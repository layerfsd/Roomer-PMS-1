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
    function Checkin: boolean; virtual;
    function CheckOut: boolean; virtual;
    function DispatchChangeHandler(aOldState, aNewState: TReservationState): THandlerFunc; virtual;
    function CatchAll: boolean; virtual;
    function GetReservationState: TReservationState; virtual;
    procedure UpdateCurrentState; virtual; abstract;
  public
    constructor Create;

    function ChangeIsAllowed(aNewState: TReservationState): boolean;
    function ChangeState(aNewState: TReservationState): boolean; virtual;
    property CurrentState: TReservationState read GetReservationState;
  end;

  TRoomReservationStateChangeHandler = class(TBaseReservationStateChangeHandler)
  protected
    FRoomReservation: integer;
    function Checkin: boolean; override;
    function CheckOut: boolean; override;
    function CatchAll: boolean; override;
    procedure UpdateCurrentState; override;
  public
    constructor Create(aReservation, aRoomReservation: integer); overload;
    constructor Create(aReservation, aRoomReservation: integer; aCurrentState: TReservationState); overload;
  end;

  TReservationStateChangeHandler = class(TBaseReservationStateChangeHandler)
  private
    FRoomStateChangers: TObjectDictionary<integer, TRoomReservationStateChangeHandler>;
    function GetRoomstateChangeHandler(aRoomRes: integer): TRoomReservationStateChangeHandler;
  protected

    function Checkin: boolean; override;
    function CatchAll: boolean; override;
    procedure UpdateCurrentState; override;
  public
    constructor Create(aReservation: integer); reintroduce;
    destructor Destroy; override;
    procedure AddRoomStateChangeHandler(aHandler: TRoomReservationStateChangeHandler);
    procedure Clear;
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
  lCurrentState := CurrentState;
  Result := (aNewState <> lCurrentState); // dont allow changing to same status
  if Result then
    case aNewState of
      rsUnKnown:          Result := false;
      rsReservation:      Result := lCurrentState in [rsUnknown, rsGuests, rsAllotment, rsOptionalBooking, rsTmp1, rsAwaitingPayment, rsCancelled, rsAwaitingPayConfirm, rsWaitingList];
      rsGuests:           Result := lCurrentState in [rsUnknown, rsReservation, rsAllotment, rsOptionalBooking, rsTmp1, rsAwaitingPayment, rsWaitingList];
      rsDeparted:         Result := lCurrentState in [rsUnknown, rsGuests];
      rsOptionalBooking:  Result := lCurrentState in [rsUnknown, rsReservation, rsAllotment, rsTmp1, rsAwaitingPayment, rsWaitingList];
      rsAllotment:        Result := lCurrentState in [rsUnknown, rsReservation, rsAllotment, rsOptionalBooking, rsTmp1, rsAwaitingPayment, rsWaitingList];
      rsNoShow:           Result := lCurrentState in [rsUnknown, rsReservation, rsAllotment, rsOptionalBooking, rsTmp1, rsAwaitingPayment, rsWaitinglist];
      rsBlocked:          Result := False;
      rsCancelled:        Result := lCurrentState in [rsUnknown, rsReservation, rsAllotment, rsOptionalBooking, rsTmp1, rsWaitinglist];
      rsTmp1:             Result := False;
      rsAwaitingPayment:  Result := False;
      rsAwaitingPayConfirm: Result := False;
      rsWaitingList:      Result := lCurrentState in [rsUnknown, rsReservation, rsGuests, rsAllotment, rsOptionalBooking, rsTmp1, rsAwaitingPayment, rsAwaitingPayConfirm];
      rsMixed:            Result := False;
    end;
end;

function TBaseReservationStateChangeHandler.CatchAll: boolean;
begin
  Result := false;
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

  fCurrentStateDirty := Result;
end;

function TBaseReservationStateChangeHandler.Checkin: boolean;
begin
  Result := False;
end;

function TBaseReservationStateChangeHandler.CheckOut: boolean;
begin
  Result := False;
