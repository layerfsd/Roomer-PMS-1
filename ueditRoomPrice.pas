unit ueditRoomPrice;

interface

uses
    Winapi.Windows
  , Winapi.Messages
  , System.SysUtils
  , System.Variants
  , System.Classes
  , Vcl.Graphics
  , Vcl.Controls
  , Vcl.Forms
  , Vcl.Dialogs
  , Vcl.ExtCtrls
  , Vcl.StdCtrls
  , Vcl.Menus

  , Data.DB
  , Data.Win.ADODB

  ,_Glob
  ,hData
  ,ug

  , kbmMemTable

  , cxGraphics
  , cxControls
  , cxLookAndFeels
  , cxLookAndFeelPainters
  , cxStyles
  , cxCustomData
  , cxFilter
  , cxData
  , cxDataStorage
  , cxEdit
  , cxNavigator
  , cxDBData
  , cxGridCustomTableView
  , cxGridTableView
  , cxGridDBTableView
  , cxGridLevel
  , cxClasses
  , cxGridCustomView
  , cxGrid
  , cxButtonEdit
  , cxContainer
  , cxDropDownEdit
  , cxCalc
  , cxButtons
  , cxSpinEdit
  , cxTextEdit
  , cxMaskEdit, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, sButton, sEdit, sSpinEdit, sComboBox, sLabel, sGroupBox, sPanel, Vcl.Mask, sMaskEdit, sCustomComboEdit, sCurrEdit,
  Vcl.Buttons, sSpeedButton, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinDarkRoom,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, dxmdaset

  ;

type
  recEditRoomPriceHolder = record
    isCreateRes   : boolean;
    Room          : string;
    RoomType      : string;
    currency      : string;
    currencyRate  : double;
    guests        : integer;
    childrenCount : integer;
    infantCount   : integer;
    sTmp : string;
  end;


type
  TfrmEditRoomPrice = class(TForm)
    Panel1: TsPanel;
    _kbmRoomRates: TkbmMemTable;
    kbmRoomRatesDS: TDataSource;
    tvRoomRates: TcxGridDBTableView;
    lvRoomRates: TcxGridLevel;
    grRoomRates: TcxGrid;
    tvRoomRatesReservation: TcxGridDBColumn;
    tvRoomRatesRoomReservation: TcxGridDBColumn;
    tvRoomRatesRoomNumber: TcxGridDBColumn;
    tvRoomRatesRateDate: TcxGridDBColumn;
    tvRoomRatesPriceCode: TcxGridDBColumn;
    tvRoomRatesRate: TcxGridDBColumn;
    tvRoomRatesDiscount: TcxGridDBColumn;
    tvRoomRatesisPercentage: TcxGridDBColumn;
    tvRoomRatesShowDiscount: TcxGridDBColumn;
    tvRoomRatesisPaid: TcxGridDBColumn;
    tvRoomRatesDiscountAmount: TcxGridDBColumn;
    tvRoomRatesRentAmount: TcxGridDBColumn;
    tvRoomRatesNativeAmount: TcxGridDBColumn;
    Panel2: TsPanel;
    btnCancel: TsButton;
    btnOK: TsButton;
    gbxForAllDates: TsGroupBox;
    clabSelectRateRule: TsLabel;
    cxComboBox1: TsComboBox;
    clabRate: TsLabel;
    clabPriceCode: TsLabel;
    clabDiscount: TsLabel;
    edPcCode: TsEdit;
    edRoomResDiscount: TsSpinEdit;
    cbxIsRoomResDiscountPrec: TsComboBox;
    ApplyDiscount: TsButton;
    edRate: TsCalcEdit;
    btnApplyRate: TsButton;
    btnApplyPriceCode: TsButton;
    btnApplyRule: TsButton;
    sGroupBox1: TsGroupBox;
    clabRoom: TsLabel;
    clabRomType: TsLabel;
    cLabCurrency: TsLabel;
    cLabAuduts: TsLabel;
    cLabChildren: TsLabel;
    cLabInfants: TsLabel;
    labRoom: TsLabel;
    labRoomType: TsLabel;
    labCurrency: TsLabel;
    labAudults: TsLabel;
    labChildren: TsLabel;
    labInfants: TsLabel;
    sButton1: TsButton;
    sButton2: TsButton;
    sSpeedButton2: TsSpeedButton;
    mRoomRates: TdxMemData;
    mRoomRatesReservation: TIntegerField;
    mRoomRatesroomreservation: TIntegerField;
    mRoomRatesRoomNumber: TStringField;
    mRoomRatesRateDate: TDateTimeField;
    mRoomRatesPriceCode: TStringField;
    mRoomRatesRate: TFloatField;
    mRoomRatesDiscount: TFloatField;
    mRoomRatesisPercentage: TBooleanField;
    mRoomRatesShowDiscount: TBooleanField;
    mRoomRatesisPaid: TBooleanField;
    mRoomRatesDiscountAmount: TFloatField;
    mRoomRatesRentAmount: TFloatField;
    mRoomRatesNativeAmount: TFloatField;
    labRecs: TsLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edPcCodePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure btnApplyRateClick(Sender: TObject);
    procedure ApplyDiscountClick(Sender: TObject);
    procedure _kbmRoomRatesBeforePost(DataSet: TDataSet);
    procedure btnApplyPriceCodeClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure edPcCodeDblClick(Sender: TObject);
    procedure mRoomRatesBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    function getPriceFromPriceCode(priceCode : string; aDate : Tdate) : double;
  public
    { Public declarations }
    zData : recEditRoomPriceHolder;
    zAct  : TActTableAction;
    ApplyType : integer;
  end;

