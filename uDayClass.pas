unit uDayClass;

interface

Uses
   Windows
  ,Messages
  ,SysUtils
  ,Classes
  ,Forms
  ,Controls
  ,IniFiles
  ,xprocs
  ,dialogs
  ,hjdateUtil
  ;


TYPE
  TDayPriceObject = class( TObject )
  private
    FDate         : Tdate   ;
    FWeekday      : integer ; //mánudagur=1 .. sunnudagur=7
    FNightNo      : Integer ;
    FHoliDaylevel : integer ; //1..5
    FPersonPrice  : Float   ; // Price without Discount or Extra

    FWeekDayExtra : Float   ; // Extra Amount for weekday
    FHoliDayExtra : Float   ; // Extra Amount for Holliday
    FDiscountExtra: Float   ; // Discount in Currency

    FPrice        : Float   ; // Th price for that day

  public
    constructor create(
                         Date          : Tdate;
                         Weekday       ,
                         NightNo      ,
                         HoliDaylevel : integer ; //1..5
                         PersonPrice    ,

                         WeekDayExtra   ,
                         HoliDayExtra   ,
                         DiscountExtra  ,

                         Price        : Float
                       );
    destructor destroy; override;

  published
    property  Date          : Tdate   read FDate          write FDate        ;
    property  Weekday       : integer read FWeekday       write FWeekday     ;
    property  NightNo       : integer read FNightNo       write FNightNo     ;
    property  HoliDaylevel  : integer read FHoliDaylevel  write FHoliDaylevel   ;
    property  PersonPrice   : Float   read FPersonPrice   write FPersonPrice    ;
    property  WeekDayExtra  : Float   read FWeekDayExtra  write FWeekDayExtra   ;
    property  HoliDayExtra  : Float   read FHoliDayExtra  write FHoliDayExtra   ;
    property  DiscountExtra : Float   read FDiscountExtra write FDiscountExtra  ;
    property  Price         : Float   read FPrice         write FPrice       ;
  end;



  TDayPriceList = class( TObject )
  private
    FDayPrices    : TList;
    FTotal        : double;
    function  GetDayPriceObject( idx : integer ) : TDayPriceObject;
    function  GetDayPriceCount : integer;
  public
    constructor Create;
    destructor  Destroy; override;
    procedure Clear;
    procedure   AddDayPrice(
                             Date         : Tdate;
                             Weekday      ,
                             NightNo      ,
                             HoliDaylevel : integer ; //1..5
                             PersonPrice  ,
                             WeekDayExtra ,
                             HoliDayExtra ,
                             DiscountExtra,
                             Price        : Float
                            );

    property DayPrice[idx : integer ] : TdayPriceObject read GetDayPriceObject;
    property DayPriceCount : integer read GetDayPriceCount;
  published
    property Total : double read FTotal write FTotal;
  end;




implementation
uses
  uD;


constructor TDayPriceObject.create(
                         Date          : Tdate;
                         Weekday       ,
                         NightNo      ,
                         HoliDaylevel : integer ; //1..5
                         PersonPrice  ,
                         WeekDayExtra ,
                         HoliDayExtra ,
                         DiscountExtra,
                         Price        : Float
                       );
begin
   inherited create;
   FDate          := Date         ;
   FWeekday       := Weekday      ;
   FNightNo       := NightNo      ;
   FHoliDaylevel  := HoliDaylevel ;
   FPersonPrice   := PersonPrice  ;
   FWeekDayExtra  := WeekDayExtra ;
   FHoliDayExtra  := HoliDayExtra ;
   FDiscountExtra := DiscountExtra;
   FPrice         := Price        ;
end;

destructor TDayPriceObject.destroy;
begin
  // --
  inherited destroy;
end;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

constructor TDayPriceList.create;
begin
  FDayPrices := TList.create;
end;

destructor TDayPriceList.destroy;
begin
  clear;
  FDayPrices.free;
  FTotal := 0;
end;

procedure TDayPriceList.Clear;
var
  i : integer;
begin
  // --
  for i := FDayPrices.count - 1 downto 0 do
  begin
    TDayPriceList(FDayPrices[ i ] ).free;
    FDayPrices.delete( i );
  end;
end;

function TDayPriceList.GetDayPriceObject( idx : integer ) : TDayPriceObject;
begin
   result := TDayPriceObject( FDayPrices[ idx ] );
end;

function TDayPriceList.GetDayPriceCount : integer;
begin
  // --
  result := FDayPrices.count;
end;

procedure TDayPriceList.AddDayPrice(
                                   Date          : Tdate;
                                   Weekday       ,
                                   NightNo      ,
                                   HoliDaylevel : integer ; //1..5
                                   PersonPrice  ,
                                   WeekDayExtra ,
                                   HoliDayExtra ,
                                   DiscountExtra,
                                   Price        : Float
                                );

var
  DayPrice : TDayPriceObject;

begin
  // --
  DayPrice := TDayPriceObject.create(
                                       Date         ,
                                       Weekday      ,
                                       NightNo      ,
                                       HoliDaylevel ,
                                       PersonPrice  ,
                                       WeekDayExtra ,
                                       HoliDayExtra ,
                                       DiscountExtra,
                                       Price
                                    );

  FDayPrices.Add(DayPrice);
  // Reikna Hér
  FTotal := FTotal + 1;//( Price * ( trunc( toDate ) - trunc( FromDate ) ) );
end;




end.
