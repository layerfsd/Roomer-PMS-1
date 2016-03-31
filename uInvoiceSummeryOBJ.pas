unit uInvoiceSummeryOBJ;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  hData,
  ug,
  ud,
  //uDSp,
  ADODB,
  DB

  , cmpRoomerDataSet
  , cmpRoomerConnection
  , uUtils
  , Generics.Collections
  ;

type
{$M+}
  TCustInfo = class(TObject)
  private
    FIvCustomer : string; // [Customer] [nvarchar](15)
    FIvPid : string; // Kennitala eins og á reikningi
    FIvName : string; // [Name]  [nvarchar](70)
    FIvAddress1 : string; // [Address1] [nvarchar](70)
    FIvAddress2 : string; // [Address2] [nvarchar](70)
    FIvAddress3 : string; // [Address3] [nvarchar](70)
    FIvAddress4 : string; // [Address3] [nvarchar](70)
    FIvCountry     : string; // [Country] [nvarchar](2)
    FIvRoomGuest   : string; // [RoomGuest] [nvarchar](50)

    function getFromInvoiceHead(InvoiceNumber : integer; invoicedata : recInvoiceHeadHolder) : boolean;

  public
    constructor Create(InvoiceNumber : integer; invoicedata : recInvoiceHeadHolder);

    destructor destroy; override;

  published
    property IvCustomer : string read FIvCustomer write FIvCustomer;
    property IvPid : string read FIvPid write FIvPid;
    property IvName : string read FIvName write FIvName;
    property IvAddress1 : string read FIvAddress1 write FIvAddress1;
    property IvAddress2 : string read FIvAddress2 write FIvAddress2;
    property IvAddress3 : string read FIvAddress3 write FIvAddress3;
    property IvAddress4 : string read FIvAddress4 write FIvAddress4;
    property IvCountry : string read FIvCountry write FIvCountry;
    property IvRoomGuest : string read FIvRoomGuest write FIvRoomGuest;

  end;

  /// *****************************************************************************
  ///
  /// -----------------------------------------------------------------------------

{$M+}
  TInvoiceLineInfo = class(TObject)
  private
    FLineNo : integer; // DB Field :  ItemNumber
    FCode : string; // DB Field :  ItemID
    FDescription : string; // DB Field : Description
    FCount : double; // DB Field : Number //-96
    FPrice : double; // DB Field : Price
    FTotalPrice : double; // DB Field : Total
    FDate : TDate; // db calc  : PurchaseDate
    FVATAmount : double; // db Field : Vat
    FVatCode : string; // db Field : VatType
    FTotalWOVat : double; // db Field :
    FilID : integer; // db Field :
    FItemKind : TItemKind;
    FAccountKey : string;
    FImportRefrence : string;
    FImportSource : string;
    FIsPackage    : boolean;
    FRoomreservationAlias : integer;

  public
    constructor Create(LineNo : integer);
    destructor destroy; override;
  published
    property LineNo : integer read FLineNo write FLineNo;
    property Code : string read FCode write FCode;
    property Description : string read FDescription write FDescription;
    property Count : double read FCount write FCount; //-96
    property Price : double read FPrice write FPrice;
    property TotalPrice : double read FTotalPrice write FTotalPrice;
    property Date : TDate read FDate write FDate;
    property VATAmount : double read FVATAmount write FVATAmount;
    property VatCode : string read FVatCode write FVatCode;

    property AccountKey : string read FAccountKey write FAccountKey;
    property ImportRefrence : string read FImportRefrence write FImportRefrence;
    property ImportSource : string read FImportSource write FImportSource;


    property TotalWOVat : double read FTotalWOVat write FTotalWOVat;
    property ilID : integer read FilID write FilID;
    property ItemKind  : TItemKind read FItemKind write FItemKind;
    property IsPackage : boolean   read FIsPackage write FIsPackage;
    property RoomreservationAlias : integer read FRoomreservationAlias write FRoomreservationAlias;

  end;

  /// *****************************************************************************
  ///
  /// -----------------------------------------------------------------------------

{$M+}
  TInvoiceVATInfo = class(TObject)
  private
    FVATNo : integer;
    FVatCode : string;
    FVATDescription : string;
    FPrice_woVAT : double;
    FPrice_wVAT : double;
    FVATPercentage : double;
    FVATAmount : double;
    FCount : integer;

  public
    constructor Create(LineNo : integer);
    destructor destroy; override;

  published
    property VATNo : integer read FVATNo write FVATNo;
    property VatCode : string read FVatCode write FVatCode;
    property VATDescription : string read FVATDescription write FVATDescription;
    property Price_woVAT : double read FPrice_woVAT write FPrice_woVAT;
    property Price_wVAT : double read FPrice_wVAT write FPrice_wVAT;
    property VATPercentage : double read FVATPercentage write FVATPercentage;
    property VATAmount : double read FVATAmount write FVATAmount;
    property Count : integer read FCount write FCount;
  end;

  /// *****************************************************************************
  ///
  /// -----------------------------------------------------------------------------

{$M+}
  TInvoicePayment = class(TObject)
  private
    FpmNo : integer;
    FpmCode : string;
    FpmAmount : double;
    FpmDate : TDateTime;
    FpmDoExport : boolean;
    FpmDescription : string;
    FpmTypeIndex   : integer;
  public
    constructor Create(LineNo : integer);
    destructor destroy; override;
  published
    property pmNo : integer read FpmNo write FpmNo;
    property pmCode : string read FpmCode write FpmCode;
    property pmAmount : double read FpmAmount write FpmAmount;
    property pmDate : TDateTime read FpmDate write FpmDate;
    property pmDoExport : boolean read FpmDoExport write FpmDoExport;
    property pmDescription : string read FpmDescription write FpmDescription;
    property pmTypeIndex : integer read FpmTypeIndex write FpmTypeIndex;
  end;

  /// *****************************************************************************
  ///
  /// -----------------------------------------------------------------------------


  TVatInfoList = TObjectlist<TInvoiceVATInfo>;
  TInvoiceLinesList = TObjectlist<TInvoiceLineInfo>;
  TInvoicePaymentList = TObjectlist<TInvoicePayment>;

