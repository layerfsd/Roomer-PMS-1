unit UnitEditorsAdd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  sFrameAdapter, sComboBoxes, sTooledit, sCurrencyEdit, sComboEdit,
  sCurrEdit, StdCtrls, Mask, sMaskEdit, sCustomComboEdit, sComboBox,
  sFileCtrl, sGroupBox, ComCtrls, acShellCtrls, sCheckBox, sFontCtrls,
  sListBox, sCheckListBox;

type
  TFrameEditorsAdd = class(TFrame)
    sFrameAdapter1: TsFrameAdapter;
    sCheckListBox1: TsCheckListBox;
    sListBox1: TsListBox;
    sColorBox1: TsColorBox;
    sComboBoxEx1: TsComboBoxEx;
    sComboBox1: TsComboBox;
    sCheckBox1: TsCheckBox;
    sFilterComboBox1: TsFilterComboBox;
    sCheckBox2: TsCheckBox;
    procedure sCheckBox1Click(Sender: TObject);
    procedure sComboBox1Change(Sender: TObject);
    procedure sCheckBox2Click(Sender: TObject);
  end;

implementation

uses sVCLUtils;

{$R *.DFM}

procedure TFrameEditorsAdd.sCheckBox1Click(Sender: TObject);
begin
  sListBox1.AutoHideScroll := sCheckBox1.Checked
end;

procedure TFrameEditorsAdd.sComboBox1Change(Sender: TObject);
var
  i : integer;
begin
  // Change SkinSection in all controls on the current frame
  for i := 0 to ControlCount - 1 do if Controls[i] is TWinControl then TrySetSkinSection(TWinControl(Controls[i]), sComboBox1.Text);
end;

procedure TFrameEditorsAdd.sCheckBox2Click(Sender: TObject);
var
  i : integer;
begin
  sCheckListBox1.MultiSelect := sCheckBox2.Checked;
  sListBox1.MultiSelect := sCheckBox2.Checked;
  sCheckListBox1.Items.BeginUpdate;
  sListBox1.Items.BeginUpdate;
  for i := 3 to 7 do begin
    sCheckListBox1.Selected[i] := sCheckBox2.Checked;
    sListBox1.Selected[i] := sCheckBox2.Checked;
  end;
  sCheckListBox1.Items.EndUpdate;
  sListBox1.Items.EndUpdate;
end;

end.
