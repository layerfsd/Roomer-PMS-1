unit uAppGlobal;

interface
uses
    Windows
  , Winapi.ShlObj
  , System.IOUtils
  , Grids
  , Forms
  , Inifiles
  , SysUtils
  , Classes
  , ADODB
  , Data.DB
  ,_glob
  , cmpRoomerDataSet
  , cmpRoomerConnection
  , Vcl.Menus
  , Generics.Collections
  , objDayFreeRooms
  , uMessageList
  , uRoomerLanguage
  , uActivityLogs

  , stdCtrls
  , comCtrls
  , extCtrls
  , uStringUtils

  , sButton
  , sCheckBox
  , sPageControl
  , sTabControl
  , sGroupBox
  , sLabel
  , sPanel
  , sComboBox
  , sSpeedButton

  , cxButtons
  , dxBar
  , cxDropdownEdit
  , cxGridDBTableView
  , cxGridBandedTableView
  , cxGridDBBandedTableView
  , cxDBPivotGrid
  , dxRibbon
  , dxMdaSet
  , cxGrid

  , ppCtrls
  , AdvEdBtn
  , Variants
  , Vcl.Buttons
  , uRoomerThreadedRequest
  , uPMSSettings
  , uTableEntityList
  ;

Type

  RecRRInfo = record
    RoomReservation: integer;
    Reservation: integer;
    Channel: integer;
    Date: Tdate;
    Room: string;
    RoomType: string;
    resFlag: string;
    isNoRoom: boolean;
    AscIndex: integer;
    DescIndex: integer;
    CustomerName: string;
    PaymentInvoice: integer;
    GroupAccount: boolean;
    Percentage: boolean;
    PriceType: String;
    Currency: String;

    Arrival: Tdate;
    Departure: Tdate;
    active: boolean;

    ItemsOnInvoice: boolean;
    numGuests: integer;
    GuestName, Tel1, Tel2, Fax: String;

    Payments, Price, Discount: Double;
    Information, PMInfo: String;
    RoomClass: string;
    BookingId : String;

    OutOfOrderBlocking: boolean;
    BlockMove: boolean;
    BlockMoveReason: String;

    OngoingSale : Double;
    OngoingTaxes : Double;
    OngoingRent : Double;

    Invoices,
    Guarantee : String;

    InvoiceIndex : Integer;
  end;

  TNumberBase = (INB_USER_EDIT,
                 INB_ROOM_NIGHT,
                 INB_GUEST_NIGHT,
                 INB_GUEST,
                 INB_ROOM,
                 INB_BOOKING);

   TRoomTypesHolder = class( TObject )
   private
     FRoomType  : string;
     FCount     : integer;
     FNumGuests : integer;
   public
   end;

   TSet_Of_Integer = class
   private
     list : TList<Integer>;
    function GetCount: integer;
   public
     constructor Create;
     destructor Destroy; override;
     procedure Clear;
     procedure Add(value : Integer);

     function ValueInList(value : Integer) : Boolean;

     property Count : integer read GetCount;
   end;

{$M+}
   TGlobalSettings = class( TObject )
   private

      FRoomTypes      : TList;
      FNumAvailType   : TStringList;
      FRoomFloors     : TList<Integer>;

    tablesList : TTableDictionary;
    FPreviousGuestsSet: TRoomerDataSet;
    FPreviousGuestsReload : TGetThreadedData;
    FPmsSettings: TPmsSettings;

      procedure AddRoomType( sType : string; iNumber, NumGuests : integer );
      procedure Clear;
    procedure ClearRoomFloors;
//    procedure ClearSingleTable(Table: TRoomerDataSet);
    function GetChannelsSet: TRoomerDataSet;
    function GetControlSet: TRoomerDataSet;
    function GetCountries: TRoomerDataSet;
    function GetCountryGroups: TRoomerDataSet;
    function GetCurrenciesSet: TRoomerDataSet;
    function GetItems: TRoomerDataSet;
    function GetItemTypes: TRoomerDataSet;
    function GetLocations: TRoomerDataSet;
    function GetRoomsSet: TRoomerDataSet;
    function GetRoomTypeGroups: TRoomerDataSet;
    function GetChannelPlanCodes: TRoomerDataSet;
    function GetRoomTypeRulesSet: TRoomerDataSet;
    function GetRoomTypesSet: TRoomerDataSet;
    function GetVAT: TRoomerDataSet;
    function GetCustomertypes: TRoomerDataSet;
    function GetPaygroups: TRoomerDataSet;
    function GetPaytypes: TRoomerDataSet;
    function GetTblconvertgroups: TRoomerDataSet;
    function GetTblconverts: TRoomerDataSet;
    function GetTblpricecodes: TRoomerDataSet;
    function GetTblseasons: TRoomerDataSet;
    function GetCustomersSet: TRoomerDataSet;
    procedure AssertComponent(Comp: TComponent);
    function ValidateHelpContext(ctx: Integer): Boolean;
