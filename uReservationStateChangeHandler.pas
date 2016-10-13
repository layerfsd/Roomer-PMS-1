unit uReservationStateChangeHandler;

interface

uses
    Classes
  , SysUtils
  , uReservationStateDefinitions
  , Generics.Collections
  ;


type
  EInvalidReservationStateChange = class(exception);

  THandlerFunc = function: boolean of object;

  TBaseReservationStateChangeHandler = class abstract(TObject)
  private
  protected
    FReservation: integer;
    FNewState : TReservationState;
    FCurrentState: TReservationState;
    FCurrentStateDirty: boolean;
    function Checkin: boolean; virtual; abstract;
    function CheckOut: boolean; virtual; abstract;
    function DispatchChangeHandler(aOldState, aNewState: TReservationState): THandlerFunc; virtual;
    function CatchAll: boolean; virtual; abstract;
    function GetReservationState: TReservationState; virtual;
    procedure UpdateCurrentState; virtual; abstract;
  public
    constructor Create;

    function ChangeIsAllowed(aNewState: TReservationState): boolean; virtual;
    function ChangeState(aNewState: TReservationState): boolean; virtual;
    property CurrentState: TReservationState read GetReservationState;
  end;

  TRoomReservationStateChangeHandler = class(TBaseReservationStateChangeHandler)
  protected
    FRoomReservation: integer;
    FRoom: string;
    function Checkin: boolean; override;
    function CheckOut: boolean; override;
    function CatchAll: boolean; override;
    procedure UpdateCurrentState; override;
  public
    constructor Create(aReservation, aRoomReservation: integer); overload;
    constructor Create(aReservation, aRoomReservation: integer; aCurrentState: TReservationState); overload;

    property Room: string read FRoom;
  end;

  TReservationStateChangeHandler = class(TBaseReservationStateChangeHandler)
  private
    FConfirmed : Boolean;
    FRoomStateChangers: TObjectDictionary<integer, TRoomReservationStateChangeHandler>;
    function GetRoomstateChangeHandler(aRoomRes: integer): TRoomReservationStateChangeHandler;
    procedure AddRoomResChangeSetHandlers;
  protected
    function Checkin: boolean; override;
    function CheckOut: boolean; override;
    function CatchAll: boolean; override;
    procedure UpdateCurrentState; override;
  public
    constructor Create(aReservation: integer); reintroduce;
    destructor Destroy; override;
    procedure AddRoomStateChangeHandler(aHandler: TRoomReservationStateChangeHandler);
    procedure UpdateRoomResStateChangeHandlers;
    procedure Clear;
    function ChangeState(aNewState: TReservationState): boolean; override;
    /// <summary>
    ///   For a full reservation the change is allowed if for at least one of the rooms the change is allowed
    /// </summary>
    function ChangeIsAllowed(aNewState: TReservationState): boolean; override;
    property RoomStateChangeHandler[aRoomRes: integer]: TRoomReservationStateChangeHandler read GetRoomstateChangeHandler;
  end;


implementation

uses
  uD
  , hData
  , Dialogs
  , PrjConst
  , uAlerts
  , uGuestCheckinForm
  , UITypes
  , uFrmCheckOut, uProvideARoom2, uAppGlobal, uG;

{ TReservationStateChangeHandler }

function TBaseReservationStateChangeHandler.ChangeIsAllowed(aNewState: TReservationState): boolean;
var
  lCurrentState: TReservationState;
begin
  Result := CurrentState.CanChangeTo(aNewState);
end;

function TBaseReservationStateChangeHandler.ChangeState(aNewState: TReservationState): boolean;
var
  lExecuteChangeFunc: THandlerFunc;
  lOldState: TReservationState;
begin
  result := false;
  FNewState := aNewState;
  lOldState := CurrentState;
  if not ChangeIsAllowed(aNewState) then
    raise EInvalidReservationStateChange.CreateFmt('ReservationState cannot be changed from [%s] to [%s]', [lOldState.AsReadableString, aNewState.AsReadableString]);

  lExecuteChangeFunc := DispatchChangeHandler(lOldState, aNewState);
  if Assigned(lExecuteChangeFunc) then
    Result := lExecuteChangeFunc();

  FCurrentStateDirty := Result;
end;

constructor TBaseReservationStateChangeHandler.Create;
begin
  FCurrentStateDirty := True;
end;

function TReservationStateChangeHandler.ChangeIsAllowed(aNewState: TReservationState): boolean;
var
  lRoomHandler: TRoomReservationStateChangeHandler;
