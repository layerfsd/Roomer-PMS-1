unit uChannelAvailabilityManager;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB,
  cmpRoomerDataSet, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.ExtCtrls,
  Vcl.StdCtrls, sLabel,
  Vcl.Mask, sMaskEdit, sCustomComboEdit, sTooledit, sButton, sPanel,
  System.Generics.Collections, acPNG, Vcl.ImgList, cxPropertiesStore,
  Vcl.ComCtrls,
  sPageControl, Vcl.OleCtrls, SHDocVw, mshtml, RoomerCloudEntities,
  AdvTimePickerDropDown, sEdit, sCheckBox, sComboBox,
  uUtils, Vcl.Menus, uD, sGroupBox, sBevel, UbuntuProgress, ActiveX, HTMLabel,
  cxClasses, acImage, clisted, uRoomerThreadedRequest, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkSide, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, cxButtons, AdvEdit, AdvEdBtn, PlannerDatePicker,
  dxSkinBlack, dxSkinBlue, dxSkinDevExpressDarkStyle, dxSkinFoggy, dxSkinLiquidSky, dxSkinMcSkin, dxSkinOffice2013White, dxSkinWhiteprint, CheckComboBox,
  AdvUtil;

type

  TChannelManagerValue = class
    FId: integer;
    FDescription: String;
    FAdminUser: String;
    FAdminPassword: String;
    FNumDays: integer;
  public
    constructor Create(Id: integer; const description, username, password: String; _numDays: integer);
  end;

  TPlanCodeValue = class
    FId: integer;
    FCode: String;
    FDescription: String;
  public
    constructor Create(Id: integer; const Code, description: String);
  end;

  TCellData = class
  private
    FId: integer;
    FDate: TDateTime;
    FPlanCodeId: integer;
    FOriginalValue: Variant;
    FOriginalMaxValue: Variant;
    FMaxValue: Variant;
    FCurrentValue: Variant;
    FRoomClassId: integer;
    FChannelManagerId: integer;
    FIsEditable: Boolean;
    FForceRefresh: Boolean;
    FLinkElement: String;
    FRoomClassCode: String;
    function GetChanged: Boolean;
    function GetEdited: Boolean;
  public
    constructor Create(Id: integer; date: TDateTime; IsEditable: Boolean; const LinkElement: String; PlanCodeId, RoomClassId, ChannelManagerId: integer;
      const RoomClassCode: String; originalValue: Variant; maxAvailability: Variant);
    destructor Destroy; override;

    property date: TDateTime read FDate;
    property Id: integer read FId;
    property PlanCodeId: integer read FPlanCodeId;
    property RoomClassId: integer read FRoomClassId;
    property ChannelManagerId: integer read FChannelManagerId;
    property originalValue: Variant read FOriginalValue write FOriginalValue;
    property MaxValue: Variant read FMaxValue write FMaxValue;
    property CurrentValue: Variant read FCurrentValue write FCurrentValue;
    property IsEditable: Boolean read FIsEditable write FIsEditable;
    property LinkElement: String read FLinkElement write FLinkElement;
    property RoomClassCode: String read FRoomClassCode write FRoomClassCode;
    property ForceRefresh: Boolean read FForceRefresh write FForceRefresh;

    property Changed: Boolean read GetChanged;
    property Edited: Boolean read GetEdited;
  end;

  TfrmChannelAvailabilityManager = class;

  TPriceData = class
  private
    FDate: TDateTime;
    FChannelManager: integer;
    FId: integer;
    FOldValue: Double;
    FPrice: Double;
    FChannelId: integer;
    FRateRoundingType: integer;
    FRoomTypeGroupId: integer;
    FRoomTypeGroupCode, FRoomTypeTopClass: String;
    FStopSell: Boolean;
    FMinStay: integer;
    ForcingUpdate: Boolean;

    FAvailability: integer;
    FMaxStay: integer;
    FCOA: Boolean;
    FCOD: Boolean;
    FLOSArrivalDateBased: Boolean;
    FSingleUsePrice: Double;

    FPriceDirty, FAvailabilityDirty, FStopSellDirty, FMaxStayDirty, FMinStayDirty, FCOADirty, FCODDirty, FLOSArrivalDateBasedDirty,
      FSingleUsePriceDirty: Boolean;
    FconnectSingleUseRateToMasterRate: Boolean;
    FconnectRateToMasterRate: Boolean;
    FsingleUseRateDeviationType: String;
    FmasterRateSingleUseRateDeviation: Double;
    FRateDeviationType: String;
    FmasterRateRateDeviation: Double;
    FconnectMaxStayToMasterRate: Boolean;
    FconnectCOAToMasterRate: Boolean;
    FconnectCODToMasterRate: Boolean;
    FconnectMinStayToMasterRate: Boolean;
    FconnectAvailabilityToMasterRate: Boolean;
    FconnectLOSToMasterRate: Boolean;
    FconnectStopSellToMasterRate: Boolean;

    procedure SetPrice(const value: Double);
    procedure SetAvailability(const value: integer);
    procedure SetCOA(const value: Boolean);
    procedure SetCOD(const value: Boolean);
    procedure SetLOSArrivalDateBased(const value: Boolean);
    procedure SetMaxStay(const value: integer);
    procedure SetSingleUsePrice(const value: Double);
    procedure setMinStay(const value: integer);
    function isEdited: Boolean;
    procedure setStopSell(const value: Boolean);
  public
    constructor Create(_Id: integer; const roomtypeGroupCode, _roomTypeTopClass: String; date: TDateTime;
      rateRoundingType, channelId, roomTypeGroupId, channelManager: integer; price: Double; stopSell: Boolean; minStay: integer; _Availability: integer;
      _MaxStay: integer; _COA: Boolean; _COD: Boolean; _LOSArrivalDateBased: Boolean; _SingleUsePrice: Double
      ;
      _connectRateToMasterRate : Boolean;
      _masterRateRateDeviation : Double;
      const _RateDeviationType : String;

      _connectSingleUseRateToMasterRate : Boolean;
      _masterRateSingleUseRateDeviation : Double;
      const _singleUseRateDeviationType : String;

      _connectStopSellToMasterRate : Boolean;
      _connectAvailabilityToMasterRate : Boolean;
      _connectMinStayToMasterRate : Boolean;
      _connectMaxStayToMasterRate : Boolean;
      _connectCOAToMasterRate : Boolean;
      _connectCODToMasterRate : Boolean;
      _connectLOSToMasterRate : Boolean
    );
    destructor Destroy; override;

    procedure ClearEdited;

    property Id: integer read FId;
    property stopSell: Boolean read FStopSell Write setStopSell;
    property minStay: integer read FMinStay Write setMinStay;
    property channelId: integer read FChannelId;
    property rateRoundingType: integer read FRateRoundingType;
    property roomTypeGroupId: integer read FRoomTypeGroupId;
    property roomtypeGroupCode: String read FRoomTypeGroupCode;
    property RoomTypeTopClass: String read FRoomTypeTopClass;

    property price: Double read FPrice write SetPrice;
    property Availability: integer read FAvailability write SetAvailability;
    property MaxStay: integer read FMaxStay write SetMaxStay;
    property COA: Boolean read FCOA write SetCOA;
    property COD: Boolean read FCOD write SetCOD;
    property LOSArrivalDateBased: Boolean read FLOSArrivalDateBased write SetLOSArrivalDateBased;
    property SingleUsePrice: Double read FSingleUsePrice write SetSingleUsePrice;

    property date: TDateTime read FDate;
    property channelManager: integer read FChannelManager;

    property connectRateToMasterRate : Boolean read FconnectRateToMasterRate write FconnectRateToMasterRate;
    property masterRateRateDeviation : Double read FmasterRateRateDeviation write FmasterRateRateDeviation;
    property RateDeviationType : String read FRateDeviationType write FRateDeviationType;

    property connectSingleUseRateToMasterRate : Boolean read FconnectSingleUseRateToMasterRate write FconnectSingleUseRateToMasterRate;
    property masterRateSingleUseRateDeviation : Double read FmasterRateSingleUseRateDeviation write FmasterRateSingleUseRateDeviation;
    property singleUseRateDeviationType : String read FsingleUseRateDeviationType write FsingleUseRateDeviationType;

    property connectStopSellToMasterRate : Boolean read FconnectStopSellToMasterRate write FconnectStopSellToMasterRate;
    property connectAvailabilityToMasterRate : Boolean read FconnectAvailabilityToMasterRate write FconnectAvailabilityToMasterRate;
    property connectMinStayToMasterRate : Boolean read FconnectMinStayToMasterRate write FconnectMinStayToMasterRate;
    property connectMaxStayToMasterRate : Boolean read FconnectMaxStayToMasterRate write FconnectMaxStayToMasterRate;
    property connectCOAToMasterRate : Boolean read FconnectCOAToMasterRate write FconnectCOAToMasterRate;
    property connectCODToMasterRate : Boolean read FconnectCODToMasterRate write FconnectCODToMasterRate;
    property connectLOSToMasterRate : Boolean read FconnectLOSToMasterRate write FconnectLOSToMasterRate;
  end;

  TDictionaryItem = class
  private
    FCode: String;
    FDate: String;
    fvalue: integer;
  public
    constructor Create(const Code, ADate: String; value: integer);
  end;

  TColumns = Array Of TCellData;
  TRowsOfColumns = Array Of TColumns;

  TDictItemObjectDictionary = TObjectDictionary<String, TDictionaryItem>;

  TfrmChannelAvailabilityManager = class(TForm)
    timStart: TTimer;
    ImageList1: TImageList;
    FormStore: TcxPropertiesStore;
    pgcPages: TsPageControl;
    sTabSheet1: TsTabSheet;
    sTabSheet2: TsTabSheet;
    Panel2: TsPanel;
    sPanel1: TsPanel;
    btnSave: TsButton;
    sPanel2: TsPanel;
    grid: TAdvStringGrid;
    pnlBulkChanges: TsPanel;
    lblBulkUpdate: TsLabel;
    lblAmountType: TsLabel;
    Label3: TsLabel;
    Label4: TsLabel;
    edtAvail: TsEdit;
    cbxRoomTypes: TCheckComboBox;
    dtBulkFrom: TsDateEdit;
    dtBulkTo: TsDateEdit;
    cbTue: TsCheckBox;
    cbWen: TsCheckBox;
    cbFri: TsCheckBox;
    cbThu: TsCheckBox;
    cbSat: TsCheckBox;
    cbSun: TsCheckBox;
    btnApplyBulk: TsButton;
    sButton2: TsButton;
    cbMon: TsCheckBox;
    rateGrid: TAdvStringGrid;
    sPanel10: TsPanel;
    sPanel11: TsPanel;
    btnPublish: TsButton;
    Panel1: TsPanel;
    lblEditing: TsLabel;
    sPanel9: TsPanel;
    cbxChannelManagers: TsComboBox;
    cbxChannel: TCheckComboBox;
    lblChannel: TsLabel;
    mnuRates: TPopupMenu;
    C1: TMenuItem;
    P1: TMenuItem;
    N1: TMenuItem;
    C2: TMenuItem;
    R1: TMenuItem;
    sButton1: TsButton;
    sButton3: TsButton;
    timRecalc: TTimer;
    sPanel6: TsPanel;
    cbxStopMinOptions: TsCheckBox;
    cbxPlanCodes: TsComboBox;
    sButton4: TsButton;
    sButton5: TsButton;
    pnlProgress: TsPanel;
    prgSaving: TUbuntuProgress;
    lblReadSave: TsLabel;
    sPanel3: TsPanel;
    cbxShowLinkedCells: TsCheckBox;
    cbxAvailType: TsComboBox;
    pnlHolder: TsPanel;
    btnClose: TsButton;
    cbxExtraRestrictions: TsCheckBox;
    lblDCAvailability: TsLabel;
    edtDCAvailbility: TsEdit;
    cbDCAvailabilityType: TsComboBox;
    __cbxRate: TsCheckBox;
    __cbxAvailability: TsCheckBox;
    pnlHideEdits: TsPanel;
    sPanel4: TsPanel;
    Image1: TImage;
    sPanel5: TsPanel;
    pnlRestrictions: TsPanel;
    __cbxMinimumStayActive: TsCheckBox;
    lblMinStay: TsLabel;
    edtMinStay: TsEdit;
    edtMaximumStay: TsEdit;
    lblMaximumStay: TsLabel;
    N2: TMenuItem;
    C3: TMenuItem;
    imgHelp: TsImage;
    edtSingleUsePrice: TsEdit;
    __cbxSingleUsePriceActive: TsCheckBox;
    lblSingleUsePrice: TsLabel;
    ccChannels: TCheckComboBox;
    sLabel1: TsLabel;
    cbxShowSubrates: TsCheckBox;
    btnRecalcDescendantRates: TsButton;
    btnClearRoomClasses: TsButton;
    btnClearChannelSelection: TsButton;
    btnClearChannelSelectionGrid: TsButton;
    btnCheckAllChannel: TsButton;
    btnCheckAllBulkRoomClasses: TsButton;
    btnCheckAllBulkChannel: TsButton;
    pnlGridsWithLoadingCaption: TsPanel;
    sPanel7: TsPanel;
    wwDBDateTimePicker1: TPlannerDatePicker;
    btnRefreshOneDay: TcxButton;
    btnForward: TcxButton;
    btnBack: TcxButton;
    dateEdit: TsDateEdit;
    lblVisibleDays: TsLabel;
    __cbxVisibleDays: TsComboBox;
    btnBegin: TcxButton;
    btnEnd: TcxButton;
    pmnuForce: TPopupMenu;
    F1: TMenuItem;
    F2: TMenuItem;
    btnStopSell_Off: TsButton;
    btnStopSell_On: TsButton;
    btnStopSell_Clear: TsButton;
    cbxStopSell: TsLabel;
    btnCloseOnArrival_Off: TsButton;
    btnCloseOnArrival_Clear: TsButton;
    btnCloseOnArrival_On: TsButton;
    cbxClosedOnArrival: TsLabel;
    btnCloseOnDeparture_Off: TsButton;
    btnCloseOnDeparture_On: TsButton;
    btnCloseOnDeparture_Clear: TsButton;
    cbxClosedOnDeparture: TsLabel;
    cbxStayThrough: TsCheckBox;
    cbxBasedOnArrival: TsCheckBox;
    lblStayThrough: TsLabel;
    lblBasedOnArrival: TsLabel;
    btnPrepareExcel: TsButton;
    lblReadTime: TsLabel;
    lblDrawTime: TsLabel;
    timBlink: TTimer;
    timBringToFront: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure timStartTimer(Sender: TObject);
    procedure gridDrawCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
    procedure gridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dateEditAcceptDate(Sender: TObject; var ADate: TDateTime; var CanAccept: Boolean);
    procedure btnSaveClick(Sender: TObject);
    procedure gridCanEditCell(Sender: TObject; ARow, ACol: integer; var CanEdit: Boolean);
    procedure dtBulkToChange(Sender: TObject);
    procedure btnApplyBulkClick(Sender: TObject);
    procedure sPanel4Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure gridGetEditorType(Sender: TObject; ACol, ARow: integer; var AEditor: TEditorType);
    procedure gridCellValidate(Sender: TObject; ACol, ARow: integer; var value: string; var Valid: Boolean);
    procedure Image1Click(Sender: TObject);
    procedure pgcPagesChange(Sender: TObject);
    procedure btnPublishClick(Sender: TObject);
    procedure rateGridCanEditCell(Sender: TObject; ARow, ACol: integer; var CanEdit: Boolean);
    procedure rateGridDrawCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
    procedure rateGridGetCellBorder(Sender: TObject; ARow, ACol: integer; APen: TPen; var Borders: TCellBorders);
    procedure rateGridGetAlignment(Sender: TObject; ARow, ACol: integer; var HAlign: TAlignment; var VAlign: AdvObj.TVAlignment);
    procedure rateGridGetCellColor(Sender: TObject; ARow, ACol: integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure cbxChannelManagersChange(Sender: TObject);
    procedure rateGridGetEditorType(Sender: TObject; ACol, ARow: integer; var AEditor: TEditorType);
    procedure rateGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure rateGridCellValidate(Sender: TObject; ACol, ARow: integer; var value: string; var Valid: Boolean);
    procedure rateGridEditCellDone(Sender: TObject; ACol, ARow: integer);
    procedure rateGridKeyPress(Sender: TObject; var Key: Char);
    procedure rateGridClipboardAfterPasteCell(Sender: TObject; ACol, ARow: integer; value: string);
    procedure rateGridClipboardBeforePasteCell(Sender: TObject; ACol, ARow: integer; var value: string; var Allow: Boolean);
    procedure R1Click(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure P1Click(Sender: TObject);
    procedure C2Click(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure rateGridGridHint(Sender: TObject; ARow, ACol: integer; var hintstr: string);
    procedure gridGridHint(Sender: TObject; ARow, ACol: integer; var hintstr: string);
    procedure timRecalcTimer(Sender: TObject);
    procedure rateGridCheckBoxChange(Sender: TObject; ACol, ARow: integer; State: Boolean);
    procedure cbxStopMinOptionsClick(Sender: TObject);
    procedure sButton4Click(Sender: TObject);
    procedure sButton5Click(Sender: TObject);
    procedure gridEditCellDone(Sender: TObject; ACol, ARow: integer);
    procedure gridClipboardAfterPasteCell(Sender: TObject; ACol, ARow: integer; value: string);
    procedure cbxShowLinkedCellsClick(Sender: TObject);
    procedure cbxAvailTypeChange(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbDCAvailabilityTypeChange(Sender: TObject);
    procedure __cbxRateClick(Sender: TObject);
    procedure __cbxAvailabilityClick(Sender: TObject);
    procedure __cbxMinimumStayActiveClick(Sender: TObject);
    procedure __cbxSingleUsePriceActiveClick(Sender: TObject);
    procedure pnlBulkChangesResize(Sender: TObject);
    procedure rateGridCellChanging(Sender: TObject; OldRow, OldCol, NewRow, NewCol: integer; var Allow: Boolean);
    procedure C3Click(Sender: TObject);
    procedure cbxChannelCloseUp(Sender: TObject);
    procedure ccChannelsClickCheck(Sender: TObject);
    procedure btnRecalcDescendantRatesClick(Sender: TObject);
    procedure cbxChannelClickCheck(Sender: TObject);
    procedure btnClearRoomClassesClick(Sender: TObject);
    procedure btnClearChannelSelectionClick(Sender: TObject);
    procedure btnClearChannelSelectionGridClick(Sender: TObject);
    procedure btnCheckAllBulkChannelClick(Sender: TObject);
    procedure btnCheckAllBulkRoomClassesClick(Sender: TObject);
    procedure btnCheckAllChannelClick(Sender: TObject);
    procedure BackgroundAvailabilityFetchHandler(Sender: TObject);
    procedure btnForwardClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnBeginClick(Sender: TObject);
    procedure btnEndClick(Sender: TObject);
    procedure F1Click(Sender: TObject);
    procedure F2Click(Sender: TObject);
    procedure btnStopSell_OffClick(Sender: TObject);
    procedure btnStopSell_OnClick(Sender: TObject);
    procedure btnStopSell_ClearClick(Sender: TObject);
    procedure btnRefreshOneDayClick(Sender: TObject);
    procedure btnPrepareExcelClick(Sender: TObject);
    procedure timBlinkTimer(Sender: TObject);
    procedure timBringToFrontTimer(Sender: TObject);
    procedure __cbxVisibleDaysCloseUp(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    RoomerDataSet: TRoomerDataSet;
    Halting: Boolean;
    FCurrentNumDays: integer;
    AvailDict: TDictItemObjectDictionary;
    CurrentChannelMan: TChannelManagerValue;
    ARoomTypeSet: TRoomerDataSet;

    NumLinesPerRateEntity: integer;

    anyDirectConnection : Boolean;
    onlyDirectConnection : Boolean;

    startDate : TDateTime;

    ThreadedDataGetter : TGetThreadedData;


    procedure ShowAvailabilityForSelectedChannelManager;
    function GetDateLabel(date: TDateTime): String;
    function EditableCell(_grid: TAdvStringGrid; ARow, ACol: integer): Boolean;
    function LoadRoomTypeGroups: Boolean;
    function DayOfWeekIsIncludes(date: TDateTime): Boolean;
    procedure EmptyBulkOperation;
    function IsWeekend(ACol: integer): Boolean;
    procedure ShowRatesForSelectedChannelManager;
    procedure FreeGridObject(aGrid: TadvStringGrid);
    function LoadChannelManagers: Boolean;
    procedure RemoveData;
    procedure EmptyGrid(grid: TAdvStringGrid);
    procedure SetAvailabilityValue(iRow: integer; var value: string; _grid: TAdvStringGrid; iCol: integer);
    procedure SetRateValue(iCol, iRow: integer; value: string; _grid: TAdvStringGrid; InPlaceEditing: Boolean = false; IsSinglePrice: Boolean = false);
    procedure InitializeBulkOperation;
    procedure getPriceOfSpecificCell;
    procedure DeleteContentOfCurrentCell;
    function CurrentActiveGrid: TAdvStringGrid;
    function getRateValueForCell(value: String; ACol, ARow: integer; ForSingleUsePrice : Boolean): Double;
    function getPriceForOnCell(ACol, ARow: integer): Double;
    procedure GetStatusOfRoomClasses;
    function locateAvailabilityFromRoomTypeCodeAndDate(const Code: String; date: TDateTime): integer;
    function RoundValue(RoundType: integer; value: Double): Double;
    function NumDecimals(RoundType: integer): integer;
    function LoadPlanCodes: Boolean;
    function SeekRecordValue(ASet: TRoomerDataSet; const fieldNameToSeek: String; fieldValue: integer): Boolean;
    procedure GridPostPasteAction(_grid: TAdvStringGrid);
    function FindRoomClassRow(const Code: String): integer;
    function AvailabilityCell(iCol, iRow: integer): TCellData;
    procedure PostList(list: TList<String>);
    procedure BeginProject(numItems: integer);
    procedure EndProject;
    procedure ForwardProject;
    procedure StallingProject(stalled: Boolean);
    procedure RefreshScreen;
    procedure CorrectLinks(ACol, ARow: integer);
    procedure HideShowLinkedClasses;
    procedure HideShowExtraCells;
    procedure PrepareAvailDictionary(AvailabilitySet: TRoomerDataSet);
    function RealNumberOfRateObjects: integer;
    function RealNumberOfAvailabilityObjects: integer;
    function isAvailabilityRow(iRow: integer): Boolean;
    function isClosedOnDepartureRow(iRow: integer): Boolean;
    function isCloseOnArrivalRow(iRow: integer): Boolean;
    function isLOSArrivalDateBasedRow(iRow: integer): Boolean;
    function isMaxStayRow(iRow: integer): Boolean;
    function isMinStayRow(iRow: integer): Boolean;
    function isSingleUsePriceRow(iRow: integer): Boolean;
    function isStopSellRow(iRow: integer): Boolean;
    function isAnySpecRow(iRow: integer): Boolean;
    function isAnyCheckBoxRow(iRow: integer): Boolean;
    function isAnyEditBoxRow(iRow: integer): Boolean;
    function isPriceRow(iRow: integer): Boolean;
    function isAnyEditableRow(iRow: integer): Boolean;
    function findPriceRowFrom(iRow: integer): integer;
    function getPriceDataOfRow(iCol, iRow: integer): TPriceData;
    function isCurrentlySelectedValueEdited(iCol, iRow: integer): Boolean;
    function buildSetStatement(dirty: Boolean; var oldResultValue: String; const dirtyName, valueName, value: String): String;
    function isPriceCell(iCol, iRow: integer): Boolean;
    function findRowTypeIndex(startAt, pointerType: integer): integer;
    function GetChannelManagerId: integer;
    function GetPlanCodeId: integer;
    procedure AssignChanges(destChannelId : Integer);
    procedure SetRateCellValue(iCol, iRow: integer; PriceData: TPriceData; value: Double);
    procedure SetAvailabilityCellValue(iCol, iRow: integer; PriceData: TPriceData; value: integer);
    procedure SetCheckBoxCellValue(iCol, iRow: integer; value: Boolean);
    procedure SetMinStayCellValue(iCol, iRow: integer; PriceData: TPriceData; value: integer);
    procedure SetMaxStayCellValue(iCol, iRow: integer; PriceData: TPriceData; value: integer);
    procedure FindFirstAndLastDateInList(var firstDate, lastDate: TDateTime);
    procedure SetSingleUsePriceCellValue(iCol, iRow: integer; PriceData: TPriceData; value: Double);
    procedure SetCheckBoxStateForCheckBoxCells(iCol, iRow: integer; value: Boolean);
    procedure CorrectMasterRateLinkedCells(PriceData : TPriceData; ACol, ARow: integer);
    function SameTypeRows(iRow1, iRow2: integer): Boolean;
    function findIdInCheckListCombo(cbx : TCheckComboBox; id: Integer): Integer;
    function IsIdCheckedInCheckListCombo(cbx: TCheckComboBox; id: Integer): Boolean;
    function isHiddenUnusedRow(iRow: integer): Boolean;
    function LoadRoomTypeGroupsForBulk: Boolean;
    procedure CheckOrUnCheckAllInCheckList(cl: TCheckComboBox; checked : Boolean; skipMinValues : Boolean = False);
    function AddCheckEditItem(comp : TCheckComboBox; line : String; obj : TObject) : Integer;
    procedure RefreshGridsData;
    procedure ForceAvailabilityForCurrentPeriod;
    procedure ForceFullAvailability;
    procedure ForceRateUpdateForCurrentPeriod;
    procedure ForceFullRates;
    function ButtonOff(const pre: String): TsButton;
    function ButtonOn(const pre: String): TsButton;
    function PreOfButton(btn: TsButton): String;
    procedure SetButtonOnOff(btn: TSButton; SetOn: Boolean);
    procedure PostRatesList(const tableName : String; list: TList<String>);
    procedure PublishSheet(OnlyCreateExcel: Boolean; AllowEditAndSendEmail : Boolean);
    procedure ShowHideExtraOptions;
    procedure BlinkCombo;
    function buildSetStatementMinMax(var oldResultValue: String; minDirty, maxDirty: Boolean; minValue, maxValue: Integer): String;
    procedure CleanUpRedundantRoomClassesInAvailbilities;
    function PerformForcedRatesUpdate: Boolean;
    function PerformForcedAvailabilityUpdate: Boolean;
    procedure ReloadSelectedPeriod;
    function AnyRateOrRestrictionsChanges: Boolean;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
    embedded: Boolean;
    EmbedWindowCloseEvent: TNotifyEvent;

    procedure PrepareUserInterface;
    procedure BringWindowToFront;
  end;

var
  frmChannelAvailabilityManager: TfrmChannelAvailabilityManager;
  frmChannelAvailabilityManagerX: TfrmChannelAvailabilityManager;

  CHANNELMANAGER_IS_OPEN : Boolean = False;

procedure ShowChannelAvailabilityManager(embedPanel: TsPanel = nil; WindowCloseEvent: TNotifyEvent = nil);

implementation

{$R *.dfm}

uses ioUtils, uMain, uDateUtils, uStringUtils, _glob, uAppGlobal, PrjConst,
  uFrmChannelCopyFrom, uRoomerMessageDialog, uDImages, uExcelProcessors, uG, uEmailExcelSheet, hData,
  uActivityLogs,
  UITypes
  , uFloatUtils, uFileSystemUtils;

const
  BODY_START = '<body bgcolor="#0000FF"><font bgcolor="#0000FF" color="#FFFFFF">';
  BOLD_START = '<b>';
  BOLD_END = '</b>';
  BODY_END = '</font></body>';

  ACTIVE_FLAG_RESTRICTION = '<b>%s</b> active.<br>';
  ACTIVE_SETTING_RESTRICTION = '<b>%s</b> = %d.<br>';

  MAX_UPDATES_PER_CALL =  600;

  NUMBER_OF_DAYS_DISPLAYED : Integer = 14;

procedure ShowChannelAvailabilityManager(embedPanel: TsPanel = nil; WindowCloseEvent: TNotifyEvent = nil);
begin

  if CHANNELMANAGER_IS_OPEN then
  begin
    if frmChannelAvailabilityManager.WindowState = wsMinimized then
      frmChannelAvailabilityManager.WindowState := wsNormal;
    frmChannelAvailabilityManager.BringToFront;
  end else
  begin
    Application.CreateForm(TfrmChannelAvailabilityManager, frmChannelAvailabilityManager);
    frmChannelAvailabilityManager.embedded := (embedPanel <> nil);
    frmChannelAvailabilityManager.EmbedWindowCloseEvent := WindowCloseEvent;
    if frmChannelAvailabilityManager.embedded then
    begin
      frmChannelAvailabilityManager.pnlHolder.parent := embedPanel;
      embedPanel.Update;
      frmChannelAvailabilityManagerX := frmChannelAvailabilityManager;
    end
    else
    begin
      frmChannelAvailabilityManager.PrepareUserInterface;
      CHANNELMANAGER_IS_OPEN := True;
      frmChannelAvailabilityManager.Show;
    end;
  end;
end;

procedure TfrmChannelAvailabilityManager.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
  Params.WndParent := Application.Handle;
end;

procedure TfrmChannelAvailabilityManager.btnApplyBulkClick(Sender: TObject);
var
  iRowCounter, iColCounter: integer;
  value: String;
  _grid: TAdvStringGrid;
  Msg, MsgType : String;
begin

  case pgcPages.ActivePageIndex of
    0: begin
         _grid := grid;
         Msg := GetTranslatedText('shUI_ChannelManager_AvailPublishWarning');
         MsgType := 'ChannelMngrAskBeforeAvailPublish';
       end;
    1: begin
         _grid := rateGrid;
         Msg := GetTranslatedText('shUI_ChannelManager_RatesPublishWarning');
         MsgType := 'ChannelMngrAskBeforeRatesPublish';
       end;
  else
    Exit;
  end;

    Screen.Cursor := crHourglass;
    _grid.Tag := 1;
    try
      if pgcPages.ActivePageIndex = 0 then // Availability
      begin
        if cbxAvailType.ItemIndex = 2 then // Auto
          value := '-1'
        else if cbxAvailType.ItemIndex = 3 then // Set Current
          value := '-2'
        else if cbxAvailType.ItemIndex = 1 then // Set Max Availability
          value := edtAvail.Text
        else // Set value normally
          value := edtAvail.Text;
      end else
      begin // Rates
        if cbxAvailType.ItemIndex = 1 then // Auto
          value := '-1'
        else // Set value normally
          value := edtAvail.Text;
      end;
      for iRowCounter := 1 to _grid.RowCount - 1 do
      begin
        for iColCounter := 1 to _grid.ColCount - 1 do
        begin
          if (_grid = grid) AND EditableCell(_grid, iRowCounter, iColCounter) then
            SetAvailabilityValue(iRowCounter, value, _grid, iColCounter)
          else if (_grid = rateGrid) AND isPriceCell(iColCounter, iRowCounter) then
            SetRateValue(iColCounter, iRowCounter, value, _grid);
        end;
      end;
      if _grid = rateGrid then
        if cbxAvailType.ItemIndex = 2 - pgcPages.ActivePageIndex then
          getPriceOfSpecificCell;

      sPanel4Click(nil);
      _grid.Invalidate;
    finally
      _grid.Tag := 0;
      Screen.Cursor := crDefault;
      Application.ProcessMessages;
    end;
end;

procedure TfrmChannelAvailabilityManager.btnBackClick(Sender: TObject);
begin
  startDate := startDate - NUMBER_OF_DAYS_DISPLAYED;
  if TRUNC(startDate) < TRUNC(now) then
    startDate := TRUNC(now);
  dateEdit.Date := startDate;
  RefreshGridsData;
end;

procedure TfrmChannelAvailabilityManager.btnBeginClick(Sender: TObject);
begin
  startDate := TRUNC(now);
  dateEdit.Date := startDate;
  RefreshGridsData;
end;

procedure TfrmChannelAvailabilityManager.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmChannelAvailabilityManager.btnEndClick(Sender: TObject);
begin
  startDate := TRUNC(now + CurrentChannelMan.FNumDays - NUMBER_OF_DAYS_DISPLAYED);
  dateEdit.Date := startDate;
  RefreshGridsData;
end;

procedure TfrmChannelAvailabilityManager.btnForwardClick(Sender: TObject);
begin
  startDate := startDate + NUMBER_OF_DAYS_DISPLAYED;
  if TRUNC(startDate) > TRUNC(now + CurrentChannelMan.FNumDays) then
    startDate := TRUNC(now + CurrentChannelMan.FNumDays - NUMBER_OF_DAYS_DISPLAYED);
  dateEdit.Date := startDate;
  RefreshGridsData;
end;

function TfrmChannelAvailabilityManager.DayOfWeekIsIncludes(date: TDateTime): Boolean;
var
  FDayOfWeek: integer;
begin
  FDayOfWeek := DayOfWeek(date);
  result := ((cbMon.Checked) AND (FDayOfWeek = 2)) OR ((cbTue.Checked) AND (FDayOfWeek = 3)) OR ((cbWen.Checked) AND (FDayOfWeek = 4)) OR
    ((cbThu.Checked) AND (FDayOfWeek = 5)) OR ((cbFri.Checked) AND (FDayOfWeek = 6)) OR ((cbSat.Checked) AND (FDayOfWeek = 7)) OR
    ((cbSun.Checked) AND (FDayOfWeek = 1));
end;

procedure TfrmChannelAvailabilityManager.dateEditAcceptDate(Sender: TObject; var ADate: TDateTime; var CanAccept: Boolean);
var
  iCol: integer;
begin
  //
  CanAccept := (trunc(ADate) >= trunc(now)) AND (trunc(ADate) <= trunc(now) + CurrentChannelMan.FNumDays + 1);
  if CanAccept then
  begin
    startDate := ADate;
    RefreshGridsData();
    iCol := 1;
    grid.ScrollInView(1, grid.Row);
    rateGrid.ScrollInView(iCol, rateGrid.Row);
    try
      case pgcPages.ActivePageIndex of
        0:
          ActiveControl := grid;
        1:
          ActiveControl := rateGrid;
      end;
    except
      // Invisible controls cause failure
    end;
  end;
end;

procedure TfrmChannelAvailabilityManager.RemoveData;
begin
  FreeGridObject(rateGrid);
  FreeGridObject(grid);
end;

function TfrmChannelAvailabilityManager.isHiddenUnusedRow(iRow: integer): Boolean;
begin
  result := rateGrid.Objects[0, iRow] = Pointer(11);
end;

function TfrmChannelAvailabilityManager.isAvailabilityRow(iRow: integer): Boolean;
begin
  result := rateGrid.Objects[0, iRow] = Pointer(1);
end;

function TfrmChannelAvailabilityManager.isStopSellRow(iRow: integer): Boolean;
begin
  result := rateGrid.Objects[0, iRow] = Pointer(2);
end;

function TfrmChannelAvailabilityManager.isMinStayRow(iRow: integer): Boolean;
begin
  result := rateGrid.Objects[0, iRow] = Pointer(3);
end;

function TfrmChannelAvailabilityManager.isMaxStayRow(iRow: integer): Boolean;
begin
  result := rateGrid.Objects[0, iRow] = Pointer(4);
end;

function TfrmChannelAvailabilityManager.isCloseOnArrivalRow(iRow: integer): Boolean;
begin
  result := rateGrid.Objects[0, iRow] = Pointer(5);
end;

function TfrmChannelAvailabilityManager.isClosedOnDepartureRow(iRow: integer): Boolean;
begin
  result := rateGrid.Objects[0, iRow] = Pointer(6);
end;

function TfrmChannelAvailabilityManager.isLOSArrivalDateBasedRow(iRow: integer): Boolean;
begin
  result := rateGrid.Objects[0, iRow] = Pointer(7);
end;

function TfrmChannelAvailabilityManager.isSingleUsePriceRow(iRow: integer): Boolean;
begin
  result := rateGrid.Objects[0, iRow] = Pointer(8);
end;

function TfrmChannelAvailabilityManager.isAnyCheckBoxRow(iRow: integer): Boolean;
begin
  result := isStopSellRow(iRow) OR isCloseOnArrivalRow(iRow) OR isClosedOnDepartureRow(iRow) OR isLOSArrivalDateBasedRow(iRow);
end;

function TfrmChannelAvailabilityManager.SameTypeRows(iRow1, iRow2: integer): Boolean;
begin
result :=
    (isPriceRow(iRow1) AND isPriceRow(iRow2))
    OR
    (isAvailabilityRow(iRow1) AND isAvailabilityRow(iRow2))
    OR
    (isStopSellRow(iRow1) AND isStopSellRow(iRow2))
    OR
    (isMinStayRow(iRow1) AND isMinStayRow(iRow2))
    OR
    (isMaxStayRow(iRow1) AND isMaxStayRow(iRow2))
    OR
    (isCloseOnArrivalRow(iRow1) AND isCloseOnArrivalRow(iRow2))
    OR
    (isClosedOnDepartureRow(iRow1) AND isClosedOnDepartureRow(iRow2))
    OR
    (isLOSArrivalDateBasedRow(iRow1) AND isLOSArrivalDateBasedRow(iRow2))
    OR
    (isSingleUsePriceRow(iRow1) AND isSingleUsePriceRow(iRow2));
end;

function TfrmChannelAvailabilityManager.getPriceDataOfRow(iCol, iRow: integer): TPriceData;
var
  iPriceRow: integer;
begin
  result := nil;
  if (iCol < 1) OR (iRow < 1) then
    exit;
  iPriceRow := findPriceRowFrom(iRow);
  if isPriceRow(iPriceRow) then
    result := TPriceData(rateGrid.Objects[iCol, iPriceRow])
end;

function TfrmChannelAvailabilityManager.isCurrentlySelectedValueEdited(iCol, iRow: integer): Boolean;
var
  PriceData: TPriceData;
begin
  result := false;
  if (iCol < 1) OR (iRow < 1) then
    exit;

  PriceData := getPriceDataOfRow(iCol, iRow);
  if Assigned(PriceData) then
  begin
    if isPriceRow(iRow) then
      result := PriceData.FPriceDirty
    else if isAvailabilityRow(iRow) then
      result := PriceData.FAvailabilityDirty
    else if isStopSellRow(iRow) then
      result := PriceData.FStopSellDirty
    else if isMinStayRow(iRow) then
      result := PriceData.FMinStayDirty
    else if isMaxStayRow(iRow) then
      result := PriceData.FMaxStayDirty
    else if isCloseOnArrivalRow(iRow) then
      result := PriceData.FCOADirty
    else if isClosedOnDepartureRow(iRow) then
      result := PriceData.FCODDirty
    else if isLOSArrivalDateBasedRow(iRow) then
      result := PriceData.FLOSArrivalDateBasedDirty
    else if isSingleUsePriceRow(iRow) then
      result := PriceData.FSingleUsePriceDirty
    else if isStopSellRow(iRow) then
      result := PriceData.FSingleUsePriceDirty;
  end;
end;

function TfrmChannelAvailabilityManager.isAnySpecRow(iRow: integer): Boolean;
begin
  result := isAvailabilityRow(iRow) OR isStopSellRow(iRow) OR isMinStayRow(iRow) OR isMaxStayRow(iRow) OR isCloseOnArrivalRow(iRow) OR
    isClosedOnDepartureRow(iRow) OR isLOSArrivalDateBasedRow(iRow) or isSingleUsePriceRow(iRow);
end;

function TfrmChannelAvailabilityManager.isAnyEditBoxRow(iRow: integer): Boolean;
begin
  result := isAvailabilityRow(iRow) OR isMinStayRow(iRow) OR isMaxStayRow(iRow) OR isSingleUsePriceRow(iRow) OR
    (Assigned(rateGrid.Objects[1, iRow]) AND (rateGrid.Objects[1, iRow] IS TPriceData));
end;

function TfrmChannelAvailabilityManager.isAnyEditableRow(iRow: integer): Boolean;
begin
  result := isAnySpecRow(iRow) OR isAnyEditBoxRow(iRow);
end;

function TfrmChannelAvailabilityManager.isPriceRow(iRow: integer): Boolean;
begin
  result := (rateGrid.ColCount > 1) AND (iRow > 0) AND (Assigned(rateGrid.Objects[1, iRow]) AND (rateGrid.Objects[1, iRow] IS TPriceData));
end;

function TfrmChannelAvailabilityManager.isPriceCell(iCol, iRow: integer): Boolean;
begin
  result := (iCol < rateGrid.ColCount) AND (iRow < rateGrid.RowCount) AND
    (Assigned(rateGrid.Objects[iCol, iRow]) AND (rateGrid.Objects[iCol, iRow] IS TPriceData));
end;

function TfrmChannelAvailabilityManager.findPriceRowFrom(iRow: integer): integer;
var
  i: integer;
begin
  result := 1;
  for i := iRow downto 1 do
    if isPriceRow(i) then
    begin
      result := i;
      break;
    end;
end;

procedure TfrmChannelAvailabilityManager.FreeGridObject(aGrid: TadvStringGrid);
var
  iRow, iCol: integer;
  obj : TObject;
begin
  try
    for iRow := 1 to aGrid.RowCount - 1 do
      for iCol := 1 to aGrid.ColCount - 1 do
      begin
        obj := aGrid.Objects[iCol, iRow];
        if (obj <> nil) AND (obj IS TObject) then
        begin
          try
            obj.Free;
          except
          end;
          aGrid.Objects[iCol, iRow] := nil;
        end
        else if aGrid.HasCheckBox(iCol, iRow) then
        begin
          aGrid.RemoveCheckBox(iCol, iRow);
        end;
      end;
  except
  end;

  aGrid.ClearAll;
end;

procedure TfrmChannelAvailabilityManager.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  pnlHolder.parent := self;
  if embedded then
  begin
    Update;
    Action := caFree;
  end;
  if Assigned(EmbedWindowCloseEvent) then
    EmbedWindowCloseEvent(self);

  timRecalc.enabled := false;
  timStart.enabled := false;
  Halting := true;
  try
    ThreadedDataGetter.Free;
  except end;

  try
    RemoveData;
  except end;

  try FreeAndNil(rateGrid); except end;
  try FreeAndNil(grid); except end;
  try FreeAndNil(cbxShowLinkedCells); except end;
  try FreeAndNil(cbxStopMinOptions); except end;
  try FreeAndNil(pgcPages); except end;

  action := caFree;
  CHANNELMANAGER_IS_OPEN := False;
end;

procedure TfrmChannelAvailabilityManager.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := True;
  if AnyRateOrRestrictionsChanges then
    CanClose :=  MessageDLG(GetTranslatedText('shTx_ChannelAvailabilityManager_ChangesContinue'), mtWarning, [mbYes, mbCancel], 0) = mrYes;
end;

procedure TfrmChannelAvailabilityManager.FormCreate(Sender: TObject);
begin
  RoomerDataSet := CreateNewDataSet;
  pgcPages.Visible := False;
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);

  imgHelp.Hint := format('<body bgcolor="#0000FF">Color definitions in grid:<br><hr><br>' + '<font %s color="#FFFFFF"> &nbsp;&nbsp;&nbsp;&nbsp;</font>' +
    '<font bgcolor="#0000FF" color="#FFFFFF"> Rate, availability or restriction has changed.</font><br>', [GetHTMLColor(clRed, true)]) +
    format('<font %s color="#FFFFFF"> &nbsp;&nbsp;&nbsp;&nbsp;</font>' + '<font bgcolor="#0000FF" color="#FFFFFF"> Stop sell is active.</font><br>',
    [GetHTMLColor(clAqua, true)]) + format('<font %s color="#FFFFFF"> &nbsp;&nbsp;&nbsp;&nbsp;</font>' +
    '<font bgcolor="#0000FF" color="#FFFFFF"> Any restrictions active.</font><br>', [GetHTMLColor(clOlive, true)]);

  Halting := false;
  FCurrentNumDays := 400;
  AvailDict := TDictItemObjectDictionary.Create([doOwnsValues]);

  sPanel4Click(nil);

  pgcPages.ActivePageIndex := 0;

  startDate := TRUNC(now); //AvailSet['today'];
  ThreadedDataGetter := TGetThreadedData.Create;
  timStart.enabled := true;
end;

procedure TfrmChannelAvailabilityManager.FormDestroy(Sender: TObject);
var
  i: integer;
  obj: TObject;
begin
  RoomerDataset.Free;
  AvailDict.Free;
  for i := 0 to cbxChannelManagers.Items.Count-1 do
  begin
    obj := cbxChannelManagers.Items.Objects[i];
    if assigned(obj) and (obj is TChannelManagerValue) then
      cbxChannelManagers.Items.Objects[i].Free;
  end;

  for i := 0 to cbxPlanCodes.Items.Count-1 do
  begin
    obj := cbxPlanCodes.Items.Objects[i];
    if assigned(obj) and (obj is TPlanCodeValue) then
      cbxPlanCodes.Items.Objects[i].Free;
  end;
end;

procedure TfrmChannelAvailabilityManager.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
    Close;
end;

procedure TfrmChannelAvailabilityManager.timRecalcTimer(Sender: TObject);
var
  iRowCounter, iColCounter: integer;
  PriceData: TPriceData;
begin
  timRecalc.enabled := false;
  for iRowCounter := 2 to rateGrid.RowCount - 1 do
    for iColCounter := 1 to rateGrid.ColCount - 1 do
    begin
      PriceData := getPriceDataOfRow(iColCounter, iRowCounter);
      if assigned(PriceData) then
      begin
        if isPriceCell(iColCounter, iRowCounter) then
          rateGrid.Cells[iColCounter, iRowCounter] := Trim(FloatToStrF(PriceData.price, ffFixed, 12, NumDecimals(PriceData.rateRoundingType)))
        else if isSingleUsePriceRow(iRowCounter) then
          rateGrid.Cells[iColCounter, iRowCounter] := Trim(FloatToStrF(PriceData.SingleUsePrice, ffFixed, 12, NumDecimals(PriceData.rateRoundingType)));
      end;
    end;
end;

{$IFDEF DEBUG}
var
  ReadTime : Integer;
  DrawTime : Integer;

  procedure StartTimer(var timer : integer);
  begin
    timer := GetTickCount;
  end;

  procedure EndTimer(timer : integer; lab : TsLabel);
  begin
    timer := integer(GetTickCount) - timer;
    if lab.Caption = '' then
      lab.Caption := inttostr(timer)
    else
      lab.Caption := lab.Caption + ', ' + inttostr(timer);
  end;
{$ENDIF}


procedure TfrmChannelAvailabilityManager.timStartTimer(Sender: TObject);
var a, b : Boolean;
begin
  timStart.enabled := false;
  pgcPages.Visible := False;
  PrepareUserInterface;
{$IFDEF DEBUG}
      lblReadTime.Visible := True;
      lblReadTime.Caption := '';
      StartTimer(ReadTime);
{$ENDIF}
  d.roomerMainDataSet.SystemPrepareChannelRates;
{$IFDEF DEBUG}
      EndTimer(ReadTime, lblReadTime);
{$ENDIF}

  dateEdit.date := startDate;
  dateEdit.OnAcceptDate := dateEditAcceptDate;

{$IFDEF DEBUG}
      StartTimer(ReadTime);
{$ENDIF}
  a := LoadRoomTypeGroups;
{$IFDEF DEBUG}
    EndTimer(ReadTime, lblReadTime);
{$ENDIF}
{$IFDEF DEBUG}
      StartTimer(ReadTime);
{$ENDIF}
  b := LoadChannelManagers;
{$IFDEF DEBUG}
    EndTimer(ReadTime, lblReadTime);
{$ENDIF}
  if a AND b then
  begin
    rateGrid.MouseActions.RangeSelectAndEdit := true;
    InitializeBulkOperation;
  end;
end;

function InvertColor(Color: TColor): TColor;
begin
  result := clWhite;
  case Color of
    clAqua:
      result := clTeal;
    clBlack:
      result := clWhite;
    clBlue:
      result := clMaroon;
    clDkGray:
      result := clFuchsia;
    clFuchsia:
      result := clDkGray;
    clGreen:
      result := clRed;
    clLime:
      result := clSilver; // clYellow;
    clLtGray:
      result := clLime;
    clMaroon:
      result := clOlive; // clBlue;
    clNavy:
      result := clNavy;
    clOlive:
      result := clMaroon; // clNavy;
    clPurple:
      result := clGray;
    clRed:
      result := clYellow; // clGreen;
    clTeal:
      result := clAqua;
    clWhite:
      result := clBlack;
    clYellow:
      result := clRed; // clLime;
  end;
end;

function TfrmChannelAvailabilityManager.IsWeekend(ACol: integer): Boolean;
begin
  result := false;
  if ACol > 0 then
    result := (DayOfWeek(startDate + ACol - 1) IN [1, 7]);
end;

function TfrmChannelAvailabilityManager.GetDateLabel(date: TDateTime): String;
var
  FYear: Word;
  FMonthDay: Word;
  FMonth: Word;
  FMonthName: String;
  FDayOfWeek: integer;
  FDayOfWeekName: String;
  sTemp: ShortString;
  sBgBegin, sBgEnd: String;
begin
  DecodeDate(date, FYear, FMonth, FMonthDay);
  FDayOfWeek := DayOfWeek(date);
  FMonthName := FormatDateTime('mmm', date);
  FDayOfWeekName := FormatDateTime('ddd', date);
  str(FMonthDay: 2, sTemp);
  sBgBegin := '';
  sBgEnd := '';
  if FDayOfWeek in [1, 7] then
  begin
    sBgBegin := '<body bgcolor="#808080">';
    sBgEnd := '</body>';
  end;

  result := sBgBegin + '<p align="center">' + FDayOfWeekName + '</p>' + '<p align="center">' +
    '<font size="12">' + '<b>' + String(sTemp) + '</b></font></p>' + '<p align="center">' + format('%s ''%d', [FMonthName, FYear - 2000]) + '</p>' + sBgEnd;
end;

procedure TfrmChannelAvailabilityManager.gridCanEditCell(Sender: TObject; ARow, ACol: integer; var CanEdit: Boolean);
begin
  if Halting then
    exit;
  CanEdit := EditableCell(grid, ARow, ACol);
end;

procedure TfrmChannelAvailabilityManager.gridCellValidate(Sender: TObject; ACol, ARow: integer; var value: string; var Valid: Boolean);
begin
  if Halting then
    exit;
  if (StrToIntDef(value, -999999) = -999999) OR (strToInt(value) < -1) OR (strToInt(value) > 9999) then
  begin
    grid.InvalidEntryTitle := GetTranslatedText('shTx_ChannelAvailabilityManager_IncorrectAvailability');
    grid.InvalidEntryText := GetTranslatedText('shTx_ChannelAvailabilityManager_EnterValidAvailability');
    grid.InvalidEntryIcon := ieError;
    Valid := false;
  end
  else
    Valid := true;
end;

procedure TfrmChannelAvailabilityManager.gridClipboardAfterPasteCell(Sender: TObject; ACol, ARow: integer; value: string);
begin
  if Halting then
    exit;
  CorrectLinks(ACol, ARow);
end;

function TfrmChannelAvailabilityManager.EditableCell(_grid: TAdvStringGrid; ARow, ACol: integer): Boolean;
begin
  result := (copy(_grid.Cells[0, ARow], 1, 13) <> '<font></font>') AND (_grid.Cells[ACol, ARow] <> '-');
  if result AND (_grid = rateGrid) then
    result := isAnySpecRow(ARow) OR isPriceRow(ARow)
  else if result AND (_grid = grid) then
    result := (Assigned(_grid.Objects[ACol, ARow]) AND (_grid.Objects[ACol, ARow] IS TCellData) AND (TCellData(_grid.Objects[ACol, ARow]).IsEditable))
end;

function TfrmChannelAvailabilityManager.AvailabilityCell(iCol, iRow: integer): TCellData;
begin
  result := TCellData(grid.Objects[iCol, iRow]);
end;


procedure TfrmChannelAvailabilityManager.gridDrawCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
var
  fColor, bColor: TColor;
  SavedAlign: Word;
  S: String;
  available: integer;
begin
  if Halting then
    exit;
  inherited;
  if ((ARow > 0) AND (ACol > 0)) AND ((grid.Cells[ACol, ARow] = '') OR (copy(grid.Cells[0, ARow], 1, 13) = '<font></font>')) then
  begin
    if IsWeekend(ACol) then
      bColor := $00E7E7E7
    else
      bColor := clSilver;
    with grid.Canvas do
    begin
      Brush.Color := bColor;
      Brush.Style := bsSolid;
      FillRect(Rect);
    end;
    exit;
  end;

  if ((ARow > 0) AND (ACol > 0)) AND (NOT AvailabilityCell(ACol, ARow).FIsEditable) then
  begin
    if IsWeekend(ACol) then
      bColor := $00E7E7E7
    else
      bColor := clGray;
    with grid.Canvas do
    begin
      Brush.Color := bColor;
      Brush.Style := bsSolid;
      FillRect(Rect);

      Font.Color := clWhite; // InvertColor(fColor);
      Brush.Color := bColor; // InvertColor(bColor);

      if StrToIntDef(grid.Cells[ACol, ARow], 0) > -1 then
        S := grid.Cells[ACol, ARow] + '/' + inttostr(TCellData(grid.Objects[ACol, ARow]).MaxValue)
        // cell contents
      else
      begin
        S := 'auto';
        try
          S := S + ' (' + inttostr(locateAvailabilityFromRoomTypeCodeAndDate(TCellData(grid.Objects[ACol, ARow]).FRoomClassCode, TCellData(grid.Objects[ACol, ARow]).date)) + ')';
        except
        end;
      end;
      SavedAlign := SetTextAlign(Handle, TA_RIGHT);
      TextRect(Rect, Rect.Right - 4, Rect.Top + 2, S);
      SetTextAlign(Handle, SavedAlign);
    end;
    exit;
  end;

  if (ACol > 0) AND (ARow > 0) then
  begin
    fColor := clBlack;
    bColor := clWhite;
    if IsWeekend(ACol) then
      bColor := $00F6F6F6;
    if StrToIntDef(grid.Cells[ACol, ARow], 0) = 0 then
    begin
      fColor := clBlack;
      bColor := clSilver;
      if IsWeekend(ACol) then
        bColor := $00E7E7E7;
    end
    else if StrToIntDef(grid.Cells[ACol, ARow], 0) = -1 then
    begin
      fColor := clBlack;
      bColor := grid.BorderColor; // clSilver;
      if IsWeekend(ACol) then
        bColor := $00DACBBA; // clSilver;
    end;
    if (ARow > 0) AND (ACol > 0) AND (Assigned(grid.Objects[ACol, ARow]) AND (grid.Objects[ACol, ARow] IS TCellData)) then
    begin
      available := locateAvailabilityFromRoomTypeCodeAndDate(TCellData(grid.Objects[ACol, ARow]).FRoomClassCode, TCellData(grid.Objects[ACol, ARow]).date);
      if available < TCellData(grid.Objects[ACol, ARow]).FCurrentValue then
      begin
        bColor := $000080FF;
        fColor := clWhite;
      end;
    end;

    if (ARow > 0) AND (ACol > 0) AND (Assigned(grid.Objects[ACol, ARow]) AND (grid.Objects[ACol, ARow] IS TCellData)) AND
      (TCellData(grid.Objects[ACol, ARow]).originalValue <> StrToIntDef(grid.Cells[ACol, ARow], 0)) then
    begin
      TCellData(grid.Objects[ACol, ARow]).CurrentValue := StrToIntDef(grid.Cells[ACol, ARow], 0);

      if (gdSelected in State) then
      begin
        fColor := InvertColor(clWhite);
        bColor := InvertColor(clBlue);
        if IsWeekend(ACol) then
          bColor := InvertColor(clGray);
      end
      else
      begin
        bColor := clBlue;
        fColor := clWhite;
        if IsWeekend(ACol) then
          bColor := $00FF4D4D;
      end;

      available := locateAvailabilityFromRoomTypeCodeAndDate(TCellData(grid.Objects[ACol, ARow]).FRoomClassCode, TCellData(grid.Objects[ACol, ARow]).date);
      if available < TCellData(grid.Objects[ACol, ARow]).FCurrentValue then
      begin
        bColor := $000080FF;
        fColor := clWhite;
      end;

    end;

    with grid.Canvas do
    begin
      Font.Color := fColor;
      Brush.Color := bColor;
      if gdSelected in State then
      begin
        Font.Color := clWhite; // InvertColor(fColor);
        Brush.Color := clBlack; // InvertColor(bColor);
      end;
      Brush.Style := bsSolid;
      FillRect(Rect);
      if grid.Cells[ACol, ARow] = '-' then
      begin
        S := '';
        Brush.Color := fColor;
        Brush.Style := bsDiagCross;
        SetBkColor(grid.Canvas.Handle, ColorToRGB(bColor));
        FillRect(Rect);
      end
      else
      begin
        if StrToIntDef(grid.Cells[ACol, ARow], 0) > -1 then
          S := grid.Cells[ACol, ARow] + '/' + inttostr(TCellData(grid.Objects[ACol, ARow]).MaxValue)
          // cell contents
          // S := grid.Cells[ACol, ARow] // cell contents
        else
        begin
          S := 'auto';
          try
            S := S + ' (' + inttostr(locateAvailabilityFromRoomTypeCodeAndDate(TCellData(grid.Objects[ACol, ARow]).FRoomClassCode, TCellData(grid.Objects[ACol, ARow]).date)) + ')';
          except
          end;
        end;
        SavedAlign := SetTextAlign(Handle, TA_RIGHT);
        TextRect(Rect, Rect.Right - 4, Rect.Top + 2, S);
        SetTextAlign(Handle, SavedAlign);
      end;
    end;
  end
  else if (ACol > 0) AND (ARow = 0) then
  begin

  end;
end;

procedure TfrmChannelAvailabilityManager.gridEditCellDone(Sender: TObject; ACol, ARow: integer);
begin
  if Halting then
    exit;
  CorrectLinks(ACol, ARow);
end;

procedure TfrmChannelAvailabilityManager.CorrectLinks(ACol, ARow: integer);
var
  iRow: integer;
begin
  if ARow < grid.RowCount then
    for iRow := ARow to grid.RowCount - 1 do
      if Assigned(grid.Objects[ACol, iRow]) AND (grid.Objects[ACol, iRow] IS TCellData) then
      begin
        if AvailabilityCell(ACol, iRow).LinkElement = AvailabilityCell(ACol, ARow).FRoomClassCode then
          grid.Cells[ACol, iRow] := grid.Cells[ACol, ARow];
      end;
end;

procedure TfrmChannelAvailabilityManager.gridGetEditorType(Sender: TObject; ACol, ARow: integer; var AEditor: TEditorType);
begin
  if Halting then
    exit;
  AEditor := edNumeric;
end;

procedure TfrmChannelAvailabilityManager.gridGridHint(Sender: TObject; ARow, ACol: integer; var hintstr: string);
var
  available: integer;
begin
  if Halting then
    exit;
  hintstr := '';
  if EditableCell(grid, ARow, ACol) then
  begin
    available := locateAvailabilityFromRoomTypeCodeAndDate(TCellData(grid.Objects[ACol, ARow]).FRoomClassCode, TCellData(grid.Objects[ACol, ARow]).date);
    hintstr := format(GetTranslatedText('shTx_ChannelAvailabilityManager_RoomAvailability'), [BODY_START, BOLD_START, available, BOLD_END]);
  end;
end;

procedure TfrmChannelAvailabilityManager.gridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Halting then
    exit;
  if NOT grid.EditMode then
  begin
    if Key = VK_DELETE then
      if EditableCell(grid, grid.Row, grid.Col) then
        grid.Cells[grid.Col, grid.Row] := '-1';
  end
  else
  begin
    if Key = VK_RIGHT then
      if grid.Col < grid.ColCount then
        grid.Col := grid.Col + 1;
  end;
end;

procedure TfrmChannelAvailabilityManager.Image1Click(Sender: TObject);
begin
  sPanel4Click(nil);
end;

function TfrmChannelAvailabilityManager.RealNumberOfAvailabilityObjects: integer;
var
  i, i1: integer;
begin
  result := 0;
  for i := 1 to grid.RowCount - 1 do
    for i1 := 1 to grid.ColCount - 1 do
      if Assigned(grid.Objects[i1, i]) AND (grid.Objects[i1, i] IS TCellData) then
        result := result + 1;
end;

function TfrmChannelAvailabilityManager.RealNumberOfRateObjects: integer;
var
  i, i1: integer;
begin
  result := 0;
  for i := 1 to rateGrid.RowCount - 1 do
    for i1 := 1 to rateGrid.ColCount - 1 do
      if (rateGrid.Objects[i1, i] <> nil) AND (rateGrid.Objects[i1, i] IS TPriceData) then
        result := result + 1;
end;

function TfrmChannelAvailabilityManager.buildSetStatement(dirty: Boolean; var oldResultValue: String; const dirtyName, valueName, value: String): String;
var
  S: String;
  dirtyValue : Integer;
begin
  if dirty then
    dirtyValue := 1
  else
    dirtyValue := 2;
  S := format('%d AS _%s, %s AS _%s', [dirtyValue, dirtyName, value, valueName]);
  if oldResultValue = '' then
    oldResultValue := S
  else
    oldResultValue := oldResultValue + ',' + #10 + S;
end;

function TfrmChannelAvailabilityManager.buildSetStatementMinMax(
               var oldResultValue: String;
               minDirty,
               maxDirty: Boolean;
               minValue,
               maxValue : Integer): String;
var
  S: String;
  dirtyValue : Integer;
begin
// MIN Stay
  if minDirty AND ((minValue <= maxValue) OR (maxValue = 0)) then
    dirtyValue := 1
  else
    dirtyValue := 2;
  S := format('%d AS _%s, %d AS _%s', [dirtyValue, 'minStayDirty', minValue, 'minStay']);
  if oldResultValue = '' then
    oldResultValue := S
  else
    oldResultValue := oldResultValue + ',' + #10 + S;

// MAX Stay
  if maxDirty AND ((minValue <= maxValue) OR (maxValue = 0)) then
    dirtyValue := 1
  else
    dirtyValue := 2;
  S := format('%d AS _%s, %d AS _%s', [dirtyValue, 'maxStayDirty', maxValue, 'maxStay']);
  if oldResultValue = '' then
    oldResultValue := S
  else
    oldResultValue := oldResultValue + ',' + #10 + S;
end;

function TfrmChannelAvailabilityManager.AnyRateOrRestrictionsChanges : Boolean;
var iMaster, iRow, iCol : Integer;
    PriceData: TPriceData;
begin
  result := False;
  for iMaster := 0 to 1 do
  begin
    for iRow := 1 to rateGrid.RowCount - 1 do
    begin
      for iCol := 1 to rateGrid.ColCount - 1 do
      begin
        if isPriceCell(iCol, iRow) then
        begin
          PriceData := getPriceDataOfRow(iCol, iRow);
          if ((PriceData.channelId > -1) AND (iMaster=0)) OR
             ((PriceData.channelId < 0) AND (iMaster=1)) then
          begin
            result := PriceData.FPriceDirty OR
//                      PriceData.FAvailabilityDirty
                      PriceData.FStopSellDirty OR
                      PriceData.FMaxStayDirty OR
                      PriceData.FMinStayDirty OR
                      PriceData.FCOADirty OR
                      PriceData.FCODDirty OR
                      PriceData.FLOSArrivalDateBasedDirty OR
                      PriceData.FSingleUsePriceDirty;
            if result then exit;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmChannelAvailabilityManager.PublishSheet(OnlyCreateExcel: Boolean; AllowEditAndSendEmail : Boolean);
var
  list: TList<String>;
  iRow, iCol: integer;
  sql: String;

  iNumRooms : Integer;

  PriceData: TPriceData;

  iMaster: Integer;

  firstDate,
  lastDate : TDate;
  lowDate,
  hiDate : TDate;
  dates,
  topClasses : TStringlist;
  s : String;


  ExcelP : TExcelProcessors;
  ChEntity : TChannelEntity;
  ClEntity : TClassEntity;
  LastChannelCode, LastChannelName: String;

      function NumRoomsOfTopClass(TopClass : String) : Integer;
      var RoomType : String;
      begin
        result := 0;
        glb.RoomTypesSet.First;
        while NOT glb.RoomTypesSet.Eof do
        begin
          if glb.RoomTypesSet['RoomTypeGroup'] = TopClass then
          begin
            RoomType := glb.RoomTypesSet['RoomType'];
            glb.RoomsSet.First;
            while NOT glb.RoomsSet.Eof do
            begin
              if glb.RoomsSet['Active'] AND (NOT glb.RoomsSet['Wildcard']) AND (glb.RoomsSet['RoomType'] = RoomType) then
                result := result + 1;

              glb.RoomsSet.Next;
            end;
          end;
          glb.RoomTypesSet.Next;
        end;
      end;

      procedure PrepareRatesExcelSheet;
      var filename : String;
      begin
        if NOT g.qRatesManagedByRoomer then exit;

        if NOT Assigned(ExcelP) then
        begin
          filename := TPath.Combine(LocalAppDataPath, 'Roomer\' + d.roomerMainDataSet.HotelId);
          forceDirectories(filename);

          filename := TPath.Combine(Filename, 'RMS_RATES_V1.1.xls');

          d.roomerMainDataSet.SystemDownloadFileFromURI('http://roomerstore.com/templates/RMS_RATES_V1.1.xls', filename);
          ExcelP := TExcelProcessors.Create;
          ExcelP.PrepareRateChanges(filename);
        end;
      end;

      procedure AddTopClassToRatesExcelSheet(TopClass : String; NumRooms : Integer);
      begin
        if NOT g.qRatesManagedByRoomer then exit;
        ExcelP.AddTopClass(TopClass, NumRooms);
      end;

      procedure AddTopClassOccToRatesExcelSheet;
      var i1, i, iNumRooms, iAvail : Integer;
          s, topClass : String;
      begin
        if NOT g.qRatesManagedByRoomer then exit;
        for i1 := 0 to topClasses.Count - 1 do
        begin
          topClass := topClasses[i1];
          iNumRooms := NumRoomsOfTopClass(topClass);
          for i := trunc(lowDate) to trunc(hiDate) do
          begin
            s := DateToSqlString(i);
            if dates.IndexOf(s) >= 0 then
            begin
              iAvail := locateAvailabilityFromRoomTypeCodeAndDate(topClass, i);
              ExcelP.AddTopClassStatusPerDay(i, topClass, iNumRooms - iAvail);
            end;
          end;
        end;
      end;

      procedure AddChannelToRatesExcelSheet(ChannelCode, ChannelName, Header : String);
      begin
        if NOT g.qRatesManagedByRoomer then exit;
        if (LastChannelCode <> ChannelCode) OR (LastChannelName <> ChannelName) then
          ChEntity := ExcelP.CreateChannelEntity(ChannelCode, ChannelName, Header);
      end;

      procedure AddRateClassToRatesExcelSheet(RateClass : String);
      begin
        if NOT g.qRatesManagedByRoomer then exit;
        clEntity := ChEntity.CreateClassEntity(RateClass);
      end;

      procedure AddDateAndRateToRatesExcelSheet(Date : TDate; Rate, RateToHotel : Double; StopSell, CTA : Boolean; MLOS : Integer);
      begin
        if NOT g.qRatesManagedByRoomer then exit;
        if Date > lastDate then
          lastDate := Date;
        if Date < firstDate then
          firstDate := Date;
        clEntity.AddValue(Date, Rate, RateToHotel, StopSell, CTA, MLOS);
      end;

      procedure AddChannelAndRateClassToRatesExcelSheet(RateClass : String);
      begin
        if NOT g.qRatesManagedByRoomer then exit;
        clEntity := ChEntity.CreateClassEntity(RateClass);
      end;

      procedure FinalizeRatesExcelSheet;
      var filename, tempFilename, company, thisDate, mnth1, yr1, mnth2, yr2 : String;
      begin
        if NOT g.qRatesManagedByRoomer then exit;
        if Assigned(ExcelP) then
        begin
          filename := TPath.Combine(LocalAppDataPath, 'Roomer\' + d.roomerMainDataSet.HotelId);
          forceDirectories(filename);
          mnth1 := Inttostr(Month(firstDate)); if length(mnth1) = 1 then mnth1 := '0' + mnth1;
          mnth2 := Inttostr(Month(lastDate)); if length(mnth2) = 1 then mnth2 := '0' + mnth2;
          yr1 := Inttostr(Year(firstDate) - 2000);
          yr2 := Inttostr(Year(lastDate) - 2000);
          thisDate := DateToSqlString(now);
          company := ctrlGetString('CompanyName');
          tempFilename := format('%s - %s - %s%s to %s%s.xls', [company, thisDate, mnth1, yr1, mnth2, yr2]);
          filename := TPath.Combine(Filename, tempFilename);
          ExcelP.ProcessExcelSheet(filename);
          sendFileAsAttachment(ctrlGetString('CompanyEmail'), 'Rate changes', filename + '=' + extractFilename(filename), AllowEditAndSendEmail);
        end;
      end;

      procedure LogChanges(PriceData : TPriceData; RateAction : TRateAction);
      begin
        AddRateActivityLog(d.roomerMainDataSet.username,
                           RateAction,
                           PriceData.roomtypeGroupCode,
                           PriceData.FPrice,
                           PriceData.FStopSell,
                           PriceData.FMinStay,
                           PriceData.FMaxStay,
                           PriceData.FDate,
                           '');
      end;

var
    compensationPercentage : Double;
    PriceToHotel : Double;
    iTypeIndex : Integer;

begin
  ExcelP := NIL;
  ChEntity := NIL;
  ClEntity := NIL;
  firstDate := trunc(now) + 400;
  lastDate := 0;
  lowDate := trunc(now) + 400;
  hiDate := 0;
  BeginProject(RealNumberOfRateObjects);
  dates := TStringlist.Create;
  topClasses := TStringlist.Create;
  topClasses.Sorted := True;
  topClasses.Duplicates := dupIgnore;
  list := TList<String>.Create;
  try
    for iMaster := 0 to 1 do
    begin
      for iRow := 1 to rateGrid.RowCount - 1 do
      begin
        for iCol := 1 to rateGrid.ColCount - 1 do
        begin
          if isPriceCell(iCol, iRow) then
          begin
            PriceData := getPriceDataOfRow(iCol, iRow);
            if ((PriceData.channelId > -1) AND (iMaster=0)) OR
               ((PriceData.channelId < 0) AND (iMaster=1)) then
            begin
              if PriceData.isEdited OR PriceData.ForcingUpdate then
              begin
                sql := '';

                buildSetStatement(PriceData.ForcingUpdate OR PriceData.FPriceDirty, sql, 'dirty', 'price', _db(PriceData.FPrice));
                if PriceData.FPriceDirty then LogChanges(PriceData, RATE_EDIT);

                if PriceData.FMaxStayDirty AND (PriceData.FMinStay > PriceData.FMaxStay) then
                  PriceData.FMaxStayDirty := False;

                buildSetStatementMinMax(sql,
                                        PriceData.FMinStayDirty OR (PriceData.ForcingUpdate AND (PriceData.FMinStay >= 0)),
                                        PriceData.FMaxStayDirty OR (PriceData.ForcingUpdate AND (PriceData.FMaxStay >= 0)),
                                        PriceData.FMinStay,
                                        PriceData.FMaxStay);

                if PriceData.FMinStayDirty then LogChanges(PriceData, MIN_EDIT);

                if PriceData.FMaxStayDirty then LogChanges(PriceData, MAX_EDIT);

                buildSetStatement(PriceData.ForcingUpdate OR PriceData.FCOADirty, sql, 'closedOnArrivalDirty', 'closedOnArrival', BoolToString_0_1(PriceData.FCOA));
                buildSetStatement(PriceData.ForcingUpdate OR PriceData.FCODDirty, sql, 'closedOnDepartureDirty', 'closedOnDeparture',
                  BoolToString_0_1(PriceData.FCOD));

                buildSetStatement(PriceData.ForcingUpdate OR PriceData.FStopSellDirty, sql, 'stopDirty', 'stop', BoolToString_0_1(PriceData.FStopSell));
                if PriceData.FStopSellDirty then LogChanges(PriceData, STOP_EDIT);

                if PriceData.FLOSArrivalDateBased AND (PriceData.FMinStay <= 1) ANd (PriceData.FMaxStay < 1) then
                begin
                  PriceData.FLOSArrivalDateBased := False;
                  PriceData.FLOSArrivalDateBasedDirty := True;
                  iTypeIndex := findRowTypeIndex(iRow, 7);
                  if iTypeIndex > -1 then
                    SetCheckBoxCellValue(iCol, iTypeIndex, PriceData.LOSArrivalDateBased);
                end;


                buildSetStatement(PriceData.FLOSArrivalDateBasedDirty OR
                         (PriceData.FLOSArrivalDateBased AND ((PriceData.FMinStayDirty OR (PriceData.ForcingUpdate AND (PriceData.FMinStay > 0))) OR
                          (PriceData.FMaxStayDirty OR (PriceData.ForcingUpdate AND (PriceData.FMaxStay > 0))))), sql, 'lengthOfStayArrivalDateBasedDirty',
                  'lengthOfStayArrivalDateBased', BoolToString_0_1(PriceData.FLOSArrivalDateBased));
                buildSetStatement(((PriceData.FSingleUsePriceDirty OR PriceData.ForcingUpdate) AND
                     (PriceData.FSingleUsePrice > 0)), sql, 'singleUsePriceDirty', 'singleUsePrice', _db(PriceData.FSingleUsePrice));

                if g.qRatesManagedByRoomer AND (PriceData.FChannelId > 0) AND PriceData.isEdited AND PriceData.FPriceDirty then
                begin
                  if PriceData.date < lowDate then lowDate := PriceData.date;
                  if PriceData.date > hiDate then hiDate := PriceData.date;
                  PrepareRatesExcelSheet;
                  iNumRooms := NumRoomsOfTopClass(PriceData.FRoomTypeTopClass);

                  topClasses.Add(PriceData.FRoomTypeTopClass);
                  s := DateToSqlString(PriceData.date);
                  dates.Add(s);
                  AddTopClassToRatesExcelSheet(PriceData.FRoomTypeGroupCode, iNumRooms);
                  if glb.LocateSpecificRecord('channels', 'id', PriceData.FChannelId) then
                  begin
                    compensationPercentage := glb.ChannelsSet['compensationPercentage'];
                    PriceToHotel := RoundTo(PriceData.FPrice / (1 + (compensationPercentage/100)), 0.01);
                    AddChannelToRatesExcelSheet(glb.ChannelsSet['channelManagerId'], glb.ChannelsSet['name'], '-------');
                    AddRateClassToRatesExcelSheet(PriceData.FRoomTypeGroupCode);
                    AddDateAndRateToRatesExcelSheet(PriceData.date, PriceData.FPrice, PriceToHotel, PriceData.stopSell, PriceData.FCOA, PriceData.minStay);
                  end;
                end;

                sql := format('SELECT %d AS _Id, %s', [PriceData.Id, sql]);

                if NOT OnlyCreateExcel then
                begin
                  list.Add(sql);

                  if (list.Count > MAX_UPDATES_PER_CALL) then
                  begin
                    StallingProject(true);
                    if iMaster=1 then
                      PostRatesList('channelmasteravailabilityrates', list)
                    else
                      PostRatesList('channelrates', list);
                    StallingProject(false);
                  end;
                end;

                ForwardProject;
              end;
            end;
          end;
        end;

        // Clear edits as they have been posted
        if NOT OnlyCreateExcel then
          for iCol := 1 to rateGrid.ColCount - 1 do
            if isPriceCell(iCol, iRow) then
            begin
              PriceData := getPriceDataOfRow(iCol, iRow);
              if assigned(PriceData) then
              begin
                if ((PriceData.channelId > -1) AND (iMaster=0)) OR
                   ((PriceData.channelId < 0) AND (iMaster=1)) then
                begin
                  PriceData.ClearEdited;
                  PriceData.ForcingUpdate := false;
                end;
              end;
            end;
      end;

      if NOT OnlyCreateExcel then
      begin
        if list.Count > 0 then
        begin
          StallingProject(true);
          if iMaster=1 then
            PostRatesList('channelmasteravailabilityrates', list)
          else
            PostRatesList('channelrates', list);
          StallingProject(false);
        end;
      end;

    end;

    if g.qRatesManagedByRoomer then
      AddTopClassOccToRatesExcelSheet;

  finally
    list.free;
    topClasses.Free;
    dates.Free;
    ExcelP.Free;
  end;
  FinalizeRatesExcelSheet;
  EndProject;
  rateGrid.Invalidate;
end;

procedure TfrmChannelAvailabilityManager.btnPrepareExcelClick(Sender: TObject);
begin
  PublishSheet(True, False);
end;

procedure TfrmChannelAvailabilityManager.btnPublishClick(Sender: TObject);
begin
  PublishSheet(False, True);
end;

procedure TfrmChannelAvailabilityManager.btnRecalcDescendantRatesClick(Sender: TObject);
var iRow, iCol: Integer;
    PriceData : TPriceData;
    doExit : Boolean;
begin
  doExit := False;
  BeginProject(RealNumberOfRateObjects);
  rateGrid.BeginUpdate;
  try
  for iRow := 1 to rateGrid.RowCount - 1 do
  begin
    for iCol := 1 to rateGrid.ColCount - 1 do
    begin
      PriceData := getPriceDataOfRow(iCol, iRow);
      if assigned(PriceData) then
      begin
        if PriceData.channelId < 0 then
          CorrectMasterRateLinkedCells(PriceData, iCol, iRow)
        else
        begin
          doExit := False;
          Break;
        end;
        ForwardProject;
      end;
    end;
    if doExit then
      Break;
  end;
  finally
    EndProject;
    rateGrid.EndUpdate;
  end;
end;

procedure TfrmChannelAvailabilityManager.btnRefreshOneDayClick(Sender: TObject);
begin
  RefreshGridsData;
end;

procedure TfrmChannelAvailabilityManager.PostList(list: TList<String>);
begin
  if list.Count > 0 then
  begin
    RoomerDataSet.SystemFreeExecuteMultiple(list);
    list.Clear;
  end;
end;

procedure TfrmChannelAvailabilityManager.PostRatesList(const tableName : String; list: TList<String>);
var i : integer;
    sql : String;
    commands : TList<String>;
begin
  if list.Count > 0 then
  begin
    RoomerDataSet.SystemStartTransaction;
    try
      commands := TList<String>.Create;
      try
        sql := format('UPDATE %s cr JOIN (', [tableName]);
        for i := 0 to list.Count - 1 do
          if i=0 then
          sql := sql + list[i] + #10
        else
          sql := sql + format('%s %s', ['UNION ALL', list[i]]) + #10;

        sql := sql + ') vals ON cr.Id = vals._Id ' + #10 +
                     'SET dirty=IF(vals._dirty=1, vals._dirty, dirty), ' + #10 +
                     '    price=IF(vals._dirty=1, vals._price, price), ' + #10 +

                     '    minStayDirty=IF(vals._minStayDirty=1, vals._minStayDirty, minStayDirty), ' + #10 +
                     '    minStay=IF(vals._minStayDirty=1, vals._minStay, minStay), ' + #10 +

                     '    maxStayDirty=IF(vals._maxStayDirty=1, vals._maxStayDirty, maxStayDirty), ' + #10 +
                     '    maxStay=IF(vals._maxStayDirty=1, vals._maxStay, maxStay), ' + #10 +

                     '    closedOnArrivalDirty=IF(vals._closedOnArrivalDirty=1, vals._closedOnArrivalDirty, closedOnArrivalDirty), ' + #10 +
                     '    closedOnArrival=IF(vals._closedOnArrivalDirty=1, vals._closedOnArrival, closedOnArrival), ' + #10 +

                     '    closedOnDepartureDirty=IF(vals._closedOnDepartureDirty=1, vals._closedOnDepartureDirty, closedOnDepartureDirty), ' + #10 +
                     '    closedOnDeparture=IF(vals._closedOnDepartureDirty=1, vals._closedOnDeparture, closedOnDeparture), ' + #10 +

                     '    stopDirty=IF(vals._stopDirty=1, vals._stopDirty, stopDirty), ' + #10 +
                     '    stop=IF(vals._stopDirty=1, vals._stop, stop), ' + #10 +

                     '    lengthOfStayArrivalDateBasedDirty=IF(vals._lengthOfStayArrivalDateBasedDirty=1, vals._lengthOfStayArrivalDateBasedDirty, lengthOfStayArrivalDateBasedDirty), ' + #10 +
                     '    lengthOfStayArrivalDateBased=IF(vals._lengthOfStayArrivalDateBasedDirty=1, vals._lengthOfStayArrivalDateBased, lengthOfStayArrivalDateBased), ' + #10 +

                     '    singleUsePriceDirty=IF(vals._singleUsePriceDirty=1, vals._singleUsePriceDirty, singleUsePriceDirty), ' + #10 +
                     '    singleUsePrice=IF(vals._singleUsePriceDirty=1, vals._singleUsePrice, singleUsePrice); ';

        CopyToClipboard(sql);
        commands.Add(sql);
        commands.Add('update channelrates set maxStayDirty = 0 where maxStayDirty != 0 AND maxStay < minstay;');
        commands.Add('update channelrates set singleUsePriceDirty = 0 where singleUsePriceDirty != 0 AND singleUsePrice = 0;');
        RoomerDataSet.SystemFreeExecuteMultiple(commands);
      finally
        commands.Free;
      end;
      list.Clear;

      RoomerDataSet.SystemCommitTransaction;

    except
      RoomerDataSet.SystemRollbackTransaction;
    end;
  end;
end;

procedure TfrmChannelAvailabilityManager.BeginProject(numItems: integer);
begin
  prgSaving.Max := numItems;
  prgSaving.Position := 0;
  prgSaving.Width := pnlProgress.Width;
  pnlProgress.Show;
  prgSaving.Width := pnlProgress.Width;
  lblReadSave.Visible := true;
  StallingProject(false);
  Screen.Cursor := crHourglass;
end;

procedure TfrmChannelAvailabilityManager.BringWindowToFront;
begin
  pnlHolder.BringToFront;
end;

procedure TfrmChannelAvailabilityManager.EndProject;
begin
  pnlProgress.Hide;
  pnlProgress.Invalidate;
  Screen.Cursor := crDefault;
  lblReadSave.Visible := false;
  RefreshScreen;
  Application.ProcessMessages;
end;

procedure TfrmChannelAvailabilityManager.F1Click(Sender: TObject);
begin
  case pgcPages.ActivePageIndex of
    0 : ForceAvailabilityForCurrentPeriod;
    1 : ForceRateUpdateForCurrentPeriod;
  end;
end;

procedure TfrmChannelAvailabilityManager.F2Click(Sender: TObject);
begin
  case pgcPages.ActivePageIndex of
    0 : ForceFullAvailability;
    1 : ForceFullRates;
  end;
  ReloadSelectedPeriod;
end;

procedure TfrmChannelAvailabilityManager.ReloadSelectedPeriod;
begin
  cbxChannelManagersChange(cbxChannelManagers);
end;

procedure TfrmChannelAvailabilityManager.RefreshScreen;
begin
  pgcPages.Update;
  pgcPages.Invalidate;
  pnlBulkChanges.Update;
  pnlBulkChanges.Invalidate;

  Update;
  Invalidate;
end;

procedure TfrmChannelAvailabilityManager.ForwardProject;
begin
  prgSaving.Position := prgSaving.Position + 1;
  if prgSaving.Position mod 10 = 0 then
  begin
    pnlProgress.Update;
    pnlProgress.Invalidate;
    prgSaving.Update;
    prgSaving.Invalidate;
    Application.ProcessMessages;
  end;
end;

procedure TfrmChannelAvailabilityManager.StallingProject(stalled: Boolean);
begin
  if stalled then
  begin
    prgSaving.ColorSet := csBlue;
    lblReadSave.Caption := 'Saving...';
  end
  else
  begin
    prgSaving.ColorSet := csOriginal;
    lblReadSave.Caption := 'Reading...';
  end;

  prgSaving.Update;
  prgSaving.Invalidate;

  lblReadSave.Update;
  lblReadSave.Invalidate;

  Application.ProcessMessages;
end;

procedure TfrmChannelAvailabilityManager.CleanUpRedundantRoomClassesInAvailbilities;
var sql : String;
begin
  sql := 'DELETE FROM channelratesavailabilities ' +
         'WHERE date >= CURRENT_DATE ' +
         'AND ((roomClassId IN (SELECT id FROM roomtypegroups rtg WHERE rtg.id=channelratesavailabilities.roomclassId AND rtg.Code != rtg.TopClass)) ' +
         'OR ISNULL((SELECT id FROM roomtypegroups rtg WHERE rtg.id=channelratesavailabilities.roomclassId)))';
  RoomerDataSet.SystemFreeExecute(sql);
end;

procedure TfrmChannelAvailabilityManager.btnSaveClick(Sender: TObject);
var
  iRow, iCol: integer;

  force: Boolean;
  Id, dirty, Availability, SetAvailability: TList<integer>;
  sql : TList<String>;
  temp,
  tempStr : String;
  tempInt : Integer;
begin
  BeginProject(RealNumberOfAvailabilityObjects);
  force := false;
  Id := TList<integer>.Create;
  dirty := TList<integer>.Create;
  Availability := TList<integer>.Create;
  SetAvailability := TList<integer>.Create;
  sql := TList<String>.Create;
  try
    for iRow := 1 to grid.RowCount - 1 do
    begin
      for iCol := 1 to grid.ColCount - 1 do
        if Assigned(grid.Objects[iCol, iRow]) AND (grid.Objects[iCol, iRow] IS TCellData) then
        begin
          if TCellData(grid.Objects[iCol, iRow]).Changed then
          begin
            if (TCellData(grid.Objects[iCol, iRow]).ForceRefresh) AND (NOT force) then
              force := true;
            tempInt := TCellData(grid.Objects[iCol, iRow]).CurrentValue;
            Id.Add(TCellData(grid.Objects[iCol, iRow]).Id);
            dirty.Add(1);
            Availability.Add(tempInt);
            SetAvailability.Add(TCellData(grid.Objects[iCol, iRow]).MaxValue);
            tempStr := format('UPDATE channelrates SET availability = %d, availabilityDirty = 1 ' +
                              'WHERE date=''%s'' AND channelManager = %d AND planCodeId = %d AND roomClassId IN (SELECT id FROM roomtypegroups WHERE Active AND (Code=TopClass) AND (Code=''%s'' OR TopClass=''%s''))',
                              [tempInt,
                               uDateUtils.dateToSqlString(TCellData(grid.Objects[iCol, iRow]).date),
                               TCellData(grid.Objects[iCol, iRow]).ChannelManagerId,
                               TCellData(grid.Objects[iCol, iRow]).PlanCodeId,
                               TCellData(grid.Objects[iCol, iRow]).RoomClassCode,
                               TCellData(grid.Objects[iCol, iRow]).RoomClassCode]);
            sql.Add(tempStr);
            if TCellData(grid.Objects[iCol, iRow]).Edited then
              AddAvailabilityActivityLog(d.roomerMainDataSet.username,
                                         EDIT,
                                         TCellData(grid.Objects[iCol, iRow]).RoomClassCode,
                                         tempInt,
                                         TCellData(grid.Objects[iCol, iRow]).date,
                                         '');
        end;
        ForwardProject;
      end;
      if Id.Count > 0 then
      begin
        StallingProject(true);
        temp := '(TfrmChannelAvailabilityManager.btnSaveClick) Availability set for Multiple IDs';
        RoomerDataSet.SystemSetMultipleChannelAvailabilityPerId(Id, dirty, Availability, SetAvailability, force, temp);
        PostList(sql);
        for iCol := 1 to grid.ColCount - 1 do
          if Assigned(grid.Objects[iCol, iRow]) AND (grid.Objects[iCol, iRow] IS TCellData) then
          begin
            if TCellData(grid.Objects[iCol, iRow]).Changed then
            begin
              TCellData(grid.Objects[iCol, iRow]).originalValue := TCellData(grid.Objects[iCol, iRow]).CurrentValue;
              TCellData(grid.Objects[iCol, iRow]).ForceRefresh := false;
            end;
          end;

        Id.free;
        dirty.free;
        Availability.free;
        SetAvailability.free;
        sql.free;
        Id := TList<integer>.Create;
        dirty := TList<integer>.Create;
        Availability := TList<integer>.Create;
        SetAvailability := TList<integer>.Create;
        sql := TList<String>.Create;
        StallingProject(false);
      end;
    end;

  finally
    Id.free;
    dirty.free;
    Availability.free;
    SetAvailability.free;
    sql.free;
    grid.Invalidate;
    CleanUpRedundantRoomClassesInAvailbilities;
    EndProject;
  end;
end;

function TfrmChannelAvailabilityManager.PreOfButton(btn : TsButton) : String;
begin
  result := copy(btn.Name, 1, POS('_', btn.Name) - 1);
end;

function TfrmChannelAvailabilityManager.ButtonOff(const pre : String) : TsButton;
begin
  result := TsButton(FindComponent(pre + '_' + 'Off'));
end;

function TfrmChannelAvailabilityManager.ButtonOn(const pre : String) : TsButton;
begin
  result := TsButton(FindComponent(pre + '_' + 'On'));
end;

procedure TfrmChannelAvailabilityManager.btnStopSell_ClearClick(Sender: TObject);
begin
  SetButtonOnOff(ButtonOff(PreOfButton(TsButton(Sender))), False);
  SetButtonOnOff(ButtonOn(PreOfButton(TsButton(Sender))), False);
end;

procedure TfrmChannelAvailabilityManager.btnStopSell_OffClick(Sender: TObject);
begin
  SetButtonOnOff(ButtonOn(PreOfButton(TsButton(Sender))), False);
  SetButtonOnOff(TsButton(Sender), True);
end;

procedure TfrmChannelAvailabilityManager.btnStopSell_OnClick(Sender: TObject);
begin
  SetButtonOnOff(ButtonOff(PreOfButton(TsButton(Sender))), False);
  SetButtonOnOff(TsButton(Sender), True);
end;

procedure TfrmChannelAvailabilityManager.SetButtonOnOff(btn : TSButton; SetOn : Boolean);
begin
  if SetOn then
  begin
    btn.Down := True;
    btn.ImageIndex := 12;
  end else
  begin
    btn.Down := False;
    btn.ImageIndex := 11;
  end;

end;


procedure TfrmChannelAvailabilityManager.C1Click(Sender: TObject);
begin
  CurrentActiveGrid.CopySelectionToClipboard;
end;

procedure TfrmChannelAvailabilityManager.C2Click(Sender: TObject);
begin
  CurrentActiveGrid.CutSelectionToClipboard;
end;

procedure TfrmChannelAvailabilityManager.FindFirstAndLastDateInList(var firstDate, lastDate: TDateTime);
var
  i: integer;
begin
  //
  lastDate := 0;
  firstDate := startDate + FCurrentNumDays + 1;
  for i := 0 to ValueList.Count - 1 do
  begin
    if ValueList[i].ADate < firstDate then
      firstDate := ValueList[i].ADate;
    if ValueList[i].ADate > lastDate then
      lastDate := ValueList[i].ADate;
  end;
end;

procedure TfrmChannelAvailabilityManager.AssignChanges(destChannelId : Integer);
var
  i, iRow, iCol: integer;
  PriceData: TPriceData;
  firstDate, lastDate: TDateTime;
begin
  FindFirstAndLastDateInList(firstDate, lastDate);
  BeginProject(ValueList.Count * RealNumberOfRateObjects);
  try
    for i := 0 to ValueList.Count - 1 do
    begin
      for iRow := 0 to rateGrid.RowCount - 1 do
      begin
        if isAnyEditableRow(iRow) then
          for iCol := trunc(firstDate) - trunc(startDate) + 1 to trunc(lastDate) - trunc(startDate) + 1 do
          begin
            PriceData := getPriceDataOfRow(iCol, iRow);
            if Assigned(PriceData) AND (PriceData.channelId = destChannelId) then
            begin
              if (ValueList[i].RoomClassId = PriceData.roomTypeGroupId) AND (trunc(ValueList[i].ADate) = trunc(PriceData.FDate)) then
              begin
                if (ValueList[i].ValueType = vtPrice) AND isPriceCell(iCol, iRow) then
                  SetRateCellValue(iCol, iRow, PriceData, ValueList[i].value)
                else if (ValueList[i].ValueType = vtAvailability) AND isAvailabilityRow(iRow) then
                  SetAvailabilityCellValue(iCol, iRow, PriceData, ValueList[i].value)
                else if (ValueList[i].ValueType = vtMinStay) AND isMinStayRow(iRow) then
                  SetMinStayCellValue(iCol, iRow, PriceData, ValueList[i].value)
                else if (ValueList[i].ValueType = vtMaxStay) AND isMaxStayRow(iRow) then
                  SetMaxStayCellValue(iCol, iRow, PriceData, ValueList[i].value)
                else if (ValueList[i].ValueType = vtClosedOnArrival) AND isCloseOnArrivalRow(iRow) then
                begin
                  PriceData.COA := ValueList[i].value;
                  SetCheckBoxCellValue(iCol, iRow, PriceData.COA);
                end
                else if (ValueList[i].ValueType = vtClosedOnDeparture) AND isClosedOnDepartureRow(iRow) then
                begin
                  PriceData.COD := ValueList[i].value;
                  SetCheckBoxCellValue(iCol, iRow, PriceData.COD);
                end
                else if (ValueList[i].ValueType = vtStop) AND isStopSellRow(iRow) then
                begin
                  PriceData.stopSell := ValueList[i].value;
                  SetCheckBoxCellValue(iCol, iRow, PriceData.stopSell);
                end
                else if (ValueList[i].ValueType = vtLengthOfStayArrivalDateBased) AND isLOSArrivalDateBasedRow(iRow) then
                begin
                  PriceData.LOSArrivalDateBased := ValueList[i].value;
                  SetCheckBoxCellValue(iCol, iRow, PriceData.LOSArrivalDateBased);
                end
                else if (ValueList[i].ValueType = vtSingleUsePrice) AND isSingleUsePriceRow(iRow) then
                begin
                  SetSingleUsePriceCellValue(iCol, iRow, PriceData, ValueList[i].value);
                end;
              end;
            end;
          end;
      end;
      ForwardProject;
    end;
  finally
    EndProject;
    ValueList.Clear;
  end;
end;

procedure TfrmChannelAvailabilityManager.C3Click(Sender: TObject);
var
  PriceData: TPriceData;
  var chId : Integer;
begin
  if isAnyEditableRow(rateGrid.Row) then
  begin
    PriceData := getPriceDataOfRow(rateGrid.Col, rateGrid.Row);
    chId := PriceData.FChannelId;
    if CopyChannelSettings(chId, CurrentChannelMan.FId, GetPlanCodeId) then
      AssignChanges(chId);
  end;
end;

function TfrmChannelAvailabilityManager.CurrentActiveGrid: TAdvStringGrid;
begin
  result := rateGrid;
  case pgcPages.ActivePageIndex of
    0:
      result := grid;
    1:
      result := rateGrid;
  end;
end;

procedure TfrmChannelAvailabilityManager.cbxChannelClickCheck(Sender: TObject);
begin
  LoadRoomTypeGroupsForBulk;
end;

function TfrmChannelAvailabilityManager.AddCheckEditItem(comp : TCheckComboBox; line : String; obj : TObject) : Integer;
var newLine : String;
begin
  newLine := replaceString(line, ',', '|');
  result := comp.Items.AddObject(newLine, obj);
end;

procedure TfrmChannelAvailabilityManager.cbxChannelCloseUp(Sender: TObject);
var channelRelations : TRoomerDataSet;
    sql : String;
    channelId : Pointer;
  i: Integer;

    function roomClassInList(roomClassId : TObject) : Boolean;
    var cRoomClass, cChannel : Pointer;
    begin
      result := False;
      channelRelations.First;
      while NOT channelRelations.Eof do
      begin
        cRoomClass := Pointer(channelRelations.FieldByName('roomClassId').AsInteger);
        cChannel := Pointer(channelRelations.FieldByName('channelId').AsInteger);
        if (cRoomClass = roomClassId) AND
           (cChannel = channelId) then
        begin
          result := true;
          Break;
        end;
        channelRelations.Next;
      end;
    end;
begin
  cbxRoomTypes.Items.Clear;
  cbxRoomTypes.Items.Add(GetTranslatedText('shTx_ChannelAvailabilityManager_AllRoomTypes'));
  sql := 'SELECT * FROM channelclassrelations';
  channelRelations := RoomerDataSet.ActivateNewDataset(RoomerDataSet.queryRoomer(sql));
  channelId := nil;
  for i := 0 to cbxChannel.Items.Count - 1 do
  begin
    channelId := cbxChannel.Items.Objects[i];
    ARoomTypeSet.First;
    while (NOT ARoomTypeSet.EOF) do
    begin
      if (channelID = nil) OR
        roomClassInList(Pointer(ARoomTypeSet.FieldByName('id').AsInteger))  then
          AddCheckEditItem(cbxRoomTypes, format('%s - %s', [ARoomTypeSet['code'], ARoomTypeSet['description']]), Pointer(ARoomTypeSet.FieldByName('id').AsInteger));
      ARoomTypeSet.next;
    end;
  end;
end;

procedure TfrmChannelAvailabilityManager.cbxChannelManagersChange(Sender: TObject);
var
  cmIndex: integer;
begin
  cmIndex := cbxChannelManagers.ItemIndex;
  if cmIndex < 0 then
    exit;
  CurrentChannelMan := TChannelManagerValue(cbxChannelManagers.Items.Objects[cmIndex]);
  pgcPages.ActivePageIndex := 1;
  pgcPagesChange(pgcPages);
  RefreshGridsData;
end;

procedure TfrmChannelAvailabilityManager.RefreshGridsData;
var MaxDate : Integer;
begin
  try
    if __cbxVisibleDays.ItemIndex = -1 then
       __cbxVisibleDays.ItemIndex := 0;
    NUMBER_OF_DAYS_DISPLAYED := StrToIntDef(__cbxVisibleDays.Items[__cbxVisibleDays.ItemIndex], 0) - 1;
    if NUMBER_OF_DAYS_DISPLAYED < 0 then
    begin
      BlinkCombo;
      exit;
    end;

    MaxDate := TRUNC(now) + CurrentChannelMan.FNumDays;
    dateEdit.MinDate := TRUNC(now);
    dateEdit.MaxDate := MaxDate;


    dtBulkFrom.MinDate := startDate;
    dtBulkFrom.MaxDate := startDate + NUMBER_OF_DAYS_DISPLAYED;
    if dtBulkFrom.MaxDate > MaxDate then
      dtBulkFrom.MaxDate := MaxDate;
    dtBulkTo.MinDate := startDate;
    dtBulkTo.MaxDate := startDate + NUMBER_OF_DAYS_DISPLAYED;
    if dtBulkTo.MaxDate > MaxDate then
      dtBulkTo.MaxDate := MaxDate;
    Screen.Cursor := crHourglass;
    try
      RemoveData;
      sTabSheet1.TabVisible := true; // NOT onlyDirectConnection;
      cbxExtraRestrictions.Checked := false;
      cbxExtraRestrictions.Tag := 0;

      ShowRatesForSelectedChannelManager;
      ShowAvailabilityForSelectedChannelManager;

      InitializeBulkOperation;
      GetStatusOfRoomClasses;
    finally
      Screen.Cursor := crDefault;
    end;
  finally
    timBringToFront.Enabled := True;
  end;
end;

procedure TfrmChannelAvailabilityManager.cbxStopMinOptionsClick(Sender: TObject);
begin
  TsCheckBox(Sender).Tag := ABS(ORD(TsCheckBox(Sender).Checked));
  HideShowExtraCells;
end;

procedure TfrmChannelAvailabilityManager.GetStatusOfRoomClasses;
var
  cmIndex: integer;
  sFrom, sTo: String;
  sql: String;
begin
  cmIndex := cbxChannelManagers.ItemIndex;
  if cmIndex < 0 then
    exit;
  FCurrentNumDays := NUMBER_OF_DAYS_DISPLAYED; // ChannelMan.FNumDays;

  sFrom := uDateUtils.dateToSqlString(startDate);
  sTo := uDateUtils.dateToSqlString(startDate + FCurrentNumDays); // ChannelMan.FNumDays);

  sql := format('SELECT DISTINCT pdd.date, rtg.Code, rtg.searchCode, rtg.Description, getRoomClassAvailability(rtg.Code, pdd.date) AS freeRooms ' +
    ' FROM (SELECT Active, Code, Description, TopClass AS searchCode FROM ' + '     roomtypegroups) rtg, ' + '     predefineddates pdd ' +

    'WHERE rtg.Active ' + 'AND rtg.Code=rtg.searchCode ' + 'AND pdd.date>=''%s'' AND pdd.date<=DATE_ADD(''%s'',INTERVAL %d DAY) ' +
    'GROUP BY pdd.date, rtg.code ' + 'ORDER BY pdd.date, rtg.code ', [sFrom, sFrom, FCurrentNumDays]);
  ThreadedDataGetter.execute(sql, BackgroundAvailabilityFetchHandler);
end;

procedure TfrmChannelAvailabilityManager.BackgroundAvailabilityFetchHandler(Sender : TObject);
var
  AvailabilitySet: TRoomerDataSet;
begin
  try
    AvailabilitySet := ThreadedDataGetter.RoomerDataSet;
    PrepareAvailDictionary(AvailabilitySet);
    ThreadedDataGetter.RoomerDataSet.Close;
    ThreadedDataGetter.RoomerDataSet.Recordset := nil;
  except
  end;
end;

procedure TfrmChannelAvailabilityManager.PrepareAvailDictionary(AvailabilitySet: TRoomerDataSet);
var i : Integer;
begin
  AvailDict.Clear;
  i := 0;
  AvailabilitySet.First;
  while NOT AvailabilitySet.EOF do
  begin
    AvailDict.Add(AvailabilitySet['searchCode'] + '_' + uDateUtils.dateToSqlString(AvailabilitySet['date']),
      TDictionaryItem.Create(AvailabilitySet['searchCode'], AvailabilitySet['date'], AvailabilitySet['freeRooms']));
    AvailabilitySet.next;
    inc(i);
    if i>=100 then
    begin
      Application.processMessages;
      i := 0;
    end;
  end;
end;

procedure TfrmChannelAvailabilityManager.PrepareUserInterface;
begin
  // 2016-9-21: Disabled for now as no hotel uses it and it can raise an AV
  btnPrepareExcel.Visible := False; //g.qRatesManagedByRoomer;
  cbxChannelManagers.Visible := NOT frmMain.RBEMode;
  cbxPlanCodes.Visible := NOT frmMain.RBEMode;
end;

procedure TfrmChannelAvailabilityManager.dtBulkToChange(Sender: TObject);
begin
  btnApplyBulk.enabled := (((edtAvail.Text <> '') AND (StrToIntDef(edtAvail.Text, 0) >= -1)) OR (cbxAvailType.ItemIndex >= 2 - pgcPages.ActivePageIndex) OR
    (pgcPages.ActivePageIndex = 1)) AND (trunc(dtBulkFrom.date) >= trunc(startDate)) AND (trunc(dtBulkTo.date) >= trunc(dtBulkFrom.date));
  if dtBulkTo.date < dtBulkFrom.date then
    dtBulkTo.date := dtBulkFrom.date;
end;

function TfrmChannelAvailabilityManager.LoadChannelManagers: Boolean;
var
  ASet: TRoomerDataSet;
begin
  cbxChannelManagers.OnChange := nil;
  cbxChannelManagers.Items.BeginUpdate;
  try
    cbxChannelManagers.Items.Clear;    
    ASet := RoomerDataSet.ActivateNewDataset
      (RoomerDataSet.queryRoomer
      ('SELECT id, description, maintenanceDays  FROM channelmanagers WHERE active AND (NOT ISNULL(channels)) AND channels<>'''''));
    try
      ASet.First;
      while (NOT ASet.EOF) do
      begin
        cbxChannelManagers.Items.AddObject(ASet['Description'], TChannelManagerValue.Create(ASet['id'], ASet['description'], '', '', ASet['maintenanceDays']));
        ASet.next;
      end;
      cbxChannelManagers.ItemIndex := 0;
    finally
      FreeAndNil(ASet);
    end;
    result := LoadPlanCodes;
    if NOT result then
      exit;
  finally
    cbxChannelManagers.Items.EndUpdate;
    cbxChannelManagers.OnChange := cbxChannelManagersChange;
  end;
  result := cbxChannelManagers.Items.Count > 0;
  if result then
    ReloadSelectedPeriod
  else
  begin
    MessageDLG(GetTranslatedText('shTx_ChannelAvailabilityManager_NoChannelManagersDefined'), mtError, [mbOk], 0);
  end;
end;

function TfrmChannelAvailabilityManager.LoadPlanCodes: Boolean;
var
  ASet: TRoomerDataSet;
begin
  cbxPlanCodes.OnChange := nil;
  cbxPlanCodes.Items.BeginUpdate;
  try
    cbxPlanCodes.Items.Clear;
    ASet := RoomerDataSet.ActivateNewDataset(RoomerDataSet.queryRoomer('SELECT * FROM channelplancodes WHERE active'));
    try
      ASet.First;
      while (NOT ASet.EOF) do
      begin
        cbxPlanCodes.Items.AddObject(format('%s - %s', [ASet['code'], ASet['description']]), TPlanCodeValue.Create(ASet['id'], ASet['code'],
          ASet['description']));
        ASet.next;
      end;
      cbxPlanCodes.ItemIndex := 0;
    finally
      FreeAndNil(ASet);
    end;
  finally
    cbxPlanCodes.Items.EndUpdate;
    cbxPlanCodes.OnChange := cbxChannelManagersChange;
  end;
  result := cbxPlanCodes.Items.Count > 0;
  if NOT result then
    MessageDLG(GetTranslatedText('shTx_ChannelAvailabilityManager_NoPlanCodesDefined'), mtError, [mbOk], 0);
end;

function TfrmChannelAvailabilityManager.LoadRoomTypeGroups: Boolean;
var i : Integer;
    sql : String;
begin
{$IFDEF DEBUG}
  lblDrawTime.Visible := True;
  lblDrawTime.Caption := '';
{$ENDIF}
  cbxRoomTypes.BulkChanging := True;
  try
    cbxRoomTypes.Items.Clear;
    sql := 'SELECT rtg.* FROM roomtypegroups rtg WHERE Active AND rtg.id IN (SELECT roomClassId FROM channelclassrelations) ORDER BY orderIndex, TopClass, Code';

    ARoomTypeSet := RoomerDataSet.ActivateNewDataset(RoomerDataSet.queryRoomer(sql));
    ARoomTypeSet.First;
    while (NOT ARoomTypeSet.EOF) do
    begin
{$IFDEF DEBUG}
      StartTimer(DrawTime);
{$ENDIF}
      i := AddCheckEditItem(cbxRoomTypes, format('%s - %s', [ARoomTypeSet['code'], ARoomTypeSet['description']]), Pointer(ARoomTypeSet.FieldByName('id').AsInteger));
{$IFDEF DEBUG}
      EndTimer(DrawTime, lblDrawTime);
{$ENDIF}
{$IFDEF DEBUG}
      StartTimer(DrawTime);
{$ENDIF}
      cbxRoomTypes.Checked[i] := (LowerCase(ARoomTypeSet['Code']) = LowerCase(ARoomTypeSet['TopClass']));
{$IFDEF DEBUG}
      EndTimer(DrawTime, lblDrawTime);
{$ENDIF}
      ARoomTypeSet.next;
    end;
    result := cbxRoomTypes.Items.Count > 0;
  finally
    cbxRoomTypes.BulkChanging := False;
  end;
  if NOT result then
  begin
    MessageDLG(GetTranslatedText('shTx_ChannelAvailabilityManager_NoRoomTypeGroupsDefined'), mtError, [mbOk], 0);
  end;
end;

function TfrmChannelAvailabilityManager.LoadRoomTypeGroupsForBulk: Boolean;
var i : Integer;
    sql : String;
    sList : String;
begin
  cbxRoomTypes.BulkChanging := True;
  try
    cbxRoomTypes.Text := '';
    cbxRoomTypes.Items.Clear;
    sList := '';
    glb.ChannelsSet.First;
    while NOT glb.ChannelsSet.Eof  do
    begin
      if IsIdCheckedInCheckListCombo(cbxChannel, glb.ChannelsSet['id']) then
        if sList = '' then
          sList := inttostr(glb.ChannelsSet['id'])
        else
          sList := sList + ',' + inttostr(glb.ChannelsSet['id']);
      glb.ChannelsSet.Next;
    end;
    for i := 0 to cbxChannel.Items.Count - 1 do
      if cbxChannel.Checked[i] then
        if cbxChannel.Items.Objects[i] = Pointer(-1) then
        begin
          sList := '';
          Break;
        end;

    if sList <> '' then
      sList := format('id IN (%s) AND', [sList]);
    sql := format('SELECT rtg.* FROM roomtypegroups rtg WHERE Active ' +
                  'AND rtg.id IN ' +
                  '   (SELECT roomClassId FROM channelclassrelations ' +
                  '    WHERE channelId IN (SELECT id FROM channels ch WHERE %s ' +
                  '                        (SELECT FIND_IN_SET(ch.id, channels) FROM channelmanagers WHERE id=%d)))', [sList, CurrentChannelMan.FId]);

  
    ARoomTypeSet := RoomerDataSet.ActivateNewDataset(RoomerDataSet.queryRoomer(sql));
    ARoomTypeSet.First;
    while (NOT ARoomTypeSet.EOF) do
    begin
      i := AddCheckEditItem(cbxRoomTypes, format('%s - %s', [ARoomTypeSet['code'], ARoomTypeSet['description']]), Pointer(ARoomTypeSet.FieldByName('id').AsInteger));
      cbxRoomTypes.Checked[i] := True; // (LowerCase(ARoomTypeSet['Code']) = LowerCase(ARoomTypeSet['TopClass']));
      ARoomTypeSet.next;
    end;
    result := cbxRoomTypes.Items.Count > 0;
  finally
    cbxRoomTypes.BulkChanging := False;
  end;
  if NOT result then
  begin
    MessageDLG(GetTranslatedText('shTx_ChannelAvailabilityManager_NoRoomTypeGroupsDefined'), mtError, [mbOk], 0);
  end;
end;

procedure TfrmChannelAvailabilityManager.ShowAvailabilityForSelectedChannelManager;
var
  AvailSet, ASet: TRoomerDataSet;
  iRow: integer;
  iCol: integer;

  sFrom, sTo: String;

  cmIndex, cmId: integer;
  pcIndex, pcId: integer;

  iIndex: integer;
  Editable: Boolean;

  sql: String;

  ChannelMan: TChannelManagerValue;
begin
  EmptyGrid(grid);
  cmIndex := cbxChannelManagers.ItemIndex;
  if cmIndex < 0 then
    exit;
  ChannelMan := TChannelManagerValue(cbxChannelManagers.Items.Objects[cmIndex]);
  cmId := ChannelMan.FId;
  FCurrentNumDays := NUMBER_OF_DAYS_DISPLAYED; // ChannelMan.FNumDays;

  pcIndex := cbxPlanCodes.ItemIndex;
  if pcIndex < 0 then
    exit;
  pcId := TPlanCodeValue(cbxPlanCodes.Items.Objects[pcIndex]).FId;

  sFrom := uDateUtils.dateToSqlString(startDate);
  sTo := uDateUtils.dateToSqlString(startDate + FCurrentNumDays); // ChannelMan.FNumDays);

  sql := format('SELECT *, CONCAT(rtg.OrderIndex, ''x'', rtg.TopClass, ''x'', rtg.Code) AS OrderID FROM roomtypegroups rtg ' +
    'WHERE rtg.Active AND rtg.sendAvailability AND (ISNULL(rtg.TopClass) OR (rtg.TopClass='''') OR (rtg.TopClass=rtg.Code)) ' +
    '  AND rtg.id IN ' +
    ' (SELECT roomClassId FROM channelclassrelations ccr ' +
    '  WHERE FIND_IN_SET(ccr.channelId, (SELECT channels FROM channelmanagers WHERE id=%d)) ' +
    '  AND (SELECT activePlanCode FROM channels WHERE id=ccr.channelId)=%d ' +
    ' ) ' +
    'ORDER BY OrderID', [cmId, pcId]);
  AvailSet := RoomerDataSet.ActivateNewDataset(RoomerDataSet.queryRoomer(sql));
  try
    AvailSet.First;
    if AvailSet.EOF then
      exit;
    grid.BeginUpdate;
    try
      grid.RowCount := AvailSet.RecordCount + 1;
      grid.ColCount := FCurrentNumDays + 2;
      iRow := 0;
{$IFDEF DEBUG}
      StartTimer(ReadTime);
{$ENDIF}
      ASet := RoomerDataSet.ActivateNewDataset(RoomerDataSet.SystemGetAvailabilities(startDate, NUMBER_OF_DAYS_DISPLAYED, cmId, pcId));
{$IFDEF DEBUG}
      EndTimer(ReadTime, lblReadTime);
{$ENDIF}
{$IFDEF DEBUG}
      StartTimer(DrawTime);
{$ENDIF}
      ASet.First;
      try
        AvailSet.First;
        while (NOT AvailSet.EOF) do
        begin
          inc(iRow);
          iCol := 0;
          // <font></font>
          grid.Cells[0, iRow] := format('<p align="Right"><b>%s [%s]</p>', [AvailSet['Description'], AvailSet['Code']]);
          if SeekRecordValue(ASet, 'roomClassId', AvailSet['id']) then
            while (NOT ASet.EOF) AND (ASet['roomClassId'] = AvailSet['id']) do
            begin
              inc(iCol);
              if iRow = 1 then
              begin
                grid.Cells[iCol, 0] := GetDateLabel(ASet['date']);
              end;
              Editable := ASet['Editable'] = 1;
              if NOT Editable then
              begin
                iIndex := FindRoomClassRow(ASet['LinkedTo']);
                if iIndex > -1 then
                  grid.Cells[iCol, iRow] := grid.Cells[iCol, iIndex]
                  // FindRoomClassRow(ASet['LinkedTo'])]
                else
                begin
                  Editable := true;
                  grid.Cells[iCol, iRow] := ASet['availability'];
                end;
              end
              else
                grid.Cells[iCol, iRow] := ASet['availability'];

              if assigned(grid.Objects[iCol, iRow]) and (grid.Objects[iCol, iRow] is TObject) then
                grid.Objects[iCol, iRow].Free;

              grid.Objects[iCol, iRow] := TCellData.Create(ASet['id'], ASet['date'], Editable, ASet['LinkedTo'], ASet['planCodeId'], ASet['roomClassId'],
                ASet['channelManagerId'], ASet['rtgCode'], ASet['availability'], ASet['setAvailability']);
              ASet.next;
            end;

          AvailSet.next;
        end;
      finally
        FreeAndNil(ASet);
      end;
{$IFDEF DEBUG}
      EndTimer(DrawTime, lblDrawTime);
{$ENDIF}
    finally
      HideShowLinkedClasses;
      grid.EndUpdate;
    end;
  finally
    FreeAndNil(AvailSet);
  end;
end;

function TfrmChannelAvailabilityManager.FindRoomClassRow(const Code: String): integer;
var
  iRow: integer;
begin
  result := -1;
  for iRow := 1 to grid.RowCount - 1 do
  begin
    if Assigned(grid.Objects[1, iRow]) and (grid.Objects[1, iRow] IS TCellData) AND (TCellData(grid.Objects[1, iRow]).RoomClassCode = Code) then
    begin
      result := iRow;
      break;
    end;
  end;

end;

function TfrmChannelAvailabilityManager.SeekRecordValue(ASet: TRoomerDataSet; const fieldNameToSeek: String; fieldValue: integer): Boolean;
begin
  result := false;
  ASet.First;
  while NOT ASet.EOF do
  begin
    if ASet[fieldNameToSeek] = fieldValue then
    begin
      result := true;
      break;
    end;
    ASet.next;
  end;
end;

function TfrmChannelAvailabilityManager.GetChannelManagerId: integer;
var
  cmIndex: integer;
begin
  result := -1;
  cmIndex := cbxChannelManagers.ItemIndex;
  if cmIndex < 0 then
    exit;
  CurrentChannelMan := TChannelManagerValue(cbxChannelManagers.Items.Objects[cmIndex]);
  result := CurrentChannelMan.FId;
end;

function TfrmChannelAvailabilityManager.GetPlanCodeId: integer;
var
  pcIndex: integer;
begin
  result := -1;
  pcIndex := cbxPlanCodes.ItemIndex;
  if pcIndex < 0 then
    exit;
  result := TPlanCodeValue(cbxPlanCodes.Items.Objects[pcIndex]).FId;
end;

function TfrmChannelAvailabilityManager.findIdInCheckListCombo(cbx : TCheckComboBox; id : Integer) : Integer;
var i : Integer;
begin
  result := -1;
  for i := 0 to cbx.Items.Count - 1 do
    if cbx.Items.Objects[i] = Pointer(id) then
    begin
      result := i;
      Break;
    end;
end;


procedure TfrmChannelAvailabilityManager.BlinkCombo;
begin
  pgcPages.Visible := False;
  timBlink.Tag := 0;
  __cbxVisibleDays.SkinData.CustomColor := True;
  __cbxVisibleDays.SkinData.CustomFont := True;
  __cbxVisibleDays.Color := clRed;
  __cbxVisibleDays.Font.Color := clWhite;
  __cbxVisibleDays.Update;
  timBlink.Enabled := true;
end;

procedure TfrmChannelAvailabilityManager.timBlinkTimer(Sender: TObject);
begin
  timBlink.Enabled := false;
  try
  timBlink.Tag := timBlink.Tag + 1;
  if ODD(timBlink.Tag) then
  begin
    __cbxVisibleDays.Color := clWhite;
    __cbxVisibleDays.Font.Color := clBlack;
  end else
  begin
    __cbxVisibleDays.Color := clRed;
    __cbxVisibleDays.Font.Color := clWhite;
  end;
  finally
    timBlink.Enabled := timBlink.Tag < 11;
    if NOT timBlink.Enabled then
    begin
      __cbxVisibleDays.Color := clWhite;
      __cbxVisibleDays.Font.Color := clBlack;
      __cbxVisibleDays.SkinData.CustomColor := False;
      __cbxVisibleDays.SkinData.CustomFont := False;
    end;
  end;
end;



procedure TfrmChannelAvailabilityManager.timBringToFrontTimer(Sender: TObject);
begin
  timBringToFront.Enabled := False;
  SetFormTopmostOn(self);
  sleep(10);
  Application.ProcessMessages;
  SetFormTopmostOff(self);
end;

function TfrmChannelAvailabilityManager.IsIdCheckedInCheckListCombo(cbx : TCheckComboBox; id : Integer) : Boolean;
var i : Integer;
begin
  result := false;
  i := findIdInCheckListCombo(cbx, id);
  if i>=0 then
    result := cbx.Checked[i];
end;

procedure TfrmChannelAvailabilityManager.ShowRatesForSelectedChannelManager;
var
  i: integer;
  AvailSet, RateSet: TRoomerDataSet;
  iLastRoomClassId: integer;
  iRow, iRateCol: integer;
  iRateRow: integer;

  chId : Integer;
  cmId: integer;
  pcId: integer;

  price: Double;

  PriceData: TPriceData;
  iCountLine: integer;

  tempSpaces : String;

  function anyDirectConnectionChannel(ASet : TRoomerDataSet) : Boolean;
  begin
    result := False;
    ASet.First;
    while NOT (ASet.Eof OR result) do
    begin
      result := ASet['directConnection'];
      if result then break;

      ASet.Next;
    end;
    ASet.First;
  end;

  function onlyDirectConnectionChannel(ASet : TRoomerDataSet) : Boolean;
  begin
    result := False;
    ASet.First;
    while NOT (ASet.Eof OR result) do
    begin
      result := NOT ASet['directConnection'];
      if result then break;

      ASet.Next;
    end;
    ASet.First;
    result := NOT result;
  end;

var channels : String;
    channelId : Integer;
    isCurrentDirectConnection : Boolean;

begin
  EmptyGrid(rateGrid);
  cbxChannel.BulkChanging := True;
  try
  cmId := GetChannelManagerId;
  if cmId < 0 then
    exit;
  FCurrentNumDays := NUMBER_OF_DAYS_DISPLAYED; //CurrentChannelMan.FNumDays;
  pgcPages.Visible := False;
  try

  {$IFDEF DEBUG}
      lblReadTime.Visible := True;
      lblDrawTime.Visible := True;
      lblReadTime.Caption := '';
      lblDrawTime.Caption := '';
      ReadTime := 0;
      DrawTime := 0;
  {$ELSE}
      lblReadTime.Visible := False;
      lblDrawTime.Visible := False;
  {$ENDIF}


    pcId := GetPlanCodeId;
    if pcId < 0 then
      exit;

    AvailSet := RoomerDataSet.ActivateNewDataset(RoomerDataSet.queryRoomer(
                   format('SELECT CURRENT_DATE AS today, ch.id AS chId, ch.Name AS channelName, ch.directConnection, ch.rateRoundingType ' +
                          ', to_bool((SELECT masterRatesActive FROM hotelconfigurations LIMIT 1)) AS masterRatesActive ' +
                          'FROM channelmanagers cm, ' +
                          '    channels ch ' +
                          'WHERE cm.id=%d ' +
                          'AND FIND_IN_SET(ch.id, cm.channels) ' +
                          'AND ch.activePlanCode=%d ' +
                          'UNION ALL ' +
                          'SELECT CURRENT_DATE AS today, ' +
                          ' -1 AS chId, ''MASTER RATE'' AS channelName, EXISTS(SELECT id FROM channels WHERE directConnection LIMIT 1) AS directConnection, 3 AS rateRoundingType ' +
                          ', to_bool((SELECT masterRatesActive FROM hotelconfigurations LIMIT 1)) AS masterRatesActive ' +
                          'ORDER BY IF(chId=-1, '''', channelName) ', [cmId, pcId])));

    cbxChannel.OnClickCheck := Nil;
    ccChannels.OnClickCheck := Nil;
    cbxChannel.Items.Clear;
    ccChannels.Items.Clear;
    try
      AvailSet.First;
      if AvailSet.EOF then
        exit;

      channelId := -1;
      if availSet['masterRatesActive'] then
      begin
        channels := '-2';
        channelId := -2;
      end
      else
      begin
        channels := '';
        AvailSet.Next;
      end;

  {$IFDEF DEBUG}
      StartTimer(ReadTime);
  {$ENDIF}
      rateSet := RoomerDataSet.ActivateNewDataset(RoomerDataSet.SystemGetChannelRates1812(startDate, NUMBER_OF_DAYS_DISPLAYED, channelId, cmId, pcId));
  {$IFDEF DEBUG}
      EndTimer(ReadTime, lblReadTime);
  {$ENDIF}


      while NOT AvailSet.EOF do
      begin
        if AvailSet['chId'] <> -1 then
        begin
          if channels = '' then
            channels := inttostr(AvailSet['chId'])
          else
            channels := channels + ',' + inttostr(AvailSet['chId']);
        end;
        AvailSet.Next;
      end;

      anyDirectConnection := anyDirectConnectionChannel(AvailSet);
      onlyDirectConnection := onlyDirectConnectionChannel(AvailSet);
      NumLinesPerRateEntity := 7 + ABS(ORD(anyDirectConnection));


      rateGrid.OnCellValidate := nil;
      rateGrid.OnCheckBoxChange := nil;
      rateGrid.OnDrawCell := nil;
      rateGrid.OnGetAlignment := nil;
      rateGrid.OnGetCellBorder := nil;
      rateGrid.OnGetCellColor := nil;

      rateGrid.BeginUpdate;
      try
        rateGrid.RowCount := 2;
        rateGrid.ColCount := FCurrentNumDays + 2;
        for i := 1 to FCurrentNumDays + 1 do
          rateGrid.Cells[i, 0] := GetDateLabel(startDate + i - 1);

        iRow := 0;
        AvailSet.First;
        if NOT availSet['masterRatesActive'] then
          AvailSet.Next; // Skip the first one because it is a master rate.

  {$IFDEF DEBUG}
          StartTimer(DrawTime);
  {$ENDIF}
        while (NOT AvailSet.EOF) do
        begin
          inc(iRow);
          rateGrid.RowCount := iRow + 3;
          iLastRoomClassId := -2;

          rateGrid.Cells[0, iRow] := '<font></font><body bgcolor="#0000FF"><p align="center"><font color="#FFFFFF" size="11"><b>' + AvailSet['channelName'] +
            '</font></p></body>';
          i := AddCheckEditItem(cbxChannel, AvailSet['channelName'], TObject(AvailSet.FieldByName('chid').AsInteger));
          cbxChannel.Checked[i] := (AvailSet['chid'] < 0);
          if AvailSet['chid'] > 0 then
          begin
            i := AddCheckEditItem(ccChannels, AvailSet['channelName'], TObject(AvailSet.FieldByName('chid').AsInteger));
            ccChannels.Checked[i] := True;
          end;

          for i := 1 to FCurrentNumDays + 1 do
          begin
            rateGrid.Objects[i, iRow] := nil;
            rateGrid.Cells[i, iRow] := '-';
          end;

          chId := AvailSet['chid'];

          iRateRow := 0;
          RateSet.First;
          while (NOT RateSet.EOF) do
          begin
            if RateSet['channelId'] = chId then
            begin
              isCurrentDirectConnection := AvailSet['directConnection'];
              if (iLastRoomClassId <> RateSet['roomClassId']) then
              begin
                inc(iRow);
                rateGrid.RowCount := iRow + 3;
                iRateRow := iRow;
                iLastRoomClassId := RateSet['roomClassId'];
                tempSpaces := '';
                if (LowerCase(RateSet['rtgTopClass']) <> LowerCase(RateSet['rtgCode'])) then
                  tempSpaces := '   >> ';

                rateGrid.Cells[0, iRateRow] := format('%s[%s] %s', [tempSpaces, RateSet['rtgCode'], RateSet['rtgDescription']]);

                inc(iRow, 7 + ABS(ORD(isCurrentDirectConnection)));
                iCountLine := 1;
                rateGrid.RowCount := iRow + 3;

                if isCurrentDirectConnection then
                begin
                  rateGrid.Cells[0, iRateRow + iCountLine] := '<font></font><p align="right"><b>Single use price</p>';
                  rateGrid.Objects[0, iRateRow + iCountLine] := Pointer(8);
                  inc(iCountLine);
                end;

                if isCurrentDirectConnection OR (anyDirectConnection AND (chId = -2)) then
                begin
                  rateGrid.Cells[0, iRateRow + iCountLine] := '<font></font><p align="right"><b>Availability</p>';
                  rateGrid.Objects[0, iRateRow + iCountLine] := Pointer(11); // Disabled!! Pointer(1);
                end
                else
                begin
                  rateGrid.Cells[0, iRateRow + iCountLine] := '<font></font><p align="right"><b>Not used</p>';
                  rateGrid.Objects[0, iRateRow + iCountLine] := Pointer(11);
                end;
                inc(iCountLine);

                rateGrid.Cells[0, iRateRow + iCountLine] := '<font></font><p align="right"><b>Minimum stay</p>';
                rateGrid.Objects[0, iRateRow + iCountLine] := Pointer(3);
                inc(iCountLine);

                rateGrid.Cells[0, iRateRow + iCountLine] := '<font></font><p align="right"><b>Maximum stay</p>';
                rateGrid.Objects[0, iRateRow + iCountLine] := Pointer(4);
                inc(iCountLine);

                rateGrid.Cells[0, iRateRow + iCountLine] := '<font></font><p align="right"><b>Stop sell</p>';
                rateGrid.Objects[0, iRateRow + iCountLine] := Pointer(2);
                inc(iCountLine);

                rateGrid.Cells[0, iRateRow + iCountLine] := '<font></font><p align="right"><b>Closed On Arrival</p>';
                rateGrid.Objects[0, iRateRow + iCountLine] := Pointer(5);
                inc(iCountLine);

                rateGrid.Cells[0, iRateRow + iCountLine] := '<font></font><p align="right"><b>Closed On Departure</p>';
                rateGrid.Objects[0, iRateRow + iCountLine] := Pointer(6);
                inc(iCountLine);

                rateGrid.Cells[0, iRateRow + iCountLine] := '<font></font><p align="right"><b>LOS based on Arrival</p>';
                rateGrid.Objects[0, iRateRow + iCountLine] := Pointer(7);

              end;

              iRateCol := trunc(RateSet['date']) - trunc(startDate) + 1;
              price := RateSet['price'];

              rateGrid.Cells[iRateCol, iRateRow] := Trim(FloatToStrF(price, ffFixed {ffNumber}, 12, NumDecimals(AvailSet['rateRoundingType'])));
              PriceData := TPriceData.Create(
                RateSet['id'],
                RateSet['rtgCode'],
                RateSet['rtgTopClass'],
                RateSet['date'],
                AvailSet['rateRoundingType'],
                RateSet['channelId'],
                RateSet['roomClassId'],
                cmId,
                RateSet['price'],
                RateSet['stop'],
                RateSet['minstay'],
                RateSet['availability'],
                RateSet['maxStay'],
                RateSet['closedOnArrival'],
                RateSet['closedOnDeparture'],
                RateSet['lengthOfStayArrivalDateBased'],
                RateSet['singleUsePrice'],
                RateSet['connectRateToMasterRate'],
                RateSet['masterRateRateDeviation'],
                RateSet['RateDeviationType'],

                RateSet['connectSingleUseRateToMasterRate'],
                RateSet['masterRateSingleUseRateDeviation'],
                RateSet['singleUseRateDeviationType'],

                RateSet['connectStopSellToMasterRate'],
                RateSet['connectAvailabilityToMasterRate'],
                RateSet['connectMinStayToMasterRate'],
                RateSet['connectMaxStayToMasterRate'],
                RateSet['connectCOAToMasterRate'],
                RateSet['connectCODToMasterRate'],
                RateSet['connectLOSToMasterRate']
              );
              rateGrid.Objects[iRateCol, iRateRow] := PriceData;

              iCountLine := 1;

              if isCurrentDirectConnection then
              begin
                rateGrid.Cells[iRateCol, iRateRow + iCountLine] := Trim(FloatToStrF(RateSet['singleUsePrice'], ffFixed, 12, NumDecimals(AvailSet['rateRoundingType'])));
                inc(iCountLine);
              end;

              if isCurrentDirectConnection OR (anyDirectConnection AND (chId = -2)) then
              begin
                rateGrid.Cells[iRateCol, iRateRow + iCountLine] := inttostr(RateSet['availability']);
              end;
              inc(iCountLine);

              rateGrid.Cells[iRateCol, iRateRow + iCountLine] := inttostr(RateSet['minstay']);
              inc(iCountLine);
              rateGrid.Cells[iRateCol, iRateRow + iCountLine] := inttostr(RateSet['maxstay']);
              inc(iCountLine);
              rateGrid.AddCheckBox(iRateCol, iRateRow + iCountLine, RateSet.FieldByName('stop').AsBoolean, false);
              inc(iCountLine);
              rateGrid.AddCheckBox(iRateCol, iRateRow + iCountLine, RateSet.FieldByName('closedOnArrival').AsBoolean, false);
              inc(iCountLine);
              rateGrid.AddCheckBox(iRateCol, iRateRow + iCountLine, RateSet.FieldByName('closedOnDeparture').AsBoolean, false);
              inc(iCountLine);
              rateGrid.AddCheckBox(iRateCol, iRateRow + iCountLine, RateSet.FieldByName('lengthOfStayArrivalDateBased').AsBoolean, false);
              rateGrid.RowHeights[iRateRow + iCountLine] := 8;

            end;
            RateSet.next;
          end;

          inc(iRow, 1); // * cbxStopMinOptions.Tag);
          rateGrid.RowCount := iRow;

          AvailSet.next;

        end;

        if cbxChannel.Items.count > 0 then
          if NOT cbxChannel.Checked[0] then
            for i := 0 to cbxChannel.Items.count - 1 do
              cbxChannel.Checked[i] := true;

      finally
        cbxStopMinOptions.Checked := False;
        cbxExtraRestrictions.Checked := False;
        cbxStopMinOptions.Tag := 0;
        cbxExtraRestrictions.Tag := 0;
        rateGrid.EndUpdate;
        grid.EndUpdate;
  {$IFDEF DEBUG}
        EndTimer(DrawTime, lblDrawTime);
  {$ENDIF}

  {$IFDEF DEBUG}
        StartTimer(DrawTime);
  {$ENDIF}
        HideShowExtraCells;
  {$IFDEF DEBUG}
        EndTimer(DrawTime, lblDrawTime);
  {$ENDIF}

        rateGrid.OnCellValidate := rateGridCellValidate;
        rateGrid.OnCheckBoxChange := rateGridCheckBoxChange;
        rateGrid.OnDrawCell := rateGridDrawCell;
        rateGrid.OnGetAlignment := rateGridGetAlignment;
        rateGrid.OnGetCellBorder := rateGridGetCellBorder;
        rateGrid.OnGetCellColor := rateGridGetCellColor;

  {$IFDEF DEBUG}
        StartTimer(DrawTime);
  {$ENDIF}
  {$IFDEF DEBUG}
        EndTimer(DrawTime, lblDrawTime);
  {$ENDIF}

        cbxChannel.OnClickCheck := cbxChannelClickCheck;
        ccChannels.OnClickCheck := ccChannelsClickCheck;

        FreeAndNil(RateSet);

      end;
    finally
      FreeAndNil(AvailSet);
    end;
    finally
      cbxChannel.BulkChanging := False;
    end;

    ShowHideExtraOptions;
  finally
    pgcPages.Visible := True;
  end;
end;

function TfrmChannelAvailabilityManager.locateAvailabilityFromRoomTypeCodeAndDate(const Code: String; date: TDateTime): integer;
var
  Key: String;
begin
  result := 0;
  Key := Code + '_' + uDateUtils.dateToSqlString(date);
  if AvailDict.ContainsKey(Key) then
    result := AvailDict[Key].fvalue;
end;

procedure TfrmChannelAvailabilityManager.EmptyGrid(grid: TAdvStringGrid);
var
  i, i1: integer;
begin
  grid.BeginUpdate;
  try
    for i := 1 to grid.RowCount do
      for i1 := 0 to grid.ColCount do
        grid.Cells[i1, i] := '';
    grid.RowCount := 2;
    grid.ColCount := 2;
  finally
    grid.EndUpdate;
  end;
end;

procedure TfrmChannelAvailabilityManager.SetAvailabilityValue(iRow: integer; var value: string; _grid: TAdvStringGrid; iCol: integer);
begin
  if Assigned(grid.Objects[iCol, iRow]) AND (grid.Objects[iCol, iRow] IS TCellData) AND
    (trunc(TCellData(grid.Objects[iCol, iRow]).FDate) >= trunc(dtBulkFrom.date)) AND (trunc(TCellData(grid.Objects[iCol, iRow]).FDate) <= trunc(dtBulkTo.date))
    AND (IsIdCheckedInCheckListCombo(cbxRoomTypes, TCellData(grid.Objects[iCol, iRow]).FRoomClassId)) AND
    DayOfWeekIsIncludes(TCellData(grid.Objects[iCol, iRow]).FDate) then
  begin
    if EditableCell(_grid, iRow, iCol) then
    begin
      if cbxAvailType.ItemIndex in [0, 2] then
      begin
        _grid.Cells[iCol, iRow] := value;
        TCellData(grid.Objects[iCol, iRow]).CurrentValue := StrToIntDef(value, 0);
      end
      else
      begin
        if cbxAvailType.ItemIndex = 1 then // Max
          TCellData(grid.Objects[iCol, iRow]).MaxValue := StrToIntDef(value, 0)
        else if cbxAvailType.ItemIndex = 3 then // Current
        begin
          value := inttostr(locateAvailabilityFromRoomTypeCodeAndDate(TCellData(grid.Objects[iCol, iRow]).FRoomClassCode,
            TCellData(grid.Objects[iCol, iRow]).date));
          _grid.Cells[iCol, iRow] := value;
          TCellData(grid.Objects[iCol, iRow]).CurrentValue := StrToIntDef(value, 0);
        end;
      end;
    end;
  end;
end;

function TfrmChannelAvailabilityManager.findRowTypeIndex(startAt, pointerType: integer): integer;
var
  i: integer;
  ptr: Pointer;
begin
  result := -1;
  ptr := Pointer(pointertype);

  for i := startAt to startAt + NumLinesPerRateEntity do
    if rateGrid.Objects[0, i] = ptr then
    begin
      result := i;
      break;
    end;
end;

procedure TfrmChannelAvailabilityManager.SetRateCellValue(iCol, iRow: integer; PriceData: TPriceData; value: Double);
begin
  PriceData.price := value;
  rateGrid.OnCellValidate := nil;
  try
    rateGrid.Cells[iCol, iRow] := Trim(FloatToStrF(PriceData.price, ffFixed, 12, NumDecimals(PriceData.rateRoundingType)));
  finally
    rateGrid.OnCellValidate := rateGridCellValidate;
  end;
end;

procedure TfrmChannelAvailabilityManager.SetSingleUsePriceCellValue(iCol, iRow: integer; PriceData: TPriceData; value: Double);
begin
  PriceData.SingleUsePrice := value;
  rateGrid.OnCellValidate := nil;
  try
    rateGrid.Cells[iCol, iRow] := Trim(FloatToStrF(PriceData.SingleUsePrice, ffFixed, 12, NumDecimals(PriceData.rateRoundingType)));
  finally
    rateGrid.OnCellValidate := rateGridCellValidate;
  end;
end;

procedure TfrmChannelAvailabilityManager.SetAvailabilityCellValue(iCol, iRow: integer; PriceData: TPriceData; value: integer);
begin
  PriceData.Availability := value;
  rateGrid.Cells[iCol, iRow] := inttostr(PriceData.Availability);
end;

procedure TfrmChannelAvailabilityManager.SetMinStayCellValue(iCol, iRow: integer; PriceData: TPriceData; value: integer);
begin
  PriceData.minStay := value;
  rateGrid.Cells[iCol, iRow] := inttostr(PriceData.minStay);
end;

procedure TfrmChannelAvailabilityManager.SetMaxStayCellValue(iCol, iRow: integer; PriceData: TPriceData; value: integer);
begin
  PriceData.MaxStay := value;
  rateGrid.Cells[iCol, iRow] := inttostr(PriceData.MaxStay);
end;

procedure TfrmChannelAvailabilityManager.SetCheckBoxStateForCheckBoxCells(iCol, iRow: integer; value: Boolean);
var PriceData : TPriceData;
begin
  if isAnyCheckBoxRow(iRow) then
  begin
    PriceData := getPriceDataOfRow(iCol, iRow);
    if assigned(PriceData) then
    begin
      if isStopSellRow(iRow) then
        PriceData.stopSell := Value
      else if isCloseOnArrivalRow(iRow) then
        PriceData.COA := Value
      else if isClosedOnDepartureRow(iRow) then
        PriceData.COD := Value
      else if isLOSArrivalDateBasedRow(iRow) then
        PriceData.LOSArrivalDateBased := Value;

      rateGrid.SetCheckBoxState(iCol, iRow, value);
    end;
  end;
end;

procedure TfrmChannelAvailabilityManager.SetCheckBoxCellValue(iCol, iRow: integer; value: Boolean);
var
  currentCheckState: Boolean;
begin
  rateGrid.GetCheckBoxState(iCol, iRow, currentCheckState);
  if currentCheckState <> value then
    rateGrid.SetCheckBoxState(iCol, iRow, value);
end;

procedure TfrmChannelAvailabilityManager.SetRateValue(iCol, iRow: integer; value: string; _grid: TAdvStringGrid; InPlaceEditing: Boolean = false; IsSinglePrice: Boolean = false);
var
  PriceData: TPriceData;
  iIntValue, iTypeIndex: integer;
begin
  if isPriceCell(iCol, iRow) then
  begin
    PriceData := getPriceDataOfRow(iCol, iRow);
    if NOT Assigned(PriceData) then
      exit;

    if value = '' then
      value := rateGrid.Cells[iCol, iRow];

    if (IsIdCheckedInCheckListCombo(cbxChannel, PriceData.channelId)) then
    begin
      if InPlaceEditing OR ((trunc(PriceData.date) >= trunc(dtBulkFrom.date)) and (trunc(PriceData.FDate) <= trunc(dtBulkTo.date)) AND
        (IsIdCheckedInCheckListCombo(cbxRoomTypes, PriceData.roomTypeGroupId)) AND
        DayOfWeekIsIncludes(PriceData.date)) then
      begin
        if InPlaceEditing OR __cbxRate.Checked then
        begin
          if NOT IsSinglePrice then
             SetRateCellValue(iCol, iRow, PriceData, getRateValueForCell(value, iCol, iRow, false))
          else
             SetSingleUsePriceCellValue(iCol, iRow, PriceData, getRateValueForCell(value, iCol, iRow, true));
          CorrectMasterRateLinkedCells(PriceData, iCol, iRow);
        end;

        if (NOT InPlaceEditing) then
        begin

          if __cbxSingleUsePriceActive.Checked then
          begin
            iTypeIndex := findRowTypeIndex(iRow, 8);
            if iTypeIndex > -1 then
            begin
              SetSingleUsePriceCellValue(iCol, iTypeIndex, PriceData, getRateValueForCell(edtSingleUsePrice.Text, iCol, iTypeIndex, true));
              CorrectMasterRateLinkedCells(PriceData, iCol, iTypeIndex);
            end;
          end;

          if __cbxAvailability.Checked then
          begin
            // 0  Type availability
            // 1  Set Max Availability
            // 2  Set Auto Availability
            // 3  Set Current Availability
            iTypeIndex := findRowTypeIndex(iRow, 1);
            iIntValue := -MaxInt;
            if iTypeIndex > -1 then
            begin
              if (cbDCAvailabilityType.ItemIndex <= 0) then // Typed in
                iIntValue := StrToIntDef(edtDCAvailbility.Text, -9999999)
              else if cbDCAvailabilityType.ItemIndex in [1] then // Auto
                iIntValue := -1
              else if cbDCAvailabilityType.ItemIndex in [2] then // Current
                iIntValue := locateAvailabilityFromRoomTypeCodeAndDate(PriceData.FRoomTypeTopClass, PriceData.date);

              if (iIntValue = -MaxInt) then
                raise Exception.Create('Incorrect availability value');

              SetAvailabilityCellValue(iCol, iTypeIndex, PriceData, iIntValue);
              CorrectMasterRateLinkedCells(PriceData, iCol, iTypeIndex);
            end;
          end;

          if btnStopSell_On.Down OR btnStopSell_Off.Down then
          begin
            iTypeIndex := findRowTypeIndex(iRow, 2);
            if iTypeIndex > -1 then
            begin
              PriceData.stopSell := btnStopSell_On.Down;
              SetCheckBoxCellValue(iCol, iTypeIndex, PriceData.stopSell);
              CorrectMasterRateLinkedCells(PriceData, iCol, iTypeIndex);
            end;
          end;
          if __cbxMinimumStayActive.Checked then
          begin
            if edtMinStay.Text <> '' then
            begin
              iTypeIndex := findRowTypeIndex(iRow, 3);
              if iTypeIndex > -1 then
              begin
                PriceData.minStay := StrToIntDef(edtMinStay.Text, 0);
                if (StrToIntDef(rateGrid.Cells[iCol, iTypeIndex], -999999) <> PriceData.minStay) then
                  rateGrid.Cells[iCol, iTypeIndex] := inttostr(PriceData.minStay);
                CorrectMasterRateLinkedCells(PriceData, iCol, iTypeIndex);
              end;
            end;
            if edtMaximumStay.Text <> '' then
            begin
              iTypeIndex := findRowTypeIndex(iRow, 4);
              if iTypeIndex > -1 then
              begin
                PriceData.MaxStay := StrToIntDef(edtMaximumStay.Text, 0);
                if (StrToIntDef(rateGrid.Cells[iCol, iTypeIndex], -999999) <> PriceData.MaxStay) then
                  rateGrid.Cells[iCol, iTypeIndex] := inttostr(PriceData.MaxStay);
                CorrectMasterRateLinkedCells(PriceData, iCol, iTypeIndex);
              end;
            end;
          end;
          if btnCloseOnArrival_Off.Down OR btnCloseOnArrival_On.Down then
          begin
            iTypeIndex := findRowTypeIndex(iRow, 5);
            if iTypeIndex > -1 then
            begin
              PriceData.COA := btnCloseOnArrival_On.Down;
              SetCheckBoxCellValue(iCol, iTypeIndex, PriceData.COA);
              CorrectMasterRateLinkedCells(PriceData, iCol, iTypeIndex);
            end;
          end;
          if btnCloseOnDeparture_Off.Down OR btnCloseOnDeparture_On.Down then
          begin
            iTypeIndex := findRowTypeIndex(iRow, 6);
            if iTypeIndex > -1 then
            begin
              PriceData.COD := btnCloseOnDeparture_On.Down;
              SetCheckBoxCellValue(iCol, iTypeIndex, PriceData.COD);
              CorrectMasterRateLinkedCells(PriceData, iCol, iTypeIndex);
            end;
          end;
          if __cbxMinimumStayActive.Checked then
          begin
            if cbxBasedOnArrival.Checked AND NOT cbxStayThrough.Checked then
            begin
              iTypeIndex := findRowTypeIndex(iRow, 7);
              if iTypeIndex > -1 then
              begin
                PriceData.LOSArrivalDateBased := cbxBasedOnArrival.Checked;
                SetCheckBoxCellValue(iCol, iTypeIndex, PriceData.LOSArrivalDateBased);
                CorrectMasterRateLinkedCells(PriceData, iCol, iTypeIndex);
              end;
            end;
          end;
        end;

        // end;
      end;
    end;
  end;
end;

function TfrmChannelAvailabilityManager.getRateValueForCell(value: String; ACol, ARow: integer; ForSingleUsePrice : Boolean): Double;
var
  sign: Char;
  originalValue, percentage: Boolean;
  dCellValue, dValue: Double;
  PriceData : TPriceData;

begin
  Result := 0;
  originalValue := value[1] = '!';
  if originalValue then
  begin
    value := copy(value, 2, length(value));
  end;

  sign := value[1];
  if CharInSet(sign, ['-', '+', '*', '/']) then
  begin
    PriceData := getPriceDataOfRow(ACol, ARow);
    if assigned(PriceData) then
    begin
      value := copy(value, 2, length(value));
      percentage := value[length(value)] = '%';
      if percentage then
        value := copy(value, 1, length(value) - 1);
      dValue := _StrToFloat(value);
      if originalValue then
        dCellValue := getPriceForOnCell(ACol, ARow)
      else
      begin
        if ForSingleUsePrice then
          dCellValue := PriceData.SingleUsePrice
        else
          dCellValue := PriceData.Price;
      end;

      if percentage then
        dValue := dCellValue * dValue / 100;
      case sign of
        '+':
          dCellValue := dCellValue + dValue;
        '-':
          dCellValue := dCellValue - dValue;
        '*':
          dCellValue := dCellValue * dValue;
        '/':
          dCellValue := dCellValue / dValue;
      end;
      result := RoundValue(PriceData.rateRoundingType, dCellValue);
    end;
  end
  else
    result := _StrToFloat(value);
end;

function TfrmChannelAvailabilityManager.RoundValue(RoundType: integer; value: Double): Double;
begin
  case RoundType Of
    0:
      result := value;
    1:
      result := Round(value);
    2:
      result := trunc(value + 0.9);
    3:
      result := trunc(value);
    4..6:
      result := _RoundN(value, RoundType - 3);
  else
    Result := 0;
  end;
end;

function TfrmChannelAvailabilityManager.NumDecimals(RoundType: integer): integer;
begin
  case RoundType Of
    0:
      result := 3;
    4..6:
      Result := RoundType -3
  else
    Result := 0;
  end;
end;

procedure TfrmChannelAvailabilityManager.EmptyBulkOperation;
begin
  edtAvail.Text := '';
end;

procedure TfrmChannelAvailabilityManager.InitializeBulkOperation;
begin
  dtBulkFrom.date := startDate;
  dtBulkTo.date := startDate;
  edtAvail.Text := '';
  cbMon.Checked := true;
  cbTue.Checked := true;
  cbWen.Checked := true;
  cbThu.Checked := true;
  cbFri.Checked := true;
  cbSat.Checked := true;
  cbSun.Checked := true;
  edtMinStay.Text := '';
  edtMaximumStay.Text := '';
  cbxStayThrough.Checked := False;
  cbxBasedOnArrival.Checked := False;

  btnStopSell_ClearClick(btnStopSell_Clear);
end;

procedure TfrmChannelAvailabilityManager.pgcPagesChange(Sender: TObject);
begin
  try
    pnlBulkChanges.Visible := pgcPages.ActivePageIndex IN [0, 1];
    lblChannel.Visible := pgcPages.ActivePageIndex IN [1];
    cbxChannel.Visible := pgcPages.ActivePageIndex IN [1];
    btnClearChannelSelection.Visible := pgcPages.ActivePageIndex IN [1];
    btnCheckAllBulkChannel.Visible := pgcPages.ActivePageIndex IN [1];
    pnlRestrictions.Visible := pgcPages.ActivePageIndex IN [1];
    cbxAvailType.Items.Clear;

    case pgcPages.ActivePageIndex of
      0:
        begin
          lblEditing.Caption := GetTranslatedText('shTx_ChannelAvailabilityManager_Availability2');
          lblAmountType.Caption := GetTranslatedText('shTx_ChannelAvailabilityManager_Availability');
          lblBulkUpdate.Caption := GetTranslatedText('shTx_ChannelAvailabilityManager_BulkAvailabilityUpdate');
          cbxAvailType.Items.Add('Type Availability');
          cbxAvailType.Items.Add('Set Max Availability');
          cbxAvailType.Items.Add('Set Auto Availability');
          cbxAvailType.Items.Add('Set Current Availability');
          cbxAvailType.ItemIndex := 0;
          cbxAvailTypeChange(cbxAvailType);
        end;
      1:
        begin
          lblEditing.Caption := GetTranslatedText('shTx_ChannelAvailabilityManager_Rates');
          lblAmountType.Caption := GetTranslatedText('shTx_ChannelAvailabilityManager_Rate');
          lblBulkUpdate.Caption := GetTranslatedText('shTx_ChannelAvailabilityManager_BulkRateUpdate');
          cbxAvailType.Items.Add('Type Rate');
          cbxAvailType.Items.Add('Calc Automatically');
          cbxAvailType.ItemIndex := 0;
          cbxAvailTypeChange(cbxAvailType);
        end;
      2:
        lblEditing.Caption := GetTranslatedText('shTx_ChannelAvailabilityManager_OnlineManagement');
    end;

    dateEdit.enabled := pgcPages.ActivePageIndex <> 2;
    RefreshScreen;
  except
  end;
end;

procedure TfrmChannelAvailabilityManager.pnlBulkChangesResize(Sender: TObject);
begin
  pnlHideEdits.Visible := pnlBulkChanges.Width <> sPanel4.Width;
end;

procedure TfrmChannelAvailabilityManager.ShowHideExtraOptions;
begin
  __cbxSingleUsePriceActive.Visible := anyDirectConnection;
  edtSingleUsePrice.Visible := anyDirectConnection;
  lblSingleUsePrice.Visible := anyDirectConnection;

  cbxExtraRestrictions.Visible := true; // anyDirectConnection; Made active on 2016-01-14
end;


procedure TfrmChannelAvailabilityManager.sPanel4Click(Sender: TObject);
begin
  Image1.Picture := nil;
  __cbxRateClick(__cbxRate);
  __cbxSingleUsePriceActiveClick(__cbxSingleUsePriceActive);
  __cbxAvailabilityClick(__cbxAvailability);
  if pnlBulkChanges.Width = sPanel4.Width then
  begin

    __cbxSingleUsePriceActive.Visible := anyDirectConnection;
    edtSingleUsePrice.Visible := anyDirectConnection;
    lblSingleUsePrice.Visible := anyDirectConnection;

    cbxExtraRestrictions.Visible := true; // anyDirectConnection;  Made active on 2016-01-14
    pnlRestrictions.Height := 169;

    cbxBasedOnArrival.enabled := __cbxMinimumStayActive.Checked;
    cbxStayThrough.enabled := __cbxMinimumStayActive.Checked;

    lblBulkUpdate.Visible := true;
    edtMinStay.Visible := pgcPages.ActivePageIndex = 1;
    lblMinStay.Visible := edtMinStay.Visible;

    if pgcPages.ActivePageIndex = 1 then
    begin
      edtAvail.Hint := '<font name="Courier New" ' + GetHTMLColor(clRed, false) + ' ' + GetHTMLColor(clWhite, true) +
        '><b>Please type here the rate value or one of these formulas:</b></font>' + #13#10#13#10 + '<font name="Courier New" ' + GetHTMLColor(clRed, true) +
        ' ' + GetHTMLColor(clWhite, false) + '><b>+XX</b></font>  (where XX is an amount to add to the CURRENT rates. Ex: +20.5)' + #13#10 +
        '<font name="Courier New" ' + GetHTMLColor(clRed, true) + ' ' + GetHTMLColor(clWhite, false) +
        '><b>-XX</b></font>  (where XX is an amount to subtract from the CURRENT rates. Ex: -20.5)' + #13#10 + '<font name="Courier New" ' +
        GetHTMLColor(clRed, true) + ' ' + GetHTMLColor(clWhite, false) +
        '><b>+XX%</b></font>  (where XX is a percentage of the CURRENT rates to be added. Ex: +10%)' + #13#10 + '<font name="Courier New" ' +
        GetHTMLColor(clRed, true) + ' ' + GetHTMLColor(clWhite, false) +
        '><b>-XX%</b></font>  (where XX is a percentage of the CURRENT rates to be subtracted. Ex: -10%)' + #13#10 + '<font name="Courier New" ' +
        GetHTMLColor(clRed, true) + ' ' + GetHTMLColor(clWhite, false) +
        '><b>*XX</b></font>  (where XX is a number to be use to multiply CURRENT rate with. Ex: *1.25)' + #13#10 + '<font name="Courier New" ' +
        GetHTMLColor(clRed, true) + ' ' + GetHTMLColor(clWhite, false) +
        '><b>/XX</b></font>  (where XX is a number to be use to devide CURRENT rate by. Ex: /0.75)' + #13#10#13#10 +

        '<font name="Courier New" ' + GetHTMLColor(clRed, true) + ' ' + GetHTMLColor(clWhite, false) +
        '><b>!+XX</b></font>  (where XX is an amount to add to the ORIGINAL rates. Ex: +20.5)' + #13#10 + '<font name="Courier New" ' +
        GetHTMLColor(clRed, true) + ' ' + GetHTMLColor(clWhite, false) +
        '><b>!-XX</b></font>  (where XX is an amount to subtract from the ORIGINAL rates. Ex: -20.5)' + #13#10 + '<font name="Courier New" ' +
        GetHTMLColor(clRed, true) + ' ' + GetHTMLColor(clWhite, false) +
        '><b>!+XX%</b></font>  (where XX is a percentage of the ORIGINAL rates to be added. Ex: +10%)' + #13#10 + '<font name="Courier New" ' +
        GetHTMLColor(clRed, true) + ' ' + GetHTMLColor(clWhite, false) +
        '><b>!-XX%</b></font>  (where XX is a percentage of the ORIGINAL rates to be subtracted. Ex: -10%)' + #13#10 + '<font name="Courier New" ' +
        GetHTMLColor(clRed, true) + ' ' + GetHTMLColor(clWhite, false) +
        '><b>!*XX</b></font>  (where XX is a number to be use to multiply ORIGINAL rate with. Ex: *1.25)' + #13#10 + '<font name="Courier New" ' +
        GetHTMLColor(clRed, true) + ' ' + GetHTMLColor(clWhite, false) +
        '><b>!/XX</b></font>  (where XX is a number to be use to devide ORIGINAL rate by. Ex: /0.75)' + #13#10;

      edtAvail.TextHint := 'Rate or formula';

      edtSingleUsePrice.TextHint := edtAvail.TextHint;
      edtSingleUsePrice.Hint := edtAvail.Hint;
    end
    else
    begin
      edtAvail.TextHint := 'Room availability';
      edtAvail.Hint := '';
      edtSingleUsePrice.TextHint := '';
      edtSingleUsePrice.Hint := '';
    end;


    edtAvail.ShowHint := true;
    edtSingleUsePrice.ShowHint := edtAvail.ShowHint;
    EmptyBulkOperation;
    pnlBulkChanges.Width := 475;
    ImageList1.GetIcon(0, Image1.Picture.Icon);
  end
  else
  begin
    lblBulkUpdate.Visible := false;
    pnlBulkChanges.Width := sPanel4.Width;
    ImageList1.GetIcon(1, Image1.Picture.Icon);
  end;
  pnlBulkChanges.Invalidate;
  pnlBulkChanges.Update;

  __cbxRateClick(__cbxRate);
  __cbxSingleUsePriceActiveClick(__cbxSingleUsePriceActive);
  __cbxAvailabilityClick(__cbxAvailability);
end;

{ TCellData }

constructor TCellData.Create(Id: integer; date: TDateTime; IsEditable: Boolean; const LinkElement: String; PlanCodeId, RoomClassId, ChannelManagerId: integer;
  const RoomClassCode: String; originalValue: Variant; maxAvailability: Variant);
begin
  inherited Create;
  FId := Id;
  FDate := date;
  FPlanCodeId := PlanCodeId;
  FRoomClassId := RoomClassId;
  FChannelManagerId := ChannelManagerId;
  FOriginalValue := originalValue;
  FCurrentValue := originalValue;
  FIsEditable := IsEditable;
  FRoomClassCode := RoomClassCode;
  FLinkElement := LinkElement;
  FMaxValue := maxAvailability;
  FOriginalMaxValue := maxAvailability;

  FForceRefresh := false;
end;

destructor TCellData.Destroy;
begin
  inherited;
end;

function TCellData.GetChanged: Boolean;
begin
  result := (FOriginalValue <> FCurrentValue) OR (FOriginalMaxValue <> FMaxValue) OR FForceRefresh;
end;

function TCellData.GetEdited: Boolean;
begin
  result := (FOriginalValue <> FCurrentValue);
end;

procedure TfrmChannelAvailabilityManager.btnCheckAllBulkChannelClick(Sender: TObject);
begin
  CheckOrUnCheckAllInCheckList(cbxChannel, true, true);
  cbxChannelClickCheck(cbxChannel);
end;

procedure TfrmChannelAvailabilityManager.btnCheckAllBulkRoomClassesClick(Sender: TObject);
begin
  CheckOrUnCheckAllInCheckList(cbxRoomTypes, true);
end;

procedure TfrmChannelAvailabilityManager.btnCheckAllChannelClick(Sender: TObject);
begin
  CheckOrUnCheckAllInCheckList(ccChannels, true);
  ccChannelsClickCheck(ccChannels);
end;

procedure TfrmChannelAvailabilityManager.sButton1Click(Sender: TObject);
begin
  // if MessageDLG('All changes will be lost. Continue?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  if (NOT AnyRateOrRestrictionsChanges) OR (MessageDLG(GetTranslatedText('shTx_ChannelAvailabilityManager_ChangesContinue'), mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    ReloadSelectedPeriod;
end;

procedure TfrmChannelAvailabilityManager.sButton2Click(Sender: TObject);
begin
  sPanel4Click(nil);
end;

procedure TfrmChannelAvailabilityManager.sButton3Click(Sender: TObject);
var
  cmId: integer;
begin
  if MessageDLG(GetTranslatedText('shTx_ChannelAvailabilityManager_ConfirmRemoveRates'), mtWarning, [mbYes, mbNo], 0) = mrYes then
  begin
    cmId := TChannelManagerValue(cbxChannelManagers.Items.Objects[cbxChannelManagers.ItemIndex]).FId;
    RoomerDataSet.DoCommand(format('DELETE FROM channelrates WHERE channelManager=%d', [cmId]));
    ReloadSelectedPeriod;
  end;
end;

procedure TfrmChannelAvailabilityManager.ForceFullAvailability;
begin
  if PerformForcedAvailabilityUpdate then
  begin
    CleanUpRedundantRoomClassesInAvailbilities;
    d.roomerMainDataSet.DoCommand('UPDATE channelrates cr SET cr.availabilityDirty=1 WHERE cr.date>=CURRENT_DATE');
    d.roomerMainDataSet.DoCommand('UPDATE channelratesavailabilities cra SET cra.dirty=1 WHERE cra.date>=CURRENT_DATE');
  end;
end;

procedure TfrmChannelAvailabilityManager.ForceFullRates;
begin
  if PerformForcedRatesUpdate then
    d.roomerMainDataSet.DoCommand('UPDATE channelrates cr SET dirty=1, minStayDirty=((minStay<=maxStay) OR (maxStay=0)), maxStayDirty=(maxStay>=minStay), closedOnArrivalDirty=1, ' +
                                  'closedOnDepartureDirty=1, stopDirty=1, lengthOfStayArrivalDateBasedDirty=1, singleUsePriceDirty=1 ' +
                                  'WHERE cr.date>=CURRENT_DATE');
end;

function TfrmChannelAvailabilityManager.PerformForcedAvailabilityUpdate : Boolean;
begin
  result := MessageDLG(GetTranslatedText('shTx_ChannelAvailabilityManager_ForceUpdateAvailability1') + #10 +
                       GetTranslatedText('shTx_ChannelAvailabilityManager_ForceUpdate2') + #10 +
                       GetTranslatedText('shTx_ChannelAvailabilityManager_ForceUpdate3'), mtWarning, [mbYes, mbNo], 0) = mrYes;
end;

procedure TfrmChannelAvailabilityManager.ForceAvailabilityForCurrentPeriod;
var
  iRow, iCol: integer;
begin
  if PerformForcedAvailabilityUpdate then
  begin
    BeginProject(RealNumberOfAvailabilityObjects);
    try
      for iRow := 1 to grid.RowCount - 1 do
        for iCol := 1 to grid.ColCount - 1 do
        begin
          if Assigned(grid.Objects[iCol, iRow]) AND (grid.Objects[iCol, iRow] IS TCellData) then
          begin
            TCellData(grid.Objects[iCol, iRow]).ForceRefresh := true;
          end;
          ForwardProject;
        end;

    finally
      EndProject;
    end;
    btnSave.Click;
  end;
end;

procedure TfrmChannelAvailabilityManager.sButton4Click(Sender: TObject);
begin
  ForceAvailabilityForCurrentPeriod;
end;

function TfrmChannelAvailabilityManager.PerformForcedRatesUpdate : Boolean;
begin
  result := MessageDLG(GetTranslatedText('shTx_ChannelAvailabilityManager_ForceUpdateRates1') + #10 +
                       GetTranslatedText('shTx_ChannelAvailabilityManager_ForceUpdate2') + #10 +
                       GetTranslatedText('shTx_ChannelAvailabilityManager_ForceUpdate3'), mtWarning, [mbYes, mbNo], 0) = mrYes;
end;

procedure TfrmChannelAvailabilityManager.ForceRateUpdateForCurrentPeriod;
var
  iRow, iCol: integer;
  PriceData: TPriceData;
begin
  if PerformForcedRatesUpdate then
  begin
    BeginProject(RealNumberOfRateObjects);
    for iRow := 1 to rateGrid.RowCount - 1 do
    begin
      for iCol := 1 to rateGrid.ColCount - 1 do
      begin
        if isPriceCell(iCol, iRow) then
        begin
          PriceData := getPriceDataOfRow(iCol, iRow);
          if Assigned(PriceData) then
            PriceData.ForcingUpdate := true;
          ForwardProject;
        end;
      end;
    end;

    EndProject;
    btnPublish.Click;
  end;
end;

procedure TfrmChannelAvailabilityManager.sButton5Click(Sender: TObject);
begin
  ForceRateUpdateForCurrentPeriod;
end;

procedure TfrmChannelAvailabilityManager.CheckOrUnCheckAllInCheckList(cl : TCheckComboBox; checked : Boolean; skipMinValues : Boolean = False);
var i: Integer;
begin
  for i := 0 to cl.Items.Count - 1 do
    if NOT (skipMinValues AND (cl.Items.Objects[i] = Pointer(-1))) then
      cl.Checked[i] := checked;
end;

procedure TfrmChannelAvailabilityManager.btnClearRoomClassesClick(Sender: TObject);
begin
  CheckOrUnCheckAllInCheckList(cbxRoomTypes, false);
end;

procedure TfrmChannelAvailabilityManager.btnClearChannelSelectionClick(Sender: TObject);
begin
  CheckOrUnCheckAllInCheckList(cbxChannel, false, true);
  cbxChannelClickCheck(cbxChannel);
end;

procedure TfrmChannelAvailabilityManager.btnClearChannelSelectionGridClick(Sender: TObject);
begin
  CheckOrUnCheckAllInCheckList(ccChannels, false);
  ccChannelsClickCheck(ccChannels);
end;

procedure TfrmChannelAvailabilityManager.__cbxMinimumStayActiveClick(Sender: TObject);
begin
  lblMinStay.enabled := __cbxMinimumStayActive.Checked;
  edtMinStay.enabled := __cbxMinimumStayActive.Checked;
  lblMaximumStay.enabled := __cbxMinimumStayActive.Checked;
  edtMaximumStay.enabled := __cbxMinimumStayActive.Checked;
  cbxStayThrough.enabled := __cbxMinimumStayActive.Checked;
  cbxBasedOnArrival.enabled := __cbxMinimumStayActive.Checked;
  lblStayThrough.enabled := __cbxMinimumStayActive.Checked;
  lblBasedOnArrival.enabled := __cbxMinimumStayActive.Checked;
end;

procedure TfrmChannelAvailabilityManager.__cbxVisibleDaysCloseUp(Sender: TObject);
begin
  if StrToInt(__cbxVisibleDays.Items[__cbxVisibleDays.ItemIndex])=400 then
  begin
    startDate := TRUNC(now);
    dateEdit.Date := startDate;
  end;
  RefreshGridsData;
end;

procedure TfrmChannelAvailabilityManager.ccChannelsClickCheck(Sender: TObject);
begin
  HideShowExtraCells;
end;

procedure TfrmChannelAvailabilityManager.__cbxSingleUsePriceActiveClick(Sender: TObject);
begin
  edtSingleUsePrice.enabled := __cbxSingleUsePriceActive.Checked;
  lblSingleUsePrice.enabled := __cbxSingleUsePriceActive.Checked;
end;

procedure TfrmChannelAvailabilityManager.cbDCAvailabilityTypeChange(Sender: TObject);
begin
  edtDCAvailbility.enabled := __cbxAvailability.Checked AND (cbDCAvailabilityType.ItemIndex = 0);
end;

procedure TfrmChannelAvailabilityManager.__cbxAvailabilityClick(Sender: TObject);
begin
  if cbDCAvailabilityType.ItemIndex < 0 then
    cbDCAvailabilityType.ItemIndex := 0;
  cbDCAvailabilityType.enabled := __cbxAvailability.Checked;
  edtDCAvailbility.enabled := __cbxAvailability.Checked AND (cbDCAvailabilityType.ItemIndex = 0);
  lblDCAvailability.enabled := __cbxAvailability.Checked;
end;

procedure TfrmChannelAvailabilityManager.cbxAvailTypeChange(Sender: TObject);
begin
  dtBulkToChange(nil);
  edtAvail.enabled := cbxAvailType.ItemIndex < 2 - pgcPages.ActivePageIndex;
end;

procedure TfrmChannelAvailabilityManager.cbxShowLinkedCellsClick(Sender: TObject);
begin
  HideShowLinkedClasses;
end;

procedure TfrmChannelAvailabilityManager.HideShowLinkedClasses;
var
  iRow: integer;
begin
  for iRow := 1 to grid.RowCount - 1 do
    if (grid.ColCount > 1) then
      if Trim(TCellData(grid.Objects[2, iRow]).LinkElement) <> '' then
        grid.RowHeights[iRow] := grid.DefaultRowHeight * ABS(ORD(cbxShowLinkedCells.Checked));
end;

procedure TfrmChannelAvailabilityManager.HideShowExtraCells;
var
  iRow, iHeight: integer;
  PriceData : TPriceData;
CONST CHECK_BOX_CELL_HEIGHT = 22;
begin
  rateGrid.BeginUpdate;
  try
  for iRow := 1 to rateGrid.RowCount - 1 do
  begin
    PriceData := getPriceDataOfRow(1, iRow);
    if Assigned(PriceData) then
    begin
        iHeight := ABS(ORD((PriceData.channelId = -1) OR IsIdCheckedInCheckListCombo(ccChannels, PriceData.channelId)));

        // If sub-rate then hide it
        if (NOT cbxShowSubrates.Checked) then
          iHeight := ABS(ORD((iHeight > 0) AND (PriceData.FRoomTypeGroupCode = PriceData.RoomTypeTopClass)));

        // Hidden, unused Row?
        if isHiddenUnusedRow(iRow) then
          rateGrid.RowHeights[iRow] := 0

        else if isPriceRow(iRow) then
          rateGrid.RowHeights[iRow] := rateGrid.DefaultRowHeight * iHeight

        else if isAvailabilityRow(iRow) then
          rateGrid.RowHeights[iRow] := rateGrid.DefaultRowHeight * iHeight

        else if isStopSellRow(iRow) then
          rateGrid.RowHeights[iRow] := CHECK_BOX_CELL_HEIGHT * ABS(ORD(cbxStopMinOptions.Checked)) * iHeight

        else if isMinStayRow(iRow) then
          rateGrid.RowHeights[iRow] := rateGrid.DefaultRowHeight * ABS(ORD(cbxStopMinOptions.Checked)) * iHeight

        else if isMaxStayRow(iRow) then
          rateGrid.RowHeights[iRow] := rateGrid.DefaultRowHeight * ABS(ORD(cbxExtraRestrictions.Checked)) * iHeight

        else if isCloseOnArrivalRow(iRow) then
          rateGrid.RowHeights[iRow] := CHECK_BOX_CELL_HEIGHT * ABS(ORD(cbxExtraRestrictions.Checked)) * iHeight

        else if isClosedOnDepartureRow(iRow) then
          rateGrid.RowHeights[iRow] := CHECK_BOX_CELL_HEIGHT * ABS(ORD(cbxExtraRestrictions.Checked)) * iHeight

        else if isLOSArrivalDateBasedRow(iRow) then
          rateGrid.RowHeights[iRow] := CHECK_BOX_CELL_HEIGHT * ABS(ORD(cbxExtraRestrictions.Checked)) * iHeight

        else if isSingleUsePriceRow(iRow) then
          rateGrid.RowHeights[iRow] := rateGrid.DefaultRowHeight * ABS(ORD(cbxExtraRestrictions.Checked)) * iHeight;

    end;
  end;
  finally
    rateGrid.EndUpdate;
  end;
end;

procedure TfrmChannelAvailabilityManager.__cbxRateClick(Sender: TObject);
begin
  edtAvail.enabled := __cbxRate.Checked;
  lblAmountType.enabled := __cbxRate.Checked;
  cbxAvailType.enabled := __cbxRate.Checked;
end;


// ******************************************* Web Browser Functions ***************************************

procedure TfrmChannelAvailabilityManager.P1Click(Sender: TObject);
begin
  CurrentActiveGrid.PasteSelectionFromClipboard;
end;

procedure TfrmChannelAvailabilityManager.R1Click(Sender: TObject);
begin
  DeleteContentOfCurrentCell;
end;

procedure TfrmChannelAvailabilityManager.rateGridCanEditCell(Sender: TObject; ARow, ACol: integer; var CanEdit: Boolean);
var
  PriceData: TPriceData;
begin
  if Halting then
    exit;

  CanEdit := isAnyEditableRow(ARow);
  if CanEdit then
    if isAvailabilityRow(ARow) then
    begin
      PriceData := nil;
      if (ACol > 0) AND (ARow > 0) then
        PriceData := getPriceDataOfRow(ACol, ARow);
      if Assigned(PriceData) then
      begin
        CanEdit := PriceData.FRoomTypeGroupCode = PriceData.FRoomTypeTopClass;
      end;
    end;
end;

procedure TfrmChannelAvailabilityManager.rateGridCellChanging(Sender: TObject; OldRow, OldCol, NewRow, NewCol: integer; var Allow: Boolean);
begin
  Allow := isAnyEditableRow(NewRow);
end;


procedure TfrmChannelAvailabilityManager.CorrectMasterRateLinkedCells(PriceData : TPriceData; ACol, ARow: integer);
var
  i: Integer;
  DestPriceData : TPriceData;
  cbValue : Boolean;
  tmpValue : Double;
begin
  if PriceData.channelId = -1 then
  begin
    for i := ARow + 7 to rateGrid.RowCount - 1 do
    begin
      DestPriceData := getPriceDataOfRow(ACol, i);
      if assigned(DestPriceData) AND (DestPriceData.channelId >= 0) then
      begin
        if (DestPriceData.RoomTypeTopClass = PriceData.RoomTypeTopClass) AND SameTypeRows(ARow, i) then
        begin
          if (DestPriceData.connectRateToMasterRate AND isPriceRow(ARow)) then
          begin
             if DestPriceData.RateDeviationType = 'FIXED_AMOUNT' then
               tmpValue := PriceData.price + DestPriceData.masterRateRateDeviation
             else
               tmpValue := PriceData.price * (1 + DestPriceData.masterRateRateDeviation / 100);
             if tmpValue > 0.00 then
               DestPriceData.price := tmpValue;
             SetRateCellValue(ACol, i, DestPriceData, DestPriceData.price);
          end else

          if (DestPriceData.connectSingleUseRateToMasterRate AND isSingleUsePriceRow(ARow)) then
          begin
             if DestPriceData.SingleUseRateDeviationType = 'FIXED_AMOUNT' then
               tmpValue := PriceData.SingleUsePrice + DestPriceData.masterRateSingleUseRateDeviation
             else
               tmpValue := PriceData.SingleUsePrice * (1 + DestPriceData.masterRateSingleUseRateDeviation / 100);
             if tmpValue > 0.00 then
               DestPriceData.SingleUsePrice := tmpValue;
             SetSingleUsePriceCellValue(ACol, i, DestPriceData, DestPriceData.SingleUsePrice);
          end else

          if (DestPriceData.connectMaxStayToMasterRate AND isMaxStayRow(ARow)) then
          begin
            DestPriceData.MaxStay := PriceData.MaxStay;
            SetMaxStayCellValue(ACol, i, DestPriceData, DestPriceData.MaxStay);
          end else

          if (DestPriceData.connectMinStayToMasterRate AND isMinStayRow(ARow)) then
          begin
            DestPriceData.MinStay := PriceData.MinStay;
            SetMinStayCellValue(ACol, i, DestPriceData, DestPriceData.MinStay);
          end else

          if (DestPriceData.connectStopSellToMasterRate AND isStopSellRow(ARow)) then
          begin
            DestPriceData.stopSell := PriceData.StopSell;
            cbValue := PriceData.StopSell;
            rateGrid.SetCheckBoxState(ACol, i, cbValue);
          end else

          if (DestPriceData.connectCODToMasterRate AND isClosedOnDepartureRow(ARow)) then
          begin
            DestPriceData.COD := PriceData.COD;
            cbValue := PriceData.COD;
            rateGrid.SetCheckBoxState(ACol, i, cbValue);
          end else

          if (DestPriceData.connectCOAToMasterRate AND isCloseOnArrivalRow(ARow)) then
          begin
            DestPriceData.COA := PriceData.COA;
            cbValue := PriceData.COA;
            rateGrid.SetCheckBoxState(ACol, i, cbValue);
          end else

          if (DestPriceData.connectAvailabilityToMasterRate AND isAvailabilityRow(ARow)) then
            DestPriceData.Availability := PriceData.Availability
          else

          if (DestPriceData.connectLOSToMasterRate AND isLOSArrivalDateBasedRow(ARow)) then
          begin
            DestPriceData.LOSArrivalDateBased := PriceData.LOSArrivalDateBased;
            cbValue := PriceData.LOSArrivalDateBased;
            rateGrid.SetCheckBoxState(ACol, i, cbValue);
          end;

        end;
      end;
    end;
  end;
end;


procedure TfrmChannelAvailabilityManager.rateGridCellValidate(Sender: TObject; ACol, ARow: integer; var value: string; var Valid: Boolean);
var
  dValue: Double;
  iValue: integer;
  PriceData: TPriceData;
begin
  if Halting then
    exit;
  if TAdvStringGrid(Sender).Tag = 1 then
    exit;
  if Sender = grid then
  begin
    if (StrToFloatDef(value, -999999999) = -999999999) OR (_StrToFloat(value) < 0) then
    begin
      grid.InvalidEntryTitle := GetTranslatedText('shTx_ChannelAvailabilityManager_IncorrectAvailability');
      grid.InvalidEntryText := GetTranslatedText('shTx_ChannelAvailabilityManager_EnterValidValue');
      grid.InvalidEntryIcon := ieError;
      Valid := false;
    end
    else
      Valid := true;
  end
  else
  begin
    if isAnyCheckBoxRow(ARow) then
      exit;

    rateGrid.BeginUpdate;
    try
      Valid := true;
      PriceData := getPriceDataOfRow(ACol, ARow);
      if assigned(PriceData) then
      begin
        TAdvStringGrid(Sender).Tag := 1;
        try
          if isPriceRow(ARow) then
          begin
            dValue := getRateValueForCell(value, ACol, ARow, False);
            Valid := dValue <> 0;
            if Valid then
              if dValue <> PriceData.price then
              begin
                SetRateValue(ACol, ARow, FloatToStr(dValue), rateGrid, true);
                CorrectMasterRateLinkedCells(PriceData, ACol, ARow);
                timRecalc.enabled := true;
              end;
          end else
          if isSingleUsePriceRow(ARow) then
          begin
            dValue := getRateValueForCell(value, ACol, ARow, True);
            Valid := dValue <> 0;
            if Valid then
              if dValue <> PriceData.SingleUsePrice then
              begin
                SetSingleUsePriceCellValue(ACol, ARow, PriceData, dValue);
                CorrectMasterRateLinkedCells(PriceData, ACol, ARow);
                timRecalc.enabled := true;
              end;
          end else
          begin
            iValue := StrToIntDef(value, -9999999);
            if iValue <> -9999999 then
            begin
              if isAvailabilityRow(ARow) then
                PriceData.Availability := iValue
              else if isMinStayRow(ARow) then
                PriceData.minStay := iValue
              else if isMaxStayRow(ARow) then
                PriceData.MaxStay := iValue;

              CorrectMasterRateLinkedCells(PriceData, ACol, ARow);
            end
            else
              Valid := false;
          end;
        finally
          TAdvStringGrid(Sender).Tag := 0;
        end;
      end;
    finally
      rateGrid.EndUpdate;
    end;
  end;
end;

procedure TfrmChannelAvailabilityManager.rateGridCheckBoxChange(Sender: TObject; ACol, ARow: integer; State: Boolean);
var
  cbState: Boolean;
  PriceData : TPriceData;
begin
  if Halting then
    exit;
  rateGrid.GetCheckBoxState(ACol, ARow, cbState);
  PriceData := getPriceDataOfRow(ACol, ARow);
  if Assigned(PriceData) then
  begin
    if isStopSellRow(ARow) then
      PriceData.stopSell := cbState
    else if isCloseOnArrivalRow(ARow) then
      PriceData.COA := cbState
    else if isClosedOnDepartureRow(ARow) then
      PriceData.COD := cbState
    else if isLOSArrivalDateBasedRow(ARow) then
      PriceData.LOSArrivalDateBased := cbState;

    CorrectMasterRateLinkedCells(PriceData, ACol, ARow);
  end;
end;

procedure TfrmChannelAvailabilityManager.rateGridClipboardAfterPasteCell(Sender: TObject; ACol, ARow: integer; value: string);
var
  dValue: Double;
  iValue: integer;
  PriceData: TPriceData;
begin
  if Halting then
    exit;
  PriceData := getPriceDataOfRow(ACol, ARow);
  if Assigned(PriceData) then
  begin
    if isPriceRow(ARow) then
    begin
      timRecalc.enabled := false;
      dValue := getRateValueForCell(value, ACol, ARow, false);
      if dValue <> PriceData.price then
      begin
        SetRateValue(ACol, ARow, FloatToStr(dValue), rateGrid, true);
        CorrectMasterRateLinkedCells(PriceData, ACol, ARow);
        timRecalc.enabled := true;
      end;
    end else
    if isSingleUsePriceRow(ARow) then
    begin
      timRecalc.enabled := false;
      dValue := getRateValueForCell(value, ACol, ARow, true);
      if dValue <> PriceData.SingleUsePrice then
      begin
        SetSingleUsePriceCellValue(ACol, ARow, PriceData, dValue);
        CorrectMasterRateLinkedCells(PriceData, ACol, ARow);
        timRecalc.enabled := true;
      end;
    end else
    begin
      iValue := StrToIntDef(value, -9999999);
      if iValue <> -9999999 then
      begin
        if isAvailabilityRow(ARow) then
          PriceData.Availability := iValue
        else if isMinStayRow(ARow) then
          PriceData.minStay := iValue
        else if isMaxStayRow(ARow) then
          PriceData.MaxStay := iValue;
        CorrectMasterRateLinkedCells(PriceData, ACol, ARow);
      end
    end;
  end;
end;

procedure TfrmChannelAvailabilityManager.rateGridClipboardBeforePasteCell(Sender: TObject; ACol, ARow: integer; var value: string; var Allow: Boolean);
begin
  if Halting then
    exit;
  Allow := isAnyEditableRow(ARow);
end;

function intValueOfCell(value: String): integer;
begin
  result := trunc(uFloatUtils.LocalizedFloatValue(value));
end;

CONST BOX_WIDTH = 8;

procedure TfrmChannelAvailabilityManager.rateGridDrawCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
var
  SavedAlign: Word;
  S: String;

  PriceData: TPriceData;
  ARect: TRect;
begin
  if Halting then
    exit;

  if rateGrid.RowHeights[ARow] = 0 then
    exit;

  if isPriceRow(ARow) then
  begin
    PriceData := nil;
    if (ACol > 0) AND (ARow > 0) AND isAnyEditableRow(ARow) then
      PriceData := getPriceDataOfRow(ACol, ARow);
    if Assigned(PriceData) then
      with rateGrid.Canvas do
      begin
        ARect.Top := Rect.Top + 5;
        ARect.Height := Rect.Height - 3;
        ARect.Left := Rect.Left;
        if PriceData.isEdited then
        begin
          Brush.Color := clRed;
          Brush.Style := bsSolid;
          ARect.Left := Rect.Left;
          ARect.Width := BOX_WIDTH;
          FillRect(ARect);
        end;
        if PriceData.stopSell then
        begin
          Brush.Color := clAqua;
          Brush.Style := bsSolid;
          ARect.Left := ARect.Left + BOX_WIDTH;
          ARect.Width := BOX_WIDTH;
          FillRect(ARect);
        end;
        if PriceData.COA OR PriceData.COD OR PriceData.LOSArrivalDateBased OR (PriceData.minStay > 1) OR
          (PriceData.MaxStay <> 0) then
        begin
          Brush.Color := clOlive;
          Brush.Style := bsSolid;
          ARect.Left := Rect.Left + BOX_WIDTH * 2;
          ARect.Width := BOX_WIDTH;
          FillRect(ARect);
        end;
      end;
    exit;
  end;

  if (ACol > 0) AND (isAvailabilityRow(ARow)) then
  begin
    if intValueOfCell(rateGrid.Cells[ACol, ARow]) = -1 then
      with rateGrid.Canvas do
      begin
        Brush.Color := clHighLight;
        Brush.Style := bsSolid;
        Font.Color := clWhite;
        if isCurrentlySelectedValueEdited(ACol, ARow) then
        begin
          Brush.Color := clBlue;
          Font.Color := clWhite;
        end;
        if gdSelected in State then
        begin
          Font.Color := clWhite; // InvertColor(fColor);
          Brush.Color := clGray; // InvertColor(bColor);
        end;
        FillRect(Rect);

        SavedAlign := SetTextAlign(Handle, TA_RIGHT);
        if StrToIntDef(grid.Cells[ACol, ARow], 0) = -1 then
          S := inttostr(intValueOfCell(rateGrid.Cells[ACol, ARow]))
        else
        begin
          S := 'auto';
          try
            S := S + ' (' + inttostr(locateAvailabilityFromRoomTypeCodeAndDate(TCellData(grid.Objects[ACol, ARow]).FRoomClassCode, TCellData(grid.Objects[ACol, ARow]).date)) + ')';
          except
          end;
        end;
        TextRect(Rect, Rect.Right - 4, Rect.Top + 2, S);
        SetTextAlign(Handle, SavedAlign);

        exit;
      end;
  end;
end;

procedure TfrmChannelAvailabilityManager.rateGridEditCellDone(Sender: TObject; ACol, ARow: integer);
var PriceData : TPriceData;
begin
  if Halting then
    exit;
  if rateGrid.RowHeights[ARow] = 0 then
    exit;

  PriceData := GetPriceDataOfRow(ACol, ARow);
  if isAvailabilityRow(ARow) then
    PriceData.Availability := StrToIntDef(rateGrid.Cells[ACol, ARow], 0)
  else if isMinStayRow(ARow) then
    PriceData.minStay := StrToIntDef(rateGrid.Cells[ACol, ARow], 0)
  else if isMaxStayRow(ARow) then
    PriceData.MaxStay := StrToIntDef(rateGrid.Cells[ACol, ARow], 0)
  else if NOT isAnyCheckBoxRow(ARow) then
    SetRateValue(ACol, ARow, rateGrid.Cells[ACol, ARow], rateGrid, true, isSingleUsePriceRow(ARow));
end;

procedure TfrmChannelAvailabilityManager.rateGridGetAlignment(Sender: TObject; ARow, ACol: integer; var HAlign: TAlignment; var VAlign: AdvObj.TVAlignment);
begin
  if Halting then
    exit;
  if rateGrid.RowHeights[ARow] = 0 then
    exit;
  if (ARow < 1) OR (ACol < 1) then
    exit;
  if isAnyCheckBoxRow(ARow) then
    HAlign := taCenter
  else if isAnyEditBoxRow(ARow) then
    HAlign := taRightJustify;
end;

procedure TfrmChannelAvailabilityManager.rateGridGetCellBorder(Sender: TObject; ARow, ACol: integer; APen: TPen; var Borders: TCellBorders);
begin
  if Halting then
    exit;
  if (ARow < 1) OR (ACol < 1) then
    exit;
  if rateGrid.RowHeights[ARow] = 0 then
    exit;

  if (NOT isAnyCheckBoxRow(ARow)) AND ((rateGrid.Cells[ACol, ARow] = '') OR (rateGrid.Cells[ACol, ARow] = '-')) then
    Borders := []
  else
  begin
    Borders := [cbLeft, cbRight];
    APen.Color := clBlack;
    if isPriceRow(ARow) then
    begin
      Borders := [cbLeft, cbRight, cbTop];
      APen.Width := 1;
    end;

  end;
end;

procedure TfrmChannelAvailabilityManager.rateGridGetCellColor(Sender: TObject; ARow, ACol: integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
var
  PriceData: TPriceData;
  available: integer;
begin
  if Halting then
    exit;
  if rateGrid.RowHeights[ARow] = 0 then
    exit;


  if (ARow > 0) AND
     ((rateGrid.Cells[0, ARow] = '') OR
      (rateGrid.Cells[0, ARow] = '-')) AND
      (NOT isAnyCheckBoxRow(ARow)) then
  begin
    ABrush.Color := clBlack; // frmMain.sSkinManager1.GetActiveEditFontColor;
    AFont.Color := clBlack; // frmMain.sSkinManager1.GetActiveEditColor;
    exit;
  end;

  if (ARow > 0) AND
     ((rateGrid.Cells[ACol, ARow] = '') OR
      (rateGrid.Cells[ACol, ARow] = '-')) AND
      (NOT isAnyCheckBoxRow(ARow)) then
  begin
    AFont.Color := ABrush.Color; // frmMain.sSkinManager1.GetActiveEditColor;
    exit;
  end;

  if gdSelected in AState then
  begin
    ABrush.Color := clBlue; // frmMain.sSkinManager1.GetActiveEditFontColor;
    AFont.Color := clWhite; // frmMain.sSkinManager1.GetActiveEditColor;
    exit;
  end;

  if (ACol < 1) OR (ARow < 1) then
  begin
    ABrush.Color := frmMain.sSkinManager1.GetGlobalColor;
    AFont.Color := frmMain.sSkinManager1.GetGlobalFontColor;
    exit;
  end;

  if (NOT isAnyCheckBoxRow(ARow)) AND ((rateGrid.Cells[ACol, ARow] = '') OR (rateGrid.Cells[ACol, ARow] = '-')) then
  begin
    ABrush.Color := frmMain.sSkinManager1.GetGlobalColor;
    AFont.Color := frmMain.sSkinManager1.GetGlobalColor;
    exit;
  end;

  PriceData := nil;
  if isAnyEditableRow(ARow) AND (ACol > 0) AND (ARow > 0) then
    PriceData := getPriceDataOfRow(ACol, ARow);

  if Assigned(PriceData) then
  begin
    ABrush.Color := frmMain.sSkinManager1.GetGlobalColor;
    if isAvailabilityRow(ARow) AND (PriceData.FRoomTypeGroupCode <> PriceData.FRoomTypeTopClass) then
    begin
      ABrush.Style := bsDiagCross;
      AFont.Color := ABrush.Color;
      exit;
    end;

    if isAvailabilityRow(ARow) then
    begin
      available := locateAvailabilityFromRoomTypeCodeAndDate(PriceData.FRoomTypeTopClass, PriceData.FDate);
      if available < PriceData.Availability then
      begin
        ABrush.Color := $000080FF;
        AFont.Color := clWhite;
        exit;
      end;
    end;

    ABrush.Color := frmMain.sSkinManager1.GetGlobalColor;
    AFont.Color := frmMain.sSkinManager1.GetGlobalFontColor;
    if isCurrentlySelectedValueEdited(ACol, ARow) then
    begin
      ABrush.Color := frmMain.sSkinManager1.GetGlobalFontColor;
      AFont.Color := frmMain.sSkinManager1.GetGlobalColor;
    end;
  end;
end;

procedure TfrmChannelAvailabilityManager.rateGridGetEditorType(Sender: TObject; ACol, ARow: integer; var AEditor: TEditorType);
begin
  if Halting then
    exit;
  if rateGrid.RowHeights[ARow] = 0 then
    exit;
  if isAnyCheckBoxRow(ARow) then
    AEditor := edCheckBox
  else
  begin
    AEditor := edNormal;
    rateGrid.ValidChars := '0123456789+-!%*/';
  end;
end;

procedure TfrmChannelAvailabilityManager.rateGridGridHint(Sender: TObject; ARow, ACol: integer; var hintstr: string);
var
  available: integer;
  PriceData: TPriceData;

  ExtraLine: String;
  function getExtraLine: String;
  begin
    result := ExtraLine;
    if ExtraLine <> '' then
      ExtraLine := '';
  end;

begin
  if Halting then
    exit;
  if rateGrid.RowHeights[ARow] = 0 then
    exit;
  hintstr := '';
  if isAnyEditableRow(ARow) then
  begin
    if ACol = 0 then
    begin
      PriceData := getPriceDataOfRow(1, ARow);
      if Assigned(PriceData) then
      begin
        hintstr := ''; // PriceData.
      end;
    end
    else
    begin
      PriceData := getPriceDataOfRow(ACol, ARow);
      if Assigned(PriceData) then
      begin
        ExtraLine := '<hr><br>';
        available := locateAvailabilityFromRoomTypeCodeAndDate(PriceData.FRoomTypeTopClass, PriceData.date);
        hintstr := BODY_START;

        if PriceData.isEdited then
          hintstr := hintstr + '<font bgcolor="#0000FF" color="#FF0000"><b>CHANGED!</b></font><br><font bgcolor="#0000FF" color="#FFFFFF">';

        hintstr := hintstr + format(GetTranslatedText('shTx_ChannelAvailabilityManager_RoomAvailability'), ['', BOLD_START, available, BOLD_END]) + '<br>';

        if PriceData.minStay > 1 then
          hintstr := hintstr + getExtraLine + format(ACTIVE_SETTING_RESTRICTION, ['Minimum days', PriceData.minStay]);
        if PriceData.MaxStay >= 1 then
          hintstr := hintstr + getExtraLine + format(ACTIVE_SETTING_RESTRICTION, ['Maximum days', PriceData.MaxStay]);

        if PriceData.stopSell then
          hintstr := hintstr + getExtraLine + format(ACTIVE_FLAG_RESTRICTION, ['Stop sell']);
        if PriceData.COA then
          hintstr := hintstr + getExtraLine + format(ACTIVE_FLAG_RESTRICTION, ['Closed on arrival']);
        if PriceData.COD then
          hintstr := hintstr + getExtraLine + format(ACTIVE_FLAG_RESTRICTION, ['Closed on departure']);
        if PriceData.LOSArrivalDateBased then
          hintstr := hintstr + getExtraLine + format(ACTIVE_FLAG_RESTRICTION, ['Length of stay arrival date based']);
        hintstr := hintstr + BODY_END;
      end;
    end;
  end;
end;

procedure TfrmChannelAvailabilityManager.rateGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  iRow: integer;
begin
  if Halting then
    exit;
  if Key = VK_DOWN then
  begin
    if TAdvStringGrid(Sender).Row <= TAdvStringGrid(Sender).RowCount - 1 then
    begin
      iRow := TAdvStringGrid(Sender).Row + 1;
      while ((iRow < TAdvStringGrid(Sender).RowCount) AND (TAdvStringGrid(Sender).RowHeights[iRow] < 9)) do
        iRow := iRow + 1;
      if iRow <= TAdvStringGrid(Sender).RowCount then
        TAdvStringGrid(Sender).Row := iRow - 1;
    end;
  end
  else if Key = VK_UP then
  begin
    if TAdvStringGrid(Sender).Row > 2 then
    begin
      iRow := TAdvStringGrid(Sender).Row - 1;
      while ((iRow > 1) AND (TAdvStringGrid(Sender).RowHeights[iRow] < 9)) do
        iRow := iRow - 1;
      if iRow > 1 then
        TAdvStringGrid(Sender).Row := iRow + 1;
    end;
  end;

  if NOT TAdvStringGrid(Sender).EditMode then
  begin
    if Key = VK_DELETE then
    begin
      DeleteContentOfCurrentCell;
    end;

  end
  else if Key = VK_RIGHT then
  begin
    if TAdvStringGrid(Sender).Col < TAdvStringGrid(Sender).ColCount then
      TAdvStringGrid(Sender).Col := TAdvStringGrid(Sender).Col + 1;

  end;
end;

procedure TfrmChannelAvailabilityManager.rateGridKeyPress(Sender: TObject; var Key: Char);
begin
  if Halting then
    exit;
  if (Key = #3) then
    TAdvStringGrid(Sender).CopySelectionToClipboard
  else if (Key = #22) then
  begin
    TAdvStringGrid(Sender).PasteSelectionFromClipboard;
    GridPostPasteAction(grid);
  end;
end;

procedure TfrmChannelAvailabilityManager.GridPostPasteAction(_grid: TAdvStringGrid);
var
  iRowCounter, iColCounter: integer;
  value: String;
  Checked: Boolean;
begin
  for iRowCounter := 1 to _grid.RowCount - 1 do
  begin
    for iColCounter := 1 to _grid.ColCount - 1 do
    begin
      if _grid = grid then
      begin
        if _grid.IsSelected(iColCounter, iRowCounter) then
          if EditableCell(_grid, iRowCounter, iColCounter) then
          begin
            value := _grid.Cells[iColCounter, iRowCounter];
            SetAvailabilityValue(iRowCounter, value, _grid, iColCounter);
          end;
      end else
      begin
        if _grid.IsSelected(iColCounter, iRowCounter) then
          if isAnyEditBoxRow(iRowCounter) then
          begin
            value := _grid.Cells[iColCounter, iRowCounter];
            SetRateValue(iColCounter, iRowCounter, value, _grid, isSingleUsePriceRow(iRowCounter));
          end
          else if isAnyCheckBoxRow(iRowCounter) then
          begin
            Checked := _grid.IsChecked(iColCounter, iRowCounter);
            SetCheckBoxStateForCheckBoxCells(iColCounter, iRowCounter, Checked);
          end;
      end;
    end;
  end;
end;

procedure TfrmChannelAvailabilityManager.getPriceOfSpecificCell;
var
  sql: String;
  PriceData: TPriceData;
  RSet: TRoomerDataSet;
  i, iCol, iRow: integer;
  ExecutionPlan: TRoomerExecutionPlan;
begin
  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  try
    i := 0;
    for iRow := 1 to rateGrid.RowCount - 1 do
      for iCol := 1 to rateGrid.RowCount - 1 do
        if (rateGrid.SelectedCells[iCol, iRow]) OR (rateGrid.Cells[iCol, iRow] = '?') then
        begin
          if EditableCell(rateGrid, iRow, iCol) then
          begin
            inc(i);
            sql := 'SELECT rtg.id AS rtgId, rtg.Code, ' + '	IF(rtg.numGuests=1, rt.Rate1Person, ' + '         IF(rtg.numGuests=2, rt.Rate2Persons, ' +
              '           IF(rtg.numGuests=3, rt.Rate3Persons, ' + '             IF(rtg.numGuests=4, rt.Rate4Persons, ' +
              '               IF(rtg.numGuests=5, rt.Rate5Persons, ' +
              '                 IF(rtg.numGuests=6, rt.Rate6Persons, rt.Rate1Person + ((rtg.numGuests-1) * rt.RateExtraPerson) )))))) AS Price ' + ' ' +
              'FROM roomtypegroups rtg, tblpricecodes pc, ' + '		(SELECT * ' + '				FROM rates ra, ' + '					(SELECT Currency AS cuCurrency ' +
              '						FROM currencies ' + '						WHERE id=(SELECT currencyId FROM channels WHERE id=%d)) cu ' + ' ' +
              '				WHERE ra.Currency=cuCurrency ' + '				AND ra.isDefault AND ra.Active) rt ' + ' ' +
              'WHERE rtg.id IN (SELECT ccr.roomClassId FROM channelclassrelations ccr WHERE ccr.channelId=%d AND ccr.roomClassId=rtg.id) ' +
              '    AND pc.pcRack ' + '	   AND rtg.id=%d';
            PriceData := TPriceData(rateGrid.Objects[iCol, iRow]);
            sql := format(sql,

              [PriceData.channelId, PriceData.channelId, PriceData.roomTypeGroupId]);
            ExecutionPlan.AddQuery(sql)
          end;
        end;

    if i > 0 then
    begin
      i := 0;
      if ExecutionPlan.Execute(ptQuery) then
      begin
        for iRow := 1 to rateGrid.RowCount - 1 do
          for iCol := 1 to rateGrid.RowCount - 1 do
            if (rateGrid.SelectedCells[iCol, iRow]) OR (rateGrid.Cells[iCol, iRow] = '?') then
            begin
              if EditableCell(rateGrid, iRow, iCol) then
              begin
                inc(i);
                RSet := ExecutionPlan.Results[i - 1];
                RSet.First;
                if NOT RSet.EOF then
                  rateGrid.Cells[iCol, iRow] :=
                    Trim(FloatToStrF(RSet['Price'], ffFixed, 12, NumDecimals(TPriceData(rateGrid.Objects[iCol, iRow]).rateRoundingType)));
              end;
            end;
      end;
    end;
  finally
    ExecutionPlan.free;
  end;
end;

function TfrmChannelAvailabilityManager.getPriceForOnCell(ACol, ARow: integer): Double;
var
  sql: String;
  PriceData: TPriceData;
  RSet: TRoomerDataSet;
begin
  Result := 0;
  if EditableCell(rateGrid, ARow, ACol) then
  begin
    sql := 'SELECT rtg.id AS rtgId, rtg.Code, ' + '	IF(rtg.numGuests=1, rt.Rate1Person, ' + '         IF(rtg.numGuests=2, rt.Rate2Persons, ' +
      '           IF(rtg.numGuests=3, rt.Rate3Persons, ' + '             IF(rtg.numGuests=4, rt.Rate4Persons, ' +
      '               IF(rtg.numGuests=5, rt.Rate5Persons, ' +
      '                 IF(rtg.numGuests=6, rt.Rate6Persons, rt.Rate1Person + ((rtg.numGuests-1) * rt.RateExtraPerson) )))))) AS Price ' + ' ' +
      'FROM roomtypegroups rtg, tblpricecodes pc, ' + '		(SELECT * ' + '				FROM rates ra, ' + '					(SELECT Currency AS cuCurrency ' +
      '						FROM currencies ' + '						WHERE id=(SELECT currencyId FROM channels WHERE id=%d)) cu ' + ' ' +
      '				WHERE ra.Currency=cuCurrency ' + '				AND ra.isDefault AND ra.Active) rt ' + ' ' +
      'WHERE rtg.id IN (SELECT ccr.roomClassId FROM channelclassrelations ccr WHERE ccr.channelId=%d AND ccr.roomClassId=rtg.id) ' + '    AND pc.pcRack ' +
      '	   AND rtg.id=%d';
    PriceData := TPriceData(rateGrid.Objects[ACol, ARow]);
    sql := format(sql,

      [PriceData.channelId, PriceData.channelId, PriceData.roomTypeGroupId]);
    RSet := RoomerDataSet.ActivateNewDataset(RoomerDataSet.queryRoomer(sql));
    try
      RSet.First;
      if NOT RSet.EOF then
        result := RSet['Price']
      else
        result := _StrToFloat(rateGrid.Cells[ACol, ARow]);
    finally
      FreeAndNil(RSet);
    end;
  end;
end;

procedure TfrmChannelAvailabilityManager.DeleteContentOfCurrentCell;
var
  _grid: TAdvStringGrid;
begin
  _grid := CurrentActiveGrid;
  if EditableCell(_grid, _grid.Row, _grid.Col) then
    if (_grid.Objects[_grid.Col, _grid.Row] <> nil) and (_grid.Objects
    [_grid.Col, _grid.Row] is TPriceData) then
    begin
      getPriceOfSpecificCell;
    end;
end;

{ TPriceData }

procedure TPriceData.ClearEdited;
begin
  FPriceDirty := false;
  FStopSellDirty := false;
  FAvailabilityDirty := false;
  FMinStayDirty := false;
  FMaxStayDirty := false;
  FCOADirty := false;
  FCODDirty := false;
  FLOSArrivalDateBasedDirty := false;
  FSingleUsePriceDirty := false;
  FSingleUsePriceDirty := false;
end;

constructor TPriceData.Create(_Id: integer; const roomtypeGroupCode, _roomTypeTopClass: String; date: TDateTime;
  rateRoundingType, channelId, roomTypeGroupId, channelManager: integer; price: Double; stopSell: Boolean; minStay: integer; _Availability: integer;
  _MaxStay: integer; _COA: Boolean; _COD: Boolean; _LOSArrivalDateBased: Boolean; _SingleUsePrice: Double
  ;
  _connectRateToMasterRate : Boolean;
  _masterRateRateDeviation : Double;
  const _RateDeviationType : String;

  _connectSingleUseRateToMasterRate : Boolean;
  _masterRateSingleUseRateDeviation : Double;
  const _singleUseRateDeviationType : String;

  _connectStopSellToMasterRate : Boolean;
  _connectAvailabilityToMasterRate : Boolean;
  _connectMinStayToMasterRate : Boolean;
  _connectMaxStayToMasterRate : Boolean;
  _connectCOAToMasterRate : Boolean;
  _connectCODToMasterRate : Boolean;
  _connectLOSToMasterRate : Boolean
  );
begin
  ForcingUpdate := false;
  FOldValue := 0.00;

  FId := _Id;
  FChannelId := channelId;
  FRateRoundingType := rateRoundingType;
  FRoomTypeGroupCode := roomtypeGroupCode;
  FRoomTypeTopClass := _roomTypeTopClass;
  FRoomTypeGroupId := roomTypeGroupId;
  FDate := date;

  FMinStay := minStay;
  FStopSell := stopSell;

  FPrice := price;
  FOldValue := price;

  FAvailability := _Availability;
  FMaxStay := _MaxStay;
  FCOA := _COA;
  FCOD := _COD;
  FLOSArrivalDateBased := _LOSArrivalDateBased;
  FSingleUsePrice := _SingleUsePrice;

  FPriceDirty := false;
  FAvailabilityDirty := false;
  FStopSellDirty := false;
  FMinStayDirty := false;
  FMaxStayDirty := false;
  FCOADirty := false;
  FCODDirty := false;
  FLOSArrivalDateBasedDirty := false;
  FSingleUsePriceDirty := false;

  FChannelManager := channelManager;

  connectRateToMasterRate := _connectRateToMasterRate;
  masterRateRateDeviation := _masterRateRateDeviation;
  RateDeviationType := _RateDeviationType;

  connectSingleUseRateToMasterRate := _connectSingleUseRateToMasterRate;
  masterRateSingleUseRateDeviation := _masterRateSingleUseRateDeviation;
  singleUseRateDeviationType := _singleUseRateDeviationType;

  connectStopSellToMasterRate := _connectStopSellToMasterRate;
  connectAvailabilityToMasterRate := _connectAvailabilityToMasterRate;
  connectMinStayToMasterRate := _connectMinStayToMasterRate;
  connectMaxStayToMasterRate := _connectMaxStayToMasterRate;
  connectCOAToMasterRate := _connectCOAToMasterRate;
  connectCODToMasterRate := _connectCODToMasterRate;
  connectLOSToMasterRate := _connectLOSToMasterRate;
end;

destructor TPriceData.Destroy;
begin
  inherited;
end;

function TPriceData.isEdited: Boolean;
begin
  result := FPriceDirty OR FAvailabilityDirty OR FStopSellDirty OR FMaxStayDirty OR FMinStayDirty OR FCOADirty OR FCODDirty OR FLOSArrivalDateBasedDirty OR
    FSingleUsePriceDirty;
end;

procedure TPriceData.SetAvailability(const value: integer);
begin
  FAvailabilityDirty := FAvailabilityDirty OR (FAvailability <> value);
  FAvailability := value;
end;

procedure TPriceData.SetCOA(const value: Boolean);
begin
  FCOADirty := FCOADirty OR (FCOA <> value);
  FCOA := value;
end;

procedure TPriceData.SetCOD(const value: Boolean);
begin
  FCODDirty := FCODDirty OR (FCOD <> value);
  FCOD := value;
end;

procedure TPriceData.SetLOSArrivalDateBased(const value: Boolean);
begin
  FLOSArrivalDateBasedDirty := FLOSArrivalDateBasedDirty OR (FLOSArrivalDateBased <> value);
  FLOSArrivalDateBased := value;
end;

procedure TPriceData.SetMaxStay(const value: integer);
begin
  FMaxStayDirty := FMaxStayDirty OR (FMaxStay <> value);
  FMaxStay := value;
end;

procedure TPriceData.setMinStay(const value: integer);
begin
  FMinStayDirty := FMinStayDirty OR (FMinStay <> value);
  FMinStay := value;
end;

procedure TPriceData.SetPrice(const value: Double);
begin
  FPriceDirty := FPriceDirty OR (FPrice <> value);
  FPrice := value;
end;

procedure TPriceData.SetSingleUsePrice(const value: Double);
begin
  FSingleUsePriceDirty := FSingleUsePriceDirty OR (FSingleUsePrice <> value);
  FSingleUsePrice := value;
end;

procedure TPriceData.setStopSell(const value: Boolean);
begin
  FStopSellDirty := FStopSellDirty OR (FStopSell <> value);
  FStopSell := value;
end;

{ TChannelManagerValue }

constructor TChannelManagerValue.Create(Id: integer; const description, username, password: String; _numDays: integer);
begin
  FId := Id;
  FDescription := description;
  FAdminUser := username;
  FAdminPassword := password;
  FNumDays := _numDays;
end;

{ TPlanCodeValue }

constructor TPlanCodeValue.Create(Id: integer; const Code, description: String);
begin
  FId := Id;
  FDescription := description;
  FCode := Code;
end;

{ TDictionaryItem }

constructor TDictionaryItem.Create(const Code, ADate: String; value: integer);
begin
  FCode := Code;
  FDate := ADate;
  fvalue := value;
end;

end.