end;

constructor TBaseReservationStateChangeHandler.Create;
begin
  FCurrentStateDirty := True;
end;

function TReservationStateChangeHandler.Checkin: boolean;
var
  lstRoomReservations: TStringList;
  lstRoomReservationsStatus: TStringList;
  lReservationCount: integer;
  i: integer;
  lRoom: string;
  lRoomRes: integer;
begin
  Result := false;
  lstRoomReservations := TStringList.Create;
  lstRoomReservationsStatus := TStringList.Create;
  try
    lReservationCount := GetReservationRRList(FReservation, lstRoomReservations, lstRoomReservationsStatus);

    if lReservationCount < 1 then
      Result := true
    else
    begin

      ShowAlertsForReservation(FReservation, 0, atCHECK_IN);

      lRoom := d.RR_GetRoomNr(StrToInt(lstRoomReservations[0]));
      if (MessageDlg(Format(GetTranslatedText('shCheckInGroupOfRoom'), [lRoom]), mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
      begin
        for i := 0 to lReservationCount - 1 do
        begin
          if UpperCase(lstRoomReservationsStatus[i]) = rsReservation.AsStatusChar then
          begin
            lRoomres := StrToInt(lstRoomReservations[i]);
            ShowAlertsForReservation(0, lRoomRes, atCHECK_IN);
            d.CheckInGuest(lRoomRes);
          end;
        end;
        Result := True;
      end;
    end;
  finally
    lstRoomReservations.Free;
    lstRoomReservationsStatus.Free;
  end;

end;

procedure TReservationStateChangeHandler.Clear;
begin
  FRoomStateChangers.Clear;
end;

constructor TReservationStateChangeHandler.Create(aReservation: integer);
begin
  inherited Create;
  FReservation := aReservation;
  FRoomStateChangers:= TObjectDictionary<integer, TRoomReservationStateChangeHandler>.Create([doOwnsValues]);
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

function TReservationStateChangeHandler.GetRoomstateChangeHandler(aRoomRes: Integer): TRoomReservationStateChangeHandler;
begin
  Result := FRoomStateChangers.Items[aRoomRes];
end;

function TRoomReservationStateChangeHandler.Checkin: boolean;
var
  lRoom: string;
begin
  Result := false;
  // Allocate room if needed
  lRoom := d.RR_GetRoomNr(FRoomReservation);
  if lRoom.StartsWith('<') then
    lRoom := ProvideARoom2(FRoomReservation);

  if lRoom = '' then
    Exit;

  // warn dirty room
  if g.qWarnCheckInDirtyRoom AND g.oRooms.Room[lRoom].IsDirty then
    if MessageDlg(Format(GetTranslatedText('shTx_Various_RoomNotClean'), [lRoom]), mtWarning, [mbYes, mbCancel], 0) <> mrYes then
      exit;
  
  if ctrlGetBoolean('CheckinWithDetailsDialog') OR
    (MessageDlg(Format(GetTranslatedText('shCheckRoom'), [lRoom]), mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
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
var
  lRoom: string;
begin
  Result := false;
  lRoom := d.RR_GetRoomNr(FRoomReservation);
  if ctrlGetBoolean('CheckOutWithPaymentsDialog') OR
    (MessageDlg(Format(GetTranslatedText('shCheckOutSelectedRoom'), [lRoom]), mtConfirmation, [mbYes, mbNo], 0) = mrYes)
  then
  begin
    ShowAlertsForReservation(FReservation, FRoomReservation, atCHECK_OUT);
    if ctrlGetBoolean('CheckOutWithPaymentsDialog') then
      CheckoutGuestNoDialog(FReservation, FRoomReservation, lRoom)
    else
      d.CheckOutGuest(FRoomReservation, lRoom);
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
begin
  Result := inherited;
end;

function TRoomreservationStateChangeHandler.Catchall: boolean;
begin
  inherited;
  d.UpdateStatusSimple(FReservation, FRoomReservation, FNewState.AsStatusChar);
  Result := True;
end;



end.
