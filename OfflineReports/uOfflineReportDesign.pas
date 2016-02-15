unit uOfflineReportDesign;

interface

uses
  System.SysUtils, System.Classes,

  Data.DB, frxClass, frxExportPDF, frxDBSet, kbmMemTable,

  cmpRoomerDataset
  ;

type
  // Base and abstract OfflineReportDesign.
  // Actual Offlinereports should be derived of this class and have their own ReportDesign and databasefields defined
  TBaseOfflineReportDesign = class(TDataModule)
    frxOfflineReport: TfrxReport;
    frxDBDataset: TfrxDBDataset;
    frxOfflinePDFExport: TfrxPDFExport;
    kbmOfflineReportDS: TkbmMemTable;
    kbmOfflineReportDSDummy: TStringField;
  private
    FDataset: TRoomerDataset;
    procedure SetDataset(const Value: TRoomerDataset);
    procedure SetreportProperties;
    { Private declarations }
  public
    { Public declarations }
    procedure PrintToPDF(const aFileName: string);
    property Dataset: TRoomerDataset read FDataset write SetDataset;
  end;

  TOfflinereportDesignClass = class of TBaseOfflineReportDesign;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  uUtils
  ;

{ TBaseOfflineReportDesign }

procedure TBaseOfflineReportDesign.SetreportProperties;
begin
  with frxOfflineReport do
  begin
    reportOptions.CreateDate := Now();
  end;
end;

procedure TBaseOfflineReportDesign.PrintToPDF(const aFileName: string);
begin
  SetReportProperties;

  frxOfflineReport.PrepareReport(false);

  frxOfflinePDFExport.Report          := frxOfflineReport;
  frxOfflinePDFExport.Compressed      := true;
  frxOfflinePDFExport.FileName        := aFileName;

  frxOfflinePDFExport.ShowDialog      := false;

  frxOfflineReport.Export(frxOfflinePDFExport);
end;

procedure TBaseOfflineReportDesign.SetDataset(const Value: TRoomerDataset);
begin
  FDataset := Value;
  frxDBDataset.Close;
  frxDBDataset.Dataset := nil;
  frxDBdataset.FieldAliases.Clear;
  if (Value <> nil) then
  begin
    kbmOfflineReportDS.CreateTableAs(Value, [mtcpoStructure, mtcpoProperties]);
    kbmOfflIneReportDS.LoadFromDataSet(Value, []);
    frxDBDataset.Dataset := kbmOfflineReportDS;
    frxDBDataset.Open;
  end;
end;

end.
