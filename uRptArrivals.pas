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
  dxStatusBar, cxGridDBTableView, Vcl.Grids, Vcl.DBGrids, Vcl.Menus;

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
    PopupMenu1: TPopupMenu;
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
    PopupMenu2: TPopupMenu;
    C1: TMenuItem;
    P1: TMenuItem;
    I1: TMenuItem;
    R2: TMenuItem;
    G2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure rbRadioButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure kbmArrivalsListAfterScroll(DataSet: TDataSet);
    procedure btnCheckInClick(Sender: TObject);
    procedure R1Click(Sender: TObject);
    procedure btnProfileClick(Sender: TObject);
    procedure G1Click(Sender: TObject);
    procedure grArrivalsListDBTableView1CellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure dtDateFromCloseUp(Sender: TObject);
    procedure dtDateToCloseUp(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateControls;
    procedure SetManualDates(aFrom, aTo: TDate);
    procedure RefreshData;
    function ConstructSQL: string;
    procedure WndProc(var message: TMessage); override;
  public
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
          '  rr.AvrageRate AS AverageRoomRate, '+
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
var s : String;
    Room : String;
    Reservation, RoomReservation : Integer;
    NoRoom, bContinue : Boolean;
begin
  Room := kbmArrivalsList['Room'];
  NoRoom := Copy(Room, 1, 1) = '<';
  Reservation := kbmArrivalsList['RoomerReservationID'];
  RoomReservation := kbmArrivalsList['RoomerRoomReservationID'];
  s := g.oRooms.FindRoomStatus(Room);
  if g.qWarnCheckInDirtyRoom AND (NOT ((s = 'R') OR (s = 'C'))) then begin
    s := format(getTranslatedText('shTx_Various_RoomNotClean'), [Room]);
    if MessageDlg(s, mtWarning, [mbYes, mbCancel], 0) <> mrYes then exit;
  end;

  if ctrlGetBoolean('CheckinWithDetailsDialog') OR (MessageDlg(Format(GetTranslatedText('shCheckRoom'), [kbmArrivalsList['GuestName']]), mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin

    ShowAlertsForReservation(Reservation, RoomReservation, atCHECK_IN);

    bContinue := true;
    if NoRoom then
    begin
      Room := ProvideARoom2(RoomReservation);
      bContinue := Room <> '';
    end;

    if bContinue then
    begin
      if (NOT ctrlGetBoolean('CheckinWithDetailsDialog')) OR OpenGuestCheckInForm(RoomReservation) then
        d.CheckInGuest(RoomReservation);
      postMessage(handle, WM_REFRESH_DATA, 0, 0);
    end;
  end
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

procedure TfrmArrivalsReport.G1Click(Sender: TObject);
begin
  EditInvoice(kbmArrivalsList['RoomerReservationID'], 0, 0, 0, 0, 0, false, true,false);
end;

procedure TfrmArrivalsReport.grArrivalsListDBTableView1CellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  btnProfile.Click;
end;

procedure TfrmArrivalsReport.kbmArrivalsListAfterScroll(DataSet: TDataSet);
begin
  btnCheckIn.Enabled := NOT kbmArrivalsList.Eof; // (kbmArrivalsList.RecordCount = 1) OR NOT (kbmArrivalsList.Eof OR kbmArrivalsList.Bof);
  btnProfile.Enabled := NOT kbmArrivalsList.Eof; // (kbmArrivalsList.RecordCount = 1) OR NOT (kbmArrivalsList.Eof OR kbmArrivalsList.Bof);
  btnInvoice.Enabled := NOT kbmArrivalsList.Eof; // (kbmArrivalsList.RecordCount = 1) OR NOT (kbmArrivalsList.Eof OR kbmArrivalsList.Bof);
end;

procedure TfrmArrivalsReport.R1Click(Sender: TObject);
begin
  EditInvoice(kbmArrivalsList['RoomerReservationID'], kbmArrivalsList['RoomerRoomReservationID'], 0, 0, 0, 0, false, true,false);
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
      rSet1 := CreateNewDataSet;
      try
        s := ConstructSQL;

        hData.rSet_bySQL(rSet1, s);
        rSet1.First;
        if kbmArrivalsList.Active then kbmArrivalsList.Close;
        kbmArrivalsList.open;
        LoadKbmMemtableFromDataSetQuiet(kbmArrivalsList,rSet1,[]);
      finally
        FreeAndNil(rSet1);
      end;
    finally
      kbmArrivalsList.EnableControls;
    end;
    kbmArrivalsList.First;
  finally
    btnRefresh.Enabled := True;
    Screen.Cursor := crDefault;
  end;
  kbmArrivalsListAfterScroll(nil);
end;

procedure TfrmArrivalsReport.SetManualDates(aFrom, aTo: TDate);
begin
  dtDateFrom.Date := aFrom;
  dtDateTo.Date := aTo;
end;

procedure TfrmArrivalsReport.UpdateControls;
begin
  dtDateFrom.Enabled := rbManualRange.Checked;
  dtDateTo.Enabled := rbManualRange.Checked;

  if rbToday.Checked then
    SetManualDates(Now, now)
  else if rbTomorrow.Checked then
    SetManualDates(Now+1, Now+1);
end;

procedure TfrmArrivalsReport.WndProc(var message: TMessage);
begin
  if message.Msg = WM_REFRESH_DATA then
    RefreshData;
  inherited WndProc(message);
end;

end.
