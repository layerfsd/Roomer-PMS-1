unit uFileDependencyManager;

interface

{$INCLUDE roomer.inc}


uses
  Generics.Collections,
  SysUtils
  ;

type
  EFileDependencyManagerException = class(Exception);

  TFileDependencymanager = class(TObject)
  type
    TResourceInfo = class
      Filename: String;
      Timestamp: TDateTime;
      URI: String;
      Size: Integer;
    public
      constructor Create(const _Filename: String; _Timestamp: TDateTime; _Size: Integer; const _URI: String);
    end;
  private
    FFileList: TObjectList<TResourceInfo>;

    procedure prepareDependencyManager;

    procedure AssertResourcesPrepared;
    function findFile(const Filename: String): TResourceInfo;
    function getExeFilePath(const Filename, toFile: String): String;
    function getFileInfoViaHead(const Filename: String): TResourceInfo;
    function getFilePath(const Filename: String; throwExceptionOnError: Boolean): String;
    function getFullFilename(const Filename: String): String;
    procedure ReadFilesFromStaticResources;

  public
    constructor Create;
    destructor Destroy; override;

    function getHtmlEditorFilePath(throwExceptionOnError: Boolean = true): String;
    procedure ResetDependencyFileList;
    function getForeignInvoiceFilePath(throwExceptionOnError: Boolean = true): String;
    function getLocalInvoiceFilePath(throwExceptionOnError: Boolean = true): String;
    procedure sendChangedFile(const Filename: String);
    function getRegistrationFormFilePath(throwExceptionOnError: Boolean = true): String;
    function getGuestListReportFilePath(throwExceptionOnError: Boolean = true): String;
    function getCustomerStayReportFilePath(throwExceptionOnError: Boolean = true): String;
    function getOneCustomerInvoiceFilePath(throwExceptionOnError: Boolean = true): String;
    function getMaidsListReportFilePath(throwExceptionOnError: Boolean = true): String;
    function getAnyFileFromRoomerStore(const FromFile, toFile: String): String;
    function getRoomerUpgradeAgentFilePath(const toFile: String): String;
    function getRoomerVersionXmlFilePath(const toFile: String): String;

  end;

function FileDependencyManager: TFileDependencymanager;

implementation

uses
  cmpRoomerDataSet
  , uManageFilesOnServer
  , uResourceManagement
  , IOUtils
  , IdHTTP
  , IdSSLOpenSSL
  , uFileSystemUtils
  , uD
  , PrjConst
  , uDateUtils
  , uFrmResources
  ;

var
  gFileDependencyMgr: TFileDependencymanager;

function FileDependencyManager: TFileDependencymanager;
begin
  if not assigned(gFileDependencyMgr) then
    gFileDependencyMgr := TFileDependencymanager.Create;

  Result := gFileDependencyMgr;
end;

procedure TFileDependencymanager.ReadFilesFromStaticResources;
var
  ASet: TRoomerDataSet;
begin
  FFileList.Clear;
  ASet := CreateNewDataSet;
  try
    ASet.OpenDataset(ASet.SystemGetStaticResourcesFiltered(ANY_FILE));
    ASet.First;
    while NOT ASet.Eof do
    begin
      FFileList.Add(TResourceInfo.Create(ASet['ORIGINAL_NAME'],
        ASet['LAST_MODIFIED'],
        0,
        ASet['URI']));
      ASet.Next;
    end;
  finally
    FreeAndNil(ASet);
  end;
end;

procedure TFileDependencymanager.prepareDependencyManager;
begin
  if d.roomerMainDataSet.OfflineMode then
    exit;

  ReadFilesFromStaticResources;
  try
    if FFileList.Count = 0 then
    begin
      UploadKnownFilesToStaticResourceBundle(d.roomerMainDataSet);
      ReadFilesFromStaticResources;
    end;
  except
    // Ignore any error here!
  end;
end;

procedure TFileDependencymanager.AssertResourcesPrepared;
begin
  if FFileList.Count = 0 then
    prepareDependencyManager;
end;

procedure TFileDependencymanager.ResetDependencyFileList;
begin
  FFileList.Clear;
  prepareDependencyManager;
end;

function TFileDependencymanager.findFile(const Filename: String): TResourceInfo;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FFileList.Count - 1 do
    if Lowercase(FFileList[i].Filename) = Lowercase(Filename) then
    begin
      Result := FFileList[i];
      Break;
    end;

