unit uTaxCalc;

interface

uses Generics.Collections,
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

     ;

type

    TEnumTaxType = (TT_PERCENTAGE, TT_FIXED_AMOUNT);
    TEnumTaxBase = (TB_ROOM_NIGHT, TB_GUEST_NIGHT, TB_ROOM, TB_BOOKING, TB_GUEST);
    TEnumTaxDue = (TD_PREPAID, TD_CHECKOUT);
    TEnumTaxIncl_Excl = (TIE_INCLUDED, TIE_EXCLUDED, TIE_PER_CUSTOMER);

    TInvoiceTaxEntity = class
      BookingItem : String;
      Description : String;
      NumItems : Double;
      Amount : Double;
      IncludedInPrice : TEnumTaxIncl_Excl;
      Percentage : Boolean;
    private
    function GetTotal: Double;
    public

      constructor Create(_BookingItem : String;
                         _Description : String;
                         _NumItems : Double;
                         _Amount : Double;
                         _IncludedInPrice : TEnumTaxIncl_Excl;
                         _Percentage : Boolean);
      property total : Double read GetTotal;
    end;

    TInvoiceTaxEntityList = TObjectList<TInvoiceTaxEntity>;

    TInvoiceRoomEntity = class
      RoomItem : String;
      Guests : Integer;
      Nights : double;
      Price : Double;
      Vat : Double;
    public
      constructor Create(_RoomItem : String;
                         _Guests : Integer;
                         _Nights : double;
                         _Price : Double;
                         _Vat : Double);
    end;

    TInvoiceItemEntity = class
      Item : String;
      NumItems,
      Price,
      Vat : Double;
    private
      function GetPriceExcl: Double;

    public
      constructor Create(_Item : String;
                         _NumItems,
                         _Price,
                         _Vat : Double);

      property TotalWOVat : Double read GetPriceExcl;
    end;

    TInvoiceItemEntityDictionary =  TObjectDictionary<String, TInvoiceItemEntity>;
    TInvoiceRoomEntityList = TObjectList<TInvoiceRoomEntity>;
    TInvoiceItemEntityList = TObjectList<TInvoiceItemEntity>;

    TTax = class
        ID : Integer;
        DESCRIPTION : String;
        AMOUNT : Double;
        TAX_TYPE : TEnumTaxType;
        TAX_BASE : TEnumTaxBase;
        TIME_DUE : TEnumTaxDue;
        RETAXABLE : Boolean;
        BOOKING_ITEM : String;
        INCL_EXCL : TEnumTaxIncl_Excl;
        NETTO_AMOUNT_BASED : Boolean;
        VALUE_FORMULA : String;
        ROUND_VALUE : Double;
        VALID_FROM,
        VALID_TO : TDate;

    private

      function getEnumTaxType(_tax_type : String) : TEnumTaxType;
      function getEnumTaxBase(_tax_base : String) : TEnumTaxBase;
      function getEnumTaxDue(_tax_due : String) : TEnumTaxDue;
      function getEnumTaxIncl_Excl(_incl_excl : String) : TEnumTaxIncl_Excl;

    public
      constructor Create(_id : Integer;
                         _description : String;
                         _amount : Double;
                         _tax_Type,
                         _tax_Base,
                         _time_due,
                         _reTaxable,
                         _booking_item,
                         _incl_Excl,
                         _netto_Amount_Based,
                         _value_Formula : String;
                         _round_Value : Double;
                        _valid_From,
                        _valid_To : TDate);


    end;

    TTaxList = TObjectList<TTax>;

var TaxList : TTaxList;
    itemTypeInfoRent : TItemTypeInfo;
    itemTypeInfoTax  : TItemTypeInfo;


procedure initializeTaxes;
function GetVATForItem(Item : String; Price : Double; numItems : Double; RoomTaxEntity : TInvoiceRoomEntity; ItemTaxEntities : TInvoiceItemEntityList; ItemTypeInfo : TItemTypeInfo; Customer : String) : Double;
function GetTaxesForInvoice(RoomTaxEntities : TInvoiceRoomEntityList;
                            ItemTaxEntities : TInvoiceItemEntityList;
                            ItemTypeInfo: TItemTypeInfo;
                            customerIncludeDefault : Boolean) : TInvoiceTaxEntityList;
