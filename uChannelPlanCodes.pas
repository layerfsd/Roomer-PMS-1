unit uChannelPlanCodes;

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
  , Menus
  , ImgList
  , StdCtrls
  , Mask
  , ExtCtrls
  , Grids
  , Buttons
  , shellapi

  , ADODB
  , db
  , DBTables
  , DBCtrls
  , ComCtrls

  , hData
  , uAppGlobal
  , _glob
  , ug

  , dxCore
  , cxGridExportLink
  , cxGraphics
  , cxControls
  , cxLookAndFeels
  , cxLookAndFeelPainters
  , cxStyles
  , cxCustomData
  , cxFilter
  , cxData
  , cxDataStorage
  , cxEdit
  , cxNavigator
  , cxDBData
  , cxGridCustomTableView
  , cxGridTableView
  , cxGridDBTableView
  , cxGridLevel
  , cxClasses
  , cxGridCustomView
  , cxGrid
  , cxTextEdit
  , cxContainer
  , cxDBEdit
  , cxGridCardView
  , cxGridDBCardView
  , cxGridCustomLayoutView
  , dxLayoutContainer
  , cxGridLayoutView
  , cxGridDBLayoutView
  , cxSpinEdit
  , dxPSGlbl
  , dxPSUtl
  , dxPSEngn
  , dxPrnPg
  , dxBkgnd
  , dxWrap
  , dxPrnDev
  , dxPSCompsProvider
  , dxPSFillPatterns
  , dxPSEdgePatterns
  , dxPSPDFExportCore
  , dxPSPDFExport
  , cxDrawTextUtils
  , dxPSPrVwStd
  , dxPSPrVwAdv
  , dxPSPrVwRibbon
  , dxPScxPageControlProducer
  , dxPScxEditorProducers
  , dxPScxExtEditorProducers
  , dxPSCore
  , dxPScxGridLnk
  , dxPScxGridLayoutViewLnk
  , dxPScxCommon
  , dxmdaset
  , cxGridBandedTableView
  , cxGridDBBandedTableView
  , cxCalc
  , cxVariants
  , cxDataUtils

  , AdvEdit
  , AdvEdBtn

  , PrjConst, cxButtonEdit, cxCheckBox

  , cmpRoomerDataSet
  , cmpRoomerConnection
  , sLabel
  , sSpeedButton
  , sEdit
  , sButton
  , sPanel
  , sStatusBar, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter, cxPropertiesStore, sCheckBox, dxPScxPivotGridLnk, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld

  ;

