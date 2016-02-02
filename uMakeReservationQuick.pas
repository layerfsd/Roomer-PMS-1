unit uMakeReservationQuick;

interface

uses
    Windows
  , Messages
  , system.SysUtils
  , system.Variants
  , system.Classes
  , Vcl.Graphics
  , Vcl.Controls
  , Vcl.Forms
  , Vcl.Dialogs
  , Vcl.Menus
  , Vcl.StdCtrls
  , Vcl.Buttons
  , Vcl.ExtCtrls
  , Vcl.Mask
  , Vcl.ComCtrls
  , hData
  , Data.DB
  , Data.Win.ADODB
  , objNewReservation
  , objHomeCustomer

  , cxPCdxBarPopupMenu
  , cxGraphics
  , cxControls
  , cxLookAndFeels
  , cxLookAndFeelPainters
  , cxContainer
  , cxEdit
  , dxCore
  , cxDateUtils
  , cxStyles
  , cxCustomData
  , cxFilter
  , cxData
  , cxDataStorage
  , cxNavigator
  , cxDBData
  , cxTextEdit
  , cxButtonEdit
  , cxSpinEdit
  , cxCalc
  , dxmdaset
  , cxButtons
  , cxGridLevel
  , cxGridCustomTableView
  , cxGridTableView
  , cxGridDBTableView
  , cxClasses
  , cxGridCustomView
  , cxGrid
  , cxDropDownEdit
  , cxCalendar
  , cxCheckBox
  , cxMaskEdit
  , cxLabel
  , cxGroupBox
  , cxPC
  , cxGridBandedTableView
  , cxGridDBBandedTableView
  , cxPropertiesStore
  , cxLookupEdit
  , cxDBLookupEdit
  , cxDBLookupComboBox


  , cmpRoomerDataSet
  , cmpRoomerConnection

  , objRoomRates
  , kbmMemTable
  , uUtils
  , uAlerts
  , uAlertEditPanel

  , sPanel

  , sSkinProvider
  , sGroupBox
  , sLabel
  , sCheckBox
  , sButton
  , sPageControl
  , sEdit
  , sSpinEdit

  , sBevel, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White, dxSkinsDefaultPainters,
  dxSkinscxPCPainter


  , sMemo
  , sMaskEdit
  , sCustomComboEdit
  , sTooledit, sComboBox, sSpeedButton
  , uDImages, Vcl.DBCtrls, cxCurrencyEdit, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinDarkRoom, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, uRoomerFilterComboBox, System.Generics.Collections,
  uDynamicRates, sListView


  //DX skins


  ;

TYPE
  recRoomRate = record
    Reservation     : integer;
    RoomReservation : integer;
    RoomNumber      : string;
    RateDate        : integer;
    PriceCode       : string;
    Rate            : double;
    Discount        : double;
    isPrecentage    : boolean;
    ShowDiscount    : boolean;
    isPaid          : boolean;
    DiscountAmount  : double;
    RentAmount      : double;
    NativeAmount    : double;
  end;



