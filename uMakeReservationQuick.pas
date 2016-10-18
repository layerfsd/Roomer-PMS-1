unit uMakeReservationQuick;

interface

uses
  Windows,
  Messages,
  system.SysUtils,
  system.Variants,
  system.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Menus,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Vcl.Mask,
  Vcl.ComCtrls,
  hData,
  Data.DB,
  Data.Win.ADODB,
  objNewReservation,
  objHomeCustomer,
  cxPCdxBarPopupMenu,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  dxCore,
  cxDateUtils,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxNavigator,
  cxDBData,
  cxTextEdit,
  cxButtonEdit,
  cxSpinEdit,
  cxCalc,
  dxmdaset,
  cxButtons,
  cxGridLevel,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxClasses,
  cxGridCustomView,
  cxGrid,
  cxDropDownEdit,
  cxCalendar,
  cxCheckBox,
  cxMaskEdit,
  cxLabel,
  cxGroupBox,
  cxPC,
  cxGridBandedTableView,
  cxGridDBBandedTableView,
  cxPropertiesStore,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBLookupComboBox,
  cmpRoomerDataSet,
  cmpRoomerConnection,
  objRoomRates,
  kbmMemTable,
  uUtils,
  uAlerts,
  uAlertEditPanel,
  sPanel,
  sSkinProvider,
  sGroupBox,
  sLabel,
  sCheckBox,
  sButton,
  sPageControl,
  sEdit,
  sSpinEdit,
  sBevel,
  dxSkinsCore,
  dxSkinDarkSide,
  dxSkinDevExpressDarkStyle,
  dxSkinMcSkin,
  dxSkinOffice2013White,
  dxSkinsDefaultPainters,
  dxSkinscxPCPainter,
  sMemo,
  sMaskEdit,
  sCustomComboEdit,
  sTooledit,
  sComboBox,
  sSpeedButton,
  uDImages,
  Vcl.DBCtrls,
  cxCurrencyEdit,
  dxSkinCaramel,
  dxSkinCoffee,
  dxSkinTheAsphaltWorld,
  dxSkinBlack,
  dxSkinBlue,
  dxSkinBlueprint,
  dxSkinDarkRoom,
  dxSkinDevExpressStyle,
  dxSkinFoggy,
  dxSkinGlassOceans,
  dxSkinHighContrast,
  dxSkiniMaginary,
  dxSkinLilian,
  dxSkinLiquidSky,
  dxSkinLondonLiquidSky,
  dxSkinMoneyTwins,
  dxSkinOffice2007Black,
  dxSkinOffice2007Blue,
  dxSkinOffice2007Green,
  dxSkinOffice2007Pink,
  dxSkinOffice2007Silver,
  dxSkinOffice2010Black,
  dxSkinOffice2010Blue,
  dxSkinOffice2010Silver,
  dxSkinPumpkin,
  dxSkinSeven,
  dxSkinSevenClassic,
  dxSkinSharp,
  dxSkinSharpPlus,
  dxSkinSilver,
  dxSkinSpringTime,
  dxSkinStardust,
  dxSkinSummer2008,
  dxSkinValentine,
  dxSkinVS2010,
  dxSkinWhiteprint,
  dxSkinXmas2008Blue,
  uRoomerFilterComboBox,
  system.Generics.Collections,
  uDynamicRates,
  sListView,
  cxTimeEdit, AdvSplitter
    ;

