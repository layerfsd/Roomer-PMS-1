unit uRates;

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
  , cmpRoomerConnection, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCheckBox, cxButtonEdit, cxCalc, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter,
  cxPropertiesStore, dxmdaset, sCheckBox, AdvCombo, ColCombo, sGroupBox, dxPScxPivotGridLnk, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld

  ;

type
  TfrmRates = class(TForm)
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
    m_ID: TIntegerField;
    m_RateExtraInfant: TFloatField;
    m_RateExtraChildren: TFloatField;
    m_Active: TBooleanField;
    grData: TcxGrid;
    tvData: TcxGridDBTableView;
    lvData: TcxGridLevel;
    tvDataRecId: TcxGridDBColumn;
    tvDataID: TcxGridDBColumn;
    tvDataCurrency: TcxGridDBColumn;
    tvDataDescription: TcxGridDBColumn;
    tvDataRateExtraInfant: TcxGridDBColumn;
    tvDataRateExtraChildren: TcxGridDBColumn;
    tvDataActive: TcxGridDBColumn;
    m_Currency: TWideStringField;
    m_Description: TWideStringField;
    m_Rate1Person: TFloatField;
    m_Rate2Persons: TFloatField;
    m_Rate3Persons: TFloatField;
    m_Rate4Persons: TFloatField;
    m_Rate5Persons: TFloatField;
    m_Rate6Persons: TFloatField;
    tvDataRate1Person: TcxGridDBColumn;
    tvDataRate2Persons: TcxGridDBColumn;
    tvDataRate3Persons: TcxGridDBColumn;
    tvDataRate4Persons: TcxGridDBColumn;
    tvDataRate5Persons: TcxGridDBColumn;
    tvDataRate6Persons: TcxGridDBColumn;
    m_RateExtraPerson: TFloatField;
    tvDataRateExtraPerson: TcxGridDBColumn;
    m_isDefault: TBooleanField;
    tvDataisDefault: TcxGridDBColumn;
    gbxFilter: TsGroupBox;
    sLabel1: TsLabel;
    cbxCurrencies: TColumnComboBox;
    chkActive: TsCheckBox;
    btnInsert: TsButton;
    btnEdit: TsButton;
    btnRefresh: TsButton;
    A1: TMenuItem;
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
    procedure btnEditClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure edFilterChange(Sender: TObject);
    procedure tvDataCurrencyPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvDataisDefaultPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure tvDataCurrencyPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnInsertClick(Sender: TObject);
    procedure cbxCurrenciesCloseUp(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
    procedure A1Click(Sender: TObject);
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
    procedure FillCurrenciesBOX(box : TcolumnComboBox;All:boolean; defID : integer);
    procedure changeAllowgridEdit;
    function getPrevCode : string;
    Procedure chkFilter;
    procedure applyFilter;



  public
    { Public declarations }
    zAct   : TActTableAction;
    zData  : recRateHolder;
  end;

function Rates(act : TActTableAction; var theData : recRateHolder) : boolean;

var
  frmRates: TfrmRates;

implementation

{$R *.dfm}

uses
    uD
  , uDImages
  , prjConst
  , uSqlDefinitions
  , uCurrencies
  , uUtils
  ;



//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function Rates(act : TActTableAction; var theData : recRateHolder) : boolean;
begin
  result := false;
  frmRates := TfrmRates.Create(frmRates);
  try
    frmRates.zData := theData;
    frmRates.zAct := act;
    frmRates.ShowModal;
    if frmRates.modalresult = mrOk then
    begin
      theData := frmRates.zData;
      result := true;
    end
    else
    begin
      initRateHolder(theData);
    end;
  finally
    freeandnil(frmRates);
  end;
end;

///////////////////////////////////////////////////////////////////////
                    { Private declarations }
///////////////////////////////////////////////////////////////////////

procedure TfrmRates.FillCurrenciesBOX(box : TcolumnComboBox;All:boolean; defID : integer);
var
  rSet        : TRoomerDataSet;
  s           : string;
  i           : integer;
  ii          : integer;
  Code        : string;
  Description : string;
  ID          : integer;
begin
  ii := 0;
  box.ItemIndex := 0;
  box.Columns.Clear;
  box.Columns.Add;
  box.Columns.Add;

  box.Columns.Items[0].Color := clltgray;
  box.Columns.Items[1].Color := clWhite;

  box.Columns.Items[0].Width := 60;
  box.Columns.Items[1].Width := 150;

  box.ComboItems.clear;

  if all then
  begin
    box.ComboItems.Add;
    box.ComboItems.Items[0].Strings.add('All');
    box.ComboItems.Items[0].Strings.add('All currencies');
    i := 0;
  end else i := -1;

  rSet := CreateNewDataSet;
  try
    s := format(select_RoomPrices_FillCurrenciesBOX , []);
    hData.rSet_bySQL(rSet,s);

    while not rSet.eof do
    begin
      inc(i);
      Code        := rSet.fieldbyname('Currency').asString;
      Description := rSet.fieldbyname('Description').asstring;
      ID          := rSet.fieldbyname('ID').asinteger;
      if  ID = defID then ii := i;
      box.ComboItems.Add;
      box.ComboItems.Items[i].Strings.add(code);
      box.ComboItems.Items[i].Strings.add(Description);
      rSet.Next;
    end;

    if defID = 0 then
    begin
      if box.ComboItems.Count > 1 then box.ItemIndex := 1;
    end else
    begin
      box.ItemIndex := ii;
    end;
  finally
    freeandNil(rSet);
  end;
end;



Procedure TfrmRates.fillGridFromDataset(currency,sGoto : string);
var
  s    : string;
  rSet : TRoomerDataSet;
begin
  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'Currency';

  rSet := CreateNewDataSet;
  try
    if currency = '' then
    begin
      s := format(select_Rates_fillGridFromDataset , [zSortStr]);
    end else
    begin
      s := format(select_Rates_fillGridFromDataset_byCurrency , [_db(currency), zSortStr]);
    end;
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
          m_.Locate('currency',sGoto,[]);
        except
        end;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
  tvdata.ApplyBestFit;
end;

procedure TfrmRates.fillHolder;
begin
  initRateHolder(zData);
  try
  zData.ID                 := m_.FieldByName('ID').AsInteger;
  zData.Active             := m_['Active'];
  zData.Currency           := m_['Currency'];
  zData.Description        := m_['Description'];
  zData.Rate1Person        := m_['Rate1Person'];
  zData.Rate2Persons       := m_['Rate2Persons'];
  zData.Rate3Persons       := m_['Rate3Persons'];
  zData.Rate4Persons       := m_['Rate4Persons'];
  zData.Rate5Persons       := m_['Rate5Persons'];
  zData.Rate6Persons       := m_['Rate6Persons'];
  zData.RateExtraPerson    := m_['RateExtraPerson'];
  zData.RateExtraChildren  := m_['RateExtraChildren'];
  zData.RateExtraInfant    := m_['RateExtraInfant'];
  zData.isDefault          := m_['isDefault'];
  except
  end;
end;


procedure TfrmRates.cbxCurrenciesCloseUp(Sender: TObject);
var
  idx : integer;
  aCode : string;
begin
  idx := cbxCurrencies.ItemIndex;
  if idx = 0 then
  begin
    zCurrencyID := 0;
  end else
  begin
    aCode := cbxCurrencies.ComboItems[idx].Strings[0];
    zCurrencyID := GET_IdByCurrency(aCode);
    zCurrency := aCode;
  end;
  btnRefresh.Click;
end;

procedure TfrmRates.changeAllowgridEdit;
begin
  if zAllowGridEdit then
  begin
    tvDataID.Options.Editing               := false;
    tvDataActive.Options.Editing           := true;
    tvDataCurrency.Options.Editing         := true;
    tvDataDescription.Options.Editing      := true;
    tvDataRate1Person.Options.Editing      := true;
    tvDataRate2Persons.Options.Editing     := true;
    tvDataRate3Persons.Options.Editing     := true;
    tvDataRate4Persons.Options.Editing     := true;
    tvDataRate5Persons.Options.Editing     := true;
    tvDataRate6Persons.Options.Editing     := true;
    tvDataRateExtraPerson.Options.Editing  := true;
    tvDataRateExtraChildren.Options.Editing:= true;
    tvDataRateExtraInfant.Options.Editing  := true;
    tvDataisDefault.Options.Editing        := true;
  end else
  begin
    tvDataID.Options.Editing               := false;
    tvDataActive.Options.Editing           := false;
    tvDataCurrency.Options.Editing         := false;
    tvDataDescription.Options.Editing      := false;
    tvDataRate1Person.Options.Editing      := false;
    tvDataRate2Persons.Options.Editing     := false;
    tvDataRate3Persons.Options.Editing     := false;
    tvDataRate4Persons.Options.Editing     := false;
    tvDataRate5Persons.Options.Editing     := false;
    tvDataRate6Persons.Options.Editing     := false;
    tvDataRateExtraPerson.Options.Editing  := false;
    tvDataRateExtraChildren.Options.Editing:= false;
    tvDataRateExtraInfant.Options.Editing  := false;
    tvDataisDefault.Options.Editing        := false;
  end;
end;


procedure TfrmRates.chkActiveClick(Sender: TObject);
begin
  btnRefresh.Click;
end;

procedure TfrmRates.chkFilter;
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


procedure TfrmRates.edFilterChange(Sender: TObject);
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

procedure TfrmRates.A1Click(Sender: TObject);
begin
  tvdata.ApplyBestFit;
end;

procedure TfrmRates.applyFilter;
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

procedure TfrmRates.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  //**
  zFirstTime  := true;
  zAct        := actNone;
  zisAddrow   := false;
  zDescription := '';
end;

procedure TfrmRates.FormShow(Sender: TObject);
var
  tmp : integer;
begin
//**
  panBtn.Visible   := False;
  sbMain.Visible   := false;

  if zData.Currency <> '' then
  begin
    zCurrencyID   := GET_IDByCurrency(zData.Currency);
  end else
  begin
    zCurrencyID     := getNativeCurrencyID();
    zCurrency       := GET_CurrencyByID(zCurrencyID);                ;
    zData.Currency  := zCurrency;
  end;

  FillCurrenciesBOX(cbxCurrencies,true, zCurrencyID);

  fillGridFromDataset(zData.Currency,zData.Currency);
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
    sbMain.Visible := true;
  end;
  //-C
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  chkFilter;
  zFirstTime := false;
end;

procedure TfrmRates.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fillHolder;
  if tvdata.DataController.DataSet.State = dsInsert then
  begin
    tvdata.DataController.Post;
  end;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;
end;

procedure TfrmRates.FormKeyPress(Sender: TObject; var Key: Char);
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


function TfrmRates.getPrevCode: string;
begin
end;


procedure TfrmRates.m_BeforeDelete(DataSet: TDataSet);
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
    if not Del_Rate(zData) then
    begin
      abort;
    end
  end else
  begin
    abort
  end;
end;

procedure TfrmRates.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('Description').Focused := True;
end;


procedure TfrmRates.m_BeforePost(DataSet: TDataSet);
var
  nID : integer;
begin
  if zFirstTime then exit;
  initRateHolder(zData);
  zData.ID                := dataset.FieldByName('ID').AsInteger;
  zData.Active            := dataset['Active'];
  zData.Currency          := dataset['Currency'];
  zData.Description       := dataset['Description'];
  zData.Rate1Person       := dataset['Rate1Person'];
  zData.Rate2Persons      := dataset['Rate2Persons'];
  zData.Rate3Persons      := dataset['Rate3Persons'];
  zData.Rate4Persons      := dataset['Rate4Persons'];
  zData.Rate5Persons      := dataset['Rate5Persons'];
  zData.Rate6Persons      := dataset['Rate6Persons'];
  zData.RateExtraPerson   := dataset['RateExtraPerson'];
  zData.RateExtraChildren := dataset['RateExtraChildren'];
  zData.RateExtraInfant   := dataset['RateExtraInfant'];
  zData.isDefault         := dataset['isDefault'];

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if UPD_Rate(zData) then
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
    if ins_Rate(zData,nID) then
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

procedure TfrmRates.m_NewRecord(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  dataset['Active']           := true;
  dataset['Rate1Person']      := 0;
  dataset['Rate2Persons']     := 0;
  dataset['Rate3Persons']     := 0;
  dataset['Rate4Persons']     := 0;
  dataset['Rate5Persons']     := 0;
  dataset['Rate6Persons']     := 0;
  dataset['RateExtraPerson']  := 0;
  dataset['RateExtraChildren']:= 0;
  dataset['RateExtraInfant']  := 0;
  dataset['isDefault']        := false;
  dataset['Currency']         := zData.Currency;
  if ZAct = actLookup then
  begin
    dataset['Description']      := zDescription+' '+zData.Currency;
  end else dataset['Description']      := '';
end;

////////////////////////////////////////////////////////////////////////////////////////
//  table View Functions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmRates.tvDataDescriptionPropertiesValidate(Sender: TObject;
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


procedure TfrmRates.tvDataisDefaultPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  isDefault   : boolean;
  oldValue    : boolean;
  Currency    : string ;
  s           : string ;
begin
  currency := m_['currency'];
  if TcxCheckBox (Sender).Checked then
  begin
    if hData.rateDefaultExist(Currency,true) then
    begin
      error := true;
     // errortext:= 'Default for '+currency+' already exists - Use [ESC] to abandon changes';
	    errortext:= format(GetTranslatedText('shTx_Rates_DefaultForCurrenyAlreadyExists'), [currency]);
      exit
    end;
  end;
end;


procedure TfrmRates.tvDataCurrencyPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  CurrValue : string;
  isDefault : boolean;
begin
  currValue := m_['currency'];
  isDefault := m_['isDefault'];

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
  //  errortext := 'Currency '+' - '+'is required - Use [ESC] to abandon changes';
	 errortext := GetTranslatedText('shTx_Rates_CurrencyIsRequired');
    exit;
  end;

  if hData.rateDefaultExist(displayvalue,true) then
  begin
    error := true;
  //  errortext:= 'Default for '+displayvalue+' already exists - Use [ESC] to abandon changes';
  	errortext:= format(GetTranslatedText('shTx_Rates_DefaultForCurrenyAlreadyExists'), [displayvalue]);
    exit
  end;
end;


procedure TfrmRates.tvDataFocusedRecordChanged(
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


procedure TfrmRates.tvDataDblClick(Sender: TObject);
begin
  if ZAct = actLookup then
  begin
    btnOK.Click
  end;
end;


////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////


procedure TfrmRates.tvDataCurrencyPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recCurrencyHolder;
  isDefault : boolean;
begin
  isDefault := m_['isDefault'];
  fillholder;
  theData.Currency := zData.Currency;
  currencies(actlookup,theData);
  if theData.Currency <> '' then
  begin
    if isDEfault then
    if hData.rateDefaultExist(theData.Currency,true) then
    begin
	    showmessage(format(GetTranslatedText('shTx_Rates_DefaultExistsAbandonChanges'), [theData.Currency]));
      exit
    end;
    m_.Edit;
    m_.FieldByName('currency').asString := theData.Currency;
    m_.Post;
  end;
end;


procedure TfrmRates.tvDataDataControllerFilterChanged(Sender: TObject);
begin
//  chkFilter;
end;


procedure TfrmRates.tvDataDataControllerSortingChanged(Sender: TObject);
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


procedure TfrmRates.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmRates.btnOtherClick(Sender: TObject);
begin
  //**
end;

procedure TfrmRates.btnRefreshClick(Sender: TObject);
begin
  zData.currency  := GET_CurrencyByID(zCurrencyID);                ;
  fillGridFromDataset(zData.Currency,zData.Currency);
  zFirstTime := false;
end;

procedure TfrmRates.btnCancelClick(Sender: TObject);
begin
  initRateHolder(zData);
end;

procedure TfrmRates.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmRates.btnDeleteClick(Sender: TObject);
begin
  m_.Delete;
end;

procedure TfrmRates.btnEditClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  grData.SetFocus;
  tvData.GetColumnByFieldName('Description').Focused := True;
  showmessage(GetTranslatedText('shTx_Rates_EditInGrid'));
end;

procedure TfrmRates.btnInsertClick(Sender: TObject);
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

procedure TfrmRates.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;
  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;


procedure TfrmRates.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;

procedure TfrmRates.mnuiGridToExcelClick(Sender: TObject);
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

procedure TfrmRates.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmRates.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmRates.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

end.

