unit uTaxes;

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
  , Data.DB
  , shellapi
  , Hdata
  , _glob
  , ug
  , uStringUtils
  , uUtils

  , kbmMemTable

  , uAppGlobal
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
  , cmpRoomerConnection


  , dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxDropDownEdit, cxButtonEdit, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter, cxPropertiesStore,
  dxmdaset, sCheckBox, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, dxPScxPivotGridLnk, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinDarkRoom, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue
  ;

type
  TfrmTaxes = class(TForm)
    sPanel1: TsPanel;
    btnDelete: TsButton;
    btnOther: TsButton;
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
    btnClear: TsSpeedButton;
    panBtn: TsPanel;
    btnCancel: TsButton;
    BtnOk: TsButton;
    DS: TDataSource;
    grPrinter: TdxComponentPrinter;
    prLink_grData: TdxGridReportLink;
    m_: TdxMemData;
    m_ID: TIntegerField;
    grData: TcxGrid;
    tvData: TcxGridDBTableView;
    lvData: TcxGridLevel;
    chkActive: TsCheckBox;
    btnInsert: TsButton;
    btnEdit: TsButton;
    btnRefresh: TsButton;
    A1: TMenuItem;
    FormStore: TcxPropertiesStore;
    m_Description: TWideStringField;
    m_Amount: TFloatField;
    m_Tax_Type: TWideStringField;
    m_Tax_Base: TWideStringField;
    m_Time_Due: TWideStringField;
    m_ReTaxable: TWideStringField;
    m_Booking_Item_Id: TIntegerField;
    tvDataRecId: TcxGridDBColumn;
    tvDataID: TcxGridDBColumn;
    tvDataDescription: TcxGridDBColumn;
    tvDataAmount: TcxGridDBColumn;
    tvDataTax_Type: TcxGridDBColumn;
    tvDataTax_Base: TcxGridDBColumn;
    tvDataTime_Due: TcxGridDBColumn;
    tvDataReTaxable: TcxGridDBColumn;
    tvDataBooking_Item_Id: TcxGridDBColumn;
    tvDataBooking_Item: TcxGridDBColumn;
    m_Hotel_Id: TWideStringField;
    m_Booking_Item: TWideStringField;
    m_Incl_Excl: TWideStringField;
    tvDataIncl_Excl: TcxGridDBColumn;
    tvDataNetto_Amount_Based: TcxGridDBColumn;
    m_Netto_Amount_Based: TWideStringField;
    pnlHolder: TsPanel;
    m_Value_Formula: TWideStringField;
    tvDataValue_Formula: TcxGridDBColumn;
    m_Valid_From: TDateField;
    m_Valid_To: TDateField;
    tvDataValid_From: TcxGridDBColumn;
    tvDataValid_To: TcxGridDBColumn;
    PopupMenu1: TPopupMenu;
    C1: TMenuItem;
    m_TaxChildren: TWideStringField;
    tvDataTaxChildren: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
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
    procedure btnEditClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure edFilterChange(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure tvDataBooking_Item_IdPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvDataBooking_ItemPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure C1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    zFirstTime       : boolean;
    zAllowGridEdit   : boolean;
    zFilterOn        : boolean;
    zSortStr         : string;
    zIsAddRow        : boolean;
    zCurrencyID      : integer;
    zCurrency        : string;
    zLocalCurrency   : string;
    zDescription : string;

    Procedure fillGridFromDataset(currency,sGoto : string);
    procedure fillHolder;
    procedure changeAllowgridEdit;
    function getPrevCode : string;
    Procedure chkFilter;
    procedure applyFilter;



  public
    { Public declarations }
    zAct   : TActTableAction;
    zData  : recTaxesHolder;

    embedded : Boolean;
    EmbedWindowCloseEvent : TNotifyEvent;

    procedure PrepareUserInterface;
    procedure BringWindowToFront;
  end;

function Taxes(act : TActTableAction; var theData : recTaxesHolder; embedPanel : TsPanel = nil; WindowCloseEvent : TNotifyEvent = nil) : boolean;

var
  frmTaxes: TfrmTaxes;
  frmTaxesX: TfrmTaxes;

implementation

{$R *.dfm}

uses
    uD
  , uDImages
  , prjConst
  , uSqlDefinitions
  , uItems2
  ;



//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function Taxes(act : TActTableAction; var theData : recTaxesHolder; embedPanel : TsPanel = nil; WindowCloseEvent : TNotifyEvent = nil) : boolean;
var _frmTaxes: TfrmTaxes;
begin
  result := false;
  _frmTaxes := TfrmTaxes.Create(nil);
  try
    _frmTaxes.zData := theData;
    _frmTaxes.zAct := act;
    _frmTaxes.embedded := (act = actNone) AND
                                    (embedPanel <> nil);
    _frmTaxes.EmbedWindowCloseEvent := WindowCloseEvent;
    if _frmTaxes.embedded then
    begin
      _frmTaxes.pnlHolder.parent := embedPanel;
      embedPanel.Update;
      frmTaxesX := _frmTaxes;
    end
    else
    begin
      _frmTaxes.PrepareUserInterface;
      _frmTaxes.ShowModal;
      if _frmTaxes.modalresult = mrOk then
      begin
        theData := _frmTaxes.zData;
        result := true;
      end
      else
      begin
        initTaxesHolder(theData);
      end;
    end;
  finally
    if (act <> actNone) OR
      (embedPanel = nil) then
      freeandnil(_frmTaxes);
  end;
end;

///////////////////////////////////////////////////////////////////////
                    { Private declarations }
///////////////////////////////////////////////////////////////////////


Procedure TfrmTaxes.fillGridFromDataset(currency,sGoto : string);
var
  s    : string;
  rSet : TRoomerDataSet;
begin
  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'Description';

  rSet := CreateNewDataSet;
  try
    s := format(select_Taxes_fillGridFromDataset , [zSortStr]);
    copytoclipboard(s);
//    debugmessage(s);


    if rSet_bySQL(rSet,s,false) then
    begin
      if m_.active then m_.Close;
      m_.LoadFromDataSet(rSet);
      if sGoto = '' then
      begin
        m_.First;
      end else
      begin
        try
          m_.Locate('Description',sGoto,[]);
        except
        end;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
  tvdata.ApplyBestFit;
end;

procedure TfrmTaxes.fillHolder;
begin
  initTaxesHolder(zData);
  try
  zData.ID                 := m_.FieldByName('ID').AsInteger;
  zData.Description        := m_['Description'];
  zData.Hotel_Id        := m_['Hotel_Id'];
  zData.Tax_Type       := m_['Tax_Type'];
  zData.Tax_Base       := m_['Tax_Base'];
  zData.Time_Due       := m_['Time_Due'];
  zData.ReTaxable       := m_['ReTaxable'];
  zData.TaxChildren     := m_TaxChildren.AsString;
  zData.Booking_Item_Id       := m_['Booking_Item_Id'];
  zData.Booking_Item    := m_['Booking_Item'];
  zData.Incl_Excl    := m_['Incl_Excl'];
  zData.NETTO_AMOUNT_BASED    := m_['NETTO_AMOUNT_BASED'];
  zData.VALUE_FORMULA    := m_['VALUE_FORMULA'];
  zData.VALID_FROM    := m_['VALID_FROM'];
  zData.VALID_TO    := m_['VALID_TO'];

  zData.Amount  := m_['Amount'];
  except  end;
end;


procedure TfrmTaxes.changeAllowgridEdit;
begin
  tvDataDescription.Options.Editing := zAllowGridEdit;
  tvDataAmount.Options.Editing := zAllowGridEdit;
  tvDataTax_Type.Options.Editing := zAllowGridEdit;
  tvDataTax_Base.Options.Editing := zAllowGridEdit;
  tvDataTime_Due.Options.Editing := zAllowGridEdit;
  tvDataReTaxable.Options.Editing := zAllowGridEdit;
  tvDataTaxChildren.Options.Editing := zAllowGridEdit;
  tvDataBooking_Item.Options.Editing := zAllowGridEdit;
  tvDataBooking_Item_Id.Options.Editing := zAllowGridEdit;
  tvDataIncl_Excl.Options.Editing := zAllowGridEdit;
  tvDataNetto_Amount_Based.Editing := zAllowGridEdit;
  tvDataValue_Formula.Editing := zAllowGridEdit;
  tvDataValid_From.Editing := zAllowGridEdit;
  tvDataValid_to.Editing := zAllowGridEdit;

  tvDataID.Options.Editing := false;
end;


procedure TfrmTaxes.chkActiveClick(Sender: TObject);
begin
  btnRefresh.Click;
end;

procedure TfrmTaxes.chkFilter;
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


procedure TfrmTaxes.edFilterChange(Sender: TObject);
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

procedure TfrmTaxes.A1Click(Sender: TObject);
begin
  tvdata.ApplyBestFit;
end;

procedure TfrmTaxes.applyFilter;
begin
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvData.DataController.Filter.Root.Clear;
  tvData.DataController.Filter.Root.AddItem(tvDataDescription,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Active := True;
end;


procedure TfrmTaxes.BringWindowToFront;
begin
  pnlHolder.BringToFront;
end;

/////////////////////////////////////////////////////////////
// Form actions
/////////////////////////////////////////////////////////////

procedure TfrmTaxes.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  //**
  zFirstTime  := true;
  zAct        := actNone;
  zisAddrow   := false;
  zDescription := '';

  PrepareUserInterface;
end;

procedure TfrmTaxes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fillHolder;
  if tvdata.DataController.DataSet.State IN [dsInsert, dsEdit] then
  begin
    tvdata.DataController.Post;
  end;

  pnlHolder.Parent := self;
  update;
  if embedded then
    Action := caFree;
  if Assigned(EmbedWindowCloseEvent) then
    EmbedWindowCloseEvent(self);
end;

procedure TfrmTaxes.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    btnCancel.Click;

end;

procedure TfrmTaxes.FormKeyPress(Sender: TObject; var Key: Char);
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


function TfrmTaxes.getPrevCode: string;
begin
end;


procedure TfrmTaxes.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
  fillHolder;
(*
  if hdata.payTypeExistsInOther(zData.PayType) then
  begin
    Showmessage('payType'+' ' + zData.Description + ' '+GetTranslatedText('shExistsInRelatedData')+' ' + chr(10) + GetTranslatedText('shCanNotDelete')+' ');
    Abort;
    exit;
  end;
*)

  s := '';
  s := s+GetTranslatedText('shDeleteRoomRate')+' '+zData.Description+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if not Del_Taxes(zData) then
    begin
      abort;
    end
  end else
  begin
    abort
  end;
end;

procedure TfrmTaxes.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('Description').Focused := True;
end;


procedure TfrmTaxes.m_BeforePost(DataSet: TDataSet);
var
  nID : integer;
begin
  if zFirstTime then exit;
  initTaxesHolder(zData);
  try
    zData.ID                := m_ID.AsInteger;
    zData.Description       := m_Description.AsString;
    zData.Amount            := m_Amount.AsFloat;
    zData.Hotel_Id          := m_Hotel_Id.AsString;
    zData.Tax_Type          := m_Tax_Type.AsString;
    zData.Tax_Base          := m_Tax_Base.AsString;
    zData.Time_Due          := m_Time_Due.AsString;
    zData.ReTaxable         := m_ReTaxable.AsString;
    zData.TaxChildren       := m_TaxChildren.AsString;
    zData.Booking_Item_Id   := m_Booking_Item_Id.AsInteger;
    zData.Booking_Item      := m_Booking_Item.AsString;
    zData.Incl_Excl         := m_Incl_Excl.AsString;
    zData.NETTO_AMOUNT_BASED := m_Netto_Amount_Based.AsString;
    zData.VALUE_FORMULA     := m_Value_Formula.AsString;
    zData.VALID_FROM        := m_Valid_From.AsDateTime;
    zData.VALID_TO          := m_Valid_To.AsDateTime;
  except
    Abort;
    Exit;
  end;

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if UPD_Taxes(zData) then
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
    if dataset.FieldByName('Description').AsString = ''  then
    begin
     // showmessage('Description is requierd - set value or use [ESC] to cancel ');
	    showmessage(GetTranslatedText('shTx_Rates_DescriptionRequired'));
      tvData.GetColumnByFieldName('Description').Focused := True;
      abort;
      exit;
    end;
    if ins_Taxes(zData,nID) then
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

procedure TfrmTaxes.m_NewRecord(DataSet: TDataSet);
var rec : recTaxesHolder;
begin
  if zFirstTime then exit;
  InitTaxesHolder(Rec);
  dataset['Hotel_Id']      := rec.Hotel_Id;
  dataset['Description']     := rec.Description;
  dataset['Tax_Type']     := rec.Tax_Type;
  dataset['Tax_Base']     := rec.Tax_Base;
  dataset['Time_Due']     := rec.Time_Due;
  dataset['Amount']     := rec.Amount;
  dataset['Booking_Item_Id']  := rec.Booking_Item_Id;
  dataset['Booking_Item']:= rec.Booking_Item;
  dataset['VALUE_FORMULA'] := rec.VALUE_FORMULA;
  dataset['VALID_FROM'] := rec.VALID_FROM;
  dataset['VALID_TO'] := rec.VALID_TO;
end;

procedure TfrmTaxes.PrepareUserInterface;
var
  tmp : integer;
begin
//**
  panBtn.Visible   := False;
  sbMain.Visible   := false;
  btnClose.Visible := False;

  fillGridFromDataset(zData.Description,zData.Description);
  zFirstTime := true;
  sbMain.SimpleText := zSortStr;

  if ZAct = actLookup then
  begin
    mnuiAllowGridEdit.Checked := false;
    panBtn.Visible := true;
    zDescription   := zData.Description;
  end else
  begin
    mnuiAllowGridEdit.Checked := true;
    btnClose.Visible := embedded;
    sbMain.Visible := true;
  end;
  //-C
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  chkFilter;
  zFirstTime := false;
end;

////////////////////////////////////////////////////////////////////////////////////////
//  table View Functions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmTaxes.tvDataDescriptionPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_.fieldbyname('Description').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
    //errortext := 'Description '+' - '+'is required - Use ESC to cancel';
	  errortext := GetTranslatedText('shTx_Rates_DescriptionIsRequired');
    exit;
  end;

  if hdata.rateDescriptionExist(displayValue) then
  begin
    error := true;
    //errortext := displayvalue+'Nýtt gildi er til í annari færslu. Notið ESC-hnappin til að hætta við';
    errortext := displayvalue+'  '+GetTranslatedText('shNewValueExistInAnotherRecor');
    exit
  end;

end;


procedure TfrmTaxes.tvDataFocusedRecordChanged(
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


procedure TfrmTaxes.tvDataDblClick(Sender: TObject);
begin
  if ZAct = actLookup then
  begin
    btnOK.Click
  end;
end;


////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////


procedure TfrmTaxes.tvDataBooking_ItemPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_.fieldbyname('Booking_Item').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
    //errortext := 'Description '+' - '+'is required - Use ESC to cancel';
	  errortext := 'Booking Item is Required'; // GetTranslatedText('shTx_Rates_DescriptionIsRequired');
    exit;
  end;

  if NOT hdata.itemExist(displayValue) then // ,g.qLogLevel,g.qProgramPath) then
  begin
    error := true;
    //errortext := displayvalue+'Nýtt gildi er til í annari færslu. Notið ESC-hnappin til að hætta við';
    errortext := displayvalue+'  Does not exist.'; //  +GetTranslatedText('shNewValueExistInAnotherRecor');
    exit;
  end;
end;

procedure TfrmTaxes.tvDataBooking_Item_IdPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recItemHolder;
begin
  fillholder;
  theData.Item := zData.Booking_Item;
  openItems(actlookup,true,theData);
  if theData.Item <> '' then
  begin
    m_.Edit;
    m_.FieldByName('Booking_Item').asString := theData.Item;
    m_.Post;
  end;
end;

procedure TfrmTaxes.tvDataDataControllerSortingChanged(Sender: TObject);
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


procedure TfrmTaxes.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmTaxes.btnOtherClick(Sender: TObject);
begin
  //**
end;

procedure TfrmTaxes.btnRefreshClick(Sender: TObject);
begin
  fillGridFromDataset(zData.Description,zData.Description);
  zFirstTime := false;
end;

procedure TfrmTaxes.C1Click(Sender: TObject);
begin
  DuplicateCurrentRow(m_);
  tvData.Columns[0].Focused := True;
end;

procedure TfrmTaxes.btnCancelClick(Sender: TObject);
begin
  initTaxesHolder(zData);
end;

procedure TfrmTaxes.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmTaxes.btnCloseClick(Sender: TObject);
begin

  if embedded then
    Close;
end;

procedure TfrmTaxes.btnDeleteClick(Sender: TObject);
begin
  m_.Delete;
end;

procedure TfrmTaxes.btnEditClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  grData.SetFocus;
  tvData.GetColumnByFieldName('Description').Focused := True;
  showmessage(GetTranslatedText('shTx_Rates_EditInGrid'));
end;

procedure TfrmTaxes.btnInsertClick(Sender: TObject);
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

procedure TfrmTaxes.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;
  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;


procedure TfrmTaxes.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;

procedure TfrmTaxes.mnuiGridToExcelClick(Sender: TObject);
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

procedure TfrmTaxes.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmTaxes.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmTaxes.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

end.

