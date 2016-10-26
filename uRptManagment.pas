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
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, ppDB, ppDBPipe, ppParameter, ppDesignLayer, ppVar, ppBands,
  ppCtrls, ppPrnabl, ppClass, ppCache, ppComm, ppRelatv, ppProd, ppReport

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
    kbmStatReport: TkbmMemTable;
    dsStatReport: TDataSource;
    plStats: TppDBPipeline;
    rptStats: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppLine1: TppLine;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    rlabFrom: TppLabel;
    rLabTo: TppLabel;
    ppLabel6: TppLabel;
    rLabHotelName: TppLabel;
    rlabUser: TppLabel;
    rLabTimeCreated: TppLabel;
    ppLine11: TppLine;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppSystemVariable1: TppSystemVariable;
    ppLabel8: TppLabel;
    ppLine2: TppLine;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppParameterList1: TppParameterList;
    btnReport: TsButton;
    ppLabel1: TppLabel;
    ppDBText1: TppDBText;
    ppLabel2: TppLabel;
    ppDBText2: TppDBText;
    ppLabel3: TppLabel;
    ppDBText3: TppDBText;
    ppLabel7: TppLabel;
    ppDBText4: TppDBText;
    ppLabel9: TppLabel;
    ppDBText5: TppDBText;
    ppLine3: TppLine;
    ppLine4: TppLine;
    ppLabel10: TppLabel;
    ppDBText6: TppDBText;
    ppLabel11: TppLabel;
    ppDBText7: TppDBText;
    ppLabel12: TppLabel;
    ppDBText8: TppDBText;
    ppLabel13: TppLabel;
    ppDBText9: TppDBText;
    ppLabel14: TppLabel;
    ppDBText10: TppDBText;
    ppLabel15: TppLabel;
    ppDBText11: TppDBText;
    ppLine5: TppLine;
    ppLine6: TppLine;
    ppLabel16: TppLabel;
    ppDBText12: TppDBText;
    ppLabel17: TppLabel;
    ppDBText13: TppDBText;
    ppLabel18: TppLabel;
    ppDBText14: TppDBText;
    ppLabel19: TppLabel;
    ppDBText15: TppDBText;
    ppLabel20: TppLabel;
    ppDBText16: TppDBText;
    ppLabel21: TppLabel;
    ppDBText17: TppDBText;
    ppLabel22: TppLabel;
    ppDBText18: TppDBText;
    ppLabel23: TppLabel;
    ppLabel24: TppLabel;
    ppLabel25: TppLabel;
    ppSummaryBand1: TppSummaryBand;
    ppLine7: TppLine;
    ppDBCalc1: TppDBCalc;
    ppDBCalc2: TppDBCalc;
    ppDBCalc3: TppDBCalc;
    ppDBCalc4: TppDBCalc;
    ppDBCalc5: TppDBCalc;
    ppDBCalc6: TppDBCalc;
    ppDBCalc7: TppDBCalc;
    ppDBCalc8: TppDBCalc;
    ppDBCalc9: TppDBCalc;
    ppDBCalc10: TppDBCalc;
    ppDBCalc12: TppDBCalc;
    ppDBCalc13: TppDBCalc;
    ppDBCalc14: TppDBCalc;
    ppDBCalc15: TppDBCalc;
    ppDBCalc16: TppDBCalc;
    ppDBCalc17: TppDBCalc;
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
    procedure btnReportClick(Sender: TObject);
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
  uRoomerDefinitions,
  uReservationStateDefinitions,
  uRptbViewer;

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
  lastDay : integer;
begin
  decodeDate(now, y, m, d);
  zYear := y;
  zMonth := m;
  cbxMonth.ItemIndex := zMonth;

  cbxYear.ItemIndex := cbxYear.Items.IndexOf(inttostr(zYear));

  zDateFrom := encodeDate(y, m, 1);
  lastDay := DaysInMonth(y, m);
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
  rset1: TRoomerDataset;
  ExecutionPlan : TRoomerExecutionPlan;

