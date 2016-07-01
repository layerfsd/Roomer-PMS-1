unit uDayFinical;

///////////////////////////////////////////////////////////////
///  2012-12-25 - No functions in uD
///
///////////////////////////////////////////////////////////////


interface

uses
  Windows
  , Messages
  , SysUtils
  , Variants
  , Classes
  , Graphics
  , Controls
  , Forms
  , Dialogs
  , shellapi

  , DB
  , ADODB
  , Mask
  , ExtCtrls
  , StdCtrls
  , Grids
  , BaseGrid
  , ComCtrls
  , Menus

  , hData
  , _Glob
  , ug

  , kbmMemTable

  , dxmdaset
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
  , cxCurrencyEdit
  , cxGridExportLink
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
  , cxGridCustomPopupMenu
  , cxGridPopupMenu
  , cxPropertiesStore
  , cxPCdxBarPopupMenu
  , cxPC
  , cxVGrid
  , cxInplaceContainer
  , cxTextEdit
  , cxDBVGrid
  , cxGridChartView
  , cxGridDBChartView
  , dxPScxExtComCtrlsLnk
  , cxContainer
  , dxPSContainerLnk
  , cxMemo
  , cxRichEdit
  , cxScrollBox
  , cxButtons
  , uUtils
  , cmpRoomerDataSet
  , cmpRoomerConnection, dxSkinsCore, dxSkinCaramel, dxSkinCoffee, dxSkinDarkSide, dxSkinTheAsphaltWorld, dxSkinscxPCPainter,
  dxSkinsdxBarPainter, dxSkinsdxRibbonPainter, ppDB, ppDBPipe, ppParameter, ppDesignLayer, ppBands, ppClass, ppCtrls, ppVar, ppPrnabl,
  ppCache, ppComm, ppRelatv, ppProd, ppReport, sPageControl, sMaskEdit, sCustomComboEdit, sTooledit, sCheckBox, sGroupBox, sButton, sLabel,
  sPanel, dxPScxPivotGridLnk, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinDarkRoom, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue
  ;

