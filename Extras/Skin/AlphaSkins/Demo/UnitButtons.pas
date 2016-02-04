unit UnitButtons;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, 
  sPanel, ExtCtrls, sFrameAdapter, Menus, sButton, sColorSelect, StdCtrls, Buttons, 
  sBitBtn, sSpeedButton, ComCtrls, ToolWin, sToolBar, sComboBox, sGroupBox,
  sTrackBar, sLabel, sCheckBox, acCoolBar;

type
  TFrameButtons = class(TFrame)
    sFrameAdapter1: TsFrameAdapter;
    sBitBtn3: TsBitBtn;
    sComboBox2: TsComboBox;
    sBitBtn8: TsBitBtn;
    sGroupBox2: TsGroupBox;
    sCheckBox1: TsCheckBox;
    sTrackBar1: TsTrackBar;
    sLabel1: TsLabel;
    sBitBtn4: TsBitBtn;
    sCheckBox2: TsCheckBox;
    sLabel2: TsLabel;
    sPanel2: TsPanel;
    sSpeedButton1: TsSpeedButton;
    sBitBtn1: TsBitBtn;
    sButton1: TsButton;
    sBitBtn6: TsBitBtn;
    sTrackBar2: TsTrackBar;
    sLabel3: TsLabel;
    sLabel4: TsLabel;
    sComboBox4: TsComboBox;
    PopupMenu1: TPopupMenu;
    Item11: TMenuItem;
    Item21: TMenuItem;
    Item31: TMenuItem;
    Item41: TMenuItem;
    Subitem411: TMenuItem;
    Subitem421: TMenuItem;
    Subitem431: TMenuItem;
    Subitem441: TMenuItem;
    Subitem451: TMenuItem;
    Subitem461: TMenuItem;
    Subitem471: TMenuItem;
    sCoolBar1: TsCoolBar;
    sToolBar2: TsToolBar;
    ToolButton1: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton8: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    sToolBar1: TsToolBar;
    ToolButton2: TToolButton;
    ToolButton10: TToolButton;
    ToolButton12: TToolButton;
    sBitBtn2: TsBitBtn;
    sTrackBar3: TsTrackBar;
    sLabel5: TsLabel;
    sLabel6: TsLabel;
    sSpeedButton2: TsSpeedButton;
    sBitBtn5: TsBitBtn;
    sLabel7: TsLabel;
    sCheckBox3: TsCheckBox;
    procedure sComboBox2Change(Sender: TObject);
    procedure sTrackBar1Change(Sender: TObject);
    procedure sCheckBox1Click(Sender: TObject);
    procedure sCheckBox2Click(Sender: TObject);
    procedure sComboBox4Change(Sender: TObject);
    procedure sTrackBar2Change(Sender: TObject);
    procedure sTrackBar3Change(Sender: TObject);
    procedure sBitBtn3Click(Sender: TObject);
    procedure sCheckBox3Click(Sender: TObject);
  end;

implementation

uses MainUnit, sVclUtils, sCommonData, acntUtils, sDialogs;

{$R *.DFM}

procedure TFrameButtons.sComboBox2Change(Sender: TObject);
begin
  sCoolBar1.SkinData.SkinSection := sComboBox2.Text;
  sPanel2.SkinData.SkinSection := sComboBox2.Text;
end;

procedure TFrameButtons.sTrackBar1Change(Sender: TObject);
var
  i : integer;
begin
  sLabel2.Caption := IntToStr(sTrackBar1.Position);
  for i := 0 to ComponentCount -1 do begin
    if Components[i] is TsBitBtn then TsBitBtn(Components[i]).Blend := sTrackBar1.Position;
    if Components[i] is TsSpeedButton then TsSpeedButton(Components[i]).Blend := sTrackBar1.Position;
  end;
  for i := 0 to Parent.ComponentCount -1 do with Parent do if Components[i] is TsSpeedButton
    then TsSpeedButton(Components[i]).Blend := sTrackBar1.Position;
end;

procedure TFrameButtons.sCheckBox1Click(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to ComponentCount -1 do begin
    if Components[i] is TsBitBtn then TsBitBtn(Components[i]).Grayed := sCheckBox1.Checked;
    if Components[i] is TsSpeedButton then TsSpeedButton(Components[i]).Grayed := sCheckBox1.Checked;
  end;
  for i := 0 to Parent.ComponentCount -1 do with Parent do if Components[i] is TsSpeedButton
    then TsSpeedButton(Components[i]).Grayed := sCheckBox1.Checked;
end;

procedure TFrameButtons.sCheckBox2Click(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to ComponentCount -1 do begin
    if Components[i] is TsButton then TsButton(Components[i]).Reflected := sCheckBox2.Checked;
    if Components[i] is TsBitBtn then TsBitBtn(Components[i]).Reflected := sCheckBox2.Checked;
    if Components[i] is TsSpeedButton then TsSpeedButton(Components[i]).Reflected := sCheckBox2.Checked;
  end;
  for i := 0 to Parent.ComponentCount -1 do with Parent do if Components[i] is TsSpeedButton
    then TsSpeedButton(Components[i]).Reflected := sCheckBox2.Checked;
end;

procedure TFrameButtons.sComboBox4Change(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to sPanel2.ControlCount -1 do {if sComboBox4.Parent.Controls[i] is TButton then } TrySetSkinSection(sPanel2.Controls[i], sComboBox4.Text);
end;

procedure TFrameButtons.sTrackBar2Change(Sender: TObject);
begin
  sLabel3.Caption := IntToStr(sTrackBar2.Position);
  MainForm.ImageList32.AcBeginUpdate;
  MainForm.ImageList32.Width := sTrackBar2.Position;
  MainForm.ImageList32.Height := sTrackBar2.Position;
  MainForm.ImageList32.AcEndUpdate(True);

  MainForm.ImgList_MultiState.AcBeginUpdate;
  MainForm.ImgList_MultiState.Width := sTrackBar2.Position * 2;
  MainForm.ImgList_MultiState.Height := sTrackBar2.Position;
  MainForm.ImgList_MultiState.AcEndUpdate(True);
end;

procedure TFrameButtons.sTrackBar3Change(Sender: TObject);
var
  i : integer;
  sd : TsCommonData;
begin
  sLabel6.Caption := IntToStr(sTrackBar3.Position);
  for i := 0 to sPanel2.ControlCount - 1 do begin
    if HasProperty(sPanel2.Controls[i], 'SkinData') then sd := TsCommonData(GetObjProp(sPanel2.Controls[i], 'SkinData')) else sd := nil;
    if (sd <> nil) then sd.HUEOffset := sTrackBar3.Position;
  end;
end;

procedure TFrameButtons.sBitBtn3Click(Sender: TObject);
begin
  if sMessageDlg('Exit this demo?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then MainForm.Close;
end;

procedure TFrameButtons.sCheckBox3Click(Sender: TObject);
begin
  sToolBar1.Flat := sCheckBox3.Checked;
  sToolBar2.Flat := sCheckBox3.Checked;
end;

end.
