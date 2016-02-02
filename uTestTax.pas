unit uTestTax;

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
  , Vcl.ComCtrls
  , Vcl.ExtCtrls
  , Vcl.StdCtrls

  , hdata

  , cmpRoomerDataSet
  , cmpRoomerConnection

  , sStatusBar
  , sPanel
  , sButton
  , sMemo
  , sLabel
  , sEdit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, dxSkinscxPCPainter, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, dxmdaset;

type
  TfrmTestTax = class(TForm)
    sPanel1: TsPanel;
    sStatusBar1: TsStatusBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    sMemo1: TsMemo;
    sPanel2: TsPanel;
    sButton1: TsButton;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sLabel4: TsLabel;
    sLabel5: TsLabel;
    labReservation: TsLabel;
    labRoomreservation: TsLabel;
    Taxes_: TdxMemData;
    Taxes_Reservation: TIntegerField;
    Taxes_RoomReservation: TIntegerField;
    Taxes_theDate: TDateField;
    Taxes_Item: TStringField;
    sPanel3: TsPanel;
    sButton2: TsButton;
    tvTaxes: TcxGridDBTableView;
    lvTaxes: TcxGridLevel;
    grTaxes: TcxGrid;
    TaxesDS: TDataSource;
    tvTaxesRecId: TcxGridDBColumn;
    tvTaxesReservation: TcxGridDBColumn;
    tvTaxesRoomReservation: TcxGridDBColumn;
    tvTaxestheDate: TcxGridDBColumn;
    tvTaxesItem: TcxGridDBColumn;
    Taxes_RoomWithVAT: TFloatField;
    Taxes_VAT: TFloatField;
    Taxes_RoomWithoutVAT: TFloatField;
    Taxes_Tax: TFloatField;
    tvTaxesRoomWithVAT: TcxGridDBColumn;
    tvTaxesRoomWithoutVAT: TcxGridDBColumn;
    tvTaxesVAT: TcxGridDBColumn;
    tvTaxesTax: TcxGridDBColumn;
    Taxes_Room: TStringField;
    Taxes_RoomType: TStringField;
    Taxes_resFlag: TStringField;
    Taxes_RoomRate: TFloatField;
    Taxes_Currency: TStringField;
    Taxes_paid: TBooleanField;
    Taxes_invoicenumber: TIntegerField;
    Taxes_discount: TFloatField;
    Taxes_isPercentage: TBooleanField;
    Taxes_RateWithDiscount: TFloatField;
    tvTaxesRoom: TcxGridDBColumn;
    tvTaxesRoomType: TcxGridDBColumn;
    tvTaxesresFlag: TcxGridDBColumn;
    tvTaxesRoomRate: TcxGridDBColumn;
    tvTaxesdiscount: TcxGridDBColumn;
    tvTaxesisPercentage: TcxGridDBColumn;
    tvTaxesRateWithDiscount: TcxGridDBColumn;
    tvTaxesCurrency: TcxGridDBColumn;
    tvTaxespaid: TcxGridDBColumn;
    tvTaxesinvoicenumber: TcxGridDBColumn;
    Taxes_confirmdate: TDateTimeField;
    Taxes_GuestCount: TIntegerField;
    tvTaxesconfirmdate: TcxGridDBColumn;
    tvTaxesGuestCount: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
  private
    { Private declarations }
    zReservation : integer;
    zRoomReservation : integer;

    zTaxesHolder : recTaxesHolder;
    zUseStayTax : boolean;

    procedure GetTaxesHolderValues(dtDate : TdateTime);
  public
    { Public declarations }
  end;

function testTax(reservation, roomreservation : integer) : boolean;

var
  frmTestTax: TfrmTestTax;

implementation

{$R *.dfm}

uses uD;


function testTax(reservation, roomreservation : integer) : boolean;
begin
  result := false;
  frmTestTax := TfrmTestTax.Create(frmTestTax);
  try
    frmTestTax.zReservation := reservation;
    frmTestTax.zRoomReservation := roomReservation;
    frmTestTax.ShowModal;
    if frmTestTax.modalresult = mrOk then
    begin
      result := true;
    end
  finally
    freeandnil(frmTestTax);
  end;
end;

procedure TfrmTestTax.GetTaxesHolderValues(dtDate : TdateTime);
var
  s : string;
  rSet : TRoomerDataset;
