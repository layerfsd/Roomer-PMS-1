unit uItems2;

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
  , Hdata
  , ug
  , uD
  , uFrmKeyPairSelector
  , RoomerCloudEntities

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
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCalc, cxButtonEdit, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter, cxPropertiesStore, dxmdaset,
  dxPScxPivotGridLnk, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, sCheckBox, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinDarkRoom, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, cxDropDownEdit

  ;

type
  TfrmItems2 = class(TForm)
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
    m_Iyem: TWideStringField;
    m_MinibarItem: TBooleanField;
    m_Description: TWideStringField;
    m_Price: TFloatField;
    m_Itemtype: TWideStringField;
    m_AccountKey: TWideStringField;
    m_Hide: TBooleanField;
    m_SystemItem: TBooleanField;
    m_RoomRentitem: TBooleanField;
    m_ReservationItem: TBooleanField;
    m_Currency: TWideStringField;
    tvDataItem: TcxGridDBColumn;
    tvDataDescription: TcxGridDBColumn;
    tvDataPrice: TcxGridDBColumn;
    tvDataItemtype: TcxGridDBColumn;
    tvDataAccountKey: TcxGridDBColumn;
    tvDataMinibarItem: TcxGridDBColumn;
    tvDataSystemItem: TcxGridDBColumn;
    tvDataRoomRentitem: TcxGridDBColumn;
    tvDataReservationItem: TcxGridDBColumn;
    tvDataCurrency: TcxGridDBColumn;
    tvDataHide: TcxGridDBColumn;
    btnInsert: TsButton;
    btnEdit: TsButton;
    FormStore: TcxPropertiesStore;
    btnTaxLinks: TsButton;
    chkActive: TsCheckBox;
    m_BreakfastItem: TBooleanField;
    m_BookKeepCode: TWideStringField;
    tvDataBookKeepCode: TcxGridDBColumn;
    timFilter: TTimer;
    m_NumberBase: TWideStringField;
    tvDataNumberBase: TcxGridDBColumn;
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
    procedure btnEditClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure edFilterChange(Sender: TObject);
    procedure tvDataItemtypePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvDataItemPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnInsertClick(Sender: TObject);
    procedure tvDataAccountKeyPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnTaxLinksClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
    procedure tvDataBookKeepCodePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure m_FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure timFilterTimer(Sender: TObject);
  private
    { Private declarations }
    financeLookupList : TKeyPairList;
    zFirstTime       : boolean;
    zAllowGridEdit   : boolean;
    zFilterOn        : boolean;

    Lookup : Boolean;
    zSortStr         : string;

    Procedure fillGridFromDataset(sGoto : string);
    procedure fillHolder;
    procedure changeAllowgridEdit;
    Procedure chkFilter;
    procedure applyFilter;
    function AssertCorrectness : Boolean;
    procedure GetSelectedItems(theData: TList<TrecItemHolder>);
    function NumItemsSelected: Integer;
    procedure StopFilter;

  public
    { Public declarations }
    zAct   : TActTableAction;
    zData  : recItemHolder;
  end;

function openItems(act : TActTableAction; Lookup : Boolean; var theData : recItemHolder) : boolean;
function openMultipleItems(act : TActTableAction; Lookup : Boolean; theData : TList<TrecItemHolder>) : boolean;

var
  frmItems2: TfrmItems2;

implementation

{$R *.dfm}

uses
  prjConst
  , uSqlDefinitions
  , uItemTypes2
  , uMessageList
  , uAppGlobal
  , uDimages
  , uFrmTaxItemLink
  , uBookKeepingCodes
  ;


