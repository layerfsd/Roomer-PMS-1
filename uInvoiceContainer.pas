unit uInvoiceContainer;

interface

uses Generics.Collections,
     Classes,
     SysUtils,
     uDateUtils,
     uStringUtils,
     ComObj,
     MSXML;

{.$define TestRunningTabsAPI}

type

  TInvoiceSourceType = (istRoom, istGroup);
  TRoomerInvoiceType = (ritRoom, ritGroup, ritCash, ritCredit);

  TInvoiceLineType = (ltRoom, ltDiscount, ltStayTax, ltSale);
  TInvoicePaymentType = (iptDownPayment, iptInvoicePayment);

  TInvoice = class;

  TPaymentLine = class
    InvoicePaymentType : TInvoicePaymentType;
    AutoGen : String;
    ID : Integer;
    PaymentType : Integer;
    Person : Integer;
    PayDate : TDateTime;
    PayType : String;
    AccountKey : String;
    Amount : Double;
    Description : String;
    Notes : String;
    Staff : String;
    When : TDateTime;

    Currency : String;
    CurrencyRate : Double;

    FChanged : Boolean;
    FIsNew : Boolean;

    FXml : String;
  private
    function GetXml: String;
    procedure SetXml(const Value: String);
  public
    constructor Create(_Type : TInvoicePaymentType;
                       _AutoGen : String;
                       _ID : Integer;
                       _PaymentType : Integer;
                       _Person : Integer;
                       _PayDate : TDateTime;
                       _PayType : String;
                       _AccountKey : String;
                       _Amount : Double;
                       _Description : String;
                       _Notes : String;
                       _Staff : String;
                       _When : TDateTime;

                       _Currency : String;
                       _CurrencyRate : Double;
                       _IsNew : Boolean = False); overload;
    constructor Create(node: IXMLDomNode); overload;
    procedure Assign(PaymentLine : TPaymentLine);
    property Dirty : Boolean read FChanged write FChanged;
    property isNew : Boolean read FisNew write FisNew;
    property Xml : String read GetXml write SetXml;
  end;

  TPaymentLineList = TObjectList<TpaymentLine>;

  TInvoiceLine = class
    InvoiceLineType : TInvoiceLineType;
    ID : Integer;
    Index : Integer;
    PurchaseDate : TDate;
    ItemCode : String;
    AccountKey : String;
    Description : String;
    NumItems : Double;
    PriceNet : Double;
    PriceGross : Double;
    Vat : Double;

    VatCode : String;
    VatPercentage : Double;

    Nights : Integer;
    Persons : Integer;

    FChanged : Boolean;
    FIsNew : Boolean;

    FXml : String;
    FInvoice : TInvoice;
  private
    function GetXml: String;
    procedure SetXml(const Value: String);
    function GetLineTypeAsText: String;
    function GetInvoiceLineTypeFromText(value: String): TInvoiceLineType;
    function GetTotal: Double;
    function GetTotalVat: Double;
    function GetTotalNet: Double;
  public
    constructor Create(_Invoice : TInvoice;
                       _Type : TInvoiceLineType;
                       _ID : Integer;
                       _Index : Integer;
                       _PurchaseDate : TDate;
                       _ItemCode : String;
                       _AccountKey : String;
                       _Description : String;
                       _NumItems : Double;
                       _PriceNet : Double;
                       _PriceGross : Double;
                       _Vat : Double;

                       _VatCode : String;
                       _VatPercentage : Double;

                       _Nights : Integer = 0;
                       _Persons : Integer = 0;
                       _IsNew : Boolean = False); overload;
    constructor Create(_Invoice : TInvoice; node: IXMLDomNode); overload;
    constructor Create(_Invoice : TInvoice); overload;
    procedure ChangeCurrency(_Currency : String; OldRate, _CurrencyRate : Double);
    procedure Assign(InvoiceLine : TInvoiceLine);
    property Dirty : Boolean read FChanged write FChanged;
    property Invoice : TInvoice read FInvoice write FInvoice;
    property isNew : Boolean read FisNew write FisNew;
    property Total : Double read GetTotal;
    property TotalNet : Double read GetTotalNet;
    property TotalVat : Double read GetTotalVat;
    property Xml : String read GetXml write SetXml;
  end;

  TInvoiceLineList = TObjectlist<TInvoiceLine>;

  TInvoice = class
  private
    FCurrency : String;
    FXml : String;
    FChanged: Boolean;
    DeletedItems : TInvoiceLineList;
    DeletedPayments : TPaymentLineList;
    FExpanded: Boolean;
    procedure LoadInvoice;
    procedure LoadRoomRent;
    function GetXml: String;
    procedure SetXml(const Value: String);
    function GetTabTypeAsString: String;
    function GetTotalNetAmount: Double;
    function GetTotalGrossAmount: Double;
    function GetTotalVatAmount: Double;
    function GetTotalPaidAmount: Double;
    function GetXmlFromCustomer: String;
    function GetChanged: Boolean;
    function GetLinesChanged: Boolean;
    function GetPaymentsChanged: Boolean;
    procedure DeletePayments;
    procedure DeleteItems;
    function GetTotal: Double;
    function GetTotalNet: Double;
    function GetTotalVat: Double;
    function GetBalance: Double;
    function GetTotalPayments: Double;
    procedure SetExpanded(const Value: Boolean);
    function GetTotalRoomRent: Double;
    function GetTotalSales: Double;
    function GetTotalTaxes: Double;
    function GetTotalForSpecificLineType(lt: TInvoiceLineType): Double;
    function GetNumberOfRentLines: Integer;
    function GetCurrency: string;
  public
    InvoiceLines : TInvoiceLineList;
    payments : TPaymentLineList;
    Reservation : Integer;
    RoomReservation : Integer;
    SplitNumber : integer;
    InvoiceNumber : Integer;
    InvoiceType : TRoomerInvoiceType;
    RoomNumber : String;
    ID : Integer;
    CurrencyRate : Double;

    BookingId : String;

    TotalStayTax : Double;
    TotalStayTaxNights : Integer;

    Location : String;



    //
    InvoiceDate : TDate;
    Customer : String;
    CustPId : String;
    Name : String;
    Address1 : String;
    Address2 : String;
    Address3 : String;
    Address4 : String;
    Country : String;
    ExtraText : String;

    //
    CreditInvoiceLink : Integer;
    OriginalInvoice : Integer;

    RoomGuest : String;
    Staff : String;



    constructor Create(_Type : TRoomerInvoiceType; _ID : Integer; _Reservation, _RoomReservation, _SplitNumber, _InvoiceNumber : Integer; _RoomNumber : String; _expanded : Boolean);
    destructor Destroy; override;

    procedure DeleteItem(line : TInvoiceLine);
    procedure DeletePayment(line : TPaymentLine);
    procedure SetCustomerHeaderInfo(_InvoiceDate : TDate;
                                    _Customer : String;
                                    _CustPId : String;
                                    _Name : String;
                                    _Address1 : String;
                                    _Address2 : String;
                                    _Address3 : String;
                                    _Address4 : String;
                                    _Country : String;
                                    _ExtraText : String); overload;

    procedure SetCustomerHeaderInfo(node : IXMLDomNode); overload;
    function AddLine(_Type : TInvoiceLineType;
                     _ItemCode : String;
                     _Description : String;
                     _NumItems : Double;
                     _Price : Double;

                     _Nights : Integer = 0;
                     _Persons : Integer = 0;
                     _ID : Integer = 0;
                     _isNew : Boolean = False
                     ) : TInvoiceLine; overload;

    function AddLine(line : TInvoiceLine) : TInvoiceLine; overload;


    function AddPayment(_Type : TInvoicePaymentType;
                        _AutoGen : String;
                        _PaymentType : Integer;
                        _Person : Integer;
                        _PayDate : TDateTime;
                        _PayType : String;
                        _Amount : Double;
                        _Description : String;
                        _Notes : String;
                        _Staff : String;
                        _When : TDateTime;

                        _Currency : String;
                        _CurrencyRate : Double;
                        _ID : Integer = 0;
                        _IsNew : Boolean = False) : TPaymentLine; overload;

    function AddPayment(line : TPaymentLine) : TPaymentLine; overload;

    procedure ChangeCurrency(_Currency : String; _CurrencyRate : Double);
    procedure SendInvoice;




    property Xml : String read GetXml write SetXml;
    property Dirty : Boolean read FChanged write FChanged;
    property isChanged : Boolean read GetChanged;
    property TotalGross : Double read GetTotal;
    property TotalNet : Double read GetTotalNet;
    property TotalVat : Double read GetTotalVat;
    property TotalPayments : Double read GetTotalPayments;
    property TotalRoomRent : Double read GetTotalRoomRent;
    property TotalSales : Double read GetTotalSales;
    property TotalTaxes : Double read GetTotalTaxes;
    property Balance : Double read GetBalance;
    property expanded : Boolean read FExpanded write SetExpanded;
    property NumberOfRentLines : Integer read GetNumberOfRentLines;
    property Currency: string read GetCurrency;
  end;