{$M+}
  TInvoiceInfo = class(TObject)
  private
    FivhSplitNumber : integer;

    FCurrency : string;
    FLocalCurrency : string;
    FCurrencyRate : double;

    FivhDate : TDate;
    FivhPayDate : TDate;
    FivhStaff : string;

    FivhReservation : integer;
    FivhRoomReservation : integer;
    FivhRoomNumber : string;
    FivhRefrence : string;

    FivhTotal : double;
    FivhTotal_woVat : double;
    FivhTotal_VAT : double;
    FivhTotal_Currency : double;
    FivhExtraText : string;
    FivhTotalBreakFast : double;
    FivhCreditInvoice : integer;
    FivhOriginalInvoice : integer;

    FivhTotal_PrePaid : double;
    FivhTotal_Balance : double;

    FivhTotalStayTax : double;
    FivhTotalStayTaxNights : integer;

    FivhTxtTotalStayTax : string;
    FivhTxtTotalStayTaxNights : string;

    FIvhPrintText : string;
    FIvhShowPackage : boolean;
    FIvhPackage     : string;
    FIvhPackageName : string;
    FIvhPackageText : string;
    FIvhLocation    : string;


    FCurrencyType : TCurrencyTypes;

    FKreditType : TKreditType; // kkUnknown ,kkDebit ,kkCredit
    FKreditReference : TKreditReference; // krUnknown , krManual , krReference

    FCustomerInfo : TCustInfo;
    FLinesList : TInvoiceLinesList;
    FPaymentList : TInvoicePaymentList;
    FVATList : TVatInfoList;
    FTotalPayments : double;
    FInvoiceNumber : integer;

    FCompanyName : string;
    FCompanyAddress1 : string;
    FCompanyAddress2 : string;
    FCompanyAddress3 : string;
    FCompanyAddress4 : string;
    FCompanyCountry : string;
    FCompanyTelePhone1 : string;
    FCompanyTelePhone2 : string;
    FCompanyFax : string;
    FCompanyEmail : string;
    FCompanyHomePage : string;
    FCompanyPID : string;
    FCompanyVATno : string;
    FCompanyBankInfo : string;

    FinvTxtHeadDebit : string;
    FinvTxtHeadKredit : string;
    FinvTxtHeadInfoNumber : string;
    FinvTxtHeadInfoDate : string;
    FinvTxtHeadInfoCustomerNo : string;
    FinvTxtHeadInfoGjalddagi : string;
    FinvTxtHeadInfoEindagi : string;
    FinvTxtHeadInfoLocalCurrency : string;
    FinvTxtHeadInfoCurrency : string;
    FinvTxtHeadInfoCurrencyRate : string;
    FinvTxtHeadInfoReservation : string;
    FinvTxtHeadInfoCreditInvoice : string;
    FinvTxtHeadInfoOrginalInfo : string;
    FinvTxtHeadInfoGuest : string;
    FinvTxtHeadInfoRoom : string;
    FinvTxtLinesItemNo : string;
    FinvTxtLinesItemText : string;
    FinvTxtLinesItemCount : string;
    FinvTxtLinesItemPrice : string;
    FinvTxtLinesItemAmount : string;
    FinvTxtLinesItemTotal : string;
    FinvTxtExtra1 : string;
    FinvTxtExtra2 : string;
    FinvTxtFooterLine1 : string;
    FinvTxtFooterLine2 : string;
    FinvTxtFooterLine3 : string;
    FinvTxtFooterLine4 : string;
    FinvTxtPaymentListHead : string;
    FinvTxtPaymentListCode : string;
    FinvTxtPaymentListAmount : string;
    FinvTxtPaymentListDate : string;
    FinvTxtPaymentListTotal : string;
    FinvTxtPaymentLineHead : string;
    FinvTxtPaymentLineSeperator : string;
    FinvTxtVATListHead : string;
    FinvTxtVATListDescription : string;
    FinvTxtVATListwoVAT : string;
    FinvTxtVATListwVAT : string;
    FinvTxtVATListVATpr : string;
    FinvTxtVATListVATAmount : string;
    FinvTxtVATListTotal : string;
    FinvTxtVATLineHead : string;
    FinvTxtVATLineSeperator : string;
    FinvTxtTotalwoVAT : string;
    FinvTxtTotalVATAmount : string;
    FinvTxtTotalTotal : string;
    FinvTxtCompanyName : string;
    FinvTxtCompanyAddress : string;
    FinvTxtCompanyTel1 : string;
    FinvTxtCompanyTel2 : string;
    FinvTxtCompanyFax : string;
    FinvTxtCompanyEmail : string;
    FinvTxtCompanyHomePage : string;
    FinvTxtCompanyPID : string;
    FinvTxtCompanyBankInfo : string;
    FinvTxtCompanyVATId : string;

    FinvTxtPaymentListDescription : string;
    FinvTxtHeadPrePaid            : string;
    FinvTxtHeadBalance            : string;




    function GetLine(idx : integer) : TInvoiceLineInfo;
    function GetLineCount : integer;

    // procedure ClearLines;

    function AddLine(ilID : integer; Date : TDate; LineNo : integer; Code : string; Description : string; Count : double;
      Price : double; TotalPrice : double; TotalWOVat : double; VATAmount : double; VatType : string;
      AccountKey : string; importRefrence, importSource : string; isPackage : boolean;RoomreservationAlias:integer) : integer;

    function GetPayment(idx : integer) : TInvoicePayment;
    function GetPaymentCount : integer;

    function AddPayment(pmCode : string; pmAmount : double; pmDate : TDateTime; pmDoExport : boolean; pmDescription : string; pmTypeIndex : integer) : integer;
    function AddToVATPrice(idx : integer; Price_woVAT : double; Price_wVAT : double; VATAmount : double) : boolean;

    function GetVAT(idx : integer) : TInvoiceVATInfo;
    function GetVATCount : integer;

    // Procedure ClearVAT;

    function getCurrencyType(sCurrency : string) : TCurrencyTypes;

    function AddVAT(VatCode : string; Price_woVAT : double; Price_wVAT : double; VATPercentage : double; VATAmount : double) : integer;

  public
    constructor Create(InvoiceNumber : integer; PaymentData : recPaymentHolder; invoiceData : recInvoiceHeadHolder);

    destructor destroy; override;

    function UpdateInfo(invoicedata : recInvoiceHeadHolder) : boolean;

    property LinesList[idx : integer] : TInvoiceLineInfo read GetLine;
    property PaymentList[idx : integer] : TInvoicePayment read GetPayment;
    property VATList[idx : integer] : TInvoiceVATInfo read GetVAT;

    function GatherPayments(var doExport : boolean;PaymentData : recPaymentHolder; invoiceData : recInvoiceHeadHolder) : double;
    function isPaid : boolean;

  published

    property ivhSplitNumber : integer read FivhSplitNumber write FivhSplitNumber;
    property ivhReservation : integer read FivhReservation write FivhReservation;
    property ivhRoomReservation : integer read FivhRoomReservation write FivhRoomReservation;
    property ivhRoomNumber : string read FivhRoomNumber write FivhRoomNumber;
    property ivhRefrence : string read FivhRefrence write FivhRefrence;

    property ivhTotal : double read FivhTotal write FivhTotal;
    property ivhTotal_woVat : double read FivhTotal_woVat write FivhTotal_woVat;
    property ivhTotal_VAT : double read FivhTotal_VAT write FivhTotal_VAT;
    property ivhTotal_Currency : double read FivhTotal_Currency write FivhTotal_Currency;
    property ivhDate : TDate read FivhDate write FivhDate;
    property ivhPayDate : TDate read FivhPayDate write FivhPayDate;

    property ivhTotal_prePaid : double read FivhTotal_prePaid write FivhTotal_prePaid;
    property ivhTotal_Balance : double read FivhTotal_Balance write FivhTotal_Balance;

    property ivhTotalStayTax           : double   read FivhTotalStayTax            write  FivhTotalStayTax      ;
    property ivhTotalStayTaxNights     : integer  read FivhTotalStayTaxNights      write  FivhTotalStayTaxNights;

    property ivhTxtTotalStayTax        : string   read FivhTxtTotalStayTax         write  FivhTxtTotalStayTax   ;
    property ivhTxtTotalStayTaxNights  : string   read FivhTxtTotalStayTaxNights   write  FivhTxtTotalStayTaxNights;

    property ivhStaff : string read FivhStaff write FivhStaff;

    property ivhExtraText : string read FivhExtraText write FivhExtraText;

    property ivhTotalBreakFast : double read FivhTotalBreakFast write FivhTotalBreakFast;
    property ivhCreditInvoice : integer read FivhCreditInvoice write FivhCreditInvoice;
    property ivhOriginalInvoice : integer read FivhOriginalInvoice write FivhOriginalInvoice;

    property ivhPrintText : string read FivhPrintText write FivhPrintText;

    property IvhShowPackage : boolean read FIvhShowPackage write FIvhShowPackage;
    property IvhPackage     : string read FIvhPackage     write FIvhPackage;
    property IvhPackageName : string read FIvhPackageName  write FIvhPackageName;
    property IvhPackageText : string read FIvhPackageText  write FIvhPackageText;
    property IvhLocation    : string read FIvhLocation     write FIvhLocation;


    property CustomerInfo : TCustInfo read FCustomerInfo write FCustomerInfo;

    property Currency : string read FCurrency write FCurrency;
    property LocalCurrency : string read FLocalCurrency write FLocalCurrency;
    property CurrencyRate : double read FCurrencyRate write FCurrencyRate;
    property CurrencyType : TCurrencyTypes read FCurrencyType write FCurrencyType;

    property lineCount : integer read GetLineCount;
    property paymentCount : integer read GetPaymentCount;
    property VATcount : integer read GetVATCount;

    property TotalPayments : double read FTotalPayments write FTotalPayments;
    property InvoiceNumber : integer read FInvoiceNumber write FInvoiceNumber;

    property KreditType : TKreditType read FKreditType write FKreditType; // kkUnknown ,kkDebit ,kkCredit
    property KreditReference : TKreditReference read FKreditReference write FKreditReference; // krUnknown , krManual , krReference

    property CompanyName : string read FCompanyName write FCompanyName;
    property CompanyAddress1 : string read FCompanyAddress1 write FCompanyAddress1;
    property CompanyAddress2 : string read FCompanyAddress2 write FCompanyAddress2;
    property CompanyAddress3 : string read FCompanyAddress3 write FCompanyAddress3;
    property CompanyAddress4 : string read FCompanyAddress4 write FCompanyAddress4;
    property CompanyCountry : string read FCompanyCountry write FCompanyCountry;
    property CompanyTelePhone1 : string read FCompanyTelePhone1 write FCompanyTelePhone1;
    property CompanyTelePhone2 : string read FCompanyTelePhone2 write FCompanyTelePhone2;
    property CompanyFax : string read FCompanyFax write FCompanyFax;
    property CompanyEmail : string read FCompanyEmail write FCompanyEmail;
    property CompanyHomePage : string read FCompanyHomePage write FCompanyHomePage;

    property CompanyPID : string read FCompanyPID write FCompanyPID;
    property CompanyVATno : string read FCompanyVATno write FCompanyVATno;
    property CompanyBankInfo : string read FCompanyBankInfo write FCompanyBankInfo;

    property invTxtHeadDebit : string read FinvTxtHeadDebit write FinvTxtHeadDebit;
    property invTxtHeadKredit : string read FinvTxtHeadKredit write FinvTxtHeadKredit;
    property invTxtHeadInfoNumber : string read FinvTxtHeadInfoNumber write FinvTxtHeadInfoNumber;
    property invTxtHeadInfoDate : string read FinvTxtHeadInfoDate write FinvTxtHeadInfoDate;
    property invTxtHeadInfoCustomerNo : string read FinvTxtHeadInfoCustomerNo write FinvTxtHeadInfoCustomerNo;
    property invTxtHeadInfoGjalddagi : string read FinvTxtHeadInfoGjalddagi write FinvTxtHeadInfoGjalddagi;
    property invTxtHeadInfoEindagi : string read FinvTxtHeadInfoEindagi write FinvTxtHeadInfoEindagi;
    property invTxtHeadInfoLocalCurrency : string read FinvTxtHeadInfoLocalCurrency write FinvTxtHeadInfoLocalCurrency;
    property invTxtHeadInfoCurrency : string read FinvTxtHeadInfoCurrency write FinvTxtHeadInfoCurrency;
    property invTxtHeadInfoCurrencyRate : string read FinvTxtHeadInfoCurrencyRate write FinvTxtHeadInfoCurrencyRate;
    property invTxtHeadInfoReservation : string read FinvTxtHeadInfoReservation write FinvTxtHeadInfoReservation;
    property invTxtHeadInfoCreditInvoice : string read FinvTxtHeadInfoCreditInvoice write FinvTxtHeadInfoCreditInvoice;
    property invTxtHeadInfoOrginalInfo : string read FinvTxtHeadInfoOrginalInfo write FinvTxtHeadInfoOrginalInfo;
    property invTxtHeadInfoGuest : string read FinvTxtHeadInfoGuest write FinvTxtHeadInfoGuest;
    property invTxtHeadInfoRoom : string read FinvTxtHeadInfoRoom write FinvTxtHeadInfoRoom;
    property invTxtLinesItemNo : string read FinvTxtLinesItemNo write FinvTxtLinesItemNo;
    property invTxtLinesItemText : string read FinvTxtLinesItemText write FinvTxtLinesItemText;
    property invTxtLinesItemCount : string read FinvTxtLinesItemCount write FinvTxtLinesItemCount;
    property invTxtLinesItemPrice : string read FinvTxtLinesItemPrice write FinvTxtLinesItemPrice;
    property invTxtLinesItemAmount : string read FinvTxtLinesItemAmount write FinvTxtLinesItemAmount;
    property invTxtLinesItemTotal : string read FinvTxtLinesItemTotal write FinvTxtLinesItemTotal;
    property invTxtExtra1 : string read FinvTxtExtra1 write FinvTxtExtra1;
    property invTxtExtra2 : string read FinvTxtExtra2 write FinvTxtExtra2;
    property invTxtFooterLine1 : string read FinvTxtFooterLine1 write FinvTxtFooterLine1;
    property invTxtFooterLine2 : string read FinvTxtFooterLine2 write FinvTxtFooterLine2;
    property invTxtFooterLine3 : string read FinvTxtFooterLine3 write FinvTxtFooterLine3;
    property invTxtFooterLine4 : string read FinvTxtFooterLine4 write FinvTxtFooterLine4;
    property invTxtPaymentListHead : string read FinvTxtPaymentListHead write FinvTxtPaymentListHead;
    property invTxtPaymentListCode : string read FinvTxtPaymentListCode write FinvTxtPaymentListCode;
    property invTxtPaymentListAmount : string read FinvTxtPaymentListAmount write FinvTxtPaymentListAmount;
    property invTxtPaymentListDate : string read FinvTxtPaymentListDate write FinvTxtPaymentListDate;
    property invTxtPaymentListTotal : string read FinvTxtPaymentListTotal write FinvTxtPaymentListTotal;
    property invTxtPaymentLineHead : string read FinvTxtPaymentLineHead write FinvTxtPaymentLineHead;
    property invTxtPaymentLineSeperator : string read FinvTxtPaymentLineSeperator write FinvTxtPaymentLineSeperator;
    property invTxtVATListHead : string read FinvTxtVATListHead write FinvTxtVATListHead;
    property invTxtVATListDescription : string read FinvTxtVATListDescription write FinvTxtVATListDescription;
    property invTxtVATListwoVAT : string read FinvTxtVATListwoVAT write FinvTxtVATListwoVAT;
    property invTxtVATListwVAT : string read FinvTxtVATListwVAT write FinvTxtVATListwVAT;
    property invTxtVATListVATpr : string read FinvTxtVATListVATpr write FinvTxtVATListVATpr;
    property invTxtVATListVATAmount : string read FinvTxtVATListVATAmount write FinvTxtVATListVATAmount;
    property invTxtVATListTotal : string read FinvTxtVATListTotal write FinvTxtVATListTotal;
    property invTxtVATLineHead : string read FinvTxtVATLineHead write FinvTxtVATLineHead;
    property invTxtVATLineSeperator : string read FinvTxtVATLineSeperator write FinvTxtVATLineSeperator;
    property invTxtTotalwoVAT : string read FinvTxtTotalwoVAT write FinvTxtTotalwoVAT;
    property invTxtTotalVATAmount : string read FinvTxtTotalVATAmount write FinvTxtTotalVATAmount;
    property invTxtTotalTotal : string read FinvTxtTotalTotal write FinvTxtTotalTotal;
    property invTxtCompanyName : string read FinvTxtCompanyName write FinvTxtCompanyName;
    property invTxtCompanyAddress : string read FinvTxtCompanyAddress write FinvTxtCompanyAddress;
    property invTxtCompanyTel1 : string read FinvTxtCompanyTel1 write FinvTxtCompanyTel1;
    property invTxtCompanyTel2 : string read FinvTxtCompanyTel2 write FinvTxtCompanyTel2;
    property invTxtCompanyFax : string read FinvTxtCompanyFax write FinvTxtCompanyFax;
    property invTxtCompanyEmail : string read FinvTxtCompanyEmail write FinvTxtCompanyEmail;
    property invTxtCompanyHomePage : string read FinvTxtCompanyHomePage write FinvTxtCompanyHomePage;
    property invTxtCompanyPID : string read FinvTxtCompanyPID write FinvTxtCompanyPID;
    property invTxtCompanyBankInfo : string read FinvTxtCompanyBankInfo write FinvTxtCompanyBankInfo;
    property invTxtCompanyVATId : string read FinvTxtCompanyVATId write FinvTxtCompanyVATId;

    property invTxtPaymentListDescription : string read  FinvTxtPaymentListDescription  write  FinvTxtPaymentListDescription ;
    property invTxtHeadPrePaid            : string read  FinvTxtHeadPrePaid             write  FinvTxtHeadPrePaid            ;
    property invTxtHeadBalance            : string read  FinvTxtHeadBalance             write  FinvTxtHeadBalance            ;



  end;