//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function openItems(act : TActTableAction; Lookup : Boolean; var theData : recItemHolder) : boolean;
var _frmItems2 : TfrmItems2;
begin
  result := false;
  _frmItems2 := TfrmItems2.Create(nil);
  try
    _frmItems2.zData := theData;
    _frmItems2.Lookup := Lookup;
    _frmItems2.zAct := act;
    _frmItems2.ShowModal;
    if _frmItems2.modalresult = mrOk then
    begin
      theData := _frmItems2.zData;
      result := true;
    end
    else
    begin
      initItemHolder(theData);
    end;
  finally
    freeandnil(_frmItems2);
    glb.Items.Filtered := False;
  end;
end;

function openMultipleItems(act : TActTableAction; Lookup : Boolean; theData : TList<TrecItemHolder>) : boolean;
var _frmItems2 : TfrmItems2;
begin
  result := false;
  _frmItems2 := TfrmItems2.Create(nil);
  try
    if theData.Count > 0  then
      _frmItems2.zData := theData[0].recHolder;
    _frmItems2.Lookup := Lookup;
    _frmItems2.zAct := act;
    _frmItems2.ShowModal;
    if _frmItems2.modalresult = mrOk then
    begin
      _frmItems2.GetSelectedItems(theData);
      result := true;
    end
    else
    begin
      theData.Clear;
    end;
  finally
    freeandnil(_frmItems2);
    glb.Items.Filtered := False;
  end;
end;


///////////////////////////////////////////////////////////////////////
                    { Private declarations }
///////////////////////////////////////////////////////////////////////

function TfrmItems2.NumItemsSelected : Integer;
begin
  result := tvData.Controller.SelectedRecordCount-1;
end;

procedure TfrmItems2.GetSelectedItems(theData : TList<TrecItemHolder>);
var item : TrecItemHolder;
    i : Integer;
    RecID : Integer;
begin
  theData.Clear;
  if NumItemsSelected > 0 then
  begin
    m_.DisableControls;
    try
      for i:= 0 To tvData.Controller.SelectedRecordCount-1 Do
      begin
        m_.RecNo := tvData.Controller.SelectedRecords[I].Index +  1;
          item := TrecItemHolder.Create;
          with item do
          begin
            recHolder.ID                    := m_.FieldByName('ID').AsInteger;
            recHolder.Active                := m_['Active'];
            recHolder.Description           := m_['Description'];
            recHolder.Item                  := m_['Item'];
            recHolder.Price                 := m_['Price'];
            recHolder.Itemtype              := m_['Itemtype'];
            recHolder.AccountKey            := m_['AccountKey'];
            recHolder.MinibarItem           := m_['MinibarItem'];
            recHolder.SystemItem            := m_['SystemItem'];
            recHolder.RoomRentitem          := m_['RoomRentitem'];
            recHolder.ReservationItem       := m_['ReservationItem'];
            recHolder.Hide                  := m_['Hide'];
            recHolder.Currency              := m_['Currency'];
            recHolder.BookKeepCode          := m_['BookKeepCode'];
            recHolder.NumberBase            := m_['NumberBase'];

            theData.Add(item);
          end;
      end;
    finally
       m_.EnableControls;
    end;
    m_.First;
  end else
  begin
    item := TrecItemHolder.Create;
    item.recHolder := zData;
    theData.Add(item);
  end;
end;

Procedure TfrmItems2.fillGridFromDataset(sGoto : string);
var
  s    : string;
  rSet : TRoomerDataSet;
  active : boolean;
begin
  zFirstTime := true;
  active := chkActive.Checked;
  if zSortStr = '' then zSortStr := 'Item';
  rSet := glb.Items;
  rSet.Sort := 'Item';
  if active then
  begin
    rSet.Filter := 'active=1';
    rSet.Filtered := True;
  end else
  begin
    rSet.Filter := 'active=0';
    rSet.Filtered := True;
  end;
  try
    rSet.First;
    if NOT rSet.Eof then
    begin
      if m_.active then m_.Close;
      m_.LoadFromDataSet(rSet);
      if sGoto = '' then
      begin
        m_.First;
      end else
      begin
        try
          m_.Locate('item',sGoto,[]);
        except
        end;
      end;
    end;
  finally
    rSet.Filter := '';
    rSet.Filtered := False;
  end;
