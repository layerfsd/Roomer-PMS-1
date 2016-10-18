unit cmpRoomerDataSet;

interface

{$INCLUDE roomer.inc}

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  Data.Win.ADODB,
  MSXML2_TLB,
  uAPIDataHandler,
  AlHttpCommon,
  RoomerCloudEntities,
  Generics.Collections,
  uRoomerHttpClient
  ;

const
  ftTemplate = $0000;
  ftImage = $0001;
  ftDocument = $0002;
  ftSystem = $0003;

  ptAll = $0000;
  ptExec = $0001;
  ptQuery = $0002;

type

  ERoomerExecutionPlanException = class(Exception);

  TRoomerDataSet = class;
  TRoomerDatasetList = TObjectList<TRoomerDataSet>;

  SET_OF_TRoomerDataSet = Array OF TObject;
  SET_OF_String = Array OF String;

  PRecInfo = ^TRecInfo;

  TRoomerOfflineAssertonParameter = (roapGet, roapPut, roapDelete, roapPost);

  TRecInfo = {$IFDEF CPUX86}packed {$ENDIF} record
    Bookmark: OleVariant;
    BookmarkFlag: TBookmarkFlag;
    RecordStatus: Integer;
    RecordNumber: Integer;
  end;

  TRoomerPlanEntity = class
  public
    PlanType: Integer;
    Sql: String;
    constructor Create(_planType: Integer; _sql: String);
  end;

  TRoomerPlanEntityList = TObjectList<TRoomerPlanEntity>;

  TRoomerHotelsEntity = class
  public
    hotelCode: String;
    hotelName: String;
    ownerId: Integer;
    constructor Create(_hotelCode, _hotelName: String; _ownerId: Integer);
  end;

  TRoomerExecutionPlan = class
  private
    FRoomerDataSet: TRoomerDataSet;
    queryResults: TRoomerDatasetList;
    sqlList: TRoomerPlanEntityList;
    FExecException: String;
    FInTransaction: boolean;
    function getSqlsAsTList(PlanType: Integer): TList<String>;

    function GetCount: Integer;
    function GetQueryCount: Integer;
    function GetExecCount: Integer;
    function GetResultRoomerDataSet(index: Integer): TRoomerDataSet;
  public
    constructor Create(_RoomerDataSet: TRoomerDataSet = nil);
    destructor Destroy; override;

    procedure BeginTransaction;
    procedure CommitTransaction;
    procedure RollbackTransaction;

    function AddQuery(aSql: String): Integer;
    function AddExec(aSql: String): Integer;

    procedure Clear;

    function Execute(PlanType: Integer = ptAll; transaction: boolean = false;
      performRollBackOnException: boolean = false): boolean;

    property Results[index: Integer]: TRoomerDataSet read GetResultRoomerDataSet;
    property RoomerDataSet: TRoomerDataSet read FRoomerDataSet write FRoomerDataSet;
    property QueryCount: Integer read GetQueryCount;
    property ExecCount: Integer read GetExecCount;
    property Count: Integer read GetCount;
    property ExecException: String read FExecException;
  end;

  THotelsEntityList = TObjectList<TRoomerHotelsEntity>;

  TRoomerDataSet = class(TADODataSet)
  private
    FRoomerDataSet: TRoomerDataSet;
    FSavedLastResult: String;
    FSavedResult: _Recordset;
    FUri: String;
    FSql: TStringList;
    FDataActive: boolean;
    FOpenApiUri: String;
    FRoomerEntitiesUri: String;
    FRoomerDatasetsUri: String;
    FOnSessionExpired: TNotifyEvent;

    FroomerClient: TRoomerHttpClient;
{$IFDEF USE_INDY}IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
{$ENDIF}
    FCommandType: TCommandType;
    FSessionLengthSeconds: Integer;
    FLastAccess: TDateTime;
    FNumberOfAffectedRows: Integer;
    FStoreUri: String;
    hotelsList: THotelsEntityList;
    FApplicationID: String;
    FAppSecret: String;
    FAppKey: String;
    FOfflineMode: boolean;
    FLoggedIn: boolean;
    function GetCommandText: String;
    procedure SetCommandText(const Value: String);
    procedure SetCommandType(const Value: TCommandType);
    function GetUri: String;
    procedure SetUri(const Value: String);
    procedure SetDataActive(const Value: boolean);
    function ProvideFieldValue(Field: TField; iMaxSize: Integer): String;
    procedure SetSessionLengthInSeconds(const xmlSource: String);
    procedure GetFieldText(Sender: TField; var Text: string; DisplayText: boolean);
    function loginViaPost(const url, Data: String; SetLastAccess: boolean = true): String;
    function getHotelsList: THotelsEntityList;
    function GetAsString(const url: String; const contentType: String = ''; force: boolean = false): String;

    function PostAsString(const url, Data: String; const contentType: String = ''): String;
    function PostAsStringAsync(const url, Data: String; const contentType: String = ''): String;
    function DownloadFile(aRoomerClient: TRoomerHttpClient; const url, filename: String): boolean;
    procedure AddAuthenticationHeaders(aRoomerClient: TRoomerHttpClient);
    function UploadFile(aRoomerClient: TRoomerHttpClient; const url, filename: String): boolean;
    function PostAsJSON(const url, Data: String): String;
    function PutAsJSON(const url, Data: String): String;
    function DeleteAsString(const url: String): String;
    function GetOpenApiUri: String;
    procedure SetOpenApiUri(const Value: String);
    function downloadUrlAsStringUsingPut(const url: String; const Data: String; SetLastAccess: boolean = true;
      loggingInOut: Integer = 0 { 0/1/2 = neither/login/logout }
      ; const contentType: String = ''; retryOnError: boolean = true): String;
    function PutAsString(const url, Data: String; const contentType: String = ''; retryOnError: boolean = true): String;
    function PostStreamAsString(const url: String; Data: TStream; const contentType: String = ''): String;
    procedure SetOpenApiAuthHeaders(hdrs:
{$IFDEF USE_INDY}TIdHeaderList{$ELSE}TAlHttpRequestHeader{$ENDIF});
    // function GetOpenAPIResourcePath(Endpoint, URI: String): String;
    procedure SetOfflineMode(const Value: boolean);
    procedure AssertOnlineMode(param: TRoomerOfflineAssertonParameter = roapGet; const aSql: String = '');
    function GetFilenameFromParameter(param: TRoomerOfflineAssertonParameter): String;
    function GetParameterTypeName(param: TRoomerOfflineAssertonParameter): String;
    procedure DoSessionExpired;
    procedure SetSpecificOpenApiAuthHeaders(hdrs: TAlHttpRequestHeader; AppKey, ApplicationId, AppSecret: String;
      tim: Extended);
    function downloadUrlAsStringUsingPostThreaded(const url: String; const Data: String; SetLastAccess: boolean = true;
      loggingInOut: Integer = 0 { 0/1/2 = neither/login/logout }; const contentType: String = ''): String;
    function FreeQueryThreaded(const query: String; SetLastAccess: boolean = true): String;
  protected
    { Protected declarations }
    FUsername: String;
    FPassword: String;
    FAppName: String;
    FAppVersion: String;
    FHotelId: String;
    FLastSql: String;

    function activeRoomerDataSet: TRoomerDataSet;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function CreateRoomerClient(aAddAuthenticationHeader: boolean = false): TRoomerHttpClient;
    function GetFloatValue(Field: TField): Double;
    procedure Post; override;
    procedure OpenDataset(const SqlResult: String);
    procedure OpenDatasetFromUrlAsString(aEndPoint: String; SetLastAccess: boolean = true; loggingInOut: Integer = 0;contentType: String = '');
    procedure DoQuery(aSql: String);
    function DoCommand(aSql: String; async: boolean = false): Integer;
    procedure Open(doLowerCase: boolean = true; SetLastAccess: boolean = true; Threaded: boolean = false);

    function PutData(url, Data: String): String;
    function PostData(url, Data: String): String;
    function DeleteData(url: String): String;

    function SplitMultipleResultIntoDatasets(res: String): TList<TRoomerDataSet>;

    procedure SetTimeZoneComparedToUTC(tz: String);

    function IsConnectedToInternet: boolean;
    function RoomerPlatformAvailable: boolean;

    procedure markMessageAsRead(id: Integer);
    function KeepSessionAlive: String;

    function ReLogin: boolean;
    function Login(hotelId: String; username: String; password: String; appName: String; appVersion: String;
      RightRangeMin: Integer = 90; RightRangeMax: Integer = 100): boolean;
    function RoomerAdminLogin(username: String; password: String; appName: String; appVersion: String): boolean;
    procedure Logout;
    procedure LogoutUnaffected;
    function MyIpAddress: String;
    function SyncFinanceTables: String;
    function SwapHotel(hotelId: String; var username, password: String): boolean;

    function CreateExecutionPlan: TRoomerExecutionPlan;

    function SendConfirmationEmailOpenAPI(Reservation: Integer): String;
    function SendEmailOpenAPI(subject: UTF8String; from, recipient, cc, bcc: String; _text, _htmlText: UTF8String;
      files: TStringList): String;

    function HashedPassword(password: String): String;
    function SystemDownloadFileFromURI(URI, filename: String): boolean;
    function SystemUploadFile(filename: String; FileType: word; includeLastModified: boolean = true): boolean;
    function SystemDownloadFile(FileType: word; sourceFilename, destFilename: String): boolean;
    function SystemDownloadRoomerFile(sourceFilename, destFilename: String): boolean;

    procedure SystemMarkReservationAsNotified(id: Integer);
    function SystemDownloadRoomerBackup(destFilename: String): boolean;
    function SystemRoomerFile(filename: String): TFileEntity;
    function SystemListFiles(FileType: word): TFileList;
    function SystemDeleteFile(FileType: word; filename: String): boolean;
    function SystemRenameFile(FileType: word; filename, newFilename: String): boolean;
    function SystemFileExists(FileType: word; filename: String): boolean;
    procedure SystemPrepareChannelRates;

    function PostOpenAPI(url: String; Data: TStream): String;
    function DeleteFileResourceOpenAPI(URI: String): String;
    function PostFileOpenAPI(url, filename, keyString: String; FileType: String;
      privateResource: boolean = true): String;
    function DownloadFileResourceOpenAPI(URI, destFilename: String): boolean;
    function HeadOfURI(URI: String): TALHTTPResponseHeader;

    function queryRoomer(aSql: String; SetLastAccess: boolean = true; Threaded: boolean = false): String;
    function downloadUrlAsString(url: String; loggingInOut: Integer = 0; SetLastAccess: boolean = true;
      contentType: String = ''; RaiseException: boolean = false): String;
    function downloadUrlAsStringUsingPost(url: String; Data: String; SetLastAccess: boolean = true;
      loggingInOut: Integer = 0 { 0/1/2 = neither/login/logout }
      ; contentType: String = ''): String;
    function downloadUrlAsStringUsingPostAsync(url: String; Data: String; SetLastAccess: boolean = true;
      loggingInOut: Integer = 0 { 0/1/2 = neither/login/logout }
      ; contentType: String = ''): String;
    function downloadRoomerUrlAsString(url: String; SetLastAccess: boolean = true): String;

    function UrlEncode(source: string): string;
    procedure AssignToDataset(SqlResult: String; DataSet: TRoomerDataSet);

    function SecondsLeft: Integer;

    function RegisterApplication(hotelId, username, password, appId: String): String;

    // ******************************************************

