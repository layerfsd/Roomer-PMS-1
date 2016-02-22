unit objNewReservation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Contnrs, Dialogs, NativeXML,
  ADODB
  , cmpRoomerDataSet
  , cmpRoomerConnection
  , uPriceOBJ
  , objHomeCustomer
  , objRoomRates
  , Generics.Collections
  , PrjConst
  , ustringUtils
  , ug
  , uAlerts
  ;

TYPE
  TResMedhod = (rmNormal, rmDateRoom, rmDate, rmRoom, rmBlocked,rmAllotment,rmImport);

TYPE

  TnewRoomReservationItem = class
    FRoomReservation: integer;
    FRoomNumber: string;
    FRoomType: string;
    FPackage : string;
    FArrival: TDateTime;
    FDeparture: TDateTime;
    FGuestCount: integer;
    FAvragePrice: Double;
    FAvrageDiscount : Double;
    FisPercentage : boolean;
    FRateCount: integer;
    FChildrenCount: integer;
    FInfantCount: integer;
    FPriceCode : string;
    FMainGuestName : string;
    FNotes         : string;

    FRates: TRates;

    function getRoomReservation: integer;
    function getRoomNumber: string;
    function getRoomType: string;
    function getPackage: string;
    function getPriceCode: string;
    function getArrival: TDateTime;
    function getDeparture: TDateTime;
    function getGuestCount: integer;
    function getAvragePrice: Double;
    function getAvrageDiscount: Double;
    function getIsPercentage : boolean;
    function getRateCount: integer;
    function getChildrenCount: integer;
    function getInfantCount: integer;
    function getMainGuestName: string;
    function getNotes: string;


    procedure SetRoomreservation(Value: integer);
    procedure SetRoomNumber(Value: string);
    procedure SetRoomType(Value: string);
    procedure SetPackage(Value: string);
    procedure SetPriceCode(Value: string);
    procedure SetArrival(Value: TDateTime);
    procedure SetDeparture(Value: TDateTime);
    procedure SetGuestCount(Value: integer);
    procedure SetAvragePrice(Value: Double);
    procedure SetAvrageDiscount(Value: Double);
    procedure SetIsPercentage(Value: boolean);
    procedure setRateCount(Value: integer);
    procedure setChildrenCount(Value: integer);
    procedure setInfantCount(Value: integer);
    procedure SetMainGuestName(Value: string);
    procedure SetNotes(Value: string);

  private
    FBreakfast: Boolean;
    FBreakfastCost: Double;
    FBreakfastIncluded: Boolean;
    FExtraBedCost: Double;
    FExtraBedIncluded: Boolean;
    FExtraBed: Boolean;
    FExtraBedCostGroupAccount: Boolean;
    FBreakfastCostGroupAccount: Boolean;
    FManualChannelId: Integer;
    FratePlanCode: String;
    // **
  public
    constructor Create(aRoomReservation: integer;
                       aRoomNumber: string;
                       aRoomType: string;
                       aPackage : string;
                       aArrival: TDateTime;
                       aDeparture: TDateTime;
                       aGuestCount: integer;
                       aAvragePrice: Double;
                       aAvrageDiscount: Double;
                       isPercentage : boolean;
                       aRateCount: integer;
                       aChildrenCount: integer;
                       aInfantCount: integer;
                       aPriceCode : string;
                       aMainGuestName : string;
                       notes : string
                       );

    destructor Destroy; override;

    property RoomReservation: integer   read getRoomReservation write SetRoomreservation    ;
    property RoomNumber     : string    read getRoomNumber      write SetRoomNumber         ;
    property RoomType       : string    read getRoomType        write SetRoomType           ;
    property Package        : string    read getPackage         write SetPackage            ;
    property PriceCode      : string    read getPriceCode       write SetPriceCode          ;
    property Arrival        : TDateTime read getArrival         write SetArrival            ;
    property Departure      : TDateTime read getDeparture       write SetDeparture          ;

    property GuestCount     : integer   read getGuestCount      write SetGuestCount         ;
    property AvragePrice    : Double    read getAvragePrice     write SetAvragePrice        ;
    property AvrageDiscount : Double    read getAvrageDiscount  write SetAvrageDiscount     ;
    property isPercentage   : boolean   read getisPercentage    write SetisPercentage       ;
    property RateCount      : integer   read getRateCount       write setRateCount          ;
    property ChildrenCount  : integer   read getChildrenCount   write setChildrenCount      ;
    property InfantCount    : integer   read getInfantCount     write setInfantCount        ;
    property MainGuestName  : string    read getMainGuestName   write SetMainGuestName      ;
    property Notes          : string    read getNotes           write SetNotes              ;

    property Breakfast  : Boolean    read FBreakfast   write FBreakfast      ;
    property BreakfastIncluded  : Boolean    read FBreakfastIncluded   write FBreakfastIncluded      ;
    property BreakfastCost  : Double    read FBreakfastCost   write FBreakfastCost      ;
    property BreakfastCostGroupAccount : Boolean    read FBreakfastCostGroupAccount   write FBreakfastCostGroupAccount      ;
    property ExtraBed  : Boolean    read FExtraBed   write FExtraBed      ;
    property ExtraBedIncluded  : Boolean    read FExtraBedIncluded   write FExtraBedIncluded      ;
    property ExtraBedCost  : Double    read FExtraBedCost   write FExtraBedCost      ;
    property ExtraBedCostGroupAccount  : Boolean    read FExtraBedCostGroupAccount   write FExtraBedCostGroupAccount      ;

    property oRates         : TRates    read FRates             write FRates                ;

    property ManualChannelId  : Integer read FManualChannelId   write FManualChannelId      ;
    property ratePlanCode  : String     read FratePlanCode      write FratePlanCode         ;

  end;

  /// ///////////////////////////////////////////////////////////////////////////
  // TSelectedRoomItem
  //
  /// ///////////////////////////////////////////////////////////////////////////

  TnewRoomReservationItemsList = TObjectList<TnewRoomReservationItem>;

  /// ///////////////////////////////////////////////////////////////////////////////////
  /// TSelectedRooms
  ///
  /// //////////////////////////////////////////////////////////////////////////////////

  TnewRoomReservation = class
  private
    FXmlFileName: string;

    FRoomCount: integer;
    FRoomList: TnewRoomReservationItemsList;  {each room in reservation}

    FHotelcode: string;
    FReservationArrival: TDateTime;
    FReservationDeparture: TDateTime;

    function getRoomCount: integer;

  public
    constructor Create(aHotelCode: string);
    destructor Destroy; override;

    function getReservationArrival: TDateTime;
    function getReservationDeparture: TDateTime;

    property XmlFileName: string read FXmlFileName write FXmlFileName;
    property Hotelcode: string read FHotelcode write FHotelcode;

    function FindRoomFromRoomNumber(RoomNumber: string; StartAt: integer;
      caseSensitive: Boolean = false): integer;
    function FindRoomFromRoomReservation(RoomReservation: integer; StartAt: integer): integer;


    property RoomItemsList: TnewRoomReservationItemsList read FRoomList
      write FRoomList;
    property RoomCount: integer read getRoomCount;

    property ReservationArrival: TDateTime read getReservationArrival;
    property ReservationDeparture: TDateTime read getReservationDeparture;
  end;

  /// ////////////////////////////////////////////////////////////////////////////////////////////
  //
  //
  /// ////////////////////////////////////////////////////////////////////////////////////////////

  TNewReservation = class
  private
    FHotelcode: string;
    FnewRoomReservations: TnewRoomReservation;  // i.e roomreservation
    FHomeCustomer: THomeCustomer;
    FShowProfile: Boolean;
    FresMedhod: TResMedhod;
    FIsQuick: Boolean;

    // Values not available until after create
    FReservation: integer;
    FPriceFound: Boolean;

    // Hdata parameters
    FConnection: TRoomerConnection;
    FLoglevel: integer;
    FLogPath: string;

    // New 2013-01-14
    FStaff: string;
    FOutOfOrderBlocking: Boolean;
    FSendConfirmationEmail: Boolean;
    FAlertList: TAlertList;
    procedure DeleteReservation(Reservation: integer);

  public
    constructor Create(aHotelCode, Staff: string);  overload;
    constructor Create(aHotelCode, Staff,contactAddress1,contactAddress2,contactAddress3,contactaddress4: string);  overload;

    destructor Destroy; override;

    Function CreateReservation(DeleteResNr : integer=-1; Transactional : Boolean = true) : Boolean;

    property Hotelcode: string read FHotelcode write FHotelcode;

    property newRoomReservations: TnewRoomReservation read FnewRoomReservations
      write FnewRoomReservations;
    property HomeCustomer: THomeCustomer read FHomeCustomer write FHomeCustomer;

    property ShowProfile: Boolean read FShowProfile write FShowProfile;
    property resMedhod: TResMedhod read FresMedhod write FresMedhod;
    property IsQuick: Boolean read FIsQuick write FIsQuick;

    // Values not available until after create
    property Reservation: integer read FReservation write FReservation;
    property PriceFound: Boolean read FPriceFound write FPriceFound;

    // Hdata parameters
    property Connection: TRoomerConnection read FConnection write FConnection;
    property loglevel: integer read FLoglevel write FLoglevel;
    property logpath: string read FLogPath write FLogPath;

    property Staff: string read FStaff write FStaff;
    property OutOfOrderBlocking: Boolean read FOutOfOrderBlocking write FOutOfOrderBlocking;
    property SendConfirmationEmail: Boolean read FSendConfirmationEmail write FSendConfirmationEmail;

    property AlertList : TAlertList read FAlertList write FAlertList;

  end;

