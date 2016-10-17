unit uDayClosingTimesAPICaller;

interface

uses
  uOpenApiCaller
  , cmpRoomerDataset
  ;

type
  TDayClosingTimesAPICaller = class(TBaseOpenAPICaller)
  const
    cResourcesURI = 'financials/';
    cDayClosingTimeURI = 'dayclosingtimes/';
  private
    function constructDayClosingTimestampXMLObject(aDay, aClosingtime: TDateTime): string;
    function ConstructNewRequest(aDay, aClosingtime: TDateTime): string;
    function ConstructUpdateRequest(aDay, aClosingtime: TDateTime): string;
  public
    /// <summary>
    ///   Implementation of /configurationItems/dayclosingtimes endpoint, returning a dataset
    /// </summary>
    function GetDayClosingTimesAsDataset(aRSet: TRoomerDataset; aDaysFrom: TDateTime = -1; aDaysTo: TDatetime= -1): boolean;
    function UpdateDayClosingTime(aDay: TDateTime; aClosingTime: TDateTime): boolean;
    function InsertDayClosingTime(aDay: TDateTime; aClosingTime: TDateTime): boolean;
    function DeleteDayClosingTime(aDay: TDateTime): boolean;
    function GetRunningDay: TDateTime;
    /// <summary>
    ///   Registers the current timestamp as the closing time of the current day, no questions asked
    /// </summary>
    function CloseRunningDay: boolean;
    /// <summary>
    ///   Registers the current timestamp as the closing time of the current day, after comfirmation by the user. <br />
    ///  If the currentday is beyond today then a timestamp for today is already registered and dayclosing is not allowed.
    /// </summary>
    procedure CloseRunningDayGuarded;
  end;

implementation

{ TDayClosingTimesICaller }

uses
  uDateTimeHelper
  , uRoomerHttpClient
  , uDateUtils
  , uD
  , Classes
  , SysUtils
  , uUtils
  , Dialogs
  , UITypes
  , PrjConst;

function TDayClosingTimesAPICaller.DeleteDayClosingTime(aDay: TDateTime): boolean;
var
  roomerClient: TRoomerHttpClient;
  lURI: string;
  lResponse: string;
begin
  roomerClient := d.roomerMainDataSet.CreateRoomerClient(True);
  try
    lURI := d.roomerMainDataSet.OpenApiUri + cResourcesURI  + cDayClosingTimeURI + '/' + dateToSqlString(aDay);

    Result := roomerClient.DeleteWithStatus(lURI, lResponse) = 200;
  finally
    roomerClient.Free;
  end;
end;

function TDayClosingTimesAPICaller.GetDayClosingTimesAsDataset(aRSet: TRoomerDataset; aDaysFrom: TDateTime = -1; aDaysTo: TDatetime= -1): boolean;
var
  roomerClient: TRoomerHttpClient;
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

    Result := roomerClient.GetWithStatus(lURI, lResponse) = 200;
    if Result then
      aRSet.OpenDataset(lResponse);
  finally
    roomerClient.Free;
  end;
end;

function TDayClosingTimesAPICaller.GetRunningDay: TDateTime;
var
  roomerClient: TRoomerHttpClient;
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

      if roomerClient.GETWithStatus(lURI, lResponse) = 200 then
      begin
        lRSet.OpenDataset(lResponse);
        Result := lRSet['runningday'];
      end
      else
        Result := now();
    finally
      lRSet.Free;
    end;
  finally
    roomerClient.Free;
  end;
end;

function TDayClosingTimesAPICaller.CloseRunningDay: boolean;
var
  roomerClient: TRoomerHttpClient;
  lURI: string;
  lResponse: string;
  lStream: TStringStream;
const
  cCloseCurrentURI = '/runningday/closenow';
begin
  roomerClient := d.roomerMainDataSet.CreateRoomerClient(True);
  try
    lStream := TStringStream.Create;
    try
      lURI := d.roomerMainDataSet.OpenApiUri + cResourcesURI + cCloseCurrentURI;

      Result := roomerClient.POSTWithStatus(lURI, lStream, lResponse) = 200;
    finally
      lStream.Free;
    end;
  finally
    roomerClient.Free;
  end;
