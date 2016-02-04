unit FrameFrameBar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  sFrameAdapter, ExtCtrls, sPanel, sScrollBox, StdCtrls,
  sLabel, ComCtrls, sTrackBar, sCheckBox, Buttons, sSpeedButton, sGroupBox,
  sComboBox, sFrameBar, sButton;

type
  TFrameBar = class(TFrame)
    sFrameAdapter1: TsFrameAdapter;
    sFrameBar1: TsFrameBar;
    sPanel1: TsPanel;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sSpeedButton1: TsSpeedButton;
    sTrackBar1: TsTrackBar;
    sTrackBar2: TsTrackBar;
    sGroupBox1: TsGroupBox;
    sComboBox1: TsComboBox;
    sComboBox2: TsComboBox;
    sComboBox3: TsComboBox;
    sCheckBox1: TsCheckBox;
    sCheckBox2: TsCheckBox;
    sGroupBox2: TsGroupBox;
    sCheckBox3: TsCheckBox;
    BarSpeedButton: TsSpeedButton;
    sButton1: TsButton;
    procedure sTrackBar1Change(Sender: TObject);
    procedure sTrackBar2Change(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
    procedure sFrameBar1Items0CreateFrame(Sender: TObject; var Frame: TCustomFrame);
    procedure sComboBox1Change(Sender: TObject);
    procedure sComboBox2Change(Sender: TObject);
    procedure sComboBox3Change(Sender: TObject);
    procedure sCheckBox2Click(Sender: TObject);
    procedure sCheckBox1Click(Sender: TObject);
    procedure sCheckBox3Click(Sender: TObject);
    procedure sSpeedButton2Click(Sender: TObject);
    procedure sSpeedButton2MouseEnter(Sender: TObject);
    procedure sFrameBar1MouseLeave(Sender: TObject);
    procedure showFrameBar(AVisible : boolean);
    procedure sButton1Click(Sender: TObject);
  end;

implementation

uses UnitFrameDemo, sVclUtils, sSkinProps;

{$R *.DFM}

procedure TFrameBar.sTrackBar1Change(Sender: TObject);
begin
  sFrameBar1.BorderWidth := sTrackBar1.Position;
end;

procedure TFrameBar.sTrackBar2Change(Sender: TObject);
begin
  sFrameBar1.TitleHeight := sTrackBar2.Position;
end;

procedure TFrameBar.sSpeedButton1Click(Sender: TObject);
begin
  sFrameBar1.Animation := sSpeedButton1.Down;
end;

procedure TFrameBar.sFrameBar1Items0CreateFrame(Sender: TObject; var Frame: TCustomFrame);
begin
  Frame := TFrameDemo.Create(nil);
  if sComboBox3.ItemIndex > -1 then TFrameDemo(Frame).sFrameAdapter1.SkinData.SkinSection := sComboBox3.Text;
end;

procedure TFrameBar.sComboBox1Change(Sender: TObject);
begin
  sFrameBar1.SkinData.SkinSection := sComboBox1.Text;
end;

procedure TFrameBar.sComboBox2Change(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to sFrameBar1.Items.Count - 1 do
    sFrameBar1.Items[i].SkinSection := sComboBox2.Text;
end;

procedure TFrameBar.sComboBox3Change(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to sFrameBar1.Items.Count - 1 do
    if (sFrameBar1.Items[i].Frame <> nil) //and not sFrameBar1.Items[i].Closing
      then TFrameDemo(sFrameBar1.Items[i].Frame).sFrameAdapter1.SkinData.SkinSection := sComboBox3.Text;
end;

procedure TFrameBar.sCheckBox2Click(Sender: TObject);
begin
  sFrameBar1.AllowAllOpen := sCheckBox2.Checked;
end;

procedure TFrameBar.sCheckBox1Click(Sender: TObject);
begin
  sFrameBar1.AllowAllClose := sCheckBox1.Checked;
end;

// Hide / Open frame bar
var
  AutoHidingEnabled : boolean = False;
const
  sCloseBar = '<'#13#10'<'#13#10'<'#13#10'<'#13#10'<'#13#10; // Text may be replaced by glyphs
  sOpenBar = '>'#13#10'>'#13#10'>'#13#10'>'#13#10'>'#13#10;

procedure TFrameBar.sCheckBox3Click(Sender: TObject);
begin
  AutoHidingEnabled := sCheckBox3.Checked;
  if AutoHidingEnabled then begin
    if sFrameBar1.Visible then ShowFrameBar(False);
  end;
end;

procedure TFrameBar.sSpeedButton2Click(Sender: TObject);
begin
  ShowFrameBar(not sFrameBar1.Visible);
end;

procedure TFrameBar.sSpeedButton2MouseEnter(Sender: TObject);
begin
  if not sFrameBar1.Visible and AutoHidingEnabled then ShowFrameBar(True);
end;

procedure TFrameBar.sFrameBar1MouseLeave(Sender: TObject);
var
  R : TRect;
begin
  if AutoHidingEnabled then begin
    GetWindowRect(sFrameBar1.Handle, R);
    if not PtInRect(R, Mouse.CursorPos) then ShowFrameBar(False);
  end
end;

procedure TFrameBar.showFrameBar(AVisible: boolean);
begin
  SendMessage(Self.Handle, WM_SETREDRAW, 0, 0);                   // Antiblinking
  sFrameBar1.Left := BarSpeedButton.Left;                         // FrameBar must be left always
  BarSpeedButton.Visible := not (AVisible and AutoHidingEnabled);
  sFrameBar1.Visible := AVisible;
  if BarSpeedButton.Visible then begin
    if AVisible then begin
      BarSpeedButton.Caption := sCloseBar
    end
    else begin
      BarSpeedButton.Caption := sOpenBar;
    end;
  end;
  SendMessage(Self.Handle, WM_SETREDRAW, 1, 0);
  RedrawWindow(Self.Handle, nil, 0, RDW_ALLCHILDREN or RDW_ERASE or RDW_INVALIDATE);
end;

procedure TFrameBar.sButton1Click(Sender: TObject);
begin
  with sFrameBar1.Items.Add as TsTitleItem do begin
    Caption := 'New item';
    OnCreateFrame := sFrameBar1Items0CreateFrame;
    ImageIndex := 8;
  end;
end;

end.