//    Function ValidateHelpContext2(ctx : Integer) : Boolean;
    function GetPackages: TRoomerDataSet;
    function GetPackageItems: TRoomerDataSet;
    function GetPersonProfiles: TRoomerDataSet;
    function GetBookKeepingCodes: TRoomerDataSet;
    function GetChannelManagersSet: TRoomerDataSet;
    procedure PreviousGuestsReloadFetchHandler(Sender: TObject);

    function GetPmsSettingsSet: TRoomerDataSet;

    function GetMaintenanceCodes: TRoomerDataSet;
    function GetMaintenanceRoomNotes: TRoomerDataSet;
    function GetStaffMembers: TRoomerDataset;

   public
      constructor Create;
      destructor Destroy; override;

      procedure LogChanges(DataSet: TDataSet; tableName : String; action: TTableAction; descriptor: String);
      function locateId(rSet : TDataset; id : Integer) : Boolean;
      procedure FillRoomAndTypeGrid(agrRooms : TStringGrid;
                                    Location : TSet_Of_Integer;
                                    Floor : TSet_Of_Integer;
                                    FreeRoomsFiltered : Boolean  = false;
                                    oFreeRooms : TFreeRooms = nil;
                                    zOneDay_dtDate : TDateTime = 0;
                                    numDays : integer = 0);

      procedure ReloadPreviousGuests;
      procedure ForceTableRefresh;
      procedure RefreshTableByName(const aTable: string);
      function KeyAlreadyExistsInAnotherRecord(table, field, value: String; ID: Integer): Boolean;
      function LocateSpecificRecord(table, field, value: String): Boolean; overload;
      function LocateSpecificRecord(dataSet : TRoomerDataSet; field : String;  value : Variant) : Boolean; overload; inline;
      function LocateSpecificRecord(table, field: String; value: Integer): Boolean; overload;
      function LocateSpecificRecord(table, field: String; value: Boolean): Boolean; overload;
      function LocateSpecificRecordAndGetValue(table, field, value: String; fieldToGet : String; var resultingValue : String): Boolean; overload;
      function LocateSpecificRecordAndGetValue(table, field : String; value : Integer; fieldToGet: String; var resultingValue: String): Boolean; overload;
      function LocateSpecificRecordAndGetValue(table, field, value: String; fieldToGet : String; var resultingValue : Integer): Boolean; overload;
      function LocateSpecificRecordAndGetValue(table, field, value: String; fieldToGet : String; var resultingValue : Boolean): Boolean; overload;
      function LocateSpecificRecordAndGetValue(table, field, value: String; fieldToGet : String; var resultingValue : Double): Boolean; overload;
      function LocateSpecificRecordAndGetValue(table, field : String; value : Integer; fieldToGet: String; var resultingValue: Double): Boolean; overload;

      function IsValidInList(list: TSet_Of_Integer; intValue : Integer): Boolean;

      procedure LoadStaticTables(startingUp : Boolean = False);
      procedure RefreshTablesWhenNeeded;
      procedure FillRoomAndTypeGridNew(agrRooms : TStringGrid );
      procedure FillLocationsMenu(mnu : TPopupMenu; event : TNotifyEvent);

      function GetRoomLocation(Room: String): String;
      function LocateRoom(Room : String) : Boolean;
      function LocateCountryGroup(CountryGroup: String): Boolean;
      function LocateLocation(Location: String): Boolean;
      function GetRoomStatistics(Room : String) : Boolean;
      function GetRoomFloor(Room: String): Integer;
      function GetRoomTypeFromRoom(Room: String): String;
      function GetLocationId(Location: String): integer;
      function GetNumberOfItems( aType : string ) : integer;
      function GetRoomTypeNumberGuests( aType : string ) : integer;
      function GetRoomTypeNumberGuestsTotal( aType : string ) : integer;
      function GetRoomType( iIndex : integer ) : string;
      function GetNumberBaseOfItem( item : string ) : TNumberBase;
      function GetCountryName(Country : String) : String;
      function RoomTypeCount : integer;
      function LocateCountry(Country : String) : Boolean;
      function LocateItemType(ItemType : String) : Boolean;
      function LocateRoomType(RoomType : String) : Boolean;
      function LocateCurrency(Currency: String): Boolean;
      function LocateChannelById(id : Integer): Boolean;
      function LocateChannelColorById(id : Integer): Integer;
      function LocateRoomTypeColor(RoomType: String): Integer;
      function LocateRoomTypeGroup(RoomTypeGroup : String) : Boolean;
      function LocateRoomTypeGroupById(RoomTypeGroupId: Integer): Boolean;
      function GetRoomTypeGroupDescription(Code: String): String;
      function GetRoomTypeDescription(RoomType : String) : String;
      function GET_RoomTypeNumberGuests_byRoom(Room : String) : integer;
      function GET_RoomTypeNumberGuests_byRoomType(RoomType: String): integer;

      function GetDataCacheLocation : String;
      function GetOfflineReportLocation: string;
      function GetLanguageLocation: String;

      property RoomTypes[ aType : string ] : integer read GetNumberOfItems;
      property RoomTypesNumGuests[ aType : string ] : integer read GetRoomTypeNumberGuests;
      property RoomTypesNumGuestsTotal[ aType : string ] : integer read GetRoomTypeNumberGuestsTotal;

      procedure InitAvailability;

      procedure PerformAuthenticationAssertion(Form : TForm);
      function AccessAllowed(value : Integer) : boolean;

      procedure EnableOrDisableTableRefresh(tablename : String; enable: Boolean);

      function LocationSQLInString(locationlist : TSet_Of_Integer) : string;

      function getPackageNameByPackageCode(packageCode : String) : String;

      procedure fillListWithMonthsLong(List : TStrings; fromIndex : Integer);
      procedure fillListWithMonthsShort(List: TStrings; fromIndex : Integer);
      procedure fillListWithYears(List : TStrings; FromIndex : Integer; ForwardOnly : Boolean);
      procedure LoadCurrentRecordFromDataSet(ToSet, DataSet: TDataSet; _AppendRecord: Boolean);

      function GetRateInclusive(channelId: Integer; Item : String; Rate: Double): Double;
      function GetRateExclusive(Item : String; Rate : Double) : Double;

      function isCustomerCityTaxIncluded(Customer : String) : Boolean;
      function GetIntegerValueOfFieldFromId(tableName : String; fieldName : String; id: Integer): Integer;
      function GetBooleanValueOfFieldFromId(tableName : String; fieldName : String; id: Integer): boolean;

      property PMSSettings: TPmsSettings read FPmsSettings;

   published
      property PreviousGuestsSet : TRoomerDataSet read FPreviousGuestsSet;
      property RoomsSet        : TRoomerDataSet read GetRoomsSet;
      property RoomTypeRulesSet: TRoomerDataSet read GetRoomTypeRulesSet;
      property RoomTypesSet    : TRoomerDataSet read GetRoomTypesSet;
      property ChannelsSet     : TRoomerDataSet read GetChannelsSet;
      property ChannelManagersSet : TRoomerDataSet read GetChannelManagersSet;
      property CurrenciesSet   : TRoomerDataSet read GetCurrenciesSet;
      property ControlSet      : TRoomerDataSet read GetControlSet;
      property CustomersSet    : TRoomerDataSet read GetCustomersSet;
      property RoomTypeGroups  : TRoomerDataSet read GetRoomTypeGroups;
      property ChannelPlanCodes: TRoomerDataSet read GetChannelPlanCodes;
      property Items           : TRoomerDataSet read GetItems;
      property ItemTypes       : TRoomerDataSet read GetItemTypes;
      property CountryGroups   : TRoomerDataSet read GetCountryGroups;
      property Locations       : TRoomerDataSet read GetLocations;
      property Countries       : TRoomerDataSet read GetCountries;
      property VAT             : TRoomerDataSet read GetVAT;
      property Packages        : TRoomerDataSet read GetPackages;
      property PackageItems    : TRoomerDataSet read GetPackageItems;
      property PersonProfiles  : TRoomerDataSet read GetPersonProfiles;
      property BookKeepingCodes  : TRoomerDataSet read GetBookKeepingCodes;
      property TblconvertsSet      : TRoomerDataSet read GetTblconverts;
      property TblconvertgroupsSet : TRoomerDataSet read GetTblconvertgroups;
      property PaygroupsSet        : TRoomerDataSet read GetPaygroups;
      property PaytypesSet         : TRoomerDataSet read GetPaytypes;
      property TblseasonsSet       : TRoomerDataSet read GetTblseasons;
      property TblpricecodesSet    : TRoomerDataSet read GetTblpricecodes;
      property CustomertypesSet    : TRoomerDataSet read GetCustomertypes;
      property MaintenanceCodes     : TRoomerDataSet read GetMaintenanceCodes;
      property Maintenanceroomnotes : TRoomerDataSet read GetMaintenanceRoomNotes;
      property Staffmembers         : TRoomerDataset read GetStaffMembers;

      property NumAvailType    : TStringList read FNumAvailType      write FNumAvailType;

   end;

var
  glb        : TGlobalSettings = nil;
  AppInifile : string;
  RoomerLanguage : TRoomerLanguage;


const
  FMHandle : THandle = 0;

  RIGHTS_REPORTS_FINANCE = 94;
  RIGHTS_REPORTS_GUESTS = 80;
  RIGHTS_INVOICE = 88;
  RIGHTS_BASE_TABLES = 90;
  RIGHTS_PRICES = 90;
  RIGHTS_BOOKINGS = 90;

  cOfflinefoldername = 'offlinereports';
  cDatacachefoldername = 'datacache';

procedure OpenAppSettings;
procedure CloseAppSettings;
procedure FilterRoom( RoomNumber : string );

implementation

