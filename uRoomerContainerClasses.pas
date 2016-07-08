unit uRoomerContainerClasses;

interface

uses
  uReservationStatusDefinitions
  ;


type
  TresCell = class
  private
    FRoomReservation: integer;
    FReservation: integer;
    FDate: Tdate;
    FRoom: string;
    FRoomType: string;
    FresFlag: TReservationStatus;
    FisNoRoom: boolean;
    FAscIndex: integer;
    FDescIndex: integer;
    FCustomerName: string;
    FChannel: integer;
    FPaymentInvoice: integer;
    FGroupAccount: boolean;
    FInformation: String;
    FFax: String;
    FTel2: String;
    FPrice: Double;
    FTel1: String;
    FGuestName: String;
    FItemsOnInvoice: boolean;
    FDiscount: Double;
    FPMInfo: String;
    FPercentage: boolean;
    FPriceType: String;
    FCurrency: String;
    FNumGuests: integer;
    FRoomClass: string;
    FOutOfOrderBlocking: boolean;
    FBlockMove: boolean;
    FBookingId: String;
    FOngoingRent: Double;
    FOngoingSale: Double;
    FGuarantee: String;
    FInvoices: String;
    FTotalPayments: Double;
    FOngoingTaxes: Double;
    FInvoiceIndex: Integer;
    FBlockMoveReason: String;

  public
    constructor Create; overload;
    constructor Create(RoomReservation, Reservation, Channel, PaymentInvoice, AscIndex, DescIndex: integer; GroupAccount: boolean;
      Room, RoomType: string; resFlag: TReservationStatus; CustomerName: string; isNoRoom: boolean; Date: Tdate; Information, Fax, Tel2, Tel1, GuestName, PMInfo, PriceType, Currency,
      BookingId: String; Price, Discount: Double; Percentage: boolean; ItemsOnInvoice: boolean; numGuests: integer; RoomClass: string;
      _OutOfOrderBlocking, _BlockMove: boolean; _BlockMoveReason: String; _OngoingSale, _OngoingRent, _OngoingTaxes: Double; _Invoices, _Guarantee: String; _TotalPayments: Double
      ; _InvoiceIndex : Integer); overload;

    destructor Destroy; override;

    property RoomReservation: integer read FRoomReservation write FRoomReservation;
    property Reservation: integer read FReservation write FReservation;
    property Channel: integer read FChannel write FChannel;
    property Date: Tdate read FDate write FDate;
    property Room: string read FRoom write FRoom;
    property RoomType: string read FRoomType write FRoomType;
    property resFlag: TReservationStatus read FresFlag write FresFlag;
    property isNoRoom: boolean read FisNoRoom write FisNoRoom;
    property AscIndex: integer read FAscIndex write FAscIndex;
    property DescIndex: integer read FDescIndex write FDescIndex;
    property CustomerName: string read FCustomerName write FCustomerName;
    property PaymentInvoice: integer read FPaymentInvoice write FPaymentInvoice;
    property GroupAccount: boolean read FGroupAccount write FGroupAccount;

    property ItemsOnInvoice: boolean read FItemsOnInvoice write FItemsOnInvoice;
    property GuestName: String read FGuestName write FGuestName;
    property Tel1: String read FTel1 write FTel1;
    property Tel2: String read FTel2 write FTel2;
    property Fax: String read FFax write FFax;
    property BookingId: String read FBookingId write FBookingId;

    property Price: Double read FPrice write FPrice;
    property Discount: Double read FDiscount write FDiscount;
    property Information: String read FInformation write FInformation;
    property PMInfo: String read FPMInfo write FPMInfo;
    property Percentage: boolean read FPercentage write FPercentage;
    property PriceType: String read FPriceType write FPriceType;
    property Currency: String read FCurrency write FCurrency;
    property numGuests: integer read FNumGuests write FNumGuests;
    property RoomClass: string read FRoomClass write FRoomClass;
    property OutOfOrderBlocking: boolean read FOutOfOrderBlocking write FOutOfOrderBlocking;
    property BlockMove: boolean read FBlockMove write FBlockMove;
    property BlockMoveReason: String read FBlockMoveReason write FBlockMoveReason;
    property OngoingSale: Double read FOngoingSale write FOngoingSale;
    property OngoingTaxes: Double read FOngoingTaxes write FOngoingTaxes;
    property OngoingRent: Double read FOngoingRent write FOngoingRent;
    property Invoices: String read FInvoices write FInvoices;
    property Guarantee: String read FGuarantee write FGuarantee;
    property TotalPayments: Double read FTotalPayments write FTotalPayments;

    property InvoiceIndex : Integer read FInvoiceIndex write FInvoiceIndex;
  end;


implementation


/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////

constructor TresCell.Create(RoomReservation, Reservation, Channel, PaymentInvoice, AscIndex, DescIndex: integer; GroupAccount: boolean;
  Room, RoomType: string; resFlag: TReservationStatus; CustomerName: string; isNoRoom: boolean; Date: Tdate; Information, Fax, Tel2, Tel1, GuestName, PMInfo, PriceType, Currency,
  BookingId: String; Price, Discount: Double; Percentage: boolean; ItemsOnInvoice: boolean; numGuests: integer; RoomClass: string;
  _OutOfOrderBlocking, _BlockMove: boolean; _BlockMoveReason: String; _OngoingSale, _OngoingRent, _OngoingTaxes: Double; _Invoices, _Guarantee: String; _TotalPayments: Double; _InvoiceIndex : Integer);

begin
  inherited Create;
  FRoomReservation := RoomReservation;
  FReservation := Reservation;
  FChannel := Channel;
  FPaymentInvoice := PaymentInvoice;
  FGroupAccount := GroupAccount;
  FAscIndex := AscIndex;
  FDescIndex := DescIndex;
  FRoom := Room;
  FRoomType := RoomType;
  FresFlag := resFlag;
  FisNoRoom := isNoRoom;
  FDate := Date;
  FCustomerName := CustomerName;
  FPercentage := Percentage;

  FInformation := Information;
  FFax := Fax;
  FTel2 := Tel2;
  FTel1 := Tel1;
  FGuestName := GuestName;
  FPMInfo := PMInfo;
  FPrice := Price;
  FDiscount := Discount;
  FItemsOnInvoice := ItemsOnInvoice;
  FPriceType := PriceType;
  FCurrency := Currency;
  FNumGuests := numGuests;
  FRoomClass := RoomClass;

  FBookingId := BookingId;

  FOutOfOrderBlocking := _OutOfOrderBlocking;
  FBlockMove := _BlockMove;
  FBlockMoveReason := _BlockMoveReason;

  FOngoingSale := _OngoingSale;
  FOngoingRent := _OngoingRent;
  FOngoingTaxes := _OngoingTaxes;

  FInvoices := _Invoices;
  FGuarantee := _Guarantee;
  FTotalPayments := _TotalPayments;

  FInvoiceIndex := _InvoiceIndex;
end;

constructor TresCell.Create;
begin
  Create(-1, -1, -1, -1, -1, -1, false, '', '', rsUnknown, '', false, 1, '', '',
          '', '', '', '', '', '', '', 0.00, 0.00,
          false, false, 0, '', false, false, '', 0, 0, 0, '', '', 0, 0);
end;

destructor TresCell.Destroy;
begin
  inherited Destroy;
end;

end.
