unit uReservationObjects;

interface

uses
    SysUtils
  , Vcl.Graphics
  , StdCtrls
  , classes
  , ADODB
  , Forms
  , Messages
  , Windows
  , dialogs
  , Controls
  , dbTables

  , hData
  , uAppGlobal
  , _glob
  , ug
  , ud
  , cmpRoomerDataSet
  , cmpRoomerConnection
  ;

type

  { A single Guest/Person }

{$M+}
  TGuestObject = class(TObject)
  private
    FPerson : integer;
    FRoomRes : integer;
    FReservation : integer;

    FGuestName : string;
    FFirstName : string;
    FSurname : string;
    FAddress1 : string;
    FAddress2 : string;
    FAddress3 : string;
    FAddress4 : string;
    FCompany : string;
    FId : string;

    FCountry : string;
    FGuestType : string;
    FInformation : string;
    FTag : integer;

  public
    constructor Create;
    destructor Destroy; override;
  published
    property Person : integer read FPerson write FPerson;
    property RoomRes : integer read FRoomRes write FRoomRes;
    property Reservation : integer read FReservation write FReservation;

    property GuestName : string read FGuestName write FGuestName;
    property FirstName : string read FFirstName write FFirstName;
    property SurName : string read FSurname write FSurname;
    property Address1 : string read FAddress1 write FAddress1;
    property Address2 : string read FAddress2 write FAddress2;
    property Address3 : string read FAddress3 write FAddress3;
    property Address4 : string read FAddress4 write FAddress4;
    property Country : string read FCountry write FCountry;
    property Company : string read FCompany write FCompany;
    property Id : string read FId write FId;
    property GuestType : string read FGuestType write FGuestType;
    property Information : string read FInformation write FInformation;
    property Tag : integer read FTag write FTag;
  end;

  { A single Room - can constist of persons rooms }

  TRoomObject = class(TObject)
  private
    FRoomRes : integer;
    FReservation : integer;

    FResStatus : TReservationStatus;

    FRoomNumber : string;
    FRRNumber : string;
    FRoomType : string;
    FRoomClass : string;
    FPriceType : string;
    FRoomStatusChar : string;

    FPaymentInvoice : integer;

    FCodedColor : integer;
    FColorId : integer;

    FCurrency : string;
    FPrice : Double;
    FDiscount : Double;
    FPercentage : Boolean;

    FArrival, FDeparture : TDate;

    FGuests : TList;

    FPMInfo : string;
    FHiddenInfo : string;

    FMeeting : integer;
    FTotalNoRent : double;
    FGroupAccount: Boolean;
    FBlockMove: Boolean;
    FOngoingRent: Double;
    FOngoingSale: Double;
    FGuarantee: String;
    FInvoices: String;
    FTotalPayments: double;
    FTotalTaxes: double;
    FOngoingTaxes: Double;
    FInvoiceIndex: Integer;

    function GetGuestCount : integer;
    function GetGuest(iIndex : integer) : TGuestObject;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    property Guests[iIndex : integer] : TGuestObject read GetGuest;

  published
    property RoomRes : integer read FRoomRes write FRoomRes;
    property Reservation : integer read FReservation write FReservation;
    property RoomNumber : string read FRoomNumber write FRoomNumber;
    property RRNumber : string read FRRNumber write FRRNumber;
    property RoomType : string read FRoomType write FRoomType;
    property RoomClass : string read FRoomClass write FRoomClass;
    property PriceType : string read FPriceType write FPriceType;
    property RoomStatusChar : string read FRoomStatusChar write FRoomStatusChar;
    property GroupAccount : Boolean read FGroupAccount write FGroupAccount;

    property CodedColor : integer read FCodedColor write FCodedColor;
    property ColorId : integer read FColorId write FColorId;


    property ResStatus : TReservationStatus read FResStatus write FResStatus;

    property Currency : string read FCurrency write FCurrency;
    property Price : Double read FPrice write FPrice;
    property Discount : Double read FDiscount write FDiscount;
    property PaymentInvoice : integer read FPaymentInvoice write FPaymentInvoice;
    property Percentage : Boolean read FPercentage write FPercentage;

    property Arrival : TDate read FArrival write FArrival;
    property Departure : TDate read FDeparture write FDeparture;

    property PMInfo : string read FPMInfo write FPMInfo;
    property HiddenInfo : string read FHiddenInfo write FHiddenInfo;

    property GuestCount : integer read GetGuestCount;
    property GuestsList : TList read FGuests write FGuests;

    property Meeting : integer read FMeeting write FMeeting;
    property TotalNoRent : double read FTotalNorent write FTotalNoRent;
    property TotalTaxes : double read FTotalTaxes write FTotalTaxes;
    property TotalPayments : double read FTotalPayments write FTotalPayments;
    property blockMove : Boolean read FBlockMove write FBlockMove;

    property OngoingSale : Double read FOngoingSale write FOngoingSale;
    property OngoingTaxes : Double read FOngoingTaxes write FOngoingTaxes;
    property OngoingRent : Double read FOngoingRent write FOngoingRent;

    property Invoices : String read FInvoices write FInvoices;
    property Guarantee : String read FGuarantee write FGuarantee;

    property InvoiceIndex : Integer read FInvoiceIndex write FInvoiceIndex;
  end;

  { A single reservation - can constist of multiple rooms }

  TSingleReservations = class(TObject)
  private
    FReservation : integer;
    FResStatus : TReservationStatus;
    FRooms : TList;

    FTel1, FTel2, FFax, FStaff, FCustomer : string;

    FInformation : string;
    FPMInfo : string;
    FHiddenInfo : string;

    FInputSource : string;
    FWebConfirmed : Boolean;

    FReservationDate : TDate;
    FArrival : TDate;
    FDeparture : TDate;

    FName : string;
    FChannel: Integer;
    FBookingReference: string;
    FOutOfOrderBlocking: Boolean;

    function GetRoomCount : integer;
    function GetRoom(iIndex : integer) : TRoomObject;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    property Rooms[iIndex : integer] : TRoomObject read GetRoom;

  published
    property name : string read FName write FName;
    property Reservation : integer read FReservation write FReservation;
    property ResStatus : TReservationStatus read FResStatus write FResStatus;
    property RoomCount : integer read GetRoomCount;
    property Channel : Integer read FChannel;

    property Staff : string read FStaff write FStaff;
    property Customer : string read FCustomer write FCustomer;

    property ReservationDate : TDate read FReservationDate write FReservationDate;
    property Arrival : TDate read FArrival write FArrival;
    property Departure : TDate read FDeparture write FDeparture;

    property InputSource : string read FInputSource write FInputSource;
    property WebConfirmed : Boolean read FWebConfirmed write FWebConfirmed;

    property Tel1 : string read FTel1 write FTel1;
    property Tel2 : string read FTel2 write FTel2;
    property Fax : string read FFax write FFax;
    property Information : string read FInformation write FInformation;
    property PMInfo : string read FPMInfo write FPMInfo;
    property HiddenInfo : string read FHiddenInfo write FHiddenInfo;
    property BookingReference : string read FBookingReference write FBookingReference;
    property OutOfOrderBlocking : Boolean read FOutOfOrderBlocking write FOutOfOrderBlocking;
  end;

  { All Reservations on a specified daterange - can constist of multiple Reservations }
  TReservationsModel = class(TObject)
  private
    FReservationStatus : TReservationStatus;
    FWebRequest : Boolean;
    FFromDate : TDate;
    FToDate : TDate;
    FReservationList : TList;

    function GetSingleReservation(iIndex : integer) : TSingleReservations;
    function GetReservationCount : integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Execute(_FromDate, _ToDate : TDate; _ReservationStatus : TReservationStatus);
    property Reservations[iIndex : integer] : TSingleReservations read GetSingleReservation;
  published
    property ReservationStatus : TReservationStatus read FReservationStatus write FReservationStatus;

    property WebRequest : Boolean read FWebRequest write FWebRequest;

    property FromDate : TDate read FFromDate write FFromDate;
    property ToDate : TDate read FToDate write FToDate;

    property ReservationList : TList read FReservationList write FReservationList;
    property ReservationCount : integer read GetReservationCount;
  end;

