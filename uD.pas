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
    , uReservationStateDefinitions
    , cmpRoomerDataSet
    , cmpRoomerConnection
    , cxEditRepositoryItems, ALHttpClient, ALWininetHttpClient
    ;

type

  // Todo: Redefine TKeyValuePairList as a dictionary where TKeyAndValue is a simple TPair<string, string>
  TKeyAndValue = class
  private
    FKey: String;
    FValue: String;
  public
    constructor Create(Key: String; Value: String);
    property Key: String read FKey write FKey;
    property Value: String read FValue write FValue;
  end;

  TKeyPairType = (FKP_CUSTOMERS, FKP_PRODUCTS, FKP_PAYTYPES);
  TKeyPairList = TObjectList<TKeyAndValue>;

  TRoomPackageLineEntry = class
  private
    FRoomReservation: Integer;
    FAmount: Double;
    FVatAmount: Double;
    FAmountWoVat: Double;
    FCode: String; // ItemCode
    FDescription: string;
    FIsRoom: boolean;
    FpackageCode: string;
    FPackageDescription: string;
    FLineNo: Integer;
    FaDate: Tdate;
    FItemCount: Double;
  public
    constructor Create(
      _Code: String;
      _Description: string;
      _Amount, _AmountWoVat,
      _VatAmount: Double;
      _RoomReservation: Integer;
      _isRoom: boolean;
      _packageCode: string;
      _packageDescription: string;
      _lineNo: Integer;
      _adate: Tdate;
      _count: Double
      );
    procedure Add(_Amount, _AmountWoVat, _VatAmount: Double; _Code, _Description: string; _count: Double; _adate: Tdate;
      _lineNo: Integer);

    property packageCode: String read FpackageCode write FpackageCode;
    property packageDescription: String read FPackageDescription write FPackageDescription;
    property Code: String read FCode write FCode;
    property Description: String read FDescription write FDescription;
    property Amount: Double read FAmount write FAmount;
    property AmountWoVat: Double read FAmountWoVat write FAmountWoVat;
    property VatAmount: Double read FVatAmount write FVatAmount;
    property RoomReservation: Integer read FRoomReservation write FRoomReservation;
    property isroom: boolean read FIsRoom write FIsRoom;
    property LineNo: Integer read FLineNo write FLineNo;
    property aDate: Tdate read FaDate write FaDate;
    property ItemCount: Double read FItemCount write FItemCount;

  end;

  TRoomPackageLineEntryList = TObjectList<TRoomPackageLineEntry>;

  Td = class(TDataModule)
    ItemsDS: TDataSource;
    viewRoomPrices1DS: TDataSource;
    rpt: TfrxReport;
    rptDesign: TfrxDesigner;
    frxPDFExport1: TfrxPDFExport;
    frxHTMLExport1: TfrxHTMLExport;
    frxRTFExport1: TfrxRTFExport;
    frxJPEGExport1: TfrxJPEGExport;
    MaidActionsDS: TDataSource;
    mCompanyInfo_: TkbmMemTable;
    mtPayments_: TkbmMemTable;
    mtHead_: TkbmMemTable;
    mtVAT_: TkbmMemTable;
    mtLines_: TkbmMemTable;
    mtCompany_: TkbmMemTable;
    mtCaptions_: TkbmMemTable;
    mRoomTypeCountDS: TDataSource;
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
    Items_: TRoomerDataSet;
    wRooms_: TRoomerDataSet;
    viewRoomPrices1_: TRoomerDataSet;
    swSystem_People_Places_Things_: TRoomerDataSet;
    swARCustomers_: TRoomerDataSet;
    swItems_: TRoomerDataSet;
    MaidActions_: TRoomerDataSet;
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
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure RoomTypes_NewRecord(DataSet: TDataSet);
    procedure DayNotes_BeforePost(DataSet: TDataSet);

    function getRoomTypeColors(sRoomType: string): recStatusAttr;
    procedure roomerMainDataSetSessionExpired(Sender: TObject);
    procedure kbmRoomRentOnInvoice_BeforePost(DataSet: TDataSet);
    procedure mInvoiceHeadsBeforePost(DataSet: TDataSet);
    procedure confirmMonitorTimer(Sender: TObject);
    procedure mInvoicelines_beforeNewRecord(DataSet: TDataSet);
    procedure mInvoicelines_afterNewRecord(DataSet: TDataSet);

  private
    { Private declarations }
    lstVaribles: tstringList;
    lstValues: tstringList;

    lstMaintenanceCodes: TKeyPairList;

    procedure SetMainRoomerDataSet(ds: TRoomerDataSet; ConnectAllDatasets: boolean = True);
    procedure LoadMaintenanceCodes;
    function LocateWRoom(Room: String): boolean;
    procedure ClearMaintenanceCodes;
    procedure SelectCloudConfig;
    procedure SetDefaultCloudConfig;
    procedure SetCloudConfigByFile(filename: String);
  public
    { Public declarations }
    qConnected: boolean;
    qRes, qRres: Integer;
    RoomsDateSetWork: TRoomerDataSet;

    zTelPriceGroupsFilter: string;
    zTelPriceGroupsSortField: string;
    zTelPriceGroupsSortDir: string;

    zTelPriceRulesFilter: string;
    zTelPriceRulesSortField: string;
    zTelPriceRulesSortDir: string;

    zRptInitFilter: string;
    zRptInitSortField: string;
    zRptInitSortDir: string;

    zItemsFilter: string;
    zItemsSortField: string;
    zItemsSortDir: string;

    zItemTypesFilter: string;
    zItemTypesSortField: string;
    zItemTypesSortDir: string;

    zRoomPricesFilter_1: string;
    zRoomPricesSortField_1: string;
    zRoomPricesSortDir_1: string;

    zMaidActionsFilter: string;
    zMaidActionsSortField: string;
    zMaidActionsSortDir: string;

    lstCollect: tstringList;

    function RetrieveFinancesKeypair(keyPairType: TKeyPairType): TKeyPairList;
    function KeyExists(keyList: TKeyPairList; Key: String): boolean;

    procedure PrepareFixedTables;

    procedure SaveTcxGridColumnOrder(form: TForm; grid: TcxGrid);
    procedure LoadTcxGridColumnOrder(form: TForm; grid: TcxGrid);

    function colorCodeOfStatus(status: String): TColor;
    procedure CopyInvoiceToInvoiceLinesTmp(Invoice: Integer; FromKredit: boolean); overload;
    procedure CopyInvoiceToInvoiceLinesTmp(Invoice: Integer; FromKredit: boolean; var hasPackage : Boolean; var SelectedInvoiceIndex : Integer); overload;

    function GetCustomerCurrency(sCustomer: string): string;
    function GetCustomerName(customer: string): string;
    function GET_CustomerTypesDescription_byCustomerType(CustomerType: string): string;

    // MaidActions Table
    function qryGetMaidActions(Orderstr: string): string;
    function OpenMaidActionsQuery(var SortField, SortDir: string): boolean;
    function Del_MaidActionByMaidAction(sAction: string): boolean;
    function MaidActionExist(sCode: string): boolean;

    function qryGetTelPriceGroups(Orderstr: string): string;
    function OpenTelPriceGroupsQuery(var SortField, SortDir: string): boolean;
    function GET_telPriceGroupsName_byCode(Code: string): string;
    function Del_PriceGroupByCode(Code: string): boolean;
    function PriceGroupExist(Code: string): boolean;
    function qryGetTelPriceRules(Orderstr: string): string;
    function OpenTelPriceRulesQuery(var SortField, SortDir: string): boolean;
    function GET_telPriceRulesName_byCode(Code: string): string;
    function Del_PriceRuleByCode(Code: string): boolean;
    function PriceRuleExist(Code: string): boolean;
    function isMixedStatus(reservation: Integer): string;
    function isMixedBreakfast(reservation: Integer): string;
    function isMixedPaymentDetails(reservation: Integer): string;
    function isGroup(RoomReservation: Integer): boolean;

    function GetReservationLocations(reservation: Integer; var lst: tstringList): Integer;
    function GetRoomReservationLocations(RoomReservation: Integer; var lst: tstringList): Integer;
    procedure insertActivityLogFromMemTable;

    function GET_RoomsDescription_byRoom(sRoom: string): string;

    function GET_roomstatus(sRoom: string): char;
    function RoomExists(sRoom: string): Integer;
    function RoomExists_InRoomReservation(sRoom: string): Integer;

    // Roomtypes Table
    function RoomTypeExistsInOther(sRoomType: string): boolean;
    function RoomTypeExists(sRoomType: string): boolean;
    function Del_RoomTypeByRoomType(sRoomType: string): boolean;

    function RoomTypeGroupExistsInOther(sRoomTypeGroup: string): boolean;
    function RoomTypeGroupExists(sRoomTypeGroup: string): boolean;
    function Del_RoomTypeGroupByRoomTypeGroup(sRoomTypeGroup: string): boolean;
    function GET_RoomTypeGroupDescription_byRoomTypeGroup(sRoomTypeGroup: string): string;

    function qryGetViewRooms(Orderstr: string): string;
    function OpenViewRoomsQuery(SortField, SortDir: string): boolean;
    function getRoomText(sRoom: string): string;

    // Locations Table
    function GET_LocationDescription_byLocation(sLocation: string): string;
    function GET_Location_byLocationDescription(sDescription: string): string;

    // Paytypes Table
    procedure PayTypes_InitDoExport;
    function PayTypes_isExport(sPaytype: string): boolean;

    // ItemTypes Table
    function GET_ItemTypeDescription_byItemType(sItemType: string): string;
    function Del_ItemTypeByItemType(sItemType: string): boolean;
    function ItemTypeExists(sItemType: string): boolean;
    function ItemTypeExistsInOther(sItemType: string): boolean;

    // Items Table
    function qryGetItems(Orderstr: string): string;
    function OpenItemsQuery(var SortField, SortDir: string): boolean;

    // StaffMembers Table
    function GET_StaffMemberName_byInitials(sInitials: string): string;
    function GET_StaffMemberPID_byInitials(sInitials: string): string;

    // PriceCodes Table
    function qryGetRoomPrices_1(Orderstr: string; priceCodeID, seasonId: Integer; RoomType, Currency: string;
      seEndDate: TdateTime): string;

    function OpenRoomPricesQuery_1(var SortField, SortDir: string; priceCodeID, seasonId: Integer;
      RoomType, Currency: string;
      seEndDate: TdateTime): boolean;
    function Del_RoomPricesByID_1(Id: Integer): boolean;
    function Get_LastRoomPriceID_1: Integer;

    function getPrice_1(rtID: Integer; persons: Integer; var Code, RoomType, Currency: string): Double;
    function getPrice_2(rtID: Integer; persons: Integer): Double;

    function getRackPriceID_1(seasonId: Integer; RoomType, Currency: string): Integer;

    function PriceExistsByCodes(pcCode, seDescription, RoomType, Currency: string): boolean;
    function PriceExistsByCodesAndCurrency(pcCode, Currency: string): boolean;

    function doLogin(login, password: string): boolean;

    // Seasons Table
    function GET_SeasonsDates_bySeasonID(seasonId: Integer; var seStartdate, seEndDate: TdateTime): boolean;
    function GET_SeasonsDescription_bySeasonID(seasonId: Integer): string;
    function GET_SeasonsId_byDescription(seDescription: string): Integer;
    function Del_SeasonByID(Id: Integer): boolean;

    function SeasonExist(aDateFrom, aDateTo: TdateTime): boolean;
    function SeasonCount(aDate: TdateTime): Integer;
    function FindSeasonID(aDate: TdateTime): Integer;
    function SeasonExists_byID(seasonId: Integer): boolean;

    // tblINC Table
    function getTblINC_nextCustomerNumber: string;
    function getTblINC_Last: Integer;
    function getTblINC_Length: Integer;
    function getTblINC_Fill: string;

    // InvoiceLinesTmp
    function InvoiceLinesTmp_exists(iRoomReservation: Integer): boolean;
    function del_InvoiceLinesTmp(iRoomReservation: Integer): boolean;

    procedure UpdateBreakfastIncluted(reservation, RoomReservation: Integer; BreakfastIncluted: boolean);
    procedure UpdateGroupAccountAll(reservation, RoomReservation, RoomReservationAlias: Integer; GroupAccount: boolean);
    procedure UpdateGroupAccountOne(reservation, RoomReservation, RoomReservationAlias: Integer; GroupAccount: boolean;
      InvoiceIndex: Integer = -1);
    function UpdateReservationMarket(aReservation: Integer; aMarket: TReservationMarketType): boolean;

    function UpdateExpectedCheckoutTime(aReservation, aRoomReservation: Integer; const aCheckoutTime: string): boolean;
    function UpdateExpectedTimeOfArrival(aReservation, aRoomReservation: Integer; const aTimeOfArrival: string)
      : boolean;
    function UpdateChildrenCount(aReservation, aRoomReservation: Integer; const aChildren: integer): boolean;
    function UpdateInfantCount(aReservation, aRoomReservation: Integer; const aInfants: integer): boolean;

    function isAllRRSameCurrency(reservation: Integer): boolean;
    // Er Allar herbergisb�kanir innan b�kunnar � sama gjaldmi�li

    function GetBreakfastIncluted(reservation, RoomReservation: Integer): boolean;
    function GetGroupAccount(reservation, RoomReservation: Integer): boolean;

    function OpenInvoiceInvoiceLines(reservation, RoomReservation: Integer): Integer;
    function NameOnOpenInvoice(reservation, RoomReservation: Integer): string;

    function MoveRoom(RoomReservation: Integer; NewRoom: string): boolean;

    function GetRoomList_Occupied(dtDateFrom, dtDateTo: Tdate; iRoomReservation: Integer; var lst: tstringList)
      : boolean;
    function isDay_Occupied(dtDate: Tdate; Room: string; var RoomReservation: Integer): boolean;

    function Occupied_fromTo(dtDateFrom, dtDateTo: Tdate; Room: string): boolean;

    function RemoveRoomsDate(iRoomReservation: Integer): boolean;

    function ChangeRrDates(RoomReservation: Integer; newArrival, newDeparture: Tdate;
      updateRoomstatus: boolean): boolean;

    // function RR_ChangeDates(RoomReservation : integer;newArrival, newDeparture : Tdate) : boolean;

    function isAllDatesSameInRes(reservation: Integer): boolean;

    procedure RemoveRoomReservation(RoomReservation: Integer;
      CancelStaff
      , CancelReason
      , CancelInformation: string;

      CancelType: Integer;
      doLog,
      useTrans, ask: boolean);

    procedure RemoveReservation(iReservation: Integer;
      CancelStaff
      , CancelReason
      , CancelInformation: string;
      CancelType: Integer

      );

    procedure RemoveReservationNotSave(iReservation: Integer; CancelStaff, CancelReason, CancelInformation: string;
      CancelType: Integer);

    procedure SetAsNoRoomEnh(RoomReservation: Integer; AllReservations: boolean);
    function GetCustomerFromRes(aRes: Integer): string;

    function GetInvoiceCurrency(InvoiceNumber: Integer): string;
    function GetInvoiceCurrencyAndReservationNumber(InvoiceNumber: Integer;
      var reservation, RoomReservation: Integer;
      var Room: String): string;
    Procedure GetInvoiceCurrencyAndRate(InvoiceNumber: Integer; var Currency: string; var Rate: Double);

    procedure AddPerson(iRoomReservation, iReservation: Integer; ciCustomerInfo: recCustomerHolderEX; sType: string;
      bTransaction: boolean);

    procedure RemovePerson(iRoomReservation: Integer; bTransaction: boolean);

    procedure UpdateUsersLanguage(Staff: string; iLanguage: Integer);

    procedure CheckInGuest(RoomReservation: Integer);
    procedure CheckOutGuest(RoomReservation: Integer; Room: String);

    function GetCustomerPreferences(CustomerID: string): string;

    function GetRoomStatus(Room: string): char;
    function AskApproval(PayType: string): boolean;
    function getCountryCode(aText: string): string;
    function getCountryName(const aCountryCode: string): string;

    function Item_Get_AccountKey(sItem: string): string;
    function Item_Get_Type(Item: string): string;

    function Item_Get_Data(aItem: string): recItemPlusHolder;

    function Item_Del(sItem: string): boolean;
    function Item_ExistsInOther(sItem: string): boolean;

    function Item_Get_ItemTypeInfo(Item: string; package: String = ''): TItemTypeInfo;

    function FieldExists(rSet: TRoomerDataSet; FieldName: String): boolean;
    function VATDescription(Code: string): string;
    function VATPercentage(Code: string): Double;
    function VATvalueFormula(Code: string): String;
    function PackageVATvalueFormula(package, Item: string; VATPercentage: Double): String;
    procedure VATvalueFormulaAndPercentage(Code: String; package: String; Item: String; var Formula: string;
      var Percentage: Double);

    function StaffExists(Staff: string): boolean;
    function CustomerTypeName(CustomerTypeCode: string): string;

    function SetInvoiceOrginalRef(Invoice, RoomReservation, OrginalRef: Integer): boolean;
    function inDateRange(seasonId: Integer; FromDate, ToDate: Tdate; var RangeStart, RangeEnd: Tdate): boolean;

    function GetRoomReservation(reservation: Integer; Room: string): Integer;
    function RoomsTypeCount(CountAll: boolean): Integer;

    function isUnPaid(RoomReservation: Integer): boolean;
    function isUnPaidByRes(reservation: Integer): boolean;
    function RemoveRoomsDatebyReservation(iReservation: Integer): boolean;
    function RemoveRoomReservationByReservation(iReservation: Integer): boolean;
    function RemoveInvoiceHeadsByReservation(iReservation: Integer): boolean;
    function RemoveReservationsByReservation(iReservation: Integer): boolean;
    function NextRoomReservatiaon(Room: string; RoomReservation: Integer; noResDate: Tdate): Integer;
    function LastRoomReservatiaon(Room: string; RoomReservation: Integer; noResDate: Tdate): Integer;

    function RemoveInvoiceCashInvoice: boolean;

    function InsInvoiceAction(R: TInvoiceActionRec): boolean;

    procedure SetUnclean(Room: string);
    procedure SetAllClean;
    procedure SetAllUnClean;

    function invoice_isExport(invoiceNo: Integer): boolean;

    function GetRoomReservatiaonArrival(RoomReservation: Integer): Tdate;

    function Del_MaidsJobsByDate(aDate: Tdate; All: boolean): boolean;

    function getRoomTypeFromRR(RR: Integer): string;
    function getChangeAvailabilityInfo(RR: Integer; var RoomType, status: string;
      var Arrival, departure: Tdate): boolean;
    function getCountryGroupNameFromCountry(Country: string): string;
    function getCountryGroupFromCountry(Country: string): string;
    function getLocationFromRoom(Room: string): string;
    function getinStatisticsFromRoom(Room: string): boolean;
    function getFloorFromRoom(Room: string): Integer;
    function ChangeCountry(newCountry: string; reservation, RoomReservation, Person, Medhod: Integer): boolean;
    function reservationCount(reservation: Integer): Integer;
    function getCountryFromReservation(reservation: Integer): string;

    function isKredit(InvoiceNumber: Integer): boolean;
    function Del_PaymentByInvoice(iNumber: Integer): boolean;

    procedure CreateMtFields;
    procedure InsertMTdata(InvoiceNumber: Integer; doExport, silent: boolean; showPackage: boolean);
    procedure exportToSnertaTextRec(silent: boolean);

    procedure exportToSnertaSimpleXML(silent: boolean);

    function SnertaExportCustomers(custNo: string): Integer;
    function SnertaExportRooms(Room, prefix: string): Integer;

    function lstRR_CurrentlyCheckedIn(aDate: Tdate): tstringList;
    function isRrCurrentlyCheckedIn(RoomReservation: Integer): boolean;
    function isResCurrentlyCheckedIn(reservation: Integer): boolean;

    function ExtStatusText(status: string; aDate, Arrival, departure: Tdate): string;

    function Next_OccupiedDate(FromDate: Tdate; Room: string): Tdate;
    function Next_OccupiedDayCount(FromDate: Tdate; Room: string): Integer;

    function GetCurrentGuestsXML: Integer;

    procedure RR_ExcluteFromOpenInvoices(RoomReservation: Integer);

    function hiddenInfo_Exists(Refrence, RefrenceType: Integer): Integer; // returns field ID
    function hiddenInfo_getData(Id: Integer): recHiddenInfoHolder;
    function hiddenInfo_Append(Id: Integer; newText: string; res: Integer): boolean;

    Procedure memImportResults_Fill;
    procedure memImportTypes_Fill;

    function imPortLog_getLastID: Integer;
    function imPortLog_InvoiceNumber: Integer;

    function imPortLog_isNewAvailable: boolean;
    procedure chkInPosMonitor;

    function IH_GetRefrence(InvoiceNumber, reservation, RoomReservation: Integer): string;
    procedure IH_getPaymentsTypes(InvoiceNumber: Integer; var PayTypes, PayTypeDescription, payGroups,
      payGroupDescription: string);

    Function IA_ActionCount(InvoiceNumber, actionID: Integer): Integer;

    procedure UpdPaymentsWhenChangingReservationToGroup(reservation, RoomReservation: Integer);
    procedure UpdPaymentsWhenChangingReservationToRoom(reservation, RoomReservation: Integer);

    procedure INV_UpdateBreakfastGuests(aReservation, aRoomReservation: integer; aNewNumberOfBreakfast: integer);

    // *************************************************************************
    // Control functions
    /// ////////////////////////////////////////////////////////////////////////

    procedure ctrlGetGlobalValues;
    function ChkCompany(Company, CompanyName: string): boolean;

    procedure ctrlSetInteger(aField: string; ivalue: Integer);
    procedure ctrlSetString(aField: string; svalue: string);

    // *************************************************************
    // StatusAttr
    // -------------------------------------------------------------

    procedure Get_All_StatusAttributes;

    procedure save_StatusAttr_Blocked;
    procedure save_StatusAttr_NoShow;
    procedure save_StatusAttr_Waitinglist;
    procedure save_StatusAttr_WaitinglistNonOptional;
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
    procedure Default_StatusAttr_Option;
    procedure Default_StatusAttr_WaitingList;
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

    // ---------------------------------------------------------------
    function RV_Upd_Name(res: Integer; newName: string): boolean;
    function RR_Upd_CurrencyRoomPrice(iRoomReservation: Integer; aDate: string; Currency: string;
      Convert: Double): boolean;

    function RR_Upd_MemoTexts(iRoomReservation: Integer; HiddenInfo: string): boolean;

    procedure RR_Upd_FirstGuestName(iRoomReservation: Integer; newName: string);
    function RR_Upd_GuestCount(iRoomReservation, NewCount: Integer): boolean;
    function RE_Upd_MarketSegment(newValue: string; reservation: Integer): boolean;
    function IH_Upd_UnPaid_RR(RoomReservation: Integer): boolean;
    function RR_Upd_Package(iRoomReservation: Integer; package: string): boolean;
    function RR_clear_Package(iRoomReservation: Integer; package: string): boolean;

    function RR_GetNumberOfRooms(iReservation: Integer): Integer;

    function RR_GetGuestCount(iRoomReservation: Integer): Integer;
    function RR_GetRoomNr(iRoomReservation: Integer): string;
    function RR_GetRoomArrivalAndDeparture(iRoomReservation: Integer; var Room: String;
      var Arrival, departure: TdateTime): boolean;

    function RR_GetArrivalDate(iRoomReservation: Integer): Tdate;
    function RR_GetDepartureDate(iRoomReservation: Integer): Tdate;

    function RR_getDates(iRoomReservation: Integer): recResDateHolder;
    function RV_getDates(iReservation: Integer): recResDateHolder;

    function RR_GetReservationName(iRoomReservation: Integer): string;
    function RR_GetMemoText(iRoomReservation: Integer; VAR RoomNotes: string; FieldName: String = 'HiddenInfo')
      : boolean;
    function RR_GetMemoBothTextForRoom(iRoomReservation: Integer; var RoomNotes, ChannelRequest: string): boolean;

    function RR_GetFirstGuestName(iRoomReservation: Integer): string;
    function RR_GetAllGuestNames(iRoomReservation: Integer; showAll: boolean = True; showTotal: boolean = True): string;

    function RR_GetLastGuestID(iRoomReservation: Integer): Integer;
    function RR_GetFirstGuestCountry(iRoomReservation: Integer): string;
    function RR_GetFirstGuestType(iRoomReservation: Integer): string;

    function RR_GetStatus(iRoomReservation: Integer): string;
    function RR_GetIsGroopAccount(iRoomReservation: Integer): boolean;

    function RR_FirstDayAndRoom(RoomReservation: Integer; var Room: string): Tdate;
    function RV_FirstDayAndRoom(reservation: Integer; var Room: string): Tdate;
    function Ref_FirstDayAndRoom(ref: string; var Room: string): Tdate;

    function RV_getMemos(reservation: Integer; var information, PMinfo: string): boolean;

    function INV_FirstDayAndRoom(InvoiceNumber: Integer; var Room: string; var InvoiceKind: Integer): Tdate;

    function RRlst_FromToUnpaid(DateFrom, DateTo: Tdate): tstringList;
    function RRlst_FromTo(DateFrom, DateTo: Tdate): tstringList;
    function RRlst_Departure(DateFrom, DateTo: Tdate): tstringList;

    function GuestlistRRlst_FromTo(DateFrom, DateTo: Tdate; includeNoshow, includeAllotment, includeBlocked: boolean)
      : tstringList;
    function GuestListRRlst_Arrival(DateFrom, DateTo: Tdate; includeNoshow, includeAllotment, includeBlocked: boolean)
      : tstringList;
    function GuestlistRRlst_Departure(DateFrom, DateTo: Tdate; includeNoshow, includeAllotment, includeBlocked: boolean)
      : tstringList;

    function RRlst_DepartureNationalReport(DateFrom, DateTo: Tdate): tstringList;
    function RRlst_DepartureNationalReportByLocation(DateFrom, DateTo: Tdate; Location: string): tstringList;

    function RRlst_Arrival(DateFrom, DateTo: Tdate): tstringList;

    function Rvlst_CreatedFromTo(DateFrom, DateTo: Tdate): tstringList;
    function Rvlst_FromToGroup(DateFrom, DateTo: Tdate): tstringList;
    function RVlst_FromTo(DateFrom, DateTo: Tdate): tstringList;
    function RVlst_Arrival(DateFrom, DateTo: Tdate; customer: string = ''): tstringList;
    function RVlst_Departure(DateFrom, DateTo: Tdate): tstringList;

    procedure Reservations_InitUseStayTax;

    Function GroupAccountCount(reservation: Integer): Integer;
    Function BreakFastInclutedCount(reservation: Integer): Integer;

    function rrGetDiscount(RoomReservation: Integer; var DiscountType: Integer; var DiscountAmount: Double): boolean;
    function rrEditDiscount(RoomReservation: Integer; DiscountType: Integer; DiscountAmount: Double): boolean;

    procedure UpdateStatusSimple(reservation, RoomReservation: Integer; newStatus: string);

    function SetAsNoRoom(RoomReservation: Integer): boolean;
    function ChkFinished(invNr: Integer): Integer;

    function AddInvoiceLinesTMP(LastLineNumber, iReservation: Integer): boolean;

    procedure InsertReciptData(PaymentData: recPaymentHolder; invoiceData: recInvoiceHeadHolder);

    function LocateRecord(rSet: TRoomerDataSet; FieldName: String; Value: Integer): boolean; overload;
    function LocateRecord(rSet: TRoomerDataSet; FieldName: String; Value: String): boolean; overload;
    procedure ApplyFieldsToKbmMemTable(sourceSet: TRoomerDataSet; destSet: TdxMemData; loadDataSet: boolean = True);
    procedure SaveKbmMemTable(destSet: TdxMemData; filename: String; performTouch: boolean = False);
    procedure TurnoverAndPaymentsGetAll(clearData: boolean; var zGlob: recTurnoverAndPaymentsGlobals);
    procedure TurnoverAndPaymentsGetAll_II(clearData: boolean; var zGlob: recTurnoverAndPaymentsGlobals_II);
    procedure TurnoverAndPaymentsUpdateTurnover(var zGlob: recTurnoverAndPaymentsGlobals);
    procedure TurnoverAndPaymentsUpdateTurnover_II(var zGlob: recTurnoverAndPaymentsGlobals_II);

    procedure TurnoverAndPaymentsUpdateTurnoverItemPriceChange(var rec: recTurnoverAndPaymentsGlobals);
    procedure TurnoverAndPaymentsUpdateTurnoverItemPriceChange_II(var rec: recTurnoverAndPaymentsGlobals_II);

    procedure TurnoverAndPaymentsDoConfirm;
    procedure TurnoverAndPaymentsDoConfirm_II;

    function GetLastConfirm: TdateTime;
    procedure chkConfirmMonitor;
    procedure TurnoverAndPayemnetsClearAllData(justClose: boolean);

    function getCurrencyProperties(Currency: String): TcxCustomEditProperties;
    procedure AddOrCreateToPackage(pckTotalsList: TRoomPackageLineEntryList;
      Code: String;
      _Description: string;
      RoomReservation: Integer;
      _Amount,
      _AmountWoVat,
      _VatAmount: Double;
      _isRoom: boolean;
      _packageCode: string;
      _packageDescription: string;
      _lineNo: Integer;
      _adate: Tdate;
      _count: Double
      );
    procedure GenerateOfflineReports;
    function CheckOutRoom(reservation, RoomReservation: Integer; Room: String): boolean;
  end;

function CreateNewDataSet: TRoomerDataSet;
function HtmlToColor(s: string; aDefault: TColor): TColor;
function getRowHeightFromIndex(index: Integer): Integer;
function GenerateProformaInvoiceNumber: Integer;

var
  PROFORMA_INVOICE_NUMBER: Integer;
{$IFDEF rmROOMERSSL}

  const RoomerBase: String = 'https://secure.roomercloud.net';
        RoomerBasePort: String = '443';
        RoomerOpenAPIBase: String = 'https://secure.roomercloud.net';
        RoomerOpenApiBasePort: String = '443';

{$ELSE}

  const RoomerBase: String = 'http://secure.roomercloud.net';
        RoomerBasePort: String = '80';
        RoomerOpenApiBasePort: String = '80';
        RoomerOpenAPIBase: String = 'http://secure.roomercloud.net';

{$ENDIF}

  const RoomerStoreBase: String = 'http://store.roomercloud.net';
        RoomerStoreBasePort: String = '8080';


var
  _RoomerBase,
    _RoomerBasePort,
    _RoomerOpenApiBasePort,
    _RoomerOpenApiBase,
    _RoomerStoreBase,
    _RoomerStoreBasePort: String;

var
  d: Td;

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
    , UITypes
    , uVatCalculator;

{$R *.dfm}


var
  RoomerStoreUri: String;
  RoomerOpenApiUri: String;
  RoomerApiUri: String;
  RoomerApiEntitiesUri: String;
  RoomerApiDatasetsUri: String;

function CreateNewDataSet: TRoomerDataSet;
begin
  result := d.roomerMainDataSet.CreateNewDataSet;
end;

function Td.getCurrencyProperties(Currency: String): TcxCustomEditProperties;
var
  currEdit: TObject;
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
      result := d.CurrencyMXN2d.Properties
    else
      if Currency = 'GBP' then
      result := d.currencyGBP2d.Properties
    else
      result := d.currencyEUR2d.Properties;
  end;
end;

procedure Td.chkInPosMonitor;
var
  use: boolean;
  interval: Integer;
begin
  try
    use := g.qInPosMonitorUse;
    interval := g.qInPosMonitorChkSec;
    interval := interval * 1000;
  except
    use := False;
    interval := 5000;
  end;

  inPosMonitor.interval := interval;
  inPosMonitor.Enabled := use;
end;

procedure Td.LoadTcxGridColumnOrder(form: TForm; grid: TcxGrid);
var
  i: Integer;
begin
  // ini := TRoomerRegistryIniFile.Create();
  for i := 0 to grid.ViewCount - 1 do
    grid.Views[i].RestoreFromRegistry(form.Name + '_' + grid.Name, False, True);
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

procedure Td.SetCloudConfigByFile(filename: String);
begin
  with TInifile.Create(TPath.Combine(ExtractFilePath(Application.ExeName), filename)) do
    try
      _RoomerBase := ReadString('Cloud', 'RoomerBase', RoomerBase);
      _RoomerBasePort := ReadString('Cloud', 'RoomerBasePort', RoomerBasePort);
      _RoomerStoreBase := ReadString('Cloud', 'RoomerStoreBase', RoomerStoreBase);
      _RoomerStoreBasePort := ReadString('Cloud', 'RoomerStoreBasePort', RoomerBase);
      _RoomerOpenApiBase := ReadString('Cloud', 'RoomerOpenAPIBase', RoomerOpenAPIBase);
      _RoomerOpenApiBasePort := ReadString('Cloud', 'RoomerOpenApiPort', RoomerOpenApiBasePort);

      RoomerOpenApiUri := _RoomerOpenApiBase + ':' + _RoomerOpenApiBasePort + ReadString('Cloud', 'RoomerOpenApiRestPath', '/roomer/openAPI/REST/');
      RoomerStoreUri := _RoomerStoreBase + ':' + _RoomerStoreBasePort + '/services/';

      RoomerApiUri := _RoomerBase + ':' + _RoomerBasePort + '/services/';
      RoomerApiEntitiesUri := RoomerApiUri + 'entities/';
      RoomerApiDatasetsUri := RoomerApiUri + 'datasets/';
    finally
      Free;
    end;
end;

procedure Td.SelectCloudConfig;
var
  files: TStrings;
  path: String;
  lfile: string;
begin
  files := tstringList.Create;
  try
    for path in GetFilesInSpecifiedDirectory(ExtractFilePath(Application.ExeName), 'roomer_environment*.cfg') do
      files.Add(path);
    if files.Count = 0 then
    begin
      SetDefaultCloudConfig;
    end
    else
    begin
      if files.Count = 1 then
        SetCloudConfigByFile(files[0])
      else
      begin
        lfile := SelectConfigurationEnvironment(files);
        if lFile.IsEmpty then
          ExitProcess(0)
        else
          SetCloudConfigByFile(lFile);
      end;
    end;
  finally
    files.Free;
  end;
end;

procedure Td.DataModuleCreate(Sender: TObject);
begin
  qRes := -1;
  qRres := -1;

  SelectCloudConfig;

  roomerMainDataSet.OnSessionExpired := roomerMainDataSetSessionExpired;
  lstMaintenanceCodes := TKeyPairList.Create(True);
  SetMainRoomerDataSet(roomerMainDataSet);

  kbmInvoiceLines.Open;

  // **
end;

procedure Td.chkConfirmMonitor;
var
  use: boolean;
  interval: Integer;
begin
  try
    use := g.qConfirmAuto;
    interval := 120000;
    g.qLastConfirm := GetLastConfirm;
    confirmMonitor.interval := interval;
  except
    use := False;
  end;

  confirmMonitor.Enabled := use;
end;

procedure Td.SaveTcxGridColumnOrder(form: TForm; grid: TcxGrid);
var
  i: Integer;
begin
  // ini := TRoomerRegistryIniFile.Create();
  for i := 0 to grid.ViewCount - 1 do
    grid.Views[i].StoreToRegistry(form.Name + '_' + grid.Name, True, [], '');
end;

procedure Td.SetMainRoomerDataSet(ds: TRoomerDataSet; ConnectAllDatasets: boolean = True);
var
  i: Integer;
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

procedure Td.DataModuleDestroy(Sender: TObject);
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

function Td.AddInvoiceLinesTMP(LastLineNumber, iReservation: Integer): boolean;
var
  lineHolder: recInvoicelineHolder;
  ExecutionPlan: TRoomerExecutionPlan;
begin
  // **TTTT

  result := False;

  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  try
    if d.kbmInvoiceLines.Active then
    begin
      if d.kbmInvoiceLines.locate('Reservation', iReservation, []) then
      begin
        try
          d.kbmInvoiceLines.First;
          while not d.kbmInvoiceLines.eof do
          begin
            if d.kbmInvoiceLines.FieldByName('Reservation').AsInteger = iReservation then
            begin
              hData.initInvoiceLineHolderRec(lineHolder);
              lineHolder.InvoiceNumber := -1;
              lineHolder.reservation := d.kbmInvoiceLines.FieldByName('Reservation').AsInteger;
              lineHolder.RoomReservation := d.kbmInvoiceLines.FieldByName('RoomReservation').AsInteger;
              lineHolder.AutoGen := d.kbmInvoiceLines.FieldByName('AutoGen').Asstring;
              lineHolder.SplitNumber := d.kbmInvoiceLines.FieldByName('SplitNumber').AsInteger;
              inc(LastLineNumber);
              lineHolder.ItemNumber := LastLineNumber;
              lineHolder.PurchaseDate := d.kbmInvoiceLines.FieldByName('PurchaseDate').asDateTime;
              lineHolder.ItemID := d.kbmInvoiceLines.FieldByName('ItemID').Asstring;
              lineHolder.Number := d.kbmInvoiceLines.FieldByName('number').asFloat; // -96
              lineHolder.Description := d.kbmInvoiceLines.FieldByName('Description').Asstring;
              lineHolder.Price := d.kbmInvoiceLines.FieldByName('Price').asFloat;
              lineHolder.VATType := d.kbmInvoiceLines.FieldByName('VATType').Asstring;
              lineHolder.TotalWOVAT := d.kbmInvoiceLines.FieldByName('TotalWOVAT').asFloat;
              lineHolder.Vat := d.kbmInvoiceLines.FieldByName('Vat').asFloat;
              lineHolder.Total := d.kbmInvoiceLines.FieldByName('Total').asFloat;
              lineHolder.AutoGenerated := d.kbmInvoiceLines.FieldByName('AutoGenerated').asBoolean;
              lineHolder.CurrencyRate := d.kbmInvoiceLines.FieldByName('CurrencyRate').asFloat;
              lineHolder.Currency := d.kbmInvoiceLines.FieldByName('Currency').Asstring;
              lineHolder.ReportDate := 1;
              lineHolder.ReportTime := '00:00';
              lineHolder.persons := d.kbmInvoiceLines.FieldByName('Persons').AsInteger;
              lineHolder.Nights := d.kbmInvoiceLines.FieldByName('Nights').AsInteger;
              lineHolder.BreakfastPrice := d.kbmInvoiceLines.FieldByName('BreakfastPrice').asFloat;
              lineHolder.AYear := d.kbmInvoiceLines.FieldByName('AYear').AsInteger;
              lineHolder.AMon := d.kbmInvoiceLines.FieldByName('AMon').AsInteger;
              lineHolder.ADay := d.kbmInvoiceLines.FieldByName('ADay').AsInteger;
              lineHolder.ilTmp := d.kbmInvoiceLines.FieldByName('ilTmp').Asstring;
              lineHolder.ilAccountKey := d.kbmInvoiceLines.FieldByName('ilAccountKey').Asstring;
              lineHolder.ItemCurrency := d.kbmInvoiceLines.FieldByName('ItemCurrency').Asstring;
              lineHolder.ItemCurrencyRate := d.kbmInvoiceLines.FieldByName('ItemCurrencyRate').asFloat;
              lineHolder.Discount := d.kbmInvoiceLines.FieldByName('Discount').asFloat;
              lineHolder.Discount_isPrecent := d.kbmInvoiceLines.FieldByName('Discount_isPrecent').asBoolean;
              lineHolder.ImportRefrence := d.kbmInvoiceLines.FieldByName('ImportRefrence').Asstring;
              lineHolder.ImportSource := d.kbmInvoiceLines.FieldByName('ImportSource').Asstring;
              lineHolder.IsPackage := d.kbmInvoiceLines.FieldByName('IsPackage').asBoolean;
              lineHolder.confirmDate := d.kbmInvoiceLines.FieldByName('confirmdate').asDateTime;
              lineHolder.InvoiceIndex := d.kbmInvoiceLines.FieldByName('InvoiceIndex').AsInteger;
              ExecutionPlan.AddExec(SQL_INS_InvoiceLine(lineHolder));
            end;
            d.kbmInvoiceLines.next;
          end;

          if NOT ExecutionPlan.Execute(ptExec, True) then
          begin
            raise Exception.Create(ExecutionPlan.ExecException);
          end
          else
          begin
            result := d.kbmInvoiceLines.recordcount > 0;
            if d.kbmInvoiceLines.Active then
              d.kbmInvoiceLines.Close;
            d.kbmInvoiceLines.Active := True;
          end;

        except
          on e: Exception do
          begin
            // MessageDlg('Problem: Unable to save the tmpInvoiveLines !' + #13#13 + 'The following Error came up:' + #13#13 +
            // e.message + #13#13 + 'Please write this message down or' + #13 + 'call support with this dialog open!', mtError, [mbOK], 0);
            MessageDlg(format(GetTranslatedText('shTx_D_UnableToSaveExceptionMessage'), [e.message]), mtError, [mbOK], 0);
            result := False;
            raise;
          end;
        end;
      end;
    end;
  finally
    freeandnil(ExecutionPlan);
  end;
end;

function Td.CheckOutRoom(reservation, RoomReservation: Integer; Room: String): boolean;
begin
  result := False;
  if ctrlGetBoolean('CheckOutWithPaymentsDialog') OR
    (MessageDlg(format(GetTranslatedText('shCheckOutSelectedRoom'), [Room]), mtConfirmation, [mbYes, mbNo], 0) = mrYes)
  then
  begin
    ShowAlertsForReservation(reservation, RoomReservation, atCHECK_OUT);
    if ctrlGetBoolean('CheckOutWithPaymentsDialog') then
      CheckoutGuestWithDialog(reservation, RoomReservation, Room)
    else
      d.CheckOutGuest(RoomReservation, Room);
    result := True;
  end;
end;

procedure Td.CopyInvoiceToInvoiceLinesTmp(Invoice: Integer; FromKredit: boolean);
var hasPackage : Boolean;
    SelectedInvoiceIndex : Integer;
begin
  CopyInvoiceToInvoiceLinesTmp(Invoice, FromKredit, hasPackage, SelectedInvoiceIndex);
end;

procedure Td.CopyInvoiceToInvoiceLinesTmp(Invoice: Integer; FromKredit: boolean; var hasPackage : Boolean; var SelectedInvoiceIndex : Integer);
var
  reservation: Integer;
  RoomReservation: Integer;
  SplitNumber: Integer;
  PurchaseDate: string;
  InvoiceNumber: Integer;
  ItemNumber: Integer;
  ItemID: string; // (10)
  Number: Double; // -96

  Description: string; // (70)
  Price: Double;
  VATType: string; // (10)
  Total: Double;
  TotalWOVAT: Double;
  Vat: Double;
  CurrencyRate: Double;
  Currency: string; // (5)
  persons: Integer;
  Nights: Integer;

  ImportRefrence: string;
  ImportSource: string;
  IsPackage: boolean;
  hasRooms : Boolean;

//  hasPackage : Boolean;

  s: string;
  rSet: TRoomerDataSet;

  sql: string;

  lExecutionPlan : TRoomerExecutionPlan;

begin
  // Empty it
  if d.kbmInvoiceLines.Active then
    d.kbmInvoiceLines.Close;
  d.kbmInvoiceLines.Open;

  // check if there is unpaid items for this roomreservation if not groupinvoice

  qRes := -1;
  qRres := -1;
  hasPackage := False;

  rSet := CreateNewDataSet;
  try
//    s := 'Select SplitNumber, reservation, roomreservation, to_bool(EXISTS (SELECT * FROM invoicelines WHERE invoiceNumber=invoiceheads.InvoiceNumber AND ImportSource<>'''')) AS hasPackage from invoiceheads where invoicenumber = %d ';
    s := 'Select SplitNumber, reservation, roomreservation, ' +
         'to_bool(EXISTS (SELECT * FROM invoicelines WHERE invoiceNumber=xxx.InvoiceNumber AND ItemId=c.RoomRentItem)) AS hasRooms, ' +
         '       to_int(IF(NOT FIND_IN_SET(''0'', InvoiceIndexes), 0, ' +
         '         IF(NOT FIND_IN_SET(''1'', InvoiceIndexes), 1, ' +
         '           IF(NOT FIND_IN_SET(''2'', InvoiceIndexes), 2, ' +
         '             IF(NOT FIND_IN_SET(''3'', InvoiceIndexes), 3, ' +
         '               IF(NOT FIND_IN_SET(''4'', InvoiceIndexes), 4, ' +
         '                 IF(NOT FIND_IN_SET(''5'', InvoiceIndexes), 5, ' +
         '                   IF(NOT FIND_IN_SET(''6'', InvoiceIndexes), 6, ' +
         '                     IF(NOT FIND_IN_SET(''7'', InvoiceIndexes), 7, ' +
         '                       IF(NOT FIND_IN_SET(''8'', InvoiceIndexes), 8, ' +
         '                         9)))))))))) AS SelectedInvoiceIndex ' +

         'FROM ( ' +
         'Select ih.SplitNumber, ih.reservation, ih.roomreservation, ih.InvoiceNumber, '  +
         '(SELECT IFNULL((SELECT GROUP_CONCAT(DISTINCT InvoiceIndex) FROM invoicelines WHERE RoomReservation=ih.RoomReservation AND Reservation=ih.Reservation AND InvoiceNumber<0), '''')) AS InvoiceIndexes ' +
         'from invoiceheads ih where invoicenumber = %d) xxx, control c ';
    s := format(s, [Invoice]);
    CopyToClipboard(s);
    if hData.rSet_bySQL(rSet, s) then
    begin
      qRes := rSet.FieldByName('Reservation').AsInteger;
      qRres := rSet.FieldByName('RoomReservation').AsInteger;
      hasRooms := rSet.FieldByName('hasRooms').AsBoolean;
      SplitNumber := rSet.FieldByName('SplitNumber').AsInteger;
      SelectedInvoiceIndex := rSet.FieldByName('SelectedInvoiceIndex').AsInteger;

      if not FromKredit then
      begin
        if qRres = 0 then
        begin
          // This is groupinvoice
          if isUnPaidByRes(qRes) then
          begin
            showmessage(GetTranslatedText('shTx_D_UnpaidGroup'));
            exit;
          end;
        end
        else
        begin
          // This is not groupinvoice
          if isUnPaid(qRres) then
          begin
            showmessage(GetTranslatedText('shTx_D_UnpaidRoom'));
            exit;
          end;
        end;
      end;
    end;
  finally
    freeandnil(rSet);
  end;

//  if ((NOT fromKredit) OR (NOT hasPackage)) AND (SplitNumber = 0) then
  if ((NOT fromKredit) OR (NOT hasRooms)) AND (SplitNumber <> 0) then
  begin
    hasPackage := False;

    rSet := CreateNewDataSet;
    try

      sql :=
        ' SELECT ' +
        '     Reservation ' +
        '   , RoomReservation ' +
        '   , SplitNumber ' +
        '   , ItemNumber ' +
        '   , PurchaseDate ' +
        '   , InvoiceNumber ' +
        '   , ItemID ' +
        '   , Number ' +
        '   , Description ' +
        '   , Price ' +
        '   , VATType ' +
        '   , Total ' +
        '   , TotalWOVat ' +
        '   , Vat ' +
        '   , CurrencyRate ' +
        '   , Currency ' +
        '   , persons ' +
        '   , Nights ' +
        '   , BreakfastPrice ' +
        '   , importRefrence ' +
        '   , ImportSource ' +
        '   , isPackage ' +
        ' FROM ' +
        '   invoicelines ' +
        ' WHERE ' +
        '   (InvoiceNumber = %d ) ' +
        ' ORDER BY itemNumber ';

      s := format(sql, [Invoice]);
      if hData.rSet_bySQL(rSet, s) then
      begin
        RoomReservation := 0;
        reservation := 0;
        while not rSet.eof do
        begin
          reservation := rSet.FieldByName('Reservation').AsInteger;
          RoomReservation := rSet.FieldByName('RoomReservation').AsInteger;;
          SplitNumber := rSet.FieldByName('Splitnumber').AsInteger;
          ItemNumber := rSet.FieldByName('ItemNumber').AsInteger;
          PurchaseDate := rSet.FieldByName('PurchaseDate').Asstring;
          InvoiceNumber := rSet.FieldByName('InvoiceNumber').AsInteger;
          ItemID := rSet.FieldByName('ItemId').Asstring;
          Number := rSet.FieldByName('number').asFloat; // -96
          Description := rSet.FieldByName('Description').Asstring;
          Price := LocalFloatValue(rSet.FieldByName('Price').Asstring);
          VATType := rSet.FieldByName('VATType').Asstring;
          Total := LocalFloatValue(rSet.FieldByName('Total').Asstring);
          TotalWOVAT := LocalFloatValue(rSet.FieldByName('TotalWOVat').Asstring);
          Vat := LocalFloatValue(rSet.FieldByName('Vat').Asstring);
          CurrencyRate := LocalFloatValue(rSet.FieldByName('CurrencyRate').Asstring);
          Currency := rSet.FieldByName('Currency').Asstring;
          persons := rSet.FieldByName('Persons').AsInteger;
          Nights := rSet.FieldByName('Nights').AsInteger;
          ImportSource := rSet.FieldByName('ImportSource').Asstring;
          ImportRefrence := rSet.FieldByName('importRefrence').Asstring;
          IsPackage := rSet['isPackage'];

          d.kbmInvoiceLines.Insert;
          d.kbmInvoiceLines.FieldByName('Reservation').AsInteger := reservation;
          d.kbmInvoiceLines.FieldByName('RoomReservation').AsInteger := RoomReservation;
          d.kbmInvoiceLines.FieldByName('SplitNumber').AsInteger := SplitNumber;;
          d.kbmInvoiceLines.FieldByName('ItemNumber').AsInteger := ItemNumber;
          d.kbmInvoiceLines.FieldByName('PurchaseDate').asDateTime := _dbdateToDate(PurchaseDate);
          d.kbmInvoiceLines.FieldByName('InvoiceNumber').AsInteger := InvoiceNumber;
          d.kbmInvoiceLines.FieldByName('ItemId').Asstring := ItemID;
          d.kbmInvoiceLines.FieldByName('Number').asFloat := Number; // -96
          d.kbmInvoiceLines.FieldByName('Description').Asstring := Description;
          d.kbmInvoiceLines.FieldByName('Price').asFloat := Price;
          d.kbmInvoiceLines.FieldByName('VATType').Asstring := VATType;
          d.kbmInvoiceLines.FieldByName('Total').asFloat := Total;
          d.kbmInvoiceLines.FieldByName('TotalWOVat').asFloat := TotalWOVAT;
          d.kbmInvoiceLines.FieldByName('VAT').asFloat := Vat;
          d.kbmInvoiceLines.FieldByName('CurrencyRate').asFloat := CurrencyRate;
          d.kbmInvoiceLines.FieldByName('Currency').Asstring := Currency;
          d.kbmInvoiceLines.FieldByName('Persons').AsInteger := persons;
          d.kbmInvoiceLines.FieldByName('Nights').AsInteger := Nights;

          d.kbmInvoiceLines.FieldByName('BreakfastPrice').asFloat := 0.00;

          d.kbmInvoiceLines.FieldByName('ImportSource').Asstring := ImportSource;
          d.kbmInvoiceLines.FieldByName('importRefrence').Asstring := ImportRefrence;
          d.kbmInvoiceLines.FieldByName('isPackage').asBoolean := IsPackage;
          d.kbmInvoiceLines.FieldByName('confirmdate').asDateTime := 2;
          d.kbmInvoiceLines.post;

          rSet.next;
        end;

        if (reservation <> 0) then
          d.AddInvoiceLinesTMP(0, reservation);

        if not FromKredit then
        begin
          if RoomReservation = 0 then
          begin
            EditInvoice(reservation, 0, 0, 0, 0, 0, False, True, False);
          end
          else
          begin
            // This is not groupinvoice
            EditInvoice(reservation, RoomReservation, 0, 0, 0, 0, False, True, False);
          end;
        end;
      end;
    finally
      freeandnil(rSet);
    end;
  end else
  begin
      hasPackage := True;
      lExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
      try
        sql := format('INSERT INTO invoicelines ' +
                      '( ' +
                      'AutoGen, ' +
                      'Reservation, ' +
                      'RoomReservation, ' +
                      'SplitNumber, ' +
                      'ItemNumber, ' +
                      'PurchaseDate, ' +
                      'InvoiceNumber, ' +
                      'ItemID, ' +
                      'Number, ' +
                      'Description, ' +
                      'Price, ' +
                      'VATType, ' +
                      'Total, ' +
                      'TotalWOVat, ' +
                      'Vat, ' +
                      'AutoGenerated, ' +
                      'CurrencyRate, ' +
                      'Currency, ' +
                      'ReportDate, ' +
                      'ReportTime, ' +
                      'Persons, ' +
                      'Nights, ' +
                      'BreakfastPrice, ' +
                      'Ayear, ' +
                      'Amon, ' +
                      'Aday, ' +
                      'ilAccountKey, ' +
                      'ItemCurrency, ' +
                      'ItemCurrencyRate, ' +
                      'Discount, ' +
                      'Discount_isprecent, ' +
                      'ImportRefrence, ' +
                      'ImportSource, ' +
                      'isPackage, ' +
                      'RoomReservationAlias, ' +
                      'ItemSource, ' +
                      'InvoiceIndex, ' +
                      'staffCreated, ' +
                      'staffLastEdit, ' +
                      'itemAdded, ' +
                      'lineid ' +
                      ') ' +
                      ' ' +
                      'SELECT ' +
                      'UUID(), ' +
                      'Reservation, ' +
                      'RoomReservation, ' +
                      'SplitNumber, ' +
                      'ItemNumber, ' +
                      'PurchaseDate, ' +
                      '-1, ' +
                      'ItemID, ' +
                      'Number, ' +
                      'Description, ' +
                      'Price, ' +
                      'VATType, ' +
                      'Total, ' +
                      'TotalWOVat, ' +
                      'Vat, ' +
                      'AutoGenerated, ' +
                      'CurrencyRate, ' +
                      'Currency, ' +
                      'ReportDate, ' +
                      'ReportTime, ' +
                      'Persons, ' +
                      'Nights, ' +
                      'BreakfastPrice, ' +
                      'Ayear, ' +
                      'Amon, ' +
                      'Aday, ' +
                      'ilAccountKey, ' +
                      'ItemCurrency, ' +
                      'ItemCurrencyRate, ' +
                      'Discount, ' +
                      'Discount_isprecent, ' +
                      'ImportRefrence, ' +
                      'ImportSource, ' +
                      'isPackage, ' +
                      'RoomReservationAlias, ' +
                      'ItemSource, ' +
                      '%d, ' +
                      'staffCreated, ' +
                      'staffLastEdit, ' +
                      'itemAdded, ' +
                      'lineid ' +
                      'FROM invoicelines, ' +
                      '     control c ' +
                      'WHERE InvoiceNumber=%d AND (NOT ItemId IN (c.RoomRentItem, ' +
                      '(SELECT Item FROM items WHERE ID=(SELECT BOOKING_ITEM_ID FROM home100.TAXES WHERE HOTEL_ID=SUBSTR(database(), 9, 10) AND PurchaseDate >= VALID_FROM AND PurchaseDate <= VALID_TO LIMIT 1) LIMIT 1)))',
                      [SelectedInvoiceIndex, Invoice]);
        CopyToClipboard(sql);
        lExecutionPlan.AddExec(sql);

        sql := format('INSERT INTO invoiceheads ' +
                      '(Reservation, ' +
                      'RoomReservation, ' +
                      'SplitNumber, ' +
                      'InvoiceNumber, ' +
                      'InvoiceDate, ' +
                      'Customer, ' +
                      'Name, ' +
                      'Address1, ' +
                      'Address2, ' +
                      'Address3, ' +
                      'Address4, ' +
                      'Country, ' +
                      'Total, ' +
                      'TotalWOVAT, ' +
                      'TotalVAT, ' +
                      'TotalBreakFast, ' +
                      'ExtraText, ' +
                      'Finished, ' +
                      'InvoiceType, ' +
                      'ihDate, ' +
                      'ihStaff, ' +
                      'ihPayDate, ' +
                      'ihConfirmDate, ' +
                      'ihInvoiceDate, ' +
                      'ihCurrency, ' +
                      'ihCurrencyRate, ' +
                      'invRefrence, ' +
                      'TotalStayTax, ' +
                      'TotalStayTaxNights, ' +
                      'showPackage, ' +
                      'location, ' +
                      'staff, ' +
                      'externalInvoiceId, ' +
                      'InvoiceFinalized, ' +
                      'externalIdentifier ' +
                      ') ' +
                      'SELECT Reservation, ' +
                      'RoomReservation, ' +
                      'SplitNumber, ' +
                      '-1, ' +
                      'CURRENT_DATE, ' +
                      'Customer, ' +
                      'Name, ' +
                      'Address1, ' +
                      'Address2, ' +
                      'Address3, ' +
                      'Address4, ' +
                      'Country, ' +
                      'Total, ' +
                      'TotalWOVAT, ' +
                      'TotalVAT, ' +
                      'TotalBreakFast, ' +
                      'ExtraText, ' +
                      '0, ' +
                      'InvoiceType, ' +
                      'CURRENT_DATE, ' +
                      'ihStaff, ' +
                      'CURRENT_DATE, ' +
                      '''1900-01-01 00:00:00'', ' +
                      'CURRENT_DATE, ' +
                      'ihCurrency, ' +
                      'ihCurrencyRate, ' +
                      'invRefrence, ' +
                      'TotalStayTax, ' +
                      'TotalStayTaxNights, ' +
                      'showPackage, ' +
                      'location, ' +
                      'staff, ' +
                      'NULL, ' +
                      'NULL, ' +
                      ''''' ' +
                      ' ' +
                      'FROM invoiceheads WHERE InvoiceNumber=%d', [Invoice]);
        CopyToClipboard(sql);
        lExecutionPlan.AddExec(sql);

        sql := format('UPDATE roomreservations rr, ' +
                      '       control c ' +
                      'Set AvrageRate=(SELECT SUM(RoomRate * Paid) FROM roomsdate rd WHERE rd.RoomReservation=rr.RoomReservation AND rd.ResFlag=rr.Status) ' +
                      IIF(hasRooms, ', InvoiceIndex=' + inttostr(SelectedInvoiceIndex), '') + ' ' +
                      'WHERE RoomReservation IN (SELECT DISTINCT RoomReservationAlias FROM invoicelines WHERE InvoiceNumber=%d AND ItemId=c.RoomRentItem) ', [Invoice]);
        CopyToClipboard(sql);
        lExecutionPlan.AddExec(sql);

        sql := format('UPDATE roomsdate rd, ' +
                      '       control c ' +
                      'Set Paid=0 ' +
                      'WHERE RoomReservation IN (SELECT DISTINCT RoomReservationAlias FROM invoicelines WHERE InvoiceNumber=%d AND ItemId=c.RoomRentItem) ', [Invoice]);
        CopyToClipboard(sql);
        lExecutionPlan.AddExec(sql);

        lExecutionPlan.Execute(ptExec);

        if hasRooms then
        begin
          MessageDlg(format(GetTranslatedText('shTx_D_SaveToSpecifiedInvoiceIndex'), [SelectedInvoiceIndex + 1]), mtInformation, [mbOK], 0);
        end;

//        if RoomReservation = 0 then
//        begin
//          EditInvoice(reservation, 0, 0, 0, 0, 0, False, True, False);
//        end
//        else
//        begin
//          // This is not groupinvoice
//          EditInvoice(reservation, RoomReservation, 0, 0, 0, 0, False, True, False);
//        end;

      finally
        lExecutionPlan.Free;
      end;
  end;
end;

function Td.colorCodeOfStatus(status: String): TColor;
var
  i, iColor: Integer;
begin
  result := clWhite;
  for i := 0 to lstMaintenanceCodes.Count - 1 do
    if lstMaintenanceCodes[i].Key = status then
    begin
      iColor := strtoint(lstMaintenanceCodes[i].Value);
      result := TColor(iColor);
      exit;
    end;
end;

/// ******************************************
// Customer Table
/// ******************************************

function Td.GetCustomerCurrency(sCustomer: string): string;
begin
  // DOOPT
  result := '';
  if glb.CustomersSet.locate('customer', sCustomer, [loCaseInsensitive]) then
  begin
    result := glb.CustomersSet.FieldByName('Currency').Asstring;
  end;

end;

function Td.qryGetMaidActions(Orderstr: string): string;
begin
  result := format(select_qryGetMaidActions, [Orderstr]);
end;

function Td.OpenMaidActionsQuery(var SortField, SortDir: string): boolean;
begin
  zMaidActionsFilter := '';

  if MaidActions_.Active then
    MaidActions_.Close;

  MaidActions_.CommandText := qryGetMaidActions(SortField + ' ' + SortDir);
  try
    MaidActions_.Open;
  except
    showmessage(GetTranslatedText('shTx_D_MaidActionsUnavailable'));
  end;
  result := True;
end;

function Td.Del_MaidActionByMaidAction(sAction: string): boolean;
var
  s: string;
begin
  result := True;
  s := '';
  s := s + 'DELETE ' + chr(10);
  s := s + 'FROM tblmaidactions ' + chr(10);
  s := s + 'WHERE  ' + chr(10);
  s := s + '(maAction =' + _db(sAction) + ') ' + chr(10);
  if not cmd_bySQL(s) then
  begin
    result := False;
  end;
end;

function Td.MaidActionExist(sCode: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_MaidActionExist, [_db(sCode)]);
    hData.rSet_bySQL(rSet, s);
    result := not rSet.eof;
  finally
    freeandnil(rSet);
  end;
end;

function Td.qryGetTelPriceGroups(Orderstr: string): string;
begin
  result := format(select_qryGetTelPriceGroups, [Orderstr]);
end;

function Td.OpenTelPriceGroupsQuery(var SortField, SortDir: string): boolean;
var
  s: string;
begin
  zTelPriceGroupsFilter := '';
  s := qryGetTelPriceGroups(SortField + ' ' + SortDir);
  result := hData.rSet_bySQL(telPriceGroups_, s);
end;

function Td.GET_telPriceGroupsName_byCode(Code: string): string;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := '';
  rSet := CreateNewDataSet;
  try
    s := format(select_GET_telPriceGroupsName_byCode, [_db(Code)]);
    hData.rSet_bySQL(rSet, s);
    result := trim(rSet.FieldByName('Description').Asstring);
  finally
    freeandnil(rSet);
  end;
end;

function Td.Del_PriceGroupByCode(Code: string): boolean;
var
  s: string;
begin
  result := True;
  s := '';
  s := s + 'DELETE ' + chr(10);
  s := s + 'FROM telpricegroups ' + chr(10);
  s := s + 'WHERE  ' + chr(10);
  s := s + '(Code =' + _db(Code) + ') ' + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

function Td.PriceGroupExist(Code: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_PriceGroupExist, [_db(Code)]);
    hData.rSet_bySQL(rSet, s);
    result := not rSet.eof;
  finally
    freeandnil(rSet);
  end;
end;

/// ******************************************
// PriceRule Table
/// ******************************************

function Td.qryGetTelPriceRules(Orderstr: string): string;
begin
  result := format(select_qryGetTelPriceRules, [Orderstr]);
end;

function Td.OpenTelPriceRulesQuery(var SortField, SortDir: string): boolean;
var
  s: string;
begin
  zTelPriceRulesFilter := '';
  s := qryGetTelPriceRules(SortField + ' ' + SortDir);
  result := hData.rSet_bySQL(telPriceRules_, s);
end;

function Td.GET_telPriceRulesName_byCode(Code: string): string;
var
  s: string;
  rCount: Integer;
  rSet: TRoomerDataSet;
begin
  result := '';
  rSet := CreateNewDataSet;
  try
    s := format(select_GET_telPriceRulesName_byCode, [_db(Code)]);
    hData.rSet_bySQL(rSet, s);
    rCount := rSet.recordcount;
    if rCount > 0 then
    begin
      result := trim(rSet.FieldByName('Description').Asstring);
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.Del_PriceRuleByCode(Code: string): boolean;
var
  s: string;
begin
  result := True;
  s := '';
  s := s + 'DELETE ' + chr(10);
  s := s + 'FROM telpricerules ' + chr(10);
  s := s + 'WHERE  ' + chr(10);
  s := s + '(Code =' + _db(Code) + ') ' + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

function Td.PriceRuleExist(Code: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_PriceRuleExist, [_db(Code)]);
    hData.rSet_bySQL(rSet, s);
    result := not rSet.eof;
  finally
    freeandnil(rSet);
  end;
end;

/// ******************************************
// GetTblInc Table
/// ******************************************

function Td.getTblINC_nextCustomerNumber: string;
var
  s: string;
  ch: char;
  iCustLast: Integer;
  iCustlength: Integer;
  sCustFill: string;
  sCustLast: string;
  rSet: TRoomerDataSet;
begin
  ch := '0';
  result := '';

  rSet := CreateNewDataSet;
  try
    s := format(select_getTblINC_nextCustomerNumber, []);
    if hData.rSet_bySQL(rSet, s) then
    begin
      iCustLast := rSet.FieldByName('custlast').AsInteger;
      iCustlength := rSet.FieldByName('custLength').AsInteger;
      sCustFill := rSet.FieldByName('custFill').Asstring;

      iCustLast := iCustLast + 1;
      if length(sCustFill) > 0 then
        ch := sCustFill[1]
      else
        sCustFill := '0';

      sCustLast := inttostr(iCustLast);

      result := _strPadChL(sCustLast, ch, iCustlength);

      rSet.edit;
      rSet.FieldByName('custlast').AsInteger := iCustLast;
      rSet.post; // ID ADDED
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.getTblINC_Last: Integer;
var
  s: string;
  iCustLast: Integer;
  rSet: TRoomerDataSet;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    s := format(select_getTblINC_Last, []);
    if hData.rSet_bySQL(rSet, s) then
    begin
      iCustLast := rSet.FieldByName('custlast').AsInteger;
      result := iCustLast;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.getTblINC_Length: Integer;
var
  s: string;
  iCustlength: Integer;
  rSet: TRoomerDataSet;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    s := format(select_getTblINC_Length, []);
    if hData.rSet_bySQL(rSet, s) then
    begin
      iCustlength := rSet.FieldByName('custLength').AsInteger;
      result := iCustlength;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.getTblINC_Fill: string;
var
  s: string;
  sCustFill: string;
  rSet: TRoomerDataSet;
begin
  result := '0';
  rSet := CreateNewDataSet;
  try
    s := format(select_getTblINC_Fill, []);
    if hData.rSet_bySQL(rSet, s) then
    begin
      sCustFill := rSet.FieldByName('custFill').Asstring;
      if length(sCustFill) > 0 then
        result := sCustFill[1]
      else
        result := '0';
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.GET_CustomerTypesDescription_byCustomerType(CustomerType: string): string;
begin
  result := '';
  if glb.CustomertypesSet.locate('CustomerType', CustomerType, [loCaseInsensitive]) then
  begin
    result := glb.CustomertypesSet.FieldByName('description').Asstring;
  end;
end;

function Td.GET_RoomsDescription_byRoom(sRoom: string): string;
begin
  result := '';
  if glb.LocateRoom(sRoom) then
    result := glb.RoomsSet['description'];
end;

function Td.RoomExists(sRoom: string): Integer;
begin
  result := ABS(ORD(glb.LocateRoom(sRoom)));
end;

function Td.RoomExists_InRoomReservation(sRoom: string): Integer;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_RoomExists_InRoomReservation, [_db(sRoom)]);
    hData.rSet_bySQL(rSet, s);
    result := rSet.recordcount;
  finally
    freeandnil(rSet);
  end;
end;

function Td.isMixedStatus(reservation: Integer): string;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := '';

  s := '';
  s := s + 'SELECT distinct resflag from roomsdate where reservation=%d ';

  rSet := CreateNewDataSet;
  try
    s := format(s, [reservation]);
    hData.rSet_bySQL(rSet, s);
    if rSet.recordcount = 1 then
      result := rSet.FieldByName('resflag').Asstring;
  finally
    freeandnil(rSet);
  end;
end;

function Td.isMixedBreakfast(reservation: Integer): string;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := 'MIXED';

  s := '';
  s := s + 'SELECT distinct invBreakfast from roomreservations where reservation=%d ';

  rSet := CreateNewDataSet;
  try
    s := format(s, [reservation]);
    hData.rSet_bySQL(rSet, s);
    if rSet.recordcount = 1 then
      result := _bool2str(rSet.FieldByName('invBreakfast').asBoolean, 0);
  finally
    freeandnil(rSet);
  end;

end;

function Td.isMixedPaymentDetails(reservation: Integer): string;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := 'MIXED';
  s := '';
  s := s + 'SELECT distinct Groupaccount from roomreservations where reservation=%d ';

  rSet := CreateNewDataSet;
  try
    s := format(s, [reservation]);
    hData.rSet_bySQL(rSet, s);
    if rSet.recordcount = 1 then
      result := _bool2str(rSet.FieldByName('Groupaccount').asBoolean, 0);
  finally
    freeandnil(rSet);
  end;
end;

function Td.isGroup(RoomReservation: Integer): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  s := '';
  s := s + 'SELECT Groupaccount from roomreservations where roomreservation=%d ';

  rSet := CreateNewDataSet;
  try
    s := format(s, [RoomReservation]);
    hData.rSet_bySQL(rSet, s);
    result := rSet.FieldByName('Groupaccount').asBoolean;
  finally
    freeandnil(rSet);
  end;
end;

function Td.GetReservationLocations(reservation: Integer; var lst: tstringList): Integer;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  s := '';
  s := s + 'Select DISTINCT '#10;
  s := s + '   rv.reservation '#10;
  s := s + '  , (SELECT Location FROM roomtypes WHERE Roomtype=rr.Roomtype) AS Location '#10;
  s := s + ' FROM '#10;
  s := s + '  reservations rv '#10;
  s := s + '  INNER JOIN roomreservations rr ON rr.Reservation=rv.Reservation '#10;
  s := s + ' WHERE '#10;
  s := s + '  rv.reservation=' + _db(reservation) + ' '#10;

  // copytoclipboard(s);
  // debugmessage(s);

  rSet := CreateNewDataSet;
  try
    if hData.rSet_bySQL(rSet, s) then
    begin
      while not rSet.eof do
      begin
        lst.Add(rSet.FieldByName('location').Asstring);
        rSet.next;
      end;
    end;
    result := lst.Count;
  finally
    freeandnil(rSet);
  end;
end;

function Td.GetRoomReservationLocations(RoomReservation: Integer; var lst: tstringList): Integer;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  s := '';
  s := s + 'Select '#10;
  s := s + '    rr.roomreservation '#10;
  s := s + '   ,rr.Room '#10;
  s := s + '   ,rr.Roomtype '#10;
  s := s + '   ,rt.location '#10;
  s := s + ' FROM '#10;
  s := s + '  roomreservations rr '#10;
  s := s + '  INNER JOIN roomtypes rt ON rt.Roomtype=rr.Roomtype '#10;
  s := s + ' WHERE '#10;
  s := s + '  rr.roomreservation=' + _db(RoomReservation) + ' '#10;

  rSet := CreateNewDataSet;
  try
    if hData.rSet_bySQL(rSet, s) then
    begin
      while not rSet.eof do
      begin
        lst.Add(rSet.FieldByName('location').Asstring);
        rSet.next;
      end;
    end;
    result := lst.Count;
  finally
    freeandnil(rSet);
  end;
end;

function Td.GET_roomstatus(sRoom: string): char;
var
  s: string;
  sTmp: string;
  rSet: TRoomerDataSet;
begin
  result := 'C';
  rSet := CreateNewDataSet;
  try
    s := format(select_GET_roomstatus, [_db(sRoom)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      sTmp := rSet.FieldByName('status').Asstring;
      if length(sTmp) > 0 then
        result := sTmp[1];
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.GET_RoomTypeGroupDescription_byRoomTypeGroup(sRoomTypeGroup: string): string;
begin
  result := '';
  if glb.LocateRoomTypeGroup(sRoomTypeGroup) then
    result := glb.RoomTypeGroups['Description'];
end;

function Td.Del_RoomTypeByRoomType(sRoomType: string): boolean;
var
  s: string;
begin
  result := True;

  if RoomTypeExistsInOther(sRoomType) then
  begin
    showmessage(format(GetTranslatedText('shTx_D_TableUsingCannotDelete'), [sRoomType]));
    result := False;
    exit
  end;

  s := '';
  s := s + 'DELETE ' + chr(10);
  s := s + 'FROM roomtypes ' + chr(10);
  s := s + 'WHERE  ' + chr(10);
  s := s + '(RoomType =' + _db(sRoomType) + ') ' + chr(10);
  if not cmd_bySQL(s) then
  begin
    result := False;
  end;
end;

function Td.Del_RoomTypeGroupByRoomTypeGroup(sRoomTypeGroup: string): boolean;
var
  s: string;
begin
  result := True;

  if RoomTypeGroupExistsInOther(sRoomTypeGroup) then
  begin
    showmessage(format(GetTranslatedText('shTx_D_TableUsingCannotDelete'), [sRoomTypeGroup]));
    result := False;
    exit
  end;

  s := '';
  s := s + 'DELETE ' + chr(10);
  s := s + 'FROM roomtypegroups ' + chr(10);
  s := s + 'WHERE  ' + chr(10);
  s := s + '(Code =' + _db(sRoomTypeGroup) + ') ' + chr(10);
  if not cmd_bySQL(s) then
  begin
    result := False;
  end;
end;

procedure Td.RoomTypes_NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('NumberGuests').AsInteger := 1;
  DataSet.FieldByName('Webable').asBoolean := True;
end;

function Td.RoomTypeExistsInOther(sRoomType: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := True;
  rSet := CreateNewDataSet;
  try
    s := format(select_RoomTypeExistsInRooms, [_db(sRoomType)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      exit;
    end;
  finally
    freeandnil(rSet);
  end;
  result := False;
end;

function Td.RoomTypeGroupExistsInOther(sRoomTypeGroup: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_RoomTypeGroupExistsInOther, [_db(sRoomTypeGroup)]);
    result := hData.rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function Td.RoomTypeExists(sRoomType: string): boolean;
begin
  result := glb.LocateRoomType(sRoomType);
end;

function Td.RoomTypeGroupExists(sRoomTypeGroup: string): boolean;
begin
  result := glb.LocateRoomTypeGroup(sRoomTypeGroup);
end;

function Td.getRoomText(sRoom: string): string;
var
  s: string;
  iRoomIndex: Integer;
  RoomItem: TRoomItem;
  StatusColor: TColor;
begin
  s := ''; // '<body bgcolor="#808080"><font color="#FFFFFF">';
  s := s + '<b><shad>' + GetTranslatedText('shRoomInformation') + '</shad></b><br>';
  if copy(sRoom, 1, 1) = '<' then
  begin
    s := s + '<br><b>' + GetTranslatedText('shRoomNotAssignedYet') + '</b>';
  end
  else
    if LocateWRoom(sRoom) then
  begin
    s := s + '<b>' + GetTranslatedText('shRoom') + ' : <font ' +
      GetHTMLColor(frmMain.sSkinManager1.GetHighLightColor(True), True) + ' ' +
      GetHTMLColor(frmMain.sSkinManager1.GetHighLightFontColor(True), False) + '>' +
      sRoom + '</font></b>' + #13;
    s := s + GetTranslatedText('shTx_Description') + ' : ' + wRooms_.FieldByName('roDescription').Asstring + #13;
    s := s + GetTranslatedText('shType') + ' : ' + wRooms_.FieldByName('rtRoomTypeDescription').Asstring + #13;
    s := s + GetTranslatedText('shTx_Location') + ' : ' + wRooms_.FieldByName('rlDescription').Asstring + #13;
    s := s + GetTranslatedText('shTx_Floor') + ' : ' + wRooms_.FieldByName('floor').Asstring + #13;
    s := s + GetTranslatedText('shTx_NumGuests') + ' : ' + wRooms_.FieldByName('numberGuests').Asstring + #13;

    iRoomIndex := g.oRooms.FindRoomFromRoomNumber(sRoom);
    if iRoomIndex >= 0 then
    begin
      RoomItem := g.oRooms.RoomItemsList[iRoomIndex];
      StatusColor := d.colorCodeOfStatus(RoomItem.status);
      s := s + '<hr><br><b><shad>' + GetTranslatedText('shTx_Status') + ' : <font ' +
        GetHTMLColor(StatusColor, True) + ' ' +
        GetHTMLColor(clWhite, False) + '>' +
        RoomItem.StatusDescripton + '</font></shad></b>' + #13;

      if NOT RoomItem.ReportUser.IsEmpty then
        s := s + GetTranslatedText('shTx_ReportedBy') + ' : [' + RoomItem.ReportUser + '] ' +
          RoomItem.ReportUserName + #13;

      if NOT RoomItem.CleaningNotes.IsEmpty then
        s := s + '   * ' + GetTranslatedText('shTx_CleaningNotes') + ' : ' + RoomItem.CleaningNotes + #13;
      if NOT RoomItem.MaintenanceNotes.IsEmpty then
        s := s + '   * ' + GetTranslatedText('shTx_MaintenanceNotes') + ' : <font ' +
          GetHTMLColor(clBlue, True) + ' ' +
          GetHTMLColor(clWhite, False) + '>' +
          RoomItem.MaintenanceNotes + '</font>' + #13;
      if NOT RoomItem.LostAndFound.IsEmpty then
        s := s + '   * ' + GetTranslatedText('shTx_LostAndFount') + ' : <font ' +
          GetHTMLColor(clRed, True) + ' ' +
          GetHTMLColor(clWhite, False) + '>' +
          RoomItem.LostAndFound + '</font>' + #13;
    end;

    s := s + '<hr><br><b><shad>' + GetTranslatedText('shTx_Equipment') + ' : ' + '</shad></b>' + #13;
    s := s + '<b>' + wRooms_.FieldByName('Equipments').Asstring + '</b>' + #13;
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

    // s := s + '</body>';
  end;
  result := s;
end;

function Td.LocateWRoom(Room: String): boolean;
begin
  result := False;
  wRooms_.First;
  while not wRooms_.eof do
  begin
    if LowerCase(wRooms_['Room']) = LowerCase(Room) then
    begin
      result := True;
      Break;
    end;
    wRooms_.next;
  end;
end;

function Td.qryGetViewRooms(Orderstr: string): string;
begin
  // s := '';
  // s := s + 'SELECT '+chr(10);
  // s := s + '* '+chr(10);
  // s := s + 'FROM '+chr(10);
  // s := s + 'wRooms '+chr(10);
  // s := s + 'ORDER BY ' + Orderstr + ' '+chr(10);
  result := format(select_qryGetViewRooms, [Orderstr]);;
end;

function Td.OpenViewRoomsQuery(SortField, SortDir: string): boolean;
begin
  result := hData.rSet_bySQL(wRooms_, qryGetViewRooms(SortField));
end;


// **************************************************************
// Locations Table
//
// **************************************************************

function Td.GET_LocationDescription_byLocation(sLocation: string): string;
begin
  result := '';
  if glb.LocateLocation(sLocation) then
    result := glb.Locations['Description'];
end;

function Td.GET_Location_byLocationDescription(sDescription: string): string;
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

function Td.lstRR_CurrentlyCheckedIn(aDate: Tdate): tstringList;
var
  s: string;
  rSet: TRoomerDataSet;
  RoomReservation: Integer;
  sql: string;
begin
  result := tstringList.Create;
  rSet := CreateNewDataSet;
  try
    // **zxhj �arf ekki a� breyta h�r   //Checket ok

    sql :=
      ' SELECT ' +
      '    roomsdate.ADate ' +
      '   , roomsdate.Room ' +
      '   , roomsdate.RoomType ' +
      '   , roomsdate.RoomReservation ' +
      '   , roomsdate.Reservation ' +
      '   , roomsdate.ResFlag ' +
      '   , roomreservations.Arrival ' +
      '   , roomreservations.Departure ' +
      ' FROM ' +
      '   roomsdate INNER JOIN ' +
      '     roomreservations ON roomsdate.RoomReservation = roomreservations.RoomReservation ' +
      ' WHERE ' +
      '   ((roomsdate.ADate =  %s ) AND (roomsdate.ResFlag = ''G'' )) ' +
      ' OR ' +
      '   ((roomsdate.ADate =  %s ) AND (roomsdate.ResFlag = ''G'' )' +
      '   AND (roomreservations.Departure =  %s )) ';

    s := format(sql, [_DateToDBDate(aDate, True), _DateToDBDate(aDate - 1, True), _DateToDBDate(aDate, True)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      while not rSet.eof do
      begin
        RoomReservation := rSet.FieldByName('RoomReservation').AsInteger;
        result.Add(inttostr(RoomReservation));
        rSet.next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.isRrCurrentlyCheckedIn(RoomReservation: Integer): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
  aDate: Tdate;
  sql: string;
begin
  aDate := date;
  rSet := CreateNewDataSet;
  try
    // **zxhj �arf ekki a� breyta h�r  //  checked ok
    sql :=
      ' SELECT ' +
      '     roomsdate.ADate ' +
      '   , roomsdate.ResFlag ' +
      '   , roomreservations.Departure ' +
      ' FROM ' +
      '   roomsdate ' +
      '     INNER JOIN ' +
      '   roomreservations ON roomsdate.RoomReservation = roomreservations.RoomReservation ' +
      ' WHERE ' +
      '   (roomsdate.RoomReservation =  %d ) ' +
      '     AND (roomsdate.ADate =  %s ) ' +
      '     AND (roomsdate.ResFlag = ''G'' ) ' +
      '   OR ' +
      '   (roomsdate.RoomReservation = %d) ' +
      '     AND (roomsdate.ADate =  %s ) ' +
      '     AND (roomsdate.ResFlag =  ''G'' ) ' +
      '     AND (roomreservations.Departure =   %s ) ';

    s := format(sql, [RoomReservation, _DateToDBDate(aDate, True), RoomReservation, _DateToDBDate(aDate - 1, True),
      _DateToDBDate(aDate, True)]);
    result := hData.rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function Td.isResCurrentlyCheckedIn(reservation: Integer): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
  RoomReservation: Integer;
begin
  result := False;
  rSet := CreateNewDataSet;
  try
    s := format(select_isResCurrentlyCheckedIn, [reservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      while not rSet.eof do
      begin
        RoomReservation := rSet.FieldByName('RoomReservation').AsInteger;
        if isRrCurrentlyCheckedIn(RoomReservation) then //
        begin
          result := True;
          Break;
        end;
        rSet.next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;



// **************************************************************
// Paytypes Table
// **************************************************************

procedure Td.PayTypes_InitDoExport;
var
  s: string;
begin
  s := '';

  s := s + ' UPDATE paytypes ' + chr(10);
  s := s + '    SET ' + chr(10);
  s := s + '       [doExport] = 1 ' + chr(10);
  s := s + '  WHERE doExport IS NULL ' + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

procedure Td.Reservations_InitUseStayTax;
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE reservations ' + chr(10);
  s := s + '    SET ' + chr(10);
  s := s + '       [UseStayTax] = 1 ' + chr(10);
  s := s + '  WHERE useStayTax IS NULL ' + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;

  s := '';
  s := s + ' UPDATE roomreservations ' + chr(10);
  s := s + '    SET ' + chr(10);
  s := s + '       [UseStayTax] = 1 ' + chr(10);
  s := s + '  WHERE useStayTax IS NULL ' + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

function Td.PayTypes_isExport(sPaytype: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := True;

  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT doExport FROM paytypes '+chr(10);
    // s := s + ' WHERE (PayType = ' + _db(sPaytype) + ') '+chr(10);
    s := format(select_PayTypes_isExport, [_db(sPaytype)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet['doExport'];
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.invoice_isExport(invoiceNo: Integer): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := True;

  rSet := CreateNewDataSet;
  try
    s := format(select_invoice_isExport, [invoiceNo]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := False
    end;
  finally
    freeandnil(rSet);
  end;
end;


// **************************************************************
// ItemTypes Table
//
// **************************************************************

function Td.GET_ItemTypeDescription_byItemType(sItemType: string): string;
begin
  result := '';
  if glb.LocateItemType(sItemType) then
    result := glb.ItemTypes['Description'];
end;

function Td.ItemTypeExists(sItemType: string): boolean;
begin
  result := glb.LocateItemType(sItemType);
end;

function Td.ItemTypeExistsInOther(sItemType: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_ItemTypeExistsInOther, [_db(sItemType)]);
    result := hData.rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
  // s := '';
  // s := s + ' SELECT ItemType FROM [Items] '+chr(10);
  // s := s + ' WHERE (ItemType = ' + _db(sItemType) + ') '+chr(10);
end;

function Td.Del_ItemTypeByItemType(sItemType: string): boolean;
var
  s: string;
begin
  result := True;

  if ItemTypeExistsInOther(sItemType) then
  begin
    showmessage(format(GetTranslatedText('shTx_D_TableUsingCannotDelete'), [sItemType]));
    result := False;
    exit
  end;
  s := '';
  s := s + 'DELETE ' + chr(10);
  s := s + 'FROM itemtypes ' + chr(10);
  s := s + 'WHERE  ' + chr(10);
  s := s + '(ItemType =' + _db(sItemType) + ') ' + chr(10);
  if not cmd_bySQL(s) then
  begin
    result := False;
  end;
end;



// **************************************************************
// Items Table
//
// **************************************************************

function Td.qryGetItems(Orderstr: string): string;
begin
  // s := s + 'SELECT '+chr(10);
  // s := s + '* '+chr(10);
  // s := s + 'FROM '+chr(10);
  // s := s + 'Items '+chr(10);
  // s := s + 'ORDER BY ' + Orderstr + ' '+chr(10);
  result := format(select_qryGetItems, [Orderstr]);;
end;

function Td.OpenItemsQuery(var SortField, SortDir: string): boolean;
begin
  zItemsFilter := '';
  result := hData.rSet_bySQL(Items_, qryGetItems(SortField + ' ' + SortDir));
end;

function Td.Item_Get_AccountKey(sItem: string): string;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := '';
  rSet := CreateNewDataSet;
  try
    s := format(select_Item_Get_AccountKey, [_db(sItem)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := trim(rSet.FieldByName('AccountKey').Asstring);
    end;
  finally
    freeandnil(rSet);
  end;
  // s := '';
  // s := s + 'SELECT AccountKey '+chr(10);
  // s := s + 'FROM Items  '+chr(10);
  // s := s + 'WHERE  '+chr(10);
  // s := s + '(Item =' + _db(sItem) + ') '+chr(10);
end;

function Td.Item_ExistsInOther(sItem: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := False;
  rSet := CreateNewDataSet;
  try
    s := format(select_Item_ExistsInOther, [_db(sItem)]);
    if hData.rSet_bySQL(rSet, s) then
      exit;
    // s := s + ' SELECT BreakFastItem FROM [Control] '+chr(10);
    // s := s + ' WHERE (BreakFastItem = ' + _db(sItem) + ') '+chr(10);

    s := format(select_Item_ExistsInOther2, [_db(sItem)]);
    if hData.rSet_bySQL(rSet, s) then
      exit;
    // s := s + ' SELECT RoomRentItem FROM [Control] '+chr(10);
    // s := s + ' WHERE (RoomRentItem = ' + _db(sItem) + ') '+chr(10);

    s := format(select_Item_ExistsInOther3, [_db(sItem)]);
    if hData.rSet_bySQL(rSet, s) then
      exit;
    // s := s + ' SELECT PaymentItem FROM [Control] '+chr(10);
    // s := s + ' WHERE (PaymentItem = ' + _db(sItem) + ') '+chr(10);

    s := format(select_Item_ExistsInOther4, [_db(sItem)]);
    if hData.rSet_bySQL(rSet, s) then
      exit;
    // s := s + ' SELECT PhoneUseItem FROM [Control] '+chr(10);
    // s := s + ' WHERE (PhoneUseItem = ' + _db(sItem) + ') '+chr(10);

    s := format(select_Item_ExistsInOther5, [_db(sItem)]);
    if hData.rSet_bySQL(rSet, s) then
      exit;
    // s := s + ' SELECT DiscountItem FROM [Control] '+chr(10);
    // s := s + ' WHERE (DiscountItem = ' + _db(sItem) + ') '+chr(10);

    s := format(select_Item_ExistsInOther6, [_db(sItem)]);
    if hData.rSet_bySQL(rSet, s) then
      exit;
    // s := s + ' SELECT ItemId FROM [Invoicelines] '+chr(10);
    // s := s + ' WHERE (ItemID = ' + _db(sItem) + ') '+chr(10);

  finally
    freeandnil(rSet);
  end;
  result := True;
end;

function Td.Item_Del(sItem: string): boolean;
var
  s: string;
begin
  result := True;

  if Item_ExistsInOther(sItem) then
  begin
    showmessage(format(GetTranslatedText('shTx_D_TableUsingCannotDelete'), [sItem]));
    result := False;
    exit
  end;

  s := '';
  s := s + 'DELETE ' + chr(10);
  s := s + 'FROM items ' + chr(10);
  s := s + 'WHERE  ' + chr(10);
  s := s + '(Item =' + _db(sItem) + ') ' + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

function Td.Item_Get_Data(aItem: string): recItemPlusHolder;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  initItemPlusHolder(result);

  rSet := CreateNewDataSet;
  try
    s := format(select_Item_Get_Data, [_db(aItem)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      rSet.First;

      if not rSet.eof then
      begin
        result.AccountKey := rSet.FieldByName('AccountKey').Asstring;
        result.AccItemLink := rSet.FieldByName('AccItemLink').Asstring;
        result.Item := rSet.FieldByName('Item').Asstring;
        result.Description := rSet.FieldByName('ItemDescription').Asstring;
        result.Price := LocalFloatValue(rSet.FieldByName('Price').Asstring);
        result.Itemtype := rSet.FieldByName('Itemtype').Asstring;
        result.ItemTypeDescription := rSet.FieldByName('ItemTypeDescription').Asstring;
        result.VATCode := rSet.FieldByName('VATCode').Asstring;
        result.VATCodeDescription := rSet.FieldByName('VATCodeDescription').Asstring;
        result.VATPercentage := LocalFloatValue(rSet.FieldByName('VATPercentage').Asstring);
        result.VATformula := rSet.FieldByName('valueformula').asString;
        result.ItemKind := Item_GetKind(aItem)
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.GET_StaffMemberName_byInitials(sInitials: string): string;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := '';
  rSet := CreateNewDataSet;
  try
    s := format(select_GET_StaffMemberName_byInitials, [_db(sInitials)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := trim(rSet.FieldByName('Name').Asstring);
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.GET_StaffMemberPID_byInitials(sInitials: string): string;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := '';
  rSet := CreateNewDataSet;
  try
    s := format(select_GET_StaffMemberPID_byInitials, [_db(sInitials)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := trim(rSet.FieldByName('staffPID').Asstring);
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.Del_RoomPricesByID_1(Id: Integer): boolean;
var
  s: string;
begin
  result := True;

  s := '';
  s := s + 'DELETE ' + chr(10);
  s := s + 'FROM pricetypes ' + chr(10);
  s := s + 'WHERE  ' + chr(10);
  s := s + '(Id =' + inttostr(Id) + ') ' + chr(10);
  if not cmd_bySQL(s) then
  begin
    result := False;
  end;
end;

function Td.Get_LastRoomPriceID_1: Integer;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    s := format(select_Get_LastRoomPriceID_1, []);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('ID').AsInteger;
    end;
  finally
    freeandnil(rSet);
  end;
  // s := '';
  // s := s + 'SELECT '+chr(10);
  // s := s + 'ID '+chr(10);
  // s := s + 'FROM '+chr(10);
  // s := s + 'priceTypes '+chr(10);
  // s := s + 'ORDER BY ID DESC '+chr(10);
end;

function Td.getPrice_1(rtID: Integer; persons: Integer; var Code, RoomType, Currency: string): Double;
var
  s: string;

  ExtraPrice: Double;
  p1, p2, p3, p4, p5: Double;

  extraPersons: Double;
  rSet: TRoomerDataSet;
  priceCodeID: Integer;

begin

  rSet := CreateNewDataSet;
  try
    Code := '';
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

    // s := '';
    // s := s + ' SELECT '+chr(10);
    // s := s + '  ID '+chr(10);
    // s := s + ', Price1Person '+chr(10);
    // s := s + ', Price2Persons '+chr(10);
    // s := s + ', Price3Persons '+chr(10);
    // s := s + ', Price4Persons '+chr(10);
    // s := s + ', Price5Persons '+chr(10);
    // s := s + ', PriceExtraPerson '+chr(10);
    // s := s + ', PcID '+chr(10);
    // s := s + ', RoomType '+chr(10);
    // s := s + ', Currency '+chr(10);
    // s := s + ' FROM '+chr(10);
    // s := s + ' PriceTypes '+chr(10);
    // s := s + ' WHERE '+chr(10);
    // s := s + ' Id = ' + inttostr(rtID)+chr(10);
    s := format(select_getPrice_1, [rtID]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      ExtraPrice := rSet.GetFloatValue(rSet.FieldByName('PriceExtraPerson'));
      p1 := LocalFloatValue(rSet.FieldByName('Price1Person').Asstring);
      p2 := LocalFloatValue(rSet.FieldByName('Price2Persons').Asstring);
      p3 := LocalFloatValue(rSet.FieldByName('Price3Persons').Asstring);
      p4 := LocalFloatValue(rSet.FieldByName('Price4Persons').Asstring);
      p5 := LocalFloatValue(rSet.FieldByName('Price5Persons').Asstring);

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

      priceCodeID := rSet.FieldByName('PcId').AsInteger;
      Code := PriceCode_Code(priceCodeID);
      RoomType := rSet.FieldByName('RoomType').Asstring;
      Currency := rSet.FieldByName('Currency').Asstring;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.getPrice_2(rtID: Integer; persons: Integer): Double;
var
  s: string;

  ExtraPrice: Double;
  p1, p2, p3, p4, p5: Double;

  extraPersons: Double;

  rSet: TRoomerDataSet;

begin

  rSet := CreateNewDataSet;
  try
    extraPersons := persons - 5;

    if persons < 0 then
      persons := 0;

    result := 0;

    if persons < 1 then
    begin
      exit;
    end;

    // s := '';
    // s := s + ' SELECT '+chr(10);
    // s := s + '  ID '+chr(10);
    // s := s + ', Price1Person '+chr(10);
    // s := s + ', Price2Persons '+chr(10);
    // s := s + ', Price3Persons '+chr(10);
    // s := s + ', Price4Persons '+chr(10);
    // s := s + ', Price5Persons '+chr(10);
    // s := s + ', PriceExtraPerson '+chr(10);
    // s := s + ' FROM '+chr(10);
    // s := s + ' PriceTypes '+chr(10);
    // s := s + ' WHERE '+chr(10);
    // s := s + ' Id = ' + inttostr(rtID)+chr(10);

    s := format(select_getPrice_2, [rtID]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      ExtraPrice := LocalFloatValue(rSet.FieldByName('PriceExtraPerson').Asstring);
      p1 := LocalFloatValue(rSet.FieldByName('Price1Person').Asstring);
      p2 := LocalFloatValue(rSet.FieldByName('Price2Persons').Asstring);
      p3 := LocalFloatValue(rSet.FieldByName('Price3Persons').Asstring);
      p4 := LocalFloatValue(rSet.FieldByName('Price4Persons').Asstring);
      p5 := LocalFloatValue(rSet.FieldByName('Price5Persons').Asstring);

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
    freeandnil(rSet);
  end;
end;

function Td.getRackPriceID_1(seasonId: Integer; RoomType, Currency: string): Integer;
var
  s: string;
  RackPriceID: Integer;
  priceCodeID: Integer;
  rSet: TRoomerDataSet;
begin
  result := -1;
  RackPriceID := priceCode_RackID;
  rSet := CreateNewDataSet;
  try
    s := format(select_getRackPriceID_1, [seasonId, _db(RoomType), _db(Currency)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      rSet.First;
      while not rSet.eof do
      begin
        priceCodeID := rSet.FieldByName('pcID').AsInteger;
        if priceCodeID = RackPriceID then
        begin
          result := rSet.FieldByName('ID').AsInteger;
        end;
        rSet.next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
  // s := '';
  // s := s + 'SELECT '+chr(10);
  // s := s + 'pcID, '+chr(10);
  // s := s + 'seID, '+chr(10);
  // s := s + 'ID, '+chr(10);
  // s := s + 'RoomType, '+chr(10);
  // s := s + 'Currency, '+chr(10);
  // s := s + 'Description '+chr(10);
  // s := s + 'FROM '+chr(10);
  // s := s + 'priceTypes '+chr(10);
  // s := s + 'WHERE ' + chr(10)+chr(10);
  // s := s + '(seID = ' + inttostr(seasonId) + ') AND '+chr(10);
  // s := s + '(RoomType = ' + _db(RoomType) + ') AND '+chr(10);
  // s := s + '(Currency = ' + _db(Currency) + ') '+chr(10);
end;


// **************************************************************
// Seasons Table
// **************************************************************

function Td.SeasonExists_byID(seasonId: Integer): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_SeasonExists_byID, [seasonId]);
    result := hData.rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
  // s := s + 'SELECT ID '+chr(10);
  // s := s + 'FROM tblSeasons  '+chr(10);
  // s := s + 'WHERE  '+chr(10);
  // s := s + '(Id =' + inttostr(seasonId) + ') '+chr(10);
end;

function Td.GET_SeasonsDescription_bySeasonID(seasonId: Integer): string;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := '';
  rSet := CreateNewDataSet;
  try
    s := format(select_GET_SeasonsDescription_bySeasonID, [seasonId]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := trim(rSet.FieldByName('seDescription').Asstring);
    end;
  finally
    freeandnil(rSet);
  end;
  // s := '';
  // s := s + 'SELECT seDescription '+chr(10);
  // s := s + 'FROM tblSeasons  '+chr(10);
  // s := s + 'WHERE  '+chr(10);
  // s := s + '(Id =' + inttostr(seasonId) + ') '+chr(10);
end;

function Td.GET_SeasonsId_byDescription(seDescription: string): Integer;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := -1;
  rSet := CreateNewDataSet;
  try
    s := format(select_GET_SeasonsId_byDescription, [_db(seDescription)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('ID').AsInteger;
    end;
  finally
    freeandnil(rSet);
  end;
  // s := '';
  // s := s + 'SELECT ID '+chr(10);
  // s := s + 'FROM tblSeasons  '+chr(10);
  // s := s + 'WHERE  '+chr(10);
  // s := s + '(seDescription =' + _db(seDescription) + ') '+chr(10);

end;

function Td.GET_SeasonsDates_bySeasonID(seasonId: Integer; var seStartdate, seEndDate: TdateTime): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := False;
  seStartdate := 1;
  seEndDate := 1;

  rSet := CreateNewDataSet;
  try
    s := format(select_GET_SeasonsDates_bySeasonID, [seasonId]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := True;
      seStartdate := rSet.FieldByName('seStartDate').asDateTime;
      seEndDate := rSet.FieldByName('seEndDate').asDateTime;
    end;
  finally
    freeandnil(rSet);
  end;
  // s := s + 'SELECT '+chr(10);
  // s := s + 'seStartDate, '+chr(10);
  // s := s + 'seEndDate '+chr(10);
  // s := s + 'FROM tblSeasons  '+chr(10);
  // s := s + 'WHERE  '+chr(10);
  // s := s + '(Id =' + inttostr(seasonId) + ') '+chr(10);
end;

function Td.Del_SeasonByID(Id: Integer): boolean;
var
  s: string;
begin
  result := True;

  s := '';
  s := s + 'DELETE ' + chr(10);
  s := s + 'FROM tblseasons ' + chr(10);
  s := s + 'WHERE  ' + chr(10);
  s := s + '(Id =' + inttostr(Id) + ') ' + chr(10);
  if not cmd_bySQL(s) then
  begin
    result := False;
  end;
end;

function Td.SeasonExist(aDateFrom, aDateTo: TdateTime): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_SeasonExist, [_DateToDBDate(aDateFrom, True), _DateToDBDate(aDateTo, True)]);
    result := hData.rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
  // s := s + 'SELECT '+chr(10);
  // s := s + 'seStartDate, seEndDate '+chr(10);
  // s := s + 'FROM '+chr(10);
  // s := s + 'tblSeasons '+chr(10);
  // s := s + 'WHERE '+chr(10);
  // s := s + '(seStartDate = ' + _DateToDBDate(aDateFrom,true) + ') AND  (seEndDate = ' + _DateToDBDate(aDateTo,true) + ') '+chr(10);
end;

function Td.SeasonCount(aDate: TdateTime): Integer;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    s := format(select_SeasonCount, [_DateToDBDate(aDate, True), _DateToDBDate(aDate, True)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.recordcount;
    end;
  finally
    freeandnil(rSet);
  end;
  // s := s + 'SELECT '+chr(10);
  // s := s + 'seStartDate, seEndDate '+chr(10);
  // s := s + 'FROM '+chr(10);
  // s := s + 'tblSeasons '+chr(10);
  // s := s + 'WHERE '+chr(10);
  // s := s + '(seStartDate <= ' + _DateToDBDate(adate,true) + ') AND  (seEndDate >= ' + _DateToDBDate(adate,true) + ') '+chr(10);
end;

function Td.FindSeasonID(aDate: TdateTime): Integer;
var
  s: string;
  NightCount: Integer;
  MaxNights: Integer;
  dateFirst: TdateTime;
  dateLast: TdateTime;
  rSet: TRoomerDataSet;
begin
  result := -1;
  rSet := CreateNewDataSet;
  try
    s := format(select_FindSeasonID, [_DateToDBDate(aDate, True), _DateToDBDate(aDate, True)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      MaxNights := 0;
      while not rSet.eof do
      begin
        dateFirst := rSet.FieldByName('seStartDate').asDateTime;
        dateLast := rSet.FieldByName('seEndDate').asDateTime;
        NightCount := _NightsBetween(dateFirst, dateLast);
        if NightCount >= MaxNights then
        begin
          MaxNights := NightCount;
          result := rSet.FieldByName('Id').AsInteger;
        end;
        rSet.next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
  // s := s + 'SELECT '+chr(10);
  // s := s + '  seStartDate '+chr(10);
  // s := s + ' ,seEndDate '+chr(10);
  // s := s + ' ,ID '+chr(10);
  // s := s + 'FROM '+chr(10);
  // s := s + 'tblSeasons '+chr(10);
  // s := s + 'WHERE '+chr(10);
  // s := s + '(seStartDate <= ' + _DateToDBDate(adate,true) + ') AND  (seEndDate >= ' + _DateToDBDate(adate,true) + ') '+chr(10);
end;



// **************************************************************
// GetInvoiceLinesTmp Table
// **************************************************************

function Td.del_InvoiceLinesTmp(iRoomReservation: Integer): boolean;
var
  s: string;
begin
  result := True;
  s := '';
  s := s + 'DELETE ' + chr(10);
  s := s + 'FROM invoicelinestmp ' + chr(10);
  s := s + 'WHERE ' + chr(10);
  s := s + 'RoomReservation=' + inttostr(iRoomReservation) + ' ' + chr(10);
  if not cmd_bySQL(s) then
  begin
    result := False;
  end;

end;

function Td.InvoiceLinesTmp_exists(iRoomReservation: Integer): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_InvoiceLinesTmp_exists, [iRoomReservation]);
    result := hData.rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

/// /*********************

function Td.doLogin(login, password: string): boolean;
var
  s: string;
  newStafflang: Integer;
  rSet: TRoomerDataSet;
  sPath: String;
begin
  result := False;
  if NOT d.roomerMainDataSet.OfflineMode then
  begin
    rSet := CreateNewDataSet;
    try
      s := format(select_doLogin, [_db(login)]);
      if hData.rSet_bySQL(rSet, s) then
      begin
        rSet.First;
        if not rSet.eof then
        begin
          if (_trimlower(rSet.FieldByName('Initials').Asstring) = _trimlower(login)) and
            (trim(rSet.FieldByName('Password').Asstring) = password) then
          begin
            g.qUser := trim(rSet.FieldByName('Initials').Asstring);
            g.qUserName := trim(rSet.FieldByName('Name').Asstring);
            g.qUserPID := trim(rSet.FieldByName('StaffPID').Asstring);
            g.qUserType := trim(rSet.FieldByName('StaffType').Asstring);
            g.qHotelName := trim(rSet.FieldByName('CompanyName').Asstring);
            g.qUserPriv1 := rSet.FieldByName('Priv1').AsInteger;
            g.qUserPriv2 := rSet.FieldByName('Priv2').AsInteger;
            g.qUserPriv3 := rSet.FieldByName('Priv3').AsInteger;
            g.qUserPriv4 := rSet.FieldByName('Priv4').AsInteger;
            g.qUserPriv5 := rSet.FieldByName('Priv5').AsInteger;
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

            g.qStayd3pActive := rSet['stays3PId'] > 0;

            g.qRoomInvoiceRoomRentIndex := rSet['RoomInvoiceRoomRentIndex'];
            g.qRoomInvoicePosItemIndex := rSet['RoomInvoicePosItemIndex'];
            g.qGroupInvoiceRoomRentIndex := rSet['GroupInvoiceRoomRentIndex'];
            g.qGroupInvoicePosItemIndex := rSet['GroupInvoicePosItemIndex'];

            g.qDynamicRatesActive := rSet['DynamicRatesActive'];

            newStafflang := rSet.FieldByName('StaffLanguage').AsInteger;

            g.ChangeLang(newStafflang, False);
            // g.qUserLanguage := rSet.fieldbyname('StaffLanguage').asInteger;

            result := True;
          end;
        end;
      end;
    finally
      freeandnil(rSet);
    end;
  end
  else
  begin // Offline login

    sPath := glb.GetDataCacheLocation;
    rSet := d.roomerMainDataSet.ActivateNewDataset
      (ReadFromTextFile(TPath.Combine(sPath, format(RoomerTableFileName, ['staffmembers']))));
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

        newStafflang := rSet['StaffLanguage'];

        g.ChangeLang(newStafflang, False);
      end;
    finally
      rSet.Free;
    end;
  end;
end;

function Td.GetRoomReservatiaonArrival(RoomReservation: Integer): Tdate;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 1;

  rSet := CreateNewDataSet;
  try
    // s := '';
    // s := s + ' SELECT rrArrival '+chr(10);
    // s := s + ' FROM RoomReservations  '+chr(10);
    // s := s + ' WHERE Roomreservation =' + inttostr(RoomReservation) + ' '+chr(10);
    s := format(select_GetRoomReservatiaonArrival, [RoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('rrArrival').asDateTime;
      result := trunc(result);
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.NextRoomReservatiaon(Room: string; RoomReservation: Integer; noResDate: Tdate): Integer;
var
  rSet: TRoomerDataSet;
  s: string;
  ArrivalDate: Tdate;
  sDate: string;
  sql: string;
begin
  if RoomReservation > 1 then
  begin
    ArrivalDate := GetRoomReservatiaonArrival(RoomReservation);
    sDate := _DateToDBDate(ArrivalDate, False);
  end
  else
  begin
    sDate := _DateToDBDate(noResDate, False)
  end;
  result := 0;

  rSet := CreateNewDataSet;
  try
    sql :=
      ' SELECT DISTINCT ' +
      '     Room ' +
      '   , Adate ' +
      '   , RoomReservation ' +
      '   , Reservation ' +
      ' FROM ' +
      '   roomsdate ' +
      ' WHERE ' +
      '       (ADate >  %s )' +
      '   AND (Room =  %s )' +
      '   AND (RoomReservation <>  %d ) ' +
      '   AND (NOT ResFlag IN (''X'',''C'')) ' +
      ' ORDER BY Adate ' +
      ' LIMIT 1 ';

    s := format(sql, [_db(sDate), _db(Room), RoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('RoomReservation').AsInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.LastRoomReservatiaon(Room: string; RoomReservation: Integer; noResDate: Tdate): Integer;
var
  rSet: TRoomerDataSet;
  s: string;
  ArrivalDate: Tdate;
  sDate: string;
  sql: string;
begin
  if RoomReservation > 1 then
  begin
    ArrivalDate := GetRoomReservatiaonArrival(RoomReservation);
    sDate := _DateToDBDate(ArrivalDate, False);
  end
  else
  begin
    sDate := _DateToDBDate(noResDate, False)
  end;
  result := 0;

  rSet := CreateNewDataSet;
  try
    sql :=
      ' SELECT DISTINCT '#10 +
      '     Room '#10 +
      '   , Adate '#10 +
      '   , RoomReservation '#10 +
      '   , Reservation '#10 +
      ' FROM '#10 +
      '   roomsdate '#10 +
      ' WHERE '#10 +
      '       (ADate <  %s )'#10 + // zxhj breytti h�r var >
      '   AND (Room =  %s )'#10 +
      '   AND (RoomReservation <>  %d ) '#10 +
      '   AND (NOT ResFlag IN (''X'',''C'')) '#10 + // zxhj Added - checked ok
      ' ORDER BY Adate DESC '#10 +
      ' LIMIT 1 ';

    s := format(sql, [_db(sDate), _db(Room), RoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('RoomReservation').AsInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.UpdateExpectedCheckoutTime(aReservation, aRoomReservation: Integer; const aCheckoutTime: string): boolean;
var
  s: string;
  lTime: TdateTime;
begin
  result := aCheckoutTime.IsEmpty or TryStrToTime(aCheckoutTime, lTime);
  if result then
  begin
    s := '';
    s := s + 'UPDATE roomreservations ' + chr(10);
    s := s + 'Set' + chr(10);
    s := s + '  ExpectedCheckoutTime = ' + _db(TTime(lTime)) + chr(10);
    s := s + 'WHERE Reservation = ' + _db(aReservation) + chr(10);
    s := s + '  AND RoomReservation = ' + inttostr(aRoomReservation) + chr(10);
    result := cmd_bySQL(s);
  end;
end;

function Td.UpdateChildrenCount(aReservation, aRoomReservation: Integer; const aChildren: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'UPDATE roomreservations ' + chr(10);
  s := s + 'Set' + chr(10);
  s := s + '  numChildren= ' + _db(aChildren) + chr(10);
  s := s + 'WHERE Reservation = ' + _db(aReservation) + chr(10);
  s := s + '  AND RoomReservation = ' + inttostr(aRoomReservation) + chr(10);
  result := cmd_bySQL(s);
end;

function Td.UpdateInfantCount(aReservation, aRoomReservation: Integer; const aInfants: integer): boolean;
var
  s: string;
begin
  s := '';
  s := s + 'UPDATE roomreservations ' + chr(10);
  s := s + 'Set' + chr(10);
  s := s + '  numInfants = ' + _db(aInfants) + chr(10);
  s := s + 'WHERE Reservation = ' + _db(aReservation) + chr(10);
  s := s + '  AND RoomReservation = ' + inttostr(aRoomReservation) + chr(10);
  result := cmd_bySQL(s);
end;

function Td.UpdateExpectedTimeOfArrival(aReservation, aRoomReservation: Integer; const aTimeOfArrival: string): boolean;
var
  s: string;
  lTime: TDateTime;
begin
  result := aTimeOfArrival.IsEmpty or TryStrToTime(aTimeOfArrival, lTime);
  if result then
  begin
    s := '';
    s := s + 'UPDATE roomreservations ' + chr(10);
    s := s + 'Set' + chr(10);
    s := s + '  ExpectedTimeOfArrival = ' + _db(TTime(lTime)) + chr(10);
    s := s + 'WHERE Reservation = ' + _db(aReservation) + chr(10);
    s := s + '  AND RoomReservation = ' + inttostr(aRoomReservation) + chr(10);
    result := cmd_bySQL(s);
  end;
end;

function Td.UpdateReservationMarket(aReservation: Integer; aMarket: TReservationMarketType): boolean;
var
  b: TStringBuilder;
begin
  b := TStringBuilder.Create;
  try
    b.Append('UPDATE reservations ' + chr(10));
    b.Append('Set' + chr(10));
    b.Append('  market = ' + _db(aMarket.ToDBString) + chr(10));
    b.Append('WHERE Reservation = ' + _db(aReservation) + chr(10));
    result := cmd_bySQL(b.ToString);
  finally
    b.Free;
  end;
end;

procedure Td.UpdateBreakfastIncluted(reservation, RoomReservation: Integer; BreakfastIncluted: boolean);
var
  s: string;
begin
  s := '';
  s := s + 'UPDATE roomreservations ' + chr(10);
  s := s + 'Set' + chr(10);
  s := s + '  InvBreakfast = ' + _db(BreakfastIncluted) + chr(10);
  s := s + 'WHERE Reservation = ' + _db(reservation) + chr(10);
  if RoomReservation > 0 then
    s := s + '  AND RoomReservation = ' + inttostr(RoomReservation) + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

function Td.isAllRRSameCurrency(reservation: Integer): boolean;
// Eru allar Herbergisb�kanir � sama gjaldmi�li
var
  rSet: TRoomerDataSet;
  s: string;
  curr, tmp: string;
begin
  result := True;
  rSet := CreateNewDataSet;
  try
    // s := '';
    // s := s + 'SELECT Currency '+chr(10);
    // s := s + 'FROM RoomReservations '+chr(10);
    // s := s + 'WHERE Reservation = ' + inttostr(reservation)+chr(10);
    s := format(select_isAllRRSameCurrency, [reservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      curr := rSet.FieldByName('currency').Asstring;
      while not rSet.eof do
      begin
        tmp := rSet.FieldByName('currency').Asstring;
        if tmp <> curr then
          result := False;
        rSet.next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure Td.UpdateGroupAccountAll(reservation, RoomReservation, RoomReservationAlias: Integer; GroupAccount: boolean);
var
  s: string;
  ExecutionPlan: TRoomerExecutionPlan;
  AllOk: boolean;
begin
  if not isAllRRSameCurrency(reservation) then
  begin
    showmessage(GetTranslatedText('shTx_D_CurrencyCancel'));
    exit;
  end;
  AllOk := True;
  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  ExecutionPlan.BeginTransaction;
  try

    s := '';
    s := s + ' UPDATE roomreservations ' + chr(10);
    s := s + ' Set' + chr(10);
    s := s + ' GroupAccount = ' + _db(GroupAccount) + chr(10); // ATH var boolTostr
    s := s + ' WHERE Reservation = ' + inttostr(reservation) + chr(10);
    ExecutionPlan.AddExec(s);

    if GroupAccount then
    begin
      s := '';
      s := s + ' UPDATE invoicelines ' + chr(10);
      s := s + ' Set' + chr(10);
      s := s + ' Roomreservation = 0 ';
      s := s + ' WHERE (Reservation = ' + inttostr(reservation) + ') AND (isPackage=1) ';
      // copytoclipboard(s);
      // debugmessage(s);
      ExecutionPlan.AddExec(s);
    end
    else
    begin
      s := '';
      s := s + ' UPDATE invoicelines ' + chr(10);
      s := s + ' Set' + chr(10);
      s := s + ' Roomreservation =RoomreservationAlias ' + chr(10);
      s := s + ' WHERE (Reservation = ' + inttostr(reservation) + ') AND (isPackage=1) ';
      // copytoclipboard(s);
      // debugmessage(s);
      ExecutionPlan.AddExec(s);
    end;

    if ExecutionPlan.Execute(ptExec, False, False) then
    begin
      ExecutionPlan.CommitTransaction;
    end
    else
      raise Exception.Create(ExecutionPlan.ExecException);

  except
    on e: Exception do
    begin
      AllOk := False;
    end;
  end;

  freeandnil(ExecutionPlan);

  if AllOk then
  begin
    if GroupAccount then
    begin
      UpdPaymentsWhenChangingReservationToGroup(reservation, RoomReservation)
    end
    else
    begin
      UpdPaymentsWhenChangingReservationToRoom(reservation, RoomReservation)
    end;
  end;

end;

procedure Td.UpdateGroupAccountOne(reservation, RoomReservation, RoomReservationAlias: Integer; GroupAccount: boolean;
  InvoiceIndex: Integer = -1);
var
  s: string;
  ExecutionPlan: TRoomerExecutionPlan;
  AllOk: boolean;
begin
  if not isAllRRSameCurrency(reservation) then
  begin
    showmessage(GetTranslatedText('shTx_D_CurrencyCancel'));
    exit;
  end;
  AllOk := True;
  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  ExecutionPlan.BeginTransaction;
  try

    s := '';
    s := s + ' UPDATE roomreservations ' + chr(10);
    s := s + ' Set' + chr(10);
    s := s + ' GroupAccount = ' + _db(GroupAccount) + chr(10); // ATH var boolTostr
    if InvoiceIndex > -1 then
      s := s + ' , InvoiceIndex = ' + _db(InvoiceIndex) + chr(10); // ATH var boolTostr
    s := s + ' WHERE Reservation = ' + inttostr(reservation) + chr(10);
    s := s + ' AND roomreservation = ' + inttostr(RoomReservation) + chr(10);

    ExecutionPlan.AddExec(s);

    if GroupAccount then
    begin
      s := '';
      s := s + ' UPDATE invoicelines ' + chr(10);
      s := s + ' Set' + chr(10);
      s := s + ' Roomreservation = 0 ';
      s := s + ' WHERE (Reservation = ' + inttostr(reservation) + ') AND (isPackage=1) ';
      s := s + ' AND roomReservationAlias = ' + inttostr(RoomReservationAlias) + chr(10);
      // copytoclipboard(s);
      // debugmessage(s);
      ExecutionPlan.AddExec(s);
    end
    else
    begin
      s := '';
      s := s + ' UPDATE invoicelines ' + chr(10);
      s := s + ' Set' + chr(10);
      s := s + ' Roomreservation =RoomreservationAlias ' + chr(10);
      s := s + ' WHERE (Reservation = ' + inttostr(reservation) + ') AND (isPackage=1) ';
      s := s + ' AND roomReservationAlias = ' + inttostr(RoomReservationAlias) + chr(10);
      // copytoclipboard(s);
      // debugmessage(s);
      ExecutionPlan.AddExec(s);
    end;

    if ExecutionPlan.Execute(ptExec, False, False) then
    begin
      ExecutionPlan.CommitTransaction;
    end
    else
      raise Exception.Create(ExecutionPlan.ExecException);

  except
    on e: Exception do
    begin
      AllOk := False;
    end;
  end;

  freeandnil(ExecutionPlan);

  if AllOk AND (InvoiceIndex > -1) then
  begin
    if GroupAccount then
    begin
      UpdPaymentsWhenChangingReservationToGroup(reservation, RoomReservation)
    end
    else
    begin
      UpdPaymentsWhenChangingReservationToRoom(reservation, RoomReservation)
    end;
  end;
end;

procedure Td.UpdPaymentsWhenChangingReservationToGroup(reservation, RoomReservation: Integer);
var
  rSet: TRoomerDataSet;
  s: string;
  resList: string;
begin
  if RoomReservation = 0 then // Change all in reservation
  begin
    rSet := CreateNewDataSet;
    try
      s := '';
      s := s + '   SELECT '#10;
      s := s + '     pm.id '#10;
      s := s + '   , pm.invoiceNumber '#10;
      s := s + '   , pm.TypeIndex '#10;
      s := s + '   , rr.reservation '#10;
      s := s + '   , rr.roomreservation '#10;
      s := s + '   , rr.groupAccount '#10;
      s := s + ' FROM '#10;
      s := s + '   roomreservations rr '#10;
      s := s + '   LEFT OUTER JOIN payments pm ON pm.roomreservation = rr.roomreservation '#10;
      s := s + ' WHERE '#10;
      s := s + '   (rr.Groupaccount <> 0) '#10;
      s := s + '   AND (pm.typeIndex=1) '#10;
      s := s + '   AND (pm.invoicenumber=-1) '#10;
      s := s + '   AND (rr.reservation=' + _db(reservation) + ') ';

      if hData.rSet_bySQL(rSet, s) then
      begin
        resList := '';
        while not rSet.eof do
        begin
          resList := resList + inttostr(rSet.FieldByName('roomreservation').AsInteger) + ',';
          rSet.next;
        end;
        delete(resList, length(resList), 1);
      end;
    finally
      freeandnil(rSet);
    end;
  end
  else
  begin // just change one room
    resList := inttostr(RoomReservation);
  end;

  if resList <> '' then
  begin
    rSet := CreateNewDataSet;
    try
      s := '';
      s := s + ' SELECT '#10;
      s := s + '    pm.Reservation '#10;
      s := s + '   ,pm.RoomReservation '#10;
      s := s + '   ,pm.TypeIndex '#10;
      s := s + '   ,pm.InvoiceNumber '#10;
      s := s + '   ,date(pm.PayDate) AS payDate '#10;
      s := s + '   ,pm.Customer '#10;
      s := s + '   ,pm.PayType '#10;
      s := s + '   ,pm.Amount '#10;
      s := s + '   ,pm.Description '#10;
      s := s + '   ,pm.CurrencyRate '#10;
      s := s + '   ,pm.Currency '#10;
      s := s + '   ,pm.confirmDate '#10;
      s := s + '   ,pm.Notes '#10;
      s := s + '   ,pm.dtCreated '#10;
      s := s + '   ,pm.id '#10;
      s := s + '   ,rr.room '#10;
      s := s + '   ,' + format(Get_mainGuestname, ['pe', 'pe', 'pm', 'GuestName']) + #10;
      s := s + ' FROM '#10;
      s := s + '    payments pm '#10;
      s := s + '     INNER JOIN roomreservations rr ON pm.roomreservation = rr.roomreservation '#10;
      s := s + ' WHERE '#10;
      s := s + '   (pm.roomreservation in (' + resList + ')) '#10;

      if hData.rSet_bySQL(rSet, s) then
      begin
        while not rSet.eof do
        begin
          s := '';
          s := s + 'Move payment ' + rSet.FieldByName('Description').Asstring + ' '#10;
          s := s + 'To groupaccount '#10#10;
          s := s + 'Amount : ' + floattostr(rSet.FieldByName('Amount').asFloat) + ' '#10;
          s := s + 'Date : ' + dateTimeToStr(rSet.FieldByName('dtCreated').asDateTime) + ' '#10;;
          s := s + 'Room/Guest : ' + rSet.FieldByName('Room').Asstring + ' - ' + rSet.FieldByName('GuestName')
            .Asstring + ' '#10;

          if MessageDlg(s, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
          begin
            s := '';
            s := s + ' UPDATE payments ' + #10;
            s := s + ' SET ' + #10;
            s := s + '     roomreservation  = 0 ' + #10;
            s := s + ' WHERE ' + #10;
            s := s + '       (ID = ' + _db(rSet.FieldByName('id').AsInteger) + ') ' + #10;
            if cmd_bySQL(s) then
            begin
            end;
          end;
          rSet.next;
        end;
      end;
    finally
      freeandnil(rSet);
    end;
  end;
end;

procedure Td.UpdPaymentsWhenChangingReservationToRoom(reservation, RoomReservation: Integer);
var
  rSet: TRoomerDataSet;
  s: string;
begin
  // if roomreservation = 0 then exit;

  rSet := CreateNewDataSet;
  try
    s := '';
    s := s + ' SELECT '#10;
    s := s + '    pm.Reservation '#10;
    s := s + '   ,pm.RoomReservation '#10;
    s := s + '   ,pm.TypeIndex '#10;
    s := s + '   ,pm.InvoiceNumber '#10;
    s := s + '   ,date(pm.PayDate) AS payDate '#10;
    s := s + '   ,pm.Customer '#10;
    s := s + '   ,pm.PayType '#10;
    s := s + '   ,pm.Amount '#10;
    s := s + '   ,pm.Description '#10;
    s := s + '   ,pm.CurrencyRate '#10;
    s := s + '   ,pm.Currency '#10;
    s := s + '   ,pm.confirmDate '#10;
    s := s + '   ,pm.Notes '#10;
    s := s + '   ,pm.dtCreated '#10;
    s := s + '   ,pm.id '#10;
    s := s + ' FROM '#10;
    s := s + '    payments pm '#10;
    s := s + ' WHERE '#10;
    s := s + '   (pm.reservation) =' + _db(reservation) + ' AND (pm.roomreservation=0) '#10;

    if hData.rSet_bySQL(rSet, s) then
    begin
      showmessage('There are ' + inttostr(rSet.recordcount) +
        ' payments on Groupaccount - You can move it manually to room ');
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.GetBreakfastIncluted(reservation, RoomReservation: Integer): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := False;
  rSet := CreateNewDataSet;
  try
    // s := '';
    // s := s + ' SELECT InvBreakfast FROM RoomReservations '+chr(10);
    // s := s + ' WHERE Reservation = ' + inttostr(reservation)+chr(10);
    // s := s + ' AND RoomReservation = ' + inttostr(RoomReservation)+chr(10);
    s := format(select_GetBreakfastIncluted, [reservation, RoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet['InvBreakfast'];
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.GetGroupAccount(reservation, RoomReservation: Integer): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := False;
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT GroupAccount FROM RoomReservations '+chr(10);
    // s := s + ' WHERE Reservation = ' + inttostr(reservation)+chr(10);
    // s := s + ' AND RoomReservation = ' + inttostr(RoomReservation)+chr(10);
    s := format(select_GetGroupAccount, [reservation, RoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet['GroupAccount'];
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.OpenInvoiceInvoiceLines(reservation, RoomReservation: Integer): Integer;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := 0;

  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+chr(10);
    // s := s + ' COUNT(*) AS InvCount '+chr(10);
    // s := s + ' FROM [InvoiceLines]  '+chr(10);
    // s := s + ' WHERE (InvoiceNumber = -1) '+chr(10);
    // if reservation > 0 then
    // s := s + ' AND (Reservation = ' + inttostr(reservation) + ' ) '+chr(10);
    // if RoomReservation > 0 then
    // s := s + ' AND (RoomReservation = ' + inttostr(RoomReservation) + ' ) '+chr(10);

    s := select_OpenInvoiceInvoiceLines(reservation, RoomReservation);
    if reservation > 0 then
      s := format(s, [reservation, RoomReservation]);
    if RoomReservation > 0 then
      s := format(s, [RoomReservation]);

    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('InvCount').AsInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.NameOnOpenInvoice(reservation, RoomReservation: Integer): string;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := '<No Name>';

  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+chr(10);
    // s := s + ' Name '+chr(10);
    // s := s + ' FROM invoiceheads  '+chr(10);
    // s := s + ' WHERE (InvoiceNumber = -1) '+chr(10);
    // if reservation > 0 then
    // s := s + ' AND (Reservation = ' + inttostr(reservation) + ' ) '+chr(10);
    // if RoomReservation > 0 then
    // s := s + ' AND (RoomReservation = ' + inttostr(RoomReservation) + ' ) '+chr(10);
    s := select_NameOnOpenInvoice(reservation, RoomReservation);
    if reservation > 0 then
    begin
      s := format(s, [reservation, RoomReservation]);
    end
    else
      if RoomReservation > 0 then
    begin
      s := format(s, [RoomReservation]);
    end;
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('Name').Asstring;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.GetRoomList_Occupied(dtDateFrom, dtDateTo: Tdate; iRoomReservation: Integer; var lst: tstringList): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  lst.clear;

  s := '';
  s := s + '  SELECT '#10;
  s := s + '    DISTINCT Room '#10;
  s := s + '  FROM '#10;
  s := s + '     roomsdate '#10;
  s := s + '  WHERE '#10;
  s := s + '        (ADate >=  %s ) '#10;
  s := s + '    AND (ADate <  %s ) '#10;
  if iRoomReservation <> -1 then
  begin
    s := s + '    AND (RoomReservation <> %d ) ' + #10; // ' + inttostr(RoomReservation) + '
  end;
  s := s + '    AND (subString(Room,1,1) <> ''<'') ' + #10;
  s := s + '    AND (ResFlag <> ' + _db(STATUS_DELETED) + ' )'#10; // **zxhj l�nu b�tt vi�
  s := s + '  ORDER BY Room '#10;

  // s := select_GetRoomList_Occupied(iRoomreservation);
  s := format(s, [_DateToDBDate(dtDateFrom, True), _DateToDBDate(dtDateTo, True), iRoomReservation]);

  rSet := CreateNewDataSet;
  try
    if hData.rSet_bySQL(rSet, s) then
    begin
      while not rSet.eof do
      begin
        lst.Add(rSet.FieldByName('room').Asstring);
        rSet.next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
  result := lst.Count > 0;
end;

function Td.Occupied_fromTo(dtDateFrom, dtDateTo: Tdate; Room: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := False;
  s := '';
  s := s + '  SELECT '#10;
  s := s + '    Room '#10;
  s := s + '  FROM '#10;
  s := s + '     roomsdate '#10;
  s := s + '  WHERE '#10;
  s := s + '        (ADate >= ' + _db(dtDateFrom) + ' ) '#10;
  s := s + '    AND (ADate <  ' + _db(dtDateTo) + ' ) '#10;
  s := s + '    AND (ResFlag <> ' + _db(STATUS_DELETED) + ' )'#10;
  s := s + '    AND (Room = ' + _db(Room) + ' )'#10;

  copytoclipboard(s);

  rSet := CreateNewDataSet;
  try
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := True;
    end;
  finally
    freeandnil(rSet);
  end;
end;


// ------------------------------------------------------------------------------
//
//
// ------------------------------------------------------------------------------

function Td.isDay_Occupied(dtDate: Tdate; Room: string; var RoomReservation: Integer): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
  sql: string;
begin
  result := False;

  rSet := CreateNewDataSet;
  try
    sql :=
      '  SELECT '#10 +
      '    Room  '#10 +
      '  , ADate '#10 +
      '  , RoomReservation '#10 +

      '  FROM '#10 +
      '    roomsdate '#10 +
      '  WHERE ' +
      '        ((ADate =  %s ) '#10 +
      '    AND (Room =  %s )) '#10 +
      '   AND (ResFlag <> ' + _db(STATUS_DELETED) + ' ) '#10; // //**zxhj ATH

    s := format(sql, [_DateToDBDate(dtDate, True), _db(Room)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := True;
      RoomReservation := rSet.FieldByName('RoomReservation').AsInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RemoveRoomsDate(iRoomReservation: Integer): boolean;
var
  s: string;
begin
  result := True;
  // s := '';
  // s := s + ' delete FROM roomsdate '+chr(10);
  // s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation)+chr(10);

  // *zxhj Breytti status h�r � 'X'
  s := '';
  s := 'UPDATE roomsdate SET ResFlag =' + _db(STATUS_DELETED) + ' '#10;
  s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation) + chr(10);

  if not cmd_bySQL(s) then
  begin
    result := False;
  end;
end;

function Td.isAllDatesSameInRes(reservation: Integer): boolean;
// used 1
var
  rSet: TRoomerDataSet;
  s: string;
  Last: string;

begin
  result := True;
  rSet := CreateNewDataSet;
  try
    s := format(select_isAllDatesSameInRes, [reservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      Last := rSet.FieldByName('Arrival').Asstring + rSet.FieldByName('departure').Asstring;
      while not rSet.eof do
      begin
        s := rSet.FieldByName('Arrival').Asstring + rSet.FieldByName('departure').Asstring;
        if s <> Last then
        begin
          result := False;
          exit;
        end;
        Last := s;
        rSet.next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure Td.RemoveRoomReservation(RoomReservation: Integer; CancelStaff, CancelReason, CancelInformation: string;
  CancelType: Integer; doLog, useTrans, ask: boolean);
var
  rSet: TRoomerDataSet;
  s,
    sInvoices: string;
  doIt: boolean;
begin
  // Check if there is booked invoices for this roomreservation

  if ask then
  begin
    // doIt :=  MessageDlg('Delete room from reservation ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes;
    doIt := MessageDlg(GetTranslatedText('shTx_D_DeleteRoom'), mtConfirmation, [mbYes, mbNo], 0) = mrYes;
  end
  else
  begin
    doIt := True;
  end;

  if not doIt then
    exit;

  sInvoices := '';
  rSet := CreateNewDataSet;
  try
    s := format(select_RemoveRoomReservation, [RoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      s := '';
      while not rSet.eof do
      begin
        sInvoices := sInvoices + rSet.FieldByName('InvoiceNumber').Asstring + ', ';
        s := s + rSet.FieldByName('InvoiceNumber').Asstring + ', ';
        rSet.next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;

  if sInvoices <> '' then
  begin
    // if MessageDlg('B�ka�ir reikningar eru � �essari p�ntunn - Viltu h�tta vi� ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    if MessageDlg(GetTranslatedText('shTx_D_Cancel'), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      exit;
    end
    else
    begin
      showmessage(format(GetTranslatedText('shTx_D_InvoicesInDeletedBooking'), [sInvoices]));
    end;
  end;

  roomerMainDataSet.SystemRemoveRoomReservation(RoomReservation, True, doLog, CancelReason, g.qUser, CancelInformation,
    CancelType);
end;

procedure Td.SetAsNoRoomEnh(RoomReservation: Integer; AllReservations: boolean);
var
  NewRoom: string;
  sPrompt: string;
  rSet: TRoomerDataSet;
  s: string;
  reservation: Integer;
begin
  // sPrompt := 'Villtu �rugglega setja �etta �essa herbergjap�ntunn utan herbergja ?';
  sPrompt := GetTranslatedText('shTx_D_OrderConfirm');

  if AllReservations then
    // sPrompt := 'Viltu �rugglega setja �LL herbergi p�ntunnar ' + #13 + 'utan herbergja ?';
    sPrompt := GetTranslatedText('shTx_D_AllRoomsToNoRoom');

  if MessageDlg(sPrompt, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    roomerMainDataSet.SystemStartTransaction;
    try
      NewRoom := '';

      if AllReservations then
      begin
        reservation := RR_GetReservation(RoomReservation);
        rSet := CreateNewDataSet;
        try
          // s := '';
          // s := s + ' SELECT '+chr(10);
          // s := s + '    Roomreservation '+chr(10);
          // s := s + '  , Reservation '+chr(10);
          // s := s + ' FROM '+chr(10);
          // s := s + '   RoomReservations '+chr(10);
          // s := s + '  WHERE '+chr(10);
          // s := s + ' Reservation = ' + inttostr(reservation)+chr(10);
          s := format(select_SetAsNoRoomEnh, [reservation]);
          if hData.rSet_bySQL(rSet, s) then
          begin
            while not rSet.eof do
            begin
              RoomReservation := rSet.FieldByName('RoomReservation').AsInteger;
              SetAsNoRoom(RoomReservation);
              rSet.next;
            end;
          end;
        finally
          freeandnil(rSet);
        end;
      end
      else
      begin
        SetAsNoRoom(RoomReservation);
      end;
      roomerMainDataSet.SystemCommitTransaction;
    except
      roomerMainDataSet.SystemRollbackTransaction;
      raise;
    end;
  end;
end;

function Td.GetCustomerFromRes(aRes: Integer): string;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := '';

  // s := '';
  // s := s + '  SELECT ' + #10;
  // s := s + '     customer ' + #10;
  // s := s + '    ,reservation ';
  // s := s + '  FROM ' + #10;
  // s := s + '    reservations ' + #10;
  // s := s + '  WHERE ' + #10;
  // s := s + '        (Reservation=' + inttostr(aRes) + ') ' + #10;

  rSet := CreateNewDataSet;
  try
    s := format(select_GetCustomerFromRes, [aRes]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('customer').Asstring;
    end;
  finally
    freeandnil(rSet);
  end;
end;

// Get by invoicenumber
function Td.GetInvoiceCurrency(InvoiceNumber: Integer): string;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := ctrlGetString('NativeCurrency');

  rSet := CreateNewDataSet;
  try
    // s := '';
    // s := s + ' SELECT '+chr(10);
    // s := s + '    InvoiceNumber '+chr(10);
    // s := s + '   , ItemNumber '+chr(10);
    // s := s + '   , Currency '+chr(10);
    // s := s + ' FROM '+chr(10);
    // s := s + '   InvoiceLines '+chr(10);
    // s := s + ' WHERE '+chr(10);
    // s := s + '   (invoiceNumber = ' +_db(invoiceNumber) + ') '+chr(10);
    s := format(select_GetInvoiceCurrency, [InvoiceNumber]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('Currency').Asstring;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.GetInvoiceCurrencyAndReservationNumber(InvoiceNumber: Integer;
  var reservation, RoomReservation: Integer;
  var Room: String): string;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := ctrlGetString('NativeCurrency');

  rSet := CreateNewDataSet;
  try
    // s := '';
    // s := s + ' SELECT '+chr(10);
    // s := s + '    InvoiceNumber '+chr(10);
    // s := s + '   , ItemNumber '+chr(10);
    // s := s + '   , Currency '+chr(10);
    // s := s + ' FROM '+chr(10);
    // s := s + '   InvoiceLines '+chr(10);
    // s := s + ' WHERE '+chr(10);
    // s := s + '   (invoiceNumber = ' +_db(invoiceNumber) + ') '+chr(10);
    s := format(select_GetInvoiceCurrencyAndReservationIds, [InvoiceNumber]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('Currency').Asstring;
      Room := rSet['Room'];
      RoomReservation := rSet['RoomReservation'];
      reservation := rSet['Reservation'];
    end;
  finally
    freeandnil(rSet);
  end;
end;

Procedure Td.GetInvoiceCurrencyAndRate(InvoiceNumber: Integer; var Currency: string; var Rate: Double);
var
  rSet: TRoomerDataSet;
  s: string;
begin
  Currency := ctrlGetString('NativeCurrency');
  Rate := 1;

  rSet := CreateNewDataSet;
  try
    s := '';
    // s := s + ' SELECT '+chr(10);
    // s := s + '     InvoiceNumber '+chr(10);
    // s := s + '   , ItemNumber '+chr(10);
    // s := s + '   , Currency '+chr(10);
    // s := s + '   , ItemID '+chr(10);
    // s := s + '   , CurrencyRate '+chr(10);
    // s := s + ' FROM '+chr(10);
    // s := s + '   InvoiceLines '+chr(10);
    // s := s + ' WHERE '+chr(10);
    // s := s + '  (invoicenumber='+_Db(Invoicenumber)+') '+chr(10);
    s := format(select_GetInvoiceCurrencyAndRate, [InvoiceNumber]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      Currency := rSet.FieldByName('Currency').Asstring;
      Rate := LocalFloatValue(rSet.FieldByName('CurrencyRate').Asstring);
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure Td.AddPerson(iRoomReservation, iReservation: Integer; ciCustomerInfo: recCustomerHolderEX; sType: string;
  bTransaction: boolean);
var
  iLastPerson: Integer;
  s: string;
begin

  if bTransaction then
    roomerMainDataSet.SystemStartTransaction;
  try
    iLastPerson := PE_SetNewID();

    // SQL 315  xINSERT Persons
    s := '';
    s := s + 'INSERT into persons ' + chr(10);
    s := s + '(' + chr(10);
    s := s + '  Person ' + chr(10);
    s := s + ', RoomReservation ' + chr(10);
    s := s + ', Reservation ' + chr(10);
    s := s + ', SurName ' + chr(10);
    s := s + ', Name ' + chr(10);
    s := s + ', Address1 ' + chr(10);
    s := s + ', Address2 ' + chr(10);
    s := s + ', Address3 ' + chr(10);
    s := s + ', Address4 ' + chr(10);
    s := s + ', Country ' + chr(10);
    s := s + ', Company ' + chr(10);
    s := s + ', GuestType ' + chr(10);
    s := s + ', Information ' + chr(10);
    s := s + ' )' + chr(10);

    s := s + ' Values ' + chr(10);
    s := s + ' (' + chr(10);
    s := s + '  ' + inttostr(iLastPerson) + chr(10);
    s := s + ', ' + inttostr(iRoomReservation) + chr(10);
    s := s + ', ' + inttostr(iReservation) + chr(10);
    s := s + ', ' + _db(ciCustomerInfo.CustomerName) + chr(10);
    s := s + ', ' + _db(ciCustomerInfo.DisplayName) + chr(10);
    s := s + ', ' + _db(ciCustomerInfo.Address1) + chr(10);
    s := s + ', ' + _db(ciCustomerInfo.Address2) + chr(10);
    s := s + ', ' + _db(ciCustomerInfo.Address3) + chr(10);
    s := s + ', ' + _db(ciCustomerInfo.Address4) + chr(10);
    s := s + ', ' + _db(ciCustomerInfo.Country) + chr(10);
    s := s + ', ' + _db('') + chr(10);
    s := s + ', ' + _db(sType) + chr(10);
    s := s + ', ' + _db('') + chr(10);
    s := s + ' )' + chr(10);
    if not cmd_bySQL(s) then
    begin
    end;

    if bTransaction then
      roomerMainDataSet.SystemCommitTransaction;
  except
    if bTransaction then
      roomerMainDataSet.SystemRollbackTransaction;
    raise;
  end;
end;

procedure Td.RemovePerson(iRoomReservation: Integer; bTransaction: boolean);
var
  s: string;
  Id: Integer;
begin
  Id := RR_GetLastGuestID(iRoomReservation);

  if Id = 0 then
    exit;

  if bTransaction then
    roomerMainDataSet.SystemStartTransaction;
  try
    s := '';
    s := s + ' DELETE FROM persons ' + chr(10);
    s := s + ' WHERE Person=' + inttostr(Id) + ' ' + chr(10);

    if not cmd_bySQL(s) then
    begin
    end;
    if bTransaction then
      roomerMainDataSet.SystemCommitTransaction;
  except
    if bTransaction then
      roomerMainDataSet.SystemRollbackTransaction;
    raise;
  end;
end;

procedure Td.UpdateUsersLanguage(Staff: string; iLanguage: Integer);
var
  s: string;
begin
  s := '';
  s := s + 'UPDATE staffmembers ' + chr(10);
  s := s + '   set StaffLanguage = ' + inttostr(iLanguage) + chr(10);
  s := s + ' where Initials = ' + _db(Staff) + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

type
  TRoomInfoRecord = record
    RoomNumber: string;
    reservation, RoomReservation: Integer;
  end;

procedure Td.SetUnclean(Room: string);
var
  s: string;
begin
  if not ctrlGetBoolean('useSetUnclean') then
    exit;
  s := '';
  s := s + 'UPDATE rooms ' + chr(10);
  s := s + '   Set Status = ' + _db('U') + chr(10);
  s := s + ' where Room  = ' + _db(Room) + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

procedure Td.SetAllClean;
var
  s: string;
begin
  s := '';
  s := s + 'UPDATE rooms ' + chr(10);
  s := s + '   Set Status = ' + _db('C') + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

procedure Td.SetAllUnClean;
var
  s: string;
begin
  s := '';
  s := s + 'UPDATE rooms ' + chr(10);
  s := s + '   Set Status = ' + _db('U') + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

function Td.GetCustomerPreferences(CustomerID: string): string;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := '';

  rSet := CreateNewDataSet;
  try
    s := format(select_GetCustomerPreferences, [_db(CustomerID)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      with rSet do
      begin
        First;
        while not eof do
        begin
          result := result + '[' + trim(FieldByName('Description').Asstring) + ']' + #13#10 +
            trim(FieldByName('Preference').Text)
            + #13#10#13#10;
          next;
        end;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.GetCustomerName(customer: string): string;
begin
  result := '';

  result := '';
  if glb.CustomersSet.locate('customer', customer, [loCaseInsensitive]) then
  begin
    result := glb.CustomersSet.FieldByName('SurName').Asstring;
  end;

end;

function Td.GetRoomStatus(Room: string): char;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 'C';

  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+chr(10);
    // s := s + '   status '+chr(10);
    // s := s + ' FROM '+chr(10);
    // s := s + '   rooms '+chr(10);
    // s := s + ' WHERE '+chr(10);
    // s := s + '   room=' + _db(Room) + ' '+chr(10);
    s := format(select_GetRoomStatus, [_db(Room)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      if ANSIuppercase(rSet.FieldByName('Status').Asstring) = 'C' then
        result := 'C'
      else if ANSIuppercase(rSet.FieldByName('Status').Asstring) = 'U' then
        result := 'U'
      else if ANSIuppercase(rSet.FieldByName('Status').Asstring) = 'O' then
        result := 'O'
      else if ANSIuppercase(rSet.FieldByName('Status').Asstring) = '1' then
        result := '1'
      else if ANSIuppercase(rSet.FieldByName('Status').Asstring) = '2' then
        result := '2'
      else if ANSIuppercase(rSet.FieldByName('Status').Asstring) = '3' then
        result := '3'
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.AskApproval(PayType: string): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := False;
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT  '+chr(10);
    // s := s + '  AskCode '+chr(10);
    // s := s + ' FROM  '+chr(10);
    // s := s + '  PayTypes '+chr(10);
    // s := s + ' WHERE  '+chr(10);
    // s := s + '  PayType =' + _db(PayType) + ' '+chr(10);
    s := format(select_AskApproval, [_db(PayType)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet['AskCode'];
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.FieldExists(rSet: TRoomerDataSet; FieldName: String): boolean;
begin
  result := assigned(rSet.FindField(FieldName));
end;

function Td.VATDescription(Code: string): string;
begin
  result := '';
  try
    if LocateRecord(glb.Vat, 'VATCode', Code) then
      result := glb.Vat.FieldByName('description').Asstring;
  except
  end;
end;

function Td.VATvalueFormula(Code: string): String;
begin
  result := '';

  try
    if FieldExists(glb.Vat, 'valueFormula') AND
      LocateRecord(glb.Vat, 'VATCode', Code) then
      result := glb.Vat['valueFormula'];
  except
  end;
end;

function Td.PackageVATvalueFormula(package, Item: string; VATPercentage: Double): String;
var
  ItemID, packageId: Integer;
begin
  result := '';
  if LocateRecord(glb.Items, 'Item', Item) then
    try
      ItemID := glb.Items['id'];
      if FieldExists(glb.PackageItems, 'unitPriceVatFormula') then
      begin
        if LocateRecord(glb.Packages, 'package', package) then
        begin
          packageId := glb.Packages['id'];
          if LocateRecord(glb.PackageItems, 'packageId', packageId) then
            while NOT glb.PackageItems.eof do
            begin
              if (ItemID = glb.PackageItems['itemId']) AND (packageId = glb.PackageItems['packageId']) then
              begin
                result := glb.PackageItems['unitPriceVatFormula'];
                result := StringReplace(result, '{unitPrice}', floattostr(glb.PackageItems['unitPrice']),
                  [rfReplaceAll, rfIgnoreCase]);
                result := StringReplace(result, '{numItems}', floattostr(glb.PackageItems['numItems']),
                  [rfReplaceAll, rfIgnoreCase]);
                result := StringReplace(result, '{vat}', floattostr(VATPercentage), [rfReplaceAll, rfIgnoreCase]);
                Break;
              end;
              glb.PackageItems.next;
            end;
        end;
      end;
    except
    end;
end;

procedure Td.VATvalueFormulaAndPercentage(Code: String; package: String; Item: String; var Formula: string;
  var Percentage: Double);
var
  packageFormula: String;
begin
  Formula := '';
  packageFormula := '';
  Percentage := 0.00;

  try
    if LocateRecord(glb.Vat, 'VATCode', Code) then
    begin
      Percentage := LocalFloatValue(glb.Vat.FieldByName('VATPercentage').Asstring);
      if FieldExists(glb.Vat, 'valueFormula') then
        Formula := glb.Vat['valueFormula'];
      packageFormula := PackageVATvalueFormula(package, Item,
        LocalFloatValue(glb.Vat.FieldByName('VATPercentage').Asstring));
      if packageFormula <> '' then
        Formula := packageFormula;
    end;
  except
  end;
end;

function Td.VATPercentage(Code: string): Double;
begin
  result := 0.00;

  try
    if LocateRecord(glb.Vat, 'VATCode', Code) then
      result := LocalFloatValue(glb.Vat.FieldByName('VATPercentage').Asstring);
  except
  end;
end;

function Td.Item_Get_Type(Item: string): string;
begin
  result := '';
  glb.LocateSpecificRecordAndGetValue('items', 'Item', Item, 'ItemType', result);
end;

function Td.Item_Get_ItemTypeInfo(Item: string; package: String = ''): TItemTypeInfo;
var
  Itemtype: string;
  tmpStr: String;
  tmpDbl: Double;

begin
  fillchar(result, sizeof(result), 0);
  Itemtype := Item_Get_Type(Item);
  if glb.LocateSpecificRecord('itemtypes', 'Itemtype', Itemtype) then
  begin
    result.Itemtype := Itemtype; // trim(glb.ItemTypes.fieldbyname('ItemType').asString);
    result.Description := trim(glb.ItemTypes.FieldByName('Description').Asstring);
    result.Price := Item_GetPrice(Item);
    result.VATCode := trim(glb.ItemTypes.FieldByName('VATCode').Asstring);
    VATvalueFormulaAndPercentage(result.VATCode, package, Item, tmpStr, tmpDbl);
    result.VATPercentage := tmpDbl;
    result.valueFormula := tmpStr;
  end;
end;

function Td.StaffExists(Staff: string): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := False;
  rSet := CreateNewDataSet;
  try
    s := format(select_StaffExists, [_db(Staff)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := True;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.CustomerTypeName(CustomerTypeCode: string): string;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := '';
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+chr(10);
    // s := s + '   Description '+chr(10);
    // s := s + ' FROM '+chr(10);
    // s := s + '   CustomerTypes '+chr(10);
    // s := s + ' WHERE '+chr(10);
    // s := s + ' Customertype=' + _db(CustomerTypeCode) + ' '+chr(10);
    s := format(select_CustomerTypeName, [_db(CustomerTypeCode)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := trim(rSet.FieldByName('Description').Asstring);
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.SetInvoiceOrginalRef(Invoice, RoomReservation, OrginalRef: Integer): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := False;
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+chr(10);
    // s := s + '     RoomReservation '+chr(10);
    // s := s + '   , OriginalInvoice '+chr(10);
    // s := s + ' FROM '+chr(10);
    // s := s + '   InvoiceHeads '+chr(10);
    // s := s + ' WHERE '+chr(10);
    // s := s + '   (InvoiceNumber =' + inttostr(Invoice) + ' ) '+chr(10);
    // s := s + ' AND  (RoomReservation =' + inttostr(RoomReservation) + ' ) '+chr(10);
    s := format(select_SetInvoiceOrginalRef, [Invoice, RoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      rSet.edit;
      rSet.FieldByName('OriginalInvoice').AsInteger := OrginalRef;
      rSet.post; // ID ADDED
      result := True;
    end;
  finally
    freeandnil(rSet);
  end;
end;

/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////

function Td.qryGetRoomPrices_1(Orderstr: string; priceCodeID, seasonId: Integer; RoomType, Currency: string;
  seEndDate: TdateTime): string;
var
  s: string;
begin
  // ATH  EKKI H�GT !!!!!! CREATE FUNCTION
  s := '';
  s := s + 'SELECT ' + chr(10);
  s := s + '* ' + chr(10);
  s := s + 'FROM ' + chr(10);
  s := s + 'viewroomprices1 ' + chr(10);
  s := s + 'WHERE  ' + chr(10);
  s := s + '( (Id < 0) ' + chr(10); // just to start then AND sequance

  if priceCodeID > -1 then
    s := s + ' AND (pcID=' + inttostr(priceCodeID) + ') ' + chr(10);
  // ooOO T�mabilsAfm�rkunn BYRJAR
  if seasonId > -1 then
  begin // n�kv�mlega �kve�i� t�mabil
    s := s + ' AND (seID=' + inttostr(seasonId) + ') ' + chr(10);
  end
  else if seasonId = -2 then
  begin // n�verandi +
    s := s + ' AND (seEndDate>' + _DateToDBDate(date, True) + ') ' + chr(10);
  end
  else if seasonId = -3 then
  begin // N�verandi =
    s := s + ' AND ((seStartDate<=' + _DateToDBDate(date, True) + ') AND (seEndDate>' + _DateToDBDate(date + 1, True) +
      ')) ' + chr(10);
  end
  else if seasonId = -4 then
  begin // li�inn
    s := s + ' AND (seEndDate<' + _DateToDBDate(date + 1, True) + ') ' + chr(10);
  end
  else if seEndDate > 1 then //
  begin
    s := s + ' AND (seEndDate>' + _DateToDBDate(seEndDate, True) + ') ' + chr(10);
  end;
  // xxXX T�mabilsAfm�rkunn Endar

  if RoomType <> '' then
    s := s + ' AND (RoomType=' + _db(RoomType) + ') ' + chr(10);

  if Currency <> '' then
    s := s + ' AND (Currency=' + _db(Currency) + ') ' + chr(10);

  s := s + ' ) ' + chr(10);

  s := s + 'ORDER BY ' + Orderstr + ' ' + chr(10);

  result := s;

end;

function Td.OpenRoomPricesQuery_1(var SortField, SortDir: string; priceCodeID, seasonId: Integer;
  RoomType, Currency: string; seEndDate: TdateTime): boolean;
var
  extraSort: string;
begin
  // **
  extraSort := '';
  RoomType := trim(RoomType);
  Currency := trim(Currency);

  zRoomPricesFilter_1 := '';
  if viewRoomPrices1_.Active then
    viewRoomPrices1_.Close;
  if _trimlower(SortField) <> 'sestartdate' then
    extraSort := ', seStartDate ';
  viewRoomPrices1_.CommandText := qryGetRoomPrices_1(SortField + ' ' + SortDir + extraSort, priceCodeID, seasonId,
    RoomType, Currency,
    seEndDate);

  viewRoomPrices1_.Open;
  result := True;
end;

function Td.PriceExistsByCodes(pcCode, seDescription, RoomType, Currency: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_PriceExistsByCodes, [_db(pcCode), _db(seDescription), _db(RoomType), _db(Currency)]);
    result := hData.rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
  // s := s + 'SELECT '+chr(10);
  // s := s + 'pcCode, '+chr(10);
  // s := s + 'seDescription, '+chr(10);
  // s := s + 'RoomType, '+chr(10);
  // s := s + 'Currency '+chr(10);
  // s := s + 'FROM '+chr(10);
  // s := s + 'viewRoomPrices1 '+chr(10);
  // s := s + 'WHERE '+chr(10);
  // s := s + '(pcCode = ' + _db(pcCode) + ') AND '+chr(10);
  // s := s + '(seDescription = ' + _db(seDescription) + ') AND '+chr(10);
  // s := s + '(RoomType = ' + _db(RoomType) + ') AND '+chr(10);
  // s := s + '(Currency = ' + _db(Currency) + ') '+chr(10);
end;

function Td.PriceExistsByCodesAndCurrency(pcCode, Currency: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_PriceExistsByCodesAndCurrency, [_db(pcCode), _db(Currency)]);
    result := hData.rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
  // s := s + 'SELECT '+chr(10);
  // s := s + 'pcCode, '+chr(10);
  // s := s + 'Currency '+chr(10);
  // s := s + 'FROM '+chr(10);
  // s := s + 'viewRoomPrices1 '+chr(10);
  // s := s + 'WHERE '+chr(10);
  // s := s + '(pcCode = ' + _db(pcCode) + ') AND '+chr(10);
  // s := s + '(Currency = ' + _db(Currency) + ') '+chr(10);
end;

function Td.imPortLog_getLastID: Integer;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    // s := 'SELECT TOP(1)ID FROM tblImportLogs WHERE importResultID <> 10010 ';
    s := format(select_imPortLog_getLastID, []);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('ID').AsInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.imPortLog_InvoiceNumber: Integer;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    // s := s+'  SELECT TOP (1) '+chr(10);
    // s := s+'    ID '+chr(10);
    // s := s+'    ,invoiceNumber '+chr(10);
    // s := s+'  FROM '+chr(10);
    // s := s+'  tblPoxExport '+chr(10);
    s := format(select_imPortLog_InvoiceNumber, []);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('invoiceNumber').AsInteger;
      // ATH POST --> DELETE
      rSet.delete;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.imPortLog_isNewAvailable: boolean;
var
  Id: Integer;
begin
  result := False;
  Id := imPortLog_getLastID;
  if Id <> g.qLastImportLogID then
  begin
    result := True;
    g.qLastImportLogID := Id;
  end;
end;

function Td.inDateRange(seasonId: Integer; FromDate, ToDate: Tdate; var RangeStart, RangeEnd: Tdate): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
  i: Integer;

  startDate: Tdate;
  endDate: Tdate;

begin
  result := False;
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+chr(10);
    // s := s + '   ID '+chr(10);
    // s := s + ' ,  seStartDate '+chr(10);
    // s := s + ' ,  seEndDate '+chr(10);
    // s := s + ' FROM '+chr(10);
    // s := s + '   tblSeasons '+chr(10);
    // s := s + ' WHERE '+chr(10);
    // s := s + '  ID=' + inttostr(seasonId) + ' '+chr(10);
    s := format(select_inDateRange, [seasonId]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      startDate := trunc(rSet.FieldByName('seStartDate').asDateTime);
      endDate := trunc(rSet.FieldByName('seEndDate').asDateTime);
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
          result := True;
          Break;
        end;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RoomsTypeCount(CountAll: boolean): Integer;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 0;

  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT DISTINCT ROOMTYPE'+chr(10);
    // s := s + ' FROM Rooms '+chr(10);
    // if not CountAll then
    // begin
    // s := s + ' WHERE  '+chr(10);
    // s := s + ' (bookable = 1) '+chr(10);
    // end;
    if CountAll then
    begin
      s := format(select_RoomsTypeCount2, []);
    end
    else
    begin
      s := format(select_RoomsTypeCount, []);
    end;

    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.recordcount;
    end;
  finally
    freeandnil(rSet);
  end;
end;


// ******************************************************************************
//
//
// ******************************************************************************

function Td.isUnPaid(RoomReservation: Integer): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_isUnPaid, [RoomReservation]);
    result := hData.rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function Td.isUnPaidByRes(reservation: Integer): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_isUnPaidRes, [reservation]);
    result := hData.rSet_bySQL(rSet, s);
  finally
    freeandnil(rSet);
  end;
end;

function Td.GetRoomReservation(reservation: Integer; Room: string): Integer;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := 0;
  // s := s + '  SELECT ' + #10;
  // s := s + '     room ' + #10;
  // s := s + '    ,roomReservation ';
  // s := s + '    ,reservation ';
  // s := s + '  FROM ' + #10;
  // s := s + '    RoomReservations ' + #10;
  // s := s + '  WHERE ' + #10;
  // s := s + '        (Reservation=' + inttostr(reservation) + ') ' + #10;
  // s := s + '   And   (Room=' + _db(Room) + ') ' + #10;
  rSet := CreateNewDataSet;
  try
    s := format(select_GetRoomReservation, [reservation, _db(Room)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('RoomReservation').AsInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RemoveRoomReservationByReservation(iReservation: Integer): boolean;
var
  s: string;
begin
  result := True;
  s := '';
  s := s + ' DELETE FROM roomreservations ' + chr(10);
  s := s + ' WHERE Reservation = ' + inttostr(iReservation) + chr(10);
  if not cmd_bySQL(s) then
  begin
    result := False;
  end;
end;

function Td.RemoveInvoiceHeadsByReservation(iReservation: Integer): boolean;
var
  s: string;
begin
  result := True;
  s := '';
  s := s + ' DELETE FROM invoiceheads ' + chr(10);
  s := s + ' WHERE Reservation = ' + inttostr(iReservation) + chr(10);
  if not cmd_bySQL(s) then
  begin
    result := False;
  end

end;

function Td.RemoveInvoiceCashInvoice: boolean;
var
  s: string;
begin
  result := True;

  // ATHOLD 09112 Setja inn roolback

  s := '';
  s := s + ' DELETE FROM invoicelines ' + chr(10);
  s := s + ' WHERE (Reservation = 0) AND (RoomReservation = 0) AND (SplitNumber = 2) AND (InvoiceNumber = -1) '
    + chr(10);
  if not cmd_bySQL(s) then
  begin
    result := False;
  end;

  s := '';
  s := s + ' DELETE FROM invoiceheads ' + chr(10);
  s := s + ' WHERE (Reservation = 0) AND (RoomReservation = 0) AND (SplitNumber = 2) AND (InvoiceNumber = -1) '
    + chr(10);
  if not cmd_bySQL(s) then
  begin
    result := False;
  end;
end;

function Td.RemoveReservationsByReservation(iReservation: Integer): boolean;
var
  s: string;
begin
  result := True;
  s := '';
  s := s + ' DELETE FROM reservations ' + chr(10);
  s := s + ' WHERE Reservation = ' + inttostr(iReservation) + chr(10);
  if not cmd_bySQL(s) then
  begin
    result := False;
  end;
end;

function Td.Del_PaymentByInvoice(iNumber: Integer): boolean;
var
  s: string;
begin
  result := True;
  s := '';
  s := s + 'DELETE ' + chr(10);
  s := s + 'FROM payments ' + chr(10);
  s := s + 'WHERE  ' + chr(10);
  s := s + '(InvoiceNumber =' + inttostr(iNumber) + ') ' + chr(10);
  if not cmd_bySQL(s) then
  begin
    result := False;
  end;
end;

function dateTime2SQLdate(const dDate: TdateTime): string;
begin
  result := _db(FormatDateTime('mm"/"dd"/"yyyy hh:nn:ss', dDate));
end;

function Td.InsInvoiceAction(R: TInvoiceActionRec): boolean;
var
  s: string;
begin
  result := False;
  s := '';
  s := s + 'INSERT into tblinvoiceactions' + chr(10);
  s := s + '(' + chr(10);
  s := s + '  Reservation ' + chr(10);
  s := s + ', RoomReservation ' + chr(10);
  s := s + ', InvoiceNumber ' + chr(10);
  s := s + ', ActionDate ' + chr(10);
  s := s + ', ActionID ' + chr(10);
  s := s + ', Action ' + chr(10);
  s := s + ', ActionNote ' + chr(10);
  s := s + ', Staff ' + chr(10);
  s := s + ')' + chr(10);

  s := s + 'Values' + chr(10);
  s := s + '(' + chr(10);

  s := s + '  ' + inttostr(R.reservation) + chr(10);
  s := s + ', ' + inttostr(R.RoomReservation) + chr(10);
  s := s + ', ' + inttostr(R.InvoiceNumber) + chr(10);
  s := s + ', ' + _dateTimeToDBdate(R.ActionDate, True) + chr(10);
  s := s + ', ' + inttostr(R.actionID) + chr(10);
  s := s + ', ' + _db(R.Action) + chr(10);
  s := s + ', ' + _db(R.ActionNote) + chr(10);
  s := s + ', ' + _db(R.Staff) + chr(10);
  s := s + ')' + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

function Td.Del_MaidsJobsByDate(aDate: Tdate; All: boolean): boolean;
var
  s: string;
begin
  result := True;

  s := '';
  s := s + ' DELETE ' + chr(10);
  s := s + ' FROM tblmaidjobs ' + chr(10);
  s := s + ' WHERE  ' + chr(10);
  s := s + ' (mjDate = ' + _DateToDBDate(aDate, True) + ') ' + chr(10);
  if not All then
  begin
    s := s + ' AND (mjAction <> ' + _db('EXTRA') + ') ' + chr(10);
  end;

  if not cmd_bySQL(s) then
  begin
    result := False;
  end;
end;

procedure Td.DayNotes_BeforePost(DataSet: TDataSet);
begin
end;

///

function Td.getRoomTypeFromRR(RR: Integer): string;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := '';

  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT RoomType'+chr(10);
    // s := s + ' FROM RoomReservation '+chr(10);
    // s := s + ' WHERE  '+chr(10);
    // s := s + ' (RoomReservation = ' + inttostr(RR) + ' ) '+chr(10);
    s := format(select_getRoomTypeFromRR, [RR]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('RoomType').Asstring;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.getChangeAvailabilityInfo(RR: Integer; var RoomType, status: string; var Arrival, departure: Tdate)
  : boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := False;

  rSet := CreateNewDataSet;
  try
    s := s + ' SELECT Status,RoomType, rrArrival,rrDeparture' + chr(10);
    s := s + ' FROM roomreservations ' + chr(10);
    s := s + ' WHERE  ' + chr(10);
    s := s + ' (RoomReservation = ' + inttostr(RR) + ' ) ' + chr(10);
    s := format(s, [RR]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      RoomType := rSet.FieldByName('RoomType').Asstring;
      status := rSet.FieldByName('Status').Asstring;
      Arrival := rSet.FieldByName('rrArrival').asDateTime;
      departure := rSet.FieldByName('rrDeparture').asDateTime;
      result := True;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.getCountryGroupNameFromCountry(Country: string): string;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := '';
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+chr(10);
    // s := s + '     Countries.Country '+chr(10);
    // s := s + '   , CountryGroups.GroupName '+chr(10);
    // s := s + ' FROM '+chr(10);
    // s := s + '    Countries LEFT OUTER JOIN '+chr(10);
    // s := s + '      CountryGroups ON Countries.CountryGroup = CountryGroups.CountryGroup '+chr(10);
    // s := s + ' WHERE '+chr(10);
    // s := s + '   (Countries.Country = ' + _db(Country) + ') '+chr(10);
    s := format(select_getCountryGroupNameFromCountry, [_db(Country)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('GroupName').Asstring;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.getCountryFromReservation(reservation: Integer): string;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := '';

  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+chr(10);
    // s := s + '     Country '+chr(10);
    // s := s + ' FROM '+chr(10);
    // s := s + '  reservations '+chr(10);
    // s := s + ' WHERE '+chr(10);
    // s := s + '   (Reservation = ' + inttostr(reservation) + ') '+chr(10);
    s := format(select_getCountryFromReservation, [reservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('country').Asstring;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.getCountryGroupFromCountry(Country: string): string;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := '';

  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+chr(10);
    // s := s + '     Countries.Country '+chr(10);
    // s := s + '   , Countries.CountryGroup '+chr(10);
    // s := s + ' FROM '+chr(10);
    // s := s + '   Countries '+chr(10);
    // s := s + ' WHERE '+chr(10);
    // s := s + '   (Countries.Country = ' + _db(Country) + ') '+chr(10);
    s := format(select_getCountryGroupFromCountry, [_db(Country)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('CountryGroup').Asstring;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.getLocationFromRoom(Room: string): string;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := '';

  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+chr(10);
    // s := s + '     Rooms.Location '+chr(10);
    // s := s + ' FROM '+chr(10);
    // s := s + '   Rooms '+chr(10);
    // s := s + ' WHERE '+chr(10);
    // s := s + '   (Room = ' + _db(Room) + ') '+chr(10);
    s := format(select_getLocationFromRoom, [_db(Room)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('Location').Asstring;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.getFloorFromRoom(Room: string): Integer;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+chr(10);
    // s := s + '     Rooms.Floor '+chr(10);
    // s := s + ' FROM '+chr(10);
    // s := s + '   Rooms '+chr(10);
    // s := s + ' WHERE '+chr(10);
    // s := s + '   (Room = ' + _db(Room) + ') '+chr(10);
    s := format(select_getFloorFromRoom, [_db(Room)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('Floor').AsInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.getinStatisticsFromRoom(Room: string): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := False;

  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+chr(10);
    // s := s + '     Rooms.[Statistics] '+chr(10);
    // s := s + ' FROM '+chr(10);
    // s := s + '   Rooms '+chr(10);
    // s := s + ' WHERE '+chr(10);
    // s := s + '   (Room = ' + _db(Room) + ') '+chr(10);
    s := format(select_getinStatisticsFromRoom, [_db(Room)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet['Statistics'];
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.ChangeCountry(newCountry: string; reservation, RoomReservation, Person, Medhod: Integer): boolean;
var
  s: string;
begin
  result := False;

  if Medhod = 0 then
  begin
    if Person < 1 then
      exit;
    result := True;
    s := '';
    s := s + ' UPDATE persons ' + chr(10);
    s := s + ' Set Country=' + _db(newCountry) + ' ' + chr(10);
    s := s + ' WHERE (Person = ' + inttostr(Person) + ') ' + chr(10);
    if not cmd_bySQL(s) then
    begin
      result := False;
    end;
  end;

  if Medhod = 1 then
  begin
    if RoomReservation < 1 then
      exit;
    result := True;
    s := '';
    s := s + ' UPDATE persons ' + chr(10);
    s := s + ' Set Country=' + _db(newCountry) + ' ' + chr(10);
    s := s + ' WHERE (RoomReservation = ' + inttostr(RoomReservation) + ') ' + chr(10);
    if not cmd_bySQL(s) then
    begin
      result := False;
    end;
  end;

  if Medhod = 2 then
  begin
    if reservation < 1 then
      exit;
    result := True;
    s := '';
    s := s + ' UPDATE persons ' + chr(10);
    s := s + ' Set Country=' + _db(newCountry) + ' ' + chr(10);
    s := s + ' WHERE (Reservation = ' + inttostr(reservation) + ') ' + chr(10);
    if not cmd_bySQL(s) then
    begin
      result := False;
    end;

    s := '';
    s := s + ' UPDATE reservations ' + chr(10);
    s := s + ' Set Country=' + _db(newCountry) + ' ' + chr(10);
    s := s + ' WHERE (Reservation = ' + inttostr(reservation) + ') ' + chr(10);
    if not cmd_bySQL(s) then
    begin
      result := False;
    end;
  end;
end;

function Td.reservationCount(reservation: Integer): Integer;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    s := format(select_reservationCount, [reservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.recordcount;
    end;
  finally
    freeandnil(rSet);
  end;
  // s := s + 'SELECT Reservation '+chr(10);
  // s := s + 'FROM Reservations  '+chr(10);
  // s := s + 'WHERE  '+chr(10);
  // s := s + '(Reservation =' + inttostr(reservation) + ') '+chr(10);
end;

function Td.getCountryCode(aText: string): string;
begin
  result := '00';
  aText := trim(aText);
  if length(aText) = 2 then
  begin
    if glb.Countries.locate('country', aText, [loCaseInsensitive]) then
    begin
      result := glb.Countries.FieldByName('Country').Asstring;
    end;
  end
  else
  begin
    if glb.Countries.locate('CountryName', aText, [loCaseInsensitive]) then
    begin
      result := glb.Countries.FieldByName('Country').Asstring;
    end
    else
      if glb.Countries.locate('IslCountryName', aText, [loCaseInsensitive]) then
    begin
      result := glb.Countries.FieldByName('Country').Asstring;
    end;
  end;
end;

function Td.getCountryName(const aCountryCode: string): string;
begin
  result := '';
  if glb.Countries.locate('country', aCountryCode, [loCaseInsensitive]) then
      result := glb.Countries.FieldByName('CountryName').Asstring;
end;

function Td.isKredit(InvoiceNumber: Integer): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := False;
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT ';
    // s := s + '   SplitNumber '+chr(10);
    // s := s + ' FROM InvoiceHeads '+chr(10);
    // s := s + ' WHERE InvoiceNumber = ' + inttostr(InvoiceNumber) + ' '+chr(10);
    s := format(select_isKredit, [InvoiceNumber]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('SplitNumber').AsInteger = 1;
    end;
  finally
    freeandnil(rSet);
  end;
end;

{ **
  Vinnslur vegna tengingar vi� st�lpa
  ** }

procedure Td.exportToSnertaTextRec(silent: boolean);
var

  s: string;
  counter: Integer;
  sCode: string;
  sDescription: string;
  sCount: string;
  sPrice: string;
  sAmount: string;
  sAmountWoVat: string;
  sVatCode: string;
  sCurrency: string;
  sCurrencyRate: string;

  sInvoiceNumber: string;

  sCustomer: string;
  sCustomerName: string;
  sAddress1: string;
  sAddress2: string;
  sAddress3: string;
  sAddress4: string;
  sCountry: string;
  sPersonalId: string;
  sGuestName: string;
  sBreakfast: string;
  sExtraText: string;
  sInvoiceDate: string;
  sPayDate: string;

  sStaff: string;

  sLocalCurrency: string;

  sReservation: string;
  sRoomReservation: string;
  sRoomNumber: string;

  sTotal: string;
  sTotalwoVAT: string;
  sTotalVAT: string;

  sTotalBreakfast: string;
  sCreditInvoice: string;
  sOrginalInvoice: string;
  sTotalPayments: string;
  sAccountKey: string;

  sfoTotal: string;
  sfoTotalwoVAT: string;
  sfoTotalVAT: string;

  sPaidWith: string;
  sDatePaid: string;
  sPaidAmount: string;

  sKredit: string;

  sTmp: string;
  iTmp: Integer;
  fTmp, fTmp2: Double;
  dTmp: TdateTime;

  dDate: Tdate;

  sCompanyName: string;
  sCompanyAddress: string;
  sCompanyZip: string;
  sCompanyPId: string;

  sFileName: string;
  sFilePath: string;
  sStaffName: string;
  sStaffPID: string;

  ar: TInvoiceActionRec;

  fPriceWOV: Double;
  sPriceWOV: string;

  iVatNumber: Integer;
  sVatNumber: string;

  fCurrencyRate: Double;

  ok: boolean;

  fVATPR: Double;
  sVATPR: string;

  isCurrency: boolean;
  isKredit: boolean;

  doExportInLocalCurrency: boolean;

  iCount: Double; // -96
  FAmount: Double;
  FAmountWoVat: Double;
  fPrice: Double;

  sMemo: string;

  lstSnerta: tstringList;

  snFileName: string;
  snertaPath: string;

  seppi: char;

  invoiceCurrency: string;
  nativeCurrency: string;

  procedure addLine(lineID, line: string);
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
      showmessage(format(GetTranslatedText('shTx_D_FolderNotFound'), [snertaPath, g.qProgramExePath]));
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

    iTmp := d.mtHead_.FieldByName('InvoiceNumber').AsInteger;
    sInvoiceNumber := inttostr(iTmp);

    counter := d.ChkFinished(iTmp);

    if not silent then
      if counter > 0 then
      begin
        // if MessageDlg('�a� er �egar b�i� a� �tlesa reikning ' + sInvoiceNumber + ' ' + inttostr(counter) + ' sinnum ' + chr(10)
        // + 'Halda �fram me� �tlestur ??', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        if MessageDlg(format(GetTranslatedText('shTx_D_AccountReadContinue'), [sInvoiceNumber, counter]),
          mtConfirmation, [mbYes, mbNo], 0) = mrNo then
          exit;
      end;

    sReservation := d.mtHead_.FieldByName('reservation').Asstring;
    sRoomReservation := d.mtHead_.FieldByName('RoomReservation').Asstring;
    sRoomNumber := d.mtHead_.FieldByName('RoomNumber').Asstring;

    sLocalCurrency := d.mtHead_.FieldByName('LocalCurrency').Asstring;
    sCurrency := d.mtHead_.FieldByName('Currency').Asstring;
    fCurrencyRate := LocalFloatValue(d.mtHead_.FieldByName('CurrencyRate').Asstring);
    sCurrencyRate := floattostr(fCurrencyRate);

    invoiceCurrency := sCurrency;

    isCurrency := not doExportInLocalCurrency;

    sCustomer := d.mtHead_.FieldByName('Customer').Asstring;
    sCustomer := trim(UpperCase(sCustomer));

    sTmp := d.mtHead_.FieldByName('staff').Asstring;
    sStaffName := d.GET_StaffMemberName_byInitials(sTmp);
    sStaffPID := d.GET_StaffMemberPID_byInitials(sTmp);;

    sCompanyName := d.mtCompany_.FieldByName('CompanyName').Asstring;
    sCompanyAddress := d.mtCompany_.FieldByName('Address1').Asstring;
    sCompanyZip := d.mtCompany_.FieldByName('Address2').Asstring;
    sCompanyPId := d.mtCompany_.FieldByName('CompanyPID').Asstring;
    sPersonalId := d.mtHead_.FieldByName('PersonalId').Asstring;

    if (sPersonalId = '000000-0000') or (sCustomer = '') or (sCustomer = g.qRackCustomer) or
      not hData.CustomerExist(sCustomer) then
      sCustomer := sCurrency;

    sCustomerName := d.mtHead_.FieldByName('CustomerName').Asstring;
    sAddress1 := d.mtHead_.FieldByName('Address1').Asstring;
    sAddress2 := d.mtHead_.FieldByName('Address2').Asstring;
    sAddress3 := d.mtHead_.FieldByName('Address3').Asstring;
    sAddress4 := d.mtHead_.FieldByName('Address4').Asstring;
    sCountry := d.mtHead_.FieldByName('Country').Asstring;

    sGuestName := d.mtHead_.FieldByName('GuestName').Asstring;
    sStaff := d.mtHead_.FieldByName('Staff').Asstring;

    dTmp := d.mtHead_.FieldByName('InvoiceDate').asDateTime;
    dDate := trunc(dTmp);

    sMemo := d.mtHead_.FieldByName('ExtraText').Asstring;

    // dagsetning �tlesturs og dagsetning reiknings
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
    while not d.mtLines_.eof do
    begin
      sCode := d.mtLines_.FieldByName('Code').Asstring;

      sVatCode := d.mtLines_.FieldByName('VatCode').Asstring;
      fVATPR := d.VATPercentage(sVatCode);
      sVATPR := floattostr(fVATPR);
      sDescription := d.mtLines_.FieldByName('Description').Asstring;
      iCount := d.mtLines_.FieldByName('Count').asFloat;
      sCount := _floatTostr(iCount, 0, 2);

      if isCurrency then
      begin
        FAmount := LocalFloatValue(d.mtLines_.FieldByName('foAmount').Asstring);
        FAmountWoVat := LocalFloatValue(d.mtLines_.FieldByName('foAmountWoVat').Asstring);
        fPrice := LocalFloatValue(d.mtLines_.FieldByName('foPrice').Asstring);
      end
      else
      begin
        FAmount := LocalFloatValue(d.mtLines_.FieldByName('Amount').Asstring);
        FAmountWoVat := LocalFloatValue(d.mtLines_.FieldByName('AmountWoVat').Asstring);
        fPrice := LocalFloatValue(d.mtLines_.FieldByName('Price').Asstring);
      end;

      sAmount := floattostr(FAmount);
      sAmountWoVat := floattostr(FAmountWoVat);
      sPrice := floattostr(fPrice);

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

      d.mtLines_.next;
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
        // FINATH aFile.DeleteFiles(_Addslash(snertaPath) + sInvoiceNumber + '.txt')
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
  ar.reservation := d.mtHead_.FieldByName('Reservation').AsInteger;
  ar.RoomReservation := d.mtHead_.FieldByName('RoomReservation').AsInteger;
  ar.InvoiceNumber := d.mtHead_.FieldByName('InvoiceNumber').AsInteger;
  ar.ActionDate := now;
  ar.actionID := 3101;
  ar.Action := 'Export To Snertu';
  ar.ActionNote := sFileName;
  ar.Staff := g.qUser;
  d.InsInvoiceAction(ar);

end;

// ****************************************************************************
//
//
// ****************************************************************************
procedure Td.exportToSnertaSimpleXML(silent: boolean);
var
  Adoc: TNativeXml;
  s: string;
  // counter : integer;
  sDate: string;
  sCode: string;
  sDescription: string;
  sCount: string;
  sPrice: string;
  sAmount: string;
  sAmountWoVat: string;
  sVatAmount: string;
  sVatCode: string;
  sfoPrice: string;
  sfoAmount: string;
  sfoAmountWoVat: string;
  sfoVatAmount: string;

  sCurrency: string;
  sCurrencyRate: string;

  sInvoiceNumber: string;

  sCustomer: string;
  sCustomerName: string;
  sAddress1: string;
  sAddress2: string;
  sAddress3: string;
  sAddress4: string;
  sCountry: string;
  sPersonalId: string;
  sGuestName: string;
  sBreakfast: string;
  sExtraText: string;

  sInvoiceDate: string;
  sDueDate: string;

  sStaff: string;

  sLocalCurrency: string;

  sReservation: string;
  sRoomReservation: string;
  sRoomNumber: string;

  sTotal: string;
  sTotalwoVAT: string;
  sTotalVAT: string;

  sTotalBreakfast: string;
  sCreditInvoice: string;
  sOrginalInvoice: string;
  sTotalPayments: string;
  sAccountKey: string;

  sfoTotal: string;
  sfoTotalwoVAT: string;
  sfoTotalVAT: string;

  sPaidWith: string;
  sDatePaid: string;
  sPaidAmount: string;

  sKredit: string;

  sTmp: string;
  iTmp: Integer;
  fTmp, fTmp2: Double;
  dTmp: TdateTime;

  dInvoiceDate: Tdate;
  dDueDate: Tdate;

  sCompanyName: string;
  sCompanyAddress: string;
  sCompanyZip: string;
  sCompanyPId: string;

  sFileName: string;
  sFilePath: string;
  sStaffName: string;
  sStaffPID: string;

  ar: TInvoiceActionRec;

  fPriceWOV: Double;
  sPriceWOV: string;

  iVatNumber: Integer;
  sVatNumber: string;

  fCurrencyRate: Double;

  ok: boolean;

  fVATPR: Double;
  sVATPR: string;

  isCurrency: boolean;
  isKredit: boolean;

  doExportInLocalCurrency: boolean;

  iCount: Integer;
  FAmount: Double;
  FAmountWoVat: Double;
  fPrice: Double;

  sMemo: string;

  lstSnerta: tstringList;

  filename: string;
  snertaPathXML: string;

  seppi: char;

  invoiceCurrency: string;
  nativeCurrency: string;

  nInvoice: TXmlNode;
  nInvoicehead: TXmlNode;

  nInvoicelines: TXmlNode;
  nInvoiceline: TXmlNode;

  nPayments: TXmlNode;
  nPayment: TXmlNode;

  nCustomer: TXmlNode;

  sSalesPerson: string;
  sPayment: string;

  sDateTime: string;
  iOutCounter: Integer;
  iInvoiceCounter: Integer;
  iLineCounter: Integer;
  iPaymentCounter: Integer;

  custInfo: recCustomerHolderEX;

  sRefrence: string;
  sSource: string;

  justLog: boolean;

  hLogData: recImportLogsHolder;

  iReservation: Integer;
  iRoomReservation: Integer;
  iInvoiceNumber: Integer;
  realRoomNumber: string;

  sInvoiceRefrence: string;

  sPaymentType: string;

  fLodgingTax: Double;
  iLodgingTaxNights: Integer;

  sLodgingTax: string;
  sLodgingTaxNights: string;

  sIsKredit: string;

begin
  justLog := False;

  if g.qHomeExportPOSType <> peExportFolder then
  begin
    justLog := True;
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
        justLog := True;
        // Showmessage('Folder ' + snertaPathXML + ' not found ' + chr(10) + ' Export file will be saved to ' + g.qProgramPath);
      end;

      nativeCurrency := ctrlGetString('NativeCurrency');

      // If true then always export in localcurrency
      doExportInLocalCurrency := ctrlGetBoolean('xmlDoExportInLocalCurrency');

      iInvoiceNumber := d.mtHead_.FieldByName('InvoiceNumber').AsInteger;
      sInvoiceNumber := inttostr(iInvoiceNumber);

      iOutCounter := d.ChkFinished(iInvoiceNumber);

      if not silent then
      begin
        if iOutCounter > 0 then
        begin
          // if MessageDlg('�a� er �egar b�i� a� �tlesa reikning ' + sInvoiceNumber + ' ' + inttostr(iOutCounter) + ' sinnum ' + chr(10)
          // + 'Halda �fram me� �tlestur ??', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
          if MessageDlg(format(GetTranslatedText('shTx_D_AccountReadContinue'), [sInvoiceNumber, iOutCounter]),
            mtConfirmation, [mbYes, mbNo], 0) = mrNo then
            exit;
        end;
      end;

      iReservation := d.mtHead_.FieldByName('reservation').AsInteger;
      iRoomReservation := d.mtHead_.FieldByName('RoomReservation').AsInteger;
      realRoomNumber := d.mtHead_.FieldByName('RoomNumber').Asstring;

      sReservation := d.mtHead_.FieldByName('reservation').Asstring;
      sRoomReservation := d.mtHead_.FieldByName('RoomReservation').Asstring;
      sRoomNumber := hData.doConvert('PO-ROOMS', d.mtHead_.FieldByName('RoomNumber').Asstring);

      isKredit := d.mtHead_['isKredit'];
      sIsKredit := _db(isKredit);

      sLocalCurrency := d.mtHead_.FieldByName('LocalCurrency').Asstring;
      sCurrency := d.mtHead_.FieldByName('Currency').Asstring;
      fCurrencyRate := LocalFloatValue(d.mtHead_.FieldByName('CurrencyRate').Asstring);
      sCurrencyRate := floattostr(fCurrencyRate);

      fLodgingTax := LocalFloatValue(d.mtHead_.FieldByName('TotalStayTax').Asstring);
      iLodgingTaxNights := d.mtHead_.FieldByName('TotalStayTaxNights').AsInteger;

      sLodgingTax := floattostr(fLodgingTax);
      sLodgingTaxNights := inttostr(iLodgingTaxNights);

      invoiceCurrency := sCurrency;

      isCurrency := sLocalCurrency <> sCurrency;
      if doExportInLocalCurrency then
      begin
        isCurrency := False;
      end;

      sCustomer := d.mtHead_.FieldByName('Customer').Asstring;
      sCustomer := trim(UpperCase(sCustomer));

      sTmp := d.mtHead_.FieldByName('staff').Asstring;
      sStaffName := d.GET_StaffMemberName_byInitials(sTmp);
      sStaffPID := d.GET_StaffMemberPID_byInitials(sTmp);;

      sSalesPerson := sTmp;

      sCompanyName := d.mtCompany_.FieldByName('CompanyName').Asstring;
      sCompanyAddress := d.mtCompany_.FieldByName('Address1').Asstring;
      sCompanyZip := d.mtCompany_.FieldByName('Address2').Asstring;
      sCompanyPId := d.mtCompany_.FieldByName('CompanyPID').Asstring;
      sPersonalId := d.mtHead_.FieldByName('PersonalId').Asstring;

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

      sCustomer := hData.doConvert('PO-CUST', sCustomer);

      sCustomerName := d.mtHead_.FieldByName('CustomerName').Asstring;
      sAddress1 := d.mtHead_.FieldByName('Address1').Asstring;
      sAddress2 := d.mtHead_.FieldByName('Address2').Asstring;
      sAddress3 := d.mtHead_.FieldByName('Address3').Asstring;
      sAddress4 := d.mtHead_.FieldByName('Address4').Asstring;
      sCountry := d.mtHead_.FieldByName('Country').Asstring;

      sGuestName := d.mtHead_.FieldByName('GuestName').Asstring;
      sStaff := d.mtHead_.FieldByName('Staff').Asstring;

      dTmp := d.mtHead_.FieldByName('InvoiceDate').asDateTime;
      dInvoiceDate := trunc(dTmp);
      datetimetostring(s, 'yyyy-mm-dd', dInvoiceDate);
      sInvoiceDate := s;

      dTmp := d.mtHead_.FieldByName('payDate').asDateTime;
      dDueDate := trunc(dTmp);
      datetimetostring(s, 'yyyy-mm-dd', dDueDate);
      sDueDate := s;

      sMemo := d.mtHead_.FieldByName('ExtraText').Asstring;
      sInvoiceRefrence := d.mtHead_.FieldByName('invRefrence').Asstring;

      // dagsetning �tlesturs og dagsetning reiknings
      datetimetostring(s, 'yyyy-mm-dd hh:nn:ss', now);
      sDateTime := s;

      // Write Head information

      sPaymentType := 'unknown';
      d.mtPayments_.First;
      if not d.mtPayments_.eof then
      begin
        sPaymentType := hData.doConvert('PO-GRTEG', d.mtPayments_.FieldByName('Code').Asstring);
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
      while not d.mtLines_.eof do
      begin
        inc(iLineCounter);
        sCode := d.mtLines_.FieldByName('Code').Asstring;

        sVatCode := d.mtLines_.FieldByName('VatCode').Asstring;
        fVATPR := d.VATPercentage(sVatCode);
        sVATPR := floattostr(fVATPR);
        sDescription := d.mtLines_.FieldByName('Description').Asstring;
        iCount := d.mtLines_.FieldByName('Count').AsInteger;
        sCount := inttostr(iCount);

        if isCurrency then
        begin
          FAmount := LocalFloatValue(d.mtLines_.FieldByName('foAmount').Asstring);
          FAmountWoVat := LocalFloatValue(d.mtLines_.FieldByName('foAmountWoVat').Asstring);
          fPrice := LocalFloatValue(d.mtLines_.FieldByName('foPrice').Asstring);
        end
        else
        begin
          FAmount := LocalFloatValue(d.mtLines_.FieldByName('Amount').Asstring);
          FAmountWoVat := LocalFloatValue(d.mtLines_.FieldByName('AmountWoVat').Asstring);
          fPrice := LocalFloatValue(d.mtLines_.FieldByName('Price').Asstring);
        end;

        sAmount := floattostr(FAmount);
        sAmountWoVat := floattostr(FAmountWoVat);
        sPrice := floattostr(fPrice);

        sRefrence := d.mtLines_.FieldByName('importRefrence').Asstring;
        sSource := d.mtLines_.FieldByName('importSource').Asstring;

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

        d.mtLines_.next;
      end;

      nPayments := nInvoice.NodeNew('payments');
      nPayments.AttributeAdd(UTF8String('invoicenumber'), UTF8String(sInvoiceNumber));

      // Write payments
      iPaymentCounter := 0;
      d.mtPayments_.First;
      while not d.mtPayments_.eof do
      begin
        inc(iPaymentCounter);

        if isCurrency then
        begin
          fTmp := LocalFloatValue(d.mtPayments_.FieldByName('foAmount').Asstring)
        end
        else
        begin
          fTmp := LocalFloatValue(d.mtPayments_.FieldByName('Amount').Asstring);
        end;

        sPayment := floattostr(fTmp);
        sCode := hData.doConvert('PO-GRTEG', d.mtPayments_.FieldByName('Code').Asstring);

        nPayment := nPayments.NodeNew('paymentline');
        with nPayment do
        begin
          AttributeAdd(UTF8String('id'), UTF8String(inttostr(iPaymentCounter)));
          writestring(UTF8String('paymentcode'), UTF8String(sCode), UTF8String('0'));
          writestring(UTF8String('amount'), UTF8String(sPayment), UTF8String('0'));
        end;
        d.mtPayments_.next;
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

      if justLog then
      begin
        s := '';
        s := s + ' INSERT INTO tblpoxexport ' + chr(10);
        s := s + '  ( ' + chr(10);
        s := s + '   InvoiceNumber ' + chr(10);
        s := s + '  ,Reservation ' + chr(10);
        s := s + '  ,RoomReservation ' + chr(10);
        s := s + '  ,InsertDate ' + chr(10);
        s := s + '  ) ' + chr(10);
        s := s + ' VALUES ' + chr(10);
        s := s + '  ( ' + chr(10);
        s := s + '   ' + _db(iInvoiceNumber) + ' ' + chr(10);
        s := s + '  ,' + _db(iReservation) + ' ' + chr(10);
        s := s + '  ,' + _db(iRoomReservation) + ' ' + chr(10);
        s := s + '  ,' + _db(now) + ' ' + chr(10);
        s := s + '  )' + chr(10);

        if not cmd_bySQL(s) then
        begin
        end;
      end
      else
      begin
        filename := _Addslash(snertaPathXML) + sInvoiceNumber + '.xml';

        if fileExists(filename) then
        begin
          try
            SysUtils.DeleteFile(filename)
          Except
            { TODO 5 -oHordur -cConvert to XE3 :  Create exception and log }
          end;
        end;

        Adoc.XmlFormat := xfReadable;

        try
          // ATHFIN XE  Adoc.EncodingString := ctrlGetString('snXMLencoding');
          Adoc.Charset := UTF8String(ctrlGetString('snXMLencoding'));
        except
        end;

        try
          Adoc.SaveToFile(filename);
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
  ar.reservation := d.mtHead_.FieldByName('Reservation').AsInteger;
  ar.RoomReservation := d.mtHead_.FieldByName('RoomReservation').AsInteger;
  ar.InvoiceNumber := d.mtHead_.FieldByName('InvoiceNumber').AsInteger;
  ar.ActionDate := now;
  ar.actionID := 3110;
  ar.Action := 'XML Export To Snertu';
  ar.ActionNote := filename;
  ar.Staff := g.qUser;
  d.InsInvoiceAction(ar);
end;

procedure Td.InsertMTdata(InvoiceNumber: Integer; doExport, silent: boolean; showPackage: boolean);
var
  i, ii: Integer;
  s: string;
  IvI: TInvoiceInfo;
  Rate: Double;

  copyText: string;
  sTmp: string;

  isForeign: boolean;
  sCurrency: string;

  okExport: boolean; // vegna paymenttype

  PaymentData: recPaymentHolder;
  invoiceData: recInvoiceHeadHolder;

  tmpCode: string;
  tmpDescription: string;
  tmpVatCode: string;
  tmpAccountKey: string;
  tmpimportSource: string;
  tmpimportRefrence: string;

  tmpPrice: Double;

  tmpfoPrice: Double;
  tmpfoAmount: Double;
  tmpfoAmountWoVat: Double;
  tmpfoVatAmount: Double;

  pckTotalsList: TRoomPackageLineEntryList;

  lineInfo: TInvoiceLineInfo;

begin
  initPaymentHolderRec(PaymentData);
  initInvoiceHeadHolderRec(invoiceData);
  pckTotalsList := TRoomPackageLineEntryList.Create(True);
  try
    IvI := TInvoiceInfo.Create(InvoiceNumber, PaymentData, invoiceData);
    try
      IvI.UpdateInfo(invoiceData);
      IvI.GatherPayments(okExport, PaymentData, invoiceData);

      sCurrency := IvI.Currency;

      isForeign := False;
      if _trimlower(ctrlGetString('NativeCurrency')) <> _trimlower(sCurrency) then
      begin
        isForeign := True;
      end;

      copyText := _islErl(IvI.ivhPrintText, isForeign);

      if IvI.KreditType = ktKredit then
      begin
        IvI.ivhTotal := IvI.ivhTotal * -1;
        IvI.ivhTotal_woVat := IvI.ivhTotal_woVat * -1;
        IvI.ivhTotal_VAT := IvI.ivhTotal_VAT * -1;
        IvI.ivhTotal_Currency := IvI.ivhTotal_Currency * -1;
        IvI.ivhTotalBreakFast := IvI.ivhTotalBreakFast * -1;

        for i := 0 to IvI.lineCount - 1 do
        begin
          IvI.LinesList[i].Price := IvI.LinesList[i].Price * -1;
          IvI.LinesList[i].TotalPrice := IvI.LinesList[i].TotalPrice * -1;
        end;

        for i := 0 to IvI.paymentCount - 1 do
        begin
          IvI.PaymentList[i].pmAmount := IvI.PaymentList[i].pmAmount * -1;
        end;

        for i := 0 to IvI.VATcount - 1 do
        begin
          IvI.VATList[i].Price_woVAT := IvI.VATList[i].Price_woVAT * -1;
          IvI.VATList[i].Price_wVAT := IvI.VATList[i].Price_wVAT * -1;
          IvI.VATList[i].VatAmount := IvI.VATList[i].VatAmount * -1;
        end;
      end;

      if d.mtHead_.Active then
        d.mtHead_.Close;
      d.mtHead_.Open;
      d.mtHead_.Insert;
      d.mtHead_.ClearFields;

      Rate := IvI.CurrencyRate;
      if Rate = 0 then
        Rate := 1;

      d.mtHead_.FieldByName('Customer').Asstring := IvI.CustomerInfo.IvCustomer;
      d.mtHead_.FieldByName('InvoiceNumber').AsInteger := IvI.InvoiceNumber;
      d.mtHead_.FieldByName('InvoiceDate').asDateTime := IvI.ivhDate;
      d.mtHead_.FieldByName('payDate').asDateTime := IvI.ivhPayDate;
      d.mtHead_.FieldByName('Staff').Asstring := IvI.ivhStaff;
      d.mtHead_.FieldByName('CustomerName').Asstring := IvI.CustomerInfo.IvName;
      d.mtHead_.FieldByName('Address1').Asstring := IvI.CustomerInfo.IvAddress1;
      d.mtHead_.FieldByName('Address2').Asstring := IvI.CustomerInfo.IvAddress2;
      d.mtHead_.FieldByName('Address3').Asstring := IvI.CustomerInfo.IvAddress3;
      d.mtHead_.FieldByName('Address4').Asstring := IvI.CustomerInfo.IvAddress4;
      d.mtHead_.FieldByName('Country').Asstring := IvI.CustomerInfo.IvCountry;
      d.mtHead_.FieldByName('CountryName').Asstring :=  d.getCountryName(IvI.CustomerInfo.IvCountry);
      d.mtHead_.FieldByName('PersonalId').Asstring := IvI.CustomerInfo.IvPid;
      d.mtHead_.FieldByName('GuestName').Asstring := IvI.CustomerInfo.IvRoomGuest;

      d.mtHead_.FieldByName('invRefrence').Asstring := IvI.ivhRefrence;

      d.mtHead_.FieldByName('Breakfast').asFloat := IvI.ivhTotalBreakFast;
      d.mtHead_.FieldByName('ExtraText').Asstring := IvI.ivhExtraText;
      d.mtHead_.FieldByName('CurrencyRate').asFloat := IvI.CurrencyRate;
      d.mtHead_.FieldByName('Currency').Asstring := IvI.Currency;
      d.mtHead_.FieldByName('LocalCurrency').Asstring := IvI.LocalCurrency;

      d.mtHead_.FieldByName('Reservation').AsInteger := IvI.ivhReservation;
      d.mtHead_.FieldByName('RoomReservation').AsInteger := IvI.ivhRoomReservation;
      d.mtHead_.FieldByName('RoomNumber').Asstring := IvI.ivhRoomNumber;
      d.mtHead_.FieldByName('Total').asFloat := IvI.ivhTotal;
      d.mtHead_.FieldByName('TotalwoVAT').asFloat := IvI.ivhTotal_woVat;
      d.mtHead_.FieldByName('TotalVAT').asFloat := IvI.ivhTotal_VAT;

      d.mtHead_.FieldByName('TotalBreakfast').asFloat := IvI.ivhTotalBreakFast;
      d.mtHead_.FieldByName('CreditInvoice').AsInteger := IvI.ivhCreditInvoice;
      d.mtHead_.FieldByName('OrginalInvoice').AsInteger := IvI.ivhOriginalInvoice;
      d.mtHead_.FieldByName('TotalPayments').asFloat := IvI.TotalPayments;

      d.mtHead_.FieldByName('PrePaid').asFloat := IvI.ivhTotal_prePaid;
      d.mtHead_.FieldByName('Balance').asFloat := IvI.ivhTotal_balance;
      d.mtHead_.FieldByName('foPrePaid').asFloat := IvI.ivhTotal_prePaid / Rate;
      d.mtHead_.FieldByName('foBalance').asFloat := IvI.ivhTotal_balance / Rate;

      d.mtHead_.FieldByName('foTotal').asFloat := IvI.ivhTotal / Rate;
      d.mtHead_.FieldByName('foTotalwoVAT').asFloat := IvI.ivhTotal_woVat / Rate;
      d.mtHead_.FieldByName('foTotalVAT').asFloat := IvI.ivhTotal_VAT / Rate;

      d.mtHead_.FieldByName('isKredit').asBoolean := IvI.KreditType = ktKredit;

      d.mtHead_.FieldByName('invPrintText').Asstring := _islErl(IvI.ivhPrintText, isForeign);

      d.mtHead_.FieldByName('TotalStayTax').asFloat := IvI.ivhTotalStayTax;
      d.mtHead_.FieldByName('TotalStayTaxNights').AsInteger := IvI.ivhTotalStayTaxNights;

      d.mtHead_.FieldByName('Package').Asstring := IvI.ivhPackage;

      d.mtHead_.FieldByName('PackageName').Asstring := IvI.ivhPackageName;
      d.mtHead_.FieldByName('ShowPackage').asBoolean := showPackage;
      d.mtHead_.FieldByName('Location').Asstring := IvI.ivhLocation;

      s := '';
      for i := 0 to IvI.paymentCount - 1 do
      begin
        s := s + IvI.PaymentList[i].pmCode + ': ' + trim(_floatTostr(IvI.PaymentList[i].pmAmount, 18, 2)) + '  /  ';
      end;
      d.mtHead_.FieldByName('PaymentLine').Asstring := s;

      s := '';
      for i := 0 to IvI.paymentCount - 1 do
      begin
        s := s + IvI.PaymentList[i].pmCode + ': ' + trim(_floatTostr(IvI.PaymentList[i].pmAmount / Rate, 18, 2))
          + '  /  ';
      end;
      d.mtHead_.FieldByName('foPaymentLine').Asstring := s;

      d.mtHead_.post;

      if d.mtLines_.Active then
        d.mtLines_.Close;
      d.mtLines_.Open;

      tmpCode := '';
      tmpDescription := '';
      tmpVatCode := '';
      tmpAccountKey := '';
      tmpimportSource := '';
      tmpimportRefrence := '';

      tmpfoPrice := 0.00;

      ii := 0;

      d.mtLines_.Insert;
      d.mtLines_.ClearFields;
      for i := 0 to IvI.lineCount - 1 do
      begin

        if (IvI.LinesList[i].IsPackage) and showPackage then
        begin
          inc(ii);
          lineInfo := IvI.LinesList[i];
          AddOrCreateToPackage(pckTotalsList
            , lineInfo.Code
            , lineInfo.Description
            , lineInfo.RoomReservationAlias
            , lineInfo.TotalPrice
            , lineInfo.TotalWOVAT
            , lineInfo.VatAmount
            , lineInfo.Code = g.qRoomRentItem
            , lineInfo.ImportSource
            , lineInfo.ImportRefrence
            , lineInfo.LineNo
            , lineInfo.date
            , lineInfo.Count
            );

        end
        else
        begin
          d.mtLines_.Insert;
          d.mtLines_.FieldByName('lineNo').AsInteger := IvI.LinesList[i].LineNo;
          d.mtLines_.FieldByName('Date').asDateTime := IvI.LinesList[i].date;
          d.mtLines_.FieldByName('Code').Asstring := IvI.LinesList[i].Code;
          d.mtLines_.FieldByName('Description').Asstring := IvI.LinesList[i].Description;
          d.mtLines_.FieldByName('Count').asFloat := IvI.LinesList[i].Count; // -96
          d.mtLines_.FieldByName('Price').asFloat := IvI.LinesList[i].Price;

          d.mtLines_.FieldByName('Amount').asFloat := IvI.LinesList[i].TotalPrice;
          d.mtLines_.FieldByName('AmountWoVat').asFloat := IvI.LinesList[i].TotalWOVAT;
          d.mtLines_.FieldByName('VatAmount').asFloat := IvI.LinesList[i].VatAmount;

          d.mtLines_.FieldByName('VatCode').Asstring := IvI.LinesList[i].VATCode;
          d.mtLines_.FieldByName('AccountKey').Asstring := IvI.LinesList[i].AccountKey;
          d.mtLines_.FieldByName('importSource').Asstring := IvI.LinesList[i].ImportSource;
          d.mtLines_.FieldByName('importRefrence').Asstring := IvI.LinesList[i].ImportRefrence;

          d.mtLines_.FieldByName('foPrice').asFloat := IvI.LinesList[i].Price / Rate;
          d.mtLines_.FieldByName('foAmount').asFloat := IvI.LinesList[i].TotalPrice / Rate;
          d.mtLines_.FieldByName('foAmountWoVat').asFloat := IvI.LinesList[i].TotalWOVAT / Rate;
          d.mtLines_.FieldByName('foVatAmount').asFloat := IvI.LinesList[i].VatAmount / Rate;
          d.mtLines_.post;
        end;
      end;

      if ii > 0 then
      begin

        for ii := 0 to pckTotalsList.Count - 1 do
        begin
          // showmessage(inttostr(pckTotalsList[ii].RoomReservation)+'   '+pckTotalsList[ii].code+'   '+floattostr(pckTotalsList[ii].Amount));



//          tmpCode           := ivi.ivhPackage;
//          tmpDescription    := ivi.IvhPackageText; // ivhPackageName;
//          if tmpCount <> 0 then tmpPrice := tmpAmount/tmpCount;
//          tmpfoPrice        := tmpPrice/rate;
//          tmpfoAmount       := tmpAmount/rate;
//          tmpfoAmountWoVat  := tmpAmountWoVat/rate;
//          tmpfoVatAmount    := tmpfoVatAmount/rate;

          tmpPrice := 0;
          if pckTotalsList[ii].ItemCount <> 0 then
          begin
            tmpPrice := pckTotalsList[ii].Amount / pckTotalsList[ii].ItemCount;
            tmpfoPrice := tmpPrice / Rate;
          end;

          tmpfoAmount := pckTotalsList[ii].Amount / Rate;
          tmpfoAmountWoVat := pckTotalsList[ii].AmountWoVat / Rate;
          tmpfoVatAmount := pckTotalsList[ii].VatAmount / Rate;

          d.mtLines_.Insert;
          d.mtLines_.FieldByName('lineNo').AsInteger := pckTotalsList[ii].LineNo;
          d.mtLines_.FieldByName('Date').asDateTime := pckTotalsList[ii].aDate;
          d.mtLines_.FieldByName('Code').Asstring := pckTotalsList[ii].packageCode;
          d.mtLines_.FieldByName('Description').Asstring := pckTotalsList[ii].Description;
          d.mtLines_.FieldByName('Count').asFloat := pckTotalsList[ii].ItemCount;
          d.mtLines_.FieldByName('Price').asFloat := tmpPrice;

          d.mtLines_.FieldByName('Amount').asFloat := pckTotalsList[ii].Amount;
          d.mtLines_.FieldByName('AmountWoVat').asFloat := pckTotalsList[ii].AmountWoVat;
          d.mtLines_.FieldByName('VatAmount').asFloat := pckTotalsList[ii].VatAmount;

          d.mtLines_.FieldByName('VatCode').Asstring := tmpVatCode;
          d.mtLines_.FieldByName('AccountKey').Asstring := tmpAccountKey;
          d.mtLines_.FieldByName('importSource').Asstring := tmpimportSource;
          d.mtLines_.FieldByName('importRefrence').Asstring := tmpimportRefrence;

          d.mtLines_.FieldByName('foPrice').asFloat := tmpfoPrice;
          d.mtLines_.FieldByName('foAmount').asFloat := tmpfoAmount;
          d.mtLines_.FieldByName('foAmountWoVat').asFloat := tmpfoAmountWoVat;
          d.mtLines_.FieldByName('foVatAmount').asFloat := tmpfoVatAmount;
          d.mtLines_.post;
        end;
      end;

      d.mtLines_.SortOn('lineNo', []);

      if d.mtPayments_.Active then
        d.mtPayments_.Close;
      d.mtPayments_.Open;
      d.mtPayments_.Insert;
      d.mtPayments_.ClearFields;
      for i := 0 to IvI.paymentCount - 1 do
      begin
        d.mtPayments_.Insert;
        d.mtPayments_.FieldByName('Date').asDateTime := IvI.PaymentList[i].pmDate;
        d.mtPayments_.FieldByName('Code').Asstring := IvI.PaymentList[i].pmCode;
        d.mtPayments_.FieldByName('Amount').asFloat := IvI.PaymentList[i].pmAmount;
        d.mtPayments_.FieldByName('foAmount').asFloat := IvI.PaymentList[i].pmAmount / Rate;
        d.mtPayments_.FieldByName('Description').Asstring := IvI.PaymentList[i].pmDescription;
        d.mtPayments_.FieldByName('TypeIndex').AsInteger := IvI.PaymentList[i].pmTypeIndex;

        d.mtPayments_.post
      end;
      // d.mtLines_.SortOn('lineNo',[]);

      if d.mtVAT_.Active then
        d.mtVAT_.Close;
      d.mtVAT_.Open;
      d.mtVAT_.Insert;
      d.mtVAT_.ClearFields;
      for i := 0 to IvI.VATcount - 1 do
      begin
        d.mtVAT_.Insert;
        d.mtVAT_.FieldByName('Code').Asstring := IvI.VATList[i].VATCode;
        d.mtVAT_.FieldByName('Description').Asstring := IvI.VATList[i].VATDescription;
        d.mtVAT_.FieldByName('Price_woVAT').asFloat := IvI.VATList[i].Price_woVAT;
        d.mtVAT_.FieldByName('Price_wVAT').asFloat := IvI.VATList[i].Price_wVAT;
        d.mtVAT_.FieldByName('VATAmount').asFloat := IvI.VATList[i].VatAmount;

        d.mtVAT_.FieldByName('foPrice_woVAT').asFloat := IvI.VATList[i].Price_woVAT / Rate;
        d.mtVAT_.FieldByName('foPrice_wVAT').asFloat := IvI.VATList[i].Price_wVAT / Rate;
        d.mtVAT_.FieldByName('foVATAmount').asFloat := IvI.VATList[i].VatAmount / Rate;

        d.mtVAT_.FieldByName('VATPercentage').asFloat := IvI.VATList[i].VATPercentage;
        d.mtVAT_.post
      end;

      if d.mtCompany_.Active then
        d.mtCompany_.Close;
      d.mtCompany_.Open;
      d.mtCompany_.Insert;
      d.mtCompany_.ClearFields;

      d.mtCompany_.FieldByName('CompanyName').Asstring := IvI.CompanyName;
      d.mtCompany_.FieldByName('Address1').Asstring := IvI.CompanyAddress1;
      d.mtCompany_.FieldByName('Address2').Asstring := IvI.CompanyAddress2;
      d.mtCompany_.FieldByName('Address3').Asstring := IvI.CompanyAddress3;
      d.mtCompany_.FieldByName('Address4').Asstring := IvI.CompanyAddress4;
      d.mtCompany_.FieldByName('Country').Asstring := IvI.CompanyCountry;
      d.mtCompany_.FieldByName('Countryname').Asstring := d.getCountryName(IvI.CompanyCountry);
      d.mtCompany_.FieldByName('TelePhone1').Asstring := IvI.CompanyTelePhone1;
      d.mtCompany_.FieldByName('TelePhone2').Asstring := IvI.CompanyTelePhone2;
      d.mtCompany_.FieldByName('Fax').Asstring := IvI.CompanyFax;
      d.mtCompany_.FieldByName('Email').Asstring := IvI.CompanyEmail;
      d.mtCompany_.FieldByName('HomePage').Asstring := IvI.CompanyHomePage;
      d.mtCompany_.FieldByName('CompanyPID').Asstring := IvI.CompanyPID;
      d.mtCompany_.FieldByName('CompanyVATno').Asstring := IvI.CompanyVATno;
      d.mtCompany_.FieldByName('CompanyBankInfo').Asstring := IvI.CompanyBankInfo;

      if d.mtCaptions_.Active then
        d.mtCaptions_.Close;
      d.mtCaptions_.Open;
      d.mtCaptions_.Insert;
      d.mtCaptions_.ClearFields;

      sTmp := '';
      if IvI.InvoiceNumber = PROFORMA_INVOICE_NUMBER then
      begin
        sTmp := ' - ' + copyText;
      end;

      d.mtCaptions_.FieldByName('invTxtHead').Asstring := _islErl(IvI.invTxtHeadDebit, isForeign) + sTmp;
      if IvI.KreditType = ktKredit then
      begin
        d.mtCaptions_.FieldByName('invTxtHead').Asstring := _islErl(IvI.invTxtHeadKredit, isForeign) + sTmp;
      end;

      d.mtCaptions_.FieldByName('invTxtHeadInfoNumber').Asstring := _islErl(IvI.invTxtHeadInfoNumber, isForeign);
      d.mtCaptions_.FieldByName('invTxtHeadInfoDate').Asstring := _islErl(IvI.invTxtHeadInfoDate, isForeign);
      d.mtCaptions_.FieldByName('invTxtHeadInfoCustomerNo').Asstring :=
        _islErl(IvI.invTxtHeadInfoCustomerNo, isForeign);
      d.mtCaptions_.FieldByName('invTxtHeadInfoGjalddagi').Asstring := _islErl(IvI.invTxtHeadInfoGjalddagi, isForeign);
      d.mtCaptions_.FieldByName('invTxtHeadInfoEindagi').Asstring := _islErl(IvI.invTxtHeadInfoEindagi, isForeign);
      d.mtCaptions_.FieldByName('invTxtHeadInfoLocalCurrency').Asstring :=
        _islErl(IvI.invTxtHeadInfoLocalCurrency, isForeign);
      d.mtCaptions_.FieldByName('invTxtHeadInfoCurrency').Asstring := _islErl(IvI.invTxtHeadInfoCurrency, isForeign);
      d.mtCaptions_.FieldByName('invTxtHeadInfoCurrencyRate').Asstring :=
        _islErl(IvI.invTxtHeadInfoCurrencyRate, isForeign);
      d.mtCaptions_.FieldByName('invTxtHeadInfoReservation').Asstring :=
        _islErl(IvI.invTxtHeadInfoReservation, isForeign);
      d.mtCaptions_.FieldByName('invTxtHeadInfoCreditInvoice').Asstring :=
        _islErl(IvI.invTxtHeadInfoCreditInvoice, isForeign);
      d.mtCaptions_.FieldByName('invTxtHeadInfoOrginalInfo').Asstring :=
        _islErl(IvI.invTxtHeadInfoOrginalInfo, isForeign);
      d.mtCaptions_.FieldByName('invTxtHeadInfoGuest').Asstring := _islErl(IvI.invTxtHeadInfoGuest, isForeign);
      d.mtCaptions_.FieldByName('invTxtHeadInfoRoom').Asstring := _islErl(IvI.invTxtHeadInfoRoom, isForeign);
      d.mtCaptions_.FieldByName('invTxtLinesItemNo').Asstring := _islErl(IvI.invTxtLinesItemNo, isForeign);
      d.mtCaptions_.FieldByName('invTxtLinesItemText').Asstring := _islErl(IvI.invTxtLinesItemText, isForeign);
      d.mtCaptions_.FieldByName('invTxtLinesItemCount').Asstring := _islErl(IvI.invTxtLinesItemCount, isForeign);
      d.mtCaptions_.FieldByName('invTxtLinesItemPrice').Asstring := _islErl(IvI.invTxtLinesItemPrice, isForeign);
      d.mtCaptions_.FieldByName('invTxtLinesItemAmount').Asstring := _islErl(IvI.invTxtLinesItemAmount, isForeign);
      d.mtCaptions_.FieldByName('invTxtLinesItemTotal').Asstring := _islErl(IvI.invTxtLinesItemTotal, isForeign);
      d.mtCaptions_.FieldByName('invTxtExtra1').Asstring := _islErl(IvI.invTxtExtra1, isForeign);
      d.mtCaptions_.FieldByName('invTxtExtra2').Asstring := _islErl(IvI.invTxtExtra2, isForeign);
      d.mtCaptions_.FieldByName('invTxtFooterLine1').Asstring := _islErl(IvI.invTxtFooterLine1, isForeign);
      d.mtCaptions_.FieldByName('invTxtFooterLine2').Asstring := _islErl(IvI.invTxtFooterLine2, isForeign);
      d.mtCaptions_.FieldByName('invTxtFooterLine3').Asstring := _islErl(IvI.invTxtFooterLine3, isForeign);
      d.mtCaptions_.FieldByName('invTxtFooterLine4').Asstring := _islErl(IvI.invTxtFooterLine4, isForeign);
      d.mtCaptions_.FieldByName('invTxtPaymentListHead').Asstring := _islErl(IvI.invTxtPaymentListHead, isForeign);
      d.mtCaptions_.FieldByName('invTxtPaymentListCode').Asstring := _islErl(IvI.invTxtPaymentListCode, isForeign);
      d.mtCaptions_.FieldByName('invTxtPaymentListAmount').Asstring := _islErl(IvI.invTxtPaymentListAmount, isForeign);
      d.mtCaptions_.FieldByName('invTxtPaymentListDate').Asstring := _islErl(IvI.invTxtPaymentListDate, isForeign);
      d.mtCaptions_.FieldByName('invTxtPaymentListTotal').Asstring := _islErl(IvI.invTxtPaymentListTotal, isForeign);
      d.mtCaptions_.FieldByName('invTxtPaymentLineHead').Asstring := _islErl(IvI.invTxtPaymentLineHead, isForeign);
      d.mtCaptions_.FieldByName('invTxtPaymentLineSeperator').Asstring :=
        _islErl(IvI.invTxtPaymentLineSeperator, isForeign);
      d.mtCaptions_.FieldByName('invTxtVATListHead').Asstring := _islErl(IvI.invTxtVATListHead, isForeign);
      d.mtCaptions_.FieldByName('invTxtVATListDescription').Asstring :=
        _islErl(IvI.invTxtVATListDescription, isForeign);
      d.mtCaptions_.FieldByName('invTxtVATListwoVAT').Asstring := _islErl(IvI.invTxtVATListwoVAT, isForeign);
      d.mtCaptions_.FieldByName('invTxtVATListwVAT').Asstring := _islErl(IvI.invTxtVATListwVAT, isForeign);
      d.mtCaptions_.FieldByName('invTxtVATListVATpr').Asstring := _islErl(IvI.invTxtVATListVATpr, isForeign);
      d.mtCaptions_.FieldByName('invTxtVATListVATAmount').Asstring := _islErl(IvI.invTxtVATListVATAmount, isForeign);
      d.mtCaptions_.FieldByName('invTxtVATListTotal').Asstring := _islErl(IvI.invTxtVATListTotal, isForeign);
      d.mtCaptions_.FieldByName('invTxtVATLineHead').Asstring := _islErl(IvI.invTxtVATLineHead, isForeign);
      d.mtCaptions_.FieldByName('invTxtVATLineSeperator').Asstring := _islErl(IvI.invTxtVATLineSeperator, isForeign);
      d.mtCaptions_.FieldByName('invTxtTotalwoVAT').Asstring := _islErl(IvI.invTxtTotalwoVAT, isForeign);
      d.mtCaptions_.FieldByName('invTxtTotalVATAmount').Asstring := _islErl(IvI.invTxtTotalVATAmount, isForeign);
      d.mtCaptions_.FieldByName('invTxtTotalTotal').Asstring := _islErl(IvI.invTxtTotalTotal, isForeign);
      d.mtCaptions_.FieldByName('invTxtCompanyName').Asstring := _islErl(IvI.invTxtCompanyName, isForeign);
      d.mtCaptions_.FieldByName('invTxtCompanyAddress').Asstring := _islErl(IvI.invTxtCompanyAddress, isForeign);
      d.mtCaptions_.FieldByName('invTxtCompanyTel1').Asstring := _islErl(IvI.invTxtCompanyTel1, isForeign);
      d.mtCaptions_.FieldByName('invTxtCompanyTel2').Asstring := _islErl(IvI.invTxtCompanyTel2, isForeign);
      d.mtCaptions_.FieldByName('invTxtCompanyFax').Asstring := _islErl(IvI.invTxtCompanyFax, isForeign);
      d.mtCaptions_.FieldByName('invTxtCompanyEmail').Asstring := _islErl(IvI.invTxtCompanyEmail, isForeign);
      d.mtCaptions_.FieldByName('invTxtCompanyHomePage').Asstring := _islErl(IvI.invTxtCompanyHomePage, isForeign);
      d.mtCaptions_.FieldByName('invTxtCompanyPID').Asstring := _islErl(IvI.invTxtCompanyPID, isForeign);
      d.mtCaptions_.FieldByName('invTxtCompanyBankInfo').Asstring := _islErl(IvI.invTxtCompanyBankInfo, isForeign);
      d.mtCaptions_.FieldByName('invTxtCompanyVATId').Asstring := _islErl(IvI.invTxtCompanyVATId, isForeign);
      d.mtCaptions_.FieldByName('invTxtTotalStayTax').Asstring := _islErl(IvI.ivhTxtTotalStayTax, isForeign);
      d.mtCaptions_.FieldByName('invTxtTotalStayTaxNights').Asstring :=
        _islErl(IvI.ivhTxtTotalStayTaxNights, isForeign);

      d.mtCaptions_.FieldByName('invTxtPaymentListDescription').Asstring :=
        _islErl(IvI.invTxtPaymentListDescription, isForeign);
      d.mtCaptions_.FieldByName('invTxtHeadPrePaid').Asstring := _islErl(IvI.invTxtHeadPrePaid, isForeign);
      d.mtCaptions_.FieldByName('invTxtHeadBalance').Asstring := _islErl(IvI.invTxtHeadBalance, isForeign);

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
          // Showmessage('Yfirf�rsla � St�lpa ');
          // InvoiceToStolpiTilbod(silent);
        end;

        if ctrlGetInteger('AccountType') = 2 then
        begin
          // Showmessage('Export To TouchStore - TextRec');
          exportToSnertaTextRec(silent);
          // exportToSnertaSimpleXML(silent);
        end;

        if ctrlGetInteger('AccountType') = 3 then
        begin
          // Showmessage('Export To TouchStore - XML');
          exportToSnertaSimpleXML(silent);
        end;

      end;
    except
      on e: Exception do
        MessageDlg('Unable to export finance data to POS (either Stolpi or Snerta) as according to ' + #13 + '"System | Settings | POS Connection"', mtError, [mbOK], 0); // + #13 + e.message, mtError, [mbOK], 0);
    end;
end;

procedure Td.InsertReciptData(PaymentData: recPaymentHolder; invoiceData: recInvoiceHeadHolder);
var
  i: Integer;
  s: string;
  IvI: TInvoiceInfo;
  Rate: Double;

  copyText: string;
  sTmp: string;

  isForeign: boolean;
  sCurrency: string;
  doExport: boolean;

begin
  doExport := False;

  IvI := TInvoiceInfo.Create(-1, PaymentData, invoiceData);
  try
    IvI.UpdateInfo(invoiceData);
    IvI.GatherPayments(doExport, PaymentData, invoiceData);

    sCurrency := IvI.Currency;

    isForeign := False;
    if _trimlower(ctrlGetString('NativeCurrency')) <> _trimlower(sCurrency) then
    begin
      isForeign := True;
    end;

    copyText := _islErl(IvI.ivhPrintText, isForeign);

    if IvI.KreditType = ktKredit then
    begin
      IvI.ivhTotal := IvI.ivhTotal * -1;
      IvI.ivhTotal_woVat := IvI.ivhTotal_woVat * -1;
      IvI.ivhTotal_VAT := IvI.ivhTotal_VAT * -1;
      IvI.ivhTotal_Currency := IvI.ivhTotal_Currency * -1;
      IvI.ivhTotalBreakFast := IvI.ivhTotalBreakFast * -1;

      for i := 0 to IvI.lineCount - 1 do
      begin
        IvI.LinesList[i].Price := IvI.LinesList[i].Price * -1;
        IvI.LinesList[i].TotalPrice := IvI.LinesList[i].TotalPrice * -1;
      end;

      for i := 0 to IvI.paymentCount - 1 do
      begin
        IvI.PaymentList[i].pmAmount := IvI.PaymentList[i].pmAmount * -1;
      end;

      for i := 0 to IvI.VATcount - 1 do
      begin
        IvI.VATList[i].Price_woVAT := IvI.VATList[i].Price_woVAT * -1;
        IvI.VATList[i].Price_wVAT := IvI.VATList[i].Price_wVAT * -1;
        IvI.VATList[i].VatAmount := IvI.VATList[i].VatAmount * -1;
      end;
    end;

    if d.mtHead_.Active then
      d.mtHead_.Close;
    d.mtHead_.Open;
    d.mtHead_.Insert;
    d.mtHead_.ClearFields;

    Rate := IvI.CurrencyRate;
    if Rate = 0 then
      Rate := 1;

    d.mtHead_.FieldByName('Customer').Asstring := IvI.CustomerInfo.IvCustomer;
    d.mtHead_.FieldByName('InvoiceNumber').AsInteger := IvI.InvoiceNumber;
    d.mtHead_.FieldByName('InvoiceDate').asDateTime := IvI.ivhDate;
    d.mtHead_.FieldByName('payDate').asDateTime := IvI.ivhPayDate;
    d.mtHead_.FieldByName('Staff').Asstring := IvI.ivhStaff;
    d.mtHead_.FieldByName('CustomerName').Asstring := IvI.CustomerInfo.IvName;
    d.mtHead_.FieldByName('Address1').Asstring := IvI.CustomerInfo.IvAddress1;
    d.mtHead_.FieldByName('Address2').Asstring := IvI.CustomerInfo.IvAddress2;
    d.mtHead_.FieldByName('Address3').Asstring := IvI.CustomerInfo.IvAddress3;
    d.mtHead_.FieldByName('Address4').Asstring := IvI.CustomerInfo.IvAddress4;
    d.mtHead_.FieldByName('Country').Asstring := IvI.CustomerInfo.IvCountry;
    d.mtHead_.FieldByName('PersonalId').Asstring := IvI.CustomerInfo.IvPid;
    d.mtHead_.FieldByName('GuestName').Asstring := IvI.CustomerInfo.IvRoomGuest;

    d.mtHead_.FieldByName('invRefrence').Asstring := IvI.ivhRefrence;

    d.mtHead_.FieldByName('Breakfast').asFloat := IvI.ivhTotalBreakFast;
    d.mtHead_.FieldByName('ExtraText').Asstring := IvI.ivhExtraText;
    d.mtHead_.FieldByName('CurrencyRate').asFloat := IvI.CurrencyRate;
    d.mtHead_.FieldByName('Currency').Asstring := IvI.Currency;
    d.mtHead_.FieldByName('LocalCurrency').Asstring := IvI.LocalCurrency;

    d.mtHead_.FieldByName('Reservation').AsInteger := IvI.ivhReservation;
    d.mtHead_.FieldByName('RoomReservation').AsInteger := IvI.ivhRoomReservation;
    d.mtHead_.FieldByName('RoomNumber').Asstring := IvI.ivhRoomNumber;
    d.mtHead_.FieldByName('Total').asFloat := IvI.ivhTotal;
    d.mtHead_.FieldByName('TotalwoVAT').asFloat := IvI.ivhTotal_woVat;
    d.mtHead_.FieldByName('TotalVAT').asFloat := IvI.ivhTotal_VAT;

    d.mtHead_.FieldByName('TotalBreakfast').asFloat := IvI.ivhTotalBreakFast;
    d.mtHead_.FieldByName('CreditInvoice').AsInteger := IvI.ivhCreditInvoice;
    d.mtHead_.FieldByName('OrginalInvoice').AsInteger := IvI.ivhOriginalInvoice;
    d.mtHead_.FieldByName('TotalPayments').asFloat := IvI.TotalPayments;

    d.mtHead_.FieldByName('PrePaid').asFloat := IvI.ivhTotal_prePaid;
    d.mtHead_.FieldByName('Balance').asFloat := IvI.ivhTotal_balance;
    d.mtHead_.FieldByName('foPrePaid').asFloat := IvI.ivhTotal_prePaid / Rate;
    d.mtHead_.FieldByName('foBalance').asFloat := IvI.ivhTotal_balance / Rate;

    d.mtHead_.FieldByName('foTotal').asFloat := IvI.ivhTotal / Rate;
    d.mtHead_.FieldByName('foTotalwoVAT').asFloat := IvI.ivhTotal_woVat / Rate;
    d.mtHead_.FieldByName('foTotalVAT').asFloat := IvI.ivhTotal_VAT / Rate;

    d.mtHead_.FieldByName('isKredit').asBoolean := IvI.KreditType = ktKredit;

    d.mtHead_.FieldByName('invPrintText').Asstring := _islErl(IvI.ivhPrintText, isForeign);

    d.mtHead_.FieldByName('TotalStayTax').asFloat := IvI.ivhTotalStayTax;
    d.mtHead_.FieldByName('TotalStayTaxNights').AsInteger := IvI.ivhTotalStayTaxNights;

    s := '';
    for i := 0 to IvI.paymentCount - 1 do
    begin
      s := s + IvI.PaymentList[i].pmCode + ': ' + trim(_floatTostr(IvI.PaymentList[i].pmAmount, 18, 2)) + '  /  ';
    end;
    d.mtHead_.FieldByName('PaymentLine').Asstring := s;

    s := '';
    for i := 0 to IvI.paymentCount - 1 do
    begin
      s := s + IvI.PaymentList[i].pmCode + ': ' + trim(_floatTostr(IvI.PaymentList[i].pmAmount / Rate, 18, 2))
        + '  /  ';
    end;
    d.mtHead_.FieldByName('foPaymentLine').Asstring := s;

    d.mtHead_.post;

    if d.mtLines_.Active then
      d.mtLines_.Close;
    d.mtLines_.Open;

    d.mtLines_.Insert;
    d.mtLines_.ClearFields;
    for i := 0 to IvI.lineCount - 1 do
    begin
      d.mtLines_.Insert;
      d.mtLines_.FieldByName('lineNo').AsInteger := IvI.LinesList[i].LineNo;
      d.mtLines_.FieldByName('Date').asDateTime := IvI.LinesList[i].date;
      d.mtLines_.FieldByName('Code').Asstring := IvI.LinesList[i].Code;
      d.mtLines_.FieldByName('Description').Asstring := IvI.LinesList[i].Description;
      d.mtLines_.FieldByName('Count').asFloat := IvI.LinesList[i].Count; // -96
      d.mtLines_.FieldByName('Price').asFloat := IvI.LinesList[i].Price;
      d.mtLines_.FieldByName('Amount').asFloat := IvI.LinesList[i].TotalPrice;
      d.mtLines_.FieldByName('AmountWoVat').asFloat := IvI.LinesList[i].TotalWOVAT;
      d.mtLines_.FieldByName('VatAmount').asFloat := IvI.LinesList[i].VatAmount;
      d.mtLines_.FieldByName('VatCode').Asstring := IvI.LinesList[i].VATCode;
      d.mtLines_.FieldByName('AccountKey').Asstring := IvI.LinesList[i].AccountKey;
      d.mtLines_.FieldByName('importSource').Asstring := IvI.LinesList[i].ImportSource;
      d.mtLines_.FieldByName('importRefrence').Asstring := IvI.LinesList[i].ImportRefrence;

      d.mtLines_.FieldByName('foPrice').asFloat := IvI.LinesList[i].Price / Rate;
      d.mtLines_.FieldByName('foAmount').asFloat := IvI.LinesList[i].TotalPrice / Rate;
      d.mtLines_.FieldByName('foAmountWoVat').asFloat := IvI.LinesList[i].TotalWOVAT / Rate;
      d.mtLines_.FieldByName('foVatAmount').asFloat := IvI.LinesList[i].VatAmount / Rate;

      d.mtLines_.post;
    end;
    d.mtLines_.SortOn('lineNo', []);

    if d.mtPayments_.Active then
      d.mtPayments_.Close;
    d.mtPayments_.Open;
    d.mtPayments_.Insert;
    d.mtPayments_.ClearFields;
    for i := 0 to IvI.paymentCount - 1 do
    begin
      d.mtPayments_.Insert;
      d.mtPayments_.FieldByName('Date').asDateTime := IvI.PaymentList[i].pmDate;
      d.mtPayments_.FieldByName('Code').Asstring := IvI.PaymentList[i].pmCode;
      d.mtPayments_.FieldByName('Amount').asFloat := IvI.PaymentList[i].pmAmount;
      d.mtPayments_.FieldByName('foAmount').asFloat := IvI.PaymentList[i].pmAmount / Rate;
      d.mtPayments_.FieldByName('Description').Asstring := IvI.PaymentList[i].pmDescription;
      d.mtPayments_.FieldByName('TypeIndex').AsInteger := IvI.PaymentList[i].pmTypeIndex;

      d.mtPayments_.post
    end;
    // d.mtLines_.SortOn('lineNo',[]);

    if d.mtVAT_.Active then
      d.mtVAT_.Close;
    d.mtVAT_.Open;
    d.mtVAT_.Insert;
    d.mtVAT_.ClearFields;
    for i := 0 to IvI.VATcount - 1 do
    begin
      d.mtVAT_.Insert;
      d.mtVAT_.FieldByName('Code').Asstring := IvI.VATList[i].VATCode;
      d.mtVAT_.FieldByName('Description').Asstring := IvI.VATList[i].VATDescription;
      d.mtVAT_.FieldByName('Price_woVAT').asFloat := IvI.VATList[i].Price_woVAT;
      d.mtVAT_.FieldByName('Price_wVAT').asFloat := IvI.VATList[i].Price_wVAT;
      d.mtVAT_.FieldByName('VATAmount').asFloat := IvI.VATList[i].VatAmount;

      d.mtVAT_.FieldByName('foPrice_woVAT').asFloat := IvI.VATList[i].Price_woVAT / Rate;
      d.mtVAT_.FieldByName('foPrice_wVAT').asFloat := IvI.VATList[i].Price_wVAT / Rate;
      d.mtVAT_.FieldByName('foVATAmount').asFloat := IvI.VATList[i].VatAmount / Rate;

      d.mtVAT_.FieldByName('VATPercentage').asFloat := IvI.VATList[i].VATPercentage;
      d.mtVAT_.post
    end;

    if d.mtCompany_.Active then
      d.mtCompany_.Close;
    d.mtCompany_.Open;
    d.mtCompany_.Insert;
    d.mtCompany_.ClearFields;

    d.mtCompany_.FieldByName('CompanyName').Asstring := IvI.CompanyName;
    d.mtCompany_.FieldByName('Address1').Asstring := IvI.CompanyAddress1;
    d.mtCompany_.FieldByName('Address2').Asstring := IvI.CompanyAddress2;
    d.mtCompany_.FieldByName('Address3').Asstring := IvI.CompanyAddress3;
    d.mtCompany_.FieldByName('Address4').Asstring := IvI.CompanyAddress4;
    d.mtCompany_.FieldByName('Country').Asstring := IvI.CompanyCountry;
    d.mtCompany_.FieldByName('TelePhone1').Asstring := IvI.CompanyTelePhone1;
    d.mtCompany_.FieldByName('TelePhone2').Asstring := IvI.CompanyTelePhone2;
    d.mtCompany_.FieldByName('Fax').Asstring := IvI.CompanyFax;
    d.mtCompany_.FieldByName('Email').Asstring := IvI.CompanyEmail;
    d.mtCompany_.FieldByName('HomePage').Asstring := IvI.CompanyHomePage;
    d.mtCompany_.FieldByName('CompanyPID').Asstring := IvI.CompanyPID;
    d.mtCompany_.FieldByName('CompanyVATno').Asstring := IvI.CompanyVATno;
    d.mtCompany_.FieldByName('CompanyBankInfo').Asstring := IvI.CompanyBankInfo;

    if d.mtCaptions_.Active then
      d.mtCaptions_.Close;
    d.mtCaptions_.Open;
    d.mtCaptions_.Insert;
    d.mtCaptions_.ClearFields;

    sTmp := '';
    if IvI.InvoiceNumber = PROFORMA_INVOICE_NUMBER then
    begin
      sTmp := ' - ' + copyText;
    end;

    d.mtCaptions_.FieldByName('invTxtHead').Asstring := _islErl(IvI.invTxtHeadDebit, isForeign) + sTmp;
    if IvI.KreditType = ktKredit then
    begin
      d.mtCaptions_.FieldByName('invTxtHead').Asstring := _islErl(IvI.invTxtHeadKredit, isForeign) + sTmp;
    end;

    d.mtCaptions_.FieldByName('invTxtHeadInfoNumber').Asstring := _islErl(IvI.invTxtHeadInfoNumber, isForeign);
    d.mtCaptions_.FieldByName('invTxtHeadInfoDate').Asstring := _islErl(IvI.invTxtHeadInfoDate, isForeign);
    d.mtCaptions_.FieldByName('invTxtHeadInfoCustomerNo').Asstring := _islErl(IvI.invTxtHeadInfoCustomerNo, isForeign);
    d.mtCaptions_.FieldByName('invTxtHeadInfoGjalddagi').Asstring := _islErl(IvI.invTxtHeadInfoGjalddagi, isForeign);
    d.mtCaptions_.FieldByName('invTxtHeadInfoEindagi').Asstring := _islErl(IvI.invTxtHeadInfoEindagi, isForeign);
    d.mtCaptions_.FieldByName('invTxtHeadInfoLocalCurrency').Asstring :=
      _islErl(IvI.invTxtHeadInfoLocalCurrency, isForeign);
    d.mtCaptions_.FieldByName('invTxtHeadInfoCurrency').Asstring := _islErl(IvI.invTxtHeadInfoCurrency, isForeign);
    d.mtCaptions_.FieldByName('invTxtHeadInfoCurrencyRate').Asstring :=
      _islErl(IvI.invTxtHeadInfoCurrencyRate, isForeign);
    d.mtCaptions_.FieldByName('invTxtHeadInfoReservation').Asstring :=
      _islErl(IvI.invTxtHeadInfoReservation, isForeign);
    d.mtCaptions_.FieldByName('invTxtHeadInfoCreditInvoice').Asstring :=
      _islErl(IvI.invTxtHeadInfoCreditInvoice, isForeign);
    d.mtCaptions_.FieldByName('invTxtHeadInfoOrginalInfo').Asstring :=
      _islErl(IvI.invTxtHeadInfoOrginalInfo, isForeign);
    d.mtCaptions_.FieldByName('invTxtHeadInfoGuest').Asstring := _islErl(IvI.invTxtHeadInfoGuest, isForeign);
    d.mtCaptions_.FieldByName('invTxtHeadInfoRoom').Asstring := _islErl(IvI.invTxtHeadInfoRoom, isForeign);
    d.mtCaptions_.FieldByName('invTxtLinesItemNo').Asstring := _islErl(IvI.invTxtLinesItemNo, isForeign);
    d.mtCaptions_.FieldByName('invTxtLinesItemText').Asstring := _islErl(IvI.invTxtLinesItemText, isForeign);
    d.mtCaptions_.FieldByName('invTxtLinesItemCount').Asstring := _islErl(IvI.invTxtLinesItemCount, isForeign);
    d.mtCaptions_.FieldByName('invTxtLinesItemPrice').Asstring := _islErl(IvI.invTxtLinesItemPrice, isForeign);
    d.mtCaptions_.FieldByName('invTxtLinesItemAmount').Asstring := _islErl(IvI.invTxtLinesItemAmount, isForeign);
    d.mtCaptions_.FieldByName('invTxtLinesItemTotal').Asstring := _islErl(IvI.invTxtLinesItemTotal, isForeign);
    d.mtCaptions_.FieldByName('invTxtExtra1').Asstring := _islErl(IvI.invTxtExtra1, isForeign);
    d.mtCaptions_.FieldByName('invTxtExtra2').Asstring := _islErl(IvI.invTxtExtra2, isForeign);
    d.mtCaptions_.FieldByName('invTxtFooterLine1').Asstring := _islErl(IvI.invTxtFooterLine1, isForeign);
    d.mtCaptions_.FieldByName('invTxtFooterLine2').Asstring := _islErl(IvI.invTxtFooterLine2, isForeign);
    d.mtCaptions_.FieldByName('invTxtFooterLine3').Asstring := _islErl(IvI.invTxtFooterLine3, isForeign);
    d.mtCaptions_.FieldByName('invTxtFooterLine4').Asstring := _islErl(IvI.invTxtFooterLine4, isForeign);
    d.mtCaptions_.FieldByName('invTxtPaymentListHead').Asstring := _islErl(IvI.invTxtPaymentListHead, isForeign);
    d.mtCaptions_.FieldByName('invTxtPaymentListCode').Asstring := _islErl(IvI.invTxtPaymentListCode, isForeign);
    d.mtCaptions_.FieldByName('invTxtPaymentListAmount').Asstring := _islErl(IvI.invTxtPaymentListAmount, isForeign);
    d.mtCaptions_.FieldByName('invTxtPaymentListDate').Asstring := _islErl(IvI.invTxtPaymentListDate, isForeign);
    d.mtCaptions_.FieldByName('invTxtPaymentListTotal').Asstring := _islErl(IvI.invTxtPaymentListTotal, isForeign);
    d.mtCaptions_.FieldByName('invTxtPaymentLineHead').Asstring := _islErl(IvI.invTxtPaymentLineHead, isForeign);
    d.mtCaptions_.FieldByName('invTxtPaymentLineSeperator').Asstring :=
      _islErl(IvI.invTxtPaymentLineSeperator, isForeign);
    d.mtCaptions_.FieldByName('invTxtVATListHead').Asstring := _islErl(IvI.invTxtVATListHead, isForeign);
    d.mtCaptions_.FieldByName('invTxtVATListDescription').Asstring := _islErl(IvI.invTxtVATListDescription, isForeign);
    d.mtCaptions_.FieldByName('invTxtVATListwoVAT').Asstring := _islErl(IvI.invTxtVATListwoVAT, isForeign);
    d.mtCaptions_.FieldByName('invTxtVATListwVAT').Asstring := _islErl(IvI.invTxtVATListwVAT, isForeign);
    d.mtCaptions_.FieldByName('invTxtVATListVATpr').Asstring := _islErl(IvI.invTxtVATListVATpr, isForeign);
    d.mtCaptions_.FieldByName('invTxtVATListVATAmount').Asstring := _islErl(IvI.invTxtVATListVATAmount, isForeign);
    d.mtCaptions_.FieldByName('invTxtVATListTotal').Asstring := _islErl(IvI.invTxtVATListTotal, isForeign);
    d.mtCaptions_.FieldByName('invTxtVATLineHead').Asstring := _islErl(IvI.invTxtVATLineHead, isForeign);
    d.mtCaptions_.FieldByName('invTxtVATLineSeperator').Asstring := _islErl(IvI.invTxtVATLineSeperator, isForeign);
    d.mtCaptions_.FieldByName('invTxtTotalwoVAT').Asstring := _islErl(IvI.invTxtTotalwoVAT, isForeign);
    d.mtCaptions_.FieldByName('invTxtTotalVATAmount').Asstring := _islErl(IvI.invTxtTotalVATAmount, isForeign);
    d.mtCaptions_.FieldByName('invTxtTotalTotal').Asstring := _islErl(IvI.invTxtTotalTotal, isForeign);
    d.mtCaptions_.FieldByName('invTxtCompanyName').Asstring := _islErl(IvI.invTxtCompanyName, isForeign);
    d.mtCaptions_.FieldByName('invTxtCompanyAddress').Asstring := _islErl(IvI.invTxtCompanyAddress, isForeign);
    d.mtCaptions_.FieldByName('invTxtCompanyTel1').Asstring := _islErl(IvI.invTxtCompanyTel1, isForeign);
    d.mtCaptions_.FieldByName('invTxtCompanyTel2').Asstring := _islErl(IvI.invTxtCompanyTel2, isForeign);
    d.mtCaptions_.FieldByName('invTxtCompanyFax').Asstring := _islErl(IvI.invTxtCompanyFax, isForeign);
    d.mtCaptions_.FieldByName('invTxtCompanyEmail').Asstring := _islErl(IvI.invTxtCompanyEmail, isForeign);
    d.mtCaptions_.FieldByName('invTxtCompanyHomePage').Asstring := _islErl(IvI.invTxtCompanyHomePage, isForeign);
    d.mtCaptions_.FieldByName('invTxtCompanyPID').Asstring := _islErl(IvI.invTxtCompanyPID, isForeign);
    d.mtCaptions_.FieldByName('invTxtCompanyBankInfo').Asstring := _islErl(IvI.invTxtCompanyBankInfo, isForeign);
    d.mtCaptions_.FieldByName('invTxtCompanyVATId').Asstring := _islErl(IvI.invTxtCompanyVATId, isForeign);
    d.mtCaptions_.FieldByName('invTxtTotalStayTax').Asstring := _islErl(IvI.ivhTxtTotalStayTax, isForeign);
    d.mtCaptions_.FieldByName('invTxtTotalStayTaxNights').Asstring := _islErl(IvI.ivhTxtTotalStayTaxNights, isForeign);

    d.mtCaptions_.FieldByName('invTxtPaymentListDescription').Asstring :=
      _islErl(IvI.invTxtPaymentListDescription, isForeign);
    d.mtCaptions_.FieldByName('invTxtHeadPrePaid').Asstring := _islErl(IvI.invTxtHeadPrePaid, isForeign);
    d.mtCaptions_.FieldByName('invTxtHeadBalance').Asstring := _islErl(IvI.invTxtHeadBalance, isForeign);

  finally
    IvI.Free;
  end;
end;

function Td.SnertaExportCustomers(custNo: string): Integer;
var
  rSet: TRoomerDataSet;
  s: string;
  dTmp: Double;
  sTmp: string;
  haus: string;

  lst: tstringList;
  snertaPath: string;
  filename: string;
  seppi: char;

  cust1: string;
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

  haus := s + chr(10);

  lst := tstringList.Create;
  try
    result := 0;
    rSet := CreateNewDataSet;
    try
      // s := '';
      // s := s + ' SELECT '+chr(10);
      // s := s + ' * '+chr(10);
      // s := s + ' FROM '+chr(10);
      // s := s + ' Customers '+chr(10);
      // if custNo <> '' then
      // begin
      // s := s + ' WHERE '+chr(10);
      // s := s + ' Customer =' + _db(custNo) + ' '+chr(10);
      // end;
      // s := s + ' ORDER BY customer '+chr(10);

      s := select_SnertaExportCustomers(custNo);
      s := format(s, [_db(custNo)]);
      if hData.rSet_bySQL(rSet, s) then
      begin
        filename := '';

        snertaPath := g.qsnPathXML;
        snertaPath := _Addslash(snertaPath);

        if not DirectoryExists(snertaPath) then
        begin
          snertaPath := g.qProgramExePath;
          showmessage(format(GetTranslatedText('shTx_D_FolderNotFound'), [g.qsnPathXML, snertaPath]));
        end
        else
        begin
          showmessage(format(GetTranslatedText('shTx_D_PathChange'), [snertaPath]));

        end;

        filename := _Addslash(snertaPath) + 'customers.txt';
        if fileExists(filename) then
        begin
          try
            // ATHFIN  aFile.DeleteFiles(FileName)
            SysUtils.DeleteFile(filename)
          except
            { TODO 5 -oHordur -cConvert to XE3 :  Create exception and log }
          end;
        end;

        lst.Add(haus);

        rSet.First;
        while not rSet.eof do
        begin
          cust1 := rSet.FieldByName('Customer').Asstring;
          s := '';
          s := s + cust1;
          s := s + seppi + rSet.FieldByName('PId').Asstring;
          s := s + seppi + rSet.FieldByName('SurName').Asstring;
          s := s + seppi + rSet.FieldByName('Address1').Asstring;
          s := s + seppi + rSet.FieldByName('Address2').Asstring;
          s := s + seppi + rSet.FieldByName('Address3').Asstring;
          s := s + seppi + rSet.FieldByName('Address4').Asstring;
          s := s + seppi + rSet.FieldByName('Tel1').Asstring;
          s := s + seppi + rSet.FieldByName('Tel2').Asstring;
          s := s + seppi + rSet.FieldByName('FAX').Asstring;
          s := s + seppi + rSet.FieldByName('EmailAddress').Asstring;
          dTmp := LocalFloatValue(rSet.FieldByName('DiscountPercent').Asstring);
          try
            sTmp := floattostr(dTmp);
          except
            sTmp := '0';
          end;
          s := s + seppi + sTmp;
          s := s + seppi + rSet.FieldByName('PCid').Asstring;
          lst.Add(s);
          rSet.next;
        end;
      end;

      if lst.Count > 1 then
      begin
        lst.SaveToFile(filename);
      end;
    finally
      freeandnil(rSet);
    end;
    result := lst.Count;
    if result > 0 then
      result := result - 1;
  finally
    lst.Free;
  end;
end;

function Td.SnertaExportRooms(Room, prefix: string): Integer;
var
  rSet: TRoomerDataSet;
  s: string;
  sTmp: string;
  haus: string;

  lst: tstringList;
  snertaPath: string;
  filename: string;
  seppi: char;
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
    rSet := CreateNewDataSet;
    try
      // s := s + ' SELECT '+chr(10);
      // s := s + ' * '+chr(10);
      // s := s + ' FROM '+chr(10);
      // s := s + ' Rooms '+chr(10);
      // if Room <> '' then
      // begin
      // s := s + ' WHERE '+chr(10);
      // s := s + ' Room =' + _db(Room) + ' '+chr(10);
      // end;
      // s := s + ' ORDER BY Room '+chr(10);

      s := select_SnertaExportRooms(Room);
      s := format(s, [_db(Room)]);
      if hData.rSet_bySQL(rSet, s) then
      begin
        filename := '';

        if not rSet.eof then
        begin
          snertaPath := g.qsnPathXML;
          snertaPath := _Addslash(snertaPath);
          if not DirectoryExists(snertaPath) then
          begin
            snertaPath := g.qProgramExePath;
            showmessage(format(GetTranslatedText('shTx_D_FolderNotFound'), [g.qsnPathXML, snertaPath]));
          end
          else
          begin
            showmessage(format(GetTranslatedText('shTx_D_PathChange'), [snertaPath]));
          end;

          filename := _Addslash(snertaPath) + 'Rooms.txt';

          if fileExists(filename) then
          begin
            try
              // ATHFIN aFile.DeleteFiles(FileName)
              try
                SysUtils.DeleteFile(filename)
              Except
                { TODO 5 -oHordur -cConvert to XE3 :  Create exception and log }
              end;
            except
            end;
          end;
          lst.Add(haus);
        end;

        rSet.First;
        while not rSet.eof do
        begin
          Room := prefix + rSet.FieldByName('room').Asstring;
          s := '';
          s := s + Room;
          s := s + seppi + rSet.FieldByName('Description').Asstring;
          s := s + seppi + rSet.FieldByName('roomtype').Asstring;
          s := s + seppi + rSet.FieldByName('location').Asstring;
          s := s + seppi + rSet.FieldByName('floor').Asstring;
          s := s + seppi + rSet.FieldByName('Equipments').Asstring;
          lst.Add(s);
          rSet.next;
        end;
      end;

      if lst.Count > 1 then
      begin
        lst.SaveToFile(filename);
      end;

    finally
      freeandnil(rSet);
    end;

    result := lst.Count;
    if result > 0 then
      result := result - 1;
  finally
    lst.Free;
  end;
end;

function Td.ExtStatusText(status: string; aDate, Arrival, departure: Tdate): string;
var
  TotalNights: Integer;
  daysFromArrival: Integer;
  daysUntilDeparture: Integer;

  s: string;
  ss: string;

  chrStatus: char;

begin
  TotalNights := trunc(Arrival) - trunc(departure);
  daysFromArrival := trunc(Arrival) - trunc(aDate);
  daysUntilDeparture := trunc(departure) - trunc(date);

  s := '';
  s := s + 'Days=' + inttostr(TotalNights) + ' ';
  s := s + 'Stay=' + inttostr(daysFromArrival) + ' ';
  s := s + 'Left=' + inttostr(daysUntilDeparture) + ' ';

  chrStatus := '0';

  if length(status) > 0 then
    chrStatus := status[1];

  case chrStatus of
    'G':
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
        if daysUntilDeparture > -1 then
          ss := format(GetTranslatedText('shTx_D_CheckoutXDaysAgo'), [daysUntilDeparture]);
        if daysUntilDeparture = -1 then
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

function Td.Next_OccupiedDayCount(FromDate: Tdate; Room: string): Integer;
var
  occDate: Tdate;
begin
  occDate := Next_OccupiedDate(FromDate, Room);
  result := trunc(occDate) - trunc(FromDate);
end;

function Td.Next_OccupiedDate(FromDate: Tdate; Room: string): Tdate;
var
  rSet: TRoomerDataSet;
  s: string;
  sDate: string;
begin
  result := date + 3600; // after years
  rSet := CreateNewDataSet;
  try
    // **xzhj
    s := format(select_Next_OccupiedDate, [_db(Room), _DateToDBDate(FromDate, True)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      sDate := rSet.FieldByName('ADate').Asstring;
      result := _dbdateToDate(sDate);
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.GetCurrentGuestsXML: Integer;
var
  Adoc: TNativeXml;
  nRoomReservations: TXmlNode;
  nRoomreservation: TXmlNode;
  nRoomguest: TXmlNode;

  rSet: TRoomerDataSet;

  lstRR: tstringList;
  i: Integer;
  s: string;

  Room: string;
  RoomDescription: string;
  RoomType: string;
  RoomTypeDescription: string;
  Location: string;
  Floor: string;
  GuestName: string;
  GuestCountry: string;
  Arrival: Tdate;
  departure: Tdate;
  customer: string;
  CustomerName: string;
  CustomerPID: string;
  ReservationName: string;
  StatusText: String;
  GuestCount: Integer;

  rCount: Integer;

  reservation: Integer;
  RoomReservation: Integer;
  status: string;

  NightsTotal: Integer;
  NightsFromArrival: Integer;
  NightsUntilDeparture: Integer;

  GroupAccount: boolean;
  Breakfast: boolean;

  sDateTime: string;
  sStaff: string;

  filename: string;

  snertaPathCurrentGuestsXML: string;

begin

  result := 0;

  // ef ekki er POS samskipti
  if ctrlGetInteger('AccountType') <> 3 then
  begin
    exit;
  end;

  datetimetostring(sDateTime, 'yyyy-mm-dd hh:nn:ss', now);
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

        lstRR := d.lstRR_CurrentlyCheckedIn(date);
        try
          result := lstRR.Count;

          for i := 0 to lstRR.Count - 1 do
          begin
            RoomReservation := strtoint(lstRR[i]);
            // rSet := SP_GET_GuestsInfoByRoomReservation(RoomReservation);
            rSet := CreateNewDataSet;
            try
              s := format(select_GuestsInfoByRoomReservation, [RoomReservation]);
              if hData.rSet_bySQL(rSet, s) then
              begin
                rSet.First;
                GuestCount := rSet.recordcount;
                rCount := 0;

                nRoomreservation := nRoomReservations.NodeNew('roomreservation');
                nRoomreservation.AttributeAdd(UTF8String('roomreservation_number'), UTF8String(lstRR[i]));
                nRoomreservation.AttributeAdd(UTF8String('guests_count'), UTF8String(inttostr(GuestCount)));

                while not rSet.eof do
                begin
                  inc(rCount);
                  Room := rSet.FieldByName('Room').Asstring;
                  RoomDescription := rSet.FieldByName('RoomDescription').Asstring;
                  RoomType := rSet.FieldByName('RoomType').Asstring;
                  RoomTypeDescription := rSet.FieldByName('RoomTypeDescription').Asstring;
                  Location := rSet.FieldByName('Location').Asstring;
                  Floor := rSet.FieldByName('Floor').Asstring;
                  Arrival := rSet.FieldByName('rrArrival').asDateTime;
                  departure := rSet.FieldByName('rrDeparture').asDateTime;
                  customer := rSet.FieldByName('Customer').Asstring;
                  CustomerName := rSet.FieldByName('CustomerName').Asstring;
                  CustomerPID := rSet.FieldByName('CustomerPID').Asstring;
                  ReservationName := rSet.FieldByName('ReservationName').Asstring;
                  status := rSet.FieldByName('Status').Asstring;
                  reservation := rSet.FieldByName('Reservation').AsInteger;
                  GroupAccount := rSet['GroupAccount'];
                  Breakfast := rSet['invBreakfast'];
                  StatusText := d.ExtStatusText(status, date, Arrival, departure);
                  NightsTotal := trunc(departure) - trunc(Arrival);
                  NightsFromArrival := trunc(date) - trunc(Arrival);
                  NightsUntilDeparture := trunc(departure) - trunc(date);

                  GuestName := rSet.FieldByName('GuestName').Asstring;
                  GuestCountry := rSet.FieldByName('CountryName').Asstring;

                  if rCount = 1 then
                  begin
                    nRoomreservation.AttributeAdd(UTF8String('room'), UTF8String(Room));
                    nRoomreservation.AttributeAdd(UTF8String('main_guest'), UTF8String(GuestName));
                    nRoomreservation.writestring(UTF8String('Room_description'), UTF8String(RoomDescription));
                    nRoomreservation.writestring(UTF8String('room_type'), UTF8String(RoomType), UTF8String(''));
                    nRoomreservation.writestring(UTF8String('room_type_description'), UTF8String(RoomTypeDescription),
                      UTF8String(''));
                    nRoomreservation.writestring(UTF8String('location'), UTF8String(Location), UTF8String(''));
                    nRoomreservation.writestring(UTF8String('floor'), UTF8String(Floor), UTF8String(''));
                    nRoomreservation.writestring(UTF8String('arrival'), UTF8String(_DateToDBDate(Arrival, False)),
                      UTF8String(''));
                    nRoomreservation.writestring(UTF8String('departure'), UTF8String(_DateToDBDate(departure, False)),
                      UTF8String(''));
                    nRoomreservation.writestring(UTF8String('customer'), UTF8String(customer), UTF8String(''));
                    nRoomreservation.writestring(UTF8String('customer_name'), UTF8String(CustomerName), UTF8String(''));
                    nRoomreservation.writestring(UTF8String('customer_pid'), UTF8String(CustomerPID), UTF8String(''));
                    nRoomreservation.writestring(UTF8String('reservation_name'), UTF8String(ReservationName),
                      UTF8String(''));
                    nRoomreservation.writestring(UTF8String('status'), UTF8String(status), UTF8String(''));
                    nRoomreservation.writestring(UTF8String('reservation'), UTF8String(inttostr(reservation)),
                      UTF8String(''));
                    nRoomreservation.writestring(UTF8String('group_account'), UTF8String(boolToStr(GroupAccount)),
                      UTF8String(''));
                    nRoomreservation.writestring(UTF8String('breakfast'), UTF8String(boolToStr(Breakfast)),
                      UTF8String(''));
                    nRoomreservation.writestring(UTF8String('status_text'), UTF8String(StatusText), UTF8String(''));
                    nRoomreservation.writestring(UTF8String('nights_total'), UTF8String(inttostr(NightsTotal)),
                      UTF8String(''));
                    nRoomreservation.writestring(UTF8String('nights_from_arrival'),
                      UTF8String(inttostr(NightsFromArrival)), UTF8String(''));
                    nRoomreservation.writestring(UTF8String('nights_until_departure'),
                      UTF8String(inttostr(NightsUntilDeparture)), UTF8String(''));
                  end;
                  nRoomguest := nRoomreservation.NodeNew(UTF8String('room_guest'));
                  nRoomguest.AttributeAdd(UTF8String('guest_index'), UTF8String(inttostr(rCount)));
                  nRoomguest.writestring(UTF8String('guest_name'), UTF8String(GuestName), UTF8String(''));
                  nRoomguest.writestring(UTF8String('guest_country'), UTF8String(GuestCountry), UTF8String(''));
                  rSet.next;
                end;
              end;
            finally
              freeandnil(rSet);
            end;
          end;
        finally
          freeandnil(lstRR);
        end;

      finally
        if rSet <> nil then
          freeandnil(rSet);
      end;

      snertaPathCurrentGuestsXML := g.qsnPathCurrentGuestsXML;
      snertaPathCurrentGuestsXML := _Addslash(snertaPathCurrentGuestsXML);

      if not DirectoryExists(snertaPathCurrentGuestsXML) then
      begin
        snertaPathCurrentGuestsXML := g.qsnPathXML;
      end;

      if not DirectoryExists(snertaPathCurrentGuestsXML) then
      begin
        snertaPathCurrentGuestsXML := g.qProgramExePath;
      end;

      filename := _Addslash(snertaPathCurrentGuestsXML) + 'currentguests' + '.xml';

      if fileExists(filename) then
      begin
        try
          // **ATHFIN aFile.DeleteFiles(filename);+
          SysUtils.DeleteFile(filename);
        except
          { TODO 5 -oHordur -cConvert to XE3 :  Create exception and log }
        end;
      end;

      Adoc.XmlFormat := xfReadable;

      try
        // ATHFIX XE Adoc.ExternalEncoding := ctrlGetString('snXMLencoding');
        Adoc.Charset := UTF8String(ctrlGetString('snXMLencoding'));
      except
      end;
      try
        Adoc.SaveToFile(filename);
      except
      end;
    finally
      freeandnil(Adoc);
    end;
  end
  else
  begin // setja � gagnagrunn
    if g.qHomeExportPOSType = peExportLogFile then
    begin
      // **
      s := '';
      s := s + ' INSERT INTO tblpoxexport ' + chr(10);
      s := s + '  ( ' + chr(10);
      s := s + '   InvoiceNumber ' + chr(10);
      s := s + '  ,Reservation ' + chr(10);
      s := s + '  ,RoomReservation ' + chr(10);
      s := s + '  ,InsertDate ' + chr(10);
      s := s + '  ) ' + chr(10);
      s := s + ' VALUES ' + chr(10);
      s := s + '  ( ' + chr(10);
      s := s + '   ' + _db(-1001) + ' ' + chr(10);
      s := s + '  ,' + _db(0) + ' ' + chr(10);
      s := s + '  ,' + _db(0) + ' ' + chr(10);
      s := s + '  ,' + _db(now) + ' ' + chr(10);
      s := s + '  )' + chr(10);
      if not cmd_bySQL(s) then
      begin
      end;
    end;
  end;
end;

function Td.IH_GetRefrence(InvoiceNumber, reservation, RoomReservation: Integer): string;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := '';

  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+chr(10);
    // s := s + '     Reservation '+chr(10);
    // s := s + '   , RoomReservation '+chr(10);
    // s := s + '   , InvoiceNumber '+chr(10);
    // s := s + '   , invRefrence '+chr(10);
    // s := s + ' FROM '+chr(10);
    // s := s + '   InvoiceHeads '+chr(10);
    // s := s + ' WHERE '+chr(10);
    // s := s + '   (Reservation = '+_db(reservation)+')  and (RoomReservation = '+_db(roomReservation)+')  and (InvoiceNumber = '+_db(invoicenumber)+') '+chr(10);
    s := format(select_IH_GetRefrence, [reservation, RoomReservation, InvoiceNumber]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('invRefrence').Asstring;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.hiddenInfo_Exists(Refrence, RefrenceType: Integer): Integer;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := 0;
  // s := s+' SELECT '+chr(10);
  // s := s+'       ID  '+chr(10);
  // s := s+'     , Refrence  '+chr(10);
  // s := s+'     , RefrenceType  '+chr(10);
  // s := s+'   FROM  '+chr(10);
  // s := s+'     tblHiddenInfo  '+chr(10);
  // s := s+'   WHERE     (Refrence = '+_db(Refrence)+') AND (RefrenceType = '+_db(RefrenceType)+') '+chr(10);
  rSet := CreateNewDataSet;
  try
    s := format(select_hiddenInfo_Exists, [_db(Refrence), _db(RefrenceType)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('id').AsInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.hiddenInfo_getData(Id: Integer): recHiddenInfoHolder;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  g.initRecHiddenInfo(result);
  // s := s+' SELECT '+chr(10);
  // s := s+'     ID '+chr(10);
  // s := s+'   , Notes '+chr(10);
  // s := s+'   , ViewLog '+chr(10);
  // s := s+'   , DeleteOn '+chr(10);
  // s := s+'   , Refrence '+chr(10);
  // s := s+'   , RefrenceType '+chr(10);
  // s := s+' FROM '+chr(10);
  // s := s+'   tblHiddenInfo '+chr(10);
  // s := s+' WHERE (ID = '+_db(ID)+') '+chr(10);
  rSet := CreateNewDataSet;
  try
    s := format(select_hiddenInfo_getData, [Id]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result.Id := rSet.FieldByName('id').AsInteger;
      result.Notes := rSet.FieldByName('Notes').Asstring;
      result.DeleteOn := rSet.FieldByName('deleteOn').asDateTime;
      result.ViewLog := rSet.FieldByName('ViewLog').Asstring;
      result.Refrence := rSet.FieldByName('Refrence').AsInteger;
      result.RefrenceType := rSet.FieldByName('refrenceType').AsInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.hiddenInfo_Append(Id: Integer; newText: string; res: Integer): boolean;
var
  s: string;
  rec: recHiddenInfoHolder;

  orginalText: string;
  updatedText: string;
  sTmp: string;
  sDate: string;
begin
  datetimetostring(sDate, 'YYYY-mm-dd hh:nn', now);
  result := False;

  if newText = '' then
    exit; // ===>

  rec := d.hiddenInfo_getData(Id);

  if Id = 0 then
  begin
    rec.Refrence := res;
    rec.RefrenceType := 1;
    updatedText := _strNumEnCrypt(newText, 5849);
    rec.ViewLog := sDate + '  -  ' + g.qUser + '  -  ' + GetTranslatedText('shTx_D_AddedNoLogin');
    // 'Added without loggin in';
    s := '';
    s := s + ' INSERT INTO tblhiddeninfo (' + chr(10);
    s := s + '     Notes ' + chr(10);
    s := s + '    ,DeleteOn ' + chr(10);
    s := s + '    ,ViewLog ' + chr(10);
    s := s + '    ,Refrence ' + chr(10);
    s := s + '    ,RefrenceType ' + chr(10);
    s := s + '    ) ' + chr(10);
    s := s + ' VALUES ( ' + chr(10);
    s := s + '    ' + _db(updatedText) + ' ' + chr(10);
    s := s + '   ,' + _db(rec.DeleteOn) + ' ' + chr(10);
    s := s + '   ,' + _db(rec.ViewLog) + ' ' + chr(10);
    s := s + '   ,' + _db(rec.Refrence) + ' ' + chr(10);
    s := s + '   ,' + _db(rec.RefrenceType) + ' ' + chr(10);
    s := s + '  ) ' + chr(10);
    if not cmd_bySQL(s) then
    begin
    end;
  end
  else
  begin
    // record Found so append new text to the orginal
    orginalText := _strNumDeCrypt(rec.Notes, 5849);
    sTmp := orginalText + #13#10 + '----' + #13#10 + newText;
    updatedText := _strNumEnCrypt(sTmp, 5849);
    rec.ViewLog := sDate + '  -  ' + g.qUser + '  -  ' + GetTranslatedText('shTx_D_AddedNoLogin');
    // 'Added without loggin in';
    s := '';
    s := s + ' UPDATE tblhiddeninfo ' + chr(10);
    s := s + ' SET ' + chr(10);
    s := s + '  Notes=' + _db(updatedText) + ' ' + chr(10);
    s := s + ' WHERE (ID = ' + _db(Id) + ') ' + chr(10);
    if not cmd_bySQL(s) then
    begin
    end;
  end;
end;

procedure Td.memImportResults_Fill;
begin
  if memImportResults.Active then
    memImportResults.Close();
  memImportResults.Open;

  memImportResults.Insert;
  memImportResults.FieldByName('ID').AsInteger := 10000;
  memImportResults.FieldByName('Description').Asstring := 'Sucess - From POS';
  memImportResults.post;

  memImportResults.Insert;
  memImportResults.FieldByName('ID').AsInteger := 10010;
  memImportResults.FieldByName('Description').Asstring := 'Sucess - From Home';
  memImportResults.post;

  memImportResults.Insert;
  memImportResults.FieldByName('ID').AsInteger := 20000;
  memImportResults.FieldByName('Description').Asstring := 'Warning - Reason unknown';
  memImportResults.post;

  memImportResults.Insert;
  memImportResults.FieldByName('ID').AsInteger := 20100;
  memImportResults.FieldByName('Description').Asstring := 'Warning - Get Item';
  memImportResults.post;

  memImportResults.Insert;
  memImportResults.FieldByName('ID').AsInteger := 20200;
  memImportResults.FieldByName('Description').Asstring := 'Warning - Edit Item';
  memImportResults.post;

  memImportResults.Insert;
  memImportResults.FieldByName('ID').AsInteger := 20300;
  memImportResults.FieldByName('Description').Asstring := 'Warning - INSERT Item';
  memImportResults.post;

  memImportResults.Insert;
  memImportResults.FieldByName('ID').AsInteger := 30000;
  memImportResults.FieldByName('Description').Asstring := 'Failed - Reason unknown';
  memImportResults.post;

  memImportResults.Insert;
  memImportResults.FieldByName('ID').AsInteger := 30010;
  memImportResults.FieldByName('Description').Asstring := 'Failed - HOME - Path not found';
  memImportResults.post;

  memImportResults.Insert;
  memImportResults.FieldByName('ID').AsInteger := 30100;
  memImportResults.FieldByName('Description').Asstring := 'Failed - RoomReservation not found';
  memImportResults.post;

  memImportResults.Insert;
  memImportResults.FieldByName('ID').AsInteger := 30200;
  memImportResults.FieldByName('Description').Asstring := 'Failed - INSERT Draft invoice';
  memImportResults.post;

  memImportResults.Insert;
  memImportResults.FieldByName('ID').AsInteger := 30300;
  memImportResults.FieldByName('Description').Asstring := 'Failed - INSERT InvoiceLinbe';
  memImportResults.post;

  memImportResults.SortedField := 'ID';
end;

procedure Td.memImportTypes_Fill;
begin
  if memImportTypes.Active then
    memImportTypes.Close();
  memImportTypes.Open;

  memImportTypes.Append;
  memImportTypes.FieldByName('ID').AsInteger := 10000;
  memImportTypes.FieldByName('Description').Asstring := 'POS InvoiceLine';
  memImportTypes.post;

  memImportTypes.Insert;
  memImportTypes.FieldByName('ID').AsInteger := 10010;
  memImportTypes.FieldByName('Description').Asstring := 'POS InvoiceLine - HOME';
  memImportTypes.post;

  memImportTypes.Insert;
  memImportTypes.FieldByName('ID').AsInteger := 10100;
  memImportTypes.FieldByName('Description').Asstring := 'POS InvoiceLine - Snerta';
  memImportTypes.post;

  memImportTypes.Insert;
  memImportTypes.FieldByName('ID').AsInteger := 10200;
  memImportTypes.FieldByName('Description').Asstring := 'POS InvoiceLine - MerkurPos';
  memImportTypes.post;

  memImportTypes.SortedField := 'ID';
end;

procedure Td.IH_getPaymentsTypes(InvoiceNumber: Integer; var PayTypes, PayTypeDescription, payGroups,
  payGroupDescription: string);
var
  rSet: TRoomerDataSet;
  s: string;
  PayType: string;
  PayGroup: string;
begin
  rSet := CreateNewDataSet;
  try
    // s := s+ ' SELECT '+chr(10);
    // s := s+ '     InvoiceHeads.InvoiceNumber '+chr(10);
    // s := s+ '   , Payments.Description '+chr(10);
    // s := s+ '   , Payments.PayType '+chr(10);
    // s := s+ '   , Paytypes.Description AS PayTypeDescription '+chr(10);
    // s := s+ '   , Paytypes.PayGroup '+chr(10);
    // s := s+ '   , PayGroups.Description AS PayGroupDescription '+chr(10);
    // s := s+ ' FROM '+chr(10);
    // s := s+ '   Paytypes '+chr(10);
    // s := s+ '      INNER JOIN Payments ON Paytypes.PayType = Payments.PayType '+chr(10);
    // s := s+ '      INNER JOIN PayGroups ON Paytypes.PayGroup = dbo.PayGroups.PayGroup '+chr(10);
    // s := s+ '      RIGHT OUTER JOIN InvoiceHeads ON Payments.InvoiceNumber = InvoiceHeads.InvoiceNumber '+chr(10);
    // s := s+ ' WHERE '+chr(10);
    // s := s+ '   (dbo.InvoiceHeads.InvoiceNumber = '+_db(InvoiceNumber)+') '+chr(10);
    s := format(select_IH_getPaymentsTypes, [InvoiceNumber]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      PayTypes := '';
      payGroups := '';

      while not rSet.eof do
      begin
        PayType := rSet.FieldByName('PayType').Asstring;
        PayTypeDescription := rSet.FieldByName('PayTypeDescription').Asstring;
        PayGroup := rSet.FieldByName('PayGroup').Asstring;
        payGroupDescription := rSet.FieldByName('PayGroupDescription').Asstring;

        PayTypes := PayTypes + PayType + ',';
        payGroups := payGroups + PayGroup + ',';
        rSet.next;
      end;

      if PayTypes <> '' then
        delete(PayTypes, length(PayTypes), 1);
      if payGroups <> '' then
        delete(payGroups, length(payGroups), 1);

      if pos(',', payGroups) > 0 then
        payGroupDescription := 'Miscellaneous';
      if pos(',', PayTypes) > 0 then
        PayTypeDescription := 'Miscellaneous';
    end;
  finally
    freeandnil(rSet);
  end;
end;

Function Td.IA_ActionCount(InvoiceNumber, actionID: Integer): Integer;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := 0;

  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+chr(10);
    // s := s + '   COUNT(ID) AS invCount '+chr(10);
    // s := s + '    , InvoiceNumber '+chr(10);
    // s := s + '    , ActionID '+chr(10);
    // s := s + '  FROM '+chr(10);
    // s := s + '    tblInvoiceActions '+chr(10);
    // s := s + '  GROUP BY InvoiceNumber, ActionID '+chr(10);
    // s := s + '  HAVING '+chr(10);
    // s := s + '    (InvoiceNumber = ' + _Db(InvoiceNumber) + ') AND (ActionID=1001) '+chr(10);
    s := format(select_IA_ActionCount, [InvoiceNumber]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('invCount').AsInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.getRoomTypeColors(sRoomType: string): recStatusAttr;
var
  iColor: Integer;
begin
  g.initStatusAttrRec(result);

  // result.backgroundColor := g.qColorOneDayRoomColBack;
  // result.fontColor := g.qColorOneDayRoomColFont;
  //
  // sColor := '';

  // ATH777
  iColor := glb.LocateRoomTypeColor(sRoomType);
  if iColor > -1 then
  begin
    result.backgroundColor := iColor;
    result.fontColor := InverseColor(iColor);
  end
  else
  begin
    result.backgroundColor := g.qColorOneDayRoomColBack;
    result.fontColor := g.qColorOneDayRoomColFont;
  end;
end;

/// //////////////////////////////////////////////////////////////////////////////////////////
///
///
///
///
///
/// ///////////////////////////////////////////////////////////////////////////////////////////

procedure Td.ctrlGetGlobalValues;
var
  rSet: TRoomerDataSet;
begin
  g.qArrivalDateRulesPrice := False;
  g.qBreakfastInclDefault := False;
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

  // s := s + ' SELECT * '+chr(10);
  // s := s + 'FROM Control  '+chr(10);

  rSet := glb.ControlSet; // CreateNewDataSet;
  // try
  // s := format(select_ctrlGetGlobalValues , []);
  // if hData.rSet_bySQL(rSet,s) then
  // begin
  g.qOneDayRowHeight := rSet.FieldByName('GrandRowHeight').AsInteger;
  g.qPeriodRowHeight := rSet.FieldByName('FiveDayRowHeight').AsInteger;
  g.qPeriodColWidth := rSet.FieldByName('FiveDayColWidth').AsInteger;
  g.qPeriodColCount := rSet.FieldByName('FiveDayColCount').AsInteger;

  g.qPeriodPrompt := rSet.FieldByName('FiveDayPrompt').AsInteger;

  g.qArrivalDateRulesPrice := rSet['ArrivalDateRulesPrice'];
  g.qBreakfastInclDefault := rSet['BreakfastInclDefault'];
  g.qPhoneUseItem := rSet.FieldByName('PhoneUseItem').Asstring;
  g.qPaymentItem := rSet.FieldByName('PaymentItem').Asstring;
  g.qNativeCurrency := rSet.FieldByName('NativeCurrency').Asstring;
  g.qRoomRentItem := rSet.FieldByName('RoomRentItem').Asstring;
  g.qCountry := rSet.FieldByName('Country').Asstring;
  g.qBreakFastItem := rSet.FieldByName('BreakFastItem').Asstring;
  g.qStayTaxItem := rSet.FieldByName('stayTaxItem').Asstring;
  g.qStayTaxPerPerson := rSet['stayTaxPerPerson'];
  g.qDiscountItem := rSet.FieldByName('DiscountItem').Asstring;
  g.qLocalRoomRent := rSet.FieldByName('LocalRoomRent').Asstring;
  g.qGreenColor := rSet.FieldByName('GreenColor').Asstring;
  g.qPurpleColor := rSet.FieldByName('PurpleColor').Asstring;
  g.qFuchsiaColor := rSet.FieldByName('FuchsiaColor').Asstring;

  try
    g.qPeriodDateformat1 := rSet.FieldByName('FiveDayDateformat1').Asstring;
  except
    g.qPeriodDateformat1 := 'MMM YY';
  end;

  try
    g.qPeriodDateformat2 := rSet.FieldByName('FiveDayDateformat2').Asstring;
  except
    g.qPeriodDateformat2 := 'DD ddd';
  end;

  try
    g.qNameOrder := rSet.FieldByName('Nameorder').AsInteger;
  except
    g.qNameOrder := 0;
  end;

  try
    g.qInvPriceGroup := rSet.FieldByName('InvPriceGroup').Asstring;;
  except
    g.qInvPriceGroup := 'REI';
  end;

  try
    g.qUseSetUnclean := rSet.FieldByName('UseSetUnclean').asBoolean;
  except
    g.qUseSetUnclean := True;
  end;

  try
    g.qNameOrderPeriod := rSet.FieldByName('NameOrderPeriod').AsInteger;
  except
    g.qNameOrderPeriod := 0;
  end;

  try
    g.qRackCustomer := rSet.FieldByName('RackCustomer').Asstring;
  except
    g.qRackCustomer := '0';
  end;
  if g.qRackCustomer = '' then
    g.qRackCustomer := '0';

  try
    g.qExcluteWaitingList := rSet.FieldByName('ExcluteWaitingList').asBoolean;
  except
    g.qExcluteWaitingList := False;
  end;
  try
    g.qExcluteAllotment := rSet.FieldByName('ExcluteAllotment').asBoolean;
  except
    g.qExcluteAllotment := False;
  end;
  try
    g.qExcluteOrder := rSet.FieldByName('ExcluteOrder').asBoolean;
  except
    g.qExcluteOrder := False;
  end;
  try
    g.qExcluteDeparted := rSet.FieldByName('ExcluteDeparted').asBoolean;
  except
    g.qExcluteDeparted := False;
  end;
  try
    g.qExcluteGuest := rSet.FieldByName('ExcluteGuest').asBoolean;
  except
    g.qExcluteGuest := False;
  end;
  try
    g.qExcluteBlocked := rSet.FieldByName('ExcluteBlocked').asBoolean;
  except
    g.qExcluteBlocked := False;
  end;
  try
    g.qExcluteNoshow := rSet.FieldByName('ExcluteNoshow').asBoolean;
  except
    g.qExcluteNoshow := False;
  end;
  // end;
  // finally
  // freeandnil(rSet);
  // end;
end;

function Td.ChkCompany(Company, CompanyName: string): boolean;
var
  s: string;
  dbCompany: string;
  dbCompanyName: string;
  rSet: TRoomerDataSet;
begin
  result := False;
  dbCompany := '';
  dbCompanyName := '';

  rSet := CreateNewDataSet;
  try
    s := format(select_ChkCompany, []);
    if hData.rSet_bySQL(rSet, s) then
    begin
      dbCompany := rSet.FieldByName('CompanyID').Asstring;
      dbCompanyName := rSet.FieldByName('CompanyName').Asstring;
      result := (LowerCase(Company) = LowerCase(dbCompany)) and (LowerCase(CompanyName) = LowerCase(dbCompanyName))
    end;
  finally
    freeandnil(rSet);
  end;
  // s := s + ' SELECT '+chr(10);
  // s := s + '    CompanyID '+chr(10);
  // s := s + '  , CompanyName '+chr(10);
  // s := s + 'FROM Control '+chr(10);
end;

procedure Td.ctrlSetInteger(aField: string; ivalue: Integer);
var
  rSet: TRoomerDataSet;
  s: string;
begin
  rSet := CreateNewDataSet;
  try
    // s := s + 'SELECT ' + aField + ' '+chr(10);
    // s := s + 'FROM Control  '+chr(10);
    s := format(select_ctrlSetInteger, [aField]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      rSet.edit;
      rSet.FieldByName(aField).AsInteger := ivalue;
      rSet.post; // ID ADDED
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure Td.ctrlSetString(aField: string; svalue: string);
var
  rSet: TRoomerDataSet;
  s: string;
begin
  rSet := CreateNewDataSet;
  try
    // s := s + 'SELECT ' + aField + ' '+chr(10);
    // s := s + 'FROM Control  '+chr(10);
    s := format(select_ctrlSetString, [aField]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      rSet.edit;
      rSet.FieldByName(aField).Asstring := svalue;
      rSet.post; // ID ADDED
    end;
  finally
    freeandnil(rSet);
  end;
end;

// ******************************************************************************************

procedure Td.Default_StatusAttr_Blocked;
begin
  g.qStatusAttr_Blocked.backgroundColor := clOlive;
  g.qStatusAttr_Blocked.fontColor := clWhite;
  g.qStatusAttr_Blocked.isBold := True;
  g.qStatusAttr_Blocked.isItalic := False;
  g.qStatusAttr_Blocked.isUnderline := False;
  g.qStatusAttr_Blocked.isStrikeOut := False;
end;

procedure Td.Default_StatusAttr_NoShow;
begin
  g.qStatusAttr_NoShow.backgroundColor := clRed;
  g.qStatusAttr_NoShow.fontColor := clYellow;
  g.qStatusAttr_NoShow.isBold := True;
  g.qStatusAttr_NoShow.isItalic := False;
  g.qStatusAttr_NoShow.isUnderline := False;
  g.qStatusAttr_NoShow.isStrikeOut := False;
end;

procedure Td.Default_StatusAttr_Option;
begin
  g.qStatusAttr_Option.backgroundColor := clYellow;
  g.qStatusAttr_Option.fontColor := clBlack;
  g.qStatusAttr_Option.isBold := False;
  g.qStatusAttr_Option.isItalic := False;
  g.qStatusAttr_Option.isUnderline := False;
  g.qStatusAttr_Option.isStrikeOut := False;
end;

procedure Td.Default_StatusAttr_WaitingList;
begin
  g.qStatusAttr_WaitingList.backgroundColor := clWhite;
  g.qStatusAttr_WaitingList.fontColor := clBlue;
  g.qStatusAttr_WaitingList.isBold := True;
  g.qStatusAttr_WaitingList.isItalic := True;
  g.qStatusAttr_WaitingList.isUnderline := False;
  g.qStatusAttr_WaitingList.isStrikeOut := False;
end;

procedure Td.Default_StatusAttr_Allotment;
begin
  g.qStatusAttr_Allotment.backgroundColor := clWhite;
  g.qStatusAttr_Allotment.fontColor := clRed;
  g.qStatusAttr_Allotment.isBold := False;
  g.qStatusAttr_Allotment.isItalic := False;
  g.qStatusAttr_Allotment.isUnderline := False;
  g.qStatusAttr_Allotment.isStrikeOut := False;
end;

procedure Td.Default_StatusAttr_Departed;
begin
  g.qStatusAttr_Departed.backgroundColor := clTeal;
  g.qStatusAttr_Departed.fontColor := clWhite;
  g.qStatusAttr_Departed.isBold := False;
  g.qStatusAttr_Departed.isItalic := True;
  g.qStatusAttr_Departed.isUnderline := False;
  g.qStatusAttr_Departed.isStrikeOut := False;
end;

procedure Td.Default_StatusAttr_Departing;
begin
  g.qStatusAttr_Departing.backgroundColor := clGray;
  g.qStatusAttr_Departing.fontColor := clWhite;
  g.qStatusAttr_Departing.isBold := False;
  g.qStatusAttr_Departing.isItalic := True;
  g.qStatusAttr_Departing.isUnderline := False;
  g.qStatusAttr_Departing.isStrikeOut := False;
end;

procedure Td.Default_StatusAttr_GuestLeavingNextDay;
begin
  g.qStatusAttr_GuestLeavingNextDay.backgroundColor := clGreen;
  g.qStatusAttr_GuestLeavingNextDay.fontColor := clWhite;
  g.qStatusAttr_GuestLeavingNextDay.isBold := False;
  g.qStatusAttr_GuestLeavingNextDay.isItalic := False;
  g.qStatusAttr_GuestLeavingNextDay.isUnderline := False;
  g.qStatusAttr_GuestLeavingNextDay.isStrikeOut := False;
end;

procedure Td.Default_StatusAttr_GuestStaying;
begin
  g.qStatusAttr_GuestStaying.backgroundColor := clBlue;
  g.qStatusAttr_GuestStaying.fontColor := clWhite;
  g.qStatusAttr_GuestStaying.isBold := False;
  g.qStatusAttr_GuestStaying.isItalic := False;
  g.qStatusAttr_GuestStaying.isUnderline := False;
  g.qStatusAttr_GuestStaying.isStrikeOut := False;
end;

procedure Td.Default_StatusAttr_ArrivingOtherLeaving;
begin
  g.qStatusAttr_ArrivingOtherLeaving.backgroundColor := clAqua;
  g.qStatusAttr_ArrivingOtherLeaving.fontColor := clBlack;
  g.qStatusAttr_ArrivingOtherLeaving.isBold := False;
  g.qStatusAttr_ArrivingOtherLeaving.isItalic := False;
  g.qStatusAttr_ArrivingOtherLeaving.isUnderline := False;
  g.qStatusAttr_ArrivingOtherLeaving.isStrikeOut := False;
end;

procedure Td.Default_StatusAttr_order;
begin
  g.qStatusAttr_Order.backgroundColor := clRed;
  g.qStatusAttr_Order.fontColor := clWhite;
  g.qStatusAttr_Order.isBold := True;
  g.qStatusAttr_Order.isItalic := False;
  g.qStatusAttr_Order.isUnderline := False;
  g.qStatusAttr_Order.isStrikeOut := False;
end;

procedure Td.Default_StatusAttr_canceled;
begin
  g.qStatusAttr_Canceled.backgroundColor := clBlack;
  g.qStatusAttr_Canceled.fontColor := clSilver;
  g.qStatusAttr_Canceled.isBold := False;
  g.qStatusAttr_Canceled.isItalic := False;
  g.qStatusAttr_Canceled.isUnderline := False;
  g.qStatusAttr_Canceled.isStrikeOut := False;
end;

procedure Td.Default_StatusAttr_tmp1;
begin
  g.qStatusAttr_Tmp1.backgroundColor := clPurple;
  g.qStatusAttr_Tmp1.fontColor := clWhite;
  g.qStatusAttr_Tmp1.isBold := False;
  g.qStatusAttr_Tmp1.isItalic := False;
  g.qStatusAttr_Tmp1.isUnderline := False;
  g.qStatusAttr_Tmp1.isStrikeOut := False;
end;

procedure Td.Default_StatusAttr_tmp2;
begin
  g.qStatusAttr_Tmp2.backgroundColor := clFuchsia;
  g.qStatusAttr_Tmp2.fontColor := clBlack;
  g.qStatusAttr_Tmp2.isBold := False;
  g.qStatusAttr_Tmp2.isItalic := False;
  g.qStatusAttr_Tmp2.isUnderline := False;
  g.qStatusAttr_Tmp2.isStrikeOut := False;
end;


// -------------------------------------------------------------------------------

procedure Td.Get_All_StatusAttributes;
var
  sTmp: String;
  rSet: TRoomerDataSet;
begin
//  sTmp := 'SELECT StatusAttr_Blocked, StatusAttr_GuestStaying, StatusAttr_GuestLeavingNextDay, ' +
//    'StatusAttr_Departed, StatusAttr_Departing, StatusAttr_Allotment, StatusAttr_Waitinglist, ' +
//    'StatusAttr_NoShow, StatusAttr_ArrivingOtherLeaving, StatusAttr_Order, StatusAttr_Canceled, StatusAttr_Tmp1,StatusAttr_Tmp2, StatusAttr_WaitingListNonOptional FROM control';

  glb.RefreshTableByName('control');
  rSet := glb.ControlSet; // CreateNewDataSet;
  rSet.First;
  try
    // if hData.rSet_bySQL(rSet,sTmp) then
    // begin
    g.qStatusAttr_Blocked := g.strToStatusAttr(trim(rSet.FieldByName('StatusAttr_Blocked').Asstring));
    g.qStatusAttr_GuestStaying := g.strToStatusAttr(trim(rSet.FieldByName('StatusAttr_GuestStaying').Asstring));
    g.qStatusAttr_GuestLeavingNextDay :=
      g.strToStatusAttr(trim(rSet.FieldByName('StatusAttr_GuestLeavingNextDay').Asstring));
    g.qStatusAttr_Departed := g.strToStatusAttr(trim(rSet.FieldByName('StatusAttr_Departed').Asstring));
    g.qStatusAttr_Departing := g.strToStatusAttr(trim(rSet.FieldByName('StatusAttr_Departing').Asstring));
    g.qStatusAttr_Allotment := g.strToStatusAttr(trim(rSet.FieldByName('StatusAttr_Allotment').Asstring));
    g.qStatusAttr_Option := g.strToStatusAttr(trim(rSet.FieldByName('StatusAttr_Waitinglist').Asstring));
    g.qStatusAttr_NoShow := g.strToStatusAttr(trim(rSet.FieldByName('StatusAttr_NoShow').Asstring));
    g.qStatusAttr_ArrivingOtherLeaving :=
      g.strToStatusAttr(trim(rSet.FieldByName('StatusAttr_ArrivingOtherLeaving').Asstring));
    g.qStatusAttr_Order := g.strToStatusAttr(trim(rSet.FieldByName('StatusAttr_Order').Asstring));
    g.qStatusAttr_Canceled := g.strToStatusAttr(trim(rSet.FieldByName('StatusAttr_Canceled').Asstring));
    g.qStatusAttr_Tmp1 := g.strToStatusAttr(trim(rSet.FieldByName('StatusAttr_Tmp1').Asstring));
    g.qStatusAttr_Tmp2 := g.strToStatusAttr(trim(rSet.FieldByName('StatusAttr_Tmp2').Asstring));
    sTmp := trim(rSet.FieldByName('StatusAttr_WaitingListNonOptional').Asstring);
    if sTmp = '' then
      Default_StatusAttr_WaitingList
    else
      g.qStatusAttr_WaitingList := g.strToStatusAttr(sTmp);

    // end;
  finally
    // freeandnil(Rset);
  end;

end;
// -------------------------------------------------------------------

procedure Td.save_StatusAttr_Blocked;
var
  s: string;
  sTmp: string;
begin
  sTmp := g.StatusAttrToStr(g.qStatusAttr_Blocked);
  s := '';
  s := s + ' UPDATE control ' + chr(10);
  s := s + ' SET ' + chr(10);
  s := s + '  StatusAttr_Blocked = ' + _db(sTmp) + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

procedure Td.save_StatusAttr_NoShow;
var
  s: string;
  sTmp: string;
begin
  sTmp := g.StatusAttrToStr(g.qStatusAttr_NoShow);
  s := '';
  s := s + ' UPDATE control ' + chr(10);
  s := s + ' SET ' + chr(10);
  s := s + '  StatusAttr_NoShow = ' + _db(sTmp) + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

procedure Td.save_StatusAttr_Waitinglist;
var
  s: string;
  sTmp: string;
begin
  sTmp := g.StatusAttrToStr(g.qStatusAttr_Option);
  s := '';
  s := s + ' UPDATE control ' + chr(10);
  s := s + ' SET ' + chr(10);
  s := s + '  StatusAttr_WaitingList = ' + _db(sTmp) + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

procedure Td.save_StatusAttr_WaitinglistNonOptional;
var
  s: string;
  sTmp: string;
begin
  sTmp := g.StatusAttrToStr(g.qStatusAttr_WaitingList);
  s := '';
  s := s + ' UPDATE control ' + chr(10);
  s := s + ' SET ' + chr(10);
  s := s + '  StatusAttr_WaitingListNonOptional = ' + _db(sTmp) + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

procedure Td.save_StatusAttr_Allotment;
var
  s: string;
  sTmp: string;
begin
  sTmp := g.StatusAttrToStr(g.qStatusAttr_Allotment);
  s := '';
  s := s + ' UPDATE control ' + chr(10);
  s := s + ' SET ' + chr(10);
  s := s + '  StatusAttr_Allotment = ' + _db(sTmp) + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

procedure Td.save_StatusAttr_Departed;
var
  s: string;
  sTmp: string;
begin
  sTmp := g.StatusAttrToStr(g.qStatusAttr_Departed);
  s := '';
  s := s + ' UPDATE control ' + chr(10);
  s := s + ' SET ' + chr(10);
  s := s + '  StatusAttr_Departed = ' + _db(sTmp) + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

procedure Td.save_StatusAttr_Departing;
var
  s: string;
  sTmp: string;
begin
  sTmp := g.StatusAttrToStr(g.qStatusAttr_Departing);

  s := '';
  s := s + ' UPDATE control ' + chr(10);
  s := s + ' SET ' + chr(10);
  s := s + '  StatusAttr_Departing = ' + _db(sTmp) + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

procedure Td.save_StatusAttr_GuestLeavingNextDay;
var
  s: string;
  sTmp: string;
begin
  sTmp := g.StatusAttrToStr(g.qStatusAttr_GuestLeavingNextDay);
  s := '';
  s := s + ' UPDATE control ' + chr(10);
  s := s + ' SET ' + chr(10);
  s := s + '  StatusAttr_GuestLeavingNextDay = ' + _db(sTmp) + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;

end;

procedure Td.save_StatusAttr_GuestStaying;
var
  s: string;
  sTmp: string;
begin
  sTmp := g.StatusAttrToStr(g.qStatusAttr_GuestStaying);
  s := '';
  s := s + ' UPDATE control ' + chr(10);
  s := s + ' SET ' + chr(10);
  s := s + '  StatusAttr_GuestStaying = ' + _db(sTmp) + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;

end;

procedure Td.save_StatusAttr_ArrivingOtherLeaving;
var
  s: string;
  sTmp: string;
begin
  sTmp := g.StatusAttrToStr(g.qStatusAttr_ArrivingOtherLeaving);

  s := '';
  s := s + ' UPDATE control ' + chr(10);
  s := s + ' SET ' + chr(10);
  s := s + '  StatusAttr_ArrivingOtherLeaving = ' + _db(sTmp) + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

procedure Td.save_StatusAttr_order;
var
  s: string;
  sTmp: string;
begin
  sTmp := g.StatusAttrToStr(g.qStatusAttr_Order);

  s := '';
  s := s + ' UPDATE control ' + chr(10);
  s := s + ' SET ' + chr(10);
  s := s + '  StatusAttr_Order = ' + _db(sTmp) + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

procedure Td.save_StatusAttr_Canceled;
var
  s: string;
  sTmp: string;
begin
  sTmp := g.StatusAttrToStr(g.qStatusAttr_Canceled);

  s := '';
  s := s + ' UPDATE control ' + chr(10);
  s := s + ' SET ' + chr(10);
  s := s + '  StatusAttr_canceled = ' + _db(sTmp) + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

procedure Td.save_StatusAttr_Tmp1;
var
  s: string;
  sTmp: string;
begin
  sTmp := g.StatusAttrToStr(g.qStatusAttr_Tmp1);

  s := '';
  s := s + ' UPDATE control ' + chr(10);
  s := s + ' SET ' + chr(10);
  s := s + '  StatusAttr_tmp1 = ' + _db(sTmp) + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

procedure Td.save_StatusAttr_Tmp2;
var
  s: string;
  sTmp: string;
begin
  sTmp := g.StatusAttrToStr(g.qStatusAttr_Tmp2);

  s := '';
  s := s + ' UPDATE control ' + chr(10);
  s := s + ' SET ' + chr(10);
  s := s + '  StatusAttr_Tmp2 = ' + _db(sTmp) + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;


// ---------------------------------------------------------------------------------

function Td.RV_Upd_Name(res: Integer; newName: string): boolean;
var
  s: string;
begin
  result := True;

  // ATHOLD 091120  Setja inn Rollback

  s := '';
  s := s + ' UPDATE reservations ' + chr(10);
  s := s + ' SET ' + chr(10);
  s := s + ' [Name] = ' + _db(newName) + ' ' + chr(10);
  s := s + ' WHERE Reservation = ' + inttostr(res) + ' ' + chr(10);
  if not cmd_bySQL(s) then
  begin
    result := False;
  end;

  s := '';
  s := s + ' UPDATE persons ' + chr(10);
  s := s + ' SET ' + chr(10);
  s := s + ' [Surname] = ' + _db(newName) + ' ' + chr(10);
  s := s + ' WHERE Reservation = ' + inttostr(res) + ' ' + chr(10);
  if not cmd_bySQL(s) then
  begin
    result := False;
  end;
end;

function Td.RR_Upd_CurrencyRoomPrice(iRoomReservation: Integer; aDate: string; Currency: string;
  Convert: Double): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
  roomRate: Double;
  Discount: Double;
  isPercentage: boolean;
  paid: boolean;
  sql: string;
begin
  result := False;
  if iRoomReservation < 1 then
    exit;

  rSet := CreateNewDataSet;
  try

    sql :=
      'SELECT '#10 +
      '  roomreservation '#10 +
      ' ,Currency '#10 +
      ' ,roomRate '#10 +
      ' ,Discount '#10 +
      ' ,isPercentage '#10 +
      ' ,paid '#10 +
      'FROM '#10 +
      '  roomsdate '#10 +
      'WHERE '#10 +
      '  (paid=0) AND (roomreservation=%d) and (aDate=%s) '#10 +
      '   AND (ResFlag <> ' + _db(STATUS_DELETED) + ' ) '#10; // **zxhj b�tt vi�

    s := format(sql, [iRoomReservation, _db(aDate)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      roomRate := rSet.GetFloatValue(rSet.FieldByName('roomRate'));
      Discount := rSet.GetFloatValue(rSet.FieldByName('Discount'));
      isPercentage := rSet.FieldByName('isPercentage').asBoolean;
      paid := rSet.FieldByName('paid').asBoolean;
      if not paid then
      begin
        roomRate := roomRate * Convert;

        if not isPercentage then
          Discount := Discount * Convert;
        s := '';
        s := s + ' UPDATE roomsdate '#10;
        s := s + ' SET '#10;
        s := s + '  Currency=' + _db(Currency) + ' '#10;
        s := s + ' ,roomRate=' + _db(roomRate) + ' '#10;
        s := s + ' ,Discount=' + _db(Discount) + ' '#10;
        s := s + ' WHERE '#10;
        s := s + '   (RoomReservation = ' + inttostr(iRoomReservation) + ') '#10;
        s := s + ' AND (Adate=' + _db(aDate) + ') ';
        s := s + ' AND (ResFlag <> ' + _db(STATUS_DELETED) + ' ) '#10;
        /// /**zxhj b�tt vi�

        if not cmd_bySQL(s) then
        begin
        end;
        result := True;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RR_Upd_MemoTexts(iRoomReservation: Integer; HiddenInfo: string): boolean;
var
  s: string;
begin
  result := False;
  if iRoomReservation < 1 then
    exit;
  result := True;
  s := '';
  s := s + ' UPDATE roomreservations ' + chr(10);
  s := s + ' SET ' + chr(10);
  s := s + ' HiddenInfo=' + _db(HiddenInfo) + ' ' + chr(10);
  s := s + ' WHERE (roomreservation = ' + inttostr(iRoomReservation) + ') ' + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

procedure Td.RR_Upd_FirstGuestName(iRoomReservation: Integer; newName: string);
var
  rSet: TRoomerDataSet;
  s: string;
  aName: string;
begin
  rSet := CreateNewDataSet;
  try
    // s := s + 'SELECT * '+chr(10);
    // s := s + 'FROM persons '+chr(10);
    // s := s + 'WHERE RoomReservation = ' + inttostr(iRoomReservation)+chr(10);
    s := format(select_RR_Upd_FirstGuestName, [iRoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      aName := rSet.FieldByName('Name').Asstring;
      rSet.edit;
      rSet.FieldByName('Name').Asstring := newName;
      rSet.post; // ID OK *
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RR_Upd_Package(iRoomReservation: Integer; package: string): boolean;
var
  s: string;
begin
  result := False;
  if iRoomReservation < 1 then
    exit;
  s := '';
  s := s + ' UPDATE roomreservations ' + chr(10);
  s := s + ' SET ' + chr(10);
  s := s + ' Package=' + _db(package) + ' ' + chr(10);
  s := s + ' WHERE (roomreservation = ' + inttostr(iRoomReservation) + ') ' + chr(10);
  result := cmd_bySQL(s)
end;

function Td.RR_clear_Package(iRoomReservation: Integer; package: string): boolean;
var
  s: string;
begin
  result := False;
  if iRoomReservation < 1 then
    exit;
  s := '';
  s := s + ' UPDATE roomreservations ' + chr(10);
  s := s + ' SET ' + chr(10);
  s := s + ' Package=' + _db(package) + ' ' + chr(10);
  s := s + ' WHERE (roomreservation = ' + inttostr(iRoomReservation) + ') ' + chr(10);
  result := cmd_bySQL(s)
end;


// **********************************************************

function Td.RR_GetNumberOfRooms(iReservation: Integer): Integer;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT count(RoomReservation) AS Cnt FROM RoomReservations '+chr(10);
    // s := s + ' WHERE Reservation = ' + inttostr(iReservation)+chr(10);
    s := format(select_RR_GetNumberOfRooms, [iReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('Cnt').AsInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RR_GetGuestCount(iRoomReservation: Integer): Integer;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT count(Person) AS Cnt FROM Persons'+chr(10);
    // s := s + ' WHERE  RoomReservation = ' + inttostr(iRoomReservation)+chr(10);
    s := format(select_RR_GetGuestCount, [iRoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('Cnt').AsInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RR_GetRoomNr(iRoomReservation: Integer): string;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := '';
  rSet := CreateNewDataSet;
  try
    // s := s + 'SELECT Room FROM RoomReservations'+chr(10);
    // s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation)+chr(10);
    s := format(select_RR_GetRoomNr, [iRoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('room').Asstring;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RR_GetRoomArrivalAndDeparture(iRoomReservation: Integer; var Room: String;
  var Arrival, departure: TdateTime): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := False;
  rSet := CreateNewDataSet;
  try
    // s := s + 'SELECT Room FROM RoomReservations'+chr(10);
    // s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation)+chr(10);
    s := 'SELECT roomres.Room, ' +
      '(SELECT ADate FROM roomsdate WHERE RoomReservation=rr.RoomReservation ORDER BY ADate LIMIT 1) AS Arrival, ' +
      'DATE_ADD((SELECT ADate FROM roomsdate WHERE RoomReservation=rr.RoomReservation ORDER BY ADate DESC LIMIT 1), INTERVAL 1 DAY) AS Departure '
      +
      'FROM roomreservations roomres, ' +
      '(SELECT ' + inttostr(iRoomReservation) + ' AS RoomReservation) rr ' +
      'WHERE roomres.RoomReservation = rr.RoomReservation';
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := True;
      Room := rSet.FieldByName('room').Asstring;
      Arrival := uDateUtils.SqlStringToDate(rSet.FieldByName('Arrival').Asstring);
      departure := uDateUtils.SqlStringToDate(rSet.FieldByName('Departure').Asstring);
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RR_GetArrivalDate(iRoomReservation: Integer): Tdate;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := date;
  rSet := CreateNewDataSet;
  try
    // s := s + 'SELECT rrArrival FROM RoomReservations'+chr(10);
    // s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation)+chr(10);
    s := format(select_RR_GetArrivalDate, [iRoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('rrArrival').asDateTime;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RR_GetDepartureDate(iRoomReservation: Integer): Tdate;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 1;
  rSet := CreateNewDataSet;
  try
    // s := s + 'SELECT rrDeparture FROM RoomReservations'+chr(10);
    // s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation)+chr(10);
    s := format(select_RR_GetDepartureDate, [iRoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('rrDeparture').asDateTime;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RR_getDates(iRoomReservation: Integer): recResDateHolder;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result.reservation := 0;
  result.RoomReservation := 0;
  result.Arrival := 1;
  result.departure := 1;
  result.status := '';

  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+chr(10);
    // s := s + '   Reservation '+chr(10);
    // s := s + ' , Status '+chr(10);
    // s := s + ' , rrArrival '+chr(10);
    // s := s + ' , rrDeparture '+chr(10);
    // s := s + ' FROM RoomReservations '+chr(10);
    // s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation) + ' '+chr(10);
    s := format(select_RR_getDates, [iRoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result.Arrival := rSet.FieldByName('rrArrival').asDateTime;
      result.departure := rSet.FieldByName('rrDeparture').asDateTime;
      result.RoomReservation := iRoomReservation;
      result.reservation := rSet.FieldByName('Reservation').AsInteger;
      result.status := rSet.FieldByName('Status').Asstring;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RV_getDates(iReservation: Integer): recResDateHolder;
var
  rSet: TRoomerDataSet;

  s: string;
begin
  result.reservation := 0;
  result.RoomReservation := 0;
  result.Arrival := 1;
  result.departure := 1;
  result.status := '';

  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+chr(10);
    // s := s + '   Reservation '+chr(10);
    // s := s + ' ,  Arrival '+chr(10);
    // s := s + ' ,  Departure '+chr(10);
    // s := s + ' FROM Reservations '+chr(10);
    // s := s + ' WHERE Reservation = ' + _db(iReservation) + ' '+chr(10);
    s := format(select_RV_getDates, [iReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      s := rSet.FieldByName('Arrival').Asstring;
      result.Arrival := _dbdateToDate(s);
      s := rSet.FieldByName('Departure').Asstring;
      result.departure := _dbdateToDate(s);
      result.RoomReservation := -1;
      result.reservation := iReservation;
      result.status := '';
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RR_GetReservationName(iRoomReservation: Integer): string;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := '';
  rSet := CreateNewDataSet;
  try
    s := '';
    // s := s + ' SELECT '+chr(10);
    // s := s + '   reservations.[Name] '+chr(10);
    // s := s + ' FROM  Reservations '+chr(10);
    // s := s + '           INNER JOIN '+chr(10);
    // s := s + '              RoomReservations ON Reservations.Reservation = RoomReservations.Reservation '+chr(10);
    // s := s + ' WHERE '+chr(10);
    // s := s + '   (RoomReservations.RoomReservation = ' + inttostr(iRoomReservation) + ' ) '+chr(10);
    s := format(select_RR_GetReservationName, [iRoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('Name').Asstring;
    end
  finally
    freeandnil(rSet);
  end;
end;

function Td.RR_GetMemoText(iRoomReservation: Integer; var RoomNotes: string; FieldName: String = 'HiddenInfo'): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := False;
  RoomNotes := '';

  rSet := CreateNewDataSet;
  try
    s := format(select_RR_GetMemoText, [iRoomReservation]);
    copytoclipboard(s);

    if hData.rSet_bySQL(rSet, s) then
    begin
      RoomNotes := rSet[FieldName];
      result := True;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RR_GetMemoBothTextForRoom(iRoomReservation: Integer; var RoomNotes, ChannelRequest: string): boolean;
var
  s: string;
  rSet: TRoomerDataSet;
begin
  result := False;
  RoomNotes := '';
  ChannelRequest := '';

  rSet := CreateNewDataSet;
  try
    s := format(select_RR_GetMemoText, [iRoomReservation]);
    copytoclipboard(s);

    if hData.rSet_bySQL(rSet, s) then
    begin
      RoomNotes := rSet['HiddenInfo'];
      ChannelRequest := rSet['PMInfo'];
      result := True;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RR_GetFirstGuestName(iRoomReservation: Integer): string;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := '';

  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+chr(10);
    // s := s + '   [Name] '+chr(10);
    // s := s + ' FROM '+chr(10);
    // s := s + '   PERSONS '+chr(10);
    // s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation)+chr(10);
    s := format(select_RR_GetFirstGuestName, [iRoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('Name').Asstring;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RR_GetAllGuestNames(iRoomReservation: Integer; showAll: boolean = True; showTotal: boolean = True): string;
var
  rSet: TRoomerDataSet;
  s: string;
  i: Integer;
begin
  result := '';

  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+chr(10);
    // s := s + '   [Name] '+chr(10);
    // s := s + ' FROM '+chr(10);
    // s := s + '   PERSONS '+chr(10);
    // s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation)+chr(10);
    s := format(select_RR_GetAllGuestNames, [iRoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      i := 0;
      while not rSet.eof do
      begin
        inc(i);
        result := result + rSet.FieldByName('Name').Asstring;
        if not showAll then
          Break;
        rSet.next;
        if rSet.eof then
        begin
          result := result + '.';
          if showTotal then
          begin
            result := result + ' Total ' + inttostr(i) + ' guests ';
          end;
        end
        else
        begin
          result := result + ', ';
        end;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RR_GetLastGuestID(iRoomReservation: Integer): Integer;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+chr(10);
    // s := s + '   [Person] '+chr(10);
    // s := s + ' FROM '+chr(10);
    // s := s + '   PERSONS '+chr(10);
    // s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation)+chr(10);
    // s := s + ' ORDER BY Person '+chr(10);
    s := format(select_RR_GetLastGuestID, [iRoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('Person').AsInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RR_GetFirstGuestCountry(iRoomReservation: Integer): string;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := '';
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+chr(10);
    // s := s + '   [Country] '+chr(10);
    // s := s + ' FROM '+chr(10);
    // s := s + '   PERSONS '+chr(10);
    // s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation)+chr(10);
    s := format(select_RR_GetFirstGuestCountry, [iRoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('Country').Asstring;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RR_GetFirstGuestType(iRoomReservation: Integer): string;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := '';

  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+chr(10);
    // s := s + '   [GuestType] '+chr(10);
    // s := s + ' FROM '+chr(10);
    // s := s + '   PERSONS '+chr(10);
    // s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation)+chr(10);
    s := format(select_RR_GetFirstGuestType, [iRoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('GuestType').Asstring;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RR_Upd_GuestCount(iRoomReservation, NewCount: Integer): boolean;
var
  oldCount: Integer;
  addCount: Integer; // +tala B�ta vi� -Tala ey�a
  sCountry: string;

  i: Integer;

  GuestInfo: recCustomerHolderEX;
  iReservation: Integer;
  sType: string;

begin
  result := False;
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
      AddPerson(iRoomReservation, iReservation, GuestInfo, sType, True);
    end;
  end
  else
  begin
    addCount := ABS(addCount);
    for i := 1 to addCount do
    begin
      RemovePerson(iRoomReservation, True);
    end;
  end;
end;

function Td.RR_GetStatus(iRoomReservation: Integer): string;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := '';
  rSet := CreateNewDataSet;
  try
    s := '';
    // s := s + 'SELECT status '+chr(10);
    // s := s + 'FROM RoomReservations '+chr(10);
    // s := s + 'WHERE RoomReservation = ' + inttostr(iRoomReservation)+chr(10);
    s := format(select_RR_GetStatus, [iRoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('Status').Asstring;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RR_GetIsGroopAccount(iRoomReservation: Integer): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := False;
  rSet := CreateNewDataSet;
  try
    // s := s + 'SELECT GroupAccount '+chr(10);
    // s := s + 'FROM RoomReservations '+chr(10);
    // s := s + 'WHERE RoomReservation = ' + inttostr(iRoomReservation)+chr(10);
    s := format(select_RR_GetIsGroopAccount, [iRoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet['GroupAccount'];
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RR_FirstDayAndRoom(RoomReservation: Integer; var Room: string): Tdate;
var
  rSet: TRoomerDataSet;
  s: string;
  sql: string;
begin
  result := 1;
  Room := '';
  rSet := CreateNewDataSet;
  try

    sql :=
      'SELECT '#10 +
      '     Room '#10 +
      '   , RoomReservation '#10 +
      '   , ADate '#10 +
      ' FROM '#10 +
      '   roomsdate '#10 +
      ' WHERE '#10 +
      '   (RoomReservation = %d) '#10 +
      '   AND (ResFlag <> ' + _db(STATUS_DELETED) + ' ) '#10 + // **zxhj line added
      ' ORDER BY ADate '#10 +
      ' LIMIT 1 ';
    s := format(sql, [RoomReservation]);

    if hData.rSet_bySQL(rSet, s) then
    begin
      result := _dbdateToDate(rSet.FieldByName('aDate').Asstring);
      Room := rSet.FieldByName('room').Asstring;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RV_FirstDayAndRoom(reservation: Integer; var Room: string): Tdate;
var
  rSet: TRoomerDataSet;
  s: string;
  sql: string;
begin
  result := 1;
  Room := '';
  rSet := CreateNewDataSet;
  try
    sql :=
      'SELECT ' +
      '     Room ' +
      '   , Reservation ' +
      '   , ADate ' +
      ' FROM ' +
      '   roomsdate ' +
      ' WHERE ' +
      '   (Reservation = %d) ' +
      '   AND (ResFlag <> ' + _db(STATUS_DELETED) + ' ) ' + // **zxhj line added
      ' ORDER BY ADate, room ' +
      ' LIMIT 1 ';

    s := format(sql, [reservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := _dbdateToDate(rSet.FieldByName('aDate').Asstring);
      Room := rSet.FieldByName('room').Asstring;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.Ref_FirstDayAndRoom(ref: string; var Room: string): Tdate;
var
  rSet: TRoomerDataSet;
  s: string;
  res: Integer;
begin
  res := 0;

  rSet := CreateNewDataSet;
  try
    s := '';
    s := s + ' SELECT '#10;
    s := s + '     reservation '#10;
    s := s + '   , invRefrence '#10;
    s := s + ' FROM '#10;
    s := s + '   reservations '#10;
    s := s + ' WHERE ';
    s := s + '   (invRefrence = %s) '#10;
    s := s + '   AND (ResFlag <> ' + _db(STATUS_DELETED) + ' ) '; // **zxhj line added
    s := s + ' LIMIT 1 ';
    s := format(s, [ref]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      res := rSet.FieldByName('Reservation').AsInteger;
    end;
  finally
    freeandnil(rSet);
  end;

  result := 1;
  Room := '';

  if res = 0 then
    exit;

  rSet := CreateNewDataSet;
  try
    s := '';
    s := s + ' SELECT ';
    s := s + '     Room ';
    s := s + '   , Reservation ';
    s := s + '   , ADate ';
    s := s + ' FROM ';
    s := s + '   roomsdate ';
    s := s + ' WHERE ';
    s := s + '   (Reservation = %d) ';
    s := s + '   AND (ResFlag <> ' + _db(STATUS_DELETED) + ' ) '#10;
    /// /**zxhj
    s := s + ' ORDER BY ADate ';
    s := s + ' LIMIT 1 ';
    s := format(s, [res]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := _dbdateToDate(rSet.FieldByName('aDate').Asstring);
      Room := rSet.FieldByName('room').Asstring;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RV_getMemos(reservation: Integer; var information, PMinfo: string): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := False;
  rSet := CreateNewDataSet;
  try
    // s := s + ' SELECT '+chr(10);
    // s := s + '   TOP (1) '+chr(10);
    // s := s + '     information '+chr(10);
    // s := s + '   , PmInfo '+chr(10);
    // s := s + ' FROM '+chr(10);
    // s := s + '   Reservations '+chr(10);
    // s := s + ' WHERE '+chr(10);
    // s := s + '   (Reservation = '+_dbInt(Reservation)+') '+chr(10);

    s := format(select_RV_getMemos, [reservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      information := rSet.FieldByName('information').Asstring;
      PMinfo := rSet.FieldByName('PMinfo').Asstring;
      result := True;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.INV_FirstDayAndRoom(InvoiceNumber: Integer; var Room: string; var InvoiceKind: Integer): Tdate;
var
  rSet: TRoomerDataSet;
  s: string;
  reservation: Integer;
  RoomReservation: Integer;
begin
  InvoiceKind := 0;
  result := 1;
  Room := '';
  rSet := CreateNewDataSet;
  try
    s := format(select_INV_FirstDayAndRoom, [InvoiceNumber]);

    if hData.rSet_bySQL(rSet, s) then
    begin
      reservation := rSet.FieldByName('reservation').AsInteger;
      RoomReservation := rSet.FieldByName('RoomReservation').AsInteger;

      if RoomReservation <> 0 then
      begin
        // herbergjareikningur
        InvoiceKind := 1;
        result := RR_FirstDayAndRoom(RoomReservation, Room);
      end
      else
        if reservation <> 0 then
      begin
        // H�preikningur
        InvoiceKind := 2;
        result := RV_FirstDayAndRoom(reservation, Room);
      end
      else
      begin
        // sta�grei�slureikningur
        InvoiceKind := 3;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure Td.INV_UpdateBreakfastGuests(aReservation, aRoomReservation, aNewNumberOfBreakFast: integer);
var
  s: string;
  rSet: TRoomerDataSet;
  lRRparam: integer;
begin
  rSet := CreateNewDataSet;
  try

    s := s + '  UPDATE invoicelines SET' + #10;
    s := s + '    Number = %s ' + #10;
    s := s + '  , Total = Price * Number ' + #10;
    s := s + '  , VAT = %s * Number ' + #10;
    s := s + '  , TotalWOVat = Total - VAT ' + #10;
    s := s + '   WHERE Reservation = %s AND Roomreservation = %s AND ItemID = %s ' + #10;

    lRRParam := aRoomReservation;
    if RR_GetIsGroopAccount(aRoomReservation) then
    begin
      lRRParam := 0;
      s := s + '   AND Description LIKE "%%' + RR_GetRoomNr(aRoomReservation) + ')%%"' + #10 ;
    end;

    s := format(s, [  _db(aNewNumberOfBreakfast),
                      _db(TVatCalculator.CalcVATforItem(g.qBreakFastItem)),
                      _db(aReservation),
                      _db(lRRparam),
                      _db(g.qBreakFastItem)]);

    // debugmessage(s);
    copytoclipboard(s);

    try
      cmd_bySQL(s);
    except
      raise Exception.create(getTranslatedText('shFailedUpdateBreakfastCount'));
    end;

  finally
    freeandnil(rSet);
  end;
end;

function Td.RRlst_FromToUnpaid(DateFrom, DateTo: Tdate): tstringList;
var
  s: string;
  rSet: TRoomerDataSet;
  listItem: Integer;

begin
  result := tstringList.Create;

  rSet := CreateNewDataSet;
  try

    s := s + '  SELECT' + #10;
    s := s + '    DISTINCT' + #10;
    s := s + '    RoomReservation' + #10;
    s := s + '  FROM' + #10;
    s := s + '    roomsdate' + #10;
    s := s + '  WHERE' + #10;
    s := s + '        (ADate >=  %s )' + #10;
    s := s + '    AND (ADate <=  %s )' + #10;
    s := s + '    AND (Paid = 0 )' + #10;
    s := s + '    AND (ResFlag not in (' + _db(STATUS_DELETED) + ',' + _db(STATUS_CANCELED) + ')) '#10;
    /// /**zxhj
    s := s + '  ORDER BY RoomReservation';

    // debugmessage(s);
    // copytoclipboard(s);

    s := format(s, [_DateToDBDate(DateFrom, True), _DateToDBDate(DateTo, True)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      while not rSet.eof do
      begin
        listItem := rSet.FieldByName('RoomReservation').AsInteger;
        result.Add(inttostr(listItem));
        rSet.next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RRlst_DepartureNationalReport(DateFrom, DateTo: Tdate): tstringList;
var
  s: string;
  rSet: TRoomerDataSet;
  listItem: Integer;

begin
  result := tstringList.Create;

  rSet := CreateNewDataSet;
  try
    s := format(select_RRlst_DepartureNationalReport, [_DateToDBDate(DateFrom, True), _DateToDBDate(DateTo, True),
      _db(True)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      while not rSet.eof do
      begin
        listItem := rSet.FieldByName('RoomReservation').AsInteger;
        result.Add(inttostr(listItem));
        rSet.next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RRlst_DepartureNationalReportByLocation(DateFrom, DateTo: Tdate; Location: string): tstringList;
var
  s: string;
  rSet: TRoomerDataSet;
  listItem: Integer;

begin

  s := s + '  SELECT'#10;
  s := s + '    DISTINCT'#10;
  s := s + '    RoomReservation'#10;
  s := s + '  FROM'#10;
  s := s + '    roomreservations'#10;
  if Location <> '' then
  begin
    s := s + ' INNER JOIN ' + #10;
    s := s + '    rooms ON roomreservations.Room =  rooms.Room ' + #10;
    s := s + ' INNER JOIN ' + #10;
    s := s + '   locations ON  rooms.Location = locations.Location ' + #10;
  end;
  s := s + '  WHERE' + #10;
  s := s + '        (Departure >= %s )' + #10;
  s := s + '    AND (Departure <= %s )' + #10;
  s := s + '    AND (roomreservations.useInNationalReport = 1 )' + #10;
  if Location <> '' then
  begin
    s := s + ' AND (locations.Location in (' + Location + ') ) ' + #10;
  end;
  s := s + '  ORDER BY RoomReservation' + #10;

  result := tstringList.Create;
  rSet := CreateNewDataSet;
  try
    s := format(s, [_DateToDBDate(DateFrom, True), _DateToDBDate(DateTo, True)]);

    // copytoclipboard(s);
    // debugmessage(s);

    if hData.rSet_bySQL(rSet, s) then
    begin
      while not rSet.eof do
      begin
        listItem := rSet.FieldByName('RoomReservation').AsInteger;
        result.Add(inttostr(listItem));
        rSet.next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.Rvlst_FromToGroup(DateFrom, DateTo: Tdate): tstringList;
var
  s: string;
  rSet: TRoomerDataSet;
  listItem: Integer;
begin
  result := tstringList.Create;

  rSet := CreateNewDataSet;
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

    s := format(s, [_DateToDBDate(DateFrom, True), _DateToDBDate(DateTo, True)]);

    if hData.rSet_bySQL(rSet, s) then
    begin
      while not rSet.eof do
      begin
        listItem := rSet.FieldByName('Reservation').AsInteger;
        result.Add(inttostr(listItem));
        rSet.next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.Rvlst_CreatedFromTo(DateFrom, DateTo: Tdate): tstringList;
var
  s: string;
  rSet: TRoomerDataSet;
  listItem: Integer;
begin
  result := tstringList.Create;
  DateTo := DateTo + 1;

  s := '';
  s := s + ' SELECT '#10;
  s := s + '   DISTINCT'#10;
  s := s + '   Reservation'#10;
  s := s + ' FROM'#10;
  s := s + '   reservations'#10;
  s := s + ' WHERE'#10;
  s := s + '       (dtCreated >=  %s )'#10;
  s := s + '   AND (dtCreated <  %s )'#10;
  s := s + ' ORDER BY Reservation';

  rSet := CreateNewDataSet;
  try
    s := format(s, [_db(DateFrom), _db(DateTo)]);

    if hData.rSet_bySQL(rSet, s) then
    begin
      while not rSet.eof do
      begin
        listItem := rSet.FieldByName('Reservation').AsInteger;
        result.Add(inttostr(listItem));
        rSet.next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RVlst_Arrival(DateFrom, DateTo: Tdate; customer: string = ''): tstringList;
var
  s: string;
  rSet: TRoomerDataSet;
  listItem: Integer;
  sql: string;
begin
  result := tstringList.Create;

  rSet := CreateNewDataSet;
  try
    sql := '';
    sql := sql + '  SELECT'#10;
    sql := sql + '    DISTINCT'#10;
    sql := sql + '    Reservation'#10;
    sql := sql + '  FROM'#10;
    sql := sql + '    reservations'#10;
    sql := sql + '  WHERE'#10;
    sql := sql +
      '        ((SELECT ADate FROM roomsdate rd WHERE rd.Reservation = reservations.Reservation AND (rd.ResFlag <> ' +
      _db(STATUS_DELETED) + ' ) AND (rd.ResFlag <> ' + _db(STATUS_CANCELED) + ' )  ORDER BY ADate LIMIT 1) >=  %s )'#10;
    sql := sql +
      '    AND ((SELECT ADate FROM roomsdate rd WHERE rd.Reservation = reservations.Reservation AND (rd.ResFlag <> ' +
      _db(STATUS_DELETED) + ' ) AND (rd.ResFlag <> ' + _db(STATUS_CANCELED) + ' ) ORDER BY ADate LIMIT 1) <=  %s )'#10;
    if customer <> '' then
    begin
      sql := sql + '    AND (customer=' + _db(customer) + ' '#10;
    end;
    sql := sql + '  ORDER BY Reservation';

    s := format(sql, [_DateToDBDate(DateFrom, True), _DateToDBDate(DateTo, True)]);
    // copyToClipboard(s);
    // DebugMessage(s);

    if hData.rSet_bySQL(rSet, s) then
    begin
      while not rSet.eof do
      begin
        listItem := rSet.FieldByName('Reservation').AsInteger;
        result.Add(inttostr(listItem));
        rSet.next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RRlst_Arrival(DateFrom, DateTo: Tdate): tstringList;
var
  s: string;
  rSet: TRoomerDataSet;
  listItem: Integer;
  sql: string;
begin
  result := tstringList.Create;

  rSet := CreateNewDataSet;
  try

    sql :=
      '  SELECT' +
      '    DISTINCT' +
      '    RoomReservation' +
      '  FROM' +
      '    roomreservations' +
      '  WHERE' +
      '        (Arrival >=  %s )' +
      '    AND (Arrival <=  %s )' +
      '    AND (status <> ' + _db(STATUS_DELETED) + ' ) ' + // **zxhj
      '    AND (status <> ' + _db(STATUS_CANCELED) + ' ) ' + // **zxhj
      '  ORDER BY RoomReservation';
    s := format(sql, [_DateToDBDate(DateFrom, True), _DateToDBDate(DateTo, True)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      while not rSet.eof do
      begin
        listItem := rSet.FieldByName('RoomReservation').AsInteger;
        result.Add(inttostr(listItem));
        rSet.next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.GuestListRRlst_Arrival(DateFrom, DateTo: Tdate; includeNoshow, includeAllotment, includeBlocked: boolean)
  : tstringList;
var
  s: string;
  rSet: TRoomerDataSet;
  listItem: Integer;
  sql: string;
begin
  result := tstringList.Create;

  rSet := CreateNewDataSet;
  try

    sql := GetListOfRoomReservationsPerArrivalDate;
    s := format(sql, [_DateToDBDate(DateFrom, True), _DateToDBDate(DateTo, True)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      while not rSet.eof do
      begin
        listItem := rSet.FieldByName('RoomReservation').AsInteger;
        result.Add(inttostr(listItem));
        rSet.next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RVlst_Departure(DateFrom, DateTo: Tdate): tstringList;
var
  s: string;
  rSet: TRoomerDataSet;
  listItem: Integer;
  sql: string;
begin
  result := tstringList.Create;
  rSet := CreateNewDataSet;
  try
    sql :=
      '  SELECT' +
      '    DISTINCT' +
      '    RoomReservation' +
      '  FROM' +
      '    roomreservations' +
      '  WHERE' +
      '        (Departure >=  %s )' +
      '    AND (Departure <=  %s )' +
      '  ORDER BY RoomReservation';

    s := format(sql, [_DateToDBDate(DateFrom, True), _DateToDBDate(DateTo, True)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      while not rSet.eof do
      begin
        listItem := rSet.FieldByName('Reservation').AsInteger;
        result.Add(inttostr(listItem));
        rSet.next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RRlst_Departure(DateFrom, DateTo: Tdate): tstringList;
var
  s: string;
  rSet: TRoomerDataSet;
  listItem: Integer;
  sql: string;
begin
  result := tstringList.Create;

  rSet := CreateNewDataSet;
  try
    sql :=
      '  SELECT' +
      '    DISTINCT' +
      '    RoomReservation' +
      '  FROM' +
      '    roomreservations' +
      '  WHERE' +
      '        (Departure >=  %s )' +
      '    AND (Departure <=  %s )' +
      '    AND (status <> ' + _db(STATUS_DELETED) + ' ) ' + // **zxhj
      '    AND (status <> ' + _db(STATUS_CANCELED) + ' ) ' + // **zxhj
      '  ORDER BY RoomReservation';
    s := format(sql, [_DateToDBDate(DateFrom, True), _DateToDBDate(DateTo, True)]);

    if hData.rSet_bySQL(rSet, s) then
    begin
      while not rSet.eof do
      begin
        listItem := rSet.FieldByName('RoomReservation').AsInteger;
        result.Add(inttostr(listItem));
        rSet.next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.GuestlistRRlst_Departure(DateFrom, DateTo: Tdate; includeNoshow, includeAllotment, includeBlocked: boolean)
  : tstringList;
var
  s: string;
  rSet: TRoomerDataSet;
  listItem: Integer;
  sql: string;
begin
  result := tstringList.Create;

  rSet := CreateNewDataSet;
  try
    sql := GetListOfRoomReservationsPerDepartureDate;
    s := format(sql, [_DateToDBDate(DateFrom, True), _DateToDBDate(DateTo, True)]);

    if hData.rSet_bySQL(rSet, s) then
    begin
      while not rSet.eof do
      begin
        listItem := rSet.FieldByName('RoomReservation').AsInteger;
        result.Add(inttostr(listItem));
        rSet.next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RVlst_FromTo(DateFrom, DateTo: Tdate): tstringList;
var
  s: string;
  rSet: TRoomerDataSet;
  listItem: Integer;
  sql: string;
begin
  result := tstringList.Create;

  rSet := CreateNewDataSet;
  try
    sql :=
      '  SELECT' +
      '    DISTINCT' +
      '    Reservation' +
      '  FROM' +
      '    roomsdate' +
      '  WHERE' +
      '        (ADate >=  %s )' +
      '    AND (ADate <=  %s )' +
      '    AND (ResFlag <> ' + _db(STATUS_DELETED) + ' ) ' + // **zxhj
      '    AND (ResFlag <> ' + _db(STATUS_CANCELED) + ' ) ' + // **zxhj
      '  ORDER BY Reservation';

    s := format(sql, [_DateToDBDate(DateFrom, True), _DateToDBDate(DateTo, True)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      while not rSet.eof do
      begin
        listItem := rSet.FieldByName('Reservation').AsInteger;
        result.Add(inttostr(listItem));
        rSet.next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RRlst_FromTo(DateFrom, DateTo: Tdate): tstringList;
var
  s: string;
  rSet: TRoomerDataSet;
  listItem: Integer;
  sql: string;

begin
  result := tstringList.Create;

  rSet := CreateNewDataSet;
  try

    sql :=
      '  SELECT' +
      '    DISTINCT' +
      '    RoomReservation' +
      '  FROM' +
      '    roomsdate' +
      '  WHERE' +
      '        (ADate >=  %s )' +
      '    AND (ADate <=  %s )' +
      '   AND (ResFlag <> ' + _db(STATUS_DELETED) + ' ) ' + // **zxhj line added
      '   AND (ResFlag <> ' + _db(STATUS_CANCELED) + ' ) ' + // **zxhj line added
      '  ORDER BY RoomReservation';

    s := format(sql, [_DateToDBDate(DateFrom, True), _DateToDBDate(DateTo, True)]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      while not rSet.eof do
      begin
        listItem := rSet.FieldByName('RoomReservation').AsInteger;
        result.Add(inttostr(listItem));
        rSet.next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.GuestlistRRlst_FromTo(DateFrom, DateTo: Tdate; includeNoshow, includeAllotment, includeBlocked: boolean)
  : tstringList;
var
  s: string;
  rSet: TRoomerDataSet;
  listItem: Integer;
  sql: string;

begin
  result := tstringList.Create;

  rSet := CreateNewDataSet;
  try

    sql := GetListOfRoomReservationsFromToDate;
    s := format(sql, [_DateToDBDate(DateFrom, True), _DateToDBDate(DateTo, True)]);

    if hData.rSet_bySQL(rSet, s) then
    begin
      while not rSet.eof do
      begin
        listItem := rSet.FieldByName('RoomReservation').AsInteger;
        result.Add(inttostr(listItem));
        rSet.next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.RE_Upd_MarketSegment(newValue: string; reservation: Integer): boolean;
var
  s: string;
begin
  result := False;

  if reservation < 1 then
    exit;
  result := True;
  s := '';
  s := s + ' UPDATE reservations ' + chr(10);
  s := s + ' Set MarketSegment=' + _db(newValue) + ' ' + chr(10);
  s := s + ' WHERE (Reservation = ' + inttostr(reservation) + ') ' + chr(10);
  if not cmd_bySQL(s) then
  begin
    result := False;
  end;
end;

const
  AlreadyLoggingIn: boolean = False;

procedure Td.roomerMainDataSetSessionExpired(Sender: TObject);
var
  res: boolean;
begin
  if AlreadyLoggingIn then
    exit;
  AlreadyLoggingIn := False;
  try
    repeat
      res := frmMain._Logout(True);
    until res OR Application.Terminated;
  finally
    AlreadyLoggingIn := False;
  end;
end;

function Td.IH_Upd_UnPaid_RR(RoomReservation: Integer): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  rSet := CreateNewDataSet;
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

procedure Td.ApplyFieldsToKbmMemTable(sourceSet: TRoomerDataSet; destSet: TdxMemData; loadDataSet: boolean = True);
begin
  destSet.FieldDefs.Assign(sourceSet.FieldDefs);
  destSet.CreateFieldsFromDataSet(sourceSet);
  if loadDataSet then
  begin
    destSet.Open;
    destSet.LoadFromDataSet(sourceSet);
    // [mtcpoStructure,mtcpoProperties,mtcpoFieldIndex,mtcpoIgnoreErrors,mtcpoStringAsWideString,mtcpoWideStringUTF8]);
  end;
end;

procedure Td.SaveKbmMemTable(destSet: TdxMemData; filename: String; performTouch: boolean = False);
begin
  if fileExists(filename) then
    DeleteAllFiles(filename);
  destSet.SaveToBinaryFile(filename);
  if performTouch then
    TouchNewFile(filename + '.changed', now);
end;

const
  GET_ALL_INVOICE_ITEMS_FOR_A_SPECIFIED_ROOM_RESERVATION =
    'SELECT il.Id AS ilId, il.PurchaseDate, il.ItemId, il.Number, il.Description, il.Price, il.VATType, il.Total, il.TotalWOVat, il.Vat, '
    + #10 +
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
    '       DATEDIFF((SELECT ADate FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) ORDER BY ADate DESC LIMIT 1), '
    + #10 +
    '                (SELECT ADate FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) ORDER BY ADate LIMIT 1)) + 1 AS Number, '
    + #10 +
    '       CONCAT(''Room '', (SELECT Room FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) LIMIT 1), '' '', '
    + #10 +
    '              DATE_FORMAT((SELECT ADate FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) ORDER BY ADate LIMIT 1), ''%d-%m''), '' - '', '
    + #10 +
    '              DATE_FORMAT((SELECT ADate FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) ORDER BY ADate DESC LIMIT 1), ''%d-%m'')) AS Description, '
    + #10 +
    '       (SELECT AVG(RoomRate) FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q''))) AS Price, '
    + #10 +
    '       _params.VATCode AS VATType, ' + #10 +
    '       (SELECT SUM(RoomRate * ABS(1-Paid)) FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q''))) AS Total, '
    + #10 +
    '       (SELECT SUM(RoomRate * ABS(1-Paid)) FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q''))) / (1+(_params.VATPercentage/100)) '
    + #10 +
    '       AS TotalWOVat, ' + #10 +
    '       (SELECT SUM(RoomRate * ABS(1-Paid)) FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q''))) - '
    + #10 +
    '       (SELECT SUM(RoomRate * ABS(1-Paid)) FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q''))) / (1+(_params.VATPercentage/100)) '
    + #10 +
    '       AS Vat, ' + #10 +
    '       (SELECT AValue from currencies WHERE Currency=(SELECT Currency FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) LIMIT 1)) AS CurrencyRate, '
    + #10 +
    '       (SELECT Currency FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) LIMIT 1) AS Currency, '
    + #10 +
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
    '              WHERE VATCode=(SELECT VATCode FROM itemtypes WHERE ItemType=(SELECT ItemType FROM items WHERE Item=RoomRentItem LIMIT 1))) AS VATPercentage, '
    + #10 +
    '             (SELECT VATCode FROM itemtypes WHERE ItemType=(SELECT ItemType FROM items WHERE Item=RoomRentItem LIMIT 1)) AS VATCode) _params '
    + #10 +
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
    '       _taxes.CurrencyRate, _taxes.Currency, _taxes.ItemNumber, _params.RoomReservation AS RoomReservationAlias, '
    + #10 +
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
    '       (SELECT ADate FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) ORDER BY ADate DESC LIMIT 1) AS _DepartureDate, '
    + #10 +
    '       (SELECT ADate FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) ORDER BY ADate LIMIT 1) AS _ArrivalDate, '
    + #10 +
    '       (SELECT COUNT(id) FROM persons WHERE RoomReservation=_params.RoomReservation) AS _NumberOfGuests, ' + #10 +
    ' ' + #10 +
    '       IF(t.TAX_BASE = ''ROOM_NIGHT'', ' + #10 +
    '          DATEDIFF((SELECT ADate FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) ORDER BY ADate DESC LIMIT 1), '
    + #10 +
    '                   (SELECT ADate FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) ORDER BY ADate LIMIT 1)) + 1, '
    + #10 +
    '       IF(t.TAX_BASE = ''GUEST_NIGHT'', ' + #10 +
    '          (SELECT COUNT(id) FROM persons WHERE RoomReservation=_params.RoomReservation) * ' + #10 +
    '          DATEDIFF((SELECT ADate FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) ORDER BY ADate DESC LIMIT 1), '
    + #10 +
    '                   (SELECT ADate FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) ORDER BY ADate LIMIT 1)) + 1, '
    + #10 +
    '       IF(t.TAX_BASE = ''GUEST'', ' + #10 +
    '          (SELECT COUNT(id) FROM persons WHERE RoomReservation=_params.RoomReservation), ' + #10 +
    '          1 ' + #10 +
    '          ))) AS Number, ' + #10 +
    ' ' + #10 +
    ' ' + #10 +
    '       (SELECT Room FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) LIMIT 1) AS Room, '
    + #10 +
    '       t.DESCRIPTION AS Description, ' + #10 +
    ' ' + #10 +
    '       t.TAX_TYPE AS tax_type, ' + #10 +
    '       t.AMOUNT AS tax_amount, ' + #10 +
    '       t.NETTO_AMOUNT_BASED AS tax_netto_based, ' + #10 +
    '       (SELECT AVG(RoomRate * ABS(1-Paid)) FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q''))) AS _AveragePrice, '
    + #10 +
    '       (SELECT SUM(RoomRate * ABS(1-Paid)) FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q''))) AS _TotalPrice, '
    + #10 +
    '       (SELECT AVG(RoomRate * ABS(1-Paid)) FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q''))) / (1+(v.VATPercentage/100)) * t.AMOUNT / 100 AS _NettoAveragePrice, '
    + #10 +
    '       (SELECT SUM(RoomRate * ABS(1-Paid)) FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q''))) / (1+(v.VATPercentage/100)) * t.AMOUNT / 100 AS _NettoTotalPrice, '
    + #10 +
    '       IF(t.NETTO_AMOUNT_BASED = ''FALSE'', ' + #10 +
    '         (SELECT AVG(RoomRate * ABS(1-Paid)) FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q''))), '
    + #10 +
    '         (SELECT AVG(RoomRate * ABS(1-Paid)) FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q''))) / (1+(v.VATPercentage/100)) * t.AMOUNT / 100) '
    + #10 +
    '       AS _TaxBaseAveragePrice, ' + #10 +
    '       IF(t.NETTO_AMOUNT_BASED = ''FALSE'', ' + #10 +
    '         (SELECT SUM(RoomRate * ABS(1-Paid)) FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q''))), '
    + #10 +
    '         (SELECT SUM(RoomRate * ABS(1-Paid)) FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q''))) / (1+(v.VATPercentage/100)) * t.AMOUNT / 100) '
    + #10 +
    '       AS _TaxBaseTotalPrice, ' + #10 +
    ' ' + #10 +
    '       v.VATPercentage AS _VATPercentage, ' + #10 +
    '       v.VATCode AS VATType, ' + #10 +
    ' ' + #10 +
    '       (SELECT AValue from currencies WHERE Currency=(SELECT Currency FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) LIMIT 1)) AS CurrencyRate, '
    + #10 +
    '       (SELECT Currency FROM roomsdate WHERE RoomReservation=_params.RoomReservation AND (NOT ResFlag IN (''X'',''C'',''O'',''N'',''Q'')) LIMIT 1) AS Currency, '
    + #10 +
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

procedure Td.GenerateOfflineReports;
begin
{$ifndef DISABLEOFFLINEREPORTS}
  if roomerMainDataSet.LoggedIn then
    TOfflineReportGenerator.ExecuteRegisteredReports;
{$endif}
end;

Function Td.BreakFastInclutedCount(reservation: Integer): Integer;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  //
  result := 0;
  rSet := CreateNewDataSet;
  try
    // s := s+' SELECT '+chr(10);
    // s := s+'   COUNT(invBreakfast) AS cnt '+chr(10);
    // s := s+' FROM '+chr(10);
    // s := s+'   RoomReservations '+chr(10);
    // s := s+' WHERE '+chr(10);
    // s := s+'   (Reservation = '+_db(Reservation)+') AND (invBreakfast = 1) '+chr(10);
    s := format(select_BreakFastInclutedCount, [reservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('cnt').AsInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

Function Td.GroupAccountCount(reservation: Integer): Integer;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  //
  result := 0;

  rSet := CreateNewDataSet;
  try
    // s := s+' SELECT '+chr(10);
    // s := s+'   COUNT(GroupAccount) AS cnt '+chr(10);
    // s := s+' FROM '+chr(10);
    // s := s+'   RoomReservations '+chr(10);
    // s := s+' WHERE '+chr(10);
    // s := s+'   (Reservation = '+_db(Reservation)+') AND (GroupAccount = 1) '+chr(10);
    s := format(select_GroupAccountCount, [reservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.FieldByName('cnt').AsInteger;
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure Td.RR_ExcluteFromOpenInvoices(RoomReservation: Integer);
var
  s: string;
begin
  s := '';
  s := s + ' UPDATE roomreservations ' + chr(10);
  s := s + ' Set ' + chr(10);
  s := s + ' RoomRentPaymentInvoice = -999 ' + chr(10);
  s := s + ' WHERE RoomReservation = ' + inttostr(RoomReservation) + chr(10);
  if not cmd_bySQL(s) then
  begin
  end;
end;

function Td.rrGetDiscount(RoomReservation: Integer; var DiscountType: Integer; var DiscountAmount: Double): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
  Discount: Double;
  Percentage: boolean;
begin
  result := False;

  rSet := CreateNewDataSet;
  try
    // s := s+' SELECT '+chr(10);
    // s := s+'     RoomReservation '+chr(10);
    // s := s+'   , Discount '+chr(10);
    // s := s+'   , Percentage '+chr(10);
    // s := s+' FROM RoomReservations '+chr(10);
    // s := s+' WHERE (RoomReservation = '+_db(roomreservation)+') '+chr(10);
    s := format(select_rrGetDiscount, [RoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      Discount := LocalFloatValue(rSet.FieldByName('discount').Asstring);
      Percentage := rSet['Percentage'];

      DiscountType := 0;
      if not Percentage then
      begin
        DiscountType := 1;
      end;
      DiscountAmount := Discount;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function Td.rrEditDiscount(RoomReservation: Integer; DiscountType: Integer; DiscountAmount: Double): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
  Discount: Double;
  Percentage: boolean;
begin
  result := False;

  rSet := CreateNewDataSet;
  try
    // s := s+' SELECT '+chr(10);
    // s := s+'     RoomReservation '+chr(10);
    // s := s+'   , Discount '+chr(10);
    // s := s+'   , Percentage '+chr(10);
    // s := s+' FROM RoomReservations '+chr(10);
    // s := s+' WHERE (RoomReservation = '+_db(roomreservation)+') '+chr(10);
    s := format(select_rrEditDiscount, [RoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      Discount := DiscountAmount;;
      Percentage := True;

      if DiscountType = 1 then
        Percentage := False;
      rSet.edit;
      rSet.FieldByName('discount').asFloat := Discount;
      rSet.FieldByName('Percentage').asBoolean := Percentage;
      rSet.post; // ID ADDED
      result := True;
    end;
  finally
    freeandnil(rSet);
  end;
end;

/// /////////////////////////////////////////////////////////////////////////////

procedure Td.UpdateStatusSimple(reservation, RoomReservation: Integer; newStatus: string);
begin

  if (RoomReservation <> 0) then
    d.roomerMainDataSet.SystemSetRoomStatus(RoomReservation, newStatus)
  else
    d.roomerMainDataSet.SystemSetRoomStatusOfReservation(reservation, newStatus);

end;

function Td.SetAsNoRoom(RoomReservation: Integer): boolean;
var
  s: string;
  sRoom: string;
  sRoomType: string;
  NewRoom: string;
  rSet: TRoomerDataSet;
begin
  result := True;
  // s := s + ' SELECT '+chr(10);
  // s := s + '    RoomReservation '+chr(10);
  // s := s + '  , Room '+chr(10);
  // s := s + '  , RoomType '+chr(10);
  // s := s + ' FROM '+chr(10);
  // s := s + '   RoomReservations '+chr(10);
  // s := s + ' WHERE '+chr(10);
  // s := s + '   RoomReservation = ' + inttostr(RoomReservation) + ' '+chr(10);

  rSet := CreateNewDataSet;
  try
    s := format(select_SetAsNoRoom, [RoomReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      sRoom := rSet.FieldByName('room').Asstring;
      sRoomType := rSet.FieldByName('roomtype').Asstring;
    end;
  finally
    freeandnil(rSet);
  end;

  NewRoom := '<' + inttostr(RoomReservation) + '>';
  s := '';
  s := s + ' UPDATE ' + chr(10);
  s := s + '   roomreservations ' + chr(10);
  s := s + ' SET ' + chr(10);
  s := s + '   Room = ' + _db(NewRoom) + ' ' + chr(10);
  s := s + '   ,rrIsNoRoom = 0 ' + chr(10);
  s := s + '   ,rrRoomAlias = ' + _db(sRoom) + ' ' + chr(10);
  s := s + '   ,rrRoomTypeAlias = ' + _db(sRoomType) + ' ' + chr(10);
  s := s + ' WHERE ' + chr(10);
  s := s + '   RoomReservation = ' + inttostr(RoomReservation) + ' ' + chr(10);
  if not cmd_bySQL(s) then
  begin
    result := False;
  end;

  // <roomsdate>xUPDATE **SetAsNoRoom**
  // **xzhj
  s := '';
  s := s + ' UPDATE ' + chr(10);
  s := s + '   roomsdate ' + chr(10);
  s := s + ' SET ' + chr(10);
  s := s + '   Room = ' + _db(NewRoom) + ' ' + chr(10);
  s := s + ' , updated = 1 ' + chr(10);
  s := s + ' , isNoRoom = 0 ' + chr(10);
  s := s + ' WHERE ' + chr(10);
  s := s + '   RoomReservation = ' + inttostr(RoomReservation) + ' ' + chr(10);
  if not cmd_bySQL(s) then
  begin
    result := False;
  end;
end;

function WebColorToDelphiColor(const AWebColor: string): TColor;
var
  lRed: Integer;
  lGreen: Integer;
  lBlue: Integer;
begin
  result := clNone;

  if (length(AWebColor) = 8) and (AWebColor[2] = 'x') then
  begin
    lRed := strtoint('$' + copy(AWebColor, 3, 2));
    lGreen := strtoint('$' + copy(AWebColor, 4, 2));
    lBlue := strtoint('$' + copy(AWebColor, 7, 2));
    result := RGB(lRed, lGreen, lBlue); // TColor((lBlue * 65536) + (lGreen * 256) + lRed);
  end;
end;

function HtmlToColor(s: string; aDefault: TColor): TColor;
begin
  if copy(s, 1, 2) = '0x' then
  begin
    s := '$' + copy(s, 7, 2) + copy(s, 5, 2) + copy(s, 3, 2);
  end
  else
    s := 'clNone';
  try
    result := StringToColor(s);
  except
    result := aDefault;
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
  iTemp: Integer;
begin
  tempSet := glb.GetDataSetFromDictionary('maintenancecodes');
  // tempSet.CommandText := 'SELECT * FROM maintenancecodes';
  // tempSet.Open;
  tempSet.First;
  while not tempSet.eof do
  begin
    iTemp := HtmlToColor(tempSet['color'], clBlack);
    lstMaintenanceCodes.Add(TKeyAndValue.Create(tempSet['code'], inttostr(iTemp)));
    tempSet.next;
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
  g.qLastImportLogID := imPortLog_getLastID;

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
  chkConfirmMonitor;

end;

function Td.LocateRecord(rSet: TRoomerDataSet; FieldName: String; Value: Integer): boolean;
begin
  result := False;
  rSet.First;
  while NOT rSet.eof do
  begin
    if rSet[FieldName] = Value then
    begin
      result := True;
      Break;
    end;
    rSet.next;
  end;
end;

function Td.LocateRecord(rSet: TRoomerDataSet; FieldName: String; Value: String): boolean;
begin
  result := False;
  rSet.First;
  while NOT rSet.eof do
  begin
    if LowerCase(rSet[FieldName]) = LowerCase(Value) then
    begin
      result := True;
      Break;
    end;
    rSet.next;
  end;
end;

function Td.MoveRoom(RoomReservation: Integer; NewRoom: string): boolean;
begin
  result := True;
  try
    roomerMainDataSet.SystemMoveRoom(RoomReservation, NewRoom);
    try
      AddReservationActivityLog(g.qUser
        , -1
        , RoomReservation
        , NEW_ROOM_NUMBER
        , ''
        , NewRoom
        , '');
    Except
    end;
  except
    result := False;
  end;
end;

function Td.ChangeRrDates(RoomReservation: Integer; newArrival, newDeparture: Tdate; updateRoomstatus: boolean)
  : boolean;
var
  lst: tstringList;

  function foundInList(const lookFor: string): boolean;
  var
    i: Integer;
  begin
    result := False;
    for i := 0 to lst.Count - 1 do
    begin
      if _trimlower(lookFor) = lst[i] then
        result := True;
    end;
  end;

var
  iNumErrors: Integer;

  s: string;

  reservation: Integer;

  Room: string;
  RoomType: string;
  status: string;

  Currency: string;

  sNewArrival: string;
  sNewDeparture: string;

  NumDays: Integer;

  rSet: TRoomerDataSet;

  doIt: boolean;
  ii: Integer;

  ChkRoomReservation: Integer;
  sChkRoomreservation: string;
  chkDate: Tdate;

  GuestCount: Integer;
  childCount: Integer;
  infantCount: Integer;
  PriceID: Integer;

  priceType: string;

  Discount: Double;
  isPercentage: boolean;
  showDiscount: boolean;

begin
  doIt := False;
  sNewArrival := _DateToDBDate(newArrival, False);
  sNewDeparture := _DateToDBDate(newDeparture, False);
  NumDays := trunc(newDeparture) - trunc(newArrival);

  if NumDays < 1 then
  begin
    showmessage(GetTranslatedText('shTx_D_CheckDates'));
  end;

  showDiscount := True;

  lst := tstringList.Create;
  try
    rSet := CreateNewDataSet;
    try
      s := format(select_ChangeRrDates, [RoomReservation]);
      if hData.rSet_bySQL(rSet, s) then
      begin
        reservation := rSet.FieldByName('Reservation').AsInteger;
        RoomReservation := rSet.FieldByName('RoomReservation').AsInteger;
        Room := trim(rSet.FieldByName('Room').Asstring);
        RoomType := hData.GET_RoomsType_byRoom(Room);
        GuestCount := rSet.FieldByName('numGuests').AsInteger;
        childCount := rSet.FieldByName('numChildren').AsInteger;
        infantCount := rSet.FieldByName('numInfants').AsInteger;

        if RoomType = '' then
        begin
          RoomType := trim(rSet.FieldByName('RoomType').Asstring);
        end;

        status := rSet.FieldByName('Status').Asstring;
        priceType := trim(rSet.FieldByName('PriceType').Asstring);
        PriceID := hData.PriceCode_ID(priceType);
        Currency := trim(rSet.FieldByName('Currency').Asstring);
        Discount := rSet.GetFloatValue(rSet.FieldByName('discount'));
        isPercentage := rSet.FieldByName('Percentage').asBoolean;

        lst.clear;
        doIt := True;

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
              doIt := False;
            end;
          end;
        end;

        if lst.Count > 0 then
        begin
          case g.OpenRoomDateProblem(lst) of
            0:
              begin
                for ii := 0 to lst.Count - 1 do
                begin
                  ChkRoomReservation := strtoint(lst[ii]);
                  MoveToRoomEnh2(ChkRoomReservation, '');
                end;
                doIt := True;
              end;
            1:
              begin
                Room := '';
                doIt := True;
              end;
            3:
              begin
                doIt := False;
              end;
          end;
        end;

        if doIt then
        begin
          // d.RemoveRoomsDate(RoomReservation);
          iNumErrors := 0;

          // d.AddRoomsDate(sNewArrival, Room, RoomType, status, RoomReservation, reservation, NumDays, iNumErrors);

          hData.AddRoomsDate(newArrival
            , Room
            , RoomType
            , status
            , Currency
            , PriceID
            , GuestCount
            , childCount
            , infantCount
            , Discount
            , isPercentage
            , showDiscount
            , RoomReservation
            , reservation
            , NumDays
            , iNumErrors
            );

          if iNumErrors > 0 then
          begin
            // s := 'Some errors ' + #10;
            // s := s + inttostr(iNumErrors) + ' total ' + #10 + #10;
            s := GetTranslatedText('shTx_D_SomeErrors') + #10;
            s := s + inttostr(iNumErrors) + GetTranslatedText('shTx_D_Total') + #10 + #10;
            MessageDlg(s, mtWarning, [mbOK], 0);
          end
          else
          begin
            rSet.edit;
            rSet.FieldByName('Arrival').Asstring := sNewArrival;
            rSet.FieldByName('Departure').Asstring := sNewDeparture;
            rSet.FieldByName('rrDeparture').asDateTime := newDeparture;
            rSet.FieldByName('rrArrival').asDateTime := newArrival;
            rSet.post;

          end;
        end;
      end; // rSEt
    finally
      freeandnil(rSet);
    end;
  finally
    lst.Free;
  end;
  result := doIt;
end;

procedure Td.RemoveReservation(iReservation: Integer; CancelStaff, CancelReason, CancelInformation: string;
  CancelType: Integer);
var
  rSet: TRoomerDataSet;
  s: string;

  invoices: string;
begin
  invoices := '';

  rSet := CreateNewDataSet;
  try
    s := format(select_RemoveReservation, [iReservation]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      invoices := '';
      while not rSet.eof do
      begin
        invoices := invoices + rSet.FieldByName('InvoiceNumber').Asstring + ', ';
        rSet.next;
      end;
    end;
  finally
    freeandnil(rSet);
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
      showmessage(s);
    end;
  end;

  if MessageDlg(GetTranslatedText('shTx_D_DeleteAll'), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    roomerMainDataSet.SystemRemoveReservation(iReservation, True, True, CancelReason, CancelStaff, CancelInformation,
      CancelType);
    frmDayNotes.RefreshRoomStatus; // hj 140527
  end
  else
  begin
    exit;
  end;
end;

function Td.RetrieveFinancesKeypair(keyPairType: TKeyPairType): TKeyPairList;
var
  i, l: Integer;
  s: String;
  sa: TArrayOfString;
  cursorWas: SmallInt;
begin
  cursorWas := Screen.Cursor;
  Screen.Cursor := crHourglass;
  Application.ProcessMessages;
  try
    case keyPairType of
      FKP_CUSTOMERS:
        s := roomerMainDataSet.SystemFinanceListCustomers;
      FKP_PRODUCTS:
        s := roomerMainDataSet.SystemFinanceListProducts;
      FKP_PAYTYPES:
        s := roomerMainDataSet.SystemFinanceListPaymentTypes;
    end;

    sa := SplitString(#10, s);
    result := TKeyPairList.Create(True);
    for i := LOW(sa) to HIGH(sa) do
    begin
      s := sa[i];
      l := pos('=', s);
      if l > 0 then
      begin
        result.Add(TKeyAndValue.Create(copy(s, 1, l - 1), copy(s, l + 1, length(s))));
      end;
    end;
  finally
    Screen.Cursor := cursorWas;
    Application.ProcessMessages;
  end;
end;

function Td.KeyExists(keyList: TKeyPairList; Key: String): boolean;
var
  i: Integer;
begin
  result := False;
  for i := 0 to keyList.Count - 1 do
  begin
    if keyList[i].Key = Key then
    begin
      result := True;
      Break;
    end;
  end;
end;

procedure Td.CheckInGuest(RoomReservation: Integer);
begin
  d.roomerMainDataSet.SystemSetRoomStatus(RoomReservation, STATUS_ARRIVED);
  g.updateCurrentGuestlist;
end;

procedure Td.CheckOutGuest(RoomReservation: Integer; Room: String);
begin

  d.roomerMainDataSet.SystemSetRoomStatus(RoomReservation, STATUS_CHECKED_OUT);
  SetUnclean(Room);
  g.updateCurrentGuestlist;
end;

function Td.RemoveRoomsDatebyReservation(iReservation: Integer): boolean;
var
  s: string;
begin
  result := False;

  s := '';
  // s := s + ' DELETE FROM roomsdate '+chr(10);
  // s := s + ' WHERE Reservation = ' + inttostr(iReservation)+chr(10);

  // **zxhj Breytti h�r
  s := 'UPDATE roomsdate SET ResFlag =' + _db(STATUS_DELETED) + ' '#10;
  s := s + ' WHERE Reservation = ' + inttostr(iReservation) + chr(10);
  if not cmd_bySQL(s) then
  begin
    result := False;
  end;
end;

function Td.ChkFinished(invNr: Integer): Integer;
var
  s: string;
  rSet: TRoomerDataSet;
  sql: string;
begin
  result := 0;
  rSet := CreateNewDataSet;
  try

    sql :=
      ' SELECT' +
      '     InvoiceNumber' +
      ' FROM' +
      '    tblinvoiceactions' +
      ' WHERE' +
      '  invoiceNumber= %d ';
    s := format(sql, [invNr]);
    if hData.rSet_bySQL(rSet, s) then
    begin
      result := rSet.recordcount;
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure Td.CreateMtFields;
begin
  // Create HeadFields
  if d.mtHead_.Active then
    d.mtHead_.Close;
  d.mtHead_.FieldDefs.clear;

  d.mtHead_.FieldDefs.Add('Customer', ftWideString, 100, False);
  d.mtHead_.FieldDefs.Add('CustomerName', ftWideString, 100, False);
  d.mtHead_.FieldDefs.Add('Address1', ftWideString, 100, False);
  d.mtHead_.FieldDefs.Add('Address2', ftWideString, 100, False);
  d.mtHead_.FieldDefs.Add('Address3', ftWideString, 100, False);
  d.mtHead_.FieldDefs.Add('Address4', ftWideString, 100, False);
  d.mtHead_.FieldDefs.Add('Country', ftWideString, 2, False);
  d.mtHead_.FieldDefs.Add('CountryName', ftWideString, 100, False);
  d.mtHead_.FieldDefs.Add('PersonalId', ftWideString, 100, False);
  d.mtHead_.FieldDefs.Add('GuestName', ftWideString, 100, False);
  d.mtHead_.FieldDefs.Add('Breakfast', ftFloat);
  d.mtHead_.FieldDefs.Add('ExtraText', ftMemo);
  d.mtHead_.FieldDefs.Add('InvoiceDate', ftDate);
  d.mtHead_.FieldDefs.Add('payDate', ftDate);
  d.mtHead_.FieldDefs.Add('Staff', ftWideString, 40, False);
  d.mtHead_.FieldDefs.Add('InvoiceNumber', ftInteger);
  d.mtHead_.FieldDefs.Add('LocalCurrency', ftString, 03, False);
  d.mtHead_.FieldDefs.Add('Currency', ftString, 03, False);
  d.mtHead_.FieldDefs.Add('CurrencyRate', ftFloat);

  d.mtHead_.FieldDefs.Add('Reservation', ftInteger);
  d.mtHead_.FieldDefs.Add('RoomReservation', ftInteger);
  d.mtHead_.FieldDefs.Add('RoomNumber', ftWideString, 100, False);

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
  d.mtHead_.FieldDefs.Add('invRefrence', ftWideString, 60, False);

  d.mtHead_.FieldDefs.Add('invPrintText', ftWideString, 100, False);

  d.mtHead_.FieldDefs.Add('TotalStayTax', ftFloat);
  d.mtHead_.FieldDefs.Add('TotalStayTaxNights', ftInteger);

  d.mtHead_.FieldDefs.Add('PrePaid', ftFloat);
  d.mtHead_.FieldDefs.Add('Balance', ftFloat);
  d.mtHead_.FieldDefs.Add('foPrePaid', ftFloat);
  d.mtHead_.FieldDefs.Add('foBalance', ftFloat);

  d.mtHead_.FieldDefs.Add('Package', ftWideString, 40, False); // *99+
  d.mtHead_.FieldDefs.Add('PackageName', ftWideString, 150, False); // *99+
  d.mtHead_.FieldDefs.Add('ShowPackage', ftBoolean); // *99+
  d.mtHead_.FieldDefs.Add('Location', ftWideString, 20, False);

  if d.mtLines_.Active then
    d.mtLines_.Close;
  d.mtLines_.FieldDefs.clear;

  d.mtLines_.FieldDefs.Add('lineNo', ftInteger);
  d.mtLines_.FieldDefs.Add('Date', ftDate);
  d.mtLines_.FieldDefs.Add('Code', ftWideString, 40);
  d.mtLines_.FieldDefs.Add('Description', ftWideString, 200);
  d.mtLines_.FieldDefs.Add('Count', ftFloat);
  d.mtLines_.FieldDefs.Add('Price', ftFloat); // -96
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

  d.mtLines_.FieldDefs.Add('isPackage', ftBoolean); // *99+
  d.mtLines_.FieldDefs.Add('isRoomRent', ftBoolean); // *99+
  d.mtLines_.FieldDefs.Add('Show', ftBoolean); // *99+

  if d.mtPayments_.Active then
    d.mtPayments_.Close;
  d.mtPayments_.FieldDefs.clear;

  d.mtPayments_.FieldDefs.Add('Date', ftDate);
  d.mtPayments_.FieldDefs.Add('Code', ftWideString, 40);
  d.mtPayments_.FieldDefs.Add('Amount', ftFloat);
  d.mtPayments_.FieldDefs.Add('foAmount', ftFloat);
  d.mtPayments_.FieldDefs.Add('Description', ftWideString, 100);
  d.mtPayments_.FieldDefs.Add('TypeIndex', ftInteger);

  if d.mtVAT_.Active then
    d.mtVAT_.Close;
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

  if mtCompany_.Active then
    mtCompany_.Close;
  mtCompany_.FieldDefs.clear;

  mtCompany_.FieldDefs.Add('CompanyName', ftWideString, 100, False);
  mtCompany_.FieldDefs.Add('Address1', ftWideString, 100, False);
  mtCompany_.FieldDefs.Add('Address2', ftWideString, 100, False);
  mtCompany_.FieldDefs.Add('Address3', ftWideString, 100, False);
  mtCompany_.FieldDefs.Add('Address4', ftWideString, 100, False);
  mtCompany_.FieldDefs.Add('Country', ftWideString, 2, False);
  mtCompany_.FieldDefs.Add('CountryName', ftWideString, 100, False);
  mtCompany_.FieldDefs.Add('TelePhone1', ftWideString, 100, False);
  mtCompany_.FieldDefs.Add('TelePhone2', ftWideString, 100, False);
  mtCompany_.FieldDefs.Add('Fax', ftWideString, 100, False);
  mtCompany_.FieldDefs.Add('Email', ftWideString, 200, False);
  mtCompany_.FieldDefs.Add('HomePage', ftWideString, 200, False);
  mtCompany_.FieldDefs.Add('CompanyPID', ftWideString, 40, False);
  mtCompany_.FieldDefs.Add('CompanyVATno', ftWideString, 100, False);
  mtCompany_.FieldDefs.Add('CompanyBankInfo', ftWideString, 40, False);

  if mtCaptions_.Active then
    mtCaptions_.Close;
  mtCaptions_.FieldDefs.clear;

  mtCaptions_.FieldDefs.Add('invTxtHead', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtHeadDebit', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtHeadKredit', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtHeadInfoNumber', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtHeadInfoDate', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtHeadInfoCustomerNo', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtHeadInfoGjalddagi', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtHeadInfoEindagi', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtHeadInfoLocalCurrency', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtHeadInfoCurrency', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtHeadInfoCurrencyRate', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtHeadInfoReservation', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtHeadInfoCreditInvoice', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtHeadInfoOrginalInfo', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtHeadInfoGuest', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtHeadInfoRoom', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtLinesItemNo', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtLinesItemText', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtLinesItemCount', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtLinesItemPrice', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtLinesItemAmount', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtLinesItemTotal', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtExtra1', ftWideString, 400, False);
  mtCaptions_.FieldDefs.Add('invTxtExtra2', ftWideString, 400, False);
  mtCaptions_.FieldDefs.Add('invTxtFooterLine1', ftWideString, 400, False);
  mtCaptions_.FieldDefs.Add('invTxtFooterLine2', ftWideString, 400, False);
  mtCaptions_.FieldDefs.Add('invTxtFooterLine3', ftWideString, 400, False);
  mtCaptions_.FieldDefs.Add('invTxtFooterLine4', ftWideString, 400, False);
  mtCaptions_.FieldDefs.Add('invTxtPaymentListHead', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtPaymentListCode', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtPaymentListAmount', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtPaymentListDate', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtPaymentListTotal', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtPaymentLineHead', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtPaymentLineSeperator', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtVATListHead', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtVATListDescription', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtVATListwoVAT', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtVATListwVAT', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtVATListVATpr', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtVATListVATAmount', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtVATListTotal', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtVATLineHead', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtVATLineSeperator', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtTotalwoVAT', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtTotalVATAmount', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtTotalTotal', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtCompanyName', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtCompanyAddress', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtCompanyTel1', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtCompanyTel2', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtCompanyFax', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtCompanyEmail', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtCompanyHomePage', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtCompanyPID', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtCompanyBankInfo', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtCompanyVATId', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtTotalStayTax', ftWideString, 200, False);
  mtCaptions_.FieldDefs.Add('invTxtTotalStayTaxNights', ftWideString, 100, False);

  mtCaptions_.FieldDefs.Add('invTxtPaymentListDescription', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtHeadPrePaid', ftWideString, 100, False);
  mtCaptions_.FieldDefs.Add('invTxtHeadBalance', ftWideString, 100, False);

end;
{ TKeyAndValue }

constructor TKeyAndValue.Create(Key, Value: String);
begin
  FKey := Key;
  FValue := Value;
end;

// *********************************************************************************

procedure Td.RemoveReservationNotSave(iReservation: Integer; CancelStaff, CancelReason, CancelInformation: string;
  CancelType: Integer);
begin
  roomerMainDataSet.SystemRemoveReservation(iReservation, True, True, CancelReason, CancelStaff, CancelInformation,
    CancelType);
end;

CONST
  MIN_PROFORMA_INVOICENUMBER = 2000000000;

CONST
  MAX_PROFORMA_INVOICENUMBER = 2100000000;

function GenerateProformaInvoiceNumber: Integer;
var
  dTemp: dWord;
begin
  dTemp := GetTickCount;
  if dTemp < MIN_PROFORMA_INVOICENUMBER then
    dTemp := MIN_PROFORMA_INVOICENUMBER + dTemp;
  while dTemp > MAX_PROFORMA_INVOICENUMBER do
    dTemp := MIN_PROFORMA_INVOICENUMBER + (dTemp - MAX_PROFORMA_INVOICENUMBER);
  result := dTemp;
end;

/// /////////////////////////////////////////////////////////////////////////////////////////
//
// Turnower and payments
//

procedure Td.kbmRoomRentOnInvoice_BeforePost(DataSet: TDataSet);
begin
  if (DataSet.FieldByName('splitnumber').AsInteger = 1) and (DataSet.FieldByName('isTaxIncluted').asBoolean = True) then
  begin
    DataSet.FieldByName('totalStayTax').AsInteger := DataSet.FieldByName('totalStayTax').AsInteger * -1
  end;
end;

procedure Td.mInvoiceHeadsBeforePost(DataSet: TDataSet);
begin
  DataSet.FieldByName('isCash').asBoolean := False;
  DataSet.FieldByName('isKredit').asBoolean := False;
  DataSet.FieldByName('isGroup').asBoolean := False;
  DataSet.FieldByName('isRoom').asBoolean := False;

  if DataSet.FieldByName('SplitNumber').AsInteger = 1 then
  begin
    DataSet.FieldByName('isKredit').asBoolean := True;
  end;

  if (DataSet.FieldByName('Reservation').AsInteger = 0) AND
    (DataSet.FieldByName('RoomReservation').AsInteger = 0) then
  begin
    DataSet.FieldByName('isCash').asBoolean := True;
    exit;
  end;

  if (DataSet.FieldByName('RoomReservation').AsInteger = 0) and
    (DataSet.FieldByName('Reservation').AsInteger > 0) then
  begin
    DataSet.FieldByName('isGroup').asBoolean := True;
    exit;
  end;

  if (DataSet.FieldByName('RoomReservation').AsInteger > 0) and
    (DataSet.FieldByName('Reservation').AsInteger > 0) then
  begin
    DataSet.FieldByName('isRoom').asBoolean := True;
  end;
end;

procedure Td.mInvoicelines_afterNewRecord(DataSet: TDataSet);
begin
  DataSet['issystemline'] := False;
end;

procedure Td.mInvoicelines_beforeNewRecord(DataSet: TDataSet);
begin
  DataSet['issystemline'] := False;
end;

function CreateSQLInText(list: tstringList): string;
var
  i: Integer;
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

/// ///////////////////////////////////////////////////////////////////
/// Tornover and Payments report
///
/// ///////////////////////////////////////////////////////////////////

procedure Td.TurnoverAndPaymentsGetAll(clearData: boolean; var zGlob: recTurnoverAndPaymentsGlobals);
var
  s: string;
  rset1
    , rset2
    , rset3
    , rset4
    , rset5
    , rset6
    , rset8
    , rset9
    , rset10
    , rSet11
    , rSet12
    : TRoomerDataSet;

  ExecutionPlan: TRoomerExecutionPlan;

  lst: tstringList;

  sUnconfirmedDate: string;

  debug_s: string;

begin

  sUnconfirmedDate := '1900-01-01 00:00:00';
  Screen.Cursor := crHourglass;
  try
    if zGlob.ConfirmState = 1 then
    begin
      lst := invoiceList_Unconfirmed();
      try
        zGlob.Invoicelist := CreateSQLInText(lst);
      finally
        freeandnil(lst);
      end;
    end
  finally
    Screen.Cursor := crDefault;
  end;

  debug_s := 'use home100_xhj2;';
  Screen.Cursor := crHourglass;
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
    s := s + '  AND  ((il.ItemID <> ' + _db(zGlob.RoomRentItem) + ' )  '#10;
    s := s + '  AND  (il.ItemID <> ' + _db(zGlob.DiscountItem) + ' )  '#10;
    s := s + '  AND  (il.ItemID <> ' + _db(zGlob.TaxesItem) + ' ))  '#10;

    s := s + ' GROUP BY '#10;
    s := s + '     il.ItemID '#10;
    s := s + '   , it.Description '#10;
    s := s + '   , it.Itemtype '#10;
    s := s + '   , ity.Description '#10;
    s := s + '   , ity.VATCode '#10;
    s := s + '   , vat.VATPercentage ;'#10;

    // rset1,Results[0],d.kbmTurnover_
    // copyToClipboard(s);
    // DebugMessage('-- 0 Turnower '#10+s);

    debug_s := debug_s + #10#10'-- 0 d.kbmTurnover_. '#10 + s;
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

    // rset2,Results[1],d.kbmPayments_
    // copyToClipboard(s);
    // DebugMessage('-- 1 '#10+s);
    debug_s := debug_s + #10#10'-- 1 d.kbmPayments_. '#10 + s;
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

    // ATH**
    // s := s + ' AND (((' + StatusInStr('rd.resflag') + ') '#10;
    s := s + ' AND ((((rd.resflag IN (' + _db('G') + ',' + _db('D') + ')))  '#10;
    s := s + ' AND (date(rd.ADate) <=  CURDATE())) OR (rd.invoicenumber > 0)) '#10;
    s := s + ' AND (ResFlag <> ' + _db(STATUS_DELETED) + ' ) ;';
    // **zxhj line added

    // rset3,Results[2],d.kbmRoomsDate_
    // copyToClipboard(s);
    // DebugMessage('-- 2 '#10+s);
    debug_s := debug_s + #10#10'-- 2 d.kbmRoomsDate_. '#10 + s;
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
    s := s + '  AND  ((il.ItemID = ' + _db(zGlob.RoomRentItem) + ' )  '#10;
    s := s + '  OR   (il.ItemID = ' + _db(zGlob.DiscountItem) + ' )  '#10;
    s := s + '  OR   (il.ItemID = ' + _db(zGlob.TaxesItem) + ' )) '#10;
    s := s + '  AND  (il.invoicenumber > 0)  ;'#10;

    // rset4,Results[3],d.kbmRoomRentOnInvoice_
    // copyToClipboard(s);
    // DebugMessage('-- 3 Getting items in invoicelines is roomrent and invoiced'#10#10+s);
    debug_s := debug_s + #10#10'-- 3 d.kbmRoomRentOnInvoice_. '#10 + s;
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
    if zGlob.Invoicelist <> '' then
    begin
      s := s + '   (ih.InvoiceNumber IN ' + zGlob.Invoicelist + ') ' + #10;
    end
    else
    begin
      s := s + '   (ih.InvoiceNumber = -888) ' + #10;
    end;
    s := s + ' ORDER BY ' + #10;
    s := s + '   ih.InvoiceNumber ;' + #10;


    // rset5,Results[4]d.mInvoiceHeads
    // copyToClipboard(s);
    // DebugMessage('-- 4 Invoiceheads'#10#10+s);

    debug_s := debug_s + #10#10'-- 4 d.mInvoiceHeads. '#10 + s;
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
    if zGlob.Invoicelist <> '' then
    begin
      s := s + '   (il.InvoiceNumber IN ' + zGlob.Invoicelist + ') ;' + #10;
    end
    else
    begin
      s := s + '   (il.InvoiceNumber = -888) ;' + #10;
    end;

    // rset6,Results[5],d.mInvoiceLines
    // copyToClipboard(s);
    // DebugMessage('-- 5 invoicelines '#10#10+s);

    debug_s := debug_s + #10#10'-- 5 d.mInvoiceLines. '#10 + s;
    ExecutionPlan.AddQuery(s);

    s := '';
    s := s + ' SELECT id from control ' + #10;

    // rset7,Results[6],kbmRoomsDateInvoiced_
    // copyToClipboard(s);
    // DebugMessage('Getting all unpaid roomrent'#10#10+s);
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
    s := s + '  AND  ((il.ItemID <> ' + _db(zGlob.RoomRentItem) + ' )  '#10;
    s := s + '  AND  (il.ItemID <> ' + _db(zGlob.DiscountItem) + ' )  '#10;
    s := s + '  AND  (il.ItemID <> ' + _db(zGlob.TaxesItem) + ' ))  ;'#10;

    // copyToClipboard(s);
    // DebugMessage('-- 6 Getting items in invoicelines that is not roomrent'#10#10+s);

    debug_s := debug_s +
      #10#10'-- 7 DReportData.kbmUnconfirmedInvoicelines_. Getting items in invoicelines that is not roomrent'#10 + s;
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
    s := s + '  AND  ((il.ItemID <> ' + _db(zGlob.RoomRentItem) + ' )  '#10;
    s := s + '  AND  (il.ItemID <> ' + _db(zGlob.DiscountItem) + ' )  '#10;
    s := s + '  AND  (il.ItemID <> ' + _db(zGlob.TaxesItem) + ' ))  '#10;
    s := s + '  AND  ((il.Total-il.confirmAmount) <> 0)  ;'#10;

    // rset9,Results[8],d.kbmInvoiceLinePriceChange_
    // copyToClipboard(s);
    // DebugMessage('-- 7 Getting items in invoicelines that is not roomrent'#10#10+s);
    debug_s := debug_s +
      #10#10'-- 8 d.kbmInvoiceLinePriceChange_. Getting items in invoicelines that is not roomrent'#10 + s;
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
    s := s + '  AND (ResFlag <> ' + _db(STATUS_DELETED) + ')  ;'#10;


    // rset10,Results[9],d.kbmRoomsDateChange_
    // copyToClipboard(s);
    // DebugMessage('-- 8 Getting confirmed uninvoiced rent change '#10#10+s);

    debug_s := debug_s + #10#10'-- 9 d.kbmRoomsDateChange_. Getting confirmed uninvoiced rent change'#10 + s;
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
    s := s + '        ResFlag = ' + _db(STATUS_DELETED) + '  '#10;
    s := s + '    ) '#10;
    s := s + ' AND ( '#10;
    s := s + '   (rd.confirmAmount+rd.confirmDiscount+rd.confirmTax) <> 0 '#10;
    s := s + '    ) ;'#10;

    // rset11,Results[9],d.kbmRoomsDateChange_
    // copyToClipboard(s);
    // DebugMessage('-- 9 '#10#10+s);
    debug_s := debug_s + #10#10'-- 10 d.kbmRoomsDateChange_. Adding to roomsdateGhange'#10 + s;
    debug_s := debug_s + #10#10'-- 11 d.kbmPaymentList_. List of payments'#10 + s;
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
    s := s + '   ,IF(pm.typeindex=0,' + _db('Invoice') + ',' + _db('Downpayment') + ') AS Medhod '#10;
    // s := s + '   ,IF(pm.typeindex=0,'Invoice','Downpayment') AS Medhod '#10;
    s := s + '  FROM payments pm '#10;
    s := s + '        INNER JOIN paytypes pty ON pm.paytype = pty.paytype '#10;
    s := s + '        INNER JOIN paygroups pgr ON pty.paygroup = pgr.paygroup '#10;
    s := s + '   WHERE '#10;
    s := s + '( confirmDate = ' + _db(sUnconfirmedDate) + ') '#10;
    // s := s + '     ( confirmDate = '2014-05-03 14:05:31') '#10;
    s := s + '    ORDER BY '#10;
    s := s + '      pm.payDate ;'#10;

    debug_s := debug_s + #10#10'-- 11 d.kbmPaymentList_. List of payments'#10 + s;
    copytoclipboard(debug_s);
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
    d.kbmPaymentList_.DisableControls;
    try
      ExecutionPlan.Execute(ptQuery);

      /// ///////////////// Turnover

      rset1 := ExecutionPlan.Results[0];
      if d.kbmTurnover_.Active then
        d.kbmTurnover_.Close;
      d.kbmTurnover_.Open;
      kbmTurnover_.LoadFromDataSet(rset1, []);
      // LoadKbmMemtableFromDataSetQuiet(kbmTurnover_,rset1,[]);
      d.kbmTurnover_.First;

      // //////////////////// Payments
      rset2 := ExecutionPlan.Results[1];
      if d.kbmPayments_.Active then
        d.kbmPayments_.Close;
      d.kbmPayments_.Open;
      kbmPayments_.LoadFromDataSet(rset2, []);
      // LoadKbmMemtableFromDataSetQuiet(kbmPayments_,rset2,[]);
      d.kbmPayments_.First;

      rset3 := ExecutionPlan.Results[2];
      if d.kbmRoomsDate_.Active then
        d.kbmRoomsDate_.Close;
      d.kbmRoomsDate_.Open;
      kbmRoomsDate_.LoadFromDataSet(rset3, []);
      // LoadKbmMemtableFromDataSetQuiet(kbmRoomsDate_,rset3,[]);
      d.kbmRoomsDate_.First;

      rset4 := ExecutionPlan.Results[3];
      if d.kbmRoomRentOnInvoice_.Active then
        d.kbmRoomRentOnInvoice_.Close;
      d.kbmRoomRentOnInvoice_.Open;
      kbmRoomRentOnInvoice_.LoadFromDataSet(rset4, []);
      // LoadKbmMemtableFromDataSetQuiet(kbmRoomRentOnInvoice_,rset4,[]);
      d.kbmRoomRentOnInvoice_.First;

      rset5 := ExecutionPlan.Results[4];
      if d.mInvoiceHeads.Active then
        d.mInvoiceHeads.Close;
      d.mInvoiceHeads.Open;
      mInvoiceHeads.LoadFromDataSet(rset5, []);
      // LoadKbmMemtableFromDataSetQuiet(mInvoiceHeads,rset5,[]);
      d.mInvoiceHeads.First;

      rset6 := ExecutionPlan.Results[5];
      if d.mInvoiceLines.Active then
        d.mInvoiceLines.Close;
      d.mInvoiceLines.Open;
      mInvoiceLines.LoadFromDataSet(rset6, []);
      // LoadKbmMemtableFromDataSetQuiet(mInvoiceLines,rset6,[]);
      d.mInvoiceLines.First;

      rset8 := ExecutionPlan.Results[7];
      if DReportData.kbmUnconfirmedInvoicelines_.Active then
        DReportData.kbmUnconfirmedInvoicelines_.Close;
      DReportData.kbmUnconfirmedInvoicelines_.Open;
      DReportData.kbmUnconfirmedInvoicelines_.LoadFromDataSet(rset8, []);
      // LoadKbmMemtableFromDataSetQuiet(kbmUnconfirmedInvoicelines_,rset8,[]);
      DReportData.kbmUnconfirmedInvoicelines_.First;

      rset9 := ExecutionPlan.Results[8];
      if d.kbmInvoiceLinePriceChange_.Active then
        d.kbmInvoiceLinePriceChange_.Close;
      d.kbmInvoiceLinePriceChange_.Open;
      kbmInvoiceLinePriceChange_.LoadFromDataSet(rset9, []);
      // LoadKbmMemtableFromDataSetQuiet(kbmInvoiceLinePriceChange_,rset9,[]);
      d.kbmInvoiceLinePriceChange_.First;

      rset10 := ExecutionPlan.Results[9];
      if d.kbmRoomsDateChange_.Active then
        d.kbmRoomsDateChange_.Close;
      d.kbmRoomsDateChange_.Open;
      kbmRoomsDateChange_.LoadFromDataSet(rset10, []);
      // LoadKbmMemtableFromDataSetQuiet(kbmRoomsDateChange_,rset10,[]);
      d.kbmRoomsDateChange_.First;

      rSet11 := ExecutionPlan.Results[10];
      rSet11.First;
      while not rSet11.eof do
      begin
        d.kbmRoomsDateChange_.Insert;
        d.kbmRoomsDateChange_.FieldByName('StayDate').asDateTime := rSet11.FieldByName('StayDate').asDateTime;
        d.kbmRoomsDateChange_.FieldByName('roomreservation').AsInteger := rSet11.FieldByName('roomreservation')
          .AsInteger;
        d.kbmRoomsDateChange_.FieldByName('reservation').AsInteger := rSet11.FieldByName('reservation').AsInteger;
        d.kbmRoomsDateChange_.FieldByName('RentAmount').asFloat := 0.00;
        d.kbmRoomsDateChange_.FieldByName('currency').Asstring := rSet11.FieldByName('currency').Asstring;
        d.kbmRoomsDateChange_.FieldByName('currencyRate').asFloat :=
          rSet11.GetFloatValue(rSet11.FieldByName('currencyRate'));
        d.kbmRoomsDateChange_.FieldByName('DiscountAmount').asFloat := 0.00;
        d.kbmRoomsDateChange_.FieldByName('TotalStayTax').asFloat := 0.00;
        d.kbmRoomsDateChange_.FieldByName('roomsdateID').AsInteger := rSet11.FieldByName('roomsdateID').AsInteger;
        d.kbmRoomsDateChange_.FieldByName('invoicenumber').AsInteger := rSet11.FieldByName('invoicenumber').AsInteger;
        d.kbmRoomsDateChange_.FieldByName('discountChange').asFloat :=
          rSet11.GetFloatValue(rSet11.FieldByName('DiscountAmount')) * -1;
        if rSet11.FieldByName('customer').Asstring = '' then
        begin
          d.kbmRoomsDateChange_.FieldByName('isTaxIncluted').asBoolean := zGlob.StayTaxIncluted;
          d.kbmRoomsDateChange_.FieldByName('taxChange').asFloat :=
            rSet11.GetFloatValue(rSet11.FieldByName('taxchange'));
        end
        else
        begin
          d.kbmRoomsDateChange_.FieldByName('taxChange').asFloat :=
            rSet11.GetFloatValue(rSet11.FieldByName('TotalStayTax')) * -1;
          d.kbmRoomsDateChange_.FieldByName('isTaxIncluted').asBoolean := rSet11.FieldByName('isTaxIncluted').asBoolean;
        end;
        d.kbmRoomsDateChange_.FieldByName('rentChange').asFloat :=
          rSet11.GetFloatValue(rSet11.FieldByName('RentAmount')) * -1;
        d.kbmRoomsDateChange_.post;
        rSet11.next;
      end;

      rSet12 := ExecutionPlan.Results[11];
      if d.kbmPaymentList_.Active then
        d.kbmPaymentList_.Close;
      d.kbmPaymentList_.Open;
      // kbmPaymentL6ist_.LoadFromDataSet(rset12,[]);
      LoadKbmMemtableFromDataSetQuiet(kbmPaymentList_, rSet12, []);
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
      d.kbmPaymentList_.enableControls;
    end;

    d.TurnoverAndPaymentsUpdateTurnover(zGlob);
    d.TurnoverAndPaymentsUpdateTurnoverItemPriceChange(zGlob);

    zGlob.totalTurnover := 0;
    d.kbmTurnover_.First;
    while not d.kbmTurnover_.eof do
    begin
      zGlob.totalTurnover := zGlob.totalTurnover + d.kbmTurnover_.FieldByName('amount').asFloat;
      d.kbmTurnover_.next;
    end;
    d.kbmTurnover_.First;

    zGlob.TotalPayments := 0;
    d.kbmPayments_.First;
    while not d.kbmPayments_.eof do
    begin
      zGlob.TotalPayments := zGlob.TotalPayments + d.kbmPayments_.FieldByName('amount').asFloat;
      d.kbmPayments_.next;
    end;
    d.kbmPayments_.First;

  finally
    ExecutionPlan.Free;
    Screen.Cursor := crDefault;
  end;
  // pg001.ApplyBestFit;
end;

procedure Td.TurnoverAndPaymentsUpdateTurnover(var zGlob: recTurnoverAndPaymentsGlobals);
var
  rentAmount: Double;
  rentVat: Double;
  rentItemCount: Double; // -96

  DiscountAmount: Double;
  discountVat: Double;
  discountItemCount: Double; // -96

  cityTaxAmount: Double;
  cityTaxVat: Double;
  cityTaxItemCount: Double; // -96

  incl_cityTaxAmount: Double;
  incl_cityTaxVat: Double;
  incl_cityTaxItemCount: Double; // -96

  Item: string;

  isKredit: boolean;

begin

  rentAmount := 0;
  rentItemCount := 0.00; // -96

  DiscountAmount := 0;
  discountItemCount := 0.00; // -96

  cityTaxAmount := 0;
  cityTaxItemCount := 0.00; // -96

  incl_cityTaxAmount := 0;
  incl_cityTaxItemCount := 0.00; // -96

  d.kbmTurnover_.DisableControls;
  d.kbmPayments_.DisableControls;
  d.kbmRoomsDate_.DisableControls;
  try

    d.kbmRoomsDate_.First;
    while not d.kbmRoomsDate_.eof do
    begin
      rentAmount := rentAmount + d.kbmRoomsDate_.FieldByName('RentAmount').asFloat;
      if rentAmount <> 0 then
        rentItemCount := rentItemCount + 1;

      DiscountAmount := DiscountAmount + d.kbmRoomsDate_.FieldByName('DiscountAmount').asFloat;
      if DiscountAmount <> 0 then
        discountItemCount := discountItemCount + 1;

      if d.kbmRoomsDate_.FieldByName('isTaxIncluted').asBoolean then
      begin
        incl_cityTaxAmount := incl_cityTaxAmount + d.kbmRoomsDate_.FieldByName('TotalStayTax').asFloat;
        if incl_cityTaxAmount <> 0 then
          incl_cityTaxItemCount := incl_cityTaxItemCount + 1
      end
      else
      begin
        cityTaxAmount := cityTaxAmount + d.kbmRoomsDate_.FieldByName('TotalStayTax').asFloat;
        if cityTaxAmount <> 0 then
          cityTaxItemCount := cityTaxItemCount + 1
      end;
      d.kbmRoomsDate_.next;
    end;

    rentAmount := rentAmount - incl_cityTaxAmount;
    rentVat := _calcVat(rentAmount, zGlob.RoomRentVATPercentage);
    discountVat := _calcVat(DiscountAmount, zGlob.RoomRentVATPercentage);
    cityTaxVat := _calcVat(cityTaxAmount, zGlob.cTaxVATPercentage);
    incl_cityTaxVat := _calcVat(incl_cityTaxAmount, zGlob.cTaxVATPercentage);

    if d.kbmRoomsDate_.recordcount > 0 then
    begin
      if rentAmount <> 0 then
      begin
        if d.kbmTurnover_.locate('ItemId', zGlob.RoomRentItem, []) then
        begin
          d.kbmTurnover_.edit;
          d.kbmTurnover_.FieldByName('Amount').asFloat :=
            d.kbmTurnover_.FieldByName('Amount').asFloat + rentAmount;
          d.kbmTurnover_.FieldByName('VAT').asFloat :=
            d.kbmTurnover_.FieldByName('Vat').asFloat + rentVat;
          d.kbmTurnover_.FieldByName('Itemcount').asFloat := d.kbmTurnover_.FieldByName('itemcount').asFloat +
            rentItemCount; // -96
          d.kbmTurnover_.post;
        end
        else
        begin
          d.kbmTurnover_.Insert;
          d.kbmTurnover_.FieldByName('ItemId').Asstring := zGlob.RoomRentItem;
          d.kbmTurnover_.FieldByName('Description').Asstring := zGlob.RoomRentItemDescription;
          d.kbmTurnover_.FieldByName('Amount').asFloat := rentAmount;
          d.kbmTurnover_.FieldByName('VAT').asFloat := rentVat;

          d.kbmTurnover_.FieldByName('Itemtype').Asstring := zGlob.RoomRentType;
          d.kbmTurnover_.FieldByName('Typedescription').Asstring := zGlob.RoomRentTypeDescription;
          d.kbmTurnover_.FieldByName('VATCode').Asstring := zGlob.RoomRentVATCode;
          d.kbmTurnover_.FieldByName('ItemCount').asFloat := rentItemCount; // -96
          d.kbmTurnover_.FieldByName('VATPercentage').asFloat := zGlob.RoomRentVATPercentage;
          d.kbmTurnover_.post;
        end;
      end;

      if DiscountAmount <> 0 then
      begin
        if d.kbmTurnover_.locate('ItemId', zGlob.DiscountItem, []) then
        begin
          d.kbmTurnover_.edit;
          d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat +
            DiscountAmount * -1;
          d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + discountVat;
          d.kbmTurnover_.FieldByName('Itemcount').asFloat := d.kbmTurnover_.FieldByName('itemcount').asFloat +
            discountItemCount; // -96
          d.kbmTurnover_.post;
        end
        else
        begin
          d.kbmTurnover_.Insert;
          d.kbmTurnover_.FieldByName('ItemId').Asstring := zGlob.DiscountItem;
          d.kbmTurnover_.FieldByName('Description').Asstring := zGlob.DiscountItemDescription;

          d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat + DiscountAmount;
          d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + discountVat;

          d.kbmTurnover_.FieldByName('Itemtype').Asstring := zGlob.DiscountType;
          d.kbmTurnover_.FieldByName('Typedescription').Asstring := zGlob.DiscountTypeDescription;
          d.kbmTurnover_.FieldByName('VATCode').Asstring := zGlob.RoomRentVATCode;
          d.kbmTurnover_.FieldByName('ItemCount').asFloat := discountItemCount; // -96
          d.kbmTurnover_.FieldByName('VATPercentage').asFloat := zGlob.RoomRentVATPercentage;
          d.kbmTurnover_.post;
        end;
      end;

      if cityTaxAmount <> 0 then
      begin
        if d.kbmTurnover_.locate('ItemId', zGlob.TaxesItem, []) then
        begin
          d.kbmTurnover_.edit;
          d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat + cityTaxAmount;
          d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + cityTaxVat;
          d.kbmTurnover_.FieldByName('Itemcount').asFloat := d.kbmTurnover_.FieldByName('itemcount').asFloat +
            cityTaxItemCount; // -96
          d.kbmTurnover_.post;
        end
        else
        begin
          d.kbmTurnover_.Insert;
          d.kbmTurnover_.FieldByName('ItemId').Asstring := zGlob.TaxesItem;
          d.kbmTurnover_.FieldByName('Description').Asstring := zGlob.TaxesItemDescription;

          d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat + cityTaxAmount;
          d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + cityTaxVat;

          d.kbmTurnover_.FieldByName('Itemtype').Asstring := zGlob.cTaxType;
          d.kbmTurnover_.FieldByName('Typedescription').Asstring := zGlob.cTaxTypeDescription;
          d.kbmTurnover_.FieldByName('VATCode').Asstring := zGlob.cTaxVATCode;
          d.kbmTurnover_.FieldByName('ItemCount').asFloat := cityTaxItemCount; // -96
          d.kbmTurnover_.FieldByName('VATPercentage').asFloat := zGlob.cTaxVATPercentage;
          d.kbmTurnover_.post;
        end;
      end;

      if incl_cityTaxAmount <> 0 then
      begin
        if d.kbmTurnover_.locate('ItemId', '-', []) then
        begin
          d.kbmTurnover_.edit;
          d.kbmTurnover_.FieldByName('Amount').asFloat :=
            d.kbmTurnover_.FieldByName('Amount').asFloat + incl_cityTaxAmount;
          d.kbmTurnover_.FieldByName('VAT').asFloat :=
            d.kbmTurnover_.FieldByName('Vat').asFloat + cityTaxVat;
          d.kbmTurnover_.FieldByName('Itemcount').asFloat := d.kbmTurnover_.FieldByName('itemcount').asFloat +
            cityTaxItemCount; // -96
          d.kbmTurnover_.post;
        end
        else
        begin
          d.kbmTurnover_.Insert;
          d.kbmTurnover_.FieldByName('ItemId').Asstring := '-';
          d.kbmTurnover_.FieldByName('Description').Asstring := 'Incluted ' + zGlob.TaxesItemDescription;

          d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat +
            incl_cityTaxAmount;
          d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + incl_cityTaxVat;

          d.kbmTurnover_.FieldByName('Itemtype').Asstring := zGlob.cTaxType;
          d.kbmTurnover_.FieldByName('Typedescription').Asstring := zGlob.cTaxTypeDescription;
          d.kbmTurnover_.FieldByName('VATCode').Asstring := zGlob.cTaxVATCode;
          d.kbmTurnover_.FieldByName('ItemCount').asFloat := cityTaxItemCount; // -96
          d.kbmTurnover_.FieldByName('VATPercentage').asFloat := zGlob.cTaxVATPercentage;
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

    DiscountAmount := 0;
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
        if d.kbmRoomsDateChange_.FieldByName('RentChange').asFloat <> 0 then
        begin
          rentAmount := rentAmount + d.kbmRoomsDateChange_.FieldByName('RentChange').asFloat;
          if rentAmount <> 0 then
            rentItemCount := rentItemCount + 1;
        end;

        if d.kbmRoomsDateChange_.FieldByName('DiscountChange').asFloat <> 0 then
        begin
          DiscountAmount := DiscountAmount + d.kbmRoomsDateChange_.FieldByName('DiscountChange').asFloat;
          if DiscountAmount <> 0 then
            discountItemCount := discountItemCount + 1;
        end;

        if d.kbmRoomsDateChange_.FieldByName('TaxChange').asFloat <> 0 then
        begin
          if d.kbmRoomsDateChange_.FieldByName('isTaxIncluted').asBoolean then
          begin
            incl_cityTaxAmount := incl_cityTaxAmount + d.kbmRoomsDateChange_.FieldByName('TotalStayTax').asFloat;
            if incl_cityTaxAmount = 0 then
              incl_cityTaxAmount := d.kbmRoomsDateChange_.FieldByName('TaxChange').asFloat;

            if incl_cityTaxAmount <> 0 then
              incl_cityTaxItemCount := incl_cityTaxItemCount + 1;
          end
          else
          begin
            cityTaxAmount := cityTaxAmount + d.kbmRoomsDateChange_.FieldByName('TotalStayTax').asFloat;
            if cityTaxAmount = 0 then
              cityTaxAmount := d.kbmRoomsDateChange_.FieldByName('TaxChange').asFloat;
            if cityTaxAmount <> 0 then
              cityTaxItemCount := cityTaxItemCount + 1
          end;
        end;
        d.kbmRoomsDateChange_.next;
      end;

      if incl_cityTaxAmount > 0 then
      begin
        rentAmount := rentAmount + incl_cityTaxAmount;;
      end;
      if incl_cityTaxAmount < 0 then
      begin
        rentAmount := rentAmount - incl_cityTaxAmount;;
      end;

      rentVat := _calcVat(rentAmount, zGlob.RoomRentVATPercentage);
      discountVat := _calcVat(DiscountAmount, zGlob.RoomRentVATPercentage);
      cityTaxVat := _calcVat(cityTaxAmount, zGlob.cTaxVATPercentage);
      incl_cityTaxVat := _calcVat(incl_cityTaxAmount, zGlob.cTaxVATPercentage);

      if d.kbmRoomsDateChange_.recordcount > 0 then
      begin
        if rentAmount <> 0 then
        begin
          if d.kbmTurnover_.locate('ItemId', zGlob.RoomRentItem, []) then
          begin
            d.kbmTurnover_.edit;
            d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat + rentAmount;
            d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + rentVat;
            d.kbmTurnover_.FieldByName('Itemcount').asFloat := d.kbmTurnover_.FieldByName('itemcount').asFloat +
              rentItemCount; // -96
            d.kbmTurnover_.post;
          end
          else
          begin
            d.kbmTurnover_.Insert;
            d.kbmTurnover_.FieldByName('ItemId').Asstring := zGlob.RoomRentItem;
            d.kbmTurnover_.FieldByName('Description').Asstring := zGlob.RoomRentItemDescription;
            d.kbmTurnover_.FieldByName('Amount').asFloat := rentAmount;
            d.kbmTurnover_.FieldByName('VAT').asFloat := rentVat;

            d.kbmTurnover_.FieldByName('Itemtype').Asstring := zGlob.RoomRentType;
            d.kbmTurnover_.FieldByName('Typedescription').Asstring := zGlob.RoomRentTypeDescription;
            d.kbmTurnover_.FieldByName('VATCode').Asstring := zGlob.RoomRentVATCode;
            d.kbmTurnover_.FieldByName('ItemCount').asFloat := rentItemCount; // -96
            d.kbmTurnover_.FieldByName('VATPercentage').asFloat := zGlob.RoomRentVATPercentage;
            d.kbmTurnover_.post;
          end;
        end;

        if DiscountAmount <> 0 then
        begin
          if d.kbmTurnover_.locate('ItemId', zGlob.DiscountItem, []) then
          begin
            d.kbmTurnover_.edit;
            d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat +
              DiscountAmount * -1;
            d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + discountVat;
            d.kbmTurnover_.FieldByName('Itemcount').asFloat := d.kbmTurnover_.FieldByName('itemcount').asFloat +
              discountItemCount; // -96
            d.kbmTurnover_.post;
          end
          else
          begin
            d.kbmTurnover_.Insert;
            d.kbmTurnover_.FieldByName('ItemId').Asstring := zGlob.DiscountItem;
            d.kbmTurnover_.FieldByName('Description').Asstring := zGlob.DiscountItemDescription;

            d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat +
              DiscountAmount;
            d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + discountVat;

            d.kbmTurnover_.FieldByName('Itemtype').Asstring := zGlob.DiscountType;
            d.kbmTurnover_.FieldByName('Typedescription').Asstring := zGlob.DiscountTypeDescription;
            d.kbmTurnover_.FieldByName('VATCode').Asstring := zGlob.RoomRentVATCode;
            d.kbmTurnover_.FieldByName('ItemCount').asFloat := discountItemCount; // -96
            d.kbmTurnover_.FieldByName('VATPercentage').asFloat := zGlob.RoomRentVATPercentage;
            d.kbmTurnover_.post;
          end;
        end;

        if cityTaxAmount <> 0 then
        begin
          if d.kbmTurnover_.locate('ItemId', zGlob.TaxesItem, []) then
          begin
            d.kbmTurnover_.edit;
            d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat +
              cityTaxAmount;
            d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + cityTaxVat;
            d.kbmTurnover_.FieldByName('Itemcount').asFloat := d.kbmTurnover_.FieldByName('itemcount').asFloat +
              cityTaxItemCount; // -96
            d.kbmTurnover_.post;
          end
          else
          begin
            d.kbmTurnover_.Insert;
            d.kbmTurnover_.FieldByName('ItemId').Asstring := zGlob.TaxesItem;
            d.kbmTurnover_.FieldByName('Description').Asstring := zGlob.TaxesItemDescription;

            d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat +
              cityTaxAmount;
            d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + cityTaxVat;

            d.kbmTurnover_.FieldByName('Itemtype').Asstring := zGlob.cTaxType;
            d.kbmTurnover_.FieldByName('Typedescription').Asstring := zGlob.cTaxTypeDescription;
            d.kbmTurnover_.FieldByName('VATCode').Asstring := zGlob.cTaxVATCode;
            d.kbmTurnover_.FieldByName('ItemCount').asFloat := cityTaxItemCount; // -96
            d.kbmTurnover_.FieldByName('VATPercentage').asFloat := zGlob.cTaxVATPercentage;
            d.kbmTurnover_.post;
          end;
        end;

        if incl_cityTaxAmount <> 0 then
        begin
          if d.kbmTurnover_.locate('ItemId', '-', []) then
          begin
            d.kbmTurnover_.edit;
            d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat +
              incl_cityTaxAmount;
            d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + cityTaxVat;
            d.kbmTurnover_.FieldByName('Itemcount').asFloat := d.kbmTurnover_.FieldByName('itemcount').asFloat +
              cityTaxItemCount; // -96
            d.kbmTurnover_.post;
          end
          else
          begin
            d.kbmTurnover_.Insert;
            d.kbmTurnover_.FieldByName('ItemId').Asstring := '-';
            d.kbmTurnover_.FieldByName('Description').Asstring := 'Incluted ' + zGlob.TaxesItemDescription;
            d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat +
              incl_cityTaxAmount;
            d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + incl_cityTaxVat;

            d.kbmTurnover_.FieldByName('Itemtype').Asstring := zGlob.cTaxType;
            d.kbmTurnover_.FieldByName('Typedescription').Asstring := zGlob.cTaxTypeDescription;
            d.kbmTurnover_.FieldByName('VATCode').Asstring := zGlob.cTaxVATCode;
            d.kbmTurnover_.FieldByName('ItemCount').asFloat := cityTaxItemCount; // -96
            d.kbmTurnover_.FieldByName('VATPercentage').asFloat := zGlob.cTaxVATPercentage;
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

  DiscountAmount := 0;
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
      Item := d.kbmRoomRentOnInvoice_.FieldByName('itemID').Asstring;
      isKredit := d.kbmRoomRentOnInvoice_.FieldByName('splitNumber').AsInteger = 1;

      if isKredit then
      begin
        if _trimlower(Item) = _trimlower(zGlob.RoomRentItem) then
        begin
          rentAmount := rentAmount + d.kbmRoomRentOnInvoice_.FieldByName('Amount').asFloat;
          rentVat := rentVat + d.kbmRoomRentOnInvoice_.FieldByName('VAT').asFloat;;
          rentItemCount := rentItemCount + d.kbmRoomRentOnInvoice_.FieldByName('ItemCount').asFloat; // -96
        end;

        if _trimlower(Item) = _trimlower(zGlob.DiscountItem) then
        begin
          DiscountAmount := DiscountAmount + d.kbmRoomRentOnInvoice_.FieldByName('Amount').asFloat;
          discountVat := discountVat + d.kbmRoomRentOnInvoice_.FieldByName('VAT').asFloat;;
          discountItemCount := discountItemCount + d.kbmRoomRentOnInvoice_.FieldByName('ItemCount').asFloat; // -96
        end;

        if _trimlower(Item) = _trimlower(zGlob.TaxesItem) then
        begin
          cityTaxAmount := cityTaxAmount + d.kbmRoomRentOnInvoice_.FieldByName('Amount').asFloat;
          cityTaxVat := cityTaxVat + d.kbmRoomRentOnInvoice_.FieldByName('VAT').asFloat;
          cityTaxItemCount := cityTaxItemCount + d.kbmRoomRentOnInvoice_.FieldByName('ItemCount').asFloat; // -96
        end;

        if d.kbmRoomRentOnInvoice_.FieldByName('isTaxIncluted').asBoolean then
        begin
          incl_cityTaxAmount := incl_cityTaxAmount + (d.kbmRoomRentOnInvoice_.FieldByName('TotalStayTax').asFloat);
          incl_cityTaxItemCount := incl_cityTaxItemCount + 1;
        end;
      end;
      d.kbmRoomRentOnInvoice_.next;
    end;
  end;

  rentAmount := rentAmount - incl_cityTaxAmount;
  incl_cityTaxVat := _calcVat(incl_cityTaxAmount, zGlob.cTaxVATPercentage);

  if d.kbmRoomRentOnInvoice_.recordcount > 0 then
  begin
    if rentAmount <> 0 then
    begin
      if d.kbmTurnover_.locate('ItemId', zGlob.RoomRentItem, []) then
      begin
        d.kbmTurnover_.edit;
        d.kbmTurnover_.FieldByName('Amount').asFloat :=
          d.kbmTurnover_.FieldByName('Amount').asFloat + rentAmount;
        d.kbmTurnover_.FieldByName('VAT').asFloat :=
          d.kbmTurnover_.FieldByName('Vat').asFloat + rentVat;
        d.kbmTurnover_.FieldByName('Itemcount').asFloat := d.kbmTurnover_.FieldByName('itemcount').asFloat +
          rentItemCount; // -96
        d.kbmTurnover_.post;
      end
      else
      begin
        d.kbmTurnover_.Insert;
        d.kbmTurnover_.FieldByName('ItemId').Asstring := zGlob.RoomRentItem;
        d.kbmTurnover_.FieldByName('Description').Asstring := zGlob.RoomRentItemDescription;
        d.kbmTurnover_.FieldByName('Amount').asFloat := rentAmount;
        d.kbmTurnover_.FieldByName('VAT').asFloat := rentVat;

        d.kbmTurnover_.FieldByName('Itemtype').Asstring := zGlob.RoomRentType;
        d.kbmTurnover_.FieldByName('Typedescription').Asstring := zGlob.RoomRentTypeDescription;
        d.kbmTurnover_.FieldByName('VATCode').Asstring := zGlob.RoomRentVATCode;
        d.kbmTurnover_.FieldByName('ItemCount').asFloat := rentItemCount; // -96
        d.kbmTurnover_.FieldByName('VATPercentage').asFloat := zGlob.RoomRentVATPercentage;

        d.kbmTurnover_.post;
      end;
    end;

    if DiscountAmount <> 0 then
    begin
      if d.kbmTurnover_.locate('ItemId', zGlob.DiscountItem, []) then
      begin
        d.kbmTurnover_.edit;
        d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat +
          DiscountAmount * -1;
        d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + discountVat;
        d.kbmTurnover_.FieldByName('Itemcount').asFloat := d.kbmTurnover_.FieldByName('itemcount').asFloat +
          discountItemCount; // -96
        d.kbmTurnover_.post;
      end
      else
      begin
        d.kbmTurnover_.Insert;
        d.kbmTurnover_.FieldByName('ItemId').Asstring := zGlob.DiscountItem;
        d.kbmTurnover_.FieldByName('Description').Asstring := zGlob.DiscountItemDescription;

        d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat + DiscountAmount;
        d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + discountVat;

        d.kbmTurnover_.FieldByName('Itemtype').Asstring := zGlob.DiscountType;
        d.kbmTurnover_.FieldByName('Typedescription').Asstring := zGlob.DiscountTypeDescription;
        d.kbmTurnover_.FieldByName('VATCode').Asstring := zGlob.RoomRentVATCode;
        d.kbmTurnover_.FieldByName('ItemCount').asFloat := discountItemCount; // -96
        d.kbmTurnover_.FieldByName('VATPercentage').asFloat := zGlob.RoomRentVATPercentage;
        d.kbmTurnover_.post;
      end;
    end;

    if cityTaxAmount <> 0 then
    begin
      if d.kbmTurnover_.locate('ItemId', zGlob.TaxesItem, []) then
      begin
        d.kbmTurnover_.edit;
        d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat + cityTaxAmount;
        d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + cityTaxVat;
        d.kbmTurnover_.FieldByName('Itemcount').asFloat := d.kbmTurnover_.FieldByName('itemcount').asFloat +
          cityTaxItemCount; // -96
        d.kbmTurnover_.post;
      end
      else
      begin
        d.kbmTurnover_.Insert;
        d.kbmTurnover_.FieldByName('ItemId').Asstring := zGlob.TaxesItem;
        d.kbmTurnover_.FieldByName('Description').Asstring := zGlob.TaxesItemDescription;

        d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat + cityTaxAmount;
        d.kbmTurnover_.FieldByName('VAT').asFloat :=
          d.kbmTurnover_.FieldByName('Vat').asFloat + cityTaxVat;

        d.kbmTurnover_.FieldByName('Itemtype').Asstring := zGlob.cTaxType;
        d.kbmTurnover_.FieldByName('Typedescription').Asstring := zGlob.cTaxTypeDescription;
        d.kbmTurnover_.FieldByName('VATCode').Asstring := zGlob.cTaxVATCode;
        d.kbmTurnover_.FieldByName('ItemCount').asFloat := cityTaxItemCount; // -96
        d.kbmTurnover_.FieldByName('VATPercentage').asFloat := zGlob.cTaxVATPercentage;
        d.kbmTurnover_.post;
      end;
    end;

    if incl_cityTaxAmount <> 0 then
    begin
      Item := '-';
      if d.kbmTurnover_.locate('ItemId', Item, []) then
      begin
        d.kbmTurnover_.edit;
        d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat +
          incl_cityTaxAmount;
        d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + cityTaxVat;
        d.kbmTurnover_.FieldByName('Itemcount').asFloat := d.kbmTurnover_.FieldByName('itemcount').asFloat +
          cityTaxItemCount; // -96
        d.kbmTurnover_.post;
      end
      else
      begin
        d.kbmTurnover_.Insert;
        d.kbmTurnover_.FieldByName('ItemId').Asstring := Item;
        d.kbmTurnover_.FieldByName('Description').Asstring := 'Incluted ' + zGlob.TaxesItemDescription;

        d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat +
          incl_cityTaxAmount;
        d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + incl_cityTaxVat;

        d.kbmTurnover_.FieldByName('Itemtype').Asstring := zGlob.cTaxType;
        d.kbmTurnover_.FieldByName('Typedescription').Asstring := zGlob.cTaxTypeDescription;
        d.kbmTurnover_.FieldByName('VATCode').Asstring := zGlob.cTaxVATCode;
        d.kbmTurnover_.FieldByName('ItemCount').asFloat := cityTaxItemCount; // -96
        d.kbmTurnover_.FieldByName('VATPercentage').asFloat := zGlob.cTaxVATPercentage;
        d.kbmTurnover_.post;
      end;
    end;
  end;
end;

procedure Td.TurnoverAndPaymentsUpdateTurnoverItemPriceChange(var rec: recTurnoverAndPaymentsGlobals);
var
  Amount: Double;
  Vat: Double;
  ItemCount: Double;

  Item: string;
begin
  if d.kbmInvoiceLinePriceChange_.recordcount = 0 then
    exit;

  d.kbmTurnover_.DisableControls;
  d.kbmInvoiceLinePriceChange_.DisableControls;
  try
    d.kbmInvoiceLinePriceChange_.First;
    while not d.kbmInvoiceLinePriceChange_.eof do
    begin
      Item := d.kbmInvoiceLinePriceChange_.FieldByName('itemID').Asstring;
      Amount := d.kbmInvoiceLinePriceChange_.FieldByName('Pricechange').asFloat;
      Vat := d.kbmInvoiceLinePriceChange_.FieldByName('Vat').asFloat;
      ItemCount := d.kbmInvoiceLinePriceChange_.FieldByName('ItemCount').asFloat; // -96

      if d.kbmTurnover_.locate('ItemId', Item, []) then
      begin
        d.kbmTurnover_.edit;
        d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat + Amount;
        d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + Vat;
        d.kbmTurnover_.FieldByName('Itemcount').asFloat := d.kbmTurnover_.FieldByName('itemcount').AsInteger +
          ItemCount; // -96
        d.kbmTurnover_.post;;
      end
      else
      begin
        d.kbmTurnover_.Insert;
        d.kbmTurnover_.FieldByName('ItemId').Asstring := Item;
        d.kbmTurnover_.FieldByName('Amount').asFloat := Amount;
        d.kbmTurnover_.FieldByName('VAT').asFloat := Vat;
        d.kbmTurnover_.FieldByName('ItemCount').asFloat := ItemCount; // -96

        d.kbmTurnover_.FieldByName('Description').Asstring :=
          d.kbmInvoiceLinePriceChange_.FieldByName('Description').Asstring;
        d.kbmTurnover_.FieldByName('Itemtype').Asstring :=
          d.kbmInvoiceLinePriceChange_.FieldByName('Itemtype').Asstring;
        d.kbmTurnover_.FieldByName('Typedescription').Asstring :=
          d.kbmInvoiceLinePriceChange_.FieldByName('Typedescription').Asstring;
        d.kbmTurnover_.FieldByName('VATCode').Asstring :=
          d.kbmInvoiceLinePriceChange_.FieldByName('VATCode').Asstring;
        d.kbmTurnover_.FieldByName('VATPercentage').asFloat :=
          d.kbmInvoiceLinePriceChange_.FieldByName('VATPercentage').asFloat;
        d.kbmTurnover_.post;
      end;
      d.kbmInvoiceLinePriceChange_.next;
    end;
  finally
    d.kbmInvoiceLinePriceChange_.enableControls;
    d.kbmTurnover_.enableControls;
  end;
end;

procedure Td.TurnoverAndPaymentsDoConfirm;
var
  rSet: TRoomerDataSet;
  s: string;
  iCount: Integer;
  ok: boolean;
  Amount: Double;
  Discount: Double;
  Tax: Double;
  Id: Integer;
  CurrencyRate: Double;

  confirmDate: TdateTime;
  dataType: Integer;
  Item: string;
  Description: string;
  Staff: string;
  Itemtype: string;
  ItemTypeDescription: string;
  itemNotes: string;
  VATCode: string;
  VATPercentage: Double;
  Vat: Double;
  ItemCount: Double;

  StayDate: TdateTime;
  RoomReservation: Integer;
  reservation: Integer;
  rentAmount: Double;
  Currency: string;
  isTaxIncluted: boolean;
  DiscountAmount: Double;
  TotalStayTax: Double;
  roomsdateID: Integer;
  InvoiceNumber: Integer;
  discountChange: Double;
  taxChange: Double;
  rentChange: Double;
  ItemID: string;
  TypeDescription: string;
  ivlID: Integer;
  PurchaseDate: TdateTime;
  confirmAmount: Double;
  PriceChange: Double;

  zConfirmedDate: TdateTime;
begin

  Screen.Cursor := crHourglass;
  try

    zConfirmedDate := now;
    ok := True;

    d.kbmRoomsDate_.DisableControls;
    try
      d.kbmRoomsDate_.First;

      while not d.kbmRoomsDate_.eof do
      begin
        Id := d.kbmRoomsDate_.FieldByName('id').AsInteger;
        Amount := d.kbmRoomsDate_.FieldByName('RentAmount').asFloat;
        Discount := d.kbmRoomsDate_.FieldByName('discountAmount').asFloat;
        Tax := d.kbmRoomsDate_.FieldByName('TotalStayTax').asFloat;
        CurrencyRate := d.kbmRoomsDate_.FieldByName('currencyRate').asFloat;

        s := '';
        s := s + ' UPDATE roomsdate ';
        s := s + ' SET ';
        s := s + '    ConfirmDate = ' + _dbDateAndTime(zConfirmedDate) + ' '#10;
        s := s + '   ,ConfirmAmount = ' + _db(Amount) + ' '#10;
        s := s + '   ,ConfirmDiscount = ' + _db(Discount) + ' '#10;
        s := s + '   ,ConfirmTax = ' + _db(Tax) + ' '#10;
        s := s + '   ,ConfirmCurrencyRate = ' + _db(CurrencyRate) + ' '#10;
        s := s + ' WHERE ' + #10;
        s := s + '   (id = ' + _db(Id) + ') ' + #10;
        if not cmd_bySQL(s) then
        begin
          ok := False;
        end;
        d.kbmRoomsDate_.next;
      end;
    finally
      d.kbmRoomsDate_.enableControls;
    end;

    d.kbmRoomsDateChange_.DisableControls;
    try
      d.kbmRoomsDateChange_.First;

      while not d.kbmRoomsDateChange_.eof do
      begin
        Id := d.kbmRoomsDateChange_.FieldByName('RoomsdateID').AsInteger;
        Amount := d.kbmRoomsDateChange_.FieldByName('RentChange').asFloat;
        Discount := d.kbmRoomsDateChange_.FieldByName('discountChange').asFloat;
        Tax := d.kbmRoomsDateChange_.FieldByName('TaxChange').asFloat;

        s := '';
        s := s + ' SELECT '#10;
        s := s + '  confirmAmount '#10;
        s := s + ' ,confirmDiscount '#10;
        s := s + ' ,confirmTax '#10;
        s := s + ' ,ResFlag '#10;
        s := s + ' FROM '#10;
        s := s + ' RoomsDate '#10;
        s := s + ' WHERE '#10;
        s := s + ' id=' + _db(Id) + ' '#10;

        rSet := CreateNewDataSet;
        try
          rSet_bySQL(rSet, s);
          if not rSet.eof then
          begin
            if rSet.FieldByName('ResFlag').Asstring = STATUS_DELETED then
            begin
              Amount := 0.00;
              Discount := 0.00;
              Tax := 0.00;
            end
            else
            begin
              Amount := Amount + rSet.FieldByName('confirmAmount').asFloat;
              Discount := Discount + rSet.FieldByName('confirmDiscount').asFloat;
              Tax := Tax + rSet.FieldByName('confirmTax').asFloat;
            end;
          end;
        finally
          freeandnil(rSet);
        end;

        // ****ATHATH
        s := '';
        s := s + ' UPDATE roomsdate ';
        s := s + ' SET ';
        s := s + '    ConfirmAmount = ' + _db(Amount) + ' '#10;
        s := s + '   ,ConfirmDiscount = ' + _db(Discount) + ' '#10;
        s := s + '   ,ConfirmTax = ' + _db(Tax) + ' '#10;
        s := s + ' WHERE ' + #10;
        s := s + '   (id = ' + _db(Id) + ') ' + #10;

        if not cmd_bySQL(s) then
        begin
          ok := False;
        end;
        d.kbmRoomsDateChange_.next;
      end;
    finally
      d.kbmRoomsDateChange_.enableControls;
    end;

    DReportData.kbmUnconfirmedInvoicelines_.DisableControls;
    try
      DReportData.kbmUnconfirmedInvoicelines_.First;
      while not DReportData.kbmUnconfirmedInvoicelines_.eof do
      begin
        Id := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('id').AsInteger;
        // --villa
        Amount := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('Amount').asFloat;

        s := '';
        s := s + ' UPDATE invoicelines ';
        s := s + ' SET ';
        s := s + '    ConfirmDate = ' + _dbDateAndTime(zConfirmedDate) + ' '#10;
        s := s + '   ,ConfirmAmount = ' + _db(Amount) + ' '#10;
        s := s + ' WHERE ' + #10;
        s := s + '   (id = ' + _db(Id) + ') ' + #10;
        if not cmd_bySQL(s) then
        begin
          ok := False;
        end;
        DReportData.kbmUnconfirmedInvoicelines_.next;
      end;
    finally
      DReportData.kbmUnconfirmedInvoicelines_.enableControls;
    end;

    d.kbmInvoiceLinePriceChange_.DisableControls;
    try
      d.kbmInvoiceLinePriceChange_.First;
      while not d.kbmInvoiceLinePriceChange_.eof do
      begin
        Id := d.kbmInvoiceLinePriceChange_.FieldByName('ivlid').AsInteger;
        Amount := d.kbmInvoiceLinePriceChange_.FieldByName('Amount').AsInteger;

        s := '';
        s := s + ' UPDATE invoicelines ';
        s := s + ' SET ';
        // s := s + '    ConfirmDate = '+_dbDateAndTime(confirmdate)+' '#10;
        s := s + '   ConfirmAmount = ' + _db(Amount) + ' '#10;
        s := s + ' WHERE ' + #10;
        s := s + '   (id = ' + _db(Id) + ') ' + #10;
        if not cmd_bySQL(s) then
        begin
          ok := False;
        end;
        d.kbmInvoiceLinePriceChange_.next;
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
      ok := False;
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
      ok := False;
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
      ok := False;
    end;

    d.kbmTurnover_.First;
    while not d.kbmTurnover_.eof do
    begin
      dataType := 1;
      confirmDate := zConfirmedDate;
      Item := d.kbmTurnover_.FieldByName('itemID').Asstring;
      Description := d.kbmTurnover_.FieldByName('Description').Asstring;
      Staff := g.qUserName;
      Itemtype := d.kbmTurnover_.FieldByName('itemType').Asstring;
      ItemTypeDescription := d.kbmTurnover_.FieldByName('TypeDescription').Asstring;

      VATCode := d.kbmTurnover_.FieldByName('VATcode').Asstring;
      VATPercentage := d.kbmTurnover_.FieldByName('VATPercentage').asFloat;
      Vat := d.kbmTurnover_.FieldByName('VAT').asFloat;
      ItemCount := d.kbmTurnover_.FieldByName('itemCount').asFloat; // -96
      Amount := d.kbmTurnover_.FieldByName('Amount').asFloat;

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
      s := s + ' ,' + _db(Item) + ' '#10;
      s := s + ' ,' + _db(Description) + ' '#10;
      s := s + ' ,' + _db(Amount) + ' '#10;
      s := s + ' ,' + _db(Staff) + ' '#10;
      s := s + ' ,' + _db(Itemtype) + ' '#10;
      s := s + ' ,' + _db(ItemTypeDescription) + ' '#10;
      s := s + ' ,' + _db(dataType) + ' '#10;
      s := s + ' ,' + _db(VATCode) + ' '#10;
      s := s + ' ,' + _db(VATPercentage) + ' '#10;
      s := s + ' ,' + _db(Vat) + ' '#10;
      s := s + ' ,' + _db(ItemCount) + ' '#10;
      s := s + ' ) '#10;

      if not cmd_bySQL(s) then
      begin
        ok := False;
      end;
      d.kbmTurnover_.next;
    end;

    d.kbmPayments_.First;
    while not d.kbmPayments_.eof do
    begin
      dataType := 2;
      confirmDate := zConfirmedDate;
      Item := d.kbmPayments_.FieldByName('payType').Asstring;
      Description := d.kbmPayments_.FieldByName('paytypeDescription').Asstring;
      Staff := g.qUserName;
      Itemtype := '-';
      ItemTypeDescription := d.kbmPayments_.FieldByName
        ('paygroupDescripion').Asstring;

      VATCode := '';
      VATPercentage := 0;
      Vat := 0;
      ItemCount := d.kbmPayments_.FieldByName('PaymentCount').asFloat; // -96
      Amount := d.kbmPayments_.FieldByName('Amount').asFloat;

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
      s := s + ' ,' + _db(Item) + ' '#10;
      s := s + ' ,' + _db(Description) + ' '#10;
      s := s + ' ,' + _db(Amount) + ' '#10;
      s := s + ' ,' + _db(Staff) + ' '#10;
      s := s + ' ,' + _db(Itemtype) + ' '#10;
      s := s + ' ,' + _db(ItemTypeDescription) + ' '#10;
      s := s + ' ,' + _db(dataType) + ' '#10;
      s := s + ' ,' + _db(VATCode) + ' '#10;
      s := s + ' ,' + _db(VATPercentage) + ' '#10;
      s := s + ' ,' + _db(Vat) + ' '#10;
      s := s + ' ,' + _db(ItemCount) + ' '#10;
      s := s + ' ) '#10;

      if not cmd_bySQL(s) then
      begin
        ok := False;
      end;
      d.kbmPayments_.next;
    end;

    d.kbmInvoiceLinePriceChange_.First;
    while not d.kbmInvoiceLinePriceChange_.eof do
    begin

      ItemID := d.kbmInvoiceLinePriceChange_.FieldByName('ItemID').Asstring;
      Description := d.kbmInvoiceLinePriceChange_.FieldByName('Description').Asstring;
      Itemtype := d.kbmInvoiceLinePriceChange_.FieldByName('Itemtype').Asstring;
      TypeDescription := d.kbmInvoiceLinePriceChange_.FieldByName('TypeDescription').Asstring;
      VATCode := d.kbmInvoiceLinePriceChange_.FieldByName('VATCode').Asstring;
      VATPercentage := d.kbmInvoiceLinePriceChange_.FieldByName('VATPercentage').asFloat;
      Amount := d.kbmInvoiceLinePriceChange_.FieldByName('Amount').asFloat;
      Vat := d.kbmInvoiceLinePriceChange_.FieldByName('VAT').asFloat;
      ItemCount := d.kbmInvoiceLinePriceChange_.FieldByName('Itemcount').asFloat; // -96
      ivlID := d.kbmInvoiceLinePriceChange_.FieldByName('ivlID').AsInteger;
      PurchaseDate := d.kbmInvoiceLinePriceChange_.FieldByName('PurchaseDate').asDateTime;
      reservation := d.kbmInvoiceLinePriceChange_.FieldByName('reservation').AsInteger;
      RoomReservation := d.kbmInvoiceLinePriceChange_.FieldByName('roomReservation').AsInteger;
      confirmAmount := d.kbmInvoiceLinePriceChange_.FieldByName('confirmAmount').asFloat;
      PriceChange := d.kbmInvoiceLinePriceChange_.FieldByName('PriceChange').asFloat;

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
      s := s + ' ,' + _db(Itemtype) + ' '#10;
      s := s + ' ,' + _db(TypeDescription) + ' '#10;
      s := s + ' ,' + _db(VATCode) + ' '#10;
      s := s + ' ,' + _db(VATPercentage) + ' '#10;
      s := s + ' ,' + _db(Amount) + ' '#10;
      s := s + ' ,' + _db(Vat) + ' '#10;
      s := s + ' ,' + _db(ItemCount) + ' '#10;
      s := s + ' ,' + _db(ivlID) + ' '#10;
      s := s + ' ,' + _db(PurchaseDate) + ' '#10;
      s := s + ' ,' + _db(reservation) + ' '#10;
      s := s + ' ,' + _db(RoomReservation) + ' '#10;
      s := s + ' ,' + _db(confirmAmount) + ' '#10;
      s := s + ' ,' + _db(PriceChange) + ' '#10;
      s := s + ' ,' + _dbDateAndTime(zConfirmedDate) + ' '#10;
      s := s + ' ) '#10;

      if not cmd_bySQL(s) then
      begin
        ok := False;
      end;
      d.kbmInvoiceLinePriceChange_.next;
    end;

    d.kbmRoomsDateChange_.First;
    while not d.kbmRoomsDateChange_.eof do
    begin
      StayDate := d.kbmRoomsDateChange_.FieldByName('StayDate').asDateTime;
      RoomReservation := d.kbmRoomsDateChange_.FieldByName('roomreservation').AsInteger;
      reservation := d.kbmRoomsDateChange_.FieldByName('reservation').AsInteger;
      rentAmount := d.kbmRoomsDateChange_.FieldByName('RentAmount').asFloat;
      Currency := d.kbmRoomsDateChange_.FieldByName('currency').Asstring;
      CurrencyRate := d.kbmRoomsDateChange_.FieldByName('currencyRate').asFloat;
      isTaxIncluted := d.kbmRoomsDateChange_.FieldByName('isTaxIncluted').asBoolean;
      DiscountAmount := d.kbmRoomsDateChange_.FieldByName('DiscountAmount').asFloat;
      TotalStayTax := d.kbmRoomsDateChange_.FieldByName('TotalStayTax').asFloat;
      roomsdateID := d.kbmRoomsDateChange_.FieldByName('roomsdateID').AsInteger;
      InvoiceNumber := d.kbmRoomsDateChange_.FieldByName('invoicenumber').AsInteger;
      discountChange := d.kbmRoomsDateChange_.FieldByName('discountChange').asFloat;
      taxChange := d.kbmRoomsDateChange_.FieldByName('taxChange').asFloat;
      rentChange := d.kbmRoomsDateChange_.FieldByName('rentChange').asFloat;
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
      s := s + ' ,' + _db(RoomReservation) + ' '#10;
      s := s + ' ,' + _db(reservation) + ' '#10;
      s := s + ' ,' + _db(rentAmount) + ' '#10;
      s := s + ' ,' + _db(Currency) + ' '#10;
      s := s + ' ,' + _db(CurrencyRate) + ' '#10;
      s := s + ' ,' + _db(isTaxIncluted) + ' '#10;
      s := s + ' ,' + _db(DiscountAmount) + ' '#10;
      s := s + ' ,' + _db(TotalStayTax) + ' '#10;
      s := s + ' ,' + _db(roomsdateID) + ' '#10;
      s := s + ' ,' + _db(InvoiceNumber) + ' '#10;
      s := s + ' ,' + _db(discountChange) + ' '#10;
      s := s + ' ,' + _db(taxChange) + ' '#10;
      s := s + ' ,' + _db(rentChange) + ' '#10;
      s := s + ' ,' + _dbDateAndTime(zConfirmedDate) + ' '#10;
      s := s + ' ) '#10;
      if not cmd_bySQL(s) then
      begin
        ok := False;
      end;
      d.kbmRoomsDateChange_.next;
    end;

    if ok then
    begin
      g.qLastConfirm := zConfirmedDate;
      // zIsConfirmed := true;
      // zConfirmState := 2;
      // btnConfirm.visible := false;
      // btnGetOld.visible := true;
      // chkGetUnconfirmed.checked := false;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

function minutesFromMidnight: Integer;
var
  Hour, Min, Sec, MSec: Word;
  aTime: TdateTime;
begin
  aTime := now;
  DecodeTime(aTime, Hour, Min, Sec, MSec);
  result := (Hour * 60) + Min;
end;

procedure Td.confirmMonitorTimer(Sender: TObject);
var
  doIt: boolean;
  globals: recTurnoverAndPaymentsGlobals;
  globals_II: recTurnoverAndPaymentsGlobals_II;
  s: string;
begin
  if NOT d.roomerMainDataSet.LoggedIn then
    exit;

  doIt := False;
  if g.qConfirmAuto then
  begin
    if (MinutesBetween(now, g.qLastConfirm) > 1440) AND (g.qLastConfirm > 2) then
    begin
      doIt := True
    end
    else
      if (minutesFromMidnight > g.qConfirmMinuteOfTheDay - 1) and (minutesFromMidnight < g.qConfirmMinuteOfTheDay + 2)
    then
    begin
      if MinutesBetween(now, g.qLastConfirm) > 5 then
        doIt := True;
    end;
    if doIt then
    begin
      if isStayTaxExcluded then
      begin
        initTurnoverAndPaymentsGlobals_II(globals_II);
        d.TurnoverAndPaymentsGetAll_II(False, globals_II);
        d.TurnoverAndPaymentsDoConfirm_II;
        d.TurnoverAndPayemnetsClearAllData(True);
      end
      else
      begin
        initTurnoverAndPaymentsGlobals(globals);
        d.TurnoverAndPaymentsGetAll(False, globals);
        d.TurnoverAndPaymentsDoConfirm;
        d.TurnoverAndPayemnetsClearAllData(True);
      end;
      datetimetostring(s, 'YYYY-DD-MM hh:nn:ss', now);
      showmessage('Turnover and payments - Auto Confirmed at  ' + s);
    end;
  end;
end;

function Td.GetLastConfirm: TdateTime;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := 0;
  if frmMain.OfflineMode then
    exit;

  rSet := CreateNewDataSet;
  try
    s := '';
    s := s + ' SELECT '#10;
    s := s + '   confirmdate '#10;
    s := s + ' FROM '#10;
    s := s + '   turnoverandpayments '#10;
    s := s + ' ORDER BY '#10;
    s := s + '   confirmdate desc '#10;
    s := s + ' LIMIT 1; '#10;
    rSet_bySQL(rSet, s);
    if not rSet.eof then
    begin
      result := rSet.FieldByName('confirmdate').asDateTime;
    end
    else
    begin
      result := 2;
    end;
  finally
    freeandnil(rSet);
  end;
end;

/// ////////////////////////////////////////////////////////////////////
// Tornover and payments
// New works if city tax is always excluted as an item
/// ////////////////////////////////////////////////////////////////////

// use both in 1 and 2
procedure Td.TurnoverAndPayemnetsClearAllData(justClose: boolean);
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
  d.mrptTurnover.Close;

  if not justClose then
  begin
    d.kbmTurnover_.Open;
    d.kbmPayments_.Open;
    d.kbmRoomsDate_.Open;
    d.kbmRoomRentOnInvoice_.Open;
    d.mInvoiceHeads.Open;
    d.mInvoiceLines.Open;
    DReportData.kbmUnconfirmedInvoicelines_.Open;
    d.kbmInvoiceLinePriceChange_.Open;
    d.kbmPaymentList_.Open;
    d.mrptPayments.Open;
    d.mrptTurnover.Open;
  end;
end;

procedure Td.TurnoverAndPaymentsGetAll_II(clearData: boolean; var zGlob: recTurnoverAndPaymentsGlobals_II);
var
  s: string;
  rset1
    , rset2
    , rset3
    , rset4
    , rset5
    , rset6
    , rset8
    , rset9
    , rset10
    , rSet11
    , rSet12
    : TRoomerDataSet;

  ExecutionPlan: TRoomerExecutionPlan;

  lst: tstringList;

  sUnconfirmedDate: string;

  debug_s: string;

begin

  sUnconfirmedDate := '1900-01-01 00:00:00';

  // ATH  if length(trim(edUnconfirmedDate.Text)) = 19  then
  // begin
  // sUnconfirmedDate := edUnconfirmedDate.Text;
  // try
  // datetimetostring(sUnconfirmedDate, 'yyyy-mm-dd hh:nn:ss', unconfirmedDate);
  // Except
  // sUnconfirmedDate := '1900-01-01 00:00:00';
  // end;
  // end;

  // 2
  Screen.Cursor := crHourglass;
  try
    if zGlob.ConfirmState = 1 then
    begin
      lst := invoiceList_Unconfirmed();
      try
        zGlob.Invoicelist := CreateSQLInText(lst);
      finally
        freeandnil(lst);
      end;
    end
  finally
    Screen.Cursor := crDefault;
  end;

  // 2

  debug_s := 'use home100_xhj;';
  Screen.Cursor := crHourglass;
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
    s := s + '  AND  ((il.ItemID <> ' + _db(zGlob.RoomRentItem) + ' )  '#10;
    s := s + '  AND  (il.ItemID <> ' + _db(zGlob.DiscountItem) + ' )  '#10;
    s := s + '  AND  (il.ItemID <> ' + _db(zGlob.TaxesItem) + ' ))  '#10;

    s := s + ' GROUP BY '#10;
    s := s + '     il.ItemID '#10;
    s := s + '   , it.Description '#10;
    s := s + '   , it.Itemtype '#10;
    s := s + '   , ity.Description '#10;
    s := s + '   , ity.VATCode '#10;
    s := s + '   , vat.VATPercentage ;'#10;

    debug_s := debug_s + #10#10'-- 0 d.kbmTurnover_. '#10 + s;

    // copyToClipboard(s);
    // DebugMessage('-- 0 Turnower '#10+s);
    ExecutionPlan.AddQuery(s);

    // 2
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

    debug_s := debug_s + #10#10'-- 1 d.kbmPayments_. '#10 + s;
    // copyToClipboard(s);
    // DebugMessage('-- 1 '#10+s);
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

    s := s + '  , ROUND((IF(tax.TAX_BASE=' + _db('GUEST_NIGHT') + ' '#10;
    s := s + '      ,IF(tax.TAX_TYPE=' + _db('PERCENTAGE') + ', '#10;
    s := s + '            rd.roomrate*cr.AValue*(SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation)* '#10;
    s := s + '                 IF(tax.NETTO_AMOUNT_BASED=' + _db('TRUE') +
      ', tax.AMOUNT/(1+vc.VatPercentage/100), tax.AMOUNT) / 100, '#10;
    s := s + '            (SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation)*tax.AMOUNT) '#10;
    s := s + '      ,IF(tax.TAX_TYPE=' + _db('PERCENTAGE') + ', '#10;
    s := s + '            rd.roomrate*cr.AValue*IF(tax.NETTO_AMOUNT_BASED=' + _db('TRUE') +
      ', tax.AMOUNT/(1+vc.VatPercentage/100), tax.AMOUNT) / 100, '#10;
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
    s := s + '    LEFT JOIN home100.TAXES tax ON HOTEL_ID=(Select companyID from control LIMIT 1) AND CURRENT_DATE>=VALID_FROM AND CURRENT_DATE<=VALID_TO '#10;

    s := s + ' WHERE '#10;
    s := s + ' ( confirmDate = ' + _db(sUnconfirmedDate) + ' ) ';
    s := s + ' AND ((((rd.resflag IN (' + _db('G') + ',' + _db('D') + ')))  '#10;
    s := s + ' AND (date(rd.ADate) <=  CURDATE())) OR (rd.invoicenumber > 0)) '#10;
    s := s + ' AND (ResFlag not in (' + _db('X') + ',' + _db('C') + ')) ;';

    debug_s := debug_s + #10#10'-- 2 d.kbmRoomsDate_. '#10 + s;
    // copyToClipboard(s);
    // DebugMessage('-- 2 '#10+s);
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

    // *2 finna total �tfr�
    //

    s := s + '   , (SELECT stayTaxIncluted FROM customers WHERE customer = ih.customer) AS isTaxIncluted '#10;
    s := s + '  , IF(il.ItemId=co.StayTaxItem, il.Total, 0) AS TotalStayTax '#10;
    s := s + ' FROM '#10;
    s := s + '   invoicelines il INNER JOIN '#10;
    s := s + '   items it ON il.ItemID = it.Item INNER JOIN '#10;
    s := s + '   invoiceheads ih ON il.invoicenumber = ih.invoicenumber INNER JOIN '#10;
    s := s + '   itemtypes ity ON it.Itemtype = ity.Itemtype INNER JOIN '#10;
    s := s + '   vatcodes vat ON ity.VATCode = vat.VATCode, '#10;
    s := s + '   control co '#10;
    s := s + ' WHERE '#10;
    s := s + '( confirmDate = ' + _db(sUnconfirmedDate) + ' ) ';
    s := s + '  AND  ((il.ItemID = ' + _db(zGlob.RoomRentItem) + ' )  '#10;
    s := s + '  OR   (il.ItemID = ' + _db(zGlob.DiscountItem) + ' )  '#10;
    s := s + '  OR   (il.ItemID = ' + _db(zGlob.TaxesItem) + ' )) '#10;
    s := s + '  AND  (il.invoicenumber > 0)  ;'#10;

    // rset4,Results[3],d.kbmRoomRentOnInvoice_
    debug_s := debug_s + #10#10'-- 3 d.kbmRoomRentOnInvoice_. '#10 + s;
    // copyToClipboard(s);
    // DebugMessage('-- 3 Getting items in invoicelines is roomrent and invoiced'#10#10+s);
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
    if zGlob.Invoicelist <> '' then
    begin
      s := s + '   (ih.InvoiceNumber IN ' + zGlob.Invoicelist + ') ' + #10;
    end
    else
    begin
      s := s + '   (ih.InvoiceNumber = -888) ' + #10;
    end;
    s := s + ' ORDER BY ' + #10;
    s := s + '   ih.InvoiceNumber ;' + #10;

    debug_s := debug_s + #10#10'-- 4 d.mInvoiceHeads. '#10 + s;

    // rset5,Results[4]d.mInvoiceHeads
    // copyToClipboard(s);
    // DebugMessage('-- 4 Invoiceheads'#10#10+s);
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
    if zGlob.Invoicelist <> '' then
    begin
      s := s + '   (il.InvoiceNumber IN ' + zGlob.Invoicelist + ') ' + #10;
    end
    else
    begin
      s := s + '   (il.InvoiceNumber = -888) ;' + #10;
    end;

    // rset6,Results[5],d.mInvoiceLines
    debug_s := debug_s + #10#10'-- 5 d.mInvoiceLines. '#10 + s;
    // copyToClipboard(s);
    // DebugMessage('-- 5 invoicelines '#10#10+s);
    ExecutionPlan.AddQuery(s);

    s := '';
    s := s + ' SELECT id from control ;' + #10;

    // rset7,Results[6],kbmRoomsDateInvoiced_
    // copyToClipboard(s);
    // DebugMessage('Getting all unpaid roomrent'#10#10+s);
    ExecutionPlan.AddQuery(s);

    s := '';
    s := s + ' SELECT '#10;
    s := s + '     il.ID '#10;
    s := s + '   , il.Reservation '#10;
    s := s + '   , il.Roomreservation '#10;
    s := s + '   , (SELECT Room FROM roomreservations WHERE RoomReservation=il.Roomreservation LIMIT 1) AS Room '#10;
    s := s + '   , (SELECT Staff FROM invoiceheads WHERE InvoiceNumber=il.InvoiceNumber LIMIT 1) AS Staff '#10;
    s := s + '   , CAST((SELECT IF(InvoiceNumber>0, InvoiceNumber, ' + quotedStr('-1') +
      ') FROM invoiceheads WHERE InvoiceNumber=il.InvoiceNumber LIMIT 1) AS CHAR(10)) AS InvoiceNumber '#10;
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
    s := s + '  AND  ((il.ItemID <> ' + _db(zGlob.RoomRentItem) + ' )  '#10;
    s := s + '  AND  (il.ItemID <> ' + _db(zGlob.DiscountItem) + ' )  '#10;
    s := s + '  AND  (il.ItemID <> ' + _db(zGlob.TaxesItem) + ' ))  ;'#10;

    debug_s := debug_s +
      #10#10'-- 7 DReportData.kbmUnconfirmedInvoicelines_. Getting items in invoicelines that is not roomrent'#10 + s;
    // rset8,Results[7],DReportData.kbmUnconfirmedInvoicelines_
    // copyToClipboard(s);
    // DebugMessage('-- 6 Getting items in invoicelines that is not roomrent'#10#10+s);
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
    s := s + '  AND  ((il.ItemID <> ' + _db(zGlob.RoomRentItem) + ' )  '#10;
    s := s + '  AND  (il.ItemID <> ' + _db(zGlob.DiscountItem) + ' )  '#10;
    s := s + '  AND  (il.ItemID <> ' + _db(zGlob.TaxesItem) + ' ))  '#10;
    s := s + '  AND  ((il.Total-il.confirmAmount) <> 0)  ;'#10;

    // rset9,Results[8],d.kbmInvoiceLinePriceChange_
    debug_s := debug_s +
      #10#10'-- 8 d.kbmInvoiceLinePriceChange_. Getting items in invoicelines that is not roomrent'#10 + s;
    // copyToClipboard(s);
    // DebugMessage('-- 7 Getting items in invoicelines that is not roomrent'#10#10+s);
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

    s := s + '  , ROUND((IF(tax.TAX_BASE=' + _db('GUEST_NIGHT') + ' '#10;
    s := s + '      ,IF(tax.TAX_TYPE=' + _db('PERCENTAGE') + ', '#10;
    s := s + '            rd.roomrate*cr.AValue*(SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation)* '#10;
    s := s + '                 IF(tax.NETTO_AMOUNT_BASED=' + _db('TRUE') +
      ', tax.AMOUNT/(1+vc.VatPercentage/100), tax.AMOUNT) / 100, '#10;
    s := s + '            (SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation)*tax.AMOUNT) '#10;
    s := s + '      ,IF(tax.TAX_TYPE=' + _db('PERCENTAGE') + ', '#10;
    s := s + '            rd.roomrate*cr.AValue*IF(tax.NETTO_AMOUNT_BASED=' + _db('TRUE') +
      ', tax.AMOUNT/(1+vc.VatPercentage/100), tax.AMOUNT) / 100, '#10;
    s := s + '            tax.AMOUNT) '#10;
    s := s + '    ))/tax.ROUND_VALUE)*tax.ROUND_VALUE AS TotalStayTax '#10;

    s := s + '  , (ROUND((IF(tax.TAX_BASE=' + _db('GUEST_NIGHT') + ' '#10;
    s := s + '      ,IF(tax.TAX_TYPE=' + _db('PERCENTAGE') + ', '#10;
    s := s + '            rd.roomrate*cr.AValue*(SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation)* '#10;
    s := s + '                 IF(tax.NETTO_AMOUNT_BASED=' + _db('TRUE') +
      ', tax.AMOUNT/(1+vc.VatPercentage/100), tax.AMOUNT) / 100, '#10;
    s := s + '            (SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation)*tax.AMOUNT) '#10;
    s := s + '      ,IF(tax.TAX_TYPE=' + _db('PERCENTAGE') + ', '#10;
    s := s + '            rd.roomrate*cr.AValue*IF(tax.NETTO_AMOUNT_BASED=' + _db('TRUE') +
      ', tax.AMOUNT/(1+vc.VatPercentage/100), tax.AMOUNT) / 100, '#10;
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
    s := s + '   LEFT JOIN home100.TAXES tax ON HOTEL_ID=(Select companyID from control LIMIT 1) AND CURRENT_DATE>=VALID_FROM AND CURRENT_DATE<=VALID_TO '#10;
    s := s + ' WHERE '#10;
    s := s + ' ( confirmDate > ' + _db(sUnconfirmedDate) + ' ) ';
    s := s + ' AND ( '#10;
    s := s + '  (rd.confirmAmount-(rd.roomrate*cr.AValue) <> 0) '#10;

    s := s + '  OR (ROUND((ROUND((IF(tax.TAX_BASE=' + _db('GUEST_NIGHT') + ' '#10;
    s := s + '      ,IF(tax.TAX_TYPE=' + _db('PERCENTAGE') + ', '#10;
    s := s + '            rd.roomrate*cr.AValue*(SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation)* '#10;
    s := s + '                 IF(tax.NETTO_AMOUNT_BASED=' + _db('TRUE') +
      ', tax.AMOUNT/(1+vc.VatPercentage/100), tax.AMOUNT) / 100, '#10;
    s := s + '            (SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation)*tax.AMOUNT) '#10;
    s := s + '      ,IF(tax.TAX_TYPE=' + _db('PERCENTAGE') + ', '#10;
    s := s + '            rd.roomrate*cr.AValue*IF(tax.NETTO_AMOUNT_BASED=' + _db('TRUE') +
      ', tax.AMOUNT/(1+vc.VatPercentage/100), tax.AMOUNT) / 100, '#10;
    s := s + '            tax.AMOUNT) '#10;
    s := s + '    ))/tax.ROUND_VALUE)*tax.ROUND_VALUE)-rd.confirmTax) <> 0) '#10;

    s := s + ' OR (rd.confirmDiscount-(IF(rd.isPercentage, rd.RoomRate*rd.Discount/100, rd.Discount)*cr.avalue) <> 0) '#10;

    s := s + '    ) '#10;
    s := s + '  AND (rd.paid=0)  '#10;
    s := s + ' AND (ResFlag not in (' + _db('X') + ',' + _db('C') + ')) ;';

    // rset10,Results[9],d.kbmRoomsDateChange_
    debug_s := debug_s + #10#10'-- 9 d.kbmRoomsDateChange_. Getting confirmed uninvoiced rent change'#10 + s;

    // copyToClipboard(s);
    // DebugMessage('-- 8 Getting confirmed uninvoiced rent change '#10#10+s);
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

    s := s + '  , ROUND((IF(tax.TAX_BASE=' + _db('GUEST_NIGHT') + ' '#10;
    s := s + '      ,IF(tax.TAX_TYPE=' + _db('PERCENTAGE') + ', '#10;
    s := s + '            rd.roomrate*cr.AValue*(SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation)* '#10;
    s := s + '                 IF(tax.NETTO_AMOUNT_BASED=' + _db('TRUE') +
      ', tax.AMOUNT/(1+vc.VatPercentage/100), tax.AMOUNT) / 100, '#10;
    s := s + '            (SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation)*tax.AMOUNT) '#10;
    s := s + '      ,IF(tax.TAX_TYPE=' + _db('PERCENTAGE') + ', '#10;
    s := s + '            rd.roomrate*cr.AValue*IF(tax.NETTO_AMOUNT_BASED=' + _db('TRUE') +
      ', tax.AMOUNT/(1+vc.VatPercentage/100), tax.AMOUNT) / 100, '#10;
    s := s + '            tax.AMOUNT) '#10;
    s := s + '    ))/tax.ROUND_VALUE)*tax.ROUND_VALUE AS TotalStayTax '#10;

    s := s + '  , (ROUND((IF(tax.TAX_BASE=' + _db('GUEST_NIGHT') + ' '#10;
    s := s + '      ,IF(tax.TAX_TYPE=' + _db('PERCENTAGE') + ', '#10;
    s := s + '            rd.roomrate*cr.AValue*(SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation)* '#10;
    s := s + '                 IF(tax.NETTO_AMOUNT_BASED=' + _db('TRUE') +
      ', tax.AMOUNT/(1+vc.VatPercentage/100), tax.AMOUNT) / 100, '#10;
    s := s + '            (SELECT count(id) FROM persons WHERE roomreservation = rd.roomreservation)*tax.AMOUNT) '#10;
    s := s + '      ,IF(tax.TAX_TYPE=' + _db('PERCENTAGE') + ', '#10;
    s := s + '            rd.roomrate*cr.AValue*IF(tax.NETTO_AMOUNT_BASED=' + _db('TRUE') +
      ', tax.AMOUNT/(1+vc.VatPercentage/100), tax.AMOUNT) / 100, '#10;
    s := s + '            tax.AMOUNT) '#10;
    s := s + '    ))/tax.ROUND_VALUE)*tax.ROUND_VALUE)-rd.confirmTax AS TaxChange '#10;

    s := s + ' , (rd.roomrate*cr.AValue)-rd.confirmAmount AS RentChange '#10;

    s := s + ' FROM '#10;

    s := s + '   roomsdate rd '#10;
    s := s + '   LEFT OUTER JOIN reservations rv ON rd.reservation = rv.reservation '#10;
    s := s + '   INNER JOIN currencies cr ON rd.currency = cr.currency, '#10;
    s := s + '   control co '#10;
    s := s + '   INNER JOIN items i ON item=co.RoomRentItem '#10;
    s := s + '   INNER JOIN itemtypes it ON it.ItemType=i.ItemType '#10;
    s := s + '   INNER JOIN vatcodes vc ON vc.VATCode=it.VatCode '#10;
    s := s + '   LEFT JOIN home100.TAXES tax ON HOTEL_ID=(Select companyID from control LIMIT 1) AND CURRENT_DATE>=VALID_FROM AND CURRENT_DATE<=VALID_TO '#10;
    s := s + ' WHERE '#10;
    s := s + ' ( confirmDate > ' + _db(sUnconfirmedDate) + ' )  '#10;
    s := s + ' AND ( ResFlag in (' + _db('X') + ',' + _db('C') + ')) ';
    s := s + ' AND ((rd.confirmAmount+rd.confirmDiscount+rd.confirmTax) <> 0 )'#10;
    s := s + '  ;'#10;

    debug_s := debug_s + #10#10'-- 10 d.kbmRoomsDateChange_. Adding to roomsdateGhange'#10 + s;
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
    s := s + '   ,IF(pm.typeindex=0,' + _db('Invoice') + ',' + _db('Downpayment') + ') AS Medhod '#10;
    // s := s + '   ,IF(pm.typeindex=0,'Invoice','Downpayment') AS Medhod '#10;
    s := s + '  FROM payments pm '#10;
    s := s + '        INNER JOIN paytypes pty ON pm.paytype = pty.paytype '#10;
    s := s + '        INNER JOIN paygroups pgr ON pty.paygroup = pgr.paygroup '#10;
    s := s + '   WHERE '#10;
    s := s + '( confirmDate = ' + _db(sUnconfirmedDate) + ') '#10;
    // s := s + '     ( confirmDate = '2014-05-03 14:05:31') '#10;
    s := s + '    ORDER BY '#10;
    s := s + '      pm.payDate ;'#10;

    debug_s := debug_s + #10#10'-- 11 d.kbmPaymentList_. List of payments'#10 + s;
    copytoclipboard(debug_s);
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
    d.kbmPaymentList_.DisableControls;
    try
      ExecutionPlan.Execute(ptQuery);

      /// ///////////////// Turnover

      rset1 := ExecutionPlan.Results[0];
      if d.kbmTurnover_.Active then
        d.kbmTurnover_.Close;
      d.kbmTurnover_.Open;
      // kbmTurnover_.LoadFromDataSet(rset1,[]);
      LoadKbmMemtableFromDataSetQuiet(kbmTurnover_, rset1, []);
      d.kbmTurnover_.First;

      // //////////////////// Payments
      rset2 := ExecutionPlan.Results[1];
      if d.kbmPayments_.Active then
        d.kbmPayments_.Close;
      d.kbmPayments_.Open;
      // kbmPayments_.LoadFromDataSet(rset2,[]);
      LoadKbmMemtableFromDataSetQuiet(kbmPayments_, rset2, []);
      d.kbmPayments_.First;

      rset3 := ExecutionPlan.Results[2];
      if d.kbmRoomsDate_.Active then
        d.kbmRoomsDate_.Close;
      d.kbmRoomsDate_.Open;
      // kbmRoomsDate_.LoadFromDataSet(rset3,[]);
      LoadKbmMemtableFromDataSetQuiet(kbmRoomsDate_, rset3, []);
      d.kbmRoomsDate_.First;

      rset4 := ExecutionPlan.Results[3];
      if d.kbmRoomRentOnInvoice_.Active then
        d.kbmRoomRentOnInvoice_.Close;
      d.kbmRoomRentOnInvoice_.Open;
      // kbmRoomRentOnInvoice_.LoadFromDataSet(rset4,[]);
      LoadKbmMemtableFromDataSetQuiet(kbmRoomRentOnInvoice_, rset4, []);
      d.kbmRoomRentOnInvoice_.First;

      rset5 := ExecutionPlan.Results[4];
      if d.mInvoiceHeads.Active then
        d.mInvoiceHeads.Close;
      d.mInvoiceHeads.Open;
      // mInvoiceHeads.LoadFromDataSet(rset5,[]);
      LoadKbmMemtableFromDataSetQuiet(mInvoiceHeads, rset5, []);
      d.mInvoiceHeads.First;

      rset6 := ExecutionPlan.Results[5];
      if d.mInvoiceLines.Active then
        d.mInvoiceLines.Close;
      d.mInvoiceLines.Open;
      // mInvoiceLines.LoadFromDataSet(rset6,[]);
      LoadKbmMemtableFromDataSetQuiet(mInvoiceLines, rset6, []);
      d.mInvoiceLines.First;

      rset8 := ExecutionPlan.Results[7];
      if DReportData.kbmUnconfirmedInvoicelines_.Active then
        DReportData.kbmUnconfirmedInvoicelines_.Close;

      DReportData.kbmUnconfirmedInvoicelines_.Open;
      LoadKbmMemtableFromDataSetQuiet(DReportData.kbmUnconfirmedInvoicelines_, rset8, []);
      DReportData.kbmUnconfirmedInvoicelines_.First;

      rset9 := ExecutionPlan.Results[8];
      if d.kbmInvoiceLinePriceChange_.Active then
        d.kbmInvoiceLinePriceChange_.Close;
      d.kbmInvoiceLinePriceChange_.Open;
      LoadKbmMemtableFromDataSetQuiet(kbmInvoiceLinePriceChange_, rset9, []);
      d.kbmInvoiceLinePriceChange_.First;

      rset10 := ExecutionPlan.Results[9];
      if d.kbmRoomsDateChange_.Active then
        d.kbmRoomsDateChange_.Close;
      d.kbmRoomsDateChange_.Open;

      LoadKbmMemtableFromDataSetQuiet(kbmRoomsDateChange_, rset10, []);
      d.kbmRoomsDateChange_.First;

      rSet11 := ExecutionPlan.Results[10];
      rSet11.First;
      while not rSet11.eof do
      begin
        d.kbmRoomsDateChange_.Insert;
        d.kbmRoomsDateChange_.FieldByName('StayDate').asDateTime := rSet11.FieldByName('StayDate').asDateTime;
        d.kbmRoomsDateChange_.FieldByName('roomreservation').AsInteger := rSet11.FieldByName('roomreservation')
          .AsInteger;
        d.kbmRoomsDateChange_.FieldByName('reservation').AsInteger := rSet11.FieldByName('reservation').AsInteger;
        d.kbmRoomsDateChange_.FieldByName('RentAmount').asFloat := 0.00;
        d.kbmRoomsDateChange_.FieldByName('currency').Asstring := rSet11.FieldByName('currency').Asstring;
        d.kbmRoomsDateChange_.FieldByName('currencyRate').asFloat :=
          rSet11.GetFloatValue(rSet11.FieldByName('currencyRate'));
        d.kbmRoomsDateChange_.FieldByName('DiscountAmount').asFloat := 0.00;
        d.kbmRoomsDateChange_.FieldByName('TotalStayTax').asFloat := 0.00;
        d.kbmRoomsDateChange_.FieldByName('roomsdateID').AsInteger := rSet11.FieldByName('roomsdateID').AsInteger;
        d.kbmRoomsDateChange_.FieldByName('invoicenumber').AsInteger := rSet11.FieldByName('invoicenumber').AsInteger;
        d.kbmRoomsDateChange_.FieldByName('discountChange').asFloat :=
          rSet11.GetFloatValue(rSet11.FieldByName('DiscountAmount')) * -1;

        d.kbmRoomsDateChange_.FieldByName('taxChange').asFloat :=
          rSet11.GetFloatValue(rSet11.FieldByName('TotalStayTax')) * -1;
        d.kbmRoomsDateChange_.FieldByName('isTaxIncluted').asBoolean := False;

        d.kbmRoomsDateChange_.FieldByName('rentChange').asFloat :=
          rSet11.GetFloatValue(rSet11.FieldByName('RentAmount')) * -1;
        d.kbmRoomsDateChange_.post;
        rSet11.next;
      end;

      rSet12 := ExecutionPlan.Results[11];
      if d.kbmPaymentList_.Active then
        d.kbmPaymentList_.Close;
      d.kbmPaymentList_.Open;
      // kbmPaymentList_.LoadFromDataSet(rset12,[]);
      LoadKbmMemtableFromDataSetQuiet(kbmPaymentList_, rSet12, []);
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
      d.kbmPaymentList_.enableControls;
    end;

    // *2
    d.TurnoverAndPaymentsUpdateTurnover_II(zGlob);

    // *2
    d.TurnoverAndPaymentsUpdateTurnoverItemPriceChange_II(zGlob);

    zGlob.totalTurnover := 0;
    d.kbmTurnover_.First;
    while not d.kbmTurnover_.eof do
    begin
      zGlob.totalTurnover := zGlob.totalTurnover + d.kbmTurnover_.FieldByName('amount').asFloat;
      d.kbmTurnover_.next;
    end;
    d.kbmTurnover_.First;

    zGlob.TotalPayments := 0;
    d.kbmPayments_.First;
    while not d.kbmPayments_.eof do
    begin
      zGlob.TotalPayments := zGlob.TotalPayments + d.kbmPayments_.FieldByName('amount').asFloat;
      d.kbmPayments_.next;
    end;
    d.kbmPayments_.First;

  finally
    ExecutionPlan.Free;
    Screen.Cursor := crDefault;
  end;
  // pg001.ApplyBestFit;
end;

procedure Td.TurnoverAndPaymentsUpdateTurnover_II(var zGlob: recTurnoverAndPaymentsGlobals_II);
var

  rentAmount: Double;
  rentVat: Double;
  rentItemCount: Double; // -96

  DiscountAmount: Double;
  discountVat: Double;
  discountItemCount: Double; // -96

  cityTaxAmount: Double;
  cityTaxVat: Double;
  cityTaxItemCount: Double; // -96

  incl_cityTaxAmount: Double;
  incl_cityTaxVat: Double;
  incl_cityTaxItemCount: Double; // -96

  Item: string;

  isKredit: boolean;

  InvoiceNumber: Integer;

begin
  rentAmount := 0;
  rentItemCount := 0.00; // -96

  DiscountAmount := 0;
  discountItemCount := 0.00; // -96

  cityTaxAmount := 0;
  cityTaxItemCount := 0.00; // -96

  incl_cityTaxAmount := 0;
  incl_cityTaxItemCount := 0.00; // -96

  d.kbmTurnover_.DisableControls;
  d.kbmPayments_.DisableControls;
  d.kbmRoomsDate_.DisableControls;
  try
    d.kbmRoomsDate_.First;
    while not d.kbmRoomsDate_.eof do
    begin
      InvoiceNumber := d.kbmRoomsDate_.FieldByName('invoicenumber').AsInteger;

      rentAmount := rentAmount + d.kbmRoomsDate_.FieldByName('RentAmount').asFloat;
      if rentAmount <> 0 then
        rentItemCount := rentItemCount + 1;

      DiscountAmount := DiscountAmount + d.kbmRoomsDate_.FieldByName('DiscountAmount').asFloat;
      if DiscountAmount <> 0 then
        discountItemCount := discountItemCount + 1;

      if InvoiceNumber > 0 then
      begin
        cityTaxAmount := cityTaxAmount + d.kbmRoomsDate_.FieldByName('TotalStayTax').asFloat;
        if cityTaxAmount <> 0 then
          cityTaxItemCount := cityTaxItemCount + 1;
      end
      else
      begin
        incl_cityTaxAmount := incl_cityTaxAmount + d.kbmRoomsDate_.FieldByName('TotalStayTax').asFloat;
        if incl_cityTaxAmount <> 0 then
          incl_cityTaxItemCount := incl_cityTaxItemCount + 1
      end;
      d.kbmRoomsDate_.next;
    end;

    rentVat := _calcVat(rentAmount, zGlob.RoomRentVATPercentage);
    discountVat := _calcVat(DiscountAmount, zGlob.RoomRentVATPercentage);
    cityTaxVat := _calcVat(cityTaxAmount, zGlob.cTaxVATPercentage);
    incl_cityTaxVat := _calcVat(incl_cityTaxAmount, zGlob.cTaxVATPercentage);

    if d.kbmRoomsDate_.recordcount > 0 then
    begin
      if rentAmount <> 0 then
      begin
        if d.kbmTurnover_.locate('ItemId', zGlob.RoomRentItem, []) then
        begin
          d.kbmTurnover_.edit;
          d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat + rentAmount;
          d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + rentVat;
          d.kbmTurnover_.FieldByName('Itemcount').asFloat := d.kbmTurnover_.FieldByName('itemcount').asFloat +
            rentItemCount; // -96
          d.kbmTurnover_.post;
        end
        else
        begin
          d.kbmTurnover_.Insert;
          d.kbmTurnover_.FieldByName('ItemId').Asstring := zGlob.RoomRentItem;
          d.kbmTurnover_.FieldByName('Description').Asstring := zGlob.RoomRentItemDescription;
          d.kbmTurnover_.FieldByName('Amount').asFloat := rentAmount;
          d.kbmTurnover_.FieldByName('VAT').asFloat := rentVat;

          d.kbmTurnover_.FieldByName('Itemtype').Asstring := zGlob.RoomRentType;
          d.kbmTurnover_.FieldByName('Typedescription').Asstring := zGlob.RoomRentTypeDescription;
          d.kbmTurnover_.FieldByName('VATCode').Asstring := zGlob.RoomRentVATCode;
          d.kbmTurnover_.FieldByName('ItemCount').asFloat := rentItemCount; // -96
          d.kbmTurnover_.FieldByName('VATPercentage').asFloat := zGlob.RoomRentVATPercentage;
          d.kbmTurnover_.post;
        end;
      end;

      if DiscountAmount <> 0 then
      begin
        if d.kbmTurnover_.locate('ItemId', zGlob.DiscountItem, []) then
        begin
          d.kbmTurnover_.edit;
          d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat +
            DiscountAmount * -1;
          d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + discountVat;
          d.kbmTurnover_.FieldByName('Itemcount').asFloat := d.kbmTurnover_.FieldByName('itemcount').asFloat +
            discountItemCount; // -96
          d.kbmTurnover_.post;
        end
        else
        begin
          d.kbmTurnover_.Insert;
          d.kbmTurnover_.FieldByName('ItemId').Asstring := zGlob.DiscountItem;
          d.kbmTurnover_.FieldByName('Description').Asstring := zGlob.DiscountItemDescription;

          d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat + DiscountAmount;
          d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + discountVat;

          d.kbmTurnover_.FieldByName('Itemtype').Asstring := zGlob.DiscountType;
          d.kbmTurnover_.FieldByName('Typedescription').Asstring := zGlob.DiscountTypeDescription;
          d.kbmTurnover_.FieldByName('VATCode').Asstring := zGlob.RoomRentVATCode;
          d.kbmTurnover_.FieldByName('ItemCount').asFloat := discountItemCount; // -96
          d.kbmTurnover_.FieldByName('VATPercentage').asFloat := zGlob.RoomRentVATPercentage;
          d.kbmTurnover_.post;
        end;
      end;

      if cityTaxAmount <> 0 then
      begin
        if d.kbmTurnover_.locate('ItemId', zGlob.TaxesItem, []) then
        begin
          d.kbmTurnover_.edit;
          d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat + cityTaxAmount;
          d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + cityTaxVat;
          d.kbmTurnover_.FieldByName('Itemcount').asFloat := d.kbmTurnover_.FieldByName('itemcount').asFloat +
            cityTaxItemCount; // -96
          d.kbmTurnover_.post;
        end
        else
        begin
          d.kbmTurnover_.Insert;
          d.kbmTurnover_.FieldByName('ItemId').Asstring := zGlob.TaxesItem;
          d.kbmTurnover_.FieldByName('Description').Asstring := zGlob.TaxesItemDescription;

          d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat + cityTaxAmount;
          d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + cityTaxVat;

          d.kbmTurnover_.FieldByName('Itemtype').Asstring := zGlob.cTaxType;
          d.kbmTurnover_.FieldByName('Typedescription').Asstring := zGlob.cTaxTypeDescription;
          d.kbmTurnover_.FieldByName('VATCode').Asstring := zGlob.cTaxVATCode;
          d.kbmTurnover_.FieldByName('ItemCount').asFloat := cityTaxItemCount; // -96
          d.kbmTurnover_.FieldByName('VATPercentage').asFloat := zGlob.cTaxVATPercentage;
          d.kbmTurnover_.post;
        end;
      end;

      if incl_cityTaxAmount <> 0 then
      begin
        if d.kbmTurnover_.locate('ItemId', '-', []) then
        begin
          d.kbmTurnover_.edit;
          d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat +
            incl_cityTaxAmount;
          d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + incl_cityTaxVat;
          d.kbmTurnover_.FieldByName('Itemcount').asFloat := d.kbmTurnover_.FieldByName('itemcount').asFloat +
            incl_cityTaxItemCount; // -96
          d.kbmTurnover_.post;
        end
        else
        begin
          d.kbmTurnover_.Insert;
          d.kbmTurnover_.FieldByName('ItemId').Asstring := '-';
          d.kbmTurnover_.FieldByName('Description').Asstring := 'uninvoiced ' + zGlob.TaxesItemDescription;

          d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat +
            incl_cityTaxAmount;
          d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + incl_cityTaxVat;

          d.kbmTurnover_.FieldByName('Itemtype').Asstring := zGlob.cTaxType;
          d.kbmTurnover_.FieldByName('Typedescription').Asstring := zGlob.cTaxTypeDescription;
          d.kbmTurnover_.FieldByName('VATCode').Asstring := zGlob.cTaxVATCode;
          d.kbmTurnover_.FieldByName('ItemCount').asFloat := incl_cityTaxItemCount; // -96
          d.kbmTurnover_.FieldByName('VATPercentage').asFloat := zGlob.cTaxVATPercentage;
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

    DiscountAmount := 0;
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
        if d.kbmRoomsDateChange_.FieldByName('RentChange').asFloat <> 0 then
        begin
          rentAmount := rentAmount + d.kbmRoomsDateChange_.FieldByName('RentChange').asFloat;
          if rentAmount <> 0 then
            rentItemCount := rentItemCount + 1;
        end;

        if d.kbmRoomsDateChange_.FieldByName('DiscountChange').asFloat <> 0 then
        begin
          DiscountAmount := DiscountAmount + d.kbmRoomsDateChange_.FieldByName('DiscountChange').asFloat;
          if DiscountAmount <> 0 then
            discountItemCount := discountItemCount + 1;
        end;

        if d.kbmRoomsDateChange_.FieldByName('TaxChange').asFloat <> 0 then
        begin
          if d.kbmRoomsDateChange_.FieldByName('invoicenumber').AsInteger < 0 then
          begin
            incl_cityTaxAmount := incl_cityTaxAmount + d.kbmRoomsDateChange_.FieldByName('TaxChange').asFloat;
            if incl_cityTaxAmount <> 0 then
              incl_cityTaxItemCount := incl_cityTaxItemCount + 1;
          end
          else
          begin
            cityTaxAmount := cityTaxAmount + d.kbmRoomsDateChange_.FieldByName('TaxChange').asFloat;
            if cityTaxAmount <> 0 then
              cityTaxItemCount := cityTaxItemCount + 1
          end;
        end;
        d.kbmRoomsDateChange_.next;
      end;

      rentVat := _calcVat(rentAmount, zGlob.RoomRentVATPercentage);
      discountVat := _calcVat(DiscountAmount, zGlob.RoomRentVATPercentage);
      cityTaxVat := _calcVat(cityTaxAmount, zGlob.cTaxVATPercentage);
      incl_cityTaxVat := _calcVat(incl_cityTaxAmount, zGlob.cTaxVATPercentage);

      if d.kbmRoomsDateChange_.recordcount > 0 then
      begin
        if rentAmount <> 0 then
        begin
          if d.kbmTurnover_.locate('ItemId', zGlob.RoomRentItem, []) then
          begin
            d.kbmTurnover_.edit;
            d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat + rentAmount;
            d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + rentVat;
            d.kbmTurnover_.FieldByName('Itemcount').asFloat := d.kbmTurnover_.FieldByName('itemcount').asFloat +
              rentItemCount; // -96
            d.kbmTurnover_.post;
          end
          else
          begin
            d.kbmTurnover_.Insert;
            d.kbmTurnover_.FieldByName('ItemId').Asstring := zGlob.RoomRentItem;
            d.kbmTurnover_.FieldByName('Description').Asstring := zGlob.RoomRentItemDescription;
            d.kbmTurnover_.FieldByName('Amount').asFloat := rentAmount;
            d.kbmTurnover_.FieldByName('VAT').asFloat := rentVat;

            d.kbmTurnover_.FieldByName('Itemtype').Asstring := zGlob.RoomRentType;
            d.kbmTurnover_.FieldByName('Typedescription').Asstring := zGlob.RoomRentTypeDescription;
            d.kbmTurnover_.FieldByName('VATCode').Asstring := zGlob.RoomRentVATCode;
            d.kbmTurnover_.FieldByName('ItemCount').asFloat := rentItemCount; // -96
            d.kbmTurnover_.FieldByName('VATPercentage').asFloat := zGlob.RoomRentVATPercentage;
            d.kbmTurnover_.post;
          end;
        end;

        if DiscountAmount <> 0 then
        begin
          if d.kbmTurnover_.locate('ItemId', zGlob.DiscountItem, []) then
          begin
            d.kbmTurnover_.edit;
            d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat +
              DiscountAmount * -1;
            d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + discountVat;
            d.kbmTurnover_.FieldByName('Itemcount').asFloat := d.kbmTurnover_.FieldByName('itemcount').asFloat +
              discountItemCount; // -96
            d.kbmTurnover_.post;
          end
          else
          begin
            d.kbmTurnover_.Insert;
            d.kbmTurnover_.FieldByName('ItemId').Asstring := zGlob.DiscountItem;
            d.kbmTurnover_.FieldByName('Description').Asstring := zGlob.DiscountItemDescription;

            d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat +
              DiscountAmount;
            d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + discountVat;

            d.kbmTurnover_.FieldByName('Itemtype').Asstring := zGlob.DiscountType;
            d.kbmTurnover_.FieldByName('Typedescription').Asstring := zGlob.DiscountTypeDescription;
            d.kbmTurnover_.FieldByName('VATCode').Asstring := zGlob.RoomRentVATCode;
            d.kbmTurnover_.FieldByName('ItemCount').asFloat := discountItemCount; // -96
            d.kbmTurnover_.FieldByName('VATPercentage').asFloat := zGlob.RoomRentVATPercentage;
            d.kbmTurnover_.post;
          end;
        end;

        if cityTaxAmount <> 0 then
        begin
          if d.kbmTurnover_.locate('ItemId', zGlob.TaxesItem, []) then
          begin
            d.kbmTurnover_.edit;
            d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat +
              cityTaxAmount;
            d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + cityTaxVat;
            d.kbmTurnover_.FieldByName('Itemcount').asFloat := d.kbmTurnover_.FieldByName('itemcount').asFloat +
              cityTaxItemCount; // -96
            d.kbmTurnover_.post;
          end
          else
          begin
            d.kbmTurnover_.Insert;
            d.kbmTurnover_.FieldByName('ItemId').Asstring := zGlob.TaxesItem;
            d.kbmTurnover_.FieldByName('Description').Asstring := zGlob.TaxesItemDescription;

            d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat +
              cityTaxAmount;
            d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + cityTaxVat;

            d.kbmTurnover_.FieldByName('Itemtype').Asstring := zGlob.cTaxType;
            d.kbmTurnover_.FieldByName('Typedescription').Asstring := zGlob.cTaxTypeDescription;
            d.kbmTurnover_.FieldByName('VATCode').Asstring := zGlob.cTaxVATCode;
            d.kbmTurnover_.FieldByName('ItemCount').asFloat := cityTaxItemCount; // -96
            d.kbmTurnover_.FieldByName('VATPercentage').asFloat := zGlob.cTaxVATPercentage;
            d.kbmTurnover_.post;
          end;
        end;

        if incl_cityTaxAmount <> 0 then
        begin
          if d.kbmTurnover_.locate('ItemId', '-', []) then
          begin
            d.kbmTurnover_.edit;
            d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat +
              incl_cityTaxAmount;
            d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + incl_cityTaxVat;
            d.kbmTurnover_.FieldByName('Itemcount').asFloat := d.kbmTurnover_.FieldByName('itemcount').asFloat +
              incl_cityTaxItemCount; // -96
            d.kbmTurnover_.post;
          end
          else
          begin
            d.kbmTurnover_.Insert;
            d.kbmTurnover_.FieldByName('ItemId').Asstring := '-';
            d.kbmTurnover_.FieldByName('Description').Asstring := 'Uninvoiced ' + zGlob.TaxesItemDescription;
            d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat +
              incl_cityTaxAmount;
            d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + incl_cityTaxVat;

            d.kbmTurnover_.FieldByName('Itemtype').Asstring := zGlob.cTaxType;
            d.kbmTurnover_.FieldByName('Typedescription').Asstring := zGlob.cTaxTypeDescription;
            d.kbmTurnover_.FieldByName('VATCode').Asstring := zGlob.cTaxVATCode;
            d.kbmTurnover_.FieldByName('ItemCount').asFloat := incl_cityTaxItemCount; // -96
            d.kbmTurnover_.FieldByName('VATPercentage').asFloat := zGlob.cTaxVATPercentage;
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

  DiscountAmount := 0;
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
      Item := d.kbmRoomRentOnInvoice_.FieldByName('itemID').Asstring;
      isKredit := d.kbmRoomRentOnInvoice_.FieldByName('splitNumber').AsInteger = 1;

      if isKredit then
      begin
        if _trimlower(Item) = _trimlower(zGlob.RoomRentItem) then
        begin
          rentAmount := rentAmount + d.kbmRoomRentOnInvoice_.FieldByName('Amount').asFloat;
          rentVat := rentVat + d.kbmRoomRentOnInvoice_.FieldByName('VAT').asFloat;;
          rentItemCount := rentItemCount + d.kbmRoomRentOnInvoice_.FieldByName('ItemCount').asFloat; // -96
        end;

        if _trimlower(Item) = _trimlower(zGlob.DiscountItem) then
        begin
          DiscountAmount := DiscountAmount + d.kbmRoomRentOnInvoice_.FieldByName('Amount').asFloat;
          discountVat := discountVat + d.kbmRoomRentOnInvoice_.FieldByName('VAT').asFloat;;
          discountItemCount := discountItemCount + d.kbmRoomRentOnInvoice_.FieldByName('ItemCount').asFloat; // -96
        end;

        if _trimlower(Item) = _trimlower(zGlob.TaxesItem) then
        begin
          cityTaxAmount := cityTaxAmount + d.kbmRoomRentOnInvoice_.FieldByName('Amount').asFloat;
          cityTaxVat := cityTaxVat + d.kbmRoomRentOnInvoice_.FieldByName('VAT').asFloat;
          cityTaxItemCount := cityTaxItemCount + d.kbmRoomRentOnInvoice_.FieldByName('ItemCount').asFloat; // -96
        end;

      end;
      d.kbmRoomRentOnInvoice_.next;
    end;
  end;

  if d.kbmRoomRentOnInvoice_.recordcount > 0 then
  begin
    if rentAmount <> 0 then
    begin
      if d.kbmTurnover_.locate('ItemId', zGlob.RoomRentItem, []) then
      begin
        d.kbmTurnover_.edit;
        d.kbmTurnover_.FieldByName('Amount').asFloat :=
          d.kbmTurnover_.FieldByName('Amount').asFloat + rentAmount;
        d.kbmTurnover_.FieldByName('VAT').asFloat :=
          d.kbmTurnover_.FieldByName('Vat').asFloat + rentVat;
        d.kbmTurnover_.FieldByName('Itemcount').asFloat := d.kbmTurnover_.FieldByName('itemcount').asFloat +
          rentItemCount; // -96
        d.kbmTurnover_.post;
      end
      else
      begin
        d.kbmTurnover_.Insert;
        d.kbmTurnover_.FieldByName('ItemId').Asstring := zGlob.RoomRentItem;
        d.kbmTurnover_.FieldByName('Description').Asstring := zGlob.RoomRentItemDescription;
        d.kbmTurnover_.FieldByName('Amount').asFloat := rentAmount;
        d.kbmTurnover_.FieldByName('VAT').asFloat := rentVat;

        d.kbmTurnover_.FieldByName('Itemtype').Asstring := zGlob.RoomRentType;
        d.kbmTurnover_.FieldByName('Typedescription').Asstring := zGlob.RoomRentTypeDescription;
        d.kbmTurnover_.FieldByName('VATCode').Asstring := zGlob.RoomRentVATCode;
        d.kbmTurnover_.FieldByName('ItemCount').asFloat := rentItemCount; // -96
        d.kbmTurnover_.FieldByName('VATPercentage').asFloat := zGlob.RoomRentVATPercentage;

        d.kbmTurnover_.post;
      end;
    end;

    if DiscountAmount <> 0 then
    begin
      if d.kbmTurnover_.locate('ItemId', zGlob.DiscountItem, []) then
      begin
        d.kbmTurnover_.edit;
        d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat +
          DiscountAmount * -1;
        d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + discountVat;
        d.kbmTurnover_.FieldByName('Itemcount').asFloat := d.kbmTurnover_.FieldByName('itemcount').asFloat +
          discountItemCount; // -96
        d.kbmTurnover_.post;
      end
      else
      begin
        d.kbmTurnover_.Insert;
        d.kbmTurnover_.FieldByName('ItemId').Asstring := zGlob.DiscountItem;
        d.kbmTurnover_.FieldByName('Description').Asstring := zGlob.DiscountItemDescription;

        d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat + DiscountAmount;
        d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + discountVat;

        d.kbmTurnover_.FieldByName('Itemtype').Asstring := zGlob.DiscountType;
        d.kbmTurnover_.FieldByName('Typedescription').Asstring := zGlob.DiscountTypeDescription;
        d.kbmTurnover_.FieldByName('VATCode').Asstring := zGlob.RoomRentVATCode;
        d.kbmTurnover_.FieldByName('ItemCount').asFloat := discountItemCount; // -96
        d.kbmTurnover_.FieldByName('VATPercentage').asFloat := zGlob.RoomRentVATPercentage;
        d.kbmTurnover_.post;
      end;
    end;

    if cityTaxAmount <> 0 then
    begin
      if d.kbmTurnover_.locate('ItemId', zGlob.TaxesItem, []) then
      begin
        d.kbmTurnover_.edit;
        d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat + cityTaxAmount;
        d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + cityTaxVat;
        d.kbmTurnover_.FieldByName('Itemcount').asFloat := d.kbmTurnover_.FieldByName('itemcount').asFloat +
          cityTaxItemCount; // -96
        d.kbmTurnover_.post;
      end
      else
      begin
        d.kbmTurnover_.Insert;
        d.kbmTurnover_.FieldByName('ItemId').Asstring := zGlob.TaxesItem;
        d.kbmTurnover_.FieldByName('Description').Asstring := zGlob.TaxesItemDescription;

        d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat + cityTaxAmount;
        d.kbmTurnover_.FieldByName('VAT').asFloat :=
          d.kbmTurnover_.FieldByName('Vat').asFloat + cityTaxVat;

        d.kbmTurnover_.FieldByName('Itemtype').Asstring := zGlob.cTaxType;
        d.kbmTurnover_.FieldByName('Typedescription').Asstring := zGlob.cTaxTypeDescription;
        d.kbmTurnover_.FieldByName('VATCode').Asstring := zGlob.cTaxVATCode;
        d.kbmTurnover_.FieldByName('ItemCount').asFloat := cityTaxItemCount; // -96
        d.kbmTurnover_.FieldByName('VATPercentage').asFloat := zGlob.cTaxVATPercentage;
        d.kbmTurnover_.post;
      end;
    end;

  end;
end;

procedure Td.TurnoverAndPaymentsUpdateTurnoverItemPriceChange_II(var rec: recTurnoverAndPaymentsGlobals_II);
var

  Amount: Double;
  Vat: Double;
  ItemCount: Double;

  Item: string;
begin

  if d.kbmInvoiceLinePriceChange_.recordcount = 0 then
    exit;

  d.kbmTurnover_.DisableControls;
  d.kbmInvoiceLinePriceChange_.DisableControls;
  try
    d.kbmInvoiceLinePriceChange_.First;
    while not d.kbmInvoiceLinePriceChange_.eof do
    begin
      Item := d.kbmInvoiceLinePriceChange_.FieldByName('itemID').Asstring;
      Amount := d.kbmInvoiceLinePriceChange_.FieldByName('Pricechange').asFloat;
      Vat := d.kbmInvoiceLinePriceChange_.FieldByName('Vat').asFloat;
      ItemCount := d.kbmInvoiceLinePriceChange_.FieldByName('ItemCount').asFloat; // -96

      if d.kbmTurnover_.locate('ItemId', Item, []) then
      begin
        d.kbmTurnover_.edit;
        d.kbmTurnover_.FieldByName('Amount').asFloat := d.kbmTurnover_.FieldByName('Amount').asFloat + Amount;
        d.kbmTurnover_.FieldByName('VAT').asFloat := d.kbmTurnover_.FieldByName('Vat').asFloat + Vat;
        d.kbmTurnover_.FieldByName('Itemcount').asFloat := d.kbmTurnover_.FieldByName('itemcount').AsInteger +
          ItemCount; // -96
        d.kbmTurnover_.post;;
      end
      else
      begin
        d.kbmTurnover_.Insert;
        d.kbmTurnover_.FieldByName('ItemId').Asstring := Item;
        d.kbmTurnover_.FieldByName('Amount').asFloat := Amount;
        d.kbmTurnover_.FieldByName('VAT').asFloat := Vat;
        d.kbmTurnover_.FieldByName('ItemCount').asFloat := ItemCount; // -96

        d.kbmTurnover_.FieldByName('Description').Asstring := d.kbmInvoiceLinePriceChange_.FieldByName
          ('Description').Asstring;
        d.kbmTurnover_.FieldByName('Itemtype').Asstring := d.kbmInvoiceLinePriceChange_.FieldByName('Itemtype')
          .Asstring;
        d.kbmTurnover_.FieldByName('Typedescription').Asstring := d.kbmInvoiceLinePriceChange_.FieldByName
          ('Typedescription').Asstring;
        d.kbmTurnover_.FieldByName('VATCode').Asstring := d.kbmInvoiceLinePriceChange_.FieldByName('VATCode').Asstring;
        d.kbmTurnover_.FieldByName('VATPercentage').asFloat := d.kbmInvoiceLinePriceChange_.FieldByName
          ('VATPercentage').asFloat;
        d.kbmTurnover_.post;
      end;
      d.kbmInvoiceLinePriceChange_.next;
    end;
  finally
    d.kbmInvoiceLinePriceChange_.enableControls;
    d.kbmTurnover_.enableControls;
  end;
end;

procedure Td.TurnoverAndPaymentsDoConfirm_II;
var
  rSet: TRoomerDataSet;
  s: string;
  iCount: Integer;
  ok: boolean;
  Amount: Double;
  Discount: Double;
  Tax: Double;
  Id: Integer;
  CurrencyRate: Double;

  confirmDate: TdateTime;
  dataType: Integer;
  Item: string;
  Description: string;
  Staff: string;
  Itemtype: string;
  ItemTypeDescription: string;
  itemNotes: string;
  VATCode: string;
  VATPercentage: Double;
  Vat: Double;
  ItemCount: Double;

  StayDate: TdateTime;
  RoomReservation: Integer;
  reservation: Integer;
  rentAmount: Double;
  Currency: string;
  isTaxIncluted: boolean;
  DiscountAmount: Double;
  TotalStayTax: Double;
  roomsdateID: Integer;
  InvoiceNumber: Integer;
  discountChange: Double;
  taxChange: Double;
  rentChange: Double;
  ItemID: string;
  TypeDescription: string;
  ivlID: Integer;
  PurchaseDate: TdateTime;
  confirmAmount: Double;
  PriceChange: Double;
  InvoiceLineID: Integer;
  Room: string;
  zConfirmedDate: TdateTime;

begin

  Screen.Cursor := crHourglass;
  try

    zConfirmedDate := now;
    ok := True;

    d.kbmRoomsDate_.DisableControls;
    try
      d.kbmRoomsDate_.First;

      while not d.kbmRoomsDate_.eof do
      begin
        Id := d.kbmRoomsDate_.FieldByName('id').AsInteger;
        Amount := d.kbmRoomsDate_.FieldByName('RentAmount').asFloat;
        Discount := d.kbmRoomsDate_.FieldByName('discountAmount').asFloat;
        Tax := d.kbmRoomsDate_.FieldByName('TotalStayTax').asFloat;
        CurrencyRate := d.kbmRoomsDate_.FieldByName('currencyRate').asFloat;

        s := '';
        s := s + ' UPDATE roomsdate ';
        s := s + ' SET ';
        s := s + '    ConfirmDate = ' + _dbDateAndTime(zConfirmedDate) + ' '#10;
        s := s + '   ,ConfirmAmount = ' + _db(Amount) + ' '#10;
        s := s + '   ,ConfirmDiscount = ' + _db(Discount) + ' '#10;
        s := s + '   ,ConfirmTax = ' + _db(Tax) + ' '#10;
        s := s + '   ,ConfirmCurrencyRate = ' + _db(CurrencyRate) + ' '#10;
        s := s + ' WHERE ' + #10;
        s := s + '   (id = ' + _db(Id) + ') ' + #10;
        if not cmd_bySQL(s) then
        begin
          ok := False;
        end;
        d.kbmRoomsDate_.next;
      end;
    finally
      d.kbmRoomsDate_.enableControls;
    end;

    d.kbmRoomsDateChange_.DisableControls;
    try
      d.kbmRoomsDateChange_.First;

      while not d.kbmRoomsDateChange_.eof do
      begin
        Id := d.kbmRoomsDateChange_.FieldByName('RoomsdateID').AsInteger;
        Amount := d.kbmRoomsDateChange_.FieldByName('RentChange').asFloat;
        Discount := d.kbmRoomsDateChange_.FieldByName('discountChange').asFloat;
        Tax := d.kbmRoomsDateChange_.FieldByName('TaxChange').asFloat;

        s := '';
        s := s + ' SELECT '#10;
        s := s + '  confirmAmount '#10;
        s := s + ' ,confirmDiscount '#10;
        s := s + ' ,confirmTax '#10;
        s := s + ' ,ResFlag '#10;
        s := s + ' FROM '#10;
        s := s + ' RoomsDate '#10;
        s := s + ' WHERE '#10;
        s := s + ' id=' + _db(Id) + ' '#10;

        rSet := CreateNewDataSet;
        try
          rSet_bySQL(rSet, s);
          if not rSet.eof then
          begin
            if (rSet.FieldByName('ResFlag').Asstring = STATUS_DELETED) or
              (rSet.FieldByName('ResFlag').Asstring = STATUS_CANCELED) then
            begin
              Amount := 0.00;
              Discount := 0.00;
              Tax := 0.00;
            end
            else
            begin
              Amount := Amount + rSet.FieldByName('confirmAmount').asFloat;
              Discount := Discount + rSet.FieldByName('confirmDiscount').asFloat;
              Tax := Tax + rSet.FieldByName('confirmTax').asFloat;
            end;
          end;
        finally
          freeandnil(rSet);
        end;

        s := '';
        s := s + ' UPDATE roomsdate ';
        s := s + ' SET ';
        s := s + '    ConfirmAmount = ' + _db(Amount) + ' '#10;
        s := s + '   ,ConfirmDiscount = ' + _db(Discount) + ' '#10;
        s := s + '   ,ConfirmTax = ' + _db(Tax) + ' '#10;
        s := s + ' WHERE ' + #10;
        s := s + '   (id = ' + _db(Id) + ') ' + #10;

        if not cmd_bySQL(s) then
        begin
          ok := False;
        end;
        d.kbmRoomsDateChange_.next;
      end;
    finally
      d.kbmRoomsDateChange_.enableControls;
    end;

    DReportData.kbmUnconfirmedInvoicelines_.DisableControls;
    try
      DReportData.kbmUnconfirmedInvoicelines_.First;
      while not DReportData.kbmUnconfirmedInvoicelines_.eof do
      begin
        Id := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('id').AsInteger;
        Amount := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('Amount').asFloat;
        // nfirmAmount := d.kbmInvoiceLinePriceChange_.FieldByName('confirmAmount').AsFloat;
        s := '';
        s := s + ' UPDATE invoicelines ';
        s := s + ' SET ';
        s := s + '    ConfirmDate = ' + _dbDateAndTime(zConfirmedDate) + ' '#10;
        s := s + '   ,ConfirmAmount = ' + _db(Amount) + ' '#10;
        s := s + ' WHERE ' + #10;
        s := s + '   (id = ' + _db(Id) + ') ' + #10;
        if not cmd_bySQL(s) then
        begin
          ok := False;
        end;
        DReportData.kbmUnconfirmedInvoicelines_.next;
      end;
    finally
      DReportData.kbmUnconfirmedInvoicelines_.enableControls;
    end;

    d.kbmInvoiceLinePriceChange_.DisableControls;
    try
      d.kbmInvoiceLinePriceChange_.First;
      while not d.kbmInvoiceLinePriceChange_.eof do
      begin
        Id := d.kbmInvoiceLinePriceChange_.FieldByName('ivlid').AsInteger;
        Amount := d.kbmInvoiceLinePriceChange_.FieldByName('Amount').asFloat;

        s := '';
        s := s + ' UPDATE invoicelines ';
        s := s + ' SET ';
        // s := s + '    ConfirmDate = '+_dbDateAndTime(confirmdate)+' '#10;
        s := s + '   ConfirmAmount = ' + _db(Amount) + ' '#10;
        s := s + ' WHERE ' + #10;
        s := s + '   (id = ' + _db(Id) + ') ' + #10;
        if not cmd_bySQL(s) then
        begin
          ok := False;
        end;
        d.kbmInvoiceLinePriceChange_.next;
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
      ok := False;
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
      ok := False;
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
      ok := False;
    end;

    d.kbmTurnover_.First;
    while not d.kbmTurnover_.eof do
    begin
      dataType := 1;
      confirmDate := zConfirmedDate;
      Item := d.kbmTurnover_.FieldByName('itemID').Asstring;
      Description := d.kbmTurnover_.FieldByName('Description').Asstring;
      Staff := g.qUserName;
      Itemtype := d.kbmTurnover_.FieldByName('itemType').Asstring;
      ItemTypeDescription := d.kbmTurnover_.FieldByName('TypeDescription').Asstring;

      VATCode := d.kbmTurnover_.FieldByName('VATcode').Asstring;
      VATPercentage := d.kbmTurnover_.FieldByName('VATPercentage').asFloat;
      Vat := d.kbmTurnover_.FieldByName('VAT').asFloat;
      ItemCount := d.kbmTurnover_.FieldByName('itemCount').asFloat; // -96
      Amount := d.kbmTurnover_.FieldByName('Amount').asFloat;

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
      s := s + ' ,' + _db(Item) + ' '#10;
      s := s + ' ,' + _db(Description) + ' '#10;
      s := s + ' ,' + _db(Amount) + ' '#10;
      s := s + ' ,' + _db(Staff) + ' '#10;
      s := s + ' ,' + _db(Itemtype) + ' '#10;
      s := s + ' ,' + _db(ItemTypeDescription) + ' '#10;
      s := s + ' ,' + _db(dataType) + ' '#10;
      s := s + ' ,' + _db(VATCode) + ' '#10;
      s := s + ' ,' + _db(VATPercentage) + ' '#10;
      s := s + ' ,' + _db(Vat) + ' '#10;
      s := s + ' ,' + _db(ItemCount) + ' '#10;
      s := s + ' ) '#10;

      if not cmd_bySQL(s) then
      begin
        ok := False;
      end;
      d.kbmTurnover_.next;
    end;

    d.kbmPayments_.First;
    while not d.kbmPayments_.eof do
    begin
      dataType := 2;
      confirmDate := zConfirmedDate;
      Item := d.kbmPayments_.FieldByName('payType').Asstring;
      Description := d.kbmPayments_.FieldByName('paytypeDescription').Asstring;
      Staff := g.qUserName;
      Itemtype := '-';
      ItemTypeDescription := d.kbmPayments_.FieldByName
        ('paygroupDescripion').Asstring;

      VATCode := '';
      VATPercentage := 0;
      Vat := 0;
      ItemCount := d.kbmPayments_.FieldByName('PaymentCount').asFloat; // -96
      Amount := d.kbmPayments_.FieldByName('Amount').asFloat;

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
      s := s + ' ,' + _db(Item) + ' '#10;
      s := s + ' ,' + _db(Description) + ' '#10;
      s := s + ' ,' + _db(Amount) + ' '#10;
      s := s + ' ,' + _db(Staff) + ' '#10;
      s := s + ' ,' + _db(Itemtype) + ' '#10;
      s := s + ' ,' + _db(ItemTypeDescription) + ' '#10;
      s := s + ' ,' + _db(dataType) + ' '#10;
      s := s + ' ,' + _db(VATCode) + ' '#10;
      s := s + ' ,' + _db(VATPercentage) + ' '#10;
      s := s + ' ,' + _db(Vat) + ' '#10;
      s := s + ' ,' + _db(ItemCount) + ' '#10;
      s := s + ' ) '#10;

      if not cmd_bySQL(s) then
      begin
        ok := False;
      end;
      d.kbmPayments_.next;
    end;

    d.kbmInvoiceLinePriceChange_.First;
    while not d.kbmInvoiceLinePriceChange_.eof do
    begin
      ItemID := d.kbmInvoiceLinePriceChange_.FieldByName('ItemID').Asstring;
      Description := d.kbmInvoiceLinePriceChange_.FieldByName('Description').Asstring;
      Itemtype := d.kbmInvoiceLinePriceChange_.FieldByName('Itemtype').Asstring;
      TypeDescription := d.kbmInvoiceLinePriceChange_.FieldByName('TypeDescription').Asstring;
      VATCode := d.kbmInvoiceLinePriceChange_.FieldByName('VATCode').Asstring;
      VATPercentage := d.kbmInvoiceLinePriceChange_.FieldByName('VATPercentage').asFloat;
      Amount := d.kbmInvoiceLinePriceChange_.FieldByName('Amount').asFloat;
      Vat := d.kbmInvoiceLinePriceChange_.FieldByName('VAT').asFloat;
      ItemCount := d.kbmInvoiceLinePriceChange_.FieldByName('Itemcount').asFloat; // -96
      ivlID := d.kbmInvoiceLinePriceChange_.FieldByName('ivlID').AsInteger;
      PurchaseDate := d.kbmInvoiceLinePriceChange_.FieldByName('PurchaseDate').asDateTime;
      reservation := d.kbmInvoiceLinePriceChange_.FieldByName('reservation').AsInteger;
      RoomReservation := d.kbmInvoiceLinePriceChange_.FieldByName('roomReservation').AsInteger;
      confirmAmount := d.kbmInvoiceLinePriceChange_.FieldByName('confirmAmount').asFloat;
      PriceChange := d.kbmInvoiceLinePriceChange_.FieldByName('PriceChange').asFloat;

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
      s := s + ' ,' + _db(Itemtype) + ' '#10;
      s := s + ' ,' + _db(TypeDescription) + ' '#10;
      s := s + ' ,' + _db(VATCode) + ' '#10;
      s := s + ' ,' + _db(VATPercentage) + ' '#10;
      s := s + ' ,' + _db(Amount) + ' '#10;
      s := s + ' ,' + _db(Vat) + ' '#10;
      s := s + ' ,' + _db(ItemCount) + ' '#10;
      s := s + ' ,' + _db(ivlID) + ' '#10;
      s := s + ' ,' + _db(PurchaseDate) + ' '#10;
      s := s + ' ,' + _db(reservation) + ' '#10;
      s := s + ' ,' + _db(RoomReservation) + ' '#10;
      s := s + ' ,' + _db(confirmAmount) + ' '#10;
      s := s + ' ,' + _db(PriceChange) + ' '#10;
      s := s + ' ,' + _dbDateAndTime(zConfirmedDate) + ' '#10;
      s := s + ' ) '#10;

      if not cmd_bySQL(s) then
      begin
        ok := False;
      end;
      d.kbmInvoiceLinePriceChange_.next;
    end;

    d.kbmRoomsDateChange_.First;
    while not d.kbmRoomsDateChange_.eof do
    begin
      StayDate := d.kbmRoomsDateChange_.FieldByName('StayDate').asDateTime;
      RoomReservation := d.kbmRoomsDateChange_.FieldByName('roomreservation').AsInteger;
      reservation := d.kbmRoomsDateChange_.FieldByName('reservation').AsInteger;
      rentAmount := d.kbmRoomsDateChange_.FieldByName('RentAmount').asFloat;
      Currency := d.kbmRoomsDateChange_.FieldByName('currency').Asstring;
      CurrencyRate := d.kbmRoomsDateChange_.FieldByName('currencyRate').asFloat;
      isTaxIncluted := d.kbmRoomsDateChange_.FieldByName('isTaxIncluted').asBoolean;
      DiscountAmount := d.kbmRoomsDateChange_.FieldByName('DiscountAmount').asFloat;
      TotalStayTax := d.kbmRoomsDateChange_.FieldByName('TotalStayTax').asFloat;
      roomsdateID := d.kbmRoomsDateChange_.FieldByName('roomsdateID').AsInteger;
      InvoiceNumber := d.kbmRoomsDateChange_.FieldByName('invoicenumber').AsInteger;
      discountChange := d.kbmRoomsDateChange_.FieldByName('discountChange').asFloat;
      taxChange := d.kbmRoomsDateChange_.FieldByName('taxChange').asFloat;
      rentChange := d.kbmRoomsDateChange_.FieldByName('rentChange').asFloat;
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
      s := s + ' ,' + _db(RoomReservation) + ' '#10;
      s := s + ' ,' + _db(reservation) + ' '#10;
      s := s + ' ,' + _db(rentAmount) + ' '#10;
      s := s + ' ,' + _db(Currency) + ' '#10;
      s := s + ' ,' + _db(CurrencyRate) + ' '#10;
      s := s + ' ,' + _db(isTaxIncluted) + ' '#10;
      s := s + ' ,' + _db(DiscountAmount) + ' '#10;
      s := s + ' ,' + _db(TotalStayTax) + ' '#10;
      s := s + ' ,' + _db(roomsdateID) + ' '#10;
      s := s + ' ,' + _db(InvoiceNumber) + ' '#10;
      s := s + ' ,' + _db(discountChange) + ' '#10;
      s := s + ' ,' + _db(taxChange) + ' '#10;
      s := s + ' ,' + _db(rentChange) + ' '#10;
      s := s + ' ,' + _dbDateAndTime(zConfirmedDate) + ' '#10;
      s := s + ' ) '#10;
      if not cmd_bySQL(s) then
      begin
        ok := False;
      end;
      d.kbmRoomsDateChange_.next;
    end;

    DReportData.kbmUnconfirmedInvoicelines_.First;
    while not DReportData.kbmUnconfirmedInvoicelines_.eof do
    begin
      ItemID := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('ItemId').Asstring;
      Description := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('Description').Asstring;
      Itemtype := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('ItemType').Asstring;
      VATCode := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('VATCode').Asstring;
      VATPercentage := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('VATPercentage').asFloat;
      Amount := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('Amount').asFloat;
      Vat := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('VAT').asFloat;
      ItemCount := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('Itemcount').asFloat;
      InvoiceLineID := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('ID').AsInteger;
      PurchaseDate := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('PurchaseDate').asDateTime;
      reservation := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('reservation').AsInteger;
      RoomReservation := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('roomReservation').AsInteger;
      confirmAmount := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('confirmAmount').asFloat;
      Room := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('Room').Asstring;
      InvoiceNumber := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('InvoiceNumber').AsInteger;

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
      s := s + '  ' + _db(ItemID) + ' '#10;
      s := s + ' ,' + _db(Description) + ' '#10;
      s := s + ' ,' + _db(TypeDescription) + ' '#10;
      s := s + ' ,' + _db(Itemtype) + ' '#10;
      s := s + ' ,' + _db(VATCode) + ' '#10;
      s := s + ' ,' + _db(VATPercentage) + ' '#10;
      s := s + ' ,' + _db(Amount) + ' '#10;
      s := s + ' ,' + _db(Vat) + ' '#10;
      s := s + ' ,' + _db(ItemCount) + ' '#10;
      s := s + ' ,' + _db(InvoiceLineID) + ' '#10;
      s := s + ' ,' + _db(PurchaseDate) + ' '#10;
      s := s + ' ,' + _db(reservation) + ' '#10;
      s := s + ' ,' + _db(RoomReservation) + ' '#10;
      s := s + ' ,' + _db(confirmAmount) + ' '#10;
      s := s + ' ,' + _db(Room) + ' '#10;
      s := s + ' ,' + _db(InvoiceNumber) + ' '#10;
      s := s + ' ,' + _dbDateAndTime(zConfirmedDate) + ' '#10;
      s := s + ' ) '#10;
      copytoclipboard(s);
      if not cmd_bySQL(s) then
      begin
        ok := False;
      end;
      DReportData.kbmUnconfirmedInvoicelines_.next;
    end;

    if ok then
    begin
      g.qLastConfirm := zConfirmedDate;
      // zIsConfirmed := true;
      // zConfirmState := 2;
      // btnConfirm.visible := false;
      // btnGetOld.visible := true;
      // chkGetUnconfirmed.checked := false;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure Td.insertActivityLogFromMemTable;
var
  s: string;
  iReservation, iRoomReservation: Integer;
  iSplitnumber: Integer;
  Item: string;
  Total: Double;
  lineNumber: Integer;
  AutoGen: string;
  bSystemline: boolean;
  i: Integer;

  // TInvoiceAction = (ADD_LINE, DELETE_LINE, CHANGE_ITEM, ADD_PAYMENT, DELETE_PAYMENT, CHANGE_PAYMENT, PRINT_PROFORMA, PAY_AND_PRINT);
  lstActivity: tstringList;

begin
  if (d.mInvoicelines_before.recordcount = 0) and (d.mInvoicelines_after.recordcount = 0) then
    exit;

  lstActivity := tstringList.Create;
  try
    d.mInvoicelines_before.First;
    while not d.mInvoicelines_before.eof do
    begin
      AutoGen := d.mInvoicelines_before.FieldByName('Autogen').Asstring;
      bSystemline := d.mInvoicelines_before.FieldByName('isSystemline').asBoolean;

      iReservation := d.mInvoicelines_before.FieldByName('reservation').AsInteger;
      iRoomReservation := d.mInvoicelines_before.FieldByName('roomreservation').AsInteger;
      iSplitnumber := d.mInvoicelines_before.FieldByName('Splitnumber').AsInteger;
      Item := d.mInvoicelines_before.FieldByName('itemID').Asstring;
      Total := d.mInvoicelines_before.FieldByName('Total').asFloat;
      lineNumber := d.mInvoicelines_before.FieldByName('itemNumber').AsInteger;

      if bSystemline = False then
      begin
        if d.mInvoicelines_after.locate('AutoGen', AutoGen, []) then
        begin
          // not room item
          if d.mInvoicelines_before.FieldByName('Total').asFloat <> d.mInvoicelines_after.FieldByName('Total').asFloat
          then
          begin
            s := CreateInvoiceActivityLog(g.qUser
              , iReservation
              , iRoomReservation
              , iSplitnumber
              , CHANGE_ITEM
              , Item
              , Total
              , lineNumber
              , 'TotalPrice change');

            if s <> '' then
              lstActivity.Add(s);
            s := '';

          end;

        end
        else
        begin
          s := CreateInvoiceActivityLog(g.qUser
            , iReservation
            , iRoomReservation
            , iSplitnumber
            , DELETE_LINE
            , Item
            , Total
            , lineNumber
            , 'Line deleted');
          if s <> '' then
            lstActivity.Add(s);
          s := '';
        end;
      end
      else
      begin
        if d.mInvoicelines_after.locate('Reservation;roomreservation', varArrayOf([iReservation, iRoomReservation]), [])
        then
        begin
          if d.mInvoicelines_before.FieldByName('Total').asFloat <> d.mInvoicelines_after.FieldByName('Total').asFloat
          then
          begin

            CreateInvoiceActivityLog(g.qUser
              , iReservation
              , iRoomReservation
              , iSplitnumber
              , CHANGE_ITEM
              , Item
              , Total
              , lineNumber
              , 'System TotalPrice change');
            if s <> '' then
              lstActivity.Add(s);
            s := '';
          end;
        end
        else
        begin
          CreateInvoiceActivityLog(g.qUser
            , iReservation
            , iRoomReservation
            , iSplitnumber
            , DELETE_LINE
            , Item
            , Total
            , lineNumber
            , 'System Line deleted');
          if s <> '' then
            lstActivity.Add(s);
          s := '';
        end;
      end;

      d.mInvoicelines_before.next;
    end;

    d.mInvoicelines_after.First;
    while not d.mInvoicelines_after.eof do
    begin
      AutoGen := d.mInvoicelines_after.FieldByName('Autogen').Asstring;
      bSystemline := d.mInvoicelines_after.FieldByName('isSystemline').asBoolean;

      iReservation := d.mInvoicelines_after.FieldByName('reservation').AsInteger;
      iRoomReservation := d.mInvoicelines_after.FieldByName('roomreservation').AsInteger;
      iSplitnumber := d.mInvoicelines_after.FieldByName('Splitnumber').AsInteger;
      Item := d.mInvoicelines_after.FieldByName('itemID').Asstring;
      Total := d.mInvoicelines_after.FieldByName('Total').asFloat;
      lineNumber := d.mInvoicelines_after.FieldByName('itemNumber').AsInteger;

      if bSystemline = False then
      begin
        if not d.mInvoicelines_before.locate('AutoGen', AutoGen, []) then
        begin
          // not room item
          s := CreateInvoiceActivityLog(g.qUser
            , iReservation
            , iRoomReservation
            , iSplitnumber
            , ADD_LINE
            , Item
            , Total
            , lineNumber
            , 'Item added ');
          if s <> '' then
            lstActivity.Add(s);
          s := '';

        end;
      end
      else
      begin
        // RoomItem/Taxitem/roomDiscount
      end;
      d.mInvoicelines_after.next;
    end;

    for i := 0 to lstActivity.Count - 1 do
    begin
      try
        if lstActivity[i] <> '' then
          WriteInvoiceActivityLog(lstActivity[i]);
      Except
      end;
    end;
  finally
    freeandnil(lstActivity);
    if d.mInvoicelines_before.Active then
      d.mInvoicelines_before.Close;
    if d.mInvoicelines_after.Active then
      d.mInvoicelines_after.Close;
  end;
end;

{ TRoomPackageLineEntry }

procedure Td.AddOrCreateToPackage(pckTotalsList: TRoomPackageLineEntryList;
  Code: String;
  _Description: string;
  RoomReservation: Integer;
  _Amount,
  _AmountWoVat,
  _VatAmount: Double;
  _isRoom: boolean;
  _packageCode: string;
  _packageDescription: string;
  _lineNo: Integer;
  _adate: Tdate;
  _count: Double
  );
var
  i: Integer;
  tempEntry: TRoomPackageLineEntry;
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

  if NOT assigned(tempEntry) then
  begin
    tempEntry := TRoomPackageLineEntry.Create(Code,
      _Description,
      _Amount,
      _AmountWoVat,
      _VatAmount,
      RoomReservation,
      _isRoom,
      _packageCode,
      _packageDescription,
      _lineNo,
      _adate,
      _count

      );
    pckTotalsList.Add(tempEntry);
  end
  else
    tempEntry.Add(_Amount, _AmountWoVat, _VatAmount, Code, _Description, _count, _adate, _lineNo);
end;

procedure TRoomPackageLineEntry.Add(_Amount, _AmountWoVat, _VatAmount: Double; _Code, _Description: string;
  _count: Double; _adate: Tdate; _lineNo: Integer);
begin
  FAmount := FAmount + _Amount;
  FAmountWoVat := FAmountWoVat + _AmountWoVat;
  FVatAmount := FVatAmount + _VatAmount;
  FCode := _Code;
  if FCode = g.qRoomRentItem then
  begin
    FItemCount := _count;
    FLineNo := _lineNo;
    FaDate := _adate;
    FDescription := _Description;
  end;
end;

constructor TRoomPackageLineEntry.Create(
  _Code: String;
  _Description: string;
  _Amount, _AmountWoVat,
  _VatAmount: Double;
  _RoomReservation: Integer;
  _isRoom: boolean;
  _packageCode: string;
  _packageDescription: string;
  _lineNo: Integer;
  _adate: Tdate;
  _count: Double
  );
begin
  FCode := _Code;
  if FCode = g.qRoomRentItem then
  begin
    FItemCount := _count;
    FLineNo := _lineNo;
    FaDate := _adate;
    FDescription := _Description;
  end;
  FAmount := _Amount;
  FAmountWoVat := _AmountWoVat;
  FVatAmount := _VatAmount;
  FRoomReservation := _RoomReservation;
  FIsRoom := _isRoom;
  FpackageCode := _packageCode;
  FPackageDescription := _packageDescription;
end;

function getRowHeightFromIndex(index: Integer): Integer;
begin
  //
  case index of
    0:
      result := g.qPeriodRowHeight;
    1:
      result := 49;
    2:
      result := 75;
  else
    result := 0;
  end;
end;

initialization

PROFORMA_INVOICE_NUMBER := GenerateProformaInvoiceNumber;

end.
