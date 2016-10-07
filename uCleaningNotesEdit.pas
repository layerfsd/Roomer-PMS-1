unit uCleaningNotesEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDImages, hData, Vcl.StdCtrls, sButton, Vcl.ExtCtrls, sPanel, cxClasses, cxPropertiesStore, sMemo, sEdit, sCheckBox,
  sComboBox, sLabel, uRoomerForm, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinCaramel, dxSkinCoffee, dxSkinDarkSide,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinsdxStatusBarPainter, dxStatusBar;

type
  TfrmCleaningNotesEdit = class(TfrmBaseRoomerForm)
    panBtn: TsPanel;
    btnCancel: TsButton;
    BtnOk: TsButton;
    sLabel1: TsLabel;
    __cbxServiceType: TsComboBox;
    lblOnceType: TsLabel;
    __cbxOnceType: TsComboBox;
    cbxActive: TsCheckBox;
    __lblInterval: TsLabel;
    edtInterval: TsEdit;
    lblMinimumDays: TsLabel;
    edtMinimumDays: TsEdit;
    sLabel5: TsLabel;
    edtMessage: TsMemo;
    cbxOnlyWhenRoomIsDirty: TsCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure __cbxOnceTypeCloseUp(Sender: TObject);
    procedure __cbxServiceTypeCloseUp(Sender: TObject);
  private
    procedure OrganizeInputs;
    procedure PrepareInputs;
    { Private declarations }
  public
    { Public declarations }
    zData : recCleaningNotesHolder;
    zInsert : boolean;

    procedure EditsToRecordHolder;
  end;

var
  frmCleaningNotesEdit: TfrmCleaningNotesEdit;

function openCleaningNotesEdit(var theData : recCleaningNotesHolder; isInsert : boolean) : boolean;

implementation

{$R *.dfm}

uses PrjConst,
     uRoomerLanguage,
     uAppGlobal,
     uUtils
     ;


function openCleaningNotesEdit(var theData : recCleaningNotesHolder; isInsert : boolean) : boolean;
var
  _FrmCleaningNotesEdit: TFrmCleaningNotesEdit;
begin
  result := false;
  _FrmCleaningNotesEdit := TFrmCleaningNotesEdit.Create(nil);
  try
    _FrmCleaningNotesEdit.zData := theData;
    _FrmCleaningNotesEdit.zInsert := isInsert;
    _FrmCleaningNotesEdit.ShowModal;
    if _FrmCleaningNotesEdit.modalresult = mrOk then
    begin
      _FrmCleaningNotesEdit.EditsToRecordHolder;
      theData := _FrmCleaningNotesEdit.zData;
      result := true;
    end
  finally
    freeandnil(_FrmCleaningNotesEdit);
  end;
end;

procedure TFrmCleaningNotesEdit.EditsToRecordHolder;
begin
  zData.active := cbxActive.Checked;
  zData.serviceType := __cbxServiceType.Text;
  zData.onlyWhenRoomIsDirty := cbxOnlyWhenRoomIsDirty.Checked;
  zData.onceType := __cbxOnceType.Text;
  zData.interval := StrToIntDef(edtInterval.Text, 3);
  zData.minimumDays := StrToIntDef(edtMinimumDays.Text, 1);
  zData.smessage := edtMessage.Text;
end;

procedure TfrmCleaningNotesEdit.FormCreate(Sender: TObject);
begin
//  RoomerLanguage.TranslateThisForm(self);
//  glb.PerformAuthenticationAssertion(self);
//  PlaceFormOnVisibleMonitor(self);
end;

procedure TfrmCleaningNotesEdit.FormShow(Sender: TObject);
begin
  PrepareInputs;
end;

procedure TFrmCleaningNotesEdit.PrepareInputs;
begin
  if NOT zInsert then
  begin
    cbxActive.Checked := zData.active;
    __cbxServiceType.ItemIndex := __cbxServiceType.Items.IndexOf(zData.serviceType);
    __cbxOnceType.ItemIndex := __cbxOnceType.Items.IndexOf(zData.onceType);
    edtInterval.Text := InttoStr(zData.interval);
    edtMinimumDays.Text := InttoStr(zData.minimumDays);
    cbxOnlyWhenRoomIsDirty.Checked := zData.onlyWhenRoomIsDirty;
    edtMessage.Text := zData.smessage;
  end;

  OrganizeInputs;
end;

procedure TfrmCleaningNotesEdit.__cbxOnceTypeCloseUp(Sender: TObject);
begin
  OrganizeInputs;
end;

procedure TfrmCleaningNotesEdit.__cbxServiceTypeCloseUp(Sender: TObject);
begin
  OrganizeInputs;
end;

procedure TFrmCleaningNotesEdit.OrganizeInputs;
begin
  __cbxOnceType.Visible := __cbxServiceType.ItemIndex > 0;
  if __cbxServiceType.ItemIndex = 0 then
  begin
    __lblInterval.Caption := GetTranslatedText('shCleaningNotesIntervalLabel');
  end else
  begin
    __lblInterval.Caption := GetTranslatedText('shCleaningNotesOnceLabel');
  end;
  lblOnceType.Visible := __cbxOnceType.Visible;

  __lblInterval.Visible := (NOT __cbxOnceType.Visible) OR (__cbxOnceType.ItemIndex IN [3,4]);
  edtInterval.Visible := __lblInterval.Visible;
end;

end.