end;

procedure TfrmItems2.fillHolder;
begin
  initItemHolder(zData);
  zData.ID                    := m_.FieldByName('ID').AsInteger;
  zData.Active                := m_['Active'];
  zData.Description           := m_['Description'];
  zData.Item                  := m_['Item'];
  zData.Price                 := m_['Price'];
  zData.Itemtype              := m_['Itemtype'];
  zData.AccountKey            := m_['AccountKey'];
  zData.MinibarItem           := m_['MinibarItem'];
  zData.SystemItem            := m_['SystemItem'];
  zData.RoomRentitem          := m_['RoomRentitem'];
  zData.ReservationItem       := m_['ReservationItem'];
  zData.Hide                  := m_['Hide'];
  zData.Currency              := m_['Currency'];
  zData.BookKeepCode          := m_['BookKeepCode'];
  zData.NumberBase            := m_['NumberBase'];
end;


//    ID              : integer ;
//    Active          : boolean ;
//    Description     : string  ;
//    Item            : string  ;
//    Price           : double  ;
//    Itemtype        : string  ;
//    AccountKey      : string  ;
//    MinibarItem     : boolean ;
//    SystemItem      : boolean ;
//    RoomRentitem    : boolean ;
//    ReservationItem : boolean ;
//    Hide            :boolean  ;
//    Currency        :string   ;


procedure TfrmItems2.changeAllowgridEdit;
begin
  tvDataID.Options.Editing              := false;
  tvDataActive.Options.Editing          := zAllowGridEdit;
  tvDataDescription.Options.Editing     := zAllowGridEdit;
  tvDataItem.Options.Editing            := zAllowGridEdit;
  tvDataPrice.Options.Editing           := zAllowGridEdit;
  tvDataItemtype.Options.Editing        := zAllowGridEdit;
  tvDataAccountKey.Options.Editing      := zAllowGridEdit;
  tvDataMinibarItem.Options.Editing     := zAllowGridEdit;
  tvDataSystemItem.Options.Editing      := zAllowGridEdit;
  tvDataRoomRentitem.Options.Editing    := zAllowGridEdit;
  tvDataReservationItem.Options.Editing := zAllowGridEdit;
  tvDataHide.Options.Editing            := zAllowGridEdit;
  tvDataCurrency.Options.Editing        := zAllowGridEdit;
  tvDataBookKeepCode.Options.Editing    := zAllowGridEdit;
  tvDataNumberBase.Options.Editing    := zAllowGridEdit;
end;


procedure TfrmItems2.chkActiveClick(Sender: TObject);
begin
  zFirstTime := false;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;
  fillGridFromDataset(zData.item);
  zFirstTime := false;
end;

procedure TfrmItems2.chkFilter;
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

procedure TfrmItems2.StopFilter;
begin
  if tvData.DataController.Filter.AutoDataSetFilter then
  begin
    timFilter.Enabled := False;
    m_.filtered := False;
    tvData.DataController.Filter.Active := False;
    tvData.DataController.Filter.Changed;
  end else
  begin
    tvData.DataController.Filter.Root.Clear;
    tvData.DataController.Filter.Active := false;
    grData.Invalidate(true);
  end;
end;

procedure TfrmItems2.edFilterChange(Sender: TObject);
begin
  if edFilter.Text = '' then
  begin
    StopFilter;
  end else
  begin
    applyFilter;
  end;
end;

procedure TfrmItems2.applyFilter;
var i : Integer;
    filter : String;

    procedure RestartTimer;
    begin
      timFilter.Enabled := False;
      timFilter.Interval := 500;
      timFilter.Interval := 30;
      timFilter.Enabled := True;
    end;
