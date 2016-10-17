unit uTableEntityList;

interface

uses
  cmpRoomerDataset
  , Generics.Collections
  , SysUtils
  ;

type

  ERefreshTableException = class(Exception);

  TTableEntity = class
  private
    FTableName: String;
    FSql: String;
    FRSet: TRoomerDataSet;
    FForceRefreshed : Boolean;
    FRefreshEnabled : Boolean;
    function GetFilename: String;
    function ReadFromFile: String;
    procedure SaveToFile(data: String);
    function FileTimeStamp: TDateTime;
  public
    constructor Create(tableName : String; baseTableAlwaysRefresh : Boolean = false; sqlExtension : String = '');
    destructor Destroy; override;
    procedure RefreshFromServer;
    procedure RefreshLocally(ForceRefresh : Boolean = true);
    procedure RefreshIfNeeded;
    property TableName : String read FTableName;
    property sql : String read FSql write FSql;
    property RSet : TRoomerDataSet read FRSet;
    property RefreshEnabled : Boolean read FRefreshEnabled write FRefreshEnabled;
  end;

  TTableDictionary = class(TObjectDictionary<String, TTableEntity>)
  private
    function GetTableEntityByName(aName: string): TTableEntity;
    function GetDatasetByName(aName: string): TRoomerDataset;
  public
    procedure InitializeTables;
    procedure RefreshAllIfNeeded;
    procedure RefreshAllLocally(ForceRefresh : Boolean = true);

    property TableEntity[aName: string]: TTableEntity read GetTableEntityByName;
    property Dataset[aName: string]: TRoomerDataset read GetDatasetByName;
  end;

const
  cRoomerTableFileName = 'RoomerTable_%s.src';



implementation

uses
  uD
  , AdODB
  , uMessageList
  , uUtils
  , IOUtils
  , uStringUtils
  , uFileSystemUtils;

{ TTableDictionary }

function TTableDictionary.GetDatasetByName(aName: string): TRoomerDataset;
var
  lTable: TTableEntity;
begin
  if TryGetValue(aName, lTable) then
    Result := lTable.RSet
  else
    Result := nil;
end;

function TTableDictionary.GetTableEntityByName(aName: string): TTableEntity;
begin
  if NOT TryGetValue(aName, result) then
    result := nil;
end;

procedure TTableDictionary.InitializeTables;
begin

  Add('rooms', TTableEntity.Create('rooms', true, 'ORDER BY OrderIndex Desc, Room ASC'));

  Add('maintenancecodes', TTableEntity.Create('maintenancecodes'));
  Add('maintenanceroomnotes', TTableEntity.Create('maintenanceroomnotes'));
  Add('staffmembers', TTableEntity.Create('staffmembers', true));

  Add('locations', TTableEntity.Create('locations'));
  Add('packages', TTableEntity.Create('packages'));
  Add('packageitems', TTableEntity.Create('packageitems'));
  Add('roomtyperules', TTableEntity.Create('roomtyperules'));
  Add('vatcodes', TTableEntity.Create('vatcodes'));
  Add('items', TTableEntity.Create('items'));
  Add('itemtypes', TTableEntity.Create('itemtypes'));
  Add('roomtypegroups', TTableEntity.Create('roomtypegroups', true));
  Add('roomtypes', TTableEntity.Create('roomtypes', true));
  Add('channels', TTableEntity.Create('channels'));
  Add('channelmanagers', TTableEntity.Create('channelmanagers'));
  Add('currencies', TTableEntity.Create('currencies'));
  Add('control', TTableEntity.Create('control', true, ' LIMIT 1'));
  Add('countries', TTableEntity.Create('countries'));
  Add('countrygroups', TTableEntity.Create('countrygroups'));
  Add('customers', TTableEntity.Create('customers'));

  Add('tblconverts', TTableEntity.Create('tblconverts'));
  Add('tblconvertgroups', TTableEntity.Create('tblconvertgroups'));
  Add('paygroups', TTableEntity.Create('paygroups'));
  Add('paytypes', TTableEntity.Create('paytypes'));
  Add('personprofiles', TTableEntity.Create('personprofiles'));
  Add('bookkeepingcodes', TTableEntity.Create('bookkeepingcodes'));
  Add('tblseasons', TTableEntity.Create('tblseasons'));
  Add('tblpricecodes', TTableEntity.Create('tblpricecodes'));
  Add('customertypes', TTableEntity.Create('customertypes'));

  Add('channelplancodes', TTableEntity.Create('channelplancodes', true));
  Add('pms_settings', TTableEntity.Create('pms_settings'));
  Add('tblMaidActions', TTableEntity.Create('tblMaidActions'));
