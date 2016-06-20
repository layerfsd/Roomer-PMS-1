unit uRptDepartures;

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
  TfrmDeparturesReport = class(TForm)
    FormStore: TcxPropertiesStore;
    kbmDeparturesList: TkbmMemTable;
    DeparturesListDS: TDataSource;
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
    grDeparturessList: TcxGrid;
    lvDeparturesListLevel1: TcxGridLevel;
    grDeparturessListDBTableView1: TcxGridDBTableView;
    kbmDeparturesListfldRoom: TStringField;
    kbmDeparturesListfldRoomtype: TStringField;
    kbmDeparturesListfldRoomerReservationID: TIntegerField;
    kbmDeparturesListfldGuestName: TStringField;
    kbmDeparturesListfldCompanyCode: TStringField;
    kbmDeparturesListfldArrival: TDateField;
    kbmDeparturesListfldDeparture: TDateField;
    kbmDeparturesListfldNumGuests: TIntegerField;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    kbmDeparturesListAverageRoomRate: TFloatField;
    kbmDeparturesListExpectedTimeOfArrival: TStringField;
    btnCheckIn: TsButton;
    btnProfile: TsButton;
    btnInvoice: TsButton;
    pmnuInvoiceMenu: TPopupMenu;
    R1: TMenuItem;
    G1: TMenuItem;
    grDeparturessListDBTableView1Room: TcxGridDBColumn;
    grDeparturessListDBTableView1Roomtype: TcxGridDBColumn;
    grDeparturessListDBTableView1RoomerReservationID: TcxGridDBColumn;
    grDeparturessListDBTableView1GuestName: TcxGridDBColumn;
    grDeparturessListDBTableView1CompanyCode: TcxGridDBColumn;
    grDeparturessListDBTableView1Arrival: TcxGridDBColumn;
    grDeparturessListDBTableView1Departure: TcxGridDBColumn;
    grDeparturessListDBTableView1NumGuests: TcxGridDBColumn;
    grDeparturessListDBTableView1AverageRoomRate: TcxGridDBColumn;
    grDeparturessListDBTableView1ExpectedTimeOfArrival: TcxGridDBColumn;
    kbmDeparturesListRoomerRoomReservationID: TIntegerField;
    grDeparturessListDBTableView1RoomerRoomReservationID: TcxGridDBColumn;
    pnmuGridMenu: TPopupMenu;
    mnuCheckin: TMenuItem;
    mnuProfile: TMenuItem;
    mnuInvoice: TMenuItem;
    mnuRoomInvoice: TMenuItem;
    mnuGroupInvoice: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure rbRadioButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure kbmDeparturesListAfterScroll(DataSet: TDataSet);
    procedure btnCheckInClick(Sender: TObject);
    procedure mnuRoomInvoiceClick(Sender: TObject);
    procedure btnProfileClick(Sender: TObject);
    procedure mnuGroupInvoiceClick(Sender: TObject);
    procedure grDeparturessListDBTableView1CellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure dtDateFromCloseUp(Sender: TObject);
    procedure dtDateToCloseUp(Sender: TObject);
  private
    FRefreshingdata: boolean;
    { Private declarations }
    procedure UpdateControls;
    procedure SetManualDates(aFrom, aTo: TDate);
    procedure RefreshData;
    function ConstructSQL: string;
  protected
    procedure WndProc(var message: TMessage); override;
  public
    { Public declarations }
  end;


/// <summary>
///   Global access point for showing the arrival report form, If Modalresult is OK then True is returned
/// </summary>
function ShowDeparturesReport: boolean;

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


