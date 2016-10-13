unit uTaxCalc;

interface

uses
  Generics.Collections,
  Classes,
  SysUtils,
  uDateUtils,
  uStringUtils,
  uSqlDefinitions,
  hData,
  cmpRoomerDataset,
  uD,
  uG,
  uUtils,
  IOUtils,
  RoomerMathParser
  , uInvoiceEntities
  ;

type

  TEnumTaxType = (TT_PERCENTAGE, TT_FIXED_AMOUNT);
  TEnumTaxBase = (TB_ROOM_NIGHT, TB_GUEST_NIGHT, TB_ROOM, TB_BOOKING, TB_GUEST);
  TEnumTaxDue = (TD_PREPAID, TD_CHECKOUT);
  TEnumTaxIncl_Excl = (TIE_INCLUDED, TIE_EXCLUDED, TIE_PER_CUSTOMER);

  TInvoiceTaxEntity = class
    BookingItem: String;
    Description: String;
    NumItems: Double;
    Amount: Double;
    IncludedInPrice: TEnumTaxIncl_Excl;
    Percentage: Boolean;
  private
    function GetTotal: Double;
  public

    constructor Create(_BookingItem: String; _Description: String; _NumItems: Double; _Amount: Double;
      _IncludedInPrice: TEnumTaxIncl_Excl; _Percentage: Boolean);
    property total: Double read GetTotal;
  end;

  TInvoiceTaxEntityList = TObjectList<TInvoiceTaxEntity>;

  TTax = class
    ID: Integer;
    Description: String;
    Amount: Double;
    TAX_TYPE: TEnumTaxType;
    TAX_BASE: TEnumTaxBase;
    TIME_DUE: TEnumTaxDue;
    RETAXABLE: Boolean;
    TAXCHILDREN: Boolean;
    BOOKING_ITEM: String;
    INCL_EXCL: TEnumTaxIncl_Excl;
    NETTO_AMOUNT_BASED: Boolean;
    VALUE_FORMULA: String;
    ROUND_VALUE: Double;
    VALID_FROM, VALID_TO: TDate;

  private

    function getEnumTaxType(_tax_type: String): TEnumTaxType;
    function getEnumTaxBase(_tax_base: String): TEnumTaxBase;
    function getEnumTaxDue(_tax_due: String): TEnumTaxDue;
    function getEnumTaxIncl_Excl(_incl_excl: String): TEnumTaxIncl_Excl;

  public
    constructor Create(_id: Integer; _Description: String; _Amount: Double; _tax_type, _tax_base, _time_due, _reTaxable,
      _taxChildren, _booking_item, _incl_excl, _netto_Amount_Based, _value_Formula: String; _round_Value: Double;
      _valid_From, _valid_To: TDate);

  end;

  TTaxList = TObjectList<TTax>;

var
  TaxList: TTaxList;
  itemTypeInfoRent: TItemTypeInfo;
  itemTypeInfoTax: TItemTypeInfo;

procedure initializeTaxes;
function GetVATForItem(Item: String; Price: Double; NumItems: Double; RoomTaxEntity: TInvoiceRoomEntity;
  ItemTaxEntities: TInvoiceItemEntityList; ItemTypeInfo: TItemTypeInfo; Customer: String): Double;
function GetTaxesForInvoice(RoomTaxEntities: TInvoiceRoomEntityList; ItemTaxEntities: TInvoiceItemEntityList;
  ItemTypeInfo: TItemTypeInfo; customerIncludeDefault: Boolean): TInvoiceTaxEntityList;
function isStayTaxPerCustomer: Boolean;
function stayTaxAmount: Double;
function isStayTaxNettoBased: Boolean;
function isStayTaxExcluded: Boolean;
function isStayTaxIncluded: Boolean;
function isStayTaxPercentage: Boolean;

function stayTaxPerGuest: Boolean;
function stayTaxPerGuestNight: Boolean;
function stayTaxPerNight: Boolean;
function stayTaxPerBooking: Boolean;
function stayTaxPerRoom: Boolean;

function currentlyValidTax: TTax;
function CalculateCityTax(rentAmount: Double; Currency: string; Customer: String; ReservationUsesStayTax: Boolean;
  taxNights, taxGuests: Integer): recCityTaxResultHolder;

