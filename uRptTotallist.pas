unit uRptTotallist;

interface

uses
    Winapi.Windows
  , Winapi.Messages
  , System.SysUtils
  , System.Variants
  , System.Classes
  , Vcl.Graphics
  , Vcl.Controls
  , Vcl.Forms
  , Vcl.Dialogs
  , Data.DB
  , Vcl.StdCtrls
  , Vcl.Mask
  , shellapi


  , kbmMemTable
  ,cmpRoomerDataSet
  ,cmpRoomerConnection

  , _glob
  , ug
  , hData
  , uUtils
  , uappGlobal


  , sMaskEdit
  , sCustomComboEdit
  , sTooledit
  , sButton
  , sComboBox
  , sGroupBox
  , Vcl.ExtCtrls
  , sPanel

  , cxGridExportLink
  , cxGraphics
  , cxControls
  , cxLookAndFeels
  , cxLookAndFeelPainters
  , dxSkinsCore
  , cxStyles
  , dxSkinscxPCPainter
  , cxCustomData
  , cxFilter
  , cxData
  , cxDataStorage
  , cxEdit
  , cxNavigator
  , cxDBData
  , cxGridLevel
  , cxClasses
  , cxGridCustomView
  , cxGridCustomTableView
  , cxGridTableView
  , cxGridDBTableView
  , cxGrid
  , dxStatusBar
  , cxGridBandedTableView
  , cxGridDBBandedTableView

  , dxSkinMcSkin, dxSkinOffice2013White, dxSkinsDefaultPainters, dxSkinsdxStatusBarPainter, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  cxPropertiesStore, sLabel, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinDarkRoom,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue;



type
  TfrmRptTotallist = class(TForm)
    Panel3: TsPanel;
    cxGroupBox2: TsGroupBox;
    cbxMonth: TsComboBox;
    cbxYear: TsComboBox;
    btnRefresh: TsButton;
    gbxSelectDates: TsGroupBox;
    dtDateFrom: TsDateEdit;
    dtDateTo: TsDateEdit;
    Panel5: TsPanel;
    btnExcel: TsButton;
    dxStatusBar1: TdxStatusBar;
    grTotallist: TcxGrid;
    kbmTotallist: TkbmMemTable;
    TotallistDS: TDataSource;
    btnReport: TsButton;
    lvTotallistLevel1: TcxGridLevel;
    lvTotallist: TcxGridDBBandedTableView;
    lvTotallistdtDate: TcxGridDBBandedColumn;
    lvTotallistWeekNr: TcxGridDBBandedColumn;
    lvTotallistroomsArrival: TcxGridDBBandedColumn;
    lvTotallistpaxArrival: TcxGridDBBandedColumn;
    lvTotallistroomsInhouse: TcxGridDBBandedColumn;
    lvTotallistpaxInhouse: TcxGridDBBandedColumn;
    lvTotallistroomsDeparture: TcxGridDBBandedColumn;
    lvTotallistpaxDeparture: TcxGridDBBandedColumn;
    lvTotallistroomsStay: TcxGridDBBandedColumn;
    lvTotallistpaxStay: TcxGridDBBandedColumn;
    lvTotallistroomsWaitinglist: TcxGridDBBandedColumn;
    lvTotallistpaxWaitinglist: TcxGridDBBandedColumn;
    lvTotallistRoomsAllotment: TcxGridDBBandedColumn;
    lvTotallistpaxAllotment: TcxGridDBBandedColumn;
    lvTotallistroomsTotal: TcxGridDBBandedColumn;
    lvTotallistpaxTotal: TcxGridDBBandedColumn;
    lvTotallistroomsOutOfOrder: TcxGridDBBandedColumn;
    lvTotallistpaxOutOfOrder: TcxGridDBBandedColumn;
    FormStore: TcxPropertiesStore;
    labLocationsList: TsLabel;
    labLocations: TsLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dtDateFromChange(Sender: TObject);
    procedure cbxMonthCloseUp(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }

    zDateFrom : Tdate;
    zDateTo   : Tdate;
    zYear     : integer;
    zMonth    : integer;
    zSetDates : boolean;

    zLocationInString : string;

//    function LocationInString : string;
    procedure ShowData;

  public
    { Public declarations }
  end;

function rptTotalList : boolean;

