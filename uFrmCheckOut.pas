unit uFrmCheckOut;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sButton, Vcl.ExtCtrls, sPanel,
  uInvoiceContainer, cxClasses, cxPropertiesStore, sLabel, sCheckBox;

type
  TFrmCheckOut = class(TForm)
    panBtn: TsPanel;
    btnCancel: TsButton;
    BtnCheckOut: TsButton;
    StoreMain: TcxPropertiesStore;
    pnlRoomBalance: TsPanel;
    pnlGroupBalance: TsPanel;
    __lblRoomBalance: TsLabel;
    sLabel33: TsLabel;
    lbRoomRent: TsLabel;
    lbSales: TsLabel;
    sLabel36: TsLabel;
    sLabel41: TsLabel;
    lbTaxes: TsLabel;
    sLabel38: TsLabel;
    sLabel40: TsLabel;
    lbPAyments: TsLabel;
    lbSubTotal: TsLabel;
    lbBalance: TsLabel;
    sLabel42: TsLabel;
    __lblGroupBalance: TsLabel;
    sLabel2: TsLabel;
    lbRoomRentGr: TsLabel;
    lbSalesGr: TsLabel;
    sLabel5: TsLabel;
    sLabel6: TsLabel;
    lbTaxesGr: TsLabel;
    sLabel8: TsLabel;
    sLabel9: TsLabel;
    lbPaymentsGr: TsLabel;
    lbSubTotalGr: TsLabel;
    lbBalanceGr: TsLabel;
    sLabel13: TsLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    btnRoomInvoice: TsButton;
    btnGroupInvoice: TsButton;
    cbxForce: TsCheckBox;
    sLabel1: TsLabel;
    lbCurrency: TsLabel;
    lbCurrencyGr: TsLabel;
    procedure cbxForceClick(Sender: TObject);
    procedure btnRoomInvoiceClick(Sender: TObject);
    procedure btnGroupInvoiceClick(Sender: TObject);
    procedure BtnCheckOutClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FReservation: Integer;
    FRoomReservation: Integer;
    FRoomNumber: String;
    FRoomInvoice: TInvoice;
    FGroupInvoice: TInvoice;
    procedure prepareInvoice;
    procedure DisplayInvoice;
    procedure ReloadInvoiceStatuses;
    { Private declarations }
  public
    { Public declarations }
    property Reservation: Integer read FReservation write FReservation;
    property RoomReservation: Integer read FRoomReservation write FRoomReservation;
    property RoomNumber: String read FRoomNumber write FRoomNumber;

    property RoomInvoice: TInvoice read FRoomInvoice write FRoomInvoice;
    property GroupInvoice: TInvoice read FGroupInvoice write FGroupInvoice;
  end;

var
  FrmCheckOut: TFrmCheckOut;

procedure CheckoutGuest(Reservation, RoomReservation: Integer; RoomNumber: String);

implementation

{$R *.dfm}

uses _Glob, uD, PrjConst, uInvoice, uRoomerLanguage, uAppGlobal, uUtils;

procedure CheckoutGuest(Reservation, RoomReservation: Integer; RoomNumber: String);
var
  _FrmCheckOut: TFrmCheckOut;
begin
  _FrmCheckOut := TFrmCheckOut.Create(nil);
  try
    _FrmCheckOut.Reservation := Reservation;
    _FrmCheckOut.RoomReservation := RoomReservation;
    _FrmCheckOut.RoomNumber := RoomNumber;

    _FrmCheckOut.prepareInvoice;

    _FrmCheckOut.ShowModal;
    _FrmCheckOut.BringToFront;
  finally
    FreeandNil(_FrmCheckOut);
  end;

end;

procedure TFrmCheckOut.cbxForceClick(Sender: TObject);
begin
  BtnCheckOut.Enabled := ((NOT pnlRoomBalance.Visible) AND (cbxForce.Checked));
end;

procedure TFrmCheckOut.DisplayInvoice;
begin
  sLabel1.Visible := False;
  with FRoomInvoice do begin
    lbCurrency.Caption    := Currency;
    lbRoomRent.Caption    := Trim(_floatToStr(TotalRoomRent, 12, 2));
    lbSales.Caption       := Trim(_floatToStr(TotalSales, 12, 2));
    lbTaxes.Caption       := Trim(_floatToStr(TotalTaxes, 12, 2));
    lbSubTotal.Caption    := Trim(_floatToStr(TotalRoomRent+TotalSales+TotalTaxes, 12, 2));
    lbPayments.Caption    := Trim(_floatToStr(TotalPayments, 12, 2));
    lbBalance.Caption     := Trim(_floatToStr(Balance, 12, 2));
    pnlRoomBalance.Visible := Round(Balance) <> 0;

    __lblGroupBalance.Caption := format(GetTranslatedText('shUI_Checkout_RoomHeader'), [RoomNumber]);
  end;

  with FGroupInvoice do begin
    lbCurrencyGr.Caption  := Currency;
    lbRoomRentGr.Caption  := Trim(_floatToStr(TotalRoomRent, 12, 2));
    lbSalesGr.Caption     := Trim(_floatToStr(TotalSales, 12, 2));
    lbTaxesGr.Caption     := Trim(_floatToStr(TotalTaxes, 12, 2));
    lbSubTotalGr.Caption  := Trim(_floatToStr(TotalRoomRent+TotalSales+TotalTaxes, 12, 2));
    lbPaymentsGr.Caption  := Trim(_floatToStr(TotalPayments, 12, 2));
    lbBalanceGr.Caption   := Trim(_floatToStr(Balance, 12, 2));
    pnlGroupBalance.Visible := Round(Balance) <> 0;

    __lblGroupBalance.Caption := format(GetTranslatedText('shUI_Checkout_GroupHeader'), [NumberOfRentLines]);
  end;

  cbxForce.Visible := (Round(FRoomInvoice.Balance) = 0) AND (Round(FGroupInvoice.Balance) <> 0);
  BtnCheckOut.Enabled := ((NOT pnlRoomBalance.Visible) AND (NOT pnlGroupBalance.Visible));
  sLabel1.Visible := BtnCheckOut.Enabled;
end;

procedure TFrmCheckOut.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
end;

procedure TFrmCheckOut.prepareInvoice;
begin
  Screen.Cursor := crHourglass;
  try
    FRoomInvoice := TInvoice.Create(ritRoom, -1, Reservation, RoomReservation, 0, -1, RoomNumber, False);
    FGroupInvoice := TInvoice.Create(ritGroup, -1, Reservation, RoomReservation, 0, -1, RoomNumber, False);
    DisplayInvoice;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmCheckOut.ReloadInvoiceStatuses;
begin
  FRoomInvoice.Free;
  FGroupInvoice.Free;
  prepareInvoice;
end;


procedure TFrmCheckOut.BtnCheckOutClick(Sender: TObject);
begin
  d.CheckOutGuest(RoomReservation, RoomNumber);
end;

procedure TFrmCheckOut.btnGroupInvoiceClick(Sender: TObject);
begin
  EditInvoice(Reservation, 0, 0, 0, 0, 0, false, true, false);
  ReloadInvoiceStatuses;
end;

procedure TFrmCheckOut.btnRoomInvoiceClick(Sender: TObject);
begin
  EditInvoice(Reservation, RoomReservation, 0, 0, 0, 0, false, true, false);
  ReloadInvoiceStatuses;
end;

end.