implementation

uses uAppGlobal, hData, uD, _Glob, cmpRoomerDataSet, uUtils;

{ TInvoice }

function TInvoice.AddLine(_Type: TInvoiceLineType;
                          _ItemCode,
                          _Description: String;
                          _NumItems,
                          _Price: Double;
                          _Nights : Integer = 0;
                          _Persons : Integer = 0;
                          _ID : Integer = 0;
                          _isNew : Boolean = False
                        ): TInvoiceLine;
var vatCode,
    itemType : String;
    vatPercentage : Double;
begin
  //
   result := nil;
   if glb.LocateSpecificRecordAndGetValue('items', 'Item', _ItemCode, 'ItemType', itemType) AND
      glb.LocateSpecificRecordAndGetValue('itemtypes', 'ItemType', itemType, 'VATCode', vatCode) AND
      glb.LocateSpecificRecordAndGetValue('vatcodes', 'VATCode', vatCode, 'VATPercentage', vatPercentage) then
   begin
      result := TInvoiceLine.Create(self,
                       _Type,
                       _ID,
                       InvoiceLines.Count + 1,
                       trunc(now),
                       _ItemCode,
                       glb.Items['AccountKey'],
                       _Description,
                       _NumItems,
                       _Price / (1 + vatPercentage / 100),
                       _Price,
                       _Price - (_Price / (1 + vatPercentage / 100)), // VAT

                       vatCode,
                       vatPercentage,

                       _Nights,
                       _Persons,
                       _isNew);

      InvoiceLines.Add(result);
   end;
