unit objHomeCustomer;

interface

uses
    Windows
  , Messages
  , SysUtils
  , Variants
  , Classes
  , Contnrs
  , Dialogs
  , ADODB
  , uUtils
  , cmpRoomerDataSet
  , cmpRoomerConnection
  , uAlerts
  ;


TYPE

//******  DataLayout *******//
//ID	             int            NO Auto
//Customer        nvarchar(15)   NO
//Surname         nvarchar(100)  YES
//Name            nvarchar(100)  YES
//PID             nvarchar(15)   YES
//Address1        nvarchar(100)  YES
//Address2        nvarchar(100)  YES
//Address3        nvarchar(100)  YES
//Address4        nvarchar(100)  YES
//Tel1            nvarchar(15)   YES
//Tel2            nvarchar(15)   YES
//Fax             nvarchar(15)   YES
{From country}
//Country         nvarchar(2)    YES
{From CustomerType}
//CustomerType    nvarchar(5)    YES
//DiscountPercent float          YES
{From ReserVation}
//EmailAddress    nvarchar(100)  YES
//Homepage        nvarchar(100)  YES
//ContactPerson   nvarchar(100)  YES
{From ReserVation}
{From ReserVation}
{From ReserVation}
//TravelAgency    bit	          NO
//Currency        nvarchar(5)    YES
{??}
//pcID            int            YES
{From pcId}
//Active          bit            YES

