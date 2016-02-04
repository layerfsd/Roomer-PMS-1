unit UnitTabControls;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  sTabControl, sCheckbox, sRadioButton, ExtCtrls, sPanel, sGroupBox, sPageControl,
  sFrameAdapter, sTrackBar, ComCtrls, StdCtrls, sListView, sComboBox,
  Buttons, sSpeedButton;

type
  TFrameTabControls = class(TFrame)
    sFrameAdapter1: TsFrameAdapter;
    sPageControl1: TsPageControl;
    sTabSheet1: TsTabSheet;
    sTabSheet2: TsTabSheet;
    sRadioButton1: TsRadioButton;
    sRadioButton2: TsRadioButton;
    sRadioButton3: TsRadioButton;
    sComboBox1: TsComboBox;
    sCheckBox15: TsCheckBox;
    sCheckBox8: TsCheckBox;
    sGroupBox5: TsGroupBox;
    sRadioButton6: TsRadioButton;
    sRadioButton7: TsRadioButton;
    sRadioButton8: TsRadioButton;
    sRadioButton9: TsRadioButton;
    sPageControl2: TsPageControl;
    sTabSheet8: TsTabSheet;
    sTabSheet9: TsTabSheet;
    sTabSheet10: TsTabSheet;
    sTabSheet11: TsTabSheet;
    sPageControl3: TsPageControl;
    sTabSheet12: TsTabSheet;
    sTabSheet13: TsTabSheet;
    sCheckBox1: TsCheckBox;
    sCheckBox17: TsCheckBox;
    sCheckBox2: TsCheckBox;
    procedure sCheckBox8Change(Sender: TObject);
    procedure sRadioButton6Change(Sender: TObject);
    procedure sRadioButton7Change(Sender: TObject);
    procedure sRadioButton8Change(Sender: TObject);
    procedure sRadioButton9Change(Sender: TObject);
    procedure sRadioButton1Click(Sender: TObject);
    procedure sRadioButton2Click(Sender: TObject);
    procedure sRadioButton3Click(Sender: TObject);
    procedure sComboBox1Change(Sender: TObject);
    procedure sCheckBox15Click(Sender: TObject);
    procedure sPageControl1CloseBtnClick(Sender: TComponent;
      TabIndex: Integer; var CanClose: Boolean;
      var Action: TacCloseAction);
    procedure sCheckBox17Click(Sender: TObject);
    procedure sTabSheet2ClickBtn(Sender: TObject);
    procedure sPageControl1Change(Sender: TObject);
    procedure sCheckBox1Click(Sender: TObject);
    procedure sCheckBox2Click(Sender: TObject);
  end;

implementation

uses commctrl, sVclUtils, sSKinProps, MainUnit;

{$R *.DFM}

procedure TFrameTabControls.sCheckBox8Change(Sender: TObject);
begin
  sPageControl1.MultiLine := sCheckBox8.Checked;
end;

procedure TFrameTabControls.sRadioButton6Change(Sender: TObject);
begin
  if sPageControl1.TabPosition <> tpTop then begin
    sPageControl1.TabPosition := tpTop;
    if sPageControl2 <> nil then sPageControl2.TabPosition := tpTop;
  end;
  sCheckBox8.Enabled := True;

  sRadioButton2.Enabled := True;
  sRadioButton3.Enabled := True;
end;

procedure TFrameTabControls.sRadioButton7Change(Sender: TObject);
begin
  if sPageControl1.TabPosition <> tpBottom then begin
    sPageControl1.TabPosition := tpBottom;
    if sPageControl2 <> nil then sPageControl2.TabPosition := tpBottom;
  end;
  sCheckBox8.Enabled := True;

  sRadioButton2.Enabled := False;
  sRadioButton3.Enabled := False;
end;

procedure TFrameTabControls.sRadioButton8Change(Sender: TObject);
begin
  if sPageControl1.TabPosition <> tpLeft then begin
    sPageControl1.TabPosition := tpLeft;
    if sPageControl2 <> nil then sPageControl2.TabPosition := tpLeft;
  end;
  sCheckBox8.Enabled := False;

  sRadioButton2.Enabled := False;
  sRadioButton3.Enabled := False;
end;

procedure TFrameTabControls.sRadioButton9Change(Sender: TObject);
begin
  if sPageControl1.TabPosition <> tpRight then begin
    sPageControl1.TabPosition := tpRight;
    if sPageControl2 <> nil then sPageControl2.TabPosition := tpRight;
  end;
  sCheckBox8.Enabled := False;

  sRadioButton2.Enabled := False;
  sRadioButton3.Enabled := False;
