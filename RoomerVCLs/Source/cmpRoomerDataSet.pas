unit cmpRoomerDataSet;

interface

{$include roomer.inc}

uses
  WinApi.Windows,
  WinInet,
  Vcl.Forms,
  System.SysUtils,

  System.Classes,
  Data.DB,
  Data.Win.ADODB,
  ADOInt,
  Web.HTTPApp,
  Variants,
  uAPIDataHandler,
  RoomerMultipartFormData,
  {.$.IFDEF USE_INDY}
  IdBaseComponent,
  IdHeaderList,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdGlobal,
  IdHTTP,
  IdIOHandler,
  IdIOHandlerSocket,
  IdIOHandlerStack,
  {.$.ELSE}
  ALWininetHttpClient,
  AlHttpCommon,
  ALHttpClient,
  {.$.ENDIF}
  MSXML2_TLB,
  IdSSL,
  IdSSLOpenSSL,
  RoomerCloudEntities,
  Generics.Collections,
  Vcl.Dialogs,
  ActiveX,
  DateUtils,
  uStringUtils;

const
  ftTemplate = $0000;
  ftImage = $0001;
  ftDocument = $0002;
  ftSystem = $0003;

  ptAll = $0000;
  ptExec = $0001;
  ptQuery = $0002;

type

  TRoomerDataSet = class;
  TRoomerDatasetList = TObjectList<TRoomerDataset>;

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

  TRoomerPlanEntityList = TObjectlist<TRoomerPlanEntity>;

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

    function Execute(PlanType: Integer = ptAll; transaction: Boolean = false;
      performRollBackOnException: Boolean = false): Boolean;

    property Results[index: Integer]: TRoomerDataSet
      read GetResultRoomerDataSet;
    property RoomerDataSet: TRoomerDataSet read FRoomerDataSet
      write FRoomerDataSet;
    property QueryCount: Integer read GetQueryCount;
    property ExecCount: Integer read GetExecCount;
    property Count: Integer read GetCount;
    property ExecException: String read FExecException;
  end;

  THotelsEntityList =  TObjectList<TRoomerHotelsEntity>;

  TRoomerDataSet = class(TADODataSet)
  private
    FRoomerDataSet: TRoomerDataSet;
    { Private declarations }
    FSavedLastResult: String;
    FSavedResult: _Recordset;
    FUri: String;
    FSql: TStringList;
    FDataActive: Boolean;
    FOpenApiUri: String;
    FRoomerEntitiesUri: String;
    FRoomerDatasetsUri: String;
    FOnSessionExpired: TNotifyEvent;

    FroomerClient: {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF};
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
    FOfflineMode: Boolean;
    FLoggedIn: Boolean;
    function GetCommandText: String;
    procedure SetCommandText(const Value: String);
    procedure SetCommandType(const Value: TCommandType);
    function GetUri: String;
    procedure SetUri(const Value: String);
    procedure SetDataActive(const Value: Boolean);
    function ProvideFieldValue(Field: TField; iMaxSize : Integer): String;
    procedure SetSessionLengthInSeconds(xmlSource: String);
    procedure GetFieldText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    function loginViaPost(url, Data: String;
      SetLastAccess: Boolean = true): String;
    function getHotelsList: THotelsEntityList;
    procedure SetAuthHeaders(hdrs:
      {$IFDEF USE_INDY}TIdHeaderList{$ELSE}TAlHttpRequestHeader{$ENDIF};
      hotel, user, password: String);

    function GetAsString(roomerClient:
      {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF}
      ; url: String; contentType: String = ''; force : Boolean = False): String;

    function PostAsString(roomerClient:
      {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF}
      ; url, Data: String; contentType: String = ''): String;
    function PostAsStringAsync(roomerClient:
      {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF}
      ; url, Data: String; contentType: String = ''): String;
    function DownloadFile(roomerClient:
      {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF}
      ; url, filename: String): Boolean;
    procedure AddAuthenticationHeaders(roomerClient:
      {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF}
      );
    function UploadFile(roomerClient:
      {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF}
      ; url, filename: String): Boolean;
//    function GetAsJSON(roomerClient:
//      {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF}
//      ; url: String): String;
    function PostAsJSON(roomerClient:
      {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF}
      ; url, Data: String): String;
    function PutAsJSON(roomerClient:
      {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF}
      ; url, Data: String): String;
    function CreateRoomerClient:
    {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF};
    function DeleteAsString(roomerClient:
      {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF}
      ; url: String): String;
    function GetOpenApiUri: String;
    procedure SetOpenApiUri(const Value: String);
    function downloadUrlAsStringUsingPut(url: String; Data: String;
      SetLastAccess: Boolean = true;
      loggingInOut: Integer = 0 { 0/1/2 = neither/login/logout }
      ; contentType: String = ''
      ; retryOnError : Boolean = true): String;
    function PutAsString(roomerClient:
      {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF}
      ; url, Data: String; contentType: String = ''
      ; retryOnError : Boolean = true): String;
    function PostStreamAsString(roomerClient:
      {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF}
      ; url: String; Data: TStream; contentType: String = ''): String;
    procedure SetOpenApiAuthHeaders(hdrs:
      {$IFDEF USE_INDY}TIdHeaderList{$ELSE}TAlHttpRequestHeader{$ENDIF});
//    function GetOpenAPIResourcePath(Endpoint, URI: String): String;
    procedure SetOfflineMode(const Value: Boolean);
    procedure AssertOnlineMode(param : TRoomerOfflineAssertonParameter = roapGet; aSql : String = '');
    function GetFilenameFromParameter(param : TRoomerOfflineAssertonParameter) : String;
    function GetParameterTypeName(param: TRoomerOfflineAssertonParameter): String;
    procedure DoSessionExpired;
    procedure SetSpecificOpenApiAuthHeaders(hdrs: TAlHttpRequestHeader; AppKey, ApplicationId, AppSecret: String; tim : Extended);
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
    function GetFloatValue(Field: TField): Double;
    procedure Post; override;
    procedure OpenDataset(SqlResult: String);
    procedure DoQuery(aSql: String);
    function DoCommand(aSql: String; async : Boolean = false): Integer;
    procedure Open(doLowerCase: Boolean = true; setLastAccess: Boolean = true);
    procedure GetMessages;
    procedure GetTableUpdateTimeStamps;

    function PutData(url, Data : String) : String;
    function PostData(url, Data : String) : String;
    function DeleteData(url: String): String;

    function SplitMultipleResultIntoDatasets(res: String): TList<TRoomerDataSet>;

    procedure SetTimeZoneComparedToUTC(tz: String);

    function IsConnectedToInternet: Boolean;
    function RoomerPlatformAvailable: Boolean;

    procedure markMessageAsRead(id: Integer);
    function KeepSessionAlive: String;

    function ReLogin: Boolean;
    function Login(hotelId: String; username: String; password: String;
      appName: String; appVersion: String; RightRangeMin: Integer = 90;
      RightRangeMax: Integer = 100): Boolean;
    function RoomerAdminLogin(username: String; password: String;
      appName: String; appVersion: String): Boolean;
    procedure Logout;
    procedure LogoutUnaffected;
    function MyIpAddress : String;
    function SyncFinanceTables: String;
    function SwapHotel(hotelId: String; var username, password: String)
      : Boolean;

    function CreateExecutionPlan: TRoomerExecutionPlan;

    function SendConfirmationEmailOpenAPI(Reservation: Integer): String;
    function SendEmailOpenAPI(subject : UTF8String; from, recipient, cc, bcc : String; _text, _htmlText : UTF8String; files : TStringList): String;

    function HashedPassword(password: String): String;
    function SystemDownloadFileFromURI(URI, filename: String): Boolean;
    function SystemUploadFile(filename: String; FileType: word;
      includeLastModified: Boolean = true): Boolean;
    function SystemDownloadFile(FileType: word;
      sourceFilename, destFilename: String): Boolean;
    function SystemDownloadRoomerFile(sourceFilename,
      destFilename: String): Boolean;

    procedure SystemMarkReservationAsNotified(id: Integer);
    function SystemDownloadRoomerBackup(destFilename: String): Boolean;
    function SystemRoomerFile(filename: String): TFileEntity;
    function SystemListFiles(FileType: word): TFileList;
    function SystemDeleteFile(FileType: word; filename: String): Boolean;
    function SystemRenameFile(FileType: word;
      filename, newFilename: String): Boolean;
    function SystemFileExists(FileType: word; filename: String): Boolean;
    procedure SystemPrepareChannelRates;

    function PostOpenAPI(url: String; Data: TStream): String;
    function DeleteFileResourceOpenAPI(URI: String): String;
    function PostFileOpenAPI(url, filename, keyString: String; FileType: String;
      privateResource: Boolean = true): String;
    function DownloadFileResourceOpenAPI(URI, destFilename: String): Boolean;
    function HeadOfURI(URI: String): TALHTTPResponseHeader;

    function queryRoomer(aSql: String; SetLastAccess: Boolean = true): String;
    function downloadUrlAsString(url: String; loggingInOut: Integer = 0;
      SetLastAccess: Boolean = true; contentType: String = ''): String;
    function downloadUrlAsStringUsingPost(url: String; Data: String;
      SetLastAccess: Boolean = true;
      loggingInOut: Integer = 0 { 0/1/2 = neither/login/logout }
      ; contentType: String = ''): String;
    function downloadUrlAsStringUsingPostAsync(url: String; Data: String;
      SetLastAccess: Boolean = true;
      loggingInOut: Integer = 0 { 0/1/2 = neither/login/logout }
      ; contentType: String = ''): String;
    function downloadRoomerUrlAsString(url: String;
      SetLastAccess: Boolean = true): String;

    function UrlEncode(source: string): string;
    procedure AssignToDataset(SqlResult: String; DataSet: TRoomerDataSet);

    function SecondsLeft: Integer;
    function GetAttributeValue(Node: IXMLDomNode;
      AttribName, defaultValue: String): String;

    function RegisterApplication(hotelId, username, password,
      appId: String): String;

    // ******************************************************