implementation

uses
  _glob,
  hData,
  ud,
  uAppGlobal,
  uGuestPortfolioEdit,
  uActivityLogs
  ;

/// ///////////////////////////////////////////////////////////////////////////
// TSelectedRoomItem
/// ///////////////////////////////////////////////////////////////////////////

constructor TnewRoomReservationItem.Create(aRoomReservation: integer;
                                     aRoomNumber: string;
                                     aRoomType: string;
                                     aPackage: string;
                                     aArrival: TDateTime;
                                     aDeparture: TDateTime;
                                     aGuestCount: integer;
                                     aAvragePrice: Double;
                                     aAvrageDiscount: Double;
                                     isPercentage : boolean;
                                     aRateCount: integer;
                                     aChildrenCount: integer;
                                     aInfantCount: integer;
                                     aPriceCode : string;
                                     aMainGuestName : string;
                                     notes : string
                                     );
begin
  setRoomreservation(aRoomReservation);
  setRoomNumber(aRoomNumber);
  setRoomType(aRoomType);
  setPackage(aPackage);
  setArrival(aArrival);
  setDeparture(aDeparture);
  setGuestCount(aGuestCount);
  setAvragePrice(aAvragePrice);
  setAvrageDiscount(aAvrageDiscount);
  setisPercentage(isPercentage);
  setRateCount(aRateCount);
  setChildrenCount(aChildrenCount);
  setInfantCount(aInfantCount);
  setPriceCode(aPriceCode);
  setMainGuestName(aMainGuestName);
  setNotes(notes);
  FRates := TRates.Create('');

  FBreakfast := False;
  FBreakfastIncluded := False;
  FBreakfastCost := 0.00;
  FExtraBed := False;
  FExtraBedIncluded := False;
  FExtraBedCost := 0.00;
end;

destructor TnewRoomReservationItem.Destroy;
begin
  FRates.Free;
  inherited;
end;

function TnewRoomReservationItem.getRateCount: integer;
begin
  result := RateCount;
end;

function TnewRoomReservationItem.getRoomNumber: string;
begin
  result := FRoomNumber
end;

function TnewRoomReservationItem.getRoomReservation: integer;
begin
  result := FRoomReservation;
end;

function TnewRoomReservationItem.getRoomType: string;
begin
  result := FRoomType;
end;

function TnewRoomReservationItem.getPackage: string;
begin
  result := FPackage;
end;

function TnewRoomReservationItem.getPriceCode: string;
begin
  result := FPriceCode;
end;

function TnewRoomReservationItem.getMainGuestName: string;
begin
  result := copy(FMainGuestName,1,100);
end;

function TnewRoomReservationItem.getNotes: string;
begin
  result := FNotes;
end;


function TnewRoomReservationItem.getArrival: TDateTime;
begin
  result := FArrival
end;

function TnewRoomReservationItem.getAvragePrice: Double;
begin
  result := FAvragePrice;
end;

function TnewRoomReservationItem.getAvrageDiscount: Double;
begin
  result := FAvrageDiscount;
end;

function TnewRoomReservationItem.getisPercentage: boolean;
begin
  result := FisPercentage;
end;


function TnewRoomReservationItem.getChildrenCount: integer;
begin
  result := FChildrenCount;
end;

function TnewRoomReservationItem.getDeparture: TDateTime;
begin
  result := FDeparture
end;

function TnewRoomReservationItem.getGuestCount: integer;
begin
  result := FGuestCount;
end;

function TnewRoomReservationItem.getInfantCount: integer;
begin
  result := FInfantCount;
end;

procedure TnewRoomReservationItem.SetGuestCount(Value: integer);
begin
  FGuestCount := Value
end;

procedure TnewRoomReservationItem.setInfantCount(Value: integer);
begin
  FInfantCount := Value;
end;

procedure TnewRoomReservationItem.setRateCount(Value: integer);
begin
  FRateCount := Value;
end;

procedure TnewRoomReservationItem.SetRoomNumber(Value: string);
begin
  FRoomNumber := Value
end;

procedure TnewRoomReservationItem.SetRoomreservation(Value: integer);
begin
  FRoomReservation := Value;
end;

procedure TnewRoomReservationItem.SetRoomType(Value: string);
begin
  FRoomType := Value;
end;

procedure TnewRoomReservationItem.SetPackage(Value: string);
begin
  FPackage := Value;
end;

procedure TnewRoomReservationItem.SetPriceCode(Value: string);
begin
  FPriceCode := Value;
end;

