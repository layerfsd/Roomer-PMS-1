unit uRoomDatesOBJ;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  DB,
  Forms,
  Dialogs,
  Contnrs,
  ug,
  _glob,
  ud,
  hData,
  ADODB,
  kbmMemTable,
  uRoomReservationOBJ
  // , uIntList
  , cmpRoomerDataSet
  , cmpRoomerConnection
  ;

// ******************************************************************************
type

  TRoomDates = class
  private
    FFilter : string;
    FSortOn : string;
    function getCount : integer;
  public
    qMT_ : TkbmMemTable;

    constructor Create(Filter, SortOn : string);
    destructor Destroy; override;

    function getFromDB(DateFrom, dateTo : Tdate) : integer;
    function Refresh(Filter, SortOn : string) : integer;

    property Filter : string read FFilter write FFilter;

    property SortOn : string read FSortOn write FSortOn;

    property Count : integer read getCount; // read only
  end;

implementation
  uses
    uSqlDefinitions;


// ******************************************************************************
// *
// *
// *
// ------------------------------------------------------------------------------

constructor TRoomDates.Create(Filter, SortOn : string);
begin
  inherited Create;
  qMT_ := TkbmMemTable.Create(nil);
  FFilter := Filter;
  FSortOn := SortOn;

  if qMT_.Active then
    qMT_.Close;
  qMT_.FieldDefs.Clear;

  qMT_.FieldDefs.Add('rdDate', ftDate);
  qMT_.FieldDefs.Add('Room', ftWideString, 20);
  qMT_.FieldDefs.Add('RoomType', ftWideString, 20);
  qMT_.FieldDefs.Add('Reservation', ftInteger);
  qMT_.FieldDefs.Add('Channel', ftInteger);
  qMT_.FieldDefs.Add('PAymentInvoice', ftInteger);
  qMT_.FieldDefs.Add('GroupAccount', ftBoolean);
  qMT_.FieldDefs.Add('RoomReservation', ftInteger);
  qMT_.FieldDefs.Add('resFlag', ftString, 1);
  qMT_.FieldDefs.Add('isNoRoom', ftBoolean);
  qMT_.FieldDefs.Add('AscIndex', ftInteger);
  qMT_.FieldDefs.Add('DescIndex', ftInteger);
  qMT_.FieldDefs.Add('Customer', ftWideString, 30);
  qMT_.FieldDefs.Add('CustomerName', ftWideString, 60);
  qMT_.FieldDefs.Add('GuestName', ftWideString, 60);

  qMT_.FieldDefs.Add('Information', ftWideString, 512);
  qMT_.FieldDefs.Add('Fax', ftString, 20);
  qMT_.FieldDefs.Add('BookingId', ftString, 100);
  qMT_.FieldDefs.Add('Tel2', ftString, 20);
  qMT_.FieldDefs.Add('Tel1', ftString, 20);
  qMT_.FieldDefs.Add('Guestname1', ftWideString, 64);
  qMT_.FieldDefs.Add('NumGuests', ftInteger);
  qMT_.FieldDefs.Add('PMInfo', ftWideString, 512);
  qMT_.FieldDefs.Add('Price', ftFloat);
  qMT_.FieldDefs.Add('Discount', ftFloat);
  qMT_.FieldDefs.Add('Percent', ftBoolean);
  qMT_.FieldDefs.Add('ItemsOnInvoice', ftBoolean);
  qMT_.FieldDefs.Add('PriceType', ftWideString, 20);
  qMT_.FieldDefs.Add('Currency', ftWideString, 10);
  qMT_.FieldDefs.Add('RoomClass', ftWideString, 20);
  qMT_.FieldDefs.Add('OutOfOrderBlocking', ftBoolean);
  qMT_.FieldDefs.Add('BlockMove', ftBoolean);
  qMT_.FieldDefs.Add('BlockMoveReason', ftWideString, 255);
  qMT_.FieldDefs.Add('TotalNoRent', ftFloat);
  qMT_.FieldDefs.Add('TotalTaxes', ftFloat);
  qMT_.FieldDefs.Add('TotalRent', ftFloat);
  qMT_.FieldDefs.Add('Invoices', ftWideString, 100);
  qMT_.FieldDefs.Add('Guarantee', ftWideString, 20);
  qMT_.FieldDefs.Add('TotalPayment', ftFloat);
  qMT_.FieldDefs.Add('InvoiceIndex', ftInteger);
  qMT_.CreateTable;
  qMT_.Open;

  Refresh(FFilter, FSortOn); // read from database into FroomList