function editRoomPrice(act : TActTableAction; var theData : recEditRoomPriceHolder; var m_ : TdxMemData; var applyType  : integer) : boolean;
procedure initEditRoomPriceHolder(var theData : recEditRoomPriceHolder );

var
  frmEditRoomPrice: TfrmEditRoomPrice;

implementation

uses
    ud
  , uPriceOBJ
  , uPriceCodes
  , uAppGlobal
  , uMain, uDImages
  , uUtils;


{$R *.dfm}

procedure initEditRoomPriceHolder(var theData : recEditRoomPriceHolder);
begin
  with theData do
  begin
    isCreateRes    := true ;
    Room           := ''   ;
    RoomType       := ''   ;
    currency       := ''   ;
    currencyRate   := 1    ;
    guests         := 0;
    childrenCount  := 0    ;
    infantCount    := 0    ;
    sTmp           := ''   ;
  end;
end;

function editRoomPrice(act : TActTableAction; var theData : recEditRoomPriceHolder;var m_ : TdxMemData; var applyType : integer) : boolean;
var
  aRate : double;
begin
  result := false;
  frmEditRoomPrice := TfrmEditRoomPrice.Create(frmEditRoomPrice);
  try
    frmEditRoomPrice.zData := theData;
    frmEditRoomPrice.zAct := act;
    frmEditRoomPrice.mRoomRates.open;
    frmEditRoomPrice.mRoomRates.LoadFromDataSet(m_);
    frmEditRoomPrice.ShowModal;
    if frmEditRoomPrice.modalresult = mrOk then
    begin
      applyType := frmEditRoomPrice.ApplyType;
      theData := frmEditRoomPrice.zData;

     // showmessage(floattostr(frmEditRoomPrice.mRoomRates['Rate']));

      if m_.Active then m_.Close;
      m_.Open;
      m_.LoadFromDataSet(frmEditRoomPrice.mRoomRates);
//      aRate := m_.FieldByName('Rate').AsFloat;
      result := true;
    end
    else
    begin
      initEditRoomPriceHolder(theData);
    end;
  finally
    freeandnil(frmEditRoomPrice);
  end;
end;

