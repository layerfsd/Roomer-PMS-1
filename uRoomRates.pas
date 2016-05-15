unit uRoomRates;

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
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxButtonEdit, cxCalendar, cxLabel, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter,
  cxPropertiesStore, dxmdaset, sCheckBox, Vcl.Mask, sMaskEdit, sCustomComboEdit, sTooledit, AdvCombo, ColCombo, sGroupBox,
  dxPScxPivotGridLnk, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld



  ;

type
  TfrmRoomRates = class(TForm)
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
    m_PriceCodeID: TIntegerField;
    m_RateID: TIntegerField;
    m_SeasonID: TIntegerField;
    m_Active: TBooleanField;
    m_DateFrom: TDateTimeField;
    m_DateTo: TDateTimeField;
    m_Description: TWideStringField;
    m_RoomType: TWideStringField;
    m_RoomTypeID: TIntegerField;
    m_CurrencyID: TIntegerField;
    m_pcCode: TWideStringField;
    m_pcRack: TBooleanField;
    m_Currency: TWideStringField;
    m_seStartDate: TDateTimeField;
    m_seEndDate: TDateTimeField;
    m_seDescription: TWideStringField;
    m_NumberGuests: TIntegerField;
    m_RateCurrency: TWideStringField;
    m_Rate1Person: TFloatField;
    m_Rate2Person: TFloatField;
    m_Rate3Persons: TFloatField;
    m_Rate5Persons: TFloatField;
    m_Rate6Persons: TFloatField;
    m_RateExtraPerson: TFloatField;
    m_RateExtraChildren: TFloatField;
    m_RateExtraInfant: TFloatField;
    tvDataRecId: TcxGridDBColumn;
    tvDataID: TcxGridDBColumn;
    tvDataPriceCodeID: TcxGridDBColumn;
    tvDatapcCode: TcxGridDBColumn;
    tvDatapcRack: TcxGridDBColumn;
    tvDataCurrencyID: TcxGridDBColumn;
    tvDataCurrency: TcxGridDBColumn;
    tvDataSeasonID: TcxGridDBColumn;
    tvDataseStartDate: TcxGridDBColumn;
    tvDataseEndDate: TcxGridDBColumn;
    tvDataseDescription: TcxGridDBColumn;
    tvDataRoomTypeID: TcxGridDBColumn;
    tvDataRoomType: TcxGridDBColumn;
    tvDataNumberGuests: TcxGridDBColumn;
    tvDataActive: TcxGridDBColumn;
    tvDataDateFrom: TcxGridDBColumn;
    tvDataDateTo: TcxGridDBColumn;
    tvDataDescription: TcxGridDBColumn;
    tvDataRateID: TcxGridDBColumn;
    tvDataRateCurrency: TcxGridDBColumn;
    tvDataRate3Persons: TcxGridDBColumn;
    tvDataRate5Persons: TcxGridDBColumn;
    tvDataRate6Persons: TcxGridDBColumn;
    tvDataRateExtraPerson: TcxGridDBColumn;
    tvDataRateExtraChildren: TcxGridDBColumn;
    tvDataRateExtraInfant: TcxGridDBColumn;
    m_Rate4Persons: TFloatField;
    tvDataRate4Persons: TcxGridDBColumn;
    gbxFilter: TsGroupBox;
    cbxPriceCodes: TColumnComboBox;
    cbxCurrencies: TColumnComboBox;
    btnInsert: TsButton;
    btnEdit: TsButton;
    tvDataRate1Person: TcxGridDBColumn;
    tvDataRate2Persons: TcxGridDBColumn;
    dtFrom: TsDateEdit;
    dtTo: TsDateEdit;
    sSpeedButton1: TsSpeedButton;
    labSeason: TsLabel;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sLabel3: TsLabel;
    chkActive: TsCheckBox;
    btnRefresh: TsButton;
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
    procedure tvDatapcCodePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvDataRoomTypePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvDataseDescriptionPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvDataDescriptionPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure sSpeedButton1Click(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
    procedure dtFromChange(Sender: TObject);
    procedure dtToChange(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure cbxPriceCodesCloseUp(Sender: TObject);
    procedure cbxCurrenciesCloseUp(Sender: TObject);
    procedure dtToCloseUp(Sender: TObject);
    procedure dtFromCloseUp(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    zFirstTime       : boolean;
    zAllowGridEdit   : boolean;
    zFilterOn        : boolean;
    zSortStr         : string;
    zIsAddRow        : boolean;

    zRackPriceCodeID   : integer;

    zPriceCodeID  : integer;
    zRateID       : integer;
    zSeasonId     : integer;
    zRoomTypeID   : integer;
    zCurrencyID   : integer;
    zDateFrom     : Tdate;
    zDateTo       : Tdate;

    Procedure fillGridFromDataset(iGoto : integer);
    procedure fillHolder;
    procedure changeAllowgridEdit;
    function getPrevCode : string;
    Procedure chkFilter;
    procedure applyFilter;
    function getDefaults(PriceCodeID, RateID, SeasonId, RoomTypeID, CurrencyID : integer ) : recwRoomRateHolder;

    procedure FillPriceCodesBOX(box : TcolumnComboBox;All:boolean; defID : integer);
    procedure FillCurrenciesBOX(box : TcolumnComboBox;All:boolean; defID : integer);

  public
    { Public declarations }
    zAct   : TActTableAction;
    zData  : recwRoomRateHolder;
  end;

function RoomRates(act : TActTableAction; var theData : recwRoomRateHolder) : boolean;


var
  frmRoomRates: TfrmRoomRates;

implementation

{$R *.dfm}

uses
    uD
  , prjConst
  , uSqlDefinitions
  , uCurrencies
  , uPriceCodes
  , uRoomTypes2
  , uSeasons2
  , uRates
  , uUtils
  ;



//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function roomRates(act : TActTableAction; var theData : recwRoomRateHolder) : boolean;
begin
  result := false;
  frmRoomRates := TfrmRoomRates.Create(frmRoomRates);
  try
    frmRoomRates.zData := theData;
    frmRoomRates.zAct := act;
    frmRoomRates.ShowModal;
    if frmRoomRates.modalresult = mrOk then
    begin
      theData := frmRoomRates.zData;
      result := true;
    end
    else
    begin
      initwRoomRateHolder(theData);
    end;
  finally
    freeandnil(frmRoomRates);
  end;
end;


///////////////////////////////////////////////////////////////////////
                    { Private declarations }
///////////////////////////////////////////////////////////////////////

function sql(pcCodeID, CurrencyID : integer; dateFrom, dateTo : TdateTime; active : boolean; orderBY : string) : string;
var
  s : string;
begin
  result := '';
  s := s+' SELECT '#10;
  s := s+'   ID '#10;
  s := s+'  ,PriceCodeID '#10;
  s := s+'  ,pcCode '#10;
  s := s+'  ,pcRack '#10;
  s := s+'  ,CurrencyID '#10;
  s := s+'  ,Currency '#10;
  s := s+'  ,SeasonID '#10;
  s := s+'  ,seStartDate '#10;
  s := s+'  ,seEndDate '#10;
  s := s+'  ,seDescription '#10;
  s := s+'  ,RoomTypeID '#10;
  s := s+'  ,RoomType '#10;
  s := s+'  ,NumberGuests '#10;
  s := s+'  ,RateID '#10;
  s := s+'  ,RateCurrency '#10;
  s := s+'  ,Rate1Person '#10;
  s := s+'  ,Rate2Persons '#10;
  s := s+'  ,Rate3Persons '#10;
  s := s+'  ,Rate4Persons '#10;
  s := s+'  ,Rate5Persons '#10;
  s := s+'  ,Rate6Persons '#10;
  s := s+'  ,RateExtraPerson '#10;
  s := s+'  ,RateExtraChildren '#10;
  s := s+'  ,RateExtraInfant '#10;
  s := s+'  ,DateCreated '#10;
  s := s+'  ,LastModified '#10;
  s := s+'  ,Description '#10;
  s := s+'  ,Active '#10;
  s := s+'  ,DateFrom '#10;
  s := s+'  ,DateTo '#10;
  s := s+' FROM '#10;
  s := s+'   wroomrates '#10;
  s := s+' WHERE  '#10;
  s := s+'  (active =  '+_db(active)+' ) '#10;
  s := s+' AND ( '#10;
  s := s+'  ((DateFrom >='+_db(dateFrom)+') AND (DateFrom <=  '+_db(dateTo)+'))'#10;
  s := s+'  OR ((DateTO >='+_db(dateFrom)+') AND (DateTO <=  '+_db(dateTO)+'))'#10;
  s := s+' ) '#10;  //_db(aDate)
  if PcCodeID > 0 then
  begin
    s := s+' AND (PriceCodeID = '+_db(PcCodeID)+' ) '#10;
  end;
  if CurrencyID > 0 then
  begin
    s := s+' AND (currencyID =  '+_db(currencyID)+' ) '#10;
  end;
  s := s+' ORDER BY '#10;
  s := s+' '+orderBy+' ';
  result := s;
end;


procedure TfrmRoomRates.FillPriceCodesBOX(box : TcolumnComboBox;All:boolean; defID : Integer);
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
    box.ComboItems.Items[0].Strings.add('All PriceTypes');
    i := 0;
  end else i := -1;

  rSet := CreateNewDataSet;
  try
    s := format(select_RoomPrices_FillPriceCodesBOX , []);
    hData.rSet_bySQL(rSet,s);

    while not rSet.eof do
    begin
      inc(i);
      Code        := rSet.fieldbyname('pcCode').asString;
      Description := rSet.fieldbyname('pcDescription').asstring;
      ID          := rSet.fieldbyname('ID').asInteger;
      if ID = defID then ii := i;
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
    freeandnil(rSet);
  end;
end;


procedure TfrmRoomRates.cbxPriceCodesCloseUp(Sender: TObject);
var
  idx : integer;
  aCode : string;
begin
  idx := cbxPriceCodes.ItemIndex;
  if idx = 0 then
  begin
    zPriceCodeID := 0;
    aCode := '';
  end else
  begin
    aCode := cbxPriceCodes.ComboItems[idx].Strings[0];
    zPriceCodeID := PriceCode_ID(aCode);
  end;
  btnRefresh.Click;
end;



procedure TfrmRoomRates.FillCurrenciesBOX(box : TcolumnComboBox;All:boolean; defID : integer);
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


procedure TfrmRoomRates.cbxCurrenciesCloseUp(Sender: TObject);
var
  idx : integer;
  aCode : string;
begin
  idx := cbxCurrencies.ItemIndex;
  if idx = 0 then
  begin
    zCurrencyID := 0;
    aCode := '';
  end else
  begin
    aCode := cbxCurrencies.ComboItems[idx].Strings[0];
    zCurrencyID := GET_IdByCurrency(aCode);
  end;
  btnRefresh.Click;
end;



Procedure TfrmRoomRates.fillGridFromDataset(iGoto : integer);
var
  s      : string;
  rSet   : TRoomerDataSet;
  active : boolean;
begin
  m_.Close;
  active := chkActive.checked;

  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'ID';
  rSet := CreateNewDataSet;
  try
    s := sql(zPriceCodeID, zCurrencyID,zDateFrom, zDateTo,chkactive.checked,zSortStr);

//    if Active then
//    begin
//      s := format(select_wRoomRates_justActive, [1,zSortStr]);
//    end else
//    begin
//      s := format(select_wRoomRates, [zSortStr]);
//    end;

    if rSet_bySQL(rSet,s) then
    begin
      if m_.active then m_.Close;
      m_.LoadFromDataSet(rSet);
      if iGoto = 0 then
      begin
        m_.First;
      end else
      begin
        try
          m_.Locate('ID',iGoto,[]);
        except
        end;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
  tvData.ApplyBestFit();
end;

procedure TfrmRoomRates.fillHolder;
begin
  initwRoomRateHolder(zData);
  zData.ID                := m_.FieldByName('ID').AsInteger;
  zData.PriceCodeID       := m_['PriceCodeID'];
  zData.pcCode            := m_['pcCode'];
  zData.pcRack            := m_['pcRack'];
  zData.CurrencyID        := m_['CurrencyID'];
  zData.Currency          := m_['Currency'];
  zData.SeasonID          := m_['SeasonID'];
  zData.seStartDate       := m_['seStartDate'];
  zData.seEndDate         := m_['seEndDate'];
  zData.seDescription     := m_['seDescription'];
  zData.RoomTypeID        := m_['RoomTypeID'];
  zData.RoomType          := m_['RoomType'];
  zData.NumberGuests      := m_['NumberGuests'];
  zData.RateID            := m_['RateID'];
  zData.RateCurrency      := m_['RateCurrency'];
  zData.Rate1Person       := m_['Rate1Person'];
  zData.Rate2Persons      := m_['Rate2Persons'];
  zData.Rate3Persons      := m_['Rate3Persons'];
  zData.Rate4Persons      := m_['Rate4Persons'];
  zData.Rate5Persons      := m_['Rate5Persons'];
  zData.Rate6Persons      := m_['Rate6Persons'];
  zData.RateExtraPerson   := m_['RateExtraPerson'];
  zData.RateExtraChildren := m_['RateExtraChildren'];
  zData.RateExtraInfant   := m_['RateExtraInfant'];
  zData.Description       := m_['Description'];
  zData.Active            := m_['Active'];
  zData.DateFrom          := m_['DateFrom'];
  zData.DateTo            := m_['DateTo'];
end;




procedure TfrmRoomRates.changeAllowgridEdit;
begin
  if zAllowGridEdit then
  begin
    tvDataID.Options.Editing               := false;
    tvDataActive           .Options.Editing           := true;
    tvDataPriceCodeID      .Options.Editing          := true;
    tvDatapcCode           .Options.Editing          := true;
    tvDatapcRack           .Options.Editing          := true;
    tvDataCurrencyID       .Options.Editing          := true;
    tvDataCurrency         .Options.Editing          := true;
    tvDataSeasonID         .Options.Editing          := true;
    tvDataseStartDate      .Options.Editing          := true;
    tvDataseEndDate        .Options.Editing          := true;
    tvDataseDescription    .Options.Editing          := true;
    tvDataRoomTypeID       .Options.Editing          := true;
    tvDataRoomType         .Options.Editing          := true;
    tvDataNumberGuests     .Options.Editing          := true;
    tvDataRateID           .Options.Editing          := true;
    tvDataRateCurrency     .Options.Editing          := true;
    tvDataRate1Person      .Options.Editing          := true;
    tvDataRate2Persons     .Options.Editing          := true;
    tvDataRate3Persons     .Options.Editing          := true;
    tvDataRate4Persons     .Options.Editing          := true;
    tvDataRate5Persons     .Options.Editing          := true;
    tvDataRate6Persons     .Options.Editing          := true;
    tvDataRateExtraPerson  .Options.Editing          := true;
    tvDataRateExtraChildren.Options.Editing          := true;
    tvDataRateExtraInfant  .Options.Editing          := true;
    tvDataDescription      .Options.Editing          := true;
    tvDataActive           .Options.Editing          := true;
    tvDataDateFrom         .Options.Editing          := true;
    tvDataDateTo           .Options.Editing          := true;

  end else
  begin
    tvDataID.Options.Editing               := false;
    tvDataActive           .Options.Editing           := true;
    tvDataPriceCodeID      .Options.Editing          := false;
    tvDatapcCode           .Options.Editing          := false;
    tvDatapcRack           .Options.Editing          := false;
    tvDataCurrencyID       .Options.Editing          := false;
    tvDataCurrency         .Options.Editing          := false;
    tvDataSeasonID         .Options.Editing          := false;
    tvDataseStartDate      .Options.Editing          := false;
    tvDataseEndDate        .Options.Editing          := false;
    tvDataseDescription    .Options.Editing          := false;
    tvDataRoomTypeID       .Options.Editing          := false;
    tvDataRoomType         .Options.Editing          := false;
    tvDataNumberGuests     .Options.Editing          := false;
    tvDataRateID           .Options.Editing          := false;
    tvDataRateCurrency     .Options.Editing          := false;
    tvDataRate1Person      .Options.Editing          := false;
    tvDataRate2Persons     .Options.Editing          := false;
    tvDataRate3Persons     .Options.Editing          := false;
    tvDataRate4Persons     .Options.Editing          := false;
    tvDataRate5Persons     .Options.Editing          := false;
    tvDataRate6Persons     .Options.Editing          := false;
    tvDataRateExtraPerson  .Options.Editing          := false;
    tvDataRateExtraChildren.Options.Editing          := false;
    tvDataRateExtraInfant  .Options.Editing          := false;
    tvDataDescription      .Options.Editing          := false;
    tvDataActive           .Options.Editing          := false;
    tvDataDateFrom         .Options.Editing          := false;
    tvDataDateTo           .Options.Editing          := false;
  end;
end;


procedure TfrmRoomRates.chkActiveClick(Sender: TObject);
var
  igoto : integer;
begin
  iGoTo := m_.FieldByName('ID').AsInteger;
  fillGridFromDataset(iGoto);
  zFirstTime := false;
end;

procedure TfrmRoomRates.chkFilter;
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


procedure TfrmRoomRates.dtFromChange(Sender: TObject);
begin
  if dtFrom.Date > dtTo.date then dtTo.Date := dtFrom.date;
  zDateFrom := dtFrom.Date;
  zDateTo := dtTo.Date;
end;

procedure TfrmRoomRates.dtFromCloseUp(Sender: TObject);
begin
  btnRefresh.Click;
end;

procedure TfrmRoomRates.dtToChange(Sender: TObject);
begin
  if dtTo.Date < dtFrom.date then dtFrom.Date := dtTo.date;
  zDateFrom := dtFrom.Date;
  zDateTo := dtTo.Date;
end;

procedure TfrmRoomRates.dtToCloseUp(Sender: TObject);
begin
  btnRefresh.Click;
end;

procedure TfrmRoomRates.edFilterChange(Sender: TObject);
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

procedure TfrmRoomRates.applyFilter;
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

procedure TfrmRoomRates.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  //**
  zFirstTime  := true;
  zAct        := actNone;
  zisAddrow   := false;
end;

procedure TfrmRoomRates.FormShow(Sender: TObject);
var
  seasonHolder : recSeasonHolder;
begin
//**
  panBtn.Visible   := False;
  sbMain.Visible   := false;

  zPriceCodeID  := PriceCodes_GETRack();
  zCurrencyID   := getNativeCurrencyID();
  zRateID       := 0;  //0

  zSeasonId         := d.FindSeasonID(now);
  seasonHolder      := seasonHolderByID(zSeasonId );
  dtFrom.Date       := seasonHolder.seStartDate;
  dtTo.Date         := seasonHolder.seEndDate;
  labSeason.Caption := seasonHolder.seDescription;

  zRoomTypeID   := 0;  //

  FillPriceCodesBOX(cbxPriceCodes,true,zPriceCodeID);
  FillCurrenciesBOX(cbxCurrencies,true, zCurrencyID);

  fillGridFromDataset(zData.ID);
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

procedure TfrmRoomRates.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TfrmRoomRates.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    btnCancel.Click;

end;

procedure TfrmRoomRates.FormKeyPress(Sender: TObject; var Key: Char);
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
function TfrmRoomRates.getPrevCode: string;
begin
end;

procedure TfrmRoomRates.m_BeforeDelete(DataSet: TDataSet);
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
    if not Del_RoomRate(zData) then
    begin
      abort;
    end
  end else
  begin
    abort
  end;
end;

procedure TfrmRoomRates.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('RoomType').Focused := True;
end;


procedure TfrmRoomRates.m_BeforePost(DataSet: TDataSet);
var
  nID : integer;
begin
  if zFirstTime then exit;

  initwRoomRateHolder(zData);
  zData.ID                := dataset.FieldByName('ID').AsInteger;
  zData.PriceCodeID       := dataset['PriceCodeID'];
  zData.pcCode            := dataset['pcCode'];
  zData.pcRack            := dataset['pcRack'];
  zData.CurrencyID        := dataset['CurrencyID'];
  zData.Currency          := dataset['Currency'];
  zData.SeasonID          := dataset['SeasonID'];
  zData.seStartDate       := dataset['seStartDate'];
  zData.seEndDate         := dataset['seEndDate'];
  zData.seDescription     := dataset['seDescription'];
  zData.RoomTypeID        := dataset['RoomTypeID'];
  zData.RoomType          := dataset['RoomType'];
  zData.NumberGuests      := dataset['NumberGuests'];
  zData.RateID            := dataset['RateID'];
  zData.RateCurrency      := dataset['RateCurrency'];
  zData.Rate1Person       := dataset['Rate1Person'];
  zData.Rate2Persons      := dataset['Rate2Persons'];
  zData.Rate3Persons      := dataset['Rate3Persons'];
  zData.Rate4Persons      := dataset['Rate4Persons'];
  zData.Rate5Persons      := dataset['Rate5Persons'];
  zData.Rate6Persons      := dataset['Rate6Persons'];
  zData.RateExtraPerson   := dataset['RateExtraPerson'];
  zData.RateExtraChildren := dataset['RateExtraChildren'];
  zData.RateExtraInfant   := dataset['RateExtraInfant'];
  zData.Description       := dataset['Description'];
  zData.Active            := dataset['Active'];
  zData.DateFrom          := dataset['DateFrom'];
  zData.DateTo            := dataset['DateTo'];
//  zData.DateCreated       := dataset['DateCreated'];
//  zData.LastModified      := dataset['LastModified'];

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if UPD_roomRate(zData) then
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
//    if dataset.FieldByName('Description').AsString = ''  then
//    begin
//      showmessage('Description is requierd - set value or use [ESC] to cancel ');
//      tvData.GetColumnByFieldName('Description').Focused := True;
//      abort;
//      exit;
//    end;
    if ins_roomRate(zData,nID) then
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


function TfrmRoomRates.getDefaults(PriceCodeID, RateID, SeasonId, RoomTypeID, CurrencyID : integer ) : recwRoomRateHolder;
var
  lstRSets : TRoomerDataSetList;
  queries : TList<String>;

  s,
  sql : string;
  i : integer;
begin

  initwRoomRateHolder(result);

  queries := TList<String>.Create;
  lstRSets := TRoomerDataSetList.Create(True);
  try

    queries.Add(format(
      'SELECT '#10+
      '   ID '#10 +
      '  ,pcCode '#10 +
      '  ,pcRack '#10 +
      ' FROM '#10 +
      '   tblpricecodes '#10 +
      ' WHERE '#10 +
      '   ID = %d ',
      [PriceCodeID]));
    lstRSets.Add(d.roomerMainDataSet.CreateNewDataset);

    queries.Add(format(
    'SELECT '#10+
    '   ID '#10+
    '  ,Currency '#10+
    ' FROM '#10+
    '   currencies '#10+
    ' WHERE '#10+
    '   ID = %d ',
    [currencyID]));
    lstRSets.Add(d.roomerMainDataSet.CreateNewDataset);


//    queries.Add(format(
//    'SELECT '#10+
//    '   ID '#10+
//    '  ,seStartDate '#10+
//    '  ,seEndDate '#10+
//    '  ,seDescription '#10+
//    ' FROM '#10+
//    '   tblseasons '#10+
//    ' WHERE '#10+
//    '   ID = %d ',
//    [seasonID]));
//    lstRSets.Add(d.roomerMainDataSet.CreateNewDataset);



//    queries.Add(format(
//    'SELECT '#10+
//    '   ID '#10+
//    '  ,RoomType '#10+
//    '  ,NumberGuests '#10+
//    ' FROM '#10+
//    '   roomtypes '#10+
//    ' WHERE '#10+
//    '   ID = %d ',
//    [roomtypeID]));
//    lstRSets.Add(d.roomerMainDataSet.CreateNewDataset);


//    queries.Add(format(
//    ' SELECT '#10+
//    '   ID '#10+
//    '  ,Currency AS rateCurrency '#10+
//    '  ,Rate1Person '#10+
//    '  ,Rate2Persons '#10+
//    '  ,Rate3Persons '#10+
//    '  ,Rate4Persons '#10+
//    '  ,Rate5Persons '#10+
//    '  ,Rate6Persons '#10+
//    '  ,RateExtraPerson '#10+
//    '  ,RateExtraChildren '#10+
//    '  ,RateExtraInfant '#10+
//    ' FROM '#10+
//    '   rates '#10+
//    ' WHERE '#10+
//    '   ID = %d ',
//    [rateID]));
//    lstRSets.Add(d.roomerMainDataSet.CreateNewDataset);

    d.roomerMainDataSet.SystemFreeMultipleQuery(lstRSets,queries);
    //tblpricecodes
    with lstRSets[0] do
    begin
      First;
      if not eof then
      begin
        zData.PriceCodeID       := lstRSets[0]['ID'];
        zData.pcCode            := lstRSets[0]['pcCode'];
        zData.pcRack            := lstRSets[0]['pcRack'];
      end;
    end;

    //Currencies
    with lstRSets[1] do
    begin
      First;
      if not eof then
      begin
        zData.CurrencyID        := lstRSets[1]['ID'];
        zData.Currency          := lstRSets[1]['Currency'];
      end;
    end;

//    //Seasons
//    with lstRSets[2] do
//    begin
//      First;
//      if not eof then
//      begin
//        zData.SeasonID          := lstRSets[2]['ID'];
//        zData.seStartDate       := lstRSets[2]['seStartDate'];
//        zData.seEndDate         := lstRSets[2]['seEndDate'];
//        zData.seDescription     := lstRSets[2]['seDescription'];
//      end;
//    end;
//
//    //RoomTypes
//    with lstRSets[3] do
//    begin
//      First;
//      if not eof then
//      begin
//        zData.RoomTypeID        := lstRSets[3]['ID'];
//        zData.RoomType          := lstRSets[3]['RoomType'];
//        zData.NumberGuests      := lstRSets[3]['NumberGuests'];
//      end;
//    end;

//    //Rates
//    with lstRSets[4] do
//    begin
//      First;
//      if not eof then
//      begin
//        zData.RateID            := lstRSets[4]['ID'];
//        zData.RateCurrency      := lstRSets[4]['RateCurrency'];
//        zData.Rate1Person       := lstRSets[4]['Rate1Person'];
//        zData.Rate2Persons      := lstRSets[4]['Rate2Persons'];
//        zData.Rate3Persons      := lstRSets[4]['Rate3Persons'];
//        zData.Rate4Persons      := lstRSets[4]['Rate4Persons'];
//        zData.Rate5Persons      := lstRSets[4]['Rate5Persons'];
//        zData.Rate6Persons      := lstRSets[4]['Rate6Persons'];
//        zData.RateExtraPerson   := lstRSets[4]['RateExtraPerson'];
//        zData.RateExtraChildren := lstRSets[4]['RateExtraChildren'];
//        zData.RateExtraInfant   := lstRSets[4]['RateExtraInfant'];
//      end;
//    end;

  finally
    FreeAndNil(lstRSets);
    freeAndNil(queries);
  end;

//  zData.DateFrom := zData.seStartDate;
//  zData.DateTo   := zData.seEndDate;
  result := zData;
end;

procedure TfrmRoomRates.m_NewRecord(DataSet: TDataSet);
var
  seasonHolder    : recSeasonHolder;
  currency : string;
begin
  if zFirstTime then exit;
  seasonHolder      := seasonHolderByID(zSeasonId );
  currency := GET_CurrencyByID(zCurrencyID);                ;

  dataset['PriceCodeID']       := zPriceCodeID               ;
  dataset['pcCode']            := PriceCode_Code(zPriceCodeID) ;
  dataset['pcRack']            := false                      ;
  dataset['CurrencyID']        := zCurrencyID                ;
  dataset['Currency']          := currency                   ;
  dataset['SeasonID']          := zSeasonID                  ;
  dataset['seStartDate']       := seasonHolder.seStartDate   ;
  dataset['seEndDate']         := seasonHolder.seEndDate     ;
  dataset['seDescription']     := seasonHolder.seDescription ;
  dataset['RoomTypeID']        := 0    ;
  dataset['RoomType']          := ''   ;
  dataset['NumberGuests']      := 0    ;

  dataset['RateID']            := 0;
  dataset['RateCurrency']      := 0;
  dataset['Rate1Person']       := 0;
  dataset['Rate2Persons']      := 0;
  dataset['Rate3Persons']      := 0;
  dataset['Rate4Persons']      := 0;
  dataset['Rate5Persons']      := 0;
  dataset['Rate6Persons']      := 0;
  dataset['RateExtraPerson']   := 0;
  dataset['RateExtraChildren'] := 0;
  dataset['RateExtraInfant']   := 0;
  dataset['Description']       := '';
  dataset['Active']            := true;           ;
  dataset['DateFrom']          := seasonHolder.seStartDate         ;
  dataset['DateTo']            := seasonHolder.seEndDate    ;
end;

////////////////////////////////////////////////////////////////////////////////////////
//  table View Functions
////////////////////////////////////////////////////////////////////////////////////////


procedure TfrmRoomRates.tvDataDescriptionPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_.fieldbyname('Description').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
//  errortext := 'Description '+' - '+'is required - Use ESC to cancel';
	errortext := GetTranslatedText('shTx_RoomRates_DescriptionIsRequired');
    exit;
  end;

  if hdata.RoomrateDescriptionExist(displayValue) then
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


procedure TfrmRoomRates.tvDataFocusedRecordChanged(
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


/////////////////////////////////////////////////////////////////////////////////////////////////
/// GET From tables
///


//GET PricsCode
procedure TfrmRoomRates.tvDatapcCodePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recPriceCodeHolder;
begin
  fillholder;
  theData.pcCode := zData.pcCode;
  priceCodes(actlookup,theData);
  if theData.pcCode <> '' then
  begin
    if tvData.DataController.DataSource.State <> dsInsert then m_.Edit;
    m_['pcCode']   := theData.pcCode;
    m_['priceCodeID'] := theData.ID;
//    m_.Post;
  end;
end;

//Get RoomType
procedure TfrmRoomRates.tvDataRoomTypePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recRoomTypeHolder;
begin
  fillholder;
  theData.RoomType := zData.RoomType;
  openroomtypes(actlookup,theData);
  if theData.roomType <> '' then
  begin
    if tvData.DataController.DataSource.State <> dsInsert then m_.Edit;
    m_['roomType']   := theData.roomType;
    m_['roomTypeID'] := theData.ID;
//    m_.Post;
  end;
end;

//Get Season
procedure TfrmRoomRates.tvDataseDescriptionPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recSeasonHolder;
begin
  fillholder;
  theData.seDescription := zData.seDescription;
  openSeasons(actlookup,theData);
  if theData.seDescription <> '' then
  begin
    if tvData.DataController.DataSource.State <> dsInsert then m_.Edit;
    m_['seDescription']   := theData.seDescription;
    m_['seasonID'] := theData.ID;
    m_['seStartDate'] := theData.seStartDate;
    m_['seEndDate'] := theData.seEndDate;
    m_['dateFrom'] := theData.seStartDate;
    m_['dateTo'] := theData.seEndDate;
//    m_.Post;
  end;
end;

procedure TfrmRoomRates.sSpeedButton1Click(Sender: TObject);
var
  theData : recSeasonHolder;
begin
  openSeasons(actlookup,theData);
  if theData.seDescription <> '' then
  begin
    zSeasonId := theData.ID;
    dtFrom.date := theData.seStartDate;
    dtTo.Date := theData.seEndDate;
    labSeason.Caption := theData.seDescription;
    btnRefresh.Click;
  end;
end;


//Get Currency
procedure TfrmRoomRates.tvDataCurrencyPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
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
//    m_.Post;
  end;
end;

//Get Price
procedure TfrmRoomRates.tvDataDescriptionPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recRateHolder;
begin
  fillholder;
  theData.Currency := zData.currency;
  theData.Description := zData.seDescription;
  Rates(actlookup,theData);
  if theData.Description <> '' then
  begin
    if tvData.DataController.DataSource.State <> dsInsert then m_.Edit;
    m_['Description']       := theData.Description;
    m_['rateID']            := theData.ID;
    m_['Rate1Person']       := theData.Rate1Person;
    m_['Rate2Persons']      := theData.Rate2Persons;
    m_['Rate3Persons']      := theData.Rate3Persons;
    m_['Rate4Persons']      := theData.Rate4Persons;
    m_['Rate5Persons']      := theData.Rate5Persons;
    m_['Rate6Persons']      := theData.Rate6Persons;
    m_['RateExtraPerson']   := theData.RateExtraPerson;
    m_['RateExtraChildren'] := theData.RateExtraChildren;
    m_['RateExtraInfant']   := theData.RateExtraInfant;
//    m_.Post;
  end;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmRoomRates.tvDataDblClick(Sender: TObject);
begin
  if ZAct = actLookup then
  begin
    btnOK.Click
  end;
end;


////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////


procedure TfrmRoomRates.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;


procedure TfrmRoomRates.tvDataDataControllerSortingChanged(Sender: TObject);
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


procedure TfrmRoomRates.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmRoomRates.btnOtherClick(Sender: TObject);
begin
  //**
end;

procedure TfrmRoomRates.btnRefreshClick(Sender: TObject);
begin
  fillGridFromDataset(m_.FieldByName('ID').AsInteger);
  zFirsttime := false;
end;

procedure TfrmRoomRates.btnCancelClick(Sender: TObject);
begin
  initwRoomRateHolder(zData);
end;

procedure TfrmRoomRates.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmRoomRates.btnDeleteClick(Sender: TObject);
begin
  m_.Delete;
end;

procedure TfrmRoomRates.btnEditClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  grData.SetFocus;
  tvData.GetColumnByFieldName('Description').Focused := True;
  showmessage(GetTranslatedText('shTx_RoomRates_EditInGrid'));
end;

procedure TfrmRoomRates.btnInsertClick(Sender: TObject);
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

procedure TfrmRoomRates.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;
  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;


procedure TfrmRoomRates.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;

procedure TfrmRoomRates.mnuiGridToExcelClick(Sender: TObject);
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

procedure TfrmRoomRates.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmRoomRates.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmRoomRates.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

end.

