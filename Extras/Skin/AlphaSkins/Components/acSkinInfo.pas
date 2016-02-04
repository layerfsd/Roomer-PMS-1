unit acSkinInfo;
{$I sDefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  sSkinProvider, StdCtrls, Buttons, sBitBtn, sMemo, ComCtrls, sLabel;


type
  TSkinInfoForm = class(TForm)
    sBitBtn1: TsBitBtn;
    sSkinProvider1: TsSkinProvider;
    sMemo1: TsMemo;
    Label1: TLabel;
  end;


var
  SkinInfoForm: TSkinInfoForm;

  
implementation

{$R *.DFM}

end.