begin
  // inherited; // no call to inherited!
  Result := false;
  for lRoomHandler in FRoomStateChangers.Values do
    if lRoomHandler.ChangeIsAllowed(aNewState) then
    begin
      Result := True;
      Break;
    end;
end;

function TReservationStateChangeHandler.Checkin: boolean;
var
  lRoom: string;
  lRoomHandler: TRoomReservationStateChangeHandler;
begin
  Result := false;
  if FRoomStateChangers.Count < 1 then
    Result := true
  else
  begin

    ShowAlertsForReservation(FReservation, 0, atCHECK_IN);

    lRoom := FRoomStateChangers.Values.ToArray[0].Room;
    if FConfirmed OR (MessageDlg(Format(GetTranslatedText('shCheckInGroupOfRoom'), [lRoom]), mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    begin
      FConfirmed := True;
      for lRoomHandler in FRoomStateChangers.Values do
      begin
        if lRoomHandler.ChangeIsAllowed(rsGuests) then
        begin
          ShowAlertsForReservation(0, lRoomhandler.FRoomReservation, atCHECK_IN);
          d.CheckInGuest(lRoomhandler.FRoomReservation);
          lRoomHandler.FCurrentStateDirty := True;
        end;
      end;
      Result := True;
    end;
  end;
end;

function TReservationStateChangeHandler.CheckOut: boolean;
var
  lRoom: string;
  lRoomHandler: TRoomReservationStateChangeHandler;
begin
  Result := false;
  if FRoomStateChangers.Count < 1 then
    Result := true
  else
  begin

    ShowAlertsForReservation(FReservation, 0, atCHECK_OUT);

    lRoom := FRoomStateChangers.Values.ToArray[0].Room;
    if FConfirmed OR (MessageDlg(Format(GetTranslatedText('shCheckOutGroupOfRoom'), [lRoom]), mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    begin
      FConfirmed := True;
      for lRoomHandler in FRoomStateChangers.Values do
      begin
        if lRoomHandler.ChangeIsAllowed(rsDeparted) then
        begin
          ShowAlertsForReservation(0, lRoomhandler.FRoomReservation, atCHECK_OUT);
          d.CheckOutGuest(lRoomhandler.FRoomReservation, lRoomHandler.Room);
          lRoomHandler.FCurrentStateDirty := True;
        end;
      end;
      Result := True;
    end;
  end;
end;

procedure TReservationStateChangeHandler.Clear;
begin
  FRoomStateChangers.Clear;
end;

constructor TReservationStateChangeHandler.Create(aReservation: integer);
begin
  inherited Create;
  FConfirmed := False;
  FReservation := aReservation;
  FConfirmed := False;
  FRoomStateChangers:= TObjectDictionary<integer, TRoomReservationStateChangeHandler>.Create([doOwnsValues]);
  AddRoomResChangeSetHandlers;
end;

procedure TReservationStateChangehandler.AddRoomResChangeSetHandlers;
var
  lRoomResList: TStringlist;
  lDummy: TStringlist;
  lRoomres: string;
begin
  lDummy := nil;
  lRoomResList := TStringList.Create;
  try
    GetReservationRRList(FReservation, lRoomResList, lDummy);
    for lRoomRes in lRoomResList do
      AddRoomStateChangeHandler(TRoomReservationStateChangeHandler.Create(FReservation, StrToInt(lRoomRes)));
  finally
    lRoomResList.Free;
  end;
end;

destructor TReservationStateChangeHandler.Destroy;
begin
  FRoomStateChangers.Free;
  inherited;
end;

procedure TReservationStateChangeHandler.UpdateCurrentState;
var
  lRoomHandler: TRoomReservationStateChangeHandler;
begin
  inherited;
  FCurrentState := rsUnKnown;
  for lRoomHandler in FRoomStateChangers.Values do
    if (FCurrentState = rsUnKnown) then
      FCurrentState := lRoomhandler.CurrentState
    else if (lRoomhandler.CurrentState <> FCurrentState ) then
    begin
      FCurrentState := rsMixed;
      Break;
    end;
end;

procedure TReservationStateChangeHandler.UpdateRoomResStateChangeHandlers;
begin
  FRoomStateChangers.Clear;
  AddRoomResChangeSetHandlers;
end;

function TReservationStateChangeHandler.GetRoomstateChangeHandler(aRoomRes: Integer): TRoomReservationStateChangeHandler;
begin
  Result := FRoomStateChangers.Items[aRoomRes];
end;

function TRoomReservationStateChangeHandler.Checkin: boolean;
begin
  Result := false;
  // Allocate room if needed
  if FRoom.StartsWith('<') then
    FRoom := ProvideARoom2(FRoomReservation);

  if FRoom = '' then
    Exit;

  // warn dirty room
  if g.qWarnCheckInDirtyRoom AND g.oRooms.Room[FRoom].IsDirty then
    if MessageDlg(Format(GetTranslatedText('shTx_Various_RoomNotClean'), [FRoom]), mtWarning, [mbYes, mbCancel], 0) <> mrYes then
      exit;

  if ctrlGetBoolean('CheckinWithDetailsDialog') OR
    (MessageDlg(Format(GetTranslatedText('shCheckRoom'), [FRoom]), mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    ShowAlertsForReservation(FReservation, FRoomReservation, atCHECK_IN);
    if (NOT ctrlGetBoolean('CheckinWithDetailsDialog')) OR OpenGuestCheckInForm(FRoomReservation) then
    begin
      d.CheckInGuest(FRoomReservation);
      Result := true;
    end;
  end;

end;

function TRoomReservationStateChangeHandler.CheckOut: boolean;
begin
  Result := false;
  if ctrlGetBoolean('CheckOutWithPaymentsDialog') OR
    (MessageDlg(Format(GetTranslatedText('shCheckOutSelectedRoom'), [FRoom]), mtConfirmation, [mbYes, mbNo], 0) = mrYes)
  then
  begin
    ShowAlertsForReservation(FReservation, FRoomReservation, atCHECK_OUT);
    if ctrlGetBoolean('CheckOutWithPaymentsDialog') then
      CheckoutGuestWithDialog(FReservation, FRoomReservation, FRoom)
    else
      d.CheckOutGuest(FRoomReservation, FRoom);
    Result := True;
  end;
end;

constructor TRoomReservationStateChangeHandler.Create(aReservation, aRoomReservation: integer;
  aCurrentState: TReservationState);
begin
  Create(aReservation, aRoomReservation);
  FCurrentState := aCurrentState;
  FCurrentStateDirty := False;
end;

constructor TRoomReservationStateChangeHandler.Create(aReservation, aRoomReservation: integer);
begin
  Create;
  FReservation := aReservation;
  FRoomReservation := aRoomReservation;
  FRoom := d.RR_GetRoomNr(FRoomReservation);
end;

procedure TRoomReservationStateChangeHandler.UpdateCurrentState;
begin
  inherited;
  FCurrentState := TReservationState.FromResStatus( d.RR_GetStatus(FRoomReservation));
  FCurrentStateDirty := False;
end;

function TBaseReservationStateChangeHandler.DispatchChangeHandler(aOldState,
  aNewState: TReservationState): THandlerFunc;
begin
  Result := nil;
  case aNewState of
    rsGuests:   Result := Checkin;
    rsDeparted: Result := Checkout;
  else
    Result := Catchall;
  end;
end;

function TBaseReservationStateChangeHandler.GetReservationState: TReservationState;
begin
  if FCurrentStateDirty then
    UpdateCurrentState;

  Result := FCurrentState;
end;

procedure TReservationStateChangeHandler.AddRoomStateChangeHandler(aHandler: TRoomReservationStateChangeHandler);
begin
  FRoomStateChangers.AddOrSetValue(aHandler.FRoomReservation, aHandler);
end;

function TReservationStateChangeHandler.Catchall: boolean;
var
  lRoomHandler: TRoomReservationStateChangeHandler;
  lFailedRooms: boolean;
begin
  lFailedROoms := False;
  if MessageDlg(Format(GetTranslatedtext('shChangeStateOfFullReservation'), [FReservation, FNewState.AsReadableString]), mtConfirmation, mbOKCancel, 0) = mrOK then
  begin
    for lRoomHandler in FRoomStateChangers.Values do
      if lRoomHandler.ChangeIsAllowed(FNewState) then
        lFailedRooms := not lRoomHandler.ChangeState(FNewState) or lFailedRooms
      else
        lFailedRooms := True;
  end;

  if lFailedRooms then
    MessageDlg(GetTranslatedText('shChangeStateReservationFailedSomeRooms'), mtWarning, [mbOK], 0);

  Result := True;
end;

function TRoomreservationStateChangeHandler.Catchall: boolean;
begin
  Result := False;
  if ChangeIsAllowed(FNewState) then
  begin
    d.UpdateStatusSimple(FReservation, FRoomReservation, FNewState.AsStatusChar);
    Result := True;
  end;
end;

function TReservationStateChangeHandler.ChangeState(aNewState: TReservationState): boolean;
begin
  FConfirmed := False;
  inherited;
end;

end.
