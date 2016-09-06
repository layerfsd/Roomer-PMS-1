unit uRptArrivals;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, kbmMemTable, cxClasses, cxPropertiesStore, Vcl.StdCtrls, sRadioButton,
  acPNG, sLabel, Vcl.Mask, sMaskEdit, sCustomComboEdit, sToolEdit, sGroupBox, sButton, Vcl.ExtCtrls, sPanel,
  uDImages, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkSide, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinsdxStatusBarPainter, cxStyles,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView, cxGridDBBandedTableView, cxGridCustomView, cxGrid,
  dxStatusBar, cxGridDBTableView, Vcl.Grids, Vcl.DBGrids, Vcl.Menus, cxTimeEdit, ppParameter, ppDesignLayer, ppCtrls,
  ppBands, ppVar, ppPrnabl, ppClass, ppCache, ppProd, ppReport, ppDB, ppComm, ppRelatv, ppDBPipe
  , uCurrencyHandler
  ;

type
  TfrmArrivalsReport = class(TForm)
    FormStore: TcxPropertiesStore;
    kbmArrivalsList: TkbmMemTable;
    ArrivalsListDS: TDataSource;
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
    dxStatusBar: TdxStatusBar;
    grArrivalsList: TcxGrid;
    lvArrivalsListLevel1: TcxGridLevel;
    grArrivalsListDBTableView1: TcxGridDBTableView;
    kbmArrivalsListfldRoom: TStringField;
    kbmArrivalsListfldRoomtype: TStringField;
    kbmArrivalsListfldRoomerReservationID: TIntegerField;
    kbmArrivalsListfldGuestName: TStringField;
    kbmArrivalsListfldCompanyCode: TStringField;
    kbmArrivalsListfldArrival: TDateField;
    kbmArrivalsListfldDeparture: TDateField;
    kbmArrivalsListfldNumGuests: TIntegerField;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    kbmArrivalsListAverageRoomRate: TFloatField;
    kbmArrivalsListExpectedTimeOfArrival: TStringField;
    btnCheckIn: TsButton;
    btnProfile: TsButton;
    btnInvoice: TsButton;
    pmnuInvoiceMenu: TPopupMenu;
    R1: TMenuItem;
    G1: TMenuItem;
    grArrivalsListDBTableView1Room: TcxGridDBColumn;
    grArrivalsListDBTableView1Roomtype: TcxGridDBColumn;
    grArrivalsListDBTableView1RoomerReservationID: TcxGridDBColumn;
    grArrivalsListDBTableView1GuestName: TcxGridDBColumn;
    grArrivalsListDBTableView1CompanyCode: TcxGridDBColumn;
    grArrivalsListDBTableView1Arrival: TcxGridDBColumn;
    grArrivalsListDBTableView1Departure: TcxGridDBColumn;
    grArrivalsListDBTableView1NumGuests: TcxGridDBColumn;
    grArrivalsListDBTableView1AverageRoomRate: TcxGridDBColumn;
    grArrivalsListDBTableView1ExpectedTimeOfArrival: TcxGridDBColumn;
    kbmArrivalsListRoomerRoomReservationID: TIntegerField;
    grArrivalsListDBTableView1RoomerRoomReservationID: TcxGridDBColumn;
    pnmuGridMenu: TPopupMenu;
    mnuCheckin: TMenuItem;
    mnuProfile: TMenuItem;
    mnuInvoice: TMenuItem;
    mnuRoomInvoice: TMenuItem;
    mnuGroupInvoice: TMenuItem;
    plArrivalsList: TppDBPipeline;
    rptArrivals: TppReport;
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
    ppLine2: TppLine;
    ppFooterBand1: TppFooterBand;
    ppSystemVariable1: TppSystemVariable;
    ppLabel8: TppLabel;
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
    kbmArrivalsReport: TkbmMemTable;
    StringField1: TStringField;
    StringField2: TStringField;
    IntegerField1: TIntegerField;
    StringField3: TStringField;
    StringField4: TStringField;
    DateField1: TDateField;
    DateField2: TDateField;
    IntegerField2: TIntegerField;
    FloatField1: TFloatField;
    StringField5: TStringField;
    IntegerField3: TIntegerField;
    dsArrivalsReport: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure rbRadioButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure kbmArrivalsListAfterScroll(DataSet: TDataSet);
    procedure btnCheckInClick(Sender: TObject);
    procedure mnuRoomInvoiceClick(Sender: TObject);
    procedure btnProfileClick(Sender: TObject);
    procedure mnuGroupInvoiceClick(Sender: TObject);
    procedure grArrivalsListDBTableView1CellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure dtDateFromCloseUp(Sender: TObject);
    procedure dtDateToCloseUp(Sender: TObject);
    procedure grArrivalsListDBTableView1ExpectedTimeOfArrivalGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure btnReportClick(Sender: TObject);
    procedure ppHeaderBand1BeforePrint(Sender: TObject);
    procedure grArrivalsListDBTableView1AverageRoomRateGetProperties(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
  private
    FRefreshingdata: boolean;
    FCurrencyhandler: TCurrencyHandler;
    { Private declarations }
    procedure UpdateControls;
    procedure SetManualDates(aFrom, aTo: TDate);
    procedure RefreshData;
    function ConstructSQL: string;
  protected
    procedure WndProc(var message: TMessage); override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    { Public declarations }
  end;


/// <summary>
///   Global access point for showing the arrival report form, If Modalresult is OK then True is returned
/// </summary>
function ShowArrivalsReport: boolean;

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
  , uProvideARoom2
  , uGuestCheckInForm
  , uInvoice
  , uReservationProfile
  , uRptbViewer
  , uReservationStateChangeHandler, uReservationStatusDefinitions;

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


function ShowArrivalsReport: boolean;
var
  frm: TfrmArrivalsReport;
begin
  frm := TfrmArrivalsReport.Create(nil);
  try
    frm.ShowModal;
    Result := (frm.modalresult = mrOk);
  finally
    frm.Free;
  end;
end;

procedure TfrmArrivalsReport.btnCheckInClick(Sender: TObject);
var
  lStateChangeHandler: TRoomReservationStateChangeHandler;
begin

  lStateChangeHandler := TRoomReservationStateChangeHandler.Create(kbmArrivalsList['RoomerReservationID'], kbmArrivalsList['RoomerRoomReservationID']);
  try
    if lStateChangeHandler.ChangeState(rsGuests) then
       PostMessage(handle, WM_REFRESH_DATA, 0, 0);
  finally
    lStateChangeHandler.Free;
  end;

end;

procedure TfrmArrivalsReport.btnExcelClick(Sender: TObject);
var
  sFilename : string;
  s         : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_ArrivalsList';
  ExportGridToExcel(sFilename, grArrivalsList, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmArrivalsReport.btnProfileClick(Sender: TObject);
begin
  if EditReservation(kbmArrivalsList['RoomerReservationID'], kbmArrivalsList['RoomerRoomReservationID']) then
    postMessage(handle, WM_REFRESH_DATA, 0, 0);
end;

procedure TfrmArrivalsReport.btnRefreshClick(Sender: TObject);
begin
  postMessage(handle, WM_REFRESH_DATA, 0, 0);
end;

procedure TfrmArrivalsReport.btnReportClick(Sender: TObject);
begin

  kbmArrivalsReport.LoadFromDataSet(kbmArrivalsList, []);

  if frmRptbViewer <> nil then
    freeandNil(frmRptbViewer);
  frmRptbViewer := TfrmRptbViewer.Create(frmRptbViewer);
  try
    screen.Cursor := crHourglass;
    try
      frmRptbViewer.ppViewer1.Reset;
      frmRptbViewer.ppViewer1.Report := rptArrivals;
      frmRptbViewer.ppViewer1.GotoPage(1);
      rptArrivals.PrintToDevices;
    finally
      screen.Cursor := crDefault;
    end;

    frmRptbViewer.showmodal;

  finally
    FreeAndNil(frmRptbViewer);
  end;
end;

function TfrmArrivalsReport.ConstructSQL: string;
var s : String;
begin
  if rbToday.Checked OR rbTomorrow.Checked then
    s := Format(cSqlForSingleDate, [FormatDateTime('yyyy-mm-dd', dtDateFrom.Date)])
  else
    s := Format(cSqlForDateRange, [FormatDateTime('yyyy-mm-dd', dtDateFrom.Date),
                                   FormatDateTime('yyyy-mm-dd', dtDateTo.Date)]);
  Result := Format(cSQL, [s]);
  CopyToClipboard(Result);
end;

constructor TfrmArrivalsReport.Create(aOwner: TComponent);
begin
  FCurrencyhandler := TCurrencyHandler.Create(g.qNativeCurrency);
  inherited;
end;

destructor TfrmArrivalsReport.Destroy;
begin
  inherited;
  FCurrencyhandler.Free;
end;

procedure TfrmArrivalsReport.dtDateFromCloseUp(Sender: TObject);
begin
 if dtDateFrom.Date > dtDateTo.Date then
   dtDateTo.Date := dtDateFrom.Date;
end;

procedure TfrmArrivalsReport.dtDateToCloseUp(Sender: TObject);
begin
 if dtDateFrom.Date > dtDateTo.Date then
   dtDateFrom.Date := dtDateTo.Date;
end;

procedure TfrmArrivalsReport.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
end;

procedure TfrmArrivalsReport.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmArrivalsReport.FormShow(Sender: TObject);
begin
  UpdateControls;
  postMessage(handle, WM_REFRESH_DATA, 0, 0);
end;

procedure TfrmArrivalsReport.mnuGroupInvoiceClick(Sender: TObject);
begin
  EditInvoice(kbmArrivalsList['RoomerReservationID'], 0, 0, 0, 0, 0, false, true,false);
end;

procedure TfrmArrivalsReport.grArrivalsListDBTableView1AverageRoomRateGetProperties(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
begin
  AProperties := FCurrencyhandler.GetcxEditProperties;
end;

procedure TfrmArrivalsReport.grArrivalsListDBTableView1CellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  btnProfile.Click;
end;

procedure TfrmArrivalsReport.grArrivalsListDBTableView1ExpectedTimeOfArrivalGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
var
  lTime: TDateTime;
begin
  if not aText.IsEmpty and TryStrToTime(aText, lTime) then
    DateTimeToString(aText, FormatSettings.ShortTimeFormat, StrTodateTime(aText));

end;

procedure TfrmArrivalsReport.kbmArrivalsListAfterScroll(DataSet: TDataSet);
begin
  UpdateControls;
end;

procedure TfrmArrivalsReport.mnuRoomInvoiceClick(Sender: TObject);
begin
  EditInvoice(kbmArrivalsList['RoomerReservationID'], kbmArrivalsList['RoomerRoomReservationID'], 0, 0, 0, 0, false, true,false);
end;

procedure TfrmArrivalsReport.ppHeaderBand1BeforePrint(Sender: TObject);
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

procedure TfrmArrivalsReport.rbRadioButtonClick(Sender: TObject);
begin
  UpdateControls;
end;

procedure TfrmArrivalsReport.RefreshData;
var
  s    : string;
  rset1: TRoomerDataset;
begin
  if NOT btnRefresh.Enabled then exit;

  btnRefresh.Enabled := False;
  Screen.Cursor := crHourglass;
  try

    kbmArrivalsList.DisableControls;
    try
      FRefreshingdata := True; // UpdateControls still called when updating dataset, despite DisableControls
      rSet1 := CreateNewDataSet;
      try
        s := ConstructSQL;

        hData.rSet_bySQL(rSet1, s);
        rSet1.First;
        if not kbmArrivalsList.Active then
          kbmArrivalsList.Open;
        LoadKbmMemtableFromDataSetQuiet(kbmArrivalsList,rSet1,[]);
      finally
        FreeAndNil(rSet1);
      end;

      kbmArrivalsList.First;

    finally
      FRefreshingdata := False;
      kbmArrivalsList.EnableControls;
    end;
  finally
    btnRefresh.Enabled := True;
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmArrivalsReport.SetManualDates(aFrom, aTo: TDate);
begin
  dtDateFrom.Date := aFrom;
  dtDateTo.Date := aTo;
end;

procedure TfrmArrivalsReport.UpdateControls;
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

  lDataAvailable := kbmArrivalsList.Active and NOT kbmArrivalsList.Eof;
  btnCheckIn.Enabled := lDataAvailable;
  btnProfile.Enabled := lDataAvailable;
  btnInvoice.Enabled := lDataAvailable;
end;

procedure TfrmArrivalsReport.WndProc(var message: TMessage);
begin
  if message.Msg = WM_REFRESH_DATA then
    RefreshData;
  inherited WndProc(message);
end;

end.
