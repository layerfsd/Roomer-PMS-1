unit uInvoiceEntities;

interface

uses
  Generics.Collections
  ;

type
  TInvoiceRoomEntity = class
  private
    FReservation: integer;
    FRoomReservation: integer;
    FRoomItem: String;
    FName: string;
    FRoom: string;
    FFrom: TDateTime;
    FTo: TDateTime;
    FNights: double;       // should be integer
    FVat: Double;
    FNumPersons: integer;
    FNumChildren: integer;
    FPrice: Double;
    FDiscount: Double;
    FBreakfastIncluded: boolean;
  public
    constructor Create; overload;
    constructor Create(_RoomItem: String; _Guests: Integer; _Children: Integer; _Nights: double; _Price: Double;
      _Vat: Double; _Discount: Double; _BreakfastIncluded: boolean); overload;

    property Reservation: integer read FReservation write FReservation;
    property RoomReservation: integer read FRoomReservation write FRoomreservation;
    property Room: string read FRoom write FRoom;
    property RoomItem: string read FRoomItem;
    property Name: string read FName write FName;
    property Arrival: TDateTime read FFrom write FFrom;
    property Departure: TDateTime read FTo write FTo;

    property Price: double read FPrice write FPrice;
    property Discount: double read FDiscount write FDiscount;
    property Vat: double read FVat write FVat;
    property BreakfastIncluded: boolean read FBreakfastIncluded write FBreakfastIncluded;
    property NumGuests: integer read FNumPersons write FNumPersons;
    property NumChildren: integer read FNumChildren write FNUmChildren;
    property Nights: double read FNights write FNights;
  end;

  TInvoiceItemEntity = class
  private
    FItem: String;
    FNumItems, FPrice, FVat: Double;
    function GetPriceExcl: Double;
  public
    constructor Create(_Item: String; _NumItems, _Price, _Vat: Double);

    property Item: string read FItem;
    property Price: double read FPrice;
    property NumItems: double read FNumItems;
    property VAT: double read FVat;
    property TotalWOVat: Double read GetPriceExcl;
  end;

  TInvoiceItemEntityDictionary = TObjectDictionary<String, TInvoiceItemEntity>;

  TInvoiceRoomEntityList = class(TObjectList<TInvoiceRoomEntity>)
  private
    function GetIncludedBreakfastCount: integer;
  public
    property IncludedBreakfastCount: integer read GetIncludedBreakfastCount;
  end;

  TInvoiceItemEntityList = class(TObjectList<TInvoiceItemEntity>)
  private
    function GetTotalPrice(aItem: string): double;
    function GetTotalVat(aItem: string): double;
  public
    property TotalPrice[aItem: string]: double read GetTotalPrice;
    property TotalVat[aItem: string]: double read GetTotalVat;
  end;

implementation

uses
  SysUtils
  ;

constructor TInvoiceRoomEntity.Create(_RoomItem: String; _Guests: Integer; _Children: Integer; _Nights: double;
  _Price, _Vat, _Discount: Double; _BreakFastIncluded: boolean);
begin
  FRoomItem := _RoomItem;
  FNumPersons:= _Guests;
  FNumChildren := _Children;
  FNights := _Nights;
  FPrice := _Price;
  FDiscount := _Discount;
  FVat := _Vat;
  FBreakFastIncluded := _BreakFastIncluded;
end;

{ TInvoiceItemEntity }

constructor TInvoiceItemEntity.Create(_Item: String; _NumItems, _Price, _Vat: Double);
begin
  FItem := _Item;
  FNumItems := _NumItems;
  FPrice := _Price;
  FVat := _Vat;
end;

function TInvoiceItemEntity.GetPriceExcl: Double;
begin
  result := FPrice - FVat;
end;

{ TInvoiceItemEntityList }

function TInvoiceItemEntityList.GetTotalPrice(aItem: string): double;
var
  lItem: TInvoiceItemEntity;
begin
  Result := 0.0;
  for lItem in Self do
    if aItem.Equals(lItem.Item) then
      Result := Result + (lItem.Price * lItem.NumItems);
end;

function TInvoiceItemEntityList.GetTotalVat(aItem: string): double;
var
  lItem: TInvoiceItemEntity;
begin
  Result := 0.0;
  for lItem in Self do
    if aItem.Equals(lItem.Item) then
      Result := Result + (lItem.Vat* lItem.NumItems);
end;

constructor TInvoiceRoomEntity.Create;
begin

end;

{ TInvoiceRoomEntityList }

function TInvoiceRoomEntityList.GetIncludedBreakfastCount: integer;
var
  lRoomEnt: TInvoiceRoomEntity;
begin
  Result := 0;
  for lRoomEnt in Self do
    if lRoomEnt.BreakfastIncluded then
      inc(Result, lRoomEnt.NumGuests * trunc(lRoomEnt.Nights));
end;

end.
