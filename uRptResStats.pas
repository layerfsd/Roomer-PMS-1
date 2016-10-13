unit uRptResStats;

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

  , sEdit
  , sMemo

  , cxGridExportLink
  , cxGraphics
  , cxControls
  , cxLookAndFeels
  , cxLookAndFeelPainters
  , cxStyles
  , cxExportPivotGridLink

  , dxSkinsCore
  , cxContainer, cxEdit, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White,
  dxSkinsDefaultPainters, Vcl.Menus, cxClasses, cxCustomData, cxCurrencyEdit, dxSkinscxPCPainter, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDBData, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, dxPSPDFExportCore, dxPSPDFExport, cxDrawTextUtils, dxPSPrVwStd, dxPSPrVwAdv, dxPSPrVwRibbon, dxPScxPageControlProducer,
  dxPScxGridLnk, dxPScxGridLayoutViewLnk, dxPScxPivotGridLnk, dxPScxEditorProducers, dxPScxExtEditorProducers, dxSkinsdxBarPainter,
  dxSkinsdxRibbonPainter, cxPropertiesStore, dxPScxCommon, dxPSCore, cxPivotGridChartConnection, dxmdaset, cxPivotGridCustomDataSet,
  cxPivotGridDrillDownDataSet, Vcl.ImgList, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxSplitter, cxGridLevel,
  cxGridChartView, cxGridCustomView, cxGrid, cxCustomPivotGrid, cxDBPivotGrid, cxLabel, cxButtons, cxGroupBox, sCheckBox, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinDarkRoom, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue,
  Vcl.Buttons, sSpeedButton
  ;

