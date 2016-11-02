unit uUpgraderMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, IOUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, acPNG, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB, Data.Win.ADODB, cmpRoomerDataSet, ALHttpClient, ALWininetHttpClient,
  sSkinProvider, sSkinManager, Vcl.ComCtrls, acProgressBar, sLabel, dxGDIPlusClasses,
  AlHttpCommon;

type
  TForm1 = class(TForm)
    Image2: TImage;
    Label1: TsLabel;
    Label2: TsLabel;
    Label3: TsLabel;
    RoomerDataSet: TRoomerDataSet;
    tmStart: TTimer;
    httpClient: TALWinInetHTTPClient;
    sProgressBar1: TsProgressBar;
    lblDownloaded: TsLabel;
    lblExename: TsLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmStartTimer(Sender: TObject);
    procedure DownloadProgress(sender: TObject; Read, Total: Integer);
  private
    procedure StartLabel(Label_: TsLabel);
    procedure EndLabel(Label_: TsLabel);
    procedure PerformUpdate;
    function DownloadFile(roomerClient: TALWininetHttpClient; Url, filename: String): Boolean;
    procedure RemoveLanguagesFiles;
    procedure RemoveAllRoomerCaches;
    function TryCopyFile(localFilename, exeName: PWideChar): Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Types, ShellAPI, uStringUtils, uFileSystemUtils;

const

  ROOMER_EXE_URI = 'http://roomerstore.com/Roomer.exe';

{$IFDEF LOCALRESOURCE}
  RoomerBase : String = 'http://localhost';
  RoomerStoreBase : String = 'http://localhost';
  RoomerBasePort : String = '8080';
  RoomerStoreBasePort : String = '8080';
{$ELSE}
  {$IFDEF ROOMERSSL}
    RoomerBase : String = 'https://secure.roomercloud.net';
    RoomerBasePort : String = '8443';
  {$ELSE}
    RoomerBase : String = 'http://secure.roomercloud.net';
    RoomerBasePort : String = '8080';
  {$ENDIF}
  const RoomerStoreBase : String = 'http://store.roomercloud.net';
  const RoomerStoreBasePort : String = '8080';
{$ENDIF}

  _K  = 1024; //byte
  _B  = 1; //byte
  _KB = _K * _B; //kilobyte
  _MB = _K * _KB; //megabyte
  _GB = _K * _MB; //gigabyte

var
  select_x : string;
  RoomerStoreUri : String;
  RoomerApiUri : String;
  RoomerApiEntitiesUri : String;
  RoomerApiDatasetsUri : String;

function FormatByteSize(const bytes: Longword): string;
begin

  if bytes > _GB then
    result := FormatFloat('#.## GB', bytes / _GB)
  else
    if bytes > _MB then
      result := FormatFloat('#.## MB', bytes / _MB)
    else
      if bytes > _KB then
        result := FormatFloat('#.## KB', bytes / _KB)
      else
        result := FormatFloat('#.## Bytes', bytes) ;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  RoomerStoreUri := RoomerStoreBase + ':' + RoomerStoreBasePort + '/services/';
  RoomerApiUri := RoomerBase + ':' + RoomerBasePort + '/services/';
  RoomerApiEntitiesUri := RoomerBase + ':' + RoomerBasePort + '/services/entities/';
  RoomerApiDatasetsUri := RoomerBase + ':' + RoomerBasePort + '/services/datasets/';
  RoomerDataSet.RoomerStoreUri := RoomerStoreUri;
  RoomerDataSet.RoomerUri := RoomerApiUri;
  RoomerDataSet.RoomerEntitiesUri := RoomerApiEntitiesUri;
  RoomerDataSet.RoomerDatasetsUri := RoomerApiDatasetsUri;
  RoomerDataSet.roomerClient.OnDownloadProgress := DownloadProgress;

  httpClient.OnDownloadProgress := DownloadProgress;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  tmStart.Enabled := true;
end;

procedure TForm1.StartLabel(Label_: TsLabel);
begin
  Label_.Font.Color := clWhite;
  Label_.Font.Style := [fsBold];
  Label_.Update;
end;

procedure TForm1.tmStartTimer(Sender: TObject);
begin
  tmStart.Enabled := false;
  PerformUpdate;
end;

procedure TForm1.DownloadProgress(sender: TObject; Read, Total: Integer);
var value : Extended;
begin
//  lblDownloaded.Caption := FormatFloat('0',Read) + ' bytes';
  if Total < 1 then
    Total := 57*_MB;
  if sProgressBar1.Max <> Total then
  begin
    sProgressBar1.Max := Total;
    sProgressBar1.Tag := 0;
  end;
  sProgressBar1.Position := Read;
  value := 100 * (Read / Total);
  if value > 100 then
     value := 100;
  lblDownloaded.Caption := FormatFloat('0.00',value) + '% of ~' + FormatByteSize(Total);
  lblDownloaded.Update;
  sProgressBar1.Update;
  sProgressBar1.Tag := sProgressBar1.Tag + 1;
  if sProgressBar1.Tag >= 20 then
  begin
    Application.ProcessMessages;
    sProgressBar1.Tag := 0;
  end;
