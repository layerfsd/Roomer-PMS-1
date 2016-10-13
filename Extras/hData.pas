unit hData;

interface

uses
    SysUtils
  , Classes
  , system.UITypes
  , ADODB
  , DB
  , Dialogs
  , inifiles

  , _Glob
  , uRoomerDefinitions
  , objRoomTypeRoomCount
  , uUtils
  , cmpRoomerDataSet

  , kbmMemTable
  , dxMdaSet
  , System.Generics.Collections
  , uReservationStateDefinitions
  ;

const
  cHotelInvoice = 0;
  cCreditInvoive = 1;
  cCashInvoice = 2;

  cHomeTo = 0;
  cToHome = 1;

  cCancelTypeUnknown = 0;
  cCancelTypeCancel = 1;
  cCancelTypeDelete = 2;

type
  /// <summary>
  /// System sale Items
  /// </summary>
  TItemKind = (
    /// <summary>
    /// Unknown Item type
    /// </summary>
    ikUnknown,

    /// <summary>
    /// Normal item type - not one of following
    /// </summary>
    ikNormal,

    ikRoomRent,

    ikRoomRentDiscount,

    ikBreakfast,

    ikPhoneUse,

    ikPayment,

    ikStayTax);

  TInvoiceTypes = (itPerCustomer, itPerRoomRes, itPerReservation, itSpecificInvoice);

  TPaymentTypes = (ptInvoice, ptDownPayment);

  TActReportAction = (ractNone, ractEdit, ractShow, ractDesign, ractClone);

//  TReservationState = (rsUnKnown, rsReservations, rsGuests, rsDeparting, rsDeparted, rsReserved, rsOverbooked, rsAll, rsCurrent, rsAlotment, rsNoShow,
//    rsBlocked, rsCanceled, rsTmp1, rsTmp2, rsDeleted); // *HJ 140206

  TReservationTypes = (rtUnknown, rtReservations, rtReserved);

  TGuestTypes = (gtNormal, gtUnKnown, gtPriority1, gtPriority2, gtPriority3, gtVIP);

  TKreditType = (ktUnknown, ktDebit, ktKredit);

  TKreditReference = (krUnknown, krManual, krReference);

  TInvoiceType = (itUnknown, itRoom, itGroup, itCash);

  TCurrencyTypes = (ctLocal, ctForeigin);

  TResMedhod = (rmNormal, rmDateRoom, rmDate, rmRoom, rmBlocked);

  TSavedConfirmType = (sctUnKnown, sctTurnover, sctPayment);
  TitemCountType = (ictAsEntered, ictRoomNghts, ictGuestNghts, ictGuests);

type

  recTurnoverAndPaymentsGlobals = record
    Invoicelist: string;
    ConfirmState: integer;
    RoomRentItem: string;
    DiscountItem: String;
    TaxesItem: string;
    RoomRentItemDescription: string;
    DiscountItemDescription: String;
    TaxesItemDescription: string;
    StayTaxPerNight: double;
    UseStayTax: boolean;
    StayTaxIncluted: boolean;
    RoomRentType: string;
    RoomRentTypeDescription: string;
    RoomRentVATCode: string;
    RoomRentVATPercentage: double;
    cTaxType: string;
    cTaxTypeDescription: string;
    cTaxVATCode: string;
    cTaxVATPercentage: double;
    DiscountType: string;
    DiscountTypeDescription: string;
    IsConfirmed: boolean;
    ConfirmedDate: TdateTime;
    totalTurnover: double;
    totalPayments: double;
  end;


  recTurnoverAndPaymentsGlobals_II = record
    Invoicelist: string;
    ConfirmState: integer;
    RoomRentItem: string;
    DiscountItem: String;
    TaxesItem: string;
    RoomRentItemDescription: string;
    DiscountItemDescription: String;
    TaxesItemDescription: string;
    RoomRentType: string;
    RoomRentTypeDescription: string;
    RoomRentVATCode: string;
    RoomRentVATPercentage: double;
    DiscountType: string;
    DiscountTypeDescription: string;
    IsConfirmed: boolean;
    ConfirmedDate: TdateTime;
    totalTurnover: double;
    totalPayments: double;

    cTaxType: string;
    cTaxTypeDescription: string;
    cTaxVATCode: string;
    cTaxVATPercentage: double;


  end;




  // CREATE TABLE `turnoverandpayments` (
  // `id` int(11) NOT NULL AUTO_INCREMENT,
  // `confirmDate` datetime DEFAULT '1900-01-01 00:00:00',
  // `Item` varchar(20) DEFAULT NULL,
  // `Description` varchar(100) DEFAULT NULL,
  // `Amount` double DEFAULT '0',
  // `Staff` varchar(20) DEFAULT NULL,
  // `ItemType` varchar(20) DEFAULT NULL,
  // `ItemTypeDescription` varchar(100) DEFAULT NULL,
  // `itemNotes` varchar(100) DEFAULT NULL,
  // `dataType` int(11) DEFAULT '0',
  // `VatCode` varchar(45) DEFAULT NULL,
  // `VATPercentage` double DEFAULT '0',
  // `VAT` double DEFAULT '0',
  // `Itemcount` int(11) DEFAULT NULL,
  // PRIMARY KEY (`id`)
  // ) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8$$

  recTurnoverAndPaymentsHolder = record
    id: integer; // int(11) NOT NULL AUTO_INCREMENT,
    confirmDate: TdateTime; // datetime DEFAULT '1900-01-01 00:00:00',
    Item: string; // varchar(20) DEFAULT NULL,
    Description: string; // varchar(100) DEFAULT NULL,
    Amount: double; // double DEFAULT '0',
    Staff: string; // varchar(20) DEFAULT NULL,
    ItemType: string; // varchar(20) DEFAULT NULL,
    ItemTypeDescription: string; // varchar(100) DEFAULT NULL,
    itemNotes: string; // varchar(100) DEFAULT NULL,
    dataType: integer; // 0=not known 1=turnover 2=payments
    VatCode: string; // varchar(45) DEFAULT NULL,
    VATPercentage: double; // double DEFAULT '0',
    VAT: string; // double DEFAULT '0',
    Itemcount: integer; // int(11) DEFAULT NULL,
  end;



//  delimiter $$
//
//CREATE TABLE `payments` (
//  `Reservation` int(11) DEFAULT '0',
//  `RoomReservation` int(11) DEFAULT '0',
//  `Person` int(11) DEFAULT '0',
//  `AutoGen` varchar(50) DEFAULT '',
//  `TypeIndex` int(11) DEFAULT '0',
//  `InvoiceNumber` int(11) DEFAULT '0',
//  `PayDate` varchar(10) DEFAULT '',
//  `Customer` varchar(15) DEFAULT '',
//  `PayType` varchar(10) DEFAULT '',
//  `Amount` double DEFAULT '0',
//  `Description` varchar(100) DEFAULT '',
//  `CurrencyRate` double DEFAULT '0',
//  `Currency` varchar(5) DEFAULT '',
//  `ReportDate` varchar(16) DEFAULT '',
//  `ReportTime` varchar(5) DEFAULT '',
//  `Ayear` int(11) DEFAULT '0',
//  `Amon` int(11) DEFAULT '0',
//  `Aday` int(11) DEFAULT '0',
//  `pmTmp` char(3) DEFAULT '',
//  `ID` int(11) NOT NULL AUTO_INCREMENT,
//  `confirmDate` datetime DEFAULT '1900-01-01 00:00:00',
//  `Notes` text,
//  `dtCreated` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
//  PRIMARY KEY (`ID`),
//  UNIQUE KEY `Payments_IX_PaymentsID` (`ID`),
//  KEY `IX_Payments_invoicenumber` (`InvoiceNumber`),
//  KEY `IX_Payments_payDate` (`PayDate`),
//  KEY `Payments_IX_PaymentsTmp` (`pmTmp`)
//) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8$$


  recPaymentHolder = record
    Reservation: integer;
    RoomReservation: integer;
    Person: integer; // Not used
    AutoGen: string;
    TypeIndex: integer; // 0 invoice 1 downpayment
    InvoiceNumber: integer;
    PayDate: string; // 'YYYY-MM-DD'
    Customer: string;
    PayType: string;
    Amount: double;
    Description: string;
    CurrencyRate: double;
    Currency: string;
    ReportDate: string;
    ReportTime: string;
    Ayear: integer;
    Amon: integer;
    Aday: integer;
    pmTmp: string; // (chr(3))
    id: integer;
    confirmDate: TdateTime;
    Notes: string;
    staff: string;
    dtCreated: TdateTime;
    invoiceIndex : Integer;
  end;





  // CREATE TABLE `invoiceheads` (
  // `Reservation` int(11) DEFAULT '0',
  // `RoomReservation` int(11) DEFAULT '0',
  // `SplitNumber` int(11) DEFAULT '0',
  // `InvoiceNumber` int(11) DEFAULT '0',
  // `InvoiceDate` varchar(10) DEFAULT '',
  // `Customer` varchar(15) DEFAULT '',
  // `Name` varchar(100) DEFAULT '',
  // `Address1` varchar(100) DEFAULT '',
  // `Address2` varchar(100) DEFAULT '',
  // `Address3` varchar(100) DEFAULT '',
  // `Address4` varchar(100) DEFAULT '',
  // `Country` varchar(2) DEFAULT '',
  // `Total` double DEFAULT '0',
  // `TotalWOVAT` double DEFAULT '0',
  // `TotalVAT` double DEFAULT '0',
  // `TotalBreakFast` double DEFAULT '0',
  // `ExtraText` longtext,
  // `Finished` tinyint(1) NOT NULL DEFAULT '0',
  // `ReportDate` varchar(10) DEFAULT '',
  // `ReportTime` varchar(5) DEFAULT '',
  // `CreditInvoice` int(11) DEFAULT '0',
  // `OriginalInvoice` int(11) DEFAULT '0',
  // `InvoiceType` int(11) DEFAULT '0',
  // `ihTmp` char(3) DEFAULT '',
  // `ID` int(11) NOT NULL AUTO_INCREMENT,
  // `custPID` varchar(15) DEFAULT '',
  // `RoomGuest` varchar(100) DEFAULT '',
  // `ihDate` datetime DEFAULT NULL,
  // `ihStaff` varchar(5) DEFAULT '',
  // `ihPayDate` datetime DEFAULT NULL,
  // `ihConfirmDate` datetime DEFAULT NULL,
  // `ihInvoiceDate` datetime DEFAULT NULL,
  // `ihCurrency` varchar(5) DEFAULT '',
  // `ihCurrencyRate` double DEFAULT '0',
  // `invRefrence` varchar(30) DEFAULT '',
  // `TotalStayTax` double DEFAULT '0',
  // `TotalStayTaxNights` int(11) DEFAULT '0',
  // PRIMARY KEY (`ID`),
  // UNIQUE KEY `InvoiceHeads_IX_InvoiceHeadsID` (`ID`),
  // KEY `InvoiceHeads_IX_IhInvoiceDate` (`ihInvoiceDate`),
  // KEY `InvoiceHeads_IX_InvoiceDate` (`InvoiceDate`),
  // KEY `IX_InvoiceHeads_confirmdate` (`ihConfirmDate`),
  // KEY `IX_InvoiceHeads_Num_Res` (`InvoiceNumber`,`RoomReservation`),
  // KEY `IX_InvoiceHeads_number_date` (`InvoiceNumber`,`InvoiceDate`),
  // KEY `InvoiceHeads_IX_InvoiceNumber` (`InvoiceNumber`),
  // KEY `InvoiceHeads_IX_Res_Roomres` (`Reservation`,`RoomReservation`)
  // ) ENGINE=InnoDB AUTO_INCREMENT=397502 DEFAULT CHARSET=utf8$$
  //

  recInvoiceHeadHolder = record
    id: integer;
    Reservation: integer; // int
    RoomReservation: integer; // int
    SplitNumber: integer; // int
    InvoiceNumber: integer; // int
    InvoiceDate: string; // nvarchar(10)
    Customer: string; // nvarchar(15)
    name: string; // nvarchar(70)
    Address1: string; // nvarchar(70)
    Address2: string; // nvarchar(70)
    Address3: string; // nvarchar(70)
    Address4: string; // nvarchar(70)
    Country: string; // nvarchar(2)
    Total: double; // double
    TotalWOVAT: double; // double
    TotalVAT: double; // double
    TotalBreakFast: double; // double
    ExtraText: string; // ntext
    Finished: boolean; // bit
    CreditInvoice: integer; // *** int
    OriginalInvoice: integer; // **** int
    InvoiceType: integer; // **** int
    ihTmp: string; // **** char(3)
    custPID: string; // **** nvarchar(15)
    RoomGuest: string; // **** nvarchar(50)
    ihDate: TdateTime; // *** datetime
    ihInvoiceDate: TdateTime; // **** datetime
    ihConfirmDate: TdateTime; // **** datetime
    ihPayDate: TdateTime; // **** datetime
    ihStaff: string; // *** nvarchar(5)
    ihCurrency: string; // **** nvarchar(5)
    ihCurrencyRate: double; // **** double
    ReportDate: string; // **** nvarchar(10)
    ReportTime: string; // **** nvarchar(5))

    invRefrence: string;
    TotalStayTax: double;
    TotalStayTaxNights: integer;
    ShowPackage: boolean;
    Location : string;
    Staff  : string;
  end;

  recInvoiceLineHolder = record
    AutoGen: string; // nvarchar(50)
    Reservation: integer; // int
    RoomReservation: integer; // int
    SplitNumber: integer; // int
    ItemNumber: integer; // int
    PurchaseDate: TdateTime; // nvarchar(10)
    InvoiceNumber: integer; // int
    ItemID: string; // nvarchar(10)
    Number: double; // int  //-96
    Description: string; // nvarchar(70)
    Price: double; // double
    VATType: string; // nvarchar(10)
    Total: double; // double
    TotalWOVAT: double; // double
    VAT: double; // double
    AutoGenerated: boolean; // bit
    CurrencyRate: double; // double
    Currency: string; // nvarchar(5)
    ReportDate: TdateTime; // nvarchar(10)
    ReportTime: string; // nvarchar(5)
    Persons: integer; // int
    Nights: integer; // int
    BreakfastPrice: double; // double
    Ayear: integer;
    Amon: integer;
    Aday: integer;
    ilTmp: string; // char(3)
    ilID: integer; // AUTOGEN
    ilAccountKey: string; // nvarchar(20)
    ItemCurrency: string;
    ItemCurrencyRate: double;
    Discount: double;
    Discount_isPrecent: boolean;
    ImportRefrence: string;
    ImportSource: string;
    IsPackage: boolean;
    confirmDate: TdateTime;
    confirmAmount: double;

    ItemAdded : TdateTime;
    RoomreservationAlias : Integer;
    InvoiceIndex : Integer;
    RevenueCorrection: double;
  end;

  recItemPlusHolder = record
    // Items
    Item: string; // MAX 10
    Description: string; // MAX 30
    Price: double;
    ItemType: string; // MAX 5
    AccountKey: string;
    Hide: boolean;
    SystemItem: boolean;
    RoomRentItem: boolean;
    ReservationItem: boolean;
    Currency: string;

    // ItemTypes
    ItemTypeDescription: string; // MAX 30
    VatCode: string; // MAX 10
    AccItemLink: string; // MAX 20

    // VatCodes
    VATCodeDescription: string; // MAX 30
    VATPercentage: double;
    VATformula: string;
    // Control
    ItemKind: TItemKind;
  end;

  recImportLogsHolder = record
    id: integer;
    DateInsert: TdateTime;
    ImportTypeID: integer;
    ImportData: string;
    ImportResultID: integer;
    Reservation: integer;
    RoomReservation: integer;
    Customer: string;

    DateExport: TdateTime;
    Itemcount: integer;
    HotelCode: string;
    Staff: string;
    RoomNumber: string;
    isGroupInvoice: boolean;
    invCustomer: string;
    invPersonalID: string;
    invCustomerName: string;
    invAddress1: string;
    invAddress2: string;
    invAddress3: string;
    invAddress4: string;
    GuestName: string;
    SaleRefrence: string;
    InvoiceNumber: integer;
  end;

  recRoomReservationHolder = record
    id: integer;
    RoomReservation: integer;
    Room: string;
    Reservation: integer;
    Status: string;
    GroupAccount: boolean;
    invBreakfast: boolean;
    RoomPrice1: double;
    Price1From: string;
    Price1To: string;
    RoomPrice2: double;
    Price2From: string;
    Price2To: string;
    RoomPrice3: double;
    Price3From: string;
    Price3To: string;
    Currency: string;
    Discount: double;
    Percentage: boolean;
    PriceType: string;
    Arrival: string;
    Departure: string;
    RoomType: string;
    PMInfo: string;
    HiddenInfo: string;
    RoomRentPaid1: double;
    RoomRentPaid2: double;
    RoomRentPaid3: double;
    RoomRentPaymentInvoice: integer;
    Hallres: integer;

    rrTmp: string;
    rrDescription: string;
    rrArrival: Tdate;
    rrDeparture: Tdate;
    rrIsNoRoom: boolean;
    rrRoomAlias: string;
    rrRoomTypeAlias: string;
    UseStayTax: boolean;

    CancelDate: TdateTime;
    CancelStaff: string;
    CancelReason: string;
    CancelInformation: string;
    CancelType: integer;
    UseInNationalReport: boolean;

    numGuests: integer;
    numChildren: integer;
    numInfants: integer;

    avrageRate: double;
    rateCount: integer;

    package: string;
    BlockMove : Boolean;
    BlockMoveReason : String;

    ManualChannelId : Integer;
    ratePlanCode : String;

    ExpectedTimeOfArrival: string;
    ExpectedCheckoutTime: string;
  end;

  recReservationHolder = record
    Reservation: integer;
    Arrival: string;
    Departure: string;
    Customer: string;
    name: string;
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

    Status: string;
    ReservationDate: string;
    Staff: string;
    Information: string;
    PMInfo: string;
    HiddenInfo: string;
    RoomRentPaid1: double;
    RoomRentPaid2: double;
    RoomRentPaid3: double;
    RoomRentPaymentInvoice: integer;
    ContactName: string;
    ContactPhone: string;
    ContactPhone2: string;
    ContactFax: string;
    ContactEmail: string;
    ContactAddress1: string;
    ContactAddress2: string;
    ContactAddress3: string;
    ContactAddress4: string;
    ContactCountry: string;
    ContactIsmainGuest: boolean;

    inputsource: string;
    webconfirmed: string;
    arrivaltime: string;
    srcrequest: string;
    rvTmp: string;
    custPID: string;
    invRefrence: string;
    marketSegment: string;
    UseStayTax: boolean;
    Channel: integer;

    OutOfOrderBlocking : Boolean;
    Market: TReservationMarketType;
  end;

  recRoomsDateHolder = record
    id: integer;
    ADate: string;
    Room: string;
    RoomType: string;
    RoomReservation: integer;
    Reservation: integer;
    ResFlag: string;
    rdTmp: string;
    updated: boolean;
    isNoRoom: boolean;
    RoomRentBilled: double;
    RoomRentUnBilled: double;
    RoomDiscountBilled: double;
    RoomDiscountUnBilled: double;
    ItemsBilled: double;
    ItemsUnbilled: double;
    TaxesBilled: double;
    TaxesUnbilled: double;
    PriceCode: string; // nvarchar(10)	Checked
    RoomRate: double;
    Discount: double;
    isPercentage: boolean;
    showDiscount: boolean;
    Paid: boolean;
    Currency: string;
  end;

  {
  `state` varchar(10) DEFAULT NULL,
  `sourceId` varchar(10) DEFAULT NULL COMMENT 'Id from source channel, i.e. RPH',
  `PersonalIdentificationId` varchar(50) DEFAULT '',
  `DateOfBirth` datetime DEFAULT '1900-01-01 00:00:00',
  `SocialSecurityNumber` varchar(45) DEFAULT NULL,
  `confirmDate` datetime DEFAULT NULL,
  `lastUpdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  }



  recPersonHolder = record
    id: integer;   {}
    Person: integer;  {}
    RoomReservation: integer;
    Reservation: integer;

    PersonsProfilesId : Integer; {New}
    title : string; {New}
    name: string;
    Surname: string;
    Address1: string;
    Address2: string;
    Address3: string;
    Address4: string;
    Country: string;

    Tel1: string;
    Tel2: string;
    Fax: string;
    Email: string;

    GuestType: string;
    Information: string;

    Nationality : string; {New}
    PID: string;
    MainName: boolean;

    Customer: string;

    Company        : string;           //   `Company` varchar(100) DEFAULT '',
    CompanyName    : string;           //   `CompanyName` varchar(100) DEFAULT NULL,
    CompAddress1   : string;           //   `CompAddress1` varchar(100) DEFAULT NULL,
    CompAddress2   : string;           //   `CompAddress2` varchar(100) DEFAULT NULL,
    CompZip        : string;           //   `CompZip` varchar(45) DEFAULT NULL,
    CompCity       : string;           //   `CompCity` varchar(100) DEFAULT NULL,
    CompCountry    : string;           //   `CompCountry` varchar(2) DEFAULT NULL,
    CompTel        : string;           //   `CompTel` varchar(40) DEFAULT NULL,
    CompEmail      : string;           //   `CompEmail` varchar(255) DEFAULT NULL,

    CompFax        : string;           //   `CompFax` varchar(40) DEFAULT NULL,
    CompVATNumber  : string;           //   `CompVATNumber` varchar(45) DEFAULT NULL,

    peTmp          : string;
    hgrID          : integer;
    HallReservation: integer;

    state                    : string;
    sourceId                 : String;
    PersonalIdentificationId : string;
    DateOfBirth              : TdateTime;
    SocialSecurityNumber     : string;
    confirmDate              : TdateTime;
    lastUpdate               : TdateTime;
  end;

  recResInfo = record
    Reservation: integer;

    bookingDate: TdateTime;
    bookingStaff: string;

    RoomCount: integer;
    NoRoomCount: integer;

    GuestCount: integer;

    ClosedInvoiceCount: integer;
    ClosedInvoiceLineCount: integer;
    ClosedInvoiceAmount: double;

    closedInvoiceRentCount: integer;
    closedInvoiceRentAmount: double;

    closedInvoiceItemCount: integer;
    closedInvoiceItemAmount: double;

    openInvoiceRentCount: integer;
    openInvoiceRentAmount: double;

    openInvoiceItemCount: integer;
    openInvoiceItemAmount: double;
  end;

  recTelLogHolder = Record
    id: integer;
    LogDateTime: TdateTime; // smalldatetime
    RecordSource: string; // *********        nvarchar(50)
    CallId: integer; // int
    CallStart: TdateTime; // smalldatetime
    ConnectedTime: string; // char(8)
    ConnectedTimeSec: integer; // int
    RingTime: integer; // int
    Caller: string; // nvarchar(50)
    Direction: string; // char(1)
    IsInternal: boolean; // bit
    CalledNumber: string; // nvarchar(100)
    DialledNumber: string; // nvarchar(100)
    Account: string; // nvarchar(50)
    Continuation: boolean; // bit
    Party1Device: string; // nvarchar(20)
    Party1Name: string; // nvarchar(50)
    Party2Device: string; // nvarchar(20)
    Party2Name: string; // nvarchar(50)
    HoldTime: integer; // int
    ParkTime: integer; // int
    AuthValid: boolean;
    AuthCode: string; // ********* nvarchar(50)
    UserCharged: string; // ********* nvarchar(50)
    CallCharge: double;
    Currency: string; // ********* nvarchar(10)
    AmountAtLastUserChange: double;
    CallUnits: integer;
    UnitsAtLastUserChange: integer;
    CostPerUnit: integer;
    MarkUp: integer;
    ExternalTargetingCause: string; // ********* nvarchar(20)
    ExternalTargeterId: string; // ********* nvarchar(50)
    ExternalTargetedNumber: string; // ********* nvarchar(50)

    Room: string; // nvarchar(15)
    Description: string; // nvarchar(50)
    Reservation: integer; // int
    RoomReservation: integer; // int
    InvoiceNumber: integer; // int
    PriceRule: string; // nvarchar(15)
    PriceGroup: string; // nvarchar(15)
    minutePrice: double; // float
    startPrice: double; // float
    chargedTime: integer; // int
    ChargedAmount: double; // float
    ImportRefrence: string; // nvarchar(15)

  end;

  recRoomReservationRentHolder = record
    RoomReservation: integer;
    Reservation: integer;
    PriceType: string;
    avrageRate: double;
    Currency: string;
    Discount: double;
    Percentage: boolean;
  end;

  recRoomsDateRentInfo = record
    RoomReservation: integer;
    Reservation: integer;
    ResFlag: string;
    isNoRoom: boolean;
    PriceCode: String;
    Currency: string;
    Discount: double;
    isPercentage: boolean;
    showDiscount: boolean;
    Rate: double;
    isGroupAccount: boolean;

    // Cacluated
    TotalRoomRent: double;
    TotalDiscount: double;
    RentDays: integer;
  end;

  recRoomInfo = record
    Room: string; // nvarchar(8)	Unchecked
    Description: string; // nvarchar(30)	Unchecked
    RoomType: string; // nvarchar(5)	Unchecked

    Bath: boolean; // bit	Unchecked
    Shower: boolean; // bit	Unchecked
    Safe: boolean; // bit	Unchecked
    TV: boolean; // bit	Unchecked
    Video: boolean; // bit	Unchecked
    Radio: boolean; // bit	Unchecked
    CDPlayer: boolean; // bit	Unchecked
    Telephone: boolean; // bit	Unchecked
    Press: boolean; // bit	Unchecked
    Coffee: boolean; // bit	Unchecked
    Kitchen: boolean; // bit	Unchecked
    Minibar: boolean; // bit	Unchecked
    Fridge: boolean; // bit	Unchecked
    Hairdryer: boolean; // bit	Unchecked
    InternetPlug: boolean; // bit	Unchecked
    Fax: boolean; // bit	Unchecked

    SqrMeters: double; // float	Checked
    BedSize: string; // nvarchar(1)	Checked
    Equipments: string; // nvarchar(100)	Checked
    Bookable: boolean; // bit	Unchecked
    Statistics: boolean; // bit	Unchecked
    Status: string; // nvarchar(1)	Checked
    OrderIndex: integer; // int	Checked
    hidden: boolean; // bit	Unchecked
    Location: string; // nvarchar(10)	Checked
    Floor: integer; // int	Checked
    id: integer; // int	Unchecked
    Dorm: string; // nvarchar(20)	Checked

    RoomTypeDescription: string;
    RoomTypeNumberGuests: integer;

    RoomTypeGroup: string;
    RoomTypeGroupDescription: string;

    LocationDescription: string;
  end;

  recCountryGroupHolder = record
    CountryGroup: string;
    GroupName: string;
    islGroupName: string;
    OrderIndex: integer;
    tmp: string;
  end;

  recChannelManagerHolder = record
    id: integer;
    Code: String;
    Description: string;
    webserviceURI: String;
    serviceUsername: string;
    servicePassword: string;
    webserviceHotelCode: String;
    serviceRequestorID: String;

    active: boolean;
    sendRate: boolean;
    sendAvailability: boolean;
    sendStopSell: boolean;
    sendMinStay: boolean;

    portalAdminUsername: String;
    portalAdminPassword: String;
    channels: String;

    tmp: string;
    maintenanceDays: integer;
    directConnection: boolean;
  end;

  recCountryHolder = record
    Country: string;
    CountryName: string;
    IslCountryName: string;
    Currency: string;
    CountryGroup: string;
    OrderIndex: integer;
    CurrenciesDescription: string; // from table currencies
    CountryGroupsGroupName: string; // from table CountruGroups
    id: integer;
    active: boolean;

    tmp: string; //
  end;

  recCurrencyHolder = record
    id: integer;
    Currency: string;
    Description: string;
    Value: double;
    SellValue: double;
    active: boolean;
    Decimals: integer;
    Displayformat: string;
    CurrencySign: string;
    procedure Init;
    procedure ReadFromDataset(aRSet: TDataset);
  end;

  recConvertHolder = record
    cvID: integer;
    cvType: string; // 10
    cvFrom: string; // 50
    cvTo: string; // 50
    active: boolean;

    tmp: integer;
  end;

  recConvertGroupHolder = record
    id: integer;
    cgCode: string; // 10
    cgDescription: string; // 50
    active: boolean;
    tmp: integer end;

    recPayGroupHolder = record id: integer;
    payGroup: string; // 5
    Description: string; // 30
    active: boolean;
    cash: boolean;
    tmp: string end;

    recPhoneRateHolder = record
      id: Integer;
      Identification : String;
      description: String; // 70
      minuteRate: Double;
      minimumCost: Double;
    end;


    recPayTypeHolder = record id: integer;
    PayType: string; // nvarchar(10)
    Description: string; // nvarchar(30)	Unchecked
    payGroup: string; // nvarchar(5)	Checked
    AskCode: boolean; // bit	Unchecked
    ptDays: integer; // int	Checked
    doExport: boolean; // bit	Checked
    active: boolean;
    bookKey: string;
    BookKeepCode : String;

    tmp: string;
  end;

  recCityTaxResultHolder = Record
    Incluted            : boolean;
    RentAmount          : double;
    RentAmountVAT       : double;

    CityTax            : double;
    CityTaxVAT         : double;
  end;


  recVatCodeHolder = record
    VatCode: string; // nvarchar(10)	Checked
    Description: string; // nvarchar(30)	Checked
    VATPercentage: double; // float	Checked
    valueFormula: string; // nvarchar(255)	Checked
    BookKeepCode : String;
    tmp: string;
  end;

  recChannelPlanCodeHolder = record
    Code: string; // nvarchar(10)	Checked
    Description: string; // nvarchar(30)	Checked
    active: boolean;
    defaultPlan: boolean;
    tmp: string;
  end;

  recPriceTypeHolder = record
    id: integer; // int
    seasonId: integer; // int
    priceCodeID: integer; // int
    RoomType: string; // char(10)
    Currency: string; // nvarchar(5)
    Description: string; // nvarchar(60)
    Price1Person: double; // float
    Price2Persons: double; // float
    Price3Persons: double; // float
    Price4Persons: double; // float
    Price5Persons: double; // float
    Price6Persons: double; // float
    PriceExtraPerson: double; // float
    RoundType: integer; // int
    RoundStartAt: integer; // int
    PriceType: string; // nvarchar(50)
    active: boolean; // bit
  end;

  recPriceCodeHolder = record
    id: integer; // int
    pcCode: string; // nvarchar(10)
    pcDescription: string; // nvarchar(50)
    pcActive: boolean; // bit
    pcRack: boolean; // bit
    pcRackCalc: double; // float
    pcShowDiscount: boolean; // bit
    pcDiscountText: String; // nvarchar(50)
    pcAutomatic: boolean; // bit
    pcLastUpdate: TdateTime; // datetime
    pcDiscountMethod: integer; // tinyint
    pcDiscountPriceAfter: double; // float
    pcDiscountDaysAfter: integer; // int
    active: boolean; // bit

    tmp: string;
  end;

  // roomer.is

  recCustomerHolderEX = record
    Customer: string; // Customer     : string;
    CustomerName: string; // CustomerName : string;
    DisplayName: string; // DisplayName  : string;
    PID: string; // PID          : string;
    Address1: string; // Address1     : string;
    Address2: string; // Address2     : String;
    Address3: string; // Address3     : string;
    Address4: string; // Address4     : string;
    Tel1: string; // Tel1 : string;
    Tel2: string; // Tel2 : string;
    Fax: string; // Fax  : string;
    CountryName: string; // CountryName : string;
    Country: string; // Country     : string;
    MarketSegmentName: string; // MarketSegmentName  : String;
    MarketSegmentCode: string; // MarketSegmentCode  : string;
    DiscountPerc: double; // DiscountPerc : double;
    ShowDiscountPercOnInvoice: string; // ShowDiscountPercOnInvoice : string;
    EmailAddress: string; // EmailAddress : string;
    HomePage: string; // HomePage : string;
    ContactPerson: string; // ContactPerson : string;
    ContactEmail: string; // ContactEmail : string;
    ContactPhone: string; // ContactPhone : string;
    ContactFax: string; // ContactFax : string;
    isTravelAgency: boolean; // isTravelAgency : boolean;
    Currency: string; // Currency : string;
    CustMemoText: string; // CustMemoText : string;
    priceCodeID: integer; // priceCodeId   : integer;
    pcCode: string; // pcCode : string;  //*
    isReservation: boolean; // isReservation   : boolean;
    ReservationName: string; // ReservationName : string;
    GuestName: string; // GuestName       : string;
    roomStatus: string; // roomStatus      : string;
    ReservationPaymentInfo: string; // ReservationPaymentInfo : string;
    ReservationGeneralInfo: string; // ReservationGeneralInfo : string;
    isGroupInvoice: boolean; // isGroupInvoice         : boolean;
    StayTaxIncluted: boolean;
    notes : string;
    RatePlanId : Integer;
  end;

  // added 2013-02-28 HJ
  recRateRuleHolder = record
    id: integer;
    Description: string;
    active: boolean;
    ApplyToDates: string;
    ApplyToSeasons: string;
    ApplyToRoomTypes: string;
    ApplyToRoomGroups: string;
    ApplyToRooms: string;
    Rules: string;
  end;

  recRoomRateHolder = record
    id: integer;
    priceCodeID: integer;
    RateID: integer;
    seasonId: integer;
    RoomTypeID: integer;
    CurrencyID: integer;
    active: boolean;
    DateFrom: TdateTime;
    DateTo: TdateTime;
    Description: string;
    DateCreated: TdateTime;
    LastModified: TdateTime;
  end;

  recRateHolder = record
    id: integer;
    active: boolean;
    Currency: string;
    Description: string;
    Rate1Person: double;
    Rate2Persons: double;
    Rate3Persons: double;
    Rate4Persons: double;
    Rate5Persons: double;
    Rate6Persons: double;
    RateExtraPerson: double;
    RateExtraChildren: double;
    RateExtraInfant: double;
    isDefault: boolean;
  end;

  recTaxesHolder = record
    id: integer;
    Description: string;
    Hotel_Id: String;
    Tax_Type: String;
    Tax_Base: String;
    Time_Due: String;
    ReTaxable: String;
    TaxChildren: string;
    Booking_Item_Id: integer;
    Booking_Item: String;
    Amount: double;
    Incl_Excl: String;
    NETTO_AMOUNT_BASED: String;
    VALUE_FORMULA: String;
    VALID_FROM : TDateTime;
    VALID_TO : TDateTime;
  end;

  recwRoomRateHolder = record
    id: integer;
    priceCodeID: integer;
    pcCode: string;
    pcRack: boolean;
    CurrencyID: integer;
    Currency: string;
    seasonId: integer;
    seStartDate: TdateTime;
    seEndDate: TdateTime;
    seDescription: string;
    RoomTypeID: integer;
    RoomType: string;
    NumberGuests: integer;
    RateID: integer;
    RateCurrency: string;
    Rate1Person: double;
    Rate2Persons: double;
    Rate3Persons: double;
    Rate4Persons: double;
    Rate5Persons: double;
    Rate6Persons: double;
    RateExtraPerson: double;
    RateExtraChildren: double;
    RateExtraInfant: double;
    Description: string;
    DateCreated: TdateTime;
    LastModified: TdateTime;
    active: boolean;
    DateFrom: TdateTime;
    DateTo: TdateTime;
  end;

  recRoomTypeHolder = record
    id: integer;
    active: boolean;
    RoomType: string;
    Description: string;
    NumberGuests: integer;
    PriceType: string; // outdated field
    Webable: boolean;
    RoomTypeGroup: string;
    color: string;
    PriorityRule: string;
    location : string;
  end;

  recRoomTypeGroupHolder = record
    id: integer;
    active: boolean;
    Code: string;
    TopClass: string;
    Description: string;
    PriorityRule: string;
    numGuests: integer;
    MaxCount: integer;
    minGuests: integer;
    maxGuests: integer;
    maxChildren: integer;
    BreakfastIncluded: boolean;
    HalfBoard: boolean;
    FullBoard: boolean;
    color: String;
    AvailabilityTypes: String;
    defRate: double;
    defAvailability: integer;
    defStopSale: boolean;
    defMinStay: integer;
    defMaxStay : Integer;
    defClosedToArrival,
    defClosedToDeparture : Boolean;
    defMaxAvailability: integer;
    NonRefundable: boolean;
    AutoChargeCreditcards: boolean;
    RateExtraBed: double;
    PhotoUri: String;
    sendAvailability: boolean;
    sendRate: boolean;
    sendStopSell: boolean;
    sendMinStay: boolean;

    DetailedDescriptionHtml: String;

    DetailedDescription: String;

    package: String;

    OrderIndex: integer;

    connectRateToMasterRate: boolean;
    masterRateRateDeviation: double;
    RateDeviationType: String;
    connectSingleUseRateToMasterRate: boolean;
    masterRateSingleUseRateDeviation: double;
    singleUseRateDeviationType: String;
    connectStopSellToMasterRate: boolean;
    connectAvailabilityToMasterRate: boolean;
    connectMinStayToMasterRate: boolean;
    connectMaxStayToMasterRate: boolean;
    connectCOAToMasterRate: boolean;
    connectCODToMasterRate: boolean;
    connectLOSToMasterRate: boolean;

    RATE_PLAN_TYPE: String;

    prepaidPercentage : Double;
  end;

  recSeasonHolder = record
    id: integer;
    active: boolean;
    seDescription: string;
    seStartDate: TdateTime;
    seEndDate: TdateTime;
  end;

  recItemTypeHolder = record
    id: integer;
    active: boolean;
    Description: string; // MAX 30
    ItemType: string; // MAX 5
    VatCode: string; // MAX 10
    AccItemLink: string; // MAX 20
    tmp: integer;
  end;

  recCleaningNotesHolder = record
    id: integer;
    active: boolean;
    onlyWhenRoomIsDirty : Boolean;
    serviceType: string;
    onceType: string;
    interval: Integer;
    minimumDays: Integer;
    smessage: String;
  end;

  recItemHolder = record
    id: integer;
    active: boolean;
    Description: string;
    Item: string;
    Price: double;
    ItemType: string;
    AccountKey: string;
    MinibarItem: boolean;
    BreakfastItem : boolean;
    SystemItem: boolean;
    RoomRentItem: boolean;
    ReservationItem: boolean;
    Hide: boolean;
    Currency: string;
    BookKeepCode : String;
    NumberBase : String;
    Stockitem: boolean;
    TotalStock: integer;
    AvailabilityFrom: TDateTime;
    AvailabilityTo: TDateTime;
    RoomReservation: integer; // used to ignore usage of stockitem of current roomreservation when calculating availablestock
    // Missing fields to create
    // ItemTypeID
    // CurrencyID
  end;

  recStockItemCountHolder = record
    ItemID: integer;
    StockCount: integer;
  end;

  recStockItemPricesHolder = record
    ID: integer;
    ItemID: integer;
    FromDate: TDate;
    price: double;
  end;

  recDayNotesHolder = record
    id: integer;
    User: String;
    Notes: string;
    ADate: TDate;
    AAction: String;
    LastChangedBy: String;
    LastUpdate: TDateTime;
  end;

  TrecItemHolder = class
    recHolder : recItemHolder;
  public
    constructor Create; overload;
    constructor Create(arecItem: recItemHolder); overload;
  end;

  TrecItemHolderList = class(TObjectList<TrecitemHolder>)
  public
    procedure AddrecItem(aRecItem: recitemHolder);
  end;

  recLocationHolder = record
    id: integer;
    active: boolean;
    Description: string;
    Location: string;
    channelManager: integer;
    channelManagerName: String;
    AccountDepartment : string
  end;

  recRoomHolder = record
    id: integer;
    active: boolean;
    Description: string;
    Room: string;
    RoomType: string;
    Location: string;
    wildcard: boolean;
    Bath: boolean;
    Shower: boolean;
    Safe: boolean;
    TV: boolean;
    Video: boolean;
    Radio: boolean;
    CDPlayer: boolean;
    Telephone: boolean;
    Press: boolean;
    Coffee: boolean;
    Kitchen: boolean;
    Minibar: boolean;
    Fridge: boolean;
    Hairdryer: boolean;
    InternetPlug: boolean;
    Fax: boolean;
    SqrMeters: integer;
    BedSize: string;
    Equipments: string;
    Bookable: boolean;
    Statistics: boolean;
    Status: string;
    OrderIndex: integer;
    hidden: boolean;
    Floor: integer;
    Dorm: string;
    UseInNationalReport: boolean;
  end;

  recCustomerTypeHolder = record
    id: integer;
    active: boolean;
    Description: string;
    customerType: string;
    Priority: integer;
  end;

  recCustomerHolder = record
    id: integer;
    active: boolean;
    Customer: string;
    Surname: string;
    name: string;
    PID: string;
    customerType: string;
    Address1: string;
    Address2: string;
    Address3: string;
    Address4: string;
    Country: string;
    Tel1: string;
    Tel2: string;
    Fax: string;
    DiscountPercent: double;
    EmailAddress: string;
    ContactPerson: string;
    TravelAgency: boolean;
    Currency: string;
    dele: string;
    pcID: integer;
    HomePage: string;
    CountryName: string;
    CustomerTypeDescription: string;
    pcCode: string;
    StayTaxIncluted: boolean;
    Notes : string;
    RatePlanId : Integer;
  end;

  recStaffTypeHolder = record
    id: integer;
    active: boolean;
    Description: string;
    StaffType: string;
    AccessPrivilidges: integer;
    AuthValue: integer;
  end;

  recStaffMemberHolder = record
    id: integer;
    active: boolean;
    Initials: string;
    Password: string;
    StaffPID: string;
    name: string;
    Address1: string;
    Address2: string;
    Address3: string;
    Address4: string;
    Country: string;
    Tel1: string;
    Tel2: string;
    Fax: string;
    ActiveMember: boolean;
    StaffLanguage: integer;
    StaffType: string;
    StaffType1: string;
    StaffType2: string;
    StaffType3: string;
    StaffType4: string;

    IPAddresses: string;
    WindowsAuth: boolean;
    PmsOnly: boolean;
  end;

  recChannelHolder = record
    id: integer;
    active: boolean;
    name: string;
    channelManagerId: string;
    minAlotment: integer;
    defaultAvailability: integer;
    defaultPricePP: double;
    marketSegment: string;
    CurrencyID: integer;
    managedByChannelManager: boolean;
    CHANNEL_ARRANGES_PAYMENT: boolean;
    defaultChannel: boolean;
    push: boolean;
    customerId: integer;
    color: String;
    Rounding: integer;
    hotelsBookingEngine: boolean;
    compensationPercentage: double;

    roomClasses: String; // Not in table
    Currency: string; // Not in table
    directConnection: boolean;
    activePlanCode :Integer;
    ratesExcludingTaxes : Boolean;
  end;

  recSystemServerHolder = record
    id: integer;
    active: boolean;
    Description: string; // 30
    server: string; // 128
    port: integer;
    username: string; // 64
    Password: string; // 128
    authenticate: boolean;
    ssl: boolean;
  end;

  recSystemActionHolder = record
    id: integer;
    active: boolean;
    Description: string; // 30
    aType: integer;
    systemserver: integer;
    recipient: string; // 128
    sender: string; // 128
    // subject                : string  ; //4096
    // content                : string  ; //4096
    // richcontent            : boolean ;
    // contentfile            : string  ;

    server: string;
  end;

  recSystemTriggerHolder = record
    id: integer;
    active: boolean;
    Description: string; // 30
    aType: integer;
    systemAction: integer;
    ActionDescription: string;
  end;

  recPackageHolder = record
    id: integer;
    active: boolean;
    Description: string;
    package: string;
    CurrencyID: integer;
    showItemsOnInvoice: boolean;

    Currency: string;
    invoiceText: String;

  end;

  recPackageItemHolder = record
    id: integer;
    Description: string; // 45
    numItems: integer;
    unitPrice: double;
    packageId: integer; // link to pagage tablee
    ItemID: integer; // link to itemTable
    numItemsMethod: integer;
    IncludedInRate: boolean;
    valueFormula: String;
    unitPriceVatFormula: String;

    Item: string; // 20
    itemDescription: string; // 30
    itemPrice: double;

    packageDescription: string;
  end;


  // recPersonVipTypesHolder = record
  // recPersonContactTypeHolder = record

  recPersonContactTypeHolder = record
    id: integer;
    Code: string; // nvarchar(5)	Checked
    Description: string; // nvarchar(45)	Checked
    SysType: integer; // integer
    active: boolean;
    tmp: string;
  end;

  recPersonVipTypesHolder = record
    id: integer;
    Code: string; // nvarchar(5)	Checked
    Description: string; // nvarchar(35)	Checked
    vipGrade: integer; // integer
    active: boolean;
    tmp: string;
  end;

  recLostAndFoundHolder = record
    id                  : integer;
    DateFound           : TdateTime;
    itemDescription     : string;
    locationDescription : string;
    returnedToOwner     : boolean;
    returnedNotes       :  string;
  end;




var
  oRoomTypeRoomCount: TRoomTypeRoomCount;

  // function test : boolean;

function rSet_bySQL(rSet: TRoomerDataSet; sSQL: string; doLowerCase: boolean = true; SetLastAccess : Boolean = True): boolean;
function cmd_bySQL(sSQL: string; performFilterTableNames : Boolean = True; async : Boolean = False): boolean;

function S_execute(var rSet: TRoomerDataSet; ProcName: string; var lstParams: TstringList): boolean;
function S_Command(ProcName: string; var lstParams: TstringList): boolean;
function S_CommandWithErrMessage(ProcName: string; var lstParams: TstringList; var ErrMessage: string): boolean;

procedure initInvoiceLineHolderRec(var rec: recInvoiceLineHolder);
procedure initTurnoverAndPaymentsGlobals(var rec: recTurnoverAndPaymentsGlobals);

//Use just in turnover and payments2
procedure initTurnoverAndPaymentsGlobals_II(var rec: recTurnoverAndPaymentsGlobals_II);

// invoiceheads
procedure initInvoiceHeadHolderRec(var rec: recInvoiceHeadHolder);
function SP_INS_InvoiceHead(theData: recInvoiceHeadHolder): boolean;
function SQL_INS_InvoiceHead(theData: recInvoiceHeadHolder): string;
procedure DxMemDataToInvoiceHeadHolderRec(dxMemData: TDxMemData; var rec: recInvoiceHeadHolder);
procedure InvoiceHeadHolderRecToDxMemData(dxMemData: TDxMemData; rec: recInvoiceHeadHolder);

// Payments
procedure initPaymentHolderRec(var rec: recPaymentHolder);
function SQL_INS_Payment(theData: recPaymentHolder): string;
function INS_Payment(theData: recPaymentHolder; var NewID: integer): boolean;
procedure DxMemDataToPaymentHolderRec(dxMemData: TDxMemData; var rec: recPaymentHolder);
procedure PaymentHolderRecToDxMemData(dxMemData: TDxMemData; rec: recPaymentHolder);

procedure initItemPlusHolder(var rec: recItemPlusHolder);

procedure initReservationHolderRec(var rec: recReservationHolder; aStaff: string);
procedure initRoomReservationHolderRec(var rec: recRoomReservationHolder);

procedure initRoomsDateHolderRec(var rec: recRoomsDateHolder);

function SQL_INS_RoomsDate(theData: recRoomsDateHolder): string;

function INS_RoomsDate(theData: recRoomsDateHolder): boolean;

procedure AddRoomsDate(ADate: TdateTime; Room, RoomType, ResFlag, Currency: string;

  priceID: integer;

  GuestCount, ChildCount, infantCount: integer;

  Discount: double; isPercentage, showDiscount: boolean;

  RoomReservation, Reservation, NumDays: integer; var iErrorDays: integer

  );

procedure initImportLogsHolderRec(var rec: recImportLogsHolder);

procedure initCustomerHolderRec(var rec: recCustomerHolderEX);

procedure initResInfoRec(var rec: recResInfo);
procedure initRentInfoRec(var rec: recRoomsDateRentInfo);

procedure initRoomInfoRec(var rec: recRoomInfo);
procedure initTelLogHolder(var rec: recTelLogHolder);

function SQL_INS_InvoiceLine(theData: recInvoiceLineHolder): string;
function SP_INS_InvoiceLine(theData: recInvoiceLineHolder): boolean;

function SP_INS_Item(theData: recItemPlusHolder): boolean;
function Del_ReservationByreservation(Reservation: integer): boolean;



// function SP_INS_ItemType(theData : recItemTypeHolder; Connection : TRoomerConnection; loglevel : integer=0; logpath : string='') : boolean;

function SQL_INS_Reservation(theData: recReservationHolder): String;
function SP_INS_Reservation(theData: recReservationHolder): boolean;
function SP_INS_DelReservation(theData: recReservationHolder): boolean;
function SP_INS_RoomReservation(theData: recRoomReservationHolder): boolean;
function SQL_INS_RoomReservation(theData: recRoomReservationHolder): string;
function SP_INS_DelRoomReservation(theData: recRoomReservationHolder): boolean;

function INS_DelPerson(theData: recPersonHolder): boolean;

function SP_UPD_tblRoomStatusByDateRangeAndRoomType(RoomType: string; available: integer; FromDate, ToDate: Tdate): boolean;

// function SP_GET_Item_ByItem(var theData : recItemHolder; Connection : TRoomerConnection; loglevel : integer=0; logpath : string='') : boolean;
// function SP_GET_ItemType_ByItemType(var theData : recItemTypeHolder; Connection : TRoomerConnection; loglevel : integer=0; logpath : string='') : boolean;
function SP_GET_RoomReservation(RoomReservation: integer): recRoomReservationHolder;
function SP_GET_Reservation(Reservation: integer): recReservationHolder;
function GET_RoomsDate(ADate: TdateTime; RoomReservation: integer): recRoomsDateHolder;
// PriceCode
procedure initPriceCodeHolder(var rec: recPriceCodeHolder);
function GET_PriceCodeRackID(): integer;
function GET_PriceCodeHolder(var theData: recPriceCodeHolder): boolean;
function UPD_PriceCode(theData: recPriceCodeHolder): boolean;
function INS_PriceCode(theData: recPriceCodeHolder; var NewID: integer): boolean;
function Del_PriceCode(theData: recPriceCodeHolder): boolean;
function PriceCoceExistsInOther(id: integer): boolean;
function PriceCodeExist(Code: string): boolean;
function PriceCode_Code(id: integer): string;
function PriceCode_Rack: string;
function priceCode_RackID: integer;
function PriceCode_ID(pcCode: string): integer;
function PriceCode_Description(id: integer): string;
function PriceCode_isRack(pcCode: string): boolean;

function activePriceTypesExists(sPriceType: string): boolean;
function getNativeCurrencyID: integer;

// PriceType
procedure initPriceTypeHolder(var rec: recPriceTypeHolder);

function GetRackPrices(priceCodeID, seasonId: integer; RoomType, Currency: string): recPriceTypeHolder;

// GountryGroups
procedure initChannelManagerHolder(var rec: recChannelManagerHolder);
procedure initCountryGroupHolder(var rec: recCountryGroupHolder);
function GET_ChannelManagerHolderById(var theData: recChannelManagerHolder): boolean;
function GET_CountryGroupHolderByGountryGroup(var theData: recCountryGroupHolder): boolean;
function UPD_CountryGroup(theData: recCountryGroupHolder): boolean;
function UPD_CHannelManager(theData: recChannelManagerHolder): boolean;
function INS_ChannelManager(theData: recChannelManagerHolder): boolean;
function INS_CountryGroup(theData: recCountryGroupHolder): boolean;
function Del_countryGroupByCountryGroup(sCode: string): boolean;
function Del_ChannelManagerByID(id: integer): boolean;
function CountryGroupExistsInOther(sCountryGroup: string): boolean;
function CountryGroupExist(sCode: string): boolean;
function GET_CountryGroupDefault(): string;

// Country
procedure initCountryHolder(var rec: recCountryHolder);
function UPD_Country(theData: recCountryHolder): boolean;
function INS_Country(theData: recCountryHolder; var NewID: integer): boolean;
function DEL_CountryByCountry(sCountry: string): boolean;
function GET_countryHolderByCountry(var theData: recCountryHolder): boolean;
function GET_CountryCurrency(sCode: string): string;
function CountryExistsInOther(sCountry: string): boolean;
function CountryExists(sCode: string): boolean;

// Currency
function GET_CurrencyHolderByCurrency(var theData: recCurrencyHolder; justActive: boolean = true): boolean;
function GET_CurrencyHolderByID(var theData: recCurrencyHolder): boolean;
function GET_CurrencyByID(aID: integer): string;
function GET_IdByCurrency(Currency: string): integer;

function UPD_currency(theData: recCurrencyHolder): boolean;
function UPD_currencyRate(Currency: string; Rate: double): boolean;
function INS_currency(theData: recCurrencyHolder; var NewID: integer): boolean;
function Del_currencyBycurrency(sCurrency: string): boolean;
function currencyExistsInOther(sCurrency: string): boolean;
function CurrencyExist(sCurrency: string): boolean;

// convert
procedure initConvertHolder(var rec: recConvertHolder);
function GET_ConvertHolder(var theData: recConvertHolder): boolean;
function UPD_convert(theData: recConvertHolder): boolean;
function INS_convert(theData: recConvertHolder): boolean;
function Del_convert(theData: recConvertHolder): boolean;
function convertExist(sFrom: string): boolean;
function convertGetLastID: integer;
function doconvert(sType, sHomeValue: string): string;

// convertGroups
procedure initConvertGroupHolder(var rec: recConvertGroupHolder);
function UPD_convertGroup(theData: recConvertGroupHolder): boolean;
function INS_convertGroup(theData: recConvertGroupHolder): boolean;
function DEL_convertGroup(theData: recConvertGroupHolder): boolean;
function GET_convertGroupHolder(var theData: recConvertGroupHolder): boolean;
function convertGroupExistsInOther(sCode: string): boolean;
function convertGroupExists(sCode: string): boolean;

procedure initPayTypeHolder(var rec: recPayTypeHolder);
function GET_PayTypeHolder(var theData: recPayTypeHolder): boolean;
function UPD_PayType(theData: recPayTypeHolder): boolean;
function INS_PayType(theData: recPayTypeHolder; var NewID: integer): boolean;
function Del_PayType(theData: recPayTypeHolder): boolean;
function PayTypeExistsInOther(sCode: string): boolean;
function PayTypeExist(sCode: string): boolean;
function PayTypesDays(sCode: string): integer;

procedure initPhoneRateHolder(var rec: recPhoneRateHolder);
function GET_PhoneRateHolder(var theData: recPhoneRateHolder): boolean;
function UPD_PhoneRate(theData: recPhoneRateHolder): boolean;
function INS_PhoneRate(theData: recPhoneRateHolder; var NewID: integer): boolean;
function Del_PhoneRate(theData: recPhoneRateHolder): boolean;


procedure initPayGroupHolder(var rec: recPayGroupHolder);
function GET_PayGroupHolder(var theData: recPayGroupHolder): boolean;
function UPD_PayGroup(theData: recPayGroupHolder): boolean;
function INS_PayGroup(theData: recPayGroupHolder; var NewID: integer): boolean;
function Del_PayGroup(theData: recPayGroupHolder): boolean;
function PayGroupExistsInOther(sCode: string): boolean;
function PayGroupExist(sCode: string): boolean;

procedure initVatCodeHolder(var rec: recVatCodeHolder);
function GET_VatCodeHolder(var theData: recVatCodeHolder): boolean;
function UPD_VatCode(theData: recVatCodeHolder): boolean;
function INS_VatCode(theData: recVatCodeHolder): boolean;
function Del_VatCode(theData: recVatCodeHolder): boolean;
function VatCodeExistsInOther(sCode: string): boolean;
function VatCodeExist(sCode: string): boolean;

procedure initChannelPlanCodeHolder(var rec: recChannelPlanCodeHolder);
function GET_ChannelPlanCodeHolder(var theData: recChannelPlanCodeHolder): boolean;
function UPD_ChannelPlanCode(theData: recChannelPlanCodeHolder): boolean;
function INS_ChannelPlanCode(theData: recChannelPlanCodeHolder): boolean;
function Del_ChannelPlanCode(theData: recChannelPlanCodeHolder): boolean;
function ChannelPlanCodeExistsInOther(sCode: string): boolean;
function ChannelPlanCodeExist(sCode: string): boolean;

function ctrlGetString(aField: string): string;
function ctrlGetFloat(aField: string): double;
function ctrlGetInteger(aField: string): integer;
function ctrlGetBoolean(aField: string): boolean;

function rd_Exists(id: integer): boolean;
function rd_ExistsByRRandDate(RoomReservation: integer; sDate: string): boolean;

function Item_Exists(sItem: string): boolean;
function ItemType_Exists(sItemType: string): boolean;
function Convert(sType, sValue: string; Direction: integer): string;
function ItemPlus_Get_Data(aItem: string): recItemPlusHolder;

function GetFirstCurrency(iReservation: integer): string;

function RR_Exists(iRoomReservation: integer): boolean;

function RR_GetReservation(iRoomReservation: integer): integer;
function RR_GetRoomNumber(iRoomReservation: integer): string;
function RR_GetFrom_RoomAndDate(Room: string; ADate: Tdate): integer;
function RR_GetFrom_RoomAndDateDeparting(Room: string; ADate: Tdate): integer;

function RR_GetDeparting(Room: string; ADate: Tdate): integer;
function RR_GetNumberGroupInvoices(iReservation: integer): integer;
function RR_GetCurrency(iRoomReservation: integer): string;
function RR_GetFirstGuestNameFast(iRoomReservation: integer): string;
function RR_unpaidRoomRent(iRoomReservation: integer; useISK: boolean = true): recRoomsDateRentInfo;
function RR_GetCustomer(iRoomReservation: integer): string;
function RR_GuestCount(iRoomReservation: integer): integer;

function RR_GetAvrageRent(iRoomReservation: integer): recRoomReservationRentHolder;

function RV_Exists(iReservation: integer): boolean;
function RV_useStayTax(iReservation: integer): boolean;
procedure RV_SetUseStayTax(iReservation: integer);
function RV_GetResInfo(iReservation: integer): recResInfo;
function RV_GuestCount(iReservation: integer): integer;
function RV_RoomCount(iReservation: integer): integer;
function RV_NoRoomCount(iReservation: integer): integer;
function RV_ClosedInvoiceCount(iReservation: integer): integer;
function RV_ClosedInvoiceLineCount(iReservation: integer): integer;
function RV_ClosedInvoiceAmount(iReservation: integer): double;
function RV_openInvoiceRentCount(iReservation: integer): integer;
function RV_openInvoiceRentAmount(iReservation: integer): double;
function RV_closedInvoiceRentCount(iReservation: integer): integer;
function RV_closedInvoiceRentAmount(iReservation: integer): double;
function RV_closedInvoiceItemCount(iReservation: integer): integer;
function RV_closedInvoiceItemAmount(iReservation: integer): double;
function RV_openInvoiceItemCount(iReservation: integer): integer;
function RV_openInvoiceItemAmount(iReservation: integer): double;

function RV_SetNewID: integer;
function PE_SetNewID: integer;
function RR_SetNewID: integer;
function RR_GetIDs(Count: integer): string;
function Persons_GetIDs(Count: integer): string;

function RV_GetLastID: integer;
function IVH_SetNewID: integer;
function IVH_RestoreID: integer;
function IVH_GetLastID: integer;

function NumberOfInvoiceLines(iReservation, iRoomReservation, iSplitNumber: integer; InvoiceIndex : Integer = -1): integer;
function GetRate(Currency: string): double;

function GetReservationRRList(Reservation: integer; var RRlist, lstRoomReservationsStatus: TstringList): integer;

function Item_GetKind(sItem: string): TItemKind;

function Item_isJustRoomRent(Item: string): boolean;
function Item_isRoomRent(Item: string): boolean;
function Item_isRoomRentOrDiscount(Item: string): boolean;

function DraftInvGroup_exists(Reservation: integer): boolean;
function DraftInv_exists(RoomReservation: integer): boolean;
function DraftInv_Create(Reservation, RoomReservation: integer; user: string): boolean;
function DraftInv_RRUpdateAmounts(RoomReservation: integer): boolean;

function Customer_Exists(Customer: string): boolean;
function PriceCodes_GETRack(): integer;
function CustomerTypes_GetDefault(): string;
function Country_GetDefault(): string;

function Item_GetDescription(Item: string): string;
function Item_GetPrice(Item: string): double;

procedure ins_delRoomReservationInfo_NOT_USED_ANYMORE(RoomReservation: integer; CancelStaff, CancelReason, CancelInformation: string; CancelType: integer);

function Room_GetRec(Room: string): recRoomInfo;
function Customer_GetHolder(Customer: string): recCustomerHolderEX;

Function GetArrivalText(RoomReservation: integer): string;

function GetTelRoomInfo(device: string; var Room, Description: string; var doCharge: boolean): boolean;

function FillLstTelPriceMasks(var lstMasks: TstringList): integer;

function invoiceList_Unconfirmed(location : string = ''): TstringList;
function invoiceList_confirmed(confirmDate: TdateTime): TstringList;
function invoiceList_ConfirmGroup(confirmDate: TdateTime): TstringList;
function invoiceList_FromTo(DateFrom, DateTo: Tdate; Location : string = ''): TstringList;

procedure RoomStatus_addDefault(FromDate: Tdate; dateCount: integer);
function RoomStatus_updByRangeAndType(FromDate: Tdate; dateCount: integer; roomType1, roomType2: string): boolean;
function roomStatus_update(FromDate: Tdate; dateCount: integer; roomType1, roomType2: string; doRefresh: boolean; ProcName: string): integer;

{ Moved from ud vegna CreateQuickReservation }
function InvoiceExists(InvoiceNumber: integer): boolean;
function GET_RoomsType_byRoom(sRoom: string): string;
function GET_useInNationalReport_byRoom(sRoom: string): boolean;
function GET_NumberOfGuestsbyRoom(sRoom: string): integer;
function GetPriceType(RoomType: string): string;
function RE_GetFirstAndLastDate(iReservation: integer; var FirstDate, LastDate: Tdate): integer;
{ ..Moved }

function LocalFloatValue(Value: String): double;
function FilterTablenames(sql: String): String;
function GetLastID(tableName: string; doLowerCase: boolean = true): integer;

procedure initTaxesHolder(var rec: recTaxesHolder);
function INS_Taxes(theData: recTaxesHolder; var NewID: integer): boolean;
function UPD_Taxes(theData: recTaxesHolder): boolean;
function Del_Taxes(theData: recTaxesHolder): boolean;

procedure initRateRuleHolder(var rec: recRateRuleHolder);
function Del_RateRule(theData: recRateRuleHolder): boolean;
function UPD_rateRule(theData: recRateRuleHolder): boolean;
function INS_RateRule(theData: recRateRuleHolder; var NewID: integer): boolean;
function rateRuleDescriptionExist(sDescription: string): boolean;

procedure initwRoomRateHolder(var rec: recwRoomRateHolder);
procedure initRoomRateHolder(var rec: recRoomRateHolder);
function RoomRateDescriptionExist(sDescription: string): boolean;
function INS_RoomRate(theData: recwRoomRateHolder; var NewID: integer): boolean;
function UPD_RoomRate(theData: recwRoomRateHolder): boolean;
function Del_RoomRate(theData: recwRoomRateHolder): boolean;

procedure initRateHolder(var rec: recRateHolder);
function rateDescriptionExist(sDescription: string): boolean;
function rateDefaultExist(sCurrency: string; bDefault: boolean): boolean;
function INS_Rate(theData: recRateHolder; var NewID: integer): boolean;
function UPD_Rate(theData: recRateHolder): boolean;
function Del_Rate(theData: recRateHolder): boolean;

procedure UpdateRoomTypeCode(oldCode, newCode : String);
procedure initRoomTypeHolder(var rec: recRoomTypeHolder);
function Del_roomType(theData: recRoomTypeHolder): boolean;
function UPD_roomType(theData: recRoomTypeHolder): boolean;
function INS_roomType(theData: recRoomTypeHolder; var NewID: integer): boolean;
function roomTypeExist(sRoomType: string): boolean;
function RoomTypeExistsInOther(sRoomType: string; id: integer): boolean;

function channelManager_GetDefaultCode: String;
function channels_GetDefaultCode: String;
function channels_GetDefault: integer;

function roomTypeGroupExist(sCode: string): boolean;
function INS_roomTypeGroup(theData: recRoomTypeGroupHolder; var NewID: integer): boolean;
function UPD_roomTypeGroup(theData: recRoomTypeGroupHolder): boolean;
function Del_roomTypeGroup(theData: recRoomTypeGroupHolder): boolean;
procedure SetRoomTypeGroupDity(Code : String);
procedure Set2RoomTypeGroupDity(Code1, Code2 : String);
procedure UpdateRoomTypeGroupCode(oldCode, newCode : String);
procedure initRoomTypeGroupHolder(var rec: recRoomTypeGroupHolder);

procedure initSeasonHolder(var rec: recSeasonHolder);
function Del_Season(theData: recSeasonHolder): boolean;
function UPD_Season(theData: recSeasonHolder): boolean;
function INS_Season(theData: recSeasonHolder; var NewID: integer): boolean;
function seasonDescriptionExist(sDescription: string): boolean;
function seasonHolderByID(iID: integer): recSeasonHolder;

procedure UpdateItemCode(oldCode, newCode : String);
procedure initItemTypeHolder(var rec: recItemTypeHolder);
function Del_itemtype(theData: recItemTypeHolder): boolean;
function UPD_itemtype(theData: recItemTypeHolder): boolean;
function INS_itemtype(theData: recItemTypeHolder; var NewID: integer): boolean;
function itemtypesItemtypeExist(sItemType: string): boolean;
function itemTypeExistsInOther(sCode: string): boolean;

procedure initDayNotes(var rec: recDayNotesHolder);
function UPD_DayNotes(var rec: recDayNotesHolder) : Boolean;
function INS_DayNotes(var rec: recDayNotesHolder; var newId : Integer) : Boolean;


function INS_CleaningNote(theData: recCleaningNotesHolder; var NewID: integer): boolean;
function UPD_CleaningNote(theData: recCleaningNotesHolder): boolean;
function Del_CleaningNote(theData: recCleaningNotesHolder): boolean;
procedure initCleaningNoteHolder(var rec: recCleaningNotesHolder);


function GET_Item_ByItem(var theData: recItemHolder): boolean;
function INS_Item(theData: recItemHolder; var NewID: integer): boolean;
function UPD_item(theData: recItemHolder): boolean;
function Del_item(theData: recItemHolder): boolean;
procedure initItemHolder(var rec: recItemHolder);
function itemExistsInOther(sCode: string): boolean;
function itemExist(sItem: string): boolean;
function GET_ItemID(Item: string): integer;
function GET_ItemCode(id: integer): string;

function INS_StockItemPrice(theData: recStockItemPricesHolder; var aNewID: integer): boolean;
function UPD_StockItemPrice(theData: recStockItemPricesHolder): boolean;
function Del_StockItemPrice(theData: recStockItemPricesHolder): boolean;

function GET_Location_ByLocation(var theData: recLocationHolder): boolean;
function INS_location(theData: recLocationHolder; var NewID: integer): boolean;
function UPD_location(theData: recLocationHolder): boolean;
function Del_location(theData: recLocationHolder): boolean;
procedure initLocationHolder(var rec: recLocationHolder);

procedure initRoomHolder(var rec: recRoomHolder);
function Del_room(theData: recRoomHolder): boolean;
function UPD_room(theData: recRoomHolder): boolean;
function INS_room(theData: recRoomHolder; var NewID: integer): boolean;
function UPD_roomLocation(Roomtype, newLocation : string): boolean;
function GET_Room_ByRoom(var theData: recRoomHolder): boolean;
function RoomExist(sRoom: string): boolean;
function RoomExistsInOther(sRoom: string): boolean;

procedure initCustomerTypeHolder(var rec: recCustomerTypeHolder);
function Del_CustomerType(theData: recCustomerTypeHolder): boolean;
function UPD_CustomerType(theData: recCustomerTypeHolder): boolean;
function INS_CustomerType(theData: recCustomerTypeHolder; var NewID: integer): boolean;
function GET_CustomerType_ByCustomerType(var theData: recCustomerTypeHolder): boolean;
function CustomerTypeExist(Code: string): boolean;
function CustomerTypeExistsInOther(Code: string; id: integer): boolean;

procedure SetForeignKeyCheckValue(value : Byte);

procedure UpdateCustomerCode(oldCode, newCode : String);
procedure initCustomerHolder(var rec: recCustomerHolder);
function Del_Customer(theData: recCustomerHolder): boolean;
function UPD_Customer(theData: recCustomerHolder): boolean;
function INS_Customer(theData: recCustomerHolder; var NewID: integer): boolean;
function GET_Customer_ByCustomer(var theData: recCustomerHolder): boolean;
function CustomerExist(Customer: string): boolean;
function GetCustomerId(Customer: string): integer;
function CustomerExistsInOther(Customer: string; id : integer = 0): boolean;

procedure initStaffTypeHolder(var rec: recStaffTypeHolder);
function Del_StaffType(theData: recStaffTypeHolder): boolean;
function UPD_StaffType(theData: recStaffTypeHolder): boolean;
function INS_StaffType(theData: recStaffTypeHolder; var NewID: integer): boolean;
function GET_StaffType_ByStaffType(var theData: recStaffTypeHolder): boolean;
function StaffTypeExist(Code: string): boolean;

procedure initStaffMemberHolder(var rec: recStaffMemberHolder);
function Del_StaffMember(theData: recStaffMemberHolder): boolean;
function UPD_Staffmember(theData: recStaffMemberHolder): boolean;
function INS_StaffMember(theData: recStaffMemberHolder; var NewID: integer): boolean;
function GET_StaffMember_ByInitials(var theData: recStaffMemberHolder): boolean;
function StaffMemberExist(Initials: string): boolean;
function StaffMemberIsAdmin_ByInitials(Initials: string): boolean;
function UPD_StaffMember_StaffType1(theData: recStaffMemberHolder): boolean;
function InitialsExistsInOther(sCode: string): boolean;

procedure initChannelHolder(var rec: recChannelHolder);
function Del_Channel(theData: recChannelHolder): boolean;
function UPD_Channel(theData: recChannelHolder): boolean;
function INS_Channel(theData: recChannelHolder; var NewID: integer): boolean;

procedure initsystemserverHolder(var rec: recSystemServerHolder);
function Del_systemserver(theData: recSystemServerHolder): boolean;
function UPD_systemserver(theData: recSystemServerHolder): boolean;
function INS_systemserver(theData: recSystemServerHolder; var NewID: integer): boolean;

procedure initSystemActionHolder(var rec: recSystemActionHolder);
function Del_SystemAction(theData: recSystemActionHolder): boolean;
function UPD_SystemAction(theData: recSystemActionHolder): boolean;
function INS_SystemAction(theData: recSystemActionHolder; var NewID: integer): boolean;
function UPD_systemaction_justDetails(id: integer; subject, content, contentfile: string; richcontent: boolean): boolean;

procedure initSystemTriggerHolder(var rec: recSystemTriggerHolder);
function Del_SystemTrigger(theData: recSystemTriggerHolder): boolean;
function UPD_SystemTrigger(theData: recSystemTriggerHolder): boolean;
function INS_SystemTrigger(theData: recSystemTriggerHolder; var NewID: integer): boolean;

procedure initPackageHolder(var rec: recPackageHolder);
function Del_Package(theData: recPackageHolder): boolean;
function UPD_Package(theData: recPackageHolder): boolean;
function INS_Package(theData: recPackageHolder; var NewID: integer): boolean;
function packageExist(sPackage: string): boolean;
function packageExistInItems(sPackage: string): boolean;
function packageExistsInOther(sCode: string): boolean;
function Package_Description(Code: string): string;
function Package_getID(Code: string): integer;
function Package_getRoomPrice(Code: string; Nights, guests: integer; Var Roomprice, itemprices: double): boolean;
function Package_getRoomDescription(Code: string; Room: String; Arrival, Departure: TdateTime; Guestname : string=''): string;

procedure initPackageItemHolder(var rec: recPackageItemHolder);
function Del_PackageItem(theData: recPackageItemHolder): boolean;
function Del_PackageItemByPackage(packageId: integer): boolean;
function UPD_PackageItem(theData: recPackageItemHolder): boolean;
function INS_Packageitem(theData: recPackageItemHolder; var NewID: integer): boolean;
function Packageitem_TotalByPackageID(packageId: integer): double;

procedure initPersonHolder(var rec: recPersonHolder);
function INS_Person(theData: recPersonHolder; var NewID: integer): boolean;
function SQL_INS_Person(theData: recPersonHolder): string;

function DEL_Person(theData: recPersonHolder): boolean;
function UPD_person(theData: recPersonHolder): boolean;
function GET_Pesson(Person: integer): recPersonHolder;
function GET_mainGuest(RoomReservation: integer): recPersonHolder;

function PersonIDExistsInOther(id: integer): boolean;
function PersonExistsInOther(Person: integer): boolean;

function PersonVipTypesExists(Code: string): boolean;
function Del_PersonVipTypesByCode(Code: string): boolean;
function PersonVipTypesExistsInOther(Code: string): boolean;
function INS_PersonVipTypes(theData: recPersonVipTypesHolder; var NewID: integer): boolean;
function UPD_PersonVipTypes(theData: recPersonVipTypesHolder): boolean;
function GET_PersonVipTypesHolderByID(var theData: recPersonVipTypesHolder): boolean;
procedure initPersonVipTypesHolder(var rec: recPersonVipTypesHolder);
function GET_PersonVipTypesHolderByCode(var theData: recPersonVipTypesHolder; justActive: boolean = true): boolean;

function PersonContactTypeExists(Code: string): boolean;
function Del_PersonContactTypeByCode(Code: string): boolean;
function PersonContactTypeExistsInOther(Code: string): boolean;
function INS_PersonContactType(theData: recPersonContactTypeHolder; var NewID: integer): boolean;
function UPD_PersonContactType(theData: recPersonContactTypeHolder): boolean;
function GET_PersonContactTypeHolderByID(var theData: recPersonContactTypeHolder): boolean;
procedure initPersonContactTypeHolder(var rec: recPersonContactTypeHolder);
function GET_PersonContactTypeHolderByCode(var theData: recPersonContactTypeHolder; justActive: boolean = true): boolean;


procedure initLostAndFoundHolder(var rec: recLostAndFoundHolder);
function Del_LostAndFound(theData: recLostAndFoundHolder): boolean;
function INS_LostAndFound(theData: recLostAndFoundHolder; var NewID: integer): boolean;
function UPD_LostAndFound(theData: recLostAndFoundHolder): boolean;


function GetDayRate(RoomType: string; RoomNumber: string; ADate: TdateTime; GuestCount: integer; ChildCount: integer; infantCount: integer; Currency: string;
  priceID: integer; Discount: double; showDiscount: boolean; isPercentage: boolean; isPaid: boolean; doAdd: boolean): double;

function RD_ispaid(RoomReservation: integer): boolean;

procedure FixRoomTypes;
Function changeNoRoomRoomtype(Reservation, RoomReservation: integer; oldType: string): boolean;
Function changeNoRoomRoomtypeReturnSelection(Reservation, RoomReservation: integer; oldType: string): String;

function updateRdResFlag(id: integer; Status: string): boolean;
function updateRdResFlagByRRandDate(RoomReservation: integer; sDate: string; Status: string; SetPaid : Boolean = False; isPaid : Boolean = False): boolean;

function DKAutoTransfer : boolean;

function GetTaxesHolder : recTaxesHolder;
procedure initCityTaxResultHolder(var rec: recCityTaxResultHolder);

function StoreDescriptionExist(ss: string): boolean;
function propertiesstoreGetText(ss: string) : string;

// var
// roomerConnection : TRoomerConnection;
// roomerDataSet : TRoomerDataSet;

implementation

uses
  uD,
  ug,
  uDayNotes, uPriceOBJ, uSqlDefinitions, uStringUtils, uAppGlobal, uRoomTypes2,
  uDateUtils,
  uActivityLogs,
  uAvailabilityPerDay,
  PrjConst
  ;

function LocalFloatValue(Value: String): double;
begin
  result := LocalizedFloatValue(Value);
end;

procedure SetForeignKeyCheckValue(value : Byte);
begin
  d.roomerMainDataSet.DoCommand('SET FOREIGN_KEY_CHECKS=' + inttostr(value));
end;

procedure AddUpdateToPlan(plan : TRoomerExecutionPlan; tableName, columnName, oldCode, newCode : String);
begin
  plan.AddExec(format('UPDATE %s SET %s=%s WHERE %s=%s',
     [
      tableName,
      columnName,
      _db(newCode),
      columnName,
      _db(oldCode)
     ]));
end;

procedure UpdateCodeOfTable(tables : Array Of String; oldCode, newCode : String);
var i : Integer;
    plan : TRoomerExecutionPlan;
    s, tableName, columnName : String;
begin
  plan := d.roomerMainDataSet.CreateExecutionPlan;
  try
    for i := LOW(tables) to HIGH(tables) do
    begin
      s := tables[i];
      tableName := copy(s, 1, POS(',', s) - 1);
      columnName := copy(s, POS(',', s) + 1, maxInt);
      AddUpdateToPlan(plan, tableName, columnName, oldCode, newCode);
    end;
    plan.Execute(ptExec, true, true);
  finally
    plan.Free;
  end;
end;


function rSet_bySQL(rSet: TRoomerDataSet; sSQL: string; doLowerCase: boolean = true; SetLastAccess : Boolean = True): boolean;
var
  errMsg: string;
begin
{$IFDEF SQLLOG}
  frmdayNotes.memLog.text := frmdayNotes.memLog.text + sSQL;
  frmdayNotes.memLog.Lines.Add('-----');
  frmdayNotes.memLog.Lines.Add('');
{$ENDIF}
  if rSet.active then
    rSet.close;

  errMsg := '';
  rSet.ParentRoomerDataSet := d.roomerMainDataSet;
  rSet.CommandType := cmdText;
  if doLowerCase then
    rSet.CommandText := LowerCase(FilterTablenames(sSQL))
  else
    rSet.CommandText := FilterTablenames(sSQL);
  try
    rSet.open(doLowerCase, SetLastAccess);
    result := not rSet.Eof;
  except
    on e: exception do
    begin
      DebugMessage(e.Message);
      // uStringUtils.CopyToClipboard(Rset.CommandText);
      // result := false;
      // errMsg := e.message;
      raise;
    end;
  end;
end;

function cmd_bySQL(sSQL: string; performFilterTableNames : Boolean = True; async : Boolean = False): boolean;
var
  sql, errMsg: string;
begin
{$IFDEF SQLLOG}
  frmdayNotes.memLog.text := frmdayNotes.memLog.text + sSQL;
  frmdayNotes.memLog.Lines.Add('-----');
  frmdayNotes.memLog.Lines.Add('');
{$ENDIF}
  errMsg := '';
  try
    if performFilterTableNames then
      sql := FilterTablenames(sSQL)
    else
      sql := sSQL;
    d.roomerMainDataSet.DoCommand(sql, async);
    result := true;
    // uStringUtils.CopyToClipboard(sSql);

  except
    on e: exception do
    begin
      errMsg := e.message + #10 + sSQL;
      uStringUtils.CopyToClipboard(errMsg + '  '#10 + sSQL);
      raise;
    end;
  end;
end;

var
  listOfTables: TstringList;

function FilterTablenames(sql: String): String;
var
  i: integer;
begin
  result := sql;
  for i := 0 to listOfTables.Count - 1 do
  begin
    result := StringReplace(result, '[' + listOfTables[i] + ']', listOfTables[i], [rfReplaceAll, rfIgnoreCase]);
    result := StringReplace(result, listOfTables[i] + '.', listOfTables[i] + '.', [rfReplaceAll, rfIgnoreCase]);
  end;

  result := StringReplace(result, '[', '', [rfReplaceAll, rfIgnoreCase]);
  result := StringReplace(result, ']', '', [rfReplaceAll, rfIgnoreCase]);
end;

function S_execute(var rSet: TRoomerDataSet; ProcName: string; var lstParams: TstringList): boolean;
var
  sParams: string;
  i: integer;
begin
  sParams := ' ';
  for i := 0 to lstParams.Count - 1 do
  begin
    if i > 0 then
      sParams := sParams + ' ,';
    sParams := sParams + lstParams[i];
  end;

  try
    if rSet.active then
      rSet.close;
    rSet.CommandText := 'EXEC ' + ProcName + ' ' + sParams;

    rSet.open;

    result := not rSet.Eof;
  except
    on e: exception do
    begin
      result := false;
    end;
  end;
end;

function S_Command(ProcName: string; var lstParams: TstringList): boolean;
var
  sParams: string;
  i: integer;
  rSet: TADOCommand;
begin
  rSet := TADOCommand.Create(nil);
  try

    rSet.CommandType := cmdText;
    rSet.ParamCheck := false;

    result := false;
    sParams := ' ';
    for i := 0 to lstParams.Count - 1 do
    begin
      if i > 0 then
        sParams := sParams + ' ,';
      sParams := sParams + lstParams[i];
    end;
    try
      rSet.CommandText := 'EXEC ' + ProcName + ' ' + sParams;
      rSet.Execute;
      result := true;
    except
      on e: exception do
      begin
        result := false;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function S_CommandWithErrMessage(ProcName: string; var lstParams: TstringList; var ErrMessage: string): boolean;
var
  sParams: string;
  i: integer;
  rSet: TADOCommand;
begin
  rSet := TADOCommand.Create(nil);
  try

    rSet.CommandType := cmdText;
    rSet.ParamCheck := false;

    result := false;
    sParams := ' ';
    for i := 0 to lstParams.Count - 1 do
    begin
      if i > 0 then
        sParams := sParams + ' ,';
      sParams := sParams + lstParams[i];
    end;
    try
      ErrMessage := '';
      rSet.CommandText := 'EXEC ' + ProcName + ' ' + sParams;
      rSet.Execute;
      result := true;
    except
      on e: exception do
      begin
        result := false;
        ErrMessage := ProcName + ' : ' + e.message;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function GetLastID(tableName: string; doLowerCase: boolean = true): integer;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := 0;
  if doLowerCase then
    tableName := LowerCase(tableName)
  else
    tableName := tableName;

  s := '';
  s := s + 'SELECT ';
  s := s + 'id ';
  s := s + 'FROM ';
  s := s + '%s ';
  s := s + 'ORDER BY ';
  s := s + 'id DESC ';
  s := s + 'LIMIT 0,1 ';

  rSet := CreateNewDataSet;
  try
    s := format(s, [tableName]);
    if rSet_bySQL(rSet, s) then
    begin
      result := rSet.fieldbyname('id').asInteger;
    end;
  finally
    freeandnil(rSet);
  end;

end;


// -----------------------------------------------------------------------------
//
//
// -----------------------------------------------------------------------------

procedure initInvoiceLineHolderRec(var rec: recInvoiceLineHolder);
begin
  with rec do
  begin
    AutoGen := '';
    Reservation := 0;
    RoomReservation := 0;
    SplitNumber := 0;
    ItemNumber := 0;
    PurchaseDate := 1;
    InvoiceNumber := 0;
    ItemID := '';
    Number := 0.00; // -96
    Description := '';
    Price := 0.00;
    VATType := '';
    Total := 0.00;
    TotalWOVAT := 0.00;
    VAT := 0.00;
    AutoGenerated := false;
    CurrencyRate := 0.00;
    Currency := '';
    ReportDate := 1;
    ReportTime := '';
    Persons := 0;
    Nights := 0;
    BreakfastPrice := 0.00;
    Ayear := 0;
    Amon := 0;
    Aday := 0;
    ilTmp := '';
    ilID := 0;
    ilAccountKey := '';
    ItemCurrency := '';
    ItemCurrencyRate := 0.00;
    Discount := 0.00;
    Discount_isPrecent := true;
    ImportRefrence := '';
    ImportSource := '';
    IsPackage := false;
    RoomreservationAlias := 0;
    confirmDate := 2;
    confirmAmount := 0.00;
    InvoiceIndex := 0;
    RevenueCorrection := 0;
  end;
end;

procedure DxMemDataToInvoiceHeadHolderRec(dxMemData: TDxMemData; var rec: recInvoiceHeadHolder);
begin
  with rec, dxMemData do
  begin
    id := dxMemData['ID'];
    Reservation := dxMemData['Reservation'];
    RoomReservation := dxMemData['RoomReservation'];
    SplitNumber := dxMemData['SplitNumber'];
    InvoiceNumber := dxMemData['InvoiceNumber'];
    InvoiceDate := dxMemData['InvoiceDate'];
    Total := dxMemData['Total'];
    TotalWOVAT := dxMemData['TotalWOVat'];
    ReportDate := dxMemData['ReportDate'];
    ReportTime := dxMemData['ReportTime'];

    Customer := dxMemData['Customer'];
    rec.name := dxMemData['name'];
    Address1 := dxMemData['Address1'];
    Address2 := dxMemData['Address2'];
    Address3 := dxMemData['Address3'];
    Address4 := dxMemData['Address4'];
    Country := dxMemData['Country'];
    TotalVAT := dxMemData['TotalVAT'];
    TotalBreakFast := dxMemData['TotalBreakFast'];
    ExtraText := dxMemData['ExtraText'];
    Finished := dxMemData['Finished'];
    CreditInvoice := dxMemData['CreditInvoice'];
    OriginalInvoice := dxMemData['OriginalInvoice'];
    InvoiceType := dxMemData['InvoiceType'];
    ihTmp := dxMemData['ihTmp'];
    custPID := dxMemData['custPID'];
    RoomGuest := dxMemData['RoomGuest'];
    ihDate := dxMemData['ihDate'];
    ihInvoiceDate := dxMemData['ihInvoiceDate'];
    ihConfirmDate := dxMemData['ihConfirmDate'];
    ihPayDate := dxMemData['ihPayDate'];
    ihStaff := dxMemData['ihStaff'];
    ihCurrency := dxMemData['ihCurrency'];
    ihCurrencyRate := dxMemData['ihCurrencyRate'];
    ReportDate := dxMemData['ReportDate'];
    ReportTime := dxMemData['ReportTime'];

    invRefrence := dxMemData['invRefrence'];
    TotalStayTax := dxMemData['TotalStayTax'];
    TotalStayTaxNights := dxMemData['TotalStayTaxNights'];
    ShowPackage := dxMemData['ShowPackage'];
    //ATH*Location
  end;
end;

procedure InvoiceHeadHolderRecToDxMemData(dxMemData: TDxMemData; rec: recInvoiceHeadHolder);
begin
  with rec, dxMemData do
  begin
    dxMemData['ID'] := id;
    dxMemData['Reservation'] := Reservation;
    dxMemData['RoomReservation'] := RoomReservation;
    dxMemData['SplitNumber'] := SplitNumber;
    dxMemData['InvoiceNumber'] := InvoiceNumber;
    dxMemData['InvoiceDate'] := InvoiceDate;
    dxMemData['Total'] := Total;
    dxMemData['TotalWOVat'] := TotalWOVAT;
    dxMemData['ReportDate'] := ReportDate;
    dxMemData['ReportTime'] := ReportTime;

    dxMemData['Customer'] := Customer;
    dxMemData['name'] := name;
    dxMemData['Address1'] := Address1;
    dxMemData['Address2'] := Address2;
    dxMemData['Address3'] := Address3;
    dxMemData['Address4'] := Address4;
    dxMemData['Country'] := Country;
    dxMemData['TotalVAT'] := TotalVAT;
    dxMemData['TotalBreakFast'] := TotalBreakFast;
    dxMemData['ExtraText'] := ExtraText;
    dxMemData['Finished'] := Finished;
    dxMemData['CreditInvoice'] := CreditInvoice;
    dxMemData['OriginalInvoice'] := OriginalInvoice;
    dxMemData['InvoiceType'] := InvoiceType;
    dxMemData['ihTmp'] := ihTmp;
    dxMemData['custPID'] := custPID;
    dxMemData['RoomGuest'] := RoomGuest;
    dxMemData['ihDate'] := ihDate;
    dxMemData['ihInvoiceDate'] := ihInvoiceDate;
    dxMemData['ihConfirmDate'] := ihConfirmDate;
    dxMemData['ihPayDate'] := ihPayDate;
    dxMemData['ihStaff'] := ihStaff;
    dxMemData['ihCurrency'] := ihCurrency;
    dxMemData['ihCurrencyRate'] := ihCurrencyRate;
    dxMemData['ReportDate'] := ReportDate;
    dxMemData['ReportTime'] := ReportTime;

    dxMemData['invRefrence'] := invRefrence;
    dxMemData['TotalStayTax'] := TotalStayTax;
    dxMemData['TotalStayTaxNights'] := TotalStayTaxNights;
    dxMemData['ShowPackage'] := ShowPackage;
    //Ath*Location
  end;
end;

procedure DxMemDataToPaymentHolderRec(dxMemData: TDxMemData; var rec: recPaymentHolder);
begin
  with rec, dxMemData do
  begin
    id := dxMemData['ID'];
    Reservation := dxMemData['Reservation'];
    RoomReservation := dxMemData['RoomReservation'];
    Person := dxMemData['Person'];
    AutoGen := dxMemData['AutoGen'];
    TypeIndex := dxMemData['TypeIndex'];
    InvoiceNumber := dxMemData['InvoiceNumber'];
    PayDate := dxMemData['PayDate'];
    Customer := dxMemData['Customer'];
    PayType := dxMemData['PayType'];
    Amount := dxMemData['Amount'];
    Description := dxMemData['Description'];
    CurrencyRate := dxMemData['CurrencyRate'];
    Currency := dxMemData['Currency'];
    ReportDate := dxMemData['ReportDate'];
    ReportTime := dxMemData['ReportTime'];
    Ayear := dxMemData['Ayear'];
    Amon := dxMemData['Amon'];
    Aday := dxMemData['Aday'];
    pmTmp := dxMemData['pmTmp'];
    confirmDate := dxMemData['confirmDate'];
    Notes := dxMemData['Notes'];
    staff := dxMemData['staff'];
    dtCreated := dxMemData['dtCreated'];
  end;
end;

procedure PaymentHolderRecToDxMemData(dxMemData: TDxMemData; rec: recPaymentHolder);
begin
  with rec, dxMemData do
  begin
    dxMemData['ID'] := id;
    dxMemData['Reservation'] := Reservation;
    dxMemData['RoomReservation'] := RoomReservation;
    dxMemData['Person'] := Person;
    dxMemData['AutoGen'] := AutoGen;
    dxMemData['TypeIndex'] := TypeIndex;
    dxMemData['InvoiceNumber'] := InvoiceNumber;
    dxMemData['PayDate'] := PayDate;
    dxMemData['Customer'] := Customer;
    dxMemData['PayType'] := PayType;
    dxMemData['Amount'] := Amount;
    dxMemData['Description'] := Description;
    dxMemData['CurrencyRate'] := CurrencyRate;
    dxMemData['Currency'] := Currency;
    dxMemData['ReportDate'] := ReportDate;
    dxMemData['ReportTime'] := ReportTime;
    dxMemData['Ayear'] := Ayear;
    dxMemData['Amon'] := Amon;
    dxMemData['Aday'] := Aday;
    dxMemData['pmTmp'] := pmTmp;
    dxMemData['confirmDate'] := confirmDate;
    dxMemData['Notes'] := Notes;
    dxMemData['staff'] := staff;
    dxMemData['dtCreated'] := dtCreated;
  end;
end;

procedure initPaymentHolderRec(var rec: recPaymentHolder);
var
  wYear, wMon, wDay: word;
begin
  with rec do
  begin
    decodedate(now, wYear, wMon, wDay);

    Aday := wDay;
    Amon := wMon;
    Ayear := wYear;

    Reservation := 0;
    RoomReservation := 0;
    Person := 0; // Not used
    AutoGen := _GetCurrentTick;
    TypeIndex := 0;
    InvoiceNumber := 0;
    PayDate := '1900-01-01'; // 'YYYY-MM-DD'
    Customer := '';
    PayType := '';
    Amount := 0.00;
    Description := '';
    CurrencyRate := 1;
    Currency := '';
    ReportDate := '';
    ReportTime := '';
    pmTmp := '';
    confirmDate := 2; // '1900-01-01 00:00:00'
    Notes := '';
    staff := d.roomerMainDataSet.username;

    invoiceIndex := 0;

    // ID - AutoInc
    // dtCreated -

  end;
end;

procedure initInvoiceHeadHolderRec(var rec: recInvoiceHeadHolder);
begin
  with rec do
  begin
    Reservation := 0; // int
    RoomReservation := 0; // int
    SplitNumber := 0; // int
    InvoiceNumber := -1; // int
    InvoiceDate := _dateToDBdate(date, false); // nvarchar(10)
    Customer := ''; // nvarchar(15)
    name := ''; // nvarchar(70)
    Address1 := ''; // nvarchar(70)
    Address2 := ''; // nvarchar(70)
    Address3 := ''; // nvarchar(70)
    Address4 := ''; // nvarchar(70)
    Country := ''; // nvarchar(2)
    Total := 0.00; // double
    TotalWOVAT := 0.00; // double
    TotalVAT := 0.00; // double
    TotalBreakFast := 0.00; // double
    ExtraText := ''; // ntext
    Finished := false; // bit
    CreditInvoice := -1; // int
    OriginalInvoice := -1; // int
    InvoiceType := 1; // int
    ihTmp := ''; // char(3)
    custPID := ''; // nvarchar(15)
    RoomGuest := ''; // nvarchar(50)
    ihDate := date; // datetime
    ihInvoiceDate := date; // datetime
    ihConfirmDate := 2; // datetime
    ihPayDate := date; // datetime
    ihStaff := g.qUser; // nvarchar(5)
    Staff := g.qUser; // nvarchar(5)
    ihCurrency := g.qNativeCurrency;
    // ctrlGetString('NativeCurrency', Connection,logLevel,logPath); // nvarchar(5)
    ihCurrencyRate := 1.00; // double
    ReportDate := ''; // nvarchar(10)
    ReportTime := ''; // nvarchar(5))
    invRefrence := '';
    TotalStayTax := 0.00;
    TotalStayTaxNights := 0;
    ShowPackage := false;
    Location := '';
  end;
end;

procedure initTelLogHolder(var rec: recTelLogHolder);
begin
  with rec do
  begin
    id := 0;
    LogDateTime := 1;
    CallId := -1;
    CallStart := 1;
    ConnectedTime := '';
    RingTime := -1;
    Caller := '';
    Direction := '';
    IsInternal := false;
    CalledNumber := '';
    DialledNumber := '';
    Account := '';
    Continuation := false;
    Party1Device := '';
    Party1Name := '';
    Party2Device := '';
    Party2Name := '';
    HoldTime := -1;
    ParkTime := -1;

    RecordSource := ''; // *********        nvarchar(50)
    AuthValid := false;
    AuthCode := '';
    UserCharged := '';
    CallCharge := 0.00;
    Currency := '';
    AmountAtLastUserChange := 0.00;
    CallUnits := 0;
    UnitsAtLastUserChange := 0;
    CostPerUnit := 0;
    MarkUp := 0;
    ExternalTargetingCause := ''; // ********* nvarchar(20)
    ExternalTargeterId := ''; // ********* nvarchar(50)
    ExternalTargetedNumber := ''; // ********* nvarchar(50)

    ConnectedTimeSec := 0; // int

    Room := '';
    Description := '';
    Reservation := -1;
    RoomReservation := -1;
    InvoiceNumber := 0;
    PriceRule := '';
    PriceGroup := '';
    minutePrice := 0.00;
    startPrice := 0.00;
    chargedTime := 0;
    ChargedAmount := 0.00;
    ImportRefrence := '';
  end;
end;


const TABLES_WITH_ITEM_CODE : Array [0..4] of String =
    ('invoicelinepricechange,ItemID',
     'invoicelines,ItemID',
     'invoicelinestmp,ItemID',
     'items,Item',
     'turnoverandpayments,Item');

procedure UpdateItemCode(oldCode, newCode : String);
begin
  UpdateCodeOfTable(TABLES_WITH_ITEM_CODE, oldCode, newCode)
end;

procedure initItemTypeHolder(var rec: recItemTypeHolder);
begin
  with rec do
  begin
    active := true;
    ItemType := '';
    Description := '';
    VatCode := '';
    AccItemLink := '';
  end;
end;

procedure initItemPlusHolder(var rec: recItemPlusHolder);
begin
  with rec do
  begin
    Item := '';
    Description := '';
    Price := 0.00;
    ItemType := '';
    AccountKey := '';
    Hide := false;
    SystemItem := false;
    RoomRentItem := false;
    ReservationItem := false;
    Currency := '';

    ItemTypeDescription := '';
    VatCode := '';
    VATCodeDescription := '';
    VATPercentage := 0.00;
    ItemKind := ikUnknown;
  end;
end;

procedure initImportLogsHolderRec(var rec: recImportLogsHolder);
begin
  with rec do
  begin
    id := 0;
    DateInsert := date;
    ImportTypeID := 0;
    ImportData := '';
    ImportResultID := 0;
    Reservation := 0;
    RoomReservation := 0;
    Customer := '';

    DateExport := date;
    Itemcount := 0;
    HotelCode := '';
    Staff := '';
    RoomNumber := '';
    isGroupInvoice := false;
    invCustomer := '';
    invPersonalID := '';
    invCustomerName := '';
    invAddress1 := '';
    invAddress2 := '';
    invAddress3 := '';
    invAddress4 := '';
    GuestName := '';
    SaleRefrence := '';
    InvoiceNumber := 0;
  end;
end;

procedure initRoomReservationHolderRec(var rec: recRoomReservationHolder);
begin
  with rec do
  begin
    // ID autoinc
    RoomReservation := -1;
    Room := '';
    Reservation := -1;
    Status := 'P';
    GroupAccount := false;
    invBreakfast := true;
    Currency := g.qNativeCurrency;
    // ctrlGetString('NativeCurrency', Connection,loglevel,logPath);
    Discount := 0.00;
    Percentage := true;
    PriceType := '';
    Arrival := _dateToDBdate(date, false);
    Departure := _dateToDBdate(date + 1, false);;
    RoomType := '';
    PMInfo := '';
    HiddenInfo := '';
    RoomRentPaymentInvoice := -1;
    rrTmp := '';
    rrDescription := '';
    rrArrival := date;
    rrDeparture := date + 1;
    rrIsNoRoom := false;
    rrRoomAlias := '';
    rrRoomTypeAlias := '';
    UseStayTax := true;

    CancelDate := now;
    CancelStaff := '';
    CancelReason := '';
    CancelInformation := '';
    CancelType := -1;
    // unKnown                                                       ID
    UseInNationalReport := true;

    numGuests := 0;
    numChildren := 0;
    numInfants := 0;

    avrageRate := 0.00;
    rateCount := 0;

    // OutDated
    RoomPrice1 := 0.00;
    Price1From := _dateToDBdate(date, false);
    Price1To := _dateToDBdate(date, false);
    RoomPrice2 := 0.00;
    Price2From := _dateToDBdate(date, false);
    Price2To := _dateToDBdate(date, false);
    RoomPrice3 := 0.00;
    Price3From := _dateToDBdate(date, false);
    Price3To := _dateToDBdate(date, false);
    RoomRentPaid1 := 0.00;
    RoomRentPaid2 := 0.00;
    RoomRentPaid3 := 0.00;
    package := '';
    Hallres := 0;

    BlockMove := False;
    BlockMoveReason := '';


    ManualChannelId := 0;
    ratePlanCode := '';

  end;
end;

procedure initReservationHolderRec(var rec: recReservationHolder; aStaff: string);
begin
  with rec do
  begin
    Reservation := 0;

    Arrival := _dateToDBdate(date, false);
    Departure := _dateToDBdate(date + 1, false);
    Customer := '0';
    name := '';
    Address1 := '';
    Address2 := '';
    Address3 := '';
    Address4 := '';
    Country := '';
    Tel1 := '';
    Tel2 := '';
    Fax := '';
    CustomerEmail := '';
    CustomerWebSite := '';
    Status := '';
    ReservationDate := _dateToDBdate(date, false);
    Staff := aStaff;
    Information := '';
    PMInfo := '';
    HiddenInfo := '';
    RoomRentPaid1 := 0.00;
    RoomRentPaid2 := 0.00;
    RoomRentPaid3 := 0.00;
    RoomRentPaymentInvoice := -1;
    ContactName := '';
    ContactPhone := '';
    ContactPhone2 := '';
    ContactFax := '';
    ContactEmail := '';
    ContactAddress1 := '';
    ContactAddress2 := '';
    ContactAddress3 := '';
    ContactAddress4 := '';
    ContactCountry := '';

    inputsource := 'I';
    webconfirmed := '';
    arrivaltime := '12:00';
    srcrequest := '';
    rvTmp := '';
    custPID := '';
    invRefrence := '';
    marketSegment := '';
    UseStayTax := true;
    ContactIsmainGuest := true;
    Channel := channels_GetDefault();
    OutOfOrderBlocking := False;
  end;
end;

procedure initRoomsDateHolderRec(var rec: recRoomsDateHolder);
begin
  with rec do
  begin
    id := 0;
    ADate := _dateToDBdate(date, false);
    Room := '';
    RoomType := '';
    RoomReservation := 0;
    Reservation := 0;
    ResFlag := '';
    rdTmp := '';
    updated := false;
    isNoRoom := false;

    RoomRentBilled := 0;
    RoomRentUnBilled := 0;
    RoomDiscountBilled := 0;
    RoomDiscountUnBilled := 0;
    ItemsBilled := 0;
    ItemsUnbilled := 0;
    TaxesBilled := 0;
    TaxesUnbilled := 0;
    PriceCode := ''; // nvarchar(10)	Checked
    RoomRate := 0;
    Discount := 0;
    isPercentage := true;
    showDiscount := true;
    Paid := false;
    Currency := g.qNativeCurrency;

    // ctrlGetString('NativeCurrency', Connection,loglevel,logpath);
  end;
end;

procedure initResInfoRec(var rec: recResInfo);
begin
  with rec do
  begin
    Reservation := -1;

    bookingDate := 1;
    bookingStaff := '';

    RoomCount := 0;
    NoRoomCount := 0;

    GuestCount := 0;

    ClosedInvoiceCount := 0;
    ClosedInvoiceLineCount := 0;
    ClosedInvoiceAmount := 0.00;

    closedInvoiceItemCount := 0;
    closedInvoiceItemAmount := 0.00;

    closedInvoiceRentCount := 0;
    closedInvoiceRentAmount := 0.00;

    openInvoiceRentCount := 0;
    openInvoiceRentAmount := 0.00;

    openInvoiceItemCount := 0;
    openInvoiceItemAmount := 0.00;

    openInvoiceRentCount := 0;
    openInvoiceRentAmount := 0.00;
  end;
end;

procedure initRoomReservationRentHolder(var rec: recRoomReservationRentHolder);
begin
  with rec do
  begin
    RoomReservation := -1;
    Reservation := -1;
    PriceType := '';
    avrageRate := 0.00;
    Currency := '';
    Discount := 0.00;
    Percentage := true;
  end;
end;

procedure initRentInfoRec(var rec: recRoomsDateRentInfo);
begin
  with rec do
  begin
    RoomReservation := -1;
    Reservation := -1;
    ResFlag := '';
    isNoRoom := false;
    PriceCode := '';
    Currency := '';
    isPercentage := true;
    Discount := 0.00;
    showDiscount := true;
    Rate := 1;
    isGroupAccount := false;

    // Cacluated
    TotalRoomRent := 0.00;
    TotalDiscount := 0.00;
    RentDays := 0;
  end;
end;

procedure initRoomInfoRec(var rec: recRoomInfo);
begin
  with rec do
  begin
    Room := '';
    Description := '';
    RoomType := '';

    Bath := false;
    Shower := false;
    Safe := false;
    TV := false;
    Video := false;
    Radio := false;
    CDPlayer := false;
    Telephone := false;
    Press := false;
    Coffee := false;
    Kitchen := false;
    Minibar := false;
    Fridge := false;
    Hairdryer := false;
    InternetPlug := false;
    Fax := false;

    SqrMeters := 0.00;
    BedSize := '';
    Equipments := '';
    Bookable := false;
    Statistics := false;
    Status := '';
    OrderIndex := 0;
    hidden := false;
    Location := '';
    Floor := 0;
    id := 0;
    Dorm := '';

    RoomTypeDescription := '';
    RoomTypeNumberGuests := 0;

    RoomTypeGroup := '';
    RoomTypeGroupDescription := '';

    LocationDescription := '';
  end;
end;

procedure initCustomerHolderRec(var rec: recCustomerHolderEX);
begin
  with rec do
  begin
    Customer := '';
    CustomerName := '';
    DisplayName := '';
    PID := '';
    Address1 := '';
    Address2 := '';
    Address3 := '';
    Address4 := '';
    Tel1 := '';
    Tel2 := '';
    Fax := '';
    CountryName := '';
    Country := Country_GetDefault();
    MarketSegmentName := '';
    MarketSegmentCode := CustomerTypes_GetDefault();
    DiscountPerc := 0.00; // *  //**
    ShowDiscountPercOnInvoice := '';
    EmailAddress := '';
    HomePage := '';
    ContactPerson := '';
    ContactEmail := '';
    ContactPhone := '';
    ContactFax := '';
    isTravelAgency := false;
    Currency := g.qNativeCurrency;
    // ctrlGetString('NativeCurrency', Connection,loglevel,logpath);
    CustMemoText := '';
    priceCodeID := PriceCodes_GETRack();
    pcCode := '';
    // This is just if making reservation
    isReservation := false;
    ReservationName := '';
    GuestName := '';
    roomStatus := '';
    ReservationPaymentInfo := '';
    ReservationGeneralInfo := '';
    isGroupInvoice := false;
    StayTaxIncluted := ctrlGetBoolean('staytaxincluted');
    notes := '';
    RatePlanId := 0;
  end;
end;

procedure initCountryGroupHolder(var rec: recCountryGroupHolder);
begin
  with rec do
  begin
    CountryGroup := '';
    GroupName := '';
    islGroupName := '';
    OrderIndex := 0;

    tmp := '';

  end;
end;

procedure initChannelManagerHolder(var rec: recChannelManagerHolder);
begin
  with rec do
  begin
    Code := '';
    Description := '';
    serviceUsername := '';
    webserviceURI := '';
    servicePassword := '';
    webserviceHotelCode := '';
    serviceRequestorID := '';

    active := true;
    sendRate := true;
    sendAvailability := true;
    sendStopSell := true;
    sendMinStay := true;

    portalAdminUsername := '';
    portalAdminPassword := '';
    channels := '';

    tmp := '';
    maintenanceDays := 400;
    directConnection := false;
  end;
end;

procedure initPriceTypeHolder(var rec: recPriceTypeHolder);
begin
  with rec do
  begin
    id := 0;
    seasonId := 0;
    priceCodeID := 0;
    RoomType := '';
    Currency := '';
    Description := '';
    Price1Person := 0.00;
    Price2Persons := 0.00;
    Price3Persons := 0.00;
    Price4Persons := 0.00;
    Price5Persons := 0.00;
    Price6Persons := 0.00;
    PriceExtraPerson := 0.00;
    RoundType := 0;
    RoundStartAt := 0;
    PriceType := '';
    active := true;
  end;
end;

function GetRackPrices(priceCodeID, seasonId: integer; RoomType, Currency: string): recPriceTypeHolder;
var
  s: string;
  RackPriceID: integer;
  rSet: TRoomerDataSet;
begin
  RackPriceID := GET_PriceCodeRackID();
  initPriceTypeHolder(result);

  // s := '';
  // s := s + 'SELECT ' + chr(10);
  // s := s + '* ' + chr(10);
  // s := s + 'FROM ' + chr(10);
  // s := s + '  viewRoomPrices1 ' + chr(10);
  // s := s + 'WHERE  ' + chr(10);
  // s := s + '( (Id > -1) ' + chr(10); // just to start then AND sequance
  // s := s + ' AND (pcID=' + inttostr(RackPriceID) + ') ' + chr(10);
  // s := s + ' AND (RoomType=' + quotedstr(RoomType) + ') ' + chr(10);
  // s := s + ' AND (Currency=' + quotedstr(Currency) + ') ' + chr(10);
  // if priceCodeID <> RackPriceID then
  // s := s + ' AND (seID=' + inttostr(seasonId) + ') ' + chr(10);
  // s := s + ' ) ' + chr(10);

  s := select_GetRackPrices(priceCodeID, RackPriceID);
  s := format(s, [RackPriceID, quotedstr(RoomType), quotedstr(RoomType), quotedstr(Currency), seasonId]);

  rSet := CreateNewDataSet;
  try
    if rSet_bySQL(rSet, s) then
    begin
      result.id := rSet.fieldbyname('ID').asInteger;
      result.priceCodeID := rSet.fieldbyname('pcId').asInteger;
      result.seasonId := rSet.fieldbyname('seID').asInteger;
      result.RoomType := rSet.fieldbyname('RoomType').asString;
      result.Currency := rSet.fieldbyname('Currency').asString;
      result.Description := rSet.fieldbyname('Description').asString;
      result.Price1Person := LocalFloatValue(rSet.fieldbyname('Price1Person').asString);
      result.Price2Persons := LocalFloatValue(rSet.fieldbyname('Price2Persons').asString);
      result.Price3Persons := LocalFloatValue(rSet.fieldbyname('Price3Persons').asString);
      result.Price4Persons := LocalFloatValue(rSet.fieldbyname('Price4Persons').asString);
      result.Price5Persons := LocalFloatValue(rSet.fieldbyname('Price5Persons').asString);
      result.PriceExtraPerson := LocalFloatValue(rSet.fieldbyname('PriceExtraPerson').asString);
    end;
  finally
    freeandnil(rSet);
  end;
end;

/// /////////////////////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////////////////////
///
///
///
/// /////////////////////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////////////////////

// **************************************************************************************************************************************

function SQL_INS_InvoiceHead(theData: recInvoiceHeadHolder): string;
var
  s: string;
begin
  s := '';
  s := s + 'Insert into invoiceheads ';
  s := s + ' ( ';
  s := s + '     Reservation ';
  s := s + '    ,RoomReservation ';
  s := s + '    ,SplitNumber ';
  s := s + '    ,InvoiceNumber ';
  s := s + '    ,InvoiceDate ';
  s := s + '    ,Customer ';
  s := s + '    ,Name ';
  s := s + '    ,Address1 ';
  s := s + '    ,Address2 ';
  s := s + '    ,Address3 ';
  s := s + '    ,Address4 ';
  s := s + '    ,Country ';
  s := s + '    ,Total ';
  s := s + '    ,TotalWOVAT ';
  s := s + '    ,TotalVAT ';
  s := s + '    ,TotalBreakFast ';
  s := s + '    ,ExtraText ';
  s := s + '    ,Finished ';
  s := s + '    ,CreditInvoice ';
  s := s + '    ,OriginalInvoice ';
  s := s + '    ,InvoiceType ';
  s := s + '    ,ihTmp ';
  s := s + '    ,custPID ';
  s := s + '    ,RoomGuest ';
  s := s + '    ,ihDate ';
  s := s + '    ,ihInvoiceDate ';
  s := s + '    ,ihConfirmDate ';
  s := s + '    ,ihPayDate ';
  s := s + '    ,ihStaff ';
  s := s + '    ,ihCurrency ';
  s := s + '    ,ihCurrencyRate ';
  s := s + '    ,ReportDate ';
  s := s + '    ,ReportTime ';
  s := s + '    ,invRefrence ';
  s := s + '    ,TotalStayTax ';
  s := s + '    ,TotalStayTaxNights ';
  s := s + '    ,showpackage ';
  s := s + '    ,Location ';
  s := s + '    ,Staff ';
  s := s + ' ) ';
  s := s + '  VALUES ( ';
  s := s + '    ' + _db(theData.Reservation) + #10;
  s := s + '  , ' + _db(theData.RoomReservation) + #10;
  s := s + '  , ' + _db(theData.SplitNumber) + #10;
  s := s + '  , ' + _db(theData.InvoiceNumber) + #10;
  s := s + '  , ' + _db(theData.InvoiceDate) + #10;
  s := s + '  , ' + _db(theData.Customer) + #10;
  s := s + '  , ' + _db(theData.name) + #10;
  s := s + '  , ' + _db(theData.Address1) + #10;
  s := s + '  , ' + _db(theData.Address2) + #10;
  s := s + '  , ' + _db(theData.Address3) + #10;
  s := s + '  , ' + _db(theData.Address4) + #10;
  s := s + '  , ' + _db(theData.Country) + #10;
  s := s + '  , ' + _db(theData.Total) + #10;
  s := s + '  , ' + _db(theData.TotalWOVAT) + #10;
  s := s + '  , ' + _db(theData.TotalVAT) + #10;
  s := s + '  , ' + _db(theData.TotalBreakFast) + #10;
  s := s + '  , ' + _db(theData.ExtraText) + #10;
  s := s + '  , ' + _db(theData.Finished) + #10;
  s := s + '  , ' + _db(theData.CreditInvoice) + #10;
  s := s + '  , ' + _db(theData.OriginalInvoice) + #10;
  s := s + '  , ' + _db(theData.InvoiceType) + #10;
  s := s + '  , ' + _db(theData.ihTmp) + #10;
  s := s + '  , ' + _db(theData.custPID) + #10;
  s := s + '  , ' + _db(theData.RoomGuest) + #10;
  s := s + '  , ' + _db(theData.ihDate) + #10;
  s := s + '  , ' + _db(theData.ihInvoiceDate) + #10;
  s := s + '  , ' + _db(theData.ihConfirmDate) + #10;
  s := s + '  , ' + _db(theData.ihPayDate) + #10;
  s := s + '  , ' + _db(theData.ihStaff) + #10;
  s := s + '  , ' + _db(theData.ihCurrency) + #10;
  s := s + '  , ' + _db(theData.ihCurrencyRate) + #10;
  s := s + '  , ' + _db(theData.ReportDate) + #10;
  s := s + '  , ' + _db(theData.ReportTime) + #10;
  s := s + '  , ' + _db(theData.invRefrence) + #10;
  s := s + '  , ' + _db(theData.TotalStayTax) + #10;
  s := s + '  , ' + _db(theData.TotalStayTaxNights) + #10;
  s := s + '  , ' + _db(theData.ShowPackage) + #10;
  s := s + '  , ' + _db(theData.Location) + #10;
  s := s + '  , ' + _db(theData.Staff) + #10;
  s := s + '  ) ';
  result := s;
end;

function SQL_INS_Payment(theData: recPaymentHolder): string;
var
  s: string;
begin
  s := '';
  s := s + 'Insert into payments '#10;
  s := s + ' ( ';
  s := s + '     Reservation '#10;
  s := s + '    ,RoomReservation '#10;
  s := s + '    ,Person '#10;
  s := s + '    ,AutoGen '#10;
  s := s + '    ,TypeIndex '#10;
  s := s + '    ,InvoiceNumber '#10;
  s := s + '    ,PayDate '#10;
  s := s + '    ,Customer '#10;
  s := s + '    ,PayType '#10;
  s := s + '    ,Amount '#10;
  s := s + '    ,Description '#10;
  s := s + '    ,CurrencyRate '#10;
  s := s + '    ,Currency '#10;
  s := s + '    ,ReportDate '#10;
  s := s + '    ,ReportTime '#10;
  s := s + '    ,Ayear '#10;
  s := s + '    ,Amon '#10;
  s := s + '    ,Aday '#10;
  s := s + '    ,pmTmp '#10;
  s := s + '    ,confirmDate '#10;
  s := s + '    ,Notes '#10;
  s := s + '    ,staff '#10;
  s := s + '    ,InvoiceIndex '#10;
  s := s + ' ) ';
  s := s + '  VALUES ( ';
  s := s + '    ' + _db(theData.Reservation) + #10;
  s := s + '  , ' + _db(theData.RoomReservation) + #10;
  s := s + '  , ' + _db(theData.Person) + #10;
  s := s + '  , ' + _db(theData.AutoGen) + #10;
  s := s + '  , ' + _db(theData.TypeIndex) + #10;
  s := s + '  , ' + _db(theData.InvoiceNumber) + #10;
  s := s + '  , ' + _db(theData.PayDate) + #10;
  s := s + '  , ' + _db(theData.Customer) + #10;
  s := s + '  , ' + _db(theData.PayType) + #10;
  s := s + '  , ' + _db(theData.Amount) + #10;
  s := s + '  , ' + _db(theData.Description) + #10;
  s := s + '  , ' + _db(theData.CurrencyRate) + #10;
  s := s + '  , ' + _db(theData.Currency) + #10;
  s := s + '  , ' + _db(theData.ReportDate) + #10;
  s := s + '  , ' + _db(theData.ReportTime) + #10;
  s := s + '  , ' + _db(theData.Ayear) + #10;
  s := s + '  , ' + _db(theData.Amon) + #10;
  s := s + '  , ' + _db(theData.Aday) + #10;
  s := s + '  , ' + _db(theData.pmTmp) + #10;
  s := s + '  , ' + _db(theData.confirmDate) + #10;
  s := s + '  , ' + _db(theData.Notes) + #10;
  s := s + '  , ' + _db(theData.staff) + #10;
  s := s + '  , ' + _db(theData.InvoiceIndex) + #10;
  s := s + '  ) ';
  result := s;
end;

function INS_Payment(theData: recPaymentHolder; var NewID: integer): boolean;
var
  s: string;
begin
  s := '';
  s := SQL_INS_Payment(theData);
  result := cmd_bySQL(s);

  if result then
  begin
    NewID := GetLastID('payments');
    try
          AddInvoiceActivityLog(g.quser
                               ,theData.reservation
                               ,theData.RoomReservation
                               ,theData.TypeIndex
                               ,ADD_PAYMENT
                               ,theData.PayType
                               ,theData.Amount
                               ,theData.InvoiceNumber
                               ,theData.Description);
    Except
    end;

  end;

end;

function SP_INS_InvoiceHead(theData: recInvoiceHeadHolder): boolean;
begin
  result := cmd_bySQL(SQL_INS_InvoiceHead(theData));
end;

function SQL_INS_InvoiceLine(theData: recInvoiceLineHolder): string;
var
  s: string;
begin
  s := '';
  s := s + 'INSERT INTO invoicelines ' + #10;
  s := s + '   (AutoGen ' + #10;
  s := s + '   ,Reservation ' + #10;
  s := s + '   ,RoomReservation ' + #10;
  s := s + '   ,SplitNumber ' + #10;
  s := s + '   ,ItemNumber ' + #10;
  s := s + '   ,PurchaseDate ' + #10;
  s := s + '   ,InvoiceNumber ' + #10;
  s := s + '   ,ItemID ' + #10;
  s := s + '   ,Number ' + #10;
  s := s + '   ,Description ' + #10;
  s := s + '   ,Price ' + #10;
  s := s + '   ,VATType ' + #10;
  s := s + '   ,Total ' + #10;
  s := s + '   ,TotalWOVat ' + #10;
  s := s + '   ,Vat ' + #10;
  s := s + '   ,AutoGenerated ' + #10;
  s := s + '   ,CurrencyRate ' + #10;
  s := s + '   ,Currency ' + #10;
  s := s + '   ,Persons ' + #10;
  s := s + '   ,Nights ' + #10;
  s := s + '   ,BreakfastPrice ' + #10;
  s := s + '   ,Ayear ' + #10;
  s := s + '   ,Amon ' + #10;
  s := s + '   ,Aday ' + #10;
  s := s + '   ,ilTmp ' + #10;
  s := s + '   ,ilAccountKey ' + #10;
  s := s + '   ,ItemCurrency ' + #10;
  s := s + '   ,ItemCurrencyRate ' + #10;
  s := s + '   ,Discount ' + #10;
  s := s + '   ,Discount_isprecent ' + #10;
  s := s + '   ,ImportRefrence ' + #10;
  s := s + '   ,ImportSource ' + #10;
  s := s + '   ,isPackage ' + #10;
  s := s + '   ,confirmDate ' + #10;
  s := s + '   ,confirmAmount ' + #10;
  s := s + '   ,RoomReservationAlias ' + #10;
  s := s + '   ,RevenueCorrection' + #10;
  s := s + ' ) ' + #10;
  s := s + ' VALUES ' + #10;
  s := s + ' ( ' + #10;
  s := s + '   ' + _db(theData.AutoGen) + #10;
  s := s + ' , ' + _db(theData.Reservation) + #10;
  s := s + ' , ' + _db(theData.RoomReservation) + #10;
  s := s + ' , ' + _db(theData.SplitNumber) + #10;
  s := s + ' , ' + _db(theData.ItemNumber) + #10;
  s := s + ' , ' + _db(theData.PurchaseDate) + #10;
  s := s + ' , ' + _db(theData.InvoiceNumber) + #10;
  s := s + ' , ' + _db(theData.ItemID) + #10;
  s := s + ' , ' + _db(theData.Number) + #10;
  s := s + ' , ' + _db(theData.Description) + #10;
  s := s + ' , ' + _db(theData.Price) + #10;
  s := s + ' , ' + _db(theData.VATType) + #10;
  s := s + ' , ' + _db(theData.Total) + #10;
  s := s + ' , ' + _db(theData.TotalWOVAT) + #10;
  s := s + ' , ' + _db(theData.VAT) + #10;
  s := s + ' , ' + _db(theData.AutoGenerated) + #10;
  s := s + ' , ' + _db(theData.CurrencyRate) + #10;
  s := s + ' , ' + _db(theData.Currency) + #10;
  s := s + ' , ' + _db(theData.Persons) + #10;
  s := s + ' , ' + _db(theData.Nights) + #10;
  s := s + ' , ' + _db(theData.BreakfastPrice) + #10;
  s := s + ' , ' + _db(theData.Ayear) + #10;
  s := s + ' , ' + _db(theData.Amon) + #10;
  s := s + ' , ' + _db(theData.Aday) + #10;
  s := s + ' , ' + _db(theData.ilTmp) + #10;
  s := s + ' , ' + _db(theData.ilAccountKey) + #10;
  s := s + ' , ' + _db(theData.ItemCurrency) + #10;
  s := s + ' , ' + _db(theData.ItemCurrencyRate) + #10;
  s := s + ' , ' + _db(theData.Discount) + #10;
  s := s + ' , ' + _db(theData.Discount_isPrecent) + #10;
  s := s + ' , ' + _db(theData.ImportRefrence) + #10;
  s := s + ' , ' + _db(theData.ImportSource) + #10;
  s := s + ' , ' + _db(theData.IsPackage) + #10;
  s := s + ' , ' + _db(theData.confirmDate) + #10;
  s := s + ' , ' + _db(theData.confirmAmount) + #10;
  s := s + ' , ' + _db(theData.RoomReservationAlias) + #10;
  s := s + ' , ' + _db(theData.RevenueCorrection) + #10;
  s := s + ' )';
  result := s;

end;

function SP_INS_InvoiceLine(theData: recInvoiceLineHolder): boolean;
var
  s: string;
begin
  s := SQL_INS_InvoiceLine(theData);
  result := cmd_bySQL(s);
end;

function SP_INS_Item(theData: recItemPlusHolder): boolean;
var
  s: string;
begin
  s := '';
  s := 'INSERT INTO items ' + #10;
  s := '   ( ' + #10;
  s := '     Item ' + #10;
  s := '    ,Description ' + #10;
  s := '    ,Price ' + #10;
  s := '    ,Itemtype ' + #10;
  s := '    ,AccountKey ' + #10;
  s := '    ,Hide ' + #10;
  s := '    ,SystemItem ' + #10;
  s := '    ,RoomRentitem ' + #10;
  s := '    ,ReservationItem ' + #10;
  s := '    ,Currency ' + #10;
  s := '   ) ' + #10;
  s := '   VALUES ' + #10;
  s := '   ( ' + #10;
  s := '     ' + _db(theData.Item) + #10;
  s := '     , ' + _db(theData.Description) + #10;
  s := '     , ' + _db(theData.Price) + #10;
  s := '     , ' + _db(theData.ItemType) + #10;
  s := '     , ' + _db(theData.AccountKey) + #10;
  s := '     , ' + _db(theData.Hide) + #10;
  s := '     , ' + _db(theData.SystemItem) + #10;
  s := '     , ' + _db(theData.RoomRentItem) + #10;
  s := '     , ' + _db(theData.ReservationItem) + #10;
  s := '     , ' + _db(theData.Currency) + #10;
  s := '   ) ' + #10;
  result := cmd_bySQL(s);
end;

function SQL_INS_Reservation(theData: recReservationHolder): String;
var
  s: string;
begin
  s := '';
  s := s + 'Insert into reservations '#10;
  s := s + ' ( '#10;
  s := s + '  	Reservation '#10;
  s := s + ' 	,Arrival '#10;
  s := s + ' 	,Departure '#10;
  s := s + ' 	,Customer '#10;
  s := s + ' 	,Name '#10;
  s := s + ' 	,Address1 '#10;
  s := s + ' 	,Address2 '#10;
  s := s + ' 	,Address3 '#10;
  s := s + ' 	,Address4 '#10;
  s := s + ' 	,Country '#10;
  s := s + ' 	,Tel1 '#10;
  s := s + ' 	,Tel2 '#10;
  s := s + ' 	,Fax '#10;
  s := s + ' 	,Status '#10;
  s := s + ' 	,ReservationDate '#10;
  s := s + ' 	,Staff '#10;
  s := s + ' 	,Information '#10;
  s := s + ' 	,PMInfo '#10;
  s := s + ' 	,HiddenInfo '#10;
  s := s + ' 	,RoomRentPaid1 '#10;
  s := s + ' 	,RoomRentPaid2 '#10;
  s := s + ' 	,RoomRentPaid3 '#10;
  s := s + ' 	,RoomRentPaymentInvoice '#10;
  s := s + ' 	,ContactName '#10;
  s := s + ' 	,ContactPhone '#10;
  s := s + ' 	,ContactPhone2 '#10;
  s := s + ' 	,ContactFax '#10;
  s := s + ' 	,ContactEmail '#10;
  s := s + ' 	,ContactAddress1 '#10;
  s := s + ' 	,ContactAddress2 '#10;
  s := s + ' 	,ContactAddress3 '#10;
  s := s + ' 	,ContactAddress4 '#10;
  s := s + ' 	,ContactCountry '#10;
  s := s + ' 	,inputsource '#10;
  s := s + ' 	,webconfirmed '#10;
  s := s + ' 	,arrivaltime '#10;
  s := s + ' 	,srcrequest '#10;
  s := s + ' 	,rvTmp '#10;
  s := s + ' 	,CustPID '#10;
  s := s + ' 	,invRefrence '#10;
  s := s + ' 	,marketSegment '#10;
  s := s + ' 	,CustomerEmail '#10;
  s := s + ' 	,CustomerWebsite '#10;
  s := s + ' 	,UseStayTax '#10;
  s := s + ' 	,Channel '#10;
  s := s + ' 	,OutOfOrderBlocking '#10;
  s := s + ' 	,Market '#10;
  s := s + ' '#10;
  s := s + ' ) '#10;
  s := s + '   VALUES ( '#10;
  s := s + '   ' + inttostr(theData.Reservation) + #10;
  s := s + ' 	, ' + quotedstr(theData.Arrival) + #10;
  s := s + ' 	, ' + quotedstr(theData.Departure) + #10;
  s := s + ' 	, ' + quotedstr(theData.Customer) + #10;
  s := s + ' 	, ' + quotedstr(theData.name) + #10;
  s := s + ' 	, ' + quotedstr(theData.Address1) + #10;
  s := s + ' 	, ' + quotedstr(theData.Address2) + #10;
  s := s + ' 	, ' + quotedstr(theData.Address3) + #10;
  s := s + ' 	, ' + quotedstr(theData.Address4) + #10;
  s := s + ' 	, ' + quotedstr(theData.Country) + #10;
  s := s + ' 	, ' + quotedstr(theData.Tel1) + #10;
  s := s + ' 	, ' + quotedstr(theData.Tel2) + #10;
  s := s + ' 	, ' + quotedstr(theData.Fax) + #10;
  s := s + ' 	, ' + quotedstr(theData.Status) + #10;
  s := s + ' 	, ' + quotedstr(theData.ReservationDate) + #10;
  s := s + ' 	, ' + quotedstr(theData.Staff) + #10;
  s := s + ' 	, ' + quotedstr(theData.Information) + #10;
  s := s + ' 	, ' + quotedstr(theData.PMInfo) + #10;
  s := s + ' 	, ' + quotedstr(theData.HiddenInfo) + #10;
  s := s + ' 	, ' + _db(theData.RoomRentPaid1) + #10;
  s := s + ' 	, ' + _db(theData.RoomRentPaid2) + #10;
  s := s + ' 	, ' + _db(theData.RoomRentPaid3) + #10;
  s := s + ' 	, ' + inttostr(theData.RoomRentPaymentInvoice) + #10;
  s := s + ' 	, ' + quotedstr(theData.ContactName) + #10;
  s := s + ' 	, ' + quotedstr(theData.ContactPhone) + #10;
  s := s + ' 	, ' + quotedstr(theData.ContactPhone2) + #10;
  s := s + ' 	, ' + quotedstr(theData.ContactFax) + #10;
  s := s + ' 	, ' + quotedstr(theData.ContactEmail) + #10;
  s := s + ' 	, ' + quotedstr(theData.ContactAddress1) + #10;
  s := s + ' 	, ' + quotedstr(theData.ContactAddress2) + #10;
  s := s + ' 	, ' + quotedstr(theData.ContactAddress3) + #10;
  s := s + ' 	, ' + quotedstr(theData.ContactAddress4) + #10;
  s := s + ' 	, ' + quotedstr(theData.ContactCountry) + #10;
  s := s + ' 	, ' + quotedstr(theData.inputsource) + #10;
  s := s + ' 	, ' + quotedstr(theData.webconfirmed) + #10;
  s := s + ' 	, ' + quotedstr(theData.arrivaltime) + #10;
  s := s + ' 	, ' + quotedstr(theData.srcrequest) + #10;
  s := s + ' 	, ' + quotedstr(theData.rvTmp) + #10;
  s := s + ' 	, ' + quotedstr(theData.custPID) + #10;
  s := s + ' 	, ' + quotedstr(theData.invRefrence) + #10;
  s := s + ' 	, ' + quotedstr(theData.marketSegment) + #10;
  s := s + ' 	, ' + quotedstr(theData.CustomerEmail) + #10;
  s := s + ' 	, ' + quotedstr(theData.CustomerWebSite) + #10;
  s := s + ' 	, ' + _db(theData.UseStayTax) + #10;
  s := s + ' 	, ' + _db(theData.Channel) + #10;
  s := s + ' 	, ' + _db(theData.OutOfOrderBlocking) + #10;
  s := s + ' 	, ' + _db(theData.Market.ToDBString) + #10;
  s := s + '   ) ';
  result := s;
  copytoclipboard(s);
end;

function SP_INS_Reservation(theData: recReservationHolder): boolean;
var
  s: string;
begin
  s := SQL_INS_Reservation(theData);
  result := cmd_bySQL(s);
end;

function SP_INS_DelReservation(theData: recReservationHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'Insert into [tblDelReservations] ' + #10;
  s := s + ' ( ' + #10;
  s := s + '  	[Reservation] ' + #10;
  s := s + ' 	,[Arrival] ' + #10;
  s := s + ' 	,[Departure] ' + #10;
  s := s + ' 	,[Customer] ' + #10;
  s := s + ' 	,[Name] ' + #10;
  s := s + ' 	,[Address1] ' + #10;
  s := s + ' 	,[Address2] ' + #10;
  s := s + ' 	,[Address3] ' + #10;
  s := s + ' 	,[Address4] ' + #10;
  s := s + ' 	,[Country] ' + #10;
  s := s + ' 	,[Tel1] ' + #10;
  s := s + ' 	,[Tel2] ' + #10;
  s := s + ' 	,[Fax] ' + #10;
  s := s + ' 	,[Status] ' + #10;
  s := s + ' 	,[ReservationDate] ' + #10;
  s := s + ' 	,[Staff] ' + #10;
  s := s + ' 	,[Information] ' + #10;
  s := s + ' 	,[PMInfo] ' + #10;
  s := s + ' 	,[HiddenInfo] ' + #10;
  s := s + ' 	,[RoomRentPaid1] ' + #10;
  s := s + ' 	,[RoomRentPaid2] ' + #10;
  s := s + ' 	,[RoomRentPaid3] ' + #10;
  s := s + ' 	,[RoomRentPaymentInvoice] ' + #10;
  s := s + ' 	,[ContactName] ' + #10;
  s := s + ' 	,[ContactPhone] ' + #10;
  s := s + ' 	,[ContactFax] ' + #10;
  s := s + ' 	,[ContactEmail] ' + #10;
  s := s + ' 	,[inputsource] ' + #10;
  s := s + ' 	,[webconfirmed] ' + #10;
  s := s + ' 	,[arrivaltime] ' + #10;
  s := s + ' 	,[srcrequest] ' + #10;
  s := s + ' 	,[rvTmp] ' + #10;
  s := s + ' 	,[CustPID] ' + #10;
  s := s + ' 	,[invRefrence] ' + #10;
  s := s + ' 	,[marketSegment] ' + #10;
  s := s + ' 	,[CustomerEmail] ' + #10;
  s := s + ' 	,[CustomerWebsite] ' + #10;
  s := s + ' 	,[UseStayTax] ' + #10;
  s := s + ' ) ' + #10;
  s := s + '   VALUES ( ' + #10;
  s := s + '    ' + _db(theData.Reservation) + #10;
  s := s + ' 	, ' + _db(theData.Arrival) + #10;
  s := s + ' 	, ' + _db(theData.Departure) + #10;
  s := s + ' 	, ' + _db(theData.Customer) + #10;
  s := s + ' 	, ' + _db(theData.name) + #10;
  s := s + ' 	, ' + _db(theData.Address1) + #10;
  s := s + ' 	, ' + _db(theData.Address2) + #10;
  s := s + ' 	, ' + _db(theData.Address3) + #10;
  s := s + ' 	, ' + _db(theData.Address4) + #10;
  s := s + ' 	, ' + _db(theData.Country) + #10;
  s := s + ' 	, ' + _db(theData.Tel1) + #10;
  s := s + ' 	, ' + _db(theData.Tel2) + #10;
  s := s + ' 	, ' + _db(theData.Fax) + #10;
  s := s + ' 	, ' + _db(theData.Status) + #10;
  s := s + ' 	, ' + _db(theData.ReservationDate) + #10;
  s := s + ' 	, ' + _db(theData.Staff) + #10;
  s := s + ' 	, ' + _db(theData.Information) + #10;
  s := s + ' 	, ' + _db(theData.PMInfo) + #10;
  s := s + ' 	, ' + _db(theData.HiddenInfo) + #10;
  s := s + ' 	, ' + _db(theData.RoomRentPaid1) + #10;
  s := s + ' 	, ' + _db(theData.RoomRentPaid2) + #10;
  s := s + ' 	, ' + _db(theData.RoomRentPaid3) + #10;
  s := s + ' 	, ' + _db(theData.RoomRentPaymentInvoice) + #10;
  s := s + ' 	, ' + _db(theData.ContactName) + #10;
  s := s + ' 	, ' + _db(theData.ContactPhone) + #10;
  s := s + ' 	, ' + _db(theData.ContactFax) + #10;
  s := s + ' 	, ' + _db(theData.ContactEmail) + #10;
  s := s + ' 	, ' + _db(theData.inputsource) + #10;
  s := s + ' 	, ' + _db(theData.webconfirmed) + #10;
  s := s + ' 	, ' + _db(theData.arrivaltime) + #10;
  s := s + ' 	, ' + _db(theData.srcrequest) + #10;
  s := s + ' 	, ' + _db(theData.rvTmp) + #10;
  s := s + ' 	, ' + _db(theData.custPID) + #10;
  s := s + ' 	, ' + _db(theData.invRefrence) + #10;
  s := s + ' 	, ' + _db(theData.marketSegment) + #10;
  s := s + ' 	, ' + _db(theData.CustomerEmail) + #10;
  s := s + ' 	, ' + _db(theData.CustomerWebSite) + #10;
  s := s + ' 	, ' + _db(theData.UseStayTax) + #10;
  s := s + '   ) ';
  result := cmd_bySQL(s);
end;

function SQL_INS_RoomReservation(theData: recRoomReservationHolder): string;
var
  b: TStringBuilder;

  function AddFormattedTime(const aTimeStr: string): string;
  var
    lDateTime: TDateTime;
  begin
    if aTimeSTr.IsEmpty or not TryStrToTime(aTimeStr, lDateTime) then
      Result := _db('') + #10
    else
      Result := _db(TTime(lDateTime)) + #10;
  end;


begin
  b := TStringBuilder.Create;
  try
    b.Append('INSERT INTO ' + #10);
    b.Append('roomreservations ' + #10);
    b.Append(' ( ' + #10);
    b.Append('    `RoomReservation` ' + #10);
    b.Append('   ,`Room` ' + #10);
    b.Append('   ,`Reservation` ' + #10);
    b.Append('   ,`Status` ' + #10);
    b.Append('   ,`GroupAccount` ' + #10);
    b.Append('   ,`invBreakfast` ' + #10);
    b.Append('   ,`RoomPrice1` ' + #10);
    b.Append('   ,`Price1From` ' + #10);
    b.Append('   ,`Price1To` ' + #10);
    b.Append('   ,`RoomPrice2` ' + #10);
    b.Append('   ,`Price2From` ' + #10);
    b.Append('   ,`Price2To` ' + #10);
    b.Append('   ,`RoomPrice3` ' + #10);
    b.Append('   ,`Price3From` ' + #10);
    b.Append('   ,`Price3To` ' + #10);
    b.Append('   ,`Currency` ' + #10);
    b.Append('   ,`Discount` ' + #10);
    b.Append('   ,`Percentage` ' + #10);
    b.Append('   ,`PriceType` ' + #10);
    b.Append('   ,`Arrival` ' + #10);
    b.Append('   ,`Departure` ' + #10);
    b.Append('   ,`RoomType` ' + #10);
    b.Append('   ,`PMInfo` ' + #10);
    b.Append('   ,`HiddenInfo` ' + #10);
    b.Append('   ,`RoomRentPaid1` ' + #10);
    b.Append('   ,`RoomRentPaid2` ' + #10);
    b.Append('   ,`RoomRentPaid3` ' + #10);
    b.Append('   ,`RoomRentPaymentInvoice` ' + #10);
    b.Append('   ,`Hallres` ' + #10);
    b.Append('   ,`rrTmp` ' + #10);
    b.Append('   ,`rrDescription` ' + #10);
    b.Append('   ,`rrArrival` ' + #10);
    b.Append('   ,`rrDeparture` ' + #10);
    b.Append('   ,`rrIsNoRoom` ' + #10);
    b.Append('   ,`rrRoomAlias` ' + #10);
    b.Append('   ,`rrRoomTypeAlias` ' + #10);
    b.Append('   ,`useStayTax` ' + #10);
    b.Append('   ,`useInNationalReport` ' + #10);
    b.Append('   ,`numGuests` ' + #10);
    b.Append('   ,`numChildren` ' + #10);
    b.Append('   ,`numInfants` ' + #10);
    b.Append('   ,`avrageRate` ' + #10);
    b.Append('   ,`rateCount` ' + #10);
    b.Append('   ,`Package` ' + #10);
    b.Append('   ,`ManualChannelId` ' + #10);
    b.Append('   ,`ratePlanCode` ' + #10);
    b.Append('   ,`ExpectedTimeOfArrival` ' + #10);
    b.Append('   ,`ExpectedCheckoutTime` ' + #10);
    b.Append('   ) ' + #10);
    b.Append('   VALUES ' + #10);
    b.Append('   ( ' + #10);
    b.Append(' ' + _db(theData.RoomReservation) + #10);
    b.Append('  , ' + _db(theData.Room) + #10);
    b.Append('  , ' + _db(theData.Reservation) + #10);
    b.Append('  , ' + _db(theData.Status) + #10);
    b.Append('  , ' + _db(theData.GroupAccount) + #10);
    b.Append('  , ' + _db(theData.invBreakfast) + #10);
    b.Append('  , ' + _db(theData.RoomPrice1) + #10);
    b.Append('  , ' + _db(theData.Price1From) + #10);
    b.Append('  , ' + _db(theData.Price1To) + #10);
    b.Append('  , ' + _db(theData.RoomPrice2) + #10);
    b.Append('  , ' + _db(theData.Price2From) + #10);
    b.Append('  , ' + _db(theData.Price2To) + #10);
    b.Append('  , ' + _db(theData.RoomPrice3) + #10);
    b.Append('  , ' + _db(theData.Price3From) + #10);
    b.Append('  , ' + _db(theData.Price3To) + #10);
    b.Append('  , ' + _db(theData.Currency) + #10);
    b.Append('  , ' + _db(theData.Discount) + #10);
    b.Append('  , ' + _db(theData.Percentage) + #10);
    b.Append('  , ' + _db(theData.PriceType) + #10);
    b.Append('  , ' + _db(theData.Arrival) + #10);
    b.Append('  , ' + _db(theData.Departure) + #10);
    b.Append('  , ' + _db(theData.RoomType) + #10);
    b.Append('  , ' + _db(theData.PMInfo) + #10);
    b.Append('  , ' + _db(theData.HiddenInfo) + #10);
    b.Append('  , ' + _db(theData.RoomRentPaid1) + #10);
    b.Append('  , ' + _db(theData.RoomRentPaid2) + #10);
    b.Append('  , ' + _db(theData.RoomRentPaid3) + #10);
    b.Append('  , ' + _db(theData.RoomRentPaymentInvoice) + #10);
    b.Append('  , ' + _db(theData.Hallres) + #10);
    b.Append('  , ' + _db(theData.rrTmp) + #10);
    b.Append('  , ' + _db(theData.rrDescription) + #10);
    b.Append('  , ' + _db(theData.rrArrival) + #10);
    b.Append('  , ' + _db(theData.rrDeparture) + #10);
    b.Append('  , ' + _db(theData.rrIsNoRoom) + #10);
    b.Append('  , ' + _db(theData.rrRoomAlias) + #10);
    b.Append('  , ' + _db(theData.rrRoomTypeAlias) + #10);
    b.Append('  , ' + _db(theData.UseStayTax) + #10);
    b.Append('  , ' + _db(theData.UseInNationalReport) + #10);
    b.Append('  , ' + _db(theData.numGuests) + #10);
    b.Append('  , ' + _db(theData.numChildren) + #10);
    b.Append('  , ' + _db(theData.numInfants) + #10);
    b.Append('  , ' + _db(theData.avrageRate) + #10);
    b.Append('  , ' + _db(theData.rateCount) + #10);
    b.Append('  , ' + _db(theData.package) + #10);
    b.Append('  , ' + _db(theData.ManualChannelId) + #10);
    b.Append('  , ' + _db(theData.ratePlanCode) + #10);
    b.Append('  , ' + AddFormattedTime(theData.ExpectedTimeOfArrival) + #10);
    b.Append('  , ' + AddFormattedTime(theData.ExpectedCheckoutTime) + #10);
    b.Append('  ) ' + #10);
    result := b.ToString;
  finally
    b.Free;
  end;
end;

function SP_INS_RoomReservation(theData: recRoomReservationHolder): boolean;
var
  s: string;
begin
  s := SQL_INS_RoomReservation(theData);
  result := cmd_bySQL(s);
end;

function SP_INS_DelRoomReservation(theData: recRoomReservationHolder): boolean;
var
  s: string;
begin

  s := '';
  s := s + 'INSERT INTO tbldelroomreservations ' + #10;
  s := s + ' ( ' + #10;
  s := s + '   RoomReservation ' + #10;
  s := s + '  ,Room ' + #10;
  s := s + '  ,Reservation ' + #10;
  s := s + '  ,Status ' + #10;
  s := s + '  ,GroupAccount ' + #10;
  s := s + '  ,invBreakfast ' + #10;
  s := s + '  ,RoomPrice1 ' + #10;
  s := s + '  ,Price1From ' + #10;
  s := s + '  ,Price1To ' + #10;
  s := s + '  ,RoomPrice2 ' + #10;
  s := s + '  ,Price2From ' + #10;
  s := s + '  ,Price2To ' + #10;
  s := s + '  ,RoomPrice3 ' + #10;
  s := s + '  ,Price3From ' + #10;
  s := s + '  ,Price3To ' + #10;
  s := s + '  ,Currency ' + #10;
  s := s + '  ,Discount ' + #10;
  s := s + '  ,Percentage ' + #10;
  s := s + '  ,PriceType ' + #10;
  s := s + '  ,Arrival ' + #10;
  s := s + '  ,Departure ' + #10;
  s := s + '  ,RoomType ' + #10;
  s := s + '  ,PMInfo ' + #10;
  s := s + '  ,HiddenInfo ' + #10;
  s := s + '  ,RoomRentPaid1 ' + #10;
  s := s + '  ,RoomRentPaid2 ' + #10;
  s := s + '  ,RoomRentPaid3 ' + #10;
  s := s + '  ,RoomRentPaymentInvoice ' + #10;
  s := s + '  ,Hallres ' + #10;
  s := s + '  ,rrTmp ' + #10;
  s := s + '  ,rrDescription ' + #10;
  s := s + '  ,rrArrival ' + #10;
  s := s + '  ,rrDeparture ' + #10;
  s := s + '  ,rrIsNoRoom ' + #10;
  s := s + '  ,rrRoomAlias ' + #10;
  s := s + '  ,rrRoomTypeAlias ' + #10;
  s := s + '  ,useStayTax ' + #10;
  s := s + '  ,CancelDate ' + #10;
  s := s + '  ,CancelStaff ' + #10;
  s := s + '  ,CancelReason ' + #10;
  s := s + '  ,CancelInformation ' + #10;
  s := s + '  ,CancelType ' + #10;
  s := s + '  ,useInNationalReport ' + #10;
  s := s + '  ,ExpectedTimeOfArrival' + #10;
  s := s + '  ,ExpectedCheckoutTime ' + #10;
  s := s + ' ) ' + #10;
  s := s + ' VALUES ' + #10;
  s := s + ' ( ' + #10;
  s := s + '    ' + _db(theData.RoomReservation) + #10;
  s := s + '  , ' + _db(theData.Room) + #10;
  s := s + '  , ' + _db(theData.Reservation) + #10;
  s := s + '  , ' + _db(theData.Status) + #10;
  s := s + '  , ' + _db(theData.GroupAccount) + #10;
  s := s + '  , ' + _db(theData.invBreakfast) + #10;
  s := s + '  , ' + _db(theData.RoomPrice1) + #10;
  s := s + '  , ' + _db(theData.Price1From) + #10;
  s := s + '  , ' + _db(theData.Price1To) + #10;
  s := s + '  , ' + _db(theData.RoomPrice2) + #10;
  s := s + '  , ' + _db(theData.Price2From) + #10;
  s := s + '  , ' + _db(theData.Price2To) + #10;
  s := s + '  , ' + _db(theData.RoomPrice3) + #10;
  s := s + '  , ' + _db(theData.Price3From) + #10;
  s := s + '  , ' + _db(theData.Price3To) + #10;
  s := s + '  , ' + _db(theData.Currency) + #10;
  s := s + '  , ' + _db(theData.Discount) + #10;
  s := s + '  , ' + _db(theData.Percentage) + #10;
  s := s + '  , ' + _db(theData.PriceType) + #10;
  s := s + '  , ' + _db(theData.Arrival) + #10;
  s := s + '  , ' + _db(theData.Departure) + #10;
  s := s + '  , ' + _db(theData.RoomType) + #10;
  s := s + '  , ' + _db(theData.PMInfo) + #10;
  s := s + '  , ' + _db(theData.HiddenInfo) + #10;
  s := s + '  , ' + _db(theData.RoomRentPaid1) + #10;
  s := s + '  , ' + _db(theData.RoomRentPaid2) + #10;
  s := s + '  , ' + _db(theData.RoomRentPaid3) + #10;
  s := s + '  , ' + _db(theData.RoomRentPaymentInvoice) + #10;
  s := s + '  , ' + _db(theData.Hallres) + #10;
  s := s + '  , ' + _db(theData.rrTmp) + #10;
  s := s + '  , ' + _db(theData.rrDescription) + #10;
  s := s + '  , ' + _dateToDBdate(theData.rrArrival, true) + #10;
  s := s + '  , ' + _dateToDBdate(theData.rrDeparture, true) + #10;
  s := s + '  , ' + _db(theData.rrIsNoRoom) + #10;
  s := s + '  , ' + _db(theData.rrRoomAlias) + #10;
  s := s + '  , ' + _db(theData.rrRoomTypeAlias) + #10;
  s := s + '  , ' + _db(theData.UseStayTax) + #10;
  s := s + '  , ' + _dateTimeToDBdate(theData.CancelDate, true) + #10;
  s := s + '  , ' + _db(theData.CancelStaff) + #10;
  s := s + '  , ' + _db(theData.CancelReason) + #10;
  s := s + '  , ' + _db(theData.CancelInformation) + #10;
  s := s + '  , ' + _db(theData.CancelType) + #10;
  s := s + '  , ' + _db(theData.UseInNationalReport) + #10;
  s := s + '  , ' + _db(theData.ExpectedTimeOfArrival) + #10;
  s := s + '  , ' + _db(theData.ExpectedCheckoutTime) + #10;
  s := s + ') ';

  result := cmd_bySQL(s);
end;

function SQL_INS_RoomsDate(theData: recRoomsDateHolder): string;
var
  s: string;
begin
  s := '';
  s := s + 'INSERT INTO roomsdate ' + #10;
  s := s + ' ( ' + #10;
  s := s + '     ADate ' + #10;
  s := s + '    ,Room ' + #10;
  s := s + '    ,RoomType ' + #10;
  s := s + '    ,RoomReservation ' + #10;
  s := s + '    ,Reservation ' + #10;
  s := s + '    ,ResFlag ' + #10;
  s := s + '    ,rdTmp ' + #10;
  s := s + '    ,updated ' + #10;
  s := s + '    ,isNoRoom ' + #10;
  s := s + '    ,RoomRentBilled ' + #10;
  s := s + '    ,RoomRentUnBilled ' + #10;
  s := s + '    ,RoomDiscountBilled ' + #10;
  s := s + '    ,RoomDiscountUnBilled ' + #10;
  s := s + '    ,ItemsBilled ' + #10;
  s := s + '    ,ItemsUnbilled ' + #10;
  s := s + '    ,TaxesBilled ' + #10;
  s := s + '    ,TaxesUnbilled ' + #10;
  s := s + '    ,PriceCode ' + #10;
  s := s + '    ,RoomRate ' + #10;
  s := s + '    ,Discount ' + #10;
  s := s + '    ,isPercentage ' + #10;
  s := s + '    ,showDiscount ' + #10;
  s := s + '    ,Paid ' + #10;
  s := s + '    ,Currency ' + #10;
  s := s + ' ) ' + #10;
  s := s + ' VALUES ' + #10;
  s := s + ' ( ' + #10;
  s := s + '    ' + _db(theData.ADate) + #10;
  s := s + '  , ' + _db(theData.Room) + #10;
  s := s + '  , ' + _db(theData.RoomType) + #10;
  s := s + '  , ' + _db(theData.RoomReservation) + #10;
  s := s + '  , ' + _db(theData.Reservation) + #10;
  s := s + '  , ' + _db(theData.ResFlag) + #10;
  s := s + '  , ' + _db(theData.rdTmp) + #10;
  s := s + '  , ' + _db(theData.updated) + #10;
  s := s + '  , ' + _db(theData.isNoRoom) + #10;
  s := s + '  , ' + _db(theData.RoomRentBilled) + #10;
  s := s + '  , ' + _db(theData.RoomRentUnBilled) + #10;
  s := s + '  , ' + _db(theData.RoomDiscountBilled) + #10;
  s := s + '  , ' + _db(theData.RoomDiscountUnBilled) + #10;
  s := s + '  , ' + _db(theData.ItemsBilled) + #10;
  s := s + '  , ' + _db(theData.ItemsUnbilled) + #10;
  s := s + '  , ' + _db(theData.TaxesBilled) + #10;
  s := s + '  , ' + _db(theData.TaxesUnbilled) + #10;
  s := s + '  , ' + _db(theData.PriceCode) + #10;
  s := s + '  , ' + _db(theData.RoomRate) + #10;
  s := s + '  , ' + _db(theData.Discount) + #10;
  s := s + '  , ' + _db(theData.isPercentage) + #10;
  s := s + '  , ' + _db(theData.showDiscount) + #10;
  s := s + '  , ' + _db(theData.Paid) + #10;
  s := s + '  , ' + _db(theData.Currency) + #10;
  s := s + ' ) ';
  result := s;
end;

function INS_RoomsDate(theData: recRoomsDateHolder): boolean;
var
  s: string;
begin
  s := SQL_INS_RoomsDate(theData);
  result := cmd_bySQL(s);
end;

procedure AddRoomsDate(ADate: TdateTime; Room, RoomType, ResFlag, Currency: string;

  priceID: integer;

  GuestCount, ChildCount, infantCount: integer;

  Discount: double; isPercentage, showDiscount: boolean;

  RoomReservation, Reservation, NumDays: integer; var iErrorDays: integer);

var
  rSet: TRoomerDataSet;
  sDate: string;
  ii: integer;
  theData: recRoomsDateHolder;
  Rate: double;
begin
  initRoomsDateHolderRec(theData);
  iErrorDays := 0;

  rSet := CreateNewDataSet;
  try
    for ii := trunc(ADate) to trunc(ADate) + NumDays - 1 do
    begin
      sDate := _dateToDBdate(ii, false);

      theData.ADate := sDate;

      if Room = '' then
      begin
        Room := '<' + inttostr(RoomReservation) + '>';
        theData.isNoRoom := true;
      end;

      theData.Room := Room;
      theData.RoomType := RoomType;
      theData.RoomReservation := RoomReservation;
      theData.Reservation := Reservation;
      theData.ResFlag := ResFlag;
      theData.Currency := Currency;

      theData.isPercentage := isPercentage;
      theData.showDiscount := showDiscount;
      theData.Discount := Discount;
      theData.PriceCode := PriceCode_Code(priceID);

      Rate := GetDayRate(theData.RoomType, theData.Room, ii, GuestCount, ChildCount, infantCount, theData.Currency, priceID, theData.Discount,
        theData.showDiscount, theData.isPercentage, false, false);

      theData.RoomRate := Rate;

      if not INS_RoomsDate(theData) then
      begin
        inc(iErrorDays);
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function INS_DelPerson(theData: recPersonHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'INSERT INTO tbldelpersons ' + #10;
  s := s + ' ( ' + #10;
  s := s + '    Person ' + #10;
  s := s + '   ,RoomReservation ' + #10;
  s := s + '   ,Reservation ' + #10;
  s := s + '   ,Name ' + #10;
  s := s + '   ,Surname ' + #10;
  s := s + '   ,Address1 ' + #10;
  s := s + '   ,Address2 ' + #10;
  s := s + '   ,Address3 ' + #10;
  s := s + '   ,Address4 ' + #10;
  s := s + '   ,Country ' + #10;
  s := s + '   ,Company ' + #10;
  s := s + '   ,GuestType ' + #10;
  s := s + '   ,Information ' + #10;
  s := s + '   ,PID ' + #10;
  s := s + '   ,MainName ' + #10;
  s := s + '   ,Customer ' + #10;
  s := s + '   ,peTmp ' + #10;
  s := s + '   ,hgrID ' + #10;
  // s := s+ '   ,HallReservation '+#10;
  // s := s+ '   ,Tel1 '+#10;
  // s := s+ '   ,Tel2 '+#10;
  // s := s+ '   ,Fax '+#10;
  // s := s+ '   ,Email '+#10;
  s := s + '    ) ' + #10;
  s := s + '    VALUES ' + #10;
  s := s + '    ( ' + #10;
  s := s + '     ' + _db(theData.Person) + #10;
  s := s + '   , ' + _db(theData.RoomReservation) + #10;
  s := s + '   , ' + _db(theData.Reservation) + #10;
  s := s + '   , ' + _db(theData.name) + #10;
  s := s + '   , ' + _db(theData.Surname) + #10;
  s := s + '   , ' + _db(theData.Address1) + #10;
  s := s + '   , ' + _db(theData.Address2) + #10;
  s := s + '   , ' + _db(theData.Address3) + #10;
  s := s + '   , ' + _db(theData.Address4) + #10;
  s := s + '   , ' + _db(theData.Country) + #10;
  s := s + '   , ' + _db(theData.Company) + #10;
  s := s + '   , ' + _db(theData.GuestType) + #10;
  s := s + '   , ' + _db(theData.Information) + #10;
  s := s + '   , ' + _db(theData.PID) + #10;
  s := s + '   , ' + _db(theData.MainName) + #10;
  s := s + '   , ' + _db(theData.Customer) + #10;
  s := s + '   , ' + _db(theData.peTmp) + #10;
  s := s + '   , ' + _db(theData.hgrID) + #10;
  // s := s+ '   , '  + _db(theData.tel1)+#10;
  // s := s+ '   , '  + _db(theData.tel2)+#10;
  // s := s+ '   , '  + _db(theData.fax)+#10;
  // s := s+ '   , '  + _db(theData.Email)+#10;
  s := s + ' ) ' + #10;
  result := cmd_bySQL(s);
end;

function SP_GET_RoomReservation(RoomReservation: integer): recRoomReservationHolder;
var
  rSet: TRoomerDataSet;
  sql: string;
begin
  rSet := CreateNewDataSet;
  try
    initRoomReservationHolderRec(result);

    sql := format(select_RoomReservation, [RoomReservation]);
    if hData.rSet_bySQL(rSet, sql) then
    begin
      result.id := rSet.fieldbyname('ID').asInteger;
      result.RoomReservation := rSet.fieldbyname('RoomReservation').asInteger;
      result.Room := rSet.fieldbyname('Room').asString;
      result.Reservation := rSet.fieldbyname('Reservation').asInteger;
      result.Status := rSet.fieldbyname('Status').asString;
      result.GroupAccount := rSet['GroupAccount'];
      result.invBreakfast := rSet['invBreakfast'];
      result.RoomPrice1 := LocalFloatValue(rSet.fieldbyname('RoomPrice1').asString);
      result.Price1From := rSet.fieldbyname('Price1From').asString;
      result.Price1To := rSet.fieldbyname('Price1To').asString;
      result.RoomPrice2 := LocalFloatValue(rSet.fieldbyname('RoomPrice2').asString);
      result.Price2From := rSet.fieldbyname('Price2From').asString;
      result.Price2To := rSet.fieldbyname('Price2To').asString;
      result.RoomPrice3 := LocalFloatValue(rSet.fieldbyname('RoomPrice3').asString);
      result.Price3From := rSet.fieldbyname('Price3From').asString;
      result.Price3To := rSet.fieldbyname('Price3To').asString;
      result.Currency := rSet.fieldbyname('Currency').asString;
      result.Discount := LocalFloatValue(rSet.fieldbyname('Discount').asString);
      result.Percentage := rSet['Percentage'];
      result.PriceType := rSet.fieldbyname('PriceType').asString;
      result.Arrival := rSet.fieldbyname('Arrival').asString;
      result.Departure := rSet.fieldbyname('Departure').asString;
      result.RoomType := rSet.fieldbyname('RoomType').asString;
      result.PMInfo := rSet.fieldbyname('PMInfo').asString;
      result.HiddenInfo := rSet.fieldbyname('HiddenInfo').asString;
      result.RoomRentPaid1 := LocalFloatValue(rSet.fieldbyname('RoomRentPaid1').asString);
      result.RoomRentPaid2 := LocalFloatValue(rSet.fieldbyname('RoomRentPaid2').asString);
      result.RoomRentPaid3 := LocalFloatValue(rSet.fieldbyname('RoomRentPaid3').asString);
      result.RoomRentPaymentInvoice := rSet.fieldbyname('RoomRentPaymentInvoice').asInteger;
      result.Hallres := rSet.fieldbyname('Hallres').asInteger;
      result.rrTmp := rSet.fieldbyname('rrTmp').asString;
      result.rrDescription := rSet.fieldbyname('rrDescription').asString;
      result.rrArrival := rSet.fieldbyname('rrArrival').AsDateTime;
      result.rrDeparture := rSet.fieldbyname('rrDeparture').AsDateTime;
      result.rrIsNoRoom := rSet['rrIsNoRoom'];
      result.rrRoomAlias := rSet.fieldbyname('rrRoomAlias').asString;
      result.rrRoomTypeAlias := rSet.fieldbyname('rrRoomTypeAlias').asString;
      result.UseStayTax := rSet['useStayTax'];
      result.UseInNationalReport := rSet['useInNationalReport'];
      result.BlockMove := rSet['blockMove'];
      result.BlockMoveReason := rSet['BlockMoveReason'];

      result.numGuests := rSet.fieldbyname('numGuests').asInteger;
      result.numChildren := rSet.fieldbyname('numChildren').asInteger;
      result.numInfants := rSet.fieldbyname('numInfants').asInteger;

      result.avrageRate := LocalFloatValue(rSet.fieldbyname('AvrageRate').asString);
      result.rateCount := rSet.fieldbyname('rateCount').asInteger;
      result.package := rSet.fieldbyname('package').asString;
      result.ExpectedTimeOfArrival := rSet.fieldbyname('ExpectedTimeOfArrival').AsString;
      result.ExpectedCheckoutTime := rSet.fieldbyname('ExpectedCheckoutTime').AsString;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function SP_GET_Reservation(Reservation: integer): recReservationHolder;
var
  rSet: TRoomerDataSet;
  sql: string;
begin
  rSet := CreateNewDataSet;
  try
    initReservationHolderRec(result, '');
    sql := format(select_Reservation, [Reservation]);
    if hData.rSet_bySQL(rSet, sql) then
    begin
      result.Reservation := rSet.fieldbyname('Reservation').asInteger;
      result.Arrival := rSet.fieldbyname('Arrival').asString;
      result.Departure := rSet.fieldbyname('Departure').asString;
      result.Customer := rSet.fieldbyname('Customer').asString;
      result.name := rSet.fieldbyname('name').asString;
      result.Address1 := rSet.fieldbyname('Address1').asString;
      result.Address2 := rSet.fieldbyname('Address2').asString;
      result.Address3 := rSet.fieldbyname('Address3').asString;
      result.Address4 := rSet.fieldbyname('Address4').asString;
      result.Country := rSet.fieldbyname('Country').asString;
      result.Tel1 := rSet.fieldbyname('Tel1').asString;
      result.Tel2 := rSet.fieldbyname('Tel2').asString;
      result.Fax := rSet.fieldbyname('Fax').asString;
      result.CustomerEmail := rSet.fieldbyname('CustomerEmail').asString;
      result.CustomerWebSite := rSet.fieldbyname('CustomerWebSite').asString;
      result.Status := rSet.fieldbyname('Status').asString;
      result.ReservationDate := rSet.fieldbyname('ReservationDate').asString;
      result.Staff := rSet.fieldbyname('Staff').asString;
      result.Information := rSet.fieldbyname('Information').asString;
      result.PMInfo := rSet.fieldbyname('PMInfo').asString;
      result.HiddenInfo := rSet.fieldbyname('HiddenInfo').asString;
      result.RoomRentPaid1 := LocalFloatValue(rSet.fieldbyname('RoomRentPaid1').asString);
      result.RoomRentPaid2 := LocalFloatValue(rSet.fieldbyname('RoomRentPaid2').asString);
      result.RoomRentPaid3 := LocalFloatValue(rSet.fieldbyname('RoomRentPaid3').asString);
      result.RoomRentPaymentInvoice := rSet.fieldbyname('RoomRentPaymentInvoice').asInteger;
      result.ContactName := rSet.fieldbyname('ContactName').asString;
      result.ContactPhone := rSet.fieldbyname('ContactPhone').asString;
      result.ContactPhone2 := rSet.fieldbyname('ContactPhone2').asString;
      result.ContactFax := rSet.fieldbyname('ContactFax').asString;
      result.ContactEmail := rSet.fieldbyname('ContactEmail').asString;
      result.ContactAddress1 := rSet.fieldbyname('ContactAddress1').asString;
      result.ContactAddress2 := rSet.fieldbyname('ContactAddress2').asString;
      result.ContactAddress3 := rSet.fieldbyname('ContactAddress3').asString;
      result.ContactAddress4 := rSet.fieldbyname('ContactAddress4').asString;
      result.ContactCountry := rSet.fieldbyname('ContactCountry').asString;
      result.inputsource := rSet.fieldbyname('inputsource').asString;
      result.webconfirmed := rSet.fieldbyname('webconfirmed').asString;
      result.arrivaltime := rSet.fieldbyname('arrivaltime').asString;
      result.srcrequest := rSet.fieldbyname('srcrequest').asString;
      result.rvTmp := rSet.fieldbyname('rvTmp').asString;
      result.custPID := rSet.fieldbyname('custPID').asString;
      result.invRefrence := rSet.fieldbyname('invRefrence').asString;
      result.marketSegment := rSet.fieldbyname('marketSegment').asString;
      result.UseStayTax := rSet['useStayTax'];
      result.Channel := rSet.fieldbyname('Channel').asInteger;
      result.OutOfOrderBlocking := rSet.fieldbyname('outOfOrderBlocking').asBoolean;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function GET_RoomsDate(ADate: TdateTime; RoomReservation: integer): recRoomsDateHolder;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  rSet := CreateNewDataSet;
  try
    initRoomsDateHolderRec(result);
    s := '';
    s := s + 'SELECT '#10;
    s := s + '`roomsdate`.`ADate`, '#10;
    s := s + '`roomsdate`.`Room`, '#10;
    s := s + '`roomsdate`.`RoomType`, '#10;
    s := s + '`roomsdate`.`RoomReservation`, '#10;
    s := s + '`roomsdate`.`Reservation`, '#10;
    s := s + '`roomsdate`.`ResFlag`, '#10;
    s := s + '`roomsdate`.`rdTmp`, '#10;
    s := s + '`roomsdate`.`updated`, '#10;
    s := s + '`roomsdate`.`isNoRoom`, '#10;
    s := s + '`roomsdate`.`ID`, '#10;
    s := s + '`roomsdate`.`RoomRentBilled`, '#10;
    s := s + '`roomsdate`.`RoomRentUnBilled`, '#10;
    s := s + '`roomsdate`.`RoomDiscountBilled`, '#10;
    s := s + '`roomsdate`.`RoomDiscountUnBilled`, '#10;
    s := s + '`roomsdate`.`ItemsBilled`, '#10;
    s := s + '`roomsdate`.`ItemsUnbilled`, '#10;
    s := s + '`roomsdate`.`TaxesBilled`, '#10;
    s := s + '`roomsdate`.`TaxesUnbilled`, '#10;
    s := s + '`roomsdate`.`PriceCode`, '#10;
    s := s + '`roomsdate`.`RoomRate`, '#10;
    s := s + '`roomsdate`.`Currency`, '#10;
    s := s + '`roomsdate`.`Discount`, '#10;
    s := s + '`roomsdate`.`isPercentage`, '#10;
    s := s + '`roomsdate`.`showDiscount`, '#10;
    s := s + '`roomsdate`.`Paid` '#10;
    s := s + 'FROM `roomsdate` '#10;
    s := s + 'WHERE '#10;
    s := s + '(ADate=%s) and (roomreservation=%d) '#10;

    s := format(s, [_dateToDBdate(ADate, true), RoomReservation]);

    if hData.rSet_bySQL(rSet, s) then
    begin
      // result.ID                  := Rset.FieldByName('ID'                 ).Asinteger;
      result.ADate := rSet.fieldbyname('ADate').asString;
      result.Room := rSet.fieldbyname('Room').asString;
      result.RoomType := rSet.fieldbyname('RoomType').asString;
      result.RoomReservation := rSet.fieldbyname('RoomReservation').asInteger;
      result.Reservation := rSet.fieldbyname('Reservation').asInteger;
      result.ResFlag := rSet.fieldbyname('ResFlag').asString;
      result.rdTmp := rSet.fieldbyname('rdTmp').asString;
      result.updated := rSet.fieldbyname('updated').Asboolean;
      result.isNoRoom := rSet.fieldbyname('isNoRoom').Asboolean;
      result.RoomRentBilled := rSet.GetFloatValue(rSet.fieldbyname('RoomRentBilled'));
      result.RoomRentUnBilled := rSet.GetFloatValue(rSet.fieldbyname('RoomRentUnBilled'));
      result.RoomDiscountBilled := rSet.GetFloatValue(rSet.fieldbyname('RoomDiscountBilled'));
      result.RoomDiscountUnBilled := rSet.GetFloatValue(rSet.fieldbyname('RoomDiscountUnBilled'));
      result.ItemsBilled := rSet.GetFloatValue(rSet.fieldbyname('ItemsBilled'));
      result.ItemsUnbilled := rSet.GetFloatValue(rSet.fieldbyname('ItemsUnbilled'));
      result.TaxesBilled := rSet.GetFloatValue(rSet.fieldbyname('TaxesBilled'));
      result.TaxesUnbilled := rSet.GetFloatValue(rSet.fieldbyname('TaxesUnbilled'));
      result.PriceCode := rSet.fieldbyname('PriceCode').asString;
      result.RoomRate := rSet.GetFloatValue(rSet.fieldbyname('RoomRate'));
      result.Discount := rSet.GetFloatValue(rSet.fieldbyname('Discount'));
      result.isPercentage := rSet.fieldbyname('isPercentage').Asboolean;
      result.showDiscount := rSet.fieldbyname('showDiscount').Asboolean;
      result.Paid := rSet.fieldbyname('Paid').Asboolean;
      result.Currency := rSet.fieldbyname('Currency').asString;
    end;
  finally
    freeandnil(rSet);
  end;
end;



// ------------------------------------------------------------------------------------------------

function SP_UPD_tblRoomStatusByDateRangeAndRoomType(RoomType: string; available: integer; FromDate, ToDate: Tdate): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE tblroomstatus ' + #10;
  s := s + ' SET ' + #10;
  s := s + '     available  = ' + _db(available) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '       (resDate >= ' + _db(FromDate) + ') ' + #10;
  s := s + '   AND (resDate < ' + _db(ToDate) + ') ' + #10;
  s := s + '   AND (roomType = ' + _db(RoomType) + ') ' + #10;
  result := cmd_bySQL(s);
end;

/// ///////////////////////////////////////////////////////////////////////////////////////////
//
//
/// ///////////////////////////////////////////////////////////////////////////////////////////

function ctrlGetString(aField: string): string;
// var
// Rset : TRoomerDataSet;
// s : string;
begin
  result := glb.ControlSet.fieldbyname(aField).asString;
  // RSet := CreateNewDataSet;
  // try
  // s := format(select_ctrlGetString, [aField]);
  // if hData.rSet_bySQL(rSet,s, Connection,LogLevel,logPath) then
  // begin
  // result := trim(Rset.FieldByName(aField).AsString);
  // end;
  // finally
  // freeandnil(Rset);
  // end;
end;

function ctrlGetFloat(aField: string): double;
// var
// Rset : TRoomerDataSet;
// s : string;
begin
  result := glb.ControlSet.GetFloatValue(glb.ControlSet.fieldbyname(aField));

  // RSet := CreateNewDataSet;
  // try
  /// /  s := s + 'SELECT ' + aField + ' '+#10;
  /// /  s := s + 'FROM Control  ';
  // s := format(select_ctrlGetFloat, [aField]);
  // if hData.rSet_bySQL(rSet,s, Connection,LogLevel,logPath) then
  // begin
  // result := LocalFloatValue(Rset.FieldByName(aField).AsString);
  // end;
  // finally
  // freeandnil(Rset);
  // end;
end;

function ctrlGetInteger(aField: string): integer;
// var
// Rset : TRoomerDataSet;
// s : string;
begin
  result := glb.ControlSet.fieldbyname(aField).asInteger;
  // RSet := CreateNewDataSet;
  // try
  /// /    s := s + 'SELECT ' + aField + ' '+#10;
  /// /    s := s + 'FROM Control  ';
  // s := format(select_ctrlGetInteger, [aField]);
  // if hData.rSet_bySQL(rSet,s, Connection,LogLevel,logPath) then
  // begin
  // result := Rset.FieldByName(aField).AsInteger;
  // end;
  // finally
  // freeandnil(Rset);
  // end;
end;


function DKAutoTransfer : boolean;
 var
   Rset : TRoomerDataSet;
   s : string;
begin
   result := true;
   RSet := CreateNewDataSet;
   try
     s := '';
     s := s + 'SELECT AutoInvoiceTransfer '+#10;
     s := s + 'FROM hotelconfigurations  ';
     if rSet_bySQL(rSet,s) then
     begin
       result := Rset.FieldByName('AutoInvoiceTransfer').AsBoolean;
     end;
   finally
     freeandnil(Rset);
   end;
end;


function ctrlGetBoolean(aField: string): boolean;
// var
// Rset : TRoomerDataSet;
// s : string;
begin
  result := glb.ControlSet[aField];
  // RSet := CreateNewDataSet;
  // try
  /// /    s := s + 'SELECT ' + aField + ' '+#10;
  /// /    s := s + 'FROM Control  ';
  // s := format(select_ctrlGetBoolean, [aField]);
  // if hData.rSet_bySQL(rSet,s, Connection,LogLevel,logPath) then
  // begin
  // result := Rset[aField];
  // end;
  // finally
  // freeandnil(Rset);
  // end;
end;

function Item_Exists(sItem: string): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := false;
  // s := s + ' SELECT Item FROM [Items] '+#10;
  // s := s + ' WHERE (Item = ' + quotedstr(sItem) + ') ';

  rSet := CreateNewDataSet;
  try
    s := format(select_Item_Exists, [quotedstr(sItem)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := true;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function rd_Exists(id: integer): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := false;
  s := s + ' SELECT id FROM roomsdate ' + #10;
  s := s + ' WHERE (id = ' + _db(id) + ') ';

  rSet := CreateNewDataSet;
  try
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := true;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function rd_ExistsByRRandDate(RoomReservation: integer; sDate: string): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := false;
  s := s + ' SELECT roomreservation,aDate FROM roomsdate ' + #10;
  s := s + ' WHERE (roomreservation = ' + _db(RoomReservation) + ') and (aDate=' + _db(sDate) + ') ';

  rSet := CreateNewDataSet;
  try
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := true;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function updateRdResFlag(id: integer; Status: string): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE roomsdate ' + #10;
  s := s + ' SET ' + #10;
  s := s + '     resFlag  = ' + _db(Status) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '       (id= ' + _db(id) + ') ' + #10;
  result := cmd_bySQL(s);
end;

function updateRdResFlagByRRandDate(RoomReservation: integer; sDate: string; Status: string; SetPaid : Boolean = False; isPaid : Boolean = False): boolean;
var
  s: string;
  sIsPaid : String;
begin
  s := '';
  s := s + ' UPDATE roomsdate ' + #10;
  s := s + ' SET ' + #10;
  s := s + '     resFlag  = ' + _db(Status) + ' ' + #10;
  if SetPaid then
  begin
    if isPaid then
      sIsPaid := '1'
    else
      sIsPaid := '0';
    s := s + '     , Paid  = ' + sIsPaid + #10;
  end;
  s := s + ' WHERE ' + #10;
  s := s + '       (roomreservation= ' + _db(RoomReservation) + ') and (Adate=' + _db(sDate) + ') ' + #10;
  result := cmd_bySQL(s);
end;

function ItemType_Exists(sItemType: string): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  // s := s + ' SELECT ItemType FROM [ItemTypes] '+#10;
  // s := s + ' WHERE (ItemType = ' + _db(sItemType) + ') '+#10;

  rSet := CreateNewDataSet;
  try
    s := format(select_ItemType_Exists, [_db(sItemType)]);
    result := hData.rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function Convert(sType, sValue: string; Direction: integer): string;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := '';
  rSet := CreateNewDataSet;
  try
    s := select_Convert(Direction);
    s := format(s, [_db(sType), _db(sValue)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      if Direction = cToHome then
        result := rSet.fieldbyname('cvFrom').asString;

      if Direction = cHomeTo then
        result := rSet.fieldbyname('cvTo').asString;

      result := trim(result);
    end;
    if result = '' then
      result := sValue;
  finally
    freeandnil(rSet);
  end;
end;

function Item_GetKind(sItem: string): TItemKind;
var
  s: string;
begin
  (* ikUnknown, ikNormal,ikRoomRent,ikRoomRentDiscount,ikBrekfastInc,ikPhoneUse,ikPayment, ikStayTax *)
  result := ikNormal;

  sItem := _trimlower(sItem);
  s := _trimlower(g.qRoomRentItem);
  // ctrlGetString('RoomRentItem', Connection,loglevel,logpath));
  if s = sItem then
  begin
    result := ikRoomRent;
    exit;
  end;

  s := _trimlower(g.qDiscountItem);
  // ctrlGetString('DiscountItem', Connection,loglevel,logpath));
  if s = sItem then
  begin
    result := ikRoomRentDiscount;
    exit;
  end;

  sItem := _trimlower(sItem);
  s := _trimlower(g.qStayTaxItem);
  // ctrlGetString('stayTaxItem', Connection,loglevel,logpath));
  if s = sItem then
  begin
    result := ikStayTax;
    exit;
  end;

  s := _trimlower(g.qBreakFastItem);
  // ctrlGetString('BreakFastItem', Connection,loglevel,logpath));
  if s = sItem then
  begin
    result := ikBreakfast;
    exit;
  end;

  s := _trimlower(g.qPhoneUseItem);
  // ctrlGetString('PhoneUseItem', Connection,loglevel,logpath));
  if s = sItem then
  begin
    result := ikPhoneUse;
    exit;
  end;

  s := _trimlower(g.qPaymentItem);
  // ctrlGetString('PaymentItem', Connection,loglevel,logpath));
  if s = sItem then
  begin
    result := ikPayment;
    exit;
  end;

end;

function Item_isRoomRent(Item: string): boolean;
var
  ItemKind: TItemKind;
begin
  result := false;
  ItemKind := Item_GetKind(Item);
  try
    result := ((ItemKind = ikRoomRent) or (ItemKind = ikRoomRentDiscount) or (ItemKind = ikStayTax));
  except
  end;
end;

function Item_isRoomRentOrDiscount(Item: string): boolean;
var
  ItemKind: TItemKind;
begin
  result := false;
  ItemKind := Item_GetKind(Item);
  try
    result := ((ItemKind = ikRoomRent) or (ItemKind = ikRoomRentDiscount));
  except
  end;
end;

function Item_isJustRoomRent(Item: string): boolean;
var
  ItemKind: TItemKind;
begin
  result := false;
  ItemKind := Item_GetKind(Item);

  try
    result := ((ItemKind = ikRoomRent));
  except
  end;
end;

function ItemPlus_Get_Data(aItem: string): recItemPlusHolder;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  initItemPlusHolder(result);
  // s := s + ' SELECT '+#10;
  // s := s + '    Items.Item '+#10;
  // s := s + '   , Items.Description '+#10;
  // s := s + '   , Items.Price '+#10;
  // s := s + '   , Items.Itemtype '+#10;
  // s := s + '   , Itemtypes.Description AS ItemTypeDescription '+#10;
  // s := s + '   , Itemtypes.VATCode '+#10;
  // s := s + '   , VATCodes.Description AS VATcodeDescription '+#10;
  // s := s + '   , VATCodes.VATPercentage '+#10;
  // s := s + '   , Items.AccountKey '+#10;
  // s := s + '   , Itemtypes.AccItemLink '+#10;
  // s := s + ' FROM '+#10;
  // s := s + '   Items '+#10;
  // s := s + '      INNER JOIN Itemtypes ON Items.Itemtype = Itemtypes.Itemtype '+#10;
  // s := s + '      INNER JOIN VATCodes ON Itemtypes.VATCode = VATCodes.VATCode '+#10;
  // s := s + '  WHERE '+#10;
  // s := s + '  Items.item = ' + _db(aItem) + ' '+#10;

  rSet := CreateNewDataSet;
  try
    s := format(select_ItemPlus_Get_Data, [_db(aItem)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result.AccountKey := rSet.fieldbyname('AccountKey').asString;
      result.AccItemLink := rSet.fieldbyname('AccItemLink').asString;
      result.Item := rSet.fieldbyname('Item').asString;
      result.Description := rSet.fieldbyname('Description').asString;
      result.Price := LocalFloatValue(rSet.fieldbyname('Price').asString);
      result.ItemType := rSet.fieldbyname('Itemtype').asString;
      result.ItemTypeDescription := rSet.fieldbyname('ItemTypeDescription').asString;
      result.VatCode := rSet.fieldbyname('VATCode').asString;
      result.VATCodeDescription := rSet.fieldbyname('VATCodeDescription').asString;
      result.VATPercentage := LocalFloatValue(rSet.fieldbyname('VATPercentage').asString);
      result.ItemKind := Item_GetKind(aItem)
    end;
  finally
    freeandnil(rSet);
  end;
end;

function GetFirstCurrency(iReservation: integer): string;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := ctrlGetString('NativeCurrency');
  rSet := CreateNewDataSet;
  try
    // s := s + 'SELECT Currency '+#10;
    // s := s + 'FROM RoomReservations '+#10;
    // s := s + 'WHERE Reservation = ' + inttostr(iReservation)+#10;
    // s := s + 'ORDER By RoomReservation '+#10;
    s := format(select_GetFirstCurrency, [iReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.fieldbyname('Currency').asString;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function NumberOfInvoiceLines(iReservation, iRoomReservation, iSplitNumber: integer; InvoiceIndex : Integer = -1): integer;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT count(ItemId) AS Cnt FROM Invoicelines '+#10;
    // s := s + ' WHERE Reservation = ' + inttostr(iReservation)+#10;
    // s := s + ' AND RoomReservation = ' + inttostr(iRoomReservation)+#10;
    // s := s + ' AND SplitNumber = ' + inttostr(iSplitNumber)+#10;

    if InvoiceIndex = -1 then
      s := format(select_NumberOfInvoiceLines, [iReservation, iRoomReservation, iSplitNumber])
    else
      s := format(select_NumberOfInvoiceLinesWithInvoiceIndex, [iReservation, iRoomReservation, iSplitNumber, InvoiceIndex]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.fieldbyname('Cnt').asInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function ExclutedTax(Invoicenumber : integer; Amount,Nights : double): boolean;
begin
  Result := false;
//  result := 0;
//  rSet := CreateNewDataSet;
//  try
//    s := format(select_NumberOfInvoiceLines, [iReservation, iRoomReservation, iSplitNumber]);
//    if hData.rSet_bySQL(rSet, s) then
//    begin
//      result := rSet.fieldbyname('Cnt').asInteger;
//    end;
//  finally
//    freeandnil(rSet);
//  end;
end;


function RR_GetNumberGroupInvoices(iReservation: integer): integer;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT count(RoomReservation) AS Cnt FROM RoomReservations '+#10;
    // s := s + ' WHERE (Reservation = ' + inttostr(iReservation) + ')'+#10;
    // s := s + ' AND (GroupAccount = 1 )'+#10;

    s := format(select_RR_GetNumberGroupInvoices, [iReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.fieldbyname('Cnt').asInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function RV_Exists(iReservation: integer): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_RV_Exists, [iReservation]);
    result := hData.rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function RV_GetResInfo(iReservation: integer): recResInfo;
var
  rSet: TRoomerDataSet;
  s: string;
  sDate: string;
begin
  initResInfoRec(result);
  result.Reservation := iReservation;

  // s := s + ' SELECT '+#10;
  // s := s + '   Reservation '+#10;
  // s := s + '   , ReservationDate '+#10;
  // s := s + '   , Staff '+#10;
  // s := s + ' FROM '+#10;
  // s := s + '   Reservations '+#10;
  // s := s + ' WHERE '+#10;
  // s := s + '   Reservation =' + _db(iReservation) + ' '+#10;

  rSet := CreateNewDataSet;
  try
    s := format(select_RV_GetResInfo, [iReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      sDate := rSet.fieldbyname('ReservationDate').asString;
      result.bookingDate := _DBDateToDate(sDate);
      result.bookingStaff := rSet.fieldbyname('staff').asString;

      // result.RoomCount := RV_RoomCount(iReservation, Connection,logLevel,logPath);
      // result.NoRoomCount := RV_NoRoomCount(iReservation, Connection,logLevel,logPath);
      // result.GuestCount := RV_GuestCount(iReservation, Connection,logLevel,logPath);
      // result.ClosedInvoiceCount      := RV_ClosedInvoiceCount(iReservation, Connection,logLevel,logPath);
      // result.ClosedInvoiceLineCount  := RV_ClosedInvoiceLineCount(iReservation, Connection,logLevel,logPath);
      // result.ClosedInvoiceAmount     := RV_ClosedInvoiceAmount(iReservation, Connection,logLevel,logPath);
      // result.openInvoiceRentCount    := RV_openInvoiceRentCount(iReservation, Connection,logLevel,logPath);
      // result.openInvoiceRentAmount   := RV_openInvoiceRentAmount(iReservation, Connection,logLevel,logPath);
      // result.closedInvoiceRentCount  := RV_closedInvoiceRentCount(iReservation, Connection,logLevel,logPath);
      // result.closedInvoiceRentAmount := RV_closedInvoiceRentAmount(iReservation, Connection,logLevel,logPath);
    end;

  finally
    freeandnil(rSet);
  end;
end;

function GetReservationRRList(Reservation: integer; var RRlist, lstRoomReservationsStatus: TstringList): integer;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  // **
  result := 0;
  RRlist.clear;
  if assigned(lstRoomReservationsStatus) then
    lstRoomReservationsStatus.Clear;

  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+#10;
    // s := s + '    RoomReservation '+#10;
    // s := s + '   ,Reservation '+#10;
    // s := s + ' FROM '+#10;
    // s := s + '   RoomReservations '+#10;
    // s := s + ' WHERE '+#10;
    // s := s + ' Reservation = ' + inttostr(Reservation)+#10;
    s := format(select_GetReservationRRList, [Reservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.recordCount;
      if result > 0 then
      begin
        rSet.First;
        while not rSet.Eof do
        begin
          RRlist.Add(rSet.fieldbyname('RoomReservation').asString);
          if assigned(lstRoomReservationsStatus) then
            lstRoomReservationsStatus.Add(rSet.fieldbyname('Status').asString);
          rSet.Next;
        end;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function RV_useStayTax(iReservation: integer): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := true;
  if d.roomerMainDataSet.OfflineMode then
    exit;
  // s := 'SELECT TOP(1) useStayTax FROM Reservations WHERE Reservation =' + _db(iReservation) + ' ';
  rSet := CreateNewDataSet;
  try
    s := format(select_RV_useStayTax, [iReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet['useStayTax'];
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure RV_SetUseStayTax(iReservation: integer);
var
  s: string;
begin
  s := format(update_RV_useStayTax, [iReservation]);
  if NOT hData.cmd_bySQL(s) then
    raise exception.Create('Unable to remove CityTax from reservation');
end;

function RR_Exists(iRoomReservation: integer): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  // s := 'SELECT TOP(1) RoomReservation FROM RoomReservations WHERE RoomReservation =' + _db(iRoomReservation) + ' ';
  rSet := CreateNewDataSet;
  try
    s := format(select_RR_Exists, [iRoomReservation]);
    result := hData.rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function RR_GetCustomer(iRoomReservation: integer): string;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := '';
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT ';
    // s := s + '     Reservations.Reservation ';
    // s := s + '   , Reservations.Customer ';
    // s := s + '   , RoomReservations.RoomReservation ';
    // s := s + ' FROM ';
    // s := s + '   Reservations ';
    // s := s + '      RIGHT OUTER JOIN ';
    // s := s + '   RoomReservations ON Reservations.Reservation = RoomReservations.Reservation ';
    // s := s + ' WHERE ';
    // s := s + '   (RoomReservation = ' + inttostr(iRoomReservation) + ' ) '+#10;
    s := format(select_RR_GetCustomer, [iRoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.fieldbyname('customer').asString;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function RR_GetReservation(iRoomReservation: integer): integer;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 0;

  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+#10;
    // s := s + '   Reservation '+#10;
    // s := s + ' FROM  RoomReservations '+#10;
    // s := s + ' WHERE '+#10;
    // s := s + '   (RoomReservation = ' + inttostr(iRoomReservation) + ' ) '+#10;
    s := format(select_RR_GetReservation, [iRoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.fieldbyname('Reservation').asInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function RR_GetRoomNumber(iRoomReservation: integer): string;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := '';

  rSet := CreateNewDataSet;
  try
    s := format(select_RR_GetRoomNumber, [iRoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.fieldbyname('room').asString;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function RR_GetDeparting(Room: string; ADate: Tdate): integer;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := -1;

  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+#10;
    // s := s + '  TOP (1) '+#10;
    // s := s + '    roomsdate.Room '+#10;
    // s := s + '  , roomsdate.RoomReservation '+#10;
    // s := s + '  , roomsdate.ADate '+#10;
    // s := s + '  , roomsdate.ResFlag '+#10;
    // s := s + '  , RoomReservations.Departure '+#10;
    // s := s + ' FROM '+#10;
    // s := s + '  roomsdate '+#10;
    // s := s + '     INNER JOIN '+#10;
    // s := s + '       RoomReservations ON dbo.roomsdate.RoomReservation = dbo.RoomReservations.RoomReservation '+#10;
    // s := s + ' WHERE ';
    // s := s + '    (dbo.roomsdate.Room = ' + _dbStr(Room) + ') '+#10;
    // s := s + ' AND (dbo.roomsdate.ADate = ' + _dateToDBdate(ADate - 1, true) + ') '+#10;
    // s := s + ' AND (dbo.roomsdate.ResFlag = ' + _db('G') + ') '+#10;
    // s := s + ' AND (dbo.RoomReservations.Departure = ' + _dateToDBdate(ADate, true) + ') '+#10;
    s := format(select_RR_GetDeparting, [_dbStr(Room), _dateToDBdate(ADate - 1, true), _dateToDBdate(ADate, true)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.fieldbyname('RoomReservation').asInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function RR_GetFrom_RoomAndDate(Room: string; ADate: Tdate): integer;
var
  rSet: TRoomerDataSet;
  s: string;
  sql: string;
begin
  result := -1;

  rSet := CreateNewDataSet;
  try
    sql := ' SELECT '#10 + '     Room '#10 + '   , RoomReservation '#10 + '   , ADate '#10 + ' FROM '#10 + '   roomsdate '#10 + ' WHERE '#10 +
      '   (Room = %s)  and (ADate = %s) ' +
    // ' + _dbStr(Room) + '  //' + _dateToDBdate(ADate, true) + '
      '   AND (ResFlag <> ' + _db(STATUS_DELETED) + ' ) ' + // **zxhj bætti við
      ' LIMIT 1 ';
    s := format(sql, [_dbStr(Room), _dateToDBdate(ADate, true)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.fieldbyname('RoomReservation').asInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function RR_GetFrom_RoomAndDateDeparting(Room: string; ADate: Tdate): integer;
var
  rSet: TRoomerDataSet;
  s: string;
  sql: string;
begin
  result := -1;

  ADate := ADate - 1;

  rSet := CreateNewDataSet;
  try

    sql := ' SELECT '#10 + '     Room '#10 + '   , RoomReservation '#10 + '   , Resflag '#10 + '   , ADate '#10 + ' FROM '#10 + '   roomsdate '#10 +
      ' WHERE '#10 + '   (Room = %s)  and (ADate = %s) ' + '   AND (ResFlag <> ' + _db(STATUS_DELETED) + ' ) ' + // **zxhj bætti við
      ' LIMIT 1 ';

    s := format(sql, [_dbStr(Room), _dateToDBdate(ADate, true)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      if rSet.fieldbyname('resflag').asString <> 'G' then
        exit;
      result := rSet.fieldbyname('RoomReservation').asInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function RR_GetFirstGuestNameFast(iRoomReservation: integer): string;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := '';
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+#10;
    // s := s + '   [Name] '+#10;
    // s := s + ' FROM '+#10;
    // s := s + '   PERSONS '+#10;
    // s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation)+#10;
    s := format(select_RR_GetFirstGuestNameFast, [iRoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.fieldbyname('Name').asString;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function DraftInv_exists(RoomReservation: integer): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin

  // s := '';
  // s := s + ' SELECT '+#10;
  // s := s + '   RoomReservation '+#10;
  // s := s + ' , SplitNumber '+#10;
  // s := s + ' , Invoicenumber '+#10;
  // s := s + ' , Finished '+#10;
  // s := s + '   FROM [invoiceHeads] '+#10;
  // s := s + ' WHERE '+#10;
  // s := s + '   RoomReservation = ' + inttostr(RoomReservation) + ' '+#10;
  // s := s + '   and SplitNumber = 0 '+#10; // roomInvoice
  // s := s + '   and InvoiceNumber = -1 '+#10;
  // s := s + '   and Finished = 0 '+#10;

  rSet := CreateNewDataSet;
  try
    s := format(select_DraftInv_exists, [RoomReservation]);
    result := hData.rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function DraftInvGroup_exists(Reservation: integer): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  // s := s + ' SELECT '+#10;
  // s := s + '   RoomReservation '+#10;
  // s := s + ' , Reservation '+#10;
  // s := s + ' , SplitNumber '+#10;
  // s := s + ' , Invoicenumber '+#10;
  // s := s + ' , Finished '+#10;
  // s := s + '   FROM [invoiceHeads] '+#10;
  // s := s + ' WHERE '+#10;
  // s := s + '   Reservation = ' + inttostr(Reservation) + ' '+#10;
  // s := s + '   and RoomReservation = 0 '+#10; // roomInvoice
  // s := s + '   and SplitNumber = 0 '+#10; // roomInvoice
  // s := s + '   and InvoiceNumber = -1 '+#10;
  // s := s + '   and Finished = 0 '+#10;

  rSet := CreateNewDataSet;
  try
    s := format(select_DraftInvGroup_exists, [Reservation]);
    result := hData.rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function GetRate(Currency: string): double;
begin
  result := 1;
  if glb.LocateCurrency(Currency) then
  begin
    result := LocalFloatValue(glb.CurrenciesSet.fieldbyname('AValue').asString);
  end;
end;

function RR_GetCurrency(iRoomReservation: integer): string;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := ctrlGetString('NativeCurrency');

  rSet := CreateNewDataSet;
  try
    // s := '';
    // s := s + 'SELECT Currency FROM RoomReservations'+#10;
    // s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation);
    // s := format(select_RR_GetCurrency, [iRoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.fieldbyname('currency').asString;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function DraftInv_Create(Reservation, RoomReservation: integer; user: string): boolean;
var
  rSet: TRoomerDataSet;

  invoiceHeadData: recInvoiceHeadHolder;

  InvoiceDate: Tdate;
  Customer: string;
  aName: string;
  custPID: string;
  Address1: string;
  Address2: string;
  Address3: string;
  Address4: string;
  Country: string;

  GuestName: string;
  Staff: string;
  Currency: string;

  s: string;
begin
  result := true;
  // Get related data from Reservations
  rSet := CreateNewDataSet;
  try
    Customer := '';
    aName := '';
    custPID := '';
    Address1 := '';
    Address2 := '';
    Address3 := '';
    Address4 := '';
    Country := '';

    // s := '';
    // s := s + ' SELECT '+#10;
    // s := s + '   Customer '+#10;
    // s := s + '  ,Name '+#10;
    // s := s + '  ,CustPid '+#10;
    // s := s + ' ,Address1 '+#10;
    // s := s + ' ,Address2 '+#10;
    // s := s + ' ,Address3 '+#10;
    // s := s + ' ,Address4 '+#10;
    // s := s + ' ,Country '+#10;
    // s := s + ' FROM [Reservations] '+#10;
    // s := s + ' WHERE Reservation = ' + inttostr(Reservation)+#10;
    s := format(select_DraftInv_Create, [Reservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      Customer := rSet.fieldbyname('Customer').asString;
      aName := rSet.fieldbyname('Name').asString;
      custPID := rSet.fieldbyname('CustPid').asString;
      Address1 := rSet.fieldbyname('Address1').asString;
      Address2 := rSet.fieldbyname('Address2').asString;
      Address3 := rSet.fieldbyname('Address3').asString;
      Address4 := rSet.fieldbyname('Address4').asString;
      Country := rSet.fieldbyname('Country').asString;
    end;
  finally
    freeandnil(rSet);
  end;

  // Get related data from RoomReservations
  rSet := CreateNewDataSet;
  try
    Currency := '';
    // s := '';
    // s := s + ' SELECT '+#10;
    // s := s + '   currency '+#10;
    // s := s + ' FROM [RoomReservations] '+#10;
    // s := s + ' WHERE RoomReservation = ' + inttostr(RoomReservation)+#10;
    s := format(select_DraftInv_Create2, [RoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      Currency := rSet.fieldbyname('currency').asString;
    end;
  finally
    freeandnil(rSet);
  end;

  Staff := user;
  InvoiceDate := date;
  GuestName := RR_GetFirstGuestNameFast(RoomReservation);

  initInvoiceHeadHolderRec(invoiceHeadData);
  invoiceHeadData.Reservation := Reservation;
  invoiceHeadData.RoomReservation := RoomReservation;
  invoiceHeadData.SplitNumber := cHotelInvoice; // 0
  invoiceHeadData.InvoiceNumber := -1;
  invoiceHeadData.InvoiceDate := _dateToDBdate(InvoiceDate, false); // ath
  invoiceHeadData.Customer := Customer;
  invoiceHeadData.name := aName + ', ' + GuestName;
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
  invoiceHeadData.CreditInvoice := 0;
  invoiceHeadData.OriginalInvoice := 0;
  invoiceHeadData.InvoiceType := 1;
  invoiceHeadData.ihTmp := 'N';

  invoiceHeadData.custPID := custPID;
  invoiceHeadData.RoomGuest := GuestName;
  invoiceHeadData.ihDate := InvoiceDate;
  invoiceHeadData.ihInvoiceDate := InvoiceDate;
  invoiceHeadData.ihConfirmDate := 2;
  invoiceHeadData.ihPayDate := InvoiceDate;
  invoiceHeadData.ihStaff := Staff;
  invoiceHeadData.ihCurrency := Currency;
  invoiceHeadData.ihCurrencyRate := 1.00;
  invoiceHeadData.ReportDate := '';
  invoiceHeadData.ReportTime := '';
  invoiceHeadData.Staff := Staff;

  if not SP_INS_InvoiceHead(invoiceHeadData) then
  begin
    // **
  end;

end;

function DraftInv_RRUpdateAmounts(RoomReservation: integer): boolean;
var
  rSet: TRoomerDataSet;
  Total: double;
  TotalWOVAT: double;
  TotalVAT: double;
  s: string;
begin
  result := true;
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+#10;
    // s := s + '     Reservation '+#10;
    // s := s + '   , RoomReservation '+#10;
    // s := s + '   , SplitNumber '+#10;
    // s := s + '   , Total '+#10;
    // s := s + '   , TotalWOVat '+#10;
    // s := s + '   , Vat '+#10;
    // s := s + '   , InvoiceNumber '+#10;
    // s := s + ' FROM '+#10;
    // s := s + '   InvoiceLines '+#10;
    // s := s + ' WHERE '+#10;
    // s := s + '   (RoomReservation = ' + _db(RoomReservation) + ' ) AND (InvoiceNumber = - 1) '+#10;
    s := format(select_DraftInv_RRUpdateAmounts, [RoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      Total := 0.00;
      TotalWOVAT := 0.00;
      TotalVAT := 0.00;

      while not rSet.Eof do
      begin
        Total := Total + LocalFloatValue(rSet.fieldbyname('Total').asString);
        TotalWOVAT := TotalWOVAT + LocalFloatValue(rSet.fieldbyname('TotalWOVAT').asString);
        TotalVAT := TotalVAT + LocalFloatValue(rSet.fieldbyname('VAT').asString);
        rSet.Next;
      end;

      s := '';
      s := s + ' UPDATE invoiceheads ' + #10;
      s := s + ' SET ' + #10;
      s := s + '     Total = ' + _db(Total) + ' ' + #10;
      s := s + '   , TotalWOVAT =' + _db(TotalWOVAT) + ' ' + #10;
      s := s + '   , TotalVAT =' + _db(TotalVAT) + ' ' + #10;
      s := s + ' WHERE ' + #10;
      s := s + '   (RoomReservation = ' + _db(RoomReservation) + ') AND (InvoiceNumber = - 1) ' + #10;
      if not cmd_bySQL(s) then
      begin
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Customer_Exists(Customer: string): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  rSet := CreateNewDataSet;
  try
    // s := s + 'SELECT '+#10;
    // s := s + 'Customer '+#10;
    // s := s + 'FROM '+#10;
    // s := s + 'Customers '+#10;
    // s := s + 'WHERE '+#10;
    // s := s + 'Customer = ' + _db(Customer) + '  '+#10;
    s := format(select_Customer_Exists, [_db(Customer)]);
    result := hData.rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function PriceCodes_GETRack(): integer;
begin
  // TOOPT
  Result := -1;
  glb.TblpricecodesSet.First;
  if glb.TblpricecodesSet.Locate('PcRack', 1, []) then
  begin
    result := glb.TblpricecodesSet.fieldbyname('ID').asInteger;
  end;

  // result := - 1;
  // RSet := CreateNewDataSet;
  // try
  // s := format(select_PriceCodes_GETRack, []);
  // if hData.rSet_bySQL(rSet,s, Connection,LogLevel,logPath) then
  // begin
  // result := Rset.FieldByName('ID').AsInteger;
  // end;
  // finally
  // freeandnil(Rset);
  // end;
end;

function CustomerTypes_GetDefault(): string;
begin
  // TOOPT

  glb.CustomertypesSet.First;
  result := glb.CustomertypesSet.fieldbyname('CustomerType').asString;

  // RSet := CreateNewDataSet;
  // try
  // s := format(select_CustomerTypes_GetDefault, []);
  // if hData.rSet_bySQL(rSet,s, Connection,LogLevel,logPath) then
  // begin
  // result := Rset.FieldByName('CustomerType').AsString;
  // end;
  // finally
  // freeandnil(Rset);
  // end;
end;

function Country_GetDefault(): string;
// Rset : TRoomerDataSet;
// s : string;

var
  m: TKbmMemtable;
begin
  m := TKbmMemtable.Create(nil);
  try
    LoadKbmMemtableFromDataSetQuiet(m,glb.Countries, [mtcpoStructure]);
    m.First;
    m.sortfields := 'OrderIndex';
    m.sort([mtcoDescending]);
    m.First;
    result := m.fieldbyname('country').asString;
  finally
    freeandnil(m);
  end;
  // result := '';
  // RSet := CreateNewDataSet;
  // try
  // s := format(select_Country_GetDefault, []);
  // if hData.rSet_bySQL(rSet,s, Connection,LogLevel,logPath) then
  // begin
  // result := Rset.FieldByName('Country').AsString;
  // end;
  // finally
  // freeandnil(Rset);
  // end;

end;

function Item_GetDescription(Item: string): string;
// var
// Rset : TRoomerDataSet;
// s : string;
begin
  result := '';
  glb.LocateSpecificRecordAndGetValue('items', 'Item', Item, 'Description', result);
end;

function Item_GetPrice(Item: string): double;
begin
  result := 0.00;
  glb.LocateSpecificRecordAndGetValue('items', 'Item', Item, 'Price', result);
end;

function RV_GuestCount(iReservation: integer): integer;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT count(Person) AS Cnt FROM Persons'+#10;
    // s := s + ' WHERE Reservation = ' + inttostr(iReservation);
    s := format(select_RV_GuestCount, [iReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.fieldbyname('Cnt').asInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function RR_GuestCount(iRoomReservation: integer): integer;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    // s := '';
    // s := s + ' SELECT count(Person) AS Cnt FROM Persons'+#10;
    // s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation);
    s := format(select_RR_GuestCount, [iRoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.fieldbyname('Cnt').asInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function RV_RoomCount(iReservation: integer): integer;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT count(Reservation) AS Cnt FROM RoomReservations'+#10;
    // s := s + ' WHERE Reservation = ' + inttostr(iReservation);
    s := format(select_RV_RoomCount, [iReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.fieldbyname('Cnt').asInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function RV_NoRoomCount(iReservation: integer): integer;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+#10;
    // s := s + '   COUNT(Room) AS CNT '+#10;
    // s := s + ' FROM '+#10;
    // s := s + '   RoomReservations '+#10;
    // s := s + ' WHERE (Reservation = ' + inttostr(iReservation) + ') '+#10;
    // s := s + ' AND (CHARINDEX(' + _db('<') + ', Room) = 1) '+#10;
    s := format(select_RV_NoRoomCount, [iReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.fieldbyname('Cnt').asInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function RV_ClosedInvoiceCount(iReservation: integer): integer;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT count(InvoiceNumber) AS Cnt FROM InvoiceHeads '+#10;
    // s := s + ' WHERE '+#10;
    // s := s + '  (Reservation = ' + _db(iReservation) + ') '+#10;
    // s := s + ' AND (InvoiceNumber > 0) '+#10;
    s := format(select_RV_ClosedInvoiceCount, [iReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.fieldbyname('Cnt').asInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function RV_ClosedInvoiceLineCount(iReservation: integer): integer;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    // s := '';
    // s := s + ' SELECT count(ItemId) AS Cnt FROM Invoicelines '+#10;
    // s := s + ' WHERE '+#10;
    // s := s + '  (Reservation = ' + _db(iReservation) + ') '+#10;
    // s := s + ' AND (InvoiceNumber > 0) '+#10;
    s := format(select_RV_ClosedInvoiceLineCount, [iReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.fieldbyname('Cnt').asInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function RV_ClosedInvoiceAmount(iReservation: integer): double;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    // s := '';
    // s := s + ' SELECT '+#10;
    // s := s + '   SUM(Total) AS Amount '+#10;
    // s := s + ' FROM '+#10;
    // s := s + '   InvoiceLines '+#10;
    // s := s + ' WHERE '+#10;
    // s := s + '   (Reservation = ' + _db(iReservation) + ') AND (InvoiceNumber > 0) '+#10;

    s := format(select_RV_ClosedInvoiceAmount, [iReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := LocalFloatValue(rSet.fieldbyname('Amount').asString);
    end;
  finally
    freeandnil(rSet);
  end;
end;

function RV_openInvoiceRentCount(iReservation: integer): integer;
var
  rSet: TRoomerDataSet;
  s: string;

begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    s := format(select_RV_openInvoiceRentCount, []);
    if hData.rSet_bySQL(rSet, s) then
    begin
      // ATH FINISH THIS
    end;
  finally
    freeandnil(rSet);
  end;
end;

function RV_openInvoiceRentAmount(iReservation: integer): double;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    // s := '';
    // s := s + ' SELECT * from control'+#10;
    s := format(select_RV_openInvoiceRentCount, []);
    if hData.rSet_bySQL(rSet, s) then
    begin
      // ATH FINISH THIS
    end;
  finally
    freeandnil(rSet);
  end;
end;

function RV_closedInvoiceRentCount(iReservation: integer): integer;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT * from control'+#10;
    s := format(select_RV_closedInvoiceRentCount, []);
    if hData.rSet_bySQL(rSet, s) then
    begin
      // ATH FINISH THIS
    end;
  finally
    freeandnil(rSet);
  end;
end;

function RV_closedInvoiceRentAmount(iReservation: integer): double;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT * from control'+#10;
    s := format(select_RV_closedInvoiceRentAmount, []);
    if hData.rSet_bySQL(rSet, s) then
    begin
      // ATH
    end;
  finally
    freeandnil(rSet);
  end;
end;

function RV_closedInvoiceItemCount(iReservation: integer): integer;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT * from control'+#10;
    s := format(select_RV_closedInvoiceItemCount, []);
    if hData.rSet_bySQL(rSet, s) then
    begin
      // ATH
    end;
  finally
    freeandnil(rSet);
  end;
end;

function RV_closedInvoiceItemAmount(iReservation: integer): double;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT * from control'+#10;
    s := format(select_RV_closedInvoiceItemAmount, []);
    if hData.rSet_bySQL(rSet, s) then
    begin
      // ATH
    end;
  finally
    freeandnil(rSet);
  end;
end;

function RV_openInvoiceItemCount(iReservation: integer): integer;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    // s := '';
    // s := s + ' SELECT * from control'+#10;
    s := format(select_RV_openInvoiceItemCount, []);
    if hData.rSet_bySQL(rSet, s) then
    begin

    end;
  finally
    freeandnil(rSet);
  end;
end;

function RV_openInvoiceItemAmount(iReservation: integer): double;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT * from control'+#10;
    s := format(select_RV_openInvoiceItemAmount, []);
    if hData.rSet_bySQL(rSet, s) then
    begin
      // ATH
    end;
  finally
    freeandnil(rSet);
  end;
end;

function GetDayCount_dbDate(dbDateFrom, dbDateTo: string): integer;
var
  DateFrom: Tdate;
  DateTo: Tdate;
begin
  try
    DateFrom := _DBDateToDate(dbDateFrom);
    DateTo := _DBDateToDate(dbDateTo);
    result := trunc(DateTo) - trunc(DateFrom);
  except
    result := 0;
  end;
end;

function RR_unpaidRoomRent(iRoomReservation: integer; useISK: boolean = true): recRoomsDateRentInfo;
var
  rSet: TRoomerDataSet;
  s: string;

  RoomReservation: integer;
  Reservation: integer;
  ResFlag: string;
  isNoRoom: boolean;
  PriceCode: String;
  Currency: string;
  Discount: double;
  isPercentage: boolean;
  showDiscount: boolean;
  Rate: double;
  isGroupAccount: boolean;
  TotalRoomRent: double;
  TotalDiscount: double;
  RentDays: integer;

begin
  initRentInfoRec(result);

  rSet := CreateNewDataSet;
  try
    s := '';
    s := s + 'SELECT '#10;
    s := s + '  `roomsdate`.`RoomReservation`, '#10;
    s := s + '  `roomsdate`.`Reservation`, '#10;
    s := s + '  `roomsdate`.`ResFlag`, '#10;
    s := s + '  `roomsdate`.`isNoRoom`, '#10;
    s := s + '  `roomsdate`.`PriceCode`, '#10;
    s := s + '  `roomsdate`.`RoomRate`, '#10;
    s := s + '  `roomsdate`.`Currency`, '#10;
    s := s + '  `roomsdate`.`Discount`, '#10;
    s := s + '  `roomsdate`.`isPercentage`, '#10;
    s := s + '  `roomsdate`.`showDiscount`, '#10;
    s := s + '  `roomsdate`.`Paid`, '#10;
    s := s + '  `currencies`.`AValue` AS `Rate`, '#10;
    s := s + '  SUM(RoomRate) AS TotalRoomRate, '#10;
    s := s + '  SUM(IF(isPercentage, RoomRate*Discount/100, Discount)) AS DiscountUnPaidRoomRent, '#10;
    s := s + '  IF(isPercentage, RoomRate*Discount/100, Discount) AS unPaidRoomRent, '#10;
    s := s + '  ((SELECT SUM(RoomRate) FROM roomsdate WHERE roomsdate.roomreservation=roomreservations.roomreservation AND roomsdate.paid=0) ' +
      ' - (SELECT SUM(IF(isPercentage, RoomRate*Discount/100, Discount)) FROM roomsdate WHERE roomsdate.roomreservation=roomreservations.roomreservation AND roomsdate.paid=0)) AS TotalUnpaidRoomRent '#10;

    s := s + 'FROM '#10;
    s := s + '  `roomsdate` '#10;
    s := s + '  INNER JOIN `currencies` ON (`roomsdate`.`Currency` = `currencies`.`Currency`) '#10;
    s := s + 'WHERE '#10;
    s := s + '  (`roomsdate`.`RoomReservation` = %d) AND '#10;
    s := s + '  (`roomsdate`.`Paid` = 0) '#10;
    s := format(s, [iRoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      rSet.First;
      RoomReservation := rSet.fieldbyname('RoomReservation').asInteger;
      Reservation := rSet.fieldbyname('Reservation').asInteger;
      ResFlag := rSet.fieldbyname('ResFlag').asString;
      isNoRoom := rSet.fieldbyname('isNoRoom').Asboolean;
      PriceCode := rSet.fieldbyname('PriceCode').asString;
      Currency := rSet.fieldbyname('Currency').asString;
      isPercentage := rSet.fieldbyname('isPercentage').Asboolean;
      showDiscount := rSet.fieldbyname('showDiscount').Asboolean;

      isGroupAccount := rSet.fieldbyname('isGroupAccount').Asboolean;
      Rate := rSet.GetFloatValue(rSet.fieldbyname('Rate'));

      TotalRoomRent := rSet.GetFloatValue(rSet.fieldbyname('TotalRoomRate'));
      // 0;
      TotalDiscount := rSet.GetFloatValue(rSet.fieldbyname('TotalDiscount'));
      // 0;
      RentDays := rSet.recordCount;

      Discount := rSet.GetFloatValue(rSet.fieldbyname('Discount'));
      // while not rSet.eof do
      // begin
      // roomRate := rSet.GetFloatValue(rSet.FieldByName('RoomRate'));
      // Discount := rSet.GetFloatValue(rSet.FieldByName('Discount'));
      // TotalRoomRent   := TotalRoomRent + RoomRate;
      //
      // DiscountAmount := 0;
      // if Discount <> 0 then
      // begin
      // if isPercentage then
      // begin
      // DiscountAmount := roomRate*Discount/100;
      // end else
      // begin
      // DiscountAmount := Discount;
      // end;
      // end;
      // TotalDiscount   := TotalDiscount + DiscountAmount;
      // rSet.Next;
      // end;

      result.RoomReservation := RoomReservation;
      result.Reservation := Reservation;
      result.ResFlag := ResFlag;
      result.isNoRoom := isNoRoom;
      result.PriceCode := PriceCode;
      result.Currency := Currency;
      result.Discount := Discount;
      result.isPercentage := isPercentage;
      result.showDiscount := showDiscount;
      result.Rate := Rate;
      result.isGroupAccount := isGroupAccount;
      result.TotalRoomRent := TotalRoomRent;
      result.TotalDiscount := TotalDiscount;
      result.RentDays := RentDays;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function RR_GetAvrageRent(iRoomReservation: integer): recRoomReservationRentHolder;
var
  rSet: TRoomerDataSet;
  s: string;
  RoomReservation: integer;
  Reservation: integer;
  PriceType: string;
  avrageRate: double;
  Currency: string;
  Discount: double;
  Percentage: boolean;
begin
  initRoomReservationRentHolder(result);

  rSet := CreateNewDataSet;
  try
    s := '';
    s := s + 'SELECT '#10;
    s := s + '  `RoomReservation`, '#10;
    s := s + '  `Reservation`, '#10;
    s := s + '  `PriceType`, '#10;
    s := s + '  `AvrageRate`, '#10;
    s := s + '  `Currency`, '#10;
    s := s + '  `Discount`, '#10;
    s := s + '  `Percentage` '#10;
    s := s + 'FROM '#10;
    s := s + '  `roomreservations` '#10;
    s := s + 'WHERE '#10;
    s := s + ' `RoomReservation` = %d ';

    s := format(s, [iRoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      rSet.First;
      RoomReservation := rSet.fieldbyname('RoomReservation').asInteger;
      Reservation := rSet.fieldbyname('Reservation').asInteger;
      PriceType := rSet.fieldbyname('PriceType').asString;
      avrageRate := rSet.GetFloatValue(rSet.fieldbyname('AvrageRate'));
      Currency := rSet.fieldbyname('Currency').asString;
      Discount := rSet.GetFloatValue(rSet.fieldbyname('Discount'));
      Percentage := rSet.fieldbyname('Percentage').Asboolean;

      result.RoomReservation := RoomReservation;
      result.Reservation := Reservation;
      result.PriceType := PriceType;
      result.avrageRate := avrageRate;
      result.Currency := Currency;
      result.Discount := Discount;
      result.Percentage := Percentage;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function RR_GetDayCount(iRoomReservation: integer): integer;
var
  rSet: TRoomerDataSet;
  s: string;
  Arrival, Departure: Tdate;
begin
  result := 0;

  rSet := CreateNewDataSet;
  try
    s := '';
    s := s + 'SELECT '#10;
    s := s + '  rrArrival '#10;
    s := s + '  ,rrDeparture '#10;
    s := s + 'FROM '#10;
    s := s + '  `roomreservations` '#10;
    s := s + 'WHERE '#10;
    s := s + ' `RoomReservation` = %d ';

    s := format(s, [iRoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      rSet.First;
      Arrival := rSet.fieldbyname('rrArrival').AsDateTime;
      Departure := rSet.fieldbyname('rrDeparture').AsDateTime;
      result := trunc(Departure) - trunc(Arrival);
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure ins_delRoomReservationInfo_NOT_USED_ANYMORE(RoomReservation: integer; CancelStaff, CancelReason, CancelInformation: string; CancelType: integer);
var
  s: string;
  roomReservationRec: recRoomReservationHolder;
  reservationRec: recReservationHolder;
  personRec: recPersonHolder;

  rSet: TRoomerDataSet;
begin
  roomReservationRec := SP_GET_RoomReservation(RoomReservation);

  roomReservationRec.CancelDate := now;
  roomReservationRec.CancelStaff := CancelStaff;
  roomReservationRec.CancelReason := CancelReason;
  roomReservationRec.CancelInformation := CancelInformation;
  roomReservationRec.CancelType := CancelType;

  SP_INS_DelRoomReservation(roomReservationRec);

  s := '';
  s := s + ' DELETE ' + #10;
  s := s + '   FROM ' + #10;
  s := s + '     tbldelreservations ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   Reservation = ' + inttostr(roomReservationRec.Reservation);
  if not cmd_bySQL(s) then
  begin
  end;

  reservationRec := SP_GET_Reservation(roomReservationRec.Reservation);
  SP_INS_DelReservation(reservationRec);

  rSet := CreateNewDataSet;
  try
    // lstParams.Clear;
    // lstParams.Add('@roomreservation=' + inttoStr(roomReservation));
    // S_execute(guestSet, 'GET_Person_By_roomreservation', lstParams);
    s := format(select_Person_By_roomreservation, [RoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      while not rSet.Eof do
      begin
        initPersonHolder(personRec);
        personRec.Person := rSet.fieldbyname('person').asInteger;
        personRec.RoomReservation := rSet.fieldbyname('RoomReservation').asInteger;
        personRec.Reservation := rSet.fieldbyname('reservation').asInteger;
        personRec.name := rSet.fieldbyname('name').asString;
        personRec.Surname := rSet.fieldbyname('surName').asString;
        personRec.Address1 := rSet.fieldbyname('Address1').asString;
        personRec.Address2 := rSet.fieldbyname('Address2').asString;
        personRec.Address3 := rSet.fieldbyname('Address3').asString;
        personRec.Address4 := rSet.fieldbyname('Address4').asString;
        personRec.Country := rSet.fieldbyname('Country').asString;
        personRec.GuestType := rSet.fieldbyname('GuestType').asString;
        personRec.Information := rSet.fieldbyname('Information').asString;
        personRec.PID := rSet.fieldbyname('PID').asString;
        personRec.MainName := rSet['MainName'];
        personRec.Customer := rSet.fieldbyname('Customer').asString;
        personRec.peTmp := rSet.fieldbyname('peTmp').asString;
        personRec.hgrID := rSet.fieldbyname('hgrID').asInteger;
        personRec.HallReservation := rSet.fieldbyname('HallReservation').asInteger;
        INS_DelPerson(personRec);
        rSet.Next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Room_GetRec(Room: string): recRoomInfo;
var
  s: string;
  rSet: TRoomerDataSet;

begin
  initRoomInfoRec(result);
  rSet := CreateNewDataSet;
  try
    // s := '';
    // s := s+ ' SELECT '+#10;
    // s := s+ '    Rooms.Room '+#10;
    // s := s+ '  , Rooms.Description '+#10;
    // s := s+ '  , Rooms.RoomType '+#10;
    // s := s+ '  , Rooms.Bath '+#10;
    // s := s+ '  , Rooms.Shower '+#10;
    // s := s+ '  , Rooms.Safe '+#10;
    // s := s+ '  , Rooms.TV '+#10;
    // s := s+ '  , Rooms.Video '+#10;
    // s := s+ '  , Rooms.Radio '+#10;
    // s := s+ '  , Rooms.CDPlayer '+#10;
    // s := s+ '  , Rooms.Telephone '+#10;
    // s := s+ '  , Rooms.Press '+#10;
    // s := s+ '  , Rooms.Coffee '+#10;
    // s := s+ '  , Rooms.Kitchen '+#10;
    // s := s+ '  , Rooms.Minibar '+#10;
    // s := s+ '  , Rooms.Fridge '+#10;
    // s := s+ '  , Rooms.Hairdryer '+#10;
    // s := s+ '  , Rooms.InternetPlug '+#10;
    // s := s+ '  , Rooms.Fax '+#10;
    // s := s+ '  , Rooms.SqrMeters '+#10;
    // s := s+ '  , Rooms.BedSize '+#10;
    // s := s+ '  , Rooms.Equipments '+#10;
    // s := s+ '  , Rooms.Bookable '+#10;
    // s := s+ '  , Rooms.[Statistics] '+#10;
    // s := s+ '  , Rooms.Status '+#10;
    // s := s+ '  , Rooms.OrderIndex '+#10;
    // s := s+ '  , Rooms.hidden '+#10;
    // s := s+ '  , Rooms.Location '+#10;
    // s := s+ '  , Rooms.Floor '+#10;
    // s := s+ '  , Rooms.ID '+#10;
    // s := s+ '  , Rooms.Dorm '+#10;
    // s := s+ '  , RoomTypes.Description AS RoomTypeDescription '+#10;
    // s := s+ '  , RoomTypes.RoomTypeGroup '+#10;
    // s := s+ '  , RoomTypes.NumberGuests AS RoomTypeNumberGuests '+#10;
    // s := s+ '  , roomTypeGroups.Description AS RoomTypeGroupDescription '+#10;
    // s := s+ '  , Locations.Description AS LocationDescription '+#10;
    // s := s+ '  , RoomTypes.NumberGuests '+#10;
    // s := s+ ' FROM '+#10;
    // s := s+ '  Locations RIGHT OUTER JOIN '+#10;
    // s := s+ '    Rooms ON Locations.Location = Rooms.Location LEFT OUTER JOIN '+#10;
    // s := s+ '    roomTypeGroups RIGHT OUTER JOIN '+#10;
    // s := s+ '    RoomTypes ON roomTypeGroups.Code = RoomTypes.RoomType ON Rooms.RoomType = RoomTypes.RoomType '+#10;
    // s := s+ ' WHERE '+#10;
    // s := s+ '  Rooms.Room ='+_db(room)+' '+#10;
    s := format(select_Room_GetRec, [_db(Room)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      with result do
      begin
        Room := rSet.fieldbyname('Room').asString;
        Description := rSet.fieldbyname('Description').asString;
        RoomType := rSet.fieldbyname('RoomType').asString;
        Bath := rSet['Bath'];
        Shower := rSet['Shower'];
        Safe := rSet['Safe'];
        TV := rSet['TV'];
        Video := rSet['Video'];
        Radio := rSet['Radio'];
        CDPlayer := rSet['CDPlayer'];
        Telephone := rSet['Telephone'];
        Press := rSet['Press'];
        Coffee := rSet['Coffee'];
        Kitchen := rSet['Kitchen'];
        Minibar := rSet['Minibar'];
        Fridge := rSet['Fridge'];
        Hairdryer := rSet['Hairdryer'];
        InternetPlug := rSet['InternetPlug'];
        Fax := rSet['Fax'];
        SqrMeters := LocalFloatValue(rSet.fieldbyname('SqrMeters').asString);
        BedSize := rSet.fieldbyname('BedSize').asString;
        Equipments := rSet.fieldbyname('Equipments').asString;
        Bookable := rSet['Bookable'];
        Statistics := rSet['Statistics'];
        Status := rSet.fieldbyname('Status').asString;
        OrderIndex := rSet.fieldbyname('OrderIndex').asInteger;
        hidden := rSet['hidden'];
        Location := rSet.fieldbyname('Location').asString;
        Floor := rSet.fieldbyname('Floor').asInteger;
        id := rSet.fieldbyname('ID').asInteger;
        Dorm := rSet.fieldbyname('Dorm').asString;
        RoomTypeDescription := rSet.fieldbyname('RoomTypeDescription').asString;
        RoomTypeNumberGuests := rSet.fieldbyname('RoomTypeNumberGuests').asInteger;
        RoomTypeGroup := rSet.fieldbyname('RoomTypeGroup').asString;
        RoomTypeGroupDescription := rSet.fieldbyname('RoomTypeGroupDescription').asString;
        LocationDescription := rSet.fieldbyname('LocationDescription').asString;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Customer_GetHolder(Customer: string): recCustomerHolderEX;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  initCustomerHolderRec(result);

  rSet := CreateNewDataSet;
  try
    s := format(select_Customer_GetHolder, [_db(Customer)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      with result do
      begin
        Customer := rSet.fieldbyname('Customer').asString;
        CustomerName := rSet.fieldbyname('CustomerName').asString;
        DisplayName := rSet.fieldbyname('DisplayName').asString;
        PID := rSet.fieldbyname('PID').asString;
        Address1 := rSet.fieldbyname('Address1').asString;
        Address2 := rSet.fieldbyname('Address2').asString;
        Address3 := rSet.fieldbyname('Address3').asString;
        Address4 := rSet.fieldbyname('Address4').asString;
        Tel1 := rSet.fieldbyname('Tel1').asString;
        Tel2 := rSet.fieldbyname('Tel2').asString;
        Fax := rSet.fieldbyname('Fax').asString;
        CountryName := rSet.fieldbyname('CountryName').asString;
        Country := rSet.fieldbyname('Country').asString;
        MarketSegmentName := rSet.fieldbyname('MarketSegmentName').asString;
        MarketSegmentCode := rSet.fieldbyname('MarketSegmentCode').asString;
        DiscountPerc := LocalFloatValue(rSet.fieldbyname('DiscountPerc').asString);
        EmailAddress := rSet.fieldbyname('EmailAddress').asString;
        HomePage := rSet.fieldbyname('Homepage').asString;
        ContactPerson := rSet.fieldbyname('ContactPerson').asString;
        isTravelAgency := rSet['isTravelAgency'];
        Currency := rSet.fieldbyname('Currency').asString;
        priceCodeID := rSet.fieldbyname('pcID').asInteger;
        pcCode := rSet.fieldbyname('pcCode').asString;
        StayTaxIncluted := rSet.fieldbyname('StayTaxIncluted').Asboolean;
        notes := rSet.fieldbyname('notes').asString;
        RatePlanId := rSet.fieldbyname('RatePlanId').asInteger;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function GetArrivalText(RoomReservation: integer): string;
var
  s: string;
  rSet: TRoomerDataSet;

  Arrival: Tdate;
  guestStatus: string;

  ADate: Tdate;
  CheckIn: integer;

  ArrivalText: string;
  StatusText: string;

begin
  result := '';

  Arrival := now;
  rSet := CreateNewDataSet;
  try
    ADate := date;

    // s := '';
    // s := s+ ' SELECT  '+#10;
    // s := s+ '   rrArrival '+#10;
    // s := s+ ' , rrDeparture '+#10;
    // s := s+ ' , Reservation '+#10;
    // s := s+ ' , Status '+#10;
    // s := s+ ' FROM '+#10;
    // s := s+ '   RoomReservations '+#10;
    // s := s+ ' WHERE '+#10;
    // s := s+ '   RoomReservation = '+inttostr(RoomReservation)+' '+#10;
    s := format(select_GetAttivalText, [RoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      Arrival := rSet.fieldbyname('rrArrival').AsDateTime;
      guestStatus := rSet.fieldbyname('Status').asString;
    end;

    CheckIn := (trunc(Arrival) - trunc(ADate));

    if CheckIn = 0 then
    begin
      ArrivalText := 'Arrival today.' + #10;
    end
    else if CheckIn = 1 then
    begin
      ArrivalText := 'Arrival tomorrow.' + #10;
    end
    else if CheckIn > 0 then
    begin
      ArrivalText := 'Arrival after ' + inttostr(CheckIn) + ' days.' + #10;
    end
    else if CheckIn = -1 then
    begin
      ArrivalText := 'Arrival yesterday. ' + #10;
    end
    else
    begin
      ArrivalText := 'Arrival was ' + inttostr(abs(CheckIn)) + ' daysago.' + #10;
    end;

    StatusText := TReservationState.FromResStatus(guestStatus).AsReadableString;
    result := StatusText + ' - ' + ArrivalText;
  finally
    freeandnil(rSet);
  end;
end;

function GetTelRoomInfo(device: string; var Room: string; var Description: string; var doCharge: boolean): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := false;
  rSet := CreateNewDataSet;
  try
    Room := '';
    Description := '';
    doCharge := false;

    // s := '';
    // s := s + 'SELECT '+#10;
    // s := s + '   Device '+#10;
    // s := s + '  ,Room '+#10;
    // s := s + '  ,Description '+#10;
    // s := s + '  ,doCharge '+#10;
    // s := s + 'FROM telDevices '+#10;
    // s := s + 'WHERE device = ' + quotedStr(device);

    s := format(select_GetTelRoomInfo, [quotedstr(device)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := true;
      Room := rSet.fieldbyname('room').asString;
      Description := rSet.fieldbyname('Description').asString;
      doCharge := rSet['doCharge'];
    end;
  finally
    freeandnil(rSet);
  end;

end;

function FillLstTelPriceMasks(var lstMasks: TstringList): integer;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+chr(10);
    // s := s + '   TOP (100) PERCENT '+chr(10);
    // s := s + '     TelPriceRules.Code '+chr(10);
    // s := s + '   , TelPriceRules.Description AS RuleDescription '+chr(10);
    // s := s + '   , TelPriceRules.Mask '+chr(10);
    // s := s + '   , TelPriceRules.tpgCode '+chr(10);
    // s := s + '   , TelPriceRules.displayOrder '+chr(10);
    // s := s + '   , TelPriceRules.doUse '+chr(10);
    // s := s + '   , TelPriceGroups.Price '+chr(10);
    // s := s + '   , TelPriceGroups.Description AS PriceDescription '+chr(10);
    // s := s + ' FROM '+chr(10);
    // s := s + '   TelPriceRules '+chr(10);
    // s := s + '     LEFT OUTER JOIN TelPriceGroups ON TelPriceRules.tpgCode = TelPriceGroups.Code '+chr(10);
    // s := s + ' WHERE '+chr(10);
    // s := s + '   (TelPriceRules.doUse = 1) '+chr(10);
    // s := s + ' ORDER BY '+chr(10);
    // s := s + '   TelPriceRules.displayOrder '+chr(10);
    s := format(select_FillLstTelPriceMasks, []);
    if hData.rSet_bySQL(rSet, s) then
    begin
      lstMasks.clear;
      rSet.First;
      while not rSet.Eof do
      begin
        inc(result);
        lstMasks.Add(rSet.fieldbyname('Code').asString + '|' + rSet.fieldbyname('RuleDescription').asString + '|' + rSet.fieldbyname('Mask').asString + '|' +
          rSet.fieldbyname('tpgCode').asString + '|' + rSet.fieldbyname('price').asString + '|' + rSet.fieldbyname('PriceDescription').asString);

        rSet.Next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function GET_ChannelManagerHolderById(var theData: recChannelManagerHolder): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  // *NOT TERSTED*//
  result := false;

  // s := '';
  // s := s+ ' SELECT '+#10;
  // s := s+ '   CountryGroup '+#10;
  // s := s+ '  , GroupName '+#10;
  // s := s+ '  , IslGroupName '+#10;
  // s := s+ '  , OrderIndex '+#10;
  // s := s+ ' FROM '+#10;
  // s := s+ '   CountryGroups '+#10;
  // s := s+ ' WHERE '+#10;
  // s := s+ '  (CountryGroup = N'+quotedstr(getItem)+') '+#10;

  s := format(select_GET_ChannelManagerHolderById, [theData.id]);

  rSet := CreateNewDataSet;
  try
    if rSet_bySQL(rSet, s) then
    begin
      result := true;
      theData.Code := rSet.fieldbyname('code').asString;
      theData.Description := rSet.fieldbyname('Description').asString;
      theData.serviceUsername := rSet.fieldbyname('webserviceUsername').asString;
      theData.webserviceURI := rSet.fieldbyname('webserviceURI').asString;
      theData.servicePassword := rSet.fieldbyname('webservicePassword').asString;
      theData.webserviceHotelCode := rSet.fieldbyname('webserviceHotelCode').asString;

      theData.serviceRequestorID := rSet.fieldbyname('weserviceRequestor').asString;

      theData.active := rSet.fieldbyname('active').Asboolean;
      theData.sendRate := rSet.fieldbyname('sendRate').Asboolean;
      theData.sendAvailability := rSet.fieldbyname('sendAvailability').Asboolean;
      theData.sendStopSell := rSet.fieldbyname('sendStopSell').Asboolean;
      theData.sendMinStay := rSet.fieldbyname('sendMinStay').Asboolean;

      theData.portalAdminUsername := rSet.fieldbyname('adminUsername').asString;
      theData.portalAdminPassword := rSet.fieldbyname('adminPassword').asString;
      theData.channels := rSet.fieldbyname('channels').asString;
      theData.maintenanceDays := rSet.fieldbyname('maintenanceDays').asInteger;
      theData.directConnection := rSet.fieldbyname('directConnection').Asboolean;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function GET_CountryGroupHolderByGountryGroup(var theData: recCountryGroupHolder): boolean;
var
  getItem: string;
  s: string;
  rSet: TRoomerDataSet;
begin
  // *NOT TERSTED*//
  result := false;

  getItem := theData.CountryGroup;
  // s := '';
  // s := s+ ' SELECT '+#10;
  // s := s+ '   CountryGroup '+#10;
  // s := s+ '  , GroupName '+#10;
  // s := s+ '  , IslGroupName '+#10;
  // s := s+ '  , OrderIndex '+#10;
  // s := s+ ' FROM '+#10;
  // s := s+ '   CountryGroups '+#10;
  // s := s+ ' WHERE '+#10;
  // s := s+ '  (CountryGroup = N'+quotedstr(getItem)+') '+#10;

  s := format(select_GET_CountryGroupHolderByGountryGroup, [quotedstr(getItem)]);

  rSet := CreateNewDataSet;
  try
    if rSet_bySQL(rSet, s) then
    begin
      result := true;
      theData.CountryGroup := rSet.fieldbyname('CountryGroup').asString;
      theData.GroupName := rSet.fieldbyname('GroupName').asString;
      theData.islGroupName := rSet.fieldbyname('islGroupName').asString;
      theData.OrderIndex := rSet.fieldbyname('OrderIndex').asInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function GET_CountryGroupDefault(): string;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  // *NOT TERSTED*//
  result := '';

  // s := '';
  // s := s+ ' SELECT top(1) '+#10;
  // s := s+ '   CountryGroup '+#10;
  // s := s+ ' FROM '+#10;
  // s := s+ '   CountryGroups '+#10;
  // s := s+ ' ORDER BY orderIndex DESC '+#10;

  s := format(select_GET_CountryGroupDefault, []);

  rSet := CreateNewDataSet;
  try
    if rSet_bySQL(rSet, s) then
    begin
      result := rSet.fieldbyname('CountryGroup').asString;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function UPD_CountryGroup(theData: recCountryGroupHolder): boolean;
var
  s: string;
begin
  if theData.tmp = '' then
    theData.tmp := theData.CountryGroup;

  s := '';
  s := s + ' UPDATE countrygroups ' + #10;
  s := s + ' SET ' + #10;
  s := s + '     CountryGroup = ' + _db(theData.CountryGroup) + ' ' + #10;
  s := s + '   , GroupName =' + _db(theData.GroupName) + ' ' + #10;
  s := s + '   , IslGroupName =' + _db(theData.islGroupName) + ' ' + #10;
  s := s + '   , OrderIndex =' + _db(theData.OrderIndex) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (CountryGroup = ' + _db(theData.tmp) + ') ';

  result := cmd_bySQL(s);
end;

function UPD_CHannelManager(theData: recChannelManagerHolder): boolean;
var
  s: string;
begin
  if theData.tmp = '' then
    theData.tmp := inttostr(theData.id);

  s := '';
  s := s + ' UPDATE channelmanagers ' + #10;
  s := s + ' SET ' + #10;
  s := s + '     code = ' + _db(theData.Code) + ' ' + #10;
  s := s + '   , Description = ' + _db(theData.Description) + ' ' + #10;
  s := s + '   , adminUsername =' + _db(theData.portalAdminUsername) + ' ' + #10;
  s := s + '   , adminPassword =' + _db(theData.portalAdminPassword) + ' ' + #10;
  s := s + '   , webserviceURI =' + _db(theData.webserviceURI) + ' ' + #10;
  s := s + '   , webserviceUsername =' + _db(theData.serviceUsername) + ' ' + #10;
  s := s + '   , webservicePassword =' + _db(theData.servicePassword) + ' ' + #10;
  s := s + '   , webserviceHotelCode =' + _db(theData.webserviceHotelCode) + ' ' + #10;
  s := s + '   , weserviceRequestor =' + _db(theData.serviceRequestorID) + ' ' + #10;

  s := s + '   , active =' + _db(theData.active) + ' ' + #10;
  s := s + '   , sendRate =' + _db(theData.sendRate) + ' ' + #10;
  s := s + '   , sendAvailability =' + _db(theData.sendAvailability) + ' ' + #10;
  s := s + '   , sendStopSell =' + _db(theData.sendStopSell) + ' ' + #10;
  s := s + '   , sendMinStay =' + _db(theData.sendMinStay) + ' ' + #10;
  s := s + '   , maintenanceDays =' + _db(theData.maintenanceDays) + ' ' + #10;
  s := s + '   , directConnection =' + _db(theData.directConnection) + ' ' + #10;

  s := s + '   , channels =' + _db(theData.channels) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (Id = ' + theData.tmp + ') ';

  result := cmd_bySQL(s);
end;

function INS_ChannelManager(theData: recChannelManagerHolder): boolean;
var
  s: string;
  i: integer;
begin
  if theData.tmp = '' then
    theData.tmp := inttostr(theData.id);
  s := '';
  s := s + 'INSERT INTO channelmanagers ' + #10;
  s := s + '   ( ' + #10;
  s := s + '      code ' + #10;
  s := s + '    , Description ' + #10;
  s := s + '    , adminUsername ' + #10;
  s := s + '    , adminPassword ' + #10;
  s := s + '    , webserviceURI ' + #10;
  s := s + '    , webserviceUsername ' + #10;
  s := s + '    , webservicePassword ' + #10;
  s := s + '    , webserviceHotelCode ' + #10;
  s := s + '    , weserviceRequestor ' + #10;

  s := s + '    , active ' + #10;
  s := s + '    , sendRate ' + #10;
  s := s + '    , sendAvailability ' + #10;
  s := s + '    , sendStopSell ' + #10;
  s := s + '    , sendMinStay ' + #10;
  s := s + '    , maintenanceDays ' + #10;
  s := s + '    , directConnection ' + #10;

  s := s + '    , channels ' + #10;
  s := s + '   ) ' + #10;
  s := s + '    VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '     ' + _db(theData.Code) + ' ' + #10;
  s := s + '    ,' + _db(theData.Description) + ' ' + #10;
  s := s + '    ,' + _db(theData.portalAdminUsername) + ' ' + #10;
  s := s + '    ,' + _db(theData.portalAdminPassword) + ' ' + #10;
  s := s + '    ,' + _db(theData.webserviceURI) + ' ' + #10;
  s := s + '    ,' + _db(theData.serviceUsername) + ' ' + #10;
  s := s + '    ,' + _db(theData.servicePassword) + ' ' + #10;
  s := s + '    ,' + _db(theData.webserviceHotelCode) + ' ' + #10;
  s := s + '    ,' + _db(theData.serviceRequestorID) + ' ' + #10;

  s := s + '    ,' + _db(theData.active) + ' ' + #10;
  s := s + '    ,' + _db(theData.sendRate) + ' ' + #10;
  s := s + '    ,' + _db(theData.sendAvailability) + ' ' + #10;
  s := s + '    ,' + _db(theData.sendStopSell) + ' ' + #10;
  s := s + '    ,' + _db(theData.sendMinStay) + ' ' + #10;
  s := s + '    ,' + _db(theData.maintenanceDays) + ' ' + #10;
  s := s + '    ,' + _db(theData.directConnection) + ' ' + #10;

  s := s + '    ,' + _db(theData.channels) + ' ' + #10;
  s := s + '   )';
  i := d.roomerMainDataSet.DoCommand(s);
  theData.tmp := inttostr(i);
  result := i >= 0; // cmd_bySQL(s, Connection,loglevel,logpath);
end;

function INS_CountryGroup(theData: recCountryGroupHolder): boolean;
var
  s: string;
begin
  if theData.tmp = '' then
    theData.tmp := theData.CountryGroup;
  s := '';
  s := s + 'INSERT INTO countrygroups ' + #10;
  s := s + '   ( ' + #10;
  s := s + '      CountryGroup ' + #10;
  s := s + '    , GroupName ' + #10;
  s := s + '    , IslGroupName ' + #10;
  s := s + '    , OrderIndex ' + #10;
  s := s + '   ) ' + #10;
  s := s + '    VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '     ' + _db(theData.CountryGroup) + ' ' + #10;
  s := s + '    ,' + _db(theData.GroupName) + ' ' + #10;
  s := s + '    ,' + _db(theData.islGroupName) + ' ' + #10;
  s := s + '    ,' + _db(theData.OrderIndex) + ' ' + #10;
  s := s + '   )';
  result := cmd_bySQL(s);
end;

function Del_countryGroupByCountryGroup(sCode: string): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + #10;
  s := s + '   FROM countrygroups ' + #10;
  s := s + ' WHERE  ' + #10;
  s := s + '   (countryGroup =' + quotedstr(sCode) + ') ';
  result := cmd_bySQL(s);
end;

function Del_ChannelManagerByID(id: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + #10;
  s := s + '   FROM channelmanagers ' + #10;
  s := s + ' WHERE  ' + #10;
  s := s + '   (id =' + inttostr(id) + ') ';
  result := cmd_bySQL(s);
end;

function CountryGroupExistsInOther(sCountryGroup: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin

  // s := '';
  // s := s + ' SELECT CountryGroup FROM [Countries] '+chr(10);
  // s := s + ' WHERE (CountryGroup = ' + quotedstr(sCountryGroup) + ') '+chr(10);
  s := format(select_CountryGroupExistsInOther, [quotedstr(sCountryGroup)]);
  rSet := CreateNewDataSet;
  try
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function CountryGroupExist(sCode: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  // s := s + ' SELECT CountryGroup FROM [CountryGroups] '+#10;
  // s := s + ' WHERE (CountryGroup = ' + quotedstr(sCode) + ') ';

  s := format(select_CountryGroupExist, [quotedstr(sCode)]);
  rSet := CreateNewDataSet;
  try
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

procedure initCountryHolder(var rec: recCountryHolder);
begin
  with rec do
  begin
    Country := '';
    CountryName := '';
    IslCountryName := '';
    Currency := '';
    CountryGroup := '';
    OrderIndex := 0;
    CurrenciesDescription := '';
    CountryGroupsGroupName := '';
    active := true;
    tmp := '';
  end;
end;

function GET_countryHolderByCountry(var theData: recCountryHolder): boolean;
var
  getItem: string;
  s: string;
  rSet: TRoomerDataSet;
begin
  result := false;

  getItem := theData.Country;

  s := format(select_GET_CountryHolderByCountry, [quotedstr(getItem)]);

  rSet := CreateNewDataSet;
  try
    if rSet_bySQL(rSet, s) then
    begin
      result := true;
      theData.Country := rSet.fieldbyname('Country').asString;
      theData.CountryName := rSet.fieldbyname('CountryName').asString;
      theData.IslCountryName := rSet.fieldbyname('IslCountryName').asString;
      theData.Currency := rSet.fieldbyname('Currency').asString;
      theData.CountryGroup := rSet.fieldbyname('CountryGroup').asString;
      theData.OrderIndex := rSet.fieldbyname('OrderIndex').asInteger;
      theData.active := rSet.fieldbyname('Active').Asboolean;
      theData.id := rSet.fieldbyname('ID').asInteger;

      theData.CurrenciesDescription := rSet.fieldbyname('CurrenciesDescription').asString;
      theData.CountryGroupsGroupName := rSet.fieldbyname('CountryGroupsGroupName').asString;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function GET_CountryCurrency(sCode: string): string;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := '';

  s := format(select_GET_CountryCurrency, [quotedstr(sCode)]);
  rSet := CreateNewDataSet;
  try
    rSet_bySQL(rSet, s);
    if not rSet.Eof then
    begin
      result := rSet.fieldbyname('CountryName').asString;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function CountryExistsInOther(sCountry: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin

  rSet := CreateNewDataSet;
  try
    s := format(select_CountryExistsInOther, [quotedstr(sCountry)]);
    result := rSet_bySQL(rSet, s);
    if result then
      exit;

    s := format(select_CountryExistsInOther2, [quotedstr(sCountry)]);
    result := rSet_bySQL(rSet, s);
    if result then
      exit;

    s := format(select_CountryExistsInOther3, [quotedstr(sCountry)]);
    result := rSet_bySQL(rSet, s);
    if result then
      exit;

    s := format(select_CountryExistsInOther4, [quotedstr(sCountry)]);
    result := rSet_bySQL(rSet, s);
    if result then
      exit;

    s := format(select_CountryExistsInOther5, [quotedstr(sCountry)]);
    result := rSet_bySQL(rSet, s);
    if result then
      exit;

    s := format(select_CountryExistsInOther6, [quotedstr(sCountry)]);
    result := rSet_bySQL(rSet, s);
    if result then
      exit;
  finally
    freeandnil(rSet);
  end;
end;

function CountryExists(sCode: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  s := format(select_CountryExists, [quotedstr(sCode)]);
  rSet := CreateNewDataSet;
  try
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function UPD_Country(theData: recCountryHolder): boolean;
var
  s: string;
begin
  if theData.tmp = '' then
    theData.tmp := theData.Country;
  s := '';
  s := s + ' UPDATE countries ' + #10;
  s := s + ' SET ' + #10;
  s := s + '     Country   = ' + _db(theData.Country) + ' ' + #10;
  s := s + '   , CountryName =' + _db(theData.CountryName) + ' ' + #10;
  s := s + '   , IslCountryName =' + _db(theData.IslCountryName) + ' ' + #10;
  s := s + '   , OrderIndex =' + _db(theData.OrderIndex) + ' ' + #10;
  s := s + '   , Currency =' + _db(theData.Currency) + ' ' + #10;
  s := s + '   , CountryGroup =' + _db(theData.CountryGroup) + ' ' + #10;
  s := s + '   , Active =' + _db(theData.active) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (Country = ' + _db(theData.tmp) + ') ';
  result := cmd_bySQL(s);
end;

function DEL_CountryByCountry(sCountry: string): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM countries ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (Country =' + quotedstr(sCountry) + ') ';
  result := cmd_bySQL(s);
end;

function INS_Country(theData: recCountryHolder; var NewID: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'INSERT INTO countries ' + #10;
  s := s + '   ( ' + #10;
  s := s + '   Country ' + #10;
  s := s + '  ,CountryName ' + #10;
  s := s + '  ,Currency ' + #10;
  s := s + '  ,CountryGroup ' + #10;
  s := s + '  ,OrderIndex ' + #10;
  s := s + '  ,IslCountryName ' + #10;
  s := s + '  ,Active ' + #10;
  s := s + '   ) ' + #10;
  s := s + '    VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '     ' + _db(theData.Country) + ' ' + #10;
  s := s + '     ,' + _db(theData.CountryName) + ' ' + #10;
  s := s + '     ,' + _db(theData.Currency) + ' ' + #10;
  s := s + '     ,' + _db(theData.CountryGroup) + ' ' + #10;
  s := s + '     ,' + _db(theData.OrderIndex) + ' ' + #10;
  s := s + '     ,' + _db(theData.IslCountryName) + ' ' + #10;
  s := s + '     ,' + _db(theData.active) + ' ' + #10;
  s := s + '   )';
  result := cmd_bySQL(s);
  if result then
  begin
    NewID := GetLastID('countries');
  end;

end;

/// //////////////////////////////////////////////////////////////////
// Currency
/// ///////////////////////////////////////////////////////////////////

procedure recCurrencyHolder.ReadFromDataset(aRset: TDataset);
begin
  id := aRSet.fieldbyname('ID').asInteger;
  Currency := aRSet.fieldbyname('currency').asString;
  Description := aRSet.fieldbyname('description').asString;
  Value := LocalFloatValue(aRSet.fieldbyname('aValue').asString);
  SellValue := LocalFloatValue(aRSet.fieldbyname('SellValue').asString);
  Decimals := aRSet.fieldbyname('Decimals').asinteger;
  Displayformat := aRSet.fieldbyname('Displayformat').asString;
  CurrencySign := aRSet.fieldbyname('CurrencySign').asString;
  active := aRSet.fieldbyname('active').Asboolean;
end;

procedure recCurrencyHolder.Init;
begin
  id := 0;
  Currency := '';
  Description := '';
  Value := 1.00;
  SellValue := 0;
  Decimals := 0;
  DisplayFormat := '';
  CurrencySign := '';
  active := true;
end;

function GET_CurrencyHolderByCurrency(var theData: recCurrencyHolder; justActive: boolean = true): boolean;
var
  getItem: string;
  s: string;
  rSet: TRoomerDataSet;
begin
  result := false;
  getItem := theData.Currency;

  s := format(select_GET_CurrencyHolderByCurrency, [quotedstr(getItem)]);
  rSet := CreateNewDataSet;
  try
    if rSet_bySQL(rSet, s) then
    begin
      result := true;
      theData.ReadFromDataset(rSet);
    end;
  finally
    freeandnil(rSet);
  end;
end;

function GET_CurrencyHolderByID(var theData: recCurrencyHolder): boolean;
var
  getItem: integer;
  s: string;
  rSet: TRoomerDataSet;
begin
  result := false;
  getItem := theData.id;

  s := format(select_GET_CurrencyHolderByCurrency, [_db(getItem)]);
  rSet := CreateNewDataSet;
  try
    if rSet_bySQL(rSet, s) then
    begin
      result := true;
      theData.ReadFromDataset(rSet);
    end;
  finally
    freeandnil(rSet);
  end;
end;

function GET_CurrencyByID(aID: integer): string;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := '';
  s := '';
  s := s + ' SELECT ' + #10;
  s := s + '    Currency ' + #10;
  s := s + ' FROM ' + #10;
  s := s + '   currencies ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '  (ID = %d) ';

  s := format(s, [aID]);

  rSet := CreateNewDataSet;
  try
    if rSet_bySQL(rSet, s) then
    begin
      result := rSet.fieldbyname('currency').asString;
    end;
  finally
    freeandnil(rSet);
  end;

end;

function GET_IdByCurrency(Currency: string): integer;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := 0;
  s := s + ' SELECT ' + #10;
  s := s + '    ID ' + #10;
  s := s + ' FROM ' + #10;
  s := s + '   currencies ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '  (currency = %s) ';

  s := format(s, [_db(Currency)]);

  rSet := CreateNewDataSet;
  try
    if rSet_bySQL(rSet, s) then
    begin
      result := rSet.fieldbyname('ID').asInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function UPD_currency(theData: recCurrencyHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE currencies ' + #10;
  s := s + ' SET ' + #10;
  s := s + '     Description =' + _db(theData.Description) + ' ' + #10;
  s := s + '   , Avalue =' + _db(theData.Value) + ' ' + #10;
  s := s + '   , Decimals =' + _db(theData.Decimals) + ' ' + #10;
  s := s + '   , DisplayFormat=' + _db(theData.Displayformat) + ' ' + #10;
  s := s + '   , CurrencySign =' + _db(theData.CurrencySign) + ' ' + #10;
  s := s + '   , Active =' + _db(theData.active) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (currency = ' + _db(theData.Currency) + ') ';
  CopyToClipboard(s);
  result := cmd_bySQL(s);
end;

function UPD_currencyRate(Currency: string; Rate: double): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE currencies ' + #10;
  s := s + ' SET ' + #10;
  s := s + '   Avalue =' + _db(Rate) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (currency = ' + _db(Currency) + ') ';
  result := cmd_bySQL(s);
end;

function INS_currency(theData: recCurrencyHolder; var NewID: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'INSERT INTO currencies ' + #10;
  s := s + '   ( ' + #10;
  s := s + '   currency ' + #10;
  s := s + '  ,Description ' + #10;
  s := s + '  ,AValue ' + #10;
  s := s + '  ,SellValue' + #10;
  s := s + '  ,Decimals ' + #10;
  s := s + '  ,DisplayFormat ' + #10;
  s := s + '  ,Active ' + #10;
  s := s + '   ) ' + #10;
  s := s + '    VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '     ' + _db(theData.Currency) + ' ' + #10;
  s := s + '     ,' + _db(theData.Description) + ' ' + #10;
  s := s + '     ,' + _db(theData.Value) + ' ' + #10;
  s := s + '     ,' + _db(theData.SellValue) + ' ' + #10;
  s := s + '     ,' + _db(theData.Decimals) + ' ' + #10;
  s := s + '     ,' + _db(theData.Displayformat) + ' ' + #10;
  s := s + '     ,' + _db(theData.active) + ' ' + #10;
  s := s + '   )';
  result := cmd_bySQL(s);
  if result then
  begin
    NewID := GetLastID('currencies');
  end;

end;

function currencyExistsInOther(sCurrency: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try

    // s := s + ' SELECT NativeCurrency FROM [Control] '+chr(10);
    // s := s + ' WHERE (NativeCurrency = ' + quotedstr(sCurrency) + ') '+chr(10);
    s := format(select_currencyExistsInOther, [quotedstr(sCurrency)]);
    result := rSet_bySQL(rSet, s);
    if result then
      exit;

    // s := s + ' SELECT Currency FROM [Countries] '+chr(10);
    // s := s + ' WHERE (Currency = ' + quotedstr(sCurrency) + ') '+chr(10);
    s := format(select_currencyExistsInOther1, [quotedstr(sCurrency)]);
    result := rSet_bySQL(rSet, s);
    if result then
      exit;

    // s := s + ' SELECT Currency FROM [Customers] '+chr(10);
    // s := s + ' WHERE (Currency = ' + quotedstr(sCurrency) + ') '+chr(10);
    s := format(select_currencyExistsInOther2, [quotedstr(sCurrency)]);
    result := rSet_bySQL(rSet, s);
    if result then
      exit;

    // s := s + ' SELECT Currency FROM [PriceTypes] '+chr(10);
    // s := s + ' WHERE (Currency = ' + quotedstr(sCurrency) + ') '+chr(10);
    s := format(select_currencyExistsInOther3, [quotedstr(sCurrency)]);
    result := rSet_bySQL(rSet, s);
    if result then
      exit;

    // s := s +' SELECT Currency FROM [InvoiceLines] '+chr(10);
    // s := s + ' WHERE (Currency = ' + quotedstr(sCurrency) + ') '+chr(10);
    s := format(select_currencyExistsInOther4, [quotedstr(sCurrency)]);
    result := rSet_bySQL(rSet, s);
    if result then
      exit;

    // s := s + ' SELECT Currency FROM [Payments] '+chr(10);
    // s := s + ' WHERE (Currency = ' + quotedstr(sCurrency) + ') '+chr(10);
    s := format(select_currencyExistsInOther5, [quotedstr(sCurrency)]);
    result := rSet_bySQL(rSet, s);
    if result then
      exit;

    // s := s + ' SELECT Currency FROM [RoomReservations] '+chr(10);
    // s := s + ' WHERE (Currency = ' + quotedstr(sCurrency) + ') '+chr(10);
    s := format(select_currencyExistsInOther6, [quotedstr(sCurrency)]);
    result := rSet_bySQL(rSet, s);
    if result then
      exit;

  finally
    freeandnil(rSet);
  end;
end;

function Del_ReservationByreservation(Reservation: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM reservations ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (reservation =' + _db(Reservation) + ') ';
  result := cmd_bySQL(s);
end;

function Del_currencyBycurrency(sCurrency: string): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM currencies ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (currency =' + quotedstr(sCurrency) + ') ';
  result := cmd_bySQL(s);
end;

function CurrencyExist(sCurrency: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  // s := s + 'SELECT '+chr(10);
  // s := s + 'Currency '+chr(10);
  // s := s + 'FROM '+chr(10);
  // s := s + 'Currencies '+chr(10);
  // s := s + 'WHERE '+chr(10);
  // s := s + 'Currency = ' + quotedstr(sCurrency) + '  '+chr(10);

  rSet := CreateNewDataSet;
  try
    s := format(select_CurrencyExist, [quotedstr(sCurrency)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;


function invoiceList_FromTo(DateFrom, DateTo: Tdate; Location : string = ''): TstringList;
var
  s: string;
  rSet: TRoomerDataSet;
  listItem: integer;
  sql : string;
begin
  result := TstringList.Create;

  sql := sql+' SELECT '#10;
  sql := sql+'   InvoiceNumber '#10;
  sql := sql+' FROM '#10;
  sql := sql+'   InvoiceHeads '#10;
  sql := sql+' WHERE '#10;
  sql := sql+'       (InvoiceNumber > 0) '#10;
  sql := sql+'    AND (InvoiceDate >= %s)'#10;
  sql := sql+'    AND (InvoiceDate <= %s)';
  if Location <> '' then
  begin
    sql := sql+'    AND (Location in (%s)) ';
  end;

  rSet := CreateNewDataSet;
  try
    s := format(sql, [_dateToDBdate(DateFrom, true), _dateToDBdate(DateTo, true),location]);
    if rSet_bySQL(rSet, s) then
    begin
      while not rSet.Eof do
      begin
        listItem := rSet.fieldbyname('InvoiceNumber').asInteger;
        result.Add(inttostr(listItem));
        rSet.Next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function invoiceList_ConfirmGroup(confirmDate: TdateTime): TstringList;
var
  s: string;
  rSet: TRoomerDataSet;
  listItem: integer;
begin
  result := TstringList.Create;

  // s := '';
  // s := s +' SELECT '+#10;
  // s := s +'   InvoiceNumber '+#10;
  // s := s +' FROM '+#10;
  // s := s +'   InvoiceHeads '+#10;
  // s := s +' WHERE '+#10;
  // s := s +'       (InvoiceNumber > 0) '+#10;
  // s := s +'    AND (ihConfirmDate = '+_DateTimeToDbDate(confirmDate,true)+')';
  rSet := CreateNewDataSet;
  try
    s := format(select_invoiceList_ConfirmGroup, [_dateTimeToDBdate(confirmDate, true)]);
    rSet_bySQL(rSet, s);
    while not rSet.Eof do
    begin
      listItem := rSet.fieldbyname('InvoiceNumber').asInteger;
      result.Add(inttostr(listItem));
      rSet.Next;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function invoiceList_Unconfirmed(Location : string = ''): TstringList;
var
  s: string;
  rSet: TRoomerDataSet;
  listItem: integer;
  sql : string;
begin
  result := TstringList.Create;


  sql := '';
  sql := sql+ ' SELECT '#10;
  sql := sql+'   InvoiceNumber '#10;
  sql := sql+' FROM '#10;
  sql := sql+'   invoiceheads '#10;
  sql := sql+' WHERE '#10;
  sql := sql+'       (InvoiceNumber > 0) '#10;
  sql := sql+'    AND (ihConfirmDate = %s) ';

  if Location <> '' then
  begin
    sql := sql+'    AND (Location in (%s)) ';
  end;

  rSet := CreateNewDataSet;
  try
    s := format(sql, [_dateToDBdate(2, true),location]);

    if rSet_bySQL(rSet, s) then
    begin
      while not rSet.Eof do
      begin
        listItem := rSet.fieldbyname('InvoiceNumber').asInteger;
        result.Add(inttostr(listItem));
        rSet.Next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function invoiceList_confirmed(confirmDate: TdateTime): TstringList;
var
  s: string;
  rSet: TRoomerDataSet;
  listItem: integer;
  sql: string;
begin
  result := TstringList.Create;

  sql := ' SELECT '#10 + '   InvoiceNumber '#10 + ' FROM '#10 + '   invoiceheads '#10 + ' WHERE '#10 + '       (InvoiceNumber > 0) '#10 +
    '    AND (ihConfirmDate = %s)'; // '+_DateToDbDate(2,true)+'

  rSet := CreateNewDataSet;
  try
    s := format(sql, [_dbDateAndTime(confirmDate)]);

    // copytoclipboard(s);
    // debugMessage(s);

    if rSet_bySQL(rSet, s) then
    begin
      while not rSet.Eof do
      begin
        listItem := rSet.fieldbyname('InvoiceNumber').asInteger;
        result.Add(inttostr(listItem));
        rSet.Next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure initConvertHolder(var rec: recConvertHolder);
begin
  with rec do
  begin
    cvID := 0;
    cvType := '';
    cvFrom := '';
    cvTo := '';
    tmp := 0;
    active := true;
  end;
end;

function GET_ConvertHolder(var theData: recConvertHolder): boolean;
var
  getItem: integer;
  s: string;
  rSet: TRoomerDataSet;
begin
  result := false;

  getItem := theData.cvID;

  // s := s+ ' SELECT '+#10;
  // s := s+ '    ID '+#10;
  // s := s+ '   ,cvType '+#10;
  // s := s+ '   ,cvFrom '+#10;
  // s := s+ '   ,cvTo '+#10;
  // s := s+ ' FROM tblConverts '+#10;
  // s := s+ ' WHERE '+#10;
  // s := s+ '   ID = '+inttostr(getItem)+' ';

  rSet := CreateNewDataSet;
  try
    s := format(select_GET_ConvertHolder, [inttostr(getItem)]);
    if rSet_bySQL(rSet, s) then
    begin
      result := true;
      theData.cvID := rSet.fieldbyname('ID').asInteger;
      theData.cvType := rSet.fieldbyname('cvType').asString;
      theData.cvFrom := rSet.fieldbyname('cvFrom').asString;
      theData.cvTo := rSet.fieldbyname('cvTo').asString;
      theData.active := rSet.fieldbyname('Active').Asboolean;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function UPD_convert(theData: recConvertHolder): boolean;
var
  s: string;
begin
  if theData.tmp = 0 then
    theData.tmp := theData.cvID;
  if theData.cvID = 0 then
    theData.tmp := convertGetLastID();

  s := '';
  s := s + ' UPDATE tblconverts ' + #10;
  s := s + ' SET ' + #10;
  s := s + '    cvType = ' + _db(theData.cvType) + ' ' + #10;
  s := s + '   ,Active = ' + _db(theData.active) + ' ' + #10;
  s := s + '   ,cvFrom = ' + _db(theData.cvFrom) + ' ' + #10;
  s := s + '   ,cvTo   = ' + _db(theData.cvTo) + ' ' + #10;
  s := s + '  WHERE ' + #10;
  s := s + '  (ID = ' + _db(theData.tmp) + ') ';
  result := cmd_bySQL(s);
end;

function INS_convert(theData: recConvertHolder): boolean;
var
  s: string;
begin

  s := '';
  s := s + 'INSERT INTO tblconverts ' + #10;
  s := s + '  ( ' + #10;
  s := s + '      cvType ' + #10;
  s := s + '    , Active ' + #10;
  s := s + '    , cvFrom ' + #10;
  s := s + '    , cvTo ' + #10;
  s := s + '  ) ' + #10;
  s := s + '  VALUES ' + #10;
  s := s + '  ( ' + #10;
  s := s + '  ' + _db(theData.cvType) + ' ' + #10;
  s := s + ' ,' + _db(theData.active) + ' ' + #10;
  s := s + ' ,' + _db(theData.cvFrom) + ' ' + #10;
  s := s + ' ,' + _db(theData.cvTo) + ' ' + #10;
  s := s + '   ) ';
  result := cmd_bySQL(s);
end;

function Del_convert(theData: recConvertHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM tblconverts ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + _db(theData.cvID) + ') ';
  result := cmd_bySQL(s);
end;

function convertExist(sFrom: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin

  // s := '';
  // s := s + 'SELECT '+chr(10);
  // s := s + 'svFrom '+chr(10);
  // s := s + 'FROM '+chr(10);
  // s := s + 'tblConverts '+chr(10);
  // s := s + 'WHERE '+chr(10);
  // s := s + 'svFrom = ' + _db(sFrom) + ' ';

  rSet := CreateNewDataSet;
  try
    s := format(select_convertExist, [_db(sFrom)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function convertGetLastID: integer;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := -1;
  // s := '';
  // s := s + 'SELECT '+chr(10);
  // s := s + ' ID '+chr(10);
  // s := s + 'FROM '+chr(10);
  // s := s + ' tblConverts'+chr(10);

  rSet := CreateNewDataSet;
  try
    s := format(select_convertGetLastID, []);
    if rSet_bySQL(rSet, s) then
    begin
      rSet.last;
      result := rSet.fieldbyname('ID').asInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function doconvert(sType, sHomeValue: string): string;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := sHomeValue;
  // s := s + 'SELECT '+chr(10);
  // s := s + '  cvType '+chr(10);
  // s := s + ' ,cvTo '+chr(10);
  // s := s + ' ,cvFrom '+chr(10);
  // s := s + 'FROM '+chr(10);
  // s := s + '  tblConverts '+chr(10);
  // s := s + 'WHERE '+chr(10);
  // s := s +   '(cvFrom='+_db(sHomeValue)+')  AND (cvType='+_db(sType)+') ';

  rSet := CreateNewDataSet;
  try
    s := format(select_doconvert, [_db(sHomeValue), _db(sType)]);
    if rSet_bySQL(rSet, s) then
    begin
      result := rSet.fieldbyname('cvTo').asString;
    end;
  finally
    freeandnil(rSet);
  end;
end;

// convertGroups
procedure initConvertGroupHolder(var rec: recConvertGroupHolder);
begin
  with rec do
  begin
    active := true;
    cgCode := '';
    cgDescription := '';
    tmp := -1;
  end;
end;

function UPD_convertGroup(theData: recConvertGroupHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE tblconvertgroups ' + #10;
  s := s + ' SET ' + #10;
  s := s + '     cgCode        = ' + _db(theData.cgCode) + ' ' + #10;
  s := s + '   , cgDescription =' + _db(theData.cgDescription) + ' ' + #10;
  s := s + '   , Active =' + _db(theData.active) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function INS_convertGroup(theData: recConvertGroupHolder): boolean;
var
  s: string;
begin

  s := '';
  s := s + 'INSERT INTO tblconvertgroups ' + #10;
  s := s + '   ( ' + #10;
  s := s + '   cgCode ' + #10;
  s := s + '  ,cgDescription ' + #10;
  s := s + '  ,Active ' + #10;
  s := s + '   ) ' + #10;
  s := s + '    VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '     ' + _db(theData.cgCode) + ' ' + #10;
  s := s + '     ,' + _db(theData.cgDescription) + ' ' + #10;
  s := s + '     ,' + _db(theData.active) + ' ' + #10;
  s := s + '   )';
  result := cmd_bySQL(s);
end;

function DEL_convertGroup(theData: recConvertGroupHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM tblconvertgroups ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function GET_convertGroupHolder(var theData: recConvertGroupHolder): boolean;
var
  getItem: string;
  s: string;
  rSet: TRoomerDataSet;
begin
  result := false;
  getItem := theData.cgCode;

  rSet := CreateNewDataSet;
  try
    s := format(select_GET_convertGroupHolder, [quotedstr(getItem)]);
    if rSet_bySQL(rSet, s) then
    begin
      result := true;
      theData.cgCode := rSet.fieldbyname('cgCode').asString;
      theData.cgDescription := rSet.fieldbyname('cgDescription').asString;
      theData.active := rSet.fieldbyname('Active').Asboolean;
      theData.id := rSet.fieldbyname('ID').asInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function convertGroupExistsInOther(sCode: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  // s := s + ' SELECT cvType FROM [tblConverts] '+#10;
  // s := s + ' WHERE (cvType = ' + quotedstr(sCode) + ') ';
  rSet := CreateNewDataSet;
  try
    s := format(select_convertGroupExistsInOther, [quotedstr(sCode)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function convertGroupExists(sCode: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin

  // s := '';
  // s := s + 'SELECT '+chr(10);
  // s := s + ' cgCode '+chr(10);
  // s := s + 'FROM '+chr(10);
  // s := s + ' tblConvertGroups'+chr(10);
  // s := s + 'WHERE '+chr(10);
  // s := s + 'cgCode = ' + quotedstr(sCode) + '  '+chr(10);

  rSet := CreateNewDataSet;
  try
    s := format(select_convertGroupExists, [quotedstr(sCode)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

/// /////////////////////////////////////////////////////////////////

procedure initPayTypeHolder(var rec: recPayTypeHolder);
begin
  with rec do
  begin
    PayType := '';
    Description := '';
    payGroup := '';
    AskCode := false;
    ptDays := 0;
    doExport := true;
    active := true;
    bookKey := '';
    BookKeepCode := '';
    tmp := '';
  end;
end;

function GET_PayTypeHolder(var theData: recPayTypeHolder): boolean;
var
  getItem: string;
  s: string;
  rSet: TRoomerDataSet;
begin
  result := false;

  getItem := theData.PayType;
  rSet := CreateNewDataSet;
  try
    s := format(select_GET_PayTypeHolder, [quotedstr(getItem)]);
    if rSet_bySQL(rSet, s) then
    begin
      result := true;
      theData.PayType := rSet.fieldbyname('PayType').asString;
      theData.Description := rSet.fieldbyname('Description').asString;
      theData.payGroup := rSet.fieldbyname('PayGroup').asString;
      theData.AskCode := rSet['AskCode'];
      theData.ptDays := rSet.fieldbyname('ptDays').asInteger;
      theData.doExport := rSet['doExport'];
      theData.active := rSet['Active'];
      theData.id := rSet.fieldbyname('ID').asInteger;
      theData.bookKey := rSet.fieldbyname('BookKey').asString;
      theData.BookKeepCode := rSet.fieldbyname('BookKeepCode').asString;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function UPD_PayType(theData: recPayTypeHolder): boolean;
var
  s: string;
begin
  if theData.tmp = '' then
    theData.tmp := theData.PayType;
  s := '';
  s := s + ' UPDATE paytypes ' + #10;
  s := s + ' SET ' + #10;
  s := s + '     PayType       = ' + _db(theData.PayType) + ' ' + #10;
  s := s + '   , Description   =' + _db(theData.Description) + ' ' + #10;
  s := s + '   , PayGroup      =' + _db(theData.payGroup) + ' ' + #10;
  s := s + '   , BookKey       =' + _db(theData.bookKey) + ' ' + #10;
  s := s + '   , BookKeepCode       =' + _db(theData.BookKeepCode) + ' ' + #10;
  s := s + '   , AskCode       =' + _db(theData.AskCode) + ' ' + #10;
  s := s + '   , ptDays        =' + _db(theData.ptDays) + ' ' + #10;
  s := s + '   , doExport      =' + _db(theData.doExport) + ' ' + #10;
  s := s + '   , Active        =' + _db(theData.active) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (payType = ' + _db(theData.tmp) + ') ';
  result := cmd_bySQL(s);
end;

function INS_PayType(theData: recPayTypeHolder; var NewID: integer): boolean;
var
  s: string;
begin

  s := '';
  s := s + 'INSERT INTO paytypes ' + #10;
  s := s + '   ( ' + #10;
  s := s + '    PayType     ' + #10;
  s := s + '  , Description ' + #10;
  s := s + '  , PayGroup    ' + #10;
  s := s + '  , BookKey     ' + #10;
  s := s + '  , BookKeepCode     ' + #10;
  s := s + '  , AskCode     ' + #10;
  s := s + '  , ptDays      ' + #10;
  s := s + '  , doExport    ' + #10;
  s := s + '  , Active    ' + #10;
  s := s + '   ) ' + #10;
  s := s + '    VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '   ' + _db(theData.PayType) + ' ' + #10;
  s := s + '   ,' + _db(theData.Description) + ' ' + #10;
  s := s + '   ,' + _db(theData.payGroup) + ' ' + #10;
  s := s + '   ,' + _db(theData.bookKey) + ' ' + #10;
  s := s + '   ,' + _db(theData.BookKeepCode) + ' ' + #10;
  s := s + '   ,' + _db(theData.AskCode) + ' ' + #10;
  s := s + '   ,' + _db(theData.ptDays) + ' ' + #10;
  s := s + '   ,' + _db(theData.doExport) + ' ' + #10;
  s := s + '   ,' + _db(theData.active) + ' ' + #10;
  s := s + '   )';
  result := cmd_bySQL(s);

  if result then
  begin
    NewID := GetLastID('paytypes');
  end;
end;

function Del_PayType(theData: recPayTypeHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM paytypes ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (payType =' + quotedstr(theData.PayType) + ') ';
  result := cmd_bySQL(s);
end;

function PayTypeExistsInOther(sCode: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  // s := s + ' SELECT PayType FROM [Payments] '+chr(10);
  // s := s + ' WHERE (PayType = ' + quotedstr(sCode) + ') '+chr(10);
  rSet := CreateNewDataSet;
  try
    s := format(select_PayTypeExistsInOther, [quotedstr(sCode)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function PayTypeExist(sCode: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  // s := '';
  // s := s + ' SELECT '+chr(10);
  // s := s + '   PayType '+chr(10);
  // s := s + ' FROM '+chr(10);
  // s := s + '   PayTypes '+chr(10);
  // s := s + ' WHERE '+chr(10);
  // s := s + '   PayType = ' + _db(sCode) + ' ';
  rSet := CreateNewDataSet;
  try
    s := format(select_PayTypeExist, [_db(sCode)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function PayTypesDays(sCode: string): integer;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    s := '';
    s := s + ' SELECT ptDays FROM paytypes '#10;
    s := s + ' WHERE (PayType = %s) ';
    s := format(s, [_db(sCode)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet['ptDays'];
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure initPhoneRateHolder(var rec: recPhoneRateHolder);
begin
  with rec do
  begin
    id := 0; // 5
    Identification := '';
    Description := ''; // 70
    minuteRate := 0.00;
    minimumCost := 0.00;
  end;
end;

function GET_PhoneRateHolder(var theData: recPhoneRateHolder): boolean;
var
  getItem: Integer;
  s: string;
  rSet: TRoomerDataSet;
begin
  result := false;
  getItem := theData.Id;

  // s := s+ ' SELECT '+#10;
  // s := s+ '    PhoneRate '+#10;
  // s := s+ '   ,Description '+#10;
  // s := s+ ' FROM '+#10;
  // s := s+ '   PhoneRates '+#10;
  // s := s+ ' WHERE '+#10;
  // s := s+ '  (PhoneRate = N'+quotedstr(getItem)+') '+#10;

  rSet := CreateNewDataSet;
  try
    s := format('SELECT * FROM phonerates WHERE id=', [inttostr(getItem)]);
    if rSet_bySQL(rSet, s) then
    begin
      result := true;
      theData.id := rSet.fieldbyname('id').asInteger;
      theData.Identification := rSet.fieldbyname('Identification').asString;
      theData.Description := rSet.fieldbyname('description').asString;
      theData.minuteRate := rSet.GetFloatValue(rSet.fieldbyname('minuteRate'));
      theData.minimumCost := rSet.GetFloatValue(rSet.fieldbyname('minimumCost'));
    end;
  finally
    freeandnil(rSet);
  end;
end;

function UPD_PhoneRate(theData: recPhoneRateHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE phonerates ' + #10;
  s := s + ' SET ' + #10;
  s := s + '     Identification =' + _db(theData.Identification) + ' ' + #10;
  s := s + '   , Description =' + _db(theData.Description) + ' ' + #10;
  s := s + '   , minuteRate =' + _db(theData.minuteRate) + ' ' + #10;
  s := s + '   , minimumCost =' + _db(theData.minimumCost) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (id = ' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function INS_PhoneRate(theData: recPhoneRateHolder; var NewID: integer): boolean;
var
  s: string;
begin

  s := '';
  s := s + 'INSERT INTO phonerates ' + #10;
  s := s + '   ( ' + #10;
  s := s + '   Identification ' + #10;
  s := s + '  ,description ' + #10;
  s := s + '  ,minuteRate ' + #10;
  s := s + '  ,minimumCost ' + #10;
  s := s + '   ) ' + #10;
  s := s + '    VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '     ' + _db(theData.Identification) + ' ' + #10;
  s := s + '     ,' + _db(theData.Description) + ' ' + #10;
  s := s + '     ,' + _db(theData.minuteRate) + ' ' + #10;
  s := s + '     ,' + _db(theData.minimumCost) + ' ' + #10;
  s := s + '   )';
  result := cmd_bySQL(s);
  if result then
  begin
    NewID := GetLastID('phonerates');
  end;
end;

function Del_PhoneRate(theData: recPhoneRateHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM phonerates ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (id =' + inttostr(theData.id) + ') ';
  result := cmd_bySQL(s);
end;


procedure initPayGroupHolder(var rec: recPayGroupHolder);
begin
  with rec do
  begin
    payGroup := ''; // 5
    Description := ''; // 30
    active := true;
    cash := False;
    tmp := '';
  end;
end;

function GET_PayGroupHolder(var theData: recPayGroupHolder): boolean;
var
  getItem: string;
  s: string;
  rSet: TRoomerDataSet;
begin
  result := false;
  getItem := theData.payGroup;

  // s := s+ ' SELECT '+#10;
  // s := s+ '    PayGroup '+#10;
  // s := s+ '   ,Description '+#10;
  // s := s+ ' FROM '+#10;
  // s := s+ '   PayGroups '+#10;
  // s := s+ ' WHERE '+#10;
  // s := s+ '  (PayGroup = N'+quotedstr(getItem)+') '+#10;

  rSet := CreateNewDataSet;
  try
    s := format(select_GET_PayGroupHolder, [quotedstr(getItem)]);
    if rSet_bySQL(rSet, s) then
    begin
      result := true;
      theData.payGroup := rSet.fieldbyname('PayGroup').asString;
      theData.Description := rSet.fieldbyname('description').asString;
      theData.active := rSet.fieldbyname('Active').Asboolean;
      theData.Cash := rSet.fieldbyname('Cash').Asboolean;
      theData.id := rSet.fieldbyname('ID').asInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function UPD_PayGroup(theData: recPayGroupHolder): boolean;
var
  s: string;
begin
  if theData.tmp = '' then
    theData.tmp := theData.payGroup;
  s := '';
  s := s + ' UPDATE paygroups ' + #10;
  s := s + ' SET ' + #10;
  s := s + '     payGroup   = ' + _db(theData.payGroup) + ' ' + #10;
  s := s + '   , Description =' + _db(theData.Description) + ' ' + #10;
  s := s + '   , Active =' + _db(theData.active) + ' ' + #10;
  s := s + '   , Cash =' + _db(theData.Cash) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (payGroup = ' + _db(theData.tmp) + ') ';
  result := cmd_bySQL(s);
end;

function INS_PayGroup(theData: recPayGroupHolder; var NewID: integer): boolean;
var
  s: string;
begin

  s := '';
  s := s + 'INSERT INTO paygroups ' + #10;
  s := s + '   ( ' + #10;
  s := s + '   payGroup ' + #10;
  s := s + '  ,description ' + #10;
  s := s + '  ,active ' + #10;
  s := s + '  ,Cash ' + #10;
  s := s + '   ) ' + #10;
  s := s + '    VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '     ' + _db(theData.payGroup) + ' ' + #10;
  s := s + '     ,' + _db(theData.Description) + ' ' + #10;
  s := s + '     ,' + _db(theData.active) + ' ' + #10;
  s := s + '     ,' + _db(theData.Cash) + ' ' + #10;
  s := s + '   )';
  result := cmd_bySQL(s);
  if result then
  begin
    NewID := GetLastID('paygroups');
  end;
end;

function Del_PayGroup(theData: recPayGroupHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM paygroups ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (PayGroup =' + quotedstr(theData.payGroup) + ') ';
  result := cmd_bySQL(s);
end;

function PayGroupExistsInOther(sCode: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_PayGroupExistsInOther, [quotedstr(sCode)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function PayGroupExist(sCode: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_PayGroupExist, [_db(sCode)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;


// *********************

procedure initVatCodeHolder(var rec: recVatCodeHolder);
begin
  with rec do
  begin
    VatCode := '';
    Description := '';
    VATPercentage := 0;
    BookKeepCode := '';
    tmp := '';
  end;
end;

function GET_VatCodeHolder(var theData: recVatCodeHolder): boolean;
var
  getItem: string;
  s: string;
  rSet: TRoomerDataSet;
begin
  result := false;
  getItem := theData.VatCode;

  rSet := CreateNewDataSet;
  try
    s := format(select_GET_VatCodeHolder, [quotedstr(getItem)]);
    if rSet_bySQL(rSet, s) then
    begin
      result := true;
      theData.VatCode := rSet.fieldbyname('VATCode').asString;
      theData.Description := rSet.fieldbyname('description').asString;
      theData.VATPercentage := LocalFloatValue(rSet.fieldbyname('VATPercentage').asString);
      theData.valueFormula := rSet.fieldbyname('valueFormula').asString;
      theData.BookKeepCode := rSet.fieldbyname('BookKeepCode').asString;
    end;
  finally
    freeandnil(rSet);
  end;

end;

function UPD_VatCode(theData: recVatCodeHolder): boolean;
var
  s: string;
begin
  if theData.tmp = '' then
    theData.tmp := theData.VatCode;
  s := '';
  s := s + ' UPDATE vatcodes ' + #10;
  s := s + ' SET ' + #10;
  s := s + '     VATCode = ' + _db(theData.VatCode) + ' ' + #10;
  s := s + '   , Description =' + _db(theData.Description) + ' ' + #10;
  s := s + '   , VATPercentage =' + _db(theData.VATPercentage) + ' ' + #10;
  s := s + '   , valueFormula =' + _db(theData.valueFormula) + ' ' + #10;
  s := s + '   , BookKeepCode =' + _db(theData.BookKeepCode) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (VATCode = ' + _db(theData.tmp) + ') ';
  result := cmd_bySQL(s);
end;

function INS_VatCode(theData: recVatCodeHolder): boolean;
var
  s: string;
begin

  s := '';
  s := s + 'INSERT INTO vatcodes ' + #10;
  s := s + '   ( ' + #10;
  s := s + '   VATCode ' + #10;
  s := s + '  ,description ' + #10;
  s := s + '  ,VATPercentage ' + #10;
  s := s + '  ,valueFormula ' + #10;
  s := s + '  ,BookKeepCode ' + #10;
  s := s + '   ) ' + #10;
  s := s + '    VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '     ' + _db(theData.VatCode) + ' ' + #10;
  s := s + '     ,' + _db(theData.Description) + ' ' + #10;
  s := s + '     ,' + _db(theData.VATPercentage) + ' ' + #10;
  s := s + '     ,' + _db(theData.valueFormula) + ' ' + #10;
  s := s + '     ,' + _db(theData.BookKeepCode) + ' ' + #10;
  s := s + '   )';
  result := cmd_bySQL(s);
end;

function Del_VatCode(theData: recVatCodeHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM vatcodes ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (VATCode =' + quotedstr(theData.VatCode) + ') ';
  result := cmd_bySQL(s);
end;

function VatCodeExistsInOther(sCode: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  // s := s + ' SELECT VatCode FROM [Itemtypes] '+chr(10);
  // s := s + ' WHERE (VatCode = ' + quotedstr(sCode) + ') '+chr(10);
  rSet := CreateNewDataSet;
  try
    s := format(select_VatCodeExistsInOther, [quotedstr(sCode)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function VatCodeExist(sCode: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin

  // s := '';
  // s := s + 'SELECT '+chr(10);
  // s := s + '  VATCode '+chr(10);
  // s := s + 'FROM '+chr(10);
  // s := s + '  VATcodes '+chr(10);
  // s := s + 'WHERE '+chr(10);
  // s := s + '  VATCode = ' + _db(sCode) + ' ';
  rSet := CreateNewDataSet;
  try
    s := format(select_VatCodeExist, [_db(sCode)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

// *********************

procedure initChannelPlanCodeHolder(var rec: recChannelPlanCodeHolder);
begin
  with rec do
  begin
    Code := '';
    Description := '';
    active := true;
    defaultPlan := False;
    tmp := '';
  end;
end;

function GET_ChannelPlanCodeHolder(var theData: recChannelPlanCodeHolder): boolean;
var
  getItem: string;
  s: string;
  rSet: TRoomerDataSet;
begin
  result := false;
  getItem := theData.Code;
  s := s + ' SELECT * ' + #10;
  s := s + ' FROM ' + #10;
  s := s + '   channelplancodes ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '  (Code = N' + quotedstr(getItem) + ') ' + #10;

  rSet := CreateNewDataSet;
  try
    s := format(s, [quotedstr(getItem)]);
    if rSet_bySQL(rSet, s) then
    begin
      result := true;
      theData.Code := rSet.fieldbyname('VATCode').asString;
      theData.Description := rSet.fieldbyname('description').asString;
      theData.active := rSet['active'];
      theData.defaultPlan := rSet['defaultPlan'];
    end;
  finally
    freeandnil(rSet);
  end;
end;

function UPD_ChannelPlanCode(theData: recChannelPlanCodeHolder): boolean;
var
  s: string;
begin
  if theData.tmp = '' then
    theData.tmp := theData.Code;
  s := '';
  s := s + ' UPDATE channelplancodes ' + #10;
  s := s + ' SET ' + #10;
  s := s + '     Code = ' + _db(theData.Code) + ' ' + #10;
  s := s + '   , Description =' + _db(theData.Description) + ' ' + #10;
  s := s + '   , active =' + _db(theData.active) + ' ' + #10;
  s := s + '   , defaultPlan =' + _db(theData.defaultPlan) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (Code = ' + _db(theData.tmp) + ') ';
  result := cmd_bySQL(s);
end;

function INS_ChannelPlanCode(theData: recChannelPlanCodeHolder): boolean;
var
  s: string;
begin

  s := '';
  s := s + 'INSERT INTO channelplancodes ' + #10;
  s := s + '   ( ' + #10;
  s := s + '   Code ' + #10;
  s := s + '  ,description ' + #10;
  s := s + '  ,Active ' + #10;
  s := s + '  ,defaultPlan ' + #10;
  s := s + '   ) ' + #10;
  s := s + '    VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '     ' + _db(theData.Code) + ' ' + #10;
  s := s + '     ,' + _db(theData.Description) + ' ' + #10;
  s := s + '     ,' + _db(theData.active) + ' ' + #10;
  s := s + '     ,' + _db(theData.defaultPlan) + ' ' + #10;
  s := s + '   )';
  result := cmd_bySQL(s);
end;

function Del_ChannelPlanCode(theData: recChannelPlanCodeHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM channelplancodes ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (Code =' + quotedstr(theData.Code) + ') ';
  result := cmd_bySQL(s);
end;

function ChannelPlanCodeExistsInOther(sCode: string): boolean;
begin
  result := false;
  exit;
  // s := s + ' SELECT VatCode FROM [Itemtypes] '+chr(10);
  // s := s + ' WHERE (VatCode = ' + quotedstr(sCode) + ') '+chr(10);
  // RSet := CreateNewDataSet;
  // try
  // s := format(select_VatCodeExistsInOther, [quotedstr(sCode)]);
  // result := rSet_bySQL(rSet,s, Connection,loglevel,logpath);
  // finally
  // freeandnil(rSet);
  // end;
end;

function ChannelPlanCodeExist(sCode: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin

  s := '';
  s := s + 'SELECT ' + chr(10);
  s := s + '  Code ' + chr(10);
  s := s + 'FROM ' + chr(10);
  s := s + '  channelplancodes ' + chr(10);
  s := s + 'WHERE ' + chr(10);
  s := s + '  Code = ' + _db(sCode) + ' ';
  rSet := CreateNewDataSet;
  try
    s := format(s, [_db(sCode)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;

end;

// *********************
/// /////////////////////////////////////////////////////////////////////////////
/// PriceCodes

procedure initPriceCodeHolder(var rec: recPriceCodeHolder);
begin
  with rec do
  begin
    id := 0;
    pcCode := '';
    pcDescription := '';
    pcActive := true;
    pcRack := false;
    pcRackCalc := 1.00;
    pcShowDiscount := false;
    pcDiscountText := '';
    pcAutomatic := false;
    pcLastUpdate := now;
    pcDiscountMethod := 0;
    pcDiscountPriceAfter := 0.00;
    pcDiscountDaysAfter := 0;
    active := true;
    tmp := '';
  end;
end;

function GET_PriceCodeRackID(): integer;
begin
  result := -1;

  // s := '';
  // s := s + 'SELECT '+chr(10);
  // s := s + '  pcRack '+chr(10);
  // s := s + '  ,ID '+chr(10);
  // s := s + 'FROM '+chr(10);
  // s := s + '  tblPriceCodes '+chr(10);
  // s := s + 'WHERE '+chr(10);
  // s := s + '  pcRack = 1 '+chr(10);

  glb.TblpricecodesSet.First;
  if glb.TblpricecodesSet.Locate('PcRack', 1, []) then
  begin
    result := glb.TblpricecodesSet.fieldbyname('ID').asInteger;
  end;

  // RSet := CreateNewDataSet;
  // try
  // s := format(select_GET_PriceCodeRackID, []);
  // if rSet_bySQL(rSet,s, Connection,loglevel,logpath) then
  // begin
  // result := rSet.fieldbyname('ID').asInteger;
  // end;
  // finally
  // freeandnil(rSet);
  // end;
end;

function GET_PriceCodeHolder(var theData: recPriceCodeHolder): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := false;

  // s := '';
  // s := s+ ' SELECT '+#10;
  // s := s+ '  ID '+#10;
  // s := s+ ' ,pcCode '+#10;
  // s := s+ ' ,pcDescription '+#10;
  // s := s+ ' ,pcActive '+#10;
  // s := s+ ' ,pcRack '+#10;
  // s := s+ ' ,pcRackCalc '+#10;
  // s := s+ ' ,pcShowDiscount '+#10;
  // s := s+ ' ,pcDiscountText '+#10;
  // s := s+ ' ,pcAutomatic '+#10;
  // s := s+ ' ,pcLastUpdate '+#10;
  // s := s+ ' ,pcDiscountMethod '+#10;
  // s := s+ ' ,pcDiscountPriceAfter '+#10;
  // s := s+ ' ,pcDiscountDaysAfter '+#10;
  // s := s+ ' ,Active '+#10;
  // s := s+ ' FROM '+#10;
  // s := s+ '   tblPriceCodes '+#10;
  // s := s+ ' WHERE '+#10;
  // s := s+ '  (pcCode = '+quotedStr(theData.pcCode)+') '+#10;

  rSet := CreateNewDataSet;
  try
    s := format(select_GET_PriceCodeHolder, [quotedstr(theData.pcCode)]);
    // CopyToClipboard(s);
    // showmessage('select_GET_PriceCodeHolder'#10#10+s);

    if rSet_bySQL(rSet, s) then
    begin
      result := true;
      theData.id := rSet.fieldbyname('ID').asInteger;
      theData.pcCode := rSet.fieldbyname('pcCode').asString;
      theData.pcDescription := rSet.fieldbyname('pcDescription').asString;
      theData.pcActive := rSet['pcActive'];
      theData.pcRack := rSet['pcRack'];
      theData.pcRackCalc := LocalFloatValue(rSet.fieldbyname('pcRackCalc').asString);
      theData.pcShowDiscount := rSet['pcShowDiscount'];
      theData.pcDiscountText := rSet.fieldbyname('pcDiscountText').asString;
      theData.pcAutomatic := rSet['pcAutomatic'];
      theData.pcLastUpdate := rSet.fieldbyname('pcLastUpdate').AsDateTime;
      theData.pcDiscountMethod := rSet['pcDiscountMethod'];
      theData.pcDiscountPriceAfter := LocalFloatValue(rSet.fieldbyname('pcDiscountPriceAfter').asString);
      theData.pcDiscountDaysAfter := rSet.fieldbyname('pcDiscountDaysAfter').asInteger;
      theData.active := rSet['Active'];
    end;
  finally
    freeandnil(rSet);
  end;
end;

function UPD_PriceCode(theData: recPriceCodeHolder): boolean;
var
  s: string;
begin
  if theData.tmp = '' then
    theData.tmp := theData.pcCode;
  s := '';
  s := s + ' UPDATE tblpricecodes ' + #10;
  s := s + ' SET ' + #10;
  s := s + '    pcCode                 = ' + _db(theData.pcCode) + ' ' + #10;
  s := s + '   ,pcDescription          = ' + _db(theData.pcDescription) + ' ' + #10;
  s := s + '   ,pcActive               = ' + _db(theData.pcActive) + ' ' + #10;
  s := s + '   ,pcRack                 = ' + _db(theData.pcRack) + ' ' + #10;
  s := s + '   ,pcRackCalc             = ' + _db(theData.pcRackCalc) + ' ' + #10;
  s := s + '   ,pcShowDiscount         = ' + _db(theData.pcShowDiscount) + ' ' + #10;
  s := s + '   ,pcDiscountText         = ' + _db(theData.pcDiscountText) + ' ' + #10;
  s := s + '   ,pcAutomatic            = ' + _db(theData.pcAutomatic) + ' ' + #10;
  s := s + '   ,pcLastUpdate           = ' + _db(theData.pcLastUpdate) + ' ' + #10;
  s := s + '   ,pcDiscountMethod       = ' + _db(theData.pcDiscountMethod) + ' ' + #10;
  s := s + '   ,pcDiscountPriceAfter   = ' + _db(theData.pcDiscountPriceAfter) + ' ' + #10;
  s := s + '   ,pcDiscountDaysAfter    = ' + _db(theData.pcDiscountDaysAfter) + ' ' + #10;
  s := s + '   ,Active                 = ' + _db(theData.active) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (pcCode = ' + _db(theData.tmp) + ') ';
  result := cmd_bySQL(s);
end;

function INS_PriceCode(theData: recPriceCodeHolder; var NewID: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'INSERT INTO tblpricecodes ' + #10;
  s := s + '   ( ' + #10;
  s := s + '   pcCode               ' + #10;
  s := s + '  ,pcDescription        ' + #10;
  s := s + '  ,pcActive             ' + #10;
  s := s + '  ,pcRack               ' + #10;
  s := s + '  ,pcRackCalc           ' + #10;
  s := s + '  ,pcShowDiscount       ' + #10;
  s := s + '  ,pcDiscountText       ' + #10;
  s := s + '  ,pcAutomatic          ' + #10;
  s := s + '  ,pcLastUpdate         ' + #10;
  s := s + '  ,pcDiscountMethod     ' + #10;
  s := s + '  ,pcDiscountPriceAfter ' + #10;
  s := s + '  ,pcDiscountDaysAfter  ' + #10;
  s := s + '  ,Active               ' + #10;
  s := s + '   ) ' + #10;
  s := s + '    VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '      ' + _db(theData.pcCode) + ' ' + #10;
  s := s + '     ,' + _db(theData.pcDescription) + ' ' + #10;
  s := s + '     ,' + _db(theData.pcActive) + ' ' + #10;
  s := s + '     ,' + _db(theData.pcRack) + ' ' + #10;
  s := s + '     ,' + _db(theData.pcRackCalc) + ' ' + #10;
  s := s + '     ,' + _db(theData.pcShowDiscount) + ' ' + #10;
  s := s + '     ,' + _db(theData.pcDiscountText) + ' ' + #10;
  s := s + '     ,' + _db(theData.pcAutomatic) + ' ' + #10;
  s := s + '     ,' + _db(theData.pcLastUpdate) + ' ' + #10;
  s := s + '     ,' + _db(theData.pcDiscountMethod) + ' ' + #10;
  s := s + '     ,' + _db(theData.pcDiscountPriceAfter) + ' ' + #10;
  s := s + '     ,' + _db(theData.pcDiscountDaysAfter) + ' ' + #10;
  s := s + '     ,' + _db(theData.active) + ' ' + #10;
  s := s + '   )';
  result := cmd_bySQL(s);
  if result then
  begin
    NewID := GetLastID('tblpricecodes');
  end;
end;

function Del_PriceCode(theData: recPriceCodeHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM tblpricecodes ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + inttostr(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function PriceCoceExistsInOther(id: integer): boolean;
begin
  result := false;
  (*
    s := '';
    s := s + ' SELECT ID FROM [Itemtypes] '+chr(10);
    s := s + ' WHERE (VatCode = ' + quotedstr(sCode) + ') '+chr(10);

    RSet := CreateNewDataSet;
    try
    rSet_bySQL(rSet,s, Connection,loglevel,logpath);
    if not rSet.Eof then
    begin
    result := true;
    exit;
    end;
    finally
    freeandnil(rSet);
    end;
  *)
end;

function PriceCodeExist(Code: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  // s := '';
  // s := s + 'SELECT '+chr(10);
  // s := s + '  pcCode '+chr(10);
  // s := s + 'FROM '+chr(10);
  // s := s + '  tblPriceCodes '+chr(10);
  // s := s + 'WHERE '+chr(10);
  // s := s + '  pcCode = ' + _db(code) + ' ';

  rSet := CreateNewDataSet;
  try
    s := format(select_PriceCodeExist, [_db(Code)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function PriceCode_Code(id: integer): string;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := '';
  // s := s + 'SELECT pcCode '+chr(10);
  // s := s + 'FROM tblPriceCodes  '+chr(10);
  // s := s + 'WHERE  '+chr(10);
  // s := s + '(Id =' + inttostr(Id) + ') '+chr(10);

  rSet := CreateNewDataSet;
  try
    s := format(select_PriceCode_Code, [id]);
    if rSet_bySQL(rSet, s) then
    begin
      result := trim(rSet.fieldbyname('pcCode').asString);
    end;
  finally
    freeandnil(rSet);
  end;
end;

function PriceCode_ID(pcCode: string): integer;
var
  rSet: TRoomerDataSet;
  s: string;

begin
  result := -1;
  // s := '';
  // s := s + 'SELECT '+chr(10);
  // s := s + '  Id '+chr(10);
  // s := s + '  ,pcCode '+chr(10);
  // s := s + 'FROM '+chr(10);
  // s := s + '  tblPriceCodes '+chr(10);
  // s := s + 'WHERE '+chr(10);
  // s := s + '  pcCode=' + quotedstr(pcCode) + ' '+chr(10);
  rSet := CreateNewDataSet;
  try
    s := format(select_PriceCode_ID, [quotedstr(pcCode)]);
    if rSet_bySQL(rSet, s) then
    begin
      result := rSet.fieldbyname('ID').asInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function PriceCode_Rack: string;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := '';

  // s := '';
  // s := s + 'SELECT '+chr(10);
  // s := s + 'pcRack, '+chr(10);
  // s := s + 'pcCode '+chr(10);
  // s := s + 'FROM '+chr(10);
  // s := s + 'tblPriceCodes '+chr(10);
  // s := s + 'WHERE '+chr(10);
  // s := s + 'pcRack = 1 '+chr(10);

  rSet := CreateNewDataSet;
  try
    s := format(select_PriceCode_Rack, []);
    rSet_bySQL(rSet, s);
    if not rSet.Eof then
    begin
      result := trim(rSet.fieldbyname('pcCode').asString);
    end;
  finally
    freeandnil(rSet);
  end;
end;

function priceCode_RackID: integer;
begin
  result := -1;
  // s := '';
  // s := s + 'SELECT '+chr(10);
  // s := s + '   pcRack '+chr(10);
  // s := s + '  ,ID '+chr(10);
  // s := s + 'FROM '+chr(10);
  // s := s + '  tblPriceCodes '+chr(10);
  // s := s + 'WHERE '+chr(10);
  // s := s + '  pcRack = 1 '+chr(10);

  glb.TblpricecodesSet.First;
  if glb.TblpricecodesSet.Locate('PcRack', 1, []) then
  begin
    result := glb.TblpricecodesSet.fieldbyname('ID').asInteger;
  end;

  // RSet := CreateNewDataSet;
  // try
  // s := format(select_priceCode_RackID, []);
  // if rSet_bySQL(rSet,s, Connection,loglevel,logpath) then
  // begin
  // result := rSet.fieldbyname('ID').asInteger;
  // end;
  // finally
  // freeandnil(rSet);
  // end;
end;

function PriceCode_Description(id: integer): string;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := '';
  // s := s + 'SELECT pcDescription '+chr(10);
  // s := s + 'FROM tblPriceCodes  '+chr(10);
  // s := s + 'WHERE  '+chr(10);
  // s := s + '(Id =' + inttostr(ID) + ') '+chr(10);
  rSet := CreateNewDataSet;
  try
    s := format(select_PriceCode_Description, [id]);
    rSet_bySQL(rSet, s);
    if not rSet.Eof then
    begin
      result := trim(rSet.fieldbyname('pcDescription').asString)
    end;
  finally
    freeandnil(rSet);
  end;
end;

function PriceCode_isRack(pcCode: string): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  pcCode := trim(pcCode);

  result := false;

  // s := '';
  // s := s + 'SELECT '+chr(10);
  // s := s + 'pcRack, '+chr(10);
  // s := s + 'pcCode '+chr(10);
  // s := s + 'FROM '+chr(10);
  // s := s + 'tblPriceCodes '+chr(10);
  // s := s + 'WHERE '+chr(10);
  // s := s + 'pcCode = ' + quotedstr(pcCode) + ' '+chr(10);
  rSet := CreateNewDataSet;
  try
    s := format(select_PriceCode_isRack, [quotedstr(pcCode)]);
    rSet_bySQL(rSet, s);
    if not rSet.Eof then
    begin
      result := rSet['pcRack'];
    end;
  finally
    freeandnil(rSet);
  end;
end;

function activePriceTypesExists(sPriceType: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  // s := s + ' SELECT [PcCode] FROM [ViewRoomPrices1] WHERE PcCode =' + quotedstr(sPriceType) + ' ';
  rSet := CreateNewDataSet;
  try
    s := format(select_activePriceTypesExists, [quotedstr(sPriceType)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

/// //////////////////////////////////////////////////////////////////////////
// Greate Availability
//

function RoomTypes_CreateList(var lst: TstringList): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
  fn: string;

begin
  result := true;
  fn := '';
  // s := s + ' SELECT '+chr(10);
  // s := s + '  RoomType '+chr(10);
  // s := s + ' FROM '+chr(10);
  // s := s + '   RoomTYPES '+chr(10);
  // s := s + ' ORDER BY roomType '+chr(10);
  rSet := CreateNewDataSet;
  try
    s := format(select_RoomTypes_CreateList, []);
    if rSet_bySQL(rSet, s) then
    begin
      while not rSet.Eof do
      begin
        lst.Add(rSet.fieldbyname('roomType').asString);
        rSet.Next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function DEL_RoomStatusAll: boolean;
var
  s: string;
  fn: string;
begin
  fn := 'DEL_RoomStatusAll';
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM tblroomstatus ' + chr(10);
  result := cmd_bySQL(s);
end;

function RoomStatus_GetLastDate(): Tdate;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 1;
  // s := '';
  // s := s + ' SELECT TOP (1) '+chr(10);
  // s := s + '   resDate '+chr(10);
  // s := s + ' FROM '+chr(10);
  // s := s + '   dbo.tblRoomStatus '+chr(10);
  // s := s + ' ORDER BY '+chr(10);
  // s := s + '   resDate DESC '+chr(10);

  rSet := CreateNewDataSet;
  try
    s := format(select_RoomStatus_GetLastDate, []);
    if rSet_bySQL(rSet, s) then
    begin
      result := rSet.fieldbyname('resDate').AsDateTime;
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure RoomStatus_addDefault(FromDate: Tdate; dateCount: integer);
var
  s: string;
  RoomType: string;
  lstRoomTypes: TstringList;
  i, ii: integer;
  freeRooms: integer;
begin
  lstRoomTypes := TstringList.Create;
  try
    RoomTypes_CreateList(lstRoomTypes);
    DEL_RoomStatusAll();

    for ii := 0 to lstRoomTypes.Count - 1 do
    begin
      RoomType := lstRoomTypes[ii];
      freeRooms := oRoomTypeRoomCount.FindRoomTypeCount(RoomType, 0);
      lstRoomTypes[ii] := lstRoomTypes[ii] + '|' + inttostr(freeRooms);
    end;

    for i := 1 to dateCount do
    begin
      for ii := 0 to lstRoomTypes.Count - 1 do
      begin
        RoomType := _strTokenAt(lstRoomTypes[ii], '|', 0);
        freeRooms := 0;
        try
          freeRooms := strToInt(_strTokenAt(lstRoomTypes[ii], '|', 1));
        except
        end;
        if freeRooms = 0 then
          continue;

        s := '';
        s := s + 'Insert into [tblRoomStatus] ' + chr(10);
        s := s + '(' + chr(10);
        s := s + '  [resDate] ' + chr(10);
        s := s + ', [RoomType] ' + chr(10);
        s := s + ', [available] ' + chr(10);
        s := s + ' )' + chr(10);

        s := s + ' Values ' + chr(10);
        s := s + ' (' + chr(10);
        s := s + '  ' + _dateToDBdate(FromDate, true) + chr(10);
        s := s + ', ' + quotedstr(RoomType) + chr(10);
        s := s + ', ' + inttostr(freeRooms) + chr(10);
        s := s + ' )' + chr(10);
        cmd_bySQL(s);
      end;
      FromDate := FromDate + 1;
    end;
  finally
    lstRoomTypes.Free;
  end;
end;

function RoomStatus_updByRangeAndType(FromDate: Tdate; dateCount: integer; roomType1, roomType2: string): boolean;
var

  ToDate: Tdate;

  sFromDate: string;
  sToDate: string;

  i: integer;

  lstRoomTypes: TstringList;

  RoomType: string;
  freeRooms: integer;
begin
  lstRoomTypes := TstringList.Create;
  try
    RoomTypes_CreateList(lstRoomTypes);

    result := true;
    try

      // ATH777
      if FromDate < 30000 then
      begin
        FromDate := date;
      end;

      if dateCount = 0 then
      begin
        ToDate := RoomStatus_GetLastDate()
      end
      else
      begin
        ToDate := FromDate + dateCount;
      end;

      sFromDate := _dateToDBdate(FromDate, false);
      sToDate := _dateToDBdate(ToDate, false);

      for i := 0 to lstRoomTypes.Count - 1 do
      begin
        RoomType := lstRoomTypes[i];

        if (_trimlower(roomType1) = '') or (_trimlower(RoomType) = _trimlower(roomType1)) or (_trimlower(RoomType) = _trimlower(roomType2)) then
        begin
          freeRooms := oRoomTypeRoomCount.FindRoomTypeCount(RoomType, 0);
          if freeRooms > 0 then
          begin
            try
              SP_UPD_tblRoomStatusByDateRangeAndRoomType(RoomType, freeRooms, FromDate, ToDate);
            except
              result := false;
            end;
          end;
        end;
      end;
    Except
      raise;
    end;
  finally
    freeandnil(lstRoomTypes);
  end;
end;

// 120103 inDebug
function roomStatus_update(FromDate: Tdate; dateCount: integer; roomType1, roomType2: string; doRefresh: boolean; ProcName: string): integer;
var
  rSet: TRoomerDataSet;

  s: string;

  RoomType: string;

  ToDate: Tdate;

  sFromDate: string;
  sToDate: string;
  sDate: string;

  lstDates: TstringList;
  i: integer;

  aCount: integer;
  countProcessed: integer;

  freeRooms: integer;

  sql: string;

begin
  countProcessed := 0;
  result := 0;
  exit;

  // if FromDate < 30000 then
  // begin
  // FromDate := Date;
  // end;

  if dateCount = 0 then
  begin
    ToDate := RoomStatus_GetLastDate();
  end
  else
  begin
    ToDate := FromDate + dateCount;
  end;

  lstDates := TstringList.Create;
  try
    RoomStatus_updByRangeAndType(FromDate, dateCount, roomType1, roomType2);

    sFromDate := _dateToDBdate(FromDate, false);
    sToDate := _dateToDBdate(ToDate, false);

    rSet := CreateNewDataSet;
    try
      sql := ' SELECT distinct '#10 + '   ADate '#10 + ' FROM '#10 + '    roomsDate '#10 + ' WHERE '#10 + '   (ADate >= %s) AND (ADate < %s ) '#10 +
        '   AND (ResFlag <> ' + _db(STATUS_DELETED) + ' ) ' + // **zxhj line added
        ' ORDER BY ADate ';
      s := format(sql, [quotedstr(sFromDate), quotedstr(sToDate)]);
      if rSet_bySQL(rSet, s) then
      begin
        while not rSet.Eof do
        begin
          lstDates.Add(rSet.fieldbyname('aDate').asString);
          rSet.Next
        end;
      end;
    finally
      freeandnil(rSet);
    end;

    for i := 0 to lstDates.Count - 1 do
    begin
      sDate := lstDates[i];
      countProcessed := 0;
      rSet := CreateNewDataSet;
      try
        sql := '  SELECT '#10 + '      ADate '#10 + '    , RoomType '#10 + '    , COUNT(ResFlag) AS aCount '#10 + '  FROM '#10 + '     roomsDate '#10 +
          '  WHERE '#10 + '     (ResFlag <> ''D'') AND (ResFlag <> ''N'') '#10 + '  GROUP BY '#10 + '     ADate, RoomType '#10 + '  HAVING '#10 +
          '    (ADate = %s) ' + '   AND (ResFlag <> ' + _db(STATUS_DELETED) + ' ) '; // **zxhj line added

        s := format(sql, [_db(sDate)]);
        if hData.rSet_bySQL(rSet, s) then
        begin
          while not rSet.Eof do
          begin
            inc(countProcessed);
            RoomType := rSet.fieldbyname('RoomType').asString;
            aCount := rSet.fieldbyname('aCount').asInteger;

            if (_trimlower(roomType1) = '') or (_trimlower(RoomType) = _trimlower(roomType1)) or (_trimlower(RoomType) = _trimlower(roomType2)) then
            begin
              freeRooms := oRoomTypeRoomCount.FindRoomTypeCount(RoomType, 0);
              freeRooms := freeRooms - aCount;
              s := '';
              s := s + ' UPDATE tblroomstatus ' + chr(10);
              s := s + ' Set ' + chr(10);
              s := s + '  available =' + inttostr(freeRooms) + chr(10);
              s := s + ' WHERE (resdate = ' + quotedstr(sDate) + ') AND (RoomType=' + quotedstr(RoomType) + ' ) ' + chr(10);
              cmd_bySQL(s);
            end;
            rSet.Next
          end;
        end;
      finally
        freeandnil(rSet);
      end;
    end;
  finally
    lstDates.Free;
  end;
  result := countProcessed;
  if result > 0 then
  begin
    if doRefresh then
    begin
      frmdayNotes.RefreshRoomStatus;
    end;
  end;
end;

// function test;
// begin
// showmessage(inttostr(oRoomTypeRoomCount.RoomTypeCount));
// end;

function InvoiceExists(InvoiceNumber: integer): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+chr(10);
    // s := s + '   InvoiceNumber '+chr(10);
    // s := s + ' FROM InvoiceHeads '+chr(10);
    // s := s + ' WHERE InvoiceNumber = ' + inttostr(InvoiceNumber) + ' '+chr(10);
    s := format(select_InvoiceExists, [InvoiceNumber]);
    result := hData.rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function RV_SetNewID: integer;
begin
  result := d.roomerMainDataSet.SystemNewReservationId;
end;

function PE_SetNewID: integer;
begin
  result := d.roomerMainDataSet.SystemNewPersonId;
end;

function getNewInvoiceNumber(): integer;
var
  rSet: TRoomerDataSet;
begin
  Result := 0;
  d.roomerMainDataSet.SystemStartTransaction;
  try
    rSet := CreateNewDataSet;
    try
      if NOT hData.cmd_bySQL('UPDATE control SET lastInvoice=lastInvoice+1') then
        raise exception.Create('Error Unable to generate a new invoice number.');
      if hData.rSet_bySQL(rSet, 'SELECT lastInvoice FROM control LIMIT 1') then
        result := rSet['LastInvoice']
      else
        raise exception.Create('Error Unable to get the new invoice number.');
    finally
      freeandnil(rSet);
    end;
    d.roomerMainDataSet.SystemCommitTransaction;
  except
    d.roomerMainDataSet.SystemRollbackTransaction;
    raise;
  end;
end;

function IVH_SetNewID: integer;

  function getIT: integer;
  begin
    result := getNewInvoiceNumber();
  end;

var
  id, iCount: integer;
begin

  iCount := 0;
  repeat
    id := getIT;
    if id <> -1 then
    begin
      if InvoiceExists(id) then
      begin
        id := -1;
      end;
    end;
    if id = -1 then
      sleep(1000);
  until (id <> -1) OR (iCount > 5);

  result := id;
end;

function IVH_GetLastID: integer;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    // s := s + 'SELECT LastInvoice FROM [Control]';
    s := format(select_IVH_GetLastID, []);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.fieldbyname('LastInvoice').asInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function IVH_RestoreID: integer;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := -1;
  rSet := CreateNewDataSet;
  try
    // s := s + 'SELECT LastInvoice FROM [Control]';
    s := format(select_IVH_RestoreID, []);
    if hData.rSet_bySQL(rSet, s) then
    begin
      rSet.edit;
      rSet.fieldbyname('LastInvoice').asInteger := rSet.fieldbyname('LastInvoice').asInteger - 1;
      rSet.Post;
      result := rSet.fieldbyname('LastInvoice').asInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function RV_GetLastID: integer;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := -1;
  rSet := CreateNewDataSet;
  try
    // s := s + 'SELECT LastReservation FROM [Control]';
    s := format(select_RV_GetLastID, []);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.fieldbyname('LastReservation').asInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function RR_SetNewID: integer;
// var
// Rset : TRoomerDataSet;
// s : string;
begin
  result := d.roomerMainDataSet.SystemNewRoomReservationId;
  // result := - 1;
  // RSet := CreateNewDataSet;
  // try
  /// /      s := s + 'SELECT LastRoomRes FROM [Control] ';
  // s := format(select_RR_SetNewID, []);
  // if hData.rSet_bySQL(rSet,s, Connection,LogLevel,logPath) then
  // begin
  // Rset.edit;
  // Rset.fieldbyname('LastRoomRes').asInteger := Rset.fieldbyname('LastRoomRes').asInteger + 1;
  // Rset.Post;
  // result := Rset.fieldbyname('LastRoomRes').asInteger;
  // end;
  // finally
  // freeandnil(Rset);
  // end;
end;

function RR_GetIDs(Count: integer): string;
// var
// Rset : TRoomerDataSet;
// s : string;
// i : integer;
// Lastid : integer;
begin
  result := StringReplace(d.roomerMainDataSet.SystemMultipleNewRoomReservationIds(Count), ',', '|', [rfReplaceAll, rfIgnoreCase]);
  // RSet := CreateNewDataSet;
  // try
  // s := 'SELECT LastRoomRes,ID FROM [control] ';
  // if hData.rSet_bySQL(rSet,s) then
  // begin
  // lastId := Rset.fieldbyname('LastRoomRes').asInteger;
  // result := '';
  // for I := 1 to count do
  // begin
  // lastID := lastID+1;
  // result := result+inttostr(LastId)+'|'
  // end;
  // if length(result) > 0 then delete(result,length(result),1);
  // Rset.edit;
  // Rset.fieldbyname('LastRoomRes').asInteger := LastID;
  // Rset.Post;
  // end;
  // finally
  // freeandnil(Rset);
  // end;
end;

function Persons_GetIDs(Count: integer): string;
// var
// Rset : TRoomerDataSet;
// s : string;
// i : integer;
// Lastid : integer;
begin
  result := StringReplace(d.roomerMainDataSet.SystemMultipleNewPersonIds(Count), ',', '|', [rfReplaceAll, rfIgnoreCase]);
  // result := '';
  // for I := 1 to count do
  // begin
  // result := result+inttostr(d.roomerMainDataSet.SystemNewPersonId)+'|'
  // end;
  // if length(result) > 0 then delete(result,length(result),1);

  // result := '';
  // RSet := CreateNewDataSet;
  // try
  // s := 'SELECT LastPerson,ID FROM [control] ';
  // if hData.rSet_bySQL(rSet,s) then
  // begin
  // lastId := Rset.fieldbyname('LastPerson').asInteger;
  // result := '';
  // for I := 1 to count do
  // begin
  // lastID := lastID+1;
  // result := result+inttostr(LastId)+'|'
  // end;
  // if length(result) > 0 then delete(result,length(result),1);
  // Rset.edit;
  // Rset.fieldbyname('LastPerson').asInteger := LastID;
  // Rset.Post;
  // end;
  // finally
  // freeandnil(Rset);
  // end;
end;

function GET_RoomsType_byRoom(sRoom: string): string;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := '';
  // s := s + 'SELECT RoomType '+chr(10);
  // s := s + 'FROM Rooms  '+chr(10);
  // s := s + 'WHERE  '+chr(10);
  // s := s + '(Room =' + quotedstr(sRoom) + ') ';

  rSet := CreateNewDataSet;
  try
    s := format(select_GET_RoomsType_byRoom, [quotedstr(sRoom)]);
    if rSet_bySQL(rSet, s) then
    begin
      result := trim(rSet.fieldbyname('RoomType').asString);
    end;
  finally
    freeandnil(rSet);
  end;
end;

function GET_useInNationalReport_byRoom(sRoom: string): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := true;
  // s := s + 'SELECT useInNationalReport '+chr(10);
  // s := s + 'FROM Rooms  '+chr(10);
  // s := s + 'WHERE  '+chr(10);
  // s := s + '(Room =' + quotedstr(sRoom) + ') '+chr(10);

  rSet := CreateNewDataSet;
  try
    s := format(select_GET_useInNationalReport_byRoom, [quotedstr(sRoom)]);
    if rSet_bySQL(rSet, s) then
    begin
      result := rSet['useInNationalReport'];
    end;
  finally
    freeandnil(rSet);
  end;
end;

function GET_NumberOfGuestsbyRoom(sRoom: string): integer;
var
  RoomType: string;
begin
  result := 0;
  if glb.RoomsSet.Locate('room', sRoom, []) then
  begin
    RoomType := glb.RoomsSet.fieldbyname('roomtype').asString;

    if glb.RoomTypesSet.Locate('roomtype', RoomType, []) then
    begin
      result := glb.RoomTypesSet.fieldbyname('NumberGuests').asInteger;
    end;
  end;

  /// /    s := s + ' SELECT '+chr(10);
  /// /    s := s + '   Rooms.Room '+chr(10);
  /// /    s := s + ' , RoomTypes.RoomType '+chr(10);
  /// /    s := s + ' , RoomTypes.NumberGuests '+chr(10);
  /// /    s := s + ' FROM '+chr(10);
  /// /    s := s + '   Rooms LEFT OUTER JOIN '+chr(10);
  /// /    s := s + '   RoomTypes ON Rooms.RoomType = RoomTypes.RoomType '+chr(10);
  /// /    s := s + ' WHERE '+chr(10);
  /// /    s := s + '(Room =' + quotedstr(sRoom) + ') '+chr(10);
  //
  // RSet := CreateNewDataSet;
  // try
  // s := format(select_GET_NumberOfGuestsbyRoom, [quotedstr(sRoom)]);
  // if rSet_bySQL(rSet,s, Connection,loglevel,logpath) then
  // begin
  // result := rSet.fieldbyname('NumberGuests').asInteger;
  // end;
  // finally
  // freeandnil(rSet);
  // end;
end;

function GetPriceType(RoomType: string): string;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := '';

  // s := s + ' SELECT '+chr(10);
  // s := s + '   PriceType '+chr(10);
  // s := s + ' FROM '+chr(10);
  // s := s + '   Roomtypes '+chr(10);
  // s := s + ' WHERE '+chr(10);
  // s := s + '  RoomType =' + quotedstr(RoomType) + ' '+chr(10);
  rSet := CreateNewDataSet;
  try
    s := format(select_GetPriceType, [quotedstr(RoomType)]);
    if rSet_bySQL(rSet, s) then
    begin
      result := trim(rSet.fieldbyname('PriceType').asString);
    end;
  finally
    freeandnil(rSet);
  end;

end;

function RE_GetFirstAndLastDate(iReservation: integer; var FirstDate, LastDate: Tdate): integer;
var
  rSet: TRoomerDataSet;
  s: string;

  dateCount: integer;
  sFirstDate: string;
  sLastdate: string;
  sql: string;

begin
  result := 0;
  exit;

  // start := GetTickCount;
  FirstDate := 1;
  LastDate := 1;

  result := 0;

  rSet := CreateNewDataSet;
  try

    sql := ' SELECT '#10 + '    Adate '#10 + ' FROM '#10 + '    roomsDate '#10 + ' WHERE (reservation = %d) '#10 + '   AND (ResFlag <> ' + _db(STATUS_DELETED) +
      ' ) ' + // **zxhj bætti við
      ' Order BY ADATE ';
    s := format(sql, [iReservation]);
    if rSet_bySQL(rSet, s) then
    begin
      sFirstDate := rSet.fieldbyname('Adate').asString;
      FirstDate := _DBDateToDate(sFirstDate);

      rSet.last;
      if not rSet.bof then
      begin
        sLastdate := rSet.fieldbyname('Adate').asString;
        LastDate := _DBDateToDate(sLastdate);
      end;
      dateCount := trunc(LastDate) - trunc(FirstDate);
      result := dateCount + 1;
    end;
  finally
    freeandnil(rSet);
  end;
end;

// added 2013-02-28 HJ
procedure initRateRuleHolder(var rec: recRateRuleHolder);
begin
  with rec do
  begin
    // ID                : integer;
    Description := '';
    active := true;
    ApplyToDates := '';
    ApplyToSeasons := '';
    ApplyToRoomTypes := '';
    ApplyToRoomGroups := '';
    ApplyToRooms := '';
    Rules := '';
  end;
end;

function Del_RateRule(theData: recRateRuleHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM pricerules ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function UPD_rateRule(theData: recRateRuleHolder): boolean;
var
  s: string;
begin
  // if theData.tmp = '' then thedata.tmp := theData.PayType;
  s := '';
  s := s + ' UPDATE pricerules ' + #10;
  s := s + ' SET ' + #10;
  s := s + '     Description       = ' + _db(theData.Description) + ' ' + #10;
  s := s + '   , Active            =' + _db(theData.active) + ' ' + #10;
  s := s + '   , ApplyToDates      =' + _db(theData.ApplyToDates) + ' ' + #10;
  s := s + '   , ApplyToSeasons    =' + _db(theData.ApplyToSeasons) + ' ' + #10;
  s := s + '   , ApplyToRoomTypes  =' + _db(theData.ApplyToRoomTypes) + ' ' + #10;
  s := s + '   , ApplyToRoomGroups =' + _db(theData.ApplyToRoomGroups) + ' ' + #10;
  s := s + '   , ApplyToRooms      =' + _db(theData.ApplyToRooms) + ' ' + #10;
  s := s + '   , Rules             =' + _db(theData.Rules) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function INS_RateRule(theData: recRateRuleHolder; var NewID: integer): boolean;
var
  s: string;
begin

  s := '';
  s := s + 'INSERT INTO pricerules ' + #10;
  s := s + '   ( ' + #10;
  s := s + '    Description        ' + #10;
  s := s + '  , Active             ' + #10;
  s := s + '  , ApplyToDates       ' + #10;
  s := s + '  , ApplyToSeasons     ' + #10;
  s := s + '  , ApplyToRoomTypes   ' + #10;
  s := s + '  , ApplyToRoomGroups  ' + #10;
  s := s + '  , ApplyToRooms       ' + #10;
  s := s + '  , Rules              ' + #10;
  s := s + '   ) ' + #10;
  s := s + '    VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '    ' + _db(theData.Description) + ' ' + #10;
  s := s + '   ,' + _db(theData.active) + ' ' + #10;
  s := s + '   ,' + _db(theData.ApplyToDates) + ' ' + #10;
  s := s + '   ,' + _db(theData.ApplyToSeasons) + ' ' + #10;
  s := s + '   ,' + _db(theData.ApplyToRoomTypes) + ' ' + #10;
  s := s + '   ,' + _db(theData.ApplyToRoomGroups) + ' ' + #10;
  s := s + '   ,' + _db(theData.ApplyToRooms) + ' ' + #10;
  s := s + '   ,' + _db(theData.Rules) + ' ' + #10;
  s := s + '   )';
  result := cmd_bySQL(s);

  if result then
  begin
    NewID := GetLastID('pricerules');
  end;

end;

function rateRuleDescriptionExist(sDescription: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  s := '';
  s := s + ' SELECT ' + chr(10);
  s := s + '   Description ' + chr(10);
  s := s + ' FROM ' + chr(10);
  s := s + '   pricerules ' + chr(10);
  s := s + ' WHERE ' + chr(10);
  s := s + '   Description = %s ';
  rSet := CreateNewDataSet;
  try
    s := format(s, [_db(sDescription)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

/// ///////////////////////////////////////////////////////////////////////////////////
//
// Taxes
//
/// ///////////////////////////////////////////////////////////////////////////////////

procedure initTaxesHolder(var rec: recTaxesHolder);
begin
  with rec do
  begin
    id := 0;
    Description := '';
    Hotel_Id := d.roomerMainDataSet.hotelId;
    Tax_Type := 'FIXED_AMOUNT';
    Tax_Base := 'ROOM_NIGHT';
    Time_Due := 'CHECKOUT';
    ReTaxable := 'FALSE';
    TaxChildren := 'FALSE';
    Booking_Item := '';
    Incl_Excl := 'EXCLUDED';
    NETTO_AMOUNT_BASED := 'TRUE';
    Amount := 0;
    VALUE_FORMULA := '';
    VALID_FROM := 0;
    VALID_TO := now + (10 * 365);
  end;
end;


function GetTaxesHolder : recTaxesHolder;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  initTaxesHolder(result);
  s :=
  ' SELECT '#10+
  '   ID '#10+
  '  ,Hotel_Id '#10+
  '  ,Description '#10+
  '  ,Tax_Type '#10+
  '  ,Tax_Base '#10+
  '  ,Time_Due '#10+
  '  ,Retaxable '#10+
  '  ,TaxChildren '#10+
  '  ,Amount '#10+
  '  ,Booking_Item_Id '#10+
  '  ,(SELECT Item FROM items WHERE id=Booking_Item_Id) AS Booking_Item '#10+
  '  ,INCL_EXCL '#10+
  '  ,NETTO_AMOUNT_BASED '#10+
  '  ,VALUE_FORMULA '#10 +
  '  ,VALID_FROM '#10 +
  '  ,VALID_TO '#10 +
  '  ,ROUND_VALUE '#10 +
  ' FROM '#10+
  '   home100.TAXES '#10+
  ' WHERE '#10+
  '    (HOTEL_ID='+_db(d.roomerMainDataSet.hotelId)+') and (Valid_from <= CURDATE() and Valid_to >= CURDATE()) ';

//  copytoclipboard(s);
//  debugmessage(s);

  rSet := CreateNewDataSet;
  try
    if rSet_bySQL(rSet, s, false) then
    begin
      result.id                 := Rset['id'];
      result.Description        := Rset['Description']; //
      result.Hotel_Id           := d.roomerMainDataSet.hotelId;
      result.Tax_Type           := Rset['Hotel_Id'];    //'FIXED_AMOUNT';
      result.Tax_Base           := Rset['Tax_Base'];    //'ROOM_NIGHT';
      result.Time_Due           := Rset['Time_Due'];    //'CHECKOUT';
      result.ReTaxable          := Rset['ReTaxable'];   //'FALSE';
      result.TaxChildren        := RSet['TaxChildren'];
      result.Booking_Item       := Rset['Booking_Item']; //'';
      result.Incl_Excl          := Rset['Incl_Excl'];   //'EXCLUDED';
      result.NETTO_AMOUNT_BASED := Rset['NETTO_AMOUNT_BASED']; //'TRUE';
      result.VALUE_FORMULA      := Rset['VALUE_FORMULA']; //'';
      result.VALID_FROM         := Rset['VALID_FROM'];
      result.VALID_TO           := Rset['VALID_TO'];
      result.Amount             := Rset['Amount'];

    end;
  finally
    freeandnil(rSet);
  end;
end;

function Del_Taxes(theData: recTaxesHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM home100.TAXES ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function UPD_Taxes(theData: recTaxesHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE home100.TAXES ' + #10;
  s := s + ' SET ' + #10;
  s := s + '     DESCRIPTION =' + _db(theData.Description) + ' ' + #10;
  s := s + '   , HOTEL_ID =' + _db(theData.Hotel_Id) + ' ' + #10;
  s := s + '   , TAX_TYPE =' + _db(theData.Tax_Type) + ' ' + #10;
  s := s + '   , TAX_BASE =' + _db(theData.Tax_Base) + ' ' + #10;
  s := s + '   , TIME_DUE =' + _db(theData.Time_Due) + ' ' + #10;
  s := s + '   , RETAXABLE =' + _db(theData.ReTaxable) + ' ' + #10;
  s := s + '   , TAXCHILDREN =' + _db(theData.TaxChildren) + ' ' + #10;
  s := s + '   , AMOUNT =' + _db(theData.Amount) + ' ' + #10;
  s := s + '   , BOOKING_ITEM_ID =(SELECT id FROM home100_' + LowerCase(theData.Hotel_Id) + '.items WHERE Item=' + _db(theData.Booking_Item) +
    ' LIMIT 1) ' + #10;
  s := s + '   , INCL_EXCL =' + _db(theData.Incl_Excl) + ' ' + #10;
  s := s + '   , NETTO_AMOUNT_BASED =' + _db(theData.NETTO_AMOUNT_BASED);
  s := s + '   , VALUE_FORMULA =' + _db(theData.VALUE_FORMULA) + ' ' + #10;
  s := s + '   , VALID_FROM =' + _db(theData.VALID_FROM) + ' ' + #10;
  s := s + '   , VALID_TO =' + _db(theData.VALID_TO) + ' ' + #10;

  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(theData.id) + ') ';
  result := cmd_bySQL(s, false);
end;

function INS_Taxes(theData: recTaxesHolder; var NewID: integer): boolean;
var
  s: string;
begin

  s := '';
  s := s + 'INSERT INTO home100.TAXES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '    HOTEL_ID ' + #10;
  s := s + '  , DESCRIPTION ' + #10;
  s := s + '  , AMOUNT ' + #10;
  s := s + '  , TAX_TYPE ' + #10;
  s := s + '  , TAX_BASE ' + #10;
  s := s + '  , TIME_DUE ' + #10;
  s := s + '  , RETAXABLE ' + #10;
  s := s + '  , TAXCHILDREN' + #10;
  s := s + '  , BOOKING_ITEM_ID ' + #10;
  s := s + '  , INCL_EXCL ' + #10;
  s := s + '  , NETTO_AMOUNT_BASED ' + #10;
  s := s + '  , VALUE_FORMULA ' + #10;
  s := s + '  , VALID_FROM ' + #10;
  s := s + '  , VALID_TO ' + #10;


  s := s + '   ) ' + #10;
  s := s + '    VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '    ' + _db(theData.Hotel_Id) + ' ' + #10;
  s := s + '   ,' + _db(theData.Description) + ' ' + #10;
  s := s + '   ,' + _db(theData.Amount) + ' ' + #10;
  s := s + '   ,' + _db(theData.Tax_Type) + ' ' + #10;
  s := s + '   ,' + _db(theData.Tax_Base) + ' ' + #10;
  s := s + '   ,' + _db(theData.Time_Due) + ' ' + #10;
  s := s + '   ,' + _db(theData.ReTaxable) + ' ' + #10;
  s := s + '   ,' + _db(theData.TaxChildren) + ' ' + #10;
  s := s + '   ,(SELECT id FROM home100_' + LowerCase(theData.Hotel_Id) + '.items WHERE Item=' + _db(theData.Booking_Item) + ' LIMIT 1) ' + #10;
  s := s + '   ,' + _db(theData.Incl_Excl) + ' ' + #10;
  s := s + '   ,' + _db(theData.NETTO_AMOUNT_BASED) + ' ' + #10;
  s := s + '   ,' + _db(theData.VALUE_FORMULA) + ' ' + #10;
  s := s + '   ,' + _db(theData.VALID_FROM) + ' ' + #10;
  s := s + '   ,' + _db(theData.VALID_TO) + ' ' + #10;


  s := s + '   )';
  result := cmd_bySQL(s, false);
  if result then
  begin
    NewID := GetLastID('home100.TAXES', false);
  end;
end;




/// ///////////////////////////////////////////////////////////////////////////////////
//
// RoomRate
//
/// ///////////////////////////////////////////////////////////////////////////////////




// SELECT
// `ID`,
// `PriceCodeID`,
// `pcCode`,
// `pcRack`,
// `CurrencyID`,
// `Currency`,
// `SeasonID`,
// `seStartDate`,
// `seEndDate`,
// `seDescription`,
// `RoomTypeID`,
// `RoomType`,
// `NumberGuests`,
// `RateID`,
// `RateCurrency`,
// `Rate1Person`,
// `Rate2Persons`,
// `Rate3Persons`,
// `Rate4Persons`,
// `Rate5Persons`,
// `Rate6Persons`,
// `RateExtraPerson`,
// `RateExtraChildren`,
// `RateExtraInfant`,
// `rateDescription`,
// `Active`,
// `DateFrom`,
// `DateTo`,
// `Description`,
// `DateCreated`,
// `LastModified`
// FROM
// `wroomrates`;

procedure initwRoomRateHolder(var rec: recwRoomRateHolder);
begin
  with rec do
  begin
    // ID              : integer;
    id := 0;
    priceCodeID := 0;
    pcCode := '';
    pcRack := false;
    CurrencyID := 0;
    Currency := '';
    seasonId := 0;
    seStartDate := now;
    seEndDate := now;
    seDescription := '';
    RoomTypeID := 0;
    RoomType := '';
    NumberGuests := 0;
    RateID := 0;
    RateCurrency := '';
    Rate1Person := 0;
    Rate2Persons := 0;
    Rate3Persons := 0;
    Rate4Persons := 0;
    Rate5Persons := 0;
    Rate6Persons := 0;
    RateExtraPerson := 0;
    RateExtraChildren := 0;
    RateExtraInfant := 0;
    Description := '';
    DateCreated := now;
    LastModified := now;
    active := true;
    DateFrom := now;
    DateTo := now;
  end;
end;

procedure initRoomRateHolder(var rec: recRoomRateHolder);
begin
  with rec do
  begin
    // ID              : integer;
    priceCodeID := 0;
    RateID := 0;
    seasonId := 0;
    RoomTypeID := 0;
    CurrencyID := 0;
    active := true;
    DateFrom := now;
    DateTo := now;
    Description := '';
    DateCreated := now;
    LastModified := now;
  end;
end;

function Del_RoomRate(theData: recwRoomRateHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM roomrates ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function UPD_RoomRate(theData: recwRoomRateHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE roomrates ' + #10;
  s := s + ' SET ' + #10;
  s := s + '    PriceCodeID    = ' + _db(theData.priceCodeID) + ' ' + #10;
  s := s + '   ,RateID         =' + _db(theData.RateID) + ' ' + #10;
  s := s + '   ,SeasonID       =' + _db(theData.seasonId) + ' ' + #10;
  s := s + '   ,RoomTypeID     =' + _db(theData.RoomTypeID) + ' ' + #10;
  s := s + '   ,CurrencyID     =' + _db(theData.CurrencyID) + ' ' + #10;
  s := s + '   ,Active         =' + _db(theData.active) + ' ' + #10;
  s := s + '   ,DateFrom       =' + _db(theData.DateFrom) + ' ' + #10;
  s := s + '   ,DateTo         =' + _db(theData.DateTo) + ' ' + #10;
  s := s + '   ,Description    =' + _db(theData.Description) + ' ' + #10;
  s := s + '   ,LastModified   =' + _db(now) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function INS_RoomRate(theData: recwRoomRateHolder; var NewID: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'INSERT INTO roomrates ' + #10;
  s := s + '   ( ' + #10;
  s := s + '   PriceCodeID  ' + #10;
  s := s + '  ,RateID       ' + #10;
  s := s + '  ,SeasonID     ' + #10;
  s := s + '  ,RoomTypeID   ' + #10;
  s := s + '  ,CurrencyID   ' + #10;
  s := s + '  ,Active       ' + #10;
  s := s + '  ,DateFrom     ' + #10;
  s := s + '  ,DateTo       ' + #10;
  s := s + '  ,Description  ' + #10;
  s := s + '  ,DateCreated   ' + #10;
  s := s + '  ,LastModified  ' + #10;
  s := s + '   ) ' + #10;
  s := s + '    VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '    ' + _db(theData.priceCodeID) + ' ' + #10;
  s := s + '   ,' + _db(theData.RateID) + ' ' + #10;
  s := s + '   ,' + _db(theData.seasonId) + ' ' + #10;
  s := s + '   ,' + _db(theData.RoomTypeID) + ' ' + #10;
  s := s + '   ,' + _db(theData.CurrencyID) + ' ' + #10;
  s := s + '   ,' + _db(theData.active) + ' ' + #10;
  s := s + '   ,' + _db(theData.DateFrom) + ' ' + #10;
  s := s + '   ,' + _db(theData.DateTo) + ' ' + #10;
  s := s + '   ,' + _db(theData.Description) + ' ' + #10;
  s := s + '   ,' + _db(now) + ' ' + #10;
  s := s + '   ,' + _db(now) + ' ' + #10;
  s := s + '   )';
  result := cmd_bySQL(s);
  if result then
  begin
    NewID := GetLastID('roomrates');
  end;

end;

function RoomRateDescriptionExist(sDescription: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  s := '';
  s := s + ' SELECT ' + chr(10);
  s := s + '   Description ' + chr(10);
  s := s + ' FROM ' + chr(10);
  s := s + '   roomrates ' + chr(10);
  s := s + ' WHERE ' + chr(10);
  s := s + '   Description = %s ';
  rSet := CreateNewDataSet;
  try
    s := format(s, [_db(sDescription)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

/// ///////////////////////////////////////////////////////////////////////////////////
//
// Rate
//
/// ///////////////////////////////////////////////////////////////////////////////////

procedure initRateHolder(var rec: recRateHolder);
begin
  with rec do
  begin
    active := true;
    Currency := '';
    Description := '';
    Rate1Person := 0;
    Rate2Persons := 0;
    Rate3Persons := 0;
    Rate4Persons := 0;
    Rate5Persons := 0;
    Rate6Persons := 0;
    RateExtraPerson := 0;
    RateExtraChildren := 0;
    RateExtraInfant := 0;
    isDefault := false;
  end;
end;

function Del_Rate(theData: recRateHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM rates ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function UPD_Rate(theData: recRateHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE rates ' + #10;
  s := s + ' SET ' + #10;
  s := s + '    Active              = ' + _db(theData.active) + ' ' + #10;
  s := s + '   ,Currency            =' + _db(theData.Currency) + ' ' + #10;
  s := s + '   ,Description         =' + _db(theData.Description) + ' ' + #10;
  s := s + '   ,Rate1Person         =' + _db(theData.Rate1Person) + ' ' + #10;
  s := s + '   ,Rate2Persons        =' + _db(theData.Rate2Persons) + ' ' + #10;
  s := s + '   ,Rate3Persons        =' + _db(theData.Rate3Persons) + ' ' + #10;
  s := s + '   ,Rate4Persons        =' + _db(theData.Rate4Persons) + ' ' + #10;
  s := s + '   ,Rate5Persons        =' + _db(theData.Rate5Persons) + ' ' + #10;
  s := s + '   ,Rate6Persons        =' + _db(theData.Rate6Persons) + ' ' + #10;
  s := s + '   ,RateExtraPerson     =' + _db(theData.RateExtraPerson) + ' ' + #10;
  s := s + '   ,RateExtraChildren   =' + _db(theData.RateExtraChildren) + ' ' + #10;
  s := s + '   ,RateExtraInfant     =' + _db(theData.RateExtraInfant) + ' ' + #10;
  s := s + '   ,isDefault           =' + _db(theData.isDefault) + ' ' + #10;
  s := s + '   ,LastModified        =' + _db(now) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function INS_Rate(theData: recRateHolder; var NewID: integer): boolean;
var
  s: string;
begin

  s := '';
  s := s + 'INSERT INTO rates ' + #10;
  s := s + '   ( ' + #10;
  s := s + '   Active ' + #10;
  s := s + '  ,Currency ' + #10;
  s := s + '  ,Description ' + #10;
  s := s + '  ,Rate1Person ' + #10;
  s := s + '  ,Rate2Persons ' + #10;
  s := s + '  ,Rate3Persons ' + #10;
  s := s + '  ,Rate4Persons ' + #10;
  s := s + '  ,Rate5Persons ' + #10;
  s := s + '  ,Rate6Persons ' + #10;
  s := s + '  ,RateExtraPerson ' + #10;
  s := s + '  ,RateExtraChildren ' + #10;
  s := s + '  ,RateExtraInfant ' + #10;
  s := s + '  ,isDefault ' + #10;
  s := s + '  ,DateCreated ' + #10;
  s := s + '  ,LastModified ' + #10;
  s := s + '   ) ' + #10;
  s := s + '    VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '    ' + _db(theData.active) + ' ' + #10;
  s := s + '   ,' + _db(theData.Currency) + ' ' + #10;
  s := s + '   ,' + _db(theData.Description) + ' ' + #10;
  s := s + '   ,' + _db(theData.Rate1Person) + ' ' + #10;
  s := s + '   ,' + _db(theData.Rate2Persons) + ' ' + #10;
  s := s + '   ,' + _db(theData.Rate3Persons) + ' ' + #10;
  s := s + '   ,' + _db(theData.Rate4Persons) + ' ' + #10;
  s := s + '   ,' + _db(theData.Rate5Persons) + ' ' + #10;
  s := s + '   ,' + _db(theData.Rate6Persons) + ' ' + #10;
  s := s + '   ,' + _db(theData.RateExtraPerson) + ' ' + #10;
  s := s + '   ,' + _db(theData.RateExtraChildren) + ' ' + #10;
  s := s + '   ,' + _db(theData.RateExtraInfant) + ' ' + #10;
  s := s + '   ,' + _db(theData.isDefault) + ' ' + #10;
  s := s + '   ,' + _db(now) + ' ' + #10;
  s := s + '   ,' + _db(now) + ' ' + #10;
  s := s + '   )';
  result := cmd_bySQL(s);
  if result then
  begin
    NewID := GetLastID('rates');
  end;

end;

function rateDescriptionExist(sDescription: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  s := '';
  s := s + ' SELECT ' + chr(10);
  s := s + '   Description ' + chr(10);
  s := s + ' FROM ' + chr(10);
  s := s + '   rates ' + chr(10);
  s := s + ' WHERE ' + chr(10);
  s := s + '   Description = %s ';
  rSet := CreateNewDataSet;
  try
    s := format(s, [_db(sDescription)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function rateDefaultExist(sCurrency: string; bDefault: boolean): boolean;
var
  s: string;
  rSet: TRoomerDataSet;

begin
  s := '';
  s := s + ' SELECT ' + chr(10);
  s := s + '   Currency ' + chr(10);
  s := s + '   ,isDefault ' + chr(10);
  s := s + ' FROM ' + chr(10);
  s := s + '   rates ' + chr(10);
  s := s + ' WHERE ' + chr(10);
  s := s + '  (currency = ' + _db(sCurrency) + ') and (isDefault = ' + _db(bDefault) + ') ';

  rSet := CreateNewDataSet;
  try
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function getNativeCurrencyID: integer;
var
  curr: string;
  s: string;
  rSet: TRoomerDataSet;
begin
  result := 0;
  curr := ctrlGetString('NativeCurrency');
  s := '';
  s := s + ' Select ';
  s := s + '  ID ';
  s := s + ' FROM ';
  s := s + '  currencies ';
  s := s + ' WHERE ';
  s := s + '  currency = ' + _db(curr) + ' ';

  rSet := CreateNewDataSet;
  try
    if rSet_bySQL(rSet, s) then
    begin
      result := rSet.fieldbyname('ID').asInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

/// //////////////////////////////////////////////////////////////////
//
// RoomType
/// /////////////////////////////////////////////////////////////////

const TABLES_WITH_ROOMTYPE_CODE : Array [0..11] of String =
    ('cancellationdetails,RoomType',
     'personprofiles,RoomType',
     'roomreservations,RoomType',
     'rooms,RoomType',
     'roomsdate,RoomType',
     'roomsdatetemp,RoomType',
     'roomtyperules,RoomType',
     'roomtypes,RoomType',
     'tbldelroomreservations,RoomType',
     'tblmaidlists,RoomType',
     'tblroomstatus,RoomType',
     'ttmp,RoomType');

procedure UpdateRoomTypeCode(oldCode, newCode : String);
begin
  UpdateCodeOfTable(TABLES_WITH_ROOMTYPE_CODE, oldCode, newCode)
end;

procedure initRoomTypeHolder(var rec: recRoomTypeHolder);
begin
  with rec do
  begin
    /// /  ID                : integer;
    active := true;
    RoomType := '';
    Description := '';
    NumberGuests := 0;
    PriceType := ''; // outdated field
    Webable := true;
    RoomTypeGroup := '';
    color := '';
    PriorityRule := '';
    Roomtype := '';
  end;
end;

function Del_roomType(theData: recRoomTypeHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM roomtypes ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function UPD_roomType(theData: recRoomTypeHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE roomtypes ' + #10;
  s := s + ' SET ' + #10;
  s := s + '    Active = ' + _db(theData.active) + ' ' + #10;
  s := s + '   ,RoomType =' + _db(theData.RoomType) + ' ' + #10;
  s := s + '   ,Description =' + _db(theData.Description) + ' ' + #10;
  s := s + '   ,NumberGuests =' + _db(theData.NumberGuests) + ' ' + #10;
  s := s + '   ,PriceType =' + _db(theData.PriceType) + ' ' + #10;
  s := s + '   ,Webable =' + _db(theData.Webable) + ' ' + #10;
  s := s + '   ,RoomTypeGroup =' + _db(theData.RoomTypeGroup) + ' ' + #10;
  s := s + '   ,color =' + _db(theData.color) + ' ' + #10;
  s := s + '   ,PriorityRule =' + _db(theData.PriorityRule) + ' ' + #10;
  s := s + '   ,location =' + _db(theData.location) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function INS_roomType(theData: recRoomTypeHolder; var NewID: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'INSERT INTO roomtypes ' + #10;
  s := s + '   ( ' + #10;
  s := s + '   Active ' + #10;
  s := s + '  ,RoomType ' + #10;
  s := s + '  ,Description ' + #10;
  s := s + '  ,NumberGuests ' + #10;
  s := s + '  ,PriceType ' + #10;
  s := s + '  ,Webable ' + #10;
  s := s + '  ,RoomTypeGroup ' + #10;
  s := s + '  ,color ' + #10;
  s := s + '  ,PriorityRule ' + #10;
  s := s + '  ,location ' + #10;
  s := s + '   ) ' + #10;
  s := s + '    VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '    ' + _db(theData.active) + ' ' + #10;
  s := s + '   ,' + _db(theData.RoomType) + ' ' + #10;
  s := s + '   ,' + _db(theData.Description) + ' ' + #10;
  s := s + '   ,' + _db(theData.NumberGuests) + ' ' + #10;
  s := s + '   ,' + _db(theData.PriceType) + ' ' + #10;
  s := s + '   ,' + _db(theData.Webable) + ' ' + #10;
  s := s + '   ,' + _db(theData.RoomTypeGroup) + ' ' + #10;
  s := s + '   ,' + _db(theData.color) + ' ' + #10;
  s := s + '   ,' + _db(theData.PriorityRule) + ' ' + #10;
  s := s + '   ,' + _db(theData.location) + ' ' + #10;
  s := s + '   )';
  result := cmd_bySQL(s);
  if result then
  begin
    NewID := GetLastID('roomtypes');
  end;

end;

function roomTypeExist(sRoomType: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  s := '';
  s := s + ' SELECT ' + chr(10);
  s := s + '   RoomType ' + chr(10);
  s := s + ' FROM ' + chr(10);
  s := s + '   RoomTypes ' + chr(10);
  s := s + ' WHERE ' + chr(10);
  s := s + '   RoomType = %s ';
  rSet := CreateNewDataSet;
  try
    s := format(s, [_db(sRoomType)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function RoomTypeExistsInOther(sRoomType: string; id: integer): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
  sql: string;
begin
  result := true;
  rSet := CreateNewDataSet;
  try
    s := format(select_RoomTypeExistsInRooms, [_db(sRoomType)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      exit;
    end;

    s := format(select_RoomTypeExistsInRoomRates, [id]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      exit;
    end;

    sql := ' SELECT RoomType FROM roomsdate ' + ' WHERE (RoomType = %s ) ' + '   AND (ResFlag <> ' + _db(STATUS_DELETED) + ' ) '; // **zxhj bætti við
    s := format(sql, [_db(sRoomType)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      exit;
    end;
  finally
    freeandnil(rSet);
  end;
  result := false;
end;

/// //////////////////////////////////////////////////////////////////
//
// RoomTypeGroup
/// /////////////////////////////////////////////////////////////////

procedure SetRoomTypeGroupDity(Code : String);
var s : String;
begin
  s := format('UPDATE channelrates cr ' +
              'SET availabilityDirty=1 ' +
              'WHERE date>=CURRENT_DATE ' +
              'AND roomClassId IN ' +
              '  (SELECT id FROM roomtypegroups WHERE Code=%s OR TopClass=%s)',
              [_db(Code),
               _db(Code)]);
  d.roomerMainDataSet.DoCommand(s);

  s := format('UPDATE channelratesavailabilities cr ' +
              'SET dirty=1 ' +
              'WHERE date>=CURRENT_DATE ' +
              'AND roomClassId IN ' +
              '  (SELECT id FROM roomtypegroups WHERE Code=%s OR TopClass=%s)',
              [_db(Code),
               _db(Code)]);
  d.roomerMainDataSet.DoCommand(s);
end;

procedure Set2RoomTypeGroupDity(Code1, Code2 : String);
var s : String;
begin
  s := format('UPDATE channelrates cr ' +
              'SET availabilityDirty=1 ' +
              'WHERE date>=CURRENT_DATE ' +
              'AND roomClassId IN ' +
              '  (SELECT id FROM roomtypegroups WHERE Code IN (%s,%s) OR TopClass IN (%s, %s))',
              [_db(Code1), _db(Code2),
               _db(Code1), _db(Code2)]);
  d.roomerMainDataSet.DoCommand(s);

  s := format('UPDATE channelratesavailabilities cr ' +
              'SET dirty=1 ' +
              'WHERE date>=CURRENT_DATE ' +
              'AND roomClassId IN ' +
              '  (SELECT id FROM roomtypegroups WHERE Code IN (%s,%s) OR TopClass IN (%s, %s))',
              [_db(Code1), _db(Code2),
               _db(Code1), _db(Code2)]);
  d.roomerMainDataSet.DoCommand(s);
end;

const TABLES_WITH_ROOMTYPE_GROUP_CODE : Array [0..2] of String =
    ('roomreservations,RoomClass',
     'roomtypes,RoomTypeGroup',
     'tbldelroomreservations,RoomClass');

procedure UpdateRoomTypeGroupCode(oldCode, newCode : String);
begin
  UpdateCodeOfTable(TABLES_WITH_ROOMTYPE_GROUP_CODE, oldCode, newCode);
end;

procedure initRoomTypeGroupHolder(var rec: recRoomTypeGroupHolder);
begin
  with rec do
  begin
    // ID                : integer;
    active := true;
    Code := '';
    TopClass := '';
    Description := '';
    PriorityRule := '';
    MaxCount := 0;
    numGuests := 2;
    minGuests := 0;
    maxGuests := 0;
    maxChildren := 0;
    color := '';
    AvailabilityTypes := '';
    BreakfastIncluded := false;
    HalfBoard := false;
    FullBoard := false;

    defRate := 0.00;
    defAvailability := 1;
    defMinStay := 0;
    defMaxStay := 0;
    defClosedToArrival := False;
    defClosedToDeparture := False;
    defMaxAvailability := 0;
    defStopSale := false;
    NonRefundable := false;
    AutoChargeCreditcards := false;
    RateExtraBed := 0.00;
    PhotoUri := '';
    sendAvailability := true;
    sendRate := true;
    sendStopSell := true;
    sendMinStay := true;
    DetailedDescriptionHtml := '';
    DetailedDescription := '';
    Package := '';
    OrderIndex := 0;

    connectRateToMasterRate := false;
    masterRateRateDeviation := 0.00;;
    RateDeviationType := 'FIXED_AMOUNT';
    connectSingleUseRateToMasterRate := false;
    masterRateSingleUseRateDeviation := 0.00;
    singleUseRateDeviationType := 'FIXED_AMOUNT';
    connectStopSellToMasterRate := false;
    connectAvailabilityToMasterRate := false;
    connectMinStayToMasterRate := false;
    connectMaxStayToMasterRate := false;
    connectCOAToMasterRate := false;
    connectCODToMasterRate := false;
    connectLOSToMasterRate := false;
    RATE_PLAN_TYPE := 'STANDARD';
    prepaidPercentage := 100;

  end;
end;

function Del_roomTypeGroup(theData: recRoomTypeGroupHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM roomtypegroups ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function UPD_roomTypeGroup(theData: recRoomTypeGroupHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE roomtypegroups ' + #10;
  s := s + ' SET ' + #10;
  s := s + '    Active = ' + _db(theData.active) + ' ' + #10;
  s := s + '   ,Code =' + _db(theData.Code) + ' ' + #10;
  s := s + '   ,TopClass =' + _db(theData.TopClass) + ' ' + #10;
  s := s + '   ,Description   =' + _db(theData.Description) + ' ' + #10;
  s := s + '   ,PriorityRule  =' + _db(theData.PriorityRule) + ' ' + #10;
  s := s + '   ,MaxCount =' + _db(theData.MaxCount) + ' ' + #10;
  s := s + '   ,minGuests =' + _db(theData.minGuests) + ' ' + #10;
  s := s + '   ,numGuests =' + _db(theData.numGuests) + ' ' + #10;
  s := s + '   ,maxGuests =' + _db(theData.maxGuests) + ' ' + #10;
  s := s + '   ,maxChildren =' + _db(theData.maxChildren) + ' ' + #10;
  s := s + '   ,color =' + _db(theData.color) + ' ' + #10;
  s := s + '   ,AvailabilityTypes =' + _db(theData.AvailabilityTypes) + ' ' + #10;
  s := s + '   ,BreakfastIncluded =' + _db(theData.BreakfastIncluded) + ' ' + #10;
  s := s + '   ,HalfBoard =' + _db(theData.HalfBoard) + ' ' + #10;
  s := s + '   ,FullBoard =' + _db(theData.FullBoard) + ' ' + #10;
  s := s + '   ,defRate =' + _db(theData.defRate) + ' ' + #10;
  s := s + '   ,defAvailability   =' + _db(theData.defAvailability) + ' ' + #10;
  s := s + '   ,defMinStay =' + _db(theData.defMinStay) + ' ' + #10;
  s := s + '   ,defMaxStay =' + _db(theData.defMaxStay) + ' ' + #10;
  s := s + '   ,defClosedToArrival =' + _db(theData.defClosedToArrival) + ' ' + #10;
  s := s + '   ,defClosedToDeparture =' + _db(theData.defClosedToDeparture) + ' ' + #10;
  s := s + '   ,defMaxAvailability   =' + _db(theData.defMaxAvailability) + ' ' + #10;
  s := s + '   ,defStopSale =' + _db(theData.defStopSale) + ' ' + #10;
  s := s + '   ,NonRefundable =' + _db(theData.NonRefundable) + ' ' + #10;
  s := s + '   ,AutoChargeCreditcards =' + _db(theData.AutoChargeCreditcards) + ' ' + #10;
  s := s + '   ,RateExtraBed =' + _db(theData.RateExtraBed) + ' ' + #10;
  s := s + '   ,PhotoUri =' + _db(theData.PhotoUri) + ' ' + #10;
  s := s + '   ,sendAvailability =' + _db(theData.sendAvailability) + ' ' + #10;
  s := s + '   ,sendRate =' + _db(theData.sendRate) + ' ' + #10;
  s := s + '   ,sendStopSell =' + _db(theData.sendStopSell) + ' ' + #10;
  s := s + '   ,sendMinStay =' + _db(theData.sendMinStay) + ' ' + #10;
  s := s + '   ,DetailedDescriptionHtml =' + _db(theData.DetailedDescriptionHtml) + ' ' + #10;
  s := s + '   ,DetailedDescription =' + _db(theData.DetailedDescription) + ' ' + #10;
  s := s + '   ,Package =' + _db(theData.package) + ' ' + #10;
  s := s + '   ,OrderIndex =' + _db(theData.OrderIndex) + ' ' + #10;
  s := s + '   ,connectRateToMasterRate = ' + _db(theData.connectRateToMasterRate) + ' ' + #10;
  s := s + '   ,masterRateRateDeviation = ' + _db(theData.masterRateRateDeviation) + ' ' + #10;
  s := s + '   ,RateDeviationType = ' + _db(theData.RateDeviationType) + ' ' + #10;
  s := s + '   ,connectSingleUseRateToMasterRate = ' + _db(theData.connectSingleUseRateToMasterRate) + ' ' + #10;
  s := s + '   ,masterRateSingleUseRateDeviation = ' + _db(theData.masterRateSingleUseRateDeviation) + ' ' + #10;
  s := s + '   ,singleUseRateDeviationType = ' + _db(theData.singleUseRateDeviationType) + ' ' + #10;
  s := s + '   ,connectStopSellToMasterRate = ' + _db(theData.connectStopSellToMasterRate) + ' ' + #10;
  s := s + '   ,connectAvailabilityToMasterRate = ' + _db(theData.connectAvailabilityToMasterRate) + ' ' + #10;
  s := s + '   ,connectMinStayToMasterRate = ' + _db(theData.connectMinStayToMasterRate) + ' ' + #10;
  s := s + '   ,connectMaxStayToMasterRate = ' + _db(theData.connectMaxStayToMasterRate) + ' ' + #10;
  s := s + '   ,connectCOAToMasterRate = ' + _db(theData.connectCOAToMasterRate) + ' ' + #10;
  s := s + '   ,connectCODToMasterRate = ' + _db(theData.connectCODToMasterRate) + ' ' + #10;
  s := s + '   ,connectLOSToMasterRate = ' + _db(theData.connectLOSToMasterRate) + ' ' + #10;
  s := s + '   ,RATE_PLAN_TYPE = ' + _db(theData.RATE_PLAN_TYPE) + ' ' + #10;
  s := s + '   ,prepaidPercentage = ' + _db(theData.prepaidPercentage) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function INS_roomTypeGroup(theData: recRoomTypeGroupHolder; var NewID: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'INSERT INTO roomtypegroups ' + #10;
  s := s + '  ( ' + #10;
  s := s + '  Active ' + #10;
  s := s + ' ,Code ' + #10;
  s := s + ' ,TopClass ' + #10;
  s := s + ' ,Description ' + #10;
  s := s + ' ,PriorityRule ' + #10;
  s := s + ' ,MaxCount ' + #10;
  s := s + ' ,numGuests ' + #10;
  s := s + ' ,minGuests ' + #10;
  s := s + ' ,maxGuests ' + #10;
  s := s + ' ,maxChildren ' + #10;
  s := s + ' ,color ' + #10;
  s := s + ' ,AvailabilityTypes ' + #10;
  s := s + ' ,BreakfastIncluded ' + #10;
  s := s + ' ,HalfBoard ' + #10;
  s := s + ' ,FullBoard ' + #10;
  s := s + ' ,defRate ' + #10;
  s := s + ' ,defAvailability ' + #10;
  s := s + ' ,defMinStay ' + #10;
  s := s + ' ,defMaxStay ' + #10;
  s := s + ' ,defClosedToArrival ' + #10;
  s := s + ' ,defClosedToDeparture ' + #10;
  s := s + ' ,defMaxAvailability ' + #10;
  s := s + ' ,defStopSale ' + #10;
  s := s + ' ,NonRefundable ' + #10;
  s := s + ' ,AutoChargeCreditcards ' + #10;
  s := s + ' ,RateExtraBed ' + #10;
  s := s + ' ,PhotoUri ' + #10;
  s := s + ' ,sendAvailability ' + #10;
  s := s + ' ,sendRate ' + #10;
  s := s + ' ,sendStopSell ' + #10;
  s := s + ' ,sendMinStay ' + #10;
  s := s + ' ,DetailedDescriptionHtml ' + #10;
  s := s + ' ,DetailedDescription ' + #10;
  s := s + ' ,Package ' + #10;
  s := s + ' ,OrderIndex ' + #10;
  s := s + ' ,connectRateToMasterRate ' + #10;
  s := s + ' ,masterRateRateDeviation ' + #10;
  s := s + ' ,RateDeviationType ' + #10;
  s := s + ' ,connectSingleUseRateToMasterRate ' + #10;
  s := s + ' ,masterRateSingleUseRateDeviation ' + #10;
  s := s + ' ,singleUseRateDeviationType ' + #10;
  s := s + ' ,connectStopSellToMasterRate ' + #10;
  s := s + ' ,connectAvailabilityToMasterRate ' + #10;
  s := s + ' ,connectMinStayToMasterRate ' + #10;
  s := s + ' ,connectMaxStayToMasterRate ' + #10;
  s := s + ' ,connectCOAToMasterRate ' + #10;
  s := s + ' ,connectCODToMasterRate ' + #10;
  s := s + ' ,connectLOSToMasterRate ' + #10;
  s := s + ' ,RATE_PLAN_TYPE ' + #10;
  s := s + ' ,prepaidPercentage ' + #10;
  s := s + '  ) ' + #10;
  s := s + '   VALUES ' + #10;
  s := s + '  ( ' + #10;
  s := s + '   ' + _db(theData.active) + ' ' + #10;
  s := s + '  ,' + _db(theData.Code) + ' ' + #10;
  s := s + '  ,' + _db(theData.TopClass) + ' ' + #10;
  s := s + '  ,' + _db(theData.Description) + ' ' + #10;
  s := s + '  ,' + _db(theData.PriorityRule) + ' ' + #10;
  s := s + '  ,' + _db(theData.MaxCount) + ' ' + #10;
  s := s + '  ,' + _db(theData.numGuests) + ' ' + #10;
  s := s + '  ,' + _db(theData.minGuests) + ' ' + #10;
  s := s + '  ,' + _db(theData.maxGuests) + ' ' + #10;
  s := s + '  ,' + _db(theData.maxChildren) + ' ' + #10;
  s := s + '  ,' + _db(theData.color) + ' ' + #10;
  s := s + '  ,' + _db(theData.AvailabilityTypes) + ' ' + #10;
  s := s + '  ,' + _db(theData.BreakfastIncluded) + ' ' + #10;
  s := s + '  ,' + _db(theData.HalfBoard) + ' ' + #10;
  s := s + '  ,' + _db(theData.FullBoard) + ' ' + #10;
  s := s + '  ,' + _db(theData.defRate) + ' ' + #10;
  s := s + '  ,' + _db(theData.defAvailability) + ' ' + #10;
  s := s + '  ,' + _db(theData.defMinStay) + ' ' + #10;
  s := s + '  ,' + _db(theData.defMaxStay) + ' ' + #10;
  s := s + '  ,' + _db(theData.defClosedToArrival) + ' ' + #10;
  s := s + '  ,' + _db(theData.defClosedToDeparture) + ' ' + #10;
  s := s + '  ,' + _db(theData.defMaxAvailability) + ' ' + #10;
  s := s + '  ,' + _db(theData.defStopSale) + ' ' + #10;
  s := s + '  ,' + _db(theData.NonRefundable) + ' ' + #10;
  s := s + '  ,' + _db(theData.AutoChargeCreditcards) + ' ' + #10;
  s := s + '  ,' + _db(theData.RateExtraBed) + ' ' + #10;
  s := s + '  ,' + _db(theData.PhotoUri) + ' ' + #10;
  s := s + '  ,' + _db(theData.sendAvailability) + ' ' + #10;
  s := s + '  ,' + _db(theData.sendRate) + ' ' + #10;
  s := s + '  ,' + _db(theData.sendStopSell) + ' ' + #10;
  s := s + '  ,' + _db(theData.sendMinStay) + ' ' + #10;
  s := s + '  ,' + _db(theData.DetailedDescriptionHtml) + ' ' + #10;
  s := s + '  ,' + _db(theData.DetailedDescription) + ' ' + #10;
  s := s + '  ,' + _db(theData.package) + ' ' + #10;
  s := s + '  ,' + _db(theData.OrderIndex) + ' ' + #10;
  s := s + '  ,' + _db(theData.connectRateToMasterRate) + ' ' + #10;
  s := s + '  ,' + _db(theData.masterRateRateDeviation) + ' ' + #10;
  s := s + '  ,' + _db(theData.RateDeviationType) + ' ' + #10;
  s := s + '  ,' + _db(theData.connectSingleUseRateToMasterRate) + ' ' + #10;
  s := s + '  ,' + _db(theData.masterRateSingleUseRateDeviation) + ' ' + #10;
  s := s + '  ,' + _db(theData.singleUseRateDeviationType) + ' ' + #10;
  s := s + '  ,' + _db(theData.connectStopSellToMasterRate) + ' ' + #10;
  s := s + '  ,' + _db(theData.connectAvailabilityToMasterRate) + ' ' + #10;
  s := s + '  ,' + _db(theData.connectMinStayToMasterRate) + ' ' + #10;
  s := s + '  ,' + _db(theData.connectMaxStayToMasterRate) + ' ' + #10;
  s := s + '  ,' + _db(theData.connectCOAToMasterRate) + ' ' + #10;
  s := s + '  ,' + _db(theData.connectCODToMasterRate) + ' ' + #10;
  s := s + '  ,' + _db(theData.connectLOSToMasterRate) + ' ' + #10;
  s := s + '  ,' + _db(theData.RATE_PLAN_TYPE) + ' ' + #10;
  s := s + '  ,' + _db(theData.prepaidPercentage) + ' ' + #10;
  s := s + '   )';
  result := cmd_bySQL(s);
  if result then
  begin
    NewID := GetLastID('roomTypeGroups');
  end;

end;

function roomTypeGroupExist(sCode: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  s := '';
  s := s + ' SELECT ' + chr(10);
  s := s + '   Code ' + chr(10);
  s := s + ' FROM ' + chr(10);
  s := s + '   roomtypegroups ' + chr(10);
  s := s + ' WHERE ' + chr(10);
  s := s + '   Code = %s ';
  rSet := CreateNewDataSet;
  try
    s := format(s, [_db(sCode)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function RoomTypeGroupExistsInOther(sCode: string; id: integer): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := true;
  rSet := CreateNewDataSet;
  try
    s := format(select_RoomTypeGroupExistsInOther, [_db(sCode)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      exit;
    end;
  finally
    freeandnil(rSet);
  end;
  result := false;
end;





// SEASONS
/// /////////////////////////////////////////////////////////////////////////////
// ID             : integer ;
// Active         : boolean ;
// seDescription  : string  ;
// seStartDate    : TdateTime ;
// seEndDate      : TdateTime ;
/// ////////////////////////////////////////////////////////////////////////////

procedure initSeasonHolder(var rec: recSeasonHolder);
begin
  with rec do
  begin
    active := true;
    seDescription := '';
    seStartDate := date;
    seEndDate := date;
  end;
end;

function Del_Season(theData: recSeasonHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM tblseasons ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function UPD_Season(theData: recSeasonHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE tblseasons ' + #10;
  s := s + ' SET ' + #10;
  s := s + '    Active  = ' + _db(theData.active) + ' ' + #10;
  s := s + '   ,seDescription  = ' + _db(theData.seDescription) + ' ' + #10;
  s := s + '   ,seStartDate =' + _db(theData.seStartDate) + ' ' + #10;
  s := s + '   ,seEndDate =' + _db(theData.seEndDate) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function INS_Season(theData: recSeasonHolder; var NewID: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'INSERT INTO tblseasons ' + #10;
  s := s + '  ( ' + #10;
  s := s + '  Active ' + #10;
  s := s + ' ,seDescription ' + #10;
  s := s + ' ,seStartDate ' + #10;
  s := s + ' ,seEndDate ' + #10;
  s := s + '  ) ' + #10;
  s := s + '   VALUES ' + #10;
  s := s + '  ( ' + #10;
  s := s + '   ' + _db(theData.active) + ' ' + #10;
  s := s + '  ,' + _db(theData.seDescription) + ' ' + #10;
  s := s + '  ,' + _db(theData.seStartDate) + ' ' + #10;
  s := s + '  ,' + _db(theData.seEndDate) + ' ' + #10;
  s := s + '   )';
  result := cmd_bySQL(s);
  if result then
  begin
    NewID := GetLastID('tblseasons');
  end;

end;

function seasonDescriptionExist(sDescription: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  s := '';
  s := s + ' SELECT ' + chr(10);
  s := s + '   seDescription ' + chr(10);
  s := s + ' FROM ' + chr(10);
  s := s + '   tblseasons ' + chr(10);
  s := s + ' WHERE ' + chr(10);
  s := s + '   seDescription = %s ';
  rSet := CreateNewDataSet;
  try
    s := format(s, [_db(sDescription)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function seasonHolderByID(iID: integer): recSeasonHolder;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  initSeasonHolder(result);

  s := '';
  s := s + ' SELECT ' + chr(10);
  s := s + '   * ' + chr(10);
  s := s + ' FROM ' + chr(10);
  s := s + '   tblseasons ' + chr(10);
  s := s + ' WHERE ' + chr(10);
  s := s + '   ID = %d ';
  rSet := CreateNewDataSet;
  try
    s := format(s, [iID]);
    if rSet_bySQL(rSet, s) then
    begin
      result.id := rSet.fieldbyname('ID').asInteger;
      result.active := rSet.fieldbyname('Active').Asboolean;
      result.seDescription := rSet.fieldbyname('seDescription').asString;
      result.seStartDate := rSet.fieldbyname('seStartDate').AsDateTime;
      result.seEndDate := rSet.fieldbyname('seEndDate').AsDateTime;
    end;
  finally
    freeandnil(rSet);
  end;
end;





//
// itemtypes
//
// ID
// Active
// Description
// Itemtype
// VATCode
// AccItemLink

function Del_itemtype(theData: recItemTypeHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM itemtypes ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function UPD_itemtype(theData: recItemTypeHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE itemtypes ' + #10;
  s := s + ' SET ' + #10;
  s := s + '    Active  = ' + _db(theData.active) + ' ' + #10;
  s := s + '   ,Description  = ' + _db(theData.Description) + ' ' + #10;
  s := s + '   ,Itemtype  = ' + _db(theData.ItemType) + ' ' + #10;
  s := s + '   ,VATCode  = ' + _db(theData.VatCode) + ' ' + #10;
  s := s + '   ,AccItemLink  = ' + _db(theData.AccItemLink) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function INS_itemtype(theData: recItemTypeHolder; var NewID: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'INSERT INTO itemtypes ' + #10;
  s := s + '   ( ' + #10;
  s := s + '     [Itemtype] ' + #10;
  s := s + '    ,[Description] ' + #10;
  s := s + '    ,[VATCode] ' + #10;
  s := s + '    ,[AccItemLink] ' + #10;
  s := s + '    ,[Active] ' + #10;
  s := s + '   ) ' + #10;
  s := s + '   VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '  ' + _db(theData.ItemType) + #10;
  s := s + '  , ' + _db(theData.Description) + #10;
  s := s + '  , ' + _db(theData.VatCode) + #10;
  s := s + '  , ' + _db(theData.AccItemLink) + #10;
  s := s + '  , ' + _db(theData.active) + #10;
  s := s + '   ) ';

  result := cmd_bySQL(s);
  if result then
  begin
    NewID := GetLastID('itemtypes');
  end;

end;

function GET_ItemType_ByItemType(var theData: recItemTypeHolder): boolean;
var
  rSet: TRoomerDataSet;
  sql: string;
begin
  result := false;
  rSet := CreateNewDataSet;
  try
    sql := format(select_Itemtype_ByItemtype, [_db(theData.ItemType)]);
    if hData.rSet_bySQL(rSet, sql) then
    begin
      theData.ItemType := rSet.fieldbyname('Itemtype').asString;
      theData.Description := rSet.fieldbyname('Description').asString;
      theData.VatCode := rSet.fieldbyname('VATCode').asString;
      theData.AccItemLink := rSet.fieldbyname('AccItemLink').asString;
      theData.id := rSet.fieldbyname('ID').asInteger;
      theData.active := rSet.fieldbyname('Active').Asboolean;
      result := true;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function itemtypesItemtypeExist(sItemType: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  s := '';
  s := s + ' SELECT ' + chr(10);
  s := s + '   itemType ' + chr(10);
  s := s + ' FROM ' + chr(10);
  s := s + '   itemtypes ' + chr(10);
  s := s + ' WHERE ' + chr(10);
  s := s + '   itemType = %s ';
  rSet := CreateNewDataSet;
  try
    s := format(s, [_db(sItemType)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function itemTypeExistsInOther(sCode: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  s := s + ' SELECT itemType FROM items ' + chr(10);
  s := s + ' WHERE (itemType =  %s ) ' + chr(10);
  s := s + ' LIMIT 0,1 ' + chr(10);
  rSet := CreateNewDataSet;
  try
    s := format(s, [_db(sCode)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;


//////////////////////////////////////////////////////////////////////////////////////
procedure initDayNotes(var rec: recDayNotesHolder);
begin
  with rec do
  begin
    ID                    := 0;
    User                  := d.roomerMainDataSet.username;
    ADate                 := now;
    Notes                 := '';
    AAction               := '';
    LastChangedBy         := d.roomerMainDataSet.username;
    LastUpdate            := now;
  end;
end;

function UPD_DayNotes(var rec: recDayNotesHolder) : Boolean;
var sql: String;
begin
  with rec do
    sql := format('UPDATE daynotes SET date=''%s'', notes=%s, action=''%s'', lastChangedBy=%s WHERE id=%d',
          [uDateUtils.dateToSqlString(ADate), _db(Notes), AAction, _db(user), id]);
  try
    d.roomerMainDataSet.DoCommand(sql);
    result := True;
  except
    result := False;
  end;
end;

function INS_DayNotes(var rec: recDayNotesHolder; var newId : Integer) : Boolean;
var sql: String;
begin
  with rec do
    sql := format('INSERT INTO daynotes (user, date, notes, action, lastChangedBy) VALUES(%s, ''%s'', %s, ''%s'', %s)',
          [_db(user), uDateUtils.dateToSqlString(ADate), _db(Notes), AAction, _db(user)]);
  try
    newId := d.roomerMainDataSet.DoCommand(sql);
    result := True;
  except
    result := False;
  end;
end;


// CleaningNotes
/// //////////////////////////////////////////////////////////////////////////////////
//
//
//
/// //////////////////////////////////////////////////////////////////////////////////

procedure initCleaningNoteHolder(var rec: recCleaningNotesHolder);
begin
  with rec do
  begin
    active := true;
    serviceType := 'INTERVAL';
    onceType := 'NONE';
    interval := 1;
    minimumDays := 1;
    sMessage := '';
  end;
end;

function Del_CleaningNote(theData: recCleaningNotesHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM cleaningnotes ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function UPD_CleaningNote(theData: recCleaningNotesHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE cleaningnotes ' + #10;
  s := s + ' SET ' + #10;
  s := s + '    Active = ' + _db(theData.active) + ' ' + #10;
  s := s + '   ,onlyWhenRoomIsDirty = ' + _db(theData.onlyWhenRoomIsDirty) + ' ' + #10;
  s := s + '   ,serviceType = ' + _db(theData.serviceType) + ' ' + #10;
  s := s + '   ,onceType = ' + _db(theData.onceType) + ' ' + #10;
  s := s + '   ,`interval` = ' + _db(theData.interval) + ' ' + #10;
  s := s + '   ,minimumDays = ' + _db(theData.minimumDays) + ' ' + #10;
  s := s + '   ,message = ' + _db(theData.smessage) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(theData.id) + ') ';

  result := cmd_bySQL(s);
end;

function INS_CleaningNote(theData: recCleaningNotesHolder; var NewID: integer): boolean;
var
  s: string;
begin

  s := '';
  s := s + 'INSERT INTO cleaningnotes ' + #10;
  s := s + '   ( ' + #10;
  s := s + '     Active ' + #10;
  s := s + '    ,onlyWhenRoomIsDirty ' + #10;
  s := s + '    ,serviceType ' + #10;
  s := s + '    ,onceType ' + #10;
  s := s + '    ,`interval` ' + #10;
  s := s + '    ,minimumDays ' + #10;
  s := s + '    ,message ' + #10;
  s := s + '   ) ' + #10;
  s := s + '   VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '    ' + _db(theData.active) + #10;
  s := s + '  , ' + _db(theData.onlyWhenRoomIsDirty) + #10;
  s := s + '  , ' + _db(theData.serviceType) + #10;
  s := s + '  , ' + _db(theData.onceType) + #10;
  s := s + '  , ' + _db(theData.interval) + #10;
  s := s + '  , ' + _db(theData.minimumDays) + #10;
  s := s + '  , ' + _db(theData.smessage) + #10;
  s := s + '   ) ';

  Result := cmd_bySQL(s);
  if Result then
    NewID := GetLastID('cleaningnotes')
end;

// Items
/// //////////////////////////////////////////////////////////////////////////////////
//
//
//
/// //////////////////////////////////////////////////////////////////////////////////

procedure initItemHolder(var rec: recItemHolder);
begin
  with rec do
  begin
    active := true;
    Description := '';
    Item := '';
    Price := 0;
    ItemType := '';
    AccountKey := '';
    MinibarItem := false;
    BreakfastItem := false;
    SystemItem := false;
    RoomRentItem := false;
    ReservationItem := false;
    Hide := false;
    Currency := '';
    BookKeepCode := '';
    NumberBase := 'USER_EDIT';
  end;
end;

function Del_item(theData: recItemHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM items ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function UPD_item(theData: recItemHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE items ' + #10;
  s := s + ' SET ' + #10;
  s := s + '    Active = ' + _db(theData.active) + ' ' + #10;
  s := s + '   ,Description = ' + _db(theData.Description) + ' ' + #10;
  s := s + '   ,Item = ' + _db(theData.Item) + ' ' + #10;
  s := s + '   ,Price = ' + _db(theData.Price) + ' ' + #10;
  s := s + '   ,Itemtype = ' + _db(theData.ItemType) + ' ' + #10;
  s := s + '   ,AccountKey = ' + _db(theData.AccountKey) + ' ' + #10;
  s := s + '   ,MinibarItem = ' + _db(theData.MinibarItem) + ' ' + #10;
  s := s + '   ,BreakfastItem = ' + _db(theData.BreakfastItem) + ' ' + #10;
  s := s + '   ,SystemItem = ' + _db(theData.SystemItem) + ' ' + #10;
  s := s + '   ,RoomRentitem = ' + _db(theData.RoomRentItem) + ' ' + #10;
  s := s + '   ,ReservationItem  = ' + _db(theData.ReservationItem) + ' ' + #10;
  s := s + '   ,Hide = ' + _db(theData.Hide) + ' ' + #10;
  s := s + '   ,Currency = ' + _db(theData.Currency) + ' ' + #10;
  s := s + '   ,BookKeepCode = ' + _db(theData.BookKeepCode) + ' ' + #10;
  s := s + '   ,NumberBase = ' + _db(theData.NumberBase) + ' ' + #10;
  s := s + '   ,Stockitem= ' + _db(theData.StockItem) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(theData.id) + ') ';

  d.roomerMainDataSet.SystemStartTransaction;
  try
    result := cmd_bySQL(s);
    if Result and theData.Stockitem and (theData.TotalStock > 0) then
    begin
      s := 'INSERT INTO stockitems (itemid, totalstock) VALUES ( ' + _db(theData.ID)  + ' , ' + _db(theData.TotalStock) + ') '+
           ' ON DUPLICATE KEY UPDATE itemid=' + _db(theData.ID)  + ', totalstock=' + _db(theData.TotalStock);
      Result := cmd_bySQL(s);
    end;
    if result then
      d.roomerMainDataSet.SystemCommitTransaction
    else
      d.roomerMainDataSet.SystemRollbackTransaction;

  except
    d.roomerMainDataSet.SystemRollbackTransaction;
    raise;
  end;
end;

function INS_Item(theData: recItemHolder; var NewID: integer): boolean;
var
  s: string;
begin

  s := '';
  s := s + 'INSERT INTO items ' + #10;
  s := s + '   ( ' + #10;
  s := s + '     Active ' + #10;
  s := s + '    ,Description ' + #10;
  s := s + '    ,Item ' + #10;
  s := s + '    ,Price ' + #10;
  s := s + '    ,Itemtype ' + #10;
  s := s + '    ,AccountKey ' + #10;
  s := s + '    ,MinibarItem ' + #10;
  s := s + '    ,BreakfastItem ' + #10;
  s := s + '    ,SystemItem ' + #10;
  s := s + '    ,RoomRentitem ' + #10;
  s := s + '    ,ReservationItem ' + #10;
  s := s + '    ,Hide ' + #10;
  s := s + '    ,Currency ' + #10;
  s := s + '    ,BookKeepCode ' + #10;
  s := s + '    ,NumberBase ' + #10;
  s := s + '    ,StockItem' + #10;
  s := s + '   ) ' + #10;
  s := s + '   VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '    ' + _db(theData.active) + #10;
  s := s + '  , ' + _db(theData.Description) + #10;
  s := s + '  , ' + _db(theData.Item) + #10;
  s := s + '  , ' + _db(theData.Price) + #10;
  s := s + '  , ' + _db(theData.ItemType) + #10;
  s := s + '  , ' + _db(theData.AccountKey) + #10;
  s := s + '  , ' + _db(theData.MinibarItem) + #10;
  s := s + '  , ' + _db(theData.BreakfastItem) + #10;
  s := s + '  , ' + _db(theData.SystemItem) + #10;
  s := s + '  , ' + _db(theData.RoomRentItem) + #10;
  s := s + '  , ' + _db(theData.ReservationItem) + #10;
  s := s + '  , ' + _db(theData.Hide) + #10;
  s := s + '  , ' + _db(theData.Currency) + #10;
  s := s + '  , ' + _db(theData.BookKeepCode) + #10;
  s := s + '  , ' + _db(theData.NumberBase) + #10;
  s := s + '  , ' + _db(theData.StockItem) + #10;
  s := s + '   ) ';

  d.roomerMainDataSet.SystemStartTransaction;
  try
    Result := cmd_bySQL(s);
    if Result then
    begin
      NewID := GetLastID('items');
      if theData.Stockitem and (theData.TotalStock > 0) then
      begin
        s := 'INSERT INTO stockitems (itemid, totalstock) VALUES '#10 +
             ' ( ' +
                _db(newId) + ' ' +
                ', ' + _db(theData.TotalStock) + ' ' +
                ')  ';
      result := cmd_bySQL(s);
      end;
    end;

    if result then
      d.roomerMainDataSet.SystemCommitTransaction
    else
      d.roomerMainDataSet.SystemRollbackTransaction;
  except
    d.roomerMainDataSet.SystemRollbackTransaction;
    raise;
  end;
end;

function GET_Item_ByItem(var theData: recItemHolder): boolean;
var
  rSet: TRoomerDataSet;
  sql: string;
begin
  result := false;
  rSet := CreateNewDataSet;
  try
    sql := format(select_Item_ByItem, [_db(theData.Item)]);
    if hData.rSet_bySQL(rSet, sql) then
    begin
      theData.active := rSet.fieldbyname('Active').Asboolean;
      theData.Description := rSet.fieldbyname('Description').asString;
      theData.Item := rSet.fieldbyname('Item').asString;
      theData.Price := rSet.GetFloatValue(rSet.fieldbyname('Price'));
      theData.ItemType := rSet.fieldbyname('Itemtype').asString;
      theData.AccountKey := rSet.fieldbyname('AccountKey').asString;
      theData.MinibarItem := rSet.fieldbyname('MinibarItem').Asboolean;
      theData.BreakfastItem := rSet.fieldbyname('BreakfastItem').Asboolean;
      theData.SystemItem := rSet.fieldbyname('SystemItem').Asboolean;
      theData.RoomRentItem := rSet.fieldbyname('RoomRentitem').Asboolean;
      theData.ReservationItem := rSet.fieldbyname('ReservationItem').Asboolean;
      theData.Hide := rSet.fieldbyname('Hide').Asboolean;
      theData.Currency := rSet.fieldbyname('Currency').asString;
      theData.BookKeepCode := rSet.fieldbyname('BookKeepCode').asString;
      theData.NumberBase := rSet.fieldbyname('NumberBase').asString;
      theData.StockItem:= rSet.fieldbyname('StockItem').asBoolean;
      theData.TotalStock := rSet.fieldbyname('TotalStock').AsInteger;
      result := true;
    end;
  finally
    freeandnil(rSet);
  end;

end;

function itemExist(sItem: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  s := '';
  s := s + ' SELECT ' + chr(10);
  s := s + '   item ' + chr(10);
  s := s + ' FROM ' + chr(10);
  s := s + '   items ' + chr(10);
  s := s + ' WHERE ' + chr(10);
  s := s + '   item = %s ';
  rSet := CreateNewDataSet;
  try
    s := format(s, [_db(sItem)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function itemExistsInOther(sCode: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  s := s + ' SELECT itemID FROM invoicelines ' + chr(10);
  s := s + ' WHERE (itemID =  %s ) ' + chr(10);
  s := s + ' LIMIT 0,1 ' + chr(10);
  rSet := CreateNewDataSet;
  try
    s := format(s, [_db(sCode)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function GET_ItemID(Item: string): integer;
var
  rSet: TRoomerDataSet;
  sql: string;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    sql := 'SELECT id from items where item =' + _db(Item) + ' ';
    if hData.rSet_bySQL(rSet, sql) then
    begin
      result := rSet.fieldbyname('ID').asInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function GET_ItemCode(id: integer): string;
var
  rSet: TRoomerDataSet;
  sql: string;
begin
  result := '';
  rSet := CreateNewDataSet;
  try
    sql := 'SELECT item from items where id =' + _db(id) + ' ';
    if hData.rSet_bySQL(rSet, sql) then
    begin
      result := rSet.fieldbyname('Item').asString;
    end;
  finally
    freeandnil(rSet);
  end;
end;


function Del_StockitemPrice(theData: recStockItemPricesHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM stockitemprices ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + _db(theData.ID) + ') ';
  result := cmd_bySQL(s);
end;

function UPD_StockitemPrice(theData: recStockItemPricesHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE stockitemprices ' + #10;
  s := s + ' SET ' + #10;
  s := s + '   fromdate = ' + _db(theData.FromDate);
  s := s + ',  price = ' + _db(theData.price);
  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function INS_StockitemPrice(theData: recStockItemPricesHolder; var aNewID: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'INSERT INTO stockitemprices ' + #10;
  s := s + '   ( ' + #10;
  s := s + '     itemID' + #10;
  s := s + '    ,fromdate' + #10;
  s := s + '    ,Price ' + #10;
  s := s + '   ) ' + #10;
  s := s + '   VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '    ' + _db(theData.ItemID) + #10;
  s := s + '  , ' + _db(theData.FromDate) + #10;
  s := s + '  , ' + _db(theData.price) + #10;
  s := s + '   ) ';
  result := cmd_bySQL(s);
  if result then
  begin
    aNewID := GetLastID('stockitemprices');
  end;

end;

// recLocationHolder = record
// ID              : integer ;
// Active          : boolean ;
// description     : string;
// location        : string;
// end;

/// //////////////////////////////////////////////////////////////////////////////////
//
//
//
/// //////////////////////////////////////////////////////////////////////////////////

procedure initLocationHolder(var rec: recLocationHolder);
begin
  with rec do
  begin
    active := true;
    Description := '';
    Location := '';
    channelManager := 0;
    AccountDepartment := '';
  end;
end;

function Del_location(theData: recLocationHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM locations ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function UPD_location(theData: recLocationHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE locations ' + #10;
  s := s + ' SET ' + #10;
  s := s + '    Active = ' + _db(theData.active) + ' ' + #10;
  s := s + '   ,Description = ' + _db(theData.Description) + ' ' + #10;
  s := s + '   ,location = ' + _db(theData.Location) + ' ' + #10;
  if theData.channelManager > 0 then
    s := s + '   ,channelManager = ' + _db(theData.channelManager) + ' ' + #10;
  s := s + '   ,AccountDepartment = ' + _db(theData.Accountdepartment) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function INS_location(theData: recLocationHolder; var NewID: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'INSERT INTO locations ' + #10;
  s := s + '   ( ' + #10;
  s := s + '     Active ' + #10;
  s := s + '    ,Description ' + #10;
  s := s + '    ,location ' + #10;
  if theData.channelManager > 0 then
    s := s + '    ,channelmanager ' + #10;
  s := s + '    ,Accountdepartment ' + #10;
  s := s + '   ) ' + #10;
  s := s + '   VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '    ' + _db(theData.active) + #10;
  s := s + '  , ' + _db(theData.Description) + #10;
  s := s + '  , ' + _db(theData.Location) + #10;
  if theData.channelManager > 0 then
    s := s + '  , ' + _db(theData.channelManager) + #10;
  s := s + '  , ' + _db(theData.AccountDepartment) + #10;

  s := s + '   ) ';
  result := cmd_bySQL(s);
  if result then
  begin
    NewID := GetLastID('locations');
  end;

end;

function GET_Location_ByLocation(var theData: recLocationHolder): boolean;
var
  rSet: TRoomerDataSet;
  sql: string;
begin
  result := false;
  rSet := CreateNewDataSet;
  try
    sql := format(select_Location_ByLocation, [_db(theData.Location)]);
    if hData.rSet_bySQL(rSet, sql) then
    begin
      theData.active := rSet.fieldbyname('Active').Asboolean;
      theData.Description := rSet.fieldbyname('Description').asString;
      theData.Location := rSet.fieldbyname('location').asString;
      theData.AccountDepartment := rSet.fieldbyname('AccountDepartment').asString;
      theData.channelManager := rSet.fieldbyname('channelManager').asInteger;
      theData.channelManagerName := rSet.fieldbyname('channelManagerName').asString;
      result := true;
    end;
  finally
    freeandnil(rSet);
  end;

end;

procedure initRoomHolder(var rec: recRoomHolder);
begin
  with rec do
  begin
    // ID                 : integer ;
    active := true;
    Description := '';
    Room := '';
    RoomType := '';
    Location := '';
    wildcard := false;
    Bath := false;
    Shower := false;
    Safe := false;
    TV := false;
    Video := false;
    Radio := false;
    CDPlayer := false;
    Telephone := false;
    Press := false;
    Coffee := false;
    Kitchen := false;
    Minibar := false;
    Fridge := false;
    Hairdryer := false;
    InternetPlug := false;
    Fax := false;
    SqrMeters := 0;
    BedSize := '';
    Equipments := '';
    Bookable := true;
    Statistics := true;
    Status := 'C';
    OrderIndex := 0;
    hidden := false;
    Floor := 1;
    Dorm := '';
    UseInNationalReport := true;
  end;
end;

function Del_room(theData: recRoomHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM rooms ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function UPD_room(theData: recRoomHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE rooms ' + #10;
  s := s + ' SET ' + #10;
  s := s + '    Active = ' + _db(theData.active) + ' ' + #10;
  s := s + '   ,description = ' + _db(theData.Description) + ' ' + #10;
  s := s + '   ,Room = ' + _db(theData.Room) + ' ' + #10;
  s := s + '   ,RoomType = ' + _db(theData.RoomType) + ' ' + #10;
  s := s + '   ,location = ' + _db(theData.Location) + ' ' + #10;
  s := s + '   ,wildcard = ' + _db(theData.wildcard) + ' ' + #10;
  s := s + '   ,Bath = ' + _db(theData.Bath) + ' ' + #10;
  s := s + '   ,Shower = ' + _db(theData.Shower) + ' ' + #10;
  s := s + '   ,Safe = ' + _db(theData.Safe) + ' ' + #10;
  s := s + '   ,TV = ' + _db(theData.TV) + ' ' + #10;
  s := s + '   ,Video = ' + _db(theData.Video) + ' ' + #10;
  s := s + '   ,Radio = ' + _db(theData.Radio) + ' ' + #10;
  s := s + '   ,CDPlayer = ' + _db(theData.CDPlayer) + ' ' + #10;
  s := s + '   ,Telephone = ' + _db(theData.Telephone) + ' ' + #10;
  s := s + '   ,Press = ' + _db(theData.Press) + ' ' + #10;
  s := s + '   ,Coffee = ' + _db(theData.Coffee) + ' ' + #10;
  s := s + '   ,Kitchen = ' + _db(theData.Kitchen) + ' ' + #10;
  s := s + '   ,Minibar = ' + _db(theData.Minibar) + ' ' + #10;
  s := s + '   ,Fridge = ' + _db(theData.Fridge) + ' ' + #10;
  s := s + '   ,Hairdryer = ' + _db(theData.Hairdryer) + ' ' + #10;
  s := s + '   ,InternetPlug = ' + _db(theData.InternetPlug) + ' ' + #10;
  s := s + '   ,Fax = ' + _db(theData.Fax) + ' ' + #10;
  s := s + '   ,SqrMeters = ' + _db(theData.SqrMeters) + ' ' + #10;
  s := s + '   ,BedSize = ' + _db(theData.BedSize) + ' ' + #10;
  s := s + '   ,Equipments = ' + _db(theData.Equipments) + ' ' + #10;
  s := s + '   ,Bookable = ' + _db(theData.Bookable) + ' ' + #10;
  s := s + '   ,Statistics = ' + _db(theData.Statistics) + ' ' + #10;
  s := s + '   ,Status = ' + _db(theData.Status) + ' ' + #10;
  s := s + '   ,OrderIndex = ' + _db(theData.OrderIndex) + ' ' + #10;
  s := s + '   ,hidden = ' + _db(theData.hidden) + ' ' + #10;
  s := s + '   ,Floor = ' + _db(theData.Floor) + ' ' + #10;
  s := s + '   ,Dorm = ' + _db(theData.Dorm) + ' ' + #10;
  s := s + '   ,useInNationalReport = ' + _db(theData.UseInNationalReport) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function UPD_roomLocation(Roomtype, newLocation : string): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE rooms ' + #10;
  s := s + ' SET ' + #10;
  s := s + '   location = ' + _db(newLocation) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (roomType = ' + _db(Roomtype) + ') ';
  result := cmd_bySQL(s);
end;



function INS_room(theData: recRoomHolder; var NewID: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'INSERT INTO rooms ' + #10;
  s := s + '   ( ' + #10;
  s := s + '     Active ' + #10;
  s := s + '    ,description  ' + #10;
  s := s + '    ,Room ' + #10;
  s := s + '    ,RoomType ' + #10;
  s := s + '    ,location ' + #10;
  s := s + '    ,wildcard ' + #10;
  s := s + '    ,Bath ' + #10;
  s := s + '    ,Shower ' + #10;
  s := s + '    ,Safe ' + #10;
  s := s + '    ,TV ' + #10;
  s := s + '    ,Video ' + #10;
  s := s + '    ,Radio ' + #10;
  s := s + '    ,CDPlayer ' + #10;
  s := s + '    ,Telephone ' + #10;
  s := s + '    ,Press ' + #10;
  s := s + '    ,Coffee ' + #10;
  s := s + '    ,Kitchen ' + #10;
  s := s + '    ,Minibar ' + #10;
  s := s + '    ,Fridge ' + #10;
  s := s + '    ,Hairdryer ' + #10;
  s := s + '    ,InternetPlug ' + #10;
  s := s + '    ,Fax ' + #10;
  s := s + '    ,SqrMeters ' + #10;
  s := s + '    ,BedSize ' + #10;
  s := s + '    ,Equipments ' + #10;
  s := s + '    ,Bookable ' + #10;
  s := s + '    ,Statistics ' + #10;
  s := s + '    ,Status ' + #10;
  s := s + '    ,OrderIndex ' + #10;
  s := s + '    ,hidden ' + #10;
  s := s + '    ,Floor ' + #10;
  s := s + '    ,Dorm ' + #10;
  s := s + '    ,useInNationalReport ' + #10;
  s := s + '   ) ' + #10;
  s := s + '   VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '   ' + _db(theData.active) + #10;
  s := s + '  ,' + _db(theData.Description) + #10;
  s := s + '  ,' + _db(theData.Room) + #10;
  s := s + '  ,' + _db(theData.RoomType) + #10;
  s := s + '  ,' + _db(theData.Location) + #10;
  s := s + '  ,' + _db(theData.wildcard) + #10;
  s := s + '  ,' + _db(theData.Bath) + #10;
  s := s + '  ,' + _db(theData.Shower) + #10;
  s := s + '  ,' + _db(theData.Safe) + #10;
  s := s + '  ,' + _db(theData.TV) + #10;
  s := s + '  ,' + _db(theData.Video) + #10;
  s := s + '  ,' + _db(theData.Radio) + #10;
  s := s + '  ,' + _db(theData.CDPlayer) + #10;
  s := s + '  ,' + _db(theData.Telephone) + #10;
  s := s + '  ,' + _db(theData.Press) + #10;
  s := s + '  ,' + _db(theData.Coffee) + #10;
  s := s + '  ,' + _db(theData.Kitchen) + #10;
  s := s + '  ,' + _db(theData.Minibar) + #10;
  s := s + '  ,' + _db(theData.Fridge) + #10;
  s := s + '  ,' + _db(theData.Hairdryer) + #10;
  s := s + '  ,' + _db(theData.InternetPlug) + #10;
  s := s + '  ,' + _db(theData.Fax) + #10;
  s := s + '  ,' + _db(theData.SqrMeters) + #10;
  s := s + '  ,' + _db(theData.BedSize) + #10;
  s := s + '  ,' + _db(theData.Equipments) + #10;
  s := s + '  ,' + _db(theData.Bookable) + #10;
  s := s + '  ,' + _db(theData.Statistics) + #10;
  s := s + '  ,' + _db(theData.Status) + #10;
  s := s + '  ,' + _db(theData.OrderIndex) + #10;
  s := s + '  ,' + _db(theData.hidden) + #10;
  s := s + '  ,' + _db(theData.Floor) + #10;
  s := s + '  ,' + _db(theData.Dorm) + #10;
  s := s + '  ,' + _db(theData.UseInNationalReport) + #10;
  s := s + '   ) ';
  result := cmd_bySQL(s);
  if result then
  begin
    NewID := GetLastID('rooms');
  end;

end;

function GET_Room_ByRoom(var theData: recRoomHolder): boolean;
var
  rSet: TRoomerDataSet;
  sql: string;
begin
  rSet := CreateNewDataSet;
  try
    result := false;
    sql := format('SELECT * FROM rooms WHERE Location=%s', [_db(theData.Location)]);
    if hData.rSet_bySQL(rSet, sql) then
    begin
      theData.id := rSet.fieldbyname('ID').asInteger;
      theData.active := rSet.fieldbyname('Active').Asboolean;
      theData.Description := rSet.fieldbyname('description').asString;
      theData.Room := rSet.fieldbyname('Room').asString;
      theData.RoomType := rSet.fieldbyname('RoomType').asString;
      theData.Location := rSet.fieldbyname('location').asString;
      theData.wildcard := rSet.fieldbyname('wildcard').Asboolean;
      theData.Bath := rSet.fieldbyname('Bath').Asboolean;
      theData.Shower := rSet.fieldbyname('Shower').Asboolean;
      theData.Safe := rSet.fieldbyname('Safe').Asboolean;
      theData.TV := rSet.fieldbyname('TV').Asboolean;
      theData.Video := rSet.fieldbyname('Video').Asboolean;
      theData.Radio := rSet.fieldbyname('Radio').Asboolean;
      theData.CDPlayer := rSet.fieldbyname('CDPlayer').Asboolean;
      theData.Telephone := rSet.fieldbyname('Telephone').Asboolean;
      theData.Press := rSet.fieldbyname('Press').Asboolean;
      theData.Coffee := rSet.fieldbyname('Coffee').Asboolean;
      theData.Kitchen := rSet.fieldbyname('Kitchen').Asboolean;
      theData.Minibar := rSet.fieldbyname('Minibar').Asboolean;
      theData.Fridge := rSet.fieldbyname('Fridge').Asboolean;
      theData.Hairdryer := rSet.fieldbyname('Hairdryer').Asboolean;
      theData.InternetPlug := rSet.fieldbyname('InternetPlug').Asboolean;
      theData.Fax := rSet.fieldbyname('Fax').Asboolean;
      theData.SqrMeters := rSet.fieldbyname('SqrMeters').asInteger;
      theData.BedSize := rSet.fieldbyname('BedSize').asString;
      theData.Equipments := rSet.fieldbyname('Equipments').asString;
      theData.Bookable := rSet.fieldbyname('Bookable').Asboolean;
      theData.Statistics := rSet.fieldbyname('Statistics').Asboolean;
      theData.Status := rSet.fieldbyname('Status').asString;
      theData.OrderIndex := rSet.fieldbyname('OrderIndex').asInteger;
      theData.hidden := rSet.fieldbyname('hidden').Asboolean;
      theData.Floor := rSet.fieldbyname('Floor').asInteger;
      theData.Dorm := rSet.fieldbyname('Dorm').asString;
      theData.UseInNationalReport := rSet.fieldbyname('useInNationalReport').Asboolean;
      result := true;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function RoomExist(sRoom: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  s := s + 'SELECT ' + chr(10);
  s := s + 'Room ' + chr(10);
  s := s + 'FROM ' + chr(10);
  s := s + 'rooms ' + chr(10);
  s := s + 'WHERE ' + chr(10);
  s := s + 'Room = %s ';

  rSet := CreateNewDataSet;
  try
    s := format(s, [_db(sRoom)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function RoomExistsInOther(sRoom: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try

    s := '';
    s := s + 'SELECT room FROM roomreservations WHERE room = %s LIMIT 1';
    s := format(s, [quotedstr(sRoom)]);
    result := rSet_bySQL(rSet, s);
    if result then
      exit;

    s := '';
    s := s + 'SELECT room FROM roomsdate WHERE room = %s LIMIT 1';
    s := format(s, [quotedstr(sRoom)]);
    result := rSet_bySQL(rSet, s);
    if result then
      exit;


    //
    // s := format(select_currencyExistsInOther1, [quotedstr(sCurrency)]);
    // result := rSet_bySQL(rSet,s, Connection,loglevel,logpath);
    // if result then exit;
    //
    // s := format(select_currencyExistsInOther2, [quotedstr(sCurrency)]);
    // result := rSet_bySQL(rSet,s, Connection,loglevel,logpath);
    // if result then exit;
    //
    // s := format(select_currencyExistsInOther3, [quotedstr(sCurrency)]);
    // result := rSet_bySQL(rSet,s, Connection,loglevel,logpath);
    // if result then exit;
    //
    // s := format(select_currencyExistsInOther4, [quotedstr(sCurrency)]);
    // result := rSet_bySQL(rSet,s, Connection,loglevel,logpath);
    // if result then exit;
    //
    // s := format(select_currencyExistsInOther5, [quotedstr(sCurrency)]);
    // result := rSet_bySQL(rSet,s, Connection,loglevel,logpath);
    // if result then exit;
    //
    // s := format(select_currencyExistsInOther6, [quotedstr(sCurrency)]);
    // result := rSet_bySQL(rSet,s, Connection,loglevel,logpath);
    // if result then exit;

  finally
    freeandnil(rSet);
  end;
end;



// recCustomerTypeHolder = record
// ID              : integer ;
// Active          : boolean ;
// description     : string  ;
// customerType    : string  ;
// Priority        : integer ;
// end;
//

/// /////////////////////////////////////////////////////////////////

procedure initCustomerTypeHolder(var rec: recCustomerTypeHolder);
begin
  with rec do
  begin
    active := true;
    Description := '';
    customerType := '';
    Priority := 0;
  end;
end;

function Del_CustomerType(theData: recCustomerTypeHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM customertypes ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function UPD_CustomerType(theData: recCustomerTypeHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE customertypes ' + #10;
  s := s + ' SET ' + #10;
  s := s + '    Active = ' + _db(theData.active) + ' ' + #10;
  s := s + '   ,Description = ' + _db(theData.Description) + ' ' + #10;
  s := s + '   ,CustomerType = ' + _db(theData.customerType) + ' ' + #10;
  s := s + '   ,Priority = ' + _db(theData.Priority) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function INS_CustomerType(theData: recCustomerTypeHolder; var NewID: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'INSERT INTO customertypes ' + #10;
  s := s + '   ( ' + #10;
  s := s + '     Active ' + #10;
  s := s + '    ,Description ' + #10;
  s := s + '    ,CustomerType ' + #10;
  s := s + '    ,Priority ' + #10;
  s := s + '   ) ' + #10;
  s := s + '   VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '   ' + _db(theData.active) + #10;
  s := s + '  ,' + _db(theData.Description) + #10;
  s := s + '  ,' + _db(theData.customerType) + #10;
  s := s + '  ,' + _db(theData.Priority) + #10;
  s := s + '   ) ';
  result := cmd_bySQL(s);
  if result then
  begin
    NewID := GetLastID('CustomerTypes');
  end;

end;

function GET_CustomerType_ByCustomerType(var theData: recCustomerTypeHolder): boolean;
var
  rSet: TRoomerDataSet;
  sql: string;
begin
  result := false;
  rSet := CreateNewDataSet;
  try
    sql := format(select_customerType_ByCustomerType, [_db(theData.customerType)]);
    if hData.rSet_bySQL(rSet, sql) then
    begin
      theData.id := rSet.fieldbyname('ID').asInteger;
      theData.active := rSet.fieldbyname('Active').Asboolean;
      theData.Description := rSet.fieldbyname('Description').asString;
      theData.customerType := rSet.fieldbyname('CustomerType').asString;
      theData.Priority := rSet.fieldbyname('Priority').asInteger;
      result := true;
    end;
  finally
    freeandnil(rSet);
  end;

end;

function CustomerTypeExist(Code: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_CustomerTypeExists, [_db(Code)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function CustomerTypeExistsInOther(Code: string; id: integer): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := true;
  rSet := CreateNewDataSet;
  try
    s := format(select_customerTypeExistsINCustomers, [_db(Code)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      exit;
    end;
  finally
    freeandnil(rSet);
  end;
  result := false;
end;

const TABLES_WITH_CUSTOMER_CODE : Array [0..9] of String =
    ('customerpreferences,Customer',
     'customers,Customer',
     'invoiceheads,Customer',
     'payments,Customer',
     'personprofiles,CustomerCode',
     'persons,Customer',
     'reservations,Customer',
     'tbldelpersons,Customer',
     'tbldelreservations,Customer',
     'tblimportlogs,Customer');

procedure UpdateCustomerCode(oldCode, newCode : String);
begin
  UpdateCodeOfTable(TABLES_WITH_CUSTOMER_CODE, oldCode, newCode)
end;

procedure initCustomerHolder(var rec: recCustomerHolder);
begin
  with rec do
  begin
    active := true;
    Customer := '';
    Surname := '';
    Name := '';
    PID := '';
    customerType := '';
    Address1 := '';
    Address2 := '';
    Address3 := '';
    Address4 := '';
    Country := '';
    Tel1 := '';
    Tel2 := '';
    Fax := '';
    DiscountPercent := 0;
    EmailAddress := '';
    ContactPerson := '';
    TravelAgency := false;
    Currency := '';
    dele := '';
    pcID := 0;
    HomePage := '';
    CountryName := '';
    CustomerTypeDescription := '';
    pcCode := '';
    StayTaxIncluted := ctrlGetBoolean('stayTaxIncluted');
    notes := '';
    RatePlanId := 0;
  end;
end;

function Del_Customer(theData: recCustomerHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM customers ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function UPD_Customer(theData: recCustomerHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE customers ' + #10;
  s := s + ' SET ' + #10;
  s := s + '    Active = ' + _db(theData.active) + ' ' + #10;
  s := s + '   ,Customer = ' + _db(theData.Customer) + ' ' + #10;
  s := s + '   ,Surname = ' + _db(theData.Surname) + ' ' + #10;
  s := s + '   ,Name = ' + _db(theData.name) + ' ' + #10;
  s := s + '   ,PID = ' + _db(theData.PID) + ' ' + #10;
  s := s + '   ,CustomerType = ' + _db(theData.customerType) + ' ' + #10;
  s := s + '   ,Address1 = ' + _db(theData.Address1) + ' ' + #10;
  s := s + '   ,Address2 = ' + _db(theData.Address2) + ' ' + #10;
  s := s + '   ,Address3 = ' + _db(theData.Address3) + ' ' + #10;
  s := s + '   ,Address4 = ' + _db(theData.Address4) + ' ' + #10;
  s := s + '   ,Country = ' + _db(theData.Country) + ' ' + #10;
  s := s + '   ,Tel1 = ' + _db(theData.Tel1) + ' ' + #10;
  s := s + '   ,Tel2 = ' + _db(theData.Tel2) + ' ' + #10;
  s := s + '   ,Fax  = ' + _db(theData.Fax) + ' ' + #10;
  s := s + '   ,DiscountPercent = ' + _db(theData.DiscountPercent) + ' ' + #10;
  s := s + '   ,EmailAddress = ' + _db(theData.EmailAddress) + ' ' + #10;
  s := s + '   ,ContactPerson = ' + _db(theData.ContactPerson) + ' ' + #10;
  s := s + '   ,TravelAgency = ' + _db(theData.TravelAgency) + ' ' + #10;
  s := s + '   ,Currency = ' + _db(theData.Currency) + ' ' + #10;
  s := s + '   ,dele = ' + _db(theData.dele) + ' ' + #10;
  s := s + '   ,pcID = ' + _db(theData.pcID) + ' ' + #10;
  s := s + '   ,Homepage = ' + _db(theData.HomePage) + ' ' + #10;
  s := s + '   ,stayTaxIncluted = ' + _db(theData.StayTaxIncluted) + ' ' + #10;
  s := s + '   ,notes = ' + _db(theData.notes) + ' ' + #10;
  s := s + '   ,RatePlanId = ' + _db(theData.RatePlanId) + ' ' + #10;

  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function INS_Customer(theData: recCustomerHolder; var NewID: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'INSERT INTO customers ' + #10;
  s := s + '   ( ' + #10;
  s := s + '     Active ' + #10;
  s := s + '    ,Customer ' + #10;
  s := s + '    ,Surname ' + #10;
  s := s + '    ,Name ' + #10;
  s := s + '    ,PID ' + #10;
  s := s + '    ,CustomerType ' + #10;
  s := s + '    ,Address1 ' + #10;
  s := s + '    ,Address2 ' + #10;
  s := s + '    ,Address3 ' + #10;
  s := s + '    ,Address4 ' + #10;
  s := s + '    ,Country ' + #10;
  s := s + '    ,Tel1 ' + #10;
  s := s + '    ,Tel2 ' + #10;
  s := s + '    ,Fax ' + #10;
  s := s + '    ,DiscountPercent ' + #10;
  s := s + '    ,EmailAddress ' + #10;
  s := s + '    ,ContactPerson ' + #10;
  s := s + '    ,TravelAgency ' + #10;
  s := s + '    ,Currency ' + #10;
  s := s + '    ,dele ' + #10;
  s := s + '    ,pcID ' + #10;
  s := s + '    ,Homepage ' + #10;
  s := s + '    ,stayTaxIncluted ' + #10;
  s := s + '    ,notes ' + #10;
  s := s + '    ,RatePlanId ' + #10;
  s := s + '   ) ' + #10;
  s := s + '   VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '   ' + _db(theData.active) + #10;
  s := s + '  ,' + _db(theData.Customer) + #10;
  s := s + '  ,' + _db(theData.Surname) + #10;
  s := s + '  ,' + _db(theData.name) + #10;
  s := s + '  ,' + _db(theData.PID) + #10;
  s := s + '  ,' + _db(theData.customerType) + #10;
  s := s + '  ,' + _db(theData.Address1) + #10;
  s := s + '  ,' + _db(theData.Address2) + #10;
  s := s + '  ,' + _db(theData.Address3) + #10;
  s := s + '  ,' + _db(theData.Address4) + #10;
  s := s + '  ,' + _db(theData.Country) + #10;
  s := s + '  ,' + _db(theData.Tel1) + #10;
  s := s + '  ,' + _db(theData.Tel2) + #10;
  s := s + '  ,' + _db(theData.Fax) + #10;
  s := s + '  ,' + _db(theData.DiscountPercent) + #10;
  s := s + '  ,' + _db(theData.EmailAddress) + #10;
  s := s + '  ,' + _db(theData.ContactPerson) + #10;
  s := s + '  ,' + _db(theData.TravelAgency) + #10;
  s := s + '  ,' + _db(theData.Currency) + #10;
  s := s + '  ,' + _db(theData.dele) + #10;
  s := s + '  ,' + _db(theData.pcID) + #10;
  s := s + '  ,' + _db(theData.HomePage) + #10;
  s := s + '  ,' + _db(theData.StayTaxIncluted) + #10;
  s := s + '  ,' + _db(theData.notes) + #10;
  s := s + '  ,' + _db(theData.RatePlanId) + #10;
  s := s + '   ) ';
  result := cmd_bySQL(s);
  if result then
  begin
    NewID := GetLastID('customers');
  end;

end;

function GET_Customer_ByCustomer(var theData: recCustomerHolder): boolean;
var
  rSet: TRoomerDataSet;
  sql: string;
begin
  result := false;
  rSet := CreateNewDataSet;
  try
    sql := format(select_CustomerPlus, [_db(theData.Customer)]);
    if hData.rSet_bySQL(rSet, sql) then
    begin
      theData.id := rSet.fieldbyname('ID').asInteger;
      theData.active := rSet.fieldbyname('Active').Asboolean;
      theData.Customer := rSet.fieldbyname('Customer').asString;
      theData.Surname := rSet.fieldbyname('Surname').asString;
      theData.name := rSet.fieldbyname('Name').asString;
      theData.PID := rSet.fieldbyname('PID').asString;
      theData.customerType := rSet.fieldbyname('CustomerType').asString;
      theData.Address1 := rSet.fieldbyname('Address1').asString;
      theData.Address2 := rSet.fieldbyname('Address2').asString;
      theData.Address3 := rSet.fieldbyname('Address3').asString;
      theData.Address4 := rSet.fieldbyname('Address4').asString;
      theData.Country := rSet.fieldbyname('Country').asString;
      theData.Tel1 := rSet.fieldbyname('Tel1').asString;
      theData.Tel2 := rSet.fieldbyname('Tel2').asString;
      theData.Fax := rSet.fieldbyname('Fax').asString;
      theData.DiscountPercent := rSet.GetFloatValue(rSet.fieldbyname('DiscountPercent'));
      theData.EmailAddress := rSet.fieldbyname('EmailAddress').asString;
      theData.ContactPerson := rSet.fieldbyname('ContactPerson').asString;
      theData.TravelAgency := rSet.fieldbyname('TravelAgency').Asboolean;
      theData.Currency := rSet.fieldbyname('Currency').asString;
      theData.dele := rSet.fieldbyname('dele').asString;
      theData.pcID := rSet.fieldbyname('pcID').asInteger;
      theData.HomePage := rSet.fieldbyname('Homepage').asString;
      theData.CountryName := rSet.fieldbyname('CountryName').asString;
      theData.CustomerTypeDescription := rSet.fieldbyname('CustomerTypeDescription').asString;
      theData.pcCode := rSet.fieldbyname('pcCode').asString;
      theData.StayTaxIncluted := rSet.fieldbyname('stayTaxIncluted').Asboolean;
      theData.notes := rSet.fieldbyname('notes').AsString;
      theData.RatePlanId := rSet.fieldbyname('RatePlanId').AsInteger;
      result := true;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function CustomerExist(Customer: string): boolean;
//var
//  s: string;
//  rSet: TRoomerDataSet;
begin
  result := glb.LocateSpecificRecord('customers', 'Customer', Customer);
//  result := false;
//  rSet := CreateNewDataSet;
//  try
//    s := format(select_CustomerExists, [_db(Customer)]);
//    result := rSet_bySQL(rSet, s);
//  finally
//    freeandnil(rSet);
//  end;
end;

function GetCustomerId(Customer: string): integer;
//var
//  s: string;
//  rSet: TRoomerDataSet;
begin
  result := 0;
  if glb.LocateSpecificRecord('customers', 'Customer', Customer) then
    result := glb.CustomersSet['id'];
//  result := 0;
//  rSet := CreateNewDataSet;
//  try
//    s := format('SELECT id FROM customers WHERE customer=%s', [_db(Customer)]);
//    if rSet_bySQL(rSet, s) then
//      result := rSet.fieldbyname('id').asInteger;
//  finally
//    freeandnil(rSet);
//  end;
end;


function CustomerExistsInOther(Customer: string; id : integer = 0): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := '';
    s := s+ ' SELECT customer FROM reservations ';
    s := s+ ' WHERE (customer = %s ) ';
    s := format(s, [_db(customer)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := true;
      exit;
    end;

    s := '';
    s := s+ ' SELECT customer FROM invoiceheads ';
    s := s+ ' WHERE (customer = %s ) ';
    s := format(s, [_db(customer)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := true;
      exit;
    end;

    if id >0 then
    begin
      s := '';
      s := s+ ' SELECT customerID FROM channels ';
      s := s+ ' WHERE (id = '+_db(id)+' ) ';
      s := format(s, [_db(customer)]);
      if hData.rSet_bySQL(rSet, s) then
      begin
        result := true;
        exit;
      end;
    end;

  finally
    freeandnil(rSet);
  end;
  result := false;
end;


/// /////////////////////////////////////////////////////
// recStaffTypeHolder = record
// ID                : integer ;
// Active            : boolean ;
// description       : string  ;
// StaffType         : string  ;
// AccessPrivilidges : integer ;
// end;
/// ///////////////////////////////////////////////////////

procedure initStaffTypeHolder(var rec: recStaffTypeHolder);
begin
  with rec do
  begin
    active := true;
    Description := '';
    StaffType := '';
    AccessPrivilidges := 0;
    AuthValue := 0
  end;
end;

function Del_StaffType(theData: recStaffTypeHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM stafftypes ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function UPD_StaffType(theData: recStaffTypeHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE stafftypes ' + #10;
  s := s + ' SET ' + #10;
  s := s + '    Active = ' + _db(theData.active) + ' ' + #10;
  s := s + '   ,Description = ' + _db(theData.Description) + ' ' + #10;
  s := s + '   ,StaffType = ' + _db(theData.StaffType) + ' ' + #10;
  s := s + '   ,AccessPrivilidges = ' + _db(theData.AccessPrivilidges) + ' ' + #10;
  s := s + '   ,AuthValue = ' + _db(theData.AuthValue) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function INS_StaffType(theData: recStaffTypeHolder; var NewID: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'INSERT INTO stafftypes ' + #10;
  s := s + '   ( ' + #10;
  s := s + '     Active ' + #10;
  s := s + '    ,Description ' + #10;
  s := s + '    ,StaffType ' + #10;
  s := s + '    ,AccessPrivilidges ' + #10;
  s := s + '    ,AuthValue ' + #10;
  s := s + '   ) ' + #10;
  s := s + '   VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '   ' + _db(theData.active) + #10;
  s := s + '  ,' + _db(theData.Description) + #10;
  s := s + '  ,' + _db(theData.StaffType) + #10;
  s := s + '  ,' + _db(theData.AccessPrivilidges) + #10;
  s := s + '  ,' + _db(theData.AuthValue) + #10;
  s := s + '   ) ';
  result := cmd_bySQL(s);
  if result then
  begin
    NewID := GetLastID('StaffTypes');
  end;

end;

function GET_StaffType_ByStaffType(var theData: recStaffTypeHolder): boolean;
var
  rSet: TRoomerDataSet;
  sql: string;
begin
  result := false;
  rSet := CreateNewDataSet;
  try
    sql := format(select_StaffType_ByStaffType, [_db(theData.StaffType)]);
    if hData.rSet_bySQL(rSet, sql) then
    begin
      theData.id := rSet.fieldbyname('ID').asInteger;
      theData.active := rSet.fieldbyname('Active').Asboolean;
      theData.Description := rSet.fieldbyname('Description').asString;
      theData.StaffType := rSet.fieldbyname('StaffType').asString;
      theData.AccessPrivilidges := rSet.fieldbyname('AccessPrivilidges').asInteger;
      theData.AuthValue := rSet.fieldbyname('AuthValue').asInteger;
      result := true;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function StaffTypeExist(Code: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_StaffTypeExist, [_db(Code)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

/// /////////////////////////////////////////////////////////////////////////////////////
// ID               : integer ;
// Active           : boolean ;
// Initials         : string  ;
// Password         : string  ;
// StaffPID         : string  ;
// Name             : string  ;
// Address1         : string  ;
// Address2         : string  ;
// Address3         : string  ;
// Address4         : string  ;
// Country          : string  ;
// Tel1             : string  ;
// Tel2             : string  ;
// Fax              : string  ;
// ActiveMember     : boolean ;
// StaffLanguage    : integer ;
// StaffType        : string  ;
// StaffType1       : string  ;
// StaffType2       : string  ;
// StaffType3       : string  ;
// StaffType4       : string  ;

procedure initStaffMemberHolder(var rec: recStaffMemberHolder);
begin
  with rec do
  begin
    // ID               :
    active := true;
    Initials := '';
    Password := '';
    StaffPID := '';
    Name := '';
    Address1 := '';
    Address2 := '';
    Address3 := '';
    Address4 := '';
    Country := '';
    Tel1 := '';
    Tel2 := '';
    Fax := '';
    ActiveMember := true;
    StaffLanguage := 0;
    StaffType := '';
    StaffType1 := '';
    StaffType2 := '';
    StaffType3 := '';
    StaffType4 := '';
    IPAddresses := '';
    WindowsAuth := false;
    PmsOnly := false;

  end;
end;

function Del_StaffMember(theData: recStaffMemberHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM staffmembers ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function UPD_Staffmember(theData: recStaffMemberHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE staffmembers ' + #10;
  s := s + ' SET ' + #10;
  s := s + '    Active        = ' + _db(theData.active) + ' ' + #10;
  s := s + '  , Initials      = ' + _db(theData.Initials) + ' ' + #10;
  s := s + '  , Password      = ' + _db(theData.Password) + ' ' + #10;
  s := s + '  , StaffPID      = ' + _db(theData.StaffPID) + ' ' + #10;
  s := s + '  , Name          = ' + _db(theData.name) + ' ' + #10;
  s := s + '  , Address1      = ' + _db(theData.Address1) + ' ' + #10;
  s := s + '  , Address2      = ' + _db(theData.Address2) + ' ' + #10;
  s := s + '  , Address3      = ' + _db(theData.Address3) + ' ' + #10;
  s := s + '  , Address4      = ' + _db(theData.Address4) + ' ' + #10;
  s := s + '  , Country       = ' + _db(theData.Country) + ' ' + #10;
  s := s + '  , Tel1          = ' + _db(theData.Tel1) + ' ' + #10;
  s := s + '  , Tel2          = ' + _db(theData.Tel2) + ' ' + #10;
  s := s + '  , Fax           = ' + _db(theData.Fax) + ' ' + #10;
  s := s + '  , ActiveMember  = ' + _db(theData.ActiveMember) + ' ' + #10;
  s := s + '  , StaffLanguage = ' + _db(theData.StaffLanguage) + ' ' + #10;
  s := s + '  , StaffType     = ' + _dbNullIfEmpty(theData.StaffType) + ' ' + #10;
  s := s + '  , StaffType1    = ' + _dbNullIfEmpty(theData.StaffType1) + ' ' + #10;
  s := s + '  , StaffType2    = ' + _dbNullIfEmpty(theData.StaffType2) + ' ' + #10;
  s := s + '  , StaffType3    = ' + _dbNullIfEmpty(theData.StaffType3) + ' ' + #10;
  s := s + '  , StaffType4    = ' + _dbNullIfEmpty(theData.StaffType4) + ' ' + #10;
  s := s + '  , IPAddresses   = ' + _db(theData.IPAddresses) + ' ' + #10;
  s := s + '  , PMSOnly       = ' + _db(theData.PmsOnly) + ' ' + #10;
  s := s + '  , WindowsAuth   = ' + _db(theData.WindowsAuth) + ' ' + #10;

  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function UPD_StaffMember_StaffType1(theData: recStaffMemberHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE staffmembers ' + #10;
  s := s + ' SET ' + #10;
  s := s + '  StaffType1 = ' + _db(theData.StaffType1) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function INS_StaffMember(theData: recStaffMemberHolder; var NewID: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'INSERT INTO staffmembers ' + #10;
  s := s + '   ( ' + #10;
  s := s + '    Active ' + #10;
  s := s + '   ,Initials ' + #10;
  s := s + '   ,Password ' + #10;
  s := s + '   ,StaffPID ' + #10;
  s := s + '   ,Name ' + #10;
  s := s + '   ,Address1 ' + #10;
  s := s + '   ,Address2 ' + #10;
  s := s + '   ,Address3 ' + #10;
  s := s + '   ,Address4 ' + #10;
  s := s + '   ,Country ' + #10;
  s := s + '   ,Tel1 ' + #10;
  s := s + '   ,Tel2 ' + #10;
  s := s + '   ,Fax ' + #10;
  s := s + '   ,ActiveMember ' + #10;
  s := s + '   ,StaffLanguage ' + #10;
  s := s + '   ,StaffType ' + #10;
  s := s + '   ,StaffType1 ' + #10;
  s := s + '   ,StaffType2 ' + #10;
  s := s + '   ,StaffType3 ' + #10;
  s := s + '   ,StaffType4 ' + #10;
  s := s + '   ,IPAddresses ' + #10;
  // = ' + _db(theData.IPAddresses  ) + ' '+#10;
  s := s + '   ,PMSOnly     ' + #10; // = ' + _db(theData.PmsOnly  ) + ' '+#10;
  s := s + '   ,WindowsAuth ' + #10;
  // = ' + _db(theData.WindowsAuth ) + ' '+#10;

  s := s + '   ) ' + #10;
  s := s + '   VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '   ' + _db(theData.active) + #10;
  s := s + '  ,' + _db(theData.Initials) + #10;
  s := s + '  ,' + _db(theData.Password) + #10;
  s := s + '  ,' + _db(theData.StaffPID) + #10;
  s := s + '  ,' + _db(theData.name) + #10;
  s := s + '  ,' + _db(theData.Address1) + #10;
  s := s + '  ,' + _db(theData.Address2) + #10;
  s := s + '  ,' + _db(theData.Address3) + #10;
  s := s + '  ,' + _db(theData.Address4) + #10;
  s := s + '  ,' + _db(theData.Country) + #10;
  s := s + '  ,' + _db(theData.Tel1) + #10;
  s := s + '  ,' + _db(theData.Tel2) + #10;
  s := s + '  ,' + _db(theData.Fax) + #10;
  s := s + '  ,' + _db(theData.ActiveMember) + #10;
  s := s + '  ,' + _db(theData.StaffLanguage) + #10;
  s := s + '  ,' + _dbNullIfEmpty(theData.StaffType) + #10;
  s := s + '  ,' + _dbNullIfEmpty(theData.StaffType1) + #10;
  s := s + '  ,' + _dbNullIfEmpty(theData.StaffType2) + #10;
  s := s + '  ,' + _dbNullIfEmpty(theData.StaffType3) + #10;
  s := s + '  ,' + _dbNullIfEmpty(theData.StaffType4) + #10;
  s := s + '  ,' + _db(theData.IPAddresses) + #10;
  s := s + '  ,' + _db(theData.PmsOnly) + #10;
  s := s + '  ,' + _db(theData.WindowsAuth) + #10;
  s := s + '   ) ';
  result := cmd_bySQL(s);
  if result then
  begin
    NewID := GetLastID('staffmembers');
  end;
end;

function GET_StaffMember_ByInitials(var theData: recStaffMemberHolder): boolean;
var
  rSet: TRoomerDataSet;
  sql: string;
  s: string;
begin
  result := false;
  rSet := CreateNewDataSet;
  try

    sql := ' SELECT '#10 + ' ID '#10 + ' ,Active '#10 + ' ,Initials '#10 + ' ,Password '#10 + ' ,StaffPID '#10 + ' ,Name '#10 + ' ,Address1 '#10 +
      ' ,Address2 '#10 + ' ,Address3 '#10 + ' ,Address4 '#10 + ' ,Country '#10 + ' ,Tel1 '#10 + ' ,Tel2 '#10 + ' ,Fax '#10 + ' ,ActiveMember '#10 +
      ' ,StaffLanguage '#10 + ' ,StaffType '#10 + ' ,StaffType1 '#10 + ' ,StaffType2 '#10 + ' ,StaffType3 '#10 + ' ,StaffType4 '#10 + ' ,IPAddresses '#10 +
      ' ,PmsOnly '#10 + ' ,WindowsAuth '#10 + ' FROM staffmembers  '#10 + ' WHERE  '#10 + ' (Initials =  %s ) ';

    s := format(sql, [_db(theData.Initials)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      theData.id := rSet.fieldbyname('ID').asInteger;
      theData.active := rSet.fieldbyname('Active').Asboolean;
      theData.Initials := rSet.fieldbyname('Initials').asString;
      theData.Password := rSet.fieldbyname('Password').asString;
      theData.StaffPID := rSet.fieldbyname('StaffPID').asString;
      theData.name := rSet.fieldbyname('Name').asString;
      theData.Address1 := rSet.fieldbyname('Address1').asString;
      theData.Address2 := rSet.fieldbyname('Address2').asString;
      theData.Address3 := rSet.fieldbyname('Address3').asString;
      theData.Address4 := rSet.fieldbyname('Address4').asString;
      theData.Country := rSet.fieldbyname('Country').asString;
      theData.Tel1 := rSet.fieldbyname('Tel1').asString;
      theData.Tel2 := rSet.fieldbyname('Tel2').asString;
      theData.Fax := rSet.fieldbyname('Fax').asString;
      theData.ActiveMember := rSet.fieldbyname('ActiveMember').Asboolean;
      theData.StaffLanguage := rSet.fieldbyname('StaffLanguage').asInteger;
      theData.StaffType := rSet.fieldbyname('StaffType').asString;
      theData.StaffType1 := rSet.fieldbyname('StaffType1').asString;
      theData.StaffType2 := rSet.fieldbyname('StaffType2').asString;
      theData.StaffType3 := rSet.fieldbyname('StaffType3').asString;
      theData.StaffType4 := rSet.fieldbyname('StaffType4').asString;
      theData.IPAddresses := rSet.fieldbyname('IPAddresses').asString;
      theData.PmsOnly := rSet.fieldbyname('PmsOnly').Asboolean;
      theData.WindowsAuth := rSet.fieldbyname('WindowsAuth').Asboolean;
      result := true;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function StaffMemberIsAdmin_ByInitials(Initials: string): boolean;
var
  rSet: TRoomerDataSet;
  sql: string;
  s: string;
begin
  result := false;
  rSet := CreateNewDataSet;
  try
    sql := ' SELECT '#10 + '  ID '#10 + ' ,StaffType '#10 + ' ,StaffType1 '#10 + ' ,StaffType2 '#10 + ' ,StaffType3 '#10 + ' ,StaffType4 '#10 +
      ' FROM staffmembers  '#10 + ' WHERE  '#10 + ' (Initials =  %s ) ';

    s := format(sql, [_db(Initials)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      if LowerCase(rSet.fieldbyname('StaffType').asString) = 'admin' then
        result := true;
      if LowerCase(rSet.fieldbyname('StaffType1').asString) = 'admin' then
        result := true;
      if LowerCase(rSet.fieldbyname('StaffType2').asString) = 'admin' then
        result := true;
      if LowerCase(rSet.fieldbyname('StaffType3').asString) = 'admin' then
        result := true;
      if LowerCase(rSet.fieldbyname('StaffType4').asString) = 'admin' then
        result := true;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function StaffMemberExist(Initials: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_StaffMemberExists, [_db(Initials)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function InitialsExistsInOther(sCode: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_StaffMemberExistsInOther, [quotedstr(sCode)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

/// ///////////////////////////////////////////////////////////////////////
// recChannelHolder
//
// ID                     : integer ;
// Active                 : boolean ;
// name                   : string  ;
// channelManagerId       : string  ;
// minAlotment            : integer ;
// defaultAvailability    : integer ;
// defaultPricePP         : double  ;
// marketSegment          : string  ;
// currencyId             : integer ;
// managedByChannelManager: boolean ;
// default                : boolean ;
/// //////////////////////////////////////////////////////////////////////////////

procedure initChannelHolder(var rec: recChannelHolder);
begin
  with rec do
  begin
    // ID
    active := false;
    name := '';
    channelManagerId := '';
    minAlotment := 0;
    defaultAvailability := 0;
    defaultPricePP := 0;
    marketSegment := '';
    CurrencyID := 0;
    managedByChannelManager := false;
    CHANNEL_ARRANGES_PAYMENT := false;
    defaultChannel := false;
    push := false;
    customerId := 0;
    color := '15793151';
    Rounding := 1;
    roomClasses := '';
    hotelsBookingEngine := false;
    compensationPercentage := 0;
    directConnection := false;
    activePlanCode := 0;
    ratesExcludingTaxes := False;
  end;
end;

function Del_Channel(theData: recChannelHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'DELETE ' + chr(10);
  s := s + '   FROM channels ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function UPD_Channel(theData: recChannelHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'UPDATE channels ' + #10;
  s := s + ' SET ' + #10;
  s := s + '   Active                   = ' + _db(theData.active) + ' ' + #10;
  s := s + '  ,name                     = ' + _db(theData.name) + ' ' + #10;
  s := s + '  ,channelManagerId         = ' + _db(theData.channelManagerId) + ' ' + #10;
  s := s + '  ,minAlotment              = ' + _db(theData.minAlotment) + ' ' + #10;
  s := s + '  ,defaultAvailability      = ' + _db(theData.defaultAvailability) + ' ' + #10;
  s := s + '  ,defaultPricePP           = ' + _db(theData.defaultPricePP) + ' ' + #10;
  s := s + '  ,marketSegment            = ' + _db(theData.marketSegment) + ' ' + #10;
  s := s + '  ,currencyId               = ' + _db(theData.CurrencyID) + ' ' + #10;
  s := s + '  ,managedByChannelManager  = ' + _db(theData.managedByChannelManager) + ' ' + #10;
  s := s + '  ,CHANNEL_ARRANGES_PAYMENT = ' + _db(theData.CHANNEL_ARRANGES_PAYMENT) + ' ' + #10;
  s := s + '  ,push                     = ' + _db(theData.push) + ' ' + #10;
  s := s + '  ,customerId               = ' + _db(theData.customerId) + ' ' + #10;
  s := s + '  ,color                    = ' + _db(theData.color) + ' ' + #10;
  s := s + '  ,rateRoundingType         = ' + _db(theData.Rounding) + ' ' + #10;
  s := s + '  ,hotelsBookingEngine      = ' + _db(theData.hotelsBookingEngine) + ' ' + #10;
  s := s + '  ,compensationPercentage   = ' + _db(theData.compensationPercentage) + ' ' + #10;
  s := s + '  ,`defaultChannel`         = ' + _db(theData.defaultChannel) + ' ' + #10;
  s := s + '  ,`directConnection`         = ' + _db(theData.directConnection) + ' ' + #10;
  s := s + '  ,`activePlanCode`         = ' + _db(theData.activePlanCode) + ' ' + #10;
  s := s + '  ,`ratesExcludingTaxes`    = ' + _db(theData.ratesExcludingTaxes) + ' ' + #10;

  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function INS_Channel(theData: recChannelHolder; var NewID: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'INSERT INTO channels ' + #10;
  s := s + '   ( ' + #10;
  s := s + '    `Active` ' + #10;
  s := s + '   ,`name` ' + #10;
  s := s + '   ,`channelManagerId` ' + #10;
  s := s + '   ,`minAlotment` ' + #10;
  s := s + '   ,`defaultAvailability` ' + #10;
  s := s + '   ,`defaultPricePP` ' + #10;
  s := s + '   ,`marketSegment` ' + #10;
  s := s + '   ,`currencyId` ' + #10;
  s := s + '   ,`managedByChannelManager` ' + #10;
  s := s + '   ,`CHANNEL_ARRANGES_PAYMENT` ' + #10;
  s := s + '   ,`defaultChannel` ' + #10;
  s := s + '   ,`push` ' + #10;
  s := s + '   ,`customerId` ' + #10;
  s := s + '   ,`rateRoundingType` ' + #10;
  s := s + '   ,`color` ' + #10;
  s := s + '   ,`hotelsBookingEngine` ' + #10;
  s := s + '   ,`compensationPercentage` ' + #10;
  s := s + '   ,`directConnection` ' + #10;
  s := s + '   ,`activePlanCode` ' + #10;
  s := s + '   ,`ratesExcludingTaxes` ' + #10;

  s := s + '   ) ' + #10;
  s := s + '   VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '   ' + _db(theData.active) + #10;
  s := s + '  ,' + _db(theData.name) + #10;
  s := s + '  ,' + _db(theData.channelManagerId) + #10;
  s := s + '  ,' + _db(theData.minAlotment) + #10;
  s := s + '  ,' + _db(theData.defaultAvailability) + #10;
  s := s + '  ,' + _db(theData.defaultPricePP) + #10;
  s := s + '  ,' + _db(theData.marketSegment) + #10;
  s := s + '  ,' + _db(theData.CurrencyID) + #10;
  s := s + '  ,' + _db(theData.managedByChannelManager) + #10;
  s := s + '  ,' + _db(theData.CHANNEL_ARRANGES_PAYMENT) + #10;
  s := s + '  ,' + _db(theData.defaultChannel) + #10;
  s := s + '  ,' + _db(theData.push) + #10;
  s := s + '  ,' + _db(theData.customerId) + #10;
  s := s + '  ,' + _db(theData.Rounding) + #10;
  s := s + '  ,' + _db(theData.color) + #10;
  s := s + '  ,' + _db(theData.hotelsBookingEngine) + #10;
  s := s + '  ,' + _db(theData.compensationPercentage) + #10;
  s := s + '  ,' + _db(theData.directConnection) + #10;
  s := s + '  ,' + _db(theData.activePlanCode) + #10;
  s := s + '  ,' + _db(theData.ratesExcludingTaxes) + #10;
  s := s + '   ) ';
  result := cmd_bySQL(s);
  if result then
  begin
    NewID := GetLastID('channels');
  end;

end;

function channelManager_GetDefaultCode: String;
var
  rSet: TRoomerDataSet;
begin
  result := '';
  rSet := glb.GetDataSetFromDictionary('channelmanagers');
  rSet.First;
  if glb.ChannelsSet.Locate('active', 1, []) then
  begin
    result := rSet.fieldbyname('code').asString;
  end;
end;


function channels_GetDefaultCode: String;
begin
  result := '';
  glb.ChannelsSet.First;
  if glb.ChannelsSet.Locate('defaultchannel', 1, []) then
  begin
    result := glb.ChannelsSet.fieldbyname('channelManagerId').asString;
  end;
end;

function channels_GetDefault: integer;
begin
  result := 0;
  glb.ChannelsSet.First;
  if glb.ChannelsSet.Locate('defaultchannel', 1, []) then
  begin
    result := glb.ChannelsSet.fieldbyname('ID').asInteger;
  end;
end;

function ChannelExist(channelManagerId: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_ChannelExists, [_db(channelManagerId)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

/// ///////////////////////////////////////////////////////////////////////////
// systemservers
// ----------------------------------
// ID                     : integer ;
// Active                 : boolean ;
// description            : string  ; //30
// server                 : string  ; //128
// port                   : integer ;
// username               : string  ; //64
// password               : string  ; //128
// authenticate           : boolean ;
// ssl                    : boolean ;
/// ///////////////////////////////////////////////////////////////////////////

procedure initsystemserverHolder(var rec: recSystemServerHolder);
begin
  with rec do
  begin
    // ID
    active := true;
    Description := '';
    server := '';
    port := 0;
    username := '';
    Password := '';
    authenticate := false;
    ssl := false;
  end;
end;

function Del_systemserver(theData: recSystemServerHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM systemservers ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function UPD_systemserver(theData: recSystemServerHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE systemservers ' + #10;
  s := s + ' SET ' + #10;
  s := s + '   `Active` = ' + _db(theData.active) + ' ' + #10;
  s := s + '  ,`description` = ' + _db(theData.Description) + ' ' + #10;
  s := s + '  ,`server` = ' + _db(theData.server) + ' ' + #10;
  s := s + '  ,`port` = ' + _db(theData.port) + ' ' + #10;
  s := s + '  ,`username` = ' + _db(theData.username) + ' ' + #10;
  s := s + '  ,`password` = ' + _db(theData.Password) + ' ' + #10;
  s := s + '  ,`authenticate` = ' + _db(theData.authenticate) + ' ' + #10;
  s := s + '  ,`ssl` = ' + _db(theData.ssl) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function INS_systemserver(theData: recSystemServerHolder; var NewID: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'INSERT INTO systemservers ' + #10;
  s := s + '   ( ' + #10;
  s := s + '    `Active` ' + #10;
  s := s + '   ,`description` ' + #10;
  s := s + '   ,`server` ' + #10;
  s := s + '   ,`port` ' + #10;
  s := s + '   ,`username` ' + #10;
  s := s + '   ,`password` ' + #10;
  s := s + '   ,`authenticate`' + #10;
  s := s + '   ,`ssl` ' + #10;
  s := s + '   ) ';
  s := s + '   VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '   ' + _db(theData.active) + #10;
  s := s + '  ,' + _db(theData.Description) + #10;
  s := s + '  ,' + _db(theData.server) + #10;
  s := s + '  ,' + _db(theData.port) + #10;
  s := s + '  ,' + _db(theData.username) + #10;
  s := s + '  ,' + _db(theData.Password) + #10;
  s := s + '  ,' + _db(theData.authenticate) + #10;
  s := s + '  ,' + _db(theData.ssl) + #10;
  s := s + '   ) ';
  result := cmd_bySQL(s);
  if result then
  begin
    NewID := GetLastID('systemservers');
  end;

end;

/// ///////////////////////////////////////////////////////////////////////////
// systemactions
// -------------------------------------------
// ID                     : integer ;
// Active                 : boolean ;
// description            : string  ; //30
// aTtype                 : integer ;
// systemserver           : integer ;
// recipient              : string  ; //128
// sender                 : string  ; //128
// SystemAction                : string  ; //4096
// content                : string  ; //4096
// richcontent            : boolean ;
// contentfile            : string  ;
/// ///////////////////////////////////////////////////////////////////////////

procedure initSystemActionHolder(var rec: recSystemActionHolder);
begin
  with rec do
  begin
    // ID           := ;
    active := true;
    Description := '';
    aType := 0;
    systemserver := 0; // link to table
    recipient := '';
    sender := '';
    // subject      := ''    ;
    // content      := ''    ;
    // richcontent  := false ;
    // contentfile  := ''    ;
    server := '';
  end;
end;

function Del_SystemAction(theData: recSystemActionHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM systemactions ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function UPD_SystemAction(theData: recSystemActionHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE systemactions ' + #10;
  s := s + ' SET ' + #10;
  s := s + '   `Active`        = ' + _db(theData.active) + ' ' + #10;
  s := s + '  ,`description`   = ' + _db(theData.Description) + ' ' + #10;
  s := s + '  ,`Type`          = ' + _db(theData.aType) + ' ' + #10;
  s := s + '  ,`systemserver`  = ' + _db(theData.systemserver) + ' ' + #10;
  s := s + '  ,`recipient`     = ' + _db(theData.recipient) + ' ' + #10;
  s := s + '  ,`sender`        = ' + _db(theData.sender) + ' ' + #10;
  // s := s + '  ,`subject`       = ' + _db(theData.subject      ) + ' '+#10;
  // s := s + '  ,`content`       = ' + _db(theData.content      ) + ' '+#10;
  // s := s + '  ,`richcontent`   = ' + _db(theData.richcontent  ) + ' '+#10;
  // s := s + '  ,`contentfile`   = ' + _db(theData.contentfile  ) + ' '+#10;
  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function UPD_systemaction_justDetails(id: integer; subject, content, contentfile: string; richcontent: boolean): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE systemactions ' + #10;
  s := s + ' SET ' + #10;
  s := s + '   `subject`       = ' + _db(subject) + ' ' + #10;
  s := s + '  ,`content`       = ' + _db(content) + ' ' + #10;
  s := s + '  ,`richcontent`   = ' + _db(richcontent) + ' ' + #10;
  s := s + '  ,`contentfile`   = ' + _db(contentfile) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(id) + ') ';
  result := cmd_bySQL(s);
end;

function INS_SystemAction(theData: recSystemActionHolder; var NewID: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'INSERT INTO systemactions ' + #10;
  s := s + '   ( ' + #10;
  s := s + '    `Active`      ' + #10;
  s := s + '   ,`description` ' + #10;
  s := s + '   ,`Type`        ' + #10;
  s := s + '   ,`systemserver`' + #10;
  s := s + '   ,`recipient`   ' + #10;
  s := s + '   ,`sender`      ' + #10;
  // s := s+'   ,`subject`     '+#10;
  // s := s+'   ,`content`     '+#10;
  // s := s+'   ,`richcontent` '+#10;
  // s := s+'   ,`contentfile` '+#10;
  s := s + '   ) ' + #10;
  s := s + '   VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '   ' + _db(theData.active) + #10;
  s := s + '  ,' + _db(theData.Description) + #10;
  s := s + '  ,' + _db(theData.aType) + #10;
  s := s + '  ,' + _db(theData.systemserver) + #10;
  s := s + '  ,' + _db(theData.recipient) + #10;
  s := s + '  ,' + _db(theData.sender) + #10;
  // s := s+'  ,'  + _db(theData.subject     )+#10;
  // s := s+'  ,'  + _db(theData.content     )+#10;
  // s := s+'  ,'  + _db(theData.richcontent )+#10;
  // s := s+'  ,'  + _db(theData.contentfile )+#10;
  s := s + '   ) ';
  result := cmd_bySQL(s);
  if result then
  begin
    NewID := GetLastID('systemactions');
  end;
end;

/// ///////////////////////////////////////////////////////////////////////////
// systemtriggers
// ------------------------------------
// ID                     : integer ;
// Active                 : boolean ;
// description            : string  ; //30
// aType                  : integer ;
// systemActions          : integer ;
/// ///////////////////////////////////////////////////////////////////////////

procedure initSystemTriggerHolder(var rec: recSystemTriggerHolder);
begin
  with rec do
  begin
    // ID             := ;
    active := true;
    Description := '';
    aType := 0;
    systemAction := 0;
    ActionDescription := '';
  end;
end;

function Del_SystemTrigger(theData: recSystemTriggerHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM systemtriggers ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function UPD_SystemTrigger(theData: recSystemTriggerHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE systemtriggers ' + #10;
  s := s + ' SET ' + #10;
  s := s + '   `Active`          = ' + _db(theData.active) + ' ' + #10;
  s := s + '  ,`description`     = ' + _db(theData.Description) + ' ' + #10;
  s := s + '  ,`Type`            = ' + _db(theData.aType) + ' ' + #10;
  s := s + '  ,`systemAction`   = ' + _db(theData.systemAction) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function INS_SystemTrigger(theData: recSystemTriggerHolder; var NewID: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'INSERT INTO systemtriggers ' + #10;
  s := s + '   ( ' + #10;
  s := s + '    `Active`        ' + #10;
  s := s + '   ,`description`   ' + #10;
  s := s + '   ,`Type`        ' + #10;
  s := s + '   ,`systemAction` ' + #10;
  s := s + '   ) ' + #10;
  s := s + '   VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '   ' + _db(theData.active) + #10;
  s := s + '  ,' + _db(theData.Description) + #10;
  s := s + '  ,' + _db(theData.aType) + #10;
  s := s + '  ,' + _db(theData.systemAction) + #10;
  s := s + '   ) ';
  result := cmd_bySQL(s);
  if result then
  begin
    NewID := GetLastID('systemactions');
  end;
end;

/// /////////////////////////////////////////////////////////////////////////////////////
// package
// --------------------------------------
// id                 : integer;
// Active             : boolean;
// Description        : string ;
// package            : string ;
// showItemsOnInvoice : boolean;
/// ////////////////////////////////////////////////////////////////////////////////////////////

procedure initPackageHolder(var rec: recPackageHolder);
begin
  with rec do
  begin
    id := 0;
    active := true;
    Description := '';
    Package := '';
    showItemsOnInvoice := false;
    CurrencyID := 0;
    Currency := '';
    invoiceText := '';
  end;
end;

function Del_Package(theData: recPackageHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM packages ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function UPD_Package(theData: recPackageHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE packages ' + #10;
  s := s + ' SET ' + #10;
  s := s + '   `Active` = ' + _db(theData.active) + ' ' + #10;
  s := s + '  ,`description` = ' + _db(theData.Description) + ' ' + #10;
  s := s + '  ,`Package` = ' + _db(theData.package) + ' ' + #10;
  s := s + '  ,`ShowItemsOnInvoice`  = ' + _db(theData.showItemsOnInvoice) + ' ' + #10;
  s := s + '  ,`InvoiceText`  = ' + _db(theData.invoiceText) + ' ' + #10;
  s := s + '  ,`CurrencyID`  = ' + _db(theData.CurrencyID) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function INS_Package(theData: recPackageHolder; var NewID: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'INSERT INTO packages ' + #10;
  s := s + '   ( ' + #10;
  s := s + '    `Active` ' + #10;
  s := s + '   ,`Description` ' + #10;
  s := s + '   ,`Package` ' + #10;
  s := s + '   ,`ShowItemsOnInvoice` ' + #10;
  s := s + '   ,`CurrencyID` ' + #10;
  s := s + '   ,`InvoiceText` ' + #10;
  s := s + '   ) ' + #10;
  s := s + '   VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '   ' + _db(theData.active) + #10;
  s := s + '  ,' + _db(theData.Description) + #10;
  s := s + '  ,' + _db(theData.package) + #10;
  s := s + '  ,' + _db(theData.showItemsOnInvoice) + #10;
  s := s + '  ,' + _db(theData.CurrencyID) + #10;
  s := s + '  ,' + _db(theData.invoiceText) + #10;
  s := s + '   ) ';
  result := cmd_bySQL(s);
  if result then
  begin
    NewID := GetLastID('packages');
  end;
end;

function packageExist(sPackage: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  s := '';
  s := s + ' SELECT ' + chr(10);
  s := s + '   package ' + chr(10);
  s := s + ' FROM ' + chr(10);
  s := s + '   packages ' + chr(10);
  s := s + ' WHERE ' + chr(10);
  s := s + '   package = %s ';
  rSet := CreateNewDataSet;
  try
    s := format(s, [_db(sPackage)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function packageExistInItems(sPackage: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  s := '';
  s := s + ' SELECT ' + chr(10);
  s := s + '   item ' + chr(10);
  s := s + ' FROM ' + chr(10);
  s := s + '   items ' + chr(10);
  s := s + ' WHERE ' + chr(10);
  s := s + '   item = %s ';
  rSet := CreateNewDataSet;
  try
    s := format(s, [_db(sPackage)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function packageExistsInOther(sCode: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  s := s + ' SELECT itemID FROM invoicelines ' + chr(10);
  s := s + ' WHERE (itemID =  %s ) ' + chr(10);
  s := s + ' LIMIT 0,1 ' + chr(10);
  rSet := CreateNewDataSet;
  try
    s := format(s, [_db(sCode)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function Package_Description(Code: string): string;
begin
  result := '';
  glb.LocateSpecificRecordAndGetValue('packageitems', 'package', Code, 'Description', result);
  // s := s + 'SELECT Description ' + chr(10);
  // s := s + 'FROM packages  ' + chr(10);
  // s := s + 'WHERE  ' + chr(10);
  // s := s + '(package =' + _db(Code) + ') ' + chr(10);
  // rSet := CreateNewDataSet;
  // try
  // rSet_bySQL(rSet, s);
  // if not rSet.Eof then
  // begin
  // result := trim(rSet.fieldbyname('Description').asString)
  // end;
  // finally
  // freeandnil(rSet);
  // end;
end;

function Package_getHolder(Code: string): recPackageHolder;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  initPackageHolder(result);
  s := s + 'SELECT * ' + chr(10);
  s := s + 'FROM packages  ' + chr(10);
  s := s + 'WHERE  ' + chr(10);
  s := s + '(package =' + _db(Code) + ') ' + chr(10);
  rSet := CreateNewDataSet;
  try
    rSet_bySQL(rSet, s);
    if not rSet.Eof then
    begin
      result.id := rSet.fieldbyname('ID').asInteger;
      result.active := rSet.fieldbyname('Active').Asboolean;
      result.Description := trim(rSet.fieldbyname('description').asString);
      result.package := trim(rSet.fieldbyname('package').asString);
      result.CurrencyID := rSet.fieldbyname('currencyId').asInteger;
      result.invoiceText := rSet.fieldbyname('InvoiceText').asString;
      result.showItemsOnInvoice := rSet.fieldbyname('showItemsOnInvoice').Asboolean;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Package_getID(Code: string): integer;
begin
  result := 0;
  glb.LocateSpecificRecordAndGetValue('packageitems', 'package', Code, 'Id', result);
  // s := s + 'SELECT ID ' + chr(10);
  // s := s + 'FROM packages  ' + chr(10);
  // s := s + 'WHERE  ' + chr(10);
  // s := s + '(package =' + _db(Code) + ') ' + chr(10);
  // rSet := CreateNewDataSet;
  // try
  // if rSet_bySQL(rSet, s) then
  // begin
  // result := rSet.fieldbyname('ID').asInteger;
  // end;
  // finally
  // freeandnil(rSet);
  // end;
end;

function Package_getRoomPrice(Code: string; Nights, guests: integer; Var Roomprice, itemprices: double): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
  packageId: integer;
  RoomRentItem: string;
  roomRentID: integer;

  // theData: recPackageHolder;

  aRoomPrice: double;
  aItemPrice: double;
  numItemsMethod: integer;
  numItems: double;
begin
  result := false;
  aRoomPrice := 0;
  aItemPrice := 0;

  if glb.Packages.Locate('package', Code, []) then
    packageId := glb.Packages.fieldbyname('ID').asInteger
  else
    Exit;


  // theData := Package_getHolder(Code);

  RoomRentItem := trim(uppercase(ctrlGetString('RoomRentItem')));
  if glb.Items.Locate('Item', RoomRentItem, []) then
    roomRentID := glb.Items.fieldbyname('ID').asInteger
  else
    Exit;

  // ***ToDO
  // Add parameters like daycount and guests

  s := '';
  s := s + 'SELECT * '#10;
  s := s + 'FROM '#10;
  s := s + '  packageitems '#10;
  s := s + 'WHERE '#10;
  s := s + '  (packageID = ' + _db(packageId) + ') '#10;

  rSet := CreateNewDataSet;
  try
    if rSet_bySQL(rSet, s) then
    begin
      result := true;
      while not rSet.Eof do
      begin
        numItemsMethod := rSet.fieldbyname('numItemsMethod').asInteger;
        numItems := rSet.GetFloatValue(rSet.fieldbyname('numItems'));
        case numItemsMethod of
          0:
            numItems := numItems;
          1:
            numItems := numItems * Nights;
          2:
            numItems := numItems * (Nights * guests);
          3:
            numItems := numItems * guests;
        end;

        if rSet.fieldbyname('itemId').asInteger = roomRentID then
        begin
          aRoomPrice := aRoomPrice + rSet.GetFloatValue(rSet.fieldbyname('unitprice'));
//          aRoomPrice := aRoomPrice * Nights;
        end
        else
        begin
          aItemPrice := aItemPrice + rSet.GetFloatValue(rSet.fieldbyname('unitprice')) * numItems
        end;
        rSet.Next;
      end;
    end;

    Roomprice := aRoomPrice;
    itemprices := aItemPrice;
  finally
    freeandnil(rSet);
  end;
end;

function Package_getRoomDescription(Code: string; Room: String; Arrival, Departure: TdateTime; guestname : string=''): string;
var
  RoomRentItem: string;
  InvoiceText, PacketDescription : String;
begin
  result := '';

  if not glb.Packages.Locate('package', Code, []) then
    Exit;

  RoomRentItem := trim(uppercase(ctrlGetString('RoomRentItem')));
  if not glb.Items.Locate('Item', RoomRentItem, []) then
    Exit;

  InvoiceText := glb.Packages['invoiceText'];
  PacketDescription := glb.Packages['Description'];
  result := IIF(InvoiceText='', PacketDescription, InvoiceText);
  result := StringReplace(result, '{room}', Room, [rfReplaceAll, rfIgnoreCase]);
  result := StringReplace(result, '{arrival}', FormatDateTime('dd.mm', Arrival), [rfReplaceAll, rfIgnoreCase]);
  result := StringReplace(result, '{departure}', FormatDateTime('dd.mm', Departure), [rfReplaceAll, rfIgnoreCase]);
  result := StringReplace(result, '{guestname}', guestname, [rfReplaceAll, rfIgnoreCase]);

end;

/// ///////////////////////////////////////////////////////////////////////////////////
// packageitems
// id                     : integer;
// description            : string ;  //45
// numItems               : integer;
// unitPrice              : double ;
// packageId              : integer;   //link to pagage tablee
// itemId                 : integer;   //link to itemTable
// Item                   : string ;  //20
// itemDescription        : string ;  //30
// itemPrice              : double ;
// packageDescription
/// //////////////////////////////////////////////////////////////////////////////////////

procedure initPackageItemHolder(var rec: recPackageItemHolder);
begin
  with rec do
  begin
    // ID              := ;
    Description := '';
    numItems := 0;
    unitPrice := 0;
    packageId := 0;
    ItemID := 0;
    Item := '';
    itemDescription := '';
    itemPrice := 0;
    packageDescription := '';
    numItemsMethod := 0;
    IncludedInRate := false;
    valueFormula := '';
    unitPriceVatFormula := '';

  end;
end;

function Del_PackageItem(theData: recPackageItemHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM packageitems ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function Del_PackageItemByPackage(packageId: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM packageitems ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (packageID =' + _db(packageId) + ') ';
  result := cmd_bySQL(s);
end;

function UPD_PackageItem(theData: recPackageItemHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE packageitems ' + #10;
  s := s + ' SET ' + #10;
  s := s + '   `description`     = ' + _db(theData.Description) + ' ' + #10;
  s := s + '  ,`numItems`        = ' + _db(theData.numItems) + ' ' + #10;
  s := s + '  ,`unitPrice`       = ' + _db(theData.unitPrice) + ' ' + #10;
  s := s + '  ,`packageId`       = ' + _db(theData.packageId) + ' ' + #10;
  s := s + '  ,`itemId`          = ' + _db(theData.ItemID) + ' ' + #10;
  s := s + '  ,`numItemsMethod`  = ' + _db(theData.numItemsMethod) + ' ' + #10;
  s := s + '  ,`IncludedInRate`  = ' + _db(theData.IncludedInRate) + ' ' + #10;
  s := s + '  ,`valueFormula`    = ' + _db(theData.valueFormula) + ' ' + #10;
  s := s + '  ,`unitPriceVatFormula`    = ' + _db(theData.unitPriceVatFormula) + ' ' + #10;

  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function INS_Packageitem(theData: recPackageItemHolder; var NewID: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'INSERT INTO packageitems ' + #10;
  s := s + '   ( ' + #10;
  s := s + '    `description` ' + #10;
  s := s + '   ,`numItems` ' + #10;
  s := s + '   ,`unitPrice` ' + #10;
  s := s + '   ,`packageId` ' + #10;
  s := s + '   ,`itemId` ' + #10;
  s := s + '   ,`numItemsMethod` ' + #10;
  s := s + '   ,`IncludedInRate` ' + #10;
  s := s + '   ,`valueFormula` ' + #10;
  s := s + '   ,`unitPriceVatFormula` ' + #10;

  s := s + '   ) ' + #10;
  s := s + '   VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '   ' + _db(theData.Description) + #10;
  s := s + '  ,' + _db(theData.numItems) + #10;
  s := s + '  ,' + _db(theData.unitPrice) + #10;
  s := s + '  ,' + _db(theData.packageId) + #10;
  s := s + '  ,' + _db(theData.ItemID) + #10;
  s := s + '  ,' + _db(theData.numItemsMethod) + #10;
  s := s + '  ,' + _db(theData.IncludedInRate) + #10;
  s := s + '  ,' + _db(theData.valueFormula) + #10;
  s := s + '  ,' + _db(theData.unitPriceVatFormula) + #10;

  s := s + '   ) ';
  result := cmd_bySQL(s);
  if result then
  begin
    NewID := GetLastID('packageitems');
  end;
end;

function Packageitem_TotalByPackageID(packageId: integer): double;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := 0;

  s := '';
  s := s + ' SELECT '#10;
  s := s + '   sum(`packageitems`.`numItems` * `packageitems`.`unitPrice`) AS `TotalPrice`, '#10;
  s := s + '   `packageitems`.`id` '#10;
  s := s + ' FROM '#10;
  s := s + '   `packageitems` '#10;
  s := s + ' WHERE '#10;
  s := s + '  (`packageitems`.`packageId` = %d) '#10;

  rSet := CreateNewDataSet;
  try
    s := format(s, [packageId]);

    if rSet_bySQL(rSet, s) then
    begin
      result := rSet.GetFloatValue(rSet.fieldbyname('TotalPrice'));
    end;
  finally
    freeandnil(rSet);
  end;
end;

/// //////////////////////////////////////////////////////////////////
//
//
/// //////////////////////////////////////////////////////////////////

procedure initPersonHolder(var rec: recPersonHolder);
begin
  with rec do
  begin
    {id}
    Person := -1;
    RoomReservation := -1;
    Reservation := -1;
    name := '';
    Surname := '';
    Address1 := '';
    Address2 := '';
    Address3 := '';
    Address4 := '';
    Country := '';

    Tel1 := '';
    Tel2 := '';
    Fax := '';
    Email := '';

    GuestType := '';
    Information := '';

    Nationality := '';
    PID := '';
    MainName := false;

    Customer := '';

    Company := '';
    CompanyName := '';
    CompAddress1 := '';
    CompAddress2 := '';
    CompZip := '';
    CompCity := '';
    CompCountry := '';
    CompTel := '';
    CompEmail := '';

    CompFax := '';
    CompVatNumber := '';

    PersonsProfilesId := 0;

    peTmp := '';
    hgrID := -1;
    HallReservation := -1;

//    state := '';
//    sourceId                 : String;
//    PersonalIdentificationId : string;
//    DateOfBirth              : TdateTime;
//    SocialSecurityNumber     : string;
//    confirmDate              : TdateTime;
//    lastUpdate               : TdateTime;

  end;
end;

function SQL_INS_Person(theData: recPersonHolder): string;
var
  s: string;
  Person: integer;
begin
  Person := theData.Person;
  if Person < 1 then
  begin
    Person := PE_SetNewID();
  end;

  s := '';
  s := s + 'INSERT INTO persons ' + #10;
  s := s + '  ( ' + #10;
  s := s + '    Person ' + #10;
  s := s + '   ,RoomReservation ' + #10;
  s := s + '   ,Reservation ' + #10;
  s := s + '   ,Name ' + #10;
  s := s + '   ,Surname ' + #10;
  s := s + '   ,Address1 ' + #10;
  s := s + '   ,Address2 ' + #10;
  s := s + '   ,Address3 ' + #10;
  s := s + '   ,Address4 ' + #10;
  s := s + '   ,Country ' + #10;
  s := s + '   ,Company ' + #10;

  s := s + '   ,CompanyName ' + #10;
  s := s + '   ,CompAddress1 ' + #10;
  s := s + '   ,CompAddress2 ' + #10;
  s := s + '   ,CompZip ' + #10;
  s := s + '   ,CompCity ' + #10;
  s := s + '   ,CompCountry ' + #10;
  s := s + '   ,CompTel ' + #10;
  s := s + '   ,CompEmail ' + #10;
  s := s + '   ,PersonsProfilesId ' + #10;


  s := s + '   ,GuestType ' + #10;
  s := s + '   ,Information ' + #10;
  s := s + '   ,PID ' + #10;
  s := s + '   ,MainName ' + #10;
  s := s + '   ,Customer ' + #10;
  s := s + '   ,peTmp ' + #10;
  s := s + '   ,hgrID ' + #10;
  s := s + '   ,HallReservation ' + #10;
  s := s + '   ,Tel1 ' + #10;
  s := s + '   ,Tel2 ' + #10;
  s := s + '   ,Fax ' + #10;
  s := s + '   ,Email ' + #10;
  s := s + '  ) ' + #10;
  s := s + '  VALUES ' + #10;
  s := s + '  ( ' + #10;
  s := s + '   ' + _db(Person) + #10;
  s := s + ' , ' + _db(theData.RoomReservation) + #10;
  s := s + ' , ' + _db(theData.Reservation) + #10;
  s := s + ' , ' + _db(theData.name) + #10;
  s := s + ' , ' + _db(theData.Surname) + #10;
  s := s + ' , ' + _db(theData.Address1) + #10;
  s := s + ' , ' + _db(theData.Address2) + #10;
  s := s + ' , ' + _db(theData.Address3) + #10;
  s := s + ' , ' + _db(theData.Address4) + #10;
  s := s + ' , ' + _db(theData.Country) + #10;
  s := s + ' , ' + _db(theData.Company) + #10;

  s := s + ' , ' + _db(theData.CompanyName) + #10;
  s := s + ' , ' + _db(theData.CompAddress1) + #10;
  s := s + ' , ' + _db(theData.CompAddress2) + #10;
  s := s + ' , ' + _db(theData.CompZip) + #10;
  s := s + ' , ' + _db(theData.CompCity) + #10;
  s := s + ' , ' + _db(theData.CompCountry) + #10;
  s := s + ' , ' + _db(theData.CompTel) + #10;
  s := s + ' , ' + _db(theData.CompEmail) + #10;
  s := s + ' , ' + _db(theData.PersonsProfilesId) + #10;


  s := s + ' , ' + _db(theData.GuestType) + #10;
  s := s + ' , ' + _db(theData.Information) + #10;
  s := s + ' , ' + _db(theData.PID) + #10;
  s := s + ' , ' + _db(theData.MainName) + #10;
  s := s + ' , ' + _db(theData.Customer) + #10;
  s := s + ' , ' + _db(theData.peTmp) + #10;
  s := s + ' , ' + _db(theData.hgrID) + #10;
  s := s + ' , ' + _db(theData.HallReservation) + #10;
  s := s + ' , ' + _db(theData.Tel1) + #10;
  s := s + ' , ' + _db(theData.Tel2) + #10;
  s := s + ' , ' + _db(theData.Fax) + #10;
  s := s + ' , ' + _db(theData.Email) + #10;
  s := s + '  ) ';
  result := s;
end;

function INS_Person(theData: recPersonHolder; var NewID: integer): boolean;
var
  s: string;
begin
  s := SQL_INS_Person(theData);
  result := cmd_bySQL(s);

  if NewID > -1 then
  begin
    if result then
    begin
      NewID := GetLastID('persons');
    end;
  end;
end;

function GET_Pesson(Person: integer): recPersonHolder;
var
  rSet: TRoomerDataSet;
  sql: string;
begin
  rSet := CreateNewDataSet;
  try
    initPersonHolder(result);
    sql := format(select_Person, [Person]);
    if hData.rSet_bySQL(rSet, sql) then
    begin
      result.Person := rSet.fieldbyname('Person').asInteger;
      result.RoomReservation := rSet.fieldbyname('RoomReservation').asInteger;
      result.Reservation := rSet.fieldbyname('Reservation').asInteger;
      result.name := rSet.fieldbyname('name').asString;
      result.Surname := rSet.fieldbyname('Surname').asString;
      result.Address1 := rSet.fieldbyname('Address1').asString;
      result.Address2 := rSet.fieldbyname('Address2').asString;
      result.Address3 := rSet.fieldbyname('Address3').asString;
      result.Address4 := rSet.fieldbyname('Address4').asString;
      result.Country := rSet.fieldbyname('Country').asString;
      result.Company := rSet.fieldbyname('Company').asString;

      result.CompanyName := rSet.fieldbyname('CompanyName').AsString;
      result.CompAddress1 := rSet.fieldbyname('CompAddress1').asString;
      result.CompAddress2 := rSet.fieldbyname('CompAddress2').asString;
      result.CompZip := rSet.fieldbyname('CompZip').asString;
      result.CompCity := rSet.fieldbyname('CompCity').asString;
      result.CompCountry := rSet.fieldbyname('CompCountry').asString;
      result.CompTel := rSet.fieldbyname('CompTel').asString;
      result.CompEmail := rSet.fieldbyname('CompEmail').asString;
      result.PersonsProfilesId := rSet.fieldbyname('PersonsProfilesId').asInteger;

      result.GuestType := rSet.fieldbyname('GuestType').asString;
      result.Information := rSet.fieldbyname('Information').asString;
      result.PID := rSet.fieldbyname('PID').asString;
      result.MainName := rSet['MainName'];
      result.Customer := rSet.fieldbyname('Customer').asString;
      result.peTmp := rSet.fieldbyname('peTmp').asString;
      result.hgrID := rSet.fieldbyname('hgrID').asInteger;
      result.HallReservation := rSet.fieldbyname('HallReservation').asInteger;
      result.Tel1 := rSet.fieldbyname('Tel1').asString;
      result.Tel2 := rSet.fieldbyname('Tel2').asString;
      result.Fax := rSet.fieldbyname('Fax').asString;
      result.Email := rSet.fieldbyname('Email').asString;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function GET_mainGuest(RoomReservation: integer): recPersonHolder;
var
  rSet: TRoomerDataSet;
  sql: string;
  s: string;
begin
  rSet := CreateNewDataSet;
  try
    initPersonHolder(result);
    s := ' SELECT * FROM persons WHERE roomreservation = %d ORDER BY MainName DESC, Person LIMIT 1 ';
    sql := format(s, [RoomReservation]);
    if hData.rSet_bySQL(rSet, sql) then
    begin
      result.Person := rSet.fieldbyname('Person').asInteger;
      result.RoomReservation := rSet.fieldbyname('RoomReservation').asInteger;
      result.Reservation := rSet.fieldbyname('Reservation').asInteger;
      result.name := rSet.fieldbyname('name').asString;
      result.Surname := rSet.fieldbyname('Surname').asString;
      result.Address1 := rSet.fieldbyname('Address1').asString;
      result.Address2 := rSet.fieldbyname('Address2').asString;
      result.Address3 := rSet.fieldbyname('Address3').asString;
      result.Address4 := rSet.fieldbyname('Address4').asString;
      result.Country := rSet.fieldbyname('Country').asString;
      result.Company := rSet.fieldbyname('Company').asString;

      result.CompanyName := rSet.fieldbyname('CompanyName').AsString;
      result.CompAddress1 := rSet.fieldbyname('CompAddress1').asString;
      result.CompAddress2 := rSet.fieldbyname('CompAddress2').asString;
      result.CompZip := rSet.fieldbyname('CompZip').asString;
      result.CompCity := rSet.fieldbyname('CompCity').asString;
      result.CompCountry := rSet.fieldbyname('CompCountry').asString;
      result.CompTel := rSet.fieldbyname('CompTel').asString;
      result.CompEmail := rSet.fieldbyname('CompEmail').asString;
      result.PersonsProfilesId := rSet.fieldbyname('PersonsProfilesId').asInteger;

      result.GuestType := rSet.fieldbyname('GuestType').asString;
      result.Information := rSet.fieldbyname('Information').asString;
      result.PID := rSet.fieldbyname('PID').asString;
      result.MainName := rSet['MainName'];
      result.Customer := rSet.fieldbyname('Customer').asString;
      result.peTmp := rSet.fieldbyname('peTmp').asString;
      result.hgrID := rSet.fieldbyname('hgrID').asInteger;
      result.HallReservation := rSet.fieldbyname('HallReservation').asInteger;
      result.Tel1 := rSet.fieldbyname('Tel1').asString;
      result.Tel2 := rSet.fieldbyname('Tel2').asString;
      result.Fax := rSet.fieldbyname('Fax').asString;
      result.Email := rSet.fieldbyname('Email').asString;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function DEL_Person(theData: recPersonHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM persons ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function PersonIDExistsInOther(id: integer): boolean;
//var
//  s: string;
//  rSet: TRoomerDataSet;
begin
  result := false;
  // s := '';
  // s := s + ' SELECT ID FROM [?] '+chr(10);
  // s := s + ' WHERE (ID = ' + _db(ID) + ') '+chr(10);
  //
  // RSet := CreateNewDataSet;
  // try
  // rSet_bySQL(rSet,s, Connection,loglevel,logpath);
  // if not rSet.Eof then
  // begin
  // result := true;
  // exit;
  // end;
  // finally
  // freeandnil(rSet);
  // end;
end;

function PersonExistsInOther(Person: integer): boolean;
//var
//  s: string;
//  rSet: TRoomerDataSet;
begin
  result := false;
  // s := '';
  // s := s + ' SELECT Person FROM [?] '#10;
  // s := s + ' WHERE (person = ' + _db(Person) + ') ';
  //
  // RSet := CreateNewDataSet;
  // try
  // rSet_bySQL(rSet,s, Connection,loglevel,logpath);
  // if not rSet.Eof then
  // begin
  // result := true;
  // exit;
  // end;
  // finally
  // freeandnil(rSet);
  // end;
end;

function UPD_person(theData: recPersonHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE persons ' + #10;
  s := s + ' SET ' + #10;
  s := s + '   `Person`          = ' + _db(theData.Person) + ' ' + #10;
  s := s + '  ,`RoomReservation` = ' + _db(theData.RoomReservation) + ' ' + #10;
  s := s + '  ,`Reservation`     = ' + _db(theData.Reservation) + ' ' + #10;
  s := s + '  ,`name`            = ' + _db(theData.name) + ' ' + #10;
  s := s + '  ,`Surname`         = ' + _db(theData.Surname) + ' ' + #10;
  s := s + '  ,`Address1`        = ' + _db(theData.Address1) + ' ' + #10;
  s := s + '  ,`Address2`        = ' + _db(theData.Address2) + ' ' + #10;
  s := s + '  ,`Address3`        = ' + _db(theData.Address3) + ' ' + #10;
  s := s + '  ,`Address4`        = ' + _db(theData.Address4) + ' ' + #10;
  s := s + '  ,`Country`         = ' + _db(theData.Country) + ' ' + #10;
  s := s + '  ,`Company`         = ' + _db(theData.Company) + ' ' + #10;

  s := s + '  ,`CompanyName`  = ' + _db(theData.CompanyName) + ' ' + #10;
  s := s + '  ,`CompAddress1` = ' + _db(theData.CompAddress1) + ' ' + #10;
  s := s + '  ,`CompAddress2` = ' + _db(theData.CompAddress2) + ' ' + #10;
  s := s + '  ,`CompZip`      = ' + _db(theData.CompZip) + ' ' + #10;
  s := s + '  ,`CompCity`     = ' + _db(theData.CompCity) + ' ' + #10;
  s := s + '  ,`CompCountry`  = ' + _db(theData.CompCountry) + ' ' + #10;
  s := s + '  ,`CompTel`      = ' + _db(theData.CompTel) + ' ' + #10;
  s := s + '  ,`CompEmail`    = ' + _db(theData.CompEmail) + ' ' + #10;
  s := s + '  ,`PersonsProfilesId`    = ' + _db(theData.PersonsProfilesId) + ' ' + #10;

  s := s + '  ,`GuestType`       = ' + _db(theData.GuestType) + ' ' + #10;
  s := s + '  ,`Information`     = ' + _db(theData.Information) + ' ' + #10;
  s := s + '  ,`PID`             = ' + _db(theData.PID) + ' ' + #10;
  s := s + '  ,`MainName`        = ' + _db(theData.MainName) + ' ' + #10;
  s := s + '  ,`Customer`        = ' + _db(theData.Customer) + ' ' + #10;
  s := s + '  ,`peTmp`           = ' + _db(theData.peTmp) + ' ' + #10;
  s := s + '  ,`hgrID`           = ' + _db(theData.hgrID) + ' ' + #10;
  s := s + '  ,`HallReservation` = ' + _db(theData.HallReservation) + ' ' + #10;
  s := s + '  ,`Tel1` = ' + _db(theData.Tel1) + ' ' + #10;
  s := s + '  ,`Tel2` = ' + _db(theData.Tel2) + ' ' + #10;
  s := s + '  ,`Fax` = ' + _db(theData.Fax) + ' ' + #10;
  s := s + '  ,`Email` = ' + _db(theData.Email) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;




// recPersonVipTypesHolder = record
// id           : integer;
// Code	       : string; // nvarchar(5)	Checked
// Description	 : string; // nvarchar(45)	Checked
// SysType	     : integer; // integer

procedure initPersonVipTypesHolder(var rec: recPersonVipTypesHolder);
begin
  with rec do
  begin
    id := 0;
    Code := '';
    Description := '';
    vipGrade := 0;
    active := true;

    tmp := '';
  end;
end;

function GET_PersonVipTypesHolderByCode(var theData: recPersonVipTypesHolder; justActive: boolean = true): boolean;
var
  getItem: string;
  s: string;
  rSet: TRoomerDataSet;
begin
  result := false;
  getItem := theData.Code;
  s := s + ' SELECT ' + #10;
  s := s + '    Id ' + #10;
  s := s + '   ,Description ' + #10;
  s := s + '   ,VipGrade ' + #10;
  s := s + '   ,active ' + #10;
  s := s + ' FROM ' + #10;
  s := s + '   personviptypes ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '  (code = ' + _db(getItem) + ') ' + #10;

  rSet := CreateNewDataSet;
  try
    if rSet_bySQL(rSet, s) then
    begin
      result := true;
      theData.id := rSet.fieldbyname('ID').asInteger;
      theData.Code := rSet.fieldbyname('Code').asString;
      theData.Description := rSet.fieldbyname('description').asString;
      theData.vipGrade := rSet.fieldbyname('vipGrade').asInteger;
      theData.active := rSet.fieldbyname('active').Asboolean;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function GET_PersonVipTypesHolderByID(var theData: recPersonVipTypesHolder): boolean;
var
  getItem: integer;
  s: string;
  rSet: TRoomerDataSet;
begin
  result := false;
  getItem := theData.id;
  s := '';
  s := s + ' SELECT ' + #10;
  s := s + '    Id ' + #10;
  s := s + '   ,Description ' + #10;
  s := s + '   ,VipGrade ' + #10;
  s := s + '   ,active ' + #10;
  s := s + ' FROM ' + #10;
  s := s + '   personviptypes ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '  (ID = ' + _db(getItem) + ') ' + #10;

  rSet := CreateNewDataSet;
  try
    if rSet_bySQL(rSet, s) then
    begin
      result := true;
      theData.id := rSet.fieldbyname('ID').asInteger;
      theData.Code := rSet.fieldbyname('Code').asString;
      theData.Description := rSet.fieldbyname('description').asString;
      theData.vipGrade := rSet.fieldbyname('vipGrade').asInteger;
      theData.active := rSet.fieldbyname('active').Asboolean;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function UPD_PersonVipTypes(theData: recPersonVipTypesHolder): boolean;
var
  s: string;
begin
  if theData.tmp = '' then
    theData.tmp := theData.Code;
  s := '';
  s := s + ' UPDATE personviptypes ' + #10;
  s := s + ' SET ' + #10;
  s := s + '     code   = ' + _db(theData.Code) + ' ' + #10;
  s := s + '   , Description =' + _db(theData.Description) + ' ' + #10;
  s := s + '   , vipGrade =' + _db(theData.vipGrade) + ' ' + #10;
  s := s + '   , Active =' + _db(theData.active) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (code = ' + _db(theData.tmp) + ') ';
  result := cmd_bySQL(s);
end;

function INS_PersonVipTypes(theData: recPersonVipTypesHolder; var NewID: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'INSERT INTO personviptypes ' + #10;
  s := s + '   ( ' + #10;
  s := s + '   code ' + #10;
  s := s + '  ,description ' + #10;
  s := s + '  ,vipGrade ' + #10;
  s := s + '  ,Active ' + #10;
  s := s + '   ) ' + #10;
  s := s + '    VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '     ' + _db(theData.Code) + ' ' + #10;
  s := s + '     ,' + _db(theData.Description) + ' ' + #10;
  s := s + '     ,' + _db(theData.vipGrade) + ' ' + #10;
  s := s + '     ,' + _db(theData.active) + ' ' + #10;
  s := s + '   )';
  result := cmd_bySQL(s);
  if result then
  begin
    NewID := GetLastID('personviptypes');
  end;

end;

function PersonVipTypesExistsInOther(Code: string): boolean;
//var
//  s: string;
//  rSet: TRoomerDataSet;
begin
  result := false;
  // RSet := CreateNewDataSet;
  // try
  //
  /// /  s := s + ' SELECT NativeCurrency FROM [Control] '+chr(10);
  /// /  s := s + ' WHERE (NativeCurrency = ' + quotedstr(sCurrency) + ') '+chr(10);
  // s := format(select_currencyExistsInOther, [quotedstr(sCurrency)]);
  // result := rSet_bySQL(rSet,s, Connection,loglevel,logpath);
  // if result then exit;
  //
  /// /  s := s + ' SELECT Currency FROM [Countries] '+chr(10);
  /// /  s := s + ' WHERE (Currency = ' + quotedstr(sCurrency) + ') '+chr(10);
  // s := format(select_currencyExistsInOther1, [quotedstr(sCurrency)]);
  // result := rSet_bySQL(rSet,s, Connection,loglevel,logpath);
  // if result then exit;
  //
  /// /  s := s + ' SELECT Currency FROM [Customers] '+chr(10);
  /// /  s := s + ' WHERE (Currency = ' + quotedstr(sCurrency) + ') '+chr(10);
  // s := format(select_currencyExistsInOther2, [quotedstr(sCurrency)]);
  // result := rSet_bySQL(rSet,s, Connection,loglevel,logpath);
  // if result then exit;
  //
  /// /  s := s + ' SELECT Currency FROM [PriceTypes] '+chr(10);
  /// /  s := s + ' WHERE (Currency = ' + quotedstr(sCurrency) + ') '+chr(10);
  // s := format(select_currencyExistsInOther3, [quotedstr(sCurrency)]);
  // result := rSet_bySQL(rSet,s, Connection,loglevel,logpath);
  // if result then exit;
  //
  /// /  s := s +' SELECT Currency FROM [InvoiceLines] '+chr(10);
  /// /  s := s + ' WHERE (Currency = ' + quotedstr(sCurrency) + ') '+chr(10);
  // s := format(select_currencyExistsInOther4, [quotedstr(sCurrency)]);
  // result := rSet_bySQL(rSet,s, Connection,loglevel,logpath);
  // if result then exit;
  //
  /// /  s := s + ' SELECT Currency FROM [Payments] '+chr(10);
  /// /  s := s + ' WHERE (Currency = ' + quotedstr(sCurrency) + ') '+chr(10);
  // s := format(select_currencyExistsInOther5, [quotedstr(sCurrency)]);
  // result := rSet_bySQL(rSet,s, Connection,loglevel,logpath);
  // if result then exit;
  //
  /// /  s := s + ' SELECT Currency FROM [RoomReservations] '+chr(10);
  /// /  s := s + ' WHERE (Currency = ' + quotedstr(sCurrency) + ') '+chr(10);
  // s := format(select_currencyExistsInOther6, [quotedstr(sCurrency)]);
  // result := rSet_bySQL(rSet,s, Connection,loglevel,logpath);
  // if result then exit;
  //
  // finally
  // freeandnil(rSet);
  // end;
end;

function Del_PersonVipTypesByCode(Code: string): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM personviptypes ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (Code =' + quotedstr(Code) + ') ';
  result := cmd_bySQL(s);
end;

function PersonVipTypesExists(Code: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  s := s + 'SELECT ' + chr(10);
  s := s + 'Code ' + chr(10);
  s := s + 'FROM ' + chr(10);
  s := s + 'personviptypes ' + chr(10);
  s := s + 'WHERE ' + chr(10);
  s := s + 'Code = ' + quotedstr(Code) + '  ' + chr(10);

  rSet := CreateNewDataSet;
  try
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;



// function PersonContactTypeExists(Code : string; Connection : TRoomerConnection) : boolean;
// function Del_PersonContactTypeByCode(Code : string; Connection : TRoomerConnection) : boolean;
// function PersonContactTypeExistsInOther(Code : string; Connection : TRoomerConnection) : boolean;
// function INS_PersonContactType(theData : recPersonContactTypeHolder; Connection : TRoomerConnection;var NewID : integer) : boolean;
// function UPD_PersonContactType(theData : recPersonContactTypeHolder; Connection : TRoomerConnection) : boolean;
// function GET_PersonContactTypeHolderByID(var theData : recPersonContactTypeHolder; Connection : TRoomerConnection) : boolean;
// procedure initPersonContactTypeHolder(var rec : recPersonContactTypeHolder);
// function GET_PersonVipContactTypeByCode(var theData : recPersonContactTypeHolder; Connection : TRoomerConnection; justActive : boolean=true) : boolean;



// recPersonContactTypeHolder = record
// id           : integer;
// Code	       : string; // nvarchar(5)	Checked
// Description	 : string; // nvarchar(35)	Checked
// vipGrade     : integer; // integer

procedure initPersonContactTypeHolder(var rec: recPersonContactTypeHolder);
begin
  with rec do
  begin
    id := 0;
    Code := '';
    Description := '';
    SysType := 0;
    active := true;

    tmp := '';
  end;
end;

function GET_PersonContactTypeHolderByCode(var theData: recPersonContactTypeHolder; justActive: boolean = true): boolean;
var
  getItem: string;
  s: string;
  rSet: TRoomerDataSet;
begin
  result := false;
  getItem := theData.Code;
  s := s + ' SELECT ' + #10;
  s := s + '    Id ' + #10;
  s := s + '   ,Description ' + #10;
  s := s + '   ,sysType ' + #10;
  s := s + '   ,active ' + #10;
  s := s + ' FROM ' + #10;
  s := s + '   personcontacttype ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '  (code = ' + _db(getItem) + ') ' + #10;

  rSet := CreateNewDataSet;
  try
    if rSet_bySQL(rSet, s) then
    begin
      result := true;
      theData.id := rSet.fieldbyname('ID').asInteger;
      theData.Code := rSet.fieldbyname('Code').asString;
      theData.Description := rSet.fieldbyname('description').asString;
      theData.SysType := rSet.fieldbyname('sysType').asInteger;
      theData.active := rSet.fieldbyname('active').Asboolean;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function GET_PersonContactTypeHolderByID(var theData: recPersonContactTypeHolder): boolean;
var
  getItem: integer;
  s: string;
  rSet: TRoomerDataSet;
begin
  result := false;
  getItem := theData.id;
  s := '';
  s := s + ' SELECT ' + #10;
  s := s + '    Id ' + #10;
  s := s + '   ,Description ' + #10;
  s := s + '   ,sysType ' + #10;
  s := s + '   ,active ' + #10;
  s := s + ' FROM ' + #10;
  s := s + '   personcontacttype ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '  (ID = ' + _db(getItem) + ') ' + #10;

  rSet := CreateNewDataSet;
  try
    if rSet_bySQL(rSet, s) then
    begin
      result := true;
      theData.id := rSet.fieldbyname('ID').asInteger;
      theData.Code := rSet.fieldbyname('Code').asString;
      theData.Description := rSet.fieldbyname('description').asString;
      theData.SysType := rSet.fieldbyname('sysType').asInteger;
      theData.active := rSet.fieldbyname('active').Asboolean;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function UPD_PersonContactType(theData: recPersonContactTypeHolder): boolean;
var
  s: string;
begin
  if theData.tmp = '' then
    theData.tmp := theData.Code;
  s := '';
  s := s + ' UPDATE personcontacttype ' + #10;
  s := s + ' SET ' + #10;
  s := s + '     code   = ' + _db(theData.Code) + ' ' + #10;
  s := s + '   , Description =' + _db(theData.Description) + ' ' + #10;
  s := s + '   , sysType =' + _db(theData.SysType) + ' ' + #10;
  s := s + '   , Active =' + _db(theData.active) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (code = ' + _db(theData.tmp) + ') ';
  result := cmd_bySQL(s);
end;

function INS_PersonContactType(theData: recPersonContactTypeHolder; var NewID: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'INSERT INTO personcontacttype ' + #10;
  s := s + '   ( ' + #10;
  s := s + '   code ' + #10;
  s := s + '  ,description ' + #10;
  s := s + '  ,sysType ' + #10;
  s := s + '  ,Active ' + #10;
  s := s + '   ) ' + #10;
  s := s + '    VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '     ' + _db(theData.Code) + ' ' + #10;
  s := s + '     ,' + _db(theData.Description) + ' ' + #10;
  s := s + '     ,' + _db(theData.SysType) + ' ' + #10;
  s := s + '     ,' + _db(theData.active) + ' ' + #10;
  s := s + '   )';
  result := cmd_bySQL(s);
  if result then
  begin
    NewID := GetLastID('personcontacttype');
  end;

end;

function PersonContactTypeExistsInOther(Code: string): boolean;
//var
//  s: string;
//  rSet: TRoomerDataSet;
begin
  result := false;
  // RSet := CreateNewDataSet;
  // try
  //
  /// /  s := s + ' SELECT NativeCurrency FROM [Control] '+chr(10);
  /// /  s := s + ' WHERE (NativeCurrency = ' + quotedstr(sCurrency) + ') '+chr(10);
  // s := format(select_currencyExistsInOther, [quotedstr(sCurrency)]);
  // result := rSet_bySQL(rSet,s, Connection,loglevel,logpath);
  // if result then exit;
  //
  /// /  s := s + ' SELECT Currency FROM [Countries] '+chr(10);
  /// /  s := s + ' WHERE (Currency = ' + quotedstr(sCurrency) + ') '+chr(10);
  // s := format(select_currencyExistsInOther1, [quotedstr(sCurrency)]);
  // result := rSet_bySQL(rSet,s, Connection,loglevel,logpath);
  // if result then exit;
  //
  /// /  s := s + ' SELECT Currency FROM [Customers] '+chr(10);
  /// /  s := s + ' WHERE (Currency = ' + quotedstr(sCurrency) + ') '+chr(10);
  // s := format(select_currencyExistsInOther2, [quotedstr(sCurrency)]);
  // result := rSet_bySQL(rSet,s, Connection,loglevel,logpath);
  // if result then exit;
  //
  /// /  s := s + ' SELECT Currency FROM [PriceTypes] '+chr(10);
  /// /  s := s + ' WHERE (Currency = ' + quotedstr(sCurrency) + ') '+chr(10);
  // s := format(select_currencyExistsInOther3, [quotedstr(sCurrency)]);
  // result := rSet_bySQL(rSet,s, Connection,loglevel,logpath);
  // if result then exit;
  //
  /// /  s := s +' SELECT Currency FROM [InvoiceLines] '+chr(10);
  /// /  s := s + ' WHERE (Currency = ' + quotedstr(sCurrency) + ') '+chr(10);
  // s := format(select_currencyExistsInOther4, [quotedstr(sCurrency)]);
  // result := rSet_bySQL(rSet,s, Connection,loglevel,logpath);
  // if result then exit;
  //
  /// /  s := s + ' SELECT Currency FROM [Payments] '+chr(10);
  /// /  s := s + ' WHERE (Currency = ' + quotedstr(sCurrency) + ') '+chr(10);
  // s := format(select_currencyExistsInOther5, [quotedstr(sCurrency)]);
  // result := rSet_bySQL(rSet,s, Connection,loglevel,logpath);
  // if result then exit;
  //
  /// /  s := s + ' SELECT Currency FROM [RoomReservations] '+chr(10);
  /// /  s := s + ' WHERE (Currency = ' + quotedstr(sCurrency) + ') '+chr(10);
  // s := format(select_currencyExistsInOther6, [quotedstr(sCurrency)]);
  // result := rSet_bySQL(rSet,s, Connection,loglevel,logpath);
  // if result then exit;
  //
  // finally
  // freeandnil(rSet);
  // end;
end;

function Del_PersonContactTypeByCode(Code: string): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM personcontacttype ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (Code =' + quotedstr(Code) + ') ';
  result := cmd_bySQL(s);
end;

function PersonContactTypeExists(Code: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  s := s + 'SELECT ' + chr(10);
  s := s + 'Code ' + chr(10);
  s := s + 'FROM ' + chr(10);
  s := s + 'personcontacttype ' + chr(10);
  s := s + 'WHERE ' + chr(10);
  s := s + 'Code = ' + quotedstr(Code) + '  ' + chr(10);

  rSet := CreateNewDataSet;
  try
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;


/////////////////////////////////////////////////////////////////////
//
//  recLostAndFoundHolder = record
//    id                  : integer;
//    DateFound           : TdateTime;
//    itemDescription     : string;
//    locationDescription : string;
//    returnedToOwner     : boolean;
//    returnedNotes       :  string;
//  end;
//
//////////////////////////////////////////////////////////////////////

procedure initLostAndFoundHolder(var rec: recLostAndFoundHolder);
begin
  with rec do
  begin
    DateFound           := 2;
    itemDescription     := '' ;
    locationDescription := '' ;
    returnedToOwner     := false;
    returnedNotes       := ''
  end;
end;

function Del_LostAndFound(theData: recLostAndFoundHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + '   FROM lostandfound ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + '   (ID =' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;


function UPD_LostAndFound(theData: recLostAndFoundHolder): boolean;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE lostandfound ' + #10;
  s := s + ' SET ' + #10;
  s := s + '   DateFound     = ' + _db(theData.dateFound) + ' ' + #10;
  s := s + '  ,itemDescription     = ' + _db(theData.itemDescription    ) + ' ' + #10;
  s := s + '  ,locationDescription = ' + _db(theData.locationDescription) + ' ' + #10;
  s := s + '  ,returnedToOwner     = ' + _db(theData.returnedToOwner    ) + ' ' + #10;
  s := s + '  ,returnedNotes       = ' + _db(theData.returnedNotes      ) + ' ' + #10;
  s := s + ' WHERE ' + #10;
  s := s + '   (ID = ' + _db(theData.id) + ') ';
  result := cmd_bySQL(s);
end;

function INS_LostAndFound(theData: recLostAndFoundHolder; var NewID: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'INSERT INTO lostandfound ' + #10;
  s := s + '   ( ' + #10;
  s := s + '    DateFound           ' + #10;
  s := s + '   ,itemDescription     ' + #10;
  s := s + '   ,locationDescription ' + #10;
  s := s + '   ,returnedToOwner     ' + #10;
  s := s + '   ,returnedNotes       ' + #10;
  s := s + '   ) ';
  s := s + '   VALUES ' + #10;
  s := s + '   ( ' + #10;
  s := s + '   ' + _db(theData.DateFound          ) + #10;
  s := s + '  ,' + _db(theData.itemDescription    ) + #10;
  s := s + '  ,' + _db(theData.locationDescription) + #10;
  s := s + '  ,' + _db(theData.returnedToOwner    ) + #10;
  s := s + '  ,' + _db(theData.returnedNotes      ) + #10;
  s := s + '   ) ';
  result := cmd_bySQL(s);
  if result then
  begin
    NewID := GetLastID('lostandfound');
  end;
end;


/// ///////////////////////////////////////////////////////////////

// recTurnoverAndPaymentsHolder = record
// id                  : integer   ; // int(11) NOT NULL AUTO_INCREMENT,
// confirmDate         : TdateTime ; // datetime DEFAULT '1900-01-01 00:00:00',
// Item                : string    ; // varchar(20) DEFAULT NULL,
// Description         : string    ; // varchar(100) DEFAULT NULL,
// Amount              : double    ; // double DEFAULT '0',
// Staff               : string    ; // varchar(20) DEFAULT NULL,
// ItemType            : string    ; // varchar(20) DEFAULT NULL,
// ItemTypeDescription : string    ; // varchar(100) DEFAULT NULL,
// itemNotes           : string    ; // varchar(100) DEFAULT NULL,
// dataType            : integer   ; // 0=not known 1=turnover 2=payments
// VatCode             : string    ; //  varchar(45) DEFAULT NULL,
// VATPercentage       : double    ; //   double DEFAULT '0',
// VAT                 : string    ; // double DEFAULT '0',
// Itemcount           : integer   ; // int(11) DEFAULT NULL,
// end;

procedure TurnoverAndPaymentsHolder(var rec: recTurnoverAndPaymentsHolder);
begin
  with rec do
  begin
    id := 0;
    confirmDate := 2; // '1900-01-01 00:00:00',
    Item := '';
    Description := '';
    Amount := 0.00;
    Staff := g.qUser;
    ItemType := '';
    ItemTypeDescription := '';
    itemNotes := '';
    dataType := 0;
    VatCode := '';
    VATPercentage := 0.00;
    VAT := '';
    Itemcount := 0;
  end;
end;

function GetDayRate(RoomType: string; RoomNumber: string; ADate: TdateTime; GuestCount: integer; ChildCount: integer; infantCount: integer; Currency: string;
  priceID: integer; Discount: double; showDiscount: boolean; isPercentage: boolean; isPaid: boolean; doAdd: boolean): double;

var
  rSet: TRoomerDataSet;
  s: string;
  ExtraPrice: double;
  p1, p2, p3, p4, p5, p6: double;
  // Price: double;
  extraPersons: double;
  Description: string;

  RateExtraChildren: double;
  RateExtraInfant: double;

begin
  extraPersons := GuestCount - 5;
  // Price      := 0.00;

  result := 0;

  if GuestCount < 1 then
  begin
    exit;
  end;

  s := s + ' SELECT '#10;
  s := s + '  `wroomrates`.`ID`, '#10;
  s := s + '  `wroomrates`.`PriceCodeID`, '#10;
  s := s + '  `wroomrates`.`pcCode`, '#10;
  s := s + '  `wroomrates`.`pcRack`, '#10;
  s := s + '  `wroomrates`.`CurrencyID`, '#10;
  s := s + '  `wroomrates`.`Currency`, '#10;
  s := s + '  `wroomrates`.`SeasonID`, '#10;
  s := s + '  `wroomrates`.`seStartDate`, '#10;
  s := s + '  `wroomrates`.`seEndDate`, '#10;
  s := s + '  `wroomrates`.`seDescription`, '#10;
  s := s + '  `wroomrates`.`RoomTypeID`, '#10;
  s := s + '  `wroomrates`.`RoomType`, '#10;
  s := s + '  `wroomrates`.`NumberGuests`, '#10;
  s := s + '  `wroomrates`.`RateID`, '#10;
  s := s + '  `wroomrates`.`RateCurrency`, '#10;
  s := s + '  `wroomrates`.`Rate1Person`, '#10;
  s := s + '  `wroomrates`.`Rate2Persons`, '#10;
  s := s + '  `wroomrates`.`Rate3Persons`, '#10;
  s := s + '  `wroomrates`.`Rate4Persons`, '#10;
  s := s + '  `wroomrates`.`Rate5Persons`, '#10;
  s := s + '  `wroomrates`.`Rate6Persons`, '#10;
  s := s + '  `wroomrates`.`RateExtraPerson`, '#10;
  s := s + '  `wroomrates`.`RateExtraChildren`, '#10;
  s := s + '  `wroomrates`.`RateExtraInfant`, '#10;
  s := s + '  `wroomrates`.`rateDescription`, '#10;
  s := s + '  `wroomrates`.`Active`, '#10;
  s := s + '  `wroomrates`.`DateFrom`, '#10;
  s := s + '  `wroomrates`.`DateTo`, '#10;
  s := s + '  `wroomrates`.`Description`, '#10;
  s := s + '  `wroomrates`.`DateCreated`, '#10;
  s := s + '  `wroomrates`.`LastModified`, '#10;
  s := s + '   DATEDIFF(DateTo,DateFrom) AS DateCount '#10;
  s := s + 'FROM '#10;
  s := s + '  `wroomrates` '#10;
  s := s + 'WHERE '#10;
  s := s + '  `PriceCodeID` = %d AND '#10;
  s := s + '  `Currency` = %s AND '#10;
  s := s + '  `RoomType` = %s AND '#10;
  s := s + '  `DateFrom` <= %s AND '#10;
  s := s + '  `DateTo` >= %s '#10;
  s := s + 'ORDER BY DateCount '#10;
  s := s + 'LIMIT 0,1 '#10;

  rSet := TRoomerDataSet.Create(nil);
  try
    s := format(s, [priceID, _db(Currency), _db(RoomType), _db(ADate), _db(ADate)]);
    hData.rSet_bySQL(rSet, s);
    // CopyToClipboard(s);
    // showmessage('select_objRoomRates_GetDayRate'#10+'  '+s);

    if not rSet.Eof then
    begin
      Description := rSet.fieldbyname('description').asString;

      RateExtraChildren := rSet.GetFloatValue(rSet.fieldbyname('RateExtraChildren'));
      RateExtraInfant := rSet.GetFloatValue(rSet.fieldbyname('RateExtraInfant'));

      ExtraPrice := rSet.GetFloatValue(rSet.fieldbyname('RateExtraPerson'));
      p1 := rSet.GetFloatValue(rSet.fieldbyname('Rate1Person'));
      p2 := rSet.GetFloatValue(rSet.fieldbyname('Rate2Persons'));
      p3 := rSet.GetFloatValue(rSet.fieldbyname('Rate3Persons'));
      p4 := rSet.GetFloatValue(rSet.fieldbyname('Rate4Persons'));
      p5 := rSet.GetFloatValue(rSet.fieldbyname('Rate5Persons'));
      p6 := rSet.GetFloatValue(rSet.fieldbyname('Rate6Persons'));

      if p1 = 0 then
        p1 := ExtraPrice;
      if p2 = 0 then
        p2 := p1 + ExtraPrice;
      if p3 = 0 then
        p3 := p2 + ExtraPrice;
      if p4 = 0 then
        p4 := p3 + ExtraPrice;
      if p5 = 0 then
        p5 := p4 + ExtraPrice;
      if p6 = 0 then
        p6 := p5 + ExtraPrice;

      if GuestCount = 1 then
        result := p1;
      if GuestCount = 2 then
        result := p2;
      if GuestCount = 3 then
        result := p3;
      if GuestCount = 4 then
        result := p4;
      if GuestCount = 5 then
        result := p5;
      if GuestCount = 6 then
        result := p6;

      if GuestCount > 6 then
        result := p6 + (extraPersons * ExtraPrice);

      result := result + (RateExtraChildren * ChildCount);
      result := result + (RateExtraInfant * infantCount);
    end;
  finally
    freeandnil(rSet);
  end;
end;

function RD_ispaid(RoomReservation: integer): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  s := '';
  s := s + 'SELECT '#10;
  s := s + ' paid  '#10;
  s := s + 'FROM '#10;
  s := s + '  roomsdate '#10;
  s := s + 'WHERE (roomreservation = %d) and (paid=1) '#10;
  s := format(s, [RoomReservation]);

  rSet := CreateNewDataSet;
  try
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;

end;



procedure FixRoomTypes;
var
  s: string;
//  rSet: TRoomerDataSet;
//  ss: string;
//  Room: string;
//  RoomType: string;
begin

  s := 'UPDATE roomreservations rr, ' +
       'roomsdate rd, ' +
       '       rooms r ' +
       'SET rr.RoomType = r.RoomType, ' +
       '    rr.rrRoomTypeAlias = r.RoomType, ' +
       '    rd.RoomType = r.RoomType, ' +
       '    rd.Updated = 0 ' +
       'WHERE rd.Room = r.Room ' +
       'AND rd.RoomReservation=rr.RoomReservation ' +
       'AND (rr.RoomType != r.RoomType OR rd.RoomType != r.RoomType) ' +
       'AND ADate>CURRENT_DATE;';

  cmd_bySQL(s);

//  s := '';
//  s := s + ' SELECT ';
//  s := s + '   Room ';
//  s := s + ' , RoomType ';
//  s := s + ' FROM ';
//  s := s + '  Rooms ';
//  s := s + ' ORDER BY Room ';
//
//  rSet := CreateNewDataSet;
//  try
//    if rSet_bySQL(rSet, s) then
//    begin
//      rSet.First;
//      while not rSet.Eof do
//      begin
//        Room := rSet.fieldbyname('Room').asString;
//        RoomType := rSet.fieldbyname('RoomType').asString;
//
//        ss := '';
//
//        ss := ss + ' UPDATE roomreservations ';
//        ss := ss + ' SET ';
//        ss := ss + '   RoomType = ' + _db(RoomType) + ', ';
//        ss := ss + '   rrRoomTypeAlias = ' + _db(RoomType) + ' ';
//
//        ss := ss + '  WHERE (Room = ' + _db(Room) + ')  AND RoomType <> (' + _db(RoomType) + ') ';
//        cmd_bySQL(ss);
//
//        ss := '';
//        ss := ss + ' UPDATE roomsdate ';
//        ss := ss + ' SET ';
//        ss := ss + '    RoomType = ' + _db(RoomType) + ' ';
//        ss := ss + '  , Updated = 0 ';
//        ss := ss + '  WHERE (Room = ' + _db(Room) + ')  AND RoomType <> (' + _db(RoomType) + ') ';
//        cmd_bySQL(ss);
//        rSet.Next;
//      end;
//    end;
//  finally
//    freeandnil(rSet);
//  end;

end;

Function changeNoRoomRoomtype(Reservation, RoomReservation: integer; oldType: string): boolean;
var
  ss: string;
  newRoomType: string;
  theData: recRoomTypeHolder;
  realType: boolean;
  Status: string;
  Arrival: Tdate;
  Departure: Tdate;

  temp : String;
begin
  result := false;

  initRoomTypeHolder(theData);

  theData.RoomType := oldType;
  openRoomTypes(actlookup, theData);
  if theData.RoomType <> '' then
  begin
    newRoomType := theData.RoomType;
  end
  else
  begin
    exit;
  end;

  realType := glb.LocateRoomType(oldType);

  if d.getChangeAvailabilityInfo(RoomReservation, oldType, Status, Arrival, Departure) then
  begin
    if g.qWarnWhenOverbooking then
      if NOT IsAvailabilityThere(oldType, newRoomType, Arrival, Departure) then exit;

    ss := '';
    ss := ss + ' UPDATE roomreservations ';
    ss := ss + ' SET ';
    ss := ss + '   [RoomType] = ' + _db(newRoomType) + ' ';
    ss := ss + '  WHERE (Roomreservation = ' + _db(RoomReservation) + ') ';
    cmd_bySQL(ss);

    ss := '';
    ss := ss + ' UPDATE [roomsdate] ';
    ss := ss + ' SET ';
    ss := ss + '    [RoomType] = ' + _db(newRoomType) + ' ';
    ss := ss + '  WHERE (Roomreservation = ' + _db(RoomReservation) + ') ';
    cmd_bySQL(ss);

    if (Status <> 'O') and (Status <> 'N') then
    begin
      if realType then
      begin
        temp := format('(changeNoRoomRoomtype) Change roomtype of a NO-ROOM booking for Reservation=%d, RoomReservation=%d, FROM RoomType=%s, FOR ArrDate=%s, DepDate=%s',
                       [Reservation, RoomReservation, oldType, DateToSqlString(Arrival), DateToSqlString(Departure)]);
        d.roomerMainDataSet.SystemChangeAvailability(oldType, Arrival, Departure - 1, false, temp); // auka framboð
      end;

      temp := format('(changeNoRoomRoomtype) Change roomtype of a NO-ROOM booking for Reservation=%d, RoomReservation=%d, TO RoomType=%s, FOR ArrDate=%s, DepDate=%s',
                     [Reservation, RoomReservation, newRoomType, DateToSqlString(Arrival), DateToSqlString(Departure)]);
      d.roomerMainDataSet.SystemChangeAvailability(newRoomType, Arrival, Departure - 1, true, temp); // minnka framboð
    end;

    result := true;
  end;
end;

Function changeNoRoomRoomtypeReturnSelection(Reservation, RoomReservation: integer; oldType: string): String;
var
  ss: string;
  newRoomType: string;
  theData: recRoomTypeHolder;
  realType: boolean;
  Status: string;
  Arrival: Tdate;
  Departure: Tdate;

  temp : String;
begin
  result := '';

  initRoomTypeHolder(theData);

  theData.RoomType := oldType;
  openRoomTypes(actlookup, theData);
  if theData.RoomType <> '' then
  begin
    newRoomType := theData.RoomType;
  end
  else
  begin
    exit;
  end;

  realType := glb.LocateRoomType(oldType);

  if d.getChangeAvailabilityInfo(RoomReservation, oldType, Status, Arrival, Departure) then
  begin
    if g.qWarnWhenOverbooking then
      if NOT IsAvailabilityThere(oldType, newRoomType, Arrival, Departure) then exit;

    ss := '';
    ss := ss + ' UPDATE roomreservations ';
    ss := ss + ' SET ';
    ss := ss + '   [RoomType] = ' + _db(newRoomType) + ' ';
    ss := ss + '  WHERE (Roomreservation = ' + _db(RoomReservation) + ') ';
    cmd_bySQL(ss);

    ss := '';
    ss := ss + ' UPDATE [roomsdate] ';
    ss := ss + ' SET ';
    ss := ss + '    [RoomType] = ' + _db(newRoomType) + ' ';
    ss := ss + '  WHERE (Roomreservation = ' + _db(RoomReservation) + ') ';
    cmd_bySQL(ss);

    if (Status <> 'O') and (Status <> 'N') then
    begin
      if realType then
      begin
        temp := format('(changeNoRoomRoomtype) Change roomtype of a NO-ROOM booking for Reservation=%d, RoomReservation=%d, FROM RoomType=%s, FOR ArrDate=%s, DepDate=%s',
                       [Reservation, RoomReservation, oldType, DateToSqlString(Arrival), DateToSqlString(Departure)]);
        d.roomerMainDataSet.SystemChangeAvailability(oldType, Arrival, Departure - 1, false, temp); // auka framboð
      end;

      temp := format('(changeNoRoomRoomtype) Change roomtype of a NO-ROOM booking for Reservation=%d, RoomReservation=%d, TO RoomType=%s, FOR ArrDate=%s, DepDate=%s',
                     [Reservation, RoomReservation, newRoomType, DateToSqlString(Arrival), DateToSqlString(Departure)]);
      d.roomerMainDataSet.SystemChangeAvailability(newRoomType, Arrival, Departure - 1, true, temp); // minnka framboð
    end;

    result := newRoomType;
  end;
end;


// Use just in Tornover and payments 2
procedure initTurnoverAndPaymentsGlobals_II(var rec: recTurnoverAndPaymentsGlobals_II);
begin
  with rec do
  begin
    Invoicelist := '';
    ConfirmState := 0;
    RoomRentItem := '';
    DiscountItem := '';
    TaxesItem := '';
    RoomRentItemDescription := '';
    DiscountItemDescription := '';
    TaxesItemDescription := '';
    RoomRentType := '';
    RoomRentTypeDescription := '';
    RoomRentVATCode := '';
    RoomRentVATPercentage := 0.00;
    DiscountType := '';
    DiscountTypeDescription := '';
    IsConfirmed := false;
    ConfirmedDate := 2;
    totalTurnover := 0;
    totalPayments := 0;

    cTaxType := '';
    cTaxTypeDescription := '';
    cTaxVATCode := '';
    cTaxVATPercentage := 0.00;


    RoomRentItem := trim(uppercase(ctrlGetString('RoomRentItem')));
    if glb.Items.Locate('Item', RoomRentItem, []) then
    begin
      RoomRentItemDescription := glb.Items.fieldbyname('Description').asString;
    end;

    DiscountItem := trim(uppercase(ctrlGetString('DiscountItem')));
    if glb.Items.Locate('Item', DiscountItem, []) then
    begin
      DiscountItemDescription := glb.Items.fieldbyname('Description').asString;
    end;

    TaxesItem := trim(uppercase(ctrlGetString('StayTaxItem')));
    if glb.Items.Locate('Item', TaxesItem, []) then
    begin
      TaxesItemDescription := glb.Items.fieldbyname('Description').asString;
    end;

    RoomRentVATPercentage := 0;
    RoomRentType := '';
    RoomRentVATCode := '';
    if glb.Items.Locate('item', RoomRentItem, []) then
    begin
      RoomRentType := glb.Items.fieldbyname('ItemType').asString;
    end;

    RoomRentTypeDescription := '';
    if glb.Itemtypes.Locate('itemtype', RoomRentType, []) then
    begin
      RoomRentTypeDescription := glb.Itemtypes.fieldbyname('Description').asString;
    end;

    if glb.Itemtypes.Locate('itemtype', RoomRentType, []) then
    begin
      RoomRentVATCode := glb.Itemtypes.fieldbyname('VATCODE').asString;
    end;

    if glb.VAT.Locate('VATCode', RoomRentVATCode, []) then
    begin
      RoomRentVATPercentage := glb.VAT.GetFloatValue(glb.VAT.fieldbyname('VATPercentage'));
    end;

    DiscountType := '';
    if glb.Items.Locate('item', DiscountItem, []) then
    begin
      DiscountType := glb.Items.fieldbyname('ItemType').asString;
    end;

    DiscountTypeDescription := '';
    if glb.Itemtypes.Locate('itemtype', DiscountType, []) then
    begin
      DiscountTypeDescription := glb.Itemtypes.fieldbyname('Description').asString;
    end;

    cTaxVATPercentage := 0;
    cTaxType := '';
    cTaxVATCode := '';
    if glb.Items.Locate('item', TaxesItem, []) then
    begin
      cTaxType := glb.Items.fieldbyname('ItemType').asString;
    end;

    cTaxTypeDescription := '';
    if glb.Items.Locate('item', TaxesItem, []) then
    begin
      cTaxTypeDescription := glb.Itemtypes.fieldbyname('Description').asString;
    end;

    if glb.Itemtypes.Locate('itemtype', cTaxType, []) then
    begin
      cTaxVATCode := glb.Itemtypes.fieldbyname('VATCODE').asString;
    end;

    if glb.VAT.Locate('VATCode', cTaxVATCode, []) then
    begin
      cTaxVATPercentage := glb.VAT.GetFloatValue(glb.VAT.fieldbyname('VATPercentage'));
    end;
  end;
end;




procedure initTurnoverAndPaymentsGlobals(var rec: recTurnoverAndPaymentsGlobals);
begin
  with rec do
  begin
    Invoicelist := '';
    ConfirmState := 0;
    RoomRentItem := '';
    DiscountItem := '';
    TaxesItem := '';
    RoomRentItemDescription := '';
    DiscountItemDescription := '';
    TaxesItemDescription := '';
    StayTaxPerNight := 0.00;
    UseStayTax := true;
    StayTaxIncluted := true;
    RoomRentType := '';
    RoomRentTypeDescription := '';
    RoomRentVATCode := '';
    RoomRentVATPercentage := 0.00;
    cTaxType := '';
    cTaxTypeDescription := '';
    cTaxVATCode := '';
    cTaxVATPercentage := 0.00;
    DiscountType := '';
    DiscountTypeDescription := '';
    IsConfirmed := false;
    ConfirmedDate := 2;
    totalTurnover := 0;
    totalPayments := 0;

    RoomRentItem := trim(uppercase(ctrlGetString('RoomRentItem')));
    if glb.Items.Locate('Item', RoomRentItem, []) then
    begin
      RoomRentItemDescription := glb.Items.fieldbyname('Description').asString;
    end;

    DiscountItem := trim(uppercase(ctrlGetString('DiscountItem')));
    if glb.Items.Locate('Item', DiscountItem, []) then
    begin
      DiscountItemDescription := glb.Items.fieldbyname('Description').asString;
    end;

    TaxesItem := trim(uppercase(ctrlGetString('StayTaxItem')));
    if glb.Items.Locate('Item', TaxesItem, []) then
    begin
      TaxesItemDescription := glb.Items.fieldbyname('Description').asString;
    end;

    UseStayTax := hData.ctrlGetBoolean('UseStayTax');
    StayTaxIncluted := hData.ctrlGetBoolean('StayTaxIncluted');

    StayTaxPerNight := 0;

    if UseStayTax then
    begin

      if glb.Items.Locate('Item', TaxesItem, []) then
      begin
        StayTaxPerNight := glb.Items.GetFloatValue(glb.Items.fieldbyname('Price'));
      end;

    end;

    RoomRentVATPercentage := 0;
    RoomRentType := '';
    RoomRentVATCode := '';
    if glb.Items.Locate('item', RoomRentItem, []) then
    begin
      RoomRentType := glb.Items.fieldbyname('ItemType').asString;
    end;

    RoomRentTypeDescription := '';
    if glb.Itemtypes.Locate('itemtype', RoomRentType, []) then
    begin
      RoomRentTypeDescription := glb.Itemtypes.fieldbyname('Description').asString;
    end;

    if glb.Itemtypes.Locate('itemtype', RoomRentType, []) then
    begin
      RoomRentVATCode := glb.Itemtypes.fieldbyname('VATCODE').asString;
    end;

    if glb.VAT.Locate('VATCode', RoomRentVATCode, []) then
    begin
      RoomRentVATPercentage := glb.VAT.GetFloatValue(glb.VAT.fieldbyname('VATPercentage'));
    end;

    DiscountType := '';
    if glb.Items.Locate('item', DiscountItem, []) then
    begin
      DiscountType := glb.Items.fieldbyname('ItemType').asString;
    end;

    DiscountTypeDescription := '';
    if glb.Itemtypes.Locate('itemtype', DiscountType, []) then
    begin
      DiscountTypeDescription := glb.Itemtypes.fieldbyname('Description').asString;
    end;

    cTaxVATPercentage := 0;
    cTaxType := '';
    cTaxVATCode := '';
    if glb.Items.Locate('item', TaxesItem, []) then
    begin
      cTaxType := glb.Items.fieldbyname('ItemType').asString;
    end;

    cTaxTypeDescription := '';
    if glb.Items.Locate('item', TaxesItem, []) then
    begin
      cTaxTypeDescription := glb.Itemtypes.fieldbyname('Description').asString;
    end;

    if glb.Itemtypes.Locate('itemtype', cTaxType, []) then
    begin
      cTaxVATCode := glb.Itemtypes.fieldbyname('VATCODE').asString;
    end;

    if glb.VAT.Locate('VATCode', cTaxVATCode, []) then
    begin
      cTaxVATPercentage := glb.VAT.GetFloatValue(glb.VAT.fieldbyname('VATPercentage'));
    end;
  end;
end;

procedure initCityTaxResultHolder(var rec: recCityTaxResultHolder);
begin
  with rec do
  begin
    Incluted                  := true;
    RentAmount                := 0.00;
    RentAmountVAT             := 0.00;
    CityTax                   := 0.00;
    CityTaxVAT                := 0.00;
  end;
end;



function StoreDescriptionExist(ss: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
   s := '';
   s := s + 'SELECT '+chr(10);
   s := s + '  Description '+chr(10);
   s := s + 'FROM '+chr(10);
   s := s + '  propertiesstore '+chr(10);
   s := s + 'WHERE '+chr(10);
   s := s + '  Description = ' + _db(ss) + ' ';

  rSet := CreateNewDataSet;
  try
    s := format(s, [_db(ss)]);
    result := rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;


function propertiesstoreGetText(ss: string) : string;
var
  s: string;
  rSet: TRoomerDataSet;
begin
   result := '';
   s := '';
   s := s + 'SELECT '+chr(10);
   s := s + '  TextContainer2 '+chr(10);
   s := s + 'FROM '+chr(10);
   s := s + '  propertiesstore '+chr(10);
   s := s + 'WHERE '+chr(10);
   s := s + '  Description = ' + _db(ss) + ' ';

  rSet := CreateNewDataSet;
  try
    s := format(s, [_db(ss)]);
    if rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('TextContainer2').AsString;
    end;
  finally
    freeandnil(rSet);
  end;
end;




{ TrecItemHolder }

constructor TrecItemHolder.Create;
begin
  initItemHolder(recHolder);
end;

constructor TrecItemHolder.Create(arecItem: recItemHolder);
begin
  Create;
  recHolder := aRecItem;
end;

{ TrecItemHolderList }

procedure TrecItemHolderList.AddrecItem(aRecItem: recitemHolder);
begin
  Add(TrecItemHolder.Create(aRecItem));
end;

initialization

{ initialization code goes here }

  listOfTables := TstringList.Create;
  listOfTables.Add('cancellationdetails');
  listOfTables.Add('channelrates');
  listOfTables.Add('channelratesavailabilities');
  listOfTables.Add('channelratesplans');
  listOfTables.Add('channels');
  listOfTables.Add('colors');
  listOfTables.Add('control');
  listOfTables.Add('countries');
  listOfTables.Add('countrygroups');
  listOfTables.Add('currencies');
  listOfTables.Add('Staffpreferences');
  listOfTables.Add('Customers');
  listOfTables.Add('Customestypes');
  listOfTables.Add('facilityactiontypes');
  listOfTables.Add('invoiceheads');
  listOfTables.Add('invoicelines');
  listOfTables.Add('invoicelinestmp');
  listOfTables.Add('items');
  listOfTables.Add('itemtypes');
  listOfTables.Add('locations');
  listOfTables.Add('maintenancecodes');
  listOfTables.Add('maintenanceroomnotes');
  listOfTables.Add('paygroups');
  listOfTables.Add('payments');
  listOfTables.Add('paytypes');
  listOfTables.Add('persons');
  listOfTables.Add('plancodes');
  listOfTables.Add('predefineddates');
  listOfTables.Add('pricetypes');
  listOfTables.Add('reservations');
  listOfTables.Add('roomreservations');
  listOfTables.Add('rooms');
  listOfTables.Add('roomsdate');
  listOfTables.Add('roomsdatetemp');
  listOfTables.Add('roomtypegroups');
  listOfTables.Add('roomtyperules');
  listOfTables.Add('roomtypes');
  listOfTables.Add('StaffMembers');
  listOfTables.Add('stafftypes');
  listOfTables.Add('tblconvertgroups');
  listOfTables.Add('tblconverts');
  listOfTables.Add('tbldelpersons');
  listOfTables.Add('tbldelreservations');
  listOfTables.Add('tbldelroomreservations');
  listOfTables.Add('tblhiddeninfo');
  listOfTables.Add('tblimportlogs');
  listOfTables.Add('tblinc');
  listOfTables.Add('tblinvoiceactions');
  listOfTables.Add('tblmaidactions');
  listOfTables.Add('tblmaidjobs');
  listOfTables.Add('tblmaidlists');
  listOfTables.Add('tblpoxexport');
  listOfTables.Add('tblpricecodes');
  listOfTables.Add('tblroomstatus');
  listOfTables.Add('tblseasons');
  listOfTables.Add('teldevices');
  listOfTables.Add('tellog');
  listOfTables.Add('telpricegroups');
  listOfTables.Add('telpricerules');
  listOfTables.Add('ttmp');
  listOfTables.Add('vatcodes');



finalization
  { finalization code goes here }
  if hData.oRoomTypeRoomCount <> nil then
    freeandnil(hData.oRoomTypeRoomCount);
  ListOfTables.Free;

end.
