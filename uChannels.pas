unit uChannels;

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
  , _glob
  , uAppGlobal
  , Hdata
  , ug
  , uManageFilesOnServer
  , uActivityLogs

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
  , cmpRoomerConnection
  , dxmdaset
  , cxButtonEdit
  , cxCalc

  , Vcl.Mask

  , cxContainer
  , cxMaskEdit
  , cxDropDownEdit
  , cxLookupEdit
  , cxDBLookupEdit
  , cxDBExtLookupComboBox
  , cxDBLookupComboBox
  , cxSpinEdit
  , dxSkinsCore
  , dxSkinsdxBarPainter
  , dxSkinsdxRibbonPainter
  , cxPropertiesStore
  , cxColorComboBox
  , cxCheckGroup
  , cxRadioGroup
  , dxPScxPivotGridLnk

  , dxSkinDarkSide
  , dxSkinDevExpressDarkStyle
  , dxSkinMcSkin
  , dxSkinOffice2013White
  , dxSkinsDefaultPainters
  , dxSkinscxPCPainter, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld

   ;

type
  TfrmChannels = class(TForm)
    sPanel1: TsPanel;
    btnOther: TsButton;
    btnClose: TsButton;
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
    m_name: TWideStringField;
    m_channelManagerId: TWideStringField;
    m_minAlotment: TIntegerField;
    m_defaultAvailability: TIntegerField;
    m_defaultPricePP: TFloatField;
    m_marketSegment: TWideStringField;
    m_currencyId: TIntegerField;
    m_managedByChannelManager: TBooleanField;
    m_default: TBooleanField;
    tvDataname: TcxGridDBColumn;
    tvDatachannelManagerId: TcxGridDBColumn;
    tvDataminAlotment: TcxGridDBColumn;
    tvDatadefaultAvailability: TcxGridDBColumn;
    tvDatadefaultPricePP: TcxGridDBColumn;
    tvDatamarketSegment: TcxGridDBColumn;
    tvDatacurrencyId: TcxGridDBColumn;
    tvDataCurrency: TcxGridDBColumn;
    tvDatamanagedByChannelManager: TcxGridDBColumn;
    m_Currency: TWideStringField;
    StoreMain: TcxPropertiesStore;
    m_push: TBooleanField;
    tvDatapush: TcxGridDBColumn;
    m_customerId: TIntegerField;
    tvDatacustomerId: TcxGridDBColumn;
    m_color: TWideStringField;
    tvDatacolor: TcxGridDBColumn;
    m_rateRoundingType: TIntegerField;
    tvDatarateRoundingType: TcxGridDBColumn;
    tvDataroomClasses: TcxGridDBColumn;
    tvDatadefaultChannel: TcxGridDBColumn;
    m_compensationPercentage: TFloatField;
    m_hotelsBookingEngine: TBooleanField;
    tvDatacompensationPercentage: TcxGridDBColumn;
    tvDatahotelsBookingEngine: TcxGridDBColumn;
    m_RateRoundingText: TStringField;
    Button1: TsButton;
    Button2: TsButton;
    Button3: TsButton;
    m_CHANNEL_ARRANGES_PAYMENT: TBooleanField;
    tvDataCHANNEL_ARRANGES_PAYMENT: TcxGridDBColumn;
    btnInsert: TsButton;
    btnEdit: TsButton;
    btnDelete: TsButton;
    m_directConnection: TBooleanField;
    tvDatadirectConnection: TcxGridDBColumn;
    m_activePlanCode: TIntegerField;
    tvDataactivePlanCode: TcxGridDBColumn;
    m_ratesExcludingTaxes: TBooleanField;
    tvDataratesExcludingTaxes: TcxGridDBColumn;
    tvDatarateRoundingType1: TcxGridDBColumn;
    m_roomClasses: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure m_BeforeDelete(DataSet: TDataSet);
    procedure m_BeforeInsert(DataSet: TDataSet);
    procedure m_BeforePost(DataSet: TDataSet);
    procedure m_NewRecord(DataSet: TDataSet);
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
    procedure btnEditClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure edFilterChange(Sender: TObject);
    procedure tvDataCurrencyPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure tvDatamarketSegmentPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure tvDatacustomerIdPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure tvDataroomClassesPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tvDataactivePlanCodePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    zFirstTime: Boolean;
    zAllowGridEdit: Boolean;
    zFilterOn: Boolean;
    zSortStr: string;
    zIsAddRow: Boolean;

    Procedure fillGridFromDataset(iGoto: Integer);
    procedure fillHolder;
    procedure changeAllowgridEdit;
    function getPrevCode: string;
    Procedure chkFilter;
    procedure applyFilter;
    procedure RemoveRedundantRatesAndAvailabilities;

  public
    { Public declarations }
    zAct: TActTableAction;
    zData: recChannelHolder;
  end;