uses   dbTables
     , Registry
     , dialogs
     , uSqlDefinitions
     , hData
     , ud
     , ug
     , uUtils
     , PrjConst
      , uFileSystemUtils;

procedure FilterRoom( RoomNumber : string );
begin
  with glb.RoomsSet do
  begin
    Filter := 'Room=''' + RoomNumber + '''';
    Filtered := true;
  end;
end;

{
{ TGlobalSettings }

constructor TGlobalSettings.Create;
begin
  tablesList := TTableDictionary.Create([doOwnsValues]);
  tablesList.InitializeTables;

  FRoomFloors := TList<Integer>.Create;

  FRoomTypes    := TList.Create;
  FNumAvailType := TStringlist.create;

  FPMSSettings := TPmsSettings.Create(GetPmsSettingsSet);

  FPreviousGuestsReload := TGetThreadedData.Create;
  FPreviousGuestsSet := nil;
  ReloadPreviousGuests;

  LoadStaticTables(true);

end;

destructor TGlobalSettings.Destroy;
begin
  clear;
  FNumAvailType.free;
  ClearRoomFloors;
  FRoomtypes.Free;
  FRoomFloors.free;
  FPreviousGuestsReload.Free;
  tablesList.Clear;
  FreeAndNil(tablesList);
  FPmsSettings.Free;
end;

procedure TGlobalSettings.LogChanges(DataSet: TDataSet; tableName : String; action : TTableAction; descriptor : String);
var i : Integer;
    Field : TField;
    Value, OldValue : String;
begin
  if action = CHANGE_FIELD then
  begin
    for i := 0 to DataSet.FieldCount - 1 do
    begin
      Field := DataSet.Fields[i];
      if Field.DataType IN [ftUnknown, ftString, ftSmallint, ftInteger, ftWord,
                                        ftBoolean, ftFloat, ftCurrency, ftDate, ftTime, ftDateTime,
                                        ftAutoInc, ftMemo, ftFmtMemo, ftFixedChar, ftWideString,
                                        ftLargeint, ftTimeStamp, ftWideMemo, ftLongWord, ftShortint,
                                        ftByte, ftExtended, ftSingle] then
      begin
        Value := VarToStr(Field.Value);
        OldValue := VarToStr(Field.OldValue);
        if Value <> OldValue then
          AddTableChangeActivityLog(d.roomerMainDataSet.username,
                                    action,
                                    tableName + '.' + field.FieldName,
                                    DataSet['id'],
                                    OldValue,
                                    Value,
                                    '');
      end;
    end;
  end else
  if action = DELETE_RECORD then
  begin
    AddTableChangeActivityLog(d.roomerMainDataSet.username,
                              action,
                              tableName,
                              DataSet['id'],
                              descriptor,
                              '',
                              format('User %s deleted record with id %d, description: %s',
                                     [d.roomerMainDataSet.username,
                                      DataSet['id'],
                                      descriptor]));
  end else
  if action = ADD_RECORD then
  begin
    AddTableChangeActivityLog(d.roomerMainDataSet.username,
                              action,
                              tableName,
                              -1,
                              descriptor,
                              '',
                              format('User %s added record with description: %s',
                                     [d.roomerMainDataSet.username,
                                      descriptor]));
  end;
end;

var PreviousGuestsReload : TGetThreadedData = nil;

procedure TGlobalSettings.ReloadPreviousGuests;
const PREV_GUESTS_SQL = 'SELECT DISTINCT * FROM ' +
                        '( ' +
                        'SELECT CONCAT(''PE'',pe.ID) AS ID, pe.title, pe.PersonalIdentificationId AS PassPortNumber, ' +
                        '       pe.Name, pe.Surname AS CustomerName, pe.Address1, pe.Address2, pe.Address3, pe.Address4, pe.Country, pe.Tel1, pe.Tel2, pe.Email, pe.SocialSecurityNumber, pe.CompVATNumber, pe.CompFax ' +
                        'FROM persons pe JOIN reservations r ON r.Reservation=pe.Reservation AND r.Departure > DATE_ADD(CURRENT_DATE, INTERVAL 365*-3 DAY) ' +
                        'WHERE pe.MainName=1 ' +
                        'AND pe.Surname <> '''' ' +
                        'AND pe.Address1 <> '''' ' +
                        'AND pe.Country <> '''' ' +
                        'AND (pe.Tel1 <> '''' OR pe.Tel2 <> '''' OR pe.Email <> '''') ' +
                        'UNION ALL ' +
                        'SELECT CONCAT(''RV'',ID) AS ID, '''' AS title, '''' AS PassPortNumber, Contactname AS Name, Name AS CustomerName, ContactAddress1, ContactAddress2, ContactAddress3, ContactAddress4, ContactCountry, ContactPhone, ContactPhone2, ContactEmail, '''', '''', ContactFax ' +
                        'FROM reservations ' +
                        'WHERE Contactname <> '''' ' +
                        'AND ContactAddress1 <> '''' ' +
                        'AND ContactCountry <> '''' ' +
                        'AND (ContactPhone <> '''' OR ContactPhone2 <> '''' OR ContactEmail <> '''') ' +
                        'AND Departure > DATE_ADD(CURRENT_DATE, INTERVAL 365*-3 DAY) ' +
                        'UNION ALL ' +
                        'SELECT CONCAT(''CU'',ID) AS ID, title, '''' AS PassPortNumber, Surname AS Name, Surname AS CustomerName, Address1, Address2, Address3, Address4, Country, Tel1, Tel2, EmailAddress, '''', '''', Fax ' +
                        'FROM customers ' +
                        'WHERE Surname <> '''' ' +
                        'AND Address1 <> '''' ' +
                        'AND Country <> '''' ' +
                        'AND (CONCAT(Tel1,Tel2,EmailAddress) <> '''') ' +
                        'ANd active=1 ' +
                        ') xxx ';
begin
  FPreviousGuestsReload.execute(PREV_GUESTS_SQL, PreviousGuestsReloadFetchHandler);
end;

procedure TGlobalSettings.PreviousGuestsReloadFetchHandler(Sender : TObject);
begin
  FPreviousGuestsSet := FPreviousGuestsReload.RoomerDataSet;
  FPreviousGuestsSet.First;
end;

function TGlobalSettings.locateId(rSet : TDataset; id : Integer) : Boolean;
begin
  result := False;
  rSet.First;
  while NOT rSet.Eof do
  begin
    if rSet['ID'] = id then
    begin
      result := True;
      Break;
    end;
    rSet.Next;
  end;
end;

function TGlobalSettings.GetRateInclusive(channelId : Integer; Item : String; Rate : Double) : Double;
begin
  result := Rate;
  if (channelId = -1) AND LocateSpecificRecord('channels', 'default', true) OR
     (channelId <> -1) AND LocateSpecificRecord('channels', 'id', channelId) then
    if GetChannelsSet['ratesExcludingTaxes'] then
      if LocateSpecificRecord('items', 'Item', Item) then
        if LocateSpecificRecord('itemtypes', 'ItemType', GetItems.FieldByName('ItemType').AsString) then
          if LocateSpecificRecord('vatcodes', 'VATCode', GetItemTypes.FieldByName('VATCode').AsString) then
            result := Rate * (1 + (GetVAT.GetFloatValue(getVat.FieldByName('VATPercentage'))/100));
end;

