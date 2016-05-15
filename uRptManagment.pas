unit uRptManagment;

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
  , math


  , kbmMemTable
  ,cmpRoomerDataSet
  ,cmpRoomerConnection

  , _glob
  , ug
  , hData
  , uUtils
  , uAppGlobal


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
  , dxSkinsCore, cxStyles, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData, cxCalc, cxCurrencyEdit,
  cxPropertiesStore, AdvChartPaneEditor, VCLTee.TeEngine, VCLTee.Series, VCLTee.TeeProcs, VCLTee.Chart, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridBandedTableView, cxGridDBBandedTableView, cxClasses, cxGridCustomView, cxGridDBTableView, cxGrid, Vcl.ComCtrls,
  sPageControl, sStatusBar, sCheckBox, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinDarkRoom, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue

  ;

type
  TfrmRptManagment = class(TForm)
    Panel3: TsPanel;
    cxGroupBox2: TsGroupBox;
    cbxMonth: TsComboBox;
    cbxYear: TsComboBox;
    btnRefresh: TsButton;
    gbxSelectDates: TsGroupBox;
    dtDateFrom: TsDateEdit;
    dtDateTo: TsDateEdit;
    sStatusBar1: TsStatusBar;
    kbmStat: TkbmMemTable;
    StatDS: TDataSource;
    pageMain: TsPageControl;
    tabStatGrid: TsTabSheet;
    tabGraph: TsTabSheet;
    sPanel1: TsPanel;
    grStat: TcxGrid;
    tvStat: TcxGridDBTableView;
    btnGuestsExcel: TsButton;
    sButton1: TsButton;
    lvStat: TcxGridLevel;
    tvStats: TcxGridDBBandedTableView;
    tvStatsADate: TcxGridDBBandedColumn;
    tvStatssoldRooms: TcxGridDBBandedColumn;
    tvStatsrevenue: TcxGridDBBandedColumn;
    tvStatstotalDiscount: TcxGridDBBandedColumn;
    tvStatsmaxRate: TcxGridDBBandedColumn;
    tvStatsminRate: TcxGridDBBandedColumn;
    tvStatsaverageRate: TcxGridDBBandedColumn;
    tvStatscheckedInToday: TcxGridDBBandedColumn;
    tvStatsarrivingRooms: TcxGridDBBandedColumn;
    tvStatsnoShow: TcxGridDBBandedColumn;
    tvStatsdepartingRooms: TcxGridDBBandedColumn;
    tvStatsdepartedRooms: TcxGridDBBandedColumn;
    tvStatsoccupiedRooms: TcxGridDBBandedColumn;
    tvStatstotalRooms: TcxGridDBBandedColumn;
    tvStatslocalCurrency: TcxGridDBBandedColumn;
    tvStatstotalGuests: TcxGridDBBandedColumn;
    tvStatsocc: TcxGridDBBandedColumn;
    tvStatsadr: TcxGridDBBandedColumn;
    tvStatsrevPar: TcxGridDBBandedColumn;
    chkCompareLasYear: TsCheckBox;
    pageCharts: TsPageControl;
    tabOcc: TsTabSheet;
    sPanel2: TsPanel;
    sButton2: TsButton;
    Chart1: TChart;
    AdvChartPanesEditorDialog1: TAdvChartPanesEditorDialog;
    Series1: TLineSeries;
    FormStore: TcxPropertiesStore;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dtDateFromChange(Sender: TObject);
    procedure cbxMonthCloseUp(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnGuestsExcelClick(Sender: TObject);
    procedure tvStatsrevenueGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure sButton2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }

    zDateFrom : Tdate;
    zDateTo   : Tdate;
    zYear     : integer;
    zMonth    : integer;
    zSetDates : boolean;


    procedure ShowData;
  public
    { Public declarations }
  end;

function rptManagment : boolean;

var
  frmRptManagment: TfrmRptManagment;

implementation

{$R *.dfm}

