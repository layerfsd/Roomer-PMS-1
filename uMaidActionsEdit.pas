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
  , DBCtrls, sButton, sLabel, sPanel

  //FIX  wwdbedit
  //FIX  wwcheckbox

  ;

type
  TfrmMaidActionsEdit = class(TForm)
    PanBtn: TsPanel;
    panTop: TsPanel;
    LMDSimpleLabel2: TsLabel;
    BDECountry: TDBEdit;
    DBECountryName: TDBEdit;
    DBMemo1: TDBMemo;
    wwCheckBox1: TDBCheckBox;
    BtnOk: TsButton;
    btnCancel: TsButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure PanBtnResize(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }

    CloseOK : boolean;
    procedure SetBtnPos;

  public
    { Public declarations }
    zAct   : TActTableAction;
    zCode  : string;
  end;

var
  frmMaidActionsEdit: TfrmMaidActionsEdit;

implementation

uses uD
  , uAppGlobal
  , PrjConst
  , uUtils
  ;

{$R *.dfm}

procedure TfrmMaidActionsEdit.SetBtnPos;
begin
  btnCancel.Left := PanBtn.Width-btnCancel.width-5;
  btnOK.Left := btnCancel.Left-BtnOk.Width-5;
end;


procedure TfrmMaidActionsEdit.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  //**
  zAct  := ActNone;
  zCode := '';
  SetBtnPos;
  closeOK := false;
end;

procedure TfrmMaidActionsEdit.FormShow(Sender: TObject);
begin
  //**
  if zAct = actInsert then
  begin
    activecontrol := BDECountry;
    d.maidActions_.Insert;
  end else
  if zAct = actEdit then
  begin
    BDECountry.Enabled := false;
    activecontrol := DBECountryName;
    d.maidActions_.Edit;
  end;
end;

procedure TfrmMaidActionsEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //**
end;

procedure TfrmMaidActionsEdit.FormDestroy(Sender: TObject);
begin
  //**
end;

procedure TfrmMaidActionsEdit.btnOkClick(Sender: TObject);
begin
  if trim(BDECountry.text) = '' then
  begin
	  showmessage(GetTranslatedText('shTx_MaidActionsEdit_CodeMaidAction'));
    closeOk := false;
    BDECountry.SetFocus;
    exit;
  end;

  //**TESTED// lev3 ok
  if zAct = actInsert then
  if d.MaidActionExist(BDECountry.text) then
  begin
	  showmessage(GetTranslatedText('shTx_MainActionsEdit_MaidActionAvailable'));
    closeOk := false;
    BDECountry.SetFocus;
    exit;
  end;

  if trim(DBECountryName.text) = '' then
  begin
	  showmessage(GetTranslatedText('shTx_MainActionsEdit_NameMaid'));
    closeOk := false;
    DBECountryName.SetFocus;
    exit;
  end;

  if (d.MaidActionsDS.State = dsEdit) or (d.MaidActionsDS.State = dsInsert) then
  begin
    d.maidActions_.post;
    zCode := d.maidActions_.fieldbyName('maAction').asString;
  end;
  closeok := true;
end;

procedure TfrmMaidActionsEdit.btnCancelClick(Sender: TObject);
begin
  //**
  if (d.MaidActionsDS.State = dsEdit) or (d.MaidActionsDS.State = dsInsert) then
  begin
    d.maidActions_.Cancel;
  end;
  zCode := d.maidActions_.fieldbyName('maAction').asString;
end;

procedure TfrmMaidActionsEdit.PanBtnResize(Sender: TObject);
begin
  SetBtnPos;
end;

procedure TfrmMaidActionsEdit.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := CloseOk;
  CloseOk  := true;
end;

end.
