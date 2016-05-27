unit uInvoice2015;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Generics.Collections, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, sListView, Vcl.ExtCtrls, sPanel, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinCaramel, dxSkinCoffee, dxSkinDarkSide, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, Vcl.StdCtrls, sEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, sLabel, sButton, Vcl.Menus, sCheckBox,
  cxButtons, sComboBox, sPageControl, cxClasses, cxPropertiesStore, uInvoiceContainer;

type

  TFrmInvoice2015 = class;

  TOpenInvoice = class
    Form: TFrmInvoice2015;
    Reservation: Integer;
    RoomReservation: Integer;
    SplitNumber: Integer;
    Credit: boolean;
    constructor Create(_Reservation, _RoomReservation, _SplitNumber: Integer; _Credit: boolean; _Form: TFrmInvoice2015);

  end;

  TOpenInvoiceList = TObjectList<TOpenInvoice>;

  TOpenInvoices = class
    FOpenInvoices: TOpenInvoiceList;
    function Add(OpenInvoice: TOpenInvoice): Integer;
    function FindForm(Reservation, RoomReservation, SplitNumber: Integer; Credit: boolean): TFrmInvoice2015;
    procedure RemoveForm(Form: TFrmInvoice2015);
    constructor Create;
    destructor Destroy; override;
  private
    procedure CloseAllForms;
  end;

  TFrmInvoice2015 = class(TForm)
    pContainer: TsPanel;
    pTop: TsPanel;
    pBottom: TsPanel;
    sPanel1: TsPanel;
    sPanel2: TsPanel;
    sLabel1: TsLabel;
    edtCustomer: TcxButtonEdit;
    sLabel2: TsLabel;
    edtName: TsEdit;
    edtAddress1: TsEdit;
    sLabel3: TsLabel;
    edtZip: TsEdit;
    sLabel4: TsLabel;
    edtAddress2: TsEdit;
    edtCity: TsEdit;
    sLabel5: TsLabel;
    edtCountryName: TsEdit;
    edtCountry: TcxButtonEdit;
    sPageControl1: TsPageControl;
    sTabSheet2: TsTabSheet;
    cbCustomerNameMethod: TsComboBox;
    sLabel6: TsLabel;
    sPanel4: TsPanel;
    pgContainer: TsPageControl;
    sTabSheet3: TsTabSheet;
    sTabSheet4: TsTabSheet;
    lvLines: TsListView;
    sPanel3: TsPanel;
    btnInsert: TsButton;
    btnEdit: TsButton;
    btnDelete: TsButton;
    sPanel5: TsPanel;
    lvPayments: TsListView;
    sButton1: TsButton;
    btnEditPayment: TsButton;
    btnDeletePayment: TsButton;
    btnProforma: TcxButton;
    btnInvoice: TcxButton;
    chkShowPackage: TsCheckBox;
    sPanel6: TsPanel;
    edtCurrency: TcxButtonEdit;
    sLabel7: TsLabel;
    sLabel8: TsLabel;
    edtCurrencyRate: TsEdit;
    Shape1: TShape;
    sLabel9: TsLabel;
    edtTotalNet: TsEdit;
    sLabel10: TsLabel;
    edtVat: TsEdit;
    sLabel11: TsLabel;
    edtInvoiceTotal: TsEdit;
    edtPayments: TsEdit;
    sLabel12: TsLabel;
    edtBalance: TsEdit;
    sLabel13: TsLabel;
    StoreMain: TcxPropertiesStore;
    sLabel14: TsLabel;
    edtPersonalId: TcxButtonEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lvLinesSelectItem(Sender: TObject; Item: TListItem; Selected: boolean);
    procedure btnEditClick(Sender: TObject);
    procedure lvLinesDblClick(Sender: TObject);
    procedure edtCustomerPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cbCustomerNameMethodCloseUp(Sender: TObject);
    procedure edtCurrencyPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure lvLinesItemChecked(Sender: TObject; Item: TListItem);
    procedure btnDeleteClick(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure btnEditPaymentClick(Sender: TObject);
    procedure lvPaymentsSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvPaymentsItemChecked(Sender: TObject; Item: TListItem);
    procedure btnDeletePaymentClick(Sender: TObject);
  private
    FSplitNumber: Integer;
    FReservation: Integer;
    FRoomReservation: Integer;
    FCredit: boolean;
    FNativeCurrency: String;
    FRoomNumber: String;
    FInvoice: TInvoice;
    FCash: boolean;
    FInvoiceNumber: Integer;
    FExpanded : Boolean;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure prepareInvoice;
    procedure DisplayInvoice;
    procedure DisplayLines;
    procedure DisplayPayments;
    procedure DisplayLine(Item: TListItem);
    function CreateLineItem: TListItem;
    procedure DisplayTotals;
    procedure SetCustomer(Customer: String);
    procedure DisplayCustomer;
    procedure GetReservationHeaderInformation;
    procedure GetGuestInformation;
    procedure GetInvoiceHeaderInformation;
    procedure GetCashInvoiceHeaderInformation;
    function AnyChecked(lv : TsListView): Boolean;
    function CreatePaymentItem: TListItem;
    procedure DisplayPayment(Item: TListItem);
    function CurrentlySelectedPayment: TPaymentLine;
    procedure SetExpanded(const Value: Boolean);
    { Private declarations }
  public
    { Public declarations }
    property Reservation: Integer read FReservation write FReservation;
    property RoomReservation: Integer read FRoomReservation write FRoomReservation;
    property SplitNumber: Integer read FSplitNumber write FSplitNumber;
    property InvoiceNumber: Integer read FInvoiceNumber write FInvoiceNumber;
    property Credit: boolean read FCredit write FCredit;
    property Cash: boolean read FCash write FCash;
    property NativeCurrency: String read FNativeCurrency write FNativeCurrency;
    property Expanded : Boolean read FExpanded write SetExpanded;
    property RoomNumber: String read FRoomNumber write FRoomNumber;
    property Invoice: TInvoice read FInvoice write FInvoice;
  end;

var
  FrmInvoice2015: TFrmInvoice2015;
  OpenInvoices: TOpenInvoices;

procedure EditInvoice2015(Reservation, RoomReservation, SplitNumber: Integer; Credit, Cash: boolean; RoomNumber: String; Expanded : Boolean; InvoiceNumber: Integer = -1);

implementation

{$R *.dfm}

uses hData, uUtils, uInvoiceLineEdit, uCustomers2, uAppGlobal, uG, uD, cmpRoomerDataset, uSqlDefinitions, uCurrencies;

procedure EditInvoice2015(Reservation, RoomReservation, SplitNumber: Integer; Credit, Cash: boolean; RoomNumber: String; Expanded : Boolean; InvoiceNumber: Integer = -1);
var
  _frmInvoice: TFrmInvoice2015;
begin
  _frmInvoice := OpenInvoices.FindForm(Reservation, RoomReservation, SplitNumber, Credit);
  if NOT Assigned(_frmInvoice) then
  begin
    _frmInvoice := TFrmInvoice2015.Create(nil);
    _frmInvoice.Reservation := Reservation;
    _frmInvoice.RoomReservation := RoomReservation;
    _frmInvoice.SplitNumber := SplitNumber; // 1 = credit Invoice
    _frmInvoice.Credit := Credit;
    _frmInvoice.Cash := Cash;
    _frmInvoice.RoomNumber := RoomNumber;
    _frmInvoice.Expanded := Expanded;
    _frmInvoice.InvoiceNumber := InvoiceNumber;

    OpenInvoices.Add(TOpenInvoice.Create(Reservation, RoomReservation, SplitNumber, Credit, _frmInvoice));

    // _frmInvoice.LoadInvoice;

    _frmInvoice.prepareInvoice;
    _frmInvoice.StoreMain.StorageName := 'Software\Roomer\FormStatus\Invoice2015_' + RoomNumber;
    _frmInvoice.StoreMain.RestoreFrom;

    _frmInvoice.Show;
    _frmInvoice.BringToFront;

  end
  else
  begin
    if _frmInvoice.WindowState = wsMinimized then
      _frmInvoice.WindowState := wsNormal;
    _frmInvoice.BringToFront;
  end;
end;

procedure TFrmInvoice2015.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  StoreMain.StoreTo;
  FInvoice.SendInvoice;
  OpenInvoices.RemoveForm(self);
  // Action := caFree;
end;

procedure TFrmInvoice2015.FormCreate(Sender: TObject);
begin
  NativeCurrency := ctrlGetString('NativeCurrency');
  pgContainer.ActivePageIndex := 0;
end;

procedure TFrmInvoice2015.FormDestroy(Sender: TObject);
begin
  FInvoice.Free;
end;

procedure TFrmInvoice2015.lvLinesDblClick(Sender: TObject);
begin
  btnEdit.Click;
end;

function TFrmInvoice2015.AnyChecked(lv : TsListView) : Boolean;
var i : Integer;
begin
  result := False;
  for i:= lv.Items.Count-1 downto 0 do
    if lv.Items[i].Checked then
    begin
      result := true;
      Break;
    end;
end;

procedure TFrmInvoice2015.lvLinesItemChecked(Sender: TObject; Item: TListItem);
begin
  btnDelete.Enabled := AnyChecked(lvLines);
end;

procedure TFrmInvoice2015.lvLinesSelectItem(Sender: TObject; Item: TListItem; Selected: boolean);
begin
  btnEdit.Enabled := Selected;
  btnDelete.Enabled := Selected;
end;

procedure TFrmInvoice2015.lvPaymentsItemChecked(Sender: TObject; Item: TListItem);
begin
  btnDeletePayment.Enabled := AnyChecked(lvPayments);
end;

procedure TFrmInvoice2015.lvPaymentsSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  btnEditPayment.Enabled := CurrentlySelectedPayment <> nil;
  btnDeletePayment.Enabled := CurrentlySelectedPayment <> nil;
end;

procedure TFrmInvoice2015.DisplayLine(Item: TListItem);
var
  line: TInvoiceLine;
  CurrCorr: Double;
begin
  line := TInvoiceLine(Item.Data);
  Item.Caption := line.ItemCode;
  Item.SubItems[0] := line.Description;
  // if line.InvoiceLineType <> ltRoom then
  // CurrCorr := FInvoice.CurrencyRate
  // else
  CurrCorr := 1.00;

  Item.SubItems[1] := FloatToXml(line.NumItems, 2);
  Item.SubItems[2] := FloatToXml(line.PriceGross / CurrCorr, 2);
  Item.SubItems[3] := FloatToXml(line.Total / CurrCorr, 2);
end;

function TFrmInvoice2015.CreateLineItem: TListItem;
begin
  result := lvLines.Items.Add;
  result.SubItems.Add('');
  result.SubItems.Add('');
  result.SubItems.Add('');
  result.SubItems.Add('');
end;

procedure TFrmInvoice2015.DisplayPayment(Item: TListItem);
var
  line: TPaymentLine;
  sTemp : String;
begin
  line := TPaymentLine(Item.Data);
  Item.Caption := DateToStr(line.PayDate);
  Item.SubItems[0] := line.PayType;

  Item.SubItems[1] := FloatToXml(line.Amount, 2);
  Item.SubItems[2] := line.Description;
  if glb.LocateSpecificRecordAndGetValue('paytypes', 'PayType', line.PayType, 'PayGroup', sTemp) then
    Item.SubItems[3] := sTemp;
  Item.SubItems[4] := line.Notes;
end;

function TFrmInvoice2015.CreatePaymentItem: TListItem;
begin
  result := lvPayments.Items.Add;
  result.SubItems.Add('');
  result.SubItems.Add('');
  result.SubItems.Add('');
  result.SubItems.Add('');
  result.SubItems.Add('');
end;

procedure TFrmInvoice2015.DisplayLines;
var
  i: Integer;
  Item: TListItem;
  line: TInvoiceLine;
begin
  lvLines.Items.Clear;
  for i := 0 to FInvoice.InvoiceLines.Count - 1 do
  begin
    line := FInvoice.InvoiceLines[i];
    Item := CreateLineItem;
    Item.Data := line;
    DisplayLine(Item);
  end;
end;

procedure TFrmInvoice2015.DisplayPayments;
var
  i: Integer;
  Item: TListItem;
  line: TPaymentLine;
begin
  lvPayments.Items.Clear;
  for i := 0 to FInvoice.Payments.Count - 1 do
  begin
    line := FInvoice.Payments[i];
    Item := CreatePaymentItem;
    Item.Data := line;
    DisplayPayment(Item);
  end;
end;

procedure TFrmInvoice2015.DisplayTotals;
begin
  edtTotalNet.Text := FloatToXml(FInvoice.TotalNet, 2);
  edtVat.Text := FloatToXml(FInvoice.TotalVat, 2);
  edtInvoiceTotal.Text := FloatToXml(FInvoice.TotalGross, 2);

  edtPayments.Text := FloatToXml(FInvoice.TotalPayments, 2);
  edtBalance.Text := FloatToXml(FInvoice.Balance, 2);
end;

procedure TFrmInvoice2015.SetCustomer(Customer: String);
var
  CustomerHolderEX: recCustomerHolderEX;
begin
  CustomerHolderEX := hData.Customer_GetHolder(Customer);
  FInvoice.Customer := Customer;
  FInvoice.CustPId := CustomerHolderEX.PID;
  if cbCustomerNameMethod.ItemIndex = 0 then
  begin
    FInvoice.Name := InvoiceName(0, CustomerHolderEX.DisplayName, CustomerHolderEX.CustomerName);
    FInvoice.Address1 := CustomerHolderEX.Address1;
    FInvoice.Address2 := CustomerHolderEX.Address2;
    FInvoice.Address3 := CustomerHolderEX.Address3;
    FInvoice.Address4 := CustomerHolderEX.Address4;
    FInvoice.Country := CustomerHolderEX.Country;
  end;
  FInvoice.Dirty := True;
  DisplayCustomer;
end;

procedure TFrmInvoice2015.SetExpanded(const Value: Boolean);
begin
  FExpanded := Value;
end;

procedure TFrmInvoice2015.GetReservationHeaderInformation;
var
  rSet: TRoomerDataset;
  s: string;
  sTmp: string;

  ss: string;

begin
  if SplitNumber = 2 then
    exit;

//  if NOT d.roomerMainDataSet.OfflineMode then
    rSet := CreateNewDataSet;
//  else
//    rSet := d.roomerMainDataSet.ActivateNewDataset(d.GetBackupReservations(Reservation));

  try
//    if NOT d.roomerMainDataSet.OfflineMode then
//    begin
      s := format(select_Invoice_GetReservationHeader, [Reservation]);
      hData.rSet_bySQL(rSet, s);
//    end;
    rSet.first;

    if not rSet.eof then
    begin
      FInvoice.Customer := rSet.FieldByName('Customer').asString;
      FInvoice.Name := rSet.FieldByName('Name').asString;
      FInvoice.Address1 := rSet.FieldByName('Address1').asString;
      FInvoice.Address2 := rSet.FieldByName('Address2').asString;
      FInvoice.Address3 := rSet.FieldByName('Address3').asString;
      FInvoice.Address4 := rSet.FieldByName('Address4').asString;
      FInvoice.Country := rSet.FieldByName('Country').asString;
      FInvoice.CustPId := rSet.FieldByName('custPID').asString;
      FInvoice.Dirty := True;
      // invRefrence := rSet.FieldByName('invRefrence').asString;
    end;
    DisplayCustomer;
  finally
    FreeAndNil(rSet);
  end;
end;

procedure TFrmInvoice2015.GetGuestInformation;
var
  Person: Integer;
  Name: string;
  Address1: string;
  Address2: string;
  Address3: string;
  Address4: string;
  Country: string;
  PID: string;

  rSet: TRoomerDataset;
  s: string;
  sql: string;

begin
  if RoomReservation <= 0 then
    exit;
  if SplitNumber = 2 then
    exit;

  rSet := CreateNewDataSet;
  try
    sql := ' SELECT ' + '     Person ' + '   , RoomReservation ' + '   , Reservation ' + '   , Name ' + '   , Address1 ' + '   , Address2 ' + '   , Address3 ' +
      '   , Address4 ' + '   , Country  ' + '   , PID ' + ' FROM ' + '   persons ' + '   WHERE ' + '      (Reservation = %d) AND (RoomReservation = %d) ';
    s := format(sql, [Reservation, RoomReservation]);
    hData.rSet_bySQL(rSet, s);

    rSet.first;
    if not rSet.eof then
    begin
      FInvoice.Name := rSet.FieldByName('Name').asString;
      FInvoice.Address1 := rSet.FieldByName('Address1').asString;
      FInvoice.Address2 := rSet.FieldByName('Address2').asString;
      FInvoice.Address3 := rSet.FieldByName('Address3').asString;
      FInvoice.Address4 := rSet.FieldByName('Address4').asString;
      FInvoice.Country := rSet.FieldByName('Country').asString;
      FInvoice.CustPId := rSet.FieldByName('PID').asString;
      FInvoice.Dirty := True;
      DisplayCustomer;
    end;
  finally
    FreeAndNil(rSet);
  end;
end;

procedure TFrmInvoice2015.GetCashInvoiceHeaderInformation;
begin
  FInvoice.Customer := ctrlGetString('RackCustomer');
  FInvoice.Name := 'Invoice';
  FInvoice.Address1 := '';
  FInvoice.Address2 := '';
  FInvoice.Address3 := '';
  FInvoice.Address4 := '';
  FInvoice.Country := ctrlGetString('Country');
  FInvoice.CustPId := '';
  FInvoice.Dirty := True;

  DisplayCustomer;
end;

procedure TFrmInvoice2015.GetInvoiceHeaderInformation;
var
  // InvoiceType: integer;
  // invRefrence: string;

  rSet: TRoomerDataset;
  s: string;

begin
  if (SplitNumber = 2) OR (Reservation = -1) then
    exit;

  rSet := CreateNewDataSet;
  try
    s := format(select_Invoice_GetInvoiceHeader, [Reservation, RoomReservation]);
    hData.rSet_bySQL(rSet, s);

    rSet.first;
    if rSet.RecordCount > 0 then
    begin
      FInvoice.Customer := rSet.FieldByName('Customer').asString;
      FInvoice.Name := rSet.FieldByName('Name').asString;
      FInvoice.Address1 := rSet.FieldByName('Address1').asString;
      FInvoice.Address2 := rSet.FieldByName('Address2').asString;
      FInvoice.Address3 := rSet.FieldByName('Address3').asString;
      FInvoice.Address4 := rSet.FieldByName('Address4').asString;
      FInvoice.Country := rSet.FieldByName('Country').asString;
      FInvoice.CustPId := rSet.FieldByName('custPID').asString;
      FInvoice.Dirty := True;
      // InvoiceType := rSet.FieldByName('InvoiceType').asinteger;
      // invRefrence := rSet.FieldByName('invRefrence').asString;
    end;

    DisplayCustomer;
  finally
    FreeAndNil(rSet);
  end;
end;

procedure TFrmInvoice2015.edtCurrencyPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  s: string;
  theData: recCurrencyHolder;
  oldCurrency: string;
begin
  s := '';
  oldCurrency := trim(edtCurrency.Text);
  theData.Currency := oldCurrency;
  Currencies(actLookup, theData);
  if theData.Currency <> '' then
  begin
    s := theData.Currency;
  end;

  if (s <> '') and (s <> oldCurrency) then
  begin
    FInvoice.ChangeCurrency(theData.Currency, theData.Value);
    DisplayInvoice;
    FInvoice.Dirty := True;
  end;
end;

procedure TFrmInvoice2015.edtCustomerPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  CustomerHolder: recCustomerHolder;
begin
  CustomerHolder.Customer := edtCustomer.Text;
  if openCustomers(actLookup, True, CustomerHolder) then
  begin
    edtCustomer.Text := CustomerHolder.Customer;
    SetCustomer(CustomerHolder.Customer);
  end;
end;

procedure TFrmInvoice2015.DisplayCustomer;
begin
  edtCustomer.Text := FInvoice.Customer;
  edtPersonalId.Text := FInvoice.CustPId;
  edtName.Text := FInvoice.Name;
  edtAddress1.Text := FInvoice.Address1;
  edtAddress2.Text := FInvoice.Address2;
  edtZip.Text := FInvoice.Address3;
  edtCity.Text := FInvoice.Address4;
  edtCountry.Text := FInvoice.Country;
end;

procedure TFrmInvoice2015.DisplayInvoice;
begin
  edtCustomer.Text := FInvoice.Customer;
  edtName.Text := FInvoice.Name;
  edtAddress1.Text := FInvoice.Address1;
  edtAddress2.Text := FInvoice.Address2;
  edtZip.Text := FInvoice.Address3;
  edtCity.Text := FInvoice.Address4;
  edtCountry.Text := FInvoice.Country;

  edtCurrency.Text := FInvoice.Currency;
  edtCurrencyRate.Text := FloatToXml(FInvoice.CurrencyRate, 5);

  DisplayLines;
  DisplayPayments;

  DisplayTotals;
end;

procedure TFrmInvoice2015.prepareInvoice;
var
  _type: TRoomerInvoiceType;
begin
  // itRoom, itGroup, itCash, itCredit
  if Credit then
    _type := ritCredit
  else if RoomReservation <= 0 then
    _type := ritGroup
  else if Cash then
    _type := ritCash
  else
    _type := ritRoom;
  FInvoice := TInvoice.Create(_type, -1, Reservation, RoomReservation, SplitNumber, InvoiceNumber, RoomNumber, FExpanded);
  DisplayInvoice;
end;

procedure TFrmInvoice2015.sButton1Click(Sender: TObject);
var
  Rec: recDownPayment;
  theData: recPaymentHolder;
  line: TPaymentLine;
  item: TListItem;
begin
  g.initRecDownPayment(Rec);

  Rec.reservation := Reservation;
  Rec.RoomReservation := RoomReservation;
  Rec.Invoice := InvoiceNumber;
  Rec.Amount := 0;
  Rec.InvoiceBalance := FInvoice.Balance;

  if g.OpenDownPayment(actInsert, Rec) then
  begin
    line := FInvoice.AddPayment(iptDownPayment, CreateAGUID,
                        1, // Payment type DownPayment
                        0,
                        Date,
                        Rec.PaymentType,
                        Rec.Amount,
                        Rec.Description,
                        Rec.Notes,
                        d.roomerMainDataSet.username,
                        Now,
                        FInvoice.Currency,
                        FInvoice.CurrencyRate,
                        0,
                        true
                        );

    if Assigned(line) then
    begin
      line.Amount := Rec.Amount / FInvoice.CurrencyRate;
      item := CreatePaymentItem;
      item.Data := line;
      DisplayPayment(item);
      DisplayTotals;
    end;

  end;
end;

function TFrmInvoice2015.CurrentlySelectedPayment : TPaymentLine;
begin
  result := nil;
  if lvPayments.Selected = nil then exit;
  result :=  TPaymentLine(lvPayments.Selected.Data);
end;

procedure TFrmInvoice2015.btnEditPaymentClick(Sender: TObject);
var
  Rec: recDownPayment;
  theData: recPaymentHolder;
  line: TPaymentLine;
  item: TListItem;

begin
  if CurrentlySelectedPayment = nil then exit;

  line := CurrentlySelectedPayment;

  g.initRecDownPayment(Rec);

  Rec.InvoiceBalance := FInvoice.Balance;

  Rec.reservation := Reservation;
  Rec.RoomReservation := RoomReservation;
  Rec.Amount := line.Amount*line.CurrencyRate;
  Rec.Description := line.Description;
  Rec.Notes := line.Notes;
  Rec.PaymentType := line.PayType;
  Rec.PayDate := line.PayDate;
//  Rec.payGroup := line.PayGroup;

  if Rec.confirmDate < 3 then
  begin
    if g.OpenDownPayment(actEdit, Rec) then
    begin
      Rec.Amount := Rec.Amount / FInvoice.CurrencyRate;
      line.PayType := Rec.PaymentType;
      line.Amount := Rec.Amount;
      line.Description := Rec.Description;
      line.Notes := Rec.Notes;
      line.FChanged := true;

      item := lvPayments.Selected;
      item.Data := line;
      DisplayPayment(item);
      DisplayTotals;
    end;

  end
  else
  begin
    showmessage('It is not allowed to change confirmed payments');
  end;
end;

procedure TFrmInvoice2015.btnInsertClick(Sender: TObject);
var
  line: TInvoiceLine;
  item: TListItem;
begin
  line := AddInvoiceItem(ltSale);
  if Assigned(line) then
  begin
    item := CreateLineItem;
    item.Data := line;
    line.Invoice := FInvoice;
    FInvoice.AddLine(line);
    DisplayLine(item);
    DisplayTotals;
  end;
end;

procedure TFrmInvoice2015.cbCustomerNameMethodCloseUp(Sender: TObject);
begin
  case cbCustomerNameMethod.ItemIndex of
    0:
      SetCustomer(FInvoice.Customer);
    1:
      GetReservationHeaderInformation;
    2:
      GetGuestInformation;
    3:
      GetInvoiceHeaderInformation;
    4:
      ;
    5:
      GetCashInvoiceHeaderInformation;
  end;
end;

procedure TFrmInvoice2015.btnDeleteClick(Sender: TObject);
var i : Integer;
begin
  for i:= lvLines.Items.Count-1 downto 0 do
    if lvLines.Items[i].Checked then
    begin
      FInvoice.DeleteItem(TInvoiceLine(lvLines.Items[i].Data));
      lvLines.Items.Delete(i);
    end;
end;

procedure TFrmInvoice2015.btnDeletePaymentClick(Sender: TObject);
var i : Integer;
begin
  for i:= lvPayments.Items.Count-1 downto 0 do
    if lvPayments.Items[i].Checked then
    begin
      FInvoice.DeletePayment(TPaymentLine(lvPayments.Items[i].Data));
      lvPayments.Items.Delete(i);
    end;
end;

procedure TFrmInvoice2015.btnEditClick(Sender: TObject);
begin
  if Assigned(lvLines.Selected) then
  begin
    EditInvoiceItem(TInvoiceLine(lvLines.Selected.Data));
    DisplayLine(lvLines.Selected);
    DisplayTotals;
  end;
end;

procedure TFrmInvoice2015.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
  Params.WndParent := Application.Handle;
end;

{ TOpenInvoices }

constructor TOpenInvoices.Create;
begin
  FOpenInvoices := TOpenInvoiceList.Create(True);
end;

destructor TOpenInvoices.Destroy;
begin
  CloseAllForms;
  FOpenInvoices.Clear;
  FOpenInvoices.Free;
end;

function TOpenInvoices.Add(OpenInvoice: TOpenInvoice): Integer;
begin
  result := FOpenInvoices.Add(OpenInvoice);
end;

procedure TOpenInvoices.CloseAllForms;
var
  i: integer;
begin
  for i := FOpenInvoices.Count-1 downto 0 do
    FOpenInvoices[i].Form.Close;
end;

function TOpenInvoices.FindForm(Reservation, RoomReservation, SplitNumber: Integer; Credit: boolean): TFrmInvoice2015;
var
  i: Integer;
begin
  result := nil;
  for i := 0 to FOpenInvoices.Count - 1 do
    if (FOpenInvoices[i].Reservation = Reservation) AND (FOpenInvoices[i].RoomReservation = RoomReservation) AND (FOpenInvoices[i].SplitNumber = SplitNumber) AND (FOpenInvoices[i].Credit = Credit)
    then
    begin
      result := FOpenInvoices[i].Form;
      Break;
    end;
end;

procedure TOpenInvoices.RemoveForm(Form: TFrmInvoice2015);
var
  i: Integer;
begin
  for i := 0 to FOpenInvoices.Count - 1 do
    if FOpenInvoices[i].Form = Form then
    begin
      FOpenInvoices.Delete(i);
      Break;
    end;
end;

{ TOpenInvoice }

constructor TOpenInvoice.Create(_Reservation, _RoomReservation, _SplitNumber: Integer; _Credit: boolean; _Form: TFrmInvoice2015);
begin
  Reservation := _Reservation;
  RoomReservation := _RoomReservation;
  SplitNumber := _SplitNumber;
  Credit := _Credit;
  Form := _Form;
end;

initialization

OpenInvoices := TOpenInvoices.Create;

finalization

OpenInvoices.Free;

end.
