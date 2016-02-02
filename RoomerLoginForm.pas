unit RoomerLoginForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, acPNG, cxLookAndFeels, sSkinProvider, cxPropertiesStore, sLabel, cxClasses, dxGDIPlusClasses, cxGraphics, cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkSide, dxSkinTheAsphaltWorld, cxButtons, dxSkinsDefaultPainters;

type
  TfrmRoomerLoginForm = class(TForm)
    Label1: TLabel;
    edtHotelCode: TEdit;
    Label2: TLabel;
    edtUsername: TEdit;
    Label3: TLabel;
    edtPassword: TEdit;
    Panel1: TPanel;
    Button1: TcxButton;
    Button2: TcxButton;
    Image1: TImage;
    StoreLogin: TcxPropertiesStore;
    lblMessage: TsLabel;
    lblServerProblem: TsLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    NoInternet,
    ServerUnreachable : Boolean;
  public
    { Public declarations }
    function GetLoginParameters(var username, password, hotelId: String): Boolean;
  end;

var
  frmRoomerLoginForm: TfrmRoomerLoginForm;

function LoginToRoomer(var username: String; var password: String; var hotelId : String; lastMessage : String): boolean;

implementation

{$R *.dfm}

uses uUtils,
     uRoomerLanguage, uDImages,
     ud,
     IOUtils,
     uStringUtils,
     uMain;

function LoginToRoomer(var username: String; var password: String; var hotelId : String; lastMessage : String): boolean;
var LoginForm: TfrmRoomerLoginForm;
begin
  result := false;
  LoginForm := TfrmRoomerLoginForm.Create(nil);
  try
    if LoginForm.GetLoginParameters(username, password, hotelId) then
    begin
      result := true;
      exit;
    end;
    if (hotelId <> '') then loginForm.edtHotelCode.Text := hotelId;
    if (username <> '') then loginForm.edtUsername.Text := username;
    loginForm.edtPassword.Text := '';
    loginForm.lblMessage.Caption := lastMessage;
    loginForm.lblMessage.Visible := lastMessage <> '';
    LoginForm.ShowModal;
    if LoginForm.Tag = mrOk then
    begin
      hotelId := UpperCase(loginForm.edtHotelCode.Text);
      username := loginForm.edtUsername.Text;
      password := loginForm.edtPassword.Text;
      result := true;
    end;
  finally
    LoginForm.Free;
  end;
end;

function TfrmRoomerLoginForm.GetLoginParameters(var username, password, hotelId : String) : Boolean;
var temp : String;
begin
  temp := ParameterByName('username');
  if temp <> '' then username := temp;

  temp := ParameterByName('password');
  if temp <> '' then password := temp;

  temp := ParameterByName('hotelId');
  if temp <> '' then hotelId := temp;

  result := (username<>'') AND (password<>'') AND (hotelId<>'');
end;


procedure TfrmRoomerLoginForm.Button1Click(Sender: TObject);
begin
  Tag := mrOK;

//  frmMain.OffLineMode :=  (NoInternet OR ServerUnreachable) AND
//    d.roomerMainDataSet.OfflineFilesAvailable(edtHotelCode.Text);
//

  Close;
end;

procedure TfrmRoomerLoginForm.Button2Click(Sender: TObject);
begin
  Tag := mrCancel;
  Close;
end;

procedure TfrmRoomerLoginForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SetFormTopmostOff(self);
end;

procedure TfrmRoomerLoginForm.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
end;

procedure TfrmRoomerLoginForm.FormShow(Sender: TObject);
begin
  if edtHotelCode.Text <> '' then
     ActiveControl := edtUsername;
  SetFormTopmostOn(self);
  NoInternet := NOT d.roomerMainDataSet.IsConnectedToInternet;
  ServerUnreachable := NOT d.roomerMainDataSet.RoomerPlatformAvailable;
  if NoInternet then
    lblServerProblem.Caption := 'No internet connection. Roomer will not be able to work normally.'
  else
  if ServerUnreachable then
    lblServerProblem.Caption := 'Roomer platform unreachable. Roomer will not be able to work normally.'
end;

end.