uses
  uD,
  uRoomerLanguage,
  uDimages,
  uRoomerDefinitions;

function rptManagment : boolean;
begin
  result := false;
  frmRptManagment := TfrmRptManagment.Create(frmRptManagment);
  try
    frmRptManagment.ShowModal;
    if frmRptManagment.modalresult = mrOk then
    begin
      result := true;
    end
  finally
    freeandnil(frmRptManagment);
  end;
end;

procedure TfrmRptManagment.ShowData;
var
  y, m, d : word;
  idx : integer;
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


procedure TfrmRptManagment.tvStatsrevenueGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptManagment.btnGuestsExcelClick(Sender: TObject);
var
  sFilename : string;
  s         : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_StatData';
  ExportGridToExcel(sFilename, grStat {grGroupInvoiceSums}, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmRptManagment.btnRefreshClick(Sender: TObject);
var
  s    : string;
  rset1,
  rset2,
  rset3 : TRoomerDataset;
  ExecutionPlan : TRoomerExecutionPlan;

  startTick : integer;
  stopTick  : integer;
  SQLms     : integer;

  statusIn : string;

  dtTmp : TdateTime;
begin
  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  try
    startTick := GetTickCount;


    s := '';
    s := s+' SELECT * '#10;
    s := s+' FROM '#10;
    s := s+' ( '#10;
    s := s+' SELECT baseData.*, '#10;
    s := s+'        CAST(0 AS SIGNED) AS ooo, '#10;
    s := s+'        CAST(soldRooms/totalRooms*100 AS DECIMAL) AS occ, '#10;
    s := s+'        CAST(revenue/soldRooms AS DECIMAL) AS adr, '#10;
    s := s+'        CAST(revenue/totalRooms AS DECIMAL) AS revPar '#10;
    s := s+' FROM ( '#10;
    s := s+' SELECT DATE(pdd.date) AS ADate, COUNT(rd.id) AS soldRooms, '#10;
    s := s+'        SUM((IF(Discount > 0, RoomRate - IF(isPercentage, RoomRate * Discount / 100, Discount), RoomRate)) * curr.AValue) AS revenue, '#10;
    s := s+'        SUM((IF(Discount > 0, IF(isPercentage, RoomRate * Discount / 100, Discount), 0)) * curr.AValue) AS totalDiscount, '#10;
    s := s+'        MAX(RoomRate * curr.AValue) AS maxRate, '#10;
    s := s+'        MIN(RoomRate * curr.AValue) AS minRate, '#10;
    s := s+'        AVG(RoomRate * curr.AValue) AS averageRate, '#10;
    s := s+'        (SELECT COUNT(id) FROM roomreservations WHERE Arrival=pdd.date AND Status='+_db(STATUS_ARRIVED)+') AS checkedInToday, '#10;
    s := s+'        (SELECT COUNT(id) FROM roomreservations WHERE Arrival=pdd.date AND Status='+_db(STATUS_NOT_ARRIVED)+') AS arrivingRooms, '#10;
    s := s+'        (SELECT COUNT(id) FROM roomreservations WHERE Arrival=DATE_ADD(pdd.date,INTERVAL -1 DAY) AND Status='+_db(STATUS_NO_SHOW)+') AS noShow, '#10;
    s := s+'        (SELECT COUNT(id) FROM roomreservations WHERE Departure=pdd.date AND Status='+_db(STATUS_ARRIVED)+') AS departingRooms, '#10;
    s := s+'        (SELECT COUNT(id) FROM roomreservations WHERE Departure=pdd.date AND Status='+_db(STATUS_CHECKED_OUT)+') AS departedRooms, '#10;
    s := s+'        (SELECT COUNT(id) FROM roomsdate WHERE ADate=pdd.date AND ResFlag='+_db(STATUS_ARRIVED)+') AS occupiedRooms, '#10;
    s := s+'        (SELECT COUNT(id) FROM rooms WHERE hidden=0 AND Active=1 AND Statistics=1 AND wildCard=0) AS totalRooms, '#10;
    s := s+'        (SELECT NativeCurrency FROM control LIMIT 1) AS localCurrency, '#10;
    s := s+'        SUM((SELECT COUNT(id) FROM persons WHERE RoomReservation=rd.RoomReservation)) AS totalGuests '#10;
    s := s+' FROM predefineddates pdd, '#10;
    s := s+'      roomsdate rd, '#10;
    s := s+'      currencies curr '#10;
    s := s+' WHERE '#10;  //pdd.date>='2014-08-01' AND pdd.date<='2014-08-30' '#10;
    s := s+'     ((pdd.date>='+_DateToDbDate(zDateFrom,true)+' AND pdd.date<='+_DateToDbDate(zDateTo,true)+')) '#10;
    s := s+' AND pdd.date=rd.ADate '#10;
    s := s+' AND curr.Currency=rd.Currency '#10;
    s := s+' AND (NOT ResFlag IN ('+_db(STATUS_DELETED)+','+_db(STATUS_CANCELLED)+','+_db(STATUS_WAITING_LIST)+','+_db(STATUS_NO_SHOW)+','+_db(STATUS_BLOCKED)+')) '#10;
    s := s+' GROUP BY pdd.date '#10;
    s := s+' ORDER BY pdd.date '#10;
    s := s+' ) baseData '#10;
    s := s+' UNION '#10;
    s := s+' SELECT baseData.*, '#10;
    s := s+'        CAST(0 AS SIGNED) AS ooo, '#10;
    s := s+'        CAST(0.00 AS DECIMAL) AS occ, '#10;
    s := s+'        CAST(0.00 AS DECIMAL) AS adr, '#10;
    s := s+'        CAST(0.00 AS DECIMAL) AS revPar '#10;
    s := s+' FROM ( '#10;
    s := s+' SELECT DATE(pdd.date) AS ADate, CAST(0 AS SIGNED) AS soldRooms, '#10;
    s := s+'        CAST(0.00 AS DECIMAL) AS revenue, '#10;
    s := s+'        CAST(0.00 AS DECIMAL) AS totalDiscount, '#10;
    s := s+'        CAST(0.00 AS DECIMAL) AS maxRate, '#10;
    s := s+'        CAST(0.00 AS DECIMAL) AS minRate, '#10;
    s := s+'        CAST(0.00 AS DECIMAL) AS averageRate, '#10;
    s := s+'        CAST(0 AS SIGNED) AS checkedInToday, '#10;
    s := s+'        CAST(0 AS SIGNED) AS arrivingRooms, '#10;
    s := s+'        (SELECT COUNT(id) FROM roomreservations WHERE Arrival=DATE_ADD(pdd.date,INTERVAL -1 DAY) AND Status='+_db(STATUS_NO_SHOW)+') AS noShow, '#10;
    s := s+'        (SELECT COUNT(id) FROM roomreservations WHERE Departure=pdd.date AND Status='+_db(STATUS_ARRIVED)+') AS departingRooms, '#10;
    s := s+'        (SELECT COUNT(id) FROM roomreservations WHERE Departure=pdd.date AND Status='+_db(STATUS_CHECKED_OUT)+') AS departedRooms, '#10;
    s := s+'        CAST(0 AS SIGNED) AS occupiedRooms, '#10;
    s := s+'        (SELECT COUNT(id) FROM rooms WHERE hidden=0 AND Active=1 AND Statistics=1 AND wildCard=0) AS totalRooms, '#10;
    s := s+'        (SELECT NativeCurrency FROM control LIMIT 1) AS localCurrency, '#10;
    s := s+'        CAST(0 AS SIGNED) AS totalGuests '#10;
    s := s+' FROM predefineddates pdd '#10;
    s := s+' WHERE '#10; // pdd.date>='2014-08-01' AND pdd.date<='2014-08-30'
    s := s+'     ((pdd.date>='+_DateToDbDate(zDateFrom,true)+' AND pdd.date<='+_DateToDbDate(zDateTo,true)+')) '#10;
    s := s+' AND ISNULL((SELECT id FROM roomsdate WHERE ADate=pdd.date AND NOT(ResFlag IN ('+_db(STATUS_DELETED)+','+_db(STATUS_CANCELLED)+')) LIMIT 1)) '#10;
    s := s+' GROUP BY pdd.date '#10;
    s := s+' ORDER BY pdd.date '#10;
    s := s+' ) baseData '#10;
    s := s+' ) AllData '#10;
    s := s+' ORDER BY ADate '#10;

//    s := '';
//    s := s+' SELECT * '#10;
//    s := s+' FROM '#10;
//    s := s+' ( '#10;
//    s := s+' SELECT baseData.*, '#10;
//    s := s+'        CAST(0 AS SIGNED) AS ooo, '#10;
//    s := s+'        CAST(soldRooms/totalRooms*100 AS DECIMAL) AS occ, '#10;
//    s := s+'        CAST(revenue/soldRooms AS DECIMAL) AS adr, '#10;
//    s := s+'        CAST(revenue/totalRooms AS DECIMAL) AS revPar '#10;
//    s := s+' FROM ( '#10;
//    s := s+' SELECT DATE(pdd.date) AS ADate, COUNT(rd.id) AS soldRooms, '#10;
//    s := s+'        SUM(IF(NOT Paid, '#10;
//    s := s+'                (IF(Discount > 0, RoomRate - IF(isPercentage, RoomRate * Discount / 100, Discount), RoomRate)) * curr.AValue, '#10;
//    s := s+'                (SELECT SUM(NUMBER*PRICE*CurrencyRate) FROM invoicelines WHERE ItemId=c.RoomRentItem AND RoomReservation=rd.RoomReservation AND InvoiceNumber>0))) AS revenue, '#10;
//    s := s+'        SUM((IF(Discount > 0, IF(isPercentage, RoomRate * Discount / 100, Discount), 0)) * curr.AValue) AS totalDiscount, '#10;
//    s := s+'        MAX(IF(NOT Paid, '#10;
//    s := s+'                RoomRate * curr.AValue, '#10;
//    s := s+'                (SELECT SUM(NUMBER*PRICE*CurrencyRate) FROM invoicelines WHERE ItemId=c.RoomRentItem AND RoomReservation=rd.RoomReservation AND InvoiceNumber>0))) AS maxRate, '#10;
//    s := s+'        MIN(IF(NOT Paid, '#10;
//    s := s+'                RoomRate * curr.AValue, '#10;
//    s := s+'                (SELECT SUM(NUMBER*PRICE*CurrencyRate) FROM invoicelines WHERE ItemId=c.RoomRentItem AND RoomReservation=rd.RoomReservation AND InvoiceNumber>0))) AS minRate, '#10;
//    s := s+'        AVG(IF(NOT Paid, '#10;
//    s := s+'                RoomRate * curr.AValue, '#10;
//    s := s+'                (SELECT SUM(NUMBER*PRICE*CurrencyRate) FROM invoicelines WHERE ItemId=c.RoomRentItem AND RoomReservation=rd.RoomReservation AND InvoiceNumber>0))) AS averageRate, '#10;
//    s := s+'        (SELECT COUNT(id) FROM roomreservations WHERE Arrival=pdd.date AND Status='+_db(STATUS_ARRIVED)+') AS checkedInToday, '#10;
//    s := s+'        (SELECT COUNT(id) FROM roomreservations WHERE Arrival=pdd.date AND Status='+_db(STATUS_NOT_ARRIVED)+') AS arrivingRooms, '#10;
//    s := s+'        (SELECT COUNT(id) FROM roomreservations WHERE Arrival=DATE_ADD(pdd.date,INTERVAL -1 DAY) AND Status='+_db(STATUS_NO_SHOW)+') AS noShow, '#10;
//    s := s+'        (SELECT COUNT(id) FROM roomreservations WHERE Departure=pdd.date AND Status='+_db(STATUS_ARRIVED)+') AS departingRooms, '#10;
//    s := s+'        (SELECT COUNT(id) FROM roomreservations WHERE Departure=pdd.date AND Status='+_db(STATUS_CHECKED_OUT)+') AS departedRooms, '#10;
//    s := s+'        (SELECT COUNT(id) FROM roomsdate WHERE ADate=pdd.date AND ResFlag='+_db(STATUS_ARRIVED)+') AS occupiedRooms, '#10;
//    s := s+'        (SELECT COUNT(id) FROM rooms WHERE (NOT hidden) AND Active) AS totalRooms, '#10;
//    s := s+'        (SELECT NativeCurrency FROM control LIMIT 1) AS localCurrency, '#10;
//    s := s+'        SUM((SELECT COUNT(id) FROM persons WHERE RoomReservation=rd.RoomReservation)) AS totalGuests '#10;
//    s := s+' FROM predefineddates pdd, '#10;
//    s := s+'      roomsdate rd, '#10;
//    s := s+'      currencies curr, '#10;
//    s := s+'      control c '#10;
//    s := s+' WHERE '#10;  //pdd.date>='2014-08-01' AND pdd.date<='2014-08-30' '#10;
//    s := s+'     ((pdd.date>='+_DateToDbDate(zDateFrom,true)+' AND pdd.date<='+_DateToDbDate(zDateTo,true)+')) '#10;
//    s := s+' AND pdd.date=rd.ADate '#10;
//    s := s+' AND curr.Currency=rd.Currency '#10;
//    s := s+' AND (NOT ResFlag IN ('+_db(STATUS_DELETED)+','+_db(STATUS_CANCELLED)+','+_db(STATUS_WAITING_LIST)+','+_db(STATUS_NO_SHOW)+')) '#10;
//    s := s+' GROUP BY pdd.date '#10;
//    s := s+' ORDER BY pdd.date '#10;
//    s := s+' ) baseData '#10;
//    s := s+' UNION '#10;
//    s := s+' SELECT baseData.*, '#10;
//    s := s+'        CAST(0 AS SIGNED) AS ooo, '#10;
//    s := s+'        CAST(0.00 AS DECIMAL) AS occ, '#10;
//    s := s+'        CAST(0.00 AS DECIMAL) AS adr, '#10;
//    s := s+'        CAST(0.00 AS DECIMAL) AS revPar '#10;
//    s := s+' FROM ( '#10;
//    s := s+' SELECT DATE(pdd.date) AS ADate, CAST(0 AS SIGNED) AS soldRooms, '#10;
//    s := s+'        CAST(0.00 AS DECIMAL) AS revenue, '#10;
//    s := s+'        CAST(0.00 AS DECIMAL) AS totalDiscount, '#10;
//    s := s+'        CAST(0.00 AS DECIMAL) AS maxRate, '#10;
//    s := s+'        CAST(0.00 AS DECIMAL) AS minRate, '#10;
//    s := s+'        CAST(0.00 AS DECIMAL) AS averageRate, '#10;
//    s := s+'        CAST(0 AS SIGNED) AS checkedInToday, '#10;
//    s := s+'        CAST(0 AS SIGNED) AS arrivingRooms, '#10;
//    s := s+'        (SELECT COUNT(id) FROM roomreservations WHERE Arrival=DATE_ADD(pdd.date,INTERVAL -1 DAY) AND Status='+_db(STATUS_NO_SHOW)+') AS noShow, '#10;
//    s := s+'        (SELECT COUNT(id) FROM roomreservations WHERE Departure=pdd.date AND Status='+_db(STATUS_ARRIVED)+') AS departingRooms, '#10;
//    s := s+'        (SELECT COUNT(id) FROM roomreservations WHERE Departure=pdd.date AND Status='+_db(STATUS_CHECKED_OUT)+') AS departedRooms, '#10;
//    s := s+'        CAST(0 AS SIGNED) AS occupiedRooms, '#10;
//    s := s+'        (SELECT COUNT(id) FROM rooms WHERE (NOT hidden) AND Active) AS totalRooms, '#10;
//    s := s+'        (SELECT NativeCurrency FROM control LIMIT 1) AS localCurrency, '#10;
//    s := s+'        CAST(0 AS SIGNED) AS totalGuests '#10;
//    s := s+' FROM predefineddates pdd '#10;
//    s := s+' WHERE '#10; // pdd.date>='2014-08-01' AND pdd.date<='2014-08-30'
//    s := s+'     ((pdd.date>='+_DateToDbDate(zDateFrom,true)+' AND pdd.date<='+_DateToDbDate(zDateTo,true)+')) '#10;
//    s := s+' AND ISNULL((SELECT id FROM roomsdate WHERE ADate=pdd.date AND ResFlag<>'+_db(STATUS_DELETED)+' LIMIT 1)) '#10;
//    s := s+' GROUP BY pdd.date '#10;
//    s := s+' ORDER BY pdd.date '#10;
//    s := s+' ) baseData '#10;
//    s := s+' ) AllData '#10;
//    s := s+' ORDER BY ADate '#10;

//  copytoclipboard(s);
//  debugmessage(s);


// ADate
// soldRooms
// revenue
// totalDiscount
// maxRate
// minRate
// averageRate
// checkedInToday
// arrivingRooms
// noShow
// departingRooms
// departedRooms
// occupiedRooms
// totalRooms
// localCurrency
// totalGuests
// ooo
// occ
// adr
// revPar

    ExecutionPlan.AddQuery(s);
    //////////////////// Execute!

    screen.Cursor := crHourGlass;
    kbmStat.DisableControls;
    try
      ExecutionPlan.Execute(ptQuery);

      //////////////////// RoomsDate
      rSet1 := ExecutionPlan.Results[0];

      if kbmStat.Active then kbmStat.Close;
      kbmStat.open;
      LoadKbmMemtableFromDataSetQuiet(kbmStat,rSet1,[]);
      kbmStat.First;

    finally
      screen.cursor := crDefault;
      kbmStat.EnableControls;
    end;

    stopTick         := GetTickCount;
    SQLms            := stopTick - startTick;
//    sLabTime.Caption := inttostr(SQLms);

  finally
    ExecutionPlan.Free;
  end;



end;

procedure TfrmRptManagment.cbxMonthCloseUp(Sender: TObject);
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

procedure TfrmRptManagment.dtDateFromChange(Sender: TObject);
begin
  if zSetDates then
  begin
    zDateFrom := dtDateFrom.Date;
    zDateTo := dtDateTo.Date;

    cbxYear.ItemIndex := 0;
    cbxMonth.ItemIndex := 0;
  end;
end;

procedure TfrmRptManagment.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //**
end;

procedure TfrmRptManagment.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  glb.fillListWithMonthsLong(cbxMonth.Items, 1);
  glb.fillListWithYears(cbxYear.Items, 1, False);
end;

procedure TfrmRptManagment.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmRptManagment.FormShow(Sender: TObject);
begin
  //**
  _restoreForm(frmRptManagment);
  showdata;
end;

procedure TfrmRptManagment.sButton2Click(Sender: TObject);
var
  i : integer;

  aValue : integer;
  sDate  : string;
  dtDate : Tdate;

begin
  Chart1.Series[0].Clear;
  kbmStat.DisableControls;
  try
    kbmstat.SortFields := 'ADate';
    kbmstat.Sort([]);
    kbmStat.First;
    while not kbmstat.eof do
    begin
      aValue := kbmStat.FieldByName('occ').AsInteger;
      dtDate := kbmStat.fieldbyname('aDate').asdatetime;
      dateTimeTostring(sDate,'mmm dd',dtDate);
      Chart1.Series[0].Add(aValue,sDate, clBlue);
      kbmStat.Next;
    end;
  finally
    kbmStat.EnableControls;
  end;

end;

end.

