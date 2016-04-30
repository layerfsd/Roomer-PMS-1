unit uVatCodes;

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
  , cmpRoomerConnection, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, dxPScxPivotGridLnk, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter, cxPropertiesStore, sEdit,
  sButton, sSpeedButton, sLabel, sPanel, sStatusBar, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld
  ;

type
  TfrmVatCodes = class(TForm)
    sbMain: TsStatusBar;
    PanTop: TsPanel;
    btnDelete: TsButton;
    btnOther: TsButton;
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
    m_VATCode: TWideStringField;
    m_Description: TWideStringField;
    m_VATPercentage: TFloatField;
    tvDataRecId: TcxGridDBColumn;
    tvDataVATCode: TcxGridDBColumn;
    tvDataDescription: TcxGridDBColumn;
    tvDataVATPercentage: TcxGridDBColumn;
    edFilter: TsEdit;
    btnClear: TsSpeedButton;
    cLabFilter: TsLabel;
    btnInsert: TsButton;
    btnEdit: TsButton;
    FormStore: TcxPropertiesStore;
    m_valueFormula: TWideStringField;
    tvDatavalueFormula: TcxGridDBColumn;
    m_BookKeepCode: TWideStringField;
    tvDataBookKeepCode: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnOkClick(Sender: TObject);
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
    procedure tvDataVATCodePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnClearClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure tvDataBookKeepCodePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);

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
    zData              : recVatCodeHolder;
  end;

function vatCodes(act : TActTableAction; var theData : recVatCodeHolder) : boolean;
function getVatCode(ed : TAdvEdit; lab : TLabel) : boolean;
function vatCodeValidate(ed : TAdvEdit; lab: TLabel) : boolean;

var
  frmVatCodes: TfrmVatCodes;

implementation

uses
   uD,
   uDImages,
   uBookKeepingCodes
   , uUtils;

{$R *.dfm}

//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function VatCodes(act : TActTableAction; var theData : recVatCodeHolder) : boolean;
begin
  result := false;
  frmVatCodes := TfrmVatCodes.Create(frmVatCodes);
  try
    frmVatCodes.zData := theData;
    frmVatCodes.zAct := act;
    frmVatCodes.ShowModal;
    if frmVatCodes.modalresult = mrOk then
    begin
      theData := frmVatCodes.zData;
      result := true;
    end
    else
    begin
      initVatCodeHolder(theData);
    end;
  finally
    freeandnil(frmVatCodes);
  end;
end;

function getVatCode(ed : TAdvEdit; lab : TLabel) : boolean;
var
  theData : recVatCodeHolder;
begin
  result := false;
  initVatCodeHolder(theData);
  theData.VatCode := trim(ed.text);
  result := VatCodes(actLookup,theData);

  if trim(theData.VatCode) = trim(ed.text) then
  begin
    result := false;
    exit;
  end;

  if result and (theData.VatCode <> ed.text) then
  begin
    ed.text := theData.VatCode;
    lab.Caption := theData.Description;
  end;
end;


function vatCodeValidate(ed : TAdvEdit; lab : TLabel) : boolean;
var
  sValue : string;
  pcCode : string;
  theData : recVatCodeHolder;
begin
  initVatCodeHolder(theData);
  theData.VatCode := trim(ed.Text);
  result := hdata.GET_VatCodeHolder(theData);

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



Procedure TfrmVatCodes.fillGridFromDataset(sGoto : string);
var
  s    : string;
  rSet : TRoomerDataSet;
begin
  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'VatCode ';

  s := '';
  s := s+ ' SELECT '+#10;
  s := s+ '    vatCode '+#10;
  s := s+ '   ,Description '+#10;
  s := s+ '   ,VATPercentage '+#10;
  s := s+ '   ,valueFormula '+#10;
  s := s+ '   ,BookKeepCode '+#10;
  s := s+ ' FROM '+#10;
  s := s+ '   vatcodes '+#10;
  s := s+ ' ORDER BY '+#10;
  s := s+ '  '+zSortStr+' ';

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
          m_.Locate('VatCode',sGoto,[]);
        except
        end;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure  TfrmVatCodes.fillHolder;
begin
  initVatCodeHolder(zData);
  zData.VATCode         := m_.fieldbyname('VATCode').asstring;
  zData.Description     := m_.fieldbyname('Description').asstring;
  zData.VATPercentage   := LocalFloatValue(m_.fieldbyname('VATPercentage').asString);
  zData.ValueFormula     := m_.fieldbyname('ValueFormula').asstring;
  zData.BookKeepCode     := m_.fieldbyname('BookKeepCode').asstring;
end;

procedure TfrmVatCodes.changeAllowgridEdit;
begin
  tvDataVATCode.Options.Editing        := zAllowGridEdit;
  tvDataDescription.Options.Editing    := zAllowGridEdit;
  tvDataVATPercentage.Options.Editing  := zAllowGridEdit;
  tvDataValueFormula.Options.Editing   := zAllowGridEdit;
  tvDataBookKeepCode.Options.Editing   := zAllowGridEdit;
end;


Procedure TfrmVatCodes.ChkFilter;
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

procedure TfrmVatCodes.FormClose(Sender: TObject; var Action: TCloseAction);
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
  glb.EnableOrDisableTableRefresh('vatcodes', True);
end;

procedure TfrmVatCodes.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  zFirstTime  := true;
  zAct        := actNone;
  zisAddrow   := false;
end;

procedure TfrmVatCodes.FormShow(Sender: TObject);
begin
  glb.EnableOrDisableTableRefresh('vatcodes', False);
  panBtn.Visible := False;
  sbMain.Visible := false;

  fillGridFromDataset(zData.VatCode);
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

