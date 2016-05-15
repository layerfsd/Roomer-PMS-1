unit uItemTypes2;

interface

uses
    Winapi.Windows
  , Winapi.Messages
  , System.SysUtils
  , System.Variants
  , System.Classes
  , Vcl.Graphics
  , Vcl.Controls
  , Vcl.Forms
  , Vcl.Dialogs
  , Vcl.Buttons
  , Vcl.StdCtrls
  , Vcl.ComCtrls
  , Vcl.Menus
  , Vcl.ExtCtrls
  , Generics.Collections
  , Data.DB
  , shellapi

  , uAppGlobal
  , _glob
  , Hdata
  , ug
  , uManageFilesOnServer
  , kbmMemTable
  , uDImages

  , sSkinProvider
  , sSpeedButton
  , sEdit
  , sPageControl
  , sStatusBar
  , sLabel
  , sButton
  , sPanel

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
  , dxPScxGridLnk
  , dxPScxGridLayoutViewLnk
  , dxPScxEditorProducers
  , dxPScxExtEditorProducers
  , dxPSCore
  , dxPScxCommon

  , cmpRoomerDataSet
  , cmpRoomerConnection, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxButtonEdit, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter, cxPropertiesStore, dxmdaset,
  dxPScxPivotGridLnk, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld

  ;

type
  TfrmItemTypes2 = class(TForm)
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
    m_ID: TIntegerField;
    m_Active: TBooleanField;
    tvDataRecId: TcxGridDBColumn;
    tvDataID: TcxGridDBColumn;
    tvDataActive: TcxGridDBColumn;
    m_Itemtype: TWideStringField;
    m_Description: TWideStringField;
    m_VATCode: TWideStringField;
    m_AccItemLink: TWideStringField;
    tvDataItemtype: TcxGridDBColumn;
    tvDataDescription: TcxGridDBColumn;
    tvDataVATCode: TcxGridDBColumn;
    tvDataAccItemLink: TcxGridDBColumn;
    btnEdit: TsButton;
    btnInsert: TsButton;
    FormStore: TcxPropertiesStore;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure m_BeforeDelete(DataSet: TDataSet);
    procedure m_BeforeInsert(DataSet: TDataSet);
    procedure m_BeforePost(DataSet: TDataSet);
    procedure m_NewRecord(DataSet: TDataSet);
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
    procedure btnOtherClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure mnuiPrintClick(Sender: TObject);
    procedure mnuiAllowGridEditClick(Sender: TObject);
    procedure mnuiGridToExcelClick(Sender: TObject);
    procedure mnuiGridToHtmlClick(Sender: TObject);
    procedure mnuiGridToTextClick(Sender: TObject);
    procedure mnuiGridToXmlClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure edFilterChange(Sender: TObject);
    procedure tvDataVATCodePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvDataItemtypePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure tvDataVATCodePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnInsertClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
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
    function getPrevCode : string;
    Procedure chkFilter;
    procedure applyFilter;


  public
    { Public declarations }
    zAct   : TActTableAction;
    zData  : recItemTypeHolder;
  end;

function openItemTypes(act : TActTableAction; var theData : recItemTypeHolder) : boolean;

var
  frmItemTypes2: TfrmItemTypes2;

implementation

{$R *.dfm}

uses
    uD
  , prjConst
  , uSqlDefinitions
  , uVatCodes
  , uUtils
  ;


//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function openItemTypes(act : TActTableAction; var theData : recItemTypeHolder) : boolean;
begin
  result := false;
  frmItemTypes2 := TfrmItemTypes2.Create(frmItemTypes2);
  try
    frmItemTypes2.zData := theData;
    frmItemTypes2.zAct := act;
    frmItemTypes2.ShowModal;
    if frmItemTypes2.modalresult = mrOk then
    begin
      theData := frmItemTypes2.zData;
      result := true;
    end
    else
    begin
      initItemTypeHolder(theData);
    end;
  finally
    freeandnil(frmItemTypes2);
  end;
end;


///////////////////////////////////////////////////////////////////////
                    { Private declarations }
///////////////////////////////////////////////////////////////////////


Procedure TfrmItemTypes2.fillGridFromDataset(sGoto : string);
var
  s    : string;
  rSet : TRoomerDataSet;
begin
  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'itemType';
  rSet := CreateNewDataSet;
  try
    s := format(select_ItemTypes, [zSortStr]);
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
          m_.Locate('itemType',sGoto,[]);
        except
        end;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

