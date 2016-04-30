unit uFrmAlertEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uAlerts, Vcl.StdCtrls, sMemo, sComboBox, sLabel, sButton, Vcl.ExtCtrls, sPanel;

type
  TFrmAlertEdit = class(TForm)
    sLabel1: TsLabel;
    __cbxAlertOn: TsComboBox;
    mmoText: TsMemo;
    sLabel2: TsLabel;
    sPanel1: TsPanel;
    BtnOk: TsButton;
    btnCancel: TsButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Alert : TAlert;

    procedure prepareEdit;
    procedure ReadBack;
  end;

var
  FrmAlertEdit: TFrmAlertEdit;

function AddAlert(_Alert : TAlert) : Boolean;
function EditAlert(_Alert : TAlert) : Boolean;

implementation

{$R *.dfm}

uses uRoomerLanguage, uAppGlobal, uUtils;

function AddAlert(_Alert : TAlert) : Boolean;
var _FrmAlertEdit: TFrmAlertEdit;
begin
  _FrmAlertEdit := TFrmAlertEdit.Create(nil);
  Try
    _FrmAlertEdit.Alert := _Alert;
    result := _FrmAlertEdit.ShowModal = mrOk;
    if result then
      _FrmAlertEdit.ReadBack;
  Finally
    FreeAndNil(_FrmAlertEdit);
  End;
end;

function EditAlert(_Alert : TAlert) : Boolean;
var _FrmAlertEdit: TFrmAlertEdit;
begin
  _FrmAlertEdit := TFrmAlertEdit.Create(nil);
  Try
    _FrmAlertEdit.Alert := _Alert;
    _FrmAlertEdit.prepareEdit;
    result := _FrmAlertEdit.ShowModal = mrOk;
    if result then
      _FrmAlertEdit.ReadBack;
  Finally
    FreeAndNil(_FrmAlertEdit);
  End;
end;


procedure TFrmAlertEdit.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  __cbxAlertOn.ItemIndex := 0;
  mmoText.Lines.Clear;
end;

procedure TFrmAlertEdit.prepareEdit;
begin
  __cbxAlertOn.ItemIndex := ORD(Alert.AlertMomentType) - 1;
  mmoText.Lines.Text := Alert.AlertText;
end;

procedure TFrmAlertEdit.ReadBack;
begin
  Alert.AlertMomentType := TAlertType(__cbxAlertOn.ItemIndex + 1);
  Alert.AlertText := mmoText.Lines.Text;
end;

end.
