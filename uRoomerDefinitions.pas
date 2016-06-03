unit uRoomerDefinitions;

interface

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


	I_STATUS_NOT_ARRIVED : Integer = 0;
  I_STATUS_ARRIVED : Integer = 1;
  I_STATUS_CHECKED_OUT : Integer = 2;
  I_STATUS_CANCELLED : Integer = 3;
  I_STATUS_WAITING_LIST : Integer = 4;
  I_STATUS_NO_SHOW : Integer = 5;
  I_STATUS_ALLOTMENT : Integer = 6;
  I_STATUS_BLOCKED : Integer = 7;
  I_STATUS_CHANCELED : Integer = 8; //*HJ 140210
  I_STATUS_TMP1 : Integer = 9; //*HJ 140210
  I_STATUS_AWAITING_PAYMENT : Integer = 10; //*HJ 140210
  I_STATUS_DELETED : Integer = 11; //*HJ 140210


	STATUS_NOT_ARRIVED = 'P';
  STATUS_ARRIVED = 'G';
  STATUS_CHECKED_OUT = 'D';
  STATUS_CANCELLED = 'C';
  STATUS_WAITING_LIST = 'O';
  STATUS_NO_SHOW = 'N';
  STATUS_ALLOTMENT = 'A';
  STATUS_BLOCKED = 'B';
  STATUS_CANCELED = 'C';  //*HJ 140210
  STATUS_TMP1 = 'W';  //*HJ 140210
  STATUS_AWAITING_PAYMENT = 'Z';  //*BG 140304
  STATUS_DELETED = 'X';  //*BG 140304

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

implementation

uses
  SysUtils
  ;

{ TReservationMarketTypeHelper }

class function TReservationMarketTypeHelper.FromString(const aStr: string): TReservationMarketType;
var
  i: TReservationMarketType;
  s: string;
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
