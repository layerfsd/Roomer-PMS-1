unit uAlerts;

interface

uses Generics.Collections,
     Classes,
     SysUtils,
     uDateUtils,
     uStringUtils,
     cmpRoomerDataset;

type

  TAlertType = (atUNKNOWN, atCHECK_IN, atCHECK_OUT, atOPEN_RESERVATION, atTIME);

  TAlert = class
  private
    FAlertMomentType: TAlertType;
    FAlertText: String;
    FAlertMoment: TDateTime;
    FRoomReservation: Integer;
    FAlertRepeatDaily: Boolean;
    FID: Integer;
    FEdited : Boolean;
    FReservation: Integer;
    procedure SetAlertMoment(const Value: TDateTime);
    procedure SetAlertMomentType(const Value: TAlertType);
    procedure SetAlertRepeatDaily(const Value: Boolean);
    procedure SetAlertText(const Value: String);
    procedure SetRoomReservation(const Value: Integer);
    procedure SetReservation(const Value: Integer);
  public
    constructor Create(_ID : Integer;
                       _Reservation : Integer;
                       _RoomReservation : Integer;
                       _AlertMomentType : TAlertType;
                       _AlertMoment : TDateTime;
                       _AlertText : String;
                       _AlertRepeatDaily : Boolean);

    procedure postChanges;
    procedure Delete;

    property ID : Integer read FID write FID;
    property Reservation : Integer read FReservation write SetReservation;
    property RoomReservation : Integer read FRoomReservation write SetRoomReservation;
    property AlertMomentType : TAlertType read FAlertMomentType write SetAlertMomentType;
    property AlertMoment : TDateTime read FAlertMoment write SetAlertMoment;
    property AlertText : String read FAlertText write SetAlertText;
    property AlertRepeatDaily : Boolean read FAlertRepeatDaily write SetAlertRepeatDaily;
  end;

  TAlertList = class
    FList : TList<TAlert>;
  private
    FReservation: Integer;
    FRoomReservation: Integer;
    function GetCount: Integer;
    procedure SetRoomReservation(const Value: Integer);
    procedure SetReservation(const Value: Integer);
  public
    constructor Create(_Reservation : Integer; _RoomReservation : Integer; AlertType : TAlertType);
    destructor Destroy;

    procedure postChanges;
    function Add(Alert : TAlert) : Integer;

    function CreateEmptyAlert : TAlert;

    function CountByType(AlertType : TAlertType) : Integer;
    function AlertByTypeAndIndex(AlertType : TAlertType; Index : Integer) : TAlert;

    property Count : Integer read GetCount;
    property Reservation : Integer read FReservation write SetReservation;
    property RoomReservation : Integer read FRoomReservation write SetRoomReservation;
    property Alerts : TList<TAlert> read FList;
  end;

function ReadAlertsForRoomReservation(Reservation: Integer; RoomReservation: Integer; AlertType : TAlertType) : TAlertList;
function AlertTypeToDescriptiveString(AlertType : TAlertType) : String;
procedure ShowAlerts(AlertList : TAlertList);
procedure ShowAlertsForReservation(Reservation, RoomReservation : Integer; AlertType : TAlertType);

implementation

uses uD, hData, _Glob, Dialogs, uFrmAlertDialog;

function ReadAlertsForRoomReservation(Reservation: Integer; RoomReservation: Integer; AlertType : TAlertType) : TAlertList;
begin
  result := TAlertList.Create(Reservation, RoomReservation, AlertType);
end;

procedure ShowAlerts(AlertList : TAlertList);
var i: Integer;
begin
  for i := 0 to AlertList.Count - 1 do
    ShowAlert(AlertList.Alerts[i]);
end;

procedure ShowAlertsForReservation(Reservation, RoomReservation : Integer; AlertType : TAlertType);
var AlertList : TAlertList;
begin
  AlertList := ReadAlertsForRoomReservation(Reservation, RoomReservation, AlertType);
  ShowAlerts(AlertList);
end;

//////

function BooleanToString(bool : Boolean) : String;
begin
  case bool of
    true : result := 'TRUE';
    false : result := 'FALSE';
  end;
end;

