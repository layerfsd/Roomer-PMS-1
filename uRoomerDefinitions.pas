unit uRoomerDefinitions;

interface

uses Graphics;

const
  cHotelInvoice  = 0;
  cCreditInvoive = 1;
  cCashInvoice   = 2;

const
  qcCompany        = 'Roomer';
  qcApplication    = 'Roomer PMS';
  testCompanyID    = '00';
  testCompanyName  = 'Hotel Trial';
  testExpDate      = 30;
  testRoomCount    = 10;
  testMeetingsRoomCount = 0;
  testConnStr      = '';
  testConnStr2     = '';
  testDiskSerial   = 'HHHH-JJJJ';

  TIM_MILLI_SECOND = 1;
  TIM_SECOND       = TIM_MILLI_SECOND * 1000;
  TIM_MINUTE       = TIM_SECOND * 60;
  TIM_15_MINUTES   = TIM_MINUTE * 15;
  TIM_HALF_HOUR    = TIM_MINUTE * 30;
  TIM_HOUR         = TIM_MINUTE * 60;
  TIM_DAY          = TIM_HOUR * 24;

const
  peExportNot     = 0;
  peExportFolder  = 1;
  peExportLogFile = 2;

  PAYMENT_GUARANTEE_TYPE : Array[0..2] of String = ('CREDIT_CARD','DOWN_PAYMENT','NONE');

const
  RESERVATION_STATUS_STRING = 'PGDCONABCWZX';

type
  TReservationMarketType = (Unknown = -1, Leisure=0, Business=1);

  TReservationMarketTypeHelper = record helper for TReservationMarketType
  const
    RESERVATIONMARKET_TYPE : array[TReservationMarketType] of string = ('', 'LEISURE', 'BUSINESS');
  public
    class function FromString(const aStr: string): TReservationMarketType; static;// constructor;
    function ToDBString: string;
    function ItemIndex: integer;
  end;

  recStatusAttr = record
    backgroundColor : TColor;
    fontColor	      : TColor;
    isBold          : Boolean;
    isItalic        : boolean;
    isUnderline     : boolean;
    isStrikeOut     : boolean;
  end;


implementation

uses
  SysUtils
  ;

{ TReservationMarketTypeHelper }

class function TReservationMarketTypeHelper.FromString(const aStr: string): TReservationMarketType;
var
  i: TReservationMarketType;
begin
  Result := TReservationMarketType.Unknown;
  for i := low(TReservationMarketType) to high(TReservationMarketType) do
    if aStr.ToUpper.Equals(RESERVATIONMARKET_TYPE[i]) then
    begin
      Result := i;
      Break;
    end;
end;

function TReservationMarketTypeHelper.ItemIndex: integer;
begin
  Result := ord(Self);
end;

function TReservationMarketTypeHelper.ToDBString: string;
begin
  Result := RESERVATIONMARKET_TYPE[Self];
end;

end.
