unit uInvoice;

{ isl } // í forminu
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, ExtCtrls, ComCtrls, StdCtrls, ImgList, Menus, Buttons, Data.DB,
  Data.Win.ADODB

    , uDateUtils, ActnList, System.Actions, Generics.Collections, variants,
  cmpRoomerDataSet

    , _glob, hData, ug, uUtils, kbmMemTable

    , uTaxCalc

    , AdvObj, BaseGrid, AdvGrid

    , sPanel, sEdit, sLabel, sGroupBox, sStatusBar, sButton, sSkinProvider,
  sPageControl

    , cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin,
  dxSkinOffice2013White, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  cxMemo,
  cxButtonEdit, cxSpinEdit, cxCalc, cxContainer

    , frxExportMail, frxExportImage, frxExportRTF, frxExportHTML, frxClass,
  frxExportPDF, frxDesgn, frxDBSet

    , cxPropertiesStore, sCheckBox, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses,
  cxGridCustomView, cxGrid

    , dxmdaset, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinDarkRoom,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, cxButtons, sComboBox,
  sSpeedButton, AdvUtil

    ;

const
  col_Select = 0;
  col_Item = col_Select + 1;
  col_Description = col_Item + 1;
  col_ItemCount = col_Description + 1;
  col_ItemPrice = col_ItemCount + 1;
  col_TotalPrice = col_ItemPrice + 1;
  col_System = col_TotalPrice + 1; // old 5
  col_date = col_System + 1;
  col_Refrence = col_date + 1; // old 7
  col_Source = col_Refrence + 1;
  col_isPackage = col_Source + 1; // old 9
  col_NoGuests = col_isPackage + 1;
  col_confirmdate = col_NoGuests + 1;
  col_confirmAmount = col_confirmdate + 1;
  col_Vat = col_confirmAmount + 1;
  col_rrAlias = col_Vat + 1;
  col_autogen = col_rrAlias + 1; // old 15

type
  TCreditType = (ctManual, ctReference, ctErr);

{$M+}

  // ------------------------------------------------------------------------------
  //
  // TRoomInfo
  //
  // ------------------------------------------------------------------------------
  TRoomInfo = class(TObject)
  private
    FRoomReservation: integer;
    FReservation: integer;
    FName: string;
    FRoom: String;
    FFrom: TDateTime;
    FTo: TDateTime;
    FNumPersons: integer;
    FPrice: Double;
    FDiscount: Double;
  published
    property Price: Double read FPrice write FPrice;
    property Discount: Double read FDiscount write FDiscount;
    property name: string read FName write FName;
  end;

  TRoomInfoList = TObjectlist<TRoomInfo>;

  // ------------------------------------------------------------------------------
  //
  // TInvoiceLine
  //
  // ------------------------------------------------------------------------------

{$M+}

  TInvoiceLine = class(TObject)
  private
    FInvoiceLine: integer;

    FItem: string;
    FText: string;

    FNumber: Double; // -96
    FPrice: Double;
    FTotal: Double;
    FDate: TDate;
    FAuto: boolean;
    FRefrence: string;
    FSource: string;
    FIspackage: boolean;
    FNoGuests: integer;
    FConfirmDate: TDateTime;
    FConfirmAmount: Double;
    FitemIndex: integer;
    FrrAlias: integer;
    FAutoGen: string;
    FId: Integer;

  public
    constructor create(invoiceLine, _id: integer);
    destructor Destroy; override;
  published
    property invoiceLine: integer read FInvoiceLine write FInvoiceLine;
    property Id: Integer read FId write FId;
    property Item: string read FItem write FItem;
    property Text: string read FText write FText;
    property Number: Double read FNumber write FNumber; // -96
    property Price: Double read FPrice write FPrice;
    property Total: Double read FTotal write FTotal;
    property Refrence: string read FRefrence write FRefrence;
    property Source: string read FSource write FSource;
    property isPackage: boolean read FIspackage write FIspackage;
    property noGuests: integer read FNoGuests write FNoGuests;
    property confrimDate: TDateTime read FConfirmDate write FConfirmDate;
    property confrimAmount: Double read FConfirmAmount write FConfirmAmount;
    property itemIndex: integer read FitemIndex write FitemIndex;
    property rrAlias: integer read FrrAlias write FrrAlias;
    property AutoGen: string read FAutoGen write FAutoGen;

  end;

  // ------------------------------------------------------------------------------
  //
  // TfrmInvoice
  //
  // ------------------------------------------------------------------------------

  TfrmInvoice = class(TForm)
    FriendlyStatusBar1: TsStatusBar;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    ExitandSave1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Items1: TMenuItem;
    Add1: TMenuItem;
    Delete1: TMenuItem;
    PANmAIN: TsPanel;
    GridImages: TImageList;
    N2: TMenuItem;
    Removetemporarily1: TMenuItem;
    Invoice2: TMenuItem;
    Print2: TMenuItem;
    PrintProforma1: TMenuItem;
    N3: TMenuItem;
    Downpayment1: TMenuItem;
    RemoveRoomRenttemporarity1: TMenuItem;
    N4: TMenuItem;
    Setjahpreikning1: TMenuItem;
    Panel1: TsPanel;
    clabCurrency: TsLabel;
    edtCurrency: TsEdit;
    rgrInvoiceType: TsRadioGroup;
    act: TActionList;
    actSaveAndExit: TAction;
    actCloce: TAction;
    actPrintInvoice: TAction;
    actPrintProforma: TAction;
    actInvoiceProperties: TAction;
    actDownPayment: TAction;
    actInfo: TAction;
    actAddLine: TAction;
    actDelLine: TAction;
    actRRtoTemp: TAction;
    actItemToTemp: TAction;
    actItemToGroupInvoice: TAction;
    actCompressLines: TAction;
    edtRate: TsEdit;
    clabRate: TsLabel;
    PopupMenu1: TPopupMenu;
    StofnaViskiptamann1: TMenuItem;
    timCloseInvoice: TTimer;
    edtInvRefrence: TsEdit;
    clabRefrence: TsLabel;
    GuestName1: TMenuItem;
    Refrence1: TMenuItem;
    btnGetCurrency: TsButton;
    btnGetRate: TsButton;
    clabInvoice: TsLabel;
    edtRoomGuest: TsEdit;
    clabRoomGuest: TsLabel;
    StoreMain: TcxPropertiesStore;
    lblChangedInvoiceActive: TsLabel;
    edtCustomer: TsEdit;
    clabCustomer: TsLabel;
    clabPId: TsLabel;
    edtPersonalId: TsEdit;
    edtName: TsEdit;
    edtAddress1: TsEdit;
    edtAddress2: TsEdit;
    edtAddress3: TsEdit;
    edtAddress4: TsEdit;
    clabCountry: TsLabel;
    clabAddress: TsLabel;
    cLabName: TsLabel;
    btnClearAddresses: TsButton;
    pageMain: TPageControl;
    tabInvoice: TTabSheet;
    tabRoomPrice: TTabSheet;
    Panel2: TsPanel;
    memExtraText: TMemo;
    Panel4: TsPanel;
    btnRoomToTemp: TsButton;
    btnAddItem: TsButton;
    btnItemToTmp: TsButton;
    btnRemoveItem: TsButton;
    btnMoveItem: TsButton;
    btnMoveRoom: TsButton;
    btnRemoveLodgingTax2: TsButton;
    btnReservationNotes: TsButton;
    sPanel1: TsPanel;
    agrLines: TAdvStringGrid;
    panTopRoomRates: TsPanel;
    cxGroupBox4: TsGroupBox;
    btdEditRoomRate: TsButton;
    mRoomResDS: TDataSource;
    kbmRoomRatesDS: TDataSource;
    grRoomRes: TcxGrid;
    tvRoomRes: TcxGridDBTableView;
    tvRoomResColumn1: TcxGridDBColumn;
    tvRoomResRoom: TcxGridDBColumn;
    tvRoomResRoomDescription: TcxGridDBColumn;
    tvRoomResRoomType: TcxGridDBColumn;
    tvRoomResRoomTypeDescription: TcxGridDBColumn;
    tvRoomResArrival: TcxGridDBColumn;
    tvRoomResDeparture: TcxGridDBColumn;
    tvRoomResGuests: TcxGridDBColumn;
    tvRoomResChildrenCount: TcxGridDBColumn;
    tvRoomResinfantCount: TcxGridDBColumn;
    tvRoomResAvragePrice: TcxGridDBColumn;
    tvRoomResRateCount: TcxGridDBColumn;
    tvRoomResPriceCode: TcxGridDBColumn;
    tvRoomResRoomReservation: TcxGridDBColumn;
    tvRoomRates: TcxGridDBTableView;
    tvRoomRatesReservation: TcxGridDBColumn;
    tvRoomRatesRoomReservation: TcxGridDBColumn;
    tvRoomRatesRoomNumber: TcxGridDBColumn;
    tvRoomRatesRateDate: TcxGridDBColumn;
    tvRoomRatesPriceCode: TcxGridDBColumn;
    tvRoomRatesRate: TcxGridDBColumn;
    tvRoomRatesDiscount: TcxGridDBColumn;
    tvRoomRatesisPercentage: TcxGridDBColumn;
    tvRoomRatesShowDiscount: TcxGridDBColumn;
    tvRoomRatesisPaid: TcxGridDBColumn;
    tvRoomRatesDiscountAmount: TcxGridDBColumn;
    tvRoomRatesRentAmount: TcxGridDBColumn;
    tvRoomRatesNativeAmount: TcxGridDBColumn;
    lvRoomRes: TcxGridLevel;
    lvRoomRates: TcxGridLevel;
    sGroupBox2: TsGroupBox;
    chkReCalcPrices: TsCheckBox;
    sGroupBox1: TsGroupBox;
    sButton2: TsButton;
    sButton3: TsButton;
    tvRoomResAvrageDiscount: TcxGridDBColumn;
    tvRoomResisPercentage: TcxGridDBColumn;
    btnExit: TcxButton;
    btnInvoice: TcxButton;
    btnProforma: TcxButton;
    sButton1: TsButton;
    sButton4: TsButton;
    chkAutoUpdateNullPrice: TsCheckBox;
    labTmpStatus: TsLabel;
    sPanel2: TsPanel;
    clabTotalwoVAT: TsLabel;
    clavVAT: TsLabel;
    clabInvoiceTotal: TsLabel;
    edtTotal: TsEdit;
    edtVat: TsEdit;
    edtInvoiceTotal: TsEdit;
    PaymentsDS: TDataSource;
    sPanel3: TsPanel;
    labPayments: TsLabel;
    tvPayments: TcxGridDBTableView;
    lvPayments: TcxGridLevel;
    grPayments: TcxGrid;
    tvPaymentsPayDate: TcxGridDBColumn;
    tvPaymentsPayType: TcxGridDBColumn;
    tvPaymentsAmount: TcxGridDBColumn;
    tvPaymentsDescription: TcxGridDBColumn;
    tvPaymentsPayGroup: TcxGridDBColumn;
    tvPaymentsMemo: TcxGridDBColumn;
    tvPaymentsconfirmDate: TcxGridDBColumn;
    btnAddDownPayment: TsButton;
    clabDownpayments: TsLabel;
    edtDownPayments: TsEdit;
    clabBalance: TsLabel;
    edtBalance: TsEdit;
    btnEditDownPayment: TsButton;
    btnDeleteDownpayment: TsButton;
    tvPaymentsid: TcxGridDBColumn;
    rptDsLines: TfrxDBDataset;
    clabForeignCurrency: TsLabel;
    edtForeignCurrency: TsEdit;
    grbInclutedTaxes: TsGroupBox;
    labLodgingTaxISK: TsLabel;
    labLodgingTaxNights: TsLabel;
    labTaxNights: TsLabel;
    ClabLodgingTaxCurrency: TsLabel;
    MemData1: TdxMemData;
    MemData2: TdxMemData;
    actAddPackage: TAction;
    Action2: TAction;
    tvRoomResPackage: TcxGridDBColumn;
    chkShowPackage: TsCheckBox;
    mRoomRates: TdxMemData;
    mRoomRatesReservation: TIntegerField;
    mRoomRatesroomreservation: TIntegerField;
    mRoomRatesTmp: TdxMemData;
    mRoomRatesRoomNumber: TStringField;
    mRoomRatesPriceCode: TStringField;
    mRoomRatesRateDate: TDateTimeField;
    mRoomRatesRate: TFloatField;
    mRoomRatesDiscount: TFloatField;
    mRoomRatesisPercentage: TBooleanField;
    mRoomRatesShowDiscount: TBooleanField;
    mRoomRatesIsPaid: TBooleanField;
    mRoomRatesDiscountAmount: TFloatField;
    mRoomRatesRentAmount: TFloatField;
    IntegerField1: TIntegerField;
    mRoomRatesNativeAmount: TFloatField;
    IntegerField2: TIntegerField;
    StringField1: TStringField;
    DateTimeField1: TDateTimeField;
    StringField2: TStringField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    BooleanField1: TBooleanField;
    BooleanField2: TBooleanField;
    BooleanField3: TBooleanField;
    FloatField3: TFloatField;
    FloatField4: TFloatField;
    FloatField5: TFloatField;
    mRoomRes: TdxMemData;
    mRoomResReservation: TIntegerField;
    mRoomResroomreservation: TIntegerField;
    mRoomResRoom: TStringField;
    mRoomResRoomType: TStringField;
    mRoomResGuests: TIntegerField;
    mRoomResAvragePrice: TFloatField;
    mRoomResRateCount: TIntegerField;
    mRoomResRoomDescription: TStringField;
    mRoomResRoomTypeDescription: TStringField;
    mRoomResArrival: TDateTimeField;
    mRoomResDeparture: TDateTimeField;
    mRoomResChildrenCount: TIntegerField;
    mRoomResinfantCount: TIntegerField;
    mRoomResPriceCode: TStringField;
    mRoomResAvrageDiscount: TFloatField;
    mRoomResisPercentage: TBooleanField;
    mRoomResPackage: TWideStringField;
    mPayments: TdxMemData;
    mPaymentsPayDate: TDateField;
    mPaymentsPayType: TWideStringField;
    mPaymentsAmount: TFloatField;
    mPaymentsDescription: TWideStringField;
    mPaymentsPayGroup: TWideStringField;
    mPaymentsMemo: TMemoField;
    mPaymentsconfirmDate: TDateTimeField;
    mPaymentsid: TIntegerField;
    mPaymentsssss: TMemoField;
    mPaymentswww: TWideStringField;
    mPaymentsdddd: TDateField;
    mRR_: TdxMemData;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    StringField3: TStringField;
    DateTimeField2: TDateTimeField;
    StringField4: TStringField;
    FloatField6: TFloatField;
    FloatField7: TFloatField;
    BooleanField4: TBooleanField;
    BooleanField5: TBooleanField;
    BooleanField6: TBooleanField;
    FloatField8: TFloatField;
    FloatField9: TFloatField;
    FloatField10: TFloatField;
    mnuMoveItem: TPopupMenu;
    mnuMoveRoom: TPopupMenu;
    T1: TMenuItem;
    t2: TMenuItem;
    T3: TMenuItem;
    T4: TMenuItem;
    btnGetCustomer: TsButton;
    sPanel5: TsPanel;
    sPanel4: TsPanel;
    pnlInvoiceIndex0: TsPanel;
    pnlInvoiceIndex1: TsPanel;
    pnlInvoiceIndex2: TsPanel;
    pnlInvoiceIndex3: TsPanel;
    pnlInvoiceIndex4: TsPanel;
    pnlInvoiceIndex5: TsPanel;
    pnlInvoiceIndex6: TsPanel;
    pnlInvoiceIndex7: TsPanel;
    pnlInvoiceIndex8: TsPanel;
    pnlInvoiceIndex9: TsPanel;
    mnuInvoiceIndex: TPopupMenu;
    N01: TMenuItem;
    N11: TMenuItem;
    N31: TMenuItem;
    N41: TMenuItem;
    N51: TMenuItem;
    N61: TMenuItem;
    N71: TMenuItem;
    N81: TMenuItem;
    N91: TMenuItem;
    I1: TMenuItem;
    N5: TMenuItem;
    N12: TMenuItem;
    shpInvoiceIndex0: TShape;
    shpInvoiceIndexRR0: TShape;
    shpInvoiceIndex9: TShape;
    shpInvoiceIndexRR9: TShape;
    shpInvoiceIndex1: TShape;
    shpInvoiceIndexRR1: TShape;
    shpInvoiceIndex2: TShape;
    shpInvoiceIndexRR2: TShape;
    shpInvoiceIndex3: TShape;
    shpInvoiceIndexRR3: TShape;
    shpInvoiceIndex4: TShape;
    shpInvoiceIndexRR4: TShape;
    shpInvoiceIndex5: TShape;
    shpInvoiceIndexRR5: TShape;
    shpInvoiceIndex6: TShape;
    shpInvoiceIndexRR6: TShape;
    shpInvoiceIndex7: TShape;
    shpInvoiceIndexRR7: TShape;
    shpInvoiceIndex8: TShape;
    shpInvoiceIndexRR8: TShape;
    btnSaveChanges: TsButton;
    mRoomResInvoiceIndex: TIntegerField;
    mRoomResGroupAccount: TBooleanField;
    procedure FormCreate(Sender: TObject);
    procedure agrLinesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure edtTotalChange(Sender: TObject);
    procedure edtCustomerDblClick(Sender: TObject);
    procedure agrLinesGetEditText(Sender: TObject; ACol, ARow: integer;
      var Value: string);
    procedure btnProformaClick(Sender: TObject);
    procedure edtCurrencyDblClick(Sender: TObject);
    procedure edtCurrencyChange(Sender: TObject);
    procedure agrLinesDrawCell(Sender: TObject; ACol, ARow: integer;
      Rect: TRect; State: TGridDrawState);
    procedure edtCurrencyExit(Sender: TObject);
    procedure rgrInvoiceTypeClick(Sender: TObject);
    procedure actSaveAndExitExecute(Sender: TObject);
    procedure actPrintInvoiceExecute(Sender: TObject);
    procedure actPrintProformaExecute(Sender: TObject);
    procedure actDownPaymentExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure actAddLineExecute(Sender: TObject);
    procedure actDelLineExecute(Sender: TObject);
    procedure actRRtoTempExecute(Sender: TObject);
    procedure actItemToTempExecute(Sender: TObject);
    procedure actItemToGroupInvoiceExecute(Sender: TObject);
    procedure actCompressLinesExecute(Sender: TObject);
    procedure memExtraTextExit(Sender: TObject);
    procedure edtCustomerExit(Sender: TObject);
    procedure timCloseInvoiceTimer(Sender: TObject);
    procedure Refrence1Click(Sender: TObject);
    procedure GuestName1Click(Sender: TObject);
    procedure btnRemoveLodgingTax2Click(Sender: TObject);
    procedure edtRateDblClick(Sender: TObject);
    procedure btnClearAddressesClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure agrLinesGetCellColor(Sender: TObject; ARow, ACol: integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure btnItemToTmpClick(Sender: TObject);
    procedure btdEditRoomRateClick(Sender: TObject);
    procedure tvRoomResColumn1PropertiesButtonClick(Sender: TObject;
      AButtonIndex: integer);
    procedure tvRoomResAvragePricePropertiesEditValueChanged(Sender: TObject);
    procedure tvRoomResGuestsPropertiesEditValueChanged(Sender: TObject);
    procedure tvRoomResChildrenCountPropertiesEditValueChanged(Sender: TObject);
    procedure tvRoomResinfantCountPropertiesEditValueChanged(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure sButton4Click(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure edtCustomerChange(Sender: TObject);
    procedure btnEditDownPaymentClick(Sender: TObject);
    procedure btnDeleteDownpaymentClick(Sender: TObject);
    procedure agrLinesGetAlignment(Sender: TObject; ARow, ACol: integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure agrLinesColumnSize(Sender: TObject; ACol: integer;
      var Allow: boolean);
    procedure btnExitClick(Sender: TObject);
    procedure btnReservationNotesClick(Sender: TObject);
    procedure agrLinesCanEditCell(Sender: TObject; ARow, ACol: integer;
      var CanEdit: boolean);
    procedure actAddPackageExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure agrLinesCellValidate(Sender: TObject; ACol, ARow: integer;
      var Value: string; var Valid: boolean);
    procedure agrLinesDblClickCell(Sender: TObject; ARow, ACol: integer);
    procedure T1Click(Sender: TObject);
    procedure T3Click(Sender: TObject);
    procedure T4Click(Sender: TObject);
    procedure mnuMoveItemPopup(Sender: TObject);
    procedure mnuMoveRoomPopup(Sender: TObject);
    procedure agrLinesRowChanging(Sender: TObject; OldRow, NewRow: integer;
      var Allow: boolean);
    procedure pnlInvoiceIndex0DragOver(Sender, Source: TObject; X, Y: integer;
      State: TDragState; var Accept: boolean);
    procedure pnlInvoiceIndex0DragDrop(Sender, Source: TObject; X, Y: integer);
    procedure pnlInvoiceIndex0Click(Sender: TObject);
    procedure N91Click(Sender: TObject);
    procedure shpInvoiceIndex0MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure shpInvoiceIndex0DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure shpInvoiceIndex0DragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure tvPaymentsMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure tvPaymentsCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
    procedure btnSaveChangesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure agrLinesCheckBoxClick(Sender: TObject; ACol, ARow: Integer; State: Boolean);
  private
    { Private declarations }

    DeletedLines : TList<Integer>;
    linesNumDays,
    linesNumGuests : Integer;
    NumberGuestNights : Integer;


    zExit: boolean;
    TaxTypes: TStringList;

    // Global to see if some changes

    zFirsttime: boolean;
    zApply: boolean;
    zInitString: string;
    zChkCount: integer;
    zDataChanged: boolean;

    zEmailAddress: String;

    zDoSave: boolean;

    zCountry: string;

    zLstRooms: TList;
    SelectableRooms: TRoomInfoList;
    zInvoiceNumber: integer;
    zInvoiceDate: TDateTime;
    zConfirmDate: TDate;
    zPayDate: TDate;

    zCellValue: string;
    zRow, zCol: integer;
    zCellEdited: boolean;

    zbRoomRentinTemp: boolean;
    zLstLines: TList;

    // Global currency and Rate
    zCurrentCurrency: string;
    zCurrencyRate: Double;
    zNativeCurrency: string;
    zInitCurrency: string;

    zErr: boolean;

    tempInvoiceNo: integer;

    zRoomRentPaymentInvoice: integer;
    zStayTaxIncluded: boolean;

    zRefNum: integer;
    zbDoingReference: boolean;

    zCreditType: TCreditType;

    zLodgingTaxISK: Double;
    zLodgingTaxNights: integer;

    zRoomIsInTemp: boolean;

    useStayTaxAlreadyFetched: boolean;
    useStayTaxOutcome: boolean;

    tempInvoiceItemList: TInvoiceItemEntityList;

    selectedRoomReservation: integer;

    zRoomRSet: TRoomerDataset;
    zLocation: string;
    zS: string;
    FInvoiceIndex: integer;
    FAnyRowChecked: Boolean;

    FTotalRoomDiscount : Double;

    procedure applyChanges;
    procedure ApplyRateToOther(RoomReservation: integer; RoomType: string);
    procedure ApplyNettoRateToNullPrice(NewRate: Double;
      RoomReservation: integer; RoomType: string);
    procedure CalcOnePrice(RoomReservation: integer; NewRate: Double = 0);
    procedure UpdateCurrencyRoomPrice(RoomReservation: integer; Currency: string; CurrencyRate: Double; convert: Double);

    procedure EditRoomRateOneRoom(RoomRes: integer);
    procedure LoadInvoice;
    procedure loadInvoiceToMemtable(var m: TKbmMemTable);

    procedure setControls;

    function calcStayTax(reservation: integer): boolean;
    // function calcStayTax2(reservation: integer): boolean;

    procedure ClearObjects;

    procedure SetCurrentVisible;

    function GetLine(idx: integer): TInvoiceLine;

    function GetLineCount: integer;

    function AddLine(lineId : Integer; sItem, sText: string; iNumber: Double;
      FPrice, FTotal: Double; PurchaseDate: TDate; bAuto: boolean;
      Refrence, Source: string; isPackage: boolean; noGuests: integer;
      confirmDate: TDateTime; confirmAmount: Double; rrAlias: integer;
      AutoGen: string; itemIndex: integer = 0): integer;

    Function AddRoom(Room: String; fRoomPrice: Double; FromDate: TDate;
      ToDate: TDate; dayCount: integer; sText: string; bGetGuestName: boolean;
      RoomReservation: integer; DiscountAmount: Double;
      DiscountIsPercentage: boolean; DiscountText: string; GuestName: String;
      NumGuests: integer; isPackage: boolean; rrAlias: integer): integer;

    Procedure AddRoomTax(totalTax: Double; TaxUnits: Double;
      taxItem: String = ''; iAddAt: integer = 0);
    function RemoveStayTax: boolean;

    procedure ClearLines;
    function getDownPayments: Double;

    procedure DisplayMem(zrSet: TRoomerDataset);
    procedure DisplayGuestName(zrSet: TRoomerDataset);

    function DisplayLine(iRow, idx: integer): integer;

    procedure DisplayTotals(editCol: integer = -1; editRow: integer = -1;
      Value: Double = 0.00);
    procedure RestoreTMPInvoicelines;

    // procedure RemoveInvoice;
    procedure SaveHeader(FTotal, fVat, fWOVat: Double;
      aExecutionPlan: TRoomerExecutionPlan);

    function SaveInvoice(iInvoiceNumber: integer): boolean;

    procedure ForceSelectCell;

    procedure CheckCurrencyChange(oldCurrency: string);
    procedure CheckRateChange;

    procedure CompressLines(sSalesItem: string);
    procedure CheckRoomRentItem(iRow: integer);

    procedure LoadKreditLines;
    procedure MarkOriginalInvoiceAsCredited(iInvoice: integer);

    function isSystemLine(row: integer): boolean;
    // Function  isRoomRentLine(row : integer) : boolean;
    function PayInvoiceAndPrint: boolean;
    function GatherPayments(PayLines: TStringList; var days: integer): Double;
    procedure SetCustEdits;
    function GetInvoiceHeader(Res, RoomRes: integer): boolean; overload;
    function GetInvoiceHeader(Res, RoomRes: integer; arSet: TdxMemData)
      : boolean; overload;
    function GetInvoiceHeader(Res, RoomRes: integer; arSet: TRoomerDataset): boolean; overload;
    function GetReservationHeader(Res, RoomRes: integer): boolean;
    function GetMainGuestHeader(Res, RoomRes: integer): boolean;
    function GetCustomerHeader(Res: integer): boolean;
    function GetMainGuestName(Res, RoomRes: integer): string;
    procedure RemoveInvalidKreditInvoice;
    function GetInvoiceTotal: Double;
    procedure itemLookup;
    procedure AddEmptyLine(CheckChanged : Boolean = True);
    procedure AddEmptyLine1;

    procedure PrintProforma;
    // procedure DeleteProforma;
    procedure SaveProforma(iInvoiceNumber: integer);
    procedure SaveProformaHeader(FTotal, fVat, fWOVat: Double);
    procedure SaveProformapayments;
    procedure SaveAnd(doExit: boolean);
    procedure CreateCashInvoice(customer: string);

    function createAllStr: string;
    function chkChanged: boolean;
    procedure ItemToTemp(confirm : Boolean);
    procedure NullifyGrid;

    Procedure InitInvoiceGrid;
    function GenerateInvoiceNumber: integer;
    procedure AddDeleteFromInvoiceToExecutionPlan(aExecutionPlan
      : TRoomerExecutionPlan);

    function LocateDate(recordSet: TRoomerDataset; field: String;
      Value: TDateTime): boolean;
    procedure GetTaxTypes(TaxResultInvoiceLines: TInvoiceTaxEntityList);
    procedure HandleExceptionListFromBookKeepingSystem(invoiceNumber: integer;
      ErrorList: String);
    function FindLastRoomRentLine: integer;
    procedure CollectInvoice(iInvoiceNumber: integer);
    procedure UpdateItemInvoiceLinesForTaxCalculations;
    function CheckIfWithdrawlAllowed(removeIfNotAllowed: boolean;
      Editing: boolean): boolean;
    function CheckIfWithdrawlAllowed_X(Editing: boolean; Value: String)
      : boolean;
    procedure FormatCurrentLine(ARow: integer);
    function CreateProformaID: integer;
    procedure MoveRoomToGroupInvoice;
    procedure MoveItemToRoomInvoice(toRoomReservation: integer;
      InvoiceIndex: integer);
    procedure MoveRoomToRoomInvoice;
    procedure FillRoomsInMenu(mnuItem: TMenuItem);
    function RoomByRoomReservation(RoomReservation: integer): String;
    procedure LoadRoomList(reservation: integer);
    procedure DeleteRow(aGrid: TAdvStringGrid; iRow: integer);
    procedure ForceRowChange;
    procedure SetInvoiceIndex(const Value: integer);
    function IsInvoiceChanged(Ask : Boolean = True): boolean;
    procedure MoveItemToNewInvoiceIndex(rowIndex, toInvoiceIndex: integer);
    procedure MoveRoomToNewInvoiceIndex(rowIndex, toInvoiceIndex: integer);
    procedure CorrectInvoiceIndexRectangles;
    function GetInvoiceIndexPanel(Index: integer): TsPanel;
    procedure SetInvoiceIndexPanelsToZero;
    function GetInvoiceIndexItems(Index: integer): TShape;
    function GetInvoiceIndexItemsRR(Index: integer): TShape;
    procedure MoveDownpaymentToInvoiceIndex(toInvoiceIndex: Integer);
    function IsCashInvoice: boolean;
    function GetCalculatedNumberOfItems(ItemId: String; dDefault: Double): Double;
    procedure CheckCheckboxes;
    procedure CheckOrUncheckAll(check: Boolean);
    function IsAnyCheckboxChecked: Boolean;
    procedure SetAnyRowChecked(const Value: Boolean);
    function GetSelectedRows: TList<String>;
    function IndexOfAutoGen(AutoGen: String): Integer;
    procedure RemoveAllCheckboxes;
    function IsRoomSelected: Boolean;
    procedure RemoveCurrentProformeInvoice(ProformaInvoiceNumber: Integer);
    procedure DeleteLinesInList(ExecutionPlan: TRoomerExecutionPlan);
    function CellInvoiceLine(line: Integer): TInvoiceLine;
    function CellInvoiceLineId(line: Integer): Integer;
    function IsLineChanged(line, iMultiplier: Integer): Boolean;

    property InvoiceIndex: integer read FInvoiceIndex write SetInvoiceIndex;
  public
    { Public declarations }
    publicReservation, FRoomReservation: integer;
    FnewSplitNumber: integer; // 0 = herbergjareikningur
    // 1 = Credit Reikningur
    // 2 = Staðgreiðslureikningur
    FCredit: boolean;
    zFakeGroup: boolean;
    zFromKredit: boolean;

    OriginalInvoiceStatus: Double;

    property Lines[idx: integer]: TInvoiceLine read GetLine;
    function PrepareInvoice: boolean;
    procedure WndProc(var message: TMessage); override;

    property AnyRowChecked : Boolean read FAnyRowChecked write SetAnyRowChecked;
  published
    property lineCount: integer read GetLineCount;
  end;

var
  frmInvoice: TfrmInvoice;
  bModal: boolean;

procedure EditInvoice(reservation, RoomReservation, SplitNumber, InvoiceIndex: integer;
  Arrival, Departure: TDate; bCredit, aModal: boolean; fakeGroup: boolean; FromKredit : boolean=false);

implementation

uses
  dbTables,
  uMain,
  uFileDependencyManager,
  // uReservationWork,
  uCreditPrompt,
  // uInvoiceCompress,
  uFinishedInvoices2,
  uD,
  ueditRoomPrice,
  uDayNotes,
  uInvoicePayment,
  uCurrencies,
  uSqlDefinitions,
  uCustomers2,
  uitems2,
  uAppGlobal,
  uRoomerLanguage,
  uAssignPayment,
  PrjConst,
  uStringUtils,
  uDImages,
  uFrmHandleBookKeepingException,
  uFrmBackupInvoice,
  uRoomerDefinitions,
  uActivityLogs,
  UITypes
    ;

{$R *.DFM}

var
  memUpdateDone: boolean;
  RoomInfo: TRoomInfo;
  zOriginalInvoice: integer;

const
  // WM_StartUpLists = WM_User + 381;
  WM_FORMAT_LINE = WM_User + 290;

  REMOVE_CURRENT_PROFORMA_INVOICE : Array[0..2] OF String = (
            'DELETE FROM invoicelines WHERE invoiceNumber=%d',
            'DELETE FROM invoiceheads WHERE invoiceNumber=%d',
            'DELETE FROM payments WHERE invoiceNumber=%d'
            );

  REMOVE_REDUNDANT_INVOICES : Array[0..2] OF String = (
                                          // Credit invoices                          // Proforma invoices
            'DELETE FROM invoicelines WHERE (SplitNumber = 1 AND InvoiceNumber = -1) OR (InvoiceNumber > 1000000000)',
            'DELETE FROM invoiceheads WHERE (SplitNumber = 1 AND InvoiceNumber = -1) OR (InvoiceNumber > 1000000000)',
            'DELETE FROM payments WHERE InvoiceNumber > 1000000000'
            );

procedure EditInvoice(reservation, RoomReservation, SplitNumber, InvoiceIndex: integer;
  Arrival, Departure: TDate; bCredit, aModal: boolean; fakeGroup: boolean; FromKredit : boolean=false);
var
  _frmInvoice: TfrmInvoice;
begin
  _frmInvoice := TfrmInvoice.create(nil);
  try
    _frmInvoice.publicReservation := reservation;
    _frmInvoice.FRoomReservation := RoomReservation;
    _frmInvoice.FnewSplitNumber := SplitNumber;
    _frmInvoice.FInvoiceIndex := InvoiceIndex;
    _frmInvoice.FCredit := bCredit;
    _frmInvoice.zNativeCurrency := ctrlGetString('NativeCurrency');
    _frmInvoice.zFakeGroup  := fakeGroup;
    _frmInvoice.zFromKredit := FromKredit;
    _frmInvoice.LoadInvoice;

    if _frmInvoice.PrepareInvoice then
      _frmInvoice.ShowModal;

    // if _frmInvoice.modalresult = mrOk then
    // begin
    // debugmessage('OK');
    // end else
    // begin
    // debugmessage('NOT OK');
    // end;

  finally
    FreeAndNil(_frmInvoice);
  end;
end;

procedure EmptyStringGrid(Grid: TAdvStringGrid);
var
  i, l: integer;
begin
  // --
  for l := 1 to Grid.RowCount - 1 do
  begin
    Grid.SetCheckBoxState(col_Select, l, false);
    Grid.RemoveCheckBox(col_Select, l);
    for i := 0 to Grid.ColCount - 1 do
    begin
      Grid.Cells[i, l] := '';
    end;
  end;

  // --
  Grid.RowCount := 2;
  Grid.FixedRows := 1;
end;

{ TRoomInfo }

procedure TfrmInvoice.ForceRowChange;
var
  Allow: boolean;
begin
  Allow := True;
  agrLinesRowChanging(agrLines, agrLines.row, agrLines.row, Allow);
end;

procedure TfrmInvoice.RemoveAllCheckboxes;
var i : Integer;
begin
  for i := 0 to 200 do  // agrLines.RowCount - 1 do
    try if agrLines.HasCheckBox(col_Select, i) then
      agrLines.RemoveCheckBox(col_Select, i); Except end;
end;

procedure TfrmInvoice.DeleteRow(aGrid: TAdvStringGrid; iRow: integer);
var
  i, l: integer;
  check : Boolean;
begin
//  EmptyRow(aGrid, iRow);
  RemoveAllCheckboxes;
  agrLines.RemoveRows(iRow, 1);
//  if (iRow = 1) and (aGrid.RowCount = 2) then
//  begin
//  end
//  else
//  begin
//    for i := iRow + 1 to aGrid.RowCount - 1 do
//    begin
//      for l := 0 to aGrid.ColCount - 1 do
//      begin
//        aGrid.Cells[l, i - 1] := aGrid.Cells[l, i];
//        aGrid.Objects[l, i - 1] := aGrid.Objects[l, i];
//      end;
//    end;
//    aGrid.RowCount := aGrid.RowCount - 1;
//    EmptyRow(aGrid, aGrid.RowCount - 1);   // BHG
//  end;
  ForceRowChange;
end;

// HJ
function TfrmInvoice.isSystemLine(row: integer): boolean;
begin
  result := false;
  try
    result := agrLines.Objects[col_Item, row] = TObject(-2);
  except
  end;
end;

procedure TfrmInvoice.AddDeleteFromInvoiceToExecutionPlan(aExecutionPlan: TRoomerExecutionPlan);
var
  s: string;
begin
//  s := '';
//  s := s + 'DELETE FROM invoicelines ' + ''#10'';
//  s := s + ' where Reservation = ' + inttostr(publicReservation);
//  s := s + '   and RoomReservation = ' + inttostr(FRoomReservation);
//  s := s + '   and SplitNumber = ' + inttostr(FnewSplitNumber);
//  s := s + '   and InvoiceNumber = -1' + ''#10'';
//  s := s + '   and InvoiceIndex = ' + inttostr(FInvoiceIndex);
//  aExecutionPlan.AddExec(s);
  s := '';
  s := s + 'DELETE FROM invoiceheads ' + ''#10'';
  s := s + ' where Reservation = ' + inttostr(publicReservation);
  s := s + '   and RoomReservation = ' + inttostr(FRoomReservation);
  s := s + '   and SplitNumber = ' + inttostr(FnewSplitNumber);
  s := s + '   and InvoiceNumber = -1';
  aExecutionPlan.AddExec(s);
end;

procedure TfrmInvoice.cxButton3Click(Sender: TObject);
begin
  // **
end;

procedure TfrmInvoice.cxButton4Click(Sender: TObject);
begin
  // **
end;

function TfrmInvoice.IsInvoiceChanged(Ask : Boolean = True): boolean;
var
  s: string;
  Res: integer;

begin
  result := false;

  if zErr then
  begin
    close;
    exit;
  end;

  if FnewSplitNumber <> cCreditInvoive then // 1
  begin
    s := createAllStr;
    if (NOT Ask) OR (s <> zInitString) then
    begin
      // if MessageDlg('Save invoice changes?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) = mrYes then
      if Ask then
        Res := MessageDlg(GetTranslatedText('shTx_Invoice_SaveChanges'), mtConfirmation, [mbYes, mbNo, mbCancel], 0)
      else
        Res := mrYes;
      case Res of
        mrYes:
          begin
            if SaveInvoice(zInvoiceNumber) then
            begin
              zInitString := createAllStr;
              zInitCurrency := edtCurrency.Text;
              zDataChanged := chkChanged;
              try
                d.insertActivityLogFromMemTable;
              except
              end;
              result := false;

            end;
          end;
        mrCancel:
          begin
            result := True;
            exit;
          end;
      end;
    end;
  end;
end;

procedure TfrmInvoice.btnExitClick(Sender: TObject);
begin
  if NOT IsCashInvoice then
    IsInvoiceChanged;
  close;
end;

procedure TfrmInvoice.btnItemToTmpClick(Sender: TObject);
begin
  // ***
end;

procedure TfrmInvoice.btnClearAddressesClick(Sender: TObject);
begin
  edtAddress1.Text := '';
  edtAddress2.Text := '';
  edtAddress3.Text := '';
  edtAddress4.Text := '';
end;

procedure TfrmInvoice.btnRemoveLodgingTax2Click(Sender: TObject);
begin
  RemoveStayTax;
  RV_SetUseStayTax(publicReservation);
  calcStayTax(publicReservation); // 003
end;

procedure TfrmInvoice.btnReservationNotesClick(Sender: TObject);
begin
  // **
  g.openresMemo(publicReservation);

end;

procedure TfrmInvoice.btnSaveChangesClick(Sender: TObject);
begin
  IsInvoiceChanged(false);
  CorrectInvoiceIndexRectangles;
  LoadInvoice;
end;

procedure TfrmInvoice.ClearObjects;
begin
  while zLstRooms.Count > 0 do
  begin
    try
      TRoomInfo(zLstRooms[0]).free;
    except
    end;
    zLstRooms.delete(0)
  end;
end;

{ TInvoiceLine }
// ------------------------------------------------------------------------------
//
//
//
//
//
//
// ------------------------------------------------------------------------------

constructor TInvoiceLine.create(invoiceLine, _id: integer);
begin
  inherited create;

  FInvoiceLine := invoiceLine;

  FId := _id;
  FItem := '';
  FText := '';
  FNumber := 0;
  FPrice := 0.00;
  FTotal := 0.00;
  FRefrence := '';
  FSource := '';
end;

destructor TInvoiceLine.destroy;
begin
  inherited destroy;
end;

/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////

const
  vWidth: integer = 9;
  vDec: integer = 2;

  eWidth: integer = 12;
  eDec: integer = 4;

procedure TfrmInvoice.ClearLines;
var i : Integer;
begin
  while zLstLines.Count > 0 do
  begin
    try
      TInvoiceLine(zLstLines[0]).free;
    except
    end;
    zLstLines.delete(0);
  end;
  for i := 0 to agrLines.RowCount - 1 do
    if agrLines.HasCheckbox(col_Select, i) then
      agrLines.RemoveCheckBox(col_Select, i);
end;

function TfrmInvoice.AddLine(lineId : Integer;
  sItem, sText: string; iNumber: Double; // -96
  FPrice, FTotal: Double; PurchaseDate: TDate; bAuto: boolean;
  Refrence, Source: string; isPackage: boolean; noGuests: integer;
  confirmDate: TDateTime; confirmAmount: Double; rrAlias: integer;
  AutoGen: string; itemIndex: integer = 0): integer;
var
  invoiceLine: TInvoiceLine;
  iLast: integer;
begin
  if AutoGen = '' then
    AutoGen := _GetCurrentTick;

  iLast := 0;

  if GetLineCount > 0 then
  begin
    iLast := Lines[GetLineCount - 1].FInvoiceLine;
  end;

  inc(iLast);

  if trim(sItem) = '' then
    if copy(sText, 1, 5) = 'Tel: ' then
      sItem := trim(g.qPhoneUseItem);

  invoiceLine := TInvoiceLine.create(iLast, lineId);
  invoiceLine.FItem := sItem;
  invoiceLine.FText := sText;
  invoiceLine.FNumber := iNumber;
  invoiceLine.FPrice := FPrice;
  invoiceLine.FTotal := FTotal;
  invoiceLine.FAuto := bAuto;
  invoiceLine.FDate := PurchaseDate;
  invoiceLine.FRefrence := Refrence;
  invoiceLine.FSource := Source;
  invoiceLine.FIspackage := isPackage;
  invoiceLine.FNoGuests := noGuests;
  invoiceLine.FConfirmDate := confirmDate;
  invoiceLine.FConfirmAmount := confirmAmount;
  invoiceLine.FrrAlias := rrAlias;
  invoiceLine.itemIndex := itemIndex;
  invoiceLine.AutoGen := AutoGen;

  result := zLstLines.add(invoiceLine);
end;

function TfrmInvoice.GetLine(idx: integer): TInvoiceLine;
begin
  result := TInvoiceLine(zLstLines[idx]);
end;

function TfrmInvoice.GetLineCount: integer;
begin
  result := zLstLines.Count;
end;

function TfrmInvoice.CellInvoiceLineId(line : Integer) : Integer;
var InvoiceLine : TInvoiceLine;
begin
  InvoiceLine := CellInvoiceLine(line);
  if Assigned(InvoiceLine) then
    result := InvoiceLine.FId
  else
    result := 0;
end;

function TfrmInvoice.CellInvoiceLine(line : Integer) : TInvoiceLine;
begin
  result := nil;
  if (agrLines.Objects[col_Select, line] = nil) OR
     (NOT (agrLines.Objects[col_Select, line] IS TInvoiceLine)) then
    exit;
  result := TInvoiceLine(agrLines.Objects[col_Select, line]);
end;


function TfrmInvoice.DisplayLine(iRow, idx: integer): integer;
var
  invoiceLine: TInvoiceLine;
begin
  // --
  InvoiceLine := CellInvoiceLine(iRow);
  if NOT Assigned(InvoiceLine) then
    invoiceLine := Lines[idx];

  agrLines.Cells[col_Item, iRow] := invoiceLine.FItem;
  agrLines.Cells[col_Description, iRow] := invoiceLine.FText;
  agrLines.Cells[col_ItemCount, iRow] :=
    trim(_floattostr(invoiceLine.FNumber, vWidth, vDec));
  agrLines.Cells[col_ItemPrice, iRow] :=
    trim(_floattostr(invoiceLine.FPrice, vWidth, vDec));
  agrLines.Cells[col_TotalPrice, iRow] :=
    trim(_floattostr(invoiceLine.FTotal, vWidth, vDec));
  agrLines.Cells[col_System, iRow] := '';
  agrLines.Cells[col_Refrence, iRow] := invoiceLine.FRefrence;
  agrLines.Cells[col_Source, iRow] := invoiceLine.FSource;
  // **AA
  agrLines.Objects[col_Description, iRow] := TObject(trunc(invoiceLine.FDate));
  agrLines.Objects[col_ItemPrice, iRow] := invoiceLine;
  // -- PurchaseDate !
  if invoiceLine.FDate > 0 then
    agrLines.Cells[col_date, iRow] := datetostr(trunc(invoiceLine.FDate));

  agrLines.Cells[col_isPackage, iRow] := _bool2str(invoiceLine.FIspackage, 2);
  agrLines.Cells[col_NoGuests, iRow] := inttostr(invoiceLine.FNoGuests);

  // s := _dbDateAndTime(invoiceLine.FConfirmDate,false);
  // showmessage(s);

  agrLines.Cells[col_confirmdate, iRow] :=
    _dbDateAndTime(invoiceLine.FConfirmDate, false);
  agrLines.Cells[col_confirmAmount, iRow] := _db(invoiceLine.FConfirmAmount);

  if invoiceLine.FAuto then
    agrLines.Objects[col_Item, iRow] := TObject(-2) // -- Auto !
  else
    agrLines.Objects[col_Item, iRow] := TObject(invoiceLine.FInvoiceLine);
  // -- From File
  agrLines.Cells[col_rrAlias, iRow] := inttostr(invoiceLine.FrrAlias);

  agrLines.Cells[col_autogen, iRow] := invoiceLine.FAutoGen;

  agrLines.Objects[col_Select, iRow] := InvoiceLine; // -- Auto !

  result := iRow;
end;

procedure TfrmInvoice.DisplayTotals(editCol: integer = -1;
  editRow: integer = -1; Value: Double = 0.00);
var

  // dWork: Double;
  dVat: Double;

  i: integer;

  ItemTypeInfo: TItemTypeInfo;
  itemId: string;

  sPaymentItem: string;
  sRoomRentItem: string;
  sDiscountItem: string;

  TotalDownPayments: Double;
  TotalBalance: Double;

  ttVAT: Double;

  itemAmount: Double;
  ttItemAmount: Double;
  ttItemVat: Double;

  taxAmount: Double;
  ttTaxAmount: Double;
  ttTaxVat: Double;

  rentAmount: Double;
  ttRentAmount: Double;
  ttRentNumber: Double;

  nativeRent: Double;
  nativeTotal: Double;

  nativeTaxAmount: Double;

  rentVat: Double;
  ItemKind: TItemKind;

  lInvRoom: TInvoiceRoomEntity;

begin
  Screen.Cursor := crHourglass;
  // Application.processmessages;
  try
    sPaymentItem := _trimlower(g.qPaymentItem);
    sRoomRentItem := _trimlower(g.qRoomRentItem);
    sDiscountItem := _trimlower(g.qDiscountItem);

    ttItemAmount := 0.00;
    ttItemVat := 0.00;

    ttRentAmount := 0.00;
    ttRentNumber := 0.00;
    ttTaxAmount := 0.00;
    ttTaxVat := 0.00;

    rentVat := 0.00;
    nativeTaxAmount := 0.00;
    taxAmount := 0.00;

    // --
    for i := 1 to agrLines.RowCount - 1 do
    begin
      itemId := _trimlower(agrLines.Cells[col_Item, i]);
      if trim(itemId) <> '' then
      begin
        ItemKind := Item_GetKind(itemId);

        if itemId <> '' then
        begin
          // ef ekki greiðsla
          if sPaymentItem <> itemId then
          begin
            if ((ItemKind <> ikRoomRent) and (ItemKind <> ikRoomRentDiscount)
              and (ItemKind <> ikStayTax)) then
            begin
              try
                if (editCol = col_ItemCount) AND (editRow = i) then
                  itemAmount := Value *
                    _StrToFloat(agrLines.Cells[col_ItemPrice, i])
                else if (editCol = col_ItemPrice) AND (editRow = i) then
                  itemAmount := Value *
                    _StrToFloat(agrLines.Cells[col_ItemCount, i])
                else
                  itemAmount :=
                    _StrToFloat(agrLines.Cells[col_TotalPrice, i]);
              except
                itemAmount := 0;
              end;

              ItemTypeInfo := d.Item_Get_ItemTypeInfo(itemId,
                agrLines.Cells[col_Source, i]);
              // if editCol <> -1 then
              // begin
              lInvRoom := TInvoiceRoomEntity.create(itemId, 1, _StrToFloat(agrLines.Cells[col_ItemCount, i]), taxAmount, 0, 0);
              try
                dVat := GetVATForItem(itemId, itemAmount, _StrToFloat(agrLines.Cells[col_ItemCount, i]),
                                      lInvRoom, tempInvoiceItemList, ItemTypeInfo, edtCustomer.Text);
              finally
                lInvRoom.Free;
              end;
              agrLines.Cells[col_Vat, i] :=
                trim(_floattostr(dVat, vWidth, 3));
              // end;
              // Formula
              // dWork := itemAmount / (1 + (ItemTypeInfo.VATPercentage / 100));
              // dVat := itemAmount - dWork;
              ttItemAmount := ttItemAmount + itemAmount;
              ttItemVat := ttItemVat + dVat;
            end
            else if ((ItemKind = ikStayTax)) then
            begin
              ItemTypeInfo := d.Item_Get_ItemTypeInfo(itemId,
                agrLines.Cells[col_Source, i]);
              try
                taxAmount := _StrToFloat(agrLines.Cells[col_TotalPrice, i]);
              except
                taxAmount := 0;
              end;
              ttTaxAmount := ttTaxAmount + taxAmount;
              nativeTaxAmount := (ttTaxAmount * zCurrencyRate);
              lInvRoom := TInvoiceRoomEntity.create(itemId, 1, _StrToFloat(agrLines.Cells[col_ItemCount, i]), taxAmount, 0, 0);
              try
                dVat := zCurrencyRate * GetVATForItem(itemId, taxAmount,_StrToFloat(agrLines.Cells[col_ItemCount, i]),
                                                      lInvRoom, tempInvoiceItemList, ItemTypeInfo, edtCustomer.Text);
              finally
                lInvRoom.Free;
              end;
              agrLines.Cells[col_Vat, i] :=
                trim(_floattostr(dVat, vWidth, 3));
            end
            else
            begin
              try
                rentAmount := _StrToFloat(agrLines.Cells[col_TotalPrice, i]);
              except
                rentAmount := 0;
              end;
              ttRentAmount := ttRentAmount + rentAmount;
              ttRentNumber := ttRentNumber + _StrToFloat(agrLines.Cells[col_ItemCount, i]);
            end;
          end
        end;
      end;
    end;

    nativeRent := (ttRentAmount * zCurrencyRate);
    nativeTotal := nativeRent + ttItemAmount + nativeTaxAmount;

    if ABS(nativeRent) > 0.00 then
    begin
      ItemTypeInfo := d.Item_Get_ItemTypeInfo(trim(g.qRoomRentItem));
      lInvRoom := TInvoiceRoomEntity.create(g.qRoomRentItem, 1, 1, nativeRent, 0, 0);
      try
        dVat := GetVATForItem(g.qRoomRentItem, nativeRent, ttRentNumber, // 1,
                              lInvRoom, tempInvoiceItemList, ItemTypeInfo, edtCustomer.Text);
      finally
        lInvRoom.Free;
      end;
      rentVat := dVat;
    end;

    ttVAT := roundDecimals(ttItemVat + rentVat + ttTaxVat,
      ctrlGetInteger('VATDecimals'));

    edtTotal.Text := trim(_floattostr((nativeTotal) - ttVAT, vWidth, vDec));
    edtVat.Text := trim(_floattostr(ttVAT, vWidth, vDec));

    edtInvoiceTotal.Text := trim(_floattostr(nativeTotal, vWidth, vDec));

    TotalDownPayments := getDownPayments;
    TotalBalance := nativeTotal - TotalDownPayments;

    edtDownPayments.Text := trim(_floattostr(TotalDownPayments, vWidth, vDec));
    edtBalance.Text := trim(_floattostr(TotalBalance, vWidth, vDec));

    if (edtCurrency.Text <> '') and (edtCurrency.Text <> zNativeCurrency) then
      edtForeignCurrency.Text :=
        _floattostr((nativeTotal) / GetRate(edtCurrency.Text), vWidth, vDec);

  finally
    Screen.Cursor := crDefault;
    // Application.processmessages;
  end;
end;

procedure TfrmInvoice.DisplayMem(zrSet: TRoomerDataset);
begin
  with zrSet do
  begin
    first;
    if not eof then
    begin
      memExtraText.Lines.Text := trim(FieldByName('ExtraText').asString);
    end;
  end;
end;

procedure TfrmInvoice.DisplayGuestName(zrSet: TRoomerDataset);
begin
  if zrSet = nil then
  begin
    exit;
  end;
  if copy(edtRoomGuest.Text, 1, 1) <> '-' then
  begin
    edtRoomGuest.Text := GetMainGuestName(publicReservation,
      FRoomReservation);
  end;
end;

procedure TfrmInvoice.AddRoomTax(totalTax: Double; TaxUnits: Double;
  taxItem: String = ''; iAddAt: integer = 0);
var
  Item: string;
  aText: string;
  rSet: TRoomerDataset;

  confirmDate: TDateTime;
  confirmAmount: Double;
  unitPrice: Double;

  idx: integer;

begin
  if zFromKredit then Exit;

  confirmDate := 2;
  confirmAmount := 0;

  rSet := CreateNewDataSet;
  try

    rSet.CommandType := cmdText;
    if taxItem = '' then
      taxItem := g.qStayTaxItem;
    aText := Item_GetDescription(taxItem);
    Item := trim(taxItem);

    unitPrice := 0.00;
    if totalTax <> 0 then
    begin
      unitPrice := totalTax / TaxUnits;
    end;

    idx := AddLine(0, Item, aText, TaxUnits, unitPrice, totalTax, 0, True, '', '',
      false, 0, confirmDate, confirmAmount, -1, _GetCurrentTick); // 77ATH

    // --
    // agrLines.Objects[col_Item, agrLines.RowCount - 1] := pointer(100);
    agrLines.InsertRows(iAddAt, 1);
    EmptyRow(agrLines, iAddAt);
    // agrLines.RowCount := agrLines.RowCount + 1;
    DisplayLine(iAddAt, idx);
  finally
    FreeAndNil(rSet);
  end;
end;

procedure TfrmInvoice.SetCurrentVisible;
begin
  if agrLines.RowCount > agrLines.VisibleRowCount then
  begin
    if (agrLines.row > agrLines.TopRow + agrLines.VisibleRowCount - 1) then
      agrLines.TopRow := agrLines.row - agrLines.VisibleRowCount + 1
    else if (agrLines.row < agrLines.TopRow) then
      agrLines.TopRow := agrLines.row;
  end;
end;

procedure TfrmInvoice.CreateCashInvoice(customer: string);
var
  CustomerHolder: recCustomerHolderEX;
begin
  d.RemoveInvoiceCashInvoice;

  Panel1.Color := $00FFDDDD; // $00EAFFEA
  Panel2.Color := $00FFDDDD; // $00EAFFEA

  rgrInvoiceType.itemIndex := 4;

  CustomerHolder := hData.Customer_GetHolder(g.qRackCustomer);

  // SQL 108 xINSERT InvoiceHeads
  // INS-InvoiceHeads
  zS := '';
  zS := zS + 'INSERT into invoiceheads ' + #10;
  zS := zS + '(' + #10;
  zS := zS + '  Reservation ' + #10;
  zS := zS + ', RoomReservation ' + #10;
  zS := zS + ', SplitNumber ' + #10;

  zS := zS + ', InvoiceNumber ' + #10;
  zS := zS + ', InvoiceDate ' + #10;

  zS := zS + ', Customer ' + #10;
  zS := zS + ', Name ' + #10;

  zS := zS + ', CustPId ' + #10;
  zS := zS + ', Address1 ' + #10;
  zS := zS + ', Address2 ' + #10;
  zS := zS + ', Address3 ' + #10;
  zS := zS + ', Address4 ' + #10;
  zS := zS + ', Country ' + #10;
  zS := zS + ', Total ' + #10;;
  zS := zS + ', TotalWOVat ' + #10;;
  zS := zS + ', TotalVat ' + #10;;
  zS := zS + ', TotalBreakfast ' + #10;
  zS := zS + ', ExtraText ' + #10;
  zS := zS + ', Finished ' + #10;
  zS := zS + ', InvoiceType ' + #10;
  zS := zS + ', ihStaff ' + #10;
  zS := zS + ', ihDate ' + #10;
  zS := zS + ', ihInvoiceDate ' + #10;
  zS := zS + ', ihConfirmDate ' + #10;
  zS := zS + ', ihPayDate ' + #10;
  zS := zS + ', ihCurrency ' + #10; // **98
  zS := zS + ', ihCurrencyrate ' + #10; // **98
  zS := zS + ', Location ' + #10; // **98
  zS := zS + ')' + #10;

  zS := zS + 'Values' + #10;
  zS := zS + '(' + #10;
  zS := zS + '  ' + _db(publicReservation);
  zS := zS + ', ' + _db(FRoomReservation);
  zS := zS + ', ' + _db(FnewSplitNumber);
  zS := zS + ', ' + _db(zInvoiceNumber);
  zS := zS + ', ' + _db(zInvoiceDate);

  zS := zS + ', ' + _db(CustomerHolder.customer);
  zS := zS + ', ' + _db(CustomerHolder.DisplayName);
  zS := zS + ', ' + _db(CustomerHolder.PID);
  zS := zS + ', ' + _db('');
  zS := zS + ', ' + _db('');
  zS := zS + ', ' + _db('');
  zS := zS + ', ' + _db('');
  zS := zS + ', ' + _db(ctrlGetString('country'));
  zS := zS + ', ' + _db(0);
  zS := zS + ', ' + _db(0);
  zS := zS + ', ' + _db(0);
  zS := zS + ', ' + _db(0);
  zS := zS + ', ' + _db(memExtraText.Lines.Text);
  zS := zS + ', ' + _db(false);
  zS := zS + ', ' + _db(rgrInvoiceType.itemIndex);
  zS := zS + ', ' + _db(g.qUser);
  zS := zS + ', ' + _db(Date);
  zS := zS + ', ' + _dbDT(zInvoiceDate);
  zS := zS + ', ' + _db(zConfirmDate);
  zS := zS + ', ' + _db(zPayDate);
  zS := zS + ', ' + _db(edtCurrency.Text);
  zS := zS + ', ' + _db(_StrToFloat(edtRate.Text));
  zS := zS + ', ' + _db(zLocation);

  zS := zS + ')' + #10;

  if not cmd_bySQL(zS) then
  begin
  end;

  rgrInvoiceType.itemIndex := 4;
  edtCustomer.Text := CustomerHolder.customer;
  edtPersonalId.Text := CustomerHolder.PID;
  edtName.Text := CustomerHolder.CustomerName;
end;

procedure TfrmInvoice.RestoreTMPInvoicelines;
var
  rSet: TRoomerDataset;
  itemNumber: integer;
  itemId: string;
  Description: string;
  Price: Double;
  VATType: string;
  Total: Double;
  TotalWOVat: Double;
  Vat: Double;
  CurrencyRate: Double;
  Currency: string;
  Persons: integer;
  Nights: integer;

  importRefrence: string;
  ImportSource: string;

  tmpData: string;

  vTotal: Double;
  vTotalWOVat: Double;
  vVat: Double;

  Number: Double; // -96
  OrginalRef: integer;

  PurchaseDate: TDateTime;

  AYear, AMon, ADay: Word;
  isPackage: boolean;
  s: string;
  orderStr: string;

  confirmDate: TDateTime;
  confirmAmount: Double;

begin
  // ILTMP

  orderStr := ' Roomreservation,ItemNumber ';
  OrginalRef := 0;

  if d.InvoiceLinesTmp_exists(FRoomReservation) then
  begin
    rSet := TRoomerDataset.create(nil);
    try
      s := select_qryGetInvoiceLinesTmp(FRoomReservation);
      s := format(s, [FRoomReservation, orderStr]);
      if hData.rSet_bySQL(rSet, s) then
      begin
        vTotal := 0;
        vTotalWOVat := 0;
        vVat := 0;

        while not rSet.eof do
        begin
          CurrencyRate := LocalFloatValue(rSet.FieldByName('CurrencyRate')
            .asString);
          Currency := rSet.FieldByName('Currency').asString;
          itemId := rSet.FieldByName('ItemId').asString;
          Price := LocalFloatValue(rSet.FieldByName('Price').asString);
          Total := LocalFloatValue(rSet.FieldByName('Total').asString);
          TotalWOVat := LocalFloatValue(rSet.FieldByName('TotalWOVat')
            .asString);
          Vat := LocalFloatValue(rSet.FieldByName('Vat').asString);
          Number := rSet.GetFloatValue(rSet.FieldByName('Number')); // -96
          VATType := rSet.FieldByName('VATType').asString;
          OrginalRef := rSet.FieldByName('InvoiceNumber').asinteger;
          PurchaseDate := rSet.FieldByName('PurchaseDate').asdateTime;
          itemNumber := rSet.FieldByName('itemNumber').asinteger;
          Description := rSet.FieldByName('Description').asString;
          Persons := rSet.FieldByName('Persons').asinteger;
          Nights := rSet.FieldByName('Nights').asinteger;
          isPackage := rSet.FieldByName('isPackage').asBoolean;

          vTotal := vTotal + Total;
          vTotalWOVat := vTotalWOVat + TotalWOVat;
          vVat := vVat + Vat;

          importRefrence := rSet.FieldByName('importRefrence').asString;
          ImportSource := rSet.FieldByName('ImportSource').asString;

          confirmDate := rSet.FieldByName('ConfirmDate').asdateTime;
          confirmAmount := rSet.GetFloatValue
            (rSet.FieldByName('ConfirmAmount'));

          tmpData := rSet.FieldByName('tmpData').asString;

          try
            decodedate(PurchaseDate, AYear, AMon, ADay);
          except
            decodedate(now, AYear, AMon, ADay);
          end;

          // SQL 107 INSERxT InvoiveLines
          zS := '' + #10;
          zS := zS + 'INSERT into invoicelines' + #10;
          zS := zS + '(' + #10;
          zS := zS + '  Reservation ' + #10;
          zS := zS + ', AutoGen ' + #10;
          zS := zS + ', RoomReservation ' + #10;
          zS := zS + ', SplitNumber ' + #10;
          zS := zS + ', ItemNumber ' + #10;
          zS := zS + ', PurchaseDate ' + #10;
          zS := zS + ', InvoiceNumber ' + #10;
          zS := zS + ', ItemId ' + #10;
          zS := zS + ', Number ' + #10;
          zS := zS + ', Description ' + #10;
          zS := zS + ', Price ' + #10;
          zS := zS + ', VATType ' + #10;
          zS := zS + ', Total ' + #10;
          zS := zS + ', TotalWOVat ' + #10;
          zS := zS + ', VAT ' + #10;
          zS := zS + ', CurrencyRate ' + #10;
          zS := zS + ', Currency ' + #10;
          zS := zS + ', Persons ' + #10;
          zS := zS + ', Nights ' + #10;
          zS := zS + ', BreakfastPrice ' + #10;
          zS := zS + ', AutoGenerated ' + #10;

          zS := zS + ', AYear ' + #10;
          zS := zS + ', AMon ' + #10;
          zS := zS + ', ADay ' + #10;

          zS := zS + ', importRefrence ' + #10;
          zS := zS + ', ImportSource ' + #10;
          zS := zS + ', isPackage ' + #10;
          zS := zS + ', confirmdate ' + #10;
          zS := zS + ', confirmAmount ' + #10;
          zS := zS + ', staffCreated ' + #10;

          zS := zS + ')' + #10;
          zS := zS + 'Values' + #10;

          zS := zS + '(' + #10;
          zS := zS + '  ' + _db(publicReservation);
          zS := zS + ', ' + _db(_GetCurrentTick);
          zS := zS + ', ' + _db(FRoomReservation);
          zS := zS + ', ' + _db(FnewSplitNumber);
          zS := zS + ', ' + _db(itemNumber);
          zS := zS + ', ' + _DateToDbDate(PurchaseDate, True);
          zS := zS + ', ' + _db(zInvoiceNumber);
          zS := zS + ', ' + _db(itemId);
          zS := zS + ', ' + _db(Number);
          zS := zS + ', ' + _db(Description);
          zS := zS + ', ' + _db(Price);
          zS := zS + ', ' + _db(VATType);
          zS := zS + ', ' + _db(Total);
          zS := zS + ', ' + _db(TotalWOVat);
          zS := zS + ', ' + _db(Vat);
          zS := zS + ', ' + _db(CurrencyRate);
          zS := zS + ', ' + _db(Currency);
          zS := zS + ', ' + _db(Persons);
          zS := zS + ', ' + _db(Nights);
          zS := zS + ', ' + _db(0.00);
          zS := zS + ', ' + _db(false);

          zS := zS + ', ' + _db(AYear);
          zS := zS + ', ' + _db(AMon);
          zS := zS + ', ' + _db(ADay);
          zS := zS + ', ' + _db(importRefrence);
          zS := zS + ', ' + _db(ImportSource);
          zS := zS + ', ' + _db(isPackage);
          zS := zS + ', ' + _db(confirmDate);
          zS := zS + ', ' + _db(confirmAmount);
          zS := zS + ', ' + _db(d.roomerMainDataSet.username);

          zS := zS + ')' + #10;

          if not cmd_bySQL(zS) then
          begin
          end;

          rSet.Next;
        end;
        d.del_InvoiceLinesTmp(FRoomReservation);

        if OrginalRef > 0 then
          zOriginalInvoice := OrginalRef;
      end;
    finally
      FreeAndNil(rSet);
    end;
  end;
end;

Procedure TfrmInvoice.InitInvoiceGrid;
var
  iWidth, i: Integer;
begin
  EmptyStringGrid(agrLines);
  agrLines.ColCount := col_autogen + 1;
  agrLines.RowCount := 2;
  agrLines.Cells[col_Item, 0] := GetTranslatedText('shTxInvoice_Form_Header_Item');
  agrLines.Cells[col_Description, 0] := GetTranslatedText('shTxInvoice_Form_Header_Text');
  agrLines.Cells[col_ItemCount, 0] := GetTranslatedText('shTxInvoice_Form_Header_Number');
  agrLines.Cells[col_ItemPrice, 0] := GetTranslatedText('shTxInvoice_Form_Header_UnitPrice');
  agrLines.Cells[col_TotalPrice, 0] := GetTranslatedText('shTxInvoice_Form_Header_Total');
  agrLines.Cells[col_System, 0] := ' !';
  agrLines.Cells[col_Refrence, 0] := GetTranslatedText('shTxInvoice_Form_Header_Reference');
  agrLines.Cells[col_Source, 0] := GetTranslatedText('shTxInvoice_Form_Header_Source');
  agrLines.Cells[col_isPackage, 0] := GetTranslatedText('shTxInvoice_Form_Header_Package');
  agrLines.Cells[col_NoGuests, 0] := GetTranslatedText('shTxInvoice_Form_Header_Guests');
  agrLines.Cells[col_confirmdate, 0] := GetTranslatedText('shTxInvoice_Form_Header_Confirmdate');
  agrLines.Cells[col_confirmAmount, 0] := GetTranslatedText('shTxInvoice_Form_Header_ConfirmAmount');
  agrLines.Cells[col_Vat, 0] := GetTranslatedText('shTxInvoice_Form_Header_Vat');
  agrLines.Cells[col_rrAlias, 0] := GetTranslatedText('shTxInvoice_Form_Header_Alias');
  agrLines.Cells[col_autogen, 0] := 'ID';

  agrLines.AutoFitColumns(false);
  agrLines.ColWidths[col_Item] := 100;
  agrLines.ColWidths[col_ItemCount] := 100;
  agrLines.ColWidths[col_ItemPrice] := 100;
  agrLines.ColWidths[col_TotalPrice] := 100;
  agrLines.ColWidths[col_Source] := 60;
  agrLines.ColWidths[col_Select] := 30;
  iWidth := agrLines.ClientWidth -
            agrLines.ColWidths[col_Item] -
            agrLines.ColWidths[col_ItemCount] -
            agrLines.ColWidths[col_ItemPrice] -
            agrLines.ColWidths[col_TotalPrice] -
            agrLines.ColWidths[col_Source] -
            agrLines.ColWidths[col_Select] -
            5;

  if iWidth > 0 then
    agrLines.ColWidths[col_Description] := iWidth;

  agrLines.HideColumn(col_System);
  agrLines.HideColumn(col_Refrence);
  agrLines.HideColumns(col_isPackage,col_AutoGen);

  for i := 0 to agrLines.ColCount - 1 do
    if agrLines.IsHiddenColumn(i) then
      agrLines.ColWidths[i] := 0;

end;

function TfrmInvoice.AddRoom(Room: String; fRoomPrice: Double; FromDate: TDate;
  ToDate: TDate; dayCount: integer; sText: string; bGetGuestName: boolean;
  RoomReservation: integer; DiscountAmount: Double;
  DiscountIsPercentage: boolean; DiscountText: string; GuestName: String;
  NumGuests: integer; isPackage: boolean; rrAlias: integer): integer;
var
  i, idx, iCol: integer;

  RmRntItem: string;
  ItemTypeInfo: TItemTypeInfo;
  fWork: Double;
  DiscountItem: string;

  sGuestName: string;
  iNumGuests: integer;
  confirmDate: TDateTime;
  confirmAmount: Double;

  rrText: string;
  aText: string;


begin

  confirmDate := 2;
  confirmAmount := 0;

  // rSet := CreateNewDataSet;
  // try
  //
  // rSet.CommandType := cmdText;

  RmRntItem := trim(g.qRoomRentItem);
  RoomInfo := TRoomInfo.create;

  sText := trim(sText);
  rrText := Item_GetDescription(RmRntItem);

  if copy(sText, 1, 2) = '--' then
  begin
    rrText := '';
    sText := copy(sText, 3, maxint);
  end;

  if copy(sText, 1, 2) = '&-' then
  begin
    rrText := '';
    sText := copy(sText, 3, maxint);
  end;

  if copy(sText, 1, 2) = '&&' then
  begin
    bGetGuestName := True;
    sText := copy(sText, 3, maxint);
  end;

  sGuestName := GuestName;
  // RR_GetFirstGuestNameFast(RoomReservation);
  iNumGuests := NumGuests; // d.RR_GetGuestCount(RoomReservation);

  // iNights :=  trunc(ToDate) - trunc(FromDate); // -- Number of nights

  if not bGetGuestName then
  begin
    if rrText <> '' then
    begin
      aText := rrText + ' (' + sText + ') '
    end
    else
    begin
      aText := sText;
    end;
  end
  else
  begin
    sText := trim(sGuestName) + ' (' + sText + ') '
  end;

  idx := AddLine(0, RmRntItem, sText, dayCount, fRoomPrice, fRoomPrice * dayCount,
    0, True, '', '', isPackage, iNumGuests, confirmDate, confirmAmount, rrAlias,
    _GetCurrentTick); // *77

  // --
  iCol := agrLines.RowCount;
  if (agrLines.RowCount = 2) and (agrLines.Cells[col_Item, 1] = '') then
    dec(iCol);

  inc(iCol);
  agrLines.RowCount := iCol;

  i := DisplayLine(iCol - 1, idx);
  // -- Attach the Room information
  RoomInfo.FRoomReservation := RoomReservation;
  RoomInfo.FReservation := publicReservation;
  RoomInfo.FName := sGuestName;
  RoomInfo.FFrom := FromDate;
  RoomInfo.FTo := ToDate;
  RoomInfo.FPrice := fRoomPrice;
  RoomInfo.FDiscount := 0.00;
  RoomInfo.FRoom := Room;
  RoomInfo.FNumPersons := iNumGuests;

  agrLines.Objects[col_ItemCount, i] := RoomInfo;
  zLstRooms.add(RoomInfo);

  // -- Discount

  if DiscountAmount <> 0 then
  begin
    DiscountItem := trim(g.qDiscountItem);
    ItemTypeInfo := d.Item_Get_ItemTypeInfo(DiscountItem);

    // fWork := fRoomPrice;
    // if DiscountIsPercentage then
    // begin
    // fWork := (trunc(fWork * discountAmount / 100)) * - 1;
    // sDiscType := ' %';
    // end else
    // begin
    // // fWork := ( fWork - RoomResSet.FieldByName( 'Discount' ).asString) ) * -1;
    // fWork := (discountAmount) * - 1;
    // sDiscType := ' ' + edtCurrency.Text;
    // end;

    DiscountText := Item_GetDescription(DiscountItem) + ' ' + DiscountText;

    fWork := fRoomPrice;
    if DiscountIsPercentage then
    begin
      // ATH  fWork := (trunc(fWork * discountAmount / 100)) * - 1;
      fWork := (fWork * DiscountAmount / 100) * -1;
    end
    else
    begin
      fWork := (DiscountAmount) * -1;
    end;

    idx := AddLine(0, DiscountItem, DiscountText, dayCount, fWork,
      fWork * dayCount, 0, True, '', '', false, NumGuests, confirmDate,
      confirmAmount, rrAlias, _GetCurrentTick);

    RoomInfo.FDiscount := fWork * dayCount;

    FTotalRoomDiscount := FTotalRoomDiscount + (fWork * dayCount);

    iCol := agrLines.RowCount;

    if (agrLines.RowCount = 2) and (agrLines.Cells[col_Item, 1] = '') then
    begin
      dec(iCol);
    end;

    inc(iCol);
    agrLines.RowCount := iCol;
    DisplayLine(iCol - 1, idx);
  end;

  UpdateItemInvoiceLinesForTaxCalculations;

  // -- Discount end...
  result := 0;
  // **** calcStayTax(publicReservation);
  DisplayTotals;
  // finally
  // freeandNil(rSet);
  // end;
end;




// var
// roomReservation : integer;
// begin
// RoomReservation := mRoomRes.FieldByName('RoomReservation').AsInteger;
// ApplyRateToOther(roomreservation,'');
// end;

procedure TfrmInvoice.sButton1Click(Sender: TObject);
var
  RoomReservation: integer;
begin
  RoomReservation := mRoomRes.FieldByName('RoomReservation').asinteger;
  ApplyRateToOther(RoomReservation, '');
end;

procedure TfrmInvoice.sButton2Click(Sender: TObject);
begin

  if zFakeGroup then
  begin
    close;
  end
  else
  begin
    pageMain.ActivePageIndex := 0;
    btnExit.Enabled := True;
    btnInvoice.Enabled := True;
    btnProforma.Enabled := True;

  end;
  // btnGetCurrency.Visible := false;
  // btnGetRate.Visible := false;
end;

procedure TfrmInvoice.sButton3Click(Sender: TObject);
begin

  if zFakeGroup then
  begin
    applyChanges;
    close;
  end
  else
  begin
    zApply := True;
    pageMain.ActivePageIndex := 0;
    applyChanges;
    SaveAnd(false);
    ClearObjects;
    ClearLines;
    FormCreate(nil);
    agrLines.OnSelectCell := nil;
    zFirsttime := false;
    LoadInvoice;
    loadInvoiceToMemtable(d.mInvoicelines_after);
    PrepareInvoice;
  end;
  btnExit.Enabled := True;
  btnInvoice.Enabled := True;
  btnProforma.Enabled := True;
end;

procedure TfrmInvoice.sButton4Click(Sender: TObject);
var
  RoomType: string;
  RoomReservation: integer;
begin
  RoomType := mRoomRes.FieldByName('RoomType').asString;
  RoomReservation := mRoomRes.FieldByName('RoomReservation').asinteger;
  ApplyRateToOther(RoomReservation, RoomType)
end;

procedure TfrmInvoice.SetAnyRowChecked(const Value: Boolean);
begin
  FAnyRowChecked := Value;
end;

procedure TfrmInvoice.ApplyRateToOther(RoomReservation: integer;
  RoomType: string);
var
  RateDate: TDateTime;
  PriceCode: string;
  Rate: Double;
  Discount: Double;
  isPercentage: boolean;
  ShowDiscount: boolean;
  isPaid: boolean;
  DiscountAmount: Double;
  rentAmount: Double;
  NativeAmount: Double;

  Arrival: TDateTime;
  Departure: TDateTime;

  AvragePrice: Double;
  RateCount: integer;
  AvrageDiscount: Double;
  Room: string;

  found: boolean;
  currentRoomReservation: integer;

begin
  // RoomReservation := mRoomRes.FieldByName('RoomReservation').AsInteger;
  // roomType        := mRoomRes.FieldByName('RoomType').AsString;

  Arrival := mRoomRes.FieldByName('Arrival').asdateTime;
  Departure := mRoomRes.FieldByName('Departure').asdateTime;
  AvragePrice := mRoomRes.FieldByName('AvragePrice').asfloat;
  RateCount := mRoomRes.FieldByName('RateCount').asinteger;
  PriceCode := mRoomRes.FieldByName('PriceCode').asString;
  AvrageDiscount := mRoomRes.FieldByName('AvrageDiscount').asfloat;
  isPercentage := mRoomRes.FieldByName('isPercentage').asBoolean;

  if mRoomRatesTmp.active then
    mRoomRatesTmp.close;
  mRoomRatesTmp.Open;
  mRoomRatesTmp.LoadFromDataSet(mRoomRates);

  // mRoomRatesTmp.Filter := '(Roomreservation=' + inttostr(RoomReservation) + ')';
  // mRoomRatesTmp.Filtered := true;

  // apply to same roomtype
  mRoomRates.DisableControls;
  mRoomRes.DisableControls;
  try
    mRoomRes.first;
    while not mRoomRes.eof do
    begin
      if RoomType <> '' then
      begin
        if (mRoomRes.FieldByName('RoomType').asString <> RoomType) then
        begin
          mRoomRes.Next;
          continue;
        end;
      end;
      if (mRoomRes.FieldByName('RoomReservation').asinteger <> RoomReservation)
        AND (mRoomRes.FieldByName('Arrival').asdateTime = Arrival) AND
        (mRoomRes.FieldByName('Departure').asdateTime = Departure) then
      begin
        currentRoomReservation := mRoomRes.FieldByName('RoomReservation')
          .asinteger;
        repeat
          found := mRoomRates.Locate('roomreservation',
            currentRoomReservation, []);
          if found then
          begin
            mRoomRates.delete;
          end;
        until not found;
        mRoomRatesTmp.first;
        while not mRoomRatesTmp.eof do
        begin
          if mRoomRatesTmp['Roomreservation'] = RoomReservation then
          begin
            RateDate := mRoomRatesTmp.FieldByName('RateDate').asdateTime;
            Room := mRoomRatesTmp.FieldByName('RoomNumber').asString;
            PriceCode := mRoomRatesTmp.FieldByName('PriceCode').asString;
            Rate := mRoomRatesTmp.FieldByName('Rate').asfloat;
            Discount := mRoomRatesTmp.FieldByName('Discount').asfloat;
            isPercentage := mRoomRatesTmp.FieldByName('isPercentage').asBoolean;
            ShowDiscount := mRoomRatesTmp.FieldByName('ShowDiscount').asBoolean;
            isPaid := mRoomRatesTmp.FieldByName('isPaid').asBoolean;
            DiscountAmount := mRoomRatesTmp.FieldByName
              ('DiscountAmount').asfloat;
            rentAmount := mRoomRatesTmp.FieldByName('RentAmount').asfloat;
            NativeAmount := mRoomRatesTmp.FieldByName('NativeAmount').asfloat;

            mRoomRates.append;
            mRoomRates.FieldByName('Reservation').asinteger := -1;
            mRoomRates.FieldByName('RoomReservation').asinteger :=
              currentRoomReservation;
            mRoomRates.FieldByName('RoomNumber').asString := Room;
            mRoomRates.FieldByName('RateDate').asdateTime := RateDate;
            mRoomRates.FieldByName('PriceCode').asString := PriceCode;
            mRoomRates.FieldByName('Rate').asfloat := Rate;
            mRoomRates.FieldByName('Discount').asfloat := Discount;
            mRoomRates.FieldByName('isPercentage').asBoolean := isPercentage;
            mRoomRates.FieldByName('ShowDiscount').asBoolean := ShowDiscount;
            mRoomRates.FieldByName('isPaid').asBoolean := isPaid;
            mRoomRates.FieldByName('DiscountAmount').asfloat := DiscountAmount;
            mRoomRates.FieldByName('RentAmount').asfloat := rentAmount;
            mRoomRates.FieldByName('NativeAmount').asfloat := NativeAmount;
            mRoomRates.post;
          end;
          mRoomRatesTmp.Next;
        end;

        mRoomRes.edit;
        mRoomRes.FieldByName('AvragePrice').asfloat := AvragePrice;
        mRoomRes.FieldByName('RateCount').asinteger := RateCount;
        mRoomRes.FieldByName('PriceCode').asString := PriceCode;
        mRoomRes.FieldByName('AvrageDiscount').asfloat := AvrageDiscount;
        mRoomRes.FieldByName('isPercentage').asBoolean := isPercentage;
        mRoomRes.post;
      end;
      mRoomRes.Next;
    end;
    mRoomRes.Locate('roomReservation', RoomReservation, []);
  finally
    mRoomRates.EnableControls;
    mRoomRes.EnableControls;
  end;
end;

procedure TfrmInvoice.ApplyNettoRateToNullPrice(NewRate: Double;
  RoomReservation: integer; RoomType: string);
var
  currentRoomReservation: integer;
begin
  mRoomRates.DisableControls;
  mRoomRes.DisableControls;
  try
    mRoomRes.first;
    while not mRoomRes.eof do
    begin
      if RoomType <> '' then
      begin
        if (mRoomRes.FieldByName('RoomType').asString <> RoomType) then
        begin
          mRoomRes.Next;
          continue;
        end;
      end;
      if (mRoomRes.FieldByName('RoomReservation').asinteger <> RoomReservation)
      then
      begin
        currentRoomReservation := mRoomRes.FieldByName('RoomReservation')
          .asinteger;
        if mRoomRes.FieldByName('AvragePrice').asfloat = 0 then
        begin
          CalcOnePrice(currentRoomReservation, NewRate);
        end;
      end;
      mRoomRes.Next;
    end;
    mRoomRes.Locate('roomReservation', RoomReservation, []);
  finally
    mRoomRates.EnableControls;
    mRoomRes.EnableControls;
  end;
end;

procedure TfrmInvoice.applyChanges;
var
  RoomReservation: integer;
  AvragePrice: Double;
  RateCount: integer;
  Guests: integer;
  ChildrenCount: integer;
  infantCount: integer;
  PriceCode: string;
  Currency: string;

  AvrageDiscount: Double;

  RoomRate: Double;
  Discount: Double;
  isPercentage: boolean;
  ShowDiscount: boolean;
  RateDate: TDate;

  sDate: string;

  s: string;

begin
  // Apply changes and return
  Currency := zCurrentCurrency;

  mRoomRes.first;
  while not mRoomRes.eof do
  begin
    // update values
    // reservation   := mRoomRes.FieldByName('Reservation').Asinteger;
    RoomReservation := mRoomRes.FieldByName('roomreservation').asinteger;
    AvragePrice := mRoomRes.FieldByName('avragePrice').asfloat;
    RateCount := mRoomRes.FieldByName('rateCount').asinteger;
    Guests := mRoomRes.FieldByName('guests').asinteger;
    ChildrenCount := mRoomRes.FieldByName('childrenCount').asinteger;
    infantCount := mRoomRes.FieldByName('infantCount').asinteger;
    PriceCode := mRoomRes.FieldByName('priceCode').asString;
    AvrageDiscount := mRoomRes.FieldByName('avrageDiscount').asfloat;
    isPercentage := mRoomRes.FieldByName('isPercentage').asBoolean;

    s := '';
    s := s + 'UPDATE `roomreservations` '#10;
    s := s + 'SET '#10;
    s := s + ' `Currency`    = ' + _db(Currency) + ' '#10;
    s := s + ',`PriceType`   = ' + _db(PriceCode) + ' '#10;
    s := s + ',`numGuests`   = ' + _db(Guests) + ' '#10;
    s := s + ',`numChildren` = ' + _db(ChildrenCount) + ' '#10;
    s := s + ',`numInfants`  = ' + _db(infantCount) + ' '#10;
    s := s + ',`AvrageRate`  = ' + _db(AvragePrice) + ' '#10;
    s := s + ',`RateCount`   = ' + _db(RateCount) + ' '#10;
    s := s + ',`Discount`    = ' + _db(AvrageDiscount) + ' '#10;
    s := s + ',`Percentage`  = ' + _db(isPercentage) + ' '#10;
    s := s + 'WHERE `roomreservation` = %d ';
    s := format(s, [RoomReservation]);
    if cmd_bySQL(s) then
    begin
{$IFDEF DEBUG}
      frmdayNotes.memLog.Lines.add(s);
      frmdayNotes.memLog.Lines.add('----');
{$ENDIF}
    end;
    mRoomRes.Next;
  end;

  mRoomRates.first;
  while not mRoomRates.eof do
  begin
    RoomReservation := mRoomRates.FieldByName('roomreservation').asinteger;
    PriceCode := mRoomRates.FieldByName('PriceCode').asString;
    RoomRate := mRoomRates.FieldByName('Rate').asfloat;
    Discount := mRoomRates.FieldByName('Discount').asfloat;
    isPercentage := mRoomRates.FieldByName('isPercentage').asBoolean;
    ShowDiscount := mRoomRates.FieldByName('showDiscount').asBoolean;
    RateDate := mRoomRates.FieldByName('RateDate').asdateTime;

    sDate := _DateToDbDate(RateDate, True);


      s := '';
      s := s + 'UPDATE `roomsdate` '#10;
      s := s + 'SET '#10;
      s := s + '`PriceCode`     =' + _db(PriceCode) + ' '#10;
      s := s + ',`RoomRate`     =' + _db(RoomRate) + ' '#10;
      s := s + ',`Currency`     =' + _db(Currency) + ' '#10;
      s := s + ',`Discount`     =' + _db(Discount) + ' '#10;
      s := s + ',`isPercentage` =' + _db(isPercentage) + ' '#10;
      s := s + ',`showDiscount` =' + _db(ShowDiscount) + ' '#10;
      s := s + 'WHERE '#10;
      s := s + ' (aDate = %s) '#10;
      s := s + 'AND (roomreservation = %d) '#10;
      s := s + '   AND (ResFlag <> ' + _db(STATUS_DELETED) + ' ) ';
      // **zxhj Bætti við

      s := format(s, [sDate, RoomReservation]);
      if cmd_bySQL(s) then
      begin
{$IFDEF DEBUG}
        frmdayNotes.memLog.Lines.add(s);
        frmdayNotes.memLog.Lines.add('----');
{$ENDIF}
      end;
    mRoomRates.Next;
  end;
end;

procedure TfrmInvoice.CalcOnePrice(RoomReservation: integer; NewRate: Double = 0);
var
  lstPrices: TStringList;
  // RoomReservation : integer;

  ii: integer;

  Room: string;
  RoomType: string;
  Guests: integer;
  RateCount: integer;
  RoomDescription: string;
  RoomTypeDescription: string;
  Arrival: TDateTime;
  Departure: TDateTime;
  ChildrenCount: integer;
  infantCount: integer;
  DiscountAmount: Double;
  rentAmount: Double;
  NativeAmount: Double;

  priceID: integer;
  PriceCode: string;

  rateTotal: Double;
  rateAvrage: Double;

  DiscountTotal: Double;
  DiscountAvrage: Double;

  dayCount: integer;
  aDate: TDateTime;

  Rate: Double;

  isPercentage: boolean;
  isPaid: boolean;

  Currency: string;
  CurrencyRate: Double;
  Discount: Double;
  ShowDiscount: boolean;
  found: boolean;

begin
  lstPrices := TStringList.create;
  try
    lstPrices.Sorted := True;
    lstPrices.Duplicates := dupIgnore;

    Currency := zCurrentCurrency;
    CurrencyRate := zCurrencyRate;

    Discount := 0;
    ShowDiscount := false;
    isPercentage := false;
    isPaid := false;

    if mRoomRates.RecordCount <> 0 then
    begin
      mRoomRates.first;
      Discount := mRoomRates.FieldByName('Discount').asfloat;
      ShowDiscount := mRoomRates.FieldByName('isPercentage').asBoolean;
      isPercentage := mRoomRates.FieldByName('ShowDiscount').asBoolean;
    end;

    if mRoomRes.Locate('roomreservation', RoomReservation, []) then
    begin
      repeat
        found := mRoomRates.Locate('roomreservation', RoomReservation, []);
        if found then
        begin
          mRoomRates.delete;
        end;
      until not found;

      Room := mRoomRes.FieldByName('room').asString;
      Arrival := mRoomRes.FieldByName('arrival').asdateTime;
      Departure := mRoomRes.FieldByName('departure').asdateTime;
      RoomType := mRoomRes.FieldByName('RoomType').asString;
      RoomTypeDescription := mRoomRes.FieldByName
        ('RoomTypeDescription').asString;
      RoomDescription := mRoomRes.FieldByName('RoomDescription').asString;
      Guests := mRoomRes.FieldByName('Guests').asinteger;
      ChildrenCount := mRoomRes.FieldByName('ChildrenCount').asinteger;
      infantCount := mRoomRes.FieldByName('infantCount').asinteger;
      PriceCode := mRoomRes.FieldByName('PriceCode').asString;
      priceID := hData.PriceCode_ID(PriceCode);

      dayCount := trunc(Departure) - trunc(Arrival);
      aDate := trunc(Arrival);
      rateTotal := 0;
      DiscountTotal := 0;
      lstPrices.Clear;
      for ii := 0 to dayCount - 1 do
      begin
        if NewRate <> 0 then
        begin
          Rate := NewRate;
        end
        else
        begin
          Rate := GetDayRate(RoomType, Room, aDate, Guests, ChildrenCount,
            infantCount, Currency, priceID, Discount, ShowDiscount,
            isPercentage, isPaid, false);
        end;

        DiscountAmount := 0;

        if Rate <> 0 then
        begin
          if Discount <> 0 then
          begin
            if isPercentage then
            begin
              DiscountAmount := Rate * Discount / 100;
            end
            else
            begin
              DiscountAmount := Discount;
            end;
          end;
        end;
        rentAmount := Rate - DiscountAmount;
        if CurrencyRate = 0 then
          CurrencyRate := 1;
        NativeAmount := rentAmount * CurrencyRate;

        mRoomRates.append;
        mRoomRates.FieldByName('Reservation').asinteger := -1;
        mRoomRates.FieldByName('RoomReservation').asinteger := RoomReservation;
        mRoomRates.FieldByName('RoomNumber').asString := Room;
        mRoomRates.FieldByName('RateDate').asdateTime := aDate;
        mRoomRates.FieldByName('PriceCode').asString := PriceCode;
        mRoomRates.FieldByName('Rate').asfloat := Rate;
        mRoomRates.FieldByName('Discount').asfloat := Discount;
        mRoomRates.FieldByName('isPercentage').asBoolean := isPercentage;
        mRoomRates.FieldByName('ShowDiscount').asBoolean := ShowDiscount;
        mRoomRates.FieldByName('isPaid').asBoolean := isPaid;
        mRoomRates.FieldByName('DiscountAmount').asfloat := DiscountAmount;
        mRoomRates.FieldByName('RentAmount').asfloat := rentAmount;
        mRoomRates.FieldByName('NativeAmount').asfloat := NativeAmount;
        mRoomRates.post;

        lstPrices.add(floattostr(rentAmount));
        rateTotal := rateTotal + rentAmount;
        DiscountTotal := DiscountTotal + Discount;
        aDate := aDate + 1
      end;

      if dayCount <> 0 then
      begin
        rateAvrage := rateTotal / dayCount;
        DiscountAvrage := DiscountTotal / dayCount;
      end
      else
      begin
        rateAvrage := 0;
        DiscountAvrage := 0;
      end;
      RateCount := lstPrices.Count;
      mRoomRes.edit;
      mRoomRes.FieldByName('AvragePrice').asfloat := rateAvrage;
      mRoomRes.FieldByName('RateCount').asfloat := RateCount;
      mRoomRes.FieldByName('AvrageDiscount').asfloat := DiscountAvrage;
      mRoomRes.post;
    end;
  finally
    FreeAndNil(lstPrices);
  end;
end;

procedure TfrmInvoice.UpdateCurrencyRoomPrice(RoomReservation: integer;
  Currency: string; CurrencyRate: Double; convert: Double);
var
  lstPrices: TStringList;
  // RoomReservation : integer;


  Room: string;
  RoomType: string;
  RateCount: integer;
  RoomDescription: string;
  RoomTypeDescription: string;
  Arrival: TDateTime;
  Departure: TDateTime;
  DiscountAmount: Double;
  rentAmount: Double;
  NativeAmount: Double;

  PriceCode: string;

  rateTotal: Double;
  rateAvrage: Double;

  DiscountTotal: Double;
  DiscountAvrage: Double;

  dayCount: integer;
  aDate: TDateTime;

  Rate: Double;

  isPercentage: boolean;
  isPaid: boolean;

  oldCurrency: string;
  Discount: Double;
  ShowDiscount: boolean;

begin
  lstPrices := TStringList.create;
  try
    lstPrices.Sorted := True;
    lstPrices.Duplicates := dupIgnore;

    oldCurrency := zCurrentCurrency;

    ShowDiscount := false;

    if mRoomRes.Locate('roomreservation', RoomReservation, []) then
    begin
      if (mRoomRes['InvoiceIndex'] = FInvoiceIndex) AND
         (mRoomRes['GroupAccount'] = (FRoomReservation=0)) then
      begin
        Room := mRoomRes.FieldByName('room').asString;
        Arrival := mRoomRes.FieldByName('arrival').asdateTime;
        Departure := mRoomRes.FieldByName('departure').asdateTime;
        RoomType := mRoomRes.FieldByName('RoomType').asString;
        RoomTypeDescription := mRoomRes.FieldByName
          ('RoomTypeDescription').asString;
        RoomDescription := mRoomRes.FieldByName('RoomDescription').asString;
        PriceCode := mRoomRes.FieldByName('PriceCode').asString;

        dayCount := trunc(Departure) - trunc(Arrival);
        aDate := trunc(Arrival);
        rateTotal := 0;
        DiscountTotal := 0;
        lstPrices.Clear;
        mRoomRates.first;
        while not mRoomRates.eof do
        begin
          if mRoomRates.FieldByName('Roomreservation').asinteger = RoomReservation
          then
          begin
            Rate := mRoomRates.FieldByName('Rate').asfloat;
            Discount := mRoomRates.FieldByName('Discount').asfloat;
            isPercentage := mRoomRates.FieldByName('isPercentage').asBoolean;
            isPaid := mRoomRates.FieldByName('isPaid').asBoolean;

            Rate := Rate * convert;
            if not isPercentage then
            begin
              Discount := Discount * convert;
            end
            else
            begin
              DiscountAmount := Rate * Discount / 100;
            end;

            rentAmount := Rate - DiscountAmount;
            if CurrencyRate = 0 then
              CurrencyRate := 1;
            NativeAmount := rentAmount * CurrencyRate;

            mRoomRates.edit;
            mRoomRates.FieldByName('Reservation').asinteger := -1;
            mRoomRates.FieldByName('RoomReservation').asinteger :=
              RoomReservation;
            mRoomRates.FieldByName('RoomNumber').asString := Room;
            mRoomRates.FieldByName('RateDate').asdateTime := aDate;
            mRoomRates.FieldByName('PriceCode').asString := PriceCode;
            mRoomRates.FieldByName('Rate').asfloat := Rate;
            mRoomRates.FieldByName('Discount').asfloat := Discount;
            mRoomRates.FieldByName('isPercentage').asBoolean := isPercentage;
            mRoomRates.FieldByName('ShowDiscount').asBoolean := ShowDiscount;
            mRoomRates.FieldByName('isPaid').asBoolean := isPaid;
            mRoomRates.FieldByName('DiscountAmount').asfloat := DiscountAmount;
            mRoomRates.FieldByName('RentAmount').asfloat := rentAmount;
            mRoomRates.FieldByName('NativeAmount').asfloat := NativeAmount;
            mRoomRates.post;

            lstPrices.add(floattostr(rentAmount));
            rateTotal := rateTotal + rentAmount;
            DiscountTotal := DiscountTotal + Discount;
            aDate := aDate + 1;
          end;
          mRoomRates.Next;
        end;

        rateAvrage := 0;
        if dayCount <> 0 then
        begin
          rateAvrage := rateTotal / dayCount;
          DiscountAvrage := DiscountTotal / dayCount;
        end
        else
        begin
          rateAvrage := 0;
          DiscountAvrage := 0;
        end;

        RateCount := lstPrices.Count;
        mRoomRes.edit;
        mRoomRes.FieldByName('AvragePrice').asfloat := rateAvrage;
        mRoomRes.FieldByName('RateCount').asfloat := RateCount;
        mRoomRes.FieldByName('AvrageDiscount').asfloat := DiscountAvrage;
        mRoomRes.post;
      end;
    end;
  finally
    FreeAndNil(lstPrices);
  end;
end;


// function TfrmInvoice.UpdateCurrencyRoomPrice(roomreservation : integer; Currency : string; CurrencyRate : double;convert : double ) : boolean;
// var
// lstPrices       : Tstringlist;
/// /  RoomReservation : integer;
//
// i,ii : integer;
//
// room                : string   ;
// RoomType            : string;
// Guests              : integer  ;
// AvragePrice         : double   ;
// RateCount           : integer;
// RoomDescription     : string;
// RoomTypeDescription : string;
// Arrival             : TdateTime;
// Departure           : TDateTime;
// ChildrenCount       : integer;
// infantCount         : integer;
// DiscountAmount      : double;
// RentAmount          : double;
// NativeAmount        : double;
//
// priceID       : integer;
// priceCode     : string ;
//
// rateTotal     : double;
// rateAvrage    : double;
//
// discountTotal     : double;
// discountAvrage    : double;
//
//
// dayCount      : integer;
// aDate         : TDateTime;
//
// RateDate      : TdateTime    ;
// rate          : Double;
//
// IsPercentage  : Boolean ;
// IsPaid        : Boolean ;
//
// oldCurrency      : string  ;
// oldCurrencyRate  : Double  ;
// Discount      : Double  ;
// showDiscount  : boolean ;
// found : boolean;
//
//
// begin
// lstPrices := TstringList.Create;
// try
// lstPrices.Sorted := true;
// lstPrices.Duplicates := dupIgnore;
//
// oldcurrency      := zCurrenctCurrency;
// oldCurrencyRate  := zCurrencyRate;
//
// discount      := 0;
// showDiscount  := false;
// isPercentage  := false;
//
// if mRoomRes.locate('roomreservation',roomreservation,[]) then
// begin
// room                := mRoomRes.FieldByName('room').AsString                ;
// arrival             := mRoomRes.FieldByName('arrival').AsDateTime           ;
// departure           := mRoomRes.FieldByName('departure').AsDateTime         ;
// RoomType            := mRoomRes.FieldByName('RoomType').AsString            ;
// RoomTypeDescription := mRoomRes.FieldByName('RoomTypeDescription').AsString ;
// RoomDescription     := mRoomRes.FieldByName('RoomDescription').AsString     ;
// Guests              := mRoomRes.FieldByName('Guests').AsInteger             ;
// ChildrenCount       := mRoomRes.FieldByName('ChildrenCount').AsInteger      ;
// InfantCount         := mRoomRes.FieldByName('infantCount').AsInteger        ;
// PriceCode           := mRoomRes.FieldByName('PriceCode').AsString           ;
// PriceID             := hdata.PriceCode_ID(priceCode);
//
// dayCount  := trunc(departure)-trunc(arrival);
// aDate     := trunc(Arrival);
// rateTotal := 0;
// discountTotal := 0;
// lstPrices.Clear;
// mRoomRates.first;
// while not mRoomRates.eof do
// begin
// Rate          := mRoomRates.FieldByName('Rate').AsFloat           ;
// Discount      := mRoomRates.FieldByName('Discount').AsFloat       ;
// isPercentage  := mRoomRates.FieldByName('isPercentage').AsBoolean ;
// isPaid        := mRoomRates.FieldByName('isPaid').AsBoolean       ;
//
// Rate := Rate * convert;
// if not isPercentage then
// begin
// Discount := Discount*convert;
// end else
// begin
// DiscountAmount :=  Rate*discount/100;
// end;
//
// RentAmount     := 0;
// NativeAmount   := 0;
// DiscountAmount := 0;
//
// RentAmount  := Rate-DiscountAmount;
// if currencyRate = 0 then currencyRate := 1;
// NativeAmount := RentAmount*CurrencyRate;
//
// mRoomRates.edit;
// mRoomRates.FieldByName('Reservation').AsInteger := -1;
// mRoomRates.FieldByName('RoomReservation').AsInteger := Roomreservation;
// mRoomRates.FieldByName('RoomNumber').AsString := Room;
// mRoomRates.FieldByName('RateDate').AsDateTime := aDate;
// mRoomRates.FieldByName('PriceCode').AsString := PriceCode;
// mRoomRates.FieldByName('Rate').AsFloat := Rate;
// mRoomRates.FieldByName('Discount').AsFloat := Discount;
// mRoomRates.FieldByName('isPercentage').AsBoolean := isPercentage;
// mRoomRates.FieldByName('ShowDiscount').AsBoolean := ShowDiscount;
// mRoomRates.FieldByName('isPaid').AsBoolean := isPaid;
// mRoomRates.FieldByName('DiscountAmount').AsFloat := DiscountAmount;
// mRoomRates.FieldByName('RentAmount').AsFloat := RentAmount;
// mRoomRates.FieldByName('NativeAmount').AsFloat := NativeAmount;
// mRoomRates.post;
//
// lstPrices.Add(floattostr(RentAmount));
// rateTotal := RateTotal+RentAmount;
// discountTotal := DiscountTotal+Discount;
// mRoomRates.Next;
// aDate := aDate+1;
// end;
//
// rateAvrage := 0;
// if dayCount <> 0 then
// begin
// rateAvrage := rateTotal/dayCount;
// discountAvrage := discountTotal/daycount;
//
// end;
//
// rateCount := lstPrices.Count;
// mRoomRes.edit;
// mRoomRes.FieldByName('AvragePrice').AsFloat := rateAvrage;
// mRoomRes.FieldByName('RateCount').AsFloat := rateCount;
// mRoomRes.FieldByName('AvrageDiscount').AsFloat := discountAvrage;
// mRoomRes.Post;
// end;
// finally
// freeandNil(lstPrices);
// end;
// end;

procedure TfrmInvoice.tvPaymentsCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  btnEditDownPaymentClick(nil);
end;

procedure TfrmInvoice.tvPaymentsMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if ssCtrl in Shift then
  begin
    grPayments.BeginDrag(True);
  end;
end;

procedure TfrmInvoice.tvRoomResAvragePricePropertiesEditValueChanged
  (Sender: TObject);

var
  RoomReservation: integer;
  RoomType: string;
  oldRate: Double;
  NewRate: Double;
begin
  RoomReservation := mRoomRes.FieldByName('RoomReservation').asinteger;
  oldRate := mRoomRes.FieldByName('avragePrice').asfloat;
  RoomType := mRoomRes.FieldByName('RoomType').asString;

  mRoomRes.post;
  NewRate := mRoomRes.FieldByName('avragePrice').asfloat;

  if oldRate <> NewRate then
  begin
    CalcOnePrice(RoomReservation, NewRate);
  end;

  if chkAutoUpdateNullPrice.checked then
  begin
    ApplyNettoRateToNullPrice(NewRate, RoomReservation, RoomType);
  end;
end;

//
// var
// roomreservation : integer;
// oldRate : double;
// newrate : double;
// begin
// roomreservation := mRoomRes.fieldbyname('RoomReservation').AsInteger;
// oldRate := mRoomRes.FieldByName('avragePrice').AsFloat;
// mRoomRes.post;
// NewRate := mRoomRes.FieldByName('avragePrice').AsFloat;
//
// if oldrate <> newrate then
// begin
// CalcOnePrice(roomreservation,newRate);
// end;
// end;

procedure TfrmInvoice.tvRoomResChildrenCountPropertiesEditValueChanged
  (Sender: TObject);
var
  RoomReservation: integer;
  oldValue: integer;
  newValue: integer;
begin
  oldValue := mRoomRes.FieldByName('ChildrenCount').asinteger;
  RoomReservation := mRoomRes.FieldByName('RoomReservation').asinteger;
  mRoomRes.post;
  newValue := mRoomRes.FieldByName('ChildrenCount').asinteger;
  if newValue <> oldValue then
  begin
    CalcOnePrice(RoomReservation);
  end;
end;

procedure TfrmInvoice.tvRoomResColumn1PropertiesButtonClick(Sender: TObject;
  AButtonIndex: integer);
var
  RoomReservation: integer;
begin
  RoomReservation := mRoomRes.FieldByName('roomreservation').asinteger;
  EditRoomRateOneRoom(RoomReservation);
end;

procedure TfrmInvoice.tvRoomResGuestsPropertiesEditValueChanged
  (Sender: TObject);
var
  RoomReservation: integer;
  oldValue: integer;
  newValue: integer;
begin
  oldValue := mRoomRes.FieldByName('guests').asinteger;
  RoomReservation := mRoomRes.FieldByName('RoomReservation').asinteger;
  mRoomRes.post;
  newValue := mRoomRes.FieldByName('guests').asinteger;
  if newValue <> oldValue then
  begin
    CalcOnePrice(RoomReservation);
  end;
end;

procedure TfrmInvoice.tvRoomResinfantCountPropertiesEditValueChanged
  (Sender: TObject);
var
  RoomReservation: integer;
  oldValue: integer;
  newValue: integer;
begin
  oldValue := mRoomRes.FieldByName('infantCount').asinteger;
  RoomReservation := mRoomRes.FieldByName('RoomReservation').asinteger;
  mRoomRes.post;
  newValue := mRoomRes.FieldByName('InfantCount').asinteger;
  if newValue <> oldValue then
  begin
    CalcOnePrice(RoomReservation);
  end;
end;

procedure TfrmInvoice.btdEditRoomRateClick(Sender: TObject);
var
  RoomReservation: integer;
begin
  RoomReservation := mRoomRes.FieldByName('roomreservation').asinteger;
  EditRoomRateOneRoom(RoomReservation);
end;

procedure TfrmInvoice.EditRoomRateOneRoom(RoomRes: integer);
var
  theData: recEditRoomPriceHolder;

  reservation: integer;
  RoomReservation: integer;
  RoomNumber: string;
  PriceCode: string;
  RateDate: TDateTime;
  Rate: Double;
  Discount: Double;
  isPercentage: boolean;
  ShowDiscount: boolean;
  isPaid: boolean;
  DiscountAmount: Double;
  rentAmount: Double;
  NativeAmount: Double;
  AvrageAmount: Double;
  ttAmount: Double;
  AmountCount: integer;
  resPrice: Double;
  lstPrices: TStringList;
  RateCount: integer;

  ttDiscount: Double;
  AvrageDiscount: Double;

  applyType: integer;

begin
  applyType := 0;
  if mRR_.active then
    mRR_.close;
  lstPrices := TStringList.create;
  try
    lstPrices.Sorted := True;
    lstPrices.Duplicates := dupIgnore;

    initEditRoomPriceHolder(theData);
    theData.isCreateRes := True;

    theData.Currency := zCurrentCurrency; // edtCurrency.Text;
    theData.CurrencyRate := zCurrencyRate;

    RoomReservation := mRoomRes.FieldByName('roomreservation').asinteger;
    theData.RoomType := mRoomRes.FieldByName('RoomType').asString;
    theData.Guests := mRoomRes.FieldByName('Guests').asinteger;
    theData.ChildrenCount := mRoomRes.FieldByName('childrenCount').asinteger;
    theData.infantCount := mRoomRes.FieldByName('infantCount').asinteger;
    resPrice := mRoomRes.FieldByName('AvragePrice').asfloat;

    mRR_.Open;

    mRoomRates.first;
    while not mRoomRates.eof do
    begin
      if mRoomRates.FieldByName('roomreservation').asinteger = RoomReservation
      then
      begin
        mRR_.append;
        mRR_.FieldByName('Reservation').asinteger :=
          mRoomRates.FieldByName('Reservation').asinteger;
        mRR_.FieldByName('RoomReservation').asinteger :=
          mRoomRates.FieldByName('RoomReservation').asinteger;
        mRR_.FieldByName('RoomNumber').asString :=
          mRoomRates.FieldByName('RoomNumber').asString;
        mRR_.FieldByName('PriceCode').asString :=
          mRoomRates.FieldByName('PriceCode').asString;
        mRR_.FieldByName('RateDate').asdateTime :=
          mRoomRates.FieldByName('RateDate').asdateTime;
        mRR_.FieldByName('Rate').asfloat :=
          mRoomRates.FieldByName('Rate').asfloat;
        mRR_.FieldByName('Discount').asfloat :=
          mRoomRates.FieldByName('Discount').asfloat;
        mRR_.FieldByName('isPercentage').asBoolean :=
          mRoomRates.FieldByName('isPercentage').asBoolean;
        mRR_.FieldByName('ShowDiscount').asBoolean :=
          mRoomRates.FieldByName('ShowDiscount').asBoolean;
        mRR_.FieldByName('isPaid').asBoolean := mRoomRates.FieldByName('isPaid')
          .asBoolean;
        mRR_.FieldByName('DiscountAmount').asfloat :=
          mRoomRates.FieldByName('DiscountAmount').asfloat;
        mRR_.FieldByName('RentAmount').asfloat :=
          mRoomRates.FieldByName('RentAmount').asfloat;
        mRR_.FieldByName('NativeAmount').asfloat :=
          mRoomRates.FieldByName('NativeAmount').asfloat;
        // mRR_.Fieldbyname('Currency').asString            :=  mRoomRates.Fieldbyname('Currency').asString           ;
        // mRR_.Fieldbyname('CurrencyRate').asFloat         :=  mRoomRates.Fieldbyname('CurrencyRate').asFloat        ;
        mRR_.post;
      end;
      mRoomRates.Next;
    end;

    mRR_.first;

    theData.Room := mRR_.FieldByName('roomNumber').asString;
    ttAmount := 0;
    AmountCount := 0;
    ttDiscount := 0;

    if editRoomPrice(actNone, theData, mRR_, applyType) then
    begin
      mRR_.first;
      while not mRR_.eof do
      begin
        reservation := mRR_.FieldByName('Reservation').asinteger;
        RoomReservation := mRR_.FieldByName('RoomReservation').asinteger;
        RoomNumber := mRR_.FieldByName('RoomNumber').asString;
        PriceCode := mRR_.FieldByName('PriceCode').asString;
        RateDate := mRR_.FieldByName('RateDate').asdateTime;
        Rate := mRR_.FieldByName('Rate').asfloat;
        Discount := mRR_.FieldByName('Discount').asfloat;
        isPercentage := mRR_.FieldByName('isPercentage').asBoolean;
        ShowDiscount := mRR_.FieldByName('ShowDiscount').asBoolean;
        isPaid := mRR_.FieldByName('isPaid').asBoolean;
        DiscountAmount := mRR_.FieldByName('DiscountAmount').asfloat;
        rentAmount := mRR_.FieldByName('RentAmount').asfloat;
        NativeAmount := mRR_.FieldByName('NativeAmount').asfloat;

        lstPrices.add(floattostr(rentAmount));
        inc(AmountCount);
        ttAmount := ttAmount + rentAmount;
        ttDiscount := ttDiscount + Discount;

        if mRoomRates.Locate('RoomReservation;rateDate',
          VarArrayOf([RoomReservation, RateDate]), []) then
        begin
          mRoomRates.edit;
          mRoomRates.FieldByName('Reservation').asinteger := reservation;
          mRoomRates.FieldByName('RoomReservation').asinteger :=
            RoomReservation;
          mRoomRates.FieldByName('RoomNumber').asString := RoomNumber;
          mRoomRates.FieldByName('PriceCode').asString := PriceCode;
          mRoomRates.FieldByName('RateDate').asdateTime := RateDate;
          mRoomRates.FieldByName('Rate').asfloat := Rate;
          mRoomRates.FieldByName('Discount').asfloat := Discount;
          mRoomRates.FieldByName('isPercentage').asBoolean := isPercentage;
          mRoomRates.FieldByName('ShowDiscount').asBoolean := ShowDiscount;
          mRoomRates.FieldByName('isPaid').asBoolean := isPaid;
          mRoomRates.FieldByName('DiscountAmount').asfloat := DiscountAmount;
          mRoomRates.FieldByName('RentAmount').asfloat := rentAmount;
          mRoomRates.FieldByName('NativeAmount').asfloat := NativeAmount;
          mRoomRates.post;
        end;
        mRR_.Next;
      end;

      if mRoomRes.Locate('RoomReservation', RoomReservation, []) then
      begin
        if AmountCount <> 0 then
        begin
          AvrageAmount := ttAmount / AmountCount;
          AvrageDiscount := ttDiscount / AmountCount;

          RateCount := lstPrices.Count;
          mRoomRes.edit;
          mRoomRes.FieldByName('AvragePrice').asfloat := AvrageAmount;
          mRoomRes.FieldByName('RateCount').asinteger := RateCount;
          mRoomRes.FieldByName('PriceCode').asString := PriceCode;
          mRoomRes.FieldByName('AvrageDiscount').asfloat := AvrageDiscount;
          mRoomRes.FieldByName('isPercentage').asBoolean := isPercentage;
          mRoomRes.post;
        end;
      end;
    end;
  finally
    FreeAndNil(lstPrices);
    if mRR_.active then
      mRR_.close;
  end;

  if applyType = 2 then
  begin
    ApplyRateToOther(RoomReservation, theData.RoomType)
  end
  else if applyType = 3 then
  begin
    ApplyRateToOther(RoomReservation, '');
  end;
end;

function TfrmInvoice.getDownPayments: Double;
var
  Total: Double;
begin
  Total := 0;

  if mPayments.RecordCount > 0 then
  begin
    mPayments.DisableControls;
    try
      mPayments.first;
      while not mPayments.eof do
      begin
        Total := Total + mPayments.FieldByName('Amount').asfloat;
        mPayments.Next;
      end;
    finally
      mPayments.EnableControls;
    end;
  end;
  result := Total;
end;

procedure TfrmInvoice.loadInvoiceToMemtable(var m: TKbmMemTable);
var
  i: integer;
  lineItem: string;
  lineDescription: string;
  lineItemCount: string;
  lineItemPrice: string;
  lineTotalPrice: string;
  lineSystem: string;
  lineDate: string;
  lineRefrence: string;
  lineSource: string;
  lineisPackage: string;
  lineNoGuests: string;
  lineConfirmdate: string;
  lineConfirmAmount: string;
  lineVat: string;
  linerrAlias: string;

  ItemCount: Double;
  ItemPrice: Double;
  TotalPrice: Double;
  sTmp: string;

  ItemTypeInfo: TItemTypeInfo;
  iMultiplier: integer;
  iNights: integer;
  irrAlias: integer;
  fVat: Double;
  iPersons: integer;

  confirmDate: TDateTime;
  confirmAmount: Double;

  AYear, AMon, ADay: Word;
  isPackage: boolean;
  bSystemLine: boolean;

  lInvRoom : TInvoiceRoomEntity;

begin
  for i := 1 to agrLines.RowCount - 1 do
  begin
    lineItem := trim(agrLines.Cells[col_Item, i]);
    lineDescription := trim(agrLines.Cells[col_Description, i]);
    lineItemCount := trim(agrLines.Cells[col_ItemCount, i]);
    lineItemPrice := trim(agrLines.Cells[col_ItemPrice, i]);
    lineTotalPrice := trim(agrLines.Cells[col_TotalPrice, i]);
    lineSystem := trim(agrLines.Cells[col_System, i]);
    lineDate := trim(agrLines.Cells[col_date, i]);
    lineRefrence := trim(agrLines.Cells[col_Refrence, i]);
    lineSource := trim(agrLines.Cells[col_Source, i]);
    lineisPackage := trim(agrLines.Cells[col_isPackage, i]);
    lineNoGuests := trim(agrLines.Cells[col_NoGuests, i]);
    lineConfirmdate := trim(agrLines.Cells[col_confirmdate, i]);
    lineConfirmAmount := trim(agrLines.Cells[col_confirmAmount, i]);
    lineVat := trim(agrLines.Cells[col_Vat, i]);
    linerrAlias := trim(agrLines.Cells[col_rrAlias, i]);

    if (lineItem = '') or (isSystemLine(i) = false) then
    begin
      continue;
    end;

    bSystemLine := isSystemLine(i);

    try
      decodedate(integer(agrLines.Objects[col_Description, i]), AYear, AMon, ADay);
    except
      decodedate(now, AYear, AMon, ADay);
    end;

    iMultiplier := 1;

    if FCredit then
    begin
      iMultiplier := -1;
    end;

    ItemTypeInfo := d.Item_Get_ItemTypeInfo(lineItem);

    iNights := 0;
    if agrLines.Objects[col_ItemCount, i] <> nil then
    begin
      iNights := trunc(TRoomInfo(agrLines.Objects[col_ItemCount, i]).FTo) -
        trunc(TRoomInfo(agrLines.Objects[col_ItemCount, i]).FFrom);
    end;

    if lineNoGuests <> '' then
    begin
      iPersons := strToInt(lineNoGuests)
    end;

    sTmp := lineItemCount;
    try
      ItemCount := _StrToFloat(sTmp);
    except
      ItemCount := 0;
    end;

    sTmp := lineItemPrice;
    try
      ItemPrice := _StrToFloat(sTmp);
    except
      ItemPrice := 0;
    end;

    ItemPrice := iMultiplier * zCurrencyRate * ItemPrice;
    TotalPrice := ItemCount * ItemPrice * iMultiplier;

    lInvRoom := TInvoiceRoomEntity.create(lineItem, 1, ItemCount, TotalPrice, 0, 0);
    try
      fVat := GetVATForItem(lineItem, TotalPrice, ItemCount, lInvRoom ,
                            tempInvoiceItemList, ItemTypeInfo, edtCustomer.Text);
    finally
      lInvRoom.Free;
    end;

    irrAlias := -1;
    try
      if linerrAlias <> '' then
        irrAlias := strToInt(linerrAlias);
    Except
    end;

    sTmp := lineConfirmdate;
    if sTmp <> '' then
    begin
      confirmDate := _DBDateToDateTimeNoMs(sTmp);
    end
    else
      confirmDate := 2;

    try
      confirmAmount := _StrToFloat(lineConfirmAmount);
    except
      confirmAmount := 0.00;
    end;

    isPackage := false;
    try
      sTmp := lineisPackage;
      if sTmp = 'Yes' then
        isPackage := True;
    except
    end;

    // asi lason
    // johann te
    // lee child

    m.insert;
    m.FieldByName('Reservation').asinteger := publicReservation;
    m.FieldByName('AutoGen').asString := _GetCurrentTick2;
    m.FieldByName('RoomReservation').asinteger := FRoomReservation;
    m.FieldByName('SplitNumber').asinteger := FnewSplitNumber;
    m.FieldByName('ItemNumber').asinteger := i;
    m.FieldByName('PurchaseDate').asString :=
      _DateToDbDate(integer(agrLines.Objects[col_Description, i]), True);
    m.FieldByName('InvoiceNumber').asinteger := zInvoiceNumber;
    m.FieldByName('ItemId').asString := lineItem;
    m.FieldByName('Number').asfloat := ItemCount;
    m.FieldByName('Description').asString := lineDescription;
    m.FieldByName('Price').asfloat := ItemPrice;
    m.FieldByName('VATType').asString := ItemTypeInfo.VATCode;
    m.FieldByName('Total').asfloat := TotalPrice;
    m.FieldByName('TotalWOVat').asfloat := TotalPrice - fVat;
    // _CommaToDot(floattostr(iMultiplier * fItemTotalWOVat));
    m.FieldByName('VAT').asfloat := fVat;
    // _CommaToDot(floattostr(iMultiplier * fItemTotalVAT));
    m.FieldByName('CurrencyRate').asfloat := zCurrencyRate;
    m.FieldByName('Currency').asString := edtCurrency.Text;
    m.FieldByName('Persons').asinteger := iPersons;
    m.FieldByName('Nights').asinteger := iNights;
    m.FieldByName('BreakfastPrice').asfloat := 0.00;
    m.FieldByName('AutoGenerated').asBoolean := false;
    m.FieldByName('AYear').asinteger := AYear;
    m.FieldByName('AMon').asinteger := AMon;
    m.FieldByName('ADay').asinteger := ADay;
    m.FieldByName('ilAccountKey').asString := d.Item_Get_AccountKey(lineItem);
    m.FieldByName('importRefrence').asString := lineRefrence;
    m.FieldByName('importSource').asString := lineSource;
    m.FieldByName('isPackage').asBoolean := false;
    m.FieldByName('confirmDate').asdateTime := now;
    m.FieldByName('confirmAmount').asfloat := 0.00;
    m.FieldByName('RoomReservationAlias').asinteger := irrAlias;
    m.FieldByName('issystemLine').asBoolean := bSystemLine;
    m.post;
  end;
end;

function TfrmInvoice.GetInvoiceIndexPanel(Index: integer): TsPanel;
begin
  result := TsPanel(FindComponent('pnlInvoiceIndex' + inttostr(Index)));
end;

function TfrmInvoice.GetInvoiceIndexItems(Index: integer): TShape;
begin
  result := TShape(FindComponent('shpInvoiceIndex' + inttostr(Index)));
end;

function TfrmInvoice.GetInvoiceIndexItemsRR(Index: integer): TShape;
begin
  result := TShape(FindComponent('shpInvoiceIndexRR' + inttostr(Index)));
end;

procedure TfrmInvoice.SetInvoiceIndexPanelsToZero;
var
  i: integer;
  pnl : TsPanel;
  shp1, shp2 : TShape;
begin
  for i := 0 to 9 do
  begin
    pnl := GetInvoiceIndexPanel(i);
    shp1 := GetInvoiceIndexItems(i);
    shp2 := GetInvoiceIndexItemsRR(i);

    pnl.HelpContext := 0;
    pnl.Hint := '';

    shp1.HelpContext := 0;
    shp1.Hint := '';
    shp1.Visible := False;

    shp2.HelpContext := 0;
    shp2.Hint := '';
    shp2.Visible := False;
  end;
end;

procedure TfrmInvoice.shpInvoiceIndex0DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  pnlInvoiceIndex0DragDrop(TShape(Sender), Source, X, Y);
end;

procedure TfrmInvoice.shpInvoiceIndex0DragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  pnlInvoiceIndex0DragOver(TShape(Sender), Source, X, Y, State, Accept);
end;

procedure TfrmInvoice.shpInvoiceIndex0MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  pnlInvoiceIndex0Click(TShape(Sender).Parent);
end;

function TfrmInvoice.GetCalculatedNumberOfItems(ItemId : String; dDefault : Double) : Double;
begin
  case glb.GetNumberBaseOfItem(itemId) of
    INB_USER_EDIT : result := dDefault;
    INB_ROOM_NIGHT : result := linesNumDays;
    INB_GUEST_NIGHT : result := NumberGuestNights;
    INB_GUEST : result := linesNumGuests;
    INB_ROOM : result := 1.0;
    INB_BOOKING : result := 1.0;
  end;
end;

procedure TfrmInvoice.LoadInvoice;
var
  rSet: TRoomerDataset;

  iLastRoomRes, idx: integer;
  iCurrentRow: integer;
  sText: string;

  GuestsInRoomRes: integer;

  PurchaseDate: TDateTime;
  Number: Double; // -96

  AYear, AMon, ADay: Word;

  // summur
  vTotal: Double;
  vTotalWOVat: Double;
  vVat: Double;

  s: string;

  tmp: string;

  itemNumber: integer;
  itemId: string;
  lineId : Integer;
  Description: string;
  Price: Double;
  VATType: string;
  Total: Double;
  TotalWOVat: Double;
  Vat: Double;
  CurrencyRate: Double;
  Currency: string;
  Persons: integer;
  Nights: integer;

  isGroupAccount: boolean;
  BrekFastIncluded: boolean;

  GuestNights: integer;

  _s: string;

  OrginalRef: integer;
  dPrice: Double;
  ciCustomerInfo: recCustomerHolderEX;
  ProcessOld: boolean;

  importRefrence: string;
  ImportSource: string;

  status: string;

  dTmp: Double;
  iTmp: integer;

  RoomReservation: integer;
  Room: string;
  RoomType: string;
  NumberGuests: integer;
  RoomDescription: string;
  RoomTypeDescription: string;
  Arrival: TDate;
  Departure: TDate;
  ChildrenCount: integer;
  infantCount: integer;
  PriceCode: string;

  invoiceHeadData: recInvoiceHeadHolder;

  dayCount: integer;
  RateDate: TDateTime;

  i: integer;

  Rate: Double;
  Discount: Double;
  isPercentage: boolean;
  ShowDiscount: boolean;
  isPaid: boolean;
  DiscountAmount: Double;
  rentAmount: Double;
  NativeAmount: Double;
  reservation: integer;

  AvrageRate: Double;
  RateCount: integer;
  UnpaidDays: integer;

  AvrageDiscount: Double;
  avrageDiscountAmount: Double;

  DiscountText: string;
  TotalDiscount: Double;
  RoomRentPaidDays: Double;
  iTotalResDays: integer;

  ttRate: Double;
  ttDiscount: Double;

  GuestName: String;
  NumGuests: integer;

  lExecutionPlan: TRoomerExecutionPlan;
  Index: integer;

  iNumNights: integer;

  iTmp2: integer;

  sql: string;
  package: string;

  showPackage: boolean;
  aRoom: string;
  tmpint: integer;
  isPackage: boolean;

  eSet, zrSet, reservationSet: TRoomerDataset;

  dNumber : Double;

  // lineItem             : string;
  // lineDescription      : string;
  // lineItemCount        : string;
  // lineItemPrice        : string;
  // lineTotalPrice       : string;
  // lineSystem           : string;
  // lineDate             : string;
  // lineRefrence         : string;
  // lineSource           : string;
  // lineisPackage        : string;
  // lineNoGuests         : string;
  // lineConfirmdate      : string;
  // lineConfirmAmount    : string;
  // lineVat              : string;
  // linerrAlias          : string;
  //
  // ItemCount    : double;
  // ItemPrice    : double;
  // TotalPrice   : double;
  // sTmp         : string;
  //
  // ItemTypeInfo : TItemTypeInfo;
  // iMultiplier  : integer;
  // iNights      : integer;
  // irrAlias     : integer;
  // fVat         : double;
  // iPersons     : integer;
  //
  // confirmDate : TdateTime;
  // confirmAmount : double;

  function SplitValue(s: String; Index: integer): String;
  var
    slist, sEntry: TStringList;
    i: integer;
  begin
    result := '';
    slist := Split(s, ',');
    for i := 0 to slist.Count - 1 do
    begin
      if slist[i] <> '' then
      begin
        sEntry := Split(slist[i], ';');
        if sEntry.Count = 2 then
        begin
          if (sEntry[0] = inttostr(index)) then
          begin
            result := sEntry[1];
            exit;
          end;
        end;
      end;
    end;

  end;

  procedure SetInvoiceIndexColors(IndexList, Currency: String);
  var
    i: integer;
    s: String;
    Value: Double;
  begin
    IndexList := IndexList;
    for i := 0 to 9 do
    begin
      s := SplitValue(IndexList, i);
      if s <> '' then
      begin
        GetInvoiceIndexPanel(i).HelpContext := i + 1;
        Value := LocalizedFloatValue(s);
        GetInvoiceIndexItems(i).Hint := Currency + ' ' +
          trim(_floattostr(Value, 12, 2));
      end;
    end;
  end;

  procedure AddRRColor(InvoiceIndex: integer; Total: Double; Currency: String);
  begin
    if round(Total) > 0 then
    begin
      GetInvoiceIndexItemsRR(InvoiceIndex).HelpContext := InvoiceIndex + 1;
      GetInvoiceIndexItemsRR(InvoiceIndex).Hint := Currency + ' ' + trim(_floattostr(Total, 12, 2))
    end;
  end;

var list : TStringList;

label Again;
begin
  DeletedLines.Clear;

  // --
  ClearObjects;
  ClearLines;
  NullifyGrid;

  SetInvoiceIndexPanelsToZero;
  FTotalRoomDiscount := 0.00;

  zrSet := CreateNewDataSet;
  Screen.Cursor := crHourglass;
  mRoomRes.DisableControls;
  mRoomRates.DisableControls;
  try
    if mRoomRes.active then
      mRoomRes.close;
    mRoomRes.Open;
    if mRoomRates.active then
      mRoomRates.close;
    mRoomRates.Open;

    // -- First the Invoice headers...
    zInvoiceNumber := -1;
    zInvoiceDate := now;
    zPayDate := now;
    zConfirmDate := 2;
    zbRoomRentinTemp := false;

    if FnewSplitNumber = 2 then
    begin
      CreateCashInvoice(g.qRackCustomer);
      edtCurrency.Text := zNativeCurrency;
      zCurrentCurrency := edtCurrency.Text;
      zCurrencyRate := GetRate(zCurrentCurrency);
      edtRate.Text := floattostr(zCurrencyRate);
      InitInvoiceGrid;
      exit;
    end;

  Again:
    zS := '';
    sql := 'SELECT CONVERT((SELECT GROUP_CONCAT(DISTINCT CONCAT(il1.InvoiceIndex, '';'', (SELECT SUM(il2.Total) FROM invoicelines il2 WHERE il2.RoomReservation=ih.RoomReservation '
      + 'AND il2.Reservation=ih.Reservation AND il2.InvoiceNumber=-1 AND il1.InvoiceIndex=il2.InvoiceIndex)) ORDER BY InvoiceIndex) '
      + 'FROM invoicelines il1 WHERE il1.RoomReservation=ih.RoomReservation AND il1.Reservation=ih.Reservation AND il1.InvoiceNumber=-1) USING utf8) AS InvoiceIndexes, '
      + '(SELECT InvoiceIndex FROM roomreservations rr WHERE rr.RoomReservation=ih.RoomReservation) rrInvoiceIndex, '
      + '(SELECT GroupAccount FROM roomreservations rr WHERE rr.RoomReservation=ih.RoomReservation) rrGroupAccount, '
      + '(SELECT SUM(RoomRate) FROM roomsdate rd WHERE rd.RoomReservation=ih.RoomReservation '
      + 'AND rd.Reservation=ih.Reservation AND rd.Paid=0 AND (NOT rd.ResFlag IN (''C'',''X'',''N'',''O''))) AS rrInvoiceTotal, '
      + 'ih.Reservation, ' +
        'ih.RoomReservation, ' +
        'ih.SplitNumber, ' +
        'ih.InvoiceNumber, ' +
        'ih.InvoiceDate, ' +
        'IFNULL((SELECT Customer FROM invoiceaddressees ia WHERE ia.invoiceNumber=ih.InvoiceNumber ' +
        '        AND ia.Reservation=ih.Reservation ' +
        '        AND ia.RoomReservation=ih.RoomReservation ' +
        '        AND ia.SplitNumber=ih.SplitNumber ' +
        '        AND ia.InvoiceIndex={InvoiceIndex} ' +
        '       ), ih.Customer) AS Customer, ' +
        'IFNULL((SELECT Name FROM invoiceaddressees ia WHERE ia.invoiceNumber=ih.InvoiceNumber ' +
        '        AND ia.Reservation=ih.Reservation ' +
        '        AND ia.RoomReservation=ih.RoomReservation ' +
        '        AND ia.SplitNumber=ih.SplitNumber ' +
        '        AND ia.InvoiceIndex={InvoiceIndex} ' +
        '       ), ih.Name) AS Name, ' +
        'IFNULL((SELECT Address1 FROM invoiceaddressees ia WHERE ia.invoiceNumber=ih.InvoiceNumber ' +
        '        AND ia.Reservation=ih.Reservation ' +
        '        AND ia.RoomReservation=ih.RoomReservation ' +
        '        AND ia.SplitNumber=ih.SplitNumber ' +
        '        AND ia.InvoiceIndex={InvoiceIndex} ' +
        '       ), ih.Address1) AS Address1, ' +
        'IFNULL((SELECT Address2 FROM invoiceaddressees ia WHERE ia.invoiceNumber=ih.InvoiceNumber ' +
        '        AND ia.Reservation=ih.Reservation ' +
        '        AND ia.RoomReservation=ih.RoomReservation ' +
        '        AND ia.SplitNumber=ih.SplitNumber ' +
        '        AND ia.InvoiceIndex={InvoiceIndex} ' +
        '       ), ih.Address2) AS Address2, ' +
        'IFNULL((SELECT Zip FROM invoiceaddressees ia WHERE ia.invoiceNumber=ih.InvoiceNumber ' +
        '        AND ia.Reservation=ih.Reservation ' +
        '        AND ia.RoomReservation=ih.RoomReservation ' +
        '        AND ia.SplitNumber=ih.SplitNumber ' +
        '        AND ia.InvoiceIndex={InvoiceIndex} ' +
        '       ), ih.Address3) AS Address3, ' +
        'IFNULL((SELECT City FROM invoiceaddressees ia WHERE ia.invoiceNumber=ih.InvoiceNumber ' +
        '        AND ia.Reservation=ih.Reservation ' +
        '        AND ia.RoomReservation=ih.RoomReservation ' +
        '        AND ia.SplitNumber=ih.SplitNumber ' +
        '        AND ia.InvoiceIndex={InvoiceIndex} ' +
        '       ), ih.Address4) AS Address4, ' +
        'IFNULL((SELECT Country FROM invoiceaddressees ia WHERE ia.invoiceNumber=ih.InvoiceNumber ' +
        '        AND ia.Reservation=ih.Reservation ' +
        '        AND ia.RoomReservation=ih.RoomReservation ' +
        '        AND ia.SplitNumber=ih.SplitNumber ' +
        '        AND ia.InvoiceIndex={InvoiceIndex} ' +
        '       ), ih.Country) AS Country, ' +
        'ih.Total, ' +
        'ih.TotalWOVAT, ' +
        'ih.TotalVAT, ' +
        'ih.TotalBreakFast, ' +
        'IFNULL((SELECT ExtraText FROM invoiceaddressees ia WHERE ia.invoiceNumber=ih.InvoiceNumber ' +
        '        AND ia.Reservation=ih.Reservation ' +
        '        AND ia.RoomReservation=ih.RoomReservation ' +
        '        AND ia.SplitNumber=ih.SplitNumber ' +
        '        AND ia.InvoiceIndex={InvoiceIndex} ' +
        '       ), ih.ExtraText) AS ExtraText, ' +
        'ih.Finished, ' +
        'ih.ReportDate, ' +
        'ih.ReportTime, ' +
        'ih.CreditInvoice, ' +
        'ih.OriginalInvoice, ' +
        'IFNULL((SELECT InvoiceType FROM invoiceaddressees ia WHERE ia.invoiceNumber=ih.InvoiceNumber ' +
        '        AND ia.Reservation=ih.Reservation ' +
        '        AND ia.RoomReservation=ih.RoomReservation ' +
        '        AND ia.SplitNumber=ih.SplitNumber ' +
        '        AND ia.InvoiceIndex={InvoiceIndex} ' +
        '       ), ih.InvoiceType) AS InvoiceType, ' +
        'ih.ihTmp, ' +
        'ih.ID, ' +
        'IFNULL((SELECT CustPID FROM invoiceaddressees ia WHERE ia.invoiceNumber=ih.InvoiceNumber ' +
        '        AND ia.Reservation=ih.Reservation ' +
        '        AND ia.RoomReservation=ih.RoomReservation ' +
        '        AND ia.SplitNumber=ih.SplitNumber ' +
        '        AND ia.InvoiceIndex={InvoiceIndex} ' +
        '       ), ih.CustPID) AS custPID, ' +
        'ih.RoomGuest, ' +
        'ih.ihDate, ' +
        'ih.ihStaff, ' +
        'ih.ihPayDate, ' +
        'ih.ihConfirmDate, ' +
        'ih.ihInvoiceDate, ' +
        'IFNULL((SELECT ihCurrency FROM invoiceaddressees ia WHERE ia.invoiceNumber=ih.InvoiceNumber ' +
        '        AND ia.Reservation=ih.Reservation ' +
        '        AND ia.RoomReservation=ih.RoomReservation ' +
        '        AND ia.SplitNumber=ih.SplitNumber ' +
        '        AND ia.InvoiceIndex={InvoiceIndex} ' +
        '       ), ih.ihCurrency) AS ihCurrency, ' +
        'ih.ihCurrencyRate, ' +
        'ih.invRefrence, ' +
        'ih.TotalStayTax, ' +
        'ih.TotalStayTaxNights, ' +
        'ih.showPackage, ' +
        'ih.staff, ' +
        'ih.location, ' +
        'ih.externalInvoiceId ' +
      'FROM invoiceheads ih where ih.Reservation = %d '#10 +
      '   and ih.RoomReservation = %d and ih.SplitNumber = %d '#10 +
      '   and ih.InvoiceNumber = -1 and ih.Finished = 0';
    if zrSet.active then
      zrSet.close;

    zS := ReplaceString(format(sql, [publicReservation, FRoomReservation, FnewSplitNumber]),
          '{InvoiceIndex}',
          inttostr(InvoiceIndex));

// copytoclipboard(zs);

     hData.rSet_bySQL(zrSet, zS);



    zrSet.first;

    if not zrSet.eof then
    begin
      SetInvoiceIndexColors(zrSet.FieldByName('InvoiceIndexes').asString, zrSet.FieldByName('ihCurrency').asString);
      AddRRColor(zrSet.FieldByName('rrInvoiceIndex').asinteger, zrSet.GetFloatValue(zrSet.FieldByName('rrInvoiceTotal')), zrSet.FieldByName('ihCurrency').asString);
      // Sækja Invoice sem er til
      zInvoiceNumber := zrSet.FieldByName('InvoiceNumber').asinteger;

      if FnewSplitNumber <> 2 then // ef ekki staðgreiðslureikningur
      begin
{$REGION 'Set Invoice type'}
        if zrSet.FieldByName('InvoiceType').asinteger <> 4 then // Free text
          GetInvoiceHeader(publicReservation, FRoomReservation, zrSet); // To initialize with current data
        if zrSet.FieldByName('InvoiceType').asinteger = 4 then // Free text
        begin
          GetInvoiceHeader(publicReservation, FRoomReservation, zrSet);
          rgrInvoiceType.itemIndex := 4;
        end
        else if zrSet.FieldByName('InvoiceType').asinteger = 1 then
        // Reservation customer
        begin
          GetReservationHeader(publicReservation, FRoomReservation);
          rgrInvoiceType.itemIndex := 1;
        end
        else
        begin
          rgrInvoiceType.itemIndex := zrSet.FieldByName('InvoiceType').asinteger;
        end;

        if FnewSplitNumber = 1 then // Kreditinvoice
        begin
          GetInvoiceHeader(publicReservation, FRoomReservation);
          rgrInvoiceType.itemIndex := 3;
        end;

{$ENDREGION}
      end;
    end
    else
    begin
      // Create New invoice
      zInvoiceNumber := -1;
      zInvoiceDate := now;
      zConfirmDate := 2;
      zPayDate := trunc(now);

      if zrSet.active then
        zrSet.close;

      sql := ' SELECT r.* FROM  reservations r ' +
        ' WHERE r.Reservation = %d ';

      zS := format(sql, [publicReservation]);

      hData.rSet_bySQL(zrSet, zS);

      zrSet.first;
      // INS-InvoiceHead
      // If there is no tmp invoice then create it
      // and goto label Again
      if not zrSet.eof then
      begin
        initInvoiceHeadHolderRec(invoiceHeadData);

        invoiceHeadData.reservation := publicReservation;
        invoiceHeadData.RoomReservation := FRoomReservation;
        invoiceHeadData.SplitNumber := FnewSplitNumber;
        invoiceHeadData.invoiceNumber := zInvoiceNumber;
        invoiceHeadData.InvoiceDate := _DateToDbDate(zInvoiceDate, false);

        invoiceHeadData.customer := zrSet.FieldByName('Customer').asString;
        invoiceHeadData.name := zrSet.FieldByName('Name').asString;
        invoiceHeadData.Address1 := zrSet.FieldByName('Address1').asString;
        invoiceHeadData.Address2 := zrSet.FieldByName('Address2').asString;
        invoiceHeadData.Address3 := zrSet.FieldByName('Address3').asString;
        invoiceHeadData.Address4 := '';
        // ATH _db(zrSet.FieldByName('Address4').asString);
        invoiceHeadData.Country := zrSet.FieldByName('Country').asString;
        invoiceHeadData.Total := 0.00;
        invoiceHeadData.TotalWOVat := 0.00;
        invoiceHeadData.TotalVAT := 0.00;
        invoiceHeadData.TotalBreakFast := 0.00;
        invoiceHeadData.ExtraText := memExtraText.Lines.Text;
        invoiceHeadData.Finished := false;
        invoiceHeadData.InvoiceType := rgrInvoiceType.itemIndex;
        invoiceHeadData.CustPID := zrSet.FieldByName('CustPid').asString;
        invoiceHeadData.ihDate := Date;
        invoiceHeadData.ihInvoiceDate := zInvoiceDate;
        invoiceHeadData.ihConfirmDate := zConfirmDate;
        invoiceHeadData.ihPayDate := zPayDate;
        invoiceHeadData.ihStaff := g.qUser;
        if not hData.SP_INS_InvoiceHead(invoiceHeadData) then
        begin
          // **
        end;
        goto Again;
      end
    end;

    if not zFakeGroup then
    begin
      DisplayMem(zrSet);
      DisplayGuestName(zrSet);
      InitInvoiceGrid;
//      AddEmptyLine;
    end
    else
    begin
      FRoomReservation := 0;
      Panel1.visible := false;
      File1.visible := false;
      Invoice2.visible := false;
      Items1.visible := false;
      pageMain.ActivePageIndex := 1;
      btnExit.Enabled := false;
      btnInvoice.Enabled := false;
      btnProforma.Enabled := false;
    end;

    zS := Select_Invoice_LoadInvoice3_WithInvoiceIndex(FRoomReservation, publicReservation, FInvoiceIndex, edtCustomer.Text);
    if FRoomReservation = 0 then // GroupInvoice
    begin
      zS := format(zS, [publicReservation]);
    end
    else
    begin
      zS := format(zS, [FRoomReservation]);
    end;
    if zRoomRSet.active then
      zRoomRSet.close;

    hData.rSet_bySQL(zRoomRSet, zS);

    iLastRoomRes := -1;
    RoomRentPaidDays := 0.00;
    zRoomRentPaymentInvoice := -1;

    // Default
    edtCurrency.Text := zNativeCurrency;
    zCurrentCurrency := edtCurrency.Text;

    zCurrencyRate := GetRate(zCurrentCurrency);
    edtRate.Text := floattostr(zCurrencyRate);

    zRoomRSet.first;
    lExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
    try

      if not zRoomRSet.eof then
      begin

        zEmailAddress := '';
        list := TStringList.Create;
        try
          uUtils.SplitString(trim(zRoomRSet.FieldByName('ContactEmail').asString), list, ';');
          for i := 0 to list.count - 1 do
            if list[i]<>'' then
            begin
              if zEmailAddress = '' then
                zEmailAddress := QuotedStr(list[i])
              else
                zEmailAddress := zEmailAddress + ';' + QuotedStr(list[i])
            end;
        finally
          FreeAndNil(list);
        end;

        if trim(zRoomRSet.FieldByName('GuestEmail').asString) <> '' then
        begin
          if zEmailAddress = '' then
          begin
            zEmailAddress := QuotedStr(trim(zRoomRSet.FieldByName('GuestEmail').asString))
          end else
          begin
            zEmailAddress := zEmailAddress + ';' + QuotedStr(trim(zRoomRSet.FieldByName('GuestEmail').asString));
          end;
        end;

        edtCurrency.Text := trim(zRoomRSet.FieldByName('Currency').asString);
        zCurrentCurrency := edtCurrency.Text;
        zCurrencyRate := GetRate(zCurrentCurrency);
        edtRate.Text := floattostr(zCurrencyRate);
      end;

      // **

        while not zRoomRSet.eof do
        begin
          RoomReservation := zRoomRSet.FieldByName('Roomreservation').asinteger;
          // package := zRoomRSet.FieldByName('Package').asString;

          Arrival := zRoomRSet.FieldByName('rrArrival').asdateTime;
          Departure := zRoomRSet.FieldByName('rrDeparture').asdateTime;

          s := 'SELECT '#10;
          s := s + 'rd.ADate, '#10;
          s := s + 'rd.Room, '#10;
          s := s + 'rd.RoomReservation, '#10;
          s := s + 'rd.Reservation, '#10;
          s := s + 'rd.PriceCode, '#10;
          s := s + 'rd.RoomRate, '#10;
          s := s + 'rd.Discount, '#10;
          s := s + 'rd.isPercentage, '#10;
          s := s + 'rd.showDiscount, '#10;
          s := s + 'rd.Paid '#10;
          s := s + ',IF(ISNULL((SELECT name FROM persons pe WHERE pe.MainName AND pe.roomreservation = rd.roomreservation LIMIT 1)), '#10;
          s := s + '   (SELECT name FROM persons pe WHERE pe.roomreservation = rd.roomreservation LIMIT 1), '#10;
          s := s + '   (SELECT name FROM persons pe WHERE pe.MainName AND pe.roomreservation = rd.roomreservation LIMIT 1)) AS guestName '#10;
          s := s + ', (SELECT count(id) FROM persons pe WHERE pe.roomreservation = rd.roomreservation) AS numGuests '#10;
          s := s + 'FROM roomsdate rd '#10;
          s := s + 'WHERE '#10;
          s := s + '(rd.roomreservation = %d ) AND (rd.ADate >= %s ) AND (rd.ADate < %s ) AND (rd.paid=0) '#10;
          s := s + 'ORDER BY '#10;
          s := s + '  ADate '#10;
          s := format(s, [RoomReservation, _DateToDbDate(Arrival, True),
            _DateToDbDate(Departure, True)]);

          // copyToclipboard(s);
          // debugmessage(s);
          lExecutionPlan.AddQuery(s);
          zRoomRSet.Next;
        end;

      if lExecutionPlan.Execute(ptQuery) then
      begin
        zRoomRSet.first;
        index := 0;

        while not zRoomRSet.eof do
        begin
          RoomReservation := zRoomRSet.FieldByName('Roomreservation').asinteger;
          isGroupAccount := zRoomRSet['GroupAccount'];
          status := zRoomRSet.FieldByName('status').asString;
          Room := zRoomRSet.FieldByName('room').asString;
          RoomType := zRoomRSet.FieldByName('RoomType').asString;
          package := zRoomRSet.FieldByName('package').asString;
          NumberGuests := zRoomRSet.FieldByName('numGuests').asinteger;
          RoomDescription := zRoomRSet.FieldByName('RoomDescription').asString;
          RoomTypeDescription := zRoomRSet.FieldByName
            ('RoomTypeDescription').asString;
          Arrival := zRoomRSet.FieldByName('rrArrival').asdateTime;
          Departure := zRoomRSet.FieldByName('rrDeparture').asdateTime;
          ChildrenCount := zRoomRSet.FieldByName('numChildren').asinteger;
          infantCount := zRoomRSet.FieldByName('numInfants').asinteger;
          PriceCode := zRoomRSet.FieldByName('PriceType').asString;
          AvrageRate := zRoomRSet.GetFloatValue
            (zRoomRSet.FieldByName('AvrageRate'));
          RateCount := zRoomRSet.FieldByName('rateCount').asinteger;
          AvrageDiscount := zRoomRSet.GetFloatValue
            (zRoomRSet.FieldByName('discount'));
          isPercentage := zRoomRSet.FieldByName('Percentage').asBoolean;

          mRoomRes.append;
          mRoomRes.FieldByName('RoomReservation').asinteger := RoomReservation;
          mRoomRes.FieldByName('room').asString := Room;
          mRoomRes.FieldByName('RoomType').asString := RoomType;
          mRoomRes.FieldByName('Package').asString := package;
          mRoomRes.FieldByName('Guests').asinteger := NumberGuests;
          mRoomRes.FieldByName('AvragePrice').asfloat := AvrageRate;
          mRoomRes.FieldByName('RateCount').asfloat := RateCount;
          mRoomRes.FieldByName('RoomDescription').asString := RoomDescription;
          mRoomRes.FieldByName('RoomTypeDescription').asString :=
            RoomTypeDescription;
          mRoomRes.FieldByName('arrival').asdateTime := Arrival;
          mRoomRes.FieldByName('departure').asdateTime := Departure;
          mRoomRes.FieldByName('ChildrenCount').asinteger := ChildrenCount;
          mRoomRes.FieldByName('InfantCount').asinteger := infantCount;
          mRoomRes.FieldByName('PriceCode').asString := PriceCode;
          mRoomRes.FieldByName('AvrageDiscount').asfloat := AvrageDiscount;
          mRoomRes.FieldByName('isPercentage').asBoolean := isPercentage;
          mRoomRes.FieldByName('InvoiceIndex').asInteger := FInvoiceIndex;
          mRoomRes.FieldByName('GroupAccount').asBoolean := zRoomRSet['GroupAccount'];

          if package <> '' then
            if glb.LocateSpecificRecordAndGetValue('packages', 'Package',
              package, 'showItemsOnInvoice', showPackage) then
              chkShowPackage.checked := showPackage;

          dayCount := trunc(Departure) - trunc(Arrival);
          RateDate := Arrival;
          TotalDiscount := 0;

          // if mRoomRates.active then mRoomRates.close;
          // mRoomRates.open;

          ttRate := 0;
          ttDiscount := 0;
          UnpaidDays := 0;

          rSet := lExecutionPlan.Results[index];

          rSet.first;
          GuestName := rSet.FieldByName('guestName').asString;
          NumGuests := rSet.FieldByName('numGuests').asinteger;
          mRoomRes.FieldByName('Guests').asinteger := NumGuests;
          mRoomRes.post;
          for i := 1 to dayCount do
          begin
            DiscountText := '';
            iTotalResDays := 0;

            if LocateDate(rSet, 'ADate', RateDate) then
            begin
              reservation := rSet.FieldByName('Reservation').asinteger;
              Room := rSet.FieldByName('Room').asString;
              PriceCode := rSet.FieldByName('PriceCode').asString;
              RateDate := _DBDateToDate(rSet.FieldByName('ADate').asString);
              Rate := rSet.GetFloatValue(rSet.FieldByName('RoomRate'));
              Discount := rSet.GetFloatValue(rSet.FieldByName('Discount'));
              isPercentage := rSet.FieldByName('isPercentage').asBoolean;
              ShowDiscount := rSet.FieldByName('ShowDiscount').asBoolean;
              isPaid := rSet.FieldByName('Paid').asBoolean;

              if not isPaid then
              begin
                UnpaidDays := UnpaidDays + 1;
              end;

              DiscountAmount := 0;
              rentAmount := 0;
              NativeAmount := 0;

              if Rate <> 0 then
              begin
                if Discount <> 0 then
                begin
                  if isPercentage then
                  begin
                    DiscountAmount := Rate * Discount / 100;
                  end
                  else
                  begin
                    DiscountAmount := Discount;
                  end;
                end;
              end;
              rentAmount := Rate - DiscountAmount;
              try
                CurrencyRate := _StrToFloat(edtRate.Text);
              except
                CurrencyRate := 1
              end;
              if CurrencyRate = 0 then
                CurrencyRate := 1;
              NativeAmount := rentAmount * CurrencyRate;

              TotalDiscount := TotalDiscount + DiscountAmount;

              ttRate := ttRate + Rate;
              ttDiscount := ttDiscount + Discount;

              mRoomRates.append;
              mRoomRates.FieldByName('Reservation').asinteger := reservation;
              mRoomRates.FieldByName('RoomReservation').asinteger := RoomReservation;
              mRoomRates.FieldByName('RoomNumber').asString := Room;
              mRoomRates.FieldByName('PriceCode').asString := PriceCode;
              mRoomRates.FieldByName('RateDate').asdateTime := RateDate;
              mRoomRates.FieldByName('Rate').asfloat := Rate;
              mRoomRates.FieldByName('Discount').asfloat := Discount;
              mRoomRates.FieldByName('isPercentage').asBoolean := isPercentage;
              mRoomRates.FieldByName('ShowDiscount').asBoolean := ShowDiscount;
              mRoomRates.FieldByName('isPaid').asBoolean := isPaid;
              mRoomRates.FieldByName('DiscountAmount').asfloat := DiscountAmount;
              mRoomRates.FieldByName('RentAmount').asfloat := rentAmount;
              mRoomRates.FieldByName('NativeAmount').asfloat := NativeAmount;
              mRoomRates.post;
            end;

            RateDate := RateDate + 1;
          end;

          iTotalResDays := trunc(Departure) - trunc(Arrival);
          // RoomRentPaidDays := LocalFloatValue(zRoomRSet.FieldByName('RoomRentPaid1').asString);

          if not zFakeGroup then
            if (isGroupAccount and (FRoomReservation = 0)) or
              ((not isGroupAccount) and (FRoomReservation = RoomReservation))
            then
            begin
              zRoomRentPaymentInvoice := zRoomRSet.FieldByName('RoomRentPaymentInvoice').asinteger;
              GuestsInRoomRes := NumberGuests; // ChildrenCount+infantCount
              GuestNights := GuestsInRoomRes * UnpaidDays;
              // unpaidDays              := daycount;
              RoomRentPaidDays := iTotalResDays - UnpaidDays;

              if UnpaidDays <> 0 then
              begin
                AvrageRate := ttRate / UnpaidDays;
                AvrageDiscount := ttDiscount / UnpaidDays;

                if AvrageRate <> 0 then
                begin
                  if AvrageDiscount <> 0 then
                  begin
                    if isPercentage then
                    begin
                      avrageDiscountAmount := AvrageRate * AvrageDiscount / 100;
                    end
                    else
                    begin
                      avrageDiscountAmount := AvrageDiscount;
                    end;
                  end;
                end;
              end;

              if UnpaidDays > 0 then
              begin
                isPackage := false;
                if ABS(AvrageRate) > 0 then
                begin
                  if package <> '' then
                  begin
                    isPackage := True;
                    _s := Package_getRoomDescription(Package, Room, Arrival,
                      Departure, GuestName);
                    if FRoomReservation = 0 then
                      _s := _s + ' Room :' + Room;

                  end
                  else
                  begin
                    _s := 'Room';
                    _s := _s + ' ' + Room + ' ';
                    _s := _s + FormatDateTime('dd.mm', Arrival);
                    _s := _s + '-';
                    _s := _s + FormatDateTime('dd.mm', Departure);
                  end;

                  sText := _s;

                  tmp := trim(zRoomRSet.FieldByName('rrDescription').asString);

                  if copy(tmp, 1, 2) = '--' then
                    sText := '';
                  sText := tmp + sText;

                  if isPercentage then
                  begin
                    DiscountText := DiscountText + '(' +
                      floattostr(AvrageDiscount) + '%)';
                  end
                  else
                  begin
                    DiscountText := DiscountText + '(' +
                      floattostr(AvrageDiscount) + '%)';
                  end;

                  iTmp2 := NumGuests;

                  AddRoom(Room, AvrageRate, Arrival, Departure, UnpaidDays,
                    sText, (FRoomReservation = 0), RoomReservation,
                    AvrageDiscount,
                    // Total discount
                    isPercentage, DiscountText, GuestName, NumGuests, isPackage,
                    RoomReservation);
                end;

                if (ABS(AvrageRate) = 0) and (status <> 'B') then
                begin
                  if package <> '' then
                  begin
                    isPackage := True;
                    _s := Package_getRoomDescription(Package, Room, Arrival,
                      Departure, GuestName);
                    if FRoomReservation = 0 then
                      _s := _s + ' Room :' + Room;
                  end
                  else
                  begin
                    _s := 'Room';
                    _s := _s + ' ' + Room + ' ';
                    _s := _s + FormatDateTime('dd.mm', Arrival);
                    _s := _s + '-';
                    _s := _s + FormatDateTime('dd.mm', Departure);
                  end;

                  sText := _s;

                  tmp := trim(zRoomRSet.FieldByName('rrDescription').asString);

                  if copy(tmp, 1, 2) = '--' then
                    sText := '';
                  sText := tmp + sText;

                  iTmp2 := NumGuests;

                  AddRoom(Room, 0, Arrival, Departure, UnpaidDays, sText,
                    (FRoomReservation = 0), RoomReservation, 0, false, '', '',
                    NumGuests, isPackage, RoomReservation);
                end;
              end;

            end
            else
            begin
            end;
          inc(index);
          zRoomRSet.Next;
        end;
      end;
    finally
      lExecutionPlan.free;
    end;

    if not zFakeGroup then
    begin

      lExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
      try
        iCurrentRow := agrLines.RowCount;

          RestoreTMPInvoicelines;

          // -- Then the invoice lines...

          sql := 'SELECT il.* ' +
            ' FROM invoicelines il where Reservation = %d ' +
            '   and RoomReservation = %d ' + '   and SplitNumber = %d ' +
            '   and InvoiceNumber = -1 AND InvoiceIndex = %d';
          zS := format(sql, [publicReservation, FRoomReservation,
            FnewSplitNumber, FInvoiceIndex]);
          lExecutionPlan.AddQuery(zS);

          sql := 'SELECT * FROM payments ' + ' where Reservation = %d ' +
            '   and RoomReservation = %d ' +
            '   and InvoiceNumber = -1 AND InvoiceIndex = %d';
          zS := format(sql, [publicReservation, FRoomReservation,
            FInvoiceIndex]);
          lExecutionPlan.AddQuery(zS);

          sql := 'SELECT SUM(IF(xxx.RoomReservation>0 AND xxx.Reservation>0, xxx.NumberOfGuests * xxx.NumberOfDays, ' +
                 ' (SELECT SUM((SELECT COUNT(id) FROM roomsdate WHERE RoomReservation = pe.RoomReservation AND NOT (ResFlag IN (''X'',''C'',''N'')))) AS GuestNights ' +
                 '   FROM persons pe ' +
                 '   WHERE pe.Reservation=xxx.Reservation) ' +
                 ')) AS NumberGuestNights, ' +
                 'SUM(NumberOfDays) AS NumberOfDays, ' +
                 'SUM(NumberOfGuests) AS NumberOfGuests ' +
                 'FROM ( ' +
                 'SELECT RoomReservation, Reservation, IF(il.RoomReservation>0 AND il.Reservation>0, (SELECT COUNT(ID) FROM roomsdate WHERE RoomReservation=il.RoomReservation AND NOT (ResFlag IN (''X'',''C'',''N'')) LIMIT 1), ' +
                 '          IF(il.Reservation>0, (SELECT COUNT(ID) FROM roomsdate WHERE Reservation=il.Reservation AND NOT (ResFlag IN (''X'',''C'',''N'')) LIMIT 1), ' +
                 '          0)) AS NumberOfDays, ' +
                 ' ' +
                 '       IF(il.RoomReservation>0 AND il.Reservation>0, (SELECT COUNT(ID) FROM persons WHERE RoomReservation=il.RoomReservation LIMIT 1), ' +
                 '          IF(il.Reservation>0, (SELECT COUNT(ID) FROM persons WHERE Reservation=il.Reservation LIMIT 1), 0)) AS NumberOfGuests ' +

                 'FROM roomreservations il ' +
                 'where (%d <= 0 AND Reservation=%d) OR (RoomReservation = %d) ' +
                 ')xxx';
          zS := format(sql, [FRoomReservation, publicReservation, FRoomReservation]);
          lExecutionPlan.AddQuery(zS);

          lExecutionPlan.Execute(ptQuery);

          eSet := lExecutionPlan.Results[0];
          reservationSet := lExecutionPlan.Results[2];
          // hData.rSet_bySQL(zrSet, zS);

          if zFirsttime then // **15-10-16
          begin
            if d.mInvoicelines_before.active then
              d.mInvoicelines_before.close;
            d.mInvoicelines_before.Open;

            if d.mInvoicelines_after.active then
              d.mInvoicelines_after.close;
            d.mInvoicelines_after.Open;

            d.mInvoicelines_before.LoadFromDataSet(eSet, []);
          end;

          eSet.First;
          reservationSet.First;
          if NOT reservationSet.Eof then
          begin
            linesNumDays := reservationSet['NumberOfDays'];
            linesNumGuests := reservationSet['NumberOfGuests'];
            NumberGuestNights := reservationSet['NumberGuestNights'];
          end;
          while not eSet.eof do
          begin
            itemId := trim(eSet.FieldByName('ItemId').asString);
            lineId := eSet.FieldByName('Id').asInteger;

            CurrencyRate := LocalFloatValue(eSet.FieldByName('CurrencyRate')
              .asString);
            Price := LocalFloatValue(eSet.FieldByName('Price').asString);

            if Item_isRoomRent(itemId) then
            begin
              if CurrencyRate <> 0 then
              begin
                Price := Price / CurrencyRate
              end;
            end;
            Room := '';
            RoomReservation := eSet.FieldByName('roomreservationAlias')
              .asinteger;
            if mRoomRes.Locate('roomreservation', RoomReservation, []) then
            begin
              Room := mRoomRes.FieldByName('room').asString;
            end;
            _s := trim(eSet.FieldByName('Description').asString);
            if (eSet.FieldByName('isPackage').asBoolean) and
              (pos('Room :', _s) = 0) then
              _s := _s + ' (Room :' + Room + ')';

            dNumber := GetCalculatedNumberOfItems(ItemId,
                        eSet.GetFloatValue(eSet.FieldByName('Number')));

            idx := AddLine(lineId, itemId, _s,
              dNumber, Price, // -96
              Price * dNumber, // -96
              _DBDateToDate(eSet.FieldByName('PurchaseDate').asString), false,
              trim(eSet.FieldByName('importRefrence').asString),
              trim(eSet.FieldByName('importSource').asString),
              eSet.FieldByName('isPackage').asBoolean,
              eSet.FieldByName('Persons').asinteger,
              eSet.FieldByName('ConfirmDate').asdateTime,
              eSet.GetFloatValue(eSet.FieldByName('ConfirmAmount')),
              RoomReservation, eSet.FieldByName('AutoGen').asString,
              eSet.FieldByName('ItemNumber').asinteger);
            if (agrLines.Cells[col_Item, agrLines.RowCount - 1] <> '') then
              inc(iCurrentRow);
            agrLines.RowCount := iCurrentRow;
            DisplayLine(iCurrentRow - 1, idx);
            eSet.Next;
          end;

          eSet := lExecutionPlan.Results[1];

          if (publicReservation = 0) and (FRoomReservation = 0) then
          begin
            // what
          end
          else
          begin
            eSet.first;

            mPayments.close;
            mPayments.Open;

            while not eSet.eof do
            begin
              // **HJ
              mPayments.insert;
              mPayments.FieldByName('PayType').asString := eSet.FieldByName('PayType').asString;
              mPayments.FieldByName('PayDate').asdateTime := _DBDateToDate(eSet.FieldByName('PayDate').asString);
              mPayments.FieldByName('Amount').asfloat := eSet.FieldByName('Amount').asfloat;
              mPayments.FieldByName('Description').asString := eSet.FieldByName('Description').asString;
              mPayments.FieldByName('PayGroup').asString := '';
              mPayments.FieldByName('Memo').asString := eSet.FieldByName('Notes').asString;
              mPayments.FieldByName('confirmDate').asdateTime := eSet.FieldByName('Confirmdate').asdateTime;
              mPayments.FieldByName('Id').asinteger := eSet.FieldByName('ID').asinteger;

              if glb.Paytypesset.Locate('payType', eSet.FieldByName('PayType').asString, []) then
              begin
                mPayments.FieldByName('PayGroup').asString := glb.Paytypesset.FieldByName('payGroup').asString;
              end;
              mPayments.post;
              eSet.Next;
            end;
          end;

        UpdateItemInvoiceLinesForTaxCalculations;

        inc(iCurrentRow);
        if (agrLines.RowCount > 2) or (trim(agrLines.Cells[col_Item, 1]) <> '')
        then
        begin
          agrLines.RowCount := iCurrentRow;
          calcStayTax(publicReservation); // 001
        end;

        agrLines.row := agrLines.RowCount - 1;

        SetCurrentVisible;

        agrLines.Objects[col_Description, agrLines.RowCount - 1] := TObject(trunc(now));
        // -- PurchaseDate !
        agrLines.Cells[col_date, agrLines.RowCount - 1] :=
          datetostr(trunc(now));

        if zFirsttime then // **15-10-16
        begin
          zFirsttime := false;
          loadInvoiceToMemtable(d.mInvoicelines_before);
        end;
      finally
        lExecutionPlan.free;
      end;
    end;

  finally
    FreeAndNil(zrSet);
    mRoomRes.EnableControls;
    mRoomRates.EnableControls;
    Screen.Cursor := crDefault;
    zFirsttime := true;
  end;

  UpdateItemInvoiceLinesForTaxCalculations;

  zInitString := createAllStr;
  if not zFakeGroup then
    AddEmptyLine(False);
  zInitCurrency := edtCurrency.Text;
  zDataChanged := chkChanged;
  CorrectInvoiceIndexRectangles;

  if not zFakeGroup then
  begin
    setControls;
  end;

//  RemoveAllCheckboxes;
//  CheckCheckboxes;
end;

function TfrmInvoice.LocateDate(recordSet: TRoomerDataset; field: String;
  Value: TDateTime): boolean;
begin
  result := false;
  recordSet.first;
  while NOT recordSet.eof do
  begin
    if recordSet[field] = _DateToDbDate(Value, false) then
    begin
      result := True;
      break;
    end;
    recordSet.Next;
  end;
end;

function TfrmInvoice.FindLastRoomRentLine: integer;
var
  i: integer;
begin
  result := 0;
  for i := 1 to agrLines.RowCount - 1 do
  begin
    if agrLines.Cells[col_Item, i] = g.qRoomRentItem then
      result := i
    else
      break;
  end;
end;

procedure TfrmInvoice.UpdateItemInvoiceLinesForTaxCalculations;
var
  taxGuests: integer;
  taxNights: Double;
  //
  i: integer;
  ItemPrice: Double;
  //
  sTmp: string;
  //
  TotalPrice: Double;
  Item: string;
  //
  TotalVAT: Double;
  itemVAT: Double;
  ItemTypeInfo: TItemTypeInfo;
  //
  //
  dNumItems: Double;
  lInvRoom: TInvoiceRoomEntity;
begin

  tempInvoiceItemList.Clear;

  TotalPrice := 0.00;
  ItemPrice := 0.00;

  zCurrentCurrency := edtCurrency.Text;
  zCurrencyRate := GetRate(zCurrentCurrency);

  taxGuests := 0;
  taxNights := 0.00;
  TotalVAT := 0.00;
  itemVAT := 0.00;

  for i := 1 to agrLines.RowCount - 1 do
  begin
    Item := _trimlower(agrLines.Cells[col_Item, i]);
    if trim(Item) <> '' then
    begin
      ItemTypeInfo := d.Item_Get_ItemTypeInfo(Item,
        agrLines.Cells[col_Source, i]);

      sTmp := trim(agrLines.Cells[col_NoGuests, i]);
      if sTmp <> '' then
      begin
        taxGuests := strToInt(sTmp);
      end;

      sTmp := trim(agrLines.Cells[col_ItemCount, i]);
      if sTmp <> '' then
      begin
        taxNights := _StrToFloat(agrLines.Cells[col_ItemCount, i]); // -96
      end;

      dNumItems := 0;
      sTmp := trim(agrLines.Cells[col_ItemCount, i]);
      if sTmp <> '' then
      begin
        dNumItems := _StrToFloat(sTmp);
      end;

      ItemPrice := 0;
      sTmp := trim(agrLines.Cells[col_ItemPrice, i]);
      if sTmp <> '' then
      begin
        ItemPrice := _StrToFloat(sTmp);
      end;
      if ItemPrice <> 0 then
      begin
        // Formula
        // if Item = _trimlower(g.qRoomRentItem) then
        lInvRoom := TInvoiceRoomEntity.create(Item, taxGuests, taxNights, ItemPrice, 0, 0);
        try
          itemVAT := GetVATForItem(Item, ItemPrice, 1, lInvRoom, nil, ItemTypeInfo, edtCustomer.Text);
        finally
          lInvRoom.Free;
        end;
        // else
        // itemVAT := _calcVAT(itemPrice, ItemTypeInfo.VATPercentage);
      end;

      TotalPrice := 0;
      sTmp := trim(agrLines.Cells[col_TotalPrice, i]);
      TotalVAT := itemVAT * dNumItems;

      tempInvoiceItemList.add(TInvoiceItemEntity.create(Item, taxNights, ItemPrice, itemVAT));
    end;
  end;
end;

function TfrmInvoice.calcStayTax(reservation: integer): boolean;
var
  taxGuests: integer;
  taxNights: Double;

  totalTaxISK: Double;
  discount : Double;

  useStayTax: boolean;

  dTmp: Double;
  iTmp: integer;

  itemId: string;
  i, l: integer;
  ItemCount: integer;
  ItemPrice: Double;
  //
  sTmp: string;
  //
  TotalPrice: Double;
  Item: string;
  //
  RoomInvoiceLines: TInvoiceRoomEntityList;
  ItemInvoiceLines: TInvoiceItemEntityList;
  TaxResultInvoiceLines: TInvoiceTaxEntityList;

  ttTaxIncluded: Double;
  ttTaxExcluded: Double;
  //
  StayTaxUnitCountIncluded: Double;
  StayTaxUnitCountExcluded: Double;

  ttTax: Double;
  StayTaxUnitCount: Double;

  TotalVAT: Double;
  itemVAT: Double;
  ItemTypeInfo: TItemTypeInfo;

  isIncluded: boolean;

  // ttNative: Double;

  Total: Double;

  TaxDescription: String;

  iAddAt: integer;

  dNumItems: Double;
  lInvRoom: TInvoiceRoomEntity;

  RoomInfo : TRoomInfo;

begin


  TotalPrice := 0.00;
  ItemPrice := 0.00;

  zCurrentCurrency := edtCurrency.Text;
  zCurrencyRate := GetRate(zCurrentCurrency);

  RemoveStayTax;

  labLodgingTaxISK.caption := '0';
  labLodgingTaxNights.caption := '0';

  useStayTax := True;
  // glb.LocateSpecificRecordAndGetValue('customers', 'Customer', edtCustomer.Text,
  // 'StayTaxIncluted', useStayTax);
  useStayTax := useStayTax AND ctrlGetBoolean('useStayTax') AND RV_useStayTax(reservation);
  useStayTaxOutcome := useStayTax;

  taxGuests := 0;
  taxNights := 0.00;
  StayTaxUnitCount := 0.00;
  TotalVAT := 0.00;
  itemVAT := 0.00;

  iAddAt := FindLastRoomRentLine + 1;
  ItemInvoiceLines := TInvoiceItemEntityList.Create(True);
  RoomInvoiceLines := TInvoiceRoomEntityList.create(True);
  try
    for i := 1 to agrLines.RowCount - 1 do
    begin
      Item := _trimlower(agrLines.Cells[col_Item, i]);
      if trim(Item) <> '' then
      begin
        ItemTypeInfo := d.Item_Get_ItemTypeInfo(Item, agrLines.Cells[col_Source, i]);

        sTmp := trim(agrLines.Cells[col_NoGuests, i]);
        if sTmp <> '' then
        begin
          taxGuests := strToInt(sTmp);
        end;

        sTmp := trim(agrLines.Cells[col_ItemCount, i]);
        if sTmp <> '' then
        begin
          taxNights := _StrToFloat(agrLines.Cells[col_ItemCount, i]); // -96
        end;

        dNumItems := 0;
        sTmp := trim(agrLines.Cells[col_ItemCount, i]);
        if sTmp <> '' then
        begin
          dNumItems := _StrToFloat(sTmp);
        end;

        ItemPrice := 0;
        sTmp := trim(agrLines.Cells[col_ItemPrice, i]);
        if sTmp <> '' then
        begin
          discount := 0.00;
          if agrLines.Objects[col_ItemCount, i] IS TRoomInfo then
          begin
            RoomInfo := agrLines.Objects[col_ItemCount, i] AS TRoomInfo;
            discount := RoomInfo.Discount;
          end;

          ItemPrice := _StrToFloat(sTmp);
        end;
        if ItemPrice <> 0 then
        begin
          // Formula
          // if Item = _trimlower(g.qRoomRentItem) then
          lInvRoom := TInvoiceRoomEntity.create(Item, taxGuests, taxNights, ItemPrice, 0, discount);
          try
            itemVAT := GetVATForItem(Item, ItemPrice, 1, lInvRoom, tempInvoiceItemList, ItemTypeInfo, edtCustomer.Text);
          finally
            lInvRoom.Free;
          end;
          if NOT(Item_GetKind(Item) IN [ikRoomRent, ikRoomRentDiscount]) then
            agrLines.Cells[col_Vat, i] := trim(_floattostr(itemVAT, vWidth, 3));
          // else
          // itemVAT := _calcVAT(itemPrice, ItemTypeInfo.VATPercentage);
//          if (Item_GetKind(Item) IN [ikRoomRentDiscount]) then
//            continue;
//          if (Item_GetKind(Item) IN [ikRoomRent]) then
//            continue;
        end;

        TotalPrice := 0;
        sTmp := trim(agrLines.Cells[col_TotalPrice, i]);
        TotalVAT := itemVAT * dNumItems;
        // if sTmp <> '' then
        // begin
        // totalPrice := _StrToFloat(sTmp);
        // end;
        // if totalPrice <> 0 then
        // begin
        // TotalVAT := _calcVAT(totalPrice, ItemTypeInfo.VATPercentage);
        // end;

        if Item = _trimlower(g.qRoomRentItem) then
        begin
          RoomInvoiceLines.add(TInvoiceRoomEntity.create(Item, taxGuests, taxNights, ItemPrice, itemVAT, discount));
        end;

        ItemInvoiceLines.add(TInvoiceItemEntity.create(Item, taxNights, ItemPrice, itemVAT));
      end;
    end;

    glb.LocateSpecificRecordAndGetValue('customers', 'Customer', edtCustomer.Text, 'StayTaxIncluted', isIncluded);

    if useStayTax then
    begin
      ItemTypeInfo := d.Item_Get_ItemTypeInfo(trim(g.qRoomRentItem));
      TaxResultInvoiceLines := GetTaxesForInvoice(RoomInvoiceLines, ItemInvoiceLines, ItemTypeInfo, isIncluded);
    end
    else
      TaxResultInvoiceLines := TInvoiceTaxEntityList.create(True);

    try

      StayTaxUnitCount := 0.00;
      ttTax := 0.00;
      // ttNative := 0.00;
      ttTaxIncluded := 0.00;
      ttTaxExcluded := 0.00;

      StayTaxUnitCountIncluded := 0.00;
      StayTaxUnitCountExcluded := 0.00;

      isIncluded := false;

      GetTaxTypes(TaxResultInvoiceLines);
      for l := 0 to TaxTypes.Count - 1 do
      begin
        ttTaxExcluded := 0;
        StayTaxUnitCountExcluded := 0;
        for i := 0 to TaxResultInvoiceLines.Count - 1 do
          if TaxResultInvoiceLines[i].BookingItem = TaxTypes[l] then
          begin
            Total := TaxResultInvoiceLines[i].Total;

            // ttNative := ttNative + Total;
            StayTaxUnitCount := StayTaxUnitCount + TaxResultInvoiceLines[i].NumItems;

            // if _trimlower(zNativeCurrency) <> _trimlower(zCurrenctCurrency) then
            // begin
            // if ttNative <> 0 then
            // ttNative := _RoundN(ttNative / zCurrencyRate, 2);
            // end;

            if TaxResultInvoiceLines[i].IncludedInPrice = TIE_PER_CUSTOMER then
            begin
              glb.LocateSpecificRecordAndGetValue('customers', 'Customer', edtCustomer.Text, 'StayTaxIncluted', isIncluded);
            end else
            if TaxResultInvoiceLines[i].IncludedInPrice = TIE_INCLUDED then
            begin
              isIncluded := True;
            end else
            if TaxResultInvoiceLines[i].IncludedInPrice = TIE_EXCLUDED then
            begin
              isIncluded := false;
            end;

            if isIncluded then
            begin
              // if NOT TaxResultInvoiceLines[i].Percentage then
              // ttTaxIncluted := ttTaxIncluted + _RoundN(Total / zCurrencyRate, 2)
              // else
              ttTaxIncluded := ttTaxIncluded + Total;
              StayTaxUnitCountIncluded := StayTaxUnitCountIncluded + TaxResultInvoiceLines[i].NumItems;
            end
            else
            begin
              if NOT TaxResultInvoiceLines[i].Percentage then
                ttTaxExcluded := ttTaxExcluded + _RoundN(Total / zCurrencyRate, 2)
              else
                ttTaxExcluded := ttTaxExcluded + Total;
              StayTaxUnitCountExcluded := StayTaxUnitCountExcluded +
                TaxResultInvoiceLines[i].NumItems;
            end;

          end;

        // if _trimlower(zNativeCurrency) <> _trimlower(zCurrenctCurrency) then
        // begin
        // if ttTaxIncluted <> 0 then
        // ttTaxIncluted := _RoundN(ttTaxIncluted / zCurrencyRate, 2);

        // if ttTaxExcluted <> 0 then
        // ttTaxExcluted := _RoundN(ttTaxExcluted / zCurrencyRate, 2);
        // end;

        if (StayTaxUnitCountExcluded <> 0) then
        begin
          AddRoomTax(ttTaxExcluded, StayTaxUnitCountExcluded, TaxTypes[l], iAddAt);
        end;
      end;
    finally
      TaxResultInvoiceLines.Free;
    end;

    grbInclutedTaxes.visible := (StayTaxUnitCountIncluded <> 0);

    labLodgingTaxISK.caption := _floattostr(ttTaxIncluded, vWidth, vDec);
    labLodgingTaxNights.caption := floattostr(StayTaxUnitCount);

    DisplayTotals;
  finally
    RoomInvoiceLines.free;
    ItemInvoiceLines.free;
  end;
end;

procedure TfrmInvoice.GetTaxTypes(TaxResultInvoiceLines: TInvoiceTaxEntityList);
var
  i: integer;
  Item: String;
begin
  TaxTypes.Clear;
  for i := 0 to TaxResultInvoiceLines.Count - 1 do
  begin
    Item := TaxResultInvoiceLines[i].BookingItem;
    if TaxTypes.IndexOf(Item) < 0 then
      TaxTypes.add(Item);
  end;
end;

function TfrmInvoice.RemoveStayTax: boolean;
var
  i: integer;
  anyRemoved: boolean;
begin
  anyRemoved := false;
  for i := agrLines.RowCount - 1 downto 1 do
  begin
    if TaxTypes.IndexOf(agrLines.Cells[col_Item, i]) >= 0 then
    begin
      DeleteRow(agrLines, i);
      anyRemoved := True;
    end;
  end;
  if anyRemoved then
  begin
    AddEmptyLine;
    DisplayTotals;
    zDataChanged := chkChanged;
  end;
end;

procedure TfrmInvoice.setControls;
begin
  // tabRoomPrice.TabVisible := false;
  // tabInvoice.TabVisible := false;

  btnRoomToTemp.Enabled := not((publicReservation = 0) AND
    (FRoomReservation = 0));
  if (agrLines.Cells[col_Item, 1] = '') then
    btnRoomToTemp.Enabled := false;

  btnItemToTmp.Enabled := btnRoomToTemp.Enabled;
  // btnItemToGroupInvoice.Enabled := btnRoomToTemp.Enabled;
  // btnRoomToGroupinvoice.Enabled := btnRoomToTemp.Enabled;
  btnRemoveLodgingTax2.Enabled := btnRoomToTemp.Enabled;
  btnReservationNotes.Enabled := btnRoomToTemp.Enabled;
  Removetemporarily1.Enabled := btnRoomToTemp.Enabled;
  RemoveRoomRenttemporarity1.Enabled := btnRoomToTemp.Enabled;
  Setjahpreikning1.Enabled := btnRoomToTemp.Enabled;

end;

function TfrmInvoice.GenerateInvoiceNumber: integer;
var
  iTemp: DWord;
begin
  iTemp := GetTickCount;
  if iTemp > 2100000000 then
    iTemp := 999999 + (iTemp - 2100000000)
  else if iTemp < 999999 then
    iTemp := 999999 + iTemp;
  result := iTemp;
end;

procedure TfrmInvoice.DeleteLinesInList(ExecutionPlan: TRoomerExecutionPlan);
var i : Integer;
begin
  for i IN DeletedLines do
  begin
    ExecutionPlan.AddExec('DELETE FROM invoicelines WHERE ID=' + inttostr(i));
  end;
  DeletedLines.Clear;
end;

procedure TfrmInvoice.FormCreate(Sender: TObject);
begin
  zErr := false;
  zFirsttime := True;
  zApply := false;

  linesNumDays := 0;
  linesNumGuests := 0;
  NumberGuestNights := 0;

  DeletedLines := TList<Integer>.Create;


  FInvoiceIndex := 0;

  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  // _RestoreWinPos(g.qAppInifile, TForm(Self).name, TForm(Self));

  SelectableRooms := TRoomInfoList.create(True);
  TaxTypes := TStringList.create;

  useStayTaxAlreadyFetched := false;
  useStayTaxOutcome := True;
  tempInvoiceNo := GenerateInvoiceNumber;
  pageMain.ActivePageIndex := 0;
  zEmailAddress := '';

  // btnGetCurrency.Visible := false;
  // btnGetRate.Visible := false;

  zDoSave := True;

  zRoomRSet := CreateNewDataSet;
  zRoomRSet.CommandType := cmdText;

  zS := '';
  zLocation := '';
  zOriginalInvoice := 0;
  zRoomIsInTemp := false;;

  zLstLines := TList.create;

  zCellEdited := false;
  zCellValue := '';

  zCol := -1;
  zRow := -1;
  // label12.caption:= ('Dálkur '+inttostr(zCol)+' / Lína '+inttostr(zRow));

  zbDoingReference := false;

  vDec := 2;

  zCurrencyRate := 1.00;
  pageMain.ActivePageIndex := 0;
  // btnGetCurrency.Visible := false;
  // btnGetRate.Visible := false;

  zLstRooms := TList.create;
  tempInvoiceItemList := TInvoiceItemEntityList.create(True);
  agrLines.ColWidths[col_Select] := 30;

end;

procedure TfrmInvoice.FormDestroy(Sender: TObject);
begin
  try
    OnResize := nil;
    SelectableRooms.free;
    RemoveInvalidKreditInvoice;
    // DeleteProforma;

    // _SaveWinPos(g.qAppInifile, TForm(Self).name, Self);

    NullifyGrid;
    // freeandNil(agrLines);

    // --
    ClearObjects;
    ClearLines;

    zLstLines.free;
    zLstRooms.free;

    if mRoomRes.active then
      mRoomRes.close;
    if mRoomRates.active then
      mRoomRates.close;

    TaxTypes.free;

    // Action := caFree;
    // frmMain.timCloseInvoice.enabled := True;
  except
  end;

  FreeAndNil(zRoomRSet);
  tempInvoiceItemList.Free;

  frmMain.btnRefresh.Click;
end;

procedure TfrmInvoice.FormResize(Sender: TObject);
begin
  agrLines.AutoFitColumns(false);
end;

procedure TfrmInvoice.FormShow(Sender: TObject);
begin
  sPanel4.Visible := NOT (IsCashInvoice OR FCredit);
end;

procedure TfrmInvoice.N91Click(Sender: TObject);
var
  omnu: TMenuItem;
  list : TList<String>;
  i, l : Integer;
begin
  //
  omnu := TMenuItem(Sender).Parent;

  list := GetSelectedRows;
  try
    for l := list.Count - 1 downto 0 do
    begin
      i := IndexOfAutoGen(list[l]);
      if i >= 0 then
      begin
        agrLines.Row := i;
        MoveItemToRoomInvoice(SelectableRooms[omnu.Tag].FRoomReservation, TMenuItem(Sender).Tag);
      end;
    end;
  finally
    list.free;
  end;
end;

procedure TfrmInvoice.NullifyGrid;
var
  iCol, iRow: integer;
begin
  agrLines.UnHideColumnsAll;
  for iRow := 0 to agrLines.RowCount - 1 do
    for iCol := 0 to agrLines.ColCount - 1 do
      agrLines.Objects[iCol, iRow] := nil;
  agrLines.RowCount := 0;
  agrLines.ColCount := 0;
  agrLines.ClearAll;
end;

procedure TfrmInvoice.AddEmptyLine(CheckChanged : Boolean = True);
var
  i: Integer;
begin
  if (agrLines.Cells[col_Item, agrLines.RowCount - 1] <> '') then
    agrLines.RowCount := agrLines.RowCount + 1;

  for i := col_Select to col_AutoGen do
  begin
    agrLines.Objects[i, agrLines.RowCount - 1] := nil;
    agrLines.Cells[i, agrLines.RowCount - 1] := '';
  end;
  agrLines.row := agrLines.RowCount - 1;
  agrLines.Objects[col_Description, agrLines.row] := TObject(trunc(now)); // -- PurchaseDate !
  agrLines.Cells[col_date, agrLines.row] := datetostr(trunc(now));

  agrLines.Col := 0;
  SetCurrentVisible;
  // DC1
  // DataChanged  := true;
  if CheckChanged then
    zDataChanged := chkChanged
  else
    zDataChanged := False;
  ForceRowChange;
end;

procedure TfrmInvoice.AddEmptyLine1;
var
  i: Integer;
begin
  if (agrLines.Cells[col_Item, agrLines.RowCount - 1] <> '') then
    agrLines.RowCount := agrLines.RowCount + 1;

  for i := col_Select to col_AutoGen do
  begin
    agrLines.Objects[i, agrLines.RowCount - 1] := nil;
    agrLines.Cells[i, agrLines.RowCount - 1] := '';
  end;

  agrLines.Objects[col_Description, agrLines.RowCount - 1] := TObject(trunc(now));
  // -- PurchaseDate !
  agrLines.Cells[col_date, agrLines.RowCount - 1] := datetostr(trunc(now));

  agrLines.Objects[col_Description, agrLines.RowCount - 2] := TObject(trunc(now));
  // -- PurchaseDate !
  agrLines.Cells[col_date, agrLines.RowCount - 2] := datetostr(trunc(now));
end;

function TfrmInvoice.PrepareInvoice: boolean;
var
  invNo: integer;

begin
  zExit := false;
  // caption := 'INVOICE';
  caption := GetTranslatedText('shUI_InvoiceCaption');

  zLodgingTaxISK := 0.00;
  zLodgingTaxNights := 0;

  labTmpStatus.caption := inttostr(d.kbmInvoicelines.RecordCount);
  ClabLodgingTaxCurrency.caption := g.qNativeCurrency;

  if not zFakeGroup then
  begin
    ForceSelectCell;

    agrLines.Col := 0;
    agrLines.row := 1;

    // --
    if FCredit then
    begin
      clabInvoice.caption := GetTranslatedText('shUI_CreditInvoiceCaption');
      Panel1.Color := $00F5ECFF; // $00EAFFEA
      Panel2.Color := $00F5ECFF; // $00EAFFEA

      zCreditType := ctManual;;
      zRefNum := -1;

      // BHG: NO Reference needed as this is only used when credit with no reference is being created...
      // ****
      // _frmCreditPrompt := TfrmCreditPrompt.Create(nil);
      // try
      // _frmCreditPrompt.ShowModal;
      // if _frmCreditPrompt.ModalResult = mrCancel then
      // begin
      // zExit := true;
      // zCreditType := ctErr;
      // zRefNum := -1;
      // end
      // else
      // begin
      // refText := trim(_frmCreditPrompt.edRefNumber.Text);
      // if refText <> '' then
      // begin
      invNo := 0;

      // if _isInteger(refText) then
      // begin
      // invNo := strToInt(refText);
      // end
      // else
      // begin
      // showmessage(format(GetTranslatedText('shTx_Invoice_NotANumber'),[_frmCreditPrompt.edRefNumber.Text]));
      // zExit := true;
      // zCreditType := ctErr;
      // zRefNum := -1;
      // end;

      // if invNo > 0 then // Will never happen...!!!
      // begin
      // if not(hData.InvoiceExists(invNo)) then
      // begin
      // showmessage(format(GetTranslatedText('shTx_Invoice_InvoiceNumber'),[refText]));
      // zExit := true;
      // zCreditType := ctErr;
      // zRefNum := -1;
      // end
      // else if (d.isKredit(invNo)) then
      // begin
      // showmessage(GetTranslatedText('shTx_Invoice_CreditInvoice'));
      // zExit := true;
      // zCreditType := ctErr;
      // zRefNum := -1;
      // end;
      // end;

      // zCreditType := ctReference;
      zRefNum := invNo;

      // if zRefNum = 0 then
      // begin
      zCreditType := ctManual;
      zRefNum := -1;
      zOriginalInvoice := zRefNum;
      // end
      // else
      // begin
      // btnGetCurrency.Enabled := false;
      // btnGetRate.Enabled     := false;
      // edtCurrency.Enabled    := false;
      // edtRate.Enabled        := false;
      // zOriginalInvoice      := zRefNum;
      // LoadKreditLines;
      // end;
      // end;
      // end;

      // finally
      // FreeAndNil(_frmCreditPrompt);
      // end;
    end;

    // DataChanged := false;
    zInitString := createAllStr;
    zInitCurrency := edtCurrency.Text;
    zDataChanged := chkChanged;
  end;

  try
  agrLines.ColWidths[col_ItemCount] := 100;
  agrLines.ColWidths[col_ItemPrice] := 100;
  agrLines.ColWidths[col_TotalPrice] := 100;
  except end;

  result := NOT zExit;

  OriginalInvoiceStatus := GridFloatValueFromString(edtBalance.Text);
end;

procedure TfrmInvoice.ForceSelectCell;
var
  CanSelect: boolean;
begin
  // --
  CanSelect := True;
  // agrLines.SetFocus;
end;

procedure TfrmInvoice.CheckRoomRentItem(iRow: integer);
var
  i: integer;
  iNights: integer;
  iPersons: integer;
  iRooms: integer;
  dRoomPrice: Double;
  ttRoomNights: Double; // -96
  ttPrice: Double;

begin
  i := iRow;

  if agrLines.Cells[col_Item, i] = g.qRoomRentItem then
  begin
    iPersons := 1;
    iRooms := 1;
    iNights := 1;
    dRoomPrice := 0;

    if g.AddAccommodation(iPersons, iRooms, iNights, dRoomPrice) then
    begin
      ttRoomNights := iNights * iRooms;
      ttPrice := ttRoomNights * dRoomPrice;

      if (iPersons > 0) and (iNights > 0) then
      begin
        agrLines.Cells[col_ItemCount, i] := _floattostr(ttRoomNights,
          vWidth, vDec);
        agrLines.Cells[col_ItemPrice, i] :=
          _floattostr(dRoomPrice, vWidth, vDec);
        agrLines.Cells[col_NoGuests, i] := inttostr(iPersons);

        if (agrLines.Objects[col_ItemCount, i] <> nil) and
          (agrLines.Objects[col_ItemCount, i] is TRoomInfo) then
        begin
          TRoomInfo(agrLines.Objects[col_ItemCount, i]).FRoomReservation := -1;
          TRoomInfo(agrLines.Objects[col_ItemCount, i]).FReservation := -1;
          TRoomInfo(agrLines.Objects[col_ItemCount, i]).FName := edtName.Text;
          TRoomInfo(agrLines.Objects[col_ItemCount, i]).FFrom := now;
          TRoomInfo(agrLines.Objects[col_ItemCount, i]).FTo := now + iNights;
          TRoomInfo(agrLines.Objects[col_ItemCount, i]).FPrice :=
            _StrToFloat(agrLines.Cells[col_ItemPrice, i]);
          TRoomInfo(agrLines.Objects[col_ItemCount, i]).FNumPersons := iPersons;
        end
        else
        begin
          RoomInfo := TRoomInfo.create;
          RoomInfo.FRoomReservation := -1;
          RoomInfo.FReservation := -1;
          RoomInfo.FName := edtName.Text;
          RoomInfo.FFrom := now;
          RoomInfo.FTo := now + iNights;
          RoomInfo.FPrice := _StrToFloat(agrLines.Cells[col_ItemPrice, i]);
          RoomInfo.FNumPersons := iPersons;
          agrLines.Objects[col_ItemCount, i] := RoomInfo;
          zLstRooms.add(RoomInfo);
        end;

        agrLines.Cells[col_TotalPrice, i] := _floattostr(ttPrice, vWidth, vDec);
        calcStayTax(publicReservation); // 002
        zDataChanged := chkChanged;
      end;
    end;
  end;

end;

function TfrmInvoice.CheckIfWithdrawlAllowed(removeIfNotAllowed: boolean;
  Editing: boolean): boolean;
var
  minValue: Double;
begin
  result := True;
  minValue := 0.00;
  if Editing then
  begin
    if agrLines.Col = col_Item then
      minValue := GridFloatValueFromString(zCellValue) *
        GridCellfloatValue(agrLines, col_ItemPrice, agrLines.row)
    else if agrLines.Col = col_ItemPrice then
      minValue := GridFloatValueFromString(zCellValue) *
        GridCellfloatValue(agrLines, col_ItemCount, agrLines.row);
  end;

  if (FRoomReservation > 0) AND
    (NOT d.roomerMainDataSet.SystemIsRoomWithdrawalAllowed(FRoomReservation,
    (GridCellfloatValue(agrLines, col_ItemCount, agrLines.row) *
    GridCellfloatValue(agrLines, col_ItemPrice, agrLines.row)) - minValue)) then
  begin
    MessageDlg(GetTranslatedText('shUI_AmountOverAllowedWithdrawalLimit'),
      mtWarning, [mbOk], 0);
    if removeIfNotAllowed then
    begin
      DeleteRow(agrLines, agrLines.row);
      AddEmptyLine;
    end
    else
    begin
      if agrLines.Col = col_Item then
        agrLines.Cells[col_ItemPrice, zRow] := zCellValue
      else if agrLines.Col = col_ItemPrice then
        agrLines.Cells[col_ItemPrice, zRow] := zCellValue
    end;
    result := false;
  end;
end;

procedure TfrmInvoice.agrLinesMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  ACol: integer;
  ARow: integer;
  itemId: string;
  tmpRoomReservation: integer;
begin

  agrLines.MouseToCell(X, Y, ACol, ARow);
  if ssCtrl in Shift then
  begin
    agrLines.row := ARow;
    agrLines.Col := ACol;
    if (ARow >= 0) AND (ARow < agrLines.RowCount) then
      agrLines.BeginDrag(True);
    exit;
  end;

  if (ACol < 0) OR (ACol >= agrLines.ColCount) OR (ARow < 0) OR
    (ARow >= agrLines.RowCount) then
    exit;

  zCol := ACol;
  zRow := ARow;
  itemId := agrLines.Cells[col_Item, ARow];
  tmpRoomReservation := FRoomReservation;
  selectedRoomReservation := -1;

  if { (zCol IN [COL_ITEMCOUNT, COL_ITEMPRICE]) AND }
    (zCol > 0) AND // Skip Checkbox column
    (((itemId = g.qRoomRentItem) or (itemId = g.qDiscountItem)) AND
    (isSystemLine(agrLines.row) = True)) then
  begin
    if tmpRoomReservation = 0 then // þ.e GroupInvoice
    begin
      try
        tmpRoomReservation := TRoomInfo(agrLines.Objects[col_ItemCount, zRow])
          .FRoomReservation;
      except
        tmpRoomReservation := -1;
      end;
    end;

    selectedRoomReservation := tmpRoomReservation;
    if (ACol = col_Description) or (ACol = col_ItemCount) then
      exit;

    if tmpRoomReservation <> -1 then
    begin
      if (itemId = g.qRoomRentItem) then
      begin
        pageMain.ActivePageIndex := 1;
        btnExit.Enabled := false;
        btnInvoice.Enabled := false;
        btnProforma.Enabled := false;
      end
      else if (itemId = g.qDiscountItem) then
      begin
        pageMain.ActivePageIndex := 1;
        btnExit.Enabled := false;
        btnInvoice.Enabled := false;
        btnProforma.Enabled := false;
      end;
    end;
    exit;
  end;

  TAdvStringGrid(Sender).MouseToCell(X, Y, ACol, ARow);
  if ARow > 0 then
  begin
    TAdvStringGrid(Sender).row := ARow;
    TAdvStringGrid(Sender).Col := ACol;
  end;
end;

procedure TfrmInvoice.CheckCheckboxes;
var i : Integer;
begin
  for i := 0 to agrLines.RowCount - 1 do
    try if NOT agrLines.HasCheckbox(col_Select, i) then
      if agrLines.Cells[col_Item, i] <> '' then
        agrLines.AddCheckBox(col_Select, i, false, false); Except end;
  AnyRowChecked := IsAnyCheckboxChecked;
end;

procedure TfrmInvoice.CheckOrUncheckAll(check : Boolean);
var i : Integer;
begin
  for i := 0 to agrLines.RowCount - 1 do
    if agrLines.HasCheckbox(col_Select, i) then
      agrLines.SetCheckBoxState(col_Select, i, check);
  AnyRowChecked := IsAnyCheckboxChecked;
end;

procedure TfrmInvoice.agrLinesRowChanging(Sender: TObject;
  OldRow, NewRow: integer; var Allow: boolean);
var
  sCurrentItem, sRoomRentItem, sDiscountItem: String;
begin
  try
    if NewRow > 0 then
    begin
      sCurrentItem := _trimlower(agrLines.Cells[col_Item, NewRow]);
      sRoomRentItem := _trimlower(g.qRoomRentItem);
      sDiscountItem := _trimlower(g.qDiscountItem);

      btnRoomToTemp.Enabled := ((sCurrentItem = sRoomRentItem) OR (sCurrentItem = sDiscountItem)) OR (AnyRowChecked AND IsRoomSelected);
      btnItemToTmp.Enabled := AnyRowChecked OR ((NOT isSystemLine(NewRow)) AND (sCurrentItem <> ''));
      btnMoveItem.Enabled := btnItemToTmp.Enabled OR AnyRowChecked;
      btnMoveRoom.Enabled := btnRoomToTemp.Enabled;
      btnRemoveItem.Enabled := btnItemToTmp.Enabled OR AnyRowChecked;
    end
    else
    begin
      btnRoomToTemp.Enabled := AnyRowChecked;
      btnItemToTmp.Enabled := AnyRowChecked;
      btnMoveItem.Enabled := btnItemToTmp.Enabled;
      btnMoveRoom.Enabled := btnRoomToTemp.Enabled AND IsRoomSelected;
      btnRemoveItem.Enabled := btnItemToTmp.Enabled;
    end;
  except
    // Hide and problem that happens in this event.
    // There never should be exception here, but if
    // one happens then it should not stop the chain
    // of events from firing.
  end;
  CheckCheckboxes;
end;

procedure TfrmInvoice.edtTotalChange(Sender: TObject);
begin
  TEdit(Sender).OnChange := nil;
  try
    TEdit(Sender).Text := RightAligned(TEdit(Sender).Text, 12);
  finally
    TEdit(Sender).OnChange := edtTotalChange;
  end;
end;

procedure TfrmInvoice.Refrence1Click(Sender: TObject);
var
  s: string;
begin
  s := edtInvRefrence.Text;
end;

procedure TfrmInvoice.RemoveInvalidKreditInvoice;
var i : Integer;
begin
  for i := LOW(REMOVE_REDUNDANT_INVOICES) to HIGH(REMOVE_REDUNDANT_INVOICES) do
    d.roomerMainDataSet.DoCommand(REMOVE_REDUNDANT_INVOICES[i]);
end;

procedure TfrmInvoice.SaveHeader(FTotal, fVat, fWOVat: Double;
  aExecutionPlan: TRoomerExecutionPlan);
var
  iMultiplier: integer;
var
  s: string;
  showPackage: boolean;
begin
  showPackage := chkShowPackage.checked;

  iMultiplier := 1;

  // Til þess að setja allar tölur í mínus
  if FCredit then
    iMultiplier := -1;

  // --
  // SQL 115 INSERxT InvoiceHeads
  // INS-InvoiceHeads
  s := '';
  s := s + 'INSERT into invoiceheads ' + #10;
  s := s + '(' + #10;
  s := s + '  Reservation ' + #10;
  s := s + ', RoomReservation ' + #10;
  s := s + ', SplitNumber ' + #10;

  s := s + ', InvoiceNumber ' + #10;
  s := s + ', InvoiceDate ' + #10;

  s := s + ', Customer ' + #10;
  s := s + ', Name ' + #10;
  s := s + ', CustPid ' + #10;
  s := s + ', RoomGuest ' + #10;

  s := s + ', Address1 ' + #10;
  s := s + ', Address2 ' + #10;
  s := s + ', Address3 ' + #10;
  s := s + ', Address4 ' + #10;
  s := s + ', Country ' + #10;
  s := s + ', Total ' + #10;
  s := s + ', TotalWOVat ' + #10;
  s := s + ', TotalVat ' + #10;
  s := s + ', TotalBreakfast ' + #10;
  s := s + ', ExtraText ' + #10;
  s := s + ', OriginalInvoice ' + #10;
  s := s + ', Finished ' + #10;
  s := s + ', InvoiceType ' + #10;
  s := s + ', ihStaff ' + #10;
  s := s + ', ihDate ' + #10;
  s := s + ', ihInvoiceDate ' + #10;
  s := s + ', ihConfirmDate ' + #10;
  s := s + ', ihPayDate ' + #10;
  s := s + ', invRefrence ' + #10;
  s := s + ', ihCurrency ' + #10; // **98
  s := s + ', ihCurrencyrate ' + #10; // **98
  s := s + ', showPackage ' + #10; // *99+
  s := s + ', Location ' + #10; // *99+

  s := s + ')' + #10;
  s := s + 'Values' + #10;
  s := s + '(' + #10;
  s := s + '  ' + _db(publicReservation);
  s := s + ', ' + _db(FRoomReservation);
  s := s + ', ' + _db(FnewSplitNumber);
  s := s + ', ' + _db(zInvoiceNumber);
  s := s + ', ' + _DateToDbDate(zInvoiceDate, True);
  s := s + ', ' + format('(SELECT IFNULL((SELECT Customer FROM invoiceaddressees ia WHERE ia.invoiceNumber=%d ' +
          '        AND ia.Reservation=%d ' +
          '        AND ia.RoomReservation=%d ' +
          '        AND ia.SplitNumber=%d ' +
          '        AND ia.InvoiceIndex=%d ' +
          '       ), %s))', [zInvoiceNumber, publicReservation, FRoomReservation, FnewSplitNumber, InvoiceIndex, _db(edtCustomer.Text)]);
  s := s + ', ' + format('(SELECT IFNULL((SELECT Name FROM invoiceaddressees ia WHERE ia.invoiceNumber=%d ' +
          '        AND ia.Reservation=%d ' +
          '        AND ia.RoomReservation=%d ' +
          '        AND ia.SplitNumber=%d ' +
          '        AND ia.InvoiceIndex=%d ' +
          '       ), %s))', [zInvoiceNumber, publicReservation, FRoomReservation, FnewSplitNumber, InvoiceIndex, _db(edtName.Text)]);
  s := s + ', ' + format('(SELECT IFNULL((SELECT CustPid FROM invoiceaddressees ia WHERE ia.invoiceNumber=%d ' +
          '        AND ia.Reservation=%d ' +
          '        AND ia.RoomReservation=%d ' +
          '        AND ia.SplitNumber=%d ' +
          '        AND ia.InvoiceIndex=%d ' +
          '       ), %s))', [zInvoiceNumber, publicReservation, FRoomReservation, FnewSplitNumber, InvoiceIndex, _db(edtPersonalId.Text)]);
  s := s + ', ' + _db(edtRoomGuest.Text);
  s := s + ', ' + format('(SELECT IFNULL((SELECT Address1 FROM invoiceaddressees ia WHERE ia.invoiceNumber=%d ' +
          '        AND ia.Reservation=%d ' +
          '        AND ia.RoomReservation=%d ' +
          '        AND ia.SplitNumber=%d ' +
          '        AND ia.InvoiceIndex=%d ' +
          '       ), %s))', [zInvoiceNumber, publicReservation, FRoomReservation, FnewSplitNumber, InvoiceIndex, _db(edtAddress1.Text)]);
  s := s + ', ' + format('(SELECT IFNULL((SELECT Address2 FROM invoiceaddressees ia WHERE ia.invoiceNumber=%d ' +
          '        AND ia.Reservation=%d ' +
          '        AND ia.RoomReservation=%d ' +
          '        AND ia.SplitNumber=%d ' +
          '        AND ia.InvoiceIndex=%d ' +
          '       ), %s))', [zInvoiceNumber, publicReservation, FRoomReservation, FnewSplitNumber, InvoiceIndex, _db(edtAddress2.Text)]);
  s := s + ', ' + format('(SELECT IFNULL((SELECT Zip FROM invoiceaddressees ia WHERE ia.invoiceNumber=%d ' +
          '        AND ia.Reservation=%d ' +
          '        AND ia.RoomReservation=%d ' +
          '        AND ia.SplitNumber=%d ' +
          '        AND ia.InvoiceIndex=%d ' +
          '       ), %s))', [zInvoiceNumber, publicReservation, FRoomReservation, FnewSplitNumber, InvoiceIndex, _db(edtAddress3.Text)]);
  s := s + ', ' + format('(SELECT IFNULL((SELECT City FROM invoiceaddressees ia WHERE ia.invoiceNumber=%d ' +
          '        AND ia.Reservation=%d ' +
          '        AND ia.RoomReservation=%d ' +
          '        AND ia.SplitNumber=%d ' +
          '        AND ia.InvoiceIndex=%d ' +
          '       ), %s))', [zInvoiceNumber, publicReservation, FRoomReservation, FnewSplitNumber, InvoiceIndex, _db(edtAddress4.Text)]);
  s := s + ', ' + format('(SELECT IFNULL((SELECT Country FROM invoiceaddressees ia WHERE ia.invoiceNumber=%d ' +
          '        AND ia.Reservation=%d ' +
          '        AND ia.RoomReservation=%d ' +
          '        AND ia.SplitNumber=%d ' +
          '        AND ia.InvoiceIndex=%d ' +
          '       ), %s))', [zInvoiceNumber, publicReservation, FRoomReservation, FnewSplitNumber, InvoiceIndex, _db(zCountry)]);
  s := s + ', ' + _CommaToDot(floattostr(iMultiplier * FTotal));
  s := s + ', ' + _CommaToDot(floattostr(iMultiplier * fWOVat));
  s := s + ', ' + _CommaToDot(floattostr(iMultiplier * fVat));
  s := s + ', ' + _CommaToDot(floattostr(0.00));
  s := s + ', ' + _db('');
  s := s + ', ' + inttostr(zOriginalInvoice);
  s := s + ', ' + _db(false);
  s := s + ', ' + inttostr(1);
  s := s + ', ' + _db(g.qUser);
  s := s + ', ' + _DateToDbDate(Date, True);
  s := s + ', ' + _DateToDbDate(zInvoiceDate, True);
  s := s + ', ' + _DateToDbDate(zConfirmDate, True);
  s := s + ', ' + _DateToDbDate(zPayDate, True);
  s := s + ', ' + _db(edtInvRefrence.Text);
  s := s + ', ' + _db(edtCurrency.Text);
  s := s + ', ' + _db(_StrToFloat(edtRate.Text));
  s := s + ', ' + _db(showPackage);
  s := s + ', ' + _db(zLocation);
  s := s + ')' + #10;

//  copytoclipboard(s);
//  debugmessage(s);

  aExecutionPlan.AddExec(s);
  // if not cmd_bySQL(s) then
  // begin
  // end;

  s := format('INSERT INTO invoiceaddressees ' +
       '(InvoiceIndex, ' +
       'Reservation, ' +
       'RoomReservation, ' +
       'SplitNumber, ' +
       'InvoiceNumber, ' +
       'Customer, ' +
       'Name, ' +
       'Address1, ' +
       'Address2, ' +
       'Zip, ' +
       'City, ' +
       'Country, ' +
       'ExtraText, ' +
       'custPID, ' +
       'InvoiceType, ' +
       'ihCurrency) ' +
       'VALUES ' +
       '(%d, ' +
       '%d, ' +
       '%d, ' +
       '%d, ' +
       '%d, ' +
       '%s, ' +
       '%s, ' +
       '%s, ' +
       '%s, ' +
       '%s, ' +
       '%s, ' +
       '%s, ' +
       '%s, ' +
       '%s, ' +
       '%d, ' +
       '%s) ',
       [
        InvoiceIndex,
        publicReservation,
        FRoomReservation,
        FNewSplitNumber,
        zInvoiceNumber,
        _db(edtCustomer.text),
        _db(edtName.text),
        _db(edtAddress1.text),
        _db(edtAddress2.text),
        _db(edtAddress3.text),
        _db(edtAddress4.text),
        _db(zCountry),
        _db(memExtraText.Lines.Text),
        _db(edtPersonalId.Text),
        rgrInvoiceType.itemIndex,
        _db(edtCurrency.Text)
        ]) +

       format('ON DUPLICATE KEY UPDATE ' +
       'InvoiceNumber=%d, ' +
       'Customer=%s, ' +
       'Name=%s, ' +
       'Address1=%s, ' +
       'Address2=%s, ' +
       'Zip=%s, ' +
       'City=%s, ' +
       'Country=%s, ' +
       'ExtraText=%s, ' +
       'custPID=%s, ' +
       'InvoiceType=%d, ' +
       'ihCurrency=%s',
       [
        zInvoiceNumber,
        _db(edtCustomer.text),
        _db(edtName.text),
        _db(edtAddress1.text),
        _db(edtAddress2.text),
        _db(edtAddress3.text),
        _db(edtAddress4.text),
        _db(zCountry),
        _db(memExtraText.Lines.Text),
        _db(edtPersonalId.Text),
        rgrInvoiceType.itemIndex,
        _db(edtCurrency.Text)
       ]);

  aExecutionPlan.AddExec(s);
//  CopyToClipboard(s);
end;

procedure TfrmInvoice.CollectInvoice(iInvoiceNumber: integer);
var
  ItemTypeInfo: TItemTypeInfo;
  i: integer;

  fWork: Double;
  fVat: Double;

  fItems: Double;
  FTotal: Double;
  fTotalVAT: Double;
  fTotalWOVat: Double;

  fItemTotal: Double;
  fItemTotalVAT: Double;
  fItemTotalWOVat: Double;

  iMultiplier: integer;

  iPersons: integer;
  iNights: integer;

  AMon: Word;
  ADay: Word;
  AYear: Word;

  s: string;
  sysline: boolean;

  _CurrencyValueSell: Double;

  sAccountKey: string;
  sItemID, sDescription: string;

  Refrence: string;
  Source: string;
  isPackage: boolean;
  sTmp: string;

  LineHolder: hData.recInvoiceLineHolder;

  confirmDate: TDateTime;
  Price, Total, confirmAmount: Double;

  ItemCount: Double; // -96

  iLineIndex, iOldLineIndex: integer;
  invoiceLine: TInvoiceLine;
  VATCode: String;

  found: boolean;

  lInvRoom: TInvoiceRoomEntity;
begin

  iMultiplier := 1;

  if FCredit then
  begin
    iMultiplier := -1;
  end;

  FTotal := 0.00;
  fTotalVAT := 0.00;
  fTotalWOVat := 0.00;

  iLineIndex := 0;
  for i := 1 to agrLines.RowCount - 1 do
  begin
    if ((trim(agrLines.Cells[col_Description, i]) = '') and
      (trim(agrLines.Cells[col_Item, i]) = '')) OR
      ((isSystemLine(i)) and (iInvoiceNumber <= 0)) then
      continue;

    iNights := 0;
    iPersons := 0;
    if agrLines.Cells[col_NoGuests, i] <> '' then
    begin
      iPersons := strToIntDef(agrLines.Cells[col_NoGuests, i], 0)
    end;

    ItemTypeInfo := d.Item_Get_ItemTypeInfo(agrLines.Cells[col_Item, i],
      agrLines.Cells[col_Source, i]);

    // --
    // RoomRentItem

    if (isSystemLine(i)) or (trim(g.qRoomRentItem) = agrLines.Cells[col_Item, i]
      ) or (trim(g.qDiscountItem) = agrLines.Cells[col_Item, i]) then
    begin
      // Setja dagsetningu á herbergisleigu
      // Dagsetning er í upphafi 0  31.12.1899
      // en er hér sett á dagsetningu prentunnar
      agrLines.Cells[col_date, i] := datetostr(trunc(now));
      agrLines.Objects[col_Description, i] := TObject(trunc(now));

      try
        fItemTotal := _CurrencyValueSell *
          _StrToFloat(agrLines.Cells[col_TotalPrice, i]);
      except
        fItemTotal := 0;
      end;

      if agrLines.Objects[col_ItemCount, i] <> nil then
      begin
        // iPersons := TRoomInfo(agrLines.Objects[col_ItemCount, i]).FNumPersons;
        iNights := trunc(TRoomInfo(agrLines.Objects[col_ItemCount, i]).FTo) -
          trunc(TRoomInfo(agrLines.Objects[col_ItemCount, i]).FFrom);
      end;

    end
    else
    begin
      try
        fItemTotal := _StrToFloat(agrLines.Cells[col_TotalPrice, i]);
      except
        fItemTotal := 0;
      end;
    end;

    Source := agrLines.Cells[col_Source, i];
    Refrence := agrLines.Cells[col_Refrence, i];

    sTmp := agrLines.Cells[col_confirmdate, i];
    if sTmp <> '' then
    begin
      confirmDate := _DBDateToDateTimeNoMs(sTmp);
    end
    else
      confirmDate := 2;

    confirmAmount := _StrToFloat(agrLines.Cells[col_confirmAmount, i]);

    isPackage := false;
    try
      sTmp := trim(agrLines.Cells[col_isPackage, i]);
      if sTmp = 'Yes' then
        isPackage := True;
    except
      // not raise
    end;

    // --
    lInvRoom := TInvoiceRoomEntity.create(agrLines.Cells[col_Item, i], 1, _StrToFloat(agrLines.Cells[col_ItemCount, i]), fItemTotal, 0, 0);
    try
      fVat := GetVATForItem(agrLines.Cells[col_Item, i], fItemTotal,
                            _StrToFloat(agrLines.Cells[col_ItemCount, i]), lInvRoom,
                            tempInvoiceItemList, ItemTypeInfo, edtCustomer.Text);
    finally
      lInvRoom.Free;
    end;

    if NOT(Item_GetKind(agrLines.Cells[col_Item, i]) IN [ikRoomRent,
      ikRoomRentDiscount]) then
      agrLines.Cells[col_Vat, i] := trim(_floattostr(fVat, vWidth, 3));
    // Formula
    // fWork := fItemTotal / (1 + (ItemTypeInfo.VATPercentage / 100));
    // fVat := fItemTotal - fWork;

    fItemTotalVAT := fVat;
    fItemTotalWOVat := fItemTotal - fItemTotalVAT;

    FTotal := FTotal + fItemTotal;
    fTotalVAT := fTotalVAT + fItemTotalVAT;
    fTotalWOVat := fTotalWOVat + fItemTotalWOVat;

    try
      decodedate(integer(agrLines.Objects[col_Description, i]), AYear, AMon, ADay);
    except
      decodedate(now, AYear, AMon, ADay);
    end;

    sTmp := agrLines.Cells[col_ItemCount, i];
    try
      ItemCount := _StrToFloat(sTmp);
    except
      ItemCount := 0;
    end;

    sItemID := agrLines.Cells[col_Item, i];

    if (isSystemLine(i)) or (trim(g.qRoomRentItem) = agrLines.Cells[col_Item, i]
      ) or (trim(g.qDiscountItem) = agrLines.Cells[col_Item, i]) then
      // -- Auto-Maintained lines are displayed in foreign currency...
      Price := iMultiplier * _CurrencyValueSell *
        _StrToFloat(agrLines.Cells[col_ItemPrice, i])
    else // -- ...The others are not...
      Price := iMultiplier * _StrToFloat(agrLines.Cells[col_ItemPrice, i]);

    VATCode := ItemTypeInfo.VATCode;

    if (isSystemLine(i)) or (trim(g.qRoomRentItem) = agrLines.Cells[col_Item, i]
      ) or (trim(g.qDiscountItem) = agrLines.Cells[col_Item, i]) then
      // -- Auto-Maintained lines are displayed in foreign currency...
      Total := iMultiplier * _CurrencyValueSell *
        _StrToFloat(agrLines.Cells[col_TotalPrice, i])
    else // -- ...The others are not...
      Total := iMultiplier * _StrToFloat(agrLines.Cells[col_TotalPrice, i]);

    sDescription := agrLines.Cells[col_Description, i];

    inc(iLineIndex);

    if Assigned(agrLines.Objects[col_ItemPrice, i]) AND
      (agrLines.Objects[col_ItemPrice, i] IS TInvoiceLine) then
    begin
      invoiceLine := TInvoiceLine(agrLines.Objects[col_ItemPrice, i]);
      iOldLineIndex := invoiceLine.itemIndex;
    end
    else
      iOldLineIndex := 0;
    if iOldLineIndex > 0 then
    begin
      MemData1.first;
      while NOT MemData1.eof do
      begin
        if MemData1['ItemNumber'] = iOldLineIndex then
          break;
        MemData1.Next;
      end;
      if NOT MemData1.eof then
      begin
        MemData1.edit;
        MemData1['InvoiceNumber'] := iInvoiceNumber;
        MemData1['Description'] := sDescription;
        MemData1['Number'] := ItemCount;
        MemData1['Price'] := Price;
        MemData1['Total'] := Total;
        MemData1['VATType'] := VATCode;
        MemData1['ItemNumber'] := iLineIndex;
        MemData1['ItemNumber'] := iLineIndex;
        MemData1['TotalWOVat'] := fItemTotalWOVat;
        MemData1['Vat'] := fItemTotalVAT;
        MemData1['AutoGenerated'] := false;
        MemData1['CurrencyRate'] := zCurrencyRate;
        MemData1['Currency'] := edtCurrency.Text;
        MemData1.post;
      end;
    end
    else
    begin
      MemData1.append;
      MemData1['id'] := 0;
      MemData1['Reservation'] := publicReservation;
      MemData1['RoomReservation'] := FRoomReservation;
      MemData1['SplitNumber'] := FnewSplitNumber;
      MemData1['InvoiceNumber'] := iInvoiceNumber;
      MemData1['PurchaseDate'] := dateToSqlString(now);
      // MemData1.FieldByName('PurchaseDate').AsDateTime := trunc(now);
      MemData1['AutoGen'] := _GetCurrentTick;

      MemData1['ItemId'] := sItemID;
      MemData1['Description'] := sDescription;
      MemData1['Number'] := ItemCount;
      MemData1['Price'] := Price;
      MemData1['Total'] := Total;
      MemData1['VATType'] := VATCode;
      MemData1['ItemNumber'] := iLineIndex;
      MemData1['TotalWOVat'] := fItemTotalWOVat;
      MemData1['Vat'] := fItemTotalVAT;
      MemData1['AutoGenerated'] := false;
      MemData1['CurrencyRate'] := zCurrencyRate;
      MemData1['Currency'] := edtCurrency.Text;
      MemData1['Persons'] := iPersons;
      MemData1['Nights'] := iNights;
      MemData1['AYear'] := AYear;
      MemData1['AMon'] := AMon;
      MemData1['ADay'] := ADay;

      MemData1['ilAccountKey'] := sAccountKey;
      MemData1['ImportRefrence'] := Refrence;
      MemData1['ImportSource'] := Source;
      MemData1['isPackage'] := isPackage;
      MemData1['confirmDate'] := confirmDate;
      MemData1['confirmAmount'] := confirmAmount;

      MemData1.post;
    end;

  end;

  d.BackupInvoiceLines(MemData1);
  d.BackupInvoiceHeader(MemData2);
end;

function TfrmInvoice.IsLineChanged(line, iMultiplier : Integer) : Boolean;
var InvoiceLine : TInvoiceLine;
begin
  result := False;
  InvoiceLine := CellInvoiceLine(line);
  if Assigned(InvoiceLine) then
    result := (InvoiceLine.Number<>_StrToFloat(agrLines.Cells[col_ItemCount, line])) OR
              (InvoiceLine.Price<>iMultiplier * _StrToFloat(agrLines.Cells[col_ItemPrice, line])) OR
              (InvoiceLine.Total<>iMultiplier * _StrToFloat(agrLines.Cells[col_TotalPrice, line]));
end;

function TfrmInvoice.SaveInvoice(iInvoiceNumber: integer): boolean;
var
  rSet: TRoomerDataset;
  ItemTypeInfo: TItemTypeInfo;
  i: integer;

  fWork: Double;
  fVat: Double;

  fItems: Double;
  FTotal: Double;
  fTotalVAT: Double;
  fTotalWOVat: Double;

  fItemTotal: Double;
  fItemTotalVAT: Double;
  fItemTotalWOVat: Double;

  iMultiplier: integer;

  iPersons: integer;
  iNights: integer;

  AMon: Word;
  ADay: Word;
  AYear: Word;

  s: string;

  sysline: boolean;

  _CurrencyValueSell: Double;

  sAccountKey: string;
  sItemID: string;

  Refrence: string;
  Source: string;
  isPackage: boolean;
  sTmp: string;

  lExecutionPlan: TRoomerExecutionPlan;
  LineHolder: hData.recInvoiceLineHolder;

  confirmDate: TDateTime;
  confirmAmount: Double;

  ItemCount: Double; // -96

  sRRAlias: string;
  irrAlias: integer;

  aItem: string;
  AutoGen: string;

  ItemPrice: Double;
  lInvRoom: TInvoiceRoomEntity;

  InvoiceLine : TInvoiceLine;

begin

  _CurrencyValueSell := zCurrencyRate;


  result := True;

    lExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
    try
      DeleteLinesInList(lExecutionPlan);

//      s := '';
//      s := s + 'DELETE FROM invoicelines ' + #10;
//      s := s + ' where Reservation = ' + _db(publicReservation);
//      s := s + '   and RoomReservation = ' + _db(FRoomReservation);
//      s := s + '   and SplitNumber = ' + _db(FnewSplitNumber);
//      s := s + '   and InvoiceIndex = ' + _db(FInvoiceIndex);
//      s := s + '   and InvoiceNumber = -1 ' + #10;
//      lExecutionPlan.AddExec(s);

      s := '';
      s := s + 'DELETE FROM invoiceheads ' + #10;
      s := s + ' where Reservation = ' + inttostr(publicReservation);
      s := s + '   and RoomReservation = ' + inttostr(FRoomReservation);
      s := s + '   and SplitNumber = ' + inttostr(FnewSplitNumber);
      s := s + '   and InvoiceNumber = -1' + #10;
      lExecutionPlan.AddExec(s);

      try
        // --
        iMultiplier := 1;

        if FCredit then
        begin
          iMultiplier := -1;
        end;

        fItems := 0.00;
        FTotal := 0.00;
        fTotalVAT := 0.00;
        fTotalWOVat := 0.00;

        for i := 1 to agrLines.RowCount - 1 do
        begin
          aItem := trim(agrLines.Cells[col_Item, i]);
          // debugmessage(aItem+'/'+booltostr(isSystemLine(i)));
          // -- is this an empty line ?
          if (trim(agrLines.Cells[col_Description, i]) = '') and (aItem = '')
          then
          begin
            continue;
          end;

          iNights := 0;
          iPersons := 0;
          if agrLines.Cells[col_NoGuests, i] <> '' then
          begin
            iPersons := strToInt(agrLines.Cells[col_NoGuests, i])
          end;

          // -- is this an Automatically maintained line ?
          // og þess vegna ekki vistuð í invoicelines

          if (isSystemLine(i)) and (iInvoiceNumber <= 0) and
            (aItem <> g.qBreakFastItem) then
          begin
            continue;
          end;

          ItemTypeInfo := d.Item_Get_ItemTypeInfo(agrLines.Cells[col_Item, i],
            agrLines.Cells[col_Source, i]);

          // --
          // RoomRentItem

          if ((isSystemLine(i)) and (aItem <> g.qBreakFastItem)) or
            (trim(g.qRoomRentItem) = agrLines.Cells[col_Item, i]) or
            (trim(g.qDiscountItem) = agrLines.Cells[col_Item, i]) then
          begin
            // Setja dagsetningu á herbergisleigu
            // Dagsetning er í upphafi 0  31.12.1899
            // en er hér sett á dagsetningu prentunnar
            agrLines.Cells[col_date, i] := datetostr(trunc(now));
            agrLines.Objects[col_Description, i] := TObject(trunc(now));

            try
              fItemTotal := _CurrencyValueSell *
                _StrToFloat(agrLines.Cells[col_TotalPrice, i]);
            except
              fItemTotal := 0;
            end;

            if agrLines.Objects[col_ItemCount, i] <> nil then
            begin
              // iPersons := TRoomInfo(agrLines.Objects[col_ItemCount, i]).FNumPersons;
              iNights := trunc(TRoomInfo(agrLines.Objects[col_ItemCount, i]).FTo) -
                trunc(TRoomInfo(agrLines.Objects[col_ItemCount, i]).FFrom);
            end;

          end
          else
          begin
            try
              fItemTotal := _StrToFloat(agrLines.Cells[col_TotalPrice, i]);
            except
              fItemTotal := 0;
            end;
          end;

          Source := agrLines.Cells[col_Source, i];
          Refrence := agrLines.Cells[col_Refrence, i];

          sTmp := agrLines.Cells[col_confirmdate, i];
          if sTmp <> '' then
          begin
            confirmDate := _DBDateToDateTimeNoMs(sTmp);
          end
          else
            confirmDate := 2;

          confirmAmount := _StrToFloat(agrLines.Cells[col_confirmAmount, i]);

          isPackage := false;
          try
            sTmp := trim(agrLines.Cells[col_isPackage, i]);
            if sTmp = 'Yes' then
              isPackage := True;
          except
            // not raise
          end;

          // --
          lInvRoom := TInvoiceRoomEntity.create(agrLines.Cells[col_Item, i], 1,
                                                _StrToFloat(agrLines.Cells[col_ItemCount, i]), fItemTotal, 0, 0);
          try
            fVat := GetVATForItem(agrLines.Cells[col_Item, i], fItemTotal,
                                  _StrToFloat(agrLines.Cells[col_ItemCount, i]), lInvRoom,
                                  tempInvoiceItemList, ItemTypeInfo, edtCustomer.Text);
          finally
            lInvRoom.Free;
          end;

          if NOT(Item_GetKind(agrLines.Cells[col_Item, i]) IN [ikRoomRent,
            ikRoomRentDiscount]) then
            agrLines.Cells[col_Vat, i] := trim(_floattostr(fVat, vWidth, 3));
          // Formula
          // fWork := fItemTotal / (1 + (ItemTypeInfo.VATPercentage / 100));
          // fVat := fItemTotal - fWork;

          fItemTotalVAT := fVat;
          fItemTotalWOVat := fItemTotal - fItemTotalVAT;

          FTotal := FTotal + fItemTotal;
          fTotalVAT := fTotalVAT + fItemTotalVAT;
          fTotalWOVat := fTotalWOVat + fItemTotalWOVat;

          try
            decodedate(integer(agrLines.Objects[col_Description, i]), AYear, AMon, ADay);
          except
            decodedate(now, AYear, AMon, ADay);
          end;

          sTmp := agrLines.Cells[col_ItemCount, i];
          try
            ItemCount := _StrToFloat(sTmp);
          except
            ItemCount := 0;
          end;

          sRRAlias := trim(agrLines.Cells[col_rrAlias, i]);
          irrAlias := -1;
          try
            if sRRAlias <> '' then
              irrAlias := strToInt(sRRAlias);
          Except
          end;

          AutoGen := trim(agrLines.Cells[col_autogen, i]);
          if AutoGen = '' then
          begin
            AutoGen := _GetCurrentTick;
          end;

          sItemID := agrLines.Cells[col_Item, i];
          sAccountKey := d.Item_Get_AccountKey(sItemID);

          InvoiceLine := CellInvoiceLine(i);
          if (NOT Assigned(InvoiceLine)) OR (InvoiceLine.FId < 1) then
          begin

            // SQL 116 INSERxT Invoicelines
            s := '';
            s := s + 'INSERT into invoicelines' + #10;
            s := s + '(' + #10;
            s := s + '  ' + 'Reservation ' + #10;
            s := s + ', ' + 'AutoGen ' + #10;
            s := s + ', ' + 'RoomReservation ' + #10;
            s := s + ', ' + 'SplitNumber ' + #10;
            s := s + ', ' + 'ItemNumber ' + #10;
            s := s + ', ' + 'PurchaseDate ' + #10;
            s := s + ', ' + 'InvoiceNumber ' + #10;
            s := s + ', ' + 'ItemId ' + #10;
            s := s + ', ' + 'Number ' + #10;
            s := s + ', ' + 'Description ' + #10;
            s := s + ', ' + 'Price ' + #10;
            s := s + ', ' + 'VATType ' + #10;
            s := s + ', ' + 'Total ' + #10;
            s := s + ', ' + 'TotalWOVat ' + #10;
            s := s + ', ' + 'VAT ' + #10;
            s := s + ', ' + 'CurrencyRate ' + #10;
            s := s + ', ' + 'Currency ' + #10;
            s := s + ', ' + 'Persons ' + #10;
            s := s + ', ' + 'Nights ' + #10;
            s := s + ', ' + 'BreakfastPrice ' + #10;
            s := s + ', ' + 'AutoGenerated ' + #10;
            s := s + ', ' + 'AYear ' + #10;
            s := s + ', ' + 'AMon ' + #10;
            s := s + ', ' + 'ADay ' + #10;
            s := s + ', ' + 'ilAccountKey ' + #10;
            s := s + ', ' + 'importRefrence ' + #10;
            s := s + ', ' + 'importSource ' + #10;
            s := s + ', ' + 'isPackage ' + #10;
            s := s + ', ' + 'confirmDate ' + #10;
            s := s + ', ' + 'confirmAmount ' + #10;
            s := s + ', ' + 'RoomReservationAlias ' + #10;
            s := s + ', ' + 'InvoiceIndex ' + #10;
            s := s + ', ' + 'staffCreated ' + #10;
            s := s + ')' + #10;
            s := s + 'Values' + #10;
            s := s + '(' + #10;
            s := s + '  ' + inttostr(publicReservation);
            s := s + ', ' + _db(AutoGen);
            s := s + ', ' + inttostr(FRoomReservation);
            s := s + ', ' + inttostr(FnewSplitNumber);
            s := s + ', ' + inttostr(i);
            s := s + ', ' + _DateToDbDate(integer(agrLines.Objects[col_Description, i]), True);
            s := s + ', ' + inttostr(iInvoiceNumber);
            s := s + ', ' + _db(sItemID);
            s := s + ', ' + _db(ItemCount); // -96ath
            s := s + ', ' + _db(agrLines.Cells[col_Description, i]);

            if ((isSystemLine(i)) and (aItem <> g.qBreakFastItem)) or
              (trim(g.qRoomRentItem) = agrLines.Cells[col_Item, i]) or
              (trim(g.qDiscountItem) = agrLines.Cells[col_Item, i]) then
              // -- Auto-Maintained lines are displayed in foreign currency...
              s := s + ', ' + _CommaToDot
                (floattostr(iMultiplier * _CurrencyValueSell *
                _StrToFloat(agrLines.Cells[col_ItemPrice, i])))
            else // -- ...The others are not...
              s := s + ', ' + _CommaToDot(floattostr(iMultiplier * _StrToFloat(agrLines.Cells[col_ItemPrice, i])));

            s := s + ', ' + _db(ItemTypeInfo.VATCode);

            if ((isSystemLine(i)) and (aItem <> g.qBreakFastItem)) or
              (trim(g.qRoomRentItem) = agrLines.Cells[col_Item, i]) or
              (trim(g.qDiscountItem) = agrLines.Cells[col_Item, i]) then
              // -- Auto-Maintained lines are displayed in foreign currency...
              s := s + ', ' + _CommaToDot(floattostr(iMultiplier * _CurrencyValueSell * _StrToFloat(agrLines.Cells[col_TotalPrice, i])))
            else // -- ...The others are not...
              s := s + ', ' + _CommaToDot(floattostr(iMultiplier * _StrToFloat(agrLines.Cells[col_TotalPrice, i])));

            s := s + ', ' + _CommaToDot(floattostr(iMultiplier * fItemTotalWOVat));
            s := s + ', ' + _CommaToDot(floattostr(iMultiplier * fItemTotalVAT));
            s := s + ', ' + _CommaToDot(floattostr(zCurrencyRate));
            s := s + ', ' + _db(edtCurrency.Text);
            s := s + ', ' + inttostr(iPersons);
            s := s + ', ' + inttostr(iNights);
            s := s + ', ' + _CommaToDot(floattostr(0.00));
            s := s + ', ' + _db(false);

            s := s + ', ' + inttostr(AYear);
            s := s + ', ' + inttostr(AMon);
            s := s + ', ' + inttostr(ADay);

            s := s + ', ' + _db(sAccountKey);
            s := s + ', ' + _db(Refrence);
            s := s + ', ' + _db(Source);
            s := s + ', ' + _db(isPackage);
            s := s + ', ' + _dbDateAndTime(confirmDate);
            s := s + ', ' + _db(confirmAmount);
            s := s + ', ' + _db(irrAlias);
            s := s + ', ' + _db(FInvoiceIndex);
            s := s + ', ' + _db(d.roomerMainDataSet.username);

            s := s + ')' + #10;
          end else
          begin
            if NOT IsLineChanged(i, iMultiplier) then
              Continue;

            s := 'UPDATE invoicelines' +
                 ' Set ItemNumber= ' + _db(i) +
                 ' , InvoiceNumber= ' + _db(iInvoiceNumber) +
                 ' , Number= ' + _db(ItemCount) +
                 ' , Price= ' + _CommaToDot(floattostr(iMultiplier * _StrToFloat(agrLines.Cells[col_ItemPrice, i]))) +
                 ' , Total= ' + _CommaToDot(floattostr(iMultiplier * _StrToFloat(agrLines.Cells[col_TotalPrice, i]))) +
                 ' , TotalWOVat= ' + _CommaToDot(floattostr(iMultiplier * fItemTotalWOVat)) +
                 ' , VAT= ' + _CommaToDot(floattostr(iMultiplier * fItemTotalVAT)) +
                 ' , CurrencyRate= ' + _CommaToDot(floattostr(zCurrencyRate)) +
                 ' , Currency= ' + _db(edtCurrency.Text) +
                 ' , Persons= ' + inttostr(iPersons) +
                 ' , Nights= ' + inttostr(iNights) +
                 ' , ilAccountKey= ' + _db(sAccountKey) +
                 ' , InvoiceIndex= ' + _db(FInvoiceIndex) +
                 ' , staffLastEdit= ' + _db(d.roomerMainDataSet.username) +
                 ' WHERE id=' + _db(InvoiceLine.FId);
          end;

          lExecutionPlan.AddExec(s);

          copytoclipboard(s);
//          debugmessage(s);

        end;

        SaveHeader(FTotal, fTotalVAT, fTotalWOVat, lExecutionPlan);

        if NOT lExecutionPlan.Execute(ptExec, True) then
          raise Exception.create(lExecutionPlan.ExecException);

        zInitString := createAllStr;
        zDataChanged := chkChanged;

      except
        on e: Exception do
        begin
          frmdayNotes.xDoLog('SaveInvoice 1000', e.message);
          // MessageDlg('Problem: Unable to save the invoice !' + #13#13 + 'While saving invoice The following Error came up:' + #13#13 +
          // e.message + #13#13 + 'Please write this message down or' + #13 + 'call support with this dialog open!', mtError, [mbOK], 0);
          MessageDlg
            (format(GetTranslatedText
            ('shTx_Invoice_UnableToSaveInvoiceMessage'), [e.message]), mtError,
            [mbOk], 0);
          result := false;
          raise;
        end;
      end;

    finally
      FreeAndNil(lExecutionPlan);
    end;

    if not zApply then
    begin
      if d.mInvoicelines_after.active then
        d.mInvoicelines_after.close;
      d.mInvoicelines_after.Open;

      rSet := CreateNewDataSet;
      try
        Screen.Cursor := crHourglass;
        try
          s := 'SELECT * FROM invoicelines' + ' where Reservation = %d ' +
            '   and RoomReservation = %d ' + '   and SplitNumber = %d ' +
            '   and InvoiceNumber = -1 AND InvoiceIndex=%d';

          s := format(s, [publicReservation, FRoomReservation, FnewSplitNumber,
            FInvoiceIndex]);

          hData.rSet_bySQL(rSet, s);
          if not rSet.eof then
          begin
            d.mInvoicelines_after.LoadFromDataSet(rSet, []);
          end;

        finally
          Screen.Cursor := crDefault;
        end;
      finally
        FreeAndNil(rSet);
      end;
      loadInvoiceToMemtable(d.mInvoicelines_after);
    end;
    zApply := false;

    d.addInvoiceLinesTmp(i, publicReservation);

  // NO REFRESH  frmMain.RefreshGrid;
end;

procedure TfrmInvoice.edtCustomerChange(Sender: TObject);
var
  customer: string;

begin
  customer := trim(edtCustomer.Text);
  try
    if NOT glb.LocateSpecificRecordAndGetValue('customers', 'Customer',
      customer, 'StayTaxIncluted', zStayTaxIncluded) then
      zStayTaxIncluded := ctrlGetBoolean('StayTaxIncluted');
  except
    zStayTaxIncluded := ctrlGetBoolean('StayTaxIncluted');
  end;
end;

procedure TfrmInvoice.edtCustomerDblClick(Sender: TObject);
var
  CustomerHolder: recCustomerHolder;
  CustomerHolderEX: recCustomerHolderEX;

  tmp: boolean;
begin

  tmp := zStayTaxIncluded;
  CustomerHolder.customer := edtCustomer.Text;
  if openCustomers(actLookup, True, CustomerHolder) then
  begin
    edtCustomer.Text := CustomerHolder.customer;
    CustomerHolderEX := hData.Customer_GetHolder(CustomerHolder.customer);
    edtName.Text := InvoiceName(0, CustomerHolderEX.DisplayName,
      CustomerHolderEX.CustomerName);
    edtPersonalId.Text := CustomerHolderEX.PID;
    edtAddress1.Text := CustomerHolderEX.Address1;
    edtAddress2.Text := CustomerHolderEX.Address2;
    edtAddress3.Text := CustomerHolderEX.Address3;
    edtAddress4.Text := CustomerHolderEX.Address4;
    zCountry := CustomerHolderEX.Country;
    if zStayTaxIncluded <> tmp then
      calcStayTax(publicReservation);
  end;
end;

procedure TfrmInvoice.agrLinesGetAlignment(Sender: TObject; ARow, ACol: integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  case ACol of
    col_Item:
      HAlign := taLeftJustify; // -96
    col_Description:
      HAlign := taLeftJustify; // -96
    col_ItemCount:
      HAlign := taRightJustify; // -96
    col_ItemPrice:
      HAlign := taRightJustify; // -96
    col_TotalPrice:
      HAlign := taRightJustify; // -96
    col_System:
      HAlign := taLeftJustify; // -96
    col_date:
      HAlign := taLeftJustify; // -96
    col_Refrence:
      HAlign := taLeftJustify; // -96
    col_Source:
      HAlign := taLeftJustify; // -96
    col_isPackage:
      HAlign := taLeftJustify; // -96
    col_NoGuests:
      HAlign := taLeftJustify; // -96
    col_confirmdate:
      HAlign := taLeftJustify; // -96
    col_confirmAmount:
      HAlign := taRightJustify; // -96
  end;
end;

procedure TfrmInvoice.agrLinesGetCellColor(Sender: TObject; ARow, ACol: integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if ARow = 0 then
  begin
    AFont.Color := frmMain.sSkinManager1.GetGlobalFontColor;
  end
  else if (gdSelected IN AState) OR (gdRowSelected IN AState) then
  begin
    ABrush.Color := frmMain.sSkinManager1.GetActiveEditFontColor;
    AFont.Color := frmMain.sSkinManager1.GetActiveEditColor;
  end
  else
  begin
    ABrush.Color := frmMain.sSkinManager1.GetActiveEditColor;
    AFont.Color := frmMain.sSkinManager1.GetActiveEditFontColor;
  end;
end;

procedure TfrmInvoice.agrLinesGetEditText(Sender: TObject; ACol, ARow: integer;
  var Value: string);
begin
  zCellValue := agrLines.Cells[ACol, ARow];
end;

procedure TfrmInvoice.itemLookup;
var
  s: string;
  Description: string;
  Currency: string;

  ItemKind: TItemKind;

  // tmpRoomReservation : integer;
  // iDiscountType   : integer;
  // dDiscountAmount : double;
  // i : integer;
  //

  theData: TrecItemHolderList;
  rec: TrecItemHolder;

  VATCode, ItemType, Item: string;
  i: integer;
  bAdded: boolean;

  dNumber : Double;

begin
  if agrLines.Col <> 0 then
    exit;

  Currency := '';
  bAdded := false;
  Item := agrLines.Cells[col_Item, agrLines.row];
  // theData.Item := Item;

  theData := TrecItemHolderList.create(True);
  try
    rec := TrecItemHolder.create;
    rec.recHolder.Item := Item;
    theData.add(rec);
    if openMultipleItems(actLookup, True, theData) AND (theData.Count > 0) then
    begin
      if theData[0].recHolder.Item <> Item then // New item
      begin
        for i := 0 to theData.Count - 1 do
        begin
          ItemKind := Item_GetKind(theData[i].recHolder.Item);

          if ItemKind = ikPayment then
          begin
            // MessageDlg('You are not allowed to use the System''s Payment code directly', mtError, [mbOK], 0);
            MessageDlg(GetTranslatedText('shTx_Invoice_NotAllowed'), mtError,
              [mbOk], 0);
            exit;
          end
          else if glb.LocateSpecificRecordAndGetValue('items', 'Item',
            theData[i].recHolder.Item, 'Itemtype', ItemType) AND
            glb.LocateSpecificRecordAndGetValue('itemtypes', 'ItemType',
            ItemType, 'VATCode', VATCode) then
          begin
            if glb.LocateSpecificRecord('vatcodes', 'VATCode', VATCode) then
            begin
              agrLines.Cells[col_Item, agrLines.row] :=
                theData[i].recHolder.Item;
              agrLines.Cells[col_Description, agrLines.row] :=
                trim(theData[i].recHolder.Description);
              dNumber := GetCalculatedNumberOfItems(theData[i].recHolder.Item, 1.0);

              agrLines.Objects[col_Item, agrLines.row] := nil;

              agrLines.Cells[col_ItemCount, agrLines.row] :=
                _floattostr(1, vWidth, vDec);
              agrLines.Cells[col_ItemPrice, agrLines.row] :=
                _floattostr(theData[i].recHolder.Price, vWidth, vDec);

              agrLines.Cells[col_autogen, agrLines.row] := _GetCurrentTick;

              if NOT CheckIfWithdrawlAllowed_X(false,
                floattostr(theData[i].recHolder.Price)) then
              begin
                agrLines.RemoveRows(agrLines.row, 1);
                AddEmptyLine1;
                DisplayTotals;
                exit;
              end;

              zCellEdited := True;
              zRow := agrLines.row;
              zCol := agrLines.Col;

              zDataChanged := chkChanged;
              AddEmptyLine1;
              postMessage(handle, WM_FORMAT_LINE, 0, agrLines.row);
              agrLines.Col := agrLines.Col + 1;
              bAdded := True;
              agrLines.row := agrLines.row + 1;
            end
            else
            begin
              MessageDlg
                (format(GetTranslatedText
                ('shTx_uInvoice_ItemTypeWithIncorrectVAT'), [ItemType, VATCode]
                ), mtError, [mbOk], 0);
            end;
          end
          else
          begin
            MessageDlg
              (format(GetTranslatedText
              ('shTx_uInvoice_ItemWithIncorrectItemType'),
              [theData[i].recHolder.Item, ItemType]), mtError, [mbOk], 0);
          end;
        end;
      end;
    end;
  finally
    theData.free;
  end;
  if bAdded then
    agrLines.row := agrLines.RowCount - 1;
  setControls;
end;

procedure TfrmInvoice.agrLinesCanEditCell(Sender: TObject; ARow, ACol: integer;
  var CanEdit: boolean);
begin
  CanEdit := (NOT(ACol IN [col_Item, col_TotalPrice, col_System, col_date,
    col_Refrence, col_Source, col_isPackage, col_NoGuests, col_confirmdate,
    col_confirmAmount]))
  // AND (
  // isSystemLine(ARow) OR (agrLines.Cells[col_Item, ARow] <> g.qRoomRentItem) OR
  // (ACol IN [col_Description, col_ItemCount]))
    AND (TaxTypes.IndexOf(agrLines.Cells[col_Item, ARow]) < 0)
    AND ((glb.GetNumberBaseOfItem(agrLines.Cells[col_Item, ARow]) = INB_USER_EDIT) OR (ACol IN [col_ItemPrice, col_Description]));
  // AND ((ACol=COL_DESCRIPTION) OR (NOT isSystemLine(agrLines.row)));
end;

function TfrmInvoice.CheckIfWithdrawlAllowed_X(Editing: boolean;
  Value: String): boolean;
var
  currValue: Double;
  Amount: Double;
begin
  result := True;
  if FCredit then
    exit;

  Amount := GridFloatValueFromString(Value);

  if Editing then
  begin
    DisplayTotals(agrLines.Col, agrLines.row, Amount)
  end
  else
  begin
    DisplayTotals(col_ItemPrice, agrLines.row, Amount);
  end;

  currValue := GridFloatValueFromString(edtBalance.Text);

  if (FRoomReservation > 0) AND
    (NOT d.roomerMainDataSet.SystemIsRoomWithdrawalAllowed(FRoomReservation,
    currValue - OriginalInvoiceStatus)) then
  begin
    MessageDlg(GetTranslatedText('shUI_AmountOverAllowedWithdrawalLimit'),
      mtWarning, [mbOk], 0);
    result := false;
  end;
end;

procedure TfrmInvoice.FormatCurrentLine(ARow: integer);
begin
  agrLines.Cells[col_ItemPrice, ARow] :=
    _floattostr(GridCellfloatValue(agrLines, col_ItemPrice, ARow),
    vWidth, vDec);
  agrLines.Cells[col_ItemCount, ARow] :=
    _floattostr(GridCellfloatValue(agrLines, col_ItemCount, ARow), vWidth,
    vDec); // -96
  agrLines.Cells[col_TotalPrice, ARow] :=
    _floattostr(GridCellfloatValue(agrLines, col_ItemPrice, ARow) *
    GridCellfloatValue(agrLines, col_ItemCount, ARow), vWidth, vDec); // -96
end;

procedure TfrmInvoice.WndProc(var message: TMessage);
begin
  if Message.msg = WM_FORMAT_LINE then
  begin
    FormatCurrentLine(Message.LParam);
    DisplayTotals;
  end;
  inherited WndProc(message);
end;

procedure TfrmInvoice.agrLinesCellValidate(Sender: TObject; ACol, ARow: integer;
  var Value: string; var Valid: boolean);
var
  sItemName: string;
  dItemPrice: Double;

  sTmp: string;
  iTmp: integer;
begin
  Valid := True;
  case zCol of
    - 1:
      ; // Do nothing...
    col_Item:
      begin
        zDataChanged := chkChanged;

        begin
          if agrLines.Cells[col_Item, zRow] = trim(g.qPaymentItem) then
          begin
            // MessageDlg('You are not allowed to use the System''s Payment code directly', mtError, [mbOK], 0);
            MessageDlg(GetTranslatedText('shTx_Invoice_NotAllowed'), mtError,
              [mbOk], 0);
            Valid := false;
            exit;
          end;

          iTmp := zRow;
          sTmp := agrLines.Cells[col_Item, zRow];
          sItemName := Item_GetDescription(sTmp);
          sItemName := trim(sItemName);
          dItemPrice := Item_GetPrice(agrLines.Cells[col_Item, zRow]);
          agrLines.Cells[col_ItemPrice, zRow] :=
            _floattostr(dItemPrice, vWidth, vDec);

          if NOT CheckIfWithdrawlAllowed_X(false, floattostr(dItemPrice)) then
          begin
            Valid := false;
            exit;
          end;

          if sItemName = '' then
          begin
            zRow := iTmp;
            agrLines.Cells[col_Item, iTmp] := zCellValue;
            agrLines.Col := 0;
            agrLines.row := iTmp;
            exit;
          end;

          if GridCellfloatValue(agrLines, col_ItemCount, zRow) = 0 then
            agrLines.Cells[col_ItemCount, zRow] := _floattostr(1, vWidth, vDec);
          // -96

          agrLines.Cells[col_Description, agrLines.row] := sItemName;
          agrLines.Cells[agrLines.Col + 5, zRow] := '';
          CheckRoomRentItem(zRow);
          agrLines.row := zRow - 1;
          agrLines.Col := 2;
          AddEmptyLine;
          postMessage(handle, WM_FORMAT_LINE, 0, agrLines.row);
        end;
      end;
    col_Description:
      ;

    col_ItemCount:
      begin
        if agrLines.Cells[col_Item, zRow] = '' then
        begin
          agrLines.Cells[col_ItemCount, zRow] := '';
          agrLines.Cells[col_ItemPrice, zRow] := '';
          agrLines.Cells[col_TotalPrice, zRow] := '';
          agrLines.Cells[col_System, zRow] := '';
        end
        else
        begin
          zDataChanged := chkChanged;

          if NOT CheckIfWithdrawlAllowed_X(True, Value) then
          begin
            Valid := false;
            exit;
          end;

          agrLines.Cells[col_System, zRow] := '';
          postMessage(handle, WM_FORMAT_LINE, 0, agrLines.row);
        end;
      end;
    col_ItemPrice:
      begin
        if agrLines.Cells[col_Item, zRow] = '' then
        begin
          agrLines.Cells[col_ItemCount, zRow] := '';
          agrLines.Cells[col_ItemPrice, zRow] := '';
          agrLines.Cells[col_TotalPrice, zRow] := '';
          agrLines.Cells[col_System, zRow] := '';
        end
        else
        begin
          zDataChanged := chkChanged;

          if NOT CheckIfWithdrawlAllowed_X(True, Value) then
          begin
            Valid := false;
            exit;
          end;

          agrLines.Cells[col_System, zRow] := '';
          postMessage(handle, WM_FORMAT_LINE, 0, agrLines.row);
        end;
      end;
  end;

  if zCol in [col_Item, col_ItemCount, col_ItemPrice] then
  begin
    calcStayTax(publicReservation); // 003
  end;
end;

procedure TfrmInvoice.agrLinesCheckBoxClick(Sender: TObject; ACol, ARow: Integer; State: Boolean);
var check : Boolean;
begin
  if ARow = 0 then
  begin
    agrLines.GetCheckBoxState(col_Select, ARow, check);
    CheckOrUncheckAll(check);
  end;

  AnyRowChecked := IsAnyCheckboxChecked;
  agrLinesRowChanging(agrLines, agrLines.Row, agrLines.Row, check);
end;

function TfrmInvoice.IsAnyCheckboxChecked : Boolean;
var i : Integer;
begin
  result := False;
  for i := 1 to agrLines.RowCount - 1 do
    if agrLines.HasCheckbox(col_Select, i) then
    begin
      agrLines.GetCheckBoxState(col_Select, i, result);
      if result then
        Break;
    end;
end;

procedure TfrmInvoice.agrLinesColumnSize(Sender: TObject; ACol: integer;
  var Allow: boolean);
begin

  if ACol = col_ItemCount then
  begin
    if agrLines.ColWidths[col_ItemCount] < 100 then
      agrLines.ColWidths[col_ItemCount] := 100; // -96
  end;

  if ACol = col_ItemPrice then
  begin
    if agrLines.ColWidths[col_ItemPrice] < 100 then
      agrLines.ColWidths[col_ItemPrice] := 100; // -96
  end;

  if ACol = col_TotalPrice then
  begin
    if agrLines.ColWidths[col_TotalPrice] < 100 then
      agrLines.ColWidths[col_TotalPrice] := 100; // -96
  end;

  // agrLines.Update;agrLines.Invalidate;
end;

procedure TfrmInvoice.agrLinesDblClickCell(Sender: TObject;
  ARow, ACol: integer);
begin
  if ACol <> col_Item then
    exit;
  if agrLines.Cells[ACol, ARow] <> '' then
    exit;
  itemLookup;
end;

function TfrmInvoice.GatherPayments(PayLines: TStringList;
  var days: integer): Double;
var
  tt: Double;
  i: integer;
  pmCode: string;
  pmAmount: Double;
  sTmp: string;
  iTmp: integer;

begin
  tt := 0;
  days := 0;
  iTmp := 0;

  for i := 0 to PayLines.Count - 1 do
  begin
    pmCode := trim(_strTokenAt(PayLines[i], '|', 0));
    sTmp := trim(_strTokenAt(PayLines[i], '|', 1));

    try
      { TODO -oHordur -cOther : Afhverju er þetta kommentað út }
      // ATHOLD payTypes      iTmp := d.GET_PaytypeDays_byPaytype(pmCode);
      if iTmp > days then
        days := iTmp;
    except
    end;

    try
      pmAmount := _StrToFloat(sTmp);
    except
      pmAmount := 0;
    end;
    if (pmCode <> '') and (pmAmount <> 0) then
    begin
      tt := tt + pmAmount;
      // AddPayment(pmCode,pmAmount)
    end;
  end;
  result := tt;
end;

function TfrmInvoice.GetInvoiceTotal: Double;
var
  i: integer;
  dTotal: Double;
  dTmp: Double;
begin
  result := 0;
  dTotal := 0;
  for i := 1 to agrLines.RowCount - 1 do
  begin
    if not edtForeignCurrency.visible or
      (trim(g.qRoomRentItem) = agrLines.Cells[col_Item, i]) or
      (trim(g.qDiscountItem) = agrLines.Cells[col_Item, i]) then
    begin
      dTotal := dTotal + _StrToFloat(agrLines.Cells[col_TotalPrice, i]);
    end
    else
    begin
      dTmp := _StrToFloat(agrLines.Cells[col_TotalPrice, i]) / zCurrencyRate;
      dTotal := dTotal + dTmp;
    end;
  end;
end;

function TfrmInvoice.PayInvoiceAndPrint: boolean;
var
  ItemTypeInfo: TItemTypeInfo;

  mResult: TModalResult;
  TotalPayments: Double;
  iTmp: integer;
  okSavePayment: boolean;
  okSaveInvoice: boolean;
  pmStr: string;
  days: integer;

  NumOk: boolean;

  isNewInvoice: boolean;

  AllOk: boolean;

  s: string;
  i: integer;

  _CurrencyValueSell: Double;

  iMultiplier: integer;

  iPersons: integer;
  iNights: integer;

  AMon: Word;
  ADay: Word;
  AYear: Word;

  fItems: Double;
  FTotal: Double;
  fTotalVAT: Double;
  fTotalWOVat: Double;

  sItemID: string;
  sAccountKey: string;
  sDescription: string;

  sRefrence: string;
  sSource: string;

  ct: string;
  sTmp, sTmp2: string;

  PaymentDescription: string;
  PaymentType: TPaymentTypes;

  dTmp: Double;

  sLinePrice: string;
  dLinePrice: Double;

  sLineTotal: string;
  dLineTotal: Double;

  sLineVAT: String;
  dLineVAT: Double;

  sLineTotalWOVat: String;
  dLineTotalWOVat: Double;

  dTotalStayTax: Double;
  iTotalStayTaxNights: integer;

  isConnected: boolean;
  isPackage: boolean;

  RoomRentPaid: boolean;
  invRoomReservation: integer;

  doRestore: boolean;

  lExecutionPlan: TRoomerExecutionPlan;

  confirmDate: TDateTime;
  confirmAmount: Double;

  ItemCount: Double; // -96

  remoteResult: String;

  theData: recPaymentHolder;

  dNumItems: Double;
  sRRAlias: string;
  irrAlias: integer;

  lstLocations: TStringList;
  lstActivity: TStringList;

  paymentValue: Double;
  paymentCode: string;
  paymentStr: string;

  lInvRoom: TInvoiceRoomEntity;

  InvoiceLine : TInvoiceLine;

Label TryAgain;
begin
  // ILTMP

  // Þegar hér er komið þá er reikningsnúmerið
  // alltaf -1 nema þegar um kreditreikning er að ræða

  result := false;
  iTmp := zInvoiceNumber;
  isNewInvoice := iTmp = -1;

  days := 0;

  AllOk := True;

  zInvoiceDate := trunc(now);
  zPayDate := zInvoiceDate;
  zConfirmDate := 2;

  lstActivity := TStringList.create;
  lstLocations := TStringList.create;
  try

    if FRoomReservation = 0 then
    begin
      d.GetReservationLocations(publicReservation, lstLocations);
    end
    else
    begin
      d.GetRoomReservationLocations(FRoomReservation, lstLocations);
    end;

    if agrLines.Cells[col_Item, 1] = '' then
      raise Exception.create('No items on invoice');

    if (zInvoiceNumber = -1) or (FnewSplitNumber = 1) then
    begin
      if not SelectPaymentTypes(_StrToFloat(edtBalance.Text), edtCustomer.Text,
        ptInvoice, lstLocations, zInvoiceDate, zPayDate, zLocation) then
      begin
        exit;
      end;
      TotalPayments := GatherPayments(stlPaySelections, days);

      if round(TotalPayments) <> round(_StrToFloat(edtBalance.Text)) then
      begin
        // raise Exception.create('Payment need to total to the same amount as the total invoice');
        raise Exception.create
          (GetTranslatedText('shTx_Invoice_PaymentTotalInvoice'));
      end;

      zInvoiceNumber := IVH_SetNewID();
      okSavePayment := false;
      okSaveInvoice := false;
      AllOk := True;


      // **************************************************************************
      // Save invoice starts
      // **************************************************************************

      lExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
      lExecutionPlan.BeginTransaction;
      try
        _CurrencyValueSell := zCurrencyRate;

        AddDeleteFromInvoiceToExecutionPlan(lExecutionPlan);

        iMultiplier := 1; // til þess að setja í mínus ef Kredit
        if FCredit then
        begin
          iMultiplier := -1;
        end;

        dTotalStayTax := 0.00;
        iTotalStayTaxNights := 0;

        try
          dTotalStayTax := _StrToFloat(labLodgingTaxISK.caption);
          dTotalStayTax := iMultiplier * dTotalStayTax;
        Except
        end;

        try
          iTotalStayTaxNights := strToInt(labLodgingTaxNights.caption);
          // ATH double value
          iTotalStayTaxNights := iMultiplier * iTotalStayTaxNights;
          if iTotalStayTaxNights <> 0 then
            labTaxNights.caption := 'Nights.';
        Except
        end;

        // --
        fItems := 0.00;
        FTotal := 0.00;
        fTotalVAT := 0.00;
        fTotalWOVat := 0.00;

        (*
          col_Item        = 0;
          col_Description = 1;
          col_ItemCount   = 2;
          col_ItemPrice   = 3;
          col_TotalPrice  = 4;
          col_System      = 5;
          col_date        = 6;
        *)

        RoomRentPaid := false;

        for i := 1 to agrLines.RowCount - 1 do
        begin
          // -- is this an empty line ?
          sItemID := trim(agrLines.Cells[col_Item, i]);
          sDescription := trim(agrLines.Cells[col_Description, i]);
          sSource := trim(agrLines.Cells[col_Source, i]);
          sRefrence := trim(agrLines.Cells[col_Refrence, i]);

          sTmp := agrLines.Cells[col_confirmdate, i];
          if sTmp <> '' then
          begin
            confirmDate := _DBDateToDateTimeNoMs(sTmp);
          end
          else
            confirmDate := 2;

          confirmAmount := _StrToFloat(agrLines.Cells[col_confirmAmount, i]);

          isPackage := false;
          try
            sTmp2 := trim(agrLines.Cells[col_isPackage, i]);
            if sTmp2 = 'Yes' then
              isPackage := True;
          except
            // not raise
          end;

          // ef tómt
          if (trim(sItemID) = '') and (sDescription = '') then
            continue;

          iNights := 0;
          iPersons := 0;

          if agrLines.Cells[col_NoGuests, i] <> '' then
          begin
            iPersons := strToInt(agrLines.Cells[col_NoGuests, i])
          end;

          ItemTypeInfo := d.Item_Get_ItemTypeInfo(sItemID, sSource);
          agrLines.Cells[col_date, i] := datetostr(trunc(now));
          agrLines.Objects[col_Description, i] := TObject(trunc(now));

          // RoomRentItem
          invRoomReservation := -1;
          if _trimlower(sItemID) = _trimlower(g.qRoomRentItem) then
          begin
            if agrLines.Objects[col_ItemCount, i] <> nil then
            begin
              // iPersons := TRoomInfo(agrLines.Objects[col_ItemCount, i]).FNumPersons;
              invRoomReservation := TRoomInfo(agrLines.Objects[col_ItemCount, i])
                .FRoomReservation;
              iNights := trunc(TRoomInfo(agrLines.Objects[col_ItemCount, i]).FTo) -
                trunc(TRoomInfo(agrLines.Objects[col_ItemCount, i]).FFrom);
            end;
          end;

          // verð á vöru í vörulínu
          sLinePrice := agrLines.Cells[col_ItemPrice, i];
          dLinePrice := _StrToFloat(sLinePrice);

          // Heildaverð vörulínu
          sLineTotal := agrLines.Cells[col_TotalPrice, i];
          dLineTotal := _StrToFloat(sLineTotal);

          // Reikna VSK
          dNumItems := _StrToFloat(agrLines.Cells[col_ItemCount, i]);
          if (LowerCase(trim(g.qRoomRentItem))
            = LowerCase(agrLines.Cells[col_Item, i])) OR
            (LowerCase(trim(g.qDiscountItem))
            = LowerCase(agrLines.Cells[col_Item, i])) then
            dNumItems := 1.00;

          lInvRoom := TInvoiceRoomEntity.create(agrLines.Cells[col_Item, i], 1,
                                                _StrToFloat(agrLines.Cells[col_ItemCount, i]), dLineTotal, 0, 0);
          try
            dLineVAT := GetVATForItem(agrLines.Cells[col_Item, i], dLineTotal, dNumItems, lInvRoom , nil, ItemTypeInfo, edtCustomer.Text);
          finally
            lInvRoom.Free;
          end;

          if NOT(Item_GetKind(agrLines.Cells[col_Item, i]) IN [ikRoomRent, ikRoomRentDiscount]) then
            agrLines.Cells[col_Vat, i] :=
              trim(_floattostr(dLineVAT, vWidth, 3));
          // Formula
          // dTmp := dLineTotal / (1 + (ItemTypeInfo.VATPercentage / 100));
          // dLineVAT := dLineTotal - dTmp;

          // og án VSK
          dLineTotalWOVat := dLineTotal - dLineVAT;

          // Ef kredit
          dLinePrice := iMultiplier * dLinePrice;
          dLineTotal := iMultiplier * dLineTotal;
          dLineVAT := iMultiplier * dLineVAT;
          dLineTotalWOVat := iMultiplier * dLineTotalWOVat;

          // Ef í gjaldmiðli þá uppreikna
          // RoomRent vörulínur í ISK
          if Item_isRoomRent(sItemID) then
          begin
            dLinePrice := _CurrencyValueSell * dLinePrice;
            dLineTotal := _CurrencyValueSell * dLineTotal;
            dLineVAT := _CurrencyValueSell * dLineVAT;
            dLineTotalWOVat := _CurrencyValueSell * dLineTotalWOVat;
            RoomRentPaid := True;
          end;

          // og aftur í texta
          sLinePrice := _CommaToDot(floattostr(dLinePrice));
          sLineTotal := _CommaToDot(floattostr(dLineTotal));
          sLineVAT := _CommaToDot(floattostr(dLineVAT));
          sLineTotalWOVat := _CommaToDot(floattostr(dLineTotalWOVat));

          // Samtals á reikning í ISK
          FTotal := FTotal + dLineTotal;
          fTotalVAT := fTotalVAT + dLineVAT;
          fTotalWOVat := fTotalWOVat + dLineTotalWOVat;

          sRRAlias := trim(agrLines.Cells[col_rrAlias, i]);

          irrAlias := -1;
          try
            if sRRAlias <> '' then
              irrAlias := strToInt(sRRAlias);
          Except
          end;

          try
            decodedate(integer(agrLines.Objects[col_Description, i]), AYear, AMon, ADay);
          except
            decodedate(now, AYear, AMon, ADay);
          end;

          try
            ItemCount := _StrToFloat(agrLines.Cells[col_ItemCount, i]); // -96
          Except
            ItemCount := 0;
          end;

          sAccountKey := d.Item_Get_AccountKey(sItemID);

          InvoiceLine := CellInvoiceLine(i);
          if (NOT Assigned(InvoiceLine)) OR (InvoiceLine.FId < 1) then
          begin
            // SQL 116 INSERxT Invoicelines
            s := '' + #10;
            s := s + 'INSERT into invoicelines' + #10;
            s := s + '(' + #10;
            s := s + '  ' + 'Reservation ' + #10;
            s := s + ', ' + 'AutoGen ' + #10;
            s := s + ', ' + 'RoomReservation ' + #10;
            s := s + ', ' + 'SplitNumber ' + #10;
            s := s + ', ' + 'ItemNumber ' + #10;
            s := s + ', ' + 'PurchaseDate ' + #10;
            s := s + ', ' + 'InvoiceNumber ' + #10;
            s := s + ', ' + 'ItemId ' + #10;
            s := s + ', ' + 'Number ' + #10;
            s := s + ', ' + 'Description ' + #10;
            s := s + ', ' + 'Price ' + #10;
            s := s + ', ' + 'VATType ' + #10;
            s := s + ', ' + 'Total ' + #10;
            s := s + ', ' + 'TotalWOVat ' + #10;
            s := s + ', ' + 'VAT ' + #10;
            s := s + ', ' + 'CurrencyRate ' + #10;
            s := s + ', ' + 'Currency ' + #10;
            s := s + ', ' + 'Persons ' + #10;
            s := s + ', ' + 'Nights ' + #10;
            s := s + ', ' + 'BreakfastPrice ' + #10;
            s := s + ', ' + 'AutoGenerated ' + #10;

            s := s + ', ' + 'AYear ' + #10;
            s := s + ', ' + 'AMon ' + #10;
            s := s + ', ' + 'ADay ' + #10;
            s := s + ', ' + 'ilAccountKey ' + #10;
            s := s + ', ' + 'importRefrence ' + #10;
            s := s + ', ' + 'importSource ' + #10;
            s := s + ', ' + 'confirmDate ' + #10;
            s := s + ', ' + 'confirmAmount ' + #10;
            s := s + ', ' + 'IsPackage ' + #10;
            s := s + ', ' + 'RoomReservationAlias ' + #10;
            s := s + ', ' + 'InvoiceIndex ' + #10;
            s := s + ', ' + 'staffCreated ' + #10;
            s := s + ')' + #10;
            s := s + 'Values' + #10;
            s := s + '(' + #10;
            s := s + '  ' + _db(publicReservation); // Reservation
            s := s + ', ' + _db(_GetCurrentTick); // AutoGen
            s := s + ', ' + _db(FRoomReservation); // RoomReservation
            s := s + ', ' + _db(FnewSplitNumber); // SPlitNumber
            s := s + ', ' + _db(i); // ItemNumber

            s := s + ', ' + _DateToDbDate(integer(agrLines.Objects[col_Description, i]), True);
            // PurchaseDate //ATHOLD er þetta alltaf now
            s := s + ', ' + inttostr(zInvoiceNumber); // InvoiceNumber
            s := s + ', ' + _db(sItemID); // ItemID
            s := s + ', ' + _db(ItemCount);
            s := s + ', ' + _db(sDescription);
            s := s + ', ' + sLinePrice;
            s := s + ', ' + _db(ItemTypeInfo.VATCode);
            s := s + ', ' + sLineTotal;
            s := s + ', ' + sLineTotalWOVat;
            s := s + ', ' + sLineVAT;
            s := s + ', ' + _CommaToDot(floattostr(zCurrencyRate));
            s := s + ', ' + _db(edtCurrency.Text);
            s := s + ', ' + inttostr(iPersons);
            s := s + ', ' + inttostr(iNights);
            s := s + ', ' + _CommaToDot(floattostr(0.00));
            s := s + ', ' + _db(false);

            s := s + ', ' + inttostr(AYear);
            s := s + ', ' + inttostr(AMon);
            s := s + ', ' + inttostr(ADay);

            s := s + ', ' + _db(sAccountKey);
            s := s + ', ' + _db(sRefrence);
            s := s + ', ' + _db(sSource);
            s := s + ', ' + _dbDateAndTime(confirmDate);
            s := s + ', ' + _db(confirmAmount);
            s := s + ', ' + _db(isPackage);
            s := s + ', ' + _db(irrAlias);
            s := s + ', ' + _db(FInvoiceIndex);
            s := s + ', ' + _db(d.roomerMainDataSet.username);

            s := s + ')' + #10;
          end else
          begin
            s := 'UPDATE invoicelines' +
                 ' Set ItemNumber= ' + _db(i) +
                 ' , InvoiceNumber= ' + _db(zInvoiceNumber) +
                 ' , Number= ' + _db(ItemCount) +
                 ' , Price= ' + sLinePrice +
                 ' , Total= ' + sLineTotal +
                 ' , TotalWOVat= ' + sLineTotalWOVat +
                 ' , VAT= ' + sLineVAT +
                 ' , CurrencyRate= ' + _CommaToDot(floattostr(zCurrencyRate)) +
                 ' , Currency= ' + _db(edtCurrency.Text) +
                 ' , Persons= ' + inttostr(iPersons) +
                 ' , Nights= ' + inttostr(iNights) +
                 ' , ilAccountKey= ' + _db(sAccountKey) +
                 ' , InvoiceIndex= ' + _db(FInvoiceIndex) +
                 ' , staffLastEdit= ' + _db(d.roomerMainDataSet.username) +
                 ' WHERE id=' + _db(InvoiceLine.FId);
          end;

          // copytoclipboard(s);
          // debugmessage(s);

          lExecutionPlan.AddExec(s);

          try
            lstActivity.add(CreateInvoiceActivityLog(g.qUser, publicReservation,
              FRoomReservation, FnewSplitNumber, ADD_LINE, sItemID, dLineTotal,
              zInvoiceNumber, sDescription));
          Except
          end;

          if RoomRentPaid then
            if invRoomReservation > 0 then
            begin
              // **
              s := '';
              s := s + 'UPDATE roomreservations ' + #10;
              s := s + 'SET' + #10;
              s := s + '   RoomRentPaid1 = ' + _db(dLineTotal) + ' '#10;
              s := s + '  ,RoomRentPaymentInvoice = ' +
                _db(zInvoiceNumber) + #10;
              s := s + 'WHERE RoomReservation = ' +
                _db(invRoomReservation) + #10;
              lExecutionPlan.AddExec(s);

              // update isPaid ef groupInvoice

              s := '';
              s := s + ' UPDATE `roomsdate` '#10;
              s := s + '  SET '#10;
              s := s + '    Paid = 1 '#10;
              s := s + '  , invoicenumber=' + _db(zInvoiceNumber) + ' '#10;
              s := s + ' WHERE '#10;
              s := s + ' (Roomreservation = ' + inttostr(invRoomReservation)
                + ') '#10;;
              s := s + ' AND (Paid = 0) '#10;
              s := s + '   AND (ResFlag <> ' + _db(STATUS_DELETED) + ' ) '#10;
              // **zxhj bætti við
              s := s + ' ORDER BY adate '#10; // **ssshj bætti við
              s := s + ' LIMIT ' + _db(ItemCount) + ' '#10; // **ssshj bætti við

              // copyToClipboard(s);
              // debugMessage(s);
              lExecutionPlan.AddExec(s);
            end;
        end;

        // SaveHeader(fTotal, fTotalVat, fTotalWOVat );
        s := '' + #10;
        s := s + 'INSERT into invoiceheads ' + #10;
        s := s + '(' + #10;
        s := s + '  Reservation ' + #10;
        s := s + ', RoomReservation ' + #10;
        s := s + ', SplitNumber ' + #10;

        s := s + ', InvoiceNumber ' + #10;
        s := s + ', InvoiceDate ' + #10;

        s := s + ', Customer ' + #10;
        s := s + ', Name ' + #10;
        s := s + ', CustPid ' + #10;
        s := s + ', RoomGuest ' + #10;

        s := s + ', Address1 ' + #10;
        s := s + ', Address2 ' + #10;
        s := s + ', Address3 ' + #10;
        s := s + ', Address4 ' + #10;
        s := s + ', Country ' + #10;
        s := s + ', Total ' + #10;
        s := s + ', TotalWOVat ' + #10;
        s := s + ', TotalVat ' + #10;
        s := s + ', TotalBreakfast ' + #10;
        s := s + ', ExtraText ' + #10;
        s := s + ', OriginalInvoice ' + #10;
        s := s + ', Finished ' + #10;
        s := s + ', InvoiceType ' + #10;
        s := s + ', ihStaff ' + #10;
        s := s + ', ihDate ' + #10;
        s := s + ', ihInvoiceDate ' + #10;
        s := s + ', ihConfirmDate ' + #10;
        s := s + ', ihPayDate ' + #10;
        s := s + ', invRefrence ' + #10;
        s := s + ', TotalStayTax ' + #10;
        s := s + ', TotalStayTaxNights ' + #10;
        s := s + ', ihCurrency ' + #10; // **98
        s := s + ', ihCurrencyrate ' + #10; // **98
        s := s + ', showPackage ' + #10; // **98
        s := s + ', Location ' + #10; // **98
        s := s + ', staff ' + #10; // **98

        s := s + ')' + #10;

        s := s + 'Values' + #10;
        s := s + '(' + #10;
        s := s + '  ' + inttostr(publicReservation);
        s := s + ', ' + inttostr(FRoomReservation);
        s := s + ', ' + inttostr(FnewSplitNumber);

        s := s + ', ' + inttostr(zInvoiceNumber);

        s := s + ', ' + _DateToDbDate(zInvoiceDate, True);

        s := s + ', ' + _db(edtCustomer.Text);
        s := s + ', ' + _db(edtName.Text);
        s := s + ', ' + _db(edtPersonalId.Text);
        s := s + ', ' + _db(edtRoomGuest.Text);

        s := s + ', ' + _db(edtAddress1.Text);
        s := s + ', ' + _db(edtAddress2.Text);
        s := s + ', ' + _db(edtAddress3.Text);
        s := s + ', ' + _db(edtAddress4.Text);

        s := s + ', ' + _db(zCountry);

        s := s + ', ' + _CommaToDot(floattostr(FTotal));
        s := s + ', ' + _CommaToDot(floattostr(fTotalWOVat));
        s := s + ', ' + _CommaToDot(floattostr(fTotalVAT));
        s := s + ', ' + _CommaToDot(floattostr(0.00));
        s := s + ', ' + _db(memExtraText.Lines.Text);
        s := s + ', ' + inttostr(zOriginalInvoice);
        s := s + ', ' + _db(false);
        s := s + ', ' + inttostr(rgrInvoiceType.itemIndex);
        s := s + ', ' + _db(g.qUser);
        s := s + ', ' + _DateToDbDate(Date, True);
        s := s + ', ' + _DateToDbDate(zInvoiceDate, True);
        s := s + ', ' + _DateToDbDate(zConfirmDate, True);
        s := s + ', ' + _DateToDbDate(zPayDate, True);
        s := s + ', ' + _db(edtInvRefrence.Text);

        s := s + ', ' + _CommaToDot(floattostr(dTotalStayTax));
        s := s + ', ' + inttostr(iTotalStayTaxNights);
        s := s + ', ' + _db(edtCurrency.Text);
        s := s + ', ' + _db(_StrToFloat(edtRate.Text));
        s := s + ', ' + _db(chkShowPackage.checked);
        s := s + ', ' + _db(zLocation);
        s := s + ', ' + _db(d.roomerMainDataSet.username);

        s := s + ')' + #10;

        // copytoclipboard(s);
        // debugmessage(s);

        lExecutionPlan.AddExec(s);




        // ***************************
        //
        // INSERxT PAYMENTS
        //
        // ***************************

//        PaymentDescription := 'Payment Invoice ' + inttostr(zInvoiceNumber);
        PaymentType := ptInvoice;
        pmStr := '';

        for i := 0 to stlPaySelections.Count - 1 do
        begin
          PaymentDescription := _strTokenAt(stlPaySelections[i], '|', 2); // 'Payment Invoice ' + inttostr(zInvoiceNumber);
          decodedate(zInvoiceDate, AYear, AMon, ADay);
          // SQL 117 INSERxT Payments
          s := '';
          s := s + 'INSERT INTO payments' + #10;
          s := s + '(' + #10;
          s := s + '  Reservation' + '' + #10;
          s := s + ', RoomReservation' + #10;
          s := s + ', Person' + #10;

          s := s + ', Customer' + #10;
          s := s + ', AutoGen' + #10;
          s := s + ', InvoiceNumber' + #10;
          s := s + ', PayDate' + #10;

          s := s + ', PayType' + #10;
          s := s + ', Amount' + #10;
          s := s + ', Description' + #10;

          s := s + ', CurrencyRate' + #10;
          s := s + ', Currency' + #10;

          s := s + ', TypeIndex' + #10;

          s := s + ', AYear' + #10;
          s := s + ', AMon' + #10;
          s := s + ', ADay' + #10;
          s := s + ', staff' + #10;
          s := s + ', InvoiceIndex' + #10;

          s := s + ')' + #10;
          s := s + 'Values' + #10;
          s := s + '(' + #10;

          s := s + '  ' + inttostr(publicReservation);
          s := s + ', ' + inttostr(FRoomReservation);
          s := s + ', ' + inttostr(FnewSplitNumber);

          s := s + ', ' + _db(sSelectedCustomer);

          ct := _GetCurrentTick;
          s := s + ', ' + _db(ct);

          s := s + ', ' + inttostr(zInvoiceNumber);
          s := s + ', ' + _DateToDbDate(zInvoiceDate, True);
          sTmp := _strTokenAt(stlPaySelections[i], '|', 0);
          s := s + ', ' + _db(_strTokenAt(stlPaySelections[i], '|', 0));
          s := s + ', ' + _CommaToDot
            (trim(floattostr(iMultiplier *
            _StrToFloat(_strTokenAt(stlPaySelections[i], '|', 1)))));
          s := s + ', ' + _db(PaymentDescription + ' [' +
            _strTokenAt(stlPaySelections[i], '|', 0) + ']');
          s := s + ', ' + _CommaToDot(floattostr(zCurrencyRate));
          s := s + ', ' + _db(edtCurrency.Text);
          if PaymentType = ptInvoice then
            s := s + ', 0'
          else if PaymentType = ptDownPayment then
            s := s + ', 1';
          s := s + ', ' + inttostr(AYear);
          s := s + ', ' + inttostr(AMon);
          s := s + ', ' + inttostr(ADay);
          s := s + ', ' + _db(d.roomerMainDataSet.username);
          s := s + ', ' + _db(FInvoiceIndex);
          s := s + ')';

          lExecutionPlan.AddExec(s);
          try
            paymentValue := iMultiplier *
              _StrToFloat(_strTokenAt(stlPaySelections[i], '|', 1));
            paymentCode := _strTokenAt(stlPaySelections[i], '|', 0);
            paymentStr := PaymentDescription + ' [' +
              _strTokenAt(stlPaySelections[i], '|', 0) + ']';

            lstActivity.add(CreateInvoiceActivityLog(g.qUser, publicReservation,
              FRoomReservation, FnewSplitNumber, ADD_PAYMENT, paymentCode,
              paymentValue, zInvoiceNumber, paymentStr));
          Except
          end;

          zRoomIsInTemp := false;
          AllOk := True;
        end;

        s := '';
        s := s + ' UPDATE `payments` '#10;
        s := s + '  SET '#10;
        s := s + ' `invoicenumber` = ' + _db(zInvoiceNumber) + ' '#10;
        s := s + ' WHERE (`reservation` = %d) and (`Roomreservation` = %d) and (Invoicenumber=-1) and (InvoiceIndex=%d) and (typeindex=1); ';
        s := format(s, [publicReservation, FRoomReservation, FInvoiceIndex]);
        lExecutionPlan.AddExec(s);

        if lExecutionPlan.Execute(ptExec, false, false) then
        begin
          lExecutionPlan.CommitTransaction;
          // NO REFRESH        frmMain.btnRefresh.Click;
        end
        else
          raise Exception.create(lExecutionPlan.ExecException);

        result := True;

      except
        on e: Exception do
        begin
          zErr := True;
          // frmDayNotes.xDoLog('Creating Invoice ', e.message);
          frmdayNotes.xDoLog(GetTranslatedText('shTx_Invoice_CreatingInvoice'),
            e.message);
          // MessageDlg('Problem: Unable to Book the Invoice !' + #13#13 + 'While saving invoice The following Error came up:' + #13#13 +
          // e.message + #13#13 + 'Please write this message down or' + #13 + 'call support with this dialog open!', mtError, [mbOK],
          lExecutionPlan.RollbackTransaction;
          // MessageDlg(format(GetTranslatedText('shTx_Invoice_UnableToSaveInvoiceMessage'), [e.message]), mtError, [mbOk], 0);
          if MessageDlg('We are unable to save the invoice. Select [Retry] to try again or [Cancel] '
                        + #13 + 'to temporarily stop the work with this invoice', mtError,
                        [mbRetry, mbCancel], 0) = mrCancel then
            close;

          IVH_RestoreID();
          exit;
          // raise;
        end;
      end;

      FreeAndNil(lExecutionPlan);

      if AllOk then
      begin
        if (FCredit and (zCreditType = ctReference)) then
        begin
          MarkOriginalInvoiceAsCredited(zInvoiceNumber);
        end
      end;
    end;

    if AllOk then
    begin
      if NOT FCredit then
      begin
        if d.addInvoiceLinesTmp(1, publicReservation) then
        begin
          d.qRes := publicReservation;
          d.qRRes := FRoomReservation;
        end;
      end;

      doRestore := false;
      if (FCredit and (zCreditType = ctReference)) and
      // (MessageDlg('Open a new invoice with the original amounts'+#10+'when finished printing credit invoice ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
        (MessageDlg(GetTranslatedText
        ('shTx_Invoice_OpenInvoiceAfterPrintCredit'), mtConfirmation,
        [mbYes, mbNo], 0) = mrYes) then
      begin
        d.copyInvoiceToInvoiceLinesTmp(zRefNum, True);
        doRestore := True;
      end;

      zDoSave := false;
      SaveAnd(false);
      try
        // Hér er tekkað á kvort ógreiddir herbergja  reikningar
        // séu til staðar ef þetta er hópreikningur
        // if publicReservation > 0 then
        // begin
        // if FRoomReservation <= 0 then
        // begin
        // postMessage(frmMain.handle, WM_CheckInvoices, publicReservation, - 1);
        // end;
        // end;

        result := True;
        try
          ViewInvoice2(zInvoiceNumber, True, false, True,
            chkShowPackage.checked, zEmailAddress);

          if dkAutoTransfer then
          begin
            // BOOK KEEPING / Finance
            remoteResult := d.roomerMainDataSet.SystemSendInvoiceToBookkeeping
              (zInvoiceNumber);
            if remoteResult <> '' then
            begin
              HandleExceptionListFromBookKeepingSystem(zInvoiceNumber,
                remoteResult);
            end;

          end;

          d.roomerMainDataSet.SystempackagesCreateHeaderIfNotExists
            (FRoomReservation, FRoomReservation);

          if doRestore then
          begin
            // if Froomreservation = 0 then
            // begin
            // EditInvoice(PublicReservation, 0, 0, 0, 0, false,false,false);
            // end else
            // begin
            // //This is not groupinvoice
            // EditInvoice(publicReservation, FRoomReservation, 0, 0, 0, false, false,false);
            // end;
          end;
        finally
          try
            lstActivity.add(CreateInvoiceActivityLog(g.qUser, publicReservation,
              FRoomReservation, FnewSplitNumber, PAY_AND_PRINT,
              inttostr(zInvoiceNumber), FTotal, 0, 'Invoice added '));
          Except
          end;

          for i := 0 to lstActivity.Count - 1 do
          begin
            try
              if lstActivity[i] <> '' then
                WriteInvoiceActivityLog(lstActivity[i]);
            Except
            end;
          end;
        end;

      except
        on e: Exception do
        begin
          ShowMessage('Ekki tókst ad senda reikning No. ' +
            inttostr(zInvoiceNumber) +
            ' til bókhaldskerfisins. Vinsamlega sendið reikninginn handvirkt síðar ');
          AddRoomerActivityLog(d.roomerMainDataSet.username, ERROR, e.message,
            format('Exception while sending invoice to booking keeping. Invoice %d, RoomReservation %d, Reservation %d -> %s',
            [zInvoiceNumber, FRoomReservation, publicReservation, e.message]));
          // Sýna dialog - segja frá ad ekki hafi gengid ad send invoice til DK vegna tengivillu.
          // Gefa upp númerid á reikningnum.
        end;
      end;
    end
    else
    begin
      IVH_RestoreID();
      zDoSave := false;
      // btnSave.Click;
      SaveAnd(false);
      result := True;
    end;
  finally
    FreeAndNil(lstLocations);
    FreeAndNil(lstActivity);
  end;
end;

procedure TfrmInvoice.HandleExceptionListFromBookKeepingSystem
  (invoiceNumber: integer; ErrorList: String);
begin
  HandleFinanceBookKeepingExceptions(invoiceNumber, ErrorList);
end;

// -- The original Invoice contains a special field which links it to the
// subceeding credit invoice. This is for traceback puurposes.
procedure TfrmInvoice.MarkOriginalInvoiceAsCredited(iInvoice: integer);
var
  s: string;
begin
  s := '';
  s := s + 'UPDATE invoiceheads ' + #10;
  s := s + ' Set ' + #10;
  s := s + '  CreditInvoice ' + ' = ' + _db(iInvoice) + #10;
  s := s + ' where InvoiceNumber = ' + _db(zRefNum);
  if not cmd_bySQL(s) then
  begin
    ShowMessage('MarkOriginalInvoiceAsCredited');
  end;
end;

procedure TfrmInvoice.btnProformaClick(Sender: TObject);
begin
  // **
end;

procedure TfrmInvoice.MoveRoomToGroupInvoice;
begin
  if FRoomReservation = 0 then
  begin
    ShowMessage(GetTranslatedText('shTx_Invoice_GroupInvoice'));
    exit;
  end;

  // if (MessageDlg('Move roomrent to Groupinvoice ' + chr(10) + 'and save other changes ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  if (MessageDlg(GetTranslatedText
    ('shTx_Invoice_RoomrentToGroupAndSaveChanges'), mtConfirmation,
    [mbYes, mbNo], 0) = mrYes) then
  begin
    d.UpdateGroupAccountone(publicReservation, FRoomReservation,
      FRoomReservation, True);
    SaveInvoice(zInvoiceNumber);
    LoadInvoice;
  end;
end;

procedure TfrmInvoice.MoveRoomToNewInvoiceIndex(rowIndex, toInvoiceIndex: integer);
begin
  // if (MessageDlg('Move roomrent to Groupinvoice ' + chr(10) + 'and save other changes ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  d.UpdateGroupAccountone(publicReservation, FRoomReservation, FRoomReservation,
    FRoomReservation = 0, toInvoiceIndex);
  InvoiceIndex := FInvoiceIndex;
end;

function TfrmInvoice.IsRoomSelected : Boolean;
var i : Integer;
    check : Boolean;
begin
  result := False;
  for i := 1 to agrLines.RowCount - 1 do
    if isSystemLine(i) then
      if agrLines.HasCheckbox(col_Select, i) then
      begin
        agrLines.GetCheckBoxState(col_Select, i, check);
        if check then
        begin
          result := True;
          Break;
        end;
      end;
end;

procedure TfrmInvoice.MoveRoomToRoomInvoice;
begin
  if FRoomReservation > 0 then
  begin
    ShowMessage(GetTranslatedText('shTx_Invoice_RoomInvoice'));
    exit;
  end;

  if selectedRoomReservation < 0 then
    exit;

  // if (MessageDlg('Move roomrent to Groupinvoice ' + chr(10) + 'and save other changes ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  if (MessageDlg(GetTranslatedText('shTx_Invoice_RoomrentToRoomAndSaveChanges'),
    mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    d.UpdateGroupAccountone(publicReservation, selectedRoomReservation,
      selectedRoomReservation, false);
    SaveInvoice(zInvoiceNumber);
    LoadInvoice;
  end;
end;

procedure TfrmInvoice.edtCurrencyDblClick(Sender: TObject);
var
  s: string;
  theData: recCurrencyHolder;
  oldCurrency: string;
begin
  s := '';
  oldCurrency := trim(edtCurrency.Text);
  theData.Currency := oldCurrency;
  Currencies(actLookup, theData);
  if theData.Currency <> '' then
  begin
    s := theData.Currency;
  end;

  if (s <> '') and (s <> oldCurrency) then
  begin
    edtCurrency.Text := s;
    if edtCurrency.Text = zNativeCurrency then
    begin
      edtForeignCurrency.Text := '';
      edtForeignCurrency.visible := false;
    end;
    zCurrentCurrency := s;
    CheckCurrencyChange(oldCurrency);
  end;
  // **
  // if FnewSplitNumber = 2 then
  // begin
  // CreateCashInvoice(s);
  // end;

  chkChanged;
end;

procedure TfrmInvoice.edtCurrencyChange(Sender: TObject);
begin
  // clabForeignCurrency.visible := edtCurrency.Text <> '';
  // edtForeignCurrency.visible := edtCurrency.Text <> '';
  //
  // if edtForeignCurrency.visible then
  // begin
  // zCurrencyRate := GetRate(zCurrenctCurrency);
  // edtRate.Text := FloatToStr(zCurrencyRate);
  // end
  // else
  // begin
  // zCurrencyRate := 1.00;
  // edtRate.Text := FloatToStr(zCurrencyRate);
  // end;
  // agrLines.Refresh;
  // calcStayTax(publicReservation);
end;

procedure TfrmInvoice.agrLinesDrawCell(Sender: TObject; ACol, ARow: integer;
  Rect: TRect; State: TGridDrawState);
var
  Bmp: TIcon;
  Item: string;
begin
  inherited;
  // --
  if not edtForeignCurrency.visible then
    exit;
  if (ACol <> 5) then
    exit;

  Item := trim(TAdvStringGrid(Sender).Cells[col_Item, ARow]);
  if (trim(g.qRoomRentItem) <> Item) and (trim(g.qDiscountItem) <> Item) then
    exit;

  try
    Bmp := TIcon.create;
    try
      GridImages.GetIcon(0, Bmp);
      TAdvStringGrid(Sender).canvas.Draw(Rect.left + 1, Rect.top + 1, Bmp);
    finally
      Bmp.free;
    end;
  except
  end;
end;

procedure TfrmInvoice.CheckCurrencyChange(oldCurrency: string);
var
  oldRate, NewRate: Double;
  i: integer;

  sUnitPrice: string;
  fUnitPrice: Double;

  unitPrice: Double;
  TotalPrice: Double;

  convert: Double;

  unitCount: Double; // -96

  s: string;
  rSet: TRoomerDataset;
  aDate: string;

  RoomReservation: integer;

  Item: string;
begin

  if zCurrentCurrency <> oldCurrency then
  begin
    oldRate := GetRate(oldCurrency);
    NewRate := GetRate(zCurrentCurrency);

    if NewRate = 0 then
      NewRate := 1;
    zCurrencyRate := NewRate;
    edtRate.Text := floattostr(zCurrencyRate);
    convert := oldRate / NewRate;

    // Then update database;
    if (FRoomReservation = 0) and (publicReservation > 0) then
    begin
      rSet := CreateNewDataSet;
      try
        s := '';
        s := format(select_Invoice_CheckCurrencyChange, [publicReservation, FInvoiceIndex]);
        hData.rSet_bySQL(rSet, s);
        rSet.first;
        while not rSet.eof do
        begin
          RoomReservation := rSet.FieldByName('RoomReservation').asinteger;
          UpdateCurrencyRoomPrice(RoomReservation, zCurrentCurrency,
            NewRate, convert);


          // mRoomRates.Filter := '(Roomreservation=' + inttostr(RoomReservation) + ')';
          // mRoomRates.Filtered := true;

          mRoomRates.first;
          while not mRoomRates.eof do
          begin
            if mRoomRates['Roomreservation'] = RoomReservation then
            begin
              aDate := _DateToDbDate(mRoomRates.FieldByName('rateDate')
                .asdateTime, false);
              d.RR_Upd_CurrencyRoomPrice(RoomReservation, aDate,
                zCurrentCurrency, convert);
            end;
            mRoomRates.Next;
          end;
          s := '';
          s := s + ' UPDATE roomreservations ' + chr(10);
          s := s + ' SET ' + chr(10);
          s := s + ' Currency=' + _db(zCurrentCurrency) + ' ' + chr(10);
          s := s + ' WHERE (RoomReservation = ' + inttostr(RoomReservation) +
            ') ' + chr(10);
          if not cmd_bySQL(s) then
          begin
          end;

          s := '';
          s := s + ' UPDATE roomsdate ' + chr(10);
          s := s + ' SET ' + chr(10);
          s := s + ' Currency=' + _db(zCurrentCurrency) + ' ' + chr(10);
          s := s + ' WHERE (RoomReservation = ' + inttostr(RoomReservation) +
            ') ' + chr(10);
          if not cmd_bySQL(s) then
          begin
          end;

          rSet.Next;
          // mRoomRates.Filtered := false;
        end;
      finally
        FreeAndNil(rSet);
      end;
    end
    else if (FRoomReservation > 0) then
    begin
      UpdateCurrencyRoomPrice(FRoomReservation, zCurrentCurrency,
        NewRate, convert);
      mRoomRates.first;
      while not mRoomRates.eof do
      begin
        aDate := _DateToDbDate(mRoomRates.FieldByName('rateDate').asdateTime, false);
        d.RR_Upd_CurrencyRoomPrice(FRoomReservation, aDate,
          zCurrentCurrency, convert);
        s := '';
        s := s + ' UPDATE roomreservations ' + chr(10);
        s := s + ' SET ' + chr(10);
        s := s + ' Currency=' + _db(zCurrentCurrency) + ' ' + chr(10);
        s := s + ' WHERE (RoomReservation = ' + inttostr(FRoomReservation) +
          ') ' + chr(10);
        if not cmd_bySQL(s) then
        begin
{$IFDEF DEBUG}
          frmdayNotes.memLog.Lines.add(s);
          frmdayNotes.memLog.Lines.add('----');
{$ENDIF}
        end;
        mRoomRates.Next;
      end;
    end
    else if (FRoomReservation = 0) and (publicReservation = 0) then
    begin
      exit;
    end;

    calcStayTax(publicReservation);

    for i := 1 to agrLines.RowCount - 1 do
    begin
      Item := agrLines.Cells[col_Item, i];
      if Item_isRoomRent(Item) then
      begin
        if NOT isSystemLine(i) then
        begin
          sUnitPrice := agrLines.Cells[col_ItemPrice, i];
          fUnitPrice := _StrToFloat(sUnitPrice);
          unitPrice := fUnitPrice * convert;

          try
            unitCount := _StrToFloat(agrLines.Cells[col_ItemCount, i])
          except
            unitCount := 1;
          end;

          TotalPrice := unitCount * unitPrice;
          agrLines.Cells[col_ItemPrice, i] :=
            _floattostr(unitPrice, vWidth, vDec);
          agrLines.Cells[col_TotalPrice, i] :=
            _floattostr(TotalPrice, vWidth, vDec);
        end;
      end;
    end;

    /// ****ATH
    // if FRoomReservation > 0 then
    // begin

    if pageMain.ActivePageIndex = 0 then
    begin
      applyChanges;
      SaveAnd(false);
      ClearObjects;
      ClearLines;
      FormCreate(nil);
      agrLines.OnSelectCell := nil;
      LoadInvoice;
      PrepareInvoice;
    end;
    // end;
  end;

end;

procedure TfrmInvoice.CheckRateChange;
var
  NewRate: Double;
  sRate: string;

begin
  sRate := edtRate.Text;

  try
    NewRate := _StrToFloat(edtRate.Text);
  except
    NewRate := 1;
    edtRate.Color := clRed;
  end;

  if NewRate = 0 then
    NewRate := 1;

  zCurrencyRate := NewRate;
  calcStayTax(publicReservation);
end;

procedure TfrmInvoice.edtCurrencyExit(Sender: TObject);
begin
  // CheckCurrencyChange('');
end;

procedure TfrmInvoice.CompressLines(sSalesItem: string);
var
  stl: TStringList;

  function InList(s: string; P: Double): integer;
  var
    i: integer;
  begin
    result := -1;
    for i := 0 to stl.Count - 1 do
    begin
      if _strTokenAt(stl[i], '|', 0) = s then
        if _strTokenAt(stl[i], '|', 1) = floattostr(P) then
        begin
          result := i;
          break;
        end;
    end;
    if result = -1 then
    begin
      result := stl.add(s + '|' + floattostr(P) + '|' + '0' + '|' + '0' + '|' +
        '0' + '|' + '0' + '|' + '' + '|');
    end;
  end;

  procedure AddThis(iRow: integer);
  var
    i: integer;
    s, s1, s2, s3, s4, s5, s6, s7: string;
  begin
    s := agrLines.Cells[col_Item, iRow];

    if trim(s) = '' then
      exit;

    i := InList(s, _StrToFloat(agrLines.Cells[col_ItemPrice, iRow]));
    if i > -1 then
    begin
      s1 := _strTokenAt(stl[i], '|', 0);
      s2 := _strTokenAt(stl[i], '|', 1);
      s3 := _strTokenAt(stl[i], '|', 2);
      s4 := _strTokenAt(stl[i], '|', 3);
      s5 := _strTokenAt(stl[i], '|', 4);
      s6 := _strTokenAt(stl[i], '|', 5);
      s7 := _strTokenAt(stl[i], '|', 6);
      // -- Num Items
      s3 := floattostr(_StrToFloat(s3) +
        _StrToFloat(agrLines.Cells[col_ItemCount, iRow]));

      // -- Item Total
      s4 := floattostr(_StrToFloat(s4) +
        (_StrToFloat(agrLines.Cells[col_ItemPrice, iRow]) *
        _StrToFloat(agrLines.Cells[col_ItemCount, iRow])));

      if agrLines.Cells[col_Item, iRow] = g.qRoomRentItem then
      begin
        // -- Not uesed... But ready ;o)
        s5 := floattostr(_StrToFloat(s5));

        if agrLines.Objects[col_ItemCount, iRow] <> nil then
          if agrLines.Objects[col_ItemCount, iRow] is TRoomInfo then
            s6 := inttostr(strToIntDef(s6, 0) + TRoomInfo(agrLines.Objects[col_ItemCount,
              iRow]).FNumPersons * (trunc(TRoomInfo(agrLines.Objects[col_ItemCount, iRow])
              .FTo) - trunc(TRoomInfo(agrLines.Objects[col_ItemCount, iRow]).FFrom)));
      end;
      if s7 = '' then
        s7 := agrLines.Cells[col_Description, iRow];
      stl[i] := s1 + '|' + s2 + '|' + s3 + '|' + s4 + '|' + s5 + '|' + s6 + '|'
        + s7 + '|';
    end;
  end;

  procedure ReplaceTheSelection;
  var
    i: integer;
    s1, s2, s3, s4, s5, s6, s7: string;
  begin // STGR med virdisauka
    // Listi yfir reikning
    // Tengja Reikning Kreditreikningum
    // Kredit reikn eftir tilv.
    // Nafn sjaist i linu
    // Textar sjaist a reikn
    // Velja Hopreikning is pontun.
    //
    // --

    for i := agrLines.RowCount - 1 downto 1 do
    begin
      if (agrLines.Cells[col_Item, i] = sSalesItem) or
        ((sSalesItem = g.qRoomRentItem) and (agrLines.Cells[col_Item,
        i] = g.qDiscountItem)) or
        ((sSalesItem = '*') and (isSystemLine(i) = false)) then
      begin
        DeleteRow(agrLines, i);
      end;
    end;

    // -- If compressing rooms...
    if (sSalesItem = g.qRoomRentItem) then
    begin
      ClearObjects;
    end;

    for i := 0 to stl.Count - 1 do
    begin
      InsertRows(agrLines, i + 1, 1);

      s1 := _strTokenAt(stl[i], '|', 0);
      s2 := _strTokenAt(stl[i], '|', 1);
      s3 := _strTokenAt(stl[i], '|', 2);
      s4 := _strTokenAt(stl[i], '|', 3);
      s5 := _strTokenAt(stl[i], '|', 4);
      s6 := _strTokenAt(stl[i], '|', 5);
      s7 := _strTokenAt(stl[i], '|', 6);

      agrLines.Cells[col_Item, i + 1] := s1;

      // -- If compressing rooms...
      if (sSalesItem = g.qRoomRentItem) then
        agrLines.Cells[col_Description, i + 1] := g.qLocalRoomRent
      else // -- If compressing phone...
        if (sSalesItem = g.qPhoneUseItem) then
          agrLines.Cells[col_Description, i + 1] := 'Phone use'
        else // -- If compressing Salesitems...
          agrLines.Cells[col_Description, i + 1] := 'Sales';

      agrLines.Cells[col_ItemCount, i + 1] := _floattostr(_StrToFloat(s3),
        vWidth, vDec); // -96
      agrLines.Cells[col_ItemPrice, i + 1] := _floattostr(_StrToFloat(s2),
        vWidth, vDec);
      agrLines.Cells[col_TotalPrice, i + 1] := _floattostr(_StrToFloat(s4),
        vWidth, vDec);
      agrLines.Cells[col_System, i + 1] := '';
      agrLines.Objects[col_Description, i] := TObject(trunc(now)); // -- PurchaseDate !
      agrLines.Objects[col_Item, i + 1] := TObject(i + 1); //

      // -- If compressing rooms...
      if (sSalesItem = g.qRoomRentItem) then
      begin
        RoomInfo := TRoomInfo.create;
        RoomInfo.FRoomReservation := -1;
        RoomInfo.FReservation := -1;
        RoomInfo.FName := edtName.Text;
        RoomInfo.FFrom := now;
        RoomInfo.FTo := now + 1;
        RoomInfo.FPrice := _StrToFloat(s2);
        RoomInfo.FNumPersons := trunc(_StrToFloat(s6));
        agrLines.Objects[col_ItemCount, i + 1] := RoomInfo;
        zLstRooms.add(RoomInfo);
      end
      else
        agrLines.Objects[col_ItemCount, i + 1] := nil;
    end;
    calcStayTax(publicReservation);
    SaveAnd(false);
  end;

var
  i: integer;
begin
  stl := TStringList.create;
  try
    for i := 1 to agrLines.RowCount - 1 do
    begin
      if (agrLines.Cells[col_Item, i] = sSalesItem) or
        ((sSalesItem = g.qRoomRentItem) and (agrLines.Cells[col_Item,
        i] = g.qDiscountItem)

        ) or ((sSalesItem = '*') and (isSystemLine(i) = false)) then
      begin
        AddThis(i);
      end;
    end;

    if stl.Count > 0 then
    begin
      ReplaceTheSelection;
    end;

  finally
    stl.free;
  end;
end;

procedure TfrmInvoice.LoadKreditLines;
var
  idx: integer;
  iCol: integer;

  Res: integer;
  RoomRes: integer;

  isRoomRent: boolean;
  isCurrencyInvoice: boolean;

  aItemPrice: Double;
  aTotalPrice: Double;
  aCurrencyValue: Double;

  totalStayTax: Double;
  totalStayTaxNights: integer;

  useStayTax: boolean;
  s: string;

  zrSet: TRoomerDataset;

begin
  if not zExit then
  begin
    zrSet := CreateNewDataSet;
    try

      (*
        Hér er verið að sækja upplýsingar á kreditreikning
        útfrá refrence númeri annars reiknings
      *)

      zCurrencyRate := 1.00;
      ClearObjects;
      ClearLines;

      s := '';
      s := s + 'SELECT * FROM invoiceheads ' + chr(10);
      s := s + ' WHERE InvoiceNumber = ' + inttostr(zRefNum) + chr(10);

      if zrSet.active then
        zrSet.close;
      try
        FreeAndNil(zrSet);
      Except
      end;
      zrSet := CreateNewDataSet;
      s := format(s, [zRefNum]);
      hData.rSet_bySQL(zrSet, s);

      zrSet.first;

      totalStayTax := 0;
      totalStayTaxNights := 0;

      if not zrSet.eof then
      begin
        zInvoiceNumber := zrSet.FieldByName('InvoiceNumber').asinteger;
        zInvoiceDate := _DBDateToDate(zrSet.FieldByName('InvoiceDate')
          .asString);

        rgrInvoiceType.itemIndex := 3;
        // := zResSet.FieldByName( 'InvoiceType' ).asInteger;
        rgrInvoiceType.Enabled := True;

        Res := zrSet.FieldByName('Reservation').asinteger;
        RoomRes := zrSet.FieldByName('RoomReservation').asinteger;
        GetInvoiceHeader(Res, RoomRes);

        totalStayTax := LocalFloatValue(zrSet.FieldByName('TotalStayTax')
          .asString);
        totalStayTaxNights := zrSet.FieldByName('TotalStayTaxNights').asinteger;

        edtRoomGuest.Text := GetMainGuestName(Res, RoomRes);

        FRoomReservation := RoomRes;
        publicReservation := Res;
        setControls;
      end
      else
      begin
        if not zExit then
        begin
          ShowMessage
            (format(GetTranslatedText('shTx_Invoice_ReferenceNumberNotFound'),
            [zRefNum]));
        end;
        zRefNum := 0;
        zCreditType := ctManual;
        zbDoingReference := false;
      end;

      // --
      DisplayMem(zrSet);
      DisplayGuestName(zrSet);

      useStayTax := ctrlGetBoolean('useStayTax');

      if RV_useStayTax(publicReservation) = false then
        useStayTax := false;

      if (useStayTax) and (totalStayTaxNights <> 0) then
      begin
        labLodgingTaxISK.caption := _floattostr(totalStayTax, vWidth, vDec);
        labLodgingTaxNights.caption := inttostr(totalStayTaxNights);
        // ATH float ?
        // if totalStayTaxNights <> 0 then labtaxNights.Caption := 'Nights.';
        if totalStayTaxNights <> 0 then
          labTaxNights.caption := GetTranslatedText('shTx_Invoice_Nights');
      end;

      // --
      iCol := 1;
      EmptyStringGrid(agrLines);
      agrLines.ColCount := 8;
      agrLines.RowCount := 2;

      agrLines.Cells[col_Item, 0] := 'Item';
      agrLines.Cells[col_Description, 0] := 'Text';
      agrLines.Cells[col_ItemCount, 0] := 'Number';
      agrLines.Cells[col_ItemPrice, 0] := 'Price';
      agrLines.Cells[col_TotalPrice, 0] := 'Total';
      agrLines.Cells[col_System, 0] := ' !';
      agrLines.Cells[col_Refrence, 0] := 'Reference';
      agrLines.Cells[col_Source, 0] := 'Source';

      zRoomRentPaymentInvoice := -1;

      edtCurrency.Text := zNativeCurrency;
      zCurrentCurrency := edtCurrency.Text;
      edtRate.Text := '1.00';

      // --
      s := '';
      s := s + 'SELECT * FROM invoicelines ';
      s := s + ' where InvoiceNumber = ' + inttostr(zRefNum);

      if zrSet.active then
        zrSet.close;
      hData.rSet_bySQL(zrSet, s);

      with zrSet do
      begin
        first;

        isCurrencyInvoice := trim(UPPERCASE(FieldByName('Currency').asString))
          <> trim(UPPERCASE(zNativeCurrency));

        // This is the same for all lines in invoice lines
        edtCurrency.Text := FieldByName('Currency').asString;
        aCurrencyValue := LocalFloatValue(FieldByName('CurrencyRate').asString);
        zCurrencyRate := aCurrencyValue;
        edtRate.Text := floattostr(zCurrencyRate);

        if aCurrencyValue = 0 then
          aCurrencyValue := 1;

        while not zrSet.eof do
        begin
          isRoomRent := Item_isRoomRent(trim(FieldByName('ItemId').asString));

          // This price is in local currency
          aItemPrice := LocalFloatValue(FieldByName('Price').asString);

          if (isCurrencyInvoice) and (isRoomRent) then
          begin
            aItemPrice := aItemPrice / aCurrencyValue;
          end;

          aTotalPrice := aItemPrice * GetFloatValue(FieldByName('Number'));
          // -96

          idx := AddLine(0, trim(FieldByName('ItemId').asString),
            trim(FieldByName('Description').asString),
            FieldByName('Number').asfloat, aItemPrice, aTotalPrice, trunc(now),
            false, '', '', FieldByName('isPackage').asBoolean,
            FieldByName('Persons').asinteger, FieldByName('confirmDate')
            .asdateTime, GetFloatValue(FieldByName('confirmAmount')),
            FieldByName('RoomReservationAlias').asinteger, _GetCurrentTick);
          inc(iCol);
          agrLines.RowCount := iCol;
          DisplayLine(iCol - 1, idx);
          Next;
        end;
      end;

      // DisplayTotalsKredit; //

      // calcStayTax(publicReservation);
      DisplayTotals;
      SetCurrentVisible;
    finally
      zrSet.free;
    end;
  end; // if zExit

  UpdateItemInvoiceLinesForTaxCalculations;

  if zrSet.active then
    zrSet.close;
end;

procedure TfrmInvoice.SetCustEdits;
begin
  edtCustomer.ReadOnly := rgrInvoiceType.itemIndex IN [0, 1, 2, 3, 4, 5];
  if rgrInvoiceType.itemIndex = 5 then
  begin
    edtCustomer.Text := ctrlGetString('RackCustomer');
  end;

  edtName.ReadOnly := rgrInvoiceType.itemIndex IN [0, 1, 2, 3];
  edtAddress1.ReadOnly := rgrInvoiceType.itemIndex IN [0, 1, 2, 3];
  edtAddress2.ReadOnly := rgrInvoiceType.itemIndex IN [0, 1, 2, 3];
  edtAddress3.ReadOnly := rgrInvoiceType.itemIndex IN [0, 1, 2, 3];
  edtAddress4.ReadOnly := rgrInvoiceType.itemIndex IN [0, 1, 2, 3];
end;

procedure TfrmInvoice.SetInvoiceIndex(const Value: integer);
begin
  IsInvoiceChanged;
  FInvoiceIndex := Value;
  CorrectInvoiceIndexRectangles;
  RemoveAllCheckboxes;
  LoadInvoice;
end;

procedure TfrmInvoice.pnlInvoiceIndex0Click(Sender: TObject);
begin
  InvoiceIndex := TsPanel(Sender).Tag;
end;

function TfrmInvoice.GetSelectedRows : TList<String>;
var i : Integer;
    check : Boolean;
begin
  result := TList<String>.Create;
  if AnyRowChecked then
  begin
    for i := 1 to agrLines.RowCount - 1 do
      if agrLines.HasCheckbox(col_Select, i) then
      begin
        agrLines.GetCheckBoxState(col_Select, i, check);
        if check then
          result.Add(agrLines.Cells[col_autogen, i]);
      end;
  end else
  if (agrLines.Row > 0) AND (agrLines.Row < agrLines.RowCount) then
    result.Add(agrLines.Cells[col_autogen, agrLines.Row]);

  RemoveAllCheckboxes;
//  CheckOrUncheckAll(False);
end;

function TfrmInvoice.IndexOfAutoGen(AutoGen : String) : Integer;
var i : Integer;
begin
  result := -1;
  for i := 1 to agrLines.RowCount - 1 do
    if agrLines.Cells[col_autogen, i] = AutoGen then
    begin
      result := i;
      Break;
    end;
end;

procedure TfrmInvoice.pnlInvoiceIndex0DragDrop(Sender, Source: TObject; X, Y: integer);
var list : TList<String>;
    i, l : Integer;
begin
  if (Source = agrLines) then
  begin
    list := GetSelectedRows;
    try
      for l := list.Count - 1 downto 0 do
      begin
        i := IndexOfAutoGen(list[l]);
        if i >= 0 then
        begin
          agrLines.Row := i;
          if isSystemLine(i) AND (trim(agrLines.Cells[col_Item, i])= g.qRoomRentItem) then
          begin
            MoveRoomToNewInvoiceIndex(i, TsPanel(Sender).Tag);
          end
          else
            MoveItemToNewInvoiceIndex(i, TsPanel(Sender).Tag);
        end;
      end;
    finally
      List.Free;
    end;
    RemoveAllCheckboxes;
    CheckCheckboxes;
  end else
  begin
    MoveDownpaymentToInvoiceIndex(TsPanel(Sender).Tag);
  end;
end;

procedure TfrmInvoice.pnlInvoiceIndex0DragOver(Sender, Source: TObject;
  X, Y: integer; State: TDragState; var Accept: boolean);
begin
  Accept := (Source = agrLines) OR (Source IS TcxDragControlObject);
end;

procedure TfrmInvoice.T1Click(Sender: TObject);
begin
  actItemToGroupInvoiceExecute(Sender);
end;

procedure TfrmInvoice.T3Click(Sender: TObject);
begin
  MoveRoomToGroupInvoice;
end;

procedure TfrmInvoice.T4Click(Sender: TObject);
begin
  MoveRoomToRoomInvoice;
end;

function TfrmInvoice.GetCustomerHeader(Res: integer): boolean;
var
  customer: string;
  aname: string;
  Address1: string;
  Address2: string;
  Address3: string;
  Address4: string;
  Country: string;
  PID: string;

  // rSet: TRoomerDataSet;
  // s: string;
  // sql : string;
begin
  // Ekki fyrir staðgreiðslureikninga
  result := false;
  if FnewSplitNumber = 2 then
    exit;
  if publicReservation = -1 then
    exit;

  customer := edtCustomer.Text;
  if glb.LocateSpecificRecord('customers', 'Customer', customer) then
    with glb.CustomersSet do
    begin
      aname := FieldByName('SurName').asString;
      Address1 := FieldByName('Address1').asString;
      Address2 := FieldByName('Address2').asString;
      Address3 := FieldByName('Address3').asString;
      Address4 := FieldByName('Address4').asString;
      Country := FieldByName('Country').asString;
      PID := FieldByName('PID').asString;

      edtCustomer.Text := trim(customer);
      edtName.Text := trim(aname);
      edtPersonalId.Text := trim(PID);
      edtAddress1.Text := trim(Address1);
      edtAddress2.Text := trim(Address2);
      edtAddress3.Text := trim(Address3);
      edtAddress4.Text := trim(Address4);
      zCountry := trim(Country);
      result := True;
    end;

  // sql :=
  // ' SELECT '+
  // '     Customer, '+
  // '     SurName, '+
  // '     Address1, '+
  // '     Address2, '+
  // '     Address3, '+
  // '     Address4, '+
  // '     Country, '+
  // '     PID '+
  // '   FROM '+
  // '     customers '+
  // '   WHERE '+
  // '      (Customer =  %s ) ' ;
  //
  // s := format(sql, [_db(Customer)]);
  // hData.rSet_bySQL(rSet, s);
  // rSet.first;
  // if rSet.RecordCount > 0 then
  // begin
  // name := rSet.FieldByName('SurName').asString;
  // Address1 := rSet.FieldByName('Address1').asString;
  // Address2 := rSet.FieldByName('Address2').asString;
  // Address3 := rSet.FieldByName('Address3').asString;
  // Address4 := rSet.FieldByName('Address4').asString;
  // Country := rSet.FieldByName('Country').asString;
  // PID := rSet.FieldByName('PID').asString;
  //
  // edtCustomer.Text   := trim(Customer);
  // edtName.Text       := trim(name);
  // edtPersonalId.Text := trim(PID);
  // edtAddress1.Text   := trim(Address1);
  // edtAddress2.Text   := trim(Address2);
  // edtAddress3.Text   := trim(Address3);
  // edtAddress4.Text   := trim(Address4);
  // zCountry := trim(Country);
  // result := true;
  // end;
  // finally
  // freeandNil(rSet);
  // end;
end;

function TfrmInvoice.GetInvoiceHeader(Res, RoomRes: integer): boolean;
var
  invoiceNumber: integer;
  customer: string;
  name: string;
  Address1: string;
  Address2: string;
  Address3: string;
  Address4: string;
  Country: string;
  CustPID: string;
  InvoiceType: integer;
  invRefrence: string;

  rSet: TRoomerDataset;
  s: string;
  sTmp: string;

begin
  result := false;

  if FnewSplitNumber = 2 then
    exit;

  result := false;
  if publicReservation = -1 then
    exit;


  // s := s + ' SELECT '+chr(10);
  // s := s + '     [Reservation], '+chr(10);
  // s := s + '     [RoomReservation], '+chr(10);
  // s := s + '     [InvoiceNumber], '+chr(10);
  // s := s + '     [Customer], '+chr(10);
  // s := s + '     [Name], '+chr(10);
  // s := s + '     [Address1], '+chr(10);
  // s := s + '     [Address2], '+chr(10);
  // s := s + '     [Address3], '+chr(10);
  // s := s + '     [Address4], '+chr(10);
  // s := s + '     [Country], '+chr(10);
  // s := s + '     [custPID], '+chr(10);
  // s := s + '     [invRefrence], '+chr(10);
  // s := s + '     [InvoiceType] '+chr(10);
  // s := s + '   FROM '+chr(10);
  // s := s + '     [InvoiceHeads] '+chr(10);
  // s := s + '   WHERE '+chr(10);
  // s := s + '      ([Reservation] = ' + inttostr(Res) + ') AND ([RoomReservation] = ' + inttostr(RoomRes) + ') '+chr(10);

  rSet := CreateNewDataSet;
  try
    s := format(select_Invoice_GetInvoiceHeader, [Res, RoomRes]);
    // CopyToClipboard(s);
    // DebugMessage('select_Invoice_GetInvoiceHeader'#10#10+s);
    hData.rSet_bySQL(rSet, s);

    invoiceNumber := -1;
    rSet.first;
    if rSet.RecordCount > 0 then
    begin
      invoiceNumber := rSet.FieldByName('InvoiceNumber').asinteger;
      customer := rSet.FieldByName('Customer').asString;
      name := rSet.FieldByName('Name').asString;
      Address1 := rSet.FieldByName('Address1').asString;
      Address2 := rSet.FieldByName('Address2').asString;
      Address3 := rSet.FieldByName('Address3').asString;
      Address4 := rSet.FieldByName('Address4').asString;
      Country := rSet.FieldByName('Country').asString;
      CustPID := rSet.FieldByName('custPID').asString;
      InvoiceType := rSet.FieldByName('InvoiceType').asinteger;
      invRefrence := rSet.FieldByName('invRefrence').asString;
    end;

    sTmp := d.IH_GetRefrence(-1, Res, RoomRes);

    if sTmp <> '' then
    begin
      invRefrence := sTmp;
    end;

    // Þ.e ekki frágengin reikningur
    if (invoiceNumber = -1) or (FCredit) then
    begin
      edtCustomer.Text := trim(customer);
      edtName.Text := trim(name);
      edtPersonalId.Text := trim(CustPID);
      edtAddress1.Text := trim(Address1);
      edtAddress2.Text := trim(Address2);
      edtAddress3.Text := trim(Address3);
      edtAddress4.Text := trim(Address4);
      edtInvRefrence.Text := trim(invRefrence);

      zCountry := trim(Country);
      result := True;
    end;
  finally
    FreeAndNil(rSet);
  end;
end;

function TfrmInvoice.GetInvoiceHeader(Res, RoomRes: integer; arSet : TRoomerDataset): boolean;
var
  invoiceNumber: integer;
  customer: string;
  name: string;
  Address1: string;
  Address2: string;
  Address3: string;
  Address4: string;
  Country: string;
  CustPID: string;
  InvoiceType: integer;
  invRefrence: string;
  FreeText : String;

  sTmp: string;

begin
  result := false;

  if FnewSplitNumber = 2 then
    exit;

  result := false;
  if publicReservation = -1 then
    exit;


  // s := s + ' SELECT '+chr(10);
  // s := s + '     [Reservation], '+chr(10);
  // s := s + '     [RoomReservation], '+chr(10);
  // s := s + '     [InvoiceNumber], '+chr(10);
  // s := s + '     [Customer], '+chr(10);
  // s := s + '     [Name], '+chr(10);
  // s := s + '     [Address1], '+chr(10);
  // s := s + '     [Address2], '+chr(10);
  // s := s + '     [Address3], '+chr(10);
  // s := s + '     [Address4], '+chr(10);
  // s := s + '     [Country], '+chr(10);
  // s := s + '     [custPID], '+chr(10);
  // s := s + '     [invRefrence], '+chr(10);
  // s := s + '     [InvoiceType] '+chr(10);
  // s := s + '   FROM '+chr(10);
  // s := s + '     [InvoiceHeads] '+chr(10);
  // s := s + '   WHERE '+chr(10);
  // s := s + '      ([Reservation] = ' + inttostr(Res) + ') AND ([RoomReservation] = ' + inttostr(RoomRes) + ') '+chr(10);

  invoiceNumber := -1;
  arSet.first;
  if NOT arSet.Eof then
  begin
    invoiceNumber := arSet.FieldByName('InvoiceNumber').asinteger;
    customer := arSet.FieldByName('Customer').asString;
    name := arSet.FieldByName('Name').asString;
    Address1 := arSet.FieldByName('Address1').asString;
    Address2 := arSet.FieldByName('Address2').asString;
    Address3 := arSet.FieldByName('Address3').asString;
    Address4 := arSet.FieldByName('Address4').asString;
    Country := arSet.FieldByName('Country').asString;
    CustPID := arSet.FieldByName('custPID').asString;
    InvoiceType := arSet.FieldByName('InvoiceType').asinteger;
    invRefrence := arSet.FieldByName('invRefrence').asString;
    FreeText := arSet.FieldByName('ExtraText').asString;
  end;

  sTmp := d.IH_GetRefrence(-1, Res, RoomRes);

  if sTmp <> '' then
  begin
    invRefrence := sTmp;
  end;

  // Þ.e ekki frágengin reikningur
  if (invoiceNumber = -1) or (FCredit) then
  begin
    edtCustomer.Text := trim(customer);
    edtName.Text := trim(name);
    edtPersonalId.Text := trim(CustPID);
    edtAddress1.Text := trim(Address1);
    edtAddress2.Text := trim(Address2);
    edtAddress3.Text := trim(Address3);
    edtAddress4.Text := trim(Address4);
    edtInvRefrence.Text := trim(invRefrence);
    memExtraText.Lines.Text := trim(FreeText);

    zCountry := trim(Country);
    result := True;
  end;
end;

function TfrmInvoice.GetInvoiceHeader(Res, RoomRes: integer;
  arSet: TdxMemData): boolean;
var
  invoiceNumber: integer;
  customer: string;
  name: string;
  Address1: string;
  Address2: string;
  Address3: string;
  Address4: string;
  Country: string;
  CustPID: string;
  InvoiceType: integer;
  invRefrence: string;

  rSet: TdxMemData;
  sTmp: string;

begin
  result := false;

  if FnewSplitNumber = 2 then
    exit;

  result := false;
  if publicReservation = -1 then
    exit;


  // s := s + ' SELECT '+chr(10);
  // s := s + '     [Reservation], '+chr(10);
  // s := s + '     [RoomReservation], '+chr(10);
  // s := s + '     [InvoiceNumber], '+chr(10);
  // s := s + '     [Customer], '+chr(10);
  // s := s + '     [Name], '+chr(10);
  // s := s + '     [Address1], '+chr(10);
  // s := s + '     [Address2], '+chr(10);
  // s := s + '     [Address3], '+chr(10);
  // s := s + '     [Address4], '+chr(10);
  // s := s + '     [Country], '+chr(10);
  // s := s + '     [custPID], '+chr(10);
  // s := s + '     [invRefrence], '+chr(10);
  // s := s + '     [InvoiceType] '+chr(10);
  // s := s + '   FROM '+chr(10);
  // s := s + '     [InvoiceHeads] '+chr(10);
  // s := s + '   WHERE '+chr(10);
  // s := s + '      ([Reservation] = ' + inttostr(Res) + ') AND ([RoomReservation] = ' + inttostr(RoomRes) + ') '+chr(10);

  invoiceNumber := -1;

  rSet := arSet;
  rSet.first;
  if rSet.RecordCount > 0 then
  begin
    invoiceNumber := rSet.FieldByName('InvoiceNumber').asinteger;
    customer := rSet.FieldByName('Customer').asString;
    name := rSet.FieldByName('Name').asString;
    Address1 := rSet.FieldByName('Address1').asString;
    Address2 := rSet.FieldByName('Address2').asString;
    Address3 := rSet.FieldByName('Address3').asString;
    Address4 := rSet.FieldByName('Address4').asString;
    Country := rSet.FieldByName('Country').asString;
    CustPID := rSet.FieldByName('custPID').asString;
    InvoiceType := rSet.FieldByName('InvoiceType').asinteger;
    invRefrence := rSet.FieldByName('invRefrence').asString;
  end;

  sTmp := rSet.FieldByName('invRefrence').asString;

  if sTmp <> '' then
  begin
    invRefrence := sTmp;
  end;

  // Þ.e ekki frágengin reikningur
  if (invoiceNumber = -1) or (FCredit) then
  begin
    edtCustomer.Text := trim(customer);
    edtName.Text := trim(name);
    edtPersonalId.Text := trim(CustPID);
    edtAddress1.Text := trim(Address1);
    edtAddress2.Text := trim(Address2);
    edtAddress3.Text := trim(Address3);
    edtAddress4.Text := trim(Address4);
    edtInvRefrence.Text := trim(invRefrence);

    zCountry := trim(Country);
    result := True;
  end;
end;

function TfrmInvoice.GetReservationHeader(Res, RoomRes: integer): boolean;
var

  customer: string;
  name: string;
  Address1: string;
  Address2: string;
  Address3: string;
  Address4: string;
  Country: string;
  CustPID: string;
  invRefrence: string;

  rSet: TRoomerDataset;
  s: string;
  sTmp: string;

begin
  result := false;

  if FnewSplitNumber = 2 then
    exit;

  if publicReservation = -1 then
    exit;

  // s := '';
  //
  // s := s + ' SELECT '+chr(10);
  // s := s + '     [Reservation], '+chr(10);
  // s := s + '     [Customer], '+chr(10);
  // s := s + '     [Name], '+chr(10);
  // s := s + '     [Address1], '+chr(10);
  // s := s + '     [Address2], '+chr(10);
  // s := s + '     [Address3], '+chr(10);
  // s := s + '     [Address4], '+chr(10);
  // s := s + '     [Country], '+chr(10);
  // s := s + '     [custPID],  '+chr(10);
  // s := s + '     [invRefrence]  '+chr(10);
  // s := s + '   FROM '+chr(10);
  // s := s + '     [Reservations] '+chr(10);
  // s := s + '   WHERE '+chr(10);
  // s := s + '      ([Reservation] = ' + inttostr(Res) + ')  '+chr(10);

    rSet := CreateNewDataSet;

  try
    s := format(select_Invoice_GetReservationHeader, [Res]);
    hData.rSet_bySQL(rSet, s);
    rSet.first;

    if not rSet.eof then
    begin
      customer := rSet.FieldByName('Customer').asString;
      name := rSet.FieldByName('Name').asString;
      Address1 := rSet.FieldByName('Address1').asString;
      Address2 := rSet.FieldByName('Address2').asString;
      Address3 := rSet.FieldByName('Address3').asString;
      Address4 := rSet.FieldByName('Address4').asString;
      Country := rSet.FieldByName('Country').asString;
      CustPID := rSet.FieldByName('custPID').asString;
      invRefrence := rSet.FieldByName('invRefrence').asString;
    end;

    sTmp := d.IH_GetRefrence(-1, Res, RoomRes);

    if sTmp <> '' then
    begin
      invRefrence := sTmp;
    end;

    edtCustomer.Text := trim(customer);
    edtName.Text := trim(name);
    edtPersonalId.Text := trim(CustPID);
    edtAddress1.Text := trim(Address1);
    edtAddress2.Text := trim(Address2);
    edtAddress3.Text := trim(Address3);
    edtAddress4.Text := trim(Address4);
    edtInvRefrence.Text := trim(invRefrence);
    zCountry := trim(Country);

    result := True;
  finally
    FreeAndNil(rSet);
  end;
end;

procedure TfrmInvoice.GuestName1Click(Sender: TObject);
var
  s: string;
begin
  s := edtRoomGuest.Text;
  CopyToClipboard(s);
end;

function TfrmInvoice.GetMainGuestHeader(Res, RoomRes: integer): boolean;
var
  Person: integer;
  name: string;
  Address1: string;
  Address2: string;
  Address3: string;
  Address4: string;
  Country: string;
  PID: string;

  rSet: TRoomerDataset;
  s: string;
  sql: string;

begin
  result := false;
  if FnewSplitNumber = 2 then
    exit;

  if publicReservation = -1 then
    exit;

  rSet := CreateNewDataSet;
  try
    sql := ' SELECT ' + '     Person ' + '   , RoomReservation ' +
      '   , Reservation ' + '   , Name ' + '   , Address1 ' + '   , Address2 ' +
      '   , Address3 ' + '   , Address4 ' + '   , Country  ' + '   , PID ' +
      ' FROM ' + '   persons ' + '   WHERE ' +
      '      (Reservation = %d) AND (RoomReservation = %d) ';
    s := format(sql, [Res, RoomRes]);
    hData.rSet_bySQL(rSet, s);

    rSet.first;
    name := '';
    Address1 := '';
    Address2 := '';
    Address3 := '';
    Address4 := '';
    Country := '';

    if not rSet.eof then
    begin
      Person := rSet.FieldByName('Person').asinteger;
      name := rSet.FieldByName('Name').asString;
      Address1 := rSet.FieldByName('Address1').asString;
      Address2 := rSet.FieldByName('Address2').asString;
      Address3 := rSet.FieldByName('Address3').asString;
      Address4 := rSet.FieldByName('Address4').asString;
      Country := rSet.FieldByName('Country').asString;
      PID := rSet.FieldByName('PID').asString;
    end;

    edtCustomer.Text := ctrlGetString('RackCustomer');
    edtName.Text := trim(name);
    edtPersonalId.Text := trim(PID);
    edtAddress1.Text := trim(Address1);
    edtAddress2.Text := trim(Address2);
    edtAddress3.Text := trim(Address3);
    edtAddress4.Text := trim(Address4);
    zCountry := trim(Country);
    result := True;
  finally
    FreeAndNil(rSet);
  end;
end;

function TfrmInvoice.GetMainGuestName(Res, RoomRes: integer): string;
var
  name: string;
  rSet: TRoomerDataset;
  s: string;
  sql: string;
begin
  result := '';
  if publicReservation = -1 then
    exit;
  if FnewSplitNumber = 2 then
    exit;

  rSet := CreateNewDataSet;
  try
    sql := ' SELECT ' + '    Name ' + ' FROM ' + '   persons ' + ' WHERE ' +
      '   (Reservation = %d) AND (RoomReservation = %d) ';
    s := format(sql, [Res, RoomRes]);
    hData.rSet_bySQL(rSet, s);
    rSet.first;
    if NOT rSet.eof then
    begin
      name := rSet.FieldByName('Name').asString;
      result := trim(name);
    end;
  finally
    FreeAndNil(rSet);
  end;
end;

procedure TfrmInvoice.rgrInvoiceTypeClick(Sender: TObject);
var
  s: string;
  sCustomer: string;
  rSetTemp: TRoomerDataset;

begin
  s := edtPersonalId.Text;
  sCustomer := edtCustomer.Text;
  rSetTemp := nil;

  memUpdateDone := false;
  zDataChanged := chkChanged;

  SetCustEdits;

  case rgrInvoiceType.itemIndex of
    0:
      begin
        GetCustomerHeader(publicReservation);
      end;
    1:
      begin
        GetReservationHeader(publicReservation, FRoomReservation);
      end;
    2:
      begin
        GetMainGuestHeader(publicReservation, FRoomReservation);
      end;
    3:
      begin
        GetInvoiceHeader(publicReservation, FRoomReservation);
      end;
    4:
      begin
        // GetReservationHeader(publicReservation);
      end;
    5:
      begin
        edtCustomer.Text := ctrlGetString('RackCustomer');
        edtPersonalId.Text := '';
        edtName.Text := 'Invoice';
        edtAddress1.Text := '';
        edtAddress2.Text := '';
        edtAddress3.Text := '';
        edtAddress4.Text := '';
      end;

  end;

  edtRoomGuest.Text := GetMainGuestName(publicReservation, FRoomReservation);

end;

procedure TfrmInvoice.SaveAnd(doExit: boolean);
begin
  try
    if zDoSave then
    begin
      SaveInvoice(zInvoiceNumber);
    end;
  except
  end;
  zDataChanged := chkChanged;
  if doExit then
    close;
end;

procedure TfrmInvoice.actSaveAndExitExecute(Sender: TObject);
begin
  SaveAnd(True);
end;

procedure TfrmInvoice.actPrintInvoiceExecute(Sender: TObject);
var
  ok: boolean;
begin
  if pageMain.ActivePageIndex = 1 then
  begin
    ShowMessage(GetTranslatedText('shTx_Invoice_PPNotAllowed'));
    exit;
  end;

  ok := hData.CustomerExist(trim(edtCustomer.Text));

  if not ok then
  begin
    MessageDlg('Customer not found', mtError, [mbOk], 0);
    exit
  end;

  if PayInvoiceAndPrint then
    close;
end;

procedure TfrmInvoice.actPrintProformaExecute(Sender: TObject);
begin
  if pageMain.ActivePageIndex = 1 then
  begin
    ShowMessage(GetTranslatedText('shTx_Invoice_PrintAndPay'));
    exit;
  end;
  PrintProforma;
end;

procedure TfrmInvoice.btnEditDownPaymentClick(Sender: TObject);
var
  rSet: TRoomerDataset;
  rec: recDownPayment;
  s: string;
  id: integer;
  sql: string;
begin
  // **
  if mPayments.RecordCount = 0 then
  begin
    exit;
  end;

  g.initRecDownPayment(rec);

  if edtBalance.Text <> '' then
    rec.InvoiceBalance := _StrToFloat(edtBalance.Text) +
      _StrToFloat(edtDownPayments.Text);

  rec.reservation := publicReservation;
  rec.RoomReservation := FRoomReservation;
  rec.Invoice := zInvoiceNumber;
  rec.Amount := mPayments.FieldByName('Amount').asfloat;
  rec.Quantity := 1;
  rec.Description := mPayments.FieldByName('Description').asString;
  rec.Notes := mPayments.FieldByName('Memo').asString;
  rec.PaymentType := mPayments.FieldByName('PayType').asString;
  rec.PayDate := mPayments.FieldByName('PayDate').asdateTime;
  rec.payGroup := mPayments.FieldByName('PayGroup').asString;
  rec.confirmDate := mPayments.FieldByName('Confirmdate').asdateTime;

  id := mPayments.FieldByName('ID').asinteger;

  if rec.confirmDate < 3 then
  begin
    if OpenAssignPayment(id) then
    begin
      rSet := CreateNewDataSet;
      try
        mPayments.close;
        mPayments.Open;

        sql := 'SELECT * FROM payments ' + ' where Reservation = %d ' +
          '   and RoomReservation = %d ' +
          '   and InvoiceNumber = -1 AND InvoiceIndex=%d';
        s := format(sql, [publicReservation, FRoomReservation, FInvoiceIndex]);
        if rSet_bySQL(rSet, s) then
        begin
          while not rSet.eof do
          begin
            mPayments.insert;
            mPayments.FieldByName('PayType').asString :=
              rSet.FieldByName('PayType').asString;
            mPayments.FieldByName('PayDate').asdateTime :=
              _DBDateToDate(rSet.FieldByName('PayDate').asString);
            mPayments.FieldByName('Amount').asfloat :=
              rSet.FieldByName('Amount').asfloat;
            mPayments.FieldByName('Description').asString :=
              rSet.FieldByName('Description').asString;
            mPayments.FieldByName('PayGroup').asString := '';
            mPayments.FieldByName('Memo').asString :=
              rSet.FieldByName('Notes').asString;
            mPayments.FieldByName('confirmDate').asdateTime :=
              rSet.FieldByName('Confirmdate').asdateTime;
            mPayments.FieldByName('Id').asinteger := rSet.FieldByName('ID')
              .asinteger;
            if glb.Paytypesset.Locate('payType', rSet.FieldByName('PayType')
              .asString, []) then
            begin
              mPayments.FieldByName('PayGroup').asString :=
                glb.Paytypesset.FieldByName('payGroup').asString;
            end;
            mPayments.post;
            rSet.Next;
          end;
        end;
      finally
        FreeAndNil(rSet);
      end;
      mPayments.Locate('id', id, []);
      DisplayTotals;
    end;

    // if g.OpenDownPayment(actInsert, Rec) then
    // begin
    // // Edit
    // s := '';
    // s := s + ' UPDATE payments ' + #10;
    // s := s + ' SET ' + #10;
    // s := s + '      amount  = ' + _db(Rec.Amount) + ' ' + #10;
    // s := s + '   ,  description  = ' + _db(Rec.Description) + ' ' + #10;
    // s := s + '   ,  notes  = ' + _db(Rec.Notes) + ' ' + #10;
    // s := s + '   ,  paytype  = ' + _db(Rec.PaymentType) + ' ' + #10;
    // s := s + ' WHERE ' + #10;
    // s := s + '   Id = (' + _db(id) + ') ' + #10;
    //
    // if cmd_bySQL(s) then
    // begin
    // mPayments.edit;
    // mPayments.FieldByName('Amount').AsFloat := Rec.Amount;
    // mPayments.FieldByName('Description').asString := Rec.Description;
    // mPayments.FieldByName('Memo').asString := Rec.Notes;
    // mPayments.FieldByName('PayType').asString := Rec.PaymentType;
    // mPayments.post;
    // DisplayTotals;
    // end;

    // end;
  end
  else
  begin
    ShowMessage('It is not allowed to change confirmed payments');
  end;
end;


procedure TfrmInvoice.MoveDownpaymentToInvoiceIndex(toInvoiceIndex : Integer);
var
  rec: recDownPayment;
  id: integer;
  s: string;
begin
  // **
  if mPayments.RecordCount = 0 then
  begin
    exit;
  end;

  rec.reservation := publicReservation;
  rec.RoomReservation := FRoomReservation;
  rec.Invoice := zInvoiceNumber;
  rec.Amount := mPayments.FieldByName('Amount').asfloat;
  rec.Quantity := 1;
  rec.Description := mPayments.FieldByName('Description').asString;
  rec.Notes := mPayments.FieldByName('Memo').asString;
  rec.PaymentType := mPayments.FieldByName('PayType').asString;
  rec.PayDate := mPayments.FieldByName('PayDate').asdateTime;
  rec.payGroup := mPayments.FieldByName('PayGroup').asString;
  rec.confirmDate := mPayments.FieldByName('Confirmdate').asdateTime;

  id := mPayments.FieldByName('ID').asinteger;

  if (rec.confirmDate < 3) and (id > 0) then
  begin
      s := ' UPDATE payments SET InvoiceIndex=' + inttostr(toInvoiceIndex) + ' '#10;
      s := s + ' WHERE  Id = (' + _db(id) + ') ' + #10;

      if cmd_bySQL(s) then
      begin
        mPayments.delete;
        try
          AddInvoiceActivityLog(g.qUser, rec.reservation, rec.RoomReservation, 1
            // field typeindex 0 = invoice payment 1 = downpayment
            , DELETE_PAYMENT, rec.PaymentType, rec.Amount, zInvoiceNumber,
            rec.Description);
        Except

        end;

      end;

      DisplayTotals;
  end
  else
  begin
    ShowMessage('It is not allowed to Delete confirmed payments');
  end;
end;

procedure TfrmInvoice.btnDeleteDownpaymentClick(Sender: TObject);
var
  rec: recDownPayment;
  id: integer;
  s: string;
begin
  // **
  if mPayments.RecordCount = 0 then
  begin
    exit;
  end;

  g.initRecDownPayment(rec);

  rec.reservation := publicReservation;
  rec.RoomReservation := FRoomReservation;
  rec.Invoice := zInvoiceNumber;
  rec.Amount := mPayments.FieldByName('Amount').asfloat;
  rec.Quantity := 1;
  rec.Description := mPayments.FieldByName('Description').asString;
  rec.Notes := mPayments.FieldByName('Memo').asString;
  rec.PaymentType := mPayments.FieldByName('PayType').asString;
  rec.PayDate := mPayments.FieldByName('PayDate').asdateTime;
  rec.payGroup := mPayments.FieldByName('PayGroup').asString;
  rec.confirmDate := mPayments.FieldByName('Confirmdate').asdateTime;

  id := mPayments.FieldByName('ID').asinteger;

  if (rec.confirmDate < 3) and (id > 0) then
  begin
    if MessageDlg('Delete payment ?'#10 + rec.Description + ' / Amount ' +
      _floattostr(rec.Amount, vWidth, vDec), mtConfirmation,
      [mbYes, mbNo, mbCancel], 0) = mrYes then
    begin
      mPayments.delete;
      s := '';
      s := s + ' DELETE FROM payments '#10;
      s := s + ' WHERE  Id = (' + _db(id) + ') ' + #10;

      if cmd_bySQL(s) then
      begin
        try
          AddInvoiceActivityLog(g.qUser, rec.reservation, rec.RoomReservation, 1
            // field typeindex 0 = invoice payment 1 = downpayment
            , DELETE_PAYMENT, rec.PaymentType, rec.Amount, zInvoiceNumber,
            rec.Description);
        Except

        end;

      end;

      DisplayTotals;
    end;
  end
  else
  begin
    ShowMessage('It is not allowed to Delete confirmed payments');
  end;
end;

procedure TfrmInvoice.actDownPaymentExecute(Sender: TObject);
var
  rec: recDownPayment;
  theData: recPaymentHolder;
  NewId: integer;

begin
  g.initRecDownPayment(rec);

  rec.reservation := publicReservation;
  rec.RoomReservation := FRoomReservation;
  rec.Invoice := zInvoiceNumber;
  rec.Amount := 0;

  if (rec.reservation = 0) and (rec.RoomReservation = 0) then
  begin
    ShowMessage('You cannot add downpayment to a cash invoive');
    exit;
  end;

  if edtBalance.Text <> '' then
    rec.InvoiceBalance := _StrToFloat(edtBalance.Text);

  if g.OpenDownPayment(actInsert, rec) then
  begin
    // memExtraText.Lines.Add('Amount      : ' +floattostr(rec.Amount));
    // memExtraText.Lines.Add('Quantity    : '+floattostr(rec.Quantity));
    // memExtraText.Lines.Add('Notes       : '+rec.Notes);
    // memExtraText.Lines.Add('Description : '+rec.Description);
    // memExtraText.Lines.Add('Payment     : '+rec.PaymentType);

    // insert payment

    initPaymentHolderRec(theData);

    theData.reservation := publicReservation;
    theData.RoomReservation := FRoomReservation;
    theData.Person := FnewSplitNumber;
    theData.TypeIndex := ORD(ptDownPayment);
    theData.invoiceNumber := zInvoiceNumber;
    theData.customer := edtCustomer.Text;
    theData.PayDate := _DateToDbDate(Date, false);
    theData.Amount := rec.Amount;
    theData.Description := rec.Description;
    theData.CurrencyRate := zCurrencyRate; // ATH
    theData.Currency := zCurrentCurrency;
    theData.confirmDate := 2; // _db('1900-01-01 00:00:00');
    theData.Notes := rec.Notes;
    theData.PayType := rec.PaymentType;
    theData.invoiceIndex := InvoiceIndex;

    NewId := 0;
    if INS_Payment(theData, NewId) then
    begin
      mPayments.insert;
      mPayments.FieldByName('PayType').asString := rec.PaymentType;
      mPayments.FieldByName('PayDate').asdateTime := Date;
      mPayments.FieldByName('Amount').asfloat := rec.Amount;
      mPayments.FieldByName('Description').asString := rec.Description;
      if glb.Paytypesset.Locate('payType', rec.PaymentType, []) then
      begin
        mPayments.FieldByName('PayGroup').asString :=
          glb.Paytypesset.FieldByName('payGroup').asString;
      end;
      mPayments.FieldByName('Memo').asString := rec.Notes;
      mPayments.FieldByName('confirmDate').asdateTime := theData.confirmDate;
      mPayments.FieldByName('ID').asinteger := NewId;

      mPayments.post;
      DisplayTotals;
    end;
  end;

end;

procedure TfrmInvoice.actInfoExecute(Sender: TObject);
begin
  if g.openresMemo(publicReservation) then
  begin
  end;
end;

procedure TfrmInvoice.actAddPackageExecute(Sender: TObject);
begin
  // **
end;

procedure TfrmInvoice.actAddLineExecute(Sender: TObject);
begin
  agrLines.row := agrLines.RowCount - 1;
  agrLines.Col := 0;
  itemLookup;
end;

procedure TfrmInvoice.actDelLineExecute(Sender: TObject);
var list : TList<String>;
    i, l, id : Integer;
    s : String;
begin
  // if MessageDlg('Delete item ', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  if AnyRowChecked then
    s := GetTranslatedText('shTx_Invoice_DeleteSelectedItems')
  else
    s := GetTranslatedText('shTx_Invoice_DeleteItem');
  if MessageDlg(s, mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
  begin
    list := GetSelectedRows;
    try
      for l := list.Count - 1 downto 0 do
      begin
        i := IndexOfAutoGen(list[l]);
        if i >= 0 then
        begin
          agrLines.Row := i;
          id := CellInvoiceLineId(i);
          if id > 0 then
            DeletedLines.Add(id);
          DeleteRow(agrLines, agrLines.row);
          AddEmptyLine;
          zDataChanged := chkChanged;
        end;
      end;
    finally
      list.Free;
    end;
    calcStayTax(publicReservation);
    setControls;
  end;
end;

procedure TfrmInvoice.actRRtoTempExecute(Sender: TObject);
var
  CurrentRow: integer;
  sRoomRentItem: string;
  sDiscountItem: string;
  sCurrentItem: string;
  list : TList<String>;
  i, l : Integer;
begin
  // if MessageDlg('Set room to temp ', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
  if MessageDlg(GetTranslatedText('shTx_Invoice_SetTemp'), mtConfirmation,
    [mbYes, mbNo], 0) <> mrYes then
  begin
    exit;
  end;

  list := GetSelectedRows;
  try
    for l := list.Count - 1 downto 0 do
    begin
      i := IndexOfAutoGen(list[l]);
      if i >= 0 then
      begin
//        agrLines.Row := i;
        CurrentRow := i;

        sRoomRentItem := _trimlower(g.qRoomRentItem);
        sDiscountItem := _trimlower(g.qDiscountItem);
        sCurrentItem := _trimlower(agrLines.Cells[col_Item, CurrentRow]);

        agrLines.row := 1;
        agrLines.Col := 0;
        CurrentRow := 0;

        repeat
          inc(CurrentRow);
          sCurrentItem := _trimlower(agrLines.Cells[col_Item, CurrentRow]);

          if (sCurrentItem = sRoomRentItem) or (sCurrentItem = sDiscountItem) then
          begin
            zRoomIsInTemp := True;
            DeleteRow(agrLines, CurrentRow);
            AddEmptyLine;
            zDataChanged := chkChanged;
            CurrentRow := 0;
            agrLines.row := 1;
            zbRoomRentinTemp := True;
          end;
        until (CurrentRow = agrLines.RowCount - 1);
      end;
    end;
  finally
    list.Free;
  end;
  calcStayTax(publicReservation);
  RemoveAllCheckboxes;
  CheckCheckboxes;
end;

procedure TfrmInvoice.ItemToTemp(confirm : Boolean);
var
  reservation: integer;
  RoomReservation: integer;
  SplitNumber: integer;
  PurchaseDate: TDateTime;
  invoiceNumber: integer;
  itemNumber: integer;
  itemId: string; // (10)

  Number: Double; // -96

  Description: string; // (70)
  Price: Double;
  VATType: string; // (10)
  Total: Double;
  TotalWOVat: Double;
  Vat: Double;
  CurrencyRate: Double;
  Currency: string; // (5)
  Persons: integer;
  Nights: integer;
  importRefrence: string;
  ImportSource: string;

  // ***

  s: string;
  CurrentRow: integer;
  ItemTypeInfo: TItemTypeInfo;

  isPackage: boolean;

  lInvRoom: TInvoiceRoomEntity;

begin
  isPackage := false;

  CurrentRow := agrLines.row;
  if isSystemLine(CurrentRow) then
  begin
    ShowMessage(GetTranslatedText('shTx_Invoice_SaleNotSelected'));
    exit;
  end;

  reservation := publicReservation;
  RoomReservation := FRoomReservation;
  SplitNumber := 0; // Alltaf 0
  PurchaseDate := integer(agrLines.Objects[col_Description, CurrentRow]);
  invoiceNumber := zInvoiceNumber;
  itemNumber := CurrentRow;

  itemId := trim(agrLines.Cells[col_Item, CurrentRow]);

  if itemId = '' then
  begin
    ShowMessage(GetTranslatedText('shTx_Invoice_EmptyInvoice'));
    exit;
  end;

  Description := trim(agrLines.Cells[col_Description, CurrentRow]); // (70)
  importRefrence := trim(agrLines.Cells[col_Refrence, CurrentRow]);
  ImportSource := trim(agrLines.Cells[col_Source, CurrentRow]);

  // if MessageDlg('Take [' + itemId + '] from invoice ', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
  if confirm AND (MessageDlg(format(GetTranslatedText('shTx_Invoice_TakeItemFromInvoice'),
    [itemId]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then
  begin
    exit;
  end;

  Number := 0;
  s := trim(agrLines.Cells[col_ItemCount, CurrentRow]);
  try
    Number := _StrToFloat(s); // -96
  except
    Number := 0.00;
  end;

  s := trim(agrLines.Cells[col_ItemPrice, CurrentRow]);
  Price := _StrToFloat(s); // Was StrToFloatDef()

  s := trim(agrLines.Cells[col_TotalPrice, CurrentRow]);
  Total := _StrToFloat(s); // Was StrToFloatDef()

  ItemTypeInfo := d.Item_Get_ItemTypeInfo(itemId);
  VATType := ItemTypeInfo.VATCode;

  lInvRoom := TInvoiceRoomEntity.create(agrLines.Cells[col_Item, CurrentRow], 1,
                                        _StrToFloat(agrLines.Cells[col_ItemCount, CurrentRow]), Total, 0, 0);
  try
    Vat := GetVATForItem(agrLines.Cells[col_Item, CurrentRow], Total,
                        _StrToFloat(agrLines.Cells[col_ItemCount, CurrentRow]), lInvRoom,
                        tempInvoiceItemList, ItemTypeInfo, edtCustomer.Text);
  finally
    lInvRoom.Free;
  end;
  // Formula
  // Vat := Total / (1 + (ItemTypeInfo.VATPercentage / 100));
  // Vat := Total - Vat;
  TotalWOVat := Total - Vat;

  Currency := edtCurrency.Text;
  CurrencyRate := GetRate(Currency);
  edtRate.Text := floattostr(CurrencyRate);

  Persons := 0;
  Nights := 0;
  if agrLines.Objects[col_ItemCount, CurrentRow] <> nil then
  begin
    Persons := TRoomInfo(agrLines.Objects[col_ItemCount, CurrentRow]).FNumPersons;
    Nights := trunc(TRoomInfo(agrLines.Objects[col_ItemCount, CurrentRow]).FTo) -
      trunc(TRoomInfo(agrLines.Objects[col_ItemCount, CurrentRow]).FFrom);
  end;

  d.kbmInvoicelines.insert;
  d.kbmInvoicelines.FieldByName('Reservation').asinteger := publicReservation;
  d.kbmInvoicelines.FieldByName('RoomReservation').asinteger :=
    FRoomReservation;
  d.kbmInvoicelines.FieldByName('SplitNumber').asinteger := 0;
  d.kbmInvoicelines.FieldByName('ItemNumber').asinteger := itemNumber;
  d.kbmInvoicelines.FieldByName('PurchaseDate').asdateTime := PurchaseDate;
  d.kbmInvoicelines.FieldByName('InvoiceNumber').asinteger := invoiceNumber;
  d.kbmInvoicelines.FieldByName('ItemId').asString := itemId;
  d.kbmInvoicelines.FieldByName('Number').asfloat := Number;
  d.kbmInvoicelines.FieldByName('Description').asString := Description;
  d.kbmInvoicelines.FieldByName('Price').asfloat := Price;
  d.kbmInvoicelines.FieldByName('VATType').asString := VATType;
  d.kbmInvoicelines.FieldByName('Total').asfloat := Total;
  d.kbmInvoicelines.FieldByName('TotalWOVat').asfloat := TotalWOVat;
  d.kbmInvoicelines.FieldByName('VAT').asfloat := Vat;
  d.kbmInvoicelines.FieldByName('CurrencyRate').asfloat := CurrencyRate;
  d.kbmInvoicelines.FieldByName('Currency').asString := Currency;
  d.kbmInvoicelines.FieldByName('Persons').asinteger := Persons;
  d.kbmInvoicelines.FieldByName('Nights').asinteger := Nights;
  d.kbmInvoicelines.FieldByName('BreakfastPrice').asfloat := 0.00;
  d.kbmInvoicelines.FieldByName('ImportSource').asString := ImportSource;
  d.kbmInvoicelines.FieldByName('importRefrence').asString := importRefrence;
  d.kbmInvoicelines.FieldByName('isPackage').asBoolean := isPackage;
  d.kbmInvoicelines.post;

  labTmpStatus.caption := inttostr(d.kbmInvoicelines.RecordCount);

  if isSystemLine(agrLines.row) then
    // raise Exception.create('System item can not delete ');
    raise Exception.create(GetTranslatedText('shTx_Invoice_CanNotDelete'));

  DeleteRow(agrLines, agrLines.row);
  AddEmptyLine;
  calcStayTax(publicReservation);
  zDataChanged := chkChanged;
end;

procedure TfrmInvoice.actItemToTempExecute(Sender: TObject);
var list : TList<String>;
    i, l : Integer;
begin
  list := GetSelectedRows;
  try
    for l := list.Count - 1 downto 0 do
    begin
      i := IndexOfAutoGen(list[l]);
      if i >= 0 then
      begin
        agrLines.Row := i;
        ItemToTemp(l = list.Count - 1);
      end;
    end;
  finally
    list.Free;
  end;
end;

function TfrmInvoice.RoomByRoomReservation(RoomReservation: integer): String;
var
  i: integer;
begin
  result := inttostr(RoomReservation);
  for i := 0 to SelectableRooms.Count - 1 do
  begin
    if SelectableRooms[i].FRoomReservation = RoomReservation then
    begin
      result := SelectableRooms[i].FRoom;
      break;
    end;
  end;
end;

procedure TfrmInvoice.MoveItemToRoomInvoice(toRoomReservation: integer;
  InvoiceIndex: integer);
var
  reservation: integer;
  RoomReservation: integer;
  SplitNumber: integer;
  invoiceNumber: integer;
  itemNumber: integer;
  itemId: string; // (10)

  Description: string; // (70)

  s: string;
  CurrentRow: integer;

  NextInvoiceLine: integer;
  RoomNumber: string;

  Btn: Word;

  rSet: TRoomerDataset;

  ItemTypeInfo: TItemTypeInfo;

  Total: Double;
  TotalWOVat: Double;
  TotalVAT: Double;
  sTotal: string;

  UpdateOk: boolean;

  err: string;

  lInvRoom: TInvoiceRoomEntity;

begin
  err := '';
  UpdateOk := false;

  Total := 0;
  TotalWOVat := 0;
  TotalVAT := 0;

  // if FRoomReservation = toRoomReservation then
  // begin
  // showmessage(GetTranslatedText('shTx_Invoice_RoomInvoice'));
  // exit;
  // end;
  zDataChanged := chkChanged;

  if zDataChanged = True then
  begin
  end;

  CurrentRow := agrLines.row;
  if isSystemLine(CurrentRow) then
  begin
    // d.UpdateGroupAccount(FReservation,0,GroupAccount);
    exit;
  end;

  itemId := trim(agrLines.Cells[col_Item, CurrentRow]);

  if itemId = '' then
  begin
    ShowMessage(GetTranslatedText('shTx_Invoice_BlankLine'));
    exit;
  end;

  reservation := publicReservation;
  RoomReservation := FRoomReservation;
  SplitNumber := 0;
  invoiceNumber := zInvoiceNumber;
  itemNumber := CurrentRow;
  RoomNumber := d.RR_GetRoomNr(RoomReservation);
  Description := trim(agrLines.Cells[col_Description, CurrentRow]);
  sTotal := trim(agrLines.Cells[col_TotalPrice, CurrentRow]);

  try
    Total := _StrToFloat(sTotal);
  except
    ShowMessage(format(GetTranslatedText('shTx_Invoice_ErrorInTotal'),
      [sTotal]));
    exit;
  end;

  ItemTypeInfo := d.Item_Get_ItemTypeInfo(itemId, agrLines.Cells[col_Source, CurrentRow]);

  lInvRoom := TInvoiceRoomEntity.create(agrLines.Cells[col_Item, CurrentRow], 1, _StrToFloat(agrLines.Cells[col_ItemCount, CurrentRow]), CurrentRow, 0, 0);
  try
    TotalVAT := GetVATForItem(agrLines.Cells[col_Item, CurrentRow], Total,
                              _StrToFloat(agrLines.Cells[col_ItemCount, CurrentRow]), lInvRoom , nil,
                              ItemTypeInfo, edtCustomer.Text);
  finally
    lInvRoom.Free;
  end;
  // Formula
  TotalVAT := Total - TotalWOVat;
  TotalWOVat := Total - TotalVAT;

  s := '';
  // s := s + 'Viltu færa ' + itemId + ': ' + Description + #10;
  // s := s + 'á hópreikning ';
  s := s + format(GetTranslatedText('shTx_Invoice_MoveItemToRoomInvoice'),
    [itemId, Description, RoomByRoomReservation(toRoomReservation)]);

  Btn := MessageDlg(s, mtConfirmation, [mbYes, mbNo], 0);
  if Btn <> mrYes then
    exit;

  SaveAnd(false);

  // Description := Description + '(Room:' + RoomNumber + ')';
  if pos('(Room:', Description) > 0 then
    Description := copy(Description, 1, pos('(Room:', Description) - 1);
  NextInvoiceLine := NumberOfInvoiceLines(reservation,
    toRoomReservation, 0) + 1;
  s := '';
  s := s + ' UPDATE invoicelines ' + #10;
  s := s + ' Set ' + #10;
  s := s + '   Roomreservation = ' + _db(toRoomReservation) + ' ' + #10;
  s := s + ' , itemNumber = ' + _db(NextInvoiceLine) + ' ' + #10;
  s := s + ' , Description = ' + _db(Description) + ' ' + #10;
  s := s + ' , InvoiceIndex = ' + _db(InvoiceIndex) + ' ' + #10;
  s := s + ' , staffLastEdit= ' + _db(d.roomerMainDataSet.username) + ' ' + #10;
  s := s + 'where Reservation = ' + _db(reservation);
  if RoomReservation > 0 then
    s := s + '  and RoomReservation = ' + _db(RoomReservation) + #10
  else
    s := s + '  and RoomReservation = 0 ' + #10;
  s := s + '   and Splitnumber = 0 ' + #10;
  s := s + '   and itemNumber = ' + _db(itemNumber);
  try
    if not cmd_bySQL(s) then
    begin
      // DebugMessage('');
    end
    else
    begin
      UpdateOk := True;
    end;
  except
    on e: Exception do
    begin
      err := e.message;
      UpdateOk := false;
    end;
  end;

  if not UpdateOk then
  begin
    ShowMessage
      (format(GetTranslatedText('shTx_Invoice_FailedGroupInvoice'), [err]));
    exit;
  end;

  rSet := CreateNewDataSet;
  try
    s := format(select_Invoice_actItemToRoomInvoiceExecute,
      [reservation, RoomReservation]);
    hData.rSet_bySQL(rSet, s);
    rSet.first;
    if not rSet.eof then
    begin
      rSet.edit;
      rSet.FieldByName('Total').Value := Total +
        LocalFloatValue(rSet.FieldByName('Total').asString);
      rSet.FieldByName('TotalWOVAT').Value := TotalWOVat +
        LocalFloatValue(rSet.FieldByName('TotalWOVAT').asString);
      rSet.FieldByName('TotalVAT').Value := TotalVAT +
        LocalFloatValue(rSet.FieldByName('TotalVAT').asString);
      rSet.post; // ID ADDED
    end;

  finally
    FreeAndNil(rSet);
  end;

  DeleteRow(agrLines, agrLines.row);
  AddEmptyLine;
  calcStayTax(publicReservation);
  zDataChanged := chkChanged;
end;

procedure TfrmInvoice.MoveItemToNewInvoiceIndex(rowIndex, toInvoiceIndex : Integer);
var
  reservation: integer;
  RoomReservation: integer;
  SplitNumber: integer;
  invoiceNumber: integer;
  itemNumber: integer;
  itemId: string; // (10)

  Description: string; // (70)

  s: string;
  CurrentRow: integer;

  NextInvoiceLine: integer;
  RoomNumber: string;

  rSet: TRoomerDataset;

  ItemTypeInfo: TItemTypeInfo;

  Total: Double;
  TotalWOVat: Double;
  TotalVAT: Double;
  sTotal: string;

  UpdateOk: boolean;

  err: string;

  lInvRoom: TInvoiceRoomEntity;

  InvoiceLine : TInvoiceLine;

begin
  err := '';
  UpdateOk := false;

  Total := 0;
  TotalWOVat := 0;
  TotalVAT := 0;

  if FInvoiceIndex = toInvoiceIndex then
  begin
    ShowMessage(GetTranslatedText('shTx_Invoice_RoomInvoice'));
    exit;
  end;
  zDataChanged := chkChanged;

  CurrentRow := rowIndex;
  if isSystemLine(CurrentRow) then
  begin
    exit;
  end;

  itemId := trim(agrLines.Cells[col_Item, CurrentRow]);

  if itemId = '' then
  begin
    ShowMessage(GetTranslatedText('shTx_Invoice_BlankLine'));
    exit;
  end;

  reservation := publicReservation;
  RoomReservation := FRoomReservation;
  SplitNumber := 0;
  invoiceNumber := zInvoiceNumber;
  itemNumber := CurrentRow;
  RoomNumber := d.RR_GetRoomNr(RoomReservation); // SKODA
  Description := trim(agrLines.Cells[col_Description, CurrentRow]);
  sTotal := trim(agrLines.Cells[col_TotalPrice, CurrentRow]);

  try
    Total := _StrToFloat(sTotal);
  except
    ShowMessage(format(GetTranslatedText('shTx_Invoice_ErrorInTotal'), [sTotal]));
    exit;
  end;

  ItemTypeInfo := d.Item_Get_ItemTypeInfo(itemId, agrLines.Cells[col_Source, CurrentRow]);

  lInvRoom := TInvoiceRoomEntity.create(agrLines.Cells[col_Item, CurrentRow], 1,
                                         _StrToFloat(agrLines.Cells[col_ItemCount, CurrentRow]), CurrentRow, 0, 0);
  try
    TotalVAT := GetVATForItem(agrLines.Cells[col_Item, CurrentRow], Total,
                              _StrToFloat(agrLines.Cells[col_ItemCount, CurrentRow]), lInvRoom, nil,
                              ItemTypeInfo, edtCustomer.Text);
  finally
    lInvRoom.Free;
  end;
  // Formula
  TotalVAT := Total - TotalWOVat;
  TotalWOVat := Total - TotalVAT;


//  IsInvoiceChanged(False);
  SaveAnd(false);

  InvoiceLine := CellInvoiceLine(rowIndex);

  // Description := Description + '(Room:' + RoomNumber + ')';
  if pos('(Room:', Description) > 0 then
    Description := copy(Description, 1, pos('(Room:', Description) - 1);
  NextInvoiceLine := NumberOfInvoiceLines(reservation, RoomReservation, 0,
    toInvoiceIndex) + 1;
  s := '';
  s := s + ' UPDATE invoicelines ' + #10;
  s := s + ' Set ' + #10;
  s := s + '   Roomreservation = ' + _db(RoomReservation) + ' ' + #10;
  s := s + ' , itemNumber = ' + _db(NextInvoiceLine) + ' ' + #10;
  s := s + ' , Description = ' + _db(Description) + ' ' + #10;
  s := s + ' , InvoiceIndex = ' + _db(toInvoiceIndex) + ' ' + #10;
  s := s + ' , staffLastEdit = ' + _db(d.roomerMainDataSet.username) + ' ' + #10;
  if (NOT Assigned(InvoiceLine)) OR (InvoiceLine.FId < 1) then
  begin
    s := s + 'where Reservation = ' + _db(reservation);
    if RoomReservation > 0 then
      s := s + '  and RoomReservation = ' + _db(RoomReservation) + #10
    else
      s := s + '  and RoomReservation = 0 ' + #10;
    s := s + '   and Splitnumber = 0 ' + #10;
    s := s + '   and itemNumber = ' + _db(itemNumber);
    s := s + '   and InvoiceIndex = ' + _db(FInvoiceIndex);
  end else
    s := s + 'where ID = ' + _db(InvoiceLine.FId);
  begin

  end;
  try
    if not cmd_bySQL(s) then
    begin
      // DebugMessage('');
    end
    else
    begin
      UpdateOk := True;
    end;
  except
    on e: Exception do
    begin
      err := e.message;
      UpdateOk := false;
    end;
  end;

  if not UpdateOk then
  begin
    ShowMessage
      (format(GetTranslatedText('shTx_Invoice_FailedGroupInvoice'), [err]));
    exit;
  end;

//  rSet := CreateNewDataSet;
//  try
//    s := format(select_Invoice_actItemToRoomInvoiceExecute,
//      [reservation, RoomReservation]);
//    hData.rSet_bySQL(rSet, s);
//    rSet.first;
//    if not rSet.eof then
//    begin
//      rSet.edit;
//      rSet.FieldByName('Total').Value := Total +
//        LocalFloatValue(rSet.FieldByName('Total').asString);
//      rSet.FieldByName('TotalWOVAT').Value := TotalWOVat +
//        LocalFloatValue(rSet.FieldByName('TotalWOVAT').asString);
//      rSet.FieldByName('TotalVAT').Value := TotalVAT +
//        LocalFloatValue(rSet.FieldByName('TotalVAT').asString);
//      rSet.post; // ID ADDED
//    end;
//
//
//  finally
//    FreeAndNil(rSet);
//  end;

  DeleteRow(agrLines, rowIndex);
  AddEmptyLine;
//  calcStayTax(publicReservation);
  zDataChanged := chkChanged;
end;

procedure TfrmInvoice.actItemToGroupInvoiceExecute(Sender: TObject);
var
  reservation: integer;
  RoomReservation: integer;
  SplitNumber: integer;
  invoiceNumber: integer;
  itemNumber: integer;
  itemId: string; // (10)

  Description: string; // (70)

  s: string;
  CurrentRow: integer;

  NextInvoiceLine: integer;
  RoomNumber: string;

  Btn: Word;

  rSet: TRoomerDataset;

  ItemTypeInfo: TItemTypeInfo;

  Total: Double;
  TotalWOVat: Double;
  TotalVAT: Double;
  sTotal: string;

  UpdateOk: boolean;

  err: string;

  lInvRoom: TInvoiceRoomEntity;

  list : TList<String>;
  i, l : Integer;
  reloadNeeded : Boolean;

begin
  err := '';
  UpdateOk := false;
  reloadNeeded := False;

  Total := 0;
  TotalWOVat := 0;
  TotalVAT := 0;

  if FRoomReservation = 0 then
  begin
    ShowMessage(GetTranslatedText('shTx_Invoice_GroupInvoice'));
    exit;
  end;
  zDataChanged := chkChanged;

  list := GetSelectedRows;
  try
    for l := list.Count - 1 downto 0 do
    begin
      i := IndexOfAutoGen(list[l]);
      if i >= 0 then
      begin
        agrLines.Row := i;

        CurrentRow := agrLines.row;
        if isSystemLine(CurrentRow) then
        begin
          // d.UpdateGroupAccount(FReservation,0,GroupAccount);
          d.UpdateGroupAccountone(publicReservation, FRoomReservation, FRoomReservation, True);
          reloadNeeded := True;
          continue;
        end;

        itemId := trim(agrLines.Cells[col_Item, CurrentRow]);

        if itemId = '' then
        begin
      //    ShowMessage(GetTranslatedText('shTx_Invoice_BlankLine'));
          continue;
        end;

        reservation := publicReservation;
        RoomReservation := FRoomReservation;
        SplitNumber := 0;
        invoiceNumber := zInvoiceNumber;
        itemNumber := CurrentRow;
        RoomNumber := d.RR_GetRoomNr(RoomReservation);
        Description := trim(agrLines.Cells[col_Description, CurrentRow]);
        sTotal := trim(agrLines.Cells[col_TotalPrice, CurrentRow]);

        try
          Total := _StrToFloat(sTotal);
        except
          ShowMessage(format(GetTranslatedText('shTx_Invoice_ErrorInTotal'),
            [sTotal]));
          exit;
        end;

        ItemTypeInfo := d.Item_Get_ItemTypeInfo(itemId, agrLines.Cells[col_Source, CurrentRow]);

        lInvRoom := TInvoiceRoomEntity.create(agrLines.Cells[col_Item, CurrentRow], 1,
                                              _StrToFloat(agrLines.Cells[col_ItemCount, CurrentRow]), CurrentRow, 0, 0);
        try
          TotalVAT := GetVATForItem(agrLines.Cells[col_Item, CurrentRow], Total,
                                    _StrToFloat(agrLines.Cells[col_ItemCount, CurrentRow]), lInvRoom, nil,
                                    ItemTypeInfo, edtCustomer.Text);
        finally
          lInvRoom.Free;
        end;
        // Formula
        TotalVAT := Total - TotalWOVat;
        TotalWOVat := Total - TotalVAT;

        if l = list.Count - 1 then
        begin
      //    s := format(GetTranslatedText('shTx_Invoice_MoveItemToGroupInvoice'), [itemId, Description]);
          s := GetTranslatedText('shTx_Invoice_MoveSelectedItemsToGroupInvoice');

          Btn := MessageDlg(s, mtConfirmation, [mbYes, mbNo], 0);
          if Btn <> mrYes then
            exit;

          SaveAnd(false);
        end;

        Description := Description + '(Room:' + RoomNumber + ')';
        NextInvoiceLine := NumberOfInvoiceLines(reservation, 0, 0) + 1 +
          RR_GetNumberGroupInvoices(reservation);
        s := '';
        s := s + ' UPDATE invoicelines ' + #10;
        s := s + ' Set ' + #10;
        s := s + '   Roomreservation = 0 ' + #10;
        s := s + ' , itemNumber = ' + _db(NextInvoiceLine) + ' ' + #10;
        s := s + ' , Description = ' + _db(Description) + ' ' + #10;
        s := s + ' , staffLastEdit = ' + _db(d.roomerMainDataSet.username) + ' ' + #10;
        s := s + 'where Reservation = ' + _db(reservation);
        s := s + '  and RoomReservation = ' + _db(RoomReservation);
        s := s + '   and Splitnumber = 0 ' + #10;
        s := s + '   and itemNumber = ' + _db(itemNumber);
        try
          if not cmd_bySQL(s) then
          begin
            // DebugMessage('');
          end
          else
          begin
            UpdateOk := True;
          end;
        except
          on e: Exception do
          begin
            err := e.message;
            UpdateOk := false;
          end;
        end;

        if not UpdateOk then
        begin
          ShowMessage
            (format(GetTranslatedText('shTx_Invoice_FailedGroupInvoice'), [err]));
          exit;
        end;

        rSet := CreateNewDataSet;
        try
          s := format(select_Invoice_actItemToGroupInvoiceExecute, [reservation]);
          hData.rSet_bySQL(rSet, s);
          rSet.first;
          if not rSet.eof then
          begin
            rSet.edit;
            rSet.FieldByName('Total').Value := Total +
              LocalFloatValue(rSet.FieldByName('Total').asString);
            rSet.FieldByName('TotalWOVAT').Value := TotalWOVat +
              LocalFloatValue(rSet.FieldByName('TotalWOVAT').asString);
            rSet.FieldByName('TotalVAT').Value := TotalVAT +
              LocalFloatValue(rSet.FieldByName('TotalVAT').asString);
            rSet.post; // ID ADDED
          end;

        finally
          FreeAndNil(rSet);
        end;

        DeleteRow(agrLines, agrLines.row);
        AddEmptyLine;
      end;
    end;
  finally
    list.Free;
  end;
  calcStayTax(publicReservation);
  zDataChanged := chkChanged;
  if reloadNeeded then
    LoadInvoice;
end;

procedure TfrmInvoice.actCompressLinesExecute(Sender: TObject);
begin
end;


// procedure TfrmInvoice.DeleteProforma;
// var
// s : string;
// begin
//
// // Max invoice value = 2,000,000,000
// s := 'DELETE FROM invoiceheads WHERE InvoiceNumber = ' + _db(PROFORMA_INVOICE_NUMBER);
// if not cmd_bySQL(s) then
// begin
// end;
//
// s := 'DELETE FROM invoicelines WHERE InvoiceNumber = ' + _db(PROFORMA_INVOICE_NUMBER);
// if not cmd_bySQL(s) then
// begin
// end;
// end;

function TfrmInvoice.CreateProformaID: integer;
  function GetMinutesSinceMidnightAsString: String;
  begin
    result := ZerosInFront(inttostr(MinutesSinceMidnight), 4);
  end;

begin
  if (publicReservation = 0) AND (FRoomReservation = 0) then
    result := GenerateProformaInvoiceNumber
  else if FRoomReservation > 0 then // 1,234,567,890
    result := strToInt(GetMinutesSinceMidnightAsString + '000000') +
      FRoomReservation
  else
    result := strToInt(GetMinutesSinceMidnightAsString + '000000') +
      publicReservation;
  if result < 1000000000 then
    result := 1000000000 + result;
end;

procedure TfrmInvoice.RemoveCurrentProformeInvoice(ProformaInvoiceNumber : Integer);
var sql : String;
    i : Integer;
begin
  for i := LOW(REMOVE_CURRENT_PROFORMA_INVOICE) to HIGH(REMOVE_CURRENT_PROFORMA_INVOICE) do
  begin
    sql := format(REMOVE_CURRENT_PROFORMA_INVOICE[i], [ProformaInvoiceNumber]);
    d.roomerMainDataSet.DoCommand(sql);
  end;
end;

procedure TfrmInvoice.PrintProforma;
var
  showPackage: boolean;
  sql: String;
begin
  showPackage := chkShowPackage.checked;

//  d.roomerMainDataSet.SystemStartTransaction;
  try
    PROFORMA_INVOICE_NUMBER := CreateProformaID;
    SaveProforma(PROFORMA_INVOICE_NUMBER);
    ViewInvoice2(PROFORMA_INVOICE_NUMBER, True, false, false, showPackage, zEmailAddress);
  finally
    RemoveCurrentProformeInvoice(PROFORMA_INVOICE_NUMBER);
//    d.roomerMainDataSet.SystemRollbackTransaction;
  end;
end;

procedure TfrmInvoice.SaveProforma(iInvoiceNumber: integer);
var
  ItemTypeInfo: TItemTypeInfo;
  i: integer;
  fWork, fVat,

    fItems, FTotal, fTotalVAT, fTotalWOVat,

    fItemTotal, fItemTotalVAT, fItemTotalWOVat: Double;

  iMultiplier: integer;

  iPersons, iNights: integer;

  AMon, ADay, AYear: Word;
  s: string;
  sTmp: string;

  ItemCount: Double;

  _CurrencyValueSell: Double;
  Refrence: string;
  Source: string;
  isPackage: boolean;

  LineHolder: hData.recInvoiceLineHolder;

  confirmDate: TDateTime;
  confirmAmount: Double;
  sItemID: string;
  sAccountKey: string;

  dNumItems: Double;

  sRRAlias: string;
  irrAlias: integer;

  isOK: boolean;

  lInvRoom: TInvoiceRoomEntity;

begin
  isOK := True;
  try
    _CurrencyValueSell := zCurrencyRate;

    iMultiplier := 1;

    fItems := 0.00;
    FTotal := 0.00;
    fTotalVAT := 0.00;
    fTotalWOVat := 0.00;

    for i := 1 to agrLines.RowCount - 1 do
    begin
      // -- is this an empty line ?
      if (trim(agrLines.Cells[col_Description, i]) = '') and
        (trim(agrLines.Cells[col_Item, i]) = '') then
        continue;

      iNights := 0;
      iPersons := 0;
      if agrLines.Cells[col_NoGuests, i] <> '' then
      begin
        iPersons := strToInt(agrLines.Cells[col_NoGuests, i])
      end;

      // -- is this an Automatically maintained line ?
      // og þess vegna ekki vistuð í invoicelines
      if (isSystemLine(i)) and (iInvoiceNumber <= 0) then
        continue;

      ItemTypeInfo := d.Item_Get_ItemTypeInfo(agrLines.Cells[col_Item, i],
        agrLines.Cells[col_Source, i]);

      // --
      // RoomRentItem

      if (isSystemLine(i)) or
        (trim(g.qRoomRentItem) = agrLines.Cells[col_Item, i]) or
        (trim(g.qDiscountItem) = agrLines.Cells[col_Item, i]) then
      begin
        // Setja dagsetningu á herbergisleigu
        // Dagsetning er í upphafi 0  31.12.1899
        // en er hér sett á dagsetningu prentunnar
        agrLines.Cells[col_date, i] := datetostr(trunc(now));
        agrLines.Objects[col_Description, i] := TObject(trunc(now));

        try
          fItemTotal := _CurrencyValueSell *
            _StrToFloat(agrLines.Cells[col_TotalPrice, i]);
        except
          fItemTotal := 0;
        end;

        if agrLines.Objects[col_ItemCount, i] <> nil then
        begin
          // iPersons := TRoomInfo(agrLines.Objects[col_ItemCount, i]).FNumPersons;
          iNights := trunc(TRoomInfo(agrLines.Objects[col_ItemCount, i]).FTo) -
            trunc(TRoomInfo(agrLines.Objects[col_ItemCount, i]).FFrom);
        end;
      end
      else
      begin
        try
          fItemTotal := _StrToFloat(agrLines.Cells[col_TotalPrice, i]);
        except
          fItemTotal := 0;
        end;
      end;

      Source := agrLines.Cells[col_Source, i];
      Refrence := agrLines.Cells[col_Refrence, i];

      sTmp := agrLines.Cells[col_confirmdate, i];
      if sTmp <> '' then
      begin
        confirmDate := _DBDateToDateTimeNoMs(sTmp);
      end
      else
        confirmDate := 2;

      confirmAmount := _StrToFloat(agrLines.Cells[col_confirmAmount, i]);

      isPackage := false;
      try
        sTmp := trim(agrLines.Cells[col_isPackage, i]);
        if sTmp = 'Yes' then
          isPackage := True;
      except
        // not raise
      end;

      // --
      dNumItems := _StrToFloat(agrLines.Cells[col_ItemCount, i]);
      if (LowerCase(trim(g.qRoomRentItem))
        = LowerCase(agrLines.Cells[col_Item, i])) OR
        (LowerCase(trim(g.qDiscountItem))
        = LowerCase(agrLines.Cells[col_Item, i])) then
        dNumItems := 1.00;

      lInvRoom := TInvoiceRoomEntity.create(agrLines.Cells[col_Item, i], 1,
                                            _StrToFloat(agrLines.Cells[col_ItemCount, i]), fItemTotal, 0, 0);
      try
        fVat := GetVATForItem(agrLines.Cells[col_Item, i], fItemTotal,
                              dNumItems, lInvRoom, tempInvoiceItemList, ItemTypeInfo, edtCustomer.Text);
      finally
        lInvRoom.Free;
      end;
      if NOT(Item_GetKind(agrLines.Cells[col_Item, i]) IN [ikRoomRent,
        ikRoomRentDiscount]) then
        agrLines.Cells[col_Vat, i] := _floattostr(fVat, vWidth, 3);
      // Formula
      // fWork := fItemTotal / (1 + (ItemTypeInfo.VATPercentage / 100));
      // fVat := fItemTotal - fWork;

      fItemTotalVAT := fVat;
      fItemTotalWOVat := fItemTotal - fItemTotalVAT;

      FTotal := FTotal + fItemTotal;
      fTotalVAT := fTotalVAT + fItemTotalVAT;
      fTotalWOVat := fTotalWOVat + fItemTotalWOVat;

      try
        decodedate(integer(agrLines.Objects[col_Description, i]), AYear, AMon, ADay);
      except
        decodedate(now, AYear, AMon, ADay);
      end;

      sTmp := agrLines.Cells[col_ItemCount, i];
      try
        ItemCount := _StrToFloat(sTmp);
      except
        ItemCount := 0;
      end;

      sRRAlias := trim(agrLines.Cells[col_rrAlias, i]);
      irrAlias := -1;
      try
        if sRRAlias <> '' then
          irrAlias := strToInt(sRRAlias);
      Except
      end;

      sItemID := agrLines.Cells[col_Item, i];
      sAccountKey := d.Item_Get_AccountKey(sItemID);

      // SQL 116 INSERxT Invoicelines
      // SQL 116 INSERxT Invoicelines
      s := '';
      s := s + 'INSERT into invoicelines' + #10;
      s := s + '(' + #10;
      s := s + '  ' + 'Reservation ' + #10;
      s := s + ', ' + 'AutoGen ' + #10;
      s := s + ', ' + 'RoomReservation ' + #10;
      s := s + ', ' + 'SplitNumber ' + #10;
      s := s + ', ' + 'ItemNumber ' + #10;
      s := s + ', ' + 'PurchaseDate ' + #10;
      s := s + ', ' + 'InvoiceNumber ' + #10;
      s := s + ', ' + 'ItemId ' + #10;
      s := s + ', ' + 'Number ' + #10;
      s := s + ', ' + 'Description ' + #10;
      s := s + ', ' + 'Price ' + #10;
      s := s + ', ' + 'VATType ' + #10;
      s := s + ', ' + 'Total ' + #10;
      s := s + ', ' + 'TotalWOVat ' + #10;
      s := s + ', ' + 'VAT ' + #10;
      s := s + ', ' + 'CurrencyRate ' + #10;
      s := s + ', ' + 'Currency ' + #10;
      s := s + ', ' + 'Persons ' + #10;
      s := s + ', ' + 'Nights ' + #10;
      s := s + ', ' + 'BreakfastPrice ' + #10;
      s := s + ', ' + 'AutoGenerated ' + #10;
      s := s + ', ' + 'AYear ' + #10;
      s := s + ', ' + 'AMon ' + #10;
      s := s + ', ' + 'ADay ' + #10;
      s := s + ', ' + 'ilAccountKey ' + #10;
      s := s + ', ' + 'importRefrence ' + #10;
      s := s + ', ' + 'importSource ' + #10;
      s := s + ', ' + 'isPackage ' + #10;
      s := s + ', ' + 'confirmDate ' + #10;
      s := s + ', ' + 'confirmAmount ' + #10;
      s := s + ', ' + 'RoomReservationAlias' + #10;
      s := s + ')' + #10;
      s := s + 'Values' + #10;
      s := s + '(' + #10;
      s := s + '  ' + inttostr(publicReservation);
      s := s + ', ' + _db(_GetCurrentTick);
      s := s + ', ' + inttostr(FRoomReservation);
      s := s + ', ' + inttostr(FnewSplitNumber);
      s := s + ', ' + inttostr(i);
      s := s + ', ' + _DateToDbDate(integer(agrLines.Objects[col_Description, i]), True);
      s := s + ', ' + inttostr(iInvoiceNumber);

      s := s + ', ' + _db(sItemID);
      s := s + ', ' + _db(ItemCount); // -96ath
      s := s + ', ' + _db(agrLines.Cells[col_Description, i]);

      if (isSystemLine(i)) or
        (trim(g.qRoomRentItem) = agrLines.Cells[col_Item, i]) or
        (trim(g.qDiscountItem) = agrLines.Cells[col_Item, i]) then
        // -- Auto-Maintained lines are displayed in foreign currency...
        s := s + ', ' + _CommaToDot
          (floattostr(iMultiplier * _CurrencyValueSell *
          _StrToFloat(agrLines.Cells[col_ItemPrice, i])))
      else // -- ...The others are not...
        s := s + ', ' + _CommaToDot
          (floattostr(iMultiplier * _StrToFloat(agrLines.Cells
          [col_ItemPrice, i])));

      s := s + ', ' + _db(ItemTypeInfo.VATCode);

      if (isSystemLine(i)) or
        (trim(g.qRoomRentItem) = agrLines.Cells[col_Item, i]) or
        (trim(g.qDiscountItem) = agrLines.Cells[col_Item, i]) then
        // -- Auto-Maintained lines are displayed in foreign currency...
        s := s + ', ' + _CommaToDot
          (floattostr(iMultiplier * _CurrencyValueSell *
          _StrToFloat(agrLines.Cells[col_TotalPrice, i])))
      else // -- ...The others are not...
        s := s + ', ' + _CommaToDot
          (floattostr(iMultiplier * _StrToFloat(agrLines.Cells
          [col_TotalPrice, i])));

      s := s + ', ' + _CommaToDot(floattostr(iMultiplier * fItemTotalWOVat));
      s := s + ', ' + _CommaToDot(floattostr(iMultiplier * fItemTotalVAT));
      s := s + ', ' + _CommaToDot(floattostr(zCurrencyRate));
      s := s + ', ' + _db(edtCurrency.Text);
      s := s + ', ' + inttostr(iPersons);
      s := s + ', ' + inttostr(iNights);
      s := s + ', ' + _CommaToDot(floattostr(0.00));
      s := s + ', ' + _db(false);

      s := s + ', ' + inttostr(AYear);
      s := s + ', ' + inttostr(AMon);
      s := s + ', ' + inttostr(ADay);

      s := s + ', ' + _db(sAccountKey);
      s := s + ', ' + _db(Refrence);
      s := s + ', ' + _db(Source);
      s := s + ', ' + _db(isPackage);
      s := s + ', ' + _dbDateAndTime(confirmDate);
      s := s + ', ' + _db(confirmAmount);
      s := s + ', ' + _db(irrAlias);

      s := s + ')' + #10;

      cmd_bySQL(s);

    end; {for each line}

    SaveProformaHeader(FTotal, fTotalVAT, fTotalWOVat);
    SaveProformapayments;
  except
    on e: Exception do
    begin
      isOK := false;
      // MessageDlg('Problem: Unable to save the invoice !' + #13#13 + 'While saving invoice The following Error came up:' + #13#13 +
      // e.message + #13#13 + 'Please write this message down or' + #13 + 'call support with this dialog open!', mtError, [mbOK], 0);
      MessageDlg
        (format(GetTranslatedText('shTx_Invoice_UnableToSaveInvoiceMessage'),
        [e.message]), mtError, [mbOk], 0);
      raise;
    end;
  end;

  if isOK then
  begin
    try
      AddInvoiceActivityLog(g.qUser, publicReservation, FRoomReservation,
        FnewSplitNumber, PRINT_PROFORMA, '', FTotal, iInvoiceNumber,
        'Print Proforma');
    Except

    end;
  end;

end;

procedure TfrmInvoice.SaveProformaHeader(FTotal, fVat, fWOVat: Double);
var
  iMultiplier: integer;
  s: string;
  Total: Double;
  TotalWOVat: Double;
  TotalVAT: Double;
  totalStayTax: Double;
  totalStayTaxNights: Double;

begin
  iMultiplier := 1;

  // Til þess að setja allar tölur í mínus
  if FCredit then
    iMultiplier := -1;

  try
    totalStayTax := _StrToFloat(labLodgingTaxISK.caption);
    totalStayTax := iMultiplier * totalStayTax;
  Except
    totalStayTax := 0;
  end;

  try
    totalStayTaxNights := _StrToFloat(labLodgingTaxNights.caption);
    totalStayTaxNights := iMultiplier * totalStayTaxNights;
  except
    totalStayTaxNights := 0;
  end;

  Total := iMultiplier * FTotal;
  TotalWOVat := iMultiplier * fWOVat;
  TotalVAT := iMultiplier * fVat;

  // SQL 115 INSERxT InvoiceHeads
  s := '';
  s := s + 'INSERT into invoiceheads ' + #10;
  s := s + '(' + #10;
  s := s + '  Reservation ' + #10;
  s := s + ', RoomReservation ' + #10;
  s := s + ', SplitNumber ' + #10;

  s := s + ', InvoiceNumber ' + #10;
  s := s + ', InvoiceDate ' + #10;

  s := s + ', Customer ' + #10;
  s := s + ', Name ' + #10;
  s := s + ', CustPid ' + #10;
  s := s + ', RoomGuest ' + #10;

  s := s + ', Address1 ' + #10;
  s := s + ', Address2 ' + #10;
  s := s + ', Address3 ' + #10;
  s := s + ', Address4 ' + #10;
  s := s + ', Country ' + #10;
  s := s + ', Total ' + #10;
  s := s + ', TotalWOVat ' + #10;
  s := s + ', TotalVat ' + #10;
  s := s + ', TotalBreakfast ' + #10;
  s := s + ', ExtraText ' + #10;
  s := s + ', OriginalInvoice ' + #10;
  s := s + ', Finished ' + #10;
  s := s + ', InvoiceType ' + #10;
  s := s + ', invRefrence ' + #10;
  s := s + ', ihpaydate ' + #10;
  s := s + ', showpackage ' + #10;
  s := s + ', TotalStayTax ' + #10;
  s := s + ', TotalStayTaxNights ' + #10;
  s := s + ', Location ' + #10;

  s := s + ')' + #10;
  s := s + 'Values' + #10;
  s := s + '(' + #10;
  s := s + '  ' + _db(publicReservation);
  s := s + ', ' + _db(FRoomReservation);
  s := s + ', ' + _db(FnewSplitNumber);

  s := s + ', ' + _db(PROFORMA_INVOICE_NUMBER);
  s := s + ', ' + _DateToDbDate(zInvoiceDate, True);
  s := s + ', ' + _db(edtCustomer.Text);
  s := s + ', ' + _db(edtName.Text);
  s := s + ', ' + _db(edtPersonalId.Text);
  s := s + ', ' + _db(edtRoomGuest.Text);
  s := s + ', ' + _db(edtAddress1.Text);
  s := s + ', ' + _db(edtAddress2.Text);
  s := s + ', ' + _db(edtAddress3.Text);
  s := s + ', ' + _db(edtAddress4.Text);
  s := s + ', ' + _db(zCountry);
  s := s + ', ' + _db(FTotal);
  s := s + ', ' + _db(fWOVat);
  s := s + ', ' + _db(fVat);
  s := s + ', ' + _db(0.00);
  s := s + ', ' + _db(memExtraText.Lines.Text);
  s := s + ', ' + _db(zOriginalInvoice);
  s := s + ', ' + _db(false);
  s := s + ', ' + _db(rgrInvoiceType.itemIndex);
  s := s + ', ' + _db(edtInvRefrence.Text);
  s := s + ', ' + _db(now);
  s := s + ', ' + _db(chkShowPackage.checked);
  s := s + ', ' + _db(totalStayTax);
  s := s + ', ' + _db(totalStayTaxNights);
  s := s + ', ' + _db(zLocation);

  s := s + ')' + #10;

  if not cmd_bySQL(s) then
  begin

  end
  else
  begin

  end;
end;

procedure TfrmInvoice.SaveProformapayments;
var
  s: string;

  rSet: TRoomerDataset;

  sql: string;

begin
  rSet := CreateNewDataSet;
  try
    sql := 'SELECT * FROM payments ' + '  where Reservation = %d ' +
      '    and RoomReservation = %d ' +
      '    and InvoiceNumber = -1 AND InvoiceIndex=%d';
    s := format(sql, [publicReservation, FRoomReservation, FInvoiceIndex]);
    hData.rSet_bySQL(rSet, s);

    rSet.first;
    while not rSet.eof do
    begin
      s := '';
      s := s + 'INSERT INTO payments' + #10;
      s := s + '(' + #10;
      s := s + '  Reservation' + '' + #10;
      s := s + ', RoomReservation' + #10;
      s := s + ', Person' + #10;
      s := s + ', Customer' + #10;
      s := s + ', AutoGen' + #10;
      s := s + ', InvoiceNumber' + #10;
      s := s + ', PayDate' + #10;
      s := s + ', PayType' + #10;
      s := s + ', Amount' + #10;
      s := s + ', Description' + #10;
      s := s + ', CurrencyRate' + #10;
      s := s + ', Currency' + #10;
      s := s + ', TypeIndex' + #10;
      s := s + ', AYear' + #10;
      s := s + ', AMon' + #10;
      s := s + ', ADay' + #10;
      s := s + ', InvoiceIndex' + #10;
      s := s + ')' + #10;
      s := s + 'Values' + #10;
      s := s + '(' + #10;

      s := s + '  ' + _db(publicReservation);
      s := s + ', ' + _db(FRoomReservation);
      s := s + ', ' + _db(rSet.FieldByName('person').asinteger);
      s := s + ', ' + _db(rSet.FieldByName('Customer').asString);
      s := s + ', ' + _db(rSet.FieldByName('AutoGen').asString);
      s := s + ', ' + _db(PROFORMA_INVOICE_NUMBER);
      s := s + ', ' + _db(rSet.FieldByName('paydate').asString);
      s := s + ', ' + _db(rSet.FieldByName('PayType').asString);
      s := s + ', ' + _db(rSet.GetFloatValue(rSet.FieldByName('Amount')));
      s := s + ', ' + _db(rSet.FieldByName('Description').asString);
      s := s + ', ' + _db(rSet.GetFloatValue(rSet.FieldByName('Currencyrate')));
      s := s + ', ' + _db(rSet.FieldByName('Currency').asString);
      s := s + ', ' + _db(rSet.FieldByName('TypeIndex').asinteger);
      s := s + ', ' + _db(rSet.FieldByName('AYear').asinteger);
      s := s + ', ' + _db(rSet.FieldByName('AMon').asinteger);
      s := s + ', ' + _db(rSet.FieldByName('ADay').asinteger);
      s := s + ', ' + _db(FInvoiceIndex);
      s := s + ')';
      if not cmd_bySQL(s) then
      begin
      end;
      rSet.Next;
    end;
  finally
    FreeAndNil(rSet)
  end;
end;

procedure TfrmInvoice.edtRateDblClick(Sender: TObject);
var
  Rate: Double;
  Currency: string;
begin
  Rate := zCurrencyRate;
  Currency := edtCurrency.Text;

  if g.OpenChangeRate(Rate, Currency) then
  begin
    zCurrencyRate := Rate;
    edtRate.Text := floattostr(Rate);
    CheckRateChange
  end;
  chkChanged;
end;

function TfrmInvoice.createAllStr: string;
var
  s: string;
  HeadText: string;
  GridText: string;
  SumText: string;
  CurrencyText: string;

  i: integer;
  ii: integer;

begin
  //
  s := '';
  s := s + edtCustomer.Text + ';';
  s := s + edtPersonalId.Text + ';';
  s := s + edtName.Text + ';';
  s := s + edtAddress1.Text + ';';
  s := s + edtAddress2.Text + ';';
  s := s + edtAddress3.Text + ';';
  s := s + edtAddress4.Text + ';';
  s := s + edtRoomGuest.Text + ';';
  s := s + inttostr(rgrInvoiceType.itemIndex) + ';';
  s := s + memExtraText.Text + ';';
  s := s + edtInvRefrence.Text + ';';
  s := s + booltostr(chkShowPackage.checked) + ';';

  HeadText := s;

  s := '';
  for i := 0 to agrLines.RowCount - 1 do
  begin
    for ii := 0 to agrLines.ColCount - 1 do
    begin
      s := s + agrLines.Cells[ii, i] + ';';
    end;
    s := s + chr(10);
  end;

  GridText := s;

  s := '';
  s := s + edtCurrency.Text + ';';
  s := s + edtRate.Text + ';';
  s := s + edtForeignCurrency.Text + ';';
  CurrencyText := s;

  s := '';
  s := s + edtTotal.Text + ';';
  s := s + edtVat.Text + ';';
  // *xcv    s := s + edtPayments.Text + ';';
  s := s + edtInvoiceTotal.Text + ';';
  SumText := s;

  result := HeadText + chr(10) + CurrencyText + chr(10) + SumText + chr(10)
    + GridText;
end;

function TfrmInvoice.IsCashInvoice: boolean;
begin
  result := ((publicReservation + FRoomReservation) = 0);
end;

function TfrmInvoice.chkChanged: boolean;
var
  diff: boolean;
  s: string;
begin
  result := False;
  if IsCashInvoice then exit;

  s := createAllStr;

  diff := s <> zInitString;
  inc(zChkCount);

  lblChangedInvoiceActive.visible := diff;
  btnSaveChanges.Visible := lblChangedInvoiceActive.visible;
end;

procedure TfrmInvoice.memExtraTextExit(Sender: TObject);
begin
  // DataChanged    := true;
  zDataChanged := chkChanged;
end;

procedure TfrmInvoice.LoadRoomList(reservation: integer);
var
  sql: String;
  rSet: TRoomerDataset;
  Room: TRoomInfo;
begin
  SelectableRooms.Clear;
  sql := format
    ('SELECT DISTINCT Room, RoomReservation FROM roomsdate WHERE Reservation=%d',
    [reservation]);
  rSet := CreateNewDataSet;
  try
    if hData.rSet_bySQL(rSet, sql, false) then
    begin
      rSet.first;
      while NOT rSet.eof do
      begin
        Room := TRoomInfo.create;
        Room.FRoom := rSet['Room'];
        Room.FRoomReservation := rSet['RoomReservation'];
        Room.FReservation := reservation;
        SelectableRooms.add(Room);
        rSet.Next;
      end;
    end;
  finally
    FreeAndNil(rSet);
  end;
end;

procedure TfrmInvoice.FillRoomsInMenu(mnuItem: TMenuItem);
var
  i: integer;
  Item, subItem: TMenuItem;
  l: integer;
begin
  LoadRoomList(publicReservation);
  mnuItem.Clear;
  for i := 0 to SelectableRooms.Count - 1 do
  begin
    // if TRoomInfo(SelectableRooms[i]).FRoomReservation <> FRoomReservation then
    // begin
    Item := TMenuItem.create(nil);
    Item.caption := TRoomInfo(SelectableRooms[i]).FRoom;
    Item.Tag := i;
    mnuItem.add(Item);
    if mnuItem = t2 then
    begin
      // item.OnClick := t2Click
      Item.Clear;
      for l := 0 to mnuInvoiceIndex.Items.Count - 1 do
      begin
        subItem := TMenuItem.create(nil);
        subItem.caption := mnuInvoiceIndex.Items[l].caption;
        subItem.Tag := mnuInvoiceIndex.Items[l].Tag;
        subItem.OnClick := N91Click;
        Item.add(subItem);
        subItem.Enabled := subItem.Tag >= 0;
      end;
    end
    else if mnuItem = T4 then
      Item.OnClick := T4Click;
    // end;
  end;
end;

procedure TfrmInvoice.mnuMoveItemPopup(Sender: TObject);
begin
  FillRoomsInMenu(t2);
end;

procedure TfrmInvoice.mnuMoveRoomPopup(Sender: TObject);
begin
  // FillRoomsInMenu(t4);
end;

procedure TfrmInvoice.edtCustomerExit(Sender: TObject);
begin
  zDataChanged := chkChanged;
end;

procedure TfrmInvoice.timCloseInvoiceTimer(Sender: TObject);
begin
  timCloseInvoice.Enabled := false;
  close;
end;

procedure TfrmInvoice.CorrectInvoiceIndexRectangles;
var
  i: integer;
  pnl: TsPanel;
  shp1, shp2 : TShape;
begin
  for i := 0 to 9 do
  begin
    pnl := GetInvoiceIndexPanel(i);
    shp1 := GetInvoiceIndexItems(i);
    shp2 := GetInvoiceIndexItemsRR(i);
    if pnl.Tag = InvoiceIndex then
      pnl.Color := $00FFCFA8
    else
      pnl.Color := clWhite;

    pnl.Font.Color := clBlack;

    if pnl.HelpContext = 0 then
      shp1.Brush.Color := clWhite
    else
      shp1.Brush.Color := clRed; // $00C1FFFF;

    if shp2.HelpContext = 0 then
      shp2.Brush.Color := clWhite
    else
      shp2.Brush.Color := clBlue; // $00FFCFA8;

    shp2.Visible := shp2.Brush.Color <> clWhite;
    shp1.Visible := shp1.Brush.Color <> clWhite;
  end;
end;

initialization

begin
  bModal := false;
end;

end.