sSQL =
'SELECT '+
'    CheckOutDate '+
'  , Reservation AS RoomerReservationId '+
'  , RoomReservation AS RoomerRoomReservationId '+
'  , Room '+
'  , RoomType '+
'  , GuestName '+
'  , NumGuests '+
'  , Arrival '+
'  , Departure '+
'  , ExpectedCheckOutTime '+
'  , Customer '+
'  , CompanyName '+
'  , NumNights '+
'  , TotalRent / NumNights AS AverageRatePerNight '+
'  , TotalRent '+
'  , TotalSale '+
'  , TotalPayments '+
'  , TotalRent+TotalSale-TotalPayments AS Balance '+
'FROM (SELECT '+
'         ADate AS CheckOutDate '+
'       ,yyy.Reservation '+
'       ,yyy.RoomReservation '+
'       ,yyy.Room '+
'       ,yyy.RoomType '+
'       ,pe.Name AS GuestName '+
'       ,cu.Customer '+
'       ,cu.Surname AS CompanyName '+
'       ,DATE((SELECT ADate FROM roomsdate WHERE RoomReservation=yyy.RoomReservation AND ResFlag=yyy.ResFlag ORDER BY ADate LIMIT 1)) AS Arrival '+
'       ,DATE(DATE_ADD((SELECT ADate FROM roomsdate WHERE RoomReservation=yyy.RoomReservation AND ResFlag=yyy.ResFlag ORDER BY ADate DESC LIMIT 1), INTERVAL 1 DAY)) AS Departure '+
'       ,ROUND(SUM(RateWithDiscount + IFNULL(IF(CityTaxIncl, 0, CityTaxPerDay), 0.00)) , 2) AS TotalRent '+
'       ,IFNULL((SELECT SUM(Number*Price) FROM invoicelines il WHERE InvoiceNumber=-1 AND RoomReservation=yyy.RoomReservation), 0.00) AS TotalSale '+
'       ,IFNULL((SELECT SUM(Amount) FROM payments WHERE InvoiceNumber=-1 AND RoomReservation=yyy.RoomReservation), 0.00) AS TotalPayments '+
'       ,(SELECT COUNT(id) FROM persons pe1 WHERE pe1.RoomReservation=yyy.RoomReservation) AS NumGuests '+
'       ,(SELECT COUNT(id) FROM roomsdate rd1 WHERE rd1.RoomReservation=yyy.RoomReservation AND rd1.ResFlag=yyy.ResFlag) AS NumNights '+
'       ,IFNULL(rr.ExpectedCheckOutTime, ho.DefaultCheckOutTime) AS ExpectedCheckOutTime '+
'     FROM(SELECT '+
'             ADate '+
'           , ResFlag '+
'           , RateExcl '+
'           , RateIncl - RateExcl AS VAT '+
'           , RateIncl '+
'           , IF(Discount > 0, IF(isPercentage, RateIncl - (RateIncl * Discount / 100), RateIncl - Discount), RateIncl) AS RateWithDiscount '+
'           , CityTaxInCl '+
'           , NumNights '+
'           , NumGuests '+
'           , IF(CityTaxIncl, 0, IF(taxPercentage, taxBaseAmount * taxAmount / 100, taxAmount) *  IF(taxRoomNight, 1, '+
'                                 IF(taxGuestNight, NumGuests,IF(taxGuestNight, NumGuests / NumNights,IF(taxBooking, 1 / NumNights,1 ))))) / CurrencyRate AS CityTaxPerDay '+
'           , taxPercentage '+
'           , taxRetaxable '+
'           , taxRoomNight '+
'           , taxGuestNight '+
'           , taxGuest '+
'           , taxBooking '+
'           , taxNettoAmountBased '+
'           , xxx.RoomReservation '+
'           , xxx.Reservation '+
'           , xxx.Room '+
'           , xxx.RoomType '+
' FROM (SELECT '+
'           DATE_ADD((SELECT rd1.ADate FROM roomsdate rd1 WHERE rd1.RoomReservation = rd.RoomReservation ORDER BY rd1.ADate DESC LIMIT 1), INTERVAL 1 DAY) AS ADate '+
'        ,rd.ResFlag '+
'        ,RoomRate AS RateIncl '+
'        ,RoomRate / (1 + vc.VATPercentage/100) AS RateExcl '+
'        ,to_bool(IF(tx.INCL_EXCL=''INCLUDED'' OR (tx.INCL_EXCL=''PER_CUSTOMER'' AND cu.StayTaxIncluted), 1, 0)) AS CityTaxInCl '+
'        ,tx.AMOUNT AS taxAmount '+
'        ,to_bool(IF(tx.TAX_TYPE=''FIXED_AMOUNT'', 0, 1)) AS taxPercentage,to_bool(IF(tx.RETAXABLE=''FALSE'', 0, 1)) AS taxRetaxable, to_bool(IF(tx.TAX_BASE=''ROOM_NIGHT'', 1, 0)) AS taxRoomNight '+
'        ,to_bool(IF(tx.TAX_BASE=''GUEST_NIGHT'', 1, 0)) AS taxGuestNight, to_bool(IF(tx.TAX_BASE=''GUEST'', 1, 0)) AS taxGuest, to_bool(IF(tx.TAX_BASE=''BOOKING'', 1, 0)) AS taxBooking '+
'        ,to_bool(IF(tx.NETTO_AMOUNT_BASED=''FALSE'', 0, 1)) AS taxNettoAmountBased , IF(tx.NETTO_AMOUNT_BASED=''FALSE'', RoomRate, RoomRate / (1 + vc.VATPercentage/100)) AS taxBaseAmount '+
'        ,(SELECT COUNT(rd1.ID) FROM roomsdate rd1 WHERE rd1.RoomReservation = rr.RoomReservation AND NOT rd1.ResFlag IN (''X'',''C'') GROUP BY rd1.RoomReservation) AS NumNights '+
'        ,(SELECT COUNT(pe.ID) FROM persons pe WHERE pe.RoomReservation = rr.RoomReservation GROUP BY pe.RoomReservation) AS NumGuests '+
'        ,cur.Currency AS Currency '+
'        ,cur.AValue AS CurrencyRate '+
'        ,rd.Discount, rd.isPercentage '+
'        ,rd.RoomReservation '+
'        ,rd.Reservation '+
'        ,rd.Room '+
'        ,rd.RoomType '+
'       FROM roomsdate rd '+
'         JOIN currencies cur ON cur.Currency=rd.Currency '+
'         JOIN roomreservations rr ON rr.RoomReservation=rd.RoomReservation '+
'         JOIN reservations r ON r.Reservation=rd.Reservation '+
'         JOIN customers cu ON cu.Customer=r.Customer '+
'         JOIN control co '+
'         JOIN home100.TAXES tx ON HOTEL_ID=co.CompanyId AND VALID_FROM<=rd.ADate AND VALID_TO>=rd.ADate '+
'         JOIN items i ON i.Item=co.RoomRentItem '+
'         JOIN itemtypes it ON it.ItemType=i.ItemType '+
'         JOIN vatcodes vc ON vc.VATCode=it.VATCode, '+
'(SELECT '+
'   ''%s'' AS StartDate '+
'   ,''%s'' AS EndDate) AS params '+
' WHERE rd.RoomReservation IN '+
'   (SELECT '+
'      RoomReservation '+
'    FROM '+
'      roomsdate rd '+
'    WHERE '+
'        rd.ADate BETWEEN DATE_ADD(params.StartDate, INTERVAL -1 DAY) AND DATE_ADD(params.EndDate, INTERVAL -1 DAY) '+
'      AND rd.ResFlag=''G'' '+
'      AND (SELECT rd1.ADate FROM roomsdate rd1 WHERE rd1.RoomReservation = rd.RoomReservation ORDER BY rd1.ADate DESC LIMIT 1) = rd.ADate) '+
'      AND NOT ResFlag IN (''X'',''C'') '+
'      AND rd.Paid=0 '+
'    ) xxx '+
'   ) yyy '+
' JOIN roomreservations rr ON rr.RoomReservation=yyy.RoomReservation '+
' JOIN reservations r ON r.Reservation=yyy.Reservation '+
' JOIN customers cu ON cu.Customer=r.Customer AND cu.Active '+
' JOIN persons pe ON pe.RoomReservation=yyy.RoomReservation AND pe.MainName=1 '+
' JOIN channels ch ON ch.Id=r.Channel '+
' JOIN hotelconfigurations ho '+
' GROUP BY yyy.RoomReservation, CheckOutDate '+
') zzz '+
'ORDER BY '+
'  CheckOutDate, Room ';