procedure TnewRoomReservationItem.SetMainGuestName(Value: string);
begin
  FMainGuestName := Value;
end;

procedure TnewRoomReservationItem.SetNotes(Value: string);
begin
  FNotes := Value;
end;


procedure TnewRoomReservationItem.SetArrival(Value: TDateTime);
begin
  FArrival := Value
end;

procedure TnewRoomReservationItem.SetAvragePrice(Value: Double);
begin
  FAvragePrice := Value;
end;

procedure TnewRoomReservationItem.SetAvrageDiscount(Value: Double);
begin
  FAvrageDiscount := Value;
end;



procedure TnewRoomReservationItem.SetisPercentage(Value: boolean);
begin
  FisPercentage := Value;
end;

procedure TnewRoomReservationItem.setChildrenCount(Value: integer);
begin
  FChildrenCount := value;
end;

procedure TnewRoomReservationItem.SetDeparture(Value: TDateTime);
begin
  FDeparture := Value
end;

/// ///////////////////////////////////////////////////////////////////
{ TSelectedRooms }
/// ///////////////////////////////////////////////////////////////////

constructor TnewRoomReservation.Create(aHotelCode: string);
begin
  inherited Create;
  try
    FRoomList := TnewRoomReservationItemsList.Create(True);
  Except
    // TODO Loga
  end;

  FHotelcode := aHotelCode;
  FRoomCount := 0;
end;

destructor TnewRoomReservation.Destroy;
begin
  FRoomList.Free;
  inherited;
end;

function TnewRoomReservation.getReservationArrival: TDateTime;
var
  i: integer;
  tmpDate: TDateTime;
begin
  tmpDate := 0;
  for i := 0 to FRoomList.Count - 1 do
  begin
    if i = 0 then
    begin
      tmpDate := FRoomList[i].FArrival;
    end;

    if FRoomList[i].FArrival < tmpDate then
      tmpDate := FRoomList[i].FArrival;
  end;

  result := tmpDate;
end;

function TnewRoomReservation.getReservationDeparture: TDateTime;
var
  i: integer;
  tmpDate: TDateTime;
begin
  tmpDate := 0;
  for i := 0 to FRoomList.Count - 1 do
  begin
    if i = 0 then
    begin
      tmpDate := FRoomList[i].FDeparture;
    end;

    if FRoomList[i].FArrival > tmpDate then
      tmpDate := FRoomList[i].FDeparture;
  end;

  result := tmpDate;
end;


function TnewRoomReservation.FindRoomFromRoomNumber(RoomNumber: string;
  StartAt: integer; caseSensitive: Boolean): integer;
var
  i: integer;
  Room: string;
begin
  result := -1;
  if StartAt > FRoomList.Count - 1 then
    exit;

  if not caseSensitive then
  begin
    RoomNumber := ansiLowercase(RoomNumber);
  end;

  for i := StartAt to FRoomList.Count - 1 do
  begin
    Room := FRoomList[i].FRoomNumber;

    if not caseSensitive then
    begin
      Room := ansiLowercase(Room);
    end;

    if RoomNumber = Room then
    begin
      result := i;
      Break;
    end;
  end;
end;


function TnewRoomReservation.FindRoomFromRoomReservation(RoomReservation: integer; StartAt: integer): integer;
var
  i: integer;
  RoomRes : integer;
begin
  result := -1;
  if StartAt > FRoomList.Count - 1 then
    exit;

  for i := StartAt to FRoomList.Count - 1 do
  begin
    RoomRes := FRoomList[i].FRoomReservation;
    if Roomreservation = RoomRes then
    begin
      result := i;
      Break;
    end;
  end;
end;


function TnewRoomReservation.getRoomCount: integer;
begin
  // Testa
  result := FRoomList.Count;
end;

/// /////////////////////////////////////////////////////////////////////////////
//
//
/// /////////////////////////////////////////////////////////////////////////////

{ TNewReservation }

constructor TNewReservation.Create(aHotelCode, Staff: string);
begin
  FHotelcode := Hotelcode;
  FnewRoomReservations := TnewRoomReservation.Create(aHotelCode);
  FHomeCustomer := THomeCustomer.Create(aHotelCode, hData.ctrlGetString('RackCustomer')); //  '');
  FReservation := -1; //hData.RV_SetNewID();

  FSendConfirmationEmail := False;

  FShowProfile := false;
  FresMedhod := rmNormal;
  FIsQuick := true;
  FStaff := Staff;

  FConnection := Connection;
  FLoglevel := loglevel;
  FLogPath := logpath;
  FPriceFound := true;

  FAlertList := TAlertList.Create(0, 0, atUNKNOWN);

end;

constructor TNewReservation.Create(aHotelCode, Staff, contactAddress1,contactAddress2,contactAddress3,contactAddress4 : string);
begin
  FHotelcode := Hotelcode;
  FnewRoomReservations := TnewRoomReservation.Create(aHotelCode);
  FHomeCustomer := THomeCustomer.Create(aHotelCode, '',contactAddress1,contactAddress2,contactaddress3,contactAddress4);
  FReservation := -1; //hData.RV_SetNewID();

  FShowProfile := false;
  FresMedhod := rmNormal;
  FIsQuick := true;
  FStaff := Staff;

  FConnection := Connection;
  FLoglevel := loglevel;
  FLogPath := logpath;
  FPriceFound := true;

  FAlertList := TAlertList.Create(0, 0, atUNKNOWN);

end;


destructor TNewReservation.Destroy;
begin
  FAlertList.Free;
  FHomeCustomer.Free;
  FNewRoomReservations.Free;
  inherited;
end;


const UPDATE_QUERY = 'INSERT INTO home100.DOORCODE_MESSAGE_SCHEDULE('
        + 'HOTEL_ID, '
        + 'BOOKING_ID, '
        + 'ROOM_RES_ID, '
        + 'FIRST_NAME, '
        + 'LAST_NAME, '
        + 'PHONENUMBER, '
        + 'EMAIL, '
        + 'HOTEL_EMAIL, '
        + 'HOTEL_ERR_EMAIL, '
        + 'DOORID, '
        + 'ARRIVAL_DATE, '
        + 'DEPARTURE_DATE, '
        + 'TIMEZONE, NAME_FOR_MAIL, '
        + 'GENDER_FOR_MAIL'
        + ') '
        + 'VALUES ('
        + ''':hotelId'', '
        + ''':bookingId'', '
        + ''':roomResId'', '
        + ''':firstName'', '
        + ''':lastName'', '
        + ''':phone'', '
        + ''':email'', '
        + ''':hotelEmail'', '
        + ''':hotelErrEmail'', '
        + ''':doorId'', '
        + ''':arrDate'', '
        + ''':depDate'', '
        + ''':tz'', '
        + ''':mailName'', '
        + ''':mailGender'''
        + ')';



