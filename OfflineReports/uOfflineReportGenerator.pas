unit uOfflineReportGenerator;

interface

uses Generics.Collections,
     uOfflineReport;

type
  //Starting point for generating offline reports.
  // This class contains a list of registered offlinereportclasses, which will all be started when the ExecuteRegisteredReports
  // class method is called
  TOfflineReportGenerator = class
  private
    class var FRegisteredReports: TList<TOfflineReportClass>;
  public
    class destructor ClassDestroy;
    class procedure RegisterOfflineReport(const aReportClass: TOfflineReportClass);
    class procedure UnRegisterOfflineReport(const aReportClass: TOfflineReportClass);
    // Start generation of all registered Offlinereports. This done creating an instance of the TOfflineReportClass and
    // by calling its Start method.
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
      // Notice that Reportclass is derived from TTHread and has FreeOnterminate set to True so freeing is not needed here
    begin
       lReportClass.Create(Now()).Start;
       Sleep(1000);
    end;
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
