unit uHotelStatusOfflineReport;

interface

uses
  uOffLineReport,
  uOfflineReportDesign
  ;

type
  THotelStatusReport = class(TOffLinereport)
  private
  protected
    class function ReportName: string; override;
    class function ReportDesign: TOfflinereportDesignClass; override;

    function PrepareData : Boolean; override;
  public
  end;

implementation

uses
  uHotelStatusOfflineReportDesign
  , uOfflineReportGenerator
  , SysUtils
  ;

resourcestring
  rsReportName = 'Hotel Status Report'; // Must be replaced by translation

  cSQL = 'SELECT co.CompanyID, ' +
         'co.CompanyName, '+
         'r.Reservation, ' +
         'r.Name AS ReservationName, ' +
         'rr.Arrival, ' +
         'rr.Departure, ' +
         'DATEDIFF(rr.Departure, rr.Arrival) AS Nights, '+
         'rr.RoomReservation, ' +
         'rr.Room, ' +
         'rr.RoomType, ' +
         'rr.Status, '+
         'FORMAT((SELECT AVG(RoomRate) FROM roomsdate WHERE RoomReservation=rr.RoomReservation AND ResFlag=rr.Status), 2) AS AvgRate, '+
         'FORMAT((SELECT AVG(Discount) FROM roomsdate WHERE RoomReservation=rr.RoomReservation AND ResFlag=rr.Status), 2) AS AvgDiscountValue, '+
         'FORMAT((SELECT IsPercentage FROM roomsdate WHERE RoomReservation=rr.RoomReservation AND ResFlag=rr.Status LIMIT 1), 2) AS DiscountIsPercentage, '+
         'FORMAT((SELECT AVG(IF(IsPercentage, RoomRate*Discount/100, Discount)) FROM roomsdate WHERE RoomReservation=rr.RoomReservation AND ResFlag=rr.Status), 2) AS AvgDiscount, '+
         'FORMAT((SELECT AVG(IF(IsPercentage, RoomRate-RoomRate*Discount/100, RoomRate-Discount)) FROM roomsdate WHERE RoomReservation=rr.RoomReservation AND ResFlag=rr.Status), 2) AS AvgRateAfterDiscount, '+
         'rr.Currency, ' +
         'rr.NumGuests, ' +
         'rr.NumChildren, ' +
         'rr.NumInfants, '+
         'c.AValue AS CurrencyRate, '+
         'p.Person, ' +
         'p.Name AS GuestName, ' +
         'r.ContactName, '+
         'co.NativeCurrency, '+
         '(SELECT GROUP_CONCAT(Name ORDER BY MainName DESC) FROM persons pe1 WHERE pe1.RoomReservation=rr.RoomReservation) AS Guests, '+
         '(SELECT Location FROM rooms WHERE Room=rr.Room) AS Location, '+
         '(SELECT Floor FROM rooms WHERE Room=rr.Room) AS Floor, '+
         '(SELECT SUM(Price * Number) FROM invoicelines WHERE RoomReservation=rr.RoomReservation) AS TotalSales '+

         'FROM reservations r '+
         'JOIN roomreservations rr ON rr.Reservation=r.Reservation '+
         'JOIN currencies c ON c.Currency=rr.Currency '+
         'JOIN persons p ON p.RoomReservation=rr.RoomReservation AND MainName=1, '+
         'control co '
         + 'WHERE EXISTS((SELECT ADate FROM roomsdate WHERE RoomReservation=rr.RoomReservation AND ResFlag IN (''P'',''G'') AND ADate=''%s''))'
         ;

{ THotelStatusReport }




function THotelStatusReport.PrepareData: Boolean;
begin
  FSQL := Format(cSQL, [FormatDateTime('yyyy-mm-dd', FDateTime)]);
  Result := inherited;
end;

class function THotelStatusReport.ReportDesign: TOfflinereportDesignClass;
begin
  Result := THotelStatusOfflineReportDesign;
end;

class function THotelStatusReport.reportName: string;
begin
  Result := rsReportName;
end;

initialization
  TOfflineReportGenerator.RegisterOfflineReport(THotelStatusReport);

finalization
  TOfflineReportGenerator.UnRegisterOfflineReport(THotelStatusReport);

end.