implementation

uses
    _Glob
  , uFinishedInvoices2
  , uSqlDefinitions
  , uAppGlobal
  ;

// *****************************************************************************
// TCustInfo - Starts
// ******************************************************************************
constructor TCustInfo.Create(InvoiceNumber : integer; invoicedata : recInvoiceHeadHolder);
begin
  inherited Create;
  FIvCustomer := '';
  FIvPid := '';
  FIvName := '';
  FIvAddress1 := '';
  FIvAddress2 := '';
  FIvAddress3 := '';
  FIvAddress4 := '';
  FIvCountry := '';
  getFromInvoiceHead(InvoiceNumber,invoiceData);
end;

destructor TCustInfo.destroy;
begin
  inherited destroy;
end;

function TCustInfo.getFromInvoiceHead(InvoiceNumber : integer;invoicedata : recInvoiceHeadHolder) : boolean;
var
  rSet : TRoomerDataSet;
  sql : string;
begin
  result := false;

  FIvCustomer  := '';
  FIvPid       := '';
  FIvName      := '';
  FIvAddress1  := '';
  FIvAddress2  := '';
  FIvAddress3  := '';
  FIvAddress4  := '';
  FIvCountry   := '';
  FIvRoomGuest := '';

  if invoicenumber = -1 then
  begin
    FIvCustomer  := invoiceData.Customer;
    FIvPid       := invoiceData.custPID;
    FIvName      := invoiceData.name;
    FIvAddress1  := invoiceData.Address1;
    FIvAddress2  := invoiceData.Address2;
    FIvAddress3  := invoiceData.Address3;
    FIvAddress4  := invoiceData.Address4;
    FIvCountry   := invoiceData.Country;
    FIvRoomGuest := invoiceData.RoomGuest;
  end else
  begin
    rSet := CreateNewDataSet;
    try
  //    lstParams.Clear;
  //    lstParams.Add('@InvoiceNumber=' + inttoStr(InvoiceNumber));
  //    S_execute(rSet, '_GET_invoiceHead_customerInfo', lstParams);
      sql := format(select_invoiceHead_customerInfo, [InvoiceNumber]);
      if hData.rSet_bySQL(rSet,sql) then
      begin
        FIvCustomer := rSet.fieldbyname('Customer').asString;
        FIvPid := rSet.fieldbyname('custPID').asString;
        FIvName := rSet.fieldbyname('Name').asString;
        FIvAddress1 := rSet.fieldbyname('Address1').asString;
        FIvAddress2 := rSet.fieldbyname('Address2').asString;
        FIvAddress3 := rSet.fieldbyname('Address3').asString;
        FIvAddress4 := rSet.fieldbyname('Address4').asString;
        FIvCountry := rSet.fieldbyname('Country').asString;
        FIvRoomGuest := rSet.fieldbyname('RoomGuest').asString;
        result := true;
      end;

    finally
      freeandnil(rSet);
    end;
  end;