//    ID          : integer;
//    Active      : boolean;
//    Description : string; // MAX 30
//    Itemtype    : string; // MAX 5
//    VATCode     : string; // MAX 10
//    AccItemLink : string; // MAX 20


procedure TfrmItemTypes2.fillHolder;
begin
  initItemTypeHolder(zData);
  zData.ID           := m_.FieldByName('ID').AsInteger;
  zData.Active       := m_['Active'];
  zData.Description  := m_['Description'];
  zData.Itemtype     := m_['Itemtype'];
  zData.VATCode      := m_['VATCode'];
  zData.AccItemLink  := m_['AccItemLink'];
end;

procedure TfrmItemTypes2.changeAllowgridEdit;
begin
  if zAllowGridEdit then
  begin
    tvDataID.Options.Editing             := false;
    tvDataActive.Options.Editing         := true;
    tvDataDescription.Options.Editing    := true;
    tvDataItemtype.Options.Editing       := true;
    tvDataVATCode.Options.Editing        := true;
    tvDataAccItemLink.Options.Editing    := true;
  end else
  begin
    tvDataID.Options.Editing             := false;
    tvDataActive.Options.Editing         := false;
    tvDataDescription.Options.Editing    := false;
    tvDataItemtype.Options.Editing       := false;
    tvDataVATCode.Options.Editing        := false;
    tvDataAccItemLink.Options.Editing    := false;
  end;
end;


procedure TfrmItemTypes2.chkFilter;
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


procedure TfrmItemTypes2.edFilterChange(Sender: TObject);
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