type
  TfrmDayFinical = class(TForm)
    LMDStatusBar1: TStatusBar;
    LMDSimplePanel1: TsPanel;
    mainPage: TsPageControl;
    sheetItemSale: TsTabSheet;
    Panel3: TsPanel;
    mItemSale: TdxMemData;
    mItemSaleTotal: TFloatField;
    mItemSaleTotalWoVat: TFloatField;
    mItemSaleTotalVat: TFloatField;
    mItemSaleDescription: TWideStringField;
    mItemSaleAccountKey: TWideStringField;
    mItemSaleItemType: TWideStringField;
    mItemSaleItemTypeDescription: TWideStringField;
    mItemSaleVATCode: TWideStringField;
    tvItemSale: TcxGridDBTableView;
    lvItemSale: TcxGridLevel;
    grItemSale: TcxGrid;
    mItemSaleDS: TDataSource;
    tvItemSaleItemCount: TcxGridDBColumn;
    tvItemSaleTotal: TcxGridDBColumn;
    tvItemSaleTotalWoVat: TcxGridDBColumn;
    tvItemSaleTotalVat: TcxGridDBColumn;
    tvItemSaleDescription: TcxGridDBColumn;
    tvItemSaleAccountKey: TcxGridDBColumn;
    tvItemSaleItemType: TcxGridDBColumn;
    tvItemSaleItemTypeDescription: TcxGridDBColumn;
    tvItemSaleVATCode: TcxGridDBColumn;
    mItemSaleItem: TWideStringField;
    tvItemSaleItem: TcxGridDBColumn;
    SheetInvoicelist: TsTabSheet;
    Panel4: TsPanel;
    mInvoiceLines: TdxMemData;
    mInvoiceHeads: TdxMemData;
    mInvoiceHeadsDS: TDataSource;
    mInvoiceLinesDS: TDataSource;
    grInvoicelist: TcxGrid;
    tvInvoiceHeads: TcxGridDBTableView;
    tvInvoiceLines: TcxGridDBTableView;
    lvInvoiceHeads: TcxGridLevel;
    lvInvoiceLines: TcxGridLevel;
    mInvoiceHeadsReservation: TIntegerField;
    mInvoiceHeadsRoomReservation: TIntegerField;
    mInvoiceHeadsSplitNumber: TIntegerField;
    mInvoiceHeadsInvoiceNumber: TIntegerField;
    mInvoiceHeadsCustomer: TWideStringField;
    mInvoiceHeadsNameOnInvoice: TWideStringField;
    mInvoiceHeadsAddress1: TWideStringField;
    mInvoiceHeadsAddress2: TWideStringField;
    mInvoiceHeadsAddress3: TWideStringField;
    mInvoiceHeadsihAmountWithTax: TFloatField;
    mInvoiceHeadsihAmountNoTax: TFloatField;
    mInvoiceHeadsihAmountTax: TFloatField;
    mInvoiceHeadsCreditInvoice: TIntegerField;
    mInvoiceHeadsOriginalInvoice: TIntegerField;
    mInvoiceHeadsRoomGuest: TWideStringField;
    mInvoiceHeadsInvoiceDate: TDateTimeField;
    mInvoiceHeadsdueDate: TDateTimeField;
    mInvoiceHeadsinvRefrence: TWideStringField;
    tvInvoiceHeadsRecId: TcxGridDBColumn;
    tvInvoiceHeadsReservation: TcxGridDBColumn;
    tvInvoiceHeadsRoomReservation: TcxGridDBColumn;
    tvInvoiceHeadsSplitNumber: TcxGridDBColumn;
    tvInvoiceHeadsInvoiceNumber: TcxGridDBColumn;
    tvInvoiceHeadsCustomer: TcxGridDBColumn;
    tvInvoiceHeadsNameOnInvoice: TcxGridDBColumn;
    tvInvoiceHeadsAddress1: TcxGridDBColumn;
    tvInvoiceHeadsAddress2: TcxGridDBColumn;
    tvInvoiceHeadsAddress3: TcxGridDBColumn;
    tvInvoiceHeadsihAmountWithTax: TcxGridDBColumn;
    tvInvoiceHeadsihAmountNoTax: TcxGridDBColumn;
    tvInvoiceHeadsihAmountTax: TcxGridDBColumn;
    tvInvoiceHeadsCreditInvoice: TcxGridDBColumn;
    tvInvoiceHeadsOriginalInvoice: TcxGridDBColumn;
    tvInvoiceHeadsRoomGuest: TcxGridDBColumn;
    tvInvoiceHeadsInvoiceDate: TcxGridDBColumn;
    tvInvoiceHeadsdueDate: TcxGridDBColumn;
    tvInvoiceHeadsinvRefrence: TcxGridDBColumn;
    sheetPayments: TsTabSheet;
    Panel5: TsPanel;
    mInvoiceLinesPurchaseDate: TWideStringField;
    mInvoiceLinesItem: TWideStringField;
    mInvoiceLinesDescription: TWideStringField;
    mInvoiceLinesPrice: TFloatField;
    mInvoiceLinesVATType: TWideStringField;
    mInvoiceLinesilAmountWithTax: TFloatField;
    mInvoiceLinesilAmountNoTax: TFloatField;
    mInvoiceLinesilAmountTax: TFloatField;
    mInvoiceLinesCurrency: TWideStringField;
    mInvoiceLinesCurrencyRate: TFloatField;
    mInvoiceLinesImportRefrence: TWideStringField;
    mInvoiceLinesImportSource: TWideStringField;
    tvInvoiceLinesRecId: TcxGridDBColumn;
    tvInvoiceLinesPurchaseDate: TcxGridDBColumn;
    tvInvoiceLinesItem: TcxGridDBColumn;
    tvInvoiceLinesQuantity: TcxGridDBColumn;
    tvInvoiceLinesDescription: TcxGridDBColumn;
    tvInvoiceLinesPrice: TcxGridDBColumn;
    tvInvoiceLinesVATType: TcxGridDBColumn;
    tvInvoiceLinesilAmountWithTax: TcxGridDBColumn;
    tvInvoiceLinesilAmountNoTax: TcxGridDBColumn;
    tvInvoiceLinesilAmountTax: TcxGridDBColumn;
    tvInvoiceLinesCurrency: TcxGridDBColumn;
    tvInvoiceLinesCurrencyRate: TcxGridDBColumn;
    tvInvoiceLinesImportRefrence: TcxGridDBColumn;
    tvInvoiceLinesImportSource: TcxGridDBColumn;
    mInvoiceLinesInvoiceNumber: TIntegerField;
    tvInvoiceLinesInvoiceNumber: TcxGridDBColumn;
    mInvoiceHeadsisKredit: TBooleanField;
    tvInvoiceHeadsisKredit: TcxGridDBColumn;
    mInvoiceHeadsisGroup: TBooleanField;
    tvInvoiceHeadsisGroup: TcxGridDBColumn;
    mInvoiceHeadsisCash: TBooleanField;
    tvInvoiceHeadsisCash: TcxGridDBColumn;
    mPaymentsDS: TDataSource;
    tvPayments: TcxGridDBTableView;
    lvPayments: TcxGridLevel;
    grPayments: TcxGrid;
    tvPaymentsRecId: TcxGridDBColumn;
    tvPaymentsReservation: TcxGridDBColumn;
    tvPaymentsRoomReservation: TcxGridDBColumn;
    tvPaymentsInvoiceNumber: TcxGridDBColumn;
    tvPaymentsCustomer: TcxGridDBColumn;
    tvPaymentsAmount: TcxGridDBColumn;
    tvPaymentsCurrency: TcxGridDBColumn;
    tvPaymentsCurrencyRate: TcxGridDBColumn;
    tvPaymentsPayType: TcxGridDBColumn;
    tvPaymentsInvoiceDate: TcxGridDBColumn;
    tvPaymentsPayTypeDescription: TcxGridDBColumn;
    tvPaymentspayGroupDescription: TcxGridDBColumn;
    tvPaymentsPayGroup: TcxGridDBColumn;
    sheetPaymentType: TsTabSheet;
    Panel1: TsPanel;
    tvPaymentType: TcxGridDBTableView;
    lvPaymentType: TcxGridLevel;
    grPaymentType: TcxGrid;
    mPaymentTypes: TdxMemData;
    mPaymentTypesDS: TDataSource;
    mPaymentTypesInvoiceCount: TIntegerField;
    mPaymentTypesAmount: TFloatField;
    mPaymentTypesPayType: TWideStringField;
    mPaymentTypesPayTypeDescription: TWideStringField;
    tvPaymentTypeRecId: TcxGridDBColumn;
    tvPaymentTypeInvoiceCount: TcxGridDBColumn;
    tvPaymentTypeAmount: TcxGridDBColumn;
    tvPaymentTypePayType: TcxGridDBColumn;
    tvPaymentTypePayTypeDescription: TcxGridDBColumn;
    mPaymentTypesCustomercount: TIntegerField;
    mPaymentTypesPayGroup: TWideStringField;
    tvPaymentTypePayGroup: TcxGridDBColumn;
    grPrinter: TdxComponentPrinter;
    grMenuInvoicelist: TcxGridPopupMenu;
    sheetSums: TsTabSheet;
    mSums: TdxMemData;
    mSumsid: TIntegerField;
    mSumsCode: TWideStringField;
    mSumsDescription: TWideStringField;
    mSumsSale: TFloatField;
    mSumsPayment: TFloatField;
    mSumsDS: TDataSource;
    mItemTypeSale: TdxMemData;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    WideStringField3: TWideStringField;
    WideStringField4: TWideStringField;
    WideStringField5: TWideStringField;
    mItemTypeSaleDS: TDataSource;
    sheetItemTypeSale: TsTabSheet;
    Panel7: TsPanel;
    grItemTypeSale: TcxGrid;
    tvItemTypeSale: TcxGridDBTableView;
    lvItemTypeSale: TcxGridLevel;
    tvItemTypeSaleRecId: TcxGridDBColumn;
    tvItemTypeSaleItemType: TcxGridDBColumn;
    tvItemTypeSaleItemTypeDescription: TcxGridDBColumn;
    tvItemTypeSaleItemCount: TcxGridDBColumn;
    tvItemTypeSaleTotal: TcxGridDBColumn;
    tvItemTypeSaleTotalWoVat: TcxGridDBColumn;
    tvItemTypeSaleTotalVat: TcxGridDBColumn;
    tvItemTypeSaleVATCode: TcxGridDBColumn;
    mPaymentGroups: TdxMemData;
    IntegerField2: TIntegerField;
    FloatField4: TFloatField;
    WideStringField6: TWideStringField;
    mPaymentGroupsDS: TDataSource;
    sheetPaymentGroups: TsTabSheet;
    Panel8: TsPanel;
    grPaymentGroups: TcxGrid;
    tvPaymentGroups: TcxGridDBTableView;
    lvPaymentGroups: TcxGridLevel;
    tvPaymentGroupsRecId: TcxGridDBColumn;
    tvPaymentGroupsInvoiceCount: TcxGridDBColumn;
    tvPaymentGroupsAmount: TcxGridDBColumn;
    tvPaymentGroupsPayGroup: TcxGridDBColumn;
    mPaymentGroupsDescription: TWideStringField;
    tvPaymentGroupsDescription: TcxGridDBColumn;
    Panel9: TsPanel;
    Panel10: TsPanel;
    Panel11: TsPanel;
    Panel12: TsPanel;
    mSums2: TdxMemData;
    IntegerField3: TIntegerField;
    WideStringField1: TWideStringField;
    WideStringField2: TWideStringField;
    FloatField5: TFloatField;
    FloatField6: TFloatField;
    mSums2DS: TDataSource;
    cxDBVerticalGrid1: TcxDBVerticalGrid;
    mHead: TdxMemData;
    mHeadCompany: TStringField;
    mHeadStaff: TStringField;
    mHeadDateFrom: TDateField;
    mHeadDateTo: TDateField;
    mHeadDS: TDataSource;
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
    mInvoiceHeadsTotalStayTax: TFloatField;
    mInvoiceHeadsTotalStayTaxNights: TIntegerField;
    tvInvoiceHeadsTotalStayTax: TcxGridDBColumn;
    tvInvoiceHeadsTotalStayTaxNights: TcxGridDBColumn;
    mInvoiceHeadsisRoom: TBooleanField;
    tvInvoiceHeadsisRoom: TcxGridDBColumn;
    mHeadRoomInvoiceCount: TIntegerField;
    mHeadGroupInvoiceCount: TIntegerField;
    mHeadKeditInvoiceCount: TIntegerField;
    mHeadCashInvoiceCount: TIntegerField;
    pageSums: TsPageControl;
    sheetSums2: TsTabSheet;
    sheetSums3: TsTabSheet;
    grSums: TcxGrid;
    tvSums: TcxGridDBTableView;
    tvSumsid: TcxGridDBColumn;
    tvSumsCode: TcxGridDBColumn;
    tvSumsDescription: TcxGridDBColumn;
    tvSumsSale: TcxGridDBColumn;
    tvSumsPayment: TcxGridDBColumn;
    lvSums: TcxGridLevel;
    cxDBVerticalGrid1RecId: TcxDBEditorRow;
    cxDBVerticalGrid1Company: TcxDBEditorRow;
    cxDBVerticalGrid1Staff: TcxDBEditorRow;
    cxDBVerticalGrid1DateFrom: TcxDBEditorRow;
    cxDBVerticalGrid1DateTo: TcxDBEditorRow;
    cxDBVerticalGrid1DateCount: TcxDBEditorRow;
    cxDBVerticalGrid1SaleAmount: TcxDBEditorRow;
    cxDBVerticalGrid1SaleAmountWoVAT: TcxDBEditorRow;
    cxDBVerticalGrid1VATAmount: TcxDBEditorRow;
    cxDBVerticalGrid1InvoiceCount: TcxDBEditorRow;
    cxDBVerticalGrid1SalePerDay: TcxDBEditorRow;
    cxDBVerticalGrid1SalePerInvoice: TcxDBEditorRow;
    cxDBVerticalGrid1PaymentAmount: TcxDBEditorRow;
    cxDBVerticalGrid1PaymentCount: TcxDBEditorRow;
    cxDBVerticalGrid1LodgingNights: TcxDBEditorRow;
    cxDBVerticalGrid1LodgingTax: TcxDBEditorRow;
    cxDBVerticalGrid1RoomInvoiceCount: TcxDBEditorRow;
    cxDBVerticalGrid1GroupInvoiceCount: TcxDBEditorRow;
    cxDBVerticalGrid1KeditInvoiceCount: TcxDBEditorRow;
    cxDBVerticalGrid1CashInvoiceCount: TcxDBEditorRow;
    cxDBVerticalGrid1CategoryRow1: TcxCategoryRow;
    cxDBVerticalGrid1CategoryRow2: TcxCategoryRow;
    cxDBVerticalGrid1CategoryRow3: TcxCategoryRow;
    cxDBVerticalGrid1CategoryRow4: TcxCategoryRow;
    cxDBVerticalGrid1CategoryRow5: TcxCategoryRow;
    grPrinterSums2: TdxGridReportLink;
    grPrinterSums: TdxGridReportLink;
    grSums2: TcxGrid;
    tvSums2: TcxGridDBTableView;
    tvSums2RecId: TcxGridDBColumn;
    tvSums2id: TcxGridDBColumn;
    tvSums2Code: TcxGridDBColumn;
    tvSums2Description: TcxGridDBColumn;
    tvSums2Sale: TcxGridDBColumn;
    tvSums2Payment: TcxGridDBColumn;
    lvSums2: TcxGridLevel;
    mItemVATsale: TdxMemData;
    FloatField7: TFloatField;
    FloatField8: TFloatField;
    FloatField9: TFloatField;
    WideStringField9: TWideStringField;
    mItemVATsaleDS: TDataSource;
    mItemVATsaleDescription: TWideStringField;
    sheetItemVATsale: TsTabSheet;
    Panel13: TsPanel;
    grItemVATsale: TcxGrid;
    tvItemVATsale: TcxGridDBTableView;
    lvItemVATsale: TcxGridLevel;
    tvItemVATsaleRecId: TcxGridDBColumn;
    tvItemVATsaleItemCount: TcxGridDBColumn;
    tvItemVATsaleTotal: TcxGridDBColumn;
    tvItemVATsaleTotalWoVat: TcxGridDBColumn;
    tvItemVATsaleTotalVat: TcxGridDBColumn;
    tvItemVATsaleVATCode: TcxGridDBColumn;
    tvItemVATsaleDescription: TcxGridDBColumn;
    mItemVATsaleVATPercentage: TFloatField;
    tvItemVATsaleVATPercentage: TcxGridDBColumn;
    grMenuItemSale: TcxGridPopupMenu;
    grMenuItemTypeSale: TcxGridPopupMenu;
    grMenuItemVATsale: TcxGridPopupMenu;
    grMenuPaymentGroups: TcxGridPopupMenu;
    grMenuPayments: TcxGridPopupMenu;
    grMenuPaymentType: TcxGridPopupMenu;
    pmnuLayout: TPopupMenu;
    All1: TMenuItem;
    Current1: TMenuItem;
    mnuLayoutSaveAll: TMenuItem;
    mnuLayoutRestoreAll: TMenuItem;
    mnuLayoutSaveCurrent: TMenuItem;
    mnuLayoutRestoreCurrent: TMenuItem;
    btnRefresh: TsButton;
    cxButton1: TsButton;
    cxButton2: TsButton;
    grPrinterInvoicelist: TdxGridReportLink;
    grPrinterItemSale: TdxGridReportLink;
    grPrinterItemTypeSale: TdxGridReportLink;
    grPrinterItemVATsale: TdxGridReportLink;
    grPrinterPaymentGroups: TdxGridReportLink;
    grPrinterPayments: TdxGridReportLink;
    grPrinterPaymentType: TdxGridReportLink;
    grPrinterLink1: TdxCompositionReportLink;
    tvPaymentsPayDate: TcxGridDBColumn;
    tvPaymentsNameOnInvoice: TcxGridDBColumn;
    tvPaymentsihConfirmDate: TcxGridDBColumn;
    tvPaymentsSplitNumber: TcxGridDBColumn;
    tvPaymentsRoomGuest: TcxGridDBColumn;
    tvPaymentsCustomerName: TcxGridDBColumn;
    tvPaymentsisAgency: TcxGridDBColumn;
    tvPaymentsisRoom: TcxGridDBColumn;
    tvPaymentsisGroup: TcxGridDBColumn;
    tvPaymentsisKredit: TcxGridDBColumn;
    tvPaymentsisCash: TcxGridDBColumn;
    gbxSelectDates: TsGroupBox;
    LMDSimpleLabel1: TsLabel;
    LMDSimpleLabel2: TsLabel;
    dtDate: TsDateEdit;
    dtDateTo: TsDateEdit;
    GroupBox1: TsGroupBox;
    chkGetUnconfirmed: TsCheckBox;
    btnConfirm: TsButton;
    getConfirmGroup: TsButton;
    mInvoiceHeadsConfirmedDate: TDateTimeField;
    mInvoiceHeadsCurrency: TWideStringField;
    mInvoiceHeadsRate: TFloatField;
    mInvoiceHeadsStaff: TWideStringField;
    mInvoiceHeadsCustomerName: TWideStringField;
    mInvoiceHeadsisAgency: TBooleanField;
    mInvoiceHeadsmarkedSegment: TWideStringField;
    mInvoiceHeadsmarkedSegmentDescription: TWideStringField;
    tvInvoiceHeadsConfirmedDate: TcxGridDBColumn;
    tvInvoiceHeadsCurrency: TcxGridDBColumn;
    tvInvoiceHeadsRate: TcxGridDBColumn;
    tvInvoiceHeadsStaff: TcxGridDBColumn;
    tvInvoiceHeadsCustomerName: TcxGridDBColumn;
    tvInvoiceHeadsisAgency: TcxGridDBColumn;
    tvInvoiceHeadsmarkedSegment: TcxGridDBColumn;
    tvInvoiceHeadsmarkedSegmentDescription: TcxGridDBColumn;
    chkOneday: TsCheckBox;
    mnuFinishedInv: TPopupMenu;
    mnuThisRoom: TMenuItem;
    mnuThisreservation: TMenuItem;
    OpenthisRoom1: TMenuItem;
    OpenGroupInvoice1: TMenuItem;
    btnSwitchToDates: TsButton;
    StoreMain: TcxPropertiesStore;
    btnPaymentReport: TsButton;
    rptbPayments: TppReport;
    ppParameterList1: TppParameterList;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    kbmReportDS: TDataSource;
    ppSystemVariable1: TppSystemVariable;
    ppDBText4: TppDBText;
    ppLabel5: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppPayments: TppDBPipeline;
    dxMemData1: TdxMemData;
    IntegerField5: TIntegerField;
    IntegerField6: TIntegerField;
    IntegerField7: TIntegerField;
    WideStringField7: TWideStringField;
    WideStringField8: TWideStringField;
    FloatField10: TFloatField;
    WideStringField10: TWideStringField;
    FloatField11: TFloatField;
    WideStringField11: TWideStringField;
    WideStringField12: TWideStringField;
    WideStringField13: TWideStringField;
    WideStringField14: TWideStringField;
    WideStringField15: TWideStringField;
    WideStringField16: TWideStringField;
    DateTimeField1: TDateTimeField;
    IntegerField8: TIntegerField;
    WideStringField17: TWideStringField;
    WideStringField18: TWideStringField;
    BooleanField1: TBooleanField;
    BooleanField2: TBooleanField;
    BooleanField3: TBooleanField;
    BooleanField4: TBooleanField;
    BooleanField5: TBooleanField;
    DateTimeField2: TDateTimeField;
    mPayments: TkbmMemTable;
    kbmReport: TkbmMemTable;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText5: TppDBText;
    ppDBText7: TppDBText;
    ppLabel6: TppLabel;
    ppDBText8: TppDBText;
    ppDBText17: TppDBText;
    ppDBText18: TppDBText;
    ppDBCalc1: TppDBCalc;
    ppSummaryBand1: TppSummaryBand;
    ppLine1: TppLine;
    ppLine2: TppLine;
    ppDBCalc2: TppDBCalc;
    ppLine3: TppLine;
    ppLabel19: TppLabel;
    ppDBCalc3: TppDBCalc;
    ppLabel20: TppLabel;
    ppDBText6: TppDBText;
    ppShape1: TppShape;
    ppLabel21: TppLabel;
    ppLabel22: TppLabel;
    ppLine4: TppLine;
    ppLine5: TppLine;
    ppLine6: TppLine;
    ppLine7: TppLine;
    ppLine8: TppLine;
    mItemSaleItemCount: TFloatField;         //-96
    mItemVATsaleItemCount: TFloatField;      //-96
    mInvoiceLinesQuantity: TFloatField;
    mItemTypeSaleItemCount: TFloatField;
    tvPaymentsaDate: TcxGridDBColumn;
    tvPaymentscurrencyAmount: TcxGridDBColumn;
    labLocations: TsLabel;
    __labLocationsList: TsLabel;
    pnlButtons: TsPanel;
    cxButton3: TsButton;
    btnPrint: TsButton;
    btnShowReservation: TsButton;
    btnShowGuests: TsButton;
    btnShowSelectedInvoice: TsButton;
    btnShowInvoice: TsButton;      //-96
    procedure FormCreate(Sender : TObject);
    procedure FormShow(Sender : TObject);
    procedure FormClose(Sender : TObject; var Action : TCloseAction);
    procedure btnRefreshClick(Sender : TObject);
    procedure mInvoiceHeadsCalcFields(DataSet: TDataSet);
    procedure tvInvoiceHeadsDataControllerSummaryAfterSummary(ASender: TcxDataSummary);
    procedure mainPageChange(Sender: TObject);
    procedure mnuLayoutSaveAllClick(Sender: TObject);
    procedure mnuLayoutRestoreAllClick(Sender: TObject);
    procedure mnuLayoutSaveCurrentClick(Sender: TObject);
    procedure mnuLayoutRestoreCurrentClick(Sender: TObject);
    procedure btnExcel(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnShowReservationClick(Sender: TObject);
    procedure mPaymentsCalcFields(DataSet: TDataSet);
    procedure chkGetUnconfirmedClick(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
    procedure btnShowRoomClick(Sender: TObject);
    procedure btnShowGuestsClick(Sender: TObject);
    procedure btnShowSelectedInvoiceClick(Sender: TObject);
    procedure mnuThisRoomClick(Sender: TObject);
    procedure mnuThisreservationClick(Sender: TObject);
    procedure OpenthisRoom1Click(Sender: TObject);
    procedure OpenGroupInvoice1Click(Sender: TObject);
    procedure getConfirmGroupClick(Sender: TObject);
    procedure btnSwitchToDatesClick(Sender: TObject);
    procedure chkOnedayClick(Sender: TObject);
    procedure btnPaymentReportClick(Sender: TObject);
    procedure tvSums2SaleGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvSums2PaymentGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvSumsSaleGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvSumsPaymentGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvInvoiceHeadsihAmountWithTaxGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvInvoiceHeadsihAmountNoTaxGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvInvoiceHeadsihAmountTaxGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvInvoiceLinesPriceGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvInvoiceLinesilAmountWithTaxGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvInvoiceLinesilAmountNoTaxGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvInvoiceLinesilAmountTaxGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvItemSaleTotalGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvItemSaleTotalWoVatGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvItemSaleTotalVatGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvItemTypeSaleTotalGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvItemTypeSaleTotalWoVatGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvItemTypeSaleTotalVatGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvItemVATsaleTotalGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvItemVATsaleTotalWoVatGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvItemVATsaleTotalVatGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvPaymentsAmountGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvPaymentTypeAmountGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvPaymentGroupsAmountGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    zIsOneDay : Boolean;
    zDate : TDate;
    sDatefrom : string;
    sDateTo : string;

    zSQLInText : string;
    zIsConfirmed : boolean;

    zConfirmState : integer;
    zConfirmedDate : TdateTime;

    zDoChkEvent    : boolean;

    zLocationInString : string;

    procedure SwitchToDates;

    function CreateSQLInText(list : TstringList) : string;

    procedure GetInvoicelist;
    procedure GetItemSale;
    procedure GetItemTypeSale;
    procedure GetItemVATsale;
    procedure getPayments;
    procedure getPaymentType;
    procedure getPaymentGroup;
    procedure getSums;
    procedure getSums2;
    procedure getHeader;
    procedure ClearAllData;
    procedure GetAll(clearData : boolean); // Clear Previuss if empty data

    function getTotal_ihAmountWithTax : double;
    function getTotal_ihAmountWoVAT : double;
    function getTotal_ihAmountVAT : double;
    function getTotal_ihInvoiceCount : integer;
    function getTotal_PaymentAmount : double;
    function getTotal_PaymentCount : integer;
    function getTotal_LodgingNights : integer;
    function getTotal_LodgingTax : double;
    function getTotal_RoomInvoiceCount : integer;
    function getTotal_GroupInvoiceCount : integer;
    function getTotal_KeditInvoiceCount : integer;
    function getTotal_CashInvoiceCount : integer;

    procedure GridLayoutRestoreAll;
    procedure GridLayoutSaveAll;

    procedure GridLayoutSave(tv : TcxGridDBTableView);
    procedure GridLayoutRestore(tv : TcxGridDBTableView);

  public
    { Public declarations }

  end;

var
  frmDayFinical : TfrmDayFinical;

implementation

uses
   uD
  ,uReservationProfile
  ,uFinishedInvoices2
  ,uInvoice
  ,uGuestProfile2
  ,uSqlDefinitions
  , uRptbViewer
  , uAppGlobal
  , PrjConst
  , uDImages
  , uMain;


{$R *.dfm}




function TfrmDayFinical.CreateSQLInText(list : TstringList) : string;
var
  i : integer;
  s : string;
begin
  result  := '';
  s := '';
  for i := 0 to list.Count - 1 do
  begin
    s := s+list[i]+',';
  end;

  if length(s) > 0 then
  begin
    delete(s,length(s),1);
    result := '('+s+')';
  end;
end;



procedure TfrmDayFinical.cxButton1Click(Sender: TObject);
begin
  tvInvoiceHeads.ViewData.Expand(true);
end;

procedure TfrmDayFinical.cxButton2Click(Sender: TObject);
begin
  tvInvoiceHeads.ViewData.Collapse(true);
end;

procedure TfrmDayFinical.FormCreate(Sender : TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
   glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  // **
  dtDate.date := date - 1;
  dtDateTo.date := date - 1;
  zIsOneDay := chkOneday.Checked;
  dtDateTo.Visible := not zIsOneDay;
  LMDSimpleLabel2.Visible := dtDateTo.Visible;
  GridLayoutRestoreAll;
  zIsConfirmed := false;
  zConfirmState := 0;
  zConfirmedDate := 0;
  zDoChkEvent := true;
end;

procedure TfrmDayFinical.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmDayFinical.FormShow(Sender : TObject);
begin
//  GetAll;
  btnShowReservation.Enabled := false;
  btnShowGuests.Enabled := false;
  getConfirmGroup.Enabled := false;
  btnShowSelectedInvoice.Enabled := false;
  btnShowInvoice.Enabled := false;

  mainPage.ActivePageIndex := 0;
  pageSums.ActivePageIndex := 0;


  zLocationInString := glb.LocationSQLInString(frmmain.FilteredLocations);

  if zLocationInString = '' then
  begin
    __labLocationsList.caption := 'All Locations';
  end else
  begin
    __labLocationsList.caption := zLocationInString;
  end;


end;

procedure TfrmDayFinical.FormClose(Sender : TObject; var Action : TCloseAction);
begin
// **
//  store.StoreTo(false);
end;


procedure TfrmDayFinical.ClearAllData;
begin

  if mSums.Active then
  begin
    mSums.Close;
    mSums.Open;
  end;

  if mSums2.Active then
  begin
    mSums2.Close;
    mSums2.Open;
  end;

  if mItemVATsale.Active then
  begin
    mItemVATsale.Close;
    mItemVATsale.Open;
  end;


  if mPayments.Active then
  begin
    mPayments.Close;
    mPayments.Open;
  end;

  if mItemSale.Active then
  begin
    mItemSale.Close;
    mItemSale.Open;
  end;

  if mHead.Active then
  begin
    mHead.Close;
    mHead.Open;
  end;

  if mPaymentTypes.Active then
  begin
    mPaymentTypes.Close;
    mPaymentTypes.Open;
  end;

  if mInvoiceLines.Active then
  begin
    mInvoiceLines.Close;
    mInvoiceLines.Open;
  end;

  if mInvoiceHeads.Active then
  begin
    mInvoiceHeads.Close;
    mInvoiceHeads.Open;
  end;

  if mItemTypeSale.Active then
  begin
    mItemTypeSale.Close;
    mItemTypeSale.Open;
  end;

  if mPaymentGroups.Active then
  begin
    mPaymentGroups.Close;
    mPaymentGroups.Open;
  end;
end;


procedure TfrmDayFinical.GetAll(clearData : boolean);
var
  lst : TStringList;
  dateFrom : TDate;
  dateTo   : TDate;
  s        : string;

  inLocation : string;

begin
  if ClearData then ClearAllData;
  inLocation := zLocationInString ;



  screen.cursor := crHourGlass;
  try
    if zConfirmState = 1 then
    begin
      dateFrom := 2;
      dateTo   := 2;
      lst := invoiceList_Unconfirmed(inlocation);
      try
        zSQLInText := CreateSQLInText(lst);
      finally
        freeandNil(lst);
      end;
      if zSQLInText = '' then
      begin
		     showmessage(GetTranslatedText('shTx_DayFinical_NoInvoices'));
         exit;
      end;
    end else
    if zConfirmState = 0 then
    begin
      dateFrom := trunc(dtDate.date);
      dateTo   := trunc(dtDateTo.date);
      if zIsOneDay then
      begin
        dateTo := dateFrom;
      end;

      lst := invoiceList_FromTo(DateFrom,DateTo,inlocation);
      try
        zSQLInText := CreateSQLInText(lst);
      finally
        freeandNil(lst);
      end;

      if zSQLInText = '' then
      begin
		    showmessage(format(GetTranslatedText('shTx_DayFinical_NoInvoicesForFromToDate'), [dateToStr(dateFrom), dateToStr(DateTo)]));
        exit;
      end;
    end else
    if zConfirmState = 2 then
    begin
      dateFrom := 2;
      dateTo   := 2;
      lst := invoiceList_ConfirmGroup(zConfirmedDate);
      try
        zSQLInText := CreateSQLInText(lst);
      finally
        freeandNil(lst);
      end;
      if zSQLInText = '' then
      begin
        dateTimeTostring(s,'dd.mm.yyyy hh:NN:ss',zConfirmedDate);
		    showmessage(format(GetTranslatedText('shTx_DayFinical_NoConfirmedInvoicesFor'), [s]));
        exit;
      end;
    end;

    GetItemSale;
    GetItemTypeSale;
    GetItemVATsale;
    GetInvoiceList;
    GetPayments;
    getPaymentType;
    getPaymentGroup;
    getSums;
    getSums2;
    getHeader;
  finally
    screen.cursor := crDefault;
  end;
end;

procedure TfrmDayFinical.btnRefreshClick(Sender : TObject);
begin
  GetAll(true);
end;


procedure TfrmDayFinical.chkGetUnconfirmedClick(Sender: TObject);
begin
  if zDoChkEvent then
  begin
    if chkGetUnconfirmed.Checked then
    begin
      zConfirmState := 1;
      gbxSelectDates.visible := false;
      btnConfirm.visible := true;
      GetAll(true);
    end else
    begin
      SwitchToDates;
    end;
  end;

end;

procedure TfrmDayFinical.chkOnedayClick(Sender: TObject);
begin
  zIsOneDay := chkOneday.Checked;
  dtDateTo.Visible := not zIsOneDay;
  LMDSimpleLabel2.Visible := dtDateTo.Visible;
end;

/////////////////////////////////////////////
// Sums


//////////////////////////////////////////////////////
// Sale by invoice

///////////////////////////////////////////////////////////////////
// ItemSale


////////////////////////////////////////////////////////////////////
// Item Type


/////////////////////////////////////////////////////////////////////////
// Payments


///////////////////////////////////////////////////////////////////
//  Payment Type


/////////////////////////////////////////////////////////////
// Payment Group


///////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////





//////////////////////////////////////////////////////////////////////////////////
///
//////////////////////////////////////////////////////////////////////////////////

procedure TfrmDayFinical.GetItemSale;
var
  s    : string;
  rSet : TRoomerDataSet;
  sql  : string;
begin

  rSet := CreateNewDataSet;
  try
    screen.Cursor := crHourGlass;
    try
       sql :=
        ' SELECT '+
        '     invoicelines.ItemID AS Item '+
        '   , SUM(invoicelines.Number) AS ItemCount '+
        '   , SUM(invoicelines.Total) AS Total '+
        '   , SUM(invoicelines.TotalWOVat) AS TotalWoVat '+
        '   , SUM(invoicelines.Vat) AS TotalVat '+
        '   , items.Description '+
        '   , items.AccountKey '+
        '   , itemtypes.Itemtype '+
        '   , itemtypes.Description AS ItemTypeDescription '+
        '   , itemtypes.VATCode '+
        ' FROM '+
        '   itemtypes '+
        '     INNER JOIN items ON itemtypes.Itemtype = items.Itemtype '+
        '     RIGHT OUTER JOIN invoicelines ON items.Item = invoicelines.ItemID '+
        ' WHERE '+
        '   (invoicelines.InvoiceNumber IN %s ) '+
        ' GROUP BY '+
        '     invoicelines.ItemID '+
        '   , items.Description '+
        '   , items.AccountKey '+
        '   , itemtypes.Itemtype '+
        '   , itemtypes.Description '+
        '   , itemtypes.VATCode ' ;

      s := format(sql,[zSqlInText]);
      hData.rSet_bySQL(rSet,s);

      mItemSale.DisableControls;
      try
        if mItemSale.Active then mItemSale.Close;
        mItemSale.LoadFromDataSet(rSet);
        mItemSale.First;
      finally
        mItemSale.EnableControls;
      end;
    finally
      screen.Cursor := crDefault;
    end;
  finally
    freeandNil(rSet);
  end;
end;

procedure TfrmDayFinical.GetItemTypeSale;
var
  s : string;
  rSet : TRoomerDataSet;
  sql : string;
begin
  rSet := CreateNewDataSet;
  try
    screen.Cursor := crHourGlass;
    try
      sql :=
      ' SELECT '+
      '      SUM(invoicelines.Number) AS ItemCount '+
      '    , SUM(invoicelines.Total) AS Total '+
      '    , SUM(invoicelines.TotalWOVat) AS TotalWoVat '+
      '    , SUM(invoicelines.Vat) AS TotalVat '+
      '    , itemtypes.Itemtype '+
      '    , itemtypes.Description AS ItemTypeDescription '+
      '    , itemtypes.VATCode '+
      ' FROM '+
      '    itemtypes '+
      '       INNER JOIN items ON itemtypes.Itemtype = items.Itemtype '+
      '       RIGHT OUTER JOIN invoicelines ON items.Item = invoicelines.ItemID '+
      ' WHERE '+
      '   (invoicelines.InvoiceNumber IN  %s ) '+
      ' GROUP BY '+
      '     itemtypes.Itemtype '+
      '  ,  itemtypes.Description '+
      '  ,  itemtypes.VATCode ' ;

      s := format(sql , [zSqlInText]);
      hData.rSet_bySQL(rSet,s);
      mItemTypeSale.DisableControls;
      try
        if mItemTypeSale.Active then mItemTypeSale.Close;
        mItemTypeSale.LoadFromDataSet(rSet);
        mItemTypeSale.First;
      finally
        mItemTypeSale.EnableControls;
      end;
    finally
      screen.Cursor := crDefault;
    end;
  finally
    freeandNil(rSet);
  end;
end;


procedure TfrmDayFinical.GetItemVATsale;
var
  s : string;
  rSet : TRoomerDataSet;
  sql : string;
begin
  s := '';
  rSet := CreateNewDataSet;
  try
    screen.Cursor := crHourGlass;
    try
      sql :=
       ' SELECT '+
       '     SUM(invoicelines.Number) AS ItemCount '+
       '   , SUM(invoicelines.Total) AS Total '+
       '   , SUM(invoicelines.TotalWOVat) AS TotalWoVat '+
       '   , SUM(invoicelines.Vat) AS TotalVat '+
       '   , vatcodes.VATCode '+
       '   , vatcodes.Description '+
       '   , vatcodes.VATPercentage '+
       ' FROM '+
       '     invoicelines '+
       '     LEFT OUTER JOIN vatcodes ON invoicelines.VATType = vatcodes.VATCode '+


//       '   itemtypes '+
//       '     RIGHT OUTER JOIN items ON itemtypes.Itemtype = items.Itemtype '+
//       '     LEFT OUTER JOIN vatcodes ON itemtypes.VATCode = vatcodes.VATCode '+
//       '     RIGHT OUTER JOIN invoicelines ON items.Item = invoicelines.ItemID '+
       ' WHERE '+
       '   (invoicelines.InvoiceNumber IN  %s ) '+
       ' GROUP BY '+
       '   vatcodes.VATCode '+
       ' , vatcodes.Description '+
       ' , vatcodes.VATPercentage ' ;

      s := format(sql , [zSqlInText]);

//      copytoclipboard(s);
//      debugmessage(s);


      hData.rSet_bySQL(rSet,s);
      mItemVATsale.DisableControls;
      try
        if mItemVATsale.Active then mItemVATsale.Close;
        mItemVATsale.LoadFromDataSet(rSet);
        mItemVATsale.First;
      finally
        mItemVATsale.EnableControls;
      end;
    finally
      screen.Cursor := crDefault;
    end;
  finally
    freeandNil(rSet);
  end;
end;


procedure TfrmDayFinical.GetInvoicelist;
var
  rSet  : TRoomerDataSet;
  s     : string;
  sql   : string;
begin

  s := '';
  rSet := CreateNewDataSet;
  try
    screen.Cursor := crHourGlass;
    try
      s := format(select_DayFinical_GetInvoicelist , [zSqlInText]);
      hData.rSet_bySQL(rSet,s);
      mInvoiceHeads.DisableControls;
      try
        if mInvoiceHeads.Active then mInvoiceHeads.Close;
        mInvoiceHeads.LoadFromDataSet(rSet);
        mInvoiceHeads.First;
      finally
        mInvoiceHeads.EnableControls;
      end;
    finally
      screen.Cursor := crDefault;
    end;
  finally
    freeandNil(rSet);
  end;

  rSet := CreateNewDataSet;
  try
    screen.Cursor := crHourGlass;
    try

      sql :=
      ' SELECT '+
      '     invoicelines.InvoiceNumber '+
      '   , invoicelines.PurchaseDate '+
      '   , invoicelines.ItemID as Item'+
      '   , invoicelines.Number as Quantity'+
      '   , invoicelines.Description '+
      '   , invoicelines.Price '+
      '   , invoicelines.VATType '+
      '   , invoicelines.Total AS ilAmountWithTax '+
      '   , invoicelines.TotalWOVat AS ilAmountNoTax '+
      '   , invoicelines.Vat as ilAmountTax'+
      '   , invoicelines.Currency '+
      '   , invoicelines.CurrencyRate '+
      '   , invoicelines.ImportRefrence '+
      '   , invoicelines.ImportSource '+
      ' FROM '+
      '   invoicelines '+
      ' WHERE '+
      '   (invoicelines.InvoiceNumber IN  %s ) ';  //zSqlInText

      s := format(sql, [zSqlInText]);
      hData.rSet_bySQL(rSet,s);
      mInvoiceLines.DisableControls;
      try
        if mInvoiceLines.Active then mInvoiceLines.Close;
        mInvoiceLines.LoadFromDataSet(rSet);
        mInvoiceLines.First;
      finally
        mInvoiceLines.EnableControls;
      end;
    finally
      screen.Cursor := crDefault;
    end;
  finally
    freeandNil(rSet);
  end;
end;


procedure TfrmDayFinical.mInvoiceHeadsCalcFields(DataSet: TDataSet);
begin
  dataset.FieldByName('isCash').AsBoolean := false;
  dataset.FieldByName('isKredit').AsBoolean := false;
  dataset.FieldByName('isGroup').AsBoolean := false;
  dataset.FieldByName('isRoom').AsBoolean := false;

  if dataset.FieldByName('SplitNumber').AsInteger = 1 then
  begin
    dataset.FieldByName('isKredit').AsBoolean := true;
  end;

  if (dataset.FieldByName('Reservation').AsInteger = 0) AND (dataset.FieldByName('RoomReservation').AsInteger = 0) then
  begin
    dataset.FieldByName('isCash').AsBoolean := true;
    exit;
  end;

  if (dataset.FieldByName('RoomReservation').AsInteger = 0) and (dataset.FieldByName('Reservation').AsInteger > 0) then
  begin
    dataset.FieldByName('isGroup').AsBoolean := true;
    exit;
  end;

  if (dataset.FieldByName('RoomReservation').AsInteger > 0) and (dataset.FieldByName('Reservation').AsInteger > 0) then
  begin
    dataset.FieldByName('isRoom').AsBoolean := true;
  end;

end;



procedure TfrmDayFinical.mainPageChange(Sender: TObject);
begin
(*

sheetInvoiceList
sheetItemSale
sheetItemVATsale
sheetItemSale
sheetPayments
sheetPaymentType
sheetPaymentGroups
sheetums
sheetSums2
*)

  btnShowReservation.Enabled := false;
  btnShowGuests.Enabled := false;
  getConfirmGroup.Enabled := false;
  btnShowSelectedInvoice.Enabled := false;
  btnShowInvoice.Enabled := false;

  if mainPage.ActivePage = sheetSums then
  begin
     if pageSums.ActivePage = sheetSums then
     begin
     end else
     if pageSums.ActivePage = sheetSums2 then
     begin
     end;
  end else
  if mainPage.ActivePage = sheetInvoiceList then
  begin
    btnShowReservation.Enabled := true;
    btnShowGuests.Enabled := true;
    getConfirmGroup.Enabled := true;
    btnShowSelectedInvoice.Enabled := true;
    btnShowInvoice.Enabled := true;
  end else
  if mainPage.ActivePage = sheetItemSale then
  begin
  end else
  if mainPage.ActivePage = sheetItemVATsale then
  begin
  end else
  if mainPage.ActivePage = sheetItemSale then
  begin
  end else
  if mainPage.ActivePage = sheetPayments then
  begin
    btnShowReservation.Enabled := true;
    btnShowGuests.Enabled := true;
    getConfirmGroup.Enabled := true;
    btnShowSelectedInvoice.Enabled := true;
    btnShowInvoice.Enabled := true;
  end else
  if mainPage.ActivePage = sheetPaymentType then
  begin
  end else
  if mainPage.ActivePage = sheetPaymentGroups then
  begin
  end;

end;

procedure TfrmDayFinical.tvInvoiceHeadsDataControllerSummaryAfterSummary(ASender: TcxDataSummary);
var
  i : integer;
  fieldName : String;
  value1 : double;
begin
  (*
  for i := 0 to ASender.FooterSummaryItems.Count - 1 do
  begin
    fieldName :=  tvInvoiceHeads.Columns[ASender.FooterSummaryItems.Items[i].Field.Index].DataBinding.FieldName;
    if fieldName = 'ihAmountWithTax' then
    begin
//      value1 :=  tvInvoiceHeads.Columns[ASender.FooterSummaryItems.Items[i].Field.Index].DataBinding.Field.AsFloat;
      labIhAmountWithTax.Caption := floattostr(value1);
      tvInvoiceHeads.DataController.Summary.FooterSummaryValues[ASummaryItem.Index];

    end;


      ds.Parameters.ParamByName('field0').Value := fieldName;
      ds.Parameters.ParamByName('field1').Value := fieldName;
      ds.Open;
      try
        // set the summary value, depending on it's kind
        case ASender.FooterSummaryItems.Items[i].Kind of
          skNone : ASender.FooterSummaryValues[i] := null;
          skSum : ASender.FooterSummaryValues[i] := ds.FieldByName('cnt').AsInteger;
          skMin : ASender.FooterSummaryValues[i] := ds.FieldByName('min').AsInteger;
            // .. to be continued
        end;
      finally
        ds.Close;
      end;

  end;
       *)
end;

procedure TfrmDayFinical.tvInvoiceHeadsihAmountNoTaxGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmDayFinical.tvInvoiceHeadsihAmountTaxGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmDayFinical.tvInvoiceHeadsihAmountWithTaxGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmDayFinical.tvInvoiceLinesilAmountNoTaxGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmDayFinical.tvInvoiceLinesilAmountTaxGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmDayFinical.tvInvoiceLinesilAmountWithTaxGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmDayFinical.tvInvoiceLinesPriceGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmDayFinical.tvItemSaleTotalGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmDayFinical.tvItemSaleTotalVatGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmDayFinical.tvItemSaleTotalWoVatGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmDayFinical.tvItemTypeSaleTotalGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmDayFinical.tvItemTypeSaleTotalVatGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmDayFinical.tvItemTypeSaleTotalWoVatGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmDayFinical.tvItemVATsaleTotalGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmDayFinical.tvItemVATsaleTotalVatGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmDayFinical.tvItemVATsaleTotalWoVatGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmDayFinical.tvPaymentGroupsAmountGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmDayFinical.tvPaymentsAmountGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmDayFinical.tvPaymentTypeAmountGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmDayFinical.tvSums2PaymentGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmDayFinical.tvSums2SaleGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmDayFinical.tvSumsPaymentGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmDayFinical.tvSumsSaleGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmDayFinical.getPayments;
var
  rSet  : TRoomerDataSet;
  s     : string;
begin
  s := '';
  s := s+'SELECT '#10;
  s := s+  '   payments.Reservation '#10;
  s := s+  ' , payments.RoomReservation '#10;
  s := s+  ' , payments.InvoiceNumber '#10;
  s := s+  ' , payments.PayDate '#10;
  s := s+  ' , payments.Customer '#10;
  s := s+  ' , payments.Amount '#10;
  s := s+  ' , payments.Currency '#10;
  s := s+  ' , payments.CurrencyRate '#10;
  s := s+  ' , (payments.Amount div payments.CurrencyRate) AS CurrencyAmount '#10;
  s := s+  ' , payments.PayType '#10;
  s := s+  ' , invoiceheads.InvoiceDate '#10;
  s := s+  ' , paytypes.Description AS PayTypeDescription '#10;
  s := s+  ' , paytypes.PayGroup '#10;
  s := s+  ' , paygroups.Description AS payGroupDescription '#10;
  s := s+  ' , invoiceheads.Name AS NameOnInvoice '#10;
  s := s+  ' , invoiceheads.ihConfirmDate '#10;
  s := s+  ' , invoiceheads.SplitNumber '#10;
  s := s+  ' , invoiceheads.RoomGuest '#10;
  s := s+  ' , customers.Surname AS CustomerName '#10;
  s := s+  ' , customers.TravelAgency AS isAgency '#10;
  s := s+  ' FROM '#10;
  s := s+  '   payments '#10;
  s := s+  '      LEFT OUTER JOIN customers ON payments.Customer = customers.Customer '#10;
  s := s+  '      LEFT OUTER JOIN paytypes ON payments.PayType = paytypes.PayType '#10;
  s := s+  '      LEFT OUTER JOIN invoiceheads ON payments.InvoiceNumber = invoiceheads.InvoiceNumber '#10;
  s := s+  '      LEFT OUTER JOIN paygroups ON paytypes.PayGroup = paygroups.PayGroup '#10;
  s := s+  ' WHERE '#10;
  s := s+  '   (payments.InvoiceNumber IN  %s ) '#10;
  s := s+  ' ORDER BY '#10;
  s := s+  '   payments.InvoiceNumber ' ;

  rSet := CreateNewDataSet;
  try
    screen.Cursor := crHourGlass;
    try
      s := format(s, [zSqlInText]);
//      CopyToClipboard(s);
//      DebugMessage('select_DayFinical_getPayments'#10#10+s);
      hData.rSet_bySQL(rSet,s);
      mPayments.DisableControls;
      try
        if mPayments.Active then mPayments.Close;
        LoadKbmMemtableFromDataSetQuiet(mPayments,rSet,[]);
        mPayments.First;
      finally
        mPayments.EnableControls;
        tvPayments.ApplyBestFit();
      end;
    finally
      screen.Cursor := crDefault;
    end;
  finally
    freeandNil(rSet);
  end;
end;

procedure TfrmDayFinical.getPaymentType;
var
  rSet  : TRoomerDataSet;
  s     : string;
begin
{$REGION 'SQL'}
//  s := '';
//  s := s+ ' SELECT '+#10;
//  s := s+ '      COUNT(Payments.InvoiceNumber) AS InvoiceCount '+#10;
//  s := s+ '    , COUNT(Payments.Customer) AS CustomerCount '+#10;
//  s := s+ '    , SUM(Payments.Amount) AS Amount '+#10;
//  s := s+ '    , Payments.PayType '+#10;
//  s := s+ '    , Paytypes.Description AS PayTypeDescription '+#10;
//  s := s+ '    , PayGroups.PayGroup '+#10;
//  s := s+ ' FROM '+#10;
//  s := s+ '   Payments '+#10;
//  s := s+ '      LEFT OUTER JOIN Paytypes ON Payments.PayType = Paytypes.PayType '+#10;
//  s := s+ '      LEFT OUTER JOIN InvoiceHeads ON Payments.InvoiceNumber = InvoiceHeads.InvoiceNumber '+#10;
//  s := s+ '      LEFT OUTER JOIN PayGroups ON Paytypes.PayGroup = PayGroups.PayGroup '+#10;
//  s := s+ ' WHERE '+#10;
//  s := s+ '   (Payments.InvoiceNumber IN '+zSqlInText+') '+#10;
//  s := s+ ' GROUP BY '+#10;
//  s := s+ '     Payments.PayType '+#10;
//  s := s+ '   , Paytypes.Description '+#10;
//  s := s+ '   , PayGroups.PayGroup '+#10;

{$ENDREGION}
  rSet := CreateNewDataSet;
  try
    screen.Cursor := crHourGlass;
    try
      s := format(select_DayFinical_getPaymentType , [zSqlInText]);
  //		CopyToClipboard(s);
  //		DebugMessage(''#10#10+s);
      hData.rSet_bySQL(rSet,s);
      mPaymentTypes.DisableControls;
      try
        if mPaymentTypes.Active then mPaymentTypes.Close;
        mPaymentTypes.LoadFromDataSet(rSet);
        mPaymentTypes.First;
      finally
        mPaymentTypes.EnableControls;
      end;
    finally
      screen.Cursor := crDefault;
    end;
  finally
    freeandNil(rSet);
  end;
end;


procedure TfrmDayFinical.getPaymentGroup;
var
  rSet  : TRoomerDataSet;
  s     : string;
begin
{$REGION 'sql'}
//  s := '';
//  s := s+ ' SELECT '+#10;
//  s := s+ '      COUNT(Payments.InvoiceNumber) AS InvoiceCount '+#10;
//  s := s+ '    , SUM(Payments.Amount) AS Amount '+#10;
//  s := s+ '    , PayGroups.PayGroup '+#10;
//  s := s+ '    , PayGroups.Description '+#10;
//  s := s+ ' FROM '+#10;
//  s := s+ '   Payments '+#10;
//  s := s+ '      LEFT OUTER JOIN Paytypes ON Payments.PayType = Paytypes.PayType '+#10;
//  s := s+ '      LEFT OUTER JOIN InvoiceHeads ON Payments.InvoiceNumber = InvoiceHeads.InvoiceNumber '+#10;
//  s := s+ '      LEFT OUTER JOIN PayGroups ON Paytypes.PayGroup = PayGroups.PayGroup '+#10;
//  s := s+ ' WHERE '+#10;
//  s := s+ '   (Payments.InvoiceNumber IN '+zSqlInText+') '+#10;
//  s := s+ ' GROUP BY '+#10;
//  s := s+ '    PayGroups.PayGroup '+#10;
//  s := s+ '   ,PayGroups.Description '+#10;
{$ENDREGION}
  rSet := CreateNewDataSet;
  try
    screen.Cursor := crHourGlass;
    try
      s := format(select_DayFinical_getPaymentGroup , [zSqlInText]);
//      CopyToClipboard(s);
//      DebugMessage(''#10#10+s);
      hData.rSet_bySQL(rSet,s);
      mPaymentGroups.DisableControls;
      try
        if mPaymentGroups.Active then mPaymentGroups.Close;
        mPaymentGroups.LoadFromDataSet(rSet);
        mPaymentGroups.First;
      finally
        mPaymentGroups.EnableControls;
      end;
    finally
      screen.Cursor := crDefault;
    end;
  finally
    freeandNil(rSet);
  end;
end;




////////////////////

procedure TfrmDayFinical.getSums;
var
  id : integer;
  Code : string;
  Description : string;
  Sale    : double;
  payment : double;

begin
  mSums.Close;
  mSums.Open;

  id := 0;
  mItemSale.DisableControls;
  mSums.DisableControls;
  try
    mItemSale.First;
    while not mItemSale.Eof do
    begin
      inc(id);
      if LocalFloatValue(mItemSale.FieldByName('Total').AsString) <> 0 then
      begin
        mSums.append;
        mSums.FieldByName('id').AsInteger := id;
        mSums.FieldByName('Code').AsString        := mItemSale.FieldByName('Item').asstring;
        mSums.FieldByName('Description').AsString := mItemSale.FieldByName('Description').asstring;;
        mSums.FieldByName('Sale').AsFloat         := LocalFloatValue(mItemSale.FieldByName('Total').AsString);
        mSums.FieldByName('Payment').AsFloat      := 0.00;
        mSums.Post;
      end;
      mItemSale.Next;
    end;
  finally
    mItemSale.EnableControls;
    mSums.EnableControls;
  end;

  mPaymentTypes.DisableControls;
  mSums.DisableControls;
  try
    mPaymentTypes.First;
    while not mPaymentTypes.Eof do
    begin
      inc(id);
      if mPaymentTypes.FieldByName('Amount').AsFloat <> 0 then
      begin
        mSums.append;
          mSums.FieldByName('id').AsInteger := id;
          mSums.FieldByName('Code').AsString        := mPaymentTypes.FieldByName('PayType').asstring;
          mSums.FieldByName('Description').AsString := mPaymentTypes.FieldByName('PayTypeDescription').asstring;;
          mSums.FieldByName('Payment').AsFloat      := LocalFloatValue(mPaymentTypes.FieldByName('Amount').AsString);
          mSums.FieldByName('Sale').AsFloat         := 0.00;
        mSums.Post;
      end;
      mPaymentTypes.Next;
    end;
  finally
    mPaymentTypes.EnableControls;
    mSums.EnableControls;
  end;
end;

procedure TfrmDayFinical.getSums2;
var
  id : integer;
  Code : string;
  Description : string;
  Sale    : double;
  payment : double;
begin
  mSums2.Close;
  mSums2.Open;

  id := 0;
  mItemTypeSale.DisableControls;
  mSums2.DisableControls;
  try
    mItemTypeSale.First;
    while not mItemTypeSale.Eof do
    begin
      inc(id);
      if mItemTypeSale.FieldByName('Total').AsFloat <> 0 then
      begin
        mSums2.append;
        mSums2.FieldByName('id').AsInteger := id;
        mSums2.FieldByName('Code').AsString        := mItemTypeSale.FieldByName('ItemType').asstring;
        mSums2.FieldByName('Description').AsString := mItemTypeSale.FieldByName('ItemTypeDescription').asstring;;
        mSums2.FieldByName('Sale').AsFloat         := LocalFloatValue(mItemTypeSale.FieldByName('Total').AsString);
        mSums2.FieldByName('Payment').AsFloat      := 0.00;
        mSums2.Post;
      end;
      mItemTypeSale.Next;
    end;
  finally
    mItemTypeSale.EnableControls;
    mSums2.EnableControls;
  end;

  mPaymentGroups.DisableControls;
  mSums2.DisableControls;
  try
    mPaymentGroups.First;
    while not mPaymentGroups.Eof do
    begin
      inc(id);
      if mPaymentGroups.FieldByName('Amount').AsFloat <> 0 then
      begin
        mSums2.append;
        mSums2.FieldByName('id').AsInteger := id;
        mSums2.FieldByName('Code').AsString        := mPaymentGroups.FieldByName('PayGroup').asstring;
        mSums2.FieldByName('Description').AsString := mPaymentGroups.FieldByName('Description').asstring;
        mSums2.FieldByName('Payment').AsFloat      := LocalFloatValue(mPaymentGroups.FieldByName('Amount').AsString);
        mSums2.FieldByName('Sale').AsFloat         := 0.00;
        mSums2.Post;
      end;
      mPaymentGroups.Next;
    end;
  finally
    mPaymentGroups.EnableControls;
    mSums2.EnableControls;
  end;
end;

function TfrmDayFinical.getTotal_ihAmountWithTax : double;
var
  AIndex: integer;
  AValue: variant;
begin
  result := 0;
  with tvInvoiceHeads.DataController.Summary do
  begin
    AIndex :=  FooterSummaryItems.IndexOfItemLink(tvInvoiceHeadsihAmountWithTax);
    AValue :=  FooterSummaryValues[AIndex];
    result :=  Avalue;
  end;
end;


function TfrmDayFinical.getTotal_ihAmountWoVAT : double;
var
  AIndex: integer;
  AValue: variant;
begin
  result := 0;
  with tvInvoiceHeads.DataController.Summary do
  begin
    AIndex :=  FooterSummaryItems.IndexOfItemLink(tvInvoiceHeadsihAmountNoTAX);
    AValue :=  FooterSummaryValues[AIndex];
    result :=  Avalue;
  end;
end;

function TfrmDayFinical.getTotal_ihAmountVAT : double;
var
  AIndex: integer;
  AValue: variant;
begin
  result := 0;
  with tvInvoiceHeads.DataController.Summary do
  begin
    AIndex :=  FooterSummaryItems.IndexOfItemLink(tvInvoiceHeadsihAmountTax);
    AValue :=  FooterSummaryValues[AIndex];
    result :=  Avalue;
  end;
end;

function TfrmDayFinical.getTotal_ihInvoiceCount : integer;
var
  AIndex: integer;
  AValue: variant;
begin
  result := 0;
  with tvInvoiceHeads.DataController.Summary do
  begin
    AIndex :=  FooterSummaryItems.IndexOfItemLink(tvInvoiceHeadsInvoiceNumber);
    AValue :=  FooterSummaryValues[AIndex];
    result :=  Avalue;
  end;
end;

function TfrmDayFinical.getTotal_PaymentAmount : double;
var
  AIndex: integer;
  AValue: variant;
begin
  result := 0;
  with tvPayments.DataController.Summary do
  begin
    AIndex :=  FooterSummaryItems.IndexOfItemLink(tvPaymentsAmount);
    AValue :=  FooterSummaryValues[AIndex];
    result :=  Avalue;
  end;
end;

function TfrmDayFinical.getTotal_PaymentCount : integer;
var
  AIndex: integer;
  AValue: variant;
begin
  result := 0;
  with tvPayments.DataController.Summary do
  begin
    AIndex :=  FooterSummaryItems.IndexOfItemLink(tvPaymentsInvoiceNumber);
    AValue :=  FooterSummaryValues[AIndex];
    result :=  Avalue;
  end;
end;


function TfrmDayFinical.getTotal_LodgingNights : integer;
var
  AIndex: integer;
  AValue: variant;
begin
  result := 0;
  with tvInvoiceHeads.DataController.Summary do
  begin
    AIndex :=  FooterSummaryItems.IndexOfItemLink(tvInvoiceHeadsTotalStayTaxNights);
    AValue :=  FooterSummaryValues[AIndex];
    result :=  Avalue;
  end;
end;

function TfrmDayFinical.getTotal_LodgingTax : double;
var
  AIndex: integer;
  AValue: variant;
begin
  result := 0;
  with tvInvoiceHeads.DataController.Summary do
  begin
    AIndex :=  FooterSummaryItems.IndexOfItemLink(tvInvoiceHeadsTotalStayTax);
    AValue :=  FooterSummaryValues[AIndex];
    result :=  Avalue;
  end;
end;


function TfrmDayFinical.getTotal_RoomInvoiceCount : integer;
var
  AIndex: integer;
  AValue: variant;
begin
  result := 0;
  with tvInvoiceHeads.DataController.Summary do
  begin
    AIndex :=  FooterSummaryItems.IndexOfItemLink(tvInvoiceHeadsisRoom);
    AValue :=  FooterSummaryValues[AIndex];
    result :=  Avalue;
  end;
end;


function TfrmDayFinical.getTotal_GroupInvoiceCount : integer;
var
  AIndex: integer;
  AValue: variant;
begin
  result := 0;
  with tvInvoiceHeads.DataController.Summary do
  begin
    AIndex :=  FooterSummaryItems.IndexOfItemLink(tvInvoiceHeadsisGroup);
    AValue :=  FooterSummaryValues[AIndex];
    result :=  Avalue;
  end;
end;


function TfrmDayFinical.getTotal_KeditInvoiceCount : integer;
var
  AIndex: integer;
  AValue: variant;
begin
  result := 0;
  with tvInvoiceHeads.DataController.Summary do
  begin
    AIndex :=  FooterSummaryItems.IndexOfItemLink(tvInvoiceHeadsisKredit);
    AValue :=  FooterSummaryValues[AIndex];
    result :=  Avalue;
  end;
end;


function TfrmDayFinical.getTotal_CashInvoiceCount : integer;
var
  AIndex: integer;
  AValue: variant;
begin
  result := 0;
  with tvInvoiceHeads.DataController.Summary do
  begin
    AIndex :=  FooterSummaryItems.IndexOfItemLink(tvInvoiceHeadsisCash);
    AValue :=  FooterSummaryValues[AIndex];
    result :=  Avalue;
  end;
end;



procedure TfrmDayFinical.getHeader;
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

        dateFrom := dtDate.Date;
        dateTo := dtDateTo.Date;
        if zIsOneDay then dateTo := dateFrom;
        dateCount := (trunc(dateTo)-trunc(DateFrom))+1;

        saleAmount      := getTotal_ihAmountWithTax;
        saleAmountWoVAT := getTotal_ihAmountWoVAT;
        vatAmount       := getTotal_ihAmountVAT;

        invoiceCount    := getTotal_ihInvoiceCount;

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

        PaymentAmount    := getTotal_PaymentAmount   ;
        PaymentCount     := getTotal_PaymentCount    ;
        LodgingNights    := getTotal_LodgingNights   ;
        LodgingTax       := getTotal_LodgingTax      ;

        RoomInvoiceCount    :=  abs(getTotal_RoomInvoiceCount)   ;
        GroupInvoiceCount   :=  abs(getTotal_GroupInvoiceCount)  ;
        KeditInvoiceCount   :=  abs(getTotal_KeditInvoiceCount)  ;
        CashInvoiceCount    :=  abs(getTotal_CashInvoiceCount)   ;


        TotalTax            :=  0;

        mHead.FieldByName('DateFrom').AsDateTime       := dateFrom;
        mHead.FieldByName('DateTo').AsDateTime         := DateTo;
        mHead.FieldByName('DateCount').AsInteger       := dateCount;

        mHead.FieldByName('SaleAmount').AsFloat        := saleAmount;
        mHead.FieldByName('SaleAmountWoVAT').AsFloat   := saleAmountWoVAT;
        mHead.FieldByName('VATAmount').AsFloat         := vatAmount;

        mHead.FieldByName('InvoiceCount').AsInteger    := getTotal_ihInvoiceCount;

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

(*

grSums2
grSums
grInvoicelist
grItemSale
grItemTypeSale
grItemVATsale
grPayments
grPaymentType
grPaymentGroups

tvInvoiceHeads.
tvInvoiceLines.
tvItemSale.
tvItemVATsale.
tvItemSale.
tvPayments.
tvPaymentType.
tvPaymentGroups.
tvSums.
tvSums2.



*)


procedure TfrmDayFinical.GridLayoutRestoreAll;
begin
  tvInvoiceHeads.RestoreFromIniFile(GetGridsIniFilename);
  tvInvoiceLines.RestoreFromIniFile(GetGridsIniFilename);
  tvItemSale.RestoreFromIniFile(GetGridsIniFilename);
  tvItemVATsale.RestoreFromIniFile(GetGridsIniFilename);
  tvItemSale.RestoreFromIniFile(GetGridsIniFilename);
  tvPayments.RestoreFromIniFile(GetGridsIniFilename);
  tvPaymentType.RestoreFromIniFile(GetGridsIniFilename);
  tvPaymentGroups.RestoreFromIniFile(GetGridsIniFilename);
  tvSums.RestoreFromIniFile(GetGridsIniFilename);
  tvSums2.RestoreFromIniFile(GetGridsIniFilename);
end;



procedure TfrmDayFinical.GridLayoutSaveAll;
begin
  tvInvoiceHeads.StoreToIniFile(GetGridsIniFilename,false, [],'','');
  tvInvoiceLines.StoreToIniFile(GetGridsIniFilename,false, [],'','');
  tvItemSale.StoreToIniFile(GetGridsIniFilename,false, [],'','');
  tvItemVATsale.StoreToIniFile(GetGridsIniFilename,false, [],'','');
  tvItemSale.StoreToIniFile(GetGridsIniFilename,false, [],'','');
  tvPayments.StoreToIniFile(GetGridsIniFilename,false, [],'','');
  tvPaymentType.StoreToIniFile(GetGridsIniFilename,false, [],'','');
  tvPaymentGroups.StoreToIniFile(GetGridsIniFilename,false, [],'','');
  tvSums.StoreToIniFile(GetGridsIniFilename,false, [],'','');
  tvSums2.StoreToIniFile(GetGridsIniFilename,false, [],'','');
end;


procedure TfrmDayFinical.GridLayoutSave(tv : TcxGridDBTableView);
begin
  tv.StoreToIniFile(GetGridsIniFilename,true, [],'','');
end;

procedure TfrmDayFinical.GridLayoutRestore(tv : TcxGridDBTableView);
begin
  tvInvoiceHeads.RestoreFromIniFile(GetGridsIniFilename);
end;


////////////////////////////////////////////////////////////////////////////////////
///
///

procedure TfrmDayFinical.mnuLayoutSaveAllClick(Sender: TObject);
begin
  GridLayoutSaveAll;
end;

procedure TfrmDayFinical.mnuLayoutSaveCurrentClick(Sender: TObject);
begin
  if mainPage.ActivePage = sheetSums then
  begin
     if pageSums.ActivePage = sheetSums then
     begin
        GridLayoutSave(tvSums);
     end else
     if pageSums.ActivePage = sheetSums2 then
     begin
       GridLayoutSave(tvSums2);
     end;
  end else
  if mainPage.ActivePage = sheetInvoiceList then
  begin
    GridLayoutSave(tvInvoiceHeads);
    GridLayoutSave(tvInvoiceLines);
  end else
  if mainPage.ActivePage = sheetItemSale then
  begin
    GridLayoutSave(tvItemSale);
  end else
  if mainPage.ActivePage = sheetItemVATsale then
  begin
    GridLayoutSave(tvItemVATsale);
  end else
  if mainPage.ActivePage = sheetItemSale then
  begin
    GridLayoutSave(tvItemSale);
  end else
  if mainPage.ActivePage = sheetPayments then
  begin
    GridLayoutSave(tvPayments);
  end else
  if mainPage.ActivePage = sheetPaymentType then
  begin
    GridLayoutSave(tvPaymentType);
  end else
  if mainPage.ActivePage = sheetPaymentGroups then
  begin
    GridLayoutSave(tvPaymentGroups);
  end;
end;


procedure TfrmDayFinical.mPaymentsCalcFields(DataSet: TDataSet);
begin
  dataset.FieldByName('isCash').AsBoolean := false;
  dataset.FieldByName('isKredit').AsBoolean := false;
  dataset.FieldByName('isGroup').AsBoolean := false;
  dataset.FieldByName('isRoom').AsBoolean := false;

  if dataset.FieldByName('SplitNumber').AsInteger = 1 then
  begin
    dataset.FieldByName('isKredit').AsBoolean := true;
  end;

  if (dataset.FieldByName('Reservation').AsInteger = 0) AND (dataset.FieldByName('RoomReservation').AsInteger = 0) then
  begin
    dataset.FieldByName('isCash').AsBoolean := true;
    exit;
  end;

  if (dataset.FieldByName('RoomReservation').AsInteger = 0) and (dataset.FieldByName('Reservation').AsInteger > 0) then
  begin
    dataset.FieldByName('isGroup').AsBoolean := true;
    exit;
  end;

  if (dataset.FieldByName('RoomReservation').AsInteger > 0) and (dataset.FieldByName('Reservation').AsInteger > 0) then
  begin
    dataset.FieldByName('isRoom').AsBoolean := true;
  end;
end;


procedure TfrmDayFinical.mnuLayoutRestoreAllClick(Sender: TObject);
begin
  GridLayoutRestoreAll
end;


procedure TfrmDayFinical.mnuLayoutRestoreCurrentClick(Sender: TObject);
begin
  if mainPage.ActivePage = sheetSums then
  begin
     if pageSums.ActivePage = sheetSums then
     begin
        GridLayoutRestore(tvSums);
     end else
     if pageSums.ActivePage = sheetSums2 then
     begin
       GridLayoutRestore(tvSums2);
     end;
  end else
  if mainPage.ActivePage = sheetInvoiceList then
  begin
    GridLayoutRestore(tvInvoiceHeads);
    GridLayoutRestore(tvInvoiceLines);
  end else
  if mainPage.ActivePage = sheetItemSale then
  begin
    GridLayoutRestore(tvItemSale);
  end else
  if mainPage.ActivePage = sheetItemTypeSale then
  begin
    GridLayoutRestore(tvItemTypeSale);
  end else
  if mainPage.ActivePage = sheetItemVATsale then
  begin
    GridLayoutRestore(tvItemVATsale);
  end else
  if mainPage.ActivePage = sheetItemSale then
  begin
    GridLayoutRestore(tvItemSale);
  end else
  if mainPage.ActivePage = sheetPayments then
  begin
    GridLayoutRestore(tvPayments);
  end else
  if mainPage.ActivePage = sheetPaymentType then
  begin
    GridLayoutRestore(tvPaymentType);
  end else
  if mainPage.ActivePage = sheetPaymentGroups then
  begin
    GridLayoutRestore(tvPaymentGroups);
  end;
end;



procedure TfrmDayFinical.btnConfirmClick(Sender: TObject);
var
  s   : string;
  iCount : integer;
begin
  iCount := mInvoiceHeads.recordcount;

  if zIsConfirmed then
  begin
    if iCount = 0 then
    begin
	    s := GetTranslatedText('shTx_DayFinical_NoInvoices2');
      showmessage(s);
      exit;
    end else
    begin
  	  s := GetTranslatedText('shTx_DayFinical_InvoiceConfirmed');
    end;
  end else
  begin
    if iCount = 0 then
    begin
  	   s := GetTranslatedText('shTx_DayFinical_NoUnconfirmedInvoices');
      showmessage(s);
      exit;
    end else
    begin
     // s := 'Invoiced not confirmed - confirm now!'
	  s := GetTranslatedText('shTx_DayFinical_InvoiceNotConfirmed');
    end;
  end;


  if MessageDlg(s, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
      s := '';
      s := s + ' UPDATE invoiceheads ';
      s := s + ' SET ';
      if zIsConfirmed then
      begin
        s := s + '   ihConfirmDate = '+_dbDateAndTime(2);
      end else
      begin
        s := s + '   ihConfirmDate = '+_dbDateAndTime(now);
      end;
      s := s+ ' WHERE '+#10;
      s := s+ '   (invoiceheads.InvoiceNumber IN '+zSqlInText+') '+#10;

      if not cmd_bySQL(s) then
      begin
      end;

      mInvoiceHeads.DisableControls;
      try
        // refresh invoicelist and without updating - invoicenumbers to get
        // to get the new value og ihConfirmDate
        GetInvoiceList;
        GetPayments;
        mInvoiceHeads.First;
      finally
        mInvoiceHeads.EnableControls;
      end;

      zIsConfirmed := not zIsConfirmed;

      if zIsConfirmed then
      begin
        //btnConfirm.Caption := 'Un-confirm NOW';
        btnConfirm.Caption := GetTranslatedText('shTx_DayFinical_Unconfirm');
        zConfirmState := 2;
      end else
      begin
        //btnConfirm.Caption := 'Confirm NOW';
        btnConfirm.Caption := GetTranslatedText('shTx_DayFinical_Confirm');
        zConfirmState := 0;
      end;
  end;
end;

procedure TfrmDayFinical.btnExcel(Sender: TObject);
var
  sFilename : string;
  sPartName : string;
  grid : TcxGrid;
  s : string;
begin
  grid := nil;
  if mainPage.ActivePage = sheetSums then
  begin
     if pageSums.ActivePage = sheetSums then
     begin
       grid := grSums;
       sPartName := 'sums';
     end else
     if pageSums.ActivePage = sheetSums2 then
     begin
       grid := grSums2;
       sPartName := 'sums2';
     end;
  end else
  if mainPage.ActivePage = sheetInvoiceList then
  begin
    grid := grInvoiceList;
    sPartName := 'InvoiceList';
  end else
  if mainPage.ActivePage = sheetItemSale then
  begin
    grid := grItemSale;
    sPartName := 'ItemSale';
  end else
  if mainPage.ActivePage = sheetItemTypeSale then
  begin
    grid := grItemTypeSale;
    sPartName := 'ItemTypeSale';
  end else
  if mainPage.ActivePage = sheetItemVATsale then
  begin
    grid := grItemVATsale;
    sPartName := 'ItemVATsale';
  end else
  if mainPage.ActivePage = sheetItemSale then
  begin
    grid := grItemSale;
    sPartName := 'ItemSale';
  end else
  if mainPage.ActivePage = sheetPayments then
  begin
    grid := grPayments;
    sPartName := 'Payments';
  end else
  if mainPage.ActivePage = sheetPaymentType then
  begin
    grid := grPaymentType;
    sPartName := 'PaymentType';
  end else
  if mainPage.ActivePage = sheetPaymentGroups then
  begin
    grid := grPaymentGroups;
    sPartName := 'PaymentGroups';
  end;

  datetimeTostring(s, 'yyyymmddhhnnss', now);
  sFilename := g.qProgramPath + s + '_'+sPartName;
  ExportGridToExcel(sFilename, grid, false, True, True);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;


procedure TfrmDayFinical.btnPaymentReportClick(Sender: TObject);
var
  aReport   : TppReport;
  sFilter : string;
  s : string;
  sortField : string;
  isDescending : boolean;

//  mReport : TkbmMemTable;


begin
  kbmReport.Close;
  LoadKbmMemtableFromDataSetQuiet(kbmReport,tvPayments.DataController.DataSource.DataSet,[mtcpoStructure]);

  sortfield    := 'PayType';
  isDescending := false;
  kbmReport.SortFields := sortfield;
  if not isDescending then
  begin
    kbmReport.sort([]);
  end else
  begin
    kbmReport.sort([mtcoDescending]);
  end;



    if frmRptbViewer <> nil then
      freeandNil(frmRptbViewer);
    frmRptbViewer := TfrmRptbViewer.Create(frmRptbViewer);
    frmRptbViewer.show;

    screen.Cursor := crHourglass;
    try
      aReport := rptbPayments;
      frmRptbViewer.ppViewer1.Reset;
      frmRptbViewer.ppViewer1.Report := aReport;
      frmRptbViewer.ppViewer1.GotoPage(1);
      aReport.PrintToDevices;
    finally
      screen.Cursor := crDefault;
    end;
//  finally
//    freeandnil(mReport);
//  end;
end;


procedure TfrmDayFinical.btnPrintClick(Sender: TObject);
var
  s1,s2 : string;
  Title : string;

  ReportLink : TdxGridReportLink;

begin

  if zIsOneDay then
  begin
    s1  := 'Date : '+datetostr(dtDate.date);
    s2 := '';
  end else
  begin
    s1  := 'From : '+dateToStr(dtdate.Date);
    s2 := 'To : '+dateToStr(dtdateTo.Date);
  end;

  if mainPage.ActivePage = sheetSums then
  begin
     if pageSums.ActivePage = sheetSums2 then
     begin
       Title := 'ItemType / PaymentGroup';
       ReportLink := grPrinterSums2;
     end else
     if pageSums.ActivePage = sheetSums3 then
     begin
       Title := 'Item / PaymentType';
       ReportLink := grPrinterSums;
     end;
  end else
  if mainPage.ActivePage = sheetInvoiceList then
  begin
    Title := 'InvoiceList';
    ReportLink := grPrinterInvoiceList;
  end else
  if mainPage.ActivePage = sheetItemSale then
  begin
    Title := 'ItemSale';
    ReportLink := grPrinterItemSale;
  end else
  if mainPage.ActivePage = sheetItemTypeSale then
  begin
    Title := 'ItemTypeSale';
    ReportLink := grPrinterItemTypeSale;
  end else
  if mainPage.ActivePage = sheetItemVATsale then
  begin
    Title := 'ItemVATsale';
    ReportLink := grPrinterItemVATsale;
  end else
  if mainPage.ActivePage = sheetItemSale then
  begin
    Title := 'ItemSale';
    ReportLink := grPrinterItemSale;
  end else
  if mainPage.ActivePage = sheetPayments then
  begin
    Title := 'Payments';
    ReportLink := grPrinterPayments;
  end else
  if mainPage.ActivePage = sheetPaymentType then
  begin
    Title := 'PaymentType';
    ReportLink := grPrinterPaymentType;
  end else
  if mainPage.ActivePage = sheetPaymentGroups then
  begin
    Title := 'PaymentGroups';
    ReportLink := grPrinterPaymentGroups;
  end;

  reportLink.PrinterPage.PageHeader.LeftTitle.Clear;
  reportLink.PrinterPage.PageHeader.LeftTitle.Add(s1);
  reportLink.PrinterPage.PageHeader.LeftTitle.Add(s2);
  reportLink.ReportTitle.Text := Title;
  grPrinter.CurrentLink := ReportLink;
  grPrinter.CurrentLink.Preview();
end;


procedure TfrmDayFinical.btnShowGuestsClick(Sender: TObject);
var
  Reservation : Integer;
  RoomReservation : Integer;
  sName : string;
  theData : recPersonHolder;
begin
  Reservation := 0;
  RoomReservation := 0;
  sName := '';

  if mainPage.ActivePage = sheetSums then
  begin
     if pageSums.ActivePage = sheetSums2 then
     begin
     end else
     if pageSums.ActivePage = sheetSums3 then
     begin
     end;
  end else
  if mainPage.ActivePage = sheetInvoiceList then
  begin
    Reservation     := mInvoiceHeads.FieldByName('Reservation').Asinteger;
    RoomReservation := mInvoiceHeads.FieldByName('RoomReservation').Asinteger; ;
    sName := mInvoiceHeads.FieldByName('RoomGuest').AsString;
  end else
  if mainPage.ActivePage = sheetItemSale then
  begin
  end else
  if mainPage.ActivePage = sheetItemTypeSale then
  begin
  end else
  if mainPage.ActivePage = sheetItemVATsale then
  begin
  end else
  if mainPage.ActivePage = sheetItemSale then
  begin
  end else
  if mainPage.ActivePage = sheetPayments then
  begin
    Reservation     := mPayments.FieldByName('Reservation').Asinteger;
    RoomReservation := mPayments.FieldByName('RoomReservation').Asinteger; ;
  end else
  if mainPage.ActivePage = sheetPaymentType then
  begin
  end else
  if mainPage.ActivePage = sheetPaymentGroups then
  begin
  end;

  if (reservation = 0) and (roomreservation = 0) then
  begin
	  showmessage(GetTranslatedText('shTx_DayFinical_CashInvoice'));
    exit;
  end;

  if (roomreservation = 0) then
  begin
//      frmResGuestList := TfrmResGuestList.Create(Self);
//      try
//        frmResGuestList.zReservation := Reservation;
//        frmResGuestList.ShowModal;
//        if frmResGuestList.ModalResult = mrOK then
//        begin
//        end;
//      finally
//        frmResGuestList.free;
//        frmResGuestList := nil;
//      end;
    exit;
  end;

  initPersonHolder(theData);
  theData.Reservation := Reservation;
  theData.RoomReservation := RoomReservation;
  theData.name := sName;

  if openGuestProfile(actNone,theData) then
  begin
  end;
end;

procedure TfrmDayFinical.btnShowReservationClick(Sender: TObject);
var
  reservation : integer;
  RoomReservation : integer;
begin
  Reservation := 0;
  RoomReservation := 0;

  if mainPage.ActivePage = sheetSums then
  begin
     if pageSums.ActivePage = sheetSums2 then
     begin
     end else
     if pageSums.ActivePage = sheetSums3 then
     begin
     end;
  end else
  if mainPage.ActivePage = sheetInvoiceList then
  begin
    Reservation     := mInvoiceHeads.FieldByName('Reservation').Asinteger;
    RoomReservation := mInvoiceHeads.FieldByName('RoomReservation').Asinteger; ;
  end else
  if mainPage.ActivePage = sheetItemSale then
  begin
  end else
  if mainPage.ActivePage = sheetItemTypeSale then
  begin
  end else
  if mainPage.ActivePage = sheetItemVATsale then
  begin
  end else
  if mainPage.ActivePage = sheetItemSale then
  begin
  end else
  if mainPage.ActivePage = sheetPayments then
  begin
    Reservation     := mPayments.FieldByName('Reservation').Asinteger;
    RoomReservation := mPayments.FieldByName('RoomReservation').Asinteger; ;
  end else
  if mainPage.ActivePage = sheetPaymentType then
  begin
  end else
  if mainPage.ActivePage = sheetPaymentGroups then
  begin
  end;

  if (reservation = 0) and (roomreservation = 0) then
  begin
	  showmessage(GetTranslatedText('shTx_DayFinical_CashInvoice'));
    exit;
  end;

  if reservation = 0 then exit;
  try
    if EditReservation(Reservation, RoomReservation) then
    begin
    end;
  Except
  end;
end;


procedure TfrmDayFinical.btnShowRoomClick(Sender: TObject);
var
  reservation : integer;
  RoomReservation : integer;
begin
end;

procedure TfrmDayFinical.btnShowSelectedInvoiceClick(Sender: TObject);
var
  InvoiceNumber : integer;
begin
  invoicenumber := 0;


  if mainPage.ActivePage = sheetSums then
  begin
     if pageSums.ActivePage = sheetSums2 then
     begin
     end else
     if pageSums.ActivePage = sheetSums3 then
     begin
     end;
  end else
  if mainPage.ActivePage = sheetInvoiceList then
  begin
    InvoiceNumber  := mInvoiceHeads.FieldByName('Invoicenumber').Asinteger;
  end else
  if mainPage.ActivePage = sheetItemSale then
  begin
  end else
  if mainPage.ActivePage = sheetItemTypeSale then
  begin
  end else
  if mainPage.ActivePage = sheetItemVATsale then
  begin
  end else
  if mainPage.ActivePage = sheetItemSale then
  begin
  end else
  if mainPage.ActivePage = sheetPayments then
  begin
    InvoiceNumber  := mPayments.FieldByName('Invoicenumber').Asinteger;
  end else
  if mainPage.ActivePage = sheetPaymentType then
  begin
  end else
  if mainPage.ActivePage = sheetPaymentGroups then
  begin
  end;


  if invoicenumber = 0 then  exit;
  try
    ViewInvoice2(InvoiceNumber, false, false, false,false, '');
  Except
  end;

end;




procedure TfrmDayFinical.mnuThisRoomClick(Sender: TObject);
var
  reservation : integer;
  RoomReservation : integer;
begin
  Reservation := 0;
  RoomReservation := 0;


  if mainPage.ActivePage = sheetSums then
  begin
     if pageSums.ActivePage = sheetSums2 then
     begin
     end else
     if pageSums.ActivePage = sheetSums3 then
     begin
     end;
  end else
  if mainPage.ActivePage = sheetInvoiceList then
  begin
    Reservation     := mInvoiceHeads.FieldByName('Reservation').Asinteger;
    RoomReservation := mInvoiceHeads.FieldByName('RoomReservation').Asinteger; ;
  end else
  if mainPage.ActivePage = sheetItemSale then
  begin
  end else
  if mainPage.ActivePage = sheetItemTypeSale then
  begin
  end else
  if mainPage.ActivePage = sheetItemVATsale then
  begin
  end else
  if mainPage.ActivePage = sheetItemSale then
  begin
  end else
  if mainPage.ActivePage = sheetPayments then
  begin
    Reservation     := mPayments.FieldByName('Reservation').Asinteger;
    RoomReservation := mPayments.FieldByName('RoomReservation').Asinteger; ;
  end else
  if mainPage.ActivePage = sheetPaymentType then
  begin
  end else
  if mainPage.ActivePage = sheetPaymentGroups then
  begin
  end;

  if (reservation = 0) and (roomreservation = 0) then
  begin
  	showmessage(GetTranslatedText('shTx_DayFinical_CashInvoice'));
    exit;
  end;

  ShowFinishedInvoices2(itPerRoomRes, '', RoomReservation);

end;


procedure TfrmDayFinical.mnuThisreservationClick(Sender: TObject);
var
  reservation : integer;
  RoomReservation : integer;
begin
  Reservation := 0;
  RoomReservation := 0;


  if mainPage.ActivePage = sheetSums then
  begin
     if pageSums.ActivePage = sheetSums2 then
     begin
     end else
     if pageSums.ActivePage = sheetSums3 then
     begin
     end;
  end else
  if mainPage.ActivePage = sheetInvoiceList then
  begin
    Reservation     := mInvoiceHeads.FieldByName('Reservation').Asinteger;
    RoomReservation := mInvoiceHeads.FieldByName('RoomReservation').Asinteger; ;
  end else
  if mainPage.ActivePage = sheetItemSale then
  begin
  end else
  if mainPage.ActivePage = sheetItemTypeSale then
  begin
  end else
  if mainPage.ActivePage = sheetItemVATsale then
  begin
  end else
  if mainPage.ActivePage = sheetItemSale then
  begin
  end else
  if mainPage.ActivePage = sheetPayments then
  begin
    Reservation     := mPayments.FieldByName('Reservation').Asinteger;
    RoomReservation := mPayments.FieldByName('RoomReservation').Asinteger; ;
  end else
  if mainPage.ActivePage = sheetPaymentType then
  begin
  end else
  if mainPage.ActivePage = sheetPaymentGroups then
  begin
  end;

  if (reservation = 0) and (roomreservation = 0) then
  begin
  	showmessage(GetTranslatedText('shTx_DayFinical_CashInvoice'));
    exit;
  end;

  ShowFinishedInvoices2(itPerReservation, '', Reservation);

end;



procedure TfrmDayFinical.OpenthisRoom1Click(Sender: TObject);
var
  reservation : integer;
  RoomReservation : integer;
begin
  Reservation := 0;
  RoomReservation := 0;


  if mainPage.ActivePage = sheetSums then
  begin
     if pageSums.ActivePage = sheetSums2 then
     begin
     end else
     if pageSums.ActivePage = sheetSums3 then
     begin
     end;
  end else
  if mainPage.ActivePage = sheetInvoiceList then
  begin
    Reservation     := mInvoiceHeads.FieldByName('Reservation').Asinteger;
    RoomReservation := mInvoiceHeads.FieldByName('RoomReservation').Asinteger; ;
  end else
  if mainPage.ActivePage = sheetItemSale then
  begin
  end else
  if mainPage.ActivePage = sheetItemTypeSale then
  begin
  end else
  if mainPage.ActivePage = sheetItemVATsale then
  begin
  end else
  if mainPage.ActivePage = sheetItemSale then
  begin
  end else
  if mainPage.ActivePage = sheetPayments then
  begin
    Reservation     := mPayments.FieldByName('Reservation').Asinteger;
    RoomReservation := mPayments.FieldByName('RoomReservation').Asinteger; ;
  end else
  if mainPage.ActivePage = sheetPaymentType then
  begin
  end else
  if mainPage.ActivePage = sheetPaymentGroups then
  begin
  end;

  if (reservation = 0) and (roomreservation = 0) then
  begin
  	showmessage(GetTranslatedText('shTx_DayFinical_CashInvoice'));
    exit;
  end;

  EditInvoice(Reservation, RoomReservation, 0, 0, 0, 0, false, false,false);
end;


procedure TfrmDayFinical.OpenGroupInvoice1Click(Sender: TObject);
var
  reservation : integer;
  RoomReservation : integer;
begin
  Reservation := 0;
  RoomReservation := 0;


  if mainPage.ActivePage = sheetSums then
  begin
     if pageSums.ActivePage = sheetSums2 then
     begin
     end else
     if pageSums.ActivePage = sheetSums3 then
     begin
     end;
  end else
  if mainPage.ActivePage = sheetInvoiceList then
  begin
    Reservation     := mInvoiceHeads.FieldByName('Reservation').Asinteger;
    RoomReservation := mInvoiceHeads.FieldByName('RoomReservation').Asinteger; ;
  end else
  if mainPage.ActivePage = sheetItemSale then
  begin
  end else
  if mainPage.ActivePage = sheetItemTypeSale then
  begin
  end else
  if mainPage.ActivePage = sheetItemVATsale then
  begin
  end else
  if mainPage.ActivePage = sheetItemSale then
  begin
  end else
  if mainPage.ActivePage = sheetPayments then
  begin
    Reservation     := mPayments.FieldByName('Reservation').Asinteger;
    RoomReservation := mPayments.FieldByName('RoomReservation').Asinteger; ;
  end else
  if mainPage.ActivePage = sheetPaymentType then
  begin
  end else
  if mainPage.ActivePage = sheetPaymentGroups then
  begin
  end;

  if (reservation = 0) and (roomreservation = 0) then
  begin
  	showmessage(GetTranslatedText('shTx_DayFinical_CashInvoice'));
    exit;
  end;

  EditInvoice(Reservation, 0, 0, 0, 0, 0, false, false,false);
end;


procedure TfrmDayFinical.getConfirmGroupClick(Sender: TObject);
var
  ConfirmDate : TDateTime;
begin
  confirmDate := 2;

  if mainPage.ActivePage = sheetSums then
  begin
     if pageSums.ActivePage = sheetSums2 then
     begin
     end else
     if pageSums.ActivePage = sheetSums3 then
     begin
     end;
  end else
  if mainPage.ActivePage = sheetInvoiceList then
  begin
    confirmDate     := mInvoiceHeads.FieldByName('ConfirmedDate').AsDateTime;
  end else
  if mainPage.ActivePage = sheetItemSale then
  begin
  end else
  if mainPage.ActivePage = sheetItemTypeSale then
  begin
  end else
  if mainPage.ActivePage = sheetItemVATsale then
  begin
  end else
  if mainPage.ActivePage = sheetItemSale then
  begin
  end else
  if mainPage.ActivePage = sheetPayments then
  begin
    confirmDate  := mPayments.FieldByName('ihConfirmDate').AsDateTime;
  end else
  if mainPage.ActivePage = sheetPaymentType then
  begin
  end else
  if mainPage.ActivePage = sheetPaymentGroups then
  begin
  end;

  if confirmDate = 2 then exit;

  zConfirmState := 2;
  zConfirmedDate := confirmDate;

  zDoChkEvent := false;
  chkGetUnconfirmed.Checked := true;
  zDoChkEvent := true;
  gbxSelectDates.visible := false;
  zIsConfirmed := true;
  btnConfirm.visible := true;
  btnConfirm.Caption := 'Un-confirm NOW';
  btnConfirm.Caption := GetTranslatedText('shTx_DayFinical_Unconfirm');
  GetAll(true);
end;


procedure TfrmDayFinical.btnSwitchToDatesClick(Sender: TObject);
begin
  SwitchToDates;
end;


procedure TfrmDayFinical.SwitchToDates;
begin
  // Leave

  dtDate.date               := date - 1;
  dtDateTo.date             := date - 1;
  zIsOneDay                   := chkOneday.Checked;
  dtDateTo.Visible          := not zIsOneDay;
  LMDSimpleLabel2.Visible   := dtDateTo.Visible;
  gbxSelectDates.visible    := true;

  zIsConfirmed              := false;
  zConfirmState             := 0;
  zConfirmedDate            := 0;

  zDoChkEvent := false;
  chkGetUnconfirmed.Checked := false;
  zDoChkEvent := true;

  btnConfirm.Visible        := false;
  //btnConfirm.Caption        := 'Confirm NOW';
  btnConfirm.Caption        := GetTranslatedText('shTx_DayFinical_Confirm');
  GetAll(true);
end;



end.
