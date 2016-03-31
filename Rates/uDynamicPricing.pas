unit uDynamicPricing;

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
  , dxSkinscxPCPainter, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, cxCalendar, sComboBox

   ;

type
  TfrmDynamicPricing = class(TForm)
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
    StoreMain: TcxPropertiesStore;
    btnInsert: TsButton;
    btnEdit: TsButton;
    btnDelete: TsButton;
    m_ROOMTYPEGROUP_CODE: TWideStringField;
    m_Rate_Name: TWideStringField;
    m_CHANNEL_MANAGER_ID: TWideStringField;
    m_ChannelManagerName: TWideStringField;
    m_CHANNEL_ID: TWideStringField;
    m_START_DATE_RANGE: TDateField;
    m_END_DATE_RANGE: TDateField;
    m_MIN_AVAIL: TIntegerField;
    m_MAX_AVAIL: TIntegerField;
    m_RULE_PRIORITY: TIntegerField;
    m_VAL: TFloatField;
    m_APPLICATION_STRATEGY: TWideStringField;
    tvDataRecId: TcxGridDBColumn;
    tvDataROOMTYPEGROUP_CODE: TcxGridDBColumn;
    tvDataRate_Name: TcxGridDBColumn;
    tvDataCHANNEL_MANAGER_ID: TcxGridDBColumn;
    tvDataChannelManagerName: TcxGridDBColumn;
    tvDataCHANNEL_ID: TcxGridDBColumn;
    tvDataSTART_DATE_RANGE: TcxGridDBColumn;
    tvDataEND_DATE_RANGE: TcxGridDBColumn;
    tvDataMIN_AVAIL: TcxGridDBColumn;
    tvDataMAX_AVAIL: TcxGridDBColumn;
    tvDataRULE_PRIORITY: TcxGridDBColumn;
    tvDataVAL: TcxGridDBColumn;
    tvDataAPPLICATION_STRATEGY: TcxGridDBColumn;
    m_ChannelName: TWideStringField;
    tvDataChannelName: TcxGridDBColumn;
    pnlGridHolder: TsPanel;
    pnlButtons: TsPanel;
    m_HOTEL_ID: TWideStringField;
    tvDataHOTEL_ID: TcxGridDBColumn;
    cbxChannelManagers: TsComboBox;
    sLabel1: TsLabel;
    cbxChannels: TsComboBox;
    sButton1: TsButton;
    sButton2: TsButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure m_BeforeDelete(DataSet: TDataSet);
    procedure m_BeforeInsert(DataSet: TDataSet);
    procedure m_BeforePost(DataSet: TDataSet);
    procedure m_NewRecord(DataSet: TDataSet);
    procedure tvDataDblClick(Sender: TObject);
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
    procedure btnInsertClick(Sender: TObject);
    procedure tvDataROOMTYPEGROUP_CODEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cbxChannelManagersCloseUp(Sender: TObject);
    procedure tvDataCHANNEL_IDPropertiesCloseUp(Sender: TObject);
    procedure tvDataCHANNEL_MANAGER_IDPropertiesCloseUp(Sender: TObject);
  private
    { Private declarations }
    zFirstTime: Boolean;
    zAllowGridEdit: Boolean;
    zFilterOn: Boolean;
    zSortStr: string;
    zIsAddRow: Boolean;
    chManCode, channelCode, RoomClass : String;

    Procedure fillGridFromDataset;
    Procedure chkFilter;
    procedure applyFilter;
    procedure DeleteSelectedPriceRule(DataSet: TDataSet);
    procedure UpdateSelectedPriceRule(DataSet: TDataSet);
    procedure InsertSelectedPriceRule(DataSet: TDataSet);
    procedure changeAllowgridEdit;
    procedure FillCombobox;

  public
    { Public declarations }
    zAct: TActTableAction;
  end;

function openDynamicRates(act: TActTableAction; chManCode, channelCode, RoomClass : String): Boolean;

var
  frmDynamicPricing: TfrmDynamicPricing;

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
  , uDateUtils
  , uRoomTypesGroups2
  , uChannels
  , uChannelManager

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
  if atext =  'No rounding' then result := 0 else
    if atext =  'Round to nearest whole number' then result := 1 else
      if atext =  'Round up to whole number' then result := 2 else
        if atext =  'Round down to whole number' then result := 3 else
          if atext =  'Round to 1 decimal' then result := 4 else
            if atext =  'Round to 2 decimals' then result := 5 else
              if atext =  'Round to 3 decimals' then result := 6 else
                result := 0;
end;


