unit uSplashRoomer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, acPNG, sSkinManager, sSkinProvider, W7Classes, W7ProgressBars, Vcl.ComCtrls, AdvProgr,
  UbuntuProgress, IdComponent, IdBaseComponent, IdThreadComponent, dxGDIPlusClasses, IdTCPConnection, IdTCPClient, IdHTTP;

type
  TfrmRoomerSplash = class(TForm)
    Image1: TImage;
    LMDSimpleLabel1: TLabel;
    UbuntuProgress1: TUbuntuProgress;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure IdHTTP1Redirect(Sender: TObject; var dest: string; var NumRedirect: Integer; var Handled: Boolean; var VMethod: string);
  private
    procedure DownloadProgress(sender: TObject; Read, Total: Integer);
    procedure RedirectEvent(sender: Tobject; const NewURL: AnsiString);
    { Private declarations }
  public
    { Public declarations }
    procedure PrepareBusyNotificator;
    procedure UpdateBusySignal;
    procedure NilInternetEvents;
  end;

var
  frmRoomerSplash: TfrmRoomerSplash;

procedure HideRoomerSplash;
procedure ShowRoomerSplash;

implementation

{$R *.dfm}

uses uAboutRoomer, ud, uUtils;

procedure HideRoomerSplash;
begin
  if Assigned(frmRoomerSplash) then
  begin
     frmRoomerSplash.Hide;
     frmRoomerSplash.close;
  end;
  frmRoomerSplash := nil;
end;

procedure ShowRoomerSplash;
begin
  frmRoomerSplash := TfrmRoomerSplash.Create(Application);
//  frmRoomerSplash.progressBar.State := pbsNormal;
  frmRoomerSplash.Show;
  frmRoomerSplash.Update;
//  frmRoomerSplash.LMDSimpleLabel1.Caption := d.fvFileVersion.FileVersion;
  Application.processmessages;
end;

procedure TfrmRoomerSplash.NilInternetEvents;
begin
{$IFDEF USE_INDY}
     d.roomerMainDataSet.roomerClient.OnWork := nil;
     d.roomerMainDataSet.roomerClient.OnRedirect := nil;
{$ELSE}
     d.roomerMainDataSet.roomerClient.OnDownloadProgress := nil;
     d.roomerMainDataSet.roomerClient.OnUploadProgress := nil;
     d.roomerMainDataSet.roomerClient.OnRedirect := nil;
{$ENDIF}
end;

procedure TfrmRoomerSplash.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmRoomerSplash.FormCreate(Sender: TObject);
begin
  LMDSimpleLabel1.Caption := 'Version ' + getVersion(Application.ExeName);
end;

procedure TfrmRoomerSplash.FormHide(Sender: TObject);
begin
  //
  NilInternetEvents;
end;

procedure TfrmRoomerSplash.FormShow(Sender: TObject);
begin
  //
end;

procedure TfrmRoomerSplash.IdHTTP1Redirect(Sender: TObject; var dest: string; var NumRedirect: Integer; var Handled: Boolean; var VMethod: string);
begin
  RedirectEvent(sender, dest);
end;

procedure TfrmRoomerSplash.IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  DownloadProgress(ASender, AWorkCount, AWorkCount);
end;

procedure TfrmRoomerSplash.PrepareBusyNotificator;
begin
  //
{$IFDEF USE_INDY}
   d.roomerMainDataSet.roomerClient.OnWork := IdHTTP1Work;
   d.roomerMainDataSet.roomerClient.OnRedirect := IdHTTP1Redirect;
{$ELSE}
   d.roomerMainDataSet.roomerClient.OnUploadProgress := DownloadProgress;
   d.roomerMainDataSet.roomerClient.OnDownloadProgress := DownloadProgress;
   d.roomerMainDataSet.roomerClient.OnRedirect := RedirectEvent;
{$ENDIF}
end;

//  TALHTTPClientUploadProgressEvent   = procedure(sender: Tobject; Sent: Integer; Total: Integer) of object;
//  TAlHTTPClientRedirectEvent         = procedure(sender: Tobject; const NewURL: AnsiString) of object;
procedure TfrmRoomerSplash.RedirectEvent(sender: Tobject; const NewURL: AnsiString);
begin
  UpdateBusySignal;
end;

procedure TfrmRoomerSplash.UpdateBusySignal;
begin
  try DownloadProgress(nil, 0, 0); except end;
end;

procedure TfrmRoomerSplash.DownloadProgress(sender: TObject; Read, Total: Integer);
begin
  Update;
  UbuntuProgress1.Update;
  UbuntuProgress1.Invalidate;
end;

end.
