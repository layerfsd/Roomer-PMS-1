unit uHotelArrivalsOfflineReport;

interface

uses
  uOffLineReport,
  uOfflineReportDesign
  ;

type
  // Offline report shown the current hotel status
  THotelArrivalsReport = class(TOffLinereport)
  private
    function FirstArrivalDate: TDateTime;
    function LastArrivalDate: TDateTime;
  protected
    class function ReportName: string; override;
    class function ReportDesign: TOfflinereportDesignClass; override;

    function PrepareData : Boolean; override;
  public
  end;

const
  cshTx_HotelArrivalsOfflineReport_Name = 'shTx_HotelArrivalsOfflineReport_Name';

implementation

uses
    uHotelArrivalsOfflineReportDesign
  , uOfflineReportGenerator
  , SysUtils
  , PrjConst
  ;


const
  cSQL = 'SELECT '+
          '  co.CompanyID, ' +
          '  rd.Room, '+
          '  rd.RoomType, '+
          '  ch.ChannelManagerId AS ChannelCode, '+
          '  ch.Name AS ChannelName, '+
          '  r.InvRefrence AS BookingReference, '+
          '  r.Reservation AS RoomerReservationId, '+
          '  pe.Name AS GuestName, '+
          '  r.Customer AS CompanyCode, '+
          '  r.Name AS CompanyName, '+
          '  rr.AvrageRate AS AverageRoomRate, '+
          '  CAST(( SELECT rd1.ADate '+
          '    FROM roomsdate rd1 '+
          '    WHERE rd1.RoomReservation=rd.RoomReservation '+
          '          AND (NOT rd1.ResFlag IN (''X'',''C'')) '+
          '    ORDER BY rd1.ADate LIMIT 1) as DATE) AS Arrival, '+
          '  CAST(DATE_ADD((SELECT rd1.ADate '+
          '              FROM roomsdate rd1 '+
          '              WHERE rd1.RoomReservation=rd.RoomReservation AND (rd1.ResFlag = ''P'') '+
          '              ORDER BY rd1.ADate DESC LIMIT 1), '+
          '            INTERVAL 1 DAY) as DATE) AS Departure, '+
          '  ( SELECT COUNT(id) '+
          '    FROM persons pe1 '+
          '    WHERE pe1.RoomReservation=rd.RoomReservation) AS NumGuests, '+
          '  '''' as ExpectedTimeOfArrival '+
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
          'GROUP BY rd.RoomReservation '+
          'ORDER BY rd.aDate, rd.Room ';

  cArrivalReportPeriod = 7; // report arrivals of comming 7 days


function THotelArrivalsReport.FirstArrivalDate: TDateTime;
begin
  Result := FDateTime;
end;

function THotelArrivalsReport.LastArrivalDate: TDateTime;
begin
  result := FDateTime + cArrivalReportPeriod;
end;

function THotelArrivalsReport.PrepareData: Boolean;
begin
  FSQL := Format(cSQL, [FormatDateTime('yyyy-mm-dd', FirstArrivalDate),
                        FormatDateTime('yyyy-mm-dd', LastArrivalDate)]);
  Result := inherited;
end;

class function THotelArrivalsReport.ReportDesign: TOfflinereportDesignClass;
begin
  Result := THotelArrivalsOfflineReportDesign;
end;

class function THotelArrivalsReport.reportName: string;
begin
  Result := GetTranslatedtext(cshTx_HotelArrivalsOfflineReport_Name);
end;

initialization
  TOfflineReportGenerator.RegisterOfflineReport(THotelArrivalsReport);

finalization
  TOfflineReportGenerator.UnRegisterOfflineReport(THotelArrivalsReport);

end.