function TGlobalSettings.GetRateExclusive(Item : String; Rate : Double) : Double;
begin
  result := Rate;
  if LocateSpecificRecord('items', 'Item', Item) then
    if LocateSpecificRecord('itemtypes', 'ItemType', GetItems.FieldByName('ItemType').AsString) then
      if LocateSpecificRecord('vatcodes', 'VATCode', GetItemTypes.FieldByName('VATCode').AsString) then
        result := Rate / (1 + (GetVAT.GetFloatValue(getVat.FieldByName('VATPercentage'))/100));
end;

function TGlobalSettings.GetIntegerValueOfFieldFromId(tableName : String; fieldName : String; id : Integer) : Integer;
var dataSet : TRoomerDataSet;
begin
  dataset := tablesList.Dataset[tableName];
  if locateId(dataset, id) then
  begin
    result := dataset[fieldName];
  end else
    result := -1;
end;

function TGlobalSettings.GetBooleanValueOfFieldFromId(tableName : String; fieldName : String; id : Integer) : boolean;
var dataSet : TRoomerDataSet;
begin
  dataset := tablesList.Dataset[tableName];
  if locateId(dataset, id) then
  begin
    result := dataset[fieldName];
  end else
    result := false;
end;

function TGlobalSettings.LocationSQLInString(locationlist : TSet_Of_Integer) : string;
var
  locationID : integer;
  s : string;

begin
  result := '';
  if (locationList.Count = 0) or (locationList.Count = glb.Locations.recordCount) then exit;

  s := '';
  glb.Locations.first;
  while not glb.locations.eof do
  begin
    locationID := glb.Locations.FieldByName('ID').asinteger;
    if LocationList.ValueInList(locationID) then
    begin
      s := s+_db(glb.Locations.FieldByName('location').AsString)+',';
    end;
    glb.Locations.next;
  end;

  if length(s) > 0 then delete(s,length(s),1);
  result := s;
end;


procedure TGlobalSettings.EnableOrDisableTableRefresh(tablename : String; enable: Boolean);
var tableEntity : TTableEntity;
begin
  tableEntity := tablesList[tableName];
  if assigned(tableEntity) then
  begin
    tableEntity.RefreshEnabled := enable;
    if enable then
      tableEntity.RefreshFromServer;
  end;
end;

procedure TGlobalSettings.fillListWithMonthsLong(List: TStrings; fromIndex : Integer);
var i : Integer;
begin
  for i := 1 to 12 do
  begin
    list.Delete(i-1 + fromIndex);
    list.insert(i-1 + fromIndex, GetTranslatedText('shSystem_Months_Long_' + inttostr(i)));
  end;
end;

procedure TGlobalSettings.fillListWithMonthsShort(List: TStrings; fromIndex : Integer);
var i : Integer;
begin
  for i := 1 to 12 do
  begin
    list.Delete(i-1 + fromIndex);
    list.insert(i-1 + fromIndex, GetTranslatedText('shSystem_Months_Short_' + inttostr(i)));
  end;
end;

procedure TGlobalSettings.fillListWithYears(List: TStrings; FromIndex : Integer; ForwardOnly: Boolean);
var i : Integer;
    iStart : Integer;
begin
  iStart := 2010;
  if ForwardOnly then
    iStart := Year(now);

  for i := iStart to Year(Now) + 15 do
  begin
    list.Delete(i-iStart + fromIndex);
    list.Insert(i-iStart + fromIndex, inttostr(i));
  end;
end;

procedure TGlobalSettings.ClearRoomFloors;
begin
  while (FRoomFloors.Count > 0) do
  begin
    FRoomFloors.Delete(0);
  end;
end;


procedure TGlobalSettings.Clear;
var
  i : integer;
begin
  for i := FRoomTypes.count - 1 downto 0 do
  begin
    TRoomTypesHolder(FRoomTypes[i]).free;
    FRoomTypes.delete(i);
  end;
end;


procedure TGlobalSettings.FillLocationsMenu(mnu: TPopupMenu; event : TNotifyEvent);
var item : TMenuItem;
    i : integer;
begin
  mnu.Items.Clear;
  locations.First;
  while NOT locations.Eof do
  begin
    item := TMenuItem.Create(nil);
    item.Caption := format('%s [%s]', [locations['Description'], locations['Location']]);
    item.Tag := locations['Id'] + 1000;
    item.OnClick := event;
    mnu.Items.Add(item);
    locations.Next;
  end;

  item := TMenuItem.Create(nil);
  item.Caption := '-';
  mnu.Items.Add(item);

  for i := 0 to FRoomFloors.Count - 1 do
  begin
    item := TMenuItem.Create(nil);
    item.Caption := format('%s %d', [GetTranslatedText('shTx_Floor'), FRoomFloors[i]]);
    item.Tag := FRoomFloors[i];
    item.OnClick := event;
    mnu.Items.Add(item);
  end;
end;

procedure TGlobalSettings.FillRoomAndTypeGrid(agrRooms : TStringGrid;
                                              Location : TSet_Of_Integer;
                                              Floor : TSet_Of_Integer;
                                              FreeRoomsFiltered : Boolean  = false;
                                              oFreeRooms : TFreeRooms = nil;
                                              zOneDay_dtDate : TDateTime = 0;
                                              numDays : integer = 0);
var l : integer;
    sTemp : String;
    dtdate : TDateTime;
    iNextOcc : integer;
    resultFilter : Boolean;

    FloorFilterActive,
    LocationFilterActive,
    FloorFilterPassed,
    LocationFilterPassed,
    FilterPassed : Boolean;
begin
  // --
  if agrRooms.ColCount < 2 then
      agrRooms.ColCount := 2;

  with roomsSet do
  begin
    first;
    l := 1;
    while not eof do
    begin
      if not RoomsSet['Hidden'] then
      begin
        FloorFilterActive := Floor.Count > 0;
        LocationFilterActive := Location.Count > 0;
        FloorFilterPassed := IsValidInList(Floor, RoomsSet['Floor']);
        LocationFilterPassed := IsValidInList(Location, GetLocationId(RoomsSet['Location']));
        FilterPassed := (NOT FloorFilterActive) OR (FloorFilterPassed AND FloorFilterActive);
        FilterPassed := FilterPassed AND
                        ((NOT LocationFilterActive) OR (LocationFilterPassed AND LocationFilterActive));

        resultFilter := FilterPassed
                        AND (NOT FreeRoomsFiltered);
        if resultFilter then
        begin
          sTemp := oFreeRooms.FindRoomNextOcc(FieldByName( 'Room' ).AsString);
          if sTemp = '' then
          begin
            dtdate := zOneDay_dtDate + 1000;
          end else dtDate := _DBDateToDate(sTemp);
          iNextOcc := trunc(dtDate)-trunc(zOneDay_dtDate);
          resultFilter := iNextOcc >= numDays;
        end;
        if resultFilter then
        begin
          inc(l);
          agrRooms.RowCount :=l;
          agrRooms.Cells[ 0, l - 1 ] := FieldByName( 'Room' ).AsString;
          agrRooms.Cells[ 1, l - 1 ] := FieldByName( 'RoomType' ).AsString;
        end;
      end;
      next;
    end;
  end;
  agrRooms.RowCount := agrRooms.RowCount + 1;
end;

function TGlobalSettings.IsValidInList(list : TSet_Of_Integer; intValue : Integer) : Boolean;
begin
  result := (list.Count = 0) OR (list.ValueInList(intValue));