end;

function TFileDependencymanager.getFullFilename(const Filename: String): String;
begin
  Result := ExtractFileName(Filename);
  Result := TPath.Combine(GetCurrenctRoomerPath, Result);
end;

function TFileDependencymanager.getFilePath(const Filename: String; throwExceptionOnError: Boolean): String;
var
  sFullFilename: String;
  DateOfFile: TDateTime;
  RemoteFile: TResourceInfo;
begin
  Result := '';
  try
    if FFileList.Count = 0 then
      raise EFileDependencyManagerException.Create(GetTranslatedText('shTx_ManageFiles_RetrieveList'));
    sFullFilename := ExtractFileName(Filename);
    sFullFilename := TPath.Combine(GetCurrenctRoomerPath, sFullFilename);
    if uFileSystemUtils.GetFileSize(sFullFilename) = 0 then
      DeleteFile(sFullFilename);

    DateOfFile := 0;
    if FileExists(sFullFilename) then
      FileAge(sFullFilename, DateOfFile);

    RemoteFile := findFile(Filename);
    if RemoteFile = nil then
      Result := ''
    else
    begin
      if DateTimeToComparableString(DateOfFile) <> DateTimeToComparableString(RemoteFile.Timestamp) then
      begin
        d.roomerMainDataSet.DownloadFileResourceOpenAPI(RemoteFile.URI, sFullFilename);
        TouchFile(sFullFilename, RemoteFile.Timestamp);
      end;
      Result := sFullFilename;
    end;
  except
    On Ex: Exception do
    begin
      if throwExceptionOnError then
        raise EFileDependencyManagerException.Create(Ex.Message);
    end;
  end;
end;

const
  REG_FORM_NAME = 'Registration_Form.fr3';

function TFileDependencymanager.getRegistrationFormFilePath(throwExceptionOnError: Boolean = true): String;
var
  error: Boolean;
  FullFilename: String;
begin
  AssertResourcesPrepared;
  error := False;
  try
    Result := getFilePath(REG_FORM_NAME, False); // throwExceptionOnError);
  except
    error := true;
  end;
  FullFilename := getFullFilename(REG_FORM_NAME);
  if error OR (Result = '') OR (GetFileSize(FullFilename) < 10) then
  begin
    d.roomerMainDataSet.SystemDownloadFileFromURI('http://roomerstore.com/Registration_Form.fr3', FullFilename);
    sendChangedFile(FullFilename);
    Result := FullFilename;
  end;
end;

function TFileDependencymanager.getForeignInvoiceFilePath(throwExceptionOnError: Boolean = true): String;
begin
  AssertResourcesPrepared;
  Result := getFilePath('erlInvoice.fr3', throwExceptionOnError); // g.qInvoiceFormFileERL);
end;

function TFileDependencymanager.getLocalInvoiceFilePath(throwExceptionOnError: Boolean = true): String;
begin
  AssertResourcesPrepared;
  Result := getFilePath('islInvoice.fr3', throwExceptionOnError); // g.qInvoiceFormFileISL);
end;

function TFileDependencymanager.getGuestListReportFilePath(throwExceptionOnError: Boolean = true): String;
begin
  AssertResourcesPrepared;
  Result := getFilePath('rptResGuests01.fr3', throwExceptionOnError);
end;

function TFileDependencymanager.getCustomerStayReportFilePath(throwExceptionOnError: Boolean = true): String;
begin
  AssertResourcesPrepared;
  Result := getFilePath('rptCustomerStayInvoice.fr3', throwExceptionOnError);
end;

function TFileDependencymanager.getOneCustomerInvoiceFilePath(throwExceptionOnError: Boolean = true): String;
begin
  AssertResourcesPrepared;
  Result := getFilePath('rptOneCustInvoice.fr3', throwExceptionOnError);
end;

function TFileDependencymanager.getMaidsListReportFilePath(throwExceptionOnError: Boolean = true): String;
begin
  AssertResourcesPrepared;
  Result := getFilePath('rptMaidList001.fr3', throwExceptionOnError);
end;

function TFileDependencymanager.getFileInfoViaHead(const Filename: String): TResourceInfo;
var
  http: TIdHTTP;
  IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
  URI: String;
