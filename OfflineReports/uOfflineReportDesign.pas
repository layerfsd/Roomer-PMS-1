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
  private
    FRoomerDataset: TRoomerDataset;
    procedure SetRoomerDataset(const Value: TRoomerDataset);
    procedure SetreportProperties;
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure PrintToPDF(const aFileName: string);
    property RoomerDataset: TRoomerDataset read FRoomerDataset write SetRoomerDataset;
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
    EnabledDataSets.Add(frxDBDataset);
    ReportOptions.CreateDate := Now();

  end;
end;

constructor TBaseOfflineReportDesign.Create(aOwner: TComponent);
begin
  inherited;

  with frxOfflineReport.EngineOptions do
  begin
    NewSilentMode := simReThrow;
//    DestroyForms := false;
    { This property switches off the search through global list, which is not thread safe}
    UseGlobalDataSetList := False;
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

procedure TBaseOfflineReportDesign.SetRoomerDataset(const Value: TRoomerDataset);
begin
  FRoomerDataset := Value;
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