end;

function TInvoice.AddLine(line: TInvoiceLine): TInvoiceLine;
begin
  result := line;
  InvoiceLines.Add(line);
end;

function TInvoice.AddPayment(line: TPaymentLine): TPaymentLine;
begin
  result := line;
  payments.Add(line);
end;

function TInvoice.AddPayment(_Type: TInvoicePaymentType; _AutoGen: String;
                             _PaymentType : Integer;
                             _Person: Integer;
                             _PayDate: TDateTime;
                             _PayType: String;
                             _Amount: Double;
                             _Description,
                             _Notes,
                             _Staff: String;
                             _When: TDateTime;
                             _Currency: String;
                             _CurrencyRate: Double;
                             _ID: Integer;
                             _IsNew: Boolean): TPaymentLine;
var BookKey : String;
begin
  if glb.LocateSpecificRecordAndGetValue('paytypes', 'PayType', _PayType, 'BookKey', BookKey) then
  begin
    result := TPaymentLine.Create(_Type,
                                  _AutoGen,
                                  _ID,
                                  _PaymentType,
                                  _Person,
                                  _PayDate,
                                  _PayType,
                                  BookKey,
                                  _Amount,
                                  _Description,
                                  _Notes,
                                  _Staff,
                                  _When,
                                  _Currency,
                                  _CurrencyRate,
                                  _IsNew);
    payments.Add(result);
  end else
    raise Exception.Create('Unknown Payment Type: ' + _PayType);
end;

procedure TInvoice.ChangeCurrency(_Currency: String; _CurrencyRate: Double);
var
  i: Integer;
begin
  for i := 0 to InvoiceLines.Count - 1 do
    InvoiceLines[i].ChangeCurrency(_Currency, CurrencyRate, _CurrencyRate);
  FCurrency := _Currency;
  CurrencyRate := _CurrencyRate;
end;

constructor TInvoice.Create(_Type: TRoomerInvoiceType; _ID : Integer; _Reservation, _RoomReservation, _SplitNumber, _InvoiceNumber: Integer; _RoomNumber : String; _expanded : Boolean);
begin
  InvoiceLines := TInvoiceLineList.Create(True);
  payments := TPaymentLineList.Create(True);
  DeletedItems := TInvoiceLineList.Create(True);
  DeletedPayments := TPaymentLineList.Create(True);

  InvoiceType := _Type;
  Reservation := _Reservation;
  RoomReservation := _RoomReservation;
  SplitNumber := _SplitNumber;
  InvoiceNumber := _InvoiceNumber;
  RoomNumber := _RoomNumber;
  FExpanded := _expanded;

  ID := _ID;

  FChanged := False;

  LoadInvoice;
end;

procedure TInvoice.DeleteItem(line: TInvoiceLine);
begin
  if line.ID > 0 then
    DeletedItems.Add(line);
  InvoiceLines.Extract(line); // don't kill the object
end;

procedure TInvoice.DeletePayment(line: TPaymentLine);
begin
  if line.ID > 0 then
    DeletedPayments.Add(line);
  payments.Extract(line);  // don't kill the object
end;

destructor TInvoice.Destroy;
begin
  InvoiceLines.Free;
  payments.Free;
  DeletedItems.Free;
  DeletedPayments.Free;
end;

function TInvoice.GetLinesChanged: Boolean;
var
  i: Integer;
begin
  result := False;
  for i := 0 to InvoiceLines.Count - 1 do
  begin
    result := invoiceLines[i].Dirty OR invoiceLines[i].isNew;
    if result then Break;
  end;
end;

function TInvoice.GetNumberOfRentLines: Integer;
var i: Integer;
begin
  result := 0;
  for i := 0 to InvoiceLines.Count - 1 do
    if (InvoiceLines[i].InvoiceLineType = ltRoom) then
      inc(result);
