unit uPackages;

interface

// unit added 2013-02-28 HJ

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

  , _glob
   , uAppGlobal
  , Hdata
  , ug
  , uManageFilesOnServer
  , kbmMemTable

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
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxButtonEdit, cxSpinEdit, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter, cxPropertiesStore,
  dxmdaset, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld

  ;

type
  TfrmPackages = class(TForm)
    sPanel1: TsPanel;
    btnDelete: TsButton;
    btnOther: TsButton;
    labFilterWarning: TsLabel;
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
    Label1: TsLabel;
    grPrinter: TdxComponentPrinter;
    prLink_grData: TdxGridReportLink;
    m_: TdxMemData;
    m_ID: TIntegerField;
    m_Active: TBooleanField;
    m_Description: TWideStringField;
    btnInsert: TsButton;
    btnEdit: TsButton;
    m_Package: TWideStringField;
    m_showItemsOnInvoice: TBooleanField;
    m_CurrencyID: TIntegerField;
    m_Currency: TWideStringField;
    grData: TcxGrid;
    tvData: TcxGridDBTableView;
    tvDataRecId: TcxGridDBColumn;
    tvDataID: TcxGridDBColumn;
    tvDataPackage: TcxGridDBColumn;
    tvDataDescription: TcxGridDBColumn;
    tvDatashowItemsOnInvoice: TcxGridDBColumn;
    tvDataActive: TcxGridDBColumn;
    tvDataCurrency: TcxGridDBColumn;
    tvDataCurrencyID: TcxGridDBColumn;
    tvItems: TcxGridDBTableView;
    tvItemsRecId: TcxGridDBColumn;
    tvItemsPItemID: TcxGridDBColumn;
    tvItemsdescription: TcxGridDBColumn;
    tvItemsnumItems: TcxGridDBColumn;
    tvItemsunitPrice: TcxGridDBColumn;
    tvItemsitem: TcxGridDBColumn;
    tvItemsitemDescription: TcxGridDBColumn;
    tvItemsitemPrice: TcxGridDBColumn;
    tvItem: TcxGridDBTableView;
    tvItemRecId: TcxGridDBColumn;
    tvItempackageId: TcxGridDBColumn;
    tvItemdescription: TcxGridDBColumn;
    tvItemunitPrice: TcxGridDBColumn;
    tvItemitem: TcxGridDBColumn;
    tvItemitemDescription: TcxGridDBColumn;
    tvItemitemPrice: TcxGridDBColumn;
    lvData: TcxGridLevel;
    tvItemnumItems: TcxGridDBColumn;
    tvItemId: TcxGridDBColumn;
    tvItemitemID: TcxGridDBColumn;
    m_TotalPrice: TFloatField;
    tvDataTotalPrice: TcxGridDBColumn;
    tvDataColumn1: TcxGridDBColumn;
    FormStore: TcxPropertiesStore;
    m_InvoiceText: TWideStringField;
    tvDataInvoiceText: TcxGridDBColumn;
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
    procedure tvDataPackagePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure tvDataCurrencyPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure btnInsertClick(Sender: TObject);
    procedure m_AfterScroll(DataSet: TDataSet);
    procedure m_TotalPriceSetText(Sender: TField; const Text: string);
    procedure m_CalcFields(DataSet: TDataSet);
    procedure tvDataColumn1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure FormDestroy(Sender: TObject);
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
    procedure GetPackageItems;

  public
    { Public declarations }
    zAct   : TActTableAction;
    zData  : recPackageHolder;
    zrData : recPackageItemHolder;

  end;

function openPackages(act : TActTableAction; var theData : recPackageHolder) : boolean;

function GetPackagetPrice(package, currency : String) : Double;

var
  frmPackages: TfrmPackages;

implementation

{$R *.dfm}

uses
    uD
  , prjConst
  , uSqlDefinitions
  , uCurrencies
  , uPackageItems
  , uDImages
  ;


//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function openPackages(act : TActTableAction; var theData : recPackageHolder) : boolean;
begin
  result := false;
  frmPackages := TfrmPackages.Create(frmPackages);
  try
    frmPackages.zData := theData;
    frmPackages.zAct := act;
    frmPackages.ShowModal;
    if frmPackages.modalresult = mrOk then
    begin
      theData := frmPackages.zData;
      result := true;
    end
    else
    begin
      initPackageHolder(theData);
    end;
  finally
    freeandnil(frmPackages);
  end;
