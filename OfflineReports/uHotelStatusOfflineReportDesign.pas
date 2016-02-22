unit uHotelStatusOfflineReportDesign;

interface

uses
  System.SysUtils, System.Classes,
  uOfflineReportDesign, Data.DB, kbmMemTable, frxClass, frxExportPDF, frxDBSet
  ;

type
  // Offlinereports design for the HotelStatus report
  THotelStatusOfflineReportDesign = class(TBaseOfflineReportDesign)
    frxHotelStatusReport: TfrxReport;
  public
    procedure PrintToPDF(const aFileName: string); override;
  end;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  Dialogs
  ;


{ THotelStatusOfflineReportDesign }

procedure THotelStatusOfflineReportDesign.PrintToPDF(const aFileName: string);
begin
  inherited;
  InternalPrintToPDF(aFileName, frxHotelStatusReport);
end;

end.