begin
  if tvData.DataController.Filter.AutoDataSetFilter then
  begin
    m_.filtered := False;
    RestartTimer;
  end else
  begin
    tvData.DataController.Filter.Options := [fcoCaseInsensitive];
    tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
    tvData.DataController.Filter.Root.Clear;
    for i := 0 to tvData.ColumnCount - 1 do
      if tvData.Columns[i].DataBinding.ValueType = 'String' then
        tvData.DataController.Filter.Root.AddItem(tvData.Columns[i], foLike, '%'+edFilter.Text+'%', '%'+edFilter.Text+'%');
    tvData.DataController.Filter.Active := True;
  end;
//begin
//  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
//  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
//  tvData.DataController.Filter.Root.Clear;
//  tvData.DataController.Filter.Root.AddItem(tvDataItem,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
//  tvData.DataController.Filter.Root.AddItem(tvDataDescription,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
//  tvData.DataController.Filter.Active := True;
end;


/////////////////////////////////////////////////////////////
// Form actions
/////////////////////////////////////////////////////////////

procedure TfrmItems2.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  Lookup := False;
  financeLookupList := nil;
  //**
  zFirstTime  := true;
  zAct        := actNone;
  //sButton1.Visible := True;
end;

procedure TfrmItems2.FormDestroy(Sender: TObject);
begin
  glb.EnableOrDisableTableRefresh('items', True);
end;

procedure TfrmItems2.FormShow(Sender: TObject);
begin
  glb.EnableOrDisableTableRefresh('items', False);
//**
  panBtn.Visible := False;
  sbMain.Visible := false;

  fillGridFromDataset(zData.item);
  zFirstTime := true;
  sbMain.SimpleText := zSortStr;

  if ZAct = actLookup then
  begin
    mnuiAllowGridEdit.Checked := False;
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

  tvData.DataController.DataModeController.GridMode := (ZAct = actLookup);
  tvData.DataController.Filter.AutoDataSetFilter := tvData.DataController.DataModeController.GridMode;
  tvData.DataController.MultiSelect := true;
end;

procedure TfrmItems2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  glb.EnableOrDisableTableRefresh('items', True);
  if tvdata.DataController.DataSet.State = dsInsert then
  begin
    tvdata.DataController.Post;
  end;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;
end;

procedure TfrmItems2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := AssertCorrectness;
end;

procedure TfrmItems2.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmItems2.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
  fillHolder;
  if hdata.itemExistsInOther(zData.item) then
  begin
    Showmessage(format(GetTranslatedText('shExistsInRelatedDataCannotDelete'), ['Item', zData.Description]));
    Abort;
    exit;
  end;

  s := '';
  s := s+GetTranslatedText('shDeleteItem')+' '+zData.Description+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if not Del_Item(zData) then
    begin
      abort;
    end
  end else
  begin
    abort
  end;
end;

procedure TfrmItems2.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('Item').Focused := True;
end;


procedure TfrmItems2.m_BeforePost(DataSet: TDataSet);
var
 nID : integer;
 oldCode : String;