end;

destructor TRoomDates.Destroy;
begin
  if qMT_.Active then
    qMT_.Close;
  FreeAndNil(qMT_);
  inherited Destroy;
end;

function TRoomDates.getCount : integer;
begin
  result := qMT_.recordCount;
end;

function TRoomDates.Refresh(Filter, SortOn : string) : integer;
begin
  result := - 1;

  if Filter <> FFilter then
  begin
    if Filter > '' then
    begin
      try
        qMT_.Filter := Filter;
        qMT_.Filtered := true;
      except
      end;
    end
    else
    begin
      qMT_.Filtered := false;
    end;
  end;

  if SortOn <> FSortOn then
  begin
    if SortOn > '' then
    begin
      try
        qMT_.SortFields := SortOn;
        qMT_.Sort([]);
      except
      end;
    end;
  end;

  FFilter := Filter;
  FSortOn := SortOn;
end;

function TRoomDates.getFromDB(DateFrom, dateTo : Tdate) : integer;
var
//  s : string;
  rSet : TRoomerDataSet;
  tmpDate : TdateTime;
  tmpRoom : string;

  noRoom : boolean;
  tmpStr : string;

  rr : integer;
  lastRR : integer;

  rrOBJ : TroomReservation;

  Channel,
  ascIndex : integer;
  descIndex : integer;

  customer, customerName : string;
  GuestName : string;

  groupAccount : boolean; //ATH
  PaymentInvoice : integer;

begin
  result := 0;
  // Get all the RoomReservations
  // in the roomsDate range
  GuestName := '';

  rrOBJ := TroomReservation.Create('', 'RoomReservation');
  try
    rSet := CreateNewDataSet;

    try
      rrOBJ.getListFromDBViaDates(DateFrom, DateTo, rSet);
