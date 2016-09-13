unit uPackageItems;

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
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxButtonEdit, cxSpinEdit, cxCalc, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter,
  cxPropertiesStore, dxmdaset, sGroupBox, cxDropDownEdit, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld

  ;

type
  TfrmPackageItems = class(TForm)
    sPanel1: TsPanel;
    btnClose: TsButton;
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
    panBtn: TsPanel;
    btnCancel: TsButton;
    BtnOk: TsButton;
    DS: TDataSource;
    Label1: TsLabel;
    grPrinter: TdxComponentPrinter;
    prLink_grData: TdxGridReportLink;
    m_: TdxMemData;
    grData: TcxGrid;
    tvData: TcxGridDBTableView;
    lvData: TcxGridLevel;
    tvDataRecId: TcxGridDBColumn;
    m_id: TIntegerField;
    m_description: TWideStringField;
    m_unitPrice: TFloatField;
    m_packageId: TIntegerField;
    m_itemId: TIntegerField;
    m_Item: TWideStringField;
    m_itemPrice: TFloatField;
    m_itemDescription: TWideStringField;
    tvDataid: TcxGridDBColumn;
    tvDatadescription: TcxGridDBColumn;
    tvDataunitPrice: TcxGridDBColumn;
    tvDatapackageId: TcxGridDBColumn;
    tvDataitemId: TcxGridDBColumn;
    tvDataItem: TcxGridDBColumn;
    tvDataitemDescription: TcxGridDBColumn;
    tvDataitemPrice: TcxGridDBColumn;
    m_numItems: TIntegerField;
    tvDatanumItems: TcxGridDBColumn;
    m_TotalPrice: TFloatField;
    tvDataTotalPrice: TcxGridDBColumn;
    sGroupBox1: TsGroupBox;
    sLabel1: TsLabel;
    labPackageName: TsLabel;
    FormStore: TcxPropertiesStore;
    m_numItemsMethod: TIntegerField;
    m_numItemsMethodStr: TStringField;
    tvDatanumItemsMethod: TcxGridDBColumn;
    tvDatanumItemsMethodStr: TcxGridDBColumn;
    btnInsert: TsButton;
    btnEdit: TsButton;
    btnDelete: TsButton;
    btnOther: TsButton;
    btnClear: TsSpeedButton;
    m_IncludedInRate: TBooleanField;
    tvDataIncludedInRate: TcxGridDBColumn;
    m_valueFormula: TWideStringField;
    tvDatavalueFormula: TcxGridDBColumn;
    m_unitPriceVatFormula: TWideStringField;
    tvDataunitPriceVatFormula: TcxGridDBColumn;
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
    procedure btnCloseClick(Sender: TObject);
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
    procedure btnInsertClick(Sender: TObject);
    procedure m_CalcFields(DataSet: TDataSet);
    procedure tvDataItemPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvDataItemPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure tvDataEditDblClick(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit);
    procedure sButton1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tvDatanumItemsMethodStrPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
  private
    { Private declarations }
    zFirstTime       : boolean;
    zAllowGridEdit   : boolean;
    zSortStr         : string;
    zIsAddRow        : boolean;

    numItemsMethodLst : TstringList;

    Procedure fillGridFromDataset(sGoto : string);
    procedure fillHolder;
    procedure changeAllowgridEdit;
    Procedure chkFilter;
    procedure applyFilter;


  public
    { Public declarations }
    zPackageID  : integer;
    zAct   : TActTableAction;
    zData  : recPackageItemHolder;
  end;

function openPackageItems(act : TActTableAction; var theData : recPackageItemHolder) : boolean;

var
  frmPackageItems: TfrmPackageItems;

implementation

{$R *.dfm}

uses
    uD
  , prjConst
  , uSqlDefinitions
  , uVatCodes
  , uItems2
  , uDImages;


//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function openPackageItems(act : TActTableAction; var theData : recPackageItemHolder) : boolean;
begin
  result := false;
  frmPackageItems := TfrmPackageItems.Create(frmPackageItems);
  try
    frmPackageItems.zData := theData;
    frmPackageItems.zAct := act;
    frmPackageItems.zPackageID := theData.PackageID;
    frmPackageItems.labPackageName.Caption := theData.packageDescription;
    frmPackageItems.ShowModal;
    if frmPackageItems.modalresult = mrOk then
    begin
      theData := frmPackageItems.zData;
      result := true;
    end
    else
    begin
      initPackageItemHolder(theData);
    end;
  finally
    freeandnil(frmPackageItems);
  end;
end;


