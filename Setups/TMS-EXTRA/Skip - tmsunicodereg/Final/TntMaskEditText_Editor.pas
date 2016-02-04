unit TntMaskEditText_Editor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, TntStdCtrls;

type
  TMaskEditTextForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    TntMEdit_InputText: TTntMaskEdit;
    Lbl_EditMask: TLabel;
    Btn_Ok: TButton;
    Btn_Cancel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MaskEditTextForm: TMaskEditTextForm;

implementation

{$R *.dfm}

end.