function isStayTaxPerCustomer : Boolean;
function isStayTaxExcluded : Boolean;
function isStayTaxPercentage : Boolean;
function currentlyValidTax : TTax;
function CalculateCityTax(rentAmount : double;
                          Currency : string;
                          Customer : String;
                          ReservationUsesStayTax : Boolean;
                          taxNights, taxGuests : integer): recCityTaxResultHolder;


implementation

uses uAppGlobal, _Glob, uMain;

procedure initializeTaxes;
var s, filename : String;
    rSet : TRoomerDataSet;
    Tax : TTax;
begin
  taxList.Clear;
  if NOT d.roomerMainDataSet.OfflineMode then
  begin
    s := format(select_Taxes_fillGridFromDataset , ['RETAXABLE']);
    s := d.roomerMainDataSet.queryRoomer(s);
  end else
  begin
    filename :=  TPath.Combine(d.GetBackupPath, 'Backup_TAXES.src');
    s := ReadFromTextFile(filename);
  end;

  rSet := d.roomerMainDataSet.ActivateNewDataset(s);
  try
    rSet.First;
    while Not RSet.Eof do
    begin
      taxList.Add(TTax.Create(rSet['ID'],
          rSet['Description'],
          rSet['Amount'],
          rSet['Tax_Type'],
          rSet['Tax_Base'],
          rSet['Time_Due'],
          rSet['Retaxable'],
          rSet['Booking_Item'],
          rSet['INCL_EXCL'],
          rSet['NETTO_AMOUNT_BASED'],
          rSet['VALUE_FORMULA'],
          rSet['ROUND_VALUE'],
          rSet['VALID_FROM'] ,
          rSet['VALID_TO']));
      RSet.Next;
    end;
  finally
    rSet.Free;
  end;

  itemTypeInfoRent.Itemtype := '';
  itemTypeInfoTax.Itemtype := '';
end;

function TaxsIsCurrentlyValid(Tax : TTax) : Boolean;
begin
  result := (trunc(frmMain.dtDate.Date) >= Tax.VALID_FROM) AND
            (trunc(frmMain.dtDate.Date) <= Tax.VALID_TO);
end;

function TaxIsIncluded(Tax : TTax; customerIncluded : Boolean) : Boolean;
begin
  result := ((Tax.INCL_EXCL = TIE_INCLUDED) OR
            ((Tax.INCL_EXCL = TIE_PER_CUSTOMER) AND customerIncluded));
end;


function isStayTaxExcluded : Boolean;
var l : Integer;
    tax : TTax;
begin
  result := ctrlGetBoolean('StayTaxIncluted');
  if taxList.Count > 0 then
  begin
    for l := 0 to taxList.Count - 1 do
    begin
      Tax := taxList[l];
      if TaxsIsCurrentlyValid(Tax) then
      begin
         result := tax.INCL_EXCL = TIE_EXCLUDED;
         break;
      end;
    end;
  end;
end;

function isStayTaxIncluded : Boolean;
var l : Integer;
    tax : TTax;
begin
  result := ctrlGetBoolean('StayTaxIncluted');
  if taxList.Count > 0 then
  begin
    for l := 0 to taxList.Count - 1 do
    begin
      Tax := taxList[l];
      if TaxsIsCurrentlyValid(Tax) then
      begin
         result := tax.INCL_EXCL = TIE_INCLUDED;
         break;
      end;
    end;
  end;
end;

function isStayTaxPerCustomer : Boolean;
var l : Integer;
    tax : TTax;
begin
  result := ctrlGetBoolean('StayTaxIncluted');
  if taxList.Count > 0 then
  begin
    for l := 0 to taxList.Count - 1 do
    begin
      Tax := taxList[l];
      if TaxsIsCurrentlyValid(Tax) then
      begin
         result := tax.INCL_EXCL = TIE_PER_CUSTOMER;
         break;
      end;
    end;
  end;
end;

function isStayTaxPercentage : Boolean;
var l : Integer;
    tax : TTax;
begin
  result := false;
  if taxList.Count > 0 then
  begin
    for l := 0 to taxList.Count - 1 do
    begin
      Tax := taxList[l];
      if TaxsIsCurrentlyValid(Tax) then
         result := tax.TAX_TYPE = TT_PERCENTAGE;
    end;
  end;
end;

