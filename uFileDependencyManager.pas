unit uFileDependencyManager;

interface

{$IFDEF DEBUG}
  {$DEFINE ROOMERSTORE}
{$ENDIF}


uses Generics.Collections,
    SysUtils,
    IOUtils,

    IdHTTP,
    IdGlobal,
    IdIOHandler,
    IdIOHandlerSocket,
    IdIOHandlerStack,
    IdSSL,
    IdSSLOpenSSL,

    uFileSystemUtils,
    uG,
    uD,
    PrjConst,
    cmpRoomerDataSet,
    alHttpCommon,
    uDateUtils,
    uFrmResources;

type

   TResourceInfo = class
     Filename : String;
     Timestamp : TDateTime;
     URI : String;
     Size : Integer;
   public
     constructor Create(_Filename : String; _Timestamp : TDateTime; _Size : Integer; _URI : String);
   end;

var fileList : TList<TResourceInfo>;

procedure prepareDependencyManager;
function getAnyFilePath(filename : String) : String;
function getRegistrationFormFilePath(throwExceptionOnError : Boolean = true) : String;
function getForeignInvoiceFilePath(throwExceptionOnError : Boolean = true) : String;
function getLocalInvoiceFilePath(throwExceptionOnError : Boolean = true) : String;
function getGuestListReportFilePath(throwExceptionOnError : Boolean = true) : String;
function getCustomerStayReportFilePath(throwExceptionOnError : Boolean = true) : String;
function getOneCustomerInvoiceFilePath(throwExceptionOnError : Boolean = true) : String;
function getMaidsListReportFilePath(throwExceptionOnError : Boolean = true) : String;
function getHtmlEditorFilePath(throwExceptionOnError : Boolean = true) : String;
procedure sendChangedFile(filename : String);

//procedure _prepareDependencyManager;
//function _getForeignInvoiceFilePath : String;
//function _getLocalInvoiceFilePath : String;
//function _getGuestListReportFilePath : String;
//function _getCustomerStayReportFilePath : String;
//function _getOneCustomerInvoiceFilePath : String;
//function _getMaidsListReportFilePath : String;
//procedure _sendChangedFile(filename : String);

function getRoomerUpgradeAgentFilePath(ToFile : String) : String;
function getRoomerVersionXmlFilePath(ToFile : String) : String;
function getAnyFileFromRoomerStore(FromFile, ToFile : String) : String;

procedure ResetDependencyFileList;

implementation

uses
   uManageFilesOnServer
  , uAPIDataHandler
  , uUtils
  , uRunWithElevatedOption
  , Forms
  , Dialogs
  ;

{$IFNDEF ROOMERSTORE}
procedure prepareDependencyManager;
begin
  ReadFileList(d.roomerMainDataSet, rftTemplates);
end;

procedure AssertResource;
begin
  if (_FileType <> rftTemplates) OR (_FileList=nil) then
    prepareDependencyManager;
end;

procedure ResetDependencyFileList;
begin
  _FileList.Free; _FileList := nil;
  prepareDependencyManager;
end;

function getRegistrationFormFilePath : String;
begin
  AssertResource;
  result := getFilePath('Registration_Form.fr3'); //g.qInvoiceFormFileERL);
end;

function getForeignInvoiceFilePath : String;
begin
  AssertResource;
  result := getFilePath('erlInvoice.fr3'); //g.qInvoiceFormFileERL);
end;

function getLocalInvoiceFilePath : String;
begin
  AssertResource;
  result := getFilePath('islInvoice.fr3'); //g.qInvoiceFormFileISL);
end;

function getGuestListReportFilePath : String;
begin
  AssertResource;
  result := getFilePath('rptResGuests01.fr3');
end;

function getCustomerStayReportFilePath : String;
begin
  AssertResource;
  result := getFilePath('rptCustomerStayInvoice.fr3');
end;

function getOneCustomerInvoiceFilePath : String;
begin
  AssertResource;
  result := getFilePath('rptOneCustInvoice.fr3');
end;

function getMaidsListReportFilePath : String;
begin
  AssertResource;
  result := getFilePath('rptMaidList001.fr3');
