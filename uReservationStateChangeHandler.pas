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

    function Checkin: boolean; virtual;
    function CheckOut: boolean; virtual;
    function DispatchChangeHandler(aOldState, aNewState: TReservationState): THandlerFunc; virtual;
    function CatchAll: boolean; virtual;
    function GetReservationState: TReservationState; virtual; abstract;
  public
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
    function GetReservationState: TReservationState; override;
  public
    constructor Create(aReservation, aRoomReservation: integer);
  end;

  TReservationStateChangeHandler = class(TBaseReservationStateChangeHandler)
  private
    FRoomStateChangers: TObjectDictionary<integer, TRoomReservationStateChangeHandler>;
    function GetRoomstateChangeHandler(aRoomRes: integer): TRoomReservationStateChangeHandler;
  protected

    function Checkin: boolean; override;
    function CatchAll: boolean; override;
    function GetReservationState: TReservationState; override;
  public
    constructor Create(aReservation: integer);
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
      rsUnKnown:      Result := false;
      rsReservation:  Result := lCurrentState in [rsUnknown, rsGuests, rsAlotment, rsOptionalBooking, rsTmp1, rsAwaitingPayment, rsAwaitingPayConfirm];
      rsGuests:       Result := lCurrentState in [rsUnknown, rsReservation, rsAlotment, rsOptionalBooking, rsTmp1, rsAwaitingPayment];
      rsDeparted:     Result := lCurrentState in [rsUnknown, rsGuests];
      rsReserved:     Result := lCurrentState in [rsUnknown, rsReservation, rsAlotment, rsOptionalBooking, rsTmp1, rsAwaitingPayment];
      rsOptionalBooking:   Result := lCurrentState in [rsUnknown, rsReservation, rsAlotment, rsReserved, rsTmp1, rsAwaitingPayment];
      rsAlotment:     Result := lCurrentState in [rsUnknown, rsReservation, rsAlotment, rsOptionalBooking, rsTmp1, rsAwaitingPayment];
      rsNoShow:       Result := lCurrentState in [rsUnknown, rsReservation, rsAlotment, rsOptionalBooking, rsTmp1, rsAwaitingPayment];
      rsBlocked:      Result := False;
      rsCancelled: ;
      rsTmp1: ;
      rsAwaitingPayment: ;
      rsDeleted: ;
      rsAwaitingPayConfirm: ;
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

end;

function TBaseReservationStateChangeHandler.Checkin: boolean;
begin
  Result := False;
end;

function TBaseReservationStateChangeHandler.CheckOut: boolean;
begin
  Result := False;
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
  FReservation := aReservation;
  FRoomStateChangers:= TObjectDictionary<integer, TRoomReservationStateChangeHandler>.Create([doOwnsValues]);
end;

destructor TReservationStateChangeHandler.Destroy;
begin
  FRoomStateChangers.Free;
  inherited;
end;

function TReservationStateChangeHandler.GetReservationState: TReservationState;
var
  lRoomHandler: TRoomReservationStateChangeHandler;
begin
  Result := rsUnKnown;
  for lRoomHandler in FRoomStateChangers.Values do
    if (Result = rsUnKnown) then
      Result := lRoomhandler.CurrentState
    else if (lRoomhandler.CurrentState <> result) then
    begin
      Result := rsMixed;
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

constructor TRoomReservationStateChangeHandler.Create(aReservation, aRoomReservation: integer);
begin
  FReservation := aReservation;
  FRoomReservation := aRoomReservation;
end;

function TRoomReservationStateChangeHandler.GetReservationState: TReservationState;
begin
  Result := TReservationState.FromResStatus( d.RR_GetStatus(FRoomReservation));
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
