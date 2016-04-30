unit uChangeRate;

(*

 121207 - checked for ww - OK
             130206 - Jóel
          Breytti textum sjá excel skjal
*)


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
  , StdCtrls
  , Buttons
  , ExtCtrls
  , Menus

  , hdata
  , uAppglobal
  , ug
  , ud
  , _glob


  , cxGraphics
  , cxControls
  , cxLookAndFeels
  , cxLookAndFeelPainters
  , cxContainer
  , cxEdit
  , cxTextEdit
  , cxMaskEdit
  , cxLabel, Vcl.Mask, sMaskEdit, sCustomComboEdit, sCurrEdit, sButton, sPanel, sLabel

  ;

type
  TfrmChangeRate = class(TForm)
    Panel1: TsPanel;
    edRate: TsCalcEdit;
    btnSave: TsButton;
    btnGetFromWeb: TsButton;
    cxButton1: TsButton;
    cxLabel1: TsLabel;
    cxLabel2: TsLabel;
    cxLabel3: TsLabel;
    labCurrency: TsLabel;
    btnOK: TsButton;
    btnCancel: TsButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnGetFromWebClick(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    zCurrency : string;
    zRate     : double;
  end;

var
  frmChangeRate: TfrmChangeRate;

implementation

{$R *.dfm}

uses
    PrjConst
   ,uDImages
   , uUtils
   ;

procedure TfrmChangeRate.btnGetFromWebClick(Sender: TObject);
begin
  showmessage(GetTranslatedText('shTx_UnderDevelopment'));
end;

procedure TfrmChangeRate.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  //**
  zRate := 0.000 ;
  zCurrency := '';
end;

procedure TfrmChangeRate.FormShow(Sender: TObject);
begin
  //**
  edRate.text   := floatTostr(zRate);
  labCurrency.caption := zCurrency ;
end;

procedure TfrmChangeRate.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //**
end;

procedure TfrmChangeRate.FormDestroy(Sender: TObject);
begin
  //**
end;

procedure TfrmChangeRate.btnSaveClick(Sender: TObject);
var
  Rate : double;
begin
    if MessageDlg(GetTranslatedText('shTx_SaveToCurrencytable')+zCurrency,
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Rate := _strToFloat(edRate.text);
    if not hdata.UPD_currencyRate(zCurrency,rate) then
    begin
      showmessage(GetTranslatedText('shTx_CurrencyUpdateError'))
    end else
    begin
      glb.ForceTableRefresh;
    end;
  end;
end;


procedure TfrmChangeRate.cxButton1Click(Sender: TObject);
var
  rate : double;
begin
  rate := GetRate(zCurrency);
  edRate.text := floatTostr(rate);
end;

procedure TfrmChangeRate.cxButton2Click(Sender: TObject);
begin
  zRate := _strToFloat(edRate.Text);
end;

end.
