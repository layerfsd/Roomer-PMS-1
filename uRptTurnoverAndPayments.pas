unit uRptTurnoverAndPayments;

interface

uses
   Winapi.Windows
  , Winapi.Messages
  , System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Mask, shellapi

    , Data.DB, cmpRoomerDataSet, cmpRoomerConnection

    , kbmMemTable, _glob, ug, hData, prjConst

    , ustringUtils
    ,uUtils

    , sEdit, sPageControl, sCheckBox, sLabel, sGroupBox, sPanel, sMaskEdit,
  sCustomComboEdit, sTooledit, sButton

    , cxGridExportLink, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  cxButtons, cxControls, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid

    , cxCalc, cxMaskEdit, cxCurrencyEdit

    , ppCtrls, ppBands, ppParameter, ppDesignLayer, ppClass, ppVar, ppPrnabl,
  ppCache, ppProd, ppReport, ppDB, ppComm, ppRelatv, ppDBPipe, ppStrtch,
  ppSubRpt

    , uRptbViewer, cxPropertiesStore, dxSkinsCore, dxSkinCaramel,
    dxSkinCoffee, dxSkinDarkSide, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinscxPCPainter, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinDarkRoom, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue

    ;

type
  TfrmRptTurnoverAndPayments = class(TForm)
    LMDSimplePanel1: TsPanel;
    LMDStatusBar1: TStatusBar;
    sPageControl1: TsPageControl;
    sTabSheet1: TsTabSheet;
    Payments: TsTabSheet;
    sPanel1: TsPanel;
    grTurnover: TcxGrid;
    tvTurnover: TcxGridDBTableView;
    lvTurnover: TcxGridLevel;
    grPayments: TcxGrid;
    tvPayments: TcxGridDBTableView;
    lvPayments: TcxGridLevel;
    sPanel2: TsPanel;
    tvTurnoverItemID: TcxGridDBColumn;
    tvTurnoverDescription: TcxGridDBColumn;
    tvTurnoverItemtype: TcxGridDBColumn;
    tvTurnoverTypeDescription: TcxGridDBColumn;
    tvTurnoverVATCode: TcxGridDBColumn;
    tvTurnoverVATPercentage: TcxGridDBColumn;
    tvTurnoverAmount: TcxGridDBColumn;
    tvTurnoverVAT: TcxGridDBColumn;
    tvTurnoverItemcount: TcxGridDBColumn;
    tvPaymentsPayType: TcxGridDBColumn;
    tvPaymentsAmount: TcxGridDBColumn;
    tvPaymentsPaymentCount: TcxGridDBColumn;
    tvPaymentspaytypeDescription: TcxGridDBColumn;
    tvPaymentspaygroupDescripion: TcxGridDBColumn;
    btnExcelTurnover: TsButton;
    btnExcelPayments: TsButton;
    rptTurnowerPayments: TppReport;
    ppParameterList2: TppParameterList;
    ppDesignLayers2: TppDesignLayers;
    ppDesignLayer2: TppDesignLayer;
    ppHeaderBand2: TppHeaderBand;
    ppDetailBand2: TppDetailBand;
    ppFooterBand2: TppFooterBand;
    ppDBPPayments: TppDBPipeline;
    ppTitleBand1: TppTitleBand;
    ppSummaryBand1: TppSummaryBand;
    ppLabel5: TppLabel;
    ppSubReport1: TppSubReport;
    ppChildReport1: TppChildReport;
    ppDBPTurnover: TppDBPipeline;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppTitleBand2: TppTitleBand;
    ppDetailBand1: TppDetailBand;
    ppSummaryBand2: TppSummaryBand;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppSubReport2: TppSubReport;
    ppChildReport2: TppChildReport;
    ppDesignLayers3: TppDesignLayers;
    ppDesignLayer3: TppDesignLayer;
    ppTitleBand3: TppTitleBand;
    ppDetailBand3: TppDetailBand;
    ppSummaryBand3: TppSummaryBand;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppLabel3: TppLabel;
    ppLabel1: TppLabel;
    ppDBText3: TppDBText;
    GroupBox1: TsGroupBox;
    chkGetUnconfirmed: TsCheckBox;
    btnConfirm: TsButton;
    sTabSheet2: TsTabSheet;
    sPanel4: TsPanel;
    sButton2: TsButton;
    grRoomsDate: TcxGrid;
    tvRoomsDate: TcxGridDBTableView;
    lvRoomsDate: TcxGridLevel;
    tvRoomsDateStayDate: TcxGridDBColumn;
    tvRoomsDateroomreservation: TcxGridDBColumn;
    tvRoomsDatereservation: TcxGridDBColumn;
    tvRoomsDateRentAmount: TcxGridDBColumn;
    tvRoomsDatecurrency: TcxGridDBColumn;
    tvRoomsDateconfirmdate: TcxGridDBColumn;
    tvRoomsDatecurrencyRate: TcxGridDBColumn;
    tvRoomsDateisTaxIncluted: TcxGridDBColumn;
    tvRoomsDateDiscountAmount: TcxGridDBColumn;
    tvRoomsDateTotalStayTax: TcxGridDBColumn;
    sTabSheet3: TsTabSheet;
    sPanel3: TsPanel;
    sButton1: TsButton;
    grRoomrentOnInvoice: TcxGrid;
    tvRoomrentOnInvoice: TcxGridDBTableView;
    lvRoomrentOnInvoice: TcxGridLevel;
    tvRoomrentOnInvoiceItemID: TcxGridDBColumn;
    tvRoomrentOnInvoiceDescription: TcxGridDBColumn;
    tvRoomrentOnInvoiceItemtype: TcxGridDBColumn;
    tvRoomrentOnInvoiceTypeDescription: TcxGridDBColumn;
    tvRoomrentOnInvoiceVATCode: TcxGridDBColumn;
    tvRoomrentOnInvoiceVATPercentage: TcxGridDBColumn;
    tvRoomrentOnInvoiceAmount: TcxGridDBColumn;
    tvRoomrentOnInvoiceVAT: TcxGridDBColumn;
    tvRoomrentOnInvoiceItemcount: TcxGridDBColumn;
    tvRoomrentOnInvoiceInvoiceNumber: TcxGridDBColumn;
    tvRoomrentOnInvoiceisTaxIncluted: TcxGridDBColumn;
    tvRoomrentOnInvoicetotalStayTax: TcxGridDBColumn;
    sTabSheet4: TsTabSheet;
    sPanel5: TsPanel;
    btnInvoiceListExcel: TsButton;
    btnInvoiceListExpandAll: TsButton;
    btnInvoiceListContractAll: TsButton;
    grInvoicelist: TcxGrid;
    tvInvoiceHeads: TcxGridDBTableView;
    tvInvoiceHeadsRecId: TcxGridDBColumn;
    tvInvoiceHeadsInvoiceNumber: TcxGridDBColumn;
    tvInvoiceHeadsInvoiceDate: TcxGridDBColumn;
    tvInvoiceHeadsihAmountWithTax: TcxGridDBColumn;
    tvInvoiceHeadsihAmountNoTax: TcxGridDBColumn;
    tvInvoiceHeadsihAmountTax: TcxGridDBColumn;
    tvInvoiceHeadsCustomer: TcxGridDBColumn;
    tvInvoiceHeadsCustomerName: TcxGridDBColumn;
    tvInvoiceHeadsNameOnInvoice: TcxGridDBColumn;
    tvInvoiceHeadsAddress1: TcxGridDBColumn;
    tvInvoiceHeadsAddress2: TcxGridDBColumn;
    tvInvoiceHeadsAddress3: TcxGridDBColumn;
    tvInvoiceHeadsRoomGuest: TcxGridDBColumn;
    tvInvoiceHeadsisAgency: TcxGridDBColumn;
    tvInvoiceHeadsisKredit: TcxGridDBColumn;
    tvInvoiceHeadsisRoom: TcxGridDBColumn;
    tvInvoiceHeadsisGroup: TcxGridDBColumn;
    tvInvoiceHeadsisCash: TcxGridDBColumn;
    tvInvoiceHeadsdueDate: TcxGridDBColumn;
    tvInvoiceHeadsinvRefrence: TcxGridDBColumn;
    tvInvoiceHeadsCreditInvoice: TcxGridDBColumn;
    tvInvoiceHeadsOriginalInvoice: TcxGridDBColumn;
    tvInvoiceHeadsReservation: TcxGridDBColumn;
    tvInvoiceHeadsRoomReservation: TcxGridDBColumn;
    tvInvoiceHeadsSplitNumber: TcxGridDBColumn;
    tvInvoiceHeadsTotalStayTax: TcxGridDBColumn;
    tvInvoiceHeadsTotalStayTaxNights: TcxGridDBColumn;
    tvInvoiceHeadsConfirmedDate: TcxGridDBColumn;
    tvInvoiceHeadsCurrency: TcxGridDBColumn;
    tvInvoiceHeadsRate: TcxGridDBColumn;
    tvInvoiceHeadsStaff: TcxGridDBColumn;
    tvInvoiceHeadsmarkedSegment: TcxGridDBColumn;
    tvInvoiceHeadsmarkedSegmentDescription: TcxGridDBColumn;
    tvInvoiceLines: TcxGridDBTableView;
    tvInvoiceLinesRecId: TcxGridDBColumn;
    tvInvoiceLinesItem: TcxGridDBColumn;
    tvInvoiceLinesDescription: TcxGridDBColumn;
    tvInvoiceLinesQuantity: TcxGridDBColumn;
    tvInvoiceLinesPrice: TcxGridDBColumn;
    tvInvoiceLinesVATType: TcxGridDBColumn;
    tvInvoiceLinesilAmountWithTax: TcxGridDBColumn;
    tvInvoiceLinesilAmountNoTax: TcxGridDBColumn;
    tvInvoiceLinesilAmountTax: TcxGridDBColumn;
    tvInvoiceLinesCurrency: TcxGridDBColumn;
    tvInvoiceLinesCurrencyRate: TcxGridDBColumn;
    tvInvoiceLinesImportRefrence: TcxGridDBColumn;
    tvInvoiceLinesPurchaseDate: TcxGridDBColumn;
    tvInvoiceLinesImportSource: TcxGridDBColumn;
    tvInvoiceLinesInvoiceNumber: TcxGridDBColumn;
    lvInvoiceHeads: TcxGridLevel;
    lvInvoiceLines: TcxGridLevel;
    btnInvoiceListInvoice: TsButton;
    btnInvoiceListReservation: TsButton;
    tvRoomsDateid: TcxGridDBColumn;
    tvRoomsDateinvoicenumber: TcxGridDBColumn;
    sTabSheet6: TsTabSheet;
    sPanel7: TsPanel;
    sButton7: TsButton;
    sButton8: TsButton;
    sButton9: TsButton;
    grUnconfirmedInvoicelines: TcxGrid;
    tvUnconfirmedInvoicelines: TcxGridDBTableView;
    lvUnconfirmedInvoicelines: TcxGridLevel;
    tvUnconfirmedInvoicelinesItemID: TcxGridDBColumn;
    tvUnconfirmedInvoicelinesDescription: TcxGridDBColumn;
    tvUnconfirmedInvoicelinesItemtype: TcxGridDBColumn;
    tvUnconfirmedInvoicelinesTypeDescription: TcxGridDBColumn;
    tvUnconfirmedInvoicelinesVATCode: TcxGridDBColumn;
    tvUnconfirmedInvoicelinesVATPercentage: TcxGridDBColumn;
    tvUnconfirmedInvoicelinesAmount: TcxGridDBColumn;
    tvUnconfirmedInvoicelinesVAT: TcxGridDBColumn;
    tvUnconfirmedInvoicelinesItemcount: TcxGridDBColumn;
    tvUnconfirmedInvoicelinesid: TcxGridDBColumn;
    tvUnconfirmedInvoicelinesPurchaseDate: TcxGridDBColumn;
    tvUnconfirmedInvoicelinesreservation: TcxGridDBColumn;
    tvUnconfirmedInvoicelinesroomReservation: TcxGridDBColumn;
    tvUnconfirmedInvoicelinesconfirmAmount: TcxGridDBColumn;
    sTabSheet7: TsTabSheet;
    sPanel8: TsPanel;
    sButton11: TsButton;
    sButton13: TsButton;
    grInvoiceLinePriceChange: TcxGrid;
    tvInvoiceLinePriceChange: TcxGridDBTableView;
    lvInvoiceLinePriceChange: TcxGridLevel;
    tvInvoiceLinePriceChangeItemID: TcxGridDBColumn;
    tvInvoiceLinePriceChangeDescription: TcxGridDBColumn;
    tvInvoiceLinePriceChangeItemtype: TcxGridDBColumn;
    tvInvoiceLinePriceChangeTypeDescription: TcxGridDBColumn;
    tvInvoiceLinePriceChangeVATCode: TcxGridDBColumn;
    tvInvoiceLinePriceChangeVATPercentage: TcxGridDBColumn;
    tvInvoiceLinePriceChangeAmount: TcxGridDBColumn;
    tvInvoiceLinePriceChangeVAT: TcxGridDBColumn;
    tvInvoiceLinePriceChangeItemcount: TcxGridDBColumn;
    tvInvoiceLinePriceChangeid: TcxGridDBColumn;
    tvInvoiceLinePriceChangePurchaseDate: TcxGridDBColumn;
    tvInvoiceLinePriceChangereservation: TcxGridDBColumn;
    tvInvoiceLinePriceChangeroomReservation: TcxGridDBColumn;
    tvInvoiceLinePriceChangeconfirmAmount: TcxGridDBColumn;
    tvInvoiceLinePriceChangePriceChange: TcxGridDBColumn;
    sTabSheet8: TsTabSheet;
    sPanel9: TsPanel;
    sButton15: TsButton;
    sButton17: TsButton;
    grRoomsDateChange: TcxGrid;
    tvRoomsDateChange: TcxGridDBTableView;
    lvRoomsDateChange: TcxGridLevel;
    tvRoomsDateChangeStayDate: TcxGridDBColumn;
    tvRoomsDateChangeroomreservation: TcxGridDBColumn;
    tvRoomsDateChangereservation: TcxGridDBColumn;
    tvRoomsDateChangeRentAmount: TcxGridDBColumn;
    tvRoomsDateChangecurrency: TcxGridDBColumn;
    tvRoomsDateChangeconfirmdate: TcxGridDBColumn;
    tvRoomsDateChangecurrencyRate: TcxGridDBColumn;
    tvRoomsDateChangeisTaxIncluted: TcxGridDBColumn;
    tvRoomsDateChangeDiscountAmount: TcxGridDBColumn;
    tvRoomsDateChangeTotalStayTax: TcxGridDBColumn;
    tvRoomsDateChangeid: TcxGridDBColumn;
    tvRoomsDateChangeinvoicenumber: TcxGridDBColumn;
    tvRoomsDateChangeDiscountChange: TcxGridDBColumn;
    tvRoomsDateChangeTaxChange: TcxGridDBColumn;
    tvRoomsDateChangeRentChange: TcxGridDBColumn;
    ppDBCalc1: TppDBCalc;
    ppLabel2: TppLabel;
    ppLabel4: TppLabel;
    ppDBCalc2: TppDBCalc;
    labConfirmdate: TppLabel;
    sButton19: TsButton;
    sButton23: TsButton;
    tvRoomrentOnInvoicesplitNumber: TcxGridDBColumn;
    rLabHotelName: TppLabel;
    rlabUser: TppLabel;
    rLabTimeCreated: TppLabel;
    ppLabel8: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    sTabSheet5: TsTabSheet;
    sPanel6: TsPanel;
    sButton3: TsButton;
    sButton4: TsButton;
    sButton5: TsButton;
    tvPaymentList: TcxGridDBTableView;
    lvPaymentList: TcxGridLevel;
    grPaymentList: TcxGrid;
    tvPaymentListPayType: TcxGridDBColumn;
    tvPaymentListAmount: TcxGridDBColumn;
    tvPaymentListpaytypeDescription: TcxGridDBColumn;
    tvPaymentListpaygroupDescripion: TcxGridDBColumn;
    tvPaymentListdtPayDate: TcxGridDBColumn;
    tvPaymentListDescription: TcxGridDBColumn;
    tvPaymentListMedhod: TcxGridDBColumn;
    tvPaymentListcustomer: TcxGridDBColumn;
    tvPaymentListcustomername: TcxGridDBColumn;
    tvPaymentListNameOnInvoice: TcxGridDBColumn;
    tvPaymentListreservation: TcxGridDBColumn;
    tvPaymentListroomreservation: TcxGridDBColumn;
    tvPaymentListinvoicenumber: TcxGridDBColumn;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel9: TppLabel;
    rLabBalance: TppLabel;
    ppLine1: TppLine;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sLabel3: TsLabel;
    labTotalTurnover: TsLabel;
    labTotalPayments: TsLabel;
    labTotalBalance: TsLabel;
    rlabTotalTurnover: TppLabel;
    rlabTotalPayments: TppLabel;
    sButton6: TsButton;
    tvUnconfirmedInvoicelinesRoom: TcxGridDBColumn;
    tvUnconfirmedInvoicelinesStaff: TcxGridDBColumn;
    tvUnconfirmedInvoicelinesInvoiceNumber: TcxGridDBColumn;
    tvRoomrentOnInvoiceRoom: TcxGridDBColumn;
    tvRoomrentOnInvoiceStaff: TcxGridDBColumn;
    sLabel4: TsLabel;
    sPanel10: TsPanel;
    btnGetOld: TsButton;
    btnRefresh: TsButton;
    btnReportsReport: TsButton;
    edUnconfirmedDate: TsEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnExcelTurnoverClick(Sender: TObject);
    procedure btnExcelPaymentsClick(Sender: TObject);
    procedure btnReportsReportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
    procedure chkGetUnconfirmedClick(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure btnInvoiceListExcelClick(Sender: TObject);
    procedure btnInvoiceListExpandAllClick(Sender: TObject);
    procedure btnInvoiceListContractAllClick(Sender: TObject);
    procedure tvTurnoverAmountGetProperties(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure tvTurnoverVATGetProperties(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure tvPaymentsAmountGetProperties(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure tvRoomsDateRentAmountGetProperties(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure tvRoomsDateDiscountAmountGetProperties
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvRoomsDateTotalStayTaxGetProperties
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvRoomrentOnInvoiceAmountGetProperties
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvRoomrentOnInvoiceVATGetProperties
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvRoomrentOnInvoicetotalStayTaxGetProperties
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvInvoiceHeadsihAmountWithTaxGetProperties
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvInvoiceHeadsihAmountTaxGetProperties
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvInvoiceHeadsTotalStayTaxGetProperties
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvInvoiceLinesilAmountWithTaxGetProperties
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvInvoiceLinesilAmountNoTaxGetProperties
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvInvoiceLinesilAmountTaxGetProperties
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure btnInvoiceListInvoiceClick(Sender: TObject);
    procedure btnInvoiceListReservationClick(Sender: TObject);
    procedure btnInvoiceListReportClick(Sender: TObject);
    procedure tvInvoiceHeadsihAmountNoTaxGetProperties
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvUnconfirmedInvoicelinesconfirmAmountGetProperties
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvUnconfirmedInvoicelinesVATGetProperties
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvUnconfirmedInvoicelinesAmountGetProperties
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvInvoiceLinePriceChangeAmountGetProperties
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvInvoiceLinePriceChangeconfirmAmountGetProperties
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvInvoiceLinePriceChangePriceChangeGetProperties
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvInvoiceLinePriceChangeVATGetProperties
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure ppTitleBand1BeforePrint(Sender: TObject);
    procedure btnGetOldClick(Sender: TObject);
    procedure tvPaymentListAmountGetProperties(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure sButton3Click(Sender: TObject);
    procedure sButton4Click(Sender: TObject);
    procedure sButton5Click(Sender: TObject);
    procedure sPageControl1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ppSummaryBand1BeforePrint(Sender: TObject);
    procedure tvRoomsDateChangeRentAmountGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvRoomsDateChangeDiscountAmountGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure sButton1Click(Sender: TObject);
    procedure sButton19Click(Sender: TObject);
    procedure sButton7Click(Sender: TObject);
    procedure sButton9Click(Sender: TObject);
    procedure sButton11Click(Sender: TObject);
    procedure sButton13Click(Sender: TObject);
    procedure sButton15Click(Sender: TObject);
    procedure sButton17Click(Sender: TObject);
    procedure sButton8Click(Sender: TObject);
    procedure sButton23Click(Sender: TObject);
    procedure sButton6Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    // zRoomRentItem: string;
    // zDiscountItem: String;
    // zTaxesItem: string;

    // zRoomRentItemDescription: string;
    // zDiscountItemDescription: String;
    // zTaxesItemDescription: string;
    //
    // zStayTaxPerNight: double;
    // zUseStayTax: boolean;
    // zStayTaxIncluted: boolean;
    //
    // zRoomRentType: string;
    // zRoomRentTypeDescription: string;
    // zRoomRentVATCode: string;
    // zRoomRentVATPercentage: double;
    //
    // zcTaxType: string;
    // zcTaxTypeDescription: string;
    // zcTaxVATCode: string;
    // zcTaxVATPercentage: double;
    //
    // zDiscountType: string;
    // zDiscountTypeDescription: string;
    //
    zIsConfirmed: boolean;
    // zConfirmState: integer;
    zConfirmedDate: TdateTime;
    //
    // zInvoiceList: string;

    globals: recTurnoverAndPaymentsGlobals;

    procedure getAll(clearData: boolean);
    function StatusInStr(inField: string): string;
    procedure UpdateTurnover;
    function CreateSQLInText(list: TstringList): string;
    procedure UpdateTurnoverItemPriceChange;
    procedure clearAllData;
    procedure getPrevius(confirmDate: TdateTime; clearData: boolean);
    procedure getReport;

  public
    { Public declarations }
  end;

function OpenRptTurnoverAndPayments: boolean;

var
  frmRptTurnoverAndPayments: TfrmRptTurnoverAndPayments;

implementation

{$R *.dfm}

uses
  uAppGlobal, uD, uDReportData, uRoomerLanguage, uReservationProfile, uFinishedInvoices2,
  uInvoice, uRptConfirms, uDImages;

function OpenRptTurnoverAndPayments: boolean;
begin
  result := false;
  frmRptTurnoverAndPayments := TfrmRptTurnoverAndPayments.Create
    (frmRptTurnoverAndPayments);
  try
    frmRptTurnoverAndPayments.ShowModal;
    if frmRptTurnoverAndPayments.modalresult = mrOk then
    begin
      result := true;
    end
    else
    begin
    end;
  finally
    freeandnil(frmRptTurnoverAndPayments);
  end;




end;

function TfrmRptTurnoverAndPayments.CreateSQLInText(list: TstringList): string;
var
  i: integer;
  s: string;
begin
  result := '';
  s := '';
  for i := 0 to list.Count - 1 do
  begin
    s := s + list[i] + ',';
  end;

  if length(s) > 0 then
  begin
    delete(s, length(s), 1);
    result := '(' + s + ')';
  end;
end;

function TfrmRptTurnoverAndPayments.StatusInStr(inField: string): string;
begin
end;

procedure TfrmRptTurnoverAndPayments.tvInvoiceHeadsihAmountNoTaxGetProperties
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptTurnoverAndPayments.tvInvoiceHeadsihAmountTaxGetProperties
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptTurnoverAndPayments.tvInvoiceHeadsihAmountWithTaxGetProperties
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptTurnoverAndPayments.tvInvoiceHeadsTotalStayTaxGetProperties
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptTurnoverAndPayments.tvInvoiceLinePriceChangeAmountGetProperties
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptTurnoverAndPayments.
  tvInvoiceLinePriceChangeconfirmAmountGetProperties
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptTurnoverAndPayments.
  tvInvoiceLinePriceChangePriceChangeGetProperties
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptTurnoverAndPayments.tvInvoiceLinePriceChangeVATGetProperties
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptTurnoverAndPayments.tvInvoiceLinesilAmountNoTaxGetProperties
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptTurnoverAndPayments.tvInvoiceLinesilAmountTaxGetProperties
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptTurnoverAndPayments.tvInvoiceLinesilAmountWithTaxGetProperties
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptTurnoverAndPayments.tvPaymentListAmountGetProperties
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptTurnoverAndPayments.tvPaymentsAmountGetProperties
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptTurnoverAndPayments.tvRoomrentOnInvoiceAmountGetProperties
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptTurnoverAndPayments.
  tvRoomrentOnInvoicetotalStayTaxGetProperties(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptTurnoverAndPayments.tvRoomrentOnInvoiceVATGetProperties
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptTurnoverAndPayments.tvRoomsDateChangeDiscountAmountGetProperties(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptTurnoverAndPayments.tvRoomsDateChangeRentAmountGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptTurnoverAndPayments.tvRoomsDateDiscountAmountGetProperties
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptTurnoverAndPayments.tvRoomsDateRentAmountGetProperties
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptTurnoverAndPayments.tvRoomsDateTotalStayTaxGetProperties
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptTurnoverAndPayments.tvTurnoverAmountGetProperties
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
//   AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptTurnoverAndPayments.tvTurnoverVATGetProperties
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptTurnoverAndPayments.
  tvUnconfirmedInvoicelinesAmountGetProperties(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptTurnoverAndPayments.
  tvUnconfirmedInvoicelinesconfirmAmountGetProperties
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptTurnoverAndPayments.tvUnconfirmedInvoicelinesVATGetProperties
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptTurnoverAndPayments.btnExcelTurnoverClick(Sender: TObject);
var
  sFilename: string;
  s: string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_Turnover';
  ExportGridToXLSX(sFilename, grTurnover, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xlsx'), nil, nil,
    sw_shownormal);
end;

procedure TfrmRptTurnoverAndPayments.btnGetOldClick(Sender: TObject);
var
  confirmDate: TdateTime;
  s : string;
begin
  s := '';
  confirmDate := 2;
  if OpenRptConfirms(confirmDate,s) then
  begin
    getPrevius(confirmDate, true);
  end else
    MessageDlg(GetTranslatedText('shTx_RptTurnoverPayments_NoConfirmedReports'), mtError, [mbOk], 0);
end;

procedure TfrmRptTurnoverAndPayments.btnRefreshClick(Sender: TObject);
begin
  getAll(true);
end;

procedure TfrmRptTurnoverAndPayments.btnReportsReportClick(Sender: TObject);
begin
  screen.Cursor := crHourglass;
  try
    getReport;
  finally
    screen.Cursor := crDefault;
  end;
end;

procedure TfrmRptTurnoverAndPayments.getReport;
var
  aReport: TppReport;
  sFilter: string;
  s: string;
  sortField: string;
  isDescending: boolean;
  mReport: TkbmMemTable;
  iCount: integer;
begin

  if d.mrptTurnover.active then
    d.mrptTurnover.Close;
  d.mrptTurnover.LoadFromDataSet(tvTurnover.DataController.DataSource.DataSet,[mtcpoStructure]);

  if d.mrptPayments.active then
    d.mrptPayments.Close;
  d.mrptPayments.LoadFromDataSet(tvPayments.DataController.DataSource.DataSet,
    [mtcpoStructure]);

  d.kbmTurnover_.DisableControls;
  d.kbmPayments_.DisableControls;
  try
    if frmRptbViewer <> nil then
      freeandnil(frmRptbViewer);
    frmRptbViewer := TfrmRptbViewer.Create(frmRptbViewer);
    frmRptbViewer.show;

    screen.Cursor := crHourglass;
    try
      aReport := rptTurnowerPayments;
      frmRptbViewer.ppViewer1.Reset;
      frmRptbViewer.ppViewer1.Report := aReport;
      frmRptbViewer.ppViewer1.GotoPage(1);
      aReport.PrintToDevices;
      frmRptbViewer.show;

    finally
      screen.Cursor := crDefault;
    end;
  finally
    d.kbmTurnover_.enableControls;
    d.kbmPayments_.enableControls;
  end;
end;

procedure TfrmRptTurnoverAndPayments.clearAllData;
begin
  d.kbmTurnover_.Close;
  d.kbmPayments_.Close;
  d.kbmRoomsDate_.Close;
  d.kbmRoomRentOnInvoice_.Close;
  d.mInvoiceHeads.Close;
  d.mInvoiceLines.Close;
  DReportData.kbmUnconfirmedInvoicelines_.Close;
  d.kbmInvoiceLinePriceChange_.Close;

  d.kbmTurnover_.open;
  d.kbmPayments_.open;
  d.kbmRoomsDate_.open;
  d.kbmRoomRentOnInvoice_.open;
  d.mInvoiceHeads.open;
  d.mInvoiceLines.open;
  DReportData.kbmUnconfirmedInvoicelines_.open;
  d.kbmInvoiceLinePriceChange_.open;
end;

procedure TfrmRptTurnoverAndPayments.chkGetUnconfirmedClick(Sender: TObject);
begin
  if chkGetUnconfirmed.checked then
  begin
    globals.ConfirmState := 1;
    btnConfirm.visible := true;
    btnGetOld.visible := false;
    getAll(true);
  end
  else
  begin
    globals.ConfirmState := 0;
    btnConfirm.visible := false;
    btnGetOld.visible := true;
    // clearAllData;
  end;
end;

procedure TfrmRptTurnoverAndPayments.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  d.TurnoverAndPayemnetsClearAllData(true);
end;

procedure TfrmRptTurnoverAndPayments.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  zIsConfirmed := false;
  zConfirmedDate := 2;
end;

procedure TfrmRptTurnoverAndPayments.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmRptTurnoverAndPayments.FormShow(Sender: TObject);
begin
  d.TurnoverAndPayemnetsClearAllData(true);
  sPageControl1.ActivePageIndex := 0;
end;

procedure TfrmRptTurnoverAndPayments.getAll(clearData: boolean);
var
  rSet: TRoomerDataset;
  s: string;
begin
  screen.Cursor := crDefault;
  try
    initTurnoverAndPaymentsGlobals(globals);
    d.TurnoverAndPaymentsGetAll(false, globals);

    tvTurnover.ApplyBestFit;
    tvPayments.ApplyBestFit;
    tvRoomsDate.ApplyBestFit;
    tvRoomrentOnInvoice.ApplyBestFit;
    tvInvoiceHeads.ApplyBestFit;
    tvUnconfirmedInvoicelines.ApplyBestFit;
    tvInvoiceLinePriceChange.ApplyBestFit;
    tvRoomsDate.ApplyBestFit;
    tvRoomsDateChange.ApplyBestFit;
    tvPaymentList.ApplyBestFit;

    labTotalTurnover.caption := FloatToStrF(globals.totalTurnover,ffCurrency, 8, 2);
    labTotalPayments.caption := FloatToStrF(globals.totalPayments,ffCurrency, 8, 2);
    labTotalBalance.caption  := FloatToStrF(globals.totalTurnover - globals.totalPayments,ffCurrency, 8, 2);
  finally
    screen.Cursor := crDefault;
  end;
end;

procedure TfrmRptTurnoverAndPayments.ppSummaryBand1BeforePrint(Sender: TObject);
var
  balance: double;
begin
  rlabTotalTurnover.caption := FloatToStrF(globals.totalTurnover,
    ffCurrency, 8, 2);
  rlabTotalPayments.caption := FloatToStrF(globals.totalPayments,
    ffCurrency, 8, 2);

  balance := globals.totalTurnover - globals.totalPayments;
  rLabBalance.caption := FloatToStrF(balance, ffCurrency, 8, 2);
end;

procedure TfrmRptTurnoverAndPayments.ppTitleBand1BeforePrint(Sender: TObject);
var
  s: string;
begin
  dateTimeToString(s, 'dddddd tt', zConfirmedDate);
  labConfirmdate.caption := 'Not confirmed ';
  if zConfirmedDate > 3 then
  begin
    labConfirmdate.caption := 'Confirmed : ' + s;
  end;

  s := g.qHotelName;

  rLabHotelName.caption := s;

  dateTimeToString(s, 'c', now);

  // s := 'Created : ' + s;
  s := GetTranslatedText('shTx_NationalReport_Created') + s;
  rLabTimeCreated.caption := s;

  // s := 'User : ' + g.qUser;
  s := GetTranslatedText('shTx_NationalReport_User') + g.qUser;
  if g.qusername <> '' then
    s := s + ' - ' + g.qusername;
  rlabUser.caption := s;
end;

procedure TfrmRptTurnoverAndPayments.UpdateTurnover;
begin
end;

procedure TfrmRptTurnoverAndPayments.UpdateTurnoverItemPriceChange;
begin
end;

procedure TfrmRptTurnoverAndPayments.btnConfirmClick(Sender: TObject);
var
  s: string;
  iCount: integer;
  ok: boolean;
begin
  iCount := d.kbmTurnover_.recordcount + d.kbmPayments_.recordcount +
    d.mInvoiceHeads.recordcount + d.kbmRoomRentOnInvoice_.recordcount;

  if zIsConfirmed then
  begin
    if iCount = 0 then
    begin
      s := 'Nothing to confirm';
      showmessage(s);
      exit;
    end
    else
    begin
      s := 'Data is confirmed - unconfirm ?';
      showmessage(s);
    end;
  end
  else
  begin
    if iCount = 0 then
    begin
      s := 'Nothing to confirm';
      showmessage(s);
      exit;
    end
    else
    begin
      s := 'Data not confirmed - confirm now!'
    end;
  end;

  if MessageDlg(s, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    d.TurnoverAndPaymentsDoConfirm;
    getReport;
  end;
end;

procedure TfrmRptTurnoverAndPayments.btnExcelPaymentsClick(Sender: TObject);
var
  sFilename: string;
  s: string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_Payments';
  ExportGridToXLSX(sFilename, grPayments, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xlsx'), nil, nil,
    sw_shownormal);
end;


procedure TfrmRptTurnoverAndPayments.sButton1Click(Sender: TObject);
var
  sFilename: string;
  s: string;
begin
  //
  if d.kbmRoomRentOnInvoice_.RecordCount = 0 then exit;

  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_unInvoicedRoomRent';
  ExportGridToXLSX(sFilename, grRoomrentOnInvoice, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xlsx'), nil, nil,
    sw_shownormal);
end;

procedure TfrmRptTurnoverAndPayments.sButton23Click(Sender: TObject);
var
  iReservation: integer;
  iRoomReservation: integer;
begin
  iReservation := d.kbmRoomsDate_.FieldByName('Reservation').asinteger;
  iRoomReservation := d.kbmRoomsDate_.FieldByName('roomReservation').asinteger;
  if EditReservation(iReservation, iRoomReservation) then
  begin
  end;
end;

procedure TfrmRptTurnoverAndPayments.sButton2Click(Sender: TObject);
var
  sFilename: string;
  s: string;
begin
  if d.kbmRoomsDate_.RecordCount = 0 then exit;

  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_unpaidRoomTent';
  ExportGridToXLSX(sFilename, grRoomsDate, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xlsx'), nil, nil,
    sw_shownormal);
end;

procedure TfrmRptTurnoverAndPayments.sButton3Click(Sender: TObject);
var
  sFilename: string;
  s: string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_PaymentList';
  ExportGridToXLSX(sFilename, grPaymentlist, false, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xlsx'), nil, nil,
    sw_shownormal);
end;

procedure TfrmRptTurnoverAndPayments.sButton4Click(Sender: TObject);
var
  invoicenumber: integer;
  iRoomReservation: integer;
  iReservation: integer;

  Arrival: Tdate;
  Departure: Tdate;

begin
  invoicenumber := d.kbmpaymentList_.FieldByName('InvoiceNumber').asinteger;
  if invoicenumber > 0 then
  begin
    ViewInvoice2(invoicenumber, false, false, false,false, '');
  end
  else
  begin
    iRoomReservation := 0;
    iReservation := 0;
    Arrival := Date;
    Departure := Date;
    iReservation := d.kbmpaymentList_.FieldByName('Reservation').asinteger;
    iRoomReservation := d.kbmpaymentList_.FieldByName('RoomReservation')
      .asinteger;
    EditInvoice(iReservation, iRoomReservation, 0, 0, 0, 0, false, true, false);
  end;
end;

procedure TfrmRptTurnoverAndPayments.sButton5Click(Sender: TObject);
var
  iReservation: integer;
  iRoomReservation: integer;
begin
  iReservation := d.kbmpaymentList_.FieldByName('Reservation').asinteger;
  iRoomReservation := d.kbmpaymentList_.FieldByName('roomReservation')
    .asinteger;

  if EditReservation(iReservation, iRoomReservation) then
  begin

  end;
end;

procedure TfrmRptTurnoverAndPayments.sButton6Click(Sender: TObject);
var
  invoicenumber: integer;
  iRoomReservation: integer;
  iReservation: integer;

  Arrival: Tdate;
  Departure: Tdate;
begin
  invoicenumber := d.kbmRoomsDate_.FieldByName('InvoiceNumber').asinteger;
  if invoicenumber > 0 then
  begin
    ViewInvoice2(invoicenumber, false, false, false,false, '');
  end
  else
  begin
    iRoomReservation := 0;
    iReservation := 0;
    Arrival := Date;
    Departure := Date;
    iReservation := d.kbmRoomsDate_.FieldByName('Reservation').asinteger;
    iRoomReservation := d.kbmRoomsDate_.FieldByName('RoomReservation').asinteger;
    EditInvoice(iReservation, iRoomReservation, 0, 0, 0, 0, false, true, false);
  end;
end;

procedure TfrmRptTurnoverAndPayments.sButton7Click(Sender: TObject);
var
  sFilename: string;
  s: string;
begin
  if DReportData.kbmUnconfirmedInvoicelines_.Eof then exit; // .RecordCount = 0 then exit;

  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_unconfirmedItems';
  ExportGridToXLSX(sFilename, grUnconfirmedInvoicelines, false, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xlsx'), nil, nil,sw_shownormal);
end;

procedure TfrmRptTurnoverAndPayments.sButton8Click(Sender: TObject);
var
  invoicenumber: integer;
  iRoomReservation: integer;
  iReservation: integer;

  Arrival: Tdate;
  Departure: Tdate;
begin
  invoicenumber := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('InvoiceNumber').asinteger;
  if invoicenumber > 0 then
  begin
    ViewInvoice2(invoicenumber, false, false, false,false, '');
  end
  else
  begin
    iRoomReservation := 0;
    iReservation := 0;
    Arrival := Date;
    Departure := Date;
    iReservation := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('Reservation').asinteger;
    iRoomReservation := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('RoomReservation').asinteger;
    EditInvoice(iReservation, iRoomReservation, 0, 0, 0, 0, false, true, false);
  end;
end;

procedure TfrmRptTurnoverAndPayments.sButton9Click(Sender: TObject);
var
  iReservation: integer;
  iRoomReservation: integer;
begin
  iReservation := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('Reservation').asinteger;
  iRoomReservation := DReportData.kbmUnconfirmedInvoicelines_.FieldByName('roomReservation').asinteger;

  if EditReservation(iReservation, iRoomReservation) then
  begin
  end;
end;

procedure TfrmRptTurnoverAndPayments.sPageControl1Change(Sender: TObject);
begin

end;

/// ///////////////////////////////////////////////////////////////////////////////
// invoicelist Buttons
//
/// ///////////////////////////////////////////////////////////////////////////////

procedure TfrmRptTurnoverAndPayments.btnInvoiceListExcelClick(Sender: TObject);
var
  sFilename: string;
  s: string;
begin
  if d.mInvoiceHeads.RecordCount = 0 then exit;

  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_Invoices';
  ExportGridToXLSX(sFilename, grInvoicelist, false, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xlsx'), nil, nil,sw_shownormal);
end;

procedure TfrmRptTurnoverAndPayments.btnInvoiceListInvoiceClick
  (Sender: TObject);
var
  invoicenumber: integer;
  iRoomReservation: integer;
  iReservation: integer;

  Arrival: Tdate;
  Departure: Tdate;

begin
  invoicenumber := d.mInvoiceHeads.FieldByName('InvoiceNumber').asinteger;
  if invoicenumber > 0 then
  begin
    ViewInvoice2(invoicenumber, false, false, false,false, '');
  end
  else
  begin
    iRoomReservation := 0;
    iReservation := 0;
    Arrival := Date;
    Departure := Date;
    iReservation := d.mInvoiceHeads.FieldByName('Reservation').asinteger;
    iRoomReservation := d.mInvoiceHeads.FieldByName('RoomReservation')
      .asinteger;
    EditInvoice(iReservation, iRoomReservation, 0, 0, 0, 0, false, true, false);
  end;
end;

procedure TfrmRptTurnoverAndPayments.btnInvoiceListReportClick(Sender: TObject);
begin
  // **
end;

procedure TfrmRptTurnoverAndPayments.btnInvoiceListReservationClick(Sender: TObject);
var
  iReservation: integer;
  iRoomReservation: integer;
begin
  iReservation := d.mInvoiceHeads.FieldByName('Reservation').asinteger;
  iRoomReservation := d.mInvoiceHeads.FieldByName('roomReservation').asinteger;

  if EditReservation(iReservation, iRoomReservation) then
  begin
  end;
end;

procedure TfrmRptTurnoverAndPayments.btnInvoiceListExpandAllClick
  (Sender: TObject);
begin
  tvInvoiceHeads.ViewData.Expand(true);
end;

procedure TfrmRptTurnoverAndPayments.btnInvoiceListContractAllClick
  (Sender: TObject);
begin
  tvInvoiceHeads.ViewData.Collapse(true);
end;

/// ///////////////////////////////////////////////////////////////////////////////
//
/// ///////////////////////////////////////////////////////////////////////////////

procedure TfrmRptTurnoverAndPayments.getPrevius(confirmDate: TdateTime;
  clearData: boolean);
var
  s: string;
  rset1, rset2, rset3, rset4, rset5, rset6, rset7, rset8, rset9,
    rset10: TRoomerDataset;

  ExecutionPlan: TRoomerExecutionPlan;

  startTick: integer;
  stopTick: integer;
  SQLms: integer;

  statusIn: string;

  dtTmp: TdateTime;
  lst: TstringList;

  dateFrom: Tdate;
  dateTo: Tdate;

  invoicelist: string;

begin
  screen.Cursor := crHourGlass;
  lst := invoiceList_confirmed(confirmDate);
  try
    invoicelist := CreateSQLInText(lst);
  finally
    freeandnil(lst);
  end;

  // showmessage(zInvoicelist);

  if clearData then
    d.TurnoverAndPayemnetsClearAllData(true);

  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  try
    startTick := GetTickCount;

    s := '';
    s := s + ' SELECT '#10;
    s := s + '     tp.Item AS ItemID '#10;
    s := s + '   , tp.Description '#10;
    s := s + '   , tp.Itemtype '#10;
    s := s + '   , tp.itemTypeDescription AS TypeDescription '#10;
    s := s + '   , tp.VATCode '#10;
    s := s + '   , tp.VATPercentage '#10;
    s := s + '   , tp.Amount '#10;
    s := s + '   , tp.VAT '#10;
    s := s + '   , tp.Itemcount '#10;
    s := s + ' FROM '#10;
    s := s + '   turnoverandpayments tp '#10;
    s := s + ' WHERE '#10;
    s := s + '( confirmDate = ' + _dbDateAndTime(confirmDate) +
      ' ) and (datatype=1) ';

    // Getting items in invoicelines that is not roomrent
    // copyToClipboard(s);
    // DebugMessage('Getting items in invoicelines that is not roomrent'#10#10+s);
    ExecutionPlan.AddQuery(s);

    // //--
    s := '';
    s := s + ' SELECT '#10;
    s := s + '  tp.Item AS PayType '#10;
    s := s + ' ,tp.Amount '#10;
    s := s + ' ,tp.ItemCount AS PaymentCount '#10;
    s := s + ' ,tp.description AS paytypeDescription '#10;
    s := s + ' ,tp.ItemTypeDescription AS paygroupDescripion '#10;
    s := s + ' FROM '#10;
    s := s + '   turnoverandpayments tp '#10;
    s := s + '  WHERE '#10;
    s := s + '( confirmDate = ' + _dbDateAndTime(confirmDate) +
      ' ) and (datatype=2) ';

    // copyToClipboard(s);
    // DebugMessage('Getting all payments'#10#10+s);

    ExecutionPlan.AddQuery(s);

    s := '';
    s := s + ' SELECT '#10;
    s := s + '  rdc.RentAmount '#10;
    s := s + ' ,rdc.StayDate '#10;
    s := s + ' ,rdc.roomreservation '#10;
    s := s + ' ,rdc.reservation '#10;
    s := s + ' ,rdc.currency '#10;
    s := s + ' ,rdc.currencyRate '#10;
    s := s + ' ,rdc.isTaxIncluted '#10;
    s := s + ' ,rdc.DiscountAmount '#10;
    s := s + ' ,rdc.TotalStayTax '#10;
    s := s + ' ,rdc.roomsdateID '#10;
    s := s + ' ,rdc.invoicenumber '#10;
    s := s + ' ,rdc.discountChange '#10;
    s := s + ' ,rdc.taxChange '#10;
    s := s + ' ,rdc.rentChange '#10;
    s := s + ' ,rdc.Confirmdate '#10;
    s := s + ' FROM '#10;
    s := s + '   roomsdatechange rdc '#10;
    s := s + '  WHERE '#10;
    s := s + '( rdc.confirmDate = ' + _dbDateAndTime(confirmDate) + ' ) ';

    // copyToClipboard(s);
    // DebugMessage(s);
    ExecutionPlan.AddQuery(s);

    s := '';
    s := s + ' SELECT '#10;
    s := s + '   ilc.ItemID '#10;
    s := s + '  ,ilc.Description '#10;
    s := s + '  ,ilc.Itemtype '#10;
    s := s + '  ,ilc.TypeDescription '#10;
    s := s + '  ,ilc.VATCode '#10;
    s := s + '  ,ilc.VATPercentage '#10;
    s := s + '  ,ilc.Amount '#10;
    s := s + '  ,ilc.VAT '#10;
    s := s + '  ,ilc.Itemcount '#10;
    s := s + '  ,ilc.ivlID '#10;
    s := s + '  ,ilc.PurchaseDate '#10;
    s := s + '  ,ilc.reservation '#10;
    s := s + '  ,ilc.roomReservation '#10;
    s := s + '  ,ilc.confirmAmount '#10;
    s := s + '  ,ilc.PriceChange '#10;
    s := s + '  ,ilc.Confirmdate '#10;
    s := s + ' FROM invoicelinepricechange ilc '#10;
    s := s + '  WHERE '#10;
    s := s + '(ilc.confirmDate = ' + _dbDateAndTime(confirmDate) + ') ';

    // copyToClipboard(s);
    // DebugMessage(s);
    ExecutionPlan.AddQuery(s);

    s := '';
    s := s + ' SELECT ' + #10;
    s := s + '     ih.Reservation ' + #10;
    s := s + '   , ih.RoomReservation ' + #10;
    s := s + '   , ih.SplitNumber ' + #10;
    s := s + '   , ih.InvoiceNumber ' + #10;
    s := s + '   , ih.Customer ' + #10;
    s := s + '   , ih.Name AS NameOnInvoice ' + #10;
    s := s + '   , ih.Address1 ' + #10;
    s := s + '   , ih.Address2 ' + #10;
    s := s + '   , ih.Address3 ' + #10;
    s := s + '   , ih.Total AS ihAmountWithTax ' + #10;
    s := s + '   , ih.TotalWOVAT AS ihAmountNoTax ' + #10;
    s := s + '   , ih.TotalVAT AS ihAmountTax ' + #10;
    s := s + '   , ih.CreditInvoice ' + #10;
    s := s + '   , ih.OriginalInvoice ' + #10;
    s := s + '   , ih.RoomGuest ' + #10;
    s := s + '   , ih.ihInvoiceDate AS InvoiceDate ' + #10;
    s := s + '   , ih.ihPayDate AS dueDate ' + #10;
    s := s + '   , ih.invRefrence ' + #10;
    s := s + '   , ih.TotalStayTax ' + #10;
    s := s + '   , ih.TotalStayTaxNights ' + #10;
    s := s + '   , ih.ihConfirmDate AS ConfirmedDate ' + #10;
    s := s + '   , ih.ihCurrency AS Currency ' + #10;
    s := s + '   , ih.ihCurrencyRate AS Rate ' + #10;
    s := s + '   , ih.ihStaff AS Staff ' + #10;
    s := s + '   , cu.Surname AS CustomerName ' + #10;
    s := s + '   , cu.TravelAgency AS isAgency ' + #10;
    s := s + '   , cu.CustomerType AS markedSegment ' + #10;
    s := s + '   , ct.Description AS markedSegmentDescription ' + #10;
    s := s + ' FROM ' + #10;
    s := s + '   customertypes ct ' + #10;
    s := s + '     RIGHT OUTER JOIN customers cu ON ct.CustomerType = cu.CustomerType '
      + #10;
    s := s + '     RIGHT OUTER JOIN invoiceheads ih ON cu.Customer = ih.Customer '
      + #10;
    s := s + ' WHERE ' + #10;
    if invoicelist <> '' then
    begin
      s := s + '   (ih.InvoiceNumber IN ' + invoicelist + ') ' + #10;
    end
    else
    begin
      s := s + '   (ih.InvoiceNumber = -888) ' + #10;
    end;
    s := s + ' ORDER BY ' + #10;
    s := s + '   ih.InvoiceNumber ' + #10;

    // rset5,Results[4]d.mInvoiceHeads
    // copyToClipboard(s);
    // DebugMessage('Invoiceheads'#10#10+s);
    ExecutionPlan.AddQuery(s);

    s := '';
    s := s + ' SELECT ' + #10;
    s := s + '     il.InvoiceNumber ' + #10;
    s := s + '   , date(il.PurchaseDate) AS PurchaseDate ' + #10;
    s := s + '   , il.ItemID as Item' + #10;
    s := s + '   , il.Number as Quantity' + #10;
    s := s + '   , il.Description ' + #10;
    s := s + '   , il.Price ' + #10;
    s := s + '   , il.VATType ' + #10;
    s := s + '   , (il.Total + il.revenueCorrection) AS ilAmountWithTax ' + #10;
    s := s + '   , (il.Total + il.revenueCorrection) - (il.Vat + il.revenueCorrectionVAT) AS ilAmountNoTax ' + #10;
    s := s + '   , (il.Vat + il.revenueCorrectionVAT) as ilAmountTax' + #10;
    s := s + '   , il.Currency ' + #10;
    s := s + '   , il.CurrencyRate ' + #10;
    s := s + '   , il.ImportRefrence ' + #10;
    s := s + '   , il.ImportSource ' + #10;
    s := s + ' FROM ' + #10;
    s := s + '   invoicelines il ' + #10;
    s := s + ' WHERE ' + #10;
    if invoicelist <> '' then
    begin
      s := s + '   (il.InvoiceNumber IN ' + invoicelist + ') ' + #10;
    end
    else
    begin
      s := s + '   (il.InvoiceNumber = -888) ' + #10;
    end;

    // copyToClipboard(s);
    // DebugMessage('Invoiceheads'#10#10+s);
    ExecutionPlan.AddQuery(s);

    s := '';
    s := s + ' SELECT '#10;
    s := s + '  pm.PayType '#10;
    s := s + ' ,pm.Amount '#10;
    s := s + ' ,date(pm.payDate) AS dtPayDate '#10;
    s := s + ' ,pm.description '#10;
    s := s + ' ,pty.description AS paytypeDescription '#10;
    s := s + ' ,pgr.description AS paygroupDescripion '#10;
    s := s + ' ,IF(pm.typeindex=0,' + _db('Invoice') + ',' + _db('Downpayment')
      + ') AS Medhod '#10;
    s := s + ' FROM payments pm INNER JOIN '#10;
    s := s + '      paytypes pty ON pm.paytype = pty.paytype INNER JOIN '#10;
    s := s + '      paygroups pgr ON pty.paygroup = pgr.paygroup '#10;
    s := s + '  WHERE '#10;
    s := s + '( confirmDate = ' + _dbDateAndTime(confirmDate) + ') ';
    s := s + '  ORDER BY '#10;
    s := s + '    pm.payDate '#10;

    s := '';
    s := s + '  SELECT '#10;
    s := s + '    pm.PayType '#10;
    s := s + '   ,pm.Amount '#10;
    s := s + '   ,date(pm.payDate) AS dtPayDate '#10;
    s := s + '   ,pm.description '#10;
    s := s + '   ,pty.description AS paytypeDescription '#10;
    s := s + '   ,pgr.description AS paygroupDescripion '#10;
    s := s + '   ,pm.invoicenumber '#10;
    s := s + '   ,pm.customer '#10;
    s := s + '   ,pm.reservation '#10;
    s := s + '   ,pm.roomreservation '#10;
    s := s + '   ,(SELECT cu.surname FROM customers cu WHERE cu.customer = pm.customer) as customername '#10;
    s := s + '   ,(SELECT ih.name FROM invoiceheads ih WHERE (ih.invoicenumber = pm.invoicenumber) and (invoicenumber>0) limit 1) as NameOnInvoice '#10;
    s := s + '   ,pm.confirmdate '#10;
    s := s + '   ,IF(pm.typeindex=0,' + _db('Invoice') + ',' +
      _db('Downpayment') + ') AS Medhod '#10;
    // s := s + '   ,IF(pm.typeindex=0,'Invoice','Downpayment') AS Medhod '#10;
    s := s + '  FROM payments pm '#10;
    s := s + '        INNER JOIN paytypes pty ON pm.paytype = pty.paytype '#10;
    s := s + '        INNER JOIN paygroups pgr ON pty.paygroup = pgr.paygroup '#10;
    s := s + '   WHERE '#10;
    s := s + '( confirmDate = ' + _dbDateAndTime(confirmDate) + ') '#10;
    // s := s + '     ( confirmDate = '2014-05-03 14:05:31') '#10;
    s := s + '    ORDER BY '#10;
    s := s + '      pm.payDate '#10;

    // copyToClipboard(s);
    // DebugMessage('Invoiceheads'#10#10+s);
    ExecutionPlan.AddQuery(s);


    // //////////////////// Execute!

    d.kbmTurnover_.DisableControls;
    d.kbmPayments_.DisableControls;
    d.kbmRoomsDateChange_.DisableControls;
    d.kbmpaymentList_.DisableControls;
    d.mInvoiceHeads.DisableControls;
    d.mInvoiceLines.DisableControls;
    try
      ExecutionPlan.Execute(ptQuery);

      /// ///////////////// Turnover

      rset1 := ExecutionPlan.Results[0];
      if d.kbmTurnover_.active then
        d.kbmTurnover_.Close;
      d.kbmTurnover_.open;
      LoadKbmMemtableFromDataSetQuiet(d.kbmTurnover_,rset1, []);
      d.kbmTurnover_.First;

      /// ///////////////// Payments
      rset2 := ExecutionPlan.Results[1];
      if d.kbmPayments_.active then
        d.kbmPayments_.Close;
      d.kbmPayments_.open;
      LoadKbmMemtableFromDataSetQuiet(d.kbmPayments_,rset2, []);
      d.kbmPayments_.First;

      rset3 := ExecutionPlan.Results[2];
      if d.kbmRoomsDateChange_.active then
        d.kbmRoomsDateChange_.Close;
      d.kbmRoomsDateChange_.open;
      LoadKbmMemtableFromDataSetQuiet(d.kbmRoomsDateChange_,rset3, []);
      d.kbmRoomsDateChange_.First;

      rset4 := ExecutionPlan.Results[3];
      if d.kbmInvoiceLinePriceChange_.active then
        d.kbmInvoiceLinePriceChange_.Close;
      d.kbmInvoiceLinePriceChange_.open;
      LoadKbmMemtableFromDataSetQuiet(d.kbmInvoiceLinePriceChange_,rset4, []);
      d.kbmInvoiceLinePriceChange_.First;

      rset5 := ExecutionPlan.Results[4];
      if d.mInvoiceHeads.active then
        d.mInvoiceHeads.Close;
      d.mInvoiceHeads.open;
      LoadKbmMemtableFromDataSetQuiet(d.mInvoiceHeads,rset5, []);
      d.mInvoiceHeads.First;

      rset6 := ExecutionPlan.Results[5];
      if d.mInvoiceLines.active then
        d.mInvoiceLines.Close;
      d.mInvoiceLines.open;
      LoadKbmMemtableFromDataSetQuiet(d.mInvoiceLines,rset6, []);
      d.mInvoiceLines.First;

      rset7 := ExecutionPlan.Results[6];
      if d.kbmpaymentList_.active then
        d.kbmpaymentList_.Close;
      d.kbmpaymentList_.open;
      LoadKbmMemtableFromDataSetQuiet(d.kbmpaymentList_,rset7, []);
      d.kbmpaymentList_.First;

      globals.totalTurnover := 0;
      d.kbmTurnover_.First;
      while not d.kbmTurnover_.eof do
      begin
        globals.totalTurnover := globals.totalTurnover +
          d.kbmTurnover_.FieldByName('amount').asfloat;
        d.kbmTurnover_.Next;
      end;
      d.kbmTurnover_.First;

      globals.totalPayments := 0;
      d.kbmPayments_.First;
      while not d.kbmPayments_.eof do
      begin
        globals.totalPayments := globals.totalPayments +
          d.kbmPayments_.FieldByName('amount').asfloat;
        d.kbmPayments_.Next;
      end;
      d.kbmPayments_.First;

      labTotalTurnover.caption := FloatToStrF(globals.totalTurnover,
        ffCurrency, 8, 2);
      labTotalPayments.caption := FloatToStrF(globals.totalPayments,
        ffCurrency, 8, 2);
      labTotalBalance.caption :=
        FloatToStrF(globals.totalTurnover - globals.totalPayments,
        ffCurrency, 8, 2);

    finally
      d.kbmPayments_.enableControls;
      d.kbmTurnover_.enableControls;
      d.kbmRoomsDateChange_.enableControls;
      d.kbmpaymentList_.enableControls;
      d.mInvoiceHeads.enableControls;
      d.mInvoiceLines.enableControls;
    end;

    stopTick := GetTickCount;
    SQLms := stopTick - startTick;
    //labExecuteTime.caption := inttostr(SQLms);

  finally
    ExecutionPlan.Free;
    screen.Cursor := crDefault;
  end;
end;

procedure TfrmRptTurnoverAndPayments.sButton11Click(Sender: TObject);
var
  sFilename: string;
  s: string;
begin
  if d.kbmInvoiceLinePriceChange_.recordcount = 0 then exit;

  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_confirmedItemPriceChange';
  ExportGridToXLSX(sFilename, grInvoiceLinePriceChange, false, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xlsx'), nil, nil,sw_shownormal);
end;

procedure TfrmRptTurnoverAndPayments.sButton13Click(Sender: TObject);
var
  iReservation: integer;
  iRoomReservation: integer;
begin
  iReservation := d.kbmInvoiceLinePriceChange_.FieldByName('Reservation').asinteger;
  iRoomReservation := d.kbmInvoiceLinePriceChange_.FieldByName('roomReservation').asinteger;

  if EditReservation(iReservation, iRoomReservation) then
  begin
  end;
end;

procedure TfrmRptTurnoverAndPayments.sButton15Click(Sender: TObject);
var
  sFilename: string;
  s: string;
begin
  if d.kbmRoomsDateChange_.recordcount = 0 then exit;

  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_confirmedRoomPriceChange';
  ExportGridToXLSX(sFilename, grRoomsDateChange, false, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xlsx'), nil, nil,sw_shownormal);
end;

procedure TfrmRptTurnoverAndPayments.sButton17Click(Sender: TObject);
var
  iReservation: integer;
  iRoomReservation: integer;
begin
  iReservation := d.kbmRoomsDateChange_.FieldByName('Reservation').asinteger;
  iRoomReservation := d.kbmRoomsDateChange_.FieldByName('roomReservation').asinteger;

  if EditReservation(iReservation, iRoomReservation) then
  begin

  end;
end;

procedure TfrmRptTurnoverAndPayments.sButton19Click(Sender: TObject);
var
  invoicenumber: integer;
  iRoomReservation: integer;
  iReservation: integer;

  Arrival: Tdate;
  Departure: Tdate;
begin
  invoicenumber := d.kbmRoomRentOnInvoice_.FieldByName('InvoiceNumber').asinteger;
  if invoicenumber > 0 then
  begin
    ViewInvoice2(invoicenumber, false, false, false,false, '');
  end
  else
  begin
    iRoomReservation := 0;
    iReservation := 0;
    Arrival := Date;
    Departure := Date;
    iReservation := d.kbmRoomRentOnInvoice_.FieldByName('Reservation').asinteger;
    iRoomReservation := d.kbmRoomRentOnInvoice_.FieldByName('RoomReservation')
      .asinteger;
    EditInvoice(iReservation, iRoomReservation, 0, 0, 0, 0, false, true, false);
  end;
end;


end.
