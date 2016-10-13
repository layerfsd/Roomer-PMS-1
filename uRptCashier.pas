unit uRptCashier;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls,
  Vcl.Mask, Vcl.ExtCtrls, shellapi, System.Generics.Collections, math, Vcl.ComCtrls, Vcl.Grids

    , kbmMemTable, cmpRoomerDataSet, cmpRoomerConnection

    , _glob, ug, hData, uUtils, uAppGlobal, clisted

  // TMS Grid
    , AdvObj, BaseGrid, AdvGrid

    , sEdit, sPageControl, sStatusBar, sCheckBox, sLabel, sMaskEdit, sCustomComboEdit, sTooledit, sButton, sComboBox, sGroupBox, sPanel

  // Report
    , ppCtrls, ppPrnabl, ppClass, ppVar, ppBands, ppCache, ppDB, ppDesignLayer, ppDBPipe, ppDBBDE, ppParameter, ppComm, ppRelatv, ppProd, ppReport

    , cxGridExportLink, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, cxDBData, cxCalc, cxCurrencyEdit, cxPropertiesStore, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridBandedTableView,
  cxGridDBBandedTableView, cxClasses, cxGridCustomView, cxGridDBTableView, cxGrid, dxmdaset

    , dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, ppStrtch, ppSubRpt, Vcl.Menus, cxButtons, cxExtEditRepositoryItems, cxEditRepositoryItems,
  AdvUtil;

