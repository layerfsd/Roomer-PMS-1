unit uOfflineReportDesign;

interface

uses
  System.SysUtils, System.Classes,

  Data.DB, frxClass, frxExportPDF, frxDBSet, Data.Win.ADODB, kbmMemTable
  ;

type
  // Base and abstract OfflineReportDesign.
  // Actual Offlinereports should be derived of this class and have their own ReportDesign and databasefields defined
  TBaseOfflineReportDesign = class abstract(TDataModule)
    frxOfflineReport: TfrxReport;
    frxDBDataset: TfrxDBDataset;
    frxOfflinePDFExport: TfrxPDFExport;
    kbmOfflineReportDS: TkbmMemTable;
  private
    FRecordset: _Recordset;
    procedure SetRecordset(const Value: _Recordset);
    { Private declarations }
  public
    { Public declarations }
    procedure PrintToPDF(const aFileName: string);
    property Recordset: _Recordset read FRecordset write SetRecordset;
  end;

  TOfflinereportDesignClass = class of TBaseOfflineReportDesign;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TBaseOfflineReportDesign }

procedure TBaseOfflineReportDesign.PrintToPDF(const aFileName: string);
begin
  frxOfflineReport.PrepareReport(false);

  frxOfflinePDFExport.Report          := frxOfflineReport;
  frxOfflinePDFExport.Compressed      := true;
  frxOfflinePDFExport.FileName        := aFileName;

  frxOfflinePDFExport.ShowDialog      := false;

  frxOfflineReport.Export(frxOfflinePDFExport);
end;

procedure TBaseOfflineReportDesign.SetRecordset(const Value: _Recordset);
begin
  //kbmOfflineReportDS.RecordSet := Value;
end;

end.