Function TNewReservation.CreateReservation(DeleteResNr : integer=-1; Transactional : Boolean = true): Boolean;
var
  rSet : TRoomerDataSet;

  iRoomReservation: integer;
  iLastPerson: integer;

  Customer: string;

  sArrival: string;
  sDeparture: string;
  Arrival: TDate;
  Departure: TDate;

  iDayCount: integer;
  sDate: string;

  RoomNumber: string;
  isNoRoom: Boolean;
  RoomType: string;
  Package : string;

  sDates: string;

  ReservationArrival: TDate;
  ReservationDeparture: TDate;
  reservationName: string;
  guestName: string;

  Address1: string;
  Address2: string;
  Address3: string;
  Address4: string;
  Country: string;
  Tel1: string;
  Tel2: string;
  Fax: string;

  CustomerEmail: string;
  CustomerWebSite: string;

  ContactName   : string;
  ContactPhone  : string;
  ContactPhone2 : string;
  ContactFax    : string;
  ContactEmail  : string;
  ContactAddress1 : string;
  ContactAddress2 : string;
  ContactAddress3 : string;
  ContactAddress4 : string;
  ContactCountry : string;

  CustPID: string;

  reservationDate: TDate;
  Staff: String;

  ReservationPaymentInfo: string;
  ReservationGeneralInfo: string;
  HiddenInfo: string;

  MarketSegment: string;

  Currency: string;

  isBreckfastIncluted: Boolean;
  isGroupInvoice: Boolean;
  RoomStatus: string;

  PriceCode: string;
  MainGuestName : string;

  numGuests    ,
  numChildren ,
  numInfants   : integer;

  Discount: Double;

  RoomPMInfo: string;
  RoomHiddenInfo: string;

  GuestCompany: string;
  GuestType: string;
  GuestInformation: string;
  GuestPID: string;

  // Data Holders
  reservationData    : recReservationHolder;
  invoiceHeadData    : recInvoiceHeadHolder;
  roomReservationData: recRoomReservationHolder;
  roomsDateData      : recRoomsDateHolder;
  personData         : recPersonHolder;
  invoicelineData    : recInvoiceLineHolder;

  // priceNotFound : boolean;

  DayCount: integer;
  Processed: integer;
  FirstDate: TDate;
  LastDate: TDate;

  useStayTax: Boolean;
  useInNationalReport: Boolean;
  channel: integer;
  invRefrence : String;

  ExecutionPlan : TRoomerExecutionPlan;

  contactIsMainGuest : boolean;
  lstReservationActivity : TStringlist;
  lstInvoiceActivity : TStringlist;

  procedure init;
  begin
    Currency := FHomeCustomer.Currency;
    Customer := FHomeCustomer.Customer;

    guestName := FHomeCustomer.guestName;
    invRefrence := FHomeCustomer.invRefrence;

    reservationName := FHomeCustomer.reservationName;

    Address1 := FHomeCustomer.Address1;
    Address2 := FHomeCustomer.Address2;
    Address3 := FHomeCustomer.Address3;
    Address4 := FHomeCustomer.Address4;
    Country := FHomeCustomer.Country;

    Tel1 := FHomeCustomer.Tel1;
    Tel2 := FHomeCustomer.Tel2;
    Fax := FHomeCustomer.Fax;

    CustomerEmail := FHomeCustomer.EmailAddress;
    CustomerWebSite := FHomeCustomer.HomePage;

    ContactName   := copy(FHomeCustomer.ContactPerson,1,100);
    ContactPhone  := copy(FHomeCustomer.ContactPhone,1,30);
    ContactFax    := copy(FHomeCustomer.ContactFax,1,30);
    ContactEmail  := copy(FHomeCustomer.ContactEmail,1,50);
    CustPID       := copy(FHomeCustomer.PID,1,15);
    MarketSegment := copy(FHomeCustomer.MarketSegmentCode,1,5);


    contactAddress1 := copy(FHomeCustomer.contactAddress1,1,100);
    contactAddress2 := copy(FHomeCustomer.contactAddress2,1,100);
    contactAddress3 := copy(FHomeCustomer.contactAddress3,1,100);
    contactAddress4 := copy(FHomeCustomer.contactAddress4,1,100);

    contactCountry := copy(FHomeCustomer.contactCountry,1,2);

    reservationDate := Date;

    ReservationPaymentInfo := FHomeCustomer.ReservationPaymentInfo;
    ReservationGeneralInfo := FHomeCustomer.ReservationGeneralInfo;
    HiddenInfo := '';
    ContactIsMainGuest := FhomeCustomer.contactIsMainGuest;

    isBreckfastIncluted := hData.ctrlGetBoolean('BreakfastInclDefault');

    isGroupInvoice := FHomeCustomer.isGroupInvoice;
    RoomStatus := FHomeCustomer.RoomStatus;

    useStayTax := true;
    useInNationalReport := true;
    channel := channels_getDefault();
  end;

  procedure CreateReservation;
  begin
    hData.initReservationHolderRec(reservationData, staff);

    reservationData.Reservation := FReservation;
    Arrival          := FnewRoomReservations.FRoomList[0].FArrival;
    Departure        := FnewRoomReservations.FRoomList[0].FDeparture;;

    reservationData.Arrival   := _DateToDBDate(Arrival  , false);
    reservationData.Departure := _DateToDBDate(Departure, false);

    reservationData.Customer := Customer;
    reservationData.name     := copy(reservationName,1,100);
    reservationData.Address1 := Address1;
    reservationData.Address2 := Address2;
    reservationData.Address3 := Address3;
    reservationData.Address4 := Address4;
    reservationData.Country  := Country;
    reservationData.Tel1          := Tel1;
    reservationData.Tel2          := Tel2;
    reservationData.Fax           := Fax;
    reservationData.CustomerEmail := CustomerEmail;
    reservationData.CustomerWebSite := CustomerWebSite;
    reservationData.status := RoomStatus;
    reservationData.reservationDate := _DateToDBDate(reservationDate, false);
    reservationData.Staff := FStaff;;
    reservationData.Information := ReservationGeneralInfo;
    reservationData.PMInfo := ReservationPaymentInfo;
    reservationData.HiddenInfo := HiddenInfo;
    reservationData.RoomRentPaid1 := 0.00;
    reservationData.RoomRentPaid2 := 0.00;
    reservationData.RoomRentPaid3 := 0.00;
    reservationData.RoomRentPaymentInvoice := -1;
    reservationData.ContactName     := ContactName;
    reservationData.ContactPhone    := ContactPhone;
    reservationData.ContactPhone2   := ContactPhone2;
    reservationData.ContactFax      := ContactFax;
    reservationData.ContactEmail    := ContactEmail;
    reservationData.ContactAddress1 := ContactAddress1;
    reservationData.ContactAddress2 := ContactAddress2;
    reservationData.ContactAddress3 := ContactAddress3;
    reservationData.ContactAddress4 := ContactAddress4;
    reservationData.ContactIsmainGuest := ContactIsMainGuest;
    reservationData.ContactCountry  := ContactCountry;
    reservationData.CustPID          := CustPID;
    reservationData.MarketSegment    := MarketSegment;
    reservationData.useStayTax       := useStayTax;
    reservationData.channel          := channel;
    reservationData.invRefrence      := invRefrence;
    reservationData.OutOfOrderBlocking  := OutOfOrderBlocking;

    ExecutionPlan.AddExec(SQL_INS_Reservation(reservationData));

    //***Log reservation
    lstReservationActivity.add(CreateReservationActivityLog(g.quser
                                                 ,FReservation
                                                 ,-1 //Roomreservation
                                                 ,NEW_RESERVATION
                                                 ,'' //old value
                                                 ,reservationData.name //New vlaue
                                                 ,'Refr :'+reservationData.invRefrence //Moreinfo
                                   ));




