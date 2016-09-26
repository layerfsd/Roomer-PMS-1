unit uAboutRoomer;

interface

{$include roomer.inc}

uses
    Winapi.Windows
  , Winapi.Messages
  , ShellApi
  , System.SysUtils
  , System.Variants
  , System.Classes
  , Vcl.Graphics
  , Vcl.Controls
  , Vcl.Forms
  , Vcl.Dialogs
  , Vcl.Menus
  , Vcl.StdCtrls
  , Vcl.ExtCtrls
  , sLabel
  , acPNG
  , cmpRoomerDataSet
  , MSXML2_TLB
  , dxGDIPlusClasses

  ;

type
  TfrmAboutRoomer = class(TForm)
    LabDBVerName: TsLabel;
    LabCopyRight: TsLabel;
    labCopyright2: TsLabel;
    Label1: TsLabel;
    sLabel1: TsLabel;
    LabSupportHomepage: TsWebLabel;
    LabSupportEmail: TsWebLabel;
    sLabel2: TsLabel;
    sLabel3: TsLabel;
    sLabel4: TsLabel;
    lblEndpoint: TsLabel;
    Image1: TImage;
    labExtraBuild: TsLabel;
    labExtraBuildText: TsLabel;
    procedure btnCloseClick(Sender: TObject);
    procedure LabSupportHomepageClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure LabSupportEmailClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LabDBVerNameMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
  private
    function getSpecialVersionInfo(filename, StringName: String): String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAboutRoomer: TfrmAboutRoomer;

procedure ShowRoomerAboutBox;
procedure downloadCurrentVersion(Handle : THandle; RoomerDataSet : TRoomerDataSet);
function checkNewVersion(Handle : THandle; RoomerDataSet : TRoomerDataSet) : boolean;
function findVersionOfRoomerOnServer(xml: IXMLDOMDocument2; RoomerDataSet : TRoomerDataSet) : String;
procedure StartRemoteSupport(Handle : THandle; RoomerDataSet : TRoomerDataSet);
procedure ShowDashboard(Handle : THandle; RoomerDataSet : TRoomerDataSet);
procedure SetIgnoresToZero(RoomerDataSet : TRoomerDataSet);

implementation

{$R *.dfm}

uses uMain
     , ActiveX
     , uRunWithElevatedOption
     , uFileDependencyManager
     , System.IOUtils
     , uFileSystemUtils
     , uStringUtils
     , uAPIDataHandler
     , IdGlobalProtocols
     , uSplashRoomer
     , uD
     , uRoomerLanguage
     , uRegistryServices
     , PrjConst
     , uUtils
     , _Glob
     , VersionInfo
     , Math
     ;

const MAX_NUMBER_OF_IGNORES = 10;
      WARNING_IGNORES = 5;

procedure ShowRoomerAboutBox;
begin
  Application.CreateForm(TfrmAboutRoomer, frmAboutRoomer);
  try
    frmAboutRoomer.ShowModal;
  finally
    frmAboutRoomer.free;
  end;
end;

procedure TfrmAboutRoomer.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAboutRoomer.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
end;

function TfrmAboutRoomer.getSpecialVersionInfo(filename, StringName : String) : String;
var verInfo : TVersionInfo;
begin
  verInfo := TVersionInfo.Create(nil);
  verInfo.FileName := filename;
  result := verInfo.StringFileInfo[StringName];
end;

procedure TfrmAboutRoomer.FormShow(Sender: TObject);
begin
  lblEndpoint.Caption := d.roomerMainDataSet.RoomerUri;
  LabDBVerName.Caption := getVersion(Application.ExeName);
  labExtraBuild.Caption := getSpecialVersionInfo(Application.ExeName,'ExtraBuild');
end;

procedure TfrmAboutRoomer.LabDBVerNameMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then
  begin
    uStringUtils.ClipboardCopy(LabDBVerName.Caption);
    ShowMessage(GetTranslatedText('shTx_AboutRoomer_CopyPMSVersion'));
  end
  else
    btnCloseClick(Sender);
end;

procedure TfrmAboutRoomer.Label1Click(Sender: TObject);
begin
  checkNewVersion(handle, TRoomerDataSet.Create(nil));
end;

procedure ShowDashboard(Handle : THandle; RoomerDataSet : TRoomerDataSet);
var
    filename : String;
    parameters : String;
    sPath,
    DashboardExeFilenameAndPath : String;
