unit uCurrencyHandler;

interface

uses
    hData
  , SysUtils
  , cxEdit
  ;

type
  ECurrencyHandlerException = class(Exception);

  // for future use ... maybe
//  TAmount = record
//    Value: double;
//    Currency: string;
//    function ConvertTo(const aOtherCurrency: string): TAmount;
//  end;

  /// <summary>
  ///   Object to handle conversions and display of amounts in a certain currency <br />
  ///  The handler is created for a certain currency code
  /// </summary>
  TCurrencyHandler = class
    FCurrencyRec: recCurrencyHolder;
    FFormatSettings: TFormatSettings;
  public
    constructor Create(const aCurrencyCode: string);

    /// <summary>
    ///   Convert aAmount in the currency of this handler to the amount of the currency provided
    /// </summary>
    function ConvertTo(aAmount: double; const aOtherCurrency: string): double;
    /// <summary>
    ///   Round aAmount to the number of decimals defined for the currency
    /// </summary>
    function RoundedValue(aAmount: double): double;
    /// <summary>
    ///   Format aAmount according to the formatsettings of the currency
    /// </summary>
    function FormattedValue(aAmount: double): string;
    /// <summary>
    ///   Get the CustomEditProperties component defined in uD , based on currencycode
    /// </summary>
    function GetcxEditProperties: TcxCustomEditProperties;
  end;


implementation

uses
    uAppGlobal
  , uStringUtils
  , uFloatUtils
  , uD;

{ TCurrencyHandler }

function TCurrencyHandler.ConvertTo(aAmount: double; const aOtherCurrency: string): double;
var
  lrecOtherCurrency: recCurrencyHolder;
begin
  if not glb.LocateCurrency(aOtherCurrency) then
    raise ECurrencyHandlerException.CreateFmt('Currency code [%s] not found', [aOtherCurrency]);

  lrecOtherCurrency.ReadFromDataset(glb.CurrenciesSet);
  Result := (aAmount * FCurrencyRec.Value) / lrecOtherCurrency.Value;
end;

constructor TCurrencyHandler.Create(const aCurrencyCode: string);
begin
  if not glb.LocateCurrency(aCurrencyCode) then
    raise ECurrencyHandlerException.CreateFmt('Currency code [%s] not found', [aCurrencyCode]);

  FCurrencyRec.ReadFromDataset(glb.CurrenciesSet);

  FFormatSettings := TFormatSettings.Create; // System defaults
  FFormatSettings.CurrencyString := FCurrencyRec.CurrencySign;
  FFormatSettings.CurrencyDecimals := FCurrencyRec.Decimals;
end;

function TCurrencyHandler.FormattedValue(aAmount: double): string;
begin
  Result := Format('%s %s', [FCurrencyRec.CurrencySign, FormatCurr(FCurrencyRec.Displayformat, RoundedValue(aAmount), FFormatSettings)]);
end;

function TCurrencyHandler.GetcxEditProperties: TcxCustomEditProperties;
begin
  Result := d.getCurrencyProperties(FCurrencyRec.Currency);
end;

function TCurrencyHandler.RoundedValue(aAmount: double): double;
begin
  Result := RoundDecimals(aAmount, FCurrencyRec.Decimals);
end;

{ TAmount }

//function TAmount.ConvertTo(const aOtherCurrency: string): TAmount;
//var
//  lrecOtherCurrency: recCurrencyHolder;
//begin
//  Result.Currency := aOthterCurrency;
//  lrecOtherCurrency.Currency := aOthterCurrency;
//  GET_CurrencyHolderByCurrency(lrecOtherCurrency, false);
//  Result.Value := (Self.Value * Self..Value) / lrecOtherCurrency.Value;
//end;

end.