//    if not hData.SP_INS_Reservation(reservationData, Connection, loglevel,
//      logpath) then
//    begin
//      // **
//    end;
  end;

  procedure createReservationInvoiceHead;
  begin
    initInvoiceHeadHolderRec(invoiceHeadData);
    invoiceHeadData.Reservation := Reservation;
    invoiceHeadData.RoomReservation := 0;
    invoiceHeadData.SplitNumber := 0;
    invoiceHeadData.InvoiceNumber := -1;
    invoiceHeadData.InvoiceDate := _DateToDBDate(reservationDate, false);
    invoiceHeadData.Customer := Customer;
    invoiceHeadData.name := copy(reservationName + ', ' + guestName,1,100);
    invoiceHeadData.Address1 := Address1;
    invoiceHeadData.Address2 := Address2;
    invoiceHeadData.Address3 := Address3;
    invoiceHeadData.Address4 := Address4;
    invoiceHeadData.Country := Country;
    invoiceHeadData.Total := 0.00;
    invoiceHeadData.TotalWOVAT := 0.00;
    invoiceHeadData.TotalVAT := 0.00;
    invoiceHeadData.TotalBreakFast := 0.00;
    invoiceHeadData.ExtraText := '';;
    invoiceHeadData.Finished := false;
    invoiceHeadData.CreditInvoice := -1;
    invoiceHeadData.OriginalInvoice := -1;
    invoiceHeadData.InvoiceType := 1;
    invoiceHeadData.ihTmp := '';
    invoiceHeadData.CustPID := CustPID;
    invoiceHeadData.RoomGuest := guestName;
    invoiceHeadData.ihDate := reservationDate;
    invoiceHeadData.ihInvoiceDate := reservationDate;
    invoiceHeadData.ihConfirmDate := 2;
    invoiceHeadData.ihPayDate := reservationDate;
    invoiceHeadData.ihStaff := FStaff;
    invoiceHeadData.ihCurrency := Currency;
    invoiceHeadData.ihCurrencyRate := 1.00;
    invoiceHeadData.ReportDate := '';
    invoiceHeadData.ReportTime := '';

    ExecutionPlan.AddExec(SQL_INS_InvoiceHead(invoiceHeadData));

  end;

var
  s: string;
  ii: integer;
  i: integer;
  line: string;

  tmpDate1, tmpDate2: TDate;
  li: longInt;

  PriceID       : integer;
  RateIndex     : integer;

  avrageRate : double;
  avrageDiscount : double;
  rateCount  : integer;

  newID : integer;
  isPercentage : boolean;

  isOk : Boolean;
  CheckCount : integer;

  TotalGuests : integer;

  sID      : string     ;
  lstIDs   : TStringLIst;
  GuestIndex : integer;
  roomnotes : string;
  packageID : integer;

  ItemTypeInfo : TItemTypeInfo;
  ItemID       : string;
  Price        : double;
  numItems     : double;
  Total        : double;
  TotalWOVAT   : double;
  Vat          : double;

  fTmp            : double;
  aYear,aMon,aDay : word;
  iTmp            : integer;
  itemDescription,
  packageDescription : string;
  numItemsMethod : integer;

  rr,rralias : integer;

  rNewSet : TRoomerDataset;
  iProfileId : Integer;

  CurrencyRate : Double;


