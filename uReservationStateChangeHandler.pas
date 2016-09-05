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

  TBaseReservationStateChangeHandler = class abstract(TObject)
  private
  protected
    FReservation: integer;
    FNewState : TReservationStatus;

    function Checkin: boolean; virtual; abstract;
    function DispatchChangeHandler(aOldState, aNewState: TReservationStatus): THandlerFunc; virtual;
    function CatchAll: boolean; virtual;
    function GetReservationStatus: TReservationStatus; virtual; abstract;
  public
    function ChangeIsAllowed(aNewState: TReservationStatus): boolean;
    function ChangeState(aNewState: TReservationStatus): boolean; virtual;
    property CurrentState: TReservationStatus read GetReservationStatus;
  end;

  TReservationStateChangeHandler = class(TBaseReservationStateChangeHandler)
  protected

    function Checkin: boolean; override;
    function CatchAll: boolean; override;
    function GetReservationStatus: TReservationStatus; override;
  public
    constructor Create(aReservation: integer);
  end;


  TRoomReservationStateChangeHandler = class(TBaseReservationStateChangeHandler)
  protected
    FRoomReservation: integer;

    function Checkin: boolean; override;
    function CatchAll: boolean; override;
    function GetReservationStatus: TReservationStatus; override;
  public
    constructor Create(aReservation, aRoomReservation: integer); reintroduce;
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

function TBaseReservationStateChangeHandler.ChangeIsAllowed(aNewState: TReservationStatus): boolean;
begin
  Result := True;
  case CurrentState of
    rsUnKnown: ;
    rsReservation: ;
    rsGuests:       Result := (aNewState <> rsGuests);
    rsDeparted: ;
    rsReserved: ;
    rsOverbooked: ;
    rsAlotment: ;
    rsNoShow: ;
    rsBlocked:     Result := (aNewState <> rsGuests);
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

function TBaseReservationStateChangeHandler.ChangeState(aNewState: TReservationStatus): boolean;
var
  lExecuteChangeFunc: THandlerFunc;
  lOldState: TReservationStatus;
begin
  result := false;
  FNewState := aNewState;
  lOldState := CurrentState;
  if not ChangeIsAllowed(rsGuests) then
    raise EInvalidReservationStateChange.CreateFmt('Reservationstatus cannot be changed from [%s] to [%s]', [lOldState.AsReadableString, aNewState.AsReadableString]);

  lExecuteChangeFunc := DispatchChangeHandler(lOldState, aNewState);
  if Assigned(lExecuteChangeFunc) then
    Result := lExecuteChangeFunc();

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

constructor TReservationStateChangeHandler.Create(aReservation: integer);
begin
  FReservation := aReservation;
end;

function TReservationStateChangeHandler.GetReservationStatus: TReservationStatus;
begin
  //TODO
  Result := rsUnkown;
end;

function TRoomReservationStateChangeHandler.Checkin: boolean;
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

constructor TRoomReservationStateChangeHandler.Create(aReservation, aRoomReservation: integer);
begin
  FReservation := aReservation;
  FRoomReservation := aRoomReservation;
end;

function TRoomReservationStateChangeHandler.GetReservationStatus: TReservationStatus;
begin
  Result := TReservationStatus.FromResStatus( d.RR_GetStatus(FRoomReservation));
end;

function TBaseReservationStateChangeHandler.DispatchChangeHandler(aOldState,
  aNewState: TReservationStatus): THandlerFunc;
begin
  Result := nil;
  case aNewState of
    rsGuests: Result := Checkin;
  else
    Result := Catchall;
  end;
end;

function TReservationStateChangeHandler.Catchall: boolean;
begin
  inherited;
end;

function TRoomreservationStateChangeHandler.Catchall: boolean;
begin
  inherited;
  d.UpdateStatusSimple(FReservation, FRoomReservation, FNewState.AsStatusChar);
  Result := TRUE;
end;



end.
