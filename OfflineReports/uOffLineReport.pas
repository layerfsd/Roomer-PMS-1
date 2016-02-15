unit uOffLineReport;

interface

uses
  uRoomerThreadedRequest,
  cmpRoomerDataSet,
  Classes,
  uOfflineReportDesign
  ;

type
  // A base definition of a Offline report, actual implementations should be derived from this abstract class
  TOfflineReport = class abstract(TBaseDBThread)
  private
    function GetReportPDFFilename: string;
  protected
    FDateTime: TDatetime;
    FSQL: string;

    class function ReportName: string; virtual; abstract;
    // Reference to the designclass that contains the actrual report design and will be used to generate the report
    class function ReportDesign: TOfflinereportDesignClass; virtual; abstract;

    // Internal working part of the report generation, called after the thread has CoInitialized itsself
    procedure InternalExecute; override;

    // First fase in generating the offline report: should populate FRecordset with the data to print
    function PrepareData : Boolean; virtual;
    //Second fase in generating the offline report: actual running the report and storing as .PDF file
    procedure CreateReport; virtual;
    //Purge older report PDF files to leave only a recent collection of data
    procedure PurgeReports; virtual;
  public
    constructor Create(const aDate: TDateTime); overload; virtual;
    destructor Destroy; override;
  end;

  TOfflineReportClass = class of TOffLineReport;
  TOfflinereportClassArr = array of TOfflineReportClass;

implementation

uses
  uD,
  uAppGlobal,
  SysUtils,
  Types,
  IOUtils,
  uRoomerDefinitions
  ;

const
  cReportFilesTokeep = 10; // maximum number of PDF files from the same report to keep

constructor TOfflineReport.Create(const aDate: TDateTime);
begin
  Create(True);
  FreeOnTerminate := True;
  FDateTime := aDate;
end;

procedure TOfflineReport.CreateReport;
var
  lDesign: TBaseOffLineReportDesign;
begin
  if (ReportDesign <> nil) then
  begin
    lDesign := ReportDesign.Create(nil);
    try
      lDesign.Dataset := Self.DataSet;
      lDesign.PrintToPDF(GetReportPDFFilename);
    finally
      lDesign.Free;
    end;
  end;
end;

destructor TOfflineReport.Destroy;
begin
  inherited;
end;

function TOfflineReport.GetReportPDFFilename: string;
var
  lFile: string;
const
  cNameFormat = '%s-%s';
begin
  lFile := ChangeFileExt(Format(cNameFormat, [ReportName, FormatDateTime('yyyyddmmhhnn', FDateTime)]), '.PDF');
  Result := TPath.Combine(glb.GetOfflinereportLocation, lFile);
end;

procedure TOfflineReport.InternalExecute;
begin
  inherited;

  if PrepareData then
    CreateReport;

  PurgeReports;
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
        // TODO: Add avtivitylog when deletion has failed
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