function StringToBoolean(bool : String) : Boolean;
begin
  result := bool = 'TRUE';
end;

function AlertTypeToDescriptiveString(AlertType : TAlertType) : String;
begin
  case AlertType of
    atUNKNOWN: result := 'UNKNOWN';
    atCHECK_IN: result := 'CHECK IN';
    atCHECK_OUT: result := 'CHECK OUT';
    atOPEN_RESERVATION: result := 'OPEN RESERVATION';
    atTIME: result := 'TIME';
  end;
end;

function AlertTypeToString(AlertType : TAlertType) : String;
begin
  case AlertType of
    atUNKNOWN: result := 'UNKNOWN';
    atCHECK_IN: result := 'CHECK_IN';
    atCHECK_OUT: result := 'CHECK_OUT';
    atOPEN_RESERVATION: result := 'OPEN_RESERVATION';
    atTIME: result := 'TIME';
  end;
end;

function StringToAlertType(AlertType : String) : TAlertType;
begin
  if AlertType = 'UNKNOWN' then result := atUNKNOWN else
  if AlertType = 'CHECK_IN' then result := atCHECK_IN else
  if AlertType = 'CHECK_OUT' then result := atCHECK_OUT else
  if AlertType = 'OPEN_RESERVATION' then result := atOPEN_RESERVATION else
  if AlertType = 'TIME' then result := atTIME;
end;

{ TAlert }

constructor TAlert.Create(_ID : Integer;
                          _Reservation : Integer;
                          _RoomReservation : Integer;
                          _AlertMomentType : TAlertType;
                          _AlertMoment : TDateTime;
                          _AlertText : String;
                          _AlertRepeatDaily : Boolean);
begin
  FID := _ID;
  FAlertMomentType := _AlertMomentType;
  FAlertText := _AlertText;
  FAlertMoment := _AlertMoment;
  FReservation := _Reservation;
  FRoomReservation := _RoomReservation;
  FAlertRepeatDaily := _AlertRepeatDaily;

  FEdited := False;
end;

procedure TAlert.Delete;
begin
  if FID > 0 then
    d.roomerMainDataSet.DoCommand(format('DELETE FROM home100.HOTEL_RESERVATION_ALERTS WHERE ID=%d', [FID]))
end;

procedure TAlert.postChanges;
var sql : String;
    rSet : TRoomerDataSet;
begin
  sql := '';
  if FID = 0 then
  begin
    sql := 'INSERT INTO home100.HOTEL_RESERVATION_ALERTS ' +
           '(HOTEL_ID, RESERVATION, ROOM_RESERVATION, ALERT_MOMENT_TYPE, ALERT_MOMENT, ALERT_TEXT, ALERT_REPEAT_DAILY) ' +
           'VALUES (%s, %d, %d, %s, %s, %s, %s)';
    sql := format(sql, [_db(d.roomerMainDataSet.hotelId), FReservation, FRoomReservation, _db(AlertTypeToString(AlertMomentType)),
                        _db(uDateUtils.DateTimeToDBString(AlertMoment)), _db(AlertText), _db(BooleanToString(AlertRepeatDaily))]);
  end else
  if FEdited then
  begin
    sql := 'UPDATE home100.HOTEL_RESERVATION_ALERTS ' +
           'SET RESERVATION=%d, ROOM_RESERVATION=%d, ALERT_MOMENT_TYPE=%s, ALERT_MOMENT=%s, ALERT_TEXT=%s, ALERT_REPEAT_DAILY=%s ' +
           'WHERE ID=%d';
    sql := format(sql, [FReservation, FRoomReservation, _db(AlertTypeToString(AlertMomentType)),
                        _db(uDateUtils.DateTimeToDBString(AlertMoment)), _db(AlertText), _db(BooleanToString(AlertRepeatDaily)), FID]);
  end;

  if sql <> '' then
  begin
    rSet := CreateNewDataSet;
    try
      cmd_bySQL(sql);
    finally
      FreeAndNil(rSet);
    end;
    FEdited := False;
  end;
end;

procedure TAlert.SetAlertMoment(const Value: TDateTime);
begin
  FAlertMoment := Value;
  FEdited := True;
end;