end;

procedure TTableDictionary.RefreshAllLocally(ForceRefresh: Boolean);
var
  lTable : TTableEntity;
begin
  for lTable in Values do
    lTable.RefreshLocally(ForceRefresh);
end;

procedure TTableDictionary.RefreshAllIfNeeded;
var
  lTable : TTableEntity;
begin
  for lTable in Values do
    lTable.RefreshIfNeeded;
end;

{ TTableEntity }

constructor TTableEntity.Create(tableName : String; baseTableAlwaysRefresh : Boolean = false; sqlExtension: String = '');
begin
  FSql := format('SELECT * FROM %s %s', [tableName, sqlExtension]);
  FTableName := tableName;
  FRSet := CreateNewDataSet;
  FRSet.CommandType := cmdText;
  FForceRefreshed := baseTableAlwaysRefresh;
  FRefreshEnabled := True;
end;

destructor TTableEntity.Destroy;
begin
  FRSet.Free;
  inherited;
end;

procedure TTableEntity.RefreshFromServer;
begin
  if NOT FRefreshEnabled then
    exit;

  FRSet.Close;

  FRSet.CommandText := FSql;
  try
    FRSet.Open(true, false, True); // Open(doLowerCase: Boolean = true; setLastAccess: Boolean = true; Threaded: Boolean = False);
    SaveToFile(FRSet.SavedLastResult);
    FRSet.First;
    RoomerMessages.MarkTableAsRefreshed(FTableName);
  except
    raise ERefreshTableException.CreateFmt('Error while refreshing table [%s] from server', [FTableName]);
  end;
end;

procedure TTableEntity.RefreshLocally(ForceRefresh : Boolean = true);
var localData : STring;
begin
  if NOT FRefreshEnabled then
    exit;
  if FRSet.Active then FRSet.Close;
  FRSet.CommandText := FSql;
  localData := ReadFromFile;
  if localData <> '' then
  try
    FRSet.OpenDataset(localData);
    RoomerMessages.MarkTableAsRefreshed(FTableName, FileTimeStamp);
  except
    raise ERefreshTableException.CreateFmt('Error while refreshing table [%s] locally', [FTableName]);
  end;
end;

procedure TTableEntity.SaveToFile(data : String);
begin
  SaveToTextFile(GetFilename, data);
  SetFileDateTime(GetFilename, RoomerMessages.CurrentTableDate(FTableName));
end;

function TTableEntity.ReadFromFile : String;
begin
  result := ReadFromTextFile(GetFilename);
end;

function TTableEntity.FileTimeStamp : TDateTime;
begin
  result := GetFileTimeStamp(GetFilename);
end;

function TTableEntity.GetFilename : String;
var sPath : String;
begin
  sPath := TPath.Combine(LocalAppDataPath, 'Roomer');
  sPath := TPath.Combine(sPath, format('%s\datacache',[d.roomerMainDataSet.hotelId]));
  forceDirectories(sPath);

  result := TPath.Combine(sPath, format(cRoomerTableFileName, [FTableName]));
end;


procedure TTableEntity.RefreshIfNeeded;
begin
  if d.roomerMainDataSet.OfflineMode OR (NOT d.roomerMainDataSet.LoggedIn) then
    exit;
  if (NOT FileExists(GetFilename)) OR (RoomerMessages.TableNeedsRefresh(FTableName)) then
    RefreshFromServer;
end;

end.
