unit uFrmNotepad;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDImages, Vcl.StdCtrls, sMemo, sButton, Vcl.ExtCtrls, sPanel, cxClasses, cxPropertiesStore,uAppGlobal;

type
  TFrmNotepad = class(TForm)
    sPanel1: TsPanel;
    btnClose: TsButton;
    sButton1: TsButton;
    sMemo1: TsMemo;
    FormStore: TcxPropertiesStore;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmNotepad: TFrmNotepad;

function EditText(Caption, text : String) : String; overload;
function EditText2(const Caption: string; var aText: string) : boolean; overload;

implementation

{$R *.dfm}

uses uRoomerLanguage, uUtils;

function EditText2(const Caption: string; var aText: string) : boolean;
var
  FrmNotepad: TFrmNotepad;
begin
  FrmNotepad := TFrmNotepad.Create(nil);
  try
    result := False;
    FrmNotepad.Caption := Caption;
    FrmNotepad.sMemo1.Lines.Text := aText;
    if FrmNotepad.ShowModal = mrOk then
    begin
      aText := FrmNotepad.sMemo1.Lines.Text;
      result := True;
    end;
  finally
    FrmNotepad.Free;
  end
end;

function EditText(Caption, text : String) : String;
var FrmNotepad: TFrmNotepad;
begin
  FrmNotepad := TFrmNotepad.Create(nil);
  try
    result := text;
    FrmNotepad.Caption := Caption;
    FrmNotepad.sMemo1.Lines.Text := text;
    if FrmNotepad.ShowModal = mrOk then
      result := FrmNotepad.sMemo1.Lines.Text;
  finally
    FreeAndNil(FrmNotepad);
  end
end;

procedure TFrmNotepad.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
end;

end.
