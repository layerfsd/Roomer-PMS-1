unit RoomerLoginForm;

interface

{$include roomer.inc}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, acPNG, cxLookAndFeels, sSkinProvider, cxPropertiesStore, sLabel, cxClasses, dxGDIPlusClasses, cxGraphics, cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkSide, dxSkinTheAsphaltWorld, cxButtons, dxSkinsDefaultPainters;

type
  // Dialog asking user for credentials, When closed the result is stored in the Tag property, using ord(TLoginformResult)
  TfrmRoomerLoginForm = class(TForm)
    lbHotel: TLabel;
    edtHotelCode: TEdit;
    lbUsername: TLabel;
    edtUsername: TEdit;
    lbPassword: TLabel;
    edtPassword: TEdit;
    pnlButtons: TPanel;
    btLogin: TcxButton;
    btCancel: TcxButton;
    imgRoomer: TImage;
    StoreLogin: TcxPropertiesStore;
    lblMessage: TsLabel;
    lblServerProblem: TsLabel;
    btOffline: TcxButton;
    procedure btLoginClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btOfflineClick(Sender: TObject);
  private
    { Private declarations }
    FNoInternet: boolean;
    FServerUnreachable : Boolean;
    procedure SetNoInternet(const Value: boolean);
    procedure SetServerUnreachable(const Value: boolean);
    procedure UpdateControls;
  protected
    function GetLoginParameters(var aUsername, aPassword, aHotelId: String): Boolean;
    property NoInternet: boolean read FNoInternet write SetNoInternet;
    property ServerUnreachable: boolean read FServerUnreachable write SetServerUnreachable;
  public
    { Public declarations }
  end;

  // Possible outcomes of AskUserForCredentials()
  TLoginFormResult = (lrCancel = 0, lrLogin, lrOffLine);



// Ask the user for authentication credentials using the RoomerLoginForm
function AskUserForCredentials(var aUsername: String; var aPassword: String; var aHotelId : String; aLastMessage : String): TLoginFormResult;


const
  // TLoginFormResults when login dialog is confirmed
  cLoginFormSuccesfull: set of TLoginFormResult = [lrLogin, lrOffline];

implementation

{$R *.dfm}

uses uUtils,
     uRoomerLanguage, uDImages,
     ud,
     IOUtils,
     uStringUtils,
     uMain,
     uAboutRoomer;

function AskUserForCredentials(var aUsername: String; var aPassword: String; var aHotelId : String; aLastMessage : String): TLoginFormResult;
var
  lLoginForm: TfrmRoomerLoginForm;
begin
  result := lrCancel;
  lLoginForm := TfrmRoomerLoginForm.Create(nil);
  try
    // Disable use of commandline parameters if previous login failed
    if (aLastMessage = '') and lLoginForm.GetLoginParameters(aUsername, aPassword, aHotelId) then
    begin
      result := lrLogin;
      exit;
    end;

    if (aHotelId <> '') then lLoginForm.edtHotelCode.Text := aHotelId;
    if (aUsername <> '') then lLoginForm.edtUsername.Text := aUsername;
    lLoginForm.edtPassword.Text := '';
    lLoginForm.lblMessage.Caption := aLastMessage;
    lLoginForm.lblMessage.Visible := aLastMessage <> '';

    lLoginForm.ShowModal;
    Result := TLoginFormResult(lLoginForm.Tag);
    if (Result in [lrLogin, lrOffline]) then
    begin
      aHotelId := UpperCase(lLoginForm.edtHotelCode.Text);
      aUsername := lLoginForm.edtUsername.Text;
      aPassword := lLoginForm.edtPassword.Text;
    end;
  finally
    lLoginForm.Free;
  end;
end;

// Get credentials from commandline parameters, return true if all three neeeded parameters are filled in
function TfrmRoomerLoginForm.GetLoginParameters(var aUsername, aPassword, aHotelId : String) : Boolean;
var temp : String;
begin
  temp := ParameterByName('username');
  if temp <> '' then aUsername := temp;

  temp := ParameterByName('password');
  if temp <> '' then aPassword := temp;

  temp := ParameterByName('hotelId');
  if temp <> '' then aHotelId := temp;

  result := (aUsername<>'') AND (aPassword<>'') AND (aHotelId<>'');
end;


procedure TfrmRoomerLoginForm.SetNoInternet(const Value: boolean);
begin
  FNoInternet := Value;
  UpdateControls;
end;

procedure TfrmRoomerLoginForm.SetServerUnreachable(const Value: boolean);
begin
  FServerUnreachable := Value;
  UpdateControls;
end;

procedure TfrmRoomerLoginForm.UpdateControls;
var
  lOffLine: boolean;
const
  cNoInternet = 'No internet connection. ';
  cPlatformUnreachable = 'Roomer platform unreachable. ';
  cOfflineMessage = 'Roomer will not be able to work normally';
begin
  lOffLine := NoInternet or ServerUnreachable;
  btLogin.Enabled := not lOffLine;

{$ifdef rmEnableOffLineLogin}
  btOffline.Visible := True;
{$else}
  btOffline.Visible := lOffLine;
{$endif}

  btLogin.Default := not lOffLine;
  btOfflIne.Default := lOffLine;

  if NoInternet then
    lblServerProblem.Caption := cNoInternet + cOfflineMessage
  else
  if ServerUnreachable then
    lblServerProblem.Caption := cPlatformUnreachable + cOfflineMessage
  else
    lblServerProblem.Caption := '';
end;

procedure TfrmRoomerLoginForm.btLoginClick(Sender: TObject);
begin
  Tag := ord(lrLogin);
  if IsControlKeyPressed then
     SetIgnoresToZero(d.roomerMainDataSet);
  Close;
end;

procedure TfrmRoomerLoginForm.btOfflineClick(Sender: TObject);
begin
  Tag := ord(lrOffLine);
end;

procedure TfrmRoomerLoginForm.btCancelClick(Sender: TObject);
begin
  Tag := ord(lrCancel);
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
  btOffline.Visible := NoInternet OR ServerUnreachable;
end;

end.
