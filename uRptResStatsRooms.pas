unit uRptResStatsRooms;

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
  , Vcl.ComCtrls
  , Vcl.StdCtrls
  , Vcl.Mask
  , Vcl.ExtCtrls
  , shellapi
  , Data.DB

  , sPageControl
  , sButton
  , sComboBox
  , sGroupBox
  , sPanel
  , sMaskEdit
  , sCustomComboEdit
  , sTooledit
  , sLabel

  ,cmpRoomerDataSet
  ,cmpRoomerConnection

  , _glob
  , ug
  , hData

  , kbmMemTable

  , cxGridExportLink
  , cxGraphics
  , cxControls
  , cxLookAndFeels
  , cxLookAndFeelPainters
  , cxStyles

  , cxExportPivotGridLink

  , dxSkinsCore, cxContainer, cxEdit, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White,
  dxSkinsDefaultPainters, Vcl.Menus, cxClasses, cxCustomData, dxSkinscxPCPainter, cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData,
  cxCurrencyEdit, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns,
  dxPSPDFExportCore, dxPSPDFExport, cxDrawTextUtils, dxPSPrVwStd, dxPSPrVwAdv, dxPSPrVwRibbon, dxPScxPageControlProducer, dxPScxGridLnk,
  dxPScxGridLayoutViewLnk, dxPScxPivotGridLnk, dxPScxEditorProducers, dxPScxExtEditorProducers, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter,
  dxmdaset, cxPropertiesStore, dxPScxCommon, dxPSCore, cxPivotGridChartConnection, cxPivotGridCustomDataSet, cxPivotGridDrillDownDataSet,
  Vcl.ImgList, cxVGrid, cxDBVGrid, cxInplaceContainer, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, sMemo, sEdit, cxSplitter,
  cxGridLevel, cxGridChartView, cxGridCustomView, cxGrid, cxCustomPivotGrid, cxDBPivotGrid, cxLabel, cxButtons, cxGroupBox, sCheckBox, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinDarkRoom, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue
  ;

