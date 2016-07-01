unit uViewDailyRates;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.Generics.Collections,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.ExtCtrls, sPanel, Vcl.StdCtrls, sLabel;

type

  TDateRate = class
    ADate : TDate;
    RateExcl : Double;
    RateIncl : Double;
    Vat : Double;
    CityTax : Double;
  public
    constructor Create(_ADate : TDate;
                      _RateExcl : Double;
                      _RateIncl : Double;
                      _Vat : Double;
                      _CityTax : Double);
    function Clone : TDateRate;
  end;

  TFrmViewDailyRates = class(TForm)
    sPanel1: TsPanel;
    grDates: TAdvStringGrid;
    sPanel3: TsPanel;
    sLabel1: TsLabel;
    lblCurrency: TsLabel;
    sPanel2: TsPanel;
    lblDescriptionLeft: TsLabel;
    lblDescriptionRight: TsLabel;
    procedure FormCreate(Sender: TObject);
    procedure grDatesGetCellColor(Sender: TObject; ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure grDatesGetAlignment(Sender: TObject; ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FRoomReservation: Integer;
    FViewList : TObjectList<TDateRate>;
    FCurrency: String;
    FDescriptionLeft: String;
    FDescriptionRight: String;
    { Private declarations }
    procedure RetrieveRates;
    procedure SetRoomReservation(const Value: Integer);
    procedure GetRatesOfRoomReservation;
    procedure ShowGivenRates;
    function TotalRateExclusive: Double;
    function TotalRateInclusive: Double;
    function TotalCityTax: Double;
    function TotalVat: Double;
    function TotalRateWithCityTax: Double;
    procedure SetCurrency(const Value: String);
    procedure SetDescriptionLeft(const Value: String);
    procedure SetDescriptionRight(const Value: String);

  public
    { Public declarations }
    procedure Clear;
    function Add(DateRate : TDateRate) : Integer;
    property RoomReservation : Integer read FRoomReservation write SetRoomReservation;
    property Currency : String read FCurrency write SetCurrency;
    property DescriptionLeft : String read FDescriptionLeft write SetDescriptionLeft;
    property DescriptionRight : String read FDescriptionRight write SetDescriptionRight;
  end;

var
  FrmViewDailyRates: TFrmViewDailyRates;

procedure ShowRatesForRoomReservation(RoomReservation : Integer);
function CreateDateRate(ADate : TDate; Rate : Double; Customer : String; NumDays, NumGuest : Integer; _Currency : String) : TDateRate;


implementation

{$R *.dfm}

uses uD,
     hData,
     uDateUtils,
     _Glob,
     uAppGlobal,
     uTaxCalc,
     cmpRoomerDataSet
     ;


procedure ShowRatesForRoomReservation(RoomReservation : Integer);
var _FrmViewDailyRates: TFrmViewDailyRates;
begin
  _FrmViewDailyRates := TFrmViewDailyRates.Create(nil);
  try
    _FrmViewDailyRates.RoomReservation := RoomReservation;
    _FrmViewDailyRates.ShowModal;
  finally
    FreeAndNil(_FrmViewDailyRates);
  end;
end;

function CreateDateRate(ADate : TDate; Rate : Double; Customer : String; NumDays, NumGuest : Integer; _Currency : String) : TDateRate;
var isIncluded : Boolean;
    ItemType : String;
    VATCode : String;
    VATPercentage : Double;

    RateExcl,
    RateIncl,
    CityTax,
    CityTaxBase,
    VAT,
    CurrencyRate : Double;

    Multiply : Double;

begin
  if glb.LocateSpecificRecordAndGetValue('customers', 'Customer', Customer, 'StayTaxIncluted', isIncluded) AND
     glb.LocateSpecificRecordAndGetValue('currencies', 'Currency', _Currency, 'AValue', CurrencyRate) AND
     glb.LocateSpecificRecordAndGetValue('items', 'Item', ctrlGetString('RoomRentItem'), 'ItemType', ItemType) AND
     glb.LocateSpecificRecordAndGetValue('itemtypes', 'ItemType', ItemType, 'VATCode', VATCode) AND
     glb.LocateSpecificRecordAndGetValue('vatcodes', 'VATCode', VATCode, 'VATPercentage', VATPercentage) then
  begin
    isIncluded := isStayTaxIncluded OR (isStayTaxPerCustomer AND isIncluded);
    RateExcl := Rate / (1 + (VATPercentage / 100));
    VAT := Rate - RateExcl;
    RateIncl := Rate;
    if isStayTaxPercentage then
    begin
      CityTaxBase := RateIncl;
      if isStayTaxNettoBased then
        CityTaxBase := RateExcl;
      CityTax := CityTaxBase * stayTaxAmount / 100;
    end else
      CityTax := stayTaxAmount;

    Multiply := 1;
    if stayTaxPerNight then
      Multiply := 1
    else
    if stayTaxPerGuest then
      Multiply := NumGuest / NumDays
    else
    if stayTaxPerGuestNight then
      Multiply := NumGuest
    else
    if stayTaxPerRoom then
      Multiply := 1 / NumDays;

    result := TDateRate.Create(ADate, RateExcl, RateIncl, VAT, CityTax * Multiply / CurrencyRate);
  end
  else
    raise Exception.Create('CreateDateRate(): Invalid parameters');
end;



function TFrmViewDailyRates.Add(DateRate: TDateRate): Integer;
begin
  Result := FViewList.Add(DateRate);
end;

procedure TFrmViewDailyRates.Clear;
begin
  FViewList.Clear;
  DescriptionLeft := '';
  DescriptionRight := '';
end;

procedure TFrmViewDailyRates.FormCreate(Sender: TObject);
begin
  FViewList := TObjectList<TDateRate>.Create;
  RoomReservation := 0;
  DescriptionLeft := '';
  DescriptionRight := '';
end;

procedure TFrmViewDailyRates.FormDestroy(Sender: TObject);
begin
  Clear;
  FreeAndNil(FViewList);
end;

procedure TFrmViewDailyRates.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TFrmViewDailyRates.FormShow(Sender: TObject);
begin
  RetrieveRates;
end;

procedure TFrmViewDailyRates.GetRatesOfRoomReservation;
var rSet : TRoomerDataSet;
    s : String;
begin
  Clear;
  rSet := CreateNewDataSet;
  try
    s := 'SELECT ADate, ' +
         'RateExcl, ' +
         'RateIncl - RateExcl AS VAT, ' +
         'RateIncl, ' +
         'CityTaxInCl, ' +
         'NumNights, ' +
         'NumGuests, ' +
         'IF(CityTaxIncl, 0, ' +
         '   IF(taxPercentage, taxBaseAmount * taxAmount / 100, taxAmount) * ' +
         '      IF(taxRoomNight, 1, ' +
         '         IF(taxGuestNight, NumGuests, ' +
         '            IF(taxGuestNight, NumGuests /  NumNights, ' +
         '               IF(taxBooking, 1 / NumNights, ' +
         '               1 )))) ' +
         '   ) / CurrencyRate AS CityTaxPerDay, ' +
         'taxPercentage, ' +
         'taxRetaxable, ' +
         'taxRoomNight, ' +
         'taxGuestNight, ' +
         'taxGuest, ' +
         'taxBooking, ' +
         'taxNettoAmountBased, ' +
         'Currency, ' +
         'CurrencyRate ' +
         'FROM ( ' +
         'SELECT DATE(ADate) AS ADate, ' +
         'RoomRate AS RateIncl, ' +
         'RoomRate / (1 + vc.VATPercentage/100) AS RateExcl, ' +
         'to_bool(IF(tx.INCL_EXCL=''INCLUDED'' OR ' +
         '           (tx.INCL_EXCL=''PER_CUSTOMER'' AND cu.StayTaxIncluted), 1, 0)) AS CityTaxInCl, ' +
         'tx.AMOUNT AS taxAmount, ' +
         'to_bool(IF(tx.TAX_TYPE=''FIXED_AMOUNT'', 0, 1)) AS taxPercentage, ' +
         'to_bool(IF(tx.RETAXABLE=''FALSE'', 0, 1)) AS taxRetaxable, ' +
         'to_bool(IF(tx.TAX_BASE=''ROOM_NIGHT'', 1, 0)) AS taxRoomNight, ' +
         'to_bool(IF(tx.TAX_BASE=''GUEST_NIGHT'', 1, 0)) AS taxGuestNight, ' +
         'to_bool(IF(tx.TAX_BASE=''GUEST'', 1, 0)) AS taxGuest, ' +
         'to_bool(IF(tx.TAX_BASE=''BOOKING'', 1, 0)) AS taxBooking, ' +
         'to_bool(IF(tx.NETTO_AMOUNT_BASED=''FALSE'', 0, 1)) AS taxNettoAmountBased, ' +
         'IF(tx.NETTO_AMOUNT_BASED=''FALSE'', RoomRate, RoomRate / (1 + vc.VATPercentage/100)) AS taxBaseAmount, ' +
         '(SELECT COUNT(rd1.ID) FROM roomsdate rd1 WHERE rd1.RoomReservation = rr.RoomReservation AND NOT rd1.ResFlag IN (''X'',''C'') GROUP BY rd1.RoomReservation) AS NumNights, ' +
         '(SELECT COUNT(pe.ID) FROM persons pe WHERE pe.RoomReservation = rr.RoomReservation GROUP BY pe.RoomReservation) AS NumGuests, ' +
         'cur.Currency AS Currency, ' +
         'cur.AValue AS CurrencyRate ' +
         'FROM roomsdate rd ' +
         'JOIN currencies cur ON cur.Currency=rd.Currency ' +
         'JOIN roomreservations rr ON rr.RoomReservation=rd.RoomReservation ' +
         'JOIN reservations r ON r.Reservation=rd.Reservation ' +
         'JOIN customers cu ON cu.Customer=r.Customer ' +
         'LEFT JOIN home100.TAXES tx ON HOTEL_ID=%s AND VALID_FROM<=rd.ADate AND VALID_TO>=rd.ADate ' +
         'JOIN control co ' +
         'JOIN items i ON i.Item=co.RoomRentItem ' +
         'JOIN itemtypes it ON it.ItemType=i.ItemType ' +
         'JOIN vatcodes vc ON vc.VATCode=it.VATCode ' +
         'WHERE rd.RoomReservation=%d ' +
         'AND NOT ResFlag IN (''X'',''C'') ' +
         ') xxx';
    hData.rSet_bySQL(rSet, format(s, [_db(d.roomerMainDataSet.hotelId), FRoomReservation]), false);
    rSet.First;
    if NOT rSet.Eof then
      Currency := rSet['Currency'];
    while NOT rSet.Eof do
    begin
      FViewList.Add(TDateRate.Create(rSet['ADate'], rSet['RateExcl'], rSet['RateIncl'], rSet['VAT'], rSet['CityTaxPerDay']));
      rSet.Next;
    end;
  finally
    FreeAndNil(rSet);
  end;
end;

procedure TFrmViewDailyRates.SetCurrency(const Value: String);
begin
  FCurrency := Value;
  lblCurrency.Caption := Value;
end;

procedure TFrmViewDailyRates.SetDescriptionLeft(const Value: String);
begin
  FDescriptionLeft := Value;
  lblDescriptionLeft.Caption := Value;
end;

procedure TFrmViewDailyRates.SetDescriptionRight(const Value: String);
begin
  FDescriptionRight := Value;
  lblDescriptionRight.Caption := Value;
end;

procedure TFrmViewDailyRates.SetRoomReservation(const Value: Integer);
begin
  FRoomReservation := Value;
end;

procedure TFrmViewDailyRates.grDatesGetAlignment(Sender: TObject; ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ACol > 0) OR (ARow = grDates.RowCount - 1) then
    HAlign := taRightJustify;
end;

procedure TFrmViewDailyRates.grDatesGetCellColor(Sender: TObject; ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if (ACol > 0) AND (ARow = grDates.RowCount - 1) then
  begin
    ABrush.Color := clBlue;
    AFont.Color := clWhite;
    AFont.Style := [fsBold];
  end;
end;

procedure TFrmViewDailyRates.RetrieveRates;
begin
  if FRoomReservation > 0 then
    GetRatesOfRoomReservation;
  ShowGivenRates;
end;

procedure TFrmViewDailyRates.ShowGivenRates;
var DateRate : TDateRate;
    iRow : Integer;
begin
  grDates.ColCount := 6;
  grDates.RowCount := FViewList.Count + 2;
  grDates.Cells[0, 0] := 'Date';
  grDates.Cells[1, 0] := 'Rate Excl';
  grDates.Cells[2, 0] := 'VAT';
  grDates.Cells[3, 0] := 'Rate Incl';
  grDates.Cells[4, 0] := 'City Tax';
  grDates.Cells[5, 0] := 'Rate Total';

  iRow := 0;
  for DateRate IN FViewList do
  begin
    inc(iRow);
    grDates.Cells[0, iRow] := uDateUtils.RoomerDateToString(DateRate.ADate);
    grDates.Cells[1, iRow] := trim(_floattostr(DateRate.RateExcl, 12, 2));
    grDates.Cells[2, iRow] := trim(_floattostr(DateRate.Vat, 12, 2));
    grDates.Cells[3, iRow] := trim(_floattostr(DateRate.RateIncl, 12, 2));
    grDates.Cells[4, iRow] := trim(_floattostr(DateRate.CityTax, 12, 2));
    grDates.Cells[5, iRow] := trim(_floattostr(DateRate.RateIncl + DateRate.CityTax, 12, 2));
  end;

  inc(iRow);
  grDates.Cells[0, iRow] := 'Total';
  grDates.Cells[1, iRow] := trim(_floattostr(TotalRateExclusive, 12, 2));
  grDates.Cells[2, iRow] := trim(_floattostr(TotalVat, 12, 2));
  grDates.Cells[3, iRow] := trim(_floattostr(TotalRateInclusive, 12, 2));
  grDates.Cells[4, iRow] := trim(_floattostr(TotalCityTax, 12, 2));
  grDates.Cells[5, iRow] := trim(_floattostr(TotalRateWithCityTax, 12, 2));
end;

function TFrmViewDailyRates.TotalRateExclusive : Double;
var DateRate : TDateRate;
begin
  Result := 0.0;
  for DateRate IN FViewList do
    Result := Result + DateRate.RateExcl;
end;

function TFrmViewDailyRates.TotalRateInclusive : Double;
var DateRate : TDateRate;
begin
  Result := 0.0;
  for DateRate IN FViewList do
    Result := Result + DateRate.RateIncl;
end;

function TFrmViewDailyRates.TotalVat : Double;
var DateRate : TDateRate;
begin
  Result := 0.0;
  for DateRate IN FViewList do
    Result := Result + DateRate.Vat;
end;

function TFrmViewDailyRates.TotalCityTax : Double;
var DateRate : TDateRate;
begin
  Result := 0.0;
  for DateRate IN FViewList do
    Result := Result + DateRate.CityTax;
end;

function TFrmViewDailyRates.TotalRateWithCityTax : Double;
var DateRate : TDateRate;
begin
  Result := 0.0;
  for DateRate IN FViewList do
    Result := Result + (DateRate.RateIncl + DateRate.CityTax);
end;


{ TDateRate }

function TDateRate.Clone: TDateRate;
begin
  result := TDateRate.Create(ADate, RateExcl, RateIncl, Vat, CityTax)
end;

constructor TDateRate.Create(_ADate: TDate; _RateExcl, _RateIncl, _Vat, _CityTax: Double);
begin
    ADate := _ADate;
    RateExcl := _RateExcl;
    RateIncl := _RateIncl;
    Vat := _Vat;
    CityTax := _CityTax;
end;

end.
