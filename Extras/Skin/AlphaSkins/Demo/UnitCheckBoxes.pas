unit UnitCheckBoxes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, 
  sCheckbox, sRadioButton, ExtCtrls, sPanel, sGroupBox, sFrameAdapter, StdCtrls,
  sComboBox;

type
  TFrameCheckBoxes = class(TFrame)
    sGroupBox2: TsGroupBox;
    sRadioButton1: TsRadioButton;
    sRadioButton2: TsRadioButton;
    sRadioButton3: TsRadioButton;
    sRadioButton5: TsRadioButton;
    sGroupBox6: TsGroupBox;
    sCheckBox1: TsCheckBox;
    sCheckBox2: TsCheckBox;
    sCheckBox3: TsCheckBox;
    sCheckBox5: TsCheckBox;
    sFrameAdapter1: TsFrameAdapter;
    sRadioGroup1: TsRadioGroup;
    sComboBox1: TsComboBox;
    procedure sComboBox1Change(Sender: TObject);
  end;

implementation

uses sConst, sVclUtils;

{$R *.DFM}

procedure TFrameCheckBoxes.sComboBox1Change(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to ComponentCount - 1 do if Components[i] is TButtonControl then TrySetSkinSection(TControl(Components[i]), sComboBox1.Text);
end;

end.
