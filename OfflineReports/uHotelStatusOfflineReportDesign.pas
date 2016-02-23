unit uHotelStatusOfflineReportDesign;

interface

uses
  System.SysUtils, System.Classes,
  uOfflineReportDesign, Data.DB, frxClass, frxExportPDF, frxDBSet, dxmdaset
  ;

type
  // Offlinereports design for the HotelStatus report
  THotelStatusOfflineReportDesign = class(TBaseOfflineReportDesign)
    frxHotelStatusReport: TfrxReport;
    procedure frxHotelStatusReportBeforePrint(Sender: TfrxReportComponent);
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

procedure THotelStatusOfflineReportDesign.frxHotelStatusReportBeforePrint(Sender: TfrxReportComponent);
begin
  inherited;
  //
end;

procedure THotelStatusOfflineReportDesign.PrintToPDF(const aFileName: string);
begin
  inherited;
  InternalPrintToPDF(aFileName, frxHotelStatusReport);
end;

end.
