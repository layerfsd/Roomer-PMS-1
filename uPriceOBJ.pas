unit uPriceOBJ;

{$M+}

interface

uses
  Forms,
  windows,
  SysUtils,
  Controls,
  Classes,
  messages,
  dialogs,
  ADODB,
  _glob,
  uUtils,
  ug,
  cmpRoomerDataSet,
  cmpRoomerConnection
  ;

type

{$M+}
  TPricesObject = class(TObject)
  private
    FPriceType : string;
    FDescription : string;
    FFromDate, FToDate : TDate;
    FPrice : Double;
    FTotal : Double;
  public
    constructor create(PriceType : string; Description : string; FromDate, ToDate : TDate; Price : Double);
    destructor Destroy; override;
  published
    property PriceType : string read FPriceType write FPriceType;
    property Description : string read FDescription write FDescription;

    property FromDate : TDate read FFromDate write FFromDate;
    property ToDate : TDate read FToDate write FToDate;
    property Price : Double read FPrice write FPrice;
    property Total : Double read FTotal write FTotal;
  end;

  TPrices = class(TObject)
  private
    FPriceObjects : TList;
    FTotal : Double;
    function GetPriceObject(idx : integer) : TPricesObject;
    function GetPricesCount : integer;
    procedure Clear;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddPrice(PriceType : string; Description : string; FromDate, ToDate : TDate; Price : Double);
    property Prices[idx : integer] : TPricesObject read GetPriceObject;
    property PricesCount : integer read GetPricesCount;
{$M+}
  published
    property Total : Double read FTotal write FTotal;
{$M-}
  end;

function GetPrices(PriceTypeCode, RoomType : string; FromDate, ToDate : TDate; NumGuest : integer; Currency : string) : TPrices;

implementation

uses
    ud
  , hData
  , uSqlDefinitions

;

constructor TPricesObject.create(PriceType : string; Description : string; FromDate, ToDate : TDate; Price : Double);
begin
  // --
  inherited create;
  FPriceType    := PriceType;
  FDescription  := Description;
  FFromDate     := FromDate;
  FToDate       := ToDate;
  FPrice        := Price;
  FTotal        := (trunc(FToDate) - trunc(FFromDate)) * FPrice;
end;

destructor TPricesObject.destroy;
begin
  // --
  inherited destroy;
end;

{ TPrices }

constructor TPrices.create;
begin
  // --
  FPriceObjects := TList.create;

end;

destructor TPrices.destroy;
begin
  // --
  Clear;
  FPriceObjects.free;
  FTotal := 0;
end;

procedure TPrices.Clear;
var
  i : integer;
begin
  for i := FPriceObjects.count - 1 downto 0 do
  begin
    TPricesObject(FPriceObjects[i]).free;
    FPriceObjects.delete(i);
  end;
end;

function TPrices.GetPriceObject(idx : integer) : TPricesObject;
begin
  result := TPricesObject(FPriceObjects[idx]);
end;

function TPrices.GetPricesCount : integer;
begin
  result := FPriceObjects.count;
end;

procedure TPrices.AddPrice(PriceType : string; Description : string; FromDate, ToDate : TDate; Price : Double);
var
  PricesObject : TPricesObject;
begin
  PricesObject := TPricesObject.create(PriceType, Description, FromDate, ToDate, Price);
  FPriceObjects.Add(PricesObject);
  FTotal := FTotal + (Price * (trunc(ToDate) - trunc(FromDate)));
end;

// -----------

function GetPrices(PriceTypeCode, RoomType : string; FromDate, ToDate : TDate; NumGuest : integer; Currency : string) : TPrices;
var
  rSet : TRoomerDataset;

  s : string;
  priceCodeId : integer;
  seasonID : integer;

  Price : Double;
  rtID : integer;

  RangeStart, RangeEnd : TDate;

  rackID : integer;