begin
  if zFirstTime then exit;
  initItemHolder(zData);
  zData.ID       := dataset.FieldByName('ID').AsInteger;
  zData.Active              := dataset['Active'];
  zData.Description         := dataset['Description'];
  zData.Item                := dataset['Item'];
  zData.Price               := dataset['Price'];
  zData.Itemtype            := dataset['Itemtype'];
  zData.AccountKey          := dataset['AccountKey'];
  zData.MinibarItem         := dataset['MinibarItem'];
  zData.SystemItem          := dataset['SystemItem'];
  zData.RoomRentitem        := dataset['RoomRentitem'];
  zData.ReservationItem     := dataset['ReservationItem'];
  zData.Hide                := dataset['Hide'];
  zData.Currency            := dataset['Currency'];
  zData.BookKeepCode        := dataset['BookKeepCode'];
  zData.NumberBase          := dataset['NumberBase'];

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    oldCode := dataSet.FieldByName('Item').OldValue;
    if oldCode <> zData.Item then
      SetForeignKeyCheckValue(0);
    try
    if UPD_Item(zData) then
    begin
      if oldCode <> zData.Item then
        UpdateItemCode(oldCode, zData.Item);
       glb.ForceTableRefresh;
    end else
    begin
      abort;
      exit;
    end;
    finally
      if oldCode <> zData.Item then
        SetForeignKeyCheckValue(1);
    end;
  end;
  if tvData.DataController.DataSource.State = dsInsert then
  begin
    if dataset.FieldByName('itemType').AsString = ''  then
    begin
    //  showmessage('Item type is requierd - set value or use [ESC] to cancel ');
	    showmessage(GetTranslatedText('shTx_Items2_ItemTypeRequired'));
      tvData.GetColumnByFieldName('ItemType').Focused := True;
      abort;
      exit;
    end;
    if dataset.FieldByName('Item').AsString = ''  then
    begin
    //  showmessage('Item is requierd - set value or use [ESC] to cancel ');
	    showmessage(GetTranslatedText('shTx_Items2_ItemRequired'));
      tvData.GetColumnByFieldName('Item').Focused := True;
      abort;
      exit;
    end;
    if ins_Item(zData,nID) then
    begin
      m_.FieldByName('ID').AsInteger := nID;
      glb.ForceTableRefresh;
    end else
    begin
      abort;
      exit;
    end;
  end;
  RoomerMessages.RefreshLists;
  glb.RefreshTablesWhenNeeded;
end;



procedure TfrmItems2.m_FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  if tvData.DataController.Filter.AutoDataSetFilter AND (edFilter.Text <> '') then
    Accept := pos(Lowercase(edFilter.Text), LowerCase(dataset['Description'])) > 0;
end;