end;


{$ELSE}
procedure ReadFilesFromStaticResources;
var ASet : TRoomerDataSet;
begin
  fileList.Clear;
  ASet := CreateNewDataSet;
  try
    ASet.OpenDataset(ASet.SystemGetStaticResourcesFiltered(ANY_FILE));
    ASet.First;
    while NOT ASet.Eof do
    begin
      fileList.Add(TResourceInfo.Create(ASet['ORIGINAL_NAME'],
                                        ASet['LAST_MODIFIED'],
                                        0,
                                        ASet['URI']));
      ASet.Next;
    end;
  finally
    FreeAndNil(ASet);
  end;
end;

procedure prepareDependencyManager;
var ASet : TRoomerDataSet;
begin
  if d.roomerMainDataSet.OfflineMode then
    exit;

  ReadFilesFromStaticResources;
  try
  if fileList.Count = 0 then
  begin
    UploadKnownFilesToStaticResourceBundle(d.roomerMainDataSet);
    ReadFilesFromStaticResources;
  end;
  except
    // Ignore any error here!
  end;
end;

procedure AssertResource;
begin
  if fileList.Count = 0 then
    prepareDependencyManager;
end;

procedure ResetDependencyFileList;
begin
  fileList.Clear;
  prepareDependencyManager;
end;

function findFile(filename: String) : TResourceInfo;
var i : integer;
begin
  result := nil;
  for i := 0 to fileList.Count - 1 do
    if Lowercase(fileList[i].Filename) = Lowercase(filename) then
    begin
      result := fileList[i];
      Break;
    end;

end;

var wasDownloaded : Boolean;

function getFullFilename(filename : String) : String;
begin
    filename := ExtractFileName(filename);
    result := TPath.Combine(GetCurrenctRoomerPath, filename);
end;

function getFilePath(filename : String; throwExceptionOnError : Boolean) : String;
var sFullFilename : String;
    DateOfFile : TDateTime;
    RemoteFile : TResourceInfo;
begin
  result := '';
  wasDownloaded := False;
  try
    if fileList.Count = 0 then
      raise Exception.Create(GetTranslatedText('shTx_ManageFiles_RetrieveList'));
    filename := ExtractFileName(filename);
    sFullFilename := TPath.Combine(GetCurrenctRoomerPath, filename);
    if uFileSystemUtils.GetFileSize(sFullFilename) = 0 then
      DeleteFile(sFullFilename);

    DateOfFile := 0;
    if FileExists(sFullFilename) then
      FileAge(sFullFilename, DateOfFile);

    RemoteFile := findFile(filename);
    if RemoteFile = nil then
      result := ''
    else
    begin
      if DateTimeToComparableString(DateOfFile) <> DateTimeToComparableString(RemoteFile.Timestamp) then
      begin
        d.roomerMainDataSet.DownloadFileResourceOpenAPI(RemoteFile.URI, sFullFilename);
        TouchFile(sFullFilename, RemoteFile.Timestamp);
        wasDownloaded := True;
      end;
      result := sFullFilename;
    end;
  except
    On Ex : Exception do
    begin
      if throwExceptionOnError then
        raise Ex;
    end;
  end;
end;

function getAnyFilePath(filename : String) : String;
begin
  AssertResource;
  result := getFilePath(filename, true); //g.qInvoiceFormFileERL);
end;

const REG_FORM_NAME = 'Registration_Form.fr3';

function getRegistrationFormFilePath(throwExceptionOnError : Boolean = true) : String;
var error : Boolean;
    FullFilename : String;
begin
  AssertResource;
  error := False;
  try
    result := getFilePath(REG_FORM_NAME, false); // throwExceptionOnError);
  except
    error := True;
  end;
  FullFilename := getFullFilename(REG_FORM_NAME);
  if error OR (result='') OR (GetFileSize(FullFilename)<10) then
  begin
    d.roomerMainDataSet.SystemDownloadFileFromURI('http://roomerstore.com/Registration_Form.fr3', FullFilename);
    sendChangedFile(FullFilename);
    result := FullFilename;
  end;