begin
  http := TIdHTTP.Create(nil);
  try
    IdSSLIOHandlerSocketOpenSSL1 := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    try
      http.IOHandler := IdSSLIOHandlerSocketOpenSSL1;
      http.Request.Accept := 'text/html,application/xhtml+xml,application/xml;application/octed-stream;q=0.9,*/*;q=0.8';
      http.Request.Referer := 'Mozilla/3.0 (compatible; Roomer PMS)';
      http.HTTPOptions := [hoForceEncodeParams];

      URI := 'http://roomerstore.com/' + Filename;
      http.Head(URI);
      Result := TResourceInfo.Create(Filename, http.Response.LastModified, http.Response.ContentLength, URI);
    finally
      IdSSLIOHandlerSocketOpenSSL1.Free;
    end;
  finally
    http.Free;
  end;
end;

function TFileDependencymanager.getExeFilePath(const Filename, toFile: String): String;
var
  sFullFilename: String;
  DateOfFile: TDateTime;
  RemoteFile: TResourceInfo;
begin
  sFullFilename := ExtractFileName(Filename);
  DateOfFile := 0;
  if FileExists(toFile) then
    FileAge(toFile, DateOfFile);

  RemoteFile := getFileInfoViaHead(sFullFilename);
  try
    if RemoteFile = nil then
      Result := ''
    else
    begin
      if DateTimeToComparableString(DateOfFile) <> DateTimeToComparableString(RemoteFile.Timestamp) then
      begin
        d.roomerMainDataSet.SystemDownloadFileFromURI(RemoteFile.URI, toFile);
        TouchFile(toFile, RemoteFile.Timestamp);
      end;
      Result := toFile;
    end;
  finally
    RemoteFile.Free;
  end;
end;

function TFileDependencymanager.getHtmlEditorFilePath(throwExceptionOnError: Boolean = true): String;
var
  sPath, parameters: String;
begin
  sPath := TPath.Combine(LocalAppDataPath, 'Roomer');
  forceDirectories(sPath);
  parameters := TPath.Combine(sPath, 'RoomerHtmlEditorControl.dll');
  getExeFilePath('RoomerHtmlEditorControl.dll', parameters);

  parameters := TPath.Combine(sPath, 'Microsoft.mshtml.dll');
  getExeFilePath('Microsoft.mshtml.dll', parameters);

  parameters := TPath.Combine(sPath, 'RoomerHtmlEditor.exe');
  Result := getExeFilePath('RoomerHtmlEditor.exe', parameters);
end;


// *********************************************************************

function TFileDependencymanager.getRoomerUpgradeAgentFilePath(const toFile: String): String;
begin
  Result := getExeFilePath('RoomerUpgradeAgent.exe', toFile);
end;

function TFileDependencymanager.getRoomerVersionXmlFilePath(const toFile: String): String;
begin
  Result := getExeFilePath('Roomer.xml', toFile);
end;

function TFileDependencymanager.getAnyFileFromRoomerStore(const FromFile, toFile: String): String;
begin
  Result := getExeFilePath(FromFile, toFile);
end;

procedure TFileDependencymanager.sendChangedFile(const Filename: String);
var
  FrmResources: TFrmResources;
  Resource: TResourceInfo;
begin
  FrmResources := TFrmResources.Create(nil);
  try
    FrmResources.keyString := ANY_FILE;
    FrmResources.access := ACCESS_RESTRICTED;
    FrmResources.ResourceParameters := nil;
    FrmResources.PrepareUserInterface;

    FrmResources.RemoveFileForUpload(Filename);
    UploadFileToResources(ANY_FILE, ACCESS_RESTRICTED, ExtractFileName(Filename), Filename);

    ReadFilesFromStaticResources;
    Resource := findFile(ExtractFileName(Filename));
    if assigned(Resource) then
      TouchFile(Filename, Resource.Timestamp);
  finally
    FreeAndNil(FrmResources);
  end;
end;

// *********************************************************************

{ TResourceInfo }

constructor TFileDependencymanager.TResourceInfo.Create(const _Filename: String; _Timestamp: TDateTime; _Size: Integer;
  const _URI: String);
begin
  Filename := _Filename;
  Timestamp := _Timestamp;
  Size := _Size;
  URI := _URI;
end;

{ TFileDependencymanager }

constructor TFileDependencymanager.Create;
begin
  FFileList := TObjectList<TResourceInfo>.Create(true);
end;

destructor TFileDependencymanager.Destroy;
begin
  FFileList.Free;
  inherited;
end;

initialization

finalization
  gFileDependencyMgr.Free;

end.