///////////////////////////////////////////////////////////////////////
                    { Private declarations }
///////////////////////////////////////////////////////////////////////


Procedure TfrmPackageItems.fillGridFromDataset(sGoto : string);
var
  s    : string;
  rSet : TRoomerDataSet;
begin
  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'Item';
  rSet := CreateNewDataSet;
  try
    s := format(select_PackageItems_byPackageID, [zPackageID]);
    if rSet_bySQL(rSet,s) then
    begin
      if not m_.active then m_.open;
//      m_.LoadFromDataSet(rSet);
      rSet.First;
      while not rSet.Eof do
      begin
        m_.insert;
        m_.FieldByName('ID').AsInteger := rSet.FieldByName('ID').AsInteger;
        m_.FieldByName('description').AsString  := rSet.FieldByName('description').AsString ;
        m_.FieldByName('numItems').AsInteger := rSet.FieldByName('numItems').AsInteger;
        m_.FieldByName('unitPrice').AsFloat   := rSet.GetFloatValue(rSet.FieldByName('unitPrice'))  ;
        m_.FieldByName('packageId').AsInteger := rSet.FieldByName('packageId').AsInteger;
        m_.FieldByName('itemId').AsInteger := rSet.FieldByName('itemId').AsInteger;
        m_.FieldByName('Item').AsString  := rSet.FieldByName('Item').AsString ;
        m_.FieldByName('itemDescription').AsString  := rSet.FieldByName('itemDescription').AsString ;
        m_.FieldByName('itemPrice').AsFloat         := rSet.GetFloatValue(rSet.FieldByName('itemPrice'))  ;
        m_.FieldByName('numItemsMethod').AsInteger  := rSet.FieldByName('numItemsMethod').asinteger  ;
        m_.FieldByName('numItemsMethodStr').AsString  := numItemsMethodLst[m_.FieldByName('numItemsMethod').AsInteger];
        m_.FieldByName('IncludedInRate').AsBoolean  := rSet.FieldByName('IncludedInRate').asBoolean ;
        m_.FieldByName('valueFormula').AsString  := rSet.FieldByName('valueFormula').asString ;
        m_.FieldByName('unitPriceVatFormula').AsString  := rSet.FieldByName('unitPriceVatFormula').asString ;

        m_.Post;
        rSet.Next;
      end;

      if sGoto = '' then
      begin
        m_.First;
      end else
      begin
        try
          m_.Locate('Item',sGoto,[]);
        except
        end;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;


procedure TfrmPackageItems.fillHolder;
begin
  initPackageItemHolder(zData);
  zData.ID                := m_.FieldByName('ID').AsInteger;
  zData.description       := m_['description'];
  zData.numItems          := m_['numItems'];
  zData.unitPrice         := m_['unitPrice'];
  zData.packageId         := m_['packageId'];
  zData.itemId            := m_['itemId'];
  zData.Item              := m_['Item'];
  zData.itemDescription   := m_['itemDescription'];
  zData.itemPrice         := m_['itemPrice'];
  zData.numItemsMethod    := m_['numItemsMethod'];
  zData.IncludedInRate    := m_['IncludedInRate'];
  zData.valueFormula      := m_['valueFormula'];
  zData.unitPriceVatFormula := m_['unitPriceVatFormula'] ;

end;

procedure TfrmPackageItems.changeAllowgridEdit;
begin
   tvDataID             .Options.Editing := false;
   tvDatadescription    .Options.Editing := zAllowGridEdit;
   tvDatanumItems       .Options.Editing := zAllowGridEdit;
   tvDataunitPrice      .Options.Editing := zAllowGridEdit;
   tvDatapackageId      .Options.Editing := zAllowGridEdit;
   tvDataitemId         .Options.Editing := zAllowGridEdit;
   tvDataItem           .Options.Editing := zAllowGridEdit;
   tvDataitemDescription.Options.Editing := zAllowGridEdit;
   tvDataitemPrice      .Options.Editing := zAllowGridEdit;
   tvDataIncludedInRate .Options.Editing := zAllowGridEdit;
   tvDatavalueFormula   .Options.Editing := zAllowGridEdit;
   tvDataunitPriceVatFormula.Options.Editing := zAllowGridEdit;
end;


procedure TfrmPackageItems.chkFilter;
begin
end;


procedure TfrmPackageItems.edFilterChange(Sender: TObject);
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

procedure TfrmPackageItems.applyFilter;
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

procedure TfrmPackageItems.FormCreate(Sender: TObject);
var
  i : integer;