function currentlyValidTax : TTax;
var l : Integer;
    tax : TTax;
begin
  result := nil;
  if taxList.Count > 0 then
  begin
    for l := 0 to taxList.Count - 1 do
    begin
      Tax := taxList[l];
      if TaxsIsCurrentlyValid(Tax) then
      begin
         result := tax;
         break;
      end;
    end;
  end;
end;


function FillHashMapWithValues(ItemTaxEntities : TInvoiceItemEntityList) : TInvoiceItemEntityDictionary;
var i : Integer;
    item : TInvoiceItemEntity;
begin
  result := TInvoiceItemEntityDictionary.Create([doOwnsValues]);
  if assigned(ItemTaxEntities) then
  begin
    for i := 0 to ItemTaxEntities.Count - 1 do
    begin
      if NOT result.TryGetValue(ItemTaxEntities[i].Item, item) then
      begin
        item := TInvoiceItemEntity.Create(
            ItemTaxEntities[i].Item,
            0,
            ItemTaxEntities[i].Price * ItemTaxEntities[i].NumItems,
            ItemTaxEntities[i].Vat * ItemTaxEntities[i].NumItems);
        result.Add(item.Item, item);
      end else
      begin
        item.Price := item.Price + (ItemTaxEntities[i].Price * ItemTaxEntities[i].NumItems);
        item.Vat := item.Vat + (ItemTaxEntities[i].Vat * ItemTaxEntities[i].NumItems);
      end;
    end;
  end;
end;

function GetFilledInFormula(formula : String; RoomTaxEntity : TInvoiceRoomEntity; map : TInvoiceItemEntityDictionary) : String;
var
  i: Integer;
  excl,
  incl,
  key : String;
  vat : Double;
   item : TInvoiceItemEntity;
begin
  result := formula;
  if trim(result) <> '' then
  begin
    excl := format('{%s.excl}', [RoomTaxEntity.RoomItem]);
    incl := format('{%s.incl}', [RoomTaxEntity.RoomItem]);
    result := StringReplace(result, excl, FloatToStr(RoomTaxEntity.Price - RoomTaxEntity.Vat), [rfReplaceAll, rfIgnoreCase]);
      result := StringReplace(result, incl, FloatToStr(RoomTaxEntity.Price), [rfReplaceAll, rfIgnoreCase]);

    for key in map.Keys do
    begin
      excl := format('{%s.excl}', [key]);
      incl := format('{%s.incl}', [key]);
      if map.TryGetValue(key, item) then
      begin
        result := StringReplace(result, excl, FloatToStr(item.Price - item.Vat), [rfReplaceAll, rfIgnoreCase]);
        result := StringReplace(result, incl, FloatToStr(item.Price), [rfReplaceAll, rfIgnoreCase]);
      end;
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

function GetCTAXPercentageOrValue(customerIncluded : Boolean; var Percentage, Value : Double; RoomVATPercentage : Double) : Boolean;
var l : Integer;
    Tax : TTax;
    ItemType, VATCode : String;
    TaxVATPercentage : Double;
begin
  Percentage := 0.00;
  Value := 0.00;
  result := False;
  for l := 0 to taxList.Count - 1 do
  begin
    Tax := taxList[l];
    if TaxsIsCurrentlyValid(Tax) then
    begin
      if TaxIsIncluded(Tax, customerIncluded) then
      begin

        // If same VAT percentage is for both ROOM rent ITem and TAX Item then Tax costs are not to be taken into
        // calculation of base amount
        if glb.LocateSpecificRecordAndGetValue('items', 'Item', tax.BOOKING_ITEM, 'ItemType', ItemType) AND
          glb.LocateSpecificRecordAndGetValue('itemtypes', 'ItemType', ItemType, 'VATCode', VATCode) AND
            glb.LocateSpecificRecordAndGetValue('vatcodes', 'VATCode', VATCode, 'VATPercentage', TaxVATPercentage) AND
              (Round(TaxVATPercentage * 100) = Round(RoomVATPercentage * 100)) then
                exit;

        if Tax.TAX_TYPE = TT_PERCENTAGE then
          Percentage := Tax.AMOUNT
        else
          Value := Tax.AMOUNT;
        result := True;
      end else
      begin
        Percentage := 0.00;
        Value := 0.00;
      end;
    end;
  end;