end;

// *****************************************************************************
// TCustInfo - Ends
// ******************************************************************************


// *****************************************************************************
// TInvoiceLineInfo - Starts
// ******************************************************************************

constructor TInvoiceLineInfo.Create(LineNo : integer);
begin
  inherited Create;
  FLineNo := LineNo;
  FCode := '';
  FDescription := '';
  FCount := 0.00; //-96
  FPrice := 0.00;
  FTotalPrice := 0.00;
  FDate := Date;
  FVATAmount := 0.00;
  FVatCode := '';
  FTotalWOVat := 0.00;
  FilID := 0;
  FItemKind := ikUnknown;
  FAccountKey := '';
  FimportSource := '';
  FimportRefrence := '';
  FIsPackage := false;
  FRoomreservationAlias := -1;
end;

destructor TInvoiceLineInfo.destroy;
begin
  inherited destroy;
end;

// *****************************************************************************
// TInvoiceLineInfo - Ends
// ******************************************************************************

constructor TInvoiceVATInfo.Create(LineNo : integer);
begin
  inherited Create;
  FVATNo := LineNo;
  FVatCode := '';
  FVATDescription := '';
  FPrice_woVAT := 0.00;
  FPrice_wVAT := 0.00;
  FVATPercentage := 0.00;
  FVATAmount := 0.00;
  FCount := 0;
end;

destructor TInvoiceVATInfo.destroy;
begin
  inherited destroy;
end;

// *****************************************************************************
// TInvoicePayment - Starts
// ******************************************************************************

constructor TInvoicePayment.Create(LineNo : integer);
begin
  inherited Create;
  FpmNo := LineNo;
  FpmCode := '';
  FpmAmount := 0.0;
  FpmDate := Date;
  FpmDoExport := true;
  FpmDescription := '';
  FpmTypeIndex    := 0;
end;

destructor TInvoicePayment.destroy;
begin

  inherited destroy;
end;

// *****************************************************************************
// TInvoicePayment - Ends
// ******************************************************************************



// *****************************************************************************
// TInvoiceInfo  - Starts
// ******************************************************************************

function TInvoiceInfo.getCurrencyType(sCurrency : string) : TCurrencyTypes;
begin
  result := ctLocal;
  if _trimlower(sCurrency) = FLocalCurrency then
    exit;
  result := ctForeigin;
end;

constructor TInvoiceInfo.Create(InvoiceNumber : integer; PaymentData : recPaymentHolder; invoiceData : recInvoiceHeadHolder);
begin
  inherited Create;

  FInvoiceNumber := InvoiceNumber;
  FCustomerInfo := TCustInfo.Create(InvoiceNumber,invoiceData);
  FLinesList := TInvoiceLinesList.Create(True);
  FPaymentList := TInvoicePaymentList.Create(True);
  FVATList := TVatInfoList.Create(True);

  FKreditType := ktUnknown;
  FKreditReference := krUnknown;

  FivhReservation := - 1;
  FivhRoomReservation := - 1;
  FivhRoomNumber := '';
  FivhRefrence := '';

  FivhExtraText := '';
  FivhDate := Date;
  FivhPayDate := Date;
  FivhStaff := '';

  FivhTotal := 0;
  FivhTotal_prePaid := 0;
  FivhTotal_balance := 0;

  FivhTotal_woVat := 0;
  FivhTotal_VAT := 0;
  FivhTotalBreakFast := 0;
  FivhCreditInvoice := 0;
  FivhOriginalInvoice := 0;
  FivhSplitNumber := - 1;
  FivhPrintText := '';
  FIvhShowpackage := false;
  FIvhPackage     := '';
  FIvhPackageName := '';
  FIvhPackageText := '';
  FIvhLocation := '';



  FivhTotalStayTax       := 0.00;
  FivhTotalStayTaxNights := 0;

  FivhTxtTotalStayTax       := '';
  FivhTxtTotalStayTaxNights := '';

  FTotalPayments := 0.00;

  FCurrency := '';
  FCurrencyRate := 0.00;
  FCurrencyType := ctLocal;
  FLocalCurrency := AnsiUpperCase(trim(ctrlGetString('NativeCurrency')));

  FCompanyName := '';
  FCompanyAddress1 := '';
  FCompanyAddress2 := '';
  FCompanyAddress3 := '';
  FCompanyAddress4 := '';
  FCompanyCountry := '';
  FCompanyTelePhone1 := '';
  FCompanyTelePhone2 := '';
  FCompanyFax := '';
  FCompanyEmail := '';
  FCompanyHomePage := '';
  FCompanyPID := '';
  FCompanyVATno := '';
  FCompanyBankInfo := '';


  // labels and captions

  FinvTxtHeadDebit := '';
  FinvTxtHeadKredit := '';
  FinvTxtHeadInfoNumber := '';
  FinvTxtHeadInfoDate := '';
  FinvTxtHeadInfoCustomerNo := '';
  FinvTxtHeadInfoGjalddagi := '';
  FinvTxtHeadInfoEindagi := '';
  FinvTxtHeadInfoLocalCurrency := '';
  FinvTxtHeadInfoCurrency := '';
  FinvTxtHeadInfoCurrencyRate := '';
  FinvTxtHeadInfoReservation := '';
  FinvTxtHeadInfoCreditInvoice := '';
  FinvTxtHeadInfoOrginalInfo := '';
  FinvTxtHeadInfoGuest := '';
  FinvTxtHeadInfoRoom := '';
  FinvTxtLinesItemNo := '';
  FinvTxtLinesItemText := '';
  FinvTxtLinesItemCount := '';
  FinvTxtLinesItemPrice := '';
  FinvTxtLinesItemAmount := '';
  FinvTxtLinesItemTotal := '';
  FinvTxtExtra1 := '';
  FinvTxtExtra2 := '';
  FinvTxtFooterLine1 := '';
  FinvTxtFooterLine2 := '';
  FinvTxtFooterLine3 := '';
  FinvTxtFooterLine4 := '';
  FinvTxtPaymentListHead := '';
  FinvTxtPaymentListCode := '';
  FinvTxtPaymentListAmount := '';
  FinvTxtPaymentListDate := '';
  FinvTxtPaymentListTotal := '';
  FinvTxtPaymentLineHead := '';
  FinvTxtPaymentLineSeperator := '';
  FinvTxtVATListHead := '';
  FinvTxtVATListDescription := '';
  FinvTxtVATListwoVAT := '';
  FinvTxtVATListwVAT := '';
  FinvTxtVATListVATpr := '';
  FinvTxtVATListVATAmount := '';
  FinvTxtVATListTotal := '';
  FinvTxtVATLineHead := '';
  FinvTxtVATLineSeperator := '';
  FinvTxtTotalwoVAT := '';
  FinvTxtTotalVATAmount := '';
  FinvTxtTotalTotal := '';
  FinvTxtCompanyName := '';
  FinvTxtCompanyAddress := '';
  FinvTxtCompanyTel1 := '';
  FinvTxtCompanyTel2 := '';
  FinvTxtCompanyFax := '';
  FinvTxtCompanyEmail := '';
  FinvTxtCompanyHomePage := '';
  FinvTxtCompanyPID := '';
  FinvTxtCompanyBankInfo := '';
  FinvTxtCompanyVATId := '';

  FinvTxtPaymentListDescription := '';
  FinvTxtHeadPrePaid            := '';
  FinvTxtHeadBalance            := '';

