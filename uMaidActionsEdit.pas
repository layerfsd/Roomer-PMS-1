unit uMaidActionsEdit;

interface

uses
    Windows
  , Messages
  , SysUtils
  , Variants
  , Classes
  , Graphics
  , Controls
  , Forms
  , Dialogs
  , StdCtrls
  , Buttons
  , ExtCtrls

  , ug
  , DB
  , Mask
  , DBTables
  , DBCtrls, sButton, sLabel, sPanel, sMemo, sEdit
  , hData
  ;

type
  TfrmMaidActionsEdit = class(TForm)
    PanBtn: TsPanel;
    panTop: TsPanel;
    cbActive: TDBCheckBox;
    BtnOk: TsButton;
    btnCancel: TsButton;
    edDescription: TsEdit;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    edAction: TsEdit;
    sLabel3: TsLabel;
    edRule: TsMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }

    CloseOK : boolean;
    procedure UpdateControls;

  public
    { Public declarations }
    zData: recMaidActionHolder;
    zInsert: boolean;

    procedure EditsToRecordHolder;
  end;

function openMaidActionEdit(var theData : recMaidActionHolder; isInsert : boolean) : boolean;

implementation

uses uD
  , uAppGlobal
  , PrjConst
  , uUtils
  ;

{$R *.dfm}

function openMaidActionEdit(var theData : recMaidActionHolder; isInsert : boolean): boolean;
var
  frm: TfrmMaidActionsEdit;
begin
  result := false;
  frm := TfrmMaidActionsEdit.Create(nil);
  try
    frm.zData := theData;
    frm.zInsert := isInsert;
    frm.ShowModal;
    if frm.modalresult = mrOk then
    begin
      frm.EditsToRecordHolder;
      theData := frm.zData;
      result := true;
    end
  finally
    freeandnil(frm);
  end;
end;

procedure TfrmMaidActionsEdit.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  //**
  closeOK := false;
end;

procedure TfrmMaidActionsEdit.FormShow(Sender: TObject);
begin
  //**
  if zInsert then
  begin
    activecontrol := edAction;
  end else
  begin
    edAction.Enabled := false;
    activecontrol := edDescription;
  end;

  UpdateControls;
end;

procedure TfrmMaidActionsEdit.UpdateControls;
begin
  cbActive.Checked := zData.active;
  edAction.Text := zData.action;
  edDescription.Text := zData.Description;
  edRule.Text := zData.Rule;
end;

procedure TfrmMaidActionsEdit.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMaidActionsEdit.btnOkClick(Sender: TObject);
begin
  if trim(edAction.text) = '' then
  begin
	  showmessage(GetTranslatedText('shTx_MaidActionsEdit_CodeMaidAction'));
    closeOk := false;
    edAction.SetFocus;
    exit;
  end;

  if zInsert then
    if d.MaidActionExist(edAction.Text) then
    begin
      showmessage(GetTranslatedText('shTx_MainActionsEdit_MaidActionAvailable'));
      closeOk := false;
      edAction.SetFocus;
      exit;
    end;

  if trim(edDescription.text) = '' then
  begin
	  showmessage(GetTranslatedText('shTx_MainActionsEdit_NameMaid'));
    closeOk := false;
    edDescription.SetFocus;
    exit;
  end;

  if CloseOK then
    Close;
end;

procedure TfrmMaidActionsEdit.EditsToRecordHolder;
begin
  zData.active := cbActive.Checked;
  zData.action := edAction.Text;
  zdata.Description := edDescription.Text;
  zData.Rule := edRule.Text;
end;

end.
