unit uMaidActions;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Menus,
  ImgList,
  StdCtrls,
  Mask,
  ExtCtrls,
  Grids,
  Buttons,
  shellapi,
  ADODB,
  db,
  DBTables,
  DBCtrls,
  ComCtrls,

  _glob,
  ug, DBGrids, cxPropertiesStore, cxClasses, sButton, sPanel

  ;

type
  TfrmMaidActions = class(TForm)
    wwDBGrid1: TDBGrid;
    LMDStatusBar1: TStatusBar;
    PanTop: TsPanel;
    panBtn: TsPanel;
    BtnOk: TsButton;
    btnCancel: TsButton;
    FormStore: TcxPropertiesStore;
    btnInsert: TsButton;
    btnEdit: TsButton;
    btnDelete: TsButton;
    btnClose: TsButton;
    procedure FormCreate(Sender : TObject);
    procedure FormShow(Sender : TObject);
    procedure btnCancelClick(Sender : TObject);
    procedure btnInsertClick(Sender : TObject);
    procedure btnEditClick(Sender : TObject);
    procedure btnDeleteClick(Sender : TObject);
    procedure panBtnResize(Sender : TObject);
    procedure FormKeyPress(Sender : TObject; var Key : Char);
    procedure BtnOkClick(Sender : TObject);
    procedure wwDBGrid1DblClick(Sender : TObject);
    procedure btnCloseClick(Sender : TObject);

  private
    { Private declarations }
    aHeader : string;
    isFirstTime : boolean;
    procedure SetBtnPos;
  public
    { Public declarations }
    zCode : string;
    zDescription : string;
    zAct : TActTableAction;

  end;

var
  frmMaidActions : TfrmMaidActions;


function OpenMaidActionsEdit(act : TActTableAction; var code : string) : boolean;

implementation

uses
  uD
  , uAppGlobal
  , PrjConst
  , uUtils
  , uDImages
  , UITypes
  , uMaidActionsEdit;
{$R *.dfm}



function OpenMaidActionsEdit(act : TActTableAction; var code : string) : boolean;
var
  frmMaidActionsEdit: TfrmMaidActionsEdit;
begin
  result := false;
  frmMaidActionsEdit := TfrmMaidActionsEdit.Create(frmMaidActionsEdit);
  try
    frmMaidActionsEdit.zAct := act;
    frmMaidActionsEdit.ShowModal;
    if frmMaidActionsEdit.modalresult = mrOk then
    begin
      code := frmMaidActionsEdit.zCode;
      result := true;
    end
    else
    begin
      code := frmMaidActionsEdit.zCode;
    end;
  finally
    frmMaidActionsEdit.free;
    frmMaidActionsEdit := nil;
  end;
end;


procedure changeSortDir(var sCurrent : string);
begin
  sCurrent := trim(Uppercase(sCurrent));
  if (sCurrent = '') or (sCurrent = 'ASC') then
  begin
    sCurrent := ' DESC';
  end
  else
  begin
    sCurrent := ' ';
  end;
end;

procedure TfrmMaidActions.SetBtnPos;
begin
  btnCancel.Left := panBtn.Width - btnCancel.Width - 5;
  BtnOk.Left := btnCancel.Left - BtnOk.Width - 5;
end;

procedure TfrmMaidActions.FormCreate(Sender : TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  isFirstTime := true;
  zCode := '';
  zAct := actNone;
  zDescription := '';
  SetBtnPos;
  aHeader := 'L�nd';
end;

procedure TfrmMaidActions.FormShow(Sender : TObject);
begin
  // **
  panBtn.Visible := false;
  LMDStatusBar1.Visible := false;
  btnClose.Visible := false;

  if zAct = actLookup then
  begin
    if zCode <> '' then
    begin
      if d.MaidActions_.Locate('maAction', zCode, []) then
      begin
      end
      else
      begin
      end;
    end;
    panBtn.Visible := true;
  end
  else
  begin
    btnClose.Visible := true;
    LMDStatusBar1.Visible := true;
  end;

  isFirstTime := false;
end;

procedure TfrmMaidActions.btnCancelClick(Sender : TObject);
begin
  // **
  zCode := '';
  zDescription := '';
end;


// ***********************************************
// Table Actons
// ***********************************************

procedure TfrmMaidActions.btnInsertClick(Sender : TObject);
var
  Code : string;
begin


  // **
  Code := '';
  if OpenMaidActionsEdit(actInsert, Code) then
  begin
    d.OpenMaidActionsQuery(d.zMaidActionsSortField, d.zMaidActionsSortDir);
    if d.MaidActions_.Locate('maAction', Code, []) then
    begin
    end
    else
    begin
  	  Showmessage(GetTranslatedText('shTx_MainActions_RegisterNotFound'));
    end
  end
  else
  begin

  end;
end;



procedure TfrmMaidActions.btnEditClick(Sender : TObject);
var
  Code : string;
begin
  Code := '';
  OpenMaidActionsEdit(actEdit, Code);
end;

procedure TfrmMaidActions.btnDeleteClick(Sender : TObject);
var
  cNumber : string;
  cDescription : string;
  s : string;
  sTmp : string;
  sTmp2 : string;

begin

  cNumber := d.MaidActions_.fieldbyname('maAction').asstring;
  cDescription := d.MaidActions_.fieldbyname('maDescription').asstring;

 //s := s + 'Ey�a �ernua�ger� ' + cNumber + ' ' + cDescription + chr(10);
 //s := s + 'ertu viss ??';
  s := format(GetTranslatedText('shTx_MaidActions_DeleteMaidAction'), [cNumber, cDescription]);

  if MessageDlg(s, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    screen.Cursor := crHourGlass;
    try
      sTmp2 := d.MaidActions_.fieldbyname('maAction').asstring;
      if not d.MaidActions_.BOF then
      begin
        d.MaidActions_.Prior;
        sTmp := d.MaidActions_.fieldbyname('maAction').asstring;
      end;

      if d.Del_MaidActionByMaidAction(cNumber) then
      begin
        try
          if d.zMaidActionsFilter <> '' then
          begin
          end
          else
          begin
            d.OpenMaidActionsQuery(d.zMaidActionsSortField, d.zMaidActionsSortDir);
          end;
          d.MaidActions_.Locate('maAction', sTmp, []);
        except
        end;
      end
      else
      begin
        d.MaidActions_.Locate('maAction', sTmp2, []);
      end;

    finally
      screen.Cursor := crDefault;
    end;
  end;
end;

procedure TfrmMaidActions.wwDBGrid1DblClick(Sender : TObject);
begin
  // **
  if zAct = actLookup then
  begin
    BtnOk.click;
  end
  else
  begin
    btnEdit.click;
  end;
end;

// **********************************************************


procedure TfrmMaidActions.panBtnResize(Sender : TObject);
begin
  SetBtnPos;
end;

procedure TfrmMaidActions.FormKeyPress(Sender : TObject; var Key : Char);
begin
  if Key = chr(13) then
  begin
    modalresult := mrOk;
  end;

  if Key = chr(27) then
  begin
    modalresult := mrCancel;
  end;
end;

procedure TfrmMaidActions.BtnOkClick(Sender : TObject);
begin
  zCode := d.MaidActions_.fieldbyname('maAction').asstring;
  zDescription := d.MaidActions_.fieldbyname('maDescription').asstring;
end;

procedure TfrmMaidActions.btnCloseClick(Sender : TObject);
begin
  Close;
end;

end.
