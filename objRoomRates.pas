unit objRoomRates;

interface

uses
  Windows
  , Messages
  , SysUtils
  , Variants
  , Classes
  , Contnrs
  , Dialogs
  , NativeXML
  , ADODB
  , uUtils
  , cmpRoomerDataSet
  , cmpRoomerConnection
  , System.Generics.Collections
  ;

TYPE

  TRateItem = class
    FReservation         : integer   ;
    FRoomReservation     : integer   ;
    FRoomNumber          : string    ;
    FRateDate            : TDateTime ;
    FPriceCode           : string    ;
    FRate                : double    ;
    FDiscount            : Double    ;
    FisPercentage        : boolean   ;
    FShowDiscount        : boolean   ;
    FisPaid              : boolean   ;


    function getRate         : Double    ;
    function getRateDate     : TdateTime ;
    function getDiscount     : Double    ;
    function GetIsPercentage : boolean   ;
    function GetShowDiscount : boolean   ;
    function GetIsPaid       : boolean   ;
    function GetPriceCode    : string    ;
    function GetRoomNumber   : string    ;
    function GetReservation      : integer ;
    function GetRoomReservation  : integer ;

    procedure SetRate(Value : double);
    procedure SetRateDate(Value : TDateTime);
    procedure SetDiscount(Value : double);
    procedure SetShowDiscount(Value : boolean);
    procedure SetIsPercentage(Value : boolean);
    procedure SetISPaid(Value : boolean);
    procedure SetPriceCode(Value : string);
    procedure SetRoomNumber(Value : string);
    procedure SetReservation(Value : integer);
    procedure SetRoomReservation(Value : integer);

  public
    constructor Create(aRate : double;
                       aRateDate : TDateTime;
                       aDiscount :double;
                       aShowDiscount
                      ,aIsPercentage
                      ,aIsPaid : boolean;
                       aPriceCode
                      ,aRoomNumber : string;
                       aReservation
                      ,aRoomReservation : integer
                      );
    destructor Destroy; override;

    property Rate             : double    read  getRate          write setRate            ;
    property RateDate         : TDateTime read  getRateDate      write setRateDate        ;

    property Discount         : Double    read getDiscount       write setDiscount        ;
    property ShowDiscount     : boolean   read getShowDiscount   write setShowDiscount    ;

    property isPercentage     : boolean   read getisPercentage   write setIsPercentage    ;
    property isPaid           : boolean   read getisPaid         write setIsPaid          ;
    property priceCode        : string    read getPriceCode      write setPriceCode       ;

    property RoomNumber       : string    read getRoomNumber      write setRoomNumber     ;
    property Reservation      : integer   read getReservation     write setReservation    ;
    property RoomReservation  : integer   read getRoomReservation write setRoomReservation;
  end;

//////////////////////////////////////////////////////////////////////////////
//  TSelectedRoomItem
//////////////////////////////////////////////////////////////////////////////

  TRateItemsList = TObjectList<TRateItem>;

  //////////////////////////////////////////////////////////////////////////////////////
  /// TRates
  /////////////////////////////////////////////////////////////////////////////////////

  TRates = class
  private
    FHotelcode   : string;
    FXmlFileName : string;

    FRateCount   : integer;
    FRateList    : TRateItemsList;
    FCurrency    : String;

    function getRateCount : integer;

  public
    constructor Create(aHotelCode : string);
    destructor Destroy; override;

    function getCurrency : string;
    procedure SetCurrency(Value : string);

    function getPriceID : integer;
    procedure SetPriceID(Value : integer);

    function GetDayRate(RoomType: string;
                        RoomNumber   : string;
                        aDate        : TDateTime;
                        GuestCount   : integer;
                        ChildCount   : integer;
                        infantCount  : integer;
                        Currency     : string;
                        PriceID      : integer;
                        Discount     : double;
                        showDiscount : boolean;
                        isPercentage : boolean;
                        isPaid       : boolean;
                        doAdd        : boolean
                        ): double;

    property Hotelcode      : string read FHotelcode   write FHotelcode;
    property XmlFileName    : string read FXmlFileName write FXmlFileName;

    function FindRateByDate(aDate : TDateTime; StartAt : integer) : integer;
    function FindRoomAndDate(RoomNumber: string;aDate: TdateTime; StartAt: integer): integer;
    property RateItemsList : TRateItemsList read FRateList write FRateList;
    property RateCount : integer read getRateCount;
    property Currency : string  read getCurrency write setCurrency;

  end;