implementation

uses
  uAppGlobal,
  _Glob,
  uMain
  ;

procedure initializeTaxes;
var
  s: String;
  rSet: TRoomerDataSet;
begin
  TaxList.Clear;
  if NOT d.roomerMainDataSet.OfflineMode then
  begin
    s := format(select_Taxes_fillGridFromDataset, ['RETAXABLE']);
    s := d.roomerMainDataSet.queryRoomer(s);
  end;

  rSet := d.roomerMainDataSet.ActivateNewDataset(s);
  try
    rSet.First;
    while Not rSet.Eof do
    begin
      TaxList.Add(TTax.Create(rSet['ID'], rSet['Description'], rSet['Amount'], rSet['Tax_Type'], rSet['Tax_Base'],
        rSet['Time_Due'], rSet['Retaxable'], rSet['TaxChildren'], rSet['Booking_Item'], rSet['INCL_EXCL'],
        rSet['NETTO_AMOUNT_BASED'], rSet['VALUE_FORMULA'], rSet['ROUND_VALUE'], rSet['VALID_FROM'], rSet['VALID_TO']));
      rSet.Next;
    end;
  finally
    rSet.Free;
  end;

  itemTypeInfoRent.Itemtype := '';
  itemTypeInfoTax.Itemtype := '';
end;

function TaxsIsCurrentlyValid(Tax: TTax): Boolean;
begin
  result := (trunc(frmMain.dtDate.Date) >= Tax.VALID_FROM) AND (trunc(frmMain.dtDate.Date) <= Tax.VALID_TO);
end;

function TaxIsIncluded(Tax: TTax; customerIncluded: Boolean): Boolean;
begin
  result := ((Tax.INCL_EXCL = TIE_INCLUDED) OR ((Tax.INCL_EXCL = TIE_PER_CUSTOMER) AND customerIncluded));
end;

function CurrentTax: TTax;
var
  l: Integer;
  Tax: TTax;
begin
  result := nil;
  if TaxList.Count > 0 then
  begin
    for l := 0 to TaxList.Count - 1 do
    begin
      Tax := TaxList[l];
      if TaxsIsCurrentlyValid(Tax) then
      begin
        result := Tax;
        break;
      end;
    end;
  end;
end;

function stayTaxPerGuest: Boolean;
var
  Tax: TTax;
begin
  result := False;
  Tax := CurrentTax;
  if Assigned(Tax) then
    result := Tax.TAX_BASE = TB_GUEST;
end;

function stayTaxPerGuestNight: Boolean;
var
  Tax: TTax;
begin
  result := False;
  Tax := CurrentTax;
  if Assigned(Tax) then
    result := Tax.TAX_BASE = TB_GUEST_NIGHT;
end;

function stayTaxPerNight: Boolean;
var
  Tax: TTax;
begin
  result := False;
  Tax := CurrentTax;
  if Assigned(Tax) then
    result := Tax.TAX_BASE = TB_ROOM_NIGHT;
end;

function stayTaxPerBooking: Boolean;
var
  Tax: TTax;
begin
  result := False;
  Tax := CurrentTax;
  if Assigned(Tax) then
    result := Tax.TAX_BASE = TB_BOOKING;
end;

function stayTaxPerRoom: Boolean;
var
  Tax: TTax;
begin
  result := False;
  Tax := CurrentTax;
  if Assigned(Tax) then
    result := Tax.TAX_BASE = TB_ROOM;
end;

function stayTaxAmount: Double;
var
  Tax: TTax;
begin
  result := 0.0;
  Tax := CurrentTax;
  if Assigned(Tax) then
    result := Tax.Amount;
end;

function isStayTaxNettoBased: Boolean;
var
  Tax: TTax;
begin
  result := False;
  Tax := CurrentTax;
  if Assigned(Tax) then
    result := Tax.NETTO_AMOUNT_BASED;
end;

function isStayTaxExcluded: Boolean;
var
  Tax: TTax;
begin
  result := ctrlGetBoolean('StayTaxIncluted');
  Tax := CurrentTax;
  if Assigned(Tax) then
    result := Tax.INCL_EXCL = TIE_EXCLUDED;
