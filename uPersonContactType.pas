unit uPersonContactType;

interface

uses
    Windows
  , Messages
  , SysUtils
  , Variants
  , system.uiTypes
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
  , uDImages

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
  , cxCustomPivotGrid

  , PrjConst
  , cmpRoomerDataSet
  , cmpRoomerConnection

  , sLabel
  , sCustomComboEdit
  , sComboBoxes
  , sComboEdit
  , sSpeedButton
  , sEdit
  , sCheckBox
  , sButton
  , sPanel
  , sStatusBar, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter, cxPropertiesStore, dxPScxPivotGridLnk

  ;

type
  TfrmPersonContactType = class(TForm)
    sbMain: TsStatusBar;
    PanTop: TsPanel;
    btnInsert: TsButton;
    btnEdit: TsButton;
    btnDelete: TsButton;
    btnOther: TsButton;
    btnClose: TsButton;
    panBtn: TsPanel;
    btnCancel: TsButton;
    BtnOk: TsButton;
    tvData: TcxGridDBTableView;
    lvData: TcxGridLevel;
    grData: TcxGrid;
    m_: TdxMemData;
    m_Description: TWideStringField;
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
    m_ID: TIntegerField;
    chkActive: TsCheckBox;
    cLabFilter: TsLabel;
    edFilter: TsEdit;
    btnClear: TsSpeedButton;
    m_active: TBooleanField;
    FormStore: TcxPropertiesStore;
    tvDataRecId: TcxGridDBColumn;
    tvDataID: TcxGridDBColumn;
    tvDataDescription: TcxGridDBColumn;
    tvDataactive: TcxGridDBColumn;
    m_Code: TWideStringField;
    tvDataCode: TcxGridDBColumn;
    m_sysType: TIntegerField;
    tvDatasysType: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
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
    procedure btnClearClick(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
    procedure m_BeforeDelete(DataSet: TDataSet);
    procedure m_BeforeInsert(DataSet: TDataSet);
    procedure tvDataCodePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);

  private
    { Private declarations }
    zFirstTime       : boolean;
    //**
    zAllowGridEdit   : boolean;
    zFilterOn        : boolean;
    zSortStr         : string;
    Procedure fillGridFromDataset(sGoto : string);
    procedure fillHolder;
    procedure changeAllowgridEdit;
    Procedure chkFilter;
    procedure applyFilter;
  public
    { Public declarations }
    zAct               : TActTableAction;
    zData              : recPersonContactTypeHolder;
  end;

function openPersonContactType(act : TActTableAction; var theData : recPersonContactTypeHolder) : boolean;
function getPersonContactType(ed : TsComboEdit; lab : TsLabel) : boolean; overload;
function PersonContactTypeValidate(ed : TsComboEdit; lab: TsLabel) : boolean; overload;


var
  frmPersonContactType: TfrmPersonContactType;

implementation

uses
   uD
  , uSqlDefinitions
;

{$R *.dfm}

//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function openPersonContactType(act : TActTableAction; var theData : recPersonContactTypeHolder) : boolean;
begin
  result := false;
  frmPersonContactType := TfrmPersonContactType.Create(frmPersonContactType);
  try
    frmPersonContactType.zData := theData;
    frmPersonContactType.zAct := act;
    frmPersonContactType.ShowModal;
    if frmPersonContactType.modalresult = mrOk then
    begin
      theData := frmPersonContactType.zData;
      result := true;
    end
    else
    begin
      initPersonContactTypeHolder(theData);
    end;
  finally
    freeandnil(frmPersonContactType);
  end;
end;


function getPersonContactType(ed : TsComboEdit; lab : TsLabel) : boolean;
var
  theData : recPersonContactTypeHolder;
begin
  initPersonContactTypeHolder(theData);
  theData.code := trim(ed.text);
  result := openPersonContactType(actLookup,theData);

  if trim(theData.code) = trim(ed.text) then
  begin
    result := false;
    exit;
  end;

  if result and (theData.code <> ed.text) then
  begin
    ed.text := theData.code;
    lab.Caption := theData.Description;
  end;
end;


function PersonContactTypeValidate(ed : TsComboEdit; lab: TsLabel) : boolean;
var
  theData : recPersonContactTypeHolder;
begin
  initPersonContactTypeHolder(theData);
  theData.code := trim(ed.Text);
  result := hdata.GET_personContactTypeHolderByCode(theData);

  if not result then
  begin
    ed.SetFocus;
    lab.Color := clRed;
    lab.caption := GetTranslatedText('shNotF_star');
  end else
  begin
    lab.Color := clBtnFace;
    lab.Caption := theData.Description;
  end;
end;


//END unit global functions


///////////////////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////////////////