end;


procedure TGlobalSettings.FillRoomAndTypeGridNew(agrRooms : TStringGrid );
var l : integer;
begin
  // --
  if agrRooms.ColCount < 3 then agrRooms.ColCount := 3;
  with RoomsSet do
  begin
    first;
    l := 1;
    while not eof do
    begin
      if (RoomsSet['Hidden'] = false) and (RoomsSet['bookable'] = true) then
      begin
        inc( l );
        agrRooms.RowCount := l;
        agrRooms.Cells[ 0, l - 1 ] := FieldByName( 'Room' ).AsString;
        agrRooms.Cells[ 1, l - 1 ] := FieldByName( 'Description' ).AsString+' ('+FieldByName( 'location' ).AsString+') ';;
        agrRooms.Cells[ 2, l - 1 ] := FieldByName( 'RoomType' ).AsString;
      end;
      next;
    end;
  end;
end;


procedure TGlobalSettings.RefreshTablesWhenNeeded;
begin
  tablesList.RefreshAllIfNeeded;
end;

procedure TGlobalSettings.ForceTableRefresh;
begin
  RoomerMessages.RefreshTabelStateList;
  tablesList.RefreshAllIfNeeded;
end;

procedure TGlobalSettings.RefreshTableByName(const aTable: string);
begin
  tablesList.TableEntity[aTable].RefreshFromServer;
end;

procedure TGlobalSettings.LoadStaticTables(startingUp : Boolean = False);
var
  rSet: TRoomerDataSet;
  s    : string;
  bTemp : Boolean;
begin

  tableslist.RefreshAllLocally(startingUp);

  if NOT d.roomerMainDataSet.OfflineMode then
  begin
    FRoomFloors.Clear;
    RoomsSet.First;
    while not RoomsSet.eof do
    begin
      if not FRoomFloors.Contains(RoomsSet['Floor']) then
        FRoomFloors.Add(RoomsSet['Floor']);
      RoomsSet.next;
    end;
    FRoomFloors.Sort;

    rSet := CreateNewDataSet;
    try
      rSet.CommandType := cmdText;
      s := format(select_GlobalSettings_LoadStaticTables, []);
      hData.rSet_bySQL(rSet,s);

      rSet.First;
      while not rSet.eof do
      begin
        AddRoomType( rSet.FieldByName( 'RoomType' ).AsString, 1, rSet.FieldByName( 'NumberGuests' ).AsInteger);
        rSet.next;
      end;
    finally
      freeandnil(rSet);
    end;

    RoomTypesSet.First;
    while not RoomTypesSet.eof do
    begin
      if LocateSpecificRecordAndGetValue('rooms', 'RoomType', RoomTypesSet.FieldByName( 'RoomType' ).AsString, 'Bookable', bTemp) AND bTemp then
        AddRoomType( RoomTypesSet.FieldByName( 'RoomType' ).AsString,
                     1,
                     RoomTypesSet.FieldByName( 'NumberGuests' ).AsInteger);
       RoomTypesSet.next;
    end;
  end;
end;

function TGlobalSettings.GetDataCacheLocation: String;
var AppDataPath : String;
    DataCache: String;