end;

function isStayTaxIncluded: Boolean;
var
  Tax: TTax;
begin
  result := ctrlGetBoolean('StayTaxIncluted');
  Tax := CurrentTax;
  if Assigned(Tax) then
    result := Tax.INCL_EXCL = TIE_INCLUDED;
end;

function isStayTaxPerCustomer: Boolean;
var
  Tax: TTax;
begin
  result := ctrlGetBoolean('StayTaxIncluted');
  Tax := CurrentTax;
  if Assigned(Tax) then
    result := Tax.INCL_EXCL = TIE_PER_CUSTOMER;
end;

function isStayTaxPercentage: Boolean;
var
  Tax: TTax;
begin
  result := False;
  Tax := CurrentTax;
  if Assigned(Tax) then
    result := Tax.TAX_TYPE = TT_PERCENTAGE;
end;

function currentlyValidTax: TTax;
var
  l: Integer;
  Tax: TTax;
begin
  result := nil;
  if TaxList.Count > 0 then
  begin
    for l := 0 to TaxList.Count - 1 do
    begin
      Tax := TaxList[l];
      if TaxsIsCurrentlyValid(Tax) then
      begin
        result := Tax;
        break;
      end;
    end;
  end;
end;

//function FillHashMapWithValues(ItemTaxEntities: TInvoiceItemEntityList): TInvoiceItemEntityDictionary;
//var
//  i: Integer;
//  Item: TInvoiceItemEntity;
//begin
//  result := TInvoiceItemEntityDictionary.Create([doOwnsValues]);
//  if Assigned(ItemTaxEntities) then
//  begin
//    for i := 0 to ItemTaxEntities.Count - 1 do
//    begin
//      if NOT result.TryGetValue(ItemTaxEntities[i].Item, Item) then
//      begin
//        Item := TInvoiceItemEntity.Create(ItemTaxEntities[i].Item, 0, ItemTaxEntities[i].Price * ItemTaxEntities[i]
//          .NumItems, ItemTaxEntities[i].Vat * ItemTaxEntities[i].NumItems);
//        result.Add(Item.Item, Item);
//      end
//      else
//      begin
//        Item.Price := Item.Price + (ItemTaxEntities[i].Price * ItemTaxEntities[i].NumItems);
//        Item.Vat := Item.Vat + (ItemTaxEntities[i].Vat * ItemTaxEntities[i].NumItems);
//      end;
//    end;
//  end;
//end;

function GetFilledInFormula(formula: String; RoomTaxEntity: TInvoiceRoomEntity;
  map: TInvoiceItemEntityList): String;
var
  excl, incl, key: String;
  Item: TInvoiceItemEntity;
begin
  result := formula;
  if trim(result) <> '' then
  begin
    excl := format('{%s.excl}', [RoomTaxEntity.RoomItem]);
    incl := format('{%s.incl}', [RoomTaxEntity.RoomItem]);
    result := StringReplace(result, excl, FloatToStr(RoomTaxEntity.Price - RoomTaxEntity.Vat),
      [rfReplaceAll, rfIgnoreCase]);
    result := StringReplace(result, incl, FloatToStr(RoomTaxEntity.Price), [rfReplaceAll, rfIgnoreCase]);

    for Item in map do
    begin
      excl := format('{%s.excl}', [Item.Item]);
      incl := format('{%s.incl}', [Item.Item]);

      result := StringReplace(result, excl, FloatToStr(Item.Price - Item.Vat), [rfReplaceAll, rfIgnoreCase]);
      result := StringReplace(result, incl, FloatToStr(Item.Price), [rfReplaceAll, rfIgnoreCase]);
    end;

    glb.items.First;
    while NOT glb.items.Eof do
    begin
      key := glb.items['Item'];
      excl := format('{%s.excl}', [key]);
      incl := format('{%s.incl}', [key]);
      result := StringReplace(result, excl, FloatToStr(0), [rfReplaceAll, rfIgnoreCase]);
      result := StringReplace(result, incl, FloatToStr(0), [rfReplaceAll, rfIgnoreCase]);

      glb.items.Next;
    end;

    if (pos('.excl}', result) > 0) OR (pos('.incl}', result) > 0) then
      result := '';
  end;
