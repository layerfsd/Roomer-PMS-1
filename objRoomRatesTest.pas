unit objRoomRatesTest;

interface


uses
  Windows
  , Messages
  , SysUtils
  , Variants
  , Classes
  , Contnrs
  , Dialogs
  , clipBrd
  , NativeXML
  , ADODB
  ;


TYPE

  TRateItem = class
    FRate                : double    ;

    function getRate         : Double    ;

    procedure SetRate(Value : double);

  private
    // **
  published
    // **
  public
    constructor Create(aRate : double);
    destructor Destroy; override;

    property Rate        : double    read  getRate       write setRate      ;
  end;


//////////////////////////////////////////////////////////////////////////////
//  TSelectedRoomItem
//
//////////////////////////////////////////////////////////////////////////////

  TRateItemsList = class(TObjectList)
  private
    function GetItem(aIndex : integer) : TRateItem;
    procedure SetItem(aIndex : integer; const Value : TRateItem);
  public
    constructor Create;
    destructor Destroy; override;

    function Add(Item : TRateItem) : integer;
    procedure Insert(aIndex : integer; Item : TRateItem);

    property Items[aIndex : integer] : TRateItem read GetItem write SetItem; default;
  end;


  //////////////////////////////////////////////////////////////////////////////////////
  /// TRates
  /////////////////////////////////////////////////////////////////////////////////////

  TRates = class
  private
    FRateCount   : integer;
    FRateList    : TRateItemsList;
    function getRateCount : integer;
  public
    constructor Create();
    destructor Destroy; override;
    property RateItemsList : TRateItemsList read FRateList write FRateList;
    property RateCount : integer read getRateCount;
  end;

implementation


//////////////////////////////////////////////////////////////////////////////
//  TRateItem
//////////////////////////////////////////////////////////////////////////////

constructor TRateItem.Create(aRate : double);
begin
  setRate(aRate);
end;

destructor TRateItem.Destroy;
begin
  inherited;
end;

function TRateItem.getRate: double;
begin
  result := FRate
end;

procedure TRateItem.SetRate(Value : double);
begin
  FRate := value;
end;

//////////////////////////////////////////////////////////////
{ TRateItemsList }
//////////////////////////////////////////////////////////////

constructor TRateItemsList.Create;
begin
  inherited Create(true);
end;

destructor TRateItemsList.Destroy;
begin
  inherited Destroy;
end;

function TRateItemsList.GetItem(aIndex: integer): TRateItem;
begin
  result := inherited GetItem(aIndex) as TRateItem;
end;

procedure TRateItemsList.SetItem(aIndex: integer; const Value: TRateItem);
begin
  inherited SetItem(aIndex, Value);
end;

function TRateItemsList.Add(Item: TRateItem): integer;
begin
  result := inherited Add(Item);
end;

procedure TRateItemsList.Insert(aIndex: integer; Item: TRateItem);
begin
  inherited Insert(aIndex, Item);
end;

//////////////////////////////////////////////////////////////////////
{TRates}
//////////////////////////////////////////////////////////////////////
constructor TRates.Create();
begin
  inherited Create;
  try
    FRateList := TRateItemsList.Create;
  Except
    //TODO Loga
  end;
end;

destructor TRates.Destroy;
begin
  freeandnil(FRateList);
  inherited;
end;

function TRates.getRateCount: integer;
begin
  result := FRateList.Count;
end;

end.