end;

///////////////////////////////////////////////////////////////////////
                    { Private declarations }
///////////////////////////////////////////////////////////////////////

Procedure TfrmPackages.fillGridFromDataset(sGoto : string);
var
  s    : string;
  rSet : TRoomerDataSet;
begin
  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'Package';
  rSet := CreateNewDataSet;
  try
    s := format(select_packages, [zSortStr]);
    if rSet_bySQL(rSet,s) then
    begin
      if not m_.active then m_.open;
//      m_.LoadFromDataSet(rSet);
      rSet.First;
      while not rSet.Eof do
      begin
        m_.insert;
        m_.FieldByName('ID').AsInteger := rSet.FieldByName('ID').AsInteger;
        m_.FieldByName('Active').AsBoolean := rSet.FieldByName('Active').AsBoolean;
        m_.FieldByName('Description').AsString  := rSet.FieldByName('Description').AsString;
        m_.FieldByName('Package').AsString  := rSet.FieldByName('Package').AsString;
        m_.FieldByName('showItemsOnInvoice').AsBoolean := rSet.FieldByName('showItemsOnInvoice').AsBoolean;
        m_.FieldByName('currencyID').AsInteger := rSet.FieldByName('currencyID').AsInteger;
        m_.FieldByName('currency').AsString  := rSet.FieldByName('currency').AsString;
        m_.FieldByName('TotalPrice').AsFloat  := Packageitem_TotalByPackageID(m_.FieldByName('ID').AsInteger);
        m_.FieldByName('invoiceText').AsString  := rSet.FieldByName('invoiceText').AsString;
        m_.post;
        rSet.Next;
      end;
      if sGoto = '' then
      begin
        m_.First;
      end else
      begin
        try
          m_.Locate('Package',sGoto,[]);
        except
        end;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure TfrmPackages.fillHolder;
begin
  initPackageHolder(zData);
  zData.ID                    := m_.FieldByName('ID').AsInteger;
  zData.Active                := m_['Active'];
  zData.Description           := m_['Description'];
  zData.Package               := m_['Package'];
  zData.showItemsOnInvoice    := m_['showItemsOnInvoice'];
  zData.currencyID            := m_['currencyID'];
  zData.currency              := m_['currency'];
  zData.InvoiceText           := m_['InvoiceText'];
end;




procedure TfrmPackages.changeAllowgridEdit;
begin
  if zAllowGridEdit then
  begin
    tvDataID.Options.Editing                  := false;
    tvDataActive.Options.Editing              := true;
    tvDataDescription.Options.Editing         := true;
    tvDataPackage.Options.Editing             := true;
    tvDatashowItemsOnInvoice.Options.Editing  := true;
    tvDataCurrency.Options.Editing  := true;
    tvDataInvoiceText.Options.Editing  := true;
  end else
  begin
    tvDataID.Options.Editing                  := false;
    tvDataActive.Options.Editing              := false;
    tvDataDescription.Options.Editing         := false;
    tvDataPackage.Options.Editing             := false;
    tvDatashowItemsOnInvoice.Options.Editing  := false;
    tvDataCurrency.Options.Editing  := false;
    tvDataInvoiceText.Options.Editing  := False;
  end;
end;


procedure TfrmPackages.chkFilter;
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
//    labFilterWarning.caption    := shFilterOn+' - '+inttostr(rc2)+' '+shRecordsOf+' '+inttostr(rc1)+' '+shAreVisible+' ';;
    labFilterWarning.caption    := format(GetTranslatedText('shFilterOnRecordsOf'), [rc2, rc1]);
  end else
  begin
    labFilterWarning.Visible    := false;
  end;
end;


procedure TfrmPackages.edFilterChange(Sender: TObject);
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