end;

function GetCTAXPercentageOrValue(customerIncluded: Boolean; var Percentage, Value: Double;
  RoomVATPercentage: Double): Boolean;
var
  l: Integer;
  Tax: TTax;
  Itemtype, VATCode: String;
  TaxVATPercentage: Double;
begin
  Percentage := 0.00;
  Value := 0.00;
  result := False;
  for l := 0 to TaxList.Count - 1 do
  begin
    Tax := TaxList[l];
    if TaxsIsCurrentlyValid(Tax) then
    begin
      if TaxIsIncluded(Tax, customerIncluded) then
      begin

        // If same VAT percentage is for both ROOM rent ITem and TAX Item then Tax costs are not to be taken into
        // calculation of base amount
        if glb.LocateSpecificRecordAndGetValue('items', 'Item', Tax.BOOKING_ITEM, 'ItemType', Itemtype) AND
          glb.LocateSpecificRecordAndGetValue('itemtypes', 'ItemType', Itemtype, 'VATCode', VATCode) AND
          glb.LocateSpecificRecordAndGetValue('vatcodes', 'VATCode', VATCode, 'VATPercentage', TaxVATPercentage) AND
          (Round(TaxVATPercentage * 100) = Round(RoomVATPercentage * 100)) then
          exit;

        if Tax.TAX_TYPE = TT_PERCENTAGE then
          Percentage := Tax.Amount
        else
          Value := Tax.Amount;
        result := True;
      end
      else
      begin
        Percentage := 0.00;
        Value := 0.00;
      end;
    end;
  end;
end;

function GetVATForItemEx(Item: String; Price: Double; NumItems: Double; RoomTaxEntity: TInvoiceRoomEntity;
  ItemTaxEntities: TInvoiceItemEntityList; ItemTypeInfo: TItemTypeInfo; custIncluded: Boolean = False): Double;
var
  parser: TRoomerMathParser;
//  map: TInvoiceItemEntityDictionary;
  formula: String;

  Percentage, Value: Double;

  Amount: Double;

begin
  if (ItemTypeInfo.VATCode) = '' then
    ItemTypeInfo := d.Item_Get_ItemTypeInfo(Item);
  result := 0.00;
  if Price <> 0 then
  begin
    if trim(ItemTypeInfo.valueFormula) <> '' then
    begin
//      map := FillHashMapWithValues(ItemTaxEntities);
//      try
        formula := GetFilledInFormula(ItemTypeInfo.valueFormula, RoomTaxEntity, ItemTaxEntities);
        if (trim(formula) <> '') then
        begin
          parser := TRoomerMathParser.Create(nil);
          try
            parser.Expression := formula;
            if parser.Parse then
              result := parser.ParserResult * NumItems
            else
              result := _calcVAT(Price, ItemTypeInfo.VATPercentage)
          finally
            parser.Free;
          end;
        end;
//      finally
//        map.Free;
//      end;
    end
    else
    begin
      if (Uppercase(RoomTaxEntity.RoomItem) = Uppercase(g.qRoomRentItem)) AND
        GetCTAXPercentageOrValue(custIncluded, Percentage, Value, ItemTypeInfo.VATPercentage) then
      begin
        if Round(Percentage) = 0 then
          Percentage := ((Value * NumItems) / Price) * 100;
        Amount := _calcNetAmount(Price, Percentage + ItemTypeInfo.VATPercentage);
        // else
        // Amount := _calcNetAmount(Price, ItemTypeInfo.VATPercentage) - Value;
        result := Amount * ItemTypeInfo.VATPercentage / 100;
      end
      else
        result := _calcVAT(Price, ItemTypeInfo.VATPercentage);
    end;
  end;

end;

function GetVATForItem(Item: String; Price: Double; NumItems: Double; RoomTaxEntity: TInvoiceRoomEntity;
  ItemTaxEntities: TInvoiceItemEntityList; ItemTypeInfo: TItemTypeInfo; Customer: String): Double;
var
  custIncluded: Boolean;
