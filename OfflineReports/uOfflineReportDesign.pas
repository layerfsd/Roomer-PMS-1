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
    frxDBDataset: TfrxDBDataset;
    frxOfflinePDFExport: TfrxPDFExport;
    kbmOfflineReportDS: TkbmMemTable;
  private
    FRoomerDataset: TRoomerDataset;
    procedure SetRoomerDataset(const Value: TRoomerDataset);
  protected
    procedure SetReportProperties(const aReport: TfrxReport);
    procedure InternalPrintToPDF(const aFileName: string; const aReport: Tfrxreport);
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure PrintToPDF(const aFileName: string); virtual;
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

procedure TBaseOfflineReportDesign.SetReportProperties(const aReport: TfrxReport);
begin
  with aReport do
  begin
    EnabledDataSets.Add(frxDBDataset);
    ReportOptions.CreateDate := Now();
  end;

  with aReport.EngineOptions do
  begin
    NewSilentMode := simReThrow;
//    DestroyForms := false;
    { This property switches off the search through global list, which is not thread safe}
    UseGlobalDataSetList := False;
  end;
end;

constructor TBaseOfflineReportDesign.Create(AOwner: TComponent);
begin
  inherited;

end;

procedure TBaseOfflineReportDesign.InternalPrintToPDF(const aFileName: string; const aReport: Tfrxreport);
begin
  SetReportProperties(aReport);

  aReport.PrepareReport(false);
  with frxOfflinePDFExport do
  begin
    Report          := aReport;
    Compressed      := true;
    FileName        := aFileName;
    ShowDialog      := false;
  end;
  aReport.Export(frxOfflinePDFExport);

end;

procedure TBaseOfflineReportDesign.PrintToPDF(const aFileName: string);
begin
  // Derived classses should call InternalPrintToPDF with their own frxReport instance
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