procedure TfrmEditRoomPrice.ApplyDiscountClick(Sender: TObject);
var
  Rate             : Double   ;
  Discount         : double   ;
  isPercentage     : boolean  ;
  DiscountAmount   : double   ;
  RentAmount       : double   ;
  NativeAmount     : double   ;

  oldRate : double;
begin

  mRoomRates.First;
  while not mRoomRates.eof do
  begin
    Discount      := edRoomResDiscount.Value;
    isPercentage  := cbxIsRoomResDiscountPrec.ItemIndex = 0;
    Rate          := mRoomRates.FieldByName('Rate').AsFloat;

    DiscountAmount := 0;
    RentAmount     := 0;
    NativeAmount   := 0;

    if rate <> 0 then
    begin
      if discount <> 0 then
      begin
        if isPercentage then
        begin
          DiscountAmount :=  Rate*discount/100;
        end else
        begin
          DiscountAmount := discount;
        end;
      end;
      RentAmount  := Rate-DiscountAmount;

      if zData.currencyRate = 0 then zData.currencyRate := 1;
      NativeAmount := RentAmount*zData.CurrencyRate;

      mRoomRates.Edit;
      mRoomRates.FieldByName('Rate').AsFloat           := Rate;
      mRoomRates.FieldByName('Discount').AsFloat       := Discount;
      mRoomRates.FieldByName('isPercentage').AsBoolean := isPercentage;
      mRoomRates.FieldByName('DiscountAmount').AsFloat := DiscountAmount;
      mRoomRates.FieldByName('RentAmount').AsFloat     := RentAmount;
      mRoomRates.FieldByName('NativeAmount').AsFloat   := NativeAmount;
      mRoomRates.post;
    end;

    mRoomRates.Next;
  end;
end;




function TfrmEditRoomPrice.getPriceFromPriceCode(priceCode : string; aDate : Tdate) : double;
var
  Prices : TPrices;
  RoomType : string;
  DateFrom : TDate;
  DateTo : TDate;
  NumGuests : Integer;
  Currency : string;
  childrenCount : integer;
  infantCount   : integer;

  calcPrice : double;
  sTmp      : string;
  p        : Integer;
  tmp      : double;

begin
  result := 0;
  RoomType  := zData.RoomType;
  DateFrom  := aDate;
  DateTo    := aDate+1;
  Currency  := zData.currency;
  NumGuests := zData.guests;
  childrenCount := zData.ChildrenCount;
  infantCount := zData.infantCount;

  if PriceCode = '' then
  begin
    exit;
  end;

  if Currency = '' then
  begin
    exit;
  end;


  Prices := GetPrices(PriceCode, RoomType, DateFrom, DateTo, NumGuests, Currency);

  if Prices.PricesCount > 0 then
  begin
    result := Prices.Prices[0].Price;
//    calcPrice := _priceRound(calcPrice, 50, 3);
  end

end;


procedure TfrmEditRoomPrice.mRoomRatesBeforePost(DataSet: TDataSet);
var
  Rate             : Double   ;
  Discount         : double   ;
  isPercentage     : boolean  ;
  DiscountAmount   : double   ;
  RentAmount       : double   ;
  NativeAmount     : double   ;
begin
  Discount      := dataset.FieldByName('Discount').AsFloat;
  isPercentage  := dataset.FieldByName('isPercentage').AsBoolean;
  Rate          := dataset.FieldByName('Rate').AsFloat;

  DiscountAmount := 0;
  RentAmount     := 0;
  NativeAmount   := 0;

  if rate <> 0 then
  begin
    if discount <> 0 then
    begin
      if isPercentage then
      begin
        DiscountAmount :=  Rate*discount/100;
      end else
      begin
        DiscountAmount := discount;
      end;
    end;
    RentAmount  := Rate-DiscountAmount;

    if zData.currencyRate = 0 then zData.currencyRate := 1;
    NativeAmount := RentAmount*zData.CurrencyRate;
  end;

  DataSet.FieldByName('DiscountAmount').AsFloat := DiscountAmount;
  DataSet.FieldByName('RentAmount').AsFloat     := RentAmount;
  DataSet.FieldByName('NativeAmount').AsFloat   := NativeAmount;