begin
  RoomerLanguage.TranslateThisForm(self);
  //**
  zFirstTime  := true;
  zAct        := actNone;
  zisAddrow   := false;
  numItemsMethodLst := TstringList.Create;
  numItemsMethodLst.Add('As entered');
  numItemsMethodLst.Add('Room nights');
  numItemsMethodLst.Add('Guest nights');
  numItemsMethodLst.Add('Guests');

   with TcxComboboxProperties(tvData.GetColumnByFieldName('numItemsMethodStr').Properties) do
   begin
     Items.clear;
     for i := 0 to numItemsMethodLst.Count-1 do
     begin
       Items.Add(numItemsMethodLst[i]);
     end;
   end;



end;

procedure TfrmPackageItems.FormDestroy(Sender: TObject);
begin
  glb.EnableOrDisableTableRefresh('packageitems', True);
  freeandNil(numItemsMethodLst);
end;

procedure TfrmPackageItems.FormShow(Sender: TObject);
begin
//**
  glb.EnableOrDisableTableRefresh('packageitems', False);
  panBtn.Visible := False;
  sbMain.Visible := false;
  btnClose.Visible := False;

  fillGridFromDataset(zData.Item);
  zFirstTime := true;
  sbMain.SimpleText := zSortStr;

  if ZAct = actLookup then
  begin
    mnuiAllowGridEdit.Checked := true;
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

procedure TfrmPackageItems.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TfrmPackageItems.FormKeyPress(Sender: TObject; var Key: Char);
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
procedure TfrmPackageItems.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
    fillHolder;
//  if hdata.PackageItemExistsInOther(zData.PackageItem) then
//  begin
//    Showmessage('PackageItem'+' ' + zData.Description + ' '+GetTranslatedText('shExistsInRelatedData')+' ' + chr(10) + GetTranslatedText('shCanNotDelete')+' ');
//    Abort;
//    exit;
//  end;
//
  s := '';
  s := s+GetTranslatedText('shDeletePackage')+' '+zData.Description+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if not Del_PackageItem(zData) then
    begin
      abort;
    end
  end else
  begin
    abort
  end;
end;

procedure TfrmPackageItems.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  grData.SetFocus;
  tvData.GetColumnByFieldName('Item').Focused := True;
end;


procedure TfrmPackageItems.m_BeforePost(DataSet: TDataSet);
var
  nID : integer;
begin
  if zFirstTime then exit;
  nID := 0;

  initPackageItemHolder(zData);
  zData.ID                    := dataset.FieldByName('ID').AsInteger;
  zData.description           := dataset['description'];
  zData.numItems              := dataset['numItems'];
  zData.unitPrice             := dataset['unitPrice'];
  zData.packageId             := dataset['packageId'];
  zData.itemId                := dataset['itemId'];
  zData.Item                  := dataset['Item'];
  zData.itemDescription       := dataset['itemDescription'];
  zData.itemPrice             := dataset['itemPrice'];
  zData.numItemsMethod        := dataset['numItemsMethod'];
  zData.IncludedInRate        := dataset['IncludedInRate'];
  zData.valueFormula          := dataset['valueFormula'];
  zData.unitPriceVatFormula := dataset['unitPriceVatFormula'];


  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if UPD_PackageItem(zData) then
    begin
       glb.ForceTableRefresh;
    end else
    begin
    //  label1.Caption := 'UPDATE NOT OK';
	  label1.Caption := GetTranslatedText('shTx_PackagedItems_UpdateNotOK');
      abort;
      exit;
    end;
  end;
  if tvData.DataController.DataSource.State = dsInsert then
  begin
    if dataset.FieldByName('Description').AsString = ''  then
    begin
    //  showmessage('Description is requierd - set value or use [ESC] to cancel ');
	  showmessage(GetTranslatedText('shTx_PackagedItems_DescriptionRequired'));
      tvData.GetColumnByFieldName('Descripton').Focused := True;
      abort;
      exit;
    end;
    if dataset.FieldByName('Item').AsString = ''  then
    begin
    // showmessage('Item is requierd - set value or use [ESC] to cancel ');
	  showmessage(GetTranslatedText('shTx_PackagedItems_ItemRequired'));
      tvData.GetColumnByFieldName('Item').Focused := True;
      abort;
      exit;
    end;
    if ins_PackageItem(zData,nID) then
    begin
      m_.fieldByname('iD').AsInteger := nID;
    end else
    begin
      abort;
      exit;
    end;
  end;
end;



procedure TfrmPackageItems.m_CalcFields(DataSet: TDataSet);
var
  units : integer;
  price : double;
