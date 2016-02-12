unit uHotelStatusOfflineReportDesign;

interface

uses
  System.SysUtils, System.Classes,
  uOfflineReportDesign, Data.DB, kbmMemTable, frxClass, frxExportPDF, frxDBSet
  ;

type
  // Offlinereports design for the HotelStatus report
  THotelStatusOfflineReportDesign = class(TBaseOfflineReportDesign)
  public
  end;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


end.
