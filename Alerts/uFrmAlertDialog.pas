unit uFrmAlertDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sButton, sMemo, acPNG, Vcl.ExtCtrls, acImage,
  uAlerts;

type
  TFrmAlertDialog = class(TForm)
    mmoText: TsMemo;
    sButton1: TsButton;
    imgTime: TsImage;
    imgCheckIn: TsImage;
    imgCheckOut: TsImage;
    imgOpenReservation: TsImage;
    procedure FormCreate(Sender: TObject);
  private
    FAlert: TAlert;
    procedure SetAlert(const Value: TAlert);
    { Private declarations }
  public
    { Public declarations }
    property Alert : TAlert read FAlert write SetAlert;
  end;

var
  FrmAlertDialog: TFrmAlertDialog;

procedure ShowAlert(Alert : TAlert);

implementation

{$R *.dfm}

uses uRoomerLanguage, uAppGlobal, uUtils;

procedure ShowAlert(Alert : TAlert);
var _FrmAlertDialog: TFrmAlertDialog;
begin
  _FrmAlertDialog := TFrmAlertDialog.Create(nil);
  try
    _FrmAlertDialog.Alert := Alert;
    _FrmAlertDialog.ShowModal;
  finally
    FreeAndNil(_FrmAlertDialog);
  end;
end;

procedure TFrmAlertDialog.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
end;

procedure TFrmAlertDialog.SetAlert(const Value: TAlert);
var img : TsImage;
begin
  FAlert := Value;

  mmoText.Lines.Text := FAlert.AlertText;

  case FAlert.AlertMomentType of
    atUNKNOWN: img := nil;
    atCHECK_IN: img := imgCheckIn;
    atCHECK_OUT: img := imgCheckOut;
    atOPEN_RESERVATION: img := imgOpenReservation;
    atTIME: img := imgTime;
  else
    Exit;
  end;

  with img do
  begin
    Left := 24;
    Top := 24;
    Visible := True;
  end;

end;

end.