begin
  if glb.LocateSpecificRecordAndGetValue('customers', 'Customer', Customer, 'StayTaxIncluted', custIncluded) then
    result := GetVATForItemEx(Item, Price, NumItems, RoomTaxEntity, ItemTaxEntities, ItemTypeInfo, custIncluded)
  else if glb.LocateSpecificRecordAndGetValue('customers', 'Customer', g.qRackCustomer, 'StayTaxIncluted', custIncluded)
  then
    result := GetVATForItemEx(Item, Price, NumItems, RoomTaxEntity, ItemTaxEntities, ItemTypeInfo, custIncluded)
  else
    result := GetVATForItemEx(Item, Price, NumItems, RoomTaxEntity, ItemTaxEntities, ItemTypeInfo,
      NOT isStayTaxExcluded);
end;

function GetTaxesForInvoice(RoomTaxEntities: TInvoiceRoomEntityList; ItemTaxEntities: TInvoiceItemEntityList;
  ItemTypeInfo: TItemTypeInfo; customerIncludeDefault: Boolean): TInvoiceTaxEntityList;
var
  i: Integer;
  Tax: TTax;
  Room: TInvoiceRoomEntity;
  l: Integer;

  BookingItem: String;
  Description: String;
  NumItems: Double;
  Amount, baseAmount: Double;
  IncludedInPrice: TEnumTaxIncl_Excl;

  Percentage: Boolean;
  taxGuests: Integer;

begin
  //
  result := TInvoiceTaxEntityList.Create(True);

  for l := 0 to TaxList.Count - 1 do
  begin
    Tax := TaxList[l];
    if TaxsIsCurrentlyValid(Tax) then
    begin
      Description := Tax.Description;
      BookingItem := Tax.BOOKING_ITEM;
      IncludedInPrice := Tax.INCL_EXCL;
      for i := 0 to RoomTaxEntities.Count - 1 do
      begin
        Room := RoomTaxEntities[i];

        taxGuests := Room.NumGuests;
        if Tax.TAXCHILDREN then
          taxGuests := taxGuests + Room.NumChildren;

        if Tax.TAX_TYPE = TT_FIXED_AMOUNT then
        begin
          Amount := Tax.Amount;
          Percentage := False;
        end
        else
        begin
          Percentage := True;
          if Tax.NETTO_AMOUNT_BASED then
          begin
            if TaxIsIncluded(Tax, customerIncludeDefault) then
            begin
              baseAmount := Room.Price / (1 + ((Tax.Amount + ItemTypeInfo.VATPercentage) / 100));
              // (Room.Price - Room.Vat)
              Amount := baseAmount * Tax.Amount / 100;
            end
            else
            begin
              baseAmount := (Room.Price - Room.Vat);
              Amount := baseAmount * Tax.Amount / 100;
            end;
          end
          else
          begin
            if TaxIsIncluded(Tax, customerIncludeDefault) then
            begin
              baseAmount := Room.Price / (1 + (Tax.Amount / 100)); // (Room.Price - Room.Vat)
              Amount := baseAmount * Tax.Amount / 100;
            end
            else
            begin
              baseAmount := Room.Price;
              Amount := baseAmount * Tax.Amount / 100;
            end;
          end;
          Description := Description + format(' (%n %% of %m)', [Tax.Amount, baseAmount]);
        end;

        NumItems := 0;
        if Tax.TAX_BASE = TB_ROOM_NIGHT then
          NumItems := Room.Nights
        else if Tax.TAX_BASE = TB_GUEST_NIGHT then
          NumItems := Room.Nights * taxGuests
        else if Tax.TAX_BASE = TB_ROOM then
          NumItems := 1
        else if Tax.TAX_BASE = TB_GUEST then
          NumItems := taxGuests
        else if Tax.TAX_BASE = TB_BOOKING then
          NumItems := 1;

        result.Add(TInvoiceTaxEntity.Create(BookingItem, Description, NumItems, Amount, IncludedInPrice, Percentage));
      end;
    end;
  end;
end;

function CalculateCityTax(rentAmount: Double; Currency: string; Customer: String; ReservationUsesStayTax: Boolean;
  taxNights, taxGuests: Integer): recCityTaxResultHolder;
