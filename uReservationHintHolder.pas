unit uReservationHintHolder;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, sPanel, Vcl.StdCtrls, sButton, sLabel,
  uPopupListEx, uAppGlobal, hData, uG, _Glob, uUtils, AdvShape, PrjConst, sMemo, HTMLabel, Vcl.Menus;

type

  THintButtonClicked = (hbcLogin, hbcLogOut);
  TOnLogInOutHandlerClick = procedure(rri: RecRRInfo; ButtonClicked : THintButtonClicked) of object;
  TOnViewReservationHandlerClick = procedure(rri: RecRRInfo) of object;


  TFrmReservationHintHolder = class(TForm)
    pnlHint: TsPanel;

    __lbStatus: TsLabel;
    __lbName: TsLabel;
    __lbRoom: TsLabel;
    __lbGuests: TsLabel;
    __lbChannel: TsLabel;
    __lbRatePlan: TsLabel;
    __lbDeparture: TsLabel;
    __lbArrival: TsLabel;
    __lbNotes: TsMemo;
    __lblHide: TsLabel;
    __hlblTotal: THTMLabel;
    __hlblDaily: THTMLabel;

    clbStatus: TsLabel;
    clbName: TsLabel;
    clbRoom: TsLabel;
    clbGuests: TsLabel;
    clbChannel: TsLabel;
    clbRatePlan: TsLabel;
    clbDeparture: TsLabel;
    clbArrival: TsLabel;
    clbRate: TsLabel;
    clbNotes: TsLabel;
    clbTotal: TsLabel;
    clblDaily: TsLabel;

    btnCheckInOut: TsButton;
    btnReservationDetails: TsButton;
    timHide: TTimer;
    shpStatus: TShape;
    AdvShape1: TAdvShape;
    Shape1: TShape;
    sLabel1: TsLabel;
    __hlbBookingIds: THTMLabel;
    PopupMenu1: TPopupMenu;
    C1: TMenuItem;
    Shape2: TShape;
    __lbPAymentNotes: TsMemo;
    sLabel2: TsLabel;
    clbInvoiceStatus: TsLabel;
    HTMLabel1: THTMLabel;
    sLabel5: TsLabel;
    __hlblTotalInvoice: THTMLabel;
    clbRoomRentInvoice: TsLabel;
    hlbGuarantee: THTMLabel;
    sLabel3: TsLabel;
    Shape3: TShape;
    procedure timHideTimer(Sender: TObject);
    procedure btnCheckInOutClick(Sender: TObject);
    procedure btnReservationDetailsClick(Sender: TObject);
    procedure __lblHideClick(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure pnlHintMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure pnlHintMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure pnlHintMouseEnter(Sender: TObject);
  private
    currentControl : TObject;
    rri: RecRRInfo;
    FOnViewReservationClick: TOnViewReservationHandlerClick;
    FOnLogInOutClick: TOnLogInOutHandlerClick;
    procedure PlaceHint(X, Y, CellWidth, CellHeight: Integer);
    procedure ReadInfo(rri: RecRRInfo);
    procedure CM_MenuClosed(var msg: TMessage) ; message CM_MENU_CLOSED;
    procedure CM_EnterMenuLoop(var msg: TMessage) ; message CM_ENTER_MENU_LOOP;
    procedure CM_ExitMenuLoop(var msg: TMessage) ; message CM_EXIT_MENU_LOOP;
     { Private declarations }
  public
    { Public declarations }
    procedure InitEmbededHint(prnt : TWinControl);
    procedure Release;
    procedure CancelHint;

    procedure ActivateHint(X, Y, CellWidth, CellHeight : Integer; rri: RecRRInfo);

    procedure TranslateAll;

    property OnLogInOutClick : TOnLogInOutHandlerClick read FOnLogInOutClick write FOnLogInOutClick;
    property OnViewReservationClick : TOnViewReservationHandlerClick read FOnViewReservationClick write FOnViewReservationClick;

  end;

var
  FrmReservationHintHolder: TFrmReservationHintHolder;

implementation

{$R *.dfm}

uses clipbrd, uMain;

{ TFrmReservationHintHolder }

procedure TFrmReservationHintHolder.ActivateHint(X, Y, CellWidth, CellHeight: Integer; rri: RecRRInfo);
begin
  self.rri := rri;
  pnlHint.Left := X + CellWidth - 4;
//  pnlHint.Top := (Y + CellHeight div 2) - (pnlHint.Height div 2);
  pnlHint.Top := Y - (pnlHint.Height div 2);

  PlaceHint(X, Y, CellWidth, CellHeight);
  ReadInfo(rri);

  pnlHint.Show;
  timHide.Enabled := True;
end;

procedure GetPriceInfo(rri: RecRRInfo;
            var TotalPrice, TotalDiscount, TotalPriceNetto, PriceNight, DiscountNight, PriceNightNetto : Double;
            var CurrencyLetter : String);
var discountAmount : Double;
begin
  TotalPrice := 0.0;
  TotalDiscount := 0.0;
  TotalPriceNetto := 0.0;
  PriceNight := 0.0;
  DiscountNight := 0.0;
  PriceNightNetto := 0.0;
  CurrencyLetter := '€';
  if rri.Discount <> 0 then
  begin
    discountAmount := rri.Discount;
    if rri.Percentage then
    begin
      discountAmount := rri.Price / ((100-rri.Discount)/100); // ro.Price * ro.Discount / 100;
      PriceNight := discountAmount;
      DiscountNight := discountAmount - rri.Price;
    end
    else
    begin
      discountAmount := rri.Price + rri.Discount;
      PriceNight := rri.Price + rri.Discount;
      DiscountNight := rri.Discount;
    end;

    PriceNightNetto := rri.Price;
  end else
  begin
    PriceNightNetto := rri.Price;
    PriceNight := rri.Price;
  end;

  TotalPrice := PriceNight * (trunc(rri.Departure) - trunc(rri.Arrival));
  TotalPriceNetto := PriceNightNetto * (trunc(rri.Departure) - trunc(rri.Arrival));
  TotalDiscount := DiscountNight * (trunc(rri.Departure) - trunc(rri.Arrival));
  if Lowercase(rri.Currency) <> 'eur' then
    CurrencyLetter := rri.Currency;
end;

function GetChannelName(rriChannel : Integer) : String;
begin
    if glb.LocateChannelById(rriChannel) then
      result := glb.ChannelsSet['name']
    else
      result := 'Manually entered reservation';
end;

function GetBookingId(rri: RecRRInfo) : String;
begin
  result := rri.BookingId;
  if trim(result) = '' then
    result := GetTranslatedText('shUI_NotAvailable');
end;

function GetTrimmedPercentage(value : Double) : String;
begin
  result := trim(_floatToStr(value, 12, 2));
  if copy(result, length(result) - 2, 2) = '00' then
    result := trim(_floatToStr(value, 12, 0));
end;

procedure TFrmReservationHintHolder.ReadInfo(rri: RecRRInfo);
var TotalPrice, TotalDiscount, TotalPriceNetto, PriceNight, DiscountNight, PriceNightNetto : Double;
    CurrencyLetter : String;
    backColor, fontColor : TColor;
    sColor1, sColor2 : String;
    temp : String;
begin
  ResStatusToColor(rri.resFlag, backColor, fontColor);
  shpStatus.Brush.Color := BackColor;
  shpStatus.Pen.Color := BackColor;
  __lbStatus.Caption := Status2StatusTextForHints(rri.resFlag);
  __lbName.Caption := rri.GuestName;
  if copy(rri.Room, 1, 1) <> '<' then
    __lbRoom.Caption := format('%s / %s', [rri.Room, rri.RoomType])
  else
    __lbRoom.Caption := format('%s / %s', [GetTranslatedText('shUI_NotAvailable'), rri.RoomType]);
  __lbGuests.Caption := inttostr(rri.numGuests);
  __lbChannel.Caption := GetChannelName(rri.Channel);
  if rri.RoomClass = '' then
    __lbRatePlan.Caption := rri.PriceType
  else
    __lbRatePlan.Caption := rri.RoomClass;

  __lbArrival.Caption := Capitalize(FormatDateTime('ddd, mmm d yyyy', rri.Arrival));
  __lbDeparture.Caption := Capitalize(FormatDateTime('ddd, mmm d yyyy', rri.Departure));

  __hlbBookingIds.HTMLText.Text := format('Channel: <B>%s</B><br>Roomer: <B>%d</B> (Room: <B>%d</B>)<br>',
              [
                GetBookingId(rri),
                rri.Reservation,
                rri.RoomReservation
              ]);

  GetPriceInfo(rri, TotalPrice, TotalDiscount, TotalPriceNetto, PriceNight, DiscountNight, PriceNightNetto, CurrencyLetter);
  // <P align="right">€ 123.000,00<br><U>- (10) € 12.300,00</U><br><B>€ 11.000,00</B></P>
  if rri.Discount <> 0 then
  begin
      if rri.Percentage then
      begin
        __hlblTotal.HTMLText.Text := format('<P align="right">%s %s<br><U>(%s) %s -%s</U><br><B>%s %s</B><br></P>',
              [
                CurrencyLetter,
                trim(_floatToStr(TotalPrice, 12, 2)),

                GetTrimmedPercentage(rri.Discount) + '%',
                CurrencyLetter,
                trim(_floatToStr(TotalDiscount, 12, 2)),

                CurrencyLetter,
                trim(_floatToStr(TotalPriceNetto, 12, 2))
              ]);
        __hlblDaily.HTMLText.Text := format('<P align="right">%s %s<br><U>(%s) %s -%s</U><br><B>%s %s</B><br></P>',
              [
                CurrencyLetter,
                trim(_floatToStr(PriceNight, 12, 2)),

                GetTrimmedPercentage(rri.Discount) + '%',
                CurrencyLetter,
                trim(_floatToStr(DiscountNight, 12, 2)),

                CurrencyLetter,
                trim(_floatToStr(PriceNightNetto, 12, 2))
              ]);
      end else
      begin
        __hlblTotal.HTMLText.Text := format('<P align="right">%s %s<br><U>%s -%s</U><br><B>%s %s</B><br></P>',
              [
                CurrencyLetter,
                trim(_floatToStr(TotalPrice, 12, 2)),

                CurrencyLetter,
                trim(_floatToStr(TotalDiscount, 12, 2)),

                CurrencyLetter,
                trim(_floatToStr(TotalPriceNetto, 12, 2))
              ]);
        __hlblDaily.HTMLText.Text := format('<P align="right">%s %s<br><U>%s -%s</U><br><B>%s %s</B><br></P>',
              [
                CurrencyLetter,
                trim(_floatToStr(PriceNight, 12, 2)),

                CurrencyLetter,
                trim(_floatToStr(DiscountNight, 12, 2)),

                CurrencyLetter,
                trim(_floatToStr(PriceNightNetto, 12, 2))
              ]);
      end;
  end else
  begin
        __hlblTotal.HTMLText.Text := format('<P align="right"><B>%s %s</B><br></P>',
              [
                CurrencyLetter,
                trim(_floatToStr(TotalPriceNetto, 12, 2))
              ]);
        __hlblDaily.HTMLText.Text := format('<P align="right"><B>%s %s</B><br></P>',
              [
                CurrencyLetter,
                trim(_floatToStr(PriceNightNetto, 12, 2))
              ]);
  end;

  if Trim(rri.Invoices) <> '' then
    clbRoomRentInvoice.Caption := GetTranslatedText('shUI_RoomInvoices') + ' ' + inttostr(rri.PaymentInvoice)
  else
    clbRoomRentInvoice.Caption := '';
//  if rri.PaymentInvoice > 0 then
//    clbRoomRentInvoice.Caption := GetTranslatedText('shUI_RoomRentInvoice') + ' ' + inttostr(rri.PaymentInvoice)
//  else
//    clbRoomRentInvoice.Caption := '';

  if rri.OngoingSale + rri.OngoingRent > 0 then
  begin
    sColor1 := '<BLINK><FONT color="#FF0000">';
    sColor2 := '</FONT></BLINK>';
  end else
  begin
    sColor1 := '';
    sColor2 := '';
  end;
  __hlblTotalInvoice.HTMLText.Text := format('<P align="right">%s %s<br>%s %s<br>%s %s<br><U>%s %s</U><br><B>%s%s %s%s</B><br></P>',
              [
                g.qNativeCurrency,
                trim(_floatToStr(rri.OngoingSale, 12, 2)),

                g.qNativeCurrency,
                trim(_floatToStr(rri.OngoingTaxes, 12, 2)),

                g.qNativeCurrency,
                trim(_floatToStr(rri.OngoingRent, 12, 2)),

                g.qNativeCurrency,
                trim(_floatToStr(rri.Payments, 12, 2)),

                sColor1,
                g.qNativeCurrency,
                trim(_floatToStr(rri.OngoingSale + rri.OngoingTaxes + rri.OngoingRent - rri.Payments, 12, 2)),
                sColor2
              ]);

  if rri.Guarantee = 'CREDIT_CARD' then
  begin
    sColor1 := '<BLINK><FONT color="#0000FF">';
    sColor2 := '</FONT></BLINK>';
    temp := GetTranslatedText('shUI_CreditCardGuarantee');
  end else
  if rri.Guarantee = 'DOWN_PAYMENT' then
  begin
    sColor1 := '<BLINK><FONT color="#FF8000">';
    sColor2 := '</FONT></BLINK>';
    temp := GetTranslatedText('shUI_DownpaymentGuarantee');
  end else
  begin
    sColor1 := '<BLINK><FONT color="#FF0000">';
    sColor2 := '</FONT></BLINK>';
    temp := GetTranslatedText('shUI_NoGuarantee');
  end;

  hlbGuarantee.HtmlText.Text := format('<B>%s%s%s</B>', [sColor1, temp, sColor2]);

//  lbRate.Caption := 'Total ' + CurrencyLetter + ' ' + trim(_floatToStr(TotalPriceNetto, 12, 2)) + ' / ' +
//                    'Average ' + CurrencyLetter + ' ' + trim(_floatToStr(PriceNightNetto, 12, 2));

  __lbNotes.Text := rri.Information;
  __lbPAymentNotes.Text := rri.PMInfo;

  btnCheckInOut.Enabled := UpperCase(rri.resFlag)[1] IN ['P','G'];

  TranslateAll;
end;

procedure TFrmReservationHintHolder.TranslateAll;
begin
  btnCheckInOut.Caption := GetTranslatedText('shUI_Check_In');
  if UpperCase(rri.resFlag)[1] IN ['G'] then
    btnCheckInOut.Caption := GetTranslatedText('shUI_Check_Out');
//  btnReservationDetails.Caption := GetTranslatedText('shUI_Reservation_Details');

//  clbStatus.Caption := GetTranslatedText('shTx_Status');
//  clbName.Caption := GetTranslatedText('shTx_G_Guest');
//  clbGuests.Caption := GetTranslatedText('shTx_NumGuests');
//  clbRoom.Caption := GetTranslatedText('shRoom');
//  clbArrival.Caption := GetTranslatedText('shArrival');
//  clbDeparture.Caption := GetTranslatedText('shDeparture');
//  clbChannel.Caption := GetTranslatedText('shTx_ChannelAvailable');
//  clbRatePlan.Caption := GetTranslatedText('shUI_Rate_Plan');
//  clbRate.Caption := GetTranslatedText('shTx_ChannelAvailabilityManager_Rate');
//  clbNotes.Caption := GetTranslatedText('shUI_Notes');
end;

procedure TFrmReservationHintHolder.PlaceHint(X, Y, CellWidth, CellHeight: Integer);
var currMousePos : TPoint;
    routeCounter : Integer;
begin
  currMousePos := GetCursorPosForControl(pnlHint.Parent);
  if currMousePos.X < 0 then
    exit;
  routeCounter := 0;
  while pnlHint.Top + pnlHint.Height > pnlHint.Parent.Height - 30 do
  begin
    inc(routeCounter);
    if routeCounter > 2048 then
      Break;
     pnlHint.Top := pnlHint.Top - 1;
  end;

  routeCounter := 0;
  while pnlHint.Top < 0 do
  begin
    inc(routeCounter);
    if routeCounter > 2048 then
      Break;
     pnlHint.Top := pnlHint.Top + 10;
  end;

  routeCounter := 0;
  while pnlHint.Left + pnlHint.Width > pnlHint.Parent.Width - 10 do
  begin
    inc(routeCounter);
    if routeCounter > 2048 then
      Break;
     pnlHint.Left := X - pnlHint.Width;
  end;

  routeCounter := 0;
  while pnlHint.Left < 0 do
  begin
    inc(routeCounter);
    if routeCounter > 2048 then
      Break;
     pnlHint.Left := pnlHint.Left + 10;
  end;

  if ((currMousePos.X >= pnlHint.Left) AND (currMousePos.X <= pnlHint.Left + pnlHint.Width)) OR
     (ABS((currMousePos.X - pnlHint.Left)) > pnlHint.Width) then
  begin
    if currMousePos.X + pnlHint.Width + 30 > pnlHint.Parent.Width then
      pnlHint.Left := currMousePos.X - pnlHint.Width - 30
    else
      pnlHint.Left := currMousePos.X + 30
  end;


end;

procedure TFrmReservationHintHolder.pnlHintMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  currentControl := Sender;
  if Button = mbLeft then
    timHide.Enabled := False;
end;

procedure TFrmReservationHintHolder.pnlHintMouseEnter(Sender: TObject);
begin
  CancelHint;
end;

procedure TFrmReservationHintHolder.pnlHintMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    timHide.Enabled := True;
end;

procedure TFrmReservationHintHolder.PopupMenu1Popup(Sender: TObject);
begin
  timHide.Enabled := False;
end;

procedure TFrmReservationHintHolder.C1Click(Sender: TObject);
begin
  if currentControl = nil then exit;

  if currentControl IS THTMLabel then
    Clipboard.AsText:= THTMLabel(currentControl).Text
  else
  if currentControl IS TsLabel then
    Clipboard.AsText:= TsLabel(currentControl).Caption
  else
  if currentControl IS TsMemo then
    Clipboard.AsText:= TsMemo(currentControl).Text;

  if (currentControl IS THtmLabel) OR (currentControl IS TsMemo) OR (currentControl IS TsLabel) then
    MessageDlg(GetTranslatedText('shUI_ValueCopiedToClipboard'), mtConfirmation, [mbOk], 0);
end;

procedure TFrmReservationHintHolder.CancelHint;
begin
  if frmMain.HintWindowShowing then exit;
  pnlHint.Hide;
  timHide.Enabled := False;
  PopupMenu1.CloseMenu;
end;

procedure TFrmReservationHintHolder.CM_EnterMenuLoop(var msg: TMessage);
begin
  //
end;

procedure TFrmReservationHintHolder.CM_ExitMenuLoop(var msg: TMessage);
begin
  //
  timHide.Enabled := True;
end;

procedure TFrmReservationHintHolder.CM_MenuClosed(var msg: TMessage);
begin
  //
  timHide.Enabled := True;
end;

procedure TFrmReservationHintHolder.InitEmbededHint(prnt: TWinControl);
begin
  pnlHint.Hide;
  pnlHint.Parent := prnt;
end;


procedure TFrmReservationHintHolder.__lblHideClick(Sender: TObject);
begin
  CancelHint;
end;

procedure TFrmReservationHintHolder.Release;
begin
  pnlHint.Hide;
  pnlHint.Parent := self;
end;

procedure TFrmReservationHintHolder.btnReservationDetailsClick(Sender: TObject);
begin
  CancelHint;
  if Assigned(FOnLogInOutClick) then
    FOnViewReservationClick(rri);
end;

procedure TFrmReservationHintHolder.btnCheckInOutClick(Sender: TObject);
var Btn : THintButtonClicked;
begin
  CancelHint;
  if Assigned(FOnLogInOutClick) then
  begin
    if UpperCase(rri.resFlag)[1] IN ['P'] then
      btn := hbcLogin
    else
      btn := hbcLogout;
     FOnLogInOutClick(rri, btn);
  end;
end;

procedure TFrmReservationHintHolder.timHideTimer(Sender: TObject);
begin
  CancelHint;
end;

end.