function openChannels(act: TActTableAction;
  var theData: recChannelHolder): Boolean;

var
  frmChannels: TfrmChannels;

implementation

{$R *.dfm}

uses
  uD
  , prjConst
  , uSqlDefinitions
  , uCurrencies
  , uCustomerTypes2
  , uCustomers2
  , uMultiSelection
  , uDImages
  , uUtils
  , u2DMatrix

  ;

/// ///////////////////////////////////////////////////////////////////////////////////////////
// unit global functions
/// ///////////////////////////////////////////////////////////////////////////////////////////

function roundint2text(aInt : integer) : string;
begin
  case aint of
    0 : result := 'No rounding';
    1 : result := 'Round to nearest whole number';
    2 : result := 'Round up to whole number';
    3 : result := 'Round down to whole number';
    4 : result := 'Round to 1 decimal';
    5 : result := 'Round to 2 decimals';
    6 : result := 'Round to 3 decimals';
  end;
end;


function roundText2int(aText : string) : integer;
begin
  if atext =  'No rounding' then result := 0;
  if atext =  'Round to nearest whole number' then result := 1;
  if atext =  'Round up to whole number' then result := 2;
  if atext =  'Round down to whole number' then result := 3;
  if atext =  'Round to 1 decimal' then result := 4;
  if atext =  'Round to 2 decimals' then result := 5;
  if atext =  'Round to 3 decimals' then result := 6;
end;


function openChannels(act: TActTableAction;
  var theData: recChannelHolder): Boolean;
begin
  result := false;
  frmChannels := TfrmChannels.Create(frmChannels);
  try
    frmChannels.zData := theData;
    frmChannels.zAct := act;
    frmChannels.ShowModal;
    if frmChannels.modalresult = mrOk then
    begin
      theData := frmChannels.zData;
      result := true;
    end
    else
    begin
      initChannelHolder(theData);
    end;
  finally
    freeandnil(frmChannels);
  end;
end;

/// ////////////////////////////////////////////////////////////////////
{ Private declarations }
/// ////////////////////////////////////////////////////////////////////

Procedure TfrmChannels.fillGridFromDataset(iGoto: Integer);
var
  s: string;
  rSet: TRoomerDataSet;
  rSetRoomClasses: TRoomerDataSet;