{$M+}
  THomeCustomer = class(TObject)
  private
    FCustomerID                : Integer ;
    FCustomer                  : string  ;
    FCustomerName              : string  ;
    FCustomerRatePlanId        : Integer  ;
    FDisplayName               : string  ;
    FPID                       : string  ;
    FAddress1                  : string  ;
    FAddress2                  : string  ;
    FAddress3                  : string  ;
    FAddress4                  : string  ;
    FTel1                      : string  ;
    FTel2                      : string  ;
    FFax                       : string  ;
    FCountryName               : string  ;
    FCountry                   : string  ;
    FMarketSegmentName         : string  ;
    FMarketSegmentCode         : string  ;
    FDiscountPerc              : double  ;
    FEmailAddress              : string  ;
    FHomePage                  : string  ;
    FContactPerson             : string  ;
    FContactAddress1           : string  ;
    FContactAddress2           : string  ;
    FContactAddress3           : string  ;
    FContactAddress4           : string  ;
    FContactEmail              : string  ;
    FContactPhone              : string  ;
    FContactFax                : string  ;
    FisTravelAgency            : boolean ;
    FCurrency                  : string  ;
    FCustMemoText              : string  ;
    FpriceCodeId               : integer ;
    FpcCode                    : string  ;
    FActive                    : boolean ;
    //This fiekds are used when making
    //Quick reservation
    FisReservation             : boolean ;
    FReservationName           : string  ;
    FGuestName                 : string  ;
    FroomStatus                : string  ;
    FReservationPaymentInfo    : string  ;
    FReservationGeneralInfo    : string  ;
    FisGroupInvoice            : boolean ;
    FShowDiscountOnInvoice     : boolean ;
    //new 2013-01-14
    FRoomResDiscount           : double  ;
    FisRoomResDiscountPrec     : boolean;

    FinvRefrence               : string;

    FHotelCode : string;
    FContactIsMainGuest        : boolean;
    FContactCountry: string;
    FPersonProfileId: Integer;
    FCreatePersonProfileId: Boolean;


    procedure initVaribles;
    function Customer_Get(customer : string) : boolean;

  protected


  public
    constructor Create(const HotelCode, Customer : string); overload;
    constructor Create(const HotelCode, customer : string; contactAddress1,contactAddress2,contactAddress3,contactAddress4 : string); overload;
    constructor Create(const HotelCode : string; Reservation, RoomReservation : integer); overload;

    function Customer_update(customer : string) : boolean;

    destructor Destroy; override;
  published
     property CustomerID                : Integer read FCustomerID                 write FCustomerID               ;
     property Customer                  : string  read FCustomer                   write FCustomer                 ;
     property CustomerName              : string  read FCustomerName               write FCustomerName             ;
     property DisplayName               : string  read FDisplayName                write FDisplayName              ;
     property PID                       : string  read FPID                        write FPID                      ;
     property Address1                  : string  read FAddress1                   write FAddress1                 ;
     property Address2                  : string  read FAddress2                   write FAddress2                 ;
     property Address3                  : string  read FAddress3                   write FAddress3                 ;
     property Address4                  : string  read FAddress4                   write FAddress4                 ;
     property Tel1                      : string  read FTel1                       write FTel1                     ;
     property Tel2                      : string  read FTel2                       write FTel2                     ;
     property Fax                       : string  read FFax                        write FFax                      ;
     property CountryName               : string  read FCountryName                write FCountryName              ;
     property Country                   : string  read FCountry                    write FCountry                  ;
     property MarketSegmentName         : string  read FMarketSegmentName          write FMarketSegmentName        ;
     property MarketSegmentCode         : string  read FMarketSegmentCode          write FMarketSegmentCode        ;
     property DiscountPerc              : double  read FDiscountPerc               write FDiscountPerc             ;
     property EmailAddress              : string  read FEmailAddress               write FEmailAddress             ;
     property HomePage                  : string  read FHomePage                   write FHomePage                 ;
     property ContactPerson             : string  read FContactPerson              write FContactPerson            ;

     property ContactAddress1           : string  read FContactAddress1            write FContactAddress1          ;
     property ContactAddress2           : string  read FContactAddress2            write FContactAddress2          ;
     property ContactAddress3           : string  read FContactAddress3            write FContactAddress3          ;
     property ContactAddress4           : string  read FContactAddress4            write FContactAddress4          ;
     property ContactCountry            : string  read FContactCountry             write FContactCountry           ;
     property PersonProfileId           : Integer read FPersonProfileId            write FPersonProfileId          ;
     property CreatePersonProfileId     : Boolean read FCreatePersonProfileId      write FCreatePersonProfileId    ;

     property ContactEmail              : string  read FContactEmail               write FContactEmail             ;
     property ContactPhone              : string  read FContactPhone               write FContactPhone             ;
     property ContactFax                : string  read FContactFax                 write FContactFax               ;
     property isTravelAgency            : boolean read FisTravelAgency             write FisTravelAgency           ;
     property Currency                  : string  read FCurrency                   write FCurrency                 ;
     property CustMemoText              : string  read FCustMemoText               write FCustMemoText             ;
     property priceCodeId               : integer read FpriceCodeId                write FpriceCodeId              ;
     property pcCode                    : string  read FpcCode                     write FpcCode                   ;
     property Active                    : boolean read FActive                     write FActive                   ;
     property isReservation             : boolean read FisReservation              write FisReservation            ;
     property ReservationName           : string  read FReservationName            write FReservationName          ;
     property GuestName                 : string  read FGuestName                  write FGuestName
                     ;
     property roomStatus                : string  read FroomStatus                 write FroomStatus               ;
     property ReservationPaymentInfo    : string  read FReservationPaymentInfo     write FReservationPaymentInfo   ;
     property ReservationGeneralInfo    : string  read FReservationGeneralInfo     write FReservationGeneralInfo   ;
     property isGroupInvoice            : boolean read FisGroupInvoice             write FisGroupInvoice           ;
     property ShowDiscountOnInvoice     : boolean read FShowDiscountOnInvoice      write FShowDiscountOnInvoice    ;
     property RoomResDiscount           : double  read FRoomResDiscount            write FRoomResDiscount           ;
     property isRoomResDiscountPrec     : boolean read FisRoomResDiscountPrec      write FisRoomResDiscountPrec     ;
     property invRefrence               : string  read FinvRefrence                write FinvRefrence;

     property HotelCode                 : string  read FHotelCode                  write FHotelCode                ;
     property contactIsMainGuest        : boolean read FContactIsMainGuest         write FContactIsMainGuest      ;
     property CustomerRatePlanId        : Integer read FCustomerRatePlanId         write FCustomerRatePlanId      ;

  end;


implementation
{ THomeCustomer }

uses
  _glob
  , hData
  , ud
  , ug
  ,uSqlDefinitions
  ,uAppGlobal
  ;


constructor THomeCustomer.Create(const HotelCode, customer : string);
begin
  FHotelCode := HotelCode;
  FCustomer  := Customer;
  Customer_Get(FCustomer);
end;

constructor THomeCustomer.Create(const HotelCode : string; Reservation, RoomReservation : integer);
begin
  FHotelCode := HotelCode;
  FCustomer := '';
  Customer_Get(FCustomer);
end;


constructor THomeCustomer.Create(const HotelCode,customer : string; contactAddress1,contactAddress2,contactAddress3,contactAddress4 : string);
begin
  FHotelCode := HotelCode;
  FCustomer := '';
  Customer_Get(FCustomer);
  FContactAddress1 := ContactAddress1;
  FContactAddress2 := ContactAddress2;
  FContactAddress3 := ContactAddress3;
  FContactAddress4 := ContactAddress4;
