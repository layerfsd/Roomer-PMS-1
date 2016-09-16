unit urptReservationsCust;

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

  ,cmpRoomerDataSet
  ,cmpRoomerConnection

  ,uUtils
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
  TfrmRptReservationsCust = class(TForm)
    pageMain: TsPageControl;
    dxStatusBar1 : TdxStatusBar;
    Panel3: TsPanel;
    cxGroupBox2: TsGroupBox;
    cbxMonth: TsComboBox;
    cbxYear: TsComboBox;
    btnRefresh: TsButton;
    gbxSelectDates: TsGroupBox;
    dtDateFrom: TsDateEdit;
    dtDateTo: TsDateEdit;
    FormStore: TcxPropertiesStore;
    cLabFilter: TsLabel;
    edFilter: TsEdit;
    btnClear: TsSpeedButton;
    PopupMenu1: TPopupMenu;
    cxGridPopupMenu1: TcxGridPopupMenu;
    rgrDateRangeFor: TsRadioGroup;
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
    sPanel1: TsPanel;
    sButton2: TsButton;
    brnRoomsTabReservation: TsButton;
    btnRoomsTabRoom: TsButton;
    kbmRooms: TkbmMemTable;
    RoomsDS: TDataSource;
    btnJumpToRoom: TsButton;
    pnlHolder: TsPanel;
    sGroupBox1: TsGroupBox;
    edCustomer: TsEdit;
    btnGetCustomer: TsSpeedButton;
    labCustomerName: TsLabel;
    tvRooms: TcxGridDBBandedTableView;
    tvRoomsRoomreservation: TcxGridDBBandedColumn;
    tvRoomsreservation: TcxGridDBBandedColumn;
    tvRoomsroom: TcxGridDBBandedColumn;
    tvRoomsrrArrival: TcxGridDBBandedColumn;
    tvRoomsrrDeparture: TcxGridDBBandedColumn;
    tvRoomsGuestName: TcxGridDBBandedColumn;
    tvRoomsGuestCount: TcxGridDBBandedColumn;
    tvRoomsStatus: TcxGridDBBandedColumn;
    tvRoomsGroupAccount: TcxGridDBBandedColumn;
    tvRoomsinvBreakfast: TcxGridDBBandedColumn;
    tvRoomsCurrency: TcxGridDBBandedColumn;
    tvRoomsDiscount: TcxGridDBBandedColumn;
    tvRoomsPercentage: TcxGridDBBandedColumn;
    tvRoomsPriceType: TcxGridDBBandedColumn;
    tvRoomsRoomType: TcxGridDBBandedColumn;
    tvRoomsPMInfo: TcxGridDBBandedColumn;
    tvRoomsHiddenInfo: TcxGridDBBandedColumn;
    tvRoomsRoomRentPaymentInvoice: TcxGridDBBandedColumn;
    tvRoomsID: TcxGridDBBandedColumn;
    tvRoomsrrIsNoRoom: TcxGridDBBandedColumn;
    tvRoomsuseStayTax: TcxGridDBBandedColumn;
    tvRoomsuseinNationalReport: TcxGridDBBandedColumn;
    tvRoomsnumGuests: TcxGridDBBandedColumn;
    tvRoomsnumChildren: TcxGridDBBandedColumn;
    tvRoomsnumInfants: TcxGridDBBandedColumn;
    tvRoomsRateCount: TcxGridDBBandedColumn;
    tvRoomsdtCreated: TcxGridDBBandedColumn;
    tvRoomsReservationName: TcxGridDBBandedColumn;
    tvRoomsCustomerName: TcxGridDBBandedColumn;
    tvRoomsChannelName: TcxGridDBBandedColumn;
    tvRoomsRoomClass: TcxGridDBBandedColumn;
    tvRoomsCustomer: TcxGridDBBandedColumn;
    tvRoomsCountry: TcxGridDBBandedColumn;
    tvRoomsContactName: TcxGridDBBandedColumn;
    tvRoomsContactEmail: TcxGridDBBandedColumn;
    tvRoomsCustPID: TcxGridDBBandedColumn;
    tvRoomsinvRefrence: TcxGridDBBandedColumn;
    tvRoomsmarketSegment: TcxGridDBBandedColumn;
    tvRoomsCustomerEmail: TcxGridDBBandedColumn;
    tvRoomsresDescription: TcxGridDBBandedColumn;
    procedure cbxMonthPropertiesCloseUp(Sender : TObject);
    procedure btnRefreshClick(Sender : TObject);
    procedure dtDateFromChange(Sender : TObject);
    procedure FormCreate(Sender : TObject);
    procedure FormClose(Sender : TObject; var Action : TCloseAction);
    procedure btnJumpToRoomClick(Sender: TObject);
    procedure edFilterChange(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure sButton8Click(Sender: TObject);
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
  frmRptReservationsCust : TfrmRptReservationsCust;
  frmRptReservationsX: TfrmRptReservationsCust;

procedure OpenReportReservationsCust(embedPanel : TsPanel = nil; WindowCloseEvent : TNotifyEvent = nil);

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


procedure OpenReportReservationsCust(embedPanel : TsPanel = nil; WindowCloseEvent : TNotifyEvent = nil);
var
  sRoom: string;
  aDate: Tdate;
  _frmRptReservations : TfrmRptReservationsCust;
begin
  // **
  _frmRptReservations := TfrmRptReservationsCust.Create(nil);
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

procedure TfrmRptReservationsCust.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmRptReservationsCust.btnCloseClick(Sender: TObject);
begin
  if embedded then
    Close;
end;

procedure TfrmRptReservationsCust.btnRefreshClick(Sender : TObject);
begin

    rrGetData;

end;


procedure TfrmRptReservationsCust.cbxMonthPropertiesCloseUp(Sender : TObject);
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
  lastDay := DaysInAMonth(y, m);
  zDateTo := encodeDate(y, m, lastDay);
  dtDateFrom.Date := zDateFrom;
  dtDateTo.Date := zDateTo;
  zSetDates := true;
end;


procedure TfrmRptReservationsCust.BringWindowToFront;
begin
  pnlHolder.Parent.BringToFront;
end;

procedure TfrmRptReservationsCust.dtDateFromChange(Sender : TObject);
begin
  if zSetDates then
  begin
    zDateFrom := dtDateFrom.Date;
    zDateTo := dtDateTo.Date;

    cbxYear.ItemIndex := 0;
    cbxMonth.ItemIndex := 0;
  end;
end;

procedure TfrmRptReservationsCust.ApplyFilter;
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



procedure TfrmRptReservationsCust.edFilterChange(Sender: TObject);
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

procedure TfrmRptReservationsCust.FormClose(Sender : TObject; var Action : TCloseAction);
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

procedure TfrmRptReservationsCust.FormCreate(Sender : TObject);
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



procedure TfrmRptReservationsCust.FormShow(Sender: TObject);
begin
  PrepareUserInterface;
end;


procedure TfrmRptReservationsCust.ShowData;
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

//  btnHagstofaReport.Enabled := true;

  //**
  zRoomReservationsList := '';
  isFirstTime := false;
end;


function TfrmRptReservationsCust.GetRVinList : string;
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


procedure TfrmRptReservationsCust.PrepareUserInterface;
begin
  btnJumpToRoom.Visible := NOT embedded;
  brnRoomsTabReservation.Visible := NOT embedded;
  btnRoomsTabRoom.Visible := NOT embedded;
  ShowData;
  rrgetData;
end;

procedure TfrmRptReservationsCust.btnJumpToRoomClick(Sender: TObject);
var
  iRoomReservation : integer;
  iReservation : integer;
begin
    iReservation     := kbmRooms.fieldbyname('Reservation').AsInteger;
    iRoomReservation := kbmRooms.fieldbyname('RoomReservation').AsInteger;
    zRoom := kbmRooms.fieldbyname('room').Asstring;
    zArrival := kbmRooms.fieldbyname('rrArrival').AsDateTime;
end;


procedure TfrmRptReservationsCust.sButton2Click(Sender: TObject);
var
  sFilename : string;
  s : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_ResListRooms';
  ExportGridToExcel(sFilename, grRooms, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmRptReservationsCust.brnRoomsTabReservationClick(Sender: TObject);
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

procedure TfrmRptReservationsCust.btnRoomsTabRoomClick(Sender: TObject);
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

procedure TfrmRptReservationsCust.rrGetData;
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
    s := s+' , concat(rv.reservation,'+_db('- ')+',cust.Customer,'+_db(' ')+',cust.surName) AS resDescription '#10;
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



procedure TfrmRptReservationsCust.sButton8Click(Sender: TObject);
begin
  //**
  rrGetData;
end;




end.


USE home100_thal

ALTER TABLE `reservations` ADD COLUMN `dtCreated` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP  AFTER `externalIds` ;

UPDATE reservations
SET `dtCreated`='SELECT reservationdate FROM reservation '+'00:00:00' WHERE ID>0;