end;

destructor TInvoiceInfo.destroy;
begin
  FCustomerInfo.Free;
  FLinesList.Free;
  FVATList.Free;
  FPaymentList.Free;
  inherited destroy;
end;

// --- InvoiceLine
function TInvoiceInfo.GetLine(idx : integer) : TInvoiceLineInfo;
begin
  result := FLinesList[idx];
end;

// --- InvoiceLine
function TInvoiceInfo.GetLineCount : integer;
begin
  result := 0;
  try
    result := FLinesList.Count;
  except
  end;
end;

(*
  // --- InvoiceLine
  Procedure TInvoiceInfo.ClearLines;
  var
  i : integer;
  begin
  for i := FLinesList.count - 1 downto 0 do
  begin
  TInvoiceLineInfo( FLinesList[i] ).free;
  FLinesList.delete(i);
  end;
  end;
*)


// --- InvoiceLine

function TInvoiceInfo.AddLine(ilID : integer;
                              Date : TDate;
                              LineNo : integer;
                              Code : string;
                              Description : string;
                              Count : double;
                              Price : double;
                              TotalPrice : double;
                              TotalWOVat : double;
                              VATAmount : double;
                              VatType : string;
                              AccountKey : string;
                              importRefrence, importSource : string;
                              isPackage : boolean;
                              RoomreservationAlias : integer
                              ) : integer;

var
  InvoiceLine : TInvoiceLineInfo;
  iLast : integer;
  VATPercentage : double;
begin
  iLast := 0;

  try
    if GetLineCount > 0 then
    begin
      iLast := LinesList[GetLineCount - 1].FLineNo;
    end;
  except

  end;

  inc(iLast);

  InvoiceLine := TInvoiceLineInfo.Create(iLast);

  InvoiceLine.FilID := ilID;
  InvoiceLine.FDate := Date;
  InvoiceLine.FLineNo := LineNo;
  InvoiceLine.FCode := Code;
  InvoiceLine.FDescription := Description;
  InvoiceLine.FCount := Count;
  InvoiceLine.FPrice := Price;
  InvoiceLine.FTotalPrice := TotalPrice;
  InvoiceLine.FTotalWOVat := TotalWOVat;
  InvoiceLine.FVATAmount := VATAmount;
  InvoiceLine.FVatCode := VatType;
  InvoiceLine.AccountKey := AccountKey;
  InvoiceLine.importRefrence := importRefrence;
  InvoiceLine.importSource := importSource;
  InvoiceLine.Ispackage := ispackage;
  Invoiceline.RoomreservationAlias := RoomreservationAlias;

  InvoiceLine.FItemKind := Item_GetKind(Code);
 (* ikUnknown,ikNormal,ikRoomRent,ikRoomRentDiscount,ikBrekfastInc,ikPhoneUse,ikPayment*)


  //InvoiceLine.FItemVATAmount  := calcVSK(InvoiceLine.FTotalPrice, InvoiceLine.FItemInfo.VATPercentage );

  VATPercentage := 0.00;
  if TotalWOVat <> 0 then
  begin
    if NOT glb.LocateSpecificRecordAndGetValue('vatcodes', 'VATCode', VatType, 'VATPercentage', VATPercentage) then
      try
        VATPercentage := (VATAmount / TotalWOVat) * 100;
      except
        VATPercentage := 0.00;
      end;
  end;

  result := FLinesList.Add(InvoiceLine);

  AddVAT(VatType, TotalWOVat, TotalPrice, VATPercentage, VATAmount);

end;

/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////

// --- Payments
function TInvoiceInfo.GetPayment(idx : integer) : TInvoicePayment;
begin
  result := FPaymentList[idx];
end;

// --- Payments
function TInvoiceInfo.GetPaymentCount : integer;
begin
  result := 0;
  try
    result := FPaymentList.Count;
  except
  end;
end;


// --- Payments
function TInvoiceInfo.AddPayment(pmCode : string; pmAmount : double; pmDate : TDateTime; pmDoExport : boolean; pmDescription : string; pmTypeIndex : integer) : integer;
var
  Payment : TInvoicePayment;
  iLast : integer;
begin
  iLast := 0;
  try
    if GetPaymentCount > 0 then
    begin
      iLast := PaymentList[GetPaymentCount - 1].FpmNo;
    end;
  except
  end;

  inc(iLast);

  Payment := TInvoicePayment.Create(iLast);

  Payment.FpmCode        := pmCode;
  Payment.FpmAmount      := pmAmount;
  Payment.FpmDate        := pmDate;
  Payment.FpmDoExport    := pmDoExport;
  Payment.FpmDescription := pmDescription;
  Payment.FpmTypeIndex   := pmTypeIndex;

  result := FPaymentList.Add(Payment);

end;

// --- Payments
function TInvoiceInfo.GatherPayments(var doExport : boolean;PaymentData : recPaymentHolder; invoiceData : recInvoiceHeadHolder) : double;
var
  tt : double;
  pmCode        : string;
  pmAmount      : double;
  pmDate        : TDateTime;
  pmDescription : string;
  pmTypeIndex   : integer;
  rSet          : TRoomerDataSet;
  s             : string;

  isExport : boolean;