function openDynamicRates(act: TActTableAction; chManCode, channelCode, RoomClass : String): Boolean;
begin
  result := false;
  frmDynamicPricing := TfrmDynamicPricing.Create(nil);
  try
    frmDynamicPricing.chManCode := chManCode;
    frmDynamicPricing.channelCode := channelCode;
    frmDynamicPricing.RoomClass := RoomClass;
    frmDynamicPricing.zAct := act;
    frmDynamicPricing.ShowModal;
    result := frmDynamicPricing.modalresult = mrOk;
  finally
    freeandnil(frmDynamicPricing);
  end;
end;

/// ////////////////////////////////////////////////////////////////////
{ Private declarations }
/// ////////////////////////////////////////////////////////////////////

Procedure TfrmDynamicPricing.fillGridFromDataset;
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
    s := format(SELECT_DYNAMIC_RATES(chManCode,channelCode,RoomClass), [zSortStr]);
    if rSet_bySQL(rSet, s, false) then
    begin
      if m_.active then
        m_.Close;
      m_.LoadFromDataSet(rSet);

      m_.First;
      rSet.First;
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure TfrmDynamicPricing.cbxChannelManagersCloseUp(Sender: TObject);
begin
  ApplyFilter;
end;

procedure TfrmDynamicPricing.changeAllowgridEdit;
begin
  tvDataROOMTYPEGROUP_CODE.Options.Editing := zAllowGridEdit;
  tvDataRate_Name.Options.Editing := false;
  tvDataCHANNEL_MANAGER_ID.Options.Editing := zAllowGridEdit;
  tvDataChannelManagerName.Options.Editing := false;
  tvDataCHANNEL_ID.Options.Editing := zAllowGridEdit;
  tvDataSTART_DATE_RANGE.Options.Editing := zAllowGridEdit;
  tvDataEND_DATE_RANGE.Options.Editing := zAllowGridEdit;
  tvDataMIN_AVAIL.Options.Editing := zAllowGridEdit;
  tvDataMAX_AVAIL.Options.Editing := zAllowGridEdit;
  tvDataRULE_PRIORITY.Options.Editing := zAllowGridEdit;
  tvDataVAL.Options.Editing := zAllowGridEdit;
  tvDataAPPLICATION_STRATEGY.Options.Editing := zAllowGridEdit;
  tvDataChannelName.Options.Editing := false;
end;

procedure TfrmDynamicPricing.chkFilter;
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

procedure TfrmDynamicPricing.edFilterChange(Sender: TObject);
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

procedure TfrmDynamicPricing.applyFilter;
var i : Integer;
begin
  tvData.DataController.Filter.Root.Clear;
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  if trim(edFilter.Text) <> '' then
  begin
    for i := 0 to tvData.ColumnCount - 1 do
      if tvData.Columns[i].DataBinding.ValueType = 'String' then
        tvData.DataController.Filter.Root.AddItem(tvData.Columns[i], foLike, '%'+edFilter.Text+'%', '%'+edFilter.Text+'%');
  end else
    tvData.DataController.Filter.Root.BoolOperatorKind := fboAnd;

  if cbxChannelManagers.ItemIndex > 0 then
    tvData.DataController.Filter.Root.AddItem(tvDataCHANNEL_MANAGER_ID,
                                              foEqual,
                                              cbxChannelManagers.Items[cbxChannelManagers.ItemIndex],
                                              cbxChannelManagers.Items[cbxChannelManagers.ItemIndex]);

  if cbxChannels.ItemIndex > 0 then
    tvData.DataController.Filter.Root.AddItem(tvDataCHANNEL_ID,
                                              foEqual,
                                              cbxChannels.Items[cbxChannels.ItemIndex],
                                              cbxChannels.Items[cbxChannels.ItemIndex]);
  tvData.DataController.Filter.Active := True;
end;

procedure TfrmDynamicPricing.FillCombobox;
begin
  //
  cbxChannels.Items.Clear;
  (tvDataCHANNEL_ID.Properties AS TcxComboBoxProperties).Items.Clear;
  (tvDataCHANNEL_MANAGER_ID.Properties AS TcxComboBoxProperties).Items.Clear;
  cbxChannelManagers.Items.Clear;

  cbxChannels.Items.Add('');
//  (tvDataCHANNEL_ID.Properties AS TcxComboBoxProperties).Items.Add('');
  cbxChannelManagers.Items.Add('');
