unit uRptStockItems;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkSide, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinsdxStatusBarPainter,
  cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData,
  cxTimeEdit, Vcl.Menus, ppParameter, ppDesignLayer, ppVar, ppBands, ppCtrls, ppPrnabl, ppClass, ppCache, ppProd,
  ppReport, ppComm, ppRelatv, ppDB, ppDBPipe, cxClasses, kbmMemTable, cxPropertiesStore, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGrid, dxStatusBar, Vcl.StdCtrls,
  Vcl.Mask, sMaskEdit, sCustomComboEdit, sToolEdit, sRadioButton, sGroupBox, sButton, Vcl.ExtCtrls, sPanel,
  cxGridBandedTableView, cxGridDBBandedTableView;

type
  TfrmRptStockItems = class(TForm)
    pnlFilter: TsPanel;
    btnRefresh: TsButton;
    gbxSelectDates: TsGroupBox;
    rbToday: TsRadioButton;
    rbTomorrow: TsRadioButton;
    rbManualRange: TsRadioButton;
    dtDateFrom: TsDateEdit;
    dtDateTo: TsDateEdit;
    pnlExportButtons: TsPanel;
    btnExcel: TsButton;
    btnProfile: TsButton;
    btnReport: TsButton;
    dxStatusBar: TdxStatusBar;
    grStockItems: TcxGrid;
    lvStockitemsLevel1: TcxGridLevel;
    FormStore: TcxPropertiesStore;
    kbmStockItems: TkbmMemTable;
    dsStockitems: TDataSource;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    plStockItems: TppDBPipeline;
    rtpStockitems: TppReport;
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
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel7: TppLabel;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppDetailBand1: TppDetailBand;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppFooterBand1: TppFooterBand;
    ppSystemVariable1: TppSystemVariable;
    ppLabel8: TppLabel;
    ppLine2: TppLine;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppParameterList1: TppParameterList;
    kbmStockitemsReport: TkbmMemTable;
    dsStockitemsReport: TDataSource;
    grStockItemsLevel1: TcxGridLevel;
    grStockItemsDBBandedTableView1: TcxGridDBBandedTableView;
    grStockItemsDBTableView1: TcxGridDBTableView;
    grStockItemsDBTableView1Column1: TcxGridDBColumn;
  private
    procedure btnExcelClick(Sender: TObject);
    procedure btnProfileClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnReportClick(Sender: TObject);
    function ConstructSQL: string;
    procedure dtDateFromCloseUp(Sender: TObject);
    procedure dtDateToCloseUp(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure grArrivalsListDBTableView1CellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure grArrivalsListDBTableView1ExpectedTimeOfArrivalGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure kbmStockItemsAfterScroll(DataSet: TDataSet);
    procedure ppHeaderBand1BeforePrint(Sender: TObject);
    procedure rbRadioButtonClick(Sender: TObject);
    procedure RefreshData;
    procedure SetManualDates(aFrom, aTo: TDate);
    procedure UpdateControls;
    procedure WndProc(var message: TMessage);
    { Private declarations }
  public
    constructor Create(aOwner: TComponent);
    destructor Destroy; override;
    { Public declarations }
  end;

/// <summary>
///   Global access point for showing the StockItemsreport form, If Modalresult is OK then True is returned
/// </summary>
function ShowStockItemsReport: boolean;

implementation

{$R *.dfm}

uses
    uRoomerLanguage
  , uAppGlobal
  , uG
  , uUtils
  , cxGridExportLink
  , ShellApi
  , cmpRoomerDataset
  , uD
  , PrjConst
  , hData
  , uAlerts
  , uReservationProfile
  , uRptbViewer
  ;

const
  cSQL = 'SELECT '+
          '  co.CompanyID, ' +
          '  rd.Room, '+
          '  rd.RoomType, '+
          '  r.Reservation AS RoomerReservationId, '+
          '  rd.RoomReservation AS RoomerRoomReservationId, '+
          '  pe.Name AS GuestName, '+
          '  r.Customer AS CompanyCode, '+
          '  r.Name AS CompanyName, '+
          '  CAST(rr.AvrageRate as DECIMAL(10,3)) AS AverageRoomRate, '+
          '  ( SELECT cast(rd1.ADate as date)'+
          '         FROM roomsdate rd1 '+
          '         WHERE rd1.RoomReservation=rd.RoomReservation '+
          '               AND (rd1.ResFlag = ''P'') '+
          '         ORDER BY rd1.ADate LIMIT 1) AS Arrival, '+
          '  Cast(DATE_ADD((SELECT rd1.ADate '+
          '              FROM roomsdate rd1 '+
          '              WHERE rd1.RoomReservation=rd.RoomReservation AND (rd1.ResFlag = ''P'') '+
          '              ORDER BY rd1.ADate DESC LIMIT 1), '+
          '            INTERVAL 1 DAY) as Date) AS Departure, '+
          '  ( SELECT COUNT(id) '+
          '    FROM persons pe1 '+
          '    WHERE pe1.RoomReservation=rd.RoomReservation) AS NumGuests, '+
          '  rr.ExpectedTimeOfArrival as ExpectedTimeOfArrival '+
          'FROM roomsdate rd '+
          'JOIN roomreservations rr ON rr.RoomReservation=rd.RoomReservation '+
          'JOIN reservations r ON r.Reservation=rd.Reservation '+
          'JOIN persons pe ON pe.RoomReservation=rd.RoomReservation AND pe.MainName=1 '+
          'JOIN channels ch ON ch.Id=r.Channel, '+
          'control co '+
          'WHERE ( SELECT rd1.ADate '+
          '        FROM roomsdate rd1 '+
          '        WHERE rd1.RoomReservation=rd.RoomReservation AND (rd1.ResFlag = ''P'') '+
          '        ORDER BY rd1.ADate LIMIT 1)=rd.ADate '+
          '      AND (rd.ResFlag = ''P'') '+
          '      %s '+
          'GROUP BY rd.aDate, rd.RoomReservation '+
          'ORDER BY rd.aDate, rd.Room ';

  cSqlForSingleDate = '      AND rd.ADate = ''%s'' ';
  cSqlForDateRange = '      AND rd.ADate >= ''%s'' AND rd.ADate <= ''%s'' ';

  WM_REFRESH_DATA = WM_User + 51;


function ShowStockItemsReport: boolean;
var
  frm: TfrmRptStockItems;
begin
  frm := TfrmRptStockItems.Create(nil);
  try
    frm.ShowModal;
    Result := (frm.modalresult = mrOk);
  finally
    frm.Free;
  end;
end;

procedure TfrmRptStockItems.btnExcelClick(Sender: TObject);
var
  sFilename : string;
  s         : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_StockitemsList';
  ExportGridToExcel(sFilename, grArrivalsList, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmRptStockItems.btnProfileClick(Sender: TObject);
begin
  if EditReservation(kbmStockitems['RoomerReservationID'], kbmStockitems['RoomerRoomReservationID']) then
    postMessage(handle, WM_REFRESH_DATA, 0, 0);
end;

procedure TfrmRptStockItems.btnRefreshClick(Sender: TObject);
begin
  postMessage(handle, WM_REFRESH_DATA, 0, 0);
end;

procedure TfrmRptStockItems.btnReportClick(Sender: TObject);
begin

  kbmStockItemsReport.LoadFromDataSet(kbmStockItems, []);

  if frmRptbViewer <> nil then
    freeandNil(frmRptbViewer);
  frmRptbViewer := TfrmRptbViewer.Create(frmRptbViewer);
  try
    screen.Cursor := crHourglass;
    try
      frmRptbViewer.ppViewer1.Reset;
      frmRptbViewer.ppViewer1.Report := rptStockitems;
      frmRptbViewer.ppViewer1.GotoPage(1);
      rptStockItems.PrintToDevices;
    finally
      screen.Cursor := crDefault;
    end;

    frmRptbViewer.showmodal;

  finally
    FreeAndNil(frmRptbViewer);
  end;
end;

function TfrmRptStockItems.ConstructSQL: string;
var s : String;
begin
  if rbToday.Checked OR rbTomorrow.Checked then
    s := Format(cSqlForSingleDate, [FormatDateTime('yyyy-mm-dd', dtDateFrom.Date)])
  else
    s := Format(cSqlForDateRange, [FormatDateTime('yyyy-mm-dd', dtDateFrom.Date),
                                   FormatDateTime('yyyy-mm-dd', dtDateTo.Date)]);
  Result := Format(cSQL, [s]);
  {$ifdef DEBUG}
    CopyToClipboard(Result);
  {$endif}
end;

constructor TfrmRptStockItems.Create(aOwner: TComponent);
begin
  FCurrencyhandler := TCurrencyHandler.Create(g.qNativeCurrency);
  inherited;
end;

destructor TfrmRptStockItems.Destroy;
begin
  inherited;
  FCurrencyhandler.Free;
end;

procedure TfrmRptStockItems.dtDateFromCloseUp(Sender: TObject);
begin
 if dtDateFrom.Date > dtDateTo.Date then
   dtDateTo.Date := dtDateFrom.Date;
end;

procedure TfrmRptStockItems.dtDateToCloseUp(Sender: TObject);
begin
 if dtDateFrom.Date > dtDateTo.Date then
   dtDateFrom.Date := dtDateTo.Date;
end;

procedure TfrmRptStockItems.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
end;

procedure TfrmRptStockItems.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmRptStockItems.FormShow(Sender: TObject);
begin
  UpdateControls;
  postMessage(handle, WM_REFRESH_DATA, 0, 0);
end;

procedure TfrmRptStockItems.grArrivalsListDBTableView1CellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  btnProfile.Click;
end;

procedure TfrmRptStockItems.grArrivalsListDBTableView1ExpectedTimeOfArrivalGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
var
  lTime: TDateTime;
begin
  if not aText.IsEmpty and TryStrToTime(aText, lTime) then
    DateTimeToString(aText, FormatSettings.ShortTimeFormat, StrTodateTime(aText));

end;

procedure TfrmRptStockItems.kbmStockItemsAfterScroll(DataSet: TDataSet);
begin
  UpdateControls;
end;

procedure TfrmRptStockItems.ppHeaderBand1BeforePrint(Sender: TObject);
var
  s : string;
begin

  rlabFrom.Caption := DateToStr(dtDateFrom.Date);
  rlabTo.Caption := DateToStr(dtDateTo.Date);

  s := g.qHotelName;
  rLabHotelName.Caption := s;

  s := DateTimeToStr(now);
  // s := 'Created : ' + s;
  s := GetTranslatedText('shTx_NationalReport_Created') + s;
  rLabTimeCreated.Caption := s;

  // s := 'User : ' + g.qUser;
  s := GetTranslatedText('shTx_NationalReport_User') + g.qUser;
  if g.qusername <> '' then
    s := s + ' - ' + g.qusername;
  rlabUser.Caption := s;
end;

procedure TfrmRptStockItems.rbRadioButtonClick(Sender: TObject);
begin
  UpdateControls;
end;

procedure TfrmRptStockItems.RefreshData;
var
  s    : string;
  rset1: TRoomerDataset;
begin
  if NOT btnRefresh.Enabled then exit;

  btnRefresh.Enabled := False;
  Screen.Cursor := crHourglass;
  try

    kbmStockitems.DisableControls;
    try
      FRefreshingdata := True; // UpdateControls still called when updating dataset, despite DisableControls
      rSet1 := CreateNewDataSet;
      try
        s := ConstructSQL;

        hData.rSet_bySQL(rSet1, s);
        rSet1.First;
        if not kbmStockItems.Active then
          kbmStockItems.Open;
        LoadKbmMemtableFromDataSetQuiet(kbmStockitems,rSet1,[]);
      finally
        FreeAndNil(rSet1);
      end;

      kbmStockitems.First;

    finally
      FRefreshingdata := False;
      kbmArrivalsList.EnableControls;
    end;
  finally
    btnRefresh.Enabled := True;
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmRptStockItems.SetManualDates(aFrom, aTo: TDate);
begin
  dtDateFrom.Date := aFrom;
  dtDateTo.Date := aTo;
end;

procedure TfrmRptStockItems.UpdateControls;
var
  lDataAvailable: boolean;
begin
  if FRefreshingData then
    Exit;

  dtDateFrom.Enabled := rbManualRange.Checked;
  dtDateTo.Enabled := rbManualRange.Checked;

  if rbToday.Checked then
    SetManualDates(Now, now)
  else if rbTomorrow.Checked then
    SetManualDates(Now+1, Now+1);

  lDataAvailable := kbmStockitems.Active and NOT kbmStockitems.Eof;
  btnProfile.Enabled := lDataAvailable;
end;

procedure TfrmRptStockItems.WndProc(var message: TMessage);
begin
  if message.Msg = WM_REFRESH_DATA then
    RefreshData;
  inherited WndProc(message);
end;
end.