begin
  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  try

  s := 'SELECT id, '+
       'pd.date, '+
       'DATE(IFNULL(ADate, pd.date)) AS ADate, '+
       'soldRooms, '+
       'revenue, '+
       'totalDiscount, '+
       'maxRate, '+
       'minRate, '+
       'averageRate, '+
       'checkedInToday, '+
       'arrivingRooms, '+
       'noShow, '+
       'departingRooms, '+
       'departedRooms, '+
       'occupiedRooms, '+
       'totalRooms, '+
       'totalGuests , '+
       'occ, '+
       'adr, '+
       'revPar, '+
       '(SELECT NativeCurrency FROM control LIMIT 1) AS localCurrency '+
       'FROM '#10 ;
  s := s + 'predefineddates pd '#10 ;
  s := s + 'LEFT OUTER JOIN '#10 ;
  s := s + ' ( '#10 ;
  s := s + '	 SELECT baseData1.*, '#10 ;
  s := s + '			soldRooms/totalRooms*100 AS occ, '#10 ;
  s := s + '			revenue/soldRooms AS adr, '#10 ;
  s := s + '			revenue/totalRooms as RevPar '#10 ;
  s := s + '	 FROM ( '#10 ;
  s := s + '		 SELECT DATE(pdd.date) AS ADate, '#10 ;
  s := s + '				COUNT(rd.id) AS soldRooms, '#10 ;
  s := s + '				SUM((IF(Discount > 0, RoomRate - IF(isPercentage, RoomRate * Discount / 100, Discount), RoomRate)) * curr.AValue) AS revenue, '#10 ;
  s := s + '				SUM((IF(Discount > 0, IF(isPercentage, RoomRate * Discount / 100, Discount), 0)) * curr.AValue) AS totalDiscount, '#10 ;
  s := s + '				MAX(RoomRate * curr.AValue) AS maxRate, '#10 ;
  s := s + '				MIN(RoomRate * curr.AValue) AS minRate, '#10 ;
  s := s + '				AVG(RoomRate * curr.AValue) AS averageRate, '#10 ;
  s := s + '				(SELECT COUNT(rr2.id) FROM roomreservations  rr2 '#10 ;
  s := s + '					JOIN rooms r on r.room=rr2.room and r.wildcard=0 and r.active=1 and statistics=1 and hidden=0 '#10 ;
  s := s + '					WHERE rr2.Arrival=pdd.date AND rr2.Status='+_db(STATUS_ARRIVED)+') AS checkedInToday, '#10 ;
  s := s + '				(SELECT COUNT(rr2.id) FROM roomreservations   rr2 '#10 ;
//  s := s + '					JOIN rooms r on r.room=rr2.room and r.wildcard=0 and r.active=1 and statistics=1 and hidden=0 '#10 ;
  s := s + '					WHERE rr2.Arrival=pdd.date AND rr2.Status='+_db(STATUS_NOT_ARRIVED)+') AS arrivingRooms, '#10 ;
  s := s + '				(SELECT COUNT(rr2.id) FROM roomreservations rr2 '#10 ;
//  s := s + '					JOIN rooms r on r.room=rr2.room and r.wildcard=0 and r.active=1 and statistics=1 and hidden=0 '#10 ;
  s := s + '					WHERE rr2.Arrival=DATE_ADD(pdd.date,INTERVAL -1 DAY) AND rr2.Status='+_db(STATUS_NO_SHOW)+') AS noShow, '#10 ;
  s := s + '				(SELECT COUNT(rr2.id) FROM roomreservations rr2 '#10 ;