implementation

uses
  uMain
  , uSqlDefinitions
  , System.TypInfo
  ;

{ TGuestObject }

constructor TGuestObject.Create;
begin
  // --
  inherited Create;
  FPerson := 0;
  FReservation := 0;

  FGuestName := '';
  FFirstName := '';
  FSurname := '';
  FAddress1 := '';
  FAddress2 := '';
  FAddress3 := '';
  FAddress4 := '';
  FCompany := '';
  FId := '';

  FCountry := '';

  FGuestType := '';

  FInformation := '';

  FTag := 0;
end;

destructor TGuestObject.Destroy;
begin
  inherited Destroy;
end;

// -----

{ TRoomObject }
constructor TRoomObject.Create;
begin
  inherited Create;
  FRoomRes := 0;
  PMInfo := '';
  HiddenInfo := '';
  FCodedColor := -1;
  FColorId := -1;
  FGuests := TList.Create;
  FOngoingSale := 0.00;
  FOngoingRent := 0.00;
  FOngoingTaxes := 0.00;
end;

destructor TRoomObject.Destroy;
begin
  Clear;
  FGuests.free;
  inherited Destroy;
end;

procedure TRoomObject.Clear;
var
  i : integer;
begin
  for i := FGuests.count - 1 downto 0 do
  begin
    TGuestObject(FGuests[i]).free;
    FGuests.delete(i);
  end;
