unit urptReservations;

interface

uses
   Windows
  ,Messages
  ,SysUtils
  ,Variants
  , Classes
  ,Graphics
  ,Controls
  ,Forms
  ,Dialogs
  ,StdCtrls
  ,ExtCtrls
  ,shellapi
  ,DB
  ,Vcl.ComCtrls
  , Vcl.Mask

  ,ADODB

  ,dateUtils
  ,Menus
  ,hData
  ,_glob
  ,ug
  ,uUtils

  ,cmpRoomerDataSet
  ,cmpRoomerConnection

  ,kbmMemTable

  , sGroupBox
  , sPageControl
  , sPanel
  , sLabel
  , sEdit
  , sSpinEdit
  , sComboBox
  , sButton
  , sMaskEdit
  , sCustomComboEdit
  , sTooledit
  , uDImages

  , cxGridExportLink
  , cxGraphics
  , cxControls
  , cxLookAndFeels
  , cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData, cxCalendar,
  dxSkinsdxStatusBarPainter, cxGridCustomPopupMenu, cxGridPopupMenu, cxPropertiesStore, Vcl.Buttons, sSpeedButton, dxStatusBar, cxGridLevel,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView,
  cxGrid, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinDarkRoom,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue

  ;

type
  TfrmRptReservations = class(TForm)
    pageMain: TsPageControl;
    dxStatusBar1 : TdxStatusBar;
    Panel3: TsPanel;
    cxGroupBox2: TsGroupBox;
    cbxMonth: TsComboBox;
    cbxYear: TsComboBox;
    btnRefresh: TsButton;
    tabReservation: TsTabSheet;
    Panel5: TsPanel;
    btnGuestsExcel: TsButton;
    brnGuestsReservation: TsButton;
    btnExpandAll: TsButton;
    btnCollapseAll: TsButton;
    btnGuestsRoom: TsButton;
    gbxSelectDates: TsGroupBox;
    dtDateFrom: TsDateEdit;
    dtDateTo: TsDateEdit;
    kbmReservations_: TkbmMemTable;
    kbmReservationsDS: TDataSource;
    grReservations: TcxGrid;
    tvReservations: TcxGridDBTableView;
    lvReservations: TcxGridLevel;
    tvReservationsreservation: TcxGridDBColumn;
    tvReservationsCustomer: TcxGridDBColumn;
    tvReservationsReservationName: TcxGridDBColumn;
    tvReservationsAddress1: TcxGridDBColumn;
    tvReservationsAddress2: TcxGridDBColumn;
    tvReservationsAddress3: TcxGridDBColumn;
    tvReservationsAddress4: TcxGridDBColumn;
    tvReservationsCountry: TcxGridDBColumn;
    tvReservationsStaff: TcxGridDBColumn;
    tvReservationsInformation: TcxGridDBColumn;
    tvReservationsPMInfo: TcxGridDBColumn;
    tvReservationsContactName: TcxGridDBColumn;
    tvReservationsContactPhone: TcxGridDBColumn;
    tvReservationsContactFax: TcxGridDBColumn;
    tvReservationsContactEmail: TcxGridDBColumn;
    tvReservationsinputsource: TcxGridDBColumn;
    tvReservationsarrivaltime: TcxGridDBColumn;
    tvReservationssrcrequest: TcxGridDBColumn;
    tvReservationsID: TcxGridDBColumn;
    tvReservationsCustPID: TcxGridDBColumn;
    tvReservationsinvRefrence: TcxGridDBColumn;
    tvReservationsmarketSegment: TcxGridDBColumn;
    tvReservationsCustomerEmail: TcxGridDBColumn;
    tvReservationsCustomerWebsite: TcxGridDBColumn;
    tvReservationsexternalIds: TcxGridDBColumn;
    tvReservationsdtCreated: TcxGridDBColumn;
    tvReservationsdtArrival: TcxGridDBColumn;
    tvReservationsdtDeparture: TcxGridDBColumn;
    tvReservationsCustomerName: TcxGridDBColumn;
    tvReservationsChannelName: TcxGridDBColumn;
    tvReservationsGuestCount: TcxGridDBColumn;
    tvReservationsroomCount: TcxGridDBColumn;
    kbmRoomReservations_: TkbmMemTable;
    kbmRoomReservationsDS: TDataSource;
    lvRoomReservations: TcxGridLevel;
    tvRoomReservations: TcxGridDBTableView;
    tvRoomReservationsRoomreservation: TcxGridDBColumn;
    tvRoomReservationsreservation: TcxGridDBColumn;
    tvRoomReservationsroom: TcxGridDBColumn;
    tvRoomReservationsrrArrival: TcxGridDBColumn;
    tvRoomReservationsrrDeparture: TcxGridDBColumn;
    tvRoomReservationsGuestCount: TcxGridDBColumn;
    tvRoomReservationsStatus: TcxGridDBColumn;
    tvRoomReservationsGroupAccount: TcxGridDBColumn;
    tvRoomReservationsinvBreakfast: TcxGridDBColumn;
    tvRoomReservationsCurrency: TcxGridDBColumn;
    tvRoomReservationsDiscount: TcxGridDBColumn;
    tvRoomReservationsPercentage: TcxGridDBColumn;
    tvRoomReservationsPriceType: TcxGridDBColumn;
    tvRoomReservationsRoomType: TcxGridDBColumn;
    tvRoomReservationsPMInfo: TcxGridDBColumn;
    tvRoomReservationsHiddenInfo: TcxGridDBColumn;
    tvRoomReservationsRoomRentPaymentInvoice: TcxGridDBColumn;
    tvRoomReservationsID: TcxGridDBColumn;
    tvRoomReservationsrrIsNoRoom: TcxGridDBColumn;
    tvRoomReservationsuseStayTax: TcxGridDBColumn;
    tvRoomReservationsuseinNationalReport: TcxGridDBColumn;
    tvRoomReservationsnumGuests: TcxGridDBColumn;
    tvRoomReservationsnumChildren: TcxGridDBColumn;
    tvRoomReservationsnumInfants: TcxGridDBColumn;
    tvRoomReservationsAvrageRate: TcxGridDBColumn;
    tvRoomReservationsRateCount: TcxGridDBColumn;
    tvRoomReservationsdtCreated: TcxGridDBColumn;
    kbmRoomsDate_: TkbmMemTable;
    kbmRoomsDateDS: TDataSource;
    lvRoomsDate: TcxGridLevel;
    tvRoomsDate: TcxGridDBTableView;
    tvRoomsDateRoomreservation: TcxGridDBColumn;
    tvRoomsDatereservation: TcxGridDBColumn;
    tvRoomsDateroomDate: TcxGridDBColumn;
    tvRoomsDateResFlag: TcxGridDBColumn;
    tvRoomsDateisNoRoom: TcxGridDBColumn;
    tvRoomsDatePriceCode: TcxGridDBColumn;
    tvRoomsDateRoomRate: TcxGridDBColumn;
    tvRoomsDateCurrency: TcxGridDBColumn;
    tvRoomsDateDiscount: TcxGridDBColumn;
    tvRoomsDateisPercentage: TcxGridDBColumn;
    tvRoomsDateshowDiscount: TcxGridDBColumn;
    tvRoomsDatePaid: TcxGridDBColumn;
    FormStore: TcxPropertiesStore;
    grReservationsDBBandedTableView1: TcxGridDBBandedTableView;
    cLabFilter: TsLabel;
    edFilter: TsEdit;
    btnClear: TsSpeedButton;
    PopupMenu1: TPopupMenu;
    cxGridPopupMenu1: TcxGridPopupMenu;
    rgrDateRangeFor: TsRadioGroup;
    tvRoomsDateGuestName: TcxGridDBColumn;
    tvRoomReservationsGuestName: TcxGridDBColumn;
    tvReservationsGuestName: TcxGridDBColumn;
    tvReservationsuseStayTax: TcxGridDBColumn;
    tabRoom: TsTabSheet;
    grRooms: TcxGrid;
    cxGridDBTableView2: TcxGridDBTableView;
    cxGridDBColumn35: TcxGridDBColumn;
    cxGridDBColumn36: TcxGridDBColumn;
    cxGridDBColumn37: TcxGridDBColumn;
    cxGridDBColumn38: TcxGridDBColumn;
    cxGridDBColumn39: TcxGridDBColumn;
    cxGridDBColumn40: TcxGridDBColumn;
    cxGridDBColumn41: TcxGridDBColumn;
    cxGridDBColumn42: TcxGridDBColumn;
    cxGridDBColumn43: TcxGridDBColumn;
    cxGridDBColumn44: TcxGridDBColumn;
    cxGridDBColumn45: TcxGridDBColumn;
    cxGridDBColumn46: TcxGridDBColumn;
    cxGridDBColumn47: TcxGridDBColumn;
    cxGridDBColumn48: TcxGridDBColumn;
    cxGridDBColumn49: TcxGridDBColumn;
    cxGridDBColumn50: TcxGridDBColumn;
    cxGridDBColumn51: TcxGridDBColumn;
    cxGridDBColumn52: TcxGridDBColumn;
    cxGridDBColumn53: TcxGridDBColumn;
    cxGridDBColumn54: TcxGridDBColumn;
    cxGridDBColumn55: TcxGridDBColumn;
    cxGridDBColumn56: TcxGridDBColumn;
    cxGridDBColumn57: TcxGridDBColumn;
    cxGridDBColumn58: TcxGridDBColumn;
    cxGridDBColumn59: TcxGridDBColumn;
    cxGridDBColumn60: TcxGridDBColumn;
    cxGridDBColumn61: TcxGridDBColumn;
    cxGridDBColumn62: TcxGridDBColumn;
    cxGridDBTableView3: TcxGridDBTableView;
    cxGridDBColumn63: TcxGridDBColumn;
    cxGridDBColumn64: TcxGridDBColumn;
    cxGridDBColumn65: TcxGridDBColumn;
    cxGridDBColumn66: TcxGridDBColumn;
    cxGridDBColumn67: TcxGridDBColumn;
    cxGridDBColumn68: TcxGridDBColumn;
    cxGridDBColumn69: TcxGridDBColumn;
    cxGridDBColumn70: TcxGridDBColumn;
    cxGridDBColumn71: TcxGridDBColumn;
    cxGridDBColumn72: TcxGridDBColumn;
    cxGridDBColumn73: TcxGridDBColumn;
    cxGridDBColumn74: TcxGridDBColumn;
    cxGridDBColumn75: TcxGridDBColumn;
    cxGridDBBandedTableView1: TcxGridDBBandedTableView;
    lvRooms: TcxGridLevel;
    tvRooms: TcxGridDBTableView;
    sPanel1: TsPanel;
    sButton2: TsButton;
    brnRoomsTabReservation: TsButton;
    sButton4: TsButton;
    sButton5: TsButton;
    btnRoomsTabRoom: TsButton;
    kbmRooms: TkbmMemTable;
    RoomsDS: TDataSource;
    tvRoomsRoomreservation: TcxGridDBColumn;
    tvRoomsreservation: TcxGridDBColumn;
    tvRoomsroom: TcxGridDBColumn;
    tvRoomsrrArrival: TcxGridDBColumn;
    tvRoomsrrDeparture: TcxGridDBColumn;
    tvRoomsGuestName: TcxGridDBColumn;
    tvRoomsGuestCount: TcxGridDBColumn;
    tvRoomsStatus: TcxGridDBColumn;
    tvRoomsGroupAccount: TcxGridDBColumn;
    tvRoomsinvBreakfast: TcxGridDBColumn;
    tvRoomsCurrency: TcxGridDBColumn;
    tvRoomsDiscount: TcxGridDBColumn;
    tvRoomsPercentage: TcxGridDBColumn;
    tvRoomsPriceType: TcxGridDBColumn;
    tvRoomsRoomType: TcxGridDBColumn;
    tvRoomsPMInfo: TcxGridDBColumn;
    tvRoomsHiddenInfo: TcxGridDBColumn;
    tvRoomsRoomRentPaymentInvoice: TcxGridDBColumn;
    tvRoomsID: TcxGridDBColumn;
    tvRoomsrrIsNoRoom: TcxGridDBColumn;
    tvRoomsuseStayTax: TcxGridDBColumn;
    tvRoomsuseinNationalReport: TcxGridDBColumn;
    tvRoomsnumGuests: TcxGridDBColumn;
    tvRoomsnumChildren: TcxGridDBColumn;
    tvRoomsnumInfants: TcxGridDBColumn;
    tvRoomsRateCount: TcxGridDBColumn;
    tvRoomsdtCreated: TcxGridDBColumn;
    tvRoomsReservationName: TcxGridDBColumn;
    tvRoomsCustomerName: TcxGridDBColumn;
    tvRoomsChannelName: TcxGridDBColumn;
    tvRoomsRoomClass: TcxGridDBColumn;
    tvRoomsCustomer: TcxGridDBColumn;
    tvRoomsCountry: TcxGridDBColumn;
    tvRoomsContactName: TcxGridDBColumn;
    tvRoomsContactEmail: TcxGridDBColumn;
    tvRoomsCustPID: TcxGridDBColumn;
    tvRoomsinvRefrence: TcxGridDBColumn;
    tvRoomsmarketSegment: TcxGridDBColumn;
    tvRoomsCustomerEmail: TcxGridDBColumn;
    btnJumpToRoom: TsButton;
    pnlHolder: TsPanel;
    btnClose: TsButton;
    procedure cbxMonthPropertiesCloseUp(Sender : TObject);
    procedure btnRefreshClick(Sender : TObject);
    procedure dtDateFromChange(Sender : TObject);
    procedure FormCreate(Sender : TObject);
    procedure FormClose(Sender : TObject; var Action : TCloseAction);
    procedure btnGuestsExcelClick(Sender: TObject);
    procedure brnGuestsReservationClick(Sender: TObject);
    procedure btnExpandAllClick(Sender: TObject);
    procedure btnCollapseAllClick(Sender: TObject);
    procedure btnGuestsRoomClick(Sender: TObject);
    procedure btnJumpToRoomClick(Sender: TObject);
    procedure edFilterChange(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure sButton8Click(Sender: TObject);
    procedure pageMainPageChanging(Sender: TObject; NewPage: TsTabSheet; var AllowChange: Boolean);
    procedure sButton2Click(Sender: TObject);
    procedure brnRoomsTabReservationClick(Sender: TObject);
    procedure btnRoomsTabRoomClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    zDateFrom : Tdate;
    zDateTo   : Tdate;
    zYear     : integer;
    zMonth    : integer;
    zSetDates : boolean;

    lstReservations : TstringList;
    lstRoomReservations : TstringList;

    zRoomReservationsList : string;
    isFirstTime : boolean;

    zReservationCount : integer;
    zRoomReservationCount : integer;

    zGuestCount : integer;
    zNightCount : integer;
    zRoomCount  : integer;
    zBedCount   : integer;
    zDayCount   : integer;


    function GetRVinList : string;
    procedure ShowData;
    procedure GetData;
    procedure rrGetData;
    procedure ApplyFilter;

  public
    { Public declarations }
    zRoom    : string;
    zArrival : Tdate;

    embedded : Boolean;
    EmbedWindowCloseEvent : TNotifyEvent;

    procedure PrepareUserInterface;
    procedure BringWindowToFront;
  end;

var
  frmRptReservations : TfrmRptReservations;
  frmRptReservationsX: TfrmRptReservations;

procedure OpenReportReservations(embedPanel : TsPanel = nil; WindowCloseEvent : TNotifyEvent = nil);

implementation

uses
    uD
  , uReservationProfile
  , uFinishedInvoices2
  , uInvoice
  , uRptbViewer
  , uStringUtils
  , uAppGlobal
  , uCountries
  , uSqlDefinitions
  , uGuestProfile2
  , PrjConst
  ;
{$R *.dfm}


procedure OpenReportReservations(embedPanel : TsPanel = nil; WindowCloseEvent : TNotifyEvent = nil);
var
  sRoom: string;
  aDate: Tdate;
  _frmRptReservations : TfrmRptReservations;
begin
  // **
  _frmRptReservations := TfrmRptReservations.Create(nil);
  try
    _frmRptReservations.embedded := (embedPanel <> nil);
    _frmRptReservations.EmbedWindowCloseEvent := WindowCloseEvent;
    _frmRptReservations.PrepareUserInterface;
    if _frmRptReservations.embedded then
    begin
      _frmRptReservations.pnlHolder.parent := embedPanel;
      embedPanel.Update;
      frmRptReservationsX := _frmRptReservations;
    end
    else
      _frmRptReservations.ShowModal;
  finally
    if (embedPanel = nil) then
      FreeAndNil(_frmRptReservations);
  end;
end;

procedure TfrmRptReservations.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmRptReservations.btnCloseClick(Sender: TObject);
begin
  if embedded then
    Close;
end;

procedure TfrmRptReservations.btnCollapseAllClick(Sender: TObject);
begin
//  tvRoomReservations.ViewData.Collapse(True);
  tvReservations.ViewData.Collapse(True);
end;

procedure TfrmRptReservations.btnExpandAllClick(Sender: TObject);
begin
  tvReservations.ViewData.Expand(True);
//  tvRoomReservations.ViewData.Expand(True);
end;

procedure TfrmRptReservations.btnRefreshClick(Sender : TObject);
begin
  if pageMain.ActivePage = tabRoom then
  begin
    rrGetData;
  end else
  begin
    getData
  end;
end;


procedure TfrmRptReservations.cbxMonthPropertiesCloseUp(Sender : TObject);
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


procedure TfrmRptReservations.btnGuestsExcelClick(Sender: TObject);
var
  sFilename : string;
  s : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_ResList';
  ExportGridToExcel(sFilename, grReservations, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmRptReservations.btnGuestsRoomClick(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
  theData : recPersonHolder;
begin
  iReservation := kbmReservations_.FieldByName('Reservation').AsInteger;
  KbmroomReservations_.Locate('reservation',iReservation,[]);
  iRoomReservation := KbmroomReservations_.fieldbyname('RoomReservation').AsInteger;

  initPersonHolder(theData);
  theData.RoomReservation := iRoomreservation;
  theData.Reservation := iReservation;
  theData.name := '';

  if openGuestProfile(actNone,theData) then
  begin
    //**
  end;
end;

procedure TfrmRptReservations.BringWindowToFront;
begin
  pnlHolder.Parent.BringToFront;
end;

procedure TfrmRptReservations.brnGuestsReservationClick(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
begin
  iReservation := kbmReservations_.FieldByName('Reservation').AsInteger;
  iRoomReservation := 0;

  if EditReservation(iReservation, iRoomReservation) then
  begin

  end;
end;

procedure TfrmRptReservations.dtDateFromChange(Sender : TObject);
begin
  if zSetDates then
  begin
    zDateFrom := dtDateFrom.Date;
    zDateTo := dtDateTo.Date;

    cbxYear.ItemIndex := 0;
    cbxMonth.ItemIndex := 0;
  end;
end;

procedure TfrmRptReservations.ApplyFilter;
begin
  if pagemain.ActivePage = tabReservation then
  begin
    tvReservations.DataController.Filter.Options := [fcoCaseInsensitive];
    tvReservations.DataController.Filter.Root.BoolOperatorKind := fboOr;
    tvReservations.DataController.Filter.Root.Clear;
    tvReservations.DataController.Filter.Root.AddItem(tvReservationsGuestName,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
    tvReservations.DataController.Filter.Root.AddItem(tvReservationsChannelName,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
    tvReservations.DataController.Filter.Root.AddItem(tvReservationsinvRefrence,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
    tvReservations.DataController.Filter.Root.AddItem(tvReservationsarrivaltime,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
    tvReservations.DataController.Filter.Root.AddItem(tvReservationsCustomerName,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
    tvReservations.DataController.Filter.Root.AddItem(tvReservationsContactName,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
    tvReservations.DataController.Filter.Root.AddItem(tvReservationsContactEmail,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
    tvReservations.DataController.Filter.Root.AddItem(tvReservationsInformation,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
    tvReservations.DataController.Filter.Root.AddItem(tvReservationsReservationName,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');

    tvReservations.DataController.Filter.Active := True;
  end else
  begin
    tvRooms.DataController.Filter.Options := [fcoCaseInsensitive];
    tvRooms.DataController.Filter.Root.BoolOperatorKind := fboOr;
    tvRooms.DataController.Filter.Root.Clear;
    tvRooms.DataController.Filter.Root.AddItem(tvRoomsGuestName,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
    tvRooms.DataController.Filter.Root.AddItem(tvRoomsChannelName,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
    tvRooms.DataController.Filter.Root.AddItem(tvRoomsinvRefrence,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
    tvRooms.DataController.Filter.Root.AddItem(tvRoomsCustomerName,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
    tvRooms.DataController.Filter.Root.AddItem(tvRoomsContactName,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
    tvRooms.DataController.Filter.Root.AddItem(tvRoomsContactEmail,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
    tvRooms.DataController.Filter.Root.AddItem(tvRoomsReservationName,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');

    tvRooms.DataController.Filter.Active := True;
  end;
end;



procedure TfrmRptReservations.edFilterChange(Sender: TObject);
begin
  if pagemain.ActivePage = tabReservation then
  begin
    if edFilter.Text = '' then
    begin
      tvReservations.DataController.Filter.Root.Clear;
      tvReservations.DataController.Filter.Active := false;
    end else
    begin
      applyFilter;
    end;
  end else
  begin
    if edFilter.Text = '' then
    begin
      tvRooms.DataController.Filter.Root.Clear;
      tvRooms.DataController.Filter.Active := false;
    end else
    begin
      applyFilter;
    end;
  end;
end;

procedure TfrmRptReservations.FormClose(Sender : TObject; var Action : TCloseAction);
begin
  freeandNil(lstReservations);
  freeandNil(lstRoomReservations);

  pnlHolder.Parent := self;
  update;
  if embedded then
    Action := caFree;
  if Assigned(EmbedWindowCloseEvent) then
    EmbedWindowCloseEvent(self);
end;

procedure TfrmRptReservations.FormCreate(Sender : TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  glb.fillListWithMonthsLong(cbxMonth.Items, 1);
  glb.fillListWithYears(cbxYear.Items, 1, False);

  PageMain.ActivePageIndex := 0;
  lstReservations := TstringList.Create;
  lstRoomReservations := TstringList.Create;

  lstReservations.Sorted := true;
  lstReservations.Duplicates := dupIgnore;
  lstRoomReservations.Sorted := true;
  lstRoomReservations.Duplicates := dupIgnore;

  zReservationCount := 0;
  zRoomReservationCount := 0;
  zGuestCount := 0;
  zNightCount := 0;

  zRoomCount  := 0;
  zBedCount   := 0;
  zDayCount   := 0;

  isFirstTime := true;
end;



procedure TfrmRptReservations.FormShow(Sender: TObject);
begin
  PrepareUserInterface;
end;


procedure TfrmRptReservations.ShowData;
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
  lastDay := _DaysPerMonth(y, m);
  zDateTo := encodeDate(y, m, lastDay);
  dtDateFrom.Date := zDateFrom;
  dtDateTo.Date := zDateTo;
  zSetDates := true;

//  btnHagstofaReport.Enabled := true;

  //**
  zRoomReservationsList := '';
  isFirstTime := false;
end;


function TfrmRptReservations.GetRVinList : string;
var
  s      : string;
  rvList : TstringList;
  i      : integer;
  dateTo : Tdate;
begin
  result := '';
  dateTo := zdateTo; // +1;

  case rgrDateRangeFor.itemindex of
    0 : begin
      rvList := d.Rvlst_CreatedFromTo(zDateFrom, dateTo);
    end;
    1 : begin
      rvList := d.Rvlst_Arrival(zDateFrom, dateTo)
    end;
    2 : begin
        rvList := d.Rvlst_FromTo(zDateFrom, dateTo);
    end;
  end;

//  rvList := d.Rvlst_CreatedFromTo(zDateFrom, zDateTo);
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

  if result = '' then
    result := '(-1)';
end;


procedure TfrmRptReservations.pageMainPageChanging(Sender: TObject; NewPage: TsTabSheet; var AllowChange: Boolean);
begin
  edFilter.Text := '';

  if newPage = tabRoom then
  begin
    rrGetData;
  end else
  begin
    getData
  end;
end;

procedure TfrmRptReservations.PrepareUserInterface;
begin
  btnJumpToRoom.Visible := NOT embedded;
  brnGuestsReservation.Visible := NOT embedded;
  btnGuestsRoom.Visible := NOT embedded;
  brnRoomsTabReservation.Visible := NOT embedded;
  btnRoomsTabRoom.Visible := NOT embedded;
  btnClose.Visible := embedded;
  ShowData;
  getData;
end;

procedure TfrmRptReservations.btnJumpToRoomClick(Sender: TObject);
var
  iRoomReservation : integer;
  iReservation : integer;
begin
  if pageMain.activepage = tabreservation then
  begin
    iReservation  := kbmreservations_.fieldbyname('Reservation').AsInteger;
    iRoomReservation := 0;
    if not kbmRoomreservations_.Locate('Reservation',ireservation,[]) then
    begin
      showmessage('No room found');
  //    showmessage(GetTranslatedText('shTx_InvoiceList2_NotRoomInvoice'));
      btnJumpToRoom.ModalResult := mrNone;
      exit;
    end;
    zRoom := kbmRoomreservations_.fieldbyname('room').Asstring;
    zArrival := kbmRoomreservations_.fieldbyname('rrArrival').AsDateTime;

  end else
  begin
    iReservation     := kbmRooms.fieldbyname('Reservation').AsInteger;
    iRoomReservation := kbmRooms.fieldbyname('RoomReservation').AsInteger;
    zRoom := kbmRooms.fieldbyname('room').Asstring;
    zArrival := kbmRooms.fieldbyname('rrArrival').AsDateTime;

  end;

end;


procedure TfrmRptReservations.sButton2Click(Sender: TObject);
var
  sFilename : string;
  s : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_ResListRooms';
  ExportGridToExcel(sFilename, grRooms, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmRptReservations.brnRoomsTabReservationClick(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
begin
  iReservation := kbmRooms.FieldByName('Reservation').AsInteger;
  iRoomReservation := 0;
  if EditReservation(iReservation, iRoomReservation) then
  begin

  end;
end;

procedure TfrmRptReservations.btnRoomsTabRoomClick(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
  theData : recPersonHolder;
begin
  iReservation := kbmRooms.FieldByName('Reservation').AsInteger;
  iRoomReservation := kbmRooms.fieldbyname('RoomReservation').AsInteger;

  initPersonHolder(theData);
  theData.RoomReservation := iRoomreservation;
  theData.Reservation := iReservation;
  theData.name := '';

  if openGuestProfile(actNone,theData) then
  begin
    //**
  end;
end;

procedure TfrmRptReservations.rrGetData;
var
  s    : string;
  rset1,
  rset2,
  rset3 : TRoomerDataset;
  ExecutionPlan : TRoomerExecutionPlan;

  dtTmp : TdateTime;

  rvList : string;

begin


  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  try
    rvList := GetRVinList;

    s := '';
    s := s+'SELECT '#10;
    s := s+'  rr.Roomreservation '#10;
    s := s+' ,rr.Reservation '#10;
    s := s+' ,rv.Name AS ReservationName '#10;
    s := s+' ,cust.surName AS CustomerName '#10;
    s := s+' ,chnl.Name AS ChannelName '#10;
    s := s+' ,rr.RoomClass '#10;
    s := s+' ,rr.Room '#10;
    s := s+' ,rr.rrDeparture '#10;
    s := s+' ,rr.rrArrival '#10;
    s := s+' , (SELECT name FROM persons WHERE RoomReservation=rr.RoomReservation AND MainName LIMIT 1) AS GuestName '#10;
    s := s+' , (SELECT count(ID) FROM persons WHERE persons.roomreservation=rr.roomreservation) AS GuestCount '#10;
    s := s+' ,rr.Status '#10;
    s := s+' ,rr.GroupAccount '#10;
    s := s+' ,rr.invBreakfast '#10;
    s := s+' ,rr.Currency '#10;
    s := s+' ,rr.Discount '#10;
    s := s+' ,rr.Percentage '#10;
    s := s+' ,rr.PriceType '#10;
    s := s+' ,rr.RoomType '#10;
    s := s+' ,rr.PMInfo '#10;
    s := s+' ,rr.HiddenInfo '#10;
    s := s+' ,rr.RoomRentPaymentInvoice '#10;
    s := s+' ,rr.ID '#10;
    s := s+' ,rr.rrIsNoRoom '#10;
    s := s+' ,rr.useStayTax '#10;
    s := s+' ,rr.useinNationalReport '#10;
    s := s+' ,rr.numGuests '#10;
    s := s+' ,rr.numChildren '#10;
    s := s+' ,rr.numInfants '#10;
//  s := s+' ,rr.AvrageRate '#10;
    s := s+' ,rr.RateCount '#10;
    s := s+' ,rr.dtCreated '#10;
    s := s+' , rv.Customer '#10;
    s := s+' , rv.Country '#10;
    s := s+' , rv.ContactName '#10;
    s := s+' , rv.ContactEmail '#10;
    s := s+' , rv.CustPID '#10;
    s := s+' , rv.invRefrence '#10;
    s := s+' , rv.marketSegment '#10;
    s := s+' , rv.CustomerEmail '#10;
    s := s+' FROM '#10;
    s := s+'    reservations rv '#10;
    s := s+'    INNER JOIN roomreservations rr ON rr.reservation = rv.reservation '#10;
    s := s+'    LEFT OUTER JOIN '#10;
    s := s+'       customers cust ON rv.customer = cust.Customer '#10;
    s := s+'    LEFT OUTER JOIN '#10;
    s := s+'       channels chnl ON rv.channel = chnl.id '#10;
    s := s+' WHERE '#10;
    s := s+'  rv.reservation in '+Rvlist+' '#10;
    s := s+' ORDER BY '#10;
    s := s+'   rr.reservation '#10;

//    copyToClipboard(s);
//    DebugMessage(s);

    ExecutionPlan.AddQuery(s);

    screen.Cursor := crHourGlass;
    kbmRooms.DisableControls;
    try

      ExecutionPlan.Execute(ptQuery);

      //////////////////// RoomsDate

      rSet1 := ExecutionPlan.Results[0];

      if rSet1.RecordCount > 0  then
      begin
        if kbmRooms.Active then kbmRooms.Close;
        kbmRooms.open;
        LoadKbmMemtableFromDataSetQuiet(kbmRooms,rSet1,[]);
        kbmRooms.First;


        if (rgrDateRangeFor.itemindex = 1) or (rgrDateRangeFor.itemindex = 2) then
        begin
          kbmRooms.SortFields := 'reservation;rrArrival;room';
          kbmRooms.SortOptions :=  [mtcoDescending];
          kbmRooms.Sort([]);
          kbmRooms.first;
        end;
      end;

    finally
      screen.cursor := crDefault;
      kbmRooms.EnableControls;
    end;
  finally
    ExecutionPlan.Free;
  end;

//  debugmessage('');

  //tvReservations.ApplyBestFit;
end;


procedure TfrmRptReservations.GetData;
var
  s    : string;
  rset1,
  rset2,
  rset3 : TRoomerDataset;
  ExecutionPlan : TRoomerExecutionPlan;

  startTick : integer;
  stopTick  : integer;
  SQLms     : integer;

  dtTmp : TdateTime;

  rvList : string;

begin
  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  try
    startTick := GetTickCount;
    stopTick  := GetTickCount;
    SQLms     := stopTick - startTick;
//    sLabTime.Caption := inttostr(SQLms);

    rvList := GetRVinList;


    startTick := GetTickCount;
    s := '';
    s := s+' SELECT '#10;
    s := s+'     rv.Reservation '#10;
    s := s+'   , rv.ReservationDate '#10;
    s := s+'   , date(rv.Arrival) AS dtArrival '#10;
    s := s+'   , date(rv.Departure) AS dtDeparture '#10;
    s := s+'   , (SELECT name FROM persons WHERE reservation=rv.Reservation AND MainName LIMIT 1) AS GuestName '#10;
    s := s+'   , rv.Customer '#10;
    s := s+'   , rv.`Name`  As ReservationName '#10;
    s := s+'   , rv.Address1 '#10;
    s := s+'   , rv.Address2 '#10;
    s := s+'   , rv.Address3 '#10;
    s := s+'   , rv.Address4 '#10;
    s := s+'   , rv.Country '#10;
    s := s+'   , rv.Tel1 '#10;
    s := s+'   , rv.Tel2 '#10;
    s := s+'   , rv.Fax '#10;
    s := s+'   , rv.`Status` AS ReservationStatus'#10;
    s := s+'   , rv.Staff '#10;
    s := s+'   , rv.Information '#10;
    s := s+'   , rv.PMInfo '#10;
    s := s+'   , rv.HiddenInfo '#10;
    s := s+'   , rv.RoomRentPaid1 '#10;
    s := s+'   , rv.RoomRentPaid2 '#10;
    s := s+'   , rv.RoomRentPaid3 '#10;
    s := s+'   , rv.RoomRentPaymentInvoice '#10;
    s := s+'   , rv.ContactName '#10;
    s := s+'   , rv.ContactPhone '#10;
    s := s+'   , rv.ContactFax '#10;
    s := s+'   , rv.ContactEmail '#10;
    s := s+'   , rv.inputsource '#10;
    s := s+'   , rv.webconfirmed '#10;
    s := s+'   , rv.arrivaltime '#10;
    s := s+'   , rv.srcrequest '#10;
    s := s+'   , rv.rvTmp '#10;
    s := s+'   , rv.ID '#10;
    s := s+'   , rv.CustPID '#10;
    s := s+'   , rv.invRefrence '#10;
    s := s+'   , rv.marketSegment '#10;
    s := s+'   , rv.CustomerEmail '#10;
    s := s+'   , rv.CustomerWebsite '#10;
    s := s+'   , rv.useStayTax '#10;
    s := s+'   , rv.channel '#10;
    s := s+'   , rv.eventsProcessed '#10;
    s := s+'   , rv.alteredReservation '#10;
    s := s+'   , rv.externalIds '#10;
    s := s+'   , rv.dtCreated '#10;
    s := s+'   , cust.surName AS CustomerName'#10;
    s := s+'   , chnl.Name AS ChannelName'#10;
    s := s+'   , (SELECT count(ID) FROM persons WHERE persons.reservation=rv.reservation) AS GuestCount '#10;
    s := s+'   , (SELECT count(ID) FROM roomreservations WHERE roomreservations.reservation=rv.reservation) AS RoomCount '#10;
    s := s+' FROM '#10;
    s := s+'   reservations rv '#10;
    s := s+' LEFT OUTER JOIN '#10;
    s := s+'   customers cust ON rv.customer = cust.Customer '#10;
    s := s+' LEFT OUTER JOIN '#10;
    s := s+'   channels chnl ON rv.channel = chnl.id '#10;
    s := s+' WHERE '#10;
    s := s+'  rv.reservation in '+Rvlist+' '#10;
//    s := s + '        (dtCreated >= '+_DB(dtDateFrom.date)+')'+#10;
//    s := s + '    AND (dtCreated <= '+_DB(dtDateTo.date)+')'+#10;
    s := s+' ORDER BY '#10;
    s := s+'   rv.dtCreated DESC'#10;


//    copyToClipboard(s);
//    DebugMessage('');

    ExecutionPlan.AddQuery(s);

    s := '';
    s := s+'SELECT '#10;
    s := s+'  rr.Roomreservation '#10;
    s := s+' ,rr.Reservation '#10;
    s := s+' ,rr.Room '#10;
    s := s+' ,rr.rrDeparture '#10;
    s := s+' ,rr.rrArrival '#10;
    s := s+' , (SELECT name FROM persons WHERE RoomReservation=rr.RoomReservation AND MainName LIMIT 1) AS GuestName '#10;
    s := s+' , (SELECT count(ID) FROM persons WHERE persons.roomreservation=rr.roomreservation) AS GuestCount '#10;
    s := s+' ,rr.Status '#10;
    s := s+' ,rr.GroupAccount '#10;
    s := s+' ,rr.invBreakfast '#10;
    s := s+' ,rr.Currency '#10;
    s := s+' ,rr.Discount '#10;
    s := s+' ,rr.Percentage '#10;
    s := s+' ,rr.PriceType '#10;
    s := s+' ,rr.RoomType '#10;
    s := s+' ,rr.PMInfo '#10;
    s := s+' ,rr.HiddenInfo '#10;
    s := s+' ,rr.RoomRentPaymentInvoice '#10;
    s := s+' ,rr.ID '#10;
    s := s+' ,rr.rrIsNoRoom '#10;
    s := s+' ,rr.useStayTax '#10;
    s := s+' ,rr.useinNationalReport '#10;
    s := s+' ,rr.numGuests '#10;
    s := s+' ,rr.numChildren '#10;
    s := s+' ,rr.numInfants '#10;
//    s := s+' ,rr.AvrageRate '#10;
    s := s+' ,rr.RateCount '#10;
    s := s+' ,rr.dtCreated '#10;
    s := s+' FROM '#10;
    s := s+'   roomreservations rr '#10;
    s := s+' WHERE '#10;
    s := s+'  rr.reservation in '+Rvlist+' '#10;
    s := s+' ORDER BY '#10;
    s := s+'   rr.reservation '#10;

//    copyToClipboard(s);
//    DebugMessage('');

    ExecutionPlan.AddQuery(s);


    s := '';
    s := s+' SELECT '#10;
    s := s+'   date(rd.ADate) AS roomDate '#10;
    s := s+'  ,rd.Reservation '#10;
    s := s+'  ,rd.RoomReservation '#10;
    s := s+'  , (SELECT name FROM persons WHERE RoomReservation=rd.RoomReservation AND MainName LIMIT 1) AS GuestName '#10;
    s := s+'  ,rd.ResFlag '#10;
    s := s+'  ,rd.isNoRoom '#10;
    s := s+'  ,rd.PriceCode '#10;
    s := s+'  ,rd.RoomRate '#10;
    s := s+'  ,rd.Currency '#10;
    s := s+'  ,rd.Discount '#10;
    s := s+'  ,rd.isPercentage '#10;
    s := s+'  ,rd.showDiscount '#10;
    s := s+'  ,rd.Paid '#10;
    s := s+' FROM '#10;
    s := s+'   roomsdate rd '#10;
    s := s+' WHERE '#10;
    s := s+'  rd.reservation in '+Rvlist+' '#10;
    s := s+' ORDER BY '#10;
    s := s+'   rd.reservation '#10;

//    copyToClipboard(s);
//    DebugMessage('');


    ExecutionPlan.AddQuery(s);



    screen.Cursor := crHourGlass;
    kbmReservations_.DisableControls;
    kbmRoomReservations_.DisableControls;
    kbmRoomsDate_.DisableControls;
    try

      ExecutionPlan.Execute(ptQuery);

      //////////////////// RoomsDate

      rSet1 := ExecutionPlan.Results[0];
      rSet2 := ExecutionPlan.Results[1];
      rSet3 := ExecutionPlan.Results[2];

      if rSet1.RecordCount > 0 then
      begin
        if kbmReservations_.Active then kbmReservations_.Close;
        kbmReservations_.open;
        LoadKbmMemtableFromDataSetQuiet(kbmReservations_,rSet1,[]);
        kbmReservations_.First;

        if kbmRoomReservations_.Active then kbmRoomReservations_.Close;
        kbmRoomReservations_.open;
        LoadKbmMemtableFromDataSetQuiet(kbmRoomReservations_,rSet2,[]);
        kbmRoomReservations_.First;


        if kbmRoomsDate_.Active then kbmRoomsDate_.Close;
        kbmRoomsDate_.open;
        LoadKbmMemtableFromDataSetQuiet(kbmRoomsDate_,rSet3,[]);
        kbmRoomsDate_.First;

        if (rgrDateRangeFor.itemindex = 1) or (rgrDateRangeFor.itemindex = 2) then
        begin
          kbmReservations_.SortFields := 'dtArrival';
          kbmReservations_.Sort([]);
          kbmReservations_.first;
        end;
      end;
    finally
      screen.cursor := crDefault;
      kbmReservations_.EnableControls;
      kbmRoomReservations_.EnableControls;
      kbmRoomsDate_.EnableControls;
    end;

    stopTick         := GetTickCount;
    SQLms            := stopTick - startTick;
//    sLabTime.Caption := inttostr(SQLms);

  finally
    ExecutionPlan.Free;
  end;
  tvReservations.ApplyBestFit;
end;

procedure TfrmRptReservations.sButton8Click(Sender: TObject);
begin
  //**
  rrGetData;
end;




end.


USE home100_thal

ALTER TABLE `reservations` ADD COLUMN `dtCreated` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP  AFTER `externalIds` ;

UPDATE reservations
SET `dtCreated`='SELECT reservationdate FROM reservation '+'00:00:00' WHERE ID>0;