function ShowDeparturesReport: boolean;
var
  frm: TfrmDeparturesReport;
begin
  frm := TfrmDeparturesReport.Create(nil);
  try
    frm.ShowModal;
    Result := (frm.modalresult = mrOk);
  finally
    frm.Free;
  end;
end;

procedure TfrmDeparturesReport.btnCheckInClick(Sender: TObject);
var s : String;
    Room : String;
    Reservation, RoomReservation : Integer;
    NoRoom, bContinue : Boolean;
begin
  Room := kbmDeparturesList['Room'];
  NoRoom := Copy(Room, 1, 1) = '<';
  Reservation := kbmDeparturesList['RoomerReservationID'];
  RoomReservation := kbmDeparturesList['RoomerRoomReservationID'];
  ShowAlertsForReservation(Reservation, RoomReservation, atCHECK_OUT);
  if d.CheckOutRoom(Reservation, RoomReservation, Room) then
    postMessage(handle, WM_REFRESH_DATA, 0, 0);
end;

procedure TfrmDeparturesReport.btnExcelClick(Sender: TObject);
var
  sFilename : string;
  s         : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_DeparturesList';
  ExportGridToExcel(sFilename, grDeparturessList, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmDeparturesReport.btnProfileClick(Sender: TObject);
begin
  if EditReservation(kbmDeparturesList['RoomerReservationID'], kbmDeparturesList['RoomerRoomReservationID']) then
    postMessage(handle, WM_REFRESH_DATA, 0, 0);
end;

procedure TfrmDeparturesReport.btnRefreshClick(Sender: TObject);
begin
  postMessage(handle, WM_REFRESH_DATA, 0, 0);
end;

function TfrmDeparturesReport.ConstructSQL: string;
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

procedure TfrmDeparturesReport.dtDateFromCloseUp(Sender: TObject);
begin
 if dtDateFrom.Date > dtDateTo.Date then
   dtDateTo.Date := dtDateFrom.Date;
end;

procedure TfrmDeparturesReport.dtDateToCloseUp(Sender: TObject);
begin
 if dtDateFrom.Date > dtDateTo.Date then
   dtDateFrom.Date := dtDateTo.Date;
end;

procedure TfrmDeparturesReport.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
end;

procedure TfrmDeparturesReport.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmDeparturesReport.FormShow(Sender: TObject);
begin
  UpdateControls;
  postMessage(handle, WM_REFRESH_DATA, 0, 0);
end;

procedure TfrmDeparturesReport.mnuGroupInvoiceClick(Sender: TObject);
begin
  EditInvoice(kbmDeparturesList['RoomerReservationID'], 0, 0, 0, 0, 0, false, true,false);
end;

procedure TfrmDeparturesReport.grDeparturessListDBTableView1CellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  btnProfile.Click;
end;

procedure TfrmDeparturesReport.kbmDeparturesListAfterScroll(DataSet: TDataSet);
begin
  UpdateControls;
end;

procedure TfrmDeparturesReport.mnuRoomInvoiceClick(Sender: TObject);
begin
  EditInvoice(kbmDeparturesList['RoomerReservationID'], kbmDeparturesList['RoomerRoomReservationID'], 0, 0, 0, 0, false, true,false);
end;

procedure TfrmDeparturesReport.rbRadioButtonClick(Sender: TObject);
begin
  UpdateControls;
end;

procedure TfrmDeparturesReport.RefreshData;
var
  s    : string;
  rset1: TRoomerDataset;
begin
  if NOT btnRefresh.Enabled then exit;


  copyToClipboard(sSql);

  btnRefresh.Enabled := False;
  Screen.Cursor := crHourglass;
  try

    kbmDeparturesList.DisableControls;
    try
      FRefreshingdata := True; // UpdateControls still called when updating dataset, despite DisableControls
      rSet1 := CreateNewDataSet;
      try
        s := ConstructSQL;

        hData.rSet_bySQL(rSet1, s);
        rSet1.First;
        if not kbmDeparturesList.Active then
          kbmDeparturesList.Open;
        LoadKbmMemtableFromDataSetQuiet(kbmDeparturesList,rSet1,[]);
      finally
        FreeAndNil(rSet1);
      end;

      kbmDeparturesList.First;

    finally
      FRefreshingdata := False;
      kbmDeparturesList.EnableControls;
    end;
  finally
    btnRefresh.Enabled := True;
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmDeparturesReport.SetManualDates(aFrom, aTo: TDate);
begin
  dtDateFrom.Date := aFrom;
  dtDateTo.Date := aTo;
end;

procedure TfrmDeparturesReport.UpdateControls;
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

  lDataAvailable := kbmDeparturesList.Active and NOT kbmDeparturesList.Eof;
  btnCheckIn.Enabled := lDataAvailable;
  btnProfile.Enabled := lDataAvailable;
  btnInvoice.Enabled := lDataAvailable;
end;

procedure TfrmDeparturesReport.WndProc(var message: TMessage);
begin
  if message.Msg = WM_REFRESH_DATA then
    RefreshData;
  inherited WndProc(message);
end;

end.
