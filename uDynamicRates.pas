unit uDynamicRates;

interface

uses
  cmpRoomerDataSet,
  SysUtils,
  classes
  ;

type
  TDynamicRates = class
    chRates : TRoomerDataSet;
    arrival, departure : TDate;
    channelCode, chManCode : String;
  private
    procedure Clear;
  public
    constructor Create;
    destructor Destroy;

    procedure Prepare(_arrival, _departure : TDate; _channelCode, _chManCode : String);
    function findRateByRateCode(ADate : TDate; numGuests : Integer; var roomPrice : Double; rateId : String) : Boolean;
    function findRateForRoomType(ADate: TDate; RoomType: String; numGuests: Integer; var roomPrice: Double; var rateId: String): Boolean;
    procedure GetAllRateCodes(List: TStrings);
    procedure Deactivate;
    function Active : Boolean;
    function AverageRateStay(rate : String; roomType : String; arrival, departure : TDate) : Double;
    procedure UpdateRoomReservation(RoomReservation: Integer; rate, roomType: String; arrival, departure: TDate);
  end;

implementation

uses
  uDateUtils,
  ud,
  System.Generics.Collections,
  _Glob;

function TDynamicRates.Active: Boolean;
begin
  result := assigned(chRates);
end;

function TDynamicRates.AverageRateStay(rate : String; roomType : String; arrival, departure: TDate): Double;
var numDays : Integer;
    Counter : Integer;
begin
  numDays := TRUNC(departure) - TRUNC(arrival);
  result := 0.00;
  if numDays < 1 then exit;

  if NOT assigned(chRates) then exit;

  chRates.First;
  Counter := 0;
  while NOT chRates.Eof do
  begin
    if (chRates['rateCode'] = rate) AND
//       (chRates['RoomType'] = roomType) AND
       (chRates['date'] >= arrival) AND
       (chRates['date'] < departure) then
    begin
      result := result + chRates['rate'];
      Inc(Counter);
    end;
    chRates.Next;
    if Counter >= numDays then
      Break;
  end;
  result := result / numDays;
end;

procedure TDynamicRates.UpdateRoomReservation(RoomReservation : Integer;
          rate : String;
          roomType : String;
          arrival,
          departure: TDate);
var SqlList : TList<String>;
    numDays : Integer;
    Total : Double;
    s : String;
    Counter : Integer;
begin
  numDays := TRUNC(departure) - TRUNC(arrival);
  Total := 0.00;
  if numDays < 1 then exit;

  if NOT assigned(chRates) then exit;

  SqlList := TList<String>.Create;
  try
    chRates.First;
    Counter := 0;
    while NOT chRates.Eof do
    begin
      if (chRates['rateCode'] = rate) AND
//         (chRates['RoomType'] = roomType) AND
         (chRates['date'] >= arrival) AND
         (chRates['date'] < departure) then
      begin
        Total := Total + chRates['rate'];
        s := format('UPDATE roomsdate SET RoomRate=%s WHERE ADate=%s AND RoomReservation=%d',
                    [
                      _db(chRates.FieldByName('rate').AsFloat),
                      _db(DateToSqlString(chRates['date'])),
                      RoomReservation
                    ]);
        SqlList.Add(s);
        inc(Counter);
      end;
      chRates.Next;
      if Counter >= numDays then
        Break;
    end;
    Total := Total / numDays;
    s := format('UPDATE roomreservations SET AvrageRate=%s, ratePlanCode=%s WHERE RoomReservation=%d',
                [
                  _db(Total),
                  _db(rate),
                  RoomReservation
                ]);
    SqlList.Add(s);
    d.roomerMainDataSet.SystemFreeExecuteMultiple(SqlList);
  finally
    SqlList.Free;
  end;
end;

procedure TDynamicRates.Clear;
begin
  if assigned(chRates) then
    FreeAndNil(chRates);
end;

constructor TDynamicRates.Create;
begin
  chRates := nil;
  arrival := Now;
  departure := arrival + 1;
  channelCode := '';
  chManCode := '';
end;

procedure TDynamicRates.Deactivate;
begin
  Clear;
end;

destructor TDynamicRates.Destroy;
begin
  Clear;
end;

function TDynamicRates.findRateByRateCode(ADate : TDate; numGuests : Integer; var roomPrice : Double; rateId : String) : Boolean;
var iCount : Integer;
    finalized : Boolean;
begin
  result := False;
  if NOT assigned(chRates) then exit;

  iCount := 0;
  finalized := False;
  repeat
    chRates.First;
    while NOT chRates.Eof do
    begin
      if (chRates['rateCode']=rateId) AND (trunc(chRates['date'])=ADate) then
      begin
        if (chRates['numGuests']=numGuests) OR (iCount > 0) then
        begin
          roomPrice := chRates['rate'];
          result := True;
          finalized := True;
          Break;
        end;
      end;
      chRates.Next;
    end;
    inc(iCount);
    if iCount > 1 then
      finalized := True;
  until finalized;
end;

function TDynamicRates.findRateForRoomType(ADate : TDate; RoomType : String; numGuests : Integer; var roomPrice : Double; var rateId : String) : Boolean;
var iCount : Integer;
    finalized : Boolean;
begin
  result := False;
  if NOT assigned(chRates) then exit;

  iCount := 0;
  finalized := False;
  repeat
    chRates.First;
    while NOT chRates.Eof do
    begin
      if (chRates['RoomType']=RoomType) AND (trunc(chRates['date'])=ADate) then
      begin
        if (chRates['numGuests']=numGuests) OR (iCount > 0) then
        begin
          roomPrice := chRates['rate'];
          rateId := chRates['rateCode'];
          result := True;
          finalized := True;
          Break;
        end;
      end;
      chRates.Next;
    end;
    inc(iCount);
    if iCount > 1 then
      finalized := True;
  until finalized;
end;

procedure TDynamicRates.GetAllRateCodes(List : TStrings);
var s : String;
begin
  chRates.First;
  while NOT chRates.Eof do
  begin
    s := chRates['rateCode'];
    if List.IndexOf(s) < 0 then
      List.Add(s);
    chRates.Next;
  end;
end;

procedure TDynamicRates.Prepare(_arrival, _departure: TDate; _channelCode, _chManCode: String);
var sql : String;
begin
  Clear;
  arrival := _arrival;
  departure := _departure;
  channelCode := _channelCode;
  chManCode := _chManCode;
  sql := format('bookingapi/pmsAvailability?arrival=%s&departure=%s&channelCode=%s&channelManagerCode=%s', [uDateUtils.dateToSqlString(arrival), uDateUtils.dateToSqlString(departure), channelCode, chManCode]);
  chRates := d.roomerMainDataSet.ActivateNewDataset(d.roomerMainDataSet.downloadUrlAsString(d.roomerMainDataSet.RoomerUri + sql));
end;

end.