{$I RoomerDBMethodsDefinitions.inc}
    function ActivateNewDataset(const SqlResult: String): TRoomerDataSet;
    function CreateNewDataset: TRoomerDataSet;
    procedure AssignPropertiesToDataSet(DataSet: TRoomerDataSet);

    function CloneToRecordset: _Recordset;

    function OfflineFilesAvailable(_hotelId: String = ''): boolean;

    // For testing purposes...
    function TestSpecificOpenApiAuthHeaders(AppKey, ApplicationId, AppSecret, url: String; tim: Extended = 0): String;

    property hotels: THotelsEntityList read getHotelsList;

    property OfflineMode: boolean read FOfflineMode write SetOfflineMode;
    property LoggedIn: boolean read FLoggedIn write FLoggedIn;
    property RoomerDataSet: TRoomerDataSet read FRoomerDataSet write FRoomerDataSet;

  published
    { Published declarations }
    property SavedLastResult: String read FSavedLastResult;
    property Sql: TStringList read FSql;
    property DataActive: boolean read FDataActive write SetDataActive;
    property RoomerStoreUri: String read FStoreUri write FStoreUri;
    property OpenApiUri: String read GetOpenApiUri write SetOpenApiUri;
    property RoomerUri: String read GetUri write SetUri;
    property RoomerEntitiesUri: String read FRoomerEntitiesUri write FRoomerEntitiesUri;
    property RoomerDatasetsUri: String read FRoomerDatasetsUri write FRoomerDatasetsUri;

    property roomerClient: TRoomerHttpClient read FroomerClient;

    property OnSessionExpired: TNotifyEvent read FOnSessionExpired write FOnSessionExpired;
    property CommandText: String read GetCommandText write SetCommandText;
    property CommandType: TCommandType read FCommandType write SetCommandType;
    property SessionLengthSeconds: Integer read FSessionLengthSeconds write FSessionLengthSeconds;
    property NumberOfAffectedRows: Integer read FNumberOfAffectedRows;
    property hotelId: String read FHotelId write FHotelId;
    property username: String read FUsername write FUsername;
    property password: String read FPassword write FPassword;
    property ParentRoomerDataSet: TRoomerDataSet read FRoomerDataSet write FRoomerDataSet;

    property ApplicationId: String read FApplicationID write FApplicationID;
    property AppKey: String read FAppKey write FAppKey;
    property AppSecret: String read FAppSecret write FAppSecret;

    property AfterScroll;

  end;

procedure Register;

implementation

uses
  JSonManager,
  md5hash,
  uDateUtils,
  idMultiPartFormData,
  GoogleOTP256,
  uRoomerExceptions,
  IOUtils,
  uFileSystemUtils,
  uFloatUtils,
   Vcl.Dialogs,
  DateUtils,
  uStringUtils,
  WinApi.Windows,
  WinInet,
  Vcl.Forms,
  IdHTTP,
  ADOInt,
  Variants,
  RoomerMultipartFormData,
  ALWininetHttpClient,
  ALHttpClient,
  IdSSLOpenSSL
  , XMLUtils
  ;

resourcestring
  PROMOIR_ROOMER_HOTEL_IDENTIFIER = 'Promoir-Roomer-Hotel-Identifier';
  PROMOIR_ROOMER_HOTEL_SECRET = 'Promoir-Roomer-Hotel-Secret';
  PROMOIR_ROOMER_HOTEL_APPLICATION_ID = 'Promoir-Roomer-Hotel-ApplicationId';
  PROMOIR_ROOMER_HOTEL_ADD_PRIVATE_RESOURCES = 'Promoir-Roomer-Hotel-Add-Private-Resources';
  PROMOIR_ROOMER_HOTEL_PATH = 'Promoir-Roomer-Hotel-Add-Resources-Path';

var
  EXTRA_BUILD_ID: String;

procedure Register;
begin
  RegisterComponents('Roomer', [TRoomerDataSet]);
end;

{ TRoomerDataSet }

const
  ROOMER_SPLIT: String = '[\ROOMER-SPLIT\]';

function TRoomerDataSet.CloneToRecordset: _Recordset;
var
  newRec: _Recordset;
  stm: Stream;
begin
  newRec := CoRecordset.Create as _Recordset;
  stm := CoStream.Create;
  Recordset.Save(stm, adPersistADTG);
  newRec.Open(stm, EmptyParam, CursorTypeEnum(adOpenUnspecified), LockTypeEnum(adLockUnspecified), 0);
  Result := newRec;
end;

constructor TRoomerDataSet.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FLoggedIn := false;

  FApplicationID := '';
  FAppSecret := '';
  FAppKey := '';

  FRoomerDataSet := nil;
  FOnSessionExpired := nil;
  FOfflineMode := false;
  FSql := TStringList.Create;
  hotelsList := THotelsEntityList.Create(true);
  FDataActive := false;
{$IFDEF rmUseLOCALRESOURCE}
  FStoreUri := 'http://localhost:8080/services/';
  FUri := 'http://localhost:8080/services/';
  FRoomerEntitiesUri := 'http://localhost:8080/services/entities/';
  FRoomerDatasetsUri := 'http://localhost:8080/services/datasets/';
{$ELSE}
  FStoreUri := 'http://store.roomercloud.net:8080/services/';
  FUri := 'http://mobile.roomercloud.net:8080/services/';
  FRoomerEntitiesUri := 'http://mobile.roomercloud.net:8080/services/entities/';
  FRoomerDatasetsUri := 'http://mobile.roomercloud.net:8080/services/datasets/';
{$ENDIF}
  FroomerClient := CreateRoomerClient;
  FLastAccess := now;

end;

function TRoomerDataSet.CreateRoomerClient(aAddAuthenticationHeader: boolean = false): TRoomerHttpClient;
begin
  Result := TRoomerHttpClient.Create(nil);

  if aAddAuthenticationHeader then
  begin
    AddAuthenticationHeaders(Result);
  end;
end;

function TRoomerDataSet.CreateExecutionPlan: TRoomerExecutionPlan;
begin
  Result := TRoomerExecutionPlan.Create;
  Result.RoomerDataSet := self;
end;

destructor TRoomerDataSet.Destroy;
begin
  FSql.Free;
  hotelsList.Free;
  FreeAndNil(FroomerClient);
  inherited;
end;

function TRoomerDataSet.CreateNewDataset: TRoomerDataSet;
begin
  Result := TRoomerDataSet.Create(Owner);
  Result.RoomerStoreUri := activeRoomerDataSet.RoomerStoreUri;
  Result.RoomerUri := activeRoomerDataSet.RoomerUri;
  Result.OpenApiUri := activeRoomerDataSet.OpenApiUri;
  Result.RoomerEntitiesUri := activeRoomerDataSet.RoomerEntitiesUri;
  Result.RoomerDatasetsUri := activeRoomerDataSet.RoomerDatasetsUri;
  Result.FRoomerDataSet := self;
  Result.OnSessionExpired := self.OnSessionExpired;
  Result.FHotelId := self.FHotelId;
  Result.FPassword := self.FPassword;
  Result.FUsername := self.FUsername;
  Result.FAppName := self.FAppName;
  Result.FAppVersion := self.FAppVersion;
  Result.AppKey := self.AppKey;
  Result.ApplicationId := self.ApplicationId;
  Result.AppSecret := self.AppSecret;
end;

procedure TRoomerDataSet.AssignPropertiesToDataSet(DataSet: TRoomerDataSet);
begin
  DataSet.RoomerStoreUri := activeRoomerDataSet.RoomerStoreUri;
  DataSet.RoomerUri := activeRoomerDataSet.RoomerUri;
  DataSet.OpenApiUri := activeRoomerDataSet.OpenApiUri;
  DataSet.RoomerEntitiesUri := activeRoomerDataSet.RoomerEntitiesUri;
  DataSet.RoomerDatasetsUri := activeRoomerDataSet.RoomerDatasetsUri;
  DataSet.FRoomerDataSet := self;
  DataSet.OnSessionExpired := self.OnSessionExpired;
end;

function TRoomerDataSet.IsConnectedToInternet: boolean;
var
  dwConnectionTypes: DWORD;
begin
  dwConnectionTypes := INTERNET_CONNECTION_MODEM + INTERNET_CONNECTION_LAN + INTERNET_CONNECTION_PROXY;

{$IFDEF rmForceOffline}
  Result := false;
{$ELSE}
  Result := InternetGetConnectedState(@dwConnectionTypes, 0);
{$ENDIF rmForceOffline}
end;

function TRoomerDataSet.RoomerPlatformAvailable: boolean;
begin
  Result := true;
  try
    if GetAsString(RoomerUri + 'sessions/livecheck', '', true) = '' then;
  except
    on E: Exception do
    begin
      OutputDebugString(PChar('>>>>>Exception during RoomerPLatformAvailable: ' + E.Message));
      Result := false;
    end;
  end;