begin
  units := dataset.FieldByName('numItems').AsInteger;
  price := dataset.FieldByName('unitPrice').AsFloat;
  dataset.fieldbyname('totalPrice').asfloat := units*price;
end;

procedure TfrmPackageItems.m_NewRecord(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  dataset['description']  := '' ;
  dataset['numItems']  := 0  ;
  dataset['unitPrice']  := 0  ;
  dataset['packageId']  := zPackageID;
  dataset['itemId']  := 0  ;
  dataset['Item']  := '' ;
  dataset['itemDescription']  := '' ;
  dataset['itemPrice']  := 0  ;
  dataset['numItemsMethod']  := 0  ;
  dataset['IncludedInRate']  := false  ;
  dataset['valueFormula'] := '';
  dataset['unitPriceVatFormula'] := '';
end;

procedure TfrmPackageItems.sButton1Click(Sender: TObject);
begin

end;



////////////////////////////////////////////////////////////////////////////////////////
//  table View Functions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmPackageItems.tvDataDescriptionPropertiesValidate(Sender: TObject;
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
	errortext := GetTranslatedText('shTx_PackagedItems_DescriptionIsRequired');
    exit;
  end;

//  if hdata.PackageItemsPackageItemExist(displayValue) then
//  begin
//    error := true;
//    //errortext := displayvalue+'Nýtt gildi er til í annari færslu. Notið ESC-hnappin til að hætta við';
//    errortext := displayvalue+'  '+GetTranslatedText('shNewValueExistInAnotherRecor');
//    exit
//  end;
//
//  if tvData.DataController.DataSource.State = dsEdit then
//  begin
//    if hdata.payTypeExistsInOther(currValue) then
//    begin
//      error := true;
//      errortext := displayvalue+' - '+GetTranslatedText('shOldValueUsedInRelatedDataC');
//      exit;
//    end;
//  end;
end;

procedure TfrmPackageItems.tvDataEditDblClick(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit);
begin
  if ZAct = actLookup then
  begin
    btnOK.Click
  end;
end;

procedure TfrmPackageItems.tvDataFocusedRecordChanged(
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



procedure TfrmPackageItems.tvDataItemPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recItemHolder;
begin
  fillholder;
  theData.Item := zData.Item;

  openItems(actlookup,true, theData);

  if theData.item <> '' then
  begin
    if tvData.DataController.DataSource.State <> dsInsert then m_.Edit;
    m_['ItemId']   := theData.ID;
    m_['Item']   := theData.item;
    m_['Description'] := theData.Description;
    m_['unitPrice'] := theData.Price;
    if tvData.DataController.DataSource.State = dsInsert then m_['numItems'] := 1;
    m_.Post;
  end;

end;

procedure TfrmPackageItems.tvDataItemPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  currValue : string;
begin
  currValue := m_.fieldbyname('Item').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
   // errortext := 'Item '+' - '+'is required - Use ESC to cancel';
	  errortext := GetTranslatedText('shTx_PackagedItems_ItemIsRequired');
    exit;
  end;
end;

procedure TfrmPackageItems.tvDatanumItemsMethodStrPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  idx : integer;
begin
  idx := numItemsMethodlst.IndexOf(DisplayValue);
  m_.edit;
  m_.fieldbyname('numItemsMethod').AsInteger := idx;
  m_.post;
end;


procedure TfrmPackageItems.tvDataDblClick(Sender: TObject);
begin

  if ZAct = actLookup then
  begin
    btnOK.Click
  end;
end;


////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////



procedure TfrmPackageItems.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;


procedure TfrmPackageItems.tvDataDataControllerSortingChanged(Sender: TObject);
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


procedure TfrmPackageItems.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmPackageItems.btnOtherClick(Sender: TObject);
begin
  //**
end;

procedure TfrmPackageItems.btnCancelClick(Sender: TObject);
begin
  //initPackageItemHolder(zData);
end;

procedure TfrmPackageItems.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmPackageItems.btnCloseClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmPackageItems.btnDeleteClick(Sender: TObject);
begin
  m_.Delete;
end;

procedure TfrmPackageItems.btnInsertClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  if m_.Active = false then m_.Open;
  m_.Insert;
  tvData.GetColumnByFieldName('Description').Focused := True;
end;

//---------------------------------------------------------------------------
// Menu in other actions
//-----------------------------------------------------------------------------

procedure TfrmPackageItems.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;
  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;


procedure TfrmPackageItems.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;

procedure TfrmPackageItems.mnuiGridToExcelClick(Sender: TObject);
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

procedure TfrmPackageItems.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmPackageItems.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmPackageItems.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

end.