{$I RoomerDBMethodsDefinitions.inc}
    function ActivateNewDataset(SqlResult: String): TRoomerDataSet;
    function CreateNewDataset: TRoomerDataSet;
    procedure AssignPropertiesToDataSet(DataSet: TRoomerDataSet);

    function CloneToRecordset: _RecordSet;

    function OfflineFilesAvailable(_hotelId : String = ''): Boolean;

   // For testing purposes...
    function TestSpecificOpenApiAuthHeaders(AppKey, ApplicationId, AppSecret, url : String; tim : Extended = 0) : String;

    property hotels: THotelsEntityList read getHotelsList;

    property OfflineMode : Boolean read FOfflineMode write SetOfflineMode;
    property LoggedIn : Boolean read FLoggedIn write FLoggedIn;
    property RoomerDataSet: TRoomerDataSet read FRoomerDataSet write FRoomerDataSet;

  published
    { Published declarations }
    property SavedLastResult: String read FSavedLastResult;
    property Sql: TStringList read FSql;
    property DataActive: Boolean read FDataActive write SetDataActive;
    property RoomerStoreUri: String read FStoreUri write FStoreUri;
    property OpenApiUri: String read GetOpenApiUri write SetOpenApiUri;
    property RoomerUri: String read GetUri write SetUri;
    property RoomerEntitiesUri: String read FRoomerEntitiesUri
      write FRoomerEntitiesUri;
    property RoomerDatasetsUri: String read FRoomerDatasetsUri
      write FRoomerDatasetsUri;

{$IFDEF USE_INDY}
    property roomerClient: TIdHTTP read FroomerClient;
{$ELSE}
    property roomerClient: TALWininetHttpClient read FroomerClient;
{$ENDIF}
    property OnSessionExpired: TNotifyEvent read FOnSessionExpired
      write FOnSessionExpired;
    property CommandText: String read GetCommandText write SetCommandText;
    property CommandType: TCommandType read FCommandType write SetCommandType;
    property SessionLengthSeconds: Integer read FSessionLengthSeconds
      write FSessionLengthSeconds;
    property NumberOfAffectedRows: Integer read FNumberOfAffectedRows;
    property hotelId: String read FHotelId write FHotelID;
    property username: String read FUsername write FUsername;
    property password: String read FPassword write FPassword;
    property ParentRoomerDataSet: TRoomerDataSet read FRoomerDataSet
      write FRoomerDataSet;

    property ApplicationID: String read FApplicationID write FApplicationID;
    property AppKey: String read FAppKey write FAppKey;
    property AppSecret: String read FAppSecret write FAppSecret;

    property AfterScroll;

  end;


procedure Register;

implementation

uses
  JSonManager, md5hash, ALfcnString, uDateUtils, idMultiPartFormData,
  GoogleOTP256, uRoomerExceptions, IOUtils, uFileSystemUtils;

resourcestring
  PROMOIR_ROOMER_HOTEL_IDENTIFIER = 'Promoir-Roomer-Hotel-Identifier';
  PROMOIR_ROOMER_HOTEL_SECRET = 'Promoir-Roomer-Hotel-Secret';
  PROMOIR_ROOMER_HOTEL_APPLICATION_ID = 'Promoir-Roomer-Hotel-ApplicationId';
  PROMOIR_ROOMER_HOTEL_ADD_PRIVATE_RESOURCES =
    'Promoir-Roomer-Hotel-Add-Private-Resources';
  PROMOIR_ROOMER_HOTEL_PATH = 'Promoir-Roomer-Hotel-Add-Resources-Path';

var
  EXTRA_BUILD_ID : String;

procedure Register;
begin
  RegisterComponents('Roomer', [TRoomerDataSet]);
end;

{ TRoomerDataSet }

const
  ROOMER_SPLIT: String = '[\ROOMER-SPLIT\]';

function TRoomerDataSet.CloneToRecordset: _RecordSet;
var
  newRec: _Recordset;
  stm: Stream;
begin
  newRec := CoRecordset.Create as _Recordset;
  stm := CoStream.Create;
  Recordset.Save(stm, adPersistADTG);
  newRec.Open(stm, EmptyParam, CursorTypeEnum(adOpenUnspecified),
      LockTypeEnum(adLockUnspecified), 0);
  Result := newRec;
end;

constructor TRoomerDataSet.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FApplicationID := '';
  FAppSecret := '';
  FAppKey := '';

  FRoomerDataSet := nil;
  FOnSessionExpired := nil;
  FOfflineMode := False;
  FSql := TStringList.Create;
  hotelsList := THotelsEntityList.Create(True);
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

function TRoomerDataSet.CreateRoomerClient:
{$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF};
begin
{$IFDEF USE_INDY}
  result := TIdHTTP.Create(nil);
  IdSSLIOHandlerSocketOpenSSL1 := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  result.IOH1andler := IdSSLIOHandlerSocketOpenSSL1;
  result.Request.Accept :=
    'text/html,application/xhtml+xml,application/xml;application/octed-stream;q=0.9,*/*;q=0.8';
  result.Request.Referer := 'Mozilla/3.0 (compatible; Roomer PMS)';
  result.HTTPOptions := [hoForceEncodeParams];
{$ELSE}
  result := TALWininetHttpClient.Create(nil);
  result.SendTimeout := 900000;
  result.ReceiveTimeout := 900000;
  result.ConnectTimeout := 10000;
  result.AccessType := wHttpAt_Direct;
  result.InternetOptions := [whttpIo_IGNORE_CERT_CN_INVALID,
    whttpIo_IGNORE_CERT_DATE_INVALID, whttpIo_KEEP_CONNECTION,
    whttpIo_NO_CACHE_WRITE, whttpIo_NO_UI, whttpIo_PRAGMA_NOCACHE,
    whttpIo_RELOAD, whttpIo_RESYNCHRONIZE];
{$ENDIF}
end;

function TRoomerDataSet.CreateExecutionPlan: TRoomerExecutionPlan;
begin
  result := TRoomerExecutionPlan.Create;
  result.RoomerDataSet := self;
end;

destructor TRoomerDataSet.Destroy;
begin
  inherited;
  FSql.Free;
  hotelsList.Free;
  FreeAndNil(FroomerClient);
end;

function TRoomerDataSet.CreateNewDataset: TRoomerDataSet;
begin
  result := TRoomerDataSet.Create(Owner);
  result.RoomerStoreUri := activeRoomerDataSet.RoomerStoreUri;
  result.RoomerUri := activeRoomerDataSet.RoomerUri;
  result.OpenApiUri := activeRoomerDataSet.OpenApiUri;
  result.RoomerEntitiesUri := activeRoomerDataSet.RoomerEntitiesUri;
  result.RoomerDatasetsUri := activeRoomerDataSet.RoomerDatasetsUri;
  result.FRoomerDataSet := self;
  result.OnSessionExpired := self.OnSessionExpired;
  result.FHotelId := self.FHotelId;
  result.FPassword := self.FPassword;
  result.FUsername := self.FUsername;
  result.FAppName := self.FAppName;
  result.FAppVersion := self.FAppVersion;
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

function TRoomerDataSet.IsConnectedToInternet: Boolean;
var
  dwConnectionTypes: DWORD;