begin
  zFirstTime := true;
  if zSortStr = '' then
    zSortStr := 'ID';
  rSet := CreateNewDataSet;
  try
    s := format(select_Channels, [zSortStr]);
    CopyToClipboard(s);
    if rSet_bySQL(rSet, s) then
    begin
      if m_.active then
        m_.Close;
      m_.LoadFromDataSet(rSet);

      m_.First;
      rSet.First;
      while not m_.Eof do
      begin
        m_.Edit;
        m_.FieldByName('rateRoundingText').AsString := roundint2text(m_.FieldByName('rateRoundingType').AsInteger);
        rSetRoomClasses := CreateNewDataSet;
        try
          rSet_bySQL(rSetRoomClasses,
              format('SELECT Code FROM roomtypegroups WHERE id IN (SELECT roomClassId FROM channelclassrelations WHERE channelId=%d)', [m_.FieldByName('id').AsInteger]));
          s := '';
          rSetRoomClasses.First;
          while NOT rSetRoomClasses.Eof do
          begin
            if s = '' then
              s := rSetRoomClasses['Code']
            else
              s := s + ',' + rSetRoomClasses['Code'];
            rSetRoomClasses.Next;
          end;
          m_.FieldByName('roomClasses').AsString := s;
        finally
          FreeAndNil(rSetRoomClasses);
        end;
        m_.Post;
        rSet.Next;
        m_.Next;
      end;

      if iGoto = 0 then
      begin
        m_.First;
      end
      else
      begin
        try
          m_.Locate('ID', iGoto, []);
        except
        end;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure TfrmChannels.fillHolder;
begin
  initChannelHolder(zData);
  zData.ID := m_.FieldByName('ID').AsInteger;
  zData.active := m_['Active'];
  zData.name := m_['name'];
  zData.channelManagerId := m_['channelManagerId'];
  zData.minAlotment := m_['minAlotment'];
  zData.defaultAvailability := m_['defaultAvailability'];
  zData.defaultPricePP := m_['defaultPricePP'];
  zData.marketSegment := m_['marketSegment'];
  zData.currencyId := m_['currencyId'];
  zData.managedByChannelManager := m_['managedByChannelManager'];
  zData.CHANNEL_ARRANGES_PAYMENT := m_['CHANNEL_ARRANGES_PAYMENT'];
  zData.defaultChannel := m_['defaultChannel'];
  zData.push := m_['push'];
  zData.customerId := m_['customerId'];
  zData.color := m_['color'];
  zData.currency := m_['currency'];
  zData.roomClasses := m_['roomClasses'];
  zData.hotelsBookingEngine := m_['hotelsBookingEngine'];
  zData.compensationPercentage := m_['compensationPercentage'];
  zData.directConnection := m_['directConnection'];
  zData.Rounding := m_['rateRoundingType'];
  zData.activePlanCode := m_['activePlanCode'];
  zData.ratesExcludingTaxes := m_['ratesExcludingTaxes'];

end;

procedure TfrmChannels.changeAllowgridEdit;
begin
  tvDataID.Options.Editing := false;
  tvDataActive.Options.Editing := zAllowGridEdit;
  tvDataname.Options.Editing := zAllowGridEdit;
  tvDatachannelManagerId.Options.Editing := zAllowGridEdit;
  tvDataminAlotment.Options.Editing := zAllowGridEdit;
  tvDatadefaultAvailability.Options.Editing := zAllowGridEdit;
  tvDatadefaultPricePP.Options.Editing := zAllowGridEdit;
  tvDatamarketSegment.Options.Editing := zAllowGridEdit;
  tvDatacurrencyId.Options.Editing := zAllowGridEdit;
  tvDatamanagedByChannelManager.Options.Editing := zAllowGridEdit;
  tvDataCHANNEL_ARRANGES_PAYMENT.Options.Editing := zAllowGridEdit;
  tvDataCurrency.Options.Editing := zAllowGridEdit;
  tvDatadefaultChannel.Options.Editing := zAllowGridEdit;
  tvDatarateRoundingType.Options.Editing := zAllowGridEdit;
  tvDataroomClasses.Options.Editing := zAllowGridEdit;
  tvDatahotelsBookingEngine.Options.Editing := zAllowGridEdit;
  tvDatacompensationPercentage.Options.Editing := zAllowGridEdit;
  tvDatadirectConnection.Options.Editing := zAllowGridEdit;
  tvDataactivePlanCode.Options.Editing := zAllowGridEdit;
  tvDataratesExcludingTaxes.Options.Editing := zAllowGridEdit;

end;

procedure TfrmChannels.chkFilter;
var
  sFilter: string;
  rC1, rc2: Integer;