var
  TaxesItem: string;

  isStayTaxPerCustomer: Boolean;
  isStayTaxIncluded: Boolean;
  isStayTaxPercentage: Boolean;

  NumItems: Double;
  taxAmount: Double;
  stayTaxAmount: Double;

  RentVAT: Double;
  CtaxVAT: Double;

  nettoRent: Double; // Rent minus incluted cititax;
  rentAmountExcl: Double;

  Tax: TTax;

begin
  initCityTaxResultHolder(result);
  Tax := currentlyValidTax;
  if NOT Assigned(Tax) then
    exit;

  if itemTypeInfoRent.Itemtype = '' then
    itemTypeInfoRent := d.Item_Get_ItemTypeInfo(trim(g.qRoomRentItem));
  if itemTypeInfoTax.Itemtype = '' then
  begin
    itemTypeInfoTax := d.Item_Get_ItemTypeInfo(trim(Tax.BOOKING_ITEM));
  end;

  stayTaxAmount := 0.00;
  RentVAT := 0.00;
  CtaxVAT := 0.00;

  if rentAmount <> 0 then
  begin
    if ReservationUsesStayTax then
    begin
      TaxesItem := Tax.BOOKING_ITEM;
      NumItems := 0;
      if Tax.TAX_BASE = TB_ROOM_NIGHT then // TB_ROOM_NIGHT, TB_GUEST_NIGHT, TB_ROOM, TB_BOOKING, TB_GUEST
        NumItems := 1
      else if Tax.TAX_BASE = TB_GUEST_NIGHT then
        NumItems := taxGuests
      else if Tax.TAX_BASE = TB_ROOM then
        NumItems := 1
      else if Tax.TAX_BASE = TB_GUEST then
        NumItems := taxGuests
      else if Tax.TAX_BASE = TB_BOOKING then
        NumItems := 1;

      taxAmount := Tax.Amount;

      isStayTaxPercentage := Tax.TAX_TYPE = TT_PERCENTAGE;
      isStayTaxPerCustomer := Tax.INCL_EXCL = TIE_PER_CUSTOMER; // isStayTaxPerCustomer;

      if isStayTaxPerCustomer then
      begin
        glb.LocateSpecificRecordAndGetValue('customers', 'Customer', Customer, 'StayTaxIncluted', isStayTaxIncluded);
      end
      else
      begin
        isStayTaxIncluded := Tax.INCL_EXCL = TIE_INCLUDED;
      end;

      if isStayTaxIncluded then
      begin
        if isStayTaxPercentage then
        begin
          if Tax.NETTO_AMOUNT_BASED then
          begin
            rentAmountExcl := rentAmount / (1 + (itemTypeInfoRent.VATPercentage + taxAmount) / 100);
            stayTaxAmount := rentAmountExcl * taxAmount / 100;
          end
          else
          begin
            rentAmountExcl := rentAmount / (1 + (itemTypeInfoRent.VATPercentage / 100)) / (1 + (taxAmount / 100));
            RentVAT := rentAmountExcl * itemTypeInfoRent.VATPercentage / 100;
            stayTaxAmount := (rentAmountExcl + RentVAT) * taxAmount / 100;
          end;
          stayTaxAmount := stayTaxAmount * NumItems;
        end
        else
        begin
          stayTaxAmount := taxAmount * NumItems;
        end;
        nettoRent := rentAmount - stayTaxAmount;
        RentVAT := _calcVAT(nettoRent, itemTypeInfoRent.VATPercentage);
        CtaxVAT := _calcVAT(stayTaxAmount, itemTypeInfoTax.VATPercentage);

      end
      else
      begin
        if isStayTaxPercentage then
        begin
          if Tax.NETTO_AMOUNT_BASED then
          begin
            rentAmountExcl := rentAmount / (1 + (itemTypeInfoRent.VATPercentage) / 100);
            stayTaxAmount := rentAmountExcl * taxAmount / 100;
          end
          else
          begin
            rentAmountExcl := rentAmount;
            stayTaxAmount := rentAmountExcl * taxAmount / 100;
          end;
          stayTaxAmount := stayTaxAmount * NumItems;
        end
        else
        begin
          stayTaxAmount := taxAmount * NumItems;
        end;
        nettoRent := rentAmount;
        RentVAT := _calcVAT(nettoRent, itemTypeInfoRent.VATPercentage);
        CtaxVAT := _calcVAT(stayTaxAmount, itemTypeInfoTax.VATPercentage);

      end;
    end;
  end;

  result.CityTax := stayTaxAmount;
  result.Incluted := isStayTaxIncluded;
  result.rentAmount := rentAmount;
  result.RentAmountVAT := RentVAT;
  result.CityTaxVAT := CtaxVAT;