end;


function GetVATForItemEx(Item : String; Price : Double; numItems : Double; RoomTaxEntity : TInvoiceRoomEntity; ItemTaxEntities : TInvoiceItemEntityList; ItemTypeInfo : TItemTypeInfo; custIncluded : Boolean = False) : Double;
var
  parser : TRoomerMathParser;
  map : TInvoiceItemEntityDictionary;
  i, l : Integer;
  formula : String;

  Percentage,
  value : Double;

  Amount : Double;

begin
  if (ItemTypeInfo.VATCode) = '' then  ItemTypeInfo := d.Item_Get_ItemTypeInfo(Item);
  result := 0.00;
  if Price <> 0 then
  begin
    if Trim(ItemTypeInfo.valueFormula) <> '' then
    begin
      map := FillHashMapWithValues(ItemTaxEntities);
      formula := GetFilledInFormula(ItemTypeInfo.valueFormula, RoomTaxEntity, map);
      if (trim(formula) <> '') then
      begin
        parser := TRoomerMathParser.Create(nil);
        parser.Expression := formula;
        if parser.Parse then
          result := parser.ParserResult * numItems
        else
          result := _calcVAT(Price, ItemTypeInfo.VATPercentage)
      end;
    end else
    begin
      if (Uppercase(RoomTaxEntity.RoomItem) = UpperCase(g.qRoomRentItem)) AND
         GetCTAXPercentageOrValue(custIncluded, Percentage, Value, ItemTypeInfo.VATPercentage)  then
      begin
        if Round(Percentage) = 0 then
          Percentage := ((Value * numItems) / Price) * 100;
        Amount := _calcNetAmount(Price, Percentage + ItemTypeInfo.VATPercentage);
//        else
//          Amount := _calcNetAmount(Price, ItemTypeInfo.VATPercentage) - Value;
        result := Amount * ItemTypeInfo.VATPercentage / 100;
      end else
        result := _calcVAT(Price, ItemTypeInfo.VATPercentage);
    end;
  end;
end;

function GetVATForItem(Item : String; Price : Double; numItems : Double; RoomTaxEntity : TInvoiceRoomEntity; ItemTaxEntities : TInvoiceItemEntityList; ItemTypeInfo : TItemTypeInfo; Customer : String) : Double;
var custIncluded : Boolean;
begin
  if glb.LocateSpecificRecordAndGetValue('customers', 'Customer', Customer, 'StayTaxIncluted', custIncluded) then
    result := GetVATForItemEx(Item, Price, numItems, RoomTaxEntity, ItemTaxEntities, ItemTypeInfo, custIncluded)
  else
  if glb.LocateSpecificRecordAndGetValue('customers', 'Customer', g.qRackCustomer, 'StayTaxIncluted', custIncluded) then
    result := GetVATForItemEx(Item, Price, numItems, RoomTaxEntity, ItemTaxEntities, ItemTypeInfo, custIncluded)
  else
    result := GetVATForItemEx(Item, Price, numItems, RoomTaxEntity, ItemTaxEntities, ItemTypeInfo, NOT isStayTaxExcluded);
end;


function GetTaxesForInvoice(RoomTaxEntities : TInvoiceRoomEntityList;
                            ItemTaxEntities : TInvoiceItemEntityList;
                            ItemTypeInfo: TItemTypeInfo;
                            customerIncludeDefault : Boolean) : TInvoiceTaxEntityList;
var
  i: Integer;
  Tax : TTax;
  Room : TInvoiceRoomEntity;
  l: Integer;

  BookingItem : String;
  Description : String;
  NumItems : Double;
  Amount, baseAmount : Double;
  IncludedInPrice : TEnumTaxIncl_Excl;

  formula : String;
  parser : TRoomerMathParser;

  map : TInvoiceItemEntityDictionary;

  Percentage : Boolean;
  VatPercentage : Double;

