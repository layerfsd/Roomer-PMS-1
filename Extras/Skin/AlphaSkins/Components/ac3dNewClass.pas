unit ac3dNewClass;
{$I sDefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons,
  {$IFDEF DELPHI6UP}Variants, {$ENDIF}
  sBitBtn, sComboBox, sEdit, sSkinProvider, ImgList, acAlphaImageList;


type
  TFormNewThirdClass = class(TForm)
    sEdit1: TsEdit;
    sComboBox1: TsComboBox;
    sBitBtn1: TsBitBtn;
    sBitBtn2: TsBitBtn;
    sSkinProvider1: TsSkinProvider;
    sAlphaImageList1: TsAlphaImageList;
    procedure FormCreate(Sender: TObject);
  end;

var
  FormNewThirdClass: TFormNewThirdClass;

implementation

uses sDefaults;

{$R *.dfm}

procedure TFormNewThirdClass.FormCreate(Sender: TObject);
var
  i: integer;
begin
  sEdit1.Text := '';
  sComboBox1.Items.Clear;
  for i := 0 to Length(acThirdCaptions) - 1 do
    sComboBox1.Items.Add(acThirdCaptions[i]);
    
  sComboBox1.ItemIndex := 0;
end;

end.