type
  TPaymentTotal = class
    Num: Integer;
    Code: String;
    Description: String;
    Total: Double;
  public
    constructor Create(_Code, _Description: String; _Amount: Double);
    procedure Add(_Amount: Double);
  end;

  TPaymentTotalDictionary = TObjectDictionary<String, TPaymentTotal>;

  TfrmRptCashier = class(TForm)
    Panel3: TsPanel;
    btnRefresh: TsButton;
    gbxSelectDates: TsGroupBox;
    dtDateFrom: TsDateEdit;
    sStatusBar1: TsStatusBar;
    pageMain: TsPageControl;
    tabStatGrid: TsTabSheet;
    sPanel1: TsPanel;
    btnGuestsExcel: TsButton;
    sButton1: TsButton;
    FormStore: TcxPropertiesStore;
    grReport: TAdvStringGrid;
    dlgSave: TFileSaveDialog;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    cbxStaff: TCheckListEdit;
    btnClearStaff: TsButton;
    btnCheckAllStaff: TsButton;
    sTabSheet1: TsTabSheet;
    _kbmGet: TkbmMemTable;
    kbmGetDS: TDataSource;
    tvGet: TcxGridDBTableView;
    lvGet: TcxGridLevel;
    grGet: TcxGrid;
    Panel5: TsPanel;
    rptbCashier: TppReport;
    ppParameterList1: TppParameterList;
    ppCashier: TppBDEPipeline;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppLabelReportname: TppLabel;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppDBText1: TppDBText;
    ppLabStaff: TppLabel;
    ppDBText2: TppDBText;
    ppLabtxDate: TppLabel;
    pplabName: TppLabel;
    pplabDescription: TppLabel;
    tvGetLineType: TcxGridDBColumn;
    tvGetTypeIndex: TcxGridDBColumn;
    tvGetStaff: TcxGridDBColumn;
    tvGetName: TcxGridDBColumn;
    tvGetLineIndex: TcxGridDBColumn;
    tvGetInvoiceNumber: TcxGridDBColumn;
    tvGettxDate: TcxGridDBColumn;
    tvGetCreated: TcxGridDBColumn;
    tvGetroom: TcxGridDBColumn;
    tvGetproduct: TcxGridDBColumn;
    tvGetproductdescription: TcxGridDBColumn;
    tvGetnumberofitems: TcxGridDBColumn;
    tvGetnativeTotalPrice: TcxGridDBColumn;
    btnExcel: TsButton;
    ppLabNativeTotalPrice: TppLabel;
    ppDBText8: TppDBText;
    tvGetLineTypeInt: TcxGridDBColumn;
    pplabType: TppLabel;
    pplabnumberofitems: TppLabel;
    ppDBText5: TppDBText;
    ppDBText10: TppDBText;
    ppDBText6: TppDBText;
    ppSystemVariable2: TppSystemVariable;
    tvGetDescription: TcxGridDBColumn;
    tvGetNameCol: TcxGridDBColumn;
    tvGetDescriptionCol: TcxGridDBColumn;
    tvGetTypeCol: TcxGridDBColumn;
    tvGetReservation: TcxGridDBColumn;
    tvGetRoomReservation: TcxGridDBColumn;
    ppDBCalc1: TppDBCalc;
    ppDBCalc2: TppDBCalc;
    ppLine1: TppLine;
    ppLine2: TppLine;
    ppLine3: TppLine;
    ppSystemVariable3: TppSystemVariable;
    ppDBCalc4: TppDBCalc;
    rLabHotelName: TppLabel;
    rlabUser: TppLabel;
    sButton6: TsButton;
    sButton23: TsButton;
    chkGroup: TsCheckBox;
    gbxTotals: TsGroupBox;
    lblTotalsale: TsLabel;
    __Totalsale: TsLabel;
    lblTotalPayments: TsLabel;
    __TotalPayments: TsLabel;
    lblBalance: TsLabel;
    __Balance: TsLabel;
    tvGetCategory: TcxGridDBColumn;
    btnExpand: TsButton;
    btnCollapse: TsButton;
    ppLabel1: TppLabel;
    ppDBText3: TppDBText;
    ppDBCalc5: TppDBCalc;
    ppDBCalc6: TppDBCalc;
    _kbmPayments: TkbmMemTable;
    kbmPaymentsDS: TDataSource;
    sTabSheet2: TsTabSheet;
    sPanel2: TsPanel;
    sButton3: TsButton;
    grPayments: TcxGrid;
    tvPayments: TcxGridDBTableView;
    lvPayments: TcxGridLevel;
    btnPaymentReport: TsButton;
    tvPaymentsType: TcxGridDBColumn;
    tvPaymentsDescription: TcxGridDBColumn;
    tvPaymentsAmount: TcxGridDBColumn;
    ppPayments: TppBDEPipeline;
    ppSummaryBand1: TppSummaryBand;
    ppSubReport1: TppSubReport;
    ppChildReport1: TppChildReport;
    ppDesignLayers2: TppDesignLayers;
    ppDesignLayer2: TppDesignLayer;
    ppTitleBand1: TppTitleBand;
    ppDetailBand2: TppDetailBand;
    ppSummaryBand2: TppSummaryBand;
    ppLabel2: TppLabel;
    ppDBText9: TppDBText;
    ppLabel3: TppLabel;
    ppDBText11: TppDBText;
    ppLabel4: TppLabel;
    ppDBText12: TppDBText;
    ppLabel5: TppLabel;
    ppDBCalc7: TppDBCalc;
    ppLine4: TppLine;
    ppLine5: TppLine;
    ppLine6: TppLine;
    ppLabTotalBalance: TppLabel;
    ppLine7: TppLine;
    ppLine8: TppLine;
    ppLabBalance: TppLabel;
    btnBack: TcxButton;
    btnForward: TcxButton;
    kbmReportDS: TDataSource;
    ppLabel6: TppLabel;
    erGrid: TcxEditRepository;
    erGridTextItem1: TcxEditRepositoryTextItem;
    sLabel3: TsLabel;
    cbxShifts: TsComboBox;
    cbxByUsers: TsCheckBox;
    rlabUsers: TppLabel;
    ppLine9: TppLine;
    ppLabtxRoom: TppLabel;
    ppLabel8: TppLabel;
    LabTxArrival: TppLabel;
    LabGuestName: TppLabel;
    ppDBText4: TppDBText;
    LabTxResId: TppLabel;
    ppLabel7: TppLabel;
    LabTxDeparture: TppLabel;
    ppLabel10: TppLabel;
    LabTxInvoice: TppLabel;
    ppLabel9: TppLabel;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    LabTxItem: TppLabel;
    LabTxReservation: TppLabel;
    _kbmReport: TkbmMemTable;
    kbmReport: TdxMemData;
    kbmReportLineType: TWideStringField;
    kbmPayments: TdxMemData;
    kbmGet: TdxMemData;
    WideStringField1: TWideStringField;
    IntegerField1: TIntegerField;
    WideStringField2: TWideStringField;
    WideStringField3: TWideStringField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    DateField1: TDateField;
    DateTimeField1: TDateTimeField;
    StringField1: TStringField;
    WideStringField4: TWideStringField;
    WideStringField5: TWideStringField;
    WideStringField6: TWideStringField;
    IntegerField4: TIntegerField;
    FloatField1: TFloatField;
    WideStringField7: TWideStringField;
    WideStringField8: TWideStringField;
    WideStringField9: TWideStringField;
    IntegerField5: TIntegerField;
    IntegerField6: TIntegerField;
    IntegerField7: TIntegerField;
    WideStringField10: TWideStringField;
    WideStringField11: TWideStringField;
    WideStringField12: TWideStringField;
    WideStringField13: TWideStringField;
    WideStringField14: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnGuestsExcelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grReportGetAlignment(Sender: TObject; ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure grReportGetCellColor(Sender: TObject; ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure sButton1Click(Sender: TObject);
    procedure btnClearStaffClick(Sender: TObject);
    procedure btnCheckAllStaffClick(Sender: TObject);
    procedure btnPaymentReportClick(Sender: TObject);
    procedure ppHeaderBand1BeforePrint(Sender: TObject);
    procedure ppGroupHeaderBand1BeforePrint(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure tvGetnativeTotalPriceGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure sButton23Click(Sender: TObject);
    procedure chkGroupClick(Sender: TObject);
    procedure btnExpandClick(Sender: TObject);
    procedure btnCollapseClick(Sender: TObject);
    procedure sButton6Click(Sender: TObject);
    procedure dtDateFromCloseUp(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure ppSummaryBand1BeforePrint(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnForwardClick(Sender: TObject);
    procedure ppDetailBand1BeforeGenerate(Sender: TObject);
    procedure ppLabel6Print(Sender: TObject);
    procedure tvGetCreatedGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure cbxShiftsChange(Sender: TObject);
    procedure cbxStaffChange(Sender: TObject);
    procedure cbxStaffClickCheck(Sender: TObject);
    procedure cbxByUsersClick(Sender: TObject);
    procedure ppLabel8Print(Sender: TObject);
    procedure ppLabel7Print(Sender: TObject);
    procedure ppLabel10Print(Sender: TObject);
    procedure ppLabel9Print(Sender: TObject);
    procedure ppLabel11Print(Sender: TObject);
    procedure LabTxItemPrint(Sender: TObject);
    procedure LabTxReservationPrint(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }

    bookingDataSet: TRoomerDataset;

    zTotalSale: Double;
    zTotalInvoicePayments: Double;
    zTotalDownPayments: Double;
    zTotalPayments: Double;
    zBalance: Double;

    procedure ShowData;
    procedure FillUsers;
    procedure Refresh;
    procedure SelectCurrentUser;
    function GetUserSqlList: String;
    procedure EnableDisableButtons;
    procedure SetReportVisiblitity(MakeVisible: boolean);
    procedure UserSelectVisible(MakeVisible: boolean);
    function GetUserAsNormalList: String;
    function AllUsersSelected: boolean;
    procedure SelectActiveUsers;
  public
    { Public declarations }
  end;

function RptCashier: boolean;

var
  frmRptCashier: TfrmRptCashier;

implementation

{$R *.dfm}

uses
  uD, uRoomerLanguage, uDimages, uDateUtils, uFrmResources, PrjConst, uGridUtils, uRptbViewer, uReservationProfile, uFinishedInvoices2, uInvoice
    ;

CONST
  FINANCE_QUERY = 'SELECT ' + #10
  + 'LineType, ' + #10
  + 'LineTypeInt, ' + #10
  + 'TypeIndex, ' + #10
  + 'Staff, ' + #10
  + 'name, ' + #10
  + 'IF(ISNULL(guestname), ' + #10
  + '   IF((roomreservation = 0) AND (Reservation > 0), (SELECT text FROM home100.dictionary where languageid=1 and extraidentity=''shUI_Reports_MultipleRooms'' LIMIT 1), '    + #10
  + '       IF((roomreservation = 0) AND (Reservation = 0), (SELECT text FROM home100.dictionary where languageid=1 and extraidentity=''shUI_Reports_CashInvoice'' LIMIT 1), '''') '    + #10
  + '      ), GuestName ' + #10
  + '	) AS guestname, ' + #10
  + 'Reservation, ' + #10
  + 'RoomReservation, ' + #10
  + 'LineIndex, ' + #10
  + 'InvoiceNumber, ' + #10
  + 'TxDate, ' + #10
  + 'dtCreated AS Created, ' + #10
  + 'Room, ' + #10
  + 'BookingId, ' + #10
  + 'Arrival, ' + #10
  + 'Departure, ' + #10
  + 'Product, ' + #10
  + 'ProductDescription, ' + #10
  + 'NumberOfItems, ' + #10
  + 'Description, ' + #10
  + 'NativeTotalPrice ' + #10
  + 'FROM ' + #10
  + '( ' +  #10
  + 'SELECT * FROM ' + #10
  + '( ' + #10
  + '   SELECT "SALEITEMS" AS LineType, ' + #10
  + '          2 AS LineTypeInt, ' + #10
  + '          0 AS TypeIndex, ' + #10
  + '          ih.Staff, ' + #10
  + '          ih.Name AS name, ' + #10
  + '          (SELECT Name FROM persons WHERE (RoomReservation=IF(il.RoomReservationAlias>0,il.RoomReservationAlias,il.RoomReservation) OR (il.RoomReservation=0 AND Reservation=il.Reservation)) AND MainName=1 LIMIT 1) AS GuestName, ' + #10
  + '          ih.Reservation, ' + #10
  + '          ih.roomReservation, ' + #10
  + '          ItemNumber AS LineIndex, ' + #10
  + '          il.InvoiceNumber AS InvoiceNumber, ' + #10
  + '          DATE(PurchaseDate) AS TxDate, ' + #10
  + '          (SELECT dtCreated FROM payments WHERE InvoiceNumber=ih.InvoiceNumber ORDER BY dtCreated DESC LIMIT 1) AS dtCreated, ' + #10
  + '          IF(ISNULL((SELECT Room FROM roomreservations WHERE (RoomReservation=IF(il.RoomReservationAlias>0,il.RoomReservationAlias,il.RoomReservation) OR (il.RoomReservation=0 AND Reservation=il.Reservation)) LIMIT 1)), "", ' + #10
  + '          (SELECT Room FROM roomreservations WHERE (RoomReservation=IF(il.RoomReservationAlias>0,il.RoomReservationAlias,il.RoomReservation) OR (il.RoomReservation=0 AND Reservation=il.Reservation)) LIMIT 1)) AS Room, '    + #10
  + '          IF(ISNULL((SELECT InvRefrence FROM reservations WHERE Reservation=il.Reservation LIMIT 1)), "", (SELECT InvRefrence FROM reservations WHERE Reservation=il.Reservation LIMIT 1)) AS BookingId, '    + #10
  + '          IF(ISNULL((SELECT Arrival FROM roomreservations WHERE (RoomReservation=IF(il.RoomReservationAlias>0,il.RoomReservationAlias,il.RoomReservation) OR (il.RoomReservation=0 AND Reservation=il.Reservation)) LIMIT 1)), "", '+ #10
  + '             (SELECT Arrival FROM roomreservations WHERE (RoomReservation=IF(il.RoomReservationAlias>0,il.RoomReservationAlias,il.RoomReservation) OR (il.RoomReservation=0 AND Reservation=il.Reservation)) LIMIT 1)) AS Arrival, '    + #10
  + '          IF(ISNULL((SELECT Departure FROM roomreservations WHERE (RoomReservation=IF(il.RoomReservationAlias>0,il.RoomReservationAlias,il.RoomReservation) OR (il.RoomReservation=0 AND Reservation=il.Reservation)) LIMIT 1)), "", '+ #10
  + '             (SELECT Departure FROM roomreservations WHERE (RoomReservation=IF(il.RoomReservationAlias>0,il.RoomReservationAlias,il.RoomReservation) OR (il.RoomReservation=0 AND Reservation=il.Reservation)) LIMIT 1)) AS Departure, ' + #10
  + '          il.ItemId AS Product, ' + #10
  + '          il.Description AS ProductDescription, ' + #10
  + '          il.Number AS NumberOfItems, ' + #10
  + '          CONCAT((SELECT text FROM home100.dictionary WHERE LanguageID=1 AND extraIdentity=IF(ih.SplitNumber=1, ''shUI_CreditInvoiceCaption'' ,''shUI_InvoiceCaption'') LIMIT 1), '' '', ih.InvoiceNumber) AS  Description, ' + #10
  + '          (il.Total + il.revenueCorrection) AS NativeTotalPrice ' + #10
  + '   FROM invoicelines il ' + #10
  + '        INNER JOIN invoiceheads ih ON ih.InvoiceNumber=il.InvoiceNumber AND ih.InvoiceNumber>0 AND InvoiceDate={date} AND staff IN ({staff}) ' + #10
  + '        INNER JOIN items i ON Item=il.ItemId ' + #10
  + '        INNER JOIN itemtypes it ON it.ItemType=i.ItemType ' + #10
  + '        INNER JOIN vatcodes vc ON vc.VatCode=it.VatCode, ' + #10
  + '        control c ' + #10
  + '        INNER JOIN currencies cu ON cu.Currency=(SELECT NativeCurrency FROM control LIMIT 1) ' + #10
  + 'UNION ALL ' + #10
  + '   SELECT "PAYMENT" AS LineType, ' + #10
  + '          0 AS LineTypeInt, ' + #10
  + '          TypeIndex, ' + #10
  + '          il.Staff, ' + #10
  + '          (SELECT Name FROM invoiceheads WHERE Reservation=il.Reservation AND RoomReservation=il.RoomReservation AND InvoiceNumber=il.InvoiceNumber LIMIT 1) AS Name, ' + #10
  + '          (SELECT Name FROM persons WHERE RoomReservation=il.RoomReservation AND MainName=1 LIMIT 1) AS GuestName, ' + #10
  + '          Reservation, ' + #10 + '          roomReservation, ' + #10 + '          il.ID AS LineIndex, ' + #10
  + '          il.InvoiceNumber AS InvoiceNumber, ' + #10 + '          il.dtCreated AS TxDate, ' + #10 + '          il.dtCreated AS dtCreated, ' + #10
  + '          IF(ISNULL((SELECT Room FROM roomreservations WHERE RoomReservation=il.RoomReservation LIMIT 1)), "", '+ #10
  + '             (SELECT Room FROM roomreservations WHERE RoomReservation=il.RoomReservation LIMIT 1)) AS Room, ' + #10
  + '          IF(ISNULL((SELECT InvRefrence FROM reservations WHERE Reservation=il.Reservation LIMIT 1)), "", (SELECT InvRefrence FROM reservations WHERE Reservation=il.Reservation LIMIT 1)) AS BookingId, ' + #10
  + '          IF(ISNULL((SELECT Arrival FROM roomreservations WHERE RoomReservation=il.RoomReservation LIMIT 1)), "", (SELECT Arrival FROM roomreservations WHERE RoomReservation=il.RoomReservation LIMIT 1)) AS Arrival, ' + #10
  + '          IF(ISNULL((SELECT Departure FROM roomreservations WHERE RoomReservation=il.RoomReservation LIMIT 1)), "", (SELECT Departure FROM roomreservations WHERE RoomReservation=il.RoomReservation LIMIT 1)) AS Departure, ' + #10
  + '          il.PayType AS Product, ' + #10
  + '          pt.Description AS ProductDescription, ' + #10
  + '          1 AS NumberOfItems, ' + #10
  + '          il.Description, ' + #10
  + '          Amount AS PricePerItem ' + #10
  + '   FROM payments il ' + #10
  + '        INNER JOIN paytypes pt ON pt.PayType = il.PayType, ' + #10
  + '        control c ' + #10
  + '        INNER JOIN currencies cu ON cu.Currency=(SELECT NativeCurrency FROM control LIMIT 1) ' + #10
  + '   WHERE TypeIndex = 0 AND PayDate={date} AND staff IN ({staff}) ' + #10
  + 'UNION ALL ' + #10
  + '   SELECT "DOWNPAYMENT" AS LineType, ' + #10
  + '          1 AS LineTypeInt, ' + #10
  + '          TypeIndex, ' + #10
  + '          il.Staff, ' + #10
  + '          (SELECT Name FROM invoiceheads WHERE Reservation=il.Reservation AND RoomReservation=il.RoomReservation AND InvoiceNumber=il.InvoiceNumber LIMIT 1) AS Name, ' + #10
  + '          (SELECT Name FROM persons WHERE RoomReservation=il.RoomReservation AND MainName=1 LIMIT 1) AS GuestName, ' + #10
  + '          Reservation, ' + #10
  + '          roomReservation, ' + #10
  + '          il.ID AS LineIndex, ' + #10
  + '          il.InvoiceNumber AS InvoiceNumber, ' + #10
  + '          il.dtCreated AS TxDate, ' + #10
  + '          il.dtCreated AS dtCreated, ' + #10
  + '          IF(ISNULL((SELECT Room FROM roomreservations WHERE RoomReservation=il.RoomReservation LIMIT 1)), "", (SELECT Room FROM roomreservations WHERE RoomReservation=il.RoomReservation LIMIT 1)) AS Room, ' + #10
  + '          IF(ISNULL((SELECT InvRefrence FROM reservations WHERE Reservation=il.Reservation LIMIT 1)), "", (SELECT InvRefrence FROM reservations WHERE Reservation=il.Reservation LIMIT 1)) AS BookingId, ' + #10
  + '          IF(ISNULL((SELECT Arrival FROM roomreservations WHERE RoomReservation=il.RoomReservation LIMIT 1)), "", (SELECT Arrival FROM roomreservations WHERE RoomReservation=il.RoomReservation LIMIT 1)) AS Arrival, '  + #10
  + '          IF(ISNULL((SELECT Departure FROM roomreservations WHERE RoomReservation=il.RoomReservation LIMIT 1)), "", (SELECT Departure FROM roomreservations WHERE RoomReservation=il.RoomReservation LIMIT 1)) AS Departure, ' + #10
  + '          il.PayType AS Product, ' + #10
  + '          pt.Description AS ProductDescription, ' + #10
  + '          1 AS NumberOfItems, ' + #10
  + '          il.Description, ' + #10
  + '          Amount AS PricePerItem ' + #10
  + '   FROM payments il ' + #10
  + '        INNER JOIN paytypes pt ON pt.PayType = il.PayType, ' + #10
  + '        control c ' + #10
  + '        INNER JOIN currencies cu ON cu.Currency=(SELECT NativeCurrency FROM control LIMIT 1) ' + #10
  + '   WHERE TypeIndex = 1 AND PayDate={date} AND staff IN ({staff}) ' + #10
  + ') InvoiceInfo ' + #10
  + ') aaa ' + #10
  + 'ORDER BY LineType, InvoiceNumber, TxDate, LineIndex ' + #10;

  // CONST FINANCE_QUERY = 'SELECT ' + #10 +
  // 'LineType, ' + #10 +
  // 'LineTypeInt, ' + #10 +
  // 'TypeIndex, ' + #10 +
  // 'Staff, ' + #10 +
  // 'name, ' + #10 +
  // 'Reservation, ' + #10 +
  // 'RoomReservation, ' + #10 +
  // 'LineIndex, ' + #10 +
  // 'InvoiceNumber, ' + #10 +
  // 'TxDate, ' + #10 +
  // 'dtCreated AS Created, ' + #10 +
  // 'Room, ' + #10 +
  // 'Product, ' + #10 +
  // 'ProductDescription, ' + #10 +
  // 'NumberOfItems, ' + #10 +
  // 'Description, ' + #10 +
  // 'NativeTotalPrice ' + #10 +
  // 'FROM ' + #10 +
  // '( ' + #10 +
  // 'SELECT * FROM ' + #10 +
  // '( ' + #10 +
  //
  // '   SELECT "SALEITEMS" AS LineType, ' + #10 +
  // '          3 AS LineTypeInt, ' + #10 +
  // '          0 AS TypeIndex, ' + #10 +
  // '          ih.Staff, ' + #10 +
  // '          ih.Name AS name, ' + #10 +
  // '          ih.Reservation, ' + #10 +
  // '          ih.roomReservation, ' + #10 +
  // '          ItemNumber AS LineIndex, ' + #10 +
  // '          il.InvoiceNumber AS InvoiceNumber, ' + #10 +
  // '          DATE(PurchaseDate) AS TxDate, ' + #10 +
  // '          (SELECT dtCreated FROM payments WHERE InvoiceNumber=ih.InvoiceNumber ORDER BY dtCreated DESC LIMIT 1) AS dtCreated, ' + #10 +
  // '          IF(ISNULL((SELECT Room FROM roomreservations WHERE RoomReservation=IF(il.RoomReservationAlias>0,il.RoomReservationAlias,il.RoomReservation))), "", (SELECT Room FROM roomreservations WHERE RoomReservation=IF(il.RoomReservationAlias>0,il.RoomReservationAlias,il.RoomReservation))) AS Room, ' + #10 +
  // '          ItemId AS Product, ' + #10 +
  // '          il.Description AS ProductDescription, ' + #10 +
  // '          Number AS NumberOfItems, ' + #10 +
  // '          CONCAT((SELECT text FROM home100.dictionary WHERE LanguageID=1 AND extraIdentity=IF(ih.SplitNumber=1, ''shUI_CreditInvoiceCaption'' ,''shUI_InvoiceCaption'') LIMIT 1), '' '', ih.InvoiceNumber) AS  Description, ' + #10 +
  // '          SUM(il.Total) AS NativeTotalPrice ' + #10 +
  // '   FROM invoicelines il ' + #10 +
  // '        INNER JOIN invoiceheads ih ON ih.InvoiceNumber=il.InvoiceNumber AND ih.InvoiceNumber>0 AND InvoiceDate={date} AND staff IN ({staff}) ' + #10 +
  // '        INNER JOIN items i ON Item=il.ItemId ' + #10 +
  // '        INNER JOIN itemtypes it ON it.ItemType=i.ItemType ' + #10 +
  // '        INNER JOIN vatcodes vc ON vc.VatCode=it.VatCode, ' + #10 +
  // '        control c ' + #10 +
  // '        INNER JOIN currencies cu ON cu.Currency=(SELECT NativeCurrency FROM control LIMIT 1) ' + #10 +
  // 'GROUP BY il.ItemId ' + #10 +
  // 'UNION ALL' + #10 +
  //
  // '   SELECT "SALE" AS LineType, ' + #10 +
  // '          0 AS LineTypeInt, ' + #10 +
  // '          0 AS TypeIndex, ' + #10 +
  // '          ih.Staff, ' + #10 +
  // '          ih.Name AS name, ' + #10 +
  // '          ih.Reservation, ' + #10 +
  // '          ih.roomReservation, ' + #10 +
  // '          ItemNumber AS LineIndex, ' + #10 +
  // '          il.InvoiceNumber AS InvoiceNumber, ' + #10 +
  // '          DATE(PurchaseDate) AS TxDate, ' + #10 +
  // '          (SELECT dtCreated FROM payments WHERE InvoiceNumber=ih.InvoiceNumber ORDER BY dtCreated DESC LIMIT 1) AS dtCreated, ' + #10 +
  // '          IF(ISNULL((SELECT Room FROM roomreservations WHERE RoomReservation=IF(il.RoomReservationAlias>0,il.RoomReservationAlias,il.RoomReservation))), "", (SELECT Room FROM roomreservations WHERE RoomReservation=IF(il.RoomReservationAlias>0,il.RoomReservationAlias,il.RoomReservation))) AS Room, ' + #10 +
  // '          ItemId AS Product, ' + #10 +
  // '          (SELECT Surname FROM customers WHERE Customer=ih.customer LIMIT 1) AS ProductDescription, ' + #10 +
  // '          Number AS NumberOfItems, ' + #10 +
  // '          CONCAT((SELECT text FROM home100.dictionary WHERE LanguageID={langId} AND extraIdentity=IF(ih.SplitNumber=1, ''shUI_CreditInvoiceCaption'' ,''shUI_InvoiceCaption'') LIMIT 1), '' '', ih.InvoiceNumber) AS  Description, ' + #10 +
  //
  // '          SUM(il.Total) AS NativeTotalPrice ' + #10 +
  //
  // '   FROM invoicelines il ' + #10 +
  // '        INNER JOIN invoiceheads ih ON ih.InvoiceNumber=il.InvoiceNumber AND ih.InvoiceNumber>0 AND InvoiceDate={date} AND staff IN ({staff}) ' + #10 +
  // '        INNER JOIN items i ON Item=il.ItemId ' + #10 +
  // '        INNER JOIN itemtypes it ON it.ItemType=i.ItemType ' + #10 +
  // '        INNER JOIN vatcodes vc ON vc.VatCode=it.VatCode, ' + #10 +
  // '        control c ' + #10 +
  // '        INNER JOIN currencies cu ON cu.Currency=(SELECT NativeCurrency FROM control LIMIT 1) ' + #10 +
  //
  // 'GROUP BY InvoiceNumber ' + #10 +
  //
  // 'UNION ALL ' + #10 +
  //
  // '   SELECT "PAYMENT" AS LineType, ' + #10 +
  // '          1 AS LineTypeInt, ' + #10 +
  // '          TypeIndex, ' + #10 +
  // '          il.Staff, ' + #10 +
  // '          (SELECT Name FROM invoiceheads WHERE Reservation=il.Reservation AND RoomReservation=il.RoomReservation AND InvoiceNumber=il.InvoiceNumber) AS Name, ' + #10 +
  // '          -1 AS Reservation, ' + #10 +
  // '          -1 AS roomReservation, ' + #10 +
  // '          il.ID AS LineIndex, ' + #10 +
  // '          il.InvoiceNumber AS InvoiceNumber, ' + #10 +
  // '          il.dtCreated AS TxDate, ' + #10 +
  // '          il.dtCreated AS dtCreated, ' + #10 +
  // '          IF(ISNULL((SELECT Room FROM roomreservations WHERE RoomReservation=IF(il.RoomReservationAlias>0,il.RoomReservationAlias,il.RoomReservation))), "", (SELECT Room FROM roomreservations WHERE RoomReservation=IF(il.RoomReservationAlias>0,il.RoomReservationAlias,il.RoomReservation))) AS Room, ' + #10 +
  // '          il.PayType AS Product, ' + #10 +
  // '          pt.Description AS ProductDescription, ' + #10 +
  // '          1 AS NumberOfItems, ' + #10 +
  // '          il.Description, ' + #10 +
  //
  // '          SUM(Amount) AS PricePerItem ' + #10 +
  //
  // '   FROM payments il ' + #10 +
  // '        INNER JOIN paytypes pt ON pt.PayType = il.PayType, ' + #10 +
  // '        control c ' + #10 +
  // '        INNER JOIN currencies cu ON cu.Currency=(SELECT NativeCurrency FROM control LIMIT 1) ' + #10 +
  // '   WHERE TypeIndex = 0 AND PayDate={date} AND staff IN ({staff}) ' + #10 +
  // '   GROUP BY TypeIndex, Product ' + #10 +
  //
  // 'UNION ALL ' + #10 +
  //
  // '   SELECT "DOWNPAYMENT" AS LineType, ' + #10 +
  // '          2 AS LineTypeInt, ' + #10 +
  // '          TypeIndex, ' + #10 +
  // '          il.Staff, ' + #10 +
  // '          (SELECT Name FROM invoiceheads WHERE Reservation=il.Reservation AND RoomReservation=il.RoomReservation AND InvoiceNumber=il.InvoiceNumber) AS Name, ' + #10 +
  // '          -1 AS Reservation, ' + #10 +
  // '          -1 AS roomReservation, ' + #10 +
  // '          il.ID AS LineIndex, ' + #10 +
  // '          il.InvoiceNumber AS InvoiceNumber, ' + #10 +
  // '          il.dtCreated AS TxDate, ' + #10 +
  // '          il.dtCreated AS dtCreated, ' + #10 +
  // '          IF(ISNULL((SELECT Room FROM roomreservations WHERE RoomReservation=IF(il.RoomReservationAlias>0,il.RoomReservationAlias,il.RoomReservation))), "", (SELECT Room FROM roomreservations WHERE RoomReservation=IF(il.RoomReservationAlias>0,il.RoomReservationAlias,il.RoomReservation))) AS Room, ' + #10 +
  // '          il.PayType AS Product, ' + #10 +
  // '          pt.Description AS ProductDescription, ' + #10 +
  // '          1 AS NumberOfItems, ' + #10 +
  // '          il.Description, ' + #10 +
  //
  // '          SUM(Amount) AS PricePerItem ' + #10 +
  //
  // '   FROM payments il ' + #10 +
  // '        INNER JOIN paytypes pt ON pt.PayType = il.PayType, ' + #10 +
  // '        control c ' + #10 +
  // '        INNER JOIN currencies cu ON cu.Currency=(SELECT NativeCurrency FROM control LIMIT 1) ' + #10 +
  // '   WHERE TypeIndex = 1 AND PayDate={date} AND staff IN ({staff}) ' + #10 +
  // '   GROUP BY TypeIndex, Product ' + #10 +
  //
  // ') InvoiceInfo ' + #10 +
  // ') aaa ' + #10 +
  // 'ORDER BY LineType, TypeIndex, InvoiceNumber, TxDate, LineIndex ' + #10 +
  // '';

function RptCashier: boolean;
begin
  result := false;
  frmRptCashier := TfrmRptCashier.Create(frmRptCashier);
  try
    frmRptCashier.ShowModal;
    if frmRptCashier.modalresult = mrOk then
    begin
      result := true;
    end
  finally
    freeandnil(frmRptCashier);
  end;
end;

function TfrmRptCashier.GetUserAsNormalList: String;
var
  i: Integer;
begin
  result := '';
  for i := 0 to cbxStaff.Items.Count - 1 do
    if cbxStaff.Checked[i] then
    begin
      if result = '' then
        result := cbxStaff.Items[i]
      else
        result := result + ',' + cbxStaff.Items[i];
    end;
end;

function TfrmRptCashier.AllUsersSelected: boolean;
var
  i: Integer;
begin
  result := true;
  for i := 1 to cbxStaff.Items.Count - 1 do
    if NOT cbxStaff.Checked[i] then
    begin
      result := false;
      Break;
    end;
end;

function TfrmRptCashier.GetUserSqlList: String;
var
  i: Integer;
begin
  result := '';
  for i := 0 to cbxStaff.Items.Count - 1 do
    if cbxStaff.Checked[i] then
    begin
      if result = '' then
        result := _db(cbxStaff.Items[i])
      else
        result := result + ',' + _db(cbxStaff.Items[i]);
    end;
end;

procedure TfrmRptCashier.ShowData;
var
  i: Integer;
begin
  dtDateFrom.Date := Date;
  FillUsers;
  cbxShifts.Items.Clear;
  if g.qNumberOfShifts > 0 then
     cbxShifts.Items.Add(GetTranslatedText('shUI_General_SELECT'));
  for i := 1 to g.qNumberOfShifts do
    cbxShifts.Items.Add(inttostr(i));

  cbxShifts.ItemIndex := 0;
  cbxShifts.Visible := g.qNumberOfShifts > 0;
  sLabel3.Visible := cbxShifts.Visible;
  // if GetUserSqlList <> '' then
  // Refresh;
end;

procedure TfrmRptCashier.tvGetCreatedGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
// var
// dtCreated : TdateTime;
// s : string;
begin
  // if kbmGet.eof then exit;
  // if arecord.Index >=0  then
  // begin
  // try
  // dtCreated  := Arecord.Values[tvGETCreated.index] ;
  // if dtCreated > 2 then
  // begin
  // AProperties :=  erIsDate.Properties;
  // end else
  // begin
  // AProperties :=  erNullDate.Properties
  // end;
  // except
  // end;
  // end;
end;

procedure TfrmRptCashier.tvGetnativeTotalPriceGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptCashier.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  bookingDataSet := CreateNewDataset;

  grReport.RowCount := 1;
  grReport.ColCount := 9;

  grReport.Cells[0, 0] := GetTranslatedText('shUI_Reports_Action');
  grReport.Cells[1, 0] := GetTranslatedText('shUI_Reports_Staff');
  grReport.Cells[2, 0] := GetTranslatedText('shUI_Reports_Invoice');
  grReport.Cells[3, 0] := GetTranslatedText('shUI_Reports_Date');
  grReport.Cells[4, 0] := GetTranslatedText('shUI_Reports_Room');
  grReport.Cells[5, 0] := GetTranslatedText('shUI_Reports_Name');
  grReport.Cells[6, 0] := GetTranslatedText('shUI_Reports_Description');
  grReport.Cells[7, 0] := GetTranslatedText('shUI_Reports_Total');
  grReport.Cells[8, 0] := GetTranslatedText('shUI_Reports_PaymentType');
end;

procedure TfrmRptCashier.FormShow(Sender: TObject);
begin
  // **
  _restoreForm(self);
  UserSelectVisible(false);
  ShowData;
end;

procedure TfrmRptCashier.FormDestroy(Sender: TObject);
begin
  freeandnil(bookingDataSet);
end;

procedure TfrmRptCashier.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmRptCashier.btnBackClick(Sender: TObject);
begin
  SetReportVisiblitity(false);
  dtDateFrom.Date := dtDateFrom.Date - 1;
  dtDateFromCloseUp(nil);
end;

procedure TfrmRptCashier.btnForwardClick(Sender: TObject);
begin
  SetReportVisiblitity(false);
  dtDateFrom.Date := dtDateFrom.Date + 1;
  dtDateFromCloseUp(nil);
end;

procedure TfrmRptCashier.btnCheckAllStaffClick(Sender: TObject);
var
  i: Integer;
begin
  SetReportVisiblitity(false);
  for i := 1 to cbxStaff.Items.Count - 1 do
    cbxStaff.Checked[i] := true;
  EnableDisableButtons;
end;

procedure TfrmRptCashier.btnClearStaffClick(Sender: TObject);
var
  i: Integer;
begin
  SetReportVisiblitity(false);
  for i := 1 to cbxStaff.Items.Count - 1 do
    cbxStaff.Checked[i] := false;
  EnableDisableButtons;
end;

procedure TfrmRptCashier.btnExcelClick(Sender: TObject);
var
  sFilename: string;
  s: string;
begin
  if kbmGet.RecordCount = 0 then
    Exit;

  datetimeTostring(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_cashierReport';
  ExportGridToExcel(sFilename, grGet, false, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;


procedure TfrmRptCashier.SelectActiveUsers;
var
  Data: TRoomerDataset;
  i: Integer;
begin
  btnClearStaffClick(nil);
  Data := CreateNewDataset;
  try
    if hData.rSet_bySQL(Data, format('SELECT DISTINCT staff ' + 'FROM ( ' + 'SELECT DISTINCT staff ' + 'FROM invoiceheads ' +
      'WHERE InvoiceNumber>0 AND InvoiceDate=%s ' + 'UNION ALL ' + 'SELECT DISTINCT staff ' + 'FROM payments ' + 'WHERE PayDate=%s) aaa ',
      [_db(DateToSqlString(dtDateFrom.Date)), _db(DateToSqlString(dtDateFrom.Date))])) then
    begin
      Data.First;
      while NOT Data.Eof do
      begin
        i := cbxStaff.Items.IndexOf(UpperCase(Data['Staff']));
        if i >= 0 then
          cbxStaff.Checked[i] := true;
        Data.Next;
      end;
    end;
  finally
    Data.Free;
  end;
end;

procedure TfrmRptCashier.SelectCurrentUser;
var
  i: Integer;
begin
  btnClearStaffClick(nil);

  i := cbxStaff.Items.IndexOf(UpperCase(d.roomerMainDataSet.username));
  if i >= 0 then
    cbxStaff.Checked[i] := true;
end;

procedure TfrmRptCashier.FillUsers;
var
  Data: TRoomerDataset;
begin
  cbxStaff.Items.Clear;
  Data := CreateNewDataset;
  try
    if hData.rSet_bySQL(Data, 'SELECT Initials FROM staffmembers') then
    begin
      Data.First;
      while NOT Data.Eof do
      begin
        cbxStaff.Items.Add(UpperCase(Data['Initials']));
        Data.Next;
      end;
    end;
  finally
    Data.Free;
  end;

  SelectCurrentUser;
end;

// ////////////////////////////////////////////////////////////
//
// Grid buttons
//
/// ///////////////////////////////////////////////////////////////

procedure TfrmRptCashier.btnGuestsExcelClick(Sender: TObject);
var
  sFilename: string;
  s: string;
begin
  datetimeTostring(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_BookKeepData' + '.xls';
  if SaveAsExcelFile(grReport, sFilename) then
    ShellExecute(Handle, 'OPEN', PChar(sFilename), nil, nil, sw_shownormal);
end;

procedure TfrmRptCashier.btnPaymentReportClick(Sender: TObject);
var
  aReport: TppReport;
  sortField: string;
begin

  kbmReport.Close;
  kbmReport.LoadFromDataSet(kbmGet);

  sortField := 'LineType';
  kbmReport.SortedField := sortField;

  if frmRptbViewer <> nil then
    freeandnil(frmRptbViewer);
  frmRptbViewer := TfrmRptbViewer.Create(nil);

  screen.Cursor := crHourglass;
  try
    aReport := rptbCashier;
    frmRptbViewer.Caption := GetTranslatedText('shUI_Reports_CashReport');
    frmRptbViewer.ppViewer1.Reset;
    frmRptbViewer.ppViewer1.Report := aReport;
    frmRptbViewer.ppViewer1.GotoPage(1);
    aReport.PrintToDevices;
  finally
    screen.Cursor := crDefault;
  end;

  frmRptbViewer.showModal;
end;

procedure TfrmRptCashier.sButton23Click(Sender: TObject);
var
  iReservation: Integer;
  iRoomReservation: Integer;
begin
  iReservation := kbmGet.FieldByName('Reservation').asinteger;
  iRoomReservation := kbmGet.FieldByName('roomReservation').asinteger;

  if iReservation < 1 then
    Exit;

  if EditReservation(iReservation, iRoomReservation) then
  begin
    // **
  end;
end;

procedure TfrmRptCashier.sButton3Click(Sender: TObject);
var
  sFilename: string;
  s: string;
begin
  if kbmPayments.RecordCount = 0 then
    Exit;

  datetimeTostring(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_cashierPaymentsReport';
  ExportGridToExcel(sFilename, grPayments, false, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmRptCashier.sButton6Click(Sender: TObject);
var
  invoicenumber: Integer;
  iRoomReservation: Integer;
  iReservation: Integer;
begin
  iReservation := kbmGet.FieldByName('Reservation').asinteger;
  iRoomReservation := kbmGet.FieldByName('RoomReservation').asinteger;

  if iReservation = -1 then
    Exit;

  invoicenumber := kbmGet.FieldByName('InvoiceNumber').asinteger;
  if invoicenumber > 0 then
  begin
    ViewInvoice2(invoicenumber, false, false, false, false, '');
  end
  else
  begin
    EditInvoice(iReservation, iRoomReservation, 0, 0, 0, 0, false, true, false);
  end;
end;

procedure TfrmRptCashier.btnExpandClick(Sender: TObject);
begin
  tvGet.DataController.Groups.FullExpand;
end;

procedure TfrmRptCashier.btnCollapseClick(Sender: TObject);
begin
  tvGet.DataController.Groups.FullCollapse;
end;

procedure TfrmRptCashier.cbxByUsersClick(Sender: TObject);
begin
  if cbxByUsers.Checked then
    SelectActiveUsers
  else
    SelectCurrentUser;
  UserSelectVisible(cbxByUsers.Checked);
end;

procedure TfrmRptCashier.cbxShiftsChange(Sender: TObject);
begin
  SetReportVisiblitity(false);
  EnableDisableButtons;
end;

procedure TfrmRptCashier.cbxStaffChange(Sender: TObject);
begin
  SetReportVisiblitity(false);
  EnableDisableButtons;
end;

procedure TfrmRptCashier.cbxStaffClickCheck(Sender: TObject);
begin
  SetReportVisiblitity(false);
  EnableDisableButtons;
end;

procedure TfrmRptCashier.chkGroupClick(Sender: TObject);
begin
  screen.Cursor := crHourglass;
  try
    btnCollapse.visible := chkGroup.Checked;
    btnExpand.visible := chkGroup.Checked;
    tvGetLineType.visible := not chkGroup.Checked;
    if chkGroup.Checked then
    begin
      tvGetCategory.GroupIndex := 1;
      tvGet.DataController.Groups.FullExpand;
    end
    else
    begin
      tvGetCategory.GroupIndex := -1;
    end;
  finally
    screen.Cursor := crDefault;
  end;
end;

procedure TfrmRptCashier.EnableDisableButtons;
begin
  btnRefresh.Enabled := (GetUserSqlList <> '') AND ((cbxShifts.Items.Count=0) OR (cbxShifts.ItemIndex > 0));
  btnPaymentReport.Enabled := btnRefresh.Enabled;
end;

procedure TfrmRptCashier.SetReportVisiblitity(MakeVisible: boolean);
begin
  pageMain.visible := MakeVisible;
  btnPaymentReport.visible := pageMain.visible;
  EnableDisableButtons;
end;

procedure TfrmRptCashier.dtDateFromCloseUp(Sender: TObject);
begin
  SetReportVisiblitity(false);
  EnableDisableButtons;
end;

/// /////////////////////////////////////////////////////////////////////////////
//
// Top Panel
//
/// ////////////////////////////////////////////////////////////////////////////////

procedure TfrmRptCashier.Refresh;
var
  Strings: TStrings;
  s: String;

  subTotalDebet, subTotalCredit, totalDebet: Double;

  lastLineType: String;
  lastNumber: Integer;
  totalNumber: Integer;

  payment: TPaymentTotalDictionary;
  item: TPaymentTotal;
  i: Integer;

  procedure SubTotal;
  begin
    grReport.RowCount := grReport.RowCount + 1;
    grReport.Cells[7, grReport.RowCount - 1] := '============';

    grReport.RowCount := grReport.RowCount + 1;
    grReport.Cells[6, grReport.RowCount - 1] := GetTranslatedText('shUI_BookKeepReortSubtotal');
    grReport.Cells[7, grReport.RowCount - 1] := trim(_floattostr(subTotalDebet, 12, 2));
    grReport.Cells[8, grReport.RowCount - 1] := '(' + inttostr(lastNumber) + ')';

    totalDebet := totalDebet + subTotalDebet;
    subTotalDebet := 0.00;
    grReport.RowCount := grReport.RowCount + 1;
    totalNumber := totalNumber + lastNumber;
  end;
  procedure Total;
  begin
    grReport.RowCount := grReport.RowCount + 1;
    grReport.Cells[7, grReport.RowCount - 1] := '============';

    grReport.RowCount := grReport.RowCount + 1;
    grReport.Cells[6, grReport.RowCount - 1] := GetTranslatedText('shUI_BookKeepReortTotal');
    grReport.Cells[7, grReport.RowCount - 1] := trim(_floattostr(totalDebet, 12, 2));
    grReport.Cells[8, grReport.RowCount - 1] := '(' + inttostr(totalNumber) + ')';
  end;

  procedure CollectPaymentTypes(Code, Description: String; Amount: Double);
  var
    item: TPaymentTotal;
  begin
    if payment.TryGetValue(Code, item) then
      item.Add(Amount)
    else
      payment.Add(Code, TPaymentTotal.Create(Code, Description, Amount));
  end;

var
  LineType: string;
  LineTypeInt: Integer;
  TypeIndex: Integer;
  Staff: string;
  Name: string;
  LineIndex: Integer;
  invoicenumber: Integer;
  txDate: Tdate;
  Created: TdateTime;
  room: string;
  product: string;
  productdescription: string;
  Description: string;
  numberofitems: Integer;
  nativeTotalPrice: Double;
  NameCol: string;
  DescriptionCol: string;
  TypeCol: string;

  // PaymentTotals             :
  Reservation: Integer;
  RoomReservation: Integer;

begin
  // if cbxQuery.ItemIndex < 0 then exit;
  if GetUserSqlList = '' then
    raise Exception.Create(GetTranslatedText('shUI_Reports_SelectAtLeastOneUser'));

  SetReportVisiblitity(true);

  grReport.ClearRows(1, grReport.RowCount - 1);
  grReport.RowCount := 1;

  subTotalDebet := 0.00;
  totalDebet := 0.00;
  lastLineType := '';
  lastNumber := 0;
  totalNumber := 0;

  zTotalSale := 0.00;
  zTotalInvoicePayments := 0.00;
  zTotalDownPayments := 0.00;
  zTotalPayments := 0.00;

  grReport.ColWidths[0] := 100;
  grReport.ColWidths[1] := 60;
  grReport.ColWidths[2] := 60;
  grReport.ColWidths[3] := 120;
  grReport.ColWidths[4] := 50;
  grReport.ColWidths[5] := 150;
  grReport.ColWidths[6] := 200;
  grReport.ColWidths[7] := 100;
  grReport.ColWidths[8] := 80;

  if kbmGet.active then
    kbmGet.Close;
  kbmGet.open;
  if kbmPayments.active then
    kbmPayments.Close;
  kbmPayments.open;

  kbmPaymentsDS.DataSet := kbmPayments;
  tvPayments.DataController.DataSource := kbmPaymentsDS;

  payment := TPaymentTotalDictionary.Create([doOwnsValues]);
  try
    screen.Cursor := crHourglass;
    d.roomerMainDataSet.SetTimeZoneComparedToUTC('');
    try
      Strings := TStringList.Create;
      try
        Strings.Text := FINANCE_QUERY;
        s := StringReplace(Strings.Text, '{date}', _db(DateToSqlString(dtDateFrom.Date)), [rfReplaceAll, rfIgnoreCase]);
        s := StringReplace(s, '{staff}', GetUserSqlList, [rfReplaceAll, rfIgnoreCase]);
        s := StringReplace(s, '{langId}', inttostr(g.qUserLanguage), [rfReplaceAll, rfIgnoreCase]);

        CopyToClipboard(s);
        // debugmessage(s);

        grReport.RowCount := grReport.RowCount + 1;
        grReport.Cells[0, grReport.RowCount - 1] := 'Transaction report for ';
        grReport.Cells[1, grReport.RowCount - 1] := DateToStr(dtDateFrom.Date);
        grReport.RowCount := grReport.RowCount + 1;
        grReport.Cells[0, grReport.RowCount - 1] := 'User ';
        if NOT AllUsersSelected then
          grReport.Cells[1, grReport.RowCount - 1] := ReplaceString(GetUserSqlList, '''', '')
        else
          grReport.Cells[1, grReport.RowCount - 1] := GetTranslatedText('shUI_Reports_ALL');
        grReport.RowCount := grReport.RowCount + 2;

        if hData.rSet_bySQL(bookingDataSet, s) then
        begin

          bookingDataSet.First;
          kbmGet.DisableControls;
          kbmPayments.DisableControls;
          bookingDataSet.DisableControls;
          try
            if kbmGet.active then
              kbmGet.Close;
            kbmGet.open;
            if kbmPayments.active then
              kbmPayments.Close;
            kbmPayments.open;

            // kbmGet.LoadFromDataSet(bookingDataSet, []);
            while not bookingDataSet.Eof do
            begin
              kbmGet.Insert;

              LineType := bookingDataSet.FieldByName('LineType').Asstring;

              LineTypeInt := bookingDataSet.FieldByName('LineTypeInt').asinteger;
              kbmGet.FieldByName('LineTypeInt').asinteger := LineTypeInt;

              nativeTotalPrice := bookingDataSet.FieldByName('nativeTotalPrice').AsFloat;
              kbmGet.FieldByName('nativeTotalPrice').AsFloat := nativeTotalPrice;

              txDate := bookingDataSet.FieldByName('txDate').AsDateTime;
              kbmGet.FieldByName('txDate').AsDateTime := txDate;

              Created := bookingDataSet.FieldByName('Created').AsDateTime;
              kbmGet.FieldByName('Created').AsDateTime := Created;

              kbmGet.FieldByName('TypeIndex').asinteger := bookingDataSet.FieldByName('TypeIndex').asinteger;
              kbmGet.FieldByName('Staff').Asstring := bookingDataSet.FieldByName('Staff').Asstring;
              kbmGet.FieldByName('Name').Asstring := bookingDataSet.FieldByName('Name').Asstring;
              kbmGet.FieldByName('GuestName').Asstring := bookingDataSet.FieldByName('GuestName').Asstring;
              kbmGet.FieldByName('LineIndex').asinteger := bookingDataSet.FieldByName('LineIndex').asinteger;
              kbmGet.FieldByName('InvoiceNumber').asinteger := bookingDataSet.FieldByName('InvoiceNumber').asinteger;
              kbmGet.FieldByName('room').Asstring := bookingDataSet.FieldByName('room').Asstring;
              kbmGet.FieldByName('BookingId').Asstring := bookingDataSet.FieldByName('BookingId').Asstring;
              kbmGet.FieldByName('product').Asstring := bookingDataSet.FieldByName('product').Asstring;
              kbmGet.FieldByName('Arrival').Asstring := bookingDataSet.FieldByName('Arrival').Asstring;
              kbmGet.FieldByName('Departure').Asstring := bookingDataSet.FieldByName('Departure').Asstring;
              kbmGet.FieldByName('productdescription').Asstring := bookingDataSet.FieldByName('productdescription').Asstring;
              kbmGet.FieldByName('description').Asstring := bookingDataSet.FieldByName('description').Asstring;
              kbmGet.FieldByName('numberofitems').asinteger := bookingDataSet.FieldByName('numberofitems').asinteger;

              Reservation := bookingDataSet.FieldByName('reservation').asinteger;
              RoomReservation := bookingDataSet.FieldByName('Roomreservation').asinteger;

              kbmGet.FieldByName('reservation').asinteger := Reservation;
              kbmGet.FieldByName('roomreservation').asinteger := RoomReservation;

              case LineTypeInt of
                3:
                  begin // Sale;
                    kbmGet.FieldByName('LineType').Asstring := LineType;
                    NameCol := bookingDataSet.FieldByName('Name').Asstring;
                    DescriptionCol := bookingDataSet.FieldByName('description').Asstring;
                    if (RoomReservation = 0) and (Reservation = 0) then
                      TypeCol := GetTranslatedText('shUI_Reports_InvoiceTypeCash');
                    if (RoomReservation = 0) and (Reservation > 0) then
                      TypeCol := GetTranslatedText('shUI_Reports_InvoiceTypeGroup');
                    if (RoomReservation > 0) and (Reservation > 0) then
                      TypeCol := GetTranslatedText('shUI_Reports_InvoiceTypeRoom');
                    zTotalSale := zTotalSale + nativeTotalPrice;
                  end;
                2:
                  begin // SaleItem;
                    kbmGet.FieldByName('LineType').Asstring := LineType;
                    NameCol := bookingDataSet.FieldByName('Name').Asstring;
                    DescriptionCol := bookingDataSet.FieldByName('productdescription').Asstring;
                    if (RoomReservation = 0) and (Reservation = 0) then
                      TypeCol := GetTranslatedText('shUI_Reports_InvoiceTypeCash');
                    if (RoomReservation = 0) and (Reservation > 0) then
                      TypeCol := GetTranslatedText('shUI_Reports_InvoiceTypeGroup');
                    if (RoomReservation > 0) and (Reservation > 0) then
                      TypeCol := GetTranslatedText('shUI_Reports_InvoiceTypeRoom');
                    zTotalSale            := zTotalSale+nativeTotalPrice;
                  end;
                0:
                  begin // Payment
                    kbmGet.FieldByName('LineType').Asstring := bookingDataSet.FieldByName('product').Asstring; // LineType;
                    NameCol := bookingDataSet.FieldByName('Name').Asstring;
                    // NameCol        := GetTranslatedText('shUI_Reports_InvoicePayments' );
                    DescriptionCol := GetTranslatedText('shUI_Reports_InvoicePayments');
                    // DescriptionCol := bookingDataSet.FieldByName('productdescription').Asstring;
                    TypeCol := bookingDataSet.FieldByName('product').Asstring;
                    zTotalInvoicePayments := zTotalInvoicePayments + nativeTotalPrice;
                    // kbmGet.FieldByName('Created').AsdateTime := 2;
                  end;
                1:
                  begin // Downpayment
                    kbmGet.FieldByName('LineType').Asstring := bookingDataSet.FieldByName('product').Asstring; // LineType;
                    NameCol := bookingDataSet.FieldByName('Name').Asstring;
                    // NameCol        := GetTranslatedText('shUI_Reports_DownPayments');
                    DescriptionCol := GetTranslatedText('shUI_Reports_DownPayments');
                    // DescriptionCol := bookingDataSet.FieldByName('productdescription').Asstring;
                    TypeCol := bookingDataSet.FieldByName('product').Asstring;
                    zTotalDownPayments := zTotalDownPayments + nativeTotalPrice;
                    // kbmGet.FieldByName('Created').AsdateTime := 2;
                  end;
              end;
              zTotalPayments := zTotalDownPayments + zTotalInvoicePayments;
              kbmGet.FieldByName('NameCol').Asstring := NameCol;
              kbmGet.FieldByName('DescriptionCol').Asstring := DescriptionCol;
              kbmGet.FieldByName('TypeCol').Asstring := TypeCol;

              // Updating/inserting payments table
              if (LineTypeInt = 0) or (LineTypeInt = 1) then
              begin
                if kbmPayments.locate('Type', TypeCol, []) then
                begin
                  kbmPayments.Edit;
                  kbmPayments.FieldByName('Amount').AsFloat := kbmPayments.FieldByName('Amount').AsFloat + nativeTotalPrice;
                  kbmPayments.Post;
                end
                else
                begin
                  kbmPayments.Insert;
                  kbmPayments.FieldByName('Type').Asstring := TypeCol; // bookingDataSet.FieldByName('product').Asstring ;
                  kbmPayments.FieldByName('Amount').AsFloat := nativeTotalPrice;
                  kbmPayments.FieldByName('Description').Asstring := bookingDataSet.FieldByName('productdescription').Asstring;
                  kbmPayments.Post;
                end
              end;

              kbmGet.Post;
              bookingDataSet.Next;
            end;
            zBalance := zTotalSale - zTotalPayments;

            // __Totalsale.Caption     := FloatToStrF(zTotalSale,ffCurrency, 8, 2); ;
            // __TotalPayments.Caption := FloatToStrF(zTotalPayments,ffCurrency, 8, 2); ;
            // __Balance.Caption       := FloatToStrF(zBalance,ffCurrency, 8, 2); ;

            kbmGet.First;
            while not kbmGet.Eof do
            begin
              LineTypeInt := kbmGet.FieldByName('LineTypeInt').asinteger;
              kbmGet.Edit;
              case LineTypeInt of
                3:
                  begin // Sale;
                    kbmGet.FieldByName('category').Asstring := GetTranslatedText('shUI_Reports_CashierLineTypeSale') + ' ' + FloatToStrF(zTotalSale, ffCurrency, 8, 2);
                  end;
                2:
                  begin // SaleItem;
                    kbmGet.FieldByName('category').Asstring := GetTranslatedText('shUI_Reports_CashierLineTypeSaleItems') + ' ' + FloatToStrF(zTotalSale, ffCurrency, 8, 2);
                  end;
                0:
                  begin // Payment
                    kbmGet.FieldByName('category').Asstring := kbmGet.FieldByName('product').Asstring + ' ' + kbmGet.FieldByName('productdescription').Asstring;
                    // GetTranslatedText('shUI_Reports_CashierLineTypeInvPayments') + ' ' + FloatToStrF(zTotalInvoicePayments,ffCurrency, 8, 2); ;
                  end;
                1:
                  begin // Downpayment
                    kbmGet.FieldByName('category').Asstring := kbmGet.FieldByName('product').Asstring + ' ' + kbmGet.FieldByName('productdescription').Asstring;
                    // GetTranslatedText('shUI_Reports_CashierLineTypeDownPayments') + ' ' + FloatToStrF(zTotalDownPayments,ffCurrency, 8, 2); ;;
                  end;
              end;
              kbmGet.Post;
              kbmGet.Next;
            end;
            kbmGet.First;

          finally
            kbmGet.EnableControls;
            kbmPayments.EnableControls;
            bookingDataSet.EnableControls;
            tvGet.DataController.Groups.FullExpand;
          end;

          bookingDataSet.First;
          while NOT bookingDataSet.Eof do
          begin
            if (lastLineType = '') OR (lastLineType <> bookingDataSet['LineType']) then
            begin
              if lastLineType <> '' then
                SubTotal;
              lastNumber := 0;
              grReport.RowCount := grReport.RowCount + 1;
              grReport.Cells[0, grReport.RowCount - 1] := GetTranslatedText('shUI_Reports_' + bookingDataSet['LineType']);
              lastLineType := bookingDataSet['LineType'];
              // grReport.Cells[1, grReport.RowCount - 1] := bookingDataSet['ProductDescription'];
            end
            else
              grReport.RowCount := grReport.RowCount + 1;

            grReport.Cells[3, grReport.RowCount - 1] := bookingDataSet['Staff'];
            if bookingDataSet['InvoiceNumber'] > 0 then
              grReport.Cells[2, grReport.RowCount - 1] := bookingDataSet['InvoiceNumber'];
            grReport.Cells[3, grReport.RowCount - 1] := DateTimeToStr(bookingDataSet['Created']); // DateToSqlString(bookingDataSet['TxDate']);
            grReport.Cells[4, grReport.RowCount - 1] := bookingDataSet['Room'];
            grReport.Cells[5, grReport.RowCount - 1] := bookingDataSet['name'];
            grReport.Cells[6, grReport.RowCount - 1] := bookingDataSet['Description'];
            subTotalDebet := subTotalDebet + bookingDataSet['NativeTotalPrice'];
            grReport.Cells[7, grReport.RowCount - 1] := trim(_floattostr(bookingDataSet['NativeTotalPrice'], 12, 2));
            if (UpperCase(bookingDataSet['LineType']) = 'DOWNPAYMENT') OR (UpperCase(bookingDataSet['LineType']) = 'PAYMENT') then
            begin
              grReport.Cells[8, grReport.RowCount - 1] := bookingDataSet['Product'];
              CollectPaymentTypes(bookingDataSet['Product'], bookingDataSet['ProductDescription'], bookingDataSet['NativeTotalPrice']);
            end;
            inc(lastNumber);
            bookingDataSet.Next;
          end;
          SubTotal;
          Total;

          grReport.RowCount := grReport.RowCount + 3;

          grReport.Cells[0, grReport.RowCount - 1] := GetTranslatedText('shUI_Reports_CashReport') + ' ';
          grReport.Cells[1, grReport.RowCount - 1] := DateToStr(dtDateFrom.Date);
          grReport.RowCount := grReport.RowCount + 1;
          grReport.Cells[0, grReport.RowCount - 1] := GetTranslatedText('shUI_Reports_Staff');
          if NOT AllUsersSelected then
            grReport.Cells[1, grReport.RowCount - 1] := ReplaceString(GetUserSqlList, '''', '')
          else
            grReport.Cells[1, grReport.RowCount - 1] := GetTranslatedText('shUI_Reports_ALL');

          totalDebet := 0.00;
          totalNumber := 0;
          for s in payment.Keys do
          begin
            grReport.RowCount := grReport.RowCount + 1;
            item := payment.Items[s];
            grReport.Cells[6, grReport.RowCount - 1] := item.Description;
            totalDebet := totalDebet + item.Total;
            grReport.Cells[7, grReport.RowCount - 1] := trim(_floattostr(item.Total, 12, 2));
            totalNumber := totalNumber + item.Num;
          end;
          Total;

        end;
      finally
        Strings.Free;
      end;
    finally
      d.roomerMainDataSet.SetTimeZoneComparedToUTC('UTC');
    end;
  finally
    payment.Free;
    screen.Cursor := crDefault;
  end;
  __Totalsale.Caption := FloatToStrF(zTotalSale, ffCurrency, 8, 2);;

  __TotalPayments.Caption := FloatToStrF(zTotalPayments, ffCurrency, 8, 2);;
  __Balance.Caption := FloatToStrF(zBalance, ffCurrency, 8, 2);;
end;

procedure TfrmRptCashier.UserSelectVisible(MakeVisible: boolean);
begin
  sLabel2.visible := MakeVisible;
  cbxStaff.visible := MakeVisible;
  btnClearStaff.visible := MakeVisible;
  btnCheckAllStaff.visible := MakeVisible;
end;

procedure TfrmRptCashier.btnRefreshClick(Sender: TObject);
begin
  Refresh;
end;

procedure TfrmRptCashier.grReportGetAlignment(Sender: TObject; ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol IN [6, 7] then
    HAlign := taRightJustify;
end;

procedure TfrmRptCashier.grReportGetCellColor(Sender: TObject; ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if ARow = 0 then
    ABrush.Color := clSilver;
end;

procedure TfrmRptCashier.LabTxItemPrint(Sender: TObject);
var
  s: String;
begin
  if kbmReport.Eof then
    Exit;
  s := kbmReport.FieldByName('Product').Asstring;
  if (s = '') OR (kbmReport.FieldByName('LineTypeInt').AsInteger IN [0,1]) then
    LabTxItem.Caption := ''
  else
    LabTxItem.Caption := s;
end;

procedure TfrmRptCashier.LabTxReservationPrint(Sender: TObject);
var
  i: Integer;
begin
  if kbmReport.Eof then
    Exit;
  i := kbmReport.FieldByName('Reservation').AsInteger;
  if (i < 1) then
    LabTxReservation.Caption := ''
  else
    LabTxReservation.Caption := IntToStr(i);
end;

procedure TfrmRptCashier.sButton1Click(Sender: TObject);
var
  Strings: TStringList;
  s: String;
  i, j: Integer;
begin
  //
  if dlgSave.Execute then
  begin
    Strings := TStringList.Create;
    try
      for j := 0 to grReport.RowCount - 1 do
      begin
        s := '';
        for i := 0 to grReport.ColCount - 1 do
        begin
          if s = '' then
            s := grReport.Cells[i, j]
          else
            s := s + Strings.Delimiter + grReport.Cells[i, j];
        end;
        Strings.Add(s);
      end;
      Strings.SaveToFile(dlgSave.FileName);
      ShellExecute(Handle, 'OPEN', PChar(dlgSave.FileName), nil, nil, sw_shownormal);
    finally
      Strings.Free;
    end;
  end;
end;


procedure TPaymentTotal.Add(_Amount: Double);
begin
  Total := Total + _Amount;
  inc(Num);
end;

constructor TPaymentTotal.Create(_Code, _Description: String; _Amount: Double);
begin
  Num := 1;
  Code := _Code;
  Description := _Description;
  Total := _Amount;
end;

/// /////////////////////////////////////////////////////////////////////////////
//
// REPORT
//
/// ////////////////////////////////////////////////////////////////////////////

procedure TfrmRptCashier.ppHeaderBand1BeforePrint(Sender: TObject);
var
  ReportName: string;
  s: string;
begin
  // **Translate
  ReportName := GetTranslatedText('shUI_Reports_CashierReportFor') + ' ' + DateToStr(dtDateFrom.Date);;
  ppLabelReportname.Caption := ReportName;

  s := g.qHotelName;
  rLabHotelName.Caption := s;

  s := GetTranslatedText('shTx_NationalReport_User') + g.qUser;
  if g.qusername <> '' then
    s := s + ' - ' + g.qusername;
  rlabUser.Caption := s;

  if cbxByUsers.Checked then
  begin
    s := GetTranslatedText('shUI_Reports_UsersInReport') + GetUserAsNormalList; // GetActiveUsersAsList;
  end
  else
  begin
    s := GetTranslatedText('shUI_Reports_UserInReport');
    s := s + format('%s (%s)', [g.qusername, g.qUser]);
  end;
  if (g.qNumberOfShifts > 0) AND (cbxShifts.ItemIndex > 0) then
    rlabUsers.Caption := Format('%s %s, %s', [getTranslatedText('shUI_Reports_ShiftInReport'), cbxShifts.Items[cbxShifts.ItemIndex], s])
  else
    rlabUsers.Caption := s;
end;

procedure TfrmRptCashier.ppLabel10Print(Sender: TObject);
var
  s: String;
begin
  if kbmReport.Eof then
    Exit;
  s := kbmReport.FieldByName('Departure').Asstring;
  if (s = '') then // OR (kbmReport.FieldByName('LineTypeInt').AsInteger IN [0,1]) then
    ppLabel10.Caption := ''
  else
    ppLabel10.Caption := DateToStr(uDateUtils.SqlStringToDate(s));
end;

procedure TfrmRptCashier.ppLabel11Print(Sender: TObject);
var
  s: String;
begin
  if kbmReport.Eof then
    Exit;
  s := kbmReport.FieldByName('TypeCol').Asstring;
  if (s = '') OR (kbmReport.FieldByName('LineTypeInt').AsInteger IN [0,1]) then
    ppLabel11.Caption := ''
  else
    ppLabel11.Caption := s;
end;

procedure TfrmRptCashier.ppLabel6Print(Sender: TObject);
var
  dtCreated: TdateTime;
  s: string;
begin
  if kbmReport.Eof then
    Exit;
  s := '';
  dtCreated := kbmReport.FieldByName('created').AsDateTime;
  if dtCreated > 2 then
  begin
    datetimeTostring(s, 'dd-mm-yyyy hh:nn:ss', dtCreated);
  end;
  ppLabel6.Caption := s;
end;

procedure TfrmRptCashier.ppLabel7Print(Sender: TObject);
var
  s: String;
begin
  if kbmReport.Eof then
    Exit;
  s := kbmReport.FieldByName('Arrival').Asstring;
  if (s = '') then // OR (kbmReport.FieldByName('LineTypeInt').AsInteger IN [0,1]) then
    ppLabel7.Caption := ''
  else
    ppLabel7.Caption := DateToStr(uDateUtils.SqlStringToDate(s));
end;

procedure TfrmRptCashier.ppLabel8Print(Sender: TObject);
begin
  if kbmReport.Eof then
    Exit;
  ppLabel8.Caption := kbmReport.FieldByName('Room').Asstring;
end;

procedure TfrmRptCashier.ppLabel9Print(Sender: TObject);
var
  i: Integer;
begin
  if kbmReport.Eof then
    Exit;
  i := kbmReport.FieldByName('InvoiceNumber').AsInteger;
  if (i < 1) then
    ppLabel9.Caption := ''
  else
    ppLabel9.Caption := IntToStr(i);
end;

procedure TfrmRptCashier.ppSummaryBand1BeforePrint(Sender: TObject);
begin
  ppLabBalance.Caption := __Balance.Caption;
  // **Translate
  ppLabTotalBalance.Caption := GetTranslatedText('shUI_Reports_Balance');
end;

/// //////////////////////////////////////////// Group header band
procedure TfrmRptCashier.ppDetailBand1BeforeGenerate(Sender: TObject);
begin
  //
end;

procedure TfrmRptCashier.ppGroupHeaderBand1BeforePrint(Sender: TObject);
begin
  ppLabStaff.Caption := GetTranslatedText('shUI_Reports_Staff');
  ppLabtxDate.Caption := GetTranslatedText('shUI_Reports_Date');
  ppLabtxRoom.Caption := GetTranslatedText('shUI_Reports_Room');
  LabTxResId.Caption := GetTranslatedText('shUI_Reports_ResId');
  LabGuestName.Caption := GetTranslatedText('shUI_Reports_GuestName');
  pplabName.Caption := GetTranslatedText('shUI_Reports_CustomerName');
  pplabDescription.Caption := GetTranslatedText('shUI_Reports_Description');
  ppLabNativeTotalPrice.Caption := GetTranslatedText('shUI_Reports_Total');
  pplabType.Caption := GetTranslatedText('shUI_Reports_PaymentType');
  pplabnumberofitems.Caption := 'Items';
end;

end.
