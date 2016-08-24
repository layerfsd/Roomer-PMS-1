unit uDayClosingTimesAPICaller;

interface

uses
  uOpenApiCaller
  , cmpRoomerDataset
  ;

type
  TDayClosingTimesAPICaller = class(TBaseOpenAPICaller)
  const
    cResourcesURI = '/financials';
    cDayClosingTimeURI = '/dayclosingtimes';
  private
    function constructXMLObject(aDay, aClosingtime: TDateTime): string;
  public
    /// <summary>
    ///   Implementation of /configurationItems/dayclosingtimes endpoint, returning a dataset
    /// </summary>
    procedure GetDayClosingTimesAsDataset(aRSet: TRoomerDataset; aDaysFrom: TDateTime = -1; aDaysTo: TDatetime= -1);
    function UpdateDayClosingTime(aDay: TDateTime; aClosingTime: TDateTime): boolean;
    function InsertDayClosingTime(aDay: TDateTime; aClosingTime: TDateTime): boolean;
    function DeleteDayClosingTime(aDay: TDateTime): boolean;
    function GetRunningDay: TDateTime;
    function CloseRunningDay: boolean;
  end;

implementation

{ TDayClosingTimesICaller }

uses
  uDateTimeHelper
  , ALWininetHttpClient
  , uDateUtils
  , uD
  , Classes
  , SysUtils
  ;

function TDayClosingTimesAPICaller.DeleteDayClosingTime(aDay: TDateTime): boolean;
var
  roomerClient: TALWininetHttpClient;
  lURI: string;
  lResponse: string;
begin
  roomerClient := d.roomerMainDataSet.CreateRoomerClient(True);
  try
    lURI := d.roomerMainDataSet.OpenApiUri + cResourcesURI + '/' + dateToSqlString(aDay);

    lResponse := roomerClient.Delete(lURI);
  finally
    roomerClient.Free;
  end;
end;

procedure TDayClosingTimesAPICaller.GetDayClosingTimesAsDataset(aRSet: TRoomerDataset; aDaysFrom: TDateTime = -1; aDaysTo: TDatetime= -1);
var
  roomerClient: TALWininetHttpClient;
  lURI: string;
  lResponse: string;
  lSep: string;
begin
  roomerClient := aRSet.CreateRoomerClient(True);
  try
    roomerClient.RequestHeader.Accept := cAccMicrosoftDataset;

    lURI := aRset.OpenApiUri + cResourcesURI + cDayClosingTimeURI;

    lSep := '?';
    if aDaysFrom <> -1 then
    begin
      lURI := lURI + lSep + 'daysFrom=' + dateToSqlString(aDaysFrom);
      lSep := '&';
     end;

     if aDaysTo <> -1 then
      lUri := lURI + lSep + 'daysTo=' + dateToSqlString(aDaysTo);

    lResponse := roomerClient.Get(lURI);
    aRSet.OpenDataset(lResponse);
  finally
    roomerClient.Free;
  end;
end;

function TDayClosingTimesAPICaller.GetRunningDay: TDateTime;
var
  roomerClient: TALWininetHttpClient;
  lURI: string;
  lResponse: string;
  lRSet: TRoomerDataSet;
const
  cRunningDayURI = '/runningday';
begin
  roomerClient := d.roomerMainDataSet.CreateRoomerClient(True);
  try
    lRSet := d.roomerMainDataSet.CreateNewDataset;
    try
      roomerClient.RequestHeader.Accept := cAccMicrosoftDataset;
      lURI := lRSet.OpenApiUri + cResourcesURI + cRunningDayURI;

      lResponse := roomerClient.GET(lURI);
      lRSet.OpenDataset(lResponse);
      Result := lRSet['runningday'];
    finally
      lRSet.Free;
    end;
  finally
    roomerClient.Free;
  end;
end;

function TDayClosingTimesAPICaller.CloseRunningDay: boolean;
var
  roomerClient: TALWininetHttpClient;
  lURI: string;
  lResponse: string;
  lStream: TStringStream;
const
  cCloseCurrentURI = '/runningday/close';
begin
  roomerClient := d.roomerMainDataSet.CreateRoomerClient(True);
  try
    lStream := TStringStream.Create;
    try
      lURI := d.roomerMainDataSet.OpenApiUri + cResourcesURI + cCloseCurrentURI;

      lResponse := roomerClient.POST(lURI, lStream);
    finally
      lStream.Free;
    end;
  finally
    roomerClient.Free;
  end;
end;

function TDayClosingTimesAPICaller.constructXMLObject(aDay, aClosingtime: TDateTime): string;
begin
  Result := '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?>'#10;
  Result := result + '<rmrds:DayClosingTimestampType xmlns:rmrds="http://roomer.promoir.nl/datamodel/canonical/datastructures/2014/01/" >'#10;
  Result := result + Format('  <day>%s</day>', [dateTimeToXmlString(aDay)]) + #10;
  Result := result + Format('  <closingtimestamp>%s</closingtimestamp>', [dateTimeToXmlString(aClosingtime)]) +#10;
  Result := result + '</rmrds:DayClosingTimestampType>'#10;
end;

function TDayClosingTimesAPICaller.InsertDayClosingTime(aDay, aClosingTime: TDateTime): boolean;
var
  roomerClient: TALWininetHttpClient;
  lURI: string;
  lResponse: string;
  lStream: TStringStream;
begin
  roomerClient := d.roomerMainDataSet.CreateRoomerClient(True);
  try
    lStream := TStringStream.Create;
    try
      roomerClient.RequestHeader.Accept := cAccMicrosoftDataset;
      roomerClient.RequestHeader.contentType := 'application/xml';
      lStream.WriteString( constructXMLObject(aDay, aClosingtime));
      lURI := d.roomerMainDataSet.OpenApiUri + cResourcesURI + cDayClosingTimeURI;

      lResponse := roomerClient.POST(lURI, lStream);
    finally
      lStream.Free;
    end;
  finally
    roomerClient.Free;
  end;
end;

function TDayClosingTimesAPICaller.UpdateDayClosingTime(aDay, aClosingTime: TDateTime): boolean;
var
  roomerClient: TALWininetHttpClient;
  lURI: string;
  lResponse: string;
  lStream: TStringStream;
begin
  roomerClient := d.roomerMainDataSet.CreateRoomerClient(True);
  try
    lStream := TStringStream.Create;
    try
      roomerClient.RequestHeader.Accept := cAccMicrosoftDataset;
      roomerClient.RequestHeader.contentType := 'application/xml';
      lStream.WriteString( constructXMLObject(aDay, aClosingtime));
      lURI := d.roomerMainDataSet.OpenApiUri + cResourcesURI + cDayClosingTimeURI;

      lResponse := roomerClient.PUT(lURI, lStream);
    finally
      lStream.Free;
    end;
  finally
    roomerClient.Free;
  end;
end;

end.