end;

procedure TFrameTabControls.sRadioButton1Click(Sender: TObject);
begin
  sPageControl1.Style := tsTabs;
  if sPageControl2 <> nil then sPageControl2.Style := tsTabs;
  sComboBox1.ItemIndex := 1;
  sPageControl1.SkinData.SkinSection := sComboBox1.Text;
  if sPageControl2 <> nil then sPageControl2.SkinData.SkinSection := sComboBox1.Text;

  if sRadioButton7 = nil then Exit;
  sRadioButton7.Enabled := True;
  sRadioButton8.Enabled := True;
  sRadioButton9.Enabled := True;
end;

procedure TFrameTabControls.sRadioButton2Click(Sender: TObject);
begin
  sPageControl1.Style := tsButtons;
  if sPageControl2 <> nil then sPageControl2.Style := tsButtons;
  sComboBox1.ItemIndex := 0;
  sPageControl1.SkinData.SkinSection := sComboBox1.Text;
  if sPageControl2 <> nil then sPageControl2.SkinData.SkinSection := sComboBox1.Text;

  if sRadioButton7 = nil then Exit;
  sRadioButton7.Enabled := False;
  sRadioButton8.Enabled := False;
  sRadioButton9.Enabled := False;
end;

procedure TFrameTabControls.sRadioButton3Click(Sender: TObject);
begin
  sPageControl1.Style := tsFlatButtons;
  if sPageControl2 <> nil then sPageControl2.Style := tsFlatButtons;
  sComboBox1.ItemIndex := 0;
  sPageControl1.SkinData.SkinSection := sComboBox1.Text;
  if sPageControl2 <> nil then sPageControl2.SkinData.SkinSection := sComboBox1.Text;

  if sRadioButton7 = nil then Exit;
  sRadioButton7.Enabled := False;
  sRadioButton8.Enabled := False;
  sRadioButton9.Enabled := False;
end;

procedure TFrameTabControls.sComboBox1Change(Sender: TObject);
begin
  sPageControl1.SkinData.SkinSection := sComboBox1.Text
end;

procedure TFrameTabControls.sCheckBox15Click(Sender: TObject);
begin
  sPageControl1.ShowCloseBtns := sCheckBox15.Checked;
  if sPageControl2 <> nil then sPageControl2.ShowCloseBtns := sCheckBox15.Checked;
end;

procedure TFrameTabControls.sPageControl1CloseBtnClick(Sender: TComponent; TabIndex: Integer; var CanClose: Boolean; var Action: TacCloseAction);
begin
  CanClose := MessageDlg('Close ' + sPageControl1.Pages[TabIndex].Caption + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;

procedure TFrameTabControls.sCheckBox17Click(Sender: TObject);
begin
  if sPageControl2 <> nil then sPageControl2.RotateCaptions := sCheckBox17.Checked;
end;

procedure TFrameTabControls.sTabSheet2ClickBtn(Sender: TObject);
var
  ts : TsTabSheet;
begin
  // Create new page
  ts := TsTabSheet.Create(sPageControl1);
  ts.ImageIndex := sPageControl1.PageCount;
  ts.Caption := IntToStr(sPageControl1.PageCount);
  ts.PageControl := sPageControl1;
  // Change index of the page with '+' button
  sTabSheet2.PageIndex := sPageControl1.PageCount - 1;
  // Show Close button on active tab
  sPageControl1.ActivePage.UseCloseBtn := True;        
end;

procedure TFrameTabControls.sPageControl1Change(Sender: TObject);
var
  i : integer;
  b : boolean;
begin
  b := False;
  // Search page which not is Active but can be activated (Close buttons may be visible in this case)
  for i := 0 to sPageControl1.PageCount - 1 do if (sPageControl1.Pages[i] <> sPageControl1.ActivePage) and (TsTabSheet(sPageControl1.Pages[i]).TabType = ttTab) then begin
    b := True;
    Break;
  end;
  for i := 0 to sPageControl1.PageCount - 1 do TsTabSheet(sPageControl1.Pages[i]).UseCloseBtn := b; // and (sPageControl1.Pages[i] = sPageControl1.ActivePage);
end;

procedure TFrameTabControls.sCheckBox1Click(Sender: TObject);
begin
  sPageControl1.ActiveIsBold := sCheckBox1.Checked;
  if sPageControl2 <> nil then sPageControl2.ActiveIsBold := sCheckBox1.Checked;
end;

procedure TFrameTabControls.sCheckBox2Click(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to sPageControl1.PageCount - 1 do sPageControl1.Pages[i].Enabled := not sCheckBox2.Checked;
end;

end.