procedure TfrmItemTypes2.applyFilter;
begin
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvData.DataController.Filter.Root.Clear;
  tvData.DataController.Filter.Root.AddItem(tvDataDescription,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Active := True;
end;


/////////////////////////////////////////////////////////////
// Form actions
/////////////////////////////////////////////////////////////

procedure TfrmItemTypes2.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  //**
  zFirstTime  := true;
  zAct        := actNone;
  zisAddrow   := false;
end;

procedure TfrmItemTypes2.FormDestroy(Sender: TObject);
begin
  glb.EnableOrDisableTableRefresh('itemtypes', True);
end;

procedure TfrmItemTypes2.FormShow(Sender: TObject);
begin
  glb.EnableOrDisableTableRefresh('itemtypes', False);
//**
  panBtn.Visible := False;
  sbMain.Visible := false;

  fillGridFromDataset(zData.itemType);
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

procedure TfrmItemTypes2.FormClose(Sender: TObject; var Action: TCloseAction);
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
  glb.EnableOrDisableTableRefresh('itemtypes', True);
end;

procedure TfrmItemTypes2.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    btnCancel.Click;

end;

procedure TfrmItemTypes2.FormKeyPress(Sender: TObject; var Key: Char);
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
function TfrmItemTypes2.getPrevCode: string;
begin
end;

procedure TfrmItemTypes2.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
  fillHolder;
  if hdata.itemTypeExistsInOther(zData.itemType) then
  begin
    Showmessage(format(GetTranslatedText('shExistsInRelatedDataCannotDelete'), ['Itemtype', zData.Description]));
    Abort;
    exit;
  end;

  s := '';
  s := s+GetTranslatedText('shDeleteItemType')+' '+zData.Description+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if not Del_ItemType(zData) then
    begin
      abort;
    end
  end else
  begin
    abort
  end;
end;

procedure TfrmItemTypes2.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('ItemType').Focused := True;
end;


procedure TfrmItemTypes2.m_BeforePost(DataSet: TDataSet);
var
  nID : integer;
begin
  if zFirstTime then exit;

  initItemTypeHolder(zData);
  zData.ID                := dataset.FieldByName('ID').AsInteger;
  zData.Active       := dataset['Active'];
  zData.ItemType     := dataset['ItemType'];
  zData.Description  := dataset['Description'];
  zData.VATCode      := dataset['VATCode'];
  zData.AccItemLink  := dataset['AccItemLink'];

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if UPD_ItemType(zData) then
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
    if dataset.FieldByName('ItemType').AsString = ''  then
    begin
      showmessage('ItemType is requierd - set value or use [ESC] to cancel ');
      tvData.GetColumnByFieldName('ItemType').Focused := True;
      abort;
      exit;
    end;
    if dataset.FieldByName('VATCode').AsString = ''  then
    begin
      showmessage('VAT code is requierd - set value or use [ESC] to cancel ');
      tvData.GetColumnByFieldName('VATCode').Focused := True;
      abort;
      exit;
    end;
    if ins_ItemType(zData,nID) then
    begin
      glb.ForceTableRefresh;
    end else
    begin
      abort;
      exit;
    end;
  end;
end;



procedure TfrmItemTypes2.m_NewRecord(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  dataset['Active']        := true;
  dataset['ItemType']      := '';
  dataset['Description']   := '';
  dataset['VATCode']  := '' ;
  dataset['AccItemLink']  := '' ;
end;

////////////////////////////////////////////////////////////////////////////////////////
//  table View Functions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmItemTypes2.tvDataDescriptionPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_.fieldbyname('Description').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
    errortext := 'Description '+' - '+'is required - Use ESC to cancel';
    exit;
  end;

  if hdata.itemtypesItemtypeExist(displayValue) then
  begin
    error := true;
    //errortext := displayvalue+'Nýtt gildi er til í annari færslu. Notið ESC-hnappin til að hætta við';
    errortext := displayvalue+'  '+GetTranslatedText('shNewValueExistInAnotherRecor');
    exit
  end;

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if hdata.payTypeExistsInOther(currValue) then
    begin
      error := true;
      errortext := displayvalue+' - '+GetTranslatedText('shOldValueUsedInRelatedDataC');
      exit;
    end;
  end;
end;

procedure TfrmItemTypes2.tvDataFocusedRecordChanged(
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

procedure TfrmItemTypes2.tvDataItemtypePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_.fieldbyname('ItemType').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
    errortext := 'Item code '+' - '+'is required - Use ESC to cancel';
    exit;
  end;

  if hdata.itemTypesItemTypeExist(displayValue) then
  begin
    error := true;
    errortext := displayvalue+'  '+GetTranslatedText('shNewValueExistInAnotherRecor');
    exit
  end;

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if hdata.itemTypeExistsInOther(currValue) then
    begin
      error := true;
      errortext := displayvalue+' - '+GetTranslatedText('shOldValueUsedInRelatedDataC');
      exit;
    end;
  end;
end;

procedure TfrmItemTypes2.tvDataVATCodePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recVatCodeHolder;
begin
  fillholder;
  theData.VATCode := zData.VATCode;
  vatCodes(actlookup,theData);

  if theData.VATCode <> '' then
  begin
    if tvData.DataController.DataSource.State <> dsInsert then m_.Edit;
    m_['VatCode'] := theData.vatCode;
  end;
end;


procedure TfrmItemTypes2.tvDataVATCodePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  CurrValue : string;
begin
  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
    errortext := 'VAT code '+' - '+'is required - Use ESC to cancel';
    exit;
  end;
end;

procedure TfrmItemTypes2.tvDataDblClick(Sender: TObject);
begin
  if ZAct = actLookup then
  begin
    btnOK.Click
  end;
end;


////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////


//procedure TfrmItemTypes2.tvDataCurrencyPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
//var
//  theData : recCurrencyHolder;
//begin
////  fillholder;
////  theData.Currency := zData.Currency;
////  theData.ID := zData.CurrencyID;
////
////
////  currencies(actlookup,theData);
////
////  if theData.Currency <> '' then
////  begin
////    m_.Edit;
////    m_['currency']   := theData.Currency;
////    m_['currencyID'] := theData.ID;
////    m_.Post;
////  end;
//
//end;

procedure TfrmItemTypes2.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;


procedure TfrmItemTypes2.tvDataDataControllerSortingChanged(Sender: TObject);
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


procedure TfrmItemTypes2.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmItemTypes2.btnOtherClick(Sender: TObject);
begin
  //**
end;

procedure TfrmItemTypes2.btnCancelClick(Sender: TObject);
begin
  initItemTypeHolder(zData);
end;

procedure TfrmItemTypes2.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmItemTypes2.btnDeleteClick(Sender: TObject);
begin
  m_.Delete;
end;

procedure TfrmItemTypes2.btnEditClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  grData.SetFocus;
  tvData.GetColumnByFieldName('Description').Focused := True;
  showmessage('Edit in grid');
end;

procedure TfrmItemTypes2.btnInsertClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  if m_.Active = false then m_.Open;
  grData.SetFocus;
  m_.Insert;
  tvData.GetColumnByFieldName('ItemType').Focused := True;
end;

//---------------------------------------------------------------------------
// Menu in other actions
//-----------------------------------------------------------------------------

procedure TfrmItemTypes2.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;
  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;


procedure TfrmItemTypes2.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;

procedure TfrmItemTypes2.mnuiGridToExcelClick(Sender: TObject);
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

procedure TfrmItemTypes2.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmItemTypes2.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmItemTypes2.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

end.