//  s := s + '					JOIN rooms r on r.room=rr2.room and r.wildcard=0 and r.active=1 and statistics=1 and hidden=0 '#10 ;
  s := s + '					WHERE rr2.Departure=pdd.date AND rr2.Status='+_db(STATUS_ARRIVED)+') AS departingRooms, '#10 ;
  s := s + '				(SELECT COUNT(rr2.id) FROM roomreservations rr2 '#10 ;
  s := s + '					JOIN rooms r on r.room=rr2.room and r.wildcard=0 and r.active=1 and statistics=1 and hidden=0 '#10 ;
  s := s + '           WHERE rr2.Departure=pdd.date AND rr2.Status='+_db(STATUS_CHECKED_OUT)+') AS departedRooms, '#10 ;
  s := s + '				(SELECT COUNT(rd2.id) FROM roomsdate rd2 '#10 ;
  s := s + '					JOIN rooms r on r.room=rd2.room and r.wildcard=0 and r.active=1 and statistics=1 and hidden=0 '#10 ;
  s := s + '					WHERE ADate=pdd.date AND ResFlag='+_db(STATUS_ARRIVED)+') AS occupiedRooms, '#10 ;
  s := s + '				(SELECT COUNT(id) FROM rooms WHERE hidden=0 AND Active=1 AND Statistics=1 AND wildCard=0) AS totalRooms, '#10 ;
  s := s + '				SUM((SELECT COUNT(id) FROM persons WHERE RoomReservation=rd.RoomReservation)) AS totalGuests '#10 ;
  s := s + '		 FROM predefineddates pdd '#10 ;
  s := s + '		 JOIN roomsdate rd on pdd.date=rd.ADate AND (NOT rd.ResFlag IN ('+_db(STATUS_DELETED)+','+_db(STATUS_CANCELLED)+','+_db(STATUS_OPTIONAL)+','+_db(STATUS_NO_SHOW)+','+_db(STATUS_BLOCKED)+')) '#10 ;
  s := s + '		 JOIN currencies curr on curr.Currency=rd.Currency '#10 ;
//  s := s + '		 JOIN rooms r on rd.room = r.room and r.wildcard=0 and r.active=1 and statistics=1 and hidden=0 '#10 ;
  s := s + '		 WHERE '#10 ;
  s := s + '				((pdd.date>='+_DateToDbDate(zDateFrom,true)+' AND pdd.date<='+_DateToDbDate(zDateTo,true)+')) '#10 ;
  s := s + '		    AND (SUBSTR(rd.room, 1, 1) = ''<'' OR NOT ISNULL((SELECT 1 FROM rooms r WHERE r.room=rd.room and r.wildcard=0 and r.active=1 and statistics=1 and hidden=0 LIMIT 1))) '#10 ;
  s := s + '		 GROUP BY pdd.date '#10 ;
  s := s + '		 ORDER BY pdd.date '#10 ;
  s := s + '		 ) baseData1 '#10 ;
  s := s + '	UNION '#10 ;
  s := s + '	 SELECT baseData2.*, '#10 ;
  s := s + '			CAST(0.00 AS DECIMAL) AS occ, '#10 ;
  s := s + '			CAST(0.00 AS DECIMAL) AS adr, '#10 ;
  s := s + '			CAST(0.00 AS DECIMAL) AS revPar '#10 ;
  s := s + '	 FROM ( '#10 ;
  s := s + '		 SELECT DATE(pdd.date) AS ADate, '#10 ;
  s := s + '				CAST(0 AS SIGNED) AS soldRooms, '#10 ;
  s := s + '				CAST(0.00 AS DECIMAL) AS revenue, '#10 ;
  s := s + '				CAST(0.00 AS DECIMAL) AS totalDiscount, '#10 ;
  s := s + '				CAST(0.00 AS DECIMAL) AS maxRate, '#10 ;
  s := s + '				CAST(0.00 AS DECIMAL) AS minRate, '#10 ;
  s := s + '				CAST(0.00 AS DECIMAL) AS averageRate, '#10 ;
  s := s + '				CAST(0 AS SIGNED) AS checkedInToday, '#10 ;
  s := s + '				CAST(0 AS SIGNED) AS arrivingRooms, '#10 ;
  s := s + '				(SELECT COUNT(rr2.id) FROM roomreservations rr2 '#10 ;
