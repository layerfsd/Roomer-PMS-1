unit uHotelArrivalsOfflineReportDesign;

interface

uses
  System.SysUtils, System.Classes,
  uOfflineReportDesign, Data.DB, frxClass, frxExportPDF, frxDBSet, dxmdaset
  ;

type
  // Offlinereports design for the HotelStatus report
  THotelArrivalsOfflineReportDesign = class(TBaseOfflineReportDesign)
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


{ THotelArrivalsOfflineReportDesign }

procedure THotelArrivalsOfflineReportDesign.PrintToPDF(const aFileName: string);
begin
  inherited;
  InternalPrintToPDF(aFileName, frxHotelStatusReport);
end;

end.