begin
 //
  result := TInvoiceTaxEntityList.Create(True);

  map := FillHashMapWithValues(ItemTaxEntities);
  try

    Percentage := False;

    for l := 0 to taxList.Count - 1 do
    begin
      Tax := taxList[l];
      if TaxsIsCurrentlyValid(Tax) then
      begin
        Description := Tax.DESCRIPTION;
        BookingItem := Tax.BOOKING_ITEM;
        IncludedInPrice := Tax.INCL_EXCL;
        for i := 0 to RoomTaxEntities.Count - 1 do
        begin
          Room := RoomTaxEntities[i];
          formula := GetFilledInFormula(Tax.VALUE_FORMULA, Room, map);
          if (trim(formula) <> '') then
          begin
            parser := TRoomerMathParser.Create(nil);
            parser.Expression := formula;
            if parser.Parse then
              Amount := parser.ParserResult
            else
              Amount := Tax.AMOUNT;
          end else
          if Tax.TAX_TYPE = TT_FIXED_AMOUNT then
          begin
            Amount := Tax.AMOUNT;
            Percentage := False;
          end
          else begin
            Percentage := True;
            if Tax.NETTO_AMOUNT_BASED then
            begin
              if TaxIsIncluded(Tax, customerIncludeDefault) then
              begin
                baseAmount := Room.Price / (1 + ((Tax.AMOUNT + ItemTypeInfo.VATPercentage)/100)); // (Room.Price - Room.Vat)
                Amount :=  baseAmount * Tax.AMOUNT / 100;
              end else
              begin
                baseAmount := (Room.Price - Room.Vat);
                Amount :=  baseAmount * Tax.AMOUNT / 100;
              end;
            end else
            begin
              if TaxIsIncluded(Tax, customerIncludeDefault) then
              begin
                baseAmount := Room.Price / (1 + (Tax.AMOUNT/100)); // (Room.Price - Room.Vat)
                Amount :=  baseAmount * Tax.AMOUNT / 100;
  //              Amount :=  RoundTo(baseAmount * Tax.AMOUNT / 100, Tax.ROUND_VALUE)
              end else
              begin
                baseAmount := Room.Price;
                Amount :=  baseAmount * Tax.AMOUNT / 100;
              end;
            end;

  //          if TaxIsIncluded(Tax, customerIncludeDefault) then
  //            Amount :=  RoundTo(PriceAmount / (100 + Tax.AMOUNT) * Tax.AMOUNT, Tax.ROUND_VALUE)
  //          else
  //            Amount :=  RoundTo(PriceAmount * Tax.AMOUNT / 100, Tax.ROUND_VALUE)
          end;

          if Tax.TAX_BASE = TB_ROOM_NIGHT then
            NumItems := Room.Nights
          else
          if Tax.TAX_BASE = TB_GUEST_NIGHT then
            NumItems := Room.Nights * Room.Guests
          else
          if Tax.TAX_BASE = TB_ROOM then
            NumItems := 1
          else
          if Tax.TAX_BASE = TB_GUEST then
            NumItems := Room.Guests
          else
          if Tax.TAX_BASE = TB_BOOKING then
            NumItems := 1;

          result.Add(TInvoiceTaxEntity.Create(BookingItem, Description, NumItems, Amount, IncludedInPrice, Percentage));
        end;
      end;
    end;
  finally
    map.Free;
  end;
end;


function CalculateCityTax(rentAmount : double;
                          Currency : string;
                          Customer : String;
                          ReservationUsesStayTax : Boolean;
                          taxNights, taxGuests : integer): recCityTaxResultHolder;
var
  i                : integer;
  currencyRate     : double;
  StayTaxUnitCount : double;

  TaxesItem : string;

  isIncluted : boolean;
  isStayTaxPerCustomer : boolean;
  isStayTaxIncluded : boolean;
  isStayTaxPercentage : boolean;

  numItems : double;
  taxAmount : double;
  StayTaxAmount : double;

  RentVAT : double;
  CtaxVAT : double;

  CTaxWoVAT : double;

  nettoRent : double; // Rent minus incluted cititax;
  nettoRentWoVAT : double; // NettoRent minus incluted VAT

  dTmp : double;
  rentAmountExcl : Double;

  tax : TTax;

  taxItemCode : String;