begin
  AppDataPath := TPath.Combine(LocalAppDataPath, 'Roomer');
  DataCache := format('%s\' + cDatacachefoldername, [d.roomerMainDataSet.hotelId]);
  result := TPath.Combine(AppDataPath, DataCache);
  forceDirectories(result);
end;

function TGlobalSettings.GetOfflineReportLocation: string;
var AppDataPath : String;
begin
  AppDataPath := TPath.Combine(LocalAppDataPath, 'Roomer');
  result := format('%s\' + cofflinefoldername,[d.roomerMainDataSet.hotelId]);
  result := TPath.Combine(AppDataPath, Result);
  forceDirectories(result);
end;


function TGlobalSettings.GetLanguageLocation: String;
begin
  result := TPath.Combine(LocalAppDataPath, 'Roomer');
  result := TPath.Combine(result, 'Languages');
  forceDirectories(result);
end;

function TGlobalSettings.GetPmsSettingsSet: TRoomerDataSet;
begin
  result := tableslist.Dataset['pms_settings'];
end;

function TGlobalSettings.GetChannelsSet: TRoomerDataSet;
begin
  result := tableslist.Dataset['channels'];
end;

function TGlobalSettings.GetControlSet: TRoomerDataSet;
begin
  result := tableslist.Dataset['control'];
end;

function TGlobalSettings.GetCountries: TRoomerDataSet;
begin
  result := tableslist.Dataset['countries'];
end;

function TGlobalSettings.GetCountryGroups: TRoomerDataSet;
begin
  result := tableslist.Dataset['countrygroups'];
end;

function TGlobalSettings.GetCountryName(Country: String): String;
begin
  result := '';
  if LocateCountry(Country) then
    result := Countries['CountryName'];
end;

function TGlobalSettings.GetCurrenciesSet: TRoomerDataSet;
begin
  result := tableslist.Dataset['currencies'];
end;

function TGlobalSettings.GetCustomersSet: TRoomerDataSet;
begin
  result := tableslist.Dataset['customers'];
end;

function TGlobalSettings.GetCustomertypes: TRoomerDataSet;
begin
  result := tableslist.Dataset['customertypes'];
end;

function TGlobalSettings.GetItems: TRoomerDataSet;
begin
  result := tableslist.Dataset['items'];
end;

function TGlobalSettings.GetItemTypes: TRoomerDataSet;
begin
  result := tableslist.Dataset['itemtypes'];
end;

function TGlobalSettings.GetLocationId(Location : String) : integer;
begin
  result := 0;
  Locations.First;
  while not Locations.eof do
  begin
    if LowerCase(Locations['Location']) = LowerCase(Location) then
    begin
      result := Locations['Id'];
      Break;
    end;
    Locations.next;
  end;
end;

function TGlobalSettings.GetLocations: TRoomerDataSet;
begin
  result := tableslist.Dataset['locations'];
end;

function TGlobalSettings.GetMaintenanceCodes: TRoomerDataSet;
begin
  Result := tablesList.Dataset['maintenancecodes'];
end;

function TGlobalSettings.GetMaintenanceRoomNotes: TRoomerDataSet;
begin
  Result := TablesList.Dataset['maintenanceroomnotes'];
end;

function TGlobalSettings.LocateSpecificRecord(table, field, value : String) : Boolean;
var dataSet : TRoomerDataSet;
begin
  Result := false;
  dataset := tableslist.Dataset[table];
  if assigned(Dataset) then
    result := dataset.Locate(field, value, []);
end;

function TGlobalSettings.KeyAlreadyExistsInAnotherRecord(table, field, value : String; ID : Integer) : Boolean;
var dataSet : TRoomerDataSet;
begin
  result := false;
  dataset := tableslist.Dataset[table];
  dataSet.First;
  while not dataSet.eof do
  begin
    if (LowerCase(dataSet[field]) = LowerCase(value)) AND (dataSet['ID'] <> ID) then
    begin
      result := true;
      Break;
    end;
    dataSet.next;
  end;
end;

function TGlobalSettings.LocateSpecificRecord(dataSet : TRoomerDataSet; field : String;  value : Variant) : Boolean;
begin
  result := dataset.Locate(field, value, []);
end;

function TGlobalSettings.LocateSpecificRecord(table, field : String;  value : Integer) : Boolean;
var dataSet : TRoomerDataSet;
begin
  dataset := tableslist.Dataset[table];
  result := dataset.Locate(field, value, []);
end;

function TGlobalSettings.LocateSpecificRecord(table, field : String;  value : Boolean) : Boolean;
var dataSet : TRoomerDataSet;
begin
  dataset := tableslist.Dataset[table];
  result := dataset.Locate(field, value, []);
end;

function TGlobalSettings.LocateSpecificRecordAndGetValue(table, field, value, fieldToGet: String; var resultingValue: Integer): Boolean;
begin
  result := LocateSpecificRecord(table, field, value);
  if result then
     resultingValue := tableslist.Dataset[table][fieldToGet];
end;

function TGlobalSettings.LocateSpecificRecordAndGetValue(table, field, value, fieldToGet: String; var resultingValue: String): Boolean;
begin
  result := LocateSpecificRecord(table, field, value);
  if result then
     resultingValue := tableslist.Dataset[table][fieldToGet];
end;

function TGlobalSettings.LocateSpecificRecordAndGetValue(table, field : String; value : Integer; fieldToGet: String; var resultingValue: String): Boolean;
begin
  result := LocateSpecificRecord(table, field, value);
  if result then
     resultingValue := tableslist.Dataset[table][fieldToGet];
end;

function TGlobalSettings.LocateSpecificRecordAndGetValue(table, field, value, fieldToGet: String; var resultingValue: Double): Boolean;
begin
  result := LocateSpecificRecord(table, field, value);
  if result then
     resultingValue := tableslist.Dataset[table].GetFloatValue(tableslist.Dataset[table].FieldByName(fieldToGet))
end;

function TGlobalSettings.LocateSpecificRecordAndGetValue(table, field : String; value : Integer; fieldToGet: String; var resultingValue: Double): Boolean;
begin
  result := LocateSpecificRecord(table, field, value);
  if result then
     resultingValue := tableslist.Dataset[table].GetFloatValue(tableslist.Dataset[table].FieldByName(fieldToGet))
end;

procedure TGlobalSettings.PerformAuthenticationAssertion(Form: TForm);
var
  i: Integer;
begin
  for i := 0 to Form.ComponentCount - 1 do
    if (Form.Components[i] IS TsButton) OR
       (Form.Components[i] IS TButton) OR
       (Form.Components[i] IS TMenuItem) OR
       (Form.Components[i] IS TdxBarLargeButton) OR
       (Form.Components[i] IS TsComboBox) OR
       (Form.Components[i] IS TComboBox) OR
       (Form.Components[i] IS TsSpeedButton) OR
       (Form.Components[i] IS TSpeedButton) OR
       (Form.Components[i] IS TsCheckBox) OR
       (Form.Components[i] IS TCheckBox) OR
       (Form.Components[i] IS TsPanel) OR
       (Form.Components[i] IS TPanel) OR
       (Form.Components[i] IS TTabControl) OR
       (Form.Components[i] IS TsTabControl) OR
       (Form.Components[i] IS TcxComboBox) OR
       (Form.Components[i] IS TdxBarCombo) OR
       (Form.Components[i] IS TcxGridDBColumn) OR
       (Form.Components[i] IS TcxGridDBBandedColumn) OR
       (Form.Components[i] IS TdxBarButton) OR
       (Form.Components[i] IS TdxRibbonTab) OR
       (Form.Components[i] IS TcxGridDBBandedColumn) then
      AssertComponent(Form.Components[i]);

end;


Function TGlobalSettings.ValidateHelpContext(ctx : Integer) : Boolean;
var
  s1,s2,s3,s4,s5 : string;
begin

  if ctx = 0 then
  begin
    result := true;
    exit;
  end;

  s1 := _glob._strPadZeroL(inttostr(g.qUserAuthValue1),7)+'00000000000000';
  s2 := _glob._strPadZeroL(inttostr(g.qUserAuthValue2),7)+'00000000000000';
  s3 := _glob._strPadZeroL(inttostr(g.qUserAuthValue3),7)+'00000000000000';
  s4 := _glob._strPadZeroL(inttostr(g.qUserAuthValue4),7)+'00000000000000';
  s5 := _glob._strPadZeroL(inttostr(g.qUserAuthValue5),7)+'00000000000000';

  result := (s1[ctx] = '1') OR
            (s2[ctx] = '1') OR
            (s3[ctx] = '1') OR
            (s4[ctx] = '1') OR
            (s5[ctx] = '1')
end;

function TGlobalSettings.AccessAllowed(value : Integer) : boolean;
begin
  result := ValidateHelpContext(value);
end;

procedure TGlobalSettings.AssertComponent(Comp : TComponent);
begin
    if (Comp IS TsButton) then
       (Comp AS TsButton).Enabled := ValidateHelpContext((Comp AS TsButton).HelpContext)
    else
    if (Comp IS TButton) then
       (Comp AS TButton).Enabled := ValidateHelpContext((Comp AS TButton).HelpContext)
    else
    if (Comp IS TMenuItem) then
       (Comp AS TMenuItem).Enabled := ValidateHelpContext((Comp AS TMenuItem).HelpContext)
    else
    if (Comp IS TdxBarLargeButton) then
    begin
       if ValidateHelpContext((Comp AS TdxBarLargeButton).HelpContext) then
         (Comp AS TdxBarLargeButton).Visible := ivAlways
       else
         (Comp AS TdxBarLargeButton).Visible := ivNever
    end
    else
    if (Comp IS TsComboBox) then
       (Comp AS TsComboBox).Enabled := ValidateHelpContext((Comp AS TsComboBox).HelpContext)
    else
    if (Comp IS TComboBox) then
       (Comp AS TComboBox).Enabled := ValidateHelpContext((Comp AS TComboBox).HelpContext)
    else
    if (Comp IS TsSpeedButton) then
       (Comp AS TsSpeedButton).Enabled := ValidateHelpContext((Comp AS TsSpeedButton).HelpContext)
    else
    if (Comp IS TSpeedButton) then
       (Comp AS TSpeedButton).Enabled := ValidateHelpContext((Comp AS TSpeedButton).HelpContext)
    else
    if (Comp IS TsCheckBox) then
       (Comp AS TsCheckBox).Enabled := ValidateHelpContext((Comp AS TsCheckBox).HelpContext)
    else
    if (Comp IS TCheckBox) then
       (Comp AS TCheckBox).Enabled := ValidateHelpContext((Comp AS TCheckBox).HelpContext)
    else
    if (Comp IS TsPanel) then
       (Comp AS TsPanel).Enabled := ValidateHelpContext((Comp AS TsPanel).HelpContext)
    else
    if (Comp IS TPanel) then
       (Comp AS TPanel).Enabled := ValidateHelpContext((Comp AS TPanel).HelpContext)
    else
    if (Comp IS TTabControl) then
       (Comp AS TTabControl).Enabled := ValidateHelpContext((Comp AS TTabControl).HelpContext)
    else
    if (Comp IS TsTabControl) then
       (Comp AS TsTabControl).Enabled := ValidateHelpContext((Comp AS TsTabControl).HelpContext)
    else
    if (Comp IS TcxComboBox) then
       (Comp AS TcxComboBox).Enabled := ValidateHelpContext((Comp AS TcxComboBox).HelpContext)
    else
    if (Comp IS TdxBarCombo) then
    begin
       if ValidateHelpContext((Comp AS TdxBarCombo).HelpContext) then
         (Comp AS TdxBarCombo).Visible := ivAlways
       else
         (Comp AS TdxBarCombo).Visible := ivNever
    end
    else
    if (Comp IS TdxBarButton) then
    begin
       if ValidateHelpContext((Comp AS TdxBarButton).HelpContext) then
         (Comp AS TdxBarButton).Visible := ivAlways
       else
         (Comp AS TdxBarButton).Visible := ivNever;
    end;
end;

function TGlobalSettings.LocateSpecificRecordAndGetValue(table, field, value, fieldToGet: String; var resultingValue: Boolean): Boolean;
begin
  result := LocateSpecificRecord(table, field, value);
  if result then
     resultingValue := tableslist.Dataset[table][fieldToGet];
end;

function TGlobalSettings.GetRoomLocation(Room : String) : String;
begin
  result := '';
  if LocateSpecificRecord('rooms', 'Room', Room) then
    result := RoomsSet['Location'];
end;

function TGlobalSettings.GetRoomsSet: TRoomerDataSet;
begin
  result := tableslist.Dataset['rooms'];
end;

function TGlobalSettings.GetRoomStatistics(Room : String) : Boolean;
begin
  result := false;
  if LocateSpecificRecord('rooms', 'Room', Room) then
    result := RoomsSet['Statistics'];
end;

function TGlobalSettings.LocateRoom(Room : String) : Boolean;
begin
  result := LocateSpecificRecord('rooms', 'Room', Room);
end;


function TGlobalSettings.LocateRoomType(RoomType: String): Boolean;
begin
  result := LocateSpecificRecord('roomtypes', 'RoomType', RoomType);
end;

function TGlobalSettings.LocateCurrency(Currency: String): Boolean;
begin
  result := LocateSpecificRecord('currencies', 'Currency', Currency);
end;


function TGlobalSettings.LocateChannelById(id : Integer): Boolean;
begin
  result := LocateSpecificRecord('channels', 'id', id);
end;

function TGlobalSettings.LocateChannelColorById(id : Integer): Integer;
begin
  result := -1;
  if LocateSpecificRecord('channels', 'id', id) then
    if TRIM(ChannelsSet.FieldByName('color').AsString) <> '' then
      result := strtointdef(ChannelsSet['color'], -1);
end;

function TGlobalSettings.LocateRoomTypeColor(RoomType: String): Integer;
begin
  result := -1;
  if LocateSpecificRecord('roomtypes', 'RoomType', RoomType) then
    if TRIM(RoomTypesSet.FieldByName('color').AsString) <> '' then
      result := strtointdef(RoomTypesSet['color'], -1);
end;

function TGlobalSettings.LocateRoomTypeGroup(RoomTypeGroup: String): Boolean;
begin
  result := LocateSpecificRecord('roomtypegroups', 'Code', RoomTypeGroup);
end;

function TGlobalSettings.LocateRoomTypeGroupById(RoomTypeGroupId: Integer): Boolean;
begin
  result := LocateSpecificRecord('roomtypegroups', 'Id', RoomTypeGroupId);
end;

function TGlobalSettings.GetRoomFloor(Room : String) : Integer;
begin
  result := 0;
  if LocateSpecificRecord('rooms', 'Room', Room) then
    result := RoomsSet['Floor'];
end;

function TGlobalSettings.LocateCountryGroup(CountryGroup : String) : Boolean;
begin
  result := LocateSpecificRecord('countrygroups', 'CountryGroup', CountryGroup);
end;

function TGlobalSettings.LocateItemType(ItemType: String): Boolean;
begin
  result := LocateSpecificRecord('itemtypes', 'ItemType', ItemType);
end;

function TGlobalSettings.LocateLocation(Location : String) : Boolean;
begin
  result := LocateSpecificRecord('locations', 'Location', Location);
end;

procedure TGlobalSettings.AddRoomType( sType : string; iNumber, NumGuests : integer );
var
  RoomTypesHolder : TRoomTypesHolder;
  i : integer;
begin
  if GetNumberOfItems(sType) = -1 then
  begin
    RoomTypesHolder := TRoomTypesHolder.create;
    RoomTypesHolder.FRoomType := sType;
    RoomTypesHolder.FCount := iNumber;
    RoomTypesHolder.FNumGuests := NumGuests;
    FRoomTypes.Add( RoomTypesHolder );
  end else
  begin
    for i := 0 to FRoomTypes.count - 1 do
    begin
      if TRoomTypesHolder( FRoomTypes[ i ] ).FRoomType = sType then
      begin
        TRoomTypesHolder( FRoomTypes[ i ] ).FCount := TRoomTypesHolder( FRoomTypes[ i ] ).FCount + iNumber;
        TRoomTypesHolder( FRoomTypes[ i ] ).FNumGuests := NumGuests;
      end;
    end;
  end;
end;

function TGlobalSettings.GetNumberBaseOfItem(item: string): TNumberBase;
var sNumberBase : String;
begin
  result := INB_USER_EDIT;
  if LocateSpecificRecordAndGetValue('items', 'Item', item, 'NumberBase', sNumberBase) then
  begin
    if sNumberBase = 'ROOM_NIGHT' then result := INB_ROOM_NIGHT else
    if sNumberBase = 'GUEST_NIGHT' then result := INB_GUEST_NIGHT else
    if sNumberBase = 'GUEST' then result := INB_GUEST else
    if sNumberBase = 'ROOM' then result := INB_ROOM else
    if sNumberBase = 'BOOKING' then result := INB_BOOKING;
  end;
end;

function TGlobalSettings.GetNumberOfItems( aType : string ) : integer;
var
  i : integer;
begin
  result := -1;
  for i := 0 to FRoomTypes.count - 1 do
  begin
    if TRoomTypesHolder( FRoomTypes[ i ] ).FRoomType = aType then
    begin
      result := TRoomTypesHolder( FRoomTypes[ i ] ).FCount;
      break;
    end;
  end;
end;

function TGlobalSettings.GetPackageItems: TRoomerDataSet;
begin
  result := tableslist.Dataset['packageitems'];
end;

function TGlobalSettings.getPackageNameByPackageCode(packageCode: String): String;
begin
  if LocateSpecificRecordAndGetValue('packages', 'package', packageCode, 'Description', result) then;
end;

function TGlobalSettings.GetPackages: TRoomerDataSet;
begin
  result := tableslist.Dataset['packages'];
end;

function TGlobalSettings.GetPaygroups: TRoomerDataSet;
begin
  result := tableslist.Dataset['paygroups'];
end;

function TGlobalSettings.GetPaytypes: TRoomerDataSet;
begin
  result := tableslist.Dataset['paytypes'];
end;

function TGlobalSettings.GetPersonProfiles: TRoomerDataSet;
begin
  result := tableslist.Dataset['personprofiles'];
end;

function TGlobalSettings.GetBookKeepingCodes: TRoomerDataSet;
begin
  result := tableslist.Dataset['bookkeepingcodes'];
end;

function TGlobalSettings.RoomTypeCount : integer;
begin
  result := FRoomTypes.Count;
end;

function TGlobalSettings.GetRoomType( iIndex : integer ) : string;
begin
  result := TRoomTypesHolder( FRoomTypes[ iIndex ] ).FRoomType;
end;

function TGlobalSettings.GetRoomTypeGroupDescription(Code: String): String;
begin
  if NOT LocateSpecificRecordAndGetValue('roomtypegroups', 'Code', Code, 'Description', result) then
    result := '';
//  if LocateSpecificRecord('roomtypes', 'RoomType', RoomType) then
//    result := RoomTypesSet['Description'];
end;

function TGlobalSettings.GetRoomTypeDescription(RoomType: String): String;
begin
  if NOT LocateSpecificRecordAndGetValue('roomtypes', 'RoomType', RoomType, 'Description', result) then
    result := '';
//  if LocateSpecificRecord('roomtypes', 'RoomType', RoomType) then
//    result := RoomTypesSet['Description'];
end;

function TGlobalSettings.GetRoomTypeFromRoom(Room: String): String;
var roomType : String;
begin
  result := '';
  if LocateSpecificRecordAndGetValue('rooms', 'room', Room, 'RoomType', RoomType) then
    result := RoomType;
end;

function TGlobalSettings.GetRoomTypeGroups: TRoomerDataSet;
begin
  result := tableslist.Dataset['roomtypegroups'];
end;

function TGlobalSettings.GetChannelManagersSet: TRoomerDataSet;
begin
  result := tableslist.Dataset['channelmanagers'];
end;

function TGlobalSettings.GetChannelPlanCodes: TRoomerDataSet;
begin
  result := tableslist.Dataset['channelplancodes'];
end;

function TGlobalSettings.GET_RoomTypeNumberGuests_byRoom(Room : String) : integer;
var roomType : String;
begin
  result := 0;
  if LocateSpecificRecordAndGetValue('rooms', 'room', Room, 'RoomType', RoomType) then
    LocateSpecificRecordAndGetValue('roomtypes', 'RoomType', RoomType, 'NumberGuests', result);
end;

function TGlobalSettings.GET_RoomTypeNumberGuests_byRoomType(RoomType : String) : integer;
begin
  result := 0;
  if LocateRoomType(RoomType) then
    result := RoomTypesSet['NumberGuests'];
end;


function TGlobalSettings.GetRoomTypeNumberGuests( aType : string ) : integer;
var
  i : integer;
begin
  result := 1;
  for i := 0 to FRoomTypes.count - 1 do
  begin
    if TRoomTypesHolder( FRoomTypes[ i ] ).FRoomType = aType then
    begin
      result := TRoomTypesHolder( FRoomTypes[ i ] ).FNumGuests;
      break;
    end;
  end;
end;

function TGlobalSettings.GetRoomTypeNumberGuestsTotal( aType : string ) : integer;
var
  i : integer;
begin
  result := 0;
  for i := 0 to FRoomTypes.count - 1 do
  begin
    if TRoomTypesHolder(FRoomTypes[i]).FRoomType = aType then
    begin
      result := TRoomTypesHolder( FRoomTypes[ i ] ).FNumGuests * GetNumberOfItems( aType );
      break;
    end;
  end;
end;

function TGlobalSettings.GetRoomTypeRulesSet: TRoomerDataSet;
begin
  result := tableslist.Dataset['roomtyperules'];
end;

function TGlobalSettings.GetRoomTypesSet: TRoomerDataSet;
begin
  result := tableslist.Dataset['roomtypes'];
end;

function TGlobalSettings.GetStaffMembers: TRoomerDataset;
begin
  result := tablesList.Dataset['staffmembers'];
end;

function TGlobalSettings.GetTblconvertgroups: TRoomerDataSet;
begin
  result := tableslist.Dataset['tblconvertgroups'];
end;

function TGlobalSettings.GetTblconverts: TRoomerDataSet;
begin
  result := tableslist.Dataset['tblconverts'];
end;

function TGlobalSettings.GetTblpricecodes: TRoomerDataSet;
begin
  result := tableslist.Dataset['tblpricecodes'];
end;

function TGlobalSettings.GetTblseasons: TRoomerDataSet;
begin
  result := tableslist.Dataset['tblseasons'];
end;

function TGlobalSettings.GetVAT: TRoomerDataSet;
begin
  result := tableslist.Dataset['vatcodes'];
end;

function TGlobalSettings.LocateCountry(Country: String): Boolean;
begin
  result := LocateSpecificRecord('countries', 'Country', Country);
end;

procedure TGlobalSettings.InitAvailability;
var
  i : integer;
  s : string;
begin
  FNumAvailType.clear;
  s := '';
  for i := 0 to FRoomTypes.count - 1 do
  begin
    s := TRoomTypesHolder(FRoomTypes[i]).FRoomType + '=' +inttostr(GetNumberOfItems(TRoomTypesHolder(FRoomTypes[i]).FRoomType));
    FNumAvailType.add(s);
  end;
end;

function TGlobalSettings.isCustomerCityTaxINcluded(Customer: String): Boolean;
begin
  result := False;
  LocateSpecificRecordAndGetValue('customers', 'Customer', Customer, 'StayTaxIncluted', result);
end;

procedure TGlobalSettings.LoadCurrentRecordFromDataSet(ToSet, DataSet : TDataSet; _AppendRecord : Boolean);

  function CanAssignTo(ASource, ADestination: TFieldType): Boolean;
  begin
    Result := ASource = ADestination;
    if not Result then
      Result := (ASource = ftAutoInc) and (ADestination = ftInteger);
  end;

  procedure SetFieldValue(ASrcField, ADestField: TField);
  begin
    if ASrcField.IsNull then
      ADestField.Value := Null
    else
      case ASrcField.DataType of
        ftLargeInt: TLargeintField(ADestField).Value := TLargeintField(ASrcField).Value; // for D6
      else
        ADestField.Value := ASrcField.Value;
      end;
  end;

var
  i : Integer;
  AField : TField;
begin
  with ToSet do
  begin
    DisableControls;
    Open;
    if _AppendRecord then
      Append
    else
      Edit;
    for i := 0 to DataSet.FieldCount - 1 do
    begin
      AField := FindField(DataSet.Fields[i].FieldName);
      if(AField <> nil) and CanAssignTo(DataSet.Fields[i].DataType, AField.DataType) then
      begin
         SetFieldValue(DataSet.Fields[i], AField);
      end;
    end;
    Post;
    EnableControls;
  end;
end;


procedure OpenAppSettings;
begin
  glb := TGlobalSettings.create;
end;

procedure CloseAppSettings;
begin
  FreeAndNil(glb);
end;

{ TSet_Of_Integer }

procedure TSet_Of_Integer.Add(value: Integer);
begin
  list.Add(Value);
end;

procedure TSet_Of_Integer.Clear;
begin
  List.Clear;
end;

constructor TSet_Of_Integer.Create;
begin
  inherited Create;
  list := TList<Integer>.Create;
end;

destructor TSet_Of_Integer.Destroy;
begin
  List.Free;
  inherited;
end;

function TSet_Of_Integer.GetCount: integer;
begin
  result := list.Count;
end;

function TSet_Of_Integer.ValueInList(value: Integer): Boolean;
var
  i: Integer;
begin
  result := False;
  for i := 0 to list.Count - 1 do
    if list[i] = value then
    begin
      result := True;
      Break;
    end;
end;



initialization
begin
  AppInifile := ChangeFileExt(Paramstr(0), '.ini' );
  RoomerLanguage := uRoomerLanguage.RoomerLanguage;
end;

end.
