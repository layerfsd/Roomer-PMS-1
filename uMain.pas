unit uMain;

(*
  sDefs.inc   acLFPainter
*)

interface

{$IFDEF DEBUG}
{$DEFINE ROOMERSTORE}
{$ENDIF}

uses
  Windows, Messages, IOUtils, System.Generics.Collections, IdComponent, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, Grids, ComCtrls, Db,
  ADODB, ActiveX, StdCtrls, Menus, Mask, ComObj, ShellApi, Inifiles, ImgList, Buttons, Vcl.AppEvnts,
  uReservationHintHolder, uEmbOccupancyView, uEmbPeriodView, uGuestProfiles, uStaffCommunication
  , uAllotmentToRes
  , uRoomerContainerClasses

  // Roomer
    , PrjConst, uReservationObjects, uRoomDatesOBJ, objRoomList2, objDayFreeRooms, objRoomTypeRoomCount, _Glob, hData, ug, uDImages, uAppGlobal, uHomedate,
  uPackages, cmpRoomerConnection, objNewReservation, uChannelAvailabilityManager, cmpRoomerDataSet, RoomerLoginForm, uUtils, uFileSystemUtils,
  uTransparentPanel, uAlerts
  , uFrmMessagesTemplates
  // Other
    , NativeXML, kbmMemTable

  // TMS
    , AdvGrid, AdvEdit, AdvEdBtn, PlannerDatePicker, AdvObj, asgprint, BaseGrid

  // ReportBuilder
    , ppDB, ppDBPipe, ppParameter, ppDesignLayer, ppCtrls, ppBands, ppStrtch, ppMemo, ppClass, ppPrnabl, ppCache, ppComm, ppRelatv, ppProd, ppReport

    , TeEngine, Series, TeeProcs, Chart, htmlhint, HTMLabel, uRoomerLanguage

  // Alpha skins
    , acPNG, acAlphaImageList, acProgressBar, acTitleBar

  // Alpha cotroles
    , sSkinProvider, sSkinManager, sPanel, sLabel, sGroupBox, sTabControl, sButton, sEdit, sSpeedButton, sPageControl, sCheckBox, sListBox, sSplitter, sDialogs,
  sMemo, sMaskEdit, sCustomComboEdit, sTooledit, sComboBox

    , dxSkinsLookAndFeelPainter

    , dxRibbonSkins, dxBar, dxBarExtItems, dxRibbon, dxPScxGridLnk, dxBarApplicationMenu, dxGDIPlusClasses, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd,
  dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns, dxPSPDFExportCore

    , dxCore, cxClasses, cxGridExportLink, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxDropDownEdit,
  cxPropertiesStore, cxBarEditItem, cxSplitter, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGrid, cxButtons,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData

    , dxPSPDFExport, dxPSPrVwStd, dxPSPrVwAdv, dxPSPrVwRibbon, dxPScxPageControlProducer, dxPScxEditorProducers, dxPScxExtEditorProducers, dxPSCore

  // DevExpress skins
    , dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  dxSkinsdxRibbonPainter, dxSkinsdxBarPainter, dxSkinsForm, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinDarkRoom, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, sScrollBox, acImage, AdvUtil

    ;

type
  TViewMode = (vmNone, vmOneDay, vmGuestList, vmPeriod, vmMeetings, vmDashboard, vmRateQuery);

  TRoomAvailabilityEntity = class
  private
    FRoom: String;
    FRoomType: STring;
    FRoomClass: String;
  public
    constructor Create(Room, RoomType, RoomClass: String);
    destructor Destroy; override;

    property Room: String read FRoom;
    property RoomType: String read FRoomType;
    property RoomClass: String read FRoomClass;
  end;

  TRoomAvailabilityEntityList = TObjectList<TRoomAvailabilityEntity>;

  TRoomClassChannelAvailabilityContainer = class
    RoomTypeGroup: String;
    NumRooms: integer;
    Reserved: integer;
    ChannelAvailable: integer;
    ChannelMaxAvailable: integer;
    GridIndex: integer;
    AnyStop: boolean;

    constructor Create(_RoomTypeGroup: String; _NumRooms: integer; _Reserved: integer; _ChannelAvailable: integer; _ChannelMaxAvailable: integer;
      _GridIndex: integer; _AnyStop: boolean);
  end;

  TRoomClassChannelAvailabilityContainerDictionary = TObjectList<TRoomClassChannelAvailabilityContainer>;

type
  recColRow = record
    col: integer;
    row: integer;
  end;

type
  TOneDayResPointers = record
    ptrRooms: array [1 .. 2, 1 .. 3] of integer;
  end;

  TOneDayResPointersArray = array [0 .. 2000] of TOneDayResPointers;

var
  zOneDayResPointers: TOneDayResPointersArray;
  zOneDay_bSelectedNonRooms: array [1 .. 500, 1 .. 2] of integer;

type

  TfrmMain = class(TForm)
    mmnuOneDayGrid: TPopupMenu;
    pmnuRoomInvoive: TMenuItem;
    pmnuCheckInRoom: TMenuItem;
    pmnuCheckOutRoom: TMenuItem;
    MenuItem8: TMenuItem;
    mnuRoomNumber: TMenuItem;
    mnuDeleteRoomFromReservation: TMenuItem;
    MenuItem13: TMenuItem;
    pmnuRoomReservation: TMenuItem;
    mnuCancelReservation2: TMenuItem;
    N18: TMenuItem;
    mmnuFinishedInvoices: TMenuItem;
    pmnuClosedInvoicesThisRoom: TMenuItem;
    pmnuClosedInvoicesThisreservation: TMenuItem;
    pmnuClosedInvoicesThisCustomer: TMenuItem;
    N27: TMenuItem;
    mnuRoomListForReservation: TMenuItem;
    pmnuModifyReservation: TMenuItem;
    barinn: TdxBarManager;
    mmnuFile: TdxBarSubItem;
    mmnuReservations: TdxBarSubItem;
    mmnuRoom: TdxBarSubItem;
    mmnuView: TdxBarSubItem;
    mmnuSystem: TdxBarSubItem;
    mmnuData: TdxBarSubItem;
    mmnuHelp: TdxBarSubItem;
    btnCheckInRoom: TdxBarLargeButton;
    btnCheckOutRoom: TdxBarLargeButton;
    btnCheckInGroup: TdxBarLargeButton;
    btnLogOut: TdxBarLargeButton;
    btnClose: TdxBarLargeButton;
    btnRoomInvoice: TdxBarLargeButton;
    mnuFinishedInvoices: TdxBarPopupMenu;
    btnGroupInvoice: TdxBarLargeButton;

    btnFinishedInvoices: TdxBarLargeButton;
    btnInvoiceSettings: TdxBarLargeButton;
    btnModifyReservation: TdxBarLargeButton;
    btnRoomGuests: TdxBarLargeButton;
    btnCancelReservationBtn: TdxBarLargeButton;
    mnuCancelRes: TdxBarPopupMenu;
    btnCashInvoice: TdxBarLargeButton;
    btnCreditInvoice: TdxBarLargeButton;
    btnProvideARoom: TdxBarLargeButton;
    btnSerachGuests: TdxBarLargeButton;
    btnChangeDate: TdxBarLargeButton;
    btnOpenInvoices: TdxBarLargeButton;
    btnRefresh: TdxBarLargeButton;
    pmnuCheckInGroup: TMenuItem;
    pmnuReservationRoomList: TdxBarLargeButton;
    btnNextDay: TdxBarButton;
    btnToDay: TdxBarButton;
    btnPreviusDay: TdxBarButton;
    btnBars: TdxBarToolbarsListItem;
    dxBarDockControl1: TdxBarDockControl;
    timKillDrag: TTimer;
    timBlink: TTimer;
    btnDayFinal: TdxBarLargeButton;
    btnRptCustInvoices: TdxBarLargeButton;
    btnRptFinanceForecast: TdxBarLargeButton;
    btnRptNationalReport: TdxBarLargeButton;
    btnCurrentGuests: TdxBarLargeButton;
    btnMaids: TdxBarLargeButton;
    btnSetNoroom: TdxBarLargeButton;
    pmnuRemoveRooms: TdxBarPopupMenu;
    mnuInvoicees: TdxBarSubItem;
    pmnuGroupInvoice: TMenuItem;
    pmnuChasInvoice: TMenuItem;
    pmnuRoomGuests: TMenuItem;
    mmnuReports: TdxBarSubItem;
    cbxNameOrder: TdxBarCombo;
    btnCustomerList: TdxBarLargeButton;
    btnCustomerTypeList: TdxBarLargeButton;
    btnCountriesList: TdxBarLargeButton;
    btnCountryGroupsList: TdxBarLargeButton;
    btnCurrenciesList: TdxBarLargeButton;
    btnRooms: TdxBarLargeButton;
    btnSelectionRules: TdxBarLargeButton;
    btnRoomTypes: TdxBarLargeButton;
    btnLocations: TdxBarLargeButton;
    btnVatCodesList: TdxBarLargeButton;
    btnPaymentGroupList: TdxBarLargeButton;
    btnPaymentTypesList: TdxBarLargeButton;
    btnItemsList: TdxBarLargeButton;
    btnItemTypeList: TdxBarLargeButton;
    btnStaffAuthorizationList: TdxBarLargeButton;
    btnEmployeeList: TdxBarLargeButton;
    btnEmployeeTypesList: TdxBarLargeButton;
    btnRoomPrice: TdxBarLargeButton;
    btnRoomPriceTypes: TdxBarLargeButton;
    btnSeasons: TdxBarLargeButton;
    btnAbout: TdxBarLargeButton;
    btnHelpContent: TdxBarLargeButton;
    btnRemoteSupport: TdxBarLargeButton;
    btnSupportRequest: TdxBarLargeButton;
    btnDayNotes: TdxBarLargeButton;
    btnNewReservation: TdxBarLargeButton;
    btnDayView: TdxBarLargeButton;
    btnPeriodView: TdxBarLargeButton;
    btnMeetingsView: TdxBarLargeButton;
    btnSettings: TdxBarLargeButton;
    BtnDataDaseMaintence: TdxBarLargeButton;
    btnVaribles: TdxBarLargeButton;
    btnVariblesGroups: TdxBarLargeButton;
    BtnMaidJobScripts: TdxBarLargeButton;
    btnClosedInvoicesThisreservation: TdxBarLargeButton;
    btnClosedInvoicesThisRoom: TdxBarLargeButton;
    btnClosedInvoicesThisCustomer: TdxBarLargeButton;
    btnClosedInvoicesAllDetailedList: TdxBarLargeButton;
    btnClosedInvoicesAllSimpleList: TdxBarLargeButton;
    btnDeleteReservation: TdxBarLargeButton;
    btnRemoveThisRoom: TdxBarLargeButton;
    btnCancelThisReservation: TdxBarLargeButton;
    btnSetNoRoomThis: TdxBarLargeButton;
    btnSetNoRoomAll: TdxBarLargeButton;
    panMain: TsPanel;
    pageMainGrids: TsPageControl;
    tabOneDayView: TsTabSheet;
    tabGuestList: TsTabSheet;
    tabPeriod: TsTabSheet;
    panMainTop: TsPanel;
    Panel4: TsPanel;
    labRefreshTime: TsLabel;
    __PanGridsHeader: TsPanel;
    panPeriodRooms: TsPanel;
    grPeriodRooms: TAdvStringGrid;
    splitPeriod: TcxSplitter;
    cbxNameOrderPeriod: TdxBarCombo;
    rbTabHome: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    rbTabInvoice: TdxRibbonTab;
    rbTabData: TdxRibbonTab;
    rbTabReservation: TdxRibbonTab;
    System: TdxRibbonTab;
    rbTabHelp: TdxRibbonTab;
    barinnFile: TdxBar;
    barinnReservation: TdxBar;
    btnRoomReservation: TdxBarLargeButton;
    barinnInvoice: TdxBar;
    barinnClosedInvoices: TdxBar;
    barinnInvoiceLists: TdxBar;
    barinnView: TdxBar;
    barinnNameOrder: TdxBar;
    btnLPreviusDay: TdxBarLargeButton;
    btnLToday: TdxBarLargeButton;
    btnLNextDay: TdxBarLargeButton;
    barinnRoomActions: TdxBar;
    barinnFindGuests: TdxBar;
    btnJumpToRoomAndDate: TdxBarLargeButton;
    barinnCheckInOut: TdxBar;
    barinnRoomActions2: TdxBar;
    barinnCustomers: TdxBar;
    barinnBar6: TdxBar;
    barinnRooms: TdxBar;
    barinnBar7: TdxBar;
    barinnBar8: TdxBar;
    barinnSettings: TdxBar;
    barinnVaribles: TdxBar;
    barinnUsers: TdxBar;
    dxRibbon1Tab1: TdxRibbonTab;
    barinnReports: TdxBar;
    barinnReports2: TdxBar;
    barinnBar15: TdxBar;
    barinnBar16: TdxBar;
    barinnReportsInvoices: TdxBar;
    barinnBar2: TdxBar;
    dxRibbon1Tab2: TdxRibbonTab;
    cxImageList1: TcxImageList;
    btnRoomTypeGroups: TdxBarLargeButton;
    btnResStat: TdxBarLargeButton;
    btnQuicReservation: TdxBarLargeButton;
    Panel2: TsPanel;
    wwDBDateTimePicker1: TPlannerDatePicker;
    oldDock1: TdxBarDockControl;
    btnShowHideHint: TdxBarLargeButton;
    btnReservationNotes: TdxBarLargeButton;
    btnRptCustInvoices2: TdxBarLargeButton;
    btnPhoneLog: TdxBarLargeButton;
    btnPhoneDevices: TdxBarLargeButton;
    btnPhonePrices: TdxBarLargeButton;
    btnPhonePriceRules: TdxBarLargeButton;
    btnLodgingTaxReport: TdxBarLargeButton;
    N1: TMenuItem;
    NewReservation1: TMenuItem;
    QuickReservation1: TMenuItem;
    barinnGuests: TdxBar;
    btnGroupsReport: TdxBarLargeButton;
    btnCurrentGuestsReport: TdxBarLargeButton;
    Panel3: TsPanel;
    rgrGroupreportStayType: TsRadioGroup;
    mAllReservations: TkbmMemTable;
    allReservationsDS: TDataSource;
    gAllReservations: TcxGrid;
    tvAllReservations: TcxGridDBTableView;
    tvAllReservationsArrivalDate: TcxGridDBColumn;
    tvAllReservationsDepartureDate: TcxGridDBColumn;
    tvAllReservationsRRGuestCount: TcxGridDBColumn;
    tvAllReservationsmainGuests: TcxGridDBColumn;
    tvAllReservationsRoom: TcxGridDBColumn;
    tvAllReservationsRoomType: TcxGridDBColumn;
    tvAllReservationsRoomDescription: TcxGridDBColumn;
    tvAllReservationsFloor: TcxGridDBColumn;
    tvAllReservationsLocationDescription: TcxGridDBColumn;
    tvAllReservationsStatustext: TcxGridDBColumn;
    tvAllReservationsmarketSegmentDescription: TcxGridDBColumn;
    tvAllReservationsGroupAccount: TcxGridDBColumn;
    tvAllReservationsCustomer: TcxGridDBColumn;
    tvAllReservationsPersonalID: TcxGridDBColumn;
    tvAllReservationsEmail: TcxGridDBColumn;
    tvAllReservationsWebsite: TcxGridDBColumn;
    tvAllReservationsRvGuestCount: TcxGridDBColumn;
    tvAllReservationsBreakfast: TcxGridDBColumn;
    tvAllReservationsNoRoom: TcxGridDBColumn;
    tvAllReservationsBookable: TcxGridDBColumn;
    tvAllReservationsStatistics: TcxGridDBColumn;
    tvAllReservationsRoomReservation: TcxGridDBColumn;
    tvAllReservationsroomCount: TcxGridDBColumn;
    tvAllReservationsReservation: TcxGridDBColumn;
    tvAllReservationsStatus: TcxGridDBColumn;
    tvAllReservationsLocation: TcxGridDBColumn;
    tvAllReservationsmarketSegment: TcxGridDBColumn;
    tvAllReservationsresInfo: TcxGridDBColumn;
    tvAllReservationshidden: TcxGridDBColumn;
    tvAllReservationsEquipments: TcxGridDBColumn;
    lvAllReservations: TcxGridLevel;
    btnGroupReportExpandAll: TcxButton;
    btnGroupreportCollapseAll: TcxButton;
    btnGuestListExcel: TcxButton;
    rptbGroups: TppReport;
    ppParameterList1: TppParameterList;
    dplGroups: TppDBPipeline;
    mDS: TDataSource;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppLabel1: TppLabel;
    ppDBText1: TppDBText;
    ppLabel2: TppLabel;
    ppDBText2: TppDBText;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    tvAllReservationsGroupReservation: TcxGridDBColumn;
    ppDBText3: TppDBText;
    ppDBCalc1: TppDBCalc;
    ppLabel3: TppLabel;
    ppLine1: TppLine;
    ppLine2: TppLine;
    tvAllReservationsResLine: TcxGridDBColumn;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppDBText8: TppDBText;
    ppLabel8: TppLabel;
    ppDBCalc2: TppDBCalc;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppLine3: TppLine;
    rLabReportName: TppLabel;
    ppLabel9: TppLabel;
    rlabFrom: TppLabel;
    rLabHotelName: TppLabel;
    rlabUser: TppLabel;
    rLabTimeCreated: TppLabel;
    ppLine4: TppLine;
    mem: TppMemo;
    ppDBText4: TppDBText;
    grbGroupReportProperties: TsGroupBox;
    chkNewPage: TsCheckBox;
    chkPrintMemo: TsCheckBox;
    ppLabel4: TppLabel;
    ppLabel10: TppLabel;
    dxBarButton1: TdxBarButton;
    btnShowHideStat: TdxBarLargeButton;
    m: TkbmMemTable;
    StoreMain: TcxPropertiesStore;
    sSkinProvider1: TsSkinProvider;
    N2: TMenuItem;
    S1: TMenuItem;
    dxBarSubItem1: TdxBarSubItem;
    dxBarLargeButton3: TdxBarLargeButton;
    grOneDayRooms: TAdvStringGrid;
    pnlNoRoomDrop: TsPanel;
    arrowImage: TImage;
    lblNoRoom: TsLabel;
    timLogout: TTimer;
    btnRefreshOneDay: TcxButton;
    tabsView: TsTabControl;
    sSkinManager1: TsSkinManager;
    timCheckSessionExpired: TTimer;
    panelHide: TsPanel;
    lblAuthStatus: TsLabel;
    btnRateRules: TdxBarLargeButton;
    dxBarLargeButton4: TdxBarLargeButton;
    timSearch: TTimer;
    sLabel1: TsLabel;
    lblSearchFilterActive: TsLabel;
    btnFilter: TsSpeedButton;
    mnuFilter: TPopupMenu;
    G1: TMenuItem;
    ilFilter: TImageList;
    C1: TMenuItem;
    T1: TMenuItem;
    S2: TMenuItem;
    N11: TMenuItem;
    N21: TMenuItem;
    N31: TMenuItem;
    N41: TMenuItem;
    N51: TMenuItem;
    N61: TMenuItem;
    N12: TMenuItem;
    dxSkinController1: TdxSkinController;
    tabFreeRooms: TsTabSheet;
    btnGotoToday: TcxButton;
    btnChannels: TdxBarLargeButton;
    timGetRoomStatuses: TTimer;
    btnServers: TdxBarButton;
    btnActions: TdxBarButton;
    btnTriggers: TdxBarButton;
    btnPackages: TdxBarLargeButton;
    btnRates: TdxBarLargeButton;
    lblLoading: TsLabel;
    btnForward: TcxButton;
    ilBackForth: TsAlphaImageList;
    cxBarEditItem1: TcxBarEditItem;
    dxBarSubItem2: TdxBarSubItem;
    __dxBarCombo1: TdxBarCombo;
    btnGroupReportShow: TcxButton;
    dxRibbon1Tab3: TdxRibbonTab;
    barinnBar12: TdxBar;
    barinnBar3: TdxBar;
    barinnBar4: TdxBar;
    dxBarSeparator1: TdxBarSeparator;
    dxBarSeparator2: TdxBarSeparator;
    dxBarSubItem3: TdxBarSubItem;
    dxBarSeparator3: TdxBarSeparator;
    dxBarSubItem4: TdxBarSubItem;
    dxBarSeparator4: TdxBarSeparator;
    dxBarSeparator5: TdxBarSeparator;
    dxBarSubItem5: TdxBarSubItem;
    dxBarSubItem6: TdxBarSubItem;
    btnManagerChannelManagerList: TdxBarLargeButton;
    barinnBar5: TdxBar;
    btnDownloadBackup: TdxBarLargeButton;
    dlgSave: TSaveDialog;
    timRetryRefresh: TTimer;
    btnCommunicationTest: TdxBarLargeButton;
    timMessages: TTimer;
    pnlMessages: TsPanel;
    sPanel1: TsPanel;
    mmoMessage: THTMLabel;
    sButton2: TsButton;
    timHalt: TTimer;
    btnLanguage: TdxBarLargeButton;
    btnChannelPlans: TdxBarLargeButton;
    btnReservationsList: TdxBarLargeButton;
    btnChanceledReservation: TdxBarLargeButton;
    btnTestData: TdxBarLargeButton;
    pmnuChannelSettings: TPopupMenu;
    N01: TMenuItem;
    PanStat: TsScrollBox;
    sSplitter1: TsSplitter;
    lblBusyDownloading: TsLabel;
    Panel5: TsPanel;
    Chart1: TChart;
    Series1: TBarSeries;
    grdRoomStatusses: TAdvStringGrid;
    grdRoomClasses: TAdvStringGrid;
    pnlDateStatistics: TsPanel;
    pnlTimeMessage: TsPanel;
    lblTimeMessage: TsLabel;
    timHideTimeMessage: TTimer;
    Image1: TImage;
    lblRoomBeingMoved: TsLabel;
    mnuItemCopyReservationToClipboard: TMenuItem;
    N3: TMenuItem;
    mnuItemPasteReservationFromClipboard: TMenuItem;
    pmnuProvideAllotment: TMenuItem;
    imgBlinker: TImage;
    N4: TMenuItem;
    mnuItmColorCodeRoom: TMenuItem;
    btnChannelToggleRules: TdxBarLargeButton;
    btnDeleteCache: TdxBarLargeButton;
    btnPersonvipTypes: TdxBarLargeButton;
    btnContactTypes: TdxBarLargeButton;
    btnDashboard: TdxBarLargeButton;
    tabDashboard: TsTabSheet;
    btnTurnover: TdxBarLargeButton;
    tvAllReservationsReservationName: TcxGridDBColumn;
    tvAllReservationsCustomerName: TcxGridDBColumn;
    tvAllReservationsGroupReservationName: TcxGridDBColumn;
    tvAllReservationsmem: TcxGridDBColumn;
    _mnuItemStatus: TMenuItem;
    G3: TMenuItem;
    N5: TMenuItem;
    D1: TMenuItem;
    W1: TMenuItem;
    N6: TMenuItem;
    A1: TMenuItem;
    B1: TMenuItem;
    C2: TMenuItem;
    P1: TMenuItem;
    N7: TMenuItem;
    dlgAdvGridPrintSettings: TAdvGridPrintSettingsDialog;
    btnTaxes: TdxBarLargeButton;
    btnDownPayments: TdxBarLargeButton;
    pnlNotifications: TsPanel;
    tvAllReservationsbreakfastGuests: TcxGridDBColumn;
    btnEmailTemplates: TdxBarLargeButton;
    btnCancelReservations: TMenuItem;
    btnTotallist: TdxBarLargeButton;
    mnuItemStatus: TPopupMenu;
    Currentguest1: TMenuItem;
    Notarrived1: TMenuItem;
    Departed1: TMenuItem;
    Waitinglist1: TMenuItem;
    NOShow1: TMenuItem;
    Alotment1: TMenuItem;
    Blockedroom1: TMenuItem;
    Cancellation1: TMenuItem;
    mnuFilterLocation: TPopupMenu;
    G2: TPopupMenu;
    __lblSearch: TsLabel;
    btnCustInvoices: TdxBarLargeButton;
    sPanel3: TsPanel;
    btnStatusFilter: TsSpeedButton;
    btnLocationFilter: TsSpeedButton;
    btnGroupsFilter: TsSpeedButton;
    edtSearch: TButtonedEdit;
    sPanel4: TsPanel;
    lblMainHeader: TsLabel;
    lblPropertyStatus: TsLabel;
    pnlRoomerLogoOld: TsPanel;
    Image5: TImage;
    lblHotelName: TsLabel;
    pnlRBE: TsPanel;
    pupGroups: TPopupMenu;
    C4: TMenuItem;
    C5: TMenuItem;
    N8: TMenuItem;
    I1: TMenuItem;
    G4: TMenuItem;
    dtDate: TsDateEdit;
    btnManagmentStat: TdxBarLargeButton;
    dxBarLargeButton1: TdxBarLargeButton;
    tabRateQuery: TsTabSheet;
    sLabel2: TsLabel;
    pnlPeriodNoRooms: TsPanel;
    pnlRoomerLogo: TsPanel;
    lblLogout: TsLabel;
    lblUsername: TsLabel;
    __cbxHotels: TsComboBox;
    pnlOffline: TsPanel;
    btnGoOnline: TsButton;
    btnSearchForGuests: TcxButton;
    timBlinker: TTimer;
    dxBarLargeButton2: TdxBarLargeButton;
    btnBreakfastGuests: TcxButton;
    btnLostAndFound: TdxBarLargeButton;
    btnRptNotes: TdxBarLargeButton;
    pnlDayStatus: TsPanel;
    lblOccupancy: TsLabel;
    cbxStatDay: TsComboBox;
    __OCCUPANCY: TsLabel;
    lblStatAdr: TsLabel;
    __ADR: TsLabel;
    lblStatRevPar: TsLabel;
    __REVPAR: TsLabel;
    lblStatRoomsSold: TsLabel;
    __ROOMSSOLD: TsLabel;
    __VER: TsLabel;
    btnGuests: TdxBarLargeButton;
    pnlViewType: TsPanel;
    cbxViewTypes: TsComboBox;
    btnBack: TcxButton;
    pnlBottomViewSettings: TsPanel;
    pnlOccupancyViewButtons: TPanel;
    btnOccupancyViewHide: TSpeedButton;
    btnOccupancyViewDefault: TSpeedButton;
    btnOccupancyViewAdvanced: TSpeedButton;
    pnlNoRoomButtons: TsPanel;
    btnNoRoomsHide: TSpeedButton;
    btnNoRoomsShow: TSpeedButton;
    grPeriodRooms_NO: TAdvStringGrid;
    pnlViewSwitch: TsPanel;
    btnOccupancyView: TSpeedButton;
    btnUnassignedReservations: TSpeedButton;
    pnlLegends: TsPanel;
    sPanel2: TsPanel;
    __ExplainG: TsLabel;
    shpG: TShape;
    __ExplainP: TsLabel;
    shpP: TShape;
    __ExplainDeparting: TsLabel;
    shpDeparting: TShape;
    __ExplainB: TsLabel;
    shpB: TShape;
    __ExplainN: TsLabel;
    shpN: TShape;
    __ExplainO: TsLabel;
    shpO: TShape;
    P2: TMenuItem;
    P3: TMenuItem;
    P4: TMenuItem;
    S3: TMenuItem;
    F1: TMenuItem;
    F2: TMenuItem;
    S4: TMenuItem;
    btnClearWindowCache: TdxBarLargeButton;
    btnGuestProfiles: TdxBarLargeButton;
    btnBookKeepingCodes: TdxBarLargeButton;
    btnHotelSpecificSqlQueries: TdxBarLargeButton;
    barinnBar9: TdxBar;
    btnTextBasedTemplates: TdxBarLargeButton;
    barinnBar10: TdxBar;
    btnBookKeepingQueries: TdxBarLargeButton;
    mnuEmailTemplates: TdxBarPopupMenu;
    mniBookinglEmailTemplates: TdxBarSubItem;
    mniCancelEmailTemplates: TdxBarSubItem;
    R1: TMenuItem;
    C6: TMenuItem;
    dxBarSeparator6: TdxBarSeparator;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarButton4: TdxBarButton;
    dxBarLargeButton5: TdxBarLargeButton;
    btnCashierReport: TdxBarLargeButton;
    tvAllReservationsNights: TcxGridDBColumn;
    tvAllReservationsCurrency: TcxGridDBColumn;
    tvAllReservationsAverageRate: TcxGridDBColumn;
    tvAllReservationsTotalStayRate: TcxGridDBColumn;
    tvAllReservationsAdults: TcxGridDBColumn;
    tvAllReservationsChildren: TcxGridDBColumn;
    tvAllReservationsInfants: TcxGridDBColumn;
    pnlStatSlider: TsPanel;
    ApplicationEvents1: TApplicationEvents;
    lblCacheNotification: TsLabel;
    P5: TMenuItem;
    btnWebAccessibleFiles: TdxBarLargeButton;
    dxBarSubItem7: TdxBarSubItem;
    dxBarButton5: TdxBarButton;
    btnReDownloadRoomer: TdxBarButton;
    dxBarLargeButton6: TdxBarLargeButton;
    pnlStaffComm: TsPanel;
    sImage1: TsImage;
    mnuConfirmBooking: TMenuItem;
    btnConfirmAllottedBooking: TdxBarLargeButton;
    HTMLHint1: THTMLHint;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    procedure pageMainGridsChange(Sender: TObject);
    procedure dtDateModified(Sender: TObject);
    procedure dtDateKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure mlLanguagesAfterLanguageChanged(Sender: TObject; NewLanguage: Byte);
    procedure __PanGridsHeaderDblClick(Sender: TObject);
    procedure mnuRemoveRoomNumberOfThisRoomClick(Sender: TObject);
    procedure mnuGlobalReservationChangesClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnHideCaptonsClick(Sender: TObject);
    procedure barinnBarAdd(Sender: TdxBarManager; ABar: TdxBar);
    procedure grOneDayRoomsClick(Sender: TObject);
    procedure grOneDayRoomsEnter(Sender: TObject);
    procedure grOneDayRoomsMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure grOneDayRoomsDragDrop(Sender, Source: TObject; X, Y: integer);
    procedure grOneDayRoomsDragOver(Sender, Source: TObject; X, Y: integer; State: TDragState; var Accept: boolean);
    procedure grOneDayRoomsDrawCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
    procedure grOneDayRoomsEndDrag(Sender, Target: TObject; X, Y: integer);
    procedure grOneDayRoomsMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure grOneDayRoomsMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure grOneDayRoomsStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure timKillDragTimer(Sender: TObject);
    procedure pnlNoRoomDropDragDrop(Sender, Source: TObject; X, Y: integer);
    procedure pnlNoRoomDropDragOver(Sender, Source: TObject; X, Y: integer; State: TDragState; var Accept: boolean);
    procedure grPeriodRoomsGetCellColor(Sender: TObject; ARow, ACol: integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure grPeriodRoomsClickCell(Sender: TObject; ARow, ACol: integer);
    procedure grPeriodRoomsGetCellBorder(Sender: TObject; ARow, ACol: integer; APen: TPen; var Borders: TCellBorders);
    procedure dtDateChange(Sender: TObject);
    procedure grPeriodRoomsEndColumnSize(Sender: TObject; ACol: integer);
    procedure grOneDayRoomsClickCell(Sender: TObject; ARow, ACol: integer);
    procedure grPeriodRoomsDblClickCell(Sender: TObject; ARow, ACol: integer);
    procedure grPeriodRooms_NOClickCell(Sender: TObject; ARow, ACol: integer);
    procedure grPeriodRooms_NOGetCellColor(Sender: TObject; ARow, ACol: integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure grPeriodRooms_NOGetCellBorder(Sender: TObject; ARow, ACol: integer; APen: TPen; var Borders: TCellBorders);
    procedure grPeriodRoomsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure timBlinkTimer(Sender: TObject);
    procedure btnMaidsClick(Sender: TObject);
    procedure tabsViewChange(Sender: TObject);
    procedure cbxNameOrderChange(Sender: TObject);
    procedure btnHelpContentClick(Sender: TObject);
    procedure btnDayNotesClick(Sender: TObject);
    procedure btnChangeDateClick(Sender: TObject);
    procedure btnLogOutClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnCheckInRoomClick(Sender: TObject);
    procedure btnCheckInGroupClick(Sender: TObject);
    procedure btnCheckOutRoomClick(Sender: TObject);
    procedure btnRoomInvoiceClick(Sender: TObject);
    procedure btnGroupInvoiceClick(Sender: TObject);
    procedure btnCashInvoiceClick(Sender: TObject);
    procedure btnCreditInvoiceClick(Sender: TObject);
    procedure btnFinishedInvoicesClick(Sender: TObject);
    procedure btnOpenInvoicesClick(Sender: TObject);
    procedure btnClosedInvoicesThisreservationClick(Sender: TObject);
    procedure btnClosedInvoicesThisRoomClick(Sender: TObject);
    procedure btnClosedInvoicesThisCustomerClick(Sender: TObject);
    procedure btnClosedInvoicesAllDetailedListClick(Sender: TObject);
    procedure btnClosedInvoicesAllSimpleListClick(Sender: TObject);
    procedure btnNewReservationClick(Sender: TObject);
    procedure btnModifyReservationClick(Sender: TObject);
    procedure btnCancelReservationBtnClick(Sender: TObject);
    procedure btnRoomGuestsClick(Sender: TObject);
    procedure btnDeleteReservationClick(Sender: TObject);
    procedure btnRemoveThisRoomClick(Sender: TObject);
    procedure btnNextDayClick(Sender: TObject);
    procedure btnToDayClick(Sender: TObject);
    procedure btnPreviusDayClick(Sender: TObject);
    procedure btnDayViewClick(Sender: TObject);
    procedure btnPeriodViewClick(Sender: TObject);
    procedure btnDayFinalClick(Sender: TObject);
    procedure btnRptCustInvoicesClick(Sender: TObject);
    procedure btnRptNationalReportClick(Sender: TObject);
    procedure btnRptFinanceForecastClick(Sender: TObject);
    procedure btnMeetingsViewClick(Sender: TObject);
    procedure btnRoomsClick(Sender: TObject);
    procedure btnRoomTypesClick(Sender: TObject);
    procedure btnLocationsClick(Sender: TObject);
    procedure btnSetNoRoomAllClick(Sender: TObject);
    procedure btnSetNoRoomThisClick(Sender: TObject);
    procedure btnCustomerListClick(Sender: TObject);
    procedure btnCustomerTypeListClick(Sender: TObject);
    procedure btnCountriesListClick(Sender: TObject);
    procedure btnCountryGroupsListClick(Sender: TObject);
    procedure btnCurrenciesListClick(Sender: TObject);
    procedure btnProvideARoomClick(Sender: TObject);
    procedure btnSerachGuestsClick(Sender: TObject);
    procedure btnEmployeeListClick(Sender: TObject);
    procedure btnEmployeeTypesListClick(Sender: TObject);
    procedure btnStaffAuthorizationListClick(Sender: TObject);
    procedure btnRoomPriceClick(Sender: TObject);
    procedure btnRoomPriceTypesClick(Sender: TObject);
    procedure btnSeasonsClick(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure btnRemoteSupportClick(Sender: TObject);
    procedure btnVatCodesListClick(Sender: TObject);
    procedure btnPaymentGroupListClick(Sender: TObject);
    procedure btnPaymentTypesListClick(Sender: TObject);
    procedure btnItemsListClick(Sender: TObject);
    procedure btnItemTypeListClick(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
    procedure btnLanguageClick(Sender: TObject);
    procedure btnVariblesClick(Sender: TObject);
    procedure btnVariblesGroupsClick(Sender: TObject);
    procedure BtnMaidJobScriptsClick(Sender: TObject);
    procedure actLanguageExecute(Sender: TObject);
    procedure btnJumpToRoomAndDateClick(Sender: TObject);
    procedure cbxNameOrderPeriodChange(Sender: TObject);
    procedure grPeriodRoomsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnRoomReservationClick(Sender: TObject);
    procedure btnLPreviusDayClick(Sender: TObject);
    procedure btnLTodayClick(Sender: TObject);
    procedure btnLNextDayClick(Sender: TObject);
    procedure CheckInGroup1Click(Sender: TObject);
    procedure btnRoomTypeGroupsClick(Sender: TObject);
    procedure btnResStatClick(Sender: TObject);
    procedure btnQuicReservationClick(Sender: TObject);
    procedure btnShowHideHintClick(Sender: TObject);
    procedure btnReservationNotesClick(Sender: TObject);
    procedure btnRptCustInvoices2Click(Sender: TObject);
    procedure btnPhonePricesClick(Sender: TObject);
    procedure btnLodgingTaxReportClick(Sender: TObject);
    procedure NewReservation1Click(Sender: TObject);
    procedure QuickReservation1Click(Sender: TObject);
    procedure btnGroupsReportClick(Sender: TObject);
    procedure rgrTypePropertiesEditValueChanged(Sender: TObject);
    procedure rgrUsePropertiesEditValueChanged(Sender: TObject);
    procedure btnGroupReportExpandAllClick(Sender: TObject);
    procedure btnGroupreportCollapseAllClick(Sender: TObject);
    procedure btnGuestListExcelClick(Sender: TObject);
    procedure btnGroupReportShowClick(Sender: TObject);
    procedure ppHeaderBand1BeforePrint(Sender: TObject);
    procedure ppGroupHeaderBand1BeforePrint(Sender: TObject);
    procedure btnCurrentGuestsReportClick(Sender: TObject);
    procedure grPeriodRoomsMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure grPeriodRoomsDragOver(Sender, Source: TObject; X, Y: integer; State: TDragState; var Accept: boolean);
    procedure grPeriodRoomsDragDrop(Sender, Source: TObject; X, Y: integer);
    procedure grPeriodRooms_NODragDrop(Sender, Source: TObject; X, Y: integer);
    procedure grPeriodRooms_NODragOver(Sender, Source: TObject; X, Y: integer; State: TDragState; var Accept: boolean);
    procedure grPeriodRooms_NOMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure grPeriodRooms_NOKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grPeriodRooms_NOKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grPeriodRoomsMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure btnShowHideStatClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure dxBarSubItem1Click(Sender: TObject);
    procedure timLogoutTimer(Sender: TObject);
    procedure tabsViewChanging(Sender: TObject; var AllowChange: boolean);
    procedure timCheckSessionExpiredTimer(Sender: TObject);
    procedure btnRefreshOneDayClick(Sender: TObject);
    procedure dxBarLargeButton4Click(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure timSearchTimer(Sender: TObject);
    procedure btnClearSearchClick(Sender: TObject);
    procedure btnFilterClick(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure mnuFilterLocationClick(Sender: TObject);
    procedure rgrGroupreportStayTypeChanging(Sender: TObject; NewIndex: integer; var AllowChange: boolean);
    procedure btnChannelsClick(Sender: TObject);
    procedure timGetRoomStatusesTimer(Sender: TObject);
    procedure grdRoomStatussesGetAlignment(Sender: TObject; ARow, ACol: integer; var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure btnRatesClick(Sender: TObject);
    procedure btnBackForwardClick(Sender: TObject);
    procedure btnManagerChannelManagerListClick(Sender: TObject);
    procedure btnDownloadBackupClick(Sender: TObject);
    procedure __lblSearchDblClick(Sender: TObject);
    procedure btnCommunicationTestClick(Sender: TObject);
    procedure timRetryRefreshTimer(Sender: TObject);
    procedure timMessagesTimer(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure Chart1DblClick(Sender: TObject);
    procedure grOneDayRoomsResize(Sender: TObject);
    procedure grOneDayRoomsEndColumnSize(Sender: TObject; ACol: integer);
    procedure timHaltTimer(Sender: TObject);
    procedure grPeriodRoomsDrawCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
    procedure grPeriodRoomsGridHint(Sender: TObject; ARow, ACol: integer; var HintStr: string);
    procedure HTMLHint1ShowHint(var HintStr: string; var CanShow: boolean; var HintInfo: THintInfo);
    procedure btnChannelPlansClick(Sender: TObject);
    procedure btnReservationsListClick(Sender: TObject);
    procedure btnTestDataClick(Sender: TObject);
    procedure grdRoomClassesCanEditCell(Sender: TObject; ARow, ACol: integer; var CanEdit: boolean);
    procedure grdRoomClassesCellValidate(Sender: TObject; ACol, ARow: integer; var Value: string; var Valid: boolean);
    procedure grdRoomClassesDrawCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
    procedure grdRoomClassesMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure grdRoomClassesGetCellBorder(Sender: TObject; ARow, ACol: integer; APen: TPen; var Borders: TCellBorders);
    procedure grPeriodRoomsResize(Sender: TObject);
    procedure timHideTimeMessageTimer(Sender: TObject);
    procedure grdRoomClassesMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure grPeriodRoomsStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure grOneDayRoomsDragScroll(Sender: TObject; TopRow, LeftCol: integer; var DragScrollDir: TDragScrollDirection; var CanScroll: boolean);
    procedure mmoMessageAnchorClick(Sender: TObject; Anchor: string);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure grPeriodRoomsEnter(Sender: TObject);
    procedure mnuItemCopyReservationToClipboardClick(Sender: TObject);
    procedure mnuItemPasteReservationFromClipboardClick(Sender: TObject);
    procedure mmnuOneDayGridPopup(Sender: TObject);
    procedure pmnuProvideAllotmentClick(Sender: TObject);
    procedure __cbxHotelsChange(Sender: TObject);
    procedure mnuItmColorCodeRoomClick(Sender: TObject);
    procedure grdRoomStatussesDrawCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
    procedure btnChannelToggleRulesClick(Sender: TObject);
    procedure btnDeleteCacheClick(Sender: TObject);
    procedure btnPersonvipTypesClick(Sender: TObject);
    procedure btnContactTypesClick(Sender: TObject);
    procedure btnDashboardClick(Sender: TObject);
    procedure btnTurnoverClick(Sender: TObject);
    procedure rgrGroupreportStayTypeClick(Sender: TObject);
    procedure rgrGroupReportDateTypeClick(Sender: TObject);
    procedure C2Click(Sender: TObject);
    procedure P1Click(Sender: TObject);
    procedure btnTaxesClick(Sender: TObject);
    procedure btnDownPaymentsClick(Sender: TObject);
    procedure btnCancelThisReservationClick(Sender: TObject);
    procedure btnTotallistClick(Sender: TObject);
    procedure mnuCancelReservation2Click(Sender: TObject);
    procedure btnStatusFilterClick(Sender: TObject);
    procedure btnLocationFilterClick(Sender: TObject);
    procedure btnGroupsFilterClick(Sender: TObject);
    procedure dtMainHeaderPropertiesChange(Sender: TObject);
    procedure C4Click(Sender: TObject);
    procedure pupGroupsPopup(Sender: TObject);
    procedure C5Click(Sender: TObject);
    procedure I1Click(Sender: TObject);
    procedure G4Click(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
    procedure lblPropertyStatusDblClick(Sender: TObject);
    procedure btnManagmentStatClick(Sender: TObject);
    procedure pmnuReservationRoomListClick(Sender: TObject);
    procedure mnuRoomListForReservationClick(Sender: TObject);
    procedure pnlRoomerLogoDblClick(Sender: TObject);
    procedure pnlRoomerLogoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure btnPackagesClick(Sender: TObject);
    procedure btnGoOnlineClick(Sender: TObject);
    procedure grPeriodRoomsGetAlignment(Sender: TObject; ARow, ACol: integer; var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure grOneDayRoomsGridHint(Sender: TObject; ARow, ACol: integer; var HintStr: string);
    procedure timBlinkerTimer(Sender: TObject);
    procedure dxBarLargeButton2Click(Sender: TObject);
    procedure btnBreakfastGuestsClick(Sender: TObject);
    procedure grPeriodRoomsMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure __dxBarCombo1CloseUp(Sender: TObject);
    procedure btnLostAndFoundClick(Sender: TObject);
    procedure btnRptNotesClick(Sender: TObject);
    procedure cbxStatDayChange(Sender: TObject);
    procedure btnGuestsClick(Sender: TObject);
    procedure cbxViewTypesCloseUp(Sender: TObject);
    procedure tabsViewMouseEnter(Sender: TObject);
    procedure pnlNoRoomButtonsMouseEnter(Sender: TObject);
    procedure btnNoRoomsHideClick(Sender: TObject);
    procedure btnOccupancyViewHideClick(Sender: TObject);
    procedure btnOccupancyViewClick(Sender: TObject);
    procedure btnOccupancyViewMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure splitPeriodMoved(Sender: TObject);
    procedure S3Click(Sender: TObject);
    procedure F2Click(Sender: TObject);
    procedure F1Click(Sender: TObject);
    procedure grOneDayRoomsDblClickCell(Sender: TObject; ARow, ACol: integer);
    procedure btnClearWindowCacheClick(Sender: TObject);
    procedure lblUsernameDblClick(Sender: TObject);
    procedure btnGuestProfilesClick(Sender: TObject);
    procedure btnBookKeepingCodesClick(Sender: TObject);
    procedure btnHotelSpecificSqlQueriesClick(Sender: TObject);
    procedure btnTextBasedTemplatesClick(Sender: TObject);
    procedure btnBookKeepingQueriesClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mniBookinglEmailTemplatesClick(Sender: TObject);
    procedure mniCancelEmailTemplatesClick(Sender: TObject);
    procedure R1Click(Sender: TObject);
    procedure C6Click(Sender: TObject);
    procedure btnEmailTemplatesClick(Sender: TObject);
    procedure btnCashierReportClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure tvAllReservationsAverageRateGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure tvAllReservationsTotalStayRateGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure lblLogoutClick(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: boolean);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: boolean);
    procedure ApplicationEvents1Deactivate(Sender: TObject);
    procedure ApplicationEvents1Activate(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure ApplicationEvents1Restore(Sender: TObject);
    procedure btnWebAccessibleFilesClick(Sender: TObject);
    procedure P5Click(Sender: TObject);
    procedure btnReDownloadRoomerClick(Sender: TObject);
    procedure btnRateRulesClick(Sender: TObject);
    procedure btnSetNoroomClick(Sender: TObject);
    procedure btnConfirmAllottedBookingClick(Sender: TObject);
    procedure sSkinManager1SkinLoading(Sender: TObject);
    procedure sPanel3DblClick(Sender: TObject);

  private
    FrmMessagesTemplates: TFrmMessagesTemplates;
    { Private declarations }
    ShowComponentNameOnHint: boolean;

    zJustClicked: boolean;

    zShowCaptions: boolean;
    zDateFrom: TdateTime;
    zDateTo: TdateTime;
    zNights: integer;

    zEmptyRoomNumber: string;

    zDoRefresh: boolean;
    zDoRefreshPeriod: boolean;

    // Golbals for 5-dayGrid
    zShowRoomDescription: boolean;

    // OneDay
    zOneDay_ResIndex: integer;
    zOneDay_bDetailsOn: boolean;
    zOneDay_dtDate: TdateTime;
    zOneDay_bNewGuest: boolean;
    zOneDay_stlTakenTypes: TStringList;
    zOneDay_bIsOverlapped: boolean;
    zOneDay_iNumRows: integer;
    zOneDay_iLastCol: integer;
    zOneDay_iLastRow: integer;
    zOneDay_bRightClick: boolean;
    zOneDay_glbRect: TRect;

    zGridTag: integer;

    zRoom: string;

    zGotoRow: integer;
    zGotoCol: integer;

    zGuestListFirstTime: boolean;

    zsFreeRackRooms: string;
    zsOccRackRooms: string;
    zsNoRooms: string;

    ziFreeRackRoomCount: integer;

    LoginCancelled: boolean;
    LoggedIn: boolean;
    grPeriodViewFilterOn: boolean;

    GroupList: TGroupEntityList;

    ExceptionsLoggingActive: boolean;
    ExceptionLogPath: String;

    HoverPointOneDay: TPoint;
    HoverPointPeriod: TPoint;
    lastDate: TdateTime;
    availListContainer: TRoomClassChannelAvailabilityContainerDictionary;
    MoveFunctionAvailRooms: TRoomAvailabilityEntityList;

    CurrentlyActiveGrid: TAdvStringGrid;
    FRBEMode: boolean;
    FOffLineMode: boolean;
    FMessagesBeingDownloaded: boolean;

    // *s    zRoomsOBJ : TRoom;

    procedure Open_RR_EdForm(_grid: TAdvStringGrid);
    procedure Open_RES_edForm(_grid: TAdvStringGrid);

    procedure OneDay_Refresh;
    function OneDay_GetReservation(var iReservation, iRoom: integer; var sRoom: string): boolean;

    function OneDay_GetIsLeftOrRight(iCol: integer): integer;
    function OneDay_isATakenType(ACol, ARow: integer): boolean;
    function OneDay_RoomReservedName(RoomNumber: string; iRes, iRoom: integer): string;
    procedure OneDay_CheckOut;
    procedure OneDay_CheckIn;
    procedure OneDay_InvoiceInfo;
    procedure OneDay_RemoveRoom(_grid: TAdvStringGrid; bAll: boolean);
    procedure OneDay_GlobalChange;
    procedure OneDay_RoomInvoice(invType: integer);
    procedure OneDay_DeleteRoomReservation;
    procedure OneDay_InvoicesPerRoom;
    procedure OneDay_InvoicesPerRes;
    procedure OneDay_InvoicesPerCustomer;
    procedure OneDay_EditPerson;
    procedure OneDay_ShowTheNameList;
    procedure OneDay_DoAJump(theRoom: string);
    function OneDay_DoProvideRoom: boolean;
    procedure OneDay_DisplayGrid;
    procedure OneDay_NewGuestCoordinates(RoomNumber: string; var iRes, iRoom: integer);
    procedure OneDay_AddToTaken(sType: string);
    procedure OneDay_CheckHint(X, Y: integer);
    function Period_CheckHint(Sender: TObject; X, Y: integer; iReservation: integer = 0; iRoomReservation: integer = 0): String;

    procedure OneDay_GetResAndRoom_IDX(var idxReservation, idxRoom: integer);

    procedure OneDay_ShowSelectedCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
    procedure OneDay_ShowNonSelectedCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);

    procedure SetWindowTitle;
    procedure BusyOn;
    procedure BusyOff;
    function IsValidCellSelected: boolean;
    procedure UpdatePanelText;
    procedure DisplayDate(aDate: Tdate);
    procedure InitializeViews;

    function LoadOneDayViewGridStatus: boolean;
    procedure SaveOneDayViewGridStatus;

    procedure OneDayUpdatePage(aDate: TdateTime);

    procedure RestoreCurrentFont;

    procedure ExceptionHandler(Sender: TObject; E: Exception);

    procedure GetRoomInfo;
    procedure CheckInGroup;
    procedure RemoveAReservation;

    // FILE
    // Procedure Logout;
    function StartHotel(appstart: boolean; ForcefulRestart: boolean = false; AutoLogin: String = ''): boolean;
    procedure SaveGridFont(OneDayFont, PeriodFont: TFont);

    function doLogin(var userName, password, WrongLoginMessage, ExpiredMessage: string; var pressedEsc: boolean; AutoLogin: String = ''): boolean;

    /// ////////////////////////////////////////////////////////////////////////
    /// ////////////////////////////////////////////////////////////////////////

    procedure EnterPeriodView;
    procedure EnterGuestListView;
    procedure EnterDayView;

    /// ////////////////////////////////////////////////////////////////////////
    /// ////////////////////////////////////////////////////////////////////////

    // **Period_ColToDate(ACol : integer) : TdateTime;

    function Period_Init: integer;

    function Period_GetRooms: integer;
    procedure Period_SetDateHeads;

    procedure Period_FillEmptyResCells;
    procedure Period_FillResCells(Days: integer = 0);

    function Period_GetStatus(ACol, ARow: integer): string;
    function Period_GetResStatus(_grid: TAdvStringGrid; ACol, ARow: integer; var status: string; var AscIndex, DescIndex: integer): boolean;

    function Period_GotoRoom(Room: string): boolean;
    function Period_RoomToRow(Room: string): integer;
    function Period_DateToCol(aDate: Tdate): integer;
    function Period_ColToDate(ACol: integer): TdateTime;
    function Period_RoomAndDateToCell(Room: string; aDate: Tdate): recColRow;

    function Period_GetNewResDates(var dtFrom: TdateTime): boolean;
    function Period_GetResInfo(ACol: integer; ARow: integer; gridTag: integer): RecRRInfo;

    procedure Period_MergeGrid;
    procedure Period_RestoreColumnSize;
    procedure Period_RestoreRowHeights;

    procedure Period_setColCount(nights: integer);

    /// ////////////////////////////////////////////////////////////////////////
    /// ////////////////////////////////////////////////////////////////////////

    function grNoRooms_Init: integer;
    function grNoRooms_ClearAll: integer;
    procedure grNoRooms_FillEmptyResCells;
    procedure grNoRooms_FillEmptyResRow(r: integer);
    procedure grNoRooms_MergeGrid;
    function grNoRooms_GetResStatus(ACol, ARow: integer; var status: string; var AscIndex, DescIndex: integer): boolean;
    procedure timBlinkRoom;
    procedure SetViews(ViewIndex: integer);

    // *Bar File
    procedure _Close;
    procedure _ChangeDate;
    procedure _Refresh;
    procedure _DayNotes;

    // *Bar Check in/out
    procedure _CheckInRoom;
    procedure _CheckInGroup;
    procedure _CheckOutRoom;

    // *Bar Invoives
    procedure _RoomInvoice;
    procedure _GroupInvoice;
    procedure _CashInvoice;
    procedure _CreditInvoice;
    procedure _FinishedInvoices;
    procedure _OpenInvoices;

    procedure _ClosedInvoicesSimple;
    procedure _ClosedInvoicesDetailed;

    procedure _ClosedInvoicesThisCustomer;
    procedure _ClosedInvoicesThisReservation;
    procedure _ClosedInvoicesThisRoom;

    // Bar Reservations
    procedure _NewReservation;
    procedure _Roomreservation;
    procedure _ModifyReservation;
    procedure _RemoveAReservation;
    procedure _RoomGuests;

    procedure _ReservationRoomList;
    procedure _DeleteReservation;
    procedure _RemoveThisRoom;
    procedure _CancelThisReservation;

    // Bar Navigation
    procedure _Nextday;
    procedure _Today;
    procedure _PreviusDay;

    // * Bar Set View
    procedure _DayView;
    procedure _PeriodView;
    procedure _GuestListView;

    // * Bar Reports
    procedure _RptDayFinal;
    procedure _RptCustomersInvoiceAllPayTypes;
    procedure _RptMaidsList;
    procedure _RptNationality;
    procedure _RptLodgingTax;
    procedure _RptFinancieForecast;

    // *bar roomData
    procedure _RoomList;
    procedure _RoomTypeList;
    procedure _RoomTypeGroupsList;
    procedure _RoomSelectionRules;
    procedure _LocationsList;

    // *bar Room Actions
    procedure _SearchAllGuests;
    procedure _ProvideARoom;
    procedure _SetNoRoomThis;
    procedure _SetNoRoomAll;
    procedure _JumptoRoomAndDate;

    // *bar customers - Countries - Currency
    procedure _CustomersList;
    procedure _CustomerTypeList;
    procedure _PersonvipTypesList;
    procedure _PersonContactTypeList;
    procedure _CountyList;
    procedure _CountryGroupList;
    procedure _CurrencyList;



    // *Bar Meetings

    // *Bar Sales Payments
    procedure _VatCodesList;
    procedure _PayGroupList;
    procedure _PayTypesList;
    procedure _ItemTypeList;
    procedure _ItemsList;
    procedure _packages;

    // *Bar Employee

    procedure _LostAndFound;
    procedure _EmployeeList;
    procedure _EmployeeTypesList;
    procedure _StaffAuthorizationList;

    // *Bar Phone
    procedure _PhonePrices;

    // * Bar Room Price
    procedure _PriceCodes;
    procedure _Seasons;

    // * Bar Help
    procedure _About;
    procedure _RemodeHelp;
    procedure _HelpContent;
    procedure _HotelList;

    // * Bar System
    procedure _Settings;
    procedure _Language;

    // procedure _Servers;
    // procedure _actions;
    // procedure _triggers;

    // * Bar Scripts
    procedure _VariblesList;
    procedure _VariblesGroupList;
    procedure _MaidJobScripts;
    procedure _RoomRates;
    procedure _Rates;

    // * Bar look
    procedure _HideCaptons;

    // * Bar Channels
    procedure _Channels;

    procedure StartOneDay;

    procedure _OldRpt;

    function Period_GotoRoomAndDate(Room: string; aDate: Tdate): boolean;

    procedure Compute_TreeMoves(X, Y: integer);

    procedure CreateQuickReservation(isQuick: boolean; showDetails: boolean = true; Blocked: boolean = false);
    function QuickResPeriodRoomObj(var oNewReservation: TNewReservation): integer;
    function QuickResOneDayRoomObj(var oNewReservation: TNewReservation): integer;

    procedure CreateProvideAllotment(Reservation: integer; showDetails: boolean = true);

    function getRoomReservationsList(aType: integer; includeNoshow, includeAllotment, includeBlocked: boolean): string;
    procedure refreshGuestList;
    function getSortField: string;
    procedure GuestListReport;
    function CheckForUpdatedRelease: boolean;
    function FilteredData(Reservation: TSingleReservations; Room: TRoomObject): boolean;
    // Reservation: TSingleReservations): Boolean;
    procedure LocationMenuSelect(Sender: TObject);
    function FilterActive: boolean;
    function LocationFiltered(Location: String): boolean;
    function SearchOrGroupFilterActive: boolean;
    function FreeRoomsFiltered: boolean;
    function LocationFilter(OnlyLocations: boolean = true): boolean;
    procedure PrepareFilterOrSearchDisplay(FreeRoomsFilterOn: boolean);
    procedure PrepareSkinSelections;
    procedure SelectSkinEvent(Sender: TObject);
    procedure grAutoSizeGrids;
    function FloorFiltered(Floor: integer): boolean;
    function ReservationNotInGroupList(resId: integer): boolean;
    function GroupsFilterActive: boolean;
    procedure DisplayRoomStatusses(Date: TdateTime);
    procedure FillRoomTypesGrid;
    function RoomTypeIndexInGrid(Grid: TAdvStringGrid; RoomType: String): integer;
    function GetAvailableCellText(Value: integer): String;
    procedure RefreshRoomList;
    procedure Period_UnMergeGrid;
    procedure grNoRooms_UnMergeGrid;
    procedure EnableDisableFunctions(Enable: boolean);
    procedure AutoResizeOneDayGrid;
    procedure ClearGroupList;
    procedure ClearFreeRooms;
    procedure ClearRoomTypeCount;
    // function FilteredFloors: TSet_Of_Integer;
    // function FilteredLocations: TSet_Of_Integer;
    function GroupFiltered(Reservation: integer): boolean;
    procedure DrawRectanglOnCanvas(_Canvas: TCanvas; iColor: integer; chRect: TRect);
    function getChannelColor(Reservation: TSingleReservations): integer;
    function getInvoiceMadeColor(PaymentInvoice: integer; NoRent: boolean; offColor, onColor, onGroupColor: integer; GroupAccount: boolean): integer;
    function getUnpaidItemsColor(Value: boolean; defaultColor: integer): integer;
    function getChannelColorByChannel(Channel: integer): integer;
    procedure AutoSizePeriodColumns;
    procedure FillPeriodGridWithRooms;
    procedure GetArrivingGuestIndexes(var idxRoom: integer; var idxReservation: integer; ACol, ARow: integer);
    procedure GetLeavingGuestIndexes(var idxRoom: integer; var idxReservation: integer; ACol, ARow: integer);
    procedure SelectStopChannel(Sender: TObject);
    procedure PopulateChannelStopMenu;
    procedure PlaceMouseClickToCell(Sender: TObject; X, Y: integer);
    procedure DisplayStatusses(IncludeChart: boolean);
    function Period_NO_ColToDate(ACol: integer): TdateTime;
    function AnyCheckedStopItems: boolean;
    procedure ShowTimelyMessage(sMessage: string);
    procedure HideRowsWithNotFittingRooms(currRow: integer; fromDate, toDate: Tdate);
    procedure ShowAllRoomsRows;
    procedure FindRoomInPeriodView(Room: String);
    function AnyHiddenRow(Sender: TAdvStringGrid): boolean;
    function OneDayGridRoomReservationOfCell(DragCell: TPoint): integer;
    procedure ListRoomsAvailable(fromDate, toDate: Tdate);
    procedure OneDayGridArrivalAndDepartureOfCell(DragCell: TPoint; var Arrival, Departure: Tdate);
    function IsRoomAvailableInMoveFunctionAvailRooms(Room: String): boolean;
    function OneDayGridRoomNumberOfCell(DragCell: TPoint): String;
    function OneDayGridRoomTypeOfCell(DragCell: TPoint): String;
    procedure GetDragGuestIndexes(DragCell: TPoint; var idxReservation, idxRoomReservation: integer);
    procedure AssignSkinColorsToComponents;
    procedure SetFilterColorsOff;
    procedure SetFilterColorsOn;
    procedure EnterPeriodDragFilter;
    procedure FillRoomOnTheMove(RoomExternal: boolean; row, col: integer; rri: RecRRInfo);
    procedure EnterPeriodDragFilterExternal;
    function ActiveGrid: TAdvStringGrid;
    procedure ApplyFiltersToPeriodView(Grid: TAdvStringGrid);
    function SearchActive: boolean;
    function FilterPassededForPeriodData(Room: TresCell): boolean;
    procedure ShowAllPeriodRows;
    procedure RedisplayGuestWindows;
    function LocationOrFloorFilterActive: boolean;
    function AnyPeriodRowsMinimized: boolean;
    procedure ReEnableFiltersInPeriodGrid;
    procedure CopyReservation(reservationId: integer);
    procedure CopyRoomReservation(roomReservationId: integer);
    function ReservationIdInClipboard(var hotelId: String; var resId: integer): boolean;
    function isCurrentPeriodCellWithReservation: boolean;
    procedure performClearHotel(performLogout: boolean; hideWorkArea: boolean = true);
    procedure PostLoginProcess(prepareLanguages: boolean);
    procedure GetMnuFilterLocationsFromStore;
    procedure SetAllMnuFilterLocationsUnchecked;
    procedure EnterDashboardView;
    function ReservationStatusFilter: boolean;
    function ReservationStatusFiltered(status: TReservationStatus): boolean;
    procedure _CancelAReservation;
    procedure CancelAReservation;
    procedure PerformFilterRefresh;
    procedure checkFilterStatuses;
    procedure SetRBEMode(const Value: boolean);
    function CheckInARoom(name: String; iRoomReservation: integer): boolean;
    procedure CheckOutARoom(Room: String; iRoomReservation, iReservation: integer);
    procedure SetDateWithoutEvents(aDate: TdateTime);
    procedure ActivateHint(HintPoint: TPoint; comp: TWinControl);
    procedure EnterRateQueryView(aDate: integer);
    procedure SetOffLineMode(const Value: boolean);
    function CountRoomsOfSpecificType(RoomType: String): integer;
    procedure MyRoundedRect(Canvas: TCanvas; X1, Y1, X2, Y2: integer; DoRoundCorners: boolean = true);
    procedure PlaceRoomerOnCurrnetMonitor;
    function GetActivePeriodGrid: TAdvStringGrid;
    procedure DebugLog(Msg: String);
    procedure HandleSkinManagerChange;
    procedure RefreshStats(force: boolean = false);
    function LongestColText(Grid: TAdvStringGrid; col: integer; startAtRow: integer = 1): integer;
    procedure GetPriceInfo(rri: RecRRInfo; var CurrencySign: String; var PricePerDay, DiscountPerDay, PriceTotal, DiscountTotal: Double);
    function GetCaptText(Canvas: TCanvas; OriginalText: String; MaxWidth: integer): String;
    procedure PlacePeriodViewTypePanel;
    procedure ApplicationCancelHint;
    procedure OnLogInOutHandlerClick(rri: RecRRInfo; ButtonClicked: THintButtonClicked);
    procedure OnViewReservationHandlerClick(rri: RecRRInfo);
    function OneDay_GetResInfo(ACol, ARow, iReservation, iRoomReservation: integer): RecRRInfo;
    procedure CorrectBottomPeriodInterface;
    // function GetSelectedRoomInformation(var iReservation, iRoomReservation: Integer; var Arrival, Departure: TDate): Boolean;
    function GetSelectedRoomInformation: boolean;
    procedure PrintRegistrationFormsForSpecifiedRoomReservations(rSet: TRoomerDataSet);
    procedure SetShapeColor(Shape: TShape; ResStatus: String);
    procedure SetExplanationColors;
    procedure ApplicationCancelGuestHint;
    procedure DrawPeriodColumn1(Grid: TAdvStringGrid; ACol, ARow: integer; State: TGridDrawState);
    procedure ShowHintWindow;
    procedure ShowOneDayHint(ACol, ARow: integer);
    function getRoomReservationsListSubQuery(aType: integer): string;
    procedure ActivateMessagesIfApplicable;
    procedure ConfirmABooking;
    procedure NillifyEventHandlers(grid: TAdvStringGrid);
{$IFDEF USE_JCL}
    procedure LogException(ExceptObj: TObject; ExceptAddr: Pointer; IsOS: boolean);
{$ENDIF}
  public
    { Public declarations }
    StaffComm : TStaffCommunication;
    BusyReloading: boolean;
    HintWindowShowing: boolean;

    ViewMode: TViewMode;
    resDateFrom: TdateTime;
    resDateTo: TdateTime;
    resNights: integer;
    zStartOneDay: boolean;

    zHintPoint: TPoint;
    zHintComp: TWinControl;
    zHintObj: TCustomHint;

    procedure WndProc(var message: TMessage); override;
    procedure DownloadProgress(Sender: TObject; Read, Total: integer);
    procedure IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure BlinkRoom;
    procedure TranslateOpenForms;
    procedure GoToDateAndRoom(aDate: TdateTime; RoomReservation: integer);
    function IsRoomReserved(RoomNumber: string; iRes, iRoom: integer): boolean;
    procedure MakeNewReservation(dtDateFrom, dtDateTo: TdateTime);
    procedure RefreshGrid(Days: integer = 0);
    function _Logout(AlreadyInactive: boolean = false; AutoLogin: String = ''): boolean;
    function IsInRoomTypes(RoomType, RTAvailable: string): boolean;
    procedure SetExtraSkinColors;
    procedure RemoveLanguagesFilesAndRefresh;
    procedure ShowBookingConfirmationTemplates;
    procedure ShowCancelConfirmationTemplates;

    property RBEMode: boolean read FRBEMode write SetRBEMode;
    function FilteredFloors: TSet_Of_Integer;
    function FilteredLocations: TSet_Of_Integer;

    property OffLineMode: boolean read FOffLineMode write SetOffLineMode;
  end;

const
  DEFAULT_UNPARSABLE_INT_VALUE: integer = -99999;
  bAppClosing: boolean = false;
  bUsingMessagesSet: boolean = false;
  GoingStr = '» ';
  ROOMER_COPY_RESERVATION = 'ROOMER:COPY:RESERVATION:';
  ROOMER_COPY_ROOMRESERVATION = 'ROOMER:COPY:ROOMRESERVATION:';
  ROOMER_COPY_RESERVATION_ID = ROOMER_COPY_RESERVATION + 'HOTEL=%s;ID=%d';
  ROOMER_COPY_ROOMRESERVATION_ID = ROOMER_COPY_ROOMRESERVATION + 'HOTEL=%s;ID=%d';

var
  frmMain: TfrmMain;
  ReservationsModel: TReservationsModel;
  oFreeRooms: TFreeRooms;

  curNoDrop: HCursor;
  curNoDropNew: HCursor;
  zDebug1: string;

const
  // WM_StartUpLists = WM_User + 381;
  WM_CHECK_INVOICES = WM_User + 386;
  WM_REFRESH_DATE = WM_User + 41;
  WM_REFRESH_PERIOD_VIEW_BOTTOM = WM_User + 392;
  WM_REFRESH_PERIOD_VIEW_BOTTOM_REFRESH = WM_User + 393;
  WM_REFRESH_SKIN_MANAGER = WM_User + 391;
  WM_REFRESH_STAFF_COMM_NOTIFIER = WM_User + 394;
  PERIOD_GRID_RECTANGLES_WIDTH = 10;

  HINT_WAIT_MS = 1500;

implementation

uses
  dbTables
{$IFDEF USE_JCL}
    , JclDebug, JclHookExcept, TypInfo
{$ENDIF}
    , uD, uRubbishCollectors, uProvideARoom2,
    uInvoice,
    uInvoice2015,
    uTaxes,
    clipbrd,
    sndkey32, uReservationProfile, uGuestProfile2, uSplashRoomer, uAboutRoomer,
  uManageFilesOnServer, uControlData, uInvoiceList, uGuestCheckInForm
  // , uMakeReservation
    , uFinishedInvoices2
  // , uRoomStatus
    , uRoomCleanMaintenanceStatus
  // , uGuestsSearch
    , uDayFinical
  // , uResGuestList
    , uInvoiceList2, uDayNotes, uNationalReport3, uLodgingTaxReport2, uBlinker, ufrmSelLang
  // , ufrmCustInvoicesMD
    , uRptbViewer
  // , uRptCustomer
    , uColorSelector, uCountryGroups, uCountries, uCurrencies, uConverts, uConvertGroups, uPayGroups, uPayTypes, uVatCodes, uChannelPlanCodes, uPriceCodes
  // , uStatisticsForcast
    , uResGuestList, uRebuildReservationStats, uMakereseRvationQuick, objHomeCustomer
  // , uTest
    , uSqlDefinitions, uRoomRates, uRates, uGotoRoomAndDate, uStringUtils, uRoomTypes2, uRoomTypesGroups2, uSeasons2, uItemTypes2, uItems2, uLocations2,
  uRooms3, uCustomerTypes2, uCustomers2, uStaffTypes2, uStaffMembers2, uChannels, uRegistryServices, uChannelManager, uCommunicationTest, uMessageList,
  uHouseKeeping
  // , uRptResDates
    , uRptResStats, uRptResStatsRooms, uGuestSearch, uDateUtils, urptReservations, urptReservationsCust

  // , urptChannceldReservations
    , uTestData, urptTotallist, uFrmChannelTogglingRules, uPersonviptypes, uFrmDaysStatistics, uFrmRateQuery, uPersonContactType,
  uRptTurnoverAndPayments, uRptTurnoverAndPayments2,
  ufDownPayments
  // , uFrmDevAndTestBed
    , uFrmResources, uFileDependencyManager, uMaidActions, uTaxCalc, uRptCustInvoices, uRptResInvoices, uFrmRBEContainer, uRptManagment,
  uChart, uRoomerExceptions, uRoomerMessageDialog, uRptBreakfastGuests, uLostAndFound, uRunWithElevatedOption, urptNotes, uRptGuests, umakeKreditInvoice,
  uBookKeepingCodes, uRptBookkeeping, uReservationEmailingDialog, uFrmReservationCancellationDialog,
  uRptCashier, uPhoneRates, uGroupGuests,
  uActivityLogs,
  uFrmCheckOut,
  uInvoiceCompare,
  GoogleOTP256,
  uInvoiceController
  ;

{$R *.DFM}
{$R Cursors.res}
{ , uMaidActions$R working.res }

var
  cHomeStatus: integer = 0;
  bAutoCorrect: boolean = false;

  ZPeriodRoomOnTheMoveCol, ZPeriodRoomOnTheMoveRow, ZPeriodRoomOnTheMoveRoomReservation: integer;
  ZPeriodRoomOnTheMoveRoomType, ZPeriodRoomOnTheMoveRoomNumber, ZPeriodRoomOnTheMoveGuestname: String;
  ZPeriodRoomOnTheMoveForceType, ZPeriodRoomOnTheMoveExternal: boolean;

var // Work-variables
  _idxReservation, _idxRoomReservation: integer;
  _iReservation, _iRoomReservation: integer;
  _Arrival, _Departure: Tdate;
  _ResStatus: TReservationStatus;
  _Guest, _Name, _Room: String;
  _NoRoom: boolean;
  _ColorId, _ColorValue: integer;
  _InvoiceIndex : Integer;

const
  bAlreadyIn: boolean = false;
  // bForceClose             : boolean = false;
  zOneDay_bMouseDown: boolean = false;
  zPeriod_bMouseDown: boolean = false;

  grRoom_PrevDays = 0;
  grRoom_Room = 1;
  grRoom_RoomType = 2;
  grRoom_RoomDescription = 3;

  // ******************************************************************************
  // ******************************************************************************
  //
  // +-----------------------------+
  // | DRAG AND DROP IN 5 Day Grid |
  // +-----------------------------+
  //
  //
  // ******************************************************************************
  // ******************************************************************************

var
  zzSourceGridID: integer;
  zzSource: TObject;
  zzSourceCol: integer;
  zzSourceRow: integer;
  zzRoomReservation: integer;
  zzReservation: integer;
  zzArrival: Tdate;
  zzDeparture: Tdate;
  zzRoom: string;
  zzRoomType: string;
  zzIsNoRoom: boolean;
  zzAscIndex: integer;
  zzDescIndex: integer;

procedure NullGlobals;
begin
  zzSourceGridID := -1;
  zzSource := nil;
  zzSourceCol := -1;
  zzSourceRow := -1;
  zzRoomReservation := -1;
  zzReservation := -1;
  zzArrival := 1;
  zzDeparture := 1;
  zzRoom := '';
  zzRoomType := '';
  zzIsNoRoom := false;
  zzAscIndex := -1;
  zzDescIndex := -1;
end;

// CreatProcess
function CreateProcessSimple(sExecutableFilePath: string): string;
var
  xx: integer;
  pi: TProcessInformation;
  si: TStartupInfo;
begin
  FillMemory(@si, sizeof(si), 0);
  si.cb := sizeof(si);

  CreateProcess(nil,

    // path to the executable file:
    PChar(sExecutableFilePath),

    nil, nil, false, NORMAL_PRIORITY_CLASS, nil, nil, si, pi);

  // "after calling code" such as
  // the code to wait until the
  // process is done should go here

  CloseHandle(pi.hProcess);
  CloseHandle(pi.hThread);
end;

function TfrmMain.IsInRoomTypes(RoomType, RTAvailable: string): boolean;
var
  sRule: string;
begin
  sRule := '';
  try
    with glb.RoomTypeRulesSet do
    begin
      first;
      while not eof do
      begin
        if trim(FieldByName('RoomType').asString) = RoomType then
        begin
          sRule := trim(FieldByName('RuleString').asString);
          break;
        end;
        next;
      end;
    end;
  finally
    result := pos(',' + RTAvailable + ',', ',' + sRule + ',') > 0;
  end;
end;

procedure TfrmMain.PostLoginProcess(prepareLanguages: boolean);
begin
  ShowRoomerSplash;
  frmRoomerSplash.PrepareBusyNotificator;
  LoggedIn := true;
  CloseAppSettings;
  OpenAppSettings;
  if g.oRooms <> nil then
    freeandNil(g.oRooms);
  g.oRooms := TRooms.Create(g.qHotelCode);

  // ******
  glb.PerformAuthenticationAssertion(self);

  if (NOT OffLineMode) then
    d.BackupsSubmitChanges;

  if prepareLanguages then
  begin
    if NOT d.roomerMainDataSet.OffLineMode then
    begin
      RoomerLanguage.prepareLanguages(d.roomerMainDataSet);
      RoomerLanguage.SetLanguageId(g.qUserLanguage, g.qUser + '.' + inttostr(g.qUserLanguage) + '.' + dateToSqlString(now));
      TranslateOpenForms;
    end;
  end;
  lblUsername.Caption := g.qUserName;

  FormatSettings.CurrencyString := ''; // '£';
  try
    FormatSettings.CurrencyString := ctrlGetString('CurrencySymbol');
  Except
  end;

  glb.FillLocationsMenu(mnuFilterLocation, LocationMenuSelect);
  GetMnuFilterLocationsFromStore;
  FillRoomTypesGrid;
end;

procedure TfrmMain.GetMnuFilterLocationsFromStore;
var
  i: integer;
begin
  for i := 0 to mnuFilterLocation.Items.Count - 1 do
  begin
    mnuFilterLocation.Items[i].Checked := Str2Bool(ReadStringValueFromAppRegistry(d.roomerMainDataSet.userName,
      'LocationSelected_' + g.qHotelCode + '_' + inttostr(mnuFilterLocation.Items[i].Tag), Bool2Str(mnuFilterLocation.Items[i].Checked)));
  end;
  checkFilterStatuses;
end;

procedure TfrmMain.SetAllMnuFilterLocationsUnchecked;
var
  i: integer;
begin
  for i := 0 to mnuFilterLocation.Items.Count - 1 do
  begin
    WriteStringValueToAppRegistry(d.roomerMainDataSet.userName, 'LocationSelected_' + g.qHotelCode + '_' + inttostr(mnuFilterLocation.Items[i].Tag),
      Bool2Str(false));
  end;
  checkFilterStatuses;
end;

procedure TfrmMain.performClearHotel(performLogout: boolean; hideWorkArea: boolean = true);
begin
  timMessages.Enabled := false;
  if NOT performLogout then
  begin
    lblAuthStatus.Caption := GetTranslatedText('shTx_Main_ForcedLogout') + ''#13''#10'' + GetTranslatedText('shTx_Main_LogginAgain');
    AddRoomerActivityLog(d.roomerMainDataSet.username,
                         uActivityLogs.LOGOUT,
                         'Success',
                         'User ' + d.roomerMainDataSet.username + ' Successfully with FORCE logged out.');
  end;
  LoggedIn := false;
  try
    EnterDayView;
  except
  end;
  if performLogout then
  begin
    d.roomerMainDataSet.Logout;
    AddRoomerActivityLog(d.roomerMainDataSet.username,
                         uActivityLogs.LOGOUT,
                         'Success',
                         'User ' + d.roomerMainDataSet.username + ' Successfully logged out.');
  end;
  if hideWorkArea then
  begin
    panelHide.Left := 0;
    panelHide.Top := 0;
    panelHide.Width := ClientWidth;
    panelHide.Height := ClientHeight;
    panelHide.Show;
    panelHide.BringToFront;
  end;
end;

procedure TfrmMain.ReEnableFiltersInPeriodGrid;
begin
  ShowAllPeriodRows;
  ApplyFiltersToPeriodView(grPeriodRooms);
  ApplyFiltersToPeriodView(grPeriodRooms_NO);
end;

procedure TfrmMain.R1Click(Sender: TObject);
var
  rSet: TRoomerDataSet;
begin
  if GetSelectedRoomInformation then
  begin
    if SendNewReservationConfirmation(_iReservation) then
      MessageDlg(GetTranslatedText('shTxConfirmationEmailHasBeenSent'), mtConfirmation, [mbOk], 0);
  end;
end;

procedure TfrmMain.RedisplayGuestWindows;
begin
  case tabsView.TabIndex of
    0:
      OneDay_DisplayGrid;
    1:
      begin
        ViewMode := vmNone;
        SetViews(tabsView.TabIndex + 1);
      end;
  end;
end;

procedure TfrmMain.EnterPeriodDragFilter;
var
  rri: RecRRInfo;
begin
  // splitPeriod.CloseSplitter; splitPeriod.Top := panPeriodRooms.Height;
  rri := Period_GetResInfo(grPeriodRooms.col, grPeriodRooms.row, grPeriodRooms.Tag);
  if rri.Reservation > -1 then
    FillRoomOnTheMove(false, grPeriodRooms.row, grPeriodRooms.col, rri);
end;

procedure TfrmMain.EnterPeriodDragFilterExternal;
var
  rri: RecRRInfo;
begin
  // splitPeriod.OpenSplitter; splitPeriod.Top := panPeriodRooms.Height;
  rri := Period_GetResInfo(grPeriodRooms_NO.col, grPeriodRooms_NO.row, grPeriodRooms_NO.Tag);
  if rri.Reservation > -1 then
    FillRoomOnTheMove(true, grPeriodRooms_NO.row, grPeriodRooms_NO.col, rri);
end;

procedure TfrmMain.FillRoomOnTheMove(RoomExternal: boolean; row, col: integer; rri: RecRRInfo);
var
  iTemp: integer;
begin
  ZPeriodRoomOnTheMoveCol := col;
  ZPeriodRoomOnTheMoveRow := row;
  ZPeriodRoomOnTheMoveExternal := RoomExternal;
  ZPeriodRoomOnTheMoveRoomReservation := rri.RoomReservation;
  ZPeriodRoomOnTheMoveRoomNumber := rri.Room;
  ZPeriodRoomOnTheMoveRoomType := rri.RoomType;
  ZPeriodRoomOnTheMoveGuestname := rri.GuestName;
  iTemp := row;
  if RoomExternal then
    iTemp := -1;

  HideRowsWithNotFittingRooms(iTemp, rri.Arrival, rri.Departure);
  SetFilterColorsOn;
end;

procedure TfrmMain.AssignSkinColorsToComponents;
var
  APainter: TcxCustomLookAndFeelPainter;
  ASkin: TdxSkin;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  DebugLog('Starting AssignSkinColorsToComponents');
  Chart1.Color := sSkinManager1.GetGlobalColor;
  Chart1.LeftAxis.LabelsFont.Color := sSkinManager1.GetGlobalFontColor;
  Chart1.BottomAxis.LabelsFont.Color := sSkinManager1.GetGlobalFontColor;
  Chart1.Title.Font.Color := sSkinManager1.GetHighLightFontColor;
  pnlNoRoomDrop.Color := sSkinManager1.GetGlobalColor;
  lblNoRoom.Font.Color := sSkinManager1.GetGlobalFontColor;
  grPeriodRooms.FixedFont.Color := sSkinManager1.GetGlobalFontColor;
  grPeriodRooms.HighlightTextColor := sSkinManager1.GetGlobalFontColor;
  grPeriodRooms.FixedColor := sSkinManager1.GetGlobalColor;

  // --
  pnlDayStatus.Color := sSkinManager1.gd[btnGoOnline.SkinData.SkinIndex].HotGlowColor; // HotColor; // GetPixelColourAsColor(Point(Width div 2 + Left, Top + 3));
  cbxStatDay.Color := pnlDayStatus.Color;
  panMainTop.Color := sSkinManager1.GetGlobalColor; // pnlDayStatus.Color;
  cbxStatDay.Font.Color := sSkinManager1.GetGlobalColor; // sSkinManager1.gd[btnGoOnline.SkinData.SkinIndex].HotFontColor[1]; // sSkinManager1.GetGlobalColor;

  // Colors are to be found in cxLookAndFeelPainterscxLookAndFeelPainters
  Color := sSkinManager1.GetGlobalColor;
  // RootLookAndFeel.Painter.DefaultFilterBoxColor; // DefaultContentColor; // DefaultVGridHeaderColor; // ASkin.Get .GetColorByName('GroupColor').Value;

  __VER.Font.Color := cbxStatDay.Font.Color;

  lblOccupancy.Font.Color := cbxStatDay.Font.Color;
  __OCCUPANCY.Font.Color := cbxStatDay.Font.Color;
  lblStatAdr.Font.Color := cbxStatDay.Font.Color;
  __ADR.Font.Color := cbxStatDay.Font.Color;
  lblStatRevPar.Font.Color := cbxStatDay.Font.Color;
  __REVPAR.Font.Color := cbxStatDay.Font.Color;
  lblStatRoomsSold.Font.Color := cbxStatDay.Font.Color;
  __ROOMSSOLD.Font.Color := cbxStatDay.Font.Color;
  DebugLog('Ending AssignSkinColorsToComponents');
  if cbxStatDay.ItemIndex < 0 then
    cbxStatDay.ItemIndex := 0;
  cbxStatDay.Update;
end;

procedure TfrmMain.DebugLog(Msg: String);
begin
{$IFDEF DEBUG}
  try
    if assigned(frmDayNotes) then
      frmDayNotes.xDoLog('DEBUG', Msg);
    Application.ProcessMessages;
  except

  end;
{$ENDIF}
end;

procedure TfrmMain.GetLeavingGuestIndexes(var idxRoom: integer; var idxReservation: integer; ACol, ARow: integer);
begin
  idxReservation := zOneDayResPointers[ARow].ptrRooms[OneDay_GetIsLeftOrRight(ACol), 1];
  // Reservation Index
  idxRoom := zOneDayResPointers[ARow].ptrRooms[OneDay_GetIsLeftOrRight(ACol), 2];
end;

procedure TfrmMain.GetArrivingGuestIndexes(var idxRoom: integer; var idxReservation: integer; ACol, ARow: integer);
begin
  idxReservation := zOneDayResPointers[ARow].ptrRooms[OneDay_GetIsLeftOrRight(ACol), 1];
  // Reservation Index
  idxRoom := zOneDayResPointers[ARow].ptrRooms[OneDay_GetIsLeftOrRight(ACol), 2];
  // Rooms Index
  OneDay_NewGuestCoordinates(ReservationsModel.Reservations[idxReservation].Rooms[idxRoom].RoomNumber, idxReservation, idxRoom);
end;

procedure TfrmMain.F1Click(Sender: TObject);
var
  rSet: TRoomerDataSet;
begin
  if GetSelectedRoomInformation then
  begin
    rSet := d.roomerMainDataSet.ActivateNewDataset
      (d.roomerMainDataSet.SystemFreeQuery(Format(GET_ALL_ROOMRESERVATIONS_ARRIVING_ON_SPECIFIED_DATE_FILTER_RESERVATION_ID,
      [_DB(uDateUtils.dateToSqlString(now)), _iReservation])));
    try
      PrintRegistrationFormsForSpecifiedRoomReservations(rSet);
    finally
      freeandNil(rSet);
    end;
  end;
end;

procedure TfrmMain.F2Click(Sender: TObject);
var
  rSet: TRoomerDataSet;
begin
  rSet := d.roomerMainDataSet.ActivateNewDataset(d.roomerMainDataSet.SystemFreeQuery(Format(GET_ALL_ROOMRESERVATIONS_ARRIVING_ON_SPECIFIED_DATE,
    [_DB(uDateUtils.dateToSqlString(now))])));
  try
    PrintRegistrationFormsForSpecifiedRoomReservations(rSet);
  finally
    freeandNil(rSet);
  end;
end;

procedure TfrmMain.PrintRegistrationFormsForSpecifiedRoomReservations(rSet: TRoomerDataSet);
var
  RoomResArray: IntegerArray;
  iCounter, iNumRecs: integer;
begin
  iNumRecs := 0;
  rSet.first;
  while not rSet.eof do
  begin
    inc(iNumRecs);
    rSet.next;
  end;

  SetLength(RoomResArray, iNumRecs);
  iCounter := LOW(RoomResArray);
  rSet.first;
  while not rSet.eof do
  begin
    RoomResArray[iCounter] := rSet['RoomReservation'];
    inc(iCounter);
    rSet.next;
  end;
  PrintRegistrationForm(RoomResArray);
end;

procedure TfrmMain.FillPeriodGridWithRooms;
var
  status: string;
  i: integer;
  Room: string;
  RoomType: string;

  startRow: integer;
  RowIndex: integer;
begin
  startRow := grPeriodRooms.FixedRows;
  RowIndex := startRow - 1;
  for i := 0 to g.oRooms.RoomCount - 1 do
  begin
    inc(RowIndex);
    status := g.oRooms.RoomItemsList.Items[i].status;
    Room := g.oRooms.RoomItemsList.Items[i].Room;
    RoomType := g.oRooms.RoomItemsList.Items[i].RoomType;
    grPeriodRooms.Objects[grRoom_Room, RowIndex] := TRoomCell.Create(status);
    grPeriodRooms.cells[grRoom_Room, RowIndex] := Room;
    grPeriodRooms.cells[grRoom_RoomType, RowIndex] := RoomType;
    if zShowRoomDescription then
    begin
      grPeriodRooms.cells[grRoom_RoomDescription, RowIndex] := g.oRooms.RoomItemsList.Items[i].RoomDescription;
    end;
  end;
  // grPeriodRooms.AddRow;
end;

procedure TfrmMain.AutoSizePeriodColumns;
var
  i: integer;
  changedHeight: boolean;
begin
  grPeriodRooms.AutoSizeCol(0);
  grPeriodRooms.colWidths[1] := LongestColText(grPeriodRooms, 1, 2) + 20;
  grPeriodRooms.colWidths[2] := (LongestColText(grPeriodRooms, 2, 2) + 20);
  try
    if cbxViewTypes.ItemIndex > 0 then
    begin
      grPeriodRooms.colWidths[2] := 0; // (LongestColText(grPeriodRooms, 2, 2) + 20) * ABS(ORD(cbxViewTypes.ItemIndex = 0));
      grPeriodRooms.colWidths[1] := 170;
    end;
  except
  end;

  grPeriodRooms.colWidths[0] := 0;
  grPeriodRooms.colWidths[3] := 0;
  grPeriodRooms.colWidths[4] := 0;

  pnlViewType.Width := grPeriodRooms.colWidths[1] + grPeriodRooms.colWidths[2] - 2;
  pnlViewType.Top := 1;
  pnlViewType.Left := 1;
  pnlViewType.Height := grPeriodRooms.RowHeights[0] + grPeriodRooms.RowHeights[1] - 2;
  pnlViewType.BringToFront;

  // for i := 5 to grPeriodRooms.fixedCols - 1 do
  // begin
  // try
  // grPeriodRooms.AutoSizeCol(i);
  // except
  // end;
  // end;
  if grPeriodRooms.ColCount > 4 then
  begin
    if assigned(embOccupancyView) then
    begin
      embOccupancyView.grdOccupancy.ColCount := grPeriodRooms.ColCount - 4;
      embOccupancyView.grdOccupancy.colWidths[0] := grPeriodRooms.colWidths[0] + grPeriodRooms.colWidths[1] + grPeriodRooms.colWidths[2] +
        grPeriodRooms.colWidths[3] + grPeriodRooms.colWidths[4];
      for i := 0 to grPeriodRooms.ColCount - 1 do
      begin
        try
          if i < grPeriodRooms_NO.ColCount then
            grPeriodRooms_NO.colWidths[i] := grPeriodRooms.colWidths[i];
          if (i > 4) AND (i - 4 < embOccupancyView.grdOccupancy.ColCount) then
            embOccupancyView.grdOccupancy.colWidths[i - 4] := grPeriodRooms.colWidths[i];
        except
        end;
      end;
    end;
  end;
end;

procedure TfrmMain.DrawRectanglOnCanvas(_Canvas: TCanvas; iColor: integer; chRect: TRect);
var
  brushColor: TColor;
begin
  brushColor := _Canvas.Brush.Color;
  try
    _Canvas.Brush.Color := iColor;
    _Canvas.Brush.Style := bsSolid;
    _Canvas.FillRect(chRect);
    _Canvas.Pen.Style := psDot;
    _Canvas.Pen.Color := _Canvas.Font.Color;
    _Canvas.Rectangle(chRect);
    // _Canvas.Ellipse(chRect.Left, chRect.Top, chRect.Right, chRect.Bottom);
  finally
    _Canvas.Brush.Color := brushColor;
  end;
end;

procedure TfrmMain.ClearRoomTypeCount;
begin
  if assigned(hData.oRoomTypeRoomCount) then
    freeandNil(hData.oRoomTypeRoomCount);
end;

procedure TfrmMain.ClearFreeRooms;
begin
  if assigned(oFreeRooms) then
  begin
    freeandNil(oFreeRooms);
  end;
end;

procedure TfrmMain.ClearGroupList;
begin
  GroupList.Clear;
end;


// ** START OF Private declarations *********************************************

/// *****************************************************************************

procedure TfrmMain.SetWindowTitle;
var
  s: string;
  recVer: TEXEVersionData;
begin
  recVer := _GetEXEVersionData(Paramstr(0));

  if NOT RBEMode then
    s := 'ROOMER PMS'
  else
    s := 'Roomer Booking Engine - ';

  s := s + { 0070 } ' - ' + GetTranslatedText('sh0070') + ':' + recVer.ProductVersion;
  Caption := s;
end;

procedure TfrmMain.sPanel3DblClick(Sender: TObject);
begin
{$IFDEF DEBUG}
  ShowMessage(d.roomerMainDataSet.TestSpecificOpenApiAuthHeaders(
    '2a0434bc',
    'ORBIS',
    'a02da62f9c6f941024e90d5828d9246c096fb5b1286946e1a63b14981d42f55e',
    'https://api.roomercloud.net/roomer/openAPI/REST/bookings/roomassignments?roomNumber=004',
    Now));
  ShowMessage(CalculateOTPOnSpecifiedTime('a02da62f9c6f941024e90d5828d9246c096fb5b1286946e1a63b14981d42f55e',
              StrToDateTime('05-01-2016 12:00:00')));
{$ENDIF}
end;

procedure TfrmMain.splitPeriodMoved(Sender: TObject);
begin
  embOccupancyView.OriginalParentHeight := pnlPeriodNoRooms.Height;
end;

procedure TfrmMain.sSkinManager1SkinLoading(Sender: TObject);
var
  skinName: String;
begin
  DebugLog('Starting sSkinManager1AfterChange');
  skinName := LowerCase(trim(sSkinManager1.skinName));
  if (pos(skinName, 'office2007 black,tv-b') > 0) then
    dxRibbon1.ColorSchemeName := 'DarkSide'
  else if (pos(skinName, 'fm,') > 0) then
    dxRibbon1.ColorSchemeName := 'DevExpressDarkStyle'

  else if (pos(skinName, 'macos2') > 0) then
    dxRibbon1.ColorSchemeName := 'McSkin'
  else
    dxRibbon1.ColorSchemeName := 'Office2013White'; // 'DarkRoom';

  AssignSkinColorsToComponents;

  WriteStringValueToAnyRegistry('Software\Roomer\FormStatus\StoreMainV2\sSkinManager1', 'SkinName', sSkinManager1.skinName);

  DebugLog('Ending sSkinManager1AfterChange');
  // TsSkinManager.GetGlobalColor
  // TsSkinManager.GetGlobalFontColor
  // TsSkinManager.GetActiveEditColor
  // TsSkinManager.GetActiveEditFontColor
  // TsSkinManager.GetHighLightColor
  // TsSkinManager.GetHighLightFontColor
end;

procedure TfrmMain.sSpeedButton1Click(Sender: TObject);
begin
  RefreshGrid;
end;

procedure TfrmMain.btnGroupsFilterClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to G2.Items.Count - 1 do
    G2.Items[i].Checked := false;
  checkFilterStatuses;
  PerformFilterRefresh;
end;

procedure TfrmMain.BusyOn;
begin
  Screen.Cursor := crHourglass;
end;

procedure TfrmMain.btnRefreshOneDayClick(Sender: TObject);
begin
  ViewMode := vmNone;
  SetViews(tabsView.TabIndex + 1);
end;

procedure TfrmMain.BusyOff;
begin
  Screen.Cursor := crDefault;
  // Application.processmessages;
end;

function TfrmMain.IsValidCellSelected: boolean;
begin
  result := true;
  if ViewMode <> vmOneDay then
    exit;
  // result := //zOneDay_ResIndex <> - 1;
end;

procedure TfrmMain.lblPropertyStatusDblClick(Sender: TObject);
begin
{$IFDEF DEBUG}
  RoomerLanguage.PerformDBUpdatesWhenUnknownEntitiesFound := true;
  try
    GenerateTranslateTextTableForConstants;
    GenerateTranslateTextTableForAllForms;
    TranslateOpenForms;
    try
      frmHomedate.Show;
      RoomerLanguage.TranslateThisForm(frmRptManagment);
      frmHomedate.Hide;
    except
    end;

    // try
    // frmHomedate.Show;
    // RoomerLanguage.TranslateThisForm(frmHomedate);
    // frmHomedate.Hide;
    // except
    // end;
    // try
    // frmDayNotes.Show;
    // RoomerLanguage.TranslateThisForm(frmDayNotes);
    // frmDayNotes.Hide;
    // except
    // end;
    // try
    // frmSelHotel.Show;
    // RoomerLanguage.TranslateThisForm(frmSelHotel);
    // frmSelHotel.Hide;
    // except
    // end;
    // try
    // frmGoToRoomandDate.Show;
    // RoomerLanguage.TranslateThisForm(frmGoToRoomandDate);
    // frmGoToRoomandDate.Hide;
    // except
    // end;
    // try
    // frmDaysStatistics.Show;
    // RoomerLanguage.TranslateThisForm(frmDaysStatistics);
    // frmDaysStatistics.Hide;
    // except
    // end;
  finally
    RoomerLanguage.PerformDBUpdatesWhenUnknownEntitiesFound := false;
  end;
{$ENDIF}
end;

procedure TfrmMain.lblUsernameDblClick(Sender: TObject);
var Invoice : TInvoice;
begin
  { IFDEF DEBUG }
  // PushActivityLogs;
  if GetSelectedRoomInformation then
  begin
    if IsControlKeyPressed then
      _iRoomReservation := 0;

   Invoice := TInvoice.Create(_iReservation, _iRoomReservation, 0, -1, 0);
   DebugMessage(FloatToStr(Invoice.Total) + #10 + FloatToStr(Invoice.TotalPayments) + #10 + FloatToStr(Invoice.Balance));
   Invoice.Free;
  end;
  { ENDIF }
end;


procedure TfrmMain.__lblSearchDblClick(Sender: TObject);
begin
  if btnResStat.Visible = ivNever then
    btnResStat.Visible := ivAlways
  else
    btnResStat.Visible := ivNever;
end;

// *****************************************************************

procedure TfrmMain.UpdatePanelText;
begin
  // lblMainHeader.caption := ' ' + g.qHotelName + ' - ' + DateToStr(dtDate.Date) + ' ' + FormatDateTime('dddd', dtDate.Date);
  lblMainHeader.Caption := // DateToStr(dtDate.Date) + ' ' +
    FormatDateTime('dddd', dtDate.Date);
end;

procedure TfrmMain.WndProc(var message: TMessage);
var
  s: string;
begin
  if Message.Msg = WM_REFRESH_STAFF_COMM_NOTIFIER then
    StaffComm.ViewDate := dtDate.Date
  else
  if Message.Msg = WM_REFRESH_PERIOD_VIEW_BOTTOM then
    CorrectBottomPeriodInterface
  else if Message.Msg = WM_REFRESH_PERIOD_VIEW_BOTTOM_REFRESH then
  begin
    embOccupancyView.ShowOccupancy(zDateFrom, zDateFrom + zNights);
    PostMessage(handle, WM_REFRESH_PERIOD_VIEW_BOTTOM, 0, 0);
  end
  else if Message.Msg = WM_REFRESH_DATE then
  begin
    RefreshGrid(dtDate.Tag);
    dtDate.Tag := 0;
  end
  else if Message.Msg = WM_SET_DATE_FROM_MAIN then
  begin
    FrmRateQuery.ShowRatesForDate(message.LParam);
  end
  else if Message.Msg = WM_REFRESH_SKIN_MANAGER then
  begin
    HandleSkinManagerChange;
  end;
  inherited WndProc(message);
end;

procedure TfrmMain.DisplayDate(aDate: Tdate);
begin

  if trunc(aDate) <> trunc(now) then
  begin
    lblMainHeader.Color := clActiveCaption;
    lblMainHeader.Font.Color := clCaptionText;
  end
  else
  begin
    lblMainHeader.Color := clMaroon;
    lblMainHeader.Font.Color := clYellow;
  end;

  UpdatePanelText;
end;

// ******************************************************************************

procedure TfrmMain.Image2MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
{$IFDEF DEBUG}
  // if Button = mbRight then
  // OpenTestBed;
{$ENDIF}
end;

procedure TfrmMain.InitializeViews;
begin
  zOneDay_bDetailsOn := false;
end;

function TfrmMain.LongestColText(Grid: TAdvStringGrid; col: integer; startAtRow: integer = 1): integer;
var
  i, len: integer;
begin
  result := 0;
  for i := startAtRow to Grid.RowCount - 1 do
  begin
    len := Grid.Canvas.TextWidth(Grid.cells[col, i]);
    if len > result then
      result := len;
  end;
end;

const
  ALREADY_READ_DAY_VIEW_SIZES: boolean = false;

function TfrmMain.LoadOneDayViewGridStatus: boolean;
var
  sIniName: string;
  l, iLen: integer;
begin
  result := false;
  if ALREADY_READ_DAY_VIEW_SIZES then
    exit;

  iLen := LongestColText(grOneDayRooms, 0);
  l := LongestColText(grOneDayRooms, 7);
  if l > iLen then
    iLen := l;
  grOneDayRooms.colWidths[0] := iLen + 20;
  grOneDayRooms.colWidths[7] := grOneDayRooms.colWidths[0];

  iLen := LongestColText(grOneDayRooms, 1);
  l := LongestColText(grOneDayRooms, 8);
  if l > iLen then
    iLen := l;
  grOneDayRooms.colWidths[1] := iLen + 20;
  grOneDayRooms.colWidths[8] := grOneDayRooms.colWidths[1];

  with TRoomerRegistryIniFile.Create(GetRoomerIniFilename) do
  begin
    try
      for l := 0 to grOneDayRooms.ColCount - 1 do
        if NOT(l IN [0, 1, 7, 8]) then
        begin
          grOneDayRooms.colWidths[l] := ReadInteger(name, grOneDayRooms.name + '_col_' + inttostr(l), grOneDayRooms.colWidths[l]);
        end;
    finally
      Free;
    end;
  end;
  ALREADY_READ_DAY_VIEW_SIZES := true;
  result := true;
end;

procedure TfrmMain.SaveOneDayViewGridStatus;
var
  l: integer;
begin
  with TRoomerRegistryIniFile.Create(GetRoomerIniFilename) do
    try
      for l := 0 to grOneDayRooms.ColCount - 1 do
      begin
        WriteInteger(name, grOneDayRooms.name + '_col_' + inttostr(l), grOneDayRooms.colWidths[l]);
      end;
    finally
      Free;
    end;
end;

procedure TfrmMain.sButton2Click(Sender: TObject);
var
  RoomerMessage: TRoomerMessage;
begin
  RoomerMessage := RoomerMessages.MessageById(mmoMessage.Tag);
    if RoomerMessage <> nil then
      RoomerMessage.MarkedAsRead := true;
    timMessagesTimer(timMessages);
end;

procedure TfrmMain.btnBackForwardClick(Sender: TObject);
var
  iNum: integer;
  iMPly: integer;
  myYear, myMonth, myDay: Word;
begin
  // --
  if OffLineMode then
    exit;

  iMPly := 0;
  if (Sender = btnBack) then
    iMPly := -1
  else if (Sender = btnForward) then
    iMPly := 1;

  iNum := 1;
  if IsControlKeyPressed then
  begin
    iNum := 7;
    if IsAltKeyPressed then
    begin
      if Sender = btnForward then
      begin
        DecodeDate(dtDate.Date, myYear, myMonth, myDay);
        iNum := (MonthDays[isLeapYear(myYear)][myMonth]);
      end
      else
      begin
        DecodeDate(dtDate.Date, myYear, myMonth, myDay);
        if myMonth = 1 then
        begin
          myMonth := 12;
          dec(myYear)
        end
        else
          dec(myMonth);
        iNum := (MonthDays[isLeapYear(myYear)][myMonth]);
      end;
    end;
  end;
  if iNum > 7 then
    iNum := 0;
  dtDate.Tag := iNum * iMPly;
  dtDate.Date := trunc(dtDate.Date + (iNum * iMPly));
  // RefreshGrid(iNum * iMPly);
end;

procedure TfrmMain.btnBreakfastGuestsClick(Sender: TObject);
begin
  // **
  rptBreakfastGuests;
end;

procedure TfrmMain.OneDayUpdatePage(aDate: TdateTime);
begin
  BusyOn;
  grOneDayRooms.BeginUpdate;
  try
    zOneDay_dtDate := aDate;
    EmptyStringGrid(grOneDayRooms);
    OneDay_Refresh;
  finally
    BusyOff;
    grOneDayRooms.endUpdate;
  end;
end;

// ------------------------------------------------------------------------------
// 19.02.2008 - er þetta nauðsynlegt - aðeins notað á einun stað --
// commentaði það út þar þanni að þetta er ekki notað
// ------------------------------------------------------------------------------
procedure TfrmMain.Compute_TreeMoves(X, Y: integer);
var
  NbPixels: integer;
  RMin, RMax: integer;
  HOffset, VOffset: integer;
begin
  GetScrollRange(grOneDayRooms.handle, SB_HORZ, RMin, RMax);
  if RMin = RMax then
    HOffset := 0
  else
    HOffset := 16;

  GetScrollRange(grOneDayRooms.handle, SB_VERT, RMin, RMax);
  if RMin = RMax then
    VOffset := 0
  else
    VOffset := 16;
  { -------------------------------------------------------------------- }
  { Near an edge means at a maximum of (half) a line, i-e half the }
  { pixles of the current font. }
  { -------------------------------------------------------------------- }

  NbPixels := grOneDayRooms.DefaultRowHeight; // Abs((Font.Height));

  if (Y < NbPixels * 2) then
    grOneDayRooms.Perform(WM_VSCROLL, SB_LINEUP, 0)
    // ScrollBy( 0, -NbPixels ) //
  else if (Y > grOneDayRooms.Height - VOffset - NbPixels) then
    grOneDayRooms.Perform(WM_VSCROLL, SB_LINEDOWN, 0);
  // agrRooms.ScrollBy( 0, NbPixels ); //

  if (X < NbPixels) then
    grOneDayRooms.Perform(WM_HSCROLL, SB_LINELEFT, 0)
    // agrRooms.ScrollBy( -NbPixels, 0 ) //
  else if (X > grOneDayRooms.Width - HOffset - NbPixels) then
    grOneDayRooms.Perform(WM_HSCROLL, SB_LINERIGHT, 0);
  // agrRooms.ScrollBy( NbPixels, 0 ); //
end;

procedure TfrmMain.tabsViewChange(Sender: TObject);
begin
  SetViews(tabsView.TabIndex + 1);
  PostMessage(handle, WM_REFRESH_PERIOD_VIEW_BOTTOM, 0, 0);
end;

procedure TfrmMain.tabsViewChanging(Sender: TObject; var AllowChange: boolean);
begin
  AllowChange := NOT FOffLineMode;
  if AllowChange then
    ShowAllRoomsRows;
end;

const
  iLastHintRow: integer = -1;
  iLastHintCol: integer = -1;

  iLastShownHintRow: integer = -1;
  iLastShownHintCol: integer = -1;
  iLastShownRoomReservation: integer = -1;

  iLastPeriodHintRow: integer = -1;
  iLastPeriodHintCol: integer = -1;

procedure TfrmMain.tabsViewMouseEnter(Sender: TObject);
begin
  ApplicationCancelHint;
  iLastHintRow := 0;
  iLastHintCol := 0;
  iLastPeriodHintRow := 0;
  iLastPeriodHintCol := 0;
end;

// ------------------------------------------------------------------------------
// 19.02.2008 - row height not longer saved to iniFile - using autosize insted
// 11.03.2008 - Bætt við að vista font í 5dayGrind
//
// ------------------------------------------------------------------------------

procedure TfrmMain.S3Click(Sender: TObject);
var
  RoomResArray: IntegerArray;
begin
  if GetSelectedRoomInformation then
  begin
    SetLength(RoomResArray, 1);
    RoomResArray[LOW(RoomResArray)] := _iRoomReservation;

    PrintRegistrationForm(RoomResArray);
  end;
end;

procedure TfrmMain.SaveGridFont(OneDayFont, PeriodFont: TFont);
begin
  grPeriodRooms.Font.name := PeriodFont.name;
  grPeriodRooms.Font.size := PeriodFont.size;

  grPeriodRooms.FixedFont := grPeriodRooms.Font;
  grPeriodRooms.Canvas.Font := grPeriodRooms.Font;

  grPeriodRooms_NO.Font := grPeriodRooms.Font;
  grPeriodRooms_NO.FixedFont := grPeriodRooms.Font;

  grPeriodRooms_NO.Canvas.Font := grPeriodRooms.Font;

  grOneDayRooms.Font.name := OneDayFont.name;
  grOneDayRooms.Font.size := OneDayFont.size;

  // grPeriodRooms.font.Color := clBlack;
  // grPeriodRooms.fixedfont.Color := clBlack;

  with TRoomerRegistryIniFile.Create(AppInifile) do
    try
      writeString('GridFonts', grOneDayRooms.name, _FontToStr(grOneDayRooms.Font));
      writeString('Grid5dayFonts', grPeriodRooms.name, _FontToStr(grPeriodRooms.Font));
    finally
      Free;
    end;
end;

// ------------------------------------------------------------------------------
// 19.02.2008 - row height not longer restored to iniFile
// - using autosize insted
//
// 11.03.2008 - Bætt við að sækja font fyrir 5dayGrind
//
// ?! - Kanski ætti að vista þetta fyrir hvern notanda
// ------------------------------------------------------------------------------
procedure TfrmMain.RestoreCurrentFont;
var
  po: TPoint;
  OneDayFont: string;
  tmpfont: TFont;

begin
  with TRoomerRegistryIniFile.Create(AppInifile) do
    try
      tmpfont := TFont.Create;

      OneDayFont := readString('GridFonts', grOneDayRooms.name, '');

      tmpfont := _StrToFont(OneDayFont);
      try
        grOneDayRooms.Font.name := tmpfont.name;
        grOneDayRooms.Font.size := tmpfont.size;
      finally
        tmpfont.Free;
      end;

      OneDayFont := readString('Grid5dayFonts', grPeriodRooms.name, '');

      tmpfont := _StrToFont(OneDayFont);
      try
        grPeriodRooms.Font.name := tmpfont.name;
        grPeriodRooms.Font.size := tmpfont.size;

        grPeriodRooms.FixedFont := grPeriodRooms.Font;
        grPeriodRooms.Canvas.Font := grPeriodRooms.Font;

        grPeriodRooms_NO.Font := grPeriodRooms.Font;
        grPeriodRooms_NO.FixedFont := grPeriodRooms.Font;

        grPeriodRooms_NO.Canvas.Font := grPeriodRooms.Font;

        // grPeriodRooms.font.Color      := clBlack;
        // grPeriodRooms.fixedfont.Color := clBlack;

      finally
        tmpfont.Free;
      end;

    finally
      Free;
    end;

  // with TRoomerRegistryIniFile.Create(AppInifile) do
  // try
  // po.X := 2;
  // po.Y := 0;
  // grPeriodRooms.XYOffset := po;
  //
  // po.X := 2;
  // po.Y := 0;
  // grOneDayRooms.XYOffset := po;
  //
  // po.X := 2;
  // po.Y := 0;
  // grPeriodRooms_NO.XYOffset := po;
  //
  // grPeriodRooms.font := _StrToFont(readString('Grid5DayFonts', grPeriodRooms.name, _FontToStr(grPeriodRooms.font)));
  // grPeriodRooms.FixedFont := grPeriodRooms.font;
  // grPeriodRooms.Canvas.font := grPeriodRooms.font;
  //
  // grPeriodRooms_NO.font := grPeriodRooms.font;
  // grPeriodRooms_NO.FixedFont := grPeriodRooms.font;
  // grPeriodRooms_NO.Canvas.font := grPeriodRooms.font;
  //
  // grOneDayRooms.font := _StrToFont(readString('GridFonts', grOneDayRooms.name, _FontToStr(grOneDayRooms.font)));
  // grOneDayRooms.Canvas.font := grOneDayRooms.font;
  // // 080311 agrRooms.AutoSizeRows(true,-1);
  // finally
  // free;
  // end;
end;

{$IFDEF USE_JCL}

procedure TfrmMain.LogException(ExceptObj: TObject; ExceptAddr: Pointer; IsOS: boolean);
var
  TmpS: string;
  ModInfo: TJclLocationInfo;
  i: integer;
  ExceptionHandled: boolean;
  HandlerLocation: Pointer;
  ExceptFrame: TJclExceptFrame;

begin
  if ExceptionsLoggingActive then
  begin
    TmpS := 'Exception ' + ExceptObj.ClassName;
    if ExceptObj is Exception then
      TmpS := TmpS + ': ' + Exception(ExceptObj).message;
    if IsOS then
      TmpS := TmpS + ' (OS Exception)';
    _textAppend(ExceptionLogPath, TmpS, true);
    ModInfo := GetLocationInfo(ExceptAddr);
    _textAppend(ExceptionLogPath, Format('  Exception occured at $%p (Module "%s", Procedure "%s", Unit "%s", Line %d)',
      [ModInfo.Address, ModInfo.UnitName, ModInfo.ProcedureName, ModInfo.SourceName, ModInfo.LineNumber]), true);
    if stExceptFrame in JclStackTrackingOptions then
    begin
      _textAppend(ExceptionLogPath, '  Except frame-dump:', true);
      i := 0;
      ExceptionHandled := false;
      while ( { chkShowAllFrames.Checked or } not ExceptionHandled) and (i < JclLastExceptFrameList.Count) do
      begin
        ExceptFrame := JclLastExceptFrameList.Items[i];
        ExceptionHandled := ExceptFrame.HandlerInfo(ExceptObj, HandlerLocation);
        if (ExceptFrame.FrameKind = efkFinally) or (ExceptFrame.FrameKind = efkUnknown) or not ExceptionHandled then
          HandlerLocation := ExceptFrame.CodeLocation;
        ModInfo := GetLocationInfo(HandlerLocation);
        TmpS := Format('    Frame at $%p (type: %s', [ExceptFrame.FrameLocation, GetEnumName(TypeInfo(TExceptFrameKind), Ord(ExceptFrame.FrameKind))]);
        if ExceptionHandled then
          TmpS := TmpS + ', handles exception)'
        else
          TmpS := TmpS + ')';
        _textAppend(ExceptionLogPath, TmpS, true);
        if ExceptionHandled then
          _textAppend(ExceptionLogPath, Format('      Handler at $%p', [HandlerLocation]), true)
        else
          _textAppend(ExceptionLogPath, Format('      Code at $%p', [HandlerLocation]), true);
        _textAppend(ExceptionLogPath, Format('      Module "%s", Procedure "%s", Unit "%s", Line %d', [ModInfo.UnitName, ModInfo.ProcedureName,
          ModInfo.SourceName, ModInfo.LineNumber]), true);
        inc(i);
      end;
    end;
    _textAppend(ExceptionLogPath, '', true);
  end;
end;
{$ENDIF}

procedure TfrmMain.ExceptionHandler(Sender: TObject; E: Exception);
begin
  // --
  if (E is EDivByZero) or (E is ERangeError) or (E is EStringListError) or (E is ERoomerOfflineAssertionException) or (E is EInvalidPointer) or
  // ( E is EOverflow          ) or
  // ( E is EUnderflow         ) or
    (E is EInvalidOp) or (E is EAbstractError) or (E is EIntOverflow) or (E is EAccessViolation) or (E is EControlC) or (E is EPrivilege) or (E is EInvalidCast)
    or (E is EVariantError) or (E is EAssertionFailed) or (E is EIntfCastError) or (pos('out of bounds', ANSIlowercase(E.message)) > 0) then
  begin
    if ExceptionsLoggingActive then
      ExceptionsLoggingActive := _textAppend(ExceptionLogPath, E.message, true);
  end
  else
  begin
    Application.ShowException(E);
  end;
end;

procedure TfrmMain.PrepareSkinSelections;
var
  i: integer;
  item: TMenuItem;
begin
  S1.Clear;
  for i := 0 to sSkinManager1.InternalSkins.Count - 1 do
  begin
    item := TMenuItem.Create(nil);
    item.Caption := sSkinManager1.InternalSkins[i].name;
    if item.Caption = sSkinManager1.skinName then
      item.Checked := true;
    item.Tag := i;
    item.OnClick := SelectSkinEvent;
    S1.Add(item);

    __dxBarCombo1.Items.Add(sSkinManager1.InternalSkins[i].name);
    if sSkinManager1.InternalSkins[i].name = sSkinManager1.skinName then
      __dxBarCombo1.ItemIndex := i;
  end;
end;

procedure TfrmMain.pupGroupsPopup(Sender: TObject);
begin
  C4.Enabled := false;
  C5.Enabled := false;
  I1.Enabled := false;
  G4.Enabled := false;
  if mAllReservations.eof OR mAllReservations.BOF then
    exit;

  C4.Enabled := mAllReservations['Status'] = 'P';
  C5.Enabled := mAllReservations['Status'] = 'G';
  I1.Enabled := true;
  G4.Enabled := true;
end;

procedure TfrmMain.SelectSkinEvent(Sender: TObject);
begin
  __dxBarCombo1.CurItemIndex := TMenuItem(Sender).Tag;
  __dxBarCombo1CloseUp(__dxBarCombo1);
end;

// ** END OF Private declarations ***********************************************

// ** START OF FORM FUNCTIONS ---------------------------------------------------

procedure TfrmMain.FormCreate(Sender: TObject);
var
  recVer: TEXEVersionData;
  temp: String;
begin
  FMessagesBeingDownloaded := false;
  StaffComm := nil;
  _InvoiceIndex := 0;

  HintWindowShowing := false;
  zHintObj := TCustomHint.Create(self);
  try
    temp := ReadStringValueFromAnyRegistry('Software\Roomer\FormStatus\StoreMainV2\sSkinManager1', 'SkinName', 'RoomerUI');
    if pos('(internal)', temp) > 0 then
      temp := LowerCase(trim(StringReplace(temp, ' (internal)', '', [rfReplaceAll, rfIgnoreCase])))
    else
      temp := LowerCase(trim(temp));
    temp := StringReplace(temp, '"', '', [rfReplaceAll, rfIgnoreCase]);
    if pos(temp + ',', 'office2007 black,tv-b,macos2,windows 8,gplus,fm,roomerui,altermetro,') = 0 then
    begin
      WriteStringValueToAnyRegistry('Software\Roomer\FormStatus\StoreMainV2\sSkinManager1', 'SkinName', 'RoomerUI');
    end;
  except
  end;

  if FileExists(Application.ExeName + '.log') then
    try
      DeleteFile(Application.ExeName + '.log');
    except
    end;
  availListContainer := TRoomClassChannelAvailabilityContainerDictionary.Create(True);

  GroupList := TGroupEntityList.Create(True);
  MoveFunctionAvailRooms := TRoomAvailabilityEntityList.Create(True);

  LoginCancelled := false;
  zJustClicked := false;

  zGotoCol := 0;
  zGotoRow := 0;
  lastDate := 0;

  grPeriodViewFilterOn := false;

  zDoRefresh := false;
  zDoRefreshPeriod := false;

  ShowComponentNameOnHint := LowerCase(ParameterByName('ShowComponentNameOnHint')) = 'true';

{$IFNDEF MONITOR_LEAKAGE}
  ExceptionsLoggingActive := true;
  ExceptionLogPath := ExtractFileDir(Application.ExeName);
  ExceptionLogPath := TPath.Combine(LocalAppDataPath, 'Roomer\logs');
  if ParameterByName('LogPath') <> '' then
    ExceptionLogPath := ParameterByName('LogPath');
  forceDirectories(ExceptionLogPath);
  ExceptionLogPath := Format('%s.log', [TPath.Combine(ExceptionLogPath, ExtractFilename(Application.ExeName))]);

{$IFDEF USE_JCL}
  JclAddExceptNotifier(LogException);
{$ELSE}
{$ENDIF}
  Application.OnException := ExceptionHandler;
{$ENDIF}
  pageMainGrids.ActivePageIndex := 0;
  ug.OpenApplication;
  zShowCaptions := true;
  barinn.HideAll;
  // FIX   StateSaver1.theOwner := TForm(Self);
  StoreMain.StorageName := 'Software\Roomer\FormStatus\StoreMainV2';
  // g.qProgramPath + 'forms' + '.ini';
  StoreMain.RestoreFrom;

  try
    recVer := _GetEXEVersionData(Paramstr(0));
    __VER.Caption := { 1081 } ANSIUpperCase(GetTranslatedText('sh0080')) + ': ' + recVer.FileVersion;
  except
  end;

  PrepareSkinSelections;

  Screen.cursors[1] := loadcursor(hinstance, 'MOVE');
  curNoDrop := Screen.cursors[crNoDrop];
  curNoDropNew := loadcursor(hinstance, 'MOVESC');
  // LoadOneDayViewGridStatus;

  Application.ShowHint := true;
  Application.HintHidePause := 15000;
  Application.HintPause := 500;

  SetDateWithoutEvents(trunc(now));

  btnShowHideStatClick(nil);
  btnShowHideHintClick(nil);
  (*
    edNights.Value := 7;
    zNights        := edNights.AsInteger;
    zDateTo        := zDateFrom+zNights;
  *)
  // ReservationsModel := TReservationsModel.Create;

  dxRibbon1.ActiveTab := rbTabHome;

  tabsView.Font.Color := clWhite;

  lblAuthStatus.Caption := GetTranslatedText('shTx_AuthNeeded');
//  Application.ModalPopupMode := pmAuto;

end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  try
    GroupList.Free;
    MoveFunctionAvailRooms.Free;
    StaffComm.Free;
    availListContainer.Free;
    GetThreadedData.Free;
    FrmMessagesTemplates.Free;
  except
  end;
end;

procedure TfrmMain.SetDateWithoutEvents(aDate: TdateTime);
begin
  zDateFrom := trunc(aDate);
  dtDate.OnChange := nil;
  dtDate.Date := zDateFrom;
  dtDate.OnChange := dtDateChange;
end;

procedure TfrmMain.PlaceRoomerOnCurrnetMonitor;
var
  Monitor: TMonitor;
const
  MoveWinThreshold: Byte = 80;
begin
  Monitor := Screen.MonitorFromWindow(self.handle);

  if Left > Monitor.Left + Monitor.Width - MoveWinThreshold then
    Left := Monitor.Left + Monitor.Width - MoveWinThreshold;

  if Top > Monitor.Top + Monitor.Height - MoveWinThreshold then
    Top := Monitor.Top + Monitor.Height - MoveWinThreshold;

  if Width > Monitor.Width then
  begin
    Width := Monitor.Width;
  end;

  if Height > Monitor.Height then
  begin
    Height := Monitor.Height;
  end;

  if Left + Width > Monitor.Width then
    Left := 0;

  if Top + Height > Monitor.Height then
    Top := 0;
end;

procedure TfrmMain.PlacePeriodViewTypePanel;
begin
  btnRefreshOneDay.Click;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  SetDateWithoutEvents(trunc(now));

  StaffComm := TStaffCommunication.Create(pnlStaffComm);


  if cbxStatDay.ItemIndex < 0 then
    cbxStatDay.ItemIndex := 0;

  FrmMessagesTemplates := TFrmMessagesTemplates.Create(nil);
  FrmMessagesTemplates.pnlContainer.Parent := pnlNotifications;

  StartHotel(true);

  if NOT LoginCancelled then
  begin
    try
      frmDayNotes.edCurrentDate.Text := DateToStr(dtDate.Date);
    Except
    end;

    zDoRefresh := true;
    zDoRefreshPeriod := true;

    SetExtraSkinColors;

    PlaceRoomerOnCurrnetMonitor;

    FormResize(Sender);
    barinnBar4.Visible := false;

    AssignSkinColorsToComponents;

    grPeriodRooms.colWidths[3] := 0;
    grPeriodRooms.colWidths[4] := 0;

    if btnShowHideStat.Down then
      btnShowHideStatClick(btnShowHideStat);
    // if btnShowHideHint.Down then
    // btnShowHideHintClick(btnShowHideHint);

    if cbxViewTypes.ItemIndex < 0 then
      cbxViewTypes.ItemIndex := 0;

    grOneDayRooms.FixedCols := 0;
    FrmReservationHintHolder.InitEmbededHint(self);
    FrmReservationHintHolder.OnLogInOutClick := OnLogInOutHandlerClick;
    FrmReservationHintHolder.OnViewReservationClick := OnViewReservationHandlerClick;

    embOccupancyView.InitEmbededOccupancyView(pnlPeriodNoRooms);

    // btnCashierReport.Visible := ivNever;

    Application.ShowHint := true; // definitions for hints
    // try
    // if LoadOneDayViewGridStatus then
    // begin
    // grAutoSizeGrids;
    // AutoSizePeriodColumns;
    // AutoResizeOneDayGrid;
    // end;
    // except
    // end;

  end
  else
    ExitProcess(0);
end;

procedure TfrmMain.OnLogInOutHandlerClick(rri: RecRRInfo; ButtonClicked: THintButtonClicked);
var
  sNewRoom: String;
begin
  if ButtonClicked = hbcLogin then
  begin

    if Copy(rri.Room, 1, 1) = '<' then
      sNewRoom := ProvideARoom2(rri.RoomReservation)
    else
      sNewRoom := rri.Room;
    if sNewRoom <> '' then
    begin
      zDebug1 := '101';
      CheckInARoom(sNewRoom, rri.RoomReservation);
      RefreshGrid;
    end;

  end
  else
    CheckOutARoom(rri.Room, rri.RoomReservation, rri.Reservation);

  RefreshGrid;
end;

procedure TfrmMain.OnViewReservationHandlerClick(rri: RecRRInfo);
begin
  if EditReservation(rri.Reservation, rri.RoomReservation) then;
end;

procedure TfrmMain.SetExtraSkinColors;
var
  skinName: string;
begin
  pnlNoRoomDrop.Color := sSkinManager1.GetGlobalColor;
  lblNoRoom.Font.Color := sSkinManager1.GetGlobalFontColor;
  HTMLHint1.HintColor := sSkinManager1.GetHighLightColor(false);
  HTMLHint1.HintFont.Color := sSkinManager1.GetHighLightFontColor(false);

  skinName := LowerCase(trim(sSkinManager1.skinName));

  if (pos(skinName, 'macos2') > 0) then
  begin
    grPeriodRooms.FixedFont.Color := clBlack;
  end
  else
  begin
    grPeriodRooms.FixedFont.Color := clWhite;
  end;

end;

function TfrmMain.StartHotel(appstart: boolean; ForcefulRestart: boolean = false; AutoLogin: String = ''): boolean;
var
  userName, password, WrongLoginMessage, ExpiredMessage: string;
  okLogin: boolean;
  tries: integer;
  iActiveHotel, i, ii: integer;
  sTmp: string;

  tmpUserLang: integer;
  esc: boolean;
  hotel: TRoomerHotelsEntity;

  didPostProcess: boolean;

begin
  result := false;
  didPostProcess := false;
  tmpUserLang := g.qUserLanguage;

  EnableDisableFunctions(false);

  if not appstart then
    g.ProcessAppIni(1);

  for i := 0 to pageMainGrids.PageCount - 1 do
  begin
    pageMainGrids.TabHeight := 0;
    pageMainGrids.Pages[i].TabVisible := false;
  end;

  if appstart then
    HideRoomerSplash;

  userName := g.qUser;
  password := '';
  WrongLoginMessage := '';
  ExpiredMessage := '';

  pageMainGrids.ActivePage := tabOneDayView;
  ViewMode := vmOneDay;

  okLogin := false;
  tries := 0;
  repeat
    inc(tries);
    if tries > 1 then
    begin
      WrongLoginMessage := Format(GetTranslatedText('shWrongLoginAttempts'), [tries]);
      AddRoomerActivityLog(d.roomerMainDataSet.username,
                           uActivityLogs.LOGIN,
                           'Failure',
                           'User ' + d.roomerMainDataSet.username + ' tried to log in without success.');
    end;

    if doLogin(userName, password, WrongLoginMessage, ExpiredMessage, esc, AutoLogin) then
    begin
      okLogin := d.doLogin(userName, password);
      if okLogin then
      begin
        g.ProcessAppIni(0);

        d.roomerMainDataSet.ApplicationID := g.qApplicationID;
        d.roomerMainDataSet.AppSecret := g.qAppSecret;
        d.roomerMainDataSet.AppKey := g.qAppKey;
        initializeTaxes;

        if ForcefulRestart then
        begin
          result := true;
          exit;
        end;

        iActiveHotel := 0;
        try
          if AutoLogin = '' then
          begin
            __cbxHotels.Items.BeginUpdate;
            try
              if g.qAppSecret = '' then
              begin
                g.RegisterApplication;
              end;

              prepareDependencyManager;

              __cbxHotels.Items.Clear;
              if d.roomerMainDataSet.hotels.Count = 0 then
              begin
                __cbxHotels.Items.AddObject(Format('%s - %s', [ANSIUpperCase(d.roomerMainDataSet.hotelId), g.qHotelName]), nil);
              end
              else
              begin
                for i := 0 to d.roomerMainDataSet.hotels.Count - 1 do
                begin
                  __cbxHotels.Items.AddObject(Format('%s - %s', [ANSIUpperCase(d.roomerMainDataSet.hotels[i].hotelCode),
                    d.roomerMainDataSet.hotels[i].hotelName]), d.roomerMainDataSet.hotels[i]);
                  if LowerCase(d.roomerMainDataSet.hotels[i].hotelCode) = LowerCase(d.roomerMainDataSet.hotelId) then
                    iActiveHotel := i;
                end;
              end;
              __cbxHotels.ItemIndex := iActiveHotel;
            finally
              __cbxHotels.Items.endUpdate;
            end;

          end;
          didPostProcess := true;
          PostLoginProcess(AutoLogin = '');
        except
          on E: Exception do
            MessageDlg(E.message, mtError, [mbOk], 0);
        end;
        if AutoLogin = '' then
          __cbxHotels.ItemIndex := iActiveHotel;
      end;
    end
    else
    begin
      // tries := 10;
    end;
  until okLogin OR esc OR (tries >= 15);

  if okLogin then
  begin
    AddRoomerActivityLog(d.roomerMainDataSet.username,
                         uActivityLogs.LOGIN,
                         'Success',
                         'User ' + d.roomerMainDataSet.username + ' successfully logged in.');
    if (NOT ForcefulRestart) AND CheckForUpdatedRelease then
    begin
      LoginCancelled := true;
      try
        d.roomerMainDataSet.Logout;
        lblUsername.Caption := 'N/A';
      except
      end;
      result := false;
      Close;
      exit;
    end;
  end;

  if not okLogin then
  begin
    LoginCancelled := true;
    result := false;
    Close;
    exit;
  end
  else
  begin
    result := true;
    lblHotelName.Caption := g.qHotelName;
    timMessagesTimer(timMessages);
    timMessages.Enabled := true;
    try
      CloseAppSettings;
      OpenAppSettings;
      if g.oRooms <> nil then
        freeandNil(g.oRooms);
      g.oRooms := TRooms.Create(g.qHotelCode);
    except
      on E: Exception do
        MessageDlg(E.message, mtError, [mbOk], 0);
    end;

    d.PrepareFixedTables;

    if g.qUserLanguage <> tmpUserLang then
    begin
      g.ChangeLang(g.qUserLanguage, false);
    end;

    d.Get_All_StatusAttributes;

    g.qDebug1 := 'StartHotel(appstart : boolean);';

    g.qUser := userName;

    pageMainGrids.ActivePage := tabOneDayView;

    d.ctrlGetGlobalValues;

    cbxNameOrder.ItemIndex := g.qNameOrder;
    cbxNameOrderPeriod.ItemIndex := g.qNameOrderPeriod;

    d.chkInPosMonitor;
    d.chkConfirmMonitor;

    try
      RestoreCurrentFont
    except
    end;
    StartOneDay;

    cbxNameOrder.ItemIndex := g.qNameOrder;
    grOneDayRooms.DefaultRowHeight := g.qOneDayRowHeight;
    g.updateCurrentGuestlist;

    HideRoomerSplash;

  end;

  frmRoomerSplash.NilInternetEvents;

  if NOT OffLineMode then
    rgrGroupreportStayType.ItemIndex := 2;

  zNights := g.qPeriodColCount;;
  zDateTo := zDateFrom + zNights;

  Period_Init;
  Period_GetRooms;

  grNoRooms_Init;

  bUsingMessagesSet := false;
  InitializeViews;
  SetWindowTitle;

  btnCheckInRoom.Enabled := true;

  oldDock1.Visible := g.qShowSideBar;

  FRBEMode := false;
  RBEMode := (g.qUserPriv1 = 50) OR (g.qUserPriv2 = 50) OR (g.qUserPriv3 = 50) OR (g.qUserPriv4 = 50) OR (g.qUserPriv5 = 50);

  SetExplanationColors;
end;

procedure TfrmMain.SetShapeColor(Shape: TShape; ResStatus: String);
var
  backColor, fontColor: TColor;
begin
  ResStatusToColor(ResStatus, backColor, fontColor);
  Shape.Brush.Color := backColor;
  Shape.Pen.Color := backColor;
end;

procedure TfrmMain.SetExplanationColors;
begin
  __ExplainP.Caption := GetTranslatedText('shTx_G_DueToArrive');
  SetShapeColor(shpP, 'P');
  // __ExplainP.Caption := GetTranslatedText('shTx_G_NotArrived');
  __ExplainG.Caption := GetTranslatedText('shTx_G_CheckedIn');
  SetShapeColor(shpG, 'G');
  // __ExplainP.Caption := GetTranslatedText('shTx_G_CheckedOut');
  // __ExplainO.Caption := GetTranslatedText('shTx_G_WaitingList');
  // __ExplainA.Caption := GetTranslatedText('shTx_G_Alotment');
  __ExplainN.Caption := GetTranslatedText('shTx_G_NoShow');
  SetShapeColor(shpN, 'N');
  __ExplainB.Caption := GetTranslatedText('shTx_G_Blocked');
  SetShapeColor(shpB, 'B');
  __ExplainDeparting.Caption := GetTranslatedText('shTx_G_DepartingToday');
  shpDeparting.Brush.Color := clGray;
  shpDeparting.Pen.Color := clGray;
  __ExplainO.Caption := GetTranslatedText('shTx_G_WaitingList');
  SetShapeColor(shpO, 'O');
end;

procedure TfrmMain.TranslateOpenForms;
begin
  SetWindowTitle;

  __dxBarCombo1.Caption := GetTranslatedText('shTxLookAndFeel');

  try
    RoomerLanguage.TranslateThisForm(self);
  except
  end;
  try
    RoomerLanguage.TranslateThisForm(frmDayNotes);
  except
  end;
  try
    RoomerLanguage.TranslateThisForm(frmGoToRoomandDate);
  except
  end;
  // try RoomerLanguage.TranslateThisForm(frmInvoicePayment2); except end;
  // try RoomerLanguage.TranslateThisForm(frmSelHotel); except end;
  try
    RoomerLanguage.TranslateThisForm(frmHomedate);
  except
  end;
  try
    RoomerLanguage.TranslateThisForm(frmDaysStatistics);
  except
  end;
  try
    RoomerLanguage.TranslateThisForm(FrmRateQuery);
  except
  end;

  try
    RoomerLanguage.TranslateThisForm(FrmReservationHintHolder);
  except
  end;
  try
    RoomerLanguage.TranslateThisForm(embOccupancyView);
  except
  end;
  try
    RoomerLanguage.TranslateThisForm(embPeriodView);
  except
  end;

end;

procedure TfrmMain.tvAllReservationsAverageRateGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(ARecord.Values[tvAllReservationsCurrency.index]);
end;

procedure TfrmMain.tvAllReservationsTotalStayRateGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(ARecord.Values[tvAllReservationsCurrency.index]);
end;

function TfrmMain.CountRoomsOfSpecificType(RoomType: String): integer;
begin
  result := 0;
  glb.RoomsSet.first;
  while NOT glb.RoomsSet.eof do
  begin
    if (glb.RoomsSet['RoomType'] = RoomType) AND (glb.RoomsSet['Active']) AND (NOT glb.RoomsSet['Hidden']) then
      inc(result);
    glb.RoomsSet.next;
  end;
end;

procedure TfrmMain.FillRoomTypesGrid;
var
  rSet: TRoomerDataSet;
  idx: integer;
begin
  availListContainer.Clear;
  // rSet := d.roomerMainDataSet.ActivateNewDataset
  // (d.roomerMainDataSet.SystemFreeQuery('SELECT rt.RoomType,' +
  // ' (SELECT COUNT(Room) FROM rooms WHERE rooms.RoomType=rt.RoomType AND Active=1 AND NOT Hidden) AS NumRooms'
  // + ' FROM roomtypes rt WHERE active=1 ORDER BY rt.RoomType'));
  grdRoomStatusses.ColCount := 3;
  grdRoomStatusses.RowCount := 2;
  grdRoomStatusses.cells[0, 0] := GetTranslatedText('shType');
  grdRoomStatusses.cells[1, 0] := GetTranslatedText('shRooms');
  grdRoomStatusses.cells[2, 0] := GetTranslatedText('shTx_Available');
  glb.RoomTypesSet.first;
  while not glb.RoomTypesSet.eof do
  begin
    grdRoomStatusses.cells[0, grdRoomStatusses.RowCount - 1] := glb.RoomTypesSet['RoomType'];
    grdRoomStatusses.cells[1, grdRoomStatusses.RowCount - 1] := inttostr(CountRoomsOfSpecificType(glb.RoomTypesSet['RoomType']));
    glb.RoomTypesSet.next;
    grdRoomStatusses.RowCount := grdRoomStatusses.RowCount + 1;
  end;
  grdRoomStatusses.RowCount := grdRoomStatusses.RowCount - 1;
  grdRoomStatusses.Height := grdRoomStatusses.DefaultRowHeight * grdRoomStatusses.RowCount;

  if d.roomerMainDataSet.OffLineMode then
    exit;

  rSet := d.roomerMainDataSet.ActivateNewDataset
    (d.roomerMainDataSet.SystemFreeQuery(Format('SELECT rtg.Code, ' +
    '(SELECT COUNT(r.Room) FROM rooms r, roomtypes rt WHERE r.Active AND r.WildCard=0 AND r.RoomType=rt.RoomType AND rt.RoomTypeGroup=rtg.Code) AS NumRooms, ' +
    '(SELECT availability FROM channelratesavailabilities WHERE date=_params._date AND roomClassId=rtg.id LIMIT 1) AS ChannelAvailable ' +
    'FROM roomtypegroups rtg, ' + '     (SELECT ''%s'' AS _date) AS _params ' + 'WHERE active=1 ' +
    // '-- AND (SELECT COUNT(r.Room) FROM rooms r, roomtypes rt WHERE r.RoomType=rt.RoomType AND rt.RoomTypeGroup=rtg.Code) > 0 ' +
    'ORDER BY rtg.Code', [uDateUtils.dateToSqlString(dtDate.Date)])));
  try
    grdRoomClasses.ColCount := 4;
    grdRoomClasses.RowCount := 2;
    grdRoomClasses.cells[0, 0] := GetTranslatedText('shTx_Class');
    grdRoomClasses.cells[1, 0] := GetTranslatedText('shRooms');
    grdRoomClasses.cells[2, 0] := GetTranslatedText('shTx_Available');
    grdRoomClasses.cells[3, 0] := GetTranslatedText('shTx_ChannelAvailable');
    rSet.first;
    while not rSet.eof do
    begin
      if rSet['NumRooms'] > 0 then
      begin
        idx := grdRoomClasses.RowCount - 1;
        grdRoomClasses.cells[0, idx] := rSet['Code'];
        grdRoomClasses.cells[1, idx] := rSet['NumRooms'];
        grdRoomClasses.cells[2, idx] := '0';
        grdRoomClasses.cells[3, idx] := rSet['ChannelAvailable'];
        grdRoomClasses.Objects[3, idx] := Pointer(1);
        availListContainer.Add(TRoomClassChannelAvailabilityContainer.Create(rSet['Code'], rSet['NumRooms'], 0, 0, 0, idx, false));

        grdRoomClasses.RowCount := grdRoomClasses.RowCount + 1;
      end;
      rSet.next;
    end;
    grdRoomClasses.RowCount := grdRoomClasses.RowCount - 1;
    grdRoomClasses.Height := grdRoomClasses.DefaultRowHeight * grdRoomClasses.RowCount;
  finally
    freeandNil(rSet);
  end;
end;

procedure TfrmMain.Chart1DblClick(Sender: TObject);
begin
  sSkinManager1.active := NOT sSkinManager1.active;
end;

function TfrmMain.CheckForUpdatedRelease: boolean;
begin
  result := checkNewVersion(handle, d.roomerMainDataSet);
end;

procedure TfrmMain.LocationMenuSelect(Sender: TObject);
begin
  TMenuItem(Sender).Checked := NOT TMenuItem(Sender).Checked;
  WriteStringValueToAppRegistry(d.roomerMainDataSet.userName, 'LocationSelected_' + g.qHotelCode + '_' + inttostr(TMenuItem(Sender).Tag),
    Bool2Str(TMenuItem(Sender).Checked));
  btnFilter.ImageIndex := ABS(Ord(LocationFilter(false) OR GroupsFilterActive OR ReservationStatusFilter)); // OR GroupsFilterActive));

  checkFilterStatuses;
  RedisplayGuestWindows;
end;

function TfrmMain.SearchActive: boolean;
begin
  result := (edtSearch.Text <> '');
end;

function TfrmMain.SearchOrGroupFilterActive: boolean;
begin
  result := SearchActive OR ReservationStatusFilter OR GroupsFilterActive;
  // OR FilterActive; // OR GroupsFilterActive;
end;

function TfrmMain.FilterActive: boolean;
begin
  result := LocationFilter OR ReservationStatusFilter; // OR FreeRoomsFiltered;
end;

function TfrmMain.LocationOrFloorFilterActive: boolean;
begin
  result := LocationFilter(false); // OR FreeRoomsFiltered;
end;

function TfrmMain.FreeRoomsFiltered: boolean;
var
  i: integer;
begin
  result := T1.Checked;
  if not result then
    for i := 0 to S2.Count - 1 do
      if S2.Items[i].Checked then
      begin
        result := true;
        break;
      end;
end;

function TfrmMain.GroupsFilterActive: boolean;
var
  i: integer;
begin
  result := false;
  for i := 0 to G2.Items.Count - 1 do
    if G2.Items[i].Checked then
    begin
      result := true;
      break;
    end;
end;

function TfrmMain.GroupFiltered(Reservation: integer): boolean;
var
  i: integer;
begin
  result := false;
  for i := 0 to G2.Items.Count - 1 do
    if (G2.Items[i].Checked) AND (GroupList[G2.Items[i].Tag].Reservation = Reservation) then
    begin
      result := true;
      break;
    end;
end;

const
  RES_STATUS_FILTER_LOCATIONS: String = 'GPDONABC';

function TfrmMain.ReservationStatusFiltered(status: TReservationStatus): boolean;
var
  i: integer;
  letter: Char;
begin
  result := false;
  letter := '-';
  case status of
    rsDeparted:
      letter := 'D';
    rsReservations:
      letter := 'P';
    rsGuests:
      letter := 'G';
    rsOverbooked:
      letter := 'O';
    rsAlotment:
      letter := 'A';
    rsNoShow:
      letter := 'N';
    rsBlocked:
      letter := 'B';
    rsCanceled:
      letter := 'C';
  end;
  if letter = '-' then
    exit;
  i := pos(letter, RES_STATUS_FILTER_LOCATIONS) - 1;
  if (i >= 0) AND (i < mnuItemStatus.Items.Count) then
    result := (mnuItemStatus.Items[i].Checked);
end;

function TfrmMain.ReservationStatusFilter: boolean;
var
  i: integer;
begin
  result := false;
  for i := 0 to mnuItemStatus.Items.Count - 1 do
  begin
    result := (mnuItemStatus.Items[i].Checked);
    if result then
      break;
  end;
end;

function TfrmMain.LocationFilter(OnlyLocations: boolean = true): boolean;
var
  i: integer;
begin
  result := false;
  for i := 0 to mnuFilterLocation.Items.Count - 1 do
  begin
    result := (mnuFilterLocation.Items[i].Checked);
    if result then
      if OnlyLocations then
        result := mnuFilterLocation.Items[i].Tag >= 1000;
    if result then
      break;
  end;
end;

function TfrmMain.LocationFiltered(Location: String): boolean;
var
  i: integer;
  id: integer;
begin
  result := false;
  id := glb.GetLocationId(Location);
  for i := 0 to mnuFilterLocation.Items.Count - 1 do
    if (mnuFilterLocation.Items[i].Checked) AND (mnuFilterLocation.Items[i].Tag = id + 1000) then
    begin
      result := true;
      break;
    end;
end;

function TfrmMain.FilteredFloors: TSet_Of_Integer;
var
  i: integer;
  checkFound: boolean;
begin
  result := TSet_Of_Integer.Create;
  checkFound := false;
  for i := 0 to mnuFilterLocation.Items.Count - 1 do
  begin
    if (mnuFilterLocation.Items[i].Checked) AND (mnuFilterLocation.Items[i].Tag < 1000) then
    begin
      result.Add(mnuFilterLocation.Items[i].Tag);
    end;
  end;
end;

function TfrmMain.FilteredLocations: TSet_Of_Integer;
var
  i: integer;
  checkFound: boolean;
begin
  result := TSet_Of_Integer.Create;
  checkFound := false;
  for i := 0 to mnuFilterLocation.Items.Count - 1 do
  begin
    if (mnuFilterLocation.Items[i].Checked) AND (mnuFilterLocation.Items[i].Tag >= 1000) then
    begin
      result.Add(mnuFilterLocation.Items[i].Tag - 1000);
    end;
  end;
end;

function TfrmMain.FloorFiltered(Floor: integer): boolean;
var
  i: integer;
  checkFound: boolean;
begin
  result := false;
  checkFound := false;
  for i := 0 to mnuFilterLocation.Items.Count - 1 do
  begin
    if (mnuFilterLocation.Items[i].Checked) AND (mnuFilterLocation.Items[i].Tag = Floor) then
    begin
      result := true;
      break;
    end;
    if (NOT checkFound) AND (mnuFilterLocation.Items[i].Checked) then
      checkFound := true;
  end;
  result := result OR (NOT checkFound);
end;

procedure TfrmMain.DisplayStatusses(IncludeChart: boolean);
begin
  Chart1.Visible := IncludeChart;
  if IncludeChart then
  begin
    pnlDateStatistics.Top := 0;
    grdRoomClasses.Top := pnlDateStatistics.Top + pnlDateStatistics.Height + 10;
    Chart1.Top := grdRoomClasses.Top + grdRoomClasses.Height + 10;
    grdRoomStatusses.Top := Chart1.Top + Chart1.Height + 10;
  end;
end;

procedure TfrmMain.pageMainGridsChange(Sender: TObject);
var
  aDate: TdateTime;
begin
  aDate := dtDate.Date;

  ShowAllRoomsRows;

  if pageMainGrids.ActivePage = tabOneDayView then
  begin
    DisplayStatusses(true);
    ViewMode := vmOneDay;
    OneDayUpdatePage(aDate);
  end
  else if pageMainGrids.ActivePage = tabGuestList then
  begin
    DisplayStatusses(true);
    ViewMode := vmGuestList;
  end
  else if pageMainGrids.ActivePage = tabPeriod then
  begin
    DisplayStatusses(false);
    ViewMode := vmPeriod;
  end
  else if pageMainGrids.ActivePage = tabDashboard then
  begin
    DisplayStatusses(false);
    ViewMode := vmDashboard;
  end
  else if pageMainGrids.ActivePage = tabRateQuery then
  begin
    DisplayStatusses(true);
    ViewMode := vmRateQuery;
  end;
end;

function TfrmMain.doLogin(var userName, password, WrongLoginMessage, ExpiredMessage: string; var pressedEsc: boolean; AutoLogin: String = ''): boolean;
var
  hotelId: String;
  lastMessage: String;
  iLoc: integer;
begin
  result := false;
  pressedEsc := false;
  lastMessage := '';
  repeat
    if (AutoLogin <> '') OR AskUserForCredentials(userName, password, hotelId, lastMessage) then
    begin
      result := true;
      lblAuthStatus.Caption := GetTranslatedText('shTx_Authenticating');
      try
        if (AutoLogin <> '') then
        begin
          hotelId := AutoLogin;
          sleep(1000);
          d.roomerMainDataSet.SwapHotel(hotelId, userName, password)
        end
        else if (NOT OffLineMode) AND d.roomerMainDataSet.IsConnectedToInternet AND d.roomerMainDataSet.RoomerPlatformAvailable then
          d.roomerMainDataSet.Login(hotelId, userName, password, 'ROOMERPMS', GetVersion(Application.ExeName))
        else
        begin
          OffLineMode := true;
          d.roomerMainDataSet.hotelId := hotelId;
          d.roomerMainDataSet.userName := userName;
          d.roomerMainDataSet.password := password;
          d.roomerMainDataSet.SessionLengthSeconds := 1;
        end;
        lblAuthStatus.Caption := GetTranslatedText('shTx_AuthSuccess');
        g.qHotelCode := hotelId;
        timCheckSessionExpired.Enabled := true;
      except
        on E: Exception do
        begin
          AutoLogin := '';
          lastMessage := E.message;
          iLoc := pos(' - ''http://', lastMessage);
          if iLoc > 0 then
            lastMessage := Copy(lastMessage, 1, iLoc - 1);
          lblAuthStatus.Caption := lastMessage;
          password := '';
          result := false;
        end;
      end;
    end
    else
      pressedEsc := true;
  until result OR pressedEsc;
end;

procedure TfrmMain.NillifyEventHandlers(grid : TAdvStringGrid);
begin
  grid.OnDrawCell := nil;
  grid.OnEnter := nil;
  grid.OnMouseMove := nil;
  grid.OnResize := nil;
  grid.OnGetCellBorder := nil;
  grid.OnGetCellColor := nil;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  try
    NillifyEventHandlers(grOneDayRooms);
    NillifyEventHandlers(grPeriodRooms);
    NillifyEventHandlers(grPeriodRooms_NO);
    // barinn.SaveToRegistry('Software\Roomer\PMS\Barinn\' + g.qUser);
    Try
      ug.CloseApplication;
    Except
    End;
    if NOT FRBEMode then
      StoreMain.StoreTo(false)
    else
      StoreMain.active := false;
    bAppClosing := true;
    ReservationsModel.Free;

    try
      if oFreeRooms <> nil then
        freeandNil(oFreeRooms);

      if hData.oRoomTypeRoomCount <> nil then
        freeandNil(hData.oRoomTypeRoomCount);

      // *s  if zRoomsOBJ <> nil then freeandNil(zRoomsOBJ);
      if g.oRooms <> nil then
        freeandNil(g.oRooms);
    except
    end;

    try
      ClearStringGridFromTo(grOneDayRooms, 1, 1);
    except
    end;

    try
      ClearFreeRooms;
    except
    end;
    try
      ClearRoomTypeCount;
    except
    end;
    try
      CloseAppSettings;
    except
    end;

  except
  end;

{$IFNDEF DEBUG}
  timHalt.Enabled := true;
{$ENDIF}
{$IFDEF USE_JCL}
  try
    JclRemoveExceptNotifier(LogException);
  except
  end;
{$ENDIF}
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin

  SaveOneDayViewGridStatus;

  if LoginCancelled OR FRBEMode OR not bAlreadyIn then
  begin
    CanClose := true;
  end
  else
  begin
    CanClose := RoomerMessageDialog(GetTranslatedText('sh1004'), mtConfirmation, [mbYes, mbNo], 'CloseRoomerMainForm', mrYes) = mrYes;
    // CanClose := MessageDLG( { 1004 } GetTranslatedText('sh1004'),
    // mtConfirmation, [mbYes, mbNo], 0) = mrYes;
    if CanClose AND bAlreadyIn then
      try
        embOccupancyView.Reset;
//        Application.ProcessMessages;
        d.roomerMainDataSet.Logout;
        lblUsername.Caption := 'N/A';
      except
      end;
  end;
end;

procedure TfrmMain.ShowHintWindow;
var
  s: String;
begin
  if pageMainGrids.ActivePage = tabPeriod then
  begin
    s := 'FORCE';
    if ActiveControl = grPeriodRooms_NO then
      grPeriodRoomsGridHint(grPeriodRooms_NO, grPeriodRooms_NO.row, grPeriodRooms_NO.col, s)
    else
      grPeriodRoomsGridHint(grPeriodRooms, grPeriodRooms.row, grPeriodRooms.col, s);
    HintWindowShowing := true;
  end
  else if pageMainGrids.ActivePage = tabOneDayView then
  begin
    ShowOneDayHint(grOneDayRooms.col, grOneDayRooms.row);
    HintWindowShowing := true;
  end;
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  myYear, myMonth, myDay: Word;
  numDays: integer;

  options: TExecuteFileOptions;
begin
  if pageMainGrids.ActivePage = tabPeriod then
    exit;

  if (Key = VK_F12) AND (ssCtrl IN Shift) AND (ssShift IN Shift) then
  begin
    options := [eoWait, eoMaximized];
    ExecuteFile(handle, 'CMD.EXE', '', options);
    exit;
  end;

  if (Key = VK_F1) AND (ssAlt IN Shift) then
  begin
    if NOT HintWindowShowing then
      ShowHintWindow;
    exit;
  end;

  // if pageMainGrids.ActivePage = tabMeetings then
  // exit;

  if ActiveControl = dtDate then
    exit;

  if (Key = vk_Right) then
  begin // vk_Next then begin
    btnBackForwardClick(btnForward);
    // if ssCtrl in Shift then
    // begin
    // if ssAlt in Shift then
    // begin
    // DecodeDate(dtDate.Date, myYear, myMonth, myDay);
    // numDays := (MonthDays[isLeapYear(myYear)][myMonth]);
    // // dtDate.Date := trunc(dtDate.Date + (MonthDays[isLeapYear(myYear)][myMonth]))
    // end
    // else
    // begin
    // numDays := 7;
    // end;
    // end
    // else
    // begin
    // numDays := 1;
    // end;
    // g.qDebug1 :=
    // 'FormKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState)';
    // dtDate.Tag := numDays;
    // dtDate.Date := trunc(dtDate.Date + numDays);
    Key := 0;
  end
  else if Key = vk_Left then
  begin // vk_Prior then begin
    btnBackForwardClick(btnBack);
    // if ssCtrl in Shift then
    // begin
    // if ssAlt in Shift then
    // begin
    // DecodeDate(dtDate.Date, myYear, myMonth, myDay);
    // if myMonth = 1 then
    // begin
    // myMonth := 12;
    // dec(myYear)
    // end
    // else
    // dec(myMonth);
    // dtDate.Date := trunc(dtDate.Date - (MonthDays[isLeapYear(myYear)][myMonth]))
    // end
    // else
    // dtDate.Date := trunc(dtDate.Date - 7);
    // end
    // else
    // begin
    // dtDate.Date := trunc(dtDate.Date - 1);
    // end;
    // g.qDebug1 :=
    // 'FormKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState)';
    Key := 0;
  end
  else if (Key = vk_Home) and (ssCtrl in Shift) then
  begin
    dtDate.Date := trunc(now);
    g.qDebug1 := 'FormKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState)';
    Key := 0;
  end;
end;

procedure TfrmMain.FormKeyPress(Sender: TObject; var Key: Char);
var
  s: string;
begin
  if (ActiveControl <> grOneDayRooms) AND (ActiveControl <> grPeriodRooms) AND (NOT frmDaysStatistics.BeingViewed) AND (NOT FrmRateQuery.BeingViewed) then
    exit;

  s := Key;

  if CharInSet(Key, ['a' .. 'z', 'A' .. 'Z', 'á', 'Á', 'é', 'É', 'ý', 'Ý', 'ú', 'Ú', 'í', 'Í', 'ó', 'Ó', 'þ', 'Þ', 'æ', 'Æ', 'ð', 'Ð', 'ö', 'Ö']) then
  begin
    ActiveControl := edtSearch;
    SendKeys(PChar(s), true);
    edtSearch.SelStart := 1;
    Key := #0;
  end;

  if OffLineMode then
    exit;

  if CharInSet(Key, ['0' .. '9']) then
  begin
    frmHomedate.dtHome.Date := dtDate.Date;
    // frmHomeDate.Show;
    frmHomedate.Left := Left + 1;
    frmHomedate.Top := Top + 1;

    // frmHomedate.ActiveControl := frmHomedate.dtHome;
    frmHomedate.dtHome.SelLength := 0;
    // frmHomeDate.dtHome.SetFocus;
    frmHomedate.dtHome.SelStart := 0;
    frmHomedate.dtHome.SelLength := 1;
    frmHomedate.dtHome.SetSelText(s);
    frmHomedate.dtHome.SelLength := 0;
    // SendKeys(PChar(s), true);
    frmHomedate.dtHome.SelStart := 1;
    frmHomedate.ShowModal;
    Key := #0;
  end;
end;

procedure TfrmMain.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if HintWindowShowing then
  begin
    HintWindowShowing := false;
    ApplicationCancelHint;
  end;
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  grdRoomStatusses.DefaultColWidth := (grdRoomStatusses.ClientWidth) div grdRoomStatusses.ColCount;
  grdRoomClasses.DefaultColWidth := (grdRoomClasses.ClientWidth) div grdRoomClasses.ColCount;

  pnlRoomerLogo.Left := ClientWidth - pnlRoomerLogo.Width - 10;

  // pnlRoomerLogo.Top := 2;
  // pnlRoomerLogo.Left := Width - pnlRoomerLogo.Width - 2; // - 40;

  // btnClearSearch.Left := lblMainHeader.Left + lblMainHeader.Width -
  // btnClearSearch.Width - 10;
  // edtSearch.Left := btnClearSearch.Left - edtSearch.Width;
  // lblSearch.Left := edtSearch.Left - lblSearch.Width - 8;

  if Assigned(StaffComm) then
    StaffComm.PlaceCorrectly;
end;

// ** END OF FORM FUNCTIONS ---------------------------------------------------

// (*
// TReservationStatus = (  rsUnKnown
// , rsReservations
// , rsGuests
// , rsDeparting
// , rsDeparted
// , rsReserved
// , rsOverbooked
// , rsAll
// , rsCurrent
// , rsAlotment
// , rsNoShow
// , rsBlocked
// );
//
// *)

procedure TfrmMain.StartOneDay;
var
  iTopRow, iOldCol, iOldRow: integer;

  rSet: TRoomerDataSet;

  i, ii: integer;
  ReservationCount: integer;
  RoomCount: integer;
  RoomNumber: string;
  ResStatus: TReservationStatus;
  ResStatusChar: string;
  s: string;
  sDate: string;
  dtDeparture: Tdate;
  daysToDeparture: integer;
  dNextOcc: Tdate;
  sNextOcc: string;

  isDeparting: string;

  tickCountStart: longint;
  tickCountEnd: longint;

  mnuItem: TMenuItem;

  statLastRoomNumber: String;
  statNumRooms, statNumExternRooms, statTaken, statCancelledExt, statCancelledRm: integer;

  temp: String;

  aDate: TdateTime;
begin
  // ClearRoomCells;
  lastDate := 0;
  grOneDayRooms.BeginUpdate;
  try

    timGetRoomStatuses.Enabled := false;
    tickCountStart := getTickCount;
    BusyOn;
    try
      RefreshRoomList;
      statNumRooms := g.oRooms.RoomCount;
      statNumExternRooms := 0;
      statCancelledExt := 0;
      statCancelledRm := 0;
      statTaken := 0;
      statLastRoomNumber := '';

      bAlreadyIn := true;

      zGuestListFirstTime := true;
      if ViewMode = vmOneDay then
      begin

        iTopRow := grOneDayRooms.TopRow;
        iOldCol := grOneDayRooms.col;
        iOldRow := grOneDayRooms.row;

        ReservationsModel.Free;
        ReservationsModel := TReservationsModel.Create;
        aDate := dtDate.Date;
        ReservationsModel.Execute(aDate, aDate + 1, rsAll);

        ReservationCount := ReservationsModel.ReservationCount;

        ziFreeRackRoomCount := 0;

        zsFreeRackRooms := '';
        zsOccRackRooms := '';
        zsNoRooms := '';

        ClearRoomTypeCount;
        hData.oRoomTypeRoomCount := TRoomTypeRoomCount.Create(g.qHotelCode);

        ClearGroupList;
        G2.Items.Clear;

        grOneDayRooms.FixedCols := 0;

        for i := 0 to ReservationCount - 1 do
        begin
          RoomCount := ReservationsModel.Reservations[i].RoomCount;

          if (RoomCount > 0) AND (trunc(ReservationsModel.Reservations[i].Departure) <> trunc(dtDate.Date)) AND
            (NOT ReservationNotInGroupList(ReservationsModel.Reservations[i].Reservation)) then
          begin
            mnuItem := TMenuItem.Create(nil);
            temp := ReservationsModel.Reservations[i].name;
            if (ReservationsModel.Reservations[i].RoomCount > 0) AND (ReservationsModel.Reservations[i].Rooms[0].GuestCount > 0) then
              temp := temp + ' - ' + ReservationsModel.Reservations[i].Rooms[0].Guests[0].GuestName;
            mnuItem.Caption := temp;
            mnuItem.Tag := GroupList.Add(TGroupEntity.Create(ReservationsModel.Reservations[i].Reservation, ReservationsModel.Reservations[i].name));
            mnuItem.OnClick := LocationMenuSelect;
            G2.Items.Add(mnuItem);
          end;

          for ii := 0 to RoomCount - 1 do
          begin
            RoomNumber := ReservationsModel.Reservations[i].Rooms[ii].RoomNumber;
            ResStatus := ReservationsModel.Reservations[i].Rooms[ii].ResStatus;
            dtDeparture := ReservationsModel.Reservations[i].Rooms[ii].Departure;
            daysToDeparture := trunc(dtDate.Date) - trunc(dtDeparture);

            ResStatusChar := g.ResStatusToStatusStr(ResStatus);

            if (daysToDeparture <> 0) AND (statLastRoomNumber <> RoomNumber) then
            begin
              if pos('<', RoomNumber) = 1 then
              begin
                if ResStatus = rsCanceled then
                  inc(statCancelledExt)
                else
                  inc(statNumExternRooms);
              end
              else
              begin
                if ResStatus = rsCanceled then
                  inc(statCancelledRm)
                else
                  inc(statTaken);
              end;
              statLastRoomNumber := RoomNumber;
            end;

            if daysToDeparture = 0 then
            begin
              // Departing
            end
            else
            begin
              if pos('<', RoomNumber) = 1 then
              begin
                zsNoRooms := zsNoRooms + RoomNumber + ','
              end
              else
              begin
                zsOccRackRooms := zsOccRackRooms + quotedStr(RoomNumber) + ',';
              end;
            end;
          end;
        end;

        if length(zsOccRackRooms) > 0 then
          Delete(zsOccRackRooms, length(zsOccRackRooms), 1);

        if length(zsNoRooms) > 0 then
          Delete(zsNoRooms, length(zsNoRooms), 1);

        sDate := _dateToDBDate(dtDate.Date, false);
        ClearFreeRooms;
        oFreeRooms := TFreeRooms.Create(g.qHotelCode, dtDate.Date, zsOccRackRooms);

        // labTotalRooms.Caption  := inttostr(statNumRooms);
        // labRackRoomCount.Caption  := inttostr(statTaken);
        // labFreeRoomCount.Caption  := inttostr(statNumRooms-statTaken);
        // labNoRoomCount.Caption  := inttostr(statNumExternRooms);
        // labNettoFreeRooms.Caption  := inttostr(statNumRooms-statTaken-statNumExternRooms);
        //
        // labFreeRoomCount.UseSkinColor := (statNumRooms-statTaken >= 0);
        // labNettoFreeRooms.UseSkinColor := (statNumRooms-statTaken-statNumExternRooms >= 0);

        Chart1.Series[0].Clear;
        Chart1.Series[0].Add(statNumRooms, GetTranslatedText('shMainFormStatisticsRooms'), clBlue);
        Chart1.Series[0].Add(statTaken, GetTranslatedText('shTx_Taken'), clMaroon);
        Chart1.Series[0].Add(statNumExternRooms, GetTranslatedText('shTx_NoRm'), clYellow);
        Chart1.Series[0].Add(statNumRooms - statTaken, GetTranslatedText('shTx_Free'), clGreen);
        Chart1.Series[0].Add(statNumRooms - statNumExternRooms - statTaken, GetTranslatedText('shTx_Netto'), clRed);
        Chart1.Series[0].Add(statCancelledExt + statCancelledRm, GetTranslatedText('shTx_Cancelled'), clBlack);

        OneDayUpdatePage(dtDate.Date);

        grOneDayRooms.SetFocus;

        if iOldCol < grOneDayRooms.ColCount then
          grOneDayRooms.col := iOldCol;

        if iOldRow < grOneDayRooms.RowCount then
          grOneDayRooms.row := iOldRow;

        if iTopRow < grOneDayRooms.RowCount then
          grOneDayRooms.TopRow := iTopRow;

      end
      else if ViewMode = vmGuestList then
      begin
        zGuestListFirstTime := false;
      end;

      DisplayDate(dtDate.Date);
      PostMessage(handle, WM_REFRESH_STAFF_COMM_NOTIFIER, 0, 0);

    finally
      if LoadOneDayViewGridStatus then
      begin
        grAutoSizeGrids;
        AutoResizeOneDayGrid;
      end;
      BusyOff;
    end;
    tickCountEnd := getTickCount;
    timGetRoomStatuses.Tag := trunc(dtDate.Date);
    timGetRoomStatuses.Enabled := true;
  finally
    grOneDayRooms.endUpdate;
    RefreshStats;
  end;
end;

procedure TfrmMain.RefreshRoomList;
begin
  if g.oRooms <> nil then
    freeandNil(g.oRooms);
  g.oRooms := TRooms.Create(g.qHotelCode);
end;

function TfrmMain.ReservationNotInGroupList(resId: integer): boolean;
var
  i: integer;
begin
  result := false;
  for i := 0 to GroupList.Count - 1 do
    if GroupList[i].Reservation = resId then
    begin
      result := true;
      break;
    end;
end;

(*

  if message.Msg = WM_AppliedKey then
  begin
  edtDate.SelLength := 0;
  edtDate.Text := FormatDateTime('DD' + DateSeparator + 'MM' + DateSeparator + 'YYYY', Now);
  edtDate.SetFocus;
  edtDate.SelLength := 0;
  if message.WParam > 0 then
  begin
  s := Chr(message.WParam);
  SendKeys(PChar(s), true);
  edtDate.SelStart := 1;
  end;
  end
*)

// **TODO
// gera vinnslu þar sem athugað er hvort opnir reikningar ery til staðar

// --
(*
  if OpenInvoiceExists(message.WParam, message.LParam) then
  begin
  if MessageDLG('There is one or more open sales on the group.' + #13#13 + 'Would you like to view the list ?', mtConfirmation,
  [mbYes, mbNo], 0) = mrYes then
  begin
  // --
  Application.CreateForm(TfrmOpenInvoices, frmOpenInvoices);
  try
  iTraceRes := message.WParam;
  iTraceRom := - 1;
  try
  frmOpenInvoices.ShowModal;
  finally
  iTraceRes := - 1;
  iTraceRom := - 1;
  end;
  finally
  frmOpenInvoices.free;
  end;
  end;
  end;
*)

procedure TfrmMain.RefreshStats(force: boolean = false);
var
  OCC, ADR, REVPAR: Double;
  RoomsSold: integer;
  s: String;
  rSet: TRoomerDataSet;
begin
  if OffLineMode then
    exit;

  if force OR (trunc(dtDate.Date) = trunc(now + cbxStatDay.ItemIndex)) OR (trunc(dtDate.Date + cbxStatDay.ItemIndex) = trunc(now + cbxStatDay.ItemIndex)) then
  begin
    OCC := 0;
    ADR := 0;
    REVPAR := 0;
    RoomsSold := 0;

    s := Format(HOTEL_PERFORMANCE_QUERY_BETWEEN_DATES,
        [
        dateToSqlString(now + cbxStatDay.ItemIndex),
        dateToSqlString(now + cbxStatDay.ItemIndex),

        dateToSqlString(now + cbxStatDay.ItemIndex),
        dateToSqlString(now + cbxStatDay.ItemIndex),

        dateToSqlString(now + cbxStatDay.ItemIndex),
        dateToSqlString(now + cbxStatDay.ItemIndex)
        ]);
    CopyToClipboard(s);
    rSet := CreateNewDataSet;
    try
      hData.rSet_bySQL(rSet, s);
      rSet.first;
      if NOT rSet.eof then
      begin
        OCC := rSet['OCC'];
        ADR := rSet['ADR'];
        REVPAR := rSet['RevPar'];
        RoomsSold := rSet['RoomsSold'];
      end;
    finally
      freeandNil(rSet);
    end;

    // frmDaysStatistics.ViewDate := now + cbxStatDay.ItemIndex;
    // frmDaysStatistics.GetDaysNumbers(OCC, ADR, REVPAR, RoomsSold);
    __OCCUPANCY.Caption := formatFloat('#,##0.00 %', OCC);
    __ADR.Caption := formatFloat('#,##0.00', ADR);
    __REVPAR.Caption := formatFloat('#,##0.00', REVPAR);
    __ROOMSSOLD.Caption := inttostr(RoomsSold);
  end;

end;

CONST
  BusyRefreshingTodaysGrid: boolean = false;

procedure TfrmMain.RefreshGrid(Days: integer = 0);
var
  needsRefresh: boolean;
begin
  if BusyRefreshingTodaysGrid then
  begin
    timRetryRefresh.Enabled := false;
    timRetryRefresh.Tag := Days;
    timRetryRefresh.Enabled := true;
    exit;
  end;
  BusyRefreshingTodaysGrid := true;
  try
    if (ABS(Days) > 7) then
      Days := 0;

    UpdatePanelText;
    if ViewMode = vmOneDay then
    begin
      // Sækja herbergi
      g.qDebug1 := 'RefreshGrid - ' + zDebug1;
      StartOneDay;
      RefreshStats;
    end;
    if ViewMode = vmPeriod then
    begin
      // if (Days < 0) then
      Days := 0;
      if Days = 0 then
      begin
        lblLoading.Show;
        lblLoading.Update;
      end;
      grPeriodRooms.BeginUpdate;
      grPeriodRooms_NO.BeginUpdate;
      try

        if Days = 0 then
        begin
          Period_SetDateHeads;
          Period_FillEmptyResCells;

          // must come before FillResCell
          grNoRooms_ClearAll;
          grNoRooms_FillEmptyResCells;
        end
        else
        begin
          Period_UnMergeGrid;
          grNoRooms_UnMergeGrid;
        end;
        Period_FillResCells(Days);
        Period_MergeGrid;
        grNoRooms_MergeGrid;
        grAutoSizeGrids;
        if btnOccupancyView.Down then
        begin
          embOccupancyView.ShowOccupancy(zDateFrom, zDateFrom + zNights);
          PostMessage(handle, WM_REFRESH_PERIOD_VIEW_BOTTOM, 0, 0);
        end;
      finally
        lblLoading.Hide;
        grPeriodRooms.endUpdate;
        grPeriodRooms_NO.endUpdate;
        grPeriodRooms.Invalidate;
      end;
      RefreshStats;

    end
    else if ViewMode = vmGuestList then
    begin
      refreshGuestList;
    end
    else if ViewMode = vmDashboard then
    begin
      frmDaysStatistics.ViewDate := dtDate.Date;
      timGetRoomStatuses.Tag := trunc(dtDate.Date);
      timGetRoomStatuses.Enabled := true;
    end
    else if ViewMode = vmRateQuery then
    begin
      PostMessage(handle, WM_SET_DATE_FROM_MAIN, 0, trunc(dtDate.Date));
    end
    else
    begin
      // **
    end;
  finally
    BusyRefreshingTodaysGrid := false;
  end;
end;

procedure TfrmMain.dtDateModified(Sender: TObject);
begin
  // 99 DisplayDate(dtDate.Date);
end;

procedure TfrmMain.dtMainHeaderPropertiesChange(Sender: TObject);
begin
  dtDateChange(dtDate);
end;

procedure TfrmMain.dtDateKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_Return then
  begin
    // postMessage(Handle, WM_StartUpLists, 0, 0);
    g.qDebug1 := 'dtDateKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState);)';
    RefreshGrid;
    Key := 0;
  end;
end;

// ******************************************************************************
// menu

function TfrmMain.IsRoomReserved(RoomNumber: string; iRes, iRoom: integer): boolean;
var
  i, l: integer;
begin
  result := false;
  for i := 0 to ReservationsModel.ReservationCount - 1 do
  begin
    for l := 0 to ReservationsModel.Reservations[i].RoomCount - 1 do
    begin
      if (i <> iRes) or (l <> iRoom) then
      begin
        if ReservationsModel.Reservations[i].Rooms[l].RoomNumber = RoomNumber then
        begin
          result := true;
          break;
        end;
      end;
    end;
    if result then
      break;
  end;
end;

procedure TfrmMain.mlLanguagesAfterLanguageChanged(Sender: TObject; NewLanguage: Byte);
begin
  // **  Exit1.caption := '-';
end;

procedure TfrmMain.mmnuOneDayGridPopup(Sender: TObject);
begin
  ApplicationCancelHint;
  case tabsView.TabIndex of
    0:
      mnuItemCopyReservationToClipboard.Enabled := zOneDay_ResIndex <> -1;
    1:
      mnuItemCopyReservationToClipboard.Enabled := isCurrentPeriodCellWithReservation;
  end;
  mnuItemPasteReservationFromClipboard.Enabled := ClipboardText.StartsWith(ROOMER_COPY_RESERVATION);
  if GetSelectedRoomInformation then
    mnuConfirmBooking.Enabled := (_ResStatus = rsAlotment) AND mnuConfirmBooking.Enabled AND (NOT OffLineMode);

end;

procedure TfrmMain.mmoMessageAnchorClick(Sender: TObject; Anchor: string);
begin
  ShellExecute(0, 'OPEN', PChar(Anchor), '', '', SW_SHOWNORMAL);
end;

procedure TfrmMain.timBlinkerTimer(Sender: TObject);
begin
  timBlinker.Enabled := false;
  try
    if timBlinker.Tag mod 2 = 0 then
    begin
      imgBlinker.Hide;
      imgBlinker.Update;
      timBlinker.Interval := 100;
    end
    else
    begin
      imgBlinker.Show;
      imgBlinker.Update;
      timBlinker.Interval := 200;
    end;
    timBlinker.Tag := timBlinker.Tag + 1;
  finally
    timBlinker.Enabled := timBlinker.Tag < 17;
  end;
end;

procedure TfrmMain.BlinkRoom;
var
  i: integer;
  box: TRect;
  pnt: TPoint;
begin
  // -- Position the blinker...
  box := grOneDayRooms.CellRect(grOneDayRooms.col, grOneDayRooms.row);
  pnt.X := box.Left;
  pnt.Y := box.Top;
  imgBlinker.Left := pnt.X;
  imgBlinker.Top := pnt.Y + grOneDayRooms.RowHeights[grOneDayRooms.row] div 2 - imgBlinker.Height div 2;
  imgBlinker.BringToFront;

  // -- Now blink...
  timBlinker.Tag := 0;
  timBlinker.Interval := 200;
  timBlinker.Enabled := true;
end;

procedure TfrmMain.__PanGridsHeaderDblClick(Sender: TObject);
begin
  dtDate.Date := trunc(now);
  // g.qDebug1 := 'panGridsHeaderDblClick(Sender : TObject);';
  // RefreshGrid;
end;

procedure TfrmMain.mnuRemoveRoomNumberOfThisRoomClick(Sender: TObject);
begin
  OneDay_RemoveRoom(grPeriodRooms, false);
end;

procedure TfrmMain.mnuRoomListForReservationClick(Sender: TObject);
begin
  // **
  OneDay_ShowTheNameList
end;

procedure TfrmMain.N12Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to mnuFilterLocation.Items.Count - 1 do
    mnuFilterLocation.Items[i].Checked := false;
  edtSearch.Text := '';
  TMenuItem(Sender).Checked := NOT TMenuItem(Sender).Checked;
  btnFilter.ImageIndex := ABS(Ord(LocationFilter(false)));
  btnFilter.Tag := TMenuItem(Sender).Tag;
  OneDay_DisplayGrid;
end;

procedure TfrmMain.NewReservation1Click(Sender: TObject);
begin
  _NewReservation;
end;

procedure TfrmMain.mnuGlobalReservationChangesClick(Sender: TObject);
begin
  OneDay_GlobalChange;
  zDebug1 := 'mnuGlobalReservationChangesClick(Sender : TObject)';
  RefreshGrid;
end;

const
  bAlreadyReading: boolean = false;


// ******************************************************************************
//
//
//
//
// ******************************************************************************

procedure TfrmMain.OneDay_GetResAndRoom_IDX(var idxReservation, idxRoom: integer);
begin
  if zOneDay_bNewGuest then
  begin
    GetArrivingGuestIndexes(idxRoom, idxReservation, grOneDayRooms.col, grOneDayRooms.row);
  end
  else
  begin
    GetLeavingGuestIndexes(idxRoom, idxReservation, grOneDayRooms.col, grOneDayRooms.row);
    // Rooms Index
  end;
end;

procedure TfrmMain.OneDay_Refresh;
begin
  BusyOn;
  try
    zGotoCol := 0;
    zGotoRow := 0;
    OneDay_DisplayGrid;
  finally
    BusyOff;
  end;
end;

procedure TfrmMain.OneDay_NewGuestCoordinates(RoomNumber: string; var iRes, iRoom: integer);
var
  i, l: integer;

  bFound: boolean;
begin
  bFound := false;
  for i := 0 to ReservationsModel.ReservationCount - 1 do
  begin
    for l := 0 to ReservationsModel.Reservations[i].RoomCount - 1 do
    begin
      if (i <> iRes) or (l <> iRoom) then
      begin
        if ReservationsModel.Reservations[i].Rooms[l].RoomNumber = RoomNumber then
        begin
          // if ReservationsModel.Reservations[ i ].Rooms[ l ].ResStatus = rsReservations then begin
          if ReservationsModel.Reservations[i].Rooms[l].GuestCount > 0 then
          begin
            iRoom := l;
            iRes := i;
            bFound := true;
            break;
          end;
          // end;
        end;
      end;
    end;
    if bFound then
      break;
  end;
end;

function TfrmMain.OneDay_GetIsLeftOrRight(iCol: integer): integer;
begin
  if iCol > 5 then
    result := 2
  else
    result := 1;
end;

function TfrmMain.OneDay_isATakenType(ACol, ARow: integer): boolean;
begin
  result := false;
  if (ARow < 1) or (ARow > 500) then
    exit;
  if (OneDay_GetIsLeftOrRight(ACol) < 1) or (OneDay_GetIsLeftOrRight(ACol) > 2) then
    exit;

  result := (zOneDay_bSelectedNonRooms[ARow, OneDay_GetIsLeftOrRight(ACol)] <> -1);
end;

function TfrmMain.ActiveGrid: TAdvStringGrid;
begin
  result := CurrentlyActiveGrid;
end;

function TfrmMain.OneDay_GetReservation(var iReservation, iRoom: integer; var sRoom: string): boolean;
var
  idxReservation: integer;
  idxRoom: integer;
  sGuest: string;
  iRoomCount: integer;
  GuestCount: integer;

begin
  result := false;
  if NOT assigned(CurrentlyActiveGrid) then
    exit;

  iReservation := -1;
  iRoom := -1;
  sRoom := '';
  // --

  if zOneDay_ResIndex = -1 then
    exit;
  if ActiveGrid.row < 1 then
    exit;

  // --
  if zOneDay_bNewGuest then
  begin
    idxReservation := zOneDayResPointers[ActiveGrid.row].ptrRooms[OneDay_GetIsLeftOrRight(ActiveGrid.col), 1];
    // Reservation Index
    idxRoom := zOneDayResPointers[ActiveGrid.row].ptrRooms[OneDay_GetIsLeftOrRight(ActiveGrid.col), 2];
    // Rooms Index
    OneDay_NewGuestCoordinates(ReservationsModel.Reservations[idxReservation].Rooms[idxRoom].RoomNumber, idxReservation, idxRoom);
  end
  else
  begin
    idxReservation := zOneDayResPointers[ActiveGrid.row].ptrRooms[OneDay_GetIsLeftOrRight(ActiveGrid.col), 1];
    // Reservation Index
    idxRoom := zOneDayResPointers[ActiveGrid.row].ptrRooms[OneDay_GetIsLeftOrRight(ActiveGrid.col), 2];
    // Rooms Index
  end;

  iReservation := idxReservation;
  iRoom := idxRoom;

  sGuest := '';
  GuestCount := 0;

  if idxReservation >= 0 then
  begin
    try
      GuestCount := ReservationsModel.Reservations[idxReservation].Rooms[idxRoom].GuestCount;
    except
      GuestCount := 0;
    end;

    if GuestCount > 0 then
    begin
      sGuest := ReservationsModel.Reservations[idxReservation].Rooms[idxRoom].Guests[0].GuestName;
    end;

    try
      iRoomCount := ReservationsModel.Reservations[idxReservation].RoomCount;
    except
      iRoomCount := 0;
    end;

    sRoom := Format(GetTranslatedText('shOneDayGetReservationRoom'), [ReservationsModel.Reservations[idxReservation].Rooms[idxRoom].RoomNumber,
      ReservationsModel.Reservations[idxReservation].name, iRoomCount, sGuest]);
  end;

end;

function TfrmMain.OneDay_RoomReservedName(RoomNumber: string; iRes, iRoom: integer): string;
var
  i, l: integer;
begin
  result := '';
  for i := 0 to ReservationsModel.ReservationCount - 1 do
  begin
    for l := 0 to ReservationsModel.Reservations[i].RoomCount - 1 do
    begin
      if (i <> iRes) or (l <> iRoom) then
      begin
        if ReservationsModel.Reservations[i].Rooms[l].RoomNumber = RoomNumber then
        begin
          // if ReservationsModel.Reservations[ i ].Rooms[ l ].ResStatus = rsReservations then begin
          if ReservationsModel.Reservations[i].Rooms[l].GuestCount > 0 then
          begin
            result := ReservationsModel.Reservations[i].Rooms[l].Guests[0].GuestName;
            break;
          end;
          // end;
        end;
      end;
    end;
    if result <> '' then
      break;
  end;
end;

procedure TfrmMain.OneDay_RemoveRoom(_grid: TAdvStringGrid; bAll: boolean);
begin
  if zOneDay_ResIndex = -1 then
    exit;

  if GetSelectedRoomInformation then
  begin
    d.SetAsNoRoomEnh(_iRoomReservation, bAll);
    if (ViewMode = vmOneDay) OR (ViewMode = vmPeriod) then
      RefreshGrid;
  end
end;

procedure TfrmMain.OneDay_GlobalChange;
begin
end;

// ==============================================================================
// Actions regarding Reservation
//
// ==============================================================================

// ------------------------------------------------------------------------------
// +2008.02.20 - Added 5Day Grid support
// +2008.02.20 - Fixed Acces Vailation when closing
//
// ------------------------------------------------------------------------------
procedure TfrmMain.MakeNewReservation(dtDateFrom, dtDateTo: TdateTime);
begin
  // Moved
end;

// ------------------------------------------------------------------------------
// +2008.02.20 - Added 5Day Grid support
//
//
// - Changes for all rooms in the reservation
// ------------------------------------------------------------------------------
procedure TfrmMain.Open_RES_edForm(_grid: TAdvStringGrid);
begin
  if GetSelectedRoomInformation then
  begin
    if EditReservation(_iReservation, _iRoomReservation) then
    begin
    end;
  end;
end;

// ------------------------------------------------------------------------------
// +2008.02.20 - Added Period Grid support
//
// ------------------------------------------------------------------------------
procedure TfrmMain.Open_RR_EdForm(_grid: TAdvStringGrid);
var
  Room: String;
begin
  if GetSelectedRoomInformation then
  begin
    Room := '';
    g.openResDates(_iReservation, _iRoomReservation, Room, _Arrival, _Departure, 1);
    if ViewMode = vmOneDay then
    begin
      zOneDay_bMouseDown := false;
      if grOneDayRooms.dragging then
        grOneDayRooms.EndDrag(false);
      RefreshGrid;
    end
    else if ViewMode = vmPeriod then
      RefreshGrid;
  end;
end;

procedure TfrmMain.P1Click(Sender: TObject);
var
  IniPath: String;
  Extra: String;
  Grid: TAdvStringGrid;
begin
  Extra := inttostr(tabsView.TabIndex);
  IniPath := TPath.Combine(LocalAppDataPath, 'Roomer\Ini');
  forceDirectories(IniPath);
  IniPath := TPath.Combine(IniPath, 'PrintGuests_' + Extra + '_' + ExtractFilename(GetRoomerIniFilename));
  case tabsView.TabIndex of
    0:
      Grid := grOneDayRooms;
    1:
      Grid := grPeriodRooms;
  else
    Exit;
  end;
  dlgAdvGridPrintSettings.Grid := Grid;
  dlgAdvGridPrintSettings.IniFile := IniPath;
  if dlgAdvGridPrintSettings.Execute then
  begin
    Grid.PrintSettings.TitleText := 'GUEST STATUS FOR ' + FormatDateTime('dd-mm-yyyy', now);
    Grid.Print;
  end;
end;

procedure TfrmMain.P5Click(Sender: TObject);
begin
  if GetSelectedRoomInformation AND
     GroupGuests(_iReservation,_iRoomReservation) then
       btnRefreshOneDay.Click;
end;

procedure TfrmMain.CreateProvideAllotment(Reservation: integer; showDetails: boolean = true);
var
  CustomerInfo: recCustomerHolderEX;
  doShowProfile: boolean;
  Daysleft: integer;
  missingReason: integer;
  resMedhod: TResMedhod;
  priceFound: boolean;
  iReservation: integer;
  oNewReservation: TNewReservation;
  oRestReservation: TNewReservation;

  s: string;
  i: integer;

  function OpenProvideAllotment(var oNewReservation, oRestReservation: TNewReservation; var restCount: integer): boolean;
  begin
    result := false;
    Application.CreateForm(TfrmAllotmentToRes, frmAllotmentToRes);
    try
      frmAllotmentToRes.zReservation := Reservation;
      frmAllotmentToRes.zRestCount := restCount;
      frmAllotmentToRes.oNewReservation := oNewReservation;
      frmAllotmentToRes.oRestReservation := oRestReservation;
      if frmAllotmentToRes.ShowModal = mrOK then
      begin
        oNewReservation := frmAllotmentToRes.oNewReservation;
        oRestReservation := frmAllotmentToRes.oRestReservation;
        restCount := frmAllotmentToRes.zRestCount;
        result := true;
      end;
    finally
      frmAllotmentToRes.Free;
      frmAllotmentToRes := nil;
    end;
  end;

var
  restCount: integer;
  trxName: String;

begin
  d.roomerMainDataSet.SystemStartTransaction;
  try
    restCount := 0;
    try
      oNewReservation := TNewReservation.Create(g.qHotelCode, g.qUser);
    Except
      // ATH Log exception
    end;

    try
      oRestReservation := TNewReservation.Create(g.qHotelCode, g.qUser);
    Except
      // ATH Log exception
    end;

    try
      priceFound := true;
      // QuickResPeriodRoomObj(oNewReservation);
      // Period_GetNewResDates(resDateFrom);

      oNewReservation.resMedhod := rmAllotment;
      oNewReservation.isQuick := false;

      oRestReservation.resMedhod := rmAllotment;
      oRestReservation.isQuick := false;

      if not OpenProvideAllotment(oNewReservation, oRestReservation, restCount) then
      begin
        showmessage(GetTranslatedText('shTx_Main_ReservationCancelled'));
        exit;
      end;

      // debugMessage(inttostr(restcount));

      if not oNewReservation.ShowProfile then
        exit;

      Screen.Cursor := crHourglass;
      try
        oNewReservation.CreateReservation(Reservation, false);
      finally
        Screen.Cursor := crDefault;
      end;

      iReservation := oNewReservation.Reservation;
      if iReservation > 0 then
      begin
        if restCount > 0 then
        begin
          Screen.Cursor := crHourglass;
          try
            oRestReservation.CreateReservation(-1, false);
          finally
            Screen.Cursor := crDefault;
          end;
        end;

        if oNewReservation.ShowProfile then
        begin
          EditReservation(iReservation, 0)
        end
        else
        begin
          RefreshGrid;
        end;
      end;
    finally
      if oNewReservation <> nil then
        freeandNil(oNewReservation);
      if oRestReservation <> nil then
        freeandNil(oRestReservation);
    end;
    d.roomerMainDataSet.SystemCommitTransaction;
  except
    d.roomerMainDataSet.SystemRollbackTransaction;
    raise;
  end;
end;

procedure TfrmMain.pmnuProvideAllotmentClick(Sender: TObject);
begin
  if not IsValidCellSelected then
    exit;

  if GetSelectedRoomInformation then
    CreateProvideAllotment(_iReservation);
end;

procedure TfrmMain.pmnuReservationRoomListClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  OneDay_ShowTheNameList
end;

function TfrmMain.ReservationIdInClipboard(var hotelId: String; var resId: integer): boolean;
var
  ClipboardText, strTemp: String;
begin
  result := false;
  ClipboardText := Clipboard.AsText;
  resId := -1;
  hotelId := d.roomerMainDataSet.hotelId;

  if ClipboardText.StartsWith(ROOMER_COPY_RESERVATION) then
  begin
    strTemp := Copy(ClipboardText, length(ROOMER_COPY_RESERVATION) + 1);
    hotelId := KeyValueFromString(strTemp, 'hotel');
    resId := StrToInt(KeyValueFromString(strTemp, 'id'));
    result := true;
  end;
end;

procedure TfrmMain.mnuItemPasteReservationFromClipboardClick(Sender: TObject);
var
  iReservation: integer;
  Date: TdateTime;
  hotelId: String;
begin
  case tabsView.TabIndex of
    0:
      Date := dtDate.Date;
    1:
      begin
        if (grPeriodRooms.col < grPeriodRooms.FixedCols) then
          exit;
        Date := Period_ColToDate(grPeriodRooms.col);
      end;
  else
    Exit;
  end;

  if ReservationIdInClipboard(hotelId, iReservation) then
  begin
    d.roomerMainDataSet.SystemCopyReservationFromHotel(hotelId, iReservation, Date);
    ShowTimelyMessage(Format(GetTranslatedText('shTx_FrmMain_PastedReservationFromClipboard'), [iReservation]));
    btnRefresh.Click;
  end
  else
    ShowTimelyMessage(GetTranslatedText('shTx_FrmMain_NoCopiedReservationFoundInClipboard'));
end;

// ------------------------------------------------------------------------------
// +2008.02.20 - Added 5Day Grid support
//
// ------------------------------------------------------------------------------
procedure TfrmMain.OneDay_EditPerson;
var
  _grid: TAdvStringGrid;
  theData: recPersonHolder;

begin
  if GetSelectedRoomInformation then
  begin
    initPersonHolder(theData);
    theData.RoomReservation := _iRoomReservation;
    theData.Reservation := _iReservation;
    theData.name := _Name;

    if openGuestProfile(actNone, theData) then
      if (ViewMode = vmOneDay) OR (ViewMode = vmPeriod) then
        RefreshGrid;

  end;

end;

// ------------------------------------------------------------------------------
// +080226 - Added 5day Grid support
//
//
// ------------------------------------------------------------------------------

function TfrmMain.isCurrentPeriodCellWithReservation: boolean;
begin
  result := assigned(grPeriodRooms.Objects[grPeriodRooms.col, grPeriodRooms.row]) AND (grPeriodRooms.Objects[grPeriodRooms.col, grPeriodRooms.row] IS TresCell)
    AND (TresCell(grPeriodRooms.Objects[grPeriodRooms.col, grPeriodRooms.row]).Reservation <> -1);
end;

procedure TfrmMain.mnuItemCopyReservationToClipboardClick(Sender: TObject);
begin
  if GetSelectedRoomInformation then
    if _iReservation >= 0 then
      CopyReservation(_iReservation);
end;

procedure TfrmMain.mnuItmColorCodeRoomClick(Sender: TObject);
var
  ASet: TRoomerDataSet;
  iResult: integer;
begin
  //
  if GetSelectedRoomInformation then
  begin
    iResult := OpenColorSelectionDialog(_ColorId, _ColorValue);
    if iResult <> mrCancel then
    begin
      ReservationsModel.Reservations[_idxReservation].Rooms[_idxRoomReservation].colorId := _ColorId;
      ReservationsModel.Reservations[_idxReservation].Rooms[_idxRoomReservation].CodedColor := _ColorValue;
      ASet := CreateNewDataSet;
      if iResult = mrOK then
        ASet.DoCommand(Format('UPDATE roomreservations SET colorId=%d WHERE RoomReservation=%d', [_ColorId, _iRoomReservation]))
      else if iResult = mrAbort then
        ASet.DoCommand(Format('UPDATE roomreservations SET colorId=NULL WHERE RoomReservation=%d', [_iRoomReservation]));

      if (ViewMode = vmOneDay) OR (ViewMode = vmPeriod) then
        RefreshGrid;
    end;
  end;

end;

procedure TfrmMain.C2Click(Sender: TObject);
begin
  TMenuItem(Sender).Checked := NOT TMenuItem(Sender).Checked;
  btnFilter.ImageIndex := ABS(Ord(LocationFilter(false)));
  btnFilter.Tag := TMenuItem(Sender).Tag;
  checkFilterStatuses;
  RefreshGrid;
end;

procedure TfrmMain.C4Click(Sender: TObject);
var
  iRoomReservation: integer;
  sText, status, room, name: String;
begin
  if mAllReservations.eof OR mAllReservations.BOF then
    exit;
  iRoomReservation := mAllReservations['RoomReservation'];
  name := mAllReservations['ReservationName'];
  room := mAllReservations['Room'];
  status := mAllReservations['Room'];

  if g.qWarnCheckInDirtyRoom AND (NOT ((status = 'R') OR (status = 'C'))) then
  begin
    sText := format(getTranslatedText('shTx_Various_RoomNotClean'), [room]);
    if MessageDlg(sText, mtWarning, [mbYes, mbCancel], 0) <> mrYes then exit;
  end;

  CheckInARoom(name, iRoomReservation);
end;

procedure TfrmMain.C5Click(Sender: TObject);
var
  iRoomReservation, iReservation: integer;
  Room: String;
begin
  if mAllReservations.eof OR mAllReservations.BOF then
    exit;
  iRoomReservation := mAllReservations['RoomReservation'];
  iReservation := mAllReservations['Reservation'];
  Room := mAllReservations['Room'];
  CheckOutARoom(Room, iRoomReservation, iReservation);
end;

procedure TfrmMain.C6Click(Sender: TObject);
var
  rSet: TRoomerDataSet;
begin
  if GetSelectedRoomInformation then
  begin
    // rSet := d.roomerMainDataSet.ActivateNewDataset
    // (d.roomerMainDataSet.SystemFreeQuery(Format('SELECT r.ContactEmail FROM reservations r WHERE r.Reservation=%d', [_iReservation])));
    // try
    // rSet.first;
    // if NOT rSet.eof then
    // begin
    // if trim(rSet['ContactEmail']) <> '' then
    // begin
    if SendCancellationConfirmation(_iReservation) then
      MessageDlg(GetTranslatedText('shTxCancellationEmailHasBeenSent'), mtConfirmation, [mbOk], 0);
    // end
    // else
    // MessageDlg(GetTranslatedText('shTxReservationHasNoContactEmailAddress'), mtError, [mbOk], 0);
    // end;
    // finally
    // freeandNil(rSet);
    // end;
  end;
end;

procedure TfrmMain.I1Click(Sender: TObject);
var
  iReservation, iRoomReservation: integer;
begin
  if mAllReservations.eof OR mAllReservations.BOF then
    exit;
  iRoomReservation := mAllReservations['RoomReservation'];
  iReservation := mAllReservations['Reservation'];
  EditInvoice(iReservation, iRoomReservation, 0, 0, 0, 0, false, true, false);
end;

procedure TfrmMain.G4Click(Sender: TObject);
var
  iReservation: integer;
begin
  if mAllReservations.eof OR mAllReservations.BOF then
    exit;
  iReservation := mAllReservations['Reservation'];
  EditInvoice(iReservation, 0, 0, 0, 0, 0, false, true, false);
end;

function TfrmMain.GetActivePeriodGrid: TAdvStringGrid;
begin
  if ActiveControl = grPeriodRooms then
    result := grPeriodRooms
  else
    result := grPeriodRooms_NO;
end;

procedure TfrmMain.RemoveAReservation;
begin
  if GetSelectedRoomInformation then
  begin
    g.OpenRemoveReservation(_iRoomReservation);

    if (ViewMode = vmOneDay) OR (ViewMode = vmPeriod) then
      RefreshGrid;
  end;

end;

procedure TfrmMain.ConfirmABooking;
begin
  if GetSelectedRoomInformation then
  begin
    g.ConfirmAllottedReservation(_iReservation);

    if (ViewMode = vmOneDay) OR (ViewMode = vmPeriod) then
      RefreshGrid;
  end;
end;

procedure TfrmMain.CancelAReservation;
begin
  if GetSelectedRoomInformation then
  begin
    // d.roomerMainDataSet.SystemCancelReservation(_iReservation, Format('User %s changed state to cancelled on %s',
    // [d.roomerMainDataSet.userName, DateTimeToStr(now)]));

    if CancelBookingDialog(_iReservation) then
      if (ViewMode = vmOneDay) OR (ViewMode = vmPeriod) then
        RefreshGrid;
  end;
end;

// ------------------------------------------------------------------------------
procedure TfrmMain.OneDay_ShowTheNameList;
var
  idxReservation, Reservation, iRoom: integer;
begin
  if ViewMode = vmOneDay then
  begin
    if zOneDay_ResIndex = -1 then
      exit;
    OneDay_GetResAndRoom_IDX(idxReservation, iRoom);
    Reservation := ReservationsModel.Reservations[idxReservation].Reservation;
    // ShowNameList(Reservation, zOneDay_dtDate);

    frmResGuestList := TfrmResGuestList.Create(self);
    try
      frmResGuestList.zReservation := Reservation;
      frmResGuestList.ShowModal;
      if frmResGuestList.ModalResult = mrOK then;
    finally
      frmResGuestList.Free;
      frmResGuestList := nil;
    end;
  end
  else if ViewMode = vmGuestList then
    showmessage(GetTranslatedText('sh1007'))
  else if ViewMode = vmPeriod then
    showmessage(GetTranslatedText('sh1008'));
end;

// ------------------------------------------------------------------------------
// +080223 - Added 5day Grid support
//
// ------------------------------------------------------------------------------
procedure TfrmMain.OneDay_CheckIn;
var
  Execute: boolean;
  bContinue: boolean;
  s : String;
begin
  Execute := false;
  if GetSelectedRoomInformation then
  begin
    s := g.oRooms.FindRoomStatus(_Room);
    if g.qWarnCheckInDirtyRoom AND (NOT ((s = 'R') OR (s = 'C'))) then begin
      s := format(getTranslatedText('shTx_Various_RoomNotClean'), [_Room]);
      if MessageDlg(s, mtWarning, [mbYes, mbCancel], 0) <> mrYes then exit;
    end;

    if _ResStatus = rsBlocked then
      exit;

    Execute := true;
    // Ef ekki Pöntun (P)
    if _ResStatus <> rsReservations then
    begin
      if _ResStatus = rsAlotment then
        _ResStatus := rsReservations
      else if _ResStatus = rsOverbooked then
        _ResStatus := rsReservations
      else if _ResStatus = rsTmp1 then // *HJ 140206
        _ResStatus := rsReservations
      else if _ResStatus = rsTmp2 then // *HJ 140206
        _ResStatus := rsReservations
      else
        Execute := false;
    end;

    if Execute then
    begin
      if ctrlGetBoolean('CheckinWithDetailsDialog') OR (MessageDlg(Format(GetTranslatedText('shCheckRoom'), [_Name]), mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
      begin

        ShowAlertsForReservation(_iReservation, _iRoomReservation, atCHECK_IN);

        bContinue := true;
        if _NoRoom then
          bContinue := OneDay_DoProvideRoom;

        if bContinue then
        begin
          if (NOT ctrlGetBoolean('CheckinWithDetailsDialog')) OR OpenGuestCheckInForm(_iRoomReservation) then
            d.CheckInGuest(_iRoomReservation);
          if (ViewMode = vmOneDay) OR (ViewMode = vmPeriod) then
            RefreshGrid;
        end;
      end
    end
    else
      showmessage(GetTranslatedText('sh1010'));
  end;
end;

procedure TfrmMain.CheckOutARoom(Room: String; iRoomReservation, iReservation: integer);
begin
  if ctrlGetBoolean('CheckOutWithPaymentsDialog') OR
     (MessageDlg(Format(GetTranslatedText('shCheckOutSelectedRoom'), [Room]), mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    ShowAlertsForReservation(iReservation, iRoomReservation, atCHECK_OUT);
    if ctrlGetBoolean('CheckOutWithPaymentsDialog') then
      CheckoutGuest(iReservation, iRoomReservation, Room)
    else
      d.CheckOutGuest(iRoomReservation, Room);
    if (ViewMode = vmOneDay) OR (ViewMode = vmPeriod) then
      RefreshGrid;
  end

//function TfrmMain.CheckOutARoom(Room: String; iRoomReservation, iReservation: integer): boolean;
//begin
//  if ctrlGetBoolean('CheckOutWithPaymentsDialog') OR
//     (MessageDlg(Format(GetTranslatedText('shCheckOutSelectedRoom'), [Room]), mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
//  begin
//    ShowAlertsForReservation(_iReservation, _iRoomReservation, atCHECK_OUT);
//    if ctrlGetBoolean('CheckOutWithPaymentsDialog') then
//      CheckoutGuest(_iReservation, _iRoomReservation, _Room)
//    else
//      d.CheckOutGuest(_iRoomReservation, _Room);
//    if (ViewMode = vmOneDay) OR (ViewMode = vmPeriod) then
//      RefreshGrid;
//  end


  //
//
//  if MessageDlg(Format(GetTranslatedText('shCheckOutSelectedRoom'), [Room]), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
//  begin
//    ShowAlertsForReservation(_iReservation, _iRoomReservation, atCHECK_OUT);
//    d.CheckOutGuest(iRoomReservation, Room);
//    RefreshGrid;
//  end;
end;

function TfrmMain.CheckInARoom(name: String; iRoomReservation: integer): boolean;
begin
  result := false;
  if ctrlGetBoolean('CheckinWithDetailsDialog') OR (MessageDlg(Format(GetTranslatedText('shCheckRoom'), [name]), mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    ShowAlertsForReservation(_iReservation, _iRoomReservation, atCHECK_IN);
    if (NOT ctrlGetBoolean('CheckinWithDetailsDialog')) OR OpenGuestCheckInForm(iRoomReservation) then
      d.CheckInGuest(iRoomReservation);
    RefreshGrid;
  end;
end;

// ------------------------------------------------------------------------------
// +080223 - Added 5day Grid support
//
// ------------------------------------------------------------------------------
procedure TfrmMain.CheckInGroup;
var
  lstRoomReservations: TStringList;
  lstRoomReservationsStatus: TStringList;
  ReservationCount: integer;
  i: integer;
begin
  lstRoomReservations := TStringList.Create;
  lstRoomReservationsStatus := TStringList.Create;
  try
    if GetSelectedRoomInformation then
    begin

      if _ResStatus = rsBlocked then
        exit;

      ReservationCount := GetReservationRRList(_iReservation, lstRoomReservations, lstRoomReservationsStatus);
      if ReservationCount < 1 then
        exit; // ==>
      ShowAlertsForReservation(_iReservation, 0, atCHECK_IN);
      if (MessageDlg(Format(GetTranslatedText('shCheckInGroupOfRoom'), [_Room]), mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
      begin
        for i := 0 to ReservationCount - 1 do
        begin
          if UpperCase(lstRoomReservationsStatus[i]) = 'P' then
          begin
            _iRoomReservation := StrToInt(lstRoomReservations[i]);
            ShowAlertsForReservation(0, _iRoomReservation, atCHECK_IN);
            d.CheckInGuest(_iRoomReservation)
          end;
        end;
        if (ViewMode = vmOneDay) OR (ViewMode = vmPeriod) then
          RefreshGrid;
      end;
    end;
  finally
    lstRoomReservations.Free;
    lstRoomReservationsStatus.Free;
  end;
end;

// ------------------------------------------------------------------------------
// +080223 - Added 5day Grid support
//
// ------------------------------------------------------------------------------
procedure TfrmMain.OneDay_CheckOut;
var
  Execute: boolean;
  sErr: string;
  sPrompt: string;

begin
  Execute := false;
  if GetSelectedRoomInformation then
  begin

    sErr := '';
    if _ResStatus = rsBlocked then
      sErr := sErr + { 1013 } GetTranslatedText('sh1013') + ' '
    else if _ResStatus = rsDeparted then
      sErr := sErr + { 1014 } GetTranslatedText('sh1014') + ' '
    else if _ResStatus = rsReservations then
      sErr := sErr + { 1015 } GetTranslatedText('sh1015') + ' '
    else if _ResStatus = rsOverbooked then
      sErr := sErr + { 1016 } GetTranslatedText('sh1016') + ' '
    else if _ResStatus = rsReserved then
      sErr := sErr + { 1017 } GetTranslatedText('sh1017') + ' '
    else if _ResStatus = rsAlotment then
      sErr := sErr + { 1018 } GetTranslatedText('sh1018') + ' '
    else if _ResStatus = rsNoShow then
      sErr := sErr + { 1019 } GetTranslatedText('sh1019') + ' '
    else if _ResStatus = rsCanceled then // *HJ 140206
      sErr := sErr + { 1019 } GetTranslatedText('sh1020') + ' '
    else if _ResStatus = rsTmp1 then // *HJ 140206
      sErr := sErr + { 1019 } GetTranslatedText('sh1021') + ' '
    else if _ResStatus = rsTmp2 then // *HJ 140206
      sErr := sErr + { 1019 } GetTranslatedText('sh1022') + ' ';

    Execute := sErr = '';

    // - í lagi rsGuests - Núverandi Gestur
    // - í lagi rsDeparting - Farandi

    if Execute then
    begin
      if ctrlGetBoolean('CheckOutWithPaymentsDialog') OR
         (MessageDlg(Format(GetTranslatedText('shCheckOutSelectedRoom'), [_Room]), mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
      begin
        ShowAlertsForReservation(_iReservation, _iRoomReservation, atCHECK_OUT);
        if ctrlGetBoolean('CheckOutWithPaymentsDialog') then
          CheckoutGuest(_iReservation, _iRoomReservation, _Room)
        else
          d.CheckOutGuest(_iRoomReservation, _Room);
        if (ViewMode = vmOneDay) OR (ViewMode = vmPeriod) then
          RefreshGrid;
      end
    end
    else
      showmessage(Format(GetTranslatedText('shCannotCheckoutRoom'), [sErr, _Room]));
  end;
end;

function TfrmMain.GetSelectedRoomInformation: boolean;
var
  rri: RecRRInfo;
  active: boolean;
  status: String;
begin
  result := false;
  if ViewMode = vmOneDay then
  begin
    if zOneDay_ResIndex = -1 then
      exit; // ===>>
    OneDay_GetResAndRoom_IDX(_idxReservation, _idxRoomReservation);
    rri := OneDay_GetResInfo(grOneDayRooms.col, grOneDayRooms.row, _idxReservation, _idxRoomReservation);
  end
  else if ViewMode = vmPeriod then
  begin
    rri := Period_GetResInfo(GetActivePeriodGrid.col, GetActivePeriodGrid.row, GetActivePeriodGrid.Tag);
  end;

  _iReservation := rri.Reservation;
  _iRoomReservation := rri.RoomReservation;
  _InvoiceIndex := rri.InvoiceIndex;

  _Arrival := rri.Arrival;
  _Departure := rri.Departure;
  active := rri.active;
  if not active then
    exit; // ===>>

  _Room := rri.Room;
  status := rri.resFlag;
  _ResStatus := g.StatusStrToResStatus(status);

  _NoRoom := Copy(_Room, 1, 1) = '<';

  if ViewMode = vmOneDay then
  begin
    _Name := ReservationsModel.Reservations[_idxReservation].name;
    if Not _NoRoom then
      _Name := Format('[%s] %s', [_Room, ReservationsModel.Reservations[_idxReservation].name]);
    if ReservationsModel.Reservations[_idxReservation].Rooms[_idxRoomReservation].GuestCount > 0 then
      _Guest := ReservationsModel.Reservations[_idxReservation].Rooms[_idxRoomReservation].Guests[0].GuestName;
    _ColorId := ReservationsModel.Reservations[_idxReservation].Rooms[_idxRoomReservation].colorId;
    _ColorValue := ReservationsModel.Reservations[_idxReservation].Rooms[_idxRoomReservation].CodedColor;

  end
  else
  begin
    _Name := rri.CustomerName;
    if NOT _NoRoom then
      _Name := Format('[%s] %s', [_Room, rri.CustomerName]);
    _Guest := rri.CustomerName + ' / ' + d.RR_GetFirstGuestName(_iRoomReservation);
  end;

  result := true;
end;

// ------------------------------------------------------------------------------
// +080223 - Added 5day Grid support
// +080224 - Added parameter invType 1= room  2 = group
// ------------------------------------------------------------------------------
procedure TfrmMain.OneDay_RoomInvoice(invType: integer);
begin
  if GetSelectedRoomInformation then
  begin
    case invType of
      1:
        begin
        end;
      2:
        begin
          _iRoomReservation := 0;
        end;
    end;

{$IFDEF DEBUG}
    if IsControlKeyPressed then
      EditInvoice2015(_iReservation, _iRoomReservation, 0, false, false, '', g.qExpandRoomRentOnInvoice)
    else
{$ENDIF}
      EditInvoice(_iReservation, _iRoomReservation, 0, _InvoiceIndex, 0, 0, false, true, false);
  end;
end;

// ------------------------------------------------------------------------------
// +080224 - Added 5day Grid support
//
// ------------------------------------------------------------------------------
procedure TfrmMain.OneDay_InvoiceInfo;
begin
end;

// ------------------------------------------------------------------------------
// +080225 - Added 5day Grid support
// +ToDo   - i 5Grid velja celluna - eða blikka openGoToRoomAndDate(var aRoom : string; aDate : TDate) : boolean;
// ------------------------------------------------------------------------------
procedure TfrmMain.OneDay_DoAJump(theRoom: string);
var
  i: integer;
begin
  if ViewMode = vmOneDay then
  begin
    if theRoom <> '' then
    begin
      for i := 1 to grOneDayRooms.RowCount - 1 do
      begin
        if Copy(grOneDayRooms.cells[0, i], 1, length(theRoom)) = theRoom then
        begin
          grOneDayRooms.col := 2;
          grOneDayRooms.row := i;
          zGotoCol := grOneDayRooms.col - 1;
          zGotoRow := grOneDayRooms.row;
          grOneDayRooms.Repaint;
          BlinkRoom;
          Update;
          break;
        end
        else if Copy(grOneDayRooms.cells[7, i], 1, length(theRoom)) = theRoom then
        begin
          grOneDayRooms.col := 9;
          grOneDayRooms.row := i;
          zGotoCol := grOneDayRooms.col - 1;
          zGotoRow := grOneDayRooms.row;
          grOneDayRooms.Repaint;
          BlinkRoom;
          Update;
          break;
        end;
      end;
    end;
  end
  else if ViewMode = vmPeriod then
  begin
    Period_GotoRoom(theRoom);
  end
  else
  begin
    exit; // ===>
  end;
end;

// ------------------------------------------------------------------------------
// +080225 - Setti í  5day Grid support en virkar ekki að fullu
// +ToDo   - Endurskrifa ProvideRoom
// ------------------------------------------------------------------------------
function TfrmMain.OneDay_DoProvideRoom: boolean;
var
  sNewRoom: string;
  Execute: boolean;
begin
  result := false;
  if GetSelectedRoomInformation then
  begin
    if _ResStatus = rsNoShow then
    begin
      MessageDlg(GetTranslatedText('shStatusIsNoShowFirstChange'), mtError, [mbOk], 0);
      exit;
    end;

    if ViewMode = vmOneDay then
    begin
      sNewRoom := ProvideARoom2(_iRoomReservation);
      if sNewRoom <> '' then
      begin
        RefreshGrid;
        result := true;
        OneDay_DoAJump(sNewRoom);
      end
      else
        RefreshGrid;
    end
    else if ViewMode = vmPeriod then
    begin
      sNewRoom := ProvideARoom2(_iRoomReservation);
      if sNewRoom <> '' then
      begin
        RefreshGrid;
        result := true;
      end;
    end;
  end;
end;

procedure TfrmMain.OneDay_DeleteRoomReservation;
begin
  if GetSelectedRoomInformation then
  begin
    if not g.OpenRemoveRoom(_iRoomReservation) then
      exit;

    if (ViewMode = vmOneDay) OR (ViewMode = vmPeriod) then
      RefreshGrid;
  end;
end;

// ******************************************************************************
// ******************************************************************************
// ******************************************************************************
// ******************************************************************************

procedure TfrmMain.OneDay_InvoicesPerRoom;
var
  iReservation, iRoom: integer;
begin
  // -- Anyone selected ?
  if zOneDay_ResIndex = -1 then
    exit;
  OneDay_GetResAndRoom_IDX(iReservation, iRoom);
  ShowFinishedInvoices2(itPerRoomRes, '', ReservationsModel.Reservations[iReservation].Rooms[iRoom].RoomRes);
end;

procedure TfrmMain.OneDay_InvoicesPerRes;
var
  iReservation, iRoom: integer;
begin
  if zOneDay_ResIndex = -1 then
    exit;
  OneDay_GetResAndRoom_IDX(iReservation, iRoom);
  ShowFinishedInvoices2(itPerReservation, '', ReservationsModel.Reservations[iReservation].Reservation);
end;

procedure TfrmMain.OneDay_InvoicesPerCustomer;
var
  iReservation: integer;
  iRoom: integer;
  sCustomer: string;
begin
  // -- Anyone selected ?
  if zOneDay_ResIndex = -1 then
    exit;
  OneDay_GetResAndRoom_IDX(iReservation, iRoom);

  sCustomer := ReservationsModel.Reservations[iReservation].customer;

  ShowFinishedInvoices2(itPerCustomer, sCustomer, -1

    );
end;

procedure TfrmMain.OneDay_AddToTaken(sType: string);
var
  i, l: integer;
  bFound: boolean;
begin
  bFound := false;

  for i := 0 to zOneDay_stlTakenTypes.Count - 1 do
  begin
    if trim(_strTokenAT(zOneDay_stlTakenTypes[i], '|', 0)) = trim(sType) then
    begin
      l := strtointDef(trim(_strTokenAT(zOneDay_stlTakenTypes[i], '|', 1)), 0);
      inc(l);
      zOneDay_stlTakenTypes[i] := trim(_strTokenAT(zOneDay_stlTakenTypes[i], '|', 0)) + '|' + inttostr(l) + '|' + inttostr(l);
      bFound := true;
      break;
    end;
  end;

  if not bFound then
    zOneDay_stlTakenTypes.Add(sType + '|1|1');
end;

procedure TfrmMain.PrepareFilterOrSearchDisplay(FreeRoomsFilterOn: boolean);
begin
  if not(SearchOrGroupFilterActive or FreeRoomsFilterOn) then
  begin
    lblSearchFilterActive.Hide;
    btnFilter.Hint := GetTranslatedText('shTx_NoFilterActive');
  end
  else
  begin
    lblSearchFilterActive.Show;
    if (edtSearch.Text <> '') AND (FilterActive) then
      btnFilter.Hint := Format(GetTranslatedText('shTx_SearchAndFilterActive'), [edtSearch.Text])
    else if (edtSearch.Text <> '') then
      btnFilter.Hint := Format(GetTranslatedText('shTx_SearchActive'), [edtSearch.Text])
    else if (FilterActive) then
      btnFilter.Hint := Format(GetTranslatedText('shTx_FilterActive'), [edtSearch.Text])
    else if (FreeRoomsFilterOn) then
      btnFilter.Hint := Format(GetTranslatedText('shTx_FreeRoomsFilterActive'), [btnFilter.Tag])
  end;

end;

/// /////////////////////////////////////////////
//
/// ///////////////////////////////////////////////

procedure TfrmMain.OneDay_DisplayGrid;

(*
  procedure FillOcc(iStartRow : integer);
  var
  col, row : integer;
  Room : string;
  isEmpty : boolean;

  iNextOcc : integer;
  sNextOcc : string;
  begin
  // --
  for row := iStartRow to grOneDayRooms.RowCount - 1 do
  begin
  Room := grOneDayRooms.cells[0, row];
  if Room = '' then
  continue;

  isEmpty := grOneDayRooms.cells[4, row] = '';

  if isEmpty then
  begin
  iNextOcc := d.Next_OccupiedDayCount(zOneDay_dtDate, Room);
  if iNextOcc > 100 then
  sNextOcc := '100+'
  else
  sNextOcc := inttostr(iNextOcc);
  grOneDayRooms.cells[3, row] := sNextOcc;
  end;
  end;
  7
  for row := iStartRow to grOneDayRooms.RowCount - 1 do
  begin
  Room := grOneDayRooms.cells[7, row];
  if Room = '' then
  continue;

  isEmpty := grOneDayRooms.cells[11, row] = '';

  if isEmpty then
  begin
  iNextOcc := d.Next_OccupiedDayCount(zOneDay_dtDate, Room);
  if iNextOcc > 100 then
  sNextOcc := '100+'
  else
  sNextOcc := inttostr(iNextOcc);
  grOneDayRooms.cells[10, row] := sNextOcc;
  end;
  end;
  end;

*)

  procedure FillOcc(iStartRow: integer);
  var
    col, row: integer;
    Room: string;
    isEmpty: boolean;

    iNextOcc: integer;
    sNextOcc: string;
    sDate: string;
    dtDate: Tdate;

  begin
    // --
    for row := iStartRow to grOneDayRooms.RowCount - 1 do
    begin
      Room := grOneDayRooms.cells[0, row];
      if Room = '' then
        continue;

      isEmpty := grOneDayRooms.cells[4, row] = '';

      if isEmpty then
      begin
        sDate := oFreeRooms.FindRoomNextOcc(Room);
        if sDate = '' then
        begin
          dtDate := zOneDay_dtDate + 1000;
        end
        else
          dtDate := _DBDateToDate(sDate);
        iNextOcc := trunc(dtDate) - trunc(zOneDay_dtDate);

        // iNextOcc := d.Next_OccupiedDayCount(zOneDay_dtDate, Room);
        if iNextOcc > 100 then
          sNextOcc := '100+'
        else
          sNextOcc := inttostr(iNextOcc);

        grOneDayRooms.cells[3, row] := sNextOcc;
      end;
    end;

    for row := iStartRow to grOneDayRooms.RowCount - 1 do
    begin
      Room := grOneDayRooms.cells[7, row];
      if Room = '' then
        continue;

      isEmpty := grOneDayRooms.cells[11, row] = '';

      if isEmpty then
      begin
        sDate := oFreeRooms.FindRoomNextOcc(Room);
        if sDate = '' then
        begin
          dtDate := zOneDay_dtDate + 1000;
        end
        else
          dtDate := _DBDateToDate(sDate);

        iNextOcc := trunc(dtDate) - trunc(zOneDay_dtDate);

        // iNextOcc := d.Next_OccupiedDayCount(zOneDay_dtDate, Room);
        if iNextOcc > 100 then
          sNextOcc := '100+'
        else
          sNextOcc := inttostr(iNextOcc);
        grOneDayRooms.cells[10, row] := sNextOcc;
      end;
    end;
  end;

var
  i, iRowCounter: integer;
  Z: integer;
  ii: integer;
  zz: integer;

  iRowCtrlRooms: integer;
  iRound, iRoomRound: integer;
  iNumRowsWas: integer;
  sType: string;
  bShouldBeTaken: boolean;

  PanelColor: TColor;

  FreeRoomsFilterOn: boolean;

  Floors: TSet_Of_Integer;
  Locations: TSet_Of_Integer;

  tempString: Utf8String;

begin
  if assigned(zOneDay_stlTakenTypes) then
  begin
    try
      zOneDay_stlTakenTypes.Free;
    except
    end;
    zOneDay_stlTakenTypes := nil;
  end;

  FreeRoomsFilterOn := FreeRoomsFiltered;
  PrepareFilterOrSearchDisplay(FreeRoomsFilterOn);

  zOneDay_stlTakenTypes := TStringList.Create;
  fillchar(zOneDay_bSelectedNonRooms, sizeof(zOneDay_bSelectedNonRooms), -1);

  // --
  fillchar(zOneDayResPointers, sizeof(zOneDayResPointers), 0);

  EmptyStringGrid(grOneDayRooms);

  grOneDayRooms.cells[0, 0] := GetTranslatedText('shRoom');
  grOneDayRooms.cells[1, 0] := GetTranslatedText('shType');
  grOneDayRooms.cells[2, 0] := GetTranslatedText('shGuestReservation');
  grOneDayRooms.cells[3, 0] := GetTranslatedText('shArrival');
  grOneDayRooms.cells[4, 0] := GetTranslatedText('shDeparture');
  grOneDayRooms.cells[5, 0] := '#';
  grOneDayRooms.cells[6, 0] := '';
  grOneDayRooms.cells[7, 0] := GetTranslatedText('shRoom');
  grOneDayRooms.cells[8, 0] := GetTranslatedText('shType');
  grOneDayRooms.cells[9, 0] := GetTranslatedText('shGuestReservation');
  grOneDayRooms.cells[10, 0] := GetTranslatedText('shArrival');
  grOneDayRooms.cells[11, 0] := GetTranslatedText('shDeparture');
  grOneDayRooms.cells[12, 0] := '#';

  iRowCounter := 1;
  ClearStringGridFromTo(grOneDayRooms, 1, 1);

  Floors := FilteredFloors;
  Locations := FilteredLocations;
  try
    if (NOT SearchOrGroupFilterActive) OR (Floors.Count > 0) OR (Locations.Count > 0) then
    begin
      glb.FillRoomAndTypeGrid(grOneDayRooms, Locations, Floors, FreeRoomsFilterOn, oFreeRooms, zOneDay_dtDate, btnFilter.Tag);
      iRowCounter := grOneDayRooms.RowCount - 1;
    end;

    iNumRowsWas := grOneDayRooms.RowCount;

    // Hreinsa ef fyrri síða var með fleiri rows or columns
    grOneDayRooms.RowCount := grOneDayRooms.RowCount + 160;
    grOneDayRooms.ColCount := grOneDayRooms.ColCount + 10;

    FillTheGrid(grOneDayRooms, '', 0, iNumRowsWas - 1);

    grOneDayRooms.RowCount := grOneDayRooms.RowCount - 160;
    grOneDayRooms.ColCount := grOneDayRooms.ColCount - 10;
    // Lokið

    // sýna annan grunnlit grind ef filter er virkur
    PanelColor := $00D5EAFF;
    // if grOneDayRooms.color <> PanelColor then
    // grOneDayRooms.color := PanelColor;

    // -- BHG Moved
    for i := 0 to ReservationsModel.ReservationCount - 1 do
    begin
      // Ef verið er að filtera út ákveðna bókun

      for Z := 0 to ReservationsModel.Reservations[i].RoomCount - 1 do
      begin
        // --
        if Copy(ReservationsModel.Reservations[i].Rooms[Z].RoomNumber, 1, 1) = '<' then
        begin
          // -- This prevents those that have not already checked in from being
          // visible on the date of their departure...

          // Ef gestur fer í dag en er ekki settur sem rsDeparted eða
          if (ReservationsModel.Reservations[i].Rooms[Z].ResStatus in [rsReservations, rsOverbooked, rsAlotment, rsNoShow, rsCanceled, rsTmp1, rsTmp2]) then
            if ReservationsModel.Reservations[i].Rooms[Z].Departure = zOneDay_dtDate then
              continue;

          if ReservationsModel.Reservations[i].Rooms[Z].ResStatus = rsDeparted then
            if ReservationsModel.Reservations[i].Rooms[Z].Departure = zOneDay_dtDate then
              continue; // Go next cycle !

          // --
          // Bæta í listann fyrir frátekin
          // sýnt seinna sem svört
          if ReservationsModel.Reservations[i].Rooms[Z].Departure <> zOneDay_dtDate then
            OneDay_AddToTaken(ReservationsModel.Reservations[i].Rooms[Z].RoomType);

        end;
      end;
    end;

    grOneDayRooms.RowCount := grOneDayRooms.RowCount + 160;
    grOneDayRooms.ColCount := grOneDayRooms.ColCount + 10;
    // agrRooms.BeginUpdate;
    try
      FillTheGrid(grOneDayRooms, '', 2, 1);
      grOneDayRooms.RowCount := grOneDayRooms.RowCount - 160;
      grOneDayRooms.ColCount := grOneDayRooms.ColCount - 10;

      iRowCtrlRooms := 1;

      zOneDay_bIsOverlapped := false;

      if NOT FreeRoomsFilterOn then
      begin
        // First round: display the normal rooms
        // Second round: display the non-rooms
        for iRoomRound := 1 to 2 - ABS(Ord(FreeRoomsFilterOn)) do
        begin

          // -- During first round, do not include those departing...
          // The second round we will include the departing rooms.
          // This will ensure us that the departing rooms will overlap
          // those not arrived yet.
          //
          for iRound := 1 to 2 do
          begin
            // --
            for i := 0 to ReservationsModel.ReservationCount - 1 do
            begin

              // -- Draw up Rooms Arriving and Departing...
              //
              for Z := 0 to ReservationsModel.Reservations[i].RoomCount - 1 do
              begin
                if FilteredData(ReservationsModel.Reservations[i], ReservationsModel.Reservations[i].Rooms[Z]) then { TSingleReservations }
                begin

                  // -- This prevents those that have not already checked in from being
                  // visible on the date of their departure...
                  //
                  if (ReservationsModel.Reservations[i].Rooms[Z].ResStatus in [rsReservations, rsOverbooked, rsAlotment, rsNoShow, rsCanceled, rsTmp1, rsTmp2])
                  then
                    if ReservationsModel.Reservations[i].Rooms[Z].Departure = zOneDay_dtDate then
                      continue;

                  // ATHOLD Do not display BLOCKED *********************
                  if ReservationsModel.Reservations[i].Rooms[Z].ResStatus = rsBlocked then
                    if ReservationsModel.Reservations[i].Rooms[Z].Departure = zOneDay_dtDate then
                      continue; // Go next cycle !

                  if ReservationsModel.Reservations[i].Rooms[Z].ResStatus = rsDeparted then
                    if ReservationsModel.Reservations[i].Rooms[Z].Departure = zOneDay_dtDate then
                      continue; // Go next cycle !

                  // -- See comments about the iRound cycle above...
                  //
                  if ((iRound = 2) and (ReservationsModel.Reservations[i].Rooms[Z].ResStatus = rsDeparting)) or
                    ((iRound = 1) and not(ReservationsModel.Reservations[i].Rooms[Z].ResStatus = rsDeparting)) then
                  begin
                    if ((iRoomRound = 1) AND ((Copy(ReservationsModel.Reservations[i].Rooms[Z].RoomNumber, 1, 1) <> '<') AND
                      (Copy(ReservationsModel.Reservations[i].Rooms[Z].RRNumber, 1, 1) <> '<'))) OR
                      ((iRoomRound = 2) AND ((Copy(ReservationsModel.Reservations[i].Rooms[Z].RoomNumber, 1, 1) = '<') OR
                      (Copy(ReservationsModel.Reservations[i].Rooms[Z].RRNumber, 1, 1) = '<'))) then
                    begin
                      // -- Rooms
                      ii := RoomIndex(grOneDayRooms, ReservationsModel.Reservations[i].Rooms[Z].RoomNumber, iRowCounter,
                        ReservationsModel.Reservations[i].Rooms[Z].RoomType, (SearchOrGroupFilterActive AND (Locations.Count = 0) AND (Floors.Count = 0)) OR
                        (iRoomRound = 2));
                      if ii <> -1 then
                      begin
                        // --
                        zOneDayResPointers[ii].ptrRooms[1, 1] := i;
                        // Reservation Index
                        zOneDayResPointers[ii].ptrRooms[1, 2] := Z;
                        // Rooms Index

                        if (Copy(ReservationsModel.Reservations[i].Rooms[Z].RoomNumber, 1, 1) <> '<') or
                          (Copy(ReservationsModel.Reservations[i].Rooms[Z].RRNumber, 1, 1) = '<') then
                        begin
                          tempString := ReservationsModel.Reservations[i].Rooms[Z].Guests[0].GuestName;
                          grOneDayRooms.cells[2, ii] := tempString;
                        end
                        else
                        begin
                          grOneDayRooms.cells[2, ii] := '[' + ReservationsModel.Reservations[i].Rooms[Z].RRNumber + '] ' + ReservationsModel.Reservations[i]
                            .Rooms[Z].Guests[0].GuestName;
                        end;

                        grOneDayRooms.cells[3, ii] := DateToStr(ReservationsModel.Reservations[i].Rooms[Z].Arrival);
                        grOneDayRooms.cells[4, ii] := DateToStr(ReservationsModel.Reservations[i].Rooms[Z].Departure);
                        grOneDayRooms.cells[5, ii] := inttostr(ReservationsModel.Reservations[i].Rooms[Z].GuestCount);

                        if ReservationsModel.Reservations[i].Rooms[Z].ResStatus = rsDeparting then
                        begin
                          if frmMain.IsRoomReserved(ReservationsModel.Reservations[i].Rooms[Z].RoomNumber, i, Z) then
                            try
                              zOneDay_bIsOverlapped := true;
                              grOneDayRooms.cells[2, ii] := '» ' + ReservationsModel.Reservations[i].Rooms[Z].Guests[0].GuestName;
                            finally
                              zOneDay_bIsOverlapped := false;
                            end;
                        end;

                      end;
                    end;
                  end;

                end;

              end;
            end;
          end;
        end;
      end;

      // -- clear empty rooms if so configured...

      grOneDayRooms.RowCount := grOneDayRooms.RowCount + 1;
      if zOneDay_bDetailsOn then
      begin
        for Z := grOneDayRooms.RowCount - 1 downto 1 do
        begin
          if grOneDayRooms.cells[4, Z] = '' then
          begin
            for i := Z + 1 to grOneDayRooms.RowCount - 1 do
            begin
              zOneDayResPointers[i - 1].ptrRooms[1, 1] := zOneDayResPointers[i].ptrRooms[1, 1];
              zOneDayResPointers[i - 1].ptrRooms[1, 2] := zOneDayResPointers[i].ptrRooms[1, 2];
            end;
            grOneDayRooms.cells[0, Z] := '';
            grOneDayRooms.row := Z;
            RowDelete(grOneDayRooms);
          end;
        end;
      end;

      zOneDay_iNumRows := trunc(((grOneDayRooms.RowCount - 1) / 2) + 0.999);

      // -- Empty last row...
      grOneDayRooms.cells[7, zOneDay_iNumRows] := '';
      grOneDayRooms.cells[8, zOneDay_iNumRows] := '';
      grOneDayRooms.cells[9, zOneDay_iNumRows] := '';
      grOneDayRooms.cells[10, zOneDay_iNumRows] := '';
      grOneDayRooms.cells[11, zOneDay_iNumRows] := '';
      grOneDayRooms.cells[12, zOneDay_iNumRows] := '';

      for i := 1 to zOneDay_iNumRows do
      begin
        zOneDayResPointers[i].ptrRooms[2, 1] := zOneDayResPointers[i + zOneDay_iNumRows].ptrRooms[1, 1];
        // Reservation Index
        zOneDayResPointers[i].ptrRooms[2, 2] := zOneDayResPointers[i + zOneDay_iNumRows].ptrRooms[1, 2]; // Rooms Index

        grOneDayRooms.cells[7, i] := grOneDayRooms.cells[0, i + zOneDay_iNumRows];
        grOneDayRooms.cells[8, i] := grOneDayRooms.cells[1, i + zOneDay_iNumRows];
        grOneDayRooms.cells[9, i] := grOneDayRooms.cells[2, i + zOneDay_iNumRows];
        grOneDayRooms.cells[10, i] := grOneDayRooms.cells[3, i + zOneDay_iNumRows];
        grOneDayRooms.cells[11, i] := grOneDayRooms.cells[4, i + zOneDay_iNumRows];
        grOneDayRooms.cells[12, i] := grOneDayRooms.cells[5, i + zOneDay_iNumRows];
      end;

      grOneDayRooms.RowCount := zOneDay_iNumRows + 1;
    finally
      // agrRooms.EndUpdate;
      zOneDay_iLastRow := -1;
      zOneDay_iLastCol := -1;
    end;

    // ---- Move Here : BHG
    // -- Add those without Room Numbers...
    // for i := 0 to ReservationsModel.ReservationCount - 1 do
    // begin
    // // Ef verið er að filtera út ákveðna bókun
    //
    // for Z := 0 to ReservationsModel.Reservations[i].RoomCount - 1 do
    // begin
    // // --
    // if copy(ReservationsModel.Reservations[i].Rooms[Z].RoomNumber, 1, 1) = '<' then
    // begin
    // // -- This prevents those that have not already checked in from being
    // // visible on the date of their departure...
    //
    // // Ef gestur fer í dag en er ekki settur sem rsDeparted eða
    // if (ReservationsModel.Reservations[i].Rooms[Z].ResStatus in [rsReservations, rsOverbooked, rsAlotment, rsNoShow]) then
    // if ReservationsModel.Reservations[i].Rooms[Z].Departure = zOneDay_dtDate then
    // continue;
    //
    // if ReservationsModel.Reservations[i].Rooms[Z].ResStatus = rsDeparted then
    // if ReservationsModel.Reservations[i].Rooms[Z].Departure = zOneDay_dtDate then
    // continue; // Go next cycle !
    //
    // // -- See comments about the iRound cycle above...
    // //ATHOLD þetta skeður aldrei því ´þetta erekki í iRound Lúpu
    // if ((iRound = 2) and not (ReservationsModel.Reservations[i].Rooms[Z].ResStatus = rsDeparting)) then
    // continue;
    // if ((iRound = 1) and (ReservationsModel.Reservations[i].Rooms[Z].ResStatus = rsDeparting)) then
    // continue;
    //
    // // --
    // grOneDayRooms.RowCount := grOneDayRooms.RowCount + 1;
    // grOneDayRooms.cells[0, grOneDayRooms.RowCount - 1] := ReservationsModel.Reservations[i].Rooms[Z].RoomNumber;
    // grOneDayRooms.cells[1, grOneDayRooms.RowCount - 1] := ReservationsModel.Reservations[i].Rooms[Z].RoomType;
    //
    // // Bæta í listann fyrir frátekin
    // // sýnt seinna sem svört
    // if ReservationsModel.Reservations[i].Rooms[Z].Departure <> zOneDay_dtDate then
    // OneDay_AddToTaken(ReservationsModel.Reservations[i].Rooms[Z].RoomType);
    //
    // end;
    // end;
    // end;
    // ---- |||||||||||||||

    for i := 0 to zOneDay_stlTakenTypes.Count - 1 do
    begin
      Z := strtointDef(trim(_strTokenAT(zOneDay_stlTakenTypes[i], '|', 1)), 0);
      for ii := 1 to Z do
      begin
        bShouldBeTaken := false;
        for zz := 1 to grOneDayRooms.RowCount - 1 do
        begin
          if grOneDayRooms.cells[4, zz] = '' then
          begin
            sType := grOneDayRooms.cells[1, zz];
            bShouldBeTaken := true;
            if sType = trim(_strTokenAT(zOneDay_stlTakenTypes[i], '|', 0)) then
            begin
              if zOneDay_bSelectedNonRooms[zz, OneDay_GetIsLeftOrRight(1)] = -1 then
              begin
                bShouldBeTaken := false;
                zOneDay_bSelectedNonRooms[zz, OneDay_GetIsLeftOrRight(1)] := i;
                dec(Z);
                zOneDay_stlTakenTypes[i] := trim(_strTokenAT(zOneDay_stlTakenTypes[i], '|', 0)) + '|' + inttostr(Z) + '|' +
                  trim(_strTokenAT(zOneDay_stlTakenTypes[i], '|', 2));
                break;
              end;
            end;
          end
          else if grOneDayRooms.cells[11, zz] = '' then
          begin
            sType := grOneDayRooms.cells[8, zz];
            bShouldBeTaken := true;
            if sType = trim(_strTokenAT(zOneDay_stlTakenTypes[i], '|', 0)) then
            begin
              if zOneDay_bSelectedNonRooms[zz, OneDay_GetIsLeftOrRight(8)] = -1 then
              begin
                bShouldBeTaken := false;
                zOneDay_bSelectedNonRooms[zz, OneDay_GetIsLeftOrRight(8)] := i;
                dec(Z);
                zOneDay_stlTakenTypes[i] := trim(_strTokenAT(zOneDay_stlTakenTypes[i], '|', 0)) + '|' + inttostr(Z) + '|' +
                  trim(_strTokenAT(zOneDay_stlTakenTypes[i], '|', 2));
                break;
              end;
            end;
          end
        end;

        if bShouldBeTaken then
        begin
          for zz := 1 to grOneDayRooms.RowCount - 1 do
          begin
            if grOneDayRooms.cells[4, zz] = '' then
            begin
              sType := grOneDayRooms.cells[1, zz];
              bShouldBeTaken := true;
              if IsInRoomTypes(trim(_strTokenAT(zOneDay_stlTakenTypes[i], '|', 0)), sType) then
              begin
                if zOneDay_bSelectedNonRooms[zz, OneDay_GetIsLeftOrRight(1)] = -1 then
                begin
                  bShouldBeTaken := false;
                  zOneDay_bSelectedNonRooms[zz, OneDay_GetIsLeftOrRight(1)] := i;
                  dec(Z);
                  zOneDay_stlTakenTypes[i] := trim(_strTokenAT(zOneDay_stlTakenTypes[i], '|', 0)) + '|' + inttostr(Z) + '|' +
                    trim(_strTokenAT(zOneDay_stlTakenTypes[i], '|', 2));
                  break;
                end;
              end;
            end
            else if grOneDayRooms.cells[11, zz] = '' then
            begin
              sType := grOneDayRooms.cells[8, zz];
              bShouldBeTaken := true;
              if IsInRoomTypes(trim(_strTokenAT(zOneDay_stlTakenTypes[i], '|', 0)), sType) then
              begin
                if zOneDay_bSelectedNonRooms[zz, OneDay_GetIsLeftOrRight(8)] = -1 then
                begin
                  bShouldBeTaken := false;
                  zOneDay_bSelectedNonRooms[zz, OneDay_GetIsLeftOrRight(8)] := i;
                  dec(Z);
                  zOneDay_stlTakenTypes[i] := trim(_strTokenAT(zOneDay_stlTakenTypes[i], '|', 0)) + '|' + inttostr(Z) + '|' +
                    trim(_strTokenAT(zOneDay_stlTakenTypes[i], '|', 2));
                  break;
                end;
              end;
            end
          end;
        end;
      end;

    end;

    FillOcc(1);

  finally
    Locations.Free;
    Floors.Free;
  end;

  // try
  // agrRooms.EndUpdate;
  // agrRooms.refresh;
  // agrRooms.show;
  // ...do stuff
  // finally
  // agrRooms.perform( WM_SETREDRAW, 1, 0 );
  // agrRooms.invalidate;
  // end;
  // finally
  // LockWindowUpdate(0);
  // end;
  // except
  // end;
  // agrRooms.refresh;  // V: 1.0.2.0

end;

function TfrmMain.FilteredData(Reservation: TSingleReservations; Room: TRoomObject): boolean;
// Reservation : TSingleReservations) : Boolean;
var
  i, I1: integer;
  s: String;
  resultStatus, resultGroup, resultSearch: boolean;
begin
  result := NOT(SearchOrGroupFilterActive);
  // (edtSearch.Text = '') AND (btnFilter.ImageIndex = 0);
  if NOT result then
  begin

    resultGroup := NOT GroupsFilterActive;
    if NOT resultGroup then
    begin
      resultGroup := GroupFiltered(Room.Reservation);
    end;

    resultStatus := NOT ReservationStatusFilter;
    if NOT resultStatus then
    begin
      resultStatus := ReservationStatusFiltered(Room.ResStatus);
    end;

    resultSearch := edtSearch.Text = '';

    if NOT resultSearch then
    begin
      s := Reservation.name + ',' + inttostr(Reservation.Reservation) + ',' + Reservation.customer + ',' + Reservation.Information + ',' + Reservation.PMInfo +
        ',' + Reservation.BookingReference + ',' + Reservation.HiddenInfo + ',';
      s := s + Room.RoomNumber + ',' + Room.RoomType + ',' + Room.PriceType + ',' + Room.Currency + ',' + DateToStr(Room.Arrival) + ',' +
        DateToStr(Room.Departure) + ',' + Room.PMInfo + ',';
      for I1 := 0 to Room.GuestCount - 1 do
        s := s + Room.Guests[I1].GuestName + ',' + Room.Guests[I1].FirstName + ',' + Room.Guests[I1].SurName + ',' + Room.Guests[I1].Address1 + ',' +
          Room.Guests[I1].Address2 + ',' + Room.Guests[I1].Address3 + ',' + Room.Guests[I1].Address4 + ',' + Room.Guests[I1].Country + ',' +
          Room.Guests[I1].Company + ',' + Room.Guests[I1].GuestType + ',' + Room.Guests[I1].Information + ',';
      resultSearch := pos(ANSIlowercase(edtSearch.Text), ANSIlowercase(s)) > 0;
    end;

    // if (lblAndOr.Tag = 1) OR FreeRoomsFiltered then
    // result := resultFilter OR resultSearch
    // else
    // result := resultFilter AND resultSearch;
    result := resultSearch AND resultGroup AND resultStatus;

  end;

end;

procedure TfrmMain.ActivateHint(HintPoint: TPoint; comp: TWinControl);
begin
  zHintPoint := HintPoint;
  zHintComp := comp;
  // Application.CancelHint;
  comp.ShowHint := true;
  Application.ActivateHint(zHintPoint);
end;

procedure TfrmMain.OneDay_CheckHint(X, Y: integer);
var
  ACol, ARow: integer;

  sHintText: string;

  iReservation, iRoom: integer;

  APoint: TPoint;
  sRoom: string;

  sTmp: string;

  wrapAT: integer;

  discountAmount: Double;
  iTempColor: integer;
  myRect, Rect: TRect;

  sHintInvoice: String;

  ro: TRoomObject;

begin

  wrapAT := 130;
  try

    grOneDayRooms.MouseToCell(X, Y, ACol, ARow);
    // Application.ProcessMessages;

    if ARow < 1 then
    begin
      iLastHintRow := ARow;
      iLastHintCol := ACol;
      exit;
    end;
    if ACol < 0 then
      exit;

    if ACol IN [0, 7, 1, 8, 2, 9] then
      exit;

    ApplicationCancelHint;
    iLastHintRow := ARow;
    iLastHintCol := ACol;
    exit;
    // end;

    // end;

  except
    // --
  end;

end;

function TfrmMain.getChannelColor(Reservation: TSingleReservations): integer;
begin
  result := getChannelColorByChannel(Reservation.Channel);
end;

function TfrmMain.getChannelColorByChannel(Channel: integer): integer;
begin
  result := glb.LocateChannelColorById(Channel);
  if result = -1 then
    result := 15793151;
end;

function TfrmMain.getInvoiceMadeColor(PaymentInvoice: integer; NoRent: boolean; offColor, onColor, onGroupColor: integer; GroupAccount: boolean): integer;
begin
  result := offColor;
  case PaymentInvoice of
    - 1:
      result := onColor;
    -2:
      result := onColor;
  end;
  if (result = onColor) OR NoRent then
    result := onColor;
  if (result = onColor) AND GroupAccount then
    result := onGroupColor;
end;

function TfrmMain.getUnpaidItemsColor(Value: boolean; defaultColor: integer): integer;
begin
  if Value then
    result := clYellow
  else
    result := defaultColor;
end;

procedure TfrmMain.OneDay_ShowSelectedCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
begin
end;

procedure TfrmMain.OneDay_ShowNonSelectedCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
begin
end;

// ******************************************************************************
// ******************************************************************************
// ******************************************************************************

var
  MousePoint: TPoint;
  PeriodMousePoint: TPoint;
  iDragCell: TPoint;

procedure TfrmMain.GetRoomInfo;
// var
// iReservation: integer;
// iRoom: integer;
// sRoom: string;
begin
  // if (ReservationsModel.ReservationCount = 0) then
  // begin
  // exit;
  // // toDo show informatiom about room and availability
  // end
  // else
  // begin
  // OneDay_GetReservation(iReservation, iRoom, sRoom);
  // if sRoom > '' then
  // begin
  // sbStatusBar.Panels[4].Text := { +1023 } GetTranslatedText('shRoom') + ' : ' + sRoom;
  // end
  // else
  // begin
  // sbStatusBar.Panels[4].Text := { +1023 } GetTranslatedText('shRoom') + ' : ' + sRoom;
  // end;
  // end;
end;

/// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// grOneDayRooms
// Click actions
//
/// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmMain.grOneDayRoomsClick(Sender: TObject);
begin
  GetRoomInfo;
end;

procedure TfrmMain.grOneDayRoomsDblClickCell(Sender: TObject; ARow, ACol: integer);
var
  Rect, myRect: TRect;
  Point: TPoint;
  theData: recPersonHolder;
var
  iReservation, iRoom: integer;
  sName: string;
begin
  // --
  zOneDay_bMouseDown := false;
  try

    // double click on Room Column
    if (ACol = 0) or (ACol = 7) then
    begin
      // -- Set the room status
      if Copy(grOneDayRooms.cells[ACol, ARow], 1, 1) = '<' then
      begin
        btnProvideARoom.Click;
        exit;
      end;

      if trim(grOneDayRooms.cells[ACol, ARow]) = '' then
        exit;

      Rect := grOneDayRooms.CellRect(ACol, ARow);
      Point.X := Rect.Left;
      Point.Y := Rect.Top;
      Point := grOneDayRooms.ClientToScreen(Point);
      SetRoomCleanAndMaintenanceStatus(grOneDayRooms.cells[ACol, ARow], Point.X, Point.Y);
      // SetRoomStatus(grOneDayRooms.cells[ACol, ARow], Point.X, Point.Y);

      zOneDay_bMouseDown := false;
      if grOneDayRooms.dragging then
        grOneDayRooms.EndDrag(false);
      btnRefreshOneDay.Click;
    end
    else
      // double click on RoomType Column
      if (ACol = 1) OR (ACol = 8) then
      begin
        if zOneDay_ResIndex = -1 then
          exit;

        if ACol = 1 then
          if (Copy(grOneDayRooms.cells[1, ARow], 1, 1) = '<') then
          begin
          end;

        if ACol = 8 then
          if (Copy(grOneDayRooms.cells[7, ARow], 1, 1) = '<') then
          begin
            OneDay_GetResAndRoom_IDX(iReservation, iRoom);
            if changeNoRoomRoomtype(ReservationsModel.Reservations[iReservation].Reservation, ReservationsModel.Reservations[iReservation].Rooms[iRoom].RoomRes,
              trim(grOneDayRooms.cells[8, ARow])) then
            begin
              RefreshGrid;
            end;

          end;

      end
      else

        // double click on Guest name column
        if (ACol = 2) or (ACol = 9) then
        begin
          if zOneDay_ResIndex = -1 then
            exit;

          OneDay_GetResAndRoom_IDX(iReservation, iRoom);

          grOneDayRooms.MouseToCell(HoverPointOneDay.X, HoverPointOneDay.Y, ACol, ARow);

          // Invoice with unpaid items
          Rect := grOneDayRooms.CellRect(ACol, ARow);
          myRect := Rect;
          myRect.Left := myRect.Right - 45;
          myRect.Right := myRect.Right - 31;
          if (HoverPointOneDay.X >= myRect.Left) AND (HoverPointOneDay.X <= myRect.Right) then
          begin
            _RoomInvoice;
            exit;
          end;

          // Roomrent Invoice
          Rect := grOneDayRooms.CellRect(ACol, ARow);
          myRect := Rect;
          myRect.Left := myRect.Right - 30;
          myRect.Right := myRect.Right - 16;
          if (HoverPointOneDay.X >= myRect.Left) AND (HoverPointOneDay.X <= myRect.Right) then
          begin
            if ReservationsModel.Reservations[iReservation].Rooms[iRoom].PaymentInvoice > 0 then
            begin
              if ReservationsModel.Reservations[iReservation].Rooms[iRoom].GroupAccount then
                _ClosedInvoicesThisReservation
              else
                _ClosedInvoicesThisRoom;
            end
            else if ReservationsModel.Reservations[iReservation].Rooms[iRoom].GroupAccount then
              _GroupInvoice
            else
              _RoomInvoice;
            exit;
          end;

          if (Copy(TAdvStringGrid(Sender).cells[ACol, ARow], 1, 2) = GoingStr) then
          begin
            // Invoice with unpaid items
            Rect := grOneDayRooms.CellRect(ACol, ARow);
            Rect.Right := Rect.Right - ((Rect.Right - Rect.Left) div 2);
            myRect := Rect;
            myRect.Left := myRect.Right - 42;
            myRect.Right := myRect.Right - 30;
            if (HoverPointOneDay.X >= myRect.Left) AND (HoverPointOneDay.X <= myRect.Right) then
            begin
              _RoomInvoice;
              exit;
            end;

            // Roomrent Invoice
            Rect := grOneDayRooms.CellRect(ACol, ARow);
            Rect.Right := Rect.Right - ((Rect.Right - Rect.Left) div 2);
            myRect := Rect;
            myRect.Left := myRect.Right - 28;
            myRect.Right := myRect.Right - 16;
            if (HoverPointOneDay.X >= myRect.Left) AND (HoverPointOneDay.X <= myRect.Right) then
            begin
              if ReservationsModel.Reservations[iReservation].Rooms[iRoom].PaymentInvoice > 0 then
              begin
                if ReservationsModel.Reservations[iReservation].Rooms[iRoom].GroupAccount then
                  _ClosedInvoicesThisReservation
                else
                  _ClosedInvoicesThisRoom;
              end
              else if ReservationsModel.Reservations[iReservation].Rooms[iRoom].GroupAccount then
                _GroupInvoice
              else
                _RoomInvoice;
              exit;
            end;
          end;

          initPersonHolder(theData);
          theData.RoomReservation := ReservationsModel.Reservations[iReservation].Rooms[iRoom].RoomRes;
          theData.Reservation := ReservationsModel.Reservations[iReservation].Reservation;
          theData.name := sName;

          if openGuestProfile(actNone, theData) then
          begin
            zDebug1 := 'grOneDayRoomsDblClick(Sender : TObject);';
            RefreshGrid;
            zOneDay_bMouseDown := false;
            if grOneDayRooms.dragging then
              grOneDayRooms.EndDrag(false);
          end;
          exit;
        end
        else

          // Double click on arrival date column
          if (ACol = 3) or (ACol = 10) then
          begin
            if zOneDay_ResIndex = -1 then
              exit;

            Open_RES_edForm(grOneDayRooms);
            exit;
          end
          else

            // Double click on departure date
            if (ACol = 4) or (ACol = 11) then
            begin
              if zOneDay_ResIndex = -1 then
                exit;

              Open_RR_EdForm(grOneDayRooms);
              exit;
            end
            else
              // Double click on Cuest count column
              if (ACol = 5) or (ACol = 12) then
              begin
                if zOneDay_ResIndex = -1 then
                  exit;
              end
  finally
    zOneDay_bMouseDown := false;

    if grOneDayRooms.dragging then
      grOneDayRooms.EndDrag(false);

    timKillDrag.Enabled := true;
  end;
end;

procedure TfrmMain.grOneDayRoomsClickCell(Sender: TObject; ARow, ACol: integer);
var
  roomCol: integer;
  noRes: boolean;
  aRoom: string;
begin
  if NOT assigned(CurrentlyActiveGrid) then
    exit;

  if ACol <= 6 then
  begin
    roomCol := 0;
    noRes := ActiveGrid.cells[4, ARow] = '';
  end
  else
  begin
    roomCol := 7;
    noRes := ActiveGrid.cells[11, ARow] = '';
  end;

  EnableDisableFunctions(NOT noRes);
  if noRes then
  begin
    aRoom := ActiveGrid.cells[roomCol, ARow];
  end
  else
  begin
    aRoom := ''
  end;
  zEmptyRoomNumber := aRoom;
  zOneDay_ResIndex := 0;
  if noRes then
    zOneDay_ResIndex := -1;
end;

procedure TfrmMain.EnableDisableFunctions(Enable: boolean);
begin

  pmnuRoomInvoive.Enabled := Enable;
  pmnuGroupInvoice.Enabled := Enable;
  pmnuClosedInvoicesThisRoom.Enabled := Enable AND (NOT OffLineMode);
  pmnuClosedInvoicesThisreservation.Enabled := Enable AND (NOT OffLineMode);
  pmnuClosedInvoicesThisCustomer.Enabled := Enable AND (NOT OffLineMode);
  pmnuCheckInRoom.Enabled := Enable;
  pmnuCheckOutRoom.Enabled := Enable;
  pmnuCheckInGroup.Enabled := Enable;
  mnuRoomNumber.Enabled := Enable;
  mnuDeleteRoomFromReservation.Enabled := Enable AND (NOT OffLineMode);
  mnuCancelReservation2.Enabled := Enable AND (NOT OffLineMode);
  pmnuModifyReservation.Enabled := Enable AND (NOT OffLineMode);
  pmnuRoomReservation.Enabled := Enable AND (NOT OffLineMode);
  pmnuRoomGuests.Enabled := Enable AND (NOT OffLineMode);
  mnuRoomListForReservation.Enabled := Enable AND (NOT OffLineMode);
  mmnuFinishedInvoices.Enabled := Enable AND (NOT OffLineMode);
  mnuItmColorCodeRoom.Enabled := Enable AND (NOT OffLineMode);
  mnuConfirmBooking.Enabled := Enable AND (NOT OffLineMode);
  btnCancelReservations.Enabled := Enable AND (NOT OffLineMode); // C3
  pmnuProvideAllotment.Enabled := Enable AND (NOT OffLineMode); // C3
  // mnuRoomNumber.Enabled := Enable;

  btnRoomInvoice.Enabled := Enable;
  btnGroupInvoice.Enabled := Enable;
  btnClosedInvoicesThisRoom.Enabled := Enable AND (NOT OffLineMode);
  btnClosedInvoicesThisreservation.Enabled := Enable AND (NOT OffLineMode);
  btnClosedInvoicesThisCustomer.Enabled := Enable AND (NOT OffLineMode);
  btnClosedInvoicesThisRoom.Enabled := Enable AND (NOT OffLineMode);
  btnClosedInvoicesThisreservation.Enabled := Enable AND (NOT OffLineMode);
  btnClosedInvoicesThisCustomer.Enabled := Enable AND (NOT OffLineMode);

  btnModifyReservation.Enabled := Enable AND (NOT OffLineMode);
  btnRoomReservation.Enabled := Enable AND (NOT OffLineMode);
  btnRoomGuests.Enabled := Enable AND (NOT OffLineMode);
  pmnuReservationRoomList.Enabled := Enable AND (NOT OffLineMode);
  btnReservationNotes.Enabled := Enable AND (NOT OffLineMode);
  btnCancelThisReservation.Enabled := Enable AND (NOT OffLineMode);
  btnDeleteReservation.Enabled := Enable AND (NOT OffLineMode);
  btnRemoveThisRoom.Enabled := Enable AND (NOT OffLineMode);
  btnCheckInRoom.Enabled := Enable;
  btnCheckInGroup.Enabled := Enable;
  btnCheckOutRoom.Enabled := Enable;
  btnProvideARoom.Enabled := Enable;
  btnSetNoroom.Enabled := Enable AND (NOT OffLineMode);
end;

/// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// grOneDayRooms
//
/// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmMain.ShowOneDayHint(ACol, ARow: integer);
var
  X, Y: integer;
  iReservation, iRoom: integer;
  Rect: TRect;
begin
  Rect := grOneDayRooms.CellRect(ACol, ARow);
  X := Rect.Left + 10;
  Y := Rect.Top + 10;

  if (Copy(grOneDayRooms.cells[ACol, ARow], 1, 2) = '» ') then
  begin
    if (X >= Rect.Left + ((Rect.Right - Rect.Left) DIV 2)) then
      Rect.Left := Rect.Left + ((Rect.Right - Rect.Left) DIV 2)
    else
      Rect.Right := Rect.Left + ((Rect.Right - Rect.Left) DIV 2);
  end;

  if (ACol = 2) and (grOneDayRooms.cells[4, ARow] = '') then
  begin
    ApplicationCancelHint;
    iLastHintRow := ARow;
    iLastHintCol := ACol;
    exit;
  end;

  if (ACol = 9) and (grOneDayRooms.cells[11, ARow] = '') then
  begin
    ApplicationCancelHint;
    iLastHintRow := ARow;
    iLastHintCol := ACol;
    exit;
  end;

  if (Copy(grOneDayRooms.cells[ACol, ARow], 1, 2) = '» ') and (X < Rect.Left + ((Rect.Right - Rect.Left) div 2)) then
  begin
    iReservation := zOneDayResPointers[ARow].ptrRooms[OneDay_GetIsLeftOrRight(ACol), 1]; // Reservation Index
    iRoom := zOneDayResPointers[ARow].ptrRooms[OneDay_GetIsLeftOrRight(ACol), 2]; // Rooms Index
    OneDay_NewGuestCoordinates(ReservationsModel.Reservations[iReservation].Rooms[iRoom].RoomNumber, iReservation, iRoom);
  end
  else
  begin
    iReservation := zOneDayResPointers[ARow].ptrRooms[OneDay_GetIsLeftOrRight(ACol), 1]; // Reservation Index
    iRoom := zOneDayResPointers[ARow].ptrRooms[OneDay_GetIsLeftOrRight(ACol), 2]; // Rooms Index
  end;

  Period_CheckHint(grOneDayRooms, X, Y, iReservation, iRoom);
end;

procedure TfrmMain.grOneDayRoomsEnter(Sender: TObject);
begin
  CurrentlyActiveGrid := TAdvStringGrid(Sender);
  GetRoomInfo;
end;

procedure TfrmMain.grOneDayRoomsGridHint(Sender: TObject; ARow, ACol: integer; var HintStr: string);
var
  iReservation, iRoom: integer;

  APoint: TPoint;
  sRoom: string;

  sTmp: string;

  discountAmount: Double;
  iTempColor: integer;
  // myRect,
  Rect: TRect;

  sHintInvoice: String;

  ro: TRoomObject;

  X, Y: integer;
  xyPoint: TPoint;
begin

  HintStr := '';
  if NOT g.qShowhint then
    exit;

  Rect := grOneDayRooms.CellRect(ACol, ARow);
  X := Rect.Left + 10;
  Y := Rect.Top + 10;

  try

    if (ARow < 1) OR (ACol < 0) then
      exit;

    case ACol of

      0, 7:
        begin
          // if (iLastHintRow = ARow) and (iLastHintCol = ACol) then
          // exit;
          // ApplicationCancelHint;
          sRoom := grOneDayRooms.cells[ACol, ARow];
          APoint.X := X;
          APoint.Y := Y;
          APoint := grOneDayRooms.ClientToScreen(APoint);
          iLastHintRow := ARow;
          iLastHintCol := ACol;
          HintStr := d.getRoomText(sRoom);
          // ActivateHint(APoint, grOneDayRooms);
          exit;
        end;

      1, 8:
        begin

          // --
          if ((ACol = 1) and (grOneDayRooms.cells[4, ARow] = '')) OR ((ACol = 8) and (grOneDayRooms.cells[11, ARow] = '')) then
          begin
            Application.CancelHint;
            exit;
          end;

          zOneDay_glbRect := grOneDayRooms.CellRect(ACol, ARow);

          APoint.X := X;
          APoint.Y := Y;
          APoint := grOneDayRooms.ClientToScreen(APoint);

          if (Copy(grOneDayRooms.cells[ACol, ARow], 1, 2) = '» ') and (X < zOneDay_glbRect.Left + ((zOneDay_glbRect.Right - zOneDay_glbRect.Left) div 2)) then
          begin
            iReservation := zOneDayResPointers[ARow].ptrRooms[OneDay_GetIsLeftOrRight(ACol), 1]; // Reservation Index
            iRoom := zOneDayResPointers[ARow].ptrRooms[OneDay_GetIsLeftOrRight(ACol), 2]; // Rooms Index
            OneDay_NewGuestCoordinates(ReservationsModel.Reservations[iReservation].Rooms[iRoom].RoomNumber, iReservation, iRoom);
          end
          else
          begin
            iReservation := zOneDayResPointers[ARow].ptrRooms[OneDay_GetIsLeftOrRight(ACol), 1]; // Reservation Index
            iRoom := zOneDayResPointers[ARow].ptrRooms[OneDay_GetIsLeftOrRight(ACol), 2]; // Rooms Index
          end;

          HintStr := '';

          ro := ReservationsModel.Reservations[iReservation].Rooms[iRoom];

          if ro.ResStatus = rsOverbooked then
          begin
            HintStr := { 1035 } '<b>' + GetTranslatedText('shWAITINGLIST') + '</b><br><br>';
          end
          else if ro.ResStatus = rsAlotment then
          begin
            HintStr := { 1036 } '<b>' + GetTranslatedText('shALOTMENT') + '</b><br><br>';
          end
          else if ro.ResStatus = rsNoShow then
          begin
            HintStr := { 1037 } '<b>' + GetTranslatedText('shNOSHOW') + '</b><br><br>';
          end;
          if ro.ResStatus = rsBlocked then
          begin
            HintStr := { 1038 } '<b>' + GetTranslatedText('shBLOCKED') + '</b><br><br>';
          end;
          if ro.ResStatus = rsCanceled then // *HJ 140206
          begin
            HintStr := { 1038 } '<b>' + GetTranslatedText('shCANCELED') + '</b><br><br>';
          end;
          if ro.ResStatus = rsTmp1 then // *HJ 140206
          begin
            HintStr := { 1038 } '<b>' + GetTranslatedText('shTmp1') + '</b><br><br>';
          end;
          if ro.ResStatus = rsTmp2 then // *HJ 140206
          begin
            HintStr := { 1038 } '<b>' + GetTranslatedText('shTmp2') + '</b><br><br>';
          end;

          // --
          if trim(ro.RoomClass) <> '' then
            HintStr := HintStr + GetTranslatedText('shTx_FrmMain_ChannelRoomType') +
              Format(' : (%s) %s', [ro.RoomClass, glb.GetRoomTypeGroupDescription(ro.RoomClass)]) + #13;
          HintStr := HintStr + { +1023 } GetTranslatedText('shRoom') + ' : ' + grOneDayRooms.cells[ACol, ARow] + #13;

          // --
          if ro.Guests[0].Address1 <> '' then
            HintStr := HintStr + #13 + ' : ' + ro.Guests[0].Address1;

          // --
          if ro.Guests[0].Address2 <> '' then
            HintStr := HintStr + #13 + ' : ' + ro.Guests[0].Address2;

          // --
          if ro.Guests[0].Address3 <> '' then
            HintStr := HintStr + #13 + ' : ' + ro.Guests[0].Address3;

          // --
          if ro.Guests[0].Address4 <> '' then
            HintStr := HintStr + #13 + ' : ' + ro.Guests[0].Address4;

          // --
          if ro.Guests[0].Country <> '' then
            HintStr := HintStr + #13 + ' : ' + ro.Guests[0].Country;

          // --
          if ReservationsModel.Reservations[iReservation].Tel1 > '' then
            HintStr := HintStr + #13 + { 1040 } GetTranslatedText('shTelephone') + ': ' + ReservationsModel.Reservations[iReservation].Tel1;

          // --
          if ReservationsModel.Reservations[iReservation].Tel2 > '' then
            HintStr := HintStr + #13 + ' : ' + ReservationsModel.Reservations[iReservation].Tel2;

          // --
          if ReservationsModel.Reservations[iReservation].Fax > '' then
            HintStr := HintStr + #13 + { 1041 } GetTranslatedText('shFax') + ' : ' + ReservationsModel.Reservations[iReservation].Fax;

          // --
          if ro.Guests[0].id <> '' then
            HintStr := HintStr + #13#13 + { 1042 } 'ID' + ' : ' + ro.Guests[0].id;

          // --
          // if ReservationsModel.Reservations[ iReservation ].Rooms[ iRoom ].Price <> 0 then
          HintStr := HintStr + #13#13 + '<b>' + { 1043 } GetTranslatedText('shPrice') + ' :</b> ' + ro.PriceType + ' ' + trim(_floatToStr(ro.Price, 12, 2)) +
            ' ' + trim(ro.Currency);

          // --
          if ro.Discount <> 0 then
          begin
            discountAmount := ro.Discount;
            if ro.Percentage then
            begin
              discountAmount := ro.Price * ro.Discount / 100;
              HintStr := HintStr + #13 + '<b>' + { 1044 } GetTranslatedText('shDiscount') + ' :</b> ' + trim(_floatToStr(ro.Discount, 12, 2)) + '% (' +
                trim(_floatToStr(discountAmount, 12, 2)) + ' ' + trim(ro.Currency) + GetTranslatedText('shTx_PerNight') + ')';
            end
            else
            begin
              HintStr := HintStr + #13 + '<b>' + { +1044 } GetTranslatedText('shDiscount') + ' :</b> ' + trim(_floatToStr(ro.Discount, 12, 2)) + ' ' +
                trim(ro.Currency) + GetTranslatedText('shTx_PerNight');
            end;

            HintStr := HintStr + #13 + '<b>' + { 1043 } GetTranslatedText('shPriceAfterDiscount') + ' :</b> ' + ro.PriceType + ' ' +
              trim(_floatToStr(ro.Price - discountAmount, 12, 2)) + ' ' + trim(ro.Currency) + #13;
          end;

          // --
          if ro.PaymentInvoice = -1 then
          begin
            HintStr := HintStr + #13 + { 1045 } GetTranslatedText('sh1045');
          end
          else if ro.PaymentInvoice = -2 then
          begin
            HintStr := HintStr + #13 + { 1046 } GetTranslatedText('sh1046');
          end
          else if ro.PaymentInvoice > 0 then
          begin
            HintStr := HintStr + #13 + { 1047 } GetTranslatedText('shInvoice') + ' ' + inttostr(ro.PaymentInvoice);
          end;

          // --
          if ro.Guests[0].Information <> '' then
          begin
            sTmp := trim(string(ro.Guests[0].Information));
            HintStr := HintStr + #13#13 + { 1048 } '-' + GetTranslatedText('shRoomMemo') + ' : ' + #13 + sTmp;
          end;

          // --
          if ro.PMInfo <> '' then
            HintStr := HintStr + #13#13 + { 1049 } GetTranslatedText('shPaymentInfo') + ' : ' + #13 + trim(string(ro.PMInfo));

          // --
          HintStr := HintStr + #13 + '===========' + #13 +
          { 1050 } GetTranslatedText('shRefrence') + ' : ' + trim(inttostr(ReservationsModel.Reservations[iReservation].Reservation)) + ' / ' +
            trim(inttostr(ro.RoomRes));

          // --
          // grOneDayRooms.Hint := HintStr;
          // ActivateHint(APoint, grOneDayRooms);
          exit;
        end;

      2, 9:
        begin
          ShowOneDayHint(ACol, ARow);
        end;
    else
    end;

  except
    // --
  end;
end;

/// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// grOneDayRooms
// Mouse actions
//
/// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmMain.grOneDayRoomsMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);

var
  ACol: integer;
  ARow: integer;

  Rect: TRect;
  PpUp: TPoint;
begin
  // --
  PlaceMouseClickToCell(Sender, X, Y);
  TAdvStringGrid(Sender).MouseToCell(X, Y, ACol, ARow);

  if ARow > 0 then
  begin
    TAdvStringGrid(Sender).row := ARow;
    TAdvStringGrid(Sender).col := ACol;
  end;

  cHomeStatus := 0;

  zOneDay_bRightClick := Button = mbRight;
  zOneDay_bNewGuest := false;
  if zOneDay_bRightClick then
  begin
    TAdvStringGrid(Sender).MouseToCell(X, Y, ACol, ARow);

    if (ACol in [2, 9]) then
    begin
      // --
      PpUp.X := X;
      PpUp.Y := Y;
      PpUp := ClientToScreen(PpUp);
      frmMain.mmnuOneDayGrid.Popup(PpUp.X, PpUp.Y);
    end
    else if (ACol in [0, 7]) then
    begin
      OneDay_DoAJump('');
    end
    else
    begin
      PpUp.X := X;
      PpUp.Y := Y;
      PpUp := ClientToScreen(PpUp);
      mmnuOneDayGrid.Popup(PpUp.X, PpUp.Y);
    end;
  end
  else
  begin
    MousePoint := Point(X, Y);
    zOneDay_bMouseDown := true;
    TAdvStringGrid(Sender).MouseToCell(X, Y, ACol, ARow);
    if ARow > 0 then
    begin
      TAdvStringGrid(Sender).row := ARow;
      TAdvStringGrid(Sender).col := ACol;
      if Copy(TAdvStringGrid(Sender).cells[ACol, ARow], 1, 2) = '» ' then
      begin
        Rect := TAdvStringGrid(Sender).CellRect(ACol, ARow);
        zOneDay_bNewGuest := (X < Rect.Left + ((Rect.Right - Rect.Left) div 2));
      end;
    end;
  end;
end;

procedure TfrmMain.grOneDayRoomsMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  zOneDay_bMouseDown := false;
end;

procedure TfrmMain.grOneDayRoomsResize(Sender: TObject);
begin
  try
    AutoResizeOneDayGrid;
  except
  end;
end;

procedure TfrmMain.AutoResizeOneDayGrid;
var
  totColWidths, totNameWidths, remainingWidth: integer;
  i: integer;
begin
  if NOT assigned(CurrentlyActiveGrid) then
    exit;

  totColWidths := 0;
  for i := 0 to 12 do // grOneDayRooms.ColCount - 1 do
    totColWidths := totColWidths + ActiveGrid.colWidths[i];
  remainingWidth := ActiveGrid.ClientWidth - totColWidths;
  totNameWidths := ActiveGrid.colWidths[2] + ActiveGrid.colWidths[9] + remainingWidth;
  ActiveGrid.colWidths[2] := totNameWidths div 2;
  ActiveGrid.colWidths[9] := totNameWidths div 2;
end;

procedure TfrmMain.grOneDayRoomsMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
var
  ACol, ARow: integer;
begin
  if NOT assigned(CurrentlyActiveGrid) then
    exit;

  HoverPointOneDay := Point(X, Y);

  grOneDayRooms.MouseToCell(X, Y, ACol, ARow);
  if (ACol IN [2, 9]) AND ((iLastShownHintRow <> ARow) OR (iLastShownHintCol <> ACol)) then
  begin
    iLastShownRoomReservation := -1;
    iLastShownHintRow := ARow;
    iLastShownHintCol := ACol;
    ApplicationCancelGuestHint;
  end;

  // if g.qShowhint then
  // OneDay_CheckHint(X, Y)
  // else
  // ApplicationCancelGuestHint;

  if zOneDay_bMouseDown then
  begin
    if (ABS(MousePoint.X - X) > 6) or (ABS(MousePoint.Y - Y) > 6) then
    begin
      zOneDay_bMouseDown := false;

      ActiveGrid.MouseToCell(MousePoint.X, MousePoint.Y, iDragCell.X, iDragCell.Y);

      if ((iDragCell.X > 6) and (ActiveGrid.cells[11, iDragCell.Y] <> '')) or ((iDragCell.X < 6) and (ActiveGrid.cells[4, iDragCell.Y] <> '')) then
      begin
        if ActiveGrid.Focused then
        begin
          ActiveGrid.BeginDrag(true);
          ApplicationCancelHint;
          // Application.processmessages;
        end;
      end;
    end;
    exit;
  end;

  // if grOneDayRooms.dragging then
  // exit;
end;

/// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// grOneDayRooms
// Drag and drop
//
/// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmMain.grOneDayRoomsStartDrag(Sender: TObject; var DragObject: TDragObject);
var
  Arrival, Departure: Tdate;
  iReservation, iRoomReservation: integer;
  _grid: TAdvStringGrid;
begin
  _grid := (Sender AS TAdvStringGrid);
  GetDragGuestIndexes(iDragCell, iReservation, iRoomReservation);
  if ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].BlockMove AND
    (Copy(ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].RoomNumber, 1, 1) <> '<') then
  begin
    MessageDlg(GetTranslatedText('shTx_FrmMain_UserCannotMoveTheRoomReservation'), mtError, [mbOk], 0);
    exit;
  end;
  if IsShiftKeyPressed then
  begin
    OneDayGridArrivalAndDepartureOfCell(iDragCell, Arrival, Departure);
    ListRoomsAvailable(Arrival, Departure);
    ActiveGrid.Invalidate;
    ActiveGrid.Refresh;
  end;
  Screen.cursors[crNoDrop] := curNoDropNew;
  pnlNoRoomDrop.Left := ActiveGrid.Width div 2 - pnlNoRoomDrop.Width div 2;
  pnlNoRoomDrop.Top := ActiveGrid.Height div 2 - pnlNoRoomDrop.Height div 2;
  pnlNoRoomDrop.Visible := true;
end;

procedure TfrmMain.GetDragGuestIndexes(DragCell: TPoint; var idxReservation, idxRoomReservation: integer);
begin
  idxReservation := zOneDayResPointers[DragCell.Y].ptrRooms[OneDay_GetIsLeftOrRight(DragCell.X), 1];
  // Reservation Index
  idxRoomReservation := zOneDayResPointers[iDragCell.Y].ptrRooms[OneDay_GetIsLeftOrRight(DragCell.X), 2];

  if zOneDay_bNewGuest then
    OneDay_NewGuestCoordinates(ReservationsModel.Reservations[idxReservation].Rooms[idxRoomReservation].RoomNumber, idxReservation, idxRoomReservation);

end;

function TfrmMain.OneDayGridRoomReservationOfCell(DragCell: TPoint): integer;
var
  idxReservation, idxRoomReservation: integer;
begin
  GetDragGuestIndexes(DragCell, idxReservation, idxRoomReservation);
  result := ReservationsModel.Reservations[idxReservation].Rooms[idxRoomReservation].RoomRes;
end;

function TfrmMain.OneDayGridRoomNumberOfCell(DragCell: TPoint): String;
var
  idxReservation, idxRoomReservation: integer;
begin
  GetDragGuestIndexes(DragCell, idxReservation, idxRoomReservation);
  result := ReservationsModel.Reservations[idxReservation].Rooms[idxRoomReservation].RoomNumber;
end;

function TfrmMain.OneDayGridRoomTypeOfCell(DragCell: TPoint): String;
var
  idxReservation, idxRoomReservation: integer;
begin
  GetDragGuestIndexes(DragCell, idxReservation, idxRoomReservation);
  result := ReservationsModel.Reservations[idxReservation].Rooms[idxRoomReservation].RoomType;
end;

procedure TfrmMain.OneDayGridArrivalAndDepartureOfCell(DragCell: TPoint; var Arrival, Departure: Tdate);
var
  idxReservation, idxRoomReservation: integer;
begin
  GetDragGuestIndexes(DragCell, idxReservation, idxRoomReservation);
  Arrival := ReservationsModel.Reservations[idxReservation].Rooms[idxRoomReservation].Arrival;
  Departure := ReservationsModel.Reservations[idxReservation].Rooms[idxRoomReservation].Departure;
end;

procedure TfrmMain.grOneDayRoomsDragDrop(Sender, Source: TObject; X, Y: integer);
var
  ACol, ARow: integer;
  iRoomReservation: integer;
begin
  TAdvStringGrid(Source).MouseToCell(X, Y, ACol, ARow);
  iRoomReservation := OneDayGridRoomReservationOfCell(iDragCell);

  if ACol > 6 then
    ACol := 7
  else
    ACol := 0;

  MoveToRoomEnh2(iRoomReservation, grOneDayRooms.cells[ACol, ARow]);
  zDebug1 := '150';
  RefreshGrid;
end;

procedure TfrmMain.grOneDayRoomsDragOver(Sender, Source: TObject; X, Y: integer; State: TDragState; var Accept: boolean);
var
  ACol, ARow: integer;
  iReservation, iRoom: integer;
  destRoom: String;
begin
  Accept := false;
  if Source is TAdvStringGrid then
  begin
    // --
    TAdvStringGrid(Source).MouseToCell(X, Y, ACol, ARow);
    if (ARow > 0) then
    begin
      if ACol > 6 then
        ACol := 7
      else
        ACol := 0;

      if (Copy(TAdvStringGrid(Source).cells[ACol, ARow], 1, 1) <> '<') and (trim(TAdvStringGrid(Source).cells[ACol, ARow]) <> '') then
      begin
        destRoom := trim(TAdvStringGrid(Source).cells[ACol, ARow]);
        if ((ACol = 0) and (trim(TAdvStringGrid(Source).cells[4, ARow]) = '')) or ((ACol = 7) and (trim(TAdvStringGrid(Source).cells[11, ARow]) = '')) then
        begin
          Accept := true;
          if IsShiftKeyPressed then
          begin
            if NOT IsRoomAvailableInMoveFunctionAvailRooms(destRoom) then
              Accept := false;
          end;
        end
        else
        begin
          iReservation := zOneDayResPointers[ARow].ptrRooms[OneDay_GetIsLeftOrRight(ACol), 1]; // Reservation Index
          iRoom := zOneDayResPointers[ARow].ptrRooms[OneDay_GetIsLeftOrRight(ACol), 2]; // Rooms Index

          if ReservationsModel.Reservations[iReservation].Rooms[iRoom].Departure = zOneDay_dtDate then
            Accept := true;
        end;
      end;
    end;
  end;
  // Compute_TreeMoves( X, Y );
end;

procedure TfrmMain.grOneDayRoomsDragScroll(Sender: TObject; TopRow, LeftCol: integer; var DragScrollDir: TDragScrollDirection; var CanScroll: boolean);
begin
  // DragScrollDir := [dsdUp,dsdDown,dsdLeft,dsdRight];
  CanScroll := true;
end;

procedure DrawTextNOT(const hDC: hDC; const Font: TFont; const Text: string; const X, Y: integer);
begin
  with TBitmap.Create do
    try
      Canvas.Font.Assign(Font);
      with Canvas.TextExtent(Text) do
        SetSize(cx, cy);
      Canvas.Brush.Color := clBlack;
      Canvas.FillRect(Rect(0, 0, Width, Height));
      Canvas.Font.Color := clWhite;
      Canvas.TextOut(0, 0, Text);
      BitBlt(hDC, X, Y, Width, Height, Canvas.handle, 0, 0, SRCINVERT);
    finally
      Free;
    end;
end;

const
  ROUNDED_CORNER_RADIUS = 10;

procedure TfrmMain.MyRoundedRect(Canvas: TCanvas; X1, Y1, X2, Y2: integer; DoRoundCorners: boolean = true);
var
  penStyle: TPenStyle;
  penColor: TColor;
begin
  penStyle := Canvas.Pen.Style;
  penColor := Canvas.Pen.Color;

  Canvas.Pen.Style := psSolid; // psClear;
  Canvas.Pen.Color := Canvas.Brush.Color;

  if DoRoundCorners then
    Canvas.RoundRect(X1, Y1, X2, Y2, ROUNDED_CORNER_RADIUS, ROUNDED_CORNER_RADIUS)
  else
    Canvas.FillRect(Rect(X1, Y1, X2, Y2));

  Canvas.Pen.Style := penStyle;
  Canvas.Pen.Color := penColor;
end;

procedure TfrmMain.grOneDayRoomsDrawCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
const
  Left_room = 0;
  Left_roomType = 1;
  Left_cust = 2;
  Left_Arrival = 3;
  Left_Departure = 4;
  Left_GuestCount = 5;

  Splitter = 6;

  Right_room = 7;
  Right_roomType = 8;
  Right_cust = 9;
  Right_Arrival = 10;
  Right_Departure = 11;
  Right_GuestCount = 12;

  c_room = [Left_room, Right_room];
  c_roomtype = [Left_roomType, Right_roomType];
  c_custs = [Left_cust, Right_cust];
  c_Arrival = [Left_Arrival, Right_Arrival];
  c_departure = [Left_Departure, Right_Departure];
  c_GuestCount = [Left_GuestCount, Right_GuestCount];

  c_RoomInfo = [Left_room, Right_room, Left_roomType, Right_roomType];

  c_GuestInfo = [Left_cust, Right_cust, Left_Arrival, Right_Arrival, Left_Departure, Right_Departure, Left_GuestCount, Right_GuestCount];

  Left_GuestInfo = [Left_cust, Left_Arrival, Left_Departure, Left_GuestCount];

  Right_GuestInfo = [Right_cust, Right_Arrival, Right_Departure, Right_GuestCount];

  c_ALL = [Left_room, Right_room, Left_roomType, Right_roomType, Left_cust, Right_cust, Left_Arrival, Right_Arrival, Left_Departure, Right_Departure,
    Left_GuestCount, Right_GuestCount, Splitter];

  Left = 1;
  Right = 2;

var
  iRes, iRoom, iRoomRes: integer;
  iRoomCol, iTemp: integer;

  LeavingName: string;
  ArrivingName: string;

  iWidth: integer;
  myRect: TRect;

  tmpBackColor: TColor;
  tmpFontColor: TColor;

  BackgroundColor: TColor;
  fontColor: TColor;
  isBold: boolean;
  isItalic: boolean;
  isUnderLine: boolean;
  i: integer;
  isStrikeOut: boolean;
  rec: recStatusAttr;

  isDeparting: boolean;
  sRoomStatus: string;
  cRoomStatus: Char;
  Room: string;
  iTempColor, iRectangleSpaceForUnpaidItems, iRectangleSpaceForInvoiceMade, iRectangleSpaceForChannelColor: integer;
  chRect: TRect;

  tempString: Utf8String;
  Grid: TAdvStringGrid;

  penStyle: TPenStyle;


begin

  if not(ACol in c_ALL) then
    exit;

  Grid := TAdvStringGrid(Sender);
  With Grid.Canvas do
  begin
    try
      if (ARow < Grid.FixedRows) then
      begin
        if (ACol IN c_GuestCount) then
        begin
          Brush.Color := sSkinManager1.GetGlobalColor;
          FillRect(Rect);
          LoadImageFromImageList(DImages.ilGuests, 5, Grid.Canvas, Point(Rect.Left + (Rect.Right - Rect.Left) div 2 - 8,
            Rect.Top + (Rect.Bottom - Rect.Top) div 2 - 8), Brush.Color, [Point(clRed, sSkinManager1.GetGlobalFontColor)]);
          exit;
        end;
        exit;
      end;

      // The Default colors
      grOneDayRooms.Canvas.Brush.Style := bsSolid;
      grOneDayRooms.Canvas.Brush.Color := g.qColorOneDayGridBack; // $00DFEFFF;
      grOneDayRooms.Canvas.Font.Color := g.qColorOneDayGridFont; // clBlack;

      if ACol in [2, 9] then
      begin
        iRectangleSpaceForChannelColor := 12;
        iRectangleSpaceForInvoiceMade := 12;
        iRectangleSpaceForUnpaidItems := 12;
      end
      else
      begin
        iRectangleSpaceForChannelColor := 0;
        iRectangleSpaceForInvoiceMade := 0;
        iRectangleSpaceForUnpaidItems := 0;
      end;
      // [2, 3, 4, 5, 9, 10, 11, 12]
      if (ACol in c_GuestInfo) then
      begin

        iRes := -1;
        iRoom := 0;
        iRoomRes := 0;

        iRes := zOneDayResPointers[ARow].ptrRooms[OneDay_GetIsLeftOrRight(ACol), 1];
        iRoom := zOneDayResPointers[ARow].ptrRooms[OneDay_GetIsLeftOrRight(ACol), 2];
        if iRes > 0 then
        begin
          iRoomRes := ReservationsModel.Reservations[iRes].Rooms[iRoom].RoomRes;
        end;

        // Ef samskonar herbergistegund er utan þá er það sýnt með því að lita brottfarardagsetningu
        // meðhöndla vinsta megin
        if ((OneDay_GetIsLeftOrRight(ACol) = Left) and (Grid.cells[Left_Departure, ARow] = '')) OR
          ((OneDay_GetIsLeftOrRight(ACol) = Right) and (Grid.cells[Right_Departure, ARow] = '')) then
        begin
          if ((ACol = Left_Departure) and (ACol <> Left_GuestCount)) OR ((ACol = Right_Departure) and (ACol <> Right_GuestCount)) then
          begin
            if OneDay_isATakenType(ACol, ARow) then
            begin
              Brush.Color := g.qColorIsTakenBack; // $0099CCFF;
              Font.Color := g.qColorIsTakenFont; // Clbalck
              // Pen.Color := clRed;
              Brush.Style := bsDiagCross;

              SetBkColor(handle, ColorToRGB(clRed));
              MyRoundedRect(Grid.Canvas, Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
              // FillRect(Rect);
            end;
          end;
          exit;
        end;

        isDeparting := false;

        // Ef gestur er að fara og annar að koma er GestCellan Tvískipt
        // annar hlutinn Grár (sá sem er að fara) en hinn Aqua (sá sem er að koma)
        if (Copy(Grid.cells[ACol, ARow], 1, 2) = GoingStr) then
        begin
          // Sá sem er að fara
          LeavingName := Grid.cells[ACol, ARow];
          // Sá sem er að koma
          ArrivingName := OneDay_RoomReservedName(ReservationsModel.Reservations[iRes].Rooms[iRoom].RoomNumber, iRes, iRoom);
          GetArrivingGuestIndexes(iRoom, iRes, ACol, ARow);

          if ArrivingName <> '' then
          begin
            tmpBackColor := g.qStatusAttr_ArrivingOtherLeaving.BackgroundColor;
            tmpFontColor := g.qStatusAttr_ArrivingOtherLeaving.fontColor;

            Brush.Color := tmpBackColor;
            Font.Color := tmpFontColor;

            // Fyrri helmingurinn fyrir þann sem er að koma
            iWidth := (Rect.Right - Rect.Left) div 2;
            myRect := Rect;
            myRect.Right := myRect.Left + iWidth;

            // if ReservationsModel.Reservations[iRes].OutOfOrderBlocking then
            // Brush.Style := bsDiagCross;

            MyRoundedRect(Grid.Canvas, myRect.Left, myRect.Top, myRect.Right, myRect.Bottom);
            // FillRect(myRect);
            iTemp := Grid.Canvas.TextHeight(ArrivingName);

            ExtTextOut(handle, myRect.Left + 2, (myRect.Bottom + myRect.Top) div 2 - iTemp div 2, ETO_CLIPPED, @myRect, PChar(ArrivingName),
              // ETO_CLIPPED or ETO_OPAQUE, @myRect, PChar(ArrivingName),
              length(ArrivingName), nil);

            if NOT ReservationsModel.Reservations[iRes].OutOfOrderBlocking then
            begin
              if iRectangleSpaceForUnpaidItems > 0 then
              begin
                chRect.Left := myRect.Right - 4 - iRectangleSpaceForChannelColor - iRectangleSpaceForInvoiceMade - 2 - iRectangleSpaceForUnpaidItems - 2;
                chRect.Top := myRect.Top + 3;
                chRect.Bottom := myRect.Bottom - 3;
                chRect.Right := chRect.Left + iRectangleSpaceForUnpaidItems;
                iTempColor := getUnpaidItemsColor(ReservationsModel.Reservations[iRes].Rooms[iRoom].TotalNoRent > 0, Brush.Color);
                DrawRectanglOnCanvas(Grid.Canvas, iTempColor, chRect);
              end;

              if iRectangleSpaceForChannelColor > 0 then
              begin
                chRect.Left := myRect.Right - 4 - iRectangleSpaceForChannelColor;
                chRect.Top := myRect.Top + 3;
                chRect.Bottom := myRect.Bottom - 3;
                chRect.Right := chRect.Left + iRectangleSpaceForChannelColor;
                iTempColor := getChannelColor(ReservationsModel.Reservations[iRes]);
                if iTempColor = -1 then
                  iTempColor := 15793151;
                DrawRectanglOnCanvas(Grid.Canvas, iTempColor, chRect);
              end;

              if iRectangleSpaceForInvoiceMade > 0 then
              begin
                chRect.Left := myRect.Right - 4 - iRectangleSpaceForChannelColor - iRectangleSpaceForInvoiceMade - 2;
                chRect.Top := myRect.Top + 3;
                chRect.Bottom := myRect.Bottom - 3;
                chRect.Right := chRect.Left + iRectangleSpaceForInvoiceMade;
                iTempColor := getInvoiceMadeColor(ReservationsModel.Reservations[iRes].Rooms[iRoom].PaymentInvoice,
                  (round(ReservationsModel.Reservations[iRes].Rooms[iRoom].OngoingRent) <> 0), Brush.Color, clWhite, clAqua,
                  ReservationsModel.Reservations[iRes].Rooms[iRoom].GroupAccount);
                DrawRectanglOnCanvas(Grid.Canvas, iTempColor, chRect);
              end;
            end;

            // Seinni helmingurinn fyrir þann sem er að fara
            Brush.Color := clGray;
            Font.Color := clWhite;

            myRect := Rect;
            myRect.Left := myRect.Left + iWidth;

            if ReservationsModel.Reservations[iRes].OutOfOrderBlocking AND (ACol in c_custs) then
            begin
              Brush.Color := clSilver;
              Font.Color := clBlack;
            end;

            MyRoundedRect(Grid.Canvas, myRect.Left, myRect.Top, myRect.Right, myRect.Bottom);
            // FillRect(myRect);
            iTemp := Grid.Canvas.TextHeight(ArrivingName);

            if ReservationsModel.Reservations[iRes].OutOfOrderBlocking then
            begin
              tempString := GetTranslatedText('shTx_FrmMain_OutOfOrder') + StringOfChar(' ', 255) + #0;
              ExtTextOut(handle, myRect.Left + 2, (myRect.Bottom + myRect.Top) div 2 - iTemp div 2, ETO_CLIPPED, @myRect, PChar(Grid.cells[ACol, ARow]),
                length(Grid.cells[ACol, ARow]), nil);

              Pen.Color := Font.Color;
              Grid.Canvas.MoveTo(Rect.Left + 2 + Grid.Canvas.TextWidth(GetTranslatedText('shTx_FrmMain_OutOfOrder')), (myRect.Top + myRect.Bottom) div 2);
              Grid.Canvas.LineTo(Rect.Right, (myRect.Top + myRect.Bottom) div 2);

              exit;
            end
            else
              ExtTextOut(handle, myRect.Left + 2, (myRect.Bottom + myRect.Top) div 2 - iTemp div 2, ETO_CLIPPED, @myRect, PChar(Grid.cells[ACol, ARow]),
                length(Grid.cells[ACol, ARow]), nil);

            GetLeavingGuestIndexes(iRoom, iRes, ACol, ARow);
            if iRectangleSpaceForUnpaidItems > 0 then
            begin
              chRect.Left := myRect.Right - 4 - iRectangleSpaceForChannelColor - iRectangleSpaceForInvoiceMade - 2 - iRectangleSpaceForUnpaidItems - 2;
              chRect.Top := myRect.Top + 3;
              chRect.Bottom := myRect.Bottom - 3;
              chRect.Right := chRect.Left + iRectangleSpaceForUnpaidItems;
              iTempColor := getUnpaidItemsColor(ReservationsModel.Reservations[iRes].Rooms[iRoom].TotalNoRent > 0, Brush.Color);
              DrawRectanglOnCanvas(Grid.Canvas, iTempColor, chRect);
            end;

            if iRectangleSpaceForChannelColor > 0 then
            begin
              chRect.Left := myRect.Right - 4 - iRectangleSpaceForChannelColor;
              chRect.Top := myRect.Top + 3;
              chRect.Bottom := myRect.Bottom - 3;
              chRect.Right := chRect.Left + iRectangleSpaceForChannelColor;
              iTempColor := getChannelColor(ReservationsModel.Reservations[iRes]);
              if iTempColor = -1 then
                iTempColor := 15793151;
              DrawRectanglOnCanvas(Grid.Canvas, iTempColor, chRect);
            end;

            if iRectangleSpaceForInvoiceMade > 0 then
            begin
              chRect.Left := myRect.Right - 4 - iRectangleSpaceForChannelColor - iRectangleSpaceForInvoiceMade - 2;
              chRect.Top := myRect.Top + 3;
              chRect.Bottom := myRect.Bottom - 3;
              chRect.Right := chRect.Left + iRectangleSpaceForInvoiceMade;
              iTempColor := getInvoiceMadeColor(ReservationsModel.Reservations[iRes].Rooms[iRoom].PaymentInvoice,
                round(ReservationsModel.Reservations[iRes].Rooms[iRoom].OngoingRent) <> 0, Brush.Color, clWhite, clAqua,
                ReservationsModel.Reservations[iRes].Rooms[iRoom].GroupAccount);
              DrawRectanglOnCanvas(Grid.Canvas, iTempColor, chRect);
            end;

            exit;
          end;
        end
        else if (ACol in c_departure) AND (ReservationsModel.Reservations[iRes].Rooms[iRoom].CodedColor <> -1) then
        begin
          Brush.Color := ReservationsModel.Reservations[iRes].Rooms[iRoom].CodedColor;
          Font.Color := InverseColor(ReservationsModel.Reservations[iRes].Rooms[iRoom].CodedColor);
          Font.Style := [];
          if g.qStatusAttr_GuestStaying.isBold then
            Font.Style := Font.Style + [fsBold];
          if g.qStatusAttr_GuestStaying.isItalic then
            Font.Style := Font.Style + [fsItalic];
          if g.qStatusAttr_GuestStaying.isStrikeOut then
            Font.Style := Font.Style + [fsStrikeOut];
        end
        else if (ReservationsModel.Reservations[iRes].Rooms[iRoom].ResStatus = rsBlocked) then
        begin
          Brush.Color := g.qStatusAttr_Blocked.BackgroundColor;
          Font.Color := g.qStatusAttr_Blocked.fontColor;
          Font.Style := [];
          if g.qStatusAttr_Blocked.isBold then
            Font.Style := Font.Style + [fsBold];
          if g.qStatusAttr_Blocked.isItalic then
            Font.Style := Font.Style + [fsItalic];
          if g.qStatusAttr_Blocked.isStrikeOut then
            Font.Style := Font.Style + [fsStrikeOut];
        end
        else
          // Gestur er að fara (sjá fyrri)
          if (ReservationsModel.Reservations[iRes].Rooms[iRoom].ResStatus = rsDeparting) then
          begin
            Brush.Color := g.qStatusAttr_Departing.BackgroundColor;
            Font.Color := g.qStatusAttr_Departing.fontColor;

            Font.Style := [];
            if g.qStatusAttr_Departing.isBold then
              Font.Style := Font.Style + [fsBold];
            if g.qStatusAttr_Departing.isItalic then
              Font.Style := Font.Style + [fsItalic];
            if g.qStatusAttr_Departing.isStrikeOut then
              Font.Style := Font.Style + [fsStrikeOut];
            isDeparting := true;
          end
          else
            // Er Pöntun þ.e. ekki innbókaður
            if ReservationsModel.Reservations[iRes].Rooms[iRoom].ResStatus = rsReservations then
            begin
              Brush.Color := g.qStatusAttr_Order.BackgroundColor;
              Font.Color := g.qStatusAttr_Order.fontColor;
              Font.Style := [];

              if g.qStatusAttr_Order.isBold then
                Font.Style := Font.Style + [fsBold];
              if g.qStatusAttr_Order.isItalic then
                Font.Style := Font.Style + [fsItalic];
              if g.qStatusAttr_Order.isStrikeOut then
                Font.Style := Font.Style + [fsStrikeOut];
            end
            else
              // Frainn þ.e útbókaður
              if ReservationsModel.Reservations[iRes].Rooms[iRoom].ResStatus = rsDeparted then
              begin
                Brush.Color := g.qStatusAttr_Departed.BackgroundColor;
                Font.Color := g.qStatusAttr_Departed.fontColor;
                Font.Style := [];
                if g.qStatusAttr_Departed.isBold then
                  Font.Style := Font.Style + [fsBold];
                if g.qStatusAttr_Departed.isItalic then
                  Font.Style := Font.Style + [fsItalic];
                if g.qStatusAttr_Departed.isStrikeOut then
                  Font.Style := Font.Style + [fsStrikeOut];
              end
              else
                // Yfirbókun
                if ReservationsModel.Reservations[iRes].Rooms[iRoom].ResStatus = rsOverbooked then
                begin
                  Brush.Color := g.qStatusAttr_Waitinglist.BackgroundColor;
                  Font.Color := g.qStatusAttr_Waitinglist.fontColor;
                  Font.Style := [];
                  if g.qStatusAttr_Waitinglist.isBold then
                    Font.Style := Font.Style + [fsBold];
                  if g.qStatusAttr_Waitinglist.isItalic then
                    Font.Style := Font.Style + [fsItalic];
                  if g.qStatusAttr_Waitinglist.isStrikeOut then
                    Font.Style := Font.Style + [fsStrikeOut];
                end
                else
                  // No Show
                  if ReservationsModel.Reservations[iRes].Rooms[iRoom].ResStatus = rsNoShow then
                  begin
                    Brush.Color := g.qStatusAttr_NoShow.BackgroundColor;
                    Font.Color := g.qStatusAttr_NoShow.fontColor;
                    Font.Style := [];
                    if g.qStatusAttr_NoShow.isBold then
                      Font.Style := Font.Style + [fsBold];
                    if g.qStatusAttr_NoShow.isItalic then
                      Font.Style := Font.Style + [fsItalic];
                    if g.qStatusAttr_NoShow.isStrikeOut then
                      Font.Style := Font.Style + [fsStrikeOut];
                  end
                  else
                    // Canceled
                    if ReservationsModel.Reservations[iRes].Rooms[iRoom].ResStatus = rsCanceled then // *HJ 140206
                    begin
                      Brush.Color := g.qStatusAttr_Canceled.BackgroundColor;
                      // ATH FIX
                      Font.Color := g.qStatusAttr_Canceled.fontColor;
                      Font.Style := [];
                      if g.qStatusAttr_NoShow.isBold then
                        Font.Style := Font.Style + [fsBold];
                      if g.qStatusAttr_NoShow.isItalic then
                        Font.Style := Font.Style + [fsItalic];
                      if g.qStatusAttr_NoShow.isStrikeOut then
                        Font.Style := Font.Style + [fsStrikeOut];
                    end
                    else
                      // TMP1
                      if ReservationsModel.Reservations[iRes].Rooms[iRoom].ResStatus = rsTmp1 then // *HJ 140206
                      begin
                        Brush.Color := g.qStatusAttr_tmp1.BackgroundColor;
                        // ATH FIX
                        Font.Color := g.qStatusAttr_tmp1.fontColor;
                        Font.Style := [];
                        if g.qStatusAttr_NoShow.isBold then
                          Font.Style := Font.Style + [fsBold];
                        if g.qStatusAttr_NoShow.isItalic then
                          Font.Style := Font.Style + [fsItalic];
                        if g.qStatusAttr_NoShow.isStrikeOut then
                          Font.Style := Font.Style + [fsStrikeOut];
                      end
                      else
                        // TMP2
                        if ReservationsModel.Reservations[iRes].Rooms[iRoom].ResStatus = rsTmp2 then // *HJ 140206
                        begin
                          Brush.Color := g.qStatusAttr_tmp2.BackgroundColor;
                          // ATH FIX
                          Font.Color := g.qStatusAttr_tmp2.fontColor;
                          Font.Style := [];
                          if g.qStatusAttr_NoShow.isBold then
                            Font.Style := Font.Style + [fsBold];
                          if g.qStatusAttr_NoShow.isItalic then
                            Font.Style := Font.Style + [fsItalic];
                          if g.qStatusAttr_NoShow.isStrikeOut then
                            Font.Style := Font.Style + [fsStrikeOut];
                        end
                        else
                          // Allotment
                          if ReservationsModel.Reservations[iRes].Rooms[iRoom].ResStatus = rsAlotment then
                          begin
                            Brush.Color := g.qStatusAttr_Allotment.BackgroundColor;
                            Font.Color := g.qStatusAttr_Allotment.fontColor;
                            Font.Style := [];
                            if g.qStatusAttr_Allotment.isBold then
                              Font.Style := Font.Style + [fsBold];
                            if g.qStatusAttr_Allotment.isItalic then
                              Font.Style := Font.Style + [fsItalic];
                            if g.qStatusAttr_Allotment.isStrikeOut then
                              Font.Style := Font.Style + [fsStrikeOut];
                          end
                          else
                            // Fer á morgunn
                            if (ReservationsModel.Reservations[iRes].Rooms[iRoom].ResStatus = rsGuests) and
                              (ReservationsModel.Reservations[iRes].Rooms[iRoom].Departure = zOneDay_dtDate + 1) then
                            begin
                              Brush.Color := g.qStatusAttr_GuestLeavingNextDay.BackgroundColor;
                              Font.Color := g.qStatusAttr_GuestLeavingNextDay.fontColor;
                              Font.Style := [];
                              if g.qStatusAttr_GuestLeavingNextDay.isBold then
                                Font.Style := Font.Style + [fsBold];
                              if g.qStatusAttr_GuestLeavingNextDay.isItalic then
                                Font.Style := Font.Style + [fsItalic];
                              if g.qStatusAttr_GuestLeavingNextDay.isStrikeOut then
                                Font.Style := Font.Style + [fsStrikeOut];
                            end
                            else
                              // Gestur og verður áfram
                              if (ReservationsModel.Reservations[iRes].Rooms[iRoom].ResStatus = rsGuests) and
                                (ReservationsModel.Reservations[iRes].Rooms[iRoom].Departure > zOneDay_dtDate + 1) then
                              begin
                                // innbókaður verður amk tvær nætur í viðbót - þ.e fer ekki á morgunn
                                Brush.Color := g.qStatusAttr_GuestStaying.BackgroundColor;
                                Font.Color := g.qStatusAttr_GuestStaying.fontColor;
                                Font.Style := [];
                                if g.qStatusAttr_GuestStaying.isBold then
                                  Font.Style := Font.Style + [fsBold];
                                if g.qStatusAttr_GuestStaying.isItalic then
                                  Font.Style := Font.Style + [fsItalic];
                                if g.qStatusAttr_GuestStaying.isStrikeOut then
                                  Font.Style := Font.Style + [fsStrikeOut];
                              end;

        if (gdFocused in State) then
        begin
          Font.Color := clBlack;
          Brush.Color := clSkyBlue;
          Font.Style := Font.Style + [fsBold];
        end;

        if ReservationsModel.Reservations[iRes].OutOfOrderBlocking then
        begin
          Brush.Color := clSilver;
          Font.Color := clWhite;
        end;

        tempString := Grid.cells[ACol, ARow] + StringOfChar(' ', 255) + #0;

        MyRoundedRect(Grid.Canvas, Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
        iTemp := Grid.Canvas.TextHeight(tempString);

        // if ReservationsModel.Reservations[iRes].Rooms[iRoom].blockMove then
        // Font.Style := Font.Style + [fsUnderline];

        if ReservationsModel.Reservations[iRes].OutOfOrderBlocking AND (ACol in c_custs) then
        begin
          tempString := GetTranslatedText('shTx_FrmMain_OutOfOrder') + StringOfChar(' ', 255) + #0;
          ExtTextOut(handle, Rect.Left + 2, (Rect.Bottom + Rect.Top) div 2 - iTemp div 2, ETO_CLIPPED, @Rect, tempString, length(tempString), nil);

          Pen.Color := clBlack;
          Grid.Canvas.MoveTo(Rect.Left + 2 + TextWidth(GetTranslatedText('shTx_FrmMain_OutOfOrder')), (Rect.Top + Rect.Bottom) div 2);
          Grid.Canvas.LineTo(Rect.Right, (Rect.Top + Rect.Bottom) div 2);

          exit;
        end
        else
          ExtTextOut(handle, Rect.Left + 2, (Rect.Bottom + Rect.Top) div 2 - iTemp div 2, ETO_CLIPPED, @Rect, tempString, length(tempString), nil);

        if iRectangleSpaceForUnpaidItems > 0 then
        begin
          chRect.Left := Rect.Right - 4 - iRectangleSpaceForChannelColor - iRectangleSpaceForInvoiceMade - 2 - iRectangleSpaceForUnpaidItems - 2;
          chRect.Top := Rect.Top + 3;
          chRect.Bottom := Rect.Bottom - 3;
          chRect.Right := chRect.Left + iRectangleSpaceForUnpaidItems;
          iTempColor := getUnpaidItemsColor(ReservationsModel.Reservations[iRes].Rooms[iRoom].TotalNoRent > 0, Brush.Color);
          DrawRectanglOnCanvas(Grid.Canvas, iTempColor, chRect);
        end;

        if iRectangleSpaceForChannelColor > 0 then
        begin
          chRect.Left := Rect.Right - 4 - iRectangleSpaceForChannelColor;
          chRect.Top := Rect.Top + 3;
          chRect.Bottom := Rect.Bottom - 3;
          chRect.Right := chRect.Left + iRectangleSpaceForChannelColor;
          iTempColor := getChannelColor(ReservationsModel.Reservations[iRes]);
          if iTempColor = -1 then
            iTempColor := 15793151;
          DrawRectanglOnCanvas(Grid.Canvas, iTempColor, chRect);
        end;

        if iRectangleSpaceForInvoiceMade > 0 then
        begin
          chRect.Left := Rect.Right - 4 - iRectangleSpaceForChannelColor - iRectangleSpaceForInvoiceMade - 2;
          chRect.Top := Rect.Top + 3;
          chRect.Bottom := Rect.Bottom - 3;
          chRect.Right := chRect.Left + iRectangleSpaceForInvoiceMade;
          iTempColor := getInvoiceMadeColor(ReservationsModel.Reservations[iRes].Rooms[iRoom].PaymentInvoice,
            round(ReservationsModel.Reservations[iRes].Rooms[iRoom].OngoingRent) <> 0, Brush.Color, clWhite, clAqua,
            ReservationsModel.Reservations[iRes].Rooms[iRoom].GroupAccount);
          DrawRectanglOnCanvas(Grid.Canvas, iTempColor, chRect);
        end;

      end
      else // Búið að skrifa gest
        if (ACol = Splitter) then
        begin
          Brush.Color := clBtnFace;
          FillRect(Rect);
        end
        // end for guestinfo cols
        // and start of roomNumber col
        else if (ACol in c_room) then
        begin
          /// Room Column but not no rooms
          Brush.Color := sSkinManager1.GetGlobalColor;
          Font.Color := sSkinManager1.GetGlobalFontColor;
          FillRect(Rect);
          Room := Grid.cells[ACol, ARow];
          if Copy(Room, 1, 1) <> '<' then
          begin
            if IsShiftKeyPressed then
            begin
              if Grid.dragging then
              begin
                if NOT IsRoomAvailableInMoveFunctionAvailRooms(Room) then
                begin
                  Brush.Color := clGray;
                  Font.Color := clWhite;
                  Pen.Color := clWhite;
                  Brush.Style := bsCross;
                  Font.Style := [];
                  FillRect(Rect);

                  iTemp := Grid.Canvas.TextHeight(Grid.cells[ACol, ARow]);

                  ExtTextOut(handle, Rect.Left + 2, (Rect.Top + Rect.Bottom) div 2 - iTemp div 2, ETO_CLIPPED or ETO_OPAQUE, @Rect,
                    PChar(Grid.cells[ACol, ARow]), length(Grid.cells[ACol, ARow]), nil);
                  exit;
                end;
              end;
            end;

            sRoomStatus := g.oRooms.FindRoomStatus(Room);
            if sRoomStatus <> '' then
            begin
              cRoomStatus := sRoomStatus[1];
              Brush.Color := d.colorCodeOfStatus(cRoomStatus);
              chRect.Left := Rect.Right - 8;
              chRect.Top := Rect.Top;
              chRect.Bottom := Rect.Bottom;
              chRect.Right := Rect.Right;
              FillRect(chRect);
            end;
            Brush.Color := sSkinManager1.GetGlobalColor;
            Font.Color := sSkinManager1.GetGlobalFontColor;
          end
          else
          /// Room Column  NO rooms
          begin
            Brush.Color := sSkinManager1.GetGlobalColor; // clAqua;
            Font.Color := sSkinManager1.GetGlobalColor; // clBlack;
          end;

          iTemp := Grid.Canvas.TextHeight(Grid.cells[ACol, ARow]);

          ExtTextOut(handle, Rect.Left + 2, (Rect.Top + Rect.Bottom) div 2 - iTemp div 2,
            // ETO_CLIPPED or ETO_OPAQUE, @Rect, PChar(Grid.cells[ACol, ARow]),
            ETO_CLIPPED, @Rect, PChar(Grid.cells[ACol, ARow]), length(Grid.cells[ACol, ARow]), nil);

        end
        else if (ACol in c_roomtype) then
        begin
          Brush.Color := sSkinManager1.GetGlobalColor;
          FillRect(Rect);

          rec := d.getRoomTypeColors(Grid.cells[ACol, ARow]);
          Brush.Color := rec.BackgroundColor;
          Font.Color := rec.fontColor;

          chRect.Left := Rect.Right - 8;
          chRect.Top := Rect.Top;
          chRect.Bottom := Rect.Bottom;
          chRect.Right := Rect.Right;
          FillRect(chRect);

          iTemp := Grid.Canvas.TextHeight(Grid.cells[ACol, ARow]);

          Brush.Color := sSkinManager1.GetGlobalColor;
          Font.Color := sSkinManager1.GetGlobalFontColor;
          ExtTextOut(handle, Rect.Left + 2, (Rect.Top + Rect.Bottom) div 2 - iTemp div 2,
            // ETO_CLIPPED or ETO_OPAQUE, @Rect, PChar(Grid.cells[ACol, ARow]),
            ETO_CLIPPED, @Rect, PChar(Grid.cells[ACol, ARow]), length(Grid.cells[ACol, ARow]), nil);

        end;

      if (zGotoCol > 0) and (zGotoRow > 0) then
      begin
        if ((ACol = zGotoCol)) and (ARow = zGotoRow) then
        begin
          Brush.Color := clHighLight;
          Font.Color := clBlack;
          Grid.BorderStyle := bsNone;
          FillRect(Rect);
          iTemp := Grid.Canvas.TextHeight(Grid.cells[ACol, ARow]);

          ExtTextOut(handle, Rect.Left + 2, (Rect.Top + Rect.Bottom) div 2 - iTemp div 2, ETO_CLIPPED or ETO_OPAQUE, @Rect, PChar(Grid.cells[ACol, ARow]),
            length(Grid.cells[ACol, ARow]), nil);

        end;
      end;
    except
    end;
  end;
end;

procedure TfrmMain.grOneDayRoomsEndColumnSize(Sender: TObject; ACol: integer);
begin
  if NOT assigned(CurrentlyActiveGrid) then
    exit;
  grOneDayRoomsResize(ActiveGrid);
end;

procedure TfrmMain.grOneDayRoomsEndDrag(Sender, Target: TObject; X, Y: integer);
begin
  pnlNoRoomDrop.Visible := false;
  ActiveGrid.Invalidate;
  ActiveGrid.Refresh;
  Screen.cursors[crNoDrop] := curNoDrop;
end;

procedure TfrmMain.timKillDragTimer(Sender: TObject);
begin

  timKillDrag.Enabled := false;

  zOneDay_bMouseDown := false;

  if ActiveGrid.dragging then
    ActiveGrid.EndDrag(false);
end;

procedure TfrmMain.timLogoutTimer(Sender: TObject);
begin
  frmMain.timLogout.Enabled := false;
  frmMain.btnLogOutClick(nil);
end;

procedure TfrmMain.timMessagesTimer(Sender: TObject);
var
  RoomerMessage: TRoomerMessage;
  systemMessage, anySystemMessage: boolean;
  RoomerMessageType: TRoomerMessageType;
  i: integer;
  iMinute: integer;

  ResList: TStrings;
  CancelList: TStrings;
begin
  // exit;
  FMessagesBeingDownloaded := true;
  try
    if NOT d.roomerMainDataSet.LoggedIn then
      exit;

    PushActivityLogs;

    if d.roomerMainDataSet.SecondsLeft <= 60 then
      exit;

    try
      timMessages.Enabled := false;
      lblCacheNotification.Visible := true;
      lblCacheNotification.Update;

      anySystemMessage := false;

      //      Beep;
      try
        if NOT OffLineMode then
        begin
          ResList := TStringList.Create;
          CancelList := TStringList.Create;
          try
            iMinute := StrToInt(FormatDateTime('n', now));
            if iMinute IN [0, 15, 30, 45] then
              d.BackUpDataForOutage;

            if iMinute IN [0] then
              glb.ReloadPreviousGuests;
            RoomerMessages.Refresh;
            for i := RoomerMessages.Count - 1 downto 0 do
            begin
              RoomerMessage := RoomerMessages.ActiveRoomerMessage[i];
              systemMessage := RoomerMessage.RoomerMessageType = 'SYSTEM_MESSAGE';
              if systemMessage AND NOT anySystemMessage then
              begin
                mmoMessage.HtmlText.Text := RoomerMessage.TheMessage;
                mmoMessage.Tag := RoomerMessage.id;
              end
              else if NOT systemMessage then
              begin
                if RoomerMessage.RoomerMessageType = 'RESERVATION_MESSAGE' then
                begin
                  ResList.Add(inttostr(RoomerMessage.id));
                  RoomerMessageType := rmtNewBooking;
                end
                else if RoomerMessage.RoomerMessageType = 'CANCELLATION_MESSAGE' then
                begin
                  CancelList.Add(inttostr(RoomerMessage.id));
                  RoomerMessageType := rmtCancellation;
                end
                else
                  RoomerMessageType := rmtUnknown;
                if RoomerMessageType <> rmtUnknown then
                begin
                  FrmMessagesTemplates.AddMessage(RoomerMessageType, RoomerMessage.TheMessage, '', inttostr(RoomerMessage.id));
                  RoomerMessages.Delete(i);
                end;
              end;
              anySystemMessage := anySystemMessage OR systemMessage;
            end;
            if ResList.Count > 0 then
              FrmMessagesTemplates.RemoveThoseNotInList(rmtNewBooking, ResList);
            if CancelList.Count > 0 then
              FrmMessagesTemplates.RemoveThoseNotInList(rmtNewBooking, CancelList);
            if OffLineMode then
              OffLineMode := false;
          except
{$IFDEF DEBUG}
            // if NOT OffLineMode then
            // raise Exception.Create('Message Retrieval failed');
{$ENDIF}
          end;
          ResList.Free;
          CancelList.Free;
          glb.RefreshTablesWhenNeeded;

          pnlMessages.Visible := anySystemMessage AND (RoomerMessages.ActiveCount > 0);

          pnlNotifications.Visible := FrmMessagesTemplates.MessageList.Count > 0;

          if pnlNotifications.Visible then
          begin
            i := FrmMessagesTemplates.HeightNeeded;
            if i > 145 then
              i := 145;
            pnlNotifications.Height := i;
          end;
          Panel5.Top := grdRoomClasses.Top;
          pnlNotifications.Top := Panel5.Top; // pnlDateStatistics.Top + pnlDateStatistics.Height + 1;

        end
        else
          btnGoOnline.Visible := d.roomerMainDataSet.IsConnectedToInternet AND d.roomerMainDataSet.RoomerPlatformAvailable;

      finally
        lblCacheNotification.Visible := false;
        timMessages.Enabled := true;
      end;
    except

    end;
  finally
    FMessagesBeingDownloaded := false;
  end;
end;

procedure TfrmMain.timRetryRefreshTimer(Sender: TObject);
begin
  timRetryRefresh.Enabled := false;
  RefreshGrid(timRetryRefresh.Tag);
end;

procedure TfrmMain.timSearchTimer(Sender: TObject);
begin
  timSearch.Enabled := false;
  timSearch.Interval := 1000;
  RedisplayGuestWindows;
end;

procedure TfrmMain.pnlNoRoomDropDragDrop(Sender, Source: TObject; X, Y: integer);
var
  // ACol : integer;

  idxReservation, idxRoomReservation: integer;

  iRoomReservation: integer;

begin
  idxReservation := zOneDayResPointers[iDragCell.Y].ptrRooms[OneDay_GetIsLeftOrRight(iDragCell.X), 1];
  // Reservation Index
  idxRoomReservation := zOneDayResPointers[iDragCell.Y].ptrRooms[OneDay_GetIsLeftOrRight(iDragCell.X), 2];
  // Rooms Index
  iRoomReservation := ReservationsModel.Reservations[idxReservation].Rooms[idxRoomReservation].RoomRes;

  // if ACol > 6 then
  // ACol := 7
  // else
  // ACol := 0;

  MoveToRoomEnh2(iRoomReservation, '');
  zDebug1 := '160';
  RefreshGrid;
end;

procedure TfrmMain.pnlNoRoomDropDragOver(Sender, Source: TObject; X, Y: integer; State: TDragState; var Accept: boolean);
begin
  Accept := false;
  if Source is TAdvStringGrid then
  begin
    Accept := true;
  end;
  if State = dsDragEnter then
  begin
    if Accept then
    begin
      pnlNoRoomDrop.Color := sSkinManager1.GetHighLightColor; // clWhite;
      lblNoRoom.Font.Color := sSkinManager1.GetHighLightFontColor; // clBlack;
    end;
  end
  else if State = dsDragLeave then
  begin
    if pnlNoRoomDrop.Color = sSkinManager1.GetHighLightColor then
    // clWhite then
    begin
      pnlNoRoomDrop.Color := sSkinManager1.GetGlobalColor; // $00FFFFC1;
      lblNoRoom.Font.Color := sSkinManager1.GetGlobalFontColor; // $00FFFFC1;
    end;
  end;

end;

procedure TfrmMain.pnlRoomerLogoDblClick(Sender: TObject);
begin
{$IFDEF DEBUG}
  if NOT OffLineMode then
    d.BackUpDataForOutage;
  OffLineMode := NOT OffLineMode;
{$ENDIF}
end;

procedure TfrmMain.pnlRoomerLogoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
{$IFDEF DEBUG}
  if Button = mbRight then
    OffLineMode := NOT OffLineMode;
{$ENDIF}
end;


/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////

// ------------------------------------------------------------------------------

procedure TfrmMain.Period_setColCount(nights: integer);
var
  s: string;
begin
  if pageMainGrids.ActivePage = tabPeriod then
  begin
    zNights := nights;
    zDateTo := zDateFrom + nights;
    dateTimeToString(s, 'dd.mm.yyyy', zDateTo);
    grPeriodRooms.ColCount := zNights + grPeriodRooms.FixedCols;
    grPeriodRooms_NO.ColCount := grPeriodRooms.ColCount;
    zDebug1 := '170';
    RefreshGrid;
  end;
end;

procedure TfrmMain.grPeriodRoomsGetCellColor(Sender: TObject; ARow, ACol: integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
var
  rec: recStatusAttr;
  BColor: TColor;
  FColor: TColor;

  status: string;
  AscIndex: integer;
  DescIndex: integer;

  weekDay: integer;
  colDate: Tdate;

  // fStyle: TFontStyles;

  _grid: TAdvStringGrid;
begin
  _grid := TAdvStringGrid(Sender);
  colDate := Period_ColToDate(ACol);
  weekDay := dayOfWeek(colDate);
  if cbxViewTypes.ItemIndex > 0 then
  begin
    AFont.name := 'Segoe UI';
    AFont.size := 12;
  end;
  if (gdSelected IN AState) then // OR (gdSelected IN State) then
  begin
    ABrush.Color := clHighLight; // sSkinManager1.GetGlobalFontColor;
    AFont.Color := clWhite; // sSkinManager1.GetGlobalColor;
  end
  else
  begin
    ABrush.Color := sSkinManager1.GetActiveEditColor;
    AFont.Color := sSkinManager1.GetActiveEditFontColor;
  end;
  AFont.Style := [];
  if (ARow IN [0, 1]) OR (ACol IN [3, 4]) then
  begin
    if (cbxViewTypes.ItemIndex > 0) AND (LowerCase(Copy(sSkinManager1.skinName, 1, 6)) = 'roomer') then
    begin
      if ARow IN [0] then
        ABrush.Color := HexToTColor('c1eeff')
      else
        ABrush.Color := HexToTColor('daf5ff'); // sSkinManager1.GetGlobalColor;
      AFont.Color := sSkinManager1.GetGlobalFontColor;
    end
    else
    begin
      ABrush.Color := sSkinManager1.GetGlobalColor;
      AFont.Color := sSkinManager1.GetGlobalFontColor;
    end;
    AFont.Style := [fsBold];
    // if (ARow IN [0, 1]) OR (ACol > _grid.FixedCols) then
    // if weekDay IN [1, 7] then
    // begin
    // if cbxViewTypes.ItemIndex = 0 then
    // ABrush.Color := HexToTColor('FFC2C2')
    // else
    // ABrush.Color := HexToTColor('F7F7F7');
    // end;
    exit;
  end;

  if (ACol > grPeriodRooms.FixedCols - 1) and (ARow > grPeriodRooms.FixedRows - 1) and ((ARow <> grPeriodRooms.RowCount - 1) OR grPeriodViewFilterOn) then
  begin

    if SearchActive then
    begin
      if (grPeriodRooms.Objects[ACol, ARow] <> nil) AND (grPeriodRooms.Objects[ACol, ARow] IS TresCell) then
        if NOT FilterPassededForPeriodData(TresCell(grPeriodRooms.Objects[ACol, ARow])) then
        begin
          ABrush.Color := clSilver;
          // ABrush.Style := bsDiagCross;
          AFont.Color := clGray;
        end;
    end;

    if grPeriodViewFilterOn AND (ACol <> ZPeriodRoomOnTheMoveCol) then
    begin
      ABrush.Color := clSilver;
      ABrush.Style := bsDiagCross;
      AFont.Color := clSilver;
    end
    else
    begin
      FColor := clRed;
      BColor := clRed;

      if weekDay IN [1, 7] then
      begin
        if cbxViewTypes.ItemIndex = 0 then
          ABrush.Color := HexToTColor('FFC2C2')
        else
          ABrush.Color := HexToTColor('F7F7F7');
      end;

      // if weekDay = 7 then
      // begin
      // ABrush.Color := HexToTColor('FFDCDC');
      // end;

    end;
  end;

end;

procedure TfrmMain.grPeriodRoomsGridHint(Sender: TObject; ARow, ACol: integer; var HintStr: string);
var
  ARect: TRect;
begin
  if (g.qShowhint OR (HintStr = 'FORCE')) AND (NOT zPeriod_bMouseDown) then
  begin
    ARect := TAdvStringGrid(Sender).CellRect(ACol, ARow);
    HintStr := Period_CheckHint(Sender, ARect.Left + 1, ARect.Top + 1);
  end
  else
    HintStr := '';
end;

procedure TfrmMain.grPeriodRoomsClickCell(Sender: TObject; ARow, ACol: integer);
var
  aDate: Tdate;
  iRoomReservation: integer;
begin
  if (ACol < (Sender as TAdvStringGrid).FixedCols) then
    exit;

  zGridTag := (Sender as TAdvStringGrid).Tag;

  // if (ACol = 0) and (ARow = 1) then
  // begin
  // tabsView.TabIndex := 0;
  // pageMainGrids.ActivePage := tabOneDayView;
  // pageMainGridsChange(pageMainGrids);
  // exit;
  // end;
  //
  // if (ACol = 0) and (ARow = 0) then
  // begin
  // btnRefreshOneDay.Click;
  // exit;
  // end;

  aDate := Period_ColToDate(ACol);
  timGetRoomStatuses.Tag := trunc(aDate);
  timGetRoomStatuses.Enabled := true;

  grPeriodRooms.col := ACol;
  grPeriodRooms.row := ARow;

  try
    if assigned(grPeriodRooms.Objects[ACol, ARow]) then
    begin
      iRoomReservation := (grPeriodRooms.Objects[ACol, ARow] as TresCell).RoomReservation;
      EnableDisableFunctions(iRoomReservation >= 0);
    end
    else
      EnableDisableFunctions(false);
  except
    EnableDisableFunctions(false);
  end;

  try
    frmDayNotes.edCurrentDate.Text := DateToStr(dtDate.Date);
  Except
  end;

  grPeriodRooms.Invalidate;

end;

procedure TfrmMain.grPeriodRoomsGetAlignment(Sender: TObject; ARow, ACol: integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ACol IN [1, 2]) OR (ARow IN [0, 1]) then
    VAlign := tvaCenter;
end;

procedure TfrmMain.grPeriodRoomsGetCellBorder(Sender: TObject; ARow, ACol: integer; APen: TPen; var Borders: TCellBorders);
var
  status: string;
  AscIndex: integer;
  DescIndex: integer;

  borderColor: TColor;

  Left, Top, Right, Bottom: integer;

  rri: RecRRInfo;

begin
  APen.Style := psSolid;
  Borders := [];

  if cbxViewTypes.ItemIndex > 0 then
    APen.Color := clSilver;

  if grPeriodViewFilterOn then
  begin
    APen.Color := clSilver; // BorderColor;
    APen.Width := 3;
    // LeftPen.Color := clRed;
    // LeftPen.Width := 3;
    // TopPen.Color := clRed;
    // TopPen.Width := 3;
    // RightPen.Color := clRed;
    // RightPen.Width := 3;
    // BottomPen.Color := clRed;
    // BottomPen.Width := 3;
  end
  else if (ACol >= grPeriodRooms.FixedCols) and (ARow >= grPeriodRooms.FixedRows) and ((ARow <> grPeriodRooms.RowCount - 1) OR grPeriodViewFilterOn) then
  begin
    // Borders :=  [cbLeft,cbTop,cbBottom, cbTop];
    Borders := [];
    // APen.Color := clltGray;
    APen.Width := 1;

    if Period_GetResStatus(TAdvStringGrid(Sender), ACol, ARow, status, AscIndex, DescIndex) then
    begin
      if ResObjToBorder(status, AscIndex, DescIndex, borderColor, Left, Top, Right, Bottom) then
      begin
        Borders := [];
        // if Left > 0 then
        // Borders := Borders + [cbLeft];
        // if Top > 0 then
        // Borders := Borders + [cbTop];
        // if Bottom > 0 then
        // Borders := Borders + [cbBottom];
        // if Right > 0 then
        // Borders := Borders + [cbRight];

        // rri := Period_GetResInfo(ACol, ARow, 1);
        // APen.color := getChannelColorByChannel(rri.Channel);
        APen.Color := clBlack; // BorderColor;
        APen.Style := psClear;
        APen.Width := 1;
      end;
    end;
  end;
end;

procedure TfrmMain.dtDateChange(Sender: TObject);
begin
  zDateFrom := trunc(dtDate.Date);
  zDateTo := zDateFrom + zNights;
  PostMessage(handle, WM_REFRESH_DATE, 0, 0);

  // RefreshGrid; // StartOneDay;

  // RefreshGrid;

  // if ViewMode = vmPeriod then
  // begin
  // zdebug1 := '190';
  // RefreshGrid;
  /// /        RefreshGrid;
  // end else
  // if ViewMode = vmOneDay then
  // begin
  // if zStartOneDay then
  // begin
  // g.qDebug1 := 'dtDateChange(Sender : TObject)';
  // startOneDay;
  // end;
  // end else
  // if ViewMode = vmGuestList then
  // begin
  // refreshGuestList
  // end;
  //
  // zStartOneDay := false;
end;

procedure TfrmMain.grPeriodRoomsEndColumnSize(Sender: TObject; ACol: integer);
begin
  Period_RestoreColumnSize;
end;

procedure TfrmMain.grPeriodRoomsEnter(Sender: TObject);
begin
  CurrentlyActiveGrid := TAdvStringGrid(Sender);
end;

procedure TfrmMain.grPeriodRoomsDblClickCell(Sender: TObject; ARow, ACol: integer);
var
  _grid: TAdvStringGrid;
  Rect: TRect;
  Point: TPoint;
  rri: RecRRInfo;
  newRoom: String;
  isCtrlOn, isFiltering: boolean;

  iReservation, iRoomReservation: integer;

const
  iExtraSpace = PERIOD_GRID_RECTANGLES_WIDTH;
begin

  zPeriod_bMouseDown := false;
  if grPeriodViewFilterOn then
  begin
    isFiltering := grPeriodViewFilterOn;
    isCtrlOn := ZPeriodRoomOnTheMoveForceType;

    if Sender = grPeriodRooms_NO then
      newRoom := ''
    else
      newRoom := grPeriodRooms.cells[1, ARow];

    MoveToRoomEnh2(ZPeriodRoomOnTheMoveRoomReservation, newRoom);
    if isFiltering then
    begin
      ShowAllRoomsRows;
      btnRefreshOneDay.Click;
    end;

    RefreshGrid;

    if isFiltering then
    begin
      grPeriodViewFilterOn := isFiltering;
      ZPeriodRoomOnTheMoveForceType := isCtrlOn;
      if newRoom <> '' then
        FindRoomInPeriodView(newRoom);
      ReEnableFiltersInPeriodGrid;
      EnterPeriodDragFilter;
    end;

    exit;
  end;
  // else
  // if grPeriodViewFilterOn then
  // begin
  // ShowAllRoomsRows;
  // btnRefreshOneDay.Click;
  // exit;
  // end;

  _grid := (Sender as TAdvStringGrid);
  zGridTag := _grid.Tag;
  Rect := _grid.CellRect(ACol, ARow);

  // double click on Room Column
  if (zGridTag = 1) AND (ACol = 1) then
  begin
    // -- Set the room status
    if trim(grPeriodRooms.cells[ACol, ARow]) = '' then
      exit;

    Point.X := Rect.Left;
    Point.Y := Rect.Top;
    Point := grPeriodRooms.ClientToScreen(Point);
    SetRoomCleanAndMaintenanceStatus(grPeriodRooms.cells[ACol, ARow], Point.X, Point.Y);
    // SetRoomStatus(grOneDayRooms.cells[grOneDayRooms.col, grOneDayRooms.row], Point.X, Point.Y);

    zOneDay_bMouseDown := false;
    if grPeriodRooms.dragging then
      grPeriodRooms.EndDrag(false);
    // RefreshGrid();
    // grPeriodRooms.Invalidate;
    // tabsViewChange(tabsView);
    FillPeriodGridWithRooms;
    AutoSizePeriodColumns;
  end
  else if (ACol >= (Sender as TAdvStringGrid).FixedCols) and (ARow >= (Sender as TAdvStringGrid).FixedRows) then
  begin
    if (HoverPointPeriod.X >= Rect.Right - 1 - iExtraSpace) AND (HoverPointPeriod.X <= Rect.Right - 1) then
    begin
      Open_RES_edForm(_grid);
    end
    else

      if (HoverPointPeriod.X >= Rect.Right - 2 - (iExtraSpace * 2)) AND (HoverPointPeriod.X <= Rect.Right - 1 - iExtraSpace) then
    begin
      rri := Period_GetResInfo(ACol, ARow, _grid.Tag);
      // rri := Period_GetResInfo;
      iReservation := rri.Reservation;
      iRoomReservation := rri.RoomReservation;

      if rri.PaymentInvoice > 0 then
      begin
        if rri.GroupAccount then
        begin
          ShowFinishedInvoices2(itPerReservation, '', iReservation);
          // btnClosedInvoicesThisreservation.Click
        end
        else
        begin
          ShowFinishedInvoices2(itPerRoomRes, '', iRoomReservation);
          // btnClosedInvoicesThisRoom.Click;
        end;
      end
      else if rri.GroupAccount then
        btnGroupInvoice.Click
      else
        btnRoomInvoice.Click;
    end
    else

      if (HoverPointPeriod.X >= Rect.Right - 3 - (iExtraSpace * 3)) AND (HoverPointPeriod.X <= Rect.Right - 2 - (iExtraSpace * 2)) then
    begin
      btnRoomInvoice.Click;
    end
    else

      Open_RES_edForm(_grid);
  end;

end;

procedure TfrmMain.SetViews(ViewIndex: integer);
var
  aDate: integer;
begin
  case ViewIndex of
    1:
      begin
        DisplayStatusses(true);
        if Assigned(frmDaysStatistics) then
        begin
          frmDaysStatistics.BeingViewed := false;
          FrmRateQuery.BeingViewed := false;
          EnterDayView;
          RefreshStats;
        end;
      end;
    2:
      begin
        DisplayStatusses(false);
        frmDaysStatistics.BeingViewed := false;
        FrmRateQuery.BeingViewed := false;
        lblLoading.Show;
        lblLoading.Update;
        try
          EnterPeriodView;
          AutoSizePeriodColumns;
        finally
          lblLoading.Hide;
        end;
        RefreshStats;
      end;
    3:
      begin
        DisplayStatusses(true);
        frmDaysStatistics.BeingViewed := false;
        FrmRateQuery.BeingViewed := false;
        EnterGuestListView;
      end;
    4:
      begin
        DisplayStatusses(true);
        frmDaysStatistics.BeingViewed := true;
        EnterDashboardView;
      end;
    5:
      begin
        aDate := trunc(dtDate.Date);
        DisplayStatusses(true);
        FrmRateQuery.BeingViewed := true;
        EnterRateQueryView(aDate);
      end;
  end;
end;

procedure TfrmMain.EnterDashboardView;
begin
  frmDaysStatistics.sPanel1.Parent := tabDashboard;
  ViewMode := vmDashboard;
  if tabsView.TabIndex <> 3 then
    tabsView.TabIndex := 3;
  pageMainGrids.ActivePage := tabDashboard;
  frmDaysStatistics.ViewDate := dtDate.Date;
  tabDashboard.Update;
end;

procedure TfrmMain.EnterRateQueryView(aDate: integer);
begin
  FrmRateQuery.pnlHolder.Parent := tabRateQuery;
  PostMessage(handle, WM_SET_DATE_FROM_MAIN, 0, trunc(aDate));
  ViewMode := vmRateQuery;
  if tabsView.TabIndex <> 4 then
    tabsView.TabIndex := 4;
  pageMainGrids.ActivePage := tabRateQuery;
  // frmRateQuery.ShowRatesForDate(dtDate.Date);
  FrmRateQuery.pnlHolder.Update;
  tabRateQuery.Update;
end;

procedure TfrmMain.EnterPeriodView;
begin
  // if grPeriodViewFilterOn then
  // ShowAllRoomsRows;

  if ViewMode = vmPeriod then
    exit;

  grPeriodRooms.BeginUpdate;
  grPeriodRooms_NO.BeginUpdate;
  lblLoading.Show;
  lblLoading.Update;
  try
    zGridTag := 1;

    if tabsView.TabIndex <> 1 then
      tabsView.TabIndex := 1;

    ViewMode := vmPeriod;

    pageMainGrids.ActivePage := tabPeriod;
    AutoSizePeriodColumns;

    Period_SetDateHeads;
    Period_FillEmptyResCells;

    // Must come before FillResCell
    grNoRooms_ClearAll;
    grNoRooms_FillEmptyResCells;

    Period_FillResCells;
    Period_MergeGrid;

    grNoRooms_MergeGrid;
    grAutoSizeGrids;

    if btnOccupancyView.Down then
    begin
      embOccupancyView.ShowOccupancy(zDateFrom, zDateFrom + zNights);
      PostMessage(handle, WM_REFRESH_PERIOD_VIEW_BOTTOM, 0, 0);
    end;

  finally
    lblLoading.Hide;
    grPeriodRooms.endUpdate;
    grPeriodRooms_NO.endUpdate;
    grPeriodRooms.Invalidate;
  end;
end;

procedure TfrmMain.EnterDayView;
var
  dt: TdateTime;
begin
  if ViewMode = vmOneDay then
    exit;
  if ViewMode = vmPeriod then
  begin
    dt := Period_ColToDate(grPeriodRooms.col);
    SetDateWithoutEvents(trunc(dt));
  end;
  ViewMode := vmOneDay;

  if tabsView.TabIndex <> 0 then
    tabsView.TabIndex := 0;

  pageMainGrids.ActivePage := tabOneDayView;
  zDebug1 := '200';
  RefreshGrid;
end;

procedure TfrmMain.EnterGuestListView;
begin
  if ViewMode = vmGuestList then
    exit;

  ViewMode := vmGuestList;

  if tabsView.TabIndex <> 2 then
    tabsView.TabIndex := 2;

  pageMainGrids.ActivePage := tabGuestList;
  refreshGuestList;
  zGuestListFirstTime := false;
end;

procedure TfrmMain.timCheckSessionExpiredTimer(Sender: TObject);
var
  res: String;
begin
  if NOT d.roomerMainDataSet.LoggedIn then
    exit;
  timCheckSessionExpired.Enabled := false;
  if d.roomerMainDataSet.SecondsLeft <= 10 then
  begin
    if (LowerCase(ParameterByName('KeepAlive')) <> 'true') then
    begin
      lblAuthStatus.Caption := GetTranslatedText('shTx_Main_AutoLoggedOff');
      btnLogOutClick(nil);
    end
    else
    begin
      res := d.roomerMainDataSet.KeepSessionAlive;
    end;
  end
  else
    timCheckSessionExpired.Enabled := true;
end;

procedure TfrmMain.timGetRoomStatusesTimer(Sender: TObject);
begin
  timGetRoomStatuses.Enabled := false;
  try
    frmDayNotes.edCurrentDate.Text := DateToStr(timGetRoomStatuses.Tag);
  Except
  end;
  DisplayRoomStatusses(timGetRoomStatuses.Tag);
end;

procedure TfrmMain.timHaltTimer(Sender: TObject);
begin
  timHalt.Enabled := false;
  ExitProcess(13);
end;

procedure TfrmMain.timHideTimeMessageTimer(Sender: TObject);
begin
  timHideTimeMessage.Enabled := false;

  pnlTimeMessage.Top := pnlTimeMessage.Top - 2;
  pnlTimeMessage.Refresh;
  pnlTimeMessage.Invalidate;

  timHideTimeMessage.Interval := (pnlTimeMessage.Height + 1) - ABS(pnlTimeMessage.Top);
  timHideTimeMessage.Enabled := pnlTimeMessage.Top > -pnlTimeMessage.Height;

  if NOT timHideTimeMessage.Enabled then
    pnlTimeMessage.Hide;
end;

procedure TfrmMain.DisplayRoomStatusses(Date: TdateTime);
var
  rSet: TRoomerDataSet;
  i, idx: integer;
  sText: String;
  StatusCont: TRoomClassChannelAvailabilityContainer;
  ChAvail, chAvailMax: integer;
  AnyStop: boolean;

  dcField: TField;
begin
  // grdRoomStatusses.DefaultColWidth := (grdRoomStatusses.ClientWidth) div 3;
  // grdRoomClasses.DefaultColWidth := grdRoomStatusses.DefaultColWidth;
  try
    if lastDate = Date then
      exit;

    dcField := nil;
    lastDate := Date;

    pnlDateStatistics.Caption := ' ' + DateToStr(Date) + ' ' + FormatDateTime('dddd', Date);

    if d.roomerMainDataSet.OffLineMode then
      exit;

    grdRoomClasses.BeginUpdate;
    grdRoomStatusses.BeginUpdate;
    try
      grdRoomStatusses.DefaultColWidth := grdRoomStatusses.ClientWidth div grdRoomStatusses.ColCount;
      grdRoomClasses.DefaultColWidth := grdRoomClasses.ClientWidth div grdRoomClasses.ColCount;

      rSet := d.roomerMainDataSet.ActivateNewDataset(d.roomerMainDataSet.SystemGetRoomTypeStatus(Date, Date));
      try
        rSet.first;
        for i := 1 to grdRoomStatusses.RowCount - 1 do
          grdRoomStatusses.cells[2, i] := GetAvailableCellText(StrToInt(grdRoomStatusses.cells[1, i]));

        for i := 1 to grdRoomClasses.RowCount - 1 do
        begin
          grdRoomClasses.cells[2, i] := grdRoomClasses.cells[1, i];
          grdRoomClasses.cells[3, i] := inttostr(DEFAULT_UNPARSABLE_INT_VALUE);
          StatusCont := availListContainer[i - 1];
          // TRoomClassChannelAvailabilityContainer(grdRoomClasses.Objects[3, i]);
          StatusCont.Reserved := 0;
        end;

        while not rSet.eof do
        begin
          idx := RoomTypeIndexInGrid(grdRoomStatusses, rSet['RoomType']);
          if idx >= 0 then
          begin
            sText := inttostr(StrToInt(grdRoomStatusses.cells[1, idx]) - rSet['Reserved']);
            // GetAvailableCellText(strtoint(grdRoomStatusses.Cells[1, idx]) - rSet['Reserved']);
            grdRoomStatusses.cells[2, idx] := sText;
          end;
          idx := RoomTypeIndexInGrid(grdRoomClasses, rSet['RoomTypeGroup']);
          if idx >= 0 then
          begin
            ChAvail := 0;
            chAvailMax := 0;
            AnyStop := false;
            // dcField := rSet.Fields.FindField('directConnection');
            // if (NOT Assigned(dcField)) then
            // begin
            ChAvail := rSet['ChannelAvailable'];
            // end else
            // if (NOT rSet['directConnection']) then
            // begin
            // if rSet.Fields.FindField('ChannelAvailable') <> nil then
            // ChAvail := rSet['ChannelAvailable'];
            // end else
            // if rSet.Fields.FindField('DirectChannelAvailable') <> nil then
            // ChAvail := rSet['DirectChannelAvailable'];

            chAvailMax := rSet['ChannelMaxAvailable'];
            if rSet.Fields.FindField('anyStop') <> nil then
              AnyStop := rSet['anyStop'];
            StatusCont := availListContainer[idx - 1];
            // TRoomClassChannelAvailabilityContainer(grdRoomClasses.Objects[3, idx]);
            StatusCont.Reserved := StatusCont.Reserved + rSet['Reserved'];
            StatusCont.ChannelAvailable := ChAvail;
            StatusCont.ChannelMaxAvailable := chAvailMax;
            StatusCont.AnyStop := AnyStop;

            if (NOT assigned(dcField)) then
              grdRoomClasses.Objects[3, idx] := Pointer(1)
            else if rSet['directConnection'] then
              grdRoomClasses.Objects[3, idx] := Pointer(2)
            else
              grdRoomClasses.Objects[3, idx] := Pointer(1);

            sText := inttostr(StatusCont.NumRooms - StatusCont.Reserved);
            grdRoomClasses.cells[2, idx] := sText;
            sText := inttostr(StatusCont.ChannelAvailable);
            grdRoomClasses.cells[3, idx] := sText;
          end;
          rSet.next;
        end;
        // for i := 1 to grdRoomClasses.RowCount - 1 do
        // grdRoomClasses.Cells[2, i] := GetAvailableCellText(strtoint(grdRoomClasses.Cells[2, i]));
      finally
        freeandNil(rSet);
      end;
    finally
      grdRoomClasses.endUpdate;
      grdRoomStatusses.endUpdate;
    end;
  finally
    grdRoomClasses.Invalidate;
  end;
end;

function TfrmMain.GetAvailableCellText(Value: integer): String;
var
  sColor, sText: String;
  iRes: integer;
begin
  sText := inttostr(Value);
  if Value < 0 then
    sColor := '#FF0000'
  else if Value = 0 then
    sColor := '#000000'
  else
    sColor := '#0000FF';
  result := Format('<p align="right"><font color="%s" size="7"><b>%s</b></font></p>', [sColor, sText]);
end;

function TfrmMain.RoomTypeIndexInGrid(Grid: TAdvStringGrid; RoomType: String): integer;
var
  i: integer;
begin
  result := -1;
  for i := 0 to Grid.RowCount - 1 do
    if Grid.cells[0, i] = RoomType then
    begin
      result := i;
      break;
    end;

end;

/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////
//
// +--------------------------------------+
// |             Period Grid              |
// +--------------------------------------+
//
//
/// /////////////////////////////////////////////////////////////////////////////

function TfrmMain.Period_Init: integer;
begin
  result := 0;
  grPeriodRooms.DefaultColWidth := g.qPeriodColWidth;
  grPeriodRooms.DefaultRowHeight := getRowHeightFromIndex(cbxViewTypes.ItemIndex);
  grPeriodRooms_NO.DefaultRowHeight := getRowHeightFromIndex(cbxViewTypes.ItemIndex);

  grPeriodRooms.RowCount := 4;
  grPeriodRooms.FixedRows := grPeriodRooms.RowCount - 1;
  grPeriodRooms.ColCount := zNights + 6;

  grPeriodRooms.FixedCols := 5;
  grPeriodRooms.colWidths[0] := 000;
  grPeriodRooms.colWidths[1] := 040;
  grPeriodRooms.colWidths[2] := 040; // * ABS(ORD(cbxViewTypes.ItemIndex = 0));;

  // grPeriodRooms.colWidths[3] := 100;
  grPeriodRooms.colWidths[3] := 5;
  grPeriodRooms.colWidths[4] := 0;

  grPeriodRooms.RowHeights[0] := 25;
  if cbxViewTypes.ItemIndex = 0 then
    grPeriodRooms.RowHeights[1] := getRowHeightFromIndex(cbxViewTypes.ItemIndex)
  else
    grPeriodRooms.RowHeights[1] := 25;
  grPeriodRooms.RowHeights[2] := 0;

  grPeriodRooms.MergeCells(0, 0, grPeriodRooms.FixedCols, 1);
  grPeriodRooms.MergeCells(0, 1, grPeriodRooms.FixedCols, 1);

  grPeriodRooms.cells[0, 0] := { 1070 } 'Refresh'; //
  grPeriodRooms.cells[0, 1] := { 1072 } GetTranslatedText('shToOneDay');
end;

function TfrmMain.Period_GetRooms: integer;
begin
  result := 0;
  ClearStringGridRows(grPeriodRooms, grPeriodRooms.RowCount - 1, 1);

  grPeriodRooms.RowCount := grPeriodRooms.RowCount + g.oRooms.RoomCount;
  FillPeriodGridWithRooms;

  (*

    //      Rooms := TRoom.Create('', '');
    //      try
    zRoomsOBJ.Refresh('','Room');
    grPeriodRooms.ClearRows(grPeriodRooms.RowCount - 1, 1);

    startRow := grPeriodRooms.RowCount;
    RowIndex := startRow - 2;

    zRoomsOBJ.qMT_.first;
    while not zRoomsOBJ.qMT_.eof do
    begin
    inc(RowIndex);

    status := zRoomsOBJ.qMT_.FieldByName('Status').asString;
    grPeriodRooms.Objects[grRoom_Room, RowIndex] := TRoomCell.Create(status);

    grPeriodRooms.cells[grRoom_Room, RowIndex] := zRoomsOBJ.qMT_.FieldByName('Room').asString;
    grPeriodRooms.cells[grRoom_RoomType, RowIndex] := zRoomsOBJ.qMT_.FieldByName('RoomType').asString;
    if zShowRoomDescription then
    begin
    grPeriodRooms.cells[grRoom_RoomDescription, RowIndex] := zRoomsOBJ.qMT_.FieldByName('RoomDescription').asString;
    end;
    grPeriodRooms.AddRow;
    zRoomsOBJ.qMT_.next;
    end;
    //      finally
    //      freeandnil(Rooms);
    //      end;

  *)
end;

procedure TfrmMain.Period_SetDateHeads;
var
  dayStartCol: integer;
  i: integer;
  aDate: Tdate;
  s: string;
begin
  dayStartCol := 4;
  aDate := zDateFrom;
  for i := 1 to zNights + 2 do
  begin
    dateTimeToString(s, g.qPeriodDateformat2, aDate);
    grPeriodRooms.cells[i + dayStartCol, 1] := s;
    dateTimeToString(s, g.qPeriodDateformat1, aDate);
    grPeriodRooms.cells[i + dayStartCol, 0] := ANSIUpperCase(s);
    aDate := aDate + 1;
  end;
end;

procedure TfrmMain.Period_FillEmptyResCells;
var
  i: integer;
  ii: integer;

begin
  for i := grPeriodRooms.FixedCols to grPeriodRooms.ColCount - 1 do
  begin
    for ii := grPeriodRooms.FixedRows to grPeriodRooms.RowCount - 2 do
    begin
      try
        if grPeriodRooms.Objects[i, ii] <> nil then
        begin
          if grPeriodRooms.Objects[i, ii] IS TresCell then
            TresCell(grPeriodRooms.Objects[i, ii]).Free;
          grPeriodRooms.Objects[i, ii] := nil;
        end;
      except
      end;
      // grPeriodRooms.Objects[i, ii].free ;
      // grPeriodRooms.Objects[i, ii] := nil ;
    end;
  end;

  // If Clear normal cells is freeing the object in the cells then a memory leak
  // will accore
  grPeriodRooms.ClearNormalCells;

  for i := grPeriodRooms.FixedCols to grPeriodRooms.ColCount - 1 do
  begin
    for ii := grPeriodRooms.FixedRows to grPeriodRooms.RowCount - 2 do
    begin
      grPeriodRooms.Objects[i, ii] := TresCell.Create(-1, -1, -1, -1, -1, -1, false, '', '', '', '', false, 1, '', '', '', '', '', '', '', '', '', 0.00, 0.00,
        false, false, 0, '', false, false, 0, 0, 0, '', '', 0, 0);
    end;
  end;

end;

function TfrmMain.AnyPeriodRowsMinimized: boolean;
var
  i: integer;
begin
  result := false;
  for i := grPeriodRooms.FixedRows to grPeriodRooms.RowCount - 1 do
    if grPeriodRooms.RowHeights[i] = 0 then
    begin
      result := true;
      break;
    end;

  if NOT result then
    for i := grPeriodRooms_NO.FixedRows to grPeriodRooms_NO.RowCount - 1 do
      if grPeriodRooms_NO.RowHeights[i] = 0 then
      begin
        result := true;
        break;
      end;
end;

procedure TfrmMain.ShowAllPeriodRows;
var
  i: integer;
begin
  for i := grPeriodRooms.FixedRows to grPeriodRooms.RowCount - 1 do
    grPeriodRooms.RowHeights[i] := getRowHeightFromIndex(cbxViewTypes.ItemIndex);

  for i := grPeriodRooms_NO.FixedRows to grPeriodRooms_NO.RowCount - 1 do
    grPeriodRooms_NO.RowHeights[i] := getRowHeightFromIndex(cbxViewTypes.ItemIndex);
end;

procedure TfrmMain.Period_FillResCells(Days: integer = 0);
var
  rdOBJ: TRoomDates;
  i: integer;
  dt: Tdate;

  Room: string;
  RoomType: string;
  resFlag: string;
  RoomReservation: integer;
  Reservation: integer;

  AscIndex: integer;
  DescIndex: integer;

  currentRow: integer;
  currentCol: integer;

  cords: recColRow;

  isNoRoom: boolean;

  customer, CustomerName: string;

  found: boolean;

  s: Utf8String;

  GuestName: string;

  OutOfOrderBlocking, BlockMove: boolean;

  procedure CleanEnds(Days: integer; Grid: TAdvStringGrid);
  var
    iCol, iRow, iDay: integer;
  begin

    for iCol := Grid.FixedCols to Grid.ColCount - 1 do
      for iRow := Grid.FixedRows to Grid.RowCount - 1 do
      begin
        Grid.cells[iCol, iRow] := '';
        if (Grid.Objects[iCol, iRow] IS TresCell) then
          try
            (Grid.Objects[iCol, iRow] AS TresCell).Free;
          except
          end;
        Grid.Objects[iCol, iRow] := TresCell.Create(-1, -1, -1, -1, -1, -1, false, '', '', '', '', false, 1, '', '', '', '', '', '', '', '', '', 0.00, 0.00,
          false, false, 0, '', false, false, 0, 0, 0, '', '', 0, 0);
      end;
    exit;

    if Days = 0 then
      exit;

    if Days < 0 then
    begin
      // Remove Onjects that will be going out of screen
      // for iCol := grid.ColCount - ABS(Days) to grid.ColCount - 1 do
      // for iRow := 0 to grid.RowCount - 1 do
      // begin
      // if grid.Objects[iCol, iRow] <> nil then
      // begin
      // TresCell(grid.Objects[iCol, iRow]).free;
      // grid.Objects[iCol, iRow] := nil;
      // end;
      // end;
      // grid.InsertCols(grid.FixedCols, Days);
      for iDay := 1 to ABS(Days) do
      begin
        for iCol := Grid.ColCount - 2 downto Grid.FixedCols do
          for iRow := 0 to Grid.RowCount - 1 do
          begin
            Grid.cells[iCol + 1, iRow] := Grid.cells[iCol, iRow];
            Grid.Objects[iCol + 1, iRow] := Grid.Objects[iCol, iRow];
            Grid.cells[iCol, iRow] := '';
            Grid.Objects[iCol, iRow] := nil;
          end;
        for iRow := 0 to Grid.RowCount - 1 do
        begin
          Grid.cells[Grid.FixedCols, iRow] := '';
          Grid.Objects[Grid.FixedCols, iRow] := TresCell.Create(-1, -1, -1, -1, -1, -1, false, '', '', '', '', false, 1, '', '', '', '', '', '', '', '', '',
            0.00, 0.00, false, false, 0, '', false, false, 0, 0, 0,'', '', 0, 0);
        end;
      end;
    end
    else if Days > 0 then
    begin
      // Remove Onjects that will be going out of screen
      // for iCol := grid.FixedCols to grid.FixedCols + Days - 1 do
      // for iRow := 0 to grid.RowCount - 1 do
      // begin
      // if grid.Objects[iCol, iRow] <> nil then
      // begin
      // TresCell(grid.Objects[iCol, iRow]).free;
      // grid.Objects[iCol, iRow] := nil;
      // end;
      // end;
      // grid.InsertCols(grid.FixedCols, Days);
      for iDay := 1 to ABS(Days) do
      begin
        for iCol := Grid.FixedCols to Grid.ColCount - 2 do
          for iRow := 0 to Grid.RowCount - 1 do
          begin
            Grid.cells[iCol, iRow] := Grid.cells[iCol + 1, iRow];
            Grid.Objects[iCol, iRow] := Grid.Objects[iCol + 1, iRow];
            Grid.cells[iCol + 1, iRow] := '';
            Grid.Objects[iCol + 1, iRow] := nil;
          end;
        for iRow := 0 to Grid.RowCount - 1 do
        begin
          Grid.cells[Grid.ColCount - 1, iRow] := '';
          Grid.Objects[Grid.ColCount - 1, iRow] := TresCell.Create(-1, -1, -1, -1, -1, -1, false, '', '', '', '', false, 1, '', '', '', '', '', '', '', '', '',
            0.00, 0.00, false, false, 0, '', false, false, 0, 0, 0, '', '', 0, 0);
        end;
      end;
    end;

  end;

var
  fromDate, toDate: TdateTime;
  Channel: integer;
  PaymentInvoice: integer;
  GroupAccount: boolean;
  Information, Fax, Tel2, Tel1, GuestName1, PMInfo: String;
  Price, Discount: Double;
  Percentage: boolean;
  ItemsOnInvoice: boolean;
  PriceType: String;
  Currency: String;
  numGuests: integer;
  RoomClass: string;
  hidden: boolean;
  BookingId: String;

  OngoingTaxes, OngoingSale, OngoingRent: Double;

  round : Integer;
  StatusCancelled : Boolean;

  numUnassigned : Integer;

  InvoiceIndex : Integer;

begin

  ShowAllPeriodRows;

  CleanEnds(Days, grPeriodRooms);
  // CleanEnds(Days, grPeriodRooms_NO);

  if Days = 0 then
  begin
    fromDate := zDateFrom;
    toDate := zDateTo + 2;
  end
  else
  begin
    Period_SetDateHeads;
    if Days > 0 then
    begin
      fromDate := zDateTo - Days;
      toDate := fromDate + Days + 1;
    end
    else
    begin
      fromDate := zDateFrom;
      toDate := fromDate + ABS(Days);
    end;
  end;

  numUnassigned := 0;

  rdOBJ := TRoomDates.Create('', '');
  try
    rdOBJ.getFromDB(fromDate, toDate);

    rdOBJ.qMT_.SortFields := 'Room;rdDate';
    rdOBJ.qMT_.Sort([]);

    currentCol := -1;
    currentRow := -1;

    for round := 0 to 1 do
    begin

      rdOBJ.qMT_.first;
      i := 0;
      while NOT rdOBJ.qMT_.eof do
      begin
        resFlag := rdOBJ.qMT_.FieldByName('resFlag').asString;
        StatusCancelled := UpperCase(copy(resFlag, 1, 1)) = 'C';
        if (round = ABS(ORD(StatusCancelled))) then
        begin
          RoomReservation := rdOBJ.qMT_.FieldByName('RoomReservation').asinteger;
          Reservation := rdOBJ.qMT_.FieldByName('Reservation').asinteger;
          Channel := rdOBJ.qMT_.FieldByName('Channel').asinteger;
          PaymentInvoice := rdOBJ.qMT_.FieldByName('PaymentInvoice').asinteger;
          GroupAccount := rdOBJ.qMT_.FieldByName('GroupAccount').AsBoolean;
          AscIndex := rdOBJ.qMT_.FieldByName('AscIndex').asinteger;
          DescIndex := rdOBJ.qMT_.FieldByName('DescIndex').asinteger;

          Information := rdOBJ.qMT_.FieldByName('Information').asString;
          Fax := rdOBJ.qMT_.FieldByName('Fax').asString;
          Tel2 := rdOBJ.qMT_.FieldByName('Tel2').asString;
          Tel1 := rdOBJ.qMT_.FieldByName('Tel1').asString;
          GuestName1 := rdOBJ.qMT_.FieldByName('Guestname1').asString;
          PMInfo := rdOBJ.qMT_.FieldByName('PMInfo').asString;
          Price := rdOBJ.qMT_.FieldByName('Price').AsFloat;
          Discount := rdOBJ.qMT_.FieldByName('Discount').AsFloat;
          ItemsOnInvoice := rdOBJ.qMT_.FieldByName('ItemsOnInvoice').AsBoolean;
          Percentage := rdOBJ.qMT_.FieldByName('Percent').AsBoolean;
          PriceType := rdOBJ.qMT_.FieldByName('PriceType').asString;
          Currency := rdOBJ.qMT_.FieldByName('Currency').asString;
          numGuests := rdOBJ.qMT_.FieldByName('NumGuests').asinteger;
          RoomClass := rdOBJ.qMT_.FieldByName('RoomClass').asString;

          Room := rdOBJ.qMT_.FieldByName('Room').asString;
          RoomType := rdOBJ.qMT_.FieldByName('RoomType').asString;

          BookingId := rdOBJ.qMT_.FieldByName('BookingId').asString;

          isNoRoom := rdOBJ.qMT_['isNoRoom'] OR (Copy(Room, 1, 1) = '<'); // ];
          customer := rdOBJ.qMT_.FieldByName('Customer').asString;
          CustomerName := rdOBJ.qMT_.FieldByName('Customername').asString;
          GuestName := rdOBJ.qMT_.FieldByName('Guestname').asString;
          OutOfOrderBlocking := rdOBJ.qMT_.FieldByName('OutOfOrderBlocking').AsBoolean;
          BlockMove := rdOBJ.qMT_.FieldByName('BlockMove').AsBoolean;
          OngoingSale := rdOBJ.qMT_.FieldByName('TotalNoRent').AsFloat;
          OngoingTaxes := rdOBJ.qMT_.FieldByName('TotalTaxes').AsFloat;
          OngoingRent := rdOBJ.qMT_.FieldByName('TotalRent').AsFloat;
          InvoiceIndex := rdOBJ.qMT_.FieldByName('InvoiceIndex').AsInteger;
          dt := rdOBJ.qMT_.FieldByName('rdDate').AsDateTime;

          inc(i);

          if (isNoRoom = false) then
          begin
            cords := Period_RoomAndDateToCell(Room, dt);
            if cords.row > 0 then
            begin
              s := GetNameCombination(g.qNameOrder, CustomerName, GuestName);

              try
                grPeriodRooms.cells[cords.col, cords.row] := s;
              except
    {$IFDEF DEBUG}
                on E: Exception do
                  MessageDlg('Room: ' + Room + #13#13 + E.message, mtError, [mbOk], 0);
    {$ENDIF}
              end;

              try
                if grPeriodRooms.Objects[cords.col, cords.row] <> nil then
                begin
                  TresCell(grPeriodRooms.Objects[cords.col, cords.row]).Free;
                end;
              except
                showmessage( { 1080 } GetTranslatedText('sh1080') + #10 + Room + #10 + inttostr(cords.col) + '/1 ' + inttostr(cords.row));
              end;

              try
                grPeriodRooms.Objects[cords.col, cords.row] := TresCell.Create(RoomReservation, Reservation, Channel, PaymentInvoice, AscIndex, DescIndex,
                  GroupAccount, Room, RoomType, resFlag, CustomerName, isNoRoom, dt, Information, Fax, Tel2, Tel1, GuestName1, PMInfo, PriceType, Currency,
                  BookingId, Price, Discount, Percentage, ItemsOnInvoice, numGuests, RoomClass, OutOfOrderBlocking, BlockMove, OngoingSale, OngoingRent,
                  OngoingTaxes, rdOBJ.qMT_['Invoices'], rdOBJ.qMT_['Guarantee'], rdOBJ.qMT_['TotalPayment'], rdOBJ.qMT_['InvoiceIndex']);
              except
    {$IFDEF DEBUG}
                on E: Exception do
                  MessageDlg(E.message, mtError, [mbOk], 0);
    {$ENDIF}
              end;
            end;

          end else
          begin // is No Room
            cords.col := Period_DateToCol(dt);
            if (cords.col < grPeriodRooms_NO.ColCount) then
            begin
              found := false;

              for i := 0 to grPeriodRooms_NO.RowCount - 1 do
              begin
                if grPeriodRooms_NO.cells[1, i] = Room then
                begin
                  found := true;
                  cords.row := i;
                  break;
                end;
              end;

              if not found then
              begin
                cords.row := grPeriodRooms_NO.RowCount - 1;
                grPeriodRooms_NO.AddRow;
                grPeriodRooms_NO.RowHeights[grPeriodRooms_NO.RowCount - 1] := getRowHeightFromIndex(cbxViewTypes.ItemIndex);
                grNoRooms_FillEmptyResRow(grPeriodRooms_NO.RowCount - 1);

                numUnassigned := numUnassigned + ABS(ORD((NOT StatusCancelled)));
                // Initilize the new row
              end;

              s := GetNameCombination(g.qNameOrderPeriod, CustomerName, GuestName);

              grPeriodRooms_NO.cells[cords.col, cords.row] := s;
              grPeriodRooms_NO.cells[1, cords.row] := Room;
              grPeriodRooms_NO.cells[2, cords.row] := RoomType;

              try
                if grPeriodRooms_NO.Objects[cords.col, cords.row] <> nil then
                begin
                  TresCell(grPeriodRooms_NO.Objects[cords.col, cords.row]).Free;
                  grPeriodRooms_NO.Objects[cords.col, cords.row] := nil;
                end;
                if assigned((grPeriodRooms_NO.Objects[cords.col, cords.row] as TresCell)) then
                begin
                  (grPeriodRooms_NO.Objects[cords.col, cords.row] as TresCell).Free;
                end;
              except
                showmessage( { 1081 } GetTranslatedText('sh1081') + ' ' + #10 + Room + #10 + inttostr(cords.col) + '/2 ' + inttostr(cords.row));
              end;

              try
                grPeriodRooms_NO.Objects[cords.col, cords.row] := TresCell.Create(RoomReservation, Reservation, Channel, PaymentInvoice, AscIndex, DescIndex,
                  GroupAccount, Room, RoomType, resFlag, CustomerName, isNoRoom, dt, Information, Fax, Tel2, Tel1, GuestName1, PMInfo, PriceType, Currency, BookingId,
                  Price, Discount, Percentage, ItemsOnInvoice, numGuests, RoomClass, OutOfOrderBlocking, BlockMove, OngoingSale, OngoingRent, OngoingTaxes,
                  rdOBJ.qMT_['Invoices'], rdOBJ.qMT_['Guarantee'], rdOBJ.qMT_['TotalPayment'], rdOBJ.qMT_['TotalPayment']);
              except
      {$IFDEF DEBUG}
                on E: Exception do
                  MessageDlg(E.message, mtError, [mbOk], 0);
      {$ENDIF}
              end;
            end;
          end;
        end;
        rdOBJ.qMT_.next;
      end;
    end;
  finally
    rdOBJ.Free;
  end;

  btnUnassignedReservations.Caption := format(GetTranslatedText('shTx_FrmMain_UnassignedItemsButton'), [numUnassigned]);
  ApplyFiltersToPeriodView(grPeriodRooms);
  ApplyFiltersToPeriodView(grPeriodRooms_NO);
end;

procedure TfrmMain.ApplyFiltersToPeriodView(Grid: TAdvStringGrid);
var
  col, row: integer;
  Floors, Locations: TSet_Of_Integer;
  hideRow: boolean;
begin
  if SearchOrGroupFilterActive then
  begin
    if SearchActive then
    begin
      for row := Grid.RowCount - 1 downto Grid.FixedRows do
      begin
        hideRow := true;
        for col := Grid.ColCount - 1 downto Grid.FixedCols do
          if Grid.Objects[col, row] IS TresCell then
          begin
            if FilterPassededForPeriodData(TresCell(Grid.Objects[col, row])) then
              hideRow := false;
          end;

        if hideRow then
          Grid.RowHeights[row] := 0;
      end;
    end;
  end;
  if LocationOrFloorFilterActive AND (Grid = grPeriodRooms) then
  begin
    Floors := FilteredFloors;
    Locations := FilteredLocations;
    try
      for row := Grid.RowCount - 1 downto Grid.FixedRows do
      begin
        if (NOT glb.IsValidInList(Floors, glb.GetRoomFloor(Grid.cells[1, row]))) OR
          (NOT glb.IsValidInList(Locations, glb.GetLocationId(glb.GetRoomLocation(Grid.cells[1, row])))) then
          Grid.RowHeights[row] := 0;
      end;
    finally
      Locations.Free;
      Floors.Free;
    end;
  end;

end;

function TfrmMain.FilterPassededForPeriodData(Room: TresCell): boolean;
// Reservation : TSingleReservations) : Boolean;
var
  i, I1: integer;
  s: String;
  resultGroup, resultSearch: boolean;
begin
  result := NOT(SearchOrGroupFilterActive);
  // (edtSearch.Text = '') AND (btnFilter.ImageIndex = 0);
  if NOT result then
  begin

    resultGroup := NOT GroupsFilterActive;
    if NOT resultGroup then
    begin
      resultGroup := GroupFiltered(Room.Reservation);
    end;

    resultSearch := edtSearch.Text = '';

    if NOT resultSearch then
    begin
      s := Room.Room + ',' + Room.RoomType + ',' + Room.RoomClass + ',' + Room.PriceType + ',' + Room.Currency + ',' + Room.PMInfo + ',' + Room.GuestName + ','
        + Room.CustomerName + ',' + Room.Information + ',';
      resultSearch := pos(ANSIlowercase(edtSearch.Text), ANSIlowercase(s)) > 0;
    end;

    // if (lblAndOr.Tag = 1) OR FreeRoomsFiltered then
    // result := resultFilter OR resultSearch
    // else
    // result := resultFilter AND resultSearch;
    result := resultSearch AND resultGroup;

  end;

end;

procedure TfrmMain.Period_RestoreColumnSize;
// var
// i : integer;
begin
  // for i := 0 to grPeriodRooms.fixedCols - 1 do
  // begin
  // grPeriodRooms.AutoSizeCol(i);
  // end;
  //
  // for i := 0 to grPeriodRooms.ColCount - 1 do
  // begin
  // grPeriodRooms_NO.colWidths[i] := grPeriodRooms.colWidths[i];
  // end;
end;

procedure TfrmMain.Period_RestoreRowHeights;
var
  i: integer;
begin
  for i := grPeriodRooms.FixedRows to grPeriodRooms.RowCount - 1 do
  begin
    grPeriodRooms.RowHeights[i] := getRowHeightFromIndex(cbxViewTypes.ItemIndex);
  end;

  for i := grPeriodRooms_NO.FixedRows to grPeriodRooms_NO.RowCount - 1 do
  begin
    grPeriodRooms_NO.RowHeights[i] := getRowHeightFromIndex(cbxViewTypes.ItemIndex);
  end;

  grPeriodRooms.RowHeights[0] := 25;
  if cbxViewTypes.ItemIndex = 0 then
    grPeriodRooms.RowHeights[1] := getRowHeightFromIndex(cbxViewTypes.ItemIndex)
  else
    grPeriodRooms.RowHeights[1] := 25;
  grPeriodRooms.RowHeights[2] := 0;
end;

function TfrmMain.Period_GetStatus(ACol, ARow: integer): string;
begin
  result := '';
  if (grPeriodRooms.Objects[ACol, ARow] <> nil) AND (grPeriodRooms.Objects[ACol, ARow] IS TRoomCell) then
  begin
    try
      result := (grPeriodRooms.Objects[ACol, ARow] as TRoomCell).Roomstatus;
    except
    end;
  end;
end;

function TfrmMain.Period_GetResStatus(_grid: TAdvStringGrid; ACol, ARow: integer; var status: string; var AscIndex, DescIndex: integer): boolean;
begin
  result := false;
  if _grid.Objects[ACol, ARow] <> nil then
  begin
    status := (_grid.Objects[ACol, ARow] as TresCell).resFlag;
    status := ANSIUpperCase(status);
    DescIndex := (_grid.Objects[ACol, ARow] as TresCell).DescIndex;
    AscIndex := (_grid.Objects[ACol, ARow] as TresCell).AscIndex;
    result := true;
  end;
end;

function TfrmMain.Period_GotoRoom(Room: string): boolean;
var
  i: integer;
begin
  result := false;
  i := Period_RoomToRow(Room);
  result := i > 0;
  if result then
    grPeriodRooms.GotoCell(grPeriodRooms.FixedCols, i);
end;

function TfrmMain.Period_GotoRoomAndDate(Room: string; aDate: Tdate): boolean;
var
  RoomRow: integer;
  dateCol: integer;
  found: boolean;
begin
  RoomRow := Period_RoomToRow(Room);
  dateCol := Period_DateToCol(aDate);
  found := (RoomRow > 0) and (dateCol > 0);
  if found then
    grPeriodRooms.GotoCell(dateCol + 1, RoomRow);
  result := found;
end;

function TfrmMain.Period_RoomToRow(Room: string): integer;
var
  i: integer;
  found: boolean;
begin
  result := -1;
  found := false;
  for i := grPeriodRooms.FixedRows - 1 to grPeriodRooms.RowCount - 1 do
  begin
    if _trimlower(Room) = _trimlower(grPeriodRooms.cells[1, i]) then
    begin
      found := true;
      break;
    end;
  end;

  if found then
    result := i
end;

function TfrmMain.Period_DateToCol(aDate: Tdate): integer;
begin
  result := -1;
  result := (trunc(aDate) - trunc(zDateFrom)) + grPeriodRooms.FixedRows + 2;
end;

function TfrmMain.Period_ColToDate(ACol: integer): TdateTime;
begin
  result := zDateFrom + (ACol - (grPeriodRooms.FixedRows + 2));
end;

function TfrmMain.Period_NO_ColToDate(ACol: integer): TdateTime;
begin
  result := zDateFrom + (ACol - (grPeriodRooms_NO.FixedRows + 2));
end;

function TfrmMain.Period_RoomAndDateToCell(Room: string; aDate: Tdate): recColRow;
var
  found: boolean;
begin
  result.col := Period_DateToCol(aDate);
  result.row := Period_RoomToRow(Room);
end;

function TfrmMain.Period_GetNewResDates(var dtFrom: TdateTime): boolean;
begin
  result := false;
  dtFrom := Period_ColToDate(grPeriodRooms.col);
  result := dtFrom > now - 100;
end;

function TfrmMain.OneDay_GetResInfo(ACol: integer; ARow: integer; iReservation, iRoomReservation: integer): RecRRInfo;
begin
  result.Reservation := ReservationsModel.Reservations[iReservation].Reservation;
  result.RoomReservation := ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].RoomRes;
  result.Channel := ReservationsModel.Reservations[iReservation].Channel;
  result.resFlag := RESERVATION_STATUS_CHARS[ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].ResStatus];
  result.Date := ReservationsModel.Reservations[iReservation].ReservationDate;
  result.Room := ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].RoomNumber;
  result.RoomType := ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].RoomType;
  result.isNoRoom := Copy(ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].RoomNumber, 1, 1) = '<';
  // result.AscIndex := resCell.AscIndex;
  // result.DescIndex := resCell.DescIndex;
  result.CustomerName := ReservationsModel.Reservations[iReservation].name;
  result.Arrival := ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].Arrival;
  result.Departure := ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].Departure;
  result.active := ReservationsModel.Reservations[iReservation].Reservation > 0;
  result.PaymentInvoice := ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].PaymentInvoice;
  result.GroupAccount := ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].GroupAccount;

  result.ItemsOnInvoice := ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].TotalNoRent > 0;
  result.GuestName := ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].Guests[0].GuestName;
  result.Tel1 := ReservationsModel.Reservations[iReservation].Tel1;
  result.Tel2 := ReservationsModel.Reservations[iReservation].Tel2;
  result.Fax := ReservationsModel.Reservations[iReservation].Fax;

  result.BookingId := ReservationsModel.Reservations[iReservation].BookingReference;

  result.Price := ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].Price;
  result.Discount := ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].Discount;
  result.Percentage := ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].Percentage;
  result.Information := ReservationsModel.Reservations[iReservation].Information;
  result.PMInfo := ReservationsModel.Reservations[iReservation].PMInfo;
  result.PriceType := ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].PriceType;
  result.Currency := ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].Currency;
  result.numGuests := ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].GuestCount;
  result.RoomClass := ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].RoomClass;
  result.OutOfOrderBlocking := ReservationsModel.Reservations[iReservation].OutOfOrderBlocking;
  result.BlockMove := ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].BlockMove;

  result.OngoingSale := ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].OngoingSale;
  result.OngoingTaxes := ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].OngoingTaxes;
  result.OngoingRent := ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].OngoingRent;

  result.Invoices := ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].Invoices;
  result.Guarantee := ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].Guarantee;
  result.Payments := ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].TotalPayments;

  result.InvoiceIndex := ReservationsModel.Reservations[iReservation].Rooms[iRoomReservation].InvoiceIndex;
end;

function TfrmMain.Period_GetResInfo(ACol: integer; ARow: integer; gridTag: integer): RecRRInfo;
var
  resCell: TresCell;
  Grid: TAdvStringGrid;
begin
  result.Reservation := -1;
  if gridTag = 1 then
    Grid := grPeriodRooms
  else if gridTag = 2 then
    Grid := grPeriodRooms_NO
  else
    Exit;

  if (ACol <0) OR (ARow <0) then exit;


  if NOT(Grid.Objects[ACol, ARow] IS TresCell) then
    exit;

  resCell := TresCell(Grid.Objects[ACol, ARow]);
  // if gridTag = 1 then
  // resCell := TresCell(Grid.Objects[ACol, ARow])
  // else if gridTag = 2 then
  // resCell := TresCell(grPeriodRooms_NO.Objects[ACol, ARow]);

  result.Reservation := resCell.Reservation;
  result.RoomReservation := resCell.RoomReservation;
  result.Channel := resCell.Channel;
  result.resFlag := resCell.resFlag;
  result.Date := resCell.Date;
  result.Room := resCell.Room;
  result.RoomType := resCell.RoomType;
  result.isNoRoom := resCell.isNoRoom;
  result.AscIndex := resCell.AscIndex;
  result.DescIndex := resCell.DescIndex;
  result.CustomerName := resCell.CustomerName;
  result.Arrival := result.Date - result.AscIndex;
  result.Departure := (result.DescIndex + result.Date) + 1;
  result.active := resCell.Reservation > 0;
  result.PaymentInvoice := resCell.PaymentInvoice;
  result.GroupAccount := resCell.GroupAccount;

  result.ItemsOnInvoice := resCell.ItemsOnInvoice;
  result.GuestName := resCell.GuestName;
  result.Tel1 := resCell.Tel1;
  result.Tel2 := resCell.Tel2;
  result.Fax := resCell.Fax;

  result.BookingId := resCell.BookingId;

  result.Price := resCell.Price;
  result.Discount := resCell.Discount;
  result.Percentage := resCell.Percentage;
  result.Information := resCell.Information;
  result.PMInfo := resCell.PMInfo;
  result.PriceType := resCell.PriceType;
  result.Currency := resCell.Currency;
  result.numGuests := resCell.numGuests;
  result.RoomClass := resCell.RoomClass;
  result.OutOfOrderBlocking := resCell.OutOfOrderBlocking;
  result.BlockMove := resCell.BlockMove;

  result.OngoingSale := resCell.OngoingSale;
  result.OngoingTaxes := resCell.OngoingTaxes;
  result.OngoingRent := resCell.OngoingRent;

  result.Invoices := resCell.Invoices;
  result.Guarantee := resCell.Guarantee;
  result.Payments := resCell.TotalPayments;

  result.InvoiceIndex := resCell.InvoiceIndex;
end;

procedure TfrmMain.Period_MergeGrid;
var
  asc, desc: integer;
  c, r: integer;
  ColsLeft: integer;
  mergeCount: integer;
begin

  for c := grPeriodRooms.FixedCols to grPeriodRooms.ColCount - 1 do
  begin
    for r := grPeriodRooms.FixedRows to grPeriodRooms.RowCount - 2 do
    begin
      asc := (grPeriodRooms.Objects[c, r] as TresCell).AscIndex;
      desc := (grPeriodRooms.Objects[c, r] as TresCell).DescIndex;

      mergeCount := desc + 1;
      ColsLeft := (grPeriodRooms.ColCount) - c;
      if mergeCount > ColsLeft then
        mergeCount := ColsLeft;

      if asc = 0 then
      begin
        grPeriodRooms.MergeCells(c, r, mergeCount, 1);
      end;

      if c = grPeriodRooms.FixedCols then
      begin
        if desc <> 0 then
        begin
          grPeriodRooms.MergeCells(c, r, mergeCount, 1);
        end;
      end;
    end;
  end;
end;

procedure TfrmMain.Period_UnMergeGrid;
var
  c, r: integer;
begin

  for c := grPeriodRooms.FixedCols to grPeriodRooms.ColCount - 1 do
  begin
    for r := grPeriodRooms.FixedRows to grPeriodRooms.RowCount - 2 do
    begin
      grPeriodRooms.MergeCells(c, r, 1, 1);
    end;
  end;
end;

function TfrmMain.AnyHiddenRow(Sender: TAdvStringGrid): boolean;
var
  i: integer;
begin
  result := false;
  for i := 0 to Sender.RowCount - 1 do
    if Sender.IsHiddenRow(i) then
    begin
      result := true;
      break;
    end;
end;

procedure TfrmMain.grPeriodRoomsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  RoomTypeForceWasOn: boolean;
  ColWas, RowWas: integer;
  options: TExecuteFileOptions;

begin

  if (Key = VK_F12) AND (ssCtrl IN Shift) AND (ssShift IN Shift) then
  begin
    options := [eoWait, eoMaximized];
    ExecuteFile(handle, 'CMD.EXE', '', options);
    exit;
  end;

  if (Key = VK_F1) AND (ssAlt IN Shift) then
  begin
    if NOT HintWindowShowing then
      ShowHintWindow;
    exit;
  end;

  if (Key = VK_CONTROL) then
  begin
    if grPeriodViewFilterOn then
    begin
      ColWas := ZPeriodRoomOnTheMoveCol;
      RowWas := ZPeriodRoomOnTheMoveRow;
      RoomTypeForceWasOn := ZPeriodRoomOnTheMoveForceType;
      ShowAllRoomsRows;

      ZPeriodRoomOnTheMoveForceType := NOT RoomTypeForceWasOn;
      if ZPeriodRoomOnTheMoveExternal then
      begin
        grPeriodRooms_NO.GotoCell(ColWas, RowWas);
        grPeriodRooms_NO.SetFocus;
        ReEnableFiltersInPeriodGrid;
        EnterPeriodDragFilterExternal
      end
      else
      begin
        grPeriodRooms.GotoCell(ColWas, RowWas);
        grPeriodRooms.SetFocus;
        ReEnableFiltersInPeriodGrid;
        EnterPeriodDragFilter;
      end;
    end;
  end
  else

    if Key = vk_Right then
  begin
    if grPeriodRooms.col = grPeriodRooms.ColCount - 1 then
    begin
      // dtDate.Date := trunc(dtDate.Date + 1);
      // StartOneDay;
      // grPeriodRooms.Refresh;

      Key := 0;
    end;
  end
  else

    if (Key = VK_SHIFT) then
  begin
    if grPeriodViewFilterOn then
      ShowAllRoomsRows
    else if (grPeriodRooms.cells[grPeriodRooms.col, grPeriodRooms.row] <> '') AND assigned(grPeriodRooms.Objects[grPeriodRooms.col, grPeriodRooms.row]) then
    begin
      ReEnableFiltersInPeriodGrid;
      EnterPeriodDragFilter;
    end;
  end
  else

    if Key = vk_Right then
  begin
    if grPeriodRooms.col = grPeriodRooms.ColCount - 1 then
    begin
      // dtDate.Date := trunc(dtDate.Date + 1);
      // StartOneDay;
      // grPeriodRooms.Refresh;

      Key := 0;
    end;
  end
  else

    if Key = vk_Left then
  begin
    if grPeriodRooms.col = grPeriodRooms.FixedCols then
    begin
      // dtDate.Date := trunc(dtDate.Date - 1);
      // StartOneDay;
      // grPeriodRooms.Refresh;
      Key := 0;
    end;
  end
  else

    if Key = VK_UP then
  begin
    if grPeriodRooms.row < 2 then
      grPeriodRooms.row := 2;
    grPeriodRooms.row := grPeriodRooms.row - 1;
    // grPeriodRooms.Refresh;
    grPeriodRooms.SelectCells(grPeriodRooms.col, grPeriodRooms.row, grPeriodRooms.col, grPeriodRooms.row);
    Key := 0;
  end
  else

    if Key = VK_DOWN then
  begin
    grPeriodRooms.row := grPeriodRooms.row + 1;
    // grPeriodRooms.OnClickCell(grPeriodRooms,grPeriodRooms.row,grPeriodRooms.col);
    // grPeriodRooms.OnMouseEnter(grPeriodRooms);
    if grPeriodRooms.row >= grPeriodRooms.RowCount - 1 then
      grPeriodRooms.row := grPeriodRooms.RowCount - 2;
    grPeriodRooms.SelectCells(grPeriodRooms.col, grPeriodRooms.row, grPeriodRooms.col, grPeriodRooms.row);
    // grPeriodRooms.Refresh;
    Key := 0;
  end
  else
    FormKeyDown(Sender, Key, Shift);

end;

procedure TfrmMain.grPeriodRoomsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  i: integer;
  ii: integer;
  iNum: integer;
begin
  g.qDebug1 := 'grPeriodRoomsKeyUp(Sender : TObject; var Key : Word; Shift : TShiftState)';

  if HintWindowShowing then
  begin
    HintWindowShowing := false;
    ApplicationCancelHint;
    exit;
  end;

  if Key = vk_Home then
  begin
    grPeriodRooms.row := 3;
    Key := 0;
    grPeriodRooms_NO.col := grPeriodRooms.col;
  end

  else if Key = vk_end then
  begin
    Key := 0;
    grPeriodRooms_NO.col := grPeriodRooms.col;
  end

  else if Key = vk_Right then
  begin
    if IsControlKeyPressed OR (grPeriodRooms.col = grPeriodRooms.ColCount - 1) then
    begin
      btnBackForwardClick(btnForward);
      Key := 0;
    end
    else
    begin
      grPeriodRooms_NO.col := grPeriodRooms.col;
    end;
  end
  else if Key = vk_Left then
  begin
    if IsControlKeyPressed OR (grPeriodRooms.col = grPeriodRooms.FixedCols) then
    begin
      btnBackForwardClick(btnBack);
      Key := 0;
    end
    else
    begin
      grPeriodRooms_NO.col := grPeriodRooms.col;
    end;
  end

  else if Key = VK_UP then
  begin
    Key := 0;
  end;
  if Key = VK_DOWN then
  begin
    Key := 0;
  end

  else if Key = vk_insert then
  begin
  end;

end;

procedure TfrmMain.grPeriodRoomsResize(Sender: TObject);
begin
  grAutoSizeGrids;
  AutoSizePeriodColumns;
end;

procedure TfrmMain.grPeriodRoomsStartDrag(Sender: TObject; var DragObject: TDragObject);
var
  rri: RecRRInfo;
  iReservation, iRoomReservation: integer;
  _grid: TAdvStringGrid;
begin
  _grid := grPeriodRooms;
  rri := Period_GetResInfo(_grid.col, _grid.row, _grid.Tag);
  if rri.Reservation > -1 then
    if rri.BlockMove AND (Copy(rri.Room, 1, 1) <> '<') then
    begin
      MessageDlg(GetTranslatedText('shTx_FrmMain_UserCannotMoveTheRoomReservation'), mtError, [mbOk], 0);
    end;
end;

/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////
//
// +--------------------------------------+
// |            Period NoRoomsGrid        |
// +--------------------------------------+
//
//
/// /////////////////////////////////////////////////////////////////////////////

// ------------------------------------------------------------------------------
// Init grid
//
// -080227 - gert
// ------------------------------------------------------------------------------
function TfrmMain.grNoRooms_Init: integer;
begin
  result := 0;
  grPeriodRooms_NO.DefaultColWidth := grPeriodRooms.DefaultColWidth;
  grPeriodRooms_NO.FixedRightCols := grPeriodRooms.FixedRightCols;
  grPeriodRooms_NO.RowCount := 1;
  grPeriodRooms_NO.FixedRows := 0;

  grPeriodRooms_NO.ColCount := grPeriodRooms.ColCount;
  grPeriodRooms_NO.FixedCols := grPeriodRooms.FixedCols;
  grPeriodRooms_NO.FixedRightCols := grPeriodRooms.FixedRightCols;
  grPeriodRooms_NO.colWidths[0] := grPeriodRooms.colWidths[0];
  grPeriodRooms_NO.colWidths[1] := grPeriodRooms.colWidths[1];
  grPeriodRooms_NO.colWidths[2] := grPeriodRooms.colWidths[2];
  grPeriodRooms_NO.colWidths[3] := grPeriodRooms.colWidths[3];

  grPeriodRooms_NO.RowHeights[0] := grPeriodRooms.RowHeights[3];
end;

function TfrmMain.grNoRooms_ClearAll: integer;
var
  c: integer;
  r: integer;
begin
  result := 0;
  for c := 0 to grPeriodRooms_NO.ColCount - 1 do
  begin
    for r := 0 to grPeriodRooms_NO.RowCount - 1 do
    begin
      grPeriodRooms_NO.cells[c, r] := '';
      if grPeriodRooms_NO.Objects[c, r] <> nil then
      begin
        if grPeriodRooms_NO.Objects[c, r] IS TresCell then
          try
            TresCell(grPeriodRooms_NO.Objects[c, r]).Free;
          except
          end;
        grPeriodRooms_NO.Objects[c, r] := nil;
      end;
    end;
  end;

  // 101011 must be after freeing the object
  // else there will be am memory leak
  grPeriodRooms_NO.ClearNormalCells;

  grPeriodRooms_NO.RowCount := 1;
end;

procedure TfrmMain.grNoRooms_FillEmptyResCells;
var
  c: integer;
  r: integer;
begin
  for c := grPeriodRooms_NO.FixedCols to grPeriodRooms_NO.ColCount - 1 do
  begin
    for r := grPeriodRooms_NO.FixedRows to grPeriodRooms_NO.RowCount - 1 do
    begin
      if grPeriodRooms_NO.Objects[c, r] <> nil then
      begin
        TresCell(grPeriodRooms_NO.Objects[c, r]).Free;
        grPeriodRooms_NO.Objects[c, r] := nil;
      end;
      grPeriodRooms_NO.Objects[c, r] := TresCell.Create(-1, -1, -1, -1, -1, -1, false, '', '', '', '', false, 1, '', '', '', '', '', '', '', '', '', 0.00, 0.00,
        false, false, 0, '', false, false, 0, 0, 0, '', '', 0, 0);
    end;
  end;
end;

procedure TfrmMain.grNoRooms_FillEmptyResRow(r: integer) ;
var
  c: integer;
begin
  for c := grPeriodRooms_NO.FixedCols to grPeriodRooms_NO.ColCount - 1 do
  begin
    if grPeriodRooms_NO.Objects[c, r] <> nil then
    begin
      TresCell(grPeriodRooms_NO.Objects[c, r]).Free;
      grPeriodRooms_NO.Objects[c, r] := nil;
    end;
    grPeriodRooms_NO.Objects[c, r] := TresCell.Create(-1, -1, -1, -1, -1, -1, false, '', '', '', '', false, 1, '', '', '', '', '', '', '', '', '', 0.00, 0.00,
      false, false, 0, '', false, false, 0, 0, 0, '', '', 0, 0);
  end;
end;

procedure TfrmMain.grAutoSizeGrids;
var
  i, iWidth, col1Width, col2Width, col3Width, col4Width, col5Width: integer;
begin
  if grPeriodRooms.ColCount <= 5 then
    exit;

  col1Width := grPeriodRooms.colWidths[0];
  col2Width := grPeriodRooms.colWidths[1];
  col3Width := grPeriodRooms.colWidths[2];
  col4Width := grPeriodRooms.colWidths[3];
  col5Width := grPeriodRooms.colWidths[4];
  iWidth := (panPeriodRooms.ClientWidth - 30 - (col1Width + col2Width + col3Width + col4Width + col5Width)) div (grPeriodRooms.ColCount - 5);
  for i := 5 to grPeriodRooms.ColCount - 1 do
  begin
    grPeriodRooms.colWidths[i] := iWidth;
    if i < grPeriodRooms_NO.ColCount then
      grPeriodRooms_NO.colWidths[i] := iWidth;
  end;
end;

procedure TfrmMain.HideRowsWithNotFittingRooms(currRow: integer; fromDate, toDate: Tdate);
var
  i, iStartRow: integer;
  sql: String;
  rSet: TRoomerDataSet;
  list: TStringList;
  Key, Extra, CurrentRoom: String;
begin
  if NOT ZPeriodRoomOnTheMoveExternal then
    CurrentRoom := ZPeriodRoomOnTheMoveRoomNumber
    // grPeriodRooms.Cells[1,currRow]
  else
    CurrentRoom := '';
  list := TStringList.Create;
  try
    if ZPeriodRoomOnTheMoveForceType then
      Extra := Format('AND RoomType=''%s''', [ZPeriodRoomOnTheMoveRoomType])
    else
      Extra := '';
    sql := Format('SELECT Room FROM rooms ' + 'WHERE (NOT room IN (SELECT room FROM roomsdate WHERE ADate>=''%s'' AND ADate<''%s'')) %s ' + 'ORDER BY Room;',
      [uDateUtils.dateToSqlString(fromDate), uDateUtils.dateToSqlString(toDate), Extra]);
    rSet := d.roomerMainDataSet.ActivateNewDataset(d.roomerMainDataSet.SystemFreeQuery(sql));
    try
      rSet.first;
      while not rSet.eof do
      begin
        list.Add(rSet['Room']);
        rSet.next;
      end;
    finally
      freeandNil(rSet);
    end;

    for i := grPeriodRooms.RowCount - 1 downto grPeriodRooms.FixedRows do
    begin
      Key := grPeriodRooms.cells[1, i];
      if (currRow <> i) AND (list.IndexOf(Key) = -1) then
      begin
        grPeriodRooms.hideRow(i);
        if i < currRow then
          dec(currRow);
      end;
    end;

    if NOT ZPeriodRoomOnTheMoveExternal then
      for i := grPeriodRooms_NO.RowCount - 2 downto grPeriodRooms_NO.FixedRows do
      begin
        grPeriodRooms_NO.hideRow(i);
      end;
  finally
    list.Free;
  end;
  if CurrentRoom <> '' then
    FindRoomInPeriodView(CurrentRoom);
end;

function TfrmMain.IsRoomAvailableInMoveFunctionAvailRooms(Room: String): boolean;
var
  i: integer;
  RoomType: String;
begin
  result := false;
  RoomType := OneDayGridRoomTypeOfCell(iDragCell);
  for i := 0 to MoveFunctionAvailRooms.Count - 1 do
    if MoveFunctionAvailRooms[i].Room = Room then
    begin
      if (NOT IsControlKeyPressed) OR (RoomType = MoveFunctionAvailRooms[i].RoomType) then
      begin
        result := true;
        break;
      end;
    end;
end;

procedure TfrmMain.ListRoomsAvailable(fromDate, toDate: Tdate);
var
  i, iStartRow: integer;
  sql: String;
  rSet: TRoomerDataSet;
  list: TStringList;
  CurrentRoom: String;
begin
  MoveFunctionAvailRooms.Clear;

  sql := Format('SELECT r.Room, rt.RoomType, rtg.Code ' + 'FROM rooms r ' + '     INNER JOIN roomtypes rt ON rt.RoomType=r.RoomType ' +
    '     INNER JOIN roomtypegroups rtg ON rtg.Code=rt.RoomTypeGroup ' +
    'WHERE NOT r.Room IN (SELECT room FROM roomsdate WHERE ADate>=''%s'' AND ADate<''%s'') ' + 'ORDER BY r.Room',
    [uDateUtils.dateToSqlString(fromDate), uDateUtils.dateToSqlString(toDate)]);
  rSet := d.roomerMainDataSet.ActivateNewDataset(d.roomerMainDataSet.SystemFreeQuery(sql));
  try
    rSet.first;
    while not rSet.eof do
    begin
      MoveFunctionAvailRooms.Add(TRoomAvailabilityEntity.Create(rSet['Room'], rSet['RoomType'], rSet['Code']));
      rSet.next;
    end;
  finally
    freeandNil(rSet);
  end;

end;

procedure TfrmMain.ShowAllRoomsRows;
begin
  grPeriodRooms.UnHideRowsAll;
  grPeriodRooms_NO.UnHideRowsAll;
  // splitPeriod.OpenSplitter; splitPeriod.Top := panPeriodRooms.Height;
  SetFilterColorsOff;
end;

procedure TfrmMain.SetFilterColorsOn;
begin
  grPeriodViewFilterOn := true;
  grPeriodRooms.GridLineColor := clSilver; // BorderColor;
  grPeriodRooms.GridFixedLineColor := clGray; // BorderColor;
  grPeriodRooms.GridLineWidth := 3;
  lblRoomBeingMoved.Caption := Format(GetTranslatedText('shTx_FrmMain_GuestAndRoomNumberBeingMoved'),
    [ZPeriodRoomOnTheMoveGuestname, ZPeriodRoomOnTheMoveRoomNumber]);
  lblRoomBeingMoved.Visible := true;
end;

procedure TfrmMain.SetOffLineMode(const Value: boolean);
var
  i: integer;
begin
  // Deactivate!
  FOffLineMode := Value;
  exit;


  d.roomerMainDataSet.OffLineMode := OffLineMode;
  btnToDay.Click;

  if FOffLineMode then
  begin
    panMain.Color := clRed;
    i := 10;
  end
  else
  begin
    panMain.Color := clBtnFace;
    i := 0;
  end;
  panMain.SkinData.CustomColor := FOffLineMode;
  pnlOffline.Visible := FOffLineMode;
  panMain.Padding.Top := i;
  panMain.Padding.Left := i;
  panMain.Padding.Bottom := i;
  panMain.Padding.Right := i;

  for i := 0 to ComponentCount - 1 do
    if (Components[i] IS TdxBarLargeButton) then
      if (Components[i] <> btnGroupInvoice) AND (Components[i] <> btnRoomInvoice) AND (Components[i] <> btnClose) AND (Components[i] <> btnRefresh) then
        (Components[i] AS TdxBarLargeButton).Enabled := NOT OffLineMode;

  dtDate.Enabled := NOT OffLineMode;

  btnBack.Enabled := NOT OffLineMode;
  btnForward.Enabled := NOT OffLineMode;
  btnForward.Enabled := NOT OffLineMode;
  tabsView.TabIndex := 0;

  for i := 0 to mmnuOneDayGrid.Items.Count - 1 do
    mmnuOneDayGrid.Items[i].Enabled := NOT OffLineMode;

  pmnuRoomInvoive.Enabled := NOT OffLineMode;
  pmnuGroupInvoice.Enabled := NOT OffLineMode;
  pmnuCheckInRoom.Enabled := NOT OffLineMode;
  pmnuCheckOutRoom.Enabled := NOT OffLineMode;
  pmnuCheckInGroup.Enabled := NOT OffLineMode;
  mnuRoomNumber.Enabled := NOT OffLineMode;
end;

procedure TfrmMain.SetRBEMode(const Value: boolean);
begin
  if FRBEMode = Value then
    exit;

  FRBEMode := Value;
  if FRBEMode then
  begin
    StoreMain.StoreTo(false);
    BorderStyle := bsDialog;
    FrmRBEContainer := TFrmRBEContainer.Create(nil);
    ClientWidth := FrmRBEContainer.pnlRBEContainer.Width;
    ClientHeight := FrmRBEContainer.pnlRBEContainer.Height;
    Caption := 'Roomer Booking Engine - ';
    pnlRBE.Left := 0;
    pnlRBE.Top := 0;
    pnlRBE.Width := ClientWidth;
    pnlRBE.Height := ClientHeight;
    pnlRBE.Show;
    // pnlRBE.Visible := True;
    // pnlRBE.Align := alClient;
    pnlRBE.BringToFront;
    FrmRBEContainer.pnlRBEContainer.Parent := pnlRBE;
    pnlRBE.Refresh;
  end
  else
  begin
    pnlRBE.Hide;
    if assigned(FrmRBEContainer) AND assigned(FrmRBEContainer.pnlRBEContainer) AND (FrmRBEContainer.pnlRBEContainer.Parent = pnlRBE) then
    begin
      freeandNil(FrmRBEContainer);
    end;
    BorderStyle := bsSizeable;
    StoreMain.RestoreFrom;
  end;
end;

procedure TfrmMain.SetFilterColorsOff;
begin
  grPeriodViewFilterOn := false;
  grPeriodRooms.GridLineColor := clSilver; // BorderColor;
  grPeriodRooms.GridFixedLineColor := clGray; // BorderColor;
  grPeriodRooms.GridLineWidth := 1;
  lblRoomBeingMoved.Caption := '';
  lblRoomBeingMoved.Visible := false;
  ZPeriodRoomOnTheMoveForceType := false;
end;

procedure TfrmMain.FindRoomInPeriodView(Room: String);
var
  i: integer;
  MyR: TGridRect;
begin
  for i := grPeriodRooms.FixedRows to grPeriodRooms.RowCount - 1 do
    if grPeriodRooms.cells[1, i] = Room then
    begin
      grPeriodRooms.ScrollInView(grPeriodRooms.col, i);
      grPeriodRooms.GotoCell(grPeriodRooms.col, i);
      grPeriodRooms.SelectCells(grPeriodRooms.col, i, grPeriodRooms.col, i);
      grPeriodRooms.SetFocus;
      break;
    end;
end;

procedure TfrmMain.grdRoomClassesCanEditCell(Sender: TObject; ARow, ACol: integer; var CanEdit: boolean);
begin
  CanEdit := (ACol = 3) AND (ARow > 0) AND (grdRoomClasses.cells[ACol, ARow] <> inttostr(DEFAULT_UNPARSABLE_INT_VALUE));
end;

procedure TfrmMain.grdRoomClassesCellValidate(Sender: TObject; ACol, ARow: integer; var Value: string; var Valid: boolean);
var
  s: String;
  iValue: integer;
  StatusCont: TRoomClassChannelAvailabilityContainer;
  temp: String;
begin
  //
  StatusCont := availListContainer[ARow - 1];
  iValue := strtointDef(Value, DEFAULT_UNPARSABLE_INT_VALUE);
  if iValue = DEFAULT_UNPARSABLE_INT_VALUE then
  begin
    if ANSIUpperCase(Copy(Value, 1, 1)) = 'M' then
    begin
      iValue := strtointDef(Copy(Value, 2, maxint), DEFAULT_UNPARSABLE_INT_VALUE);
      if iValue < -1 then
        raise Exception.Create(GetTranslatedText('shTx_FrmMain_WrongValueEntered'));
      temp := Format('(grdRoomClassesCellValidate 1) Manual change of MAX availability for RoomClass=%s, SetMaxAvailability=%d, Date=%s',
        [grdRoomClasses.cells[0, ARow], iValue, dateToSqlString(lastDate)]);
      d.roomerMainDataSet.SystemSetChannelAvailability(uDateUtils.dateToSqlString(lastDate), grdRoomClasses.cells[0, ARow], 1, -2, iValue, -1, -1, temp);
      lastDate := 0;
      StatusCont.ChannelMaxAvailable := iValue;
      timGetRoomStatuses.Enabled := true;
      ShowTimelyMessage(Format(GetTranslatedText('shTx_FrmMain_ChannelChangedMaxAvail'), [grdRoomClasses.cells[0, ARow], iValue]));
      exit;
    end
    else
    begin
      Valid := false;
      raise Exception.Create(GetTranslatedText('shTx_FrmMain_WrongValueEntered'));
    end;
  end;
  if iValue < -1 then
    raise Exception.Create(GetTranslatedText('shTx_FrmMain_WrongValueEntered'));

  temp := Format('(grdRoomClassesCellValidate 2) Manual change of availability for RoomClass=%s, SetAvailability=%d, Date=%s',
    [grdRoomClasses.cells[0, ARow], iValue, dateToSqlString(lastDate)]);
  d.roomerMainDataSet.SystemSetChannelAvailability(uDateUtils.dateToSqlString(lastDate), grdRoomClasses.cells[0, ARow], 1, iValue, -1, -1, -1, temp);
  AddAvailabilityActivityLog(d.roomerMainDataSet.username,
                             EDIT,
                             grdRoomClasses.cells[0, ARow],
                             iValue,
                             lastDate,
                             'Edited in Roomer''s main screen');

  ShowTimelyMessage(Format(GetTranslatedText('shTx_FrmMain_ChannelChangedAvail'), [grdRoomClasses.cells[0, ARow], iValue]));
  StatusCont.ChannelAvailable := iValue;
  grdRoomClasses.Invalidate;
end;

procedure TfrmMain.PlaceMouseClickToCell(Sender: TObject; X, Y: integer);
var
  ACol: integer;
  ARow: integer;
begin
  TAdvStringGrid(Sender).MouseToCell(X, Y, ACol, ARow);
  TAdvStringGrid(Sender).col := ACol;
  TAdvStringGrid(Sender).row := ARow;
end;

procedure TfrmMain.grdRoomClassesDrawCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
var
  Text: String;
  dx: integer;
  iValue: integer;
  StatusCont: TRoomClassChannelAvailabilityContainer;
begin
  if bAppClosing then exit;
  Text := grdRoomClasses.cells[ACol, ARow];
  if (ACol = 3) AND (ARow > 0) then
  begin
    try
      if ARow - 1 < availListContainer.Count then
      begin
        StatusCont := availListContainer[ARow - 1];
        with grdRoomClasses.Canvas do
        begin
          Brush.Color := sSkinManager1.GetGlobalColor; // clWhite; // $00EAEAEA;
          Font.Style := [fsBold];
          iValue := strtointDef(Text, DEFAULT_UNPARSABLE_INT_VALUE);
          if iValue > 0 then
            Font.Color := clBlue
          else if iValue = 0 then
            Font.Color := $000080FF // Orange
          else if iValue = DEFAULT_UNPARSABLE_INT_VALUE then
          begin
            Font.Color := clBlack;
            Brush.Color := $00EAEAEA;
            Text := 'n/a';
          end
          else
            Font.Color := sSkinManager1.GetGlobalFontColor; // clBlue;
          if (iValue > 0) AND (StrToInt(grdRoomClasses.cells[2, ARow]) - iValue < 0) then
          begin
            Font.Color := clWhite;
            Brush.Color := $000080FF;
            Font.Style := [fsBold, fsItalic];
          end;
          Font.size := 7;
          FillRect(Rect);
          if iValue = -1 then
            Text := 'auto'
          else if iValue <> DEFAULT_UNPARSABLE_INT_VALUE then
            Text := Format('%d/%d', [StatusCont.ChannelAvailable, StatusCont.ChannelMaxAvailable]);
          dx := TextWidth(Text) + 2;
          TextOut(Rect.Right - dx, Rect.Top, Text);
        end;
      end;
    except
    end;
  end
  else if (ACol = 2) AND (ARow > 0) then
  begin
    with grdRoomClasses.Canvas do
    begin
      iValue := strtointDef(Text, DEFAULT_UNPARSABLE_INT_VALUE);
      Brush.Color := sSkinManager1.GetGlobalColor; // $00EAEAEA;
      if iValue > 0 then
        Font.Color := sSkinManager1.GetGlobalFontColor // clBlue
      else if iValue = 0 then
        Font.Color := sSkinManager1.GetGlobalFontColor // clBlack
      else
      begin
        Font.Color := clRed;
        Brush.Color := clWhite
      end;
      Font.Style := [fsBold];
      Font.size := 7;
      FillRect(Rect);
      dx := TextWidth(Text) + 2;
      TextOut(Rect.Right - dx, Rect.Top, Text);
    end;
  end;
  if (ACol = 1) AND (ARow > 0) then
  begin
    with grdRoomClasses.Canvas do
    begin
      Brush.Color := sSkinManager1.GetGlobalColor; // $00EAEAEA;
      Font.Color := sSkinManager1.GetGlobalFontColor; // clBlack;
      Font.Style := [];
      Font.size := 7;
      FillRect(Rect);
      dx := TextWidth(Text) + 2;
      TextOut(Rect.Right - dx, Rect.Top, Text);
    end;
  end;
end;

procedure TfrmMain.grdRoomClassesGetCellBorder(Sender: TObject; ARow, ACol: integer; APen: TPen; var Borders: TCellBorders);
var
  iValue: integer;
  StatusCont: TRoomClassChannelAvailabilityContainer;
begin
  if bAppClosing then exit;

  if (ARow > 0) AND (ACol = 3) then
  begin
    if (ARow < grdRoomClasses.RowCount) AND (ACol < grdRoomClasses.ColCount) then
      try
        iValue := strtointDef(grdRoomClasses.cells[3, ARow], DEFAULT_UNPARSABLE_INT_VALUE);
        if iValue <> DEFAULT_UNPARSABLE_INT_VALUE then
          if ARow - 1 < availListContainer.Count then
          begin
            StatusCont := availListContainer[ARow - 1];
            // TRoomClassChannelAvailabilityContainer(grdRoomClasses.Objects[3, aRow]);
            if StatusCont.AnyStop then
            begin
              APen.Color := clRed;
              APen.Width := 4;
              Borders := [cbTop, cbLeft, cbRight, cbBottom];
            end;
          end;
      except
      end;
  end;
end;

procedure TfrmMain.grdRoomClassesMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  PpUp: TPoint;
  ACol: integer;
  ARow: integer;
begin
  if bAppClosing then exit;
  PlaceMouseClickToCell(Sender, X, Y);
  if Button = mbRight then
  begin
    PpUp.X := X;
    PpUp.Y := Y;
    PpUp := grdRoomClasses.ClientToScreen(PpUp);
    PopulateChannelStopMenu;
    pmnuChannelSettings.Popup(PpUp.X, PpUp.Y);
  end;
end;

var
  iLastHintRowClasses: integer = 0;
  iLastHintColClasses: integer = 0;

procedure TfrmMain.grdRoomClassesMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
var
  Text: String;
  dx: integer;
  ARow, ACol, iValue: integer;
  APoint: TPoint;
  StatusCont: TRoomClassChannelAvailabilityContainer;
  availColor, maxColor, HintStr: String;
begin
  if bAppClosing then exit;
  grdRoomClasses.MouseToCell(X, Y, ACol, ARow);
  Application.ProcessMessages;
  if (iLastHintRow = ARow) and (iLastHintCol = ACol) then
    exit;

  if (ACol = 3) AND (ARow > 0) then
  begin
    StatusCont := availListContainer[ARow - 1];
    // TRoomClassChannelAvailabilityContainer(grdRoomClasses.Objects[3, aRow]);
    // ATitle := GetTranslatedText('shTx_FrmMain_Explanation');
    Text := TAdvStringGrid(Sender).cells[ACol, ARow];
    // AIcon := ORD(biInfo);
    maxColor := '#0000ff';
    if StatusCont.ChannelMaxAvailable < 1 then
      maxColor := '#ff0000';

    HintStr := GetTranslatedText('shTx_FrmMain_ChannelAvailabilityClassesHintHeader');
    iValue := strtointDef(Text, DEFAULT_UNPARSABLE_INT_VALUE);
    availColor := '#0000ff';
    if iValue < 1 then
      availColor := '#ff0000';

    if ((iValue > 0) AND (StrToInt(grdRoomClasses.cells[2, ARow]) - iValue < 0)) then
      HintStr := HintStr + GetTranslatedText('shTx_FrmMain_WarningIncorrectAvailability')
    else if iValue >= 0 then
      HintStr := HintStr + Format(GetTranslatedText('shTx_FrmMain_RoomsAvailableFromChannels'), [availColor, iValue]) +
        Format(GetTranslatedText('shTx_FrmMain_ChannelMaxAvailability'), [maxColor, StatusCont.ChannelMaxAvailable])
      // else
      // if iValue = 0 then
      // HintStr := HintStr + GetTranslatedText('shTx_FrmMain_NoRoomsAvailableFromChannels') +
      // format(GetTranslatedText('shTx_FrmMain_ChannelMaxAvailability'), [maxColor, statusCont.ChannelMaxAvailable])
    else if iValue = DEFAULT_UNPARSABLE_INT_VALUE then
      HintStr := GetTranslatedText('shTx_FrmMain_RoomClassNotAvailableOnChannels')
    else
      HintStr := GetTranslatedText('shTx_FrmMain_AutoAvailabilityOnChannels');

    if StatusCont.AnyStop then
      HintStr := HintStr + '<hr>' + GetTranslatedText('shTx_FrmMain_StopSaleActiveOnOneOrMoreChannels');

    HintStr := '<font size="10">' + HintStr + '</font>';

    grdRoomClasses.Hint := HintStr;
    APoint.X := X;
    APoint.Y := Y;
    APoint := grdRoomClasses.ClientToScreen(APoint);
    ActivateHint(APoint, grdRoomClasses);

    iLastHintRow := ARow;
    iLastHintCol := ACol;

  end;
end;

procedure TfrmMain.grdRoomStatussesDrawCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
// var
// Text: String;
// dx: integer;
// iValue: integer;
// StatusCont: TRoomClassChannelAvailabilityContainer;
begin
  // Text := grdRoomClasses.cells[ACol, ARow];
  // if (ACol = 2) AND (ARow > 0) then
  // begin
  // with grdRoomStatusses.Canvas do
  // begin
  // iValue := strtointDef(Text, DEFAULT_UNPARSABLE_INT_VALUE);
  // if iValue = DEFAULT_UNPARSABLE_INT_VALUE then
  // exit;
  // Brush.Color := clWhite;
  // if iValue > 0 then
  // Font.Color := clBlue
  // else if iValue = 0 then
  // Font.Color := clBlack
  // else
  // begin
  // Font.Color := clWhite;
  // Brush.Color := clRed;
  // end;
  // Font.Style := [fsBold];
  // Font.size := 7;
  // FillRect(Rect);
  // dx := TextWidth(Text) + 2;
  // TextOut(Rect.Right - dx, Rect.Top, Text);
  // end;
  // end;
end;

procedure TfrmMain.grdRoomStatussesGetAlignment(Sender: TObject; ARow, ACol: integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if bAppClosing then exit;
  if (ACol IN [1, 2, 3]) then
    HAlign := taRightJustify
  else if (ACol = 0) AND (ARow > 0) then
    HAlign := taRightJustify
  else if (ACol = 0) AND (ARow = 0) then
    HAlign := taCenter;
end;

procedure TfrmMain.grNoRooms_MergeGrid;
var
  asc, desc: integer;
  c, r: integer;
  ColsLeft: integer;
  mergeCount: integer;

  RoomColSize_NR: integer;
  RoomColSize_5D: integer;

begin
  for c := grPeriodRooms_NO.FixedCols to grPeriodRooms_NO.ColCount - 1 do
  begin

    for r := grPeriodRooms_NO.FixedRows to grPeriodRooms_NO.RowCount - 2 do
    begin
      // grNoRooms.Cells[c,r] := 'XX';
      try
        asc := (grPeriodRooms_NO.Objects[c, r] as TresCell).AscIndex;
        desc := (grPeriodRooms_NO.Objects[c, r] as TresCell).DescIndex;
      except
        raise;
      end;

      mergeCount := desc + 1;
      ColsLeft := (grPeriodRooms_NO.ColCount) - c;

      if mergeCount > ColsLeft then
        mergeCount := ColsLeft;

      if asc = 0 then
      begin
        grPeriodRooms_NO.MergeCells(c, r, mergeCount, 1);
      end;

      if c = grPeriodRooms_NO.FixedCols then
      begin
        if desc <> 0 then
        begin
          grPeriodRooms_NO.MergeCells(c, r, mergeCount, 1);
        end;
      end;
    end;
  end;

  grPeriodRooms_NO.AutoSizeCol(1);

  RoomColSize_NR := grPeriodRooms_NO.colWidths[1];
  RoomColSize_5D := grPeriodRooms.colWidths[1];

  if RoomColSize_5D < RoomColSize_NR then
    grPeriodRooms.colWidths[1] := RoomColSize_NR;
  if RoomColSize_NR < RoomColSize_5D then
    grPeriodRooms_NO.colWidths[1] := RoomColSize_5D;
end;

procedure TfrmMain.grNoRooms_UnMergeGrid;
var
  c, r: integer;
begin
  for c := grPeriodRooms_NO.FixedCols to grPeriodRooms_NO.ColCount - 1 do
  begin

    for r := grPeriodRooms_NO.FixedRows to grPeriodRooms_NO.RowCount - 2 do
    begin
      grPeriodRooms_NO.MergeCells(c, r, 1, 1);
    end;
  end;
end;

function TfrmMain.grNoRooms_GetResStatus(ACol, ARow: integer; var status: string; var AscIndex, DescIndex: integer): boolean;
begin
  result := false;
  if grPeriodRooms_NO.Objects[ACol, ARow] <> nil then
  begin
    status := (grPeriodRooms_NO.Objects[ACol, ARow] as TresCell).resFlag;
    status := ANSIUpperCase(status);
    DescIndex := (grPeriodRooms_NO.Objects[ACol, ARow] as TresCell).DescIndex;
    AscIndex := (grPeriodRooms_NO.Objects[ACol, ARow] as TresCell).AscIndex;
    result := true;
  end;
end;

procedure TfrmMain.grPeriodRoomsMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  cellContent: string;

  iRoomReservation: integer;
  AscIndex: integer;

  ACol, ARow: integer;

  allow: boolean;

  keystate: TShiftState;

  resCell: TresCell;

begin
  zPeriod_bMouseDown := true;
  PeriodMousePoint := Point(X, Y);
  if Button = mbRight then
    exit;
  grPeriodRooms.MouseToCell(X, Y, ACol, ARow);
  cellContent := grPeriodRooms.cells[ACol, ARow];

  iRoomReservation := 0;
  AscIndex := -1;

  if (ACol >= grPeriodRooms.FixedCols) and (ARow >= grPeriodRooms.FixedRows) and (ARow <> grPeriodRooms.RowCount - 1) then
  begin
    resCell := (grPeriodRooms.Objects[ACol, ARow] as TresCell);
    grPeriodRooms_NO.col := grPeriodRooms.col;

    // if  (ssShift in shift) or (ssCtrl in shift)  then
    // begin
    try
      iRoomReservation := resCell.RoomReservation;
      AscIndex := (grPeriodRooms.Objects[ACol, ARow] as TresCell).AscIndex;
    except
    end;

    allow := (* (trunc(Period_ColToDate(ACol)) = resCell.Date - resCell.AscIndex) AND *) (iRoomReservation > 0) and (AscIndex = 0);

    // result.Departure := (result.DescIndex + result.Date) + 1;

    if allow then
    begin
      zzRoomReservation := (grPeriodRooms.Objects[ACol, ARow] as TresCell).RoomReservation;
      zzReservation := (grPeriodRooms.Objects[ACol, ARow] as TresCell).Reservation;
      zzRoomType := (grPeriodRooms.Objects[ACol, ARow] as TresCell).RoomType;
      zzRoom := (grPeriodRooms.Objects[ACol, ARow] as TresCell).Room;
      zzIsNoRoom := (grPeriodRooms.Objects[ACol, ARow] as TresCell).isNoRoom;
      zzAscIndex := (grPeriodRooms.Objects[ACol, ARow] as TresCell).AscIndex;
      zzDescIndex := (grPeriodRooms.Objects[ACol, ARow] as TresCell).DescIndex;
      zzArrival := (grPeriodRooms.Objects[ACol, ARow] as TresCell).Date + zzAscIndex;
      zzDeparture := (grPeriodRooms.Objects[ACol, ARow] as TresCell).Date + zzDescIndex + 1;

      zzSource := Sender;
      zzSourceCol := ACol;
      zzSourceRow := ARow;
      zzSourceGridID := 1;
      // grPeriodRooms.BeginDrag(false, 4);

      // if grPeriodViewFilterOn then
      // begin
      // ZPeriodRoomOnTheMoveRoomReservation := zzRoomReservation;
      // ZPeriodRoomOnTheMoveCol := ACol;
      // ZPeriodRoomNumberOnTheMoveRoomReservation := zzRoom;
      // ZPeriodRoomGuestOnTheMoveRoomReservation := (grPeriodRooms.Objects[ACol, ARow] as TresCell).GuestName;
      // ZPeriodRoomOnTheMoveExternal := False;
      // grPeriodRooms.UnHideRowsAll;
      // HideRowsWithNotFittingRooms({grPeriodRooms.Row}-1, zzArrival, zzDeparture);
      // SetFilterColorsOn;
      // end;

    end;
    // end;
  end;
end;

procedure TfrmMain.ApplicationCancelHint;
begin
  Application.CancelHint;
  FrmReservationHintHolder.CancelHint;
end;

procedure TfrmMain.ActivateMessagesIfApplicable;
begin
  // if the timer has been enabled means the idle duration is already counting.
  // Do not continue to avoid resetting the start idle time
  if FMessagesBeingDownloaded OR timMessages.Enabled then
    exit;

  // store the time when the user become idle
  // FStartIdle := GetTickCount;

  // enable the timer
  timMessages.Enabled := true;
end;

procedure TfrmMain.ApplicationEvents1Activate(Sender: TObject);
begin
  if NOT timMessages.Enabled then
    exit;
  timMessages.Enabled := false;
end;

procedure TfrmMain.ApplicationEvents1Deactivate(Sender: TObject);
begin
  ActivateMessagesIfApplicable;
end;

procedure TfrmMain.ApplicationEvents1Idle(Sender: TObject; var Done: boolean);
begin
  ActivateMessagesIfApplicable;
end;

procedure TfrmMain.ApplicationEvents1Message(var Msg: tagMSG; var Handled: boolean);
begin
  Handled := false;
  if NOT timMessages.Enabled then
    exit;

  case Msg.message of
    WM_KEYDOWN:
      timMessages.Enabled := false;
    WM_MBUTTONDOWN, WM_MBUTTONUP, WM_MBUTTONDBLCLK:
      timMessages.Enabled := false;
    WM_MOUSEWHEEL:
      timMessages.Enabled := false;
    WM_LBUTTONDOWN:
      timMessages.Enabled := false;
    WM_RBUTTONDOWN:
      timMessages.Enabled := false;
    // WM_MBUTTONDOWN : Timer1.Enabled := False;
  end;
end;

procedure TfrmMain.ApplicationEvents1Minimize(Sender: TObject);
begin
  ActivateMessagesIfApplicable;
end;

procedure TfrmMain.ApplicationEvents1Restore(Sender: TObject);
begin
  if NOT timMessages.Enabled then
    exit;
  timMessages.Enabled := false;
end;

procedure TfrmMain.ApplicationCancelGuestHint;
begin
  FrmReservationHintHolder.CancelHint;
end;

procedure TfrmMain.grPeriodRoomsMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
var
  ACol, ARow: integer;
  rri: RecRRInfo;
  Grid: TAdvStringGrid;
begin
  Grid := TAdvStringGrid(Sender);
  if Grid.dragging then
    exit;

  Grid.MouseToCell(X, Y, ACol, ARow);
  rri := Period_GetResInfo(ACol, ARow, Grid.Tag);
  if (ACol >= Grid.FixedCols) AND (rri.RoomReservation <> iLastShownRoomReservation) then
  // ((iLastShownHintRow <> ARow) OR (iLastShownHintCol <> ACol)) then
  begin
    iLastShownHintRow := ARow;
    iLastShownHintCol := ACol;
    iLastShownRoomReservation := -1;
    ApplicationCancelGuestHint;
  end;

  HoverPointPeriod := Point(X, Y);

  // if g.qShowhint AND (NOT zPeriod_bMouseDown) then
  // Period_CheckHint(Sender, X, Y)
  // else
  // ApplicationCancelGuestHint;

  if zPeriod_bMouseDown then
  begin
    if (ABS(PeriodMousePoint.X - X) > 6) or (ABS(PeriodMousePoint.Y - Y) > 6) then
    begin
      zPeriod_bMouseDown := false;

      // ActiveGrid.MouseToCell(PeriodMousePoint.X, PeriodMousePoint.Y, iDragCell.X,
      // iDragCell.Y);
      //
      // if ((iDragCell.X > 6) and (ActiveGrid.cells[11, iDragCell.Y] <> '')) or
      // ((iDragCell.X < 6) and (ActiveGrid.cells[4, iDragCell.Y] <> '')) then
      // begin
      // if ActiveGrid.Focused then
      // begin
      ApplicationCancelHint;
      Grid.BeginDrag(true);
      // Application.processmessages;
      // end;
      // end;
    end;
  end;

end;

procedure TfrmMain.grPeriodRoomsMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  zPeriod_bMouseDown := false;
end;

procedure TfrmMain.grPeriodRoomsDragOver(Sender, Source: TObject; X, Y: integer; State: TDragState; var Accept: boolean);
var
  ACol, ARow: integer;
  sHintText: string;
  APoint: TPoint;

begin
  grPeriodRooms.MouseToCell(X, Y, ACol, ARow);

  (*
    Application.processmessages;
    sHintText := inttostr(aCol)+','+inttostr(aRow);
    grPeriodRooms.Hint := sHintText;
    APoint := grPeriodRooms.ClientToScreen(APoint);
    Application.ActivateHint(APoint);
  *)
  Accept := false;

  if ACol <> zzSourceCol then
  begin
    exit;
  end;

  if ((ACol >= grPeriodRooms.FixedCols) and (ARow >= grPeriodRooms.FixedRows)) and ((ARow <> grPeriodRooms.RowCount - 1) OR grPeriodViewFilterOn) and
    (grPeriodRooms.cells[ACol, ARow] = '') and (Sender = Sender as TAdvStringGrid) then
  begin
    Accept := true;
  end;
end;

procedure TfrmMain.GetPriceInfo(rri: RecRRInfo; var CurrencySign: String; var PricePerDay, DiscountPerDay, PriceTotal, DiscountTotal: Double);
var
  discountAmount: Double;
begin
  CurrencySign := '€';
  if rri.Discount <> 0 then
  begin
    discountAmount := rri.Discount;
    if rri.Percentage then
    begin
      discountAmount := rri.Price / ((100 - rri.Discount) / 100); // ro.Price * ro.Discount / 100;
      PricePerDay := discountAmount;
      DiscountPerDay := rri.Discount;
    end
    else
    begin
      discountAmount := rri.Price + rri.Discount;
      PricePerDay := rri.Price + rri.Discount;
      DiscountPerDay := rri.Discount;
    end;

    PriceTotal := PricePerDay * (rri.Departure - rri.Arrival);
    DiscountTotal := DiscountPerDay * (rri.Departure - rri.Arrival);
  end
  else
  begin
    PricePerDay := rri.Price;
    DiscountPerDay := 0.00;
    PriceTotal := PricePerDay * (rri.Departure - rri.Arrival);
    DiscountTotal := 0.00;
  end;
end;

function TfrmMain.GetCaptText(Canvas: TCanvas; OriginalText: String; MaxWidth: integer): String;
var
  AnyCharCapt: boolean;
  extraChars: String;
begin
  result := OriginalText;
  extraChars := '';
  AnyCharCapt := (result <> '') AND (Canvas.TextWidth(result) > MaxWidth);
  if AnyCharCapt then
    extraChars := '...';
  while (result <> '') AND (Canvas.TextWidth(result + extraChars) > MaxWidth) do
    result := Copy(result, 1, length(result) - 1);
  result := result + extraChars;
end;

procedure TfrmMain.DrawPeriodColumn1(Grid: TAdvStringGrid; ACol, ARow: integer; State: TGridDrawState);
var
  iMargin, iTemp, TempHeight, TempTop: integer;
  s, sRoom, tempString, sType, sStatus: String;
  BColor, FColor: TColor;
  fStyle: TFontStyles;
  Rect, chRect: TRect;
begin
  Rect := Grid.CellRect(ACol, ARow);
  With Grid.Canvas do
  begin
    iMargin := 5;
    if gdSelected IN State then
    begin
      Brush.Color := clHighLight; // sSkinManager1.GetGlobalFontColor;
      Font.Color := clWhite; // sSkinManager1.GetGlobalColor;
    end
    else
    begin
      Brush.Color := sSkinManager1.GetGlobalColor;
      Font.Color := sSkinManager1.GetGlobalFontColor;
    end;

    if cbxViewTypes.ItemIndex > 0 then
    begin
      Font.name := 'Segoe UI';
      Font.Style := [fsBold];
    end;

    FillRect(Rect);
    if (Grid.cells[ACol, ARow] <> '') AND (ARow >= Grid.FixedRows) and (ARow < Grid.RowCount) then
    begin
      if (gdSelected IN State) then // OR (gdSelected IN State) then
      begin
        Brush.Color := clHighLight; // sSkinManager1.GetGlobalFontColor;
        Font.Color := clWhite; // sSkinManager1.GetGlobalColor;
      end
      else
      begin
        Brush.Color := sSkinManager1.GetGlobalColor;
        Font.Color := sSkinManager1.GetGlobalFontColor;
      end;
      Font.Style := [fsBold];
      if cbxViewTypes.ItemIndex = 0 then
      begin
        iTemp := Grid.Canvas.TextHeight(Grid.cells[ACol, ARow]);
        ExtTextOut(handle, Rect.Left + 2, (Rect.Top + Rect.Bottom) div 2 - iTemp div 2, ETO_CLIPPED, @Rect, PChar(Grid.cells[ACol, ARow]),
          length(Grid.cells[ACol, ARow]), nil);
      end
      else if cbxViewTypes.ItemIndex = 1 then
      begin
        Font.name := 'Segoe UI';
        Font.Style := [fsBold];
        TempHeight := (Rect.Bottom - Rect.Top) div 2;
        sRoom := Grid.cells[ACol, ARow];
        tempString := sRoom + StringOfChar(' ', 255) + #0;
        iTemp := TextHeight(tempString);
        TempTop := Rect.Top + (TempHeight div 2) - (iTemp div 2);
        ExtTextOut(handle, Rect.Left + iMargin, TempTop, ETO_CLIPPED, @Rect, tempString, length(tempString), nil);

        Font.Style := [];
        if glb.LocateSpecificRecordAndGetValue('rooms', 'Room', sRoom, 'RoomType', s) then
          if glb.LocateSpecificRecordAndGetValue('roomtypes', 'RoomType', s, 'Description', s) then
          begin
            Font.Color := sSkinManager1.GetGlobalFontColor;
            tempString := GetCaptText(Grid.Canvas, s, Rect.Right - Rect.Left - 4) + StringOfChar(' ', 255) + #0;

            TempTop := TempHeight + Rect.Top + (TempHeight div 2) - (iTemp div 2);
            ExtTextOut(handle, Rect.Left + iMargin, TempTop, ETO_CLIPPED, @Rect, tempString, length(tempString), nil)
          end;
      end
      else
      begin
        Font.name := 'Segoe UI';
        Font.Style := [fsBold];
        TempHeight := (Rect.Bottom - Rect.Top) div 3;
        sRoom := Grid.cells[ACol, ARow];
        tempString := sRoom + StringOfChar(' ', 255) + #0;
        iTemp := TextHeight(tempString);
        TempTop := Rect.Top + (TempHeight div 2) - (iTemp div 2);
        ExtTextOut(handle, Rect.Left + iMargin, TempTop, ETO_CLIPPED, @Rect, tempString, length(tempString), nil);

        Font.Style := [];
        s := '';
        if glb.LocateSpecificRecordAndGetValue('rooms', 'Room', sRoom, 'RoomType', sType) then
        begin
          sStatus := glb.RoomsSet['Status'];
          Font.Color := sSkinManager1.GetGlobalFontColor;
          if glb.LocateSpecificRecordAndGetValue('roomtypes', 'RoomType', sType, 'Description', s) then
          begin
            tempString := GetCaptText(Grid.Canvas, s, Rect.Right - Rect.Left - 4) + StringOfChar(' ', 255) + #0;

            TempTop := TempHeight + Rect.Top + (TempHeight div 2) - (iTemp div 2);
            ExtTextOut(handle, Rect.Left + iMargin, TempTop, ETO_CLIPPED, @Rect, tempString, length(tempString), nil)
          end;

          if glb.LocateSpecificRecordAndGetValue('maintenancecodes', 'code', sStatus, 'name', s) then
          begin
            TempTop := (TempHeight * 2) + Rect.Top + (TempHeight div 2) - (iTemp div 2);
            tempString := GetCaptText(Grid.Canvas, s, Rect.Right - Rect.Left - 4) + StringOfChar(' ', 255) + #0;
            if StatusToColor(sRoom, BColor, FColor, fStyle) then
              Font.Color := BColor;
            ExtTextOut(handle, Rect.Left + iMargin, TempTop, ETO_CLIPPED, @Rect, tempString, length(tempString), nil);
          end;
        end;
      end;

      if cbxViewTypes.ItemIndex = 0 then
        if StatusToColor(Grid.cells[ACol, ARow]
          { Period_GetStatus(1, ARow) } , BColor, FColor, fStyle) then
        begin
          Brush.Color := BColor;
          Font.Color := FColor;

          chRect.Left := Rect.Right - 8;
          chRect.Top := Rect.Top;
          chRect.Bottom := Rect.Bottom;
          chRect.Right := Rect.Right;
          FillRect(chRect);
        end;
    end;
  end;
end;

procedure TfrmMain.grPeriodRoomsDrawCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
var
  iNights, iTempColor, iRes, dx, i: integer;
  chRect: TRect;
  rri: RecRRInfo;
  Grid: TAdvStringGrid;
  Text, s, sType, sStatus, sRoom: String;
  tempString: Utf8String;
  iTemp: integer;

  rec: recStatusAttr;
  fStyle: TFontStyles;

  BColor: TColor;
  FColor: TColor;

  status: string;
  AscIndex: integer;
  DescIndex: integer;

  penStyle: TPenStyle;

  Noon2Noon: TRect;

  TempHeight, TempTop, TempBottom: integer;

  CurrencySign: String;
  PricePerDay, DiscountPerDay, PriceTotal, DiscountTotal: Double;

  pt1, pt2: TPoint;

  iMargin, weekDay: integer;
const
  iExtraSpace = PERIOD_GRID_RECTANGLES_WIDTH;
begin
  Grid := TAdvStringGrid(Sender);
  if Grid.RowHeights[ARow] = 0 then
    exit;

  if ACol IN [3, 4] then
  begin
    exit;
  end;

  if ACol IN [2] then
  begin
    if cbxViewTypes.ItemIndex > 0 then
      exit;
  end;

  with Grid.Canvas do
  begin
    if (ARow < Grid.RowCount) AND (ACol < Grid.FixedCols) then
    begin
      case ACol of
        1:
          begin
            DrawPeriodColumn1(TAdvStringGrid(Sender), ACol, ARow, State);
          end;
        2:
          begin
            With Grid.Canvas do
            begin
              Brush.Color := sSkinManager1.GetGlobalColor;
              Font.Color := sSkinManager1.GetGlobalFontColor;
              Font.Style := [];
              FillRect(Rect);

              rec := d.getRoomTypeColors(Grid.cells[ACol, ARow]);
              Brush.Color := rec.BackgroundColor;
              Font.Color := rec.fontColor;

              chRect.Left := Rect.Right - 8;
              chRect.Top := Rect.Top;
              chRect.Bottom := Rect.Bottom;
              chRect.Right := Rect.Right;
              FillRect(chRect);

              iTemp := Grid.Canvas.TextHeight(Grid.cells[ACol, ARow]);

              Brush.Color := sSkinManager1.GetGlobalColor;
              Font.Color := sSkinManager1.GetGlobalFontColor;
              ExtTextOut(handle, Rect.Left + 2, (Rect.Top + Rect.Bottom) div 2 - iTemp div 2,
                // ETO_CLIPPED or ETO_OPAQUE, @Rect, PChar(Grid.cells[ACol, ARow]),
                ETO_CLIPPED, @Rect, PChar(Grid.cells[ACol, ARow]), length(Grid.cells[ACol, ARow]), nil);
              exit;
            end;
          end;
      end;
    end;

    if (ACol > Grid.FixedCols - 1) and (ARow >= Grid.FixedRows) and ((ARow <> Grid.RowCount - 1) OR grPeriodViewFilterOn) then
    begin
      DrawPeriodColumn1(TAdvStringGrid(Sender), 1, ARow, State);
      try
        if (NOT Grid.IsHiddenRow(ARow)) AND (Grid.cells[ACol, ARow] <> '') AND assigned(Grid.Objects[ACol, ARow]) then
        begin
          if NOT(grPeriodViewFilterOn AND (ACol <> ZPeriodRoomOnTheMoveCol)) then
          begin
            rri := Period_GetResInfo(ACol, ARow, Grid.Tag);
            if rri.Reservation = -1 then
              exit;

            Period_GetResStatus(Grid, ACol, ARow, status, AscIndex, DescIndex);

            if rri.OutOfOrderBlocking then
            begin
              Brush.Color := clSilver;
              Font.Color := clWhite;
              if cbxViewTypes.ItemIndex > 0 then
              begin
                Brush.Style := bsBDiagonal;
                Brush.Color := sSkinManager1.GetGlobalFontColor;
                Pen.Color := sSkinManager1.GetGlobalFontColor;
                Pen.Style := psSolid;
                Pen.Width := 5;

                chRect := Rect;

                SetBkColor(handle, sSkinManager1.GetGlobalColor);
                FillRect(chRect);
                exit;
              end;
            end
            else if ResStatusToColor(status, BColor, FColor) then
            begin
              Brush.Color := BColor;
              Pen.Color := BColor;
              Font.Color := FColor;
            end;

            iTemp := (Rect.Right - Rect.Left) div 2;
            Noon2Noon.Left := Rect.Left + iTemp;
            Noon2Noon.Right := Rect.Right + iTemp;
            Noon2Noon.Top := Rect.Top;
            Noon2Noon.Bottom := Rect.Bottom;
            if Grid.Tag = 1 then
              MyRoundedRect(Grid.Canvas, Rect.Left, Rect.Top, Rect.Right, Rect.Bottom, cbxViewTypes.ItemIndex = 0)
            else
              FillRect(Rect);

            tempString := Grid.cells[ACol, ARow] + StringOfChar(' ', 255) + #0;
            iTemp := TextHeight(tempString);

            if rri.OutOfOrderBlocking then
            begin
              tempString := GetTranslatedText('shTx_FrmMain_OutOfOrder') + StringOfChar(' ', 255) + #0;
              ExtTextOut(handle, Rect.Left + 2, (Rect.Bottom + Rect.Top) div 2 - iTemp div 2, ETO_CLIPPED, @Rect, tempString, length(tempString), nil);

              Pen.Color := clBlack;
              MoveTo(Rect.Left + 2 + TextWidth(GetTranslatedText('shTx_FrmMain_OutOfOrder')), (Rect.Top + Rect.Bottom) div 2);
              LineTo(Rect.Right, (Rect.Top + Rect.Bottom) div 2);

              exit;
            end
            else
            begin
              if cbxViewTypes.ItemIndex = 0 then
                ExtTextOut(handle, Rect.Left + 2, (Rect.Bottom + Rect.Top) div 2 - iTemp div 2, ETO_CLIPPED, @Rect, tempString, length(tempString), nil)
              else if cbxViewTypes.ItemIndex = 1 then
              begin
                Font.name := 'Segoe UI';
                Font.Style := [fsBold];
                TempHeight := (Rect.Bottom - Rect.Top) div 2;
                tempString := GetCaptText(Grid.Canvas, Grid.cells[ACol, ARow], Rect.Right - Rect.Left - 4) + StringOfChar(' ', 255) + #0;
                iTemp := TextHeight(tempString);
                TempTop := Rect.Top + (TempHeight div 2) - (iTemp div 2);
                ExtTextOut(handle, Rect.Left + 2, TempTop, ETO_CLIPPED, @Rect, tempString, length(tempString), nil);

                Font.Style := [];
                GetPriceInfo(rri, CurrencySign, PricePerDay, DiscountPerDay, PriceTotal, DiscountTotal);
                tempString := GetCaptText(Grid.Canvas, Format('%s %s (av. %s %s)', [CurrencySign, trim(_floatToStr(PriceTotal - DiscountTotal, 12, 2)),
                  CurrencySign, trim(_floatToStr(PricePerDay - DiscountPerDay, 12, 2))]), Rect.Right - Rect.Left - 4) + StringOfChar(' ', 255) + #0;
                TempTop := TempHeight + Rect.Top + (TempHeight div 2) - (iTemp div 2);
                ExtTextOut(handle, Rect.Left + 2, TempTop, ETO_CLIPPED, @Rect, tempString, length(tempString), nil)
              end
              else
              begin
                Font.name := 'Segoe UI';
                Font.Style := [fsBold];
                TempHeight := (Rect.Bottom - Rect.Top) div 3;
                tempString := GetCaptText(Grid.Canvas, Grid.cells[ACol, ARow], Rect.Right - Rect.Left - 4) + StringOfChar(' ', 255) + #0;
                iTemp := TextHeight(tempString);
                TempTop := Rect.Top + (TempHeight div 2) - (iTemp div 2);
                ExtTextOut(handle, Rect.Left + 2, TempTop, ETO_CLIPPED, @Rect, tempString, length(tempString), nil);

                Font.Style := [];
                GetPriceInfo(rri, CurrencySign, PricePerDay, DiscountPerDay, PriceTotal, DiscountTotal);
                tempString := GetCaptText(Grid.Canvas, Format('%s %s (av. %s %s)', [CurrencySign, trim(_floatToStr(PriceTotal - DiscountTotal, 12, 2)),
                  CurrencySign, trim(_floatToStr(PricePerDay - DiscountPerDay, 12, 2))]), Rect.Right - Rect.Left - 4) + StringOfChar(' ', 255) + #0;
                TempTop := TempHeight + Rect.Top + (TempHeight div 2) - (iTemp div 2);
                ExtTextOut(handle, Rect.Left + 2, TempTop, ETO_CLIPPED, @Rect, tempString, length(tempString), nil);

                Font.Style := [];
                GetPriceInfo(rri, CurrencySign, PricePerDay, DiscountPerDay, PriceTotal, DiscountTotal);
                TempTop := (TempHeight * 2) + Rect.Top + (TempHeight div 2) - (iTemp div 2);

                s := inttostr(trunc(rri.Departure) - trunc(rri.Arrival));
                tempString := s + StringOfChar(' ', 255) + #0;
                LoadImageFromImageList(DImages.ilGuests, 6, Grid.Canvas, Point(Rect.Left + 2, TempTop + 2), Brush.Color, [Point(clRed, Font.Color)]);
                ExtTextOut(handle, Rect.Left + 2 + 18, TempTop, ETO_CLIPPED, @Rect, tempString, length(tempString), nil);

                i := TextWidth(s) + 10;
                s := inttostr(rri.numGuests);
                tempString := s + StringOfChar(' ', 255) + #0;
                LoadImageFromImageList(DImages.ilGuests, 5, Grid.Canvas, Point(Rect.Left + i + 20, TempTop + 2), Brush.Color, [Point(clRed, Font.Color)]);
                ExtTextOut(handle, Rect.Left + 2 + (18 * 2) + i, TempTop, ETO_CLIPPED, @Rect, tempString, length(tempString), nil);
              end;
            end;

            if cbxViewTypes.ItemIndex > 0 then
              exit;

            chRect.Left := Rect.Right - 4 - iExtraSpace;
            chRect.Top := Rect.Top + 3;
            chRect.Bottom := Rect.Bottom - 3;
            chRect.Right := chRect.Left + iExtraSpace;
            iTempColor := getChannelColorByChannel(rri.Channel);
            if iTempColor = -1 then
              iTempColor := 15793151;
            DrawRectanglOnCanvas(Grid.Canvas, iTempColor, chRect);

            chRect.Left := Rect.Right - 4 - iExtraSpace - iExtraSpace - 1 - iExtraSpace - 1;
            chRect.Top := Rect.Top + 3;
            chRect.Bottom := Rect.Bottom - 3;
            chRect.Right := chRect.Left + iExtraSpace;
            iTempColor := getUnpaidItemsColor(rri.ItemsOnInvoice, TAdvStringGrid(Sender).Canvas.Brush.Color);
            DrawRectanglOnCanvas(Grid.Canvas, iTempColor, chRect);

            chRect.Left := Rect.Right - 4 - iExtraSpace - iExtraSpace - 1;
            chRect.Top := Rect.Top + 3;
            chRect.Bottom := Rect.Bottom - 3;
            chRect.Right := chRect.Left + iExtraSpace;
            iTempColor := getInvoiceMadeColor(rri.PaymentInvoice, round(rri.OngoingRent) <> 0, Brush.Color, clWhite, clAqua, rri.GroupAccount);
            DrawRectanglOnCanvas(TAdvStringGrid(Sender).Canvas, iTempColor, chRect);
          end;

        end
        else
        begin
          Brush.Color := sSkinManager1.GetGlobalColor;
          Font.Color := Brush.Color;
          if (gdSelected IN State) OR (gdRowSelected IN State) OR (gdPressed IN State) then
            Brush.Color := sSkinManager1.GetHighLightColor(true)
          else
          begin
            weekDay := dayOfWeek(Period_ColToDate(ACol));
            if weekDay IN [1, 7] then
            begin
              if cbxViewTypes.ItemIndex = 0 then
                Brush.Color := HexToTColor('FFC2C2')
              else
                Brush.Color := HexToTColor('F7F7F7');
            end;
          end;
          FillRect(Rect);
        end;
      except
      end;
    end
    else if (ARow < Grid.FixedRows) then
    begin
      Text := Grid.cells[ACol, ARow];
      // Brush.Color := sSkinManager1.GetGlobalColor;
      // Font.Color := sSkinManager1.GetGlobalFontColor;
      // if ACol >= Grid.FixedCols then
      // begin
      // weekDay := dayOfWeek(Period_ColToDate(ACol));
      // if weekDay IN [1, 7] then
      // begin
      // if cbxViewTypes.ItemIndex = 0 then
      // Brush.Color := HexToTColor('FFC2C2')
      // else
      // begin
      // Brush.Color := HexToTColor('F7F7F7');
      // Font.Color := clGray;
      // end;
      // end;
      // end;
      // FillRect(Rect);
      // if cbxViewTypes.ItemIndex > 0 then
      // begin
      // Font.Name := 'Segoe UI';
      // Font.Style := [fsBold];
      // end;
      FillRect(Rect);
      dx := (TextWidth(Text) + 2) div 2;
      TextOut(Rect.Right - (Rect.Right - Rect.Left) div 2 - dx, Rect.Top, Text);
    end;
  end;

end;

procedure TfrmMain.grPeriodRoomsDragDrop(Sender, Source: TObject; X, Y: integer);
var
  ACol, ARow: integer;
  newRoom: string;
  allow: boolean;
  isFiltering: boolean;
begin
  grPeriodRooms.MouseToCell(X, Y, ACol, ARow);

  newRoom := '';
  allow := false;

  if ACol <> zzSourceCol then
  begin
    allow := false;
    exit;
  end;

  if (ACol >= grPeriodRooms.FixedCols) and (ARow >= grPeriodRooms.FixedRows) and ((ARow <> grPeriodRooms.RowCount - 1) OR grPeriodViewFilterOn) and
    (grPeriodRooms.cells[ACol, ARow] = '') then
  begin
    allow := true;
  end;

  if allow then
  begin
    grPeriodRooms.BeginUpdate;
    try
      newRoom := grPeriodRooms.cells[1, ARow];

      MoveToRoomEnh2(zzRoomReservation, newRoom);

      isFiltering := grPeriodViewFilterOn;
      if isFiltering then
      begin
        ShowAllRoomsRows;
        btnRefreshOneDay.Click;
      end;

      // grPeriodRooms.GotoCell(ACol, ARow);

      zDebug1 := '210';
      RefreshGrid;
      NullGlobals;
      zzRoomReservation := -1;

      if isFiltering then
      begin
        FindRoomInPeriodView(newRoom);
        ReEnableFiltersInPeriodGrid;
        EnterPeriodDragFilter;
      end;

    finally
      grPeriodRooms.endUpdate;
    end;
  end;
end;





// ******************************************************************************
// ******************************************************************************
//
// +-------------------------------+
// | DRAG AND DROP IN No Room Grid |
// +-------------------------------+
//
//
// ******************************************************************************
// ******************************************************************************

procedure TfrmMain.grPeriodRooms_NOMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  iRoomReservation: integer;
  AscIndex: integer;
  ACol, ARow: integer;
  cellContent: string;
  allow: boolean;
begin
  if Button = mbRight then
    exit;
  grPeriodRooms_NO.MouseToCell(X, Y, ACol, ARow);
  cellContent := grPeriodRooms_NO.cells[ACol, ARow];

  zzSource := Sender;
  zzSourceCol := ACol;

  iRoomReservation := 0;
  AscIndex := -1;
  allow := false;

  // if  (ssShift in shift) or (ssCtrl in shift)  then
  // begin
  try
    iRoomReservation := (grPeriodRooms_NO.Objects[ACol, ARow] as TresCell).RoomReservation;
    AscIndex := (grPeriodRooms_NO.Objects[ACol, ARow] as TresCell).AscIndex;
  except
  end;

  allow := (iRoomReservation > 0) and (AscIndex = 0);

  if allow then
  begin

    grPeriodRooms.col := grPeriodRooms_NO.col;

    zzRoomReservation := (grPeriodRooms_NO.Objects[ACol, ARow] as TresCell).RoomReservation;
    zzReservation := (grPeriodRooms_NO.Objects[ACol, ARow] as TresCell).Reservation;
    zzRoomType := (grPeriodRooms_NO.Objects[ACol, ARow] as TresCell).RoomType;
    zzRoom := (grPeriodRooms_NO.Objects[ACol, ARow] as TresCell).Room;
    zzIsNoRoom := (grPeriodRooms_NO.Objects[ACol, ARow] as TresCell).isNoRoom;
    zzAscIndex := (grPeriodRooms_NO.Objects[ACol, ARow] as TresCell).AscIndex;
    zzDescIndex := (grPeriodRooms_NO.Objects[ACol, ARow] as TresCell).DescIndex;
    zzArrival := (grPeriodRooms_NO.Objects[ACol, ARow] as TresCell).Date + zzAscIndex;
    zzDeparture := (grPeriodRooms_NO.Objects[ACol, ARow] as TresCell).Date + zzDescIndex + 1;

    zzSourceCol := ACol;
    zzSourceRow := ARow;
    zzSourceGridID := 1;

    grPeriodRooms_NO.BeginDrag(false, 4);
  end;
  /// end;
end;

procedure TfrmMain.grPeriodRooms_NODragOver(Sender, Source: TObject; X, Y: integer; State: TDragState; var Accept: boolean);
begin
  Accept := zzSource <> Sender;
end;

procedure TfrmMain.grPeriodRooms_NODragDrop(Sender, Source: TObject; X, Y: integer);
var
  newRoom: string;
  allow: boolean;
  ACol, ARow: integer;
begin
  grPeriodRooms_NO.MouseToCell(X, Y, ACol, ARow);
  allow := zzSource <> Sender;

  if allow then
  begin
    newRoom := '';
    MoveToRoomEnh2(zzRoomReservation, newRoom);
    zDebug1 := '220';
    RefreshGrid;
    grPeriodRooms_NO.GotoCell(ACol, ARow);
    NullGlobals;
  end;
end;

procedure TfrmMain.grPeriodRooms_NOClickCell(Sender: TObject; ARow, ACol: integer);
var
  iRoomReservation: integer;
  aDate: Tdate;
begin
  zGridTag := (Sender as TAdvStringGrid).Tag;
  grPeriodRooms_NO.col := ACol;
  grPeriodRooms_NO.row := ARow;
  grPeriodRooms.col := ACol;
  if (ACol >= (Sender as TAdvStringGrid).FixedCols) then
  begin
    aDate := Period_NO_ColToDate(ACol);
    timGetRoomStatuses.Tag := trunc(aDate);
    timGetRoomStatuses.Enabled := true;
  end;
  try
    if assigned(grPeriodRooms_NO.Objects[ACol, ARow]) then
    begin
      iRoomReservation := (grPeriodRooms_NO.Objects[ACol, ARow] as TresCell).RoomReservation;
      EnableDisableFunctions(iRoomReservation >= 0);
    end
    else
      EnableDisableFunctions(false);
  except
    EnableDisableFunctions(false);
  end;
end;

function TfrmMain.Period_CheckHint(Sender: TObject; X, Y: integer; iReservation: integer = 0; iRoomReservation: integer = 0): String;
var
  ACol, ARow: integer;
  HintStr: String;
  APoint: TPoint;
  Rect: TRect;
  sRoom: string;
  sHintText: string;

  //
  rri: RecRRInfo;
  Grid: TAdvStringGrid;
  cellWidth, cellHeight: integer;

  // const
  // iExtraSpace = PERIOD_GRID_RECTANGLES_WIDTH;
begin
  result := '';

  Grid := TAdvStringGrid(Sender);
  Grid.MouseToCell(X, Y, ACol, ARow);

  if (ARow < Grid.FixedRows) then
  begin
    ApplicationCancelGuestHint;
    exit;
  end;

  if (ACol >= Grid.FixedCols) then
  begin
    Rect := Grid.CellRect(ACol, ARow);
    APoint := Point(Rect.Left, Rect.Top);
    APoint.X := Rect.Left + Grid.Left + pageMainGrids.Left;
    if (Grid = grPeriodRooms) then
      APoint.Y := Rect.Top + Grid.Top + pageMainGrids.Top + panMain.Top
    else if (Grid = grPeriodRooms_NO) then
      APoint.Y := Rect.Top + Grid.Top + pageMainGrids.Top + panMain.Top + pnlPeriodNoRooms.Top
    else
      APoint.Y := Rect.Top + Grid.Top + pageMainGrids.Top + panMain.Top;

    cellWidth := ABS(Rect.Right - Rect.Left);
    cellHeight := ABS(Rect.Bottom - Rect.Top);

    if (Grid = grOneDayRooms) then
      rri := OneDay_GetResInfo(ACol, ARow, iReservation, iRoomReservation)
    else
      rri := Period_GetResInfo(ACol, ARow, Grid.Tag);
    if rri.Reservation = -1 then
    begin
      ApplicationCancelGuestHint;
      exit;
    end;
    if (FrmReservationHintHolder.pnlHint.Visible) AND (iLastShownRoomReservation = rri.RoomReservation) AND (iLastShownHintRow = ARow) then
      // (iLastShownHintCol = ACol) then
      exit;

    iLastShownHintRow := ARow;
    iLastShownHintCol := ACol;
    iLastShownRoomReservation := rri.RoomReservation;

    FrmReservationHintHolder.CancelHint;
    FrmReservationHintHolder.ActivateHint(APoint.X, APoint.Y, cellWidth, cellHeight, rri);

    //
    exit;
  end;

  // // **

  if Sender <> grPeriodRooms then
    exit;

  if ACol = 1 then
  begin
    if (iLastHintRow = ARow) and (iLastHintCol = ACol) then
      exit;

    sRoom := grPeriodRooms.cells[ACol, ARow];
    result := d.getRoomText(sRoom);
    iLastHintRow := ARow;
    iLastHintCol := ACol;
    exit;
  end;

  // Rect := TAdvStringGrid(Sender).CellRect(ACol, ARow);
  // if ((iLastHintRow = ARow) AND (iLastHintCol = ACol)) AND (X < Rect.Right - 3 - (iExtraSpace * 3)) then
  // begin
  // exit;
  // end;
  //
  // GetPeriodRoomsGridHint(Sender, ARow, ACol, HintStr);
  // if HintStr = '' then
  // begin
  // TAdvStringGrid(Sender).Hint := '';
  // Application.CancelHint;
  // iLastHintRow := ARow;
  // iLastHintCol := ACol;
  // exit;
  // end;
  // TAdvStringGrid(Sender).Hint := HintStr;
  // // wraptext(hintstr,#13,[' ','-'],130);
  // APoint.X := X + 5;
  // APoint.Y := Y + 5;
  // APoint := TAdvStringGrid(Sender).ClientToScreen(APoint);
  // ActivateHint(APoint, TAdvStringGrid(Sender));
end;

procedure TfrmMain.grPeriodRooms_NOGetCellColor(Sender: TObject; ARow, ACol: integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
var
  BColor: TColor;
  FColor: TColor;

  status: string;
  AscIndex: integer;
  DescIndex: integer;

begin
  ABrush.Color := sSkinManager1.GetActiveEditColor;
  AFont.Color := sSkinManager1.GetActiveEditFontColor;
  AFont.Style := [];
  if (ACol IN [1, 2, 3, 4]) then
  begin
    ABrush.Color := sSkinManager1.GetGlobalColor;
    AFont.Color := sSkinManager1.GetGlobalFontColor;
    exit;
  end;

  if (ACol > grPeriodRooms_NO.FixedCols - 1) and (ARow <> grPeriodRooms_NO.RowCount - 1) then
  begin
    FColor := clRed;
    BColor := clRed;

    grNoRooms_GetResStatus(ACol, ARow, status, AscIndex, DescIndex);
    if ResStatusToColor(status, BColor, FColor) then
    begin
      ABrush.Color := BColor;
      AFont.Color := FColor;
    end;
  end;
end;

procedure TfrmMain.grPeriodRooms_NOKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  rri: RecRRInfo;
  RoomTypeForceWasOn: boolean;
  ColWas, RowWas: integer;
begin

  if (Key = VK_F1) AND (ssAlt IN Shift) then
  begin
    if NOT HintWindowShowing then
      ShowHintWindow;
    exit;
  end;

  if (Key = VK_CONTROL) then
  begin
    if grPeriodViewFilterOn then
    begin
      ColWas := ZPeriodRoomOnTheMoveCol;
      RowWas := ZPeriodRoomOnTheMoveRow;
      RoomTypeForceWasOn := ZPeriodRoomOnTheMoveForceType;
      ShowAllRoomsRows;

      ZPeriodRoomOnTheMoveForceType := NOT RoomTypeForceWasOn;
      if ZPeriodRoomOnTheMoveExternal then
      begin
        grPeriodRooms_NO.GotoCell(ColWas, RowWas);
        grPeriodRooms_NO.SetFocus;
        ReEnableFiltersInPeriodGrid;
        EnterPeriodDragFilterExternal
      end
      else
      begin
        grPeriodRooms.GotoCell(ColWas, RowWas);
        grPeriodRooms.SetFocus;
        ReEnableFiltersInPeriodGrid;
        EnterPeriodDragFilter;
      end;
    end;
  end
  else if (Key = VK_SHIFT) then
  begin
    if grPeriodViewFilterOn then
      ShowAllRoomsRows
    else if (grPeriodRooms_NO.cells[grPeriodRooms_NO.col, grPeriodRooms_NO.row] <> '') AND
      assigned(grPeriodRooms_NO.Objects[grPeriodRooms_NO.col, grPeriodRooms_NO.row]) then
    begin
      ReEnableFiltersInPeriodGrid;
      EnterPeriodDragFilterExternal;
    end;
  end
  else if Key = vk_Home then
  begin
    Key := 0;
  end;
  if Key = vk_end then
  begin
    Key := 0;
  end;
  if Key = vk_Right then
  begin
    Key := 0;
  end
  else if Key = vk_Left then
  begin
    Key := 0;
  end;
end;

procedure TfrmMain.grPeriodRooms_NOKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if HintWindowShowing then
  begin
    HintWindowShowing := false;
    ApplicationCancelHint;
    exit;
  end;

  if Key = vk_Home then
  begin
    Key := 0;
  end;
  if Key = vk_end then
  begin
    Key := 0;
  end;
  if Key = vk_Right then
  begin
    Key := 0;
  end
  else if Key = vk_Left then
  begin
    Key := 0;
  end;

end;

procedure TfrmMain.grPeriodRooms_NOGetCellBorder(Sender: TObject; ARow, ACol: integer; APen: TPen; var Borders: TCellBorders);
var
  status: string;
  AscIndex: integer;
  DescIndex: integer;

  borderColor: TColor;
  Left, Top, Right, Bottom: integer;

  rri: RecRRInfo;

begin
  if (ACol > grPeriodRooms_NO.FixedCols - 1) and (ARow > grPeriodRooms_NO.FixedRows - 1) and
  // (ACol <> gr5day.ColCount-1) and
    (ARow <> grPeriodRooms_NO.RowCount - 1) then
  begin
    // Borders :=  [cbLeft,cbTop,cbBottom, cbTop];
    Borders := [];
    APen.Color := clltGray;
    APen.Width := 1;

    if grNoRooms_GetResStatus(ACol, ARow, status, AscIndex, DescIndex) then
    begin
      if ResObjToBorder(status, AscIndex, DescIndex, borderColor, Left, Top, Right, Bottom) then
      begin
        Borders := [];
        if Left > 0 then
          Borders := Borders + [cbLeft];
        if Top > 0 then
          Borders := Borders + [cbTop];
        if Bottom > 0 then
          Borders := Borders + [cbBottom];
        if Right > 0 then
          Borders := Borders + [cbRight];

        rri := Period_GetResInfo(ACol, ARow, 2);
        APen.Color := getChannelColorByChannel(rri.Channel);
        // APen.color := clBlack; // BorderColor;
        APen.Width := 1;
      end;
    end;
  end;
end;

procedure TfrmMain.timBlinkTimer(Sender: TObject);
begin
  timBlinkRoom;
  timBlink.Enabled := false;
end;

procedure TfrmMain.mnuCancelReservation2Click(Sender: TObject);
begin
  _RemoveAReservation;
end;

procedure TfrmMain.mnuFilterLocationClick(Sender: TObject);
begin

end;

/// ////////////////////////////////////////////////////////////////////////////
//
//

procedure TfrmMain.timBlinkRoom;
var
  i: integer;
begin
  for i := 1 to grOneDayRooms.RowCount - 1 do
  begin
    if Copy(grOneDayRooms.cells[0, i], 1, length(zRoom)) = zRoom then
    begin
      grOneDayRooms.col := 2;
      grOneDayRooms.row := i;
      // BlinkRoom;
      BlinkRoom;
      break;
    end
    else if Copy(grOneDayRooms.cells[7, i], 1, length(zRoom)) = zRoom then
    begin
      grOneDayRooms.col := 9;
      grOneDayRooms.row := i;
      // BlinkRoom;
      BlinkRoom;
      break;
    end;
  end;

end;

procedure TfrmMain.barinnBarAdd(Sender: TdxBarManager; ABar: TdxBar);
begin
  ABar.DockControl := dxBarDockControl1;
  ABar.OneOnRow := false;
  ABar.RotateWhenVertical := false;
  ABar.DockedDockingStyle := dsTop;
end;

/// /////////////////////////////////////////////////////////////////////////////
///
/// Right click menu on OnDayGrid
///
/// /////////////////////////////////////////////////////////////////////////////

procedure TfrmMain.CheckInGroup1Click(Sender: TObject);
begin
end;

/// /////////////////////////////////////////////////////////////////////////////
//
//
//
/// /////////////////////////////////////////////////////////////////////////////

// ??????????????????????????????????????????????????????????????????????????????
// |  Bottons move to procedures                                                                           |
// ?????????????????????????????????????????????????????????????????????????????

procedure TfrmMain.btnNewReservationClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _NewReservation;
end;

procedure TfrmMain.btnRoomReservationClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _Roomreservation;
end;

procedure TfrmMain.btnModifyReservationClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _ModifyReservation;
end;

procedure TfrmMain.btnCancelReservationBtnClick(Sender: TObject);
begin
  _RemoveAReservation;
end;

procedure TfrmMain.btnCancelThisReservationClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _CancelAReservation;
end;

procedure TfrmMain.btnRoomGuestsClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _RoomGuests;
end;

procedure TfrmMain.SelectStopChannel(Sender: TObject);
var
  s: String;
  Value: integer;
  StatusCont: TRoomClassChannelAvailabilityContainer;
begin
  TMenuItem(Sender).Checked := NOT TMenuItem(Sender).Checked;
  if TMenuItem(Sender).Checked then
    Value := 1
  else
    Value := 0;

  StatusCont := availListContainer[grdRoomClasses.row - 1];
  // TRoomClassChannelAvailabilityContainer(grdRoomClasses.Objects[3, grdRoomClasses.Row]);
  StatusCont.AnyStop := AnyCheckedStopItems;

  s := Format('UPDATE channelrates SET dirty=1, Stop=%d ' + 'WHERE id=%d', [Value, TMenuItem(Sender).Tag]);
  if not cmd_bySQL(s) then
  begin
    raise Exception.Create('Channel Stop-Sale update failed.');
  end;
  grdRoomClasses.Update;
  grdRoomClasses.Invalidate;
end;

Function TfrmMain.AnyCheckedStopItems: boolean;
var
  i: integer;
begin
  result := false;
  for i := 0 to pmnuChannelSettings.Items.Count - 1 do
    if pmnuChannelSettings.Items[i].Checked then
    begin
      result := true;
      break;
    end;
end;

procedure TfrmMain.PopulateChannelStopMenu;
var
  rSet: TRoomerDataSet;
  item: TMenuItem;
  iValue: integer;
begin
  if (grdRoomClasses.row > 0) then
  begin

    pmnuChannelSettings.Items.Clear;
    iValue := strtointDef(grdRoomClasses.cells[3, grdRoomClasses.row], DEFAULT_UNPARSABLE_INT_VALUE);
    if iValue = DEFAULT_UNPARSABLE_INT_VALUE then
      exit;

    rSet := d.roomerMainDataSet.ActivateNewDataset
      (d.roomerMainDataSet.SystemFreeQuery(Format('SELECT id, Stop, ' + '       (SELECT Code FROM roomtypegroups WHERE id=roomClassId) AS roomClass, ' +
      '       channelId, ' + '       (SELECT name FROM channels WHERE id=channelId) AS channelName ' + 'FROM channelrates ' +
      'WHERE roomClassId=(SELECT id FROM roomtypegroups WHERE Code=''%s'' LIMIT 1) ' + 'AND to_bool((SELECT Active FROM channels WHERE id=channelId)) ' +
      'AND date=''%s'' ' + 'ORDER BY channelName', [grdRoomClasses.cells[0, grdRoomClasses.row], uDateUtils.dateToSqlString(lastDate)])));
    try
      rSet.first;
      while not rSet.eof do
      begin
        item := TMenuItem.Create(pmnuChannelSettings);
        item.Caption := 'Stop on ' + rSet['channelName'];
        item.Checked := rSet['Stop'];
        item.Tag := rSet['id'];
        item.OnClick := SelectStopChannel;
        pmnuChannelSettings.Items.Add(item);
        rSet.next;
      end;
    finally
      freeandNil(rSet);
    end;
  end;
end;

procedure TfrmMain.btnDeleteCacheClick(Sender: TObject);
var
  path: String;
begin
  UserClickedDxLargeButton(Sender);
  if MessageDlg(GetTranslatedText('shTx_Refresh_Local_Data_Cache'), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Cursor := crHourglass;
    Application.ProcessMessages;
    try
      path := glb.GetDataCacheLocation;
      TDirectory.Delete(path, true);
      glb.ForceTableRefresh;

      RemoveLanguagesFilesAndRefresh;
    finally
      Cursor := crDefault;
      Application.ProcessMessages;
    end;
  end;
end;

procedure TfrmMain.RemoveLanguagesFilesAndRefresh;
var
  path: String;
begin
  path := glb.GetLanguageLocation;
  DeleteAllFiles(TPath.Combine(path, 'RoomerLanguage*.src'));
  RoomerLanguage.LoadLanguage(true);

  TranslateOpenForms;
end;

procedure TfrmMain.IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  DownloadProgress(ASender, AWorkCount, AWorkCount);
end;

procedure TfrmMain.btnDeleteReservationClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _RemoveAReservation;
end;

procedure TfrmMain.btnDownloadBackupClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  if dlgSave.Execute then
  begin

    d.roomerMainDataSet.roomerClient.{$IFDEF USE_INDY}OnWork := IdHTTP1Work{$ELSE}OnDownloadProgress := DownloadProgress{$ENDIF};
    // lblBusyDownloading.Caption := 'Downloading...';
    lblBusyDownloading.Caption := GetTranslatedText('shTx_Main_Downloading');
    lblBusyDownloading.Visible := true;
    try
      d.roomerMainDataSet.SystemDownloadRoomerBackup(dlgSave.FileName);
    finally
      frmRoomerSplash.NilInternetEvents;
      // lblBusyDownloading.Caption := 'Ready.';
      lblBusyDownloading.Caption := GetTranslatedText('shTx_Main_Ready');
      lblBusyDownloading.Update;
      sleep(1000);
      lblBusyDownloading.Visible := false;
    end;
  end;
end;

procedure TfrmMain.btnDownPaymentsClick(Sender: TObject);
var
  sRoom: string;
  aDate: Tdate;
begin
  UserClickedDxLargeButton(Sender);
  // **
  aDate := Date;
  Application.CreateForm(TfrmRptDownPayments, frmRptDownPayments);
  try
    if frmRptDownPayments.ShowModal = mrOK then
    begin
      if frmRptDownPayments.zRoom <> '' then
      begin
        aDate := trunc(frmRptDownPayments.zArrival);
        RefreshGrid;
        sRoom := frmRptDownPayments.zRoom;
      end;
    end;
  finally
    frmRptDownPayments.Free;
  end;

  if sRoom <> '' then
  begin
    SetViews(1);
    SetDateWithoutEvents(aDate);
    StartOneDay;
    OneDay_DoAJump(sRoom);
  end;

end;

procedure TfrmMain.btnRemoveThisRoomClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _RemoveThisRoom
end;

procedure TfrmMain.btnReDownloadRoomerClick(Sender: TObject);
begin
  LoginCancelled := true;
  downloadCurrentVersion(handle, d.roomerMainDataSet);
  try
    d.roomerMainDataSet.Logout;
    lblUsername.Caption := 'N/A';
  except
  end;
  Close;
end;

procedure TfrmMain.btnRefreshClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _Refresh;
end;

procedure TfrmMain.btnChangeDateClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _ChangeDate;
end;

procedure TfrmMain.btnChannelPlansClick(Sender: TObject);
var
  theData: recChannelPlanCodeHolder;
begin
  UserClickedDxLargeButton(Sender);
  ChannelPlanCodes(actNone, theData);
end;

procedure TfrmMain.btnChannelsClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _Channels
end;

procedure TfrmMain.btnChannelToggleRulesClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  ShowCheannelTogglingRules;
end;

procedure TfrmMain.btnCheckInGroupClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _CheckInGroup
end;

procedure TfrmMain.btnCheckInRoomClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _CheckInRoom;
end;

procedure TfrmMain.btnCheckOutRoomClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _CheckOutRoom;
end;

procedure TfrmMain.btnClearSearchClick(Sender: TObject);
begin
  edtSearch.Text := '';
  btnFilter.Click;
  timSearch.Enabled := false;
  // OneDay_DisplayGrid;
  PerformFilterRefresh;
end;

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _Close;
end;

procedure TfrmMain.lblLogoutClick(Sender: TObject);
begin
  if Sender <> nil then
  begin
    lblAuthStatus.Caption := GetTranslatedText('shTx_Main_LoggedOut');
  end;
  _Logout;
end;

procedure TfrmMain.btnLogOutClick(Sender: TObject);
begin
end;


// procedure TfrmMain.btnLogOutClick(Sender: TObject);
// begin
// if Sender <> nil then
// begin
// lblAuthStatus.Caption := GetTranslatedText('shTx_Main_LoggedOut');
// end;
// _Logout;
// end;

procedure TfrmMain.btnLostAndFoundClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _LostAndFound;
end;

procedure TfrmMain.btnDayNotesClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _DayNotes;
end;

procedure TfrmMain.btnCashInvoiceClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _CashInvoice;
end;

procedure TfrmMain.btnCreditInvoiceClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _CreditInvoice;
end;

procedure TfrmMain.btnRoomInvoiceClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _RoomInvoice;
end;

procedure TfrmMain.btnGoOnlineClick(Sender: TObject);
begin
  OffLineMode := NOT(d.roomerMainDataSet.IsConnectedToInternet AND d.roomerMainDataSet.RoomerPlatformAvailable);
  if NOT OffLineMode then
    _Logout;
end;

procedure TfrmMain.btnGroupInvoiceClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _GroupInvoice;
end;

procedure TfrmMain.btnFilterClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to mnuFilterLocation.Items.Count - 1 do
    mnuFilterLocation.Items[i].Checked := false;
  T1.Checked := false;
  for i := 0 to S2.Count - 1 do
    S2.Items[i].Checked := false;
  for i := 0 to G2.Items.Count - 1 do
    G2.Items[i].Checked := false;
  for i := 0 to mnuItemStatus.Items.Count - 1 do
    mnuItemStatus.Items[i].Checked := false;
  edtSearch.Text := '';
  PerformFilterRefresh;
  btnFilter.ImageIndex := ABS(Ord(FilterActive));
  SetAllMnuFilterLocationsUnchecked;
end;

procedure TfrmMain.btnFinishedInvoicesClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _FinishedInvoices;
end;

procedure TfrmMain.CorrectBottomPeriodInterface;
begin
  grPeriodRooms_NO.Visible := btnUnassignedReservations.Down;
  embOccupancyView.pnlEmbeddable.Visible := btnOccupancyView.Down;

  pnlOccupancyViewButtons.Visible := btnOccupancyView.Down;
  pnlNoRoomButtons.Visible := btnUnassignedReservations.Down;

  // btnRefresh.Click;

  tabPeriod.Update;
  if btnOccupancyView.Down then
  begin
    pnlBottomViewSettings.Update;
    pnlOccupancyViewButtons.Update;
    embOccupancyView.pnlEmbeddable.Update;
  end
  else
  begin
    grPeriodRooms_NO.Update;
    pnlNoRoomButtons.Update;
  end;
  pnlOccupancyViewButtons.Refresh;
end;

procedure TfrmMain.btnOccupancyViewClick(Sender: TObject);
begin
  if assigned(Sender) then
    TSpeedButton(Sender).Down := true;
  PostMessage(handle, WM_REFRESH_PERIOD_VIEW_BOTTOM_REFRESH, 0, 0);
end;

procedure TfrmMain.btnOccupancyViewHideClick(Sender: TObject);
begin
  pnlPeriodNoRooms.Visible := Sender <> btnOccupancyViewHide;
  pnlPeriodNoRooms.Top := pnlBottomViewSettings.Top + pnlBottomViewSettings.Height + 10;
  if Sender = btnOccupancyViewHide then
    btnNoRoomsHide.Down := true
  else
    btnNoRoomsShow.Down := true;

  if Sender = btnOccupancyViewDefault then
    embOccupancyView.OccupancyViewType := ovtDefault
  else if Sender = btnOccupancyViewAdvanced then
    embOccupancyView.OccupancyViewType := ovtAdvanced;

  pnlBottomViewSettings.Update;
end;

procedure TfrmMain.btnOccupancyViewMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin
  ApplicationCancelHint;
  iLastHintRow := 0;
  iLastHintCol := 0;
  iLastPeriodHintRow := 0;
  iLastPeriodHintCol := 0;
end;

procedure TfrmMain.btnOpenInvoicesClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _OpenInvoices;
end;

procedure TfrmMain.btnClosedInvoicesAllDetailedListClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _ClosedInvoicesDetailed
end;

procedure TfrmMain.btnClosedInvoicesAllSimpleListClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _ClosedInvoicesSimple
end;

procedure TfrmMain.btnClosedInvoicesThisCustomerClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _ClosedInvoicesThisCustomer;
end;

procedure TfrmMain.btnClosedInvoicesThisreservationClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _ClosedInvoicesThisReservation;
end;

procedure TfrmMain.btnClosedInvoicesThisRoomClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _ClosedInvoicesThisRoom;
end;

/// /////////////////////////////////////////////////////////////////////////////

procedure TfrmMain.btnNextDayClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _Nextday;
end;

procedure TfrmMain.btnNoRoomsHideClick(Sender: TObject);
begin
  pnlPeriodNoRooms.Visible := Sender = btnNoRoomsShow;
  pnlPeriodNoRooms.Top := pnlBottomViewSettings.Top + pnlBottomViewSettings.Height + 10;
  if Sender = btnNoRoomsHide then
    btnOccupancyViewHide.Down := true
  else
    btnOccupancyViewDefault.Down := true;
  pnlBottomViewSettings.Update;
end;

procedure TfrmMain.btnTaxesClick(Sender: TObject);
var
  theData: recTaxesHolder;
begin
  UserClickedDxLargeButton(Sender);
  if Taxes(actNone, theData) then;
  initializeTaxes;
end;

procedure TfrmMain.btnTestDataClick(Sender: TObject);
begin
  // Application.CreateForm(TfrmRebuildReservationStats, frmRebuildReservationStats);
  // try
  // frmRebuildReservationStats.ShowModal;
  // finally
  // frmRebuildReservationStats.free;
  // end;
  Application.CreateForm(TfrmTestData, frmTestData);
  try
    if frmTestData.ShowModal = mrOK then
    begin
    end;
  finally
    frmTestData.Free;
  end;
end;

procedure TfrmMain.btnTextBasedTemplatesClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  StaticResources('Text based templates', TEXT_BASED_TEMPLATES, ACCESS_OPEN, TTextResourceParameters.Create);
end;

procedure TfrmMain.btnToDayClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _Today;
end;

procedure TfrmMain.btnTotallistClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  rptTotalList;
end;

procedure TfrmMain.btnPreviusDayClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _PreviusDay;
end;

procedure TfrmMain.btnDayViewClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _DayView;
end;

procedure TfrmMain.btnPeriodViewClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _PeriodView;
end;

procedure TfrmMain.btnPersonvipTypesClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _PersonvipTypesList;
end;

procedure TfrmMain.btnMeetingsViewClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _GuestListView
end;

procedure TfrmMain.btnMaidsClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _RptMaidsList;
end;

procedure TfrmMain.btnManagerChannelManagerListClick(Sender: TObject);
var
  act: TActTableAction;
  theData: recChannelManagerHolder;
begin
  UserClickedDxLargeButton(Sender);
  act := actNone;
  initChannelManagerHolder(theData);
  if ChannelManager(act, theData) then
  begin
  end
  else
  begin
  end;
end;

procedure TfrmMain.btnManagmentStatClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  rptManagment;
end;

procedure TfrmMain.btnDayFinalClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _RptDayFinal
end;

procedure TfrmMain.btnRptCustInvoices2Click(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _RptCustomersInvoiceAllPayTypes;
end;

procedure TfrmMain.btnRptCustInvoicesClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  RptResInvoices
end;

procedure TfrmMain.btnRptFinanceForecastClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _RptFinancieForecast
end;

procedure TfrmMain.btnRptNationalReportClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _RptNationality
end;

procedure TfrmMain.btnRoomsClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _RoomList;
end;

procedure TfrmMain.btnRoomTypeGroupsClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _RoomTypeGroupsList;
end;

procedure TfrmMain.btnRoomTypesClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _RoomTypeList;
end;

procedure TfrmMain.btnLocationFilterClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to mnuFilterLocation.Items.Count - 1 do
    mnuFilterLocation.Items[i].Checked := false;
  SetAllMnuFilterLocationsUnchecked;
  PerformFilterRefresh;
end;

procedure TfrmMain.btnLocationsClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _LocationsList
end;

procedure TfrmMain.btnLodgingTaxReportClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _RptLodgingTax;
end;

procedure TfrmMain.btnSetNoRoomAllClick(Sender: TObject);
begin
  _SetNoRoomAll;
end;

procedure TfrmMain.btnSetNoroomClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);

end;

procedure TfrmMain.btnSetNoRoomThisClick(Sender: TObject);
begin
  _SetNoRoomThis;
end;

procedure TfrmMain.btnProvideARoomClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _ProvideARoom;
end;

procedure TfrmMain.btnSerachGuestsClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _SearchAllGuests;
end;

procedure TfrmMain.btnCustomerListClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _CustomersList;
end;

procedure TfrmMain.btnCustomerTypeListClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _CustomerTypeList;
end;

procedure TfrmMain.btnDashboardClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  ShowDashboard(self.handle, d.roomerMainDataSet);
end;

procedure TfrmMain.btnCommunicationTestClick(Sender: TObject);
begin
  CommunicationTest;
end;

procedure TfrmMain.btnConfirmAllottedBookingClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  ConfirmABooking;
end;

procedure TfrmMain.btnContactTypesClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _PersonContactTypeList;
end;

procedure TfrmMain.btnCountriesListClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _CountyList;
end;

procedure TfrmMain.btnCountryGroupsListClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _CountryGroupList;
end;

procedure TfrmMain.btnCurrenciesListClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _CurrencyList;
end;

procedure TfrmMain.btnVatCodesListClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _VatCodesList
end;

procedure TfrmMain.btnPackagesClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _packages;
end;

procedure TfrmMain.btnPaymentGroupListClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _PayGroupList
end;

procedure TfrmMain.btnPaymentTypesListClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _PayTypesList
end;

procedure TfrmMain.btnItemsListClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _ItemsList
end;

procedure TfrmMain.btnItemTypeListClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _ItemTypeList;
  itemTypeInfoRent.Itemtype := '';
  itemTypeInfoTax.Itemtype := '';
end;

procedure TfrmMain.btnEmailTemplatesClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  mnuEmailTemplates.PopupFromCursorPos;
end;

procedure TfrmMain.btnEmployeeListClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _EmployeeList;
end;

procedure TfrmMain.btnEmployeeTypesListClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _EmployeeTypesList;
end;

procedure TfrmMain.btnStaffAuthorizationListClick(Sender: TObject);
begin
  _StaffAuthorizationList;
end;

procedure TfrmMain.PerformFilterRefresh;
begin
  timSearch.Enabled := false;
  timSearch.Interval := 1;
  timSearch.Enabled := true;
end;

procedure TfrmMain.checkFilterStatuses;
var
  i: integer;
begin
  btnStatusFilter.Font.Style := [];
  for i := 0 to mnuItemStatus.Items.Count - 1 do
    if mnuItemStatus.Items[i].Checked then
    begin
      btnStatusFilter.Font.Style := [fsUnderline];
      break;
    end;

  btnLocationFilter.Font.Style := [];
  for i := 0 to mnuFilterLocation.Items.Count - 1 do
    if mnuFilterLocation.Items[i].Checked then
    begin
      btnLocationFilter.Font.Style := [fsUnderline];
      break;
    end;

  btnGroupsFilter.Font.Style := [];
  for i := 0 to G2.Items.Count - 1 do
    if G2.Items[i].Checked then
    begin
      btnGroupsFilter.Font.Style := [fsUnderline];
      break;
    end;
end;

procedure TfrmMain.btnStatusFilterClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to mnuItemStatus.Items.Count - 1 do
    mnuItemStatus.Items[i].Checked := false;
  checkFilterStatuses;
  PerformFilterRefresh;
end;

procedure TfrmMain.btnPhonePricesClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _PhonePrices;
end;

procedure TfrmMain.btnRoomPriceClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _RoomRates;
end;

procedure TfrmMain.btnRoomPriceTypesClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _PriceCodes;
end;

procedure TfrmMain.btnSeasonsClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _Seasons
end;

procedure TfrmMain.btnAboutClick(Sender: TObject);
begin
  {$IFDEF DEBUG}
     openInvoiceCompare;
  {$Else}
     _About
  {$ENDIF}
end;

procedure TfrmMain.btnHelpContentClick(Sender: TObject);
begin
  _HelpContent
end;

procedure TfrmMain.btnRemoteSupportClick(Sender: TObject);
begin
  StartRemoteSupport(self.handle, d.roomerMainDataSet);
  // FixRoomTypes;
  // _RemodeHelp
end;

procedure TfrmMain.btnSettingsClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _Settings;
  ALREADY_READ_DAY_VIEW_SIZES := false;
  if LoadOneDayViewGridStatus then
  begin
    grAutoSizeGrids;
    AutoSizePeriodColumns;
    AutoResizeOneDayGrid;
  end;
  btnRefreshOneDay.Click;
end;

procedure TfrmMain.btnLanguageClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _Language
end;

procedure TfrmMain.btnTurnoverClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  if isStayTaxExcluded then
  begin
    OpenRptTurnoverAndPayments2;
  end else
  begin
    OpenRptTurnoverAndPayments;
  end;
end;

procedure TfrmMain.btnShowHideStatClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  // if NOT pnlStatSlider.Visible then
  // OpenWindowFromRight(pnlStatSlider.Handle)
  // else
  // CloseWindowToRight(pnlStatSlider.Handle);
  pnlStatSlider.Visible := NOT btnShowHideStat.Down;
  // btnShowHideStat.Down := NOT PanStat.Visible;
  pnlStatSlider.Left := Width;
  if assigned(Sender) then
    btnRefreshOneDay.Click;
end;

procedure TfrmMain.dxBarLargeButton4Click(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  StaticResources('Files', ANY_FILE, ACCESS_RESTRICTED);
end;

procedure TfrmMain.btnWebAccessibleFilesClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  StaticResources('Files', ANY_FILE, ACCESS_OPEN);
end;

procedure TfrmMain.btnCashierReportClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  RptCashier;
end;

procedure TfrmMain.btnBookKeepingQueriesClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  RptBookkeeping;
end;

procedure TfrmMain.btnBookKeepingCodesClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  BookKeepingCodes(actNone, '');
end;

procedure TfrmMain.btnClearWindowCacheClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  if MessageDlg(GetTranslatedText('shTx_ClearWindowsCacheAndClose'), mtConfirmation, [mbYes, mbCancel], 0) = mrYes then
  begin
    DeleteRegistryLocation('Software\Roomer\FormStatus');
    ExitProcess(0);
  end;
end;

procedure TfrmMain.btnRptNotesClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  RptNotes;
end;

procedure TfrmMain.dxBarSubItem1Click(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  ShowChannelAvailabilityManager();
end;

procedure TfrmMain.ShowBookingConfirmationTemplates;
begin
  mniBookinglEmailTemplatesClick(nil);
end;

procedure TfrmMain.ShowCancelConfirmationTemplates;
begin
  mniCancelEmailTemplatesClick(nil);
end;

procedure TfrmMain.mniBookinglEmailTemplatesClick(Sender: TObject);
begin
  StaticResources('Booking Confirmation Email Templates', GUEST_EMAIL_TEMPLATE, ACCESS_OPEN, THtmlResourceParameters.Create);
end;

procedure TfrmMain.mniCancelEmailTemplatesClick(Sender: TObject);
begin
  StaticResources('Cancellation Confirmation Email Templates', CANCEL_EMAIL_TEMPLATE, ACCESS_OPEN, THtmlResourceParameters.Create);
end;

procedure TfrmMain.edtSearchChange(Sender: TObject);
begin
  timSearch.Enabled := false;
  timSearch.Enabled := true;
  edtSearch.RightButton.Visible := edtSearch.Text <> '';
end;

procedure TfrmMain.btnResStatClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  // Application.CreateForm(TfrmRebuildReservationStats, frmRebuildReservationStats);
  // try
  // frmRebuildReservationStats.ShowModal;
  // finally
  // frmRebuildReservationStats.free;
  // end;
  // exit;

  // Application.CreateForm(TfrmRptResDates, frmrptResDates);
  // try
  // frmrptResDates.ShowModal;
  // finally
  // freeandnil(frmrptResDates);
  // end;

  Application.CreateForm(TfrmRptResStatsRooms, frmRptResStatsRooms);
  try
    frmRptResStatsRooms.ShowModal;
  finally
    freeandNil(frmRptResStatsRooms);
  end;
end;

procedure TfrmMain.btnReservationNotesClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  if GetSelectedRoomInformation then
  begin
    if g.openresMemo(_iReservation) then
      if (ViewMode = vmOneDay) OR (ViewMode = vmPeriod) then
        RefreshGrid;
  end;
end;

procedure TfrmMain.btnReservationsListClick(Sender: TObject);
var
  sRoom: string;
  aDate: Tdate;
begin
  UserClickedDxLargeButton(Sender);
  // **
  aDate := Date;
  Application.CreateForm(TfrmRptReservations, frmRptReservations);
  try
    if frmRptReservations.ShowModal = mrOK then
    begin
      if frmRptReservations.zRoom <> '' then
      begin
        aDate := trunc(frmRptReservations.zArrival);
        RefreshGrid;
        sRoom := frmRptReservations.zRoom;
      end;
    end;
  finally
    frmRptReservations.Free;
  end;

  if sRoom <> '' then
  begin
    SetViews(1);
    SetDateWithoutEvents(aDate);
    StartOneDay;
    OneDay_DoAJump(sRoom);
  end;

end;

procedure TfrmMain.GoToDateAndRoom(aDate: TdateTime; RoomReservation: integer);
var
  i, l: integer;
  Room: String;
begin
  SetViews(1);
  SetDateWithoutEvents(aDate);
  StartOneDay;
  Room := '';
  for i := 0 to ReservationsModel.ReservationCount - 1 do
    for l := 0 to ReservationsModel.Reservations[i].RoomCount - 1 do
      if ReservationsModel.Reservations[i].Rooms[l].RoomRes = RoomReservation then
      begin
        Room := ReservationsModel.Reservations[i].Rooms[l].RoomNumber;
        OneDay_DoAJump(Room);
      end;
end;

procedure TfrmMain.btnShowHideHintClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  if Sender = nil then
  begin
    g.qShowhint := NOT btnShowHideHint.Down;
  end
  else
  begin
    g.qShowhint := not g.qShowhint;
    btnShowHideHint.Down := NOT g.qShowhint;
  end;
end;

procedure TfrmMain.btnQuicReservationClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  CreateQuickReservation(true);
end;

procedure TfrmMain.btnVariblesClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _VariblesList;
end;

procedure TfrmMain.btnVariblesGroupsClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _VariblesGroupList;
end;

procedure TfrmMain.BtnMaidJobScriptsClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _MaidJobScripts
end;

procedure TfrmMain.btnRateRulesClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);

end;

procedure TfrmMain.btnRatesClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  _Rates;
end;

procedure TfrmMain.btnHideCaptonsClick(Sender: TObject);
begin
  _HideCaptons;
end;

procedure TfrmMain.btnHotelSpecificSqlQueriesClick(Sender: TObject);
begin
end;

/// ///////////////////////////////////////////////////////////////////////////
procedure TfrmMain.btnLPreviusDayClick(Sender: TObject);
begin
  _PreviusDay;
end;

procedure TfrmMain.btnLTodayClick(Sender: TObject);
begin
  _Today;
end;

procedure TfrmMain.btnLNextDayClick(Sender: TObject);
begin
  _Nextday;
end;

/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////
/// ////////////////   A C T I O N S   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////

(*
  #########################################################################
  ######################### Buttons in the bars ###########################
  #########################################################################
*)

// ############################# File #####################################

function TfrmMain._Logout(AlreadyInactive: boolean = false; AutoLogin: String = ''): boolean;
begin
  lblHotelName.Caption := '';
  performClearHotel(NOT AlreadyInactive);
  result := false;
  try
    result := StartHotel(false, AlreadyInactive, AutoLogin);
  finally
    panelHide.Hide;
  end;
  lblUsername.Caption := 'N/A';
end;

procedure TfrmMain._Close;
begin
  Close;
end;

procedure TfrmMain._ChangeDate;
begin
  frmHomedate.dtHome.Date := dtDate.Date;
  frmHomedate.Show;
  frmHomedate.Left := Left + 1;
  frmHomedate.Top := Top - 1;

  frmHomedate.ActiveControl := frmHomedate.dtHome;
  frmHomedate.dtHome.SelLength := 0;
  frmHomedate.dtHome.SetFocus;
  frmHomedate.dtHome.SelStart := 0;
  frmHomedate.dtHome.SelLength := length(frmHomedate.dtHome.Text);
end;

procedure TfrmMain._Refresh;
begin
  zDebug1 := '260';
  RefreshGrid;
end;

procedure TfrmMain._DayNotes;
begin
  if frmDayNotes.V then
  begin
    frmDayNotes.V := false;
    frmDayNotes.Close;
  end
  else
  begin
    frmDayNotes.V := true;
    frmDayNotes.ActiveTab := -1;
    frmDayNotes.Show;
  end;
end;

// ############################# Check in/out ################################

procedure TfrmMain._CheckInRoom;
begin
  if not IsValidCellSelected then
    exit;
  OneDay_CheckIn;
end;

procedure TfrmMain._CheckInGroup;
begin
  if not IsValidCellSelected then
    exit;
  CheckInGroup;
end;

procedure TfrmMain._CheckOutRoom;
begin
  if not IsValidCellSelected then
    exit;
  OneDay_CheckOut;
end;

// ##############################  Invoices ##################################

procedure TfrmMain._RoomInvoice;
begin
  // Room Invoice
  // if not IsValidCellSelected then exit;
  OneDay_RoomInvoice(1); // RoomInvoice

  if d.qRes > -1 then
  begin
    if d.qrres = 0 then
    begin
      EditInvoice(d.qRes, 0, 0, 0, 0, 0, false, true, false);
    end
    else
    begin
      // This is not groupinvoice
      EditInvoice(d.qRes, d.qrres, 0, 0, 0, 0, false, true, false);
    end;
  end;

  d.qRes := -1;
  d.qrres := -1;

end;

procedure TfrmMain._GroupInvoice;
begin
  // - Group Invoice
  if not IsValidCellSelected then
    exit;
  OneDay_RoomInvoice(2);

  if d.qRes > -1 then
  begin
    if d.qrres = 0 then
    begin
      EditInvoice(d.qRes, 0, 0, 0, 0, 0, false, true, false);
    end
    else
    begin
      // This is not groupinvoice
      EditInvoice(d.qRes, d.qrres, 0, 0, 0, 0, false, true, false);
    end;
  end;

  d.qRes := -1;
  d.qrres := -1;

end;

procedure TfrmMain._CashInvoice;
begin
  try
    EditInvoice(0, 0, 2, 0, 0, 0, false, true, false);
  finally
  end;
end;

procedure TfrmMain._CreditInvoice;
var
  CreateNew: boolean;
begin
  CreateNew := true;
  MakeKreditInvoice(0, CreateNew);
  //
  d.qRes := -1;
  d.qrres := -1;
end;

procedure TfrmMain._FinishedInvoices;
begin
  // - Finished invoices
  // No action - subMenu
  mnuFinishedInvoices.PopupFromCursorPos;
end;

procedure TfrmMain._OpenInvoices;
begin
  g.OpenOpenInvoicesNew;
  (*
    Application.CreateForm(TfrmOpenInvoices, frmOpenInvoices);
    try
    iTraceRes := - 1;
    iTraceRom := - 1;
    frmOpenInvoices.ShowModal;
    finally
    frmOpenInvoices.free;
    end;
  *)
end;

procedure TfrmMain._ClosedInvoicesDetailed;
var
  sRoom: string;
begin
  sRoom := '';

  Application.CreateForm(TfrmInvoiceList2, frmInvoiceList2);
  try
    if frmInvoiceList2.ShowModal = mrOK then
    begin
      if frmInvoiceList2.zRoom <> '' then
      begin
        dtDate.Date := trunc(frmInvoiceList2.zArrival);
        // RefreshGrid;
        sRoom := frmInvoiceList2.zRoom;
      end;
    end;
  finally
    frmInvoiceList2.Free;
  end;

  if sRoom <> '' then
  begin
    zRoom := sRoom;
    timBlink.Enabled := true;
  end;
end;

procedure TfrmMain._ClosedInvoicesSimple;
begin
  Application.CreateForm(TfrmInvoiceList, frmInvoiceList);
  try
    frmInvoiceList.ShowModal;
  finally
    frmInvoiceList.Free;
  end;
end;

procedure TfrmMain._ClosedInvoicesThisCustomer;
begin
  // ** Finished invoices - this Customer
  if not IsValidCellSelected then
    exit;
  OneDay_InvoicesPerCustomer;
end;

procedure TfrmMain._ClosedInvoicesThisReservation;
begin
  // ** Finished invoices - this reservation
  if not IsValidCellSelected then
    exit;
  OneDay_InvoicesPerRes;
end;

procedure TfrmMain._ClosedInvoicesThisRoom;
var
  CreateNew: boolean;
begin
  // ** Finished invoices - this room
  if not IsValidCellSelected then
    exit;
  OneDay_InvoicesPerRoom;
end;


// ############################# Reservations ################################

procedure TfrmMain._NewReservation;
begin
  CreateQuickReservation(false);
end;

procedure TfrmMain._Roomreservation;
begin
  // **
  if not IsValidCellSelected then
    exit;
  Open_RR_EdForm(GetActivePeriodGrid);
end;

procedure TfrmMain._ModifyReservation;
begin
  if not IsValidCellSelected then
    exit;
  Open_RES_edForm(GetActivePeriodGrid);
end;

procedure TfrmMain._RemoveAReservation;
begin
  RemoveAReservation;
end;

procedure TfrmMain._CancelAReservation;
begin
  CancelAReservation;
end;

procedure TfrmMain._RoomGuests;
begin
  if not IsValidCellSelected then
    exit;
  OneDay_EditPerson;
end;

procedure TfrmMain._ReservationRoomList;
begin
end;

procedure TfrmMain._DeleteReservation;
begin
  RemoveAReservation;
end;

procedure TfrmMain._RemoveThisRoom;
begin
  if not IsValidCellSelected then
    exit;
  OneDay_DeleteRoomReservation;
end;

procedure TfrmMain._CancelThisReservation;
begin
  RemoveAReservation;
end;


// ############################# Navigation ################################

procedure TfrmMain._Nextday;
begin
  g.qDebug1 := '_Nextday';
  dtDate.Date := trunc(dtDate.Date + 1);
  // RefreshGrid;
end;

procedure TfrmMain._Today;
begin
  g.qDebug1 := '_Today';
  dtDate.Date := trunc(now);
  // RefreshGrid;
end;

procedure TfrmMain._PreviusDay;
begin
  g.qDebug1 := '_PreviusDay';
  dtDate.Date := trunc(dtDate.Date - 1);
  // RefreshGrid;
end;

// ############################  Channels  #######################################

procedure TfrmMain._Channels;
var
  theData: recChannelHolder;
begin
  openChannels(actNone, theData);
end;

// ############################  View  #######################################
procedure TfrmMain.__cbxHotelsChange(Sender: TObject);
begin
  if (__cbxHotels.Items.Count > 0) then
  begin
    _Logout(false, TRoomerHotelsEntity(__cbxHotels.Items.Objects[__cbxHotels.ItemIndex]).hotelCode);
    checkFilterStatuses;
  end;
end;

procedure TfrmMain.cbxNameOrderChange(Sender: TObject);
begin
  if zDoRefresh then
  begin
    g.qNameOrder := cbxNameOrder.ItemIndex;
    zDebug1 := '280';
    RefreshGrid;
  end
  else
  begin
    zDoRefresh := true;
  end;
end;

procedure TfrmMain.cbxNameOrderPeriodChange(Sender: TObject);
begin
  if zDoRefreshPeriod then
  begin
    g.qNameOrderPeriod := cbxNameOrderPeriod.ItemIndex;
    zDebug1 := '290';
    RefreshGrid;
  end
  else
  begin
    zDoRefreshPeriod := true;
  end;
end;

procedure TfrmMain.cbxStatDayChange(Sender: TObject);
begin
  RefreshStats(true);
end;

procedure TfrmMain.cbxViewTypesCloseUp(Sender: TObject);
begin
  //
  PlacePeriodViewTypePanel;
end;

// ############################# Set View  ###################################

procedure TfrmMain._DayView;
begin
  EnterDayView;
end;

procedure TfrmMain._PeriodView;
begin
  EnterPeriodView;
end;

procedure TfrmMain._GuestListView;
begin
  EnterGuestListView;
end;

// ############################# Reports  ?###################################

procedure TfrmMain._RptDayFinal;
begin
  Application.CreateForm(TfrmDayFinical, frmDayFinical);
  try
    frmDayFinical.ShowModal;
  finally
    frmDayFinical.Free;
  end;
end;

procedure TfrmMain._RptCustomersInvoiceAllPayTypes;
begin
  RptCustInvoices;
end;

procedure TfrmMain._RptMaidsList;
begin
  Application.CreateForm(TfrmHouseKeeping, frmHouseKeeping);
  try
    frmHouseKeeping.zDate := dtDate.Date;
    if frmHouseKeeping.ShowModal = mrOK then
    begin
      //
    end;

  finally
    freeandNil(frmHouseKeeping);
  end;
end;

procedure TfrmMain._RptNationality;
begin
  Application.CreateForm(TfrmNationalReport3, frmNationalReport3);
  try
    if frmNationalReport3.ShowModal = mrOK then
    begin
      //
    end;
  finally
    freeandNil(frmNationalReport3);
  end;
end;

procedure TfrmMain._RptLodgingTax;
begin
  Application.CreateForm(TfrmlodgingTaxReport2, frmLodgingTaxReport2);
  try
    if frmLodgingTaxReport2.ShowModal = mrOK then
    begin
      //
    end;
  finally
    freeandNil(frmLodgingTaxReport2);
  end;
end;

procedure TfrmMain._RptFinancieForecast;
begin

  Application.CreateForm(TfrmRptResStats, frmrptResStats);
  try
    frmrptResStats.ShowModal;
  finally
    freeandNil(frmrptResStats);
  end;

  // Application.CreateForm(TfrmStatisticsForcast, frmStatisticsForcast);
  // try
  // frmStatisticsForcast.ShowModal;
  // finally
  // frmStatisticsForcast.free;
  // end;

end;

// ############################# Room Data  ##################################

procedure TfrmMain._RoomList;
var
  zData: recRoomHolder;
begin
  OpenRooms(actNone, zData);
end;

procedure TfrmMain._RoomTypeGroupsList;
var
  theData: recRoomTypeGroupHolder;
begin
  openRoomTypeGroups(actNone, theData);
end;

procedure TfrmMain._RoomTypeList;
var
  theData: recRoomTypeHolder;
begin
  openRoomTypes(actNone, theData);
end;

procedure TfrmMain._RoomSelectionRules;
begin
end;

procedure TfrmMain._LocationsList;
var
  theData: recLocationHolder;
begin
  if OpenLocation(actNone, theData) then
end;

// ########################  Room Actions ####################################

procedure TfrmMain._SetNoRoomThis;
begin
  OneDay_RemoveRoom(GetActivePeriodGrid, false);
end;

procedure TfrmMain._SetNoRoomAll;
begin
  OneDay_RemoveRoom(GetActivePeriodGrid, true);
end;

procedure TfrmMain._ProvideARoom;
begin
  OneDay_DoProvideRoom;
end;

procedure TfrmMain._SearchAllGuests;
var
  sRoom: string;
begin

  // sRoom := '';
  // Application.CreateForm(TfrmGuestsSearch, frmGuestsSearch);
  // try
  // frmGuestsSearch.zzDate := dtDate.Date;
  //
  // if frmGuestsSearch.ShowModal = mrOK then
  // begin
  // if frmGuestsSearch.zGoTo then
  // begin
  // dtDate.Date := trunc(frmGuestsSearch.zArrival);
  // zdebug1 := '300';
  // RefreshGrid;
  // sRoom := frmGuestsSearch.zRoom;
  // end;
  // end;
  // finally
  // frmGuestsSearch.free;
  // end;
  //
  // if sRoom <> '' then
  // begin
  // zRoom := sRoom;
  // timBlink.Enabled := true;
  // end;

  sRoom := '';
  Application.CreateForm(TfrmGuestSearch, frmGuestSearch);
  try
    frmGuestSearch.ShowModal;
    if frmGuestSearch.ModalResult = mrOK then
    begin
      if frmGuestSearch.zGoTo then
      begin
        SetDateWithoutEvents(trunc(frmGuestSearch.zDateFrom));
        if tabsView.TabIndex <> 0 then
        begin
          tabsView.TabIndex := 0;
          pageMainGrids.ActivePage := tabOneDayView;
          pageMainGridsChange(pageMainGrids);
        end;
        RefreshGrid;
        sRoom := frmGuestSearch.zRoom;
      end;
    end;
  finally
    freeandNil(frmGuestSearch);
  end;

  if sRoom <> '' then
  begin
    zRoom := sRoom;
    timBlink.Enabled := true;
  end;
end;

procedure TfrmMain._JumptoRoomAndDate;
var
  aRoom: string;
  aDate: Tdate;

  ACol: integer;
  ARow: integer;
begin
  aDate := dtDate.Date;
  aRoom := '';

  SetViews(1);
  // if ViewMode = vmOneDay then
  // begin
  ACol := grOneDayRooms.col;
  ARow := grOneDayRooms.row;

  if OneDay_GetIsLeftOrRight(ACol) = 1 then
  begin
    aRoom := grOneDayRooms.cells[0, ARow];
  end
  else
  begin
    aRoom := grOneDayRooms.cells[7, ARow];
  end;
  g.openGoToRoomAndDate(aRoom, aDate);

  SetDateWithoutEvents(trunc(aDate));
  g.qDebug1 := '_JumptoRoomAndDate';
  StartOneDay;
  OneDay_DoAJump(aRoom);
  // end;

end;

procedure TfrmMain.actLanguageExecute(Sender: TObject);
begin

end;

// ########################  Customer - country - Currency ####################

procedure TfrmMain._CustomersList;
var
  theData: recCustomerHolder;
begin
  openCustomers(actNone, false, theData);
end;

procedure TfrmMain._PersonvipTypesList;
var
  theData: recPersonVipTypesHolder;
begin
  openPersonviptypes(actNone, theData);
end;

procedure TfrmMain._PersonContactTypeList;
var
  theData: recPersonContactTypeHolder;
begin
  openPersonContactType(actNone, theData);
end;

procedure TfrmMain._CustomerTypeList;
var
  theData: recCustomerTypeHolder;
begin
  openCustomerTypes(actNone, theData);
end;

procedure TfrmMain._CountyList;
var
  act: TActTableAction;
  theData: recCountryHolder;
begin
  act := actNone;
  initCountryHolder(theData);
  if Countries(act, theData) then
  begin
  end
  else
  begin
  end;
end;

procedure TfrmMain._CountryGroupList;
var
  act: TActTableAction;
  theData: recCountryGroupHolder;
begin
  act := actNone;
  initCountryGroupHolder(theData);
  if CountryGroups(act, theData) then
  begin
  end
  else
  begin
  end;
end;

procedure TfrmMain._CurrencyList;
var
  theData: recCurrencyHolder;
  act: TActTableAction;
begin
  act := actNone;
  initCurrencyHolder(theData);
  if Currencies(act, theData) then
  begin
  end
  else
  begin
  end;
end;

procedure TfrmMain._LostAndFound;
var
  theData: recLostAndFoundHolder;
  act: TActTableAction;
begin
  act := actNone;
  initLostAndFoundHolder(theData);
  if OpenlostAndFound(act, theData) then
  begin
  end
  else
  begin
  end;
end;


// #######################  Sales - Payments ##############################

procedure TfrmMain._VatCodesList;
var
  theData: recVatCodeHolder;
begin
  vatCodes(actNone, theData);
end;

procedure TfrmMain._PayGroupList;
var
  theData: recPayGroupHolder;
begin
  payGroup(actNone, theData);
end;

procedure TfrmMain._PayTypesList;
var
  theData: recPayTypeHolder;
begin
  payType(actNone, false, theData);
end;

procedure TfrmMain._ItemTypeList;
var
  theData: recItemTypeHolder;
begin
  openItemTypes(actNone, theData);
end;

procedure TfrmMain._ItemsList;
var
  theData: recItemHolder;
begin
  if OpenItems(actNone, false, theData) then
end;

procedure TfrmMain._packages;
var
  theData: recPackageHolder;
begin
  if OpenPackages(actNone, theData) then
end;

// #######################  Employee  ########################################

procedure TfrmMain._EmployeeList;
var
  theData: recStaffMemberHolder;
begin
  openStaffmembers(actNone, theData);
end;

procedure TfrmMain._EmployeeTypesList;
var
  theData: recStaffTypeHolder;
begin
  openStaffTypes(actNone, theData);
end;

procedure TfrmMain._StaffAuthorizationList;
begin
  showmessage('Comming soon')
end;


// #######################  Telephone  ######################################


// g.OpenPhoneLog then
// g.OpenphoneDevices
// g.OpenPriceRules
// g.OpenPhonePrices

procedure TfrmMain._PhonePrices;
var
  theData: recPhoneRateHolder;
begin
  theData.id := 0;
  if PhoneRate(actNone, theData) then
  begin
  end
  else
  begin
  end;
end;


// #######################  Room Price  ######################################

procedure TfrmMain._PriceCodes;
var
  theData: recPriceCodeHolder;
  act: TActTableAction;
begin
  initPriceCodeHolder(theData);
  priceCodes(actNone, theData);
end;

procedure TfrmMain._Seasons;
var
  theData: recSeasonHolder;
begin
  openSeasons(actNone, theData);
end;

// ################################  Help  ###################################

procedure TfrmMain._About;
begin
  ShowRoomerAboutBox;
end;

procedure TfrmMain._HelpContent;
var
  aUrl: string;
begin
  aUrl := { 1090 } 'http:\\www.roomerpms.com';
  try
    ShellExecute(self.WindowHandle, 'open', PChar(aUrl), nil, nil, SW_SHOWNORMAL);
  except
    on E: Exception do
    begin
      showmessage(E.ClassName + { 1091 } ' ' + GetTranslatedText('sh1091') + ' : ' + E.message);
    end;
  end;
end;

procedure TfrmMain._RemodeHelp;
var
  aProgram: string;
begin
  aProgram := ExtractFilePath(Paramstr(0)) + 'fjartenging.exe';

  if FileExists(aProgram) then
  begin
    try
      CreateProcessSimple(aProgram);
    except
      on E: Exception do
      begin
        showmessage(E.ClassName + { 1091 } ' ' + GetTranslatedText('sh1091') + ' : ' + E.message);
      end;
    end;
  end
  else
  begin
    showmessage( { 1092a } GetTranslatedText('sh1092a') + ' "' + aProgram +
      { 1092b } '"' + ' - ' + GetTranslatedText('sh1092b') + ' ');
  end;

end;

procedure TfrmMain._OldRpt;
var
  aProgram: string;
begin
  aProgram := ExtractFilePath(Paramstr(0)) + 'rpt.exe';

  if FileExists(aProgram) then
  begin
    try
      CreateProcessSimple(aProgram);
    except
      on E: Exception do
      begin
        showmessage(E.ClassName + { +1091 } ' ' + GetTranslatedText('sh1091') + ' : ' + E.message);
      end;
    end;
  end
  else
  begin
    showmessage( { 1092a } GetTranslatedText('sh1092a') + ' "' + aProgram +
      { 1092b } '" - ' + GetTranslatedText('sh1092b') + ' ');
  end;

end;

procedure TfrmMain._HotelList;
begin
end;


// ############################ SYSTEM #######################################

procedure TfrmMain._Settings;
var
  tmpNights: integer;
begin
  tmpNights := g.qPeriodColCount;

  Application.CreateForm(TfrmControlData, frmControlData);
  try
    frmControlData.grid5DayFont.name := grPeriodRooms.Font.name;
    frmControlData.grid5DayFont.size := grPeriodRooms.Font.size;

    frmControlData.gridFont.name := grOneDayRooms.Font.name;
    frmControlData.gridFont.size := grOneDayRooms.Font.size;

    frmControlData.ShowModal;

    if frmControlData.ModalResult = mrOK then
    begin
      SaveGridFont(frmControlData.gridFont, frmControlData.grid5DayFont);
      d.ctrlGetGlobalValues;
      d.chkInPosMonitor;
      d.chkConfirmMonitor;
      grPeriodRooms.DefaultColWidth := g.qPeriodColWidth;
      grPeriodRooms.DefaultRowHeight := getRowHeightFromIndex(cbxViewTypes.ItemIndex);
      Period_RestoreColumnSize;
      Period_RestoreRowHeights;

      grOneDayRooms.DefaultRowHeight := g.qOneDayRowHeight;

      if tmpNights <> g.qPeriodColCount then
      begin
      end;

      zDoRefresh := false;
      cbxNameOrder.ItemIndex := g.qNameOrder;

      zDoRefreshPeriod := false;
      cbxNameOrderPeriod.ItemIndex := g.qNameOrderPeriod;

      zDebug1 := '310';
      RefreshGrid;
      oldDock1.Visible := g.qShowSideBar;

      Period_Init;
      Period_GetRooms;
    end;
  finally
    frmControlData.Free;
  end;
end;

procedure TfrmMain._Language;
var
  langName: string;
  langExt: string;
  langId: integer;

  iSaved1, iSaved2, iSaved3: integer;
begin
  langName := '';
  langExt := '';
  langId := g.qUserLanguage;

  iSaved1 := -1;
  iSaved2 := -1;
  iSaved3 := -1;
  g.openSelectLanguage(langName, langExt, langId);
  try
    iSaved1 := cbxNameOrderPeriod.ItemIndex;
    iSaved2 := cbxNameOrder.ItemIndex;
    iSaved3 := __dxBarCombo1.ItemIndex;
    if g.ChangeLang(langId, true) then
    begin
      RoomerLanguage.SetLanguageId(g.qUserLanguage, g.qUser + '.' + inttostr(g.qUserLanguage) + '.' + DateTimeToStr(now));
      TranslateOpenForms;
    end;
  finally
    cbxNameOrderPeriod.ItemIndex := iSaved1;
    cbxNameOrder.ItemIndex := iSaved2;
    __dxBarCombo1.ItemIndex := iSaved3;

    cbxNameOrderPeriod.Text := cbxNameOrderPeriod.Items[iSaved1];
    cbxNameOrder.Text := cbxNameOrder.Items[iSaved2];
    __dxBarCombo1.Text := __dxBarCombo1.Items[iSaved3];

  end;
end;


// ############################################################################

procedure TfrmMain._VariblesList;
var
  theData: recConvertHolder;
begin
  OpenConverts(actNone, theData);
end;

procedure TfrmMain._VariblesGroupList;
var
  theData: recConvertGroupHolder;
begin
  OpenConvertGroups(actNone, theData);
end;

procedure TfrmMain._MaidJobScripts;
begin
  Application.CreateForm(TfrmMaidActions, frmMaidActions);
  try
    if frmMaidActions.ShowModal = mrOK then
    begin
    end;
  finally
    frmMaidActions.Free;
  end;
end;

procedure TfrmMain._RoomRates;
var
  theData: recwRoomRateHolder;
begin
  if RoomRates(actNone, theData) then
  begin
  end;
end;

procedure TfrmMain._Rates;
var
  theData: recRateHolder;
begin
  if Rates(actNone, theData) then
  begin
  end;
end;

procedure TfrmMain._HideCaptons;
begin
end;

/// ///////////////////////////////////////////////////////////////////////////
procedure TfrmMain.btnJumpToRoomAndDateClick(Sender: TObject);
var
  aRoom: string;
  aDate: Tdate;
begin
  UserClickedDxLargeButton(Sender);
  aRoom := '';
  aDate := Date - 1;
  if g.openGoToRoomAndDate(aRoom, aDate) then
  begin
    if aRoom <> '' then
    begin
      SetViews(1);
      SetDateWithoutEvents(aDate);
      StartOneDay;
      OneDay_DoAJump(aRoom);
    end;
  end
  else
  begin
  end;
end;

procedure TfrmMain.CreateQuickReservation(isQuick: boolean; showDetails: boolean = true; Blocked: boolean = false);
var
  CustomerInfo: recCustomerHolderEX;
  doShowProfile: boolean;
  Daysleft: integer;
  missingReason: integer;
  resMedhod: TResMedhod;
  priceFound: boolean;
  iReservation: integer;
  oNewReservation: TNewReservation;

  confEmailSent: boolean;

  s: string;
  i: integer;

  function OpenQuickDetails(var oNewReservation: TNewReservation): boolean;
  begin
    result := false;
    frmMakeReservationQuick := TfrmMakeReservationQuick.Create(frmMakeReservationQuick);
    try
      frmMakeReservationQuick.oNewReservation := oNewReservation;
      frmMakeReservationQuick.ShowModal;

      if frmMakeReservationQuick.ModalResult = mrOK then
      begin
        oNewReservation := frmMakeReservationQuick.oNewReservation;
        result := true;
      end
      else
      begin
      end;
    finally
      frmMakeReservationQuick.Free;
      frmMakeReservationQuick := nil;
    end;
  end;

begin
  confEmailSent := false;
  try
    oNewReservation := TNewReservation.Create(g.qHotelCode, g.qUser);
  Except
    // ATH Log exception
  end;

  try
    priceFound := true;
    if isQuick then
    begin
      if ViewMode = vmOneDay then
      begin
        QuickResOneDayRoomObj(oNewReservation);
      end
      else
      begin
        QuickResPeriodRoomObj(oNewReservation);
      end;

      if oNewReservation.newRoomReservations.RoomCount = 0 then
      begin
        exit;
      end;
    end
    else
    begin
      if ViewMode = vmOneDay then
      begin
        resDateFrom := zDateFrom;
      end
      else
      begin
        Period_GetNewResDates(resDateFrom);
      end;
      resDateTo := zDateFrom + 1;
    end;

    oNewReservation.resMedhod := rmNormal;
    oNewReservation.isQuick := isQuick;
    if showDetails then
    begin
      if not OpenQuickDetails(oNewReservation) then
      begin
        RoomerMessageDialog(GetTranslatedText('shTx_Main_ReservationCancelled'), mtConfirmation, [mbOk], 'MainFormReservationCancelledMessage', mrOK);
        // showmessage(GetTranslatedText('shTx_Main_ReservationCancelled'));
        exit;
      end;
    end;

    Screen.Cursor := crHourglass;
    try
      // frmdayNotes.memLog.Clear;
      // frmdayNotes.memLog.Lines.Add('---'+Caption+'-----');
      // frmdayNotes.memLog.Lines.Add('');
      oNewReservation.CreateReservation;
      if oNewReservation.SendConfirmationEmail then
      begin
        if SendNewReservationConfirmation(oNewReservation.Reservation) then
          // d.roomerMainDataSet.SendConfirmationEmailOpenAPI(oNewReservation.Reservation);
          confEmailSent := true;
      end;

    finally
      Screen.Cursor := crDefault;
    end;

    if confEmailSent then
      MessageDlg(GetTranslatedText('shTxConfirmationEmailHasBeenSent'), mtConfirmation, [mbOk], 0);

    iReservation := oNewReservation.Reservation;
    if iReservation > 0 then
    begin
      if oNewReservation.ShowProfile then
      begin
        EditReservation(iReservation, 0)
      end
      else
      begin
        RefreshGrid;
      end;
    end;

  finally
    if oNewReservation <> nil then
      freeandNil(oNewReservation);
  end;
end;

procedure TfrmMain.QuickReservation1Click(Sender: TObject);
begin
  CreateQuickReservation(true);
end;

function TfrmMain.QuickResOneDayRoomObj(var oNewReservation: TNewReservation): integer;
var
  iRow, iCol: integer;
  sDepartureCell: string;
  isSelected: boolean;

  aRoom: string;
  Arrival: Tdate;
  Departure: Tdate;

  oSelectedRoomItem: TnewRoomReservationItem;
begin
  result := 0;

  Arrival := zDateFrom;
  Departure := zDateFrom + 1;

  for iRow := 1 to grOneDayRooms.RowCount - 1 do
  begin
    // Get selected rooms from left col
    isSelected := false;
    for iCol := 0 to 5 do
    begin
      if grOneDayRooms.SelectedCells[iCol, iRow] then
        isSelected := true;
    end;

    if isSelected then
    begin
      sDepartureCell := trim(grOneDayRooms.cells[4, iRow]);
      if (sDepartureCell = '') or (strToDate(sDepartureCell) = zOneDay_dtDate) then
      begin
        aRoom := grOneDayRooms.cells[0, iRow];
        // oSelectedRoomItem := TSelectedRoomItem.Create(aRoom,Arrival,departure,0);
        oSelectedRoomItem := TnewRoomReservationItem.Create(0, aRoom, '', '', Arrival, Departure, 0, 0, 0, true, 0, 0, 0, '', '', '');
        oNewReservation.newRoomReservations.RoomItemsList.Add(oSelectedRoomItem);
      end
    end;

    // Get selected rooms from left col
    isSelected := false;
    for iCol := 7 to 12 do
    begin
      if grOneDayRooms.SelectedCells[iCol, iRow] then
        isSelected := true;
    end;

    if isSelected then
    begin
      sDepartureCell := trim(grOneDayRooms.cells[11, iRow]);
      if (sDepartureCell = '') or (strToDate(sDepartureCell) = zOneDay_dtDate) then
      begin
        aRoom := grOneDayRooms.cells[7, iRow];
        // oSelectedRoomItem := TSelectedRoomItem.Create(aRoom,Arrival,departure,0);
        oSelectedRoomItem := TnewRoomReservationItem.Create(0, aRoom, '', '', Arrival, Departure, 0, 0, 0, true, 0, 0, 0, '', '', '');
        oNewReservation.newRoomReservations.RoomItemsList.Add(oSelectedRoomItem);
      end;
    end;
  end;
end;

function TfrmMain.QuickResPeriodRoomObj(var oNewReservation: TNewReservation): integer;
var
  iRow: integer;
  iCol: integer;
  ok: boolean;

  sCellContent: string;

  aRoom: string;
  Arrival: Tdate;
  Departure: Tdate;

  RoomNext: string;
  dtDateFromNext: Tdate;
  dtDateToNext: Tdate;

  oSelectedRoomItem: TnewRoomReservationItem;
begin
  result := 0;
  d.mQuickRes.SortedField := 'Room;DateFrom';
  if d.mQuickRes.active then
    d.mQuickRes.Close;
  d.mQuickRes.Open;

  for iRow := 1 to grPeriodRooms.RowCount - 1 do
  begin
    for iCol := 1 to grPeriodRooms.ColCount - 1 do
    begin
      sCellContent := trim(grPeriodRooms.cells[iCol, iRow]);
      if sCellContent = '' then
      begin
        if grPeriodRooms.SelectedCells[iCol, iRow] then
        begin
          aRoom := grPeriodRooms.cells[1, iRow];
          Arrival := Period_ColToDate(iCol);
          Departure := Arrival + 1;

          d.mQuickRes.append;
          d.mQuickRes.FieldByName('room').asString := aRoom;
          d.mQuickRes.FieldByName('dateFrom').AsDateTime := Arrival;
          d.mQuickRes.FieldByName('dateTo').AsDateTime := Departure;
          d.mQuickRes.Post;
        end;
      end;
    end;
  end;

  d.mQuickRes.first;
  while not d.mQuickRes.eof do
  begin
    aRoom := d.mQuickRes.FieldByName('Room').asString;
    Arrival := d.mQuickRes.FieldByName('DateFrom').AsDateTime;
    Departure := d.mQuickRes.FieldByName('DateTo').AsDateTime;
    if not d.mQuickRes.eof then
    begin
      d.mQuickRes.next;
      RoomNext := d.mQuickRes.FieldByName('Room').asString;
      dtDateFromNext := d.mQuickRes.FieldByName('DateFrom').AsDateTime;
      dtDateToNext := d.mQuickRes.FieldByName('DateTo').AsDateTime;

      if (dtDateFromNext = Departure) and (aRoom = RoomNext) then
      begin
        d.mQuickRes.Prior;
        d.mQuickRes.edit;
        d.mQuickRes.FieldByName('DateTo').AsDateTime := dtDateToNext;
        d.mQuickRes.Post;

        d.mQuickRes.next;
        d.mQuickRes.Delete;
        d.mQuickRes.first;
      end;
    end
    else
      d.mQuickRes.next;
  end;

  d.mQuickRes.first;
  while not d.mQuickRes.eof do
  begin
    aRoom := d.mQuickRes.FieldByName('Room').asString;
    Arrival := d.mQuickRes.FieldByName('DateFrom').AsDateTime;
    Departure := d.mQuickRes.FieldByName('DateTo').AsDateTime;
    // oSelectedRoomItem := TSelectedRoomItem.Create(aRoom,Arrival,departure,0);
    oSelectedRoomItem := TnewRoomReservationItem.Create(0, aRoom, '', '', Arrival, Departure, 0, 0, 0, true, 0, 0, 0, '', '', '');
    oNewReservation.newRoomReservations.RoomItemsList.Add(oSelectedRoomItem);
    d.mQuickRes.next;
  end;

end;

procedure TfrmMain.btnGroupsReportClick(Sender: TObject);
begin
  refreshGuestList;
  GuestListReport;
end;

procedure TfrmMain.btnCurrentGuestsReportClick(Sender: TObject);
begin
  showmessage( { 1096 } 'Ekki tilbúið');
end;

procedure TfrmMain.__dxBarCombo1CloseUp(Sender: TObject);
begin
  PostMessage(handle, WM_REFRESH_SKIN_MANAGER, 0, 0);
end;

procedure TfrmMain.HandleSkinManagerChange;
var
  skin: String;
begin
  DebugLog('Starting __dxBarCombo1CloseUp');
  sSkinManager1.active := false;
  try
    DebugLog('Selecting Skin __dxBarCombo1CloseUp');
    skin := __dxBarCombo1.Items[__dxBarCombo1.CurItemIndex];
    DebugLog('Selected Skin __dxBarCombo1CloseUp - ' + skin);
    sSkinManager1.skinName := DelChars(skin, '&');
    DebugLog('Assigned Skin __dxBarCombo1CloseUp - ' + sSkinManager1.skinName);
  finally
    DebugLog('Activating Skinmanager __dxBarCombo1CloseUp');
    sSkinManager1.active := true;
    DebugLog('Skinmanager activated __dxBarCombo1CloseUp');
  end;
  DebugLog('Loaded __dxBarCombo1CloseUp');
  sSkinManager1.Loaded;
  DebugLog('Loaded done __dxBarCombo1CloseUp');
  SetExtraSkinColors;
  DebugLog('Ending __dxBarCombo1CloseUp');
end;

procedure TfrmMain.dxBarLargeButton2Click(Sender: TObject);
begin
end;

/// /////////////////////////////////////////////////////////////////////////////
///
/// Guest List Tab
///
/// ///////////////////////////////////////////////////////////////////////////

var
  zRoomReservationCount: integer;
  zReservationCount: integer;
  zRoomReservationList: string;

function TfrmMain.getSortField: string;
var
  i: integer;
  AColumn: TcxGridDBColumn;
  aName: string;
  s: string;
begin
  //
  s := '';
  for i := 0 to tvAllReservations.ColumnCount - 1 do
  begin
    AColumn := tvAllReservations.Columns[i];
    aName := AColumn.DataBinding.FieldName;
    s := aName;
    if AColumn.SortOrder = soNone then
    begin
    end
    else if AColumn.SortOrder = soAscending then
    begin
      s := s + ';a';
      result := s;
      exit;
    end
    else if AColumn.SortOrder = soDescending then
    begin
      s := s + ';d';
      result := s;
      exit;
    end;
  end;
end;

function TfrmMain.getRoomReservationsListSubQuery(aType: integer): string;
begin
  result := '';
  case aType of
    0:
      begin
        result := Format(GetListOfRoomReservationsPerArrivalDate, [_dateToDBDate(dtDate.Date, true), _dateToDBDate(dtDate.Date, true)]);
      end;
    1:
      begin
        result := Format(GetListOfRoomReservationsPerDepartureDate, [_dateToDBDate(dtDate.Date, true), _dateToDBDate(dtDate.Date, true)]);
      end;
    2:
      begin
        result := Format(GetListOfRoomReservationsFromToDate, [_dateToDBDate(dtDate.Date, true), _dateToDBDate(dtDate.Date, true)]);
      end;
  else
    begin
      exit;
    end;
  end;

end;

function TfrmMain.getRoomReservationsList(aType: integer; includeNoshow, includeAllotment, includeBlocked: boolean): string;
var
  s: string;
  rrList: TStringList;
  i: integer;
begin
  result := '';
  case aType of
    0:
      begin
        rrList := d.GuestListRRlst_Arrival(dtDate.Date, dtDate.Date, includeNoshow, includeAllotment, includeBlocked);
      end;
    1:
      begin
        rrList := d.GuestListRRlst_Departure(dtDate.Date, dtDate.Date, includeNoshow, includeAllotment, includeBlocked);
      end;
    2:
      begin
        rrList := d.GuestListRRlst_FromTo(dtDate.Date, dtDate.Date, includeNoshow, includeAllotment, includeBlocked)
      end;
  else
    begin
      exit;
    end;
  end;

  try
    s := '';
    for i := 0 to rrList.Count - 1 do
    begin
      s := s + rrList[i] + ',';
    end;
    if length(s) > 0 then
    begin
      Delete(s, length(s), 1);
      s := '(' + s + ')';
      result := s;
    end;
    zRoomReservationCount := rrList.Count;
  finally
    freeandNil(rrList);
  end;
  result := s;
end;

procedure TfrmMain.refreshGuestList;
var
  rSet: TRoomerDataSet;
  rCount: integer;
  s: string;
  aType: integer;
  // Fields
  RoomReservation: integer;
  Reservation: integer;
  ReservationName: string;
  ArrivalDate: Tdate;
  DepartureDate: Tdate;
  Room: string;
  RoomType: string;
  status: string;
  Breakfast: boolean;
  noRoom: boolean;
  RoomDescription: string;
  Bookable: boolean;
  hidden: boolean;
  Location: string;
  Floor: integer;
  Equipments: string;
  LocationDescription: string;
  GroupAccount: boolean;
  marketSegment: string;
  marketSegmentDescription: string;
  Email: string;
  Website: string;
  customer: string;
  CustomerName: string;
  PersonalID: string;

  // calc Fields
  Statustext: string;
  ResInfo: string;
  RoomCount: integer;
  RvGuestCount: integer;
  RRGuestCount: integer;
  resId: integer;
  mainGuests: string;
  GroupReservation: integer;
  GroupReservationName: string;

  Currency: String;
  AverageRate, TotalRate: Double;
  numDays, Adults, Children, Infants: integer;

  ResLine: string;
  rv: integer;
  Information, PMInfo: string;

  breakfastguests: integer;

  SubSql: String;

begin

  if ViewMode = vmGuestList then
    try
      aType := rgrGroupreportStayType.ItemIndex;
      zRoomReservationList := getRoomReservationsListSubQuery(aType);

      if zRoomReservationList = '' then
      begin
        if mAllReservations.active then
          mAllReservations.Close;
        mAllReservations.Open;
        exit;
      end;
      s := '';
      if mAllReservations.active then
        mAllReservations.Close;
      mAllReservations.Open;
      resId := 0;

      rSet := CreateNewDataSet;
      try
        Screen.Cursor := crHourglass;
        mAllReservations.DisableControls;
        try
          s := select_Main_refreshGuestList;
          SubSql := Format('(%s)', [zRoomReservationList]);
          s := Format(s, [SubSql]);

          uUtils.CopyToClipboard(s);
          // DebugMessage(s);

          hData.rSet_bySQL(rSet, s);

          rv := -1;

          rSet.first;
          while not rSet.eof do
          begin
            mAllReservations.append;
            RoomReservation := rSet.FieldByName('RoomReservation').asinteger;
            Reservation := rSet.FieldByName('Reservation').asinteger;
            ReservationName := rSet.FieldByName('ReservationName').asString;
            ArrivalDate := rSet.FieldByName('ArrivalDate').AsDateTime;
            DepartureDate := rSet.FieldByName('DepartureDate').AsDateTime;
            Room := rSet.FieldByName('Room').asString;
            RoomType := rSet.FieldByName('RoomType').asString;
            status := rSet.FieldByName('Status').asString;
            Breakfast := rSet['Breakfast'];
            noRoom := rSet['NoRoom'];
            RoomDescription := rSet.FieldByName('RoomDescription').asString;
            Bookable := rSet['Bookable'];
            hidden := rSet['hidden'];
            Location := rSet.FieldByName('Location').asString;
            Floor := rSet.FieldByName('Floor').asinteger;
            Equipments := rSet.FieldByName('Equipments').asString;
            LocationDescription := rSet.FieldByName('LocationDescription').asString;
            GroupAccount := rSet['GroupAccount'];
            marketSegment := rSet.FieldByName('marketSegment').asString;
            marketSegmentDescription := rSet.FieldByName('marketSegmentDescription').asString;
            Email := rSet.FieldByName('Email').asString;
            Website := rSet.FieldByName('Website').asString;
            customer := rSet.FieldByName('Customer').asString;
            CustomerName := rSet.FieldByName('CustomerName').asString;
            PersonalID := rSet.FieldByName('PersonalID').asString;
            Statustext := rSet.FieldByName('Statustext').asString;
            RoomCount := rSet.FieldByName('RoomCount').asinteger;
            RvGuestCount := rSet.FieldByName('RvGuestCount').asinteger;
            RRGuestCount := rSet.FieldByName('RRGuestCount').asinteger;
            mainGuests := rSet.FieldByName('MainGuests').asString;
            ResLine := mainGuests + ' / ' + ReservationName;

            Currency := rSet.FieldByName('Currency').asString;
            AverageRate := rSet.GetFloatValue(rSet.FieldByName('AverageRate'));
            numDays := rSet.FieldByName('NumDays').asinteger;
            TotalRate := numDays * AverageRate;
            Adults := rSet.FieldByName('NumGuests').asinteger;
            Children := rSet.FieldByName('NumChildren').asinteger;
            Infants := rSet.FieldByName('NumInfants').asinteger;

            breakfastguests := 0;
            if Breakfast then
            begin
              breakfastguests := RRGuestCount;
            end;

            if RoomCount < 2 then
            begin
              GroupReservation := 0;
              GroupReservationName := 'One Room Reservations';
              ResInfo := inttostr(GroupReservation) + ' | ' + GroupReservationName;
            end
            else
            begin
              GroupReservation := Reservation;
              GroupReservationName := ReservationName;
              ResInfo := inttostr(GroupReservation) + ' | ' + GroupReservationName + ' (' + inttostr(RvGuestCount) + ' guests in ' + inttostr(RoomCount) +
                ' rooms)';
            end;

            mAllReservations.FieldByName('RoomReservation').asinteger := RoomReservation;
            mAllReservations.FieldByName('Reservation').asinteger := Reservation;
            mAllReservations.FieldByName('ReservationName').asString := ReservationName;
            mAllReservations.FieldByName('ArrivalDate').AsDateTime := ArrivalDate;
            mAllReservations.FieldByName('DepartureDate').AsDateTime := DepartureDate;
            mAllReservations.FieldByName('Room').asString := Room;
            mAllReservations.FieldByName('RoomType').asString := RoomType;
            mAllReservations.FieldByName('Status').asString := status;
            mAllReservations['Breakfast'] := Breakfast;
            mAllReservations['NoRoom'] := noRoom;
            mAllReservations.FieldByName('RoomDescription').asString := RoomDescription;
            mAllReservations['Bookable'] := Bookable;
            mAllReservations['hidden'] := hidden;
            mAllReservations.FieldByName('Location').asString := Location;
            mAllReservations.FieldByName('Floor').asinteger := Floor;
            mAllReservations.FieldByName('Equipments').asString := Equipments;
            mAllReservations.FieldByName('LocationDescription').asString := LocationDescription;
            mAllReservations['GroupAccount'] := GroupAccount;
            mAllReservations.FieldByName('marketSegment').asString := marketSegment;
            mAllReservations.FieldByName('marketSegmentDescription').asString := marketSegmentDescription;
            mAllReservations.FieldByName('Email').asString := Email;
            mAllReservations.FieldByName('Website').asString := Website;
            mAllReservations.FieldByName('Customer').asString := customer;
            mAllReservations.FieldByName('CustomerName').asString := CustomerName;
            mAllReservations.FieldByName('PersonalID').asString := PersonalID;
            mAllReservations.FieldByName('Statustext').asString := Statustext;
            mAllReservations.FieldByName('ResInfo').asString := ResInfo;
            mAllReservations.FieldByName('RoomCount').asinteger := RoomCount;
            mAllReservations.FieldByName('RvGuestCount').asinteger := RvGuestCount;
            mAllReservations.FieldByName('RRGuestCount').asinteger := RRGuestCount;
            mAllReservations.FieldByName('MainGuests').asString := Copy(mainGuests, 1, 100);
            mAllReservations.FieldByName('ResLine').asString := Copy(ResLine, 1, 100);
            mAllReservations.FieldByName('GroupReservation').asinteger := GroupReservation;
            mAllReservations.FieldByName('GroupReservationName').asString := GroupReservationName;
            mAllReservations.FieldByName('BreakfastGuests').asinteger := breakfastguests;

            mAllReservations.FieldByName('Currency').asString := Currency;
            mAllReservations.FieldByName('AverageRate').AsFloat := AverageRate;
            mAllReservations.FieldByName('Nights').asinteger := numDays;
            mAllReservations.FieldByName('TotalStayRate').AsFloat := TotalRate;
            mAllReservations.FieldByName('Adults').asinteger := Adults;
            mAllReservations.FieldByName('Children').asinteger := Children;
            mAllReservations.FieldByName('Infants').asinteger := Infants;

            mAllReservations.Post;
            rSet.next;
          end;

          mAllReservations.first;
          rCount := rSet.RecordCount;
        finally
          Screen.Cursor := crDefault;
          mAllReservations.EnableControls;
          // mAllReservations.SortFields := 'GroupReservation:D;customer;room';
          // mAllReservations.Sort([]);
          tvAllReservations.DataController.Groups.FullExpand;
        end;
      finally
        freeandNil(rSet);
      end;
      if ViewMode = vmGuestList then
        gAllReservations.SetFocus;
    finally
      timGetRoomStatuses.Tag := trunc(dtDate.Date);
      timGetRoomStatuses.Enabled := true;
    end;
end;

procedure TfrmMain.rgrGroupReportDateTypeClick(Sender: TObject);
begin
  refreshGuestList;
  zGuestListFirstTime := false;
end;

procedure TfrmMain.rgrGroupreportStayTypeChanging(Sender: TObject; NewIndex: integer; var AllowChange: boolean);
begin
  // AllowChange := True;
  // btnRefreshOneDay.Click;
end;

procedure TfrmMain.rgrGroupreportStayTypeClick(Sender: TObject);
begin
  refreshGuestList;
  zGuestListFirstTime := false;
end;

procedure TfrmMain.rgrTypePropertiesEditValueChanged(Sender: TObject);
begin
  if ViewMode <> vmGuestList then
    exit;

  if not zGuestListFirstTime then
  begin
    refreshGuestList;
  end;
end;

procedure TfrmMain.rgrUsePropertiesEditValueChanged(Sender: TObject);
begin
  if ViewMode <> vmGuestList then
    exit;

  if not zGuestListFirstTime then
  begin
    refreshGuestList;
  end;
end;

procedure TfrmMain.btnGroupreportCollapseAllClick(Sender: TObject);
begin
  tvAllReservations.DataController.Groups.FullCollapse;
end;

procedure TfrmMain.btnGroupReportExpandAllClick(Sender: TObject);
begin
  tvAllReservations.DataController.Groups.FullExpand;
end;

procedure TfrmMain.btnGuestListExcelClick(Sender: TObject);
var
  sFilename: string;
  s: string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_Groups';
  ExportGridToExcel(sFilename, gAllReservations, true, true, true);
  ShellExecute(handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmMain.btnGuestProfilesClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  GuestProfiles(actNone);
end;

procedure TfrmMain.btnGuestsClick(Sender: TObject);
begin
  UserClickedDxLargeButton(Sender);
  rptGuests;
end;

procedure TfrmMain.GuestListReport;
var
  aReport: TppReport;
  sFilter: string;
  s: string;
  sortField: string;
  isDescending: boolean;
begin
  rptbGroups.Groups[0].NewPage := chkNewPage.Checked;

  if mAllReservations.RecordCount = 0 then
    exit;

  sFilter := tvAllReservations.DataController.Filter.FilterText;
  if m.active then
    m.Close;
  m.LoadFromDataSet(tvAllReservations.DataController.DataSource.DataSet, [mtcpoStructure]);

  m.Filtered := false;

  if sFilter <> '' then
  begin
    m.Filter := sFilter;
    m.Filtered := true;
    m.first;
  end;

  s := getSortField;

  sortField := 'Room';
  isDescending := false;

  if s <> '' then
  begin
    sortField := _strTokenAT(s, ';', 0);
    isDescending := (_strTokenAT(s, ';', 1) = 'd');
  end;

  m.SortFields := sortField;
  if not isDescending then
  begin
    m.Sort([]);
  end
  else
  begin
    m.Sort([mtcoDescending]);
  end;

  (*
    if m.Active then m.Close;
    m.LoadFromDataSet(tvAllReservations.DataController.DataSource.DataSet,[mtcpoStructure]);
    //  [mtcpoStructure]

    mAllReservations.SortFields := 'GroupReservation:D;customer;room';
    mAllReservations.Sort([]);
  *)

  if frmRptbViewer <> nil then
    freeandNil(frmRptbViewer);
  frmRptbViewer := TfrmRptbViewer.Create(frmRptbViewer);
  frmRptbViewer.Show;

  Screen.Cursor := crHourglass;
  try
    aReport := rptbGroups;
    frmRptbViewer.ppViewer1.Reset;
    frmRptbViewer.ppViewer1.Report := aReport;
    frmRptbViewer.ppViewer1.GotoPage(1);
    aReport.PrintToDevices;
  finally
    Screen.Cursor := crDefault;
  end;

end;

procedure TfrmMain.HTMLHint1ShowHint(var HintStr: string; var CanShow: boolean; var HintInfo: THintInfo);
begin
  if ShowComponentNameOnHint then
    HintStr := Format('<b>%s</b><br><br>', [HintInfo.HintControl.name]) + HintStr;
  CanShow := true;
end;

procedure TfrmMain.ShowTimelyMessage(sMessage: string);
begin
  pnlTimeMessage.Hide;
  timHideTimeMessage.Enabled := false;

  pnlTimeMessage.Top := 0;
  pnlTimeMessage.Left := 0;
  pnlTimeMessage.Width := panMain.Width;

  lblTimeMessage.Top := 8;
  lblTimeMessage.Caption := sMessage;
  pnlTimeMessage.Show;
  timHideTimeMessage.Interval := 3000;
  timHideTimeMessage.Enabled := true;
end;

procedure TfrmMain.pnlNoRoomButtonsMouseEnter(Sender: TObject);
begin
  ApplicationCancelHint;
  iLastHintRow := 0;
  iLastHintCol := 0;
  iLastPeriodHintRow := 0;
  iLastPeriodHintCol := 0;
end;

procedure TfrmMain.btnGroupReportShowClick(Sender: TObject);
begin
  GuestListReport;
end;

procedure TfrmMain.ppGroupHeaderBand1BeforePrint(Sender: TObject);
var
  Reservation: integer;
  Information, PMInfo: string;
begin
  if chkPrintMemo.Checked then
  begin
    Reservation := m.FieldByName('reservation').asinteger;
    d.RV_getMemos(Reservation, Information, PMInfo);
    mem.Text := Information;
  end;
end;

procedure TfrmMain.ppHeaderBand1BeforePrint(Sender: TObject);
var
  s: string;
begin
  dateTimeToString(s, 'dd.mm.yyyy', dtDate.Date);
  rlabFrom.Caption := s;

  s := g.qHotelName;
  rLabHotelName.Caption := s;

  dateTimeToString(s, 'dd mmm yyyy hh:nn', now);

  s := { 1098 } GetTranslatedText('shCreated') + ' : ' + s;
  rLabTimeCreated.Caption := s;

  s := { 1099 } GetTranslatedText('shUser') + ' : ' + g.qUser;
  if g.qUserName <> '' then
    s := s + ' - ' + g.qUserName;
  rlabUser.Caption := s;

  s := { 2000 } GetTranslatedText('shGroups') + ' ';

  case rgrGroupreportStayType.ItemIndex of
    0:
      s := { 2002 } GetTranslatedText('shArriving') + ' ' + s;
    1:
      s := { 2001 } GetTranslatedText('shDeparting') + ' ' + s;
    2:
      s := { 2003 } GetTranslatedText('shAll') + ' ' + s;
  end;

  rLabReportName.Caption := s;
end;

procedure TfrmMain.DownloadProgress(Sender: TObject; Read, Total: integer);
var
  Value: Extended;
begin
  if lblBusyDownloading.Color <> sSkinManager1.GetHighLightColor(true) then
  begin
    lblBusyDownloading.Color := sSkinManager1.GetHighLightColor(true);
    lblBusyDownloading.Font.Color := sSkinManager1.GetHighLightFontColor(true);
  end
  else
  begin
    lblBusyDownloading.Color := sSkinManager1.GetGlobalColor;
    lblBusyDownloading.Font.Color := sSkinManager1.GetGlobalFontColor;
  end;
  lblBusyDownloading.Update;
  // if sProgressBar1.Max <> Total then
  // sProgressBar1.Max := Total;
  // sProgressBar1.Position := Read;
  // sProgressBar1.Update;
  // value := 100 * (Read / Total);
  // lblDownloaded.Caption := FormatFloat('0.00',value) + '% of ' + FormatByteSize(Total);
  // Application.ProcessMessages;
end;

procedure TfrmMain.CopyReservation(reservationId: integer);
begin
  ClipboardCopy(Format(ROOMER_COPY_RESERVATION_ID, [d.roomerMainDataSet.hotelId, reservationId]));
  ShowTimelyMessage(Format(GetTranslatedText('shTx_FrmMain_CopiedReservationToClipboard'), [reservationId]));
end;

procedure TfrmMain.CopyRoomReservation(roomReservationId: integer);
begin
  ClipboardCopy(Format(ROOMER_COPY_ROOMRESERVATION_ID, [d.roomerMainDataSet.hotelId, roomReservationId]));
  ShowTimelyMessage(Format(GetTranslatedText('shTx_FrmMain_CopiedRoomReservationToClipboard'), [roomReservationId]));
end;


{$IFDEF USE_JCL}

initialization

JclStackTrackingOptions := JclStackTrackingOptions + [stExceptFrame];
// , stAllModules, stTraceAllExceptions, stMainThreadOnly ];
JclStartExceptionTracking;
{$ENDIF}
{ TRoomClassChannelAvailabilityContainer }

constructor TRoomClassChannelAvailabilityContainer.Create(_RoomTypeGroup: String; _NumRooms, _Reserved, _ChannelAvailable, _ChannelMaxAvailable,
  _GridIndex: integer; _AnyStop: boolean);
begin
  RoomTypeGroup := _RoomTypeGroup;
  NumRooms := _NumRooms;
  Reserved := _Reserved;
  ChannelAvailable := _ChannelAvailable;
  ChannelMaxAvailable := _ChannelMaxAvailable;
  GridIndex := _GridIndex;
  AnyStop := _AnyStop;
end;

{ TRoomAvailabilityEntity }

constructor TRoomAvailabilityEntity.Create(Room, RoomType, RoomClass: String);
begin
  FRoom := Room;
  FRoomType := RoomType;
  FRoomClass := RoomClass;
end;

destructor TRoomAvailabilityEntity.Destroy;
begin
  inherited;
end;

end.