Procedure TfrmPersonContactType.fillGridFromDataset(sGoto : string);
var
  s    : string;
  rSet : TRoomerDataSet;
  active : boolean;
begin
  active := chkActive.Checked;
  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'Code ';
  rSet := CreateNewDataSet;
  try
		s := format(select_personContactType_fillGridFromDataset_byActive, [ord(active),zSortStr]);
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

procedure  TfrmPersonContactType.fillHolder;
begin
  initPersonContactTypeHolder(zData);
  zData.ID                  := m_.fieldbyname('ID').asInteger;
  zData.code                := m_.fieldbyname('Code').asstring;
  zData.Description         := m_.fieldbyname('Description').asstring;
  zData.sysType            := m_.fieldbyname('sysType').asInteger;
  zData.active              := m_['Active'];
end;

procedure TfrmPersonContactType.changeAllowgridEdit;
begin
  if zAllowGridEdit then
  begin
    tvDataCode.Options.Editing         := true;
    tvDataDescription.Options.Editing  := true;
    tvDatasysType.Options.Editing     := true;
    tvDataActive.Options.Editing       := true;
  end else
  begin
    tvDataCode.Options.Editing         := false;
    tvDataDescription.Options.Editing  := false;
    tvDatasysType.Options.Editing     := true;
    tvDataActive.Options.Editing       := true;
  end;
end;


procedure TfrmPersonContactType.chkActiveClick(Sender: TObject);
begin
  zFirstTime := false;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;
  fillGridFromDataset(zData.code);
  zFirstTime := false;
end;

Procedure TfrmPersonContactType.ChkFilter;
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
  end else
  begin
  end;
end;


/////////////////////////////////////////////////////////////
// Form actions
/////////////////////////////////////////////////////////////

procedure TfrmPersonContactType.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self);
  zFirstTime  := true;
  zAct        := actNone;
end;

procedure TfrmPersonContactType.FormShow(Sender: TObject);
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

procedure TfrmPersonContactType.FormDestroy(Sender: TObject);
begin
  //
end;

procedure TfrmPersonContactType.FormKeyPress(Sender: TObject; var Key: Char);
begin
  //*NOT TESTED*//
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

procedure TfrmPersonContactType.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
  fillHolder;

  if hdata.PersonContactTypeExistsInOther(zData.Code) then
  begin
    Showmessage(format(GetTranslatedText('shExistsInRelatedDataCannotDelete'), ['person contact Type', zData.Description]));
    exit;
  end;

  s := '';
  s := s+GetTranslatedText('shDeletePersonContactType')+' '+zData.Code+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    screen.Cursor := crHourGlass;
    try
      if not Del_PersonContactTypeByCode(zData.Code) then
      begin
        abort
      end;
    finally
      screen.Cursor := crDefault;
    end;
  end else
  begin
    abort;
  end;
end;

procedure TfrmPersonContactType.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('Code').Focused := True;
end;

procedure TfrmPersonContactType.m_BeforePost(DataSet: TDataSet);
var
  nID : integer;
begin
  if zFirstTime then exit;
  nId := 0;

  initPersonContactTypeHolder(zData);
  zData.code        := dataset['Code'];
  zData.Description := dataset['Description'];
  zData.sysType    := dataset['sysType'];
  zData.active      := dataset['active'];

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if UPD_PersonContactType(zData) then
    begin
      glb.ForceTableRefresh;
    end else
    begin
      abort;
      exit;
    end;
  end;
  if tvData.DataController.DataSource.State = dsInsert then
  begin

    if dataset.FieldByName('Code').AsString = ''  then
    begin
      //showmessage('Currency requierd - set value or use [ESC] to cancel ');
	    showmessage(GetTranslatedText('shTx_PersonContactType_Required'));
      tvData.GetColumnByFieldName('Code').Focused := True;
      abort;
      exit;
    end;

    if ins_PersonContactType(zData,nID) then
    begin
      m_.FieldByName('ID').AsInteger := nID;
      glb.ForceTableRefresh;
    end else
    begin
      abort;
      exit;
    end;
  end;
end;

procedure TfrmPersonContactType.m_NewRecord(DataSet: TDataSet);
begin
  dataset.FieldByName('sysType').AsInteger := 0;
  dataset['Active'] := true;
  dataset['Code'] := '';
  dataset['description'] := '';
end;

////////////////////////////////////////////////////////////////////////////////////////
//  tvFunctions
////////////////////////////////////////////////////////////////////////////////////////