type
  TfrmRptResStatsRooms = class(TForm)
    Panel3: TsPanel;
    gbxSelectDates: TsGroupBox;
    gbxSelectMonths: TsGroupBox;
    cbxMonth: TsComboBox;
    cbxYear: TsComboBox;
    btnRefresh: TsButton;
    pageMain: TsPageControl;
    dtDateFrom: TsDateEdit;
    dtDateTo: TsDateEdit;
    SheetMainResult: TsTabSheet;
    Panel1: TPanel;
    Panel5: TPanel;
    cxSplitter2: TcxSplitter;
    Panel6: TPanel;
    cxSplitter1: TcxSplitter;
    Dril001: TcxPivotGridDrillDownDataSet;
    Dril001DS: TDataSource;
    pgGraph001: TcxPivotGridChartConnection;
    sPageControl2: TsPageControl;
    sTabSheet2: TsTabSheet;
    sTabSheet3: TsTabSheet;
    pg001: TcxDBPivotGrid;
    cxGrid: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridChartView: TcxGridChartView;
    cxGridLevel: TcxGridLevel;
    grDrill: TcxGrid;
    tvDrill001: TcxGridDBTableView;
    grDrillLevel1: TcxGridLevel;
    grPrinter: TdxComponentPrinter;
    prLinkPg001: TcxPivotGridReportLink;
    prLinkGrDrill: TdxGridReportLink;
    store1: TcxPropertiesStore;
    sPanel2: TsPanel;
    sPanel4: TsPanel;
    gbxCustomization: TsGroupBox;
    cbxSel: TsComboBox;
    panLayoutShowMore: TsPanel;
    btnSaveLayout: TsButton;
    edLayoutName: TsEdit;
    cxButton2: TsButton;
    cxButton1: TsButton;
    sLabel1: TsLabel;
    memLayoutNotes: TsMemo;
    sLabel3: TsLabel;
    btnLayoutShowMore: TsButton;
    sTabSheet4: TsTabSheet;
    kbmRoomsData_: TkbmMemTable;
    kbmRoomsDataDS: TDataSource;
    sPanel6: TsPanel;
    btnExcel: TsButton;
    btnReport: TsButton;
    grRoomsData: TcxGrid;
    tvRoomsData: TcxGridDBTableView;
    lvRoomsData: TcxGridLevel;
    tvRoomsDatadtDate: TcxGridDBColumn;
    tvRoomsDataADate: TcxGridDBColumn;
    tvRoomsDataRoomType: TcxGridDBColumn;
    tvRoomsDataReservation: TcxGridDBColumn;
    tvRoomsDataRoomreservation: TcxGridDBColumn;
    tvRoomsDataResFlag: TcxGridDBColumn;
    tvRoomsDataisNoRoom: TcxGridDBColumn;
    tvRoomsDataPaid: TcxGridDBColumn;
    tvRoomsDatagroupAccount: TcxGridDBColumn;
    tvRoomsDatanumGuests: TcxGridDBColumn;
    tvRoomsDatanumChildren: TcxGridDBColumn;
    tvRoomsDatanumInfants: TcxGridDBColumn;
    tvRoomsDatatotalNumberOfBeds: TcxGridDBColumn;
    tvRoomsDatatotalNumberOfGuests: TcxGridDBColumn;
    tvRoomsDataGuestsCountry: TcxGridDBColumn;
    tvRoomsDatachannelID: TcxGridDBColumn;
    tvRoomsDataChannelName: TcxGridDBColumn;
    tvRoomsDatacustomer: TcxGridDBColumn;
    tvRoomsDataCustName: TcxGridDBColumn;
    tvRoomsDatastaff: TcxGridDBColumn;
    tvRoomsDataMarket: TcxGridDBColumn;
    tvRoomsDataMarketName: TcxGridDBColumn;
    tvRoomsDatanumRooms: TcxGridDBColumn;
    tvRoomsDataStatistics: TcxGridDBColumn;
    tvRoomsDataroom: TcxGridDBColumn;
    pg001dtDate: TcxDBPivotGridField;
    pg001room: TcxDBPivotGridField;
    pg001RoomType: TcxDBPivotGridField;
    pg001ResFlag: TcxDBPivotGridField;
    pg001isNoRoom: TcxDBPivotGridField;
    pg001Paid: TcxDBPivotGridField;
    pg001numGuests: TcxDBPivotGridField;
    pg001totalNumberOfBeds: TcxDBPivotGridField;
    pg001totalNumberOfGuests: TcxDBPivotGridField;
    pg001GuestsCountry: TcxDBPivotGridField;
    pg001ChannelName: TcxDBPivotGridField;
    mHead: TdxMemData;
    mHeadCompany: TStringField;
    mHeadStaff: TStringField;
    mHeadDateFrom: TDateField;
    mHeadDateTo: TDateField;
    mHeadDateCount: TIntegerField;
    mHeadSaleAmount: TFloatField;
    mHeadSaleAmountWoVAT: TFloatField;
    mHeadVATAmount: TFloatField;
    mHeadInvoiceCount: TIntegerField;
    mHeadSalePerDay: TFloatField;
    mHeadSalePerInvoice: TFloatField;
    mHeadPaymentAmount: TFloatField;
    mHeadPaymentCount: TFloatField;
    mHeadLodgingNights: TIntegerField;
    mHeadLodgingTax: TFloatField;
    mHeadRoomInvoiceCount: TIntegerField;
    mHeadGroupInvoiceCount: TIntegerField;
    mHeadKeditInvoiceCount: TIntegerField;
    mHeadCashInvoiceCount: TIntegerField;
    mHeadDS: TDataSource;
    tvRoomsDataTotalRooms: TcxGridDBColumn;
    tvRoomsDataEmptyRooms: TcxGridDBColumn;
    pg001TotalRooms: TcxDBPivotGridField;
    pg001EmptyRooms: TcxDBPivotGridField;
    pg001occRooms: TcxDBPivotGridField;
    pg001Week: TcxDBPivotGridField;
    pg001Month: TcxDBPivotGridField;
    tvRoomsDataoccRooms: TcxGridDBColumn;
    tvRoomsDataNoRooms: TcxGridDBColumn;
    pg001NoRooms: TcxDBPivotGridField;
    pg001NettoRooms: TcxDBPivotGridField;
    pg001OccPr: TcxDBPivotGridField;
    sGroupBox1: TsGroupBox;
    btnsetUseStatusAsDefault: TsButton;
    btnGetUseStatusAsDefault: TsButton;
    gbxUseStatusOfRooms: TsGroupBox;
    chkExcluteWaitingList: TsCheckBox;
    chkExcluteAlotment: TsCheckBox;
    chkExcluteOrder: TsCheckBox;
    chkExcluteNoShow: TsCheckBox;
    chkExcluteDeparted: TsCheckBox;
    chkExcluteBlocked: TsCheckBox;
    chkExcluteGuest: TsCheckBox;
    gbxUseStatusNoRooms: TsGroupBox;
    chkExcluteWaitingListNoRooms: TsCheckBox;
    chkExcluteAlotmentNoRooms: TsCheckBox;
    chkExcluteOrderNorooms: TsCheckBox;
    chkExcluteNoShowNoRooms: TsCheckBox;
    chkExcluteDepartedNoRooms: TsCheckBox;
    chkExcluteBlockedNoRooms: TsCheckBox;
    chkExcluteGuestNoRooms: TsCheckBox;
    FormStore: TcxPropertiesStore;
    sPanel3: TsPanel;
    chkStatistics: TsCheckBox;
    btnGrDrillExcel: TsButton;
    btnGrdrillPrint: TsButton;
    btnGrDrillBestFit: TsButton;
    sButton2: TsButton;
    sButton3: TsButton;
    sPanel7: TsPanel;
    btnPivgrRequestsExcel: TsButton;
    btnpivgrRequestsPrint: TsButton;
    btnPivgrRequestsBestfit: TsButton;
    labIsFiltered: TsLabel;
    pg001Location: TcxDBPivotGridField;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dtDateFromChange(Sender: TObject);
    procedure dtDateToChange(Sender: TObject);
    procedure cbxMonthCloseUp(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure chkExcluteWaitingListClick(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SheetMainResultShow(Sender: TObject);
    procedure kbmRoomsData_BeforePost(DataSet: TDataSet);
    procedure getHeader;
    procedure Dril001DataChanged(Sender: TObject);
    procedure btnPivgrRequestsExcelClick(Sender: TObject);
    procedure btnpivgrRequestsPrintClick(Sender: TObject);
    procedure btnPivgrRequestsBestfitClick(Sender: TObject);
    procedure btnGrDrillExcelClick(Sender: TObject);
    procedure pg001OccPrCalculateCustomSummary(Sender: TcxPivotGridField; ASummary: TcxPivotGridCrossCellSummary);
    procedure sButton4Click(Sender: TObject);

  private
    { Private declarations }
    zDateFrom : Tdate;
    zDateTo   : Tdate;
    zYear     : integer;
    zMonth    : integer;
    zSetDates : boolean;
    zRRInList   : string;
    zRVInList   : string;

    isFirstTime : boolean;
    zRoomReservationCount : Integer;
    zReservationCount : Integer;

    zRoomRentItem : string;
    zDiscountItem : String;
    zTaxesItem    : string;

    zStayTaxPerNight : double;
    zUseStayTax      : boolean;
    zStayTaxIncluted : boolean;

    zRoomRentVATPercentage : double;

    zFirstTime : boolean;

    procedure InitControles;

    procedure GetData;
    procedure ExcluteFilter;
    function StatusSQL : string;
    procedure ClearAllData;
    procedure addMissing;
    procedure updateDrilldown;
  public
    { Public declarations }
  end;

var
  frmRptResStatsRooms: TfrmRptResStatsRooms;

implementation

{$R *.dfm}

uses
    uD
  , uStringUtils
  , uAppGlobal
  , uReservationProfile
  , uGuestProfile2
  , uFinishedInvoices2
  , uUtils
  , PrjConst
  , uDImages;


procedure TfrmRptResStatsRooms.updateDrilldown;
begin
  screen.Cursor := crHourGlass;
  Dril001.DisableControls;
  try
    tvDrill001.BeginUpdate;
    try
      tvDrill001.ClearItems;
      tvDrill001.DataController.CreateAllItems;
    finally
      tvDrill001.EndUpdate;
    end;
  finally
    screen.Cursor := crDefault;
    Dril001.enableControls;
  end;
end;


//---------------------------------------------------------------------
// Form
//
//=====================================================================

procedure TfrmRptResStatsRooms.InitControles;
var
  y, m, d : word;
  idx     : integer;
  lastDay : integer;

begin
  zSetDates := false;

  decodeDate(now, y, m, d);
  zYear := y;
  zMonth := m;
  cbxMonth.ItemIndex := zMonth;

  cbxYear.ItemIndex := cbxYear.Items.IndexOf(inttostr(zYear));
//  idx := zYear - 2010;
//  if (idx < cbxYear.Items.Count - 1) and (idx > 0) then
//  begin
//    cbxYear.ItemIndex := idx;
//  end;

  zDateFrom := encodeDate(y, m, 1);
  lastDay := _DaysPerMonth(y, m);
  zDateTo := encodeDate(y, m, lastDay);
  dtDateFrom.Date := zDateFrom;
  dtDateTo.Date := zDateTo;
  zSetDates := true;
  isFirstTime := false;
end;

procedure TfrmRptResStatsRooms.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  glb.fillListWithMonthsLong(cbxMonth.Items, 1);
  glb.fillListWithYears(cbxYear.Items, 1, False);

  if pg001.Customization.Site <> nil then
  begin
    try
      pg001.Customization.Site := nil;
    Except
    end;
  end;
  isFirstTime := true;

  gbxCustomization.Visible :=  false;
  pg001.Customization.Visible :=  false;
end;

procedure TfrmRptResStatsRooms.FormDestroy(Sender: TObject);
begin
  if pg001.Customization.Site <> nil then
  begin
    try
      pg001.Customization.Site := nil;
    Except
    end;
  end;
end;

procedure TfrmRptResStatsRooms.FormShow(Sender: TObject);
begin
  _restoreForm(frmRptResStatsRooms);
  InitControles;
  pg001.Customization.Site := gbxCustomization;
  gbxCustomization.Visible :=  true;
  pg001.Customization.Visible :=  TRUE;
end;


procedure TfrmRptResStatsRooms.cbxMonthCloseUp(Sender: TObject);
var
  y, m : word;
  lastDay : integer;
begin
  if cbxYear.ItemIndex < 1 then
    exit;

  if cbxMonth.ItemIndex < 1 then
    exit;

  zSetDates := false;
  y := StrToInt(cbxYear.Items[cbxYear.ItemIndex]);
//  y := cbxYear.ItemIndex + 2010;
  m := cbxMonth.ItemIndex;

  zDateFrom := encodeDate(y, m, 1);
  lastDay := _DaysPerMonth(y, m);
  zDateTo := encodeDate(y, m, lastDay);
  dtDateFrom.Date := zDateFrom;
  dtDateTo.Date := zDateTo;
  zSetDates := true;
end;

procedure TfrmRptResStatsRooms.chkExcluteWaitingListClick(Sender: TObject);
begin
  ExcluteFilter;
end;


procedure TfrmRptResStatsRooms.ClearAllData;
begin
  //**
  if mHead.Active then
  begin
    mHead.Close;
    mHead.Open;
  end;
end;


procedure TfrmRptResStatsRooms.Dril001DataChanged(Sender: TObject);
begin
  updateDrilldown;
end;

procedure TfrmRptResStatsRooms.getHeader;
var
  id : integer;
  Code : string;
  Description : string;
  Sale    : double;
  payment : double;


  dateFrom  : TDate;
  dateTo    : Tdate;
  dateCount : integer;


  saleAmount      : double;
  saleAmountWoVAT : double;
  vatAmount       : double;

  invoiceCount   : integer;

  salePerDay       : double;
  salePerInvoice   : Double;

  PaymentAmount    : Double;
  PaymentCount     : Integer;
  LodgingNights    : Integer;
  LodgingTax       : Double;
  TotalTax         : Double;

  RoomInvoiceCount    : integer;
  GroupInvoiceCount   : integer;
  KeditInvoiceCount   : integer;
  CashInvoiceCount    : integer;

begin
  mHead.Close;
  mHead.Open;

  id := 0;
  mHead.DisableControls;
  try
    mHead.append;
        mHead.FieldByName('Company').AsString         := g.qHotelName;
        mHead.FieldByName('Staff').AsString           := g.qUserName;

        dateFrom := dtDateFrom.Date;
        dateTo := dtDateTo.Date;

        dateCount := (trunc(dateTo)-trunc(DateFrom))+1;

        saleAmount      := 0;//getTotal_ihAmountWithTax;
        saleAmountWoVAT := 0;//getTotal_ihAmountWoVAT;
        vatAmount       := 0;//getTotal_ihAmountVAT;

        invoiceCount    := 0;//getTotal_ihInvoiceCount;

        salePerDay      := 0;
        salePerInvoice  := 0;

        if dateCount > 0 then
        begin
          salePerDay := saleAmount/dateCount;
        end;

        if invoiceCount > 0 then
        begin
          salePerInvoice := saleAmount/invoiceCount;
        end;

        PaymentAmount    := 0;//getTotal_PaymentAmount   ;
        PaymentCount     := 0;//getTotal_PaymentCount    ;
        LodgingNights    := 0;//getTotal_LodgingNights   ;
        LodgingTax       := 0;//getTotal_LodgingTax      ;

        RoomInvoiceCount    :=  0;//abs(getTotal_RoomInvoiceCount)   ;
        GroupInvoiceCount   :=  0;//abs(getTotal_GroupInvoiceCount)  ;
        KeditInvoiceCount   :=  0;//abs(getTotal_KeditInvoiceCount)  ;
        CashInvoiceCount    :=  0;//abs(getTotal_CashInvoiceCount)   ;


        TotalTax            :=  0;

        mHead.FieldByName('DateFrom').AsDateTime       := dateTo;
        mHead.FieldByName('DateTo').AsDateTime         := DateFrom;
        mHead.FieldByName('DateCount').AsInteger       := dateCount;

        mHead.FieldByName('SaleAmount').AsFloat        := saleAmount;
        mHead.FieldByName('SaleAmountWoVAT').AsFloat   := saleAmountWoVAT;
        mHead.FieldByName('VATAmount').AsFloat         := vatAmount;

        mHead.FieldByName('InvoiceCount').AsInteger    := 0;//getTotal_ihInvoiceCount;

        mHead.FieldByName('SalePerDay').AsFloat        := salePerDay;
        mHead.FieldByName('SalePerInvoice').AsFloat    := salePerInvoice;

        mHead.FieldByName('PaymentAmount').AsFloat     := PaymentAmount   ;
        mHead.FieldByName('PaymentCount').AsInteger    := PaymentCount    ;
        mHead.FieldByName('LodgingNights').AsInteger   := LodgingNights   ;
        mHead.FieldByName('LodgingTax').AsFloat        := LodgingTax      ;

        mHead.FieldByName('RoomInvoiceCount').AsInteger  :=RoomInvoiceCount   ;
        mHead.FieldByName('GroupInvoiceCount').AsInteger :=GroupInvoiceCount  ;
        mHead.FieldByName('KeditInvoiceCount').AsInteger :=KeditInvoiceCount  ;
        mHead.FieldByName('CashInvoiceCount').AsInteger  :=CashInvoiceCount   ;
    mHead.Post;
  finally
    mHead.EnableControls;
  end;
end;


procedure TfrmRptResStatsRooms.dtDateFromChange(Sender: TObject);
begin
  if zSetDates then
  begin
    zDateFrom := dtDateFrom.Date;
    zDateTo := dtDateTo.Date;

    cbxYear.ItemIndex := 0;
    cbxMonth.ItemIndex := 0;
  end;
end;

procedure TfrmRptResStatsRooms.dtDateToChange(Sender: TObject);
begin
  if zSetDates then
  begin
    zDateFrom := dtDateFrom.Date;
    zDateTo := dtDateTo.Date;

    cbxYear.ItemIndex := 0;
    cbxMonth.ItemIndex := 0;
  end;
end;


procedure TfrmRptResStatsRooms.ExcluteFilter;
begin
end;


procedure TfrmRptResStatsRooms.SheetMainResultShow(Sender: TObject);
var
   c : integer;
begin
  pg001.Customization.Visible :=  TRUE;

  pg001.DataController.Filter.StoreItemLinkNames := False;
  pg001.DataController.Filter.Assign(tvRoomsData.DataController.Filter, True);

  if tvRoomsData.DataController.Filter.IsFiltering then
  begin
    labIsFiltered.Caption := 'Data has Prefilter';
  end else
  begin
    labIsFiltered.Caption := 'Data Not Filtered';
  end;


end;

function TfrmRptResStatsRooms.StatusSQL : string;
var
  sFilter : string;
  sNoRooms : string;
  sRooms   : string;
  i : integer;
begin
  result := '';

  if chkExcluteWaitingListNoRooms.checked then sNoRooms       := sNoRooms+_db('O')+',';
  if chkExcluteOrderNoRooms.checked then       sNoRooms       := sNoRooms+_db('P')+',';
  if chkExcluteGuestNoRooms.checked then       sNoRooms       := sNoRooms+_db('G')+',';
  if chkExcluteDepartedNoRooms.checked then    sNoRooms       := sNoRooms+_db('D')+',';
  if chkExcluteAlotmentNoRooms.checked then    sNoRooms       := sNoRooms+_db('A')+',';
  if chkExcluteBlockedNoRooms.checked then     sNoRooms       := sNoRooms+_db('B')+',';
  if chkExcluteNoshowNoRooms.checked then      sNoRooms       := sNoRooms+_db('N')+',';

  if chkExcluteWaitingList.checked then sRooms       := sRooms+_db('O')+',';
  if chkExcluteOrder.checked then       sRooms       := sRooms+_db('P')+',';
  if chkExcluteGuest.checked then       sRooms       := sRooms+_db('G')+',';
  if chkExcluteDeparted.checked then    sRooms       := sRooms+_db('D')+',';
  if chkExcluteAlotment.checked then    sRooms       := sRooms+_db('A')+',';
  if chkExcluteBlocked.checked then     sRooms       := sRooms+_db('B')+',';
  if chkExcluteNoshow.checked then      sRooms       := sRooms+_db('N')+',';

  if length(sNoRooms) > 0 then
  begin
    delete(sNoRooms,length(sNoRooms),1);
    sNoRooms := '('+sNoRooms+')';

    sNoRooms := '(rd.ResFlag IN '+sNoRooms+' AND (isNoRoom=1))';
  end;

  if length(sRooms) > 0 then
  begin
    delete(sRooms,length(sRooms),1);
    sRooms := '('+sRooms+')';
    sRooms := '(rd.ResFlag IN '+sRooms+' AND (isNoRoom=0))';
  end;

  if (length(sRooms) > 0) and (length(sNoRooms) > 0) then
  begin
    result := '('+sRooms+' OR '+sNoRooms+')'
  end else
  if length(sRooms) > 0 then
  begin
    result := sRooms;
  end else
  if length(sNORooms) > 0 then
  begin
    result := sNoRooms;
  end;
end;

//---------------------------------------------------------------------
// Get data QUERYS
//=====================================================================

procedure TfrmRptResStatsRooms.GetData;
var
  s    : string;
  rset1,
  rset2,
  rset3 : TRoomerDataset;
  ExecutionPlan : TRoomerExecutionPlan;

  startTick : integer;
  stopTick  : integer;
  SQLms     : integer;

  statusIn : string;

  dtTmp : TdateTime;

  rDate : TdateTime;
  rRoom : String;

begin
  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  try
    zFirstTime := false;
    startTick := GetTickCount;

    s := '';
    s := s+ '  SELECT '#10;
    s := s+ '    DATE(rd.ADate) as dtDate '#10;
    s := s+ '    ,rd.ADate '#10;
    s := s+ '    ,rd.room '#10;
    s := s+ '    ,rd.RoomType '#10;
    s := s+ '    ,rd.reservation '#10;
    s := s+ '    ,rd.roomReservation '#10;
    s := s+ '    ,rd.resFlag '#10;
    s := s+ '    ,rd.isNoRoom '#10;
    s := s+ '    ,rd.Paid '#10;
    s := s+ '    ,rr.groupAccount '#10;
    s := s+ '    ,rr.numGuests '#10;
    s := s+ '    ,rr.numChildren '#10;
    s := s+ '    ,rr.numInfants '#10;
    s := s+ '    ,ro.Statistics '#10;
    s := s+ '    ,ro.Location '#10;
    s := s+ '    ,(SELECT NumberGuests FROM roomtypes WHERE RoomType=rd.RoomType  LIMIT 1) AS totalNumberOfBeds '#10;
    s := s+ '    ,(SELECT COUNT(id) FROM persons WHERE RoomReservation=rd.RoomReservation  LIMIT 1) AS totalNumberOfGuests '#10;
    s := s+ '    ,(SELECT country FROM persons WHERE RoomReservation=rd.RoomReservation LIMIT 1) AS GuestsCountry '#10;
    s := s+ '    ,(SELECT channel FROM reservations WHERE reservation=rd.reservation  LIMIT 1) AS ChannelID '#10;
    s := s+ '    ,(SELECT Name FROM channels WHERE id = (SELECT channel FROM reservations WHERE reservation=rd.reservation LIMIT 1)  LIMIT 1) AS ChannelName '#10;
    s := s+ '    ,(SELECT Customer FROM reservations WHERE reservation=rd.reservation  LIMIT 1) AS Customer '#10;
    s := s+ '    ,(SELECT surname FROM customers WHERE customer = (SELECT Customer FROM reservations WHERE reservation=rd.reservation LIMIT 1) LIMIT 1 ) AS CustName '#10;
    s := s+ '    ,(SELECT Staff FROM reservations WHERE reservation=rd.reservation  LIMIT 1) AS Staff '#10;
    s := s+ '    ,(SELECT Marketsegment FROM reservations WHERE reservation=rd.reservation  LIMIT 1) AS Market '#10;
    s := s+ '    ,(SELECT Description FROM customertypes WHERE CustomerType=(SELECT Marketsegment FROM reservations WHERE reservation=rd.reservation LIMIT 1)  LIMIT 1) AS MarketName '#10;

    //  s := s+ '    ,(SELECT Statistics FROM rooms WHERE room=rd.room) AS Statistics '#10;
    s := s+ '  FROM roomsdate rd '#10;
    s := s+ '       INNER JOIN roomreservations rr ON rr.RoomReservation = rd.RoomReservation '#10;
    s := s+ '       INNER JOIN roomtypes rt ON rt.RoomType = rd.RoomType '#10;
    s := s+ '       LEFT OUTER JOIN rooms ro ON ro.Room = rd.Room '#10;
    s := s+ ' WHERE rd.ADate>='+_DateToDbDate(zDateFrom,true)+' AND rd.ADate<='+_DateToDbDate(zDateTo,true)+' '#10;

    statusIn := StatusSQL;
    if statusIn <> '' then
    begin
      s := s+'AND '+StatusSQL+' '#10;
    end;
    if chkStatistics.checked then
    begin
      s := s+'AND ( (ro.Statistics = 1) OR (left(rd.room,1)='+_db('<')+')) '#10;
    end;

//    s := s+'AND (ro.Statistics = 1) '#10;
    s := s+ ' ORDER BY ADATE DESC,room '#10;

//    copytoclipboard(s);
//    debugmessage(s);

    ExecutionPlan.AddQuery(s);
    //////////////////// Execute!

    screen.Cursor := crHourGlass;
    kbmRoomsData_.DisableControls;
    try
      ExecutionPlan.Execute(ptQuery);

      //////////////////// RoomsDate
      rSet1 := ExecutionPlan.Results[0];

      rset1.First;
      while not rset1.Eof do
      begin
        rDate := rSet1.fieldbyname('dtDate').asdateTime;
        rRoom := rSet1.fieldbyname('room').AsString;

        if kbmRoomsData_.Locate('dtDate;Room',varArrayOf([rDate,rRoom]),[]) then
        begin
          kbmRoomsData_.Edit;
          kbmRoomsData_.fieldbyname('reservation').AsInteger         := rSet1.fieldbyname('reservation').AsInteger;
          kbmRoomsData_.fieldbyname('roomreservation').AsInteger     := rSet1.fieldbyname('roomreservation').AsInteger;
          kbmRoomsData_.fieldbyname('ADate').AsString                := rSet1.fieldbyname('ADate').AsString;
          kbmRoomsData_.fieldbyname('ResFlag').AsString              := rSet1.fieldbyname('ResFlag').AsString;
          kbmRoomsData_.fieldbyname('isNoRoom').AsBoolean            := copy(rRoom,1,1)='<';
          kbmRoomsData_.fieldbyname('Paid').AsBoolean                := rSet1.fieldbyname('Paid').AsBoolean;
          kbmRoomsData_.fieldbyname('groupAccount').AsBoolean        := rSet1.fieldbyname('groupAccount').AsBoolean;
          kbmRoomsData_.fieldbyname('numGuests').AsInteger           := rSet1.fieldbyname('numGuests').AsInteger;
          kbmRoomsData_.fieldbyname('numChildren').AsInteger         := rSet1.fieldbyname('numChildren').AsInteger;
          kbmRoomsData_.fieldbyname('numInfants').AsInteger          := rSet1.fieldbyname('numInfants').AsInteger;
          kbmRoomsData_.fieldbyname('totalNumberOfGuests').AsInteger := rSet1.fieldbyname('totalNumberOfGuests').AsInteger;
          kbmRoomsData_.fieldbyname('GuestsCountry').AsString        := rSet1.fieldbyname('GuestsCountry').AsString;
          kbmRoomsData_.fieldbyname('channelID').AsInteger           := rSet1.fieldbyname('channelID').AsInteger;
          kbmRoomsData_.fieldbyname('ChannelName').AsString          := rSet1.fieldbyname('ChannelName').AsString;
          kbmRoomsData_.fieldbyname('customer').AsString             := rSet1.fieldbyname('customer').AsString;
          kbmRoomsData_.fieldbyname('CustName').AsString             := rSet1.fieldbyname('CustName').AsString;
          kbmRoomsData_.fieldbyname('staff').AsString                := rSet1.fieldbyname('staff').AsString;
          kbmRoomsData_.fieldbyname('Market').AsString               := rSet1.fieldbyname('Market').AsString;
          kbmRoomsData_.fieldbyname('MarketName').AsString           := rSet1.fieldbyname('MarketName').AsString;
          kbmRoomsData_.fieldbyname('Statistics').AsBoolean          := rSet1.fieldbyname('Statistics').AsBoolean;
          kbmRoomsData_.fieldbyname('location').AsString             := rSet1.fieldbyname('location').AsString;
          kbmRoomsData_.fieldbyname('occRooms').AsInteger            := 1;
          kbmRoomsData_.fieldbyname('TotalRooms').AsInteger          := 1;
          kbmRoomsData_.fieldbyname('EmptyRooms').AsInteger          := 0;
          kbmRoomsData_.fieldbyname('NoRooms').AsInteger             := 0;
          kbmRoomsData_.fieldbyname('NettoRooms').AsInteger          := 0;
          if kbmRoomsData_.fieldbyname('isNoRoom').AsBoolean = true then
          begin
            kbmRoomsData_.fieldbyname('NoRooms').asinteger    := 1;
            kbmRoomsData_.fieldbyname('NettoRooms').AsInteger := -1;
          end;
  //        kbmRoomsData_.fieldbyname('NettoRooms').AsInteger := kbmRoomsData_.fieldbyname('EmptyRooms').AsInteger-kbmRoomsData_.fieldbyname('NoRooms').asinteger;
          kbmRoomsData_.post;
        end else
        begin
          kbmRoomsData_.append;
          kbmRoomsData_.fieldbyname('dtDate').AsDateTime             := rSet1.fieldbyname('dtDate').AsDateTime;
          kbmRoomsData_.fieldbyname('room').AsString                 := rSet1.fieldbyname('room').asstring;
          kbmRoomsData_.fieldbyname('roomType').AsString             := rSet1.fieldbyname('roomType').asstring;
          kbmRoomsData_.fieldbyname('reservation').AsInteger         := rSet1.fieldbyname('reservation').AsInteger;
          kbmRoomsData_.fieldbyname('roomreservation').AsInteger     := rSet1.fieldbyname('roomreservation').AsInteger;
          kbmRoomsData_.fieldbyname('ADate').AsString                := rSet1.fieldbyname('ADate').AsString;
          kbmRoomsData_.fieldbyname('ResFlag').AsString              := rSet1.fieldbyname('ResFlag').AsString;
          kbmRoomsData_.fieldbyname('isNoRoom').AsBoolean            := copy(rRoom,1,1)='<';
          kbmRoomsData_.fieldbyname('Paid').AsBoolean                := rSet1.fieldbyname('Paid').AsBoolean;
          kbmRoomsData_.fieldbyname('groupAccount').AsBoolean        := rSet1.fieldbyname('groupAccount').AsBoolean;
          kbmRoomsData_.fieldbyname('numGuests').AsInteger           := rSet1.fieldbyname('numGuests').AsInteger;
          kbmRoomsData_.fieldbyname('numChildren').AsInteger         := rSet1.fieldbyname('numChildren').AsInteger;
          kbmRoomsData_.fieldbyname('numInfants').AsInteger          := rSet1.fieldbyname('numInfants').AsInteger;
          kbmRoomsData_.fieldbyname('totalNumberOfGuests').AsInteger := rSet1.fieldbyname('totalNumberOfGuests').AsInteger;
          kbmRoomsData_.fieldbyname('GuestsCountry').AsString        := rSet1.fieldbyname('GuestsCountry').AsString;
          kbmRoomsData_.fieldbyname('channelID').AsInteger           := rSet1.fieldbyname('channelID').AsInteger;
          kbmRoomsData_.fieldbyname('ChannelName').AsString          := rSet1.fieldbyname('ChannelName').AsString;
          kbmRoomsData_.fieldbyname('customer').AsString             := rSet1.fieldbyname('customer').AsString;
          kbmRoomsData_.fieldbyname('CustName').AsString             := rSet1.fieldbyname('CustName').AsString;
          kbmRoomsData_.fieldbyname('staff').AsString                := rSet1.fieldbyname('staff').AsString;
          kbmRoomsData_.fieldbyname('Market').AsString               := rSet1.fieldbyname('Market').AsString;
          kbmRoomsData_.fieldbyname('MarketName').AsString           := rSet1.fieldbyname('MarketName').AsString;
          kbmRoomsData_.fieldbyname('Statistics').AsBoolean          := rSet1.fieldbyname('Statistics').AsBoolean;
          kbmRoomsData_.fieldbyname('totalNumberOfBeds').AsInteger   := rSet1.fieldbyname('totalNumberOfBeds').AsInteger;
          kbmRoomsData_.fieldbyname('occRooms').AsInteger            := 1;
          kbmRoomsData_.fieldbyname('TotalRooms').AsInteger          := 0;
          kbmRoomsData_.fieldbyname('EmptyRooms').AsInteger          := 0;
          kbmRoomsData_.fieldbyname('NoRooms').AsInteger             := 0;
          kbmRoomsData_.fieldbyname('nettoRooms').AsInteger          := 0;
          if kbmRoomsData_.fieldbyname('isNoRoom').AsBoolean = true then
          begin
            kbmRoomsData_.fieldbyname('NoRooms').asinteger := 1;
            kbmRoomsData_.fieldbyname('NettoRooms').AsInteger := -1;
          end;
          kbmRoomsData_.post;
        end;
        rset1.Next;
      end;


//      if kbmRoomsdata_.Active then kbmRoomsData_.Close;
//      kbmRoomsData_.open;
//      kbmRoomsData_.LoadFromDataSet(rSet1,[]);
//      kbmRoomsData_.First;


    finally
      screen.cursor := crDefault;
      kbmRoomsData_.EnableControls;
    end;

    stopTick         := GetTickCount;
    SQLms            := stopTick - startTick;

    zFirstTime := false;

  finally
    ExecutionPlan.Free;
  end;
end;

procedure TfrmRptResStatsRooms.addMissing;
var
  s    : string;
  rset1,
  rset2,
  rset3 : TRoomerDataset;
  ExecutionPlan : TRoomerExecutionPlan;

  startTick : integer;
  stopTick  : integer;
  SQLms     : integer;

  statusIn : string;

  dtTmp : TdateTime;
begin
  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  try
    zFirstTime := true;
    startTick := GetTickCount;

   s := '';
   s := s+' SELECT '#10;
   s := s+'     pd.date AS dtDate '#10;
   s := s+'    ,ro.Room '#10;
   s := s+'    ,ro.RoomType '#10;
   s := s+'    ,(SELECT NumberGuests FROM roomtypes WHERE RoomType=ro.RoomType) AS totalNumberOfBeds '#10;
   s := s+'  FROM predefineddates pd, rooms ro '#10;
   s := s+'  WHERE '#10;
   s := s+'     ((pd.date>='+_DateToDbDate(zDateFrom,true)+' AND pd.date<='+_DateToDbDate(zDateTo,true)+')) '#10;
   if chkStatistics.checked then
   begin
     s := s+'AND (ro.Statistics = 1)  '#10;
   end;
   s := s+'  GROUP BY pd.date, ro.Room '#10;

//    copytoclipboard(s);
//    DebugMessage(s);

    ExecutionPlan.AddQuery(s);
    //////////////////// Execute!

    screen.Cursor := crHourGlass;
    kbmRoomsData_.DisableControls;
    try
      ExecutionPlan.Execute(ptQuery);

      //////////////////// RoomsDate
      rSet1 := ExecutionPlan.Results[0];

      if kbmRoomsdata_.Active then kbmRoomsData_.Close;
      kbmRoomsData_.open;
      LoadKbmMemtableFromDataSetQuiet(kbmRoomsData_,rSet1,[]);
      kbmRoomsData_.First;
    finally
      screen.cursor := crDefault;
      kbmRoomsData_.EnableControls;
    end;

    stopTick         := GetTickCount;
    SQLms            := stopTick - startTick;
    zFirstTime := false;

  finally
    ExecutionPlan.Free;
  end;

end;

procedure TfrmRptResStatsRooms.kbmRoomsData_BeforePost(DataSet: TDataSet);
begin
  if not zFirstTime then exit;
  dataset.FieldByName('ADate').asString := '';
  dataset.FieldByName('Reservation').asInteger := 0;
  dataset.FieldByName('Roomreservation').asInteger := 0;
  dataset.FieldByName('ResFlag').asString := '';
  dataset.FieldByName('isNoRoom').asBoolean := false;
  dataset.FieldByName('Paid').asBoolean := false;
  dataset.FieldByName('groupAccount').asBoolean := false;
  dataset.FieldByName('numGuests').asInteger := 0;
  dataset.FieldByName('numChildren').asInteger := 0;
  dataset.FieldByName('numInfants').asInteger := 0;
  dataset.FieldByName('totalNumberOfGuests').asInteger := 0;
  dataset.FieldByName('GuestsCountry').asString := '';
  dataset.FieldByName('channelID').asInteger := -1;
  dataset.FieldByName('ChannelName').asInteger := 0;
  dataset.FieldByName('customer').asString := '';
  dataset.FieldByName('CustName').asString := '';
  dataset.FieldByName('staff').asString := '';
  dataset.FieldByName('Market').asString := '';
  dataset.FieldByName('MarketName').asString := '';
  dataset.FieldByName('Statistics').asBoolean := false;
  dataset.FieldByName('occRooms').asInteger      := 0;
  dataset.fieldbyname('TotalRooms').AsInteger    := 1;
  dataset.fieldbyname('EmptyRooms').AsInteger    := 1;
  dataset.fieldbyname('NoRooms').AsInteger       := 0;
  dataset.fieldbyname('nettoRooms').AsInteger    := 1;
end;

procedure TfrmRptResStatsRooms.pg001OccPrCalculateCustomSummary(Sender: TcxPivotGridField; ASummary: TcxPivotGridCrossCellSummary);
var
  ATotal, AOcc: Variant;
  ARow: TcxPivotGridGroupItem;
begin
  ASummary.Custom := 0;

  ARow := ASummary.Owner.Row;
  ATotal := ARow.GetCellByCrossItem(ASummary.Owner.Column).GetSummaryByField(pg001TotalRooms, stSum);
  AOcc := ARow.GetCellByCrossItem(ASummary.Owner.Column).GetSummaryByField(pg001occRooms, stSum);
  if aTotal <> 0 then
  ASummary.Custom := (AOcc / ATotal) * 100;
end;


procedure TfrmRptResStatsRooms.sButton4Click(Sender: TObject);
begin

end;

//15



//****************************************
procedure TfrmRptResStatsRooms.btnExcelClick(Sender: TObject);
var
  sFilename : string;
  s         : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_reservationstatitics';
  ExportGridToExcel(sFilename, grRoomsData, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;



procedure TfrmRptResStatsRooms.btnGrDrillExcelClick(Sender: TObject);
var
  sFilename : string;
  s : string;
begin
  datetimeTostring(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_pivResStatDetails';
  cxExportPivotGridToExcel(sFileName, pg001);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;


procedure TfrmRptResStatsRooms.btnPivgrRequestsBestfitClick(Sender: TObject);
begin
  pg001.ApplyBestFit;
end;

procedure TfrmRptResStatsRooms.btnPivgrRequestsExcelClick(Sender: TObject);
var
  sFilename : string;
  s : string;
begin
  datetimeTostring(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_pivResStat';
  cxExportPivotGridToExcel(sFileName, pg001);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;


procedure TfrmRptResStatsRooms.btnpivgrRequestsPrintClick(Sender: TObject);
begin
  grPrinter.CurrentLink := prLinkPg001;
  grPrinter.CurrentLink.ReportTitle.Text := 'Reservation Statitics';
  grPrinter.Preview(true,nil);
end;

procedure TfrmRptResStatsRooms.btnRefreshClick(Sender: TObject);
begin
  addMissing;
  getData;
//  getHeader;
end;


end.