end;

procedure TForm1.EndLabel(Label_: TsLabel);
begin
  Label_.Font.Color := clGray;
  Label_.Font.Style := [fsStrikeOut];
  Label_.Update;
end;

function TForm1.DownloadFile(
    roomerClient: {$IFDEF USE_INDY}TIdHTTP{$ELSE}TALWininetHttpClient{$ENDIF}
    ;Url, filename : String) : Boolean;
var
  stream: TFileStream;
{$IFNDEF USE_INDY}aResponseContentHeader: TALHTTPResponseHeader;{$ENDIF}
begin
{$IFNDEF USE_INDY}aResponseContentHeader := TALHTTPResponseHeader.Create;{$ENDIF}
  stream := TFileStream.Create(filename, fmCreate);
  try
    try
{$IFDEF USE_INDY}
      roomerClient.handleRedirects:=True;                      //Handle redirects
      roomerClient.get(Url,stream);
{$ELSE}
      roomerClient.Get(AnsiString(Url),
                       stream,
                       aResponseContentHeader);
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




procedure TForm1.RemoveAllRoomerCaches;
var
  path: String;
  files : TStringDynArray;
  i: Integer;
begin
  try
    path := TPath.Combine(uFileSystemUtils.LocalAppDataPath, 'Roomer');
    files := TDirectory.GetFiles(Path + '\', '*.src', TSearchOption.soAllDirectories);
    for i := LOW(files) to HIGH(files) do
       DeleteFile(files[i]);
  except
    // Ignore - Not a vital problem
  end;
end;

procedure TForm1.RemoveLanguagesFiles;
var
  path: String;
begin
  try
    path := TPath.Combine(uFileSystemUtils.LocalAppDataPath, 'Roomer');
    path := TPath.Combine(path, 'Languages');
    forceDirectories(path);
    DeleteAllFiles(TPath.Combine(path, 'RoomerLanguage*.src'));
  except
    // Ignore - Not a vital problem
  end;
end;

function TForm1.TryCopyFile(localFilename, exeName : PWideChar) : Boolean;
begin
  result := False;
  while true do
  begin
    if CopyFile(localFilename, exeName, False) then
    begin
      result := True;
      Break;
    end;
    if MessageDlg('Unable to upgrade Roomer!' + #13#13 +
                  '[Retry] = Try to automatically close Roomer and retry the upgrade.' + #13 +
                  '[Cancel] = Cancel the upgrade for now.', mtConfirmation, [mbRetry, mbCancel], 0) = mrCancel then
    begin
      result := False;
      Break;
    end;
    KillTask(ExtractFilename(exeName));
    sleep(2000);
  end;
end;

procedure TForm1.PerformUpdate;
var exeName : String;
    localFilename : PWideChar;
    tempFile : String;
begin
  exeName := ParamStr(1);
  lblExename.Caption := exeName;
  StartLabel(Label1);
  try
//    if RoomerDataSet.SystemDownloadRoomerFile('Roomer.exe', ExtractFilePath(Application.ExeName) + '\rTemp.exe') then
//    if DownloadFile(httpClient, 'http://roomerstore.com/Roomer.exe', ExtractFilePath(Application.ExeName) + '\rTemp.exe') then
//    ShowMessage(RoomerStoreUri + 'store/roomer/Roomer.exe');
//    if DownloadFile(httpClient, RoomerStoreUri + 'store/roomer/Roomer.exe', ExtractFilePath(Application.ExeName) + '\rTemp.exe') then
    tempFile := ExtractFilePath(Application.ExeName) + '\rTemp.exe';
    deleteFile(tempFile);
    if DownloadFile(httpClient, ROOMER_EXE_URI, tempFile) then
    begin
      RemoveLanguagesFiles;
      RemoveAllRoomerCaches;

      lblDownloaded.Hide;
      lblDownloaded.Update;
//      Application.ProcessMessages;

      EndLabel(Label1);

      StartLabel(Label2);
      sleep(2000);
      DeleteFile(exeName);
      localFilename := PWideChar(tempFile);
      if NOT TryCopyFile(localFilename, PChar(exeName)) then
      begin
        if FileExists(tempFile) then
          deleteFile(tempFile);
        Close;
        exit;
      end;
      DeleteFile(localFilename);
//      MoveFileEx(localFilename, PWideChar(exeName), MOVEFILE_REPLACE_EXISTING);
      EndLabel(Label2);

      StartLabel(Label3);
      ShellExecute(Handle, 'open', PChar(exeName), nil, nil, SW_SHOWNORMAL);
      EndLabel(Label3);
    end;
  except
    On E: Exception do begin
      {$IFDEF DEBUG}
        ShowMessage('Error: ' + e.Message);
      {$ENDIF}
    end;
  end;

  Close;
end;

end.
