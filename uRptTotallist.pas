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
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue
  , uRoomerForm;



type
    // See https://promoir.atlassian.net/wiki/x/B4BEB for an explanation of the different states

  TfrmRptTotallist = class(TfrmBaseRoomerForm)
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
    grTotallist: TcxGrid;
    kbmTotallist: TkbmMemTable;
    TotallistDS: TDataSource;
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
    lvTotallistroomsWaitinglistNonOptional: TcxGridDBBandedColumn;
    lvTotallistpaxWaitinglistNonOptional: TcxGridDBBandedColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dtDateFromChange(Sender: TObject);
    procedure cbxMonthCloseUp(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
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
  protected
    procedure DoLoadData; override;
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
  , uMain, uReservationStateDefinitions
  , DateUtils
  ;


function rptTotalList : boolean;
begin
  frmRptTotallist := TfrmRptTotallist.Create(nil);
  try
    frmRptTotallist.ShowModal;
    Result := (frmRptTotallist.modalresult = mrOk);
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

  zDateFrom := encodeDate(y, m, 1);
  lastDay := DaysInaMonth(y, m);
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

procedure TfrmRptTotallist.DoLoadData;
var
  lExecutionPlan: TRoomerExecutionPlan;
  rSet1: TRoomerDataSet;
  s: string;

const
  cAllReservations: TReservationStateSet = [rsReservation, rsGuests, rsDeparted, rsWaitingList, rsTmp1, rsAllotment, rsBlocked, rsAwaitingPayment, rsAwaitingPayConfirm];
  cArrivalReservations: TReservationStateSet = [rsReservation, rsGuests, rsDeparted, rsTmp1, rsAwaitingPayment, rsAwaitingPayConfirm];
  cDepartureReservations: TReservationStateSet = [rsReservation, rsGuests, rsDeparted, rsTmp1, rsAwaitingPayment, rsAwaitingPayConfirm];
  cInhouseReservations: TReservationStateSet = [rsReservation, rsGuests, rsDeparted, rsTmp1, rsAwaitingPayment, rsAwaitingPayConfirm];
  cStayOverReservations: TReservationStateSet = [rsReservation, rsGuests, rsDeparted, rsTmp1, rsAwaitingPayment, rsAwaitingPayConfirm];

begin
  inherited;

  lExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  try

    // See https://promoir.atlassian.net/wiki/x/B4BEB for an explanation of the different states

{$REGION 'SQL statement'}
      s := '';
      s := s+'   SELECT '#10;
      s := s+'     pd.date AS dtDate, '#10;
      s := s+'    (SELECT '#10;
      s := s+'            COUNT(xx.id) '#10;
      s := s+'        FROM '#10;
      s := s+'            (SELECT '#10;
      s := s+'                rr.id, rr.arrival '#10;
      s := s+'            FROM '#10;
      s := s+'                roomreservations rr '#10;
      s := s+'            LEFT OUTER JOIN rooms ON (rooms.room = rr.room '#10;
      s := s+'                AND rooms.wildcard = 0) '#10;
      s := s+'            WHERE '#10;
      s := s+'                rr.status IN ' + cArrivalReservations.AsSQLString ;
      s := s+'                    AND ((SUBSTRING(rr.room, 1, 1) = ''<'') '#10;
      s := s+'                    OR (rooms.active = 1))) xx '#10;
      s := s+'        WHERE '#10;
      s := s+'            (xx.arrival = pd.date)) AS roomsArrival, '#10;

      s := s+'    (SELECT '#10;
      s := s+'            SUM(xx.numGuests) '#10;
      s := s+'        FROM '#10;
      s := s+'            (SELECT '#10;
      s := s+'                rr.numGuests, rr.arrival '#10;
      s := s+'            FROM '#10;
      s := s+'                roomreservations rr '#10;
      s := s+'            LEFT OUTER JOIN rooms ON (rooms.room = rr.room '#10;
      s := s+'                AND rooms.wildcard = 0) '#10;
      s := s+'            WHERE '#10;
      s := s+'                rr.status IN ' + cArrivalReservations.AsSQLString;
      s := s+'                    AND ((SUBSTRING(rr.room, 1, 1) = ''<'') '#10;
      s := s+'                    OR (rooms.active = 1))) xx '#10;
      s := s+'        WHERE '#10;
      s := s+'            (xx.arrival = pd.date)) AS paxArrival, '#10;

      s := s+'    (SELECT '#10;
      s := s+'            COUNT(xx.id) '#10;
      s := s+'        FROM '#10;
      s := s+'            (SELECT '#10;
      s := s+'                rr.id, rr.departure '#10;
      s := s+'            FROM '#10;
      s := s+'                roomreservations rr '#10;
      s := s+'            LEFT OUTER JOIN rooms ON (rooms.room = rr.room '#10;
      s := s+'                AND rooms.wildcard = 0) '#10;
      s := s+'            WHERE '#10;
      s := s+'                rr.status IN  ' + cDepartureReservations.AsSQLString;
      s := s+'                    AND ((SUBSTRING(rr.room, 1, 1) = ''<'') '#10;
      s := s+'                    OR (rooms.active = 1))) xx '#10;
      s := s+'        WHERE '#10;
      s := s+'            (xx.departure = pd.date)) AS roomsDeparture, '#10;

      s := s+'    (SELECT '#10;
      s := s+'            SUM(xx.numGuests) '#10;
      s := s+'        FROM '#10;
      s := s+'            (SELECT '#10;
      s := s+'                rr.numGuests, rr.departure '#10;
      s := s+'            FROM '#10;
      s := s+'                roomreservations rr '#10;
      s := s+'            LEFT OUTER JOIN rooms ON (rooms.room = rr.room '#10;
      s := s+'                AND rooms.wildcard = 0) '#10;
      s := s+'            WHERE '#10;
      s := s+'                rr.status IN ' + cDepartureReservations.AsSQLString;
      s := s+'                    AND ((SUBSTRING(rr.room, 1, 1) = ''<'') '#10;
      s := s+'                    OR (rooms.active = 1))) xx '#10;
      s := s+'        WHERE '#10;
      s := s+'            (xx.departure = pd.date)) AS paxDeparture, '#10;

      s := s+'    (SELECT '#10;
      s := s+'            COUNT(xx.id) '#10;
      s := s+'        FROM '#10;
      s := s+'            (SELECT '#10;
      s := s+'                rr.id, rr.arrival, rr.departure'#10;
      s := s+'            FROM '#10;
      s := s+'                roomreservations rr '#10;
      s := s+'            LEFT OUTER JOIN rooms ON (rooms.room = rr.room '#10;
      s := s+'                AND rooms.wildcard = 0) '#10;
      s := s+'            WHERE '#10;
      s := s+'                rr.status IN '+ cInhouseReservations.AsSQLString + #10;
      s := s+'                    AND ((SUBSTRING(rr.room, 1, 1) = ''<'') '#10;
      s := s+'                    OR (rooms.active = 1))) xx '#10;
      s := s+'        WHERE '#10;
      s := s+'            (xx.arrival <= pd.date) '#10;
      s := s+'            AND (xx.departure > pd.date)) AS roomsInHouse, '#10;

      s := s+'    (SELECT '#10;
      s := s+'            SUM(xx.numGuests) '#10;
      s := s+'        FROM '#10;
      s := s+'            (SELECT '#10;
      s := s+'                rr.arrival, rr.departure, '#10;
      s := s+'                (SELECT COUNT(pe.id) FROM persons pe WHERE pe.RoomReservation=rr.RoomReservation) AS numGuests '#10;
      s := s+'            FROM '#10;
      s := s+'                roomreservations rr '#10;
      s := s+'            LEFT OUTER JOIN rooms ON (rooms.room = rr.room '#10;
      s := s+'                AND rooms.wildcard = 0) '#10;
      s := s+'            WHERE '#10;
      s := s+'                rr.status IN ' + cInhouseReservations.AsSQLString;
      s := s+'                    AND ((SUBSTRING(rr.room, 1, 1) = ''<'') '#10;
      s := s+'                    OR (rooms.active = 1))) xx '#10;
      s := s+'        WHERE '#10;
      s := s+'            (xx.arrival <= pd.date) AND (xx.departure > pd.date)) AS paxinhouse, '#10;

      s := s+'    (SELECT '#10;
      s := s+'            COUNT(xx.id) '#10;
      s := s+'        FROM '#10;
      s := s+'            (SELECT '#10;
      s := s+'                rr.id, rr.arrival, rr.departure '#10;
      s := s+'            FROM '#10;
      s := s+'                roomreservations rr '#10;
      s := s+'            LEFT OUTER JOIN rooms ON (rooms.room = rr.room '#10;
      s := s+'                AND rooms.wildcard = 0) '#10;
      s := s+'            WHERE '#10;
      s := s+'                rr.status IN  ' + cStayOverReservations.AsSQLString;
      s := s+'                    AND ((SUBSTRING(rr.room, 1, 1) = ''<'') '#10;
      s := s+'                    OR (rooms.active = 1))) xx '#10;
      s := s+'        WHERE '#10;
      s := s+'            (xx.arrival < pd.date) '#10;
      s := s+'                AND (xx.departure > pd.date)) AS roomsStay, '#10;

      s := s+'    (SELECT '#10;
      s := s+'            SUM(xx.numGuests) '#10;
      s := s+'        FROM '#10;
      s := s+'            (SELECT '#10;
      s := s+'                rr.arrival, rr.departure, '#10;
      s := s+'                (SELECT COUNT(pe.id) FROM persons pe WHERE pe.RoomReservation=rr.RoomReservation) AS numGuests '#10;
      s := s+'            FROM '#10;
      s := s+'                roomreservations rr '#10;
      s := s+'            LEFT OUTER JOIN rooms ON (rooms.room = rr.room '#10;
      s := s+'                AND rooms.wildcard = 0) '#10;
      s := s+'            WHERE '#10;
      s := s+'                rr.status IN ' + cStayOverReservations.AsSQLString;
      s := s+'                    AND ((SUBSTRING(rr.room, 1, 1) = ''<'') '#10;
      s := s+'                    OR (rooms.active = 1))) xx '#10;
      s := s+'        WHERE '#10;
      s := s+'            (xx.arrival < pd.date '#10;
      s := s+'                AND xx.departure > pd.date)) AS paxStay, '#10;

      s := s+'    (SELECT '#10;
      s := s+'            COUNT(rd.id) '#10;
      s := s+'        FROM '#10;
      s := s+'            roomsdate rd '#10;
      s := s+'        WHERE '#10;
      s := s+'            DATE(rd.Adate) = pd.Date '#10;
      s := s+'                AND rd.resflag IN ('+ _db(rsOptionalBooking.AsStatusChar) +')) AS roomsWaitinglist, '#10;

      s := s+'    (SELECT '#10;
      s := s+'            COUNT(pe.id) '#10;
      s := s+'        FROM '#10;
      s := s+'            persons pe '#10;
      s := s+'        WHERE '#10;
      s := s+'            RoomReservation IN ((SELECT '#10;
      s := s+'                    roomreservation '#10;
      s := s+'                FROM '#10;
      s := s+'                    roomsdate rd '#10;
      s := s+'                WHERE '#10;
      s := s+'                    DATE(rd.Adate) = pd.Date '#10;
      s := s+'                        AND rd.resflag IN ('+ _db(rsOptionalBooking.AsStatusChar) +')))) AS paxWaitinglist, '#10;

      s := s+'    (SELECT '#10;
      s := s+'            COUNT(rd.id) '#10;
      s := s+'        FROM '#10;
      s := s+'            roomsdate rd '#10;
      s := s+'        WHERE '#10;
      s := s+'            DATE(rd.Adate) = pd.Date '#10;
      s := s+'                AND rd.resflag IN ('+ _db(rsWaitingList.AsStatusChar) +')) AS roomsWaitinglistNonOptional, '#10;

      s := s+'    (SELECT '#10;
      s := s+'            COUNT(pe.id) '#10;
      s := s+'        FROM '#10;
      s := s+'            persons pe '#10;
      s := s+'        WHERE '#10;
      s := s+'            RoomReservation IN ((SELECT '#10;
      s := s+'                    roomreservation '#10;
      s := s+'                FROM '#10;
      s := s+'                    roomsdate rd '#10;
      s := s+'                WHERE '#10;
      s := s+'                    DATE(rd.Adate) = pd.Date '#10;
      s := s+'                        AND rd.resflag IN ('+ _db(rsWaitingList.AsStatusChar) +')))) AS paxWaitinglistNonOptional, '#10;

      s := s+'    (SELECT '#10;
      s := s+'            COUNT(rd.id) '#10;
      s := s+'        FROM '#10;
      s := s+'            roomsdate rd '#10;
      s := s+'        WHERE '#10;
      s := s+'            DATE(rd.Adate) = pd.Date '#10;
      s := s+'                AND rd.resflag IN ('+ _db(rsAllotment.AsStatusChar) +')) AS roomsAllotmennt, '#10;

      s := s+'    (SELECT '#10;
      s := s+'            COUNT(pe.id) '#10;
      s := s+'        FROM '#10;
      s := s+'            persons pe '#10;
      s := s+'        WHERE '#10;
      s := s+'            RoomReservation IN ((SELECT '#10;
      s := s+'                    roomreservation '#10;
      s := s+'                FROM '#10;
      s := s+'                    roomsdate rd '#10;
      s := s+'                        INNER JOIN '#10;
      s := s+'                    rooms ON (rooms.room = rd.room '#10;
      s := s+'                        AND rooms.wildcard = 0 '#10;
      s := s+'                        AND rooms.active = 1) '#10;
      s := s+'                WHERE '#10;
      s := s+'                    DATE(rd.Adate) = pd.Date '#10;
      s := s+'                        AND rd.resflag IN ('+ _db(rsAllotment.AsStatusChar) +')))) AS paxAllotment, '#10;

      s := s+'    (SELECT '#10;
      s := s+'            COUNT(xx.id) '#10;
      s := s+'        FROM '#10;
      s := s+'            (SELECT '#10;
      s := s+'                rr.id, rr.arrival, rr.departure '#10;
      s := s+'            FROM '#10;
      s := s+'                roomreservations rr '#10;
      s := s+'            LEFT OUTER JOIN rooms ON (rooms.room = rr.room '#10;
      s := s+'                AND rooms.wildcard = 0) '#10;
      s := s+'            WHERE '#10;
      s := s+'                rr.status IN '+ cAllReservations.AsSQLString;
      s := s+'                    AND ((SUBSTRING(rr.room, 1, 1) = ''<'') '#10;
      s := s+'                    OR (rooms.active = 1))) xx '#10;
      s := s+'        WHERE '#10;
      s := s+'            (xx.arrival <= pd.date) '#10;
      s := s+'                AND xx.departure >= pd.date) AS roomsTotal, '#10;

      s := s+'    (SELECT '#10;
      s := s+'            SUM(xx.numGuests) '#10;
      s := s+'        FROM '#10;
      s := s+'            (SELECT '#10;
      s := s+'                rr.arrival, rr.departure, '#10;
      s := s+'                (SELECT COUNT(pe.id) FROM persons pe WHERE pe.RoomReservation=rr.RoomReservation) AS numGuests '#10;
      s := s+'            FROM '#10;
      s := s+'                roomreservations rr '#10;
      s := s+'            LEFT OUTER JOIN rooms ON (rooms.room = rr.room '#10;
      s := s+'                AND rooms.wildcard = 0) '#10;
      s := s+'            WHERE '#10;
      s := s+'                rr.status IN '+ cAllReservations.AsSQLString;
      s := s+'                    AND ((SUBSTRING(rr.room, 1, 1) = ''<'') '#10;
      s := s+'                    OR (rooms.active = 1))) xx '#10;
      s := s+'        WHERE '#10;
      s := s+'            (xx.arrival <= pd.date '#10;
      s := s+'                AND xx.departure >= pd.date)) AS paxTotal, '#10;

      s := s+'    (SELECT '#10;
      s := s+'            COUNT(rd.id) '#10;
      s := s+'        FROM '#10;
      s := s+'            roomsdate rd '#10;
      s := s+'                LEFT JOIN '#10;
      s := s+'            rooms ON (rooms.room = rd.room '#10;
      s := s+'                AND rooms.wildcard = 0 '#10;
      s := s+'                AND rooms.active = 1) '#10;
      s := s+'        WHERE '#10;
      s := s+'            DATE(rd.Adate) = pd.Date '#10;
      s := s+'                AND rd.resflag IN ('+ _db(rsBlocked.AsStatusChar) +')) AS roomsOutOfOrder, '#10;

      s := s+'    (SELECT '#10;
      s := s+'            COUNT(pe.id) '#10;
      s := s+'        FROM '#10;
      s := s+'            persons pe '#10;
      s := s+'        WHERE '#10;
      s := s+'            RoomReservation IN ((SELECT '#10;
      s := s+'                    roomreservation '#10;
      s := s+'                FROM '#10;
      s := s+'                    roomsdate rd '#10;
      s := s+'                        LEFT JOIN '#10;
      s := s+'                    rooms ON (rooms.room = rd.room '#10;
      s := s+'                        AND rooms.wildcard = 0 '#10;
      s := s+'                        AND rooms.active = 1) '#10;
      s := s+'                WHERE '#10;
      s := s+'                    DATE(rd.Adate) = pd.Date '#10;
      s := s+'                        AND rd.resflag IN ('+ _db(rsBlocked.AsStatusChar) +')))) AS paxOutOfOrder '#10;
      s := s+'FROM '#10;
      s := s+'    predefineddates pd '#10;
      s := s+'WHERE '#10;
      s := s+'    ((pd.date >= '+_DateToDbDate(zDateFrom,true)+' AND pd.date<='+_DateToDbDate(zDateTo,true)+')) '#10;
  
  
{$ENDREGION}

    CopyToClipboard(s);
    lExecutionPlan.AddQuery(s);

    screen.Cursor := crHourGlass;
    kbmTotallist.DisableControls;
    try
      lExecutionPlan.Execute(ptQuery);

      rSet1 := lExecutionPlan.Results[0];

      if kbmTotallist.Active then kbmTotallist.Close;
      kbmTotallist.open;
      LoadKbmMemtableFromDataSetQuiet(kbmTotallist,rSet1,[]);
      kbmTotallist.First;

    finally
      screen.cursor := crDefault;
      kbmTotallist.EnableControls;
    end;

  finally
    lExecutionPlan.Free;
  end;

end;

procedure TfrmRptTotallist.btnRefreshClick(Sender: TObject);
begin
  RefreshData;
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
  m := cbxMonth.ItemIndex;

  zDateFrom := encodeDate(y, m, 1);
  lastDay := DaysInAMonth(y, m);
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

procedure TfrmRptTotallist.FormCreate(Sender: TObject);
begin
  glb.fillListWithMonthsLong(cbxMonth.Items, 1);
  glb.fillListWithYears(cbxYear.Items, 1, False);
end;


procedure TfrmRptTotallist.FormShow(Sender: TObject);
var
  lLocations: TSet_Of_Integer;
begin
  lLocations := frmmain.FilteredLocations;
  try
  zLocationInString := glb.LocationSQLInString(lLocations);
  finally
    lLocations.Free;
  end;

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