begin
  FReservation := -1;
  CheckCount   := 0;
  Discount     := 0;
  isOk         := True;
  GuestIndex   := 0;


  lstInvoiceActivity := TStringList.Create;
  lstReservationActivity := TStringList.Create;

  lstIDs := TstringList.Create;
  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  try
    repeat
      try
        if Transactional then
          ExecutionPlan.BeginTransaction;

        if (DeleteResNr > 0) then
        begin
          d.roomerMainDataSet.SystemRemoveReservation(DeleteResNr, False, False);
        end;

        TotalGuests := 0;
        for i := 0 to FnewRoomReservations.RoomCount - 1 do
        begin
          TotalGuests := TotalGuests + FnewRoomReservations.FRoomList[i].getGuestCount;
          TotalGuests := TotalGuests + FnewRoomReservations.FRoomList[i].getChildrenCount;
          TotalGuests := TotalGuests + FnewRoomReservations.FRoomList[i].getInfantCount;
        end;

        sId := persons_GetIDs(TotalGuests);
        _glob._strTokenToStrings(sID,'|',lstIDs);


        FReservation := hData.RV_SetNewID();
        init;
        CreateReservation;
        createReservationInvoiceHead;

        for i := 0 to FnewRoomReservations.RoomCount - 1 do
        begin

          RoomNumber       := FnewRoomReservations.FRoomList[i].FRoomNumber;

          if (RoomNumber <> '') AND (copy(RoomNumber,1,1) <> '<') then  glb.LocateRoom(RoomNumber);

          Arrival          := FnewRoomReservations.FRoomList[i].FArrival;
          Departure        := FnewRoomReservations.FRoomList[i].FDeparture;;

          RoomType         := FnewRoomReservations.FRoomList[i].FRoomType;
          Package          := FnewRoomReservations.FRoomList[i].FPackage;

          iRoomReservation := FnewRoomReservations.FRoomList[i].FRoomReservation;

          numGuests        := FnewRoomReservations.FRoomList[i].FGuestCount;
          numChildren      := FnewRoomReservations.FRoomList[i].FChildrenCount;
          numInfants       := FnewRoomReservations.FRoomList[i].FInfantCount;

          PriceCode     := FnewRoomReservations.FRoomList[i].FPriceCode;
          MainGuestName := FnewRoomReservations.FRoomList[i].FMainGuestName;

          AvrageRate     := FnewRoomReservations.FRoomList[i].FAvragePrice;
          AvrageDiscount := FnewRoomReservations.FRoomList[i].FAvrageDiscount;
          isPercentage   := FnewRoomReservations.FRoomList[i].FisPercentage;
          rateCount      := FnewRoomReservations.FRoomList[i].FRateCount;

          roomNotes := FnewRoomReservations.FRoomList[i].FNotes;


          if iRoomReservation < 1 then
          begin
            iRoomReservation := RR_SetNewID();
          end;

          if roomType = '' then
          begin
            RoomType := glb.RoomsSet['RoomType'];//GET_RoomsType_byRoom(RoomNumber);
          end;

          useInNationalReport := true;
          isNoRoom := false;

          if RoomNumber = '' then
          begin
            RoomNumber := '<' + inttostr(iRoomReservation) + '>';
            isNoRoom := true;
            { TODO 3 -oHordur -cConvert to XE3 : When creating reservation in quick and room is noRoon then set RoomType to default roomtype }
          end else
          if copy(RoomNumber,1,1) = '<' then
          begin
            isNoRoom := true;
          end else
          begin
            useInNationalReport := glb.RoomsSet.FieldByName('useInNationalReport').AsBoolean;//GET_useInNationalReport_byRoom(RoomNumber);
          end;

          if RoomStatus <> 'B' then
          begin
            if numGuests = 0 then
            begin
              if isNoRoom then
              begin
                numGuests :=  glb.GET_RoomTypeNumberGuests_byRoomType(RoomType);
              end else
              begin
                numGuests := hData.GET_NumberOfGuestsbyRoom(RoomNumber);
              end
            end;
            if numGuests = 0 then numGuests := 2;
          end;


          RoomPMInfo := '';
          RoomHiddenInfo := roomNotes;

          initRoomReservationHolderRec(roomReservationData);

          roomReservationData.ManualChannelId := FnewRoomReservations.FRoomList[i].ManualChannelId;
          roomReservationData.ratePlanCode    := FnewRoomReservations.FRoomList[i].ratePlanCode;
          roomReservationData.RoomReservation := iRoomReservation;
          roomReservationData.Room            := RoomNumber;
          roomReservationData.Reservation     := FReservation;
          roomReservationData.status          := RoomStatus;
          roomReservationData.GroupAccount    := isGroupInvoice;
          roomReservationData.invBreakfast    := FnewRoomReservations.FRoomList[i].FBreakfast AND FnewRoomReservations.FRoomList[i].FBreakfastIncluded;
          roomReservationData.Currency        := Currency;
          roomReservationData.Discount        := Discount;
          roomReservationData.Percentage      := isPercentage;
          roomReservationData.PriceType       := PriceCode;
          roomReservationData.Arrival         := _DateToDBDate(Arrival, false);
          roomReservationData.Departure       := _DateToDBDate(Departure, false);
          roomReservationData.RoomType        := RoomType;
          roomReservationData.Package         := package;
          roomReservationData.PMInfo          := RoomPMInfo;
          roomReservationData.HiddenInfo      := RoomHiddenInfo;
          roomReservationData.RoomRentPaymentInvoice := -1;
          roomReservationData.rrTmp               := '';;
          roomReservationData.rrDescription       := '';;
          roomReservationData.rrArrival           := Arrival;
          roomReservationData.rrDeparture         := Departure;
          roomReservationData.rrIsNoRoom          := isNoRoom;
          roomReservationData.rrRoomAlias         := RoomNumber;
          roomReservationData.rrRoomTypeAlias     := RoomType;
          roomReservationData.useStayTax          := useStayTax;
          roomReservationData.useInNationalReport := useInNationalReport;

          roomReservationData.RoomRentPaid1   := 0.00;
          roomReservationData.RoomRentPaid2   := 0.00;
          roomReservationData.RoomRentPaid3   := 0.00;


          roomReservationData.numGuests   := numGuests;
          roomReservationData.numInfants  := numInfants;
          roomReservationData.numChildren := numChildren;

          roomReservationData.avrageRate  := avrageRate;
          roomReservationData.rateCount   := rateCount;

          roomReservationData.Discount    := avrageDiscount;

          roomReservationData.RoomPrice1      := 0.00;
          roomReservationData.Price1From      := _DateToDBDate(Arrival, false);
          roomReservationData.Price1To        := _DateToDBDate(Departure, false);
          roomReservationData.RoomPrice2      := 0.00;
          roomReservationData.Price2From      := _DateToDBDate(Arrival, false);
          roomReservationData.Price2To        := _DateToDBDate(Arrival, false);
          roomReservationData.RoomPrice3      := 0.00;
          roomReservationData.Price3From      := _DateToDBDate(Arrival, false);
          roomReservationData.Price3To        := _DateToDBDate(Arrival, false);
          roomReservationData.Hallres         := 0;

          ExecutionPlan.AddExec(SQL_INS_RoomReservation(roomReservationData));

    //***Log roomreservation
         try
           lstReservationActivity.add(CreateReservationActivityLog(g.quser
                                                 ,FReservation
                                                 ,roomReservationData.RoomReservation
                                                 ,NEW_ROOMRESERVATION
                                                 ,'' //old value
                                                 ,roomReservationData.Room //New vlaue
                                                 ,'Roomtype :'+roomReservationData.Roomtype+' Status :'+roomReservationData.Status //Moreinfo
                                   ));
         Except
         end;

          invoiceHeadData.RoomReservation := iRoomReservation;
          ExecutionPlan.AddExec(SQL_INS_InvoiceHead(invoiceHeadData));

          // Now Create RoomsDates  for this room
          initRoomsDateHolderRec(roomsDateData);
          roomsDateData.Room                 := RoomNumber;
          roomsDateData.RoomType             := RoomType;
          roomsDateData.RoomReservation      := iRoomReservation;
          roomsDateData.Reservation          := FReservation;
          roomsDateData.ResFlag              := RoomStatus;
          roomsDateData.isNoRoom             := false;  {set value}
          roomsDateData.RoomRentBilled       := 0;
          roomsDateData.RoomDiscountBilled   := 0;
          roomsDateData.ItemsBilled          := 0;
          roomsDateData.ItemsUnbilled        := 0;
          roomsDateData.TaxesBilled          := 0;
          roomsDateData.Paid                 := false;
          roomsDateData.Currency             := FnewRoomReservations.FRoomList[i].FRates.getCurrency;   // 'ISK';  {set value}
          roomsDateData.PriceCode            := PriceCode;

          if copy(RoomNumber, 1, 1) = '<' then
            roomsDateData.isNoRoom := true;

          iDayCount := trunc(Departure) - trunc(Arrival);
          for ii := trunc(Arrival) to trunc(Arrival) + iDayCount - 1 do
          begin
            sDate := _DateToDBDate(ii, false);
            roomsDateData.ADate := sDate;
            RateIndex := FnewRoomReservations.FRoomList[i].FRates.FindRateByDate(ii, 0);



            roomsDateData.isPercentage         := FnewRoomReservations.FRoomList[i].FRates.RateItemsList[RateIndex].GetIsPercentage;   {set value}                                         ;
            roomsDateData.showDiscount         := FnewRoomReservations.FRoomList[i].FRates.RateItemsList[RateIndex].GetShowDiscount;
            roomsDateData.RoomRate             := FnewRoomReservations.FRoomList[i].FRates.RateItemsList[RateIndex].getRate ; {set value}
            roomsDateData.Discount             := FnewRoomReservations.FRoomList[i].FRates.RateItemsList[RateIndex].getDiscount;
            roomsDateData.PriceCode            := FnewRoomReservations.FRoomList[i].FRates.RateItemsList[RateIndex].GetPriceCode;
            roomsDateData.TaxesUnbilled        := 0; {set value}
            roomsDateData.RoomRentUnBilled     := 0; //FnewRoomReservations.FRoomList[i].FRates.RateItemsList[RateIndex].getRate;  //10000;  {set value}
            roomsDateData.RoomDiscountUnBilled := 0;

            ExecutionPlan.AddExec(SQL_INS_RoomsDate(roomsDateData));
          end;

          if RoomStatus = 'B' then
          begin
            numGuests := 1;
          end;

          iLastPerson := strToInt(lstIDs[guestIndex]); //PE_SetNewID();
          inc(guestIndex);

          GuestCompany := Customer;
          GuestType := RoomType;
          GuestInformation := '';
          GuestPID := '';

          initPersonHolder(personData);
          personData.Person := iLastPerson;
          personData.RoomReservation := iRoomReservation;
          personData.Reservation := FReservation;
          personData.name        := copy(MainGuestName,1,100);
          personData.Surname     := copy(reservationName,1,100);

          personData.CompanyName := FHomeCustomer.reservationName;
          personData.CompAddress1 := Address1;
          personData.CompAddress2 := Address2;
          personData.CompZip := Address3;
          personData.CompCity := Address4;
          personData.CompCountry := Country;
          personData.CompTel := FHomeCustomer.Tel1;
          personData.CompEmail := FHomeCustomer.EmailAddress;

          personData.Address1 := ContactAddress1;
          personData.Address2 := ContactAddress2;
          personData.Address3 := ContactAddress3;
          personData.Address4 := ContactAddress4;