begin
  doExport := true;
  tt := 0;
  if FInvoicenumber = -1 then
  begin


  end else
  begin
    rSet := CreateNewDataSet;
    try
      s := format(select_InvoiceSummeryOBJ_InvoiceInfo_GatherPayments , [FInvoiceNumber]);
  // 	   CopyToClipboard(s);
  //     DebugMessage(''#10#10+s);
      hData.rSet_bySQL(rSet,s);
      if not rSet.Eof then
      begin
        while not rSet.Eof do
        begin
          pmCode := rSet.fieldbyname('PayType').asString;
          pmAmount := LocalFloatValue(rSet.fieldbyname('Amount').asString);
          pmDate := _DBdateToDate(rSet.fieldbyname('PayDate').asString);
          pmDescription := rSet.fieldbyname('Description').asstring;
          pmTypeIndex   := rSet.fieldbyname('TypeIndex').asInteger;

          if (pmCode <> '') and (pmAmount <> 0) then
          begin
            isExport := d.PayTypes_isExport(pmCode);
            if not isExport then doExport := false;
            tt := tt + pmAmount;
            AddPayment(pmCode, pmAmount, pmDate,isExport,pmDescription,pmTypeIndex);
          end;
          rSet.Next;
        end;
      end;
    finally
      freeandnil(rSet);
    end;
  end;

  result := tt;
  FTotalPayments := result;
end;

// --- Payments
function TInvoiceInfo.isPaid : boolean;
begin
  result := trunc(TotalPayments) = trunc(ivhTotal);
end;

/// ////////////////////////////////////////////////////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////
// \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
// \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

// --- InvoiceVAT

function TInvoiceInfo.GetVAT(idx : integer) : TInvoiceVATInfo;
begin
  result := FVATList[idx];
end;

function TInvoiceInfo.AddToVATPrice(idx : integer; Price_woVAT : double; Price_wVAT : double; VATAmount : double) : boolean;

begin
  result := true;
  FVATList[idx].FPrice_woVAT := FVATList[idx].FPrice_woVAT + Price_woVAT;
  FVATList[idx].FPrice_wVAT := FVATList[idx].FPrice_wVAT + Price_wVAT;
  FVATList[idx].FVATAmount := FVATList[idx].FVATAmount + VATAmount;
  // result := TInvoiceVATInfo(FVATList[idx]);

end;

// --- InvoiceVAT
function TInvoiceInfo.GetVATCount : integer;
begin
  result := 0;
  try
    result := FVATList.Count;
  except
  end;
end;

(*
  // --- InvoiceVAT
  Procedure TInvoiceInfo.ClearVAT;
  var
  i : integer;
  begin
  for i := FVATList.count - 1 downto 0 do
  begin
  TInvoiceVATInfo( FVATList[i] ).free;
  FVATList.delete(i);
  end;
  end;
*)

// --- InvoiceVAT
function TInvoiceInfo.AddVAT(VatCode : string; Price_woVAT : double; Price_wVAT : double; VATPercentage : double; VATAmount : double)
  : integer;

var
  VATinfo : TInvoiceVATInfo;
  TMPinfo : TInvoiceVATInfo;
  i : integer;
  iCount : integer;
  tmpCode : string;
  FoundAT : integer;
  iLast : integer;
  theData : recVatCodeHolder;


begin
  result := 0;

  iCount := GetVATCount;
  iLast := 0;
  try
    if iCount > 0 then
    begin
      iLast := VATList[iCount - 1].FVATNo;
    end;
  except
  end;

  inc(iLast);

  FoundAT := - 1;

  if iCount > 0 then
  begin
    for i := 0 to iCount - 1 do
    begin
      TMPinfo := GetVAT(i);
      try
        tmpCode := _trimlower(TMPinfo.VatCode);
        if _trimlower(VatCode) = tmpCode then
        begin
          FoundAT := i;
        end;
      finally
      end;
    end;
  end;

  if (FoundAT = - 1) then
  begin // Not Found
    VATinfo := TInvoiceVATInfo.Create(iLast);
    VATinfo.VatCode := VatCode;
     //**NOT TESTED**//
    theData.VATCode := VatCode;
    GET_VatCodeHolder(theData);
    //ATHFIN
    VATinfo.VATDescription := theData.Description;
    VATinfo.Price_woVAT := Price_woVAT;
    VATinfo.Price_wVAT := Price_wVAT;
    VATinfo.VATPercentage := VATPercentage;
    VATinfo.VATAmount := VATAmount;
    result := FVATList.Add(VATinfo);
  end
  else
  begin // Found
    AddToVATPrice(FoundAT, Price_woVAT, Price_wVAT, VATAmount)
  end;
end;

/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////
// -- Public

function TInvoiceInfo.UpdateInfo(invoicedata : recInvoiceHeadHolder) : boolean;
var
  sTmp : string;
  ilID : integer;
  Date : TDate;
  LineNo : integer;
  Code : string;
  Description : string;
  Count : double;
  Price : double;
  TotalPrice : double;
  TotalWOVat : double;
  VATAmount : double;
  VatType : string;
  AccountKey : string;
  importRefrence : string;
  importSource  : string;

  PrintedTimes : integer;
  OriginalText : string;
  CopyText     : string;

  sql : string;

  prePaid : double;
  balance : double;
  isPackage : boolean;
  RoomreservationAlias : integer;
  sumTotal : double;

  tempStr : String;
  Arrival,
  Departure : TDateTime;
  sProformaHeader : string;

var
  rSet : TRoomerDataSet;
  rSet2 : TRoomerDataSet;

  index : integer;
  s : string;
begin

  result := false;
  rSet := CreateNewDataSet;
  try
    FivhReservation := - 1;
    FivhRoomReservation := - 1;
    FivhRoomNumber := '';
    FivhRefrence := '';

    FivhExtraText := '';
    FivhDate := Date;
    FivhPayDate := Date;
    FivhStaff := '';

    FivhTotal_prePaid := 0;
    FivhTotal_Balance := 0;

    FivhTotal := 0;
    FivhTotal_woVat := 0;
    FivhTotal_VAT := 0;
    FivhTotalBreakFast := 0;
    FivhCreditInvoice := 0;
    FivhOriginalInvoice := 0;
    FivhSplitNumber := - 1;
    FivhPrintText := '';

    FIvhShowpackage := false;
    FIvhPackage     := '';
    FIvhPackageName := '';
    FIvhPackageText := '';
    FIvhLocation := '';




    FivhTotalStayTax       := 0.00;
    FivhTotalStayTaxNights := 0;

    if Invoicenumber = -1 then
    begin
      FivhReservation     := invoicedata.Reservation;
      FivhRoomReservation := invoicedata.RoomReservation;
      d.RR_GetRoomArrivalAndDeparture(FivhRoomReservation, tempStr, Arrival, Departure);
      FivhRoomNumber      := tempStr; // d.RR_GetRoomNr(FivhRoomReservation); //invoicedata.;
//**ATH      FivhRefrence        := invoicedata.;


      FivhExtraText       := invoicedata.ExtraText;

      sTmp := invoicedata.InvoiceDate;
      FivhDate := _DBdateToDate(sTmp);

      FivhPayDate         := invoicedata.ihPayDate;
      FivhStaff           := invoicedata.ihStaff;

      FivhTotal           := invoicedata.Total;
      FivhTotal_woVat     := invoicedata.TotalWOVAT;
      FivhTotal_VAT       := invoicedata.TotalVAT;
      FivhTotalBreakFast  := invoicedata.TotalBreakFast;
      FivhCreditInvoice   := invoicedata.CreditInvoice;
      FivhOriginalInvoice := invoicedata.OriginalInvoice;
      FivhSplitNumber     := invoicedata.SplitNumber;
      FIvhShowpackage     := invoiceData.ShowPackage;

      sql := format(select_ivh_otherInfo, [InvoiceNumber]);
      if hData.rSet_bySQL(rSet,sql) then
      begin
        FivhTotalStayTax       := invoicedata.TotalStayTax;
        FivhTotalStayTaxNights := invoicedata.TotalStayTaxNights;
        FivhRefrence := rSet.fieldbyname('invRefrence').asString;
      end;
    end else
    begin
      sql := format(select_ivh_otherInfo, [InvoiceNumber]);
      if hData.rSet_bySQL(rSet,sql) then
      begin
        FivhReservation := rSet.fieldbyname('Reservation').asInteger;
        FivhRoomReservation := rSet.fieldbyname('RoomReservation').asInteger;
        FivhRefrence := rSet.fieldbyname('invRefrence').asString;

        d.RR_GetRoomArrivalAndDeparture(FivhRoomReservation, tempStr, Arrival, Departure);
        FivhRoomNumber := tempStr; // d.RR_GetRoomNr(FivhRoomReservation);
        FivhExtraText := rSet.fieldbyname('ExtraText').asString;
        sTmp := rSet.fieldbyname('InvoiceDate').asString;
        FivhDate := _DBdateToDate(sTmp);

        FivhPayDate := rSet.fieldbyname('ihPayDate').asDateTime;
        FivhStaff := rSet.fieldbyname('ihStaff').asString;

        FivhTotal := LocalFloatValue(rSet.fieldbyname('Total').asString);
        FivhTotal_woVat := LocalFloatValue(rSet.fieldbyname('TotalWOVAT').asString);
        FivhTotal_VAT := LocalFloatValue(rSet.fieldbyname('TotalVAT').asString);
        FivhTotalBreakFast := LocalFloatValue(rSet.fieldbyname('TotalBreakFast').asString);
        FivhCreditInvoice := rSet.fieldbyname('CreditInvoice').asInteger;
        FivhOriginalInvoice := rSet.fieldbyname('OriginalInvoice').asInteger;
        FivhSplitNumber := rSet.fieldbyname('SplitNumber').asInteger;

        FivhTotalStayTax       := LocalFloatValue(rSet.fieldbyname('TotalStayTax').asString);
        FivhTotalStayTaxNights := rSet.fieldbyname('TotalStayTaxNights').asInteger;
        FivhShowPackage        := rSet.fieldbyname('Showpackage').asBoolean;
        FivhLocation           := rSet.fieldbyname('Location').asString;

        FKreditType := ktDebit;
        if FivhTotal < 0 then
        begin
          FKreditType := ktKredit;
        end;
        result := true;
      end;
    end;
  finally
    freeandnil(rSet);
  end;

  rSet := CreateNewDataSet;
  try