//  s := s + '					JOIN rooms r on r.room=rr2.room and r.wildcard=0 and r.active=1 and statistics=1 and hidden=0 '#10 ;
  s := s + '                    WHERE rr2.Arrival=DATE_ADD(pdd.date,INTERVAL -1 DAY) AND rr2.Status='+_db(STATUS_NO_SHOW)+') AS noShow, '#10 ;
  s := s + '				(SELECT COUNT(rr2.id) FROM roomreservations rr2 '#10 ;
  s := s + '					JOIN rooms r on r.room=rr2.room and r.wildcard=0 and r.active=1 and statistics=1 and hidden=0 '#10 ;
  s := s + '                    WHERE rr2.Departure=pdd.date AND rr2.Status='+_db(STATUS_ARRIVED)+') AS departingRooms, '#10 ;
  s := s + '				(SELECT COUNT(rr2.id) FROM roomreservations rr2 '#10 ;
  s := s + '					JOIN rooms r on r.room=rr2.room and r.wildcard=0 and r.active=1 and statistics=1 and hidden=0 '#10 ;
  s := s + '                    WHERE rr2.Departure=pdd.date AND rr2.Status='+_db(STATUS_CHECKED_OUT)+') AS departedRooms, '#10 ;
  s := s + '				CAST(0 AS SIGNED) AS occupiedRooms, '#10 ;
  s := s + '				(SELECT COUNT(id) FROM rooms WHERE hidden=0 AND Active=1 AND Statistics=1 AND wildCard=0) AS totalRooms, '#10 ;
  s := s + '				CAST(0 AS SIGNED) AS totalGuests '#10 ;
  s := s + '		 FROM predefineddates pdd '#10 ;
  s := s + '		 WHERE '#10 ;
  s := s + '				((pdd.date>='+_DateToDbDate(zDateFrom,true)+' AND pdd.date<='+_DateToDbDate(zDateTo,true)+')) '#10 ;
  s := s + '		 AND ISNULL((SELECT id FROM roomsdate WHERE ADate=pdd.date AND NOT(ResFlag IN ('+_db(STATUS_DELETED)+','+_db(STATUS_CANCELLED)+')) LIMIT 1)) '#10 ;
  s := s + '		 GROUP BY pdd.date '#10 ;
  s := s + '		 ORDER BY pdd.date '#10 ;
  s := s + '		 ) baseData2 '#10 ;
  s := s + '	) AllData '#10 ;
  s := s + ' on DATE(pd.date) = AllData.aDate '#10 ;
  s := s + ' WHERE '#10 ;
  s := s + '	((pd.date>='+_DateToDbDate(zDateFrom,true)+' AND pd.date<='+_DateToDbDate(zDateTo,true)+')) '#10 ;
  s := s + ' ORDER BY date ';

    ExecutionPlan.AddQuery(s);
    CopyToClipboard(s);
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
  finally
    ExecutionPlan.Free;
  end;



end;

procedure TfrmRptManagment.btnReportClick(Sender: TObject);
begin

  kbmStatReport.LoadFromDataSet(kbmStat, []);

  if frmRptbViewer <> nil then
    freeandNil(frmRptbViewer);
  frmRptbViewer := TfrmRptbViewer.Create(nil);
  try
    screen.Cursor := crHourglass;
    try
      frmRptbViewer.ppViewer1.Reset;
      frmRptbViewer.ppViewer1.Report := rptStats;
      frmRptbViewer.ppViewer1.GotoPage(1);
      rptStats.PrintToDevices;
    finally
      screen.Cursor := crDefault;
    end;

    frmRptbViewer.showmodal;

  finally
    FreeAndNil(frmRptbViewer);
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
  lastDay := DaysInMonth(y, m);
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
  _restoreForm(self);
  showdata;
end;

procedure TfrmRptManagment.sButton2Click(Sender: TObject);
var
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

