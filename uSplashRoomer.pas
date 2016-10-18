unit uSplashRoomer;

interface

uses
  Vcl.StdCtrls, System.Classes, Vcl.Controls, Vcl.ExtCtrls,
  Vcl.Forms,
  dxGDIPlusClasses, AdvSmoothProgressBar
  ;

type
  TfrmRoomerSplash = class(TForm)
    Image1: TImage;
    LMDSimpleLabel1: TLabel;
    lblMessage: TLabel;
    AdvSmoothProgressBar1: TAdvSmoothProgressBar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    procedure DownloadProgress(Sender: TObject; Read, Total: Integer);
    { Private declarations }
  public
    { Public declarations }
    procedure PrepareBusyNotificator;
    procedure NilInternetEvents;
  end;


  /// <summary>
  ///   SplashForm manager and implicit factory
  /// </summary>
  TSplashFormManager = class(TObject)
  private
    class var frmInstance: TfrmRoomerSplash;
    class function frmSplash: TfrmRoomerSplash;
    class procedure ShowSplashForm; static;
  public
    class procedure Show;
    class procedure Close;
    /// <summary>
    ///   If the form is created then hide it. Result is true is form was created and visible
    /// </summary>
    class function TryHideForm: boolean;
    class procedure UpdateProgress(const aMsg:string=''; aIncProgress: integer = 1);
  end;

implementation

{$R *.dfm}

uses
  uAboutRoomer,
  ud,
  uUtils,
  uFileSystemUtils,
  PrjConst, uRoomerVersionInfo;

procedure TfrmRoomerSplash.NilInternetEvents;
begin
//  if Assigned(d.roomerMainDataSet.roomerClient) then
//  begin
//    d.roomerMainDataSet.roomerClient.OnDownloadProgress := nil;
//    d.roomerMainDataSet.roomerClient.OnUploadProgress := nil;
//  end;
end;

procedure TfrmRoomerSplash.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmRoomerSplash.FormCreate(Sender: TObject);
begin
  LMDSimpleLabel1.Caption := TRoomerVersionInfo.LongVersionString;
end;

procedure TfrmRoomerSplash.FormHide(Sender: TObject);
begin
  //
  NilInternetEvents;
end;

procedure TfrmRoomerSplash.PrepareBusyNotificator;
begin
//  d.roomerMainDataSet.roomerClient.OnUploadProgress := DownloadProgress;
//  d.roomerMainDataSet.roomerClient.OnDownloadProgress := DownloadProgress;
end;


procedure TfrmRoomerSplash.DownloadProgress(Sender: TObject; Read, Total: Integer);
begin
//  Update;
end;


class procedure TSplashFormManager.Close;
begin
  if assigned(frmInstance) then
  begin
    frmInstance.Close;
    frmInstance := nil;
  end;
end;

class function TSplashFormManager.frmSplash: TfrmRoomerSplash;
begin
  if not assigned(frmInstance) then
    frmInstance := TfrmRoomerSplash.Create(Application);

  result := frmInstance;
end;

class procedure TSplashFormManager.Show;
begin
  frmSplash.Show;
end;

class procedure TSplashFormManager.ShowSplashForm;
begin
  if not assigned(frmInstance) then
    frmInstance := TfrmRoomerSplash.Create(Application);

  frmInstance.Show;
end;

class function TSplashFormManager.TryHideForm: boolean;
begin
  Result := assigned(frmInstance) and frmInstance.Visible;
  if assigned(frmInstance) then
  begin
    frmInstance.Hide;
    frmInstance.Close;
    frmInstance := nil;
  end;
end;


class procedure TSplashFormManager.UpdateProgress(const aMsg:string=''; aIncProgress: integer = 1);
begin
  with frmSplash do
  begin
    Visible := true;
    lblMessage.Caption := aMsg;
    AdvSmoothProgressBar1.Next;
    Update;
  end;
end;

end.