//    lstParams.Clear;
//    S_execute(rSet, '_GET_ctrl_CompanyInfo', lstParams);
    sql := format(select_ctrl_CompanyInfo, []);
    if hData.rSet_bySQL(rSet,sql) then
  	begin
      FCompanyName := rSet.fieldbyname('CompanyName').asString;
      FCompanyAddress1 := rSet.fieldbyname('Address1').asString;
      FCompanyAddress2 := rSet.fieldbyname('Address2').asString;
      FCompanyAddress3 := rSet.fieldbyname('Address3').asString;
      FCompanyAddress4 := rSet.fieldbyname('Address4').asString;
      FCompanyCountry := rSet.fieldbyname('Country').asString;
      FCompanyFax := rSet.fieldbyname('Fax').asString;
      FCompanyTelePhone1 := rSet.fieldbyname('Telephone1').asString;
      FCompanyTelePhone2 := rSet.fieldbyname('TelePhone2').asString;
      FCompanyEmail := rSet.fieldbyname('CompanyEmail').asString;
      FCompanyHomePage := rSet.fieldbyname('CompanyHomePage').asString;
      FCompanyPID := rSet.fieldbyname('CompanyPID').asString;
      FCompanyVATno := rSet.fieldbyname('CompanyVATno').asString;
      FCompanyBankInfo := rSet.fieldbyname('CompanyBankInfo').asString;
      result := true;
    end;
  finally
    freeandnil(rSet);
  end;

//  rSet := CreateNewDataSet;
//  try
    rSet := glb.ControlSet;
      sProformaHeader := 'Proforma';
      if invoicenumber = PROFORMA_INVOICE_NUMBER then
      begin
       rSet2 := CreateNewDataSet;
       try
         s := 'SELECT Proformaheader FROM hotelconfigurations ';
         if hData.rSet_bySQL(rSet2,s) then
         begin
           if rSet2.FieldByName('Proformaheader').AsString <> '' then sProformaHeader := rSet2.FieldByName('Proformaheader').AsString;
         end;
       finally
         freeandnil(rSet2);
       end;

        FinvTxtHeadDebit :=  sProformaHeader;
        FinvTxtHeadKredit := sProformaHeader+' Kredit';
        OriginalText := '';
        CopyText     := '';
      end else
      begin
        FinvTxtHeadDebit := rSet.fieldbyname('invTxtHeadDebit').asString;
        FinvTxtHeadKredit := rSet.fieldbyname('invTxtHeadKredit').asString;
        OriginalText := rSet.fieldbyname('invTxtOriginal').asString;
        CopyText     := rSet.fieldbyname('invTxtCopy').asString;
      end;

      FinvTxtHeadInfoNumber := rSet.fieldbyname('invTxtHeadInfoNumber').asString;
      FinvTxtHeadInfoDate := rSet.fieldbyname('invTxtHeadInfoDate').asString;
      FinvTxtHeadInfoCustomerNo := rSet.fieldbyname('invTxtHeadInfoCustomerNo').asString;
      FinvTxtHeadInfoGjalddagi := rSet.fieldbyname('invTxtHeadInfoGjalddagi').asString;
      FinvTxtHeadInfoEindagi := rSet.fieldbyname('invTxtHeadInfoEindagi').asString;
      FinvTxtHeadInfoLocalCurrency := rSet.fieldbyname('invTxtHeadInfoLocalCurrency').asString;
      FinvTxtHeadInfoCurrency := rSet.fieldbyname('invTxtHeadInfoCurrency').asString;
      FinvTxtHeadInfoCurrencyRate := rSet.fieldbyname('invTxtHeadInfoCurrencyRate').asString;
      FinvTxtHeadInfoReservation := rSet.fieldbyname('invTxtHeadInfoReservation').asString;
      FinvTxtHeadInfoCreditInvoice := rSet.fieldbyname('invTxtHeadInfoCreditInvoice').asString;
      FinvTxtHeadInfoOrginalInfo := rSet.fieldbyname('invTxtHeadInfoOrginalInfo').asString;
      FinvTxtHeadInfoGuest := rSet.fieldbyname('invTxtHeadInfoGuest').asString;
      FinvTxtHeadInfoRoom := rSet.fieldbyname('invTxtHeadInfoRoom').asString;
      FinvTxtLinesItemNo := rSet.fieldbyname('invTxtLinesItemNo').asString;
      FinvTxtLinesItemText := rSet.fieldbyname('invTxtLinesItemText').asString;
      FinvTxtLinesItemCount := rSet.fieldbyname('invTxtLinesItemCount').asString;
      FinvTxtLinesItemPrice := rSet.fieldbyname('invTxtLinesItemPrice').asString;
      FinvTxtLinesItemAmount := rSet.fieldbyname('invTxtLinesItemAmount').asString;
      FinvTxtLinesItemTotal := rSet.fieldbyname('invTxtLinesItemTotal').asString;
      FinvTxtExtra1 := rSet.fieldbyname('invTxtExtra1').asString;
      FinvTxtExtra2 := rSet.fieldbyname('invTxtExtra2').asString;
      FinvTxtFooterLine1 := rSet.fieldbyname('invTxtFooterLine1').asString;
      FinvTxtFooterLine2 := rSet.fieldbyname('invTxtFooterLine2').asString;
      FinvTxtFooterLine3 := rSet.fieldbyname('invTxtFooterLine3').asString;
      FinvTxtFooterLine4 := rSet.fieldbyname('invTxtFooterLine4').asString;
      FinvTxtPaymentListHead := rSet.fieldbyname('invTxtPaymentListHead').asString;
      FinvTxtPaymentListCode := rSet.fieldbyname('invTxtPaymentListCode').asString;
      FinvTxtPaymentListAmount := rSet.fieldbyname('invTxtPaymentListAmount').asString;
      FinvTxtPaymentListDate := rSet.fieldbyname('invTxtPaymentListDate').asString;
      FinvTxtPaymentListTotal := rSet.fieldbyname('invTxtPaymentListTotal').asString;
      FinvTxtPaymentLineHead := rSet.fieldbyname('invTxtPaymentLineHead').asString;
      FinvTxtPaymentLineSeperator := rSet.fieldbyname('invTxtPaymentLineSeperator').asString;
      FinvTxtVATListHead := rSet.fieldbyname('invTxtVATListHead').asString;
      FinvTxtVATListDescription := rSet.fieldbyname('invTxtVATListDescription').asString;
      FinvTxtVATListwoVAT := rSet.fieldbyname('invTxtVATListwoVAT').asString;
      FinvTxtVATListwVAT := rSet.fieldbyname('invTxtVATListwVAT').asString;
      FinvTxtVATListVATpr := rSet.fieldbyname('invTxtVATListVATpr').asString;
      FinvTxtVATListVATAmount := rSet.fieldbyname('invTxtVATListVATAmount').asString;
      FinvTxtVATListTotal := rSet.fieldbyname('invTxtVATListTotal').asString;
      FinvTxtVATLineHead := rSet.fieldbyname('invTxtVATLineHead').asString;
      FinvTxtVATLineSeperator := rSet.fieldbyname('invTxtVATLineSeperator').asString;
      FinvTxtTotalwoVAT := rSet.fieldbyname('invTxtTotalwoVAT').asString;
      FinvTxtTotalVATAmount := rSet.fieldbyname('invTxtTotalVATAmount').asString;
      FinvTxtTotalTotal := rSet.fieldbyname('invTxtTotalTotal').asString;
      FinvTxtCompanyName := rSet.fieldbyname('invTxtCompanyName').asString;
      FinvTxtCompanyAddress := rSet.fieldbyname('invTxtCompanyAddress').asString;
      FinvTxtCompanyTel1 := rSet.fieldbyname('invTxtCompanyTel1').asString;
      FinvTxtCompanyTel2 := rSet.fieldbyname('invTxtCompanyTel2').asString;
      FinvTxtCompanyFax := rSet.fieldbyname('invTxtCompanyFax').asString;
      FinvTxtCompanyEmail := rSet.fieldbyname('invTxtCompanyEmail').asString;
      FinvTxtCompanyHomePage := rSet.fieldbyname('invTxtCompanyHomePage').asString;
      FinvTxtCompanyPID := rSet.fieldbyname('invTxtCompanyPID').asString;
      FinvTxtCompanyBankInfo := rSet.fieldbyname('invTxtCompanyBankInfo').asString;
      FinvTxtCompanyVATId := rSet.fieldbyname('invTxtCompanyVATId').asString;

      FinvTxtPaymentListDescription := rSet.fieldbyname('invTxtPaymentListDescription').asString;
      FinvTxtHeadPrePaid            := rSet.fieldbyname('invTxtHeadPrePaid').asString;
      FinvTxtHeadBalance            := rSet.fieldbyname('invTxtHeadBalance').asString;

      try
        FivhTxtTotalStayTax       := rSet.fieldbyname('ivhTxtTotalStayTax').asString;
        FivhTxtTotalStayTaxNights := rSet.fieldbyname('ivhTxtTotalStayTaxNights').asString;
      except
      end;



      result := true;
