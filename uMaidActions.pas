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

  _glob, dxCore,
  ug, DBGrids, cxPropertiesStore, cxClasses, sButton, sPanel, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinCaramel, dxSkinCoffee, dxSkinDarkSide, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDBData, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, dxPSPDFExportCore, dxPSPDFExport, cxDrawTextUtils, dxPSPrVwStd, dxPSPrVwAdv, dxPSPrVwRibbon,
  dxPScxPageControlProducer, dxPScxGridLnk, dxPScxGridLayoutViewLnk, dxPScxEditorProducers, dxPScxExtEditorProducers,
  dxSkinsdxBarPainter, dxSkinsdxRibbonPainter, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, dxmdaset,
  dxPSCore, dxPScxCommon, cxGridLevel, cxGridCustomView, cxGrid, sStatusBar, sEdit, sSpeedButton, sLabel, hData, cxMemo

  ;

type
  TfrmMaidActions = class(TForm)
    sPanel1: TsPanel;
    btnDelete: TsButton;
    btnOther: TsButton;
    mnuOther: TPopupMenu;
    mnuiPrint: TMenuItem;
    mnuiAllowGridEdit: TMenuItem;
    N2: TMenuItem;
    Export1: TMenuItem;
    mnuiGridToExcel: TMenuItem;
    mnuiGridToHtml: TMenuItem;
    mnuiGridToText: TMenuItem;
    mnuiGridToXml: TMenuItem;
    sbMain: TsStatusBar;
    edFilter: TsEdit;
    cLabFilter: TsLabel;
    btnClear: TsSpeedButton;
    panBtn: TsPanel;
    btnCancel: TsButton;
    BtnOk: TsButton;
    DS: TDataSource;
    grPrinter: TdxComponentPrinter;
    prLink_grData: TdxGridReportLink;
    m_: TdxMemData;
    grData: TcxGrid;
    tvData: TcxGridDBTableView;
    lvData: TcxGridLevel;
    tvDataRecId: TcxGridDBColumn;
    btnEdit: TsButton;
    btnInsert: TsButton;
    FormStore: TcxPropertiesStore;
    tvDatamaAction: TcxGridDBColumn;
    tvDatamaDescription: TcxGridDBColumn;
    tvDatamaRule: TcxGridDBColumn;
    tvDatamaUSe: TcxGridDBColumn;
    tvDatamaCross: TcxGridDBColumn;
    tvDatamaActive: TcxGridDBColumn;
    tvDataID: TcxGridDBColumn;
    m_ID: TIntegerField;
    m_maAction: TWideStringField;
    m_maDescription: TWideStringField;
    m_maRule: TWideMemoField;
    m_maUSe: TBooleanField;
    m_maCross: TBooleanField;
    m_maActive: TBooleanField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure m_BeforeDelete(DataSet: TDataSet);
    procedure tvDataDescriptionPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure tvDataDblClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure tvDataFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure tvDataDataControllerFilterChanged(Sender: TObject);
    procedure tvDataDataControllerSortingChanged(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure mnuiPrintClick(Sender: TObject);
    procedure mnuiAllowGridEditClick(Sender: TObject);
    procedure mnuiGridToExcelClick(Sender: TObject);
    procedure mnuiGridToHtmlClick(Sender: TObject);
    procedure mnuiGridToTextClick(Sender: TObject);
    procedure mnuiGridToXmlClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure edFilterChange(Sender: TObject);
    procedure tvDataItemtypePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnInsertClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    zFirstTime       : boolean;
    zAllowGridEdit   : boolean;
    zFilterOn        : boolean;
    zSortStr         : string;
    zIsAddRow        : boolean;

    Procedure fillGridFromDataset(sGoto : string);
    procedure fillHolder;
    procedure changeAllowgridEdit;
    Procedure chkFilter;
    procedure applyFilter;


  public
    { Public declarations }
    zAct   : TActTableAction;
    zData  : recMaidActionHolder;
  end;

function openMaidAction(act : TActTableAction; var theData : recmaidActionHolder) : boolean;

implementation

{$R *.dfm}

uses
    uD
  , prjConst
  , uSqlDefinitions
  , uVatCodes
  , uUtils
  , cmpRoomerDataset
  , uAppGlobal
  , cxGridExportLink
  , UITypes
  , uMaidActionsEdit;


//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function openMaidAction(act : TActTableAction; var theData : recmaidActionHolder) : boolean;
var
  frmMaidAction: TfrmMaidActions;
begin
  result := false;
  frmMaidAction := TfrmMaidActions.Create(nil);
  try
    frmMaidAction.zData := theData;
    frmMaidAction.zAct := act;
    frmMaidAction.ShowModal;
    if frmMaidAction.modalresult = mrOk then
    begin
      theData := frmMaidAction.zData;
      result := true;
    end
    else
    begin
      initMaidActionHolder(theData);
    end;
  finally
    freeandnil(frmMaidAction);
  end;
end;


///////////////////////////////////////////////////////////////////////
                    { Private declarations }
///////////////////////////////////////////////////////////////////////


Procedure TfrmMaidActions.fillGridFromDataset(sGoto : string);
var
  s    : string;
  rSet : TRoomerDataSet;
begin
  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'maAction';
  rSet := CreateNewDataSet;
  try
    s := format(select_MaidList_FormShow, [zSortStr]);
    if rSet_bySQL(rSet,s) then
    begin
      if m_.active then m_.Close;
      m_.LoadFromDataSet(rSet);
      if sGoto = '' then
      begin
        m_.First;
      end else
      begin
        try
          m_.Locate('maAction',sGoto,[]);
        except
        end;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;


procedure TfrmMaidActions.fillHolder;
begin
  initMaidActionHolder(zData);
  zData.ID           := m_.FieldByName('ID').AsInteger;
  zData.Active       := m_['Active'];
  zData.Description  := m_['maDescription'];
  zData.Action       := m_['maAction'];
  zData.Rule         := m_['maRule'];
  zData.Cross        := m_['maCross'];
  zData.Use          := m_['maUse'];
end;

procedure TfrmMaidActions.changeAllowgridEdit;
begin
  tvDataID.Options.Editing             := false;
  tvDatamaActive.Options.Editing         := zAllowGridEdit;
  tvDatamaDescription.Options.Editing    := zAllowGridEdit;
  tvDatamaRule.Options.Editing       := zAllowGridEdit;
  tvDatamaUSe.Options.Editing        := zAllowGridEdit;
  tvDatamaCross.Options.Editing    := zAllowGridEdit;
end;


procedure TfrmMaidActions.chkFilter;
var
  sFilter : string;
  rC1,rc2   : integer;
begin
  sFilter := edFilter.text;
  rc1 := tvData.DataController.RecordCount;
  rc2 := tvData.DataController.FilteredRecordCount;
  zFilterON := rc1 <> rc2;
end;


procedure TfrmMaidActions.edFilterChange(Sender: TObject);
begin
  if edFilter.Text = '' then
  begin
    tvData.DataController.Filter.Root.Clear;
    tvData.DataController.Filter.Active := false;
  end else
  begin
    applyFilter;
  end;

end;

procedure TfrmMaidActions.applyFilter;
begin
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvData.DataController.Filter.Root.Clear;
  tvData.DataController.Filter.Root.AddItem(tvDatamaDescription,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Active := True;
end;


/////////////////////////////////////////////////////////////
// Form actions
/////////////////////////////////////////////////////////////

procedure TfrmMaidActions.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  //**
  zFirstTime  := true;
  zAct        := actNone;
  zisAddrow   := false;
end;

procedure TfrmMaidActions.FormShow(Sender: TObject);
begin
  glb.EnableOrDisableTableRefresh('tblMaidActions', False);
//**
  panBtn.Visible := False;
  sbMain.Visible := false;

  fillGridFromDataset(zData.Action);
  zFirstTime := true;
  sbMain.SimpleText := zSortStr;

  if ZAct = actLookup then
  begin
    mnuiAllowGridEdit.Checked := false;
    panBtn.Visible := true;
  end else
  begin
    mnuiAllowGridEdit.Checked := true;
    sbMain.Visible := true;
  end;
  //-C
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  chkFilter;
  zFirstTime := false;
end;

procedure TfrmMaidActions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  try
    fillHolder;
    if tvdata.DataController.DataSet.State = dsInsert then
    begin
      tvdata.DataController.Post;
    end;
    if tvdata.DataController.DataSet.State = dsEdit then
    begin
      tvdata.DataController.Post;
    end;
  except
  end;
  glb.EnableOrDisableTableRefresh('tblMaidActions', True);
end;

procedure TfrmMaidActions.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    btnCancel.Click;

end;

procedure TfrmMaidActions.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if ZAct = actLookup then
  begin
    if key = chr(13) then
    begin
      if activecontrol = edFilter then
      begin
      end else
      begin
        btnOk.click;
      end;
    end;

    if key = chr(27) then
    begin
      if activecontrol = edFilter then
      begin
      end else
      begin
        btnCancel.click;
      end;
    end;
  end;
end;


////////////////////////////////////////////////////////////////////////////////////////
// memory table
////////////////////////////////////////////////////////////////////////////////////////
procedure TfrmMaidActions.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
  fillHolder;
  if hdata.maidActionExistsInOther(zData.Action) then
  begin
    Showmessage(format(GetTranslatedText('shExistsInRelatedDataCannotDelete'), ['Housekeeping rule', zData.Description]));
    Abort;
    exit;
  end;

  s := '';
  s := s+GetTranslatedText('shDeleteItemType')+' '+zData.Description+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if not Del_MaidAction(zData) then
      Abort
    else
      glb.ForceTableRefresh;
      fillGridFromDataset('');
  end;
    Abort;
end;


////////////////////////////////////////////////////////////////////////////////////////
//  table View Functions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmMaidActions.tvDataDescriptionPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_.fieldbyname('maDescription').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
    errortext := 'Description '+' - '+'is required - Use ESC to cancel';
    exit;
  end;

end;

procedure TfrmMaidActions.tvDataFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  if AFocusedRecord = nil then
  begin
    zIsAddrow := true;
  end else
  begin
    zIsAddrow := false;
  end;
end;

procedure TfrmMaidActions.tvDataItemtypePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_.fieldbyname('maAction').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
    errortext := 'Action '+' - '+'is required - Use ESC to cancel';
    exit;
  end;

  if hdata.MaidActionMaidActionExist(displayValue) then
  begin
    error := true;
    errortext := displayvalue+'  '+GetTranslatedText('shNewValueExistInAnotherRecor');
    exit
  end;

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if hdata.MaidActionMaidActionExist(currValue) then
    begin
      error := true;
      errortext := displayvalue+' - '+GetTranslatedText('shOldValueUsedInRelatedDataC');
      exit;
    end;
  end;
end;


procedure TfrmMaidActions.tvDataDblClick(Sender: TObject);
begin
  btnEdit.Click;
end;

procedure TfrmMaidActions.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;


procedure TfrmMaidActions.tvDataDataControllerSortingChanged(Sender: TObject);
var
  i : integer;
  s : string;
  serval : boolean;
begin
  s := '';
  serval := false;
  for i :=  0 to tvData.SortedItemCount - 1 do
  begin
    if serval then s := s+', ';
    s := s+TcxGridDBColumn(tvData.SortedItems[I]).DataBinding.FieldName;
    serval := true;
    if tvData.SortedItems[i].SortOrder = soDescending then
    s := s + ' DESC';
  end;
  zSortStr := s;
  sbMain.SimpleText := s;
end;

//////////////////////////////////////////////////////////////////////////
//  Buttons
//////////////////////////////////////////////////////////////////////////


procedure TfrmMaidActions.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmMaidActions.btnCancelClick(Sender: TObject);
begin
  initMaidActionHolder(zData);
end;

procedure TfrmMaidActions.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmMaidActions.btnDeleteClick(Sender: TObject);
begin
  m_.Delete;
end;

procedure TfrmMaidActions.btnEditClick(Sender: TObject);
begin
  fillHolder;
  if OpenMaidActionEdit(zData, false) then
  begin
    UPD_MaidAction(zData);
    glb.ForceTableRefresh;
    fillGridFromDataset(zData.action);
  end;
end;

procedure TfrmMaidActions.btnInsertClick(Sender: TObject);
var
  lData: recMaidActionHolder;
  lNewID: integer;
begin
  initMaidActionHolder(lData);
  if OpenMaidActionEdit(lData, True) then
  begin
    INS_MaidAction(lData, lNewId);
    glb.ForceTableRefresh;
    fillGridFromDataset(lData.action);
  end;
end;

//---------------------------------------------------------------------------
// Menu in other actions
//-----------------------------------------------------------------------------

procedure TfrmMaidActions.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;
  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;


procedure TfrmMaidActions.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;

procedure TfrmMaidActions.mnuiGridToExcelClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToExcel(sFilename, grData, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmMaidActions.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmMaidActions.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmMaidActions.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

end.

