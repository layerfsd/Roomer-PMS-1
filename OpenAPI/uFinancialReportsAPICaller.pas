unit uFinancialReportsAPICaller;


interface

uses
  uOpenApiCaller
  , cmpRoomerDataset
  ;

type
  TFinancialReportsAPICaller = class(TBaseOpenAPICaller)
  const
    cResourcesURI = 'financials/reports/';
    cPaymentsURI = 'payments/';
    cRevenuesURI = 'revenues/';
    cRoomrentURI = 'roomrent/';
  private
  public
    function GetPaymentsReportAsDataset(aRSet: TRoomerDataset; aDateFrom: TDateTime = -1; aDateTo: TDatetime= -1): boolean;
    function GetRevenuesReportAsDataset(aRSet: TRoomerDataset; aDateFrom: TDateTime = -1; aDateTo: TDatetime= -1): boolean;
    function GetRoomrentReportAsDataset(aRSet: TRoomerDataset; aDateFrom: TDateTime = -1; aDateTo: TDatetime= -1): boolean;
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
  , uUtils;


function TFinancialReportsAPICaller.GetPaymentsReportAsDataset(aRSet: TRoomerDataset; aDateFrom: TDateTime = -1; aDateTo: TDatetime= -1): boolean;
var
  roomerClient: TRoomerHttpClient;
  lURI: string;
  lResponse: string;
  lSep: string;
begin
  roomerClient := aRSet.CreateRoomerClient(True);
  try
    roomerClient.RequestHeader.Accept := cAccMicrosoftDataset;

    lURI := aRset.OpenApiUri + cResourcesURI + cPaymentsURI;

    lSep := '?';
    if aDateFrom = -1 then
      aDateFrom := TDateTime.Today;

    if aDateFrom <> -1 then
    begin
      lURI := lURI + lSep + 'dateFrom=' + dateToSqlString(aDateFrom);
      lSep := '&';
     end;

     if aDateTo <> -1 then
      lUri := lURI + lSep + 'dateTo=' + dateToSqlString(aDateTo);

    Result := roomerClient.GetWithStatus(lURI, lResponse) = 200;
    if Result then
      aRSet.OpenDataset(lResponse);
  finally
    roomerClient.Free;
  end;
end;

function TFinancialReportsAPICaller.GetRevenuesReportAsDataset(aRSet: TRoomerDataset; aDateFrom, aDateTo: TDatetime): boolean;
var
  roomerClient: TRoomerHttpClient;
  lURI: string;
  lResponse: string;
  lSep: string;
begin
  roomerClient := aRSet.CreateRoomerClient(True);
  try
    roomerClient.RequestHeader.Accept := cAccMicrosoftDataset;

    lURI := aRset.OpenApiUri + cResourcesURI + cRevenuesURI;

    lSep := '?';
    if aDateFrom = -1 then
      aDateFrom := TDateTime.Today;

    if aDateFrom <> -1 then
    begin
      lURI := lURI + lSep + 'dateFrom=' + dateToSqlString(aDateFrom);
      lSep := '&';
     end;

     if aDateTo <> -1 then
      lUri := lURI + lSep + 'dateTo=' + dateToSqlString(aDateTo);

    Result := roomerClient.GetWithStatus(lURI, lResponse) = 200;
    if Result then
      aRSet.OpenDataset(lResponse);
  finally
    roomerClient.Free;
  end;
end;

function TFinancialReportsAPICaller.GetRoomrentReportAsDataset(aRSet: TRoomerDataset; aDateFrom, aDateTo: TDatetime): boolean;
var
  roomerClient: TRoomerHttpClient;
  lURI: string;
  lResponse: string;
  lSep: string;
begin
  roomerClient := aRSet.CreateRoomerClient(True);
  try
    roomerClient.RequestHeader.Accept := cAccMicrosoftDataset;

    lURI := aRset.OpenApiUri + cResourcesURI + cRoomrentURI;

    lSep := '?';
    if aDateFrom = -1 then
      aDateFrom := TDateTime.Today;

    if aDateFrom <> -1 then
    begin
      lURI := lURI + lSep + 'dateFrom=' + dateToSqlString(aDateFrom);
      lSep := '&';
     end;

     if aDateTo <> -1 then
      lUri := lURI + lSep + 'dateTo=' + dateToSqlString(aDateTo);

    Result := roomerClient.GetWithStatus(lURI, lResponse) = 200;
    if Result then
      aRSet.OpenDataset(lResponse);
  finally
    roomerClient.Free;
  end;end;

end.