//      rSet.CommandType := cmdText;
//      rSet.CommandText := s;
//      rSet.open;
      if not rSet.Eof then
      begin
        result := 0;
        lastRR := - 1;
        while not rSet.Eof do
        begin
          inc(result);

          qMT_.append;
          qMT_.ClearFields;

          tmpStr := rSet.fieldbyname('Adate').AsString;
          tmpDate := _DBDateToDate(tmpStr);
          tmpDate := Int(tmpDate);

          noRoom := false;
          tmpRoom := rSet.fieldbyname('Room').AsString;
          tmpRoom := trim(tmpRoom);

          if length(tmpRoom) > 0 then
            noRoom := copy(tmpRoom, 1, 1) = '<';

          rr := rSet.fieldbyname('RoomReservation').asInteger;
          if rr <> lastRR then
          begin
            // New reservation
          end;

          groupaccount := false; //ATH
          PaymentInvoice := 0; //ATH
          rrOBJ.DateOrders(rr, tmpDate, Channel, PaymentInvoice, ascIndex, descIndex, groupAccount, customer, customerName, GuestName);

          qMT_.fieldbyname('rdDate').asDateTime := tmpDate;
          qMT_.fieldbyname('Room').AsString := tmpRoom;
          qMT_.fieldbyname('RoomType').AsString := rSet.fieldbyname('RoomType').AsString;
          qMT_.fieldbyname('Reservation').asInteger := rSet.fieldbyname('Reservation').asInteger;
          qMT_.fieldbyname('RoomReservation').asInteger := rr;
          qMT_.fieldbyname('GroupAccount').asBoolean := groupAccount;
          qMT_.fieldbyname('PaymentInvoice').asInteger := PaymentInvoice;
          qMT_.fieldbyname('Channel').asInteger := Channel;
          qMT_.fieldbyname('resFlag').AsString := rSet.fieldbyname('resFlag').AsString;
          qMT_.fieldbyname('isNoRoom').asBoolean := noRoom;
          qMT_.fieldbyname('AscIndex').asInteger := ascIndex;
          qMT_.fieldbyname('DescIndex').asInteger := descIndex;
          qMT_.fieldbyname('Customer').AsString := customer;
          qMT_.fieldbyname('CustomerName').AsString := customerName;
          qMT_.fieldbyname('GuestName').AsString := GuestName;

          qMT_.FieldByName('Information').AsWideString := rSet.fieldbyname('Information').AsWideString;
          qMT_.FieldByName('Fax').AsString := rSet.fieldbyname('Fax').asString;
          qMT_.FieldByName('BookingId').AsString := rSet.fieldbyname('BookingId').asString;
          qMT_.FieldByName('Tel2').AsString := rSet.fieldbyname('Tel2').asString;
          qMT_.FieldByName('Tel1').AsString := rSet.fieldbyname('Tel1').asString;
          qMT_.FieldByName('Guestname1').AsString := rSet.fieldbyname('MainName').asString;
          qMT_.FieldByName('NumGuests').AsInteger := rSet.fieldbyname('NumGuests').asInteger;
          qMT_.FieldByName('Percent').AsBoolean := rSet.fieldbyname('Percentage').asBoolean;
          qMT_.FieldByName('PMInfo').AsWideString := rSet.fieldbyname('PMInfo').asWideString;
          qMT_.FieldByName('Price').AsFloat := rSet.GetFloatValue(rSet.fieldbyname('Price'));
          qMT_.FieldByName('Discount').AsFloat := rSet.GetFloatValue(rSet.fieldbyname('Discount'));
          qMT_.FieldByName('ItemsOnInvoice').AsBoolean := rSet.fieldbyname('ItemsOnInvoice').asInteger <> 0;
          qMT_.FieldByName('PriceType').AsString := rSet.fieldbyname('PriceType').asString;
          qMT_.FieldByName('Currency').AsString := rSet.fieldbyname('Currency').asString;
          qMT_.FieldByName('RoomClass').AsString := rSet.fieldbyname('RoomClass').asString;
          qMT_.FieldByName('OutOfOrderBlocking').AsBoolean := rSet.fieldbyname('OutOfOrderBlocking').AsBoolean;
          qMT_.FieldByName('TotalNoRent').AsFloat := rSet.GetFloatValue(rSet.fieldbyname('TotalNoRent'));
          qMT_.FieldByName('TotalTaxes').AsFloat := rSet.GetFloatValue(rSet.fieldbyname('TotalTaxes'));
          qMT_.FieldByName('TotalRent').AsFloat := rSet.GetFloatValue(rSet.fieldbyname('TotalRent'));
          if Assigned(rSet.FindField('blockMove')) then
            qMT_.FieldByName('BlockMove').AsBoolean := rSet.fieldbyname('BlockMove').AsBoolean;
          if Assigned(rSet.FindField('blockMoveReason')) then
            qMT_.FieldByName('blockMoveReason').AsString := rSet.fieldbyname('blockMoveReason').AsString;
          qMT_.FieldByName('Invoices').AsString := rSet['Invoices'];
          qMT_.FieldByName('Guarantee').AsString := rSet['Guarantee'];
          qMT_.FieldByName('TotalPayment').AsFloat := rSet['TotalPayment'];
          qMT_.FieldByName('InvoiceIndex').AsInteger := rSet['InvoiceIndex'];
          qMT_.Post;
          rSet.Next;
          lastRR := rr;
        end;
      end;
    finally
      FreeAndNil(rSet);
    end;
  finally
    rrOBJ.Free;
  end;
end;

end.