//0810-hj           personData.Country := ContactCountry;
          personData.Country := Country;
          personData.PersonsProfilesId := FHomeCustomer.PersonProfileId;

          personData.Tel1 := ContactPhone;
          personData.Tel2 := ContactPhone2;
          personData.Email := ContactEmail;

          personData.Company := GuestCompany;
          personData.GuestType := GuestType;
          personData.Information := GuestInformation;
          personData.PID := GuestPID;
          personData.MainName := true;
          personData.Customer := Customer;
          personData.peTmp := '';
          personData.hgrID := -1;
          personData.HallReservation := -1;


          // FirstGuest
          ExecutionPlan.AddExec(SQL_INS_Person(personData));
           try
             lstReservationActivity.add(CreateReservationActivityLog(g.quser
                                                   ,FReservation
                                                   ,roomReservationData.RoomReservation
                                                   ,CHANGE_NUMBER_OF_GUESTS
                                                   ,'0' //old value
                                                   ,'1' //New vlaue
                                                   ,'Add Main Guest :'+personData.name //Moreinfo
                                     ));
           Except
           end;


          if numGuests > 1 then
          begin
            for ii := 2 to numGuests do
            begin
              iLastPerson := strToInt(lstIDs[guestIndex]); //PE_SetNewID();
              inc(guestIndex);
              personData.Person := iLastPerson;
              personData.name := 'RoomGuest';
              personData.MainName := false;
              personData.PersonsProfilesId := 0;

              // rest of the Guests
              ExecutionPlan.AddExec(SQL_INS_Person(personData));
              try
                lstreservationActivity.add(CreateReservationActivityLog(g.quser
                                                       ,FReservation
                                                       ,roomReservationData.RoomReservation
                                                       ,CHANGE_NUMBER_OF_GUESTS
                                                       ,inttostr(ii-1) //old value
                                                       ,inttostr(ii) //New vlaue
                                                       ,'Add Guest :'+personData.name //Moreinfo
                                         ));
              Except
              end;

            end;
          end;

          if FnewRoomReservations.FRoomList[i].FBreakfast AND (NOT FnewRoomReservations.FRoomList[i].FBreakfastIncluded) then
          begin
            initInvoiceLineHolderRec(InvoicelineData);
            itemId := ctrlGetString('BreakFastItem');
            glb.LocateSpecificRecordAndGetValue('items', 'Item', ItemId, 'Description', itemDescription);
            ItemTypeInfo := d.Item_Get_ItemTypeInfo(itemID);
            Price        := FnewRoomReservations.FRoomList[i].FBreakfastCost;
            numItems     := numGuests * iDayCount;
            Total        := price*numItems;

            fTmp           := Total / (1 + (ItemTypeInfo.VATPercentage / 100));
            Vat            := Total - ftmp;
            TotalWOVat     := Total - VAT;

            decodedate(now, AYear, AMon, ADay);
            invoiceLineData.ItemID          := itemID;
            invoiceLineData.AutoGen         := _db(_GetCurrentTick);
            invoiceLineData.Reservation     := FReservation;
            if FnewRoomReservations.FRoomList[i].FBreakfastCostGroupAccount then
              invoiceLineData.RoomReservation := 0
            else
              invoiceLineData.RoomReservation := iRoomReservation;
            invoiceLineData.PurchaseDate    := date;
            invoiceLineData.InvoiceNumber   := -1;
            invoiceLineData.Description     := itemDescription;
            invoiceLineData.Price           := Price;
            invoiceLineData.Number          := numItems;
            invoiceLineData.VATType         := ItemTypeInfo.VATCode;
            invoiceLineData.Total           := Total;
            invoiceLineData.TotalWOVAT      := totalWOVat;
            invoiceLineData.Vat             := VAT;
            invoiceLineData.CurrencyRate    := 1;
            invoiceLineData.Currency        := g.qNativeCurrency;
            invoiceLineData.ReportDate      := now;
            invoiceLineData.ReportTime      := '00:00';
            invoiceLineData.Persons         := 0;
            invoiceLineData.Nights          := 0;
            invoiceLineData.BreakfastPrice  := 0.00;
            invoiceLineData.AYear           := aYear;
            invoiceLineData.AMon            := aMon;
            invoiceLineData.ADay            := aDay;
            invoiceLineData.ItemCurrency     := g.qNativeCurrency;
            invoiceLineData.ItemCurrencyRate := 1.00;
            invoiceLineData.Discount           := 0.00;
            invoiceLineData.Discount_isPrecent := true;
            invoiceLineData.ImportRefrence     := '';
            invoiceLineData.ImportSource       := '';
            invoiceLineData.Ispackage          := false;
            invoiceLineData.InvoiceIndex          := 0;
            ExecutionPlan.AddExec(SQL_INS_InvoiceLine(invoiceLineData));
            //***Add invoice log here
            try
               lstInvoiceActivity.add(CreateInvoiceActivityLog(g.quser
                                     ,invoiceLineData.Reservation
                                     ,invoiceLineData.RoomReservation
                                     ,invoiceLineData.SplitNumber
                                     ,ADD_LINE
                                     ,invoiceLineData.ItemID
                                     ,invoiceLineData.Total
                                     ,-1
                                     ,invoiceLineData.Description));
            Except
            end;


          end;

          if FnewRoomReservations.FRoomList[i].FExtraBed AND (NOT FnewRoomReservations.FRoomList[i].FExtraBedIncluded) then
          begin
            glb.LocateSpecificRecordAndGetValue('currencies', 'Currency', Currency, 'AValue', CurrencyRate);

            initInvoiceLineHolderRec(InvoicelineData);
            itemId := g.qRoomRentItem;
            itemDescription := GetTranslatedText('shTxExtraBedInvoiceText');