//  (tvDataCHANNEL_MANAGER_ID.Properties AS TcxComboBoxProperties).Items.Add('');

  glb.ChannelsSet.First;
  while NOT glb.ChannelsSet.Eof do
  begin
    cbxChannels.Items.Add(glb.ChannelsSet['ChannelManagerId']);
    (tvDataCHANNEL_ID.Properties AS TcxComboBoxProperties).Items.Add(glb.ChannelsSet['ChannelManagerId']);
    glb.ChannelsSet.Next;
  end;

  glb.ChannelManagersSet.First;
  while NOT glb.ChannelManagersSet.Eof do
  begin
    cbxChannelManagers.Items.Add(glb.ChannelManagersSet['Code']);
    (tvDataCHANNEL_MANAGER_ID.Properties AS TcxComboBoxProperties).Items.Add(glb.ChannelManagersSet['Code']);
    glb.ChannelManagersSet.Next;
  end;
end;

/// //////////////////////////////////////////////////////////
// Form actions
/// //////////////////////////////////////////////////////////

procedure TfrmDynamicPricing.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  // **
  zFirstTime := true;
  zAct := actNone;
  zIsAddRow := false;
end;

procedure TfrmDynamicPricing.FormShow(Sender: TObject);
begin
  // **
  panBtn.Visible := false;
  sbMain.Visible := false;
  btnClose.Visible := false;

  tvDataROOMTYPEGROUP_CODE.Visible := RoomClass = '';
  tvDataRate_Name.Visible := RoomClass = '';

  tvDataCHANNEL_ID.Visible := channelCode = '';
  tvDataChannelName.Visible := channelCode = '';

  tvDataCHANNEL_MANAGER_ID.Visible := chManCode = '';
  tvDataChannelManagerName.Visible := chManCode = '';

  fillGridFromDataset;
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

  FillCombobox;
end;

procedure TfrmDynamicPricing.FormClose(Sender: TObject; var Action: TCloseAction);
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
end;

procedure TfrmDynamicPricing.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmDynamicPricing.DeleteSelectedPriceRule(DataSet: TDataSet);
var s : String;
begin
  s := 'DELETE FROM home100.DYNAMIC_PRICING_RULES ' +
       format('WHERE HOTEL_ID = ''%s'' ', [DataSet['HOTEL_ID']]) +
       format('AND ROOMTYPEGROUP_CODE = ''%s'' ', [DataSet['ROOMTYPEGROUP_CODE']]) +
       format('AND MIN_AVAIL = ''%d'' ', [DataSet['MIN_AVAIL']]) +
       format('AND MAX_AVAIL = ''%d'' ', [DataSet['MAX_AVAIL']]) +
       format('AND START_DATE_RANGE = ''%d'' ', [dateToSqlString(DataSet['START_DATE_RANGE'])]) +
       format('AND END_DATE_RANGE = ''%d'' ', [dateToSqlString(DataSet['END_DATE_RANGE'])]);
  d.roomerMainDataSet.DoCommand(s);
end;

/// /////////////////////////////////////////////////////////////////////////////////////
// memory table
/// /////////////////////////////////////////////////////////////////////////////////////

