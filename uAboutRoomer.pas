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
  public
  end;

var
  frmAboutRoomer: TfrmAboutRoomer;

procedure ShowRoomerAboutBox;
procedure downloadCurrentVersion(Handle : THandle; RoomerDataSet : TRoomerDataSet);
function checkNewVersion(Handle : THandle; RoomerDataSet : TRoomerDataSet) : boolean;
procedure StartRemoteSupport(Handle : THandle; RoomerDataSet : TRoomerDataSet);
procedure ShowDashboard(Handle : THandle; RoomerDataSet : TRoomerDataSet);
procedure SetIgnoresToZero(RoomerDataSet : TRoomerDataSet);

implementation

{$R *.dfm}

uses uMain
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
     , Math
     , uRoomerVersionInfo;

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


procedure TfrmAboutRoomer.FormShow(Sender: TObject);
begin
  lblEndpoint.Caption := d.roomerMainDataSet.RoomerUri;
  LabDBVerName.Caption := TRoomerVersionInfo.FileVersion;
  if TRoomerVersionInfo.IsPreRelease then
    LabDBVerName.Caption := LabDBVerName.Caption + ' (Pre-Release)';
  labExtraBuild.Caption := TRoomerVersionInfo.ExtraBuild;
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
var
  version : String;
begin
  version := TRoomerVersionInfo.FileVersionOnServer;
  if version <> TRoomerVersionInfo.FileVersion then
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
end;


function checkNewVersion(Handle : THandle; RoomerDataSet : TRoomerDataSet) : boolean;
var
  version : String;
  FileInfo : TFileEntity;
  sPath,
  UpgradeManagerPath : String;
  NumDialogShown : Integer;
  s : String;
  Buttons: TMsgDlgButtons;
  lButton: TButton;
  lMSgResult: integer;
begin

  version := TRoomerVersionInfo.FileVersionOnServer;
  if not (TRoomerVersionInfo.IsPreRelease or TRoomerVersionInfo.IsDebug) and (version <> TROomerVersionInfo.FileVersion) then
  begin
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

    lMsgResult := mrCancel;
    with CreateMessageDialog(s, mtConfirmation, Buttons) do
    try
      lButton := TButton(FindComponent('OK'));
      if lButton <> nil then
        lButton.Caption := GetTranslatedText('shTx_AboutRoomer_NewVersionAvailableUpdateNow');

      lButton := TButton(FindComponent('Cancel'));
      if lButton <> nil then
        lButton.Caption := GetTranslatedText('shTx_AboutRoomer_NewVersionAvailableUpdateLater');
      Position := poScreenCenter;
      lMsgResult := ShowModal;
    finally
      Free;
    end;

    if lMsgResult = mrOk then
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
end;

end.