begin
  CurrencyRate := GetRate(Currency);
  tax := currentlyValidTax;
  if itemTypeInfoRent.Itemtype = '' then
    itemTypeInfoRent := d.Item_Get_ItemTypeInfo(trim(g.qRoomRentItem));
  if itemTypeInfoTax.Itemtype = '' then
  begin
    itemTypeInfoTax  := d.Item_Get_ItemTypeInfo(trim(tax.BOOKING_ITEM));
  end;


  StayTaxAmount    := 0.00;
  StayTaxUnitCount := 0.00;

  initCityTaxResultHolder(result);

  if rentAmount <> 0 then
  begin
    if ReservationUsesStayTax then
    begin
      TaxesItem := tax.BOOKING_ITEM;

      if tax.TAX_BASE = TB_ROOM_NIGHT then // TB_ROOM_NIGHT, TB_GUEST_NIGHT, TB_ROOM, TB_BOOKING, TB_GUEST
        NumItems := 1
      else
      if tax.TAX_BASE = TB_GUEST_NIGHT then
        NumItems := taxGuests
      else
      if tax.TAX_BASE = TB_ROOM then
        NumItems := 1
      else
      if tax.TAX_BASE = TB_GUEST then
        NumItems := taxGuests
      else
      if tax.TAX_BASE = TB_BOOKING then
        NumItems := 1;

      taxAmount := tax.AMOUNT;

      isStayTaxPercentage   := tax.TAX_TYPE  = TT_PERCENTAGE;
      isStayTaxPerCustomer  := tax.INCL_EXCL  = TIE_PER_CUSTOMER; // isStayTaxPerCustomer;

      if isStayTaxPerCustomer then
      begin
        glb.LocateSpecificRecordAndGetValue('customers', 'Customer', Customer, 'StayTaxIncluted', isStayTaxIncluded);
      end else
      begin
        isStayTaxIncluded     := tax.INCL_EXCL = TIE_INCLUDED;
      end;

      if isStayTaxIncluded then
      begin
        if isStayTaxPercentage then
        begin
          if tax.NETTO_AMOUNT_BASED then
          begin
            rentAmountExcl := rentAmount / (1 + (itemTypeInfoRent.VATPercentage + taxAmount)/100);
            StayTaxAmount  := rentAmountExcl * taxAmount/100;
          end else
          begin
            rentAmountExcl := rentAmount / (1 + (itemTypeInfoRent.VATPercentage/100)) / (1 + (taxAmount/100));
            RentVAT        := rentAmountExcl * itemTypeInfoRent.VATPercentage / 100;
            StayTaxAmount  := (rentAmountExcl + RentVAT) * taxAmount/100;
          end;
          StayTaxAmount  := StayTaxAmount  * NumItems;
        end else
        begin
          stayTaxAmount := taxAmount*NumItems;
        end;
        nettoRent      := RentAmount-stayTaxAmount;
        RentVAT        := _calcVAT(nettoRent, itemTypeInfoRent.VATPercentage);
        CtaxVAT        := _calcVAT(stayTaxAmount, itemTypeInfoTax.VATPercentage);

        nettoRentWoVAT := nettoRent - RentVAT;
        CtaxWoVat      := stayTaxAmount - CtaxVat;
      end else
      begin
        if isStayTaxPercentage then
        begin
          if tax.NETTO_AMOUNT_BASED then
          begin
            rentAmountExcl := rentAmount / (1 + (itemTypeInfoRent.VATPercentage)/100);
            StayTaxAmount  := rentAmountExcl * taxAmount/100;
          end else
          begin
            rentAmountExcl := rentAmount;
            StayTaxAmount  := rentAmountExcl * taxAmount/100;
          end;
          StayTaxAmount  := StayTaxAmount  * NumItems;
        end else
        begin
          stayTaxAmount := taxAmount*NumItems;
        end;
        nettoRent      := RentAmount;
        RentVAT        := _calcVAT(nettoRent, itemTypeInfoRent.VATPercentage);
        CtaxVAT        := _calcVAT(stayTaxAmount, itemTypeInfoTax.VATPercentage);

        nettoRentWoVAT := nettoRent - RentVAT;
        CtaxWoVat      := stayTaxAmount - CtaxVat;
      end;
    end;
  end;

  result.CityTax       := StayTaxAmount;
  result.Incluted      := isStayTaxIncluded;
  result.RentAmount    := RentAmount;
  result.RentAmountVAT := RentVAT;
  result.CityTaxVAT    := CtaxVAT;

end;


{ TTax }

constructor TTax.Create(_id: Integer; _description: String;
                        _amount: Double;
                        _tax_Type,
                        _tax_Base,
                        _time_due,
                        _reTaxable,
                        _booking_item,
                        _incl_Excl,
                        _netto_Amount_Based,
                        _value_Formula: String;
                        _round_Value : Double;
                        _valid_From,
                        _valid_To : TDate);