end;

procedure TfrmEditRoomPrice.btnApplyPriceCodeClick(Sender: TObject);
var
  Rate             : Double   ;
  Discount         : double   ;
  isPercentage     : boolean  ;
  DiscountAmount   : double   ;
  RentAmount       : double   ;
  NativeAmount     : double   ;
  PriceCode        : string   ;
  aDate            : Tdate    ;
  oldRate          : double   ;
  priceID          : integer  ;
begin
  priceCode := edPcCode.Text;
  priceID   := PriceCode_ID(priceCode);

  mRoomRates.First;
  while not mRoomRates.eof do
  begin
    oldRate       := mRoomRates.FieldByName('Rate').AsFloat;
    if rate <> oldRate then
    begin
      adate         := mRoomRates.FieldByName('RateDate').AsDateTime;
      rate          := //getPriceFromPriceCode(priceCode,aDate);

      hdata.GetDayRate(zData.RoomType,
                       zData.Room,
                       aDate,
                       zData.Guests,
                       zData.childrenCount,
                       zData.infantCount,
                       zData.currency,
                       PriceID,
                       0,
                       false,
                       true,
                       false,
                       false);

      Discount      := mRoomRates.FieldByName('Discount').AsFloat;
      isPercentage  := mRoomRates.FieldByName('isPercentage').AsBoolean;

      DiscountAmount := 0;
      RentAmount     := 0;
      NativeAmount   := 0;

      if rate <> 0 then
      begin
        if discount <> 0 then
        begin
          if isPercentage then
          begin
            DiscountAmount :=  Rate*discount/100;
          end else
          begin
            DiscountAmount := discount;
          end;
        end;
      end;
      RentAmount  := Rate-DiscountAmount;
      if zData.currencyRate = 0 then zData.currencyRate := 1;
      NativeAmount := RentAmount*zData.CurrencyRate;

      mRoomRates.Edit;
      mRoomRates.FieldByName('priceCode').AsString     := PriceCode;
      mRoomRates.FieldByName('Rate').AsFloat           := Rate;
      mRoomRates.FieldByName('Discount').AsFloat       := Discount;
      mRoomRates.FieldByName('isPercentage').AsBoolean := isPercentage;
      mRoomRates.FieldByName('DiscountAmount').AsFloat := DiscountAmount;
      mRoomRates.FieldByName('RentAmount').AsFloat     := RentAmount;
      mRoomRates.FieldByName('NativeAmount').AsFloat   := NativeAmount;
      mRoomRates.post;
    end;
    mRoomRates.Next;
  end;
end;

procedure TfrmEditRoomPrice.btnApplyRateClick(Sender: TObject);
var
  Rate             : Double   ;
  Discount         : double   ;
  isPercentage     : boolean  ;
  DiscountAmount   : double   ;
  RentAmount       : double   ;
  NativeAmount     : double   ;

  oldRate : double;
begin
  rate := edRate.Value;

  mRoomRates.First;
  while not mRoomRates.eof do
  begin
    oldRate       := mRoomRates.FieldByName('Rate').AsFloat;
    if rate <> oldRate then
    begin
      Discount      := mRoomRates.FieldByName('Discount').AsFloat;
      isPercentage  := mRoomRates.FieldByName('isPercentage').AsBoolean;
      DiscountAmount := 0;
      RentAmount := 0;
      NativeAmount := 0;

      if rate <> 0 then
      begin
        if discount <> 0 then
        begin
          if isPercentage then
          begin
            DiscountAmount :=  Rate*discount/100;
          end else
          begin
            DiscountAmount := discount;
          end;
        end;
      end;
      RentAmount  := Rate-DiscountAmount;
      if zData.currencyRate = 0 then zData.currencyRate := 1;
      NativeAmount := RentAmount*zData.CurrencyRate;

      mRoomRates.Edit;
      mRoomRates.FieldByName('Rate').AsFloat           := Rate;
      mRoomRates.FieldByName('Discount').AsFloat       := Discount;
      mRoomRates.FieldByName('isPercentage').AsBoolean := isPercentage;
      mRoomRates.FieldByName('DiscountAmount').AsFloat := DiscountAmount;
      mRoomRates.FieldByName('RentAmount').AsFloat     := RentAmount;
      mRoomRates.FieldByName('NativeAmount').AsFloat   := NativeAmount;
      mRoomRates.post;
    end;
    mRoomRates.Next;
  end;
