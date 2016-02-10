unit OfflineReportGenerator;

interface

uses uD,
     cmpRoomerDataSet;

type

  THotelStatusReport = class
    DataSet : TRoomerDataSet;
  private
    procedure CreateReport;
    function PrepareData : Boolean;
  public
    constructor Create(ADate : TDate);
  end;


implementation

{ THotelStatusReport }

uses hData;

constructor THotelStatusReport.Create(ADate: TDate);
begin
  if PrepareData then
    CreateReport;
end;

function THotelStatusReport.PrepareData : Boolean;
begin
  DataSet := CreateNewDataSet;
//  result := rSet_bySQL(DataSet, TheSql);
  Result := true;
end;

procedure THotelStatusReport.CreateReport;
begin
end;


end.
