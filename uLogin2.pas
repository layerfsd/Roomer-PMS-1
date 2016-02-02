unit uLogin2;

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
  , ExtCtrls
  , Buttons
  , ug
  , _glob
  , PrjConst;

type
  TfrmLogin2 = class(TForm)
    Panel3: TPanel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    grbxLogin: TGroupBox;
    Image1: TImage;
    clabUser: TLabel;
    clabPassword: TLabel;
    labWrongLoginMessage: TLabel;
    labExpiredMessage: TLabel;
    edtLogin: TEdit;
    edtPassword: TEdit;
    grbxCurrentHotel: TGroupBox;
    clabName: TLabel;
    cLabRoomCount: TLabel;
    cLabValidUntil: TLabel;
    labName: TLabel;
    labRoomCount: TLabel;
    labExpDate: TLabel;
    btnChangeHotel: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnChangeHotelClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }

    // svo það sé hægt að hætta breyta aftur
    // ef ýtt á cancel
    startHotelIndex : integer;

    procedure calcDaysLeft;


  public
    zUserName          : string;
    zPassword          : string;
    zWrongLoginMessage : string;
    zExpiredMessage    : string;
    zDaysLeft          : integer;


    { Public declarations }
  end;

var
  frmLogin2: TfrmLogin2;

implementation

{$R *.dfm}

procedure TfrmLogin2.calcDaysLeft;
begin
  zDaysLeft := _DaysBetween(Date, g.qExpDate);
  if zDaysLeft < 90 then
  begin
    zExpiredMessage := inttostr(zDaysLeft)+' '+shDaysLeft;
  end;
end;


procedure TfrmLogin2.FormCreate(Sender: TObject);
begin
  //**
  zUserName          := '';
  zPassword          := '';
  zWrongLoginMessage := '';
  zExpiredMessage    := '';
end;

procedure TfrmLogin2.FormShow(Sender: TObject);
begin
  //**
  startHotelIndex := g.qHotelIndex;

  edtLogin.Text    := zUserName;
  edtPassword.Text := zPassword;

  labName.caption      := g.qHotelCode+' '+g.qHotelName;
  labRoomCount.Caption := inttostr(g.qRoomCount);
  labexpdate.caption   := dateToStr(g.qExpDate);


  calcDaysLeft;



  labWrongLoginMessage.Caption := zWrongLoginMessage;
  labExpiredMessage.Caption    := zExpiredMessage;
end;

procedure TfrmLogin2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //**
end;

procedure TfrmLogin2.FormDestroy(Sender: TObject);
begin
  //**
end;

procedure TfrmLogin2.btnOkClick(Sender: TObject);
begin
  zUserName   := edtLogin.Text;
  zPassword   := edtPassword.Text;
end;

procedure TfrmLogin2.btnChangeHotelClick(Sender: TObject);
var
  tmpIndex : integer;
begin
  tmpIndex := g.qHotelIndex;
  if g.openSelectHotel then
  begin
    // Ef valið nýtt hótel
    if g.qHotelIndex <> tmpIndex then
    begin
      g.SetHotelIndex;

      labName.caption      := g.qHotelCode+' '+g.qHotelName;
      labRoomCount.Caption := inttostr(g.qRoomCount);
      labexpdate.caption   := dateToStr(g.qExpDate);

      labExpiredMessage.Caption    := '';
      calcDaysLeft;
      labWrongLoginMessage.Caption := zWrongLoginMessage;
      labExpiredMessage.Caption    := zExpiredMessage;
    end;
  end;
end;

procedure TfrmLogin2.btnCancelClick(Sender: TObject);
begin
  if startHotelIndex <> g.qHotelIndex then
  begin
    g.qHotelIndex := startHotelIndex;

    g.SetHotelIndex;
    g.ProcessHotelList(false);

    labName.caption      := g.qHotelCode+' '+g.qHotelName;
    labRoomCount.Caption := inttostr(g.qRoomCount);
    labexpdate.caption   := dateToStr(g.qExpDate);

    labExpiredMessage.Caption    := '';
    calcDaysLeft;
    labWrongLoginMessage.Caption := zWrongLoginMessage;
    labExpiredMessage.Caption    := zExpiredMessage;
  end;

end;

end.