end;

{ TTax }

constructor TTax.Create(_id: Integer; _Description: String; _Amount: Double;
  _tax_type, _tax_base, _time_due, _reTaxable, _taxChildren, _booking_item, _incl_excl, _netto_Amount_Based,
  _value_Formula: String; _round_Value: Double; _valid_From, _valid_To: TDate);
begin
  ID := _id;
  Description := _Description;
  Amount := _Amount;
  TAX_TYPE := getEnumTaxType(_tax_type);
  TAX_BASE := getEnumTaxBase(_tax_base);
  TIME_DUE := getEnumTaxDue(_time_due);
  RETAXABLE := Uppercase(_reTaxable) = 'TRUE';
  TAXCHILDREN := Uppercase(_taxChildren) = 'TRUE';
  BOOKING_ITEM := _booking_item;
  INCL_EXCL := getEnumTaxIncl_Excl(_incl_excl);
  NETTO_AMOUNT_BASED := Uppercase(_netto_Amount_Based) = 'TRUE';
  VALUE_FORMULA := _value_Formula;
  ROUND_VALUE := _round_Value;
  VALID_FROM := _valid_From;
  VALID_TO := _valid_To;
end;

function TTax.getEnumTaxType(_tax_type: String): TEnumTaxType;
begin
  if _tax_type = 'PERCENTAGE' then
    result := TT_PERCENTAGE
  else
    result := TT_FIXED_AMOUNT;
end;

function TTax.getEnumTaxBase(_tax_base: String): TEnumTaxBase;
begin
  if _tax_base = 'ROOM_NIGHT' then
    result := TB_ROOM_NIGHT
  else if _tax_base = 'GUEST_NIGHT' then
    result := TB_GUEST_NIGHT
  else if _tax_base = 'ROOM' then
    result := TB_ROOM
  else if _tax_base = 'BOOKING' then
    result := TB_BOOKING
  else
    result := TB_GUEST;
end;

function TTax.getEnumTaxDue(_tax_due: String): TEnumTaxDue;
begin
  if _tax_due = 'PREPAID' then
    result := TD_PREPAID
  else
    result := TD_CHECKOUT;
end;

function TTax.getEnumTaxIncl_Excl(_incl_excl: String): TEnumTaxIncl_Excl;
begin
  if _incl_excl = 'INCLUDED' then
    result := TIE_INCLUDED
  else if _incl_excl = 'EXCLUDED' then
    result := TIE_EXCLUDED
  else
    result := TIE_PER_CUSTOMER;
end;


// TEnumTaxType = (TT_PERCENTAGE, TT_FIXED_AMOUNT);
// TEnumTaxBase = (TB_ROOM_NIGHT, TB_GUEST_NIGHT, TB_ROOM, TB_BOOKING, TB_GUEST);
// TEnumTaxDue = (TD_PREPAID, TD_CHECKOUT);
// TEnumTaxIncl_Excl = (TIE_INCLUDED, TIE_EXCLUDED);

{ TTaxEntity }
function TInvoiceTaxEntity.GetTotal: Double;
begin
  result := NumItems * Amount;
end;



constructor TInvoiceTaxEntity.Create(_BookingItem, _Description: String; _NumItems, _Amount: Double;
  _IncludedInPrice: TEnumTaxIncl_Excl; _Percentage: Boolean);
begin
  BookingItem := _BookingItem;
  Description := _Description;
  NumItems := _NumItems;
  Amount := _Amount;
  IncludedInPrice := _IncludedInPrice;
  Percentage := _Percentage;
end;

{ TRoomTaxEntity }


initialization

TaxList := TTaxList.Create(True);
itemTypeInfoRent.Itemtype := '';
itemTypeInfoTax.Itemtype := '';

finalization

TaxList.Clear;
TaxList.Free;

end.