end;

function getForeignInvoiceFilePath(throwExceptionOnError : Boolean = true) : String;
begin
  AssertResource;
  result := getFilePath('erlInvoice.fr3', throwExceptionOnError); //g.qInvoiceFormFileERL);
end;

function getLocalInvoiceFilePath(throwExceptionOnError : Boolean = true) : String;
begin
  AssertResource;
  result := getFilePath('islInvoice.fr3', throwExceptionOnError); //g.qInvoiceFormFileISL);
end;

function getGuestListReportFilePath(throwExceptionOnError : Boolean = true) : String;
begin
  AssertResource;
  result := getFilePath('rptResGuests01.fr3', throwExceptionOnError);
end;

function getCustomerStayReportFilePath(throwExceptionOnError : Boolean = true) : String;
begin
  AssertResource;
  result := getFilePath('rptCustomerStayInvoice.fr3', throwExceptionOnError);
end;

function getOneCustomerInvoiceFilePath(throwExceptionOnError : Boolean = true) : String;
begin
  AssertResource;
  result := getFilePath('rptOneCustInvoice.fr3', throwExceptionOnError);
end;

function getMaidsListReportFilePath(throwExceptionOnError : Boolean = true) : String;
begin
  AssertResource;
  result := getFilePath('rptMaidList001.fr3', throwExceptionOnError);
end;

function getFileInfoViaHead(filename : String) : TResourceInfo;
var http : TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1 : TIdSSLIOHandlerSocketOpenSSL;
    URI : String;
begin
  http := TIdHTTP.Create(nil);
  try
    IdSSLIOHandlerSocketOpenSSL1 := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    try
      http.IOHandler := IdSSLIOHandlerSocketOpenSSL1;
      http.Request.Accept := 'text/html,application/xhtml+xml,application/xml;application/octed-stream;q=0.9,*/*;q=0.8';
      http.Request.Referer := 'Mozilla/3.0 (compatible; Roomer PMS)';
      http.HTTPOptions := [hoForceEncodeParams];

      URI := 'http://roomerstore.com/' + filename;
      http.Head(URI);
      result := TResourceInfo.Create(filename, http.Response.LastModified, http.Response.ContentLength, URI);
    finally
      IdSSLIOHandlerSocketOpenSSL1.Free;
    end;
  finally
    http.Free;
  end;
end;

function getExeFilePath(filename, toFile : String) : String;
var sFullFilename : String;
    DateOfFile : TDateTime;
    RemoteFile : TResourceInfo;
begin
  wasDownloaded := False;
  filename := ExtractFileName(filename);
  sFullFilename := ToFile; // TPath.Combine(GetCurrenctRoomerPath, filename);
  DateOfFile := 0;
  if FileExists(sFullFilename) then
    FileAge(sFullFilename, DateOfFile);

  RemoteFile := getFileInfoViaHead(filename);
  if RemoteFile = nil then
    result := ''
  else
  begin
    if DateTimeToComparableString(DateOfFile) <> DateTimeToComparableString(RemoteFile.Timestamp) then
    begin
      d.roomerMainDataSet.SystemDownloadFileFromURI(RemoteFile.URI, sFullFilename);
      TouchFile(sFullFilename, RemoteFile.Timestamp);
      wasDownloaded := True;
    end;
    result := sFullFilename;
  end;
end;


//function getHtmlEditorFilePath(throwExceptionOnError : Boolean = true) : String;
//var sPath, regApp, parameters : String;
//begin
//  sPath := TPath.Combine(LocalAppDataPath, 'Roomer');
//  forceDirectories(sPath);
//  parameters := TPath.Combine(sPath, 'RoomerHtmlEdit.ocx');
//  result := getExeFilePath('RoomerHtmlEdit.ocx', parameters);
//
//  if ((result <> '') AND wasDownloaded) then
//  begin
//    regApp := GetSystemPath + 'regsvr32.exe';
//    parameters := '/s ' + DoubleQuoteIfNeeded(result);
//    ShowMessage('Romer PMS needs to register a tool for editing rich text document.' + #13 +
//                'When/if a security warning message is shown, please select [Yes] for a successful registration.');
//    ExecuteFile(Application.MainForm.Handle, regApp, parameters, [eoElevate]);
//  end;
//end;