end;

function TInvoice.GetPaymentsChanged: Boolean;
var
  i: Integer;
begin
  result := False;
  for i := 0 to Payments.Count - 1 do
  begin
    result := Payments[i].Dirty OR Payments[i].isNew;
    if result then Break;
  end;
end;

function TInvoice.GetBalance: Double;
begin
  result := TotalGross - TotalPayments;
end;

function TInvoice.GetChanged: Boolean;
begin
  result := Dirty OR GetLinesChanged OR GetPaymentsChanged;
end;

function TInvoice.GetCurrency: string;
begin
  if FCurrency.IsEmpty then
    // Fall back to native

  else
    Result := FCurrency;
end;

function TInvoice.GetTabTypeAsString: String;
begin
  case InvoiceType of
    ritRoom   : result := 'ROOM';
    ritGroup  : result := 'GROUP';
    ritCash   : result := 'CASH';
    ritCredit : result := 'CREDIT';
  end;
end;

function TInvoice.GetTotalNet: Double;
begin
  result := GetTotalNetAmount * CurrencyRate;
end;

function TInvoice.GetTotalNetAmount: Double;
var i: Integer;
begin
  result := 0.00;
  for i := 0 to InvoiceLines.Count - 1 do
    result := result + InvoiceLines[i].TotalNet;
end;

function TInvoice.GetTotal: Double;
begin
  result := GetTotalGrossAmount * CurrencyRate;
end;

function TInvoice.GetTotalGrossAmount: Double;
var i: Integer;
begin
  result := 0.00;
  for i := 0 to InvoiceLines.Count - 1 do
    result := result + InvoiceLines[i].Total;
end;

function TInvoice.GetTotalPaidAmount: Double;
var i: Integer;
begin
  result := 0.00;
  for i := 0 to payments.Count - 1 do
    result := result + payments[i].Amount;
end;

function TInvoice.GetTotalPayments: Double;
var i : Integer;
    line: TPaymentLine;
begin
  result := 0.00;
  for i := 0 to Payments.Count - 1 do
  begin
    line := Payments[i];
    result := result + line.Amount * line.CurrencyRate;
  end;
end;

function TInvoice.GetTotalForSpecificLineType(lt : TInvoiceLineType) : Double;
var i: Integer;
begin
  result := 0.00;
  for i := 0 to InvoiceLines.Count - 1 do
    if (InvoiceLines[i].InvoiceLineType = lt) then
      result := result + InvoiceLines[i].Total;
end;

function TInvoice.GetTotalRoomRent: Double;
begin
  result := GetTotalForSpecificLineType(ltRoom);
  result := result - GetTotalForSpecificLineType(ltDiscount);
end;

function TInvoice.GetTotalSales: Double;
begin
  result := GetTotalForSpecificLineType(ltSale);
end;

function TInvoice.GetTotalTaxes: Double;
begin
  result := GetTotalForSpecificLineType(ltStayTax);
end;

function TInvoice.GetTotalVat: Double;
begin
  result := GetTotalVatAmount * CurrencyRate;
end;

function TInvoice.GetTotalVatAmount: Double;
var i: Integer;
begin
  result := 0.00;
  for i := 0 to InvoiceLines.Count - 1 do
    result := result + InvoiceLines[i].Vat * InvoiceLines[i].NumItems;
end;

function TInvoice.GetXmlFromCustomer: String;
var CountryName : String;
begin
  if NOT glb.LocateSpecificRecordAndGetValue('countries', 'Country', Country, 'CountryName', CountryName) then
    CountryName := 'Unknown';
  result := format('<customer roomerCode="%s" PID="%s">' +
                   '<name>%s</name>' +
                   '<address1>%s</address1>' +
                   '<address2>%s</address2><zip>%s</zip><city>%s</city>' +
                   '<country>%s</country><countryName>%s</countryName></customer>',
                   [Customer, CustPID,
                   Name,
                   Address1,
                   Address2, Address3, Address4,
                   Country, CountryName]);

end;

function TInvoice.GetXml: String;
var i: Integer;
begin
  result := format('<runningTabs room="%s" roomReservationId="%d" reservationId="%d">' +
                   '<runningTab tabType="%s" description="%s" currency="%s" currencyRate="%s" ' +
                   'totalNetAmount="%s" totalVatAmount="%s" totalGrossAmount="%s" ' +
                   'totalPaid="%s" balance="%s">',
                   [RoomNumber, RoomReservation, Reservation,
                   GetTabTypeAsString, GetTabTypeAsString, FCurrency, FloatToXml(CurrencyRate, 5),
                   FloatToXml(GetTotalNetAmount, 2), FloatToXml(GetTotalVatAmount, 2), FloatToXml(GetTotalGrossAmount, 2),
                   FloatToXml(GetTotalPaidAmount, 2), FloatToXml(GetTotalGrossAmount - GetTotalPaidAmount, 2)]);

  result := result + GetXmlFromCustomer;
  result := result + '<products>';
  for i := 0 to InvoiceLines.Count - 1 do
    if InvoiceLines[i].Dirty OR InvoiceLines[i].IsNew then
    result := result + InvoiceLines[i].Xml;
  result := result + '</products>';

  result := result + '<payments>';
  for i := 0 to payments.Count - 1 do
    if payments[i].Dirty OR payments[i].IsNew then
      result := result + payments[i].Xml;
  result := result + '</payments>';

  result := result + '</runningTab></runningTabs>';