procedure TfrmPackages.applyFilter;
begin
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvData.DataController.Filter.Root.Clear;
  tvData.DataController.Filter.Root.AddItem(tvDataDescription,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataPackage,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Active := True;
end;


/////////////////////////////////////////////////////////////
// Form actions
/////////////////////////////////////////////////////////////

procedure TfrmPackages.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  //**
  zFirstTime  := true;
  zAct        := actNone;
  zisAddrow   := false;
end;

procedure TfrmPackages.FormDestroy(Sender: TObject);
begin
   glb.EnableOrDisableTableRefresh('packages', True);
end;

procedure TfrmPackages.FormShow(Sender: TObject);
begin
//**
  glb.EnableOrDisableTableRefresh('packages', False);
  panBtn.Visible := False;
  sbMain.Visible := false;

  fillGridFromDataset(zData.Package);
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

procedure TfrmPackages.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if m_.recordcount > 0 then fillHolder;
  if tvdata.DataController.DataSet.State = dsInsert then
  begin
    tvdata.DataController.Post;
  end;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;
end;

procedure TfrmPackages.FormKeyPress(Sender: TObject; var Key: Char);
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
function TfrmPackages.getPrevCode: string;
begin
end;

procedure TfrmPackages.m_AfterScroll(DataSet: TDataSet);
begin
//  fillItems(dataset.fieldbyname('Id').asinteger);
end;

procedure TfrmPackages.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
  fillHolder;


  // Del all packageItems first
  Del_PackageItemByPackage(zData.id);

  if hdata.PackageExistsInOther(zData.Package) then
  begin
  	Showmessage(format(GetTranslatedText('shExistsInRelatedDataCannotDelete'), ['Package', zData.Description]));
    Abort;
    exit;
  end;

  s := '';
  s := s+GetTranslatedText('shDeletePackage')+' '+zData.Description+' '+chr(10);
  s := s+GetTranslatedText('shContinue');
  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if not Del_Package(zData) then
    begin
      abort;
    end
  end else
  begin
    abort
  end;
end;

procedure TfrmPackages.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then
  begin
  end else
  begin
    tvData.GetColumnByFieldName('Package').Focused := True;
  end;
end;


procedure TfrmPackages.m_BeforePost(DataSet: TDataSet);
var
 nID : integer;
begin
  if zFirstTime then exit;
  initPackageHolder(zData);
  zData.ID       := dataset.FieldByName('ID').AsInteger;
  zData.Active              := dataset['Active'];
  zData.Description         := dataset['Description'];
  zData.Package             := dataset['Package'];
  zData.showItemsOnInvoice  := dataset['showItemsOnInvoice'];
  zData.currencyID          := dataset['CurrencyID'];
  zData.currency            := dataset['Currency'];
  zData.InvoiceText         := dataset['InvoiceText'];

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if UPD_Package(zData) then
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
    if dataset.FieldByName('Package').AsString = ''  then
    begin
	  showmessage(GetTranslatedText('shTx_Packages_PackageRequired'));
      tvData.GetColumnByFieldName('Package').Focused := True;
      abort;
      exit;
    end;
    if ins_Package(zData,nID) then
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



procedure TfrmPackages.m_CalcFields(DataSet: TDataSet);
begin
  if zFirstTime then
  begin
//
  end;
end;

procedure TfrmPackages.m_NewRecord(DataSet: TDataSet);
begin
  dataset['Active']             := true;
  dataset['Description']        := '';
  dataset['Package']            := '';
  dataset['showItemsOnInvoice'] := false;
  dataset['CurrencyID']         := getNativeCurrencyID();
  dataset['Currency']           := ctrlGetString('NativeCurrency');
  dataset['InvoiceText']        := '';
end;

procedure TfrmPackages.m_TotalPriceSetText(Sender: TField; const Text: string);
begin

end;

////////////////////////////////////////////////////////////////////////////////////////
//  table View Functions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmPackages.tvDataDescriptionPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_.fieldbyname('Description').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
   // errortext := 'Description '+' - '+'is required - Use ESC to cancel';
	  errortext := GetTranslatedText('shTx_Packages_DescriptionIsRequired');
    exit;
  end;

  if hdata.RoomrateDescriptionExist(displayValue) then
  begin
    error := true;
    //errortext := displayvalue+'Nýtt gildi er til í annari færslu. Notið ESC-hnappin til að hætta við';
    errortext := displayvalue+'  '+GetTranslatedText('shNewValueExistInAnotherRecor');
    exit
  end;
//
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




procedure TfrmPackages.tvDataPackagePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_.fieldbyname('Package').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
  //  errortext := 'Package code '+' - '+'is required - Use ESC to cancel';
	  errortext := GetTranslatedText('shTx_Packages_PackageCodeIsRequired');
    exit;
  end;

  if hdata.PackageExist(displayValue) then
  begin
    error := true;
    errortext := displayvalue+'  '+GetTranslatedText('shNewValueExistInAnotherRecor');
    exit
  end;

  if hdata.PackageExistInItems(displayValue) then
  begin
    error := true;
   // errortext := displayvalue+'  '+'exists in Items table '; 
	  errortext := displayvalue+'  '+GetTranslatedText('shTx_Packages_Exists');
    exit
  end;

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if hdata.PackageExistsInOther(currValue) then
    begin
      error := true;
      errortext := displayvalue+' - '+GetTranslatedText('shOldValueUsedInRelatedDataC');
      exit;
    end;
  end;
end;


procedure TfrmPackages.tvDataDblClick(Sender: TObject);
begin
  if ZAct = actLookup then
  begin
    btnOK.Click
  end;
end;


////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////

procedure TfrmPackages.tvDataColumn1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  getPackageItems;
end;

procedure TfrmPackages.tvDataCurrencyPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recCurrencyHolder;
begin
  fillholder;
  theData.Currency := zData.Currency;
  theData.ID := zData.CurrencyID;

  currencies(actlookup,theData);

  if theData.Currency <> '' then
  begin
    if tvData.DataController.DataSource.State <> dsInsert then m_.Edit;
    m_['currency']   := theData.Currency;
    m_['currencyID'] := theData.ID;
    m_.Post;
  end;

end;

procedure TfrmPackages.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;

procedure TfrmPackages.tvDataDataControllerSortingChanged(Sender: TObject);
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


procedure TfrmPackages.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmPackages.btnOtherClick(Sender: TObject);
begin
  //**
end;


procedure TfrmPackages.GetPackageItems;
var
  theData : recPackageItemHolder;
  sTmp    : string;
  total   : double;
begin
  if tvData.DataController.DataSource.State = dsInsert then m_.post;
  initPackageItemHolder(theData);
  sTmp := m_.FieldByName('Package').AsString;
  theData.packageId := m_.FieldByName('ID').AsInteger;
  thedata.packageDescription := m_.FieldByName('Description').AsString;
  if openPackageItems(actlookup,theData) then
  begin
    total := Packageitem_TotalByPackageID(m_.FieldByName('ID').AsInteger);
    zFirstTime := true;
    m_.Edit;
    m_.FieldByName('totalprice').asFloat := total;
    m_.post;
    zFirstTime := false;
  end;
end;


procedure TfrmPackages.btnCancelClick(Sender: TObject);
begin
  initPackageHolder(zData);
end;

procedure TfrmPackages.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmPackages.btnDeleteClick(Sender: TObject);
begin
  m_.Delete;
end;

procedure TfrmPackages.btnInsertClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  if m_.Active = false then m_.Open;
  grData.SetFocus;
  m_.Insert;
  tvData.GetColumnByFieldName('Description').Focused := True;
end;

//---------------------------------------------------------------------------
// Menu in other actions
//-----------------------------------------------------------------------------

procedure TfrmPackages.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;
  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;


procedure TfrmPackages.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;

procedure TfrmPackages.mnuiGridToExcelClick(Sender: TObject);
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

procedure TfrmPackages.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmPackages.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmPackages.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

function GetPackagetPrice(package, currency : String) : Double;
var rSet : TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  if rSet_bySQL(rSet, format('SELECT SUM(TotalPrice) / (SELECT AValue FROM currencies WHERE Currency=%s LIMIT 1) AS TotalPrice FROM (SELECT pi.numItems AS NumItems, ' +
                             'pi.unitPrice * (SELECT AValue FROM currencies WHERE Currency = ctrl.NativeCurrency) / cu.AValue AS UnitPrice, ' +
                             '(pi.unitPrice * (SELECT AValue FROM currencies WHERE Currency = ctrl.NativeCurrency) / cu.AValue) * pi.numItems AS TotalPrice, ' +
                             'p.* ' +
                             'FROM packages p ' +
                             'INNER JOIN currencies cu ON cu.id=p.currencyId ' +
                             'INNER JOIN packageitems pi ON pi.packageId=p.id, ' +
                             '(SELECT NativeCurrency FROM control LIMIT 1) ctrl ' +
                             'WHERE p.Package=''%s'') AAA', [currency, package])) then
    result := rSet['TotalPrice']
  else
    result := 0;
end;

end.

