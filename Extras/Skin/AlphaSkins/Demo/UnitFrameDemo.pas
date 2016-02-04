unit UnitFrameDemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, 
  sFrameAdapter, Buttons, sSpeedButton, ComCtrls, sStatusBar, Menus,
  StdCtrls, sLabel, sCheckBox, sGroupBox, sTrackBar;

type
  TFrameDemo = class(TFrame)
    sFrameAdapter1: TsFrameAdapter;
    PopupMenu1: TPopupMenu;
    Item11: TMenuItem;
    Item1: TMenuItem;
    Item31: TMenuItem;
    Item41: TMenuItem;
    Item111: TMenuItem;
    Item121: TMenuItem;
    Item131: TMenuItem;
    sLabel1: TsLabel;
    sCheckBox1: TsCheckBox;
    sGroupBox1: TsGroupBox;
    sSpeedButton1: TsSpeedButton;
    sSpeedButton2: TsSpeedButton;
    sSpeedButton3: TsSpeedButton;
    sTrackBar1: TsTrackBar;
  end;

implementation

{uses Unit3, Unit4, Unit5, Unit6, Unit7, Unit8, Unit9, Unit10, Unit11,
  Unit12, Unit13, Unit14, Unit15, Unit18, sMessages, sSkinProps;
}
{$R *.DFM}

end.
