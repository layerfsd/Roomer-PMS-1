unit UnitHints;

interface

uses 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, sFrameAdapter, StdCtrls, sComboBox, Buttons, sBitBtn, sLabel,
  sListBox, sGroupBox;

type
  TFrameHints = class(TFrame)
    sFrameAdapter1: TsFrameAdapter;
    sBitBtn1: TsBitBtn;
    sLabelFX1: TsLabelFX;
    sRadioGroup1: TsRadioGroup;
    sListBox1: TsListBox;
    procedure sBitBtn1Click(Sender: TObject);
    procedure sRadioGroup1Click(Sender: TObject);
    procedure FrameResize(Sender: TObject);
    procedure sListBox1Click(Sender: TObject);
  public
    procedure UpdateStates;
  end;

implementation

uses sConst, sHintDesigner, sHintManager, MainUnit, acAlphaHintsEdit;

{$R *.DFM}

procedure TFrameHints.sBitBtn1Click(Sender: TObject);
var
  i : integer;
begin
  EditHints(MainForm.sAlphaHints1);
  // Generate new list
  sListBox1.Items.Clear;
  sListBox1.Items.Add('Default internal');
  for i := 0 to MainForm.sAlphaHints1.Templates.Count - 1 do begin
    sListBox1.Items.Add(MainForm.sAlphaHints1.Templates[i].Name);
  end;
  sListBox1.ItemIndex := 0
end;

procedure TFrameHints.sRadioGroup1Click(Sender: TObject);
begin
  case sRadioGroup1.ItemIndex of
    0 : MainForm.ActionHintsDisable.Execute;
    1 : MainForm.ActionHintsSkinned.Execute;
    2 : MainForm.ActionHintsCustom.Execute;
    3 : MainForm.ActionHintsStd.Execute;
  end;
  sListBox1.Enabled := MainForm.ActionHintsCustom.Checked;
  sBitBtn1.Enabled := MainForm.ActionHintsCustom.Checked;
end;

procedure TFrameHints.FrameResize(Sender: TObject);
var
  i : integer;
begin
  sListBox1.Items.Clear;
  sListBox1.Items.Add('Default internal');
  for i := 0 to MainForm.sAlphaHints1.Templates.Count - 1 do begin
    sListBox1.Items.Add(MainForm.sAlphaHints1.Templates[i].Name);
  end;
  sListBox1.ItemIndex := 0;
  UpdateStates;
end;

procedure TFrameHints.UpdateStates;
begin
  if MainForm.ActionHintsDisable.Checked then sRadioGroup1.ItemIndex := 0
    else if MainForm.ActionHintsSkinned.Checked then sRadioGroup1.ItemIndex := 1
      else if MainForm.ActionHintsCustom.Checked then sRadioGroup1.ItemIndex := 2
        else if MainForm.ActionHintsStd.Checked then sRadioGroup1.ItemIndex := 3;
  sListBox1.Enabled := MainForm.ActionHintsCustom.Checked;
  sBitBtn1.Enabled := MainForm.ActionHintsCustom.Checked;
end;

procedure TFrameHints.sListBox1Click(Sender: TObject);
begin
  MainForm.sAlphaHints1.TemplateName := sListBox1.Items[sListBox1.ItemIndex]
end;

end.
