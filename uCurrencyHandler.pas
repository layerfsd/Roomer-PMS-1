unit uCurrencyHandler;

interface

uses
    hData
  , SysUtils
  , cxCurrencyEdit
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
  ///  The handler is constructed for a certain currency code
  /// </summary>
  TCurrencyHandler = class
  private
    FCurrencyRec: recCurrencyHolder;
    FFormatSettings: TFormatSettings;
    function GetRate: double;
    function GetCurrencyCode: string;
  public
    constructor Create(const aCurrencyCode: string);

    property Rate: double read GetRate;
    property CurrencyCode: string read GetCurrencyCode;

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
    function GetcxEditProperties: TcxCurrencyEditProperties;
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

function TCurrencyHandler.GetCurrencyCode: string;
begin
  Result := FCurrencyRec.Currency;
end;

function TCurrencyHandler.GetcxEditProperties: TcxCurrencyEditProperties;
begin
  Result := TcxCurrencyEditProperties(d.getCurrencyProperties(FCurrencyRec.Currency));
end;

function TCurrencyHandler.GetRate: double;
begin
  Result := FCurrencyRec.Value;
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