var
  frmRptTotallist: TfrmRptTotallist;

implementation

{$R *.dfm}

uses
    uD
  , uRoomerLanguage
  , uDImages
  , uRoomerDefinitions
  , uMain;

function rptTotalList : boolean;
begin
  result := false;
  frmRptTotallist := TfrmRptTotallist.Create(nil);
  try
    frmRptTotallist.ShowModal;
    if frmRptTotallist.modalresult = mrOk then
    begin
      result := true;
    end
  finally
    freeandnil(frmRptTotallist);
  end;
end;


procedure TfrmRptTotallist.ShowData;
var
  y, m, d : word;
  lastDay : integer;
begin

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
end;


procedure TfrmRptTotallist.btnExcelClick(Sender: TObject);
var
  sFilename : string;
  s         : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_Totallist';
  ExportGridToExcel(sFilename, grTotallist {grGroupInvoiceSums}, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmRptTotallist.btnRefreshClick(Sender: TObject);
var
  s    : string;
  rset1: TRoomerDataset;
  ExecutionPlan : TRoomerExecutionPlan;

  sArrival     : string;
  sDeparture   : string;
  sWaitingList : string;
  sInhouse     : string;
  sStay        : string;
  sTotal       : String;
  sOutOfOrder  : string;
  sAllotment   : string;

begin
  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  try
//	STATUS_NOT_ARRIVED = 'P';
//  STATUS_ARRIVED = 'G';
//  STATUS_CHECKED_OUT = 'D';
//  STATUS_CANCELLED = 'C';
//  STATUS_WAITING_LIST = 'O';
//  STATUS_NO_SHOW = 'N';
//  STATUS_ALLOTMENT = 'A';
//  STATUS_BLOCKED = 'B';
//  STATUS_CANCELED = 'C';  //*HJ 140210
//  STATUS_TMP1 = 'W';  //*HJ 140210
//  STATUS_AWAITING_PAYMENT = 'Z';  //*BG 140304
//  STATUS_DELETED = 'X';  //*BG 140304

    sTotal       := _db(STATUS_NOT_ARRIVED)+','+
                    _db(STATUS_ARRIVED)+','+
                    _db(STATUS_CHECKED_OUT)+','+
                    _db(STATUS_TMP1)+','+
                    _db(STATUS_AWAITING_PAYMENT)+','+
                    _db(STATUS_WAITING_LIST)+','+
                    _db(STATUS_ALLOTMENT)+','+
                    _db(STATUS_BLOCKED);

    sArrival     := _db(STATUS_NOT_ARRIVED)+','
                   +_db(STATUS_ARRIVED)+','
                   +_db(STATUS_CHECKED_OUT)+','
                   +_db(STATUS_TMP1)+','
                   +_db(STATUS_AWAITING_PAYMENT);

    sDeparture   :=
                   _db(STATUS_NOT_ARRIVED)+',' +
                   _db(STATUS_ARRIVED)+','
                   +_db(STATUS_CHECKED_OUT)+','
                   +_db(STATUS_TMP1)+','
                   +_db(STATUS_AWAITING_PAYMENT);
                    ;

    sInhouse     := _db(STATUS_NOT_ARRIVED) + ',' +
                    _db(STATUS_ARRIVED) + ','
                    +_db(STATUS_CHECKED_OUT) + ','
                    + _db(STATUS_TMP1) + ','
                    + _db(STATUS_AWAITING_PAYMENT)
                    ;

    sStay        := _db(STATUS_NOT_ARRIVED)+','+_db(STATUS_ARRIVED)+','+_db(STATUS_CHECKED_OUT)+','+_db(STATUS_TMP1)+','+_db(STATUS_AWAITING_PAYMENT);

    sWaitingList := _db(STATUS_WAITING_LIST);
    sOutOfOrder  := _db(STATUS_BLOCKED);
    sAllotment   := _db(STATUS_ALLOTMENT);

    s := '';
    s := s+' SELECT '#10;
    s := s+'   pd.date AS dtDate '#10;
    s := s+'   ,(SELECT count(rr.id) FROM roomreservations rr INNER JOIN rooms on (rooms.room=rr.room and rooms.wildcard=0)' +
                ' WHERE (rr.arrival = pd.Date) AND rr.status in ('+sArrival+')) AS roomsArrival '#10;

    s := s+'   ,(SELECT sum(rr.numGuests) FROM roomreservations rr INNER JOIN rooms on (rooms.room=rr.room and rooms.wildcard=0)' +
                ' WHERE (rr.arrival = pd.Date) AND rr.status in ('+sArrival+')) AS paxArrival '#10;

    s := s+'   ,(SELECT count(rr.id) FROM roomreservations rr INNER JOIN rooms on (rooms.room=rr.room and rooms.wildcard=0)' +
                ' WHERE (rr.departure = pd.Date) AND rr.status in ('+sDeparture+')) AS roomsDeparture '#10;

    s := s+'   ,(SELECT sum(rr.numGuests) FROM roomreservations rr INNER JOIN rooms on (rooms.room=rr.room and rooms.wildcard=0)' +
                ' WHERE (rr.departure = pd.Date) AND rr.status in ('+sDeparture+')) AS paxDeparture '#10;

    s := s+'   ,(SELECT count(rd.id) FROM roomsdate rd INNER JOIN rooms on (rooms.room=rd.room and rooms.wildcard=0)' +
                ' WHERE date(rd.Adate)=pd.Date and rd.resflag in ('+sInhouse+')) AS roomsInhouse '#10;

    s := s+'   ,(SELECT count(pe.id) FROM persons pe WHERE RoomReservation IN ' +
                ' ((SELECT roomreservation FROM roomsdate rd INNER JOIN rooms on (rooms.room=rd.room and rooms.wildcard=0)' +
                '   WHERE date(rd.Adate)=pd.Date and rd.resflag in ('+sInhouse+'))))  AS paxInhouse '#10;

    s := s+'   ,((SELECT count(rd.id) FROM roomsdate rd INNER JOIN rooms on (rooms.room=rd.room and rooms.wildcard=0)' +
                ' WHERE date(rd.Adate)=pd.Date and rd.resflag in ('+sInhouse+'))) '#10 +
                ' - ((SELECT count(rr.id) FROM roomreservations rr INNER JOIN rooms on (rooms.room=rr.room and rooms.wildcard=0)' +
                '     WHERE (rr.arrival = pd.Date) AND rr.status in ('+sArrival+'))) AS roomsStay '#10;

    s := s+'   ,(SELECT count(pe.id) FROM persons pe WHERE RoomReservation IN ' +
                ' ((SELECT roomreservation FROM roomsdate rd INNER JOIN rooms on (rooms.room=rd.room and rooms.wildcard=0)' +
                ' WHERE date(rd.Adate)=pd.Date and rd.resflag in ('+sInhouse+')))) '#10 +
                ' -  ((SELECT sum(numGuests) FROM roomreservations rr INNER JOIN rooms on (rooms.room=rr.room and rooms.wildcard=0)' +
                '      WHERE (rr.arrival = pd.Date) AND rr.status in ('+sArrival+'))) AS paxStay '#10;

    s := s+'   ,(SELECT count(rd.id) FROM roomsdate rd WHERE date(rd.Adate)=pd.Date and rd.resflag in ('+sWaitingList+')) AS roomsWaitinglist '#10;

    s := s+'   ,(SELECT count(pe.id) FROM persons pe WHERE RoomReservation IN ((SELECT roomreservation FROM roomsdate rd WHERE date(rd.Adate)=pd.Date and rd.resflag in ('+sWaitingList+'))))  AS paxWaitinglist '#10;

    s := s+'   ,(SELECT count(rd.id) FROM roomsdate rd WHERE date(rd.Adate)=pd.Date and rd.resflag in ('+sAllotment+')) AS roomsAllotmennt '#10;

    s := s+'   ,(SELECT count(pe.id) FROM persons pe WHERE RoomReservation IN ' +
                ' ((SELECT roomreservation FROM roomsdate rd INNER JOIN rooms on (rooms.room=rd.room and rooms.wildcard=0)' +
                '   WHERE date(rd.Adate)=pd.Date and rd.resflag in ('+sAllotment+'))))  AS paxAllotment '#10;

    s := s+'   ,(SELECT count(rd.id) FROM roomsdate rd INNER JOIN rooms on (rooms.room=rd.room and rooms.wildcard=0)' +
                ' WHERE date(rd.Adate)=pd.Date and rd.resflag in ('+sTotal+')) AS roomsTotal '#10;

    s := s+'   ,(SELECT count(pe.id) FROM persons pe WHERE RoomReservation IN ' +
                ' ((SELECT roomreservation FROM roomsdate rd INNER JOIN rooms on (rooms.room=rd.room and rooms.wildcard=0)' +
                '   WHERE date(rd.Adate)=pd.Date and rd.resflag in ('+sTotal+'))))  AS paxTotal '#10;

    s := s+'   ,(SELECT count(rd.id) FROM roomsdate rd INNER JOIN rooms on (rooms.room=rd.room and rooms.wildcard=0)' +
                ' WHERE date(rd.Adate)=pd.Date and rd.resflag in ('+sOutofOrder+')) AS roomsOutOfOrder '#10;

    s := s+'   ,(SELECT count(pe.id) FROM persons pe WHERE RoomReservation IN ' +
                ' ((SELECT roomreservation FROM roomsdate rd INNER JOIN rooms on (rooms.room=rd.room and rooms.wildcard=0)' +
                '   WHERE date(rd.Adate)=pd.Date and rd.resflag in ('+sOutOfOrder+'))))  AS paxOutOfOrder '#10;

    s := s+'  FROM predefineddates pd '#10;
    s := s+'  WHERE '#10;
    s := s+'     ((pd.date>='+_DateToDbDate(zDateFrom,true)+' AND pd.date<='+_DateToDbDate(zDateTo,true)+')) '#10;

//    if zLocationInString <> '' then
//    begin
//      s := s+' AND location in ('+zLocationInString+') ';
//    end;

    ExecutionPlan.AddQuery(s);
    //////////////////// Execute!

    screen.Cursor := crHourGlass;
    kbmTotallist.DisableControls;
    try
      ExecutionPlan.Execute(ptQuery);

      //////////////////// RoomsDate
      rSet1 := ExecutionPlan.Results[0];

      if kbmTotallist.Active then kbmTotallist.Close;
      kbmTotallist.open;
      LoadKbmMemtableFromDataSetQuiet(kbmTotallist,rSet1,[]);
      kbmTotallist.First;

    finally
      screen.cursor := crDefault;
      kbmTotallist.EnableControls;
    end;

  finally
    ExecutionPlan.Free;
  end;

end;

procedure TfrmRptTotallist.cbxMonthCloseUp(Sender: TObject);
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

procedure TfrmRptTotallist.dtDateFromChange(Sender: TObject);
begin
  if zSetDates then
  begin
    zDateFrom := dtDateFrom.Date;
    zDateTo := dtDateTo.Date;

    cbxYear.ItemIndex := 0;
    cbxMonth.ItemIndex := 0;
  end;
end;

procedure TfrmRptTotallist.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //**
end;

procedure TfrmRptTotallist.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  glb.fillListWithMonthsLong(cbxMonth.Items, 1);
  glb.fillListWithYears(cbxYear.Items, 1, False);
end;


procedure TfrmRptTotallist.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

//function TfrmRptTotallist.LocationInString : string;
//var
//  i : integer;
//  locationID : integer;
//  s : string;
//  LocationList : TSet_Of_Integer;
//
//begin
//  result := '';
//  LocationList := frmmain.FilteredLocations;
//  if (locationList.Count = 0) or (locationList.Count = glb.Locations.recordCount) then exit;
//
//  s := '';
//  glb.Locations.first;
//  while not glb.locations.eof do
//  begin
//    locationID := glb.Locations.FieldByName('ID').asinteger;
//    if LocationList.ValueInList(locationID) then
//    begin
//      s := s+glb.Locations.FieldByName('location').AsString+',';
//    end;
//    glb.Locations.next;
//  end;
//
//  if length(s) > 0 then delete(s,length(s),1);
//  result := s;
//end;

procedure TfrmRptTotallist.FormShow(Sender: TObject);
begin
  _restoreForm(frmRptTotallist);
  zLocationInString := glb.LocationSQLInString(frmmain.FilteredLocations);

  if zLocationInString = '' then
  begin
    labLocationsList.caption := 'All Locations';
  end else
  begin
    labLocationsList.caption := zLocationInString;
  end;
  showdata;
end;

end.