end;

function TRoomObject.GetGuestCount : integer;
begin
  result := FGuests.count;
end;

function TRoomObject.GetGuest(iIndex : integer) : TGuestObject;
begin
  result := TGuestObject(FGuests[iIndex]);
end;

// ----

{ TSingleReservations }

constructor TSingleReservations.Create;
begin
  inherited Create;
  PMInfo := '';
  HiddenInfo := '';
  BookingReference := '';
  FRooms := TList.Create;
end;

destructor TSingleReservations.Destroy;
begin
  Clear;
  FRooms.free;
  inherited Destroy;
end;

procedure TSingleReservations.Clear;
var
  i : integer;
begin
  for i := FRooms.count - 1 downto 0 do
  begin
    TRoomObject(FRooms[i]).free;
    FRooms.delete(i);
  end;
end;

function TSingleReservations.GetRoomCount : integer;
begin
  result := FRooms.count;
end;

function TSingleReservations.GetRoom(iIndex : integer) : TRoomObject;
begin
  result := TRoomObject(FRooms[iIndex]);
end;

{ TReservationsModel }

constructor TReservationsModel.Create;
begin
  inherited Create;
  FReservationStatus := rsUnKnown;
  FFromDate := Now;
  FToDate := Now;
  FReservationList := TList.Create;
end;

destructor TReservationsModel.Destroy;
begin
  Clear;
  FReservationList.free;
  inherited Destroy;
end;

procedure TReservationsModel.Clear;
var
  i : integer;
begin
  for i := FReservationList.count - 1 downto 0 do
  begin
    TSingleReservations(FReservationList[i]).free;
    FReservationList.delete(i);
  end;
end;

function TReservationsModel.GetSingleReservation(iIndex : integer) : TSingleReservations;
begin
  result := TSingleReservations(FReservationList[iIndex]);
end;

procedure TReservationsModel.Execute(_FromDate, _ToDate : TDate; _ReservationStatus : TReservationStatus);
var

  SingleReservations : TSingleReservations;
  RoomObject : TRoomObject;
  GuestObject : TGuestObject;
  iReservation : integer;

  iLastPerson, iLastPerson1, iLastReservation, iLastRoomReservation : integer;

  sLastDate : string;

  s : string;
  rSet : TRoomerDataSet;