end;

procedure TInvoice.LoadInvoice;
begin
  InvoiceLines.Clear;
  payments.Clear;
  DeletedItems.Clear;
  DeletedPayments.Clear;

  if InvoiceNumber <= 0 then
    LoadRoomRent;
end;

procedure TInvoice.LoadRoomRent;
var url, exp : String;
begin
  if FExpanded then
    exp := 'true'
  else
    exp := 'false';
{$IFDEF TestRunningTabsAPI}
  url := 'runningTab/test/id/' + LowerCase(d.roomerMainDataSet.HotelId) + '/' + inttostr(RoomReservation) + '?expanded=' + exp;
{$ELSE}
  url := format('runningTab/id/%d?expanded=%s', [RoomReservation, exp]);
{$ENDIF}
  Xml := d.roomerMainDataSet.downloadRoomerUrlAsString(url);
end;

procedure TInvoice.DeletePayments;
var sTemp, url : String;
  i: Integer;
begin
  sTemp := '';
  for i := 0 to DeletedPayments.Count - 1 do
  begin
    if i = 0 then
      sTemp := inttostr(DeletedPayments[i].ID)
    else
      sTemp := sTemp + ',' + inttostr(DeletedPayments[i].ID);
  end;
  if sTemp <> '' then
  begin
{$IFDEF TestRunningTabsAPI}
    url := 'runningTab/test/delete/payment/' + LowerCase(d.roomerMainDataSet.HotelId) + '/' + sTemp;
{$ELSE}
    url := 'runningTab/delete/payment/' + sTemp;
{$ENDIF}
    d.roomerMainDataSet.DeleteData(url);
  end;
end;

procedure TInvoice.DeleteItems;
var sTemp, url : String;
  i: Integer;
begin
  sTemp := '';
  for i := 0 to DeletedItems.Count - 1 do
  begin
    if i = 0 then
      sTemp := inttostr(DeletedItems[i].ID)
    else
      sTemp := sTemp + ',' + inttostr(DeletedItems[i].ID);
  end;
  if sTemp <> '' then
  begin
{$IFDEF TestRunningTabsAPI}
    url := 'runningTab/test/delete/item/' + LowerCase(d.roomerMainDataSet.HotelId) + '/' + sTemp;
{$ELSE}
    url := 'runningTab/delete/item/' + sTemp;
{$ENDIF}
    d.roomerMainDataSet.DeleteData(url);
  end;
end;

procedure TInvoice.SendInvoice;
var url : String;
begin
  DeleteItems;
  DeletePayments;

  if NOT isChanged then Exit;

{$IFDEF TestRunningTabsAPI}
  url := 'runningTab/add/test/' + LowerCase(d.roomerMainDataSet.HotelId);
{$ELSE}
  url := 'runningTab/add';
{$ENDIF}
  Xml := d.roomerMainDataSet.PutData(url, 'xml=' + d.roomerMainDataSet.UrlEncode(Xml));
end;

procedure TInvoice.SetCustomerHeaderInfo(_InvoiceDate: TDate; _Customer, _CustPId, _Name, _Address1, _Address2, _Address3, _Address4, _Country, _ExtraText: String);
begin
  InvoiceDate := _InvoiceDate;
  Customer := _Customer;
  CustPId := _CustPId;
  Name := _Name;
  Address1 := _Address1;
  Address2 := _Address2;
  Address3 := _Address3;
  Address4 := _Address4;
  Country := _Country;
  ExtraText := _ExtraText;
end;

procedure TInvoice.SetCustomerHeaderInfo(node : IXMLDomNode);
var
  i: Integer;
begin
  // iptDownPayment, iptInvoicePayment
  Customer := node.attributes.getNamedItem('roomerCode').text;
  CustPId := node.attributes.getNamedItem('PID').text;
  for i := 0 to node.childNodes.length - 1 do
  begin
    if node.childNodes[i].nodeName = 'name' then
      Name := node.childNodes[i].Text
    else
    if node.childNodes[i].nodeName = 'address1' then
      Address1 := node.childNodes[i].Text
    else
    if node.childNodes[i].nodeName = 'address2' then
      Address2 := node.childNodes[i].Text
    else
    if node.childNodes[i].nodeName = 'zip' then
      Address3 := node.childNodes[i].Text
    else
    if node.childNodes[i].nodeName = 'city' then
      Address4 := node.childNodes[i].Text
    else
    if node.childNodes[i].nodeName = 'country' then
      Country := node.childNodes[i].Text;
  end;
