unit uOpenAPICaller;

interface

uses
    cmpRoomerDataset
  , SysUtils
  ;

type
  EOpenAPICallerException = class(Exception);

  TBaseOpenAPICaller = class abstract(TObject)
  const
    cAccMicrosoftDataset = 'application/x-microsoft-dataset';
  public
  end;

  TInventoriesOpenAPICaller = class(TBaseOpenAPICaller)
  const
    cResourcesURI = 'inventories/';
  public
    /// <summary>
    ///   Implementation of /inventories/stocks endpoint, returning a dataset
    /// </summary>
    procedure CallStockitemsAsDataset(aRSet: TRoomerDataset; aIncludePrices: boolean; aPricesFrom, aPricesTo: TDatetime; aIncludeUsage: boolean; aUsageFrom, aUsageTo: TDatetime);
  end;

implementation

uses
    ALWininetHttpClient
  , uDateUtils
  ;

{ TInventoriesOpenAPICaller }

procedure TInventoriesOpenAPICaller.CallStockitemsAsDataset(aRSet: TRoomerDataset; aIncludePrices: boolean; aPricesFrom,
  aPricesTo: TDatetime; aIncludeUsage: boolean; aUsageFrom, aUsageTo: TDatetime);
const
  cStockItemsURI = 'stocks';
var
  roomerClient: TALWininetHttpClient;
  lURI: string;
  lResponse: string;
begin
  roomerClient := aRSet.CreateRoomerClient(True);
  try
    roomerClient.RequestHeader.Accept := cAccMicrosoftDataset;

    lURI := aRset.OpenApiUri + cResourcesURI + cStockitemsURI;
    if aIncludePrices then
    begin
      lURI := lURI + '?includePrices=true&pricesFrom=' + dateToSqlString(aPricesFrom) + '&pricesTo=' + dateToSqlString(aPricesTo);
    end;
    if aIncludeUsage then
    begin
      lURI := lURI + '?includeUsage=true&usageFrom=' + dateToSqlString(aUsageFrom) + '&usageTo=' + dateToSqlString(aUsageTo);
    end;

    lResponse := roomerClient.Get(lURI);
    aRSet.OpenDataset(lResponse);
  finally
    roomerClient.Free;
  end;
end;

end.