type
  TfrmMakeReservationQuick = class(TForm)
    pgcMain: TsPageControl;
    taReservation: TsTabSheet;
    tabSelectType: TsTabSheet;
    panTop: TsPanel;
    Panel2: TsPanel;
    gbxGetCustomer: TsGroupBox;
    clabCustomer: TsLabel;
    labCustomerName: TsLabel;
    gbxGetReservation: TsGroupBox;
    clabReservationName: TsLabel;
    edReservationName: TsEdit;
    cbxRoomStatus: TsComboBox;
    clabGroupInvoice: TsLabel;
    chkisGroupInvoice: TsCheckBox;
    labMarketSegmentName: TsLabel;
    pgcMoreInfo: TsPageControl;
    tabCustomerDetails: TsTabSheet;
    clabTel2: TsLabel;
    tabContactDetails: TsTabSheet;
    mRoomResDS: TDataSource;
    gbxDates: TsGroupBox;
    edNights: TsSpinEdit;
    dtArrival: TsDateEdit;
    dtDeparture: TsDateEdit;
    __lblArrivalWeekday: TsLabel;
    __lblDepartureWeekday: TsLabel;
    clabArrival: TsLabel;
    clabdeparture: TsLabel;
    clabNights: TsLabel;
    mSelectTypes: TdxMemData;
    StringField2: TStringField;
    StringField4: TStringField;
    mSelectTypesDS: TDataSource;
    mSelectTypesSelected: TIntegerField;
    mSelectRooms: TdxMemData;
    StringField1: TStringField;
    mSelectRoomsDS: TDataSource;
    panBottom: TsPanel;
    btnCancel: TsButton;
    btnNext: TsButton;
    btnPrevius: TsButton;
    btnFinish: TsButton;
    Panel5: TsPanel;
    panNotesPayment: TsPanel;
    Panel7: TsPanel;
    panNotesGeneral: TsPanel;
    Panel11: TsPanel;
    clabGeneralNotes: TsLabel;
    memReservationGeneralInfo: TsMemo;
    tabSelectRooms: TsTabSheet;
    tabRoomRates: TsTabSheet;
    panTopRoomRates: TsPanel;
    grRoomRes: TcxGrid;
    tvRoomRes: TcxGridDBTableView;
    lvRoomRes: TcxGridLevel;
    panSelectRoomsTop: TsPanel;
    grSelectRooms: TcxGrid;
    lvSelectRooms: TcxGridLevel;
    panSelectTypesTop: TsPanel;
    grSelectType: TcxGrid;
    tvSelectType: TcxGridDBTableView;
    tvSelectTypeRecId: TcxGridDBColumn;
    tvSelectTyperoomType: TcxGridDBColumn;
    tvSelectTypeRoomTypeDescription: TcxGridDBColumn;
    tvSelectTypeSelected: TcxGridDBColumn;
    lvSelectType: TcxGridLevel;
    _kbmRoomRes: TkbmMemTable;
    tvRoomResRoom: TcxGridDBColumn;
    tvRoomResRoomType: TcxGridDBColumn;
    tvRoomResGuests: TcxGridDBColumn;
    tvRoomResRoomDescription: TcxGridDBColumn;
    tvRoomResRoomTypeDescription: TcxGridDBColumn;
    tvRoomResDeparture: TcxGridDBColumn;
    tvRoomResArrival: TcxGridDBColumn;
    tvRoomResChildrenCount: TcxGridDBColumn;
    tvRoomResinfantCount: TcxGridDBColumn;
    tvRoomResRoomReservation: TcxGridDBColumn;
    tvRoomResAvragePrice: TcxGridDBColumn;
    tvRoomResRateCount: TcxGridDBColumn;
    _kbmRoomRates: TkbmMemTable;
    kbmRoomRatesDS: TDataSource;
    lvRoomRates: TcxGridLevel;
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
    gbxSelectedRoom: TsGroupBox;
    btdEditRoomRate: TsButton;
    sPanel1: TsPanel;
    clabPID: TsLabel;
    clabCustomerName: TsLabel;
    clabAddress1: TsLabel;
    clabWebSite: TsLabel;
    clabEmail: TsLabel;
    clabFax: TsLabel;
    clabTel1: TsLabel;
    edPID: TsEdit;
    edCustomerName: TsEdit;
    edAddress1: TsEdit;
    edAddress2: TsEdit;
    edAddress3: TsEdit;
    edTel1: TsEdit;
    edTel2: TsEdit;
    edFax: TsEdit;
    edEmailAddress: TsEdit;
    edHomePage: TsEdit;
    sPanel3: TsPanel;
    gbxContact: TsGroupBox;
    clabContactPerson: TsLabel;
    gbxCustomerAlert: TsGroupBox;
    timAlert: TTimer;
    tvRoomResColumn1: TcxGridDBColumn;
    tvRoomResPriceCode: TcxGridDBColumn;
    mSelectTypesNoRooms: TIntegerField;
    tvSelectTypeNoRooms: TcxGridDBColumn;
    sPanel4: TsPanel;
    mDS: TDataSource;
    mOcc_: TdxMemData;
    StringField7: TStringField;
    DateTimeField1: TDateTimeField;
    mOcc_isNoRoom: TBooleanField;
    mOcc_Status: TStringField;
    mOcc_RoomCount: TIntegerField;
    mOccDS: TDataSource;
    m_: TdxMemData;
    m_RoomType: TStringField;
    m_aDate: TDateTimeField;
    m_RoomTypeGroup: TStringField;
    m_MaxFree: TIntegerField;
    m_occTotal: TIntegerField;
    m_occDeparted: TIntegerField;
    m_occGuest: TIntegerField;
    m_occOrder: TIntegerField;
    m_occAllotment: TIntegerField;
    m_occWaitinglist: TIntegerField;
    m_occNoShow: TIntegerField;
    m_occBlocked: TIntegerField;
    m_nrTotal: TIntegerField;
    m_nrDeparted: TIntegerField;
    m_nrGuest: TIntegerField;
    m_nrOrder: TIntegerField;
    m_nrAllotment: TIntegerField;
    m_nrWaitingList: TIntegerField;
    m_nrNoShow: TIntegerField;
    m_nrBlocked: TIntegerField;
    m_FreeRooms: TIntegerField;
    m_Description: TStringField;
    tvSelectRooms: TcxGridDBBandedTableView;
    mSelectRoomsRoomType: TStringField;
    mSelectRoomsDescription: TStringField;
    mSelectRoomsDetailedDescription: TMemoField;
    mSelectRoomsSqrMeters: TFloatField;
    mSelectRoomsBedSize: TStringField;
    mSelectRoomsEquipments: TStringField;
    mSelectRoomsBookable: TBooleanField;
    mSelectRoomsStatistics: TBooleanField;
    mSelectRoomsStatus: TStringField;
    mSelectRoomsOrderIndex: TIntegerField;
    mSelectRoomshidden: TBooleanField;
    mSelectRoomsLocation: TStringField;
    mSelectRoomsFloor: TIntegerField;
    mSelectRoomsID: TStringField;
    mSelectRoomsDorm: TStringField;
    mSelectRoomsuseInNationalReport: TBooleanField;
    mSelectRoomsActive: TBooleanField;
    mSelectRoomsLocationDescription: TStringField;
    mSelectRoomsRoomTypeDescription: TStringField;
    mSelectRoomsRoomTypeGroupDescription: TStringField;
    mSelectRoomsBath: TBooleanField;
    mSelectRoomsShower: TBooleanField;
    mSelectRoomsSafe: TBooleanField;
    mSelectRoomsTV: TBooleanField;
    mSelectRoomsVideo: TBooleanField;
    mSelectRoomsRadio: TBooleanField;
    mSelectRoomsCDPlayer: TBooleanField;
    mSelectRoomsTelephone: TBooleanField;
    mSelectRoomsPress: TBooleanField;
    mSelectRoomsCoffee: TBooleanField;
    mSelectRoomsKitchen: TBooleanField;
    mSelectRoomsMinibar: TBooleanField;
    mSelectRoomsFridge: TBooleanField;
    mSelectRoomsHairdryer: TBooleanField;
    mSelectRoomsInternetPlug: TBooleanField;
    mSelectRoomsFax: TBooleanField;
    tvSelectRoomsRecId: TcxGridDBBandedColumn;
    tvSelectRoomsID: TcxGridDBBandedColumn;
    tvSelectRoomsActive: TcxGridDBBandedColumn;
    tvSelectRoomsRoom: TcxGridDBBandedColumn;
    tvSelectRoomsRoomType: TcxGridDBBandedColumn;
    tvSelectRoomsDescription: TcxGridDBBandedColumn;
    tvSelectRoomsDetailedDescription: TcxGridDBBandedColumn;
    tvSelectRoomsSqrMeters: TcxGridDBBandedColumn;
    tvSelectRoomsBedSize: TcxGridDBBandedColumn;
    tvSelectRoomsEquipments: TcxGridDBBandedColumn;
    tvSelectRoomsBookable: TcxGridDBBandedColumn;
    tvSelectRoomsStatistics: TcxGridDBBandedColumn;
    tvSelectRoomsStatus: TcxGridDBBandedColumn;
    tvSelectRoomsOrderIndex: TcxGridDBBandedColumn;
    tvSelectRoomshidden: TcxGridDBBandedColumn;
    tvSelectRoomsLocation: TcxGridDBBandedColumn;
    tvSelectRoomsFloor: TcxGridDBBandedColumn;
    tvSelectRoomsDorm: TcxGridDBBandedColumn;
    tvSelectRoomsuseInNationalReport: TcxGridDBBandedColumn;
    tvSelectRoomsLocationDescription: TcxGridDBBandedColumn;
    tvSelectRoomsRoomTypeDescription: TcxGridDBBandedColumn;
    tvSelectRoomsRoomTypeGroupDescription: TcxGridDBBandedColumn;
    tvSelectRoomsBath: TcxGridDBBandedColumn;
    tvSelectRoomsShower: TcxGridDBBandedColumn;
    mSelectRoomsNumberGuests: TIntegerField;
    mSelectRoomsRoomTypeGroup: TStringField;
    tvSelectRoomsNumberGuests: TcxGridDBBandedColumn;
    tvSelectRoomsRoomTypeGroup: TcxGridDBBandedColumn;
    mSelectRoomsSelect: TBooleanField;
    tvSelectRoomsSelect: TcxGridDBBandedColumn;
    mSelectRoomstmp: TStringField;
    tvSelectRoomstmp: TcxGridDBBandedColumn;
    mSelectTypesAvailable: TIntegerField;
    tvSelectTypeAvailable: TcxGridDBColumn;
    mSelectTypesTotalFree: TIntegerField;
    tvSelectTypeTotalFree: TcxGridDBColumn;
    gbxSelStatus: TsGroupBox;
    chkExcluteWaitingList: TsCheckBox;
    chkExcluteAllotment: TsCheckBox;
    chkExcluteOrder: TsCheckBox;
    chkExcluteNoShow: TsCheckBox;
    chkExcluteDeparted: TsCheckBox;
    chkExcluteBlocked: TsCheckBox;
    chkExcluteGuest: TsCheckBox;
    sLabel2: TsLabel;
    labTotalSelected: TsLabel;
    sLabel3: TsLabel;
    labTotalRoomsSelected: TsLabel;
    sLabel5: TsLabel;
    sLabel6: TsLabel;
    mSelectTypesRoomsSelected: TIntegerField;
    tvSelectTypeRoomsSelected: TcxGridDBColumn;
    mSelectTypesPriorityRule: TStringField;
    tvSelectTypePriorityRule: TcxGridDBColumn;
    tvRoomResAvrageDiscount: TcxGridDBColumn;
    tvRoomResisPercentage: TcxGridDBColumn;
    StoreMain: TcxPropertiesStore;
    panRoomNotes: TsPanel;
    clabPaymentNotes: TsLabel;
    sPanel6: TsPanel;
    clabRoomNotes: TsLabel;
    mCurrency: TdxMemData;
    m_Currency: TWideStringField;
    WideStringField1: TWideStringField;
    m_AValue: TFloatField;
    m_ID: TIntegerField;
    m_active: TBooleanField;
    DS: TDataSource;
    sPanel7: TsPanel;
    cxButton1: TsButton;
    sLabel9: TsLabel;
    edInvRefrence: TsEdit;
    sButton3: TsButton;
    sButton4: TsButton;
    tvRoomResMainGuest: TcxGridDBColumn;
    _kbmRoomRatesTmp: TkbmMemTable;
    btnClearLog: TsButton;
    sButton2: TsButton;
    sButton5: TsButton;
    sButton6: TsButton;
    sButton7: TsButton;
    edCustomer: TsEdit;
    btnGetCustomer: TsSpeedButton;
    btnGetLastCustomer: TsSpeedButton;
    edMarketSegmentCode: TsEdit;
    btnGetMarketSegment: TsSpeedButton;
    clabContactAddress: TsLabel;
    edContactAddress1: TsEdit;
    edContactAddress2: TsEdit;
    edContactAddress3: TsEdit;
    edContactAddress4: TsEdit;
    chkContactIsGuest: TsCheckBox;
    clabContactPhone: TsLabel;
    edContactPhone: TsEdit;
    clabContactFax: TsLabel;
    edContactFax: TsEdit;
    clabContactEmail: TsLabel;
    edContactEmail: TsEdit;
    memCustomerAlert: TMemo;
    clabGuestCountry: TsLabel;
    edCountry: TsEdit;
    sSpeedButton1: TsSpeedButton;
    labCountryName: TsLabel;
    mnuFinish: TPopupMenu;
    mnuFinishAndShow: TMenuItem;
    memReservationPaymentInfo: TsMemo;
    gbxRate: TsGroupBox;
    clabCurrency: TsLabel;
    clabDiscountPerc: TsLabel;
    clabPcCode: TsLabel;
    labCurrencyName: TsLabel;
    labCurrencyRate: TsLabel;
    btnGetCurrency: TsSpeedButton;
    sSpeedButton2: TsSpeedButton;
    labPcCodeName: TsLabel;
    edRoomResDiscount: TsSpinEdit;
    cbxIsRoomResDiscountPrec: TsComboBox;
    edCurrency: TsEdit;
    edPcCode: TsEdit;
    gbxRefresh: TsGroupBox;
    btnRefresh: TsButton;
    sButton1: TsButton;
    clabMarketSegmentCode: TsLabel;
    clabReservationType: TsLabel;
    memRoomNotes: TDBMemo;
    sLabPackage: TsLabel;
    edPackage: TsEdit;
    sSpeedButton3: TsSpeedButton;
    labPackageDescription: TsLabel;
    tvRoomResPackage: TcxGridDBColumn;
    tvRoomResPackagePrice: TcxGridDBColumn;
    btnAutoSelectRooms: TsButton;
    btnSetAllAsNoRoom: TsButton;
    chkSendConfirmation: TsCheckBox;
    lblContactZip: TsLabel;
    lblContactCity: TsLabel;
    lbContactCountry: TsLabel;
    edContactCountry: TsEdit;
    sSpeedButton4: TsSpeedButton;
    lbContactCountryName: TsLabel;
    lblPortfolio: TsLabel;
    edtPortfolio: TsEdit;
    btnPortfolio: TsSpeedButton;
    btnPortfolioLookup: TsSpeedButton;
    edContactPerson: TRoomerFilterComboBox;
    cbxAddToGuestProfiles: TsCheckBox;
    timNew: TTimer;
    lblNew: TsLabel;
    tvRoomRatesCurrency: TcxGridDBColumn;
    tvRoomRatesCurrencyRate: TcxGridDBColumn;
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
    mRoomRates: TdxMemData;
    mRoomRatesReservation: TIntegerField;
    mRoomRatesroomreservation: TIntegerField;
    mRoomRatesRoomNumber: TStringField;
    mRoomRatesRateDate: TDateTimeField;
    mRoomRatesPriceCode: TStringField;
    mRoomRatesRate: TFloatField;
    mRoomRatesDiscount: TFloatField;
    mRoomRatesisPercentage: TBooleanField;
    mRoomRatesShowDiscount: TBooleanField;
    mRoomRatesisPaid: TBooleanField;
    mRoomRatesDiscountAmount: TFloatField;
    mRoomRatesRentAmount: TFloatField;
    mRoomRatesNativeAmount: TFloatField;
    mRoomRatesTmp: TdxMemData;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    StringField3: TStringField;
    DateTimeField2: TDateTimeField;
    StringField5: TStringField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    BooleanField1: TBooleanField;
    BooleanField2: TBooleanField;
    BooleanField3: TBooleanField;
    FloatField3: TFloatField;
    FloatField4: TFloatField;
    FloatField5: TFloatField;
    mRR_: TdxMemData;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    StringField8: TStringField;
    DateTimeField3: TDateTimeField;
    StringField9: TStringField;
    FloatField7: TFloatField;
    FloatField8: TFloatField;
    BooleanField4: TBooleanField;
    BooleanField5: TBooleanField;
    BooleanField6: TBooleanField;
    FloatField9: TFloatField;
    FloatField10: TFloatField;
    FloatField11: TFloatField;
    StringField10: TStringField;
    FloatField12: TFloatField;
    mRoomResRatePlanCode: TStringField;
    mRoomResManualChannelId: TIntegerField;
    tvRoomResRatePlanCode: TcxGridDBColumn;
    sLabel1: TsLabel;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    sPanel5: TsPanel;
    edtRatePlans: TsComboBox;
    lblRatePlan: TsLabel;
    chkAutoUpdateNullPrice: TsCheckBox;
    pgcExtraAndAlert: TsPageControl;
    sTabSheet1: TsTabSheet;
    sPanel2: TsPanel;
    lblExtraCurrency: TsLabel;
    lblExtraIncludedInRate: TsLabel;
    Shape1: TShape;
    lblPerPerson: TsLabel;
    lblExtraBedCurrency: TsLabel;
    lblOnGroupInvoice: TsLabel;
    lblPrice: TsLabel;
    cbxBreakfast: TsCheckBox;
    cbxBreakfastIncl: TsCheckBox;
    edtBreakfast: TsEdit;
    cbxExtraBedIncl: TsCheckBox;
    cbxExtraBed: TsCheckBox;
    edtExtraBed: TsEdit;
    cbxBreakfastGrp: TsCheckBox;
    cbxExtraBedGrp: TsCheckBox;
    Alerts: TsTabSheet;
    procedure FormShow(Sender : TObject);
    procedure edCustomerDblClick(Sender: TObject);
    procedure edCustomerPropertiesEditValueChanged(Sender: TObject);
    procedure edCustomerExit(Sender: TObject);
    procedure edCustomerKeyPress(Sender: TObject; var Key: Char);
    procedure btnFinishClick(Sender: TObject);
    procedure edCountryDblClick(Sender: TObject);
    procedure edCountryKeyPress(Sender: TObject; var Key: Char);
    procedure edMarketSegmentCodeExit(Sender: TObject);
    procedure edMarketSegmentCodeDblClick(Sender: TObject);
    procedure edMarketSegmentCodeKeyPress(Sender: TObject; var Key: Char);
    procedure edMarketSegmentCodePropertiesChange(Sender: TObject);
    procedure edCurrencyDblClick(Sender: TObject);
    procedure edPcCodePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure edPcCodeDblClick(Sender: TObject);
    procedure edPcCodeExit(Sender: TObject);
    procedure edPcCodeKeyPress(Sender: TObject; var Key: Char);
    procedure btnNextClick(Sender: TObject);
    procedure btnPreviusClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure pgcMainChange(Sender: TObject);
    procedure btdEditRoomRateClick(Sender: TObject);
    procedure tvRoomResColumn1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure btnEditRateAllRoomsClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure mSelectTypesBeforePost(DataSet: TDataSet);
    procedure mSelectRoomsNewRecord(DataSet: TDataSet);
    procedure tvSelectRoomsRoomPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvSelectTypeSelectedPropertiesEditValueChanged(Sender: TObject);
    procedure tvSelectTypeNoRoomsPropertiesEditValueChanged(Sender: TObject);
    procedure mSelectTypesCalcFields(DataSet: TDataSet);
    procedure tvSelectRoomsSelectPropertiesEditValueChanged(Sender: TObject);
    procedure btnAutoSelectRoomsClick(Sender: TObject);
    procedure tvRoomResAvragePricePropertiesEditValueChanged(Sender: TObject);
    procedure tvRoomResGuestsPropertiesEditValueChanged(Sender: TObject);
    procedure tvRoomResChildrenCountPropertiesEditValueChanged(Sender: TObject);
    procedure tvRoomResinfantCountPropertiesEditValueChanged(Sender: TObject);
    procedure dtDepartureExit(Sender: TObject);
    procedure dtArrivalExit(Sender: TObject);
    procedure edNightsChange(Sender: TObject);
    procedure edCurrencyExit(Sender: TObject);
    procedure btnSetAllAsNoRoomClick(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure tvSelectTypeSelectedPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure tvSelectTypeNoRoomsPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure sButton4Click(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure btnClearLogClick(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure sButton5Click(Sender: TObject);
    procedure sButton6Click(Sender: TObject);
    procedure sButton7Click(Sender: TObject);
    procedure edCountryExit(Sender: TObject);
    procedure dtArrivalCloseUp(Sender: TObject);
    procedure dtDepartureCloseUp(Sender: TObject);
    procedure dtArrivalChange(Sender: TObject);
    procedure dtDepartureChange(Sender: TObject);
    procedure edCountryChange(Sender: TObject);
    procedure edCustomerChange(Sender: TObject);
    procedure btnGetLastCustomerClick(Sender: TObject);
    procedure edCurrencyChange(Sender: TObject);
    procedure edPcCodeChange(Sender: TObject);
    procedure edMarketSegmentCodeChange(Sender: TObject);
    procedure cbxIsRoomResDiscountPrecChange(Sender: TObject);
    procedure F1Click(Sender: TObject);
    procedure mnuFinishAndShowClick(Sender: TObject);
    procedure edCustomerKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edMarketSegmentCodeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edCountryKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edCurrencyKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edPcCodeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edCurrencyKeyPress(Sender: TObject; var Key: Char);
    procedure edPackageDblClick(Sender: TObject);
    procedure edPackageExit(Sender: TObject);
    procedure tvRoomResPackagePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure chkisGroupInvoiceClick(Sender: TObject);
    procedure cbxRoomStatusCloseUp(Sender: TObject);
    procedure edContactEmailChange(Sender: TObject);
    procedure edContactCountryDblClick(Sender: TObject);
    procedure edContactCountryChange(Sender: TObject);
    procedure edContactCountryKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnPortfolioClick(Sender: TObject);
    procedure btnPortfolioLookupClick(Sender: TObject);
    procedure edContactPersonCloseUp(Sender: TObject);
    procedure edContactPersonKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tvRoomResMainGuestPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure timNewTimer(Sender: TObject);
    procedure edContactPersonEnter(Sender: TObject);
    procedure edContactPersonExit(Sender: TObject);
    procedure cbxBreakfastClick(Sender: TObject);
    procedure lblExtraBedCurrencyClick(Sender: TObject);
    procedure edtRatePlansCloseUp(Sender: TObject);
    procedure tvRoomResRatePlanCodePropertiesCloseUp(Sender: TObject);
    procedure tvRoomResRatePlanCodePropertiesEditValueChanged(Sender: TObject);
    procedure tvSelectTypeTotalFreePropertiesChange(Sender: TObject);
    procedure tvSelectTypeNoRoomsPropertiesChange(Sender: TObject);
    procedure tvSelectTypeNoRoomsStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
  private
    { Private declarations }
    zCustomerChanged : Boolean;
    zIsFirstTime : boolean;

    FrmAlertPanel: TFrmAlertPanel;



    zRtInRoom : integer;
    zRtNoRoom : integer;
    zRtTotal  : integer;

    zTotalSelected : integer;       //0
    zTotalRoomsSelected : integer;  //4
    zTotalAvailable : integer;      //3
    zTotalFree      : integer;      //2
    zTotalNoRooms   : integer;      //1

    zTotal : integer;


    zNights : integer;
    FOutOfOrderBlocking: Boolean;

    DynamicRates : TDynamicRates;


    procedure initCustomer;
    function RoomStatusFromInfo(statusText : string) : integer;
    function RoomStatusToInfo(Index : integer) : string;
    function Apply : boolean;
    procedure addAvailableRoomTypes;
    procedure SetAllAsNoRoom(doNextPage : boolean=true);

    function customerValidate : boolean;
    function CountryValidate : boolean;
    function MarketSegmentValidate : boolean;
    function CurrencyValidate(ed : TsEdit; lab,labName : TsLabel) : boolean;
    function PriceCodeValidate(ed : TsEdit; lab, labName : TsLabel) : boolean;
    function PackageValidate(ed : TsEdit; lab, labName : TsLabel) : boolean;

    procedure ApplyRateToOther(RoomReservation : integer; RoomType : string);
    procedure ApplyNettoRateToNullPrice(NewRate : double;RoomReservation: integer; RoomType : string);

    procedure getSelectRooms;
    procedure InitSelectRooms;

    function CreateRoomRes_Quick : Boolean;
    procedure CreateRoomRes_Normal;

    procedure EditRoomRateOneRoom(RoomRes : integer) ;
    procedure GetPrices;

    procedure UpdateStat;

   function doAutoSelect(RoomType : string; NumRooms : integer; PriorityRule : string) : integer;
   function CalcOnePrice(roomreservation : integer; Newrate : double = 0) : boolean;
   Procedure fillCurrencyFromDataset(sGoto : string);

   procedure SetOutOfOrderBlocking(const Value: Boolean);
    procedure FillQuickFind;
    procedure ShowhideExtraInputs;
    procedure ShowRatePlans;
    procedure PopulateRatePlanCombo;
    function SetOnePrice(RoomReservation: Integer; rateId: String; channelId: Integer): boolean;
    property OutOfOrderBlocking : Boolean read FOutOfOrderBlocking write SetOutOfOrderBlocking;

  public
    { Public declarations }
    oNewReservation : TNewReservation;
    procedure WndProc(var message: TMessage); override;
  end;

var
  frmMakeReservationQuick : TfrmMakeReservationQuick;

implementation

uses
    ug
  , ud
  , uSqlDefinitions
  , _Glob
  , PrjConst

  , uMain
  , uCurrencies
  , uPriceCodes
  , uCountries
  , ueditRoomPrice
  , uCustomers2
  , uCustomerTypes2
  , objDayFreeRooms
  , uAppGlobal
  , uDayNotes
  , uPackages
  , uGuestProfiles
  , uRoomerDefinitions
  , uDateUtils
  , uAvailabilityPerDay

  ;

{$R *.dfm}

const WM_SET_COMBO_TEXT = WM_User + 101;
      WM_SET_EMPTY_TEXT = WM_User + 102;

function TfrmMakeReservationQuick.RoomstatusFromInfo(statusText : string) : integer;
begin
  Result := 0;
  if StatusText = 'P' then Result := 0;
  if StatusText = 'G' then Result := 1;
  if StatusText = 'A' then Result := 2;
  if StatusText = 'O' then Result := 3;
  if StatusText = 'N' then Result := 4;
  if StatusText = 'D' then Result := 5;
  if StatusText = 'B' then Result := 6;
end;

function TfrmMakeReservationQuick.RoomstatusToInfo(index : integer) : string;
begin
  Result := '';
  if Index = 0 then Result :='P'  ;
  if Index = 1 then Result :='G'  ;
  if Index = 2 then Result :='A'  ;
  if Index = 3 then Result :='O'  ;
  if Index = 4 then Result :='N'  ;
  if Index = 5 then Result :='D'  ;
  if Index = 6 then Result :='B'  ;
  if Index = 7 then Result :='B'  ;
end;

procedure TfrmMakeReservationQuick.sButton3Click(Sender: TObject);
var
  roomReservation : integer;
begin
  RoomReservation := mRoomRes.FieldByName('RoomReservation').AsInteger;
  ApplyRateToOther(roomreservation,'');
end;

procedure TfrmMakeReservationQuick.sButton4Click(Sender: TObject);
var
  roomType        : string;
  roomReservation : integer;
begin
  roomType        := mRoomRes.FieldByName('RoomType').AsString;
  RoomReservation := mRoomRes.FieldByName('RoomReservation').AsInteger;
  ApplyRateToOther(roomreservation,RoomType)
end;

procedure TfrmMakeReservationQuick.ApplyRateToOther(RoomReservation: integer; RoomType : string);
var
  Reservation     : integer;
  RoomNumber      : string;
  RateDate        : TDateTime;
  PriceCode       : string;
  Rate            : double;
  Discount        : double;
  isPercentage    : boolean;
  ShowDiscount    : boolean;
  isPaid          : boolean;
  DiscountAmount  : double;
  RentAmount      : double;
  NativeAmount    : double;

  Arrival   : TdateTime;
  Departure : TdateTime;
  Guests    : integer;
  ChildrenCount : integer;
  infantCount   : integer;

  AvragePrice    : double;
  RateCount      : integer;
  AvrageDiscount : double;
  room           : string;

  i : integer;

  found : boolean;
  currentRoomReservation : integer;
  currentRoomType        : string;
  ManualChannelId : Integer;
  ratePlanCode : String;


begin
//  RoomReservation := mRoomRes.FieldByName('RoomReservation').AsInteger;
//  roomType        := mRoomRes.FieldByName('RoomType').AsString;

  Arrival         := mRoomRes.FieldByName('Arrival').AsDateTime;
  Departure       := mRoomRes.FieldByName('Departure').AsDateTime;
  Guests          := mRoomRes.FieldByName('Guests').AsInteger;
  ChildrenCount   := mRoomRes.FieldByName('ChildrenCount').AsInteger;
  infantCount     := mRoomRes.FieldByName('infantCount').AsInteger;
  AvragePrice     :=  mRoomRes.FieldByName('AvragePrice').AsFloat    ;
  RateCount       :=  mRoomRes.FieldByName('RateCount').AsInteger    ;
  PriceCode       :=  mRoomRes.FieldByName('PriceCode').AsString     ;
  AvrageDiscount  :=  mRoomRes.FieldByName('AvrageDiscount').AsFloat ;
  isPercentage    :=  mRoomRes.FieldByName('isPercentage').AsBoolean ;
  ManualChannelId := mRoomRes.FieldByName('ManualChannelId').AsInteger;
  ratePlanCode    := mRoomRes.FieldByName('ratePlanCode').AsString;

  if mRoomRatesTmp.active then mRoomRatesTmp.Close;
  mRoomRatesTmp.Open;
  mRoomRatesTmp.LoadFromDataSet(mRoomRates);

  mRoomRatesTmp.Filter   := '(Roomreservation='+inttostr(roomreservation)+')';
  mRoomRatesTmp.Filtered := true;

  //apply to same roomtype
  mRoomRates.DisableControls;
  mRoomRes.DisableControls;
  try
      mRoomRes.First;
      while not mRoomRes.eof do
      begin
        if roomtype <> '' then
        begin
          if (mRoomRes.FieldByName('RoomType').AsString <> roomType) then
          begin
            mRoomRes.next;
            continue;
          end;
        end;
        if
          (mRoomRes.FieldByName('RoomReservation').AsInteger <> RoomReservation)
           AND (mRoomRes.FieldByName('Arrival').AsDateTime = Arrival)
           AND (mRoomRes.FieldByName('Departure').AsDateTime = Departure)
        then
        begin
          currentRoomReservation := mRoomRes.FieldByName('RoomReservation').AsInteger;
          repeat
            found :=  mRoomRates.Locate('roomreservation',currentRoomreservation,[]);
            if found then
            begin
              mRoomRates.Delete;
            end;
          until not found;
          mRoomRatesTmp.First;
          while not mRoomRatesTmp.eof do
          begin
            RateDate        :=  mRoomRatesTmp.FieldByName('RateDate'       ).AsDateTime;
            Room            :=  mRoomRatesTmp.FieldByName('RoomNumber'     ).AsString;
            PriceCode       :=  mRoomRatesTmp.FieldByName('PriceCode'      ).Asstring;
            Rate            :=  mRoomRatesTmp.FieldByName('Rate'           ).Asfloat;
            Discount        :=  mRoomRatesTmp.FieldByName('Discount'       ).Asfloat;
            isPercentage    :=  mRoomRatesTmp.FieldByName('isPercentage'   ).Asboolean;
            ShowDiscount    :=  mRoomRatesTmp.FieldByName('ShowDiscount'   ).Asboolean;
            isPaid          :=  mRoomRatesTmp.FieldByName('isPaid'         ).Asboolean;
            DiscountAmount  :=  mRoomRatesTmp.FieldByName('DiscountAmount' ).Asfloat;
            RentAmount      :=  mRoomRatesTmp.FieldByName('RentAmount'     ).Asfloat;
            NativeAmount    :=  mRoomRatesTmp.FieldByName('NativeAmount'   ).Asfloat;


            mRoomRates.append;
            mRoomRates.FieldByName('Reservation').AsInteger := -1;
            mRoomRates.FieldByName('RoomReservation').AsInteger := CurrentRoomreservation;
            mRoomRates.FieldByName('RoomNumber').AsString := Room;
            mRoomRates.FieldByName('RateDate').AsDateTime := rateDate;
            mRoomRates.FieldByName('PriceCode').AsString := PriceCode;
            mRoomRates.FieldByName('Rate').AsFloat := Rate;
            mRoomRates.FieldByName('Discount').AsFloat := Discount;
            mRoomRates.FieldByName('isPercentage').AsBoolean := isPercentage;
            mRoomRates.FieldByName('ShowDiscount').AsBoolean := ShowDiscount;
            mRoomRates.FieldByName('isPaid').AsBoolean := isPaid;
            mRoomRates.FieldByName('DiscountAmount').AsFloat := DiscountAmount;
            mRoomRates.FieldByName('RentAmount').AsFloat := RentAmount;
            mRoomRates.FieldByName('NativeAmount').AsFloat := NativeAmount;
            mRoomRates.FieldByName('Currency').AsString := mRoomRatesTmp.FieldByName('Currency').AsString;
            mRoomRates.FieldByName('CurrencyRate').AsFloat := mRoomRatesTmp.FieldByName('CurrencyRate').Asfloat;
            mRoomRates.post;
            mRoomRatesTmp.Next;
          end;



         mRoomRes.edit;
         mRoomRes.FieldByName('AvragePrice').AsFloat    :=  AvragePrice     ;
         mRoomRes.FieldByName('RateCount').AsInteger    :=  RateCount       ;
         mRoomRes.FieldByName('PriceCode').AsString     :=  PriceCode       ;
         mRoomRes.FieldByName('AvrageDiscount').AsFloat :=  AvrageDiscount  ;
         mRoomRes.FieldByName('isPercentage').AsBoolean :=  isPercentage    ;
         mRoomRes.FieldByName('ManualChannelId').AsInteger := ManualChannelId;
         mRoomRes.FieldByName('ratePlanCode').AsString  := ratePlanCode ;
         mRoomRes.post;
        end;
        mRoomRes.next;
      end;
    mRoomRes.Locate('roomReservation',roomreservation,[]);
  finally
    mRoomRates.EnableControls;
    mRoomRes.EnableControls;
  end;
end;


procedure TfrmMakeReservationQuick.ApplyNettoRateToNullPrice(NewRate : double;RoomReservation: integer; RoomType : string);
var
  CurrentRoomreservation : integer;
begin
  mRoomRates.DisableControls;
  mRoomRes.DisableControls;
  try
      mRoomRes.First;
      while not mRoomRes.eof do
      begin
        if roomtype <> '' then
        begin
          if (mRoomRes.FieldByName('RoomType').AsString <> roomType) then
          begin
            mRoomRes.next;
            continue;
          end;
        end;
        if
          (mRoomRes.FieldByName('RoomReservation').AsInteger <> RoomReservation)
        then
        begin
          currentRoomReservation := mRoomRes.FieldByName('RoomReservation').AsInteger;
          if mRoomRes.FieldByName('AvragePrice').asFloat = 0 then
          begin
            CalcOnePrice(currentroomreservation,newRate);
          end;
        end;
        mRoomRes.next;
      end;
    mRoomRes.Locate('roomReservation',roomreservation,[]);
  finally
    mRoomRates.EnableControls;
    mRoomRes.EnableControls;
  end;
end;



procedure TfrmMakeReservationQuick.UpdateStat;
begin
//  if not mSelectTypes.active then exit;
//  zRtInRoom := mSelectTypes.FieldByName('Selected').AsInteger;
//  zRtNoRoom := mSelectTypes.FieldByName('NoRooms').AsInteger;
//  zRtTotal  := zRtInRoom+zRtNoRoom;
//  labRtInRoom.caption    :=  inttostr(zRtInRoom);
//  labRtNoRoom.caption    :=  inttostr(zRtNoRoom);
//  labRtTotal.caption     :=  inttostr(zRtTotal);
end;

procedure TfrmMakeReservationQuick.WndProc(var message: TMessage);
var s : String;
begin
  inherited;
  if message.Msg = WM_SET_EMPTY_TEXT then
  begin
    edContactAddress1.Text := '';
    edContactAddress2.Text := '';
    edContactAddress3.Text := '';
    edContactAddress4.Text := '';
//0810-hj    edContactCountry.Text := ctrlGetString('Country');
    edContactPhone.Text := '';
    edContactFax.Text := '';
    edContactEmail.Text := '';

    cbxAddToGuestProfiles.Visible := True;
    edtPortfolio.Tag := 0;
  end else
  if message.Msg = WM_SET_COMBO_TEXT then
  begin
    if message.WParam = 1 then
    begin
      edContactPerson.Text := glb.PreviousGuestsSet['Name'];
      edContactAddress1.Text := glb.PreviousGuestsSet['Address1'];
      edContactAddress2.Text := glb.PreviousGuestsSet['Address2'];
      edContactAddress3.Text := glb.PreviousGuestsSet['Address3'];
      edContactAddress4.Text := glb.PreviousGuestsSet['Address4'];
//0810-hj       edContactCountry.Text := glb.PreviousGuestsSet['Country'];
      s := glb.PreviousGuestsSet['Tel1'];
      if s = '' then
        s := glb.PreviousGuestsSet['Tel2'];
      edContactPhone.Text := s;
      edContactFax.Text := ''; // glb.PreviousGuestsSet['TelFax'];
      edContactEmail.Text := glb.PreviousGuestsSet['Email'];
    end else
    begin
      edContactPerson.Text := Trim(glb.PersonProfiles['Firstname'] + ' ' + glb.PersonProfiles['Lastname']);
      edContactAddress1.Text := glb.PersonProfiles['Address1'];
      edContactAddress2.Text := glb.PersonProfiles['Address2'];
      edContactAddress3.Text := glb.PersonProfiles['Zip'];
      edContactAddress4.Text := glb.PersonProfiles['City'];
//0810-hj       edContactCountry.Text := glb.PersonProfiles['Country'];
      s := glb.PersonProfiles['TelMobile'];
      if s = '' then
        s := glb.PersonProfiles['TelLandLine'];
      edContactPhone.Text := s;
      edContactFax.Text := glb.PersonProfiles['TelFax'];
      edContactEmail.Text := glb.PersonProfiles['Email'];
    end;
  end;
end;

/////////////////////////////////////////////////////////////////////////////////////////////////
//  FORM
/////////////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmMakeReservationQuick.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  screen.Cursor := crHourGlass;
  try
    DynamicRates := TDynamicRates.Create;
    zisFirstTime              := true ;
    zRtInRoom := 0;
    zRtNoRoom := 0;
    zRtTotal  := 0;

    taReservation.TabVisible  := false;
    tabSelectType.TabVisible  := false;
    tabSelectRooms.TabVisible := false;
    tabRoomRates.TabVisible   := false;
    pgcMain.ActivePageIndex   := 0    ;
  finally
    screen.Cursor := crDefault;
  end;

  pgcExtraAndAlert.ActivePageIndex := 0;
end;

procedure TfrmMakeReservationQuick.FillQuickFind;
var rSet : TRoomerDataSet;

  function getFullname : String;
  begin
    result := Trim(rSet['FirstName'] + ' ' + rSet['Lastname']);
  end;

  function getField(fName : String) : String;
  var s : String;
  begin
    s := rSet[FName];
    if s = '' then
      result := ''
    else
      result := ', ' + s;
  end;

var item : TRoomerFilterItem;

begin
  rSet := glb.PersonProfiles;
  edContactPerson.StoredItems.Clear;
  rSet.First;
  while NOT rSet.Eof do
  begin
    item := TRoomerFilterItem.Create;
    item.Key := inttostr(rSet['ID']);
    item.Line := format('%s%s%s%s', [getFullname, getField('City'), getField('Country'), getField('Address1')]);
    edContactPerson.StoredItems.Add(item);
    rSet.Next;
  end;

  rSet := glb.PreviousGuestsSet;
  rSet.First;
  while NOT rSet.Eof do
  begin
    item := TRoomerFilterItem.Create;
    item.Key := rSet['ID'];
    item.Line := format('%s%s%s%s', [rSet['Name'], getField('Address4'), getField('Country'), getField('Address1')]);
    edContactPerson.StoredItems.Add(item);
    rSet.Next;
  end;

//  cbActiveLiveSearch.Checked := False;
//  cbActiveLiveSearchClick(cbActiveLiveSearch);
  if edContactPerson.StoredItems.Count > 0 then
    edContactPerson.Start;
end;

procedure TfrmMakeReservationQuick.FormDestroy(Sender: TObject);
begin
  DynamicRates.Free;
end;

procedure TfrmMakeReservationQuick.ShowhideExtraInputs;
begin
  cbxBreakfastIncl.Visible := cbxBreakfast.Checked;
  edtBreakfast.Visible := cbxBreakfast.Checked AND (NOT cbxBreakfastIncl.Checked);
  lblExtraCurrency.Visible := edtBreakfast.Visible;
  lblPerPerson.Visible := edtBreakfast.Visible;
  cbxBreakfastGrp.Visible := edtBreakfast.Visible AND chkisGroupInvoice.Checked;
  lblOnGroupInvoice.Visible := edtBreakfast.Visible AND chkisGroupInvoice.Checked;

  cbxExtraBedIncl.Visible := cbxExtraBed.Checked;
  edtExtraBed.Visible := cbxExtraBed.Checked AND (NOT cbxExtraBedIncl.Checked);
  lblExtraBedCurrency.Visible := edtExtraBed.Visible;
  cbxExtraBedGrp.Visible := edtExtraBed.Visible AND chkisGroupInvoice.Checked;

end;

procedure TfrmMakeReservationQuick.ShowRatePlans;
var res : TRoomerDataSet;
begin
  edtRatePlans.Items.Clear;
  edtRatePlans.Items.AddObject('<none>', nil);
  res := glb.GetDataSetFromDictionary('channels');
  res.First;
  while NOT res.Eof do
  begin
    edtRatePlans.Items.AddObject(res['name'], TObject(res.FieldByName('id').AsInteger));
    res.Next;
  end;
  edtRatePlans.ItemIndex := 0;
end;

procedure TfrmMakeReservationQuick.FormShow(Sender : TObject);
begin
//  pgcMain.Properties.HideTabs := false;

  FillQuickFind;
  screen.Cursor := crHourglass;
  try
    //cbxResMedhod.ItemIndex := 0;
    cbxIsRoomResDiscountPrec.ItemIndex := 0;
    edCustomer.text := oNewReservation.HomeCustomer.Customer;
    initCustomer;

    cbxBreakfast.Checked := ctrlGetBoolean('BreakfastInclDefault');
    cbxBreakfastIncl.Checked := cbxBreakfast.Checked;
    lblExtraCurrency.Caption := g.qNativeCurrency;
    lblExtraBedCurrency.Caption := edCurrency.Text;

    cbxExtraBed.Visible := False;
    cbxExtraBed.Checked := False;
    ShowhideExtraInputs;

    chkExcluteWaitingList.checked := g.qExcluteWaitingList ;
    chkExcluteAllotment.checked :=   g.qExcluteAllotment   ;
    chkExcluteOrder.checked :=       g.qExcluteOrder       ;
    chkExcluteDeparted.checked :=    g.qExcluteDeparted    ;
    chkExcluteGuest.checked :=       g.qExcluteGuest       ;
    chkExcluteBlocked.checked :=     g.qExcluteBlocked     ;
    chkExcluteNoshow.checked :=      g.qExcluteNoshow      ;

    if oNewReservation.IsQuick then
    begin
  	  caption := GetTranslatedText('shTx_QuickReservation_NewReservationQuick');
      dtArrival.date   := oNewReservation.newRoomReservations.ReservationArrival;
      dtDeparture.Date := oNewReservation.newRoomReservations.ReservationDeparture;
      gbxDates.Enabled := false;
      btnFinish.Enabled := false;
      edCustomer.SetFocus;
    end else
    begin
   	  caption := GetTranslatedText('shTx_QuickReservation_NewReservation');
      dtArrival.date   := trunc(frmMain.resDateFrom); // trunc(now);
      dtDeparture.date := trunc(frmMain.resDateTo); // trunc(now+1);
      btnFinish.Enabled := false;
      edNights.SetFocus;
    end;
    edNights.Value := trunc(dtdeparture.date)-Trunc(dtArrival.date);

    memRoomNotes.Enabled := false;
    clabRoomNotes.Visible := false;

    ShowRatePlans;
  finally
    screen.Cursor := crDefault;
  end;

  chkSendConfirmation.Enabled := False;

  cbxAddToGuestProfiles.Visible := False;

  FrmAlertPanel := TFrmAlertPanel.Create(nil);
  FrmAlertPanel.PlaceEditPanel(Alerts, oNewReservation.AlertList);
end;

///////////////////////////////////////////////////////////////////////////////////////////
//  RoomRes grid and table
///////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmMakeReservationQuick.timNewTimer(Sender: TObject);
begin
  postMessage(handle, WM_SET_EMPTY_TEXT, 1, 0);
  timNew.Enabled := False;
end;

procedure TfrmMakeReservationQuick.tvRoomResAvragePricePropertiesEditValueChanged(Sender: TObject);
var
  roomreservation : integer;
  roomType : string;
  oldRate : double;
  newrate : double;
begin
  roomreservation := mRoomRes.fieldbyname('RoomReservation').AsInteger;
  oldRate := mRoomRes.FieldByName('avragePrice').AsFloat;
  roomType := mRoomRes.FieldByName('RoomType').AsString;

  mRoomRes.post;
  NewRate     := mRoomRes.FieldByName('avragePrice').AsFloat;

  if oldrate <> newrate then
  begin
    CalcOnePrice(roomreservation,newRate);
  end;

  if chkAutoUpdateNullPrice.checked then
  begin
    ApplyNettoRateToNullPrice(NewRate,RoomReservation,roomType);
  end;
end;

procedure TfrmMakeReservationQuick.tvRoomResChildrenCountPropertiesEditValueChanged(Sender: TObject);
var
  roomreservation : integer;
  oldValue   : integer;
  newValue   : integer;
begin
  oldValue   := mRoomRes.fieldbyname('ChildrenCount').AsInteger;
  roomreservation := mRoomRes.fieldbyname('RoomReservation').AsInteger;
  mRoomRes.Post;
  NewValue   := mRoomRes.fieldbyname('ChildrenCount').AsInteger;
  if newValue <> oldVAlue then
  begin
    CalcOnePrice(roomreservation);
  end;
end;

procedure TfrmMakeReservationQuick.tvRoomResColumn1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  RoomReservation  : integer  ;
begin
  roomReservation := mRoomRes.FieldByName('roomreservation').AsInteger;
  EditRoomRateOneRoom(RoomReservation);
end;

procedure TfrmMakeReservationQuick.tvRoomResGuestsPropertiesEditValueChanged(Sender: TObject);
var
  roomreservation : integer;
  oldValue   : integer;
  newValue   : integer;
begin
  oldValue   := mRoomRes.fieldbyname('guests').AsInteger;
  roomreservation := mRoomRes.fieldbyname('RoomReservation').AsInteger;
  mRoomRes.Post;
  NewValue   := mRoomRes.fieldbyname('guests').AsInteger;
  if newValue <> oldVAlue then
  begin
    CalcOnePrice(roomreservation);
  end;
end;

procedure TfrmMakeReservationQuick.tvRoomResinfantCountPropertiesEditValueChanged(Sender: TObject);
var
  roomreservation : integer;
  oldValue   : integer;
  newValue   : integer;
begin
  oldValue   := mRoomRes.fieldbyname('infantCount').AsInteger;
  roomreservation := mRoomRes.fieldbyname('RoomReservation').AsInteger;
  mRoomRes.Post;
  NewValue   := mRoomRes.fieldbyname('InfantCount').AsInteger;
  if newValue <> oldVAlue then
  begin
    CalcOnePrice(roomreservation);
  end;
end;

procedure TfrmMakeReservationQuick.tvRoomResMainGuestPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var sName : String;
    iId : Integer;
begin
  iId := GuestProfiles(actLookup, 0);
  if iId > 0 then
  begin
    if glb.LocateSpecificRecord('personprofiles', 'ID', inttostr(iId)) then
    begin
      mRoomRes.Edit;
      mRoomRes['MainGuest'] := Trim(glb.PersonProfiles['FirstName'] + ' ' + glb.PersonProfiles['LastName']);
      mRoomRes.FieldByName('PersonsProfilesId').AsInteger := iId;
      mRoomRes.Post;
    end;
  end;
end;

procedure TfrmMakeReservationQuick.tvRoomResPackagePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData  : recPackageHolder;
  roomPrice : double;
  itemPrice : double;
  newRoomPrice : double;
  packagePrice : double;
  package : string;
  rr : integer;
  guestCount : integer;
  nightCount : integer;
begin
  roomPrice := 0;
  itemPrice := 0;
  rr := mRoomRes.FieldByName('roomreservation').Asinteger;
  initPackageHolder(thedata);
  theData.package := mRoomRes.FieldByName('Package').AsString;
  if openPackages(actLookup,theData) then
  begin
    package := theData.package;
  end;

  guestCount := mRoomRes.FieldByName('Guests').AsInteger;
  nightCount := trunc(mRoomRes.FieldByName('Departure').AsDateTime) - trunc(mRoomRes.FieldByName('Arrival').AsDateTime);

  if trim(package) <> '' then
  begin
    Package_getRoomPrice(package,nightCount,guestCount,roomPrice,ItemPrice);
    if roomprice = 0  then
    begin
      newRoomPrice := mRoomRes.FieldByName('AvragePrice').AsFloat;
    end else
    begin
      newRoomPrice := roomPrice;
    end;

    if newRoomprice > 0 then
    begin
      mRoomRes.Edit;
      mRoomRes.FieldByName('AvragePrice').AsFloat := newRoomprice;
      mRoomRes.FieldByName('AvrageDiscount').AsFloat := 0;
      mRoomRes.FieldByName('RateCount').AsInteger := 1;
      mRoomRes.FieldByName('PackagePrice').AsFloat := newRoomPrice+itemPrice;
      mRoomRes.FieldByName('Package').AsString := package;
      mRoomRes.post;

      mRoomRates.Filter      := '(Roomreservation='+inttostr(rr)+')';
      mRoomRates.Filtered := true;

      mRoomRates.first;
      while not mRoomRates.eof do
      begin
        mRoomRates.Edit;
        mRoomRates.FieldByName('rate').AsFloat := newRoomPrice;
        mRoomRates.FieldByName('discount').AsFloat := 0;
        mRoomRates.FieldByName('isPercentage').AsBoolean := true;
        mRoomRates.FieldByName('discountAmount').asfloat := 0;
        mRoomRates.FieldByName('Rentamount').asfloat := newRoomPrice;
        mRoomRates.FieldByName('NativeAmount').asfloat := newRoomPrice;
        mRoomRates.Post;
        mRoomRates.Next;
      end;
      mRoomRates.Filtered := false;
    end;

//    mRoomRes.edit;
//    mRoomRes.FieldByName('Package').AsString := theData.package;
//    mRoomRes.FieldByName('PackagePrice').AsFloat := packagePrice;
//    mRoomRes.post;

  end;


//  theData.Item := zData.Item;
//
//  openItems(actlookup,true, theData);
//
//  if theData.item <> '' then
//  begin
//    if tvData.DataController.DataSource.State <> dsInsert then m_.Edit;
//    m_['ItemId']   := theData.ID;
//    m_['Item']   := theData.item;
//    m_['Description'] := theData.Description;
//    m_['unitPrice'] := theData.Price;
//    if tvData.DataController.DataSource.State = dsInsert then
//       m_['numItems'] := 1;
//    m_.Post;
//  end;

end;


function TfrmMakeReservationQuick.SetOnePrice(RoomReservation : Integer; rateId : String; channelId : Integer) : boolean;
var

  i,ii : integer;

  Guests              : integer  ;
  AvragePrice         : double   ;
  Arrival             : TdateTime;
  Departure           : TDateTime;
  ADate               : TDate;
  rate          : Double;
  DayCount : Integer;
  rateTotal, rateAvrage : Double;

begin
    if mRoomRes.locate('roomreservation',roomreservation,[]) then
    begin

      i := oNewReservation.newRoomReservations.FindRoomFromRoomReservation(RoomReservation,0);

      arrival             := mRoomRes.FieldByName('arrival').AsDateTime           ;
      departure           := mRoomRes.FieldByName('departure').AsDateTime         ;
      dayCount := trunc(departure)-trunc(arrival);

      for ii := 0  to dayCount-1 do
      begin
          ADate := arrival+ii;
          if mRoomRates.locate('RateDate',ADate,[]) then
          begin
            if DynamicRates.Active AND
              DynamicRates.findRateByRateCode(trunc(arrival)+ii, mRoomRes['Guests'], Rate, rateId) then
            begin
              // Rate acuired

              mRoomRates.Edit;
              mRoomRates.FieldByName('Rate').AsFloat := Rate;
              mRoomRates.post;
            end;
          end;
          rateTotal := rateTotal + rate;
      end;

      rateAvrage := rateTotal / dayCount;

      mRoomRes.edit;
        mRoomRes.FieldByName('AvragePrice').AsFloat := rateAvrage;
        mRoomRes.FieldByName('RateCount').AsFloat := 1;
        mRoomRes.FieldByName('ManualChannelId').AsInteger := channelId;
        mRoomRes.FieldByName('ratePlanCode').AsString := rateId;
      mRoomRes.Post;
    end;
end;


procedure TfrmMakeReservationQuick.tvRoomResRatePlanCodePropertiesCloseUp(Sender: TObject);
var channelId : Integer;
begin
  if NOT mRoomRes.Eof then
  begin
    channelId := 0;
    if edtRatePlans.ItemIndex > 0 then
      channelId := Integer(edtRatePlans.Items.Objects[edtRatePlans.ItemIndex]);
    SetOnePrice(mRoomRes['RoomReservation'],
                (tvRoomResRatePlanCode.Properties AS TcxComboBoxProperties).Items[TcxComboBox(Sender).ItemIndex],
                channelId);
  end;
end;

procedure TfrmMakeReservationQuick.tvRoomResRatePlanCodePropertiesEditValueChanged(Sender: TObject);
begin
  if NOT mRoomRes.Eof then
  begin
    mRoomRes.Edit;
    TcxComboBox(Sender).ItemIndex := (tvRoomResRatePlanCode.Properties AS TcxComboBoxProperties).Items.IndexOf(TcxComboBox(Sender).Text);
    if TcxComboBox(Sender).ItemIndex >= 0 then
      mRoomRes['ratePlanCode'] := (tvRoomResRatePlanCode.Properties AS TcxComboBoxProperties).Items[TcxComboBox(Sender).ItemIndex];
    mRoomRes.Post;
  end;
end;

///////////////////////////////////////////////////////////////////////////////////////////
//  SelectRooms grid and table
///////////////////////////////////////////////////////////////////////////////////////////


procedure TfrmMakeReservationQuick.tvSelectRoomsRoomPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if not mSelectRooms.fieldbyname('Select').asboolean then exit;

  mSelectRooms.Edit;

  if mSelectRooms.FieldByName('Room').AsString = '' then
    mSelectRooms.FieldByName('Room').AsString := mSelectRooms.FieldByName('tmp').AsString else
      mSelectRooms.FieldByName('Room').AsString := '';
end;

procedure TfrmMakeReservationQuick.tvSelectRoomsSelectPropertiesEditValueChanged(Sender: TObject);
var
  roomType : string;
  isSelected : boolean;
  aValue : integer;
begin
  mSelectRooms.Post;
  roomtype   := mSelectRooms.fieldbyname('RoomType').asString;
  isSelected := mSelectRooms.fieldbyname('Select').asBoolean;


  if isSelected then
  begin
    avalue := 1;
  end else
  begin
    aValue := -1
  end;

  if mSelectTypes.Locate('Roomtype',roomtype,[]) then
  begin
    mSelectTypes.Edit;
    mSelectTypes.fieldbyname('RoomsSelected').asinteger := mSelectTypes.fieldbyname('RoomsSelected').asinteger+avalue;
    mSelectTypes.Post;
  end;

  zTotalRoomsSelected := tvSelectType.DataController.Summary.FooterSummaryValues[4];
  labTotalRoomsSelected.Caption := inttostr(zTotalRoomsSelected);
end;

procedure TfrmMakeReservationQuick.tvSelectTypeNoRoomsPropertiesChange(Sender: TObject);
var
  total    : integer;
  norooms  : integer;
  TotalFree : integer;
begin
  noRooms   := mSelectTypes.FieldByName('Norooms').AsInteger;
  totalfree := mSelectTypes.FieldByName('totalFree').AsInteger;
  total     := totalfree-norooms;
  slabel1.Caption := inttostr(total);
end;

procedure TfrmMakeReservationQuick.tvSelectTypeNoRoomsPropertiesEditValueChanged(Sender: TObject);
begin
  if tvSelectType.DataController.DataSource.State = dsEdit then  mSelectTypes.post;
  UpdateStat;
end;

procedure TfrmMakeReservationQuick.tvSelectTypeNoRoomsPropertiesValidate(Sender: TObject; var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  if displayValue < 0 then displayValue := 0;



end;

procedure TfrmMakeReservationQuick.tvSelectTypeNoRoomsStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
var
  total    : integer;
  norooms  : integer;
  TotalFree : integer;
begin
  noRooms   := mSelectTypes.FieldByName('Norooms').AsInteger;
  totalfree := mSelectTypes.FieldByName('totalFree').AsInteger;
  total     := totalfree-norooms;

  if total < 0  then
  begin
    AStyle := cxStyle1
  end else
  begin
    AStyle := cxStyle2
  end;


end;

procedure TfrmMakeReservationQuick.tvSelectTypeSelectedPropertiesEditValueChanged(Sender: TObject);
begin
  if tvSelectType.DataController.DataSource.State = dsEdit then
     mSelectTypes.post;
  UpdateStat;
end;

procedure TfrmMakeReservationQuick.tvSelectTypeSelectedPropertiesValidate(Sender: TObject; var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  if displayValue < 0 then displayValue := 0;

  if displayValue > mSelectTypes.FieldByName('Available').asinteger then
  begin
    if mSelectTypes.FieldByName('Available').asinteger < 1 then
    begin
      displayValue := 0;
    end else
    begin
      displayValue := mSelectTypes.FieldByName('Available').asinteger;
    end;
  end;


end;

procedure TfrmMakeReservationQuick.tvSelectTypeTotalFreePropertiesChange(Sender: TObject);
begin
  //
end;

procedure TfrmMakeReservationQuick.initCustomer;
var
  customer : string;
  oldCustomer : string;
  ChannelCode : String;
  i: Integer;
begin
  customer := edCustomer.text;
  oldCustomer := oNewReservation.HomeCustomer.Customer;
  oNewReservation.HomeCustomer.Customer_update(customer);
  labCustomerName.caption := oNewReservation.HomeCustomer.CustomerName;

//  edGuestName.text            := MainGuestConstant_Version_1;
  edCountry.text              := oNewReservation.HomeCustomer.Country;
  labCountryName.caption      := oNewReservation.HomeCustomer.CountryName;
  edReservationName.text      := oNewReservation.HomeCustomer.CustomerName;

  cbxRoomStatus.ItemIndex     := RoomStatusFromInfo(oNewReservation.HomeCustomer.RoomStatus);
  edMarketSegmentCode.text    := oNewReservation.HomeCustomer.MarketSegmentCode;

  if oNewReservation.HomeCustomer.IsGroupInvoice = true then
       chkIsGroupInvoice.checked := true else
         chkIsGroupInvoice.checked := false;

//  if oNewReservation.HomeCustomer.ShowDiscountOnInvoice = true then
//       chkShowDiscountOnInvoice.checked := true else
//         chkShowDiscountOnInvoice.checked := false;


  edCurrency.text             := oNewReservation.HomeCustomer.Currency;
  edPcCode.text               := oNewReservation.HomeCustomer.PcCode;
  edRoomResDiscount.Value     := trunc(oNewReservation.HomeCustomer.DiscountPerc);
  edPID.text                  := oNewReservation.HomeCustomer.PID;
  edCustomerName.text         := oNewReservation.HomeCustomer.CustomerName;
  edAddress1.text             := oNewReservation.HomeCustomer.Address1;
  edAddress2.text             := oNewReservation.HomeCustomer.Address2;
  edAddress3.text             := oNewReservation.HomeCustomer.Address3;
  edTel1.text                 := oNewReservation.HomeCustomer.Tel1;
  edTel2.text                 := oNewReservation.HomeCustomer.Tel2;
  edFax.text                  := oNewReservation.HomeCustomer.Fax;
  edEmailAddress.text         := oNewReservation.HomeCustomer.EmailAddress;
  edHomePage.text             := oNewReservation.HomeCustomer.HomePage;
  edContactPhone.text         := oNewReservation.HomeCustomer.ContactPhone;
//0810-hj   edContactCountry.text       := oNewReservation.HomeCustomer.Country;
  edContactPerson.text        := '';//oNewReservation.HomeCustomer.ContactPerson;
  edContactFax.text           := '';//oNewReservation.HomeCustomer.ContactFax;
  edContactEmail.text         := '';//oNewReservation.HomeCustomer.ContactEmail;
  zCustomerChanged := false;

  memCustomerAlert.lines.clear;
  memCustomerAlert.text := d.GetCustomerPreferences(customer);

  customerValidate;
  CountryValidate;
  MarketSegmentValidate;
  CurrencyValidate(edCurrency,clabCurrency,labCurrencyName);
  PriceCodeValidate(edPcCode, clabPcCode, labPcCodeName);

  if glb.LocateSpecificRecordAndGetValue('channels', 'id', oNewReservation.HomeCustomer.CustomerRatePlanId, 'channelManagerId', ChannelCode) then
    for i := 1 to edtRatePlans.Items.Count - 1 do
      if Integer(edtRatePlans.Items.Objects[i]) = oNewReservation.HomeCustomer.CustomerRatePlanId then
      begin
        edtRatePlans.ItemIndex := i; // edtRatePlans.Items.IndexOf(ChannelCode);
        edtRatePlansCloseUp(nil);
        Break;
      end;
end;



procedure TfrmMakeReservationQuick.btdEditRoomRateClick(Sender: TObject);
var
  RoomReservation  : integer  ;
begin
  roomReservation := mRoomRes.FieldByName('roomreservation').AsInteger;
  EditRoomRateOneRoom(RoomReservation);
end;


procedure TfrmMakeReservationQuick.EditRoomRateOneRoom(RoomRes : integer) ;
var
  theData : recEditRoomPriceHolder;

  recCount : integer;
  Reservation      : integer  ;
  RoomReservation  : integer  ;
  RoomNumber       : string   ;
  PriceCode        : string   ;
  RateDate         : TDateTime;
  Rate             : Double   ;
  Discount         : double   ;
  isPercentage     : boolean  ;
  ShowDiscount     : boolean  ;
  isPaid           : boolean  ;
  DiscountAmount   : double   ;
  RentAmount       : double   ;
  NativeAmount     : double   ;
  AvrageAmount     : double   ;
  ttAmount         : double   ;
  AmountCount      : integer  ;
  resPrice         : double   ;
  lstPrices        : TstringList;
  rateCount        : integer;

  ttDiscount     : double;
  avrageDiscount : double;
  applyType : integer;

begin
  isPercentage := True;
  applyType := 0;

  if mRR_.Active then mRR_.Close;
  lstPrices := TstringList.Create;
  try
    lstPrices.Sorted := true;
    lstPrices.Duplicates := dupIgnore;

    initEditRoomPriceHolder(theData);
    theData.isCreateRes   := true;
    theData.currency      := edCurrency.Text;
    theData.CurrencyRate  := hData.GetRate(theData.currency);

    roomReservation       := mRoomRes.FieldByName('roomreservation').AsInteger;
    theData.RoomType      := mRoomRes.FieldByName('RoomType').AsString;
    theData.guests        := mRoomRes.FieldByName('Guests').AsInteger;
    theData.childrenCount := mRoomRes.FieldByName('childrenCount').AsInteger;
    theData.infantCount   := mRoomRes.FieldByName('infantCount').AsInteger;
    resPrice              := mRoomRes.FieldByName('AvragePrice').AsFloat;
    mRR_.Open;

    mRoomRates.first;
    while not mRoomRates.Eof do
    begin
      if mRoomRates.fieldbyname('roomreservation').AsInteger = roomreservation then
      begin
        mRR_.append;
        mRR_.Fieldbyname('Reservation').asInteger        :=  mRoomRates.Fieldbyname('Reservation').asInteger       ;
        mRR_.Fieldbyname('RoomReservation').asInteger    :=  mRoomRates.Fieldbyname('RoomReservation').asInteger   ;
        mRR_.Fieldbyname('RoomNumber').asString          :=  mRoomRates.Fieldbyname('RoomNumber').asString         ;
        mRR_.Fieldbyname('PriceCode').asString           :=  mRoomRates.Fieldbyname('PriceCode').asString          ;
        mRR_.Fieldbyname('RateDate').asDatetime          :=  mRoomRates.Fieldbyname('RateDate').asDatetime         ;
        mRR_.Fieldbyname('Rate').asFloat                 :=  mRoomRates.Fieldbyname('Rate').asFloat                ;
        mRR_.Fieldbyname('Discount').asFloat             :=  mRoomRates.Fieldbyname('Discount').asFloat            ;
        mRR_.Fieldbyname('isPercentage').asBoolean       :=  mRoomRates.Fieldbyname('isPercentage').asBoolean      ;
        mRR_.Fieldbyname('ShowDiscount').asBoolean       :=  mRoomRates.Fieldbyname('ShowDiscount').asBoolean      ;
        mRR_.Fieldbyname('isPaid').asBoolean             :=  mRoomRates.Fieldbyname('isPaid').asBoolean            ;
        mRR_.Fieldbyname('DiscountAmount').asFloat       :=  mRoomRates.Fieldbyname('DiscountAmount').asFloat      ;
        mRR_.Fieldbyname('RentAmount').asFloat           :=  mRoomRates.Fieldbyname('RentAmount').asFloat          ;
        mRR_.Fieldbyname('NativeAmount').asFloat         :=  mRoomRates.Fieldbyname('NativeAmount').asFloat        ;
        mRR_.Fieldbyname('Currency').asString            :=  mRoomRates.Fieldbyname('Currency').asString           ;
        mRR_.Fieldbyname('CurrencyRate').asFloat         :=  mRoomRates.Fieldbyname('CurrencyRate').asFloat        ;
        mRR_.Post;
      end;
      mRoomRates.next;
    end;

    mRR_.first;


    theData.Room := mRR_.FieldByName('roomNumber').AsString;
    ttAmount := 0;
    ttDiscount := 0;
    AmountCount := 0;
    if editRoomPrice(actNone,theData,mRR_,applyType) then
    begin
      mRR_.first;
      while not mRR_.eof do
      begin
        Reservation      := mRR_.FieldByName('Reservation').Asinteger     ;
        RoomReservation  := mRR_.FieldByName('RoomReservation').Asinteger ;
        RoomNumber       := mRR_.FieldByName('RoomNumber').Asstring       ;
        PriceCode        := mRR_.FieldByName('PriceCode').Asstring        ;
        RateDate         := mRR_.FieldByName('RateDate').AsDateTime       ;
        Rate             := mRR_.FieldByName('Rate').AsFloat              ;
        Discount         := mRR_.FieldByName('Discount').AsFloat          ;
        isPercentage     := mRR_.FieldByName('isPercentage').AsBoolean    ;
        ShowDiscount     := mRR_.FieldByName('ShowDiscount').AsBoolean    ;
        isPaid           := mRR_.FieldByName('isPaid').AsBoolean          ;
        DiscountAmount   := mRR_.FieldByName('DiscountAmount').AsFloat    ;
        RentAmount       := mRR_.FieldByName('RentAmount').AsFloat        ;
        NativeAmount     := mRR_.FieldByName('NativeAmount').AsFloat      ;

        lstPrices.Add(floatTostr(RentAmount));
        inc(AmountCount);
        ttAmount := ttAmount+RentAmount;
        ttDiscount := ttDiscount+Discount;

        if mRoomRates.Locate('RoomReservation;rateDate', VarArrayOf([RoomReservation, rateDate]), []) then
        begin
          mRoomRates.Edit;
          mRoomRates.FieldbyName('Reservation').AsInteger       := Reservation        ;
          mRoomRates.FieldbyName('RoomReservation').asInteger   := RoomReservation    ;
          mRoomRates.FieldbyName('RoomNumber').asString         := RoomNumber         ;
          mRoomRates.FieldbyName('PriceCode').asString          := PriceCode          ;
          mRoomRates.FieldbyName('RateDate').asDateTime         := RateDate           ;
          mRoomRates.FieldbyName('Rate').asFloat                := Rate               ;
          mRoomRates.FieldbyName('Discount').asFloat            := Discount           ;
          mRoomRates.FieldbyName('isPercentage').asBoolean      := isPercentage       ;
          mRoomRates.FieldbyName('ShowDiscount').asBoolean      := ShowDiscount       ;
          mRoomRates.FieldbyName('isPaid').asboolean            := isPaid             ;
          mRoomRates.FieldbyName('DiscountAmount').asFloat      := DiscountAmount     ;
          mRoomRates.FieldbyName('RentAmount').asFloat          := RentAmount         ;
          mRoomRates.FieldbyName('NativeAmount').asFloat        := NativeAmount       ;
          mRoomRates.Post;
        end;
//        memReservationGeneralInfo.Lines.Add(floattostr(rate));
        mRR_.next;
      end;

      if mRoomRes.Locate('RoomReservation', RoomReservation,[]) then
      begin
        if AmountCount <> 0 then
        begin
          AvrageAmount := ttAmount / AmountCount;
          AvrageDiscount := ttDiscount / AmountCount;
          rateCount := lstPrices.Count;
          mRoomRes.Edit;
          mRoomRes.FieldByName('AvragePrice').AsFloat := AvrageAmount;
          mRoomRes.FieldByName('RateCount').AsInteger := RateCount;
          mRoomRes.FieldByName('PriceCode').AsString := PriceCode;
          mRoomRes.FieldByName('AvrageDiscount').AsFloat := AvrageDiscount;
          mRoomRes.FieldByName('isPercentage').AsBoolean := isPercentage;
          mRoomRes.post;
        end;
      end;
    end;
  finally
    if mRR_.Active then mRR_.Close;
    freeandnil(lstPrices);
  end;

  if applyType = 2 then
  begin
    ApplyRateToOther(roomreservation,theData.RoomType)
  end else
  if applyType = 3 then
  begin
    ApplyRateToOther(roomreservation,'');
  end;
end;


procedure TfrmMakeReservationQuick.InitSelectRooms;
begin
  zTotalRoomsSelected := 0;
  labTotalRoomsSelected.Caption := inttostr(zTotalRoomsSelected);
  getSelectRooms;
  mSelectTypes.First;
  while not mSelectTypes.eof do
  begin
    mSelectTypes.Edit;
    mSelectTypes.fieldbyname('RoomsSelected').asinteger := 0;
    mSelectTypes.Post;
    mSelectTypes.Next;
  end;

  mSelectTypes.First;
end;

procedure TfrmMakeReservationQuick.lblExtraBedCurrencyClick(Sender: TObject);
begin
   showmessage(edCurrency.Text);
end;

procedure TfrmMakeReservationQuick.getSelectRooms;
var
  rSet    : TRoomerDataSet;
  rSetOcc : TRoomerDataSet;
  s : string;
  dateFrom : Tdate;
  dateTo   : Tdate;
  room : string;

  ioccRooms : integer;

begin
  mSelectRooms.DisableControls;
  try
    DateFrom  := dtArrival.Date;
    DateTo    := dtDeparture.Date;

    if mSelectRooms.Active then mSelectRooms.close;
    mSelectRooms.Open;

    s := '';
    s := s+'SELECT DISTINCT '#10;
    s := s+'    Room '#10;
    s := s+'  , isNoRoom '#10;
    s := s+'FROM '#10;
    s := s+'  roomsdate '#10;
    s := s+'WHERE '#10;
    s := s+'  (ADate >= '+_db(DateFrom)+') AND (ADate < '+_db(DateTo)+') AND (isNoRoom = 0) '#10;
    s := s+'   AND (ResFlag <> '+_db(STATUS_DELETED)+' ) '; //**zxhj
    s := s+'   AND (ResFlag <> '+_db(STATUS_CANCELED)+' ) '; //**zxhj
    s := s+'ORDER BY '#10;
    s := s+'  ROOM '#10;

    rSetOcc := createNewDataSet;
    try
      iOccRooms := 0;
      if rSet_bySQL(rSetOcc,s) then
      begin
  //    iOccRooms := rSet.RecordCount;
      end;

      s := 'SELECT * FROM wroominfo ORDER BY room ';
      rSet := createNewDataSet;
      try
        rSet_bySQL(rSet,s);

        copytoclipboard(s);
        debugmessage(s);


        While not rSet.Eof do
        begin
          room := rSet.FieldByName('room').AsString;
          if not rSetOcc.Locate('room',room,[]) then
          begin
            mSelectRooms.Append;
            mSelectRooms.fieldbyname('Room').AsString  := rSet.fieldbyname('Room').asString ;
            mSelectRooms.fieldbyname('tmp').AsString  := rSet.fieldbyname('Room').asString ;
            mSelectRooms.fieldbyname('Description').AsString  := rSet.fieldbyname('Description')        .asString ;
            mSelectRooms.fieldbyname('DetailedDescription').AsString  := rSet.fieldbyname('DetailedDescription').asString ;
            mSelectRooms.fieldbyname('RoomType').AsString  := rSet.fieldbyname('RoomType')           .asString ;
            mSelectRooms.fieldbyname('Bath').AsBoolean := rSet.fieldbyname('Bath')               .asBoolean;
            mSelectRooms.fieldbyname('Shower').AsBoolean := rSet.fieldbyname('Shower')             .asBoolean;
            mSelectRooms.fieldbyname('Safe').AsBoolean := rSet.fieldbyname('Safe')               .asBoolean;
            mSelectRooms.fieldbyname('TV').AsBoolean := rSet.fieldbyname('TV')                 .asBoolean;
            mSelectRooms.fieldbyname('Video').AsBoolean := rSet.fieldbyname('Video')              .asBoolean;
            mSelectRooms.fieldbyname('Radio').AsBoolean := rSet.fieldbyname('Radio')              .asBoolean;
            mSelectRooms.fieldbyname('CDPlayer').AsBoolean := rSet.fieldbyname('CDPlayer')           .asBoolean;
            mSelectRooms.fieldbyname('Telephone').AsBoolean := rSet.fieldbyname('Telephone')          .asBoolean;
            mSelectRooms.fieldbyname('Press').AsBoolean := rSet.fieldbyname('Press')              .asBoolean;
            mSelectRooms.fieldbyname('Coffee').AsBoolean := rSet.fieldbyname('Coffee')             .asBoolean;
            mSelectRooms.fieldbyname('Kitchen').AsBoolean := rSet.fieldbyname('Kitchen')            .asBoolean;
            mSelectRooms.fieldbyname('Minibar').AsBoolean := rSet.fieldbyname('Minibar')            .asBoolean;
            mSelectRooms.fieldbyname('Fridge').AsBoolean := rSet.fieldbyname('Fridge')             .asBoolean;
            mSelectRooms.fieldbyname('Hairdryer').AsBoolean := rSet.fieldbyname('Hairdryer')          .asBoolean;
            mSelectRooms.fieldbyname('InternetPlug').AsBoolean := rSet.fieldbyname('InternetPlug')       .asBoolean;
            mSelectRooms.fieldbyname('Fax').AsBoolean := rSet.fieldbyname('Fax')                .asBoolean;
            mSelectRooms.fieldbyname('SqrMeters').AsFloat := rSet.GetFloatValue(rSet.fieldbyname('SqrMeters'));
            mSelectRooms.fieldbyname('BedSize').AsBoolean := rSet.fieldbyname('BedSize')            .asBoolean;
            mSelectRooms.fieldbyname('Equipments').AsString  := rSet.fieldbyname('Equipments')         .asString ;
            mSelectRooms.fieldbyname('Bookable').AsBoolean := rSet.fieldbyname('Bookable')           .asBoolean;
            mSelectRooms.fieldbyname('Statistics').AsBoolean := rSet.fieldbyname('Statistics')         .asBoolean;
            mSelectRooms.fieldbyname('Status').AsString  := rSet.fieldbyname('Status')             .asString ;
            mSelectRooms.fieldbyname('OrderIndex').AsInteger := rSet.fieldbyname('OrderIndex')         .asInteger;
            mSelectRooms.fieldbyname('hidden').AsBoolean := rSet.fieldbyname('hidden')             .asBoolean;
            mSelectRooms.fieldbyname('Location').AsString  := rSet.fieldbyname('Location')           .asString ;
            mSelectRooms.fieldbyname('Floor').AsInteger := rSet.fieldbyname('Floor')              .asInteger;
            mSelectRooms.fieldbyname('ID').AsInteger := rSet.fieldbyname('ID')                 .asInteger;
            mSelectRooms.fieldbyname('Dorm').AsString  := rSet.fieldbyname('Dorm')               .asString ;
            mSelectRooms.fieldbyname('useInNationalReport').AsBoolean := rSet.fieldbyname('useInNationalReport').asBoolean;
            mSelectRooms.fieldbyname('Active').AsBoolean := rSet.fieldbyname('Active')             .asBoolean;
            mSelectRooms.fieldbyname('LocationDescription').AsString  := rSet.fieldbyname('LocationDescription').asString ;
            mSelectRooms.fieldbyname('RoomTypeDescription').AsString  := rSet.fieldbyname('RoomTypeDescription').asString ;
            mSelectRooms.fieldbyname('NumberGuests').AsInteger := rSet.fieldbyname('NumberGuests')       .asInteger;
            mSelectRooms.fieldbyname('RoomTypeGroup').AsString  := rSet.fieldbyname('RoomTypeGroup')      .asString ;
            mSelectRooms.fieldbyname('RoomTypeGroupDescription').AsString  := rSet.fieldbyname('RoomTypeGroupDescription').asString;
            mSelectRooms.Post;
          end;
           rSet.Next;
        end;
      finally
        freeandnil(rSet);
      end;
    finally
      freeandnil(rSetOcc);
    end;
    mSelectRooms.First;
  finally
    mSelectRooms.EnableControls;
  end;

//  debugmessage(inttostr(mSelectRooms.recordcount));

end;

function TfrmMakeReservationQuick.doAutoSelect(RoomType : string; NumRooms : integer; PriorityRule : string) : integer;
var
  lstPriority : TstringList;
  tmp : integer;

  aRoomtype  : string;
  foundCount : integer;

begin
  result := 0;
  if numRooms = 0 then exit;

  foundCount := 0;
  lstPriority := TstringList.Create;
  try
    tmp := mSelectRooms.FieldByName('ID').asInteger;
    mSelectRooms.DisableControls;
    try
      mSelectRooms.First;
      while NOT mSelectRooms.eof do
      begin
        aRoomtype := mSelectRooms.Fieldbyname('RoomType').AsString;
        if Uppercase(aRoomType) = UpperCase(RoomType) then
        begin
          if foundCount < NumRooms then
          begin
            mSelectRooms.edit;
            mSelectRooms.FieldByName('Select').AsBoolean := true;
            mSelectRooms.Post;

            mSelectTypes.Edit;
            mSelectTypes.fieldbyname('RoomsSelected').asinteger := mSelectTypes.fieldbyname('RoomsSelected').asinteger+1;
            mSelectTypes.Post;

            inc(FoundCount);
          end;
        end;
        mSelectRooms.Next;
      end;
      mSelectRooms.Locate('ID',tmp,[]);
    finally
      mSelectRooms.EnableControls;
    end;
  finally
    freeandnil(lstPriority);
  end;
  zTotalRoomsSelected := tvSelectType.DataController.Summary.FooterSummaryValues[4];
  labTotalRoomsSelected.Caption := inttostr(zTotalRoomsSelected);
end;






procedure TfrmMakeReservationQuick.dtDepartureCloseUp(Sender: TObject);
begin
  if dtDeparture.Date <= dtArrival.Date  then dtDeparture.Date := dtArrival.Date +1;
  if dtArrival.Date >= dtDeparture.Date  then dtArrival.Date := dtDeparture.Date -1;
  zNights :=  trunc(dtDeparture.Date)-trunc(dtArrival.Date);
  edNights.Value := zNights;
end;

procedure TfrmMakeReservationQuick.dtDepartureExit(Sender: TObject);
begin
  if dtDeparture.Date <= dtArrival.Date  then dtDeparture.Date := dtArrival.Date +1;
  if dtArrival.Date >= dtDeparture.Date  then dtArrival.Date := dtDeparture.Date -1;
  zNights :=  trunc(dtDeparture.Date)-trunc(dtArrival.Date);
  edNights.Value := zNights;
end;


procedure TfrmMakeReservationQuick.btnAutoSelectRoomsClick(Sender: TObject);
var
  RoomType : string;
  NumRooms : integer;
  PriorityRule : string;
begin
  InitSelectRooms;
  mSelectTypes.First;
  while not mSelectTypes.eof do
  begin
    RoomType     := mSelectTypes.FieldByName('RoomType').AsString;
    NumRooms     := mSelectTypes.FieldByName('Selected').AsInteger;
    PriorityRule := mSelectTypes.FieldByName('PriorityRule').AsString;
    doAutoSelect(RoomType,NumRooms,PriorityRule);
    mSelectTypes.Next;
  end;
end;


procedure TfrmMakeReservationQuick.btnEditRateAllRoomsClick(Sender: TObject);
begin
  apply;
end;

procedure TfrmMakeReservationQuick.btnFinishClick(Sender: TObject);
begin
  apply;
end;



procedure TfrmMakeReservationQuick.btnGetLastCustomerClick(Sender: TObject);
var
  s : string;
  theData : recCustomerHolder;
  rSet : TroomerDataset;
begin
    rSet := CreateNewDataSet;
    try
      s := '';
      s := s+' Select * FROM reservations Order by reservation desc Limit 1';
      if rSet_bySQL(rSet,s) then
      begin
        edCustomer.Text := rSet.FieldByName('customer').AsString;
        if customerValidate then
        begin
          zCustomerChanged := true;
          initCustomer;
        end;
        edCountry.Text := rSet.FieldByName('country').AsString;
        labCountryName.Caption := '';
      end;
    finally
      freeandnil(rSet);
    end;
end;

procedure TfrmMakeReservationQuick.btnNextClick(Sender: TObject);
begin
  if not customerValidate then exit;
  if not CountryValidate then exit;
  if not MarketSegmentValidate then exit;
  if not CurrencyValidate(edCurrency,clabCurrency,labCurrencyName)  then exit;
  if not PriceCodeValidate(edPcCode, clabPcCode, labPcCodeName)  then exit;


  if pgcMain.ActivePageIndex = 3 then exit;

  if pgcMain.ActivePageIndex = 0 then
  begin
    if oNewReservation.IsQuick then
    begin
      pgcMain.ActivePageIndex := 3;
    end else
    begin
      if OutOfOrderBlocking then
        pgcMain.ActivePageIndex := 2
      else
        pgcMain.ActivePageIndex := 1;
    end;
    pgcMainChange(self);
    exit;
  end;


  if pgcMain.ActivePageIndex = 1 then
  begin
    if oNewReservation.IsQuick then
    begin
      pgcMain.ActivePageIndex := 3;
    end else
    begin
      zTotalSelected      := tvSelectType.DataController.Summary.FooterSummaryValues[0];
      zTotalRoomsSelected := tvSelectType.DataController.Summary.FooterSummaryValues[4];     //4
      zTotalAvailable     := tvSelectType.DataController.Summary.FooterSummaryValues[3];     //3
      zTotalFree          := tvSelectType.DataController.Summary.FooterSummaryValues[2];     //2
      zTotalNoRooms       := tvSelectType.DataController.Summary.FooterSummaryValues[1];     //1

      zTotal := zTotalSelected+zTotalRoomsSelected+zTotalAvailable+zTotalFree+zTotalNoRooms;
      if ((zTotalSelected = 0) and (zTotalNoRooms > 0)) and (zTotal <> 0) then
      begin
        pgcMain.ActivePage := tabRoomrates;
      end else
      begin
        pgcMain.ActivePageIndex := 2;
      end;
    end;
    pgcMainChange(self);
    exit;
  end;


  if pgcMain.ActivePageIndex = 2 then
  begin
    if oNewReservation.IsQuick then
    begin
      pgcMain.ActivePageIndex := 3;
    end else
    begin
      pgcMain.ActivePageIndex := 3;
    end;
    pgcMainChange(self);
    exit;
  end;
end;

procedure TfrmMakeReservationQuick.btnPortfolioClick(Sender: TObject);
begin
  if edtPortfolio.Tag > 0 then
  begin
    edContactPerson.Text := '';
    edContactAddress1.Text := '';
    edContactAddress2.Text := '';
    edContactAddress3.Text := '';
    edContactAddress4.Text := '';
//0810-hj     edContactCountry.Text := '';

    edContactPhone.Text := '';
    edContactFax.Text := '';
    edContactEmail.Text := '';

    lbContactCountryName.caption := '';
  end;
  edtPortfolio.Tag := 0;
  edtPortfolio.Text := '';
end;

procedure TfrmMakeReservationQuick.btnPreviusClick(Sender: TObject);
begin
  if pgcMain.ActivePageIndex = 0 then exit;


  if pgcMain.ActivePageIndex = 1 then
  begin
    if oNewReservation.IsQuick then
    begin
      pgcMain.ActivePageIndex := 0;
    end else
    begin
      pgcMain.ActivePageIndex := 0;
    end;
    pgcMainChange(self);
    exit;
  end;


  if pgcMain.ActivePageIndex = 2 then
  begin
    if oNewReservation.IsQuick then
    begin
      pgcMain.ActivePageIndex := 0;
    end else
    begin
      pgcMain.ActivePageIndex := 1;
    end;
    pgcMainChange(self);
    exit;
  end;

  if pgcMain.ActivePageIndex = 3 then
  begin
    if oNewReservation.IsQuick then
    begin
      pgcMain.ActivePageIndex := 0;
    end else
    begin
      pgcMain.ActivePageIndex := 2;
    end;
    pgcMainChange(self);
    exit;
  end;

end;

procedure TfrmMakeReservationQuick.btnRefreshClick(Sender: TObject);
begin
  GetPrices;
end;

procedure TfrmMakeReservationQuick.btnSetAllAsNoRoomClick(Sender: TObject);
begin
  SetAllAsNoRoom(true);
end;

procedure TfrmMakeReservationQuick.SetAllAsNoRoom(doNextPage : boolean=true);
var
  selected : integer;
  noRooms  : integer;
begin
  mSelectTypes.DisableControls;
  mSelectTypes.first;
  try
    while not mSelectTypes.Eof do
    begin
      noRooms := mSelectTypes.FieldByName('selected').AsInteger + mSelectTypes.FieldByName('noRooms').AsInteger;
      mSelectTypes.Edit;
      mSelectTypes.FieldByName('noRooms').AsInteger := noRooms;
      mSelectTypes.FieldByName('Selected').AsInteger := 0;
      mSelectTypes.Post;
      mSelectTypes.Next;
    end;
  finally
    mSelectTypes.EnableControls;
    screen.Cursor := crDefault;
  end;

  // if jist norooms
  zTotal := zTotalSelected+zTotalRoomsSelected+zTotalAvailable+zTotalFree+zTotalNoRooms;
  if ((zTotalSelected = 0) and (zTotalNoRooms > 0)) and (zTotal <> 0) then exit;

  mSelectRooms.DisableControls;
  mSelectRooms.first;
  try
    while not mSelectRooms.Eof do
    begin
      mSelectRooms.Edit;
      mSelectRooms.FieldByName('select').AsBoolean := false;
      mSelectRooms.Post;
      mSelectRooms.Next;
    end;
  finally
    mSelectRooms.EnableControls;
    screen.Cursor := crDefault;
  end;
  if doNextPage then
  begin
    pgcMain.ActivePageIndex := 3;
    pgcMainChange(self);
  end;
end;


procedure TfrmMakeReservationQuick.SetOutOfOrderBlocking(const Value: Boolean);
var i : Integer;
begin
  FOutOfOrderBlocking := Value;
  gbxContact.Visible := NOT FOutOfOrderBlocking;
  gbxRate.Visible := NOT FOutOfOrderBlocking;
  gbxCustomerAlert.Visible := NOT FOutOfOrderBlocking;
  gbxGetCustomer.Visible := NOT FOutOfOrderBlocking;
  panNotesPayment.Visible := NOT FOutOfOrderBlocking;
  panRoomNotes.Visible := NOT FOutOfOrderBlocking;
  btnAutoSelectRooms.Visible := NOT FOutOfOrderBlocking;
  btnSetAllAsNoRoom.Visible := NOT FOutOfOrderBlocking;

  gbxRefresh.Visible := NOT FOutOfOrderBlocking;
  gbxSelectedRoom.Visible := NOT FOutOfOrderBlocking;
  chkAutoUpdateNullPrice.Visible := NOT FOutOfOrderBlocking;

  tvRoomResGuests.Visible := NOT FOutOfOrderBlocking;
  tvRoomResChildrenCount.Visible := NOT FOutOfOrderBlocking;
  tvRoomResinfantCount.Visible := NOT FOutOfOrderBlocking;
  tvRoomResMainGuest.Visible := NOT FOutOfOrderBlocking;
  tvRoomResAvragePrice.Visible := NOT FOutOfOrderBlocking;
  tvRoomResPackage.Visible := NOT FOutOfOrderBlocking;
  tvRoomResPackagePrice.Visible := NOT FOutOfOrderBlocking;
  tvRoomResAvrageDiscount.Visible := NOT FOutOfOrderBlocking;
  tvRoomResisPercentage.Visible := NOT FOutOfOrderBlocking;
  tvRoomResPriceCode.Visible := NOT FOutOfOrderBlocking;
  tvRoomResRatePlanCode.Visible := NOT FOutOfOrderBlocking;

  if FOutOfOrderBlocking then
  begin
    clabReservationName.Caption := GetTranslatedText('shTx_FrmMakeReservationQuick_OutOfOrderDescription');
    clabArrival.Caption := GetTranslatedText('shTx_FrmMakeReservationQuick_OutOfOrderStartDate');
    clabDeparture.Caption := GetTranslatedText('shTx_FrmMakeReservationQuick_OutOfOrderEndDate');
  end else
  begin
    RoomerLanguage.TranslateThisControl(self, clabReservationName);
    RoomerLanguage.TranslateThisControl(self, clabArrival);
    RoomerLanguage.TranslateThisControl(self, clabDeparture);
//    clabReservationName.Caption := GetTranslatedText('TfrmMakeReservationQuick.clabReservationName.Caption');
//    clabArrival.Caption := GetTranslatedText('TfrmMakeReservationQuick.clabArrival.Caption');
//    clabDeparture.Caption := GetTranslatedText('TfrmMakeReservationQuick.clabDeparture.Caption');
  end;

  for i := 0 to ComponentCount - 1 do
  begin
    if (
       (Components[i] IS TsLabel) OR
       (Components[i] IS TsEdit) OR
       (Components[i] IS TsComboBox) OR
       (Components[i] IS TsCheckBox) OR
       (Components[i] IS TsSpeedButton)
       ) AND
       (
       (TControl(Components[i]).Parent = gbxGetReservation) AND
       (Components[i].Name <> 'clabReservationName') AND
       (Components[i].Name <> 'edReservationName') AND
       (Components[i].Name <> 'clabReservationType') AND
       (Components[i].Name <> 'cbxRoomStatus')
       )
       then
        TControl(Components[i]).Visible := NOT FOutOfOrderBlocking;
  end;

end;

procedure TfrmMakeReservationQuick.btnPortfolioLookupClick(Sender: TObject);
var sName : String;
    iId : Integer;
begin
  iId := GuestProfiles(actLookup, edtPortfolio.Tag);
  if iId > 0 then
  begin
    if glb.LocateSpecificRecord('personprofiles', 'ID', inttostr(iId)) then
    begin
      edtPortfolio.Text := Trim(glb.PersonProfiles['FirstName'] + ' ' + glb.PersonProfiles['LastName']);
      edtPortfolio.Tag := iId;

      edContactPerson.Text := edtPortfolio.Text;
      edContactAddress1.Text := glb.PersonProfiles['Address1'];
      edContactAddress2.Text := glb.PersonProfiles['Address2'];
      edContactAddress3.Text := glb.PersonProfiles['Zip'];
      edContactAddress4.Text := glb.PersonProfiles['City'];
//0810-hj       edContactCountry.Text := glb.PersonProfiles['Country'];

      edContactPhone.Text := glb.PersonProfiles['TelMobile'];
      edContactFax.Text := glb.PersonProfiles['TelFax'];
      edContactEmail.Text := glb.PersonProfiles['Email'];

//0810-hj ATH
      if glb.LocateSpecificRecordAndGetValue('countries', 'Country', edContactCountry.Text, 'CountryName', sName) then
        lbContactCountryName.caption := sName;

    end;
  end;
end;

procedure TfrmMakeReservationQuick.sButton1Click(Sender: TObject);
begin
  mRoomRes.DisableControls;
  mRoomRes.first;
  try
    while not mRoomRes.Eof do
    begin
      mRoomRes.Edit;
      mRoomRes.FieldByName('Room').AsString := '<'+mRoomRes.FieldByName('roomReservation').AsString+'>';
      mRoomRes.Post;
      mRoomRes.Next;
    end;
  finally
    mRoomRes.EnableControls;
    screen.Cursor := crDefault;
  end;
end;


procedure TfrmMakeReservationQuick.edCustomerPropertiesEditValueChanged(Sender: TObject);
begin
end;


//**********************************************************************************
// Country
//

function TfrmMakeReservationQuick.CountryValidate : boolean;
var
  sValue : string;
begin
  result := true;

  sValue := trim(edCountry.Text);
  //**NOT TESTED**//
  if not hdata.CountryExists(svalue) then
  begin
    edCountry.SetFocus;
    labCountryName.Font.Color := clRed;
    labCountryName.Caption := GetTranslatedText('shNotF_star');
    result := false;
    exit;
  end else
  begin
    labCountryName.Font.Color := clBlack;
    if glb.LocateCountry(sValue) then
      labCountryName.caption  := glb.Countries['CountryName']; // GET_CountryName(sValue);
  end;

//0810-hj
//  sValue := trim(edContactCountry.Text);
//  //**NOT TESTED**//
//  if not hdata.CountryExists(svalue) then
//  begin
//    edContactCountry.SetFocus;
//    lbContactCountryName.Font.Color := clRed;
//    lbContactCountryName.Caption := GetTranslatedText('shNotF_star');
//    result := false;
//    exit;
//  end else
//  begin
//    lbContactCountryName.Font.Color := clBlack;
//    if glb.LocateCountry(sValue) then
//      lbContactCountryName.caption  := glb.Countries['CountryName']; // GET_CountryName(sValue);
//  end;

end;

procedure TfrmMakeReservationQuick.mSelectRoomsNewRecord(DataSet: TDataSet);
begin
  dataset.FieldByName('Select').AsBoolean := false;
end;

procedure TfrmMakeReservationQuick.mSelectTypesBeforePost(DataSet: TDataSet);
begin
//  if mSelectTypes.FieldByName('Selected').AsInteger > mSelectTypes.FieldByName('FreeRooms').AsInteger  then
//  begin
//    mSelectTypes.FieldByName('NoRooms').AsInteger  := mSelectTypes.FieldByName('Selected').AsInteger - mSelectTypes.FieldByName('FreeRooms').AsInteger
//  end else
//  if mSelectTypes.FieldByName('Selected').AsInteger = mSelectTypes.FieldByName('FreeRooms').AsInteger  then
//  begin
//    mSelectTypes.FieldByName('NoRooms').AsInteger  := 0;
//  end;
end;

procedure TfrmMakeReservationQuick.mSelectTypesCalcFields(DataSet: TDataSet);
begin
  dataset.fieldbyname('totalFree').AsInteger := dataset.FieldByName('Available').AsInteger-dataset.FieldByName('Selected').AsInteger
end;

procedure TfrmMakeReservationQuick.pgcMainChange(Sender: TObject);
begin
  if pgcMain.ActivePageIndex = 0 then
  begin

    btnCancel.enabled    := true;
    btnPrevius.Enabled   := false;
    btnNext.Enabled := true;
    if oNewReservation.IsQuick then
    begin
      btnFinish.Enabled := true;
      memRoomNotes.Enabled := true;
      clabRoomNotes.Visible := true;
    end else
    begin
      btnFinish.Enabled := false;
      memRoomNotes.Enabled := false;
      clabRoomNotes.Visible := false;

    end;
  end else
  if pgcMain.ActivePageIndex = 1 then
  begin
    if not oNewReservation.IsQuick then
    begin
      zTotalSelected      := 0;          //0
      zTotalRoomsSelected := 0;     //4
      zTotalAvailable     := 0;         //3
      zTotalFree          := 0;         //2
      zTotalNoRooms       := 0   ;      //1

      zTotal := zTotalSelected+zTotalRoomsSelected+zTotalAvailable+zTotalFree+zTotalNoRooms;
      labTotalSelected.Caption := inttostr(zTotalSelected);
      labTotalRoomsSelected.Caption := inttostr(zTotalRoomsSelected);
    end;

    memRoomNotes.Enabled := false;
    clabRoomNotes.Visible := false;
    btnCancel.enabled    := true;
    btnPrevius.Enabled   := true;
    btnNext.Enabled := true;
    if oNewReservation.IsQuick then
    begin
      btnFinish.Enabled := true;
      memRoomNotes.Enabled := true;
      clabRoomNotes.Visible := true;
    end else
    begin
      btnFinish.Enabled := false;
      memRoomNotes.Enabled := false;
      clabRoomNotes.Visible := false;
    end;
    addAvailableRoomTypes;
  end else
  if pgcMain.ActivePageIndex = 2 then
  begin
    if not oNewReservation.IsQuick then
    begin
      zTotalSelected := 0;          //0
      zTotalRoomsSelected := 0;     //4
      zTotalAvailable := 0;         //3
      zTotalFree      := 0;         //2
      zTotalNoRooms   := 0   ;      //1

      zTotal := zTotalSelected+zTotalRoomsSelected+zTotalAvailable+zTotalFree+zTotalNoRooms;
      labTotalSelected.Caption := inttostr(zTotalSelected);
      labTotalRoomsSelected.Caption := inttostr(zTotalRoomsSelected);
    end;

    btnCancel.enabled    := true;
    btnPrevius.Enabled   := true;
    btnNext.Enabled := true;

    if oNewReservation.IsQuick then
    begin
      btnFinish.Enabled := true;
      memRoomNotes.Enabled := true;
      clabRoomNotes.Visible := true;

    end else
    begin
      btnFinish.Enabled := false;
      memRoomNotes.Enabled := false;
      clabRoomNotes.Visible := false;
      getSelectRooms;
    end;


    zTotalSelected      := tvSelectType.DataController.Summary.FooterSummaryValues[0];
    zTotalRoomsSelected := tvSelectType.DataController.Summary.FooterSummaryValues[4];     //4
    zTotalAvailable     := tvSelectType.DataController.Summary.FooterSummaryValues[3];     //3
    zTotalFree          := tvSelectType.DataController.Summary.FooterSummaryValues[2];      //2
    zTotalNoRooms       := tvSelectType.DataController.Summary.FooterSummaryValues[1];      //1

     zTotal := zTotalSelected+zTotalRoomsSelected+zTotalAvailable+zTotalFree+zTotalNoRooms;
     labTotalSelected.Caption := inttostr(zTotalSelected);

  end else
  if pgcMain.ActivePageIndex = 3 then
  begin
    //**

//    tvRoomResMainGuest.Visible := (NOT chkContactIsGuest.Checked) OR (Trim(edContactPerson.Text)='');

    if not oNewReservation.IsQuick then
    begin
      if ((zTotalSelected > 0) and (zTotalRoomsSelected = 0))
        OR ((zTotalSelected = 0) and (zTotalNoRooms > 0))
      then
      begin
        SetAllAsNoRoom(false);
      end;
    end;

    btnCancel.enabled    := true;
    btnPrevius.Enabled   := true;
    btnNext.Enabled      := false;
    if oNewReservation.IsQuick then
    begin
      btnFinish.Enabled := true;
      memRoomNotes.Enabled := true;
      clabRoomNotes.Visible := true;
    end else
    begin
      btnFinish.Enabled := false;
      memRoomNotes.Enabled := false;
      clabRoomNotes.Visible := false;
    end;
    if oNewReservation.IsQuick then
    begin
      if zIsFirsttime then
        if NOT createRoomRes_quick then
        begin
          Close;
          Exit;
        end;
    end else
    begin
      createRoomRes_normal;
    end;
    GetPrices;
  end;
end;

//##############################################################################################################
//##############################################################################################################


procedure TfrmMakeReservationQuick.Button1Click(Sender: TObject);
begin
  //
end;

procedure TfrmMakeReservationQuick.mnuFinishAndShowClick(Sender: TObject);
begin
  apply;
  oNewReservation.ShowProfile := true;

  close;
  modalresult := mrok;
end;

procedure TfrmMakeReservationQuick.addAvailableRoomTypes;
var
  rSet : TRoomerDataset;
  i : integer;
  s : string;

  RoomType            : string;
  NumberGuests        : integer;
  RoomTypeDescription : string;
  Description : string;

  dateFrom : TDate;
  dateTo : Tdate;
  aDate      : TDate;
  Status     : string ;
  isNoRoom   : boolean;
  RoomCount  : integer;
  DateCount  : integer;

  TotalNotFree : integer;


  bExcluteWaitingList : boolean;
  bExcluteAllotment   : boolean;
  bExcluteOrder       : boolean;
  bExcluteDeparted    : boolean;
  bExcluteGuest       : boolean;
  bExcluteBlocked     : boolean;
  bExcluteNoshow      : boolean;

  MaxFree  : integer;
  MinAvailable  : integer;
  OccTotal : integer;
  nrTotal  : integer;

  tmpRoomType : string;
  tmpDescription : string;

begin
  mOCC_.DisableControls;
  try
    screen.Cursor := crHourGlass;
    try
      DateFrom  := dtArrival.Date;
      DateTo    := dtDeparture.Date;
      DateCount := trunc(DateTo)-trunc(DateFrom);

      if m_.Active then m_.Close;
      m_.Open;

      s := '';
      s := s+'SELECT rt.RoomType,rt.Description,  ' ;
      s := s+'(SELECT COUNT(Room) FROM rooms WHERE rooms.RoomType=rt.RoomType) AS NumRooms ' ;
      s := s+'FROM roomtypes rt ';
      s := s+'ORDER BY rt.RoomType ';

      rSet := createNewDataSet;
      try
        rSet_bySQL(rSet,s);

        aDate := DateFrom;
        for i := 1 to DateCount do
        begin
          rSet.First;
          while not rSet.Eof do
          begin
            m_.Append;
            m_.FieldByName('RoomType').AsString := rSet.FieldByName('RoomType').AsString;
            m_.FieldByName('Description').AsString := rSet.FieldByName('Description').AsString;
            m_.FieldByName('MaxFree').AsInteger := rSet.FieldByName('NumRooms').AsInteger;
            m_.FieldByName('aDate').AsDateTime := aDate;
            m_.Post;
            rSet.Next;
          end;
          aDate := aDate+1;
        end;
      finally
        freeandnil(rSet);
      end;


      s := '';
      s := s+ 'SELECT ';
      s := s+ '    ADate ';
      s := s+ '  , RoomType ';
      s := s+ '  , isNoRoom ';
      s := s+ '  , ResFlag ';
      s := s+ '  , COUNT(Room) AS RoomCount ';
      s := s+ 'FROM ';
      s := s+ '  roomsdate ';
      s := s+ 'WHERE ';
      s := s+ '  ((ADate >= '+_db(DateFrom)+') AND (ADate <= '+_db(DateTo)+')) ';
      s := s+ '   AND (ResFlag <> '+_db(STATUS_DELETED)+' ) '; //**zxhj line added
      s := s+ '   AND (ResFlag <> '+_db(STATUS_CANCELED)+' ) '; //**zxhj line added

      s := s+ 'GROUP BY ';
      s := s+ '    ADate ';
      s := s+ '  , RoomType ';
      s := s+ '  , ResFlag ';
      s := s+ '  , isNoRoom ';
      s := s+ 'ORDER BY ';
      s := s+ '  RoomType,ADate DESC';

      if mOCC_.Active then mOCC_.Close;
      mOCC_.Open;

      rSet := createNewDataSet;
      try
        rSet_bySQL(rSet,s);
        rSet.First;
        while not rSet.Eof do
        begin
          aDate         := _DBDateToDate(rSet.FieldByName('aDate').AsString);
          RoomType      := rSet.FieldByName('RoomType').AsString;
          Status        := rSet.FieldByName('ResFlag').AsString;
          isNoRoom      := rSet.FieldByName('isNoRoom').AsBoolean;
          RoomCount     := rSet.FieldByName('RoomCount').AsInteger;

          mOCC_.Append;
          mOCC_.FieldByName('RoomType').AsString   := RoomType  ;
          mOCC_.FieldByName('Status').AsString     := Status    ;
          mOCC_.FieldByName('aDate').AsDateTime    := aDate;    ;
          mOCC_.FieldByName('isNoRoom').AsBoolean  := isNoRoom  ;
          mOCC_.FieldByName('RoomCount').AsInteger := RoomCount ;
          mOCC_.Post;

          if m_.Locate('aDate;RoomType', VarArrayOf([aDate, roomType]), []) then
          begin
            m_.Edit;
            if isNoRoom then
            begin
              m_.FieldByName('nrTotal').AsInteger := m_.FieldByName('nrTotal').AsInteger+RoomCount;
              if Status = 'P' then m_.FieldByName('nrOrder').AsInteger      := m_.FieldByName('nrOrder').AsInteger     +RoomCount;
              if Status = 'G' then m_.FieldByName('nrGuest').AsInteger       := m_.FieldByName('nrGuest').AsInteger      +RoomCount;
              if Status = 'D' then m_.FieldByName('nrDeparted').AsInteger    := m_.FieldByName('nrDeparted').AsInteger   +RoomCount;
              if Status = 'O' then m_.FieldByName('nrWaitingList').AsInteger := m_.FieldByName('nrWaitingList').AsInteger+RoomCount;
              if Status = 'A' then m_.FieldByName('nrAllotment').AsInteger   := m_.FieldByName('nrAllotment').AsInteger  +RoomCount;
              if Status = 'B' then m_.FieldByName('nrBlocked').AsInteger     := m_.FieldByName('nrBlocked').AsInteger    +RoomCount;
              if Status = 'N' then m_.FieldByName('nrNoShow').AsInteger      := m_.FieldByName('nrNoShow').AsInteger     +RoomCount;
            end else
            begin
              m_.FieldByName('occTotal').AsInteger := m_.FieldByName('occTotal').AsInteger+RoomCount;
              if Status = 'P' then m_.FieldByName('occOrder').AsInteger       := m_.FieldByName('occOrder').AsInteger     +RoomCount;
              if Status = 'G' then m_.FieldByName('occGuest').AsInteger       := m_.FieldByName('occGuest').AsInteger      +RoomCount;
              if Status = 'D' then m_.FieldByName('occDeparted').AsInteger    := m_.FieldByName('occDeparted').AsInteger   +RoomCount;
              if Status = 'O' then m_.FieldByName('occWaitingList').AsInteger := m_.FieldByName('occWaitingList').AsInteger+RoomCount;
              if Status = 'A' then m_.FieldByName('occAllotment').AsInteger   := m_.FieldByName('occAllotment').AsInteger  +RoomCount;
              if Status = 'B' then m_.FieldByName('occBlocked').AsInteger     := m_.FieldByName('occBlocked').AsInteger    +RoomCount;
              if Status = 'N' then m_.FieldByName('occNoShow').AsInteger      := m_.FieldByName('occNoShow').AsInteger     +RoomCount;
            end;
            m_.Post;
          end;
          rSet.Next;
        end;
      finally
        freeandnil(rSet);
      end;
      mOCC_.First;

      bExcluteWaitingList := chkExcluteWaitingList.checked;
      bExcluteAllotment   := chkExcluteAllotment  .checked;
      bExcluteOrder       := chkExcluteOrder      .checked;
      bExcluteDeparted    := chkExcluteDeparted   .checked;
      bExcluteGuest       := chkExcluteGuest      .checked;
      bExcluteBlocked     := chkExcluteBlocked    .checked;
      bExcluteNoshow      := chkExcluteNoshow     .checked;

      m_.SortedField := 'RoomType';
      m_.First;
      while not m_.eof do
      begin
        MaxFree  := m_.fieldbyname('MaxFree').asInteger;
        OccTotal := m_.fieldbyname('occTotal').asInteger;
        nrTotal  := m_.fieldbyname('nrTotal').asInteger;
        totalNotFree := MaxFree-OccTotal-nrTotal;
        if bExcluteWaitingList then TotalNotFree := TotalNotFree+m_.FieldByName('nrWaitingList').asinteger;
        if bExcluteAllotment   then TotalNotFree := TotalNotFree+m_.FieldByName('nrAllotment').asinteger;
        if bExcluteOrder       then TotalNotFree := TotalNotFree+m_.FieldByName('nrOrder').asinteger;
        if bExcluteDeparted    then TotalNotFree := TotalNotFree+m_.FieldByName('nrDeparted').asinteger;
        if bExcluteGuest       then TotalNotFree := TotalNotFree+m_.FieldByName('nrGuest').asinteger;
        if bExcluteBlocked     then TotalNotFree := TotalNotFree+m_.FieldByName('nrBlocked').asinteger;
        if bExcluteNoShow      then TotalNotFree := TotalNotFree+m_.FieldByName('nrNoShow').asinteger;

        m_.edit;
          m_.FieldByName('FreeRooms').AsInteger := TotalNotFree;
        m_.Post;
        m_.Next;
      end;
      m_.SortedField := 'RoomType';
      m_.First;

      if mSelectTypes.Active then mSelectTypes.Close;
      mSelectTypes.Open;

      m_.SortedField := 'RoomType';
      m_.First;

      tmpRoomType := m_.FieldByName('RoomType').AsString;
      tmpDescription := m_.FieldByName('RoomType').AsString;
      minAvailable := 1000;
      while not m_.eof do
      begin
        if tmpRoomType <> m_.FieldByName('RoomType').AsString then
        begin
          mSelectTypes.Append;
          mSelectTypes.FieldByName('RoomType').AsString := tmpRoomType;
          mSelectTypes.FieldByName('RoomTypeDescription').AsString := tmpDescription;
          mSelectTypes.FieldByName('Available').AsInteger := minAvailable;
          mSelectTypes.FieldByName('Selected').AsInteger := 0;
          mSelectTypes.FieldByName('NoRooms').AsInteger := 0;
          mSelectTypes.Post;
          tmpRoomType := m_.FieldByName('RoomType').AsString;
          tmpDescription := m_.FieldByName('Description').AsString;
          minAvailable := 1000;
        end;
        if m_.FieldByName('FreeRooms').AsInteger <= minAvailable then minAvailable := m_.FieldByName('FreeRooms').AsInteger;
        m_.Next;
        if m_.eof then
        begin
          mSelectTypes.Append;
          mSelectTypes.FieldByName('RoomType').AsString := m_.FieldByName('RoomType').AsString;
          mSelectTypes.FieldByName('RoomTypeDescription').AsString := m_.FieldByName('Description').AsString;
          mSelectTypes.FieldByName('Available').AsInteger := minAvailable;
          mSelectTypes.FieldByName('Selected').AsInteger := 0;
          mSelectTypes.FieldByName('NoRooms').AsInteger := 0;
          mSelectTypes.Post;
        end;
      end;

      //Add PriorityRule

      s := '';
      s := s+ 'SELECT ';
      s := s+ '  RoomType ';
      s := s+ ' ,PriorityRule ';
      s := s+ 'FROM roomtypes ';

      rSet := createNewDataSet;
      try
        rSet_bySQL(rSet,s);
        rSet.First;
        while not rSet.Eof do
        begin
          RoomType := rSet.FieldByName('RoomType').AsString;
          if mSelectTypes.Locate('RoomType',roomType,[]) then
          begin
            mSelectTypes.edit;
            mSelectTypes.FieldByName('PriorityRule').AsString := rSet.FieldByName('PriorityRule').AsString;
            mSelectTypes.post;
          end;
          rSet.Next;
        end;
      finally
        freeandnil(rSet);
      end;
    finally
      screen.cursor := crDefault;
    end;

  finally
    mOCC_.EnableControls;
  end;

end;

procedure TfrmMakeReservationQuick.cxButton1Click(Sender: TObject);
var
 iValue : integer;
begin


  //addAvailableRoomTypes;
end;


procedure TfrmMakeReservationQuick.CreateRoomRes_Normal;
var
  oSelectedRoomItem : TnewRoomReservationItem;
  selected     : boolean;
  Room         : string ;
  RoomType     : string ;
  NumberGuests : integer;
  Arrival      : Tdate  ;
  Departure    : TDate  ;

  NumberNoRoom : integer ;


  i : integer;

  roomCount      : integer;
  isPaid         : boolean;
  ChildrenCount  : integer;
  infantCount    : integer;

  RoomReservation : integer;

  RoomDescription      : string;
  RoomTypeDescription  : string;
  PriceCode            : string;

  sID : string;
  lstIDs : TstringList;
begin
  RoomReservation := 0;
  oNewReservation.newRoomReservations.RoomItemsList.Clear;

  Arrival       := dtArrival.Date;
  Departure     := dtDeparture.Date;
  PriceCode     := trim(edPcCode.text);

  lstIds := TstringList.Create;
  try
    if not((zTotalSelected = 0) and (zTotalNoRooms > 0)) and (zTotal <> 0) then
    begin
      mSelectRooms.First;
      while not mSelectRooms.Eof do
      begin
        Room         := mSelectRooms.FieldByName('room').AsString;
        Selected     := mSelectRooms.FieldByName('Select').AsBoolean;
        RoomType     := mSelectRooms.FieldByName('RoomType').AsString;
        NumberGuests := mSelectRooms.FieldByName('NumberGuests').AsInteger;
        if Selected then
        begin
          oSelectedRoomItem := TnewRoomReservationItem.Create(0,Room,RoomType,'',Arrival,departure,NumberGuests,0,0,true,0,0,0,'','','');
          oNewReservation.newRoomReservations.RoomItemsList.Add(oSelectedRoomItem);
        end;
        mSelectRooms.Next;
      end;
      mSelectRooms.First;
    end;

    mSelectTypes.First;
    while not mSelectTypes.Eof do
    begin
      RoomType     := mSelectTypes.FieldByName('RoomType').AsString;
      NumberNoRoom := mSelectTypes.FieldByName('NoRooms').AsInteger;
      Room := '';
      NumberGuests := glb.GET_RoomTypeNumberGuests_byRoomType(RoomType);
      for i  := 1 to NumberNoRoom do
      begin
        oSelectedRoomItem := TnewRoomReservationItem.Create(0,Room,RoomType,'',Arrival,departure,NumberGuests,0,0,true,0,0,0,'','','');
        oNewReservation.newRoomReservations.RoomItemsList.Add(oSelectedRoomItem);
      end;
      mSelectTypes.Next;
    end;
    mSelectTypes.First;

    if mRoomRes.Active then mRoomRes.Close;
    mRoomRes.Open;

    roomCount     := oNewReservation.newRoomReservations.RoomCount;
    isPaid        := false;


    sId := RR_GetIDs(RoomCount);
    _glob._strTokenToStrings(sID,'|',lstIDs);


    for i := 0 to RoomCount-1 do
    begin
      if oNewReservation.newRoomReservations.RoomItemsList[i].FRoomReservation < 1 then
      begin
        RoomReservation := strToInt(lstIDs[i]);//RR_SetNewID();
        oNewReservation.newRoomReservations.RoomItemsList[i].SetRoomreservation(RoomReservation);
      end;

      room  := oNewReservation.newRoomReservations.RoomItemsList[i].getRoomNumber;
      if room = '' then
      begin
        room := '<'+inttostr(RoomReservation)+'>';
  //      roomType := oNewReservation.newRoomReservations.RoomItemsList[i].FRoomType;
      end;

      arrival       := oNewReservation.newRoomReservations.RoomItemsList[i].getArrival;
      departure     := oNewReservation.newRoomReservations.RoomItemsList[i].getDeparture;
      numberGuests  := oNewReservation.newRoomReservations.RoomItemsList[i].getGuestCount;
      childrenCount := oNewReservation.newRoomReservations.RoomItemsList[i].getChildrenCount;
      infantCount   := oNewReservation.newRoomReservations.RoomItemsList[i].getInfantCount;
      roomType      := oNewReservation.newRoomReservations.RoomItemsList[i].getRoomType;

      RoomDescription     := '';
      RoomTypeDescription := '';

      if not (zTotalSelected = 0) and (zTotalNoRooms > 0) then
      begin
        if mSelectRooms.Locate('RoomType',RoomType,[]) then
        begin
          RoomDescription     := mSelectRooms.FieldByName('Description').asString;
          RoomTypeDescription := mSelectRooms.FieldByName('RoomTypeDescription').asString;
        end;
      end;

      if (copy(room,1,1)) = '<' then
      begin
        // It is noroom
        // There is no roomdescription
        // .. Get the roomType Description
        RoomTypeDescription := glb.GetRoomTypeDescription(RoomType);
        if numberGuests = 0 then
           NumberGuests        := glb.GET_RoomTypeNumberGuests_byRoomType(RoomType);
      end;

      mRoomRes.append;
      mRoomRes.FieldByName('RoomReservation').AsInteger      := Roomreservation;
      mRoomRes.FieldByName('room').AsString                  := room;
      mRoomRes.FieldByName('RoomType').AsString              := RoomType;
      mRoomRes.FieldByName('Guests').AsInteger               := NumberGuests;
      mRoomRes.FieldByName('AvragePrice').AsFloat            := 0;
      mRoomRes.FieldByName('RateCount').AsFloat              := 0;
      mRoomRes.FieldByName('AvrageDiscount').AsFloat         := 0;
      mRoomRes.FieldByName('isPercentage').Asboolean         := true;

      mRoomRes.FieldByName('ManualChannelId').AsInteger      := 0;
      mRoomRes.FieldByName('ratePlanCode').AsString          := '';

      mRoomRes.FieldByName('RoomDescription').AsString       := RoomDescription;
      mRoomRes.FieldByName('RoomTypeDescription').AsString   := RoomTypeDescription;
      mRoomRes.FieldByName('arrival').AsDateTime             := arrival;
      mRoomRes.FieldByName('departure').AsDateTime           := departure;
      mRoomRes.FieldByName('ChildrenCount').AsInteger        := ChildrenCount;
      mRoomRes.FieldByName('InfantCount').AsInteger          := InfantCount;
      mRoomRes.FieldByName('PriceCode').AsString             := PriceCode;
      mRoomRes.FieldByName('PersonsProfilesId').AsInteger    := edtPortfolio.Tag;
      if chkContactIsGuest.Checked AND (TRIM(edContactPerson.Text) <> '') then
        mRoomRes['MainGuest'] := edContactPerson.Text
      else
      if (TRIM(edtPortfolio.Text) <> '') then
        mRoomRes['MainGuest'] := edtPortfolio.Text
      else
        mRoomRes['MainGuest'] := edReservationName.Text;
      mRoomRes.post;
    end;

    if mRoomRes.RecordCount > 0 then
    begin
      btnFinish.Enabled := true;
      memRoomNotes.Enabled := true;
      clabRoomNotes.Visible := true;

      mRoomRes.First;
    end;
  finally
    freeandnil(lstIDs);
  end;
end;

function TfrmMakeReservationQuick.CreateRoomRes_Quick : Boolean;
var
  rSetRooms : TRoomerDataset;
//  rSetAvail : TRoomerDataset;
  i : integer;

  s : string;

  Arrival             : TdateTime;
  Departure           : TDateTime;

  roomReservation     : integer  ;
  room                : string   ;
  RoomType            : string;
  Guests              : integer  ;

  RoomDescription     : string;
  RoomTypeDescription : string;
  ChildrenCount       : integer;
  infantCount         : integer;
  roomCount            : integer;

  priceCode     : string ;

  defaultGuests : integer;

  sID          : string;
  lstIDs       : TstringLIst;
  sRoomsInList : string;
  sRoomTypes : TStrings;
  sMessage : String;

  ExecutionPlan : TRoomerExecutionPlan;

  AvailabilityPerDay : TAvailabilityPerDay;

begin
  result := True;
  DefaultGuests := 2;
  RoomReservation := 0;
  PriceCode     := trim(edPcCode.text);

  if mRoomRes.Active then mRoomRes.Close;
  mRoomRes.Open;
  roomCount     := oNewReservation.newRoomReservations.RoomCount;
  ChildrenCount := 0;
  infantCount   := 0;


  lstIDs := TstringList.Create;
  try

    sId := RR_GetIDs(RoomCount);
    _glob._strTokenToStrings(sID,'|',lstIDs);

    sRoomsInList := '';

    for i := 0 to RoomCount-1 do
    begin
      room  := oNewReservation.newRoomReservations.RoomItemsList[i].getRoomNumber;
      if room <> '' then
      begin
        sRoomsInList := sRoomsInList+_db(room)+',';
      end;
    end;

    if sRoomsInList <> '' then delete(sRoomsInList,length(sRoomsInList),1);

    s := '';
    s:=s+ ' SELECT '+#10;
    s:=s+ '     rooms.Room '+#10;
    s:=s+ '   , rooms.Description AS RoomDescription '+#10;
    s:=s+ '   , rooms.RoomType '+#10;
    s:=s+ '   , roomtypes.NumberGuests '+#10;
    s:=s+ '   , roomtypes.Description AS RoomTypeDescription '+#10;
    s:=s+ ' FROM '+#10;
    s:=s+ '   rooms '+#10;
    s:=s+ '   LEFT OUTER JOIN roomtypes ON rooms.RoomType = roomtypes.RoomType '+#10;
    s:=s+ ' WHERE '+#10;
    s:=s+ '   (rooms.Room in ('+sRoomsInList+'))'+#10;

    ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
    try
      ExecutionPlan.AddQuery(s);
      ExecutionPlan.Execute(ptQuery);
      rSetRooms := ExecutionPlan.Results[0];

      for i := 0 to RoomCount-1 do
      begin
        if oNewReservation.newRoomReservations.RoomItemsList[i].FRoomReservation < 1 then
        begin
          RoomReservation := strToInt(lstIDs[i]);//RR_SetNewID();
          oNewReservation.newRoomReservations.RoomItemsList[i].SetRoomreservation(RoomReservation);
        end;

        room  := oNewReservation.newRoomReservations.RoomItemsList[i].getRoomNumber;
        if room = '' then
        begin
          room := '<'+inttostr(RoomReservation)+'>';
          roomType := oNewReservation.newRoomReservations.RoomItemsList[i].FRoomType;
        end;

        arrival       := oNewReservation.newRoomReservations.RoomItemsList[i].getArrival;
        departure     := oNewReservation.newRoomReservations.RoomItemsList[i].getDeparture;
        guests        := oNewReservation.newRoomReservations.RoomItemsList[i].getGuestCount;
        childrenCount := oNewReservation.newRoomReservations.RoomItemsList[i].getChildrenCount;
        infantCount   := oNewReservation.newRoomReservations.RoomItemsList[i].getInfantCount;

        if (copy(room,1,1)) <>  '<' then
        begin
          rSetRooms.Locate('room',room,[]);
          RoomDescription     := rSetRooms.FieldByName('RoomDescription').asString;
          RoomType            := rSetRooms.FieldByName('RoomType').asString;
          oNewReservation.newRoomReservations.RoomItemsList[i].FRoomType := RoomType;
          DefaultGuests       := rSetRooms.FieldByName('NumberGuests').asInteger;
          RoomTypeDescription := rSetRooms.FieldByName('RoomTypeDescription').asString;
        end else
        begin // It is noroom
          // There is no roomdescription
          // .. Get the roomType Description
          RoomTypeDescription := glb.GetRoomTypeDescription(RoomType);
          DefaultGuests := glb.GET_RoomTypeNumberGuests_byRoomType(RoomType);
        end;

        Guests := DefaultGuests;

        mRoomRes.append;
        mRoomRes.FieldByName('RoomReservation').AsInteger      := Roomreservation;
        mRoomRes.FieldByName('room').AsString                  := room;
        mRoomRes.FieldByName('RoomType').AsString              := RoomType;
        mRoomRes.FieldByName('Guests').AsInteger               := Guests;
        mRoomRes.FieldByName('AvragePrice').AsFloat            := 0;
        mRoomRes.FieldByName('RateCount').AsFloat              := 0;
        mRoomRes.FieldByName('AvrageDiscount').AsFloat         := 0;

        mRoomRes.FieldByName('ManualChannelId').AsInteger      := 0;
        mRoomRes.FieldByName('ratePlanCode').AsString          := '';

        mRoomRes.FieldByName('RoomDescription').AsString       := RoomDescription;
        mRoomRes.FieldByName('RoomTypeDescription').AsString   := RoomTypeDescription;
        mRoomRes.FieldByName('arrival').AsDateTime             := arrival;
        mRoomRes.FieldByName('departure').AsDateTime           := departure;
        mRoomRes.FieldByName('ChildrenCount').AsInteger        := ChildrenCount;
        mRoomRes.FieldByName('InfantCount').AsInteger          := InfantCount;
        mRoomRes.FieldByName('PriceCode').AsString             := PriceCode;
        mRoomRes.FieldByName('PersonsProfilesId').AsInteger    := edtPortfolio.Tag;
        if chkContactIsGuest.Checked AND (TRIM(edContactPerson.Text) <> '') then
          mRoomRes['MainGuest'] := edContactPerson.Text
        else
        if (TRIM(edtPortfolio.Text) <> '') then
          mRoomRes['MainGuest'] := edtPortfolio.Text
        else
          mRoomRes['MainGuest'] := edReservationName.Text;
        mRoomRes.post;
      end;
      zIsFirstTime := false;

      if g.qWarnWhenOverbooking then
      begin
        sMessage := '';
        AvailabilityPerDay := TAvailabilityPerDay.Create(dtArrival.Date, dtDeparture.Date, oNewReservation);
        sRoomTypes := AvailabilityPerDay.Overbookings;
        try
          sMessage := sRoomTypes.Text;
        finally
          sRoomTypes.Free;
        end;
        if sMessage <> '' then
        begin
          s := getTranslatedText('shTx_Various_WouldCreateOverbooking') +
               sMessage + #10#10 +
               getTranslatedText('shTx_Various_AreYoySureYouWantToContinue');
          if MessageDlg(s, mtWarning, [mbYes, mbCancel], 0) <> mrYes then
          begin
            result := False;
            exit;
          end;
        end;
      end;

    finally
       freeandnil(ExecutionPlan);
    end;


  finally
    freeandNil(lstIDs);
  end;
end;

procedure TfrmMakeReservationQuick.PopulateRatePlanCombo;
begin
  (tvRoomResRatePlanCode.Properties AS TcxComboBoxProperties).Items.Clear;
  (tvRoomResRatePlanCode.Properties AS TcxComboBoxProperties).Items.Add('');
  DynamicRates.GetAllRateCodes((tvRoomResRatePlanCode.Properties AS TcxComboBoxProperties).Items);
end;

procedure TfrmMakeReservationQuick.GetPrices;
var
  lstPrices       : Tstringlist;
  RoomReservation : integer;

  i,ii : integer;

  room                : string   ;
  RoomType            : string;
  Guests              : integer  ;
  AvragePrice         : double   ;
  RateCount           : integer;
  RoomDescription     : string;
  RoomTypeDescription : string;
  Arrival             : TdateTime;
  Departure           : TDateTime;
  ChildrenCount       : integer;
  infantCount         : integer;
  DiscountAmount      : double;
  RentAmount          : double;
  NativeAmount        : double;

  priceID       : integer;
  priceCode     : string ;

  rateTotal     : double;
  rateAvrage    : double;

  dayCount      : integer;
  aDate         : TDateTime;
  DateFrom : Tdate;
  DateTo   : TDate;


  RateDate      : TdateTime    ;
  rate          : Double;

  IsPercentage  : Boolean ;
  IsPaid        : Boolean ;

  Currency      : string  ;
  CurrencyRate  : Double  ;
  Discount      : Double  ;
  showDiscount  : boolean ;

  discountTotal     : double;
  discountAvrage    : double;

  rateSet : TRoomerDataset;


  s : string;
  lstRoomTypes : TstringList;
  inStrRoomTypes : string;
  andRoomTypes : String;


  FirstArrival : Tdate;
  LastDeparture : Tdate;

  roomPrice : double;


  price1p : double;
  price2p : double;
  price3p : double;
  price4p : double;
  price5p : double;
  price6p : double;
  priceEp : double;
  PriceEc : double;
  PriceEi : double;



  function finalPrice(p1,p2,p3,p4,p5,p6,Ep,Ec,Ei : double; GuestCount,ChildCount,infantCount : integer) : double;
  var
    extraPersons : double;
  begin
    extraPersons := GuestCount - 5;

    if p1 = 0 then p1 := Ep;
    if p2 = 0 then p2 := p1 + ep;
    if p3 = 0 then p3 := p2 + ep;
    if p4 = 0 then p4 := p3 + ep;
    if p5 = 0 then p5 := p4 + ep;
    if p6 = 0 then p6 := p5 + ep;

    if GuestCount = 1 then result := p1;
    if GuestCount = 2 then result := p2;
    if GuestCount = 3 then result := p3;
    if GuestCount = 4 then result := p4;
    if GuestCount = 5 then result := p5;
    if GuestCount = 6 then result := p6;

    if GuestCount > 6 then result := p6 + (extraPersons * Ep);

    result := result+(Ec * ChildCount);
    result := result+(Ei * infantCount);
  end;

  var rateId : String;
      channelId : Integer;
begin
  channelId := 0;
  if edtRatePlans.ItemIndex > 0 then
    channelId := Integer(edtRatePlans.Items.Objects[edtRatePlans.ItemIndex]);
  IsPaid := False;
  mRoomRes.DisableControls;
  lstPrices    := TstringList.Create;
  lstRoomTypes := TstringList.Create;

  rateSet := CreateNewDataSet;
  try

    lstRoomTypes.Sorted := true;
    lstRoomTypes.Duplicates := dupIgnore;

    mRoomRes.First;
    if not mRoomRes.eof then
    begin
      FirstArrival  := mRoomRes.FieldByName('Arrival').AsDateTime;
      LastDeparture := mRoomRes.FieldByName('departure').AsDateTime;
    end;
    while not mRoomRes.eof do
    begin
      if mRoomRes.FieldByName('Arrival').AsDateTime < firstArrival then firstArrival := mRoomRes.FieldByName('Arrival').AsDateTime;
      if mRoomRes.FieldByName('Departure').AsDateTime > LastDeparture then LastDeparture := mRoomRes.FieldByName('Departure').AsDateTime;
      RoomType := mRoomRes.FieldByName('RoomType').AsString;
      lstRoomTypes.Add(_db(RoomType));
      mRoomRes.next;
    end;

    inStrRoomTypes := '';
    for i := 0 to lstRoomTypes.count-1 do
    begin
      inStrRoomTypes := inStrRoomTypes+lstRoomTypes[i];
      if i <> lstRoomTypes.count-1 then inStrRoomTypes := inStrRoomTypes+',';
    end;

    s := '';
    s := s+'SELECT '#10;
    s := s+'    `roomrates`.`ID` AS `ID`, '#10;
    s := s+'    `roomrates`.`PriceCodeID` AS `PriceCodeID`, '#10;
    s := s+'    `tblpricecodes`.`pcCode` AS `pcCode`, '#10;
    s := s+'    `tblpricecodes`.`pcRack` AS `pcRack`, '#10;
    s := s+'    `roomrates`.`CurrencyID` AS `CurrencyID`, '#10;
    s := s+'    `currencies`.`Currency` AS `Currency`, '#10;
    s := s+'    `roomrates`.`SeasonID` AS `SeasonID`, '#10;
    s := s+'    `tblseasons`.`seStartDate` AS `seStartDate`, '#10;
    s := s+'    `tblseasons`.`seEndDate` AS `seEndDate`, '#10;
    s := s+'    `tblseasons`.`seDescription` AS `seDescription`, '#10;
    s := s+'    `roomrates`.`RoomTypeID` AS `RoomTypeID`, '#10;
    s := s+'    `roomtypes`.`RoomType` AS `RoomType`, '#10;
    s := s+'    `roomtypes`.`NumberGuests` AS `NumberGuests`, '#10;
    s := s+'    `roomrates`.`RateID` AS `RateID`, '#10;
    s := s+'    `rates`.`Currency` AS `RateCurrency`, '#10;
    s := s+'    `rates`.`Rate1Person` AS `Rate1Person`, '#10;
    s := s+'    `rates`.`Rate2Persons` AS `Rate2Persons`, '#10;
    s := s+'    `rates`.`Rate3Persons` AS `Rate3Persons`, '#10;
    s := s+'    `rates`.`Rate4Persons` AS `Rate4Persons`, '#10;
    s := s+'    `rates`.`Rate5Persons` AS `Rate5Persons`, '#10;
    s := s+'    `rates`.`Rate6Persons` AS `Rate6Persons`, '#10;
    s := s+'    `rates`.`RateExtraPerson` AS `RateExtraPerson`, '#10;
    s := s+'    `rates`.`RateExtraChildren` AS `RateExtraChildren`, '#10;
    s := s+'    `rates`.`RateExtraInfant` AS `RateExtraInfant`, '#10;
    s := s+'    `rates`.`Description` AS `rateDescription`, '#10;
    s := s+'    `roomrates`.`Active` AS `Active`, '#10;
    s := s+'    `roomrates`.`DateFrom` AS `DateFrom`, '#10;
    s := s+'    `roomrates`.`DateTo` AS `DateTo`, '#10;
    s := s+'    `roomrates`.`Description` AS `Description`, '#10;
    s := s+'    `roomrates`.`DateCreated` AS `DateCreated`, '#10;
    s := s+'    `roomrates`.`LastModified` AS `LastModified`, '#10;
    s := s+'   DATEDIFF(DateTo,DateFrom) AS DateCount '#10;

    s := s+'FROM predefineddates, '#10;
    s := s+'    (((((`roomrates` '#10;
    s := s+'    left join `tblpricecodes` ON ((`roomrates`.`PriceCodeID` = `tblpricecodes`.`ID`))) '#10;
    s := s+'    left join `rates` ON ((`roomrates`.`RateID` = `rates`.`ID`))) '#10;
    s := s+'    left join `tblseasons` ON ((`roomrates`.`SeasonID` = `tblseasons`.`ID`))) '#10;
    s := s+'    left join `roomtypes` ON ((`roomrates`.`RoomTypeID` = `roomtypes`.`ID`))) '#10;
    s := s+'    left join `currencies` ON ((`roomrates`.`CurrencyID` = `currencies`.`ID`))) '#10;
    s := s+'WHERE '#10;
    s := s+'       predefineddates.date >= %s AND predefineddates.date <= %s '#10;
    s := s+'  AND  `PriceCodeID` = %d '#10;
    s := s+'  AND  currencies.Currency = %s '#10;
    s := s+'  %s '#10;
    s := s+'  AND  (`DateFrom` <= predefineddates.date AND `DateTo` >= predefineddates.date)'#10;
    s := s+'ORDER by '#10;
    s := s+'  `roomtypes`.`RoomType` '#10;
    s := s+' , DateCount '#10;

    lstPrices.Sorted := true;
    lstPrices.Duplicates := dupIgnore;

    currency      := edCurrency.Text;

    CurrencyRate  := hData.GetRate(currency);
    discount      := edRoomResDiscount.Value;
    showDiscount  := true;
    isPercentage  := cbxIsRoomResDiscountPrec.ItemIndex=0;

    PriceCode     := trim(edPcCode.text);
    PriceID       := hdata.PriceCode_ID(priceCode);

    andRoomTypes := '';
    if Trim(inStrRoomTypes) <> '' then
      andRoomTypes := format('AND  `RoomType` IN (%s)', [inStrRoomTypes]);

    s := format(s,[ _dateToDbDate(firstArrival,true)
              ,_dateToDbDate(lastDeparture,true)
              ,PriceID
              ,_db(currency)
              ,andRoomTypes
              ]);


    if rSet_bySQL(rateSet,s) then
    begin

    end;

// debugmessage(_dateToDbDate(firstArrival,true)+' / '+_dateToDbDate(lastDeparture,true));
//   copytoclipboard(s);
//   debugmessage(s);

    if mRoomRates.Active then mRoomRates.Close;
    mRoomRates.open;

    mRoomRes.First;
    while not mRoomRes.eof do
    begin
      RoomReservation := mRoomRes.FieldByName('roomReservation').AsInteger;

      i := oNewReservation.newRoomReservations.FindRoomFromRoomReservation(RoomReservation,0);
      oNewReservation.newRoomReservations.RoomItemsList[i].oRates.RateItemsList.Clear;

      room                := mRoomRes.FieldByName('room').AsString                ;
      arrival             := mRoomRes.FieldByName('arrival').AsDateTime           ;
      departure           := mRoomRes.FieldByName('departure').AsDateTime         ;
      RoomType            := mRoomRes.FieldByName('RoomType').AsString            ;
      RoomTypeDescription := mRoomRes.FieldByName('RoomTypeDescription').AsString ;
      RoomDescription     := mRoomRes.FieldByName('RoomDescription').AsString     ;
      Guests              := mRoomRes.FieldByName('Guests').AsInteger             ;
      ChildrenCount       := mRoomRes.FieldByName('ChildrenCount').AsInteger      ;
      InfantCount         := mRoomRes.FieldByName('infantCount').AsInteger        ;

      dayCount := trunc(departure)-trunc(arrival);

      aDate     := trunc(Arrival);
      rate := 0;
      rateId := '';
      rateTotal := 0;
      discountTotal := 0;
      lstPrices.Clear;
      for ii := 0  to dayCount-1 do
      begin
        if DynamicRates.Active AND
          DynamicRates.findRateForRoomType(trunc(arrival)+ii, RoomType, mRoomRes['Guests'], roomPrice, rateId) then
        begin
          // Rate acuired
        end else
        begin
          rateSet.first;
          roomPrice := 0;
          while not rateSet.eof do
          begin
            DateFrom := rateSet.fieldbyname('DateFrom').asdateTime;
            DateTo := rateSet.fieldbyname('DateTo').asdateTime;
            if (uppercase(roomtype)=uppercase(rateSet.fieldbyname('roomtype').asstring))  then
            begin
              if priceId = rateSet.fieldbyname('PriceCodeID').asInteger then
              begin
                if uppercase(currency) = uppercase(rateSet.fieldbyname('Currency').asstring) then
                begin
                  if (adate >=DateFrom) and (aDate<=DateTo) then
                  begin
                    price1p := rateSet.GetFloatValue(rateSet.fieldbyname('Rate1Person'));
                    price2p := rateSet.GetFloatValue(rateSet.fieldbyname('Rate2Persons'));
                    price3p := rateSet.GetFloatValue(rateSet.fieldbyname('Rate3Persons'));
                    price4p := rateSet.GetFloatValue(rateSet.fieldbyname('Rate4Persons'));
                    price5p := rateSet.GetFloatValue(rateSet.fieldbyname('Rate5Persons'));
                    price6p := rateSet.GetFloatValue(rateSet.fieldbyname('Rate6Persons'));
                    priceEp := rateSet.GetFloatValue(rateSet.fieldbyname('RateExtraPerson'));
                    PriceEc := rateSet.GetFloatValue(rateSet.fieldbyname('RateExtraChildren'));
                    PriceEi := rateSet.GetFloatValue(rateSet.fieldbyname('RateExtraInfant'));
                    roomPrice := finalPrice( price1p
                                            ,price2p
                                            ,price3p
                                            ,price4p
                                            ,price5p
                                            ,price6p
                                            ,priceEp
                                            ,PriceEc
                                            ,PriceEi
                                            ,Guests
                                            ,ChildrenCount
                                            ,infantCount);
                    Break;

                  end;
                end;
              end;
            end;
            rateSet.next;
          end;
        end;


        Rate := roomPrice;

//        Rate :=  oNewReservation.newRoomReservations.RoomItemsList[i].oRates.GetDayRate
//                 (RoomType
//                 ,Room
//                 ,aDate
//                 ,guests
//                 ,ChildrenCount
//                 ,infantCount
//                 ,currency
//                 ,PriceID
//                 ,discount
//                 ,showDiscount
//                 ,isPercentage
//                 ,isPaid
//                 ,false
//
//                  );



          DiscountAmount := 0;
          RentAmount := 0;
          NativeAmount := 0;

          if rate <> 0 then
          begin
            if discount <> 0 then
            begin
              if isPercentage then
              begin
                DiscountAmount :=  Rate*discount/100;
              end else
              begin
                DiscountAmount := discount;
              end;
            end;
          end;
          RentAmount  := Rate-DiscountAmount;
          if currencyRate = 0 then currencyRate := 1;
          NativeAmount := RentAmount*CurrencyRate;

          mRoomRates.append;
          mRoomRates.FieldByName('Reservation').AsInteger := -1;
          mRoomRates.FieldByName('RoomReservation').AsInteger := Roomreservation;
          mRoomRates.FieldByName('RoomNumber').AsString := Room;
          mRoomRates.FieldByName('RateDate').AsDateTime := aDate;
          mRoomRates.FieldByName('PriceCode').AsString := PriceCode;
          mRoomRates.FieldByName('Rate').AsFloat := Rate;
          mRoomRates.FieldByName('Discount').AsFloat := Discount;
          mRoomRates.FieldByName('isPercentage').AsBoolean := isPercentage;
          mRoomRates.FieldByName('ShowDiscount').AsBoolean := ShowDiscount;
          mRoomRates.FieldByName('isPaid').AsBoolean := isPaid;
          mRoomRates.FieldByName('DiscountAmount').AsFloat := DiscountAmount;
          mRoomRates.FieldByName('RentAmount').AsFloat := RentAmount;
          mRoomRates.FieldByName('NativeAmount').AsFloat := NativeAmount;
          mRoomRates.FieldByName('Currency').AsString := edCurrency.Text;
          mRoomRates.FieldByName('CurrencyRate').AsFloat := CurrencyRate;
          mRoomRates.post;


        lstPrices.Add(floattostr(RentAmount));
        rateTotal := RateTotal+RentAmount;
        discountTotal := discountTotal+discount;
        aDate := aDate+1
      end;

      rateAvrage := 0;
      discountAvrage := 0;
      if dayCount <> 0 then
      begin
        rateAvrage := rateTotal/dayCount;
        discountAvrage := discountTotal/dayCount
      end;
      rateCount := lstPrices.Count;
      mRoomRes.edit;
        mRoomRes.FieldByName('AvragePrice').AsFloat := rateAvrage;
        mRoomRes.FieldByName('RateCount').AsFloat := rateCount;
        mRoomRes.FieldByName('AvrageDiscount').AsFloat := discountAvrage;
        mRoomRes.FieldByName('isPercentage').AsBoolean := isPercentage;

        mRoomRes.FieldByName('ManualChannelId').AsInteger := channelId;
        mRoomRes.FieldByName('ratePlanCode').AsString := rateId;
      mRoomRes.Post;
      mRoomRes.Next;
    end;
  finally
    freeandNil(rateSet);
    freeandNil(lstPrices);
    freeandnil(lstRoomTypes);
    mRoomRes.First;
    mRoomRes.EnableControls;
  end;
end;


function TfrmMakeReservationQuick.CalcOnePrice(roomreservation : integer; NewRate : double=0) : boolean;
var
  lstPrices       : Tstringlist;
//  RoomReservation : integer;

  i,ii : integer;

  room                : string   ;
  RoomType            : string;
  Guests              : integer  ;
  AvragePrice         : double   ;
  RateCount           : integer;
  RoomDescription     : string;
  RoomTypeDescription : string;
  Arrival             : TdateTime;
  Departure           : TDateTime;
  ChildrenCount       : integer;
  infantCount         : integer;
  DiscountAmount      : double;
  RentAmount          : double;
  NativeAmount        : double;

  priceID       : integer;
  priceCode     : string ;

  rateTotal     : double;
  rateAvrage    : double;

  discountTotal     : double;
  discountAvrage    : double;

  dayCount      : integer;
  aDate         : TDateTime;

  RateDate      : TdateTime    ;
  rate          : Double;

  IsPercentage  : Boolean ;
  IsPaid        : Boolean ;

  Currency      : string  ;
  CurrencyRate  : Double  ;
  Discount      : Double  ;
  showDiscount  : boolean ;
  found : boolean;

  rateId : String;
      channelId : Integer;
begin
  channelId := 0;
  if edtRatePlans.ItemIndex > 0 then
    channelId := Integer(edtRatePlans.Items.Objects[edtRatePlans.ItemIndex]);
  IsPaid := False;
  lstPrices := TstringList.Create;
  try
    lstPrices.Sorted := true;
    lstPrices.Duplicates := dupIgnore;

    currency      := edCurrency.Text;
    CurrencyRate  := hData.GetRate(currency);
    discount      := edRoomResDiscount.Value;
    showDiscount  := true;
    isPercentage  := cbxIsRoomResDiscountPrec.ItemIndex=0;

    if mRoomRes.locate('roomreservation',roomreservation,[]) then
    begin

      repeat
        found :=  mRoomRates.Locate('roomreservation',roomreservation,[]);
        if found then
        begin
          mRoomRates.Delete;
        end;
      until not found;

      i := oNewReservation.newRoomReservations.FindRoomFromRoomReservation(RoomReservation,0);
      oNewReservation.newRoomReservations.RoomItemsList[i].oRates.RateItemsList.Clear;

      room                := mRoomRes.FieldByName('room').AsString                ;
      arrival             := mRoomRes.FieldByName('arrival').AsDateTime           ;
      departure           := mRoomRes.FieldByName('departure').AsDateTime         ;
      RoomType            := mRoomRes.FieldByName('RoomType').AsString            ;
      RoomTypeDescription := mRoomRes.FieldByName('RoomTypeDescription').AsString ;
      RoomDescription     := mRoomRes.FieldByName('RoomDescription').AsString     ;
      Guests              := mRoomRes.FieldByName('Guests').AsInteger             ;
      ChildrenCount       := mRoomRes.FieldByName('ChildrenCount').AsInteger      ;
      InfantCount         := mRoomRes.FieldByName('infantCount').AsInteger        ;
      discount            := mRoomRes.FieldByName('avrageDiscount').AsFloat             ;

      PriceCode           := trim(edPcCode.text);
      PriceID             := hdata.PriceCode_ID(priceCode);

      dayCount := trunc(departure)-trunc(arrival);
      aDate     := trunc(Arrival);
      rateId := '';
      rateTotal := 0;
      discountTotal := 0;
      lstPrices.Clear;
      for ii := 0  to dayCount-1 do
      begin
        if (newRate <> 0) then
        begin
          rate     := NewRate;
          discount := 0;
        end else
        begin
          if DynamicRates.Active AND
            DynamicRates.findRateForRoomType(trunc(arrival)+ii, RoomType, mRoomRes['Guests'], Rate, rateId) then
          begin
            // Rate acuired
          end else
          begin
            Rate :=  oNewReservation.newRoomReservations.RoomItemsList[i].oRates.GetDayRate
                       (RoomType
                       ,Room
                       ,aDate
                       ,guests
                       ,ChildrenCount
                       ,infantCount
                       ,currency
                       ,PriceID
                       ,discount
                       ,showDiscount
                       ,isPercentage
                       ,isPaid
                       ,false

                        );
          end;
        end;



        DiscountAmount := 0;
        RentAmount := 0;
        NativeAmount := 0;

        if rate <> 0 then
        begin
          if discount <> 0 then
          begin
            if isPercentage then
            begin
              DiscountAmount :=  Rate*discount/100;
            end else
            begin
              DiscountAmount := discount;
            end;
          end;
        end;
        RentAmount  := Rate-DiscountAmount;
        if currencyRate = 0 then currencyRate := 1;
        NativeAmount := RentAmount*CurrencyRate;

        mRoomRates.append;
        mRoomRates.FieldByName('Reservation').AsInteger := -1;
        mRoomRates.FieldByName('RoomReservation').AsInteger := Roomreservation;
        mRoomRates.FieldByName('RoomNumber').AsString := Room;
        mRoomRates.FieldByName('RateDate').AsDateTime := aDate;
        mRoomRates.FieldByName('PriceCode').AsString := PriceCode;
        mRoomRates.FieldByName('Rate').AsFloat := Rate;


        mRoomRates.FieldByName('Discount').AsFloat := Discount;
        mRoomRates.FieldByName('isPercentage').AsBoolean := isPercentage;
        mRoomRates.FieldByName('ShowDiscount').AsBoolean := ShowDiscount;
        mRoomRates.FieldByName('isPaid').AsBoolean := isPaid;
        mRoomRates.FieldByName('DiscountAmount').AsFloat := DiscountAmount;
        mRoomRates.FieldByName('RentAmount').AsFloat := RentAmount;
        mRoomRates.FieldByName('NativeAmount').AsFloat := NativeAmount;
        mRoomRates.FieldByName('Currency').AsString := edCurrency.Text;
        mRoomRates.FieldByName('CurrencyRate').AsFloat := CurrencyRate;
        mRoomRates.post;

        lstPrices.Add(floattostr(RentAmount));
        rateTotal := RateTotal+RentAmount;
        discountTotal := discountTotal+discount;
        aDate := aDate+1
      end;

      rateAvrage := 0;
      discountAvrage := 0;

      if dayCount <> 0 then
      begin
        rateAvrage := rateTotal/dayCount;
        discountAvrage := discountTotal/dayCount
      end;
      rateCount := lstPrices.Count;
      mRoomRes.edit;
        mRoomRes.FieldByName('AvragePrice').AsFloat := rateAvrage;
        mRoomRes.FieldByName('RateCount').AsFloat := rateCount;
        mRoomRes.FieldByName('AvrageDiscount').AsFloat := discountAvrage;
        mRoomRes.FieldByName('isPercentage').AsBoolean := isPercentage;

        mRoomRes.FieldByName('ManualChannelId').AsInteger := channelId;
        mRoomRes.FieldByName('ratePlanCode').AsString := rateId;
      mRoomRes.Post;
    end;
  finally
    freeandNil(lstPrices);
  end;
end;

function TfrmMakeReservationQuick.Apply: boolean;
var
  customer          : string;
  oSelectedRoomItem : TnewRoomReservationItem;
  Room              : string;
  RoomType          : string;
  package           : string;
  Arrival           : TdateTime;
  Departure         : TdateTime;
  GuestCount        : Integer;
  roomReservation   : integer;
  AvragePrice       : double;
  AvrageDiscount    : double;
  isPercentage      : boolean;
  RateCount         : integer;
  ChildrenCount     : integer;
  infantCount       : integer;
  PriceCode         : string;

  rateRoomNumber   : string;
  rateDate         : Tdate;
  rate             : double;
  ratePriceCode    : string;
  rateDiscount     : double;
  rateIsPercentage : boolean;
  rateShowDiscount : boolean;
  rateIsPaid       : boolean;
  rateItem         : TRateItem;
  roomIndex        : integer;
  TotalRoomRate    : double;
  TotalAvrage      : double;
  rateDays         : integer;
  mainGuestName    : string;
  RoomNotes        : string;
begin
  result := true;
  Customer := edCustomer.Text;
  oNewReservation.SendConfirmationEmail := chkSendConfirmation.Enabled AND chkSendConfirmation.Checked;
  oNewReservation.HomeCustomer.Customer := Customer;

  if chkContactIsGuest.checked then
  begin
    if trim(edContactPerson.Text) = '' then
    begin
      oNewReservation.HomeCustomer.GuestName := GetTranslatedText('MainGuestConstant_Version_1');
    end else
    begin
      oNewReservation.HomeCustomer.GuestName := edContactPerson.text;
    end;
  end else
  begin
    oNewReservation.HomeCustomer.GuestName := GetTranslatedText('MainGuestConstant_Version_1');
  end;

  oNewReservation.HomeCustomer.invRefrence            := edinvRefrence.Text;
  oNewReservation.HomeCustomer.Country                := edCountry.text;
  oNewReservation.HomeCustomer.ReservationName        := edReservationName.text;
  oNewReservation.HomeCustomer.RoomStatus             := RoomstatusToInfo(cbxRoomStatus.ItemIndex);
  oNewReservation.HomeCustomer.MarketSegmentCode      := edMarketSegmentCode.text;
  oNewReservation.HomeCustomer.IsGroupInvoice         := chkIsGroupInvoice.checked;
  oNewReservation.HomeCustomer.Currency               := edCurrency.text;
  oNewReservation.HomeCustomer.PcCode                 := edPcCode.text;
  oNewReservation.HomeCustomer.PID                    := edPID.text ;
  oNewReservation.HomeCustomer.CustomerName           := edCustomerName.text ;
  oNewReservation.HomeCustomer.Address1               := edAddress1.text ;
  oNewReservation.HomeCustomer.Address2               := edAddress2.text ;
  oNewReservation.HomeCustomer.Address3               := edAddress3.text ;
  oNewReservation.HomeCustomer.Tel1                   := edTel1.text     ;
  oNewReservation.HomeCustomer.Tel2                   := edTel2.text     ;
  oNewReservation.HomeCustomer.Fax                    := edFax.text      ;
  oNewReservation.HomeCustomer.EmailAddress           := edEmailAddress.text ;
  oNewReservation.HomeCustomer.HomePage               := edHomePage.text     ;
  oNewReservation.HomeCustomer.ContactPhone           := edContactPhone.text ;
  oNewReservation.HomeCustomer.ContactPerson          := edContactPerson.text;
  oNewReservation.HomeCustomer.ContactAddress1        := edContactAddress1.text;
  oNewReservation.HomeCustomer.ContactAddress2        := edContactAddress2.text;
  oNewReservation.HomeCustomer.ContactAddress3        := edContactAddress3.text;
  oNewReservation.HomeCustomer.ContactAddress4        := edContactAddress4.text;
//0810-hj   oNewReservation.HomeCustomer.ContactCountry         := edContactCountry.text   ;
  oNewReservation.HomeCustomer.ContactCountry         := edCountry.text   ;
  oNewReservation.HomeCustomer.PersonProfileId        := edtPortfolio.Tag   ;
  oNewReservation.HomeCustomer.CreatePersonProfileId  := cbxAddToGuestProfiles.Checked;

  oNewReservation.HomeCustomer.ContactFax             := edContactFax.text   ;
  oNewReservation.HomeCustomer.ContactEmail           := edContactEmail.text ;
  oNewReservation.HomeCustomer.ReservationPaymentInfo := memReservationPaymentInfo.text;
  oNewReservation.HomeCustomer.ReservationGeneralInfo := memReservationGeneralInfo.text;
  oNewReservation.HomeCustomer.ShowDiscountOnInvoice  := true;
  oNewReservation.HomeCustomer.isRoomResDiscountPrec  := cbxIsRoomResDiscountPrec.ItemIndex=0;
  oNewReservation.HomeCustomer.RoomResDiscount        := edRoomResDiscount.Value;
  oNewReservation.HomeCustomer.contactIsMainGuest     := chkContactIsGuest.checked;

  oNewReservation.OutOfOrderBlocking := OutOfOrderBlocking;


//  case cbxResMedhod.ItemIndex of
//    0 : oNewReservation.ResMedhod := rmNormal   ;
//    1 : oNewReservation.ResMedhod := rmDateRoom ;
//    2 : oNewReservation.ResMedhod := rmRoom     ;
//  end;
  oNewReservation.ResMedhod := rmNormal   ;

//  _kbmRoomRates.LoadFromDataSet(mRoomrates,[]);
//  _kbmRoomRates.SortFields := 'RoomReservation;RateDate';
//  _kbmRoomRates.sort([]);
//
//  _kbmRoomRates.First;
//  while not _kbmRoomRates.eof do
//  begin
//     showmessage(_kbmRoomRates.fieldbyname('roomreservation').AsString+' '+dateTostr(_kbmRoomRates.fieldbyname('ratedate').AsDateTime));
//    _kbmRoomRates.next;
//  end;
//  mRoomRates.First;
//  while not mRoomRates.eof do
//  begin
//     showmessage(mRoomRates.fieldbyname('roomreservation').AsString+' - '+dateTostr(mRoomRates.fieldbyname('ratedate').AsDateTime));
//    mRoomRates.next;
//  end;
// mRoomrates.LoadFromDataSet(_kbmRoomRates);
//**ATH  mRoomRates  .sort([]);

  mRoomrates.SortedField := 'ratedate';

  memReservationGeneralInfo.Clear;

  oNewReservation.newRoomReservations.RoomItemsList.Clear;
  roomIndex := 0;
  mRoomRes.first;

  while not mRoomRes.eof do
  begin
    Room            := mRoomRes.FieldByName('Room').asString;
    RoomType        := mRoomRes.FieldByName('RoomType').asString;
    Package         := mRoomRes.FieldByName('Package').asString;
    Arrival         := mRoomRes.FieldByName('Arrival').AsDateTime;
    Departure       := mRoomRes.FieldByName('Departure').AsDateTime;
    GuestCount      := mRoomRes.FieldByName('Guests').AsInteger;
    RoomReservation := mRoomRes.FieldByName('RoomReservation').AsInteger;
    if NOT OutOfOrderBlocking then
    begin
      AvragePrice     := glb.GetRateInclusive(-1, ctrlGetString('RoomRentItem'), mRoomRes.FieldByName('AvragePrice').AsFloat)  ;
      if mRoomRes.FieldByName('isPercentage').AsBoolean then
        AvrageDiscount  := mRoomRes.FieldByName('AvrageDiscount').AsFloat
      else
        AvrageDiscount  := glb.GetRateInclusive(-1, ctrlGetString('RoomRentItem'), mRoomRes.FieldByName('AvrageDiscount').AsFloat)  ;
    end else
    begin
      AvragePrice     := 0.00;
      AvrageDiscount  := 0.00;
    end;
    RateCount       := mRoomRes.FieldByName('RateCount').AsInteger;
    ChildrenCount   := mRoomRes.FieldByName('ChildrenCount').AsInteger;
    infantCount     := mRoomRes.FieldByName('infantCount').AsInteger;
    PriceCode       := mRoomRes.FieldByName('PriceCode').AsString;
    isPercentage    := mRoomRes.FieldByName('isPercentage').AsBoolean;
    mainGuestName   := mRoomRes.FieldByName('MainGuest').AsString;
    roomNotes       := mRoomRes.FieldByName('roomNotes').asString;


    if trim(mainGuestName) = '' then
    begin
      if chkContactIsGuest.checked then
      begin
        mainGuestName := edContactPerson.text;
        if trim(mainGuestName) = '' then mainGuestName := GetTranslatedText('MainGuestConstant_Version_1'); // MainGuestConstant_Version_1;;
      end else
      begin
        mainGuestName := GetTranslatedText('MainGuestConstant_Version_1'); // MainGuestConstant_Version_1;
      end;
    end;

    oSelectedRoomItem := TnewRoomReservationItem.Create(RoomReservation,Room,RoomType,package,Arrival,departure,guestCount,AvragePrice,AvrageDiscount,isPercentage,RateCount,ChildrenCount,infantCount,priceCode,mainGuestName,roomNotes);
    oSelectedRoomItem.ManualChannelId := mRoomRes.FieldByName('ManualChannelId').AsInteger;
    oSelectedRoomItem.ratePlanCode    := mRoomRes.FieldByName('ratePlanCode').AsString;

    oNewReservation.newRoomReservations.RoomItemsList.Add(oSelectedRoomItem);
    oNewReservation.newRoomReservations.RoomItemsList[roomIndex].oRates.SetCurrency(edCurrency.text);

//    Þetta virkar ekki á expressmemdata
//    mRoomRates.Filter := '(Roomreservation='+inttostr(roomreservation)+')';
//    mRoomRates.Filtered := true;

    mRoomRates.First;
    while not mRoomRates.eof do
    begin
      //    Þetta er skítamixið
      if mRoomrates.fieldbyname('roomreservation').AsInteger = roomreservation then
      begin
        rateRoomNumber   := mRoomRates.FieldByName('RoomNumber').AsString;
        rateDate         := mRoomRates.FieldByName('RateDate').AsdateTime;
        if NOT OutOfOrderBlocking then
        begin
          rate             := glb.GetRateInclusive(-1, ctrlGetString('RoomRentItem'), mRoomRates.FieldByName('rate').AsFloat);
          if mRoomRates.FieldByName('isPercentage').AsBoolean then
            rateDiscount     := mRoomRates.FieldByName('Discount').AsFloat
          else
            rateDiscount     := glb.GetRateInclusive(-1, ctrlGetString('RoomRentItem'), mRoomRates.FieldByName('Discount').AsFloat) ;
        end else
        begin
          rate             := 0.00;
          rateDiscount     := 0.00;
        end;
        ratePriceCode    := mRoomRates.FieldByName('PriceCode').AsString;
        rateIsPercentage := mRoomRates.FieldByName('isPercentage').AsBoolean;
        rateShowDiscount := mRoomRates.FieldByName('ShowDiscount').AsBoolean;
        rateIsPaid       := mRoomRates.FieldByName('isPaid').AsBoolean;
        rateItem := TRateItem.Create(rate,rateDate,rateDiscount,rateShowDiscount,rateIsPercentage,rateisPaid,ratePriceCode,rateRoomNumber,-1,roomreservation);
        oNewReservation.newRoomReservations.RoomItemsList[roomIndex].oRates.RateItemsList.Add(rateItem);

        oNewReservation.newRoomReservations.RoomItemsList[roomIndex].Breakfast := cbxBreakfast.Checked;
        oNewReservation.newRoomReservations.RoomItemsList[roomIndex].BreakfastIncluded := cbxBreakfastIncl.Checked;
        oNewReservation.newRoomReservations.RoomItemsList[roomIndex].BreakfastCost := StrToFloat(edtBreakfast.Text);
        oNewReservation.newRoomReservations.RoomItemsList[roomIndex].BreakfastCostGroupAccount := cbxBreakfastGrp.Checked;

        oNewReservation.newRoomReservations.RoomItemsList[roomIndex].ExtraBed := cbxExtraBed.Checked;
        oNewReservation.newRoomReservations.RoomItemsList[roomIndex].ExtraBedIncluded := cbxExtraBedIncl.Checked;
        oNewReservation.newRoomReservations.RoomItemsList[roomIndex].ExtraBedCost := StrToFloat(edtExtraBed.Text);
        oNewReservation.newRoomReservations.RoomItemsList[roomIndex].ExtraBedCostGroupAccount := cbxExtraBedGrp.Checked;
      end;

      mRoomRates.Next;
    end;
    inc(roomIndex);
    mRoomRes.next;
  end;
end;


Procedure TfrmMakeReservationQuick.fillCurrencyFromDataset(sGoto : string);
var
  s        : string;
  rSet     : TRoomerDataSet;
  active   : boolean;
  zSortStr : string;
begin
  active := true;
  if zSortStr = '' then zSortStr := 'Currency ';
  rSet := CreateNewDataSet;
  try
		s := format(select_Currencies_fillGridFromDataset_byActive, [ord(active),zSortStr]);
    if rSet_bySQL(rSet,s) then
    begin
      if mCurrency.active then mCurrency.Close;
      mCurrency.LoadFromDataSet(rSet);
      if sGoto = '' then
      begin
        mCurrency.First;
      end else
      begin
        try
          mCurrency.Locate('currency',sGoto,[]);
        except
        end;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;



procedure TfrmMakeReservationQuick.btnClearLogClick(Sender: TObject);
begin
  CopyToClipboard(frmdayNotes.memLog.text);
  frmdayNotes.memLog.Clear;
  frmdayNotes.memLog.Lines.Add('---'+Caption+'-----');
  frmdayNotes.memLog.Lines.Add('');
end;


procedure TfrmMakeReservationQuick.sButton2Click(Sender: TObject);
begin
  frmdayNotes.FormatLog;
end;

procedure TfrmMakeReservationQuick.sButton5Click(Sender: TObject);
begin
  frmdayNotes.memLog.SelStart := 0;
end;



procedure TfrmMakeReservationQuick.sButton6Click(Sender: TObject);
begin
  frmdayNotes.memLog.Perform(EM_LINESCROLL,0,10)
end;

procedure TfrmMakeReservationQuick.sButton7Click(Sender: TObject);
begin
  frmdayNotes.memLog.Perform(EM_LINESCROLL,0,-10)
end;

procedure TfrmMakeReservationQuick.edPackageDblClick(Sender: TObject);
var
  theData : recPackageHolder;
begin
  theData.package := edPackage.text;
  if openPackages(actLookup,theData) then
  begin
    edPackage.text := theData.package;
  end;
end;

procedure TfrmMakeReservationQuick.edPackageExit(Sender: TObject);
begin
  if PackageValidate(edPackage, clabPcCode, labPackageDescription) then
  begin
  end;

end;

//////////////////////////

//-------------------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------------
//  Currency Edit

function TfrmMakeReservationQuick.CurrencyValidate(ed : TsEdit; lab, labName : TsLabel) : boolean;
var
  theData : recCurrencyHolder;
begin
  theData.Currency := trim(ed.Text);
  result := (hdata.GET_currencyHolderByCurrency(theData)) and (theData.Currency <> '');

  if not result then
  begin
    ed.SetFocus;
    labName.Font.Color := clRed;
    labName.Caption := GetTranslatedText('shNotF_star');
  end else
  begin
    labName.Font.Color := clBlack;
    labName.caption := theData.Description+' - Rate '+ floatTostr(theData.Value);
  end;
end;








//=============================================================================================
// Price Code Edit
//=============================================================================================

function TfrmMakeReservationQuick.PriceCodeValidate(ed : TsEdit; lab, labName : TsLabel) : boolean;
var
  sValue : string;
  priceID : integer;
  Currency : string;
begin
  svalue := trim(ed.Text);
  result := PriceCodeExist(sValue);

  priceID := PriceCode_ID(sValue);
  currency := trim(edCurrency.Text);

  if not result then
  begin
    ed.SetFocus;
    labName.Font.Color := clRed;
    labName.Caption := GetTranslatedText('shNotF_star');
  end else
  begin
    labName.Font.Color := clBlack;
    labName.caption := PriceCode_Description(PriceID);
  end;
end;


function TfrmMakeReservationQuick.PackageValidate(ed : TsEdit; lab, labName : TsLabel) : boolean;
var
  sValue : string;
  Package : string;
  Currency : string;
begin
  svalue := trim(ed.Text);
  result := PackageExist(sValue);

  if not result then
  begin
    ed.SetFocus;
    labName.Font.Color := clRed;
    labName.Caption := GetTranslatedText('shNotF_star');
  end else
  begin
    labName.Font.Color := clBlack;
    labName.caption := Package_Description(svalue);
  end;
end;



procedure TfrmMakeReservationQuick.edPcCodePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recPriceCodeHolder;
begin
  theData.pcCode := edPcCode.text;
  if priceCodes(actLookup,theData) then
  begin
    edPcCode.text := theData.pcCode;
  end;
end;


procedure TfrmMakeReservationQuick.edtRatePlansCloseUp(Sender: TObject);
var channelCode,
    chManCode : String;
    arrival,
    departure : TDateTime;
    sql : String;
    channelId : Integer;
begin
  if edtRatePlans.ItemIndex > 0 then
  begin
    channelId := Integer(edtRatePlans.Items.Objects[edtRatePlans.ItemIndex]);
    chManCode := channelManager_GetDefaultCode;
    if glb.LocateSpecificRecordAndGetValue('channels', 'id', channelId, 'channelManagerId', channelCode) then
    begin
      DynamicRates.Prepare(dtArrival.Date, dtDeparture.Date, channelCode, chManCode);
      PopulateRatePlanCombo;
    end;
  end;
  if Assigned(Sender) then
    GetPrices;
end;

procedure TfrmMakeReservationQuick.F1Click(Sender: TObject);
begin

end;

//////////////////////////////////////////////////////////////
///
///

function TfrmMakeReservationQuick.MarketSegmentValidate: boolean;
var
  sValue : string;
begin
  sValue := trim(edMarketSegmentCode.Text);
  result := CustomerTypeExist(sValue);

  if not result then
  begin
    edMarketSegmentCode.SetFocus;
    labMarketSegmentName.Font.Color := clRed;
    labMarketSegmentName.Caption := GetTranslatedText('shNotF_star');
  end else
  begin
    labMarketSegmentName.Font.Color := clBlack;
    labMarketSegmentName.caption  := d.GET_CustomerTypesDescription_byCustomerType(trim(edMarketsegmentCode.Text));
  end;
end;

procedure TfrmMakeReservationQuick.edMarketSegmentCodePropertiesChange(Sender: TObject);
begin
end;




//******************************************************************************
//   Page Reservation Edits
//******************************************************************************

procedure TfrmMakeReservationQuick.dtArrivalChange(Sender: TObject);
var
   s : string;
begin
  datetimetostring(s,'dddd',dtArrival.Date);
  __lblArrivalWeekday.Caption := s;
end;

procedure TfrmMakeReservationQuick.dtArrivalCloseUp(Sender: TObject);
begin
  if dtDeparture.Date <= dtArrival.Date  then dtDeparture.Date := dtArrival.Date +1;
  if dtArrival.Date >= dtDeparture.Date  then dtArrival.Date := dtDeparture.Date -1;
  zNights :=  trunc(dtDeparture.Date)-trunc(dtArrival.Date);
  edNights.Value := zNights;
end;

procedure TfrmMakeReservationQuick.dtArrivalExit(Sender: TObject);
begin
  if dtDeparture.Date <= dtArrival.Date  then dtDeparture.Date := dtArrival.Date +1;
  if dtArrival.Date >= dtDeparture.Date  then dtArrival.Date := dtDeparture.Date -1;
  zNights :=  trunc(dtDeparture.Date)-trunc(dtArrival.Date);
  edNights.Value := zNights;
end;

//////////////

procedure TfrmMakeReservationQuick.dtDepartureChange(Sender: TObject);
var
   s : string;
begin
  datetimetostring(s,'dddd',dtDeparture.Date);
  __lblDepartureWeekday.Caption := s;
end;

procedure TfrmMakeReservationQuick.edNightsChange(Sender: TObject);
begin
  ZNights := edNights.Value;
  dtDeparture.Date := dtArrival.Date + zNights;
end;


//////////////////////////////////////
// edCustomerKey

function TfrmMakeReservationQuick.customerValidate : boolean;
var
  sCustomer : string;
begin
  sCustomer := trim(edCustomer.Text);
  result :=  glb.CustomersSet.Locate('customer',scustomer,[]);

  if not result then
  begin
    edCustomer.SetFocus;
    labCustomerName.Font.Color := clRed;
    labCustomerName.Caption := GetTranslatedText('shNotF_star');
  end else
  begin
    labCustomerName.Font.Color := clBlack;
  end;
end;


procedure TfrmMakeReservationQuick.edCustomerChange(Sender: TObject);
begin
  if customerValidate then
  begin
    zCustomerChanged := true;
    initCustomer;
  end;
end;

procedure TfrmMakeReservationQuick.edCustomerDblClick(Sender: TObject);
var
  s : string;
  theData : recCustomerHolder;
begin
 theData.Customer := trim(edCustomer.text);
 if OpenCustomers(actLookup, true, theData) then
 begin
   s := theData.Customer;
   if (s <> '') and (s <> trim(edCustomer.text)) then
   begin
     edCustomer.text := s;
   end;
 end;
end;

procedure TfrmMakeReservationQuick.edCustomerExit(Sender: TObject);
begin
   if customerValidate then
   begin
   end;
end;

procedure TfrmMakeReservationQuick.edCustomerKeyPress(Sender: TObject; var Key: Char);
begin
//  if key = chr(13) then
//  begin
//     if customerValidate then
//     begin
//     end;
//  end;
end;

procedure TfrmMakeReservationQuick.edCustomerKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key =vk_f2 then
  begin
    edCustomerDblClick(self);
  end;
end;

//////////////////////////////
// edMarketSegmentCode

procedure TfrmMakeReservationQuick.edMarketSegmentCodeChange(Sender: TObject);
begin
  if MarketSegmentValidate then
  begin
  end;
end;

procedure TfrmMakeReservationQuick.edMarketSegmentCodeDblClick(Sender: TObject);
var
  theData : recCustomerTypeHolder;
begin
  theData.customerType := edMarketSegmentCode.text;
  if openCustomerTypes(actLookup, theData) then
  begin
    edMarketSegmentCode.text := theData.customerType;
    if MarketSegmentValidate then
    begin
    end;
  end;
end;

procedure TfrmMakeReservationQuick.edMarketSegmentCodeExit(Sender: TObject);
begin
  if MarketSegmentValidate then
  begin
  end;
end;

procedure TfrmMakeReservationQuick.edMarketSegmentCodeKeyPress(Sender: TObject; var Key: Char);
begin
//  if key = chr(13) then
//  begin
//    if MarketSegmentValidate then
//    begin
//    end;
//  end;
end;

procedure TfrmMakeReservationQuick.edMarketSegmentCodeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key =vk_f2 then
  begin
    edMarketSegmentCodeDblClick(self);
  end;
end;


//////////////////////////////
// edCountry

procedure TfrmMakeReservationQuick.edContactCountryChange(Sender: TObject);
begin
//0810-hj
//  if glb.LocateCountry(edContactCountry.text) then
//    lbContactCountryName.caption  := glb.Countries['CountryName'] // GET_CountryName(sValue);
//  else lbContactCountryName.caption  := GetTranslatedText('shNotF_star');
end;

procedure TfrmMakeReservationQuick.edContactCountryDblClick(Sender: TObject);
var
  theData : recCountryHolder;
begin
//0810-hj
//  theData.Country := edContactCountry.Text;
//  if Countries(actLookup,theData) then
//  begin
//    edContactCountry.text := theData.Country;
//    lbContactCountryName.caption := theData.CountryName;
//  end;
end;

procedure TfrmMakeReservationQuick.edContactCountryKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
//0810-hj
//  if key =vk_f2 then
//  begin
//    edContactCountryDblClick(self);
//  end;
end;

procedure TfrmMakeReservationQuick.edContactEmailChange(Sender: TObject);
begin
  chkSendConfirmation.Enabled := Length(Trim(edContactEmail.Text)) > 4;
end;



procedure TfrmMakeReservationQuick.edContactPersonCloseUp(Sender: TObject);
var Key : String;
begin
  if edContactPerson.Items.IndexOf(edContactPerson.Text) >= 0 then
  begin
    Key := TRoomerFilterItem(edContactPerson.Items.Objects[edContactPerson.ItemIndex]).Key; // edContactPerson.FKeys[idx];
    if glb.LocateSpecificRecord(glb.PreviousGuestsSet, 'ID', Key) then
    begin
      postMessage(handle, WM_SET_COMBO_TEXT, 1, 0);
    end else
    if glb.LocateSpecificRecord(glb.PersonProfiles, 'ID', Key) then
    begin
      if chkContactIsGuest.Checked then
      begin
        edtPortfolio.Text := Trim(glb.PersonProfiles['FirstName'] + ' ' + glb.PersonProfiles['LastName']);
        edtPortfolio.Tag := StrToInt(Key);
      end;
      postMessage(handle, WM_SET_COMBO_TEXT, 2, 0);
    end;
  end;
end;

procedure TfrmMakeReservationQuick.edContactPersonEnter(Sender: TObject);
begin
  lblNew.Visible := edContactPerson.Active;
end;

procedure TfrmMakeReservationQuick.edContactPersonExit(Sender: TObject);
begin
  lblNew.Visible := False;
end;

procedure TfrmMakeReservationQuick.edContactPersonKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var sTemp : String;
begin
  if (Key IN [VK_F2]) then
  begin
    edContactPerson.OnCloseUp := NIL;
    sTemp := edContactPerson.Text;
    edContactPerson.Stop;
    cbxAddToGuestProfiles.Visible := True;
    edContactPerson.DroppedDown := False;
    edContactPerson.Text := sTemp;
    edContactPerson.SelLength := 0;
    edContactPerson.SelStart := length(sTemp);
    lblNew.Visible := edContactPerson.Active;
  end;
//  if (Key IN [VK_RETURN, VK_TAB]) then
//  begin
//    if (edContactPerson.Items.IndexOf(edContactPerson.Text) >= 0) then
//    begin
////      edContactPersonCloseUp(edContactPerson);
//    end else
//    begin
//      timNew.Enabled := True;
//      ActiveControl := edContactAddress1;
//    end;
//    Key := #0;
//  end;

end;

procedure TfrmMakeReservationQuick.edCountryChange(Sender: TObject);
begin
  if glb.LocateCountry(edCountry.text) then
    labCountryName.caption  := glb.Countries['CountryName'] // GET_CountryName(sValue);
      else labCountryName.caption  := GetTranslatedText('shNotF_star');
end;


procedure TfrmMakeReservationQuick.edCountryDblClick(Sender: TObject);
var
  theData : recCountryHolder;
begin
  theData.Country := edCountry.Text;
  if Countries(actLookup,theData) then
  begin
    edCountry.text := theData.Country;
    labCountryName.caption := theData.CountryName;
  end;
end;

procedure TfrmMakeReservationQuick.edCountryExit(Sender: TObject);
begin
  if CountryValidate then
  begin
  end;
end;

procedure TfrmMakeReservationQuick.edCountryKeyPress(Sender: TObject; var Key: Char);
begin
//  if CountryValidate then
//  begin
//  end;
end;

procedure TfrmMakeReservationQuick.edCountryKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key =vk_f2 then
  begin
    edCountryDblClick(self);
  end;
end;

//////////////////////////////////
// edCurrency

procedure TfrmMakeReservationQuick.edCurrencyChange(Sender: TObject);
var
  index : integer;
begin
  if CurrencyValidate(edCurrency,clabCurrency,labCurrencyName) then
  begin
    index := cbxIsRoomResDiscountPrec.ItemIndex;
    cbxIsRoomResDiscountPrec.Items.Clear;
    cbxIsRoomResDiscountPrec.Items.Add('%');
    cbxIsRoomResDiscountPrec.Items.Add(edCurrency.text);
    cbxIsRoomResDiscountPrec.itemIndex := index;

    if index = 0 then edRoomResDiscount.MaxValue := 100
      else edRoomResDiscount.MaxValue := 99999999;

    labCurrencyRate.Caption := floattostr(GetRate(edCurrency.text));
  end;
end;

procedure TfrmMakeReservationQuick.edCurrencyDblClick(Sender: TObject);
var
  theData : recCurrencyHolder;
begin
  theData.Currency := trim(edCurrency.text);
  if Currencies(actLookup,theData) then
  begin
    edCurrency.text := theData.Currency;
    labCurrencyRate.Caption := floattostr(GetRate(edCurrency.text));
    lblExtraBedCurrency.Caption := edCurrency.Text;

  end;
end;

procedure TfrmMakeReservationQuick.edCurrencyExit(Sender: TObject);
begin
  if CurrencyValidate(edCurrency,clabCurrency,labCurrencyName) then
  begin
  end;
end;

procedure TfrmMakeReservationQuick.edCurrencyKeyPress(Sender: TObject; var Key: Char);
begin
//  if CurrencyValidate(edCurrency,clabCurrency,labCurrencyName) then
//  begin
//  end;
end;

procedure TfrmMakeReservationQuick.edCurrencyKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key =vk_f2 then
  begin
    edCurrencyDblClick(self);
  end;
end;

///////////////////////////
// edPcCode

procedure TfrmMakeReservationQuick.edPcCodeChange(Sender: TObject);
begin
  if PriceCodeValidate(edPcCode, clabPcCode, labPcCodeName) then
  begin
  end;
end;

procedure TfrmMakeReservationQuick.edPcCodeDblClick(Sender: TObject);
var
  theData : recPriceCodeHolder;
begin
  theData.pcCode := edPcCode.text;
  if priceCodes(actLookup,theData) then
  begin
    edPcCode.text := theData.pcCode;
  end;
end;

procedure TfrmMakeReservationQuick.edPcCodeExit(Sender: TObject);
begin
  if PriceCodeValidate(edPcCode, clabPcCode, labPcCodeName) then
  begin
  end;
end;

procedure TfrmMakeReservationQuick.edPcCodeKeyPress(Sender: TObject; var Key: Char);
begin
//  if key = chr(13) then
//  begin
//    if PriceCodeValidate(edPcCode, clabPcCode, labPcCodeName) then
//    begin
//    end;
//  end;
end;

procedure TfrmMakeReservationQuick.edPcCodeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key =vk_f2 then
  begin
    edPcCodeDblClick(self);
  end;
end;

///////////////////////////////
//

procedure TfrmMakeReservationQuick.cbxBreakfastClick(Sender: TObject);
begin
  ShowhideExtraInputs;
end;

procedure TfrmMakeReservationQuick.cbxIsRoomResDiscountPrecChange(Sender: TObject);
begin
  if cbxIsRoomResDiscountPrec.ItemIndex = 0 then
  begin
     edRoomResDiscount.MaxValue := 100
  end else
  begin
   edRoomResDiscount.MaxValue := 99999999;
  end;
end;



procedure TfrmMakeReservationQuick.cbxRoomStatusCloseUp(Sender: TObject);
begin
  OutOfOrderBlocking := cbxRoomStatus.ItemIndex = 7;
end;

procedure TfrmMakeReservationQuick.chkisGroupInvoiceClick(Sender: TObject);
begin
  // tvRoomResPackage.Options.Editing := not chkisGroupInvoice.Checked;
end;

end.