procedure TAlert.SetAlertMomentType(const Value: TAlertType);
begin
  FAlertMomentType := Value;
  FEdited := True;
end;

procedure TAlert.SetAlertRepeatDaily(const Value: Boolean);
begin
  FAlertRepeatDaily := Value;
  FEdited := True;
end;

procedure TAlert.SetAlertText(const Value: String);
begin
  FAlertText := Value;
  FEdited := True;
end;

procedure TAlert.SetReservation(const Value: Integer);
begin
  FReservation := Value;
  FEdited := True;
end;

procedure TAlert.SetRoomReservation(const Value: Integer);
begin
  FRoomReservation := Value;
  FEdited := True;
end;

{ TAlertList }

function TAlertList.Add(Alert: TAlert): Integer;
begin
  FList.Add(Alert);
end;

function TAlertList.AlertByTypeAndIndex(AlertType: TAlertType; Index: Integer): TAlert;
var i, count: Integer;
begin
  count := -1;
  result := nil;
  for i := 0 to FList.Count - 1 do
  begin
    count := count + ABS(ORD(FList[i].FAlertMomentType = AlertType));
    if count = Index then
    begin
      result := FList[i];
    end;
  end;
end;

function TAlertList.CountByType(AlertType: TAlertType): Integer;
var i: Integer;
begin
  result := 0;
  for i := 0 to Count - 1 do
    if FList[i].FAlertMomentType = AlertType then
      inc(result);
end;

constructor TAlertList.Create(_Reservation: Integer; _RoomReservation: Integer; AlertType: TAlertType);
var sql : String;
    rSet : TRoomerDataSet;
begin
  FList := TList<TAlert>.Create;

  FReservation := _Reservation;
  FRoomReservation := _RoomReservation;
  if (_RoomReservation <> 0) OR (_Reservation <> 0) then
  begin
    sql := 'SELECT * FROM home100.HOTEL_RESERVATION_ALERTS WHERE HOTEL_ID=%s AND ((ROOM_RESERVATION=%d AND ROOM_RESERVATION<>0) OR (RESERVATION=%d AND RESERVATION<>0)) %s';
    if AlertType = atUNKNOWN then
      sql := format(sql, [_db(d.roomerMainDataSet.hotelId), _RoomReservation, _Reservation, ''])
    else
      sql := format(sql, [_db(d.roomerMainDataSet.hotelId), _RoomReservation, _Reservation, 'AND ALERT_MOMENT_TYPE=' + _db(AlertTypeToString(AlertType))]);

    rSet := CreateNewDataSet;
    try
      if rSet_bySQL(rSet, sql, False) then
      begin
        rSet.First;
        while NOT rSet.Eof do
        begin
          FList.Add(TAlert.Create(rSet['ID'],
                                 _Reservation,
                                 _RoomReservation,
                                 StringToAlertType(rSet['ALERT_MOMENT_TYPE']),
                                 rSet['ALERT_MOMENT'],
                                 rSet['ALERT_TEXT'],
                                 StringToBoolean(rSet['ALERT_REPEAT_DAILY'])));
          rSet.Next;
        end;
      end;
    finally
      FreeAndNil(rSet);
    end;
  end;
end;

function TAlertList.CreateEmptyAlert: TAlert;
begin
  result := TAlert.Create(0,
                       Reservation,
                       RoomReservation,
                       atUNKNOWN,
                       0.00,
                       '',
                       False);
end;

destructor TAlertList.Destroy;
begin
  FList.Clear;
  FList.Free;
end;

function TAlertList.GetCount: Integer;
begin
  result := FList.Count;
end;

procedure TAlertList.postChanges;
var i: Integer;
begin
  for i := 0 to Count - 1 do
    FList[i].PostChanges;
end;

procedure TAlertList.SetReservation(const Value: Integer);
var i: Integer;
begin
  FReservation := Value;
  for i := 0 to Count - 1 do
    FList[i].Reservation := FReservation;
end;

procedure TAlertList.SetRoomReservation(const Value: Integer);
var i: Integer;
begin
  FRoomReservation := Value;
  for i := 0 to Count - 1 do
    FList[i].RoomReservation := FRoomReservation;
end;

end.