begin
  sFilter := edFilter.text;
  rC1 := tvData.DataController.RecordCount;
  rc2 := tvData.DataController.FilteredRecordCount;
  zFilterOn := rC1 <> rc2;
  if zFilterOn then
  begin
    labFilterWarning.Visible := true;
    labFilterWarning.color := clMoneyGreen;
    labFilterWarning.Font.Style := [fsBold]; // -C
    // labFilterWarning.caption    := shFilterOn+' - '+inttostr(rc2)+' '+shRecordsOf+' '+inttostr(rc1)+' '+shAreVisible+' ';;
    labFilterWarning.caption := format(GetTranslatedText('shFilterOnRecordsOf'),
      [rc2, rC1]);
  end
  else
  begin
    labFilterWarning.Visible := false;
  end;
end;

procedure TfrmChannels.edFilterChange(Sender: TObject);
begin
  if edFilter.text = '' then
  begin
    tvData.DataController.Filter.Root.Clear;
    tvData.DataController.Filter.active := false;
  end
  else
  begin
    applyFilter;
  end;

end;

procedure TfrmChannels.applyFilter;
begin
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvData.DataController.Filter.Root.Clear;
  tvData.DataController.Filter.Root.AddItem(tvDataname, foLike,
    '%' + edFilter.text + '%', '%' + edFilter.text + '%');
  tvData.DataController.Filter.Root.AddItem(tvDatachannelManagerId, foLike,
    '%' + edFilter.text + '%', '%' + edFilter.text + '%');
  tvData.DataController.Filter.Root.AddItem(tvDataCurrency, foLike,
    '%' + edFilter.text + '%', '%' + edFilter.text + '%');
  tvData.DataController.Filter.active := true;
end;

/// //////////////////////////////////////////////////////////
// Form actions
/// //////////////////////////////////////////////////////////

procedure TfrmChannels.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self);
  // **
  zFirstTime := true;
  zAct := actNone;
  zIsAddRow := false;
end;

procedure TfrmChannels.FormDestroy(Sender: TObject);
begin
  glb.EnableOrDisableTableRefresh('channels', True);
end;

procedure TfrmChannels.FormShow(Sender: TObject);
begin
  glb.EnableOrDisableTableRefresh('channels', False);
  // **
  panBtn.Visible := false;
  sbMain.Visible := false;
  btnClose.Visible := false;

  fillGridFromDataset(zData.ID);
  zFirstTime := true;
  sbMain.SimpleText := zSortStr;

  if zAct = actLookup then
  begin
    mnuiAllowGridEdit.Checked := false;
    panBtn.Visible := true;
  end
  else
  begin
    mnuiAllowGridEdit.Checked := true;
    btnClose.Visible := true;
    sbMain.Visible := true;
  end;
  // -C
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowgridEdit;
  chkFilter;
  zFirstTime := false;
end;

procedure TfrmChannels.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  glb.EnableOrDisableTableRefresh('channels', True);
  if tvData.DataController.DataSet.State = dsInsert then
  begin
    tvData.DataController.Post;
  end;
  if tvData.DataController.DataSet.State = dsEdit then
  begin
    tvData.DataController.Post;
  end;
  try RemoveRedundantRatesAndAvailabilities; except end;
end;

Procedure TfrmChannels.RemoveRedundantRatesAndAvailabilities;
var
  s: string;
begin
  s := 'DELETE FROM channelrates WHERE NOT roomClassId IN (SELECT roomclassId FROM channelclassrelations WHERE channelId=channelrates.channelId)';
  cmd_bySQL(s);
  s := 'DELETE FROM channelratesavailabilities WHERE NOT roomClassId IN (SELECT id FROM roomtypegroups WHERE Active)';
  cmd_bySQL(s);
end;

procedure TfrmChannels.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if zAct = actLookup then
  begin
    if Key = chr(13) then
    begin
      if activecontrol = edFilter then
      begin
      end
      else
      begin
        BtnOk.click;
      end;
    end;

    if Key = chr(27) then
    begin
      if activecontrol = edFilter then
      begin
      end
      else
      begin
        btnCancel.click;
      end;
    end;
  end;
