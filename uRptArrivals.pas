unit uRptArrivals;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, kbmMemTable, cxClasses, cxPropertiesStore, Vcl.StdCtrls, sRadioButton,
  sLabel, Vcl.Mask, sMaskEdit, sCustomComboEdit, sToolEdit, sGroupBox, sButton, Vcl.ExtCtrls, sPanel,
  uDImages, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkSide, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinsdxStatusBarPainter, cxStyles,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView, cxGridDBBandedTableView, cxGridCustomView, cxGrid,
  dxStatusBar, cxGridDBTableView, Vcl.Grids, Vcl.DBGrids;

type
  TfrmArrivalsReport = class(TForm)
    FormStore: TcxPropertiesStore;
    kbmArrivalsList: TkbmMemTable;
    ArrivalsListDS: TDataSource;
    pnlFilter: TsPanel;
    btnRefresh: TsButton;
    gbxSelectDates: TsGroupBox;
    pnlLocations: TsPanel;
    labLocations: TsLabel;
    labLocationsList: TsLabel;
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
    grArrivalsListDBTableView1Room: TcxGridDBColumn;
    grArrivalsListDBTableView1Roomtype: TcxGridDBColumn;
    grArrivalsListDBTableView1RoomerReservationID: TcxGridDBColumn;
    grArrivalsListDBTableView1GuestName: TcxGridDBColumn;
    grArrivalsListDBTableView1CompanyCode: TcxGridDBColumn;
    grArrivalsListDBTableView1Arrival: TcxGridDBColumn;
    grArrivalsListDBTableView1Departure: TcxGridDBColumn;
    grArrivalsListDBTableView1NumGuests: TcxGridDBColumn;
    kbmArrivalsListAverageRoomRate: TFloatField;
    grArrivalsListDBTableView1AverageRoomRate: TcxGridDBColumn;
    kbmArrivalsListExpectedTimeOfArrival: TStringField;
    grArrivalsListDBTableView1ExpectedTimeOfArrival: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure rbRadioButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateControls;
    procedure SetManualDates(aFrom, aTo: TDate);
    procedure RefreshData;
    function ConstructSQL: string;
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
  ;

const
  cSQL = 'SELECT '+
          '  co.CompanyID, ' +
          '  rd.Room, '+
          '  rd.RoomType, '+
          '  r.Reservation AS RoomerReservationId, '+
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
          '      AND rd.ADate >= ''%s'' AND rd.ADate <= ''%s'' '+
          'GROUP BY rd.aDate, rd.RoomReservation '+
          'ORDER BY rd.aDate, rd.Room ';


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

procedure TfrmArrivalsReport.btnRefreshClick(Sender: TObject);
begin
  RefreshData;
end;

function TfrmArrivalsReport.ConstructSQL: string;
begin
  Result := Format(cSQL, [FormatDateTime('yyyy-mm-dd', dtDateFrom.Date),
                          FormatDateTime('yyyy-mm-dd', dtDateTo.Date)]);
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
  RefreshData;
end;

procedure TfrmArrivalsReport.rbRadioButtonClick(Sender: TObject);
begin
  UpdateControls;
end;

procedure TfrmArrivalsReport.RefreshData;
var
  s    : string;
  rset1: TRoomerDataset;
  ExecutionPlan : TRoomerExecutionPlan;
begin
  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  try
    s := ConstructSQL;

    ExecutionPlan.AddQuery(s);

    screen.Cursor := crHourGlass;
    kbmArrivalsList.DisableControls;
    try
      ExecutionPlan.Execute(ptQuery);

      rSet1 := ExecutionPlan.Results[0];

      if kbmArrivalsList.Active then kbmArrivalsList.Close;
      kbmArrivalsList.open;
      LoadKbmMemtableFromDataSetQuiet(kbmArrivalsList,rSet1,[]);
      kbmArrivalsList.First;

    finally
      screen.cursor := crDefault;
      kbmArrivalsList.EnableControls;
    end;

  finally
    ExecutionPlan.Free;
  end;

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

end.
