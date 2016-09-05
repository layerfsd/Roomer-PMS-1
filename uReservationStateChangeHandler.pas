unit uReservationStateChangeHandler;

interface

uses
    Classes
  , SysUtils
  , uReservationStatusDefinitions
  ;


type
  EInvalidReservationStateChange = class(exception);

  THandlerFunc = function: boolean of object;

  TReservationStateChangeHandler = class(TObject)
  private
    FReservation: integer;
    FRoomReservation: integer;
    FNewState : TReservationStatus;
    FOldState : TReservationStatus;

    procedure CheckChangeIsAllowed(aOldState, aNewState: TReservationStatus);
    function CheckinRoom: boolean;
    function CheckinGroup: boolean;
    function DispatchRoomChangeHandler(aOldState, aNewState: TReservationStatus): THandlerFunc;
    function DispatchReservationChangeHandler(aOldState, aNewState: TReservationStatus): THandlerFunc;
    function CatchallRoom: boolean;
    function CatchallGroup: boolean;
  public
    constructor Create(aReservation, aRoomReservation: integer);
    function ChangeStateReservation(aNewState: TReservationStatus): boolean; overload;
    function ChangeStateRoom(aNewState: TReservationStatus): boolean; overload;
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
  ;

{ TReservationStateChangeHandler }

procedure TReservationStateChangeHandler.CheckChangeIsAllowed(aOldState, aNewState: TReservationStatus);
begin
  if (aOldState = rsBlocked) and (aNewState = rsGuests) then
    raise EInvalidReservationStateChange.CreateFmt('Reservationstatus cannot be changed from [%s] to [%s]', [aOldState.AsReadableString, aNewState.AsReadableString]);
end;

function TReservationStateChangeHandler.ChangeStateReservation(aNewState: TReservationStatus): boolean;
var
  lExecuteChangeFunc: THandlerFunc;
begin
  result := false;
  FNewState := aNewState;
  FOldState := TReservationStatus.FromResStatus( d.RR_GetStatus(FRoomReservation));
  CheckChangeIsAllowed(FOldState, rsGuests);

  lExecuteChangeFunc := DispatchReservationChangeHandler(FOldState, aNewState);
  if Assigned(lExecuteChangeFunc) then
    Result := lExecuteChangeFunc();

  end;

function TReservationStateChangeHandler.ChangeStateRoom(aNewState: TReservationStatus): boolean;
var
  lExecuteChangeFunc: THandlerFunc;
begin
  result := false;
  FNewState := aNewState;
  FOldState := TReservationStatus.FromResStatus( d.RR_GetStatus(FRoomReservation));
  CheckChangeIsAllowed(FOldState, rsGuests);

  lExecuteChangeFunc := DispatchRoomChangeHandler(FOldState, aNewState);
  if Assigned(lExecuteChangeFunc) then
    Result := lExecuteChangeFunc();

end;

function TReservationStateChangeHandler.CheckinGroup: boolean;
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

function TReservationStateChangeHandler.CheckinRoom: boolean;
var
  lRoom: string;
begin
  Result := false;
  lRoom := d.RR_GetRoomNr(FRoomReservation);
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

constructor TReservationStateChangeHandler.Create(aReservation, aRoomReservation: integer);
begin
  FReservation := aReservation;
  FRoomReservation := aRoomReservation;
end;

function TReservationStateChangeHandler.CatchallGroup: boolean;
begin

end;

function TReservationStateChangeHandler.CatchallRoom: boolean;
begin
  d.UpdateStatusSimple(FReservation, FRoomReservation, FNewState.AsStatusChar);
  Result := TRUE;
end;

function TReservationStateChangeHandler.DispatchReservationChangeHandler(aOldState,
  aNewState: TReservationStatus): THandlerFunc;
begin
  Result := nil;
  case aNewState of
    rsGuests: Result := CheckinGroup
  else
    Result := CatchallGroup;
  end;
end;

function TReservationStateChangeHandler.DispatchRoomChangeHandler(aOldState, aNewState: TReservationStatus): THandlerFunc;
begin
  Result := nil;
  case aNewState of
    rsGuests: Result := CheckinRoom
  else
    Result := CatchallRoom;
  end;

end;

end.