begin
  ID := _id;
  DESCRIPTION := _description;
  AMOUNT := _amount;
  TAX_TYPE := getEnumTaxType(_tax_type);
  TAX_BASE := getEnumTaxBase(_tax_base);
  TIME_DUE := getEnumTaxDue(_time_due);
  RETAXABLE := UpperCase(_retaxable) = 'TRUE';
  BOOKING_ITEM := _booking_item;
  INCL_EXCL := getEnumTaxIncl_Excl(_incl_excl);
  NETTO_AMOUNT_BASED := UpperCase(_netto_Amount_Based) = 'TRUE';
  VALUE_FORMULA := _value_Formula;
  ROUND_VALUE := _round_Value;
  VALID_FROM := _valid_From;
  VALID_TO := _valid_To;
end;

function TTax.getEnumTaxType(_tax_type : String) : TEnumTaxType;
begin
  if _tax_type = 'PERCENTAGE' then
    result := TT_PERCENTAGE
  else
    result := TT_FIXED_AMOUNT;
end;

function TTax.getEnumTaxBase(_tax_base : String) : TEnumTaxBase;
begin
  if _tax_base = 'ROOM_NIGHT' then
    result := TB_ROOM_NIGHT
  else
  if _tax_base = 'GUEST_NIGHT' then
    result := TB_GUEST_NIGHT
  else
  if _tax_base = 'ROOM' then
    result := TB_ROOM
  else
  if _tax_base = 'BOOKING' then
    result := TB_BOOKING
  else
    result := TB_GUEST;
end;

function TTax.getEnumTaxDue(_tax_due : String) : TEnumTaxDue;
begin
  if _tax_due = 'PREPAID' then
    result := TD_PREPAID
  else
    result := TD_CHECKOUT;
end;

function TTax.getEnumTaxIncl_Excl(_incl_excl : String) : TEnumTaxIncl_Excl;
begin
  if _incl_excl = 'INCLUDED' then
    result := TIE_INCLUDED
  else
  if _incl_excl = 'EXCLUDED' then
    result := TIE_EXCLUDED
  else
    result := TIE_PER_CUSTOMER;
end;


//    TEnumTaxType = (TT_PERCENTAGE, TT_FIXED_AMOUNT);
//    TEnumTaxBase = (TB_ROOM_NIGHT, TB_GUEST_NIGHT, TB_ROOM, TB_BOOKING, TB_GUEST);
//    TEnumTaxDue = (TD_PREPAID, TD_CHECKOUT);
//    TEnumTaxIncl_Excl = (TIE_INCLUDED, TIE_EXCLUDED);


{ TTaxEntity }

constructor TInvoiceTaxEntity.Create(_BookingItem, _Description: String; _NumItems, _Amount: Double; _IncludedInPrice: TEnumTaxIncl_Excl; _Percentage : Boolean);
begin
  BookingItem := _BookingItem;
  Description := _Description;
  NumItems := _NumItems;
  Amount := _Amount;
  IncludedInPrice := _IncludedInPrice;
  Percentage := _Percentage;
end;

{ TRoomTaxEntity }

constructor TInvoiceRoomEntity.Create(_RoomItem: String; _Guests : integer; _Nights: double; _Price, _Vat: Double);
begin
  RoomItem := _RoomItem;
  Guests := _Guests;
  Nights := _Nights;
  Price := _Price;
  Vat := _Vat;
end;

function TInvoiceTaxEntity.GetTotal: Double;
begin
  result := NumItems * Amount;
end;

{ TInvoiceItemEntity }

constructor TInvoiceItemEntity.Create(_Item: String; _NumItems, _Price, _Vat: Double);
begin
  Item := _Item;
  NumItems := _NumItems;
  Price := _Price;
  Vat := _Vat;
end;

function TInvoiceItemEntity.GetPriceExcl: Double;
begin
  result := Price - Vat;
end;

initialization
  TaxList := TTaxList.Create(True);
  itemTypeInfoRent.Itemtype := '';
  itemTypeInfoTax.Itemtype := '';


finalization

  TaxList.Clear;
  TaxList.Free;

end.