begin
  dwConnectionTypes :=
    INTERNET_CONNECTION_MODEM +
    INTERNET_CONNECTION_LAN +
    INTERNET_CONNECTION_PROXY;

{$ifdef rmForceOffline}
  Result := false;
{$else}
  Result := InternetGetConnectedState(@dwConnectionTypes, 0);
{$endif rmForceOffline}

end;

function TRoomerDataSet.RoomerPlatformAvailable: Boolean;
var
  lRoomerClient: {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF};
begin
  result := True;
  try
    lRoomerClient := CreateRoomerClient;
    try
      if GetAsString(lRoomerClient, RoomerUri + 'sessions/livecheck', '', true) = '' then;
    finally
      lRoomerClient.Free;
    end;
  except
   on E: Exception do
   begin
    OutputDebugString(PChar('>>>>>Exception during RoomerPLatformAvailable: ' + E.Message));
    result := False;
   end;
  end;
end;

function TRoomerDataSet.UrlEncode(source: string): string;
var
  i: Integer;
begin
  result := '';
  for i := 1 to length(source) do
    if CharInSet(source[i], ['+', '^', '&', '%', '?', '\', '`']) then
      result := result + '%' + inttohex(ord(source[i]), 2)
    else
      result := result + source[i];
end;

function TRoomerDataSet.activeRoomerDataSet: TRoomerDataSet;
begin
  if assigned(FRoomerDataSet) then
    result := FRoomerDataSet
  else
    result := self;
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

procedure TRoomerDataSet.Open(doLowerCase: Boolean = true; setLastAccess: Boolean = true);
var
  sqlCommand, SqlResult: String;
begin
  if doLowerCase then
    sqlCommand := LowerCase(Sql.Text)
  else
    sqlCommand := Sql.Text;
  SqlResult := queryRoomer(sqlCommand, setLastAccess);
  OpenDataset(SqlResult);
end;

procedure TRoomerDataSet.GetMessages;
begin
  try
    if NOT OfflineMode then
      OpenDataset(downloadUrlAsString(RoomerUri + 'messaging/broadcastlist', 0, false));
  except
    // Ignore ...
  end;
end;

procedure TRoomerDataSet.SystemMarkReservationAsNotified(id: Integer);
begin
  try
    DoCommand('UPDATE reservations SET notificationRead=1 WHERE Reservation=' +
      inttostr(id));
  except
  end;
end;

function TRoomerDataSet.GetOpenApiUri: String;
begin
  result := FOpenApiUri;
end;

procedure TRoomerDataSet.GetTableUpdateTimeStamps;
begin
  try
    if NOT OfflineMode then
      OpenDataset(downloadUrlAsString(RoomerUri + 'messaging/lastchanges', 0, false));
  except
    // Ignore ...
  end;
end;

function TRoomerDataSet.RegisterApplication(hotelId, username, password,
  appId: String): String;
begin
  try
    result := downloadUrlAsStringUsingPost(OpenApiUri + 'credentials/register' +
      format('?hotelId=%s&user=%s&password=%s&appId=%s',
      [EncodeURIComponent(hotelId), EncodeURIComponent(username),
      AnsiString(HashedPassword(password)), EncodeURIComponent(appId)]), '');
  except
    result := '';
  end;
end;

procedure TRoomerDataSet.markMessageAsRead(id: Integer);
begin
  downloadUrlAsString(RoomerUri +
    format('messaging/markbroadcastread?messageId=%d', [id]), 0, false);
end;

function TRoomerDataSet.KeepSessionAlive: String;
begin
  result := downloadUrlAsString(RoomerUri + 'sessions/pulse', 0, true);
end;

function TRoomerDataSet.queryRoomer(aSql: String; SetLastAccess: Boolean = true): String;
begin
  FLastSql := aSql;
  result := activeRoomerDataSet.SystemFreeQuery(aSql, SetLastAccess);
end;

function TRoomerDataSet.ReLogin: Boolean;
begin
  result := Login(hotelId, username, password, FAppName, FAppVersion);
end;

function TRoomerDataSet.RoomerAdminLogin(username, password, appName,
  appVersion: String): Boolean;
var
  pwmd5: String;
  res: String;
begin
  result := true;
  FUsername := username;
  FPassword := password;
  pwmd5 := HashedPassword(password);

  res := loginViaPost(RoomerUri + 'authentication/roomerlogin',
    format('username=%s&pwencoded=%s&appname=%s&appversion=%s&datasettype=0',
    [username, pwmd5, appName, appVersion]));
  // {$ENDIF}
  SetSessionLengthInSeconds(res);
  FLastAccess := now;
  FLoggedIn := True;
end;

function TRoomerDataSet.GetParameterTypeName(param : TRoomerOfflineAssertonParameter) : String;
begin
  result := '(NA)';
  case param of
    roapGet: result := 'GET';
    roapPut: result := 'PUT';
    roapDelete: result := 'DELETE';
    roapPost: result := 'POST';
  end;
end;

function TRoomerDataSet.GetFilenameFromParameter(param : TRoomerOfflineAssertonParameter) : String;
var sPath : String;
begin
  sPath := TPath.Combine(uStringUtils.LocalAppDataPath, 'Roomer');
  sPath := TPath.Combine(sPath, format('%s\backup',[hotelId]));
  forceDirectories(sPath);
  result := TPath.Combine(sPath, format('Offline_%s_Commands.src', [GetParameterTypeName(param)]));
end;

procedure TRoomerDataSet.AssertOnlineMode(param : TRoomerOfflineAssertonParameter = roapGet; asql : String = '');
begin
  if OfflineMode then
  begin
    case param of
      roapGet: ;
      roapPut: AddToTextFile(GetFilenameFromParameter(param), asql);
      roapDelete: AddToTextFile(GetFilenameFromParameter(param), asql);
      roapPost: AddToTextFile(GetFilenameFromParameter(param), asql);
    end;
    raise ERoomerOfflineAssertionException.CreateErrCode(
              format('Roomer is in Off-line mode while trying %s mode SQL.', [GetParameterTypeName(param)]),
              ORD(param));
  end;
end;

function TRoomerDataSet.PutData(url, Data : String) : String;
begin
  result := PutAsString(activeRoomerDataSet.roomerClient, RoomerUri + url, Data);
end;

function TRoomerDataSet.PostData(url, Data : String) : String;
begin
  result := PostAsString(activeRoomerDataSet.roomerClient, RoomerUri + url, Data);
end;

function TRoomerDataSet.DeleteData(url : String) : String;
begin
  result := DeleteAsString(activeRoomerDataSet.roomerClient, RoomerUri + url);
end;

function TRoomerDataSet.downloadRoomerUrlAsString(url: String;
  SetLastAccess: Boolean = true): String;
begin
  result := downloadUrlAsString(RoomerUri + url, 0, SetLastAccess);
end;

procedure TRoomerDataSet.AddAuthenticationHeaders(roomerClient:
  {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF}
  );
begin
  roomerClient.SendTimeout := 900000;
  roomerClient.ReceiveTimeout := 900000;
  roomerClient.ConnectTimeout := 10000;
  SetAuthHeaders(

    roomerClient.{$IFDEF USE_INDY}Request.CustomHeaders{$ELSE}RequestHeader{$ENDIF}, self.hotelId, self.username, self.password);
  SetOpenApiAuthHeaders(roomerClient.RequestHeader);
end;

(*
function TRoomerDataSet.GetAsJSON(roomerClient:
  {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF}
  ; url: String): String;

var
  _roomerClient: {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF};

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
function TRoomerDataSet.PostAsJSON(roomerClient:
  {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF}
  ; url, Data: String): String;
var
  stream: TStringStream;
  _roomerClient: {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF};

var retries : Integer;
begin
  AssertOnlineMode;
  _roomerClient := CreateRoomerClient;
  try

    _roomerClient.{$IFDEF USE_INDY}Request{$ELSE}RequestHeader{$ENDIF}.
      contentType := 'application/json';

    AddAuthenticationHeaders(_roomerClient);
    stream := TStringStream.Create(Data, TEncoding.UTF8);
    try
      stream.Position := 0;
      for retries := 1 to 3 do
      begin
        try
          result := String(_roomerClient.Post(AnsiString(url), stream));
        Break;
        except
          if retries = 3 then
            raise;
        end;
      end;
    finally
      stream.Free;
    end;
  finally
    FreeAndNil(_roomerClient);
  end;
end;

function TRoomerDataSet.PutAsJSON(roomerClient:
  {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF}
  ; url, Data: String): String;
var
  stream: TStringStream;
  _roomerClient: {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF};

var retries : Integer;
begin
  AssertOnlineMode;
  _roomerClient := CreateRoomerClient;
  try

    _roomerClient.{$IFDEF USE_INDY}Request{$ELSE}RequestHeader{$ENDIF}.
      contentType := 'application/json';

    AddAuthenticationHeaders(_roomerClient);
    stream := TStringStream.Create(Data, TEncoding.UTF8);
    try
      stream.Position := 0;
      for retries := 1 to 3 do
      begin
        try
          result := String(_roomerClient.Put(AnsiString(url), stream));
        Break;
        except
          if retries = 3 then
            raise;
        end;
      end;
    finally
      stream.Free;
    end;
  finally
    FreeAndNil(_roomerClient);
  end;
end;

function TRoomerDataSet.GetAsString(roomerClient:
  {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF}
  ; url: String; contentType: String = ''; force : Boolean = False): String;
var
  _roomerClient: {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF};

var retries : Integer;
begin
  if NOT force then
    AssertOnlineMode;
  _roomerClient := CreateRoomerClient;
  try
    AddAuthenticationHeaders(_roomerClient);
    if contentType = '' then
      contentType := '*/*;charset=utf-8';
    _roomerClient.{$IFDEF USE_INDY}Request{$ELSE}RequestHeader{$ENDIF}.
      contentType := contentType;
    _roomerClient.{$IFDEF USE_INDY}Request{$ELSE}RequestHeader{$ENDIF}.
      AcceptEncoding := 'UTF-8';
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

function TRoomerDataSet.PostAsString(roomerClient:
  {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF}
  ; url, Data: String; contentType: String = ''): String;

var
  stream: TStringStream;
  _roomerClient: {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF};

begin
  _roomerClient := CreateRoomerClient;
  try
    stream := TStringStream.Create(Data, TEncoding.UTF8);
    try
      stream.Position := 0;
      AddAuthenticationHeaders(_roomerClient);
      if contentType = '' then
        contentType := 'application/x-www-form-urlencoded'; // '*/*;charset=utf-8';
      _roomerClient.{$IFDEF USE_INDY}Request{$ELSE}RequestHeader{$ENDIF}.
        contentType := contentType;
//      for retries := 1 to 3 do
//      begin
        try
          result := _roomerClient.Post(url, stream);
//          Break;
        except
//          if retries = 3 then
            raise;
        end;
//      end;
    finally
      stream.Free;
    end;
  finally
    FreeAndNil(_roomerClient);
  end;
end;

function TRoomerDataSet.PostAsStringAsync(roomerClient: TALWininetHttpClient
  ; url, Data: String; contentType: String = ''): String;

var
  stream: TStringStream;
  _roomerClient: TALWininetHttpClient;

begin
  _roomerClient := CreateRoomerClient;
  try
    stream := TStringStream.Create(Data, TEncoding.UTF8);
    try
      stream.Position := 0;
      AddAuthenticationHeaders(_roomerClient);
      if contentType = '' then
        contentType := 'application/x-www-form-urlencoded'; // '*/*;charset=utf-8';
      _roomerClient.RequestHeader.contentType := contentType;
        try
          _roomerClient.InternetOptions := _roomerClient.InternetOptions + [wHttpIo_Async];
          try
            result := _roomerClient.Post(url, stream);
          finally
            _roomerClient.InternetOptions := _roomerClient.InternetOptions - [wHttpIo_Async];
          end;
        except
            raise;
        end;
    finally
      stream.Free;
    end;
  finally
    FreeAndNil(_roomerClient);
  end;
end;

function TRoomerDataSet.PostStreamAsString(roomerClient:
  {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF}
  ; url: String; Data: TStream; contentType: String = ''): String;

var
  _roomerClient: {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF};

begin
  _roomerClient := CreateRoomerClient;
  try
    Data.Position := 0;
    AddAuthenticationHeaders(_roomerClient);
    if contentType = '' then
      contentType := '*/*;charset=utf-8';
    _roomerClient.{$IFDEF USE_INDY}Request{$ELSE}RequestHeader{$ENDIF}.
      contentType := contentType;
//    for retries := 1 to 3 do
//    begin
      try
        result := _roomerClient.Post(url, Data);
//        Break;
      except
//        if retries = 3 then
          raise;
      end;
//    end;
  finally
    FreeAndNil(_roomerClient);
  end;
end;

function TRoomerDataSet.PutAsString(roomerClient:
  {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF}
  ; url, Data: String; contentType: String = ''
  ; retryOnError : Boolean = true): String;

var
  stream: TStringStream;
  _roomerClient: {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF};

begin
  _roomerClient := CreateRoomerClient;
  try
    stream := TStringStream.Create(Data, TEncoding.UTF8);
    try
      stream.Position := 0;
      AddAuthenticationHeaders(_roomerClient);
      if contentType = '' then
        contentType := 'application/x-www-form-urlencoded'; // '*/*;charset=utf-8';
//      if contentType = '' then
//        contentType := '*/*;charset=utf-8';
      _roomerClient.{$IFDEF USE_INDY}Request{$ELSE}RequestHeader{$ENDIF}.
        contentType := contentType;
//      for retries := 1 to 3 do
//      begin
        try
          result := _roomerClient.Put(url, stream);
//          Break;
        except
//          if (NOT retryOnError) OR (retries = 3) then
            raise;
        end;
//      end;
    finally
      stream.Free;
    end;
  finally
    FreeAndNil(_roomerClient);
  end;
end;

function TRoomerDataSet.DeleteAsString(roomerClient:
  {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF}
  ; url: String): String;

var
  _roomerClient: {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF};

var retries : Integer;
begin
  _roomerClient := CreateRoomerClient;
  try
    AddAuthenticationHeaders(_roomerClient);
    _roomerClient.{$IFDEF USE_INDY}Request{$ELSE}RequestHeader{$ENDIF}.
      contentType := '';
    for retries := 1 to 3 do
    begin
      try
        result := String(_roomerClient.Delete(AnsiString(url)));
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

function TRoomerDataSet.DownloadFile(roomerClient:
  {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF}
  ; url, filename: String): Boolean;
var
  stream: TFileStream;
  retries : Integer;
{$IFNDEF USE_INDY}
  aResponseContentHeader: TALHTTPResponseHeader;
{$ENDIF}

begin
  {$IFNDEF USE_INDY}
  aResponseContentHeader := TALHTTPResponseHeader.Create;
  {$ENDIF}

  result := false;
  stream := TFileStream.Create(filename, fmCreate);
  try
    try
      AddAuthenticationHeaders(roomerClient);
      {$IFDEF USE_INDY}
        roomerClient.handleRedirects := true; // Handle redirects
        roomerClient.Get(url, stream);
      {$ELSE}
        for retries := 1 to 3 do
        begin
          try
            roomerClient.Get(AnsiString(url), stream, aResponseContentHeader);
            Break;
          except
            if retries = 3 then
              raise;
          end;
        end;
      {$ENDIF}
      result := true;
    except
      result := false;
    end;
  finally
    stream.Free;
    {$IFNDEF USE_INDY}
      aResponseContentHeader.Free;
    {$ENDIF}
  end;
end;

function TRoomerDataSet.UploadFile(roomerClient:
  {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF}
  ; url, filename: String): Boolean;
var
  stream: TMemoryStream;
  contentType: String;
var retries : Integer;
begin
  Result := false;
  stream := TMemoryStream.Create;
  try
    try
      stream.LoadFromFile(filename);
      stream.Position := 0;
      AddAuthenticationHeaders(roomerClient);
      if contentType = '' then
        contentType := 'application/octet-stream';
      roomerClient.{$IFDEF USE_INDY}Request{$ELSE}RequestHeader{$ENDIF}.
        contentType := contentType;
      for retries := 1 to 3 do
      begin
        try
          roomerClient.Post(url, stream);
          Break;
        except
          if retries = 3 then
            raise;
        end;
      end;
      result := true;
    except
      result := false;
    end;
  finally
    stream.Free;
  end;
end;

function TRoomerDataSet.downloadUrlAsString(url: String;
  loggingInOut: Integer = 0; { 0/1/2 = neither/login/logout }
  SetLastAccess: Boolean = true; contentType: String = ''): String;
var
  doRetry: Boolean;
begin
  doRetry := true;
  while doRetry do
    try
      doRetry := false;
      result := GetAsString(activeRoomerDataSet.roomerClient, url, contentType);
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
            raise Exception.Create
              (format('Error during communication with server (GET): [%d] %s',
              [E.StatusCode, E.Message]));
        end;
{$ENDIF}
      end;
    end;
end;

procedure TRoomerDataSet.SetTimeZoneComparedToUTC(tz : String);
var statements : TList<String>;
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
  LoggedIn := False;
  if NOT assigned(FOnSessionExpired) then
    raise Exception.Create
      ('401 - Not allowed. Is the session expired?');
  FOnSessionExpired(self);
end;

procedure TRoomerDataSet.SetAuthHeaders(hdrs:
  {$IFDEF USE_INDY}TIdHeaderList{$ELSE}TAlHttpRequestHeader{$ENDIF};
  hotel, user, password: String);
begin
  hdrs.CustomHeaders.Clear;
  hdrs.CustomHeaders.Add(format('%s: %s', ['hotel', hotel]));
  hdrs.CustomHeaders.Add(format('%s: %s', ['Username', user]));
  hdrs.CustomHeaders.Add(format('%s: %s', ['Password', password]));
  hdrs.CustomHeaders.Add(format('%s: %s', ['AppName', FAppName]));
  hdrs.CustomHeaders.Add(format('%s: %s', ['AppVersion', FAppVersion]));
  hdrs.CustomHeaders.Add(format('%s: %s', ['DatasetType', '0']));
  hdrs.CustomHeaders.Add(format('%s: %s', ['ExtraBuild', EXTRA_BUILD_ID]));
end;

function TRoomerDataSet.downloadUrlAsStringUsingPost(url: String; Data: String;
  SetLastAccess: Boolean = true;
  loggingInOut: Integer = 0 { 0/1/2 = neither/login/logout }
  ; contentType: String = ''): String;
var
  doRetry: Boolean;
begin
  doRetry := true;
  while doRetry do
    try
      doRetry := false;
      result := PostAsString(activeRoomerDataSet.roomerClient, url, Data, contentType);
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
            raise Exception.Create
              (format('Error during communication with server (GET): [%d] %s',
              [E.StatusCode, E.Message]));
        end;
{$ENDIF}
      end;
      on E: Exception do
      begin
        raise Exception.Create
          (format('Error during communication with server (POST): %s',
          [E.Message]));
      end;
    end;
end;

function TRoomerDataSet.downloadUrlAsStringUsingPostAsync(url: String; Data: String;
  SetLastAccess: Boolean = true;
  loggingInOut: Integer = 0 { 0/1/2 = neither/login/logout }
  ; contentType: String = ''): String;
var
  doRetry: Boolean;
begin
  doRetry := true;
  while doRetry do
    try
      doRetry := false;
      result := PostAsStringAsync(activeRoomerDataSet.roomerClient, url, Data, contentType);
      if SetLastAccess then
        FLastAccess := now;
      exit;
    except
      on E: EALHTTPClientException
        do
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
            raise Exception.Create
              (format('Error during communication with server (GET): [%d] %s',
              [E.StatusCode, E.Message]));
        end;
      end;
      on E: Exception do
      begin
        raise Exception.Create
          (format('Error during communication with server (POST): %s',
          [E.Message]));
      end;
    end;
end;

function TRoomerDataSet.downloadUrlAsStringUsingPut(url: String; Data: String;
  SetLastAccess: Boolean = true;
  loggingInOut: Integer = 0 { 0/1/2 = neither/login/logout }
  ; contentType: String = ''
  ; retryOnError : Boolean = true
  ): String;
var
  doRetry: Boolean;
begin
  doRetry := true;
  while doRetry do
    try
      doRetry := false;
      result := PutAsString(activeRoomerDataSet.roomerClient, url, Data,
        contentType, retryOnError);
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
            raise Exception.Create
              (format('Error during communication with server (GET): [%d] %s',
              [E.StatusCode, E.Message]));
        end;
{$ENDIF}
      end;
      on E: Exception do
      begin
        raise Exception.Create
          (format('Error during communication with server (POST): %s',
          [E.Message]));
      end;
    end;
end;

function TRoomerDataSet.loginViaPost(url: String; Data: String;
  SetLastAccess: Boolean = true): String;
begin
  try
    result := PostAsString(activeRoomerDataSet.roomerClient, url, Data);
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
        raise Exception.Create
          ('Unknown hotel, username and password combination');
      end
      else if (E.StatusCode DIV 100 = 5) then
      begin
        if POS('UNKNOWN DATABASE', Uppercase(E.Message)) > 0 then
          raise Exception.Create
            ('Unknown hotel, username and password combination')
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
  result := PostStreamAsString(activeRoomerDataSet.roomerClient, url, Data,
    'multipart/form-data');
end;

procedure TRoomerDataSet.SetOfflineMode(const Value: Boolean);
begin
  FOfflineMode := Value;
end;

procedure TRoomerDataSet.SetOpenApiAuthHeaders(hdrs:
  {$IFDEF USE_INDY}TIdHeaderList{$ELSE}TAlHttpRequestHeader{$ENDIF});
begin
  if TRIM(AppKey) = '' then exit;

//  hdrs.CustomHeaders.Clear;
  hdrs.CustomHeaders.Add(format('%s: %s', [PROMOIR_ROOMER_HOTEL_IDENTIFIER,
    AppKey]));
  hdrs.CustomHeaders.Add(format('%s: %s', [PROMOIR_ROOMER_HOTEL_APPLICATION_ID,
    ApplicationID]));
  hdrs.CustomHeaders.Add(format('%s: %s', [PROMOIR_ROOMER_HOTEL_SECRET,
    CalculateOTP(AppSecret)]));
end;

procedure TRoomerDataSet.SetSpecificOpenApiAuthHeaders(hdrs: TAlHttpRequestHeader;
AppKey, ApplicationId, AppSecret : String; tim : Extended);
begin
  if TRIM(AppKey) = '' then exit;

//  hdrs.CustomHeaders.Clear;
  hdrs.CustomHeaders.Add(format('%s: %s', [PROMOIR_ROOMER_HOTEL_IDENTIFIER,
    AppKey]));
  hdrs.CustomHeaders.Add(format('%s: %s', [PROMOIR_ROOMER_HOTEL_APPLICATION_ID,
    ApplicationID]));
  hdrs.CustomHeaders.Add(format('%s: %s', [PROMOIR_ROOMER_HOTEL_SECRET,
    CalculateOTPOnSpecifiedTime(AppSecret, tim)]));

// 2a0434bc
// ORBIS
// a02da62f9c6f941024e90d5828d9246c096fb5b1286946e1a63b14981d42f55e
// https://api.roomercloud.net/roomer/openAPI/REST/bookings/roomassignments?roomNumber=004
end;

function TRoomerDataSet.TestSpecificOpenApiAuthHeaders(AppKey, ApplicationId, AppSecret, url : String; tim : Extended = 0) : String;
begin
  SetSpecificOpenApiAuthHeaders(roomerClient.RequestHeader, AppKey, ApplicationId, AppSecret, tim);
  roomerClient.RequestHeader.AcceptEncoding := 'UTF-8';
  result := roomerClient.Get(url);
end;


function TRoomerDataSet.OfflineFilesAvailable(_hotelId : String = ''): Boolean;
var sPath, filePath : String;
begin
  result := False;
  if (_hotelId = '') AND (hotelId = '') then
    exit;

  if _hotelId = '' then
     _hotelId := hotelId;

  sPath := TPath.Combine(uStringUtils.LocalAppDataPath, 'Roomer');
  sPath := TPath.Combine(sPath, format('%s\backup',[_hotelId]));
  filePath := TPath.Combine(sPath, 'Backup_TAXES.src');
  forceDirectories(sPath);

  result := FileExists(filePath);
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
  _roomerClient: {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF};
begin
  _roomerClient := CreateRoomerClient;
  try
    SetOpenApiAuthHeaders(_roomerClient.RequestHeader);
    // _roomerClient.Delete(OpenApiUri + 'staticresources/' + EncodeURIComponent(GetOpenAPIResourcePath(OpenApiUri, URI)));
    _roomerClient.Delete(URI);
    result := '';
  finally
    FreeAndNil(_roomerClient);
  end;
end;

function TRoomerDataSet.DownloadFileResourceOpenAPI(URI,
  destFilename: String): Boolean;
var
  stream: TFileStream;
var
  _roomerClient: {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF};
{$IFNDEF USE_INDY}aResponseContentHeader: TALHTTPResponseHeader; {$ENDIF}
begin
{$IFNDEF USE_INDY}aResponseContentHeader := TALHTTPResponseHeader.Create;
  {$ENDIF}
  result := true;
  _roomerClient := CreateRoomerClient;
  try
    try
      SetOpenApiAuthHeaders(_roomerClient.RequestHeader);
      // SentUri := OpenApiUri + Path + '/' + EncodeURIComponent(Filename);
      stream := TFileStream.Create(destFilename, fmCreate);
      try
{$IFDEF USE_INDY}
        _roomerClient.handleRedirects := true; // Handle redirects
        _roomerClient.Get(URI, stream);
{$ELSE}
        _roomerClient.Get(AnsiString(URI), stream, aResponseContentHeader);
{$ENDIF}
      finally
        stream.Free;
      end;
    except
      result := false;
      raise;
    end;
  finally
    FreeAndNil(_roomerClient);
  end;
  // result := PostStreamAsString(activeRoomerDataSet.roomerClient, Url, Data, 'multipart/form-data');
end;

function TRoomerDataSet.PostFileOpenAPI(url: String;
  filename, keyString: String; FileType: String;
  privateResource: Boolean = true): String;
var
  multi: TRoomerMultipartFormData;
  http: TIdHTTP;
  privRes: String;
  IdSSLIOHandlerSocketOpenSSL1 : TIdSSLIOHandlerSocketOpenSSL;
begin
  multi := TRoomerMultipartFormData.Create;
  try
    multi.AddFile(extractFilename(filename), filename, FileType);

    if privateResource then
      privRes := 'true'
    else
      privRes := 'false';

    http := TIdHTTP.Create(nil);
    try
      // http.Request.CustomHeaders.AddValue(PROMOIR_ROOMER_HOTEL_PATH, keyString);
      if LowerCase(Copy(OpenApiUri, 1, 8)) = 'https://' then
      begin
        IdSSLIOHandlerSocketOpenSSL1 := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
        http.IOHandler := IdSSLIOHandlerSocketOpenSSL1;
      end;

      http.Request.CustomHeaders.AddValue
        (PROMOIR_ROOMER_HOTEL_IDENTIFIER, AppKey);
      http.Request.CustomHeaders.AddValue(PROMOIR_ROOMER_HOTEL_APPLICATION_ID,
        ApplicationID);
      http.Request.CustomHeaders.AddValue(PROMOIR_ROOMER_HOTEL_SECRET,
        CalculateOTP(AppSecret));
      http.Request.CustomHeaders.AddValue
        (PROMOIR_ROOMER_HOTEL_ADD_PRIVATE_RESOURCES, privRes);
      result := http.Post(OpenApiUri + url + '/' + keyString, multi);
    finally
      if LowerCase(Copy(OpenApiUri, 1, 8)) = 'https://' then
        IdSSLIOHandlerSocketOpenSSL1.Free;
      http.Free;
    end;
  finally
    multi.Free;
  end;
  // result := PostStreamAsString(activeRoomerDataSet.roomerClient, Url, Data, 'multipart/form-data');
end;

function TRoomerDataSet.SendConfirmationEmailOpenAPI(Reservation : Integer): String;
var
  http: TIdHTTP;
  URL : String;
  stream : TStringStream;
  IdSSLIOHandlerSocketOpenSSL1 : TIdSSLIOHandlerSocketOpenSSL;
begin
  http := TIdHTTP.Create(nil);
  if LowerCase(Copy(OpenApiUri, 1, 8)) = 'https://' then
    IdSSLIOHandlerSocketOpenSSL1 := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    if LowerCase(Copy(OpenApiUri, 1, 8)) = 'https://' then
      http.IOHandler := IdSSLIOHandlerSocketOpenSSL1;

    http.Request.CustomHeaders.AddValue
      (PROMOIR_ROOMER_HOTEL_IDENTIFIER, AppKey);
    http.Request.CustomHeaders.AddValue(PROMOIR_ROOMER_HOTEL_APPLICATION_ID,
      ApplicationID);
    http.Request.CustomHeaders.AddValue(PROMOIR_ROOMER_HOTEL_SECRET,
      CalculateOTP(AppSecret));

    URL := format(OpenApiUri + 'bookings/%d?confirmedToGuest=true', [Reservation]);

    stream := TStringStream.Create;
    try
    result := http.PUT(URL, stream);
    finally
      stream.Free;
    end;
  finally
    if LowerCase(Copy(OpenApiUri, 1, 8)) = 'https://' then
      IdSSLIOHandlerSocketOpenSSL1.Free;
    http.Free;
  end;
end;

function TRoomerDataSet.SendEmailOpenAPI(subject : UTF8String; from, recipient, cc, bcc : String; _text, _htmlText : UTF8String; files : TStringList): String;
var
  multi: TIdMultipartFormDataStream;
  http: TIdHTTP;
  i: Integer;
  filename, filePath : String;
  att : TIdFormDataField;
  IdSSLIOHandlerSocketOpenSSL1 : TIdSSLIOHandlerSocketOpenSSL;
begin
  multi := TIdMultipartFormDataStream.Create;
  try
    for i := 0 to files.Count - 1 do
    begin
      filename := copy(files[i], pos('=', files[i]) + 1, maxint);
      filePath := copy(files[i], 1, pos('=', files[i]) - 1);
      att := multi.AddFile('attachment', filePath, GetMIMEtype(filename));
      att.FileName := extractFilename(filename);
    end;

    multi.AddFormField('to', recipient, 'UTF-8');
    if trim(cc) <> '' then
      multi.AddFormField('cc', cc, 'UTF-8');
    if trim(bcc) <> '' then
      multi.AddFormField('bcc', bcc, 'UTF-8');
    multi.AddFormField('from', from, 'UTF-8');
    multi.AddFormField('subject', subject, 'UTF-8');

    multi.AddFormField('plaintext', _text, 'UTF-8', 'text/plain', 'emailText.txt');
    multi.AddFormField('htmltext', _htmlText, 'UTF-8', 'text/html', 'htmlText.html');


    http := TIdHTTP.Create(nil);
    if LowerCase(Copy(OpenApiUri, 1, 8)) = 'https://' then
      IdSSLIOHandlerSocketOpenSSL1 := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    try
      if LowerCase(Copy(OpenApiUri, 1, 8)) = 'https://' then
        http.IOHandler := IdSSLIOHandlerSocketOpenSSL1;
      http.Request.CustomHeaders.AddValue
        (PROMOIR_ROOMER_HOTEL_IDENTIFIER, AppKey);
      http.Request.CustomHeaders.AddValue(PROMOIR_ROOMER_HOTEL_APPLICATION_ID,
        ApplicationID);
      http.Request.CustomHeaders.AddValue(PROMOIR_ROOMER_HOTEL_SECRET,
        CalculateOTP(AppSecret));

      result := http.Post(OpenApiUri + 'hotelservices/email', multi);
    finally
      if LowerCase(Copy(OpenApiUri, 1, 8)) = 'https://' then
        IdSSLIOHandlerSocketOpenSSL1.Free;
      http.Free;
    end;
  finally
    multi.Free;
  end;
  // result := PostStreamAsString(activeRoomerDataSet.roomerClient, Url, Data, 'multipart/form-data');
end;

procedure TRoomerDataSet.GetFieldText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  Text := StringReplace(Sender.AsString, #10, #13#10, [rfReplaceAll]);
end;

procedure TRoomerDataSet.OpenDataset(SqlResult: String);
var
  i: Integer;
begin
  if (SqlResult = '') then
    Exit;

  try
    FSavedLastResult := SqlResult;
    FSavedResult := XMLToRecordset(SqlResult);
    Close;
    CommandType := cmdFile;
    LockType := ltBatchOptimistic;
//    CommandText := '';
    RecordSet := ADOInt._Recordset(FSavedResult);

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
      DebugMessage(e.Message);
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
    Data: OleVariant;
  begin
    try
      FieldData := PVariantList(PByte(ActiveBuffer) + SizeOf(TRecInfo));
      for i := 0 to Fields.Count - 1 do
        if TField(Fields[i]).OldValue <> TField(Fields[i]).NewValue then
        begin
          Data := Unassigned;
          Data := FieldData[TField(Fields[i]).index];
          if not VarIsClear(Data) then
            RecordSet.Fields[TField(Fields[i]).FieldNo - 1].Value := Data;
        end;
      ReleaseLock;
    except
      CursorPosChanged;
      RecordSet.CancelUpdate;
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
    for i := 0 to RecordSet.Fields.Count - 1 do
    begin
      tableName := RecordSet.Fields[i].Properties['BASETABLENAME'].Value;
      if NOT list.Contains(tableName) then
        list.Add(tableName);
    end;
  end;

  procedure PerformUpdate(aTableName: String; aSql: String);
  begin
    if aSql <> '' then
    begin
      aSql := format('UPDATE %s SET %s WHERE id=%d',
        [aTableName, aSql, FieldByName('id').AsInteger]);
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
    for i := 0 to RecordSet.Fields.Count - 1 do
    begin
      tableName := RecordSet.Fields[i].Properties['BASETABLENAME'].Value;
      if table = tableName then
      begin
        fieldName := RecordSet.Fields[i].Properties['BASECOLUMNNAME'].Value;
        Field := FieldByName(RecordSet.Fields[i].Name);
        if Field.OldValue <> Field.NewValue then
        begin
          iFieldSize := RecordSet.Fields[i].DefinedSize;
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
      aSql := format('INSERT INTO %s (%s) VALUES(%s)',
        [LowerCase(aTableName), aFields, aSql]);
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
    for i := 0 to RecordSet.Fields.Count - 1 do
    begin
      tableName := RecordSet.Fields[i].Properties['BASETABLENAME'].Value;
      if table = tableName then
      begin
        fieldName := RecordSet.Fields[i].Properties['BASECOLUMNNAME'].Value;
        Field := FieldByName(RecordSet.Fields[i].Name);
        iFieldSize := RecordSet.Fields[i].DefinedSize;
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
    try inherited Post; except end;
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

procedure TRoomerDataSet.AssignToDataset(SqlResult: String;
  DataSet: TRoomerDataSet);
begin
  FSavedLastResult := SqlResult;
  DataSet.Close;
  DataSet.CommandType := cmdFile;
  DataSet.LockType := ltBatchOptimistic;
  DataSet.CommandText := '';
  DataSet.RecordSet := ADOInt._Recordset(SqlResult);
  if not(BOF and EOF) then
    First;
end;

function TRoomerDataSet.DoCommand(aSql: String; async : Boolean = false): Integer;
var
  sResult: String;
begin
  if async then
    sResult := self.activeRoomerDataSet.SystemFreeExecuteAsync(aSql)
  else
    sResult := self.activeRoomerDataSet.SystemFreeExecute(aSql);
  result := StrToIntDef(sResult, -99999999);
  if result <= 0 then
  begin
    if result = -99999999 then
    begin
{$IFDEF DEBUG}
      CopyToClipboard(aSql + #13#10#13#10 + '-- ' + sResult);
{$ENDIF}
      raise Exception.Create('command execution failed:' + sResult);
    end;
  end;
  FNumberOfAffectedRows := result;
end;

procedure TRoomerDataSet.DoQuery(aSql: String);
begin
  OpenDataset(queryRoomer(aSql));
end;

function TRoomerDataSet.GetCommandText: String;
begin
  result := Sql.Text;
end;

function SystemDecimalSeparator: string;
var
  Decimal: PChar;
begin
  Decimal := StrAlloc(10);
  GetLocaleInfo(LOCALE_SYSTEM_DEFAULT, LOCALE_SDECIMAL, Decimal, 10);
  result := String(Decimal)[1];
end;

function TRoomerDataSet.GetFloatValue(Field: TField): Double;
begin
  result := LocalizedFloatValue(Field.Value);
end;

function TRoomerDataSet.getHotelsList: THotelsEntityList;
begin
  result := hotelsList;
end;

function TRoomerDataSet.Login(hotelId: String; username, password: String;
  appName: String; appVersion: String; RightRangeMin: Integer = 90;
  RightRangeMax: Integer = 100): Boolean;
var
  pwmd5: AnsiString;
  res: String;
begin
  result := true;
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
  FLoggedIn := True;
end;

function TRoomerDataSet.SwapHotel(hotelId: String;
  var username, password: String): Boolean;
// var
// res: String;
begin
  result := Login(hotelId, FUsername, FPassword, FAppName, FAppVersion);
  if result then
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
  result := md5(password);
end;

function TRoomerDataSet.HeadOfURI(URI: String): TALHTTPResponseHeader;
var
  _roomerClient: {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF};
  ResponseContentStream: TMemoryStream;
  ResponseContentHeader: TALHTTPResponseHeader;
begin
  _roomerClient := CreateRoomerClient;
  try
    SetOpenApiAuthHeaders(_roomerClient.RequestHeader);
    // _roomerClient.Delete(OpenApiUri + 'staticresources/' + EncodeURIComponent(GetOpenAPIResourcePath(OpenApiUri, URI)));
    ResponseContentStream := TMemoryStream.Create;
    ResponseContentHeader := TALHTTPResponseHeader.Create;
    _roomerClient.Head(URI, ResponseContentStream, ResponseContentHeader);
    result := ResponseContentHeader;
  finally
    FreeAndNil(_roomerClient);
  end;
end;

procedure TRoomerDataSet.Logout;
begin
  FLoggedIn := False;
  try downloadUrlAsString(RoomerUri + 'logout', 2, false); except end;
  AppKey := '';
end;

procedure TRoomerDataSet.LogoutUnaffected;
begin
  FLoggedIn := False;
  try roomerClient.Get(RoomerUri + 'logout'); except end;
  AppKey := '';
end;

function TRoomerDataSet.MyIpAddress : String;
begin
  result := downloadUrlAsString(RoomerUri + 'authentication/myipaddress');
end;

function TRoomerDataSet.SyncFinanceTables : String;
begin
  result := downloadUrlAsString(RoomerUri + 'financekeys/reset');
end;

procedure TRoomerDataSet.SetSessionLengthInSeconds(xmlSource: String);
var
  xml: IXMLDOMDocument2;
  xmlTemp: IXMLDOMNodeList;
  xmlHotel: IXMLDomNode;
  i: Integer;
begin
  xml := CreateXmlDocument;
  xml.LoadXML(xmlSource);
  FSessionLengthSeconds :=
    strtoint(GetAttributeValue(xml.documentElement.firstChild,
    'sessionTimoutSeconds', '450'));

  hotelsList.Clear;
  xmlTemp := xml.selectNodes('//authentication/user/hotels/hotel');
  // xmlTemp := xmlHotels.item[0].getElementsByTagName('hotel');
  for i := 0 to xmlTemp.length - 1 do
  begin
    xmlHotel := xmlTemp.item[i];
    if xmlHotel.nodeName = 'hotel' then
    begin
      hotelsList.Add(TRoomerHotelsEntity.Create(GetAttributeValue(xmlHotel,
        'hotelCode', hotelId), GetAttributeValue(xmlHotel, 'hotelName',
        hotelId), strtoint(GetAttributeValue(xmlHotel, 'ownerID', '0'))));
    end;
  end;
end;

function TRoomerDataSet.GetAttributeValue(Node: IXMLDomNode;
  AttribName, defaultValue: String): String;
var
  i: Integer;
begin
  result := defaultValue;
  for i := 0 to Node.Attributes.length - 1 do
    if Node.Attributes.item[i].nodeName = AttribName then
    begin
      result := Node.Attributes.item[i].Text;
      Break;
    end;
end;

function TRoomerDataSet.SecondsLeft: Integer;
begin
  result := SecondsBetween(IncSecond(FLastAccess, FSessionLengthSeconds), now);
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

function TRoomerDataSet.ActivateNewDataset(SqlResult: String): TRoomerDataSet;
begin
  result := TRoomerDataSet.Create(Owner);
  result.OfflineMode := OfflineMode;
  result.RoomerStoreUri := activeRoomerDataSet.RoomerStoreUri;
  result.RoomerUri := activeRoomerDataSet.RoomerUri;
  result.OpenApiUri := activeRoomerDataSet.OpenApiUri;
  result.RoomerEntitiesUri := activeRoomerDataSet.RoomerEntitiesUri;
  result.RoomerDatasetsUri := activeRoomerDataSet.RoomerDatasetsUri;
  result.OpenDataset(SqlResult);
  // AssignToDataset(SqlResult, result);
end;

// **********************************************************************

procedure TRoomerDataSet.SetDataActive(const Value: Boolean);
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
  result := FUri;
end;

procedure TRoomerDataSet.SetUri(const Value: String);
begin
  FUri := Value;
end;

function locationName(locationId: word): String;
begin
  if locationId = ftTemplate then
    result := 'templates'
  else if locationId = ftImage then
    result := 'images'
  else if locationId = ftDocument then
    result := 'contracts'
  else if locationId = ftSystem then
    result := 'system'
  else
    result := 'templates';
end;

function TRoomerDataSet.SystemDeleteFile(FileType: word;
  filename: String): Boolean;
begin
  try
    GetAsString(roomerClient,
      FStoreUri + format('store/delete?hotelId=%s&filename=%s&location=%s',
      [FHotelId, EncodeURIComponent(extractFilename(filename)),
      locationName(FileType)]));
    result := true;
  except
    result := false;
  end;
end;

function TRoomerDataSet.SystemRenameFile(FileType: word;
  filename, newFilename: String): Boolean;
begin
  try
    GetAsString(roomerClient,
      FStoreUri + format
      ('store/rename?hotelId=%s&filename=%s&newname=%s&location=%s',
      [FHotelId, EncodeURIComponent(extractFilename(filename)),
      EncodeURIComponent(extractFilename(newFilename)),
      locationName(FileType)]));
    result := true;
  except
    result := false;
  end;
end;

function TRoomerDataSet.SystemDownloadFile(FileType: word;
  sourceFilename, destFilename: String): Boolean;
begin
  result := DownloadFile(roomerClient,
    FStoreUri + format('store/get?hotelId=%s&filename=%s&location=%s',
    [FHotelId, extractFilename(sourceFilename), locationName(FileType)]),
    destFilename);
end;

function TRoomerDataSet.SystemDownloadFileFromURI(URI,
  filename: String): Boolean;
begin
  result := DownloadFile(roomerClient, URI, filename);
end;

function TRoomerDataSet.SystemDownloadRoomerFile(sourceFilename,
  destFilename: String): Boolean;
begin
  result := DownloadFile(roomerClient, FStoreUri + format('store/roomer/%s',
    [extractFilename(sourceFilename)]), destFilename);
end;

function TRoomerDataSet.SystemDownloadRoomerBackup(destFilename
  : String): Boolean;
begin
  result := DownloadFile(roomerClient, FUri + 'pms/business/backup',
    destFilename);
end;

function TRoomerDataSet.SystemRoomerFile(filename: String): TFileEntity;
var
  fileList: TFileList;
begin
  try
    fileList := TFileList.Create(String(GetAsString(roomerClient,
      FStoreUri + format('store/roomerinfo?hotelId=%s&filename=%s',
      [FHotelId, filename]))));
    if fileList.Count > 0 then
      result := fileList.Files[0]
    else
      result := nil;
  except
    result := nil;
  end;
end;

function TRoomerDataSet.SystemFileExists(FileType: word;
  filename: String): Boolean;
var
  s: String;
begin
  s := String(GetAsString(roomerClient,
    FStoreUri + format('store/exists?hotelId=%s&location=%s&filename=%s',
    [FHotelId, locationName(FileType), extractFilename(filename)])));
  result := LowerCase(s) = 'true';
end;

function TRoomerDataSet.SystemListFiles(FileType: word): TFileList;
var
  s: String;
begin
  s := GetAsString(roomerClient,
    FStoreUri + format('store/list?hotelId=%s&location=%s',
    [FHotelId, locationName(FileType)]));
  result := TFileList.Create(s); // SplitStringToTStrings(#10, s);
end;

function TRoomerDataSet.SystemUploadFile(filename: String; FileType: word;
  includeLastModified: Boolean = true): Boolean;
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

  result := UploadFile(roomerClient,
    AnsiString(FStoreUri +
    format('store/save?hotelId=%s&filename=%s&location=%s%s',
    [FHotelId, extractFilename(filename), locationName(FileType), sTimeStamp])),
    filename);
end;

function TRoomerDataSet.SplitMultipleResultIntoDatasets(res : String) : TList<TRoomerDataSet>;
var list : TStrings;
    I : Integer;
    ds : TRoomerDataSet;
begin
  list := SplitStringToTStrings(ROOMER_SPLIT, res);
  try
    result := TList<TRoomerDataSet>.Create;
    for I := 0 to list.Count - 1 do
    begin
      if list[i] <> '' then
      begin
        ds := CreateNewDataset;
        ds.OpenDataset(list[I]);
        result.add(ds);
      end;
    end;
  finally
    list.Free;
  end;
end;

procedure TRoomerDataSet.SystemPrepareChannelRates;
begin
  downloadUrlAsString(  RoomerUri + 'pms/business/prepareChannelRates');
end;


function TRoomerDataSet.ProvideFieldValue(Field: TField; iMaxSize : Integer): String;
var str : String;
begin
  if Field.Value = null then
    result := ''
  else
    case Field.DataType of
      ftString, ftFixedChar, ftWideString, ftVariant, ftFixedWideChar, ftMemo,
        ftWideMemo:
        begin
          if iMaxSize > 0 then
            str := copy(Field.Value, 1, iMaxSize)
          else
            str := Field.Value;
          result := format('''%s''', [StringReplace(str, '''', '\''',
            [rfReplaceAll])]);
        end;
      ftSmallint, ftInteger, ftWord, ftLargeint, ftLongWord, ftShortint, ftByte,
        ftExtended, ftSingle:
        result := Field.Value;
      ftBoolean:
        result := inttostr(ord(Field.AsBoolean));
      ftFloat, ftCurrency:
        result := uStringUtils.FloatToDBString(Field.Value);
      ftDate:
        result := format('''%s''',
          [FormatDateTime('yyyy-mm-dd', Field.AsDateTime)]);
      ftTime:
        result := format('''%s''',
          [FormatDateTime('hh:nn:ss', Field.AsDateTime)]);
      ftDateTime:
        result := format('''%s''', [FormatDateTime('yyyy-mm-dd hh:nn:ss',
          Field.AsDateTime)]);
      ftAutoInc:
        result := '';

    else
      result := format('''%s''', [Field.Value]);
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
  result := sqlList.Add(TRoomerPlanEntity.Create(ptExec, aSql));
end;

function TRoomerExecutionPlan.AddQuery(aSql: String): Integer;
begin
  result := sqlList.Add(TRoomerPlanEntity.Create(ptQuery, aSql));
end;

procedure TRoomerExecutionPlan.BeginTransaction;
begin
  FRoomerDataSet.SystemStartTransaction;
end;

procedure TRoomerExecutionPlan.Clear;
begin
  sqlList.Clear;
  queryResults.Clear;
end;

procedure TRoomerExecutionPlan.CommitTransaction;
begin
  FRoomerDataSet.SystemCommitTransaction;
end;

constructor TRoomerExecutionPlan.Create(_RoomerDataSet: TRoomerDataSet = nil);
begin
  inherited Create;
  queryResults := TRoomerDatasetList.Create(True);
  sqlList := TRoomerPlanEntityList.Create(True);
  FRoomerDataSet := _RoomerDataSet;
end;

destructor TRoomerExecutionPlan.Destroy;
begin
  FRoomerDataset := nil;
  queryResults.Free;
  sqlList.Free;
  inherited;
end;

function TRoomerExecutionPlan.Execute(PlanType: Integer = ptAll;
  transaction: Boolean = false;
  performRollBackOnException: Boolean = false): Boolean;
var
  i: Integer;
  res: String;
  lSQLList: TList<string>;
begin
  if transaction then
    FRoomerDataSet.SystemStartTransaction;
  try
    if PlanType = ptQuery then
    begin
      for i := 0 to QueryCount - 1 do
        queryResults.Add(FRoomerDataSet.CreateNewDataset);

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
      FRoomerDataSet.SystemCommitTransaction;
    result := true;
  except
    on E: Exception do
    begin
      FExecException := E.Message;
      if transaction OR performRollBackOnException then
        FRoomerDataSet.SystemRollbackTransaction;
      result := false;
    end;
  end;
end;

function TRoomerExecutionPlan.GetCount: Integer;
begin
  result := sqlList.Count;
end;

function TRoomerExecutionPlan.GetExecCount: Integer;
var
  i: Integer;
begin
  result := 0;
  for i := 0 to sqlList.Count - 1 do
    if sqlList[i].PlanType = ptExec then
      inc(result);
end;

function TRoomerExecutionPlan.GetQueryCount: Integer;
var
  i: Integer;
begin
  result := 0;
  for i := 0 to sqlList.Count - 1 do
    if sqlList[i].PlanType = ptQuery then
      inc(result);
end;

function TRoomerExecutionPlan.GetResultRoomerDataSet(index: Integer)
  : TRoomerDataSet;
begin
  result := queryResults[index];
end;

function TRoomerExecutionPlan.getSqlsAsTList(PlanType: Integer): TList<String>;
var
  i: Integer;
begin
  Result := TList<String>.Create;
  for i := 0 to sqlList.Count - 1 do
    if sqlList[i].PlanType = PlanType then
      Result.Add(sqlList[i].Sql);
end;

procedure TRoomerExecutionPlan.RollbackTransaction;
begin
  FRoomerDataSet.SystemRollbackTransaction;
end;

{ TRoomerHotelsEntity }

constructor TRoomerHotelsEntity.Create(_hotelCode, _hotelName: String;
  _ownerId: Integer);
begin
  hotelCode := _hotelCode;
  hotelName := _hotelName;
  ownerId := _ownerId;
end;

var recVer: TEXEVersionData;

initialization

begin
  recVer := _GetEXEVersionData(Paramstr(0));
  EXTRA_BUILD_ID := recVer.ExtraBuild;
end;

end.