end;

procedure TInvoice.SetExpanded(const Value: Boolean);
begin
  FExpanded := Value;
  SendInvoice;
  LoadInvoice;
end;

procedure TInvoice.SetXml(const Value: String);
var
  Doc: IXMLDomDocument;
  node, node_temp: IXMLDomNode;
  nodes_tab, nodes_products, nodes_payments, nodes_customers : IXMLDomNodeList;
  i, j: Integer;
begin
  Doc := CreateOleObject('Microsoft.XMLDOM') as IXMLDOMDocument;
  Doc.async := False;
  Doc.loadXML(value);
  if Doc.parseError.errorCode <> 0 then
    raise Exception.Create('XML Load error:' + Doc.parseError.reason);

  nodes_tab := Doc.selectNodes('/runningTabs/runningTab');
  for i := 0 to nodes_tab.length - 1 do
  begin
    node := nodes_tab.item[i];
    if node.attributes.getNamedItem('tabType').Text = GetTabTypeAsString then
    begin

      // First products/invoice lines
      nodes_products := node.selectNodes('products/product');
      for j := 0 to nodes_products.length - 1 do
      begin
        node_temp := nodes_products.item[j];
        InvoiceLines.Add(TInvoiceLine.Create(self, node_temp));
      end;

      // Now payments
      nodes_payments := node.selectNodes('payments/payment');
      for j := 0 to nodes_payments.length - 1 do
      begin
        node_temp := nodes_payments.item[j];
        payments.Add(TPaymentLine.Create(node_temp));
      end;

      // And then customer info
      nodes_customers := node.selectNodes('customer');
      for j := 0 to nodes_customers.length - 1 do
      begin
        node_temp := nodes_customers.item[j];
        SetCustomerHeaderInfo(node_temp);
      end;

      FCurrency := node.attributes.getNamedItem('currency').text;
      CurrencyRate := LocalizedFloatValue(node.attributes.getNamedItem('currencyRate').text, true, 1.00);


    end;
  end;

//  nodes_tab := Doc.selectNodes('/runningTabs/runningTab/');
end;

{ TInvoiceLine }

constructor TInvoiceLine.Create(_Invoice : TInvoice;
                                _Type: TInvoiceLineType; _ID : Integer;
                                _Index: Integer;
                                _PurchaseDate: TDate;
                                _ItemCode, _AccountKey, _Description: String;
                                _NumItems, _PriceNet, _PriceGross, _Vat: Double;
                                _VatCode: String;
                                _VatPercentage: Double;
                                _Nights : Integer = 0;
                                _Persons : Integer = 0;
                                _IsNew : Boolean = False);
begin
  InvoiceLineType := _Type;
  ID := _ID;
  Index := _Index;
  PurchaseDate := _PurchaseDate;
  ItemCode := _ItemCode;
  AccountKey := _AccountKey;
  Description := _Description;
  NumItems := _NumItems;
  PriceNet := _PriceNet;
  PriceGross := _PriceGross;
  Vat := _Vat;

  VatCode := _VatCode;
  VatPercentage := _VatPercentage;


  Nights := _Nights;
  Persons := _Persons;

 //
  FChanged:= False;
  FIsNew := _IsNew;
  FInvoice := _Invoice;
end;

procedure TInvoiceLine.Assign(InvoiceLine: TInvoiceLine);
begin
  InvoiceLineType := InvoiceLine.InvoiceLineType;
  ID := InvoiceLine.ID;
  Index := InvoiceLine.Index;
  PurchaseDate := InvoiceLine.PurchaseDate;
  ItemCode := InvoiceLine.ItemCode;
  AccountKey := InvoiceLine.AccountKey;
  Description := InvoiceLine.Description;
  NumItems := InvoiceLine.NumItems;
  PriceNet := InvoiceLine.PriceNet;
  PriceGross := InvoiceLine.PriceGross;
  Vat := InvoiceLine.Vat;

  VatCode := InvoiceLine.VatCode;
  VatPercentage := InvoiceLine.VatPercentage;

  Nights := InvoiceLine.Nights;
  Persons := InvoiceLine.Persons;

  FChanged := InvoiceLine.FChanged;
  FIsNew := InvoiceLine.FIsNew;

  FXml := InvoiceLine.FXml;

  FInvoice := InvoiceLine.FInvoice;
end;

constructor TInvoiceLine.Create(_Invoice : TInvoice; node: IXMLDomNode);
var
  i: Integer;
