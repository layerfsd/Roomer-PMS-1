unit uOfflineReportGenerator;

interface

uses uRoomerThreadedRequest,
     generics.Collections,
     uD,
     uOfflineReport,
     cmpRoomerDataSet;

type
  TOfflineReportGenerator = class
  private
    class var FRegisteredReports: TList<TOfflineReportClass>;
  public
    class destructor ClassDestroy;
    class procedure RegisterOfflineReport(const aReportClass: TOfflineReportClass);
    class procedure UnRegisterOfflineReport(const aReportClass: TOfflineReportClass);
    class procedure ExecuteRegisteredReports;
  end;

implementation

uses
  SysUtils
  ;


{ TOfflineReportGenerator }


class destructor TOfflineReportGenerator.ClassDestroy;
begin
  FRegisteredReports.Free;
end;

class procedure TOfflineReportGenerator.ExecuteRegisteredReports;
var
  lReportClass: TOfflineReportClass;
begin
  if assigned(FRegisteredReports) then
    for lReportClass in FRegisteredReports do
      // Notice that Reportclass is derived from TTHread and has FreeOnterminate set to True
       lReportClass.Create(Now()).Start;
end;

class procedure TOfflineReportGenerator.RegisterOfflineReport(const aReportClass: TOfflineReportClass);
begin
  if (FRegisteredReports = nil) then
    FRegisteredReports := TList<TOfflineReportClass>.Create;

  FRegisteredReports.Add(aReportClass);
end;

class procedure TOfflineReportGenerator.UnRegisterOfflineReport(const aReportClass: TOfflineReportClass);
begin
  if assigned(FRegisteredReports) then
    FRegisteredReports.Remove(aReportClass);
end;

end.