procedure TfrmVatCodes.FormDestroy(Sender: TObject);
begin
  glb.EnableOrDisableTableRefresh('vatcodes', True);
  //
end;

procedure TfrmVatCodes.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmVatCodes.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
  fillHolder;
  if hdata.vatCodeExistsInOther(zData.VatCode) then
  begin
   // Showmessage('VatCode'+' ' + zData.Description + ' '+GetTranslatedText('shExistsInRelatedData')+' ' + chr(10) + GetTranslatedText('shCanNotDelete')+' ');
	  Showmessage(format(GetTranslatedText('shExistsInRelatedDataCannotDelete'), ['VATCode', zData.Description]));
    Abort;
    exit;
  end;

  s := '';
  s := s+GetTranslatedText('shDeleteVATCode')+' '+zData.Description+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if not Del_VatCode(zData) then
    begin
      abort;
    end
  end else
  begin
    abort
  end;
end;

procedure TfrmVatCodes.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('VatCode').Focused := True;
end;

procedure TfrmVatCodes.m_BeforePost(DataSet: TDataSet);
begin
  if zFirstTime then exit;

  initVatCodeHolder(zData);
  zData.VatCode      := dataset.fieldbyname('VatCode').asstring;
  zData.Description  := dataset.fieldbyname('Description').asstring;
  zData.VATPercentage:= LocalFloatValue(dataset.fieldbyname('VATPercentage').asString);
  zData.ValueFormula := dataset.fieldbyname('ValueFormula').asstring;
  zData.BookKeepCode := dataset.fieldbyname('BookKeepCode').asstring;

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if UPD_VatCode(zData) then
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

    if dataset.FieldByName('VatCode').AsString = ''  then
    begin
    //  showmessage('VatCode Code requierd - set value or use [ESC] to cancel ');
	    showmessage(GetTranslatedText('shTx_VATCodes_VATCodeRequired'));
      tvData.GetColumnByFieldName('VatCode').Focused := True;
      abort;
      exit;
    end;


    if ins_vatCode(zData) then
    begin
      glb.ForceTableRefresh;
    end else
    begin
      abort;
      exit;
    end;
  end;
end;

procedure TfrmVatCodes.m_NewRecord(DataSet: TDataSet);
begin
  dataset.fieldbyname('VATPercentage').asFloat := 0.00;
end;

////////////////////////////////////////////////////////////////////////////////////////
//  tvFunctions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmVatCodes.tvDataVATCodePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  CurrValue : string;
begin
  DisplayValue := TRIM(DisplayValue);

  currValue := m_.fieldbyname('VatCode').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
   // errortext := 'VatCode code '+' - '+'is required - Use ESC to cancel';
	  errortext := GetTranslatedText('shTx_VATCodes_VATCodeCodeIsRequired');
    exit;
  end;

  if hdata.vatCodeExist(displayValue) then
  begin
    error := true;
    errortext := displayvalue+'  '+GetTranslatedText('shNewValueExistInAnotherRecor');
    exit
  end;

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if hdata.vatCodeExistsInOther(currValue) then
    begin
      error := true;
      errortext := displayvalue+' - '+GetTranslatedText('shOldValueUsedInRelatedDataC');
      exit;
    end;
  end;
end;





procedure TfrmVatCodes.tvDataDblClick(Sender: TObject);
begin
  if ZAct = actLookup then
  begin
    btnOK.Click
  end;
end;

procedure TfrmVatCodes.tvDataFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
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

procedure TfrmVatCodes.tvDataBookKeepCodePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var s : String;
begin
  s := '';
  if NOT m_.Eof then
    s := m_['BookKeepCode'];
  s := BookKeepingCodes(actLookUp, s);
  if s <> '' then
  begin
    m_.Edit;
    m_['BookKeepCode'] := s;
    m_.Post;
  end;
end;

procedure TfrmVatCodes.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;

procedure TfrmVatCodes.tvDataDataControllerSortingChanged(Sender: TObject);
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

procedure TfrmVatCodes.ApplyFilter;
begin
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvData.DataController.Filter.Root.Clear;
  tvData.DataController.Filter.Root.AddItem(tvDataVatCode    ,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataDescription,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Active := True;
end;

procedure TfrmVatCodes.edFilterChange(Sender: TObject);
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

procedure TfrmVatCodes.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmVatCodes.btnCancelClick(Sender: TObject);
begin
  initVatCodeHolder(zData);
end;

procedure TfrmVatCodes.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmVatCodes.mnuExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmVatCodes.btnOtherClick(Sender: TObject);
begin
  //
end;

procedure TfrmVatCodes.btnDeleteClick(Sender: TObject);
begin
  m_.Delete;
end;


procedure TfrmVatCodes.btnEditClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  if m_.Active = false then m_.Open;
  grData.SetFocus;
  m_.Insert;
  tvData.GetColumnByFieldName('Description').Focused := True;
end;

procedure TfrmVatCodes.btnInsertClick(Sender: TObject);
begin
   mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  if m_.Active = false then m_.Open;
  grData.SetFocus;
  m_.Insert;
  tvData.GetColumnByFieldName('VATCode').Focused := True;
end;

////---------------------------------------------------------------------------
/// Menu in other actions
///-----------------------------------------------------------------------------

procedure TfrmVatCodes.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;

  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;

procedure TfrmVatCodes.mnuiGridToExcelClick(Sender: TObject);
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

procedure TfrmVatCodes.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmVatCodes.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmVatCodes.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

procedure TfrmVatCodes.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;


end.