end;

procedure TfrmEditRoomPrice.btnOKClick(Sender: TObject);
begin
  ApplyType := 1;
end;

procedure TfrmEditRoomPrice.edPcCodeDblClick(Sender: TObject);
var
  theData : recPriceCodeHolder;
begin
  if priceCodes(actLookup,theData) then
  begin
    edPcCode.text := theData.pcCode;
  end;
end;

procedure TfrmEditRoomPrice.edPcCodePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recPriceCodeHolder;
begin
  if priceCodes(actLookup,theData) then
  begin
    edPcCode.text := theData.pcCode;
  end;
end;

procedure TfrmEditRoomPrice.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  //**
  applyType := 0;
end;

procedure TfrmEditRoomPrice.FormDestroy(Sender: TObject);
begin
  //**
end;

procedure TfrmEditRoomPrice.FormShow(Sender: TObject);
var
  recCount : integer;
begin

  labCurrency.caption  := zData.currency+' - rate '+floattostr(zData.currencyRate);
  labRoom.Caption      := zData.room;
  labRoomType.Caption  := zData.roomType;
  labAudults.Caption   := inttostr(zData.guests);
  labChildren.Caption  := inttostr(zData.childrenCount);
  labInfants.Caption   := inttostr(zData.infantCount);

  recCount := mRoomRates.RecordCount;
  labRecs.caption := inttostr(recCount);

  cbxIsRoomResDiscountPrec.Items.Add(zData.currency);
  cbxIsRoomResDiscountPrec.ItemIndex := 0;
  mRoomRates.First;
  if not mRoomRates.eof then
  begin
    edPcCode.text := mRoomRates.FieldByName('PriceCode').AsString;
    if mRoomRates.FieldByName('isPercentage').AsBoolean = false then cbxIsRoomResDiscountPrec.ItemIndex := 1; //
  end;
end;




procedure TfrmEditRoomPrice._kbmRoomRatesBeforePost(DataSet: TDataSet);
var
  Rate             : Double   ;
  Discount         : double   ;
  isPercentage     : boolean  ;
  DiscountAmount   : double   ;
  RentAmount       : double   ;
  NativeAmount     : double   ;
begin
  Discount      := dataset.FieldByName('Discount').AsFloat;
  isPercentage  := dataset.FieldByName('isPercentage').AsBoolean;
  Rate          := dataset.FieldByName('Rate').AsFloat;

  DiscountAmount := 0;
  RentAmount     := 0;
  NativeAmount   := 0;

  if rate <> 0 then
  begin
    if discount <> 0 then
    begin
      if isPercentage then
      begin
        DiscountAmount :=  Rate*discount/100;
      end else
      begin
        DiscountAmount := discount;
      end;
    end;
    RentAmount  := Rate-DiscountAmount;

    if zData.currencyRate = 0 then zData.currencyRate := 1;
    NativeAmount := RentAmount*zData.CurrencyRate;
  end;

  DataSet.FieldByName('DiscountAmount').AsFloat := DiscountAmount;
  DataSet.FieldByName('RentAmount').AsFloat     := RentAmount;
  DataSet.FieldByName('NativeAmount').AsFloat   := NativeAmount;

end;

procedure TfrmEditRoomPrice.sButton1Click(Sender: TObject);
begin
  ApplyType := 2;
end;

procedure TfrmEditRoomPrice.sButton2Click(Sender: TObject);
begin
  ApplyType := 3;
end;

end.