type
  TfrmChannelPlanCodes = class(TForm)
    sbMain: TsStatusBar;
    PanTop: TsPanel;
    btnDelete: TsButton;
    btnOther: TsButton;
    btnClose: TsButton;
    labFilterWarning: TStaticText;
    panBtn: TsPanel;
    btnCancel: TsButton;
    BtnOk: TsButton;
    tvData: TcxGridDBTableView;
    lvData: TcxGridLevel;
    grData: TcxGrid;
    m_: TdxMemData;
    mnuOther: TPopupMenu;
    mnuiPrint: TMenuItem;
    mnuiAllowGridEdit: TMenuItem;
    N2: TMenuItem;
    Export1: TMenuItem;
    mnuiGridToExcel: TMenuItem;
    mnuiGridToHtml: TMenuItem;
    mnuiGridToText: TMenuItem;
    mnuiGridToXml: TMenuItem;
    DS: TDataSource;
    grPrinter: TdxComponentPrinter;
    prLink_grData: TdxGridReportLink;
    Label1: TsLabel;
    edFilter: TsEdit;
    btnClear: TsSpeedButton;
    cLabFilter: TsLabel;
    btnInsert: TsButton;
    btnEdit: TsButton;
    m_Code: TStringField;
    m_Active: TBooleanField;
    tvDataRecId: TcxGridDBColumn;
    tvDataCode: TcxGridDBColumn;
    tvDataActive: TcxGridDBColumn;
    m_Description: TStringField;
    tvDataDescription: TcxGridDBColumn;
    chkActive: TsCheckBox;
    FormStore: TcxPropertiesStore;
    m_defaultPlan: TBooleanField;
    tvDatadefaultPlan: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnOkClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure btnOtherClick(Sender: TObject);
    procedure mnuiPrintClick(Sender: TObject);
    procedure mnuiAllowGridEditClick(Sender: TObject);
    procedure mnuiGridToExcelClick(Sender: TObject);
    procedure mnuiGridToHtmlClick(Sender: TObject);
    procedure mnuiGridToTextClick(Sender: TObject);
    procedure mnuiGridToXmlClick(Sender: TObject);
    procedure m_BeforePost(DataSet: TDataSet);
    procedure edFilterChange(Sender: TObject);
    procedure tvDataDataControllerFilterChanged(Sender: TObject);
    procedure m_NewRecord(DataSet: TDataSet);
    procedure tvDataDblClick(Sender: TObject);
    procedure tvDataDataControllerSortingChanged(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure tvDataFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure m_BeforeDelete(DataSet: TDataSet);
    procedure m_BeforeInsert(DataSet: TDataSet);
    procedure btnClearClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure tvDataCodePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure chkActiveClick(Sender: TObject);

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
    zAct               : TActTableAction;
    zData              : recChannelPlanCodeHolder;
  end;

function ChannelPlanCodes(act : TActTableAction; var theData : recChannelPlanCodeHolder) : boolean;
function getChannelPlanCode(ed : TAdvEdit; lab : TLabel) : boolean;
function ChannelCodeValidate(ed : TAdvEdit; lab: TLabel) : boolean;

var
  frmChannelPlanCodes: TfrmChannelPlanCodes;

implementation

uses
   uD, uDImages, uUtils;

{$R *.dfm}

//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function ChannelPlanCodes(act : TActTableAction; var theData : recChannelPlanCodeHolder) : boolean;
begin
  result := false;
  frmChannelPlanCodes := TfrmChannelPlanCodes.Create(frmChannelPlanCodes);
  try
    frmChannelPlanCodes.zData := theData;
    frmChannelPlanCodes.zAct := act;
    frmChannelPlanCodes.ShowModal;
    if frmChannelPlanCodes.modalresult = mrOk then
    begin
      theData := frmChannelPlanCodes.zData;
      result := true;
    end
    else
    begin
      initChannelPlanCodeHolder(theData);
    end;
  finally
    freeandnil(frmChannelPlanCodes);
  end;
end;

function getChannelPlanCode(ed : TAdvEdit; lab : TLabel) : boolean;
var
  theData : recChannelPlanCodeHolder;
begin
  result := false;
  initChannelPlanCodeHolder(theData);
  theData.Code := trim(ed.text);
  result := ChannelPlanCodes(actLookup,theData);

  if trim(theData.Code) = trim(ed.text) then
  begin
    result := false;
    exit;
  end;

  if result and (theData.Code <> ed.text) then
  begin
    ed.text := theData.Code;
    lab.Caption := theData.Description;
  end;
end;


function ChannelCodeValidate(ed : TAdvEdit; lab : TLabel) : boolean;
var
  sValue : string;
  pcCode : string;
  theData : recChannelPlanCodeHolder;
begin
  initChannelPlanCodeHolder(theData);
  theData.Code := trim(ed.Text);
  result := hdata.GET_ChannelPlanCodeHolder(theData);

  if not result then
  begin
    ed.SetFocus;
    lab.Color := clRed;
    lab.caption := GetTranslatedText('shNotF_star');
  end else
  begin
    lab.Color := clBtnFace;
    lab.caption := theData.Description;
  end;
end;
//END unit global functions

///////////////////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////////////////


Procedure TfrmChannelPlanCodes.fillGridFromDataset(sGoto : string);
var
  s    : string;
  rSet : TRoomerDataSet;
  active : boolean;
begin
  active := chkActive.Checked;
  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'Code ';

  s := '';
  s := s+ ' SELECT *'+#10;
  s := s+ ' FROM '+#10;
  s := s+ '   channelplancodes '+#10;
  s := s+ ' WHERE '+#10;
  s := s+ '   Active = %d '+#10;
  s := s+ ' ORDER BY '+#10;
  s := s+ '  '+zSortStr+' ';

  s := format(s, [ord(active)]);

  rSet := CreateNewDataSet;
  try
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
          m_.Locate('Code',sGoto,[]);
        except
        end;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure  TfrmChannelPlanCodes.fillHolder;
begin
  initChannelPlanCodeHolder(zData);
  zData.Code         := m_.fieldbyname('Code').asstring;
  zData.Description  := m_.fieldbyname('Description').asstring;
  zData.active       := m_['active'];
  zData.defaultPlan  := m_.fieldbyname('defaultPlan').AsBoolean;
end;

procedure TfrmChannelPlanCodes.changeAllowgridEdit;
begin
  if zAllowGridEdit then
  begin
    tvDataCode.Options.Editing        := true;
    tvDataDescription.Options.Editing    := true;
    tvDataActive.Options.Editing  := true;
    tvDatadefaultPlan.Options.Editing  := true;
  end else
  begin
    tvDataCode.Options.Editing        := false;
    tvDataDescription.Options.Editing    := false;
    tvDataActive.Options.Editing  := false;
    tvDatadefaultPlan.Options.Editing  := False;
  end;
end;


procedure TfrmChannelPlanCodes.chkActiveClick(Sender: TObject);
begin
  zFirstTime := false;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;
  fillGridFromDataset(zData.code);
  zFirstTime := false;
end;

Procedure TfrmChannelPlanCodes.ChkFilter;
var
  sFilter : string;
  rC1,rc2   : integer;
begin
  sFilter := edFilter.text;
  rc1 := tvData.DataController.RecordCount;
  rc2 := tvData.DataController.FilteredRecordCount;

  zFilterON := rc1 <> rc2;

  if zFilterON then
  begin
    labFilterWarning.Visible    := true;
    labFilterWarning.Color      := clMoneyGreen;
    labFilterWarning.Font.Style := [fsBold];                         //-C
    labFilterWarning.caption    := format(GetTranslatedText('shFilterOnRecordsOf'), [rc2, rc1]);
  end else
  begin
    labFilterWarning.Visible    := false;
  end;
end;


/////////////////////////////////////////////////////////////
// Form actions
/////////////////////////////////////////////////////////////

procedure TfrmChannelPlanCodes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if tvdata.DataController.DataSet.State = dsInsert then
  begin
    tvdata.DataController.Post;
  end;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;
end;

procedure TfrmChannelPlanCodes.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  zFirstTime  := true;
  zAct        := actNone;
  zisAddrow   := false;
end;

procedure TfrmChannelPlanCodes.FormShow(Sender: TObject);
begin
  panBtn.Visible := False;
  sbMain.Visible := false;
  btnClose.Visible := False;

  fillGridFromDataset(zData.Code);
  zFirstTime := true;
  sbMain.SimpleText := zSortStr;

  if ZAct = actLookup then
  begin
    mnuiAllowGridEdit.Checked := false;
    panBtn.Visible := true;
  end else
  begin
    mnuiAllowGridEdit.Checked := true;
    btnClose.Visible := true;
    sbMain.Visible := true;
  end;
  //-C
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  chkFilter;
  zFirstTime := false;
end;

procedure TfrmChannelPlanCodes.FormDestroy(Sender: TObject);
begin
  //
end;

procedure TfrmChannelPlanCodes.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmChannelPlanCodes.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
  fillHolder;
  if hdata.ChannelPlanCodeExistsInOther(zData.Code) then
  begin
	  Showmessage(format(GetTranslatedText('shExistsInRelatedDataCannotDelete'), ['Code', zData.Description]));
    Abort;
    exit;
  end;

  s := '';
  s := s+GetTranslatedText('shDeleteChannelPlanCode')+' '+zData.Description+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if not Del_ChannelPlanCode(zData) then
    begin
      abort;
    end
  end else
  begin
    abort
  end;
end;

procedure TfrmChannelPlanCodes.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('Code').Focused := True;
end;

procedure TfrmChannelPlanCodes.m_BeforePost(DataSet: TDataSet);
begin
  if zFirstTime then exit;

  initChannelPlanCodeHolder(zData);
  zData.Code      := dataset.fieldbyname('Code').asstring;
  zData.Description  := dataset.fieldbyname('Description').asstring;
  zData.Active := dataset.fieldbyname('active').asBoolean;
  zData.DefaultPlan := dataset.fieldbyname('defaultPlan').asBoolean;

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if UPD_ChannelPlanCode(zData) then
    begin
       glb.ForceTableRefresh;
    end else
    begin
      label1.Caption := GetTranslatedText('shTx_ChannelPlanCodes_UpdateNotOK');
      abort;
      exit;
    end;
  end;
  if tvData.DataController.DataSource.State = dsInsert then
  begin

    if dataset.FieldByName('Code').AsString = ''  then
    begin
	    showmessage(GetTranslatedText('shTx_ChannelPlanCodes_CodeRequired'));
      tvData.GetColumnByFieldName('Code').Focused := True;
      abort;
      exit;
    end;


    if ins_ChannelPlanCode(zData) then
    begin
      glb.ForceTableRefresh;
    end else
    begin
      label1.Caption := GetTranslatedText('shTx_ChannelPlanCodes_InsertNotOK');
      abort;
      exit;
    end;
  end;
end;

procedure TfrmChannelPlanCodes.m_NewRecord(DataSet: TDataSet);
begin
  dataset.fieldbyname('active').asBoolean := true;
  dataset.fieldbyname('defaultPlan').asBoolean := true;
end;

////////////////////////////////////////////////////////////////////////////////////////
//  tvFunctions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmChannelPlanCodes.tvDataDblClick(Sender: TObject);
begin
  if ZAct = actLookup then
  begin
    btnOK.Click
  end;
end;

procedure TfrmChannelPlanCodes.tvDataFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
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

////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////

procedure TfrmChannelPlanCodes.tvDataCodePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_.fieldbyname('Code').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
   // errortext := 'VatCode code '+' - '+'is required - Use ESC to cancel';
	  errortext := GetTranslatedText('shTx_ChannelPlanCodes_CodeIsRequired');
    exit;
  end;

  if hdata.ChannelPlanCodeExist(displayValue) then
  begin
    error := true;
    errortext := displayvalue+'  '+GetTranslatedText('shNewValueExistInAnotherRecor');
    exit
  end;

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if hdata.channelPlanCodeExistsInOther(currValue) then
    begin
      error := true;
      errortext := displayvalue+' - '+GetTranslatedText('shOldValueUsedInRelatedDataC');
      exit;
    end;
  end;
end;

procedure TfrmChannelPlanCodes.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;

procedure TfrmChannelPlanCodes.tvDataDataControllerSortingChanged(Sender: TObject);
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

procedure TfrmChannelPlanCodes.ApplyFilter;
begin
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvData.DataController.Filter.Root.Clear;
  tvData.DataController.Filter.Root.AddItem(tvDataCode    ,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataDescription,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Active := True;
end;

procedure TfrmChannelPlanCodes.edFilterChange(Sender: TObject);
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

//////////////////////////////////////////////////////////////////////////
//  Buttons
//////////////////////////////////////////////////////////////////////////

procedure TfrmChannelPlanCodes.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmChannelPlanCodes.btnCancelClick(Sender: TObject);
begin
  initChannelPlanCodeHolder(zData);
end;

procedure TfrmChannelPlanCodes.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmChannelPlanCodes.btnCloseClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmChannelPlanCodes.mnuExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmChannelPlanCodes.btnOtherClick(Sender: TObject);
begin
  //
end;

procedure TfrmChannelPlanCodes.btnDeleteClick(Sender: TObject);
begin
  m_.Delete;
end;


procedure TfrmChannelPlanCodes.btnEditClick(Sender: TObject);
begin
//  mnuiAllowGridEdit.Checked := true;
//  zAllowGridEdit := mnuiAllowGridEdit.Checked;
//  changeAllowGridEdit;
//  if m_.Active = false then m_.Open;
//  grData.SetFocus;
//  m_.Insert;
//  tvData.GetColumnByFieldName('Description').Focused := True;

  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  grData.SetFocus;
  tvData.GetColumnByFieldName('Description').Focused := True;
  showmessage(GetTranslatedText('shTx_Items2_EditInGrid'));
end;

procedure TfrmChannelPlanCodes.btnInsertClick(Sender: TObject);
begin
   mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  if m_.Active = false then m_.Open;
  grData.SetFocus;
  m_.Insert;
  tvData.GetColumnByFieldName('Code').Focused := True;
end;

////---------------------------------------------------------------------------
/// Menu in other actions
///-----------------------------------------------------------------------------

procedure TfrmChannelPlanCodes.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;

  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;

procedure TfrmChannelPlanCodes.mnuiGridToExcelClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToExcel(sFilename, grData, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
  //  To export ot xlsx form then use this
  //  ExportGridToXLSX(sFilename, grData, true, true, true);
  //  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xlsx'), nil, nil, sw_shownormal);
end;

procedure TfrmChannelPlanCodes.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmChannelPlanCodes.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmChannelPlanCodes.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

procedure TfrmChannelPlanCodes.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;


end.