begin
  RoomObject := nil;
  SingleReservations := nil;
  iLastPerson1 := 0;
  Screen.Cursor := crHourglass;
  Application.processmessages;
  try
    Clear;

    iLastReservation := -1;
    iLastRoomReservation := -1;
    iLastPerson := -1;

    //-- Query all rooms reserved this period:
    try
    rSet := nil;
    if NOT d.roomerMainDataSet.OfflineMode then
      rSet := d.roomerMainDataSet.ActivateNewDataset(d.roomerMainDataSet.SystemGetDayGrid(_FromDate, _ToDate,
              GetEnumName(TypeInfo(TReservationStatus), integer(_ReservationStatus))))
    else
      rSet := d.roomerMainDataSet.ActivateNewDataset(d.GetBackupTodaysGuests);
      with rSet do
      begin
        first;

        while not eof do
        begin
          if iLastPerson1 = FieldByName('Person').asInteger then
          begin
            next;
            continue;
          end;

          iLastPerson1 := FieldByName('Person').asInteger;
          iReservation := FieldByName('Reservation').asInteger;

          if iLastReservation <> iReservation then
          begin
            iLastReservation := iReservation;

            SingleReservations := TSingleReservations.Create;

            SingleReservations.FInputSource := Trim(FieldByName('InputSource').asString);
            SingleReservations.FWebConfirmed := Trim(FieldByName('WebConfirmed').asString) = 'Y';
            SingleReservations.FReservation := iReservation;
            try
              SingleReservations.FChannel := FieldByName('Channel').asInteger
            except
              SingleReservations.FChannel := glb.ControlSet.FieldByName('DefaultChannelId').AsInteger;
            end;
            SingleReservations.FCustomer := Trim(FieldByName('Customer').asString);
            SingleReservations.FName := Trim(FieldByName('Name').asString);
            SingleReservations.FArrival := _DBDateToDate(Trim(FieldByName('Arrival').asString));
            SingleReservations.FReservationDate := _DBDateToDate(Trim(FieldByName('ReservationDate').asString));
            SingleReservations.FStaff := Trim(FieldByName('Staff').asString);
            SingleReservations.FDeparture := _DBDateToDate(Trim(FieldByName('Departure').asString));
            SingleReservations.FTel1 := Trim(FieldByName('Tel1').asString);
            SingleReservations.FTel2 := Trim(FieldByName('Tel2').asString);
            SingleReservations.FFax := Trim(FieldByName('Fax').asString);
            SingleReservations.FInformation := Trim(FieldByName('rvInformation').Text);
            SingleReservations.FPMInfo := Trim(FieldByName('rvPMInfo').Text);
            SingleReservations.FHiddenInfo := Trim(FieldByName('rvHiddenInfo').Text);
            SingleReservations.BookingReference := Trim(FieldByName('rvInvRefrence').Text);
            SingleReservations.OutOfOrderBlocking := FieldByName('rvOutOfOrderBlocking').AsBoolean;

            // --
            // if SingleReservations.FDeparture = _ToDate - 1 then
            // SingleReservations.FResStatus := rsDeparting
            // else
            if Trim(FieldByName('Status').asString) = 'P' then
              SingleReservations.FResStatus := rsReservations
            else if Trim(FieldByName('Status').asString) = 'G' then
              SingleReservations.FResStatus := rsGuests
            else if Trim(FieldByName('Status').asString) = 'D' then
              SingleReservations.FResStatus := rsDeparted
            else if Trim(FieldByName('Status').asString) = 'R' then
              SingleReservations.FResStatus := rsReserved
            else if Trim(FieldByName('Status').asString) = 'O' then
              SingleReservations.FResStatus := rsOverbooked
            else if Trim(FieldByName('Status').asString) = 'A' then
              SingleReservations.FResStatus := rsAlotment
            else if Trim(FieldByName('Status').asString) = 'N' then
              SingleReservations.FResStatus := rsNoShow
            else if Trim(FieldByName('Status').asString) = 'B' then
              SingleReservations.FResStatus := rsBlocked
            else if Trim(FieldByName('Status').asString) = 'C' then
              SingleReservations.FResStatus := rsCanceled
            else if Trim(FieldByName('Status').asString) = 'W' then
              SingleReservations.FResStatus := rsTmp1
            else if Trim(FieldByName('Status').asString) = 'Z' then
              SingleReservations.FResStatus := rsTmp1;

            FReservationList.add(SingleReservations);
          end;

          if iLastRoomReservation <> FieldByName('RoomReservation').asInteger then
          begin
            iLastRoomReservation := FieldByName('RoomReservation').asInteger;
            sLastDate := '';

            RoomObject := TRoomObject.Create;
            RoomObject.FRoomRes := FieldByName('RoomReservation').asInteger;
            RoomObject.FReservation := FieldByName('Reservation').asInteger;
            RoomObject.FArrival := _DBDateToDate(Trim(FieldByName('RoomArrival').asString));
            RoomObject.FDeparture := _DBDateToDate(Trim(FieldByName('RoomDeparture').asString));
            RoomObject.FRoomNumber := Trim(FieldByName('Room').asString);
            RoomObject.FRRNumber := Trim(FieldByName('rrRoom').asString);
            try
              RoomObject.FGroupAccount := rset['GroupAccount'];
            except
              RoomObject.FGroupAccount := false;
            end;
            RoomObject.FRoomType := Trim(FieldByName('RoomType').asString);
            RoomObject.FRoomClass := Trim(FieldByName('RoomClass').asString);
            RoomObject.FPriceType := Trim(FieldByName('PriceType').asString);
            RoomObject.FRoomStatusChar := Trim(FieldByName('Status').asString);
            RoomObject.Currency := Trim(FieldByName('Currency').asString);
            RoomObject.FPrice := LocalFloatValue(FieldByName('RoomPrice1').asString);
            RoomObject.FDiscount := LocalFloatValue(FieldByName('Discount').asString);
            RoomObject.FPercentage := rset['Percentage']; //.asBoolean;
            RoomObject.FPMInfo := Trim(FieldByName('rrPMInfo').Text);
            RoomObject.FHiddenInfo := Trim(FieldByName('rrHiddenInfo').Text);
            RoomObject.FMeeting := FieldByName('rrHallRes').asInteger;
            RoomObject.FTotalNoRent := LocalFloatValue(FieldByName('totalNoRent').asString);
            RoomObject.FTotalTaxes := LocalFloatValue(FieldByName('totalTaxes').asString);
            RoomObject.FTotalPayments := LocalFloatValue(FieldByName('TotalPayment').asString);
            RoomObject.FPaymentInvoice := FieldByName('RoomRentPaymentInvoice').asInteger;
            if Assigned(rSet.FindField('blockMove')) then
              RoomObject.FBlockMove := rset['blockMove']; //.asBoolean;

            RoomObject.FOngoingSale := 0.00;
            if Assigned(rSet.FindField('TotalNoRent')) AND Assigned(rSet.FindField('TotalRent')) then
            begin
              RoomObject.FOngoingSale := LocalFloatValue(rSet.FieldByName('TotalNoRent').asString);
              RoomObject.FOngoingRent := LocalFloatValue(rSet.FieldByName('TotalRent').asString);
            end;

            RoomObject.FOngoingTaxes := LocalFloatValue(rSet.FieldByName('totalTaxes').asString);

            if Assigned(rSet.FindField('Invoices')) AND Assigned(rSet.FindField('Guarantee')) then
            begin
              RoomObject.FInvoices := FieldByName('Invoices').asString;
              RoomObject.FGuarantee := FieldByName('Guarantee').asString;
            end;

            if Assigned(rSet.FindField('InvoiceIndex')) then
            begin
              RoomObject.FInvoiceIndex := FieldByName('InvoiceIndex').asInteger;
            end else
              RoomObject.FInvoiceIndex := 0;

            RoomObject.ColorId := -1;
            RoomObject.CodedColor := -1;
            if FieldDefs.IndexOf('colorId') > -1 then
              try RoomObject.ColorId := FieldByName('colorId').AsInteger; except end;
            if FieldDefs.IndexOf('CodedColor') > -1 then
              try
                if FieldByName('CodedColor').AsString <> '' then
                  RoomObject.CodedColor := StringToColor(FieldByName('CodedColor').AsString);
              except
              end;

            // --
            if (RoomObject.FDeparture < _ToDate - 1) and (Trim(FieldByName('Status').asString) = 'D') then
            begin
              RoomObject.FResStatus := rsDeparting
            end
            else if (RoomObject.FDeparture = _ToDate - 1) and (Trim(FieldByName('Status').asString) = 'G') then
            begin
              RoomObject.FResStatus := rsDeparting
            end
            else if Trim(FieldByName('Status').asString) = 'P' then
            begin
              RoomObject.FResStatus := rsReservations
            end
            else if Trim(FieldByName('Status').asString) = 'G' then
            begin
              RoomObject.FResStatus := rsGuests
            end
            else if Trim(FieldByName('Status').asString) = 'D' then
            begin
              RoomObject.FResStatus := rsDeparted
            end
            else if Trim(FieldByName('Status').asString) = 'R' then
            begin
              RoomObject.FResStatus := rsReserved
            end
            else if Trim(FieldByName('Status').asString) = 'O' then
            begin
              RoomObject.FResStatus := rsOverbooked
            end
            else if Trim(FieldByName('Status').asString) = 'A' then
            begin
              RoomObject.FResStatus := rsAlotment
            end
            else if Trim(FieldByName('Status').asString) = 'N' then
            begin
              RoomObject.FResStatus := rsNoShow;
            end
            else if Trim(FieldByName('Status').asString) = 'B' then
            begin
              RoomObject.FResStatus := rsBlocked;
            end
            else if Trim(FieldByName('Status').asString) = 'C' then
            begin
              RoomObject.FResStatus := rsCanceled;
            end
            else if Trim(FieldByName('Status').asString) = 'W' then
            begin
              RoomObject.FResStatus := rsTmp1;
            end
            else if Trim(FieldByName('Status').asString) = 'Z' then
            begin
              RoomObject.FResStatus := rsTmp2;
            end;

            SingleReservations.FRooms.add(RoomObject);
          end;

          // --
          if iLastPerson <> FieldByName('Person').asInteger then
          begin
            iLastPerson := FieldByName('Person').asInteger;
            // --
            GuestObject := TGuestObject.Create;
            GuestObject.FPerson := FieldByName('Person').asInteger;
            GuestObject.FRoomRes := FieldByName('RoomReservation').asInteger;
            GuestObject.FReservation := FieldByName('Reservation').asInteger;
            // *SSS

            case g.qNameOrder of
              0 :
                GuestObject.FGuestName := CombineNames
                  (Trim(FieldByName('peName').asString), Trim(FieldByName('surName').asString));
              1 :
                GuestObject.FGuestName := CombineNames
                  (Trim(FieldByName('SurName').asString), Trim(FieldByName('peName').asString));
              2 :
                GuestObject.FGuestName := FieldByName('peName').asString;
              3 :
                GuestObject.FGuestName := FieldByName('surName').asString;
            end;

            GuestObject.FSurname := Trim(FieldByName('Surname').asString);
            GuestObject.FFirstName := Trim(FieldByName('peName').asString);
            GuestObject.FAddress1 := Trim(FieldByName('Address1').asString);
            GuestObject.FAddress2 := Trim(FieldByName('Address2').asString);
            GuestObject.FAddress3 := Trim(FieldByName('Address3').asString);
            GuestObject.FAddress4 := Trim(FieldByName('Address4').asString);
            GuestObject.Country := Trim(FieldByName('Country').asString);
            GuestObject.GuestType := Trim(FieldByName('GuestType').asString);
            GuestObject.FInformation := Trim(FieldByName('Information').Text);

            RoomObject.FGuests.add(GuestObject);
          end;

          next;
        end;

      end;
    finally
      freeandnil(rSet);
    end;
  finally
    Screen.Cursor := crDefault;
    Application.processmessages;
  end;
end;

function TReservationsModel.GetReservationCount : integer;
begin
  result := 0;
  try
    result := FReservationList.count;
  except
  end;
end;

end.