implementation

uses
  _Glob
  ,uSqlDefinitions
  ,hData
  ;

//////////////////////////////////////////////////////////////////////////////
//  TRateItem
//////////////////////////////////////////////////////////////////////////////

constructor TRateItem.Create(aRate : double;
                       aRateDate : TDateTime;
                       aDiscount :double;

                       aShowDiscount
                      ,aIsPercentage
                      ,aIsPaid : boolean;

                       aPriceCode
                      ,aRoomNumber : string;
                      aReservation
                      ,aRoomReservation : integer


                      );
begin
  setRate(aRate);
  setRateDate(aRateDate);
  setDiscount(aDiscount);
  setIsPercentage(aIsPercentage);
  setIsPaid(aIsPaid);
  setPriceCode(aPriceCode);
  setShowDiscount(aShowDiscount);
  setRoomNumber(aRoomNumber);
  setReservation(aReservation);
  setRoomReservation(aRoomReservation);
end;

destructor TRateItem.Destroy;
begin
  inherited;
end;

function TRateItem.getDiscount: Double;
begin
  result := FDiscount;
end;

function TRateItem.GetIsPaid: boolean;
begin
  result := FIsPaid;
end;

function TRateItem.GetIsPercentage: boolean;
begin
  result := FIsPercentage
end;

function TRateItem.GetPriceCode: string;
begin
  result := FPriceCode;
end;

function TRateItem.getRate: double;
begin
  result := FRate
end;

function TRateItem.getRateDate : TDateTime;
begin
  result := FRateDate
end;

function TRateItem.GetReservation: integer;
begin
  result := FReservation;
end;

function TRateItem.GetRoomNumber: string;
begin
  result := FRoomNumber;
end;

function TRateItem.GetRoomReservation: integer;
begin
  result := FRoomReservation;
end;

function TRateItem.GetShowDiscount: boolean;
begin
  result := FShowDiscount;
end;

procedure TRateItem.SetDiscount(Value: double);
begin
  FDiscount := value;
end;

procedure TRateItem.SetISPaid(Value: boolean);
begin
  FIsPaid := Value;
end;

procedure TRateItem.SetIsPercentage(Value: boolean);
begin
  FIsPercentage := Value;
end;

procedure TRateItem.SetPriceCode(Value: string);
begin
  FPriceCode := Value;
end;

procedure TRateItem.SetRate(Value : double);
begin
  FRate := value;
end;

procedure TRateItem.SetRateDate(Value : TDateTime);
begin
  FRateDate := value;
end;

procedure TRateItem.SetReservation(Value: integer);
begin
  FReservation := value;
end;

procedure TRateItem.SetRoomNumber(Value: string);
begin
  FRoomNumber := value;
end;

procedure TRateItem.SetRoomReservation(Value: integer);
begin
  FRoomreservation := value;
end;

procedure TRateItem.SetShowDiscount(Value: boolean);
begin
  FShowDiscount := value;
end;

//////////////////////////////////////////////////////////////////////
{TRates}
//////////////////////////////////////////////////////////////////////
constructor TRates.Create(aHotelCode : string);
begin
  inherited Create;
  try
    FRateList := TRateItemsList.Create(True);
  Except
    //TODO Loga
  end;
  FRateCount := 0;
end;

destructor TRates.Destroy;
begin
  freeandnil(FRateList);
  inherited;
end;

function TRates.FindRoomAndDate(RoomNumber: string;aDate: TdateTime; StartAt: integer): integer;
var
  i       : integer;
  tmpRoom : string;
  tmpDate : Tdate;
begin
  aDate  := trunc(date);
  result := -1;
  if StartAt > FRateList.Count-1 then exit;

  RoomNumber := ansiLowercase(RoomNumber);

  for i := startAt to FRateList.Count -1 do
  begin
    tmpRoom := FRateList[i].FRoomNumber;
    tmpDate := trunc(FRateList[i].FRateDate);
    if (RoomNumber = tmproom) and (tmpDate = aDate) then
    begin
      result := i;
      Break;
    end;
  end;
end;


function TRates.FindRateByDate(aDate : TDateTime; StartAt : integer) : integer;
var
  i : integer;
  tmpDate : TdateTime;