type
  TfrmRptResStats = class(TForm)
    Panel3: TsPanel;
    gbxSelectDates: TsGroupBox;
    gbxSelectMonths: TsGroupBox;
    cbxMonth: TsComboBox;
    cbxYear: TsComboBox;
    btnRefresh: TsButton;
    pageMain: TsPageControl;
    dtDateFrom: TsDateEdit;
    dtDateTo: TsDateEdit;
    kbmRoomsDate_: TkbmMemTable;
    RoomsDateDS: TDataSource;
    kbmInvoiceLines_: TkbmMemTable;
    InvoiceLinesDS: TDataSource;
    kbmGroupInvoiceSums_: TkbmMemTable;
    GroupInvoiceSumsDS: TDataSource;
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
    pg001dtDate: TcxDBPivotGridField;
    pg001Room: TcxDBPivotGridField;
    pg001RoomType: TcxDBPivotGridField;
    pg001StatusText: TcxDBPivotGridField;
    pg001isNoroom: TcxDBPivotGridField;
    pg001Location: TcxDBPivotGridField;
    pg001Country: TcxDBPivotGridField;
    pg001CustomerType: TcxDBPivotGridField;
    pg001incomeTotal: TcxDBPivotGridField;
    pg001RoomRentTotal: TcxDBPivotGridField;
    pg001RoomDiscountTotal: TcxDBPivotGridField;
    pg001ItemsTotal: TcxDBPivotGridField;
    pg001TaxesTotal: TcxDBPivotGridField;
    pg001RRGuestCount: TcxDBPivotGridField;
    pg001MainGuests: TcxDBPivotGridField;
    pg001paid: TcxDBPivotGridField;
    pg001RoomRentBilled: TcxDBPivotGridField;
    pg001RoomDiscountBilled: TcxDBPivotGridField;
    pg001ItemsBilled: TcxDBPivotGridField;
    pg001TaxesBilled: TcxDBPivotGridField;
    pg001RoomRentUnBilled: TcxDBPivotGridField;
    pg001RoomDiscountUnBilled: TcxDBPivotGridField;
    pg001itemsUnBilled: TcxDBPivotGridField;
    pg001TaxesUnbilled: TcxDBPivotGridField;
    pg001currency: TcxDBPivotGridField;
    pg001CurrencyRate: TcxDBPivotGridField;
    pg001NativeRate: TcxDBPivotGridField;
    pg001discount: TcxDBPivotGridField;
    pg001isPercentage: TcxDBPivotGridField;
    pg001discountAmount: TcxDBPivotGridField;
    pg001sArrival: TcxDBPivotGridField;
    pg001sDeparture: TcxDBPivotGridField;
    pg001DayCount: TcxDBPivotGridField;
    pg001RoomCount: TcxDBPivotGridField;
    pg001RvGuestCount: TcxDBPivotGridField;
    pg001roomReservation: TcxDBPivotGridField;
    pg001Reservation: TcxDBPivotGridField;
    pg001Invoicenumbers: TcxDBPivotGridField;
    pg001ResFlag: TcxDBPivotGridField;
    pg001FilterFlag: TcxDBPivotGridField;
    pg001aDate: TcxDBPivotGridField;
    grDrill: TcxGrid;
    tvDrill001: TcxGridDBTableView;
    grDrillLevel1: TcxGridLevel;
    pg00Week: TcxDBPivotGridField;
    grPrinter: TdxComponentPrinter;
    prLinkPg001: TcxPivotGridReportLink;
    prLinkGrDrill: TdxGridReportLink;
    pg001Month: TcxDBPivotGridField;
    store1: TcxPropertiesStore;
    sheetMainData: TsTabSheet;
    pageData: TsPageControl;
    sTabSheet7: TsTabSheet;
    sTabSheet8: TsTabSheet;
    sTabSheet9: TsTabSheet;
    Panel2: TsPanel;
    btnExcelRoomsDate: TsButton;
    btnReservationRoomsDate: TsButton;
    btnRoomRoomsDate: TsButton;
    grRoomsDate: TcxGrid;
    tvRoomsDate: TcxGridDBTableView;
    tvRoomsDatedtDate: TcxGridDBColumn;
    tvRoomsDateRoom: TcxGridDBColumn;
    tvRoomsDateRoomType: TcxGridDBColumn;
    tvRoomsDateStatusText: TcxGridDBColumn;
    tvRoomsDateisNoroom: TcxGridDBColumn;
    tvRoomsDateLocation: TcxGridDBColumn;
    tvRoomsDateCountry: TcxGridDBColumn;
    tvRoomsDateCustomerType: TcxGridDBColumn;
    tvRoomsDateincomeTotal: TcxGridDBColumn;
    tvRoomsDateRoomRentTotal: TcxGridDBColumn;
    tvRoomsDateRoomDiscountTotal: TcxGridDBColumn;
    tvRoomsDateItemsTotal: TcxGridDBColumn;
    tvRoomsDateTaxesTotal: TcxGridDBColumn;
    tvRoomsDateRRGuestCount: TcxGridDBColumn;
    tvRoomsDateMainGuests: TcxGridDBColumn;
    tvRoomsDatepaid: TcxGridDBColumn;
    tvRoomsDateRoomRentBilled: TcxGridDBColumn;
    tvRoomsDateRoomDiscountBilled: TcxGridDBColumn;
    tvRoomsDateItemsBilled: TcxGridDBColumn;
    tvRoomsDateTaxesBilled: TcxGridDBColumn;
    tvRoomsDateRoomRentUnBilled: TcxGridDBColumn;
    tvRoomsDateRoomDiscountUnBilled: TcxGridDBColumn;
    tvRoomsDateitemsUnBilled: TcxGridDBColumn;
    tvRoomsDateTaxesUnbilled: TcxGridDBColumn;
    tvRoomsDatecurrency: TcxGridDBColumn;
    tvRoomsDateCurrencyRate: TcxGridDBColumn;
    tvRoomsDateNativeRate: TcxGridDBColumn;
    tvRoomsDatediscount: TcxGridDBColumn;
    tvRoomsDateisPercentage: TcxGridDBColumn;
    tvRoomsDatediscountAmount: TcxGridDBColumn;
    tvRoomsDatesArrival: TcxGridDBColumn;
    tvRoomsDatesDeparture: TcxGridDBColumn;
    tvRoomsDateDayCount: TcxGridDBColumn;
    tvRoomsDateRoomCount: TcxGridDBColumn;
    tvRoomsDateRvGuestCount: TcxGridDBColumn;
    tvRoomsDateroomReservation: TcxGridDBColumn;
    tvRoomsDateReservation: TcxGridDBColumn;
    tvRoomsDateInvoicenumbers: TcxGridDBColumn;
    tvRoomsDateResFlag: TcxGridDBColumn;
    tvRoomsDateFilterFlag: TcxGridDBColumn;
    tvRoomsDateaDate: TcxGridDBColumn;
    lvRoomsDate: TcxGridLevel;
    sPanel1: TsPanel;
    btnExcelInvoiceLines: TsButton;
    btnInvoiceInvoicelines: TsButton;
    btnReservationInvoiceLines: TsButton;
    btnRoomInvoicelines: TsButton;
    grInvoicelines: TcxGrid;
    tvInvoicelines: TcxGridDBTableView;
    tvInvoicelinesInvoiceNumber: TcxGridDBColumn;
    tvInvoicelinesItemID: TcxGridDBColumn;
    tvInvoicelinesDescription: TcxGridDBColumn;
    tvInvoicelinesNumber: TcxGridDBColumn;
    tvInvoicelinesPrice: TcxGridDBColumn;
    tvInvoicelinesTotal: TcxGridDBColumn;
    tvInvoicelinesVATType: TcxGridDBColumn;
    tvInvoicelinesTotalWOVat: TcxGridDBColumn;
    tvInvoicelinesVat: TcxGridDBColumn;
    tvInvoicelinesSplitNumber: TcxGridDBColumn;
    tvInvoicelinesReservation: TcxGridDBColumn;
    tvInvoicelinesRoomReservation: TcxGridDBColumn;
    lvInvoicelines: TcxGridLevel;
    sPanel3: TsPanel;
    btnExcelGroupInvoiceSums: TsButton;
    btnReservationGroupInvoiceSums: TsButton;
    btnRoomGroupInvoiceSums: TsButton;
    btnInvoiceGroupInvoiceSums: TsButton;
    gr: TcxGrid;
    tvGroupInvoiceSums: TcxGridDBTableView;
    tvGroupInvoiceSumsinvoiceNumber: TcxGridDBColumn;
    tvGroupInvoiceSumsItemId: TcxGridDBColumn;
    tvGroupInvoiceSumsnoItems: TcxGridDBColumn;
    tvGroupInvoiceSumsavragePrice: TcxGridDBColumn;
    tvGroupInvoiceSumsTotal: TcxGridDBColumn;
    tvGroupInvoiceSumsTotalWOVat: TcxGridDBColumn;
    tvGroupInvoiceSumsTotalVat: TcxGridDBColumn;
    tvGroupInvoiceSumsnoInvoices: TcxGridDBColumn;
    tvGroupInvoiceSumsRoomCount: TcxGridDBColumn;
    tvGroupInvoiceSumsReservation: TcxGridDBColumn;
    lvGroupInvoiceSums: TcxGridLevel;
    sPanel2: TsPanel;
    sPanel4: TsPanel;
    gbxCustomization: TsGroupBox;
    cbxSel: TsComboBox;
    btnSetDefaultLayout: TsButton;
    tvRoomsDateCustomer: TcxGridDBColumn;
    pg001Customer: TcxDBPivotGridField;
    tvRoomsDateCustomerName: TcxGridDBColumn;
    tvRoomsDateRoomCount2: TcxGridDBColumn;
    pg001CustomerName: TcxDBPivotGridField;
    sGroupBox1: TsGroupBox;
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
    btnsetUseStatusAsDefault: TsButton;
    btnGetUseStatusAsDefault: TsButton;
    sPanel6: TsPanel;
    btnGrDrillExcel: TsButton;
    btnGrdrillPrint: TsButton;
    btnGrDrillBestFit: TsButton;
    sButton2: TsButton;
    sButton3: TsButton;
    sButton4: TsButton;
    sPanel7: TsPanel;
    btnPivgrRequestsBestfit: TsButton;
    btnpivgrRequestsPrint: TsButton;
    btnPivgrRequestsExcel: TsButton;
    FormStore: TcxPropertiesStore;
    labIsFiltered: TsLabel;
    pg001VatTotal: TcxDBPivotGridField;
    pg001VatBilled: TcxDBPivotGridField;
    pg001VatUnbilled: TcxDBPivotGridField;
    pg001CtaxTotal: TcxDBPivotGridField;
    pg001CtaxBilled: TcxDBPivotGridField;
    pg001CtaxUnbilled: TcxDBPivotGridField;
    pg001CTaxTotalWoVAT: TcxDBPivotGridField;
    pg001IncomeTotalNoVAT: TcxDBPivotGridField;
    tvRoomsDateNoOfRooms: TcxGridDBColumn;
    tvRoomsDateIncomeTotalWoVAT: TcxGridDBColumn;
    tvRoomsDateRoomRentTotalWoVAT: TcxGridDBColumn;
    tvRoomsDateRoomDiscountTotalWoVAT: TcxGridDBColumn;
    tvRoomsDateItemsTotalWoVAT: TcxGridDBColumn;
    tvRoomsDateVatTotal: TcxGridDBColumn;
    tvRoomsDateVatBilled: TcxGridDBColumn;
    tvRoomsDateVatUnbilled: TcxGridDBColumn;
    tvRoomsDateCtaxTotal: TcxGridDBColumn;
    tvRoomsDateCtaxTotalWoVAT: TcxGridDBColumn;
    tvRoomsDateCtaxBilled: TcxGridDBColumn;
    tvRoomsDateCtaxUnbilled: TcxGridDBColumn;
    pg001RoomRentTotalWoVAT: TcxDBPivotGridField;
    pg001ItemsTotalWoVAT: TcxDBPivotGridField;
    pg001vatItemsTotal: TcxDBPivotGridField;
    pg001vatItemsUnbilled: TcxDBPivotGridField;
    pg001vatItemsBilled: TcxDBPivotGridField;
    pg001vatRentTotal: TcxDBPivotGridField;
    pg001vatRentBilled: TcxDBPivotGridField;
    pg001VatRentUnbilled: TcxDBPivotGridField;
    pg001vatCtaxTotal: TcxDBPivotGridField;
    pg001vatCtaxbilled: TcxDBPivotGridField;
    pg001vatCtaxUnbilled: TcxDBPivotGridField;
    tvRoomsDatevatRentUnbilled: TcxGridDBColumn;
    tvRoomsDatevatRentBilled: TcxGridDBColumn;
    tvRoomsDatevatRentTotal: TcxGridDBColumn;
    tvRoomsDatevatItemsUnbilled: TcxGridDBColumn;
    tvRoomsDatevatItemsBilled: TcxGridDBColumn;
    tvRoomsDatevatItemsTotal: TcxGridDBColumn;
    tvRoomsDatevatCtaxUnbilled: TcxGridDBColumn;
    tvRoomsDatevatCtaxbilled: TcxGridDBColumn;
    tvRoomsDatevatCtaxTotal: TcxGridDBColumn;
    tvRoomsDateItemId: TcxGridDBColumn;
    pg001vatDiscountTotal: TcxDBPivotGridField;
    pg001vatDiscountBilled: TcxDBPivotGridField;
    pg001vatDiscountUnbilled: TcxDBPivotGridField;
    btnSaveLayout: TsButton;
    btnUpdateLayout: TsButton;
    cxButton1: TsButton;
    sSpeedButton1: TsSpeedButton;
    tvRoomsDatevatDiscountTotal: TcxGridDBColumn;
    tvRoomsDatevatDiscountBilled: TcxGridDBColumn;
    tvRoomsDatevatDiscountUnbilled: TcxGridDBColumn;
    storeOld: TcxPropertiesStore;
    chkExcludeWaitingListNonOptional: TsCheckBox;
    chkExcludeWaitingListNonOptional_NoRooms: TsCheckBox;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dtDateFromChange(Sender: TObject);
    procedure dtDateToChange(Sender: TObject);
    procedure cbxMonthCloseUp(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure kbmRoomsDate_BeforePost(DataSet: TDataSet);
    procedure btnExcelInvoiceLinesClick(Sender: TObject);
    procedure btnExcelRoomsDateClick(Sender: TObject);
    procedure btnExcelGroupInvoiceSumsClick(Sender: TObject);
    procedure btnReservationRoomsDateClick(Sender: TObject);
    procedure btnRoomRoomsDateClick(Sender: TObject);
    procedure btnReservationInvoiceLinesClick(Sender: TObject);
    procedure btnRoomInvoicelinesClick(Sender: TObject);
    procedure btnReservationGroupInvoiceSumsClick(Sender: TObject);
    procedure btnRoomGroupInvoiceSumsClick(Sender: TObject);
    procedure btnInvoiceGroupInvoiceSumsClick(Sender: TObject);
    procedure btnInvoiceInvoicelinesClick(Sender: TObject);
    procedure chkExcluteWaitingListClick(Sender: TObject);
    procedure btnGetUseStatusAsDefaultClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SheetMainResultShow(Sender: TObject);
    procedure btnPivgrRequestsBestfitClick(Sender: TObject);
    procedure sTabSheet2Show(Sender: TObject);
    procedure Dril001DataChanged(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure btnpivgrRequestsPrintClick(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure sButton4Click(Sender: TObject);
    procedure btnPivgrRequestsExcelClick(Sender: TObject);
    procedure btnGrDrillBestFitClick(Sender: TObject);
    procedure btnGrDrillExcelClick(Sender: TObject);
    procedure btnGrdrillPrintClick(Sender: TObject);
    procedure btnSaveLayoutClick(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure btnSetDefaultLayoutClick(Sender: TObject);
    procedure cbxSelCloseUp(Sender: TObject);
    procedure btnsetUseStatusAsDefaultClick(Sender: TObject);
    procedure pg001incomeTotalGetProperties(Sender: TcxPivotGridField; ACell: TcxPivotGridCustomCellViewInfo;
      var AProperties: TcxCustomEditProperties);
    procedure tvRoomsDateincomeTotalGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure pg001AvrRateCalculateCustomSummary(Sender: TcxPivotGridField;
      ASummary: TcxPivotGridCrossCellSummary);
    procedure sSpeedButton1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

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

    zTaxesItem          : string;
    zStayTaxAmount    : double;
    zUseStayTax         : boolean;
    zStayTaxIncluted    : boolean;
    zStayTaxPerCustomer : boolean;
    zStayTaxPercentage   : boolean;

    zRoomRentVATPercentage : double;

    zFirstTime : boolean;

    zTaxesHolder : recTaxesHolder;
    zItemTypeInfoRent : TItemTypeInfo;
    zItemTypeInfoTax  : TItemTypeInfo;


    Procedure fillLocationsChkBox;
    procedure InitControles;

    function GetRRinList : string;
    function GetRVinList : string;
    procedure GetData;
    procedure AddInvoicelineData;
    procedure AddGroupInvoiceSumsData;
    procedure ExcluteFilter;
    function StatusSQL : string;
    procedure updateDrilldown;
    procedure SetColumnProperties(ATableView: TcxGridTableView);
    procedure GetSel;
    function GetAutoName : string;
    procedure LoadLayout(useDefault : boolean);
    procedure GetUseStatusDefault;
    procedure SetUseStatusDefault;
    function SaveLayout2new : boolean;
    procedure deleteLayout(description : string);
    function updateLayoutName(oldName, newname : string) : boolean;
    procedure LoadLayoutOld(useDefault : boolean);
//    function calcStayTax(Taxholder : recTaxesHolder; rentAmount : double; currency : string; Customer : string; taxnights,taxguests : integer; Reservation : integer): recCityTaxResultHolder;

  public
    { Public declarations }
    procedure WndProc(var message: TMessage); override;
  end;

var
  frmRptResStats: TfrmRptResStats;

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
  , uTaxCalc
  , uDImages
  , cxPivotGridAdvancedCustomization
  , uFinanceForcastLayout
  , DateUtils
  ;

const WM_LOAD_LAYOUT = WM_User + 401;
      WM_START_LOAD = WM_User + 402;


function cust_isTaxIncluted(Customer : string): boolean;
var
  rSet: TRoomerDataSet;
  s: string;
begin
  result := true;
  s := '';
  s := s + 'SELECT '#10;
  s := s + ' StayTaxIncluted  '#10;
  s := s + 'FROM '#10;
  s := s + '  customers '#10;
  s := s + 'WHERE (Customer = %s) '#10;
  s := format(s, [Customer]);

  rSet := CreateNewDataSet;
  try
    if rSet_bySQL(rSet, s) then
    begin
      result := rSet.fieldbyname('StayTaxIncluted').asBoolean;
    end;
  finally
    freeandnil(rSet);
  end;
end;


procedure TfrmRptResStats.WndProc(var message: TMessage);
begin
  if Message.Msg = WM_LOAD_LAYOUT then
    loadLayout(false)
  else
  if Message.Msg = WM_START_LOAD then
    loadLayout(true);

  inherited WndProc(message);
end;


procedure TfrmRptResStats.SetColumnProperties(ATableView: TcxGridTableView);

  procedure CreateFooterSummaryCell(AGridColumn: TcxGridColumn);
  begin
    AGridColumn.Summary.FooterKind := skSum;
    AGridColumn.Summary.FooterFormat := ',.00';
    AGridColumn.summary.GroupKind := skSum;
    AGridColumn.Summary.GroupFormat := ',.00';
  end;

  function ColumnByCaption(ACaption: string): TcxGridColumn;
  var
    I: Integer;
  begin
    Result := nil;
    for I := 0 to ATableView.ColumnCount - 1 do
      if ATableView.Columns[I].Caption = ACaption then
      begin
        Result := ATableView.Columns[I];
        Break;
      end;
  end;

var
  i : integer;
begin
  for I := 0 to pg001.FieldCount - 1 do
  begin
//    if (pg001.Fields[I].Area = faData) then
      if not pg001.Fields[I].DataBinding.ValueTypeClass.IsString then
      begin
        CreateFooterSummaryCell(ColumnByCaption(pg001.Fields[I].Caption));
        ColumnByCaption(pg001.Fields[I].Caption).PropertiesClass := TcxCurrencyEditProperties;
        TcxCurrencyEditProperties(ColumnByCaption(pg001.Fields[I].Caption).Properties).DisplayFormat := '#,##0.;-#,##0.';
      end;
  end;

end;


procedure TfrmRptResStats.updateDrilldown;
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



Procedure TfrmRptResStats.fillLocationsChkBox;
begin
end;




////////////////////////////////////////////////////////////////////////////////
///
/// Form
///
////////////////////////////////////////////////////////////////////////////////

procedure TfrmRptResStats.InitControles;
var
  y, m, d : word;
  idx : integer;
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
  lastDay := DaysInAMonth(y, m);
  zDateTo := encodeDate(y, m, lastDay);
  dtDateFrom.Date := zDateFrom;
  dtDateTo.Date := zDateTo;
  zSetDates := true;

  //**
  GetUseStatusDefault;
  isFirstTime := false;
  pagemain.ActivePageIndex := 0;
  pageData.ActivePageIndex := 0;
end;


procedure TfrmRptResStats.FormCreate(Sender: TObject);
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

procedure TfrmRptResStats.FormDestroy(Sender: TObject);
begin
  if pg001.Customization.Site <> nil then
  begin
    try
      pg001.Customization.Site := nil;
    Except
    end;
  end;
end;

procedure TfrmRptResStats.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmRptResStats.FormShow(Sender: TObject);
var
  RoomRentType : string;
  RoomRentVATCode : string;
  dTmp : double;
begin
  _restoreForm(self);
  InitControles;
  GetSel;

  pg001.Customization.Site := gbxCustomization;

  zRoomRentItem  := trim(uppercase(ctrlGetString('RoomRentItem')));
  zDiscountItem  := trim(uppercase(ctrlGetString('DiscountItem')));

  //**--

  zTaxesHolder := GetTaxesHolder;


  zTaxesItem           := trim(uppercase(zTaxesHolder.Booking_Item));
  zUseStayTax          := true;
  zuseStayTax          := zuseStayTax AND ctrlGetBoolean('useStayTax');



  zStayTaxIncluted     := trim(uppercase(zTaxesHolder.Incl_Excl)) = 'INCLUDED';   //NOT isStayTaxExcluded;
  zStayTaxPercentage   := trim(uppercase(zTaxesHolder.Tax_Type))  = 'PERCENTAGE'; //isStayTaxPercentage;
  zStayTaxPerCustomer  := trim(uppercase(zTaxesHolder.tax_base))  = 'PER_CUSTOMER'; // isStayTaxPerCustomer;
  zStayTaxAmount       := 0;


  zItemTypeInfoRent := d.Item_Get_ItemTypeInfo(trim(g.qRoomRentItem));
  zItemTypeInfoTax  := d.Item_Get_ItemTypeInfo(trim(zTaxesItem));

  zRoomRentVATPercentage := 0;
  RoomRentType := '';
  if glb.Items.Locate('item',zRoomRentItem,[]) then
  begin
    RoomRentType := glb.Items.FieldByName('ItemType').AsString;
  end;

  if glb.ItemTypes.Locate('itemtype',RoomRentType,[]) then
  begin
    RoomRentVATCode := glb.ItemTypes.FieldByName('VATCODE').AsString;
  end;

  if glb.VAT.Locate('VATCode',RoomRentVATCode,[]) then
  begin
    zRoomRentVATPercentage := glb.Items.GetFloatValue(glb.VAT.FieldByName('VATPercentage'));
  end;

  gbxCustomization.Visible :=  true;
  pg001.Customization.Visible :=  TRUE;

  PostMessage(handle, WM_START_LOAD, 0, 0);

end;


procedure TfrmRptResStats.cbxMonthCloseUp(Sender: TObject);
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
  m := cbxMonth.ItemIndex;

  zDateFrom := encodeDate(y, m, 1);
  lastDay := DaysInAMonth(y, m);
  zDateTo := encodeDate(y, m, lastDay);
  dtDateFrom.Date := zDateFrom;
  dtDateTo.Date := zDateTo;
  zSetDates := true;
end;

procedure TfrmRptResStats.cbxSelCloseUp(Sender: TObject);
begin
  PostMessage(handle, WM_LOAD_LAYOUT, 0, 0);
end;

procedure TfrmRptResStats.chkExcluteWaitingListClick(Sender: TObject);
begin
  ExcluteFilter;
end;


procedure TfrmRptResStats.Dril001DataChanged(Sender: TObject);
begin
  updateDrilldown;
end;

procedure TfrmRptResStats.dtDateFromChange(Sender: TObject);
begin
  if zSetDates then
  begin
    zDateFrom := dtDateFrom.Date;
    zDateTo := dtDateTo.Date;

    cbxYear.ItemIndex := 0;
    cbxMonth.ItemIndex := 0;
  end;
end;

procedure TfrmRptResStats.dtDateToChange(Sender: TObject);
begin
  if zSetDates then
  begin
    zDateFrom := dtDateFrom.Date;
    zDateTo := dtDateTo.Date;

    cbxYear.ItemIndex := 0;
    cbxMonth.ItemIndex := 0;
  end;
end;


procedure TfrmRptResStats.ExcluteFilter;
var
  sFilter : string;
  sNoRooms : string;
  sRooms   : string;
  i : integer;
begin
end;


procedure TfrmRptResStats.SheetMainResultShow(Sender: TObject);
var
   c : integer;
begin
  pg001.Customization.Visible :=  TRUE;

//  showmessage(tvRoomsDate.DataController.Filter.FilterText);
//
  pg001.DataController.Filter.StoreItemLinkNames := False;
  pg001.DataController.Filter.Assign(tvRoomsDate.DataController.Filter, True);

  if tvRoomsDate.DataController.Filter.IsFiltering then
  begin
    labIsFiltered.Caption := 'Data has Prefilter';
  end else
  begin
    labIsFiltered.Caption := 'Data Not Filtered';
  end;
end;

procedure TfrmRptResStats.sSpeedButton1Click(Sender: TObject);
var
  sDescription : string;
  sText : string;
  oldDescription : string;
  s : string;
  itemindex : integer;
begin
  sDescription := cbxSel.Items[cbxSel.ItemIndex];
  sText := propertiesstoreGetText(sDescription);
  oldDescription := sDescription;
  openFinanceForcastLayout(sdescription,sText);
//  if sdescription <> cbxSel.Items[cbxSel.ItemIndex] then
//  begin
    sDescription := trim(sDescription);
    if sDescription = '' then exit;

    s := '';
    s := s + ' UPDATE propertiesstore '+#10;
    s := s + '   SET '+#10;
    s := s+ '    Description =' + _db(sDescription)+#10;
    s := s+ '   ,TextContainer2='+_db(sText)+#10;
    s := s + ' WHERE '+#10;
    s := s + '   description = ' + _db(oldDescription);

    if cmd_bySQL(s) then
    begin
      cbxSel.Items[cbxSel.ItemIndex] := sDescription;
      itemindex := cbxSel.Items.IndexOf(sDescription);
      cbxSel.ItemIndex := itemindex;
    end;
//  end;
end;



procedure TfrmRptResStats.sTabSheet2Show(Sender: TObject);
begin
  pg001.Customization.Visible :=  TRUE;
end;

function TfrmRptResStats.StatusSQL : string;
var
  sFilter  : string;
  sNoRooms : string;
  sRooms   : string;
  i        : integer;

begin
  result := '';

  if chkExcluteWaitingListNoRooms.checked then sNoRooms       := sNoRooms+_db('O')+',';
  if chkExcludeWaitingListNonOptional_NoRooms.checked then sNoRooms       := sNoRooms+_db('L')+',';
  if chkExcluteOrderNoRooms.checked then       sNoRooms       := sNoRooms+_db('P')+',';
  if chkExcluteGuestNoRooms.checked then       sNoRooms       := sNoRooms+_db('G')+',';
  if chkExcluteDepartedNoRooms.checked then    sNoRooms       := sNoRooms+_db('D')+',';
  if chkExcluteAlotmentNoRooms.checked then    sNoRooms       := sNoRooms+_db('A')+',';
  if chkExcluteBlockedNoRooms.checked then     sNoRooms       := sNoRooms+_db('B')+',';
  if chkExcluteNoshowNoRooms.checked then      sNoRooms       := sNoRooms+_db('N')+',';

  if chkExcluteWaitingList.checked then sRooms       := sRooms+_db('O')+',';
  if chkExcludeWaitingListNonOptional.checked then sRooms       := sRooms+_db('L')+',';
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

procedure TfrmRptResStats.tvRoomsDateincomeTotalGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
   AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

//---------------------------------------------------------------------
// Get data QUERYS
//
//=====================================================================
function TfrmRptResStats.GetRRinList : string;
var
  s      : string;
  rrList : TstringList;
  i      : integer;
begin
  result := '';
  rrList := d.RRlst_FromTo(zDateFrom, zDateTo);
  try
    s := '';
    for i := 0 to rrList.Count - 1 do
    begin
      s := s+rrList[i]+',';
    end;
    if length(s) > 0 then
    begin
      delete(s,length(s),1);
      s := '('+s+')';
      result := s;
    end;
    zRoomReservationCount := rrList.count;
  finally
    freeandNil(rrList);
  end;
  result := s;
end;

function TfrmRptResStats.GetRVinList : string;
var
  s      : string;
  rvList : TstringList;
  i      : integer;
begin
  result := '';
  rvList := d.RVlst_FromTo(zDateFrom, zDateTo);
  try
    s := '';
    for i := 0 to rvList.Count - 1 do
    begin
      if rvList[i] <> '0' then
        s := s+rvList[i]+',';
    end;
    if length(s) > 0 then
    begin
      delete(s,length(s),1);
      s := '('+s+')';
      result := s;
    end;
    zReservationCount := rvList.count;
  finally
    freeandNil(rvList);
  end;
  result := s;
end;




//---------------------------------------------------------------------
// Grid and memtables
//
//=====================================================================



function TfrmRptResStats.GetAutoName : string;
var
  I, J, AAreaIndex: Integer;
  FilterList : array of TcxPivotGridField;
  DataList   : array of TcxPivotGridField;
  RowList    : array of TcxPivotGridField;
  ColumnList : array of TcxPivotGridField;
  ATemp: TcxPivotGridField;

  aName    : string;
  aCaption : string;

begin
  result := '';

  for I := 0 to pg001.FieldCount - 1 do
  begin
    if pg001.Fields[I].Area = faFilter then
    begin
      SetLength(FilterList, Length(FilterList) + 1);
      FilterList[Length(FilterList) - 1] := pg001.Fields[I];
    end;

    if pg001.Fields[I].Area = faData then
    begin
      SetLength(DataList, Length(DataList) + 1);
      DataList[Length(DataList) - 1] := pg001.Fields[I];
    end;

    if pg001.Fields[I].Area = faRow then
    begin
      SetLength(rowList, Length(rowList) + 1);
      rowList[Length(rowList) - 1] := pg001.Fields[I];
    end;

    if pg001.Fields[I].Area = faColumn then
    begin
      SetLength(ColumnList, Length(ColumnList) + 1);
      ColumnList[Length(ColumnList) - 1] := pg001.Fields[I];
    end;
  end;

   aName := '';
   for i := 0 to Length(DataList) - 1 do
   begin
     aCaption := DataList[I].Caption;
     aName := aName + aCaption + ','
   end;

   if length(aName) > 1 then delete(aName,length(aName),1);

   aName := aName+' ON ';
   for i := 0 to Length(ColumnList) - 1 do
   begin
     aCaption := ColumnList[I].Caption;
     aName := aName + aCaption + ','
   end;

   if length(aName) > 1 then delete(aName,length(aName),1);
   aName := aName + ' BY ';

   for i := 0 to Length(rowList) - 1 do
   begin
     aCaption := rowList[I].Caption;
     aName := aName + aCaption + ','
   end;
   if length(aName) > 1 then delete(aName,length(aName),1);
   result := aName;
end;


procedure TfrmRptResStats.sButton2Click(Sender: TObject);
begin
  //**
  screen.Cursor := crHourGlass;
  Dril001.DisableControls;
  try
    SetColumnProperties(tvDrill001);
    tvDrill001.ApplyBestFit;
  finally
    Dril001.EnableControls;
    screen.Cursor := crDefault;
  end;

end;

procedure TfrmRptResStats.sButton3Click(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
begin
  iReservation := dril001.fieldbyname('Reservation').AsInteger;
  iRoomReservation := dril001.fieldbyname('RoomReservation').AsInteger;

  if EditReservation(iReservation, iRoomReservation) then
  begin
    // **
  end;
end;

procedure TfrmRptResStats.sButton4Click(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
  theData : recPersonHolder;
begin
  iReservation := Dril001.fieldbyname('Reservation').AsInteger;
  iRoomReservation := Dril001.fieldbyname('RoomReservation').AsInteger;

  initPersonHolder(theData);
  theData.RoomReservation := iRoomreservation;
  theData.Reservation := iReservation;
  theData.name := '';

  if openGuestProfile(actNone,theData) then
  begin
    //**
  end;
end;




procedure TfrmRptResStats.AddGroupInvoiceSumsData;
var
  startTick : integer;
  stopTick  : integer;
  SQLms     : integer;

  itemID       : string;

  Reservation : integer;
  RoomReservation : integer;
  invoicenumber : integer;
  RoomCount : integer;
  Avr : double;
  Total : double;

  dayCount : integer;
  avrVAT   : double;
  vat : double;
  noItems : double;

  RRGuestCount : integer;
  stayTaxHolder : recCityTaxResultHolder;
  Customer : string;
  Currency : string;


begin
  kbmGroupInvoiceSums_.DisableControls;
  kbmRoomsDate_.DisableControls;
  try
    startTick := GetTickCount;

    kbmRoomsDate_.SortFields := 'Reservation';
    kbmRoomsDate_.Sort([]);


    kbmGroupInvoiceSums_.SortFields := 'Reservation';
    kbmGroupInvoiceSums_.Sort([]);

    kbmGroupInvoiceSums_.First;
    while not kbmGroupInvoiceSums_.eof do
    begin
      Reservation     := kbmGroupInvoiceSums_.FieldByName('Reservation').AsInteger;

      invoiceNumber   := kbmGroupInvoiceSums_.FieldByName('InvoiceNumber').AsInteger;
      RoomCount       := kbmGroupInvoiceSums_.FieldByName('RoomCount').AsInteger;
      NoItems         := kbmGroupInvoiceSums_.FieldByName('NoItems').AsFloat; //-96

      Total           := kbmGroupInvoiceSums_.FieldByName('total').AsFloat;
      VAT             := kbmGroupInvoiceSums_.FieldByName('TotalVat').AsFloat;

      itemID  := trim(uppercase(kbmGroupInvoiceSums_.FieldByName('ItemID').AsString));

      dayCount := 0;
      RRGuestCount  := 0;

      if kbmRoomsDate_.Locate('Reservation',Reservation,[]) then
      begin
        while (NOT kbmRoomsDate_.EOF) AND (kbmRoomsDate_.FieldByName('Reservation').AsInteger = Reservation) do
        begin
          inc(dayCount);
          kbmRoomsDate_.Next;
        end;
      end;


      if kbmRoomsDate_.Locate('Reservation',Reservation,[]) then
      begin
        while (NOT kbmRoomsDate_.EOF) AND (kbmRoomsDate_.FieldByName('Reservation').AsInteger = Reservation) do
        begin
          customer := kbmRoomsDate_.FieldByName('Customer').AsString;
          currency := kbmRoomsDate_.FieldByName('Currency').AsString;

          avr := 0;
          avrVat := 0;
          if DayCount <> 0 then
          begin
            avr     := Total/dayCount;
            avrVAT  := vat/dayCount;
          end;

          kbmRoomsDate_.Edit;

          if VAT <> 0.00 then
          begin
            if invoicenumber > 1 then
            begin
              kbmRoomsDate_.FieldByName('VatBilled').AsFloat := kbmRoomsDate_.FieldByName('VatBilled').AsFloat+avrVAT;
              kbmRoomsDate_.FieldByName('TaxesBilled').AsFloat := kbmRoomsDate_.FieldByName('TaxesBilled').AsFloat+avrVAT;
            end else
            begin
              kbmRoomsDate_.FieldByName('VatUnBilled').AsFloat := kbmRoomsDate_.FieldByName('VatUnBilled').AsFloat+avrVAT;
              kbmRoomsDate_.FieldByName('TaxesUnBilled').AsFloat := kbmRoomsDate_.FieldByName('TaxesUnBilled').AsFloat+avrVAT;
            end;
          end;

          if itemID = zRoomRentItem then
          begin
            kbmRoomsDate_.fieldbyname('itemId').asstring := ItemId;
            RRGuestCount  := kbmRoomsDate_.FieldByName('RRGuestCount').asinteger;
            stayTaxHolder := CalculateCityTax(total, currency, Customer, true,DayCount,rrGuestCount);

            if invoicenumber > 1 then
            begin
              if stayTaxHolder.Incluted then
              begin
                kbmRoomsDate_.FieldByName('CTaxTotal').AsFloat        := stayTaxHolder.CityTax;
                kbmRoomsDate_.FieldByName('CTaxTotalWoVAT').AsFloat   := stayTaxHolder.CityTax-stayTaxHolder.CityTaxVAT;
                kbmRoomsDate_.FieldByName('CTaxBilled').AsFloat       := stayTaxHolder.CityTax;
                kbmRoomsDate_.FieldByName('vatCTaxBilled').AsFloat    := stayTaxHolder.CityTaxVAT;

                kbmRoomsDate_.FieldByName('VatRentBilled').AsFloat    := kbmRoomsDate_.FieldByName('VatRentBilled').AsFloat+AvrVAT;
                kbmRoomsDate_.FieldByName('TaxesBilled').AsFloat      := kbmRoomsDate_.FieldByName('TaxesBilled').AsFloat+stayTaxHolder.CityTax-stayTaxHolder.CityTaxVAT;
                kbmRoomsDate_.FieldByName('RoomRentBilled').AsFloat := kbmRoomsDate_.FieldByName('RoomRentBilled').AsFloat+avr-stayTaxHolder.CityTax;
              end else
              begin
                kbmRoomsDate_.FieldByName('VatRentBilled').AsFloat    := kbmRoomsDate_.FieldByName('VatRentBilled').AsFloat+AvrVAT;
                kbmRoomsDate_.FieldByName('TaxesBilled').AsFloat      := kbmRoomsDate_.FieldByName('TaxesBilled').AsFloat;
                kbmRoomsDate_.FieldByName('RoomRentBilled').AsFloat   := kbmRoomsDate_.FieldByName('RoomRentBilled').AsFloat+avr;
              end;
            end else
            begin
              if stayTaxHolder.Incluted then
              begin
                kbmRoomsDate_.FieldByName('CTaxTotal').AsFloat           := stayTaxHolder.CityTax;
                kbmRoomsDate_.FieldByName('CTaxTotalWoVAT').AsFloat      := stayTaxHolder.CityTax-stayTaxHolder.CityTaxVAT;
                kbmRoomsDate_.FieldByName('CTaxUnbilled').AsFloat        := stayTaxHolder.CityTax;
                kbmRoomsDate_.FieldByName('vatCTaxUnBilled').AsFloat     := stayTaxHolder.CityTaxVAT;


                kbmRoomsDate_.FieldByName('VatRentUnBilled').AsFloat     := kbmRoomsDate_.FieldByName('VatRentUnBilled').AsFloat+AvrVAT;
                kbmRoomsDate_.FieldByName('TaxesUnBilled').AsFloat       := kbmRoomsDate_.FieldByName('TaxesUnBilled').AsFloat+stayTaxHolder.CityTax-stayTaxHolder.CityTaxVAT;
                kbmRoomsDate_.FieldByName('RoomRentUnBilled').AsFloat := kbmRoomsDate_.FieldByName('RoomRentUnBilled').AsFloat+avr-stayTaxHolder.CityTax;
              end;
            end;
          end else
          if itemID = zDiscountItem then
          begin
            kbmRoomsDate_.fieldbyname('itemId').asstring := ItemId;
            if invoicenumber > 1 then
            begin
              kbmRoomsDate_.FieldByName('RoomDiscountBilled').AsFloat := kbmRoomsDate_.FieldByName('RoomDiscountBilled').AsFloat+avr;
              kbmRoomsDate_.FieldByName('VatRentBilled').AsFloat      := kbmRoomsDate_.FieldByName('VatRentBilled').AsFloat+AvrVAT;
            end else
            begin
              kbmRoomsDate_.FieldByName('RoomDiscountUnBilled').AsFloat := kbmRoomsDate_.FieldByName('RoomDiscountUnBilled').AsFloat+avr;
              kbmRoomsDate_.FieldByName('VatRentUnBilled').AsFloat      := kbmRoomsDate_.FieldByName('VatRentUnBilled').AsFloat+AvrVAT;
            end;
          end else
          if itemID = zTaxesHolder.Booking_Item then
          begin
            if invoicenumber > 1 then
            begin
              if stayTaxHolder.Incluted then
              begin
                kbmRoomsDate_.fieldbyname('itemId').asstring := ItemId;
                RRGuestCount  := kbmRoomsDate_.FieldByName('RRGuestCount').asinteger;
  //              stayTaxHolder := CalculateCityTax(total, 'ISK', '0000000000',true,1,rrGuestCount);
                stayTaxHolder := CalculateCityTax(total, currency, Customer, true,DayCount,rrGuestCount);
              end else
              begin
                kbmRoomsDate_.FieldByName('CTaxBilled').AsFloat        := kbmRoomsDate_.FieldByName('CTaxBilled').AsFloat+Avr;
                kbmRoomsDate_.FieldByName('vatCTaxUnBilled').AsFloat   := AvrVAT;
                kbmRoomsDate_.FieldByName('TaxesBilled').AsFloat       := kbmRoomsDate_.FieldByName('TaxesBilled').AsFloat+avr;
              end;
            end else
            begin
              kbmRoomsDate_.FieldByName('CTaxUnBilled').AsFloat := kbmRoomsDate_.FieldByName('CTaxUnBilled').AsFloat+Avr;
              kbmRoomsDate_.FieldByName('TaxesUnBilled').AsFloat := kbmRoomsDate_.FieldByName('TaxesUnBilled').AsFloat+avr;
            end;
          end else
          begin
            kbmRoomsDate_.fieldbyname('itemId').asstring := ItemId;
            if invoicenumber > 1 then
            begin
              kbmRoomsDate_.FieldByName('ItemsBilled').AsFloat := kbmRoomsDate_.FieldByName('ItemsBilled').AsFloat+avr;
              kbmRoomsDate_.FieldByName('VatItemsBilled').AsFloat := kbmRoomsDate_.FieldByName('VatItemsBilled').AsFloat+AvrVAT;
            end else
            begin
              kbmRoomsDate_.FieldByName('ItemsUnBilled').AsFloat := kbmRoomsDate_.FieldByName('ItemsUnBilled').AsFloat+avr;
              kbmRoomsDate_.FieldByName('VatItemsUnBilled').AsFloat := kbmRoomsDate_.FieldByName('VatItemsUnBilled').AsFloat+AvrVAT;
            end;
            kbmRoomsDate_.FieldByName('ItemsTotal').AsFloat := kbmRoomsDate_.FieldByName('ItemsBilled').AsFloat+kbmRoomsDate_.FieldByName('ItemsUnBilled').AsFloat;
          end;

          kbmRoomsDate_.FieldByName('Invoicenumbers').AsString := kbmRoomsDate_.FieldByName('Invoicenumbers').AsString+inttostr(Invoicenumber)+';';

          kbmRoomsDate_.post;
          kbmRoomsDate_.Next;
        end;
      end;

      kbmGroupInvoiceSums_.next;
    end;

    stopTick := GetTickCount;
    SQLms    := stopTick - startTick;
  finally
    kbmRoomsDate_.EnableControls;
    kbmGroupInvoiceSums_.EnableControls
  end;
end;



procedure TfrmRptResStats.AddInvoicelineData;
var
  startTick : integer;
  stopTick  : integer;
  SQLms     : integer;

  itemID       : string;
  RoomReservation : integer;
  Reservation : integer;
  invoicenumber : integer;
  Total : double;
  avr : double;
  dayCount : integer;

  VAT    : double;
  avrVAT : double;
  RRGuestCount : integer;

  stayTaxHolder : recCityTaxResultHolder;
  customer : string;
  currency : string;
begin
//  kbmInvoicelines_.DisableControls;
//  kbmRoomsDate_.DisableControls;
//  try

    startTick := GetTickCount;

    kbmInvoicelines_.SortFields := 'RoomReservation';
    kbmInvoicelines_.Sort([]);

    kbmInvoicelines_.First;
    while not kbmInvoicelines_.eof do
    begin
      RoomReservation := kbmInvoicelines_.FieldByName('RoomReservation').AsInteger;
      invoiceNumber   := kbmInvoicelines_.FieldByName('InvoiceNumber').AsInteger;
      itemID          := trim(uppercase(kbmInvoicelines_.FieldByName('ItemID').AsString));
      total           := kbmInvoiceLines_.FieldByName('Total').asfloat;
      VAT             := kbmInvoiceLines_.FieldByName('VAT').asfloat;
      Reservation     := kbmInvoiceLines_.FieldByName('Reservation').asinteger;

      if kbmRoomsDate_.Locate('roomReservation',roomReservation,[]) then
      begin
        while (NOT kbmRoomsDate_.EOF) AND (kbmRoomsDate_.FieldByName('RoomReservation').AsInteger = RoomReservation) do
        begin
          dayCount        := kbmRoomsDate_.FieldByName('dayCount').asInteger;
          RRGuestCount    := kbmRoomsDate_.FieldByName('RRGuestCount').asinteger;
          Customer        := kbmRoomsDate_.FieldByName('Customer').asString;
          Currency        := kbmRoomsDate_.FieldByName('Currency').asString;

          avr := 0;
          if DayCount <> 0 then
          begin
             avr     := Total/DayCount;
             avrVAT  := vat/DayCount;
          end;

          kbmRoomsDate_.Edit;

          if VAT <> 0.00 then
          begin
            if invoicenumber > 1 then
            begin
              kbmRoomsDate_.FieldByName('VatBilled').AsFloat := kbmRoomsDate_.FieldByName('VatBilled').AsFloat+avrVAT;
              kbmRoomsDate_.FieldByName('TaxesBilled').AsFloat := kbmRoomsDate_.FieldByName('TaxesBilled').AsFloat+avrVAT;
            end else
            begin
              kbmRoomsDate_.FieldByName('VatUnBilled').AsFloat := kbmRoomsDate_.FieldByName('VatUnBilled').AsFloat+avrVAT;
              kbmRoomsDate_.FieldByName('TaxesUnBilled').AsFloat := kbmRoomsDate_.FieldByName('TaxesUnBilled').AsFloat+avrVAT;
            end;
          end;

          if itemID = zRoomRentItem then
          begin
            kbmRoomsDate_.fieldbyname('itemId').asstring := ItemId;
//            stayTaxHolder := CalculateCityTax(total, 'ISK', '0000000000', true,1,rrGuestCount);
            stayTaxHolder := CalculateCityTax(total, currency, Customer, true,DayCount,rrGuestCount);

            if invoicenumber > 1 then
            begin
              if stayTaxHolder.Incluted then
              begin
                kbmRoomsDate_.FieldByName('CTaxTotal').AsFloat        := stayTaxHolder.CityTax;
                kbmRoomsDate_.FieldByName('CTaxTotalWoVAT').AsFloat   := stayTaxHolder.CityTax-stayTaxHolder.CityTaxVAT;
                kbmRoomsDate_.FieldByName('CTaxBilled').AsFloat       := stayTaxHolder.CityTax;
                kbmRoomsDate_.FieldByName('vatCTaxBilled').AsFloat    := stayTaxHolder.CityTaxVAT;

                kbmRoomsDate_.FieldByName('VatRentBilled').AsFloat    := kbmRoomsDate_.FieldByName('VatRentBilled').AsFloat+AvrVAT;
                kbmRoomsDate_.FieldByName('TaxesBilled').AsFloat      := kbmRoomsDate_.FieldByName('TaxesBilled').AsFloat+stayTaxHolder.CityTax-stayTaxHolder.CityTaxVAT;
                kbmRoomsDate_.FieldByName('RoomRentBilled').AsFloat := kbmRoomsDate_.FieldByName('RoomRentBilled').AsFloat+avr-stayTaxHolder.CityTax;
              end else
              begin
                kbmRoomsDate_.FieldByName('VatRentBilled').AsFloat    := kbmRoomsDate_.FieldByName('VatRentBilled').AsFloat+AvrVAT;
                kbmRoomsDate_.FieldByName('TaxesBilled').AsFloat      := kbmRoomsDate_.FieldByName('TaxesBilled').AsFloat;
                kbmRoomsDate_.FieldByName('RoomRentBilled').AsFloat   := kbmRoomsDate_.FieldByName('RoomRentBilled').AsFloat+avr;
              end;
            end else
            begin
              if stayTaxHolder.Incluted then
              begin
                kbmRoomsDate_.FieldByName('CTaxTotal').AsFloat           := stayTaxHolder.CityTax;
                kbmRoomsDate_.FieldByName('CTaxTotalWoVAT').AsFloat      := stayTaxHolder.CityTax-stayTaxHolder.CityTaxVAT;
                kbmRoomsDate_.FieldByName('CTaxUnbilled').AsFloat        := stayTaxHolder.CityTax;
                kbmRoomsDate_.FieldByName('vatCTaxUnBilled').AsFloat     := stayTaxHolder.CityTaxVAT;


                kbmRoomsDate_.FieldByName('VatRentUnBilled').AsFloat     := kbmRoomsDate_.FieldByName('VatRentUnBilled').AsFloat+AvrVAT;
                kbmRoomsDate_.FieldByName('TaxesUnBilled').AsFloat       := kbmRoomsDate_.FieldByName('TaxesUnBilled').AsFloat+stayTaxHolder.CityTax-stayTaxHolder.CityTaxVAT;
                kbmRoomsDate_.FieldByName('RoomRentUnBilled').AsFloat := kbmRoomsDate_.FieldByName('RoomRentUnBilled').AsFloat+avr-stayTaxHolder.CityTax;
              end;
            end;
          end else
          if itemID = zDiscountItem then
          begin
            kbmRoomsDate_.fieldbyname('itemId').asstring := ItemId;
            if invoicenumber > 1 then
            begin
              kbmRoomsDate_.FieldByName('RoomDiscountBilled').AsFloat := kbmRoomsDate_.FieldByName('RoomDiscountBilled').AsFloat+avr;
              kbmRoomsDate_.FieldByName('VatRentBilled').AsFloat      := kbmRoomsDate_.FieldByName('VatRentBilled').AsFloat+AvrVAT;
            end else
            begin
              kbmRoomsDate_.FieldByName('RoomDiscountUnBilled').AsFloat := kbmRoomsDate_.FieldByName('RoomDiscountUnBilled').AsFloat+avr;
              kbmRoomsDate_.FieldByName('VatRentUnBilled').AsFloat      := kbmRoomsDate_.FieldByName('VatRentUnBilled').AsFloat+AvrVAT;
            end;
          end else
          if itemID = zTaxesHolder.Booking_Item then
          begin
            if invoicenumber > 1 then
            begin
              if stayTaxHolder.Incluted then
              begin
                kbmRoomsDate_.fieldbyname('itemId').asstring := ItemId;
//                stayTaxHolder := CalculateCityTax(total, 'ISK', '0000000000',true,1,rrGuestCount);
            stayTaxHolder := CalculateCityTax(total, currency, Customer, true,DayCount,rrGuestCount);
              end else
              begin
                kbmRoomsDate_.FieldByName('CTaxBilled').AsFloat        := kbmRoomsDate_.FieldByName('CTaxBilled').AsFloat+Avr;
                kbmRoomsDate_.FieldByName('vatCTaxUnBilled').AsFloat   := AvrVAT;
                kbmRoomsDate_.FieldByName('TaxesBilled').AsFloat       := kbmRoomsDate_.FieldByName('TaxesBilled').AsFloat+avr;
              end;
            end else
            begin
              kbmRoomsDate_.FieldByName('CTaxUnBilled').AsFloat := kbmRoomsDate_.FieldByName('CTaxUnBilled').AsFloat+Avr;
              kbmRoomsDate_.FieldByName('TaxesUnBilled').AsFloat := kbmRoomsDate_.FieldByName('TaxesUnBilled').AsFloat+avr;
            end;
          end else
          begin
            kbmRoomsDate_.fieldbyname('itemId').asstring := ItemId;
            if invoicenumber > 1 then
            begin
              kbmRoomsDate_.FieldByName('ItemsBilled').AsFloat := kbmRoomsDate_.FieldByName('ItemsBilled').AsFloat+avr;
              kbmRoomsDate_.FieldByName('VatItemsBilled').AsFloat := kbmRoomsDate_.FieldByName('VatItemsBilled').AsFloat+AvrVAT;
            end else
            begin
              kbmRoomsDate_.FieldByName('ItemsUnBilled').AsFloat := kbmRoomsDate_.FieldByName('ItemsUnBilled').AsFloat+avr;
              kbmRoomsDate_.FieldByName('VatItemsUnBilled').AsFloat := kbmRoomsDate_.FieldByName('VatItemsUnBilled').AsFloat+AvrVAT;
            end;
            kbmRoomsDate_.FieldByName('ItemsTotal').AsFloat := kbmRoomsDate_.FieldByName('ItemsBilled').AsFloat+kbmRoomsDate_.FieldByName('ItemsUnBilled').AsFloat;
          end;

          kbmRoomsDate_.FieldByName('Invoicenumbers').AsString := kbmRoomsDate_.FieldByName('Invoicenumbers').AsString+inttostr(Invoicenumber)+';';
          kbmRoomsDate_.post;
          kbmRoomsDate_.Next;
        end;
      end;
      kbmInvoicelines_.next;
    end;

    stopTick := GetTickCount;
    SQLms    := stopTick - startTick;
//  finally
//    kbmRoomsDate_.EnableControls;
//    kbmInvoicelines_.EnableControls
//  end;

end;

procedure TfrmRptResStats.kbmRoomsDate_BeforePost(DataSet: TDataSet);
var
  discount : double;
  isPercentage : boolean;
  DiscountAmount : double;
  nativeRate     : double;
  paid  : boolean;
  RoomVat : double;

  ItemID : string;

  dtArrival   : Tdate;
  dtDeparture : TDate;
  DayCount    : integer;

  RoomRentBilled      : double;
  RoomRentUnBilled    : double;
  RoomRentTotal       : double;
  RoomRentTotalWoVAT  : double;

  RoomDiscountBilled   : double;
  RoomDiscountUnBilled : double;
  RoomDiscountTotal    : double;

  TaxesBilled    : double;
  TaxesUnbilled  : double;
  TaxesTotal     : double;

  VatBilled        : double;
  VatUnBilled      : double;
  VatRentUnbilled  : Double;
  VatRentBilled   : double;
  VatRentTotal   : double;

  VatItemsBilled    : double;
  VatItemsUnbilled  : double;
  VatItemsTotal     : double;


  VatTotal         : double;

  CtaxBilled     : double;
  CtaxUnbilled   : double;
  CtaxTotal      : double;
  CTaxTotalWoVAT : double;

  ItemsBilled    : double;
  ItemsUnBilled  : double;
  ItemsTotal     : double;
  ItemsTotalWoVAT: double;

  VatCtaxTotal     : double;
  VatCtaxBilled    : double;
  VatCtaxUnBilled  : double;

  CityTax : double;

  CtaxVAT : Double;


  customer : string;

  taxvat : double;

  nights : double;

  RRGuestCount : integer;
  Reservation : integer;

  IncomeTotal      : double;
  IncomeTotalWoVAT : Double;

  VatDiscountBilled    : Double;
  VatDiscountUnbilled  : Double;
  VatDiscountTotal     : Double;

  discountVAT          : Double;

  stayTaxHolder : recCityTaxResultHolder;
  Currency : string;

begin

  if not zFirsttime then exit;

  taxVat := 0;
  nights := 1;

  discount        := 0;
  isPercentage    := false;
  DiscountAmount  := 0;
  nativeRate      := 0;
  paid            := false;
  RoomVat         := 0;

  DayCount        := 0;

  incomeTotal := 0.00;

  RoomRentBilled      := 0.00;
  RoomRentUnBilled    := 0.00;
  RoomRentTotal       := 0.00;

  RoomDiscountBilled   := 0.00;
  RoomDiscountUnBilled := 0.00;
  RoomDiscountTotal    := 0.00;

  TaxesBilled    := 0.00;
  TaxesUnbilled  := 0.00;
  TaxesTotal     := 0.00;

  ItemsBilled    := 0.00;
  ItemsUnBilled  := 0.00;
  ItemsTotal     := 0.00;

  VatBilled        := 0.00;
  VatRentUnbilled  := 0.00;
  VatTotal         := 0.00;

  VatCtaxTotal     := 0.00;
  VatCtaxBilled    := 0.00;
  VatCtaxUnBilled  := 0.00;

  CtaxBilled     := 0.00;
  CtaxUnbilled   := 0.00;
  CtaxTotal      := 0.00;

  CtaxVAT        := 0.00;
  CTaxTotalWoVAT := 0.00;

  VatItemsBilled    := 0.00;
  VatItemsUnbilled  := 0.00;
  VatItemsTotal     := 0.00;

  VatDiscountBilled    := 0.00;
  VatDiscountUnbilled  := 0.00;
  VatDiscountTotal     := 0.00;

  dataset.FieldByName('dtDate').AsDateTime := _dbDateToDate(dataset.FieldByName('aDate').AsString);

  discount     := dataset.FieldByName('discount').AsFloat;
  isPercentage := dataset.FieldByName('isPercentage').AsBoolean;
  NativeRate   := dataset.FieldByName('NativeRate').AsFloat;
  Paid         := dataset.FieldByName('Paid').AsBoolean;
  customer     := dataset.FieldByName('customer').AsString;
  ItemId       := dataset.FieldByName('ItemId').AsString;
  Currency     := dataset.FieldByName('Currency').AsString;

  dtArrival   := _dbDateToDate(dataset.FieldByName('sArrival').AsString);
  dtDeparture := _dbDateToDate(dataset.FieldByName('sDeparture').AsString);

  dataset.FieldByName('DayCount').asInteger := trunc(dtDeparture)-trunc(dtArrival);

  if dataset.FieldByName('isNoRoom').AsBoolean then
  begin
    dataset.FieldByName('FilterFlag').AsString := dataset.FieldByName('ResFlag').AsString+'N';
  end else
  begin
    dataset.FieldByName('FilterFlag').AsString := dataset.FieldByName('ResFlag').AsString+'R';
  end;



  discountAmount := 0;

  if itemID <> zDiscountItem then
  begin
    if discount <> 0 then
    begin
      if isPercentage then
      begin
        discountAmount := nativeRate*discount/100;
      end else
      begin
        discountAmount := discount;
      end;
    end;
    discountAmount   := discountAmount*-1;
    DiscountVAT     := _calcVAT(discountAmount, zItemTypeInfoRent.VATPercentage);
    dataset.FieldByName('discountAmount').AsFloat := discountAmount;
  end;

  RRGuestCount := dataset.FieldByName('RRGuestCount').AsInteger;
  reservation  := dataset.FieldByName('reservation').AsInteger;
  reservation  := dataset.FieldByName('reservation').AsInteger;


  if not paid then
  begin
//    stayTaxHolder := CalculateCityTax(NativeRate, '', Customer,true,1,RRGuestCount);
    stayTaxHolder := CalculateCityTax(NativeRate, currency, Customer, true,DayCount,rrGuestCount);

    CtaxUnbilled     := stayTaxHolder.CityTax;
    vatCTaxUnbilled  := stayTaxHolder.CityTaxVAT;

    RoomDiscountUnBilled := discountAmount;
    vatDiscountUnBilled := DiscountVAT;


    RoomRentUnBilled := NativeRate+RoomDiscountUnBilled;

    if stayTaxHolder.Incluted then
    begin
      RoomRentUnBilled := RoomRentUnBilled-CtaxUnbilled;
    end;

    if zRoomRentVATPercentage <> 0 then
    begin
      VatRentUnbilled := _calcVAT(RoomRentUnBilled, zRoomRentVATPercentage);
    end;

//    if (VatRentUnBilled <> 0.00) then
//    begin
//      VatRentUnBilled := VatRentunBilled-VatCtaxUnBilled;
//    end;

    TaxesUnBilled        := VatRentUnbilled + vatCTaxUnbilled+CtaxUnbilled-vatCTaxUnbilled;
  end else
  begin
    vatDiscountBilled := DiscountVAT;
    vatCTaxUnBilled := dataset.FieldByName('vatCTaxUnBilled').AsFloat;
  end;

  vatDiscountTotal := vatDiscountBilled+vatDiscountUnBilled;

  RoomDiscountBilled  := dataset.FieldByName('RoomDiscountBilled').AsFloat;
  RoomRentBilled      := dataset.FieldByName('RoomRentBilled').AsFloat;;
  RoomRentBilled      := RoomRentBilled+RoomDiscountBilled;
  RoomDiscountTotal   := RoomDiscountBilled+RoomDiscountUnbilled;

  TaxesBilled         := dataset.FieldByName('TaxesBilled').AsFloat;

  VatBilled           := dataset.FieldByName('VatBilled').AsFloat;
  VatUnBilled         := dataset.FieldByName('VatUnBilled').AsFloat+VatRentUnbilled + vatCTaxUnbilled;

  VatItemsBilled       := dataset.FieldByName('VatItemsBilled').AsFloat;
  VatItemsUnBilled     := dataset.FieldByName('VatItemsUnBilled').AsFloat;
  VatItemsTotal        := VatItemsBilled+VatItemsUnBilled;

  ItemsBilled         := dataset.FieldByName('ItemsBilled').AsFloat;
  ItemsUnBilled       := dataset.FieldByName('ItemsUnBilled').AsFloat;
  ItemsTotal          := ItemsBilled+itemsUnbilled;

  VatCtaxBilled       := dataset.FieldByName('VatCtaxBilled').AsFloat;
  CtaxBilled          := dataset.FieldByName('CtaxBilled').AsFloat;

  VatRentBilled       := dataset.FieldByName('VatRentBilled').AsFloat;
  if (VatRentBilled <> 0.00) and (ItemsTotal=0.00) and (itemID <> zDiscountItem) then
  begin
    VatRentBilled := VatRentBilled-VatCtaxBilled;
  end;

  VatRentTotal        := VatRentBilled+VatRentUnBilled;

//8959698

  //Roomrent er roomrent �n CityTax
  RoomRentTotal       := RoomRentBilled+RoomRentUnbilled;
  RoomRentTotalWoVAT  := RoomRentTotal-vatRentTotal;

  vatCtaxTotal        := vatCtaxBilled+vatCtaxUnBilled;

  CtaxTotal           := CtaxBilled+CtaxUnBilled;
  CtaxTotalWoVAT      := CtaxBilled+CtaxUnBilled-vatCtaxBilled-vatCtaxUnbilled;


  VatTotal            := VatRentTotal+VatItemsTotal+VatCTaxTotal;

  TaxesTotal          := TaxesBilled+TaxesUnBilled;
  ItemsTotalWoVAT     := ItemsTotal-VatItemsTotal;


//  IncomeTotal := RoomRentTotal+RoomDiscountTotal+ItemsTotal+CTaxTotal;
  IncomeTotal := RoomRentTotal+ItemsTotal+CTaxTotal;
  IncomeTotalWoVAT := IncomeTotal-VatTotal;


  dataset.FieldByName('RoomRentUnBilled').AsFloat     := RoomRentUnBilled;
  dataset.FieldByName('RoomDiscountUnBilled').AsFloat := RoomDiscountUnBilled;
  dataset.FieldByName('TaxesUnBilled').AsFloat        := TaxesUnBilled;

  dataset.FieldByName('RoomRentTotal').AsFloat        := RoomRentTotal;
  dataset.FieldByName('RoomRentTotalWoVAT').AsFloat   := RoomRentTotalWoVAT;

  dataset.FieldByName('RoomDiscountTotal').AsFloat    := RoomDiscountTotal;
  dataset.FieldByName('TaxesTotal').AsFloat           := TaxesTotal;

  dataset.FieldByName('ItemsTotal').AsFloat         := ItemsTotal;
  dataset.FieldByName('ItemsTotalWoVAT').AsFloat    := ItemsTotalWoVAT;

  dataset.FieldByName('VatTotal').AsFloat             := VatTotal;
  dataset.FieldByName('VatUnBilled').AsFloat          := VatUnbilled;

  dataset.FieldByName('VatRentTotal').AsFloat         := VatRentTotal;
  dataset.FieldByName('VatRentUnBilled').AsFloat      := VatRentUnBilled;
  dataset.FieldByName('VatRentBilled').AsFloat        := VatRentBilled;

  dataset.FieldByName('VatCTaxTotal').AsFloat         := VatCtaxTotal;
  dataset.FieldByName('VatCTaxUnBilled').AsFloat      := VatCtaxUnBilled;

  dataset.FieldByName('VatDiscountTotal').AsFloat         := VatDiscountTotal;
  dataset.FieldByName('VatDiscountBilled').AsFloat        := VatDiscountBilled;
  dataset.FieldByName('VatDiscountUnBilled').AsFloat      := VatDiscountUnBilled;

  dataset.FieldByName('VatItemsTotal').AsFloat        := VatItemsTotal;

  dataset.FieldByName('CtaxUnBilled').AsFloat         := CtaxUnbilled;
  dataset.FieldByName('CtaxTotal').AsFloat            := CtaxTotal;
  dataset.FieldByName('CtaxTotalWoVAT').AsFloat       := CtaxTotalWoVAT;

  dataset.FieldByName('IncomeTotal').AsFloat          := IncomeTotal;
  dataset.FieldByName('IncomeTotalWoVAT').AsFloat     := IncomeTotalWoVAT;
end;


//****************************************
procedure TfrmRptResStats.btnExcelInvoiceLinesClick(Sender: TObject);
var
  sFilename : string;
  s         : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_Invoicelines';
  ExportGridToExcel(sFilename, grInvoicelines, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;


procedure TfrmRptResStats.btnExcelRoomsDateClick(Sender: TObject);
var
  sFilename : string;
  s         : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_RevenueForecast';
  ExportGridToExcel(sFilename, grRoomsDate, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmRptResStats.btnGrDrillBestFitClick(Sender: TObject);
begin
  tvDrill001.ApplyBestFit;
end;

procedure TfrmRptResStats.btnGrDrillExcelClick(Sender: TObject);
var
  sFilename : string;
  s         : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_FinanceForecastDrill';
  ExportGridToExcel(sFilename, grDrill, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmRptResStats.btnGrdrillPrintClick(Sender: TObject);
begin
  grPrinter.CurrentLink := prLinkgrDrill;
  grPrinter.CurrentLink.ReportTitle.Text := 'Finance forecast - drilldown';
  grPrinter.Preview(true,nil);
end;

procedure TfrmRptResStats.btnExcelGroupInvoiceSumsClick(Sender: TObject);
var
  sFilename : string;
  s         : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_GroupInvoiceSums';
  ExportGridToExcel(sFilename, gr {grGroupInvoiceSums}, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;


procedure TfrmRptResStats.btnReservationRoomsDateClick(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
begin
  iReservation := KbmRoomsDate_.fieldbyname('Reservation').AsInteger;
  iRoomReservation := KbmRoomsDate_.fieldbyname('RoomReservation').AsInteger;

  if EditReservation(iReservation, iRoomReservation) then
  begin
    // **
  end;
end;


procedure TfrmRptResStats.btnRoomRoomsDateClick(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
  theData : recPersonHolder;
begin
  iReservation := KbmRoomsDate_.fieldbyname('Reservation').AsInteger;
  iRoomReservation := KbmRoomsDate_.fieldbyname('RoomReservation').AsInteger;

  initPersonHolder(theData);
  theData.RoomReservation := iRoomreservation;
  theData.Reservation := iReservation;
  theData.name := '';

  if openGuestProfile(actNone,theData) then
  begin
    //**
  end;
end;


procedure TfrmRptResStats.btnReservationInvoiceLinesClick(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
begin
  iReservation := kbmInvoiceLines_.fieldbyname('Reservation').AsInteger;
  iRoomReservation := kbmInvoiceLines_.fieldbyname('RoomReservation').AsInteger;

  if EditReservation(iReservation, iRoomReservation) then
  begin
    // **
  end;
end;


procedure TfrmRptResStats.btnRoomInvoicelinesClick(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
  theData : recPersonHolder;
begin
  iReservation := kbmInvoiceLines_.fieldbyname('Reservation').AsInteger;
  iRoomReservation := kbmInvoiceLines_.fieldbyname('RoomReservation').AsInteger;

  initPersonHolder(theData);
  theData.RoomReservation := iRoomreservation;
  theData.Reservation := iReservation;
  theData.name := '';

  if openGuestProfile(actNone,theData) then
  begin
    //**
  end;
end;

procedure TfrmRptResStats.btnReservationGroupInvoiceSumsClick(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
begin
  iReservation := kbmGroupInvoiceSums_.fieldbyname('Reservation').AsInteger;
  iRoomReservation := kbmGroupInvoiceSums_.fieldbyname('RoomReservation').AsInteger;

  if EditReservation(iReservation, iRoomReservation) then
  begin
    // **
  end;
end;


procedure TfrmRptResStats.btnRoomGroupInvoiceSumsClick(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
  theData : recPersonHolder;
begin
  iReservation := kbmGroupInvoiceSums_.fieldbyname('Reservation').AsInteger;
  iRoomReservation := kbmGroupInvoiceSums_.fieldbyname('RoomReservation').AsInteger;

  initPersonHolder(theData);
  theData.RoomReservation := iRoomreservation;
  theData.Reservation := iReservation;
  theData.name := '';

  if openGuestProfile(actNone,theData) then
  begin
    //**
  end;
end;


procedure TfrmRptResStats.btnInvoiceInvoicelinesClick(Sender: TObject);
var
  InvoiceNumber : integer;
begin
  InvoiceNumber := kbmInvoiceLines_.fieldbyname('InvoiceNumber').AsInteger;
  ViewInvoice2(InvoiceNumber, false, false, false,false, '');
end;

procedure TfrmRptResStats.cxButton1Click(Sender: TObject);
var
  s : string;
  Description : string;
begin
  if cbxSel.Items.Count = 0 then exit;
  Description := cbxSel.Items[cbxSel.ItemIndex];

  //**Translate
  if MessageDlg('Delete '+description, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    s := '';
    s := s + ' DELETE '+#10;
    s := s + '   FROM '+#10;
    s := s + '     propertiesstore '+#10;
    s := s + ' WHERE '+#10;
    s := s + '   description = '+ _db(description);
    if cmd_bySQL(s) then
    begin
      GetSel;
    end;
  end;
end;

procedure TfrmRptResStats.deleteLayout(description : string);
var
  s : string;
begin
  if cbxSel.Items.Count = 0 then exit;
  Description := cbxSel.Items[cbxSel.ItemIndex];

  //**Translate
//  if MessageDlg('Delete '+description, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
//  begin
    s := '';
    s := s + ' DELETE '+#10;
    s := s + '   FROM '+#10;
    s := s + '     propertiesstore '+#10;
    s := s + ' WHERE '+#10;
    s := s + '   description = '+ _db(description);
    if cmd_bySQL(s) then
    begin
      GetSel;
    end;
//  end;
end;


procedure TfrmRptResStats.btnsetUseStatusAsDefaultClick(Sender: TObject);
begin
  setUseStatusDefault;
end;


procedure TfrmRptResStats.setUseStatusDefault;
var
  s : string;

  Description : string ;
  AccessLevel : integer;
  AccessOwner : string ;
  FormName    : string ;
  StoreType   : string ;
  StoreName   : string ;

  TextContainer1   : string;
  StringContainer1 : string;

  aNewName : string;

  boolChain : string;
  rSet : TRoomerDataset;

begin
  boolChain := '';
  boolChain := boolChain+_db(chkExcluteWaitingList.Checked);
  boolChain := boolChain+_db(chkExcluteDeparted.Checked);
  boolChain := boolChain+_db(chkExcluteBlocked.Checked);
  boolChain := boolChain+_db(chkExcluteAlotment.Checked);
  boolChain := boolChain+_db(chkExcluteGuest.Checked);
  boolChain := boolChain+_db(chkExcluteNoShow.Checked);
  boolChain := boolChain+_db(chkExcluteOrder.Checked);
  boolChain := boolChain+_db(chkExcluteWaitingListNoRooms.Checked);
  boolChain := boolChain+_db(chkExcluteDepartedNoRooms.Checked);
  boolChain := boolChain+_db(chkExcluteBlockedNoRooms.Checked);
  boolChain := boolChain+_db(chkExcluteAlotmentNoRooms.Checked);
  boolChain := boolChain+_db(chkExcluteGuestNoRooms.Checked);
  boolChain := boolChain+_db(chkExcluteNoShowNoRooms.Checked);
  boolChain := boolChain+_db(chkExcluteOrderNoRooms.Checked);

  boolChain := boolChain+_db(chkExcludeWaitingListNonOptional.Checked);
  boolChain := boolChain+_db(chkExcludeWaitingListNonOptional_NoRooms.Checked);

  Description := 'Use roomStatus of';
  AccessLevel :=    1;
  AccessOwner :=   '';
  FormName    := name;
  StoreType   :=   'boolChain';
  StoreName   :=   'none';

  s := '';
  s:= s+'SELECT '#10;
  s:= s+'   StringContainer1 '#10;
  s:= s+'FROM '#10;
  s:= s+' propertiesstore '#10;
  s:= s+'WHERE '#10;
  s:= s+' FormName = '+_db(name)+' AND storeType='+_db('boolChain')+' '#10;

  rSet := CreateNewDataSet;
  try
    if rSet_bySQL(rSet,s) then
    begin
      // update
      s := '';
      s := s+ 'UPDATE propertiesstore '+#10;
      s := s+ '  SET StringContainer1 = '+_db(boolChain)+' '+#10;
      s:= s+'WHERE '#10;
      s:= s+' FormName = '+_db(name)+' AND storeType='+_db('boolChain')+' '#10;

      if not cmd_bySQL(s) then
      begin
      end;

    end else
    begin
      //Insert
      s := '';
      s := s+ 'INSERT INTO propertiesstore '+#10;
      s := s+ '   (Description '+#10;
      s := s+ '   ,AccessLevel '+#10;
      s := s+ '   ,AccessOwner '+#10;
      s := s+ '   ,FormName '+#10;
      s := s+ '   ,StoreType '+#10;
      s := s+ '   ,StoreName '+#10;
      s := s+ '   ,StringContainer1 '+#10;
      s := s+ ' ) '+#10;
      s := s+ ' VALUES '+#10;
      s := s+ ' ( '+#10;
      s := s+ '   ' + _db(Description)+#10;
      s := s+ ' , ' + _db(AccessLevel)+#10;
      s := s+ ' , ' + _db(AccessOwner)+#10;
      s := s+ ' , ' + _db(FormName)+#10;
      s := s+ ' , ' + _db(StoreType)+#10;
      s := s+ ' , ' + _db(storeName)+#10;
      s := s+ ' , ' + _db(boolchain)+#10;
      s := s+ ' )';

      if not cmd_bySQL(s) then
      begin
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;


procedure TfrmRptResStats.btnGetUseStatusAsDefaultClick(Sender: TObject);
begin
  getUseStatusDefault;
end;


procedure TfrmRptResStats.GetUseStatusDefault;
var
  s : string;

  Description : string ;
  AccessLevel : integer;
  AccessOwner : string ;
  FormName    : string ;
  StoreType   : string ;
  StoreName   : string ;
  TextContainer1   : string;
  StringContainer1 : string;

  boolChain : string;
  rSet : TRoomerDataset;

  i : integer;
  tmp : string;
  aBool : boolean;

begin
  boolChain := '';

  s := '';
  s:= s+'SELECT '#10;
  s:= s+'   StringContainer1 '#10;
  s:= s+'FROM '#10;
  s:= s+' propertiesstore '#10;
  s:= s+'WHERE '#10;
  s:= s+' FormName = '+_db(name)+' AND storeType='+_db('boolChain')+' '#10;

  rSet := CreateNewDataSet;
  try
    if rSet_bySQL(rSet,s) then
    begin
      boolChain := rset.fieldbyname('StringContainer1').asstring;
    end;
  finally
    freeandnil(rSet);
  end;

  if boolchain <> '' then
  for i := 1 to length(boolchain) do
  begin
    tmp := boolchain[i];
    aBool := strtoBool(tmp);
    case i of
       1 : chkExcluteWaitingList.Checked := abool;
       2 : chkExcluteDeparted.Checked := abool;
       3 : chkExcluteBlocked.Checked := abool;
       4 : chkExcluteAlotment.Checked := abool;
       5 : chkExcluteGuest.Checked := abool;
       6 : chkExcluteNoShow.Checked := abool;
       7 : chkExcluteOrder.Checked := abool;
       8 : chkExcluteWaitingListNoRooms.Checked := abool;
       9 : chkExcluteDepartedNoRooms.Checked := abool;
      10 : chkExcluteBlockedNoRooms.Checked := abool;
      11 : chkExcluteAlotmentNoRooms.Checked := abool;
      12 : chkExcluteGuestNoRooms.Checked := abool;
      13 : chkExcluteNoShowNoRooms.Checked := abool;
      14 : chkExcluteOrderNoRooms.Checked := abool;

      15 : chkExcludeWaitingListNonOptional.Checked := abool;
      16 : chkExcludeWaitingListNonOptional_NoRooms.Checked := abool;
    end;
  end;
end;





procedure TfrmRptResStats.pg001AvrRateCalculateCustomSummary(
  Sender: TcxPivotGridField; ASummary: TcxPivotGridCrossCellSummary);
var
  ATotal, Count: Variant;
  ARow: TcxPivotGridGroupItem;
begin
  ASummary.Custom := 0;

  ARow   := ASummary.Owner.Row;
  ATotal := ARow.GetCellByCrossItem(ASummary.Owner.Column).GetSummaryByField(pg001incomeTotal, stSum);
  Count   := ARow.GetCellByCrossItem(ASummary.Owner.Column).GetSummaryByField(pg001RoomCount, stSum);
  if Count <> 0 then
  begin
    ASummary.Custom := (ATotal/Count);
  end;
end;


procedure TfrmRptResStats.pg001incomeTotalGetProperties(Sender: TcxPivotGridField; ACell: TcxPivotGridCustomCellViewInfo;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptResStats.btnPivgrRequestsBestfitClick(Sender: TObject);
begin
  pg001.ApplyBestFit;
end;

procedure TfrmRptResStats.btnPivgrRequestsExcelClick(Sender: TObject);
var
  sFilename : string;
  s : string;
begin
  datetimeTostring(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_pivDataFinance';
  cxExportPivotGridToExcel(sFileName, pg001);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmRptResStats.btnpivgrRequestsPrintClick(Sender: TObject);
begin
  grPrinter.CurrentLink := prLinkPg001;
  grPrinter.CurrentLink.ReportTitle.Text := 'Finance forecast';
  grPrinter.Preview(true,nil);
end;

procedure TfrmRptResStats.btnInvoiceGroupInvoiceSumsClick(Sender: TObject);
var
  InvoiceNumber : integer;
begin
  InvoiceNumber := kbmGroupInvoiceSums_.fieldbyname('InvoiceNumber').AsInteger;
  ViewInvoice2(InvoiceNumber, false, false, false,false, '');
end;



////////////////////////////////////////////////////////////////////////////////
//
//  Refress- Get data
////////////////////////////////////////////////////////////////////////////////

procedure TfrmRptResStats.GetData;
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

  sDebugSQL : string;

begin
  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  try
    zFirstTime := true;

    startTick := GetTickCount;
    zRRInList := GetRRinList;
    stopTick  := GetTickCount;
    SQLms     := stopTick - startTick;

    zRVInList := GetRVinList;

    sDebugSQL := 'use home100_xxx;'+chr(10)+chr(10);

    startTick := GetTickCount;
    s := '';
    s := s+'SELECT '#10;
    s := s+'  rd.roomReservation '#10;
    s := s+', rd.Reservation '#10;
    s := s+', rd.Room '#10;
    s := s+', rd.RoomType '#10;
    s := s+', rd.ResFlag '#10;
    s := s+', rd.isNoRoom '#10;
    s := s+', rd.aDate '#10;
    s := s+', rr.currency '#10;
    s := s+', rd.roomrate '#10;
    s := s+', rd.discount '#10;
    s := s+', rd.isPercentage '#10;
    s := s+', rd.paid '#10;
    s := s+', rv.Country '#10;
    s := s+', rv.Customer '#10;
    s := s+', rr.Arrival AS sArrival '#10;
    s := s+', rr.Departure  AS sDeparture '#10;
    s := s+', cust.surName AS CustomerName '#10;
    s := s+', cust.CustomerType '#10;
    s := s+', ro.Location '#10;
    s := s+', (SELECT curr.AValue from currencies curr  WHERE curr.Currency = rr.Currency) AS CurrencyRate '#10;
    s := s+', (SELECT curr.AValue from currencies curr  WHERE curr.Currency = rr.Currency)*Roomrate AS NativeRate '#10;
    s := s+', (SELECT di.result from dictionary di  WHERE di.code = rd.Resflag) AS StatusText '#10;
    s := s+', (SELECT count(id) FROM roomreservations trr WHERE trr.reservation = rv.reservation) As RoomCount '#10;
    s := s+', (SELECT count(id) FROM persons tpe WHERE tpe.reservation = rd.reservation) As RvGuestCount '#10;
    s := s+', (SELECT count(id) FROM persons tpe WHERE tpe.roomreservation = rd.roomreservation) AS RRGuestCount '#10;
    s := s+', (SELECT count(id) FROM roomsdate rd) AS RoomCount2 '#10;
    s := s+', (SELECT tpe.`Name` FROM persons tpe WHERE tpe.roomreservation = rd.roomreservation ORDER BY tpe.MainName DESC, tpe.Person LIMIT 1) As MainGuests  '#10;
    s := s+',  1 as noOfRooms '#10;
    s := s+'FROM '#10;
    s := s+'  locations loc  RIGHT OUTER JOIN '#10;
    s := s+'  countries co  RIGHT OUTER JOIN '#10;
    s := s+'  rooms ro  RIGHT OUTER JOIN '#10;
    s := s+'  roomsdate rd  INNER JOIN '#10;
    s := s+'  roomreservations rr ON rd.RoomReservation = rr.RoomReservation LEFT OUTER JOIN '#10;
    s := s+'  reservations rv ON rd.Reservation = rv.Reservation ON ro.Room = rd.Room ON '#10;
    s := s+'  co.Country = rv.Country LEFT OUTER JOIN '#10;
    s := s+'  customertypes ct RIGHT OUTER JOIN '#10;
    s := s+'  customers cust ON ct.CustomerType = cust.CustomerType ON rv.Customer = cust.Customer LEFT OUTER JOIN '#10;
    s := s+'  roomtypes rt ON rd.RoomType = rt.RoomType ON loc.Location = ro.Location '#10;
    s := s+'WHERE '#10;
    s := s+'  rd.roomreservation in '+zRRinlist+' '#10;

    statusIn := StatusSQL;

    if statusIn <> '' then
    begin
      s := s+'AND '+StatusSQL+' '#10;
    end;

    sDebugSql := sDebugSql+s+';'+chr(10)+chr(10);

//    uStringUtils.CopyToClipboard(s);
//    DebugMessage(s);


    ExecutionPlan.AddQuery(s);
//
    s := '';
    s := s+'SELECT '#10;
    s := s+'  il.Reservation '#10;
    s := s+' ,il.RoomReservation '#10;
    s := s+' ,il.SplitNumber '#10;
    s := s+' ,il.InvoiceNumber '#10;
    s := s+' ,il.ItemID '#10;
    s := s+' ,il.Number '#10;
    s := s+' ,il.Description '#10;
    s := s+' ,il.Price '#10;
    s := s+' ,il.VATType '#10;
    s := s+' ,(il.Total + il.revenueCorrection) as Total '#10;
    s := s+' ,(il.Total + il.revenueCorrection) - (il.Vat + il.revenueCorrectionVAT) as TotalWOVat '#10;
    s := s+' ,(il.Vat + il.revenueCorrectionVAT) as Vat '#10;
    s := s+' ,it.description AS ItemDescription '#10;
    s := s+' ,it.ItemType '#10;
    s := s+' ,ity.Description AS ItemTypeDescription '#10;
    s := s+' ,ity.VatCode '#10;
    s := s+' ,vatc.Description AS VATDescription '#10;
    s := s+' ,vatc.VATPercentage '#10;
    s := s+' ,(SELECT count(id) FROM persons tpe WHERE tpe.roomreservation = il.roomreservation) AS RRGuestCount '#10;
    s := s+'FROM '#10;
    s := s+'  invoicelines il INNER JOIN '#10;
    s := s+'  items it ON il.ItemID = it.Item INNER JOIN '#10;
    s := s+'  itemtypes ity ON it.Itemtype = ity.Itemtype INNER JOIN '#10;
    s := s+'  vatcodes vatc ON ity.VATCode = vatc.VATCode '#10;
    s := s+'WHERE '#10;
    s := s+'  il.roomreservation in '+zRRinlist+' '#10;

    sDebugSql := sDebugSql+s+';'+chr(10)+chr(10);
    ExecutionPlan.AddQuery(s);

    s := '';
    s := s+'SELECT '#10;
    s := s+'  il.Reservation '#10;
    s := s+' ,il.ItemID '#10;
    s := s+' ,il.invoicenumber '#10;
    s := s+' ,count(il.InvoiceNumber) AS noInvoices '#10;
    s := s+' ,SUM(il.`number`) AS noItems '#10;
    s := s+' ,AVG(il.Price) AS avragePrice '#10;
    s := s+' ,SUM(il.Total + il.revenueCorrection) AS Total '#10;
    s := s+' ,SUM(il.Total + il.revenueCorrection -  (il.Vat + il.revenueCorrectionVAT)) AS TotalWOVat '#10;
    s := s+' ,SUM(il.Vat + il.revenueCorrectionVAT) as TotalVAT '#10;
    s := s+' ,(SELECT count(id) FROM roomreservations rr WHERE rr.reservation = il.reservation) As RoomCount '#10;
    s := s+'FROM '#10;
    s := s+'  invoicelines il '#10;
    s := s+'WHERE '#10;
    s := s+'  (il.reservation in '+zRVinlist+') AND (RoomReservation = 0) '#10;
    s := s+'GROUP BY '#10;
    s := s+'   il.reservation '#10;
    s := s+'  ,il.itemID '#10;

    sDebugSql := sDebugSql+s+';'+chr(10)+chr(10);
    ExecutionPlan.AddQuery(s);


    copytoclipboard(sDebugSql);
//    debugMessage(sDebugSQL);



    //////////////////// Execute!

    screen.Cursor := crHourGlass;
    kbmRoomsDate_.DisableControls;
    kbmInvoicelines_.DisableControls;
    kbmGroupInvoiceSums_.DisableControls;
    try
      try
        ExecutionPlan.Execute(ptQuery);
      Except
        on e: exception do
        begin
         showMessage('Getting Data : '+e.message);
         exit;
        end;
      end;

      //////////////////// RoomsDate

      rSet1 := ExecutionPlan.Results[0];

      if kbmRoomsdate_.Active then kbmRoomsDate_.Close;
      kbmRoomsdate_.open;
      LoadKbmMemtableFromDataSetQuiet(kbmRoomsdate_,rSet1,[]);
      kbmRoomsdate_.First;

      //////////////////// InvoiceLines
      rSet2 := ExecutionPlan.Results[1];

      if kbmInvoicelines_.Active then kbmInvoicelines_.Close;
      kbmInvoicelines_.open;
      LoadKbmMemtableFromDataSetQuiet(kbmInvoicelines_,rSet2,[]);
      kbmInvoicelines_.First;
      kbmRoomsdate_.SortFields := 'roomreservation';
      kbmRoomsdate_.Sort([]);


      //////////////////// GroupInvoiceSums
      rSet3 := ExecutionPlan.Results[2];

      if kbmGroupInvoiceSums_.Active then kbmGroupInvoiceSums_.Close;
      kbmGroupInvoiceSums_.open;
      LoadKbmMemtableFromDataSetQuiet(kbmGroupInvoiceSums_,rSet3,[]);
      kbmGroupInvoiceSums_.First;
      kbmGroupInvoiceSums_.SortFields := 'Reservation';
      kbmGroupInvoiceSums_.Sort([]);

      AddInvoicelineData;
      AddGroupInvoiceSumsData;

// kbmRoomsdate_.SortFields := 'Reservation;room';
// kbmRoomsdate_.Sort([]);

      zFirstTime := false;

      kbmRoomsdate_.SortFields := 'dtDate';
      kbmRoomsdate_.Sort([]);

      kbmRoomsDate_.first;

      while (not kbmRoomsDate_.eof) AND (kbmRoomsDate_.fieldbyname('dtDate').AsDateTime < zDateFrom)  do
      begin
        kbmRoomsDate_.first;
        kbmRoomsDate_.delete;
      end;

      kbmRoomsDate_.last;
      while (not kbmRoomsDate_.bof) AND (kbmRoomsDate_.fieldbyname('dtDate').AsDateTime > zDateTo)  do
      begin
        kbmRoomsDate_.last;
        kbmRoomsDate_.delete;
      end;

    finally
      screen.cursor := crDefault;
      kbmGroupInvoiceSums_.EnableControls;
      kbmRoomsDate_.EnableControls;
      kbmInvoicelines_.EnableControls;
    end;

    stopTick         := GetTickCount;
    SQLms            := stopTick - startTick;

  finally
    ExecutionPlan.Free;
  end;
  pg001.ApplyBestFit;

end;

procedure TfrmRptResStats.btnRefreshClick(Sender: TObject);
begin
  getData
  //**
end;


////////////////////////////////////////////////////////////////////////////////
///
/// LAYOUT
///
///  ///////////////////////////////////////////////////////////////////////////


procedure TfrmRptResStats.btnSaveLayoutClick(Sender: TObject);
var
  s : string;

  Description : string;
  AccessLevel : integer;
  AccessOwner : string;
  FormName    : string;
  StoreType   : string;
  StoreName   : string;

  TextContainer1   : string;
  StringContainer1 : string;

  aNewName : string;
//  notes : string;
begin
  Store1.StorageStream := TMemoryStream.Create;
  Store1.StoreTo(false);
  Store1.StorageStream.Position := 0;
//  memo1.text := Bin2Hex(Store1.StorageStream AS TMemoryStream);
  TextContainer1    := Bin2Hex(Store1.StorageStream AS TMemoryStream);
  StringContainer1  := '';

  Description := GetAutoName;
//  EdlayoutName.text := Description;
  Description := copy(Description,1,254);

  if StoreDescriptionExist(Description) then
  begin
    Showmessage('This Already Exists : '+Description );
    exit;
  end;

  AccessLevel := 1;
  AccessOwner := '';
  FormName    := name;
  StoreType   := 'TcxPivotGridDataLayout';
  StoreName   := 'store1';
//  Notes := memLayoutNotes.Text;

  s := s+ 'INSERT INTO propertiesstore '+#10;
  s := s+ '   (Description '+#10;
  s := s+ '   ,AccessLevel '+#10;
  s := s+ '   ,AccessOwner '+#10;
  s := s+ '   ,FormName '+#10;
  s := s+ '   ,StoreType '+#10;
  s := s+ '   ,StoreName '+#10;
  s := s+ '   ,TextContainer1 '+#10;
//  s := s+ '   ,TextContainer2 '+#10;
  s := s+ '   ,StringContainer1 '+#10;
  s := s+ ' ) '+#10;
  s := s+ ' VALUES '+#10;
  s := s+ ' ( '+#10;
  s := s+ '   ' + _db(Description)+#10;
  s := s+ ' , ' + _db(AccessLevel)+#10;
  s := s+ ' , ' + _db(AccessOwner)+#10;
  s := s+ ' , ' + _db(FormName)+#10;
  s := s+ ' , ' + _db(StoreType)+#10;
  s := s+ ' , ' + _db(storeName)+#10;
  s := s+ ' , ' + _db(TextContainer1)+#10;
//  s := s+ ' , ' + _db(notes)+#10;
  s := s+ ' , ' + _db(StringContainer1)+#10;
  s := s+ ' )';

  if not cmd_bySQL(s) then
  begin
    showmessage('Could not insert!')
  end else
  begin
    GetSel;
  end;
end;




procedure TfrmRptResStats.btnSetDefaultLayoutClick(Sender: TObject);
var
  TextContainer1   : string;
  Description      : string;
  s                : string;

  formName  : string;
  StoreType : string;
  StoreName : string;

begin
  if cbxSel.Items.Count = 0 then exit;
  Description := cbxSel.Items[cbxSel.ItemIndex];

  FormName    := name;
  StoreType   := 'TcxPivotGridDataLayout';
  StoreName   := 'store1';

  s := '';
  s := s + ' UPDATE propertiesstore '+#10;
  s := s + '   SET '+#10;
  s := s+ '    `isDefault` = 0 '+#10;  // First set all to default
  s := s +' WHERE '+#10;  // First set all to default
  s := s +' (Formname = '+_db(FormName)+') AND '+#10;  // First set all to default
  s := s +' (StoreType = '+_db(StoreType)+') AND '+#10;  // First set all to default
  s := s +' (StoreName = '+_db(StoreName)+') '+#10;  // First set all to default


  if cmd_bySQL(s) then
  begin
  end;


  s := '';
  s := s +' UPDATE propertiesstore '+#10;
  s := s +'   SET '+#10;
  s := s +'    `isDefault` = 1 '+#10;  // First set all to default
  s := s +' WHERE '+#10;  // First set all to default
  s := s +' (Formname = '+_db(FormName)+') AND '+#10;  // First set all to default
  s := s +' (StoreType = '+_db(StoreType)+') AND '+#10;  // First set all to default
  s := s +' (StoreName = '+_db(StoreName)+') AND '+#10;  // First set all to default
  s := s +' (Description = '+_db(Description)+') '+#10;  // First set all to default

  if cmd_bySQL(s) then
  begin
  end;

end;

procedure TfrmRptResStats.LoadLayoutOld(useDefault : boolean);
var
  s : string;
  Description : string;
  AccessLevel : integer;
  AccessOwner : string;
  FormName    : string;
  StoreType   : string;
  StoreName   : string;
  TextContainer1   : string;
  StringContainer1 : string;
  rSet : TRoomerDataset;

  itemindex : integer;

  layoutName : string;

begin
  dril001.SynchronizeData := false;

  if useDefault then
  begin
    s := '';
    s:= s+'SELECT '#10;
    s:= s+'   Description '#10;
    s:= s+' , FormName '#10;
    s:= s+' , StoreType '#10;
    s:= s+' , StoreName '#10;
    s:= s+' , TextContainer1 '#10;
    s:= s+' , TextContainer2 '#10;
    s:= s+' , StringContainer1 '#10;
    s:= s+'FROM '#10;
    s:= s+' propertiesstore '#10;
    s:= s+'WHERE '#10;
    s:= s+' isDefault = 1 '#10;
  end else
  begin
    if cbxSel.Items.Count = 0 then exit;
    Description := cbxSel.Items[cbxSel.ItemIndex];
    s := '';
    s:= s+'SELECT '#10;
    s:= s+'   Description '#10;
    s:= s+' , FormName '#10;
    s:= s+' , StoreType '#10;
    s:= s+' , StoreName '#10;
    s:= s+' , TextContainer1 '#10;
    s:= s+' , TextContainer2 '#10;
    s:= s+' , StringContainer1 '#10;
    s:= s+'FROM '#10;
    s:= s+' propertiesstore '#10;
    s:= s+'WHERE '#10;
    s:= s+' Description = '+_db(Description)+' '#10;
  end;

  rSet := CreateNewDataSet;
  try
    if rSet_bySQL(rSet,s) then
    begin
      LayoutName := rSet.FieldByName('Description').asstring;
//    memLayoutNotes.Text := rSet.FieldByName('TextContainer2').Text;

      itemindex := cbxSel.Items.IndexOf(LayoutName);
      cbxSel.ItemIndex := itemindex;
      if itemindex >= 0 then
        sSpeedButton1.Hint := propertiesstoreGetText(LayoutName);

      storeOld.StorageStream := TMemoryStream.Create;
      try
        StoreOld.StorageStream.Position := 0;
        TextContainer1 := rSet.FieldByName('TextContainer1').asstring;
        Hex2Bin(TextContainer1, StoreOld.StorageStream AS TMemoryStream);
        StoreOld.RestoreFrom;
      finally
      end;
    end;
  finally
    freeandnil(rSet);
  end;
  dril001.SynchronizeData := true;
end;

procedure TfrmRptResStats.LoadLayout(useDefault : boolean);
var
  s : string;
  Description : string;
  AccessLevel : integer;
  AccessOwner : string;
  FormName    : string;
  StoreType   : string;
  StoreName   : string;
  TextContainer1   : string;
  StringContainer1 : string;
  rSet : TRoomerDataset;

  itemindex : integer;

  layoutName : string;

  isOld : boolean;

begin
  dril001.SynchronizeData := false;
  isOld := false;

  if useDefault then
  begin
    s := '';
    s:= s+'SELECT '#10;
    s:= s+'   Description '#10;
    s:= s+' , FormName '#10;
    s:= s+' , StoreType '#10;
    s:= s+' , StoreName '#10;
    s:= s+' , TextContainer1 '#10;
    s:= s+' , TextContainer2 '#10;
    s:= s+' , StringContainer1 '#10;
    s:= s+' , length(Textcontainer1) AS iLength '#10;
    s:= s+'FROM '#10;
    s:= s+' propertiesstore '#10;
    s:= s+'WHERE '#10;
    s:= s+' isDefault = 1 '#10;
  end else
  begin
    if cbxSel.Items.Count = 0 then exit;
    Description := cbxSel.Items[cbxSel.ItemIndex];
    s := '';
    s:= s+'SELECT '#10;
    s:= s+'   Description '#10;
    s:= s+' , FormName '#10;
    s:= s+' , StoreType '#10;
    s:= s+' , StoreName '#10;
    s:= s+' , TextContainer1 '#10;
    s:= s+' , TextContainer2 '#10;
    s:= s+' , StringContainer1 '#10;
    s:= s+' , length(Textcontainer1)  AS iLength '#10;
    s:= s+'FROM '#10;
    s:= s+' propertiesstore '#10;
    s:= s+'WHERE '#10;
    s:= s+' Description = '+_db(Description)+' '#10;
  end;

  rSet := CreateNewDataSet;
  try
    if rSet_bySQL(rSet,s) then
    begin
      isOld := (rSet.FieldByName('iLength').asInteger < 14500) and (rSet.FieldByName('iLength').asInteger > 500);

      if isOld then
      begin
        if MessageDlg(GetTranslatedText('shTx_FinanceForecast_DoYouWantToConvertLayoutToNewVersion'), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          try
            LoadLayoutOld(false);
            SaveLayout2new;
          Except
            on e: exception do
            begin
             MessageDlg(GetTranslatedText('shTx_FinanceForecast_ErrorConvertingReport'), mtError, [mbOk], 0);
             exit;
            end;
          end;
        end;
        exit;
      end;

      LayoutName := rSet.FieldByName('Description').asstring;
//    memLayoutNotes.Text := rSet.FieldByName('TextContainer2').Text;

      itemindex := cbxSel.Items.IndexOf(LayoutName);
      cbxSel.ItemIndex := itemindex;
      if itemindex >= 0 then
        sSpeedButton1.Hint := propertiesstoreGetText(LayoutName);

      store1.StorageStream := TMemoryStream.Create;
      try
        Store1.StorageStream.Position := 0;
        TextContainer1 := rSet.FieldByName('TextContainer1').asstring;
        Hex2Bin(TextContainer1, Store1.StorageStream AS TMemoryStream);
        Store1.RestoreFrom;
      finally
      end;
    end;
  finally
    freeandnil(rSet);
  end;
  dril001.SynchronizeData := true;
end;


procedure TfrmRptResStats.GetSel;
var
  s : string;
  Description : string;
  AccessLevel : integer;
  AccessOwner : string;
  FormName    : string;
  StoreType   : string;
  StoreName   : string;
  TextContainer1   : string;
  StringContainer1 : string;
  rSet : TRoomerDataset;
begin
  s := '';
  s:= s+'SELECT '#10;
  s:= s+'   Description '#10;
  s:= s+' , FormName '#10;
  s:= s+' , StoreType '#10;
  s:= s+' , StoreName '#10;
  s:= s+'FROM '#10;
  s:= s+' propertiesstore '#10;
  s:= s+'WHERE '#10;
  s:= s+' FormName = '+_db(name)+' AND storeName='+_db('store1')+' '#10;
  s:= s+'Order by Description '#10;


  rSet := CreateNewDataSet;
  try
    cbxSel.Items.Clear;

    if rSet_bySQL(rSet,s) then
    begin
      while not rSet.Eof do
      begin
        cbxSel.Items.Add(rset.fieldbyname('description').asstring);
        rSet.Next;
      end;
      cbxSel.ItemIndex := 0;
    end;
  finally
    freeandnil(rSet);
  end;
end;

function TfrmRptResStats.updateLayoutName(oldName, newname : string) : boolean;
var
  s : string;
  itemindex : integer;
begin
  result := false;
  s := '';
  s := s + ' UPDATE propertiesstore '+#10;
  s := s + '   SET '+#10;
  s := s+ '    Description =' + _db(newName)+#10;
  s := s + ' WHERE '+#10;
  s := s + '   description = ' + _db(oldName);

  if cmd_bySQL(s) then
  begin
    cbxSel.Items[cbxSel.ItemIndex] := newName;
    itemindex := cbxSel.Items.IndexOf(NewName);
    cbxSel.ItemIndex := itemindex;
    result := true;
  end;
end;



function TfrmRptResStats.SaveLayout2new : boolean;
var
  s : string;

  Description : string;
  AccessLevel : integer;
  AccessOwner : string;
  FormName    : string;
  StoreType   : string;
  StoreName   : string;

  TextContainer1   : string;
  StringContainer1 : string;

  aNewName : string;
  oldDescription : string;
  sText : string;
//  notes : string;
begin
  result := false;
  Store1.StorageStream := TMemoryStream.Create;
  Store1.StoreTo(false);
  Store1.StorageStream.Position := 0;
//  memo1.text := Bin2Hex(Store1.StorageStream AS TMemoryStream);
  TextContainer1    := Bin2Hex(Store1.StorageStream AS TMemoryStream);
  StringContainer1  := '';

  Description := cbxSel.Items[cbxSel.ItemIndex];
  sText := propertiesstoreGetText(Description);
  oldDescription := Description;


  Description := '** '+Description;
//  EdlayoutName.text := Description;
  Description := copy(Description,1,254);

  if StoreDescriptionExist(Description) then
  begin
    Showmessage('This Already Exists : '+Description );
    exit;
  end;

  AccessLevel := 1;
  AccessOwner := '';
  FormName    := name;
  StoreType   := 'TcxPivotGridDataLayout';
  StoreName   := 'store1';
//  Notes := memLayoutNotes.Text;

  s := s+ 'INSERT INTO propertiesstore '+#10;
  s := s+ '   (Description '+#10;
  s := s+ '   ,AccessLevel '+#10;
  s := s+ '   ,AccessOwner '+#10;
  s := s+ '   ,FormName '+#10;
  s := s+ '   ,StoreType '+#10;
  s := s+ '   ,StoreName '+#10;
  s := s+ '   ,TextContainer1 '+#10;
//  s := s+ '   ,TextContainer2 '+#10;
  s := s+ '   ,StringContainer1 '+#10;
  s := s+ ' ) '+#10;
  s := s+ ' VALUES '+#10;
  s := s+ ' ( '+#10;
  s := s+ '   ' + _db(Description)+#10;
  s := s+ ' , ' + _db(AccessLevel)+#10;
  s := s+ ' , ' + _db(AccessOwner)+#10;
  s := s+ ' , ' + _db(FormName)+#10;
  s := s+ ' , ' + _db(StoreType)+#10;
  s := s+ ' , ' + _db(storeName)+#10;
  s := s+ ' , ' + _db(TextContainer1)+#10;
//  s := s+ ' , ' + _db(notes)+#10;
  s := s+ ' , ' + _db(StringContainer1)+#10;
  s := s+ ' )';

  if not cmd_bySQL(s) then
  begin
    showmessage('Could not insert!')
  end else
  begin
    // GetSel;
    result := true;
    deleteLayout(oldDescription);
    updateLayoutName(description, oldDescription);
  end;
end;

end.