//            glb.LocateSpecificRecordAndGetValue('items', 'Item', ItemId, 'Description', itemDescription);
            ItemTypeInfo := d.Item_Get_ItemTypeInfo(itemID);
            Price        := FnewRoomReservations.FRoomList[i].FExtraBedCost;
            numItems     := 1.00; // numGuests;
            Total        := price*numItems;

            fTmp           := Total / (1 + (ItemTypeInfo.VATPercentage / 100));
            Vat            := Total - ftmp;
            TotalWOVat     := Total - VAT;

            decodedate(now, AYear, AMon, ADay);
            invoiceLineData.ItemID          := itemID;
            invoiceLineData.AutoGen         := _db(_GetCurrentTick);
            invoiceLineData.Reservation     := FReservation;
            if FnewRoomReservations.FRoomList[i].FExtraBedCostGroupAccount then
              invoiceLineData.RoomReservation := 0
            else
              invoiceLineData.RoomReservation := iRoomReservation;
            invoiceLineData.PurchaseDate    := date;
            invoiceLineData.InvoiceNumber   := -1;
            invoiceLineData.Description     := itemDescription;
            invoiceLineData.Price           := Price;
            invoiceLineData.Number          := numItems;
            invoiceLineData.VATType         := ItemTypeInfo.VATCode;
            invoiceLineData.Total           := Total;
            invoiceLineData.TotalWOVAT      := totalWOVat;
            invoiceLineData.Vat             := VAT;
            invoiceLineData.CurrencyRate    := CurrencyRate;
            invoiceLineData.Currency        := Currency;
            invoiceLineData.ReportDate      := now;
            invoiceLineData.ReportTime      := '00:00';
            invoiceLineData.Persons         := 0;
            invoiceLineData.Nights          := 0;
            invoiceLineData.BreakfastPrice  := 0.00;
            invoiceLineData.AYear           := aYear;
            invoiceLineData.AMon            := aMon;
            invoiceLineData.ADay            := aDay;
            invoiceLineData.ItemCurrency     := Currency;
            invoiceLineData.ItemCurrencyRate := CurrencyRate;
            invoiceLineData.Discount           := 0.00;
            invoiceLineData.Discount_isPrecent := true;
            invoiceLineData.ImportRefrence     := '';
            invoiceLineData.ImportSource       := '';
            invoiceLineData.Ispackage          := false;
            invoiceLineData.InvoiceIndex       := 0;
            ExecutionPlan.AddExec(SQL_INS_InvoiceLine(invoiceLineData));
            //***Add invoice log here
            try
               lstInvoiceActivity.add(CreateInvoiceActivityLog(g.quser
                                     ,invoiceLineData.Reservation
                                     ,invoiceLineData.RoomReservation
                                     ,invoiceLineData.SplitNumber
                                     ,ADD_LINE
                                     ,invoiceLineData.ItemID
                                     ,invoiceLineData.Total
                                     ,-1
                                     ,invoiceLineData.Description));
            Except
            end;


          end;
        end;


        if ExecutionPlan.Execute(ptExec, False, True) then
        begin
          if Transactional then
            ExecutionPlan.CommitTransaction
        end else
          raise Exception.Create(ExecutionPlan.ExecException);


        isOk := RV_Exists(FReservation) ;

        FAlertList.Reservation := FReservation;
        FAlertList.postChanges;

        if NOT isOk then
        begin
          inc(CheckCount);
          ExecutionPlan.Clear;
          CreateReservation;
          ExecutionPlan.Execute(ptExec, True, True);
          if NOT RV_Exists(FReservation) then
          begin
            DeleteReservation(FReservation);
            if CheckCount >= 3 then
              raise Exception.Create(format(GetTranslatedText('shTx_ReservationIdNotFound'), [FReservation]));
          end;
        end;

{$Optimization Off}
        d.roomerMainDataSet.SystemAddToDoorCodeSchedules(FReservation);
{$Optimization On}



        for i := 0 to FnewRoomReservations.RoomCount - 1 do
        begin
          if FnewRoomReservations.FRoomList[i].FPackage <> '' then
          begin
            rr :=  FnewRoomReservations.FRoomList[i].FRoomReservation;
            rrAlias := rr;
            if isGroupInvoice then
            begin
              rr  := 0;
            end;
            d.roomerMainDataSet.SystempackagesAdd(
                FnewRoomReservations.FRoomList[i].FPackage,
                rr,
                rrAlias,
                FnewRoomReservations.FRoomList[i].FAvragePrice,
                FnewRoomReservations.FRoomList[i].FRates.getCurrency);
          end;
        end;

        if FHomeCustomer.CreatePersonProfileId then
        begin
          if FnewRoomReservations.RoomCount > 0 then
          begin
            rNewSet := CreateNewDataset;
            try
              if hData.rSet_bySQL(rNewSet, format('SELECT Person FROM persons WHERE MainName=1 AND RoomReservation=%d', [FnewRoomReservations.FRoomList[0].FRoomReservation])) then
              begin
                rNewSet.First;
                iProfileId := CreateNewGuest(glb.PersonProfiles, rNewSet['Person']);
                if iProfileId > 0 then
                  cmd_bySQL(format('UPDATE persons SET PersonsProfilesId=%d WHERE MainName=1 AND Reservation=%d', [iProfileId, FReservation]));
              end;
            finally
              rNewSet.Free;
            end;
          end;
        end;
        result := true
      except
        on e: exception do
        begin
          if Transactional then
            ExecutionPlan.RollbackTransaction;
          showMessage('proc CreateReservations_Roomlist //: '+dateToStr(Arrival)+'//'+MainGuestName+'//'+e.message);
          isOk := True;
          result := false;
        end;
      end;
    until isOk;

    if result then
    begin
      //Write logs
      for i := 0 to lstReservationActivity.Count-1 do
      begin
        try
          if LstReservationActivity[i] <> '' then
               WriteReservationActivityLog(LstReservationActivity[i]);
        Except
        end;
      end;

      for i := 0 to lstInvoiceActivity.Count-1 do
      begin
        try
          if LstInvoiceActivity[i] <> '' then
               WriteInvoiceActivityLog(LstInvoiceActivity[i]);
        Except
        end;
      end;
    end;


  finally
    freeandNil(ExecutionPlan);
    freeandNil(lstIDs);
    freeandNil(lstReservationActivity);
    freeandNil(lstInvoiceActivity);
  end;
end;

procedure TNewReservation.DeleteReservation(Reservation : integer);
var cmdList : TList<String>;
begin
  cmdList := TList<String>.Create;
  cmdList.Add('DELETE from reservations WHERE reservation=' + inttostr(Reservation));
  cmdList.Add('DELETE from roomreservations WHERE reservation=' + inttostr(Reservation));
  cmdList.Add('DELETE from invoiceheads WHERE reservation=' + inttostr(Reservation));

  //**zxhj ATH EKKI breyta resstatus hér
  cmdList.Add('DELETE from roomsdate WHERE reservation=' + inttostr(Reservation));

  cmdList.Add('DELETE from persons WHERE reservation=' + inttostr(Reservation));
  cmdList.Add('DELETE from invoicelines WHERE reservation=' + inttostr(Reservation));
  d.roomerMainDataSet.SystemFreeExecuteMultiple(cmdList)
end;

end.
