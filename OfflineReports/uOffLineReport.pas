unit uOffLineReport;

interface

uses
  uRoomerThreadedRequest,
  cmpRoomerDataSet,
  Classes,
  uOfflineReportDesign
  ;

type
  // A base definition of an Offline report, actual implementations should be derived from this abstract class
  TOfflineReport = class abstract(TBaseDBThread)
  private
    FDesign: TBaseOfflineReportDesign;
    function GetReportPDFFilename: string;
  protected
    FDateTime: TDatetime;
    FSQL: string;

    // User friendly name of the report used a.o. in the resulting filename and the grid displaying the available offline reports
    class function ReportName: string; virtual; abstract;

    // Reference to the designclass that contains the actrual report design and will be used to generate the report
    class function ReportDesign: TOfflinereportDesignClass; virtual; abstract;

    // Internal working part of the report generation, called after the thread has CoInitialized itsself
    procedure InternalExecute; override;

    // First fase in generating the offline report: should populate FRecordset with the data to print
    function PrepareData : Boolean; virtual;

    //Second fase in generating the offline report: actual running the report and storing as .PDF file, using the
    // Offlinereport design sepcified by ReportDesign class function
    procedure CreateReport; virtual;

    //Purge older report PDF files to leave only a recent collection of data
    procedure PurgeReports; virtual;
  public
    constructor Create(const aDate: TDateTime); overload; virtual;
  end;

  TOfflineReportClass = class of TOffLineReport;

implementation

uses
  uD,
  uG,
  uAppGlobal,
  SysUtils,
  Types,
  IOUtils,
  uRoomerDefinitions
  , uActivityLogs;

const
  cReportFilesTokeep = 10; // maximum number of PDF files from the same report to keep

constructor TOfflineReport.Create(const aDate: TDateTime);
begin
  Create(True);
  FreeOnTerminate := True;
  FDateTime := aDate;
end;

procedure TOfflineReport.CreateReport;
//var
//  lDesign: TBaseOffLineReportDesign;
begin
  if (ReportDesign <> nil) then
  begin
    FDesign := ReportDesign.Create(nil);
//    try
      FDesign.RoomerDataset := Self.DataSet;
      FDesign.PrintToPDF(GetReportPDFFilename);
//    finally
//      lDesign.Free;
//    end;
  end;
end;

destructor TOfflineReport.Destroy;
begin
  FDesign.Free;
  inherited;
end;

function TOfflineReport.GetReportPDFFilename: string;
var
  lFile: string;
const
  cNameFormat = '%s-%s';
begin
  lFile := ChangeFileExt(Format(cNameFormat, [ReportName, FormatDateTime('yyyymmddhhnn', FDateTime)]), '.PDF');
  Result := TPath.Combine(glb.GetOfflinereportLocation, lFile);
end;

procedure TOfflineReport.InternalExecute;
begin
  try
    inherited;

    if PrepareData then
      CreateReport;

    PurgeReports;
  except
    on E: Exception do
      AddOfflineReportActivityLog(g.quser, REPORTEXCEPTION, ReportName, E.ClassName, E.Message);
  end;
end;


function TOfflineReport.PrepareData: Boolean;
begin
  try
    if (FSQL <> '')  then
      ExecuteSQL(FSQL);
    Result := RecordSet.RecordCount > 0;
  except
    Result := false;
  end;
end;

procedure TOfflineReport.PurgeReports;
var
  lDirectory: TStringDynArray;
  lFile: string;
  lFileList: TStringList;
begin
  // remove older files if more then cReportFilesTokeep are present

  lDirectory := TDirectory.GetFiles(glb.GetOfflinereportLocation, ReportName + '*.PDF');
  if (Length(lDirectory) > cReportFilesToKeep) then
  begin
    lFileList := TStringlist.Create;
    try
      for lFile in lDirectory do
        lFileList.Add(lFile);

      lFileList.Sort;

      while (lFileList.Count > cReportFilesToKeep) do
      begin
        DeleteFile(lFileList[0]);
        lFileList.Delete(0);
      end;


    finally
      lFileList.Free;
    end;
  end;

end;

initialization

finalization

end.