//    end;
//  finally
//    freeandnil(rSet);
//  end;



  try
    PrintedTimes := D.IA_ActionCount(FInvoiceNumber, 1001);
    if PrintedTimes = 0 then
    begin
      FIvhPrintText := OriginalText;
    end else
    begin
      FIvhPrintText := CopyText;
    end;
  Except
  end;

  rSet := CreateNewDataSet;
  try
    sql:=
    '      SELECT '#10+
    '         InvoiceNumber '#10+
    '       , ItemNumber '#10+
    '       , PurchaseDate '#10+
    '       , ItemID '#10+
    '       , Number '#10+
    '       , Description '#10+
    '       , Price '#10+
    '       , VATType '#10+
    '       , Total '#10+
    '       , TotalWOVat '#10+
    '       , Vat '#10+
    '       , CurrencyRate '#10+
    '       , Currency '#10+
    '       , BreakfastPrice '#10+
    '       , ID '#10+
    '       , ilAccountKey '#10+
    '       , importRefrence '#10+
    '       , importSource '#10+
    '       , isPackage '#10+
    '       , RoomReservationAlias '#10+
    '      FROM '#10+
    '        invoicelines '#10+
    '      WHERE '#10+
    '       (InvoiceNumber = %d) '#10+
    '     ORDER BY '#10+
    '       ItemID ';

    sql := format(sql, [InvoiceNumber]);
    if hData.rSet_bySQL(rSet,sql) then
  	begin
      index := 0;
      sumTotal := 0;
      while not rSet.Eof do
      begin
        inc(index);

        importRefrence := rSet.fieldbyname('importRefrence').asString;
        importSource := rSet.fieldbyname('importSource').asString;
        isPackage := rSet.fieldbyname('isPackage').asBoolean;
        RoomreservationAlias := rSet.fieldbyname('RoomReservationAlias').asinteger;
        Description := rSet.fieldbyname('Description').asString;
        if isPackage then
        begin
          Description := StringReplace(Description, '{room}', tempStr,  [rfReplaceAll, rfIgnoreCase]);
          Description := StringReplace(Description, '{arrival}', FormatDateTime('dd.mm', Arrival), [rfReplaceAll, rfIgnoreCase]);
          Description := StringReplace(Description, '{departure}', FormatDateTime('dd.mm', Departure), [rfReplaceAll, rfIgnoreCase]);
          if FIvhPackage = '' then FIvhPackage :=  importSource;
          if FIvhPackageName = '' then FIvhPackageName := importRefrence;
          if FIvhPackageText = '' then FIvhPackageText := Package_getRoomDescription(importSource, tempStr, Arrival, Departure);
        end;

        ilID := rSet.fieldbyname('ID').asInteger;
        sTmp := rSet.fieldbyname('PurchaseDate').asString;
        Date := _DBdateToDate(sTmp);

        LineNo := rSet.fieldbyname('ItemNumber').asInteger;
        Code := rSet.fieldbyname('ItemID').asString;


        Count      := rSet.GetFloatValue(rSet.fieldbyname('Number')); //-96
        Price      := LocalFloatValue(rSet.fieldbyname('Price').asString);
        TotalPrice := LocalFloatValue(rSet.fieldbyname('Total').asString);
        TotalWOVat := LocalFloatValue(rSet.fieldbyname('TotalWOVat').asString);
        VATAmount  := LocalFloatValue(rSet.fieldbyname('Vat').asString);
        VatType    := rSet.fieldbyname('VATType').asString;
        AccountKey := rSet.fieldbyname('ilAccountKey').asString;

        sumTotal := sumTotal+TotalPrice;

        if index = 1 then
        begin
          FCurrency := rSet.fieldbyname('Currency').asString;
          FCurrencyRate := LocalFloatValue(rSet.fieldbyname('CurrencyRate').asString);
          FCurrencyType := getCurrencyType(FCurrency); // ctLocalor ctForeign
        end;

        AddLine(ilID,
                Date,
                LineNo,
                Code,
                Description,
                Count,
                Price,
                TotalPrice,
                TotalWOVat,
                VATAmount,
                VatType,
                AccountKey,
                importRefrence,
                importSource,
                ispackage,
                RoomreservationAlias);

        rSet.Next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;


  if FKreditType = ktKredit then
  begin
    FinvTxtHeadPrePaid    := '';
    FinvTxtHeadBalance    := '';
    FivhTotal_prePaid := 0;
    FivhTotal_Balance := 0;
    exit;
  end;

  rSet := CreateNewDataSet;
  try
    sql := format(select_get_prepaid, [InvoiceNumber]);
    if hData.rSet_bySQL(rSet,sql) then
  	begin
      prePaid := 0.0;
      balance := 0.0;
      while not rSet.Eof do
      begin
        Case rSet.FieldByName('typeIndex').asInteger of
          0 : begin
                balance := balance+rSet.GetFloatValue(rSet.FieldByName('Amount'));
              end;
          1 : begin
                prePaid := prePaid+rSet.GetFloatValue(rSet.FieldByName('Amount'));
              end;
        end;
        rSet.Next;
      end;
      FivhTotal_prePaid := prePaid;
      if invoicenumber = PROFORMA_INVOICE_NUMBER then
      begin
        FivhTotal_Balance := {sumTotal} FivhTotal-prepaid;
      end else
      begin
        FivhTotal_Balance := balance;
      end;
    end;
  finally
    freeandnil(rSet);
  end;



end;

end.
