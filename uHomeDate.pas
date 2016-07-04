unit uHomeDate;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,

  _Glob, cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  cxCheckBox,
  StdCtrls, Vcl.Mask, sMaskEdit, sCustomComboEdit, sTooledit, sButton, Vcl.ExtCtrls, sPanel

  ;

type
  TfrmHomedate = class(TForm)
    Panel2: TsPanel;
    dtHome: TsDateEdit;
    sPanel1: TsPanel;
    Button2: TsButton;
    Button1: TsButton;
    procedure FormCreate(Sender : TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure returnToHome;
  public
    { Public declarations }
  end;

var
  frmHomedate : TfrmHomedate;

implementation

uses
  uMain, uAppGlobal, uDImages, uUtils;

{$R *.dfm}

procedure TfrmHomedate.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmHomedate.Button2Click(Sender: TObject);
begin
  returnToHome;
end;

procedure TfrmHomedate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmMain.KeyPreview := true;
end;

procedure TfrmHomedate.FormCreate(Sender : TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  dtHome.Date := now;
end;

procedure TfrmHomedate.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    returnToHome;
    Key := VK_NONAME;
  end;
end;

procedure TfrmHomedate.returnToHome;
begin
    frmMain.dtDate.Date := StrToDate(dtHome.Text); // dtHome.Date;
    Close;
end;



end.




