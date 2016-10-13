unit uVatCalculator;

interface

type
  /// <summary>
  ///   Centralized access to all VAT calculations
  /// </summary>
  TVatCalculator = class
  private
  public
    /// <summary>
    ///   Calculate VAT for one item, based on the price and VATcode or formula in the Sales item table
    /// </summary>
    class function CalcVATforItem(aItemID: string): double;
  end;

implementation

uses
  uD
  , hData
  ;

{ TVatCalculator }

class function TVatCalculator.CalcVATforItem(aItemID: string): double;
var
  lItemInfo: recItemPlusHolder;
begin
  lItemInfo := d.Item_Get_Data(aItemId);

//  if trim(lItemInfo.VATFormula) <> '' then
//  begin
//
//    formula := GetFilledInFormula(ItemTypeInfo.valueFormula, RoomTaxEntity, ItemTaxEntities);
//    if (trim(formula) <> '') then
//    begin
//      parser := TRoomerMathParser.Create(nil);
//      parser.Expression := formula;
//      if parser.Parse then
//        result := parser.ParserResult * NumItems
//      else
//        result := _calcVAT(Price, ItemTypeInfo.VATPercentage)
//    end;
//      finally
//        map.Free;
//      end;

  Result := lItemInfo.Price * lItemInfo.VATPercentage / 100;
end;

end.
