unit uDownPayment;

interface

uses
    Windows
  , Messages
  , SysUtils
  , Variants
  , Classes
  , Graphics
  , Controls
  , Forms
  , Dialogs
  , ExtCtrls
  , Menus
  , StdCtrls
  , Data.DB

  , uG
  , hData
  , _glob

  , uUtils
  , kbmMemTable

  , cmpRoomerDataSet
  , cmpRoomerConnection

  , sMemo
  , sEdit
  , sSpinEdit
  , sLabel
  , sGroupBox
  , sButton
  , sScrollBox

  , cxStyles
  , dxSkinscxPCPainter
  , dxSkinsCore, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin,
  dxSkinOffice2013White, dxSkinsDefaultPainters, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  cxPropertiesStore, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, Vcl.Mask,
  sMaskEdit, sCustomComboEdit, sCurrEdit, Vcl.Buttons, sSpeedButton, sPanel, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinDarkRoom, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue

  ;

type
  TfrmDownPayment = class(TForm)
    Panel1: TsPanel;
    cxGroupBox1: TsGroupBox;
    btnOk: TsButton;
    btnCancel: TsButton;
    labReservation: TsLabel;
    labRoomReservation: TsLabel;
    labInvoice: TsLabel;
    sGroupBox1: TsGroupBox;
    memNotes: TsMemo;
    sScrollBox1: TsScrollBox;
    kbmPayType: TkbmMemTable;
    tvPayType: TcxGridDBTableView;
    lvPayType: TcxGridLevel;
    grPayType: TcxGrid;
    PayTypeDS: TDataSource;
    tvPayTypePayType: TcxGridDBColumn;
    tvPayTypeDescription: TcxGridDBColumn;
    tvPayTypePayGroup: TcxGridDBColumn;
    edDescription: TsEdit;
    labPayment: TsLabel;
    labDescription: TsLabel;
    edAmount: TsCalcEdit;
    sSpeedButton1: TsButton;
    FormStore: TcxPropertiesStore;
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnCancelClick(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    zCanClose : boolean;
  public
    { Public declarations }
    rec : recDownPayment;
  end;

var
  frmDownPayment : TfrmDownPayment;

implementation

{$R *.dfm}

uses uAppGlobal, uD, uDImages;

procedure TfrmDownPayment.btnCancelClick(Sender: TObject);
begin
  //
  zCanClose := true;
end;

procedure TfrmDownPayment.btnOkClick(Sender: TObject);
var
  dq : double;
  balance : double;

begin
  zCanClose := true;

  balance := rec.InvoiceBalance-edAmount.value;


  if edAmount.value = 0 then
  begin
    showmessage('Payment can not be 0');
    edAmount.SetFocus;
    zCanClose := false;
    exit;
  end;



  if NOT rec.NotInvoice then
    if (balance < 0) AND (NOT ctrlGetBoolean('AllowNegativeInvoice')) then
    begin
      showmessage('Payments can not be higer than the invoice amount');
      edAmount.SetFocus;
      zCanClose := false;
      exit;
    end;

  frmDownPayment.rec.Reservation     := rec.Reservation      ;
  frmDownPayment.rec.RoomReservation := rec.RoomReservation  ;
  frmDownPayment.rec.Invoice         := rec.Invoice          ;
  frmDownPayment.rec.Amount          := edAmount.value;
  frmDownPayment.rec.Description     := edDescription.text;
  frmDownPayment.rec.Notes           := memNotes.Text;
  frmDownPayment.rec.PaymentType     := kbmPayType.FieldByName('payType').asstring;
  frmDownPayment.rec.InvoiceBalance  := balance;
end;


procedure TfrmDownPayment.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //
end;

procedure TfrmDownPayment.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  canClose := zCanClose;
end;

procedure TfrmDownPayment.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self);
  g.initRecDownPayment(rec);
  zCanClose := true;
end;

procedure TfrmDownPayment.FormDestroy(Sender: TObject);
begin
  //
end;

procedure TfrmDownPayment.FormShow(Sender: TObject);
var
   rSet : TRoomerDataset;
   s : string;

   defaultType : string;

begin
  labReservation.Caption         := inttostr(frmDownPayment.rec.Reservation);
  labRoomReservation.caption     := inttostr(frmDownPayment.rec.RoomReservation);
  labInvoice.caption             := inttostr(frmDownPayment.rec.Invoice);
  edAmount.Value                 := frmDownPayment.rec.Amount;
  edDescription.text             := frmDownPayment.rec.Description;
  memNotes.Text                  := frmDownPayment.rec.Notes;

  defaultType := frmDownPayment.rec.PaymentType;
  //InvPriceGroup

  rSet := CreateNewDataSet;
  try
		s := '';
    s := s+'Select paytype,description,paygroup From paytypes where (active=true) and PayGroup <> '+_db(g.qInvPriceGroup)+' order by paygroup ';

//    _db(g.qInvPriceGroup)

    if rSet_bySQL(rSet,s) then
    begin
      LoadKbmMemtableFromDataSetQuiet(kbmPaytype,rSet,[]);
      if not kbmPaytype.Locate('Paytype',defaultType,[]) then
      begin
        kbmPaytype.First;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure TfrmDownPayment.sSpeedButton1Click(Sender: TObject);
begin
  edAmount.value := rec.InvoiceBalance;
end;

end.