end;


destructor THomeCustomer.Destroy;
begin
  //
  inherited;
end;


procedure THomeCustomer.initVaribles;
begin

  if Fcustomer='' then
  begin
    FCustomer := hData.ctrlGetString('rackCustomer')
  end;

  FCustomerName := '';
  FDisplayName := '';
  FPID := '';
  FAddress1 := '';
  FAddress2 := '';
  FAddress3 := '';
  FAddress4 := '';
  FTel1 := '';
  FTel2 := '';
  FFax := '';
  FCountryName := '';
  FCountry := hdata.Country_GetDefault();
  FMarketSegmentName := '';
  FMarketSegmentCode := hdata.CustomerTypes_GetDefault();
  FDiscountPerc := 0.00; // *  //**
  FEmailAddress := '';
  FHomePage := '';
  FContactPerson := '';
  FContactEmail := '';
  FContactPhone := '';
  FContactFax := '';
  FisTravelAgency := false;
  FCurrency := hdata.ctrlGetString('NativeCurrency');
  FCustMemoText := '';
  FpriceCodeId := hdata.PriceCodes_GETRack();
  FpcCode := '';
    // This is just if making reservation
  FisReservation := false;
  FReservationName := '';
  FGuestName := '';
  FroomStatus := '';
  FReservationPaymentInfo := '';
  FReservationGeneralInfo := '';
  FisGroupInvoice := false;
  FContactIsMainGuest := true;
  FShowDiscountOnInvoice := True;
  FRoomResDiscount        := 0.00;
  FisRoomResDiscountPrec  := true;
  FinvRefrence := '';
end;


function THomeCustomer.Customer_Get(customer : string) : boolean;
begin
  result := False;
  FCustomer := Customer;
  initVaribles;


  if glb.CustomersSet.Locate('Customer',customer,[]) then
  begin
    FCustomer           :=  glb.CustomersSet.FieldByName('Customer').AsString;
    FCustomerID         :=  glb.CustomersSet.FieldByName('ID').AsInteger;
    FCustomerName       :=  glb.CustomersSet.FieldByName('Surname').AsString;
    FDisplayName        :=  glb.CustomersSet.FieldByName('Name').AsString;
    FPID                :=  glb.CustomersSet.FieldByName('PID').AsString;
    FAddress1           :=  glb.CustomersSet.FieldByName('Address1').AsString;
    FAddress2           :=  glb.CustomersSet.FieldByName('Address2').AsString;
    FAddress3           :=  glb.CustomersSet.FieldByName('Address3').AsString;
    FAddress4           :=  glb.CustomersSet.FieldByName('Address4').AsString;
    FTel1               :=  glb.CustomersSet.FieldByName('Tel1').AsString;
    FTel2               :=  glb.CustomersSet.FieldByName('Tel2').AsString;
    FFax                :=  glb.CustomersSet.FieldByName('Fax').AsString;
    FCountry            :=  glb.CustomersSet.FieldByName('Country').AsString;
    FMarketSegmentCode  :=  glb.CustomersSet.FieldByName('CustomerType').AsString;
    FDiscountPerc       :=  LocalFloatValue(glb.CustomersSet.FieldByName('DiscountPercent').AsString);
    FEmailAddress       :=  glb.CustomersSet.FieldByName('EmailAddress').AsString;
    FHomePage           :=  glb.CustomersSet.FieldByName('Homepage').AsString;
    FContactPerson      :=  glb.CustomersSet.FieldByName('ContactPerson').AsString;
    FisTravelAgency     :=  glb.CustomersSet['TravelAgency'];
    FCurrency           :=  glb.CustomersSet.FieldByName('Currency').AsString;
    FpriceCodeId        :=  glb.CustomersSet.FieldByName('pcID').AsInteger;
    FCustomerRatePlanId :=  glb.CustomersSet.FieldByName('RatePlanId').AsInteger;

    FpcCode := PriceCode_Code(FPriceCodeId);

    if glb.CustomertypesSet.Locate('CustomerType',FMarketSegmentCode,[]) then
    begin
      FMarketSegmentName :=  glb.CustomertypesSet.FieldByName('Description').AsString;
    end;


    if glb.Countries.Locate('country',FCountry,[]) then
    begin
       FCountryName       :=   glb.Countries.FieldByName('CountryName').AsString;
    end;
  end;
end;


function THomeCustomer.Customer_update(customer: string): boolean;
begin
  FCustomer  := Customer;
  result := Customer_Get(FCustomer);
end;

end.