//procedure TfrmPersonContactType.tvDataCurrencyPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
//  var Error: Boolean);
//var
//  CurrValue : string;
//begin
//  currValue := m_.fieldbyname('Code').asstring;
//
//  error := false;
//  if trim(displayValue) = '' then
//  begin
//    error := true;
//    //errortext := 'Currency code '+' - '+'is required - Use ESC to cancel';
//	  errortext := GetTranslatedText('shTx_Currencies_CodeIsRequired');
//    exit;
//  end;
//
//  if hdata.CurrencyExist(displayValue) then
//  begin
//    error := true;
//    //errortext := displayvalue+'Nýtt gildi er til í annari færslu. Notið ESC-hnappin til að hætta við';
//    errortext := displayvalue+GetTranslatedText('shNewValueExistInAnotherRecor');
//    exit
//  end;
//
//  if tvData.DataController.DataSource.State = dsEdit then
//  begin
//    if hdata.currencyExistsInOther(currValue) then
//    begin
//      error := true;
//      // errortext := displayvalue+'Eldra gildi fannst í tengdri færslu ekki hægt að breyta - Notið 'ESC-hnappin til að hætta við';
//      errortext := displayvalue+GetTranslatedText('shOldValueUsedInRelatedDataC');
//      exit;
//    end;
//  end;
//end;


//procedure TfrmPersonContactType.tvDataAValuePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
//  var Error: Boolean);
////var
////  CurrValue : double;
//begin
////  currValue := LocalFloatValue(m_.fieldbyname('AValue').asString);
//  if (displayValue = 0) then
//  begin
//    error := true;
//    //errortext := 'Rate'+' '+'can not be 0'+'  '+'Use ESC- to cancel';
//	errortext := GetTranslatedText('shTx_Currencies_RateCannotBeZeroCancel');
//  end;
//end;


procedure TfrmPersonContactType.tvDataDblClick(Sender: TObject);
begin
  if ZAct = actLookup then
  begin
    btnOK.Click
  end else
  begin
    btnedit.click
  end;
end;



////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////

procedure TfrmPersonContactType.tvDataCodePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_.fieldbyname('Code').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
    //errortext := 'Currency code '+' - '+'is required - Use ESC to cancel';
	  errortext := GetTranslatedText('shTx_PersonContactType_CodeIsRequired');
    exit;
  end;

  if hdata.PersonContactTypeExists(displayValue) then
  begin
    error := true;
    //errortext := displayvalue+'Nýtt gildi er til í annari færslu. Notið ESC-hnappin til að hætta við';
    errortext := displayvalue+GetTranslatedText('shNewValueExistInAnotherRecor');
    exit
  end;

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if hdata.PersonContactTypeExistsInOther(currValue) then
    begin
      error := true;
      // errortext := displayvalue+'Eldra gildi fannst í tengdri færslu ekki hægt að breyta - Notið 'ESC-hnappin til að hætta við';
      errortext := displayvalue+GetTranslatedText('shOldValueUsedInRelatedDataC');
      exit;
    end;
  end;
end;

procedure TfrmPersonContactType.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;

procedure TfrmPersonContactType.tvDataDataControllerSortingChanged(Sender: TObject);
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

procedure TfrmPersonContactType.ApplyFilter;
begin
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvData.DataController.Filter.Root.Clear;
  tvData.DataController.Filter.Root.AddItem(tvDataCode,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataDescription,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Active := True;
end;

procedure TfrmPersonContactType.edFilterChange(Sender: TObject);
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

procedure TfrmPersonContactType.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;


procedure TfrmPersonContactType.btnCancelClick(Sender: TObject);
begin
  initPersonContactTypeHolder(zData);
end;

procedure TfrmPersonContactType.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmPersonContactType.btnCloseClick(Sender: TObject);
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

procedure TfrmPersonContactType.mnuExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPersonContactType.btnOtherClick(Sender: TObject);
begin
  //
end;

procedure TfrmPersonContactType.btnInsertClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  if m_.Active = false then m_.Open;
  grData.SetFocus;
  m_.Insert;
  tvData.GetColumnByFieldName('Code').Focused := True;
end;

procedure TfrmPersonContactType.btnEditClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  grData.SetFocus;
  tvData.GetColumnByFieldName('Code').Focused := True;
  //showmessage('edit in grid');
  showmessage(GetTranslatedText('shTx_PersonContactType_EditInGrid'));
end;

procedure TfrmPersonContactType.btnDeleteClick(Sender: TObject);
begin
  m_.Delete;
end;

////---------------------------------------------------------------------------
/// Menu in other actions
///-----------------------------------------------------------------------------

procedure TfrmPersonContactType.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;

  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;

procedure TfrmPersonContactType.mnuiGridToExcelClick(Sender: TObject);
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

procedure TfrmPersonContactType.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmPersonContactType.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmPersonContactType.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

procedure TfrmPersonContactType.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;


end.
