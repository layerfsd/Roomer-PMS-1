unit uFrmEditEmailProperties;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sButton, Vcl.ExtCtrls, sPanel, sEdit, sLabel;

type
  TFrmEditEmailProperties = class(TForm)
    sPanel2: TsPanel;
    sButton1: TsButton;
    sButton2: TsButton;
    sLabel1: TsLabel;
    edtName: TsEdit;
    edtSubject: TsEdit;
    sLabel2: TsLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEditEmailProperties: TFrmEditEmailProperties;

implementation

{$R *.dfm}

uses uRoomerLanguage,
     uAppGlobal
     ;

procedure TFrmEditEmailProperties.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
end;

end.