begin
  rSet := CreateNewDataSet;
  try
    rSet.CommandType := cmdText;

    if Currency = '' then
      Currency := ctrlGetString('NativeCurrency');

    priceCodeId := PriceCode_ID(PriceTypeCode);

    result := TPrices.create;

    s := s+' SELECT '#10;
    s := s+'  `wroomrates`.`ID`, '#10;
    s := s+'  `wroomrates`.`PriceCodeID`, '#10;
    s := s+'  `wroomrates`.`pcCode`, '#10;
    s := s+'  `wroomrates`.`pcRack`, '#10;
    s := s+'  `wroomrates`.`CurrencyID`, '#10;
    s := s+'  `wroomrates`.`Currency`, '#10;
    s := s+'  `wroomrates`.`SeasonID`, '#10;
    s := s+'  `wroomrates`.`seStartDate`, '#10;
    s := s+'  `wroomrates`.`seEndDate`, '#10;
    s := s+'  `wroomrates`.`seDescription`, '#10;
    s := s+'  `wroomrates`.`RoomTypeID`, '#10;
    s := s+'  `wroomrates`.`RoomType`, '#10;
    s := s+'  `wroomrates`.`NumberGuests`, '#10;
    s := s+'  `wroomrates`.`RateID`, '#10;
    s := s+'  `wroomrates`.`RateCurrency`, '#10;
    s := s+'  `wroomrates`.`Rate1Person`, '#10;
    s := s+'  `wroomrates`.`Rate2Persons`, '#10;
    s := s+'  `wroomrates`.`Rate3Persons`, '#10;
    s := s+'  `wroomrates`.`Rate4Persons`, '#10;
    s := s+'  `wroomrates`.`Rate5Persons`, '#10;
    s := s+'  `wroomrates`.`Rate6Persons`, '#10;
    s := s+'  `wroomrates`.`RateExtraPerson`, '#10;
    s := s+'  `wroomrates`.`RateExtraChildren`, '#10;
    s := s+'  `wroomrates`.`RateExtraInfant`, '#10;
    s := s+'  `wroomrates`.`rateDescription`, '#10;
    s := s+'  `wroomrates`.`Active`, '#10;
    s := s+'  `wroomrates`.`DateFrom`, '#10;
    s := s+'  `wroomrates`.`DateTo`, '#10;
    s := s+'  `wroomrates`.`Description`, '#10;
    s := s+'  `wroomrates`.`DateCreated`, '#10;
    s := s+'  `wroomrates`.`LastModified`, '#10;
    s := s+'   DATEDIFF(DateTo,DateFrom) AS DateCount '#10;
    s := s+'FROM '#10;
    s := s+'  `wroomrates` '#10;
    s := s+'WHERE '#10;
    s := s+'  `PriceCodeID` = %d AND '#10;
    s := s+'  `Currency` = %s AND '#10;
    s := s+'  `RoomType` = %s AND '#10;
    s := s+'  `DateFrom` <= %s AND '#10;
    s := s+'  `DateTo` >= %s '#10;
    s := s+'ORDER BY DateCount '#10;
    s := s+'LIMIT 0,1 '#10;


    s := format(select_PriceOBJ_GetPrices , [priceCodeId,quotedSTR(Currency),quotedSTR(RoomType)]);
		// CopyToClipboard(s);
    // DebugMessage(''#10#10+s);
    hData.rSet_bySQL(rSet,s);
    rSet.first;
    // RSet inniheldur allar verðskrár í Verðkóðanum í sama gengi og herbergjatýpu

    if rSet.eof then
      exit; // ekkert verð fannst

    while not rSet.eof do
    begin
      seasonID := rSet.fieldbyname('seId').AsInteger;
      RangeStart := 0;
      RangeEnd := 0;
      if d.inDateRange(seasonID, FromDate, ToDate, RangeStart, RangeEnd) then
      begin
        rtID := rSet.fieldbyname('Id').AsInteger;
        Price := d.getPrice_2(rtID, NumGuest);

        if Price <> 0 then
        begin
          if Price < 3 then
          begin
            rackID := d.getRackPriceID_1(seasonID, RoomType, Currency);
            if rackID > 0 then
            begin
              Price := _priceRound(d.getPrice_2(rackID, NumGuest) * Price, 50, 2);
            end;
          end;
        end;

        result.AddPrice(PriceTypeCode, rSet.fieldbyname('Description').asstring, RangeStart, RangeEnd - 1, Price);
        // if g.qArrivalDateRulesPrice then break;
      end;
      rSet.next;
    end;
  finally
    freeandnil(rSet);
  end;
end;

end.