TYPE
  recRoomRate = record
    Reservation: integer;
    RoomReservation: integer;
    RoomNumber: string;
    RateDate: integer;
    PriceCode: string;
    Rate: double;
    Discount: double;
    isPrecentage: boolean;
    ShowDiscount: boolean;
    isPaid: boolean;
    DiscountAmount: double;
    RentAmount: double;
    NativeAmount: double;
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
    DELETE_kbmRoomRes: TkbmMemTable;
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
    DELETE_kbmRoomRates: TkbmMemTable;
    mRoomRatesDS: TDataSource;
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
    gbxProfileAlert: TsGroupBox;
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
    mCurrencyDS: TDataSource;
    sPanel7: TsPanel;
    cxButton1: TsButton;
    sLabel9: TsLabel;
    edInvRefrence: TsEdit;
    sButton3: TsButton;
    sButton4: TsButton;
    tvRoomResMainGuest: TcxGridDBColumn;
    DELETE_kbmRoomRatesTmp: TkbmMemTable;
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
    edtSpecialRequests: TMemo;
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
    mROomResPersonsProfilesID: TIntegerField;
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
    mRoomResMainGuest: TWideStringfield;
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
    __tvRoomResColumn2: TcxGridDBColumn;
    AdvSplitter1: TAdvSplitter;
    gbxCustomerAlert: TsGroupBox;
    memCustomerAlert: TMemo;
    lblSpecialRequests: TsLabel;
    lblNotes: TsLabel;
    edtNotes: TMemo;
    gbxRoomAlert: TsGroupBox;
    lblRoomType: TsLabel;
    lblRoom: TsLabel;
    edtRoom: TsEdit;
    edtRoomType: TsEdit;
    tvRoomResExpectedTimeOfArrival: TcxGridDBColumn;
    tvRoomResexpectedCheckouttime: TcxGridDBColumn;
    mRoomResExpectedTimeOfArrival: TStringField;
    mRoomResExpectedCheckOutTime: TStringField;
    cbxMarket: TsComboBox;
    lblMarket: TsLabel;
    mRoomResStockItemsCount: TIntegerField;
    tvRoomResStockItemsCount: TcxGridDBColumn;
    mRoomResStockitemsPrice: TFloatField;
    tvRoomResStockitemsPrice: TcxGridDBColumn;
    mExtras: TdxMemData;
    mExtrasRoomreservation: TIntegerField;
    mExtrasItemid: TIntegerField;
    mExtrasCount: TIntegerField;
    mExtrasPricePerItemPerDay: TFloatField;
    mExtrasFromdate: TDateTimeField;
    mExtrasToDate: TDateTimeField;
    mExtrasItem: TStringField;
    mExtrasDescription: TStringField;
    mExtrasTotalPrice: TFloatField;
    m_nrWaitingListNonOptional: TIntegerField;
    m_occWaitingListNonOptional: TIntegerField;
    chkExcludeWaitingListNonOptional: TsCheckBox;
    cbxFilterSelectedTypes: TsCheckBox;
    procedure FormShow(Sender: TObject);
    procedure edCustomerDblClick(Sender: TObject);
    procedure edCustomerPropertiesEditValueChanged(Sender: TObject);
    procedure edCustomerExit(Sender: TObject);
    procedure btnFinishClick(Sender: TObject);
    procedure edCountryDblClick(Sender: TObject);
    procedure edMarketSegmentCodeDblClick(Sender: TObject);
    procedure edCurrencyDblClick(Sender: TObject);
    procedure edPcCodePropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
    procedure edPcCodeDblClick(Sender: TObject);
    procedure edPcCodeExit(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPreviusClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pgcMainChange(Sender: TObject);
    procedure btdEditRoomRateClick(Sender: TObject);
    procedure tvRoomResColumn1PropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
    procedure btnEditRateAllRoomsClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure mSelectRoomsNewRecord(DataSet: TDataSet);
    procedure tvSelectRoomsRoomPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
    procedure tvSelectTypeSelectedPropertiesEditValueChanged(Sender: TObject);
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
    procedure btnSetAllAsNoRoomClick(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure tvSelectTypeSelectedPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: boolean);
    procedure tvSelectTypeNoRoomsPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: boolean);
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
    procedure cbxIsRoomResDiscountPrecChange(Sender: TObject);
    procedure mnuFinishAndShowClick(Sender: TObject);
    procedure edCustomerKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edMarketSegmentCodeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edCountryKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edCurrencyKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edPcCodeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edPackageDblClick(Sender: TObject);
    procedure edPackageExit(Sender: TObject);
    procedure tvRoomResPackagePropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
    procedure cbxRoomStatusCloseUp(Sender: TObject);
    procedure edContactEmailChange(Sender: TObject);
    procedure btnPortfolioClick(Sender: TObject);
    procedure btnPortfolioLookupClick(Sender: TObject);
    procedure edContactPersonCloseUp(Sender: TObject);
    procedure edContactPersonKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tvRoomResMainGuestPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
    procedure timNewTimer(Sender: TObject);
    procedure edContactPersonEnter(Sender: TObject);
    procedure edContactPersonExit(Sender: TObject);
    procedure cbxBreakfastClick(Sender: TObject);
    procedure lblExtraBedCurrencyClick(Sender: TObject);
    procedure edtRatePlansCloseUp(Sender: TObject);
    procedure tvRoomResRatePlanCodePropertiesCloseUp(Sender: TObject);
    procedure tvRoomResRatePlanCodePropertiesEditValueChanged(Sender: TObject);
    procedure tvSelectTypeNoRoomsPropertiesChange(Sender: TObject);
    procedure tvSelectTypeNoRoomsStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure __tvRoomResColumn2PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure GetLocaTimeEditProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure FormatTextToShortFormat(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure tvRoomResStockItemsCountPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure mExtrasCalcFields(DataSet: TDataSet);
    procedure mRoomResDSDataChange(Sender: TObject; Field: TField);
    procedure cbxFilterSelectedTypesClick(Sender: TObject);
    procedure mSelectRoomsFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure edPcCodeChange(Sender: TObject);
    procedure edPackageChange(Sender: TObject);
  private
    { Private declarations }
    zCustomerChanged: boolean;
    zIsFirstTime: boolean;

    FrmAlertPanel: TFrmAlertPanel;

    zRtInRoom: integer;
    zRtNoRoom: integer;
    zRtTotal: integer;

    zTotalSelected: integer; // 0
    zTotalRoomsSelected: integer; // 4
    zTotalAvailable: integer; // 3
    zTotalFree: integer; // 2
    zTotalNoRooms: integer; // 1

    zTotal: integer;

    zNights: integer;
    FOutOfOrderBlocking: boolean;

    FDynamicRates: TDynamicRates;

    FNewReservation: TNewReservation;

    procedure initCustomer;
    function RoomStatusFromInfo(statusText: string): integer;
    function RoomStatusToInfo(Index: integer): string;
    ///<summary> Create the roomlist in NewReservation object and set all properties from UI and local memtables </summary>
    function Apply: boolean;
    procedure addAvailableRoomTypes;
    procedure SetAllAsNoRoom(doNextPage: boolean = true);

    function customerValidate: boolean;
    function CountryValidate: boolean;
    function MarketSegmentValidate: boolean;
    function CurrencyValidate(ed: TsEdit; lab, labName: TsLabel): boolean;
    function PriceCodeValidate(ed: TsEdit; lab, labName: TsLabel): boolean;
    function PackageValidate(ed: TsEdit; lab, labName: TsLabel): boolean;

    procedure ApplyRateToOther(RoomReservation: integer; RoomType: string);
    procedure ApplyNettoRateToNullPrice(NewRate: double; RoomReservation: integer; RoomType: string);

    procedure getSelectRooms;
    procedure InitSelectRooms;

    function CreateRoomRes_Quick: boolean;
    procedure CreateRoomRes_Normal;

    procedure EditRoomRateOneRoom(RoomRes: integer);
    procedure GetPrices;

    function doAutoSelect(RoomType: string; NumRooms: integer; PriorityRule: string): integer;
    function CalcOnePrice(RoomReservation: integer; NewRate: double = 0): boolean;

    procedure SetOutOfOrderBlocking(const Value: boolean);
    procedure FillQuickFind;
    procedure ShowhideExtraInputs;
    procedure ShowRatePlans;
    procedure PopulateRatePlanCombo(clearAll : Boolean = True);
    function SetOnePrice(RoomReservation: Integer; rateId: String; channelId: Integer): boolean;
    procedure SetProfileAlertVisibility;
    procedure SetRoomFilterOnlySelectedTypes(aOnlySelected: boolean);
    property OutOfOrderBlocking : Boolean read FOutOfOrderBlocking write SetOutOfOrderBlocking;

  public
    { Public declarations }
    procedure WndProc(var message: TMessage); override;
    property NewReservation: TNewReservation read FNewReservation write FNewReservation;
  end;

var
  frmMakeReservationQuick: TfrmMakeReservationQuick;

implementation

uses
  UITypes,
  ug,
  ud,
  uSqlDefinitions,
  _Glob,
  PrjConst,
  uMain,
  uCurrencies,
  uPriceCodes,
  uCountries,
  ueditRoomPrice,
  uCustomers2,
  uCustomerTypes2,
  objDayFreeRooms,
  uAppGlobal,
  uDayNotes,
  uPackages,
  uGuestProfiles,
  uRoomerDefinitions,
  uReservationStateDefinitions,
  uDateUtils,
  uAvailabilityPerDay,
  uViewDailyRates
 , ufrmReservationExtras
 , DateUtils
 ;

{$R *.dfm}


const
  WM_SET_COMBO_TEXT = WM_User + 101;
  WM_SET_EMPTY_TEXT = WM_User + 102;

function TfrmMakeReservationQuick.RoomStatusFromInfo(statusText: string): integer;
begin
  Result := 0;
  if statusText = 'P' then
    Result := 0;
  if statusText = 'G' then
    Result := 1;
  if statusText = 'A' then
    Result := 2;
  if statusText = 'O' then
    Result := 3;
  if statusText = 'N' then
    Result := 4;
  if statusText = 'D' then
    Result := 5;
  if statusText = 'B' then
    Result := 6;
  if statusText = 'L' then
    Result := 8;
end;

function TfrmMakeReservationQuick.RoomStatusToInfo(Index: integer): string;
begin
  Result := '';
  if Index = 0 then
    Result := 'P';
  if Index = 1 then
    Result := 'G';
  if Index = 2 then
    Result := 'A';
  if Index = 3 then
    Result := 'O';
  if Index = 4 then
    Result := 'N';
  if Index = 5 then
    Result := 'D';
  if Index = 6 then
    Result := 'B';
  if Index = 8 then
    Result := 'L';
  if Index = 7 then
    Result := 'B';
end;

procedure TfrmMakeReservationQuick.sButton3Click(Sender: TObject);
begin
  ApplyRateToOther(mRoomResroomreservation.AsInteger, '');
end;

procedure TfrmMakeReservationQuick.sButton4Click(Sender: TObject);
begin
  ApplyRateToOther(mRoomResroomreservation.AsInteger, mRoomResRoomType.AsString);
end;

procedure TfrmMakeReservationQuick.ApplyRateToOther(RoomReservation: integer; RoomType: string);
var
  RateDate: TDateTime;
  PriceCode: string;
  Rate: double;
  Discount: double;
  isPercentage: boolean;
  ShowDiscount: boolean;
  isPaid: boolean;
  DiscountAmount: double;
  RentAmount: double;
  NativeAmount: double;

  Arrival: TDateTime;
  Departure: TDateTime;
  AvragePrice: double;
  RateCount: integer;
  AvrageDiscount: double;
  room: string;

  found: boolean;
  currentRoomReservation: integer;
  ManualChannelId: integer;
  ratePlanCode: String;

begin
  Arrival := mRoomRes.FieldByName('Arrival').AsDateTime;
  Departure := mRoomRes.FieldByName('Departure').AsDateTime;
  AvragePrice := mRoomRes.FieldByName('AvragePrice').AsFloat;
  RateCount := mRoomRes.FieldByName('RateCount').AsInteger;
  PriceCode := mRoomRes.FieldByName('PriceCode').AsString;
  AvrageDiscount := mRoomRes.FieldByName('AvrageDiscount').AsFloat;
  isPercentage := mRoomRes.FieldByName('isPercentage').AsBoolean;
  ManualChannelId := mRoomRes.FieldByName('ManualChannelId').AsInteger;
  ratePlanCode := mRoomRes.FieldByName('ratePlanCode').AsString;

  if mRoomRatesTmp.active then
    mRoomRatesTmp.Close;
  mRoomRatesTmp.Open;
  mRoomRatesTmp.LoadFromDataSet(mRoomRates);

  mRoomRatesTmp.Filter := '(Roomreservation=' + inttostr(RoomReservation) + ')';
  mRoomRatesTmp.Filtered := true;

  // apply to same roomtype
  mRoomRates.DisableControls;
  mRoomRes.DisableControls;
  try
    mRoomRes.First;
    while not mRoomRes.eof do
    begin
      if RoomType <> '' then
      begin
        if (mRoomRes.FieldByName('RoomType').AsString <> RoomType) then
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
          found := mRoomRates.Locate('roomreservation', currentRoomReservation, []);
          if found then
          begin
            mRoomRates.Delete;
          end;
        until not found;
        mRoomRatesTmp.First;
        while not mRoomRatesTmp.eof do
        begin
          RateDate := mRoomRatesTmp.FieldByName('RateDate').AsDateTime;
          room := mRoomRatesTmp.FieldByName('RoomNumber').AsString;
          PriceCode := mRoomRatesTmp.FieldByName('PriceCode').AsString;
          Rate := mRoomRatesTmp.FieldByName('Rate').AsFloat;
          Discount := mRoomRatesTmp.FieldByName('Discount').AsFloat;
          isPercentage := mRoomRatesTmp.FieldByName('isPercentage').AsBoolean;
          ShowDiscount := mRoomRatesTmp.FieldByName('ShowDiscount').AsBoolean;
          isPaid := mRoomRatesTmp.FieldByName('isPaid').AsBoolean;
          DiscountAmount := mRoomRatesTmp.FieldByName('DiscountAmount').AsFloat;
          RentAmount := mRoomRatesTmp.FieldByName('RentAmount').AsFloat;
          NativeAmount := mRoomRatesTmp.FieldByName('NativeAmount').AsFloat;

          mRoomRates.append;
          mRoomRates.FieldByName('Reservation').AsInteger := -1;
          mRoomRates.FieldByName('RoomReservation').AsInteger := currentRoomReservation;
          mRoomRates.FieldByName('RoomNumber').AsString := room;
          mRoomRates.FieldByName('RateDate').AsDateTime := RateDate;
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
          mRoomRates.FieldByName('CurrencyRate').AsFloat := mRoomRatesTmp.FieldByName('CurrencyRate').AsFloat;
          mRoomRates.post;
          mRoomRatesTmp.next;
        end;

        mRoomRes.edit;
        mRoomRes.FieldByName('AvragePrice').AsFloat := AvragePrice;
        mRoomRes.FieldByName('RateCount').AsInteger := RateCount;
        mRoomRes.FieldByName('PriceCode').AsString := PriceCode;
        mRoomRes.FieldByName('AvrageDiscount').AsFloat := AvrageDiscount;
        mRoomRes.FieldByName('isPercentage').AsBoolean := isPercentage;
        mRoomRes.FieldByName('ManualChannelId').AsInteger := ManualChannelId;
        mRoomRes.FieldByName('ratePlanCode').AsString := ratePlanCode;
        mRoomRes.post;
      end;
      mRoomRes.next;
    end;
    mRoomRes.Locate('roomReservation', RoomReservation, []);
  finally
    mRoomRates.EnableControls;
    mRoomRes.EnableControls;
  end;
end;

procedure TfrmMakeReservationQuick.ApplyNettoRateToNullPrice(NewRate: double; RoomReservation: integer;
  RoomType: string);
var
  currentRoomReservation: integer;
begin
  mRoomRates.DisableControls;
  mRoomRes.DisableControls;
  try
    mRoomRes.First;
    while not mRoomRes.eof do
    begin
      if RoomType <> '' then
      begin
        if (mRoomRes.FieldByName('RoomType').AsString <> RoomType) then
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
        if mRoomRes.FieldByName('AvragePrice').AsFloat = 0 then
        begin
          CalcOnePrice(currentRoomReservation, NewRate);
        end;
      end;
      mRoomRes.next;
    end;
    mRoomRes.Locate('roomReservation', RoomReservation, []);
  finally
    mRoomRates.EnableControls;
    mRoomRes.EnableControls;
  end;
end;

procedure TfrmMakeReservationQuick.WndProc(var message: TMessage);
var
  s: String;
begin
  inherited;
  if message.Msg = WM_SET_EMPTY_TEXT then
  begin
    edContactAddress1.Text := '';
    edContactAddress2.Text := '';
    edContactAddress3.Text := '';
    edContactAddress4.Text := '';
    // 0810-hj    edContactCountry.Text := ctrlGetString('Country');
    edContactPhone.Text := '';
    edContactFax.Text := '';
    edContactEmail.Text := '';

    cbxAddToGuestProfiles.Visible := true;
    edtPortfolio.Tag := 0;
  end
  else
    if message.Msg = WM_SET_COMBO_TEXT then
  begin
    if message.WParam = 1 then
    begin
      edContactPerson.Text := glb.PreviousGuestsSet['Name'];
      edContactAddress1.Text := glb.PreviousGuestsSet['Address1'];
      edContactAddress2.Text := glb.PreviousGuestsSet['Address2'];
      edContactAddress3.Text := glb.PreviousGuestsSet['Address3'];
      edContactAddress4.Text := glb.PreviousGuestsSet['Address4'];
      edCountry.Text := glb.PersonProfiles['Country'];
      s := glb.PreviousGuestsSet['Tel1'];
      if s = '' then
        s := glb.PreviousGuestsSet['Tel2'];
      edContactPhone.Text := s;
      edContactFax.Text := ''; // glb.PreviousGuestsSet['TelFax'];
      edContactEmail.Text := glb.PreviousGuestsSet['Email'];
    end
    else
    begin
      edContactPerson.Text := Trim(glb.PersonProfiles['Firstname'] + ' ' + glb.PersonProfiles['Lastname']);
      edContactAddress1.Text := glb.PersonProfiles['Address1'];
      edContactAddress2.Text := glb.PersonProfiles['Address2'];
      edContactAddress3.Text := glb.PersonProfiles['Zip'];
      edContactAddress4.Text := glb.PersonProfiles['City'];
      edCountry.Text := glb.PersonProfiles['Country'];
      s := glb.PersonProfiles['TelMobile'];
      if s = '' then
        s := glb.PersonProfiles['TelLandLine'];
      edContactPhone.Text := s;
      edContactFax.Text := glb.PersonProfiles['TelFax'];
      edContactEmail.Text := glb.PersonProfiles['Email'];

      edtSpecialRequests.Text := glb.PersonProfiles['Preparation'];
      edtNotes.Text := glb.PersonProfiles['Information'];
      edtRoom.Text := glb.PersonProfiles['Room'];
      edtRoomType.Text := glb.PersonProfiles['RoomType'];

      SetProfileAlertVisibility;
    end;
  end;
end;

procedure TfrmMakeReservationQuick.__tvRoomResColumn2PropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
var
  _FrmViewDailyRates: TFrmViewDailyRates;
  ADate,
    Arrival,
    Departure: TDate;
  ii,
    Guests,
    dayCount, RoomReservation: integer;
  Rate: double;
  rateId: String;
begin
  if AButtonIndex = 0 then
  begin

    _FrmViewDailyRates := TFrmViewDailyRates.Create(nil);
    try
      RoomReservation := mRoomRes['RoomReservation'];
      if mRoomRes.Locate('roomreservation', RoomReservation, []) then
      begin

        Arrival := mRoomRes.FieldByName('arrival').AsDateTime;
        Departure := mRoomRes.FieldByName('departure').AsDateTime;
        dayCount := trunc(Departure) - trunc(Arrival);
        Guests := mRoomRes['Guests'];

        rateId := mRoomRes.FieldByName('RatePlanCode').AsString;

        _FrmViewDailyRates.Currency := edCurrency.Text;
        _FrmViewDailyRates.Clear;
        for ii := 0 to dayCount - 1 do
        begin
          ADate := Arrival + ii;
          if mRoomRates.Locate('RateDate', ADate, []) then
          begin
            if NOT(FDynamicRates.active AND
              FDynamicRates.findRateByRateCode(trunc(Arrival) + ii, Guests, Rate, rateId)) then
              Rate := mRoomRes.FieldByName('AvragePrice').AsFloat;
            _FrmViewDailyRates.Add(CreateDateRate(trunc(Arrival) + ii, Rate, edCustomer.Text, dayCount, Guests,
              edCurrency.Text));
          end;
        end;

        _FrmViewDailyRates.ShowModal;
      end;
    finally
      FreeAndNil(_FrmViewDailyRates);
    end;
  end;
end;

/// //////////////////////////////////////////////////////////////////////////////////////////////
// FORM
/// //////////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmMakeReservationQuick.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  screen.Cursor := crHourGlass;
  try
    FDynamicRates := TDynamicRates.Create;
    zIsFirstTime := true;
    zRtInRoom := 0;
    zRtNoRoom := 0;
    zRtTotal := 0;

    taReservation.TabVisible := false;
    tabSelectType.TabVisible := false;
    tabSelectRooms.TabVisible := false;
    tabRoomRates.TabVisible := false;
    pgcMain.ActivePageIndex := 0;
  finally
    screen.Cursor := crDefault;
  end;

  pgcExtraAndAlert.ActivePageIndex := 0;
end;

procedure TfrmMakeReservationQuick.FillQuickFind;
var
  rSet: TRoomerDataSet;

  function getFullname: String;
  begin
    Result := Trim(rSet['FirstName'] + ' ' + rSet['Lastname']);
  end;

  function getField(fName: String): String;
  var
    s: String;
  begin
    s := rSet[fName];
    if s = '' then
      Result := ''
    else
      Result := ', ' + s;
  end;

var
  item: TRoomerFilterItem;

begin
  rSet := glb.PersonProfiles;
  edContactPerson.StoredItems.Clear;
  rSet.First;
  while NOT rSet.eof do
  begin
    item := TRoomerFilterItem.Create;
    item.Key := inttostr(rSet['ID']);
    item.Line := format('%s%s%s%s', [getFullname, getField('City'), getField('Country'), getField('Address1')]);
    edContactPerson.StoredItems.Add(item);
    rSet.next;
  end;

  rSet := glb.PreviousGuestsSet;
  rSet.First;
  while NOT rSet.eof do
  begin
    item := TRoomerFilterItem.Create;
    item.Key := rSet['ID'];
    item.Line := format('%s%s%s%s', [rSet['Name'], getField('Address4'), getField('Country'), getField('Address1')]);
    edContactPerson.StoredItems.Add(item);
    rSet.next;
  end;

  if edContactPerson.StoredItems.Count > 0 then
    edContactPerson.Start;
end;

procedure TfrmMakeReservationQuick.FormDestroy(Sender: TObject);
begin
  FDynamicRates.Free;
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
var
  res: TRoomerDataSet;
begin
  edtRatePlans.Items.Clear;
  edtRatePlans.Items.AddObject('<none>', nil);
  res := glb.ChannelsSet;
  res.First;
  while NOT res.eof do
  begin
    edtRatePlans.Items.AddObject(res['name'], TObject(res.FieldByName('id').AsInteger));
    res.next;
  end;
  edtRatePlans.ItemIndex := 0;
end;

procedure TfrmMakeReservationQuick.FormShow(Sender: TObject);
begin

  FillQuickFind;
  screen.Cursor := crHourGlass;
  try
    cbxIsRoomResDiscountPrec.ItemIndex := 0;
    edCustomer.Text := FNewReservation.HomeCustomer.Customer;
    initCustomer;

    cbxBreakfast.Checked := ctrlGetBoolean('BreakfastInclDefault');
    cbxBreakfastIncl.Checked := cbxBreakfast.Checked;
    lblExtraCurrency.Caption := g.qNativeCurrency;
    lblExtraBedCurrency.Caption := edCurrency.Text;

    cbxExtraBed.Visible := false;
    cbxExtraBed.Checked := false;
    ShowhideExtraInputs;

    chkExcluteWaitingList.Checked := g.qExcluteWaitingList;
    chkExcluteAllotment.Checked := g.qExcluteAllotment;
    chkExcluteOrder.Checked := g.qExcluteOrder;
    chkExcluteDeparted.Checked := g.qExcluteDeparted;
    chkExcluteGuest.Checked := g.qExcluteGuest;
    chkExcluteBlocked.Checked := g.qExcluteBlocked;
    chkExcluteNoShow.Checked := g.qExcluteNoshow;

    if FNewReservation.IsQuick then
    begin
      Caption := GetTranslatedText('shTx_QuickReservation_NewReservationQuick');
      dtArrival.date := FNewReservation.newRoomReservations.ReservationArrival;
      dtDeparture.date := FNewReservation.newRoomReservations.ReservationDeparture;
      gbxDates.Enabled := false;
      btnFinish.Enabled := false;
      edCustomer.SetFocus;
    end
    else
    begin
      Caption := GetTranslatedText('shTx_QuickReservation_NewReservation');
      dtArrival.date := trunc(frmMain.resDateFrom); // trunc(now);
      dtDeparture.date := trunc(frmMain.resDateTo); // trunc(now+1);
      btnFinish.Enabled := false;
      edNights.SetFocus;
    end;
    edNights.Value := trunc(dtDeparture.date) - trunc(dtArrival.date);

    memRoomNotes.Enabled := false;
    clabRoomNotes.Visible := false;

    ShowRatePlans;
  finally
    screen.Cursor := crDefault;
  end;

  chkSendConfirmation.Enabled := false;

  cbxAddToGuestProfiles.Visible := false;

  FrmAlertPanel := TFrmAlertPanel.Create(self);
  FrmAlertPanel.PlaceEditPanel(Alerts, FNewReservation.AlertList);
  gbxProfileAlert.Visible := False;
end;


///////////////////////////////////////////////////////////////////////////////////////////
//  RoomRes grid and table
///////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmMakeReservationQuick.timNewTimer(Sender: TObject);
begin
  postMessage(handle, WM_SET_EMPTY_TEXT, 1, 0);
  timNew.Enabled := false;
end;

procedure TfrmMakeReservationQuick.tvRoomResAvragePricePropertiesEditValueChanged(Sender: TObject);
var
  RoomReservation: integer;
  RoomType: string;
  oldRate: double;
  NewRate: double;
begin
  RoomReservation := mRoomRes.FieldByName('RoomReservation').AsInteger;
  oldRate := mRoomRes.FieldByName('avragePrice').AsFloat;
  RoomType := mRoomRes.FieldByName('RoomType').AsString;

  mRoomRes.post;
  NewRate := mRoomRes.FieldByName('avragePrice').AsFloat;

  if oldRate <> NewRate then
  begin
    CalcOnePrice(RoomReservation, NewRate);
  end;

  if chkAutoUpdateNullPrice.Checked then
  begin
    ApplyNettoRateToNullPrice(NewRate, RoomReservation, RoomType);
  end;
end;

procedure TfrmMakeReservationQuick.tvRoomResChildrenCountPropertiesEditValueChanged(Sender: TObject);
var
  RoomReservation: integer;
  oldValue: integer;
  newValue: integer;
begin
  oldValue := mRoomRes.FieldByName('ChildrenCount').AsInteger;
  RoomReservation := mRoomRes.FieldByName('RoomReservation').AsInteger;
  mRoomRes.post;
  newValue := mRoomRes.FieldByName('ChildrenCount').AsInteger;
  if newValue <> oldValue then
  begin
    CalcOnePrice(RoomReservation);
  end;
end;

procedure TfrmMakeReservationQuick.tvRoomResColumn1PropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
begin
  EditRoomRateOneRoom(mRoomResroomreservation.AsInteger);
end;

procedure TfrmMakeReservationQuick.FormatTextToShortFormat(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not aText.IsEmpty then
    DateTimeToString(aText, FormatSettings.ShortTimeFormat, StrTodateTime(aText));
end;

procedure TfrmMakeReservationQuick.GetLocaTimeEditProperties(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
begin
  TcxTimeEditProperties(aProperties).Use24HourFormat := not FormatSettings.ShortTimeFormat.Contains(Formatsettings.TimeAMString);
end;

procedure TfrmMakeReservationQuick.tvRoomResGuestsPropertiesEditValueChanged(Sender: TObject);
var
  RoomReservation: integer;
  oldValue: integer;
  newValue: integer;
begin
  oldValue := mRoomRes.FieldByName('guests').AsInteger;
  RoomReservation := mRoomRes.FieldByName('RoomReservation').AsInteger;
  mRoomRes.post;
  newValue := mRoomRes.FieldByName('guests').AsInteger;
  if newValue <> oldValue then
  begin
    CalcOnePrice(RoomReservation);
  end;
end;

procedure TfrmMakeReservationQuick.tvRoomResinfantCountPropertiesEditValueChanged(Sender: TObject);
var
  RoomReservation: integer;
  oldValue: integer;
  newValue: integer;
begin
  oldValue := mRoomRes.FieldByName('infantCount').AsInteger;
  RoomReservation := mRoomRes.FieldByName('RoomReservation').AsInteger;
  mRoomRes.post;
  newValue := mRoomRes.FieldByName('InfantCount').AsInteger;
  if newValue <> oldValue then
  begin
    CalcOnePrice(RoomReservation);
  end;
end;

procedure TfrmMakeReservationQuick.tvRoomResMainGuestPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
var
  iId: integer;
begin
  iId := GuestProfiles(actLookup, 0);
  if iId > 0 then
  begin
    if glb.LocateSpecificRecord('personprofiles', 'ID', inttostr(iId)) then
    begin
      mRoomRes.edit;
      mRoomRes['MainGuest'] := Trim(glb.PersonProfiles['FirstName'] + ' ' + glb.PersonProfiles['LastName']);
      mRoomRes.FieldByName('PersonsProfilesId').AsInteger := iId;
      mRoomRes.post;
    end;
  end;
end;

procedure TfrmMakeReservationQuick.tvRoomResPackagePropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
var
  theData: recPackageHolder;
  roomPrice: double;
  itemPrice: double;
  package: string;
  rr: integer;
  guestCount: integer;
  nightCount: integer;
begin
  roomPrice := 0;
  itemPrice := 0;
  rr := mRoomRes.FieldByName('roomreservation').AsInteger;
  initPackageHolder(theData);
  theData.package := mRoomRes.FieldByName('Package').AsString;
  if openPackages(actLookup, theData) then
  begin
    package := theData.package;

    guestCount := mRoomRes.FieldByName('Guests').AsInteger;
    nightCount := trunc(mRoomRes.FieldByName('Departure').AsDateTime) - trunc(mRoomRes.FieldByName('Arrival').AsDateTime);

    if Trim(package) <> '' then
    begin
      Package_getRoomPrice(package, nightCount, guestCount, roomPrice, itemPrice);

      if roomPrice = 0 then
        RoomPrice := mRoomRes.FieldByName('AvragePrice').AsFloat;

      if RoomPrice > 0 then
      begin
        mRoomRes.edit;
        try
          mRoomRes.FieldByName('AvragePrice').AsFloat := RoomPrice;
          mRoomRes.FieldByName('AvrageDiscount').AsFloat := 0;
          mRoomRes.FieldByName('RateCount').AsInteger := 1;
          mRoomRes.FieldByName('PackagePrice').AsFloat := RoomPrice + itemPrice;
          mRoomRes.FieldByName('Package').AsString := package;
          mRoomRes.post;
        except
          mRoomRes.Cancel;
          raise;
        end;

        mRoomRates.Filter := '(Roomreservation=' + inttostr(rr) + ')';
        mRoomRates.Filtered := true;

        mRoomRates.First;
        while not mRoomRates.eof do
        begin
          mRoomRates.edit;
          try
            mRoomRates.FieldByName('rate').AsFloat := RoomPrice;
            mRoomRates.FieldByName('discount').AsFloat := 0;
            mRoomRates.FieldByName('isPercentage').AsBoolean := true;
            mRoomRates.FieldByName('discountAmount').AsFloat := 0;
            mRoomRates.FieldByName('Rentamount').AsFloat := RoomPrice;
            mRoomRates.FieldByName('NativeAmount').AsFloat := RoomPrice;
            mRoomRates.post;
          except
            mRoomRates.Cancel;
            raise;
          end;
          mRoomRates.next;
        end;
        mRoomRates.Filtered := false;
      end;
    end;
  end;

end;

function TfrmMakeReservationQuick.SetOnePrice(RoomReservation: integer; rateId: String; channelId: integer): boolean;
var

  ii: integer;

  Arrival: TDateTime;
  Departure: TDateTime;
  ADate: TDate;
  Rate: double;
  dayCount: integer;
  rateTotal, rateAvrage: double;

begin
  Result := false;
  if mRoomRes.Locate('roomreservation', RoomReservation, []) then
  begin

    Arrival := mRoomRes.FieldByName('arrival').AsDateTime;
    Departure := mRoomRes.FieldByName('departure').AsDateTime;
    dayCount := trunc(Departure) - trunc(Arrival);
    rateTotal := 0;
    for ii := 0 to dayCount - 1 do
    begin
      ADate := Arrival + ii;
      if mRoomRates.Locate('RateDate', ADate, []) then
      begin
        if FDynamicRates.active AND
          FDynamicRates.findRateByRateCode(trunc(Arrival) + ii, mRoomRes['Guests'], Rate, rateId) then
        begin
          // Rate acuired

          mRoomRates.edit;
          mRoomRates.FieldByName('Rate').AsFloat := Rate;
          mRoomRates.post;
        end;
      end;
      rateTotal := rateTotal + Rate;
    end;

    rateAvrage := rateTotal / dayCount;

    mRoomRes.edit;
    mRoomRes.FieldByName('AvragePrice').AsFloat := rateAvrage;
    mRoomRes.FieldByName('RateCount').AsFloat := 1;
    mRoomRes.FieldByName('ManualChannelId').AsInteger := channelId;
    mRoomRes.FieldByName('ratePlanCode').AsString := rateId;
    mRoomRes.post;
    Result := true;
  end;
end;

procedure TfrmMakeReservationQuick.tvRoomResRatePlanCodePropertiesCloseUp(Sender: TObject);
var
  channelId: integer;
begin
  if NOT mRoomRes.eof then
  begin
    channelId := 0;
    if edtRatePlans.ItemIndex > 0 then
      channelId := integer(edtRatePlans.Items.Objects[edtRatePlans.ItemIndex]);
    SetOnePrice(mRoomRes['RoomReservation'],
      (tvRoomResRatePlanCode.Properties AS TcxComboBoxProperties).Items[TcxComboBox(Sender).ItemIndex],
      channelId);
  end;
end;

procedure TfrmMakeReservationQuick.tvRoomResRatePlanCodePropertiesEditValueChanged(Sender: TObject);
begin
  if NOT mRoomRes.eof then
  begin
    mRoomRes.edit;
    TcxComboBox(Sender).ItemIndex := (tvRoomResRatePlanCode.Properties AS TcxComboBoxProperties)
      .Items.IndexOf(TcxComboBox(Sender).Text);
    if TcxComboBox(Sender).ItemIndex >= 0 then
      mRoomRes['ratePlanCode'] := (tvRoomResRatePlanCode.Properties AS TcxComboBoxProperties)
        .Items[TcxComboBox(Sender).ItemIndex];
    mRoomRes.post;
  end;
end;

procedure TfrmMakeReservationQuick.tvRoomResStockItemsCountPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  lCurrentRoomRes: recEditReservationExtrasHolder;
begin
  with lCurrentRoomRes do
  begin
    RoomReservation := mRoomResroomreservation.AsInteger;
    Room := mRoomResRoom.asString;
    RoomType := mRoomResRoomType.AsString;
    Currency := edCurrency.Text;
    CurrencyRate := hData.GetRate(Currency);
    guests := mRoomResGuests.AsInteger;
    childrenCount := mRoomResChildrenCount.asInteger;
    infantCount := mRoomResinfantCount.AsInteger;
    ArrivalDate := mRoomResArrival.AsDateTime;
    DepartureDate := mRoomResDeparture.asDateTime;
  end;

  if editReservationExtras(lCurrentRoomRes, mExtras) then
  begin
    mExtras.Filter := format('roomreservation=%d', [mRoomResroomreservation.AsInteger]);
    mExtras.Filtered := true;
    try
      mRoomRes.Edit;
      try
        mRoomResStockItemsCount.AsInteger := 0;
        mRoomResStockitemsPrice.AsFloat := 0;
        mExtras.First;
        while not mExtras.Eof do
        begin
          if (mExtrasRoomreservation.AsInteger = mRoomResroomreservation.asInteger) then // filter doesnt seem to work :-(
          begin
            mRoomResStockItemsCount.AsInteger := mRoomResStockItemsCount.AsInteger + mExtrasCount.AsInteger;
            mRoomResStockitemsPrice.AsFloat := mRoomResStockitemsPrice.AsFloat + mExtrasTotalprice.AsFloat;
          end;
          mExtras.Next;
        end;
        mRoomRes.Post;
      except
        mRoomRes.Cancel;
        raise;
      end;
    finally
      mExtras.Filtered := False;
    end;
  end;
end;

/// ////////////////////////////////////////////////////////////////////////////////////////
// SelectRooms grid and table
/// ////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmMakeReservationQuick.tvSelectRoomsRoomPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
begin
  if not mSelectRooms.FieldByName('Select').AsBoolean then
    exit;

  mSelectRooms.edit;

  if mSelectRooms.FieldByName('Room').AsString = '' then
    mSelectRooms.FieldByName('Room').AsString := mSelectRooms.FieldByName('tmp').AsString
  else
    mSelectRooms.FieldByName('Room').AsString := '';
end;

procedure TfrmMakeReservationQuick.tvSelectRoomsSelectPropertiesEditValueChanged(Sender: TObject);
var
  RoomType: string;
  isSelected: boolean;
  aValue: integer;
begin
  mSelectRooms.post;
  RoomType := mSelectRooms.FieldByName('RoomType').AsString;
  isSelected := mSelectRooms.FieldByName('Select').AsBoolean;

  if isSelected then
  begin
    aValue := 1;
  end
  else
  begin
    aValue := -1
  end;

  if mSelectTypes.Locate('Roomtype', RoomType, []) then
  begin
    mSelectTypes.edit;
    mSelectTypes.FieldByName('RoomsSelected').AsInteger := mSelectTypes.FieldByName('RoomsSelected').AsInteger + aValue;
    mSelectTypes.post;
  end;

  zTotalRoomsSelected := tvSelectType.DataController.Summary.FooterSummaryValues[4];
  labTotalRoomsSelected.Caption := inttostr(zTotalRoomsSelected);
end;

procedure TfrmMakeReservationQuick.tvSelectTypeNoRoomsPropertiesChange(Sender: TObject);
var
  total: integer;
  norooms: integer;
  TotalFree: integer;
begin
  norooms := mSelectTypes.FieldByName('Norooms').AsInteger;
  TotalFree := mSelectTypes.FieldByName('totalFree').AsInteger;
  total := TotalFree - norooms;
  sLabel1.Caption := inttostr(total);
end;

procedure TfrmMakeReservationQuick.tvSelectTypeNoRoomsPropertiesValidate(Sender: TObject; var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: boolean);
begin
  if DisplayValue < 0 then
    DisplayValue := 0;
end;

procedure TfrmMakeReservationQuick.tvSelectTypeNoRoomsStylesGetContentStyle(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
var
  total: integer;
  norooms: integer;
  TotalFree: integer;
begin
  norooms := mSelectTypes.FieldByName('Norooms').AsInteger;
  TotalFree := mSelectTypes.FieldByName('totalFree').AsInteger;
  total := TotalFree - norooms;

  if total < 0 then
  begin
    AStyle := cxStyle1
  end
  else
  begin
    AStyle := cxStyle2
  end;

end;

procedure TfrmMakeReservationQuick.tvSelectTypeSelectedPropertiesEditValueChanged(Sender: TObject);
begin
  if tvSelectType.DataController.DataSource.State = dsEdit then
    mSelectTypes.post;
end;

procedure TfrmMakeReservationQuick.tvSelectTypeSelectedPropertiesValidate(Sender: TObject; var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: boolean);
begin
  if DisplayValue < 0 then
    DisplayValue := 0;

  if DisplayValue > mSelectTypes.FieldByName('Available').AsInteger then
  begin
    if mSelectTypes.FieldByName('Available').AsInteger < 1 then
    begin
      DisplayValue := 0;
    end
    else
    begin
      DisplayValue := mSelectTypes.FieldByName('Available').AsInteger;
    end;
  end;

end;

procedure TfrmMakeReservationQuick.initCustomer;
var
  Customer: string;
  oldCustomer: string;
  ChannelCode: String;
  i: integer;
begin
  Customer := edCustomer.Text;
  oldCustomer := FNewReservation.HomeCustomer.Customer;
  FNewReservation.HomeCustomer.Customer_update(Customer);
  labCustomerName.Caption := FNewReservation.HomeCustomer.CustomerName;

  edCountry.Text := FNewReservation.HomeCustomer.Country;
  labCountryName.Caption := FNewReservation.HomeCustomer.CountryName;
  edReservationName.Text := FNewReservation.HomeCustomer.CustomerName;

  cbxRoomStatus.ItemIndex := RoomStatusFromInfo(FNewReservation.HomeCustomer.RoomStatus);
  edMarketSegmentCode.Text := FNewReservation.HomeCustomer.MarketSegmentCode;

  if FNewReservation.HomeCustomer.IsGroupInvoice = true then
    chkisGroupInvoice.Checked := true
  else
    chkisGroupInvoice.Checked := false;

  edCurrency.Text := FNewReservation.HomeCustomer.Currency;
  edPcCode.Text := FNewReservation.HomeCustomer.PcCode;
  edRoomResDiscount.Value := trunc(FNewReservation.HomeCustomer.DiscountPerc);
  edPID.Text := FNewReservation.HomeCustomer.PID;
  edCustomerName.Text := FNewReservation.HomeCustomer.CustomerName;
  edAddress1.Text := FNewReservation.HomeCustomer.Address1;
  edAddress2.Text := FNewReservation.HomeCustomer.Address2;
  edAddress3.Text := FNewReservation.HomeCustomer.Address3;
  edTel1.Text := FNewReservation.HomeCustomer.Tel1;
  edTel2.Text := FNewReservation.HomeCustomer.Tel2;
  edFax.Text := FNewReservation.HomeCustomer.Fax;
  edEmailAddress.Text := FNewReservation.HomeCustomer.EmailAddress;
  edHomePage.Text := FNewReservation.HomeCustomer.HomePage;
  edContactPhone.Text := FNewReservation.HomeCustomer.ContactPhone;
  // 0810-hj   edContactCountry.text       := oNewReservation.HomeCustomer.Country;
  edContactPerson.Text := ''; // oNewReservation.HomeCustomer.ContactPerson;
  edContactFax.Text := ''; // oNewReservation.HomeCustomer.ContactFax;
  edContactEmail.Text := ''; // oNewReservation.HomeCustomer.ContactEmail;
  zCustomerChanged := false;

  memCustomerAlert.lines.Clear;
  memCustomerAlert.Text := d.GetCustomerPreferences(Customer);

  customerValidate;
  CountryValidate;
  MarketSegmentValidate;
  CurrencyValidate(edCurrency, clabCurrency, labCurrencyName);
  PriceCodeValidate(edPcCode, clabPcCode, labPcCodeName);

  if glb.LocateSpecificRecordAndGetValue('channels', 'id', FNewReservation.HomeCustomer.CustomerRatePlanId,
    'channelManagerId', ChannelCode) then
    for i := 1 to edtRatePlans.Items.Count - 1 do
      if integer(edtRatePlans.Items.Objects[i]) = FNewReservation.HomeCustomer.CustomerRatePlanId then
      begin
        edtRatePlans.ItemIndex := i; // edtRatePlans.Items.IndexOf(ChannelCode);
        edtRatePlansCloseUp(nil);
        Break;
      end;
end;

procedure TfrmMakeReservationQuick.btdEditRoomRateClick(Sender: TObject);
var
  RoomReservation: integer;
begin
  RoomReservation := mRoomRes.FieldByName('roomreservation').AsInteger;
  EditRoomRateOneRoom(RoomReservation);
end;

procedure TfrmMakeReservationQuick.EditRoomRateOneRoom(RoomRes: integer);
var
  theData: recEditRoomPriceHolder;

  Reservation: integer;
  RoomReservation: integer;
  RoomNumber: string;
  PriceCode: string;
  RateDate: TDateTime;
  Rate: double;
  Discount: double;
  isPercentage: boolean;
  ShowDiscount: boolean;
  isPaid: boolean;
  DiscountAmount: double;
  RentAmount: double;
  NativeAmount: double;
  AvrageAmount: double;
  ttAmount: double;
  AmountCount: integer;
  lstPrices: TstringList;
  RateCount: integer;

  ttDiscount: double;
  AvrageDiscount: double;
  applyType: integer;

begin
  isPercentage := true;
  applyType := 0;

  if mRR_.active then
    mRR_.Close;
  lstPrices := TstringList.Create;
  try
    lstPrices.Sorted := true;
    lstPrices.Duplicates := dupIgnore;

    initEditRoomPriceHolder(theData);
    theData.isCreateRes := true;
    theData.Currency := edCurrency.Text;
    theData.CurrencyRate := hData.GetRate(theData.Currency);

    RoomReservation := mRoomRes.FieldByName('roomreservation').AsInteger;
    theData.RoomType := mRoomRes.FieldByName('RoomType').AsString;
    theData.Guests := mRoomRes.FieldByName('Guests').AsInteger;
    theData.childrenCount := mRoomRes.FieldByName('childrenCount').AsInteger;
    theData.infantCount := mRoomRes.FieldByName('infantCount').AsInteger;
    mRR_.Open;

    mRoomRates.First;
    while not mRoomRates.eof do
    begin
      if mRoomRates.FieldByName('roomreservation').AsInteger = RoomReservation then
      begin
        mRR_.append;
        mRR_.FieldByName('Reservation').AsInteger := mRoomRates.FieldByName('Reservation').AsInteger;
        mRR_.FieldByName('RoomReservation').AsInteger := mRoomRates.FieldByName('RoomReservation').AsInteger;
        mRR_.FieldByName('RoomNumber').AsString := mRoomRates.FieldByName('RoomNumber').AsString;
        mRR_.FieldByName('PriceCode').AsString := mRoomRates.FieldByName('PriceCode').AsString;
        mRR_.FieldByName('RateDate').AsDateTime := mRoomRates.FieldByName('RateDate').AsDateTime;
        mRR_.FieldByName('Rate').AsFloat := mRoomRates.FieldByName('Rate').AsFloat;
        mRR_.FieldByName('Discount').AsFloat := mRoomRates.FieldByName('Discount').AsFloat;
        mRR_.FieldByName('isPercentage').AsBoolean := mRoomRates.FieldByName('isPercentage').AsBoolean;
        mRR_.FieldByName('ShowDiscount').AsBoolean := mRoomRates.FieldByName('ShowDiscount').AsBoolean;
        mRR_.FieldByName('isPaid').AsBoolean := mRoomRates.FieldByName('isPaid').AsBoolean;
        mRR_.FieldByName('DiscountAmount').AsFloat := mRoomRates.FieldByName('DiscountAmount').AsFloat;
        mRR_.FieldByName('RentAmount').AsFloat := mRoomRates.FieldByName('RentAmount').AsFloat;
        mRR_.FieldByName('NativeAmount').AsFloat := mRoomRates.FieldByName('NativeAmount').AsFloat;
        mRR_.FieldByName('Currency').AsString := mRoomRates.FieldByName('Currency').AsString;
        mRR_.FieldByName('CurrencyRate').AsFloat := mRoomRates.FieldByName('CurrencyRate').AsFloat;
        mRR_.post;
      end;
      mRoomRates.next;
    end;

    mRR_.First;

    theData.room := mRR_.FieldByName('roomNumber').AsString;
    ttAmount := 0;
    ttDiscount := 0;
    AmountCount := 0;
    if editRoomPrice(actNone, theData, mRR_, applyType) then
    begin
      mRR_.First;
      while not mRR_.eof do
      begin
        Reservation := mRR_.FieldByName('Reservation').AsInteger;
        RoomReservation := mRR_.FieldByName('RoomReservation').AsInteger;
        RoomNumber := mRR_.FieldByName('RoomNumber').AsString;
        PriceCode := mRR_.FieldByName('PriceCode').AsString;
        RateDate := mRR_.FieldByName('RateDate').AsDateTime;
        Rate := mRR_.FieldByName('Rate').AsFloat;
        Discount := mRR_.FieldByName('Discount').AsFloat;
        isPercentage := mRR_.FieldByName('isPercentage').AsBoolean;
        ShowDiscount := mRR_.FieldByName('ShowDiscount').AsBoolean;
        isPaid := mRR_.FieldByName('isPaid').AsBoolean;
        DiscountAmount := mRR_.FieldByName('DiscountAmount').AsFloat;
        RentAmount := mRR_.FieldByName('RentAmount').AsFloat;
        NativeAmount := mRR_.FieldByName('NativeAmount').AsFloat;

        lstPrices.Add(floatTostr(RentAmount));
        inc(AmountCount);
        ttAmount := ttAmount + RentAmount;
        ttDiscount := ttDiscount + Discount;

        if mRoomRates.Locate('RoomReservation;rateDate', VarArrayOf([RoomReservation, RateDate]), []) then
        begin
          mRoomRates.edit;
          mRoomRates.FieldByName('Reservation').AsInteger := Reservation;
          mRoomRates.FieldByName('RoomReservation').AsInteger := RoomReservation;
          mRoomRates.FieldByName('RoomNumber').AsString := RoomNumber;
          mRoomRates.FieldByName('PriceCode').AsString := PriceCode;
          mRoomRates.FieldByName('RateDate').AsDateTime := RateDate;
          mRoomRates.FieldByName('Rate').AsFloat := Rate;
          mRoomRates.FieldByName('Discount').AsFloat := Discount;
          mRoomRates.FieldByName('isPercentage').AsBoolean := isPercentage;
          mRoomRates.FieldByName('ShowDiscount').AsBoolean := ShowDiscount;
          mRoomRates.FieldByName('isPaid').AsBoolean := isPaid;
          mRoomRates.FieldByName('DiscountAmount').AsFloat := DiscountAmount;
          mRoomRates.FieldByName('RentAmount').AsFloat := RentAmount;
          mRoomRates.FieldByName('NativeAmount').AsFloat := NativeAmount;
          mRoomRates.post;
        end;
        // memReservationGeneralInfo.Lines.Add(floattostr(rate));
        mRR_.next;
      end;

      if mRoomRes.Locate('RoomReservation', RoomReservation, []) then
      begin
        if AmountCount <> 0 then
        begin
          AvrageAmount := ttAmount / AmountCount;
          AvrageDiscount := ttDiscount / AmountCount;
          RateCount := lstPrices.Count;
          mRoomRes.edit;
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
    if mRR_.active then
      mRR_.Close;
    FreeAndNil(lstPrices);
  end;

  if applyType = 2 then
  begin
    ApplyRateToOther(RoomReservation, theData.RoomType)
  end
  else
    if applyType = 3 then
  begin
    ApplyRateToOther(RoomReservation, '');
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
    mSelectTypes.edit;
    mSelectTypes.FieldByName('RoomsSelected').AsInteger := 0;
    mSelectTypes.post;
    mSelectTypes.next;
  end;

  mSelectTypes.First;
end;

procedure TfrmMakeReservationQuick.lblExtraBedCurrencyClick(Sender: TObject);
begin
  showmessage(edCurrency.Text);
end;

procedure TfrmMakeReservationQuick.getSelectRooms;
var
  rSet: TRoomerDataSet;
  rSetOcc: TRoomerDataSet;
  s: string;
  dateFrom: TDate;
  dateTo: TDate;
  room: string;

begin
  mSelectRooms.DisableControls;
  try
    dateFrom := dtArrival.date;
    dateTo := dtDeparture.date;

    if mSelectRooms.active then
      mSelectRooms.Close;
    mSelectRooms.Open;

    s := '';
    s := s + 'SELECT DISTINCT '#10;
    s := s + '    Room '#10;
    s := s + '  , isNoRoom '#10;
    s := s + 'FROM '#10;
    s := s + '  roomsdate '#10;
    s := s + 'WHERE '#10;
    s := s + '  (ADate >= ' + _db(dateFrom) + ') AND (ADate < ' + _db(dateTo) + ') AND (isNoRoom = 0) '#10;
    s := s + '   AND (ResFlag <> ' + _db(STATUS_DELETED) + ' ) '; // **zxhj
    s := s + '   AND (ResFlag <> ' + _db(STATUS_CANCELED) + ' ) '; // **zxhj
    s := s + 'ORDER BY '#10;
    s := s + '  ROOM '#10;

    rSetOcc := createNewDataSet;
    try
      if rSet_bySQL(rSetOcc, s) then
      begin
        // iOccRooms := rSet.RecordCount;
      end;

      s := 'SELECT * FROM wroominfo ORDER BY room ';
      rSet := createNewDataSet;
      try
        rSet_bySQL(rSet, s);

        While not rSet.eof do
        begin
          room := rSet.FieldByName('room').AsString;
          if not rSetOcc.Locate('room', room, []) then
          begin
            mSelectRooms.append;
            mSelectRooms.FieldByName('Room').AsString := rSet.FieldByName('Room').AsString;
            mSelectRooms.FieldByName('tmp').AsString := rSet.FieldByName('Room').AsString;
            mSelectRooms.FieldByName('Description').AsString := rSet.FieldByName('Description').AsString;
            mSelectRooms.FieldByName('DetailedDescription').AsString := rSet.FieldByName('DetailedDescription')
              .AsString;
            mSelectRooms.FieldByName('RoomType').AsString := rSet.FieldByName('RoomType').AsString;
            mSelectRooms.FieldByName('Bath').AsBoolean := rSet.FieldByName('Bath').AsBoolean;
            mSelectRooms.FieldByName('Shower').AsBoolean := rSet.FieldByName('Shower').AsBoolean;
            mSelectRooms.FieldByName('Safe').AsBoolean := rSet.FieldByName('Safe').AsBoolean;
            mSelectRooms.FieldByName('TV').AsBoolean := rSet.FieldByName('TV').AsBoolean;
            mSelectRooms.FieldByName('Video').AsBoolean := rSet.FieldByName('Video').AsBoolean;
            mSelectRooms.FieldByName('Radio').AsBoolean := rSet.FieldByName('Radio').AsBoolean;
            mSelectRooms.FieldByName('CDPlayer').AsBoolean := rSet.FieldByName('CDPlayer').AsBoolean;
            mSelectRooms.FieldByName('Telephone').AsBoolean := rSet.FieldByName('Telephone').AsBoolean;
            mSelectRooms.FieldByName('Press').AsBoolean := rSet.FieldByName('Press').AsBoolean;
            mSelectRooms.FieldByName('Coffee').AsBoolean := rSet.FieldByName('Coffee').AsBoolean;
            mSelectRooms.FieldByName('Kitchen').AsBoolean := rSet.FieldByName('Kitchen').AsBoolean;
            mSelectRooms.FieldByName('Minibar').AsBoolean := rSet.FieldByName('Minibar').AsBoolean;
            mSelectRooms.FieldByName('Fridge').AsBoolean := rSet.FieldByName('Fridge').AsBoolean;
            mSelectRooms.FieldByName('Hairdryer').AsBoolean := rSet.FieldByName('Hairdryer').AsBoolean;
            mSelectRooms.FieldByName('InternetPlug').AsBoolean := rSet.FieldByName('InternetPlug').AsBoolean;
            mSelectRooms.FieldByName('Fax').AsBoolean := rSet.FieldByName('Fax').AsBoolean;
            mSelectRooms.FieldByName('SqrMeters').AsFloat := rSet.GetFloatValue(rSet.FieldByName('SqrMeters'));
            mSelectRooms.FieldByName('BedSize').AsBoolean := rSet.FieldByName('BedSize').AsBoolean;
            mSelectRooms.FieldByName('Equipments').AsString := rSet.FieldByName('Equipments').AsString;
            mSelectRooms.FieldByName('Bookable').AsBoolean := rSet.FieldByName('Bookable').AsBoolean;
            mSelectRooms.FieldByName('Statistics').AsBoolean := rSet.FieldByName('Statistics').AsBoolean;
            mSelectRooms.FieldByName('Status').AsString := rSet.FieldByName('Status').AsString;
            mSelectRooms.FieldByName('OrderIndex').AsInteger := rSet.FieldByName('OrderIndex').AsInteger;
            mSelectRooms.FieldByName('hidden').AsBoolean := rSet.FieldByName('hidden').AsBoolean;
            mSelectRooms.FieldByName('Location').AsString := rSet.FieldByName('Location').AsString;
            mSelectRooms.FieldByName('Floor').AsInteger := rSet.FieldByName('Floor').AsInteger;
            mSelectRooms.FieldByName('ID').AsInteger := rSet.FieldByName('ID').AsInteger;
            mSelectRooms.FieldByName('Dorm').AsString := rSet.FieldByName('Dorm').AsString;
            mSelectRooms.FieldByName('useInNationalReport').AsBoolean := rSet.FieldByName('useInNationalReport')
              .AsBoolean;
            mSelectRooms.FieldByName('Active').AsBoolean := rSet.FieldByName('Active').AsBoolean;
            mSelectRooms.FieldByName('LocationDescription').AsString := rSet.FieldByName('LocationDescription')
              .AsString;
            mSelectRooms.FieldByName('RoomTypeDescription').AsString := rSet.FieldByName('RoomTypeDescription')
              .AsString;
            mSelectRooms.FieldByName('NumberGuests').AsInteger := rSet.FieldByName('NumberGuests').AsInteger;
            mSelectRooms.FieldByName('RoomTypeGroup').AsString := rSet.FieldByName('RoomTypeGroup').AsString;
            mSelectRooms.FieldByName('RoomTypeGroupDescription').AsString :=
              rSet.FieldByName('RoomTypeGroupDescription').AsString;
            mSelectRooms.post;
          end;
          rSet.next;
        end;
      finally
        FreeAndNil(rSet);
      end;
    finally
      FreeAndNil(rSetOcc);
    end;
    mSelectRooms.First;
    cbxFilterSelectedTypesClick(cbxFilterSelectedTypes); // update filter
  finally
    mSelectRooms.EnableControls;
  end;

end;

function TfrmMakeReservationQuick.doAutoSelect(RoomType: string; NumRooms: integer; PriorityRule: string): integer;
var
  lstPriority: TstringList;
  tmp: integer;

  aRoomtype: string;
  foundCount: integer;

begin
  Result := 0;
  if NumRooms = 0 then
    exit;

  foundCount := 0;
  lstPriority := TstringList.Create;
  try
    tmp := mSelectRooms.FieldByName('ID').AsInteger;
    mSelectRooms.DisableControls;
    try
      mSelectRooms.First;
      while NOT mSelectRooms.eof do
      begin
        aRoomtype := mSelectRooms.FieldByName('RoomType').AsString;
        if Uppercase(aRoomtype) = Uppercase(RoomType) then
        begin
          if foundCount < NumRooms then
          begin
            mSelectRooms.edit;
            mSelectRooms.FieldByName('Select').AsBoolean := true;
            mSelectRooms.post;

            mSelectTypes.edit;
            mSelectTypes.FieldByName('RoomsSelected').AsInteger := mSelectTypes.FieldByName('RoomsSelected')
              .AsInteger + 1;
            mSelectTypes.post;

            inc(foundCount);
          end;
        end;
        mSelectRooms.next;
      end;
      mSelectRooms.Locate('ID', tmp, []);
    finally
      mSelectRooms.EnableControls;
    end;
  finally
    FreeAndNil(lstPriority);
  end;
  zTotalRoomsSelected := tvSelectType.DataController.Summary.FooterSummaryValues[4];
  labTotalRoomsSelected.Caption := inttostr(zTotalRoomsSelected);
end;

procedure TfrmMakeReservationQuick.dtDepartureCloseUp(Sender: TObject);
begin
  if dtDeparture.date <= dtArrival.date then
    dtDeparture.date := dtArrival.date + 1;
  if dtArrival.date >= dtDeparture.date then
    dtArrival.date := dtDeparture.date - 1;
  zNights := trunc(dtDeparture.date) - trunc(dtArrival.date);
  edNights.Value := zNights;
end;

procedure TfrmMakeReservationQuick.dtDepartureExit(Sender: TObject);
begin
  if dtDeparture.date <= dtArrival.date then
    dtDeparture.date := dtArrival.date + 1;
  if dtArrival.date >= dtDeparture.date then
    dtArrival.date := dtDeparture.date - 1;
  zNights := trunc(dtDeparture.date) - trunc(dtArrival.date);
  edNights.Value := zNights;
end;

procedure TfrmMakeReservationQuick.btnAutoSelectRoomsClick(Sender: TObject);
var
  RoomType: string;
  NumRooms: integer;
  PriorityRule: string;
begin
  InitSelectRooms;
  mSelectTypes.First;
  while not mSelectTypes.eof do
  begin
    RoomType := mSelectTypes.FieldByName('RoomType').AsString;
    NumRooms := mSelectTypes.FieldByName('Selected').AsInteger;
    PriorityRule := mSelectTypes.FieldByName('PriorityRule').AsString;
    doAutoSelect(RoomType, NumRooms, PriorityRule);
    mSelectTypes.next;
  end;
end;

procedure TfrmMakeReservationQuick.btnEditRateAllRoomsClick(Sender: TObject);
begin
  Apply;
end;

procedure TfrmMakeReservationQuick.btnFinishClick(Sender: TObject);
begin
  Apply;
end;

procedure TfrmMakeReservationQuick.btnGetLastCustomerClick(Sender: TObject);
var
  s: string;
  rSet: TRoomerDataSet;
begin
  rSet := createNewDataSet;
  try
    s := '';
    s := s + ' Select * FROM reservations Order by reservation desc Limit 1';
    if rSet_bySQL(rSet, s) then
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
    FreeAndNil(rSet);
  end;
end;

procedure TfrmMakeReservationQuick.btnNextClick(Sender: TObject);
begin
  if not customerValidate then
    exit;
  if not CountryValidate then
    exit;
  if not MarketSegmentValidate then
    exit;
  if not CurrencyValidate(edCurrency, clabCurrency, labCurrencyName) then
    exit;
  if not PriceCodeValidate(edPcCode, clabPcCode, labPcCodeName) then
    exit;

  if pgcMain.ActivePageIndex = 3 then
    exit;

  if pgcMain.ActivePageIndex = 0 then
  begin
    addAvailableRoomTypes;
    if FNewReservation.IsQuick then
    begin
      pgcMain.ActivePageIndex := 3;
    end
    else
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
    if FNewReservation.IsQuick then
    begin
      pgcMain.ActivePageIndex := 3;
    end
    else
    begin
      zTotalSelected := tvSelectType.DataController.Summary.FooterSummaryValues[0];
      zTotalRoomsSelected := tvSelectType.DataController.Summary.FooterSummaryValues[4]; // 4
      zTotalAvailable := tvSelectType.DataController.Summary.FooterSummaryValues[3]; // 3
      zTotalFree := tvSelectType.DataController.Summary.FooterSummaryValues[2]; // 2
      zTotalNoRooms := tvSelectType.DataController.Summary.FooterSummaryValues[1]; // 1

      zTotal := zTotalSelected + zTotalRoomsSelected + zTotalAvailable + zTotalFree + zTotalNoRooms;
      if ((zTotalSelected = 0) and (zTotalNoRooms > 0)) and (zTotal <> 0) then
      begin
        pgcMain.ActivePage := tabRoomRates;
      end
      else
      begin
        pgcMain.ActivePageIndex := 2;
      end;
    end;
    pgcMainChange(self);
    exit;
  end;

  if pgcMain.ActivePageIndex = 2 then
  begin
    if FNewReservation.IsQuick then
    begin
      pgcMain.ActivePageIndex := 3;
    end
    else
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

    edContactPhone.Text := '';
    edContactFax.Text := '';
    edContactEmail.Text := '';

    lbContactCountryName.Caption := '';
  end;
  edtPortfolio.Tag := 0;
  edtPortfolio.Text := '';
end;

procedure TfrmMakeReservationQuick.btnPreviusClick(Sender: TObject);
begin
  if pgcMain.ActivePageIndex = 0 then
    exit;

  if pgcMain.ActivePageIndex = 1 then
  begin
    if FNewReservation.IsQuick then
    begin
      pgcMain.ActivePageIndex := 0;
    end
    else
    begin
      pgcMain.ActivePageIndex := 0;
    end;
    pgcMainChange(self);
    exit;
  end;

  if pgcMain.ActivePageIndex = 2 then
  begin
    if FNewReservation.IsQuick then
    begin
      pgcMain.ActivePageIndex := 0;
    end
    else
    begin
      pgcMain.ActivePageIndex := 1;
    end;
    pgcMainChange(self);
    exit;
  end;

  if pgcMain.ActivePageIndex = 3 then
  begin
    if FNewReservation.IsQuick then
    begin
      pgcMain.ActivePageIndex := 0;
    end
    else
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

procedure TfrmMakeReservationQuick.SetAllAsNoRoom(doNextPage: boolean = true);
var
  norooms: integer;
begin
  mSelectTypes.DisableControls;
  mSelectTypes.First;
  try
    while not mSelectTypes.eof do
    begin
      norooms := mSelectTypes.FieldByName('selected').AsInteger + mSelectTypes.FieldByName('noRooms').AsInteger;
      mSelectTypes.edit;
      mSelectTypes.FieldByName('noRooms').AsInteger := norooms;
      mSelectTypes.FieldByName('Selected').AsInteger := 0;
      mSelectTypes.post;
      mSelectTypes.next;
    end;
  finally
    mSelectTypes.EnableControls;
    screen.Cursor := crDefault;
  end;

  // if jist norooms
  zTotal := zTotalSelected + zTotalRoomsSelected + zTotalAvailable + zTotalFree + zTotalNoRooms;
  if ((zTotalSelected = 0) and (zTotalNoRooms > 0)) and (zTotal <> 0) then
    exit;

  mSelectRooms.DisableControls;
  mSelectRooms.First;
  try
    while not mSelectRooms.eof do
    begin
      mSelectRooms.edit;
      mSelectRooms.FieldByName('select').AsBoolean := false;
      mSelectRooms.post;
      mSelectRooms.next;
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

procedure TfrmMakeReservationQuick.SetOutOfOrderBlocking(const Value: boolean);
var
  i: integer;
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
  tvRoomResStockItemsCount.Visible := NOT FOutOfOrderBlocking;
  tvRoomResStockitemsPrice.Visible := NOT FOutOfOrderBlocking;
  tvRoomResAvrageDiscount.Visible := NOT FOutOfOrderBlocking;
  tvRoomResisPercentage.Visible := NOT FOutOfOrderBlocking;
  tvRoomResPriceCode.Visible := NOT FOutOfOrderBlocking;
  tvRoomResRatePlanCode.Visible := NOT FOutOfOrderBlocking;

  if FOutOfOrderBlocking then
  begin
    clabReservationName.Caption := GetTranslatedText('shTx_FrmMakeReservationQuick_OutOfOrderDescription');
    clabArrival.Caption := GetTranslatedText('shTx_FrmMakeReservationQuick_OutOfOrderStartDate');
    clabdeparture.Caption := GetTranslatedText('shTx_FrmMakeReservationQuick_OutOfOrderEndDate');
  end
  else
  begin
    RoomerLanguage.TranslateThisControl(self, clabReservationName);
    RoomerLanguage.TranslateThisControl(self, clabArrival);
    RoomerLanguage.TranslateThisControl(self, clabdeparture);
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
var
  sName: String;
  iId: integer;
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

      edContactPhone.Text := glb.PersonProfiles['TelMobile'];
      edContactFax.Text := glb.PersonProfiles['TelFax'];
      edContactEmail.Text := glb.PersonProfiles['Email'];

      if glb.LocateSpecificRecordAndGetValue('countries', 'Country', edContactCountry.Text, 'CountryName', sName) then
        lbContactCountryName.Caption := sName;

      edtSpecialRequests.Text := glb.PersonProfiles['Preparation'];
      edtNotes.Text := glb.PersonProfiles['Information'];
      edtRoom.Text := glb.PersonProfiles['Room'];
      edtRoomType.Text := glb.PersonProfiles['RoomType'];

      SetProfileAlertVisibility;
    end;
  end;
end;

procedure TfrmMakeReservationQuick.SetProfileAlertVisibility;
begin
  gbxProfileAlert.Visible := TRIM(edtSpecialRequests.Text + edtNotes.Text +
                                  edtRoom.Text + edtRoomType.Text) <> '';
  gbxRoomAlert.Visible := TRIM(edtRoom.Text + edtRoomType.Text) <> '';
  if gbxProfileAlert.Visible then
  begin
    edtSpecialRequests.Font.Color := clRed;
    edtNotes.Font.Color := clRed;

    lblSpecialRequests.Visible := (edtSpecialRequests.Text) <> '';
    edtSpecialRequests.Visible := (edtSpecialRequests.Text) <> '';

    lblNotes.Visible := (edtNotes.Text) <> '';
    edtNotes.Visible := (edtNotes.Text) <> '';

    lblRoom.Visible := (edtRoom.Text) <> '';
    edtRoom.Visible := (edtRoom.Text) <> '';

    lblRoomType.Visible := (edtRoomType.Text) <> '';
    edtRoomType.Visible := (edtRoomType.Text) <> '';
  end;
end;

procedure TfrmMakeReservationQuick.sButton1Click(Sender: TObject);
begin
  mRoomRes.DisableControls;
  mRoomRes.First;
  try
    while not mRoomRes.eof do
    begin
      mRoomRes.edit;
      mRoomRes.FieldByName('Room').AsString := '<' + mRoomRes.FieldByName('roomReservation').AsString + '>';
      mRoomRes.post;
      mRoomRes.next;
    end;
  finally
    mRoomRes.EnableControls;
    screen.Cursor := crDefault;
  end;
end;

procedure TfrmMakeReservationQuick.edCustomerPropertiesEditValueChanged(Sender: TObject);
begin
end;


// **********************************************************************************
// Country
//

procedure TfrmMakeReservationQuick.cbxFilterSelectedTypesClick(Sender: TObject);
begin
  SetRoomFilterOnlySelectedTypes(TCheckbox(Sender).Checked);
end;


procedure TfrmMakeReservationQuick.SetRoomFilterOnlySelectedTypes(aOnlySelected: boolean);
begin
  mSelectRooms.Filtered := aOnlySelected;
end;

function TfrmMakeReservationQuick.CountryValidate: boolean;
var
  sValue: string;
begin
  Result := true;

  sValue := Trim(edCountry.Text);
  // **NOT TESTED**//
  if not hData.CountryExists(sValue) then
  begin
    edCountry.SetFocus;
    labCountryName.Font.Color := clRed;
    labCountryName.Caption := GetTranslatedText('shNotF_star');
    Result := false;
    exit;
  end
  else
  begin
    labCountryName.Font.Color := clBlack;
    if glb.LocateCountry(sValue) then
      labCountryName.Caption := glb.Countries['CountryName']; // GET_CountryName(sValue);
  end;

end;

procedure TfrmMakeReservationQuick.mSelectRoomsFilterRecord(DataSet: TDataSet; var Accept: Boolean);
var
  bm: TBookmark;
begin
  if cbxFilterSelectedTypes.Checked then
  begin
    bm := mSelectTypes.Bookmark;
    try
      Accept := (zTotalSelected = 0) or (mSelectTypes.Locate('roomtype', mSelectRoomsRoomType.AsString, []) and (mSelectTypesSelected.AsInteger > 0));
    finally
      mSelectTypes.Bookmark := bm;
    end;
  end
  else
    Accept := True;
end;

procedure TfrmMakeReservationQuick.mSelectRoomsNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('Select').AsBoolean := false;
end;

procedure TfrmMakeReservationQuick.mSelectTypesCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('totalFree').AsInteger := DataSet.FieldByName('Available').AsInteger -
    DataSet.FieldByName('Selected').AsInteger
end;

procedure TfrmMakeReservationQuick.pgcMainChange(Sender: TObject);
begin
  if pgcMain.ActivePageIndex = 0 then
  begin

    btnCancel.Enabled := true;
    btnPrevius.Enabled := false;
    btnNext.Enabled := true;
    if FNewReservation.IsQuick then
    begin
      btnFinish.Enabled := true;
      memRoomNotes.Enabled := true;
      clabRoomNotes.Visible := true;
    end
    else
    begin
      btnFinish.Enabled := false;
      memRoomNotes.Enabled := false;
      clabRoomNotes.Visible := false;

    end;
  end
  else
    if pgcMain.ActivePageIndex = 1 then
  begin
    if not FNewReservation.IsQuick then
    begin
      zTotalSelected := 0; // 0
      zTotalRoomsSelected := 0; // 4
      zTotalAvailable := 0; // 3
      zTotalFree := 0; // 2
      zTotalNoRooms := 0; // 1

      zTotal := zTotalSelected + zTotalRoomsSelected + zTotalAvailable + zTotalFree + zTotalNoRooms;
      labTotalSelected.Caption := inttostr(zTotalSelected);
      labTotalRoomsSelected.Caption := inttostr(zTotalRoomsSelected);
    end;

    memRoomNotes.Enabled := false;
    clabRoomNotes.Visible := false;
    btnCancel.Enabled := true;
    btnPrevius.Enabled := true;
    btnNext.Enabled := true;
    if FNewReservation.IsQuick then
    begin
      btnFinish.Enabled := true;
      memRoomNotes.Enabled := true;
      clabRoomNotes.Visible := true;
    end
    else
    begin
      btnFinish.Enabled := false;
      memRoomNotes.Enabled := false;
      clabRoomNotes.Visible := false;
    end;
//    addAvailableRoomTypes;
  end
  else
  if pgcMain.ActivePageIndex = 2 then
  begin
    btnCancel.Enabled := true;
    btnPrevius.Enabled := true;
    btnNext.Enabled := true;

    zTotalSelected := tvSelectType.DataController.Summary.FooterSummaryValues[0];
    zTotalRoomsSelected := tvSelectType.DataController.Summary.FooterSummaryValues[4]; // 4
    zTotalAvailable := tvSelectType.DataController.Summary.FooterSummaryValues[3]; // 3
    zTotalFree := tvSelectType.DataController.Summary.FooterSummaryValues[2]; // 2
    zTotalNoRooms := tvSelectType.DataController.Summary.FooterSummaryValues[1]; // 1

    zTotal := zTotalSelected + zTotalRoomsSelected + zTotalAvailable + zTotalFree + zTotalNoRooms;
    labTotalSelected.Caption := inttostr(zTotalSelected);

    labTotalRoomsSelected.Caption := inttostr(zTotalRoomsSelected);

    if FNewReservation.IsQuick then
    begin
      btnFinish.Enabled := true;
      memRoomNotes.Enabled := true;
      clabRoomNotes.Visible := true;
    end
    else
    begin
      btnFinish.Enabled := false;
      memRoomNotes.Enabled := false;
      clabRoomNotes.Visible := false;
      getSelectRooms;
    end;

  end
  else
    if pgcMain.ActivePageIndex = 3 then
  begin
    if not FNewReservation.IsQuick then
    begin
      if ((zTotalSelected > 0) and (zTotalRoomsSelected = 0))
        OR ((zTotalSelected = 0) and (zTotalNoRooms > 0))
      then
      begin
        SetAllAsNoRoom(false);
      end;
    end;

    btnCancel.Enabled := true;
    btnPrevius.Enabled := true;
    btnNext.Enabled := false;
    if FNewReservation.IsQuick then
    begin
      btnFinish.Enabled := true;
      memRoomNotes.Enabled := true;
      clabRoomNotes.Visible := true;
    end
    else
    begin
      btnFinish.Enabled := false;
      memRoomNotes.Enabled := false;
      clabRoomNotes.Visible := false;
    end;
    if FNewReservation.IsQuick then
    begin
      if zIsFirstTime then
        if NOT CreateRoomRes_Quick then
        begin
          Close;
          exit;
        end;
    end
    else
    begin
      CreateRoomRes_Normal;
    end;
    GetPrices;
  end;
end;

// ##############################################################################################################
// ##############################################################################################################

procedure TfrmMakeReservationQuick.mExtrasCalcFields(DataSet: TDataSet);
begin
  mExtrasTotalprice.AsFloat := mExtrasPricePerItemPerDay.AsFloat * mExtrasCount.AsInteger * DaysBetween(mExtrasFromDate.AsDateTime, mExtrasToDate.AsDateTime);
end;

procedure TfrmMakeReservationQuick.mnuFinishAndShowClick(Sender: TObject);
begin
  Apply;
  FNewReservation.ShowProfile := true;

  Close;
  modalresult := mrok;
end;

procedure TfrmMakeReservationQuick.mRoomResDSDataChange(Sender: TObject; Field: TField);
begin
//
end;

procedure TfrmMakeReservationQuick.addAvailableRoomTypes;
var
  rSet: TRoomerDataSet;
  i: integer;
  s: string;

  RoomType: string;

  dateFrom: TDate;
  dateTo: TDate;
  ADate: TDate;
  Status: string;
  isNoRoom: boolean;
  RoomCount: integer;
  DateCount: integer;

  TotalNotFree: integer;

  bExcluteWaitingList: boolean;
  bExcluteWaitingListNonOptional: boolean;
  bExcluteAllotment: boolean;
  bExcluteOrder: boolean;
  bExcluteDeparted: boolean;
  bExcluteGuest: boolean;
  bExcluteBlocked: boolean;
  bExcluteNoshow: boolean;

  MaxFree: integer;
  MinAvailable: integer;
  OccTotal: integer;
  nrTotal: integer;

  tmpRoomType: string;
  tmpDescription: string;

begin
  mOcc_.DisableControls;
  try
    screen.Cursor := crHourGlass;
    try
      dateFrom := dtArrival.date;
      dateTo := dtDeparture.date;
      DateCount := trunc(dateTo) - trunc(dateFrom);

      if m_.active then
        m_.Close;
      m_.Open;

      s := '';
      s := s + 'SELECT rt.RoomType,rt.Description,  ';
      s := s + '(SELECT COUNT(Room) FROM rooms WHERE rooms.RoomType=rt.RoomType) AS NumRooms ';
      s := s + 'FROM roomtypes rt ';
      s := s + 'ORDER BY rt.RoomType ';

      rSet := createNewDataSet;
      try
        rSet_bySQL(rSet, s);

        ADate := dateFrom;
        for i := 1 to DateCount do
        begin
          rSet.First;
          while not rSet.eof do
          begin
            m_.append;
            m_.FieldByName('RoomType').AsString := rSet.FieldByName('RoomType').AsString;
            m_.FieldByName('Description').AsString := rSet.FieldByName('Description').AsString;
            m_.FieldByName('MaxFree').AsInteger := rSet.FieldByName('NumRooms').AsInteger;
            m_.FieldByName('aDate').AsDateTime := ADate;
            m_.post;
            rSet.next;
          end;
          ADate := ADate + 1;
        end;
      finally
        FreeAndNil(rSet);
      end;

      s := '';
      s := s + 'SELECT ';
      s := s + '    ADate ';
      s := s + '  , RoomType ';
      s := s + '  , isNoRoom ';
      s := s + '  , ResFlag ';
      s := s + '  , COUNT(Room) AS RoomCount ';
      s := s + 'FROM ';
      s := s + '  roomsdate ';
      s := s + 'WHERE ';
      s := s + '  ((ADate >= ' + _db(dateFrom) + ') AND (ADate <= ' + _db(dateTo) + ')) ';
      s := s + '   AND (ResFlag <> ' + _db(STATUS_DELETED) + ' ) '; // **zxhj line added
      s := s + '   AND (ResFlag <> ' + _db(STATUS_CANCELED) + ' ) '; // **zxhj line added

      s := s + 'GROUP BY ';
      s := s + '    ADate ';
      s := s + '  , RoomType ';
      s := s + '  , ResFlag ';
      s := s + '  , isNoRoom ';
      s := s + 'ORDER BY ';
      s := s + '  RoomType,ADate DESC';

      if mOcc_.active then
        mOcc_.Close;
      mOcc_.Open;

      rSet := createNewDataSet;
      try
        rSet_bySQL(rSet, s);
        rSet.First;
        while not rSet.eof do
        begin
          ADate := _DBDateToDate(rSet.FieldByName('aDate').AsString);
          RoomType := rSet.FieldByName('RoomType').AsString;
          Status := rSet.FieldByName('ResFlag').AsString;
          isNoRoom := rSet.FieldByName('isNoRoom').AsBoolean;
          RoomCount := rSet.FieldByName('RoomCount').AsInteger;

          mOcc_.append;
          mOcc_.FieldByName('RoomType').AsString := RoomType;
          mOcc_.FieldByName('Status').AsString := Status;
          mOcc_.FieldByName('aDate').AsDateTime := ADate;;
          mOcc_.FieldByName('isNoRoom').AsBoolean := isNoRoom;
          mOcc_.FieldByName('RoomCount').AsInteger := RoomCount;
          mOcc_.post;

          if m_.Locate('aDate;RoomType', VarArrayOf([ADate, RoomType]), []) then
          begin
            m_.edit;
            if isNoRoom then
            begin
              m_.FieldByName('nrTotal').AsInteger := m_.FieldByName('nrTotal').AsInteger + RoomCount;
              if Status = 'P' then
                m_.FieldByName('nrOrder').AsInteger := m_.FieldByName('nrOrder').AsInteger + RoomCount;
              if Status = 'L' then
                m_.FieldByName('nrWaitingListNonOptional').AsInteger := m_.FieldByName('nrWaitingListNonOptional').AsInteger + RoomCount;
              if Status = 'G' then
                m_.FieldByName('nrGuest').AsInteger := m_.FieldByName('nrGuest').AsInteger + RoomCount;
              if Status = 'D' then
                m_.FieldByName('nrDeparted').AsInteger := m_.FieldByName('nrDeparted').AsInteger + RoomCount;
              if Status = 'O' then
                m_.FieldByName('nrWaitingList').AsInteger := m_.FieldByName('nrWaitingList').AsInteger + RoomCount;
              if Status = 'A' then
                m_.FieldByName('nrAllotment').AsInteger := m_.FieldByName('nrAllotment').AsInteger + RoomCount;
              if Status = 'B' then
                m_.FieldByName('nrBlocked').AsInteger := m_.FieldByName('nrBlocked').AsInteger + RoomCount;
              if Status = 'N' then
                m_.FieldByName('nrNoShow').AsInteger := m_.FieldByName('nrNoShow').AsInteger + RoomCount;
            end
            else
            begin
              m_.FieldByName('occTotal').AsInteger := m_.FieldByName('occTotal').AsInteger + RoomCount;
              if Status = 'P' then
                m_.FieldByName('occOrder').AsInteger := m_.FieldByName('occOrder').AsInteger + RoomCount;
              if Status = 'L' then
                m_.FieldByName('occWaitingListNonOptional').AsInteger := m_.FieldByName('occWaitingListNonOptional').AsInteger + RoomCount;
              if Status = 'G' then
                m_.FieldByName('occGuest').AsInteger := m_.FieldByName('occGuest').AsInteger + RoomCount;
              if Status = 'D' then
                m_.FieldByName('occDeparted').AsInteger := m_.FieldByName('occDeparted').AsInteger + RoomCount;
              if Status = 'O' then
                m_.FieldByName('occWaitingList').AsInteger := m_.FieldByName('occWaitingList').AsInteger + RoomCount;
              if Status = 'A' then
                m_.FieldByName('occAllotment').AsInteger := m_.FieldByName('occAllotment').AsInteger + RoomCount;
              if Status = 'B' then
                m_.FieldByName('occBlocked').AsInteger := m_.FieldByName('occBlocked').AsInteger + RoomCount;
              if Status = 'N' then
                m_.FieldByName('occNoShow').AsInteger := m_.FieldByName('occNoShow').AsInteger + RoomCount;
            end;
            m_.post;
          end;
          rSet.next;
        end;
      finally
        FreeAndNil(rSet);
      end;
      mOcc_.First;

      bExcluteWaitingList := chkExcluteWaitingList.Checked;
      bExcluteWaitingListNonOptional := chkExcludeWaitingListNonOptional.Checked;
      bExcluteAllotment := chkExcluteAllotment.Checked;
      bExcluteOrder := chkExcluteOrder.Checked;
      bExcluteDeparted := chkExcluteDeparted.Checked;
      bExcluteGuest := chkExcluteGuest.Checked;
      bExcluteBlocked := chkExcluteBlocked.Checked;
      bExcluteNoshow := chkExcluteNoShow.Checked;

      m_.SortedField := 'RoomType';
      m_.First;
      while not m_.eof do
      begin
        MaxFree := m_.FieldByName('MaxFree').AsInteger;
        OccTotal := m_.FieldByName('occTotal').AsInteger;
        nrTotal := m_.FieldByName('nrTotal').AsInteger;
        TotalNotFree := MaxFree - OccTotal - nrTotal;
        if bExcluteWaitingList then
          TotalNotFree := TotalNotFree + m_.FieldByName('nrWaitingList').AsInteger;
        if bExcluteWaitingListNonOptional then
          TotalNotFree := TotalNotFree + m_.FieldByName('nrWaitingListNonOptional').AsInteger;
        if bExcluteAllotment then
          TotalNotFree := TotalNotFree + m_.FieldByName('nrAllotment').AsInteger;
        if bExcluteOrder then
          TotalNotFree := TotalNotFree + m_.FieldByName('nrOrder').AsInteger;
        if bExcluteDeparted then
          TotalNotFree := TotalNotFree + m_.FieldByName('nrDeparted').AsInteger;
        if bExcluteGuest then
          TotalNotFree := TotalNotFree + m_.FieldByName('nrGuest').AsInteger;
        if bExcluteBlocked then
          TotalNotFree := TotalNotFree + m_.FieldByName('nrBlocked').AsInteger;
        if bExcluteNoshow then
          TotalNotFree := TotalNotFree + m_.FieldByName('nrNoShow').AsInteger;

        m_.edit;
        m_.FieldByName('FreeRooms').AsInteger := TotalNotFree;
        m_.post;
        m_.next;
      end;
      m_.SortedField := 'RoomType';
      m_.First;

      if mSelectTypes.active then
        mSelectTypes.Close;
      mSelectTypes.Open;

      m_.SortedField := 'RoomType';
      m_.First;

      tmpRoomType := m_.FieldByName('RoomType').AsString;
      tmpDescription := m_.FieldByName('RoomType').AsString;
      MinAvailable := 1000;
      while not m_.eof do
      begin
        if tmpRoomType <> m_.FieldByName('RoomType').AsString then
        begin
          mSelectTypes.append;
          mSelectTypes.FieldByName('RoomType').AsString := tmpRoomType;
          mSelectTypes.FieldByName('RoomTypeDescription').AsString := tmpDescription;
          mSelectTypes.FieldByName('Available').AsInteger := MinAvailable;
          mSelectTypes.FieldByName('Selected').AsInteger := 0;
          mSelectTypes.FieldByName('NoRooms').AsInteger := 0;
          mSelectTypes.post;
          tmpRoomType := m_.FieldByName('RoomType').AsString;
          tmpDescription := m_.FieldByName('Description').AsString;
          MinAvailable := 1000;
        end;
        if m_.FieldByName('FreeRooms').AsInteger <= MinAvailable then
          MinAvailable := m_.FieldByName('FreeRooms').AsInteger;
        m_.next;
        if m_.eof then
        begin
          mSelectTypes.append;
          mSelectTypes.FieldByName('RoomType').AsString := m_.FieldByName('RoomType').AsString;
          mSelectTypes.FieldByName('RoomTypeDescription').AsString := m_.FieldByName('Description').AsString;
          mSelectTypes.FieldByName('Available').AsInteger := MinAvailable;
          mSelectTypes.FieldByName('Selected').AsInteger := 0;
          mSelectTypes.FieldByName('NoRooms').AsInteger := 0;
          mSelectTypes.post;
        end;
      end;

      // Add PriorityRule

      s := '';
      s := s + 'SELECT ';
      s := s + '  RoomType ';
      s := s + ' ,PriorityRule ';
      s := s + 'FROM roomtypes ';

      rSet := createNewDataSet;
      try
        rSet_bySQL(rSet, s);
        rSet.First;
        while not rSet.eof do
        begin
          RoomType := rSet.FieldByName('RoomType').AsString;
          if mSelectTypes.Locate('RoomType', RoomType, []) then
          begin
            mSelectTypes.edit;
            mSelectTypes.FieldByName('PriorityRule').AsString := rSet.FieldByName('PriorityRule').AsString;
            mSelectTypes.post;
          end;
          rSet.next;
        end;
      finally
        FreeAndNil(rSet);
      end;
    finally
      screen.Cursor := crDefault;
    end;

  finally
    mOcc_.EnableControls;
  end;

end;

procedure TfrmMakeReservationQuick.CreateRoomRes_Normal;
var
  oSelectedRoomItem: TnewRoomReservationItem;
  room: string;
  RoomType: string;
  NumberGuests: integer;
  Arrival: TDate;
  Departure: TDate;

  NumberNoRoom: integer;

  i: integer;

  RoomCount: integer;
  childrenCount: integer;
  infantCount: integer;

  RoomReservation: integer;

  RoomDescription: string;
  RoomTypeDescription: string;
  PriceCode: string;

  sID: string;
  lstIDs: TstringList;
begin
  RoomReservation := 0;
  FNewReservation.newRoomReservations.RoomItemsList.Clear;

  Arrival := dtArrival.date;
  Departure := dtDeparture.date;
  PriceCode := Trim(edPcCode.Text);

  if not((zTotalSelected = 0) and (zTotalNoRooms > 0)) and (zTotal <> 0) then
  begin
    mSelectRooms.First;
    while not mSelectRooms.eof do
    begin
      if mSelectRoomsSelect.AsBoolean then
      begin
        room := mSelectRooms.FieldByName('room').AsString;
        RoomType := mSelectRooms.FieldByName('RoomType').AsString;
        NumberGuests := mSelectRooms.FieldByName('NumberGuests').AsInteger;
        oSelectedRoomItem := TnewRoomReservationItem.Create(0, room, RoomType, '', Arrival, Departure, NumberGuests, 0, 0, true, 0, 0, 0, '', '', '');
        FNewReservation.newRoomReservations.RoomItemsList.Add(oSelectedRoomItem);
      end;
      mSelectRooms.next;
    end;
    mSelectRooms.First;
  end;


  mSelectTypes.First;
  while not mSelectTypes.eof do
  begin
    RoomType := mSelectTypes.FieldByName('RoomType').AsString;
    NumberNoRoom := mSelectTypes.FieldByName('NoRooms').AsInteger;
    if (NumberNoRoom > 0) then
    begin
      room := '';
      NumberGuests := glb.GET_RoomTypeNumberGuests_byRoomType(RoomType);
      for i := 1 to NumberNoRoom do
      begin
        oSelectedRoomItem := TnewRoomReservationItem.Create(0, room, RoomType, '', Arrival, Departure, NumberGuests, 0,
          0, true, 0, 0, 0, '', '', '');
        FNewReservation.newRoomReservations.RoomItemsList.Add(oSelectedRoomItem);
      end;
    end;
    mSelectTypes.next;
  end;
  mSelectTypes.First;

  mRoomRes.Close;
  mRoomRes.Open;
  mExtras.Open;

  RoomCount := FNewReservation.newRoomReservations.RoomCount;

  lstIDs := TstringList.Create;
  try
    sID := RR_GetIDs(RoomCount);
    _Glob._strTokenToStrings(sID, '|', lstIDs);

    for oSelectedRoomItem in FNewReservation.newRoomReservations.RoomItemsList do
    begin
      if oSelectedRoomItem.RoomReservation < 1 then
      begin
        RoomReservation := strToInt(lstIDs[0]); // RR_SetNewID();
        lstIds.Delete(0);
        oSelectedRoomItem.RoomReservation := RoomReservation;
      end;

      room := oSelectedRoomItem.RoomNumber;
      if room = '' then
        room := '<' + inttostr(RoomReservation) + '>';

      Arrival := oSelectedRoomItem.Arrival;
      Departure := oSelectedRoomItem.Departure;
      NumberGuests := oSelectedRoomItem.guestCount;
      childrenCount := oSelectedRoomItem.childrenCount;
      infantCount := oSelectedRoomItem.infantCount;
      RoomType := oSelectedRoomItem.RoomType;

      RoomDescription := '';
      RoomTypeDescription := '';

      if not(zTotalSelected = 0) and (zTotalNoRooms > 0) then
      begin
        if mSelectRooms.Locate('RoomType', RoomType, []) then
        begin
          RoomDescription := mSelectRooms.FieldByName('Description').AsString;
          RoomTypeDescription := mSelectRooms.FieldByName('RoomTypeDescription').AsString;
        end;
      end;

      if (copy(room, 1, 1)) = '<' then
      begin
        // It is noroom
        // There is no roomdescription
        // .. Get the roomType Description
        RoomTypeDescription := glb.GetRoomTypeDescription(RoomType);
        if NumberGuests = 0 then
          NumberGuests := glb.GET_RoomTypeNumberGuests_byRoomType(RoomType);
      end;

      mRoomRes.append;
      try
        mRoomResRoomReservation.AsInteger := RoomReservation;
        mRoomResroom.AsString := room;
        mRoomResRoomType.AsString := RoomType;
        mRoomResGuests.AsInteger := NumberGuests;
        mRoomResAvragePrice.AsFloat := 0;
        mRoomResRateCount.AsFloat := 0;
        mRoomResAvrageDiscount.AsFloat := 0;
        mRoomResisPercentage.AsBoolean := true;

        mRoomResManualChannelId.AsInteger := 0;
        mRoomResratePlanCode.AsString := '';

        mRoomResRoomDescription.AsString := RoomDescription;
        mRoomResRoomTypeDescription.AsString := RoomTypeDescription;
        mRoomResarrival.AsDateTime := Arrival;
        mRoomResdeparture.AsDateTime := Departure;
        mRoomResChildrenCount.AsInteger := childrenCount;
        mRoomResInfantCount.AsInteger := infantCount;
        mRoomResPriceCode.AsString := PriceCode;
        mRoomResPersonsProfilesId.AsInteger := edtPortfolio.Tag;
        if chkContactIsGuest.Checked AND (Trim(edContactPerson.Text) <> '') then
          mRoomResMainGuest.AsString := edContactPerson.Text
        else if (Trim(edtPortfolio.Text) <> '') then
          mRoomResMainGuest.AsString := edtPortfolio.Text
        else
          mRoomResMainGuest.AsString := edReservationName.Text;
        mRoomRes.post;
      except
        mRoomRes.Cancel;
        raise;
      end;
    end; //for

  finally
    FreeAndNil(lstIDs);
  end;

  if mRoomRes.RecordCount > 0 then
  begin
    btnFinish.Enabled := true;
    memRoomNotes.Enabled := true;
    clabRoomNotes.Visible := true;

    mRoomRes.First;
  end;
end;

function TfrmMakeReservationQuick.CreateRoomRes_Quick: boolean;
var
  rSetRooms: TRoomerDataSet;
  i: integer;

  s: string;

  Arrival: TDateTime;
  Departure: TDateTime;

  RoomReservation: integer;
  room: string;
  RoomType: string;
  Guests: integer;

  RoomDescription: string;
  RoomTypeDescription: string;
  childrenCount: integer;
  infantCount: integer;
  RoomCount: integer;

  PriceCode: string;

  defaultGuests: integer;

  sID: string;
  lstIDs: TstringList;
  sRoomsInList: string;
  sRoomTypes: TStrings;
  sMessage: String;

  ExecutionPlan: TRoomerExecutionPlan;

  AvailabilityPerDay: TAvailabilityPerDay;

  lRoomReservation: TnewRoomReservationItem;

begin
  Result := true;
  RoomReservation := 0;
  PriceCode := Trim(edPcCode.Text);

  if mRoomRes.active then
    mRoomRes.Close;
  mRoomRes.Open;
  mExtras.Open;
  RoomCount := FNewReservation.newRoomReservations.RoomCount;

  lstIDs := TstringList.Create;
  try

    sID := RR_GetIDs(RoomCount);
    _Glob._strTokenToStrings(sID, '|', lstIDs);

    sRoomsInList := '';

    for i := 0 to RoomCount - 1 do
    begin
      room := FNewReservation.newRoomReservations.RoomItemsList[i].RoomNumber;
      if room <> '' then
      begin
        sRoomsInList := sRoomsInList + _db(room) + ',';
      end;
    end;

    if sRoomsInList <> '' then
      Delete(sRoomsInList, length(sRoomsInList), 1);

    s := '';
    s := s + ' SELECT ' + #10;
    s := s + '     rooms.Room ' + #10;
    s := s + '   , rooms.Description AS RoomDescription ' + #10;
    s := s + '   , rooms.RoomType ' + #10;
    s := s + '   , roomtypes.NumberGuests ' + #10;
    s := s + '   , roomtypes.Description AS RoomTypeDescription ' + #10;
    s := s + ' FROM ' + #10;
    s := s + '   rooms ' + #10;
    s := s + '   LEFT OUTER JOIN roomtypes ON rooms.RoomType = roomtypes.RoomType ' + #10;
    s := s + ' WHERE ' + #10;
    s := s + '   (rooms.Room in (' + sRoomsInList + '))' + #10;

    ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
    try
      ExecutionPlan.AddQuery(s);
      ExecutionPlan.Execute(ptQuery);
      rSetRooms := ExecutionPlan.Results[0];

      for i := 0 to FNewReservation.newRoomReservations.RoomItemsList.Count-1 do
      begin
        lRoomReservation := FNewReservation.newRoomReservations.RoomItemsList[i];
        if lRoomReservation.RoomReservation < 1 then
        begin
          RoomReservation := strToInt(lstIDs[i]); // RR_SetNewID();
          lRoomReservation.RoomReservation := RoomReservation;
        end;

        room := lRoomReservation.RoomNumber;
        if room = '' then
        begin
          room := '<' + inttostr(RoomReservation) + '>';
          RoomType := lRoomReservation.RoomType;
        end;

        Arrival := lRoomReservation.Arrival;
        Departure := lRoomReservation.Departure;
        childrenCount := lRoomReservation.childrenCount;
        infantCount := lRoomReservation.infantCount;

        if (copy(room, 1, 1)) <> '<' then
        begin
          rSetRooms.Locate('room', room, []);
          RoomDescription := rSetRooms.FieldByName('RoomDescription').AsString;
          RoomType := rSetRooms.FieldByName('RoomType').AsString;
          lRoomReservation.RoomType := RoomType;
          defaultGuests := rSetRooms.FieldByName('NumberGuests').AsInteger;
          RoomTypeDescription := rSetRooms.FieldByName('RoomTypeDescription').AsString;
        end
        else
        begin // It is noroom
          // There is no roomdescription
          // .. Get the roomType Description
          RoomTypeDescription := glb.GetRoomTypeDescription(RoomType);
          defaultGuests := glb.GET_RoomTypeNumberGuests_byRoomType(RoomType);
        end;

        Guests := defaultGuests;

        mRoomRes.append;
        try
          mRoomResRoomReservation.AsInteger := RoomReservation;
          mRoomResroom.AsString := room;
          mRoomResRoomType.AsString := RoomType;
          mRoomResGuests.AsInteger := Guests;
          mRoomResAvragePrice.AsFloat := 0;
          mRoomResRateCount.AsFloat := 0;
          mRoomResAvrageDiscount.AsFloat := 0;

          mRoomResManualChannelId.AsInteger := 0;
          mRoomResratePlanCode.AsString := '';

          mRoomResRoomDescription.AsString := RoomDescription;
          mRoomResRoomTypeDescription.AsString := RoomTypeDescription;
          mRoomResarrival.AsDateTime := Arrival;
          mRoomResdeparture.AsDateTime := Departure;
          mRoomResChildrenCount.AsInteger := childrenCount;
          mRoomResInfantCount.AsInteger := infantCount;
          mRoomResPriceCode.AsString := PriceCode;
          mRoomResPersonsProfilesId.AsInteger := edtPortfolio.Tag;

          if chkContactIsGuest.Checked AND (Trim(edContactPerson.Text) <> '') then
            mRoomResMainGuest.AsString := edContactPerson.Text
          else if (Trim(edtPortfolio.Text) <> '') then
            mRoomResMainGuest.AsString := edtPortfolio.Text
          else
            mRoomResMainGuest.AsString := edReservationName.Text;

          mRoomRes.post;

        except
          mRoomRes.Cancel;
          raise;
        end;
      end;
      zIsFirstTime := false;

      if g.qWarnWhenOverbooking then
      begin
        sMessage := '';
        AvailabilityPerDay := TAvailabilityPerDay.Create(dtArrival.date, dtDeparture.date, FNewReservation);
        sRoomTypes := AvailabilityPerDay.Overbookings;
        try
          sMessage := sRoomTypes.Text;
        finally
          sRoomTypes.Free;
          AvailabilityPerDay.Free;
        end;
        if sMessage <> '' then
        begin
          s := GetTranslatedText('shTx_Various_WouldCreateOverbooking') +
            sMessage + #10#10 +
            GetTranslatedText('shTx_Various_AreYoySureYouWantToContinue');
          if MessageDlg(s, mtWarning, [mbYes, mbCancel], 0) <> mrYes then
            Result := false;
        end;
      end;

    finally
      FreeAndNil(ExecutionPlan);
    end;

  finally
    FreeAndNil(lstIDs);
  end;
end;

procedure TfrmMakeReservationQuick.PopulateRatePlanCombo(clearAll: boolean = true);
begin
  if clearAll then
  begin
    (tvRoomResRatePlanCode.Properties AS TcxComboBoxProperties).Items.Clear;
    (tvRoomResRatePlanCode.Properties AS TcxComboBoxProperties).Items.Add('');
  end;
  FDynamicRates.GetAllRateCodes((tvRoomResRatePlanCode.Properties AS TcxComboBoxProperties).Items);
end;

procedure TfrmMakeReservationQuick.GetPrices;
var
  lstPrices: TstringList;
  RoomReservation: integer;

  i, ii: integer;

  room: string;
  RoomType: string;
  Guests: integer;
  AvragePrice: double;
  RateCount: integer;
  RoomDescription: string;
  RoomTypeDescription: string;
  Arrival: TDateTime;
  Departure: TDateTime;
  childrenCount: integer;
  infantCount: integer;
  DiscountAmount: double;
  RentAmount: double;
  NativeAmount: double;

  priceID: integer;
  PriceCode: string;

  rateTotal: double;
  rateAvrage: double;

  dayCount: integer;
  ADate: TDateTime;
  dateFrom: TDate;
  dateTo: TDate;

  RateDate: TDateTime;
  Rate: double;

  isPercentage: boolean;
  isPaid: boolean;

  Currency: string;
  CurrencyRate: double;
  Discount: double;
  ShowDiscount: boolean;

  discountTotal: double;
  discountAvrage: double;

  rateSet: TRoomerDataSet;

  s: string;
  lstRoomTypes: TstringList;
  inStrRoomTypes: string;
  andRoomTypes: String;

  FirstArrival: TDate;
  LastDeparture: TDate;

  roomPrice: double;

  price1p: double;
  price2p: double;
  price3p: double;
  price4p: double;
  price5p: double;
  price6p: double;
  priceEp: double;
  PriceEc: double;
  PriceEi: double;

  function finalPrice(p1, p2, p3, p4, p5, p6, Ep, Ec, Ei: double; guestCount, ChildCount, infantCount: integer): double;
  var
    extraPersons: double;
  begin
    extraPersons := guestCount - 5;

    if p1 = 0 then
      p1 := Ep;
    if p2 = 0 then
      p2 := p1 + Ep;
    if p3 = 0 then
      p3 := p2 + Ep;
    if p4 = 0 then
      p4 := p3 + Ep;
    if p5 = 0 then
      p5 := p4 + Ep;
    if p6 = 0 then
      p6 := p5 + Ep;

    Result := 0;
    if guestCount = 1 then
      Result := p1;
    if guestCount = 2 then
      Result := p2;
    if guestCount = 3 then
      Result := p3;
    if guestCount = 4 then
      Result := p4;
    if guestCount = 5 then
      Result := p5;
    if guestCount = 6 then
      Result := p6;

    if guestCount > 6 then
      Result := p6 + (extraPersons * Ep);

    Result := Result + (Ec * ChildCount);
    Result := Result + (Ei * infantCount);
  end;

var
  rateId: String;
  channelId: integer;
begin
  channelId := 0;
  if edtRatePlans.ItemIndex > 0 then
    channelId := integer(edtRatePlans.Items.Objects[edtRatePlans.ItemIndex]);
  isPaid := false;
  mRoomRes.DisableControls;
  lstPrices := TstringList.Create;
  lstRoomTypes := TstringList.Create;

  rateSet := createNewDataSet;
  try

    lstRoomTypes.Sorted := true;
    lstRoomTypes.Duplicates := dupIgnore;

    mRoomRes.First;
    if not mRoomRes.eof then
    begin
      FirstArrival := mRoomRes.FieldByName('Arrival').AsDateTime;
      LastDeparture := mRoomRes.FieldByName('departure').AsDateTime;
      while not mRoomRes.eof do
      begin
        if mRoomRes.FieldByName('Arrival').AsDateTime < FirstArrival then
          FirstArrival := mRoomRes.FieldByName('Arrival').AsDateTime;
        if mRoomRes.FieldByName('Departure').AsDateTime > LastDeparture then
          LastDeparture := mRoomRes.FieldByName('Departure').AsDateTime;
        RoomType := mRoomRes.FieldByName('RoomType').AsString;
        lstRoomTypes.Add(_db(RoomType));
        mRoomRes.next;
      end;
    end;

    inStrRoomTypes := '';
    for i := 0 to lstRoomTypes.Count - 1 do
    begin
      inStrRoomTypes := inStrRoomTypes + lstRoomTypes[i];
      if i <> lstRoomTypes.Count - 1 then
        inStrRoomTypes := inStrRoomTypes + ',';
    end;

    s := '';
    s := s + 'SELECT '#10;
    s := s + '    `roomrates`.`ID` AS `ID`, '#10;
    s := s + '    `roomrates`.`PriceCodeID` AS `PriceCodeID`, '#10;
    s := s + '    `tblpricecodes`.`pcCode` AS `pcCode`, '#10;
    s := s + '    `tblpricecodes`.`pcRack` AS `pcRack`, '#10;
    s := s + '    `roomrates`.`CurrencyID` AS `CurrencyID`, '#10;
    s := s + '    `currencies`.`Currency` AS `Currency`, '#10;
    s := s + '    `roomrates`.`SeasonID` AS `SeasonID`, '#10;
    s := s + '    `tblseasons`.`seStartDate` AS `seStartDate`, '#10;
    s := s + '    `tblseasons`.`seEndDate` AS `seEndDate`, '#10;
    s := s + '    `tblseasons`.`seDescription` AS `seDescription`, '#10;
    s := s + '    `roomrates`.`RoomTypeID` AS `RoomTypeID`, '#10;
    s := s + '    `roomtypes`.`RoomType` AS `RoomType`, '#10;
    s := s + '    `roomtypes`.`NumberGuests` AS `NumberGuests`, '#10;
    s := s + '    `roomrates`.`RateID` AS `RateID`, '#10;
    s := s + '    `rates`.`Currency` AS `RateCurrency`, '#10;
    s := s + '    `rates`.`Rate1Person` AS `Rate1Person`, '#10;
    s := s + '    `rates`.`Rate2Persons` AS `Rate2Persons`, '#10;
    s := s + '    `rates`.`Rate3Persons` AS `Rate3Persons`, '#10;
    s := s + '    `rates`.`Rate4Persons` AS `Rate4Persons`, '#10;
    s := s + '    `rates`.`Rate5Persons` AS `Rate5Persons`, '#10;
    s := s + '    `rates`.`Rate6Persons` AS `Rate6Persons`, '#10;
    s := s + '    `rates`.`RateExtraPerson` AS `RateExtraPerson`, '#10;
    s := s + '    `rates`.`RateExtraChildren` AS `RateExtraChildren`, '#10;
    s := s + '    `rates`.`RateExtraInfant` AS `RateExtraInfant`, '#10;
    s := s + '    `rates`.`Description` AS `rateDescription`, '#10;
    s := s + '    `roomrates`.`Active` AS `Active`, '#10;
    s := s + '    `roomrates`.`DateFrom` AS `DateFrom`, '#10;
    s := s + '    `roomrates`.`DateTo` AS `DateTo`, '#10;
    s := s + '    `roomrates`.`Description` AS `Description`, '#10;
    s := s + '    `roomrates`.`DateCreated` AS `DateCreated`, '#10;
    s := s + '    `roomrates`.`LastModified` AS `LastModified`, '#10;
    s := s + '   DATEDIFF(DateTo,DateFrom) AS DateCount '#10;

    s := s + 'FROM predefineddates, '#10;
    s := s + '    (((((`roomrates` '#10;
    s := s + '    left join `tblpricecodes` ON ((`roomrates`.`PriceCodeID` = `tblpricecodes`.`ID`))) '#10;
    s := s + '    left join `rates` ON ((`roomrates`.`RateID` = `rates`.`ID`))) '#10;
    s := s + '    left join `tblseasons` ON ((`roomrates`.`SeasonID` = `tblseasons`.`ID`))) '#10;
    s := s + '    left join `roomtypes` ON ((`roomrates`.`RoomTypeID` = `roomtypes`.`ID`))) '#10;
    s := s + '    left join `currencies` ON ((`roomrates`.`CurrencyID` = `currencies`.`ID`))) '#10;
    s := s + 'WHERE '#10;
    s := s + '       predefineddates.date >= %s AND predefineddates.date <= %s '#10;
    s := s + '  AND  `PriceCodeID` = %d '#10;
    s := s + '  AND  currencies.Currency = %s '#10;
    s := s + '  %s '#10;
    s := s + '  AND  (`DateFrom` <= predefineddates.date AND `DateTo` >= predefineddates.date)'#10;
    s := s + 'ORDER by '#10;
    s := s + '  `roomtypes`.`RoomType` '#10;
    s := s + ' , DateCount '#10;

    lstPrices.Sorted := true;
    lstPrices.Duplicates := dupIgnore;

    Currency := edCurrency.Text;

    CurrencyRate := hData.GetRate(Currency);
    Discount := edRoomResDiscount.Value;
    ShowDiscount := true;
    isPercentage := cbxIsRoomResDiscountPrec.ItemIndex = 0;

    PriceCode := Trim(edPcCode.Text);
    priceID := hData.PriceCode_ID(PriceCode);

    andRoomTypes := '';
    if Trim(inStrRoomTypes) <> '' then
      andRoomTypes := format('AND  `RoomType` IN (%s)', [inStrRoomTypes]);

    s := format(s, [_dateToDbDate(FirstArrival, true)
      , _dateToDbDate(LastDeparture, true)
      , priceID
      , _db(Currency)
      , andRoomTypes
      ]);

    if rSet_bySQL(rateSet, s) then
    begin

    end;

    if mRoomRates.active then
      mRoomRates.Close;
    mRoomRates.Open;

    mRoomRes.First;
    while not mRoomRes.eof do
    begin
      RoomReservation := mRoomRes.FieldByName('roomReservation').AsInteger;

      i := FNewReservation.newRoomReservations.FindRoomFromRoomReservation(RoomReservation, 0);
      FNewReservation.newRoomReservations.RoomItemsList[i].oRates.RateItemsList.Clear;

      room := mRoomRes.FieldByName('room').AsString;
      Arrival := mRoomRes.FieldByName('arrival').AsDateTime;
      Departure := mRoomRes.FieldByName('departure').AsDateTime;
      RoomType := mRoomRes.FieldByName('RoomType').AsString;
      RoomTypeDescription := mRoomRes.FieldByName('RoomTypeDescription').AsString;
      RoomDescription := mRoomRes.FieldByName('RoomDescription').AsString;
      Guests := mRoomRes.FieldByName('Guests').AsInteger;
      childrenCount := mRoomRes.FieldByName('ChildrenCount').AsInteger;
      infantCount := mRoomRes.FieldByName('infantCount').AsInteger;

      dayCount := trunc(Departure) - trunc(Arrival);

      ADate := trunc(Arrival);
      rateId := '';
      rateTotal := 0;
      discountTotal := 0;
      lstPrices.Clear;
      for ii := 0 to dayCount - 1 do
      begin
        if FDynamicRates.active AND
          FDynamicRates.findRateForRoomType(trunc(Arrival) + ii, RoomType, mRoomRes['Guests'], roomPrice, rateId) then
        begin
          // Rate acuired
        end
        else
        begin
          rateSet.First;
          roomPrice := 0;
          while not rateSet.eof do
          begin
            dateFrom := rateSet.FieldByName('DateFrom').AsDateTime;
            dateTo := rateSet.FieldByName('DateTo').AsDateTime;
            if (Uppercase(RoomType) = Uppercase(rateSet.FieldByName('roomtype').AsString)) then
            begin
              if priceID = rateSet.FieldByName('PriceCodeID').AsInteger then
              begin
                if Uppercase(Currency) = Uppercase(rateSet.FieldByName('Currency').AsString) then
                begin
                  if (ADate >= dateFrom) and (ADate <= dateTo) then
                  begin
                    price1p := rateSet.GetFloatValue(rateSet.FieldByName('Rate1Person'));
                    price2p := rateSet.GetFloatValue(rateSet.FieldByName('Rate2Persons'));
                    price3p := rateSet.GetFloatValue(rateSet.FieldByName('Rate3Persons'));
                    price4p := rateSet.GetFloatValue(rateSet.FieldByName('Rate4Persons'));
                    price5p := rateSet.GetFloatValue(rateSet.FieldByName('Rate5Persons'));
                    price6p := rateSet.GetFloatValue(rateSet.FieldByName('Rate6Persons'));
                    priceEp := rateSet.GetFloatValue(rateSet.FieldByName('RateExtraPerson'));
                    PriceEc := rateSet.GetFloatValue(rateSet.FieldByName('RateExtraChildren'));
                    PriceEi := rateSet.GetFloatValue(rateSet.FieldByName('RateExtraInfant'));
                    roomPrice := finalPrice(price1p
                      , price2p
                      , price3p
                      , price4p
                      , price5p
                      , price6p
                      , priceEp
                      , PriceEc
                      , PriceEi
                      , Guests
                      , childrenCount
                      , infantCount);
                    Break;

                  end;
                end;
              end;
            end;
            rateSet.next;
          end;
        end;

        Rate := roomPrice;

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
        RentAmount := Rate - DiscountAmount;
        if CurrencyRate = 0 then
          CurrencyRate := 1;
        NativeAmount := RentAmount * CurrencyRate;

        mRoomRates.append;
        try
          mRoomRates.FieldByName('Reservation').AsInteger := -1;
          mRoomRates.FieldByName('RoomReservation').AsInteger := RoomReservation;
          mRoomRates.FieldByName('RoomNumber').AsString := room;
          mRoomRates.FieldByName('RateDate').AsDateTime := ADate;
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
        except
          mRoomRates.Cancel;
          raise;
        end;

        lstPrices.Add(floatTostr(RentAmount));
        rateTotal := rateTotal + RentAmount;
        discountTotal := discountTotal + Discount;
        ADate := ADate + 1
      end;

      rateAvrage := 0;
      discountAvrage := 0;
      if dayCount <> 0 then
      begin
        rateAvrage := rateTotal / dayCount;
        discountAvrage := discountTotal / dayCount
      end;
      RateCount := lstPrices.Count;
      mRoomRes.edit;
      try
        mRoomRes.FieldByName('AvragePrice').AsFloat := rateAvrage;
        mRoomRes.FieldByName('RateCount').AsFloat := RateCount;
        mRoomRes.FieldByName('AvrageDiscount').AsFloat := discountAvrage;
        mRoomRes.FieldByName('isPercentage').AsBoolean := isPercentage;

        mRoomRes.FieldByName('ManualChannelId').AsInteger := channelId;
        mRoomRes.FieldByName('ratePlanCode').AsString := rateId;
        mRoomRes.post;
      except
        mRoomRes.Cancel;
        raise;
      end;
      mRoomRes.next;
    end;
  finally
    FreeAndNil(rateSet);
    FreeAndNil(lstPrices);
    FreeAndNil(lstRoomTypes);
    mRoomRes.First;
    mRoomRes.EnableControls;
  end;
end;

function TfrmMakeReservationQuick.CalcOnePrice(RoomReservation: integer; NewRate: double = 0): boolean;
var
  lstPrices: TstringList;

  i, ii: integer;

  room: string;
  RoomType: string;
  Guests: integer;
  AvragePrice: double;
  RateCount: integer;
  RoomDescription: string;
  RoomTypeDescription: string;
  Arrival: TDateTime;
  Departure: TDateTime;
  childrenCount: integer;
  infantCount: integer;
  DiscountAmount: double;
  RentAmount: double;
  NativeAmount: double;

  priceID: integer;
  PriceCode: string;

  rateTotal: double;
  rateAvrage: double;

  discountTotal: double;
  discountAvrage: double;

  dayCount: integer;
  ADate: TDateTime;

  RateDate: TDateTime;
  Rate: double;

  isPercentage: boolean;
  isPaid: boolean;

  Currency: string;
  CurrencyRate: double;
  Discount: double;
  ShowDiscount: boolean;
  found: boolean;

  rateId: String;
  channelId: integer;
begin
  channelId := 0;
  if edtRatePlans.ItemIndex > 0 then
    channelId := integer(edtRatePlans.Items.Objects[edtRatePlans.ItemIndex]);
  isPaid := false;
  lstPrices := TstringList.Create;
  try
    lstPrices.Sorted := true;
    lstPrices.Duplicates := dupIgnore;

    Currency := edCurrency.Text;
    CurrencyRate := hData.GetRate(Currency);
    ShowDiscount := true;
    isPercentage := cbxIsRoomResDiscountPrec.ItemIndex = 0;

    if mRoomRes.Locate('roomreservation', RoomReservation, []) then
    begin

      repeat
        found := mRoomRates.Locate('roomreservation', RoomReservation, []);
        if found then
        begin
          mRoomRates.Delete;
        end;
      until not found;

      i := FNewReservation.newRoomReservations.FindRoomFromRoomReservation(RoomReservation, 0);
      FNewReservation.newRoomReservations.RoomItemsList[i].oRates.RateItemsList.Clear;

      room := mRoomRes.FieldByName('room').AsString;
      Arrival := mRoomRes.FieldByName('arrival').AsDateTime;
      Departure := mRoomRes.FieldByName('departure').AsDateTime;
      RoomType := mRoomRes.FieldByName('RoomType').AsString;
      RoomTypeDescription := mRoomRes.FieldByName('RoomTypeDescription').AsString;
      RoomDescription := mRoomRes.FieldByName('RoomDescription').AsString;
      Guests := mRoomRes.FieldByName('Guests').AsInteger;
      childrenCount := mRoomRes.FieldByName('ChildrenCount').AsInteger;
      infantCount := mRoomRes.FieldByName('infantCount').AsInteger;
      Discount := mRoomRes.FieldByName('avrageDiscount').AsFloat;

      PriceCode := Trim(edPcCode.Text);
      priceID := hData.PriceCode_ID(PriceCode);

      dayCount := trunc(Departure) - trunc(Arrival);
      ADate := trunc(Arrival);
      rateId := '';
      rateTotal := 0;
      discountTotal := 0;
      lstPrices.Clear;
      for ii := 0 to dayCount - 1 do
      begin
        if (NewRate <> 0) then
        begin
          Rate := NewRate;
          Discount := 0;
        end
        else
        begin
          if FDynamicRates.active AND
            FDynamicRates.findRateForRoomType(trunc(Arrival) + ii, RoomType, mRoomRes['Guests'], Rate, rateId) then
          begin
            // Rate acuired
          end
          else
          begin
            Rate := FNewReservation.newRoomReservations.RoomItemsList[i].oRates.GetDayRate
              (RoomType
              , room
              , ADate
              , Guests
              , childrenCount
              , infantCount
              , Currency
              , priceID
              , Discount
              , ShowDiscount
              , isPercentage
              , isPaid
              , false

              );
          end;
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
        RentAmount := Rate - DiscountAmount;
        if CurrencyRate = 0 then
          CurrencyRate := 1;
        NativeAmount := RentAmount * CurrencyRate;

        mRoomRates.append;
        try
          mRoomRates.FieldByName('Reservation').AsInteger := -1;
          mRoomRates.FieldByName('RoomReservation').AsInteger := RoomReservation;
          mRoomRates.FieldByName('RoomNumber').AsString := room;
          mRoomRates.FieldByName('RateDate').AsDateTime := ADate;
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
        except
          mRoomRates.Cancel;
          raise;
        end;

        lstPrices.Add(floatTostr(RentAmount));
        rateTotal := rateTotal + RentAmount;
        discountTotal := discountTotal + Discount;
        ADate := ADate + 1
      end;

      rateAvrage := 0;
      discountAvrage := 0;

      if dayCount <> 0 then
      begin
        rateAvrage := rateTotal / dayCount;
        discountAvrage := discountTotal / dayCount
      end;
      RateCount := lstPrices.Count;
      mRoomRes.edit;
      try
        mRoomRes.FieldByName('AvragePrice').AsFloat := rateAvrage;
        mRoomRes.FieldByName('RateCount').AsFloat := RateCount;
        mRoomRes.FieldByName('AvrageDiscount').AsFloat := discountAvrage;
        mRoomRes.FieldByName('isPercentage').AsBoolean := isPercentage;

        mRoomRes.FieldByName('ManualChannelId').AsInteger := channelId;
        mRoomRes.FieldByName('ratePlanCode').AsString := rateId;
        mRoomRes.post;
      except
        mRoomRes.Cancel;
        raise;
      end;
    end;
  finally
    FreeAndNil(lstPrices);
  end;
end;

function TfrmMakeReservationQuick.Apply: boolean;
var
  Customer: string;
  oSelectedRoomItem: TnewRoomReservationItem;
  room: string;
  RoomType: string;
  package: string;
  Arrival: TDateTime;
  Departure: TDateTime;
  guestCount: integer;
  RoomReservation: integer;
  AvragePrice: double;
  AvrageDiscount: double;
  isPercentage: boolean;
  RateCount: integer;
  childrenCount: integer;
  infantCount: integer;
  PriceCode: string;

  rateRoomNumber: string;
  RateDate: TDate;
  Rate: double;
  ratePriceCode: string;
  rateDiscount: double;
  rateIsPercentage: boolean;
  rateShowDiscount: boolean;
  rateIsPaid: boolean;
  rateItem: TRateItem;
  mainGuestName: string;
  RoomNotes: string;
  lReservationExtra: TReservationExtra;
begin
  Result := true;
  Customer := edCustomer.Text;
  FNewReservation.SendConfirmationEmail := chkSendConfirmation.Enabled AND chkSendConfirmation.Checked;
  FNewReservation.HomeCustomer.Customer := Customer;

  if chkContactIsGuest.Checked then
  begin
    if Trim(edContactPerson.Text) = '' then
    begin
      FNewReservation.HomeCustomer.GuestName := GetTranslatedText('MainGuestConstant_Version_1');
    end
    else
    begin
      FNewReservation.HomeCustomer.GuestName := edContactPerson.Text;
    end;
  end
  else
  begin
    FNewReservation.HomeCustomer.GuestName := GetTranslatedText('MainGuestConstant_Version_1');
  end;

  FNewReservation.HomeCustomer.invRefrence := edInvRefrence.Text;
  FNewReservation.HomeCustomer.Country := edCountry.Text;
  FNewReservation.HomeCustomer.ReservationName := edReservationName.Text;
  FNewReservation.HomeCustomer.RoomStatus := RoomStatusToInfo(cbxRoomStatus.ItemIndex);
  FNewReservation.HomeCustomer.MarketSegmentCode := edMarketSegmentCode.Text;
  FNewReservation.HomeCustomer.IsGroupInvoice := chkisGroupInvoice.Checked;
  FNewReservation.HomeCustomer.Currency := edCurrency.Text;
  FNewReservation.HomeCustomer.PcCode := edPcCode.Text;
  FNewReservation.HomeCustomer.PID := edPID.Text;
  FNewReservation.HomeCustomer.CustomerName := edCustomerName.Text;
  FNewReservation.HomeCustomer.Address1 := edAddress1.Text;
  FNewReservation.HomeCustomer.Address2 := edAddress2.Text;
  FNewReservation.HomeCustomer.Address3 := edAddress3.Text;
  FNewReservation.HomeCustomer.Tel1 := edTel1.Text;
  FNewReservation.HomeCustomer.Tel2 := edTel2.Text;
  FNewReservation.HomeCustomer.Fax := edFax.Text;
  FNewReservation.HomeCustomer.EmailAddress := edEmailAddress.Text;
  FNewReservation.HomeCustomer.HomePage := edHomePage.Text;
  FNewReservation.HomeCustomer.ContactPhone := edContactPhone.Text;
  FNewReservation.HomeCustomer.ContactPerson := edContactPerson.Text;
  FNewReservation.HomeCustomer.ContactAddress1 := edContactAddress1.Text;
  FNewReservation.HomeCustomer.ContactAddress2 := edContactAddress2.Text;
  FNewReservation.HomeCustomer.ContactAddress3 := edContactAddress3.Text;
  FNewReservation.HomeCustomer.ContactAddress4 := edContactAddress4.Text;
  // 0810-hj   FNewReservation.HomeCustomer.ContactCountry         := edContactCountry.text   ;
  FNewReservation.HomeCustomer.ContactCountry := edCountry.Text;
  FNewReservation.HomeCustomer.PersonProfileId := edtPortfolio.Tag;
  FNewReservation.HomeCustomer.CreatePersonProfileId := cbxAddToGuestProfiles.Checked;

  FNewReservation.HomeCustomer.ContactFax := edContactFax.Text;
  FNewReservation.HomeCustomer.ContactEmail := edContactEmail.Text;
  FNewReservation.HomeCustomer.ReservationPaymentInfo := memReservationPaymentInfo.Text;
  FNewReservation.HomeCustomer.ReservationGeneralInfo := memReservationGeneralInfo.Text;
  FNewReservation.HomeCustomer.ShowDiscountOnInvoice := true;
  FNewReservation.HomeCustomer.isRoomResDiscountPrec := cbxIsRoomResDiscountPrec.ItemIndex = 0;
  FNewReservation.HomeCustomer.RoomResDiscount := edRoomResDiscount.Value;
  FNewReservation.HomeCustomer.contactIsMainGuest := chkContactIsGuest.Checked;

  FNewReservation.OutOfOrderBlocking := OutOfOrderBlocking;
  FNewReservation.Market := TReservationMarketType(cbxMarket.itemindex);
  mRoomRates.SortedField := 'ratedate';

  memReservationGeneralInfo.Clear;

  FNewReservation.newRoomReservations.RoomItemsList.Clear;
  mRoomRes.First;

  while not mRoomRes.eof do
  begin
    room := mRoomRes.FieldByName('Room').AsString;
    RoomType := mRoomRes.FieldByName('RoomType').AsString;
    Package := mRoomRes.FieldByName('Package').AsString;
    Arrival := mRoomRes.FieldByName('Arrival').AsDateTime;
    Departure := mRoomRes.FieldByName('Departure').AsDateTime;
    guestCount := mRoomRes.FieldByName('Guests').AsInteger;
    RoomReservation := mRoomRes.FieldByName('RoomReservation').AsInteger;
    if NOT OutOfOrderBlocking then
    begin
      AvragePrice := glb.GetRateInclusive(-1, ctrlGetString('RoomRentItem'),
        mRoomRes.FieldByName('AvragePrice').AsFloat);
      if mRoomRes.FieldByName('isPercentage').AsBoolean then
        AvrageDiscount := mRoomRes.FieldByName('AvrageDiscount').AsFloat
      else
        AvrageDiscount := glb.GetRateInclusive(-1, ctrlGetString('RoomRentItem'), mRoomRes.FieldByName('AvrageDiscount')
          .AsFloat);
    end
    else
    begin
      AvragePrice := 0.00;
      AvrageDiscount := 0.00;
    end;
    RateCount := mRoomRes.FieldByName('RateCount').AsInteger;
    childrenCount := mRoomRes.FieldByName('ChildrenCount').AsInteger;
    infantCount := mRoomRes.FieldByName('infantCount').AsInteger;
    PriceCode := mRoomRes.FieldByName('PriceCode').AsString;
    isPercentage := mRoomRes.FieldByName('isPercentage').AsBoolean;
    mainGuestName := mRoomRes.FieldByName('MainGuest').AsString;
    RoomNotes := mRoomRes.FieldByName('roomNotes').AsString;

    if Trim(mainGuestName) = '' then
    begin
      if chkContactIsGuest.Checked then
      begin
        mainGuestName := edContactPerson.Text;
        if Trim(mainGuestName) = '' then
          mainGuestName := GetTranslatedText('MainGuestConstant_Version_1'); // MainGuestConstant_Version_1;;
      end
      else
      begin
        mainGuestName := GetTranslatedText('MainGuestConstant_Version_1'); // MainGuestConstant_Version_1;
      end;
    end;

    oSelectedRoomItem := TnewRoomReservationItem.Create(RoomReservation, room, RoomType, package, Arrival, Departure,
      guestCount, AvragePrice, AvrageDiscount, isPercentage, RateCount, childrenCount, infantCount, PriceCode,
      mainGuestName, RoomNotes);
    oSelectedRoomItem.ManualChannelId := mRoomRes.FieldByName('ManualChannelId').AsInteger;
    oSelectedRoomItem.ratePlanCode := mRoomRes.FieldByName('ratePlanCode').AsString;
    oSelectedRoomItem.ExpTOA := mRoomResExpectedTimeOfArrival.AsString;
    oSelectedRoomItem.ExpCOT := mRoomResExpectedCheckOutTime.AsString;
    oSelectedRoomItem.oRates.SetCurrency(edCurrency.Text);
    FNewReservation.newRoomReservations.RoomItemsList.Add(oSelectedRoomItem);

    mRoomRates.First;
    while not mRoomRates.eof do
    begin
      // �etta er sk�tamixi�
      if mRoomRates.FieldByName('roomreservation').AsInteger = RoomReservation then
      begin
        rateRoomNumber := mRoomRates.FieldByName('RoomNumber').AsString;
        RateDate := mRoomRates.FieldByName('RateDate').AsDateTime;
        if NOT OutOfOrderBlocking then
        begin
          Rate := glb.GetRateInclusive(-1, ctrlGetString('RoomRentItem'), mRoomRates.FieldByName('rate').AsFloat);
          if mRoomRates.FieldByName('isPercentage').AsBoolean then
            rateDiscount := mRoomRates.FieldByName('Discount').AsFloat
          else
            rateDiscount := glb.GetRateInclusive(-1, ctrlGetString('RoomRentItem'),
              mRoomRates.FieldByName('Discount').AsFloat);
        end
        else
        begin
          Rate := 0.00;
          rateDiscount := 0.00;
        end;
        ratePriceCode := mRoomRates.FieldByName('PriceCode').AsString;
        rateIsPercentage := mRoomRates.FieldByName('isPercentage').AsBoolean;
        rateShowDiscount := mRoomRates.FieldByName('ShowDiscount').AsBoolean;
        rateIsPaid := mRoomRates.FieldByName('isPaid').AsBoolean;
        rateItem := TRateItem.Create(Rate, RateDate, rateDiscount, rateShowDiscount, rateIsPercentage, rateIsPaid,
                                      ratePriceCode, rateRoomNumber, -1, RoomReservation);

        oSelectedRoomItem.oRates.RateItemsList.Add(rateItem);

        oSelectedRoomItem.Breakfast := cbxBreakfast.Checked;
        oSelectedRoomItem.BreakfastIncluded := cbxBreakfastIncl.Checked;
        oSelectedRoomItem.BreakfastCost := StrToFloat(edtBreakfast.Text);
        oSelectedRoomItem.BreakfastCostGroupAccount := cbxBreakfastGrp.Checked;

        oSelectedRoomItem.ExtraBed := cbxExtraBed.Checked;
        oSelectedRoomItem.ExtraBedIncluded := cbxExtraBedIncl.Checked;
        oSelectedRoomItem.ExtraBedCost := StrToFloat(edtExtraBed.Text);
        oSelectedRoomItem.ExtraBedCostGroupAccount := cbxExtraBedGrp.Checked;

      end;

      mRoomRates.next;
    end;


    // Add extras
    mExtras.First;
    while not mExtras.Eof do
    begin
      if (mExtrasRoomreservation.asInteger = RoomReservation) then
      begin
        lReservationExtra := TReservationExtra.Create(mExtrasItemid.AsInteger,
                                                      mExtrasItem.AsString,
                                                      mExtrasDescription.AsString,
                                                      mExtrasCount.AsInteger,
                                                      mExtrasPricePerItemPerDay.AsFloat,
                                                      iif(mExtrasFromdate.AsDateTime = Arrival, 0, mExtrasFromdate.AsDateTime),
                                                      iif(mExtrasTodate.AsDateTime = Departure, 0, mExtrasTodate.AsDateTime));
        oSelectedRoomItem.Extras.Add(lReservationExtra);
      end;
      mExtras.Next;
    end;


    mRoomRes.next;
  end;
end;

procedure TfrmMakeReservationQuick.btnClearLogClick(Sender: TObject);
begin
  copytoclipboard(frmdayNotes.memLog.Text);
  frmdayNotes.memLog.Clear;
  frmdayNotes.memLog.lines.Add('---' + Caption + '-----');
  frmdayNotes.memLog.lines.Add('');
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
  frmdayNotes.memLog.Perform(EM_LINESCROLL, 0, 10)
end;

procedure TfrmMakeReservationQuick.sButton7Click(Sender: TObject);
begin
  frmdayNotes.memLog.Perform(EM_LINESCROLL, 0, -10)
end;

procedure TfrmMakeReservationQuick.edPackageChange(Sender: TObject);
begin
  PackageValidate(edPackage, clabPcCode, labPackageDescription);
end;

procedure TfrmMakeReservationQuick.edPackageDblClick(Sender: TObject);
var
  theData: recPackageHolder;
begin
  theData.package := edPackage.Text;
  if openPackages(actLookup, theData) then
  begin
    edPackage.Text := theData.package;
  end;
end;

procedure TfrmMakeReservationQuick.edPackageExit(Sender: TObject);
begin
  PackageValidate(edPackage, clabPcCode, labPackageDescription);
end;

/// ///////////////////////

// -------------------------------------------------------------------------------------------------

// --------------------------------------------------------------------------------------------
// Currency Edit

function TfrmMakeReservationQuick.CurrencyValidate(ed: TsEdit; lab, labName: TsLabel): boolean;
var
  theData: recCurrencyHolder;
begin
  theData.Currency := Trim(ed.Text);
  Result := (hData.GET_currencyHolderByCurrency(theData)) and (theData.Currency <> '');

  if not Result then
  begin
    ed.SetFocus;
    labName.Font.Color := clRed;
    labName.Caption := GetTranslatedText('shNotF_star');
  end
  else
  begin
    labName.Font.Color := clBlack;
    labName.Caption := theData.Description + ' - Rate ' + floatTostr(theData.Value);
  end;
end;


// =============================================================================================
// Price Code Edit
// =============================================================================================

function TfrmMakeReservationQuick.PriceCodeValidate(ed: TsEdit; lab, labName: TsLabel): boolean;
var
  sValue: string;
  priceID: integer;
  Currency: string;
begin
  sValue := Trim(ed.Text);
  Result := PriceCodeExist(sValue);

  priceID := PriceCode_ID(sValue);
  Currency := Trim(edCurrency.Text);

  if not Result then
  begin
    ed.SetFocus;
    labName.Font.Color := clRed;
    labName.Caption := GetTranslatedText('shNotF_star');
  end
  else
  begin
    labName.Font.Color := clBlack;
    labName.Caption := PriceCode_Description(priceID);
  end;
end;

function TfrmMakeReservationQuick.PackageValidate(ed: TsEdit; lab, labName: TsLabel): boolean;
var
  sValue: string;
begin
  sValue := Trim(ed.Text);
  Result := PackageExist(sValue);

  if not Result then
  begin
    ed.SetFocus;
    labName.Font.Color := clRed;
    labName.Caption := GetTranslatedText('shNotF_star');
  end
  else
  begin
    labName.Font.Color := clBlack;
    labName.Caption := Package_Description(sValue);
  end;
end;

procedure TfrmMakeReservationQuick.edPcCodePropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
var
  theData: recPriceCodeHolder;
begin
  theData.PcCode := edPcCode.Text;
  if priceCodes(actLookup, theData) then
  begin
    edPcCode.Text := theData.PcCode;
  end;
end;

procedure TfrmMakeReservationQuick.edtRatePlansCloseUp(Sender: TObject);
var
  ChannelCode,
    chManCode: String;
  channelId: integer;
  FirstRound: boolean;
begin
  if edtRatePlans.ItemIndex > 0 then
  begin
    channelId := integer(edtRatePlans.Items.Objects[edtRatePlans.ItemIndex]);
    chManCode := channelManager_GetDefaultCode;
    FirstRound := true;
    if glb.LocateSpecificRecordAndGetValue('channels', 'id', channelId, 'channelManagerId', ChannelCode) then
    begin
      FDynamicRates.Prepare(dtArrival.date, dtDeparture.date, ChannelCode, chManCode);
      PopulateRatePlanCombo(FirstRound);
    end;
  end;
  if Assigned(Sender) then
    GetPrices;
end;


/// ///////////////////////////////////////////////////////////
///
///

function TfrmMakeReservationQuick.MarketSegmentValidate: boolean;
var
  sValue: string;
begin
  sValue := Trim(edMarketSegmentCode.Text);
  Result := CustomerTypeExist(sValue);

  if not Result then
  begin
    edMarketSegmentCode.SetFocus;
    labMarketSegmentName.Font.Color := clRed;
    labMarketSegmentName.Caption := GetTranslatedText('shNotF_star');
  end
  else
  begin
    labMarketSegmentName.Font.Color := clBlack;
    labMarketSegmentName.Caption := d.GET_CustomerTypesDescription_byCustomerType(Trim(edMarketSegmentCode.Text));
  end;
end;





// ******************************************************************************
// Page Reservation Edits
// ******************************************************************************

procedure TfrmMakeReservationQuick.dtArrivalChange(Sender: TObject);
var
  s: string;
begin
  datetimetostring(s, 'dddd', dtArrival.date);
  __lblArrivalWeekday.Caption := s;
end;

procedure TfrmMakeReservationQuick.dtArrivalCloseUp(Sender: TObject);
begin
  if dtDeparture.date <= dtArrival.date then
    dtDeparture.date := dtArrival.date + 1;
  if dtArrival.date >= dtDeparture.date then
    dtArrival.date := dtDeparture.date - 1;
  zNights := trunc(dtDeparture.date) - trunc(dtArrival.date);
  edNights.Value := zNights;
end;

procedure TfrmMakeReservationQuick.dtArrivalExit(Sender: TObject);
begin
  if dtDeparture.date <= dtArrival.date then
    dtDeparture.date := dtArrival.date + 1;
  if dtArrival.date >= dtDeparture.date then
    dtArrival.date := dtDeparture.date - 1;
  zNights := trunc(dtDeparture.date) - trunc(dtArrival.date);
  edNights.Value := zNights;
end;

/// ///////////

procedure TfrmMakeReservationQuick.dtDepartureChange(Sender: TObject);
var
  s: string;
begin
  datetimetostring(s, 'dddd', dtDeparture.date);
  __lblDepartureWeekday.Caption := s;
end;

procedure TfrmMakeReservationQuick.edNightsChange(Sender: TObject);
begin
  zNights := edNights.Value;
  dtDeparture.date := dtArrival.date + zNights;
end;

/// ///////////////////////////////////
// edCustomerKey

function TfrmMakeReservationQuick.customerValidate: boolean;
var
  sCustomer: string;
begin
  sCustomer := Trim(edCustomer.Text);
  Result := glb.CustomersSet.Locate('customer', sCustomer, []);

  if not Result then
  begin
    edCustomer.SetFocus;
    labCustomerName.Font.Color := clRed;
    labCustomerName.Caption := GetTranslatedText('shNotF_star');
  end
  else
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
  s: string;
  theData: recCustomerHolder;
begin
  theData.Customer := Trim(edCustomer.Text);
  if OpenCustomers(actLookup, true, theData) then
  begin
    s := theData.Customer;
    if (s <> '') and (s <> Trim(edCustomer.Text)) then
    begin
      edCustomer.Text := s;
    end;
  end;
end;

procedure TfrmMakeReservationQuick.edCustomerExit(Sender: TObject);
begin
  customerValidate;
end;

procedure TfrmMakeReservationQuick.edCustomerKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_f2 then
  begin
    edCustomerDblClick(self);
  end;
end;

/// ///////////////////////////
// edMarketSegmentCode

procedure TfrmMakeReservationQuick.edMarketSegmentCodeDblClick(Sender: TObject);
var
  theData: recCustomerTypeHolder;
begin
  theData.customerType := edMarketSegmentCode.Text;
  if openCustomerTypes(actLookup, theData) then
  begin
    edMarketSegmentCode.Text := theData.customerType;
    if MarketSegmentValidate then
    begin
    end;
  end;
end;

procedure TfrmMakeReservationQuick.edMarketSegmentCodeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_f2 then
  begin
    edMarketSegmentCodeDblClick(self);
  end;
end;

/// ///////////////////////////
// edCountry

procedure TfrmMakeReservationQuick.edContactEmailChange(Sender: TObject);
begin
  chkSendConfirmation.Enabled := length(Trim(edContactEmail.Text)) > 4;
end;

procedure TfrmMakeReservationQuick.edContactPersonCloseUp(Sender: TObject);
var
  Key: String;
begin
  if edContactPerson.Items.IndexOf(edContactPerson.Text) >= 0 then
  begin
    Key := TRoomerFilterItem(edContactPerson.Items.Objects[edContactPerson.ItemIndex]).Key;
    // edContactPerson.FKeys[idx];
    if glb.LocateSpecificRecord(glb.PreviousGuestsSet, 'ID', Key) then
    begin
      postMessage(handle, WM_SET_COMBO_TEXT, 1, 0);
    end
    else
      if glb.LocateSpecificRecord(glb.PersonProfiles, 'ID', Key) then
    begin
      if chkContactIsGuest.Checked then
      begin
        edtPortfolio.Text := Trim(glb.PersonProfiles['FirstName'] + ' ' + glb.PersonProfiles['LastName']);
        edtPortfolio.Tag := strToInt(Key);
      end;
      postMessage(handle, WM_SET_COMBO_TEXT, 2, 0);
    end;
  end;
end;

procedure TfrmMakeReservationQuick.edContactPersonEnter(Sender: TObject);
begin
  lblNew.Visible := edContactPerson.active;
end;

procedure TfrmMakeReservationQuick.edContactPersonExit(Sender: TObject);
begin
  lblNew.Visible := false;
end;

procedure TfrmMakeReservationQuick.edContactPersonKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  sTemp: String;
begin
  if (Key IN [vk_f2]) then
  begin
    edContactPerson.OnCloseUp := NIL;
    sTemp := edContactPerson.Text;
    edContactPerson.Stop;
    cbxAddToGuestProfiles.Visible := true;
    edContactPerson.DroppedDown := false;
    edContactPerson.Text := sTemp;
    edContactPerson.SelLength := 0;
    edContactPerson.SelStart := length(sTemp);
    lblNew.Visible := edContactPerson.active;
  end;
end;

procedure TfrmMakeReservationQuick.edCountryChange(Sender: TObject);
begin
  if glb.LocateCountry(edCountry.Text) then
    labCountryName.Caption := glb.Countries['CountryName'] // GET_CountryName(sValue);
  else
    labCountryName.Caption := GetTranslatedText('shNotF_star');
end;

procedure TfrmMakeReservationQuick.edCountryDblClick(Sender: TObject);
var
  theData: recCountryHolder;
begin
  theData.Country := edCountry.Text;
  if Countries(actLookup, theData) then
  begin
    edCountry.Text := theData.Country;
    labCountryName.Caption := theData.CountryName;
  end;
end;

procedure TfrmMakeReservationQuick.edCountryExit(Sender: TObject);
begin
  if CountryValidate then
  begin
  end;
end;

procedure TfrmMakeReservationQuick.edCountryKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_f2 then
  begin
    edCountryDblClick(self);
  end;
end;

/// ///////////////////////////////
// edCurrency

procedure TfrmMakeReservationQuick.edCurrencyChange(Sender: TObject);
var
  Index: integer;
begin
  if CurrencyValidate(edCurrency, clabCurrency, labCurrencyName) then
  begin
    index := cbxIsRoomResDiscountPrec.ItemIndex;
    cbxIsRoomResDiscountPrec.Items.Clear;
    cbxIsRoomResDiscountPrec.Items.Add('%');
    cbxIsRoomResDiscountPrec.Items.Add(edCurrency.Text);
    cbxIsRoomResDiscountPrec.ItemIndex := index;

    if index = 0 then
      edRoomResDiscount.MaxValue := 100
    else
      edRoomResDiscount.MaxValue := 99999999;

    labCurrencyRate.Caption := floatTostr(GetRate(edCurrency.Text));
  end;
end;

procedure TfrmMakeReservationQuick.edCurrencyDblClick(Sender: TObject);
var
  theData: recCurrencyHolder;
begin
  theData.Currency := Trim(edCurrency.Text);
  if Currencies(actLookup, theData) then
  begin
    edCurrency.Text := theData.Currency;
    labCurrencyRate.Caption := floatTostr(GetRate(edCurrency.Text));
    lblExtraBedCurrency.Caption := edCurrency.Text;

  end;
end;

procedure TfrmMakeReservationQuick.edCurrencyKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_f2 then
  begin
    edCurrencyDblClick(self);
  end;
end;

/// ////////////////////////
// edPcCode

procedure TfrmMakeReservationQuick.edPcCodeChange(Sender: TObject);
begin
  PriceCodeValidate(edPcCode, clabPcCode, labPcCodeName);
end;

procedure TfrmMakeReservationQuick.edPcCodeDblClick(Sender: TObject);
var
  theData: recPriceCodeHolder;
begin
  theData.PcCode := edPcCode.Text;
  if priceCodes(actLookup, theData) then
  begin
    edPcCode.Text := theData.PcCode;
  end;
end;

procedure TfrmMakeReservationQuick.edPcCodeExit(Sender: TObject);
begin
  PriceCodeValidate(edPcCode, clabPcCode, labPcCodeName);
end;

procedure TfrmMakeReservationQuick.edPcCodeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_f2 then
  begin
    edPcCodeDblClick(self);
  end;
end;

/// ////////////////////////////
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
  end
  else
  begin
    edRoomResDiscount.MaxValue := 99999999;
  end;
end;

procedure TfrmMakeReservationQuick.cbxRoomStatusCloseUp(Sender: TObject);
begin
  OutOfOrderBlocking := cbxRoomStatus.ItemIndex = 7;
end;

end.