begin
  FInvoice := _Invoice;
  InvoiceLineType := GetInvoiceLineTypeFromText(node.attributes.getNamedItem('type').text);
  ID := StrToIntdef(node.attributes.getNamedItem('id').text, -1);
  Index := StrToIntDef(node.attributes.getNamedItem('index').text, 0);
  ItemCode := node.attributes.getNamedItem('roomerId').text;
  AccountKey := node.attributes.getNamedItem('accountKey').text;
  for i := 0 to node.childNodes.length - 1 do
  begin
    if node.childNodes[i].nodeName = 'text1' then
      Description := node.childNodes[i].text
    else
    if node.childNodes[i].nodeName = 'purchaseDate' then
      PurchaseDate := SqlStringToDate(node.childNodes[i].Text)
    else
    if node.childNodes[i].nodeName = 'numItems' then
      NumItems := LocalizedFloatValue(node.childNodes[i].Text, true, 0.00)
    else
    if node.childNodes[i].nodeName = 'itemNetPrice' then
      PriceNet := LocalizedFloatValue(node.childNodes[i].Text, true, 0.00)
    else
    if node.childNodes[i].nodeName = 'itemGrossPrice' then
      PriceGross := LocalizedFloatValue(node.childNodes[i].Text, true, 0.00)
    else
    if node.childNodes[i].nodeName = 'itemVatAmount' then
    begin
      Vat := LocalizedFloatValue(node.childNodes[i].Text, true, 0.00);
      VatCode := node.childNodes[i].attributes.getNamedItem('roomerCode').Text;
      VatPercentage := LocalizedFloatValue(node.childNodes[i].attributes.getNamedItem('percentage').Text, true, 0.00);
    end;
  end;

//  Nights := _Nights;
//  Persons := _Persons;

 //
  FChanged:= False;
end;

procedure TInvoiceLine.ChangeCurrency(_Currency: String; OldRate, _CurrencyRate: Double);
begin
//  if InvoiceLineType = ltRoom  then
//  begin
    PriceNet := PriceNet * (OldRate / _CurrencyRate);
    PriceGross := PriceGross * (OldRate / _CurrencyRate);
    Vat := Vat * (OldRate / _CurrencyRate);
//  end;
end;

constructor TInvoiceLine.Create(_Invoice : TInvoice);
begin
  InvoiceLineType := ltSale;
  ID := -1;
  Index := MaxInt;
  PurchaseDate := Trunc(Now);
  ItemCode := '';
  AccountKey := '';
  Description := '';
  NumItems := 1;
  PriceNet := 0.00;
  PriceGross := 0.00;
  Vat := 0.00;

  VatCode := '';
  VatPercentage := 0.00;

  Nights := 0;
  Persons := 0;

  FChanged := False;
  FIsNew := true;

  FXml := '';
  FInvoice := _Invoice;
end;

function TInvoiceLine.GetInvoiceLineTypeFromText(value : String) : TInvoiceLineType;
begin
  if value = 'SALE' then
    result := ltSale
  else
  if value = 'STAYTAX' then
    result := ltStayTax
  else
  if value = 'DISCOUNT' then
    result := ltDiscount
  else
  if value = 'ROOMRENT' then
    result := ltRoom
  else
    result := ltSale;
end;

function TInvoiceLine.GetLineTypeAsText : String;
begin
  case InvoiceLineType of
    ltRoom : result := 'ROOMRENT';
    ltDiscount : result := 'DISCOUNT';
    ltStayTax : result := 'STAYTAX';
    ltSale : result := 'SALE';
  else
    result := 'SALE';
  end;
end;

function TInvoiceLine.GetTotal: Double;
begin
  result := PriceGross * NumItems;
end;

function TInvoiceLine.GetTotalNet: Double;
begin
  result := PriceNet * NumItems;
end;

function TInvoiceLine.GetTotalVat: Double;
begin
  result := Vat * NumItems;
end;

function TInvoiceLine.GetXml: String;
var sId : String;
    PNet,
    PGross,
    V: double;
begin
  sId := inttostr(ID);
  if FIsNew then
    sId := '-1';
  PNet := PriceNet * FInvoice.CurrencyRate;
  PGross := PriceGross * FInvoice.CurrencyRate;
  V := Vat * FInvoice.CurrencyRate;

  result := format('<product id="%s" index="%d" type="%s" roomerId="%s" accountKey="%s">' +     //1
                   '<text1>%s</text1><text2>%s</text2><purchaseDate>%s</purchaseDate>' +        //2
                   '<numItems>%s</numItems><itemNetPrice>%s</itemNetPrice>' +                   //3
                   '<itemVatAmount roomerCode="%s" percentage="%s">%s</itemVatAmount>' +         //4
                   '<itemGrossPrice>%s</itemGrossPrice><totalNetAmount>%s</totalNetAmount>' +   //5
                   '<totalVatAmount roomerCode="%s" percentage="%s">%s</totalVatAmount>' +      //6
                   '<totalGrossAmount>%s</totalGrossAmount></product>',
                   [sId, Index, GetLineTypeAsText, ItemCode, AccountKey,                        //1
                    XmlEncode_ex(Description, Description), '' {Text2}, DateToSqlString(PurchaseDate), //2
                    FloatToXml(NumItems, 2), FloatToXml(PNet, 2),                           //3
                    VatCode, FloatToXml(VatPercentage, 2), FloatToXml(V, 2),                  //4
                    FloatToXml(PGross, 2), FloatToXml(NumItems * PNet, 2),              //5
                    VatCode, FloatToXml(VatPercentage, 2), FloatToXml(NumItems * V, 2),       //6
                    FloatToXml(NumItems * PGross, 2)]);