begin
  filename := 'RoomerDashboard.exe';
  sPath := TPath.Combine(LocalAppDataPath, 'Roomer');
  forceDirectories(sPath);

  parameters := format('hotel=%s host=%s port=%s user=%s pass=%s date=2014-01-01',
           [RoomerDataset.hotelId,
            _RoomerBase,
            _RoomerBasePort,
            RoomerDataset.Username,
            RoomerDataset.Password ]);

  DashboardExeFilenameAndPath := TPath.Combine(sPath, filename);
  FileDependencymanager.getAnyFileFromRoomerStore(filename, DashboardExeFilenameAndPath);
  ExecuteFile(Handle, DashboardExeFilenameAndPath, parameters, []);
end;



procedure TfrmAboutRoomer.LabSupportEmailClick(Sender: TObject);
begin
  ShellExecute(Self.WindowHandle, 'open', PChar('mailto:' + TsWebLabel(Sender).Caption), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmAboutRoomer.LabSupportHomepageClick(Sender: TObject);
begin
  ShellExecute(Self.WindowHandle, 'open', PChar('http://' + TsWebLabel(Sender).Caption), nil, nil, SW_SHOWNORMAL);
end;

procedure StartRemoteSupport(Handle : THandle; RoomerDataSet : TRoomerDataSet);
var
    filename : String;
    language : String;
    sPath,
    RemoteSupportFilenameAndPath : String;
begin
  language := LowerCase(copy(RoomerLanguage.LanguageCode, 1, 2));
  if trim(language) = '' then
    language := 'en';
  filename := format('RoomerQS%s.exe', [language]);
  sPath := TPath.Combine(LocalAppDataPath, 'Roomer');
  forceDirectories(sPath);
  RemoteSupportFilenameAndPath := TPath.Combine(sPath, filename);
  FileDependencymanager.getAnyFileFromRoomerStore(filename, RemoteSupportFilenameAndPath);
  ExecuteFile(Handle, RemoteSupportFilenameAndPath, '', []);
end;

procedure downloadCurrentVersion(Handle : THandle; RoomerDataSet : TRoomerDataSet);
var
    sPath,
    UpgradeManagerPath : String;
begin
  try
    frmMain.RemoveLanguagesFilesAndRefresh(False);
    sPath := TPath.Combine(LocalAppDataPath, 'Roomer');
    forceDirectories(sPath);
    UpgradeManagerPath := TPath.Combine(sPath, 'RoomerUpgradeAgent.exe');
    FileDependencymanager.getRoomerUpgradeAgentFilePath(UpgradeManagerPath);
    ExecuteFile(Handle, UpgradeManagerPath, '"' + Application.ExeName + '"', [eoElevate]);
  except
  end;
end;

procedure SetIgnoresToZero(RoomerDataSet : TRoomerDataSet);
var sTempName : String;
    xml: IXMLDOMDocument2;
    currentVersion, version : String;
begin
  sTempName := GetEnvironmentVariable('TEMP') + '\roomerversion.xml';

  try
    FileDependencymanager.getRoomerVersionXmlFilePath(sTempName);
  except
    exit;
  end;

  currentVersion := getVersion(Application.ExeName);
  xml := CreateXmlDocument; // CoDOMDocument40.Create;
  xml.Load(sTempName);
  try

    version := findVersionOfRoomerOnServer(xml, RoomerDataSet);
    if version <> currentVersion then
    begin
    (*  if MessageDlg('There is a new version of ROOMER (' + version + ').' + #13#10 +
                    'ROOMER needs to be updated.' + #13#10#13#10 +
                    'Click [OK] to perform the update now.'+ #13#10 +
                    'Click [Cancel] to do this later', mtConfirmation, [mbOK,mbCancel], 0) = mrOk then *)
      with TRoomerRegistryIniFile.Create(GetRoomerIniFilename) do
      try
        WriteInteger('RoomerPMSVersion', version, 0);
      finally
        Free;
      end;
    end;
  except

  end;
end;

/// return which version string (aa.bb.cc.ddddd) is higher
function CompareVersionStrings(const aVersion1, aVersion2: string): integer;
var
  lvlist1, lvList2: TStringlist;
  i: integer;
begin
  result := 0;

  if aVersion1.Equals(aVersion2) then
    exit;

  lvList1 := TStringlist.create;
  lvList2 := TStringlist.create;
  try
    lvList1.Delimiter := '.';
    lvList2.Delimiter := '.';

    lvlist1.DelimitedText := aVersion1;
    lvlist2.DelimitedText := aVersion2;

    for i := 0 to max(lvlist1.count, lvlist2.count)-1 do
    begin
      if StrToInt(lvlist1[i]) <> StrToInt(lvList2[i]) then
      begin
        Result := StrToInt(lvlist1[i]) - StrToInt(lvList2[i]);
        Break;
      end;
    end;
  finally
    lvList1.Free;
    lvList2.Free;
  end;


end;


function checkNewVersion(Handle : THandle; RoomerDataSet : TRoomerDataSet) : boolean;
{$IFNDEF DEBUG}
var sTempName : String;
    xml: IXMLDOMDocument2;
    node : IXMLDomNode;
    currentVersion, version : String;
    FileInfo : TFileEntity;
    sPath,
    UpgradeManagerPath : String;
    NumDialogShown : Integer;
    s : String;
    Buttons: TMsgDlgButtons;
{$ENDIF}
begin
  result := false;
{$IFNDEF DEBUG}
  sTempName := GetEnvironmentVariable('TEMP') + '\roomerversion.xml';

  try
    FileDependencyManager.getRoomerVersionXmlFilePath(sTempName);
  except
    exit;
  end;

  currentVersion := getVersion(Application.ExeName);
  xml := CreateXmlDocument; // CoDOMDocument40.Create;
  xml.Load(sTempName);
  try

    version := findVersionOfRoomerOnServer(xml, RoomerDataSet);
    DebugMEssage('Server: ' + version + '  Local: ' + currentVersion);
//    if CompareVersionStrings(version, currentVersion) > 0 then
    if version <> currentVersion then
    begin
    (*  if MessageDlg('There is a new version of ROOMER (' + version + ').' + #13#10 +
                    'ROOMER needs to be updated.' + #13#10#13#10 +
                    'Click [OK] to perform the update now.'+ #13#10 +
                    'Click [Cancel] to do this later', mtConfirmation, [mbOK,mbCancel], 0) = mrOk then *)
      with TRoomerRegistryIniFile.Create(GetRoomerIniFilename) do
      try
        NumDialogShown := ReadInteger('RoomerPMSVersion', version, 0) + 1;
      finally
        Free;
      end;

      if NumDialogShown > MAX_NUMBER_OF_IGNORES then
      begin
        s := format(GetTranslatedText('shTx_AboutRoomer_NewVersionAvailableExpired'), [version, MAX_NUMBER_OF_IGNORES]);
        Buttons := [mbOK];
      end else
      if NumDialogShown > WARNING_IGNORES then
      begin
        s := format(GetTranslatedText('shTx_AboutRoomer_NewVersionAvailableExpireWarning'), [version, NumDialogShown - 1, MAX_NUMBER_OF_IGNORES - (NumDialogShown - 1)]);
        Buttons := [mbOK,mbCancel];
      end else
      begin
        s := format(GetTranslatedText('shTx_AboutRoomer_NewVersionAvailable'), [version]);
        Buttons := [mbOK,mbCancel];
      end;

      if MessageDlg(s, mtConfirmation, Buttons, 0) = mrOk then
      begin
        downloadCurrentVersion(Handle, RoomerDataSet);
        result := true;
      end
      else
        with TRoomerRegistryIniFile.Create(GetRoomerIniFilename) do
        try
          WriteInteger('RoomerPMSVersion', version, NumDialogShown);
        finally
          Free;
        end;
    end;

  except

  end;
{$ENDIF}
end;

function findVersionOfRoomerOnServer(xml: IXMLDOMDocument2; RoomerDataSet : TRoomerDataSet) : String;
var node : IXMLDomNode;
    currentVersion : String;
begin
  result := '';
  node := xml.documentElement.firstChild;
  while node <> nil do
  begin
    if RoomerDataSet.GetAttributeValue(node, 'filename', '') = 'Roomer.exe' then
    begin
      result := RoomerDataSet.GetAttributeValue(node, 'version', currentVersion);
      Break;
    end;
    node := node.nextSibling;
  end;
end;

end.