function getHtmlEditorFilePath(throwExceptionOnError : Boolean = true) : String;
var sPath, regApp, parameters : String;
begin
  sPath := TPath.Combine(LocalAppDataPath, 'Roomer');
  forceDirectories(sPath);
  parameters := TPath.Combine(sPath, 'RoomerHtmlEditorControl.dll');
  result := getExeFilePath('RoomerHtmlEditorControl.dll', parameters);

  parameters := TPath.Combine(sPath, 'Microsoft.mshtml.dll');
  result := getExeFilePath('Microsoft.mshtml.dll', parameters);

  parameters := TPath.Combine(sPath, 'RoomerHtmlEditor.exe');
  result := getExeFilePath('RoomerHtmlEditor.exe', parameters);


//  if ((result <> '') AND wasDownloaded) then
//  begin
//    regApp := GetSystemPath + 'regsvr32.exe';
//    parameters := '/s ' + DoubleQuoteIfNeeded(result);
//    ShowMessage('Romer PMS needs to register a tool for editing rich text document.' + #13 +
//                'When/if a security warning message is shown, please select [Yes] for a successful registration.');
//    ExecuteFile(Application.MainForm.Handle, regApp, parameters, [eoElevate]);
//  end;
end;



{$ENDIF}

// *********************************************************************

{$IFDEF ROOMERSTORE}
function getRoomerUpgradeAgentFilePath(ToFile : String) : String;
begin
  result := getExeFilePath('RoomerUpgradeAgent.exe', ToFile);
end;

function getRoomerVersionXmlFilePath(ToFile : String) : String;
begin
  result := getExeFilePath('Roomer.xml', ToFile);
end;

function getAnyFileFromRoomerStore(FromFile, ToFile : String) : String;
begin
  result := getExeFilePath(FromFile, ToFile);
end;

procedure sendChangedFile(filename : String);
var FrmResources: TFrmResources;
    Resource : TResourceInfo;
begin
  FrmResources := TFrmResources.Create(nil);
  try
    FrmResources.keyString := ANY_FILE;
    FrmResources.access := ACCESS_RESTRICTED;

    FrmResources.RemoveFileForUpload(filename);
    FrmResources.UploadFile(ANY_FILE, ACCESS_RESTRICTED, filename);

    ReadFilesFromStaticResources;
    Resource := findFile(ExtractFilename(filename));
    if Assigned(Resource) then
      TouchFile(filename, Resource.Timestamp);
  finally
    FreeAndNil(FrmResources);
  end;
end;


{$ELSE}

procedure prepareRoomerDependencyManager;
begin
  ReadFileList(d.roomerMainDataSet, rftRoomer);
end;

function getRoomerUpgradeAgentFilePath(ToFile : String) : String;
begin
  prepareRoomerDependencyManager;
  result := getilePath('RoomerUpgradeAgent.exe', ToFile);
end;

function getRoomerVersionXmlFilePath(ToFile : String) : String;
begin
  prepareRoomerDependencyManager;
  result := getExeFilePath('Roomer.xml', ToFile);
end;

function getAnyFuleFromRoomerStore(FromFile, ToFile : String) : String;
begin
  prepareRoomerDependencyManager;
  result := getExeFilePath(FromFile, ToFile);
end;

procedure sendChangedFile(filename : String);
begin
  d.roomerMainDataSet.SystemUploadFile(filename, ORD(rftTemplates));
end;

{$ENDIF}


// *********************************************************************

{ TResourceInfo }

constructor TResourceInfo.Create(_Filename : String; _Timestamp: TDateTime; _Size: Integer; _URI : String);
begin
  inherited Create;
  Filename := _Filename;
  Timestamp := _Timestamp;
  Size := _Size;
  URI := _URI;
end;

initialization

  fileList := TList<TResourceInfo>.Create;

finalization
  fileList.Clear;
  fileList.Free;

end.
