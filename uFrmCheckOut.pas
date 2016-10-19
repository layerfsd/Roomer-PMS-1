unit uFrmCheckOut;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sButton, Vcl.ExtCtrls, sPanel,
  uInvoiceContainer, cxClasses, cxPropertiesStore, sLabel, sCheckBox;

type
  TFrmCheckOut = class(TForm)
    StoreMain: TcxPropertiesStore;
    sLabel1: TsLabel;
    pnlRoomBalance: TsPanel;
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
    Shape1: TShape;
    Shape2: TShape;
    lbCurrency: TsLabel;
    btnRoomInvoice: TsButton;
    pnlGroupBalance: TsPanel;
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
    Shape3: TShape;
    Shape4: TShape;
    lbCurrencyGr: TsLabel;
    btnGroupInvoice: TsButton;
    cbxForce: TsCheckBox;
    panBtn: TsPanel;
    btnCancel: TsButton;
    BtnCheckOut: TsButton;
    procedure cbxForceClick(Sender: TObject);
    procedure btnRoomInvoiceClick(Sender: TObject);
    procedure btnGroupInvoiceClick(Sender: TObject);
    procedure BtnCheckOutClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
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

procedure CheckoutGuestWithDialog(Reservation, RoomReservation: Integer; RoomNumber: String);

implementation

{$R *.dfm}

uses
    _Glob
  , uD
  , PrjConst
  , uInvoice
  , uRoomerLanguage
  , uAppGlobal
  , uUtils
  , uCurrencyHandler
  , Math
  ;

procedure CheckoutGuestWithDialog(Reservation, RoomReservation: Integer; RoomNumber: String);
var
  _FrmCheckOut: TFrmCheckOut;
begin
  _FrmCheckOut := TFrmCheckOut.Create(nil);
  try
    _FrmCheckOut.Reservation := Reservation;
    _FrmCheckOut.RoomReservation := RoomReservation;
    _FrmCheckOut.RoomNumber := RoomNumber;

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
var
  lCurrencyHandler: TCurrencyHandler;
begin
  sLabel1.Visible := False;
  pnlRoomBalance.Visible := False;
  pnlGroupBalance.Visible := False;

  if FRoomInvoice.InvoiceLines.Count > 0 then with FRoomInvoice do
  begin
    lCurrencyHandler := TCurrencyHandler.Create(Currency);
    try
      pnlRoomBalance.Visible := not SameValue(lCurrencyHandler.RoundedValue(Balance), 0);
      if pnlRoomBalance.Visible then
      begin
        lbCurrency.Caption    := Currency;
        lbRoomRent.Caption    := lCurrencyHandler.FormattedValue(TotalRoomRent);
        lbSales.Caption       := lCurrencyHandler.FormattedValue(TotalSales);
        lbTaxes.Caption       := lCurrencyHandler.FormattedValue(TotalTaxes);
        lbSubTotal.Caption    := lCurrencyHandler.FormattedValue(lCurrencyHandler.RoundedValue(TotalRoomRent) +
                                                                 lCurrencyHandler.RoundedValue(TotalSales) +
                                                                 lCurrencyHandler.RoundedValue(TotalTaxes));
        lbPayments.Caption    := lCurrencyHandler.FormattedValue(TotalPayments);
        lbBalance.Caption     := lCurrencyHandler.FormattedValue(Balance);

        __lblGroupBalance.Caption := format(GetTranslatedText('shUI_Checkout_RoomHeader'), [RoomNumber]);
      end;
    finally
      lCurrencyHandler.Free;
    end;
  end;

  if FGroupInvoice.InvoiceLines.Count > 0 then with FGroupInvoice do
  begin
    lCurrencyHandler := TCurrencyHandler.Create(Currency);
    try
      pnlGroupBalance.Visible := not SameValue(lCurrencyHandler.RoundedValue(Balance), 0);
      if pnlGroupBalance.Visible then
      begin
        lbCurrencyGr.Caption  := Currency;
        lbRoomRentGr.Caption  := lCurrencyHandler.FormattedValue(TotalRoomRent);
        lbSalesGr.Caption     := lCurrencyHandler.FormattedValue(TotalSales);
        lbTaxesGr.Caption     := lCurrencyHandler.FormattedValue(TotalTaxes);
        lbSubTotalGr.Caption  := lCurrencyHandler.FormattedValue(lCurrencyHandler.RoundedValue(TotalRoomRent) +
                                                                 lCurrencyHandler.RoundedValue(TotalSales) +
                                                                 lCurrencyHandler.RoundedValue(TotalTaxes));
        lbPaymentsGr.Caption  := lCurrencyHandler.FormattedValue(TotalPayments);
        lbBalanceGr.Caption   := lCurrencyHandler.FormattedValue(Balance);

        __lblGroupBalance.Caption := format(GetTranslatedText('shUI_Checkout_GroupHeader'), [NumberOfRentLines]);
      end;
    finally
      lCurrencyHandler.Free;
    end;
  end;

  cbxForce.Visible := SameValue(FRoomInvoice.Balance, 0) AND not SameValue(FGroupInvoice.Balance, 0);
  BtnCheckOut.Enabled := ((NOT pnlRoomBalance.Visible) AND (NOT pnlGroupBalance.Visible));
  sLabel1.Visible := BtnCheckOut.Enabled;
  if sLabel1.Visible then
  begin
    sLabel1.Left := 5;
    sLabel1.Top := (Height - panBtn.Height) div 2;
    Width := sLabel1.Width + 20;
  end;
end;

procedure TFrmCheckOut.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
end;

procedure TFrmCheckOut.FormDestroy(Sender: TObject);
begin
  FRoomInvoice.Free;
  FGroupInvoice.Free;
end;

procedure TFrmCheckOut.FormShow(Sender: TObject);
begin
  prepareInvoice;
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