end;

procedure TInvoiceLine.SetXml(const Value: String);
begin

end;

{ TPaymentLine }

constructor TPaymentLine.Create(_Type: TInvoicePaymentType;
                                _AutoGen: String;
                                _ID,
                                _PaymentType : Integer;
                                _Person: Integer;
                                _PayDate: TDateTime;
                                _PayType: String;
                                _AccountKey : String;
                                _Amount: Double;
                                _Description,
                                _Notes,
                                _Staff: String;
                                _When: TDateTime;
                                _Currency: String;
                                _CurrencyRate: Double;
                                _IsNew : Boolean = False);
begin
  InvoicePaymentType := _Type;
  AutoGen := _AutoGen;
  ID := _ID;
  PaymentType := _PaymentType;
  Person := _Person;
  PayDate := _PayDate;
  PayType := _PayType;
  AccountKey := _AccountKey;
  Amount := _Amount;
  Description := _Description;
  Notes := _Notes;
  Staff := _Staff;
  When := _When;

  Currency := _Currency;
  CurrencyRate := _CurrencyRate;

  FChanged := False;
  FIsNew := _IsNew;
end;

procedure TPaymentLine.Assign(PaymentLine: TPaymentLine);
begin
  InvoicePaymentType := PaymentLine.InvoicePaymentType;
  AutoGen := PaymentLine.AutoGen;
  ID := PaymentLine.ID;
  Person := PaymentLine.Person;
  PayDate := PaymentLine.PayDate;
  PayType := PaymentLine.PayType;
  PaymentType := PaymentLine.PaymentType;
  AccountKey := PaymentLine.AccountKey;
  Amount := PaymentLine.Amount;
  Description := PaymentLine.Description;
  Notes := PaymentLine.Notes;
  Staff := PaymentLine.Staff;
  When := PaymentLine.When;

  Currency := PaymentLine.Currency;
  CurrencyRate := PaymentLine.CurrencyRate;

  FChanged := PaymentLine.FChanged;
  FIsNew := PaymentLine.FIsNew;

  FXml := PaymentLine.FXml;
end;

constructor TPaymentLine.Create(node: IXMLDomNode);
var
  i: Integer;
begin
  // iptDownPayment, iptInvoicePayment
  InvoicePaymentType := iptInvoicePayment;
  ID := StrToIntdef(node.attributes.getNamedItem('id').text, -1);
  PaymentType := StrToIntdef(node.attributes.getNamedItem('paymentType').text, -1);
  PayType := node.attributes.getNamedItem('roomerCode').text;
  AccountKey := node.attributes.getNamedItem('accountKey').text;
  Currency := node.attributes.getNamedItem('currency').text;
  CurrencyRate := LocalizedFloatValue(node.attributes.getNamedItem('currencyRate').text, true, 1.00);
  for i := 0 to node.childNodes.length - 1 do
  begin
    if node.childNodes[i].nodeName = 'description' then
      Description := node.childNodes[i].Text
    else
    if node.childNodes[i].nodeName = 'notes' then
      Notes := node.childNodes[i].Text
    else
    if node.childNodes[i].nodeName = 'paymentDate' then
      PayDate := SqlStringToDate(node.childNodes[i].Text)
    else
    if node.childNodes[i].nodeName = 'amount' then
      Amount := LocalizedFloatValue(node.childNodes[i].Text, true, 0.00);
  end;

  FChanged := false;
  FIsNew := false;
end;

function TPaymentLine.GetXml: String;
begin
  result := format('<payment id="%d" roomerCode="%s" paymentType="%s" accountKey="%s" currency="%s" currencyRate="%s">' +
                   '<amount>%s</amount><description>%s</description><notes>%s</notes><paymentDate>%s</paymentDate></payment>',
                   [id, PayType, inttostr(paymentType), AccountKey,
                    Currency, FloatToXml(CurrencyRate, 5),
                    FloatToXml(Amount * CurrencyRate, 2), XmlEncode_ex(Description, Description), XmlEncode_ex(notes, notes), DateToSqlString(PayDate)]);

end;

procedure TPaymentLine.SetXml(const Value: String);
begin
end;

end.