procedure TfrmDynamicPricing.m_BeforeDelete(DataSet: TDataSet);
begin
  if MessageDlg(GetTranslatedText('shDeleteDynamicPriceRule'), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    DeleteSelectedPriceRule(DataSet)
  else
    abort
end;

procedure TfrmDynamicPricing.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then
    exit;
  tvData.GetColumnByFieldName('ROOMTYPEGROUP_CODE').Focused := true;
end;


procedure TfrmDynamicPricing.UpdateSelectedPriceRule(DataSet: TDataSet);
var s, rtg : String;
    minVal, maxVal : Integer;
begin
  rtg := DataSet.FieldByName('ROOMTYPEGROUP_CODE').OldValue;
  minVal := DataSet.FieldByName('MIN_AVAIL').OldValue;
  maxVal := DataSet.FieldByName('MAX_AVAIL').OldValue;

  s := 'UPDATE home100.DYNAMIC_PRICING_RULES SET ' +

       format('ROOMTYPEGROUP_CODE = %s, ',  [_db(DataSet.FieldByName('ROOMTYPEGROUP_CODE').AsString)]) +
       format('CHANNEL_MANAGER_ID = %s, ',  [_db(DataSet.FieldByName('CHANNEL_MANAGER_ID').AsString)]) +
       format('CHANNEL_ID = %s, ',  [_db(DataSet.FieldByName('CHANNEL_ID').AsString)]) +
       format('START_DATE_RANGE = %s, ',  [_db(dateToSqlString(DataSet['START_DATE_RANGE']))]) +
       format('END_DATE_RANGE = %s, ',  [_db(dateToSqlString(DataSet['END_DATE_RANGE']))]) +
       format('MIN_AVAIL = %s, ',  [_db(DataSet.FieldByName('MIN_AVAIL').AsInteger)]) +
       format('MAX_AVAIL = %s, ',  [_db(DataSet.FieldByName('MAX_AVAIL').AsInteger)]) +

       format('RULE_PRIORITY = %s, ',  [_db(DataSet.FieldByName('RULE_PRIORITY').AsInteger)]) +
       format('APPLICATION_STRATEGY = %s, ',  [_db(DataSet.FieldByName('APPLICATION_STRATEGY').AsString)]) +
       format('VAL = %s ',  [_db(FloatToXml(DataSet.FieldByName('VAL').AsFloat, 2))]) +

       format('WHERE HOTEL_ID = %s ', [_db(DataSet.FieldByName('HOTEL_ID').asString)]) +
       format('AND ROOMTYPEGROUP_CODE = %s ', [_db(rtg)]) +
       format('AND MIN_AVAIL = %s ', [_db(minVal)]) +
       format('AND MAX_AVAIL = %s ', [_db(maxVal)]) +
       format('AND START_DATE_RANGE = %s ', [_db(dateToSqlString(DataSet.FieldByName('START_DATE_RANGE').OldValue))]) +
       format('AND END_DATE_RANGE = %s ', [_db(dateToSqlString(DataSet.FieldByName('END_DATE_RANGE').OldValue))]);
  CopyToClipboard(s);
  d.roomerMainDataSet.DoCommand(s);
end;

procedure TfrmDynamicPricing.InsertSelectedPriceRule(DataSet: TDataSet);
var s : String;
begin
  s := 'INSERT INTO home100.DYNAMIC_PRICING_RULES (' +

       'HOTEL_ID, ' +
       'ROOMTYPEGROUP_CODE, ' +
       'CHANNEL_MANAGER_ID, ' +
       'CHANNEL_ID, ' +
       'START_DATE_RANGE, ' +
       'END_DATE_RANGE, ' +
       'MIN_AVAIL, ' +
       'MAX_AVAIL, ' +
       'RULE_PRIORITY, ' +
       'APPLICATION_STRATEGY, ' +
       'VAL) VALUES (' +

       _db(d.roomerMainDataSet.hotelId) + ', ' +
       _db(DataSet.FieldByName('ROOMTYPEGROUP_CODE').AsString) + ', ' +
       _db(DataSet.FieldByName('CHANNEL_MANAGER_ID').AsString) + ', ' +
       _db(DataSet.FieldByName('CHANNEL_ID').AsString) + ', ' +
       _db(dateToSqlString(DataSet['START_DATE_RANGE'])) + ', ' +
       _db(dateToSqlString(DataSet['END_DATE_RANGE'])) + ', ' +
       _db(DataSet.FieldByName('MIN_AVAIL').AsInteger) + ', ' +
       _db(DataSet.FieldByName('MAX_AVAIL').AsInteger) + ', ' +
       _db(DataSet.FieldByName('RULE_PRIORITY').AsInteger) + ', ' +
       _db(DataSet.FieldByName('APPLICATION_STRATEGY').AsString) + ', ' +
       _db(FloatToXml(DataSet.FieldByName('VAL').AsFloat, 2)) + ') ';
  d.roomerMainDataSet.DoCommand(s);
end;

procedure TfrmDynamicPricing.m_BeforePost(DataSet: TDataSet);
var
  nID: Integer;
begin
  if zFirstTime then
    exit;

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    UpdateSelectedPriceRule(DataSet);
  end;
  if tvData.DataController.DataSource.State = dsInsert then
  begin
    InsertSelectedPriceRule(DataSet);
  end;
end;

procedure TfrmDynamicPricing.m_NewRecord(DataSet: TDataSet);
var tmp : Integer;
begin
  DataSet['HOTEL_ID'] := d.roomerMainDataSet.hotelId;
  DataSet.FieldByName('ROOMTYPEGROUP_CODE').AsString := RoomClass;
  DataSet.FieldByName('CHANNEL_MANAGER_ID').AsString := chManCode;
  DataSet.FieldByName('CHANNEL_ID').AsString := ChannelCode;
  DataSet['START_DATE_RANGE'] := TRUNC(now);
  DataSet['END_DATE_RANGE'] := TRUNC(now);
  DataSet.FieldByName('MIN_AVAIL').AsInteger := 0;
  DataSet.FieldByName('MAX_AVAIL').AsInteger := 0;
  DataSet.FieldByName('RULE_PRIORITY').AsInteger := 0;
  DataSet.FieldByName('APPLICATION_STRATEGY').AsString := '';
  DataSet.FieldByName('VAL').AsFloat := 0.00;
end;

/// /////////////////////////////////////////////////////////////////////////////////////
// table View Functions
/// /////////////////////////////////////////////////////////////////////////////////////

procedure TfrmDynamicPricing.tvDataFocusedRecordChanged
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

procedure TfrmDynamicPricing.tvDataROOMTYPEGROUP_CODEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var theData : recRoomTypeGroupHolder;
begin
  theData.id := 0;
  theData.Code := '';
  if openRoomTypeGroups(actLookup, theData) then
  begin
    if theData.Code <> '' then
    begin
      if tvData.DataController.DataSource.State <> dsInsert then m_.Edit;
      m_['ROOMTYPEGROUP_CODE'] := theData.Code;
      m_['Rate_Name'] := theData.Description;
// result := 'SELECT dpr.*, rtg.Description AS Rate_Name, cm.Description AS ChannelManagerName, ch.Name AS ChannelName ' +
    end;
  end;
end;

procedure TfrmDynamicPricing.tvDataDblClick(Sender: TObject);
begin
  if zAct = actLookup then
  begin
    BtnOk.click
  end;
end;

/// /////////////////////////////////////////////////////////////////////////
// Filter
/// //////////////////////////////////////////////////////////////////////////


procedure TfrmDynamicPricing.tvDataCHANNEL_IDPropertiesCloseUp(Sender: TObject);
var s, s1 : String;
begin
  if TcxComboBox(Sender).ItemIndex >= 0 then
  begin
    s := (tvDataCHANNEL_ID.Properties AS TcxComboBoxProperties).Items[TcxComboBox(Sender).ItemIndex];
    if glb.LocateSpecificRecordAndGetValue('channels', 'ChannelManagerId', s, 'Name', s1) then
    begin
      if tvData.DataController.DataSource.State <> dsInsert then m_.Edit;
      m_['CHANNEL_ID'] := s;
      m_['ChannelName'] := s1;
    end;
  end;
end;

procedure TfrmDynamicPricing.tvDataCHANNEL_MANAGER_IDPropertiesCloseUp(Sender: TObject);
var s, s1 : String;
begin
  if TcxComboBox(Sender).ItemIndex >= 0 then
  begin
    s := (tvDataCHANNEL_MANAGER_ID.Properties AS TcxComboBoxProperties).Items[TcxComboBox(Sender).ItemIndex];
    if glb.LocateSpecificRecordAndGetValue('channelmanagers', 'Code', s, 'Description', s1) then
    begin
      if tvData.DataController.DataSource.State <> dsInsert then m_.Edit;
      m_['CHANNEL_MANAGER_ID'] := s;
      m_['ChannelManagerName'] := s1;
    end;
  end;
end;

procedure TfrmDynamicPricing.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;

procedure TfrmDynamicPricing.tvDataDataControllerSortingChanged(Sender: TObject);
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

procedure TfrmDynamicPricing.btnOtherClick(Sender: TObject);
begin
  // **
end;

procedure TfrmDynamicPricing.btnClearClick(Sender: TObject);
begin
  cbxChannelManagers.ItemIndex := -1;
  cbxChannels.ItemIndex := -1;
  if edFilter.Text <> '' then
    edFilter.text := ''
  else
    applyFilter;
end;

procedure TfrmDynamicPricing.btnCloseClick(Sender: TObject);
begin
  if m_.State IN [dsEdit, dsInsert] then
    m_.Post;
end;

procedure TfrmDynamicPricing.btnDeleteClick(Sender: TObject);
begin
  m_.Delete;
end;

procedure TfrmDynamicPricing.btnEditClick(Sender: TObject);
begin
  //**
end;

procedure TfrmDynamicPricing.btnInsertClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  if m_.Active = false then m_.Open;
  grData.SetFocus;
  m_.Insert;
  tvData.GetColumnByFieldName('ROOMTYPEGROUP_CODE').Focused := True;
end;

// ---------------------------------------------------------------------------
// Menu in other actions
// -----------------------------------------------------------------------------

procedure TfrmDynamicPricing.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then
    exit;
  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowgridEdit;
end;

procedure TfrmDynamicPricing.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.text := caption;
  grPrinter.Preview(true, prLink_grData);
end;

procedure TfrmDynamicPricing.mnuiGridToExcelClick(Sender: TObject);
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

procedure TfrmDynamicPricing.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename: string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil,
    sw_shownormal);
end;

procedure TfrmDynamicPricing.mnuiGridToTextClick(Sender: TObject);
var
  sFilename: string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true, ';', '', '', 'txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil,
    sw_shownormal);
end;

procedure TfrmDynamicPricing.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename: string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil,
    sw_shownormal);
end;

end.