end;


procedure TDayClosingTimesAPICaller.CloseRunningDayGuarded;
var
  lCaller: TDayClosingTimesAPICaller;
  lCurrentDay: TdateTime;
begin
  lCaller := TDayClosingTimesAPICaller.Create;
  try
    lCurrentDay := lCaller.GetRunningDay;

    if lCurrentDay > TDateTime.Today then
      MessageDlg(Format(GetTranslatedText('shTx_FinancialDayAlreadyClosed'), [lCurrentDay.ToString]), mtInformation, [mbOK], 0)
    else
      if MessageDlg(GetTranslatedText('shTx_CloseFinancialDay') + #10 +
                    GetTranslatedText('shTx_CurrentFinancialDay') + lCurrentDay.ToString, mtConfirmation, [mbYes, mbCancel], 0) = mrYes then
        lCaller.CloseRunningDay;
  finally
    lCaller.Free;
  end;
end;

function TDayClosingTimesAPICaller.constructDayClosingTimestampXMLObject(aDay, aClosingtime: TDateTime): string;
begin
  Result := result + '<rmrds:DayClosingTimestampType '#10;
  Result := result + Format('  day="%s" ', [dateToSQLString(aDay)]) + #10;
  Result := result + Format('  closingtimestamp="%s"', [dateTimeToXmlString(aClosingtime)]) +#10;
  Result := result + '/>'#10;
end;

function TDayClosingTimesAPICaller.ConstructNewRequest(aDay, aClosingtime: TDateTime): string;
begin
  Result := '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?>'#10;
  Result := result + '<NewDayClosingTimestampRequest '#10;
  Result := Result + '    xmlns="http://www.promoir.nl/roomer/financials/2016/08" '#10;
  Result := result + '    xmlns:rmrds="http://roomer.promoir.nl/datamodel/canonical/datastructures/2014/01/" '#10;
  Result := result + '> '#10;
  Result := Result + constructDayClosingTimestampXMLObject(aDay, aClosingTime);
  Result := Result + '</NewDayClosingTimestampRequest>';

end;

function TDayClosingTimesAPICaller.ConstructUpdateRequest(aDay, aClosingtime: TDateTime): string;
begin
  Result := '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?>'#10;
  Result := result + '<UpdateDayClosingTimestampRequest '#10;
  Result := Result + '    xmlns="http://www.promoir.nl/roomer/financials/2016/08" '#10;
  Result := result + '    xmlns:rmrds="http://roomer.promoir.nl/datamodel/canonical/datastructures/2014/01/" '#10;
  Result := result + '> '#10;
  Result := Result + constructDayClosingTimestampXMLObject(aDay, aClosingTime);
  Result := Result + '</UpdateDayClosingTimestampRequest>';

end;

function TDayClosingTimesAPICaller.InsertDayClosingTime(aDay, aClosingTime: TDateTime): boolean;
var
  roomerClient: TRoomerHttpClient;
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
      lStream.WriteString( ConstructNewRequest(aDay, aClosingtime));
      lURI := d.roomerMainDataSet.OpenApiUri + cResourcesURI + cDayClosingTimeURI;

      Result := roomerClient.POSTWithStatus(lURI, lStream, lResponse) = 200;
    finally
      lStream.Free;
    end;
  finally
    roomerClient.Free;
  end;
end;

function TDayClosingTimesAPICaller.UpdateDayClosingTime(aDay, aClosingTime: TDateTime): boolean;
var
  roomerClient: TRoomerHttpClient;
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
      lStream.WriteString( ConstructUpdateRequest(aDay, aClosingtime));
      lURI := d.roomerMainDataSet.OpenApiUri + cResourcesURI + cDayClosingTimeURI;

      Result := roomerClient.PUTWithStatus(lURI, lStream, lResponse) = 200;
    finally
      lStream.Free;
    end;
  finally
    roomerClient.Free;
  end;
end;

end.