end;

/// /////////////////////////////////////////////////////////////////////////////////////
// memory table
/// /////////////////////////////////////////////////////////////////////////////////////
function TfrmChannels.getPrevCode: string;
begin
end;

procedure TfrmChannels.m_BeforeDelete(DataSet: TDataSet);
var
  s: string;
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
  s := s + GetTranslatedText('shDeleteChannel') + ' ' + zData.name + ' '
    + chr(10);
  s := s + GetTranslatedText('shContinue');

  if MessageDlg(s, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if not Del_Channel(zData) then
    begin
      abort;
    end else
      glb.LogChanges(DataSet, 'channels', DELETE_RECORD, 'Channel ID = ' + zData.channelManagerId + ', name = ' + zData.Name);
  end
  else
  begin
    abort
  end;
end;

procedure TfrmChannels.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then
    exit;
  tvData.GetColumnByFieldName('channelManagerId').Focused := true;
end;


procedure TfrmChannels.m_BeforePost(DataSet: TDataSet);
var
  nID: Integer;
begin
  if zFirstTime then
    exit;

  initChannelHolder(zData);
  zData.ID := DataSet.FieldByName('ID').AsInteger;
  zData.active := DataSet['Active'];
  zData.name := DataSet['name'];
  zData.channelManagerId := DataSet['channelManagerId'];
  zData.minAlotment := DataSet['minAlotment'];
  zData.defaultAvailability := DataSet['defaultAvailability'];
  zData.defaultPricePP := DataSet['defaultPricePP'];
  zData.marketSegment := DataSet['marketSegment'];
  zData.currencyId := DataSet['currencyId'];
  zData.managedByChannelManager := DataSet['managedByChannelManager'];
  zData.CHANNEL_ARRANGES_PAYMENT := DataSet['CHANNEL_ARRANGES_PAYMENT'];
  zData.defaultChannel := DataSet['defaultChannel'];
  zData.push := DataSet['push'];
  zData.customerId := DataSet['customerId'];
  zData.color := DataSet['color'];
  zData.currency := DataSet['currency'];

  zData.Rounding := roundtext2Int(DataSet['rateRoundingtext']);


  zData.roomClasses := DataSet['roomClasses'];
  zData.hotelsBookingEngine := DataSet['hotelsBookingEngine'];
  zData.compensationPercentage := DataSet['compensationPercentage'];
  zData.directConnection := DataSet['directConnection'];
  zData.activePlanCode := DataSet['activePlanCode'];
  zData.ratesExcludingTaxes := DataSet['ratesExcludingTaxes'];

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    glb.LogChanges(DataSet, 'channels', CHANGE_FIELD, '');
    if UPD_Channel(zData) then
    begin
      glb.ForceTableRefresh;
    end
    else
    begin
      abort;
      exit;
    end;
  end;
  if tvData.DataController.DataSource.State = dsInsert then
  begin
    if DataSet.FieldByName('channelManagerId').AsString = '' then
    begin
      showmessage('Channel is requierd - set value or use [ESC] to cancel ');
      tvData.GetColumnByFieldName('channelManagerId').Focused := true;
      abort;
      exit;
    end;
    if ins_Channel(zData, nID) then
    begin
      glb.LogChanges(DataSet, 'channels', ADD_RECORD, 'Channel ID = ' + zData.channelManagerId + ', name = ' + zData.Name);
      glb.ForceTableRefresh;
    end
    else
    begin
      abort;
      exit;
    end;
  end;
end;

procedure TfrmChannels.m_NewRecord(DataSet: TDataSet);
var tmp : Integer;
begin
  DataSet['Active'] := false;
  DataSet['name'] := '';
  DataSet['channelManagerId'] := '';
  DataSet['minAlotment'] := 0;
  DataSet['defaultAvailability'] := 0;
  DataSet['defaultPricePP'] := 0;
  DataSet['marketSegment'] := '';
  DataSet['currencyId'] := getNativeCurrencyID();
  DataSet['currency'] := ctrlGetString('NativeCurrency');;
  DataSet['defaultChannel'] := false;
  DataSet['push'] := true;
  DataSet['customerId'] := GetCustomerId(ctrlGetString('rackCustomer'));
  DataSet['color'] := '15793151';
  DataSet['rateRoundingType']       := 1;
  DataSet['rateRoundingText']       := roundint2text(DataSet['rateRoundingType']);
  DataSet['roomClasses']            := '';
  DataSet['hotelsBookingEngine']    := false;
  DataSet['compensationPercentage'] := 0;
  DataSet['directConnection'] := False;
  DataSet['ratesExcludingTaxes'] := False;
  if glb.LocateSpecificRecord('channelplancodes', 'Code', 'PLAN') then
    DataSet['activePlanCode'] := glb.ChannelPlanCodes['ID'];

  // TcxRadioGroupProperties(tvDatarateRoundingType).DefaultValue:= 1;
  // TcxRadioGroupProperties(tvDatarateRoundingType).PrepareDisplayValue(1, aTemp, False);

end;

/// /////////////////////////////////////////////////////////////////////////////////////
// table View Functions
/// /////////////////////////////////////////////////////////////////////////////////////

procedure TfrmChannels.tvDataFocusedRecordChanged
  (Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord
  : TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  if AFocusedRecord = nil then
  begin
    zIsAddRow := true;
  end
  else
  begin
    zIsAddRow := false;
  end;
end;

procedure TfrmChannels.tvDatamarketSegmentPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var
  theData: recCustomerTypeHolder;
begin
  fillHolder;
  theData.customerType := zData.marketSegment;
  // theData.ID := zData.CurrencyID;
  openCustomerTypes(actLookup, theData);

  if theData.customerType <> '' then
  begin
    if tvData.DataController.DataSource.State <> dsInsert then
      m_.Edit;
    m_['marketSegment'] := theData.customerType;
    // m_['currencyID'] := theData.ID;
  end;
end;

procedure TfrmChannels.tvDataroomClassesPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var
  newValue: String;
begin
  newValue := LookupForDataItem('Room Classes', glb.RoomTypeGroups, 'Code',
    'Description', m_['roomClasses'], true, false, 'Active', nil, '');

//  CopyToClipboard(m_['roomClasses']);
//  DebugMessage(m_['roomClasses']);

  if newValue <> m_['roomclasses'] then
  begin
    m_.Edit;
    m_['roomClasses'] := newValue;
    d.roomerMainDataSet.SystemCorrectRoomClasses(m_['id'], newValue);
  end;
end;

procedure TfrmChannels.tvDataDblClick(Sender: TObject);
begin
  if zAct = actLookup then
  begin
    BtnOk.click
  end;
end;

/// /////////////////////////////////////////////////////////////////////////
// Filter
/// //////////////////////////////////////////////////////////////////////////


// procedure TfrmChannels2.tvDataCurrencyPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
// var
// theData : recCurrencyHolder;
// begin
/// /  fillholder;
/// /  theData.Currency := zData.Currency;
/// /  theData.ID := zData.CurrencyID;
/// /
/// /
/// /  currencies(actlookup,theData);
/// /
/// /  if theData.Currency <> '' then
/// /  begin
/// /    m_.Edit;
/// /    m_['currency']   := theData.Currency;
/// /    m_['currencyID'] := theData.ID;
/// /    m_.Post;
/// /  end;
//
// end;

procedure TfrmChannels.tvDataactivePlanCodePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  LookupForDataItem('Channel Plan Code',
                  glb.ChannelPlanCodes,
                  'Id',
                  'Description',
                  m_['activePlanCode'],
                  False,
                  True,
                  'active',
                  m_,
                  'activePlanCode');
end;

procedure TfrmChannels.tvDataCurrencyPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var
  theData: recCurrencyHolder;
begin
  fillHolder;
  theData.currency := zData.currency;
  theData.ID := zData.currencyId;
  currencies(actLookup, theData);

  if theData.currency <> '' then
  begin
    if tvData.DataController.DataSource.State <> dsInsert then
      m_.Edit;
    m_['currency'] := theData.currency;
    m_['currencyID'] := theData.ID;
  end;
end;

procedure TfrmChannels.tvDatacustomerIdPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var
  theData: recCustomerHolder;
  sCustomer : String;
begin
  fillHolder;
  sCustomer := '';
  theData.ID := zData.customerId;
  glb.LocateSpecificRecordAndGetValue('customers', 'id', zData.customerId, 'Customer', sCustomer);
  theData.Customer := sCustomer;
  openCustomers(actLookup, true, theData);

  if theData.ID <> 0 then
  begin
    if tvData.DataController.DataSource.State <> dsInsert then
      m_.Edit;
    m_['customerId'] := theData.ID;
  end;
end;

procedure TfrmChannels.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;

procedure TfrmChannels.tvDataDataControllerSortingChanged(Sender: TObject);
var
  i: Integer;
  s: string;
  serval: Boolean;
begin
  s := '';
  serval := false;
  for i := 0 to tvData.SortedItemCount - 1 do
  begin
    if serval then
      s := s + ', ';
    s := s + TcxGridDBColumn(tvData.SortedItems[i]).DataBinding.FieldName;
    serval := true;
    if tvData.SortedItems[i].SortOrder = soDescending then
      s := s + ' DESC';
  end;
  zSortStr := s;
  sbMain.SimpleText := s;
end;

/// ///////////////////////////////////////////////////////////////////////
// Buttons
/// ///////////////////////////////////////////////////////////////////////

procedure TfrmChannels.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmChannels.btnOtherClick(Sender: TObject);
begin
  // **
end;

procedure TfrmChannels.Button1Click(Sender: TObject);
begin
    EditPaymentAssuranceForChannels;
end;

procedure TfrmChannels.Button2Click(Sender: TObject);
begin
    EditChannelsEmailConfirmationMatrix;
end;

procedure TfrmChannels.Button3Click(Sender: TObject);
begin
  EditChannelsHotelEmailMatrix;
end;

procedure TfrmChannels.btnCancelClick(Sender: TObject);
begin
  initChannelHolder(zData);
end;

procedure TfrmChannels.btnClearClick(Sender: TObject);
begin
  edFilter.text := '';
end;

procedure TfrmChannels.btnCloseClick(Sender: TObject);
begin
  if m_.State IN [dsEdit, dsInsert] then
    m_.Post;
  fillHolder;
end;

procedure TfrmChannels.btnDeleteClick(Sender: TObject);
begin
  m_.Delete;
end;

procedure TfrmChannels.btnEditClick(Sender: TObject);
begin
  //**
end;

procedure TfrmChannels.btnInsertClick(Sender: TObject);
begin
  //**
end;

// ---------------------------------------------------------------------------
// Menu in other actions
// -----------------------------------------------------------------------------

procedure TfrmChannels.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then
    exit;
  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowgridEdit;
end;

procedure TfrmChannels.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.text := caption;
  grPrinter.Preview(true, prLink_grData);
end;

procedure TfrmChannels.mnuiGridToExcelClick(Sender: TObject);
var
  sFilename: string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToExcel(sFilename, grData, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil,
    sw_shownormal);
  // To export ot xlsx form then use this
  // ExportGridToXLSX(sFilename, grData, true, true, true);
  // ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xlsx'), nil, nil, sw_shownormal);
end;

procedure TfrmChannels.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename: string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil,
    sw_shownormal);
end;

procedure TfrmChannels.mnuiGridToTextClick(Sender: TObject);
var
  sFilename: string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true, ';', '', '', 'txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil,
    sw_shownormal);
end;

procedure TfrmChannels.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename: string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil,
    sw_shownormal);
end;

end.
