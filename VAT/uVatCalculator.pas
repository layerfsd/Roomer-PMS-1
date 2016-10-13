unit uVatCalculator;

interface

uses
    hData
  , SysUtils
  , Generics.Collections
  ;

type
  EVatCalculatorException = class(Exception);

  /// <summary>
  ///   Centralized access to all VAT calculations
  /// </summary>
  TVatCalculator = class
  private
  public
    /// <summary>
    ///   Calculate VAT for one item, based on the price (inc VAT) and VATcode from the Sales item table
    /// </summary>
    class function CalcVATforItem(aItemID: string): double; overload;
    /// <summary>
    ///   Calculate VAT for one item, based on provided price (incl VAT) and VATcode from the Sales item table
    /// </summary>
    class function CalcVATforItem(aItemID: string; aPriceInclVAT: double): double; overload;
    /// <summary>
    ///   Calculate the VAT from the provided Price (including VAT) and VAT percentage (0-100)
    /// </summary>
    class function CalcVATfromInclPrice(aPriceInclVat: double; aVATPercentage: double): double;
  end;

  TVATFormulaParameters = TDictionary<string, double>;

  TFormulaVatCalculator = class(TObject)
  private
    FFormula: string;
    function Substitutedformula(aParams: TVATFormulaParameters): string;
  public
    constructor Create(const aFormula: string);
    /// <summary>
    ///   Calculate the VAT using the formula for this instance and the parameters (Key=Value) from the TVatFormulaParamters
    /// </summary>
    function CalcVatForParameters(aParams: TVATFormulaParameters): double;
  end;

  TRoomRentVatCalculator = class(TObject)
  end;

implementation

uses
  uD
  ,RoomerMathParser
  ;

{ TVatCalculator }

class function TVatCalculator.CalcVATforItem(aItemID: string): double;
var
  lItemInfo: recItemPlusHolder;
begin
  lItemInfo := d.Item_Get_Data(aItemId);
  Result := CalcVATfromInclPrice(lItemInfo.Price, lItemInfo.VATPercentage);
end;

class function TVatCalculator.CalcVATforItem(aItemID: string; aPriceInclVAT: double): double;
var
  lItemInfo: recItemPlusHolder;
begin
  lItemInfo := d.Item_Get_Data(aItemId);
  Result := CalcVATfromInclPrice(aPriceInclVAT, lItemInfo.VATPercentage);
end;

class function TVatCalculator.CalcVATfromInclPrice(aPriceInclVat, aVATPercentage: double): double;
begin
  Result := (aPriceInclVAT - (aPriceInclVAT / (100 + aVatPercentage))) * aVATPercentage/100;
end;

{ TFormulaVatCalculator }

function TFormulaVatCalculator.CalcVatForParameters(aParams: TVATFormulaParameters): double;
var
  lParser: TRoomerMathParser;
begin
  lParser := TRoomerMathParser.Create(nil);
  try
    lParser.Expression := Substitutedformula(aParams);
    if lParser.Parse then
      Result := lParser.ParserResult
    else
      raise EVatCalculatorException.CreateFmt('Error occured while calculating VAT from formula [%s]', [FFormula]);
  finally
    lParser.Free;
  end;
end;

function TFormulaVatCalculator.Substitutedformula(aParams:TVATFormulaParameters): string;
var
  lParam: TPair<string, double>;
begin
  Result := FFormula;
  for lParam in aParams do
    Result := StringReplace(Result, lParam.Key, FloatToStr(lParam.Value), [rfReplaceAll, rfIgnoreCase]);

end;

constructor TFormulaVatCalculator.Create(const aFormula: string);
begin
  FFormula := aFormula;
end;

end.
