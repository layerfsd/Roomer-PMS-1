unit uD;


interface

{$I Roomer.inc}

uses
    SysUtils
  , TypInfo
  , IOUtils
  , Classes
  , uDReportData
  , System.Generics.Collections
  , System.variants

  , DB
  , ImgList
  , Controls
  , Dialogs
  , Graphics
  , Forms
  , Menus
  , winProcs
  , ADODB
  , dbTables
  , ExtCtrls
  , cxGrid
  , uRegistryServices
  , dateUtils
  , ug


  , _glob
  , hData

  , ColCombo
  , NativeXml

  , kbmMemTable

  , dxmdaset
  , cxClasses
  , cxStyles
  , cxGridTableView
  , cxGraphics
  , cxEdit
  , cxContainer

  , frxClass
  , frxADOComponents
  , frxDBSet
  , frxExportImage
  , frxExportRTF
  , frxExportHTML
  , frxExportPDF
  , frxDesgn

  , uRoomerDefinitions
  , cmpRoomerDataSet
  , cmpRoomerConnection
  , cxEditRepositoryItems, ALHttpClient, ALWininetHttpClient
  ;

//const FKP_CUSTOMERS = 1;
//      FKP_PRODUCTS  = 2;
//      FKP_PAYTYPES  = 3;

type

// Todo: Redefine TKeyValuePairList as a dictionary where TKeyAndValue is a simple TPair<string, string>
  TKeyAndValue = class
    private
    FKey: String;
    FValue: String;
    public
    constructor Create(Key : String; Value : String);
    property Key : String read FKey write FKey;
    property Value : String read FValue write FValue;
  end;

    TKeyPairType = (FKP_CUSTOMERS, FKP_PRODUCTS, FKP_PAYTYPES);
    TKeyPairList = TObjectList<TKeyAndValue>;



  TRoomPackageLineEntry = class
  private
    FRoomReservation: Integer;
    FAmount: Double;
    FVatAmount: Double;
    FAmountWoVat: Double;
    FCode: String;  // ItemCode
    FDescription : string;
    FIsRoom : boolean;
    FpackageCode : string;
    FPackageDescription : string;
    FLineNo : integer;
    FaDate   : Tdate;
    FItemCount  : double;
  public
    constructor Create(
                        _Code : String;
                        _Description : string;
                        _Amount, _AmountWoVat,
                        _VatAmount : Double;
                        _RoomReservation : Integer;
                        _isRoom : boolean ;
                        _packageCode : string;
                        _packageDescription : string;
                        _lineNo : integer ;
                        _adate : Tdate;
                        _count : double
                       );
    procedure Add(_Amount, _AmountWoVat, _VatAmount : Double;  _Code,_Description : string; _count : double; _aDate : Tdate;_LineNo : integer);

    property packageCode        : String  read FpackageCode write FpackageCode;
    property packageDescription : String  read FpackageDescription write FpackageDescription;
    property Code               : String  read FCode write FCode;
    property Description        : String  read FDescription write FDescription;
    property Amount             : Double  read FAmount write FAmount;
    property AmountWoVat        : Double  read FAmountWoVat write FAmountWoVat;
    property VatAmount          : Double  read FVatAmount write FVatAmount;
    property RoomReservation    : Integer read FRoomReservation write FRoomReservation;
    property isroom             : boolean read FisRoom write FIsRoom;
    property LineNo             : integer read FLineNo write FLineNo;
    property aDate              : TDate   read FaDate write FaDate;
    property ItemCount          : double read FItemCount write FItemCount;

  end;

  TRoomPackageLineEntryList = TObjectList<TRoomPackageLineEntry>;

  Td = class(TDataModule)
    ItemsDS: TDataSource;
    viewRoomPrices1DS: TDataSource;
    rpt : TfrxReport;
    rptDesign : TfrxDesigner;
    frxPDFExport1 : TfrxPDFExport;
    frxHTMLExport1 : TfrxHTMLExport;
    frxRTFExport1 : TfrxRTFExport;
    frxJPEGExport1 : TfrxJPEGExport;
    rptDs1 : TfrxDBDataset;
    rptDS2 : TfrxDBDataset;
    rptDSHead : TfrxDBDataset;
    rptDs3 : TfrxDBDataset;
    frxADOComponents1 : TfrxADOComponents;
    MaidActionsDS: TDataSource;
    mCompanyInfo_ : TkbmMemTable;
    mtPayments_ : TkbmMemTable;
    mtHead_ : TkbmMemTable;
    mtVAT_ : TkbmMemTable;
    mtLines_ : TkbmMemTable;
    mtCompany_ : TkbmMemTable;
    mtCaptions_ : TkbmMemTable;
    mRoomTypeCountDS : TDataSource;
    memImportTypes: TdxMemData;
    memImportTypesID: TIntegerField;
    memImportTypesDescription: TStringField;
    memImportResults: TdxMemData;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    inPosMonitor: TTimer;
    telPriceGroupsDS: TDataSource;
    mQuickRes: TdxMemData;
    mQuickResRoom: TStringField;
    mQuickResDateFrom: TDateField;
    mQuickResDateTo: TDateField;
    mQuickRes2: TkbmMemTable;
    roomerMainDataSet: TRoomerDataSet;
    Items_ : TRoomerDataSet;
    wRooms_ : TRoomerDataSet;
    viewRoomPrices1_ : TRoomerDataSet;
    swSystem_People_Places_Things_ : TRoomerDataSet;
    swARCustomers_ : TRoomerDataSet;
    swItems_ : TRoomerDataSet;
    MaidActions_ : TRoomerDataSet;
    ImportLogs_: TRoomerDataSet;
    telPriceGroups_: TRoomerDataSet;
    telPriceRules_: TRoomerDataSet;
    telPriceRulesDS: TDataSource;
    kbmTemp1_: TkbmMemTable;
    kbmInvoiceLines: TkbmMemTable;
    cxEditRepository1: TcxEditRepository;
    currencyEUR2d: TcxEditRepositoryCurrencyItem;
    RoomsDateDS: TDataSource;
    mInvoiceHeadsDS: TDataSource;
    mInvoiceLinesDS: TDataSource;
    mrptTurnoverDS: TDataSource;
    PaymentListDS: TDataSource;
    RoomRentOnInvoiceDS: TDataSource;
    kbmRoomsDate_: TkbmMemTable;
    mInvoiceHeads: TkbmMemTable;
    mInvoiceLines: TkbmMemTable;
    mrptTurnover: TkbmMemTable;
    kbmPaymentList_: TkbmMemTable;
    kbmRoomRentOnInvoice_: TkbmMemTable;
    TurnoverDS: TDataSource;
    mrptPaymentsDS: TDataSource;
    RoomsDateChangeDS: TDataSource;
    PaymentsDS: TDataSource;
    kbmInvoiceLinePriceChangeDS: TDataSource;
    kbmTurnover_: TkbmMemTable;
    mrptPayments: TkbmMemTable;
    kbmRoomsDateChange_: TkbmMemTable;
    kbmPayments_: TkbmMemTable;
    kbmInvoiceLinePriceChange_: TkbmMemTable;
    confirmMonitor: TTimer;
    currencyISK2d: TcxEditRepositoryCurrencyItem;
    currencyUSD2d: TcxEditRepositoryCurrencyItem;
    currencyCAD2d: TcxEditRepositoryCurrencyItem;
    currencyGBP2d: TcxEditRepositoryCurrencyItem;
    dxMemData: TdxMemData;
    ALWinInetHTTPClient1: TALWinInetHTTPClient;
    CurrencyMXN2d: TcxEditRepositoryCurrencyItem;
    mlogInvoicelines: TkbmMemTable;
    mInvoicelines_before: TkbmMemTable;
    mInvoicelines_after: TkbmMemTable;
    mInvoicelog: TkbmMemTable;
    mGuests: TdxMemData;
    mGuestsRoomReservation: TIntegerField;
    mGuestsReservation: TIntegerField;
    mGuestsReservationName: TWideStringField;
    mGuestsArrival: TDateTimeField;
    mGuestsDeparture: TDateTimeField;
    mGuestsAdults: TIntegerField;
    mGuestsChildren: TIntegerField;
    mGuestsInfants: TIntegerField;
    mGuestsCurrencyRate: TFloatField;
    mGuestsCurrency: TStringField;
    mGuestsAverageRate: TFloatField;
    mGuestsNumDays: TIntegerField;
    mGuestsTotalStayRate: TFloatField;
    mGuestsroom: TWideStringField;
    mGuestsroomtype: TWideStringField;
    mGuestscustomer: TWideStringField;
    mGuestsPersonalID: TWideStringField;
    mGuestsCustomerName: TWideStringField;
    mGuestsBreakfast: TBooleanField;
    mGuestsRoomDescription: TWideStringField;
    mGuestsfloor: TIntegerField;
    mGuestsLocationDescription: TWideStringField;
    mGuestsmarketSegmentDescription: TWideStringField;
    mGuestsemail: TWideStringField;
    mGuestsStatusText: TWideStringField;
    mGuestsresInfo: TWideStringField;
    mGuestsRoomCount: TIntegerField;
    mGuestsRvGuestCount: TIntegerField;
    mGuestsRRGuestCount: TIntegerField;
    mGuestsGuestName: TStringField;
    mGuestsisMain: TBooleanField;
    mGuestschannel: TWideStringField;
    mGuestsBookingId: TWideStringField;
    mGuestsTotalStayRateNative: TFloatField;
    procedure DataModuleCreate(Sender : TObject);
    procedure DataModuleDestroy(Sender : TObject);
    procedure RoomTypes_NewRecord(DataSet : TDataSet);
    procedure DayNotes_BeforePost(DataSet : TDataSet);

    function getRoomTypeColors(sRoomType : string) : recStatusAttr;
    procedure roomerMainDataSetSessionExpired(Sender: TObject);
    procedure kbmRoomRentOnInvoice_BeforePost(DataSet: TDataSet);
    procedure mInvoiceHeadsBeforePost(DataSet: TDataSet);
    procedure confirmMonitorTimer(Sender: TObject);
    procedure mInvoicelines_beforeNewRecord(DataSet: TDataSet);
    procedure mInvoicelines_afterNewRecord(DataSet: TDataSet);

  private
    { Private declarations }
    lstVaribles : tstringList;
    lstValues : tstringList;

    lstMaintenanceCodes : TKeyPairList;

    procedure SetMainRoomerDataSet(ds : TRoomerDataSet; ConnectAllDatasets : Boolean = True);
    procedure LoadMaintenanceCodes;
    function LocateWRoom(Room: String): Boolean;
    procedure ClearMaintenanceCodes;
//    procedure ProcessInvoiceBackupsForDate(sourceRSet : TRoomerDataSet; sPath : String; rSet: TRoomerDataset);
//    procedure ProcessReservationBackupsForDate(sourceRSet : TRoomerDataSet; sPath: String; rSet: TRoomerDataset);
//    procedure SaveRoomerDataAsKbmMemTable(filename: String; res : String);
//    procedure SaveRoomerDataSetAsKbmMemTable(filename : String; sourceSet : TRoomerDataSet);
//    procedure LoadKbmMemTable(destSet: TdxMemData; filename: String);
//    procedure BackupsSubmitInvoiceLinesChanges;
//    procedure BackupsSubmitInvoiceHeadsChanges;
//    procedure BackupsSubmitPaymentChanges;
//    procedure removeChangedFiles;
//    procedure BackupTaxes(sourceRSet : TRoomerDataSet; sPath : String);
    procedure SelectCloudConfig;
    procedure SetDefaultCloudConfig;
    procedure SetCloudConfigByFile(filename: String);
    procedure Customers_BeforePost(DataSet: TDataSet);
    procedure CustomerTypes_AfterPost(DataSet: TDataSet);
    procedure CustomerTypes_NewRecord(DataSet: TDataSet);
    procedure inPosMonitorTimer(Sender: TObject);
    procedure Items_NewRecord(DataSet: TDataSet);
    procedure Paytypes_NewRecord(DataSet: TDataSet);
    procedure RoomTypeGroups_NewRecord(DataSet: TDataSet);
    procedure StaffMembers_NewRecord(DataSet: TDataSet);
    procedure StaffTypes_NewRecord(DataSet: TDataSet);
    procedure telPriceGroups_NewRecord(DataSet: TDataSet);
    procedure telPriceRules_NewRecord(DataSet: TDataSet);
    procedure VATCodes_NewRecord(DataSet: TDataSet);
    procedure viewRoomPrices_NewRecord(DataSet: TDataSet);
    procedure viewRoomPrices1_NewRecord(DataSet: TDataSet);
  public
    { Public declarations }
    qConnected : boolean;

    qRes,qRres : integer;


    RoomsDateSetWork : TRoomerDataSet;

    zTelPriceGroupsFilter : string;
    zTelPriceGroupsSortField : string;
    zTelPriceGroupsSortDir : string;

    zTelPriceRulesFilter : string;
    zTelPriceRulesSortField : string;
    zTelPriceRulesSortDir : string;


    zRptInitFilter : string;
    zRptInitSortField : string;
    zRptInitSortDir : string;

    zItemsFilter : string;
    zItemsSortField : string;
    zItemsSortDir : string;

    zItemTypesFilter : string;
    zItemTypesSortField : string;
    zItemTypesSortDir : string;

    zRoomPricesFilter_1 : string;
    zRoomPricesSortField_1 : string;
    zRoomPricesSortDir_1 : string;

    zMaidActionsFilter : string;
    zMaidActionsSortField : string;
    zMaidActionsSortDir : string;

    lstCollect : tstringList;

    function RetrieveFinancesKeypair(keyPairType: TKeyPairType): TKeyPairList;
    function KeyExists(keyList : TKeyPairList; key : String) : Boolean;

    procedure PrepareFixedTables;

    procedure SaveTcxGridColumnOrder(form: TForm; grid: TcxGrid);
    procedure LoadTcxGridColumnOrder(form: TForm; grid: TcxGrid);


    function colorCodeOfStatus(status: String): TColor;
    procedure CopyInvoiceToInvoiceLinesTmp(Invoice : integer; FromKredit : boolean);

    function GetCustomerCurrency(sCustomer : string) : string;
    function GetCustomerName(customer : string) : string;
    function GET_CustomerTypesDescription_byCustomerType(CustomerType : string) : string;


    // MaidActions Table
    function qryGetMaidActions(Orderstr : string) : string;
    function OpenMaidActionsQuery(var SortField, SortDir : string) : boolean;
    function Del_MaidActionByMaidAction(sAction : string) : boolean;
    function MaidActionExist(sCode : string) : boolean;


    function qryGetTelPriceGroups(Orderstr : string) : string;
    function OpenTelPriceGroupsQuery(var SortField, SortDir : string) : boolean;
    function GET_telPriceGroupsName_byCode(Code : string) : string;
    function Del_PriceGroupByCode(Code : string) : boolean;
    function PriceGroupExist(Code : string) : boolean;
    function qryGetTelPriceRules(Orderstr : string) : string;
    function OpenTelPriceRulesQuery(var SortField, SortDir : string) : boolean;
    function GET_telPriceRulesName_byCode(Code : string) : string;
    function Del_PriceRuleByCode(Code : string) : boolean;
    function PriceRuleExist(code : string) : boolean;




    function isMixedStatus(reservation : integer) : string;
    function isMixedBreakfast(reservation : integer) : string;
    function isMixedPaymentDetails(reservation : integer) : string;
    function isGroup(roomreservation : integer) : boolean;

    function GetReservationLocations(reservation : integer; var lst : tstringList) : integer;
    function GetRoomReservationLocations(roomreservation : integer; var lst : tstringList ) : integer;
    procedure insertActivityLogFromMemTable;


    // Rooms Table
//    function Del_RoomByRoom(sRoom : string) : boolean;

    function GET_RoomsDescription_byRoom(sRoom : string) : string;

    function GET_roomstatus(sRoom : string) : char;
    function RoomExists(sRoom : string) : integer;
    function RoomExists_InRoomReservation(sRoom : string) : integer;

    // Roomtypes Table
    function RoomTypeExistsInOther(sRoomType : string) : boolean;
    function RoomTypeExists(sRoomType : string) : boolean;
    function Del_RoomTypeByRoomType(sRoomType : string) : boolean;

    function RoomTypeGroupExistsInOther(sRoomTypeGroup : string) : boolean;
    function RoomTypeGroupExists(sRoomTypeGroup : string) : boolean;
    function Del_RoomTypeGroupByRoomTypeGroup(sRoomTypeGroup : string) : boolean;
    function GET_RoomTypeGroupDescription_byRoomTypeGroup(sRoomTypeGroup : string) : string;

    function qryGetViewRooms(Orderstr : string) : string;
    function OpenViewRoomsQuery(SortField, SortDir : string) : boolean;
    function getRoomText(sRoom : string) : string;

    // Locations Table
    function GET_LocationDescription_byLocation(sLocation : string) : string;
    function GET_Location_byLocationDescription(sDescription : string) : string;


    // Paytypes Table
    procedure PayTypes_InitDoExport;
    function PayTypes_isExport(sPaytype : string) : boolean;


    // ItemTypes Table
    function GET_ItemTypeDescription_byItemType(sItemType : string) : string;
    function Del_ItemTypeByItemType(sItemType : string) : boolean;
    function ItemTypeExists(sItemType : string) : boolean;
    function ItemTypeExistsInOther(sItemType : string) : boolean;


    // Items Table
    function qryGetItems(Orderstr : string) : string;
    function OpenItemsQuery(var SortField, SortDir : string) : boolean;


    // StaffMembers Table
    function GET_StaffMemberName_byInitials(sInitials : string) : string;
    function GET_StaffMemberPID_byInitials(sInitials : string) : string;


    // PriceCodes Table
    function qryGetRoomPrices_1(Orderstr : string; priceCodeID, seasonId : integer; RoomType, Currency : string; seEndDate : TdateTime) : string;

    function OpenRoomPricesQuery_1(var SortField, SortDir : string; priceCodeID, seasonID : integer; RoomType, Currency : string;
      seEndDate : TdateTime) : boolean;
    function Del_RoomPricesByID_1(Id : integer) : boolean;
    function Get_LastRoomPriceID_1 : integer;

    function getPrice_1(rtID : integer; persons : integer; var code, RoomType, Currency : string) : double;
    function getPrice_2(rtID : integer; persons : integer) : double;

    function getRackPriceID_1(seasonId : integer; RoomType, Currency : string) : integer;

    function PriceExistsByCodes(pcCode, seDescription, RoomType, Currency : string) : boolean;
    function PriceExistsByCodesAndCurrency(pcCode, Currency : string) : boolean;

    function doLogin(login, password : string) : boolean;

    // Seasons Table
    function GET_SeasonsDates_bySeasonID(seasonId : integer; var seStartdate, seEndDate : TdateTime) : boolean;
    function GET_SeasonsDescription_bySeasonID(seasonId : integer) : string;
    function GET_SeasonsId_byDescription(seDescription : string) : integer;
    function Del_SeasonByID(Id : integer) : boolean;


    function SeasonExist(aDateFrom, aDateTo : TdateTime) : boolean;
    function SeasonCount(adate : TdateTime) : integer;
    function FindSeasonID(adate : TdateTime) : integer;
    function SeasonExists_byID(seasonId : integer) : boolean;

    // tblINC Table
    function getTblINC_nextCustomerNumber : string;
    function getTblINC_Last : integer;
    function getTblINC_Length : integer;
    function getTblINC_Fill : string;

    // InvoiceLinesTmp
    function InvoiceLinesTmp_exists(iRoomReservation : integer) : boolean;
    function del_InvoiceLinesTmp(iRoomReservation : integer) : boolean;

//    function GetFirstRoomReservation(iReservation : integer) : integer;
//    function TotalDays(iReservation : integer) : integer;

    procedure UpdateBreakfastIncluted(reservation, RoomReservation : integer; BreakfastIncluted : boolean);
    procedure UpdateGroupAccountAll(reservation, RoomReservation,RoomReservationAlias : integer; GroupAccount : boolean);
    procedure UpdateGroupAccountOne(reservation, RoomReservation, RoomReservationAlias : integer; GroupAccount : boolean; InvoiceIndex : Integer = -1);
    function UpdateReservationMarket(aReservation: integer; aMarket: TReservationMarketType): boolean;

    function UpdateExpectedCheckoutTime(aReservation, aRoomReservation: integer; const aCheckoutTime: string): boolean;
    function UpdateExpectedTimeOfArrival(aReservation, aRoomReservation: integer; const aTimeOfArrival: string): boolean;

    function isAllRRSameCurrency(reservation : integer) : boolean;
    // Er Allar herbergisbókanir innan bókunnar í sama gjaldmiðli

    function GetBreakfastIncluted(reservation, RoomReservation : integer) : boolean;
    function GetGroupAccount(reservation, RoomReservation : integer) : boolean;
    // procedure UpdateStatus(reservation, RoomReservation : integer; status : string);

    function OpenInvoiceInvoiceLines(reservation, RoomReservation : integer) : integer;
    function NameOnOpenInvoice(reservation, RoomReservation : integer) : string;


    function MoveRoom(RoomReservation : integer; NewRoom : string) : boolean;

    function GetRoomList_Occupied(dtDateFrom, dtDateTo : Tdate; iRoomReservation : integer; var lst : tstringList) : boolean;
    function isDay_Occupied(dtDate : Tdate; Room : string; var RoomReservation : integer) : boolean;

    function Occupied_fromTo(dtDateFrom, dtDateTo : Tdate; Room:string) : boolean;

    function RemoveRoomsDate(iRoomReservation : integer) : boolean;

    function ChangeRrDates(RoomReservation : integer; newArrival, newDeparture : Tdate; updateRoomstatus : boolean) : boolean;

//    function RR_ChangeDates(RoomReservation : integer;newArrival, newDeparture : Tdate) : boolean;


    function isAllDatesSameInRes(reservation : integer) : boolean;


    procedure RemoveRoomReservation(RoomReservation : integer;
                                        CancelStaff
                                       ,CancelReason
                                       ,CancelInformation : string;

                                        CancelType : integer;
                                        doLog,
                                        useTrans,ask : boolean);


    procedure RemoveReservation(iReservation : integer;
                                        CancelStaff
                                       ,CancelReason
                                       ,CancelInformation : string;
                                       CancelType : integer

                             );

    procedure RemoveReservationNotSave(iReservation : integer;CancelStaff,CancelReason,CancelInformation : string;CancelType : integer);

    procedure SetAsNoRoomEnh(RoomReservation : integer; AllReservations : boolean);
    function GetCustomerFromRes(aRes : integer) : string;

    function GetInvoiceCurrency(InvoiceNumber : integer) : string;
    function GetInvoiceCurrencyAndReservationNumber(InvoiceNumber : integer;
               var Reservation, RoomReservation : Integer;
               var Room : String) : string;
    Procedure GetInvoiceCurrencyAndRate(InvoiceNumber : integer; var currency : string; var Rate : double);

    procedure AddPerson(iRoomReservation, iReservation : integer; ciCustomerInfo : recCustomerHolderEX; sType : string;
      bTransaction : boolean);

    procedure RemovePerson(iRoomReservation : integer; bTransaction : boolean);

    procedure UpdateUsersLanguage(Staff : string; iLanguage : integer);
//    function isRoomCheckedIN(iRoomReservation : integer) : boolean;

    procedure CheckInGuest(RoomReservation : integer);
    procedure CheckOutGuest(RoomReservation : integer; Room : String);

    function GetCustomerPreferences(CustomerID : string) : string;

    function GetRoomStatus(Room : string) : char;
//MOVE to hdata    function GetPriceType(RoomType : string) : string;
    function AskApproval(PayType : string) : boolean;
    function getCountryCode(aText : string) : string;


    function Item_Get_AccountKey(sItem : string) : string;
    function Item_Get_Type(Item : string) : string;

//    function Item_isRoomRent(Item : string) : boolean;

    function Item_Get_Data(aItem : string) : recItemPlusHolder;

    function Item_Del(sItem : string) : boolean;
    function Item_ExistsInOther(sItem : string) : boolean;

    function Item_Get_ItemTypeInfo(Item : string; package : String = '') : TItemTypeInfo;

    function FieldExists(rSet : TRoomerDataSet; FieldName : String): Boolean;
    function VATDescription(code : string) : string;
    function VATPercentage(code : string) : double;
    function VATvalueFormula(code : string) : String;
    function PackageVATvalueFormula(package, item : string; vatPercentage : Double) : String;
    procedure VATvalueFormulaAndPercentage(code : String; package : String; item : String; var Formula : string; var Percentage : double);

    function StaffExists(Staff : string) : boolean;
    function CustomerTypeName(CustomerTypeCode : string) : string;

    function SetInvoiceOrginalRef(Invoice, RoomReservation, OrginalRef : integer) : boolean;
    function inDateRange(seasonId : integer; FromDate, ToDate : Tdate; var RangeStart, RangeEnd : Tdate) : boolean;

    function GetRoomReservation(reservation : integer; Room : string) : integer;

//    function GetRoomsDateRoomReservation(aDate, Room : string) : integer;


    function RoomsTypeCount(CountAll : boolean) : integer;


    function isUnPaid(RoomReservation : integer) : boolean;
    function isUnPaidByRes(Reservation : integer) : boolean;

//    function ReservationDayCount(reservation : integer) : integer;
    function RemoveRoomsDatebyReservation(iReservation : integer) : boolean;
    function RemoveRoomReservationByReservation(iReservation : integer) : boolean;
    function RemoveInvoiceHeadsByReservation(iReservation : integer) : boolean;
    function RemoveReservationsByReservation(iReservation : integer) : boolean;
    function NextRoomReservatiaon(Room : string; RoomReservation : integer; noResDate : Tdate) : integer;
    function LastRoomReservatiaon(Room : string; RoomReservation : integer; noResDate : Tdate) : integer;

    function RemoveInvoiceCashInvoice : boolean;

    function InsInvoiceAction(R : TInvoiceActionRec) : boolean;

    procedure SetUnclean(Room : string);
    procedure SetAllClean;
    procedure SetAllUnClean;

    function invoice_isExport(invoiceNo : integer) : boolean;

//    function swUpdate_HomeRates(RateType, CalcStudull : integer) : double;
    function GetRoomReservatiaonArrival(RoomReservation : integer) : Tdate;

    function Del_MaidsJobsByDate(adate : Tdate; All : boolean) : boolean;

    function getRoomTypeFromRR(RR : integer) : string;
    function getChangeAvailabilityInfo(RR : integer; var RoomType,status : string; var Arrival,departure : Tdate) : boolean;
    function getCountryGroupNameFromCountry(Country : string) : string;
    function getCountryGroupFromCountry(Country : string) : string;
    function getLocationFromRoom(Room : string) : string;
    function getinStatisticsFromRoom(Room : string) : boolean;
    function getFloorFromRoom(Room : string) : integer;
    function ChangeCountry(newCountry : string; reservation, RoomReservation, Person, Medhod : integer) : boolean;
    function reservationCount(reservation : integer) : integer;
    function getCountryFromReservation(reservation : integer) : string;

    function isKredit(InvoiceNumber : integer) : boolean;
//MOVE TO HDATA    function InvoiceExists(InvoiceNumber : integer) : boolean;

    function Del_PaymentByInvoice(iNumber : integer) : boolean;

    {
      Vinnslur vegna yfirfærslu stólpa
    }


    procedure CreateMtFields;
    procedure InsertMTdata(InvoiceNumber : integer; doExport, silent : boolean; showPackage : boolean);
    procedure exportToSnertaTextRec(silent : boolean);

    procedure exportToSnertaSimpleXML(silent : boolean);

    function SnertaExportCustomers(custNo : string) : integer;
    function SnertaExportRooms(Room, prefix : string) : integer;


    function lstRR_CurrentlyCheckedIn(adate : Tdate) : tstringList;
    function isRrCurrentlyCheckedIn(RoomReservation : integer) : boolean;
    function isResCurrentlyCheckedIn(Reservation : integer) : boolean;

    function ExtStatusText(status : string; adate, Arrival, Departure : Tdate) : string;

    function Next_OccupiedDate(fromDate : Tdate; Room : string) : Tdate;
    function Next_OccupiedDayCount(fromDate : Tdate; Room : string) : integer;

    function GetCurrentGuestsXML : integer;

    procedure RR_ExcluteFromOpenInvoices(RoomReservation : integer);

    function hiddenInfo_Exists(Refrence, RefrenceType : integer) : integer; // returns field ID
    function hiddenInfo_getData(ID : integer) : recHiddenInfoHolder;
    function hiddenInfo_Append(ID: integer; newText : string; res : integer) : boolean;


    Procedure memImportResults_Fill;
    procedure memImportTypes_Fill;

    function imPortLog_getLastID : integer;
    function imPortLog_InvoiceNumber : integer;


    function imPortLog_isNewAvailable : boolean;
    procedure chkInPosMonitor;


    function IH_GetRefrence(invoiceNumber, Reservation, roomReservation : integer) : string;
    procedure IH_getPaymentsTypes(invoiceNumber : integer; var PayTypes, PayTypeDescription, payGroups, payGroupDescription : string);

    Function  IA_ActionCount(InvoiceNumber, actionID : integer) : integer;

    procedure UpdPaymentsWhenChangingReservationToGroup(reservation,roomreservation : integer);
    procedure UpdPaymentsWhenChangingReservationToRoom(reservation,roomreservation : integer);





    //*************************************************************************
    // Control functions
    ///////////////////////////////////////////////////////////////////////////

    procedure ctrlGetGlobalValues;
    function ChkCompany(Company, CompanyName : string) : boolean;

//MOVED TO hData     function PE_SetNewID  : integer;
//MOVED TO hData     function RR_SetNewID  : integer;
//MOVED TO hData     function RV_SetNewID  : integer;
//MOVED TO hData     function RV_GetLastID : integer;
//MOVED TO hData     function IVH_SetNewID  : integer;
//MOVED TO hData     function IVH_RestoreID : integer;
//MOVED TO hData     function IVH_GetLastID : integer;

    procedure ctrlSetInteger(aField : string; ivalue : integer);
    procedure ctrlSetString(aField : string; svalue : string);

    //*************************************************************
    // StatusAttr
    //-------------------------------------------------------------

    procedure Get_All_StatusAttributes;

    procedure save_StatusAttr_Blocked;
    procedure save_StatusAttr_NoShow;
    procedure save_StatusAttr_Waitinglist;
    procedure save_StatusAttr_Allotment;
    procedure save_StatusAttr_Departed;
    procedure save_StatusAttr_Departing;
    procedure save_StatusAttr_GuestLeavingNextDay;
    procedure save_StatusAttr_GuestStaying;
    procedure save_StatusAttr_ArrivingOtherLeaving;
    procedure save_StatusAttr_order;
    procedure save_StatusAttr_Canceled;
    procedure save_StatusAttr_Tmp1;
    procedure save_StatusAttr_Tmp2;


    procedure Default_StatusAttr_Blocked;
    procedure Default_StatusAttr_NoShow;
    procedure Default_StatusAttr_Waitinglist;
    procedure Default_StatusAttr_Allotment;
    procedure Default_StatusAttr_Departed;
    procedure Default_StatusAttr_Departing; //
    procedure Default_StatusAttr_GuestLeavingNextDay;
    procedure Default_StatusAttr_GuestStaying;
    procedure Default_StatusAttr_ArrivingOtherLeaving;
    procedure Default_StatusAttr_order;
    procedure Default_StatusAttr_canceled;
    procedure Default_StatusAttr_tmp1;
    procedure Default_StatusAttr_tmp2;


//---------------------------------------------------------------
    function RV_Upd_Name(Res : integer; newName : string) : boolean;
    function RR_Upd_CurrencyRoomPrice(iRoomReservation : integer;aDate:string;Currency : string; Convert : double) : boolean;

    function RR_Upd_MemoTexts(iRoomReservation : integer; HiddenInfo : string) : boolean;

    procedure RR_Upd_FirstGuestName(iRoomReservation : integer; newName : string);
    function RR_Upd_GuestCount(iRoomReservation, NewCount : integer) : boolean;
    function RE_Upd_MarketSegment(newValue : string; reservation : integer) : boolean;
    function IH_Upd_UnPaid_RR(RoomReservation : integer) : boolean;
    function RR_Upd_Package(iRoomReservation : integer; package : string) : boolean;
    function RR_clear_Package(iRoomReservation : integer; Package : string) : boolean;

    function RR_GetNumberOfRooms(iReservation: integer): integer;

    function RR_GetGuestCount(iRoomReservation : integer) : integer;
    function RR_GetRoomNr(iRoomReservation : integer) : string;
    function RR_GetRoomArrivalAndDeparture(iRoomReservation : integer; var Room : String; var Arrival, Departure : TDateTime) : boolean;

    function RR_GetArrivalDate(iRoomReservation : integer) : Tdate;
    function RR_GetDepartureDate(iRoomReservation : integer) : Tdate;

    function RR_getDates(iRoomReservation : integer) : recResDateHolder;
    function RV_getDates(iReservation : integer) : recResDateHolder;

    function RR_GetReservationName(iRoomReservation : integer) : string;
    function RR_GetMemoText(iRoomReservation : integer; VAR  RoomNotes : string; fieldName : String = 'HiddenInfo') : boolean;
    function RR_GetMemoBothTextForRoom(iRoomReservation : integer; var RoomNotes, ChannelRequest : string) : boolean;

    function RR_GetFirstGuestName(iRoomReservation : integer) : string;
    function RR_GetAllGuestNames(iRoomReservation : integer; showAll : boolean=true; showTotal : boolean=true) : string;

    function RR_GetLastGuestID(iRoomReservation : integer) : integer;
    function RR_GetFirstGuestCountry(iRoomReservation : integer) : string;
    function RR_GetFirstGuestType(iRoomReservation : integer) : string;


    function RR_GetStatus(iRoomReservation : integer) : string;
    function RR_GetIsGroopAccount(iRoomReservation : integer) : boolean;

    function RR_FirstDayAndRoom(RoomReservation : integer; var Room : string) : Tdate;
    function RV_FirstDayAndRoom(Reservation : integer; var Room : string) : Tdate;
    function Ref_FirstDayAndRoom(ref : string; var Room : string) : Tdate;

    function RV_getMemos(Reservation : integer; var information, PMinfo : string) : boolean;


    function INV_FirstDayAndRoom(invoiceNumber : integer; var Room : string; var InvoiceKind : integer) : Tdate;

    function RRlst_FromToUnpaid(DateFrom,DateTo :  Tdate) : tstringList;
    function RRlst_FromTo(DateFrom,DateTo :  Tdate) : tstringList;
    function RRlst_Departure(DateFrom,DateTo :  Tdate) : tstringList;


    function GuestlistRRlst_FromTo(DateFrom,DateTo :  Tdate; includeNoshow,includeAllotment,includeBlocked : boolean)    : tstringList;
    function GuestListRRlst_Arrival(DateFrom,DateTo :  Tdate; includeNoshow,includeAllotment,includeBlocked : boolean)   : tstringList;
    function GuestlistRRlst_Departure(DateFrom,DateTo :  Tdate; includeNoshow,includeAllotment,includeBlocked : boolean) : tstringList;


    function RRlst_DepartureNationalReport(DateFrom,DateTo :  Tdate) : tstringList;
    function RRlst_DepartureNationalReportByLocation(DateFrom,DateTo :  Tdate; Location : string) : tstringList;

    function RRlst_Arrival(DateFrom,DateTo :  Tdate) : tstringList;

    function Rvlst_CreatedFromTo(DateFrom,DateTo :  Tdate) : tstringList;
    function Rvlst_FromToGroup(DateFrom,DateTo :  Tdate) : tstringList;
    function RVlst_FromTo(DateFrom,DateTo :  Tdate) : tstringList;
    function RVlst_Arrival(DateFrom,DateTo :  Tdate; customer : string = '') : tstringList;
    function RVlst_Departure(DateFrom,DateTo :  Tdate) : tstringList;

    procedure Reservations_InitUseStayTax;

    Function GroupAccountCount(reservation : integer) : integer;
    Function BreakFastInclutedCount(reservation : integer) : integer;

    function rrGetDiscount(RoomReservation: integer; var DiscountType : integer; var DiscountAmount : double) : boolean;
    function rrEditDiscount(RoomReservation: integer; DiscountType : integer; DiscountAmount : double) : boolean;

    procedure UpdateStatusSimple(reservation, RoomReservation: Integer; newStatus : string);


    function SetAsNoRoom(RoomReservation : integer) : boolean;
    function ChkFinished(invNr : integer) : integer;

    function AddInvoiceLinesTMP(LastLineNumber,iReservation : integer) : boolean;

    procedure InsertReciptData(PaymentData : recPaymentHolder; invoiceData : recInvoiceHeadHolder);

//    function GetBackupPath: String;
    function LocateRecord(rSet : TRoomerDataSet; FieldName : String; value : Integer) : boolean; overload;
    function LocateRecord(rSet : TRoomerDataSet; FieldName : String; value : String) : boolean; overload;
    procedure ApplyFieldsToKbmMemTable(sourceSet: TRoomerDataSet; destSet: TdxMemData; loadDataSet : Boolean = True);
    procedure SaveKbmMemTable(destSet: TdxMemData; filename : String; performTouch : Boolean = False);
//    procedure BackUpDataForOutage;
//    procedure BackupControlTable(rSet : TRoomerDataSet);
//    procedure BackupInvoiceLines(rSet : TdxMemData);
//    procedure BackupInvoiceHeader(rSet : TdxMemData);
//    procedure BackupPayments(rSet: TdxMemData);
//    procedure BackupTodaysGuestsList(rSet : TRoomerDataSet);
//    function GetBackupTodaysGuests: String;
//    function GetBackupControlTable : String;
//    procedure GetBackupInvoiceLinesReservationRoomReservationsSplitNumber(Reservation, RoomReservation, Split : Integer; kbm : TdxMemData);
//    procedure GetBackupInvoiceHeadsReservationRoomReservationsSplitNumber(Reservation, RoomReservation, Split : Integer; kbm : TdxMemData);
//    procedure GetBackupPaymentsReservationRoomReservations(Reservation, RoomReservation : Integer; kbm : TdxMemData);
//    function GetBackupReservationRoomReservations(Reservation : Integer) : String;
//    function GetBackupReservationRoomsDate(Reservation : Integer) : String;
//    function GetBackupRoomReservationRoomsDate(RoomReservation : Integer) : String;
//    function GetBackupRoomIvoice(RoomReservation: Integer): String;
//    function GetBackupPersons(RoomReservation : Integer; kbm : TdxMemData) : String;
//    function GetBackupRoomReservation(RoomReservation : Integer) : String;
//    function GetBackupReservations(Reservation : Integer) : String;
//    procedure BackupsSubmitChanges;

    procedure TurnoverAndPaymentsGetAll(clearData: boolean;var  zGlob : recTurnoverAndPaymentsGlobals);
    procedure TurnoverAndPaymentsGetAll_II(clearData: boolean;var zGlob : recTurnoverAndPaymentsGlobals_II);
    procedure TurnoverAndPaymentsUpdateTurnover(var zGlob : recTurnoverAndPaymentsGlobals);
    procedure TurnoverAndPaymentsUpdateTurnover_II(var zGlob : recTurnoverAndPaymentsGlobals_II);

    procedure TurnoverAndPaymentsUpdateTurnoverItemPriceChange(var rec : recTurnoverAndPaymentsGlobals );
    procedure TurnoverAndPaymentsUpdateTurnoverItemPriceChange_II(var rec : recTurnoverAndPaymentsGlobals_II);

    procedure TurnoverAndPaymentsDoConfirm;
    procedure TurnoverAndPaymentsDoConfirm_II;

    function GetLastConfirm : TDateTime;
    procedure chkConfirmMonitor;
    procedure TurnoverAndPayemnetsClearAllData(justClose : boolean);

    function getCurrencyProperties(Currency : String) : TcxCustomEditProperties;
    procedure AddOrCreateToPackage(pckTotalsList : TRoomPackageLineEntryList;
        code : String;
        _description : string;
        RoomReservation : Integer;
        _Amount,
        _AmountWoVat,
        _VatAmount: Double;
        _isRoom : boolean;
        _packageCode : string;
        _packageDescription : string;
        _lineNo : integer ;
        _adate : Tdate;
        _count : Double
        );
    procedure GenerateOfflineReports;
    function CheckOutRoom(Reservation, RoomReservation: integer; Room: String) : Boolean;
  end;


function CreateNewDataSet : TRoomerDataSet;
function HtmlToColor(s:string;aDefault:Tcolor):TColor;
function getRowHeightFromIndex(index : Integer) : Integer;
function GenerateProformaInvoiceNumber : Integer;


var PROFORMA_INVOICE_NUMBER : integer;

{$IFDEF rmLOCALRESOURCE}
  const RoomerOpenAPIBase : String = 'http://localhost';
  const RoomerBase : String = 'http://localhost';
  const RoomerStoreBase : String = 'http://localhost';
  const RoomerBasePort : String = '8080';
  const RoomerOpenApiBasePort : String = '8080';
  const RoomerStoreBasePort : String = '8080';
{$ELSE}
//  {$IFDEF rmROOMERSSL}
    const RoomerBase : String = 'https://secure.roomercloud.net';
    const RoomerBasePort : String = '443';
//    const RoomerOpenAPIBase : String = 'https://secure.roomercloud.net';
//    const RoomerOpenApiBasePort : String = '443';
//  {$ELSE}
//    const RoomerBase : String = 'http://secure.roomercloud.net';
//    const RoomerBasePort : String = '80';
    const RoomerOpenApiBasePort : String = '80';
    const RoomerOpenAPIBase : String = 'http://secure.roomercloud.net';
//  {$ENDIF}
  const RoomerStoreBase : String = 'http://store.roomercloud.net';
  const RoomerStoreBasePort : String = '8080';
{$ENDIF}

var _RoomerBase,
    _RoomerBasePort,
    _RoomerOpenApiBasePort,
    _RoomerOpenApiBase,
    _RoomerStoreBase,
    _RoomerStoreBasePort : String;


var
  d : Td;

implementation

uses
    uPriceOBJ
  , uProvideARoom2
  , uAppGlobal
  , uDayNotes
  , uInvoiceSummeryOBJ
  , uSqlDefinitions
  , uMain
  , uInvoice
  , objRoomList2
  , PrjConst
  , uUtils
  , uStringUtils
  , uFileSystemUtils
  , uDateUtils
  , uTaxCalc
  , uActivityLogs
  , uOfflineReportGenerator
  , uFrmSelectCloudConfiguration
  , Inifiles
  , uAlerts
  , uFrmCheckOut
  ;


{$R *.dfm}

var
  RoomerStoreUri : String;
  RoomerOpenApiUri : String;
  RoomerApiUri : String;
  RoomerApiEntitiesUri : String;
  RoomerApiDatasetsUri : String;

function CreateNewDataSet : TRoomerDataSet;
begin
  result := d.roomerMainDataSet.CreateNewDataset;
end;

function Td.getCurrencyProperties(Currency : String) : TcxCustomEditProperties;
var currEdit : TObject;
begin
  Currency := UpperCase(Currency);
  currEdit := FindComponent(format('currency%s2d', [Currency]));
  if currEdit <> nil then
     result := (currEdit AS TcxEditRepositoryCurrencyItem).Properties
  else // Should not happen, except for unknown currencies
  begin
    if Currency = 'EUR' then
       result := d.currencyEUR2d.Properties
    else
    if Currency = 'ISK' then
      result := d.currencyISK2d.Properties
    else
    if Currency = 'USD' then
      result := d.currencyUSD2d.Properties
    else
    if Currency = 'CAD' then
      result := d.currencyCAD2d.Properties
    else
    if Currency = 'MXN' then
      result := d.currencyMXN2d.Properties
    else
    if Currency = 'GBP' then
      result := d.currencyGBP2d.Properties
    else
       result := d.currencyEUR2d.Properties;
  end;
end;


procedure Td.chkInPosMonitor;
var
  use : boolean;
  interval : integer;
begin
  try
    use      := g.qInPosMonitorUse;
    interval := g.qInPosMonitorChkSec;
    interval := interval*1000;
  except
    use      := false;
    interval := 5000;
  end;

  inPosMonitor.Interval := interval;
  inPosmonitor.Enabled := use;
end;


  procedure Td.LoadTcxGridColumnOrder(form : TForm; grid : TcxGrid);
var i : Integer;
begin
//  ini := TRoomerRegistryIniFile.Create();
  for i := 0 to grid.ViewCount - 1 do
    grid.Views[i].RestoreFromRegistry(form.Name + '_' + grid.Name, false, true);
end;


// *****************************


procedure Td.SetDefaultCloudConfig;
begin
  _RoomerBase := ParameterByName('RoomerBase');
  if _RoomerBase = '' then
    _RoomerBase := RoomerBase;
  _RoomerBasePort := ParameterByName('Port');
  if _RoomerBasePort = '' then
    _RoomerBasePort := RoomerBasePort;

  _RoomerStoreBase := ParameterByName('RoomerStoreBase');
  if _RoomerStoreBase = '' then
    _RoomerStoreBase := RoomerStoreBase;
  _RoomerStoreBasePort := ParameterByName('RoomerStoreBasePort');
  if _RoomerStoreBasePort = '' then
    _RoomerStoreBasePort := RoomerStoreBasePort;
  _RoomerOpenApiBasePort := ParameterByName('RoomerOpenApiBasePort');
  if _RoomerOpenApiBasePort = '' then
    _RoomerOpenApiBasePort := RoomerOpenApiBasePort;


  _RoomerOpenApiBase := ParameterByName('OpenApiBase');
  if _RoomerOpenApiBase = '' then
    _RoomerOpenApiBase := RoomerOpenAPIBase;

  RoomerOpenApiUri := _RoomerOpenApiBase + ':' + _RoomerOpenApiBasePort + '/roomer/openAPI/REST/';
  RoomerStoreUri := _RoomerStoreBase + ':' + _RoomerStoreBasePort + '/services/';
  RoomerApiUri := _RoomerBase + ':' + _RoomerBasePort + '/services/';
  RoomerApiEntitiesUri := RoomerApiUri + 'entities/';
  RoomerApiDatasetsUri := RoomerApiUri + 'datasets/';
end;

procedure Td.SetCloudConfigByFile(filename : String);
begin
  with TInifile.Create(TPath.Combine(ExtractFilePath(Application.ExeName), filename)) do
  try
    _RoomerBase := ReadString('Cloud', 'RoomerBase', RoomerBase);
    _RoomerBasePort := ReadString('Cloud', 'RoomerBasePort', RoomerBasePort);
    _RoomerStoreBase := ReadString('Cloud', 'RoomerStoreBase', RoomerStoreBase);
    _RoomerStoreBasePort := ReadString('Cloud', 'RoomerStoreBasePort', RoomerBase);
    _RoomerOpenApiBase := ReadString('Cloud', 'RoomerOpenAPIBase', RoomerOpenAPIBase);
    _RoomerOpenApiBasePort := ReadString('Cloud', 'RoomerOpenApiPort', RoomerOpenApiBasePort);

    RoomerOpenApiUri := _RoomerOpenApiBase + ':' + _RoomerOpenApiBasePort + '/roomer/openAPI/REST/';
    RoomerStoreUri := _RoomerStoreBase + ':' + _RoomerStoreBasePort + '/services/';

    RoomerApiUri := _RoomerBase + ':' + _RoomerBasePort + '/services/';
    RoomerApiEntitiesUri := RoomerApiUri + 'entities/';
    RoomerApiDatasetsUri := RoomerApiUri + 'datasets/';
  finally
    Free;
  end;
end;

procedure Td.SelectCloudConfig;
var files : TStrings;
    path : String;
begin
  files := TStringList.Create;
  try
    for Path in GetFilesInSpecifiedDirectory(ExtractFilePath(Application.ExeName), 'roomer_environment*.cfg') do
      files.Add(Path);
    if files.Count = 0 then
    begin
      SetDefaultCloudConfig;
    end else
    begin
      if files.Count = 1 then
        SetCloudConfigByFile(files[0])
      else
        SetCloudConfigByFile(SelectConfigurationEnvironment(files));
    end;
  finally
    files.Free;
  end;
end;

procedure Td.DataModuleCreate(Sender : TObject);
var OpenAPIUri : String;
begin
   qRes     := -1;
   qRRes    := -1;

  SelectCloudConfig;

//  _RoomerBase := ParameterByName('RoomerBase');
//  if _RoomerBase = '' then
//    _RoomerBase := RoomerBase;
//  _RoomerBasePort := ParameterByName('Port');
//  if _RoomerBasePort = '' then
//    _RoomerBasePort := RoomerBasePort;
//
//  _RoomerStoreBase := ParameterByName('RoomerStoreBase');
//  if _RoomerStoreBase = '' then
//    _RoomerStoreBase := RoomerStoreBase;
//  _RoomerStoreBasePort := ParameterByName('RoomerStoreBasePort');
//  if _RoomerStoreBasePort = '' then
//    _RoomerStoreBasePort := RoomerStoreBasePort;
//
//
//  OpenAPIUri := ParameterByName('OpenApiBase');  if OpenAPIUri = '' then
//    OpenAPIUri := RoomerOpenAPIBase;
//
//  RoomerOpenApiUri := OpenAPIUri + ':' + _RoomerBasePort + '/roomer/openAPI/REST/';
//  RoomerStoreUri := _RoomerStoreBase + ':' + _RoomerStoreBasePort + '/services/';
//  RoomerApiUri := _RoomerBase + ':' + _RoomerBasePort + '/services/';
//  RoomerApiEntitiesUri := _RoomerBase + ':' + _RoomerBasePort + '/services/entities/';
//  RoomerApiDatasetsUri := _RoomerBase + ':' + _RoomerBasePort + '/services/datasets/';

  roomerMainDataSet.OnSessionExpired := roomerMainDataSetSessionExpired;
  lstMaintenanceCodes := TKeyPairList.Create(True);
  SetMainRoomerDataSet(roomerMainDataSet);

  kbmInvoicelines.Open;

  //**
end;



procedure Td.chkConfirmMonitor;
var
  use : boolean;
  interval : integer;
begin
  try
    use := g.qConfirmAuto;
    interval := 120000;
    g.qLastConfirm := getLastConfirm;
    confirmMonitor.Interval := interval;
  except
    use := false;
  end;

  confirmmonitor.Enabled := use;
end;

procedure Td.SaveTcxGridColumnOrder(form : TForm; grid : TcxGrid);
var i : Integer;
begin
//  ini := TRoomerRegistryIniFile.Create();
  for i := 0 to grid.ViewCount - 1 do
      grid.Views[i].StoreToRegistry(form.Name + '_' + grid.Name, True, [], '');
end;

procedure Td.SetMainRoomerDataSet(ds : TRoomerDataSet; ConnectAllDatasets : Boolean = True);
var i : integer;
begin
  ds.RoomerStoreUri := RoomerStoreUri;
  ds.OpenApiUri := RoomerOpenApiUri;
  ds.RoomerUri := RoomerApiUri;
  ds.RoomerEntitiesUri := RoomerApiEntitiesUri;
  ds.RoomerDatasetsUri := RoomerApiDatasetsUri;

  if ConnectAllDatasets then
    for i := 0 to ComponentCount - 1 do
    begin
      if (Components[i] IS TRoomerDataSet) then
      begin
        if Components[i] <> ds then
        begin
          TRoomerDataSet(Components[i]).ParentRoomerDataSet := ds;
          TRoomerDataSet(Components[i]).RoomerStoreUri := RoomerStoreUri;
          TRoomerDataSet(Components[i]).OpenApiUri := RoomerOpenApiUri;
          TRoomerDataSet(Components[i]).RoomerUri := RoomerApiUri;
          TRoomerDataSet(Components[i]).RoomerEntitiesUri := RoomerApiEntitiesUri;
          TRoomerDataSet(Components[i]).RoomerDatasetsUri := RoomerApiDatasetsUri;
        end;
      end;
    end;
end;

procedure Td.DataModuleDestroy(Sender : TObject);
begin
  lstVaribles.Free;
  lstValues.Free;
  lstCollect.Free;
  ClearMaintenanceCodes;
  lstMaintenanceCodes.Free;
  freeandnil(RoomsDateSetWork);
  memImportResults.Close;
  memImportTypes.Close;
end;

// ******************************************************************************
// Global Table Functions
// ******************************************************************************


function Td.AddInvoiceLinesTMP(LastLineNumber,iReservation : integer) : boolean;
var
  lineHolder    : recInvoicelineHolder;
  ExecutionPlan : TRoomerExecutionPlan;
begin
  //**TTTT

  result := false;




  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  try
      if d.kbmInvoicelines.Active then
      begin
        if d.kbmInvoicelines.locate('Reservation',iReservation,[]) then
        begin
          try
            d.kbmInvoicelines.First;
            while not d.kbmInvoicelines.eof do
            begin
              if d.kbmInvoicelines.FieldByName('Reservation').AsInteger = iReservation then
              begin
                hdata.initInvoiceLineHolderRec(LineHolder);
                lineHolder.InvoiceNumber   := -1;
                lineHolder.Reservation     := d.kbmInvoicelines.FieldByName('Reservation').AsInteger;
                lineHolder.RoomReservation := d.kbmInvoicelines.FieldByName('RoomReservation').AsInteger;
                lineHolder.AutoGen         := d.kbmInvoicelines.FieldByName('AutoGen').Asstring;
                lineHolder.SplitNumber     := d.kbmInvoicelines.FieldByName('SplitNumber').AsInteger;
                inc(LastLineNumber);
                lineHolder.ItemNumber      := LastLineNumber;
                lineHolder.PurchaseDate    := d.kbmInvoicelines.FieldByName('PurchaseDate').asDateTime;
                lineHolder.ItemID          := d.kbmInvoicelines.FieldByName('ItemID').asString;
                lineHolder.Number          := d.kbmInvoicelines.FieldByName('number').asFloat; //-96
                lineHolder.Description     := d.kbmInvoicelines.FieldByName('Description').asString;
                lineHolder.Price           := d.kbmInvoicelines.FieldByName('Price').asFloat;
                lineHolder.VATType         := d.kbmInvoicelines.FieldByName('VATType').asString;
                lineHolder.TotalWOVAT      := d.kbmInvoicelines.FieldByName('TotalWOVAT').asFloat;
                lineHolder.Vat             := d.kbmInvoicelines.FieldByName('Vat').asFloat;
                lineHolder.Total           := d.kbmInvoicelines.FieldByName('Total').asFloat;
                lineHolder.AutoGenerated   := d.kbmInvoicelines.FieldByName('AutoGenerated').asBoolean;
                lineHolder.CurrencyRate    := d.kbmInvoicelines.FieldByName('CurrencyRate').asFloat;
                lineHolder.Currency        := d.kbmInvoicelines.FieldByName('Currency').asString;
                lineHolder.ReportDate      := 1;
                lineHolder.ReportTime      := '00:00';
                lineHolder.Persons         := d.kbmInvoicelines.FieldByName('Persons').asInteger;
                lineHolder.Nights          := d.kbmInvoicelines.FieldByName('Nights').asInteger;
                lineHolder.BreakfastPrice  := d.kbmInvoicelines.FieldByName('BreakfastPrice').asFloat;
                lineHolder.AYear           := d.kbmInvoicelines.FieldByName('AYear').asInteger;
                lineHolder.AMon            := d.kbmInvoicelines.FieldByName('AMon').asInteger;
                lineHolder.ADay            := d.kbmInvoicelines.FieldByName('ADay').asInteger;
                lineHolder.ilTmp           := d.kbmInvoicelines.FieldByName('ilTmp').asString;
                lineHolder.ilAccountKey    := d.kbmInvoicelines.FieldByName('ilAccountKey').asString;
                lineHolder.ItemCurrency       := d.kbmInvoicelines.FieldByName('ItemCurrency').asString;
                lineHolder.ItemCurrencyRate   := d.kbmInvoicelines.FieldByName('ItemCurrencyRate').asFloat;
                lineHolder.Discount           := d.kbmInvoicelines.FieldByName('Discount').asFloat;
                lineHolder.Discount_isPrecent := d.kbmInvoicelines.FieldByName('Discount_isPrecent').asBoolean;
                lineHolder.ImportRefrence     := d.kbmInvoicelines.FieldByName('ImportRefrence').asString;
                lineHolder.ImportSource       := d.kbmInvoicelines.FieldByName('ImportSource').asString;
                lineHolder.IsPackage          := d.kbmInvoicelines.FieldByName('IsPackage').asBoolean;
                lineHolder.confirmDate        := d.kbmInvoicelines.FieldByName('confirmdate').asdateTime;
                lineHolder.InvoiceIndex        := d.kbmInvoicelines.FieldByName('InvoiceIndex').asInteger;
                ExecutionPlan.AddExec(SQL_INS_InvoiceLine(lineHolder));
              end;
              d.kbmInvoicelines.next;
            end;

            if NOT ExecutionPlan.Execute(ptExec, True) then
            begin
              raise Exception.Create(ExecutionPlan.ExecException);
            end else
            begin
              result := d.kbmInvoicelines.recordcount > 0;
              if d.kbmInvoicelines.Active then d.kbmInvoicelines.close;
              d.kbmInvoicelines.Active := true;
            end;

          except
            on e : Exception do
            begin
              //MessageDlg('Problem: Unable to save the tmpInvoiveLines !' + #13#13 + 'The following Error came up:' + #13#13 +
                 // e.message + #13#13 + 'Please write this message down or' + #13 + 'call support with this dialog open!', mtError, [mbOK], 0);
				      MessageDlg(format(GetTranslatedText('shTx_D_UnableToSaveExceptionMessage'), [e.message]), mtError, [mbOK], 0);
			  result := false;
              raise ;
            end;
          end;
        end;
      end;
  finally
    FreeAndNil(ExecutionPlan);
  end;
end;

function Td.CheckOutRoom(Reservation, RoomReservation : integer; Room : String) : Boolean;
begin
  result := False;
  if ctrlGetBoolean('CheckOutWithPaymentsDialog') OR
     (MessageDlg(Format(GetTranslatedText('shCheckOutSelectedRoom'), [Room]), mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    ShowAlertsForReservation(Reservation, RoomReservation, atCHECK_OUT);
    if ctrlGetBoolean('CheckOutWithPaymentsDialog') then
      CheckoutGuestNoDialog(Reservation, RoomReservation, Room)
    else
      d.CheckOutGuest(RoomReservation, Room);
    Result := True;
  end;
end;


procedure Td.CopyInvoiceToInvoiceLinesTmp(Invoice : integer; fromKredit : boolean);
var
  reservation : integer;
  RoomReservation : integer;
  SplitNumber : integer;
  PurchaseDate : string;
  InvoiceNumber : integer;
  ItemNumber : integer;
  itemID : string; // (10)
  Number : double; //-96

  Description : string; // (70)
  Price : double;
  VatType : string; // (10)
  Total : double;
  TotalWOVat : double;
  Vat : double;
  CurrencyRate : double;
  Currency : string; // (5)
  persons : integer;
  Nights : integer;

  importRefrence : string;
  ImportSource   : string;
  isPackage      : boolean;

  s : string;
  Rset : TRoomerDataSet;

  sql : string;

begin
  //Empty it
  if d.kbmInvoiceLines.active then d.kbmInvoiceLines.close;
  d.kbmInvoiceLines.Open;

  //check if there is unpaid items for this roomreservation if not groupinvoice

  qRes     := -1;
  qRRes    := -1;


  Rset := CreateNewDataSet;
  try
    s := 'Select reservation, roomreservation from invoiceheads where invoicenumber = %d ';
    s := format(s , [Invoice]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      qRes     := Rset.fieldbyname('Reservation').asInteger;
      qRRes    := Rset.fieldbyname('RoomReservation').asInteger; ;

      if not fromKredit then
      begin
        if qRRes = 0 then
        begin
          //This is groupinvoice
          if isUnPaidByRes(qRes) then
          begin
			      showmessage(GetTranslatedText('shTx_D_UnpaidGroup'));
            exit;
          end;
        end else
        begin
          //This is not groupinvoice
          if isUnPaid(qRRes) then
          begin
      			showmessage(GetTranslatedText('shTx_D_UnpaidRoom'));
            exit;
          end;
        end;
      end;
    end;
  finally
    freeandnil(Rset);
  end;




  Rset := CreateNewDataSet;
  try

    sql :=
    ' SELECT '+
    '     Reservation '+
    '   , RoomReservation '+
    '   , SplitNumber '+
    '   , ItemNumber '+
    '   , PurchaseDate '+
    '   , InvoiceNumber '+
    '   , ItemID '+
    '   , Number '+
    '   , Description '+
    '   , Price '+
    '   , VATType '+
    '   , Total '+
    '   , TotalWOVat '+
    '   , Vat '+
    '   , CurrencyRate '+
    '   , Currency '+
    '   , persons '+
    '   , Nights '+
    '   , BreakfastPrice '+
    '   , importRefrence '+
    '   , ImportSource '+
    '   , isPackage '+
    ' FROM '+
    '   invoicelines '+
    ' WHERE '+
    '   (InvoiceNumber = %d ) '+
    ' ORDER BY itemNumber ';

    s := format(sql , [Invoice]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      Roomreservation := 0;
      Reservation := 0;
      while not rSet.Eof do
      begin
        reservation      := Rset.fieldbyname('Reservation').asInteger;
        RoomReservation  := Rset.fieldbyname('RoomReservation').asInteger; ;
        SplitNumber      := Rset.fieldbyname('Splitnumber').asInteger;
        ItemNumber       := Rset.fieldbyname('ItemNumber').asInteger;
        PurchaseDate     := Rset.fieldbyname('PurchaseDate').asString;
        InvoiceNumber    := Rset.fieldbyname('InvoiceNumber').asInteger;
        itemID           := Rset.fieldbyname('ItemId').asString;
        Number           := Rset.fieldbyname('number').asFloat;     //-96
        Description      := Rset.fieldbyname('Description').asString;
        Price            := LocalFloatValue(Rset.fieldbyname('Price').asString);
        VatType          := Rset.fieldbyname('VATType').asString;
        Total            := LocalFloatValue(Rset.fieldbyname('Total').asString);
        TotalWOVat       := LocalFloatValue(Rset.fieldbyname('TotalWOVat').asString);
        Vat              := LocalFloatValue(Rset.fieldbyname('Vat').asString);
        CurrencyRate     := LocalFloatValue(Rset.fieldbyname('CurrencyRate').asString);
        Currency         := Rset.fieldbyname('Currency').asString;
        persons          := Rset.fieldbyname('Persons').asInteger;
        Nights           := Rset.fieldbyname('Nights').asInteger;
        ImportSource     := Rset.fieldbyname('ImportSource').asString;
        importRefrence   := Rset.fieldbyname('importRefrence').asString;
        isPackage        := Rset['isPackage'];

        d.kbmInvoiceLines.Insert;
          d.kbmInvoicelines.FieldByName('Reservation'     ).AsInteger  := Reservation        ;
          d.kbmInvoicelines.FieldByName('RoomReservation' ).AsInteger  := RoomReservation    ;
          d.kbmInvoicelines.FieldByName('SplitNumber'     ).AsInteger  := SplitNumber        ;                    ;
          d.kbmInvoicelines.FieldByName('ItemNumber'      ).AsInteger  := ItemNumber         ;
          d.kbmInvoicelines.FieldByName('PurchaseDate'    ).AsDateTime := _dbdateToDate(PurchaseDate);
          d.kbmInvoicelines.FieldByName('InvoiceNumber'   ).AsInteger  := InvoiceNumber       ;
          d.kbmInvoicelines.FieldByName('ItemId'          ).AsString   := itemID              ;
          d.kbmInvoicelines.FieldByName('Number'          ).AsFloat    := Number              ; //-96
          d.kbmInvoicelines.FieldByName('Description'     ).AsString   := Description         ;
          d.kbmInvoicelines.FieldByName('Price'           ).AsFloat    := Price               ;
          d.kbmInvoicelines.FieldByName('VATType'         ).AsString   := VatType             ;
          d.kbmInvoicelines.FieldByName('Total'           ).AsFloat    := Total               ;
          d.kbmInvoicelines.FieldByName('TotalWOVat'      ).AsFloat    := TotalWOVat          ;
          d.kbmInvoicelines.FieldByName('VAT'             ).AsFloat    := Vat                 ;
          d.kbmInvoicelines.FieldByName('CurrencyRate'    ).AsFloat    := CurrencyRate        ;
          d.kbmInvoicelines.FieldByName('Currency'        ).AsString   := Currency            ;
          d.kbmInvoicelines.FieldByName('Persons'         ).AsInteger  := persons             ;
          d.kbmInvoicelines.FieldByName('Nights'          ).AsInteger  := Nights              ;

          d.kbmInvoicelines.FieldByName('BreakfastPrice'  ).AsFloat    := 0.00                ;

          d.kbmInvoicelines.FieldByName('ImportSource'    ).AsString   := ImportSource        ;
          d.kbmInvoicelines.FieldByName('importRefrence'  ).AsString   := importRefrence      ;
          d.kbmInvoicelines.FieldByName('isPackage'       ).AsBoolean  := isPackage           ;
          d.kbmInvoicelines.FieldByName('confirmdate'       ).AsDateTime  := 2  ;
        d.kbmInvoiceLines.post;

        Rset.Next;
      end;

      if (Reservation <> 0) then
        d.addInvoiceLinesTmp(0,Reservation);


      if not FromKredit then
      begin
        if roomreservation = 0 then
        begin
          EditInvoice(Reservation, 0, 0, 0, 0, 0, false, true,false);
        end else
        begin
          //This is not groupinvoice
          EditInvoice(Reservation, RoomReservation, 0, 0, 0, 0, false, true,false);
        end;
      end;
    end;
  finally
    freeandnil(Rset);
  end;
end;




function Td.colorCodeOfStatus(status : String) : TColor;
var
  i, iColor: Integer;
begin
  result := clWhite;
  for i := 0 to lstMaintenanceCodes.Count-1 do
    if lstMaintenanceCodes[i].Key=status then
    begin
      iColor := strtoint(lstMaintenanceCodes[i].Value);
      result := TColor(iColor);
      exit;
    end;
end;




/// ******************************************
// Customer Table
/// ******************************************


function Td.GetCustomerCurrency(sCustomer : string) : string;
begin
  //DOOPT
  result := '';
  if glb.CustomersSet.Locate('customer',sCustomer,[loCaseInsensitive]) then
  begin
    result := glb.CustomersSet.FieldByName('Currency').AsString;
  end;

end;

function Td.qryGetMaidActions(Orderstr : string) : string;
begin
  result := format(select_qryGetMaidActions , [Orderstr]);
end;

function Td.OpenMaidActionsQuery(var SortField, SortDir : string) : boolean;
begin
  zMaidActionsFilter := '';

  if MaidActions_.active then MaidActions_.close;

  MaidActions_.CommandText := qryGetMaidActions(SortField + ' ' + SortDir);
  try
    MaidActions_.open;
  except
    Showmessage(GetTranslatedText('shTx_D_MaidActionsUnavailable'));
  end;
  result := true;
end;


function Td.Del_MaidActionByMaidAction(sAction : string) : boolean;
var
  s : string;
begin
  result := true;
  s := '';
  s := s + 'DELETE '+chr(10);
  s := s + 'FROM tblmaidactions '+chr(10);
  s := s + 'WHERE  '+chr(10);
  s := s + '(maAction =' + _db(sAction) + ') '+chr(10);
  if not cmd_bySQL(s) then
  begin
    result := false;
  end;
end;


function Td.MaidActionExist(sCode : string) : boolean;
var
  s : string;
 rSet : TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_MaidActionExist , [_db(sCode)]);
    hData.rSet_bySQL(rSet,s);
    result := not rSet.Eof;
  finally
    freeandNil(rSet);
  end;
end;




function Td.qryGetTelPriceGroups(Orderstr: string): string;
begin
  result := format(select_qryGetTelPriceGroups , [Orderstr]);
end;

function Td.OpenTelPriceGroupsQuery(var SortField, SortDir: string): boolean;
var
  s : string;
begin
  zTelPriceGroupsFilter := '';
  s :=  qryGetTelPriceGroups(SortField + ' ' + SortDir);
  result := hData.rSet_bySQL(telPriceGroups_,s);
end;

function Td.GET_telPriceGroupsName_byCode(Code: string): string;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  result := '';
  rSet := CreateNewDataSet;
  try
    s := format(select_GET_telPriceGroupsName_byCode , [ _db(code)]);
    hData.rSet_bySQL(rSet,s);
    result := trim(rSet.fieldbyname('Description').asString);
  finally
    freeandNil(rSet);
  end;
end;

function Td.Del_PriceGroupByCode(Code: string): boolean;
var
  s : string;
begin
  result := true;
  s := '';
  s := s + 'DELETE '+chr(10);
  s := s + 'FROM telpricegroups '+chr(10);
  s := s + 'WHERE  '+chr(10);
  s := s + '(Code =' + _db(Code) + ') '+chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;


function Td.PriceGroupExist(Code: string): boolean;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_PriceGroupExist , [_db(code)]);
    hData.rSet_bySQL(rSet,s);
    result := not rSet.Eof;
  finally
    freeandNil(rSet);
  end;
end;


/// ******************************************
// PriceRule Table
/// ******************************************

function Td.qryGetTelPriceRules(Orderstr: string): string;
begin
  result := format(select_qryGetTelPriceRules , [Orderstr]);
end;

function Td.OpenTelPriceRulesQuery(var SortField, SortDir: string): boolean;
var
  s : string;
begin
  zTelPriceRulesFilter := '';
  s := qryGetTelPriceRules(SortField + ' ' + SortDir);
  result := hData.rSet_bySQL(telPriceRules_,s);
end;


function Td.GET_telPriceRulesName_byCode(code: string): string;
var
  s : string;
  rCount : integer;
  rSet : TRoomerDataSet;
begin
  result := '';
  rSet := CreateNewDataSet;
  try
    s := format(select_GET_telPriceRulesName_byCode , [_db(code)]);
    hData.rSet_bySQL(rSet,s);
    rCount := rSet.recordCount;
    if rCount > 0 then
    begin
      result := trim(rSet.fieldbyname('Description').asString);
    end;
  finally
    freeandNil(rSet);
  end;
end;

function Td.Del_PriceRuleByCode(Code: string): boolean;
var
  s : string;
begin
  result := true;
  s := '';
  s := s + 'DELETE '+chr(10);
  s := s + 'FROM telpricerules '+chr(10);
  s := s + 'WHERE  '+chr(10);
  s := s + '(Code =' + _db(code) + ') '+chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;


function Td.PriceRuleExist(Code: string): boolean;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_PriceRuleExist , [_db(code)]);
    hData.rSet_bySQL(rSet,s);
    result := not rSet.Eof;
  finally
    freeandNil(rSet);
  end;
end;



/// ******************************************
  // GetTblInc Table
  /// ******************************************


function Td.getTblINC_nextCustomerNumber : string;
var
  s : string;
  ch : char;
  iCustLast : integer;
  iCustlength : integer;
  sCustFill : string;
  sCustLast : string;
  rSet : TRoomerDataSet;
begin
  ch := '0';
  result := '';

  rSet := CreateNewDataSet;
  try
    s := format(select_getTblINC_nextCustomerNumber , []);
    if hData.rSet_bySQL(rSet,s) then
    begin
      iCustLast := rSet.fieldbyname('custlast').asInteger;
      iCustlength := rSet.fieldbyname('custLength').asInteger;
      sCustFill := rSet.fieldbyname('custFill').asString;

      iCustLast := iCustLast + 1;
      if length(sCustFill) > 0 then
         ch := sCustFill[1]
      else
        sCustFill := '0';

      sCustLast := inttostr(iCustLast);

      result := _strPadChL(sCustLast, ch, iCustlength);

      rSet.edit;
      rSet.fieldbyname('custlast').asInteger := iCustLast;
      rSet.Post; //ID ADDED
    end;
  finally
    freeandNil(rSet);
  end;
end;


function Td.getTblINC_Last : integer;
var
  s : string;
  iCustLast : integer;
  rSet : TRoomerDataSet;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    s := format(select_getTblINC_Last , []);
    if hData.rSet_bySQL(rSet,s) then
    begin
      iCustLast := rSet.fieldbyname('custlast').asInteger;
      result := iCustLast;
    end;
  finally
    freeandNil(rSet);
  end;
end;

function Td.getTblINC_Length : integer;
var
  s : string;
  iCustlength : integer;
  rSet : TRoomerDataSet;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    s := format(select_getTblINC_Length , []);
    if hData.rSet_bySQL(rSet,s) then
    begin
      iCustlength := rSet.fieldbyname('custLength').asInteger;
      result := iCustlength;
    end;
  finally
    freeandNil(rSet);
  end;
end;

function Td.getTblINC_Fill : string;
var
  s : string;
  sCustFill : string;
  rSet : TRoomerDataSet;
begin
  result := '0';
  rSet := CreateNewDataSet;
  try
    s := format(select_getTblINC_Fill , []);
    if hData.rSet_bySQL(rSet,s) then
    begin
      sCustFill := rSet.fieldbyname('custFill').asString;
      if length(sCustFill) > 0 then
        result := sCustFill[1]
      else
        result := '0';
    end;
  finally
    freeandNil(rSet);
  end;
end;



function Td.GET_CustomerTypesDescription_byCustomerType(CustomerType : string) : string;
begin
  result := '';
  if glb.CustomertypesSet.Locate('CustomerType',CustomerType,[loCaseInsensitive]) then
  begin
    result := glb.CustomerTypesSet.FieldByName('description').AsString;
  end;
end;

//function Td.CustomerTypeExist(sCustomerType : string) : boolean;
//var
//  s : string;
//  rSet : TRoomerDataSet;
//begin
//  result := true;
//  rSet := CreateNewDataSet;
//  try
//    s := format(select_CustomerTypeExist , [_db(sCustomerType)]);
//    result := hData.rSet_bySQL(rSet,s);
//  finally
//    freeandNil(rSet);
//  end;
//end;

//function Td.CustomerTypeExistsInOther(sCustomerType : string) : boolean;
//var
//  s : string;
//  rSet : TRoomerDataSet;
//begin
//  result := false;
//  rSet := CreateNewDataSet;
//  try
//    s := format(select_CustomerTypeExistsInOther , [_db(sCustomerType)]);
//    result := hData.rSet_bySQL(rSet,s);
//  finally
//    freeandNil(rSet);
//  end;
////  s := s + ' SELECT CustomerType FROM [Customers] '+chr(10);
////  s := s + ' WHERE (CustomerType = ' + _db(sCustomerType) + ') '+chr(10);
//
//end;


procedure Td.CustomerTypes_NewRecord(DataSet : TDataSet);
begin
  DataSet.fieldbyname('Priority').asInteger := 0;
end;

procedure Td.CustomerTypes_AfterPost(DataSet : TDataSet);
begin
end;

  // ****************************************************
  // Halls Table
  // ****************************************************


  // ****************************************************
  // Countries Table
  // ****************************************************


  // **************************************************************
  // CountryGroups Table
  //
  // **************************************************************


  // **************************************************************
  // Rooms Table
  // **************************************************************

function Td.GET_RoomsDescription_byRoom(sRoom : string) : string;
begin
  result := '';
  if glb.LocateRoom(sRoom) then
    result := glb.RoomsSet['description'];
end;

function Td.RoomExists(sRoom : string) : integer;
begin
  result := ABS(ORD(glb.LocateRoom(sRoom)));
end;

function Td.RoomExists_InRoomReservation(sRoom : string) : integer;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_RoomExists_InRoomReservation , [_db(sRoom)]);
    hData.rSet_bySQL(rSet,s);
    result := rSet.recordCount;
  finally
    freeandNil(rSet);
  end;
//    s := '';
//    s := s + 'SELECT Room '+chr(10);
//    s := s + 'FROM RoomReservations  '+chr(10);
//    s := s + 'WHERE  '+chr(10);
//    s := s + '(Room =' + _db(sRoom) + ') '+chr(10);
end;


function Td.isMixedStatus(reservation : integer) : string;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  result := 'MIXED';

  s := '';
  s := s + 'SELECT distinct resflag from roomsdate where reservation=%d ';

  rSet := CreateNewDataSet;
  try
    s := format(s , [reservation]);
    hData.rSet_bySQL(rSet,s);
    if rSet.recordCount =  1 then result := rSet.fieldbyname('resflag').asstring;
  finally
    freeandNil(rSet);
  end;


end;


function Td.isMixedBreakfast(reservation : integer) : string;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  result := 'MIXED';


  s := '';
  s := s + 'SELECT distinct invBreakfast from roomreservations where reservation=%d ';

  rSet := CreateNewDataSet;
  try
    s := format(s , [reservation]);
    hData.rSet_bySQL(rSet,s);
    if rSet.recordCount =  1 then result := _bool2str(rSet.fieldbyname('invBreakfast').asboolean,0);
  finally
    freeandNil(rSet);
  end;

end;


function Td.isMixedPaymentDetails(reservation : integer) : string;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  result := 'MIXED';
  s := '';
  s := s + 'SELECT distinct Groupaccount from roomreservations where reservation=%d ';

  rSet := CreateNewDataSet;
  try
    s := format(s , [reservation]);
    hData.rSet_bySQL(rSet,s);
    if rSet.recordCount =  1 then result := _bool2str(rSet.fieldbyname('Groupaccount').asboolean,0);
  finally
    freeandNil(rSet);
  end;
end;


function Td.isGroup(roomreservation : integer) : boolean;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  s := '';
  s := s + 'SELECT Groupaccount from roomreservations where roomreservation=%d ';

  rSet := CreateNewDataSet;
  try
    s := format(s , [roomreservation]);
    hData.rSet_bySQL(rSet,s);
    result := rSet.fieldbyname('Groupaccount').asboolean;
  finally
    freeandNil(rSet);
  end;
end;


function Td.GetReservationLocations(reservation : integer; var lst : tstringList ) : integer;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  s := '';
  s := s+'Select DISTINCT '#10;
  s := s+'   rv.reservation '#10;
  s := s+'  , (SELECT Location FROM roomtypes WHERE Roomtype=rr.Roomtype) AS Location '#10;
  s := s+' FROM '#10;
  s := s+'  reservations rv '#10;
  s := s+'  INNER JOIN roomreservations rr ON rr.Reservation=rv.Reservation '#10;
  s := s+' WHERE '#10;
  s := s+'  rv.reservation='+_db(reservation)+' '#10;

// copytoclipboard(s);
// debugmessage(s);

  rSet := CreateNewDataSet;
  try
    if hData.rSet_bySQL(rSet,s) then
    begin
      while not Rset.Eof do
      begin
        lst.Add(rSet.fieldbyname('location').asString);
        Rset.Next;
      end;
    end;
    result := lst.Count;
  finally
    freeandNil(rSet);
  end;
end;


function Td.GetRoomReservationLocations(roomreservation : integer; var lst : tstringList ) : integer;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  s := '';
  s := s+'Select '#10;
  s := s+'    rr.roomreservation '#10;
  s := s+'   ,rr.Room '#10;
  s := s+'   ,rr.Roomtype '#10;
  s := s+'   ,rt.location '#10;
  s := s+' FROM '#10;
  s := s+'  roomreservations rr '#10;
  s := s+'  INNER JOIN roomtypes rt ON rt.Roomtype=rr.Roomtype '#10;
  s := s+' WHERE '#10;
  s := s+'  rr.roomreservation='+_db(roomreservation)+' '#10;


  rSet := CreateNewDataSet;
  try
    if hData.rSet_bySQL(rSet,s) then
    begin
      while not Rset.Eof do
      begin
        lst.Add(rSet.fieldbyname('location').asString);
        Rset.Next;
      end;
    end;
    result := lst.Count;
  finally
    freeandNil(rSet);
  end;
end;



//function Td.Del_RoomByRoom(sRoom : string) : boolean;
//var
//  s : string;
//  rdCount : integer;
//begin
//    rdCount := RoomExists_InRoomReservation(sRoom);
//    if rdCount > 0 then
//    begin
//      Showmessage(format(GetTranslatedText('shTx_D_RoomBeingUsedInReservations'), [sRoom, rdCount]));
//	 result := false;
//      exit;
//    end;
//
//    result := true;
//
//    s := '';
//    s := s + 'DELETE '+chr(10);
//    s := s + 'FROM rooms '+chr(10);
//    s := s + 'WHERE  '+chr(10);
//    s := s + '(Room =' + _db(sRoom) + ') '+chr(10);
//    if not cmd_bySQL(s) then
//    begin
//      result := false;
//    end;
//  end;

function Td.GET_roomstatus(sRoom : string) : char;
var
  s : string;
  sTmp : string;
  rSet : TRoomerDataSet;
begin
  result := 'C';
  rSet := CreateNewDataSet;
  try
    s := format(select_GET_roomstatus, [_db(sRoom)]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      sTmp := rSet.fieldbyname('status').asString;
      if length(sTmp) > 0 then
        result := sTmp[1];
    end;
  finally
    freeandNil(rSet);
  end;
end;


function Td.GET_RoomTypeGroupDescription_byRoomTypeGroup(sRoomTypeGroup : string) : string;
begin
  result := '';
  if glb.LocateRoomTypeGroup(sRoomTypeGroup) then
    result:= glb.RoomTypeGroups['Description'];
end;

//function TD.GET_RoomTypeDescription_byRoomType(sRoomType : string) : string;
//var
//  s : string;
//  rCount : integer;
//  rSet : TRoomerDataSet;
//begin
//  result := '';
//  rSet := CreateNewDataSet;
//  try
//    s := format(select_GET_RoomTypeDescription_byRoomType , [_db(sRoomType)]);
//    if hData.rSet_bySQL(rSet,s) then
//    begin
//      result := trim(rSet.fieldbyname('Description').asString);
//    end;
//  finally
//    freeandNil(rSet);
//  end;
////    s := '';
////    s := s + 'SELECT Description '+chr(10);
////    s := s + 'FROM RoomTypes  '+chr(10);
////    s := s + 'WHERE  '+chr(10);
////    s := s + '(RoomType =' + _db(sRoomType) + ') '+chr(10);
//end;

//function TD.GET_RoomTypeNumberGuests_byRoomType(sRoomType : string) : integer;
//var
//  s : string;
//  rSet : TRoomerDataSet;
//begin
//  result := - 1;
//  rSet := CreateNewDataSet;
//  try
//    s := format(select_GET_RoomTypeNumberGuests_byRoomType , [_db(sRoomType)]);
//    if hData.rSet_bySQL(rSet,s) then
//    begin
//      result := rSet.fieldbyname('NumberGuests').asInteger;
//    end;
//  finally
//    freeandNil(rSet);
//  end;
////    s := '';
////    s := s + 'SELECT NumberGuests '+chr(10);
////    s := s + 'FROM RoomTypes  '+chr(10);
////    s := s + 'WHERE  '+chr(10);
////    s := s + '(RoomType =' + _db(sRoomType) + ') '+chr(10);
//end;

function Td.Del_RoomTypeByRoomType(sRoomType : string) : boolean;
var
  s : string;
begin
    result := true;

    if RoomTypeExistsInOther(sRoomType) then
    begin
	    Showmessage(format(GetTranslatedText('shTx_D_TableUsingCannotDelete'), [sRoomType]));
      result := false;
      exit
    end;

    s := '';
    s := s + 'DELETE '+chr(10);
    s := s + 'FROM roomtypes '+chr(10);
    s := s + 'WHERE  '+chr(10);
    s := s + '(RoomType =' + _db(sRoomType) + ') '+chr(10);
    if not cmd_bySQL(s) then
    begin
      result := false;
    end;
end;

  function Td.Del_RoomTypeGroupByRoomTypeGroup(sRoomTypeGroup : string) : boolean;
  var
    s : string;
  begin
    result := true;

    if RoomTypeGroupExistsInOther(sRoomTypeGroup) then
    begin
	    Showmessage(format(GetTranslatedText('shTx_D_TableUsingCannotDelete'), [sRoomTypeGroup]));
      result := false;
      exit
    end;

    s := '';
    s := s + 'DELETE '+chr(10);
    s := s + 'FROM roomtypegroups '+chr(10);
    s := s + 'WHERE  '+chr(10);
    s := s + '(Code =' + _db(sRoomTypeGroup) + ') '+chr(10);
    if not cmd_bySQL(s) then
    begin
      result := false;
    end;
end;

procedure Td.RoomTypes_NewRecord(DataSet : TDataSet);
begin
  DataSet.fieldbyname('NumberGuests').asInteger := 1;
  DataSet.fieldbyname('Webable').AsBoolean := true;
end;

function Td.RoomTypeExistsInOther(sRoomType : string) : boolean;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  result := true;
  rSet := CreateNewDataSet;
  try
    s := format(select_RoomTypeExistsInRooms , [_db(sRoomType)]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      exit;
    end;
  finally
    freeandNil(rSet);
  end;
  result := false;
end;

function Td.RoomTypeGroupExistsInOther(sRoomTypeGroup : string) : boolean;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_RoomTypeGroupExistsInOther , [_db(sRoomTypeGroup)]);
    result := hData.rSet_bySQL(rSet,s);
  finally
    freeandNil(rSet);
  end;
//    s := s + ' SELECT RoomTypeGroup FROM [RoomTypes] '+chr(10);
//    s := s + ' WHERE (RoomTypeGroup = ' + _db(sRoomTypeGroup) + ') '+chr(10);
end;

procedure Td.RoomTypeGroups_NewRecord(DataSet : TDataSet);
begin
  DataSet.fieldbyname('MaxCount').asInteger := 1;
  DataSet.fieldbyname('MinGuests').asInteger := 2;
  DataSet.fieldbyname('MaxGuests').asInteger := 2;
  DataSet.fieldbyname('MaxCount').asInteger := 1000;
  DataSet.fieldbyname('MaxChildren').asInteger := 0;
end;

function Td.RoomTypeExists(sRoomType : string) : boolean;
begin
  result := glb.LocateRoomType(sRoomType);
end;

function Td.RoomTypeGroupExists(sRoomTypeGroup : string) : boolean;
begin
  result := glb.LocateRoomTypeGroup(sRoomTypeGroup);
end;

function Td.getRoomText(sRoom : string) : string;
var
  s : string;
  iRoomIndex : integer;
  RoomItem : TRoomItem;
  StatusColor : TColor;
begin
  s := ''; // '<body bgcolor="#808080"><font color="#FFFFFF">';
  s := s + '<b><shad>' + GetTranslatedText('shRoomInformation') + '</shad></b><br>';
  if copy(sRoom, 1, 1) = '<' then
  begin
    s := s + '<br><b>' + GetTranslatedText('shRoomNotAssignedYet') + '</b>';
  end else
  if LocateWRoom(sRoom) then
  begin
    s :=   s + '<b>' + GetTranslatedText('shRoom') + ' : <font ' +
            GetHTMLColor(frmMain.sSkinManager1.GetHighLightColor(true), true) + ' ' +
            GetHTMLColor(frmMain.sSkinManager1.GetHighLightFontColor(true), false) + '>' +
            sRoom + '</font></b>'+ #13;
    s :=   s + GetTranslatedText('shTx_Description') + ' : ' + wRooms_.fieldbyname('roDescription').asString + #13;
    s :=   s + GetTranslatedText('shType') + ' : ' + wRooms_.fieldbyname('rtRoomTypeDescription').asString + #13;
    s :=   s + GetTranslatedText('shTx_Location') + ' : ' + wRooms_.fieldbyname('rlDescription').asString + #13;
    s :=   s + GetTranslatedText('shTx_Floor') + ' : ' + wRooms_.fieldbyname('floor').asString + #13;
    s :=   s + GetTranslatedText('shTx_NumGuests') + ' : ' + wRooms_.fieldbyname('numberGuests').asString + #13;

    iRoomIndex := g.oRooms.FindRoomFromRoomNumber(sRoom);
    if iRoomIndex >= 0 then
    begin
      RoomItem := g.oRooms.RoomItemsList[iRoomIndex];
      StatusColor := d.colorCodeOfStatus(RoomItem.Status);
      s := s + '<hr><br><b><shad>' + GetTranslatedText('shTx_Status') + ' : <font ' +
            GetHTMLColor(StatusColor, true) + ' ' +
            GetHTMLColor(clWhite, false) + '>' +
            RoomItem.StatusDescripton + '</font></shad></b>' + #13;

      if NOT RoomItem.ReportUser.IsEmpty then
        s := s + GetTranslatedText('shTx_ReportedBy') + ' : [' + RoomItem.ReportUser + '] ' + RoomItem.ReportUserName + #13;

      if NOT RoomItem.CleaningNotes.IsEmpty then
        s := s + '   * ' + GetTranslatedText('shTx_CleaningNotes') + ' : ' + RoomItem.CleaningNotes + #13;
      if NOT RoomItem.MaintenanceNotes.IsEmpty then
        s := s + '   * ' + GetTranslatedText('shTx_MaintenanceNotes') + ' : <font ' +
            GetHTMLColor(clBlue, true) +  ' ' +
            GetHTMLColor(clWhite, false) + '>' +
            RoomItem.MaintenanceNotes + '</font>' + #13;
      if NOT RoomItem.LostAndFound.IsEmpty then
        s := s + '   * ' + GetTranslatedText('shTx_LostAndFount') + ' : <font ' +
            GetHTMLColor(clRed, true) + ' ' +
            GetHTMLColor(clWhite, false) + '>' +
            RoomItem.LostAndFound + '</font>' + #13;
    end;


    s := s + '<hr><br><b><shad>' + GetTranslatedText('shTx_Equipment') + ' : ' + '</shad></b>' + #13;
    s := s + '<b>' + wRooms_.fieldbyname('Equipments').asString + '</b>' + #13;
    if wRooms_['kitchen'] then
      s := s + 'kitchen' + #13;
    if wRooms_['Fridge'] then
      s := s + 'Fridge' + #13;
    if wRooms_['Coffee'] then
      s := s + 'Coffee maqchine' + #13;
    if wRooms_['Minibar'] then
      s := s + 'MiniBar' + #13;
    if wRooms_['Safe'] then
      s := s + 'Cooking' + #13;
     if wRooms_['Radio'] then
      s := s + 'Radio' + #13;
    if wRooms_['CDPlayer'] then
      s := s + 'Stereos' + #13;
    if wRooms_['Tv'] then
      s := s + 'TV' + #13;
    if wRooms_['video'] then
      s := s + 'Video/DVD' + #13;
     if wRooms_['telephone'] then
      s := s + 'Telephone' + #13;
    if wRooms_['Fax'] then
      s := s + 'Fax' + #13;
    if wRooms_['InternetPlug'] then
      s := s + 'internet plug' + #13;
     if wRooms_['Bath'] then
      s := s + 'Bath' + #13;
    if wRooms_['Shower'] then
      s := s + 'Shower' + #13;
    if wRooms_['Hairdryer'] then
      s := s + 'Hairdryer' + #13;
    if wRooms_['Press'] then
      s := s + 'Sofa';

//    s := s + '</body>';
  end;
  result := s;
end;

function Td.LocateWRoom(Room : String) : Boolean;
begin
  result := false;
  wRooms_.First;
  while not wRooms_.eof do
  begin
    if LowerCase(wRooms_['Room']) = LowerCase(Room) then
    begin
      result := true;
      Break;
    end;
    wRooms_.next;
  end;
end;

function Td.qryGetViewRooms(Orderstr : string) : string;
begin
//    s := '';
//    s := s + 'SELECT '+chr(10);
//    s := s + '* '+chr(10);
//    s := s + 'FROM '+chr(10);
//    s := s + 'wRooms '+chr(10);
//    s := s + 'ORDER BY ' + Orderstr + ' '+chr(10);
  result := format(select_qryGetViewRooms , [orderstr]);;
end;

function Td.OpenViewRoomsQuery(SortField, SortDir : string) : boolean;
begin
  result := hData.rSet_bySQL(wRooms_,qryGetViewRooms(SortField));
end;


  // **************************************************************
  // Locations Table
  //
  // **************************************************************

function Td.GET_LocationDescription_byLocation(sLocation : string) : string;
begin
  result := '';
  if glb.LocateLocation(sLocation) then
    result := glb.Locations['Description'];
end;


function Td.GET_Location_byLocationDescription(sDescription : string) : string;
begin
  result := '';
  glb.Locations.First;
  while not glb.Locations.eof do
  begin
    if LowerCase(glb.Locations['Description']) = LowerCase(sDescription) then
    begin
      result := glb.Locations['Location'];
      Break;
    end;
    glb.Locations.next;
  end;
end;



function Td.lstRR_CurrentlyCheckedIn(adate : Tdate) : tstringList;
var
  s : string;
  Rset : TRoomerDataSet;
  RoomReservation : integer;
  sql : string;
begin
  result := tstringList.Create;
  Rset := CreateNewDataSet;
  try
  //**zxhj þarf ekki að breyta hér   //Checket ok

  sql :=
  ' SELECT '+
  '    roomsdate.ADate '+
  '   , roomsdate.Room '+
  '   , roomsdate.RoomType '+
  '   , roomsdate.RoomReservation '+
  '   , roomsdate.Reservation '+
  '   , roomsdate.ResFlag '+
  '   , roomreservations.Arrival '+
  '   , roomreservations.Departure '+
  ' FROM '+
  '   roomsdate INNER JOIN '+
  '     roomreservations ON roomsdate.RoomReservation = roomreservations.RoomReservation '+
  ' WHERE '+
  '   ((roomsdate.ADate =  %s ) AND (roomsdate.ResFlag = ''G'' )) '+
  ' OR '+
  '   ((roomsdate.ADate =  %s ) AND (roomsdate.ResFlag = ''G'' )'+
  '   AND (roomreservations.Departure =  %s )) ';


    s := format(sql , [_DateToDBDate(adate,true), _DateToDBDate(adate - 1,true),_DateToDBDate(adate,true)]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      while not Rset.Eof do
      begin
        RoomReservation := Rset.fieldbyname('RoomReservation').asInteger;
        result.Add(inttostr(RoomReservation));
        Rset.Next;
      end;
    end;
  finally
    freeandnil(Rset);
  end;
end;


function td.isRrCurrentlyCheckedIn(RoomReservation : integer) : boolean;
var
  s     : string;
  Rset  : TRoomerDataSet;
  aDate : Tdate;
  sql   : string;
begin
    aDate := date;
    Rset := CreateNewDataSet;
    try
      //**zxhj þarf ekki að breyta hér  //  checked ok
      sql :=
      ' SELECT '+
      '     roomsdate.ADate '+
      '   , roomsdate.ResFlag '+
      '   , roomreservations.Departure '+
      ' FROM '+
      '   roomsdate '+
      '     INNER JOIN '+
      '   roomreservations ON roomsdate.RoomReservation = roomreservations.RoomReservation '+
      ' WHERE '+
      '   (roomsdate.RoomReservation =  %d ) '+
      '     AND (roomsdate.ADate =  %s ) '+
      '     AND (roomsdate.ResFlag = ''G'' ) '+
      '   OR '+
      '   (roomsdate.RoomReservation = %d) '+
      '     AND (roomsdate.ADate =  %s ) '+
      '     AND (roomsdate.ResFlag =  ''G'' ) '+
      '     AND (roomreservations.Departure =   %s ) ';

      s := format(sql , [RoomReservation,_DateToDBDate(adate,true),RoomReservation,_DateToDBDate(adate-1,true),_DateToDBDate(adate,true) ]);
      result := hData.rSet_bySQL(rSet,s);
    finally
      freeandnil(Rset);
    end;
  end;


function td.isResCurrentlyCheckedIn(Reservation : integer) : boolean;
var
  s : string;
  Rset : TRoomerDataSet;
  RoomReservation : integer;
begin
    result := false;
    Rset := CreateNewDataSet;
    try
      s := format(select_isResCurrentlyCheckedIn , [reservation]);
      if hData.rSet_bySQL(rSet,s) then
      begin
        while not Rset.Eof do
        begin
          RoomReservation := rSet.FieldByName('RoomReservation').AsInteger;
          if isRrCurrentlyCheckedIn(RoomReservation) then  //
          begin
            result := true;
            break;
          end;
          rSet.Next;
        end;
      end;
    finally
      freeandnil(Rset);
    end;
  end;



  // **************************************************************
  // Paytypes Table
  // **************************************************************




  procedure Td.PayTypes_InitDoExport;
  var
    s : string;
  begin
    s := '';

    s := s+ ' UPDATE paytypes '+chr(10);
    s := s+ '    SET '+chr(10);
    s := s+ '       [doExport] = 1 '+chr(10);
    s := s+ '  WHERE doExport IS NULL '+chr(10);
    if not cmd_bySQL(s) then
    begin
    end;
end;


  procedure Td.Reservations_InitUseStayTax;
  var
    s : string;
  begin
    s := '';
    s := s+ ' UPDATE reservations '+chr(10);
    s := s+ '    SET '+chr(10);
    s := s+ '       [UseStayTax] = 1 '+chr(10);
    s := s+ '  WHERE useStayTax IS NULL '+chr(10);
    if not cmd_bySQL(s) then
    begin
    end;

    s := '';
    s := s+ ' UPDATE roomreservations '+chr(10);
    s := s+ '    SET '+chr(10);
    s := s+ '       [UseStayTax] = 1 '+chr(10);
    s := s+ '  WHERE useStayTax IS NULL '+chr(10);
    if not cmd_bySQL(s) then
    begin
      end;
    end;


  function Td.PayTypes_isExport(sPaytype : string) : boolean;
  var
    s    : string;
    rSet : TRoomerDataSet;
  begin
    result := true;

    rSet := CreateNewDataSet;
    try
//      s := s + ' SELECT doExport FROM paytypes '+chr(10);
//      s := s + ' WHERE (PayType = ' + _db(sPaytype) + ') '+chr(10);
       s := format(select_PayTypes_isExport , [_db(sPaytype)]);
       if  hData.rSet_bySQL(rSet,s) then
       begin
          result := rSet['doExport'];
       end;
    finally
      freeandnil(rSet);
    end;
  end;


  function Td.invoice_isExport(invoiceNo : integer) : boolean;
  var
    s    : string;
    rSet : TRoomerDataSet;
  begin
    result := true;

    rSet := CreateNewDataSet;
    try
//      s := s+ ' SELECT '+chr(10);
//      s := s+ '     Payments.InvoiceNumber '+chr(10);
//      s := s+ '   , Payments.PayType '+chr(10);
//      s := s+ '   , Paytypes.doExport '+chr(10);
//      s := s+ ' FROM '+chr(10);
//      s := s+ '    Payments '+chr(10);
//      s := s+ '       INNER JOIN Paytypes ON Payments.PayType = Paytypes.PayType '+chr(10);
//      s := s+ ' WHERE '+chr(10);
//      s := s+ '    (Paytypes.doExport = 0) AND (Payments.InvoiceNumber = '+_db(invoiceNo)+') '+chr(10);

      s := format(select_invoice_isExport , [invoiceNo]);
      if hData.rSet_bySQL(rSet,s) then
      begin
        result := false
      end;
    finally
      freeandnil(rSet);
    end;
  end;


  // **************************************************************
  // ItemTypes Table
  //
  // **************************************************************


function Td.GET_ItemTypeDescription_byItemType(sItemType : string) : string;
begin
  result := '';
  if glb.LocateItemType(sItemType) then
    result := glb.ItemTypes['Description'];
end;

function Td.ItemTypeExists(sItemType : string) : boolean;
begin
  result := glb.LocateItemType(sItemType);
end;

function Td.ItemTypeExistsInOther(sItemType : string) : boolean;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_ItemTypeExistsInOther , [_db(sItemType)]);
    result := hData.rSet_bySQL(rSet,s);
  finally
    freeandNil(rSet);
  end;
//    s := '';
//    s := s + ' SELECT ItemType FROM [Items] '+chr(10);
//    s := s + ' WHERE (ItemType = ' + _db(sItemType) + ') '+chr(10);
end;

  function Td.Del_ItemTypeByItemType(sItemType : string) : boolean;
  var
    s : string;
  begin
    result := true;

    if ItemTypeExistsInOther(sItemType) then
    begin
	    Showmessage(format(GetTranslatedText('shTx_D_TableUsingCannotDelete'), [sItemType]));
      result := false;
      exit
    end;
    s := '';
    s := s + 'DELETE '+chr(10);
    s := s + 'FROM itemtypes '+chr(10);
    s := s + 'WHERE  '+chr(10);
    s := s + '(ItemType =' + _db(sItemType) + ') '+chr(10);
    if not cmd_bySQL(s) then
    begin
      result := false;
    end;
  end;



  // **************************************************************
  // Items Table
  //
  // **************************************************************

  function Td.qryGetItems(Orderstr : string) : string;
  begin
//    s := s + 'SELECT '+chr(10);
//    s := s + '* '+chr(10);
//    s := s + 'FROM '+chr(10);
//    s := s + 'Items '+chr(10);
//    s := s + 'ORDER BY ' + Orderstr + ' '+chr(10);
    result := format(select_qryGetItems , [Orderstr]);;
  end;

  function Td.OpenItemsQuery(var SortField, SortDir : string) : boolean;
  begin
    zItemsFilter := '';
    result := hData.rSet_bySQL(Items_,qryGetItems(SortField + ' ' + SortDir));
  end;

function Td.Item_Get_AccountKey(sItem : string) : string;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  result := '';
  rSet := CreateNewDataSet;
  try
    s := format(select_Item_Get_AccountKey , [_db(sItem)]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      result := trim(rSet.fieldbyname('AccountKey').asString);
    end;
  finally
    freeandNil(rSet);
  end;
//    s := '';
//    s := s + 'SELECT AccountKey '+chr(10);
//    s := s + 'FROM Items  '+chr(10);
//    s := s + 'WHERE  '+chr(10);
//    s := s + '(Item =' + _db(sItem) + ') '+chr(10);
end;


function Td.Item_ExistsInOther(sItem : string) : boolean;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  result := false;
  rSet := CreateNewDataSet;
  try
    s := format(select_Item_ExistsInOther , [_db(sItem)]);
    if hData.rSet_bySQL(rSet,s) then exit;
//    s := s + ' SELECT BreakFastItem FROM [Control] '+chr(10);
//    s := s + ' WHERE (BreakFastItem = ' + _db(sItem) + ') '+chr(10);

    s := format(select_Item_ExistsInOther2 , [_db(sItem)]);
    if hData.rSet_bySQL(rSet,s) then exit;
//    s := s + ' SELECT RoomRentItem FROM [Control] '+chr(10);
//    s := s + ' WHERE (RoomRentItem = ' + _db(sItem) + ') '+chr(10);

    s := format(select_Item_ExistsInOther3 , [_db(sItem)]);
    if hData.rSet_bySQL(rSet,s) then exit;
//    s := s + ' SELECT PaymentItem FROM [Control] '+chr(10);
//    s := s + ' WHERE (PaymentItem = ' + _db(sItem) + ') '+chr(10);

    s := format(select_Item_ExistsInOther4 , [_db(sItem)]);
    if hData.rSet_bySQL(rSet,s) then exit;
//    s := s + ' SELECT PhoneUseItem FROM [Control] '+chr(10);
//    s := s + ' WHERE (PhoneUseItem = ' + _db(sItem) + ') '+chr(10);

    s := format(select_Item_ExistsInOther5 , [_db(sItem)]);
    if hData.rSet_bySQL(rSet,s) then exit;
//    s := s + ' SELECT DiscountItem FROM [Control] '+chr(10);
//    s := s + ' WHERE (DiscountItem = ' + _db(sItem) + ') '+chr(10);

    s := format(select_Item_ExistsInOther6 , [_db(sItem)]);
    if hData.rSet_bySQL(rSet,s) then exit;
//    s := s + ' SELECT ItemId FROM [Invoicelines] '+chr(10);
//    s := s + ' WHERE (ItemID = ' + _db(sItem) + ') '+chr(10);

  finally
    freeandNil(rSet);
  end;
  result := true;
end;

  function Td.Item_Del(sItem : string) : boolean;
  var
    s : string;
  begin
    result := true;

    if Item_ExistsInOther(sItem) then
    begin
	    Showmessage(format(GetTranslatedText('shTx_D_TableUsingCannotDelete'), [sItem]));
      result := false;
      exit
    end;

    s := '';
    s := s + 'DELETE '+chr(10);
    s := s + 'FROM items '+chr(10);
    s := s + 'WHERE  '+chr(10);
    s := s + '(Item =' + _db(sItem) + ') '+chr(10);
    if not cmd_bySQL(s) then
    begin
    end;
  end;



    function Td.Item_Get_Data(aItem : string) : recItemPlusHolder;
    var
      rSet : TRoomerDataSet;
      s : string;
    begin
      initItemPlusHolder(result);
//      s := s+ ' SELECT '+chr(10);
//      s := s+ '    Items.Item '+chr(10);
//      s := s+ '   , Items.Description AS ItemDescription '+chr(10);
//      s := s+ '   , Items.Price '+chr(10);
//      s := s+ '   , Items.Itemtype '+chr(10);
//      s := s+ '   , Itemtypes.Description AS ItemTypeDescription '+chr(10);
//      s := s+ '   , Itemtypes.VATCode '+chr(10);
//      s := s+ '   , VATCodes.Description AS VATcodeDescription '+chr(10);
//      s := s+ '   , VATCodes.VATPercentage '+chr(10);
//      s := s+ '   , Items.AccountKey '+chr(10);
//      s := s+ '   , Itemtypes.AccItemLink '+chr(10);
//      s := s+ ' FROM '+chr(10);
//      s := s+ '   Items '+chr(10);
//      s := s+ '      INNER JOIN Itemtypes ON Items.Itemtype = Itemtypes.Itemtype '+chr(10);
//      s := s+ '      INNER JOIN VATCodes ON Itemtypes.VATCode = VATCodes.VATCode '+chr(10);
//      s := s+ '  WHERE '+chr(10);
//      s := s+ '  Items.item = '+_db(aItem)+' '+chr(10);
      rSet := CreateNewDataSet;
      try
        s := format(select_Item_Get_Data , [_db(aItem)]);
        if hData.rSet_bySQL(rSet,s) then
        begin
          rSet.First;

          if not rSet.eof then
          begin
            result.AccountKey          := rSet.FieldByName('AccountKey').asString;
            result.AccItemLink         := rSet.FieldByName('AccItemLink').asString;
            result.Item                := rSet.FieldByName('Item').asString;
            result.Description         := rSet.FieldByName('ItemDescription').asString;
            result.Price               := LocalFloatValue(rSet.FieldByName('Price').asString);
            result.Itemtype            := rSet.FieldByName('Itemtype').asString;
            result.ItemTypeDescription := rSet.FieldByName('ItemTypeDescription').asString;
            result.VATCode             := rSet.FieldByName('VATCode').asString;
            result.VATCodeDescription  := rSet.FieldByName('VATCodeDescription').asString;
            result.VATPercentage       := LocalFloatValue(rSet.FieldByName('VATPercentage').asString);
            result.ItemKind            := Item_GetKind(aItem)
          end;
        end;
      finally
        freeandNil(rSet);
      end;
    end;

  // **************************************************************
  // RoomTypeRules Table
  //
  // **************************************************************







  // **************************************************************
  // StaffTypes Table
  //
  // **************************************************************


  procedure Td.StaffTypes_NewRecord(DataSet : TDataSet);
  begin
  end;

  // **************************************************************
  // StaffMembers Table
  //
  // **************************************************************

function Td.GET_StaffMemberName_byInitials(sInitials : string) : string;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  result := '';
  rSet := CreateNewDataSet;
  try
    s := format(select_GET_StaffMemberName_byInitials , [_db(sInitials) ]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      result := trim(rSet.fieldbyname('Name').asString);
    end;
  finally
    freeandNil(rSet);
  end;
end;

function Td.GET_StaffMemberPID_byInitials(sInitials : string) : string;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  result := '';
  rSet := CreateNewDataSet;
  try
    s := format(select_GET_StaffMemberPID_byInitials , [_db(sInitials)]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      result := trim(rSet.fieldbyname('staffPID').asString);
    end;
  finally
    freeandNil(rSet);
  end;
end;


  function Td.Del_RoomPricesByID_1(Id : integer) : boolean;
  var
    s : string;
  begin
    result := true;

    s := '';
    s := s + 'DELETE '+chr(10);
    s := s + 'FROM pricetypes '+chr(10);
    s := s + 'WHERE  '+chr(10);
    s := s + '(Id =' + inttostr(Id) + ') '+chr(10);
    if not cmd_bySQL(s) then
    begin
      result := false;
    end;
  end;

function Td.Get_LastRoomPriceID_1 : integer;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    s := format(select_Get_LastRoomPriceID_1 , []);
    if hData.rSet_bySQL(rSet,s) then
    begin
      result := rSet.fieldbyname('ID').asInteger;
    end;
  finally
    freeandNil(rSet);
  end;
//    s := '';
//    s := s + 'SELECT '+chr(10);
//    s := s + 'ID '+chr(10);
//    s := s + 'FROM '+chr(10);
//    s := s + 'priceTypes '+chr(10);
//    s := s + 'ORDER BY ID DESC '+chr(10);
end;

  function Td.getPrice_1(rtID : integer; persons : integer; var code, RoomType, Currency : string) : double;
  var
    s : string;

    ExtraPrice : double;
    p1, p2, p3, p4, p5 : double;

    Price : double;

    extraPersons : double;
    Rset : TRoomerDataSet;
    priceCodeID : integer;

  begin

    Rset := CreateNewDataSet;
    try
      code := '';
      RoomType := '';
      Currency := '';

      extraPersons := persons - 5;

      if persons < 0 then
        persons := 0;

      result := 0;

      if persons < 1 then
      begin
        exit;
      end;

//      s := '';
//      s := s + ' SELECT '+chr(10);
//      s := s + '  ID '+chr(10);
//      s := s + ', Price1Person '+chr(10);
//      s := s + ', Price2Persons '+chr(10);
//      s := s + ', Price3Persons '+chr(10);
//      s := s + ', Price4Persons '+chr(10);
//      s := s + ', Price5Persons '+chr(10);
//      s := s + ', PriceExtraPerson '+chr(10);
//      s := s + ', PcID '+chr(10);
//      s := s + ', RoomType '+chr(10);
//      s := s + ', Currency '+chr(10);
//      s := s + ' FROM '+chr(10);
//      s := s + ' PriceTypes '+chr(10);
//      s := s + ' WHERE '+chr(10);
//      s := s + ' Id = ' + inttostr(rtID)+chr(10);
      s := format(select_getPrice_1 , [rtID]);
      if hData.rSet_bySQL(rSet,s) then
      begin
        ExtraPrice := rSet.GetFloatValue(Rset.fieldbyname('PriceExtraPerson'));
        p1 := LocalFloatValue(Rset.fieldbyname('Price1Person').asString);
        p2 := LocalFloatValue(Rset.fieldbyname('Price2Persons').asString);
        p3 := LocalFloatValue(Rset.fieldbyname('Price3Persons').asString);
        p4 := LocalFloatValue(Rset.fieldbyname('Price4Persons').asString);
        p5 := LocalFloatValue(Rset.fieldbyname('Price5Persons').asString);

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

        if persons = 1 then
          result := p1;
        if persons = 2 then
          result := p2;
        if persons = 3 then
          result := p3;
        if persons = 4 then
          result := p4;
        if persons = 5 then
          result := p5;

        if persons > 5 then
          result := p5 + (extraPersons * ExtraPrice);

        priceCodeID := Rset.fieldbyname('PcId').asInteger;
        code := PriceCode_Code(priceCodeID);
        RoomType := Rset.fieldbyname('RoomType').asString;
        Currency := Rset.fieldbyname('Currency').asString;
      end;
    finally
      freeandnil(Rset);
    end;
  end;

  function Td.getPrice_2(rtID : integer; persons : integer) : double;
  var
    s : string;

    ExtraPrice : double;
    p1, p2, p3, p4, p5 : double;

    Price : double;

    extraPersons : double;

    Rset : TRoomerDataSet;

  begin

    Rset := CreateNewDataSet;
    try
      extraPersons := persons - 5;

      if persons < 0 then
        persons := 0;

      result := 0;

      if persons < 1 then
      begin
        exit;
      end;

//      s := '';
//      s := s + ' SELECT '+chr(10);
//      s := s + '  ID '+chr(10);
//      s := s + ', Price1Person '+chr(10);
//      s := s + ', Price2Persons '+chr(10);
//      s := s + ', Price3Persons '+chr(10);
//      s := s + ', Price4Persons '+chr(10);
//      s := s + ', Price5Persons '+chr(10);
//      s := s + ', PriceExtraPerson '+chr(10);
//      s := s + ' FROM '+chr(10);
//      s := s + ' PriceTypes '+chr(10);
//      s := s + ' WHERE '+chr(10);
//      s := s + ' Id = ' + inttostr(rtID)+chr(10);

      s := format(select_getPrice_2 , [rtID]);
      if hData.rSet_bySQL(rSet,s) then
      begin
          ExtraPrice := LocalFloatValue(Rset.fieldbyname('PriceExtraPerson').asString);
          p1 := LocalFloatValue(Rset.fieldbyname('Price1Person').asString);
          p2 := LocalFloatValue(Rset.fieldbyname('Price2Persons').asString);
          p3 := LocalFloatValue(Rset.fieldbyname('Price3Persons').asString);
          p4 := LocalFloatValue(Rset.fieldbyname('Price4Persons').asString);
          p5 := LocalFloatValue(Rset.fieldbyname('Price5Persons').asString);

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

          if persons = 1 then
            result := p1;
          if persons = 2 then
            result := p2;
          if persons = 3 then
            result := p3;
          if persons = 4 then
            result := p4;
          if persons = 5 then
            result := p5;

          if persons > 5 then
            result := p5 + (extraPersons * ExtraPrice);
        end;
    finally
      freeandnil(Rset);
    end;
  end;


function Td.getRackPriceID_1(seasonId : integer; RoomType, Currency : string) : integer;
var
  s : string;
  RackPriceID : integer;
  priceCodeID : integer;
  rSet : TRoomerDataSet;
begin
  result := - 1;
  RackPriceID := priceCode_RackID;
  rSet := CreateNewDataSet;
  try
    s := format(select_getRackPriceID_1 , [seasonId,_db(RoomType),_db(Currency)]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      rSet.First;
      while not rSet.Eof do
      begin
        priceCodeID := rSet.fieldbyname('pcID').asInteger;
        if priceCodeID = RackPriceID then
        begin
          result := rSet.fieldbyname('ID').asInteger;
        end;
        rSet.Next;
      end;
    end;
  finally
    freeandNil(rSet);
  end;
//    s := '';
//    s := s + 'SELECT '+chr(10);
//    s := s + 'pcID, '+chr(10);
//    s := s + 'seID, '+chr(10);
//    s := s + 'ID, '+chr(10);
//    s := s + 'RoomType, '+chr(10);
//    s := s + 'Currency, '+chr(10);
//    s := s + 'Description '+chr(10);
//    s := s + 'FROM '+chr(10);
//    s := s + 'priceTypes '+chr(10);
//    s := s + 'WHERE ' + chr(10)+chr(10);
//    s := s + '(seID = ' + inttostr(seasonId) + ') AND '+chr(10);
//    s := s + '(RoomType = ' + _db(RoomType) + ') AND '+chr(10);
//    s := s + '(Currency = ' + _db(Currency) + ') '+chr(10);
end;

  //121230 MOVE to Hdata

  procedure Td.viewRoomPrices1_NewRecord(DataSet : TDataSet);
  begin
    DataSet.fieldbyname('Price1Person').asfloat := 0;
    DataSet.fieldbyname('Price2Persons').asfloat := 0;
    DataSet.fieldbyname('Price3Persons').asfloat := 0;
    DataSet.fieldbyname('Price4Persons').asfloat := 0;
    DataSet.fieldbyname('Price5Persons').asfloat := 0;
    DataSet.fieldbyname('Price6Persons').asfloat := 0;
    DataSet.fieldbyname('PriceExtraPerson').asfloat := 0;
  end;

  procedure Td.viewRoomPrices_NewRecord(DataSet : TDataSet);
  begin
  end;

  // **************************************************************
  // Seasons Table
  // **************************************************************


function Td.SeasonExists_byID(seasonId : integer) : boolean;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_SeasonExists_byID , [seasonId]);
    result := hData.rSet_bySQL(rSet,s);
  finally
    freeandNil(rSet);
  end;
//    s := s + 'SELECT ID '+chr(10);
//    s := s + 'FROM tblSeasons  '+chr(10);
//    s := s + 'WHERE  '+chr(10);
//    s := s + '(Id =' + inttostr(seasonId) + ') '+chr(10);
end;

function Td.GET_SeasonsDescription_bySeasonID(seasonId : integer) : string;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  result := '';
  rSet := CreateNewDataSet;
  try
    s := format(select_GET_SeasonsDescription_bySeasonID , [seasonId]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      result := trim(rSet.fieldbyname('seDescription').asString);
    end;
  finally
    freeandNil(rSet);
  end;
//    s := '';
//    s := s + 'SELECT seDescription '+chr(10);
//    s := s + 'FROM tblSeasons  '+chr(10);
//    s := s + 'WHERE  '+chr(10);
//    s := s + '(Id =' + inttostr(seasonId) + ') '+chr(10);
end;

function Td.GET_SeasonsId_byDescription(seDescription : string) : integer;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  result := - 1;
  rSet := CreateNewDataSet;
  try
    s := format(select_GET_SeasonsId_byDescription , [_db(seDescription)]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      result := rSet.fieldbyname('ID').asInteger;
    end;
  finally
    freeandNil(rSet);
  end;
//    s := '';
//    s := s + 'SELECT ID '+chr(10);
//    s := s + 'FROM tblSeasons  '+chr(10);
//    s := s + 'WHERE  '+chr(10);
//    s := s + '(seDescription =' + _db(seDescription) + ') '+chr(10);

end;

function Td.GET_SeasonsDates_bySeasonID(seasonId : integer; var seStartdate, seEndDate : TdateTime) : boolean;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  result := false;
  seStartdate := 1;
  seEndDate := 1;

  rSet := CreateNewDataSet;
  try
    s := format(select_GET_SeasonsDates_bySeasonID , [seasonId]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      result := true;
      seStartdate := rSet.fieldbyname('seStartDate').asDateTime;
      seEndDate := rSet.fieldbyname('seEndDate').asDateTime;
    end;
  finally
    freeandNil(rSet);
  end;
//    s := s + 'SELECT '+chr(10);
//    s := s + 'seStartDate, '+chr(10);
//    s := s + 'seEndDate '+chr(10);
//    s := s + 'FROM tblSeasons  '+chr(10);
//    s := s + 'WHERE  '+chr(10);
//    s := s + '(Id =' + inttostr(seasonId) + ') '+chr(10);
end;

  function Td.Del_SeasonByID(Id : integer) : boolean;
  var
    s : string;
  begin
    result := true;

    s := '';
    s := s + 'DELETE '+chr(10);
    s := s + 'FROM tblseasons '+chr(10);
    s := s + 'WHERE  '+chr(10);
    s := s + '(Id =' + inttostr(Id) + ') '+chr(10);
    if not cmd_bySQL(s) then
    begin
      result := false;
    end;
  end;

function Td.SeasonExist(aDateFrom, aDateTo : TdateTime) : boolean;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_SeasonExist , [ _DateToDBDate(aDateFrom,true),_DateToDBDate(aDateTo,true)]);
    result := hData.rSet_bySQL(rSet,s);
  finally
    freeandNil(rSet);
  end;
//    s := s + 'SELECT '+chr(10);
//    s := s + 'seStartDate, seEndDate '+chr(10);
//    s := s + 'FROM '+chr(10);
//    s := s + 'tblSeasons '+chr(10);
//    s := s + 'WHERE '+chr(10);
//    s := s + '(seStartDate = ' + _DateToDBDate(aDateFrom,true) + ') AND  (seEndDate = ' + _DateToDBDate(aDateTo,true) + ') '+chr(10);
end;

function Td.SeasonCount(adate : TdateTime) : integer;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    s := format(select_SeasonCount , [ _DateToDBDate(adate,true), _DateToDBDate(adate,true)]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      result := rSet.recordCount;
    end;
  finally
    freeandNil(rSet);
  end;
//    s := s + 'SELECT '+chr(10);
//    s := s + 'seStartDate, seEndDate '+chr(10);
//    s := s + 'FROM '+chr(10);
//    s := s + 'tblSeasons '+chr(10);
//    s := s + 'WHERE '+chr(10);
//    s := s + '(seStartDate <= ' + _DateToDBDate(adate,true) + ') AND  (seEndDate >= ' + _DateToDBDate(adate,true) + ') '+chr(10);
end;

function Td.FindSeasonID(adate : TdateTime) : integer;
var
    s : string;
    NightCount : integer;
    MaxNights : integer;
    dateFirst : TdateTime;
    dateLast : TdateTime;
   rSet : TRoomerDataSet;
begin
  result := - 1;
  rSet := CreateNewDataSet;
  try
    s := format(select_FindSeasonID , [_DateToDBDate(adate,true),_DateToDBDate(adate,true)]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      MaxNights := 0;
      while not rSet.Eof do
      begin
        dateFirst := rSet.fieldbyname('seStartDate').asDateTime;
        dateLast := rSet.fieldbyname('seEndDate').asDateTime;
        NightCount := _NightsBetween(dateFirst, dateLast);
        if NightCount >= MaxNights then
        begin
          MaxNights := NightCount;
          result := rSet.fieldbyname('Id').asInteger;
        end;
        rSet.Next;
      end;
    end;
  finally
    freeandNil(rSet);
  end;
//    s := s + 'SELECT '+chr(10);
//    s := s + '  seStartDate '+chr(10);
//    s := s + ' ,seEndDate '+chr(10);
//    s := s + ' ,ID '+chr(10);
//    s := s + 'FROM '+chr(10);
//    s := s + 'tblSeasons '+chr(10);
//    s := s + 'WHERE '+chr(10);
//    s := s + '(seStartDate <= ' + _DateToDBDate(adate,true) + ') AND  (seEndDate >= ' + _DateToDBDate(adate,true) + ') '+chr(10);
end;



  // **************************************************************
  // PriceCodes Table
  // **************************************************************


  procedure Td.telPriceGroups_NewRecord(DataSet: TDataSet);
  begin
    dataset.FieldByName('doUse').AsBoolean := true;
    dataset.FieldByName('price').AsFloat := 0.00;
  end;

  procedure Td.telPriceRules_NewRecord(DataSet: TDataSet);
  begin
    dataset.FieldByName('doUse').AsBoolean := true;
  end;



  // **************************************************************
  // GetInvoiceLinesTmp Table
  // **************************************************************


  function Td.del_InvoiceLinesTmp(iRoomReservation : integer) : boolean;
  var
    s : string;
  begin
    result := true;
    s := '';
    s := s + 'DELETE '+chr(10);
    s := s + 'FROM invoicelinestmp '+chr(10);
    s := s + 'WHERE '+chr(10);
    s := s + 'RoomReservation=' + inttostr(iRoomReservation) + ' '+chr(10);
    if not cmd_bySQL(s) then
    begin
      result := false;
    end;

  end;


function Td.InvoiceLinesTmp_exists(iRoomReservation : integer) : boolean;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_InvoiceLinesTmp_exists , [iRoomReservation]);
    result := hData.rSet_bySQL(rSet,s);
  finally
    freeandNil(rSet);
  end;
end;

  /// *****************************************************************************
  /// *****************************************************************************
  /// *****************************************************************************
  /// *****************************************************************************
  /// *****************************************************************************

  procedure Td.StaffMembers_NewRecord(DataSet : TDataSet);
  begin
    DataSet.fieldbyname('ActiveMember').AsBoolean := true;
    DataSet.fieldbyname('StaffLanguage').asInteger := 1;
  end;

  procedure Td.Items_NewRecord(DataSet : TDataSet);
  begin
    DataSet.fieldbyname('Price').asfloat := 0;
  end;

  procedure Td.Paytypes_NewRecord(DataSet : TDataSet);
  begin

    try
      DataSet.fieldbyname('AskCode').AsBoolean := false;
    except
    end;

    try
      DataSet.fieldbyname('doExport').AsBoolean := true;
    except
    end;
  end;

  procedure Td.VATCodes_NewRecord(DataSet : TDataSet);
  begin
    DataSet.fieldbyname('VATPercentage').asfloat := 0;
  end;

  procedure Td.Customers_BeforePost(DataSet : TDataSet);
  begin
  end;

  /// /*********************

function Td.doLogin(login, password : string) : boolean;
var
  s : string;
  newStafflang : integer;
  rSet : TRoomerDataSet;
  sPath : String;
begin
  result := false;
  if NOT d.roomerMainDataSet.OfflineMode then
  begin
    rSet := CreateNewDataSet;
    try
      s := format(select_doLogin , [_db(login)]);
      if hData.rSet_bySQL(rSet,s) then
      begin
        rSet.First;
        if not rSet.Eof then
        begin
          if (_trimlower(rSet.fieldbyname('Initials').asString) = _trimlower(login)) and
            (trim(rSet.fieldbyname('Password').asString) = password) then
          begin
            g.qUser := trim(rSet.fieldbyname('Initials').asString);
            g.qUserName := trim(rSet.fieldbyname('Name').asString);
            g.qUserPID := trim(rSet.fieldbyname('StaffPID').asString);
            g.qUserType := trim(rSet.fieldbyname('StaffType').asString);
            g.qHotelName := trim(rSet.fieldbyname('CompanyName').asString);
            g.qUserPriv1 := rSet.fieldbyname('Priv1').asInteger;
            g.qUserPriv2 := rSet.fieldbyname('Priv2').asInteger;
            g.qUserPriv3 := rSet.fieldbyname('Priv3').asInteger;
            g.qUserPriv4 := rSet.fieldbyname('Priv4').asInteger;
            g.qUserPriv5 := rSet.fieldbyname('Priv5').asInteger;
            g.qUserAuthValue1 := rSet['AuthValue1'];
            g.qUserAuthValue2 := rSet['AuthValue2'];
            g.qUserAuthValue3 := rSet['AuthValue3'];
            g.qUserAuthValue4 := rSet['AuthValue4'];
            g.qUserAuthValue5 := rSet['AuthValue5'];
            g.qLocationPerRoomType := rSet['LocationPerRoomType'];
            g.qNumberOfShifts := rSet['NumberOfShifts'];

            g.qWarnCheckInDirtyRoom := rSet['WarnCheckInDirtyRoom'];
            g.qWarnWhenOverbooking := rSet['WarnWhenOverbooking'];
            g.qWarnMoveRoomToNewRoomtype := rSet['WarnMoveRoomToNewRoomtype'];

            g.qDefaultSendCCEmailToHotel := rSet['DefaultSendCCEmailToHotel'];
            g.qRatesManagedByRoomer := rSet['RatesManagedByRoomer'];
            g.qRestrictWithdrawalWithoutGuarantee := rSet['RestrictWithdrawalToGuarantee'];
            g.qExpandRoomRentOnInvoice := rSet['ExpandedRoomStayOnInvoice'];

            g.qRoomInvoiceRoomRentIndex := rSet['RoomInvoiceRoomRentIndex'];
            g.qRoomInvoicePosItemIndex := rSet['RoomInvoicePosItemIndex'];
            g.qGroupInvoiceRoomRentIndex := rSet['GroupInvoiceRoomRentIndex'];
            g.qGroupInvoicePosItemIndex := rSet['GroupInvoicePosItemIndex'];

            g.qDynamicRatesActive := rSet['DynamicRatesActive'];


            newStaffLang := rSet.fieldbyname('StaffLanguage').asInteger;

            g.ChangeLang(newStaffLang,false);
            // g.qUserLanguage := rSet.fieldbyname('StaffLanguage').asInteger;
            result := true;
          end;
        end;
      end;
    finally
      freeandNil(rSet);
    end;
  end else
  begin // Offline login
//    sPath := TPath.Combine(uStringUtils.LocalAppDataPath, 'Roomer');
//    sPath := TPath.Combine(sPath, format('%s\datacache',[d.roomerMainDataSet.hotelId]));
//    forceDirectories(sPath);
    sPath := glb.GetDataCacheLocation;
    rSet := d.roomerMainDataSet.ActivateNewDataset(ReadFromTextFile(TPath.Combine(sPath, format(RoomerTableFileName, ['staffmembers']))));
    try
      if LocateRecord(rSet, 'initials', login) then
         result := LowerCase(rSet['Password']) = LowerCase(password);
      if result then
      begin
        g.qUser := trim(rSet['Initials']);
        g.qUserName := trim(rSet['Name']);
        g.qUserPID := trim(rSet['StaffPID']);
        g.qUserType := trim(rSet['StaffType']);
        g.qHotelName := d.roomerMainDataSet.hotelId;
        g.qUserPriv1 := 90;
        g.qUserPriv2 := g.qUserPriv1;
        g.qUserPriv3 := g.qUserPriv1;
        g.qUserPriv4 := g.qUserPriv1;
        g.qUserPriv5 := g.qUserPriv1;
        g.qUserAuthValue1 := 1111111;
        g.qUserAuthValue2 := g.qUserAuthValue1;
        g.qUserAuthValue3 := g.qUserAuthValue1;
        g.qUserAuthValue4 := g.qUserAuthValue1;
        g.qUserAuthValue5 := g.qUserAuthValue1;
        g.qNumberOfShifts := 3;
        g.qRatesManagedByRoomer := False;

        newStaffLang := rSet['StaffLanguage'];

        g.ChangeLang(newStaffLang,false);
      end;
    finally
      rSet.Free;
    end;
  end;
end;



  procedure Td.inPosMonitorTimer(Sender: TObject);
  var
    invoiceNumber : integer;
    iTmp : integer;
  begin
//    inPosMonitor.Enabled := false;
//    showmessage('Hæ');
//    inPosMonitor.Enabled := True;
    exit;


    if imPortLog_isNewAvailable then
    begin
      inPosMonitor.Enabled := false;

      if frmDayNotes.V then
      begin
        if frmDayNotes.pageMain.ActivePage = frmDayNotes.tabLog then
          if frmDayNotes.pageLog.ActivePage = frmDayNotes.tabImportLog then
        begin
          frmDayNotes.RefreshImPortLog;
        end;
      end;
      inPosMonitor.Enabled := True;
    end else
    begin
      invoicenumber := imPortLog_InvoiceNumber;

      if invoiceNumber  > 0 then
      begin
        inPosMonitor.Enabled := false;

        iTmp := g.qHomeExportPOSType;
        try
          g.qHomeExportPOSType := peExportFolder;
          CreateMtFields;
          d.InsertMTdata(InvoiceNumber,true,true,false);
        finally
          g.qHomeExportPOSType := iTmp;
        end;
        inPosMonitor.Enabled := True;
      end else
      begin
        case invoiceNumber of
          -1001 : begin
                     GetCurrentGuestsXML;
                  end;
        end;
      end;
    end;

  end;




function Td.GetRoomReservatiaonArrival(RoomReservation : integer) : Tdate;
var
  Rset : TRoomerDataSet;
  s : string;
begin
  result := 1;

  Rset := CreateNewDataSet;
  try
//    s := '';
//    s := s + ' SELECT rrArrival '+chr(10);
//    s := s + ' FROM RoomReservations  '+chr(10);
//    s := s + ' WHERE Roomreservation =' + inttostr(RoomReservation) + ' '+chr(10);
    s := format(select_GetRoomReservatiaonArrival , [RoomReservation]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      result := Rset.fieldbyname('rrArrival').asDateTime;
      result := trunc(result);
    end;
  finally
    freeandnil(Rset);
  end;
end;


function Td.NextRoomReservatiaon(Room : string; RoomReservation : integer; noResDate : Tdate) : integer;
  var
    Rset : TRoomerDataSet;
    s : string;
    ArrivalDate : Tdate;
    sDate : string;
    sql : string;
  begin
    if RoomReservation > 1 then
    begin
      ArrivalDate := GetRoomReservatiaonArrival(RoomReservation);
      sDate := _DateToDBDate(ArrivalDate,false);
    end
    else
    begin
      sDate := _DateToDBDate(noResDate,false)
    end;
    result := 0;

    Rset := CreateNewDataSet;
    try
      sql :=
      ' SELECT DISTINCT ' +
      '     Room '+
      '   , Adate '+
      '   , RoomReservation '+
      '   , Reservation '+
      ' FROM '+
      '   roomsdate '+
      ' WHERE '+
      '       (ADate >  %s )'+
      '   AND (Room =  %s )'+
      '   AND (RoomReservation <>  %d ) '+
      '   AND (NOT ResFlag IN (''X'',''C'')) '+
      ' ORDER BY Adate ' +
      ' LIMIT 1 ';

      s := format(sql , [_db(sDate), _db(Room),RoomReservation]);
      if hData.rSet_bySQL(rSet,s) then
      begin
        result := Rset.fieldbyname('RoomReservation').asInteger;
      end;
    finally
      freeandnil(Rset);
    end;
  end;







function Td.LastRoomReservatiaon(Room : string; RoomReservation : integer; noResDate : Tdate) : integer;
var
  Rset : TRoomerDataSet;
  s : string;
  ArrivalDate : Tdate;
  sDate : string;
  sql : string;
begin
  if RoomReservation > 1 then
  begin
    ArrivalDate := GetRoomReservatiaonArrival(RoomReservation);
    sDate := _DateToDBDate(ArrivalDate,false);
  end
  else
  begin
    sDate := _DateToDBDate(noResDate,false)
  end;
  result := 0;

  Rset := CreateNewDataSet;
  try
    sql :=
    ' SELECT DISTINCT '#10 +
    '     Room '#10+
    '   , Adate '#10+
    '   , RoomReservation '#10+
    '   , Reservation '#10+
    ' FROM '#10+
    '   roomsdate '#10+
    ' WHERE '#10+
    '       (ADate <  %s )'#10+   //zxhj breytti hér var >
    '   AND (Room =  %s )'#10+
    '   AND (RoomReservation <>  %d ) '#10+
    '   AND (NOT ResFlag IN (''X'',''C'')) '#10+ //zxhj Added - checked ok
    ' ORDER BY Adate DESC '#10 +
    ' LIMIT 1 ';

    s := format(sql , [ _db(sDate),_db(Room),RoomReservation]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      result := Rset.fieldbyname('RoomReservation').asInteger;
    end;
  finally
    freeandnil(Rset);
  end;
end;

//function TD.GetFirstRoomReservation(iReservation : integer) : integer;
//var
//  Rset : TRoomerDataSet;
//  s : string;
//begin
//  result := 0;
//  Rset := CreateNewDataSet;
//  try
//    s := format(select_GetFirstRoomReservation , [iReservation]);
//    if hData.rSet_bySQL(rSet,s) then
//    begin
//      result := Rset.fieldbyname('RoomReservation').asInteger;
//    end;
//  finally
//    freeandnil(Rset);
//  end;
//end;


function Td.UpdateExpectedCheckoutTime(aReservation, aRoomReservation: integer; const aCheckoutTime: string): boolean;
var
  s : string;
  lTime: TDateTime;
begin
  Result := aCheckoutTime.IsEmpty or TryStrToTime(aCheckoutTime, lTime);
  if Result then
  begin
    s := '';
    s := s + 'UPDATE roomreservations '+chr(10);
    s := s + 'Set'+chr(10);
    s := s + '  ExpectedCheckoutTime = ' +  _db(TTime(lTime))+chr(10);
    s := s + 'WHERE Reservation = ' + _db(aReservation)+chr(10);
    s := s + '  AND RoomReservation = ' + inttostr(aRoomReservation)+chr(10);
    Result := cmd_bySQL(s);
  end;
end;

function Td.UpdateExpectedTimeOfArrival(aReservation, aRoomReservation: integer; const aTimeOfArrival: string): boolean;
var
  s : string;
  lTime: TDateTime;
begin
  Result := aTimeOfArrival.IsEmpty or TryStrToTime(aTimeOfArrival, lTime);
  if Result then
  begin
    s := '';
    s := s + 'UPDATE roomreservations '+chr(10);
    s := s + 'Set'+chr(10);
    s := s + '  ExpectedTimeOfArrival = ' + _db(TTime(lTime))+chr(10);
    s := s + 'WHERE Reservation = ' + _db(aReservation)+chr(10);
    s := s + '  AND RoomReservation = ' + inttostr(aRoomReservation)+chr(10);
    Result := cmd_bySQL(s);
  end;
end;

function Td.UpdateReservationMarket(aReservation: integer; aMarket: TReservationMarketType): boolean;
var
  b : TStringBuilder;
begin
  b := TStringBuilder.Create;
  try
    b.Append('UPDATE reservations '+chr(10));
    b.Append('Set'+chr(10));
    b.Append('  market = ' + _db(aMarket.ToDBString)+chr(10));
    b.Append('WHERE Reservation = ' + _db(aReservation)+chr(10));
    Result := cmd_bySQL(b.ToString);
  finally
    b.Free;
  end;
end;

procedure Td.UpdateBreakfastIncluted(reservation, RoomReservation : integer; BreakfastIncluted : boolean);
var
  s : string;
begin
  s := '';
  s := s + 'UPDATE roomreservations '+chr(10);
  s := s + 'Set'+chr(10);
  s := s + '  InvBreakfast = ' + _db(BreakfastIncluted)+chr(10);
  s := s + 'WHERE Reservation = ' + _db(reservation)+chr(10);
  if RoomReservation > 0 then
    s := s + '  AND RoomReservation = ' + inttostr(RoomReservation)+chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

function Td.isAllRRSameCurrency(reservation : integer) : boolean;
// Eru allar Herbergisbókanir í sama gjaldmiðli
var
  Rset : TRoomerDataSet;
  s : string;
  curr, tmp : string;
begin
  result := true;
  Rset := CreateNewDataSet;
  try
//      s := '';
//      s := s + 'SELECT Currency '+chr(10);
//      s := s + 'FROM RoomReservations '+chr(10);
//      s := s + 'WHERE Reservation = ' + inttostr(reservation)+chr(10);
    s := format(select_isAllRRSameCurrency , [reservation]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      curr := Rset.fieldbyname('currency').asString;
      while not Rset.Eof do
      begin
        tmp := Rset.fieldbyname('currency').asString;
        if tmp <> curr then
          result := false;
        Rset.Next;
      end;
    end;
  finally
    freeandnil(Rset);
  end;
end;

procedure Td.UpdateGroupAccountAll(reservation, RoomReservation, RoomReservationAlias : integer; GroupAccount : boolean);
var
  s : string;
  ExecutionPlan: TRoomerExecutionPlan;
  AllOk : boolean;
begin
  if not isAllRRSameCurrency(reservation) then
  begin
    Showmessage(GetTranslatedText('shTx_D_CurrencyCancel'));
    exit;
  end;
  Allok := true ;
  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  ExecutionPlan.BeginTransaction;
  try

    s := '';
    s := s + ' UPDATE roomreservations '+chr(10);
    s := s + ' Set'+chr(10);
    s := s + ' GroupAccount = ' + _DB(GroupAccount)+chr(10);  //ATH var boolTostr
    s := s + ' WHERE Reservation = ' + inttostr(reservation)+chr(10);
    ExecutionPlan.AddExec(s);

    if groupAccount then
    begin
      s := '';
      s := s + ' UPDATE invoicelines '+chr(10);
      s := s + ' Set'+chr(10);
      s := s + ' Roomreservation = 0 ';
      s := s + ' WHERE (Reservation = ' + inttostr(reservation)+') AND (isPackage=1) ';
//      copytoclipboard(s);
//      debugmessage(s);
      ExecutionPlan.AddExec(s);
    end else
    begin
      s := '';
      s := s + ' UPDATE invoicelines '+chr(10);
      s := s + ' Set'+chr(10);
      s := s + ' Roomreservation =RoomreservationAlias '+chr(10);
      s := s + ' WHERE (Reservation = ' + inttostr(reservation)+') AND (isPackage=1) ';
//      copytoclipboard(s);
//      debugmessage(s);
      ExecutionPlan.AddExec(s);
    end;

    if ExecutionPlan.Execute(ptExec, false, false) then
    begin
      ExecutionPlan.CommitTransaction;
    end
    else
    raise Exception.create(ExecutionPlan.ExecException);

    except
      on e: Exception do
      begin
        AllOk := false;
      end;
    end;

    freeandNil(ExecutionPlan);




  if AllOk then
  begin
    if groupAccount  then
    begin
      UpdPaymentsWhenChangingReservationToGroup(reservation,roomreservation)
    end else
    begin
      UpdPaymentsWhenChangingReservationToRoom(reservation,roomreservation)
    end;
  end;




end;

procedure Td.UpdateGroupAccountOne(reservation, RoomReservation, RoomReservationAlias : integer; GroupAccount : boolean; InvoiceIndex : Integer = -1);
var
  s : string;
  ExecutionPlan: TRoomerExecutionPlan;
  AllOk : boolean;
begin
  if not isAllRRSameCurrency(reservation) then
  begin
    Showmessage(GetTranslatedText('shTx_D_CurrencyCancel'));
    exit;
  end;
  Allok := true ;
  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  ExecutionPlan.BeginTransaction;
  try

    s := '';
    s := s + ' UPDATE roomreservations '+chr(10);
    s := s + ' Set'+chr(10);
    s := s + ' GroupAccount = ' + _db(GroupAccount)+chr(10);  //ATH var boolTostr
    if InvoiceIndex > -1 then
      s := s + ' , InvoiceIndex = ' + _db(InvoiceIndex)+chr(10);  //ATH var boolTostr
    s := s + ' WHERE Reservation = ' + inttostr(reservation)+chr(10);
    s := s + ' AND roomreservation = ' + inttostr(roomreservation)+chr(10);



    ExecutionPlan.AddExec(s);

    if groupAccount then
    begin
      s := '';
      s := s + ' UPDATE invoicelines '+chr(10);
      s := s + ' Set'+chr(10);
      s := s + ' Roomreservation = 0 ';
      s := s + ' WHERE (Reservation = ' + inttostr(reservation)+') AND (isPackage=1) ';
      s := s + ' AND roomReservationAlias = ' + inttostr(roomreservationAlias)+chr(10);
//    copytoclipboard(s);
//    debugmessage(s);
      ExecutionPlan.AddExec(s);
    end else
    begin
      s := '';
      s := s + ' UPDATE invoicelines '+chr(10);
      s := s + ' Set'+chr(10);
      s := s + ' Roomreservation =RoomreservationAlias '+chr(10);
      s := s + ' WHERE (Reservation = ' + inttostr(reservation)+') AND (isPackage=1) ';
      s := s + ' AND roomReservationAlias = ' + inttostr(roomreservationAlias)+chr(10);
//    copytoclipboard(s);
//    debugmessage(s);
      ExecutionPlan.AddExec(s);
    end;

    if ExecutionPlan.Execute(ptExec, false, false) then
    begin
      ExecutionPlan.CommitTransaction;
    end
    else
    raise Exception.create(ExecutionPlan.ExecException);

    except
      on e: Exception do
      begin
        AllOk := false;
      end;
    end;

    freeandNil(ExecutionPlan);




  if AllOk AND (InvoiceIndex > -1) then
  begin
    if groupAccount  then
    begin
      UpdPaymentsWhenChangingReservationToGroup(reservation,roomreservation)
    end else
    begin
      UpdPaymentsWhenChangingReservationToRoom(reservation,roomreservation)
    end;
  end;
end;

procedure Td.UpdPaymentsWhenChangingReservationToGroup(reservation,roomreservation : integer);
var
  rSet : TRoomerDataset;
  s : string;
  resList : string;
begin
  if roomreservation = 0 then // Change all in reservation
  begin
    Rset := CreateNewDataSet;
    try
      s := '';
      s := s+'   SELECT '#10;
      s := s+'     pm.id '#10;
      s := s+'   , pm.invoiceNumber '#10;
      s := s+'   , pm.TypeIndex '#10;
      s := s+'   , rr.reservation '#10;
      s := s+'   , rr.roomreservation '#10;
      s := s+'   , rr.groupAccount '#10;
      s := s+' FROM '#10;
      s := s+'   roomreservations rr '#10;
      s := s+'   LEFT OUTER JOIN payments pm ON pm.roomreservation = rr.roomreservation '#10;
      s := s+' WHERE '#10;
      s := s+'   (rr.Groupaccount <> 0) '#10;
      s := s+'   AND (pm.typeIndex=1) '#10;
      s := s+'   AND (pm.invoicenumber=-1) '#10;
      s := s+'   AND (rr.reservation='+_db(reservation)+') ';

      if hData.rSet_bySQL(rSet,s) then
      begin
        resList := '';
        while not rSet.eof do
        begin
          resList := resList+inttostr(rSet.FieldByName('roomreservation').AsInteger)+',';
          rSet.Next;
        end;
        delete(resList,length(resList),1);
      end;
    finally
      freeandnil(Rset);
    end;
  end else
  begin   // just change one room
    resList:=inttostr(roomreservation);
  end;

  if resList <> '' then
  begin
    Rset := CreateNewDataSet;
    try
      s := '';
      s := s+' SELECT '#10;
      s := s+'    pm.Reservation '#10;
      s := s+'   ,pm.RoomReservation '#10;
      s := s+'   ,pm.TypeIndex '#10;
      s := s+'   ,pm.InvoiceNumber '#10;
      s := s+'   ,date(pm.PayDate) AS payDate '#10;
      s := s+'   ,pm.Customer '#10;
      s := s+'   ,pm.PayType '#10;
      s := s+'   ,pm.Amount '#10;
      s := s+'   ,pm.Description '#10;
      s := s+'   ,pm.CurrencyRate '#10;
      s := s+'   ,pm.Currency '#10;
      s := s+'   ,pm.confirmDate '#10;
      s := s+'   ,pm.Notes '#10;
      s := s+'   ,pm.dtCreated '#10;
      s := s+'   ,pm.id '#10;
      s := s+'   ,rr.room '#10;
      s := s+'   ,'+format(Get_mainGuestname,['pe','pe','pm','GuestName'])+#10;
      s := s+' FROM '#10;
      s := s+'    payments pm '#10;
      s := s+'     INNER JOIN roomreservations rr ON pm.roomreservation = rr.roomreservation '#10;
      s := s+' WHERE '#10;
      s := s+'   (pm.roomreservation in ('+reslist+')) '#10;

      if hData.rSet_bySQL(rSet,s) then
      begin
        while not rSet.eof do
        begin
          s := '';
          s := s+'Move payment '+rSet.FieldByName('Description').asstring+ ' '#10;
          s := s+'To groupaccount '#10#10;
          s := s+'Amount : '+floattostr(rSet.FieldByName('Amount').asFloat)+ ' '#10;
          s := s+'Date : '+dateTimeToStr(rSet.FieldByName('dtCreated').asDateTime)+ ' '#10;;
          s := s+'Room/Guest : '+rSet.FieldByName('Room').asstring+ ' - '+rSet.FieldByName('GuestName').asstring+' '#10;

          if MessageDlg(s, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
          begin
            s := '';
            s := s+' UPDATE payments '+#10;
            s := s+' SET '+#10;
            s := s+'     roomreservation  = 0 '+#10;
            s := s+' WHERE '+#10;
            s := s+'       (ID = '+_db(rSet.FieldByName('id').asInteger)+') '+#10;
            if cmd_bySQL(s) then
            begin
            end;
          end;
          rSEt.Next;
        end;
     end;
    finally
      freeandnil(Rset);
    end;
  end;
end;
procedure Td.UpdPaymentsWhenChangingReservationToRoom(reservation,roomreservation : integer);
var
  rSet : TRoomerDataset;
  s : string;
begin
//    if roomreservation = 0 then exit;

  Rset := CreateNewDataSet;
  try
    s := '';
    s := s+' SELECT '#10;
    s := s+'    pm.Reservation '#10;
    s := s+'   ,pm.RoomReservation '#10;
    s := s+'   ,pm.TypeIndex '#10;
    s := s+'   ,pm.InvoiceNumber '#10;
    s := s+'   ,date(pm.PayDate) AS payDate '#10;
    s := s+'   ,pm.Customer '#10;
    s := s+'   ,pm.PayType '#10;
    s := s+'   ,pm.Amount '#10;
    s := s+'   ,pm.Description '#10;
    s := s+'   ,pm.CurrencyRate '#10;
    s := s+'   ,pm.Currency '#10;
    s := s+'   ,pm.confirmDate '#10;
    s := s+'   ,pm.Notes '#10;
    s := s+'   ,pm.dtCreated '#10;
    s := s+'   ,pm.id '#10;
    s := s+' FROM '#10;
    s := s+'    payments pm '#10;
    s := s+' WHERE '#10;
    s := s+'   (pm.reservation) ='+_Db(reservation)+' AND (pm.roomreservation=0) '#10;

    if hData.rSet_bySQL(rSet,s) then
    begin
      showmessage('There are '+inttostr(rSet.recordcount)+' payments on Groupaccount - You can move it manually to room ');
    end;
  finally
    freeandnil(Rset);
  end;
end;

function Td.GetBreakfastIncluted(reservation, RoomReservation : integer) : boolean;
var
  Rset : TRoomerDataSet;
  s : string;
begin
  result := false;
  Rset := CreateNewDataSet;
  try
//      s := '';
//      s := s + ' SELECT InvBreakfast FROM RoomReservations '+chr(10);
//      s := s + ' WHERE Reservation = ' + inttostr(reservation)+chr(10);
//      s := s + ' AND RoomReservation = ' + inttostr(RoomReservation)+chr(10);
    s := format(select_GetBreakfastIncluted , [reservation,RoomReservation]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      result := Rset['InvBreakfast'];
    end;
  finally
    freeandnil(Rset);
  end;
end;

function Td.GetGroupAccount(reservation, RoomReservation : integer) : boolean;
var
  Rset : TRoomerDataSet;
  s : string;
begin
  result := false;
  Rset := CreateNewDataSet;
  try
//      s := s + ' SELECT GroupAccount FROM RoomReservations '+chr(10);
//      s := s + ' WHERE Reservation = ' + inttostr(reservation)+chr(10);
//      s := s + ' AND RoomReservation = ' + inttostr(RoomReservation)+chr(10);
    s := format(select_GetGroupAccount, [reservation,RoomReservation]);
    if hData.rSet_bySQL(rSet,s) then
    begin
     result := Rset['GroupAccount'];
    end;
  finally
    freeandnil(Rset);
  end;
end;

function Td.OpenInvoiceInvoiceLines(reservation, RoomReservation : integer) : integer;
var
  s : string;
  Rset : TRoomerDataSet;
begin
  result := 0;

  Rset := CreateNewDataSet;
  try
//      s := s + ' SELECT '+chr(10);
//      s := s + ' COUNT(*) AS InvCount '+chr(10);
//      s := s + ' FROM [InvoiceLines]  '+chr(10);
//      s := s + ' WHERE (InvoiceNumber = -1) '+chr(10);
//      if reservation > 0 then
//        s := s + ' AND (Reservation = ' + inttostr(reservation) + ' ) '+chr(10);
//      if RoomReservation > 0 then
//        s := s + ' AND (RoomReservation = ' + inttostr(RoomReservation) + ' ) '+chr(10);

    s := select_OpenInvoiceInvoiceLines(reservation,roomreservation);
    if reservation > 0 then
      s := format(s , [reservation,RoomReservation]);
    if RoomReservation > 0 then
      s := format(s , [RoomReservation]);

    if hData.rSet_bySQL(rSet,s) then
    begin
      result := rSet.fieldbyname('InvCount').asInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.NameOnOpenInvoice(reservation, RoomReservation : integer) : string;
var
  s : string;
  Rset : TRoomerDataSet;
begin
  result := '<No Name>';

  Rset := CreateNewDataSet;
  try
//    s := s + ' SELECT '+chr(10);
//    s := s + ' Name '+chr(10);
//    s := s + ' FROM invoiceheads  '+chr(10);
//    s := s + ' WHERE (InvoiceNumber = -1) '+chr(10);
//    if reservation > 0 then
//      s := s + ' AND (Reservation = ' + inttostr(reservation) + ' ) '+chr(10);
//    if RoomReservation > 0 then
//      s := s + ' AND (RoomReservation = ' + inttostr(RoomReservation) + ' ) '+chr(10);
    s := select_NameOnOpenInvoice(reservation,roomreservation);
    if reservation > 0 then
    begin
      s := format(s, [reservation,RoomReservation]);
    end else
    if RoomReservation > 0 then
    begin
      s := format(s, [RoomReservation]);
    end;
    if hData.rSet_bySQL(rSet,s) then
    begin
      result := rSet.fieldbyname('Name').asString;
    end;
  finally
    freeandnil(Rset);
  end;
end;


function Td.GetRoomList_Occupied(dtDateFrom, dtDateTo : Tdate; iRoomReservation : integer; var lst : tstringList) : boolean;
var
  s : string;
  Rset : TRoomerDataSet;
begin
  lst.clear;


  s := '';
  s := s+'  SELECT '#10;
  s := s+'    DISTINCT Room '#10;
  s := s+'  FROM '#10;
  s := s+'     roomsdate '#10;
  s := s+'  WHERE '#10;
  s := s+'        (ADate >=  %s ) '#10;
  s := s+'    AND (ADate <  %s ) '#10;
  if iRoomReservation <> - 1 then
  begin
    s := s + '    AND (RoomReservation <> %d ) ' + #10;  //' + inttostr(RoomReservation) + '
  end;
  s := s + '    AND (subString(Room,1,1) <> ''<'') ' + #10;
  s := s + '    AND (ResFlag <> '+_db(STATUS_DELETED)+' )'#10;     //**zxhj línu bætt við
  s := s + '  ORDER BY Room '#10;


//    s := select_GetRoomList_Occupied(iRoomreservation);
  s := format(s , [_DateToDBDate(dtDateFrom,true),_DateToDBDate(dtDateTo,true),iRoomReservation]);

  Rset := CreateNewDataSet;
  try
    if hData.rSet_bySQL(rSet,s) then
    begin
      while not Rset.Eof do
      begin
        lst.Add(Rset.fieldbyname('room').asString);
        Rset.Next;
      end;
    end;
  finally
    freeandnil(Rset);
  end;
  result := lst.Count > 0;
end;


function Td.Occupied_fromTo(dtDateFrom, dtDateTo : Tdate; Room:string) : boolean;
var
  s : string;
  Rset : TRoomerDataSet;
begin
  result := false;
  s := '';
  s := s+'  SELECT '#10;
  s := s+'    Room '#10;
  s := s+'  FROM '#10;
  s := s+'     roomsdate '#10;
  s := s+'  WHERE '#10;
  s := s+'        (ADate >= '+_db(dtDateFrom)+' ) '#10;
  s := s+'    AND (ADate <  '+_db(dtDateTo)+' ) '#10;
  s := s + '    AND (ResFlag <> '+_db(STATUS_DELETED)+' )'#10;
  s := s + '    AND (Room = '+_db(room)+' )'#10;

  copytoclipboard(s);

  Rset := CreateNewDataSet;
  try
    if hData.rSet_bySQL(rSet,s) then
    begin
      result := true;
    end;
  finally
    freeandnil(Rset);
  end;
end;


// ------------------------------------------------------------------------------
//
//
// ------------------------------------------------------------------------------

function Td.isDay_Occupied(dtDate : Tdate; Room : string; var RoomReservation : integer) : boolean;
var
  s : string;
  Rset : TRoomerDataSet;
  sql : string;
begin
  result := false;

  Rset := CreateNewDataSet;
  try
  sql :=
  '  SELECT '#10+
  '    Room  '#10+
  '  , ADate '#10+
  '  , RoomReservation '#10+

  '  FROM '#10+
  '    roomsdate '#10+
  '  WHERE '+
  '        ((ADate =  %s ) '#10+
  '    AND (Room =  %s )) '#10+
  '   AND (ResFlag <> '+_db(STATUS_DELETED)+' ) '#10;  //      //**zxhj ATH


    s := format(sql , [_DateToDBDate(dtDate,true),_db(Room)]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      result := true;
      RoomReservation := Rset.fieldbyname('RoomReservation').asInteger;
    end;
  finally
    freeandnil(Rset);
  end;
end;

//  function TD.isDay_Occupied(dtDate : Tdate; Room : string; var RoomReservation : integer) : boolean;
//  var
//    s : string;
//    Rset : TRoomerDataSet;
//  begin
//    result := false;
//
//    // <roomsdate>SELECT **isDay_Occupied**
//    Rset := CreateNewDataSet;
//    try
////      s := '';
////      s := s + '  SELECT '+chr(10);
////      s := s + '    Room  '+chr(10);
////      s := s + '  , ADate '+chr(10);
////      s := s + '  , RoomReservation '+chr(10);
////      s := s + '  FROM '+chr(10);
////      s := s + '    roomsdate '+chr(10);
////      s := s + '  WHERE '+chr(10);
////      s := s + '        (ADate = ' + _DateToDBDate(dtDate,true) + ') '+chr(10);
////      s := s + '    AND (Room = ' + _db(Room) + ') '+chr(10);
//
//      s := format(select_isDay_Occupied , [_DateToDBDate(dtDate,true),_db(Room)]);
//      if hData.rSet_bySQL(rSet,s) then
//      begin
//        result := true;
//        RoomReservation := Rset.fieldbyname('RoomReservation').asInteger;
//      end;
//    finally
//      freeandnil(Rset);
//    end;
//  end;


function Td.RemoveRoomsDate(iRoomReservation : integer) : boolean;
var
  s : string;
begin
  result := true;
//    s := '';
//    s := s + ' delete FROM roomsdate '+chr(10);
//    s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation)+chr(10);

 //*zxhj Breytti status hér í 'X'
  s := '';
  s := 'UPDATE roomsdate SET ResFlag ='+_db(STATUS_DELETED)+' '#10;
  s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation)+chr(10);


  if not cmd_bySQL(s) then
  begin
    result := false;
  end;
end;



function Td.isAllDatesSameInRes(reservation : integer) : boolean;
//used 1
var
  Rset : TRoomerDataSet;
  s : string;
  Last : string;

begin
  result := true;
  Rset := CreateNewDataSet;
  try
    s := format(select_isAllDatesSameInRes , [reservation]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      Last := Rset.fieldbyname('Arrival').asString + Rset.fieldbyname('departure').asString;
      while not Rset.Eof do
      begin
        s := Rset.fieldbyname('Arrival').asString + Rset.fieldbyname('departure').asString;
        if s <> Last then
        begin
          result := false;
          exit;
        end;
        Last := s;
        Rset.Next;
      end;
    end;
  finally
    freeandnil(Rset);
  end;
end;



procedure Td.RemoveRoomReservation(RoomReservation : integer;CancelStaff,CancelReason,CancelInformation : string;CancelType : integer;doLog,useTrans,ask : boolean);
var
  Rset  : TRoomerDataSet;
  s,
  sInvoices     : string;
  doIt : boolean;
begin
  // Check if there is booked invoices for this roomreservation

  if ask then
  begin
    //doIt :=  MessageDlg('Delete room from reservation ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes;
    doIt :=  MessageDlg(GetTranslatedText('shTx_D_DeleteRoom'), mtConfirmation, [mbYes, mbNo], 0) = mrYes;
  end else
  begin
    doit := true;
  end;


  if not doIt then exit;

  sInvoices := '';
  Rset := CreateNewDataSet;
  try
    s := format(select_RemoveRoomReservation , [RoomReservation]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      s := '';
      while not Rset.Eof do
      begin
        sInvoices := sInvoices + Rset.fieldbyname('InvoiceNumber').asString + ', ';
        s := s + Rset.fieldbyname('InvoiceNumber').asString + ', ';
        Rset.Next;
      end;
    end;
  finally
    freeandnil(Rset);
  end;

  if sInvoices <> '' then
  begin
    // if MessageDlg('Bókaðir reikningar eru á þessari pöntunn - Viltu hætta við ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    if MessageDlg(GetTranslatedText('shTx_D_Cancel'), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      exit;
    end
    else
    begin
      Showmessage(format(GetTranslatedText('shTx_D_InvoicesInDeletedBooking'), [sInvoices]));
    end;
  end;


//    if doLog then
//    begin
//      ins_delRoomReservationInfo(RoomReservation, g.qUser,CancelReason,CancelInformation,CancelType);
//    end;

//    getCangeAvailabilityInfo(roomreservation,RoomType,status,Arrival,departure);

  roomerMainDataSet.SystemRemoveRoomReservation(RoomReservation, true, doLog, CancelReason, g.qUser, CancelInformation, CancelType);

//    if (status <> 'O') and (status <> 'N') then
//    begin
//      d.roomerMainDataSet.SystemChangeAvailability(RoomType, Arrival, Departure-1, false); // Auka framboð
//    end;


end;



procedure Td.SetAsNoRoomEnh(RoomReservation : integer; AllReservations : boolean);
var
  NewRoom : string;
  sPrompt : string;
  Rset : TRoomerDataSet;
  s : string;
  reservation : integer;
begin
  //sPrompt := 'Villtu örugglega setja þetta þessa herbergjapöntunn utan herbergja ?';
 sPrompt := GetTranslatedText('shTx_D_OrderConfirm');

  if AllReservations then
   //sPrompt := 'Viltu örugglega setja ÖLL herbergi pöntunnar ' + #13 + 'utan herbergja ?';
  sPrompt := GetTranslatedText('shTx_D_AllRoomsToNoRoom');

  if MessageDlg(sPrompt, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    roomerMainDataSet.SystemStartTransaction;
    try
        NewRoom := '';

        if AllReservations then
        begin
          reservation := RR_GetReservation(RoomReservation);
          Rset := CreateNewDataSet;
          try
//              s := '';
//              s := s + ' SELECT '+chr(10);
//              s := s + '    Roomreservation '+chr(10);
//              s := s + '  , Reservation '+chr(10);
//              s := s + ' FROM '+chr(10);
//              s := s + '   RoomReservations '+chr(10);
//              s := s + '  WHERE '+chr(10);
//              s := s + ' Reservation = ' + inttostr(reservation)+chr(10);
            s := format(select_SetAsNoRoomEnh , [reservation]);
            if hData.rSet_bySQL(rSet,s) then
            begin
              while not Rset.Eof do
              begin
                RoomReservation := Rset.fieldbyname('RoomReservation').asInteger;
                SetAsNoRoom(RoomReservation);
                Rset.Next;
              end;
            end;
          finally
            freeandnil(Rset);
          end;
        end
        else
        begin
          SetAsNoRoom(RoomReservation);
        end;
      roomerMainDataSet.SystemCommitTransaction;
    except
      roomerMainDataSet.SystemRollbackTransaction;
      raise ;
    end;
  end;
end;


function Td.GetCustomerFromRes(aRes : integer) : string;
var
  s : string;
  Rset : TRoomerDataSet;
begin
  result := '';

//    s := '';
//    s := s + '  SELECT ' + #10;
//    s := s + '     customer ' + #10;
//    s := s + '    ,reservation ';
//    s := s + '  FROM ' + #10;
//    s := s + '    reservations ' + #10;
//    s := s + '  WHERE ' + #10;
//    s := s + '        (Reservation=' + inttostr(aRes) + ') ' + #10;

  Rset := CreateNewDataSet;
  try
    s := format(select_GetCustomerFromRes , [aRes]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      result := Rset.fieldbyname('customer').asString;
    end;
  finally
    freeandnil(Rset);
  end;
end;

// Get by invoicenumber
function Td.GetInvoiceCurrency(InvoiceNumber : integer) : string;
var
  Rset : TRoomerDataSet;
  s : string;
begin
  result := ctrlGetString('NativeCurrency');

  Rset := CreateNewDataSet;
  try
//      s := '';
//      s := s + ' SELECT '+chr(10);
//      s := s + '    InvoiceNumber '+chr(10);
//      s := s + '   , ItemNumber '+chr(10);
//      s := s + '   , Currency '+chr(10);
//      s := s + ' FROM '+chr(10);
//      s := s + '   InvoiceLines '+chr(10);
//      s := s + ' WHERE '+chr(10);
//      s := s + '   (invoiceNumber = ' +_db(invoiceNumber) + ') '+chr(10);
    s := format(select_GetInvoiceCurrency , [invoiceNumber]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      result := Rset.fieldbyname('Currency').asString;
    end;
  finally
    freeandnil(Rset);
  end;
end;

function Td.GetInvoiceCurrencyAndReservationNumber(InvoiceNumber : integer;
               var Reservation, RoomReservation : Integer;
               var Room : String) : string;
var
  Rset : TRoomerDataSet;
  s : string;
begin
  result := ctrlGetString('NativeCurrency');

  Rset := CreateNewDataSet;
  try
//      s := '';
//      s := s + ' SELECT '+chr(10);
//      s := s + '    InvoiceNumber '+chr(10);
//      s := s + '   , ItemNumber '+chr(10);
//      s := s + '   , Currency '+chr(10);
//      s := s + ' FROM '+chr(10);
//      s := s + '   InvoiceLines '+chr(10);
//      s := s + ' WHERE '+chr(10);
//      s := s + '   (invoiceNumber = ' +_db(invoiceNumber) + ') '+chr(10);
    s := format(select_GetInvoiceCurrencyAndReservationIds , [invoiceNumber]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      result := Rset.fieldbyname('Currency').asString;
      Room := rSet['Room'];
      RoomReservation := rSet['RoomReservation'];
      Reservation := rSet['Reservation'];
    end;
  finally
    freeandnil(Rset);
  end;
end;


Procedure Td.GetInvoiceCurrencyAndRate(InvoiceNumber : integer; var currency : string; var Rate : double);
var
  Rset : TRoomerDataSet;
  s : string;
begin
  Currency := ctrlGetString('NativeCurrency');
  Rate := 1;

  Rset := CreateNewDataSet;
  try
    s := '';
//      s := s + ' SELECT '+chr(10);
//      s := s + '     InvoiceNumber '+chr(10);
//      s := s + '   , ItemNumber '+chr(10);
//      s := s + '   , Currency '+chr(10);
//      s := s + '   , ItemID '+chr(10);
//      s := s + '   , CurrencyRate '+chr(10);
//      s := s + ' FROM '+chr(10);
//      s := s + '   InvoiceLines '+chr(10);
//      s := s + ' WHERE '+chr(10);
//      s := s + '  (invoicenumber='+_Db(Invoicenumber)+') '+chr(10);
    s := format(select_GetInvoiceCurrencyAndRate , [Invoicenumber]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      Currency := Rset.fieldbyname('Currency').asString;
      Rate     := LocalFloatValue(Rset.fieldbyname('CurrencyRate').asString);
    end;
  finally
    freeandnil(Rset);
  end;
end;


procedure Td.AddPerson(iRoomReservation, iReservation : integer; ciCustomerInfo : recCustomerHolderEX; sType : string;
  bTransaction : boolean);
var
  iLastPerson : integer;
  s : string;
begin

  if bTransaction then
    roomerMainDataSet.SystemStartTransaction;
  try
      iLastPerson := PE_SetNewID();

      // SQL 315  xINSERT Persons
      s := '';
      s := s + 'INSERT into persons '+chr(10);
      s := s + '('+chr(10);
      s := s + '  Person '+chr(10);
      s := s + ', RoomReservation '+chr(10);
      s := s + ', Reservation '+chr(10);
      s := s + ', SurName '+chr(10);
      s := s + ', Name '+chr(10);
      s := s + ', Address1 '+chr(10);
      s := s + ', Address2 '+chr(10);
      s := s + ', Address3 '+chr(10);
      s := s + ', Address4 '+chr(10);
      s := s + ', Country '+chr(10);
      s := s + ', Company '+chr(10);
      s := s + ', GuestType '+chr(10);
      s := s + ', Information '+chr(10);
      s := s + ' )'+chr(10);

      s := s + ' Values '+chr(10);
      s := s + ' ('+chr(10);
      s := s + '  ' + inttostr(iLastPerson)+chr(10);
      s := s + ', ' + inttostr(iRoomReservation)+chr(10);
      s := s + ', ' + inttostr(iReservation)+chr(10);
      s := s + ', ' + _db(ciCustomerInfo.CustomerName)+chr(10);
      s := s + ', ' + _db(ciCustomerInfo.DisplayName)+chr(10);
      s := s + ', ' + _db(ciCustomerInfo.Address1)+chr(10);
      s := s + ', ' + _db(ciCustomerInfo.Address2)+chr(10);
      s := s + ', ' + _db(ciCustomerInfo.Address3)+chr(10);
      s := s + ', ' + _db(ciCustomerInfo.Address4)+chr(10);
      s := s + ', ' + _db(ciCustomerInfo.Country)+chr(10);
      s := s + ', ' + _db('')+chr(10);
      s := s + ', ' + _db(sType)+chr(10);
      s := s + ', ' + _db('')+chr(10);
      s := s + ' )'+chr(10);
      if not cmd_bySQL(s) then
      begin
      end;

    if bTransaction then
      roomerMainDataSet.SystemCommitTransaction;
   except
    if bTransaction then
      roomerMainDataSet.SystemRollbackTransaction;
    raise ;
  end;
end;

procedure Td.RemovePerson(iRoomReservation : integer; bTransaction : boolean);
var
  s : string;
  Id : integer;
begin
  Id := RR_GetLastGuestID(iRoomReservation);

  if Id = 0 then
    exit;

  if bTransaction then
    roomerMainDataSet.SystemStartTransaction;
  try
      s := '';
      s := s + ' DELETE FROM persons '+chr(10);
      s := s + ' WHERE Person=' + inttostr(Id) + ' '+chr(10);

      if not cmd_bySQL(s) then
      begin
      end;
    if bTransaction then
      roomerMainDataSet.SystemCommitTransaction;
  except
    if bTransaction then
      roomerMainDataSet.SystemRollbackTransaction;
    raise ;
  end;
end;

procedure Td.UpdateUsersLanguage(Staff : string; iLanguage : integer);
var
  s : string;
begin
  s := '';
  s := s + 'UPDATE staffmembers '+chr(10);
  s := s + '   set StaffLanguage = ' + inttostr(iLanguage)+chr(10);
  s := s + ' where Initials = ' + _db(Staff)+chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

type
  TRoomInfoRecord = record
    RoomNumber : string;
    reservation, RoomReservation : integer;
  end;

//  function TD.isRoomCheckedIN(iRoomReservation : integer) : boolean;
//  var
//    Rset : TRoomerDataSet;
//    s : string;
//  begin
//    Rset := CreateNewDataSet;
//    try
//      s := format(select_isRoomCheckedIN , [iRoomReservation]);
//      result := hData.rSet_bySQL(rSet,s);
//    finally
//      freeandnil(Rset);
//    end;
//  end;


procedure Td.SetUnclean(Room : string);
var
  s : string;
begin
  if not ctrlGetBoolean('useSetUnclean') then exit;
  s := '';
  s := s + 'UPDATE rooms '+chr(10);
  s := s + '   Set Status = ' + _db('U')+chr(10);
  s := s + ' where Room  = ' + _db(Room)+chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

procedure Td.SetAllClean;
var
  s : string;
begin
    s := '';
    s := s + 'UPDATE rooms '+chr(10);
    s := s + '   Set Status = ' + _db('C')+chr(10);
    if not cmd_bySQL(s) then
    begin
    end;
end;

procedure Td.SetAllUnClean;
var
  s : string;
begin
    s := '';
    s := s + 'UPDATE rooms '+chr(10);
    s := s + '   Set Status = ' + _db('U')+chr(10);
    if not cmd_bySQL(s) then
    begin
    end;
end;


function Td.GetCustomerPreferences(CustomerID : string) : string;
var
  Rset : TRoomerDataSet;
  s : string;
begin
  result := '';

  Rset := CreateNewDataSet;
  try
    s := format(select_GetCustomerPreferences , [ _db(CustomerID)]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      with Rset do
      begin
        First;
        while not Eof do
        begin
          result := result + '[' + trim(fieldbyname('Description').asString) + ']' + #13#10 + trim(fieldbyname('Preference').Text)
            + #13#10#13#10;
          Next;
        end;
      end;
    end;
  finally
    freeandnil(Rset);
  end;
end;

function Td.GetCustomerName(customer : string) : string;
begin
  Result := '';

  result := '';
  if glb.CustomersSet.Locate('customer',Customer,[loCaseInsensitive]) then
  begin
    result := glb.CustomersSet.FieldByName('SurName').AsString;
  end;

//    Rset := CreateNewDataSet;
//    try
//      s := format(select_GetCustomerName , [_db(Customer)]);
//      if hData.rSet_bySQL(rSet,s) then
//      begin
//          result := trim(Rset.fieldbyname('SurName').asString);
//      end;
//    finally
//      Rset.Free;
//    end;
end;

function Td.GetRoomStatus(Room : string) : char;
var
  Rset : TRoomerDataSet;
  s : string;
begin
  result := 'C';

  Rset := CreateNewDataSet;
  try
//      s := s + ' SELECT '+chr(10);
//      s := s + '   status '+chr(10);
//      s := s + ' FROM '+chr(10);
//      s := s + '   rooms '+chr(10);
//      s := s + ' WHERE '+chr(10);
//      s := s + '   room=' + _db(Room) + ' '+chr(10);
    s := format(select_GetRoomStatus , [ _db(Room)]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      if ANSIuppercase(Rset.fieldbyname('Status').asString) = 'C' then
        result := 'C'
      else if ANSIuppercase(Rset.fieldbyname('Status').asString) = 'U' then
        result := 'U'
      else if ANSIuppercase(Rset.fieldbyname('Status').asString) = 'O' then
        result := 'O'
      else if ANSIuppercase(Rset.fieldbyname('Status').asString) = '1' then
        result := '1'
      else if ANSIuppercase(Rset.fieldbyname('Status').asString) = '2' then
        result := '2'
      else if ANSIuppercase(Rset.fieldbyname('Status').asString) = '3' then
        result := '3'
    end;
  finally
    freeandnil(Rset);
  end;
end;

function Td.AskApproval(PayType : string) : boolean;
var
  Rset : TRoomerDataSet;
  s : string;
begin
  result := false;
  Rset := CreateNewDataSet;
  try
//      s := s + ' SELECT  '+chr(10);
//      s := s + '  AskCode '+chr(10);
//      s := s + ' FROM  '+chr(10);
//      s := s + '  PayTypes '+chr(10);
//      s := s + ' WHERE  '+chr(10);
//      s := s + '  PayType =' + _db(PayType) + ' '+chr(10);
    s := format(select_AskApproval , [ _db(PayType)]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      result := Rset['AskCode'];
    end;
  finally
    freeandnil(Rset);
  end;
end;

//  function TD.VATDescription(code : string) : string;
//  var
//    Rset : TRoomerDataSet;
//    s : string;
//  begin
//    result := '';
//    Rset := CreateNewDataSet;
//    try
////      s := s + ' SELECT '+chr(10);
////      s := s + '   description '+chr(10);
////      s := s + ' FROM '+chr(10);
////      s := s + '   VatCodes '+chr(10);
////      s := s + ' WHERE '+chr(10);
////      s := s + '  VatCode=' + _db(code) + ' '+chr(10);
//      s := format(select_VATDescription , [_db(code)]);
//      if hData.rSet_bySQL(rSet,s) then
//    	begin
//        result := Rset.fieldbyname('Description').asString;
//      end;
//    finally
//      freeandnil(Rset);
//    end;
//  end;

function Td.FieldExists(rSet : TRoomerDataSet; FieldName : String): Boolean;
begin
  result := assigned(rSet.FindField(FieldName));
end;

function Td.VATDescription(code : string) : string;
begin
  result := '';
  try
    if LocateRecord(glb.VAT, 'VATCode', code) then
      result := glb.VAT.fieldbyname('description').asString;
  except
  end;
end;

function Td.VATvalueFormula(code : string) : String;
begin
  result := '';

  try
    if FieldExists(glb.Vat, 'valueFormula') AND
       LocateRecord(glb.VAT, 'VATCode', code) then
        result := glb.VAT['valueFormula'];
  except
  end;
end;

function Td.PackageVATvalueFormula(package, item : string; vatPercentage : Double) : String;
var  itemId, packageId : Integer;
begin
  result := '';
  if LocateRecord(glb.Items, 'Item', item) then
  try
    itemId := glb.Items['id'];
    if FieldExists(glb.PackageItems, 'unitPriceVatFormula') then
    begin
      if LocateRecord(glb.Packages, 'package', package) then
      begin
        packageId := glb.Packages['id'];
        if LocateRecord(glb.PackageItems, 'packageId', packageId) then
          while NOT glb.PackageItems.Eof do
          begin
            if (itemId = glb.PackageItems['itemId']) AND (packageId = glb.PackageItems['packageId']) then
            begin
              result := glb.PackageItems['unitPriceVatFormula'];
              result := StringReplace(result, '{unitPrice}', FloatToStr(glb.PackageItems['unitPrice']),  [rfReplaceAll, rfIgnoreCase]);
              result := StringReplace(result, '{numItems}', FloatToStr(glb.PackageItems['numItems']),  [rfReplaceAll, rfIgnoreCase]);
              result := StringReplace(result, '{vat}', FloatToStr(vatPercentage),  [rfReplaceAll, rfIgnoreCase]);
              break;
            end;
            glb.PackageItems.Next;
          end;
      end;
    end;
  except
  end;
end;

procedure Td.VATvalueFormulaAndPercentage(code : String; package : String; item : String; var Formula : string; var Percentage : double);
var packageFormula : String;
begin
  Formula := '';
  packageFormula := '';
  Percentage := 0.00;

  try
    if LocateRecord(glb.VAT, 'VATCode', code) then
    begin
      Percentage := LocalFloatValue(glb.VAT.fieldbyname('VATPercentage').asString);
      if FieldExists(glb.Vat, 'valueFormula') then
        Formula := glb.VAT['valueFormula'];
      packageFormula := PackageVATvalueFormula(package, item, LocalFloatValue(glb.VAT.fieldbyname('VATPercentage').asString));
      if packageFormula <> '' then
        formula := packageFormula;
    end;
  except
  end;
end;

function Td.VATPercentage(code : string) : double;
begin
  result := 0.00;

  try
    if LocateRecord(glb.VAT, 'VATCode', code) then
      result := LocalFloatValue(glb.VAT.fieldbyname('VATPercentage').asString);
  except
  end;
end;

function Td.Item_Get_Type(Item : string) : string;
begin
  result := '';
  glb.LocateSpecificRecordAndGetValue('items', 'Item', Item, 'ItemType', result);
end;

function Td.Item_Get_ItemTypeInfo(Item : string; package : String = '') : TItemTypeInfo;
var
  Itemtype : string;
  tmpStr : String;
  tmpDbl : Double;

begin
  fillchar(result, sizeof(result), 0);
  Itemtype := Item_Get_Type(Item);
  if glb.LocateSpecificRecord('itemtypes', 'Itemtype', Itemtype) then
    begin
      result.Itemtype := Itemtype; //trim(glb.ItemTypes.fieldbyname('ItemType').asString);
      result.Description := trim(glb.ItemTypes.fieldbyname('Description').asString);
      result.Price := Item_GetPrice(Item);
      result.VATCode := trim(glb.ItemTypes.fieldbyname('VATCode').asString);
      VATvalueFormulaAndPercentage(result.VATCode, package, Item, tmpStr, tmpDbl);
      result.VATPercentage := tmpDbl;
      result.valueFormula := tmpStr;
    end;
end;

function Td.StaffExists(Staff : string) : boolean;
var
  Rset : TRoomerDataSet;
  s : string;
begin
  result := false;
  Rset := CreateNewDataSet;
  try
    s := format(select_StaffExists , [_db(Staff)]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      result := true;
    end;
  finally
    freeandnil(Rset);
  end;
end;

function Td.CustomerTypeName(CustomerTypeCode : string) : string;
var
  Rset : TRoomerDataSet;
  s : string;
begin
  result := '';
  Rset := CreateNewDataSet;
  try
//      s := s + ' SELECT '+chr(10);
//      s := s + '   Description '+chr(10);
//      s := s + ' FROM '+chr(10);
//      s := s + '   CustomerTypes '+chr(10);
//      s := s + ' WHERE '+chr(10);
//      s := s + ' Customertype=' + _db(CustomerTypeCode) + ' '+chr(10);
    s := format(select_CustomerTypeName , [_db(CustomerTypeCode)]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      result := trim(Rset.fieldbyname('Description').asString);
    end;
  finally
    freeandnil(Rset);
  end;
end;

function Td.SetInvoiceOrginalRef(Invoice, RoomReservation, OrginalRef : integer) : boolean;
var
  Rset : TRoomerDataSet;
  s : string;
begin
  result := false;
  Rset := CreateNewDataSet;
  try
//      s := s + ' SELECT '+chr(10);
//      s := s + '     RoomReservation '+chr(10);
//      s := s + '   , OriginalInvoice '+chr(10);
//      s := s + ' FROM '+chr(10);
//      s := s + '   InvoiceHeads '+chr(10);
//      s := s + ' WHERE '+chr(10);
//      s := s + '   (InvoiceNumber =' + inttostr(Invoice) + ' ) '+chr(10);
//      s := s + ' AND  (RoomReservation =' + inttostr(RoomReservation) + ' ) '+chr(10);
    s := format(select_SetInvoiceOrginalRef , [Invoice,RoomReservation]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      Rset.edit;
      Rset.fieldbyname('OriginalInvoice').asInteger := OrginalRef;
      Rset.Post; //ID ADDED
      result := true;
    end;
  finally
    freeandnil(Rset);
  end;
end;

/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////


function Td.qryGetRoomPrices_1(Orderstr : string; priceCodeID, seasonId : integer; RoomType, Currency : string; seEndDate : TdateTime) : string;
var
  s : string;
begin
  //ATH  EKKI HÆGT !!!!!! CREATE FUNCTION
  s := '';
  s := s + 'SELECT ' + chr(10);
  s := s + '* ' + chr(10);
  s := s + 'FROM ' + chr(10);
  s := s + 'viewroomprices1 ' + chr(10);
  s := s + 'WHERE  ' + chr(10);
  s := s + '( (Id < 0) ' + chr(10); // just to start then AND sequance

  if priceCodeID > - 1 then
    s := s + ' AND (pcID=' + inttostr(priceCodeID) + ') ' + chr(10);
  // ooOO TímabilsAfmörkunn BYRJAR
  if seasonId > - 1 then
  begin // nákvæmlega ákveðið tímabil
    s := s + ' AND (seID=' + inttostr(seasonId) + ') ' + chr(10);
  end
  else if seasonId = - 2 then
  begin // núverandi +
    s := s + ' AND (seEndDate>' + _DateToDBDate(Date,true) + ') ' + chr(10);
  end
  else if seasonId = - 3 then
  begin // Núverandi =
    s := s + ' AND ((seStartDate<=' + _DateToDBDate(Date,true) + ') AND (seEndDate>' + _DateToDBDate(Date + 1,true) + ')) ' + chr(10);
  end
  else if seasonId = - 4 then
  begin // liðinn
    s := s + ' AND (seEndDate<' + _DateToDBDate(Date + 1,true) + ') ' + chr(10);
  end
  else if seEndDate > 1 then //
  begin
    s := s + ' AND (seEndDate>' + _DateToDBDate(seEndDate,true) + ') ' + chr(10);
  end;
  // xxXX TímabilsAfmörkunn Endar

  if RoomType <> '' then
    s := s + ' AND (RoomType=' + _db(RoomType) + ') ' + chr(10);

  if Currency <> '' then
    s := s + ' AND (Currency=' + _db(Currency) + ') ' + chr(10);

  s := s + ' ) ' + chr(10);

  s := s + 'ORDER BY ' + Orderstr + ' ' + chr(10);

  result := s;

end;

function Td.OpenRoomPricesQuery_1(var SortField, SortDir : string; priceCodeID, seasonID : integer; RoomType, Currency : string;seEndDate : TdateTime) : boolean;
var
  extraSort : string;
begin
  // **
  extraSort := '';
  RoomType := trim(RoomType);
  Currency := trim(Currency);

  zRoomPricesFilter_1 := '';
  if viewRoomPrices1_.active then
    viewRoomPrices1_.close;
  if _trimlower(SortField) <> 'sestartdate' then
    extraSort := ', seStartDate ';
  viewRoomPrices1_.CommandText := qryGetRoomPrices_1(SortField + ' ' + SortDir + extraSort, priceCodeID, seasonID, RoomType, Currency,
    seEndDate);

  viewRoomPrices1_.open;
  result := true;
end;

function Td.PriceExistsByCodes(pcCode, seDescription, RoomType, Currency : string) : boolean;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_PriceExistsByCodes , [_db(pcCode),_db(seDescription),_db(RoomType),_db(Currency)]);
    result :=  hData.rSet_bySQL(rSet,s);
  finally
    freeandNil(rSet);
  end;
//    s := s + 'SELECT '+chr(10);
//    s := s + 'pcCode, '+chr(10);
//    s := s + 'seDescription, '+chr(10);
//    s := s + 'RoomType, '+chr(10);
//    s := s + 'Currency '+chr(10);
//    s := s + 'FROM '+chr(10);
//    s := s + 'viewRoomPrices1 '+chr(10);
//    s := s + 'WHERE '+chr(10);
//    s := s + '(pcCode = ' + _db(pcCode) + ') AND '+chr(10);
//    s := s + '(seDescription = ' + _db(seDescription) + ') AND '+chr(10);
//    s := s + '(RoomType = ' + _db(RoomType) + ') AND '+chr(10);
//    s := s + '(Currency = ' + _db(Currency) + ') '+chr(10);
end;


function Td.PriceExistsByCodesAndCurrency(pcCode, Currency : string) : boolean;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_PriceExistsByCodesAndCurrency , [_db(pcCode),_db(Currency)]);
    result := hData.rSet_bySQL(rSet,s);
  finally
    freeandNil(rSet);
  end;
//    s := s + 'SELECT '+chr(10);
//    s := s + 'pcCode, '+chr(10);
//    s := s + 'Currency '+chr(10);
//    s := s + 'FROM '+chr(10);
//    s := s + 'viewRoomPrices1 '+chr(10);
//    s := s + 'WHERE '+chr(10);
//    s := s + '(pcCode = ' + _db(pcCode) + ') AND '+chr(10);
//    s := s + '(Currency = ' + _db(Currency) + ') '+chr(10);
end;



function Td.imPortLog_getLastID: integer;
  var
    rSet : TRoomerDataSet;
    s : string;
  begin
    result := 0;
    rSet := CreateNewDataSet;
    try
      //s := 'SELECT TOP(1)ID FROM tblImportLogs WHERE importResultID <> 10010 ';
      s := format(select_imPortLog_getLastID , []);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        result := rSet.FieldByName('ID').AsInteger;
      end;
    finally
      freeandnil(rSet);
    end;
  end;


  function Td.imPortLog_InvoiceNumber  : integer;
  var
    rSet : TRoomerDataSet;
    s : string;
  begin
    result := 0;
    rSet := CreateNewDataSet;
    try
//      s := s+'  SELECT TOP (1) '+chr(10);
//      s := s+'    ID '+chr(10);
//      s := s+'    ,invoiceNumber '+chr(10);
//      s := s+'  FROM '+chr(10);
//      s := s+'  tblPoxExport '+chr(10);
      s := format(select_imPortLog_InvoiceNumber , []);
      if hData.rSet_bySQL(rSet,s) then
      begin
        result := rSet.FieldByName('invoiceNumber').AsInteger;
        //ATH POST --> DELETE
        rSet.Delete;
      end;
    finally
      freeandnil(rSet);
    end;
  end;

  function Td.imPortLog_isNewAvailable: boolean;
  var
    id : integer;
  begin
    result := false;
    id := imPortLog_getLastID;
    if id <> g.qLastImportLogID then
    begin
      result := true;
      g.qLastImportLogID := id;
    end;
  end;



  function Td.inDateRange(seasonId : integer; FromDate, ToDate : Tdate; var RangeStart, RangeEnd : Tdate) : boolean;
  var
    Rset : TRoomerDataSet;
    s : string;
    i : integer;

    startDate : Tdate;
    endDate : Tdate;

  begin
    result := false;
    Rset := CreateNewDataSet;
    try
//      s := s + ' SELECT '+chr(10);
//      s := s + '   ID '+chr(10);
//      s := s + ' ,  seStartDate '+chr(10);
//      s := s + ' ,  seEndDate '+chr(10);
//      s := s + ' FROM '+chr(10);
//      s := s + '   tblSeasons '+chr(10);
//      s := s + ' WHERE '+chr(10);
//      s := s + '  ID=' + inttostr(seasonId) + ' '+chr(10);
      s := format(select_inDateRange , [seasonId]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        startDate := trunc(Rset.fieldbyname('seStartDate').asDateTime);
        endDate := trunc(Rset.fieldbyname('seEndDate').asDateTime);
        for i := trunc(FromDate) to trunc(ToDate) - 1 do
        begin
          if (i >= startDate) and (i <= endDate) then
          begin
            RangeStart := FromDate;
            RangeEnd := ToDate;
            if ToDate > endDate then
              RangeEnd := endDate + 1;
            if FromDate < startDate then
              RangeStart := startDate;
            result := true;
            break;
          end;
        end;
      end;
    finally
      freeandnil(Rset);
    end;
  end;

function Td.RoomsTypeCount(CountAll : boolean) : integer;
  var
    Rset : TRoomerDataSet;
    s : string;
  begin
    result := 0;

    Rset := CreateNewDataSet;
    try
//      s := s + ' SELECT DISTINCT ROOMTYPE'+chr(10);
//      s := s + ' FROM Rooms '+chr(10);
//      if not CountAll then
//      begin
//        s := s + ' WHERE  '+chr(10);
//        s := s + ' (bookable = 1) '+chr(10);
//      end;
      if CountAll then
      begin
        s := format(select_RoomsTypeCount2 , []);
      end else
      begin
        s := format(select_RoomsTypeCount , []);
      end;

      if hData.rSet_bySQL(rSet,s) then
	    begin
        result := Rset.recordCount;
      end;
    finally
      freeandnil(Rset);
    end;
  end;


// ******************************************************************************
  //
  //
  // ******************************************************************************

  function Td.isUnPaid(RoomReservation : integer) : boolean;
  var
    Rset : TRoomerDataSet;
    s : string;
  begin
    Rset := CreateNewDataSet;
    try
      s := format(select_isUnPaid , [RoomReservation]);
      result :=  hData.rSet_bySQL(rSet,s);
    finally
      freeandnil(rSet);
    end;
  end;

  function Td.isUnPaidByRes(Reservation : integer) : boolean;
  var
    Rset : TRoomerDataSet;
    s : string;
  begin
    Rset := CreateNewDataSet;
    try
      s := format(select_isUnPaidRes , [Reservation]);
      result :=  hData.rSet_bySQL(rSet,s);
    finally
      freeandnil(rSet);
    end;
  end;


function Td.GetRoomReservation(reservation : integer; Room : string) : integer;
  var
    s : string;
    Rset : TRoomerDataSet;
  begin
    result := 0;
//    s := s + '  SELECT ' + #10;
//    s := s + '     room ' + #10;
//    s := s + '    ,roomReservation ';
//    s := s + '    ,reservation ';
//    s := s + '  FROM ' + #10;
//    s := s + '    RoomReservations ' + #10;
//    s := s + '  WHERE ' + #10;
//    s := s + '        (Reservation=' + inttostr(reservation) + ') ' + #10;
//    s := s + '   And   (Room=' + _db(Room) + ') ' + #10;
    Rset := CreateNewDataSet;
    try
      s := format(select_GetRoomReservation , [reservation,_db(Room)]);
      if hData.rSet_bySQL(rSet,s) then
      begin
        result := Rset.fieldbyname('RoomReservation').asInteger;
      end;
    finally
      freeandnil(Rset);
    end;
  end;

function Td.RemoveRoomReservationByReservation(iReservation : integer) : boolean;
  var
    s : string;
  begin
    result := true;
    s := '';
    s := s + ' DELETE FROM roomreservations '+chr(10);
    s := s + ' WHERE Reservation = ' + inttostr(iReservation)+chr(10);
    if not cmd_bySQL(s) then
    begin
      result := false;
    end;
  end;

  function Td.RemoveInvoiceHeadsByReservation(iReservation : integer) : boolean;
  var
    s : string;
  begin
    result := true;
    s := '';
    s := s + ' DELETE FROM invoiceheads '+chr(10);
    s := s + ' WHERE Reservation = ' + inttostr(iReservation)+chr(10);
    if not cmd_bySQL(s) then
    begin
      result := false;
    end

  end;

function Td.RemoveInvoiceCashInvoice : boolean;
  var
    s : string;
  begin
    result := true;

    //ATHOLD 09112 Setja inn roolback

    s := '';
    s := s + ' DELETE FROM invoicelines '+chr(10);
    s := s + ' WHERE (Reservation = 0) AND (RoomReservation = 0) AND (SplitNumber = 2) AND (InvoiceNumber = -1) '+chr(10);
    if not cmd_bySQL(s) then
    begin
      result := false;
    end;

    s := '';
    s := s + ' DELETE FROM invoiceheads '+chr(10);
    s := s + ' WHERE (Reservation = 0) AND (RoomReservation = 0) AND (SplitNumber = 2) AND (InvoiceNumber = -1) '+chr(10);
    if not cmd_bySQL(s) then
    begin
      result := false;
    end;
  end;

  function Td.RemoveReservationsByReservation(iReservation : integer) : boolean;
  var
    s : string;
  begin
    result := true;
    s := '';
    s := s + ' DELETE FROM reservations '+chr(10);
    s := s + ' WHERE Reservation = ' + inttostr(iReservation)+chr(10);
    if not cmd_bySQL(s) then
    begin
      result := false;
    end;
  end;

  function Td.Del_PaymentByInvoice(iNumber : integer) : boolean;
  var
    s : string;
  begin
    result := true;
    s := '';
    s := s + 'DELETE '+chr(10);
    s := s + 'FROM payments '+chr(10);
    s := s + 'WHERE  '+chr(10);
    s := s + '(InvoiceNumber =' + inttostr(iNumber) + ') '+chr(10);
    if not cmd_bySQL(s) then
    begin
      result := false;
    end;
  end;

function dateTime2SQLdate(const dDate : TdateTime) : string;
  begin
    result := _db(FormatDateTime('mm"/"dd"/"yyyy hh:nn:ss', dDate));
  end;

  function Td.InsInvoiceAction(R : TInvoiceActionRec) : boolean;
  var
    s : string;
  begin
    result := false;
    s := '';
    s := s + 'INSERT into tblinvoiceactions'+chr(10);
    s := s + '('+chr(10);
    s := s + '  Reservation '+chr(10);
    s := s + ', RoomReservation '+chr(10);
    s := s + ', InvoiceNumber '+chr(10);
    s := s + ', ActionDate '+chr(10);
    s := s + ', ActionID '+chr(10);
    s := s + ', Action '+chr(10);
    s := s + ', ActionNote '+chr(10);
    s := s + ', Staff '+chr(10);
    s := s + ')'+chr(10);

    s := s + 'Values'+chr(10);
    s := s + '('+chr(10);

    s := s + '  ' + inttostr(R.reservation)+chr(10);
    s := s + ', ' + inttostr(R.RoomReservation)+chr(10);
    s := s + ', ' + inttostr(R.InvoiceNumber)+chr(10);
    s := s + ', ' + _dateTimeToDBdate(R.ActionDate,true)+chr(10);
    s := s + ', ' + inttostr(R.ActionID)+chr(10);
    s := s + ', ' + _db(R.Action)+chr(10);
    s := s + ', ' + _db(R.ActionNote)+chr(10);
    s := s + ', ' + _db(R.Staff)+chr(10);
    s := s + ')'+chr(10);
    if not cmd_bySQL(s) then
    begin
    end;
  end;

function Td.Del_MaidsJobsByDate(adate : Tdate; All : boolean) : boolean;
  var
    s : string;
  begin
    result := true;

    s := '';
    s := s + ' DELETE '+chr(10);
    s := s + ' FROM tblmaidjobs '+chr(10);
    s := s + ' WHERE  '+chr(10);
    s := s + ' (mjDate = ' + _DateToDBDate(adate,true) + ') '+chr(10);
    if not All then
    begin
      s := s + ' AND (mjAction <> ' + _db('EXTRA') + ') '+chr(10);
    end;

   if not cmd_bySQL(s) then
   begin
     result := false;
   end;
 end;

 procedure Td.DayNotes_BeforePost(DataSet : TDataSet);
 begin
 end;

  ///

  function Td.getRoomTypeFromRR(RR : integer) : string;
  var
    Rset : TRoomerDataSet;
    s : string;
  begin
    result := '';

    Rset := CreateNewDataSet;
    try
//    s := s + ' SELECT RoomType'+chr(10);
//    s := s + ' FROM RoomReservation '+chr(10);
//    s := s + ' WHERE  '+chr(10);
//    s := s + ' (RoomReservation = ' + inttostr(RR) + ' ) '+chr(10);
      s := format(select_getRoomTypeFromRR , [RR]);
      if hData.rSet_bySQL(rSet,s) then
     	begin
        result := Rset.fieldbyname('RoomType').asString;
      end;
    finally
      freeandnil(Rset);
    end;
  end;

function Td.getChangeAvailabilityInfo(RR : integer; var RoomType,Status : string; var Arrival,departure : Tdate) : boolean;
  var
    Rset : TRoomerDataSet;
    s : string;
  begin
    result := false;

    Rset := CreateNewDataSet;
    try
      s := s + ' SELECT Status,RoomType, rrArrival,rrDeparture'+chr(10);
      s := s + ' FROM roomreservations '+chr(10);
      s := s + ' WHERE  '+chr(10);
      s := s + ' (RoomReservation = ' + inttostr(RR) + ' ) '+chr(10);
      s := format(s , [RR]);
      if hData.rSet_bySQL(rSet,s) then
     	begin
        RoomType  := rSet.FieldByName('RoomType').AsString;
        status    := rSet.FieldByName('Status').AsString;
        Arrival   := rSet.FieldByName('rrArrival').AsDateTime;
        Departure := rSet.FieldByName('rrDeparture').AsDateTime;
        result := true;
      end;
    finally
      freeandnil(Rset);
    end;
  end;


  function Td.getCountryGroupNameFromCountry(Country : string) : string;
  var
    Rset : TRoomerDataSet;
    s : string;
  begin
    result := '';
    Rset := CreateNewDataSet;
    try
//      s := s + ' SELECT '+chr(10);
//      s := s + '     Countries.Country '+chr(10);
//      s := s + '   , CountryGroups.GroupName '+chr(10);
//      s := s + ' FROM '+chr(10);
//      s := s + '    Countries LEFT OUTER JOIN '+chr(10);
//      s := s + '      CountryGroups ON Countries.CountryGroup = CountryGroups.CountryGroup '+chr(10);
//      s := s + ' WHERE '+chr(10);
//      s := s + '   (Countries.Country = ' + _db(Country) + ') '+chr(10);
       s := format(select_getCountryGroupNameFromCountry , [ _db(Country)]);
       if hData.rSet_bySQL(rSet,s) then
	     begin
        result := Rset.fieldbyname('GroupName').asString;
       end;
    finally
      freeandnil(Rset);
    end;
  end;

  function Td.getCountryFromReservation(reservation : integer) : string;
  var
    Rset : TRoomerDataSet;
    s : string;
  begin
    result := '';

    Rset := CreateNewDataSet;
    try
//      s := s + ' SELECT '+chr(10);
//      s := s + '     Country '+chr(10);
//      s := s + ' FROM '+chr(10);
//      s := s + '  reservations '+chr(10);
//      s := s + ' WHERE '+chr(10);
//      s := s + '   (Reservation = ' + inttostr(reservation) + ') '+chr(10);
      s := format(select_getCountryFromReservation , [reservation]);
      if hData.rSet_bySQL(rSet,s) then
      begin
        result := Rset.fieldbyname('country').asString;
      end;
    finally
      freeandnil(Rset);
    end;
  end;

  function Td.getCountryGroupFromCountry(Country : string) : string;
  var
    Rset : TRoomerDataSet;
    s : string;
  begin
    result := '';

    Rset := CreateNewDataSet;
    try
//    s := s + ' SELECT '+chr(10);
//    s := s + '     Countries.Country '+chr(10);
//    s := s + '   , Countries.CountryGroup '+chr(10);
//    s := s + ' FROM '+chr(10);
//    s := s + '   Countries '+chr(10);
//    s := s + ' WHERE '+chr(10);
//    s := s + '   (Countries.Country = ' + _db(Country) + ') '+chr(10);
      s := format(select_getCountryGroupFromCountry , [_db(Country)]);
      if hData.rSet_bySQL(rSet,s) then
     	begin
        result := Rset.fieldbyname('CountryGroup').asString;
      end;
    finally
      freeandnil(Rset);
    end;
  end;

  function Td.getLocationFromRoom(Room : string) : string;
  var
    Rset : TRoomerDataSet;
    s : string;
  begin
    result := '';

    Rset := CreateNewDataSet;
    try
//      s := s + ' SELECT '+chr(10);
//      s := s + '     Rooms.Location '+chr(10);
//      s := s + ' FROM '+chr(10);
//      s := s + '   Rooms '+chr(10);
//      s := s + ' WHERE '+chr(10);
//      s := s + '   (Room = ' + _db(Room) + ') '+chr(10);
      s := format(select_getLocationFromRoom , [_db(Room)]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        result := Rset.fieldbyname('Location').asString;
      end;
    finally
      freeandnil(Rset);
    end;
  end;

function Td.getFloorFromRoom(Room : string) : integer;
  var
    Rset : TRoomerDataSet;
    s : string;
  begin
    result := 0;
    Rset := CreateNewDataSet;
    try
//      s := s + ' SELECT '+chr(10);
//      s := s + '     Rooms.Floor '+chr(10);
//      s := s + ' FROM '+chr(10);
//      s := s + '   Rooms '+chr(10);
//      s := s + ' WHERE '+chr(10);
//      s := s + '   (Room = ' + _db(Room) + ') '+chr(10);
      s := format(select_getFloorFromRoom , [_db(Room)]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        result := Rset.fieldbyname('Floor').asInteger;
      end;
    finally
      freeandnil(Rset);
    end;
  end;

function Td.getinStatisticsFromRoom(Room : string) : boolean;
  var
    Rset : TRoomerDataSet;
    s : string;
  begin
    result := false;

    Rset := CreateNewDataSet;
    try
//      s := s + ' SELECT '+chr(10);
//      s := s + '     Rooms.[Statistics] '+chr(10);
//      s := s + ' FROM '+chr(10);
//      s := s + '   Rooms '+chr(10);
//      s := s + ' WHERE '+chr(10);
//      s := s + '   (Room = ' + _db(Room) + ') '+chr(10);
      s := format(select_getinStatisticsFromRoom , [_db(Room)]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        result := Rset['Statistics'];
      end;
    finally
      freeandnil(Rset);
    end;
  end;

  function Td.ChangeCountry(newCountry : string; reservation, RoomReservation, Person, Medhod : integer) : boolean;
  var
    s : string;
  begin
    result := false;

    if Medhod = 0 then
    begin
      if Person < 1 then
        exit;
      result := true;
      s := '';
      s := s + ' UPDATE persons '+chr(10);
      s := s + ' Set Country=' + _db(newCountry) + ' '+chr(10);
      s := s + ' WHERE (Person = ' + inttostr(Person) + ') '+chr(10);
      if not cmd_bySQL(s) then
      begin
        result := false;
      end;
    end;

    if Medhod = 1 then
    begin
      if RoomReservation < 1 then
        exit;
      result := true;
      s := '';
      s := s + ' UPDATE persons '+chr(10);
      s := s + ' Set Country=' + _db(newCountry) + ' '+chr(10);
      s := s + ' WHERE (RoomReservation = ' + inttostr(RoomReservation) + ') '+chr(10);
      if not cmd_bySQL(s) then
      begin
        result := false;
      end;
    end;

    if Medhod = 2 then
    begin
      if reservation < 1 then
        exit;
      result := true;
      s := '';
      s := s + ' UPDATE persons '+chr(10);
      s := s + ' Set Country=' + _db(newCountry) + ' '+chr(10);
      s := s + ' WHERE (Reservation = ' + inttostr(reservation) + ') '+chr(10);
      if not cmd_bySQL(s) then
      begin
        result := false;
      end;

      s := '';
      s := s + ' UPDATE reservations '+chr(10);
      s := s + ' Set Country=' + _db(newCountry) + ' '+chr(10);
      s := s + ' WHERE (Reservation = ' + inttostr(reservation) + ') '+chr(10);
      if not cmd_bySQL(s) then
      begin
        result := false;
      end;
    end;
  end;


function Td.reservationCount(reservation : integer) : integer;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    s := format(select_reservationCount , [reservation]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      result := rSet.RecordCount;
    end;
  finally
    freeandNil(rSet);
  end;
//  s := s + 'SELECT Reservation '+chr(10);
//  s := s + 'FROM Reservations  '+chr(10);
//  s := s + 'WHERE  '+chr(10);
//  s := s + '(Reservation =' + inttostr(reservation) + ') '+chr(10);
end;


  function Td.getCountryCode(aText : string) : string;
  begin
    result := '00';
    aText := trim(aText);
    if length(aText)=2 then
    begin
      if glb.Countries.Locate('country',atext,[loCaseInsensitive]) then
      begin
        result := glb.Countries.FieldByName('Country').AsString;
      end;
    end else
    begin
      if glb.Countries.Locate('CountryName',atext,[loCaseInsensitive]) then
      begin
        result := glb.Countries.FieldByName('Country').AsString;
      end else
      if glb.Countries.Locate('IslCountryName',atext,[loCaseInsensitive]) then
      begin
        result := glb.Countries.FieldByName('Country').AsString;
      end;
    end;
  end;


function Td.isKredit(InvoiceNumber : integer) : boolean;
  var
    Rset : TRoomerDataSet;
    s : string;
  begin
    result := false;
    Rset := CreateNewDataSet;
    try
//      s := s + ' SELECT ';
//      s := s + '   SplitNumber '+chr(10);
//      s := s + ' FROM InvoiceHeads '+chr(10);
//      s := s + ' WHERE InvoiceNumber = ' + inttostr(InvoiceNumber) + ' '+chr(10);
      s := format(select_isKredit , [InvoiceNumber]);
      if hData.rSet_bySQL(rSet,s) then
	    begin
        result := Rset.fieldbyname('SplitNumber').asInteger = 1;
      end;
    finally
      freeandnil(Rset);
    end;
  end;


{ **
    Vinnslur vegna tengingar við stólpa
    ** }




  procedure Td.exportToSnertaTextRec(silent : boolean);
  var

    s : string;
    counter : integer;
    sCode : string;
    sDescription : string;
    sCount : string;
    sPrice : string;
    sAmount : string;
    sAmountWoVat : string;
    sVatCode : string;
    sfoAmount : string;
    sfoAmountWoVat : string;
    sfoVatAmount : string;

    sCurrency : string;
    sCurrencyRate : string;

    sInvoiceNumber : string;

    sCustomer : string;
    sCustomerName : string;
    sAddress1 : string;
    sAddress2 : string;
    sAddress3 : string;
    sAddress4 : string;
    sCountry : string;
    sPersonalId : string;
    sGuestName : string;
    sBreakfast : string;
    sExtraText : string;
    sInvoiceDate : string;
    sPayDate : string;

    sStaff : string;

    sLocalCurrency : string;

    sReservation : string;
    sRoomReservation : string;
    sRoomNumber : string;

    sTotal : string;
    sTotalwoVAT : string;
    sTotalVAT : string;

    sTotalBreakfast : string;
    sCreditInvoice : string;
    sOrginalInvoice : string;
    sTotalPayments : string;
    sAccountKey : string;

    sfoTotal : string;
    sfoTotalwoVAT : string;
    sfoTotalVAT : string;

    sPaidWith : string;
    sDatePaid : string;
    sPaidAmount : string;

    sKredit : string;

    sTmp : string;
    iTmp : integer;
    fTmp, fTmp2 : double;
    dTmp : TdateTime;

    dDate : Tdate;

    sCompanyName : string;
    sCompanyAddress : string;
    sCompanyZip : string;
    sCompanyPId : string;

    sFileName : string;
    sFilePath : string;
    sStaffName : string;
    sStaffPID : string;

    ar : TInvoiceActionRec;

    fPriceWOV : double;
    sPriceWOV : string;

    iVatNumber : integer;
    sVatNumber : string;

    fCurrencyRate : double;

    ok : boolean;

    fVATPR : double;
    sVATPR : string;

    isCurrency : boolean;
    isKredit : boolean;

    doExportInLocalCurrency : boolean;

    iCount  : double;  //-96
    fAmount : double;
    fAmountWoVat : double;
    fPrice : double;

    sMemo : string;

    lstSnerta : tstringList;

    snFileName : string;
    snertaPath : string;

    seppi : char;

    invoiceCurrency : string;
    nativeCurrency : string;

    procedure addLine(lineID, line : string);
    begin
      if trim(line) > '' then
        lstSnerta.Add(lineID + ';' + line);
    end;

  begin

    lstSnerta := tstringList.Create;
    try
      snertaPath := ctrlGetString('snPath');
      snertaPath := _Addslash(snertaPath);
      if not DirectoryExists(snertaPath) then
      begin
		    Showmessage(format(GetTranslatedText('shTx_D_FolderNotFound'), [snertaPath, g.qProgramExePath]));
        snertaPath := g.qProgramExePath;
      end;

      sTmp := ctrlGetString('SnFieldSeparator');
      sTmp := trim(sTmp);
      if length(sTmp) > 0 then
      begin
        seppi := sTmp[1]
      end
      else
      begin
        seppi := ';';
      end;

      nativeCurrency := ctrlGetString('NativeCurrency');

      // If true then always export in localcurrency
      doExportInLocalCurrency := ctrlGetBoolean('xmlDoExportInLocalCurrency');

      iTmp := d.mtHead_.fieldbyname('InvoiceNumber').asInteger;
      sInvoiceNumber := inttostr(iTmp);

      counter := d.ChkFinished(iTmp);

      if not silent then
        if counter > 0 then
        begin
         // if MessageDlg('Það er þegar búið að útlesa reikning ' + sInvoiceNumber + ' ' + inttostr(counter) + ' sinnum ' + chr(10)
         //     + 'Halda áfram með útlestur ??', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
		      if MessageDlg(format(GetTranslatedText('shTx_D_AccountReadContinue'), [sInvoiceNumber, counter]), mtConfirmation, [mbYes, mbNo], 0) = mrNo then
            exit;
        end;

      sReservation := d.mtHead_.fieldbyname('reservation').asString;
      sRoomReservation := d.mtHead_.fieldbyname('RoomReservation').asString;
      sRoomNumber := d.mtHead_.fieldbyname('RoomNumber').asString;

      isKredit := d.mtHead_['isKredit'];
      sLocalCurrency := d.mtHead_.fieldbyname('LocalCurrency').asString;
      sCurrency := d.mtHead_.fieldbyname('Currency').asString;
      fCurrencyRate := LocalFloatValue(d.mtHead_.fieldbyname('CurrencyRate').asString);
      sCurrencyRate := floatTostr(fCurrencyRate);

      invoiceCurrency := sCurrency;

      isCurrency := sLocalCurrency <> sCurrency;

      if doExportInLocalCurrency then
      begin
        isCurrency := false;
      end
      else
      begin

      end;

      sCustomer := d.mtHead_.fieldbyname('Customer').asString;
      sCustomer := trim(UPPERCASE(sCustomer));

      sTmp := d.mtHead_.fieldbyname('staff').asString;
      sStaffName := d.GET_StaffMemberName_byInitials(sTmp);
      sStaffPID := d.GET_StaffMemberPID_byInitials(sTmp); ;

      sCompanyName := d.mtCompany_.fieldbyname('CompanyName').asString;
      sCompanyAddress := d.mtCompany_.fieldbyname('Address1').asString;
      sCompanyZip := d.mtCompany_.fieldbyname('Address2').asString;
      sCompanyPId := d.mtCompany_.fieldbyname('CompanyPID').asString;
      sPersonalId := d.mtHead_.fieldbyname('PersonalId').asString;

      if sPersonalId = '000000-0000' then
      begin
        sCustomer := sCurrency;
      end
      else if sCustomer = '' then
      begin
        sCustomer := sCurrency;
      end
      else if sCustomer = g.qRackCustomer then
      begin
        sCustomer := sCurrency;
      end
      else if not hData.CustomerExist(sCustomer) then
      begin
        sCustomer := sCurrency;
      end;

      sCustomerName := d.mtHead_.fieldbyname('CustomerName').asString;
      sAddress1 := d.mtHead_.fieldbyname('Address1').asString;
      sAddress2 := d.mtHead_.fieldbyname('Address2').asString;
      sAddress3 := d.mtHead_.fieldbyname('Address3').asString;
      sAddress4 := d.mtHead_.fieldbyname('Address4').asString;
      sCountry := d.mtHead_.fieldbyname('Country').asString;

      sGuestName := d.mtHead_.fieldbyname('GuestName').asString;
      sStaff := d.mtHead_.fieldbyname('Staff').asString;

      dTmp := d.mtHead_.fieldbyname('InvoiceDate').asDateTime;
      dDate := trunc(dTmp);

      if isCurrency then
      begin
        fAmount := LocalFloatValue(d.mtHead_.fieldbyname('foTotal').asString)
      end
      else
      begin
        fAmount := LocalFloatValue(d.mtHead_.fieldbyname('Total').asString);
      end;

      if isKredit then
        if fAmount > 0 then
          fAmount := fAmount * - 1;

      sMemo := d.mtHead_.fieldbyname('ExtraText').asString;

      // dagsetning útlesturs og dagsetning reiknings
      datetimetostring(s, 'dd.mm.yyyy hh:nn', now);
      sTmp := '';
      sTmp := sTmp + s;
      datetimetostring(s, 'dd.mm.yyyy', dDate);
      sTmp := sTmp + seppi + s;

      addLine('100', sTmp);

      sTmp := '';
      sTmp := sTmp + sRoomNumber;
      sTmp := sTmp + seppi + sCustomer;
      sTmp := sTmp + seppi + sPersonalId;
      sTmp := sTmp + seppi + sReservation;
      sTmp := sTmp + seppi + sRoomReservation;
      addLine('102', sTmp);

      // Write payments
      d.mtPayments_.First;

      // Write invoiceLines
      d.mtLines_.First;
      while not d.mtLines_.Eof do
      begin
        sCode := d.mtLines_.fieldbyname('Code').asString;

        sVatCode := d.mtLines_.fieldbyname('VatCode').asString;
        fVATPR := d.VATPercentage(sVatCode);
        sVATPR := floatTostr(fVATPR);
        sDescription := d.mtLines_.fieldbyname('Description').asString;
        iCount := d.mtLines_.fieldbyname('Count').asFloat;
        sCount := _floatTostr(iCount,0,2);

        if isCurrency then
        begin
          fAmount := LocalFloatValue(d.mtLines_.fieldbyname('foAmount').asString);
          fAmountWoVat := LocalFloatValue(d.mtLines_.fieldbyname('foAmountWoVat').asString);
          fPrice := LocalFloatValue(d.mtLines_.fieldbyname('foPrice').asString);
        end
        else
        begin
          fAmount := LocalFloatValue(d.mtLines_.fieldbyname('Amount').asString);
          fAmountWoVat := LocalFloatValue(d.mtLines_.fieldbyname('AmountWoVat').asString);
          fPrice := LocalFloatValue(d.mtLines_.fieldbyname('Price').asString);
        end;

        sAmount := floatTostr(fAmount);
        sAmountWoVat := floatTostr(fAmountWoVat);
        sPrice := floatTostr(fPrice);

        sTmp := '';
        sTmp := sTmp + sCode;
        sTmp := sTmp + seppi + sAmount;
        sTmp := sTmp + seppi + sDescription;
        sTmp := sTmp + seppi + sCount;
        sTmp := sTmp + seppi + sVATPR;

        if isCurrency then
        begin
          sTmp := sTmp + seppi + invoiceCurrency;
        end
        else
        begin
          sTmp := sTmp + seppi + nativeCurrency;
        end;
        addLine('103', sTmp);

        d.mtLines_.Next;
      end;

      sTmp := '';
      sTmp := sTmp + invoiceCurrency;
      sTmp := sTmp + seppi + sCurrencyRate;
      addLine('1000', sTmp);

      addLine('2000', sCustomer);
      addLine('2001', sCustomerName);
      addLine('2002', sAddress1);
      addLine('2003', sAddress2);
      addLine('2004', sAddress3);
      addLine('2005', sAddress4);
      addLine('2006', sCountry);
      addLine('2007', sPersonalId);

      addLine('3000', sGuestName);
      addLine('3010', sStaff);

      if lstSnerta.Count > 0 then
      begin
        if fileExists(_Addslash(snertaPath) + sInvoiceNumber + '.txt') then
        begin
          //FINATH aFile.DeleteFiles(_Addslash(snertaPath) + sInvoiceNumber + '.txt')
          try
            SysUtils.DeleteFile(_Addslash(snertaPath) + sInvoiceNumber + '.txt')
          except
             { TODO 5 -oHordur -cConvert to XE3 :  Create exception and log }
          end;

        end;

        snFileName := _Addslash(snertaPath) + sInvoiceNumber + '.sn';
        lstSnerta.SaveToFile(snFileName);
        sFileName := snFileName;
        try
          SysUtils.RenameFile(sFileName, _Addslash(snertaPath) + sInvoiceNumber + '.txt');
        except
          { TODO 5 -oHordur -cConvert to XE3 :  Create exception and log }
        end;
      end;

    finally
      lstSnerta.Free;
    end;

    // Read to InvoiceAction
    ar.reservation := d.mtHead_.fieldbyname('Reservation').asInteger;
    ar.RoomReservation := d.mtHead_.fieldbyname('RoomReservation').asInteger;
    ar.InvoiceNumber := d.mtHead_.fieldbyname('InvoiceNumber').asInteger;
    ar.ActionDate := now;
    ar.ActionID := 3101;
    ar.Action := 'Export To Snertu';
    ar.ActionNote := sFileName;
    ar.Staff := g.qUser;
    d.InsInvoiceAction(ar);

  end;

  // ****************************************************************************
  //
  //
  // ****************************************************************************
  procedure Td.exportToSnertaSimpleXML(silent : boolean);
  var
    Adoc : TNativeXml;
    s : string;
    // counter : integer;
    sDate : string;
    sCode : string;
    sDescription : string;
    sCount : string;
    sPrice : string;
    sAmount : string;
    sAmountWoVat : string;
    sVatAmount : string;
    sVatCode : string;
    sfoPrice : string;
    sfoAmount : string;
    sfoAmountWoVat : string;
    sfoVatAmount : string;

    sCurrency : string;
    sCurrencyRate : string;

    sInvoiceNumber : string;

    sCustomer : string;
    sCustomerName : string;
    sAddress1 : string;
    sAddress2 : string;
    sAddress3 : string;
    sAddress4 : string;
    sCountry : string;
    sPersonalId : string;
    sGuestName : string;
    sBreakfast : string;
    sExtraText : string;

    sInvoiceDate : string;
    sDueDate : string;

    sStaff : string;

    sLocalCurrency : string;

    sReservation : string;
    sRoomReservation : string;
    sRoomNumber : string;

    sTotal : string;
    sTotalwoVAT : string;
    sTotalVAT : string;

    sTotalBreakfast : string;
    sCreditInvoice : string;
    sOrginalInvoice : string;
    sTotalPayments : string;
    sAccountKey : string;

    sfoTotal : string;
    sfoTotalwoVAT : string;
    sfoTotalVAT : string;

    sPaidWith : string;
    sDatePaid : string;
    sPaidAmount : string;

    sKredit : string;

    sTmp : string;
    iTmp : integer;
    fTmp, fTmp2 : double;
    dTmp : TdateTime;

    dInvoiceDate : Tdate;
    dDueDate : Tdate;

    sCompanyName : string;
    sCompanyAddress : string;
    sCompanyZip : string;
    sCompanyPId : string;

    sFileName : string;
    sFilePath : string;
    sStaffName : string;
    sStaffPID : string;

    ar : TInvoiceActionRec;

    fPriceWOV : double;
    sPriceWOV : string;

    iVatNumber : integer;
    sVatNumber : string;

    fCurrencyRate : double;

    ok : boolean;

    fVATPR : double;
    sVATPR : string;

    isCurrency : boolean;
    isKredit : boolean;

    doExportInLocalCurrency : boolean;

    iCount : integer;
    fAmount : double;
    fAmountWoVat : double;
    fPrice : double;

    sMemo : string;

    lstSnerta : tstringList;

    FileName : string;
    snertaPathXML : string;

    seppi : char;

    invoiceCurrency : string;
    nativeCurrency : string;

    nInvoice : TXmlNode;
    nInvoicehead : TXmlNode;

    nInvoicelines : TXmlNode;
    nInvoiceline : TXmlNode;

    nPayments : TXmlNode;
    nPayment : TXmlNode;

    nCustomer : TXmlNode;

    sSalesPerson : string;
    sPayment : string;

    sDateTime : string;
    iOutCounter : integer;
    iInvoiceCounter : integer;
    iLineCounter : integer;
    iPaymentCounter : integer;

    custInfo : recCustomerHolderEX;

    sRefrence : string;
    sSource   : string;

    justLog : boolean;

    hLogData   : recImportLogsHolder;

    iReservation     : integer;
    iRoomReservation : integer;
    iInvoiceNumber : integer;
    realRoomNumber : string;

    sInvoiceRefrence : string;

    sPaymentType : string;

    fLodgingTax       : double;
    iLodgingTaxNights : integer;

    sLodgingTax       : string;
    sLodgingTaxNights : string;


    sIsKredit : string;

  begin
    justLog := false;

    if g.qHomeExportPOSType <> peExportFolder then
    begin
      justLog := true;
    end;

    Adoc := TNativeXml.CreateName('invoices');
    try
      lstSnerta := tstringList.Create;
      try
        snertaPathXML := g.qsnPathXML;
        snertaPathXML := _Addslash(snertaPathXML);

        if not DirectoryExists(snertaPathXML) then
        begin
          snertaPathXML := '';
          justLog := true;
          //Showmessage('Folder ' + snertaPathXML + ' not found ' + chr(10) + ' Export file will be saved to ' + g.qProgramPath);
        end;

        nativeCurrency := ctrlGetString('NativeCurrency');

        // If true then always export in localcurrency
        doExportInLocalCurrency := ctrlGetBoolean('xmlDoExportInLocalCurrency');


        iInvoiceNumber := d.mtHead_.fieldbyname('InvoiceNumber').asInteger;
        sInvoiceNumber := inttostr(iInvoiceNumber);

        iOutCounter := d.ChkFinished(iInvoiceNumber);

        if not silent then
        begin
          if iOutCounter > 0 then
          begin
            //if MessageDlg('Það er þegar búið að útlesa reikning ' + sInvoiceNumber + ' ' + inttostr(iOutCounter) + ' sinnum ' + chr(10)
            //   + 'Halda áfram með útlestur ??', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
		        if MessageDlg(format(GetTranslatedText('shTx_D_AccountReadContinue'), [sInvoiceNumber, iOutCounter]), mtConfirmation, [mbYes, mbNo], 0) = mrNo then
              exit;
          end;
        end;

        iReservation := d.mtHead_.fieldbyname('reservation').asInteger;
        iRoomReservation := d.mtHead_.fieldbyname('RoomReservation').asInteger;
        realRoomNumber := d.mtHead_.fieldbyname('RoomNumber').asString;


        sReservation := d.mtHead_.fieldbyname('reservation').asString;
        sRoomReservation := d.mtHead_.fieldbyname('RoomReservation').asString;
        sRoomNumber := hdata.doConvert('PO-ROOMS',d.mtHead_.fieldbyname('RoomNumber').asString);

        isKredit := d.mtHead_['isKredit'];
        sIsKredit := _db(isKredit);

        sLocalCurrency := d.mtHead_.fieldbyname('LocalCurrency').asString;
        sCurrency := d.mtHead_.fieldbyname('Currency').asString;
        fCurrencyRate := LocalFloatValue(d.mtHead_.fieldbyname('CurrencyRate').asString);
        sCurrencyRate := floatTostr(fCurrencyRate);

        fLodgingTax := LocalFloatValue(d.mtHead_.FieldByName('TotalStayTax').AsString);
        iLodgingTaxNights := d.mtHead_.FieldByName('TotalStayTaxNights').AsInteger;

        sLodgingTax       := floatToStr(fLodgingTax);
        sLodgingTaxNights := intToStr(iLodgingTaxNights);

        invoiceCurrency := sCurrency;

        isCurrency := sLocalCurrency <> sCurrency;
        if doExportInLocalCurrency then
        begin
          isCurrency := false;
        end;

        sCustomer := d.mtHead_.fieldbyname('Customer').asString;
        sCustomer := trim(UPPERCASE(sCustomer));

        sTmp := d.mtHead_.fieldbyname('staff').asString;
        sStaffName := d.GET_StaffMemberName_byInitials(sTmp);
        sStaffPID := d.GET_StaffMemberPID_byInitials(sTmp); ;

        sSalesPerson := sTmp;

        sCompanyName    := d.mtCompany_.fieldbyname('CompanyName').asString;
        sCompanyAddress := d.mtCompany_.fieldbyname('Address1').asString;
        sCompanyZip     := d.mtCompany_.fieldbyname('Address2').asString;
        sCompanyPId     := d.mtCompany_.fieldbyname('CompanyPID').asString;
        sPersonalId     := d.mtHead_.fieldbyname('PersonalId').asString;

        if sPersonalId = '000000-0000' then
        begin
          sCustomer := sCurrency;
        end
        else if sCustomer = '' then
        begin
          sCustomer := sCurrency;
        end
        else if sCustomer = g.qRackCustomer then
        begin
          sCustomer := sCurrency;
        end
        else if not hData.CustomerExist(sCustomer) then
        begin
          sCustomer := sCurrency;
        end;

        sCustomer := hdata.doConvert('PO-CUST',sCustomer);

        sCustomerName := d.mtHead_.fieldbyname('CustomerName').asString;
        sAddress1     := d.mtHead_.fieldbyname('Address1').asString;
        sAddress2     := d.mtHead_.fieldbyname('Address2').asString;
        sAddress3     := d.mtHead_.fieldbyname('Address3').asString;
        sAddress4     := d.mtHead_.fieldbyname('Address4').asString;
        sCountry      := d.mtHead_.fieldbyname('Country').asString;

        sGuestName := d.mtHead_.fieldbyname('GuestName').asString;
        sStaff := d.mtHead_.fieldbyname('Staff').asString;

        dTmp := d.mtHead_.fieldbyname('InvoiceDate').asDateTime;
        dInvoiceDate := trunc(dTmp);
        datetimetostring(s, 'yyyy-mm-dd', dInvoiceDate);
        sInvoiceDate := s;

        dTmp := d.mtHead_.fieldbyname('payDate').asDateTime;
        dDueDate := trunc(dTmp);
        datetimetostring(s, 'yyyy-mm-dd', dDueDate);
        sDueDate := s;

        sMemo := d.mtHead_.fieldbyname('ExtraText').asString;
        sInvoiceRefrence := d.mtHead_.fieldbyname('invRefrence').asString;

        // dagsetning útlesturs og dagsetning reiknings
        datetimetostring(s, 'yyyy-mm-dd hh:nn:ss', now);
        sDateTime := s;

        // Write Head information

       sPaymentType := 'unknown';
       d.mtPayments_.first;
       if not d.mtPayments_.eof then
       begin
         sPaymentType := hdata.doConvert('PO-GRTEG',d.mtPayments_.fieldbyname('Code').asString);
       end;


        nInvoice := Adoc.Root.NodeNew('invoice');
        with nInvoice do
        begin
          AttributeAdd(UTF8String('hotelcode'), UTF8String(g.qHotelCode));
          AttributeAdd(UTF8String('invoicenumber'), UTF8String(sInvoiceNumber));
          AttributeAdd(UTF8String('staff'), UTF8String(sStaff));
          AttributeAdd(UTF8String('exportdatetime'), UTF8String(sDateTime));
          AttributeAdd(UTF8String('paymenttype'), UTF8String(sPaymentType));
          AttributeAdd(UTF8String('kedit'), UTF8String(sIsKredit));
        end;

        nInvoicehead := nInvoice.NodeNew('invoicehead');
        with nInvoicehead do
        begin
          AttributeAdd(UTF8String('invoicenumber'), UTF8String(sInvoiceNumber));
          writestring(UTF8String('invoicedate'), UTF8String(sInvoiceDate));
          writestring(UTF8String('duedate'), UTF8String(sDueDate));
          writestring(UTF8String('reservation'), UTF8String(sReservation), UTF8String('0'));
          writestring(UTF8String('roomreservation'), UTF8String(sRoomReservation), UTF8String('0'));
          writestring(UTF8String('roomnumber'), UTF8String(sRoomNumber), UTF8String('0'));
          writestring(UTF8String('orderreference'), UTF8String(sInvoiceRefrence), UTF8String(''));

          writestring(UTF8String('headernotes'), UTF8String(sMemo));

          writestring(UTF8String('salesperson'), UTF8String(sSalesPerson), UTF8String('-1'));
          writestring(UTF8String('customer'), UTF8String(sCustomer), UTF8String('-1'));
          writestring(UTF8String('personalid'), UTF8String(sPersonalId), UTF8String(''));
          writestring(UTF8String('currency'), UTF8String(invoiceCurrency), UTF8String('ISK'));
          writestring(UTF8String('CurrencyRate'), UTF8String(sCurrencyRate), UTF8String('1'));

          writestring(UTF8String('customername'), UTF8String(sCustomerName), UTF8String(''));
          writestring(UTF8String('address1'), UTF8String(sAddress1), UTF8String(''));
          writestring(UTF8String('address2'), UTF8String(sAddress2), UTF8String(''));
          writestring(UTF8String('address3'), UTF8String(sAddress3), UTF8String(''));
          writestring(UTF8String('address4'), UTF8String(sAddress4), UTF8String(''));
          writestring(UTF8String('guestname'), UTF8String(sGuestName), UTF8String(''));
          writestring(UTF8String('lodgingtax'), UTF8String(sLodgingTax), UTF8String('0'));
          writestring(UTF8String('lodgingtax_nights'), UTF8String(sLodgingTaxNights), UTF8String('0'));
        end;

        nInvoicelines := nInvoice.NodeNew('invoicelines');
        nInvoicelines.AttributeAdd(UTF8String('invoicenumber'), UTF8String(sInvoiceNumber));
        // Write invoiceLines
        iLineCounter := 0;
        d.mtLines_.First;
        while not d.mtLines_.Eof do
        begin
          inc(iLineCounter);
          sCode := d.mtLines_.fieldbyname('Code').asString;

          sVatCode := d.mtLines_.fieldbyname('VatCode').asString;
          fVATPR := d.VATPercentage(sVatCode);
          sVATPR := floatTostr(fVATPR);
          sDescription := d.mtLines_.fieldbyname('Description').asString;
          iCount := d.mtLines_.fieldbyname('Count').asInteger;
          sCount := inttostr(iCount);

          if isCurrency then
          begin
            fAmount := LocalFloatValue(d.mtLines_.fieldbyname('foAmount').asString);
            fAmountWoVat := LocalFloatValue(d.mtLines_.fieldbyname('foAmountWoVat').asString);
            fPrice := LocalFloatValue(d.mtLines_.fieldbyname('foPrice').asString);
          end
          else
          begin
            fAmount := LocalFloatValue(d.mtLines_.fieldbyname('Amount').asString);
            fAmountWoVat := LocalFloatValue(d.mtLines_.fieldbyname('AmountWoVat').asString);
            fPrice := LocalFloatValue(d.mtLines_.fieldbyname('Price').asString);
          end;

          sAmount := floatTostr(fAmount);
          sAmountWoVat := floatTostr(fAmountWoVat);
          sPrice := floatTostr(fPrice);

          sRefrence := d.mtLines_.fieldbyname('importRefrence').asString;
          sSource   := d.mtLines_.fieldbyname('importSource').asString;

          nInvoiceline := nInvoicelines.NodeNew('invoiceline');
          with nInvoiceline do
          begin
            AttributeAdd(UTF8String('line'), UTF8String(inttostr(iLineCounter)));
            writestring(UTF8String('unitprice'), UTF8String(sPrice), UTF8String('0'));
            writestring(UTF8String('quantity'), UTF8String(sCount), UTF8String('0'));
            writestring(UTF8String('itemcode'), UTF8String(sCode), UTF8String(''));
            writestring(UTF8String('itemdescription'), UTF8String(sDescription), UTF8String(''));
            writestring(UTF8String('vatcode'), UTF8String(sVatCode), UTF8String(''));
            writestring(UTF8String('vatpr'), UTF8String(sVATPR), UTF8String(''));
            writestring(UTF8String('amount'), UTF8String(sAmount), UTF8String('0'));
            writestring(UTF8String('amountwovat'), UTF8String(sAmountWoVat), UTF8String('0'));
            writestring(UTF8String('importrefrence'), UTF8String(sRefrence), UTF8String('0'));
            writestring(UTF8String('importsource'), UTF8String(sSource), UTF8String('0'));
          end;

          d.mtLines_.Next;
        end;

        nPayments := nInvoice.NodeNew('payments');
        nPayments.AttributeAdd(UTF8String('invoicenumber'), UTF8String(sInvoiceNumber));

        // Write payments
        iPaymentCounter := 0;
        d.mtPayments_.First;
        while not d.mtPayments_.Eof do
        begin
          inc(iPaymentCounter);

          if isCurrency then
          begin
            fTmp := LocalFloatValue(d.mtPayments_.fieldbyname('foAmount').asString)
          end
          else
          begin
            fTmp := LocalFloatValue(d.mtPayments_.fieldbyname('Amount').asString);
          end;

          sPayment := floatTostr(fTmp);
          sCode := hdata.doConvert('PO-GRTEG',d.mtPayments_.fieldbyname('Code').asString);

          nPayment := nPayments.NodeNew('paymentline');
          with nPayment do
          begin
            AttributeAdd(UTF8String('id'), UTF8String(inttostr(iPaymentCounter)));
            writestring(UTF8String('paymentcode'), UTF8String(sCode), UTF8String('0'));
            writestring(UTF8String('amount'), UTF8String(sPayment), UTF8String('0'));
          end;
          d.mtPayments_.Next;
        end;

        custInfo := hData.Customer_getHolder(sCustomer);
        if custInfo.customer > '' then
        begin
          nCustomer := nInvoice.NodeNew('customer');
          with nCustomer do
          begin
            AttributeAdd(UTF8String('invoicenumber'), UTF8String(sInvoiceNumber));
            writestring(UTF8String('customer'), UTF8String(custInfo.customer));
            writestring(UTF8String('pid'), UTF8String(custInfo.PID));
            writestring(UTF8String('name'), UTF8String(custInfo.CustomerName));
            writestring(UTF8String('address1'), UTF8String(custInfo.Address1));
            writestring(UTF8String('address2'), UTF8String(custInfo.Address2));
            writestring(UTF8String('address3'), UTF8String(custInfo.Address3));
            writestring(UTF8String('address4'), UTF8String(custInfo.Address4));
            writestring(UTF8String('tel1'), UTF8String(custInfo.Tel1));
            writestring(UTF8String('tel2'), UTF8String(custInfo.Tel2));
            writestring(UTF8String('fax'), UTF8String(custInfo.Fax));
            writestring(UTF8String('emailaddress'), UTF8String(custInfo.EmailAddress));
            writestring(UTF8String('contactperson'), UTF8String(custInfo.ContactPerson));
          end;
        end;


        if justlog then
        begin
          s := '';
          s := s+' INSERT INTO tblpoxexport '+chr(10);
          s := s+'  ( '+chr(10);
          s := s+'   InvoiceNumber '+chr(10);
          s := s+'  ,Reservation '+chr(10);
          s := s+'  ,RoomReservation '+chr(10);
          s := s+'  ,InsertDate '+chr(10);
          s := s+'  ) '+chr(10);
          s := s+' VALUES '+chr(10);
          s := s+'  ( '+chr(10);
          s := s+'   '+_db(iInvoiceNumber)+' '+chr(10);
          s := s+'  ,'+_db(iReservation)+' '+chr(10);
          s := s+'  ,'+_db(iRoomReservation)+' '+chr(10);
          s := s+'  ,'+_db(now)+' '+chr(10);
          s := s+'  )'+chr(10);

          if not cmd_bySQL(s) then
          begin
          end;
        end else
        begin
          FileName := _Addslash(snertaPathXML) + sInvoiceNumber + '.xml';

          if fileExists(Filename) then
          begin
            try
              SysUtils.DeleteFile(FileName)
            Except
              { TODO 5 -oHordur -cConvert to XE3 :  Create exception and log }
            end;
          end;



          Adoc.XmlFormat := xfReadable;

          try
            //ATHFIN XE  Adoc.EncodingString := ctrlGetString('snXMLencoding');
            Adoc.Charset := UTF8String(ctrlGetString('snXMLencoding'));
          except
          end;

          try
            Adoc.SaveToFile(FileName);
          except
          end;
        end;

      finally
        lstSnerta.Free;
      end;
    finally
      Adoc.Free;
    end;

    // Read to InvoiceAction
    ar.reservation := d.mtHead_.fieldbyname('Reservation').asInteger;
    ar.RoomReservation := d.mtHead_.fieldbyname('RoomReservation').asInteger;
    ar.InvoiceNumber := d.mtHead_.fieldbyname('InvoiceNumber').asInteger;
    ar.ActionDate := now;
    ar.ActionID := 3110;
    ar.Action := 'XML Export To Snertu';
    ar.ActionNote := FileName;
    ar.Staff := g.qUser;
    d.InsInvoiceAction(ar);
  end;


  procedure Td.InsertMTdata(InvoiceNumber : integer; doExport, silent : boolean; ShowPackage : boolean);
  var
    i,ii : integer;
    s : string;
    IvI : TInvoiceInfo;
    Rate : double;

    copyText : string;
    sTmp : string;

    isForeign : boolean;
    sCurrency : string;

    okExport : boolean; // vegna paymenttype



   PaymentData : recPaymentHolder;
   invoiceData : recInvoiceHeadHolder;

   tmpLineNo         : integer;
   tmpDate           : TdateTime;
   tmpCode           : string;
   tmpDescription    : string;
   tmpVatCode        : string;
   tmpAccountKey     : string;
   tmpimportSource   : string;
   tmpimportRefrence : string;


   tmpCount          : double;
   tmpPrice          : double;

   tmpAmount         : double;
   tmpAmountWoVat    : double;
   tmpVatAmount      : double;
   tmpfoPrice        : double;
   tmpfoAmount       : double;
   tmpfoAmountWoVat  : double;
   tmpfoVatAmount    : double;

   pckTotalsList : TRoomPackageLineEntryList;

  begin
    initPaymentHolderRec(PaymentData);
    initInvoiceHeadHolderRec(invoiceData);
    pckTotalsList := TRoomPackageLineEntryList.Create(True);
    try
      IvI := TInvoiceInfo.Create(InvoiceNumber,paymentData,invoiceData);
      try
        IvI.UpdateInfo(invoicedata);
        IvI.GatherPayments(okExport,paymentData,invoiceData);


        sCurrency := IvI.Currency;

        isForeign := false;
        if _trimlower(ctrlGetString('NativeCurrency')) <> _trimlower(sCurrency) then
        begin
          isForeign := true;
        end;

        copyText := _islErl(IvI.ivhPrintText,isForeign);


        if IvI.KreditType = ktKredit then
        begin
          IvI.ivhTotal := IvI.ivhTotal * - 1;
          IvI.ivhTotal_woVat := IvI.ivhTotal_woVat * - 1;
          IvI.ivhTotal_VAT := IvI.ivhTotal_VAT * - 1;
          IvI.ivhTotal_Currency := IvI.ivhTotal_Currency * - 1;
          IvI.ivhTotalBreakFast := IvI.ivhTotalBreakFast * - 1;

          for i := 0 to IvI.lineCount - 1 do
          begin
            IvI.LinesList[i].Price := IvI.LinesList[i].Price * - 1;
            IvI.LinesList[i].TotalPrice := IvI.LinesList[i].TotalPrice * - 1;
          end;

          for i := 0 to IvI.paymentCount - 1 do
          begin
            IvI.PaymentList[i].pmAmount := IvI.PaymentList[i].pmAmount * - 1;
          end;

          for i := 0 to IvI.VATcount - 1 do
          begin
            IvI.VATList[i].Price_woVAT := IvI.VATList[i].Price_woVAT * - 1;
            IvI.VATList[i].Price_wVAT := IvI.VATList[i].Price_wVAT * - 1;
            IvI.VATList[i].VATAmount := IvI.VATList[i].VATAmount * - 1;
          end;
        end;

        if d.mtHead_.active then
          d.mtHead_.close;
        d.mtHead_.open;
        d.mtHead_.INSERT;
        d.mtHead_.ClearFields;

        Rate := IvI.CurrencyRate;
        if Rate = 0 then
          Rate := 1;

        d.mtHead_.fieldbyname('Customer').asString := IvI.CustomerInfo.IvCustomer;
        d.mtHead_.fieldbyname('InvoiceNumber').asInteger := IvI.InvoiceNumber;
        d.mtHead_.fieldbyname('InvoiceDate').asDateTime := IvI.ivhDate;
        d.mtHead_.fieldbyname('payDate').asDateTime := IvI.ivhPayDate;
        d.mtHead_.fieldbyname('Staff').asString := IvI.ivhStaff;
        d.mtHead_.fieldbyname('CustomerName').asString := IvI.CustomerInfo.IvName;
        d.mtHead_.fieldbyname('Address1').asString := IvI.CustomerInfo.IvAddress1;
        d.mtHead_.fieldbyname('Address2').asString := IvI.CustomerInfo.IvAddress2;
        d.mtHead_.fieldbyname('Address3').asString := IvI.CustomerInfo.IvAddress3;
        d.mtHead_.fieldbyname('Address4').asString := IvI.CustomerInfo.IvAddress4;
        d.mtHead_.fieldbyname('Country').asString := IvI.CustomerInfo.IvCountry;
        d.mtHead_.fieldbyname('PersonalId').asString := IvI.CustomerInfo.IvPid;
        d.mtHead_.fieldbyname('GuestName').asString := IvI.CustomerInfo.IvRoomGuest;

        d.mtHead_.fieldbyname('invRefrence').asString := IvI.ivhRefrence;

        d.mtHead_.fieldbyname('Breakfast').asfloat := IvI.ivhTotalBreakFast;
        d.mtHead_.fieldbyname('ExtraText').asString := IvI.ivhExtraText;
        d.mtHead_.fieldbyname('CurrencyRate').asfloat := IvI.CurrencyRate;
        d.mtHead_.fieldbyname('Currency').asString := IvI.Currency;
        d.mtHead_.fieldbyname('LocalCurrency').asString := IvI.LocalCurrency;

        d.mtHead_.fieldbyname('Reservation').asInteger := IvI.ivhReservation;
        d.mtHead_.fieldbyname('RoomReservation').asInteger := IvI.ivhRoomReservation;
        d.mtHead_.fieldbyname('RoomNumber').asString := IvI.ivhRoomNumber;
        d.mtHead_.fieldbyname('Total').asfloat := IvI.ivhTotal;
        d.mtHead_.fieldbyname('TotalwoVAT').asfloat := IvI.ivhTotal_woVat;
        d.mtHead_.fieldbyname('TotalVAT').asfloat := IvI.ivhTotal_VAT;

        d.mtHead_.fieldbyname('TotalBreakfast').asfloat := IvI.ivhTotalBreakFast;
        d.mtHead_.fieldbyname('CreditInvoice').asInteger := IvI.ivhCreditInvoice;
        d.mtHead_.fieldbyname('OrginalInvoice').asInteger := IvI.ivhOriginalInvoice;
        d.mtHead_.fieldbyname('TotalPayments').asfloat := IvI.TotalPayments;

        d.mtHead_.fieldbyname('PrePaid').asfloat := IvI.ivhTotal_prePaid;
        d.mtHead_.fieldbyname('Balance').asfloat := IvI.ivhTotal_balance;
        d.mtHead_.fieldbyname('foPrePaid').asfloat := IvI.ivhTotal_prePaid / Rate;
        d.mtHead_.fieldbyname('foBalance').asfloat := IvI.ivhTotal_balance / Rate;

        d.mtHead_.fieldbyname('foTotal').asfloat := IvI.ivhTotal / Rate;
        d.mtHead_.fieldbyname('foTotalwoVAT').asfloat := IvI.ivhTotal_woVat / Rate;
        d.mtHead_.fieldbyname('foTotalVAT').asfloat := IvI.ivhTotal_VAT / Rate;

        d.mtHead_.fieldbyname('isKredit').AsBoolean := IvI.KreditType = ktKredit;

        d.mtHead_.fieldbyname('invPrintText').AsString := _islErl(IvI.ivhPrintText, isForeign);

        d.mtHead_.fieldbyname('TotalStayTax').asfloat := IvI.ivhTotalStayTax;
        d.mtHead_.fieldbyname('TotalStayTaxNights').asInteger := IvI.ivhTotalStayTaxNights;

        d.mtHead_.fieldbyname('Package').AsString := ivi.ivhPackage;

        d.mtHead_.fieldbyname('PackageName').AsString := ivi.ivhPackageName;
        d.mtHead_.fieldbyname('ShowPackage').AsBoolean := ShowPackage;
        d.mtHead_.fieldbyname('Location').AsString := ivi.ivhLocation;

        s := '';
        for i := 0 to IvI.paymentCount - 1 do
        begin
          s := s + IvI.PaymentList[i].pmCode + ': ' + trim(_floatToStr(IvI.PaymentList[i].pmAmount, 18, 2)) + '  /  ';
        end;
        d.mtHead_.fieldbyname('PaymentLine').asString := s;

        s := '';
        for i := 0 to IvI.paymentCount - 1 do
        begin
          s := s + IvI.PaymentList[i].pmCode + ': ' + trim(_floatToStr(IvI.PaymentList[i].pmAmount / Rate, 18, 2)) + '  /  ';
        end;
        d.mtHead_.fieldbyname('foPaymentLine').asString := s;

        d.mtHead_.Post;

        if d.mtLines_.active then
          d.mtLines_.close;
        d.mtLines_.open;

         tmpCode           := ''  ;
         tmpDescription    := ''  ;
         tmpVatCode        := ''  ;
         tmpAccountKey     := ''  ;
         tmpimportSource   := ''  ;
         tmpimportRefrence := ''  ;

         tmpfoPrice        := 0.00;

         ii := 0;

        d.mtLines_.INSERT;
        d.mtLines_.ClearFields;
        for i := 0 to IvI.lineCount - 1 do
        begin

          if (IvI.LinesList[i].isPackage) and Showpackage then
          begin
            inc(ii);


            AddOrCreateToPackage(pckTotalsList
                               , IvI.LinesList[i].code
                               , IvI.LinesList[i].Description
                               , Ivi.LinesList[i].roomreservationAlias
                               , IvI.LinesList[i].TotalPrice
                               , IvI.LinesList[i].TotalWoVat
                               , IvI.LinesList[i].VatAmount
                               , IvI.LinesList[i].code = g.qRoomRentItem
                               , IvI.LinesList[i].importSource
                               , IvI.LinesList[i].ImportRefrence
                               , IvI.LinesList[i].LineNo
                               , IvI.LinesList[i].Date
                               , IvI.LinesList[i].Count
                              );

          end else
          begin
            d.mtLines_.INSERT;
            d.mtLines_.fieldbyname('lineNo').asInteger := IvI.LinesList[i].LineNo;
            d.mtLines_.fieldbyname('Date').asDateTime := IvI.LinesList[i].Date;
            d.mtLines_.fieldbyname('Code').asString := IvI.LinesList[i].code;
            d.mtLines_.fieldbyname('Description').asString := IvI.LinesList[i].Description;
            d.mtLines_.fieldbyname('Count').asFloat := IvI.LinesList[i].Count; //-96
            d.mtLines_.fieldbyname('Price').asfloat := IvI.LinesList[i].Price;

            d.mtLines_.fieldbyname('Amount').asfloat := IvI.LinesList[i].TotalPrice;
            d.mtLines_.fieldbyname('AmountWoVat').asfloat := IvI.LinesList[i].TotalWOVat;
            d.mtLines_.fieldbyname('VatAmount').asfloat := IvI.LinesList[i].VATAmount;

            d.mtLines_.fieldbyname('VatCode').asString := IvI.LinesList[i].VATCode;
            d.mtLines_.fieldbyname('AccountKey').asString := IvI.LinesList[i].AccountKey;
            d.mtLines_.fieldbyname('importSource').asString := IvI.LinesList[i].ImportSource;
            d.mtLines_.fieldbyname('importRefrence').asString := IvI.LinesList[i].ImportRefrence;

            d.mtLines_.fieldbyname('foPrice').asfloat := IvI.LinesList[i].Price / Rate;
            d.mtLines_.fieldbyname('foAmount').asfloat := IvI.LinesList[i].TotalPrice / Rate;
            d.mtLines_.fieldbyname('foAmountWoVat').asfloat := IvI.LinesList[i].TotalWOVat / Rate;
            d.mtLines_.fieldbyname('foVatAmount').asfloat := IvI.LinesList[i].VATAmount / Rate;
            d.mtLines_.Post;
          end;
        end;



        if ii > 0 then
        begin

          for ii := 0 to pckTotalsList.count-1 do
          begin
          //  showmessage(inttostr(pckTotalsList[ii].RoomReservation)+'   '+pckTotalsList[ii].code+'   '+floattostr(pckTotalsList[ii].Amount));



            // tmpCode           := ivi.ivhPackage;
            // tmpDescription    := ivi.IvhPackageText; // ivhPackageName;
            // if tmpCount <> 0 then tmpPrice := tmpAmount/tmpCount;
            // tmpfoPrice        := tmpPrice/rate;
            // tmpfoAmount       := tmpAmount/rate;
            // tmpfoAmountWoVat  := tmpAmountWoVat/rate;
            // tmpfoVatAmount    := tmpfoVatAmount/rate;

             tmpPrice := 0;
             if pckTotalsList[ii].itemcount <> 0 then
             begin
               tmpPrice  :=   pckTotalsList[ii].Amount / pckTotalsList[ii].itemCount;
               tmpfoPrice := tmpPrice/rate;
             end;

             tmpfoAmount       := pckTotalsList[ii].Amount/rate;
             tmpfoAmountWoVat  := pckTotalsList[ii].AmountWoVat/rate;
             tmpfoVatAmount    := pckTotalsList[ii].VatAmount  /rate;




          d.mtLines_.INSERT;
          d.mtLines_.fieldbyname('lineNo').asInteger     := pckTotalsList[ii].lineNo;
          d.mtLines_.fieldbyname('Date').asDateTime      := pckTotalsList[ii].aDate;
          d.mtLines_.fieldbyname('Code').asString        := pckTotalsList[ii].packageCode;
          d.mtLines_.fieldbyname('Description').asString := pckTotalsList[ii].Description;
          d.mtLines_.fieldbyname('Count').asFloat        := pckTotalsList[ii].ItemCount;
          d.mtLines_.fieldbyname('Price').asfloat        := tmpPrice;

          d.mtLines_.fieldbyname('Amount').asfloat       := pckTotalsList[ii].Amount     ;
          d.mtLines_.fieldbyname('AmountWoVat').asfloat  := pckTotalsList[ii].AmountWoVat;
          d.mtLines_.fieldbyname('VatAmount').asfloat    := pckTotalsList[ii].VatAmount  ;

          d.mtLines_.fieldbyname('VatCode').asString        := tmpVATCode;
          d.mtLines_.fieldbyname('AccountKey').asString     := tmpAccountKey;
          d.mtLines_.fieldbyname('importSource').asString   := tmpImportSource;
          d.mtLines_.fieldbyname('importRefrence').asString := tmpImportRefrence;

          d.mtLines_.fieldbyname('foPrice').asfloat       := tmpfoPrice      ;
          d.mtLines_.fieldbyname('foAmount').asfloat      := tmpfoAmount     ;
          d.mtLines_.fieldbyname('foAmountWoVat').asfloat := tmpfoAmountWoVat;
          d.mtLines_.fieldbyname('foVatAmount').asfloat   := tmpfoVatAmount  ;
          d.mtLines_.Post;
          end;
        end;



        d.mtLines_.SortOn('lineNo', []);

        if d.mtPayments_.active then
          d.mtPayments_.close;
        d.mtPayments_.open;
        d.mtPayments_.INSERT;
        d.mtPayments_.ClearFields;
        for i := 0 to IvI.paymentCount - 1 do
        begin
          d.mtPayments_.INSERT;
          d.mtPayments_.fieldbyname('Date').asDateTime := IvI.PaymentList[i].pmDate;
          d.mtPayments_.fieldbyname('Code').asString := IvI.PaymentList[i].pmCode;
          d.mtPayments_.fieldbyname('Amount').asfloat := IvI.PaymentList[i].pmAmount;
          d.mtPayments_.fieldbyname('foAmount').asfloat := IvI.PaymentList[i].pmAmount / Rate;
          d.mtPayments_.fieldbyname('Description').asString := IvI.PaymentList[i].pmDescription;
          d.mtPayments_.fieldbyname('TypeIndex').asInteger := IvI.PaymentList[i].pmTypeIndex;

          d.mtPayments_.Post
        end;
        // d.mtLines_.SortOn('lineNo',[]);

        if d.mtVAT_.active then
          d.mtVAT_.close;
        d.mtVAT_.open;
        d.mtVAT_.INSERT;
        d.mtVAT_.ClearFields;
        for i := 0 to IvI.VATcount - 1 do
        begin
          d.mtVAT_.INSERT;
          d.mtVAT_.fieldbyname('Code').asString := IvI.VATList[i].VATCode;
          d.mtVAT_.fieldbyname('Description').asString := IvI.VATList[i].VATDescription;
          d.mtVAT_.fieldbyname('Price_woVAT').asfloat := IvI.VATList[i].Price_woVAT;
          d.mtVAT_.fieldbyname('Price_wVAT').asfloat := IvI.VATList[i].Price_wVAT;
          d.mtVAT_.fieldbyname('VATAmount').asfloat := IvI.VATList[i].VATAmount;

          d.mtVAT_.fieldbyname('foPrice_woVAT').asfloat := IvI.VATList[i].Price_woVAT / Rate;
          d.mtVAT_.fieldbyname('foPrice_wVAT').asfloat := IvI.VATList[i].Price_wVAT / Rate;
          d.mtVAT_.fieldbyname('foVATAmount').asfloat := IvI.VATList[i].VATAmount / Rate;

          d.mtVAT_.fieldbyname('VATPercentage').asfloat := IvI.VATList[i].VATPercentage;
          d.mtVAT_.Post
        end;

        if d.mtCompany_.active then
          d.mtCompany_.close;
        d.mtCompany_.open;
        d.mtCompany_.INSERT;
        d.mtCompany_.ClearFields;

        d.mtCompany_.fieldbyname('CompanyName').asString := IvI.CompanyName;
        d.mtCompany_.fieldbyname('Address1').asString := IvI.CompanyAddress1;
        d.mtCompany_.fieldbyname('Address2').asString := IvI.CompanyAddress2;
        d.mtCompany_.fieldbyname('Address3').asString := IvI.CompanyAddress3;
        d.mtCompany_.fieldbyname('Address4').asString := IvI.CompanyAddress4;
        d.mtCompany_.fieldbyname('Country').asString := IvI.CompanyCountry;
        d.mtCompany_.fieldbyname('TelePhone1').asString := IvI.CompanyTelePhone1;
        d.mtCompany_.fieldbyname('TelePhone2').asString := IvI.CompanyTelePhone2;
        d.mtCompany_.fieldbyname('Fax').asString := IvI.CompanyFax;
        d.mtCompany_.fieldbyname('Email').asString := IvI.CompanyEmail;
        d.mtCompany_.fieldbyname('HomePage').asString := IvI.CompanyHomePage;
        d.mtCompany_.fieldbyname('CompanyPID').asString := IvI.CompanyPID;
        d.mtCompany_.fieldbyname('CompanyVATno').asString := IvI.CompanyVATno;
        d.mtCompany_.fieldbyname('CompanyBankInfo').asString := IvI.CompanyBankInfo;

        if d.mtCaptions_.active then
          d.mtCaptions_.close;
        d.mtCaptions_.open;
        d.mtCaptions_.INSERT;
        d.mtCaptions_.ClearFields;

        sTmp := '';
        if IvI.InvoiceNumber = PROFORMA_INVOICE_NUMBER then
        begin
          sTmp := ' - ' + copyText;
        end;

        d.mtCaptions_.fieldbyname('invTxtHead').asString := _islErl(IvI.invTxtHeadDebit, isForeign) + sTmp;
        if IvI.KreditType = ktKredit then
        begin
          d.mtCaptions_.fieldbyname('invTxtHead').asString := _islErl(IvI.invTxtHeadKredit, isForeign) + sTmp;
        end;

        d.mtCaptions_.fieldbyname('invTxtHeadInfoNumber').asString := _islErl(IvI.invTxtHeadInfoNumber, isForeign);
        d.mtCaptions_.fieldbyname('invTxtHeadInfoDate').asString := _islErl(IvI.invTxtHeadInfoDate, isForeign);
        d.mtCaptions_.fieldbyname('invTxtHeadInfoCustomerNo').asString := _islErl(IvI.invTxtHeadInfoCustomerNo, isForeign);
        d.mtCaptions_.fieldbyname('invTxtHeadInfoGjalddagi').asString := _islErl(IvI.invTxtHeadInfoGjalddagi, isForeign);
        d.mtCaptions_.fieldbyname('invTxtHeadInfoEindagi').asString := _islErl(IvI.invTxtHeadInfoEindagi, isForeign);
        d.mtCaptions_.fieldbyname('invTxtHeadInfoLocalCurrency').asString := _islErl(IvI.invTxtHeadInfoLocalCurrency, isForeign);
        d.mtCaptions_.fieldbyname('invTxtHeadInfoCurrency').asString := _islErl(IvI.invTxtHeadInfoCurrency, isForeign);
        d.mtCaptions_.fieldbyname('invTxtHeadInfoCurrencyRate').asString := _islErl(IvI.invTxtHeadInfoCurrencyRate, isForeign);
        d.mtCaptions_.fieldbyname('invTxtHeadInfoReservation').asString := _islErl(IvI.invTxtHeadInfoReservation, isForeign);
        d.mtCaptions_.fieldbyname('invTxtHeadInfoCreditInvoice').asString := _islErl(IvI.invTxtHeadInfoCreditInvoice, isForeign);
        d.mtCaptions_.fieldbyname('invTxtHeadInfoOrginalInfo').asString := _islErl(IvI.invTxtHeadInfoOrginalInfo, isForeign);
        d.mtCaptions_.fieldbyname('invTxtHeadInfoGuest').asString := _islErl(IvI.invTxtHeadInfoGuest, isForeign);
        d.mtCaptions_.fieldbyname('invTxtHeadInfoRoom').asString := _islErl(IvI.invTxtHeadInfoRoom, isForeign);
        d.mtCaptions_.fieldbyname('invTxtLinesItemNo').asString := _islErl(IvI.invTxtLinesItemNo, isForeign);
        d.mtCaptions_.fieldbyname('invTxtLinesItemText').asString := _islErl(IvI.invTxtLinesItemText, isForeign);
        d.mtCaptions_.fieldbyname('invTxtLinesItemCount').asString := _islErl(IvI.invTxtLinesItemCount, isForeign);
        d.mtCaptions_.fieldbyname('invTxtLinesItemPrice').asString := _islErl(IvI.invTxtLinesItemPrice, isForeign);
        d.mtCaptions_.fieldbyname('invTxtLinesItemAmount').asString := _islErl(IvI.invTxtLinesItemAmount, isForeign);
        d.mtCaptions_.fieldbyname('invTxtLinesItemTotal').asString := _islErl(IvI.invTxtLinesItemTotal, isForeign);
        d.mtCaptions_.fieldbyname('invTxtExtra1').asString := _islErl(IvI.invTxtExtra1, isForeign);
        d.mtCaptions_.fieldbyname('invTxtExtra2').asString := _islErl(IvI.invTxtExtra2, isForeign);
        d.mtCaptions_.fieldbyname('invTxtFooterLine1').asString := _islErl(IvI.invTxtFooterLine1, isForeign);
        d.mtCaptions_.fieldbyname('invTxtFooterLine2').asString := _islErl(IvI.invTxtFooterLine2, isForeign);
        d.mtCaptions_.fieldbyname('invTxtFooterLine3').asString := _islErl(IvI.invTxtFooterLine3, isForeign);
        d.mtCaptions_.fieldbyname('invTxtFooterLine4').asString := _islErl(IvI.invTxtFooterLine4, isForeign);
        d.mtCaptions_.fieldbyname('invTxtPaymentListHead').asString := _islErl(IvI.invTxtPaymentListHead, isForeign);
        d.mtCaptions_.fieldbyname('invTxtPaymentListCode').asString := _islErl(IvI.invTxtPaymentListCode, isForeign);
        d.mtCaptions_.fieldbyname('invTxtPaymentListAmount').asString := _islErl(IvI.invTxtPaymentListAmount, isForeign);
        d.mtCaptions_.fieldbyname('invTxtPaymentListDate').asString := _islErl(IvI.invTxtPaymentListDate, isForeign);
        d.mtCaptions_.fieldbyname('invTxtPaymentListTotal').asString := _islErl(IvI.invTxtPaymentListTotal, isForeign);
        d.mtCaptions_.fieldbyname('invTxtPaymentLineHead').asString := _islErl(IvI.invTxtPaymentLineHead, isForeign);
        d.mtCaptions_.fieldbyname('invTxtPaymentLineSeperator').asString := _islErl(IvI.invTxtPaymentLineSeperator, isForeign);
        d.mtCaptions_.fieldbyname('invTxtVATListHead').asString := _islErl(IvI.invTxtVATListHead, isForeign);
        d.mtCaptions_.fieldbyname('invTxtVATListDescription').asString := _islErl(IvI.invTxtVATListDescription, isForeign);
        d.mtCaptions_.fieldbyname('invTxtVATListwoVAT').asString := _islErl(IvI.invTxtVATListwoVAT, isForeign);
        d.mtCaptions_.fieldbyname('invTxtVATListwVAT').asString := _islErl(IvI.invTxtVATListwVAT, isForeign);
        d.mtCaptions_.fieldbyname('invTxtVATListVATpr').asString := _islErl(IvI.invTxtVATListVATpr, isForeign);
        d.mtCaptions_.fieldbyname('invTxtVATListVATAmount').asString := _islErl(IvI.invTxtVATListVATAmount, isForeign);
        d.mtCaptions_.fieldbyname('invTxtVATListTotal').asString := _islErl(IvI.invTxtVATListTotal, isForeign);
        d.mtCaptions_.fieldbyname('invTxtVATLineHead').asString := _islErl(IvI.invTxtVATLineHead, isForeign);
        d.mtCaptions_.fieldbyname('invTxtVATLineSeperator').asString := _islErl(IvI.invTxtVATLineSeperator, isForeign);
        d.mtCaptions_.fieldbyname('invTxtTotalwoVAT').asString := _islErl(IvI.invTxtTotalwoVAT, isForeign);
        d.mtCaptions_.fieldbyname('invTxtTotalVATAmount').asString := _islErl(IvI.invTxtTotalVATAmount, isForeign);
        d.mtCaptions_.fieldbyname('invTxtTotalTotal').asString := _islErl(IvI.invTxtTotalTotal, isForeign);
        d.mtCaptions_.fieldbyname('invTxtCompanyName').asString := _islErl(IvI.invTxtCompanyName, isForeign);
        d.mtCaptions_.fieldbyname('invTxtCompanyAddress').asString := _islErl(IvI.invTxtCompanyAddress, isForeign);
        d.mtCaptions_.fieldbyname('invTxtCompanyTel1').asString := _islErl(IvI.invTxtCompanyTel1, isForeign);
        d.mtCaptions_.fieldbyname('invTxtCompanyTel2').asString := _islErl(IvI.invTxtCompanyTel2, isForeign);
        d.mtCaptions_.fieldbyname('invTxtCompanyFax').asString := _islErl(IvI.invTxtCompanyFax, isForeign);
        d.mtCaptions_.fieldbyname('invTxtCompanyEmail').asString := _islErl(IvI.invTxtCompanyEmail, isForeign);
        d.mtCaptions_.fieldbyname('invTxtCompanyHomePage').asString := _islErl(IvI.invTxtCompanyHomePage, isForeign);
        d.mtCaptions_.fieldbyname('invTxtCompanyPID').asString := _islErl(IvI.invTxtCompanyPID, isForeign);
        d.mtCaptions_.fieldbyname('invTxtCompanyBankInfo').asString := _islErl(IvI.invTxtCompanyBankInfo, isForeign);
        d.mtCaptions_.fieldbyname('invTxtCompanyVATId').asString := _islErl(IvI.invTxtCompanyVATId, isForeign);
        d.mtCaptions_.fieldbyname('invTxtTotalStayTax').asString := _islErl(IvI.ivhTxtTotalStayTax, isForeign);
        d.mtCaptions_.fieldbyname('invTxtTotalStayTaxNights').asString := _islErl(IvI.ivhTxtTotalStayTaxNights, isForeign);

        d.mtCaptions_.fieldbyname('invTxtPaymentListDescription').asString := _islErl(IvI.invTxtPaymentListDescription, isForeign);
        d.mtCaptions_.fieldbyname('invTxtHeadPrePaid').asString := _islErl(IvI.invTxtHeadPrePaid, isForeign);
        d.mtCaptions_.fieldbyname('invTxtHeadBalance').asString := _islErl(IvI.invTxtHeadBalance, isForeign);


      finally
        IvI.Free;
      end;
    finally
      freeandnil(pckTotalsList);
    end;

    if (doExport) and (okExport) then
    try
      if ctrlGetBoolean('xmlDoExport') then
      begin


        if ctrlGetInteger('AccountType') = 1 then
        begin
//          Showmessage('Yfirfærsla í Stólpa ');
//          InvoiceToStolpiTilbod(silent);
        end;

        if ctrlGetInteger('AccountType') = 2 then
        begin
//          Showmessage('Export To TouchStore - TextRec');
          exportToSnertaTextRec(silent);
          // exportToSnertaSimpleXML(silent);
        end;

        if ctrlGetInteger('AccountType') = 3 then
        begin
//          Showmessage('Export To TouchStore - XML');
          exportToSnertaSimpleXML(silent);
        end;

      end;
    except
      on E: Exception do
        MessageDLG('Unable to export finance data to POS:' + #13 + E.Message, mtError, [mbOK], 0);
    end;
  end;


  procedure Td.InsertReciptData(PaymentData : recPaymentHolder; invoiceData : recInvoiceHeadHolder);
  var
    i : integer;
    s : string;
    IvI : TInvoiceInfo;
    Rate : double;

    copyText : string;
    sTmp : string;

    isForeign : boolean;
    sCurrency : string;
    doExport : boolean;

  begin
    doExport := false;

    IvI := TInvoiceInfo.Create(-1,paymentdata,invoiceData);
    try
      IvI.UpdateInfo(invoicedata);
      IvI.GatherPayments(doExport,paymentdata,invoiceData);


      sCurrency := IvI.Currency;

      isForeign := false;
      if _trimlower(ctrlGetString('NativeCurrency')) <> _trimlower(sCurrency) then
      begin
        isForeign := true;
      end;

      copyText := _islErl(IvI.ivhPrintText,isForeign);


      if IvI.KreditType = ktKredit then
      begin
        IvI.ivhTotal := IvI.ivhTotal * - 1;
        IvI.ivhTotal_woVat := IvI.ivhTotal_woVat * - 1;
        IvI.ivhTotal_VAT := IvI.ivhTotal_VAT * - 1;
        IvI.ivhTotal_Currency := IvI.ivhTotal_Currency * - 1;
        IvI.ivhTotalBreakFast := IvI.ivhTotalBreakFast * - 1;

        for i := 0 to IvI.lineCount - 1 do
        begin
          IvI.LinesList[i].Price := IvI.LinesList[i].Price * - 1;
          IvI.LinesList[i].TotalPrice := IvI.LinesList[i].TotalPrice * - 1;
        end;

        for i := 0 to IvI.paymentCount - 1 do
        begin
          IvI.PaymentList[i].pmAmount := IvI.PaymentList[i].pmAmount * - 1;
        end;

        for i := 0 to IvI.VATcount - 1 do
        begin
          IvI.VATList[i].Price_woVAT := IvI.VATList[i].Price_woVAT * - 1;
          IvI.VATList[i].Price_wVAT := IvI.VATList[i].Price_wVAT * - 1;
          IvI.VATList[i].VATAmount := IvI.VATList[i].VATAmount * - 1;
        end;
      end;

      if d.mtHead_.active then
        d.mtHead_.close;
      d.mtHead_.open;
      d.mtHead_.INSERT;
      d.mtHead_.ClearFields;

      Rate := IvI.CurrencyRate;
      if Rate = 0 then
        Rate := 1;

      d.mtHead_.fieldbyname('Customer').asString := IvI.CustomerInfo.IvCustomer;
      d.mtHead_.fieldbyname('InvoiceNumber').asInteger := IvI.InvoiceNumber;
      d.mtHead_.fieldbyname('InvoiceDate').asDateTime := IvI.ivhDate;
      d.mtHead_.fieldbyname('payDate').asDateTime := IvI.ivhPayDate;
      d.mtHead_.fieldbyname('Staff').asString := IvI.ivhStaff;
      d.mtHead_.fieldbyname('CustomerName').asString := IvI.CustomerInfo.IvName;
      d.mtHead_.fieldbyname('Address1').asString := IvI.CustomerInfo.IvAddress1;
      d.mtHead_.fieldbyname('Address2').asString := IvI.CustomerInfo.IvAddress2;
      d.mtHead_.fieldbyname('Address3').asString := IvI.CustomerInfo.IvAddress3;
      d.mtHead_.fieldbyname('Address4').asString := IvI.CustomerInfo.IvAddress4;
      d.mtHead_.fieldbyname('Country').asString := IvI.CustomerInfo.IvCountry;
      d.mtHead_.fieldbyname('PersonalId').asString := IvI.CustomerInfo.IvPid;
      d.mtHead_.fieldbyname('GuestName').asString := IvI.CustomerInfo.IvRoomGuest;

      d.mtHead_.fieldbyname('invRefrence').asString := IvI.ivhRefrence;

      d.mtHead_.fieldbyname('Breakfast').asfloat := IvI.ivhTotalBreakFast;
      d.mtHead_.fieldbyname('ExtraText').asString := IvI.ivhExtraText;
      d.mtHead_.fieldbyname('CurrencyRate').asfloat := IvI.CurrencyRate;
      d.mtHead_.fieldbyname('Currency').asString := IvI.Currency;
      d.mtHead_.fieldbyname('LocalCurrency').asString := IvI.LocalCurrency;

      d.mtHead_.fieldbyname('Reservation').asInteger := IvI.ivhReservation;
      d.mtHead_.fieldbyname('RoomReservation').asInteger := IvI.ivhRoomReservation;
      d.mtHead_.fieldbyname('RoomNumber').asString := IvI.ivhRoomNumber;
      d.mtHead_.fieldbyname('Total').asfloat := IvI.ivhTotal;
      d.mtHead_.fieldbyname('TotalwoVAT').asfloat := IvI.ivhTotal_woVat;
      d.mtHead_.fieldbyname('TotalVAT').asfloat := IvI.ivhTotal_VAT;

      d.mtHead_.fieldbyname('TotalBreakfast').asfloat := IvI.ivhTotalBreakFast;
      d.mtHead_.fieldbyname('CreditInvoice').asInteger := IvI.ivhCreditInvoice;
      d.mtHead_.fieldbyname('OrginalInvoice').asInteger := IvI.ivhOriginalInvoice;
      d.mtHead_.fieldbyname('TotalPayments').asfloat := IvI.TotalPayments;

      d.mtHead_.fieldbyname('PrePaid').asfloat := IvI.ivhTotal_prePaid;
      d.mtHead_.fieldbyname('Balance').asfloat := IvI.ivhTotal_balance;
      d.mtHead_.fieldbyname('foPrePaid').asfloat := IvI.ivhTotal_prePaid / Rate;
      d.mtHead_.fieldbyname('foBalance').asfloat := IvI.ivhTotal_balance / Rate;

      d.mtHead_.fieldbyname('foTotal').asfloat := IvI.ivhTotal / Rate;
      d.mtHead_.fieldbyname('foTotalwoVAT').asfloat := IvI.ivhTotal_woVat / Rate;
      d.mtHead_.fieldbyname('foTotalVAT').asfloat := IvI.ivhTotal_VAT / Rate;

      d.mtHead_.fieldbyname('isKredit').AsBoolean := IvI.KreditType = ktKredit;

      d.mtHead_.fieldbyname('invPrintText').AsString := _islErl(IvI.ivhPrintText, isForeign);

      d.mtHead_.fieldbyname('TotalStayTax').asfloat := IvI.ivhTotalStayTax;
      d.mtHead_.fieldbyname('TotalStayTaxNights').asInteger := IvI.ivhTotalStayTaxNights;


      s := '';
      for i := 0 to IvI.paymentCount - 1 do
      begin
        s := s + IvI.PaymentList[i].pmCode + ': ' + trim(_floatToStr(IvI.PaymentList[i].pmAmount, 18, 2)) + '  /  ';
      end;
      d.mtHead_.fieldbyname('PaymentLine').asString := s;

      s := '';
      for i := 0 to IvI.paymentCount - 1 do
      begin
        s := s + IvI.PaymentList[i].pmCode + ': ' + trim(_floatToStr(IvI.PaymentList[i].pmAmount / Rate, 18, 2)) + '  /  ';
      end;
      d.mtHead_.fieldbyname('foPaymentLine').asString := s;

      d.mtHead_.Post;

      if d.mtLines_.active then
        d.mtLines_.close;
      d.mtLines_.open;

      d.mtLines_.INSERT;
      d.mtLines_.ClearFields;
      for i := 0 to IvI.lineCount - 1 do
      begin
        d.mtLines_.INSERT;
        d.mtLines_.fieldbyname('lineNo').asInteger := IvI.LinesList[i].LineNo;
        d.mtLines_.fieldbyname('Date').asDateTime := IvI.LinesList[i].Date;
        d.mtLines_.fieldbyname('Code').asString := IvI.LinesList[i].code;
        d.mtLines_.fieldbyname('Description').asString := IvI.LinesList[i].Description;
        d.mtLines_.fieldbyname('Count').asFloat := IvI.LinesList[i].Count; //-96
        d.mtLines_.fieldbyname('Price').asfloat := IvI.LinesList[i].Price;
        d.mtLines_.fieldbyname('Amount').asfloat := IvI.LinesList[i].TotalPrice;
        d.mtLines_.fieldbyname('AmountWoVat').asfloat := IvI.LinesList[i].TotalWOVat;
        d.mtLines_.fieldbyname('VatAmount').asfloat := IvI.LinesList[i].VATAmount;
        d.mtLines_.fieldbyname('VatCode').asString := IvI.LinesList[i].VATCode;
        d.mtLines_.fieldbyname('AccountKey').asString := IvI.LinesList[i].AccountKey;
        d.mtLines_.fieldbyname('importSource').asString := IvI.LinesList[i].ImportSource;
        d.mtLines_.fieldbyname('importRefrence').asString := IvI.LinesList[i].ImportRefrence;

        d.mtLines_.fieldbyname('foPrice').asfloat := IvI.LinesList[i].Price / Rate;
        d.mtLines_.fieldbyname('foAmount').asfloat := IvI.LinesList[i].TotalPrice / Rate;
        d.mtLines_.fieldbyname('foAmountWoVat').asfloat := IvI.LinesList[i].TotalWOVat / Rate;
        d.mtLines_.fieldbyname('foVatAmount').asfloat := IvI.LinesList[i].VATAmount / Rate;

        d.mtLines_.Post;
      end;
      d.mtLines_.SortOn('lineNo', []);

      if d.mtPayments_.active then
        d.mtPayments_.close;
      d.mtPayments_.open;
      d.mtPayments_.INSERT;
      d.mtPayments_.ClearFields;
      for i := 0 to IvI.paymentCount - 1 do
      begin
        d.mtPayments_.INSERT;
        d.mtPayments_.fieldbyname('Date').asDateTime := IvI.PaymentList[i].pmDate;
        d.mtPayments_.fieldbyname('Code').asString := IvI.PaymentList[i].pmCode;
        d.mtPayments_.fieldbyname('Amount').asfloat := IvI.PaymentList[i].pmAmount;
        d.mtPayments_.fieldbyname('foAmount').asfloat := IvI.PaymentList[i].pmAmount / Rate;
        d.mtPayments_.fieldbyname('Description').asString := IvI.PaymentList[i].pmDescription;
        d.mtPayments_.fieldbyname('TypeIndex').asInteger := IvI.PaymentList[i].pmTypeIndex;

        d.mtPayments_.Post
      end;
      // d.mtLines_.SortOn('lineNo',[]);

      if d.mtVAT_.active then
        d.mtVAT_.close;
      d.mtVAT_.open;
      d.mtVAT_.INSERT;
      d.mtVAT_.ClearFields;
      for i := 0 to IvI.VATcount - 1 do
      begin
        d.mtVAT_.INSERT;
        d.mtVAT_.fieldbyname('Code').asString := IvI.VATList[i].VATCode;
        d.mtVAT_.fieldbyname('Description').asString := IvI.VATList[i].VATDescription;
        d.mtVAT_.fieldbyname('Price_woVAT').asfloat := IvI.VATList[i].Price_woVAT;
        d.mtVAT_.fieldbyname('Price_wVAT').asfloat := IvI.VATList[i].Price_wVAT;
        d.mtVAT_.fieldbyname('VATAmount').asfloat := IvI.VATList[i].VATAmount;

        d.mtVAT_.fieldbyname('foPrice_woVAT').asfloat := IvI.VATList[i].Price_woVAT / Rate;
        d.mtVAT_.fieldbyname('foPrice_wVAT').asfloat := IvI.VATList[i].Price_wVAT / Rate;
        d.mtVAT_.fieldbyname('foVATAmount').asfloat := IvI.VATList[i].VATAmount / Rate;

        d.mtVAT_.fieldbyname('VATPercentage').asfloat := IvI.VATList[i].VATPercentage;
        d.mtVAT_.Post
      end;

      if d.mtCompany_.active then
        d.mtCompany_.close;
      d.mtCompany_.open;
      d.mtCompany_.INSERT;
      d.mtCompany_.ClearFields;

      d.mtCompany_.fieldbyname('CompanyName').asString := IvI.CompanyName;
      d.mtCompany_.fieldbyname('Address1').asString := IvI.CompanyAddress1;
      d.mtCompany_.fieldbyname('Address2').asString := IvI.CompanyAddress2;
      d.mtCompany_.fieldbyname('Address3').asString := IvI.CompanyAddress3;
      d.mtCompany_.fieldbyname('Address4').asString := IvI.CompanyAddress4;
      d.mtCompany_.fieldbyname('Country').asString := IvI.CompanyCountry;
      d.mtCompany_.fieldbyname('TelePhone1').asString := IvI.CompanyTelePhone1;
      d.mtCompany_.fieldbyname('TelePhone2').asString := IvI.CompanyTelePhone2;
      d.mtCompany_.fieldbyname('Fax').asString := IvI.CompanyFax;
      d.mtCompany_.fieldbyname('Email').asString := IvI.CompanyEmail;
      d.mtCompany_.fieldbyname('HomePage').asString := IvI.CompanyHomePage;
      d.mtCompany_.fieldbyname('CompanyPID').asString := IvI.CompanyPID;
      d.mtCompany_.fieldbyname('CompanyVATno').asString := IvI.CompanyVATno;
      d.mtCompany_.fieldbyname('CompanyBankInfo').asString := IvI.CompanyBankInfo;

      if d.mtCaptions_.active then
        d.mtCaptions_.close;
      d.mtCaptions_.open;
      d.mtCaptions_.INSERT;
      d.mtCaptions_.ClearFields;

      sTmp := '';
      if IvI.InvoiceNumber = PROFORMA_INVOICE_NUMBER then
      begin
        sTmp := ' - ' + copyText;
      end;

      d.mtCaptions_.fieldbyname('invTxtHead').asString := _islErl(IvI.invTxtHeadDebit, isForeign) + sTmp;
      if IvI.KreditType = ktKredit then
      begin
        d.mtCaptions_.fieldbyname('invTxtHead').asString := _islErl(IvI.invTxtHeadKredit, isForeign) + sTmp;
      end;

      d.mtCaptions_.fieldbyname('invTxtHeadInfoNumber').asString := _islErl(IvI.invTxtHeadInfoNumber, isForeign);
      d.mtCaptions_.fieldbyname('invTxtHeadInfoDate').asString := _islErl(IvI.invTxtHeadInfoDate, isForeign);
      d.mtCaptions_.fieldbyname('invTxtHeadInfoCustomerNo').asString := _islErl(IvI.invTxtHeadInfoCustomerNo, isForeign);
      d.mtCaptions_.fieldbyname('invTxtHeadInfoGjalddagi').asString := _islErl(IvI.invTxtHeadInfoGjalddagi, isForeign);
      d.mtCaptions_.fieldbyname('invTxtHeadInfoEindagi').asString := _islErl(IvI.invTxtHeadInfoEindagi, isForeign);
      d.mtCaptions_.fieldbyname('invTxtHeadInfoLocalCurrency').asString := _islErl(IvI.invTxtHeadInfoLocalCurrency, isForeign);
      d.mtCaptions_.fieldbyname('invTxtHeadInfoCurrency').asString := _islErl(IvI.invTxtHeadInfoCurrency, isForeign);
      d.mtCaptions_.fieldbyname('invTxtHeadInfoCurrencyRate').asString := _islErl(IvI.invTxtHeadInfoCurrencyRate, isForeign);
      d.mtCaptions_.fieldbyname('invTxtHeadInfoReservation').asString := _islErl(IvI.invTxtHeadInfoReservation, isForeign);
      d.mtCaptions_.fieldbyname('invTxtHeadInfoCreditInvoice').asString := _islErl(IvI.invTxtHeadInfoCreditInvoice, isForeign);
      d.mtCaptions_.fieldbyname('invTxtHeadInfoOrginalInfo').asString := _islErl(IvI.invTxtHeadInfoOrginalInfo, isForeign);
      d.mtCaptions_.fieldbyname('invTxtHeadInfoGuest').asString := _islErl(IvI.invTxtHeadInfoGuest, isForeign);
      d.mtCaptions_.fieldbyname('invTxtHeadInfoRoom').asString := _islErl(IvI.invTxtHeadInfoRoom, isForeign);
      d.mtCaptions_.fieldbyname('invTxtLinesItemNo').asString := _islErl(IvI.invTxtLinesItemNo, isForeign);
      d.mtCaptions_.fieldbyname('invTxtLinesItemText').asString := _islErl(IvI.invTxtLinesItemText, isForeign);
      d.mtCaptions_.fieldbyname('invTxtLinesItemCount').asString := _islErl(IvI.invTxtLinesItemCount, isForeign);
      d.mtCaptions_.fieldbyname('invTxtLinesItemPrice').asString := _islErl(IvI.invTxtLinesItemPrice, isForeign);
      d.mtCaptions_.fieldbyname('invTxtLinesItemAmount').asString := _islErl(IvI.invTxtLinesItemAmount, isForeign);
      d.mtCaptions_.fieldbyname('invTxtLinesItemTotal').asString := _islErl(IvI.invTxtLinesItemTotal, isForeign);
      d.mtCaptions_.fieldbyname('invTxtExtra1').asString := _islErl(IvI.invTxtExtra1, isForeign);
      d.mtCaptions_.fieldbyname('invTxtExtra2').asString := _islErl(IvI.invTxtExtra2, isForeign);
      d.mtCaptions_.fieldbyname('invTxtFooterLine1').asString := _islErl(IvI.invTxtFooterLine1, isForeign);
      d.mtCaptions_.fieldbyname('invTxtFooterLine2').asString := _islErl(IvI.invTxtFooterLine2, isForeign);
      d.mtCaptions_.fieldbyname('invTxtFooterLine3').asString := _islErl(IvI.invTxtFooterLine3, isForeign);
      d.mtCaptions_.fieldbyname('invTxtFooterLine4').asString := _islErl(IvI.invTxtFooterLine4, isForeign);
      d.mtCaptions_.fieldbyname('invTxtPaymentListHead').asString := _islErl(IvI.invTxtPaymentListHead, isForeign);
      d.mtCaptions_.fieldbyname('invTxtPaymentListCode').asString := _islErl(IvI.invTxtPaymentListCode, isForeign);
      d.mtCaptions_.fieldbyname('invTxtPaymentListAmount').asString := _islErl(IvI.invTxtPaymentListAmount, isForeign);
      d.mtCaptions_.fieldbyname('invTxtPaymentListDate').asString := _islErl(IvI.invTxtPaymentListDate, isForeign);
      d.mtCaptions_.fieldbyname('invTxtPaymentListTotal').asString := _islErl(IvI.invTxtPaymentListTotal, isForeign);
      d.mtCaptions_.fieldbyname('invTxtPaymentLineHead').asString := _islErl(IvI.invTxtPaymentLineHead, isForeign);
      d.mtCaptions_.fieldbyname('invTxtPaymentLineSeperator').asString := _islErl(IvI.invTxtPaymentLineSeperator, isForeign);
      d.mtCaptions_.fieldbyname('invTxtVATListHead').asString := _islErl(IvI.invTxtVATListHead, isForeign);
      d.mtCaptions_.fieldbyname('invTxtVATListDescription').asString := _islErl(IvI.invTxtVATListDescription, isForeign);
      d.mtCaptions_.fieldbyname('invTxtVATListwoVAT').asString := _islErl(IvI.invTxtVATListwoVAT, isForeign);
      d.mtCaptions_.fieldbyname('invTxtVATListwVAT').asString := _islErl(IvI.invTxtVATListwVAT, isForeign);
      d.mtCaptions_.fieldbyname('invTxtVATListVATpr').asString := _islErl(IvI.invTxtVATListVATpr, isForeign);
      d.mtCaptions_.fieldbyname('invTxtVATListVATAmount').asString := _islErl(IvI.invTxtVATListVATAmount, isForeign);
      d.mtCaptions_.fieldbyname('invTxtVATListTotal').asString := _islErl(IvI.invTxtVATListTotal, isForeign);
      d.mtCaptions_.fieldbyname('invTxtVATLineHead').asString := _islErl(IvI.invTxtVATLineHead, isForeign);
      d.mtCaptions_.fieldbyname('invTxtVATLineSeperator').asString := _islErl(IvI.invTxtVATLineSeperator, isForeign);
      d.mtCaptions_.fieldbyname('invTxtTotalwoVAT').asString := _islErl(IvI.invTxtTotalwoVAT, isForeign);
      d.mtCaptions_.fieldbyname('invTxtTotalVATAmount').asString := _islErl(IvI.invTxtTotalVATAmount, isForeign);
      d.mtCaptions_.fieldbyname('invTxtTotalTotal').asString := _islErl(IvI.invTxtTotalTotal, isForeign);
      d.mtCaptions_.fieldbyname('invTxtCompanyName').asString := _islErl(IvI.invTxtCompanyName, isForeign);
      d.mtCaptions_.fieldbyname('invTxtCompanyAddress').asString := _islErl(IvI.invTxtCompanyAddress, isForeign);
      d.mtCaptions_.fieldbyname('invTxtCompanyTel1').asString := _islErl(IvI.invTxtCompanyTel1, isForeign);
      d.mtCaptions_.fieldbyname('invTxtCompanyTel2').asString := _islErl(IvI.invTxtCompanyTel2, isForeign);
      d.mtCaptions_.fieldbyname('invTxtCompanyFax').asString := _islErl(IvI.invTxtCompanyFax, isForeign);
      d.mtCaptions_.fieldbyname('invTxtCompanyEmail').asString := _islErl(IvI.invTxtCompanyEmail, isForeign);
      d.mtCaptions_.fieldbyname('invTxtCompanyHomePage').asString := _islErl(IvI.invTxtCompanyHomePage, isForeign);
      d.mtCaptions_.fieldbyname('invTxtCompanyPID').asString := _islErl(IvI.invTxtCompanyPID, isForeign);
      d.mtCaptions_.fieldbyname('invTxtCompanyBankInfo').asString := _islErl(IvI.invTxtCompanyBankInfo, isForeign);
      d.mtCaptions_.fieldbyname('invTxtCompanyVATId').asString := _islErl(IvI.invTxtCompanyVATId, isForeign);
      d.mtCaptions_.fieldbyname('invTxtTotalStayTax').asString := _islErl(IvI.ivhTxtTotalStayTax, isForeign);
      d.mtCaptions_.fieldbyname('invTxtTotalStayTaxNights').asString := _islErl(IvI.ivhTxtTotalStayTaxNights, isForeign);

      d.mtCaptions_.fieldbyname('invTxtPaymentListDescription').asString := _islErl(IvI.invTxtPaymentListDescription, isForeign);
      d.mtCaptions_.fieldbyname('invTxtHeadPrePaid').asString := _islErl(IvI.invTxtHeadPrePaid, isForeign);
      d.mtCaptions_.fieldbyname('invTxtHeadBalance').asString := _islErl(IvI.invTxtHeadBalance, isForeign);


    finally
      IvI.Free;
    end;
  end;


  function Td.SnertaExportCustomers(custNo : string) : integer;
  var
    Rset : TRoomerDataSet;
    s : string;
    dTmp : double;
    sTmp : string;
    haus : string;

    lst : tstringList;
    snertaPath : string;
    FileName : string;
    seppi : char;

    cust1 : string;
  begin

    sTmp := ctrlGetString('SnFieldSeparator');
    sTmp := trim(sTmp);
    if length(sTmp) > 0 then
    begin
      seppi := sTmp[1]
    end
    else
    begin
      seppi := ';';
    end;

    s := '';
    s := s + 'VIDNUMER';
    s := s + seppi + 'KENNITALA';
    s := s + seppi + 'NAFN';
    s := s + seppi + 'HEIMILI_1';
    s := s + seppi + 'HEIMILI_2';
    s := s + seppi + 'POSTNUMER';
    s := s + seppi + 'LAND';
    s := s + seppi + 'SIMI_1';
    s := s + seppi + 'SIMI_2';
    s := s + seppi + 'FAX';
    s := s + seppi + 'E_MAIL';
    s := s + seppi + 'Fastur_afslattur';
    s := s + seppi + 'Verdflokkur';

    haus := s+chr(10);

    lst := tstringList.Create;
    try
      result := 0;
      Rset := CreateNewDataSet;
      try
//        s := '';
//        s := s + ' SELECT '+chr(10);
//        s := s + ' * '+chr(10);
//        s := s + ' FROM '+chr(10);
//        s := s + ' Customers '+chr(10);
//        if custNo <> '' then
//        begin
//          s := s + ' WHERE '+chr(10);
//          s := s + ' Customer =' + _db(custNo) + ' '+chr(10);
//        end;
//        s := s + ' ORDER BY customer '+chr(10);

        s := select_SnertaExportCustomers(CustNO);
        s := format(s , [_db(custNo)]);
        if hData.rSet_bySQL(rSet,s) then
      	begin
          FileName := '';

          snertaPath := g.qsnPathXML;
          snertaPath := _Addslash(snertaPath);

          if not DirectoryExists(snertaPath) then
          begin
            snertaPath := g.qProgramExePath;
			      Showmessage(format(GetTranslatedText('shTx_D_FolderNotFound'), [g.qSnPathXML , snertaPath]));
          end else
          begin
			      Showmessage(format(GetTranslatedText('shTx_D_PathChange'), [snertaPath]));

          end;

          FileName := _Addslash(snertaPath) + 'customers.txt';
          if fileExists(FileName) then
          begin
            try
               //ATHFIN  aFile.DeleteFiles(FileName)
               sysUtils.DeleteFile(FileName)
            except
               { TODO 5 -oHordur -cConvert to XE3 :  Create exception and log }
            end;
          end;

          lst.Add(haus);


          Rset.First;
          while not Rset.Eof do
          begin
            cust1 := Rset.fieldbyname('Customer').asString;
            s := '';
            s := s + cust1;
            s := s + seppi + Rset.fieldbyname('PId').asString;
            s := s + seppi + Rset.fieldbyname('SurName').asString;
            s := s + seppi + Rset.fieldbyname('Address1').asString;
            s := s + seppi + Rset.fieldbyname('Address2').asString;
            s := s + seppi + Rset.fieldbyname('Address3').asString;
            s := s + seppi + Rset.fieldbyname('Address4').asString;
            s := s + seppi + Rset.fieldbyname('Tel1').asString;
            s := s + seppi + Rset.fieldbyname('Tel2').asString;
            s := s + seppi + Rset.fieldbyname('FAX').asString;
            s := s + seppi + Rset.fieldbyname('EmailAddress').asString;
            dTmp := LocalFloatValue(Rset.fieldbyname('DiscountPercent').asString);
            try
              sTmp := floatTostr(dTmp);
            except
              sTmp := '0';
            end;
            s := s + seppi + sTmp;
            s := s + seppi + Rset.fieldbyname('PCid').asString;
            lst.Add(s);
            Rset.Next;
          end;
        end;

        if lst.Count > 1 then
        begin
          lst.SaveToFile(FileName);
        end;
      finally
        freeandnil(Rset);
      end;
      result := lst.Count;
      if result > 0 then
        result := result - 1;
    finally
      lst.Free;
    end;
  end;


  function Td.SnertaExportRooms(Room, prefix : string) : integer;
  var
    Rset : TRoomerDataSet;
    s : string;
    sTmp : string;
    haus : string;

    lst : tstringList;
    snertaPath : string;
    FileName : string;
    seppi : char;
  begin
    prefix := trim(prefix);

    sTmp := ctrlGetString('SnFieldSeparator');
    sTmp := trim(sTmp);
    if length(sTmp) > 0 then
    begin
      seppi := sTmp[1]
    end
    else
    begin
      seppi := ';';
    end;

    s := '';
    s := s + 'ROOM';
    s := s + seppi + 'DESCRIPTION';
    s := s + seppi + 'ROOMTYPE';
    s := s + seppi + 'LOCATION';
    s := s + seppi + 'FLOOR';
    s := s + seppi + 'EQUIPMENTS';

    haus := s;

    lst := tstringList.Create;
    try
      result := 0;
      Rset := CreateNewDataSet;
      try
//        s := s + ' SELECT '+chr(10);
//        s := s + ' * '+chr(10);
//        s := s + ' FROM '+chr(10);
//        s := s + ' Rooms '+chr(10);
//        if Room <> '' then
//        begin
//          s := s + ' WHERE '+chr(10);
//          s := s + ' Room =' + _db(Room) + ' '+chr(10);
//        end;
//        s := s + ' ORDER BY Room '+chr(10);

        s := select_SnertaExportRooms(room);
        s := format(s , [_db(Room)]);
        if hData.rSet_bySQL(rSet,s) then
      	begin
          FileName := '';

          if not Rset.Eof then
          begin
            snertaPath := g.qsnPathXML;
            snertaPath := _Addslash(snertaPath);
            if not DirectoryExists(snertaPath) then
            begin
              snertaPath := g.qProgramExePath;
			        Showmessage(format(GetTranslatedText('shTx_D_FolderNotFound'), [g.qSnPathXML , snertaPath]));
            end else
            begin
			        Showmessage(format(GetTranslatedText('shTx_D_PathChange'), [snertaPath]));
            end;

            FileName := _Addslash(snertaPath) + 'Rooms.txt';

            if fileExists(FileName) then
            begin
              try
                //ATHFIN aFile.DeleteFiles(FileName)
                try
                  SysUtils.DeleteFile(FileName)
                Except
                  { TODO 5 -oHordur -cConvert to XE3 :  Create exception and log }
                end;
              except
              end;
            end;
            lst.Add(haus);
          end;

          Rset.First;
          while not Rset.Eof do
          begin
            room := prefix+Rset.fieldbyname('room').asString;
            s := '';
            s := s + room;
            s := s + seppi + Rset.fieldbyname('Description').asString;
            s := s + seppi + Rset.fieldbyname('roomtype').asString;
            s := s + seppi + Rset.fieldbyname('location').asString;
            s := s + seppi + Rset.fieldbyname('floor').asString;
            s := s + seppi + Rset.fieldbyname('Equipments').asString;
            lst.Add(s);
            Rset.Next;
          end;
        end;

        if lst.Count > 1 then
        begin
          lst.SaveToFile(FileName);
        end;

      finally
        freeandnil(Rset);
      end;

      result := lst.Count;
      if result > 0 then
        result := result - 1;
    finally
      lst.Free;
    end;
  end;


  function Td.ExtStatusText(status : string; adate, Arrival, Departure : Tdate) : string;
  var
    TotalNights : integer;
    daysFromArrival : integer;
    daysUntilDeparture : integer;

    s : string;
    ss : string;

    chrStatus : char;

  begin
    TotalNights := trunc(Arrival) - trunc(Departure);
    daysFromArrival := trunc(Arrival) - trunc(adate);
    daysUntilDeparture := trunc(Departure) - trunc(Date);

    s := '';
    s := s + 'Days=' + inttostr(TotalNights) + ' ';
    s := s + 'Stay=' + inttostr(daysFromArrival) + ' ';
    s := s + 'Left=' + inttostr(daysUntilDeparture) + ' ';

    chrStatus := '0';

    if length(status) > 0 then
      chrStatus := status[1];

    case chrStatus of
      'G' :
        begin
		(* if daysUntilDeparture > - 1 then
            ss := 'Should have checked out ' + inttostr(daysUntilDeparture) + ' daysago';
          if daysUntilDeparture = - 1 then
            ss := 'Should have hecked out yesterday ';
          if daysUntilDeparture = 0 then
            ss := 'Leaves today';
          if daysUntilDeparture = 1 then
            ss := 'Leaves tomorrow';
          if daysUntilDeparture > 1 then
            ss := 'Leaves after ' + inttostr(daysUntilDeparture) + ' days';

          s := '';
          s := s + 'Guest is Checked in '; *)
          if daysUntilDeparture > - 1 then
            ss := format(GetTranslatedText('shTx_D_CheckoutXDaysAgo'),  [daysUntilDeparture]);
          if daysUntilDeparture = - 1 then
            ss := GetTranslatedText('shTx_D_CheckoutYesterday');
          if daysUntilDeparture = 0 then
            ss := GetTranslatedText('shTx_D_LeavesToday');
          if daysUntilDeparture = 1 then
            ss := GetTranslatedText('shTx_D_LeavesTomorrow');
          if daysUntilDeparture > 1 then
            ss := format(GetTranslatedText('shTx_D_LeavesAfterXDays'), [daysUntilDeparture]);

          s := '';
          s := s + GetTranslatedText('shTx_D_CheckedIn');
          s := s + ss + '  ';
        end;
    end;
    result := s;
  end;



  function Td.Next_OccupiedDayCount(fromDate: Tdate; Room: string): integer;
  var
    occDate : TDate;
  begin
    occDate := Next_OccupiedDate(fromDate,Room);
    result := trunc(occDate)-trunc(FromDate);
  end;

function Td.Next_OccupiedDate(fromDate : Tdate; Room : string) : Tdate;
  var
    rSet : TRoomerDataSet;
    s : string;
    sDate : string;
  begin
    result := date+3600; // after years
    rSet := CreateNewDataSet;
    try
      //**xzhj
      s := format(select_Next_OccupiedDate , [_db(Room),_dateToDBDate(FromDate,true)]);
      if hData.rSet_bySQL(rSet,s) then
  	  begin
        sDate := Rset.fieldbyname('ADate').asString;
        result := _DBdateToDate(sDate);
      end;
    finally
      freeandnil(Rset);
    end;
  end;


function td.GetCurrentGuestsXML : integer;
var
  Adoc : TNativeXml;
  nRoomReservations : TXmlNode;
  nRoomreservation  : TXmlNode;
  nRoomguest  : TXmlNode;


  rSet : TRoomerDataSet;

  lstRR : TstringList;
  i : integer;
  s : string;

  Room                 : string;
  RoomDescription      : string;
  RoomType             : string;
  RoomTypeDescription  : string;
  Location             : string;
  Floor                : string;
  GuestName            : string;
  GuestCountry         : string;
  Arrival              : Tdate;
  Departure            : TDate;
  Customer             : string;
  CustomerName         : string;
  CustomerPID          : string;
  ReservationName      : string;
  StatusText           : String;
  GuestCount           : integer;

  rCount : integer;

  Reservation          : integer;
  RoomReservation      : integer;
  Status               : string;

  NightsTotal          : Integer;
  NightsFromArrival    : integer;
  NightsUntilDeparture : integer;

  GroupAccount : boolean;
  Breakfast    : boolean;

  sDateTime : string;
  sStaff : string;

  filename : string;

  snertaPathCurrentGuestsXML : string;

begin

  result := 0;

  // ef ekki er POS samskipti
  if ctrlGetInteger('AccountType') <> 3 then
  begin
    exit;
  end;

  dateTimeToString(sDateTime,'yyyy-mm-dd hh:nn:ss',now);
  sStaff := g.qUser;

  if g.qHomeExportPOSType = peExportFolder then
  begin
    Adoc := TNativeXml.CreateName('checkedin_guests');
    try

      rSet := CreateNewDataSet;
      try
        
        rSet.CommandType := cmdText;

        nRoomReservations := Adoc.Root.NodeNew('roomreservations');
        with nRoomReservations do
        begin
          AttributeAdd(UTF8String('hotelcode'), UTF8String(g.qHotelCode));
          AttributeAdd(UTF8String('staff'), UTF8String(sStaff));
          AttributeAdd(UTF8String('exportdatetime'), UTF8String(sDateTime));
        end;

        lstRR := d.lstRR_CurrentlyCheckedIn(Date);
        try
          result := lstRR.Count;

          for i := 0 to lstRR.Count - 1 do
          begin
            roomReservation := strToInt(lstRR[i]);
            // rSet := SP_GET_GuestsInfoByRoomReservation(RoomReservation);
            rSet := CreateNewDataSet;
            try
              s := format(select_GuestsInfoByRoomReservation, [RoomReservation]);
              if hData.rSet_bySQL(rSet,s) then
              begin
                rSet.First;
                GuestCount := rSet.RecordCount;
                rCount := 0;

                nRoomreservation := nRoomReservations.NodeNew('roomreservation');
                nRoomreservation.AttributeAdd(UTF8String('roomreservation_number'), UTF8String(lstRR[i]));
                nRoomreservation.AttributeAdd(UTF8String('guests_count'), UTF8String(inttostr(guestCount)));

                while not rSet.Eof do
                begin
                  inc(rCount);
                  Room                 := rSet.FieldByName('Room').asstring;
                  RoomDescription      := rSet.FieldByName('RoomDescription').asstring;
                  RoomType             := rSet.FieldByName('RoomType').asstring;
                  RoomTypeDescription  := rSet.FieldByName('RoomTypeDescription').asstring;
                  Location             := rSet.FieldByName('Location').asstring;
                  Floor                := rSet.FieldByName('Floor').asstring;
                  Arrival              := rSet.FieldByName('rrArrival').asDateTime;
                  Departure            := rSet.FieldByName('rrDeparture').asDateTime;
                  Customer             := rSet.FieldByName('Customer').asstring;
                  CustomerName         := rSet.FieldByName('CustomerName').asstring;
                  CustomerPID          := rSet.FieldByName('CustomerPID').asstring;
                  ReservationName      := rSet.FieldByName('ReservationName').asstring;
                  Status               := rSet.FieldByName('Status').asString;
                  Reservation          := rSet.FieldByName('Reservation').asInteger;
                  GroupAccount         := rSet['GroupAccount'];
                  Breakfast            := rSet['invBreakfast'];
                  StatusText           := d.ExtStatusText(status,Date, Arrival, departure);
                  NightsTotal          := trunc(Departure)-trunc(Arrival);
                  NightsFromArrival    := trunc(date)-trunc(Arrival) ;
                  NightsUntilDeparture := trunc(Departure)-trunc(Date);

                  GuestName            := rSet.FieldByName('GuestName').asstring;
                  GuestCountry         := rSet.FieldByName('CountryName').asstring;


                  if rCount = 1 then
                  begin
                    nRoomreservation.AttributeAdd(UTF8String('room'), UTF8String(room));
                    nRoomreservation.AttributeAdd(UTF8String('main_guest'),UTF8String(GuestName));
                    nRoomreservation.writestring(UTF8String('Room_description'), UTF8String(Roomdescription));
                    nRoomreservation.writestring(UTF8String('room_type'),UTF8String(RoomType), UTF8String(''));
                    nRoomreservation.writestring(UTF8String('room_type_description'),UTF8String(RoomTypeDescription) , UTF8String(''));
                    nRoomreservation.writestring(UTF8String('location'),UTF8String(Location), UTF8String(''));
                    nRoomreservation.writestring(UTF8String('floor'),UTF8String(Floor), UTF8String(''));
                    nRoomreservation.writestring(UTF8String('arrival'),UTF8String(_DateToDbDate(Arrival,false)), UTF8String(''));
                    nRoomreservation.writestring(UTF8String('departure'),UTF8String(_DateToDbDate(Departure,false)), UTF8String(''));
                    nRoomreservation.writestring(UTF8String('customer'),UTF8String(Customer), UTF8String(''));
                    nRoomreservation.writestring(UTF8String('customer_name'),UTF8String(CustomerName), UTF8String(''));
                    nRoomreservation.writestring(UTF8String('customer_pid'),UTF8String(CustomerPID), UTF8String(''));
                    nRoomreservation.writestring(UTF8String('reservation_name'),UTF8String(ReservationName), UTF8String(''));
                    nRoomreservation.writestring(UTF8String('status'),UTF8String(Status), UTF8String(''));
                    nRoomreservation.writestring(UTF8String('reservation'),UTF8String(inttostr(Reservation)), UTF8String(''));
                    nRoomreservation.writestring(UTF8String('group_account'),UTF8String(boolToStr(GroupAccount)), UTF8String(''));
                    nRoomreservation.writestring(UTF8String('breakfast'),UTF8String(boolToStr(Breakfast)), UTF8String(''));
                    nRoomreservation.writestring(UTF8String('status_text'),UTF8String(StatusText), UTF8String(''));
                    nRoomreservation.writestring(UTF8String('nights_total'),UTF8String(inttostr(NightsTotal)), UTF8String(''));
                    nRoomreservation.writestring(UTF8String('nights_from_arrival'),UTF8String(inttostr(NightsFromArrival)), UTF8String(''));
                    nRoomreservation.writestring(UTF8String('nights_until_departure'),UTF8String(inttostr(NightsUntilDeparture)), UTF8String(''));
                  end;
                  nRoomGuest := nRoomReservation.NodeNew(UTF8String('room_guest'));
                  nRoomGuest.AttributeAdd(UTF8String('guest_index'),UTF8String(inttostr(rCount)));
                  nRoomGuest.writestring(UTF8String('guest_name'),UTF8String(GuestName), UTF8String(''));
                  nRoomGuest.writestring(UTF8String('guest_country'),UTF8String(GuestCountry), UTF8String(''));
                  rSet.next;
                end;
              end;
            finally
              freeandnil(rset);
            end;
          end;
        finally
          freeandNil(lstRR);
        end;

      finally
        if rSet <> nil then freeandnil(rSet);
      end;

      snertaPathCurrentGuestsXML := g.qsnPathCurrentGuestsXML;
      snertaPathCurrentGuestsXML := _Addslash(snertaPathCurrentGuestsXML);

      if not DirectoryExists(snertaPathCurrentGuestsXML) then
      begin
        snertaPathCurrentGuestsXML := g.qSnPathXML;
      end;

      if not DirectoryExists(snertaPathCurrentGuestsXML) then
      begin
        snertaPathCurrentGuestsXML := g.qProgramExePath;
      end;


      FileName :=_Addslash(snertaPathCurrentGuestsXML) + 'currentguests' + '.xml';

      if fileExists(filename) then
      begin
        try
           //**ATHFIN aFile.DeleteFiles(filename);+
          SysUtils.DeleteFile(filename);
        except
          { TODO 5 -oHordur -cConvert to XE3 :  Create exception and log }
        end;
      end;

      Adoc.XmlFormat := xfReadable;

      try
        //ATHFIX XE Adoc.ExternalEncoding := ctrlGetString('snXMLencoding');
        Adoc.Charset := UTF8String(ctrlGetString('snXMLencoding'));
      except
      end;
      try
        Adoc.SaveToFile(FileName);
      except
      end;
    finally
      freeandnil(aDoc);
    end;
  end else
  begin // setja í gagnagrunn
    if g.qHomeExportPOSType = peExportLogFile  then
    begin
      //**
      s := '';
      s := s+' INSERT INTO tblpoxexport '+chr(10);
      s := s+'  ( '+chr(10);
      s := s+'   InvoiceNumber '+chr(10);
      s := s+'  ,Reservation '+chr(10);
      s := s+'  ,RoomReservation '+chr(10);
      s := s+'  ,InsertDate '+chr(10);
      s := s+'  ) '+chr(10);
      s := s+' VALUES '+chr(10);
      s := s+'  ( '+chr(10);
      s := s+'   '+_db(-1001)+' '+chr(10);
      s := s+'  ,'+_db(0)+' '+chr(10);
      s := s+'  ,'+_db(0)+' '+chr(10);
      s := s+'  ,'+_db(now)+' '+chr(10);
      s := s+'  )'+chr(10);
      if not cmd_bySQL(s) then
      begin
      end;
    end;
  end;
end;



  function td.IH_GetRefrence(invoiceNumber, Reservation, roomReservation : integer) : string;
  var
    rSet : TRoomerDataSet;
    s : string;
  begin
    Result := '';

    Rset := CreateNewDataSet;
    try
//      s := s + ' SELECT '+chr(10);
//      s := s + '     Reservation '+chr(10);
//      s := s + '   , RoomReservation '+chr(10);
//      s := s + '   , InvoiceNumber '+chr(10);
//      s := s + '   , invRefrence '+chr(10);
//      s := s + ' FROM '+chr(10);
//      s := s + '   InvoiceHeads '+chr(10);
//      s := s + ' WHERE '+chr(10);
//      s := s + '   (Reservation = '+_db(reservation)+')  and (RoomReservation = '+_db(roomReservation)+')  and (InvoiceNumber = '+_db(invoicenumber)+') '+chr(10);
      s := format(select_IH_GetRefrence , [reservation,roomReservation,invoicenumber]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        result := rSet.FieldByName('invRefrence').AsString;
      end;
    finally
       freeAndNil(rSet);
    end;
  end;


function Td.hiddenInfo_Exists(Refrence, RefrenceType: integer): integer;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  result := 0;
//  s := s+' SELECT '+chr(10);
//  s := s+'       ID  '+chr(10);
//  s := s+'     , Refrence  '+chr(10);
//  s := s+'     , RefrenceType  '+chr(10);
//  s := s+'   FROM  '+chr(10);
//  s := s+'     tblHiddenInfo  '+chr(10);
//  s := s+'   WHERE     (Refrence = '+_db(Refrence)+') AND (RefrenceType = '+_db(RefrenceType)+') '+chr(10);
  rSet := CreateNewDataSet;
  try
    s := format(select_hiddenInfo_Exists , [_db(Refrence),_db(RefrenceType)]);
    if hData.rSet_bySQL(rSet,s) then
  	begin
      result := rSet.FieldByName('id').AsInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;



function Td.hiddenInfo_getData(ID: integer): recHiddenInfoHolder;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  g.initRecHiddenInfo(result);
//  s := s+' SELECT '+chr(10);
//  s := s+'     ID '+chr(10);
//  s := s+'   , Notes '+chr(10);
//  s := s+'   , ViewLog '+chr(10);
//  s := s+'   , DeleteOn '+chr(10);
//  s := s+'   , Refrence '+chr(10);
//  s := s+'   , RefrenceType '+chr(10);
//  s := s+' FROM '+chr(10);
//  s := s+'   tblHiddenInfo '+chr(10);
//  s := s+' WHERE (ID = '+_db(ID)+') '+chr(10);
  rSet := CreateNewDataSet;
  try
    s := format(select_hiddenInfo_getData , [ID]);
    if hData.rSet_bySQL(rSet,s) then
  	begin
      result.id := rSet.FieldByName('id').AsInteger;
      result.Notes := rSet.FieldByName('Notes').AsString;
      result.DeleteOn := rSet.FieldByName('deleteOn').AsDateTime;
      result.ViewLog := rSet.FieldByName('ViewLog').AsString;
      result.refrence := rSet.FieldByName('Refrence').AsInteger;
      result.refrenceType := rSet.FieldByName('refrenceType').AsInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.hiddenInfo_Append(ID: integer; newText : string; res : integer) : boolean;
var
  s    : string;
  rec  : recHiddenInfoHolder;

  orginalText : string;
  updatedText : string;
  sTmp        : string;
  sDate       : string;
begin
  dateTimeToString(sDate,'YYYY-mm-dd hh:nn',now);
  result := false;

  if newText = '' then exit; //===>

  rec := d.hiddenInfo_getData(ID);

  if ID = 0 then
  begin
    rec.Refrence := res;
    rec.RefrenceType := 1;
    updatedText := _strNumEnCrypt(NewText,5849);
    rec.ViewLog := sDate+'  -  '+g.qUser+'  -  '+ GetTranslatedText('shTx_D_AddedNoLogin');  //'Added without loggin in';
    s := '';
    s := s+' INSERT INTO tblhiddeninfo ('+chr(10);
    s := s+'     Notes '+chr(10);
    s := s+'    ,DeleteOn '+chr(10);
    s := s+'    ,ViewLog '+chr(10);
    s := s+'    ,Refrence '+chr(10);
    s := s+'    ,RefrenceType '+chr(10);
    s := s+'    ) '+chr(10);
    s := s+' VALUES ( '+chr(10);
    s := s+'    '+_db(updatedText)+' '+chr(10);
    s := s+'   ,'+_db(rec.DeleteOn)+' '+chr(10);
    s := s+'   ,'+_db(rec.ViewLog)+' '+chr(10);
    s := s+'   ,'+_db(rec.Refrence)+' '+chr(10);
    s := s+'   ,'+_db(rec.RefrenceType)+' '+chr(10);
    s := s+'  ) '+chr(10);
    if not cmd_bySQL(s) then
    begin
    end;
  end else
  begin
      // record Found so append new text to the orginal
    orginalText := _strNumDeCrypt(rec.Notes,5849);
    sTmp := orginalText+#13#10+'----'+#13#10+NewText;
    updatedText :=  _strNumEnCrypt(sTmp,5849);
    rec.ViewLog := sDate+'  -  '+g.qUser+'  -  '+ GetTranslatedText('shTx_D_AddedNoLogin'); //'Added without loggin in';
    s := '';
    s := s + ' UPDATE tblhiddeninfo '+chr(10);
    s := s + ' SET '+chr(10);
    s := s + '  Notes=' + _db(updatedText)+' '+chr(10);
    s := s + ' WHERE (ID = ' + _db(ID) + ') '+chr(10);
    if not cmd_bySQL(s) then
    begin
    end;
  end;
end;



procedure Td.memImportResults_Fill;
begin
  if memImportResults.active then memImportResults.Close();
  memImportResults.Open;

  memImportResults.INSERT;
  memImportResults.FieldByName('ID').AsInteger := 10000;
  memImportResults.FieldByName('Description').AsString := 'Sucess - From POS';
  memImportResults.Post;

  memImportResults.INSERT;
  memImportResults.FieldByName('ID').AsInteger := 10010;
  memImportResults.FieldByName('Description').AsString := 'Sucess - From Home';
  memImportResults.Post;

  memImportResults.INSERT;
  memImportResults.FieldByName('ID').AsInteger := 20000;
  memImportResults.FieldByName('Description').AsString := 'Warning - Reason unknown';
  memImportResults.Post;

  memImportResults.INSERT;
  memImportResults.FieldByName('ID').AsInteger := 20100;
  memImportResults.FieldByName('Description').AsString := 'Warning - Get Item';
  memImportResults.Post;

  memImportResults.INSERT;
  memImportResults.FieldByName('ID').AsInteger := 20200;
  memImportResults.FieldByName('Description').AsString := 'Warning - Edit Item';
  memImportResults.Post;

  memImportResults.INSERT;
  memImportResults.FieldByName('ID').AsInteger := 20300;
  memImportResults.FieldByName('Description').AsString := 'Warning - INSERT Item';
  memImportResults.Post;

  memImportResults.INSERT;
  memImportResults.FieldByName('ID').AsInteger := 30000;
  memImportResults.FieldByName('Description').AsString := 'Failed - Reason unknown';
  memImportResults.Post;

  memImportResults.INSERT;
  memImportResults.FieldByName('ID').AsInteger := 30010;
  memImportResults.FieldByName('Description').AsString := 'Failed - HOME - Path not found';
  memImportResults.Post;

  memImportResults.INSERT;
  memImportResults.FieldByName('ID').AsInteger := 30100;
  memImportResults.FieldByName('Description').AsString := 'Failed - RoomReservation not found';
  memImportResults.Post;

  memImportResults.INSERT;
  memImportResults.FieldByName('ID').AsInteger := 30200;
  memImportResults.FieldByName('Description').AsString := 'Failed - INSERT Draft invoice';
  memImportResults.Post;

  memImportResults.INSERT;
  memImportResults.FieldByName('ID').AsInteger := 30300;
  memImportResults.FieldByName('Description').AsString := 'Failed - INSERT InvoiceLinbe';
  memImportResults.Post;


  memImportResults.SortedField := 'ID';
end;

procedure Td.memImportTypes_Fill;
begin
  if memImportTypes.active then memImportTypes.Close();
  memImportTypes.Open;

  memImportTypes.Append;
  memImportTypes.FieldByName('ID').AsInteger := 10000;
  memImportTypes.FieldByName('Description').AsString := 'POS InvoiceLine';
  memImportTypes.Post;

  memImportTypes.INSERT;
  memImportTypes.FieldByName('ID').AsInteger := 10010;
  memImportTypes.FieldByName('Description').AsString := 'POS InvoiceLine - HOME';
  memImportTypes.Post;

  memImportTypes.INSERT;
  memImportTypes.FieldByName('ID').AsInteger := 10100;
  memImportTypes.FieldByName('Description').AsString := 'POS InvoiceLine - Snerta';
  memImportTypes.Post;

  memImportTypes.INSERT;
  memImportTypes.FieldByName('ID').AsInteger := 10200;
  memImportTypes.FieldByName('Description').AsString := 'POS InvoiceLine - MerkurPos';
  memImportTypes.Post;

  memImportTypes.SortedField := 'ID';
end;






procedure Td.IH_getPaymentsTypes(invoiceNumber : integer; var PayTypes, PayTypeDescription, payGroups, payGroupDescription : string);
var
  rSet : TRoomerDataSet;
  s : string;
  PayType : string;
  PayGroup : string;
begin
  rSet := CreateNewDataSet;
  try
//    s := s+ ' SELECT '+chr(10);
//    s := s+ '     InvoiceHeads.InvoiceNumber '+chr(10);
//    s := s+ '   , Payments.Description '+chr(10);
//    s := s+ '   , Payments.PayType '+chr(10);
//    s := s+ '   , Paytypes.Description AS PayTypeDescription '+chr(10);
//    s := s+ '   , Paytypes.PayGroup '+chr(10);
//    s := s+ '   , PayGroups.Description AS PayGroupDescription '+chr(10);
//    s := s+ ' FROM '+chr(10);
//    s := s+ '   Paytypes '+chr(10);
//    s := s+ '      INNER JOIN Payments ON Paytypes.PayType = Payments.PayType '+chr(10);
//    s := s+ '      INNER JOIN PayGroups ON Paytypes.PayGroup = dbo.PayGroups.PayGroup '+chr(10);
//    s := s+ '      RIGHT OUTER JOIN InvoiceHeads ON Payments.InvoiceNumber = InvoiceHeads.InvoiceNumber '+chr(10);
//    s := s+ ' WHERE '+chr(10);
//    s := s+ '   (dbo.InvoiceHeads.InvoiceNumber = '+_db(InvoiceNumber)+') '+chr(10);
    s := format(select_IH_getPaymentsTypes , [InvoiceNumber]);
    if hData.rSet_bySQL(rSet,s) then
  	begin
      PayTypes  := '';
      PayGroups := '';

      while not rSet.eof do
      begin
        PayType             := rSet.FieldByName('PayType').AsString;
        payTypeDescription  := rSet.FieldByName('PayTypeDescription').AsString;
        PayGroup            := rSet.FieldByName('PayGroup').AsString;
        PayGroupDescription := rSet.FieldByName('PayGroupDescription').AsString;

        PayTypes  := PayTypes+PayType+',';
        PayGroups := PayGroups+PayGroup+',';
        rSet.next;
      end;

      if payTypes <> '' then delete(payTypes,length(payTypes),1);
      if payGroups <> '' then delete(payGroups,length(payGroups),1);

      if pos(',',payGroups) > 0 then PayGroupDescription := 'Miscellaneous';
      if pos(',',payTypes)  > 0 then PayTypeDescription := 'Miscellaneous';
    end;
  finally
    freeandNil(rSet);
  end;
end;


Function  Td.IA_ActionCount(InvoiceNumber, actionID : integer) : integer;
var
  s    : string;
  rSet : TRoomerDataSet;
begin
  result := 0;

  rSet := CreateNewDataSet;
  try
//    s := s + ' SELECT '+chr(10);
//    s := s + '   COUNT(ID) AS invCount '+chr(10);
//    s := s + '    , InvoiceNumber '+chr(10);
//    s := s + '    , ActionID '+chr(10);
//    s := s + '  FROM '+chr(10);
//    s := s + '    tblInvoiceActions '+chr(10);
//    s := s + '  GROUP BY InvoiceNumber, ActionID '+chr(10);
//    s := s + '  HAVING '+chr(10);
//    s := s + '    (InvoiceNumber = ' + _Db(InvoiceNumber) + ') AND (ActionID=1001) '+chr(10);
    s := format(select_IA_ActionCount , [InvoiceNumber]);
    if hData.rSet_bySQL(rSet,s) then
  	begin
      result := rSet.fieldbyname('invCount').asInteger;
    end;
  finally
    freeandnil(rset);
  end;
end;

function Td.getRoomTypeColors(sRoomType : string) : recStatusAttr;
  var
    iColor : integer;
  begin
    g.initStatusAttrRec(result);

//    result.backgroundColor := g.qColorOneDayRoomColBack;
//    result.fontColor := g.qColorOneDayRoomColFont;
//
//    sColor := '';

    //ATH777
    iColor := glb.LocateRoomTypeColor(sRoomType);
    if iColor > -1 then
    begin
      result.backgroundColor := iColor;
      result.fontColor := InverseColor(iColor);
    end else
    begin
      result.backgroundColor := g.qColorOneDayRoomColBack;
      result.fontColor := g.qColorOneDayRoomColFont;
    end;
  end;



/////////////////////////////////////////////////////////////////////////////////////////////
///
///
///
///
///
//////////////////////////////////////////////////////////////////////////////////////////////


  procedure Td.ctrlGetGlobalValues;
  var
    s    : string;
    rSet : TRoomerDataSet;
  begin
    g.qArrivalDateRulesPrice := false;
    g.qBreakfastInclDefault := false;
    g.qPhoneUseItem := '';
    g.qPaymentItem := '';
    g.qRoomRentItem := '';
    g.qNativeCurrency := '';
    g.qStayTaxItem := '';
    g.qStayTaxPerPerson := False;
    g.qDiscountItem := '';
    g.qCountry := '';
    g.qBreakFastItem := '';
    g.qLocalRoomRent := '';
    g.qGreenColor := '';
    g.qPurpleColor := '';
    g.qFuchsiaColor := '';
    g.qNameOrder := 0;
    g.qNameOrderPeriod := 0;

    g.qOneDayRowHeight := 10;
    g.qPeriodRowHeight := 25;
    g.qPeriodColWidth := 20;
    g.qPeriodColCount := 5;
    g.qPeriodPrompt := 0;

    g.qPeriodDateformat1 := 'DD ddd';
    g.qPeriodDateformat2 := 'MMM YY';

//    s := s + ' SELECT * '+chr(10);
//    s := s + 'FROM Control  '+chr(10);

    rSet := glb.ControlSet; //  CreateNewDataSet;
//    try
//      s := format(select_ctrlGetGlobalValues , []);
//      if hData.rSet_bySQL(rSet,s) then
//      begin
          g.qOneDayRowHeight := rSet.fieldbyname('GrandRowHeight').asInteger;
          g.qPeriodRowHeight := rSet.fieldbyname('FiveDayRowHeight').asInteger;
          g.qPeriodColWidth := rSet.fieldbyname('FiveDayColWidth').asInteger;
          g.qPeriodColCount := rSet.fieldbyname('FiveDayColCount').asInteger;

          g.qPeriodPrompt := rSet.fieldbyname('FiveDayPrompt').asInteger;

          g.qArrivalDateRulesPrice := rSet['ArrivalDateRulesPrice'];
          g.qBreakfastInclDefault := rSet['BreakfastInclDefault'];
          g.qPhoneUseItem := rSet.fieldbyname('PhoneUseItem').asString;
          g.qPaymentItem := rSet.fieldbyname('PaymentItem').asString;
          g.qNativeCurrency := rSet.fieldbyname('NativeCurrency').asString;
          g.qRoomRentItem := rSet.fieldbyname('RoomRentItem').asString;
          g.qCountry := rSet.fieldbyname('Country').asString;
          g.qBreakFastItem := rSet.fieldbyname('BreakFastItem').asString;
          g.qStayTaxItem := rSet.fieldbyname('stayTaxItem').asString;
          g.qStayTaxPerPerson := rSet['stayTaxPerPerson'];
          g.qDiscountItem := rSet.fieldbyname('DiscountItem').asString;
          g.qLocalRoomRent := rSet.fieldbyname('LocalRoomRent').asString;
          g.qGreenColor := rSet.fieldbyname('GreenColor').asString;
          g.qPurpleColor := rSet.fieldbyname('PurpleColor').asString;
          g.qFuchsiaColor := rSet.fieldbyname('FuchsiaColor').asString;

          try
            g.qPeriodDateformat1 := rSet.fieldbyname('FiveDayDateformat1').asString;
          except
            g.qPeriodDateformat1 := 'MMM YY';
          end;

          try
            g.qPeriodDateformat2 := rSet.fieldbyname('FiveDayDateformat2').asString;
          except
            g.qPeriodDateformat2 := 'DD ddd';
          end;

          try
            g.qNameOrder := rSet.fieldbyname('Nameorder').asInteger;
          except
            g.qNameOrder := 0;
          end;

          try
            g.qInvPriceGroup := rSet.fieldbyname('InvPriceGroup').Asstring;;
          except
            g.qInvPriceGroup := 'REI';
          end;

          try
            g.qUseSetUnclean := rSet.fieldbyname('UseSetUnclean').asBoolean;
          except
            g.qUseSetUnclean := true;
          end;

          try
            g.qNameOrderPeriod := rSet.fieldbyname('NameOrderPeriod').AsInteger;
          except
            g.qNameOrderPeriod := 0;
          end;

          try
            g.qRackCustomer := rSet.fieldbyname('RackCustomer').asstring;
          except
            g.qRackCustomer := '0';
          end;
          if g.qRackCustomer = '' then g.qRackCustomer := '0';

          try
            g.qExcluteWaitingList := rSet.fieldbyname('ExcluteWaitingList').AsBoolean;
          except
            g.qExcluteWaitingList := false;
          end;
          try
            g.qExcluteAllotment := rSet.fieldbyname('ExcluteAllotment').AsBoolean;
          except
            g.qExcluteAllotment := false;
          end;
          try
            g.qExcluteOrder := rSet.fieldbyname('ExcluteOrder').AsBoolean;
          except
            g.qExcluteOrder := false;
          end;
          try
            g.qExcluteDeparted := rSet.fieldbyname('ExcluteDeparted').AsBoolean;
          except
            g.qExcluteDeparted := false;
          end;
          try
            g.qExcluteGuest := rSet.fieldbyname('ExcluteGuest').AsBoolean;
          except
            g.qExcluteGuest := false;
          end;
          try
            g.qExcluteBlocked := rSet.fieldbyname('ExcluteBlocked').AsBoolean;
          except
            g.qExcluteBlocked := false;
          end;
          try
            g.qExcluteNoshow := rSet.fieldbyname('ExcluteNoshow').AsBoolean;
          except
            g.qExcluteNoshow := false;
          end;
//        end;
//      finally
//        freeandnil(rSet);
//      end;
   end;

  function Td.ChkCompany(Company, CompanyName : string) : boolean;
  var
    s : string;
    dbCompany : string;
    dbCompanyName : string;
   rSet : TRoomerDataSet;
begin
  result := false;
  dbCompany := '';
  dbCompanyName := '';

  rSet := CreateNewDataSet;
  try
    s := format(select_ChkCompany , []);
    if hData.rSet_bySQL(rSet,s) then
    begin
      dbCompany := rSet.fieldbyname('CompanyID').asString;
      dbCompanyName := rSet.fieldbyname('CompanyName').asString;
      result := (lowercase(Company) = lowercase(dbCompany)) and (lowercase(CompanyName) = lowercase(dbCompanyName))
    end;
  finally
    freeandNil(rSet);
  end;
//    s := s + ' SELECT '+chr(10);
//     s := s + '    CompanyID '+chr(10);
//    s := s + '  , CompanyName '+chr(10);
//    s := s + 'FROM Control '+chr(10);
end;



  procedure Td.ctrlSetInteger(aField : string; ivalue : integer);
  var
    Rset : TRoomerDataSet;
    s : string;
  begin
    Rset := CreateNewDataSet;
    try
//      s := s + 'SELECT ' + aField + ' '+chr(10);
//      s := s + 'FROM Control  '+chr(10);
      s := format(select_ctrlSetInteger, [aField]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        Rset.edit;
        Rset.fieldbyname(aField).asInteger := ivalue;
        Rset.Post; //ID ADDED
      end;
    finally
      freeandnil(Rset);
    end;
  end;

  procedure Td.ctrlSetString(aField : string; svalue : string);
  var
    Rset : TRoomerDataSet;
    s : string;
  begin
    Rset := CreateNewDataSet;
    try
//    s := s + 'SELECT ' + aField + ' '+chr(10);
//    s := s + 'FROM Control  '+chr(10);
      s := format(select_ctrlSetString, [aField]);
      if hData.rSet_bySQL(rSet,s) then
      begin
        Rset.edit;
        Rset.fieldbyname(aField).asString := svalue;
        Rset.Post;  //ID ADDED
      end;
    finally
      freeandnil(Rset);
    end;
  end;

  //******************************************************************************************

procedure Td.Default_StatusAttr_Blocked;
begin
  g.qStatusAttr_Blocked.backgroundColor := clOlive;
  g.qStatusAttr_Blocked.fontColor := clWhite;
  g.qStatusAttr_Blocked.isBold := true;
  g.qStatusAttr_Blocked.isItalic := false;
  g.qStatusAttr_Blocked.isUnderline := false;
  g.qStatusAttr_Blocked.isStrikeOut := false;
end;

procedure Td.Default_StatusAttr_NoShow;
begin
  g.qStatusAttr_NoShow.backgroundColor := clRed;
  g.qStatusAttr_NoShow.fontColor       := clYellow;
  g.qStatusAttr_NoShow.isBold          := true;
  g.qStatusAttr_NoShow.isItalic        := false;
  g.qStatusAttr_NoShow.isUnderline     := false;
  g.qStatusAttr_NoShow.isStrikeOut     := false;
end;

procedure Td.Default_StatusAttr_Waitinglist;
begin
  g.qStatusAttr_Waitinglist.backgroundColor := clYellow;
  g.qStatusAttr_Waitinglist.fontColor := clBlack;
  g.qStatusAttr_Waitinglist.isBold := false;
  g.qStatusAttr_Waitinglist.isItalic := false;
  g.qStatusAttr_Waitinglist.isUnderline := false;
  g.qStatusAttr_Waitinglist.isStrikeOut := false;
end;

procedure Td.Default_StatusAttr_Allotment;
begin
  g.qStatusAttr_Allotment.backgroundColor := clWhite;
  g.qStatusAttr_Allotment.fontColor := clRed;
  g.qStatusAttr_Allotment.isBold := false;
  g.qStatusAttr_Allotment.isItalic := false;
  g.qStatusAttr_Allotment.isUnderline := false;
  g.qStatusAttr_Allotment.isStrikeOut := false;
end;

procedure Td.Default_StatusAttr_Departed;
begin
  g.qStatusAttr_Departed.backgroundColor := clTeal;
  g.qStatusAttr_Departed.fontColor := clWhite;
  g.qStatusAttr_Departed.isBold := false;
  g.qStatusAttr_Departed.isItalic := true;
  g.qStatusAttr_Departed.isUnderline := false;
  g.qStatusAttr_Departed.isStrikeOut := false;
end;

procedure Td.Default_StatusAttr_Departing;
begin
  g.qStatusAttr_Departing.backgroundColor := clGray;
  g.qStatusAttr_Departing.fontColor := clWhite;
  g.qStatusAttr_Departing.isBold := false;
  g.qStatusAttr_Departing.isItalic := true;
  g.qStatusAttr_Departing.isUnderline := false;
  g.qStatusAttr_Departing.isStrikeOut := false;
end;

procedure Td.Default_StatusAttr_GuestLeavingNextDay;
begin
  g.qStatusAttr_GuestLeavingNextDay.backgroundColor := clGreen;
  g.qStatusAttr_GuestLeavingNextDay.fontColor := clWhite;
  g.qStatusAttr_GuestLeavingNextDay.isBold := false;
  g.qStatusAttr_GuestLeavingNextDay.isItalic := false;
  g.qStatusAttr_GuestLeavingNextDay.isUnderline := false;
  g.qStatusAttr_GuestLeavingNextDay.isStrikeOut := false;
end;

procedure Td.Default_StatusAttr_GuestStaying;
begin
  g.qStatusAttr_GuestStaying.backgroundColor := clBlue;
  g.qStatusAttr_GuestStaying.fontColor := clWhite;
  g.qStatusAttr_GuestStaying.isBold := false;
  g.qStatusAttr_GuestStaying.isItalic := false;
  g.qStatusAttr_GuestStaying.isUnderline := false;
  g.qStatusAttr_GuestStaying.isStrikeOut := false;
end;

procedure Td.Default_StatusAttr_ArrivingOtherLeaving;
begin
  g.qStatusAttr_ArrivingOtherLeaving.backgroundColor := clAqua;
  g.qStatusAttr_ArrivingOtherLeaving.fontColor := clBlack;
  g.qStatusAttr_ArrivingOtherLeaving.isBold := false;
  g.qStatusAttr_ArrivingOtherLeaving.isItalic := false;
  g.qStatusAttr_ArrivingOtherLeaving.isUnderline := false;
  g.qStatusAttr_ArrivingOtherLeaving.isStrikeOut := false;
end;

procedure Td.Default_StatusAttr_Order;
begin
  g.qStatusAttr_Order.backgroundColor := clRed;
  g.qStatusAttr_Order.fontColor := clWhite;
  g.qStatusAttr_Order.isBold := true;
  g.qStatusAttr_Order.isItalic := false;
  g.qStatusAttr_Order.isUnderline := false;
  g.qStatusAttr_Order.isStrikeOut := false;
end;


procedure Td.Default_StatusAttr_canceled;
begin
  g.qStatusAttr_Canceled.backgroundColor := clBlack;
  g.qStatusAttr_Canceled.fontColor := clSilver;
  g.qStatusAttr_Canceled.isBold := false;
  g.qStatusAttr_Canceled.isItalic := false;
  g.qStatusAttr_Canceled.isUnderline := false;
  g.qStatusAttr_Canceled.isStrikeOut := false;
end;

procedure Td.Default_StatusAttr_tmp1;
begin
  g.qStatusAttr_Tmp1.backgroundColor := clPurple;
  g.qStatusAttr_Tmp1.fontColor := clWhite;
  g.qStatusAttr_Tmp1.isBold := false;
  g.qStatusAttr_Tmp1.isItalic := false;
  g.qStatusAttr_Tmp1.isUnderline := false;
  g.qStatusAttr_Tmp1.isStrikeOut := false;
end;

procedure Td.Default_StatusAttr_tmp2;
begin
  g.qStatusAttr_Tmp2.backgroundColor := clFuchsia;
  g.qStatusAttr_Tmp2.fontColor := clBlack;
  g.qStatusAttr_Tmp2.isBold := false;
  g.qStatusAttr_Tmp2.isItalic := false;
  g.qStatusAttr_Tmp2.isUnderline := false;
  g.qStatusAttr_Tmp2.isStrikeOut := false;
end;


//-------------------------------------------------------------------------------

procedure Td.Get_All_StatusAttributes;
var sTmp : String;
    Rset : TRoomerDataSet;
begin
  sTmp := 'SELECT StatusAttr_Blocked, StatusAttr_GuestStaying, StatusAttr_GuestLeavingNextDay, ' +
          'StatusAttr_Departed, StatusAttr_Departing, StatusAttr_Allotment, StatusAttr_Waitinglist, ' +
          'StatusAttr_NoShow, StatusAttr_ArrivingOtherLeaving, StatusAttr_Order, StatusAttr_Canceled, StatusAttr_Tmp1,StatusAttr_Tmp2 FROM control';
  RSet := glb.ControlSet; // CreateNewDataSet;
  RSet.first;
  try
//    if hData.rSet_bySQL(rSet,sTmp) then
//	  begin
      g.qStatusAttr_Blocked := g.strToStatusAttr(trim(Rset.FieldByName('StatusAttr_Blocked').AsString));
      g.qStatusAttr_GuestStaying := g.strToStatusAttr(trim(Rset.FieldByName('StatusAttr_GuestStaying').AsString));
      g.qStatusAttr_GuestLeavingNextDay := g.strToStatusAttr(trim(Rset.FieldByName('StatusAttr_GuestLeavingNextDay').AsString));
      g.qStatusAttr_Departed := g.strToStatusAttr(trim(Rset.FieldByName('StatusAttr_Departed').AsString));
      g.qStatusAttr_Departing := g.strToStatusAttr(trim(Rset.FieldByName('StatusAttr_Departing').AsString));
      g.qStatusAttr_Allotment := g.strToStatusAttr(trim(Rset.FieldByName('StatusAttr_Allotment').AsString));
      g.qStatusAttr_Waitinglist := g.strToStatusAttr(trim(Rset.FieldByName('StatusAttr_Waitinglist').AsString));
      g.qStatusAttr_NoShow := g.strToStatusAttr(trim(Rset.FieldByName('StatusAttr_NoShow').AsString));
      g.qStatusAttr_ArrivingOtherLeaving := g.strToStatusAttr(trim(Rset.FieldByName('StatusAttr_ArrivingOtherLeaving').AsString));
      g.qStatusAttr_Order := g.strToStatusAttr(trim(Rset.FieldByName('StatusAttr_Order').AsString));
      g.qStatusAttr_Canceled := g.strToStatusAttr(trim(Rset.FieldByName('StatusAttr_Canceled').AsString));
      g.qStatusAttr_Tmp1 := g.strToStatusAttr(trim(Rset.FieldByName('StatusAttr_Tmp1').AsString));
      g.qStatusAttr_Tmp2 := g.strToStatusAttr(trim(Rset.FieldByName('StatusAttr_Tmp2').AsString));

//    end;
  finally
//    freeandnil(Rset);
  end;

end;

//procedure TD.Get_StatusAttr_Blocked;
//var
//  sTmp : string;
//begin
//  sTmp := '';
//  g.initStatusAttrRec(g.qStatusAttr_Blocked);
//  try
//    sTmp := ctrlGetString('StatusAttr_Blocked');
//  Except
//  end;
//  if sTmp <> '' then
//  begin
//    g.qStatusAttr_Blocked := g.strToStatusAttr(sTmp);
//  end else
//  begin
//    default_StatusAttr_Blocked;
//  end;
//end;
//
//procedure TD.Get_StatusAttr_NoShow;
//var
//  sTmp : string;
//begin
//  sTmp := '';
//  g.initStatusAttrRec(g.qStatusAttr_NoShow);
//  try
//    sTmp := ctrlGetString('StatusAttr_NoShow');
//  Except
//  end;
//  if sTmp <> '' then
//  begin
//    g.qStatusAttr_NoShow := g.strToStatusAttr(sTmp);
//  end else
//  begin
//    default_StatusAttr_NoShow;
//  end;
//end;
//
//procedure TD.Get_StatusAttr_Waitinglist;
//var
//  sTmp : string;
//begin
//  sTmp := '';
//  g.initStatusAttrRec(g.qStatusAttr_Waitinglist);
//  try
//    sTmp := ctrlGetString('StatusAttr_Waitinglist');
//  Except
//  end;
//  if sTmp <> '' then
//  begin
//    g.qStatusAttr_Waitinglist := g.strToStatusAttr(sTmp);
//  end else
//  begin
//    default_StatusAttr_Waitinglist;
//  end;
//end;
//
//procedure TD.Get_StatusAttr_Allotment;
//var
//  sTmp : string;
//begin
//  sTmp := '';
//  g.initStatusAttrRec(g.qStatusAttr_Allotment);
//  try
//    sTmp := ctrlGetString('StatusAttr_Allotment');
//  Except
//  end;
//  if sTmp <> '' then
//  begin
//    g.qStatusAttr_Allotment := g.strToStatusAttr(sTmp);
//  end else
//  begin
//    default_StatusAttr_Allotment;
//  end;
//end;
//
//procedure TD.Get_StatusAttr_Departed;
//var
//  sTmp : string;
//begin
//  sTmp := '';
//  g.initStatusAttrRec(g.qStatusAttr_Departed);
//  try
//    sTmp := ctrlGetString('StatusAttr_Departed');
//  Except
//  end;
//  if sTmp <> '' then
//  begin
//    g.qStatusAttr_Departed := g.strToStatusAttr(sTmp);
//  end else
//  begin
//    default_StatusAttr_Departed;
//  end;
//end;
//
//procedure TD.Get_StatusAttr_Departing;
//var
//  sTmp : string;
//begin
//  sTmp := '';
//  g.initStatusAttrRec(g.qStatusAttr_Departing);
//  try
//    sTmp := ctrlGetString('StatusAttr_Departing');
//  Except
//  end;
//  if sTmp <> '' then
//  begin
//    g.qStatusAttr_Departing := g.strToStatusAttr(sTmp);
//  end else
//  begin
//    default_StatusAttr_Departing;
//  end;
//end;
//
//procedure TD.Get_StatusAttr_GuestLeavingNextDay;
//var
//  sTmp : string;
//begin
//  sTmp := '';
//  g.initStatusAttrRec(g.qStatusAttr_GuestLeavingNextDay);
//  try
//    sTmp := ctrlGetString('StatusAttr_GuestLeavingNextDay');
//  Except
//  end;
//  if sTmp <> '' then
//  begin
//    g.qStatusAttr_GuestLeavingNextDay := g.strToStatusAttr(sTmp);
//  end else
//  begin
//    default_StatusAttr_GuestLeavingNextDay;
//  end;
//end;
//
//procedure TD.Get_StatusAttr_GuestStaying;
//var
//  sTmp : string;
//begin
//  sTmp := '';
//  g.initStatusAttrRec(g.qStatusAttr_GuestStaying);
//  try
//    sTmp := ctrlGetString('StatusAttr_GuestStaying');
//  Except
//  end;
//  if sTmp <> '' then
//  begin
//    g.qStatusAttr_GuestStaying := g.strToStatusAttr(sTmp);
//  end else
//  begin
//    default_StatusAttr_GuestStaying;
//  end;
//end;
//
//procedure TD.Get_StatusAttr_ArrivingOtherLeaving;
//var
//  sTmp : string;
//begin
//  sTmp := '';
//  g.initStatusAttrRec(g.qStatusAttr_ArrivingOtherLeaving);
//  try
//    sTmp := ctrlGetString('StatusAttr_ArrivingOtherLeaving');
//  Except
//  end;
//  if sTmp <> '' then
//  begin
//    g.qStatusAttr_ArrivingOtherLeaving := g.strToStatusAttr(sTmp);
//  end else
//  begin
//    default_StatusAttr_ArrivingOtherLeaving;
//  end;
//end;
//
//procedure TD.Get_StatusAttr_Order;
//var
//  sTmp : string;
//begin
//  sTmp := '';
//  g.initStatusAttrRec(g.qStatusAttr_Order);
//  try
//    sTmp := ctrlGetString('StatusAttr_Order');
//  Except
//  end;
//  if sTmp <> '' then
//  begin
//    g.qStatusAttr_Order := g.strToStatusAttr(sTmp);
//  end else
//  begin
//    default_StatusAttr_Order;
//  end;
//end;

//-------------------------------------------------------------------

procedure Td.save_StatusAttr_Blocked;
var
  s : string;
  sTmp : string;
begin
  sTmp := g.StatusAttrToStr(g.qStatusAttr_Blocked);
  s := '';
  s := s + ' UPDATE control '+chr(10);
  s := s + ' SET '+chr(10);
  s := s + '  StatusAttr_Blocked = ' + _db(sTmp)+chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

procedure Td.save_StatusAttr_NoShow;
var
  s : string;
  sTmp : string;
begin
  sTmp := g.StatusAttrToStr(g.qStatusAttr_NoShow);
  s := '';
  s := s + ' UPDATE control '+chr(10);
  s := s + ' SET '+chr(10);
  s := s + '  StatusAttr_NoShow = ' + _db(sTmp)+chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

procedure Td.save_StatusAttr_Waitinglist;
var
  s : string;
  sTmp : string;
begin
  sTmp := g.StatusAttrToStr(g.qStatusAttr_WaitingList);
  s := '';
  s := s + ' UPDATE control '+chr(10);
  s := s + ' SET '+chr(10);
  s := s + '  StatusAttr_WaitingList = ' + _db(sTmp)+chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

procedure Td.save_StatusAttr_Allotment;
var
  s : string;
  sTmp : string;
begin
  sTmp := g.StatusAttrToStr(g.qStatusAttr_Allotment);
  s := '';
  s := s + ' UPDATE control '+chr(10);
  s := s + ' SET '+chr(10);
  s := s + '  StatusAttr_Allotment = ' + _db(sTmp)+chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

procedure Td.save_StatusAttr_Departed;
var
  s : string;
  sTmp : string;
begin
  sTmp := g.StatusAttrToStr(g.qStatusAttr_Departed);
  s := '';
  s := s + ' UPDATE control '+chr(10);
  s := s + ' SET '+chr(10);
  s := s + '  StatusAttr_Departed = ' + _db(sTmp)+chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

procedure Td.save_StatusAttr_Departing;
var
  s    : string;
  sTmp : string;
begin
  sTmp := g.StatusAttrToStr(g.qStatusAttr_Departing);

  s := '';
  s := s + ' UPDATE control '+chr(10);
  s := s + ' SET '+chr(10);
  s := s + '  StatusAttr_Departing = ' + _db(sTmp)+chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

procedure Td.Save_StatusAttr_GuestLeavingNextDay;
var
  s : string;
  sTmp : string;
begin
  sTmp := g.StatusAttrToStr(g.qStatusAttr_GuestLeavingNextDay);
  s := '';
  s := s + ' UPDATE control '+chr(10);
  s := s + ' SET '+chr(10);
  s := s + '  StatusAttr_GuestLeavingNextDay = ' + _db(sTmp)+chr(10);
  if not cmd_bySQL(s) then
  begin
  end;

end;

procedure Td.Save_StatusAttr_GuestStaying;
var
  s : string;
  sTmp : string;
begin
  sTmp := g.StatusAttrToStr(g.qStatusAttr_GuestStaying);
  s := '';
  s := s + ' UPDATE control '+chr(10);
  s := s + ' SET '+chr(10);
  s := s + '  StatusAttr_GuestStaying = ' + _db(sTmp)+chr(10);
  if not cmd_bySQL(s) then
  begin
  end;

end;

procedure Td.save_StatusAttr_ArrivingOtherLeaving;
var
  s : string;
  sTmp : string;
begin
  sTmp := g.StatusAttrToStr(g.qStatusAttr_ArrivingOtherLeaving);

  s := '';
  s := s + ' UPDATE control '+chr(10);
  s := s + ' SET '+chr(10);
  s := s + '  StatusAttr_ArrivingOtherLeaving = ' + _db(sTmp)+chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

procedure Td.save_StatusAttr_Order;
var
  s : string;
  sTmp : string;
begin
  sTmp := g.StatusAttrToStr(g.qStatusAttr_Order);

  s := '';
  s := s + ' UPDATE control '+chr(10);
  s := s + ' SET '+chr(10);
  s := s + '  StatusAttr_Order = ' + _db(sTmp)+chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;


procedure Td.save_StatusAttr_Canceled;
var
  s : string;
  sTmp : string;
begin
  sTmp := g.StatusAttrToStr(g.qStatusAttr_Canceled);

  s := '';
  s := s + ' UPDATE control '+chr(10);
  s := s + ' SET '+chr(10);
  s := s + '  StatusAttr_canceled = ' + _db(sTmp)+chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;


procedure Td.save_StatusAttr_Tmp1;
var
  s : string;
  sTmp : string;
begin
  sTmp := g.StatusAttrToStr(g.qStatusAttr_Tmp1);

  s := '';
  s := s + ' UPDATE control '+chr(10);
  s := s + ' SET '+chr(10);
  s := s + '  StatusAttr_tmp1 = ' + _db(sTmp)+chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;


procedure Td.save_StatusAttr_Tmp2;
var
  s : string;
  sTmp : string;
begin
  sTmp := g.StatusAttrToStr(g.qStatusAttr_Tmp2);

  s := '';
  s := s + ' UPDATE control '+chr(10);
  s := s + ' SET '+chr(10);
  s := s + '  StatusAttr_Tmp2 = ' + _db(sTmp)+chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;


//---------------------------------------------------------------------------------

  function Td.RV_Upd_Name(Res : integer; newName : string) : boolean;
  var
    s : string;
  begin
    result := true;

    //ATHOLD 091120  Setja inn Rollback

    s := '';
    s := s + ' UPDATE reservations '+chr(10);
    s := s + ' SET '+chr(10);
    s := s + ' [Name] = ' + _db(newName) + ' '+chr(10);
    s := s + ' WHERE Reservation = ' + inttostr(Res) + ' '+chr(10);
    if not cmd_bySQL(s) then
    begin
      result := false;
    end;

    s := '';
    s := s + ' UPDATE persons '+chr(10);
    s := s + ' SET '+chr(10);
    s := s + ' [Surname] = ' + _db(newName) + ' '+chr(10);
    s := s + ' WHERE Reservation = ' + inttostr(Res) + ' '+chr(10);
    if not cmd_bySQL(s) then
    begin
      result := false;
    end;
  end;

  function Td.RR_Upd_CurrencyRoomPrice(iRoomReservation : integer;aDate:string;Currency : string; Convert : double) : boolean;
  var
    rSet     : TRoomerDataSet;
    s        : string;
    roomRate : double;
    Discount : double;
    isPercentage : boolean;
    paid         : boolean;
    sql : string;
  begin
    result    := false;
    if iRoomReservation < 1 then exit;

    rSet := CreateNewDataSet;
    try



      sql :=
      'SELECT '#10+
      '  roomreservation '#10+
      ' ,Currency '#10+
      ' ,roomRate '#10+
      ' ,Discount '#10+
      ' ,isPercentage '#10+
      ' ,paid '#10+
      'FROM '#10+
      '  roomsdate '#10+
      'WHERE '#10+
      '  (paid=0) AND (roomreservation=%d) and (aDate=%s) '#10+
      '   AND (ResFlag <> '+_db(STATUS_DELETED)+' ) '#10;  //**zxhj bætt við

      s := format(sql , [iRoomReservation,_db(aDate)]);
      if hData.rSet_bySQL(rSet,s) then
      begin
        roomRate      := rSet.GetFloatValue(rSet.FieldByName('roomRate'    )) ;
        Discount      := rSet.GetFloatValue(rSet.FieldByName('Discount'    )) ;
        isPercentage  := rSet.FieldByName('isPercentage').AsBoolean ;
        paid          := rSet.FieldByName('paid'        ).AsBoolean ;
        if  not paid then
        begin
          roomRate := roomRate*Convert;

          if not isPercentage then discount := discount*convert;
          s := '';
          s := s + ' UPDATE roomsdate '#10;
          s := s + ' SET '#10;
          s := s + '  Currency='+ _db(Currency) + ' '#10;
          s := s + ' ,roomRate='+ _db(Roomrate) + ' '#10;
          s := s + ' ,Discount='+ _db(Discount) + ' '#10;
          s := s + ' WHERE '#10;
          s := s + '   (RoomReservation = ' + inttostr(iRoomReservation)+') '#10;
          s := s + ' AND (Adate='+_db(aDate)+') ';
          s := s + ' AND (ResFlag <> '+_db(STATUS_DELETED)+' ) '#10; ////**zxhj bætt við

          if not cmd_bySQL(s) then
          begin
          end;
          Result := true;
        end;
      end;
    finally
      freeandNil(rSet);
    end;
  end;


  function Td.RR_Upd_MemoTexts(iRoomReservation : integer; HiddenInfo : string) : boolean;
  var
    s : string;
  begin
    result := false;
    if iRoomReservation < 1 then
      exit;
      result := true;
      s := '';
      s := s + ' UPDATE roomreservations '+chr(10);
      s := s + ' SET '+chr(10);
      s := s + ' HiddenInfo=' + _db(HiddenInfo)+' '+chr(10);
      s := s + ' WHERE (roomreservation = ' + inttostr(iRoomReservation) + ') '+chr(10);
      if not cmd_bySQL(s) then
      begin
      end;
  end;



  procedure Td.RR_Upd_FirstGuestName(iRoomReservation : integer; newName : string);
  var
    Rset : TRoomerDataSet;
    s : string;
    aName : string;
  begin
    Rset := CreateNewDataSet;
    try
//      s := s + 'SELECT * '+chr(10);
//      s := s + 'FROM persons '+chr(10);
//      s := s + 'WHERE RoomReservation = ' + inttostr(iRoomReservation)+chr(10);
      s := format(select_RR_Upd_FirstGuestName , [iRoomReservation]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        aName := Rset.fieldbyname('Name').asString;
        Rset.edit;
        Rset.fieldbyname('Name').asString := newName;
        Rset.Post; //ID OK *
      end;
    finally
      freeandnil(Rset);
    end;
  end;


  function Td.RR_Upd_Package(iRoomReservation : integer; Package : string) : boolean;
  var
    s : string;
  begin
    result := false;
    if iRoomReservation < 1 then
      exit;
    s := '';
    s := s + ' UPDATE roomreservations '+chr(10);
    s := s + ' SET '+chr(10);
    s := s + ' Package=' + _db(package)+' '+chr(10);
    s := s + ' WHERE (roomreservation = ' + inttostr(iRoomReservation) + ') '+chr(10);
    result :=  cmd_bySQL(s)
  end;


  function Td.RR_clear_Package(iRoomReservation : integer; Package : string) : boolean;
  var
    s : string;
  begin
    result := false;
    if iRoomReservation < 1 then
      exit;
    s := '';
    s := s + ' UPDATE roomreservations '+chr(10);
    s := s + ' SET '+chr(10);
    s := s + ' Package=' + _db(package)+' '+chr(10);
    s := s + ' WHERE (roomreservation = ' + inttostr(iRoomReservation) + ') '+chr(10);
    result :=  cmd_bySQL(s)
  end;


//**********************************************************



  function Td.RR_GetNumberOfRooms(iReservation : integer) : integer;
  var
    Rset : TRoomerDataSet;
    s : string;
  begin
    result := 0;
    Rset := CreateNewDataSet;
    try
//      s := s + ' SELECT count(RoomReservation) AS Cnt FROM RoomReservations '+chr(10);
//      s := s + ' WHERE Reservation = ' + inttostr(iReservation)+chr(10);
      s := format(select_RR_GetNumberOfRooms , [iReservation]);
      if hData.rSet_bySQL(rSet,s) then
     	begin
        result := Rset.fieldbyname('Cnt').asInteger;
      end;
    finally
      freeandnil(Rset);
    end;
  end;

  function Td.RR_GetGuestCount(iRoomReservation : integer) : integer;
  var
    Rset : TRoomerDataSet;
    s : string;
  begin
    result := 0;
    Rset := CreateNewDataSet;
    try
//      s := s + ' SELECT count(Person) AS Cnt FROM Persons'+chr(10);
//      s := s + ' WHERE  RoomReservation = ' + inttostr(iRoomReservation)+chr(10);
      s := format(select_RR_GetGuestCount, [iRoomReservation]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        result := Rset.fieldbyname('Cnt').asInteger;
      end;
    finally
      freeandnil(Rset);
    end;
  end;

  function Td.RR_GetRoomNr(iRoomReservation : integer) : string;
  var
    Rset : TRoomerDataSet;
    s : string;
  begin
    result := '';
    Rset := CreateNewDataSet;
    try
//      s := s + 'SELECT Room FROM RoomReservations'+chr(10);
//      s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation)+chr(10);
      s := format(select_RR_GetRoomNr , [iRoomReservation]);
      if hData.rSet_bySQL(rSet,s) then
  	  begin
        result := Rset.fieldbyname('room').asString;
      end;
    finally
      freeandnil(Rset);
    end;
  end;

  function Td.RR_GetRoomArrivalAndDeparture(iRoomReservation : integer; var Room : String; var Arrival, Departure : TDateTime) : boolean;
  var
    Rset : TRoomerDataSet;
    s : string;
  begin
    result := false;
    Rset := CreateNewDataSet;
    try
//      s := s + 'SELECT Room FROM RoomReservations'+chr(10);
//      s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation)+chr(10);
      s := 'SELECT roomres.Room, ' +
                  '(SELECT ADate FROM roomsdate WHERE RoomReservation=rr.RoomReservation ORDER BY ADate LIMIT 1) AS Arrival, ' +
                  'DATE_ADD((SELECT ADate FROM roomsdate WHERE RoomReservation=rr.RoomReservation ORDER BY ADate DESC LIMIT 1), INTERVAL 1 DAY) AS Departure ' +
                  'FROM roomreservations roomres, ' +
                  '(SELECT ' + inttostr(iRoomReservation) + ' AS RoomReservation) rr ' +
                  'WHERE roomres.RoomReservation = rr.RoomReservation';
      if hData.rSet_bySQL(rSet,s) then
  	  begin
        result := true;
        Room := Rset.fieldbyname('room').asString;
        Arrival := uDateUtils.SqlStringToDate(Rset.fieldbyname('Arrival').asString);
        Departure := uDateUtils.SqlStringToDate(Rset.fieldbyname('Departure').asString);
      end;
    finally
      freeandnil(Rset);
    end;
  end;

function Td.RR_GetArrivalDate(iRoomReservation : integer) : Tdate;
var
  Rset : TRoomerDataSet;
  s : string;
begin
  result := Date;
  Rset := CreateNewDataSet;
  try
//    s := s + 'SELECT rrArrival FROM RoomReservations'+chr(10);
//    s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation)+chr(10);
    s := format(select_RR_GetArrivalDate , [iRoomReservation]);
    if hData.rSet_bySQL(rSet,s) then
  	begin
      result := Rset.fieldbyname('rrArrival').asDateTime;
    end;
  finally
    freeandnil(Rset);
  end;
end;


function Td.RR_GetDepartureDate(iRoomReservation : integer) : Tdate;
var
  Rset : TRoomerDataSet;
  s : string;
begin
  result := 1;
  Rset := CreateNewDataSet;
  try
//    s := s + 'SELECT rrDeparture FROM RoomReservations'+chr(10);
//    s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation)+chr(10);
    s := format(select_RR_GetDepartureDate , [iRoomReservation]);
    if hData.rSet_bySQL(rSet,s) then
  	begin
      result := Rset.fieldbyname('rrDeparture').asDateTime;
    end;
  finally
    freeandnil(Rset);
  end;
end;

function Td.RR_getDates(iRoomReservation : integer) : recResDateHolder;
var
  Rset : TRoomerDataSet;
  s : string;
begin
  result.reservation := 0;
  result.RoomReservation := 0;
  result.Arrival := 1;
  result.Departure := 1;
  result.status := '';

  Rset := CreateNewDataSet;
  try
//    s := s + ' SELECT '+chr(10);
//    s := s + '   Reservation '+chr(10);
//    s := s + ' , Status '+chr(10);
//    s := s + ' , rrArrival '+chr(10);
//    s := s + ' , rrDeparture '+chr(10);
//    s := s + ' FROM RoomReservations '+chr(10);
//    s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation) + ' '+chr(10);
    s := format(select_RR_getDates , [iRoomReservation]);
    if hData.rSet_bySQL(rSet,s) then
  	begin
      result.Arrival := Rset.fieldbyname('rrArrival').asDateTime;
      result.Departure := Rset.fieldbyname('rrDeparture').asDateTime;
      result.RoomReservation := iRoomReservation;
      result.reservation := Rset.fieldbyname('Reservation').asInteger;
      result.status := Rset.fieldbyname('Status').asString;
    end;
  finally
    freeandnil(Rset);
  end;
end;


function Td.RV_getDates(iReservation : integer) : recResDateHolder;
var
  Rset : TRoomerDataSet;

  s : string;
begin
  result.reservation := 0;
  result.RoomReservation := 0;
  result.Arrival := 1;
  result.Departure := 1;
  result.status := '';

  Rset := CreateNewDataSet;
  try
//    s := s + ' SELECT '+chr(10);
//    s := s + '   Reservation '+chr(10);
//    s := s + ' ,  Arrival '+chr(10);
//    s := s + ' ,  Departure '+chr(10);
//    s := s + ' FROM Reservations '+chr(10);
//    s := s + ' WHERE Reservation = ' + _db(iReservation) + ' '+chr(10);
    s := format(select_RV_getDates , [iReservation]);
    if hData.rSet_bySQL(rSet,s) then
  	begin
      s := Rset.fieldbyname('Arrival').asString;
      result.Arrival := _DBDateToDate(s);
      s := Rset.fieldbyname('Departure').asString;
      result.Departure := _DBDateToDate(s);
      result.RoomReservation := -1;
      result.reservation := iReservation;
      result.status := '';
    end;
  finally
    freeandnil(Rset);
  end;
end;

function Td.RR_GetReservationName(iRoomReservation : integer) : string;
var
  Rset : TRoomerDataSet;
  s : string;
begin
  result := '';
  Rset := CreateNewDataSet;
  try
    s := '';
//    s := s + ' SELECT '+chr(10);
//    s := s + '   reservations.[Name] '+chr(10);
//    s := s + ' FROM  Reservations '+chr(10);
//    s := s + '           INNER JOIN '+chr(10);
//    s := s + '              RoomReservations ON Reservations.Reservation = RoomReservations.Reservation '+chr(10);
//    s := s + ' WHERE '+chr(10);
//    s := s + '   (RoomReservations.RoomReservation = ' + inttostr(iRoomReservation) + ' ) '+chr(10);
    s := format(select_RR_GetReservationName , [iRoomReservation]);
    if hData.rSet_bySQL(rSet,s) then
  	begin
      result := Rset.fieldbyname('Name').asString;
    end
    finally
      freeandnil(Rset);
    end;
  end;

  function Td.RR_GetMemoText(iRoomReservation : integer; var RoomNotes : string; fieldName : String = 'HiddenInfo') : boolean;
  var
    s : string;
   rSet : TRoomerDataSet;
begin
  result := false;
  RoomNotes := '';

  rSet := CreateNewDataSet;
  try
    s := format(select_RR_GetMemoText, [iRoomReservation]);
    copyToClipboard(s);

    if hData.rSet_bySQL(rSet,s) then
    begin
      RoomNotes := rSet[fieldName];
      result := true;
    end;
  finally
    freeandNil(rSet);
  end;
end;

  function Td.RR_GetMemoBothTextForRoom(iRoomReservation : integer; var RoomNotes, ChannelRequest : string) : boolean;
  var
    s : string;
   rSet : TRoomerDataSet;
begin
  result := false;
  RoomNotes := '';
  ChannelRequest := '';

  rSet := CreateNewDataSet;
  try
    s := format(select_RR_GetMemoText, [iRoomReservation]);
    copyToClipboard(s);

    if hData.rSet_bySQL(rSet,s) then
    begin
      RoomNotes := rSet['HiddenInfo'];
      ChannelRequest := rSet['PMInfo'];
      result := true;
    end;
  finally
    freeandNil(rSet);
  end;
end;




  function Td.RR_GetFirstGuestName(iRoomReservation : integer) : string;
  var
    Rset : TRoomerDataSet;
    s : string;
  begin
    result := '';

    Rset := CreateNewDataSet;
    try
//      s := s + ' SELECT '+chr(10);
//      s := s + '   [Name] '+chr(10);
//      s := s + ' FROM '+chr(10);
//      s := s + '   PERSONS '+chr(10);
//      s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation)+chr(10);
      s := format(select_RR_GetFirstGuestName , [iRoomReservation]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        result := Rset.fieldbyname('Name').asString;
      end;
    finally
      freeandnil(Rset);
    end;
  end;


  function Td.RR_GetAllGuestNames(iRoomReservation : integer; showAll : boolean=true; showTotal : boolean=true) : string;
  var
    Rset : TRoomerDataSet;
    s : string;
    i : integer;
  begin
    result := '';

    Rset := CreateNewDataSet;
    try
//      s := s + ' SELECT '+chr(10);
//      s := s + '   [Name] '+chr(10);
//      s := s + ' FROM '+chr(10);
//      s := s + '   PERSONS '+chr(10);
//      s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation)+chr(10);
      s := format(select_RR_GetAllGuestNames , [iRoomReservation]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        i := 0;
        while not Rset.Eof do
        begin
          inc(i);
          result := result+Rset.fieldbyname('Name').asString;
          if not showAll then break;
          Rset.Next;
          if rSet.eof then
          begin
            result := result+'.';
            if showTotal then
            begin
              result := result+' Total '+inttostr(i)+' guests ';
            end;
          end else
          begin
            result := result+', ';
          end;
        end;
      end;
    finally
      freeandnil(Rset);
    end;
  end;


  function Td.RR_GetLastGuestID(iRoomReservation : integer) : integer;
  var
    Rset : TRoomerDataSet;
    s : string;
  begin
    result := 0;
    Rset := CreateNewDataSet;
    try
//      s := s + ' SELECT '+chr(10);
//      s := s + '   [Person] '+chr(10);
//      s := s + ' FROM '+chr(10);
//      s := s + '   PERSONS '+chr(10);
//      s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation)+chr(10);
//      s := s + ' ORDER BY Person '+chr(10);
      s := format(select_RR_GetLastGuestID , [iRoomReservation]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        result := Rset.fieldbyname('Person').asInteger;
      end;
    finally
      freeandnil(Rset);
    end;
  end;

  function Td.RR_GetFirstGuestCountry(iRoomReservation : integer) : string;
  var
    Rset : TRoomerDataSet;
    s : string;
  begin
    result := '';
    Rset := CreateNewDataSet;
    try
//      s := s + ' SELECT '+chr(10);
//      s := s + '   [Country] '+chr(10);
//      s := s + ' FROM '+chr(10);
//      s := s + '   PERSONS '+chr(10);
//      s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation)+chr(10);
      s := format(select_RR_GetFirstGuestCountry , [iRoomReservation]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        result := Rset.fieldbyname('Country').asString;
      end;
    finally
      freeandnil(Rset);
    end;
  end;

  function Td.RR_GetFirstGuestType(iRoomReservation : integer) : string;
  var
    Rset : TRoomerDataSet;
    s : string;
  begin
    result := '';

    Rset := CreateNewDataSet;
    try
//      s := s + ' SELECT '+chr(10);
//      s := s + '   [GuestType] '+chr(10);
//      s := s + ' FROM '+chr(10);
//      s := s + '   PERSONS '+chr(10);
//      s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation)+chr(10);
      s := format(select_RR_GetFirstGuestType, [iRoomReservation]);
      if hData.rSet_bySQL(rSet,s) then
     	begin
        result := Rset.fieldbyname('GuestType').asString;
      end;
    finally
      freeandnil(Rset);
    end;
  end;


  function Td.RR_Upd_GuestCount(iRoomReservation, NewCount : integer) : boolean;
  var
    oldCount : integer;
    addCount : integer; // +tala Bæta við -Tala eyða
    sCountry : string;

    i : integer;

    GuestInfo : recCustomerHolderEX;
    iReservation : integer;
    sType : string;

  begin
    result := false;
    if NewCount < 1 then
      exit;

    oldCount := RR_GetGuestCount(iRoomReservation);

    addCount := NewCount - oldCount;

    if addCount = 0 then
      exit;

    if addCount > 0 then
    begin
      sCountry := RR_GetFirstGuestCountry(iRoomReservation);
      iReservation := RR_GetReservation(iRoomReservation);
      sType := RR_GetFirstGuestType(iRoomReservation);

      GuestInfo.CustomerName := RR_GetReservationName(iRoomReservation);
      GuestInfo.DisplayName := 'RoomGuest';
      GuestInfo.PID := '';
      GuestInfo.Address1 := '';
      GuestInfo.Address2 := '';
      GuestInfo.Address3 := '';
      GuestInfo.Address4 := '';
      GuestInfo.Country := sCountry;
      GuestInfo.Tel1 := '';
      GuestInfo.Tel2 := '';
      GuestInfo.Fax := '';
      GuestInfo.EmailAddress := '';
      GuestInfo.CustMemoText := '';

      for i := 1 to addCount do
      begin
        AddPerson(iRoomReservation, iReservation, GuestInfo, sType, true);
      end;
    end
    else
    begin
      addCount := abs(addCount);
      for i := 1 to addCount do
      begin
        RemovePerson(iRoomReservation, true);
      end;
    end;
  end;

  function Td.RR_GetStatus(iRoomReservation : integer) : string;
  var
    Rset : TRoomerDataSet;
    s : string;
  begin
    result := '';
    Rset := CreateNewDataSet;
    try
      s := '';
//      s := s + 'SELECT status '+chr(10);
//      s := s + 'FROM RoomReservations '+chr(10);
//      s := s + 'WHERE RoomReservation = ' + inttostr(iRoomReservation)+chr(10);
      s := format(select_RR_GetStatus , [iRoomReservation]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        result := Rset.fieldbyname('Status').asString;
      end;
    finally
      freeandnil(Rset);
    end;
  end;

  function Td.RR_GetIsGroopAccount(iRoomReservation : integer) : boolean;
  var
    Rset : TRoomerDataSet;
    s : string;
  begin
    result := false;
    Rset := CreateNewDataSet;
    try
//      s := s + 'SELECT GroupAccount '+chr(10);
//      s := s + 'FROM RoomReservations '+chr(10);
//      s := s + 'WHERE RoomReservation = ' + inttostr(iRoomReservation)+chr(10);
      s := format(select_RR_GetIsGroopAccount , [iRoomReservation]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        result := Rset['GroupAccount'];
      end;
    finally
      freeandnil(Rset);
    end;
  end;


function Td.RR_FirstDayAndRoom(RoomReservation : integer; var Room : string) : Tdate;
  var
    rSet : TRoomerDataSet;
    s : string;
    sql : string;
  begin
    Result := 1;
    room := '';
    Rset := CreateNewDataSet;
    try

      sql :=
      'SELECT '#10+
      '     Room '#10+
      '   , RoomReservation '#10+
      '   , ADate '#10+
      ' FROM '#10+
      '   roomsdate '#10+
      ' WHERE '#10+
      '   (RoomReservation = %d) '#10+
      '   AND (ResFlag <> '+_db(STATUS_DELETED)+' ) '#10+ //**zxhj line added
      ' ORDER BY ADate '#10 +
      ' LIMIT 1 ';
      s := format(sql , [RoomReservation]);

      if hData.rSet_bySQL(rSet,s) then
    	begin
        result := _DBDateToDate(rSet.FieldByName('aDate').AsString);
        room := rSet.FieldByName('room').AsString;
      end;
    finally
       freeAndNil(rSet);
    end;
  end;

function td.RV_FirstDayAndRoom(Reservation : integer; var Room : string) : Tdate;
  var
    rSet : TRoomerDataSet;
    s : string;
    sql : string;
  begin
    Result := 1;
    room := '';
    Rset := CreateNewDataSet;
    try
      sql :=
      'SELECT '+
      '     Room '+
      '   , Reservation '+
      '   , ADate '+
      ' FROM '+
      '   roomsdate '+
      ' WHERE '+
      '   (Reservation = %d) '+
      '   AND (ResFlag <> '+_db(STATUS_DELETED)+' ) '+ //**zxhj line added
      ' ORDER BY ADate, room '+
      ' LIMIT 1 ';


      s := format(sql , [Reservation]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        result := _DBDateToDate(rSet.FieldByName('aDate').AsString);
        room := rSet.FieldByName('room').AsString;
      end;
    finally
       freeAndNil(rSet);
    end;
  end;


  function Td.Ref_FirstDayAndRoom(ref : string; var Room : string) : Tdate;
  var
    rSet : TRoomerDataSet;
    s : string;
    res : integer;
  begin
    res := 0;

    Rset := CreateNewDataSet;
    try
      s := '';
      s := s+' SELECT '#10;
      s := s+'     reservation '#10;
      s := s+'   , invRefrence '#10;
      s := s+' FROM '#10;
      s := s+'   reservations '#10;
      s := s+' WHERE ';
      s := s+'   (invRefrence = %s) '#10;
      s := s+'   AND (ResFlag <> '+_db(STATUS_DELETED)+' ) '; //**zxhj line added
      s := s+' LIMIT 1 ';
      s := format(s , [Ref]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        res := rSet.FieldByName('Reservation').AsInteger;
      end;
    finally
       freeAndNil(rSet);
    end;


    Result := 1;
    room := '';

    if res = 0 then exit;


    Rset := CreateNewDataSet;
    try
      s := '';
      s := s+' SELECT ';
      s := s+'     Room ';
      s := s+'   , Reservation ';
      s := s+'   , ADate ';
      s := s+' FROM ';
      s := s+'   roomsdate ';
      s := s+' WHERE ';
      s := s+'   (Reservation = %d) ';
      s := s+'   AND (ResFlag <> '+_db(STATUS_DELETED)+' ) '#10; ////**zxhj
      s := s+' ORDER BY ADate ';
      s := s+' LIMIT 1 ';
      s := format(s , [res]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        result := _DBDateToDate(rSet.FieldByName('aDate').AsString);
        room := rSet.FieldByName('room').AsString;
      end;
    finally
       freeAndNil(rSet);
    end;
  end;


 function td.RV_getMemos(Reservation : integer; var information, PMinfo : string) : boolean;
  var
    rSet : TRoomerDataSet;
    s : string;
  begin
    Result := false;
    Rset := CreateNewDataSet;
    try
//      s := s + ' SELECT '+chr(10);
//      s := s + '   TOP (1) '+chr(10);
//      s := s + '     information '+chr(10);
//      s := s + '   , PmInfo '+chr(10);
//      s := s + ' FROM '+chr(10);
//      s := s + '   Reservations '+chr(10);
//      s := s + ' WHERE '+chr(10);
//      s := s + '   (Reservation = '+_dbInt(Reservation)+') '+chr(10);

      s := format(select_RV_getMemos , [Reservation]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        information := rSet.FieldByName('information').AsString;
        PMinfo := rSet.FieldByName('PMinfo').AsString;
        result := true;
      end;
    finally
       freeAndNil(rSet);
    end;
  end;


  function td.INV_FirstDayAndRoom(invoiceNumber : integer; var Room : string; var InvoiceKind : integer) : Tdate;
  var
    rSet            : TRoomerDataSet;
    s               : string;
    reservation     : integer;
    roomreservation : integer;
  begin
    invoiceKind := 0;
    Result := 1;
    room := '';
    Rset := CreateNewDataSet;
    try
      s := format(select_INV_FirstDayAndRoom , [invoiceNumber]);

      if hData.rSet_bySQL(rSet,s) then
    	begin
        reservation := rSet.FieldByName('reservation').asInteger;
        roomreservation := rSet.FieldByName('RoomReservation').asInteger;

        if RoomReservation <> 0 then
        begin
          // herbergjareikningur
          invoiceKind := 1;
          result := RR_FirstDayAndRoom(RoomReservation,Room);
        end else
        if Reservation <> 0 then
        begin
          // Hópreikningur
          invoiceKind := 2;
          result := RV_FirstDayAndRoom(Reservation,Room);
        end else
        begin
          // staðgreiðslureikningur
          invoiceKind := 3;
        end;
      end;
    finally
       freeAndNil(rSet);
    end;
  end;



  function Td.RRlst_FromToUnpaid(DateFrom,DateTo :  Tdate) : tstringList;
  var
    s : string;
    Rset : TRoomerDataSet;
    listItem : integer;

  begin
    result := tstringList.Create;

    Rset := CreateNewDataSet;
    try

      s := s+'  SELECT'+#10;
      s := s+'    DISTINCT'+#10;
      s := s+'    RoomReservation'+#10;
      s := s+'  FROM'+#10;
      s := s+'    roomsdate'+#10;
      s := s+'  WHERE'+#10;
      s := s+'        (ADate >=  %s )'+#10;
      s := s+'    AND (ADate <=  %s )'+#10;
      s := s+'    AND (Paid = 0 )'+#10;
      s := s+'    AND (ResFlag not in ('+_db(STATUS_DELETED)+','+_db(STATUS_CANCELED)+')) '#10; ////**zxhj
      s := s+'  ORDER BY RoomReservation';

//      debugmessage(s);
//      copytoclipboard(s);



      s := format(s , [_DateToDbDate(DateFrom,true),_DateToDbDate(DateTo,true)]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        while not Rset.Eof do
        begin
          listItem := Rset.fieldbyname('RoomReservation').asInteger;
          result.Add(inttostr(listItem));
          Rset.Next;
        end;
      end;
    finally
      freeandnil(Rset);
    end;
  end;




  function Td.RRlst_DepartureNationalReport(DateFrom,DateTo :  Tdate) : tstringList;
  var
    s : string;
    Rset : TRoomerDataSet;
    listItem : integer;

  begin
    result := tstringList.Create;

    Rset := CreateNewDataSet;
    try
      s := format(select_RRlst_DepartureNationalReport , [_DateToDbDate(DateFrom,true),_DateToDbDate(DateTo,true),_db(true)]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        while not Rset.Eof do
        begin
          listItem := Rset.fieldbyname('RoomReservation').asInteger;
          result.Add(inttostr(listItem));
          Rset.Next;
        end;
      end;
    finally
      freeandnil(Rset);
    end;
  end;


  function Td.RRlst_DepartureNationalReportByLocation(DateFrom,DateTo :  Tdate; Location : string) : tstringList;
  var
    s : string;
    Rset : TRoomerDataSet;
    listItem : integer;

  begin

    s := s+'  SELECT'#10;
    s := s+'    DISTINCT'#10;
    s := s+'    RoomReservation'#10;
    s := s+'  FROM'#10;
    s := s+'    roomreservations'#10;
    if Location <> '' then
    begin
      s := s + ' INNER JOIN '+#10;
      s := s + '    rooms ON roomreservations.Room =  rooms.Room '+#10;
      s := s + ' INNER JOIN '+#10;
      s := s + '   locations ON  rooms.Location = locations.Location '+#10;
    end;
    s := s + '  WHERE'+#10;
    s := s + '        (Departure >= %s )'+#10;
    s := s + '    AND (Departure <= %s )'+#10;
    s := s + '    AND (roomreservations.useInNationalReport = 1 )'+#10;
    if Location <> '' then
    begin
      s := s + ' AND (locations.Location in ('+location+') ) '+#10;
    end;
    s := s + '  ORDER BY RoomReservation'+#10;


    result := tstringList.Create;
    Rset := CreateNewDataSet;
    try
      s := format(s , [_DateToDbDate(DateFrom,true),_DateToDbDate(DateTo,true)]);

//      copytoclipboard(s);
//      debugmessage(s);


      if hData.rSet_bySQL(rSet,s) then
	    begin
        while not Rset.Eof do
        begin
          listItem := Rset.fieldbyname('RoomReservation').asInteger;
          result.Add(inttostr(listItem));
          Rset.Next;
        end;
      end;
    finally
      freeandnil(Rset);
    end;
  end;



  function Td.Rvlst_FromToGroup(DateFrom,DateTo :  Tdate) : tstringList;
  var
    s : string;
    Rset : TRoomerDataSet;
    listItem : integer;
  begin
    result := tstringList.Create;

    Rset := CreateNewDataSet;
    try
      s := s + ' SELECT '#10;
      s := s + '   Reservation '#10;
      s := s + '   roomReservation '#10;
      s := s + ' FROM '#10;
      s := s + '   reservations '#10;
      s := s + ' WHERE '#10;
      s := s + '       (Arrival >=  %s ) '#10;
      s := s + '   AND (Arrival <=  %s ) '#10;
      s := s + '   AND (roomreservation=0) '#10;
      s := s + ' ORDER BY Reservation ';

      s := format(s , [_DateToDbDate(DateFrom,true),_DateToDbDate(DateTo,true)]);


      if hData.rSet_bySQL(rSet,s) then
    	begin
        while not Rset.Eof do
        begin
          ListItem := Rset.fieldbyname('Reservation').asInteger;
          result.Add(inttostr(listItem));
          Rset.Next;
        end;
      end;
    finally
      freeandnil(Rset);
    end;
  end;




  function Td.Rvlst_CreatedFromTo(DateFrom,DateTo :  Tdate) : tstringList;
  var
    s : string;
    Rset : TRoomerDataSet;
    listItem : integer;
  begin
    result := tstringList.Create;
    dateTo := DateTo+1;

    s := '';
    s := s+  ' SELECT '#10;
    s := s+  '   DISTINCT'#10;
    s := s+  '   Reservation'#10;
    s := s+  ' FROM'#10;
    s := s+  '   reservations'#10;
    s := s+  ' WHERE'#10;
    s := s+  '       (dtCreated >=  %s )'#10;
    s := s+  '   AND (dtCreated <  %s )'#10;
    s := s+  ' ORDER BY Reservation';

    Rset := CreateNewDataSet;
    try
      s := format(s , [_Db(DateFrom),_Db(DateTo)]);

      if hData.rSet_bySQL(rSet,s) then
    	begin
        while not Rset.Eof do
        begin
          ListItem := Rset.fieldbyname('Reservation').asInteger;
          result.Add(inttostr(listItem));
          Rset.Next;
        end;
      end;
    finally
      freeandnil(Rset);
    end;
  end;

  function Td.Rvlst_Arrival(DateFrom,DateTo :  Tdate; customer : string = '') : tstringList;
  var
    s : string;
    Rset : TRoomerDataSet;
    listItem : integer;
    sql : string;
  begin
    result := tstringList.Create;

    Rset := CreateNewDataSet;
    try
      sql := '';
      sql := sql +'  SELECT'#10;
      sql := sql +'    DISTINCT'#10;
      sql := sql +'    Reservation'#10;
      sql := sql +'  FROM'#10;
      sql := sql +'    reservations'#10;
      sql := sql +'  WHERE'#10;
      sql := sql +'        ((SELECT ADate FROM roomsdate rd WHERE rd.Reservation = reservations.Reservation AND (rd.ResFlag <> '+_db(STATUS_DELETED)+' ) AND (rd.ResFlag <> '+_db(STATUS_CANCELED)+' )  ORDER BY ADate LIMIT 1) >=  %s )'#10;
      sql := sql +'    AND ((SELECT ADate FROM roomsdate rd WHERE rd.Reservation = reservations.Reservation AND (rd.ResFlag <> '+_db(STATUS_DELETED)+' ) AND (rd.ResFlag <> '+_db(STATUS_CANCELED)+' ) ORDER BY ADate LIMIT 1) <=  %s )'#10;
      if customer <> '' then
      begin
        sql := sql +'    AND (customer='+_db(customer)+ ' '#10;
      end;
      sql := sql +'  ORDER BY Reservation';

      s := format(sql , [_DateToDbDate(DateFrom,true),_DateToDbDate(DateTo,true)]);
//    copyToClipboard(s);
//    DebugMessage(s);

      if hData.rSet_bySQL(rSet,s) then
    	begin
        while not Rset.Eof do
        begin
          ListItem := Rset.fieldbyname('Reservation').asInteger;
          result.Add(inttostr(listItem));
          Rset.Next;
        end;
      end;
    finally
      freeandnil(Rset);
    end;
  end;


  function Td.RRlst_Arrival(DateFrom,DateTo :  Tdate) : tstringList;
  var
    s : string;
    Rset : TRoomerDataSet;
    listItem : integer;
    sql : string;
  begin
    result := tstringList.Create;

    Rset := CreateNewDataSet;
    try

      sql :=
      '  SELECT'+
      '    DISTINCT'+
      '    RoomReservation'+
      '  FROM'+
      '    roomreservations'+
      '  WHERE'+
      '        (Arrival >=  %s )'+
      '    AND (Arrival <=  %s )'+
      '    AND (status <> '+_db(STATUS_DELETED)+' ) '+ //**zxhj
      '    AND (status <> '+_db(STATUS_CANCELED)+' ) '+ //**zxhj
      '  ORDER BY RoomReservation';
      s := format(sql , [_DateToDbDate(DateFrom,true),_DateToDbDate(DateTo,true)]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        while not Rset.Eof do
        begin
          listItem := Rset.fieldbyname('RoomReservation').asInteger;
          result.Add(inttostr(listItem));
          Rset.Next;
        end;
      end;
    finally
      freeandnil(Rset);
    end;
  end;


  function Td.GuestListRRlst_Arrival(DateFrom,DateTo :  Tdate;includeNoshow,includeAllotment,includeBlocked : boolean) : tstringList;
  var
    s : string;
    Rset : TRoomerDataSet;
    listItem : integer;
    sql : string;
  begin
    result := tstringList.Create;

    Rset := CreateNewDataSet;
    try

      sql := GetListOfRoomReservationsPerArrivalDate;
      s := format(sql , [_DateToDbDate(DateFrom,true),_DateToDbDate(DateTo,true)]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        while not Rset.Eof do
        begin
          listItem := Rset.fieldbyname('RoomReservation').asInteger;
          result.Add(inttostr(listItem));
          Rset.Next;
        end;
      end;
    finally
      freeandnil(Rset);
    end;
  end;


  function Td.Rvlst_Departure(DateFrom,DateTo :  Tdate) : tstringList;
  var
    s : string;
    Rset : TRoomerDataSet;
    listItem : integer;
    sql : string;
  begin
    result := tstringList.Create;
    Rset := CreateNewDataSet;
    try
      sql :=
      '  SELECT'+
      '    DISTINCT'+
      '    RoomReservation'+
      '  FROM'+
      '    roomreservations'+
      '  WHERE'+
      '        (Departure >=  %s )'+
      '    AND (Departure <=  %s )'+
      '  ORDER BY RoomReservation';

      s := format(sql , [_DateToDbDate(DateFrom,true),_DateToDbDate(DateTo,true)]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        while not Rset.Eof do
        begin
          ListItem := Rset.fieldbyname('Reservation').asInteger;
          result.Add(inttostr(listItem));
          Rset.Next;
        end;
      end;
    finally
      freeandnil(Rset);
    end;
  end;


  function Td.RRlst_Departure(DateFrom,DateTo :  Tdate) : tstringList;
  var
    s : string;
    Rset : TRoomerDataSet;
    listItem : integer;
    sql : string;
  begin
    result := tstringList.Create;

    Rset := CreateNewDataSet;
    try
      sql :=
      '  SELECT'+
      '    DISTINCT'+
      '    RoomReservation'+
      '  FROM'+
      '    roomreservations'+
      '  WHERE'+
      '        (Departure >=  %s )'+
      '    AND (Departure <=  %s )'+
      '    AND (status <> '+_db(STATUS_DELETED)+' ) '+ //**zxhj
      '    AND (status <> '+_db(STATUS_CANCELED)+' ) '+ //**zxhj
      '  ORDER BY RoomReservation';
      s := format(sql , [_DateToDbDate(DateFrom,true),_DateToDbDate(DateTo,true)]);


      if hData.rSet_bySQL(rSet,s) then
    	begin
        while not Rset.Eof do
        begin
          listItem := Rset.fieldbyname('RoomReservation').asInteger;
          result.Add(inttostr(listItem));
          Rset.Next;
        end;
      end;
    finally
      freeandnil(Rset);
    end;
  end;


  function Td.GuestListRRlst_Departure(DateFrom,DateTo :  Tdate;includeNoshow,includeAllotment,includeBlocked : boolean) : tstringList;
  var
    s : string;
    Rset : TRoomerDataSet;
    listItem : integer;
    sql : string;
  begin
    result := tstringList.Create;

    Rset := CreateNewDataSet;
    try
      sql := GetListOfRoomReservationsPerDepartureDate;
      s := format(sql , [_DateToDbDate(DateFrom,true),_DateToDbDate(DateTo,true)]);

      if hData.rSet_bySQL(rSet,s) then
    	begin
        while not Rset.Eof do
        begin
          listItem := Rset.fieldbyname('RoomReservation').asInteger;
          result.Add(inttostr(listItem));
          Rset.Next;
        end;
      end;
    finally
      freeandnil(Rset);
    end;
  end;


  function Td.Rvlst_FromTo(DateFrom,DateTo :  Tdate) : tstringList;
  var
    s : string;
    Rset : TRoomerDataSet;
    listItem : integer;
    sql : string;
  begin
    result := tstringList.Create;

    Rset := CreateNewDataSet;
    try
      sql :=
      '  SELECT'+
      '    DISTINCT'+
      '    Reservation'+
      '  FROM'+
      '    roomsdate'+
      '  WHERE'+
      '        (ADate >=  %s )'+
      '    AND (ADate <=  %s )'+
      '    AND (ResFlag <> '+_db(STATUS_DELETED)+' ) '+ //**zxhj
      '    AND (ResFlag <> '+_db(STATUS_CANCELED)+' ) '+ //**zxhj
      '  ORDER BY Reservation';

      s := format(sql , [_DateToDbDate(DateFrom,true),_DateToDbDate(DateTo,true)]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        while not Rset.Eof do
        begin
          ListItem := Rset.fieldbyname('Reservation').asInteger;
          result.Add(inttostr(listItem));
          Rset.Next;
        end;
      end;
    finally
      freeandnil(Rset);
    end;
  end;


  function Td.RRlst_FromTo(DateFrom,DateTo :  Tdate) : tstringList;
  var
    s : string;
    Rset : TRoomerDataSet;
    listItem : integer;
    sql : string;

  begin
    result := tstringList.Create;

    Rset := CreateNewDataSet;
    try


      sql :=
      '  SELECT'+
      '    DISTINCT'+
      '    RoomReservation'+
      '  FROM'+
      '    roomsdate'+
      '  WHERE'+
      '        (ADate >=  %s )'+
      '    AND (ADate <=  %s )'+
      '   AND (ResFlag <> '+_db(STATUS_DELETED)+' ) '+ //**zxhj line added
      '   AND (ResFlag <> '+_db(STATUS_CANCELED)+' ) '+ //**zxhj line added
      '  ORDER BY RoomReservation';

      s := format(sql , [_DateToDbDate(DateFrom,true),_DateToDbDate(DateTo,true)]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        while not Rset.Eof do
        begin
          listItem := Rset.fieldbyname('RoomReservation').asInteger;
          result.Add(inttostr(listItem));
          Rset.Next;
        end;
      end;
    finally
      freeandnil(Rset);
    end;
  end;

  function Td.GuestlistRRlst_FromTo(DateFrom,DateTo :  Tdate;includeNoshow,includeAllotment,includeBlocked : boolean) : tstringList;
  var
    s : string;
    Rset : TRoomerDataSet;
    listItem : integer;
    sql : string;

  begin
    result := tstringList.Create;

    Rset := CreateNewDataSet;
    try

      sql := GetListOfRoomReservationsFromToDate;
      s := format(sql , [_DateToDbDate(DateFrom,true),_DateToDbDate(DateTo,true)]);

      if hData.rSet_bySQL(rSet,s) then
    	begin
        while not Rset.Eof do
        begin
          listItem := Rset.fieldbyname('RoomReservation').asInteger;
          result.Add(inttostr(listItem));
          Rset.Next;
        end;
      end;
    finally
      freeandnil(Rset);
    end;
  end;


  function Td.RE_Upd_MarketSegment(newValue : string; reservation : integer) : boolean;
  var
    s : string;
  begin
    result := false;

    if reservation < 1 then
      exit;
    result := true;
    s := '';
    s := s + ' UPDATE reservations '+chr(10);
    s := s + ' Set MarketSegment=' + _db(newValue) + ' '+chr(10);
    s := s + ' WHERE (Reservation = ' + inttostr(reservation) + ') '+chr(10);
    if not cmd_bySQL(s) then
    begin
      result := false;
    end;
  end;

const AlreadyLoggingIn : boolean = false;
procedure Td.roomerMainDataSetSessionExpired(Sender: TObject);
var res : boolean;
begin
//  frmMain.timLogout.Enabled := true;
  if AlreadyLoggingIn then
    exit;
  AlreadyLoggingIn := false;
  try
    repeat
      res := frmMain._Logout(true);
    until res OR Application.Terminated;
  finally
    AlreadyLoggingIn := false;
  end;
end;

function Td.IH_Upd_UnPaid_RR(RoomReservation : integer) : boolean;
var
  Rset : TRoomerDataSet;
  s : string;
begin
  Rset := CreateNewDataSet;
  try
    // s := s + ' SELECT'+chr(10);
    // s := s + '     RoomReservation'+chr(10);
    // s := s + '   , InvoiceNumber'+chr(10);
    // s := s + '   , Total'+chr(10);
    // s := s + ' FROM'+chr(10);
    // s := s + '    InvoiceHeads'+chr(10);
    // s := s + ' WHERE'+chr(10);
    // s := s + '   (Total > 0) AND (InvoiceNumber = - 1) AND (RoomReservation = ' + inttostr(RoomReservation) + ')'+chr(10);
    s := format(select_IH_Upd_UnPaid_RR, [RoomReservation]);
    result := hData.rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

procedure Td.ApplyFieldsToKbmMemTable(sourceSet: TRoomerDataSet; destSet: TdxMemData; loadDataSet : Boolean = True);
begin
  destSet.FieldDefs.Assign(sourceSet.FieldDefs);
  destSet.CreateFieldsFromDataSet(sourceSet);
  if loadDataSet then
  begin
    destSet.Open;
    destSet.LoadFromDataSet(sourceSet);
//      [mtcpoStructure,mtcpoProperties,mtcpoFieldIndex,mtcpoIgnoreErrors,mtcpoStringAsWideString,mtcpoWideStringUTF8]);
  end;
end;


procedure Td.SaveKbmMemTable(destSet : TdxMemData; filename : String; performTouch : Boolean = False);
begin
  if FileExists(filename) then
    DeleteAllFiles(filename);
  destSet.SaveToBinaryFile(filename);
  if performTouch then
    TouchNewFile(filename + '.changed', now);
end;

//procedure Td.LoadKbmMemTable(destSet : TdxMemData; filename : String);
//begin
//  if destSet.active then
//    destSet.Close;
//  destSet.CreateFieldsFromBinaryFile(filename);
//  destSet.LoadFromBinaryFile(filename);
//end;
//
//procedure Td.SaveRoomerDataAsKbmMemTable(filename : String; res : String);
//var sourceSet : TRoomerDataSet;
//begin
//  if FileExists(filename) then
//    DeleteAllFiles(filename);
//  sourceSet := roomerMainDataSet.ActivateNewDataSet(res);
//  try
//    SaveRoomerDataSetAsKbmMemTable(filename, sourceSet);
//    Application.processMessages;
//  finally
//    FreeAndNil(sourceSet);
//  end;
//end;
//
//procedure Td.SaveRoomerDataSetAsKbmMemTable(filename : String; sourceSet : TRoomerDataSet);
//var kbm : TdxMemData;
//    saveData : Boolean;
//begin
//  kbm := dxMemData; //  TKbmMemTable.Create(nil);
//  try
////    sourceSet.First;
//    saveData := true; // NOT sourceSet.Eof;
//
//    ApplyFieldsToKbmMemTable(sourceSet, kbm, saveData);
//    if saveData then
//      SaveKbmMemTable(kbm, filename);
//  finally
////    FreeAndNil(kbm);
//  end;
//end;
//

const GET_ALL_INVOICE_ITEMS_FOR_A_SPECIFIED_ROOM_RESERVATION =
'SELECT il.Id AS ilId, il.PurchaseDate, il.ItemId, il.Number, il.Description, il.Price, il.VATType, il.Total, il.TotalWOVat, il.Vat, ' + #10 +
'il.CurrencyRate, il.Currency, il.ItemNumber, il.RoomReservationAlias, ' + #10 +
'       ih.Reservation, ' + #10 +
'    ih.RoomReservation, ' + #10 +
'    ih.SplitNumber, ' + #10 +
'    ih.InvoiceNumber, ' + #10 +
'    ih.InvoiceDate, ' + #10 +
'    ih.Customer, ' + #10 +
'    ih.Name, ' + #10 +
'    ih.Address1, ' + #10 +
'    ih.Address2, ' + #10 +
'    ih.Address3, ' + #10 +
'    ih.Address4, ' + #10 +
'    ih.Country, ' + #10 +
'    ih.Total AS ihTotal, ' + #10 +
'    ih.TotalWOVAT AS ihTotalWOVAT, ' + #10 +
'    ih.TotalVAT AS ihTotalVAT, ' + #10 +
'    ih.TotalBreakFast, ' + #10 +
'    ih.ExtraText, ' + #10 +
'    ih.Finished, ' + #10 +
'    ih.ReportDate, ' + #10 +
'    ih.ReportTime, ' + #10 +
'    ih.CreditInvoice, ' + #10 +
'    ih.OriginalInvoice, ' + #10 +
'    ih.InvoiceType, ' + #10 +
'    ih.ihTmp, ' + #10 +
'    ih.ID, ' + #10 +
'    ih.custPID, ' + #10 +
'    ih.RoomGuest, ' + #10 +
'    ih.ihDate, ' + #10 +
'    ih.ihStaff, ' + #10 +
'    ih.ihPayDate, ' + #10 +
'    ih.ihConfirmDate, ' + #10 +
'    ih.ihInvoiceDate, ' + #10 +
'    ih.ihCurrency, ' + #10 +
'    ih.ihCurrencyRate, ' + #10 +
'    ih.invRefrence, ' + #10 +
'    ih.TotalStayTax, ' + #10 +
'    ih.TotalStayTaxNights ' + #10 +
'    ih.showPackage ' + #10 +
'    ih.location ' + #10 +
'    , (SELECT COUNT(id) FROM persons WHERE RoomReservation=_params.RoomReservation) AS numTaxGuests ' + #10 +
'FROM invoiceheads ih, invoicelines il, (SELECT ${RoomReservation} AS RoomReservation) _params ' + #10 +
' ' + #10 +
'WHERE ih.RoomReservation = _params.RoomReservation ' + #10 +
'AND ih.invoiceNumber=-1 ' + #10 +
'AND ih.SplitNumber=0 ' + #10 +
'AND ih.RoomReservation=il.RoomReservation ' + #10 +
'AND ih.InvoiceNumber=il.InvoiceNumber ' + #10 +
'AND ih.SplitNumber=il.SplitNumber ' + #10 +
' ' + #10 +
'UNION ALL ' + #10 +
' ' + #10 +
'SELECT -2 AS ilId, CURRENT_DATE AS PurchaseDate, ' + #10 +
'       _params.RoomRentItem AS ItemId, ' + #10 +
'       DATEDIFF((SELECT ADate FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) ORDER BY ADate DESC LIMIT 1), ' + #10 +
'                (SELECT ADate FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) ORDER BY ADate LIMIT 1)) + 1 AS Number, ' + #10 +
'       CONCAT(''Room '', (SELECT Room FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) LIMIT 1), '' '', ' + #10 +
'              DATE_FORMAT((SELECT ADate FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) ORDER BY ADate LIMIT 1), ''%d-%m''), '' - '', ' + #10 +
'              DATE_FORMAT((SELECT ADate FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) ORDER BY ADate DESC LIMIT 1), ''%d-%m'')) AS Description, ' + #10 +
'       (SELECT AVG(RoomRate) FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q''))) AS Price, ' + #10 +
'       _params.VATCode AS VATType, ' + #10 +
'       (SELECT SUM(RoomRate * ABS(1-Paid)) FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q''))) AS Total, ' + #10 +
'       (SELECT SUM(RoomRate * ABS(1-Paid)) FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q''))) / (1+(_params.VATPercentage/100)) ' + #10 +
'       AS TotalWOVat, ' + #10 +
'       (SELECT SUM(RoomRate * ABS(1-Paid)) FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q''))) - ' + #10 +
'       (SELECT SUM(RoomRate * ABS(1-Paid)) FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q''))) / (1+(_params.VATPercentage/100)) ' + #10 +
'       AS Vat, ' + #10 +
'       (SELECT AValue from currencies WHERE Currency=(SELECT Currency FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) LIMIT 1)) AS CurrencyRate, ' + #10 +
'       (SELECT Currency FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) LIMIT 1) AS Currency, ' + #10 +
'       -1 AS ItemNumber, _params.RoomReservation AS RoomReservationAlias, ' + #10 +
'       ih.Reservation, ' + #10 +
'    ih.RoomReservation, ' + #10 +
'    ih.SplitNumber, ' + #10 +
'    ih.InvoiceNumber, ' + #10 +
'    ih.InvoiceDate, ' + #10 +
'    ih.Customer, ' + #10 +
'    ih.Name, ' + #10 +
'    ih.Address1, ' + #10 +
'    ih.Address2, ' + #10 +
'    ih.Address3, ' + #10 +
'    ih.Address4, ' + #10 +
'    ih.Country, ' + #10 +
'    ih.Total AS ihTotal, ' + #10 +
'    ih.TotalWOVAT AS ihTotalWOVAT, ' + #10 +
'    ih.TotalVAT AS ihTotalVAT, ' + #10 +
'    ih.TotalBreakFast, ' + #10 +
'    ih.ExtraText, ' + #10 +
'    ih.Finished, ' + #10 +
'    ih.ReportDate, ' + #10 +
'    ih.ReportTime, ' + #10 +
'    ih.CreditInvoice, ' + #10 +
'    ih.OriginalInvoice, ' + #10 +
'    ih.InvoiceType, ' + #10 +
'    ih.ihTmp, ' + #10 +
'    ih.ID, ' + #10 +
'    ih.custPID, ' + #10 +
'    ih.RoomGuest, ' + #10 +
'    ih.ihDate, ' + #10 +
'    ih.ihStaff, ' + #10 +
'    ih.ihPayDate, ' + #10 +
'    ih.ihConfirmDate, ' + #10 +
'    ih.ihInvoiceDate, ' + #10 +
'    ih.ihCurrency, ' + #10 +
'    ih.ihCurrencyRate, ' + #10 +
'    ih.invRefrence, ' + #10 +
'    ih.TotalStayTax, ' + #10 +
'    ih.TotalStayTaxNights ' + #10 +
'    ih.showPackage ' + #10 +
'    ih.location ' + #10 +
'    , (SELECT COUNT(id) FROM persons WHERE RoomReservation=_params.RoomReservation) AS numTaxGuests ' + #10 +
'FROM invoiceheads ih, ' + #10 +
'     (SELECT ${RoomReservation} AS RoomReservation, ' + #10 +
'             (SELECT RoomRentItem FROM control LIMIT 1) AS RoomRentItem, ' + #10 +
'             (SELECT VATPercentage FROM vatcodes ' + #10 +
'              WHERE VATCode=(SELECT VATCode FROM itemtypes WHERE ItemType=(SELECT ItemType FROM items WHERE Item=RoomRentItem LIMIT 1))) AS VATPercentage, ' + #10 +
'             (SELECT VATCode FROM itemtypes WHERE ItemType=(SELECT ItemType FROM items WHERE Item=RoomRentItem LIMIT 1)) AS VATCode) _params ' + #10 +
'WHERE ih.RoomReservation = _params.RoomReservation ' + #10 +
'AND ih.invoiceNumber=-1 ' + #10 +
'AND ih.SplitNumber=0 ' + #10 +
' ' + #10 +
'UNION ALL ' + #10 +
' ' + #10 +
'SELECT -1 AS ilId, _taxes.PurchaseDate, _taxes.ItemId, _taxes.Number, ' + #10 +
'       CONCAT(''Room '', _taxes.Room, '' '', _taxes.Description), ' + #10 +
'       IF(tax_type = ''FIXED_AMOUNT'', tax_amount, ' + #10 +
'          IF(tax_base IN (''ROOM_NIGHT'', ''GUEST_NIGHT''), ' + #10 +
'              _TaxBaseAveragePrice * tax_amount / 100, ' + #10 +
'              _TaxBaseTotalPrice * tax_amount / 100 ' + #10 +
'       )) AS Price, ' + #10 +
' ' + #10 +
'       _taxes.VATType, ' + #10 +
' ' + #10 +
'       IF(tax_type = ''FIXED_AMOUNT'', tax_amount, ' + #10 +
'          IF(tax_base IN (''ROOM_NIGHT'', ''GUEST_NIGHT''), ' + #10 +
'              _TaxBaseAveragePrice * tax_amount / 100, ' + #10 +
'              _TaxBaseTotalPrice * tax_amount / 100 ' + #10 +
'       )) * _taxes.Number AS Total, ' + #10 +
' ' + #10 +
'       IF(tax_type = ''FIXED_AMOUNT'', tax_amount, ' + #10 +
'          IF(tax_base IN (''ROOM_NIGHT'', ''GUEST_NIGHT''), ' + #10 +
'              _TaxBaseAveragePrice * tax_amount / 100, ' + #10 +
'              _TaxBaseTotalPrice * tax_amount / 100 ' + #10 +
'       )) * _taxes.Number / (1 + _VATPercentage/100) AS TotalWOVat, ' + #10 +
'       IF(tax_type = ''FIXED_AMOUNT'', tax_amount, ' + #10 +
'          IF(tax_base IN (''ROOM_NIGHT'', ''GUEST_NIGHT''), ' + #10 +
'              _TaxBaseAveragePrice * tax_amount / 100, ' + #10 +
'              _TaxBaseTotalPrice * tax_amount / 100 ' + #10 +
'       )) * _taxes.Number - ' + #10 +
'      IF(tax_type = ''FIXED_AMOUNT'', tax_amount, ' + #10 +
'          IF(tax_base IN (''ROOM_NIGHT'', ''GUEST_NIGHT''), ' + #10 +
'              _TaxBaseAveragePrice * tax_amount / 100, ' + #10 +
'              _TaxBaseTotalPrice * tax_amount / 100 ' + #10 +
'       )) * _taxes.Number / (1 + _VATPercentage/100) AS Vat, ' + #10 +
' ' + #10 +
'       _taxes.CurrencyRate, _taxes.Currency, _taxes.ItemNumber, _params.RoomReservation AS RoomReservationAlias, ' + #10 +
'       ih.Reservation, ' + #10 +
'    ih.RoomReservation, ' + #10 +
'    ih.SplitNumber, ' + #10 +
'    ih.InvoiceNumber, ' + #10 +
'    ih.InvoiceDate, ' + #10 +
'    ih.Customer, ' + #10 +
'    ih.Name, ' + #10 +
'    ih.Address1, ' + #10 +
'    ih.Address2, ' + #10 +
'    ih.Address3, ' + #10 +
'    ih.Address4, ' + #10 +
'    ih.Country, ' + #10 +
'    ih.Total AS ihTotal, ' + #10 +
'    ih.TotalWOVAT AS ihTotalWOVAT, ' + #10 +
'    ih.TotalVAT AS ihTotalVAT, ' + #10 +
'    ih.TotalBreakFast, ' + #10 +
'    ih.ExtraText, ' + #10 +
'    ih.Finished, ' + #10 +
'    ih.ReportDate, ' + #10 +
'    ih.ReportTime, ' + #10 +
'    ih.CreditInvoice, ' + #10 +
'    ih.OriginalInvoice, ' + #10 +
'    ih.InvoiceType, ' + #10 +
'    ih.ihTmp, ' + #10 +
'    ih.ID, ' + #10 +
'    ih.custPID, ' + #10 +
'    ih.RoomGuest, ' + #10 +
'    ih.ihDate, ' + #10 +
'    ih.ihStaff, ' + #10 +
'    ih.ihPayDate, ' + #10 +
'    ih.ihConfirmDate, ' + #10 +
'    ih.ihInvoiceDate, ' + #10 +
'    ih.ihCurrency, ' + #10 +
'    ih.ihCurrencyRate, ' + #10 +
'    ih.invRefrence, ' + #10 +
'    ih.TotalStayTax, ' + #10 +
'    ih.TotalStayTaxNights ' + #10 +
'    ih.showPackage ' + #10 +
'    ih.location ' + #10 +
'    , (SELECT COUNT(id) FROM persons WHERE RoomReservation=_params.RoomReservation) AS numTaxGuests ' + #10 +
' ' + #10 +
'FROM ' + #10 +
'( ' + #10 +
'SELECT CURRENT_DATE AS PurchaseDate, ' + #10 +
'       i.Item AS ItemId, ' + #10 +
' ' + #10 +
'       t.TAX_BASE AS tax_base, ' + #10 +
'       (SELECT ADate FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) ORDER BY ADate DESC LIMIT 1) AS _DepartureDate, ' + #10 +
'       (SELECT ADate FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) ORDER BY ADate LIMIT 1) AS _ArrivalDate, ' + #10 +
'       (SELECT COUNT(id) FROM persons WHERE RoomReservation=_params.RoomReservation) AS _NumberOfGuests, ' + #10 +
' ' + #10 +
'       IF(t.TAX_BASE = ''ROOM_NIGHT'', ' + #10 +
'          DATEDIFF((SELECT ADate FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) ORDER BY ADate DESC LIMIT 1), ' + #10 +
'                   (SELECT ADate FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) ORDER BY ADate LIMIT 1)) + 1, ' + #10 +
'       IF(t.TAX_BASE = ''GUEST_NIGHT'', ' + #10 +
'          (SELECT COUNT(id) FROM persons WHERE RoomReservation=_params.RoomReservation) * ' + #10 +
'          DATEDIFF((SELECT ADate FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) ORDER BY ADate DESC LIMIT 1), ' + #10 +
'                   (SELECT ADate FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) ORDER BY ADate LIMIT 1)) + 1, ' + #10 +
'       IF(t.TAX_BASE = ''GUEST'', ' + #10 +
'          (SELECT COUNT(id) FROM persons WHERE RoomReservation=_params.RoomReservation), ' + #10 +
'          1 ' + #10 +
'          ))) AS Number, ' + #10 +
' ' + #10 +
' ' + #10 +
'       (SELECT Room FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) LIMIT 1) AS Room, ' + #10 +
'       t.DESCRIPTION AS Description, ' + #10 +
' ' + #10 +
'       t.TAX_TYPE AS tax_type, ' + #10 +
'       t.AMOUNT AS tax_amount, ' + #10 +
'       t.NETTO_AMOUNT_BASED AS tax_netto_based, ' + #10 +
'       (SELECT AVG(RoomRate * ABS(1-Paid)) FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q''))) AS _AveragePrice, ' + #10 +
'       (SELECT SUM(RoomRate * ABS(1-Paid)) FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q''))) AS _TotalPrice, ' + #10 +
'       (SELECT AVG(RoomRate * ABS(1-Paid)) FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q''))) / (1+(v.VATPercentage/100)) * t.AMOUNT / 100 AS _NettoAveragePrice, ' + #10 +
'       (SELECT SUM(RoomRate * ABS(1-Paid)) FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q''))) / (1+(v.VATPercentage/100)) * t.AMOUNT / 100 AS _NettoTotalPrice, ' + #10 +
'       IF(t.NETTO_AMOUNT_BASED = ''FALSE'', ' + #10 +
'         (SELECT AVG(RoomRate * ABS(1-Paid)) FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q''))), ' + #10 +
'         (SELECT AVG(RoomRate * ABS(1-Paid)) FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q''))) / (1+(v.VATPercentage/100)) * t.AMOUNT / 100) ' + #10 +
'       AS _TaxBaseAveragePrice, ' + #10 +
'       IF(t.NETTO_AMOUNT_BASED = ''FALSE'', ' + #10 +
'         (SELECT SUM(RoomRate * ABS(1-Paid)) FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q''))), ' + #10 +
'         (SELECT SUM(RoomRate * ABS(1-Paid)) FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q''))) / (1+(v.VATPercentage/100)) * t.AMOUNT / 100) ' + #10 +
'       AS _TaxBaseTotalPrice, ' + #10 +
' ' + #10 +
'       v.VATPercentage AS _VATPercentage, ' + #10 +
'       v.VATCode AS VATType, ' + #10 +
' ' + #10 +
'       (SELECT AValue from currencies WHERE Currency=(SELECT Currency FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) LIMIT 1)) AS CurrencyRate, ' + #10 +
'       (SELECT Currency FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) LIMIT 1) AS Currency, ' + #10 +
'       0 AS ItemNumber ' + #10 +
'FROM home100.TAXES t, invoiceheads ih, items i, itemtypes it, vatcodes v, ' + #10 +
'     (SELECT ${RoomReservation} AS RoomReservation) _params ' + #10 +
'WHERE ih.RoomReservation = _params.RoomReservation ' + #10 +
'AND ih.invoiceNumber=-1 ' + #10 +
'AND ih.SplitNumber=0 ' + #10 +
'AND t.HOTEL_ID=(SELECT CompanyID FROM control LIMIT 1) ' + #10 +
'AND t.VALID_FROM>=CURRENT_DATE ' + #10 +
'AND i.id = t.BOOKING_ITEM_ID ' + #10 +
'AND it.ItemType = i.ItemType ' + #10 +
'AND v.VATCode = it.VATCode ' + #10 +
') _taxes, ' + #10 +
'invoiceheads ih, ' + #10 +
'     (SELECT ${RoomReservation} AS RoomReservation) _params ' + #10 +
'WHERE ih.RoomReservation = _params.RoomReservation ' + #10 +
'AND ih.invoiceNumber=-1 ' + #10 +
'AND ih.SplitNumber=0 ' + #10 +
' ' + #10 +
'ORDER BY ItemNumber ' + #10;


//procedure Td.ProcessInvoiceBackupsForDate(sourceRSet : TRoomerDataSet; sPath : String; rSet : TRoomerDataset);
//var RoomReservation : Integer;
//    res : String;
//    sql : String;
//begin
//  rSet.First;
//  while NOT rSet.Eof do
//  begin
//    RoomReservation := rSet['RoomReservation'];
//    sql := StringReplace(GET_ALL_INVOICE_ITEMS_FOR_A_SPECIFIED_ROOM_RESERVATION, '${RoomReservation}', inttoStr(RoomReservation), [rfReplaceAll, rfIgnoreCase]);
//    res := sourceRSet.queryRoomer(sql);
////    CopyToClipboard(sql);
//    SaveToUtf8TextFile(TPath.Combine(sPath, format('Backup_Room_Invoice_%d.src', [RoomReservation])), res);
//    rSet.Next;
//  end;
//end;
//
//procedure Td.ProcessReservationBackupsForDate(sourceRSet : TRoomerDataSet; sPath : String; rSet : TRoomerDataset);
//var i, Reservation, RoomReservation , iSplit: Integer;
//    res,
//    sql,
//    filename : String;
//    rSetTemp : TRoomerDataSet;
//begin
//  rSet.First;
//  while NOT rSet.Eof do
//  begin
//    Reservation := rSet['Reservation'];
//    RoomReservation := rSet['RoomReservation'];
//
//    filename := TPath.Combine(sPath, format('Backup_RoomReservation_%d.src', [RoomReservation]));
//    if NOT FileExists(filename) then
//    begin
//      sql := StringReplace('SELECT * FROM roomreservations WHERE RoomReservation=${RoomReservation}', '${RoomReservation}', inttoStr(RoomReservation), [rfReplaceAll, rfIgnoreCase]);
//      res := sourceRSet.queryRoomer(sql);
//      SaveToUtf8TextFile(filename, res);
//      Application.processMessages;
//    end;
//
//    filename := TPath.Combine(sPath, format('Backup_Reservation_%d.src', [Reservation]));
//    if NOT FileExists(filename) then
//    begin
//      sql := StringReplace('SELECT * FROM reservations WHERE Reservation=${Reservation}', '${Reservation}', inttoStr(Reservation), [rfReplaceAll, rfIgnoreCase]);
//      res := sourceRSet.queryRoomer(sql);
//      SaveToUtf8TextFile(filename, res);
//      Application.processMessages;
//    end;
//
//    filename := TPath.Combine(sPath, format('Backup_Persons_%d.src', [RoomReservation]));
//    if NOT FileExists(filename) then
//    begin
//      sql := StringReplace('SELECT * FROM persons WHERE RoomReservation=${RoomReservation}', '${RoomReservation}', inttoStr(RoomReservation), [rfReplaceAll, rfIgnoreCase]);
//      res := sourceRSet.queryRoomer(sql);
//      SaveRoomerDataAsKbmMemTable(filename, res);
//      Application.processMessages;
//    end;
//
//    sql := StringReplace('SELECT Min(SplitNumber) AS MinSplitNumber, Max(SplitNumber) AS MaxSplitNumber FROM invoicelines WHERE Reservation=${Reservation}', '${Reservation}', inttoStr(RoomReservation), [rfReplaceAll, rfIgnoreCase]);
//    rSetTemp := sourceRSet.ActivateNewDataSet(sourceRSet.queryRoomer(sql));
//    rSetTemp.First;
//
//    if NOT rSetTemp.Eof then
//    for i := rSetTemp['MinSplitNumber'] to rSetTemp['MaxSplitNumber'] do
//    begin
//      iSplit := i;
//      filename := TPath.Combine(sPath, format('Backup_Invoice_Lines_Res_RoomRes_Split_%d_%d_%d.src', [Reservation, RoomReservation, iSplit]));
//      if NOT FileExists(filename) then
//      begin
//        sql := StringReplace('SELECT * FROM invoicelines where Reservation = ${Reservation} and RoomReservation = ${RoomReservation} and SplitNumber = ${SplitNumber} and InvoiceNumber = -1',
//                             '${RoomReservation}', inttoStr(RoomReservation), [rfReplaceAll, rfIgnoreCase]);
//        sql := StringReplace(sql, '${Reservation}', inttoStr(Reservation), [rfReplaceAll, rfIgnoreCase]);
//        sql := StringReplace(sql, '${SplitNumber}', inttoStr(iSplit), [rfReplaceAll, rfIgnoreCase]);
//        res := sourceRSet.queryRoomer(sql);
//        SaveRoomerDataAsKbmMemTable(filename, res);
//      end;
//
//      filename := TPath.Combine(sPath, format('Backup_Invoice_Heads_Res_RoomRes_Split_%d_%d_%d.src', [Reservation, RoomReservation, iSplit]));
//      if NOT FileExists(filename) then
//      begin
//        sql := StringReplace('SELECT * FROM invoiceheads where Reservation = ${Reservation} and RoomReservation = ${RoomReservation} and SplitNumber = ${SplitNumber} and InvoiceNumber = -1',
//                             '${RoomReservation}', inttoStr(RoomReservation), [rfReplaceAll, rfIgnoreCase]);
//        sql := StringReplace(sql, '${Reservation}', inttoStr(Reservation), [rfReplaceAll, rfIgnoreCase]);
//        sql := StringReplace(sql, '${SplitNumber}', inttoStr(iSplit), [rfReplaceAll, rfIgnoreCase]);
//        res := sourceRSet.queryRoomer(sql);
//        SaveRoomerDataAsKbmMemTable(filename, res);
//      end;
//    end;
//
//    filename := TPath.Combine(sPath, format('Backup_Payments_Res_RoomRes_%d_%d.src', [Reservation, RoomReservation]));
//    if NOT FileExists(filename) then
//    begin
//      sql := StringReplace('SELECT * FROM payments where Reservation = ${Reservation} and RoomReservation = ${RoomReservation} and InvoiceNumber = -1', '${RoomReservation}', inttoStr(RoomReservation), [rfReplaceAll, rfIgnoreCase]);
//      sql := StringReplace(sql, '${Reservation}', inttoStr(Reservation), [rfReplaceAll, rfIgnoreCase]);
//      res := sourceRSet.queryRoomer(sql);
//      SaveRoomerDataAsKbmMemTable(filename, res);
//    end;
//
//
//    filename := TPath.Combine(sPath, format('Backup_Reservation_Roomsdate_%d.src', [Reservation]));
//    if NOT FileExists(filename) then
//    begin
//      sql := StringReplace('SELECT * FROM roomsdate WHERE Reservation=${Reservation} AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) ', '${Reservation}', inttoStr(Reservation), [rfReplaceAll, rfIgnoreCase]);
//      res := sourceRSet.queryRoomer(sql);
//      SaveToUtf8TextFile(filename, res);
//      Application.processMessages;
//    end;
//
//    filename := TPath.Combine(sPath, format('Backup_RoomReservation_Roomsdate_%d.src', [RoomReservation]));
//    if NOT FileExists(filename) then
//    begin
//      sql := StringReplace('SELECT rd.* ' +
//        ',IF(ISNULL((SELECT name FROM persons WHERE persons.MainName AND persons.roomreservation = rd.roomreservation LIMIT 1)), ' +
//        '   (SELECT name FROM persons WHERE persons.roomreservation = rd.roomreservation LIMIT 1), ' +
//        '   (SELECT name FROM persons WHERE persons.MainName AND persons.roomreservation = rd.roomreservation LIMIT 1)) AS guestName ' +
//        ', (SELECT count(id) FROM persons WHERE persons.roomreservation = rd.roomreservation) AS numGuests ' +
//        'FROM roomsdate rd WHERE rd.RoomReservation=${RoomReservation} AND (NOT rd.ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) ', '${RoomReservation}', inttoStr(RoomReservation), [rfReplaceAll, rfIgnoreCase]);
//      res := sourceRSet.queryRoomer(sql);
//      SaveToUtf8TextFile(filename, res);
//      Application.processMessages;
//    end;
//
//    filename := TPath.Combine(sPath, format('Backup_Reservation_RoomReservations_%d.src', [Reservation]));
//    if NOT FileExists(filename) then
//    begin
//      sql := StringReplace('SELECT rr.*, ' +
//        '(SELECT Description FROM rooms WHERE rooms.Room=rr.Room) AS RoomDescription, ' +
//        '(SELECT Description FROM roomtypes WHERE roomtypes.RoomType=(SELECT RoomType FROM rooms WHERE rooms.Room=rr.Room)) AS RoomTypeDescription, ' +
//        '(SELECT COUNT(id) FROM persons WHERE persons.RoomReservation=rr.RoomReservation) AS numTaxGuests ' +
//        'FROM roomreservations rr ' +
//        'WHERE rr.Reservation=${Reservation} AND (NOT rr.Status IN (''X'',''C'',''O'',''N'',''Q'')) ', '${Reservation}', inttoStr(Reservation), [rfReplaceAll, rfIgnoreCase]);
//      res := sourceRSet.queryRoomer(sql);
//      SaveToUtf8TextFile(filename, res);
//      Application.processMessages;
//    end;
//
//    rSet.Next;
//  end;
//end;
//
//procedure Td.BackupTaxes(sourceRSet : TRoomerDataSet; sPath : String);
//var s, filename : String;
//begin
//  filename :=  TPath.Combine(sPath, 'Backup_TAXES.src');
//  s := format(select_Taxes_fillGridFromDataset , ['RETAXABLE']);
//  s := sourceRSet.queryRoomer(s);
//  SaveToUtf8TextFile(filename, s);
//end;
//
//procedure Td.BackupControlTable(rSet : TRoomerDataSet);
//begin
//  rSet.SaveToFile(TPath.Combine(GetBackupPath, 'Backup_Control_Table.src'), pfXML);
//end;
//
//procedure Td.BackupInvoiceLines(rSet : TdxMemData);
//var Reservation, RoomReservation, Split : Integer;
//begin
//  rset.First;
//  Reservation := rSet['Reservation'];
//  RoomReservation := rSet['RoomReservation'];
//  Split := rSet['SplitNumber'];
//  SaveKbmMemTable(rSet, TPath.Combine(GetBackupPath, format('Backup_Invoice_Lines_Res_RoomRes_Split_%d_%d_%d.src', [Reservation, RoomReservation, Split])), True);
//end;
//
//procedure Td.BackupInvoiceHeader(rSet : TdxMemData);
//var Reservation, RoomReservation, Split : Integer;
//begin
//  rset.First;
//  Reservation := rSet['Reservation'];
//  RoomReservation := rSet['RoomReservation'];
//  Split := rSet['SplitNumber'];
//  SaveKbmMemTable(rSet, TPath.Combine(GetBackupPath, format('Backup_Invoice_Heads_Res_RoomRes_Split_%d_%d_%d.src', [Reservation, RoomReservation, Split])), True);
//end;
//
//procedure Td.BackupPayments(rSet : TdxMemData);
//var Reservation, RoomReservation: Integer;
//begin
//  rset.First;
//  Reservation := rSet['Reservation'];
//  RoomReservation := rSet['RoomReservation'];
//  SaveKbmMemTable(rSet, TPath.Combine(GetBackupPath, format('Backup_Payments_Res_RoomRes_%d_%d.src', [Reservation, RoomReservation])), True);
//end;
//
//procedure Td.BackupTodaysGuestsList(rSet : TRoomerDataSet);
//var filename : String;
//begin
//  rset.First;
//  filename := TPath.Combine(GetBackupPath, format('Backup_Guests_%s.src', [dateToSqlString(now)]));
//  rSet.SaveToFile(filename, pfXML);
//  TouchNewFile(filename + '.changed', now);
//end;
//
//function Td.GetBackupPath : String;
//begin
//  result := TPath.Combine(uStringUtils.LocalAppDataPath, 'Roomer');
//  result := TPath.Combine(result, format('%s\backup',[d.roomerMainDataSet.hotelId]));
//  forceDirectories(result);
//end;
//
//function Td.GetBackupTodaysGuests : String;
//begin
//  result := ReadFromTextFile(TPath.Combine(GetBackupPath, format('Backup_Guests_%s.src', [dateToSqlString(now)])));
//end;

procedure Td.GenerateOfflineReports;
begin
  TOfflineReportGenerator.ExecuteRegisteredReports;
end;

//function Td.GetBackupControlTable : String;
//begin
//  result := ReadFromTextFile(TPath.Combine(GetBackupPath, 'Backup_Control_Table.src'));
//end;
//
//procedure Td.GetBackupInvoiceLinesReservationRoomReservationsSplitNumber(Reservation, RoomReservation, Split : Integer; kbm : TdxMemData);
//begin
//  LoadKbmMemTable(kbm, TPath.Combine(GetBackupPath, format('Backup_Invoice_Lines_Res_RoomRes_Split_%d_%d_%d.src', [Reservation, RoomReservation, Split])));
//end;
//
//procedure Td.GetBackupInvoiceHeadsReservationRoomReservationsSplitNumber(Reservation, RoomReservation, Split : Integer; kbm : TdxMemData);
//begin
//  LoadKbmMemTable(kbm, TPath.Combine(GetBackupPath, format('Backup_Invoice_Heads_Res_RoomRes_Split_%d_%d_%d.src', [Reservation, RoomReservation, Split])));
//end;
//
//procedure Td.GetBackupPaymentsReservationRoomReservations(Reservation, RoomReservation : Integer; kbm : TdxMemData);
//begin
//  LoadKbmMemTable(kbm, TPath.Combine(GetBackupPath, format('Backup_Payments_Res_RoomRes_%d_%d.src', [Reservation, RoomReservation])));
//end;
//
//function Td.GetBackupReservationRoomReservations(Reservation : Integer) : String;
//begin
//  result := ReadFromTextFile(TPath.Combine(GetBackupPath, format('Backup_Reservation_RoomReservations_%d.src', [Reservation])));
//end;
//
//function Td.GetBackupReservationRoomsDate(Reservation : Integer) : String;
//begin
//  result := ReadFromTextFile(TPath.Combine(GetBackupPath, format('Backup_Reservation_Roomsdate_%d.src', [Reservation])));
//end;
//
//function Td.GetBackupRoomReservationRoomsDate(RoomReservation : Integer) : String;
//begin
//  result := ReadFromTextFile(TPath.Combine(GetBackupPath, format('Backup_RoomReservation_Roomsdate_%d.src', [RoomReservation])));
//end;
//
//function Td.GetBackupRoomIvoice(RoomReservation : Integer) : String;
//begin
//  result := ReadFromTextFile(TPath.Combine(GetBackupPath, format('Backup_Room_Invoice_%d.src', [RoomReservation])));
//end;
//
//function Td.GetBackupRoomReservation(RoomReservation : Integer) : String;
//begin
//  result := ReadFromTextFile(TPath.Combine(GetBackupPath, format('Backup_RoomReservation_%d.src', [RoomReservation])));
//end;
//
//function Td.GetBackupPersons(RoomReservation : Integer; kbm : TdxMemData) : String;
//begin
//  LoadKbmMemTable(kbm, TPath.Combine(GetBackupPath, format('Backup_Persons_%d.src', [RoomReservation])));
//end;
//
//function Td.GetBackupReservations(Reservation : Integer) : String;
//begin
//  result := ReadFromTextFile(TPath.Combine(GetBackupPath, format('Backup_Reservation_%d.src', [Reservation])));
//end;
//
//procedure Td.BackUpDataForOutage;
//var res : String;
//    sPath : String;
//    sourceRSet, rSet : TRoomerDataSet;
//begin
//  if NOT g.BackupMachine then exit;
//
//  sourceRSet := TRoomerDataSet.Create(nil);
//  try
//    SetMainRoomerDataSet(sourceRSet, False);
//
//    sourceRSet.Login(roomerMainDataSet.hotelId, roomerMainDataSet.userName, roomerMainDataSet.password, 'ROOMERPMS',
//              GetVersion(Application.ExeName));
//    try
//      sPath := GetBackupPath;
////      RemoveBackups(sPath);
//
//      BackupTaxes(sourceRSet, sPath);
//
//      // Guest list today
//      res := sourceRSet.SystemGetDayGrid(now, now + 1, GetEnumName(TypeInfo(TReservationStatus),integer(rsAll)));
//      SaveToUtf8TextFile(TPath.Combine(sPath, format('Backup_Guests_%s.src', [dateToSqlString(now)])), res);
//      Application.processMessages;
//      rSet := sourceRSet.ActivateNewDataset(res);
//      ProcessInvoiceBackupsForDate(sourceRSet, sPath, rSet);
//      ProcessReservationBackupsForDate(sourceRSet, sPath, rSet);
//
//      // Guest list tomorrow
//      res := sourceRSet.SystemGetDayGrid(now + 1, now + 2, GetEnumName(TypeInfo(TReservationStatus),integer(rsAll)));
//      SaveToUtf8TextFile(TPath.Combine(sPath, format('Backup_Guests_%s.src', [dateToSqlString(now + 1)])), res);
//      Application.processMessages;
//      ProcessInvoiceBackupsForDate(sourceRSet, sPath, rSet);
//      ProcessReservationBackupsForDate(sourceRSet, sPath, rSet);
//    finally
////      try sourceRSet.Logout; except end;
//    end;
//  finally
//    FreeAndNil(sourceRSet);
//  end;
//
////  DownloadControlTable(sPath);
//end;

//procedure Td.BackupsSubmitInvoiceLinesChanges;
//var files : TStrings;
//    i: Integer;
//    sPath : String;
//
//    rec : recInvoiceLineHolder;
//begin
//  files := TStringlist.create;
//  sPath := GetBackupPath;
//  GetFileList(files, sPath, 'Backup_Invoice_Lines_Res_RoomRes_Split_*.changed');
//  for i := 0 to files.Count - 1 do
//  begin
//    LoadKbmMemTable(dxMemData, TPath.Combine(sPath, ChangeFileExt(files[i], '')));
//    dxMemData.First;
//    if NOT dxMemData.Eof then
//    begin
//      DxMemDataToInvoiceLineHolderRec(dxMemData, rec);
//      roomerMainDataSet.doCommand(format('DELETE FROM invoicelines WHERE Reservation=%d AND RoomReservation=%d AND SplitNumber=%d',
//          [rec.Reservation, rec.RoomReservation, rec.SplitNumber]));
//      while NOT dxMemData.Eof do
//      begin
//        DxMemDataToInvoiceLineHolderRec(dxMemData, rec);
//        SP_INS_InvoiceLine(rec);
//        dxMemData.Next;
//      end;
//    end;
//  end;
//end;
//
//procedure Td.BackupsSubmitInvoiceHeadsChanges;
//var files : TStrings;
//    i: Integer;
//    sPath : String;
//
//    rec : recInvoiceHeadHolder;
//begin
//  files := TStringlist.create;
//  sPath := GetBackupPath;
//  GetFileList(files, sPath, 'Backup_Invoice_Heads_Res_RoomRes_Split_*.changed');
//  for i := 0 to files.Count - 1 do
//  begin
//    LoadKbmMemTable(dxMemData, TPath.Combine(sPath, ChangeFileExt(files[i], '')));
//    dxMemData.First;
//    if NOT dxMemData.Eof then
//    begin
//      DxMemDataToInvoiceHeadHolderRec(dxMemData, rec);
//      roomerMainDataSet.doCommand(format('DELETE FROM invoiceheads WHERE Reservation=%d AND RoomReservation=%d AND SplitNumber=%d',
//          [rec.Reservation, rec.RoomReservation, rec.SplitNumber]));
//      while NOT dxMemData.Eof do
//      begin
//        DxMemDataToInvoiceHeadHolderRec(dxMemData, rec);
//        SP_INS_InvoiceHead(rec);
//        dxMemData.Next;
//      end;
//    end;
//  end;
//end;
//
//procedure Td.BackupsSubmitPaymentChanges;
//var files : TStrings;
//    i, iNewId: Integer;
//    sPath : String;
//
//    rec : recPaymentHolder;
//begin
//  files := TStringlist.create;
//  sPath := GetBackupPath;
//  GetFileList(files, sPath, 'Backup_Payments_Res_RoomRes_*.changed');
//  for i := 0 to files.Count - 1 do
//  begin
//    LoadKbmMemTable(dxMemData, TPath.Combine(sPath, ChangeFileExt(files[i], '')));
//    dxMemData.First;
//    if NOT dxMemData.Eof then
//    begin
//      DxMemDataToPaymentHolderRec(dxMemData, rec);
//      roomerMainDataSet.doCommand(format('DELETE FROM payments WHERE Reservation=%d AND RoomReservation=%d AND InvoiceNumber=-1',
//          [rec.Reservation, rec.RoomReservation]));
//
//      while NOT dxMemData.Eof do
//      begin
//        DxMemDataToPaymentHolderRec(dxMemData, rec);
//        INS_Payment(rec, iNewId);
//        dxMemData.Next;
//      end;
//    end;
//  end;
//end;

//procedure Td.removeChangedFiles;
//begin
//  DeleteFileWithWildcard(GetBackupPath, '*.changed');
//end;

//procedure Td.BackupsSubmitChanges;
//begin
//  if NOT g.BackupMachine then exit;
//
//  roomerMainDataSet.SystemStartTransaction;
//  try
//    BackupsSubmitInvoiceLinesChanges;
//    BackupsSubmitInvoiceHeadsChanges;
//    BackupsSubmitPaymentChanges;
//
//    removeChangedFiles;
//
//    roomerMainDataSet.SystemCommitTransaction;
//  except
//    On e: Exception do
//    begin
//      showmessage(e.Message + #10 + e.StackTrace);
//      roomerMainDataSet.SystemRollbackTransaction;
//    end;
//  end;
//end;

Function Td.BreakFastInclutedCount(reservation : integer) : integer;
var
  rSet : TRoomerDataSet;
  s : string;
begin
  //
  result := 0;
  rSet := CreateNewDataSet;
  try
//    s := s+' SELECT '+chr(10);
//    s := s+'   COUNT(invBreakfast) AS cnt '+chr(10);
//    s := s+' FROM '+chr(10);
//    s := s+'   RoomReservations '+chr(10);
//    s := s+' WHERE '+chr(10);
//    s := s+'   (Reservation = '+_db(Reservation)+') AND (invBreakfast = 1) '+chr(10);
    s := format(select_BreakFastInclutedCount , [Reservation]);
    if hData.rSet_bySQL(rSet,s) then
  	begin
      result := rSet.FieldByName('cnt').asinteger;
    end;
  finally
    freeAndNil(rSet);
  end;
end;

Function Td.GroupAccountCount(reservation : integer) : integer;
var
  rSet : TRoomerDataSet;
  s : string;
begin
  //
  result := 0;

  rSet := CreateNewDataSet;
  try
//    s := s+' SELECT '+chr(10);
//    s := s+'   COUNT(GroupAccount) AS cnt '+chr(10);
//    s := s+' FROM '+chr(10);
//    s := s+'   RoomReservations '+chr(10);
//    s := s+' WHERE '+chr(10);
//    s := s+'   (Reservation = '+_db(Reservation)+') AND (GroupAccount = 1) '+chr(10);
    s := format(select_GroupAccountCount , [Reservation]);
    if hData.rSet_bySQL(rSet,s) then
    begin
      result := rSet.FieldByName('cnt').asinteger;
    end;
  finally
    freeAndNil(rSet);
  end;
end;


  procedure Td.RR_ExcluteFromOpenInvoices(RoomReservation : integer);
  var
    s : string;
  begin
      s := '';
      s := s + ' UPDATE roomreservations '+chr(10);
      s := s + ' Set '+chr(10);
      s := s + ' RoomRentPaymentInvoice = -999 '+chr(10);
      s := s + ' WHERE RoomReservation = ' + inttostr(roomReservation)+chr(10);
      if not cmd_bySQL(s) then
      begin
      end;
  end;


  function Td.rrGetDiscount(RoomReservation: integer; var DiscountType : integer; var DiscountAmount : double) : boolean;
  var
    rSet : TRoomerDataSet;
    s    : string;
    Discount   : double;
    Percentage : boolean;
  begin
    result := false;

    rSet := CreateNewDataSet;
    try
//      s := s+' SELECT '+chr(10);
//      s := s+'     RoomReservation '+chr(10);
//      s := s+'   , Discount '+chr(10);
//      s := s+'   , Percentage '+chr(10);
//      s := s+' FROM RoomReservations '+chr(10);
//      s := s+' WHERE (RoomReservation = '+_db(roomreservation)+') '+chr(10);
      s := format(select_rrGetDiscount , [roomreservation]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        discount   := LocalFloatValue(rSet.FieldByName('discount').asString);
        Percentage := rSet['Percentage'];

        DiscountType := 0;
        if not Percentage then
        begin
          DiscountType := 1;
        end;
        discountAmount := discount;
      end;
    finally
      freeAndNil(rSet);
    end;
  end;

  function Td.rrEditDiscount(RoomReservation: integer; DiscountType : integer; DiscountAmount : double) : boolean;
  var
    rSet : TRoomerDataSet;
    s    : string;
    Discount   : double;
    Percentage : boolean;
  begin
    result := false;

    rSet := CreateNewDataSet;
    try
//      s := s+' SELECT '+chr(10);
//      s := s+'     RoomReservation '+chr(10);
//      s := s+'   , Discount '+chr(10);
//      s := s+'   , Percentage '+chr(10);
//      s := s+' FROM RoomReservations '+chr(10);
//      s := s+' WHERE (RoomReservation = '+_db(roomreservation)+') '+chr(10);
      s := format(select_rrEditDiscount , [roomreservation]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        discount   := discountAmount;;
        Percentage := true;

        if DiscountType = 1 then Percentage := false;
        rSet.Edit;
          rSet.FieldByName('discount').asFloat := discount;
          rSet.FieldByName('Percentage').asBoolean := Percentage;
        rSet.Post; //ID ADDED
        result := true;
      end;
    finally
      freeAndNil(rSet);
    end;
  end;


////////////////////////////////////////////////////////////////////////////////



procedure Td.UpdateStatusSimple(Reservation, RoomReservation: Integer; newStatus : string);
begin

  if (Roomreservation <> 0) then
    d.roomerMainDataSet.SystemSetRoomStatus(RoomReservation, newStatus)
  else
    d.roomerMainDataSet.SystemSetRoomStatusOfReservation(Reservation, newStatus);
//  begin
//    Rset := CreateNewDataSet;
//    try
//      s := format('SELECT RoomReservation FROM roomreservations WHERE reservation=%d', [Reservation]);
//      if hData.rSet_bySQL(Rset, s, D.qConnection, g.qLogLevel,g.qProgramPath) then
//        while not Rset.eof do
//        begin
//          d.roomerMainDataSet.SystemSetRoomStatus(rset.fieldbyname('RoomReservation').AsInteger, newStatus);
//          Rset.next;
//        end;
//    finally
//      freeandnil(Rset);
//    end;
//  end;


//  subtract := true;
//  Roomtype  := '';
//  Arrival   := 1;
//  Departure := 1;
//
//
//  Rset := CreateNewDataSet;
//  try
//    OldStatus := '';
//    if (Roomreservation <> 0) then
//    begin
//      s := format(select_UpdateStatusSimple2, [RoomReservation]);
//      if hData.rSet_bySQL(Rset, s, D.qConnection, g.qLogLevel,g.qProgramPath) then
//      begin
//        OldStatus := Rset.FieldByName('Status').Asstring;
//        if NeedToChangeChannelAvailibility_FromResStatus(newStatus,oldStatus,subtract) then
//        begin
//          arrival   := _dbdateToDate(rset.fieldbyname('Arrival').asString);
//          departure := _dbdateToDate(rset.fieldbyname('departure').asString);
//          roomtype  := rSet.fieldbyname('roomType').asstring;
//          d.roomerMainDataSet.SystemChangeAvailability(RoomType, Arrival, Departure-1, subtract);
////        Showmessage('Do Update Availability  '+Rset.FieldByName('Room').Asstring+'    '+OldStatus+'/'+NewStatus);
//        end;
//      end;
//    end else
//    begin
//      s := format(select_UpdateStatusSimple1, [reservation]);
//      if hData.rSet_bySQL(Rset, s) then
//      begin
//        while not Rset.eof do
//        begin
//          Oldstatus := Rset.FieldByName('status').Asstring;
//          if NeedToChangeChannelAvailibility_FromResStatus(newStatus,oldStatus,subtract) then
//          begin
//            arrival   := _dbdateToDate(rset.fieldbyname('Arrival').asString);
//            departure := _dbdateToDate(rset.fieldbyname('departure').asString);
//            roomtype  := rSet.fieldbyname('roomType').asstring;
//            d.roomerMainDataSet.SystemChangeAvailability(RoomType, Arrival, Departure-1, subtract);
////            Showmessage('Do Update Availability  '+Rset.FieldByName('Room').Asstring+'    '+OldStatus+'/'+NewStatus);
//          end;
//          Rset.next;
//        end;
//      end;
//    end;
//
//    s := '';
//    s := s + ' UPDATE roomreservations ' + chr(10);
//    s := s + ' Set ' + chr(10);
//    s := s + ' Status = ' + _db(newStatus) + chr(10);
//    s := s + ' WHERE Reservation = ' + inttostr(reservation) + chr(10);
//    if RoomReservation > 0 then
//      s := s + '  AND RoomReservation = ' + inttostr(RoomReservation) + chr(10);
//    if not cmd_bySQL(s) then
//    begin
//    end;
//
//    s := '';
//    s := s + 'UPDATE roomsdate ' + chr(10);
//    s := s + 'Set' + chr(10);
//    s := s + ' resFlag = ' + _db(newStatus) + chr(10);
//    s := s + ', updated = 1 ' + chr(10);
//    s := s + 'WHERE Reservation = ' + inttostr(reservation) + chr(10);
//    if RoomReservation > 0 then
//      s := s + ' AND RoomReservation = ' + inttostr(RoomReservation) + chr(10);
//    if not cmd_bySQL(s) then
//    begin
//    end;
//
//
//    // IF departing then set rooms to unclean and update current guestlist
//    if (newStatus = 'D') and (RoomReservation = 0)  then //Change the whole reservation
//    begin
//      s := format(select_UpdateStatusSimple1, [reservation]);
//      if hData.rSet_bySQL(Rset, s) then
//      begin
//        while not Rset.eof do
//        begin
//          Room := Rset.FieldByName('Room').Asstring;
//          RR := Rset.FieldByName('RoomReservation').AsInteger;
//          if D.isRRCurrentlyCheckedIn(rr) then
//          begin
//            g.updateCurrentGuestlist;
//          end;
//          SetUnclean(Room);
//          Rset.next;
//        end;
//      end;
//    end;
//
//    if (newStatus = 'D') and (Roomreservation <> 0) then //Update only this roomreservation
//    begin
//      s := format(select_UpdateStatusSimple2, [RoomReservation]);
//      if hData.rSet_bySQL(Rset, s, D.qConnection, g.qLogLevel,g.qProgramPath) then
//      begin
//        Room := Rset.FieldByName('Room').Asstring;
//        SetUnclean(Room);
//        if D.isRrCurrentlyCheckedIn(RoomReservation) then
//        begin
//          g.updateCurrentGuestlist;
//        end;
//      end;
//    end;
//
//
//
//  finally
//    freeandnil(Rset);
//  end;

end;

function Td.SetAsNoRoom(RoomReservation: integer): Boolean;
var
  s: string;
  sRoom: string;
  sRoomType: string;
    NewRoom : string;
    Rset : TRoomerDataSet;
  begin
    result := true;
//    s := s + ' SELECT '+chr(10);
//    s := s + '    RoomReservation '+chr(10);
//    s := s + '  , Room '+chr(10);
//    s := s + '  , RoomType '+chr(10);
//    s := s + ' FROM '+chr(10);
//    s := s + '   RoomReservations '+chr(10);
//    s := s + ' WHERE '+chr(10);
//    s := s + '   RoomReservation = ' + inttostr(RoomReservation) + ' '+chr(10);

    Rset := CreateNewDataSet;
    try
      s := format(select_SetAsNoRoom , [RoomReservation]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        sRoom := Rset.fieldbyname('room').asString;
        sRoomType := Rset.fieldbyname('roomtype').asString;
      end;
    finally
      freeandnil(Rset);
    end;

    NewRoom := '<' + inttostr(RoomReservation) + '>';
    s := '';
    s := s + ' UPDATE '+chr(10);
    s := s + '   roomreservations '+chr(10);
    s := s + ' SET '+chr(10);
    s := s + '   Room = ' + _db(NewRoom) + ' '+chr(10);
    s := s + '   ,rrIsNoRoom = 0 '+chr(10);
    s := s + '   ,rrRoomAlias = ' + _db(sRoom) + ' '+chr(10);
    s := s + '   ,rrRoomTypeAlias = ' + _db(sRoomType) + ' '+chr(10);
    s := s + ' WHERE '+chr(10);
    s := s + '   RoomReservation = ' + inttostr(RoomReservation) + ' '+chr(10);
    if not cmd_bySQL(s) then
    begin
      result := false;
    end;

    // <roomsdate>xUPDATE **SetAsNoRoom**
    //**xzhj
    s := '';
    s := s + ' UPDATE '+chr(10);
    s := s + '   roomsdate '+chr(10);
    s := s + ' SET '+chr(10);
    s := s + '   Room = ' + _db(NewRoom) + ' '+chr(10);
    s := s + ' , updated = 1 '+chr(10);
    s := s + ' , isNoRoom = 0 '+chr(10);
    s := s + ' WHERE '+chr(10);
    s := s + '   RoomReservation = ' + inttostr(RoomReservation) + ' '+chr(10);
    if not cmd_bySQL(s) then
    begin
      result := false;
    end;
  end;


function WebColorToDelphiColor(const AWebColor: string): TColor;
var
  lRed : Integer;
  lGreen : Integer;
  lBlue : Integer;
begin
  Result := clNone;

  if (Length(AWebColor) = 8) and (AWebColor[2] = 'x') then
  begin
    lRed := StrToInt('$' + Copy(AWebColor, 3, 2));
    lGreen := StrToInt('$' + Copy(AWebColor, 4, 2));
    lBlue := StrToInt('$' + Copy(AWebColor, 7, 2));
    Result := RGB(lRed, lGreen, lBlue); //  TColor((lBlue * 65536) + (lGreen * 256) + lRed);
  end;
end;

function HtmlToColor(s:string;aDefault:Tcolor):TColor;
begin
  if copy(s,1,2)='0x' then begin
    s:='$'+copy(s,7,2)+copy(s,5,2)+copy(s,3,2);
  end
  else
    s:='clNone';
  try
    result:=StringToColor(s);
  except
    result:=aDefault;
  end;
end;

procedure Td.ClearMaintenanceCodes;
begin
  while lstMaintenanceCodes.Count > 0 do
    lstMaintenanceCodes.delete(0);
end;

procedure Td.LoadMaintenanceCodes;
var
  tempSet: TRoomerDataSet;
  iTemp : integer;
begin
  tempSet := glb.GetDataSetFromDictionary('maintenancecodes');
//  tempSet.CommandText := 'SELECT * FROM maintenancecodes';
//  tempSet.Open;
  tempSet.First;
  while not tempSet.Eof do
  begin
    iTemp := HtmlToColor(tempSet['color'], clBlack);
    lstMaintenanceCodes.Add(TKeyAndValue.Create(tempSet['code'], inttostr(iTemp)));
    tempSet.Next;
  end;
end;

procedure Td.PrepareFixedTables;
begin
  LoadMaintenanceCodes;

  if frmMain.OfflineMode then
    exit;
  
  zMaidActionsSortField := 'maAction';
  zMaidActionsSortDir := '';
  OpenMaidActionsQuery(zMaidActionsSortField, zMaidActionsSortDir);

  OpenViewRoomsQuery('Room', '');

  zItemsSortField := 'Item';
  zItemsSortDir := '';
  OpenItemsQuery(zItemsSortField, zItemsSortDir);


  zRoomPricesSortField_1 := 'RoomType';
  zRoomPricesSortDir_1 := '';
  OpenRoomPricesQuery_1(zRoomPricesSortField_1, zRoomPricesSortDir_1, -1, -1, '', '', 1);


  zTelPriceRulesSortField := 'displayOrder';
  zTelPriceRulesSortDir := '';
  OpenTelPriceRulesQuery(zTelPriceRulesSortField, zTelPriceRulesSortDir);

  zTelPriceGroupsSortField := 'Code';
  zTelPriceGroupsSortDir := '';
  OpenTelPriceGroupsQuery(zTelPriceGroupsSortField, zTelPriceGroupsSortDir);

  OpenViewRoomsQuery('Room', '');
  g.qLastImportLogID := importLog_GetLastID;

  // **************** BHG : Below commands were the last part of the Create event *****************
  RoomsDateSetWork := CreateNewDataSet;
  RoomsDateSetWork.CommandType := cmdText;


  lstVaribles := tstringList.Create;
  lstValues := tstringList.Create;

  ctrlGetGlobalValues;
  lstCollect := tstringList.Create;

  memImportResults_Fill;
  memImportTypes_Fill;
  chkInPosMonitor;
  chkConfirmmonitor;

end;

function Td.LocateRecord(rSet : TRoomerDataSet; FieldName : String; value : Integer) : boolean;
begin
  result := False;
  rSet.First;
  while NOT rSet.Eof do
  begin
    if rSet[FieldName] = value then
    begin
      result := True;
      Break;
    end;
    rSet.Next;
  end;
end;

function Td.LocateRecord(rSet : TRoomerDataSet; FieldName : String; value : String) : boolean;
begin
  result := False;
  rSet.First;
  while NOT rSet.Eof do
  begin
    if LowerCase(rSet[FieldName]) = LowerCase(value) then
    begin
      result := True;
      Break;
    end;
    rSet.Next;
  end;
end;

function Td.MoveRoom(RoomReservation : integer; NewRoom : string) : boolean;
var
  sRoom : string;
  isNoRoom : boolean;
  Rset : TRoomerDataSet;

begin
  result := true;
  try
//    if NOT roomerMainDataSet.OfflineMode then
//    begin
      roomerMainDataSet.SystemMoveRoom(RoomReservation, newRoom);
      try
      AddReservationActivityLog(g.quser
                                ,-1
                                ,RoomReservation
                                ,NEW_ROOM_NUMBER
                                ,''
                                ,NewRoom
                                ,'');
      Except
      end;



//    end
//    else
//    begin
//      rSet := roomerMainDataSet.ActivateNewDataset(GetBackupTodaysGuests);
//      isNoRoom := (newRoom = '');
//      if isNoRoom then
//        sRoom := '<' + newRoom + '>'
//      else
//        sRoom := newRoom;
//      if LocateRecord(rSet, 'RoomReservation', RoomReservation) then
//      begin
//        rSet.Edit;
//        rSet['Room'] := sRoom;
//        rSet.Post;
//        BackupTodaysGuestsList(rSet);
//      end;
//    end;
  except
    result := False;
  end;
//

end;

function Td.ChangeRrDates(RoomReservation : integer; newArrival, newDeparture : Tdate; updateRoomstatus : boolean) : boolean;
var
  lst : tstringList;

  function foundInList(const lookFor : string) : boolean;
  var
    i : integer;
  begin
    result := false;
    for i := 0 to lst.Count - 1 do
    begin
      if _trimlower(lookFor) = lst[i] then
        result := true;
    end;
  end;

var
  iNumErrors : integer;

  s : string;

  reservation : integer;

  Room : string;
  RoomType : string;
  status : string;

  Currency : string;

  sNewArrival : string;
  sNewDeparture : string;

  NumDays : integer;

  Rset : TRoomerDataSet;

  doIt : boolean;
  ii : integer;

  ChkRoomReservation : integer;
  sChkRoomreservation : string;
  chkDate : Tdate;

  guestCount  : integer;
  childCount  : integer;
  infantCount : integer;
  PriceID     : integer;

  priceType : string;

  Discount     : double ;
  isPercentage : boolean;
  showDiscount : boolean;

begin
  doIt := false;
  sNewArrival    := _DateToDBDate(newArrival,false);
  sNewDeparture  := _DateToDBDate(newDeparture,false);
  NumDays        := trunc(newDeparture) - trunc(newArrival);

  if NumDays < 1 then
  begin
    Showmessage (GetTranslatedText('shTx_D_CheckDates'));
  end;

  showDiscount := true;

  lst := tstringList.Create;
  try
    Rset := CreateNewDataSet;
    try
      s := format(select_ChangeRrDates , [RoomReservation]);
      if hData.rSet_bySQL(rSet,s) then
      begin
        reservation      := Rset.fieldbyname('Reservation').asInteger;
        RoomReservation  := Rset.fieldbyname('RoomReservation').asInteger;
        Room             := trim(Rset.fieldbyname('Room').asString);
        RoomType         := hdata.GET_RoomsType_byRoom(Room);
        GuestCount       := Rset.fieldbyname('numGuests').asInteger;
        childCount       := Rset.fieldbyname('numChildren').asInteger;
        infantCount      := Rset.fieldbyname('numInfants').asInteger;

        if RoomType = '' then
        begin
          RoomType := trim(Rset.fieldbyname('RoomType').asString);
        end;

        status       := Rset.fieldbyname('Status').asString;
        PriceType    := trim(Rset.fieldbyname('PriceType').asString);
        PriceId      := hdata.PriceCode_ID(priceType);
        Currency     := trim(Rset.fieldbyname('Currency').asString);
        discount     := rSet.GetFloatValue(rset.FieldByName('discount'));
        isPercentage := rset.FieldByName('Percentage').Asboolean;

        lst.clear;
        doIt := true;

        for ii := trunc(newArrival) to trunc(newArrival) + NumDays - 1 do
        begin
          chkDate := ii;
          if d.isDay_Occupied(chkDate, Room, ChkRoomReservation) then
          begin
            if ChkRoomReservation <> RoomReservation then
            begin
              sChkRoomreservation := inttostr(ChkRoomReservation);
              if not foundInList(sChkRoomreservation) then
                lst.Add(sChkRoomreservation);
              doIt := false;
            end;
          end;
        end;

        if lst.Count > 0 then
        begin
          case g.OpenRoomDateProblem(lst) of
            0 :
              begin
                for ii := 0 to lst.Count - 1 do
                begin
                  ChkRoomReservation := strToInt(lst[ii]);
                  MoveToRoomEnh2(ChkRoomReservation, '');
                end;
                doIt := true;
              end;
            1 :
              begin
                Room := '';
                doIt := true;
              end;
            3 :
              begin
                doIt := false;
              end;
          end;
        end;

        if doIt then
        begin
          // d.RemoveRoomsDate(RoomReservation);
          iNumErrors := 0;

         //d.AddRoomsDate(sNewArrival, Room, RoomType, status, RoomReservation, reservation, NumDays, iNumErrors);

          hdata.AddRoomsDate(NewArrival
                             ,Room
                             ,RoomType
                             ,status
                             ,currency
                             ,priceID
                             ,guestCount
                             ,ChildCount
                             ,infantCount
                             ,Discount
                             ,isPercentage
                             ,showDiscount
                             ,RoomReservation
                             ,reservation
                             ,NumDays
                             ,iNumErrors
                             );

          if iNumErrors > 0 then
          begin
            //s := 'Some errors ' + #10;
            //s := s + inttostr(iNumErrors) + ' total ' + #10 + #10;
            s := GetTranslatedText('shTx_D_SomeErrors') + #10;
            s := s + inttostr(iNumErrors) + GetTranslatedText('shTx_D_Total') + #10 + #10;
            MessageDlg(s, mtWarning, [mbOK], 0);
          end else
          begin
            Rset.edit;
            Rset.fieldbyname('Arrival').asString := sNewArrival;
            Rset.fieldbyname('Departure').asString := sNewDeparture;
            Rset.fieldbyname('rrDeparture').asDateTime := newDeparture;
            Rset.fieldbyname('rrArrival').asDateTime := newArrival;
            Rset.Post;

          end;
        end;
      end; //rSEt
    finally
      freeandnil(Rset);
    end;
  finally
    lst.Free;
  end;
  result := doIt;
end;







  procedure Td.RemoveReservation(iReservation : integer;CancelStaff,CancelReason,CancelInformation : string;CancelType : integer);
  var
    Rset : TRoomerDataSet;
    s : string;

    DayCount : integer;
    FirstDate : Tdate;
    LastDate : Tdate;

    RoomReservation : integer;
    RoomReservationCount : integer;
    invoices : string;
  begin
    invoices := '';

    Rset := CreateNewDataSet;
    try
      s := format(select_RemoveReservation , [iReservation]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        invoices := '';
        while not Rset.Eof do
        begin
          invoices := invoices + Rset.fieldbyname('InvoiceNumber').asString + ', ';
          Rset.Next;
        end;
      end;
    finally
      freeandnil(Rset);
    end;

    if invoices <> '' then
    begin
	    if MessageDlg(GetTranslatedText('shTx_D_InvoicesBooked'), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
	    begin
        exit;
      end
      else
      begin
		    s := format(GetTranslatedText('shTx_D_InvoicesBookedNumbersWriteDown'), [invoices]);
        Showmessage(s);
      end;
    end;


    if MessageDlg(GetTranslatedText('shTx_D_DeleteAll'), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      roomerMainDataSet.SystemRemoveReservation(iReservation, true, true, CancelReason, CancelStaff, CancelInformation, CancelType);
      frmDayNotes.RefreshRoomStatus; //hj 140527
    end else
    begin
      exit;
    end;
  end;

function Td.RetrieveFinancesKeypair(keyPairType : TKeyPairType) : TKeyPairList;
  var i, l : Integer;
      s : String;
      sa : TArrayOfString;
      cursorWas : SmallInt;
  begin
    CursorWas := Screen.Cursor;
    Screen.Cursor := crHourglass; Application.ProcessMessages;
    try
      case keyPairType of
        FKP_CUSTOMERS: s := roomerMainDataSet.SystemFinanceListCustomers;
        FKP_PRODUCTS: s := roomerMainDataSet.SystemFinanceListProducts;
        FKP_PAYTYPES: s := roomerMainDataSet.SystemFinanceListPaymentTypes;
      end;

      sa := SplitString(#10, s);
      result := TKeyPairList.Create(True);
      for i := LOW(sa) to HIGH(sa) do
      begin
        s := sa[i];
        l := pos('=', s);
        if l > 0 then
        begin
          result.Add(TKeyAndValue.Create(copy(s, 1, l - 1), copy(s, l +1, length(s))));
        end;
      end;
    finally
      Screen.Cursor := CursorWas; Application.ProcessMessages;
    end;
  end;

  function Td.KeyExists(keyList : TKeyPairList; key : String) : Boolean;
  var i : Integer;
  begin
    result := false;
    for i := 0 to keyList.Count - 1 do
    begin
      if keyList[i].Key = key then
      begin
        result := true;
        Break;
      end;
    end;
  end;


  procedure Td.CheckInGuest(RoomReservation : integer);
  begin
    d.roomerMainDataSet.SystemSetRoomStatus(RoomReservation, STATUS_ARRIVED);
    g.updateCurrentGuestlist;
//    Rset := CreateNewDataSet;
//    try
//      s := format(select_CheckInGuest , [RoomReservation]);
//      if hData.rSet_bySQL(rSet,s) then
//      begin
//        Room      := rSet.fieldbyname('Room').asstring;
//        Arrival   := _dbDateToDate(rSet.fieldbyname('Arrival').asstring);
//        Departure := _dbDateToDate(rSet.fieldbyname('Departure').asstring);
//        RoomType  := rSet.fieldbyname('RoomType').asstring;
//        oldStatus := rSet.fieldbyname('status').asstring;
//
//        if oldStatus = 'G' then
//        begin
//          Showmessage(format(GetTranslatedText('shTx_D_RoomAlreadyCheckedin'), [Rset.fieldbyname('Room').asString]));
//          exit;
//        end;
//
//        if (oldstatus = 'O') or (oldStatus='N') then
//        begin
//          d.roomerMainDataSet.SystemChangeAvailability(RoomType, Arrival, Departure-1, true);
//        end;
//      end;
//
//      s := '';
//      s := s + ' UPDATE roomreservations '+chr(10);
//      s := s + '   SET Status = ' + _db('G')+chr(10);
//      s := s + ' WHERE '+chr(10);
//      s := s + '  [RoomReservation] = ' + inttostr(RoomReservation)+chr(10);
//      if not cmd_bySQL(s) then
//      begin
//      end;
//
//
//      // <roomsdate>xUPDATE **CheckInGuest**
//      s := '';
//      s := s + ' UPDATE roomsdate'+chr(10);
//      s := s + ' Set '+chr(10);
//      s := s + ' resFlag = ' + _db('G')+chr(10);
//      s := s + ',updated = 0 '+chr(10);
//      s := s + ' WHERE  RoomReservation = ' + inttostr(RoomReservation)+chr(10);
//      if not cmd_bySQL(s) then
//      begin
//      end;
//
//      g.updateCurrentGuestlist;
//    finally
//      freeandnil(Rset);
//    end;
  end;

  procedure Td.CheckOutGuest(RoomReservation : integer; Room : String);
//  var
//    s : string;
//    Room : string;
//
//    DayCount : integer;
//    Processed : integer;
//    FirstDate : Tdate;
//    LastDate : Tdate;
//
//    reservation : integer;
//
//
//    RoomType  : string;
//    Arrival   : Tdate;
//    departure : Tdate;
//    Status : string;

  begin

    d.roomerMainDataSet.SystemSetRoomStatus(RoomReservation, STATUS_CHECKED_OUT);
    SetUnclean(Room);
    g.updateCurrentGuestlist;

//    if getCangeAvailabilityInfo(roomreservation,RoomType,status,Arrival,departure) then
//    begin
//      if (status = 'O') or (Status='N') then
//      begin
//        d.roomerMainDataSet.SystemChangeAvailability(RoomType, Arrival, Departure-1, false); //auka framboð
//      end;
//    end;
//
//
//    s := '';
//    s := s + 'UPDATE roomreservations '+chr(10);
//    s := s + '   Set Status = ' + _db('D')+chr(10);
//    s := s + ' where RoomReservation = ' + inttostr(RoomReservation)+chr(10);
//    if not cmd_bySQL(s) then
//    begin
//    end;
//
//      // <roomsdate>xUPDATE **CheckOutGuest**
//    s := '';
//    s := s + ' UPDATE roomsdate'+chr(10);
//    s := s + ' Set'+chr(10);
//    s := s + '   resFlag = ' + _db('D')+chr(10);
//    s := s + ',  updated = 0 '+chr(10);
//    s := s + ' where '+chr(10);
//    s := s + '   Roomreservation = ' + inttostr(RoomReservation)+chr(10);
//    if not cmd_bySQL(s) then
//    begin
//    end;
//
//    Room := RR_GetRoomNr(RoomReservation);
//    SetUnclean(Room);
//    g.updateCurrentGuestlist;
  end;


function Td.RemoveRoomsDatebyReservation(iReservation : integer) : boolean;
  var
    s : string;
  begin
    result := false;

    s := '';
//    s := s + ' DELETE FROM roomsdate '+chr(10);
//    s := s + ' WHERE Reservation = ' + inttostr(iReservation)+chr(10);

    //**zxhj Breytti hér
    s := 'UPDATE roomsdate SET ResFlag ='+_db(STATUS_DELETED)+' '#10;
    s := s + ' WHERE Reservation = ' + inttostr(iReservation)+chr(10);
    if not cmd_bySQL(s) then
    begin
      result := false;
    end;
  end;

  function Td.ChkFinished(invNr : integer) : integer;
  var
    s : string;
    Rset : TRoomerDataSet;
    sql : string;
  begin
    result := 0;
    Rset := CreateNewDataSet;
    try

      sql:=
      ' SELECT'+
      '     InvoiceNumber'+
      ' FROM'+
      '    tblinvoiceactions'+
      ' WHERE'+
      '  invoiceNumber= %d ';
      s := format(sql , [invNr]);
      if hData.rSet_bySQL(rSet,s) then
    	begin
        result := Rset.recordCount;
      end;
    finally
      freeandnil(Rset);
    end;
  end;


procedure Td.CreateMtFields;
  begin
    // Create HeadFields
    if d.mtHead_.active then
      d.mtHead_.close;
    d.mtHead_.FieldDefs.clear;

    d.mtHead_.FieldDefs.Add('Customer', ftWideString, 100, false);
    d.mtHead_.FieldDefs.Add('CustomerName', ftWideString, 100, false);
    d.mtHead_.FieldDefs.Add('Address1', ftWideString, 100, false);
    d.mtHead_.FieldDefs.Add('Address2', ftWideString, 100, false);
    d.mtHead_.FieldDefs.Add('Address3', ftWideString, 100, false);
    d.mtHead_.FieldDefs.Add('Address4', ftWideString, 100, false);
    d.mtHead_.FieldDefs.Add('Country', ftWideString, 100, false);
    d.mtHead_.FieldDefs.Add('PersonalId', ftWideString, 100, false);
    d.mtHead_.FieldDefs.Add('GuestName', ftWideString, 100, false);
    d.mtHead_.FieldDefs.Add('Breakfast', ftFloat);
    d.mtHead_.FieldDefs.Add('ExtraText', ftMemo);
    d.mtHead_.FieldDefs.Add('InvoiceDate', ftDate);
    d.mtHead_.FieldDefs.Add('payDate', ftDate);
    d.mtHead_.FieldDefs.Add('Staff', ftWideString, 40, false);
    d.mtHead_.FieldDefs.Add('InvoiceNumber', ftInteger);
    d.mtHead_.FieldDefs.Add('LocalCurrency', ftString, 03, false);
    d.mtHead_.FieldDefs.Add('Currency', ftString, 03, false);
    d.mtHead_.FieldDefs.Add('CurrencyRate', ftFloat);

    d.mtHead_.FieldDefs.Add('Reservation', ftInteger);
    d.mtHead_.FieldDefs.Add('RoomReservation', ftInteger);
    d.mtHead_.FieldDefs.Add('RoomNumber', ftWideString, 100, false);

    d.mtHead_.FieldDefs.Add('Total', ftFloat);
    d.mtHead_.FieldDefs.Add('TotalwoVAT', ftFloat);
    d.mtHead_.FieldDefs.Add('TotalVAT', ftFloat);

    d.mtHead_.FieldDefs.Add('TotalBreakfast', ftFloat);
    d.mtHead_.FieldDefs.Add('CreditInvoice', ftInteger);
    d.mtHead_.FieldDefs.Add('OrginalInvoice', ftInteger);
    d.mtHead_.FieldDefs.Add('TotalPayments', ftFloat);

    d.mtHead_.FieldDefs.Add('foTotal', ftFloat);
    d.mtHead_.FieldDefs.Add('foTotalwoVAT', ftFloat);
    d.mtHead_.FieldDefs.Add('foTotalVAT', ftFloat);

    d.mtHead_.FieldDefs.Add('isKredit', ftBoolean);

    // caculated values
    d.mtHead_.FieldDefs.Add('PaymentLine', ftMemo);
    d.mtHead_.FieldDefs.Add('foPaymentLine', ftMemo);
    d.mtHead_.FieldDefs.Add('invRefrence', ftWideString, 60, false);

    d.mtHead_.FieldDefs.Add('invPrintText', ftWideString, 100, false);

    d.mtHead_.FieldDefs.Add('TotalStayTax', ftFloat);
    d.mtHead_.FieldDefs.Add('TotalStayTaxNights', ftInteger);

    d.mtHead_.FieldDefs.Add('PrePaid', ftFloat);
    d.mtHead_.FieldDefs.Add('Balance', ftFloat);
    d.mtHead_.FieldDefs.Add('foPrePaid', ftFloat);
    d.mtHead_.FieldDefs.Add('foBalance', ftFloat);

    d.mtHead_.FieldDefs.Add('Package', ftWideString, 40, false);  //*99+
    d.mtHead_.FieldDefs.Add('PackageName', ftWideString, 150, false); //*99+
    d.mtHead_.FieldDefs.Add('ShowPackage', ftboolean); //*99+
    d.mtHead_.FieldDefs.Add('Location',ftWideString, 20, false);


    if d.mtLines_.active then
      d.mtLines_.close;
    d.mtLines_.FieldDefs.clear;

    d.mtLines_.FieldDefs.Add('lineNo', ftInteger);
    d.mtLines_.FieldDefs.Add('Date', ftDate);
    d.mtLines_.FieldDefs.Add('Code', ftWideString, 40);
    d.mtLines_.FieldDefs.Add('Description', ftWideString, 200);
    d.mtLines_.FieldDefs.Add('Count', ftFloat);
    d.mtLines_.FieldDefs.Add('Price', ftFloat); //-96
    d.mtLines_.FieldDefs.Add('Amount', ftFloat);
    d.mtLines_.FieldDefs.Add('AmountWoVat', ftFloat);
    d.mtLines_.FieldDefs.Add('VatAmount', ftFloat);
    d.mtLines_.FieldDefs.Add('VatCode', ftWideString, 20);
    d.mtLines_.FieldDefs.Add('foPrice', ftFloat);
    d.mtLines_.FieldDefs.Add('foAmount', ftFloat);
    d.mtLines_.FieldDefs.Add('foAmountWoVat', ftFloat);
    d.mtLines_.FieldDefs.Add('foVatAmount', ftFloat);
    d.mtLines_.FieldDefs.Add('AccountKey', ftString, 20);
    d.mtLines_.FieldDefs.Add('importRefrence', ftWideString, 40);
    d.mtLines_.FieldDefs.Add('importSource', ftWideString, 60);

    d.mtLines_.FieldDefs.Add('isPackage', ftBoolean);  //*99+
    d.mtLines_.FieldDefs.Add('isRoomRent', ftBoolean); //*99+
    d.mtLines_.FieldDefs.Add('Show', ftBoolean);  //*99+


    if d.mtPayments_.active then
      d.mtPayments_.close;
    d.mtPayments_.FieldDefs.clear;

    d.mtPayments_.FieldDefs.Add('Date', ftDate);
    d.mtPayments_.FieldDefs.Add('Code', ftWideString, 40);
    d.mtPayments_.FieldDefs.Add('Amount', ftFloat);
    d.mtPayments_.FieldDefs.Add('foAmount', ftFloat);
    d.mtPayments_.FieldDefs.Add('Description', ftWideString, 100);
    d.mtPayments_.FieldDefs.Add('TypeIndex', ftinteger);

    if d.mtVAT_.active then
      d.mtVAT_.close;
    d.mtVAT_.FieldDefs.clear;

    d.mtVAT_.FieldDefs.Add('Code', ftWideString, 40);
    d.mtVAT_.FieldDefs.Add('Description', ftWideString, 100);
    d.mtVAT_.FieldDefs.Add('Price_woVAT', ftFloat);
    d.mtVAT_.FieldDefs.Add('Price_wVAT', ftFloat);
    d.mtVAT_.FieldDefs.Add('VATAmount', ftFloat);
    d.mtVAT_.FieldDefs.Add('VATPercentage', ftFloat);

    d.mtVAT_.FieldDefs.Add('foPrice_woVAT', ftFloat);
    d.mtVAT_.FieldDefs.Add('foPrice_wVAT', ftFloat);
    d.mtVAT_.FieldDefs.Add('foVATAmount', ftFloat);

    if mtCompany_.active then
      mtCompany_.close;
    mtCompany_.FieldDefs.clear;

    mtCompany_.FieldDefs.Add('CompanyName', ftWideString, 100, false);
    mtCompany_.FieldDefs.Add('Address1', ftWideString, 100, false);
    mtCompany_.FieldDefs.Add('Address2', ftWideString, 100, false);
    mtCompany_.FieldDefs.Add('Address3', ftWideString, 100, false);
    mtCompany_.FieldDefs.Add('Address4', ftWideString, 100, false);
    mtCompany_.FieldDefs.Add('Country', ftWideString, 100, false);
    mtCompany_.FieldDefs.Add('TelePhone1', ftWideString, 100, false);
    mtCompany_.FieldDefs.Add('TelePhone2', ftWideString, 100, false);
    mtCompany_.FieldDefs.Add('Fax', ftWideString, 100, false);
    mtCompany_.FieldDefs.Add('Email', ftWideString, 200, false);
    mtCompany_.FieldDefs.Add('HomePage', ftWideString, 200, false);
    mtCompany_.FieldDefs.Add('CompanyPID', ftWideString, 40, false);
    mtCompany_.FieldDefs.Add('CompanyVATno', ftWideString, 100, false);
    mtCompany_.FieldDefs.Add('CompanyBankInfo', ftWideString, 40, false);

    if mtCaptions_.active then
      mtCaptions_.close;
    mtCaptions_.FieldDefs.clear;

    mtCaptions_.FieldDefs.Add('invTxtHead', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtHeadDebit', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtHeadKredit', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtHeadInfoNumber', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtHeadInfoDate', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtHeadInfoCustomerNo', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtHeadInfoGjalddagi', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtHeadInfoEindagi', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtHeadInfoLocalCurrency', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtHeadInfoCurrency', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtHeadInfoCurrencyRate', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtHeadInfoReservation', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtHeadInfoCreditInvoice', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtHeadInfoOrginalInfo', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtHeadInfoGuest', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtHeadInfoRoom', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtLinesItemNo', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtLinesItemText', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtLinesItemCount', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtLinesItemPrice', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtLinesItemAmount', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtLinesItemTotal', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtExtra1', ftWideString, 400, false);
    mtCaptions_.FieldDefs.Add('invTxtExtra2', ftWideString, 400, false);
    mtCaptions_.FieldDefs.Add('invTxtFooterLine1', ftWideString, 400, false);
    mtCaptions_.FieldDefs.Add('invTxtFooterLine2', ftWideString, 400, false);
    mtCaptions_.FieldDefs.Add('invTxtFooterLine3', ftWideString, 400, false);
    mtCaptions_.FieldDefs.Add('invTxtFooterLine4', ftWideString, 400, false);
    mtCaptions_.FieldDefs.Add('invTxtPaymentListHead', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtPaymentListCode', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtPaymentListAmount', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtPaymentListDate', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtPaymentListTotal', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtPaymentLineHead', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtPaymentLineSeperator', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtVATListHead', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtVATListDescription', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtVATListwoVAT', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtVATListwVAT', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtVATListVATpr', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtVATListVATAmount', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtVATListTotal', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtVATLineHead', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtVATLineSeperator', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtTotalwoVAT', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtTotalVATAmount', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtTotalTotal', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtCompanyName', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtCompanyAddress', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtCompanyTel1', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtCompanyTel2', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtCompanyFax', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtCompanyEmail', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtCompanyHomePage', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtCompanyPID', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtCompanyBankInfo', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtCompanyVATId', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtTotalStayTax', ftWideString, 200, false);
    mtCaptions_.FieldDefs.Add('invTxtTotalStayTaxNights', ftWideString, 100, false);


    mtCaptions_.FieldDefs.Add('invTxtPaymentListDescription', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtHeadPrePaid', ftWideString, 100, false);
    mtCaptions_.FieldDefs.Add('invTxtHeadBalance', ftWideString, 100, false);

  end;
{ TKeyAndValue }




constructor TKeyAndValue.Create(Key, Value: String);
begin
  FKey := Key;
  FValue := Value;
end;

// *********************************************************************************


  procedure Td.RemoveReservationNotSave(iReservation : integer;CancelStaff,CancelReason,CancelInformation : string;CancelType : integer);
//  var
//    Rset : TRoomerDataSet;
//    s : string;
//    RoomReservation : integer;
//    RoomReservationCount : integer;
//    lstRoomReservations : TstringList;
//    i : integer;
  begin
//    RoomReservation  := 0;
//    RoomReservationCount := 0;
//
//    lstRoomReservations := TstringList.Create;
//    try
//      RoomReservationCount := GetReservationRRList(iReservation, lstRoomReservations);
//      if RoomReservationCount < 1 then exit; // ==>
//
//      for i := 0 to RoomReservationCount - 1 do
//      begin
//        RoomReservation := strToint(lstRoomReservations[i]);
//        ins_delRoomReservationInfo(RoomReservation,CancelStaff,CancelReason,CancelInformation,CancelType);
//      end;
//    finally
//      freeandNil(lstRoomreservations);
//    end;
    roomerMainDataSet.SystemRemoveReservation(iReservation, true, true, CancelReason, CancelStaff, CancelInformation, CancelType);
  end;


CONST MIN_PROFORMA_INVOICENUMBER = 2000000000;
CONST MAX_PROFORMA_INVOICENUMBER = 2100000000;

function GenerateProformaInvoiceNumber : Integer;
var dTemp : dWord;
begin
  dTemp := GetTickCount;
  if dTemp < MIN_PROFORMA_INVOICENUMBER then
     dTemp := MIN_PROFORMA_INVOICENUMBER + dTemp;
  while dTemp > MAX_PROFORMA_INVOICENUMBER do
    dTemp := MIN_PROFORMA_INVOICENUMBER + (dTemp - MAX_PROFORMA_INVOICENUMBER);
  result := dTemp;
end;


////////////////////////////////////////////////////////////////////////////////////////////
//
// Turnower and payments
//

procedure Td.kbmRoomRentOnInvoice_BeforePost(DataSet: TDataSet);
begin
  if (DataSet.FieldByName('splitnumber').asinteger = 1) and (DataSet.FieldByName('isTaxIncluted').asboolean = true) then
  begin
    DataSet.FieldByName('totalStayTax').asinteger := DataSet.FieldByName('totalStayTax').asinteger * -1
  end;
end;


procedure Td.mInvoiceHeadsBeforePost(DataSet: TDataSet);
begin
  DataSet.FieldByName('isCash').asboolean := false;
  DataSet.FieldByName('isKredit').asboolean := false;
  DataSet.FieldByName('isGroup').asboolean := false;
  DataSet.FieldByName('isRoom').asboolean := false;

  if DataSet.FieldByName('SplitNumber').asinteger = 1 then
  begin
    DataSet.FieldByName('isKredit').asboolean := true;
  end;

  if (DataSet.FieldByName('Reservation').asinteger = 0) AND
    (DataSet.FieldByName('RoomReservation').asinteger = 0) then
  begin
    DataSet.FieldByName('isCash').asboolean := true;
    exit;
  end;

  if (DataSet.FieldByName('RoomReservation').asinteger = 0) and
    (DataSet.FieldByName('Reservation').asinteger > 0) then
  begin
    DataSet.FieldByName('isGroup').asboolean := true;
    exit;
  end;

  if (DataSet.FieldByName('RoomReservation').asinteger > 0) and
    (DataSet.FieldByName('Reservation').asinteger > 0) then
  begin
    DataSet.FieldByName('isRoom').asboolean := true;
  end;
end;


procedure Td.mInvoicelines_afterNewRecord(DataSet: TDataSet);
begin
  dataset['issystemline'] := false;
end;

procedure Td.mInvoicelines_beforeNewRecord(DataSet: TDataSet);
begin
  dataset['issystemline'] := false;
end;

function CreateSQLInText(list: TstringList): string;
var
  i: integer;
  s: string;
begin
  result := '';
  s := '';
  for i := 0 to list.Count - 1 do
  begin
    s := s + list[i] + ',';
  end;

  if length(s) > 0 then
  begin
    delete(s, length(s), 1);
    result := '(' + s + ')';
  end;
end;


//////////////////////////////////////////////////////////////////////
///  Tornover and Payments report
///
//////////////////////////////////////////////////////////////////////

procedure Td.TurnoverAndPaymentsGetAll(clearData: boolean;var zGlob : recTurnoverAndPaymentsGlobals);
var
  s: string;
    rset1
  , rset2
  , rset3
  , rset4
  , rset5
  , rset6
  , rset7
  , rset8
  , rset9
  , rset10
  , rSet11
  , rSet12
  : TRoomerDataset;

  ExecutionPlan: TRoomerExecutionPlan;

  startTick: integer;
  stopTick: integer;
  SQLms: integer;

  lst: TstringList;

  dateFrom: Tdate;
  dateTo: Tdate;

  sUnconfirmedDate : string;

  debug_s  : string;

begin

  sUnconfirmedDate := '1900-01-01 00:00:00';

//ATH  if length(trim(edUnconfirmedDate.Text)) = 19  then
//  begin
//    sUnconfirmedDate := edUnconfirmedDate.Text;
//    try
//      datetimetostring(sUnconfirmedDate, 'yyyy-mm-dd hh:nn:ss', unconfirmedDate);
//    Except
//      sUnconfirmedDate := '1900-01-01 00:00:00';
//    end;
//  end;


  screen.Cursor := crHourGlass;
  try
    if zglob.ConfirmState = 1 then
    begin
      lst := invoiceList_Unconfirmed();
      try
        zglob.Invoicelist := CreateSQLInText(lst);
      finally
        freeandnil(lst);
      end;
    end
  finally
    screen.Cursor := crDefault;
  end;

  debug_s := 'use home100_xhj2;';
  screen.Cursor := crHourGlass;
  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  try
    s := '';
    s := s + ' SELECT '#10;
    s := s + '     il.ItemID '#10;
    s := s + '   , it.Description '#10;
    s := s + '   , it.Itemtype '#10;
    s := s + '   , ity.Description AS TypeDescription '#10;
    s := s + '   , ity.VATCode '#10;
    s := s + '   , vat.VATPercentage '#10;
    s := s + '   , SUM(il.Total) AS Amount '#10;
    s := s + '   , SUM(il.Vat) AS VAT '#10;
    s := s + '   , SUM(il.Number) AS Itemcount '#10;
    s := s + ' FROM '#10;
    s := s + '   invoicelines il INNER JOIN '#10;
    s := s + '   items it ON il.ItemID = it.Item INNER JOIN '#10;
    s := s + '   itemtypes ity ON it.Itemtype = ity.Itemtype INNER JOIN '#10;
    s := s + '   vatcodes vat ON ity.VATCode = vat.VATCode '#10;
    s := s + ' WHERE '#10;
    s := s + '( confirmDate = ' + _db(sUnconfirmedDate) + ' ) ';
    s := s + '  AND  ((il.ItemID <> ' + _db(zglob.RoomRentItem) + ' )  '#10;
    s := s + '  AND  (il.ItemID <> ' + _db(zglob.DiscountItem) + ' )  '#10;
    s := s + '  AND  (il.ItemID <> ' + _db(zglob.TaxesItem) + ' ))  '#10;

    s := s + ' GROUP BY '#10;
    s := s + '     il.ItemID '#10;
    s := s + '   , it.Description '#10;
    s := s + '   , it.Itemtype '#10;
    s := s + '   , ity.Description '#10;
    s := s + '   , ity.VATCode '#10;
    s := s + '   , vat.VATPercentage ;'#10;

    // rset1,Results[0],d.kbmTurnover_
//    copyToClipboard(s);
//    DebugMessage('-- 0 Turnower '#10+s);

    debug_s := debug_s+#10#10'-- 0 d.kbmTurnover_. '#10+s;
    ExecutionPlan.AddQuery(s);

    // --
    s := '';
    s := s + ' SELECT '#10;
    s := s + '  pm.PayType '#10;
    s := s + ' ,sum(pm.Amount) AS Amount '#10;
    s := s + ' ,count(pm.ID) AS PaymentCount '#10;
    s := s + ' ,pty.description AS paytypeDescription '#10;
    s := s + ' ,pgr.description AS paygroupDescripion '#10;
    s := s + ' FROM payments pm INNER JOIN '#10;
    s := s + '      paytypes pty ON pm.paytype = pty.paytype INNER JOIN '#10;
    s := s + '      paygroups pgr ON pty.paygroup = pgr.paygroup '#10;
    s := s + '  WHERE '#10;
    s := s + '( confirmDate = ' + _db(sUnconfirmedDate) + ' ) ';
    s := s + '  GROUP BY '#10;
    s := s + '    pm.PayType '#10;
    s := s + '   ,pty.description '#10;
    s := s + '   ,pgr.description ;'#10;

    //rset2,Results[1],d.kbmPayments_
//    copyToClipboard(s);
//    DebugMessage('-- 1 '#10+s);
    debug_s := debug_s+#10#10'-- 1 d.kbmPayments_. '#10+s;
    ExecutionPlan.AddQuery(s);

    s := '';
    s := s + ' SELECT '#10;
    s := s + '   rd.id '#10;
    s := s + ' , date(rd.ADate) as StayDate '#10;
    s := s + ' , rd.roomreservation '#10;
    s := s + ' , rd.reservation '#10;
    s := s + ' , rd.invoicenumber '#10;
    s := s + ' , rd.roomrate*cr.AValue AS RentAmount '#10;
    s := s + ' , rd.currency '#10;
    s := s + ' , rd.confirmdate '#10;
    s := s + ' , rv.customer '#10;
    s := s + ' , cr.avalue AS currencyRate '#10;
    s := s + ' , (SELECT stayTaxIncluted FROM customers WHERE customer = rv.customer Limit 1) AS isTaxIncluted '#10;
    s := s + ' , (IF(rd.isPercentage, rd.RoomRate*rd.Discount/100, rd.Discount)*cr.avalue) AS DiscountAmount '#10;
    s := s + ' , (IF((SELECT StayTaxPerPerson from control LIMIT 1) '#10;
    s := s + '     ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1))*(SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation) '#10;
    s := s + '     ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1)) '#10;
    s := s + '   )) AS TotalStayTax '#10;
    s := s + ' FROM '#10;
    s := s + '   roomsdate rd '#10;
    s := s + '   INNER JOIN reservations rv ON rd.reservation = rv.reservation '#10;
    s := s + '   INNER JOIN currencies cr ON rd.currency = cr.currency '#10;
    s := s + ' WHERE '#10;
    s := s + ' ( confirmDate = ' + _db(sUnconfirmedDate) + ' ) ';

//ATH**
//    s := s + ' AND (((' + StatusInStr('rd.resflag') + ') '#10;
    s := s + ' AND ((((rd.resflag IN ('+_db('G')+','+_db('D')+')))  '#10;
    s := s + ' AND (date(rd.ADate) <=  CURDATE())) OR (rd.invoicenumber > 0)) '#10;
    s := s + ' AND (ResFlag <> ' + _db(STATUS_DELETED) + ' ) ;';
    // **zxhj line added

    //rset3,Results[2],d.kbmRoomsDate_
//    copyToClipboard(s);
//    DebugMessage('-- 2 '#10+s);
    debug_s := debug_s+#10#10'-- 2 d.kbmRoomsDate_. '#10+s;
    ExecutionPlan.AddQuery(s);

    s := '';
    s := s + ' SELECT '#10;
    s := s + '     il.ItemID '#10;
    s := s + '   , il.Invoicenumber '#10;
    s := s + '   , (SELECT Room FROM roomreservations WHERE RoomReservation=il.Roomreservation LIMIT 1) AS Room '#10;
    s := s + '   , ih.Staff '#10;
    s := s + '   , il.splitNumber '#10;
    s := s + '   , it.Description '#10;
    s := s + '   , it.Itemtype '#10;
    s := s + '   , ity.Description AS TypeDescription '#10;
    s := s + '   , ity.VATCode '#10;
    s := s + '   , vat.VATPercentage '#10;
    s := s + '   , il.Total AS Amount '#10;
    s := s + '   , il.Vat AS VAT '#10;
    s := s + '   , il.Number AS Itemcount '#10;
    s := s + '   , il.confirmAmount '#10;
    s := s + '   , ih.Customer '#10;
    s := s + '   , (SELECT stayTaxIncluted FROM customers WHERE customer = ih.customer) AS isTaxIncluted '#10;
    s := s + '   , (IF((SELECT StayTaxPerPerson from control LIMIT 1) '#10;
    s := s + '        ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1))*(il.persons) '#10;
    s := s + '        ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1))*(il.number) '#10;
    s := s + '       )) AS TotalStayTax '#10;
    s := s + ' FROM '#10;
    s := s + '   invoicelines il INNER JOIN '#10;
    s := s + '   items it ON il.ItemID = it.Item INNER JOIN '#10;
    s := s + '   invoiceheads ih ON il.invoicenumber = ih.invoicenumber INNER JOIN '#10;
    s := s + '   itemtypes ity ON it.Itemtype = ity.Itemtype INNER JOIN '#10;
    s := s + '   vatcodes vat ON ity.VATCode = vat.VATCode '#10;
    s := s + ' WHERE '#10;
    s := s + '( confirmDate = ' + _db(sUnconfirmedDate) + ' ) ';
    s := s + '  AND  ((il.ItemID = ' + _db(zglob.RoomRentItem) + ' )  '#10;
    s := s + '  OR   (il.ItemID = ' + _db(zglob.DiscountItem) + ' )  '#10;
    s := s + '  OR   (il.ItemID = ' + _db(zglob.TaxesItem) + ' )) '#10;
    s := s + '  AND  (il.invoicenumber > 0)  ;'#10;

    // rset4,Results[3],d.kbmRoomRentOnInvoice_
//    copyToClipboard(s);
//    DebugMessage('-- 3 Getting items in invoicelines is roomrent and invoiced'#10#10+s);
    debug_s := debug_s+#10#10'-- 3 d.kbmRoomRentOnInvoice_. '#10+s;
    ExecutionPlan.AddQuery(s);

    s := '';
    s := s + ' SELECT ' + #10;
    s := s + '     ih.Reservation ' + #10;
    s := s + '   , ih.RoomReservation ' + #10;
    s := s + '   , ih.SplitNumber ' + #10;
    s := s + '   , ih.InvoiceNumber ' + #10;
    s := s + '   , ih.Customer ' + #10;
    s := s + '   , ih.Name AS NameOnInvoice ' + #10;
    s := s + '   , ih.Address1 ' + #10;
    s := s + '   , ih.Address2 ' + #10;
    s := s + '   , ih.Address3 ' + #10;
    s := s + '   , ih.Total AS ihAmountWithTax ' + #10;
    s := s + '   , ih.TotalWOVAT AS ihAmountNoTax ' + #10;
    s := s + '   , ih.TotalVAT AS ihAmountTax ' + #10;
    s := s + '   , ih.CreditInvoice ' + #10;
    s := s + '   , ih.OriginalInvoice ' + #10;
    s := s + '   , ih.RoomGuest ' + #10;
    s := s + '   , ih.ihInvoiceDate AS InvoiceDate ' + #10;
    s := s + '   , ih.ihPayDate AS dueDate ' + #10;
    s := s + '   , ih.invRefrence ' + #10;
    s := s + '   , ih.TotalStayTax ' + #10;
    s := s + '   , ih.TotalStayTaxNights ' + #10;
    s := s + '   , ih.ihConfirmDate AS ConfirmedDate ' + #10;
    s := s + '   , ih.ihCurrency AS Currency ' + #10;
    s := s + '   , ih.ihCurrencyRate AS Rate ' + #10;
    s := s + '   , ih.ihStaff AS Staff ' + #10;
    s := s + '   , cu.Surname AS CustomerName ' + #10;
    s := s + '   , cu.TravelAgency AS isAgency ' + #10;
    s := s + '   , cu.CustomerType AS markedSegment ' + #10;
    s := s + '   , ct.Description AS markedSegmentDescription ' + #10;
    s := s + ' FROM ' + #10;
    s := s + '   customertypes ct ' + #10;
    s := s + '     RIGHT OUTER JOIN customers cu ON ct.CustomerType = cu.CustomerType '
      + #10;
    s := s + '     RIGHT OUTER JOIN invoiceheads ih ON cu.Customer = ih.Customer '
      + #10;
    s := s + ' WHERE ' + #10;
    if zglob.InvoiceList <> '' then
    begin
      s := s + '   (ih.InvoiceNumber IN ' + zglob.InvoiceList + ') ' + #10;
    end
    else
    begin
      s := s + '   (ih.InvoiceNumber = -888) ' + #10;
    end;
    s := s + ' ORDER BY ' + #10;
    s := s + '   ih.InvoiceNumber ;' + #10;


    // rset5,Results[4]d.mInvoiceHeads
//    copyToClipboard(s);
//    DebugMessage('-- 4 Invoiceheads'#10#10+s);

    debug_s := debug_s+#10#10'-- 4 d.mInvoiceHeads. '#10+s;
    ExecutionPlan.AddQuery(s);

    s := '';
    s := s + ' SELECT ' + #10;
    s := s + '     il.InvoiceNumber ' + #10;
    s := s + '   , date(il.PurchaseDate) AS PurchaseDate ' + #10;
    s := s + '   , il.ItemID as Item' + #10;
    s := s + '   , il.Number as Quantity' + #10;
    s := s + '   , il.Description ' + #10;
    s := s + '   , il.Price ' + #10;
    s := s + '   , il.VATType ' + #10;
    s := s + '   , il.Total AS ilAmountWithTax ' + #10;
    s := s + '   , il.TotalWOVat AS ilAmountNoTax ' + #10;
    s := s + '   , il.Vat as ilAmountTax' + #10;
    s := s + '   , il.Currency ' + #10;
    s := s + '   , il.CurrencyRate ' + #10;
    s := s + '   , il.ImportRefrence ' + #10;
    s := s + '   , il.ImportSource ' + #10;
    s := s + ' FROM ' + #10;
    s := s + '   invoicelines il ' + #10;
    s := s + ' WHERE ' + #10;
    if zglob.InvoiceList <> '' then
    begin
      s := s + '   (il.InvoiceNumber IN ' + zglob.InvoiceList + ') ;' + #10;
    end
    else
    begin
      s := s + '   (il.InvoiceNumber = -888) ;' + #10;
    end;

    // rset6,Results[5],d.mInvoiceLines
//    copyToClipboard(s);
//    DebugMessage('-- 5 invoicelines '#10#10+s);

    debug_s := debug_s+#10#10'-- 5 d.mInvoiceLines. '#10+s;
    ExecutionPlan.AddQuery(s);

    s := '';
    s := s + ' SELECT id from control ' + #10;

    // rset7,Results[6],kbmRoomsDateInvoiced_
//    copyToClipboard(s);
//    DebugMessage('Getting all unpaid roomrent'#10#10+s);
    ExecutionPlan.AddQuery(s);

    s := '';
    s := s + ' SELECT '#10;
    s := s + '     il.ID '#10;
    s := s + '   , il.Reservation '#10;
    s := s + '   , il.Roomreservation '#10;
    s := s + '   , (SELECT Room FROM roomreservations WHERE RoomReservation=il.Roomreservation LIMIT 1) AS Room '#10;
    s := s + '   , (SELECT Staff FROM invoiceheads WHERE InvoiceNumber=il.InvoiceNumber LIMIT 1) AS Staff '#10;
    s := s + '   , CAST((SELECT IF(InvoiceNumber>0, InvoiceNumber, '''') FROM invoiceheads WHERE InvoiceNumber=il.InvoiceNumber LIMIT 1) AS CHAR(10)) AS InvoiceNumber '#10;
    s := s + '   , date(il.PurchaseDate) As PurchaseDate '#10;
    s := s + '   , il.ItemID '#10;
    s := s + '   , it.Description '#10;
    s := s + '   , it.Itemtype '#10;
    s := s + '   , ity.Description AS TypeDescription '#10;
    s := s + '   , ity.VATCode '#10;
    s := s + '   , vat.VATPercentage '#10;
    s := s + '   , il.Total AS Amount '#10;
    s := s + '   , il.Vat AS VAT '#10;
    s := s + '   , il.Number AS Itemcount '#10;
    s := s + '   , il.confirmAmount '#10;
    s := s + ' FROM '#10;
    s := s + '   invoicelines il INNER JOIN '#10;
    s := s + '   items it ON il.ItemID = it.Item INNER JOIN '#10;
    s := s + '   itemtypes ity ON it.Itemtype = ity.Itemtype INNER JOIN '#10;
    s := s + '   vatcodes vat ON ity.VATCode = vat.VATCode '#10;
    s := s + ' WHERE '#10;
    s := s + '( confirmDate = ' + _db(sUnconfirmedDate) + ' ) ';
    s := s + '  AND  ((il.ItemID <> ' + _db(zglob.RoomRentItem) + ' )  '#10;
    s := s + '  AND  (il.ItemID <> ' + _db(zglob.DiscountItem) + ' )  '#10;
    s := s + '  AND  (il.ItemID <> ' + _db(zglob.TaxesItem) + ' ))  ;'#10;

//    copyToClipboard(s);
//    DebugMessage('-- 6 Getting items in invoicelines that is not roomrent'#10#10+s);

    debug_s := debug_s+#10#10'-- 7 DReportData.kbmUnconfirmedInvoicelines_. Getting items in invoicelines that is not roomrent'#10+s;
    ExecutionPlan.AddQuery(s);

    s := '';
    s := s + ' SELECT '#10;
    s := s + '     il.ID AS ivlID'#10;
    s := s + '   , il.Reservation '#10;
    s := s + '   , il.Roomreservation '#10;
    s := s + '   , date(il.PurchaseDate) As PurchaseDate '#10;
    s := s + '   , il.ItemID '#10;
    s := s + '   , it.Description '#10;
    s := s + '   , it.Itemtype '#10;
    s := s + '   , ity.Description AS TypeDescription '#10;
    s := s + '   , ity.VATCode '#10;
    s := s + '   , vat.VATPercentage '#10;
    s := s + '   , il.Total AS Amount '#10;
    s := s + '   , il.Vat AS VAT '#10;
    s := s + '   , il.Number AS Itemcount '#10;
    s := s + '   , il.confirmAmount '#10;
    s := s + '   , (il.Total-il.confirmAmount) AS pricechange'#10;
    s := s + ' FROM '#10;
    s := s + '   invoicelines il INNER JOIN '#10;
    s := s + '   items it ON il.ItemID = it.Item INNER JOIN '#10;
    s := s + '   itemtypes ity ON it.Itemtype = ity.Itemtype INNER JOIN '#10;
    s := s + '   vatcodes vat ON ity.VATCode = vat.VATCode '#10;
    s := s + ' WHERE '#10;
    s := s + '( confirmDate > ' + _db(sUnconfirmedDate) + ' ) ';
    s := s + '  AND  ((il.ItemID <> ' + _db(zglob.RoomRentItem) + ' )  '#10;
    s := s + '  AND  (il.ItemID <> ' + _db(zglob.DiscountItem) + ' )  '#10;
    s := s + '  AND  (il.ItemID <> ' + _db(zglob.TaxesItem) + ' ))  '#10;
    s := s + '  AND  ((il.Total-il.confirmAmount) <> 0)  ;'#10;

    // rset9,Results[8],d.kbmInvoiceLinePriceChange_
//    copyToClipboard(s);
//    DebugMessage('-- 7 Getting items in invoicelines that is not roomrent'#10#10+s);
    debug_s := debug_s+#10#10'-- 8 d.kbmInvoiceLinePriceChange_. Getting items in invoicelines that is not roomrent'#10+s;
    ExecutionPlan.AddQuery(s);

    // **zxhj
    s := '';
    s := s + ' SELECT '#10;
    s := s + '   rd.id AS roomsdateID'#10;
    s := s + ' , date(rd.ADate) as StayDate '#10;
    s := s + ' , rd.roomreservation '#10;
    s := s + ' , rd.reservation '#10;
    s := s + ' , rd.invoicenumber '#10;
    s := s + ' , rd.roomrate*cr.AValue AS RentAmount '#10;
    s := s + ' , rd.currency '#10;
    s := s + ' , rd.confirmdate '#10;
    s := s + ' , rd.confirmAmount '#10;
    s := s + ' , rd.confirmDiscount '#10;
    s := s + ' , rd.confirmTax '#10;
    s := s + ' , rv.customer '#10;
    s := s + ' , cr.avalue AS currencyRate '#10;
    s := s + ' , (SELECT stayTaxIncluted FROM customers WHERE customer = rv.customer) AS isTaxIncluted '#10;
    s := s + ' , (IF(rd.isPercentage, rd.RoomRate*rd.Discount/100, rd.Discount)*cr.avalue) AS DiscountAmount '#10;
    s := s + ' , (IF(rd.isPercentage, rd.RoomRate*rd.Discount/100, rd.Discount)*cr.avalue)-rd.confirmDiscount AS DiscountChange '#10;

    s := s + ' ,(IF((SELECT StayTaxPerPerson from control LIMIT 1) '#10;
    s := s + '     ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1))*(SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation) '#10;
    s := s + '     ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1)) '#10;
    s := s + '   )) AS TotalStayTax '#10;

    s := s + ' ,(IF((SELECT StayTaxPerPerson from control LIMIT 1) '#10;
    s := s + '     ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1))*(SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation) '#10;
    s := s + '     ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1)) '#10;
    s := s + '   ))-rd.confirmTax AS TaxChange '#10;

    s := s + ' , (rd.roomrate*cr.AValue)-rd.confirmAmount AS RentChange '#10;

    s := s + ' FROM '#10;
    s := s + '   roomsdate rd '#10;
    s := s + '   INNER JOIN reservations rv ON rd.reservation = rv.reservation '#10;
    s := s + '   INNER JOIN currencies cr ON rd.currency = cr.currency '#10;
    s := s + ' WHERE '#10;
    s := s + ' ( confirmDate > ' + _db(sUnconfirmedDate) + ' ) ';
    s := s + ' AND ( '#10;
    s := s + '  (rd.confirmAmount-(rd.roomrate*cr.AValue) <> 0) '#10;
    s := s + '  OR (rd.confirmTax-(IF((SELECT StayTaxPerPerson from control LIMIT 1) '#10;
    s := s + '     ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1))*(SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation) '#10;
    s := s + '     ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1)) '#10;
    s := s + '   )) <> 0 ) '#10;
    s := s + ' OR (rd.confirmDiscount-(IF(rd.isPercentage, rd.RoomRate*rd.Discount/100, rd.Discount)*cr.avalue) <> 0) '#10;
    s := s + '    ) '#10;
    s := s + '  AND (ResFlag <> '+ _db(STATUS_DELETED)+')  ;'#10;


    // rset10,Results[9],d.kbmRoomsDateChange_
//    copyToClipboard(s);
//    DebugMessage('-- 8 Getting confirmed uninvoiced rent change '#10#10+s);

    debug_s := debug_s+#10#10'-- 9 d.kbmRoomsDateChange_. Getting confirmed uninvoiced rent change'#10+s;
    ExecutionPlan.AddQuery(s);



    s := '';
    s := s + ' SELECT '#10;
    s := s + '   rd.id AS roomsdateID'#10;
    s := s + ' , date(rd.ADate) as StayDate '#10;
    s := s + ' , rd.roomreservation '#10;
    s := s + ' , rd.reservation '#10;
    s := s + ' , rd.invoicenumber '#10;
    s := s + ' , rd.roomrate*cr.AValue AS RentAmount '#10;
    s := s + ' , rd.currency '#10;
    s := s + ' , rd.confirmdate '#10;
    s := s + ' , rd.confirmAmount '#10;
    s := s + ' , rd.confirmDiscount '#10;
    s := s + ' , rd.confirmTax '#10;
    s := s + ' , rv.customer '#10;
    s := s + ' , cr.avalue AS currencyRate '#10;
    s := s + ' , (SELECT stayTaxIncluted FROM customers WHERE customer = rv.customer) AS isTaxIncluted '#10;
    s := s + ' , (IF(rd.isPercentage, rd.RoomRate*rd.Discount/100, rd.Discount)*cr.avalue) AS DiscountAmount '#10;
    s := s + ' , (IF(rd.isPercentage, rd.RoomRate*rd.Discount/100, rd.Discount)*cr.avalue)-rd.confirmDiscount AS DiscountChange '#10;

    s := s + ' ,(IF((SELECT StayTaxPerPerson from control LIMIT 1) '#10;
    s := s + '     ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1))*(SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation) '#10;
    s := s + '     ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1)) '#10;
    s := s + '   )) AS TotalStayTax '#10;

    s := s + ' ,(IF((SELECT StayTaxPerPerson from control LIMIT 1) '#10;
    s := s + '     ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1))*(SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation) '#10;
    s := s + '     ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1)) '#10;
    s := s + '   ))-rd.confirmTax AS TaxChange '#10;

    s := s + ' , (rd.roomrate*cr.AValue)-rd.confirmAmount AS RentChange '#10;

    s := s + ' FROM '#10;
    s := s + '   roomsdate rd '#10;
    s := s + '   LEFT OUTER JOIN reservations rv ON rd.reservation = rv.reservation '#10;
    s := s + '   INNER JOIN currencies cr ON rd.currency = cr.currency '#10;
    s := s + ' WHERE '#10;
    s := s + ' ( confirmDate > ' + _db(sUnconfirmedDate) + ' )  '#10;
    s := s + ' AND ( '#10;
    s := s + '        ResFlag = '+ _db(STATUS_DELETED)+'  '#10;
    s := s + '    ) '#10;
    s := s + ' AND ( '#10;
    s := s + '   (rd.confirmAmount+rd.confirmDiscount+rd.confirmTax) <> 0 '#10;
    s := s + '    ) ;'#10;

// rset11,Results[9],d.kbmRoomsDateChange_
//    copyToClipboard(s);
//    DebugMessage('-- 9 '#10#10+s);
    debug_s := debug_s+#10#10'-- 10 d.kbmRoomsDateChange_. Adding to roomsdateGhange'#10+s;debug_s := debug_s+#10#10'-- 11 d.kbmPaymentList_. List of payments'#10+s;
    ExecutionPlan.AddQuery(s);


    s := '';
    s := s + '  SELECT '#10;
    s := s + '    pm.PayType '#10;
    s := s + '   ,pm.Amount '#10;
    s := s + '   ,date(pm.payDate) AS dtPayDate '#10;
    s := s + '   ,pm.description '#10;
    s := s + '   ,pty.description AS paytypeDescription '#10;
    s := s + '   ,pgr.description AS paygroupDescripion '#10;
    s := s + '   ,pm.invoicenumber '#10;
    s := s + '   ,pm.customer '#10;
    s := s + '   ,pm.reservation '#10;
    s := s + '   ,pm.roomreservation '#10;
    s := s + '   ,(SELECT cu.surname FROM customers cu WHERE cu.customer = pm.customer) as customername '#10;
    s := s + '   ,(SELECT ih.name FROM invoiceheads ih WHERE (ih.invoicenumber = pm.invoicenumber) and (invoicenumber>0) limit 1) as NameOnInvoice '#10;
    s := s + '   ,pm.confirmdate '#10;
    s := s + '   ,IF(pm.typeindex=0,'+_db('Invoice')+','+_db('Downpayment')+') AS Medhod '#10;
//    s := s + '   ,IF(pm.typeindex=0,'Invoice','Downpayment') AS Medhod '#10;
    s := s + '  FROM payments pm '#10;
    s := s + '        INNER JOIN paytypes pty ON pm.paytype = pty.paytype '#10;
    s := s + '        INNER JOIN paygroups pgr ON pty.paygroup = pgr.paygroup '#10;
    s := s + '   WHERE '#10;
    s := s + '( confirmDate = ' + _db(sUnconfirmedDate) + ') '#10;
//    s := s + '     ( confirmDate = '2014-05-03 14:05:31') '#10;
    s := s + '    ORDER BY '#10;
    s := s + '      pm.payDate ;'#10;

    debug_s := debug_s+#10#10'-- 11 d.kbmPaymentList_. List of payments'#10+s;
    copyToClipboard(debug_s);
    ExecutionPlan.AddQuery(s);


    // //////////////////// Execute!

    d.kbmTurnover_.DisableControls;
    d.kbmPayments_.DisableControls;
    d.kbmRoomsDate_.DisableControls;
    d.kbmRoomRentOnInvoice_.DisableControls;
    d.mInvoiceHeads.DisableControls;
    d.mInvoiceLines.DisableControls;
    DReportData.kbmUnconfirmedInvoicelines_.DisableControls;
    d.kbmInvoiceLinePriceChange_.DisableControls;
    d.kbmPaymentList_.disableControls;
    try
      ExecutionPlan.Execute(ptQuery);

      /// ///////////////// Turnover

      rset1 := ExecutionPlan.Results[0];
      if d.kbmTurnover_.active then d.kbmTurnover_.Close;
      d.kbmTurnover_.open;
      kbmTurnover_.LoadFromDataSet(rset1,[]);
//      LoadKbmMemtableFromDataSetQuiet(kbmTurnover_,rset1,[]);
      d.kbmTurnover_.First;

      // //////////////////// Payments
      rset2 := ExecutionPlan.Results[1];
      if d.kbmPayments_.active then
        d.kbmPayments_.Close;
      d.kbmPayments_.open;
      kbmPayments_.LoadFromDataSet(rset2,[]);
//      LoadKbmMemtableFromDataSetQuiet(kbmPayments_,rset2,[]);
      d.kbmPayments_.First;

      rset3 := ExecutionPlan.Results[2];
      if d.kbmRoomsDate_.active then
        d.kbmRoomsDate_.Close;
      d.kbmRoomsDate_.open;
      kbmRoomsDate_.LoadFromDataSet(rset3,[]);
//      LoadKbmMemtableFromDataSetQuiet(kbmRoomsDate_,rset3,[]);
      d.kbmRoomsDate_.First;

      rset4 := ExecutionPlan.Results[3];
      if d.kbmRoomRentOnInvoice_.active then
        d.kbmRoomRentOnInvoice_.Close;
      d.kbmRoomRentOnInvoice_.open;
      kbmRoomRentOnInvoice_.LoadFromDataSet(rset4,[]);
//      LoadKbmMemtableFromDataSetQuiet(kbmRoomRentOnInvoice_,rset4,[]);
      d.kbmRoomRentOnInvoice_.First;

      rset5 := ExecutionPlan.Results[4];
      if d.mInvoiceHeads.active then
        d.mInvoiceHeads.Close;
      d.mInvoiceHeads.open;
      mInvoiceHeads.LoadFromDataSet(rset5,[]);
//      LoadKbmMemtableFromDataSetQuiet(mInvoiceHeads,rset5,[]);
      d.mInvoiceHeads.First;

      rset6 := ExecutionPlan.Results[5];
      if d.mInvoiceLines.active then
        d.mInvoiceLines.Close;
      d.mInvoiceLines.open;
      mInvoiceLines.LoadFromDataSet(rset6,[]);
//      LoadKbmMemtableFromDataSetQuiet(mInvoiceLines,rset6,[]);
      d.mInvoiceLines.First;


      rset8 := ExecutionPlan.Results[7];
      if DReportData.kbmUnconfirmedInvoicelines_.active then
        DReportData.kbmUnconfirmedInvoicelines_.Close;
      DReportData.kbmUnconfirmedInvoicelines_.open;
      DReportData.kbmUnconfirmedInvoicelines_.LoadFromDataSet(rset8,[]);
//      LoadKbmMemtableFromDataSetQuiet(kbmUnconfirmedInvoicelines_,rset8,[]);
      DReportData.kbmUnconfirmedInvoicelines_.First;

      rset9 := ExecutionPlan.Results[8];
      if d.kbmInvoiceLinePriceChange_.active then
        d.kbmInvoiceLinePriceChange_.Close;
      d.kbmInvoiceLinePriceChange_.open;
      kbmInvoiceLinePriceChange_.LoadFromDataSet(rset9,[]);
//      LoadKbmMemtableFromDataSetQuiet(kbmInvoiceLinePriceChange_,rset9,[]);
      d.kbmInvoiceLinePriceChange_.First;

      rset10 := ExecutionPlan.Results[9];
      if d.kbmRoomsDateChange_.active then
        d.kbmRoomsDateChange_.Close;
      d.kbmRoomsDateChange_.open;
      kbmRoomsDateChange_.LoadFromDataSet(rset10,[]);
//      LoadKbmMemtableFromDataSetQuiet(kbmRoomsDateChange_,rset10,[]);
      d.kbmRoomsDateChange_.First;

      rset11 := ExecutionPlan.Results[10];
      rSet11.first;
      while not rSet11.eof do
      begin
        d.kbmRoomsDateChange_.Insert;
        d.kbmRoomsDateChange_.FieldByName('StayDate').asDateTime         :=   rSet11.FieldByName('StayDate').asDateTime           ;
        d.kbmRoomsDateChange_.FieldByName('roomreservation').asinteger   :=   rSet11.FieldByName('roomreservation').asinteger     ;
        d.kbmRoomsDateChange_.FieldByName('reservation').asinteger       :=   rSet11.FieldByName('reservation').asinteger         ;
        d.kbmRoomsDateChange_.FieldByName('RentAmount').AsFloat          :=   0.00;
        d.kbmRoomsDateChange_.FieldByName('currency').AsString           :=   rSet11.FieldByName('currency').AsString             ;
        d.kbmRoomsDateChange_.FieldByName('currencyRate').AsFloat        :=   rSet11.GetFloatValue(rSet11.FieldByName('currencyRate'));
        d.kbmRoomsDateChange_.FieldByName('DiscountAmount').AsFloat      :=   0.00;
        d.kbmRoomsDateChange_.FieldByName('TotalStayTax').AsFloat        :=   0.00;
        d.kbmRoomsDateChange_.FieldByName('roomsdateID').asinteger       :=   rSet11.FieldByName('roomsdateID').asinteger         ;
        d.kbmRoomsDateChange_.FieldByName('invoicenumber').asinteger     :=   rSet11.FieldByName('invoicenumber').asinteger       ;
        d.kbmRoomsDateChange_.FieldByName('discountChange').AsFloat      :=   rSet11.GetFloatValue(rSet11.FieldByName('DiscountAmount'))*-1     ;
        if rSet11.FieldByName('customer').AsString = ''  then
        begin
          d.kbmRoomsDateChange_.FieldByName('isTaxIncluted').asboolean     :=   zglob.StayTaxIncluted;
          d.kbmRoomsDateChange_.FieldByName('taxChange').AsFloat           :=   rSet11.GetFloatValue(rSet11.FieldByName('taxchange'));
        end else
        begin
          d.kbmRoomsDateChange_.FieldByName('taxChange').AsFloat           :=   rSet11.GetFloatValue(rSet11.FieldByName('TotalStayTax'))*-1       ;
          d.kbmRoomsDateChange_.FieldByName('isTaxIncluted').asboolean     :=   rSet11.FieldByName('isTaxIncluted').asboolean       ;
        end;
        d.kbmRoomsDateChange_.FieldByName('rentChange').AsFloat          :=   rSet11.GetFloatValue(rSet11.FieldByName('RentAmount'))*-1         ;
        d.kbmRoomsDateChange_.post;
        rSet11.next;
      end;

      rset12 := ExecutionPlan.Results[11];
      if d.kbmPaymentList_.active then
        d.kbmPaymentList_.Close;
      d.kbmPaymentList_.open;
//      kbmPaymentL6ist_.LoadFromDataSet(rset12,[]);
      LoadKbmMemtableFromDataSetQuiet(kbmPaymentList_,rset12, []);
      d.kbmPaymentList_.First;

    finally
      d.kbmPayments_.enableControls;
      d.kbmTurnover_.enableControls;
      d.kbmRoomsDate_.enableControls;
      d.kbmRoomRentOnInvoice_.enableControls;
      d.mInvoiceHeads.enableControls;
      d.mInvoiceLines.enableControls;
      DReportData.kbmUnconfirmedInvoicelines_.enableControls;
      d.kbmInvoiceLinePriceChange_.enableControls;
      d.kbmPaymentList_.EnableControls;
    end;


    d.TurnoverAndPaymentsUpdateTurnover(zGlob);
    d.TurnoverAndPaymentsUpdateTurnoverItemPriceChange(zGlob);

    zGlob.totalTurnover := 0;
    d.kbmTurnover_.First;
    while not d.kbmTurnover_.eof do
    begin
      zGlob.totalTurnover := zGlob.totalTurnover + d.kbmTurnover_.fieldbyname('amount').asfloat;
      d.kbmTurnover_.Next;
    end;
    d.kbmTurnover_.First;


    zGlob.totalPayments := 0;
    d.kbmPayments_.First;
    while not d.kbmPayments_.eof do
    begin
      zGlob.totalPayments := zGlob.totalPayments + d.kbmPayments_.fieldbyname('amount').asfloat;
      d.kbmPayments_.Next;
    end;
    d.kbmPayments_.First;


  finally
    ExecutionPlan.Free;
    screen.Cursor := crDefault;
  end;
  // pg001.ApplyBestFit;
end;




procedure Td.TurnoverAndPaymentsUpdateTurnover(var zGlob : recTurnoverAndPaymentsGlobals);
var
  rentAmount: double;
  rentVat: double;
  rentItemCount: Double;  //-96

  discountAmount: double;
  discountVat: double;
  discountItemCount: double; //-96

  cityTaxAmount: double;
  cityTaxVat: double;
  cityTaxItemCount: double; //-96

  incl_cityTaxAmount: double;
  incl_cityTaxVat: double;
  incl_cityTaxItemCount: double; //-96

  item: string;

  isKredit: boolean;

begin

  rentAmount := 0;
  rentItemCount := 0.00; //-96

  discountAmount := 0;
  discountItemCount := 0.00; //-96

  cityTaxAmount := 0;
  cityTaxItemCount := 0.00;  //-96

  incl_cityTaxAmount := 0;
  incl_cityTaxItemCount := 0.00; //-96

  d.kbmTurnover_.DisableControls;
  d.kbmPayments_.DisableControls;
  d.kbmRoomsDate_.DisableControls;
  try

    d.kbmRoomsDate_.First;
    while not d.kbmRoomsDate_.eof do
    begin
      rentAmount := rentAmount + d.kbmRoomsDate_.FieldByName('RentAmount').AsFloat;
      if rentAmount <> 0 then rentItemCount := rentItemCount + 1;

      discountAmount := discountAmount + d.kbmRoomsDate_.FieldByName('DiscountAmount').AsFloat;
      if discountAmount <> 0 then discountItemCount := discountItemCount + 1;

      if d.kbmRoomsDate_.FieldByName('isTaxIncluted').asboolean then
      begin
        incl_cityTaxAmount := incl_cityTaxAmount + d.kbmRoomsDate_.FieldByName('TotalStayTax').AsFloat;
        if incl_cityTaxAmount <> 0 then
        incl_cityTaxItemCount := incl_cityTaxItemCount + 1
      end
      else
      begin
        cityTaxAmount := cityTaxAmount + d.kbmRoomsDate_.FieldByName('TotalStayTax').AsFloat;
        if cityTaxAmount <> 0 then cityTaxItemCount := cityTaxItemCount + 1
      end;
      d.kbmRoomsDate_.Next;
    end;


    rentAmount := rentAmount - incl_cityTaxAmount;
    rentVat := _calcVat(rentAmount, zGlob.RoomRentVATPercentage);
    discountVat := _calcVat(discountAmount, zGlob.RoomRentVATPercentage);
    cityTaxVat := _calcVat(cityTaxAmount, zGlob.cTaxVATPercentage);
    incl_cityTaxVat := _calcVat(incl_cityTaxAmount, zGlob.cTaxVATPercentage);

    if d.kbmRoomsDate_.recordcount > 0 then
    begin
      if rentAmount <> 0 then
      begin
        if d.kbmTurnover_.Locate('ItemId', zGlob.RoomRentItem, []) then
        begin
          d.kbmTurnover_.Edit;
          d.kbmTurnover_.FieldByName('Amount').AsFloat :=
          d.kbmTurnover_.FieldByName('Amount').AsFloat + rentAmount;
          d.kbmTurnover_.FieldByName('VAT').AsFloat :=
          d.kbmTurnover_.FieldByName('Vat').AsFloat + rentVat;
          d.kbmTurnover_.FieldByName('Itemcount').AsFloat := d.kbmTurnover_.FieldByName('itemcount').AsFloat + rentItemCount; //-96
          d.kbmTurnover_.post;
        end
        else
        begin
          d.kbmTurnover_.insert;
          d.kbmTurnover_.FieldByName('ItemId').AsString := zGlob.RoomRentItem;
          d.kbmTurnover_.FieldByName('Description').AsString := zGlob.RoomRentItemDescription;
          d.kbmTurnover_.FieldByName('Amount').AsFloat := rentAmount;
          d.kbmTurnover_.FieldByName('VAT').AsFloat := rentVat;

          d.kbmTurnover_.FieldByName('Itemtype').AsString := zGlob.RoomRentType;
          d.kbmTurnover_.FieldByName('Typedescription').AsString := zGlob.RoomRentTypeDescription;
          d.kbmTurnover_.FieldByName('VATCode').AsString := zGlob.RoomRentVATCode;
          d.kbmTurnover_.FieldByName('ItemCount').asFloat := rentItemCount; //-96
          d.kbmTurnover_.FieldByName('VATPercentage').AsFloat := zGlob.RoomRentVATPercentage;
          d.kbmTurnover_.post;
        end;
      end;

      if discountAmount <> 0 then
      begin
        if d.kbmTurnover_.Locate('ItemId', zGlob.DiscountItem, []) then
        begin
          d.kbmTurnover_.Edit;
          d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + discountAmount * -1;
          d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + discountVat;
          d.kbmTurnover_.FieldByName('Itemcount').AsFloat := d.kbmTurnover_.FieldByName('itemcount').AsFloat + discountItemCount; //-96
          d.kbmTurnover_.post;
        end
        else
        begin
          d.kbmTurnover_.insert;
          d.kbmTurnover_.FieldByName('ItemId').AsString := zGlob.DiscountItem;
          d.kbmTurnover_.FieldByName('Description').AsString := zGlob.DiscountItemDescription;

          d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + discountAmount;
          d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + discountVat;

          d.kbmTurnover_.FieldByName('Itemtype').AsString := zGlob.DiscountType;
          d.kbmTurnover_.FieldByName('Typedescription').AsString := zGlob.DiscountTypeDescription;
          d.kbmTurnover_.FieldByName('VATCode').AsString := zGlob.RoomRentVATCode;
          d.kbmTurnover_.FieldByName('ItemCount').asFloat := discountItemCount; //-96
          d.kbmTurnover_.FieldByName('VATPercentage').AsFloat := zGlob.RoomRentVATPercentage;
          d.kbmTurnover_.post;
        end;
      end;

      if cityTaxAmount <> 0 then
      begin
        if d.kbmTurnover_.Locate('ItemId', zGlob.TaxesItem, []) then
        begin
          d.kbmTurnover_.Edit;
          d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + cityTaxAmount;
          d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + cityTaxVat;
          d.kbmTurnover_.FieldByName('Itemcount').AsFloat := d.kbmTurnover_.FieldByName('itemcount').AsFloat + cityTaxItemCount; //-96
          d.kbmTurnover_.post;
        end
        else
        begin
          d.kbmTurnover_.insert;
          d.kbmTurnover_.FieldByName('ItemId').AsString := zGlob.TaxesItem;
          d.kbmTurnover_.FieldByName('Description').AsString := zGlob.TaxesItemDescription;

          d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + cityTaxAmount;
          d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + cityTaxVat;

          d.kbmTurnover_.FieldByName('Itemtype').AsString := zGlob.cTaxType;
          d.kbmTurnover_.FieldByName('Typedescription').AsString := zGlob.cTaxTypeDescription;
          d.kbmTurnover_.FieldByName('VATCode').AsString := zGlob.cTaxVATCode;
          d.kbmTurnover_.FieldByName('ItemCount').asFloat := cityTaxItemCount; //-96
          d.kbmTurnover_.FieldByName('VATPercentage').AsFloat := zGlob.cTaxVATPercentage;
          d.kbmTurnover_.post;
        end;
      end;

      if incl_cityTaxAmount <> 0 then
      begin
        if d.kbmTurnover_.Locate('ItemId', '-', []) then
        begin
          d.kbmTurnover_.Edit;
          d.kbmTurnover_.FieldByName('Amount').AsFloat :=
            d.kbmTurnover_.FieldByName('Amount').AsFloat + incl_cityTaxAmount;
          d.kbmTurnover_.FieldByName('VAT').AsFloat :=
            d.kbmTurnover_.FieldByName('Vat').AsFloat + cityTaxVat;
          d.kbmTurnover_.FieldByName('Itemcount').AsFloat := d.kbmTurnover_.FieldByName('itemcount').AsFloat + cityTaxItemCount;  //-96
          d.kbmTurnover_.post;
        end
        else
        begin
          d.kbmTurnover_.insert;
          d.kbmTurnover_.FieldByName('ItemId').AsString := '-';
          d.kbmTurnover_.FieldByName('Description').AsString := 'Incluted ' + zGlob.TaxesItemDescription;

          d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + incl_cityTaxAmount;
          d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + incl_cityTaxVat;

          d.kbmTurnover_.FieldByName('Itemtype').AsString := zGlob.cTaxType;
          d.kbmTurnover_.FieldByName('Typedescription').AsString := zGlob.cTaxTypeDescription;
          d.kbmTurnover_.FieldByName('VATCode').AsString := zGlob.cTaxVATCode;
          d.kbmTurnover_.FieldByName('ItemCount').asFloat := cityTaxItemCount; //-96
          d.kbmTurnover_.FieldByName('VATPercentage').AsFloat := zGlob.cTaxVATPercentage;
          d.kbmTurnover_.post;
        end;
      end;
    end;
  finally
    d.kbmPayments_.enableControls;
    d.kbmTurnover_.enableControls;
    d.kbmRoomsDate_.enableControls;
  end;

  /// ///////////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  ///

  if d.kbmRoomsDateChange_.recordcount > 0 then
  begin
    rentAmount := 0;
    rentItemCount := 0;

    discountAmount := 0;
    discountItemCount := 0;

    cityTaxAmount := 0;
    cityTaxItemCount := 0;

    incl_cityTaxAmount := 0;
    incl_cityTaxItemCount := 0;

    d.kbmTurnover_.DisableControls;
    d.kbmRoomsDateChange_.DisableControls;
    try
      d.kbmRoomsDateChange_.First;
      while not d.kbmRoomsDateChange_.eof do
      begin
        if d.kbmRoomsDateChange_.FieldByName('RentChange').AsFloat <> 0 then
        begin
          rentAmount := rentAmount + d.kbmRoomsDateChange_.FieldByName('RentChange').AsFloat;
          if rentAmount <> 0 then rentItemCount := rentItemCount + 1;
        end;

        if d.kbmRoomsDateChange_.FieldByName('DiscountChange').AsFloat <> 0 then
        begin
          discountAmount := discountAmount + d.kbmRoomsDateChange_.FieldByName('DiscountChange').AsFloat;
          if discountAmount <> 0 then discountItemCount := discountItemCount + 1;
        end;

        if d.kbmRoomsDateChange_.FieldByName('TaxChange').AsFloat <> 0 then
        begin
          if d.kbmRoomsDateChange_.FieldByName('isTaxIncluted').asboolean then
          begin
            incl_cityTaxAmount := incl_cityTaxAmount + d.kbmRoomsDateChange_.FieldByName('TotalStayTax').AsFloat;
            if incl_cityTaxAmount = 0 then incl_cityTaxAmount := d.kbmRoomsDateChange_.FieldByName('TaxChange').AsFloat;

            if incl_cityTaxAmount <> 0 then incl_cityTaxItemCount := incl_cityTaxItemCount + 1;
          end else
          begin
            cityTaxAmount := cityTaxAmount + d.kbmRoomsDateChange_.FieldByName('TotalStayTax').AsFloat;
            if cityTaxAmount = 0 then cityTaxAmount := d.kbmRoomsDateChange_.FieldByName('TaxChange').AsFloat;
            if cityTaxAmount <> 0 then cityTaxItemCount := cityTaxItemCount + 1
          end;
        end;
        d.kbmRoomsDateChange_.Next;
      end;

      if incl_cityTaxAmount > 0 then
      begin
        rentAmount := rentAmount + incl_cityTaxAmount;;
      end;
      if incl_cityTaxAmount < 0 then
      begin
        rentAmount := rentAmount - incl_cityTaxAmount;;
      end;


      rentVat         := _calcVat(rentAmount, zGlob.RoomRentVATPercentage);
      discountVat     := _calcVat(discountAmount, zGlob.RoomRentVATPercentage);
      cityTaxVat      := _calcVat(cityTaxAmount, zGlob.cTaxVATPercentage);
      incl_cityTaxVat := _calcVat(incl_cityTaxAmount, zGlob.cTaxVATPercentage);

      if d.kbmRoomsDateChange_.recordcount > 0 then
      begin
        if rentAmount <> 0 then
        begin
          if d.kbmTurnover_.Locate('ItemId', zGlob.RoomRentItem, []) then
          begin
            d.kbmTurnover_.Edit;
            d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + rentAmount;
            d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + rentVat;
            d.kbmTurnover_.FieldByName('Itemcount').AsFloat := d.kbmTurnover_.FieldByName('itemcount').AsFloat + rentItemCount; //-96
            d.kbmTurnover_.post;
          end else
          begin
            d.kbmTurnover_.insert;
            d.kbmTurnover_.FieldByName('ItemId').AsString := zGlob.RoomRentItem;
            d.kbmTurnover_.FieldByName('Description').AsString := zGlob.RoomRentItemDescription;
            d.kbmTurnover_.FieldByName('Amount').AsFloat := rentAmount;
            d.kbmTurnover_.FieldByName('VAT').AsFloat := rentVat;

            d.kbmTurnover_.FieldByName('Itemtype').AsString := zGlob.RoomRentType;
            d.kbmTurnover_.FieldByName('Typedescription').AsString := zGlob.RoomRentTypeDescription;
            d.kbmTurnover_.FieldByName('VATCode').AsString := zGlob.RoomRentVATCode;
            d.kbmTurnover_.FieldByName('ItemCount').asFloat := rentItemCount;   //-96
            d.kbmTurnover_.FieldByName('VATPercentage').AsFloat := zGlob.RoomRentVATPercentage;
            d.kbmTurnover_.post;
          end;
        end;

        if discountAmount <> 0 then
        begin
          if d.kbmTurnover_.Locate('ItemId', zGlob.DiscountItem, []) then
          begin
            d.kbmTurnover_.Edit;
            d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + discountAmount * -1;
            d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + discountVat;
            d.kbmTurnover_.FieldByName('Itemcount').AsFloat := d.kbmTurnover_.FieldByName('itemcount').AsFloat + discountItemCount; //-96
            d.kbmTurnover_.post;
          end
          else
          begin
            d.kbmTurnover_.insert;
            d.kbmTurnover_.FieldByName('ItemId').AsString := zGlob.DiscountItem;
            d.kbmTurnover_.FieldByName('Description').AsString := zGlob.DiscountItemDescription;

            d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + discountAmount;
            d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + discountVat;

            d.kbmTurnover_.FieldByName('Itemtype').AsString := zGlob.DiscountType;
            d.kbmTurnover_.FieldByName('Typedescription').AsString := zGlob.DiscountTypeDescription;
            d.kbmTurnover_.FieldByName('VATCode').AsString := zGlob.RoomRentVATCode;
            d.kbmTurnover_.FieldByName('ItemCount').asFloat := discountItemCount; //-96
            d.kbmTurnover_.FieldByName('VATPercentage').AsFloat := zGlob.RoomRentVATPercentage;
            d.kbmTurnover_.post;
          end;
        end;

        if cityTaxAmount <> 0 then
        begin
          if d.kbmTurnover_.Locate('ItemId', zGlob.TaxesItem, []) then
          begin
            d.kbmTurnover_.Edit;
            d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + cityTaxAmount;
            d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + cityTaxVat;
            d.kbmTurnover_.FieldByName('Itemcount').AsFloat := d.kbmTurnover_.FieldByName('itemcount').AsFloat + cityTaxItemCount; //-96
            d.kbmTurnover_.post;
          end
          else
          begin
            d.kbmTurnover_.insert;
            d.kbmTurnover_.FieldByName('ItemId').AsString := zGlob.TaxesItem;
            d.kbmTurnover_.FieldByName('Description').AsString := zGlob.TaxesItemDescription;

            d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + cityTaxAmount;
            d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + cityTaxVat;

            d.kbmTurnover_.FieldByName('Itemtype').AsString := zGlob.cTaxType;
            d.kbmTurnover_.FieldByName('Typedescription').AsString := zGlob.cTaxTypeDescription;
            d.kbmTurnover_.FieldByName('VATCode').AsString := zGlob.cTaxVATCode;
            d.kbmTurnover_.FieldByName('ItemCount').asFloat := cityTaxItemCount; //-96
            d.kbmTurnover_.FieldByName('VATPercentage').AsFloat := zGlob.cTaxVATPercentage;
            d.kbmTurnover_.post;
          end;
        end;

        if incl_cityTaxAmount <> 0 then
        begin
          if d.kbmTurnover_.Locate('ItemId', '-', []) then
          begin
            d.kbmTurnover_.Edit;
            d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + incl_cityTaxAmount;
            d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + cityTaxVat;
            d.kbmTurnover_.FieldByName('Itemcount').AsFloat := d.kbmTurnover_.FieldByName('itemcount').AsFloat + cityTaxItemCount; //-96
            d.kbmTurnover_.post;
          end
          else
          begin
            d.kbmTurnover_.insert;
            d.kbmTurnover_.FieldByName('ItemId').AsString := '-';
            d.kbmTurnover_.FieldByName('Description').AsString := 'Incluted ' + zGlob.TaxesItemDescription;
            d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + incl_cityTaxAmount;
            d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + incl_cityTaxVat;

            d.kbmTurnover_.FieldByName('Itemtype').AsString := zGlob.cTaxType;
            d.kbmTurnover_.FieldByName('Typedescription').AsString := zGlob.cTaxTypeDescription;
            d.kbmTurnover_.FieldByName('VATCode').AsString := zGlob.cTaxVATCode;
            d.kbmTurnover_.FieldByName('ItemCount').asFloat := cityTaxItemCount; //-96
            d.kbmTurnover_.FieldByName('VATPercentage').AsFloat := zGlob.cTaxVATPercentage;
            d.kbmTurnover_.post;
          end;
        end;
      end;
    finally
      d.kbmTurnover_.enableControls;
      d.kbmRoomsDateChange_.enableControls;
    end;
  end;

  rentAmount := 0;
  rentVat := 0;
  rentItemCount := 0;

  discountAmount := 0;
  discountVat := 0;
  discountItemCount := 0;

  cityTaxAmount := 0;
  cityTaxVat := 0;
  cityTaxItemCount := 0;

  incl_cityTaxAmount := 0;
  incl_cityTaxItemCount := 0;

  if d.kbmRoomRentOnInvoice_.recordcount > 0 then
  begin
    d.kbmRoomRentOnInvoice_.First;
    while not d.kbmRoomRentOnInvoice_.eof do
    begin
      item := d.kbmRoomRentOnInvoice_.FieldByName('itemID').AsString;
      isKredit := d.kbmRoomRentOnInvoice_.FieldByName('splitNumber').asinteger = 1;

      if isKredit then
      begin
        if _trimLower(item) = _trimLower(zGlob.RoomRentItem) then
        begin
          rentAmount := rentAmount + d.kbmRoomRentOnInvoice_.FieldByName('Amount').AsFloat;
          rentVat := rentVat + d.kbmRoomRentOnInvoice_.FieldByName('VAT').AsFloat;;
          rentItemCount := rentItemCount + d.kbmRoomRentOnInvoice_.FieldByName('ItemCount').asFloat; //-96
        end;

        if _trimLower(item) = _trimLower(zGlob.DiscountItem) then
        begin
          discountAmount := discountAmount + d.kbmRoomRentOnInvoice_.FieldByName('Amount').AsFloat;
          discountVat := discountVat + d.kbmRoomRentOnInvoice_.FieldByName('VAT').AsFloat;;
          discountItemCount := discountItemCount + d.kbmRoomRentOnInvoice_.FieldByName('ItemCount').asFloat; //-96
        end;

        if _trimLower(item) = _trimLower(zGlob.TaxesItem) then
        begin
          cityTaxAmount := cityTaxAmount + d.kbmRoomRentOnInvoice_.FieldByName('Amount').AsFloat;
          cityTaxVat := cityTaxVat + d.kbmRoomRentOnInvoice_.FieldByName('VAT').AsFloat;
          cityTaxItemCount := cityTaxItemCount + d.kbmRoomRentOnInvoice_.FieldByName('ItemCount').asFloat; //-96
        end;

        if d.kbmRoomRentOnInvoice_.FieldByName('isTaxIncluted').asboolean then
        begin
          incl_cityTaxAmount := incl_cityTaxAmount + (d.kbmRoomRentOnInvoice_.FieldByName('TotalStayTax').AsFloat);
          incl_cityTaxItemCount := incl_cityTaxItemCount + 1;
        end;
      end;
      d.kbmRoomRentOnInvoice_.Next;
    end;
  end;

  rentAmount := rentAmount - incl_cityTaxAmount;
  incl_cityTaxVat := _calcVat(incl_cityTaxAmount, zGlob.cTaxVATPercentage);

  if d.kbmRoomRentOnInvoice_.recordcount > 0 then
  begin
    if rentAmount <> 0 then
    begin
      if d.kbmTurnover_.Locate('ItemId', zGlob.RoomRentItem, []) then
      begin
        d.kbmTurnover_.Edit;
        d.kbmTurnover_.FieldByName('Amount').AsFloat :=
          d.kbmTurnover_.FieldByName('Amount').AsFloat + rentAmount;
        d.kbmTurnover_.FieldByName('VAT').AsFloat :=
          d.kbmTurnover_.FieldByName('Vat').AsFloat + rentVat;
        d.kbmTurnover_.FieldByName('Itemcount').AsFloat := d.kbmTurnover_.FieldByName('itemcount').AsFloat + rentItemCount; //-96
        d.kbmTurnover_.post;
      end
      else
      begin
        d.kbmTurnover_.insert;
        d.kbmTurnover_.FieldByName('ItemId').AsString := zGlob.RoomRentItem;
        d.kbmTurnover_.FieldByName('Description').AsString := zGlob.RoomRentItemDescription;
        d.kbmTurnover_.FieldByName('Amount').AsFloat := rentAmount;
        d.kbmTurnover_.FieldByName('VAT').AsFloat := rentVat;

        d.kbmTurnover_.FieldByName('Itemtype').AsString := zGlob.RoomRentType;
        d.kbmTurnover_.FieldByName('Typedescription').AsString := zGlob.RoomRentTypeDescription;
        d.kbmTurnover_.FieldByName('VATCode').AsString := zGlob.RoomRentVATCode;
        d.kbmTurnover_.FieldByName('ItemCount').asFloat := rentItemCount; //-96
        d.kbmTurnover_.FieldByName('VATPercentage').AsFloat := zGlob.RoomRentVATPercentage;

        d.kbmTurnover_.post;
      end;
    end;

    if discountAmount <> 0 then
    begin
      if d.kbmTurnover_.Locate('ItemId', zGlob.DiscountItem, []) then
      begin
        d.kbmTurnover_.Edit;
        d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + discountAmount * -1;
        d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + discountVat;
        d.kbmTurnover_.FieldByName('Itemcount').AsFloat := d.kbmTurnover_.FieldByName('itemcount').AsFloat + discountItemCount; //-96
        d.kbmTurnover_.post;
      end
      else
      begin
        d.kbmTurnover_.insert;
        d.kbmTurnover_.FieldByName('ItemId').AsString := zGlob.DiscountItem;
        d.kbmTurnover_.FieldByName('Description').AsString := zGlob.DiscountItemDescription;

        d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + discountAmount;
        d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + discountVat;

        d.kbmTurnover_.FieldByName('Itemtype').AsString := zGlob.DiscountType;
        d.kbmTurnover_.FieldByName('Typedescription').AsString := zGlob.DiscountTypeDescription;
        d.kbmTurnover_.FieldByName('VATCode').AsString := zGlob.RoomRentVATCode;
        d.kbmTurnover_.FieldByName('ItemCount').asFloat := discountItemCount; //-96
        d.kbmTurnover_.FieldByName('VATPercentage').AsFloat := zGlob.RoomRentVATPercentage;
        d.kbmTurnover_.post;
      end;
    end;

    if cityTaxAmount <> 0 then
    begin
      if d.kbmTurnover_.Locate('ItemId', zGlob.TaxesItem, []) then
      begin
        d.kbmTurnover_.Edit;
        d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + cityTaxAmount;
        d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + cityTaxVat;
        d.kbmTurnover_.FieldByName('Itemcount').AsFloat := d.kbmTurnover_.FieldByName('itemcount').AsFloat + cityTaxItemCount; //-96
        d.kbmTurnover_.post;
      end
      else
      begin
        d.kbmTurnover_.insert;
        d.kbmTurnover_.FieldByName('ItemId').AsString := zGlob.TaxesItem;
        d.kbmTurnover_.FieldByName('Description').AsString := zGlob.TaxesItemDescription;

        d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + cityTaxAmount;
        d.kbmTurnover_.FieldByName('VAT').AsFloat :=
          d.kbmTurnover_.FieldByName('Vat').AsFloat + cityTaxVat;

        d.kbmTurnover_.FieldByName('Itemtype').AsString := zGlob.cTaxType;
        d.kbmTurnover_.FieldByName('Typedescription').AsString := zGlob.cTaxTypeDescription;
        d.kbmTurnover_.FieldByName('VATCode').AsString := zGlob.cTaxVATCode;
        d.kbmTurnover_.FieldByName('ItemCount').asFloat := cityTaxItemCount; //-96
        d.kbmTurnover_.FieldByName('VATPercentage').AsFloat := zGlob.cTaxVATPercentage;
        d.kbmTurnover_.post;
      end;
    end;

    if incl_cityTaxAmount <> 0 then
    begin
      item := '-';
      if d.kbmTurnover_.Locate('ItemId', item, []) then
      begin
        d.kbmTurnover_.Edit;
        d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + incl_cityTaxAmount;
        d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + cityTaxVat;
        d.kbmTurnover_.FieldByName('Itemcount').AsFloat := d.kbmTurnover_.FieldByName('itemcount').AsFloat + cityTaxItemCount; //-96
        d.kbmTurnover_.post;
      end
      else
      begin
        d.kbmTurnover_.insert;
        d.kbmTurnover_.FieldByName('ItemId').AsString := item;
        d.kbmTurnover_.FieldByName('Description').AsString := 'Incluted ' + zGlob.TaxesItemDescription;

        d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + incl_cityTaxAmount;
        d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + incl_cityTaxVat;

        d.kbmTurnover_.FieldByName('Itemtype').AsString := zGlob.cTaxType;
        d.kbmTurnover_.FieldByName('Typedescription').AsString := zGlob.cTaxTypeDescription;
        d.kbmTurnover_.FieldByName('VATCode').AsString := zGlob.cTaxVATCode;
        d.kbmTurnover_.FieldByName('ItemCount').asFloat := cityTaxItemCount; //-96
        d.kbmTurnover_.FieldByName('VATPercentage').AsFloat := zGlob.cTaxVATPercentage;
        d.kbmTurnover_.post;
      end;
    end;
  end;
end;


procedure Td.TurnoverAndPaymentsUpdateTurnoverItemPriceChange(var rec : recTurnoverAndPaymentsGlobals );
var
  Amount: double;
  VAT: double;
  ItemCount: double;

  item: string;
begin
  if d.kbmInvoiceLinePriceChange_.recordcount = 0 then
    exit;

  d.kbmTurnover_.DisableControls;
  d.kbmInvoiceLinePriceChange_.DisableControls;
  try
    d.kbmInvoiceLinePriceChange_.First;
    while not d.kbmInvoiceLinePriceChange_.eof do
    begin
      item := d.kbmInvoiceLinePriceChange_.FieldByName('itemID').AsString;
      Amount := d.kbmInvoiceLinePriceChange_.FieldByName('Pricechange').AsFloat;
      VAT := d.kbmInvoiceLinePriceChange_.FieldByName('Vat').AsFloat;
      ItemCount := d.kbmInvoiceLinePriceChange_.FieldByName('ItemCount').asFloat; //-96

      if d.kbmTurnover_.Locate('ItemId', item, []) then
      begin
        d.kbmTurnover_.Edit;
        d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + Amount;
        d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + VAT;
        d.kbmTurnover_.FieldByName('Itemcount').AsFloat := d.kbmTurnover_.FieldByName('itemcount').asinteger + ItemCount; //-96
        d.kbmTurnover_.post;;
      end
      else
      begin
        d.kbmTurnover_.insert;
        d.kbmTurnover_.FieldByName('ItemId').AsString := item;
        d.kbmTurnover_.FieldByName('Amount').AsFloat := Amount;
        d.kbmTurnover_.FieldByName('VAT').AsFloat := VAT;
        d.kbmTurnover_.FieldByName('ItemCount').asFloat := ItemCount; //-96

        d.kbmTurnover_.FieldByName('Description').AsString :=
          d.kbmInvoiceLinePriceChange_.FieldByName('Description').AsString;
        d.kbmTurnover_.FieldByName('Itemtype').AsString :=
          d.kbmInvoiceLinePriceChange_.FieldByName('Itemtype').AsString;
        d.kbmTurnover_.FieldByName('Typedescription').AsString :=
          d.kbmInvoiceLinePriceChange_.FieldByName('Typedescription').AsString;
        d.kbmTurnover_.FieldByName('VATCode').AsString :=
          d.kbmInvoiceLinePriceChange_.FieldByName('VATCode').AsString;
        d.kbmTurnover_.FieldByName('VATPercentage').AsFloat :=
          d.kbmInvoiceLinePriceChange_.FieldByName('VATPercentage').AsFloat;
        d.kbmTurnover_.post;
      end;
      d.kbmInvoiceLinePriceChange_.Next;
    end;
  finally
    d.kbmInvoiceLinePriceChange_.enableControls;
    d.kbmTurnover_.enableControls;
  end;
end;


procedure Td.TurnoverAndPaymentsDoConfirm;
var
  rSet: TRoomerDataset;
  s: string;
  iCount: integer;
  ok: boolean;
  Amount: double;
  discount: double;
  Tax: double;
  id: integer;
  currencyRate: double;

  confirmDate: TdateTime;
  dataType: integer;
  item: string;
  Description: string;
  Staff: string;
  ItemType: string;
  ItemTypeDescription: string;
  itemNotes: string;
  VatCode: string;
  VATPercentage: double;
  VAT: double;
  ItemCount: double;

  StayDate: TdateTime;
  roomreservation: integer;
  reservation: integer;
  rentAmount: double;
  currency: string;
  isTaxIncluted: boolean;
  discountAmount: double;
  TotalStayTax: double;
  roomsdateID: integer;
  invoicenumber: integer;
  discountChange: double;
  taxChange: double;
  rentChange: double;
  ItemID: string;
  TypeDescription: string;
  ivlID: integer;
  PurchaseDate: TdateTime;
  confirmAmount: double;
  PriceChange: double;

  zConfirmedDate : TDateTime;
begin

  screen.Cursor := crHourglass;
  try

    zConfirmedDate := now;
    ok := true;

    d.kbmRoomsDate_.DisableControls;
    try
      d.kbmRoomsDate_.First;

      while not d.kbmRoomsDate_.eof do
      begin
        id := d.kbmRoomsDate_.FieldByName('id').asinteger;
        Amount := d.kbmRoomsDate_.FieldByName('RentAmount').AsFloat;
        discount := d.kbmRoomsDate_.FieldByName('discountAmount').AsFloat;
        Tax := d.kbmRoomsDate_.FieldByName('TotalStayTax').AsFloat;
        currencyRate := d.kbmRoomsDate_.FieldByName('currencyRate').AsFloat;

        s := '';
        s := s + ' UPDATE roomsdate ';
        s := s + ' SET ';
        s := s + '    ConfirmDate = ' + _dbDateAndTime(zConfirmedDate) + ' '#10;
        s := s + '   ,ConfirmAmount = ' + _db(Amount) + ' '#10;
        s := s + '   ,ConfirmDiscount = ' + _db(discount) + ' '#10;
        s := s + '   ,ConfirmTax = ' + _db(Tax) + ' '#10;
        s := s + '   ,ConfirmCurrencyRate = ' + _db(currencyRate) + ' '#10;
        s := s + ' WHERE ' + #10;
        s := s + '   (id = ' + _db(id) + ') ' + #10;
        if not cmd_bySQL(s) then
        begin
          ok := false;
        end;
        d.kbmRoomsDate_.Next;
      end;
    finally
      d.kbmRoomsDate_.enableControls;
    end;

    d.kbmRoomsDateChange_.DisableControls;
    try
      d.kbmRoomsDateChange_.First;

      while not d.kbmRoomsDateChange_.eof do
      begin
        id       := d.kbmRoomsDateChange_.FieldByName('RoomsdateID').asinteger;
        Amount   := d.kbmRoomsDateChange_.FieldByName('RentChange').AsFloat;
        discount := d.kbmRoomsDateChange_.FieldByName('discountChange').AsFloat;
        Tax      := d.kbmRoomsDateChange_.FieldByName('TaxChange').AsFloat;

        s := '';
        s := s + ' SELECT '#10;
        s := s + '  confirmAmount '#10;
        s := s + ' ,confirmDiscount '#10;
        s := s + ' ,confirmTax '#10;
        s := s + ' ,ResFlag '#10;
        s := s + ' FROM '#10;
        s := s + ' RoomsDate '#10;
        s := s + ' WHERE '#10;
        s := s + ' id=' + _db(id) + ' '#10;

        rSet := CreateNewDataSet;
        try
          rSet_bySQL(rSet, s);
          if not rSet.eof then
          begin
            if rSet.FieldByName('ResFlag').asstring = STATUS_DELETED then
            begin
              Amount     := 0.00;
              discount   := 0.00;
              Tax        := 0.00;
            end else
            begin
              Amount     := Amount   + rSet.FieldByName('confirmAmount').AsFloat;
              discount   := discount + rSet.FieldByName('confirmDiscount').AsFloat;
              Tax        := Tax      + rSet.FieldByName('confirmTax').AsFloat;
            end;
          end;
        finally
          freeandnil(rSet);
        end;

        //****ATHATH
        s := '';
        s := s + ' UPDATE roomsdate ';
        s := s + ' SET ';
        s := s + '    ConfirmAmount = ' + _db(Amount) + ' '#10;
        s := s + '   ,ConfirmDiscount = ' + _db(discount) + ' '#10;
        s := s + '   ,ConfirmTax = ' + _db(Tax) + ' '#10;
        s := s + ' WHERE ' + #10;
        s := s + '   (id = ' + _db(id) + ') ' + #10;

        if not cmd_bySQL(s) then
        begin
          ok := false;
        end;
        d.kbmRoomsDateChange_.Next;
      end;
    finally
      d.kbmRoomsDateChange_.enableControls;
    end;

    DReportData.kbmUnconfirmedInvoicelines_.DisableControls;
    try
      DReportData.kbmUnconfirmedInvoicelines_.First;
      while not DReportData.kbmUnconfirmedInvoicelines_.eof do
      begin
        id := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('id').asinteger;
//--villa
        Amount := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('Amount').asFloat;

        s := '';
        s := s + ' UPDATE invoicelines ';
        s := s + ' SET ';
        s := s + '    ConfirmDate = ' + _dbDateAndTime(zConfirmedDate) + ' '#10;
        s := s + '   ,ConfirmAmount = ' + _db(Amount) + ' '#10;
        s := s + ' WHERE ' + #10;
        s := s + '   (id = ' + _db(id) + ') ' + #10;
        if not cmd_bySQL(s) then
        begin
          ok := false;
        end;
        DReportData.kbmUnconfirmedInvoicelines_.Next;
      end;
    finally
      DReportData.kbmUnconfirmedInvoicelines_.enableControls;
    end;

    d.kbmInvoiceLinePriceChange_.DisableControls;
    try
      d.kbmInvoiceLinePriceChange_.First;
      while not d.kbmInvoiceLinePriceChange_.eof do
      begin
        id := d.kbmInvoiceLinePriceChange_.FieldByName('ivlid').asinteger;
        Amount := d.kbmInvoiceLinePriceChange_.FieldByName('Amount').asinteger;

        s := '';
        s := s + ' UPDATE invoicelines ';
        s := s + ' SET ';
        // s := s + '    ConfirmDate = '+_dbDateAndTime(confirmdate)+' '#10;
        s := s + '   ConfirmAmount = ' + _db(Amount) + ' '#10;
        s := s + ' WHERE ' + #10;
        s := s + '   (id = ' + _db(id) + ') ' + #10;
        if not cmd_bySQL(s) then
        begin
          ok := false;
        end;
        d.kbmInvoiceLinePriceChange_.Next;
      end;
    finally
      d.kbmInvoiceLinePriceChange_.enableControls;
    end;

    s := '';
    s := s + ' UPDATE payments ';
    s := s + ' SET ';
    s := s + '   ConfirmDate = ' + _dbDateAndTime(zConfirmedDate) + ' '#10;
    s := s + ' WHERE ' + #10;
    s := s + '   (confirmdate = ' + _db('1900-01-01 00:00:00') + ') ' + #10;
    if not cmd_bySQL(s) then
    begin
      ok := false;
    end;

    s := '';
    s := s + ' UPDATE invoiceheads ';
    s := s + ' SET ';
    s := s + '   ihConfirmDate = ' + _dbDateAndTime(zConfirmedDate) + ' '#10;
    s := s + ' WHERE ' + #10;
    s := s + '   (ihconfirmdate = ' + _db('1900-01-01 00:00:00') +
      ') AND (invoicenumber>0) ' + #10;
    if not cmd_bySQL(s) then
    begin
      ok := false;
    end;

    s := '';
    s := s + ' UPDATE invoicelines ';
    s := s + ' SET ';
    s := s + '   ConfirmDate = ' + _dbDateAndTime(zConfirmedDate) + ' '#10;
    s := s + ' WHERE ' + #10;
    s := s + '   (confirmdate = ' + _db('1900-01-01 00:00:00') +
      ') AND (invoicenumber>0) ' + #10;
    if not cmd_bySQL(s) then
    begin
      ok := false;
    end;

    d.kbmTurnover_.First;
    while not d.kbmTurnover_.eof do
    begin
      dataType := 1;
      confirmDate := zConfirmedDate;
      item := d.kbmTurnover_.FieldByName('itemID').AsString;
      Description := d.kbmTurnover_.FieldByName('Description').AsString;
      Staff := g.qusername;
      ItemType := d.kbmTurnover_.FieldByName('itemType').AsString;
      ItemTypeDescription := d.kbmTurnover_.FieldByName('TypeDescription').AsString;

      VatCode := d.kbmTurnover_.FieldByName('VATcode').AsString;
      VATPercentage := d.kbmTurnover_.FieldByName('VATPercentage').AsFloat;
      VAT := d.kbmTurnover_.FieldByName('VAT').AsFloat;
      ItemCount := d.kbmTurnover_.FieldByName('itemCount').asFloat; //-96
      Amount := d.kbmTurnover_.FieldByName('Amount').AsFloat;

      s := '';
      s := s + ' INSERT INTO turnoverandpayments '#10;
      s := s + ' ('#10;
      s := s + '  confirmDate '#10;
      s := s + ' ,Item '#10;
      s := s + ' ,Description '#10;
      s := s + ' ,Amount '#10;
      s := s + ' ,Staff '#10;
      s := s + ' ,ItemType '#10;
      s := s + ' ,ItemTypeDescription '#10;
      s := s + ' ,dataType '#10;
      s := s + ' ,VatCode '#10;
      s := s + ' ,VATPercentage '#10;
      s := s + ' ,VAT '#10;
      s := s + ' ,Itemcount) '#10;
      s := s + '  VALUES '#10;
      s := s + ' ( '#10;
      s := s + ' ' + _dbDateAndTime(confirmDate) + ' '#10;
      s := s + ' ,' + _db(item) + ' '#10;
      s := s + ' ,' + _db(Description) + ' '#10;
      s := s + ' ,' + _db(Amount) + ' '#10;
      s := s + ' ,' + _db(Staff) + ' '#10;
      s := s + ' ,' + _db(ItemType) + ' '#10;
      s := s + ' ,' + _db(ItemTypeDescription) + ' '#10;
      s := s + ' ,' + _db(dataType) + ' '#10;
      s := s + ' ,' + _db(VatCode) + ' '#10;
      s := s + ' ,' + _db(VATPercentage) + ' '#10;
      s := s + ' ,' + _db(VAT) + ' '#10;
      s := s + ' ,' + _db(ItemCount) + ' '#10;
      s := s + ' ) '#10;

      if not cmd_bySQL(s) then
      begin
        ok := false;
      end;
      d.kbmTurnover_.Next;
    end;

    d.kbmPayments_.First;
    while not d.kbmPayments_.eof do
    begin
      dataType := 2;
      confirmDate := zConfirmedDate;
      item := d.kbmPayments_.FieldByName('payType').AsString;
      Description := d.kbmPayments_.FieldByName('paytypeDescription').AsString;
      Staff := g.qusername;
      ItemType := '-';
      ItemTypeDescription := d.kbmPayments_.FieldByName
        ('paygroupDescripion').AsString;

      VatCode := '';
      VATPercentage := 0;
      VAT := 0;
      ItemCount := d.kbmPayments_.FieldByName('PaymentCount').asFloat; //-96
      Amount := d.kbmPayments_.FieldByName('Amount').AsFloat;

      s := '';
      s := s + ' INSERT INTO turnoverandpayments '#10;
      s := s + ' ('#10;
      s := s + '  confirmDate '#10;
      s := s + ' ,Item '#10;
      s := s + ' ,Description '#10;
      s := s + ' ,Amount '#10;
      s := s + ' ,Staff '#10;
      s := s + ' ,ItemType '#10;
      s := s + ' ,ItemTypeDescription '#10;
      s := s + ' ,dataType '#10;
      s := s + ' ,VatCode '#10;
      s := s + ' ,VATPercentage '#10;
      s := s + ' ,VAT '#10;
      s := s + ' ,Itemcount) '#10;
      s := s + '  VALUES '#10;
      s := s + ' ( '#10;
      s := s + ' ' + _dbDateAndTime(confirmDate) + ' '#10;
      s := s + ' ,' + _db(item) + ' '#10;
      s := s + ' ,' + _db(Description) + ' '#10;
      s := s + ' ,' + _db(Amount) + ' '#10;
      s := s + ' ,' + _db(Staff) + ' '#10;
      s := s + ' ,' + _db(ItemType) + ' '#10;
      s := s + ' ,' + _db(ItemTypeDescription) + ' '#10;
      s := s + ' ,' + _db(dataType) + ' '#10;
      s := s + ' ,' + _db(VatCode) + ' '#10;
      s := s + ' ,' + _db(VATPercentage) + ' '#10;
      s := s + ' ,' + _db(VAT) + ' '#10;
      s := s + ' ,' + _db(ItemCount) + ' '#10;
      s := s + ' ) '#10;

      if not cmd_bySQL(s) then
      begin
        ok := false;
      end;
      d.kbmPayments_.Next;
    end;

    d.kbmInvoiceLinePriceChange_.First;
    while not d.kbmInvoiceLinePriceChange_.eof do
    begin

      ItemID := d.kbmInvoiceLinePriceChange_.FieldByName('ItemID').AsString;
      Description := d.kbmInvoiceLinePriceChange_.FieldByName('Description').AsString;
      ItemType := d.kbmInvoiceLinePriceChange_.FieldByName('Itemtype').AsString;
      TypeDescription := d.kbmInvoiceLinePriceChange_.FieldByName('TypeDescription').AsString;
      VatCode := d.kbmInvoiceLinePriceChange_.FieldByName('VATCode').AsString;
      VATPercentage := d.kbmInvoiceLinePriceChange_.FieldByName('VATPercentage').AsFloat;
      Amount := d.kbmInvoiceLinePriceChange_.FieldByName('Amount').AsFloat;
      VAT := d.kbmInvoiceLinePriceChange_.FieldByName('VAT').AsFloat;
      ItemCount := d.kbmInvoiceLinePriceChange_.FieldByName('Itemcount').asFloat; //-96
      ivlID := d.kbmInvoiceLinePriceChange_.FieldByName('ivlID').asinteger;
      PurchaseDate := d.kbmInvoiceLinePriceChange_.FieldByName('PurchaseDate').asDateTime;
      reservation := d.kbmInvoiceLinePriceChange_.FieldByName('reservation').asinteger;
      roomreservation := d.kbmInvoiceLinePriceChange_.FieldByName('roomReservation').asinteger;
      confirmAmount := d.kbmInvoiceLinePriceChange_.FieldByName('confirmAmount').AsFloat;
      PriceChange := d.kbmInvoiceLinePriceChange_.FieldByName('PriceChange').AsFloat;

      // ItemID
      // Description
      // Itemtype
      // TypeDescription
      // VATCode
      // VATPercentage
      // Amount
      // VAT
      // Itemcount
      // ivlID
      // PurchaseDate
      // reservation
      // roomReservation
      // confirmAmount
      // PriceChange
      // Confirmdate

      s := '';
      s := s + ' INSERT INTO invoicelinepricechange '#10;
      s := s + ' ('#10;
      s := s + '   ItemID '#10;
      s := s + ' ,Description '#10;
      s := s + ' ,Itemtype '#10;
      s := s + ' ,TypeDescription '#10;
      s := s + ' ,VATCode '#10;
      s := s + ' ,VATPercentage '#10;
      s := s + ' ,Amount '#10;
      s := s + ' ,VAT '#10;
      s := s + ' ,Itemcount '#10;
      s := s + ' ,ivlID '#10;
      s := s + ' ,PurchaseDate '#10;
      s := s + ' ,reservation '#10;
      s := s + ' ,roomReservation '#10;
      s := s + ' ,confirmAmount '#10;
      s := s + ' ,PriceChange '#10;
      s := s + ' ,Confirmdate '#10;
      s := s + ' ) '#10;
      s := s + '  VALUES '#10;
      s := s + ' ( '#10;
      s := s + '  ' + _db(ItemID) + ' '#10;
      s := s + ' ,' + _db(Description) + ' '#10;
      s := s + ' ,' + _db(ItemType) + ' '#10;
      s := s + ' ,' + _db(TypeDescription) + ' '#10;
      s := s + ' ,' + _db(VatCode) + ' '#10;
      s := s + ' ,' + _db(VATPercentage) + ' '#10;
      s := s + ' ,' + _db(Amount) + ' '#10;
      s := s + ' ,' + _db(VAT) + ' '#10;
      s := s + ' ,' + _db(ItemCount) + ' '#10;
      s := s + ' ,' + _db(ivlID) + ' '#10;
      s := s + ' ,' + _db(PurchaseDate) + ' '#10;
      s := s + ' ,' + _db(reservation) + ' '#10;
      s := s + ' ,' + _db(roomreservation) + ' '#10;
      s := s + ' ,' + _db(confirmAmount) + ' '#10;
      s := s + ' ,' + _db(PriceChange) + ' '#10;
      s := s + ' ,' + _dbDateAndTime(zConfirmedDate) + ' '#10;
      s := s + ' ) '#10;

      if not cmd_bySQL(s) then
      begin
        ok := false;
      end;
      d.kbmInvoiceLinePriceChange_.Next;
    end;

    d.kbmRoomsDateChange_.First;
    while not d.kbmRoomsDateChange_.eof do
    begin
      StayDate        := d.kbmRoomsDateChange_.FieldByName('StayDate').asDateTime;
      roomreservation := d.kbmRoomsDateChange_.FieldByName('roomreservation').asinteger;
      reservation     := d.kbmRoomsDateChange_.FieldByName('reservation').asinteger;
      rentAmount      := d.kbmRoomsDateChange_.FieldByName('RentAmount').AsFloat;
      currency        := d.kbmRoomsDateChange_.FieldByName('currency').AsString;
      currencyRate    := d.kbmRoomsDateChange_.FieldByName('currencyRate').AsFloat;
      isTaxIncluted   := d.kbmRoomsDateChange_.FieldByName('isTaxIncluted').asboolean;
      discountAmount  := d.kbmRoomsDateChange_.FieldByName('DiscountAmount').AsFloat;
      TotalStayTax    := d.kbmRoomsDateChange_.FieldByName('TotalStayTax').AsFloat;
      roomsdateID     := d.kbmRoomsDateChange_.FieldByName('roomsdateID').asinteger;
      invoicenumber   := d.kbmRoomsDateChange_.FieldByName('invoicenumber').asinteger;
      discountChange  := d.kbmRoomsDateChange_.FieldByName('discountChange').AsFloat;
      taxChange       := d.kbmRoomsDateChange_.FieldByName('taxChange').AsFloat;
      rentChange      := d.kbmRoomsDateChange_.FieldByName('rentChange').AsFloat;
      s := '';
      s := s + ' INSERT INTO roomsdatechange '#10;
      s := s + ' ('#10;
      s := s + '  StayDate '#10;
      s := s + ' ,roomreservation '#10;
      s := s + ' ,reservation '#10;
      s := s + ' ,RentAmount '#10;
      s := s + ' ,currency '#10;
      s := s + ' ,currencyRate '#10;
      s := s + ' ,isTaxIncluted '#10;
      s := s + ' ,DiscountAmount '#10;
      s := s + ' ,TotalStayTax '#10;
      s := s + ' ,roomsdateID '#10;
      s := s + ' ,invoicenumber '#10;
      s := s + ' ,discountChange '#10;
      s := s + ' ,taxChange '#10;
      s := s + ' ,rentChange '#10;
      s := s + ' ,Confirmdate '#10;
      s := s + ' ) '#10;
      s := s + '  VALUES '#10;
      s := s + ' ( '#10;
      s := s + '  ' + _db(StayDate) + ' '#10;
      s := s + ' ,' + _db(roomreservation) + ' '#10;
      s := s + ' ,' + _db(reservation) + ' '#10;
      s := s + ' ,' + _db(rentAmount) + ' '#10;
      s := s + ' ,' + _db(currency) + ' '#10;
      s := s + ' ,' + _db(currencyRate) + ' '#10;
      s := s + ' ,' + _db(isTaxIncluted) + ' '#10;
      s := s + ' ,' + _db(discountAmount) + ' '#10;
      s := s + ' ,' + _db(TotalStayTax) + ' '#10;
      s := s + ' ,' + _db(roomsdateID) + ' '#10;
      s := s + ' ,' + _db(invoicenumber) + ' '#10;
      s := s + ' ,' + _db(discountChange) + ' '#10;
      s := s + ' ,' + _db(taxChange) + ' '#10;
      s := s + ' ,' + _db(rentChange) + ' '#10;
      s := s + ' ,' + _dbDateAndTime(zConfirmedDate) + ' '#10;
      s := s + ' ) '#10;
      if not cmd_bySQL(s) then
      begin
        ok := false;
      end;
      d.kbmRoomsDateChange_.Next;
    end;

    if ok then
    begin
      g.qLastConfirm := zConfirmedDate;
//      zIsConfirmed := true;
//      zConfirmState := 2;
//      btnConfirm.visible := false;
//      btnGetOld.visible := true;
//      chkGetUnconfirmed.checked := false;
    end;
  finally
    screen.Cursor := crDefault;
  end;
end;


function minutesFromMidnight : Integer;
var
  Hour,Min,Sec,MSec: Word;
  aTime : TdateTime;
begin
  aTime := now;
  DecodeTime(ATime, Hour, Min, Sec, MSec);
  Result := (Hour * 60) + Min;
end;

procedure Td.confirmMonitorTimer(Sender: TObject);
var
  doIt : boolean;
  globals : recTurnoverAndPaymentsGlobals;
  globals_II : recTurnoverAndPaymentsGlobals_II;
  s : string;
begin
  if NOT d.roomerMainDataSet.LoggedIn then exit;

  doIt := false;
  if g.qConfirmAuto then
  begin
    if  (MinutesBetween(now,g.qLastConfirm) > 1440) AND (g.qLastConfirm>2) then
    begin
      doIt := true
    end else
    if (minutesFromMidnight > g.qConfirmMinuteOfTheDay-1) and (minutesFromMidnight < g.qConfirmMinuteOfTheDay+2) then
    begin
      if MinutesBetween(now,g.qLastConfirm) > 5 then doIt := true;
    end;
    if doit then
    begin
      if isStayTaxExcluded then
      begin
        initTurnoverAndPaymentsGlobals_II(globals_II);
        d.TurnoverAndPaymentsGetAll_II(false,globals_II);
        d.TurnoverAndPaymentsDoConfirm_II;
        d.TurnoverAndPayemnetsClearAllData(true);
      end else
      begin
        initTurnoverAndPaymentsGlobals(globals);
        d.TurnoverAndPaymentsGetAll(false,globals);
        d.TurnoverAndPaymentsDoConfirm;
        d.TurnoverAndPayemnetsClearAllData(true);
      end;
      datetimetostring(s,'YYYY-DD-MM hh:nn:ss',now);
      showmessage('Turnover and payments - Auto Confirmed at  '+s);
    end;
  end;
end;

function Td.GetLastConfirm : TDateTime;
var
  rSet : TRoomerDataSet;
  s : string;
begin
  Result := 0;
  if frmMain.OffLineMode then
    exit;

  rSet := CreateNewDataSet;
  try
    s := '';
    s := s+' SELECT '#10;
    s := s+'   confirmdate '#10;
    s := s+' FROM '#10;
    s := s+'   turnoverandpayments '#10;
    s := s+' ORDER BY '#10;
    s := s+'   confirmdate desc '#10;
    s := s+' LIMIT 1; '#10;
    rSet_bySQL(rSet, s);
    if not rSet.eof then
    begin
      result := rSet.FieldByName('confirmdate').AsDateTime;
    end else
    begin
      result := 2;
    end;
  finally
    freeandnil(rSet);
  end;
end;

///////////////////////////////////////////////////////////////////////
// Tornover and payments
// New works if city tax is always excluted as an item
///////////////////////////////////////////////////////////////////////


// use both in 1 and 2
procedure td.TurnoverAndPayemnetsClearAllData(justClose : boolean);
begin
  d.kbmTurnover_.Close;
  d.kbmPayments_.Close;
  d.kbmRoomsDate_.Close;
  d.kbmRoomRentOnInvoice_.Close;
  d.mInvoiceHeads.Close;
  d.mInvoiceLines.Close;
  DReportData.kbmUnconfirmedInvoicelines_.Close;
  d.kbmInvoiceLinePriceChange_.Close;
  d.kbmPaymentList_.Close;
  d.mrptPayments.Close;
  d.mrptTurnover.close;

  if not justClose then
  begin
    d.kbmTurnover_.open;
    d.kbmPayments_.open;
    d.kbmRoomsDate_.open;
    d.kbmRoomRentOnInvoice_.open;
    d.mInvoiceHeads.open;
    d.mInvoiceLines.open;
    DReportData.kbmUnconfirmedInvoicelines_.open;
    d.kbmInvoiceLinePriceChange_.open;
    d.kbmPaymentList_.open;
    d.mrptPayments.open;
    d.mrptTurnover.Open;
  end;
end;


procedure Td.TurnoverAndPaymentsGetAll_II(clearData: boolean;var zGlob : recTurnoverAndPaymentsGlobals_II);
var
  s: string;
    rset1
  , rset2
  , rset3
  , rset4
  , rset5
  , rset6
  , rset7
  , rset8
  , rset9
  , rset10
  , rSet11
  , rSet12
  : TRoomerDataset;

  ExecutionPlan: TRoomerExecutionPlan;

  startTick: integer;
  stopTick: integer;
  SQLms: integer;

  lst: TstringList;

  dateFrom: Tdate;
  dateTo: Tdate;

  sUnconfirmedDate : string;

  debug_s : string;


begin

  sUnconfirmedDate := '1900-01-01 00:00:00';

//ATH  if length(trim(edUnconfirmedDate.Text)) = 19  then
//  begin
//    sUnconfirmedDate := edUnconfirmedDate.Text;
//    try
//      datetimetostring(sUnconfirmedDate, 'yyyy-mm-dd hh:nn:ss', unconfirmedDate);
//    Except
//      sUnconfirmedDate := '1900-01-01 00:00:00';
//    end;
//  end;

  //2
  screen.Cursor := crHourGlass;
  try
    if zglob.ConfirmState = 1 then
    begin
      lst := invoiceList_Unconfirmed();
      try
        zglob.Invoicelist := CreateSQLInText(lst);
      finally
        freeandnil(lst);
      end;
    end
  finally
    screen.Cursor := crDefault;
  end;

  //2

  debug_s := 'use home100_xhj;';
  screen.Cursor := crHourGlass;
  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  try
    s := '';
    s := s + ' SELECT '#10;
    s := s + '     il.ItemID '#10;
    s := s + '   , il.invoicenumber '#10;
    s := s + '   , it.Description '#10;
    s := s + '   , it.Itemtype '#10;
    s := s + '   , ity.Description AS TypeDescription '#10;
    s := s + '   , ity.VATCode '#10;
    s := s + '   , vat.VATPercentage '#10;
    s := s + '   , SUM(il.Total) AS Amount '#10;
    s := s + '   , SUM(il.Vat) AS VAT '#10;
    s := s + '   , SUM(il.Number) AS Itemcount '#10;
    s := s + ' FROM '#10;
    s := s + '   invoicelines il INNER JOIN '#10;
    s := s + '   items it ON il.ItemID = it.Item INNER JOIN '#10;
    s := s + '   itemtypes ity ON it.Itemtype = ity.Itemtype INNER JOIN '#10;
    s := s + '   vatcodes vat ON ity.VATCode = vat.VATCode '#10;
    s := s + ' WHERE '#10;
    s := s + '( confirmDate = ' + _db(sUnconfirmedDate) + ' ) ';
    s := s + '  AND  ((il.ItemID <> ' + _db(zglob.RoomRentItem) + ' )  '#10;
    s := s + '  AND  (il.ItemID <> ' + _db(zglob.DiscountItem) + ' )  '#10;
    s := s + '  AND  (il.ItemID <> ' + _db(zglob.TaxesItem) + ' ))  '#10;

    //  s := s + '  AND  ((il.ItemID <> ' + _db(zglob.TaxesItem) + ' ) and (il.invoicenumber = -1)) ) '#10;

    s := s + ' GROUP BY '#10;
    s := s + '     il.ItemID '#10;
    s := s + '   , it.Description '#10;
    s := s + '   , it.Itemtype '#10;
    s := s + '   , ity.Description '#10;
    s := s + '   , ity.VATCode '#10;
    s := s + '   , vat.VATPercentage ;'#10;

    // rset1,Results[0],d.kbmTurnover_
    debug_s := debug_s+#10#10'-- 0 d.kbmTurnover_. '#10+s;

//    copyToClipboard(s);
//    DebugMessage('-- 0 Turnower '#10+s);
    ExecutionPlan.AddQuery(s);


    //2
    s := '';
    s := s + ' SELECT '#10;
    s := s + '  pm.PayType '#10;
    s := s + ' ,sum(pm.Amount) AS Amount '#10;
    s := s + ' ,count(pm.ID) AS PaymentCount '#10;
    s := s + ' ,pty.description AS paytypeDescription '#10;
    s := s + ' ,pgr.description AS paygroupDescripion '#10;
    s := s + ' FROM payments pm INNER JOIN '#10;
    s := s + '      paytypes pty ON pm.paytype = pty.paytype INNER JOIN '#10;
    s := s + '      paygroups pgr ON pty.paygroup = pgr.paygroup '#10;
    s := s + '  WHERE '#10;
    s := s + '( confirmDate = ' + _db(sUnconfirmedDate) + ' ) ';
    s := s + '  GROUP BY '#10;
    s := s + '    pm.PayType '#10;
    s := s + '   ,pty.description '#10;
    s := s + '   ,pgr.description ;'#10;

    debug_s := debug_s+#10#10'-- 1 d.kbmPayments_. '#10+s;
//    copyToClipboard(s);
//    DebugMessage('-- 1 '#10+s);
    ExecutionPlan.AddQuery(s);

    s := '';
    s := s + ' SELECT '#10;
    s := s + '   rd.id '#10;
    s := s + ' , date(rd.ADate) as StayDate '#10;
    s := s + ' , rd.roomreservation '#10;
    s := s + ' , rd.reservation '#10;
    s := s + ' , rd.invoicenumber '#10;
    s := s + ' , rd.roomrate*cr.AValue AS RentAmount '#10;
    s := s + ' , rd.currency '#10;
    s := s + ' , rd.confirmdate '#10;
    s := s + ' , rd.paid '#10;
    s := s + ' , rv.customer '#10;
    s := s + ' , cr.avalue AS currencyRate '#10;

    s := s + ' , (SELECT stayTaxIncluted FROM customers WHERE customer = rv.customer Limit 1) AS isTaxIncluted '#10;
    s := s + ' , (IF(rd.isPercentage, rd.RoomRate*rd.Discount/100, rd.Discount)*cr.avalue) AS DiscountAmount '#10;

//    s := s + ' , (IF((SELECT StayTaxPerPerson from control LIMIT 1) '#10;
//    s := s + '     ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1))*(SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation) '#10;
//    s := s + '     ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1)) '#10;
//    s := s + '   )) AS TotalStayTax '#10;
//
//    s := s + ' FROM '#10;
//    s := s + '   roomsdate rd '#10;
//    s := s + '   INNER JOIN reservations rv ON rd.reservation = rv.reservation '#10;
//    s := s + '   INNER JOIN currencies cr ON rd.currency = cr.currency '#10;

    s := s + '  , ROUND((IF(tax.TAX_BASE='+_db('GUEST_NIGHT')+' '#10;
    s := s + '      ,IF(tax.TAX_TYPE='+_db('PERCENTAGE')+', '#10;
    s := s + '            rd.roomrate*cr.AValue*(SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation)* '#10;
    s := s + '                 IF(tax.NETTO_AMOUNT_BASED='+_db('TRUE')+', tax.AMOUNT/(1+vc.VatPercentage/100), tax.AMOUNT) / 100, '#10;
    s := s + '            (SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation)*tax.AMOUNT) '#10;
    s := s + '      ,IF(tax.TAX_TYPE='+_db('PERCENTAGE')+', '#10;
    s := s + '            rd.roomrate*cr.AValue*IF(tax.NETTO_AMOUNT_BASED='+_db('TRUE')+', tax.AMOUNT/(1+vc.VatPercentage/100), tax.AMOUNT) / 100, '#10;
    s := s + '            tax.AMOUNT) '#10;
    s := s + '    ))/tax.ROUND_VALUE)*tax.ROUND_VALUE AS TotalStayTax '#10;

    s := s + '  FROM '#10;
    s := s + '    roomsdate rd '#10;
    s := s + '    INNER JOIN reservations rv ON rd.reservation = rv.reservation '#10;
    s := s + '    INNER JOIN currencies cr ON rd.currency = cr.currency, '#10;
    s := s + '    control co '#10;
    s := s + '    INNER JOIN items i ON item=co.RoomRentItem '#10;
    s := s + '    INNER JOIN itemtypes it ON it.ItemType=i.ItemType '#10;
    s := s + '    INNER JOIN vatcodes vc ON vc.VATCode=it.VatCode '#10;
    s := s + '    JOIN home100.TAXES tax ON HOTEL_ID=(Select companyID from control LIMIT 1) AND CURRENT_DATE>=VALID_FROM AND CURRENT_DATE<=VALID_TO '#10;

    s := s + ' WHERE '#10;
    s := s + ' ( confirmDate = ' + _db(sUnconfirmedDate) + ' ) ';
    s := s + ' AND ((((rd.resflag IN ('+_db('G')+','+_db('D')+')))  '#10;
    s := s + ' AND (date(rd.ADate) <=  CURDATE())) OR (rd.invoicenumber > 0)) '#10;
    s := s + ' AND (ResFlag not in ('+_db('X')+','+_db('C')+')) ;';
//  s := s + ' AND (rd.paid = 0) ';

    //2
    //rset3,Results[2],d.kbmRoomsDate_
    debug_s := debug_s+#10#10'-- 2 d.kbmRoomsDate_. '#10+s;
//    copyToClipboard(s);
//    DebugMessage('-- 2 '#10+s);
    ExecutionPlan.AddQuery(s);

    s := '';
    s := s + ' SELECT '#10;
    s := s + '     il.ItemID '#10;
    s := s + '   , il.Invoicenumber '#10;
    s := s + '   , (SELECT Room FROM roomreservations WHERE RoomReservation=il.Roomreservation LIMIT 1) AS Room '#10;
    s := s + '   , ih.Staff '#10;
    s := s + '   , il.splitNumber '#10;
    s := s + '   , it.Description '#10;
    s := s + '   , it.Itemtype '#10;
    s := s + '   , ity.Description AS TypeDescription '#10;
    s := s + '   , ity.VATCode '#10;
    s := s + '   , vat.VATPercentage '#10;
    s := s + '   , il.Total AS Amount '#10;
    s := s + '   , il.Vat AS VAT '#10;
    s := s + '   , il.Number AS Itemcount '#10;
    s := s + '   , il.confirmAmount '#10;
    s := s + '   , ih.Customer '#10;

   //*2 finna total útfrá
   //

   s := s + '   , (SELECT stayTaxIncluted FROM customers WHERE customer = ih.customer) AS isTaxIncluted '#10;
//   s := s + '   , (SELECT SUM(Total) FROM invoicelines il1 WHERE il1.ItemId=co.StayTaxItem ' +
//            ' AND il1.InvoiceNumber=il.InvoiceNumber) AS TotalStayTax '#10;
   s := s + '  , IF(il.ItemId=co.StayTaxItem, il.Total, 0) AS TotalStayTax '#10;

//    s := s + '   , (IF((SELECT StayTaxPerPerson from control LIMIT 1) '#10;
//    s := s + '        ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1))*(il.persons) '#10;
//    s := s + '        ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1))*(il.number) '#10;
//    s := s + '       )) AS TotalStayTax '#10;

    s := s + ' FROM '#10;
    s := s + '   invoicelines il INNER JOIN '#10;
    s := s + '   items it ON il.ItemID = it.Item INNER JOIN '#10;
    s := s + '   invoiceheads ih ON il.invoicenumber = ih.invoicenumber INNER JOIN '#10;
    s := s + '   itemtypes ity ON it.Itemtype = ity.Itemtype INNER JOIN '#10;
    s := s + '   vatcodes vat ON ity.VATCode = vat.VATCode, '#10;
    s := s + '   control co '#10;
    s := s + ' WHERE '#10;
    s := s + '( confirmDate = ' + _db(sUnconfirmedDate) + ' ) ';
    s := s + '  AND  ((il.ItemID = ' + _db(zglob.RoomRentItem) + ' )  '#10;
    s := s + '  OR   (il.ItemID = ' + _db(zglob.DiscountItem) + ' )  '#10;
    s := s + '  OR   (il.ItemID = ' + _db(zglob.TaxesItem) + ' )) '#10;
    s := s + '  AND  (il.invoicenumber > 0)  ;'#10;

    // rset4,Results[3],d.kbmRoomRentOnInvoice_
    debug_s := debug_s+#10#10'-- 3 d.kbmRoomRentOnInvoice_. '#10+s;
//    copyToClipboard(s);
//    DebugMessage('-- 3 Getting items in invoicelines is roomrent and invoiced'#10#10+s);
    ExecutionPlan.AddQuery(s);

    s := '';
    s := s + ' SELECT ' + #10;
    s := s + '     ih.Reservation ' + #10;
    s := s + '   , ih.RoomReservation ' + #10;
    s := s + '   , ih.SplitNumber ' + #10;
    s := s + '   , ih.InvoiceNumber ' + #10;
    s := s + '   , ih.Customer ' + #10;
    s := s + '   , ih.Name AS NameOnInvoice ' + #10;
    s := s + '   , ih.Address1 ' + #10;
    s := s + '   , ih.Address2 ' + #10;
    s := s + '   , ih.Address3 ' + #10;
    s := s + '   , ih.Total AS ihAmountWithTax ' + #10;
    s := s + '   , ih.TotalWOVAT AS ihAmountNoTax ' + #10;
    s := s + '   , ih.TotalVAT AS ihAmountTax ' + #10;
    s := s + '   , ih.CreditInvoice ' + #10;
    s := s + '   , ih.OriginalInvoice ' + #10;
    s := s + '   , ih.RoomGuest ' + #10;
    s := s + '   , ih.ihInvoiceDate AS InvoiceDate ' + #10;
    s := s + '   , ih.ihPayDate AS dueDate ' + #10;
    s := s + '   , ih.invRefrence ' + #10;
    s := s + '   , ih.TotalStayTax ' + #10;
    s := s + '   , ih.TotalStayTaxNights ' + #10;
    s := s + '   , ih.ihConfirmDate AS ConfirmedDate ' + #10;
    s := s + '   , ih.ihCurrency AS Currency ' + #10;
    s := s + '   , ih.ihCurrencyRate AS Rate ' + #10;
    s := s + '   , ih.ihStaff AS Staff ' + #10;
    s := s + '   , cu.Surname AS CustomerName ' + #10;
    s := s + '   , cu.TravelAgency AS isAgency ' + #10;
    s := s + '   , cu.CustomerType AS markedSegment ' + #10;
    s := s + '   , ct.Description AS markedSegmentDescription ' + #10;
    s := s + ' FROM ' + #10;
    s := s + '   customertypes ct ' + #10;
    s := s + '     RIGHT OUTER JOIN customers cu ON ct.CustomerType = cu.CustomerType '
      + #10;
    s := s + '     RIGHT OUTER JOIN invoiceheads ih ON cu.Customer = ih.Customer '
      + #10;
    s := s + ' WHERE ' + #10;
    if zglob.InvoiceList <> '' then
    begin
      s := s + '   (ih.InvoiceNumber IN ' + zglob.InvoiceList + ') ' + #10;
    end
    else
    begin
      s := s + '   (ih.InvoiceNumber = -888) ' + #10;
    end;
    s := s + ' ORDER BY ' + #10;
    s := s + '   ih.InvoiceNumber ;' + #10;


    debug_s := debug_s+#10#10'-- 4 d.mInvoiceHeads. '#10+s;

    // rset5,Results[4]d.mInvoiceHeads
//    copyToClipboard(s);
//    DebugMessage('-- 4 Invoiceheads'#10#10+s);
    ExecutionPlan.AddQuery(s);

    s := '';
    s := s + ' SELECT ' + #10;
    s := s + '     il.InvoiceNumber ' + #10;
    s := s + '   , date(il.PurchaseDate) AS PurchaseDate ' + #10;
    s := s + '   , il.ItemID as Item' + #10;
    s := s + '   , il.Number as Quantity' + #10;
    s := s + '   , il.Description ' + #10;
    s := s + '   , il.Price ' + #10;
    s := s + '   , il.VATType ' + #10;
    s := s + '   , il.Total AS ilAmountWithTax ' + #10;
    s := s + '   , il.TotalWOVat AS ilAmountNoTax ' + #10;
    s := s + '   , il.Vat as ilAmountTax' + #10;
    s := s + '   , il.Currency ' + #10;
    s := s + '   , il.CurrencyRate ' + #10;
    s := s + '   , il.ImportRefrence ' + #10;
    s := s + '   , il.ImportSource ' + #10;
    s := s + ' FROM ' + #10;
    s := s + '   invoicelines il ' + #10;
    s := s + ' WHERE ' + #10;
    if zglob.InvoiceList <> '' then
    begin
      s := s + '   (il.InvoiceNumber IN ' + zglob.InvoiceList + ') ' + #10;
    end
    else
    begin
      s := s + '   (il.InvoiceNumber = -888) ;' + #10;
    end;

    // rset6,Results[5],d.mInvoiceLines
    debug_s := debug_s+#10#10'-- 5 d.mInvoiceLines. '#10+s;
//    copyToClipboard(s);
//    DebugMessage('-- 5 invoicelines '#10#10+s);
    ExecutionPlan.AddQuery(s);

    s := '';
    s := s + ' SELECT id from control ;' + #10;

    // rset7,Results[6],kbmRoomsDateInvoiced_
//    copyToClipboard(s);
//    DebugMessage('Getting all unpaid roomrent'#10#10+s);
    ExecutionPlan.AddQuery(s);

    s := '';
    s := s + ' SELECT '#10;
    s := s + '     il.ID '#10;
    s := s + '   , il.Reservation '#10;
    s := s + '   , il.Roomreservation '#10;
    s := s + '   , (SELECT Room FROM roomreservations WHERE RoomReservation=il.Roomreservation LIMIT 1) AS Room '#10;
    s := s + '   , (SELECT Staff FROM invoiceheads WHERE InvoiceNumber=il.InvoiceNumber LIMIT 1) AS Staff '#10;
    s := s + '   , CAST((SELECT IF(InvoiceNumber>0, InvoiceNumber, '+quotedStr('-1')+') FROM invoiceheads WHERE InvoiceNumber=il.InvoiceNumber LIMIT 1) AS CHAR(10)) AS InvoiceNumber '#10;
    s := s + '   , date(il.PurchaseDate) As PurchaseDate '#10;
    s := s + '   , il.ItemID '#10;
    s := s + '   , it.Description '#10;
    s := s + '   , it.Itemtype '#10;
    s := s + '   , ity.Description AS TypeDescription '#10;
    s := s + '   , ity.VATCode '#10;
    s := s + '   , vat.VATPercentage '#10;
    s := s + '   , il.Total AS Amount '#10;
    s := s + '   , il.Vat AS VAT '#10;
    s := s + '   , il.Number AS Itemcount '#10;
    s := s + '   , il.confirmAmount '#10;
    s := s + ' FROM '#10;
    s := s + '   invoicelines il INNER JOIN '#10;
    s := s + '   items it ON il.ItemID = it.Item INNER JOIN '#10;
    s := s + '   itemtypes ity ON it.Itemtype = ity.Itemtype INNER JOIN '#10;
    s := s + '   vatcodes vat ON ity.VATCode = vat.VATCode '#10;
    s := s + ' WHERE '#10;
    s := s + '( confirmDate = ' + _db(sUnconfirmedDate) + ' ) ';
    s := s + '  AND  ((il.ItemID <> ' + _db(zglob.RoomRentItem) + ' )  '#10;
    s := s + '  AND  (il.ItemID <> ' + _db(zglob.DiscountItem) + ' )  '#10;
    s := s + '  AND  (il.ItemID <> ' + _db(zglob.TaxesItem) + ' ))  ;'#10;

    debug_s := debug_s+#10#10'-- 7 DReportData.kbmUnconfirmedInvoicelines_. Getting items in invoicelines that is not roomrent'#10+s;
    // rset8,Results[7],DReportData.kbmUnconfirmedInvoicelines_
//    copyToClipboard(s);
//    DebugMessage('-- 6 Getting items in invoicelines that is not roomrent'#10#10+s);
    ExecutionPlan.AddQuery(s);

    s := '';
    s := s + ' SELECT '#10;
    s := s + '     il.ID AS ivlID'#10;
    s := s + '   , il.Reservation '#10;
    s := s + '   , il.Roomreservation '#10;
    s := s + '   , date(il.PurchaseDate) As PurchaseDate '#10;
    s := s + '   , il.ItemID '#10;
    s := s + '   , it.Description '#10;
    s := s + '   , it.Itemtype '#10;
    s := s + '   , ity.Description AS TypeDescription '#10;
    s := s + '   , ity.VATCode '#10;
    s := s + '   , vat.VATPercentage '#10;
    s := s + '   , il.Total AS Amount '#10;
    s := s + '   , il.Vat AS VAT '#10;
    s := s + '   , il.Number AS Itemcount '#10;
    s := s + '   , il.confirmAmount '#10;
    s := s + '   , (il.Total-il.confirmAmount) AS pricechange'#10;
    s := s + ' FROM '#10;
    s := s + '   invoicelines il INNER JOIN '#10;
    s := s + '   items it ON il.ItemID = it.Item INNER JOIN '#10;
    s := s + '   itemtypes ity ON it.Itemtype = ity.Itemtype INNER JOIN '#10;
    s := s + '   vatcodes vat ON ity.VATCode = vat.VATCode '#10;
    s := s + ' WHERE '#10;
    s := s + '( confirmDate > ' + _db(sUnconfirmedDate) + ' ) ';
    s := s + '  AND  ((il.ItemID <> ' + _db(zglob.RoomRentItem) + ' )  '#10;
    s := s + '  AND  (il.ItemID <> ' + _db(zglob.DiscountItem) + ' )  '#10;
    s := s + '  AND  (il.ItemID <> ' + _db(zglob.TaxesItem) + ' ))  '#10;
    s := s + '  AND  ((il.Total-il.confirmAmount) <> 0)  ;'#10;

    // rset9,Results[8],d.kbmInvoiceLinePriceChange_
    debug_s := debug_s+#10#10'-- 8 d.kbmInvoiceLinePriceChange_. Getting items in invoicelines that is not roomrent'#10+s;
//    copyToClipboard(s);
//    DebugMessage('-- 7 Getting items in invoicelines that is not roomrent'#10#10+s);
    ExecutionPlan.AddQuery(s);

    // **zxhj
    s := '';
    s := s + ' SELECT '#10;
    s := s + '   rd.id AS roomsdateID'#10;
    s := s + ' , date(rd.ADate) as StayDate '#10;
    s := s + ' , rd.roomreservation '#10;
    s := s + ' , rd.reservation '#10;
    s := s + ' , rd.invoicenumber '#10;
    s := s + ' , rd.roomrate*cr.AValue AS RentAmount '#10;
    s := s + ' , rd.currency '#10;
    s := s + ' , rd.confirmdate '#10;
    s := s + ' , rd.confirmAmount '#10;
    s := s + ' , rd.confirmDiscount '#10;
    s := s + ' , rd.confirmTax '#10;
    s := s + ' , rv.customer '#10;
    s := s + ' , cr.avalue AS currencyRate '#10;
    s := s + ' , (SELECT stayTaxIncluted FROM customers WHERE customer = rv.customer) AS isTaxIncluted '#10;
    s := s + ' , (IF(rd.isPercentage, rd.RoomRate*rd.Discount/100, rd.Discount)*cr.avalue) AS DiscountAmount '#10;
    s := s + ' , (IF(rd.isPercentage, rd.RoomRate*rd.Discount/100, rd.Discount)*cr.avalue)-rd.confirmDiscount AS DiscountChange '#10;

//    s := s + ' ,(IF((SELECT StayTaxPerPerson from control LIMIT 1) '#10;
//    s := s + '     ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1))*(SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation) '#10;
//    s := s + '     ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1)) '#10;
//    s := s + '   )) AS TotalStayTax '#10;

    s := s + '  , ROUND((IF(tax.TAX_BASE='+_db('GUEST_NIGHT')+' '#10;
    s := s + '      ,IF(tax.TAX_TYPE='+_db('PERCENTAGE')+', '#10;
    s := s + '            rd.roomrate*cr.AValue*(SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation)* '#10;
    s := s + '                 IF(tax.NETTO_AMOUNT_BASED='+_db('TRUE')+', tax.AMOUNT/(1+vc.VatPercentage/100), tax.AMOUNT) / 100, '#10;
    s := s + '            (SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation)*tax.AMOUNT) '#10;
    s := s + '      ,IF(tax.TAX_TYPE='+_db('PERCENTAGE')+', '#10;
    s := s + '            rd.roomrate*cr.AValue*IF(tax.NETTO_AMOUNT_BASED='+_db('TRUE')+', tax.AMOUNT/(1+vc.VatPercentage/100), tax.AMOUNT) / 100, '#10;
    s := s + '            tax.AMOUNT) '#10;
    s := s + '    ))/tax.ROUND_VALUE)*tax.ROUND_VALUE AS TotalStayTax '#10;

//    s := s + ' ,(IF((SELECT StayTaxPerPerson from control LIMIT 1) '#10;
//    s := s + '     ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1))*(SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation) '#10;
//    s := s + '     ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1)) '#10;
    s := s + '  , (ROUND((IF(tax.TAX_BASE='+_db('GUEST_NIGHT')+' '#10;
    s := s + '      ,IF(tax.TAX_TYPE='+_db('PERCENTAGE')+', '#10;
    s := s + '            rd.roomrate*cr.AValue*(SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation)* '#10;
    s := s + '                 IF(tax.NETTO_AMOUNT_BASED='+_db('TRUE')+', tax.AMOUNT/(1+vc.VatPercentage/100), tax.AMOUNT) / 100, '#10;
    s := s + '            (SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation)*tax.AMOUNT) '#10;
    s := s + '      ,IF(tax.TAX_TYPE='+_db('PERCENTAGE')+', '#10;
    s := s + '            rd.roomrate*cr.AValue*IF(tax.NETTO_AMOUNT_BASED='+_db('TRUE')+', tax.AMOUNT/(1+vc.VatPercentage/100), tax.AMOUNT) / 100, '#10;
    s := s + '            tax.AMOUNT) '#10;
    s := s + '    ))/tax.ROUND_VALUE)*tax.ROUND_VALUE)-rd.confirmTax AS TaxChange '#10;

    s := s + ' , (rd.roomrate*cr.AValue)-rd.confirmAmount AS RentChange '#10;

    s := s + ' FROM '#10;
    s := s + '   roomsdate rd '#10;
    s := s + '   INNER JOIN reservations rv ON rd.reservation = rv.reservation '#10;
    s := s + '   INNER JOIN currencies cr ON rd.currency = cr.currency, '#10;
    s := s + '   control co '#10;
    s := s + '   INNER JOIN items i ON item=co.RoomRentItem '#10;
    s := s + '   INNER JOIN itemtypes it ON it.ItemType=i.ItemType '#10;
    s := s + '   INNER JOIN vatcodes vc ON vc.VATCode=it.VatCode '#10;
    s := s + '   JOIN home100.TAXES tax ON HOTEL_ID=(Select companyID from control LIMIT 1) AND CURRENT_DATE>=VALID_FROM AND CURRENT_DATE<=VALID_TO '#10;
    s := s + ' WHERE '#10;
    s := s + ' ( confirmDate > ' + _db(sUnconfirmedDate) + ' ) ';
    s := s + ' AND ( '#10;
    s := s + '  (rd.confirmAmount-(rd.roomrate*cr.AValue) <> 0) '#10;

//    s := s + '  OR (rd.coxxxxxxxxxxxxxxxxxxxnfirmTax-(IF((SELECT StayTaxPerPerson from control LIMIT 1) '#10;
//    s := s + '     ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1))*(SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation) '#10;
//    s := s + '     ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1)) '#10;
//    s := s + '   )) <> 0 ) '#10;


    s := s + '  OR (ROUND((ROUND((IF(tax.TAX_BASE='+_db('GUEST_NIGHT')+' '#10;
    s := s + '      ,IF(tax.TAX_TYPE='+_db('PERCENTAGE')+', '#10;
    s := s + '            rd.roomrate*cr.AValue*(SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation)* '#10;
    s := s + '                 IF(tax.NETTO_AMOUNT_BASED='+_db('TRUE')+', tax.AMOUNT/(1+vc.VatPercentage/100), tax.AMOUNT) / 100, '#10;
    s := s + '            (SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation)*tax.AMOUNT) '#10;
    s := s + '      ,IF(tax.TAX_TYPE='+_db('PERCENTAGE')+', '#10;
    s := s + '            rd.roomrate*cr.AValue*IF(tax.NETTO_AMOUNT_BASED='+_db('TRUE')+', tax.AMOUNT/(1+vc.VatPercentage/100), tax.AMOUNT) / 100, '#10;
    s := s + '            tax.AMOUNT) '#10;
    s := s + '    ))/tax.ROUND_VALUE)*tax.ROUND_VALUE)-rd.confirmTax) <> 0) '#10;


    s := s + ' OR (rd.confirmDiscount-(IF(rd.isPercentage, rd.RoomRate*rd.Discount/100, rd.Discount)*cr.avalue) <> 0) '#10;

    s := s + '    ) '#10;
    s := s + '  AND (rd.paid=0)  '#10;
    s := s + ' AND (ResFlag not in ('+_db('X')+','+_db('C')+')) ;';


    // rset10,Results[9],d.kbmRoomsDateChange_
    debug_s := debug_s+#10#10'-- 9 d.kbmRoomsDateChange_. Getting confirmed uninvoiced rent change'#10+s;

//    copyToClipboard(s);
//    DebugMessage('-- 8 Getting confirmed uninvoiced rent change '#10#10+s);
    ExecutionPlan.AddQuery(s);
    s := '';
    s := s + ' SELECT '#10;
    s := s + '   rd.id AS roomsdateID'#10;
    s := s + ' , date(rd.ADate) as StayDate '#10;
    s := s + ' , rd.roomreservation '#10;
    s := s + ' , rd.reservation '#10;
    s := s + ' , rd.invoicenumber '#10;
    s := s + ' , rd.roomrate*cr.AValue AS RentAmount '#10;
    s := s + ' , rd.currency '#10;
    s := s + ' , rd.confirmdate '#10;
    s := s + ' , rd.confirmAmount '#10;
    s := s + ' , rd.confirmDiscount '#10;
    s := s + ' , rd.confirmTax '#10;
    s := s + ' , rv.customer '#10;
    s := s + ' , cr.avalue AS currencyRate '#10;
    s := s + ' , (SELECT stayTaxIncluted FROM customers WHERE customer = rv.customer) AS isTaxIncluted '#10;
    s := s + ' , (IF(rd.isPercentage, rd.RoomRate*rd.Discount/100, rd.Discount)*cr.avalue) AS DiscountAmount '#10;
    s := s + ' , (IF(rd.isPercentage, rd.RoomRate*rd.Discount/100, rd.Discount)*cr.avalue)-rd.confirmDiscount AS DiscountChange '#10;

//    s := s + ' ,(IF((SELECT StayTaxPerPerson from control LIMIT 1) '#10;
//    s := s + '     ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1))*(SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation) '#10;
//    s := s + '     ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1)) '#10;
//    s := s + '   )) AS TotalStayTax '#10;

    s := s + '  , ROUND((IF(tax.TAX_BASE='+_db('GUEST_NIGHT')+' '#10;
    s := s + '      ,IF(tax.TAX_TYPE='+_db('PERCENTAGE')+', '#10;
    s := s + '            rd.roomrate*cr.AValue*(SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation)* '#10;
    s := s + '                 IF(tax.NETTO_AMOUNT_BASED='+_db('TRUE')+', tax.AMOUNT/(1+vc.VatPercentage/100), tax.AMOUNT) / 100, '#10;
    s := s + '            (SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation)*tax.AMOUNT) '#10;
    s := s + '      ,IF(tax.TAX_TYPE='+_db('PERCENTAGE')+', '#10;
    s := s + '            rd.roomrate*cr.AValue*IF(tax.NETTO_AMOUNT_BASED='+_db('TRUE')+', tax.AMOUNT/(1+vc.VatPercentage/100), tax.AMOUNT) / 100, '#10;
    s := s + '            tax.AMOUNT) '#10;
    s := s + '    ))/tax.ROUND_VALUE)*tax.ROUND_VALUE AS TotalStayTax '#10;


//    s := s + ' ,(IF((SELECT StayTaxPerPerson from control LIMIT 1) '#10;
//    s := s + '     ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1))*(SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation) '#10;
//    s := s + '     ,(SELECT price FROM items Where item=(SELECT stayTaxItem from control LIMIT 1)) '#10;
//    s := s + '   ))-rd.confirmTax AS TaxChange '#10;

    s := s + '  , (ROUND((IF(tax.TAX_BASE='+_db('GUEST_NIGHT')+' '#10;
    s := s + '      ,IF(tax.TAX_TYPE='+_db('PERCENTAGE')+', '#10;
    s := s + '            rd.roomrate*cr.AValue*(SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation)* '#10;
    s := s + '                 IF(tax.NETTO_AMOUNT_BASED='+_db('TRUE')+', tax.AMOUNT/(1+vc.VatPercentage/100), tax.AMOUNT) / 100, '#10;
    s := s + '            (SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation)*tax.AMOUNT) '#10;
    s := s + '      ,IF(tax.TAX_TYPE='+_db('PERCENTAGE')+', '#10;
    s := s + '            rd.roomrate*cr.AValue*IF(tax.NETTO_AMOUNT_BASED='+_db('TRUE')+', tax.AMOUNT/(1+vc.VatPercentage/100), tax.AMOUNT) / 100, '#10;
    s := s + '            tax.AMOUNT) '#10;
    s := s + '    ))/tax.ROUND_VALUE)*tax.ROUND_VALUE)-rd.confirmTax AS TaxChange '#10;


    s := s + ' , (rd.roomrate*cr.AValue)-rd.confirmAmount AS RentChange '#10;

    s := s + ' FROM '#10;
//    s := s + '   roomsdate rd '#10;
//    s := s + '   LEFT OUTER JOIN reservations rv ON rd.reservation = rv.reservation '#10;
//    s := s + '   INNER JOIN currencies cr ON rd.currency = cr.currency '#10;

    s := s + '   roomsdate rd '#10;
    s := s + '   LEFT OUTER JOIN reservations rv ON rd.reservation = rv.reservation '#10;
    s := s + '   INNER JOIN currencies cr ON rd.currency = cr.currency, '#10;
    s := s + '   control co '#10;
    s := s + '   INNER JOIN items i ON item=co.RoomRentItem '#10;
    s := s + '   INNER JOIN itemtypes it ON it.ItemType=i.ItemType '#10;
    s := s + '   INNER JOIN vatcodes vc ON vc.VATCode=it.VatCode '#10;
    s := s + '   JOIN home100.TAXES tax ON HOTEL_ID=(Select companyID from control LIMIT 1) AND CURRENT_DATE>=VALID_FROM AND CURRENT_DATE<=VALID_TO '#10;
    s := s + ' WHERE '#10;
    s := s + ' ( confirmDate > ' + _db(sUnconfirmedDate) + ' )  '#10;
    s := s + ' AND ( ResFlag in ('+_db('X')+','+_db('C')+')) ';
    s := s + ' AND ((rd.confirmAmount+rd.confirmDiscount+rd.confirmTax) <> 0 )'#10;
//    s := s + ' AND ( '#10;
//    s := s + '   (rd.paid = 1) '#10;
    s := s + '  ;'#10;

    debug_s := debug_s+#10#10'-- 10 d.kbmRoomsDateChange_. Adding to roomsdateGhange'#10+s;
    ExecutionPlan.AddQuery(s);

    s := '';
    s := s + '  SELECT '#10;
    s := s + '    pm.PayType '#10;
    s := s + '   ,pm.Amount '#10;
    s := s + '   ,date(pm.payDate) AS dtPayDate '#10;
    s := s + '   ,pm.description '#10;
    s := s + '   ,pty.description AS paytypeDescription '#10;
    s := s + '   ,pgr.description AS paygroupDescripion '#10;
    s := s + '   ,pm.invoicenumber '#10;
    s := s + '   ,pm.customer '#10;
    s := s + '   ,pm.reservation '#10;
    s := s + '   ,pm.roomreservation '#10;
    s := s + '   ,(SELECT cu.surname FROM customers cu WHERE cu.customer = pm.customer) as customername '#10;
    s := s + '   ,(SELECT ih.name FROM invoiceheads ih WHERE (ih.invoicenumber = pm.invoicenumber) and (invoicenumber>0) limit 1) as NameOnInvoice '#10;
    s := s + '   ,pm.confirmdate '#10;
    s := s + '   ,IF(pm.typeindex=0,'+_db('Invoice')+','+_db('Downpayment')+') AS Medhod '#10;
//    s := s + '   ,IF(pm.typeindex=0,'Invoice','Downpayment') AS Medhod '#10;
    s := s + '  FROM payments pm '#10;
    s := s + '        INNER JOIN paytypes pty ON pm.paytype = pty.paytype '#10;
    s := s + '        INNER JOIN paygroups pgr ON pty.paygroup = pgr.paygroup '#10;
    s := s + '   WHERE '#10;
    s := s + '( confirmDate = ' + _db(sUnconfirmedDate) + ') '#10;
//    s := s + '     ( confirmDate = '2014-05-03 14:05:31') '#10;
    s := s + '    ORDER BY '#10;
    s := s + '      pm.payDate ;'#10;

    debug_s := debug_s+#10#10'-- 11 d.kbmPaymentList_. List of payments'#10+s;
    copyToClipboard(debug_s);
    ExecutionPlan.AddQuery(s);

    // //////////////////// Execute!



    d.kbmTurnover_.DisableControls;
    d.kbmPayments_.DisableControls;
    d.kbmRoomsDate_.DisableControls;
    d.kbmRoomRentOnInvoice_.DisableControls;
    d.mInvoiceHeads.DisableControls;
    d.mInvoiceLines.DisableControls;
    DReportData.kbmUnconfirmedInvoicelines_.DisableControls;
    d.kbmInvoiceLinePriceChange_.DisableControls;
    d.kbmPaymentList_.disableControls;
    try
      ExecutionPlan.Execute(ptQuery);

      /// ///////////////// Turnover

      rset1 := ExecutionPlan.Results[0];
      if d.kbmTurnover_.active then d.kbmTurnover_.Close;
      d.kbmTurnover_.open;
//    kbmTurnover_.LoadFromDataSet(rset1,[]);
      LoadKbmMemtableFromDataSetQuiet(kbmTurnover_,rset1,[]);
      d.kbmTurnover_.First;

      // //////////////////// Payments
      rset2 := ExecutionPlan.Results[1];
      if d.kbmPayments_.active then
        d.kbmPayments_.Close;
      d.kbmPayments_.open;
//    kbmPayments_.LoadFromDataSet(rset2,[]);
      LoadKbmMemtableFromDataSetQuiet(kbmPayments_,rset2,[]);
      d.kbmPayments_.First;

      rset3 := ExecutionPlan.Results[2];
      if d.kbmRoomsDate_.active then
        d.kbmRoomsDate_.Close;
      d.kbmRoomsDate_.open;
//    kbmRoomsDate_.LoadFromDataSet(rset3,[]);
      LoadKbmMemtableFromDataSetQuiet(kbmRoomsDate_,rset3,[]);
      d.kbmRoomsDate_.First;

      rset4 := ExecutionPlan.Results[3];
      if d.kbmRoomRentOnInvoice_.active then
        d.kbmRoomRentOnInvoice_.Close;
      d.kbmRoomRentOnInvoice_.open;
//    kbmRoomRentOnInvoice_.LoadFromDataSet(rset4,[]);
      LoadKbmMemtableFromDataSetQuiet(kbmRoomRentOnInvoice_,rset4,[]);
      d.kbmRoomRentOnInvoice_.First;

      rset5 := ExecutionPlan.Results[4];
      if d.mInvoiceHeads.active then
        d.mInvoiceHeads.Close;
      d.mInvoiceHeads.open;
//    mInvoiceHeads.LoadFromDataSet(rset5,[]);
      LoadKbmMemtableFromDataSetQuiet(mInvoiceHeads,rset5,[]);
      d.mInvoiceHeads.First;

      rset6 := ExecutionPlan.Results[5];
      if d.mInvoiceLines.active then
        d.mInvoiceLines.Close;
      d.mInvoiceLines.open;
//      mInvoiceLines.LoadFromDataSet(rset6,[]);
      LoadKbmMemtableFromDataSetQuiet(mInvoiceLines,rset6,[]);
      d.mInvoiceLines.First;


      rset8 := ExecutionPlan.Results[7];
      if DReportData.kbmUnconfirmedInvoicelines_.active then
        DReportData.kbmUnconfirmedInvoicelines_.Close;

      DReportData.kbmUnconfirmedInvoicelines_.open;
      LoadKbmMemtableFromDataSetQuiet(DReportData.kbmUnconfirmedInvoicelines_,rset8,[]);
      DReportData.kbmUnconfirmedInvoicelines_.First;

//      while not DReportData.kbmUnconfirmedInvoicelines_.eof do
//      begin
//
//      end;





      rset9 := ExecutionPlan.Results[8];
      if d.kbmInvoiceLinePriceChange_.active then
        d.kbmInvoiceLinePriceChange_.Close;
      d.kbmInvoiceLinePriceChange_.open;
      LoadKbmMemtableFromDataSetQuiet(kbmInvoiceLinePriceChange_,rset9,[]);
      d.kbmInvoiceLinePriceChange_.First;



      rset10 := ExecutionPlan.Results[9];
      if d.kbmRoomsDateChange_.active then
        d.kbmRoomsDateChange_.Close;
      d.kbmRoomsDateChange_.open;



      LoadKbmMemtableFromDataSetQuiet(kbmRoomsDateChange_,rset10,[]);
      d.kbmRoomsDateChange_.First;

      rset11 := ExecutionPlan.Results[10];
      rSet11.first;
      while not rSet11.eof do
      begin
          d.kbmRoomsDateChange_.Insert;
          d.kbmRoomsDateChange_.FieldByName('StayDate').asDateTime         :=   rSet11.FieldByName('StayDate').asDateTime           ;
          d.kbmRoomsDateChange_.FieldByName('roomreservation').asinteger   :=   rSet11.FieldByName('roomreservation').asinteger     ;
          d.kbmRoomsDateChange_.FieldByName('reservation').asinteger       :=   rSet11.FieldByName('reservation').asinteger         ;
          d.kbmRoomsDateChange_.FieldByName('RentAmount').AsFloat          :=   0.00;
          d.kbmRoomsDateChange_.FieldByName('currency').AsString           :=   rSet11.FieldByName('currency').AsString             ;
          d.kbmRoomsDateChange_.FieldByName('currencyRate').AsFloat        :=   rSet11.GetFloatValue(rSet11.FieldByName('currencyRate'));
          d.kbmRoomsDateChange_.FieldByName('DiscountAmount').AsFloat      :=   0.00;
          d.kbmRoomsDateChange_.FieldByName('TotalStayTax').AsFloat        :=   0.00;
          d.kbmRoomsDateChange_.FieldByName('roomsdateID').asinteger       :=   rSet11.FieldByName('roomsdateID').asinteger         ;
          d.kbmRoomsDateChange_.FieldByName('invoicenumber').asinteger     :=   rSet11.FieldByName('invoicenumber').asinteger       ;
          d.kbmRoomsDateChange_.FieldByName('discountChange').AsFloat      :=   rSet11.GetFloatValue(rSet11.FieldByName('DiscountAmount'))*-1     ;

          d.kbmRoomsDateChange_.FieldByName('taxChange').AsFloat           :=   rSet11.GetFloatValue(rSet11.FieldByName('TotalStayTax'))*-1       ;
          d.kbmRoomsDateChange_.FieldByName('isTaxIncluted').asboolean     :=   False       ;

          d.kbmRoomsDateChange_.FieldByName('rentChange').AsFloat          :=   rSet11.GetFloatValue(rSet11.FieldByName('RentAmount'))*-1         ;
          d.kbmRoomsDateChange_.post;
        rSet11.next;
      end;

      rset12 := ExecutionPlan.Results[11];
      if d.kbmPaymentList_.active then
        d.kbmPaymentList_.Close;
      d.kbmPaymentList_.open;
//      kbmPaymentList_.LoadFromDataSet(rset12,[]);
      LoadKbmMemtableFromDataSetQuiet(kbmPaymentList_,rset12, []);
      d.kbmPaymentList_.First;

    finally
      d.kbmPayments_.enableControls;
      d.kbmTurnover_.enableControls;
      d.kbmRoomsDate_.enableControls;
      d.kbmRoomRentOnInvoice_.enableControls;
      d.mInvoiceHeads.enableControls;
      d.mInvoiceLines.enableControls;
      DReportData.kbmUnconfirmedInvoicelines_.enableControls;
      d.kbmInvoiceLinePriceChange_.enableControls;
      d.kbmPaymentList_.EnableControls;
    end;

    //*2
    d.TurnoverAndPaymentsUpdateTurnover_II(zGlob);


    //*2
    d.TurnoverAndPaymentsUpdateTurnoverItemPriceChange_II(zGlob);

    zGlob.totalTurnover := 0;
    d.kbmTurnover_.First;
    while not d.kbmTurnover_.eof do
    begin
      zGlob.totalTurnover := zGlob.totalTurnover + d.kbmTurnover_.fieldbyname('amount').asfloat;
      d.kbmTurnover_.Next;
    end;
    d.kbmTurnover_.First;


    zGlob.totalPayments := 0;
    d.kbmPayments_.First;
    while not d.kbmPayments_.eof do
    begin
      zGlob.totalPayments := zGlob.totalPayments + d.kbmPayments_.fieldbyname('amount').asfloat;
      d.kbmPayments_.Next;
    end;
    d.kbmPayments_.First;

  finally
    ExecutionPlan.Free;
    screen.Cursor := crDefault;
  end;
  // pg001.ApplyBestFit;
end;


procedure Td.TurnoverAndPaymentsUpdateTurnover_II(var zGlob : recTurnoverAndPaymentsGlobals_II);
var

  rentAmount: double;
  rentVat: double;
  rentItemCount: Double;  //-96

  discountAmount: double;
  discountVat: double;
  discountItemCount: double; //-96

  cityTaxAmount: double;
  cityTaxVat: double;
  cityTaxItemCount: double; //-96

  incl_cityTaxAmount: double;
  incl_cityTaxVat: double;
  incl_cityTaxItemCount: double; //-96

  item: string;

  isKredit: boolean;

  invoicenumber : integer;

begin
  rentAmount := 0;
  rentItemCount := 0.00; //-96

  discountAmount := 0;
  discountItemCount := 0.00; //-96

  cityTaxAmount := 0;
  cityTaxItemCount := 0.00;  //-96

  incl_cityTaxAmount := 0;
  incl_cityTaxItemCount := 0.00; //-96


  d.kbmTurnover_.DisableControls;
  d.kbmPayments_.DisableControls;
  d.kbmRoomsDate_.DisableControls;
  try
    d.kbmRoomsDate_.First;
    while not d.kbmRoomsDate_.eof do
    begin
      invoicenumber := d.kbmRoomsDate_.FieldByName('invoicenumber').AsInteger;

      rentAmount := rentAmount + d.kbmRoomsDate_.FieldByName('RentAmount').AsFloat;
      if rentAmount <> 0 then rentItemCount := rentItemCount + 1;

      discountAmount := discountAmount + d.kbmRoomsDate_.FieldByName('DiscountAmount').AsFloat;
      if discountAmount <> 0 then discountItemCount := discountItemCount + 1;

      if invoicenumber > 0 then
      begin
        cityTaxAmount := cityTaxAmount + d.kbmRoomsDate_.FieldByName('TotalStayTax').AsFloat;
        if cityTaxAmount <> 0 then cityTaxItemCount := cityTaxItemCount + 1;
      end else
      begin
        incl_cityTaxAmount := incl_cityTaxAmount + d.kbmRoomsDate_.FieldByName('TotalStayTax').AsFloat;
        if incl_cityTaxAmount <> 0 then incl_cityTaxItemCount := incl_cityTaxItemCount + 1
      end;
      d.kbmRoomsDate_.Next;
    end;

    rentVat         := _calcVat(rentAmount, zGlob.RoomRentVATPercentage);
    discountVat     := _calcVat(discountAmount, zGlob.RoomRentVATPercentage);
    cityTaxVat      := _calcVat(cityTaxAmount, zGlob.cTaxVATPercentage);
    incl_cityTaxVat := _calcVat(incl_cityTaxAmount, zGlob.cTaxVATPercentage);

    if d.kbmRoomsDate_.recordcount > 0 then
    begin
      if rentAmount <> 0 then
      begin
        if d.kbmTurnover_.Locate('ItemId', zGlob.RoomRentItem, []) then
        begin
          d.kbmTurnover_.Edit;
          d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + rentAmount;
          d.kbmTurnover_.FieldByName('VAT').AsFloat :=  d.kbmTurnover_.FieldByName('Vat').AsFloat + rentVat;
          d.kbmTurnover_.FieldByName('Itemcount').AsFloat := d.kbmTurnover_.FieldByName('itemcount').AsFloat + rentItemCount; //-96
          d.kbmTurnover_.post;
        end
        else
        begin
          d.kbmTurnover_.insert;
          d.kbmTurnover_.FieldByName('ItemId').AsString := zGlob.RoomRentItem;
          d.kbmTurnover_.FieldByName('Description').AsString := zGlob.RoomRentItemDescription;
          d.kbmTurnover_.FieldByName('Amount').AsFloat := rentAmount;
          d.kbmTurnover_.FieldByName('VAT').AsFloat := rentVat;

          d.kbmTurnover_.FieldByName('Itemtype').AsString := zGlob.RoomRentType;
          d.kbmTurnover_.FieldByName('Typedescription').AsString := zGlob.RoomRentTypeDescription;
          d.kbmTurnover_.FieldByName('VATCode').AsString := zGlob.RoomRentVATCode;
          d.kbmTurnover_.FieldByName('ItemCount').asFloat := rentItemCount; //-96
          d.kbmTurnover_.FieldByName('VATPercentage').AsFloat := zGlob.RoomRentVATPercentage;
          d.kbmTurnover_.post;
        end;
      end;

      if discountAmount <> 0 then
      begin
        if d.kbmTurnover_.Locate('ItemId', zGlob.DiscountItem, []) then
        begin
          d.kbmTurnover_.Edit;
          d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + discountAmount * -1;
          d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + discountVat;
          d.kbmTurnover_.FieldByName('Itemcount').AsFloat := d.kbmTurnover_.FieldByName('itemcount').AsFloat + discountItemCount; //-96
          d.kbmTurnover_.post;
        end
        else
        begin
          d.kbmTurnover_.insert;
          d.kbmTurnover_.FieldByName('ItemId').AsString := zGlob.DiscountItem;
          d.kbmTurnover_.FieldByName('Description').AsString := zGlob.DiscountItemDescription;

          d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + discountAmount;
          d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + discountVat;

          d.kbmTurnover_.FieldByName('Itemtype').AsString := zGlob.DiscountType;
          d.kbmTurnover_.FieldByName('Typedescription').AsString := zGlob.DiscountTypeDescription;
          d.kbmTurnover_.FieldByName('VATCode').AsString := zGlob.RoomRentVATCode;
          d.kbmTurnover_.FieldByName('ItemCount').asFloat := discountItemCount; //-96
          d.kbmTurnover_.FieldByName('VATPercentage').AsFloat := zGlob.RoomRentVATPercentage;
          d.kbmTurnover_.post;
        end;
      end;

      if cityTaxAmount <> 0 then
      begin
        if d.kbmTurnover_.Locate('ItemId', zGlob.TaxesItem, []) then
        begin
          d.kbmTurnover_.Edit;
          d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + cityTaxAmount;
          d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + cityTaxVat;
          d.kbmTurnover_.FieldByName('Itemcount').AsFloat := d.kbmTurnover_.FieldByName('itemcount').AsFloat + cityTaxItemCount; //-96
          d.kbmTurnover_.post;
        end
        else
        begin
          d.kbmTurnover_.insert;
          d.kbmTurnover_.FieldByName('ItemId').AsString := zGlob.TaxesItem;
          d.kbmTurnover_.FieldByName('Description').AsString := zGlob.TaxesItemDescription;

          d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + cityTaxAmount;
          d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + cityTaxVat;

          d.kbmTurnover_.FieldByName('Itemtype').AsString := zGlob.cTaxType;
          d.kbmTurnover_.FieldByName('Typedescription').AsString := zGlob.cTaxTypeDescription;
          d.kbmTurnover_.FieldByName('VATCode').AsString := zGlob.cTaxVATCode;
          d.kbmTurnover_.FieldByName('ItemCount').asFloat := cityTaxItemCount; //-96
          d.kbmTurnover_.FieldByName('VATPercentage').AsFloat := zGlob.cTaxVATPercentage;
          d.kbmTurnover_.post;
        end;
      end;

      if incl_cityTaxAmount <> 0 then
      begin
        if d.kbmTurnover_.Locate('ItemId', '-', []) then
        begin
          d.kbmTurnover_.Edit;
          d.kbmTurnover_.FieldByName('Amount').AsFloat    :=  d.kbmTurnover_.FieldByName('Amount').AsFloat + incl_cityTaxAmount;
          d.kbmTurnover_.FieldByName('VAT').AsFloat       := d.kbmTurnover_.FieldByName('Vat').AsFloat + incl_cityTaxVat;
          d.kbmTurnover_.FieldByName('Itemcount').AsFloat := d.kbmTurnover_.FieldByName('itemcount').AsFloat + incl_cityTaxItemCount;  //-96
          d.kbmTurnover_.post;
        end else
        begin
          d.kbmTurnover_.insert;
          d.kbmTurnover_.FieldByName('ItemId').AsString := '-';
          d.kbmTurnover_.FieldByName('Description').AsString := 'uninvoiced ' + zGlob.TaxesItemDescription;

          d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + incl_cityTaxAmount;
          d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + incl_cityTaxVat;

          d.kbmTurnover_.FieldByName('Itemtype').AsString := zGlob.cTaxType;
          d.kbmTurnover_.FieldByName('Typedescription').AsString := zGlob.cTaxTypeDescription;
          d.kbmTurnover_.FieldByName('VATCode').AsString := zGlob.cTaxVATCode;
          d.kbmTurnover_.FieldByName('ItemCount').asFloat := incl_cityTaxItemCount; //-96
          d.kbmTurnover_.FieldByName('VATPercentage').AsFloat := zGlob.cTaxVATPercentage;
          d.kbmTurnover_.post;
        end;
      end;
    end;
  finally
    d.kbmPayments_.enableControls;
    d.kbmTurnover_.enableControls;
    d.kbmRoomsDate_.enableControls;
  end;

  /// ///////////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  ///

  if d.kbmRoomsDateChange_.recordcount > 0 then
  begin
    rentAmount := 0;
    rentItemCount := 0;

    discountAmount := 0;
    discountItemCount := 0;

    cityTaxAmount := 0;
    cityTaxItemCount := 0;

    incl_cityTaxAmount := 0;
    incl_cityTaxItemCount := 0;

    d.kbmTurnover_.DisableControls;
    d.kbmRoomsDateChange_.DisableControls;
    try
      d.kbmRoomsDateChange_.First;
      while not d.kbmRoomsDateChange_.eof do
      begin
        if d.kbmRoomsDateChange_.FieldByName('RentChange').AsFloat <> 0 then
        begin
          rentAmount := rentAmount + d.kbmRoomsDateChange_.FieldByName('RentChange').AsFloat;
          if rentAmount <> 0 then rentItemCount := rentItemCount + 1;
        end;

        if d.kbmRoomsDateChange_.FieldByName('DiscountChange').AsFloat <> 0 then
        begin
          discountAmount := discountAmount + d.kbmRoomsDateChange_.FieldByName('DiscountChange').AsFloat;
          if discountAmount <> 0 then discountItemCount := discountItemCount + 1;
        end;

        if d.kbmRoomsDateChange_.FieldByName('TaxChange').AsFloat <> 0 then
        begin
          if d.kbmRoomsDateChange_.FieldByName('invoicenumber').asinteger < 0 then
          begin
            incl_cityTaxAmount := incl_cityTaxAmount + d.kbmRoomsDateChange_.FieldByName('TaxChange').AsFloat;
            if incl_cityTaxAmount <> 0 then incl_cityTaxItemCount := incl_cityTaxItemCount + 1;
          end else
          begin
            cityTaxAmount := cityTaxAmount + d.kbmRoomsDateChange_.FieldByName('TaxChange').AsFloat;
            if cityTaxAmount <> 0 then cityTaxItemCount := cityTaxItemCount + 1
          end;
        end;
        d.kbmRoomsDateChange_.Next;
      end;

//      if incl_cityTaxAmount > 0 then
//      begin
//        rentAmount := rentAmount + incl_cityTaxAmount;;
//      end;
//      if incl_cityTaxAmount < 0 then
//      begin
//        rentAmount := rentAmount - incl_cityTaxAmount;;
//      end;


      rentVat         := _calcVat(rentAmount, zGlob.RoomRentVATPercentage);
      discountVat     := _calcVat(discountAmount, zGlob.RoomRentVATPercentage);
      cityTaxVat      := _calcVat(cityTaxAmount, zGlob.cTaxVATPercentage);
      incl_cityTaxVat := _calcVat(incl_cityTaxAmount, zGlob.cTaxVATPercentage);

      if d.kbmRoomsDateChange_.recordcount > 0 then
      begin
        if rentAmount <> 0 then
        begin
          if d.kbmTurnover_.Locate('ItemId', zGlob.RoomRentItem, []) then
          begin
            d.kbmTurnover_.Edit;
            d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + rentAmount;
            d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + rentVat;
            d.kbmTurnover_.FieldByName('Itemcount').AsFloat := d.kbmTurnover_.FieldByName('itemcount').AsFloat + rentItemCount; //-96
            d.kbmTurnover_.post;
          end else
          begin
            d.kbmTurnover_.insert;
            d.kbmTurnover_.FieldByName('ItemId').AsString := zGlob.RoomRentItem;
            d.kbmTurnover_.FieldByName('Description').AsString := zGlob.RoomRentItemDescription;
            d.kbmTurnover_.FieldByName('Amount').AsFloat := rentAmount;
            d.kbmTurnover_.FieldByName('VAT').AsFloat := rentVat;

            d.kbmTurnover_.FieldByName('Itemtype').AsString := zGlob.RoomRentType;
            d.kbmTurnover_.FieldByName('Typedescription').AsString := zGlob.RoomRentTypeDescription;
            d.kbmTurnover_.FieldByName('VATCode').AsString := zGlob.RoomRentVATCode;
            d.kbmTurnover_.FieldByName('ItemCount').asFloat := rentItemCount;   //-96
            d.kbmTurnover_.FieldByName('VATPercentage').AsFloat := zGlob.RoomRentVATPercentage;
            d.kbmTurnover_.post;
          end;
        end;

        if discountAmount <> 0 then
        begin
          if d.kbmTurnover_.Locate('ItemId', zGlob.DiscountItem, []) then
          begin
            d.kbmTurnover_.Edit;
            d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + discountAmount * -1;
            d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + discountVat;
            d.kbmTurnover_.FieldByName('Itemcount').AsFloat := d.kbmTurnover_.FieldByName('itemcount').AsFloat + discountItemCount; //-96
            d.kbmTurnover_.post;
          end
          else
          begin
            d.kbmTurnover_.insert;
            d.kbmTurnover_.FieldByName('ItemId').AsString := zGlob.DiscountItem;
            d.kbmTurnover_.FieldByName('Description').AsString := zGlob.DiscountItemDescription;

            d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + discountAmount;
            d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + discountVat;

            d.kbmTurnover_.FieldByName('Itemtype').AsString := zGlob.DiscountType;
            d.kbmTurnover_.FieldByName('Typedescription').AsString := zGlob.DiscountTypeDescription;
            d.kbmTurnover_.FieldByName('VATCode').AsString := zGlob.RoomRentVATCode;
            d.kbmTurnover_.FieldByName('ItemCount').asFloat := discountItemCount; //-96
            d.kbmTurnover_.FieldByName('VATPercentage').AsFloat := zGlob.RoomRentVATPercentage;
            d.kbmTurnover_.post;
          end;
        end;

        if cityTaxAmount <> 0 then
        begin
          if d.kbmTurnover_.Locate('ItemId', zGlob.TaxesItem, []) then
          begin
            d.kbmTurnover_.Edit;
            d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + cityTaxAmount;
            d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + cityTaxVat;
            d.kbmTurnover_.FieldByName('Itemcount').AsFloat := d.kbmTurnover_.FieldByName('itemcount').AsFloat + cityTaxItemCount; //-96
            d.kbmTurnover_.post;
          end
          else
          begin
            d.kbmTurnover_.insert;
            d.kbmTurnover_.FieldByName('ItemId').AsString := zGlob.TaxesItem;
            d.kbmTurnover_.FieldByName('Description').AsString := zGlob.TaxesItemDescription;

            d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + cityTaxAmount;
            d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + cityTaxVat;

            d.kbmTurnover_.FieldByName('Itemtype').AsString := zGlob.cTaxType;
            d.kbmTurnover_.FieldByName('Typedescription').AsString := zGlob.cTaxTypeDescription;
            d.kbmTurnover_.FieldByName('VATCode').AsString := zGlob.cTaxVATCode;
            d.kbmTurnover_.FieldByName('ItemCount').asFloat := cityTaxItemCount; //-96
            d.kbmTurnover_.FieldByName('VATPercentage').AsFloat := zGlob.cTaxVATPercentage;
            d.kbmTurnover_.post;
          end;
        end;

        if incl_cityTaxAmount <> 0 then
        begin
          if d.kbmTurnover_.Locate('ItemId', '-', []) then
          begin
            d.kbmTurnover_.Edit;
            d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + incl_cityTaxAmount;
            d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + incl_cityTaxVat;
            d.kbmTurnover_.FieldByName('Itemcount').AsFloat := d.kbmTurnover_.FieldByName('itemcount').AsFloat + incl_cityTaxItemCount; //-96
            d.kbmTurnover_.post;
          end
          else
          begin
            d.kbmTurnover_.insert;
            d.kbmTurnover_.FieldByName('ItemId').AsString := '-';
            d.kbmTurnover_.FieldByName('Description').AsString := 'Uninvoiced ' + zGlob.TaxesItemDescription;
            d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + incl_cityTaxAmount;
            d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + incl_cityTaxVat;

            d.kbmTurnover_.FieldByName('Itemtype').AsString := zGlob.cTaxType;
            d.kbmTurnover_.FieldByName('Typedescription').AsString := zGlob.cTaxTypeDescription;
            d.kbmTurnover_.FieldByName('VATCode').AsString := zGlob.cTaxVATCode;
            d.kbmTurnover_.FieldByName('ItemCount').asFloat := incl_cityTaxItemCount; //-96
            d.kbmTurnover_.FieldByName('VATPercentage').AsFloat := zGlob.cTaxVATPercentage;
            d.kbmTurnover_.post;
          end;
        end;
      end;
    finally
      d.kbmTurnover_.enableControls;
      d.kbmRoomsDateChange_.enableControls;
    end;
  end;

  rentAmount := 0;
  rentVat := 0;
  rentItemCount := 0;

  discountAmount := 0;
  discountVat := 0;
  discountItemCount := 0;

  cityTaxAmount := 0;
  cityTaxVat := 0;
  cityTaxItemCount := 0;


  if d.kbmRoomRentOnInvoice_.recordcount > 0 then
  begin
    d.kbmRoomRentOnInvoice_.First;
    while not d.kbmRoomRentOnInvoice_.eof do
    begin
      item := d.kbmRoomRentOnInvoice_.FieldByName('itemID').AsString;
      isKredit := d.kbmRoomRentOnInvoice_.FieldByName('splitNumber').asinteger = 1;

      if isKredit then
      begin
        if _trimLower(item) = _trimLower(zGlob.RoomRentItem) then
        begin
          rentAmount := rentAmount + d.kbmRoomRentOnInvoice_.FieldByName('Amount').AsFloat;
          rentVat := rentVat + d.kbmRoomRentOnInvoice_.FieldByName('VAT').AsFloat;;
          rentItemCount := rentItemCount + d.kbmRoomRentOnInvoice_.FieldByName('ItemCount').asFloat; //-96
        end;

        if _trimLower(item) = _trimLower(zGlob.DiscountItem) then
        begin
          discountAmount := discountAmount + d.kbmRoomRentOnInvoice_.FieldByName('Amount').AsFloat;
          discountVat := discountVat + d.kbmRoomRentOnInvoice_.FieldByName('VAT').AsFloat;;
          discountItemCount := discountItemCount + d.kbmRoomRentOnInvoice_.FieldByName('ItemCount').asFloat; //-96
        end;

        if _trimLower(item) = _trimLower(zGlob.TaxesItem) then
        begin
          cityTaxAmount := cityTaxAmount + d.kbmRoomRentOnInvoice_.FieldByName('Amount').AsFloat;
          cityTaxVat := cityTaxVat + d.kbmRoomRentOnInvoice_.FieldByName('VAT').AsFloat;
          cityTaxItemCount := cityTaxItemCount + d.kbmRoomRentOnInvoice_.FieldByName('ItemCount').asFloat; //-96
        end;

//        if d.kbmRoomRentOnInvoice_.FieldByName('isTaxIncluted').asboolean then
//        begin
//          incl_cityTaxAmount := incl_cityTaxAmount + (d.kbmRoomRentOnInvoice_.FieldByName('TotalStayTax').AsFloat);
//          incl_cityTaxItemCount := incl_cityTaxItemCount + 1;
//        end;
      end;
      d.kbmRoomRentOnInvoice_.Next;
    end;
  end;

//  rentAmount := rentAmount - incl_cityTaxAmount;
//  incl_cityTaxVat := _calcVat(incl_cityTaxAmount, zGlob.cTaxVATPercentage);

  if d.kbmRoomRentOnInvoice_.recordcount > 0 then
  begin
    if rentAmount <> 0 then
    begin
      if d.kbmTurnover_.Locate('ItemId', zGlob.RoomRentItem, []) then
      begin
        d.kbmTurnover_.Edit;
        d.kbmTurnover_.FieldByName('Amount').AsFloat :=
          d.kbmTurnover_.FieldByName('Amount').AsFloat + rentAmount;
        d.kbmTurnover_.FieldByName('VAT').AsFloat :=
          d.kbmTurnover_.FieldByName('Vat').AsFloat + rentVat;
        d.kbmTurnover_.FieldByName('Itemcount').AsFloat := d.kbmTurnover_.FieldByName('itemcount').AsFloat + rentItemCount; //-96
        d.kbmTurnover_.post;
      end
      else
      begin
        d.kbmTurnover_.insert;
        d.kbmTurnover_.FieldByName('ItemId').AsString := zGlob.RoomRentItem;
        d.kbmTurnover_.FieldByName('Description').AsString := zGlob.RoomRentItemDescription;
        d.kbmTurnover_.FieldByName('Amount').AsFloat := rentAmount;
        d.kbmTurnover_.FieldByName('VAT').AsFloat := rentVat;

        d.kbmTurnover_.FieldByName('Itemtype').AsString := zGlob.RoomRentType;
        d.kbmTurnover_.FieldByName('Typedescription').AsString := zGlob.RoomRentTypeDescription;
        d.kbmTurnover_.FieldByName('VATCode').AsString := zGlob.RoomRentVATCode;
        d.kbmTurnover_.FieldByName('ItemCount').asFloat := rentItemCount; //-96
        d.kbmTurnover_.FieldByName('VATPercentage').AsFloat := zGlob.RoomRentVATPercentage;

        d.kbmTurnover_.post;
      end;
    end;

    if discountAmount <> 0 then
    begin
      if d.kbmTurnover_.Locate('ItemId', zGlob.DiscountItem, []) then
      begin
        d.kbmTurnover_.Edit;
        d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + discountAmount * -1;
        d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + discountVat;
        d.kbmTurnover_.FieldByName('Itemcount').AsFloat := d.kbmTurnover_.FieldByName('itemcount').AsFloat + discountItemCount; //-96
        d.kbmTurnover_.post;
      end else
      begin
        d.kbmTurnover_.insert;
        d.kbmTurnover_.FieldByName('ItemId').AsString := zGlob.DiscountItem;
        d.kbmTurnover_.FieldByName('Description').AsString := zGlob.DiscountItemDescription;

        d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + discountAmount;
        d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + discountVat;

        d.kbmTurnover_.FieldByName('Itemtype').AsString := zGlob.DiscountType;
        d.kbmTurnover_.FieldByName('Typedescription').AsString := zGlob.DiscountTypeDescription;
        d.kbmTurnover_.FieldByName('VATCode').AsString := zGlob.RoomRentVATCode;
        d.kbmTurnover_.FieldByName('ItemCount').asFloat := discountItemCount; //-96
        d.kbmTurnover_.FieldByName('VATPercentage').AsFloat := zGlob.RoomRentVATPercentage;
        d.kbmTurnover_.post;
      end;
    end;

    if cityTaxAmount <> 0 then
    begin
      if d.kbmTurnover_.Locate('ItemId', zGlob.TaxesItem, []) then
      begin
        d.kbmTurnover_.Edit;
        d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + cityTaxAmount;
        d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + cityTaxVat;
        d.kbmTurnover_.FieldByName('Itemcount').AsFloat := d.kbmTurnover_.FieldByName('itemcount').AsFloat + cityTaxItemCount; //-96
        d.kbmTurnover_.post;
      end
      else
      begin
        d.kbmTurnover_.insert;
        d.kbmTurnover_.FieldByName('ItemId').AsString := zGlob.TaxesItem;
        d.kbmTurnover_.FieldByName('Description').AsString := zGlob.TaxesItemDescription;

        d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + cityTaxAmount;
        d.kbmTurnover_.FieldByName('VAT').AsFloat :=
          d.kbmTurnover_.FieldByName('Vat').AsFloat + cityTaxVat;

        d.kbmTurnover_.FieldByName('Itemtype').AsString := zGlob.cTaxType;
        d.kbmTurnover_.FieldByName('Typedescription').AsString := zGlob.cTaxTypeDescription;
        d.kbmTurnover_.FieldByName('VATCode').AsString := zGlob.cTaxVATCode;
        d.kbmTurnover_.FieldByName('ItemCount').asFloat := cityTaxItemCount; //-96
        d.kbmTurnover_.FieldByName('VATPercentage').AsFloat := zGlob.cTaxVATPercentage;
        d.kbmTurnover_.post;
      end;
    end;

  end;
end;



procedure Td.TurnoverAndPaymentsUpdateTurnoverItemPriceChange_II(var rec : recTurnoverAndPaymentsGlobals_II);
var

  Amount: double;
  VAT: double;
  ItemCount: double;

  item: string;
begin

  if d.kbmInvoiceLinePriceChange_.recordcount = 0 then exit;

  d.kbmTurnover_.DisableControls;
  d.kbmInvoiceLinePriceChange_.DisableControls;
  try
    d.kbmInvoiceLinePriceChange_.First;
    while not d.kbmInvoiceLinePriceChange_.eof do
    begin
      item      := d.kbmInvoiceLinePriceChange_.FieldByName('itemID').AsString;
      Amount    := d.kbmInvoiceLinePriceChange_.FieldByName('Pricechange').AsFloat;
      VAT       := d.kbmInvoiceLinePriceChange_.FieldByName('Vat').AsFloat;
      ItemCount := d.kbmInvoiceLinePriceChange_.FieldByName('ItemCount').asFloat; //-96

      if d.kbmTurnover_.Locate('ItemId', item, []) then
      begin
        d.kbmTurnover_.Edit;
        d.kbmTurnover_.FieldByName('Amount').AsFloat := d.kbmTurnover_.FieldByName('Amount').AsFloat + Amount;
        d.kbmTurnover_.FieldByName('VAT').AsFloat := d.kbmTurnover_.FieldByName('Vat').AsFloat + VAT;
        d.kbmTurnover_.FieldByName('Itemcount').AsFloat := d.kbmTurnover_.FieldByName('itemcount').asinteger + ItemCount; //-96
        d.kbmTurnover_.post;;
      end
      else
      begin
        d.kbmTurnover_.insert;
        d.kbmTurnover_.FieldByName('ItemId').AsString := item;
        d.kbmTurnover_.FieldByName('Amount').AsFloat := Amount;
        d.kbmTurnover_.FieldByName('VAT').AsFloat := VAT;
        d.kbmTurnover_.FieldByName('ItemCount').asFloat := ItemCount; //-96

        d.kbmTurnover_.FieldByName('Description').AsString := d.kbmInvoiceLinePriceChange_.FieldByName('Description').AsString;
        d.kbmTurnover_.FieldByName('Itemtype').AsString  := d.kbmInvoiceLinePriceChange_.FieldByName('Itemtype').AsString;
        d.kbmTurnover_.FieldByName('Typedescription').AsString := d.kbmInvoiceLinePriceChange_.FieldByName('Typedescription').AsString;
        d.kbmTurnover_.FieldByName('VATCode').AsString := d.kbmInvoiceLinePriceChange_.FieldByName('VATCode').AsString;
        d.kbmTurnover_.FieldByName('VATPercentage').AsFloat := d.kbmInvoiceLinePriceChange_.FieldByName('VATPercentage').AsFloat;
        d.kbmTurnover_.post;
      end;
      d.kbmInvoiceLinePriceChange_.Next;
    end;
  finally
    d.kbmInvoiceLinePriceChange_.enableControls;
    d.kbmTurnover_.enableControls;
  end;
end;

procedure Td.TurnoverAndPaymentsDoConfirm_II;
var
  rSet: TRoomerDataset;
  s: string;
  iCount: integer;
  ok: boolean;
  Amount: double;
  discount: double;
  Tax: double;
  id: integer;
  currencyRate: double;

  confirmDate: TdateTime;
  dataType: integer;
  item: string;
  Description: string;
  Staff: string;
  ItemType: string;
  ItemTypeDescription: string;
  itemNotes: string;
  VatCode: string;
  VATPercentage: double;
  VAT: double;
  ItemCount: double;

  StayDate: TdateTime;
  roomreservation: integer;
  reservation: integer;
  rentAmount: double;
  currency: string;
  isTaxIncluted: boolean;
  discountAmount: double;
  TotalStayTax: double;
  roomsdateID: integer;
  invoicenumber: integer;
  discountChange: double;
  taxChange: double;
  rentChange: double;
  ItemID: string;
  TypeDescription: string;
  ivlID: integer;
  PurchaseDate: TdateTime;
  confirmAmount: double;
  PriceChange: double;
  InvoiceLineID : integer;
  room : string;
  zConfirmedDate : TDateTime;

begin

  screen.Cursor := crHourglass;
  try

    zConfirmedDate := now;
    ok := true;

    d.kbmRoomsDate_.DisableControls;
    try
      d.kbmRoomsDate_.First;

      while not d.kbmRoomsDate_.eof do
      begin
        id           := d.kbmRoomsDate_.FieldByName('id').asinteger;
        Amount       := d.kbmRoomsDate_.FieldByName('RentAmount').AsFloat;
        discount     := d.kbmRoomsDate_.FieldByName('discountAmount').AsFloat;
        Tax          := d.kbmRoomsDate_.FieldByName('TotalStayTax').AsFloat;
        currencyRate := d.kbmRoomsDate_.FieldByName('currencyRate').AsFloat;

        s := '';
        s := s + ' UPDATE roomsdate ';
        s := s + ' SET ';
        s := s + '    ConfirmDate = ' + _dbDateAndTime(zConfirmedDate) + ' '#10;
        s := s + '   ,ConfirmAmount = ' + _db(Amount) + ' '#10;
        s := s + '   ,ConfirmDiscount = ' + _db(discount) + ' '#10;
        s := s + '   ,ConfirmTax = ' + _db(Tax) + ' '#10;
        s := s + '   ,ConfirmCurrencyRate = ' + _db(currencyRate) + ' '#10;
        s := s + ' WHERE ' + #10;
        s := s + '   (id = ' + _db(id) + ') ' + #10;
        if not cmd_bySQL(s) then
        begin
          ok := false;
        end;
        d.kbmRoomsDate_.Next;
      end;
    finally
      d.kbmRoomsDate_.enableControls;
    end;

    d.kbmRoomsDateChange_.DisableControls;
    try
      d.kbmRoomsDateChange_.First;

      while not d.kbmRoomsDateChange_.eof do
      begin
        id       := d.kbmRoomsDateChange_.FieldByName('RoomsdateID').asinteger;
        Amount   := d.kbmRoomsDateChange_.FieldByName('RentChange').AsFloat;
        discount := d.kbmRoomsDateChange_.FieldByName('discountChange').AsFloat;
        Tax      := d.kbmRoomsDateChange_.FieldByName('TaxChange').AsFloat;

        s := '';
        s := s + ' SELECT '#10;
        s := s + '  confirmAmount '#10;
        s := s + ' ,confirmDiscount '#10;
        s := s + ' ,confirmTax '#10;
        s := s + ' ,ResFlag '#10;
        s := s + ' FROM '#10;
        s := s + ' RoomsDate '#10;
        s := s + ' WHERE '#10;
        s := s + ' id=' + _db(id) + ' '#10;

        rSet := CreateNewDataSet;
        try
          rSet_bySQL(rSet, s);
          if not rSet.eof then
          begin
            if (rSet.FieldByName('ResFlag').asstring = STATUS_DELETED) or (rSet.FieldByName('ResFlag').asstring = STATUS_CANCELED) then
            begin
              Amount     := 0.00;
              discount   := 0.00;
              Tax        := 0.00;
            end else
            begin
              Amount     := Amount   + rSet.FieldByName('confirmAmount').AsFloat;
              discount   := discount + rSet.FieldByName('confirmDiscount').AsFloat;
              Tax        := Tax      + rSet.FieldByName('confirmTax').AsFloat;
            end;
          end;
        finally
          freeandnil(rSet);
        end;

        s := '';
        s := s + ' UPDATE roomsdate ';
        s := s + ' SET ';
        s := s + '    ConfirmAmount = ' + _db(Amount) + ' '#10;
        s := s + '   ,ConfirmDiscount = ' + _db(discount) + ' '#10;
        s := s + '   ,ConfirmTax = ' + _db(Tax) + ' '#10;
        s := s + ' WHERE ' + #10;
        s := s + '   (id = ' + _db(id) + ') ' + #10;

        if not cmd_bySQL(s) then
        begin
          ok := false;
        end;
        d.kbmRoomsDateChange_.Next;
      end;
    finally
      d.kbmRoomsDateChange_.enableControls;
    end;

    DReportData.kbmUnconfirmedInvoicelines_.DisableControls;
    try
      DReportData.kbmUnconfirmedInvoicelines_.First;
      while not DReportData.kbmUnconfirmedInvoicelines_.eof do
      begin
        id := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('id').asinteger;
        Amount := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('Amount').asFloat;
// nfirmAmount := d.kbmInvoiceLinePriceChange_.FieldByName('confirmAmount').AsFloat;
        s := '';
        s := s + ' UPDATE invoicelines ';
        s := s + ' SET ';
        s := s + '    ConfirmDate = ' + _dbDateAndTime(zConfirmedDate) + ' '#10;
        s := s + '   ,ConfirmAmount = ' + _db(Amount) + ' '#10;
        s := s + ' WHERE ' + #10;
        s := s + '   (id = ' + _db(id) + ') ' + #10;
        if not cmd_bySQL(s) then
        begin
          ok := false;
        end;
        DReportData.kbmUnconfirmedInvoicelines_.Next;
      end;
    finally
      DReportData.kbmUnconfirmedInvoicelines_.enableControls;
    end;

    d.kbmInvoiceLinePriceChange_.DisableControls;
    try
      d.kbmInvoiceLinePriceChange_.First;
      while not d.kbmInvoiceLinePriceChange_.eof do
      begin
        id := d.kbmInvoiceLinePriceChange_.FieldByName('ivlid').asinteger;
        Amount := d.kbmInvoiceLinePriceChange_.FieldByName('Amount').asFloat;

        s := '';
        s := s + ' UPDATE invoicelines ';
        s := s + ' SET ';
        // s := s + '    ConfirmDate = '+_dbDateAndTime(confirmdate)+' '#10;
        s := s + '   ConfirmAmount = ' + _db(Amount) + ' '#10;
        s := s + ' WHERE ' + #10;
        s := s + '   (id = ' + _db(id) + ') ' + #10;
        if not cmd_bySQL(s) then
        begin
          ok := false;
        end;
        d.kbmInvoiceLinePriceChange_.Next;
      end;
    finally
      d.kbmInvoiceLinePriceChange_.enableControls;
    end;

    s := '';
    s := s + ' UPDATE payments ';
    s := s + ' SET ';
    s := s + '   ConfirmDate = ' + _dbDateAndTime(zConfirmedDate) + ' '#10;
    s := s + ' WHERE ' + #10;
    s := s + '   (confirmdate = ' + _db('1900-01-01 00:00:00') + ') ' + #10;
    if not cmd_bySQL(s) then
    begin
      ok := false;
    end;

    s := '';
    s := s + ' UPDATE invoiceheads ';
    s := s + ' SET ';
    s := s + '   ihConfirmDate = ' + _dbDateAndTime(zConfirmedDate) + ' '#10;
    s := s + ' WHERE ' + #10;
    s := s + '   (ihconfirmdate = ' + _db('1900-01-01 00:00:00') +
      ') AND (invoicenumber>0) ' + #10;
    if not cmd_bySQL(s) then
    begin
      ok := false;
    end;

    s := '';
    s := s + ' UPDATE invoicelines ';
    s := s + ' SET ';
    s := s + '   ConfirmDate = ' + _dbDateAndTime(zConfirmedDate) + ' '#10;
    s := s + ' WHERE ' + #10;
    s := s + '   (confirmdate = ' + _db('1900-01-01 00:00:00') +
      ') AND (invoicenumber>0) ' + #10;
    if not cmd_bySQL(s) then
    begin
      ok := false;
    end;

    d.kbmTurnover_.First;
    while not d.kbmTurnover_.eof do
    begin
      dataType := 1;
      confirmDate := zConfirmedDate;
      item := d.kbmTurnover_.FieldByName('itemID').AsString;
      Description := d.kbmTurnover_.FieldByName('Description').AsString;
      Staff := g.qusername;
      ItemType := d.kbmTurnover_.FieldByName('itemType').AsString;
      ItemTypeDescription := d.kbmTurnover_.FieldByName('TypeDescription').AsString;

      VatCode := d.kbmTurnover_.FieldByName('VATcode').AsString;
      VATPercentage := d.kbmTurnover_.FieldByName('VATPercentage').AsFloat;
      VAT := d.kbmTurnover_.FieldByName('VAT').AsFloat;
      ItemCount := d.kbmTurnover_.FieldByName('itemCount').asFloat; //-96
      Amount := d.kbmTurnover_.FieldByName('Amount').AsFloat;

      s := '';
      s := s + ' INSERT INTO turnoverandpayments '#10;
      s := s + ' ('#10;
      s := s + '  confirmDate '#10;
      s := s + ' ,Item '#10;
      s := s + ' ,Description '#10;
      s := s + ' ,Amount '#10;
      s := s + ' ,Staff '#10;
      s := s + ' ,ItemType '#10;
      s := s + ' ,ItemTypeDescription '#10;
      s := s + ' ,dataType '#10;
      s := s + ' ,VatCode '#10;
      s := s + ' ,VATPercentage '#10;
      s := s + ' ,VAT '#10;
      s := s + ' ,Itemcount) '#10;
      s := s + '  VALUES '#10;
      s := s + ' ( '#10;
      s := s + ' ' + _dbDateAndTime(confirmDate) + ' '#10;
      s := s + ' ,' + _db(item) + ' '#10;
      s := s + ' ,' + _db(Description) + ' '#10;
      s := s + ' ,' + _db(Amount) + ' '#10;
      s := s + ' ,' + _db(Staff) + ' '#10;
      s := s + ' ,' + _db(ItemType) + ' '#10;
      s := s + ' ,' + _db(ItemTypeDescription) + ' '#10;
      s := s + ' ,' + _db(dataType) + ' '#10;
      s := s + ' ,' + _db(VatCode) + ' '#10;
      s := s + ' ,' + _db(VATPercentage) + ' '#10;
      s := s + ' ,' + _db(VAT) + ' '#10;
      s := s + ' ,' + _db(ItemCount) + ' '#10;
      s := s + ' ) '#10;

      if not cmd_bySQL(s) then
      begin
        ok := false;
      end;
      d.kbmTurnover_.Next;
    end;

    d.kbmPayments_.First;
    while not d.kbmPayments_.eof do
    begin
      dataType := 2;
      confirmDate := zConfirmedDate;
      item := d.kbmPayments_.FieldByName('payType').AsString;
      Description := d.kbmPayments_.FieldByName('paytypeDescription').AsString;
      Staff := g.qusername;
      ItemType := '-';
      ItemTypeDescription := d.kbmPayments_.FieldByName
        ('paygroupDescripion').AsString;

      VatCode := '';
      VATPercentage := 0;
      VAT := 0;
      ItemCount := d.kbmPayments_.FieldByName('PaymentCount').asFloat; //-96
      Amount := d.kbmPayments_.FieldByName('Amount').AsFloat;

      s := '';
      s := s + ' INSERT INTO turnoverandpayments '#10;
      s := s + ' ('#10;
      s := s + '  confirmDate '#10;
      s := s + ' ,Item '#10;
      s := s + ' ,Description '#10;
      s := s + ' ,Amount '#10;
      s := s + ' ,Staff '#10;
      s := s + ' ,ItemType '#10;
      s := s + ' ,ItemTypeDescription '#10;
      s := s + ' ,dataType '#10;
      s := s + ' ,VatCode '#10;
      s := s + ' ,VATPercentage '#10;
      s := s + ' ,VAT '#10;
      s := s + ' ,Itemcount) '#10;
      s := s + '  VALUES '#10;
      s := s + ' ( '#10;
      s := s + ' ' + _dbDateAndTime(confirmDate) + ' '#10;
      s := s + ' ,' + _db(item) + ' '#10;
      s := s + ' ,' + _db(Description) + ' '#10;
      s := s + ' ,' + _db(Amount) + ' '#10;
      s := s + ' ,' + _db(Staff) + ' '#10;
      s := s + ' ,' + _db(ItemType) + ' '#10;
      s := s + ' ,' + _db(ItemTypeDescription) + ' '#10;
      s := s + ' ,' + _db(dataType) + ' '#10;
      s := s + ' ,' + _db(VatCode) + ' '#10;
      s := s + ' ,' + _db(VATPercentage) + ' '#10;
      s := s + ' ,' + _db(VAT) + ' '#10;
      s := s + ' ,' + _db(ItemCount) + ' '#10;
      s := s + ' ) '#10;

      if not cmd_bySQL(s) then
      begin
        ok := false;
      end;
      d.kbmPayments_.Next;
    end;

    d.kbmInvoiceLinePriceChange_.First;
    while not d.kbmInvoiceLinePriceChange_.eof do
    begin
      ItemID          := d.kbmInvoiceLinePriceChange_.FieldByName('ItemID').AsString;
      Description     := d.kbmInvoiceLinePriceChange_.FieldByName('Description').AsString;
      ItemType        := d.kbmInvoiceLinePriceChange_.FieldByName('Itemtype').AsString;
      TypeDescription := d.kbmInvoiceLinePriceChange_.FieldByName('TypeDescription').AsString;
      VatCode         := d.kbmInvoiceLinePriceChange_.FieldByName('VATCode').AsString;
      VATPercentage   := d.kbmInvoiceLinePriceChange_.FieldByName('VATPercentage').AsFloat;
      Amount          := d.kbmInvoiceLinePriceChange_.FieldByName('Amount').AsFloat;
      VAT := d.kbmInvoiceLinePriceChange_.FieldByName('VAT').AsFloat;
      ItemCount := d.kbmInvoiceLinePriceChange_.FieldByName('Itemcount').asFloat; //-96
      ivlID := d.kbmInvoiceLinePriceChange_.FieldByName('ivlID').asinteger;
      PurchaseDate := d.kbmInvoiceLinePriceChange_.FieldByName('PurchaseDate').asDateTime;
      reservation := d.kbmInvoiceLinePriceChange_.FieldByName('reservation').asinteger;
      roomreservation := d.kbmInvoiceLinePriceChange_.FieldByName('roomReservation').asinteger;
      confirmAmount := d.kbmInvoiceLinePriceChange_.FieldByName('confirmAmount').AsFloat;
      PriceChange := d.kbmInvoiceLinePriceChange_.FieldByName('PriceChange').AsFloat;

      // ItemID
      // Description
      // Itemtype
      // TypeDescription
      // VATCode
      // VATPercentage
      // Amount
      // VAT
      // Itemcount
      // ivlID
      // PurchaseDate
      // reservation
      // roomReservation
      // confirmAmount
      // PriceChange
      // Confirmdate

      s := '';
      s := s + ' INSERT INTO invoicelinepricechange '#10;
      s := s + ' ('#10;
      s := s + '   ItemID '#10;
      s := s + ' ,Description '#10;
      s := s + ' ,Itemtype '#10;
      s := s + ' ,TypeDescription '#10;
      s := s + ' ,VATCode '#10;
      s := s + ' ,VATPercentage '#10;
      s := s + ' ,Amount '#10;
      s := s + ' ,VAT '#10;
      s := s + ' ,Itemcount '#10;
      s := s + ' ,ivlID '#10;
      s := s + ' ,PurchaseDate '#10;
      s := s + ' ,reservation '#10;
      s := s + ' ,roomReservation '#10;
      s := s + ' ,confirmAmount '#10;
      s := s + ' ,PriceChange '#10;
      s := s + ' ,Confirmdate '#10;
      s := s + ' ) '#10;
      s := s + '  VALUES '#10;
      s := s + ' ( '#10;
      s := s + '  ' + _db(ItemID) + ' '#10;
      s := s + ' ,' + _db(Description) + ' '#10;
      s := s + ' ,' + _db(ItemType) + ' '#10;
      s := s + ' ,' + _db(TypeDescription) + ' '#10;
      s := s + ' ,' + _db(VatCode) + ' '#10;
      s := s + ' ,' + _db(VATPercentage) + ' '#10;
      s := s + ' ,' + _db(Amount) + ' '#10;
      s := s + ' ,' + _db(VAT) + ' '#10;
      s := s + ' ,' + _db(ItemCount) + ' '#10;
      s := s + ' ,' + _db(ivlID) + ' '#10;
      s := s + ' ,' + _db(PurchaseDate) + ' '#10;
      s := s + ' ,' + _db(reservation) + ' '#10;
      s := s + ' ,' + _db(roomreservation) + ' '#10;
      s := s + ' ,' + _db(confirmAmount) + ' '#10;
      s := s + ' ,' + _db(PriceChange) + ' '#10;
      s := s + ' ,' + _dbDateAndTime(zConfirmedDate) + ' '#10;
      s := s + ' ) '#10;

      if not cmd_bySQL(s) then
      begin
        ok := false;
      end;
      d.kbmInvoiceLinePriceChange_.Next;
    end;

    d.kbmRoomsDateChange_.First;
    while not d.kbmRoomsDateChange_.eof do
    begin
      StayDate        := d.kbmRoomsDateChange_.FieldByName('StayDate').asDateTime;
      roomreservation := d.kbmRoomsDateChange_.FieldByName('roomreservation').asinteger;
      reservation     := d.kbmRoomsDateChange_.FieldByName('reservation').asinteger;
      rentAmount      := d.kbmRoomsDateChange_.FieldByName('RentAmount').AsFloat;
      currency        := d.kbmRoomsDateChange_.FieldByName('currency').AsString;
      currencyRate    := d.kbmRoomsDateChange_.FieldByName('currencyRate').AsFloat;
      isTaxIncluted   := d.kbmRoomsDateChange_.FieldByName('isTaxIncluted').asboolean;
      discountAmount  := d.kbmRoomsDateChange_.FieldByName('DiscountAmount').AsFloat;
      TotalStayTax    := d.kbmRoomsDateChange_.FieldByName('TotalStayTax').AsFloat;
      roomsdateID     := d.kbmRoomsDateChange_.FieldByName('roomsdateID').asinteger;
      invoicenumber   := d.kbmRoomsDateChange_.FieldByName('invoicenumber').asinteger;
      discountChange  := d.kbmRoomsDateChange_.FieldByName('discountChange').AsFloat;
      taxChange       := d.kbmRoomsDateChange_.FieldByName('taxChange').AsFloat;
      rentChange      := d.kbmRoomsDateChange_.FieldByName('rentChange').AsFloat;
      s := '';
      s := s + ' INSERT INTO roomsdatechange '#10;
      s := s + ' ('#10;
      s := s + '  StayDate '#10;
      s := s + ' ,roomreservation '#10;
      s := s + ' ,reservation '#10;
      s := s + ' ,RentAmount '#10;
      s := s + ' ,currency '#10;
      s := s + ' ,currencyRate '#10;
      s := s + ' ,isTaxIncluted '#10;
      s := s + ' ,DiscountAmount '#10;
      s := s + ' ,TotalStayTax '#10;
      s := s + ' ,roomsdateID '#10;
      s := s + ' ,invoicenumber '#10;
      s := s + ' ,discountChange '#10;
      s := s + ' ,taxChange '#10;
      s := s + ' ,rentChange '#10;
      s := s + ' ,Confirmdate '#10;
      s := s + ' ) '#10;
      s := s + '  VALUES '#10;
      s := s + ' ( '#10;
      s := s + '  ' + _db(StayDate) + ' '#10;
      s := s + ' ,' + _db(roomreservation) + ' '#10;
      s := s + ' ,' + _db(reservation) + ' '#10;
      s := s + ' ,' + _db(rentAmount) + ' '#10;
      s := s + ' ,' + _db(currency) + ' '#10;
      s := s + ' ,' + _db(currencyRate) + ' '#10;
      s := s + ' ,' + _db(isTaxIncluted) + ' '#10;
      s := s + ' ,' + _db(discountAmount) + ' '#10;
      s := s + ' ,' + _db(TotalStayTax) + ' '#10;
      s := s + ' ,' + _db(roomsdateID) + ' '#10;
      s := s + ' ,' + _db(invoicenumber) + ' '#10;
      s := s + ' ,' + _db(discountChange) + ' '#10;
      s := s + ' ,' + _db(taxChange) + ' '#10;
      s := s + ' ,' + _db(rentChange) + ' '#10;
      s := s + ' ,' + _dbDateAndTime(zConfirmedDate) + ' '#10;
      s := s + ' ) '#10;
      if not cmd_bySQL(s) then
      begin
        ok := false;
      end;
      d.kbmRoomsDateChange_.Next;
    end;


    DReportData.kbmUnconfirmedInvoicelines_.First;
    while not DReportData.kbmUnconfirmedInvoicelines_.eof do
    begin
      ItemID          := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('ItemId').asString;
      Description     := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('Description').asString;
      ItemType        := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('ItemType').asString;
      VATCode         := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('VATCode').AsString;
      VATPercentage   := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('VATPercentage').AsFloat;
      Amount          := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('Amount').AsFloat;
      VAT             := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('VAT').asFloat;
      Itemcount       := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('Itemcount').AsFloat;
      InvoicelineID   := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('ID').asinteger;
      PurchaseDate    := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('PurchaseDate').asDateTime;
      reservation     := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('reservation').AsInteger;
      roomReservation := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('roomReservation').AsInteger;
      confirmAmount   := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('confirmAmount').AsFloat;
      Room            := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('Room').AsString;
      Invoicenumber   := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('InvoiceNumber').AsInteger;



      s := '';
      s := s + ' INSERT INTO unconfirmed_invoicelines '#10;
      s := s + ' ('#10;
      s := s + '  ItemId '#10;
      s := s + ' ,Description '#10;
      s := s + ' ,TypeDescription '#10;
      s := s + ' ,ItemType '#10;
      s := s + ' ,VATCode '#10;
      s := s + ' ,VATPercentage '#10;
      s := s + ' ,Amount '#10;
      s := s + ' ,VAT '#10;
      s := s + ' ,Itemcount '#10;
      s := s + ' ,InvoicelineID '#10;
      s := s + ' ,PurchaseDate '#10;
      s := s + ' ,reservation '#10;
      s := s + ' ,roomReservation '#10;
      s := s + ' ,confirmAmount '#10;
      s := s + ' ,Room '#10;
      s := s + ' ,InvoiceNumber '#10;
      s := s + ' ,ConfirmedDate '#10;
      s := s + ' ) '#10;
      s := s + '  VALUES '#10;
      s := s + ' ( '#10;
      s := s + '  ' + _db(ItemId) + ' '#10;
      s := s + ' ,' + _db(Description) + ' '#10;
      s := s + ' ,' + _db(TypeDescription) + ' '#10;
      s := s + ' ,' + _db(ItemType) + ' '#10;
      s := s + ' ,' + _db(VATCode) + ' '#10;
      s := s + ' ,' + _db(VATPercentage) + ' '#10;
      s := s + ' ,' + _db(Amount) + ' '#10;
      s := s + ' ,' + _db(VAT) + ' '#10;
      s := s + ' ,' + _db(Itemcount) + ' '#10;
      s := s + ' ,' + _db(InvoicelineID) + ' '#10;
      s := s + ' ,' + _db(PurchaseDate) + ' '#10;
      s := s + ' ,' + _db(reservation) + ' '#10;
      s := s + ' ,' + _db(roomReservation) + ' '#10;
      s := s + ' ,' + _db(confirmAmount) + ' '#10;
      s := s + ' ,' + _db(Room) + ' '#10;
      s := s + ' ,' + _db(InvoiceNumber) + ' '#10;
      s := s + ' ,' + _dbDateAndTime(zConfirmedDate) + ' '#10;
      s := s + ' ) '#10;
copytoclipboard(s);
      if not cmd_bySQL(s) then
      begin
        ok := false;
      end;
      DReportData.kbmUnconfirmedInvoicelines_.Next;
    end;

    if ok then
    begin
      g.qLastConfirm := zConfirmedDate;
//      zIsConfirmed := true;
//      zConfirmState := 2;
//      btnConfirm.visible := false;
//      btnGetOld.visible := true;
//      chkGetUnconfirmed.checked := false;
    end;
  finally
    screen.Cursor := crDefault;
  end;
end;


procedure td.insertActivityLogFromMemTable;
var
  s : string;
  iReservation , iroomreservation : integer;
  iSplitnumber : integer;
  Item : string;
  Total : double;
  lineNumber : integer;
  Autogen : string;
  bSystemline : boolean;
  i: Integer;

//  TInvoiceAction = (ADD_LINE, DELETE_LINE, CHANGE_ITEM, ADD_PAYMENT, DELETE_PAYMENT, CHANGE_PAYMENT, PRINT_PROFORMA, PAY_AND_PRINT);
 lstActivity : Tstringlist;


begin
  if (d.mInvoicelines_before.RecordCount = 0) and (d.mInvoicelines_after.RecordCount = 0) then exit;

  lstActivity := TStringlist.create;
  try
    d.mInvoicelines_before.First;
    while not d.mInvoicelines_before.eof do
    begin
      AutoGen          := d.mInvoicelines_before.FieldByName('Autogen').asString;
      bSystemLine      := d.mInvoicelines_before.FieldByName('isSystemline').asBoolean;

      iReservation     := d.mInvoicelines_before.FieldByName('reservation').asInteger;
      iRoomreservation := d.mInvoicelines_before.FieldByName('roomreservation').asInteger;
      iSplitnumber     := d.mInvoicelines_before.FieldByName('Splitnumber').asInteger;
      item             := d.mInvoicelines_before.FieldByName('itemID').asString;
      Total            := d.mInvoicelines_before.FieldByName('Total').asFloat;
      lineNumber       := d.mInvoicelines_before.FieldByName('itemNumber').asInteger;

      if bsystemline=false then
      begin
         if d.mInvoicelines_after.Locate('AutoGen',autogen,[]) then
         begin
           // not room item
           if d.mInvoicelines_before.FieldByName('Total').AsFloat <> d.mInvoicelines_after.FieldByName('Total').AsFloat  then
           begin
             s := CreateInvoiceActivityLog(g.quser
                                     ,iReservation
                                     ,iRoomReservation
                                     ,iSplitNumber
                                     ,CHANGE_ITEM
                                     ,item
                                     ,Total
                                     ,LineNumber
                                    ,'TotalPrice change');


             if s <> '' then
                LstActivity.Add(s);
             s := '';

           end;

         end else
         begin
           s := CreateInvoiceActivityLog(g.quser
                                     ,iReservation
                                     ,iRoomReservation
                                     ,iSplitNumber
                                     ,DELETE_LINE
                                     ,item
                                     ,Total
                                     ,LineNumber
                                    ,'Line deleted');
           if s <> '' then
              LstActivity.Add(s);
           s := '';
         end;
      end else
      begin
        if d.mInvoicelines_after.Locate('Reservation;roomreservation',varArrayOf([ireservation,iroomreservation]),[]) then
        begin
          if d.mInvoicelines_before.FieldByName('Total').AsFloat <> d.mInvoicelines_after.FieldByName('Total').AsFloat  then
          begin

            CreateInvoiceActivityLog(g.quser
                                     ,iReservation
                                     ,iRoomReservation
                                     ,iSplitNumber
                                     ,CHANGE_ITEM
                                     ,item
                                     ,Total
                                     ,LineNumber
                                    ,'System TotalPrice change');
             if s <> '' then
                LstActivity.Add(s);
             s := '';
          end;
        end else
        begin
          CreateInvoiceActivityLog(g.quser
                               ,iReservation
                               ,iRoomReservation
                               ,iSplitNumber
                               ,DELETE_LINE
                               ,item
                               ,Total
                               ,LineNumber
                              ,'System Line deleted');
           if s <> '' then
              LstActivity.Add(s);
           s := '';
        end;
      end;

      d.mInvoicelines_before.Next;
    end;



    d.mInvoicelines_after.First;
    while not d.mInvoicelines_after.eof do
    begin
      AutoGen          := d.mInvoicelines_after.FieldByName('Autogen').asString;
      bSystemLine      := d.mInvoicelines_after.FieldByName('isSystemline').asBoolean;

      iReservation     := d.mInvoicelines_after.FieldByName('reservation').asInteger;
      iRoomreservation := d.mInvoicelines_after.FieldByName('roomreservation').asInteger;
      iSplitnumber     := d.mInvoicelines_after.FieldByName('Splitnumber').asInteger;
      item             := d.mInvoicelines_after.FieldByName('itemID').asString;
      Total            := d.mInvoicelines_after.FieldByName('Total').asFloat;
      lineNumber       := d.mInvoicelines_after.FieldByName('itemNumber').asInteger;


      if bsystemline=false then
      begin
         if not d.mInvoicelines_before.Locate('AutoGen',autogen,[]) then
         begin
           // not room item
           s :=  CreateInvoiceActivityLog(g.quser
                                   ,iReservation
                                   ,iRoomReservation
                                   ,iSplitNumber
                                   ,ADD_LINE
                                  ,item
                                  ,Total
                                  ,LineNumber
                                  ,'Item added ');
           if s <> '' then
              LstActivity.Add(s);
           s := '';

         end;
      end else
      begin
        // RoomItem/Taxitem/roomDiscount
      end;
      d.mInvoicelines_after.Next;
    end;

    for i := 0 to LstActivity.Count-1 do
    begin
      try
        if LstActivity[i] <> '' then
          WriteInvoiceActivityLog(LstActivity[i]);
      Except
      end;
    end;
  finally
    freeandNil(lstActivity);
    if d.mInvoicelines_before.active then d.mInvoicelines_before.close;
    if d.mInvoicelines_after.active then d.mInvoicelines_after.close;
  end;
end;



{ TRoomPackageLineEntry }

procedure td.AddOrCreateToPackage(pckTotalsList : TRoomPackageLineEntryList;
                                  Code : String;
                                  _description : string;
                                  RoomReservation : Integer;
                                  _Amount,
                                  _AmountWoVat,
                                  _VatAmount: Double;
                                  _isRoom : boolean;
                                  _packageCode : string;
                                  _packageDescription : string;
                                  _lineNo : integer ;
                                  _adate : Tdate;
                                  _count : double
                                  );
   var
  i: Integer;
  tempEntry : TRoomPackageLineEntry;
begin
  tempEntry := nil;
  for i := 0 to pckTotalsList.Count - 1 do
  begin
    if (pckTotalsList[i].RoomReservation = RoomReservation) then
    begin
      tempEntry := pckTotalsList[i];
      Break;
    end;
  end;

  if NOT Assigned(tempEntry) then
  begin
    tempEntry := TRoomPackageLineEntry.Create(code,
                                              _description,
                                              _Amount,
                                              _AmountWoVat,
                                              _VatAmount,
                                              RoomReservation,
                                              _isRoom,
                                              _packageCode,
                                              _packageDescription,
                                              _LineNo,
                                              _adate,
                                              _count

                                              );
    pckTotalsList.Add(tempEntry);
  end else
    tempEntry.add(_Amount, _AmountWoVat, _VatAmount,code,_description,_count,_aDate,_LineNo);
end;

procedure TRoomPackageLineEntry.Add(_Amount, _AmountWoVat, _VatAmount: Double; _Code,_Description : string; _count : double; _aDate : Tdate;_LineNo : integer);
begin
  FAmount := FAmount + _Amount;
  FAmountWoVat := FAmountWoVat + _AmountWoVat;
  FVatAmount := FVatAmount + _VatAmount;
  FCode := _code;
  if FCode = g.qRoomRentItem then
  begin
    FItemCount := _Count;
    FLineNo := _LineNo ;
    FaDate := _aDate ;
    FDescription := _Description;
  end;
end;

constructor TRoomPackageLineEntry.Create(
                           _code : String;
                           _Description : string;
                           _Amount, _AmountWoVat,
                           _VatAmount: Double;
                           _RoomReservation: Integer;
                           _isRoom : boolean;
                           _packageCode : string;
                           _packageDescription : string;
                           _LineNo : integer;
                           _aDate : Tdate;
                           _Count : double
                           );
begin
  FCode := _code;
  if FCode = g.qRoomRentItem then
  begin
    FItemCount := _Count;
    FLineNo := _LineNo ;
    FaDate := _aDate ;
    FDescription := _Description;
  end;
  FAmount := _Amount;
  FAmountWoVat := _AmountWoVat;
  FVatAmount := _VatAmount;
  FRoomReservation := _RoomReservation;
  FIsRoom := _isRoom;
  FPackageCode := _packageCode;
  FPackageDescription := _packageDescription;
end;

function getRowHeightFromIndex(index : Integer) : Integer;
begin
  //
  case index of
    0 : result := g.qPeriodRowHeight;
    1 : result := 49;
    2 : result := 75;
  else
    Result := 0;
  end;
end;




initialization
   PROFORMA_INVOICE_NUMBER := GenerateProformaInvoiceNumber;
end.

//RSet.SystemChangeAvailability('DBL', '2013-09-12', '2013-09-12', True); //Lækkar
//RSet.SystemChangeAvailability('DBL', '2013-09-12', '2013-09-12', False); //Hækkar
//
//Td ef bókun sem er DBL frá 2013-09-12 til 2013-09-20  er breytt í SGL:
//d.roomerMainDataSet.RSet.SystemChangeAvailability('DBL', '2013-09-12', '2013-09-19', false);
//d.roomerMainDataSet.RSet.SystemChangeAvailability('SGL', '2013-09-12', '2013-09-19', true);