end;

function TRoomerDataSet.UrlEncode(source: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to length(source) do
    if CharInSet(source[i], ['+', '^', '&', '%', '?', '\', '`']) then
      Result := Result + '%' + inttohex(ord(source[i]), 2)
    else
      Result := Result + source[i];
end;

function TRoomerDataSet.activeRoomerDataSet: TRoomerDataSet;
begin
  if assigned(FRoomerDataSet) then
    Result := FRoomerDataSet
  else
    Result := self;
end;

procedure XSaveToFile(Text, filename: String);
var
  list: TStrings;
begin
  list := TStringList.Create;
  try
    list.Text := Text;
    list.SaveToFile(filename);
  finally
    FreeAndNil(list);
  end;
end;

procedure TRoomerDataSet.Open(doLowerCase: boolean = true; SetLastAccess: boolean = true; Threaded: boolean = false);
var
  sqlCommand, SqlResult: String;
begin
  if doLowerCase then
    sqlCommand := LowerCase(Sql.Text)
  else
    sqlCommand := Sql.Text;
  SqlResult := queryRoomer(sqlCommand, SetLastAccess, Threaded);
  OpenDataset(SqlResult);
end;


procedure TRoomerDataSet.SystemMarkReservationAsNotified(id: Integer);
begin
  try
    DoCommand('UPDATE reservations SET notificationRead=1 WHERE Reservation=' + inttostr(id));
  except
  end;
end;

function TRoomerDataSet.GetOpenApiUri: String;
begin
  Result := FOpenApiUri;
end;

function TRoomerDataSet.RegisterApplication(hotelId, username, password, appId: String): String;
begin
  try
    Result := downloadUrlAsStringUsingPost(OpenApiUri + 'credentials/register' +
      format('?hotelId=%s&user=%s&password=%s&appId=%s', [EncodeURIComponent(hotelId), EncodeURIComponent(username),
      AnsiString(HashedPassword(password)), EncodeURIComponent(appId)]), '');
  except
    Result := '';
  end;
end;

procedure TRoomerDataSet.markMessageAsRead(id: Integer);
begin
  downloadUrlAsString(RoomerUri + format('messaging/markbroadcastread?messageId=%d', [id]), 0, false);
end;

function TRoomerDataSet.KeepSessionAlive: String;
begin
  Result := downloadUrlAsString(RoomerUri + 'sessions/pulse', 0, true);
end;

function TRoomerDataSet.FreeQueryThreaded(const query: String; SetLastAccess: boolean = true): String;
var
  res, setAccess: String;
begin
  if SetLastAccess then
    setAccess := 'true'
  else
    setAccess := 'false';
  res := downloadUrlAsStringUsingPostThreaded(RoomerUri + 'pms/business/query',
    format('query=%s&%s', [UrlEncode(query), setAccess]), SetLastAccess);
  Result := res;
end;

function TRoomerDataSet.queryRoomer(aSql: String; SetLastAccess: boolean = true; Threaded: boolean = false): String;
begin
  FLastSql := aSql;
  if NOT Threaded then
    Result := activeRoomerDataSet.SystemFreeQuery(aSql, SetLastAccess)
  else
    Result := FreeQueryThreaded(aSql, SetLastAccess);
end;

function TRoomerDataSet.ReLogin: boolean;
begin
  Result := Login(hotelId, username, password, FAppName, FAppVersion);
end;

function TRoomerDataSet.RoomerAdminLogin(username, password, appName, appVersion: String): boolean;
var
  pwmd5: String;
  res: String;
begin
  Result := true;
  FUsername := username;
  FPassword := password;
  pwmd5 := HashedPassword(password);

  res := loginViaPost(RoomerUri + 'authentication/roomerlogin',
    format('username=%s&pwencoded=%s&appname=%s&appversion=%s&datasettype=0', [username, pwmd5, appName, appVersion]));
  // {$ENDIF}
  SetSessionLengthInSeconds(res);
  FLastAccess := now;
  FLoggedIn := true;
end;

function TRoomerDataSet.GetParameterTypeName(param: TRoomerOfflineAssertonParameter): String;
begin
  Result := '(NA)';
  case param of
    roapGet:
      Result := 'GET';
    roapPut:
      Result := 'PUT';
    roapDelete:
      Result := 'DELETE';
    roapPost:
      Result := 'POST';
  end;
end;

function TRoomerDataSet.GetFilenameFromParameter(param: TRoomerOfflineAssertonParameter): String;
var
  sPath: String;
begin
  sPath := TPath.Combine(LocalAppDataPath, 'Roomer');
  sPath := TPath.Combine(sPath, format('%s\backup', [hotelId]));
  forceDirectories(sPath);
  Result := TPath.Combine(sPath, format('Offline_%s_Commands.src', [GetParameterTypeName(param)]));
end;

procedure TRoomerDataSet.AssertOnlineMode(param: TRoomerOfflineAssertonParameter = roapGet; const aSql: String = '');
begin
  if OfflineMode then
  begin
    case param of
      roapGet:
        ;
      roapPut:
        AddToTextFile(GetFilenameFromParameter(param), aSql);
      roapDelete:
        AddToTextFile(GetFilenameFromParameter(param), aSql);
      roapPost:
        AddToTextFile(GetFilenameFromParameter(param), aSql);
    end;
    raise ERoomerOfflineAssertionException.CreateErrCode(format('Roomer is in Off-line mode while trying %s mode SQL.',
      [GetParameterTypeName(param)]), ord(param));
  end;
end;

function TRoomerDataSet.PutData(url, Data: String): String;
begin
  Result := PutAsString(RoomerUri + url, Data);
end;

function TRoomerDataSet.PostData(url, Data: String): String;
begin
  Result := PostAsString(RoomerUri + url, Data);
end;

function TRoomerDataSet.DeleteData(url: String): String;
begin
  Result := DeleteAsString(RoomerUri + url);
end;

function TRoomerDataSet.downloadRoomerUrlAsString(url: String; SetLastAccess: boolean = true): String;
begin
  Result := downloadUrlAsString(RoomerUri + url, 0, SetLastAccess);
end;

procedure TRoomerDataSet.AddAuthenticationHeaders(aRoomerClient: TRoomerHttpClient);
begin
  aRoomerClient.AddAuthenticationHeaders(hotelId, username, password, FAppName, FAppVersion, EXTRA_BUILD_ID);
  SetOpenApiAuthHeaders(aRoomerClient.RequestHeader);
end;

(*
  function TRoomerDataSet.GetAsJSON(roomerClient:
  TRoomerHttpClient
  ; url: String): String;

  var
  _roomerClient: TRoomerHttpClient;

  var retries : Integer;
  begin
  AssertOnlineMode;
  _roomerClient := CreateRoomerClient;
  try
  AddAuthenticationHeaders(_roomerClient);
  _roomerClient.RequestHeader.AcceptEncoding := 'UTF-8';
  for retries := 1 to 3 do
  begin
  try
  result := _roomerClient.Get(url);
  Break;
  except
  if retries = 3 then
  raise;
  end;
  end;
  finally
  FreeAndNil(_roomerClient);
  end;
  end;

*)
function TRoomerDataSet.PostAsJSON(const url, Data: String): String;
var
  Stream: TStringStream;
  _roomerClient: TRoomerHttpClient;

var
  retries: Integer;
begin
  AssertOnlineMode;
  _roomerClient := CreateRoomerClient(true);
  try

    _roomerClient.contentType := 'application/json';

    Stream := TStringStream.Create(Data, TEncoding.UTF8);
    try
      Stream.Position := 0;
      for retries := 1 to 3 do
      begin
        try
          Result := String(_roomerClient.Post(AnsiString(url), Stream));
          Break;
        except
          if retries = 3 then
            raise;
        end;
      end;
    finally
      Stream.Free;
    end;
  finally
    FreeAndNil(_roomerClient);
  end;
end;

function TRoomerDataSet.PutAsJSON(const url, Data: String): String;
var
  Stream: TStringStream;
  _roomerClient: TRoomerHttpClient;

var
  retries: Integer;
begin
  AssertOnlineMode;
  _roomerClient := CreateRoomerClient(true);
  try

    _roomerClient.contentType := 'application/json';

    Stream := TStringStream.Create(Data, TEncoding.UTF8);
    try
      Stream.Position := 0;
      for retries := 1 to 3 do
      begin
        try
          Result := String(_roomerClient.Put(AnsiString(url), Stream));
          Break;
        except
          if retries = 3 then
            raise;
        end;
      end;
    finally
      Stream.Free;
    end;
  finally
    FreeAndNil(_roomerClient);
  end;
end;

function TRoomerDataSet.GetAsString(const url: String; const contentType: String = ''; force: boolean = false): String;
var
  _roomerClient: TRoomerHttpClient;

var
  retries: Integer;
begin
  if NOT force then
    AssertOnlineMode;
  _roomerClient := CreateRoomerClient(true);
  try
    if contentType = '' then
      _roomerClient.contentType := '*/*;charset=utf-8'
    else
    _roomerClient.contentType := contentType;
    _roomerClient.AcceptEncoding := 'UTF-8';
    for retries := 1 to 3 do
    begin
      try
        Result := String(_roomerClient.Get(AnsiString(url)));
        Break;
      except
        if retries = 3 then
          raise;
      end;
    end;
  finally
    FreeAndNil(_roomerClient);
  end;
end;

function TRoomerDataSet.PostAsString(const url, Data: String; const contentType: String = ''): String;

var
  Stream: TStringStream;
  _roomerClient: TRoomerHttpClient;

begin
  _roomerClient := CreateRoomerClient(true);
  try
    Stream := TStringStream.Create(Data, TEncoding.UTF8);
    try
      Stream.Position := 0;
      if contentType = '' then
        _roomerClient.contentType := 'application/x-www-form-urlencoded'
      else
        _roomerClient.contentType := contentType;
      try
        Result := String(_roomerClient.Post(AnsiString(url), Stream));
      except
        raise;
      end;
    finally
      Stream.Free;
    end;
  finally
    FreeAndNil(_roomerClient);
  end;
end;

function TRoomerDataSet.PostAsStringAsync(const url, Data: String; const contentType: String = ''): String;

var
  Stream: TStringStream;
  _roomerClient: TRoomerHttpClient;

begin
  _roomerClient := CreateRoomerClient(true);
  try
    Stream := TStringStream.Create(Data, TEncoding.UTF8);
    try
      Stream.Position := 0;
      if contentType = '' then
        _roomerClient.contentType := 'application/x-www-form-urlencoded'
      else
        _roomerClient.contentType := contentType;
      try
        _roomerClient.InternetOptions := _roomerClient.InternetOptions + [wHttpIo_Async];
        try
          Result := string(_roomerClient.Post(AnsiString(url), Stream));
        finally
          _roomerClient.InternetOptions := _roomerClient.InternetOptions - [wHttpIo_Async];
        end;
      except
        raise;
      end;
    finally
      Stream.Free;
    end;
  finally
    FreeAndNil(_roomerClient);
  end;
end;

function TRoomerDataSet.PostStreamAsString(const url: String; Data: TStream; const contentType: String = ''): String;

var
  _roomerClient: TRoomerHttpClient;

begin
  _roomerClient := CreateRoomerClient(true);
  try
    Data.Position := 0;
    if contentType = '' then
      _roomerClient.contentType := '*/*;charset=utf-8'
    else
      _roomerClient.contentType := contentType;
    // for retries := 1 to 3 do
    // begin
    try
      Result := string(_roomerClient.Post(AnsiString(url), Data));
      // Break;
    except
      // if retries = 3 then
      raise;
    end;
    // end;
  finally
    FreeAndNil(_roomerClient);
  end;
end;

function TRoomerDataSet.PutAsString(const url, Data: String; const contentType: String = ''; retryOnError: boolean = true): String;

var
  Stream: TStringStream;
  _roomerClient: TRoomerHttpClient;

begin
  _roomerClient := CreateRoomerClient(true);
  try
    Stream := TStringStream.Create(Data, TEncoding.UTF8);
    try
      Stream.Position := 0;
      if contentType = '' then
        _roomerClient.contentType := 'application/x-www-form-urlencoded'
      else
        _roomerClient.contentType := contentType;
      try
        Result := String(_roomerClient.Put(AnsiString(url), Stream));
      except
        raise;
      end;
    finally
      Stream.Free;
    end;
  finally
    FreeAndNil(_roomerClient);
  end;
end;

function TRoomerDataSet.DeleteAsString(const url: String): String;
var
  _roomerClient: TRoomerHttpClient;
  retries: Integer;
begin
  _roomerClient := CreateRoomerClient(true);
  try
    _roomerClient.contentType := '';
    for retries := 1 to 3 do
    begin
      try
        Result := String(_roomerClient.Delete(AnsiString(url)));
        Break;
      except
        if retries = 3 then
          raise;
      end;
    end;
  finally
    FreeAndNil(_roomerClient);
  end;
end;

function TRoomerDataSet.DownloadFile(aRoomerClient: TRoomerHttpClient; const url, filename: String): boolean;
var
  Stream: TFileStream;
  retries: Integer;
{$IFNDEF USE_INDY}
  aResponseContentHeader: TALHTTPResponseHeader;
{$ENDIF}
begin
{$IFNDEF USE_INDY}
  aResponseContentHeader := TALHTTPResponseHeader.Create;
{$ENDIF}
  Result := false;
  Stream := TFileStream.Create(filename, fmCreate);
  try
    try
      AddAuthenticationHeaders(aRoomerClient);
{$IFDEF USE_INDY}
      aRoomerClient.handleRedirects := true; // Handle redirects
      aRoomerClient.Get(url, Stream);
{$ELSE}
      for retries := 1 to 3 do
      begin
        try
          aRoomerClient.Get(AnsiString(url), Stream, aResponseContentHeader);
          Break;
        except
          if retries = 3 then
            raise;
        end;
      end;
{$ENDIF}
      Result := true;
    except
      Result := false;
    end;
  finally
    Stream.Free;
{$IFNDEF USE_INDY}
    aResponseContentHeader.Free;
{$ENDIF}
  end;
end;

function TRoomerDataSet.UploadFile(aRoomerClient: TRoomerHttpClient; const url, filename: String): boolean;
var
  Stream: TMemoryStream;
  contentType: String;
var
  retries: Integer;
begin
  Result := false;
  Stream := TMemoryStream.Create;
  try
    try
      Stream.LoadFromFile(filename);
      Stream.Position := 0;
      AddAuthenticationHeaders(aRoomerClient);
      if contentType = '' then
        contentType := 'application/octet-stream';
      aRoomerClient.contentType := contentType;
      for retries := 1 to 3 do
      begin
        try
          aRoomerClient.Post(AnsiString(url), Stream);
          Break;
        except
          if retries = 3 then
            raise;
        end;
      end;
      Result := true;
    except
      Result := false;
    end;
  finally
    Stream.Free;
  end;
end;

function TRoomerDataSet.downloadUrlAsString(url: String; loggingInOut: Integer = 0; { 0/1/2 = neither/login/logout }
  SetLastAccess: boolean = true; contentType: String = ''; RaiseException: boolean = false): String;
var
  doRetry: boolean;
begin
  doRetry := true;
  while doRetry do
    try
      doRetry := false;
      Result := GetAsString(url, contentType);
      if SetLastAccess then
        FLastAccess := now;
      exit;
    except
      on E:
{$IFDEF USE_INDY}
        Exception
{$ELSE}
        EALHTTPClientException
{$ENDIF}
        do
      begin
{$IFDEF USE_INDY}
{$ELSE}
        if RaiseException then
          Raise;
        if (E.StatusCode = 0) OR (E.StatusCode = 401) then
        begin
          if (loggingInOut = 0) then
          begin
            DoSessionExpired;
            doRetry := NOT Application.Terminated;
          end
          else if (loggingInOut = 1) then
          begin
            if (E.StatusCode = 401) OR (E.StatusCode = 500) then
              raise Exception.Create('Wrong login credentials provided');
          end
        end
        else
        begin
          if loggingInOut = 1 then
          begin
            if (E.StatusCode = 401) OR (E.StatusCode = 500) then
              raise Exception.Create('Wrong login credentials provided');
          end
          else
{$IFDEF DEBUG}
            ShowMessage('Error when communicating with Roomer backend: ' + inttostr(E.StatusCode) + ' - ' + E.Message);
{$ENDIF}
          raise Exception.Create(format('Error during communication with server (GET): [%d] %s',
            [E.StatusCode, E.Message]));
        end;
{$ENDIF}
      end;
    end;
end;

procedure TRoomerDataSet.SetTimeZoneComparedToUTC(tz: String);
var
  statements: TList<String>;
begin
  statements := TList<String>.Create;
  try
    if tz = '' then
      tz := '(SELECT UTCTimeZoneOffset FROM hotelconfigurations LIMIT 1)'
    else
      tz := '''' + tz + '''';
    statements.add(format('SET time_zone = %s', [tz]));
    SystemFreeExecuteMultiple(statements);
  finally
    statements.Free;
  end;
end;

procedure TRoomerDataSet.DoSessionExpired;
begin
  LoggedIn := false;
  if NOT assigned(FOnSessionExpired) then
    raise Exception.Create('401 - Not allowed. Is the session expired?');
  FOnSessionExpired(self);
end;

function TRoomerDataSet.downloadUrlAsStringUsingPost(url: String; Data: String; SetLastAccess: boolean = true;
  loggingInOut: Integer = 0 { 0/1/2 = neither/login/logout }
  ; contentType: String = ''): String;
var
  doRetry: boolean;
begin
  doRetry := true;
  while doRetry do
    try
      doRetry := false;
      Result := PostAsString(url, Data, contentType);
      if SetLastAccess then
        FLastAccess := now;
      exit;
    except
      on E:
{$IFDEF USE_INDY}
        Exception
{$ELSE}
        EALHTTPClientException
{$ENDIF}
        do
      begin
{$IFDEF USE_INDY}
{$ELSE}
        if (E.StatusCode = 0) OR (E.StatusCode = 401) then
        begin
          if (loggingInOut = 0) then
          begin
            DoSessionExpired;
            doRetry := NOT Application.Terminated;
          end
          else if (loggingInOut = 1) then
          begin
            if (E.StatusCode = 401) OR (E.StatusCode = 500) then
              raise Exception.Create('Wrong login credentials provided');
          end
        end
        else
        begin
          if loggingInOut = 1 then
          begin
            if (E.StatusCode = 401) OR (E.StatusCode = 500) then
              raise Exception.Create('Wrong login credentials provided');
          end
          else
{$IFDEF DEBUG}
            ShowMessage('Error when communicating with Roomer backend: ' + inttostr(E.StatusCode) + ' - ' + E.Message);
{$ENDIF}
          raise Exception.Create(format('Error during communication with server (GET): [%d] %s',
            [E.StatusCode, E.Message]));
        end;
{$ENDIF}
      end;
      on E: Exception do
      begin
        raise Exception.Create(format('Error during communication with server (POST): %s', [E.Message]));
      end;
    end;
end;

function TRoomerDataSet.downloadUrlAsStringUsingPostThreaded(const url: String; const Data: String; SetLastAccess: boolean = true;
  loggingInOut: Integer = 0 { 0/1/2 = neither/login/logout }
  ; const contentType: String = ''): String;
var
  doRetry: boolean;
begin
  doRetry := true;
  while doRetry do
    try
      doRetry := false;
      Result := PostAsString(url, Data, contentType);
      if SetLastAccess then
        FLastAccess := now;
      exit;
    except
      on E:
{$IFDEF USE_INDY}
        Exception
{$ELSE}
        EALHTTPClientException
{$ENDIF}
        do
      begin
        raise Exception.Create(format('Error during communication with server (GET): [%d] %s',
          [E.StatusCode, E.Message]));
      end;
      on E: Exception do
      begin
        raise Exception.Create(format('Error during communication with server (POST): %s', [E.Message]));
      end;
    end;
end;

function TRoomerDataSet.downloadUrlAsStringUsingPostAsync(url: String; Data: String; SetLastAccess: boolean = true;
  loggingInOut: Integer = 0 { 0/1/2 = neither/login/logout }
  ; contentType: String = ''): String;
var
  doRetry: boolean;
begin
  doRetry := true;
  while doRetry do
    try
      doRetry := false;
      Result := PostAsStringAsync(url, Data, contentType);
      if SetLastAccess then
        FLastAccess := now;
      exit;
    except
      on E: EALHTTPClientException do
      begin
        if (E.StatusCode = 0) OR (E.StatusCode = 401) then
        begin
          if (loggingInOut = 0) then
          begin
            DoSessionExpired;
            doRetry := NOT Application.Terminated;
          end
          else if (loggingInOut = 1) then
          begin
            if (E.StatusCode = 401) OR (E.StatusCode = 500) then
              raise Exception.Create('Wrong login credentials provided');
          end
        end
        else
        begin
          if loggingInOut = 1 then
          begin
            if (E.StatusCode = 401) OR (E.StatusCode = 500) then
              raise Exception.Create('Wrong login credentials provided');
          end
          else
{$IFDEF DEBUG}
            ShowMessage('Error when communicating with Roomer backend: ' + inttostr(E.StatusCode) + ' - ' + E.Message);
{$ENDIF}
          raise Exception.Create(format('Error during communication with server (GET): [%d] %s',
            [E.StatusCode, E.Message]));
        end;
      end;
      on E: Exception do
      begin
        raise Exception.Create(format('Error during communication with server (POST): %s', [E.Message]));
      end;
    end;
end;

function TRoomerDataSet.downloadUrlAsStringUsingPut(const url: String; const Data: String; SetLastAccess: boolean = true;
  loggingInOut: Integer = 0 { 0/1/2 = neither/login/logout }
  ; const contentType: String = ''; retryOnError: boolean = true): String;
var
  doRetry: boolean;
begin
  doRetry := true;
  while doRetry do
    try
      doRetry := false;
      Result := PutAsString(url, Data, contentType, retryOnError);
      if SetLastAccess then
        FLastAccess := now;
      exit;
    except
      on E:
{$IFDEF USE_INDY}
        Exception
{$ELSE}
        EALHTTPClientException
{$ENDIF}
        do
      begin
{$IFDEF USE_INDY}
{$ELSE}
        if (E.StatusCode = 0) OR (E.StatusCode = 401) then
        begin
          if (loggingInOut = 0) then
          begin
            DoSessionExpired;
            doRetry := NOT Application.Terminated;
          end
          else if (loggingInOut = 1) then
          begin
            if (E.StatusCode = 401) OR (E.StatusCode = 500) then
              raise Exception.Create('Wrong login credentials provided');
          end
        end
        else
        begin
          if loggingInOut = 1 then
          begin
            if (E.StatusCode = 401) OR (E.StatusCode = 500) then
              raise Exception.Create('Wrong login credentials provided');
          end
          else
{$IFDEF DEBUG}
            ShowMessage('Error when communicating with Roomer backend: ' + inttostr(E.StatusCode) + ' - ' + E.Message);
{$ENDIF}
          raise Exception.Create(format('Error during communication with server (GET): [%d] %s',
            [E.StatusCode, E.Message]));
        end;
{$ENDIF}
      end;
      on E: Exception do
      begin
        raise Exception.Create(format('Error during communication with server (POST): %s', [E.Message]));
      end;
    end;
end;

function TRoomerDataSet.loginViaPost(const url: String; const Data: String; SetLastAccess: boolean = true): String;
begin
  try
    Result := PostAsString(url, Data);
    if SetLastAccess then
      FLastAccess := now;
  except
    on E:
{$IFDEF USE_INDY}
      Exception
{$ELSE}
      EALHTTPClientException
{$ENDIF}
      do
    begin
{$IFDEF USE_INDY}
{$ELSE}
      if (E.StatusCode = 401) then
      begin
        raise Exception.Create('Unknown hotel, username and password combination');
      end
      else if (E.StatusCode DIV 100 = 5) then
      begin
        if POS('UNKNOWN DATABASE', Uppercase(E.Message)) > 0 then
          raise Exception.Create('Unknown hotel, username and password combination')
        else
          raise Exception.Create('Internal Error ' + E.Message);
      end;
      raise;
{$ENDIF}
    end;
  end;
end;

function TRoomerDataSet.PostOpenAPI(url: String; Data: TStream): String;
begin
  Result := PostStreamAsString(url, Data, 'multipart/form-data');
end;

procedure TRoomerDataSet.SetOfflineMode(const Value: boolean);
begin
  FOfflineMode := Value;
end;

procedure TRoomerDataSet.SetOpenApiAuthHeaders(hdrs:
{$IFDEF USE_INDY}TIdHeaderList{$ELSE}TAlHttpRequestHeader{$ENDIF});
begin
  if TRIM(AppKey) = '' then
    exit;

  // hdrs.CustomHeaders.Clear;
  hdrs.CustomHeaders.add(AnsiString(format('%s: %s', [PROMOIR_ROOMER_HOTEL_IDENTIFIER, AppKey])));
  hdrs.CustomHeaders.add(AnsiString(format('%s: %s', [PROMOIR_ROOMER_HOTEL_APPLICATION_ID, ApplicationId])));
  hdrs.CustomHeaders.add(AnsiString(format('%s: %s', [PROMOIR_ROOMER_HOTEL_SECRET, CalculateOTP(AppSecret)])));
end;

procedure TRoomerDataSet.SetSpecificOpenApiAuthHeaders(hdrs: TAlHttpRequestHeader;
  AppKey, ApplicationId, AppSecret: String; tim: Extended);
begin
  if TRIM(AppKey) = '' then
    exit;

  // hdrs.CustomHeaders.Clear;
  hdrs.CustomHeaders.add(AnsiString(format('%s: %s', [PROMOIR_ROOMER_HOTEL_IDENTIFIER, AppKey])));
  hdrs.CustomHeaders.add(AnsiString(format('%s: %s', [PROMOIR_ROOMER_HOTEL_APPLICATION_ID, ApplicationId])));
  hdrs.CustomHeaders.add(AnsiString(format('%s: %s', [PROMOIR_ROOMER_HOTEL_SECRET,
    CalculateOTPOnSpecifiedTime(AppSecret, tim)])));

  // 2a0434bc
  // ORBIS
  // a02da62f9c6f941024e90d5828d9246c096fb5b1286946e1a63b14981d42f55e
  // https://api.roomercloud.net/roomer/openAPI/REST/bookings/roomassignments?roomNumber=004
end;

function TRoomerDataSet.TestSpecificOpenApiAuthHeaders(AppKey, ApplicationId, AppSecret, url: String;
  tim: Extended = 0): String;
begin
  SetSpecificOpenApiAuthHeaders(roomerClient.RequestHeader, AppKey, ApplicationId, AppSecret, tim);
  roomerClient.RequestHeader.AcceptEncoding := 'UTF-8';
  Result := string(roomerClient.Get(AnsiString(url)));
end;

function TRoomerDataSet.OfflineFilesAvailable(_hotelId: String = ''): boolean;
var
  sPath, filePath: String;
begin
  Result := false;
  if (_hotelId = '') AND (hotelId = '') then
    exit;

  if _hotelId = '' then
    _hotelId := hotelId;

  sPath := TPath.Combine(LocalAppDataPath, 'Roomer');
  sPath := TPath.Combine(sPath, format('%s\backup', [_hotelId]));
  filePath := TPath.Combine(sPath, 'Backup_TAXES.src');
  forceDirectories(sPath);

  Result := FileExists(filePath);
end;

(*
  function TRoomerDataSet.GetOpenAPIResourcePath(Endpoint, URI: String): String;
  begin
  // https://dev1.roomerdev.net/openAPI/REST/sdsdsd/sdsdsd/sdsdsd.png
  // 1234567890123456789012345678901234567890123456789012345678901234567890
  // 1        11        21        31        41        51        61
  result := copy(URI, length(Endpoint) + 1, maxInt);
  end;
*)

function TRoomerDataSet.DeleteFileResourceOpenAPI(URI: String): String;
var
  _roomerClient: TRoomerHttpClient;
begin
  _roomerClient := CreateRoomerClient;
  try
    SetOpenApiAuthHeaders(_roomerClient.RequestHeader);
    // _roomerClient.Delete(OpenApiUri + 'staticresources/' + EncodeURIComponent(GetOpenAPIResourcePath(OpenApiUri, URI)));
    _roomerClient.Delete(AnsiString(URI));
    Result := '';
  finally
    FreeAndNil(_roomerClient);
  end;
end;

function TRoomerDataSet.DownloadFileResourceOpenAPI(URI, destFilename: String): boolean;
var
  Stream: TFileStream;
var
  _roomerClient: TRoomerHttpClient;
{$IFNDEF USE_INDY}aResponseContentHeader: TALHTTPResponseHeader; {$ENDIF}
begin
{$IFNDEF USE_INDY}aResponseContentHeader := TALHTTPResponseHeader.Create;
{$ENDIF}
  Result := true;
  _roomerClient := CreateRoomerClient;
  try
    try
      SetOpenApiAuthHeaders(_roomerClient.RequestHeader);
      // SentUri := OpenApiUri + Path + '/' + EncodeURIComponent(Filename);
      Stream := TFileStream.Create(destFilename, fmCreate);
      try
{$IFDEF USE_INDY}
        _roomerClient.handleRedirects := true; // Handle redirects
        _roomerClient.Get(URI, Stream);
{$ELSE}
        _roomerClient.Get(AnsiString(URI), Stream, aResponseContentHeader);
{$ENDIF}
      finally
        Stream.Free;
      end;
    except
      Result := false;
      raise;
    end;
  finally
    FreeAndNil(_roomerClient);
  end;
  // result := PostStreamAsString(activeRoomerDataSet.roomerClient, Url, Data, 'multipart/form-data');
end;

function TRoomerDataSet.PostFileOpenAPI(url: String; filename, keyString: String; FileType: String;
  privateResource: boolean = true): String;
var
  multi: TRoomerMultipartFormData;
  http: TIdHTTP;
  privRes: String;
  IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
begin
  multi := TRoomerMultipartFormData.Create;
  try
    multi.AddFile(extractFilename(filename), filename, FileType);

    if privateResource then
      privRes := 'true'
    else
      privRes := 'false';

    IdSSLIOHandlerSocketOpenSSL1 := nil;
    http := TIdHTTP.Create(nil);
    try
      if LowerCase(Copy(OpenApiUri, 1, 8)) = 'https://' then
      begin
        IdSSLIOHandlerSocketOpenSSL1 := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
        http.IOHandler := IdSSLIOHandlerSocketOpenSSL1;
      end;

      http.Request.CustomHeaders.AddValue(PROMOIR_ROOMER_HOTEL_IDENTIFIER, AppKey);
      http.Request.CustomHeaders.AddValue(PROMOIR_ROOMER_HOTEL_APPLICATION_ID, ApplicationId);
      http.Request.CustomHeaders.AddValue(PROMOIR_ROOMER_HOTEL_SECRET, CalculateOTP(AppSecret));
      http.Request.CustomHeaders.AddValue(PROMOIR_ROOMER_HOTEL_ADD_PRIVATE_RESOURCES, privRes);
      Result := http.Post(OpenApiUri + url + '/' + keyString, multi);
    finally
      IdSSLIOHandlerSocketOpenSSL1.Free;
      http.Free;
    end;
  finally
    multi.Free;
  end;
  // result := PostStreamAsString(activeRoomerDataSet.roomerClient, Url, Data, 'multipart/form-data');
end;

function TRoomerDataSet.SendConfirmationEmailOpenAPI(Reservation: Integer): String;
var
  http: TIdHTTP;
  url: String;
  Stream: TStringStream;
  IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
begin
  IdSSLIOHandlerSocketOpenSSL1 := nil;
  http := TIdHTTP.Create(nil);
  try
    if LowerCase(Copy(OpenApiUri, 1, 8)) = 'https://' then
    begin
      IdSSLIOHandlerSocketOpenSSL1 := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
      http.IOHandler := IdSSLIOHandlerSocketOpenSSL1;
    end;

    http.Request.CustomHeaders.AddValue(PROMOIR_ROOMER_HOTEL_IDENTIFIER, AppKey);
    http.Request.CustomHeaders.AddValue(PROMOIR_ROOMER_HOTEL_APPLICATION_ID, ApplicationId);
    http.Request.CustomHeaders.AddValue(PROMOIR_ROOMER_HOTEL_SECRET, CalculateOTP(AppSecret));

    url := format(OpenApiUri + 'bookings/%d?confirmedToGuest=true', [Reservation]);

    Stream := TStringStream.Create;
    try
      Result := http.Put(url, Stream);
    finally
      Stream.Free;
    end;
  finally
    IdSSLIOHandlerSocketOpenSSL1.Free;
    http.Free;
  end;
end;

function TRoomerDataSet.SendEmailOpenAPI(subject: UTF8String; from, recipient, cc, bcc: String;
  _text, _htmlText: UTF8String; files: TStringList): String;
var
  multi: TIdMultipartFormDataStream;
  http: TIdHTTP;
  i: Integer;
  filename, filePath: String;

  att: TIdFormDataField;
  IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
  contType : String;
begin
  multi := TIdMultipartFormDataStream.Create;
  try
    for i := 0 to files.Count - 1 do
    begin
      filename := Copy(files[i], POS('=', files[i]) + 1, maxint);
      filePath := Copy(files[i], 1, POS('=', files[i]) - 1);
      contType := '';
//      contType := GetMIMEtype(filename);
//      if LENGTH(contType) < 4 then
//        contType := 'application/' + copy(LowerCase(ExtractFileExt(Filename)), 2, maxint);
      att := multi.AddFile('attachment', filePath, contType);
      att.filename := extractFilename(filename);
    end;

    multi.AddFormField('to', recipient, 'UTF-8');
    if TRIM(cc) <> '' then
      multi.AddFormField('cc', cc, 'UTF-8');
    if TRIM(bcc) <> '' then
      multi.AddFormField('bcc', bcc, 'UTF-8');
    multi.AddFormField('from', from, 'UTF-8');
    multi.AddFormField('subject', subject, 'UTF-8');

    multi.AddFormField('plaintext', _text, 'UTF-8', 'text/plain', 'emailText.txt');
    multi.AddFormField('htmltext', _htmlText, 'UTF-8', 'text/html', 'htmlText.html');

    IdSSLIOHandlerSocketOpenSSL1 := nil;
    http := TIdHTTP.Create(nil);
    try
      if LowerCase(Copy(OpenApiUri, 1, 8)) = 'https://' then
      begin
        IdSSLIOHandlerSocketOpenSSL1 := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
        http.IOHandler := IdSSLIOHandlerSocketOpenSSL1;
      end;
      http.Request.CustomHeaders.AddValue(PROMOIR_ROOMER_HOTEL_IDENTIFIER, AppKey);
      http.Request.CustomHeaders.AddValue(PROMOIR_ROOMER_HOTEL_APPLICATION_ID, ApplicationId);
      http.Request.CustomHeaders.AddValue(PROMOIR_ROOMER_HOTEL_SECRET, CalculateOTP(AppSecret));

      Result := http.Post(OpenApiUri + 'hotelservices/email', multi);
    finally
      IdSSLIOHandlerSocketOpenSSL1.Free;
      http.Free;
    end;
  finally
    multi.Free;
  end;
  // result := PostStreamAsString(activeRoomerDataSet.roomerClient, Url, Data, 'multipart/form-data');
end;

procedure TRoomerDataSet.GetFieldText(Sender: TField; var Text: string; DisplayText: boolean);
begin
  Text := StringReplace(Sender.AsString, #10, #13#10, [rfReplaceAll]);
end;

procedure TRoomerDataSet.OpenDatasetFromUrlAsString(aEndPoint: String; SetLastAccess: boolean = true; loggingInOut: Integer = 0;contentType: String = '');
begin
  OpenDataset(downloadUrlAsString(RoomerUri + aEndPoint, loggingInOut,SetLastAccess, contentType, False));
end;

procedure TRoomerDataSet.OpenDataset(const SqlResult: String);
var
  i: Integer;
begin
  if (SqlResult = '') then
    exit;

  try
    FSavedLastResult := SqlResult;
    FSavedResult := XMLToRecordset(SqlResult);
    Close;
    CommandType := cmdFile;
    LockType := ltBatchOptimistic;
    // CommandText := '';
    Recordset := ADOInt._Recordset(FSavedResult);

    for i := 0 to FieldCount - 1 do
      if Fields[i].DataType IN [ftString, ftWideString, ftWideMemo] then
        Fields[i].OnGetText := GetFieldText;

    if not(BOF and EOF) then
    begin
      First;
    end;
  except
    on E: Exception do
    begin
{$IFDEF DEBUG}
      CopyToClipboard(FLastSql + #13#10#13#10 + '-- ' + SqlResult + #13 + CommandText);
      DebugMessage(E.Message);
{$ENDIF}
      raise;
    end;
  end;
end;

procedure TRoomerDataSet.Post;

  procedure UpdateData;
  var
    i: Integer;
    FieldData: PVariantList;
    Data: Variant;
  begin
    try
      FieldData := PVariantList(PByte(ActiveBuffer) + SizeOf(TRecInfo));
      for i := 0 to Fields.Count - 1 do
        if TField(Fields[i]).OldValue <> TField(Fields[i]).NewValue then
        begin
          Data := Unassigned;
          Data := FieldData[TField(Fields[i]).index];
          if not VarIsClear(Data) then
            Recordset.Fields[TField(Fields[i]).FieldNo - 1].Value := Data;
        end;
      ReleaseLock;
    except
      CursorPosChanged;
      Recordset.CancelUpdate;
      raise;
    end;
  end;

  procedure GlueToRecordSet;
  begin
    DataEvent(deCheckBrowseMode, 0);
    DoBeforePost;
    UpdateData;
    FreeFieldBuffers;
    SetState(dsBrowse);
    Resync([]);
    DoAfterPost;
  end;

  procedure CollectTablesToSubmit(list: TList<String>);
  var
    i: Integer;
    tableName: String;
  begin
    for i := 0 to Recordset.Fields.Count - 1 do
    begin
      tableName := Recordset.Fields[i].Properties['BASETABLENAME'].Value;
      if NOT list.Contains(tableName) then
        list.add(tableName);
    end;
  end;

  procedure PerformUpdate(aTableName: String; aSql: String);
  begin
    if aSql <> '' then
    begin
      aSql := format('UPDATE %s SET %s WHERE id=%d', [aTableName, aSql, FieldByName('id').AsInteger]);
      self.activeRoomerDataSet.SystemFreeExecute(aSql);
      GlueToRecordSet;
    end;
  end;

  procedure UpdateTable(table: String);
  var
    lSql: String;
    fieldName, fieldValue, tableName: String;
    Field: TField;
    i, iFieldSize: Integer;

  begin
    lSql := '';
    for i := 0 to Recordset.Fields.Count - 1 do
    begin
      tableName := Recordset.Fields[i].Properties['BASETABLENAME'].Value;
      if table = tableName then
      begin
        fieldName := Recordset.Fields[i].Properties['BASECOLUMNNAME'].Value;
        Field := FieldByName(Recordset.Fields[i].Name);
        if Field.OldValue <> Field.NewValue then
        begin
          iFieldSize := Recordset.Fields[i].DefinedSize;
          fieldValue := ProvideFieldValue(Field, iFieldSize);
          if fieldValue <> '' then
          begin
            if lSql = '' then
              lSql := format('%s=%s', [fieldName, fieldValue])
            else
              lSql := lSql + format(',%s=%s', [fieldName, fieldValue]);
          end;
        end;
      end;
    end;
    PerformUpdate(table, lSql);
  end;

  procedure PerformInsert(aTableName: String; aFields, aSql: String);
  begin
    if aSql <> '' then
    begin
      aSql := format('INSERT INTO %s (%s) VALUES(%s)', [LowerCase(aTableName), aFields, aSql]);
      self.activeRoomerDataSet.SystemFreeExecute(aSql);
      GlueToRecordSet;
    end;
  end;

  procedure InsertTable(table: String);
  var
    sFields, lSql: String;
    fieldName, fieldValue, tableName: String;
    Field: TField;
    i, iFieldSize: Integer;
  begin
    lSql := '';
    sFields := '';
    for i := 0 to Recordset.Fields.Count - 1 do
    begin
      tableName := Recordset.Fields[i].Properties['BASETABLENAME'].Value;
      if table = tableName then
      begin
        fieldName := Recordset.Fields[i].Properties['BASECOLUMNNAME'].Value;
        Field := FieldByName(Recordset.Fields[i].Name);
        iFieldSize := Recordset.Fields[i].DefinedSize;
        fieldValue := ProvideFieldValue(Field, iFieldSize);
        if fieldValue <> '' then
        begin
          if sFields = '' then
            sFields := format('%s', [fieldName])
          else
            sFields := sFields + format(',%s', [fieldName]);

          if lSql = '' then
            lSql := format('%s', [fieldValue])
          else
            lSql := lSql + format(',%s', [fieldValue]);
        end;
      end;
    end;
    PerformInsert(table, sFields, lSql);
  end;

var
  tables: TList<String>;
  i: Integer;
begin
  if OfflineMode then
  begin
    try
      inherited Post;
    except
    end;
    exit;
  end;

  UpdateRecord;
  case State of
    dsEdit, dsInsert:
      begin
        tables := TList<String>.Create;
        CollectTablesToSubmit(tables);
        try
          for i := 0 to tables.Count - 1 do
          begin
            if State = dsInsert then
              InsertTable(tables[i])
            else
              UpdateTable(tables[i]);
          end;
        finally
          tables.Clear;
          tables.Free;
        end;
      end;
  end;

end;

procedure TRoomerDataSet.AssignToDataset(SqlResult: String; DataSet: TRoomerDataSet);
begin
  FSavedLastResult := SqlResult;
  DataSet.Close;
  DataSet.CommandType := cmdFile;
  DataSet.LockType := ltBatchOptimistic;
  DataSet.CommandText := '';
  DataSet.Recordset := ADOInt._Recordset(SqlResult);
  if not(BOF and EOF) then
    First;
end;

function TRoomerDataSet.DoCommand(aSql: String; async: boolean = false): Integer;
var
  sResult: String;
begin
  if async then
    sResult := self.activeRoomerDataSet.SystemFreeExecuteAsync(aSql)
  else
    sResult := self.activeRoomerDataSet.SystemFreeExecute(aSql);
  Result := StrToIntDef(sResult, -99999999);
  if Result <= 0 then
  begin
    if Result = -99999999 then
    begin
{$IFDEF DEBUG}
      CopyToClipboard(aSql + #13#10#13#10 + '-- ' + sResult);
{$ENDIF}
      raise Exception.Create('command execution failed:' + sResult);
    end;
  end;
  FNumberOfAffectedRows := Result;
end;

procedure TRoomerDataSet.DoQuery(aSql: String);
begin
  OpenDataset(queryRoomer(aSql));
end;

function TRoomerDataSet.GetCommandText: String;
begin
  Result := Sql.Text;
end;

function SystemDecimalSeparator: string;
var
  Decimal: PChar;
begin
  Decimal := StrAlloc(10);
  GetLocaleInfo(LOCALE_SYSTEM_DEFAULT, LOCALE_SDECIMAL, Decimal, 10);
  Result := String(Decimal)[1];
end;

function TRoomerDataSet.GetFloatValue(Field: TField): Double;
begin
  Result := LocalizedFloatValue(Field.Value);
end;

function TRoomerDataSet.getHotelsList: THotelsEntityList;
begin
  Result := hotelsList;
end;

function TRoomerDataSet.Login(hotelId: String; username, password: String; appName: String; appVersion: String;
  RightRangeMin: Integer = 90; RightRangeMax: Integer = 100): boolean;
var
  pwmd5: AnsiString;
  res: String;
begin
  Result := true;
  FUsername := username;
  FPassword := password;
  FAppName := appName;
  FAppVersion := appVersion;
  FHotelId := hotelId;
  pwmd5 := AnsiString(HashedPassword(password));

  res := loginViaPost(RoomerUri + 'authentication/login',
    format('hotelid=%s&username=%s&pwencoded=%s&appname=%s&appversion=%s&datasettype=0&extraBuild=%s',
    [hotelId, username, pwmd5, appName, appVersion, EXTRA_BUILD_ID]));
  SetSessionLengthInSeconds(res);
  FLastAccess := now;
  FLoggedIn := true;
end;

function TRoomerDataSet.SwapHotel(hotelId: String; var username, password: String): boolean;
// var
// res: String;
begin
  Result := Login(hotelId, FUsername, FPassword, FAppName, FAppVersion);
  if Result then
  begin
    username := FUsername;
    password := FPassword;
  end;
  // result := true;
  // FHotelId := hotelId;
  //
  // res := downloadUrlAsString(RoomerUri + format('authentication/swaphotels?hotelid=%s', [hotelId]), 0, true);
  // SetSessionLengthInSeconds(res);
  // FLastAccess := now;
end;

function TRoomerDataSet.HashedPassword(password: String): String;
begin
  Result := md5(password);
end;

function TRoomerDataSet.HeadOfURI(URI: String): TALHTTPResponseHeader;
var
  _roomerClient: TRoomerHttpClient;
  ResponseContentStream: TMemoryStream;
  ResponseContentHeader: TALHTTPResponseHeader;
begin
  _roomerClient := CreateRoomerClient;
  try
    SetOpenApiAuthHeaders(_roomerClient.RequestHeader);
    // _roomerClient.Delete(OpenApiUri + 'staticresources/' + EncodeURIComponent(GetOpenAPIResourcePath(OpenApiUri, URI)));
    ResponseContentStream := TMemoryStream.Create;
    ResponseContentHeader := TALHTTPResponseHeader.Create;
    _roomerClient.Head(AnsiString(URI), ResponseContentStream, ResponseContentHeader);
    Result := ResponseContentHeader;
  finally
    FreeAndNil(_roomerClient);
  end;
end;

procedure TRoomerDataSet.Logout;
begin
  FLoggedIn := false;
  try
    downloadUrlAsString(RoomerUri + 'logout', 2, false);
  except
  end;
  AppKey := '';
end;

procedure TRoomerDataSet.LogoutUnaffected;
begin
  FLoggedIn := false;
  try
    roomerClient.Get(AnsiString(RoomerUri + 'logout'));
  except
  end;
  AppKey := '';
end;

function TRoomerDataSet.MyIpAddress: String;
begin
  Result := downloadUrlAsString(RoomerUri + 'authentication/myipaddress');
end;

function TRoomerDataSet.SyncFinanceTables: String;
begin
  Result := downloadUrlAsString(RoomerUri + 'financekeys/reset');
end;

procedure TRoomerDataSet.SetSessionLengthInSeconds(const xmlSource: String);
var
  xml: IXMLDOMDocument2;
  xmlTemp: IXMLDOMNodeList;
  xmlHotel: IXMLDomNode;
  i: Integer;
begin
  xml := CreateXmlDocument;
  xml.LoadXML(xmlSource);
  FSessionLengthSeconds := strtoint(GetAttributeValue(xml.documentElement.firstChild, 'sessionTimoutSeconds', '450'));

  hotelsList.Clear;
  xmlTemp := xml.selectNodes('//authentication/user/hotels/hotel');
  // xmlTemp := xmlHotels.item[0].getElementsByTagName('hotel');
  for i := 0 to xmlTemp.length - 1 do
  begin
    xmlHotel := xmlTemp.item[i];
    if xmlHotel.nodeName = 'hotel' then
    begin
      hotelsList.add(TRoomerHotelsEntity.Create(GetAttributeValue(xmlHotel, 'hotelCode', hotelId),
        GetAttributeValue(xmlHotel, 'hotelName', hotelId), strtoint(GetAttributeValue(xmlHotel, 'ownerID', '0'))));
    end;
  end;
end;


function TRoomerDataSet.SecondsLeft: Integer;
begin
  Result := SecondsBetween(IncSecond(FLastAccess, FSessionLengthSeconds), now);
end;

procedure TRoomerDataSet.SetCommandText(const Value: String);
begin
  Sql.Text := Value;
end;

procedure TRoomerDataSet.SetCommandType(const Value: TCommandType);
begin
  FCommandType := Value;
end;

{$I RoomerDBMethodsImplementations.inc}

function TRoomerDataSet.ActivateNewDataset(const SqlResult: String): TRoomerDataSet;
begin
  Result := CreateNewDataset;
  Result.OpenDataset(SqlResult);
  // AssignToDataset(SqlResult, result);
end;

// **********************************************************************

procedure TRoomerDataSet.SetDataActive(const Value: boolean);
begin
  FDataActive := Value;
  if FDataActive then
  begin
    Open;
  end;
end;

procedure TRoomerDataSet.SetOpenApiUri(const Value: String);
begin
  FOpenApiUri := Value;
end;

function TRoomerDataSet.GetUri: String;
begin
  Result := FUri;
end;

procedure TRoomerDataSet.SetUri(const Value: String);
begin
  FUri := Value;
end;

function locationName(locationId: word): String;
begin
  if locationId = ftTemplate then
    Result := 'templates'
  else if locationId = ftImage then
    Result := 'images'
  else if locationId = ftDocument then
    Result := 'contracts'
  else if locationId = ftSystem then
    Result := 'system'
  else
    Result := 'templates';
end;

function TRoomerDataSet.SystemDeleteFile(FileType: word; filename: String): boolean;
begin
  try
    GetAsString(FStoreUri + format('store/delete?hotelId=%s&filename=%s&location=%s',
      [FHotelId, EncodeURIComponent(extractFilename(filename)), locationName(FileType)]));
    Result := true;
  except
    Result := false;
  end;
end;

function TRoomerDataSet.SystemRenameFile(FileType: word; filename, newFilename: String): boolean;
begin
  try
    GetAsString(FStoreUri + format('store/rename?hotelId=%s&filename=%s&newname=%s&location=%s',
      [FHotelId, EncodeURIComponent(extractFilename(filename)), EncodeURIComponent(extractFilename(newFilename)),
      locationName(FileType)]));
    Result := true;
  except
    Result := false;
  end;
end;

function TRoomerDataSet.SystemDownloadFile(FileType: word; sourceFilename, destFilename: String): boolean;
begin
  Result := DownloadFile(roomerClient, FStoreUri + format('store/get?hotelId=%s&filename=%s&location=%s',
    [FHotelId, extractFilename(sourceFilename), locationName(FileType)]), destFilename);
end;

function TRoomerDataSet.SystemDownloadFileFromURI(URI, filename: String): boolean;
begin
  Result := DownloadFile(roomerClient, URI, filename);
end;

function TRoomerDataSet.SystemDownloadRoomerFile(sourceFilename, destFilename: String): boolean;
begin
  Result := DownloadFile(roomerClient, FStoreUri + format('store/roomer/%s', [extractFilename(sourceFilename)]),
    destFilename);
end;

function TRoomerDataSet.SystemDownloadRoomerBackup(destFilename: String): boolean;
begin
  Result := DownloadFile(roomerClient, FUri + 'pms/business/backup', destFilename);
end;

function TRoomerDataSet.SystemRoomerFile(filename: String): TFileEntity;
var
  fileList: TFileList;
begin
  try
    fileList := TFileList.Create(String(GetAsString(FStoreUri + format('store/roomerinfo?hotelId=%s&filename=%s',
      [FHotelId, filename]))));
    if fileList.Count > 0 then
      Result := fileList.files[0]
    else
      Result := nil;
  except
    Result := nil;
  end;
end;

function TRoomerDataSet.SystemFileExists(FileType: word; filename: String): boolean;
var
  s: String;
begin
  s := String(GetAsString(FStoreUri + format('store/exists?hotelId=%s&location=%s&filename=%s',
    [FHotelId, locationName(FileType), extractFilename(filename)])));
  Result := LowerCase(s) = 'true';
end;

function TRoomerDataSet.SystemListFiles(FileType: word): TFileList;
var
  s: String;
begin
  s := GetAsString(FStoreUri + format('store/list?hotelId=%s&location=%s', [FHotelId, locationName(FileType)]));
  Result := TFileList.Create(s); // SplitStringToTStrings(#10, s);
end;

function TRoomerDataSet.SystemUploadFile(filename: String; FileType: word; includeLastModified: boolean = true)
  : boolean;
var
  DateOfFile: TDateTime;
  sTimeStamp: String;
begin
  sTimeStamp := '';
  if includeLastModified then
  begin
    FileAge(filename, DateOfFile);
    sTimeStamp := format('&timestamp=%s', [dateToJsonString(DateOfFile)]);
  end;

  Result := UploadFile(roomerClient, FStoreUri + format('store/save?hotelId=%s&filename=%s&location=%s%s',
    [FHotelId, extractFilename(filename), locationName(FileType), sTimeStamp]), filename);
end;

function TRoomerDataSet.SplitMultipleResultIntoDatasets(res: String): TList<TRoomerDataSet>;
var
  list: TStrings;
  i: Integer;
  ds: TRoomerDataSet;
begin
  list := SplitStringToTStrings(ROOMER_SPLIT, res);
  try
    Result := TList<TRoomerDataSet>.Create;
    for i := 0 to list.Count - 1 do
    begin
      if list[i] <> '' then
      begin
        ds := CreateNewDataset;
        ds.OpenDataset(list[i]);
        Result.add(ds);
      end;
    end;
  finally
    list.Free;
  end;
end;

procedure TRoomerDataSet.SystemPrepareChannelRates;
begin
  downloadUrlAsString(RoomerUri + 'pms/business/prepareChannelRates');
end;

function TRoomerDataSet.ProvideFieldValue(Field: TField; iMaxSize: Integer): String;
var
  str: String;
begin
  if Field.Value = null then
    Result := ''
  else
    case Field.DataType of
      ftString, ftFixedChar, ftWideString, ftVariant, ftFixedWideChar, ftMemo, ftWideMemo:
        begin
          if iMaxSize > 0 then
            str := Copy(Field.Value, 1, iMaxSize)
          else
            str := Field.Value;
          Result := format('''%s''', [StringReplace(str, '''', '\''', [rfReplaceAll])]);
        end;
      ftSmallint, ftInteger, ftWord, ftLargeint, ftLongWord, ftShortint, ftByte, ftExtended, ftSingle:
        Result := Field.Value;
      ftBoolean:
        Result := inttostr(ord(Field.AsBoolean));
      ftFloat, ftCurrency:
        Result := uStringUtils.FloatToDBString(Field.Value);
      ftDate:
        Result := format('''%s''', [FormatDateTime('yyyy-mm-dd', Field.AsDateTime)]);
      ftTime:
        Result := format('''%s''', [FormatDateTime('hh:nn:ss', Field.AsDateTime)]);
      ftDateTime:
        Result := format('''%s''', [FormatDateTime('yyyy-mm-dd hh:nn:ss', Field.AsDateTime)]);
      ftAutoInc:
        Result := '';

    else
      Result := format('''%s''', [Field.Value]);
    end;
end;

{ TRoomerPlanEntity }

constructor TRoomerPlanEntity.Create(_planType: Integer; _sql: String);
begin
  inherited Create;
  PlanType := _planType;
  Sql := _sql;
end;

{ TRoomerExecutionPlan }

function TRoomerExecutionPlan.AddExec(aSql: String): Integer;
begin
  Result := sqlList.add(TRoomerPlanEntity.Create(ptExec, aSql));
end;

function TRoomerExecutionPlan.AddQuery(aSql: String): Integer;
begin
  Result := sqlList.add(TRoomerPlanEntity.Create(ptQuery, aSql));
end;

procedure TRoomerExecutionPlan.BeginTransaction;
begin
  if FInTransaction then
    raise ERoomerExecutionPlanException.Create('Nested transactions not allowed');
  FRoomerDataSet.SystemStartTransaction;
  FInTransaction := true;
end;

procedure TRoomerExecutionPlan.Clear;
begin
  sqlList.Clear;
  queryResults.Clear;
end;

procedure TRoomerExecutionPlan.CommitTransaction;
begin
  FRoomerDataSet.SystemCommitTransaction;
  FInTransaction := false;
end;

constructor TRoomerExecutionPlan.Create(_RoomerDataSet: TRoomerDataSet = nil);
begin
  inherited Create;
  queryResults := TRoomerDatasetList.Create(true);
  sqlList := TRoomerPlanEntityList.Create(true);
  FRoomerDataSet := _RoomerDataSet;
end;

destructor TRoomerExecutionPlan.Destroy;
begin
  if FInTransaction then
    try
      CommitTransaction;
    except
      if FInTransaction then
        RollbackTransaction;
    end;
  FRoomerDataSet := nil;
  queryResults.Free;
  sqlList.Free;
  inherited;
end;

function TRoomerExecutionPlan.Execute(PlanType: Integer = ptAll; transaction: boolean = false;
  performRollBackOnException: boolean = false): boolean;
var
  i: Integer;
  res: String;
  lSQLList: TList<string>;
begin
  if transaction then
    BeginTransaction;
  try
    if PlanType = ptQuery then
    begin
      for i := 0 to QueryCount - 1 do
        queryResults.add(FRoomerDataSet.CreateNewDataset);

      lSQLList := getSqlsAsTList(PlanType);
      try
        res := RoomerDataSet.SystemFreeMultipleQuery(queryResults, lSQLList);
      finally
        lSQLList.Free;
      end;

    end
    else if PlanType = ptExec then
    begin
      lSQLList := getSqlsAsTList(PlanType);
      try
        res := RoomerDataSet.SystemFreeExecuteMultiple(lSQLList);
      finally
        lSQLList.Free;
      end;
    end;

    if transaction then
      CommitTransaction;
    Result := true;
  except
    on E: Exception do
    begin
      FExecException := E.Message;
      if transaction OR performRollBackOnException then
        RollbackTransaction;
      Result := false;
    end;
  end;
end;

function TRoomerExecutionPlan.GetCount: Integer;
begin
  Result := sqlList.Count;
end;

function TRoomerExecutionPlan.GetExecCount: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to sqlList.Count - 1 do
    if sqlList[i].PlanType = ptExec then
      inc(Result);
end;

function TRoomerExecutionPlan.GetQueryCount: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to sqlList.Count - 1 do
    if sqlList[i].PlanType = ptQuery then
      inc(Result);
end;

function TRoomerExecutionPlan.GetResultRoomerDataSet(index: Integer): TRoomerDataSet;
begin
  Result := queryResults[index];
end;

function TRoomerExecutionPlan.getSqlsAsTList(PlanType: Integer): TList<String>;
var
  i: Integer;
begin
  Result := TList<String>.Create;
  for i := 0 to sqlList.Count - 1 do
    if sqlList[i].PlanType = PlanType then
      Result.add(sqlList[i].Sql);
end;

procedure TRoomerExecutionPlan.RollbackTransaction;
begin
  FRoomerDataSet.SystemRollbackTransaction;
  FInTransaction := false;
end;

{ TRoomerHotelsEntity }

constructor TRoomerHotelsEntity.Create(_hotelCode, _hotelName: String; _ownerId: Integer);
begin
  hotelCode := _hotelCode;
  hotelName := _hotelName;
  ownerId := _ownerId;
end;

//var
//  recVer: TEXEVersionData;
//
initialization

begin
//  recVer := _GetEXEVersionData(Paramstr(0));
//  EXTRA_BUILD_ID := recVer.ExtraBuild;
end;

end.