procedure TfrmItems2.m_NewRecord(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  dataset['Active']          := true;
  dataset['Description']     := '';
  dataset['Item']            := '';
  dataset['Price']           := 0;
  dataset['Itemtype']        := '';
  dataset['AccountKey']      := '';
  dataset['MinibarItem']     := false ;
  dataset['SystemItem']      := false ;
  dataset['RoomRentitem']    := false ;
  dataset['ReservationItem'] := false ;
  dataset['Hide']            := false ;
  dataset['Currency']        := ctrlGetString('NativeCurrency'); // nvarchar(5); //
  dataset['BookKeepCode']    := ''; // nvarchar(5); //
  dataset['NumberBase']      := 'USER_EDIT'; // nvarchar(5); //
end;

procedure TfrmItems2.btnTaxLinksClick(Sender: TObject);
begin
  LinkTables('items', 'item,Description', 'ID',
                     'home100.TAXES', 'Description,Tax_Type,Amount,Tax_Base', 'ID',
                     'home100.ITEM_TAXES', 'ITEM_ID', 'TAX_ID');
end;

////////////////////////////////////////////////////////////////////////////////////////
//  table View Functions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmItems2.tvDataDescriptionPropertiesValidate(Sender: TObject;
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
	errortext := GetTranslatedText('shTx_Items2_DescriptionIsRequired');
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

procedure TfrmItems2.tvDataItemPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_.fieldbyname('Item').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
   // errortext := 'Item code '+' - '+'is required - Use ESC to cancel';
	  errortext := GetTranslatedText('shTx_Items2_ItemCodeIsRequired');
    exit;
  end;

  if hdata.itemExist(displayValue) then
  begin
    error := true;
    errortext := displayvalue+'  '+GetTranslatedText('shNewValueExistInAnotherRecor');
    exit
  end;

//  if tvData.DataController.DataSource.State = dsEdit then
//  begin
//    if hdata.itemExistsInOther(currValue) then
//    begin
//      error := true;
//      errortext := displayvalue+' - '+GetTranslatedText('shOldValueUsedInRelatedDataC');
//      exit;
//    end;
//  end;
end;

procedure TfrmItems2.tvDataItemtypePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recItemTypeHolder;
begin
  fillholder;
  theData.Itemtype := zData.Itemtype;
  openItemTypes(actlookup,theData);

  if theData.Itemtype <> '' then
  begin
    if tvData.DataController.DataSource.State <> dsInsert then m_.Edit;
    m_['ItemType'] := theData.itemType;
  end;
end;

procedure TfrmItems2.tvDataDblClick(Sender: TObject);
begin
  if ZAct = actLookup then
  begin
    btnOK.Click
  end;
end;


////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////

procedure TfrmItems2.timFilterTimer(Sender: TObject);
begin
  timFilter.Enabled := False;
  m_.filtered := True;
  tvData.DataController.Filter.Refresh;
end;

procedure TfrmItems2.tvDataAccountKeyPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  AccountKeyValue : string;
  keyValue : TKeyAndValue;
begin
  if NOT assigned(financeLookupList) then
    financeLookupList := d.RetrieveFinancesKeypair(FKP_PRODUCTS);

  AccountKeyValue := m_.FieldByName('AccountKey').asString;
  keyValue := selectFromKeyValuePairs('Products', AccountKeyValue, financeLookupList);
  if Assigned(keyValue) then
  begin
    m_.Edit;
    m_.fieldbyname('AccountKey').AsString := keyValue.Key;
    m_.Post;
  end else
  begin
    //NotOK
  end;
end;

procedure TfrmItems2.tvDataBookKeepCodePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
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

procedure TfrmItems2.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;

procedure TfrmItems2.tvDataDataControllerSortingChanged(Sender: TObject);
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


procedure TfrmItems2.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmItems2.btnOtherClick(Sender: TObject);
begin
  //**
end;

procedure TfrmItems2.btnCancelClick(Sender: TObject);
begin
  initItemHolder(zData);
end;

procedure TfrmItems2.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

function TfrmItems2.AssertCorrectness : Boolean;
var config : Array_Of_THotelconfigurationsEntity;
    answer : Integer;
begin

  result := true;
  if Lookup then
    exit;
  try
    config := d.roomerMainDataSet.Hotelconfigurations_Entities_FindAll;
    if config[0].forceExternalProductIdCorrectness = 1 then
    begin
      screen.Cursor := crHourglass;
      m_.DisableControls;
      try
        m_.First;
        if NOT m_.Eof then
          if NOT assigned(financeLookupList) then
            financeLookupList := d.RetrieveFinancesKeypair(FKP_PRODUCTS);
        while NOT m_.Eof do
        begin
          if ((m_['AccountKey'] = '') OR NOT d.KeyExists(financeLookupList, m_['AccountKey'])) and (m_['active'] = true) then
          begin
            answer := MessageDlg(format('Product %s (%s) needs to have an account key for bookkeeping.', [m_['Item'], m_['Description']]), mtWarning, [mbOk, mbIgnore, mbCancel], 0, mbOk);
            if answer = mrCancel then
            begin
              result := True;
              exit;
            end else
            if answer = mrOk then
            begin
              result := False;
              exit;
            end;
          end;
          m_.Next;
        end;
      finally
        screen.Cursor := crDefault;
        m_.EnableControls;
      end;
    end;
  except
  end;
end;


procedure TfrmItems2.btnDeleteClick(Sender: TObject);
begin
  m_.Delete;
end;

procedure TfrmItems2.btnEditClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  grData.SetFocus;
  tvData.GetColumnByFieldName('Description').Focused := True;
 // showmessage('Edit in grid');
  showmessage(GetTranslatedText('shTx_Items2_EditInGrid'));
end;

procedure TfrmItems2.btnInsertClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  if m_.Active = false then m_.Open;
  grData.SetFocus;
  m_.Insert;
  tvData.GetColumnByFieldName('Item').Focused := True;
end;

//---------------------------------------------------------------------------
// Menu in other actions
//-----------------------------------------------------------------------------

procedure TfrmItems2.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;
  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;


procedure TfrmItems2.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;

procedure TfrmItems2.mnuiGridToExcelClick(Sender: TObject);
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

procedure TfrmItems2.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmItems2.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmItems2.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

end.