begin
  result := -1;
  if StartAt > FRateList.Count-1 then exit;

  for i := startAt to FRateList.Count -1 do
  begin
    tmpDate := FRateList[i].FRateDate;

    if tmpDate = aDate then
    begin
      result := i;
      Break;
    end;
  end;
end;

function TRates.getCurrency: string;
begin
  result := FCurrency;
end;


function TRates.getPriceID: integer;
begin
  result := 0;
end;


procedure TRates.SetCurrency(Value: string);
begin
  FCurrency := Value;
end;

procedure TRates.SetPriceID(Value: integer);
begin
  //**
end;

function TRates.getRateCount: integer;
begin
  result := FRateList.Count;
end;

function TRates.GetDayRate(RoomType     : string;
                           RoomNumber   : string;
                           aDate        : TDateTime;
                           GuestCount   : integer;
                           ChildCount   : integer;
                           infantCount  : integer;
                           Currency     : string;
                           PriceID      : integer;
                           Discount     : double;
                           showDiscount : boolean;
                           isPercentage : boolean;
                           isPaid       : boolean;
                           doAdd : boolean
                           ): double;

var
  rSet : TRoomerDataSet;
  s: string;
  ExtraPrice: double;
  p1, p2, p3, p4, p5, p6 : double;
//  Price: double;
  extraPersons: double;
  oRateItem : TRateItem;
  priceCode : string;
//  iDateCount : integer;
  Description : string;

  RateExtraChildren : double;
  RateExtraInfant   : double;

begin
  result := 0;
  extraPersons := GuestCount - 5;
//  Price      := 0.00;


  if GuestCount < 1 then
  begin
    exit;
  end;

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

  rSet := TRoomerDataSet.Create(nil);
  try
    s := format(s , [priceID,_db(currency),_db(RoomType),_db(aDate),_db(aDate)]);
    hData.rSet_bySQL(rSet,s);
//    CopyToClipboard(s);
//    DebugMessage('select_objRoomRates_GetDayRate'#10+'  '+s);


    if not rSet.eof then
    begin
//      iDateCount := Rset.fieldbyname('DateCount').asInteger;
      description := rSet.fieldbyname('description').AsString;

      RateExtraChildren := rSet.GetFloatValue(Rset.fieldbyname('RateExtraChildren'));
      RateExtraInfant   := rSet.GetFloatValue(Rset.fieldbyname('RateExtraInfant'));

      ExtraPrice := rSet.GetFloatValue(Rset.fieldbyname('RateExtraPerson'));
      p1 := rSet.GetFloatValue(Rset.fieldbyname('Rate1Person'));
      p2 := rSet.GetFloatValue(Rset.fieldbyname('Rate2Persons'));
      p3 := rSet.GetFloatValue(Rset.fieldbyname('Rate3Persons'));
      p4 := rSet.GetFloatValue(Rset.fieldbyname('Rate4Persons'));
      p5 := rSet.GetFloatValue(Rset.fieldbyname('Rate5Persons'));
      p6 := rSet.GetFloatValue(Rset.fieldbyname('Rate6Persons'));

      if p1 = 0 then p1 := ExtraPrice;
      if p2 = 0 then p2 := p1 + ExtraPrice;
      if p3 = 0 then p3 := p2 + ExtraPrice;
      if p4 = 0 then p4 := p3 + ExtraPrice;
      if p5 = 0 then p5 := p4 + ExtraPrice;
      if p6 = 0 then p6 := p5 + ExtraPrice;

      if GuestCount = 1 then result := p1;
      if GuestCount = 2 then result := p2;
      if GuestCount = 3 then result := p3;
      if GuestCount = 4 then result := p4;
      if GuestCount = 5 then result := p5;
      if GuestCount = 6 then result := p6;

      if GuestCount > 6 then result := p6 + (extraPersons * ExtraPrice);

      result := result+(RateExtraChildren * ChildCount);
      result := result+(RateExtraInfant * infantCount);
    end;
  finally
    freeandNil(rSet);
  end;

  priceCode := hdata.PriceCode_Code(priceID);

  if doAdd then
  begin
    oRateItem := TRateItem.Create(result,aDate,discount,showDiscount,isPercentage,isPaid,priceCode,RoomNumber,-1,-1);
    self.FRateList.Add(oRateItem);
  end;
end;

end.