begin
  s := '';

  s := s+' SELECT '#10;
  s := s+'   ID '#10;
  s := s+'  ,Hotel_Id '#10;
  s := s+'  ,Description '#10;
  s := s+'  ,Tax_Type '#10;
  s := s+'  ,Tax_Base '#10;
  s := s+'  ,Time_Due '#10;
  s := s+'  ,Retaxable '#10;
  s := s+'  ,Amount '#10;
  s := s+'  ,Booking_Item_Id '#10;
  s := s+'  ,(SELECT Item FROM items WHERE id=Booking_Item_Id) AS Booking_Item '#10;
  s := s+'  ,INCL_EXCL '#10;
  s := s+'  ,NETTO_AMOUNT_BASED '#10;
  s := s+'  ,VALUE_FORMULA '#10;
  s := s+'  ,VALID_FROM '#10;
  s := s+'  ,VALID_TO '#10;
  s := s+'  ,ROUND_VALUE '#10;
  s := s+' FROM '#10;
  s := s+'   home100.TAXES WHERE HOTEL_ID=(SELECT CompanyID FROM control LIMIT 1) COLLATE utf8_general_ci '#10;
  s := s+' WHERE ';
  s := s+'   (VALID_FROM >= dtDate) AND (VALID_TO <= dtDate)';

  rSet := CreateNewDataSet;
  try

    if rSet_bySQL(rSet,s,false) then
    begin
      zTaxesHolder.id                 := rSet['id'];
      zTaxesHolder.Description        := rSet['description'];
      zTaxesHolder.Hotel_Id           := rSet['Hotel_dd'];
      zTaxesHolder.Tax_Type           := rSet['tax_Type'];
      zTaxesHolder.Tax_Base           := rSet['tax_base'];
      zTaxesHolder.Time_Due           := rSet['time_due'];
      zTaxesHolder.ReTaxable          := rSet['retaxable'];
      zTaxesHolder.Booking_Item_Id    := rSet['Booking_Item_Id'];
      zTaxesHolder.Booking_Item       := rSet['Booking_Item'];
      zTaxesHolder.Incl_Excl          := rSet['inc_Exc'];
      zTaxesHolder.NETTO_AMOUNT_BASED := rSet['NETTO_AMOUNT_BASED'];
      zTaxesHolder.VALUE_FORMULA      := rSet['VALUE_FORMULA'];
      zTaxesHolder.VALID_FROM         := rSet['Valid_FROM'];
      zTaxesHolder.VALID_TO           := rSet['Valid_TO'];
    end;
  finally
    freeandnil(rSet);
  end;

end;



procedure TfrmTestTax.sButton1Click(Sender: TObject);
var
  taxdata :recTaxesHolder;
begin
  taxdata := GetTaxesHolder;

  sMemo1.Lines.Add(taxdata.Incl_Excl);

end;

procedure TfrmTestTax.sButton2Click(Sender: TObject);
var
  s : string;
  rSet : TRoomerDataset;

  theDate  : TdateTime;
  room     : string;
  roomtype : string;
  resflag : string;
  roomrate : double;
  discount : double;
  isPercentage : boolean;
  currency : string;
  Invoicenumber : integer;
  paid : boolean;
  confirmdate : TdateTime;
  GuestCount : integer;

begin
  s := '';
  s := s+'SELECT '#10;
  s := s+' rd.reservation'#10;
  s := s+',rd.roomReservation '#10;
  s := s+',date(rd.adate) as theDate '#10;
  s := s+',rd.room '#10;
  s := s+',rd.roomtype '#10;
  s := s+',rd.resflag '#10;
  s := s+',rd.roomrate '#10;
  s := s+',rd.discount '#10;
  s := s+',rd.isPercentage '#10;
  s := s+',rd.currency '#10;
  s := s+',rd.Invoicenumber '#10;
  s := s+',rd.paid '#10;
  s := s+',rd.confirmdate '#10;
  s := s+',(SELECT count(ID) FROM persons WHERE persons.roomreservation=rd.roomreservation) AS GuestCount '#10;
  s := s+'FROM '#10;
  s := s+'  roomsdate rd '#10;
  s := s+'WHERE '#10;
  s := s+'  roomReservation = 9392 '#10;
  s := s+'ORDER BY rd.aDate '#10;


  rSet := CreateNewDataSet;
  try
    if rSet_bySQL(rSet,s,false) then
    begin
      if taxes_.active  then taxes_.Close;
      taxes_.Open;

      // það þarf að vera hægt að
      // reikna tax útfrá þeim forsendum sem eru hér

      // val um að sleppa greiddum
      // val um að sleppa þeim sem eru þegar confirmaðar

      // og svo taka inn allar hugsanlegar breytur úr taxes
      // Hvaða dagur á að ráða
      // valit_to valit_from

      rSet.First;
      while not rSet.Eof do
      begin
        Taxes_.Append;
        zReservation      := rSet['reservation'];
        zRoomReservation  := rSet['roomreservation'];
        room              := rSet['room'];
        theDate           := rSet['theDate'];
        roomtype          := rSet['roomtype'];
        resflag           := rSet['resflag'];
        roomrate          := rSet['roomrate'];
        discount          := rSet['discount'];
        isPercentage      := rSet['isPercentage'];
        currency          := rSet['currency'];
        Invoicenumber     := rSet['Invoicenumber'];
        paid              := rSet['paid'];
        confirmdate       := rSet['confirmdate'];
        GuestCount        := rSet['GuestCount'];

        Taxes_['reservation']      := zReservation           ;
        Taxes_['roomreservation']  := zRoomReservation           ;
        Taxes_['room']             := room           ;
        Taxes_['theDate']          := theDate        ;
        Taxes_['roomtype']         := roomtype       ;
        Taxes_['resflag']          := resflag        ;
        Taxes_['roomrate']         := roomrate       ;
        Taxes_['discount']         := discount       ;
        Taxes_['isPercentage']     := isPercentage   ;
        Taxes_['currency']         := currency       ;
        Taxes_['Invoicenumber']    := Invoicenumber  ;
        Taxes_['paid']             := paid           ;
        Taxes_['confirmdate']      := confirmdate    ;
        Taxes_['GuestCount']       := GuestCount     ;
        Taxes_.post;
        rSet.Next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure TfrmTestTax.FormCreate(Sender: TObject);
begin
  zUseStayTax      := false;
  zReservation     := 0;
  zRoomreservation := 0;
end;

procedure TfrmTestTax.FormShow(Sender: TObject);
var
  s : string;
begin
  //**

  s := '';
  labReservation.caption     := inttostr(zReservation);
  labRoomReservation.caption := inttostr(zRoomReservation);
  initTaxesHolder(zTaxesHolder);

//  GetTaxesHolderValues(;




end;

end.
