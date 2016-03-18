unit uAvailabilityPerDay;

interface

uses
    SysUtils
  , Classes
  , system.UITypes
  , ADODB
  , DB
  , _Glob
  , hData
  , objNewReservation
  , uUtils
  , cmpRoomerDataSet
  , uD
  , uSqlDefinitions
  ;

type
  TAvailabilityPerDay = Class
  private
    FRoomTypes : TStrings;
    oNewReservation : TNewReservation;
    rSetAvail : TRoomerDataset;
    ArrivalDate,
    CheckOutDate : TDate;

    procedure CollectTypes;
    function NumRoomsOfType(sType: String): Integer;
    procedure LoadData;
  public
    constructor Create(_ArrivalDate, _CheckOutDate : TDate; _NewReservation : TNewReservation);
    function RoomTypeOverbooking(sType: String; NumRoomsToAdd: Integer): Boolean;
    function Overbookings: TStrings;
  End;

function IsAvailabilityThere(RoomType : String; arrival, departure : TDate) : Boolean;

implementation

uses uG, PrjConst, Dialogs;

function IsAvailabilityThere(RoomType : String; arrival, departure : TDate) : Boolean;
var s : String;
    AvailabilityPerDay : TAvailabilityPerDay;
begin
  result := True;
  s := '';
  AvailabilityPerDay := TAvailabilityPerDay.Create(arrival, departure, nil);
  try
    if AvailabilityPerDay.RoomTypeOverbooking(RoomType, 1) then
    begin
      s := getTranslatedText('shTx_Various_WouldCreateOverbooking') +
           RoomType + #10#10 +
           getTranslatedText('shTx_Various_AreYoySureYouWantToContinue');
      if MessageDlg(s, mtWarning, [mbYes, mbCancel], 0) <> mrYes then
        result := False;
    end;
  finally
    FreeAndNil(AvailabilityPerDay);
  end;
end;

procedure TAvailabilityPerDay.CollectTypes;
var i : Integer;
begin
  FRoomTypes := TStringList.Create;
  for i := 0 to oNewReservation.newRoomReservations.RoomCount - 1 do
    if FRoomTypes.IndexOf(AnsiLowerCase(oNewReservation.newRoomReservations.RoomItemsList[i].FRoomType)) <= 0 then
      FRoomTypes.Add(AnsiLowerCase(oNewReservation.newRoomReservations.RoomItemsList[i].FRoomType));
end;

constructor TAvailabilityPerDay.Create(_ArrivalDate, _CheckOutDate: TDate; _NewReservation : TNewReservation);
begin
  inherited Create;
  ArrivalDate := _ArrivalDate;
  CheckOutDate := _CheckOutDate;
  oNewReservation := _NewReservation;

  LoadData;
end;

procedure TAvailabilityPerDay.LoadData;
begin
  rSetAvail := CreateNewDataSet;
  if rSet_bySQL(rSetAvail, GetRoomTypeAvailabilitySql(ArrivalDate, CheckOutDate-1)) then
  begin
    if Assigned(oNewReservation) then
      CollectTypes;
  end;
end;

function TAvailabilityPerDay.NumRoomsOfType(sType : String) : Integer;
var i : Integer;
    LowerType : String;
begin
  result := 0;
  LowerType := AnsiLowerCase(sType);
  for i := 0 to oNewReservation.newRoomReservations.RoomCount - 1 do
    if AnsiLowerCase(oNewReservation.newRoomReservations.RoomItemsList[i].FRoomType) = LowerType then
      inc(result);
end;

function TAvailabilityPerDay.Overbookings : TStrings;
var iNum : Integer;
    LowerType : String;
    i : Integer;
begin
  result := TStringlist.Create;
  for i := 0 to FRoomTypes.Count - 1 do
  begin
    LowerType := AnsiLowerCase(FRoomTypes[i]);
    iNum := NumRoomsOfType(LowerType);
    rSetAvail.Filter := format('(RoomType=%s)', [_db(LowerType)]);
    rSetAvail.Filtered := True;
    try
      if (rSetAvail['NumAvailable'] - iNum) < 0 then
        result.Add(AnsiUpperCase(LowerType));
    finally
      rSetAvail.Filtered := False;
    end;
  end;
end;

function TAvailabilityPerDay.RoomTypeOverbooking(sType : String; NumRoomsToAdd : Integer) : Boolean;
var iNum : Integer;
    LowerType : String;
begin
  result := False;
  LowerType := AnsiLowerCase(sType);
  rSetAvail.Filter := format('(RoomType=%s)', [_db(LowerType)]);
  rSetAvail.Filtered := True;
  try
    result :=  (rSetAvail['NumAvailable'] - NumRoomsToAdd) < 0;
  finally
    rSetAvail.Filtered := False;
  end;
end;

end.
