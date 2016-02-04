unit UnitScrolls;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  sScrollBar, sGauge, sTrackBar, sFrameAdapter, ComCtrls, StdCtrls,
  sComboBox, acProgressBar, sRadioButton, sCheckBox, sEdit;

type
  TFrameScrolls = class(TFrame)
    sGauge1: TsGauge;
    sTrackBar1: TsTrackBar;
    sScrollBar1: TsScrollBar;
    sScrollBar3: TsScrollBar;
    sGauge2: TsGauge;
    sComboBox1: TsComboBox;
    sComboBox2: TsComboBox;
    sProgressBar1: TsProgressBar;
    sTrackBar2: TsTrackBar;
    sProgressBar2: TsProgressBar;
    sFrameAdapter1: TsFrameAdapter;
    sRadioButton1: TsRadioButton;
    sRadioButton2: TsRadioButton;
    sCheckBox1: TsCheckBox;
    sCheckBox2: TsCheckBox;
    sEdit1: TsEdit;
    sCheckBox3: TsCheckBox;
    procedure sScrollBar2Change(Sender: TObject);
    procedure sTrackBar1Change(Sender: TObject);
    procedure sComboBox2Change(Sender: TObject);
    procedure sComboBox1Change(Sender: TObject);
    procedure sRadioButton1Click(Sender: TObject);
    procedure sRadioButton2Click(Sender: TObject);
    procedure sCheckBox1Click(Sender: TObject);
    procedure sCheckBox2Click(Sender: TObject);
    procedure sEdit1Change(Sender: TObject);
    procedure sCheckBox3Click(Sender: TObject);
  end;

implementation

uses MainUnit, acPNG;

{$R *.DFM}

procedure TFrameScrolls.sScrollBar2Change(Sender: TObject);
begin
  if csLoading in TComponent(Sender).ComponentState then Exit;
  sGauge1.Progress := TsScrollBar(Sender).Position;
  if Sender = sScrollBar1 then sScrollBar3.Position := sGauge1.Progress else
  if Sender = sScrollBar3 then sScrollBar1.Position := sGauge1.Progress;

  sTrackBar1.Position  := sGauge1.Progress;
  sTrackBar2.Position  := sGauge1.Progress;

  sProgressBar1.Position := sGauge1.Progress;
  sProgressBar2.Position := sGauge1.Progress;
  sGauge2.Progress := sGauge1.Progress;
  Mainform.sGauge3.Progress := sGauge1.Progress;
end;

procedure TFrameScrolls.sTrackBar1Change(Sender: TObject);
begin
  if csLoading in TComponent(Sender).ComponentState then Exit;
  if (Sender is TsTrackBar) then sGauge1.Progress := TsTrackBar(Sender).Position;
  sTrackBar1.Position  := sGauge1.Progress;
  sTrackBar2.Position  := sGauge1.Progress;
  sScrollBar1.Position := sGauge1.Progress;
  sScrollBar3.Position := sGauge1.Progress;
  sProgressBar1.Position := sGauge1.Progress;
  sProgressBar2.Position := sGauge1.Progress;
  sGauge2.Progress := sGauge1.Progress;
  Mainform.sGauge3.Progress := sGauge1.Progress;
end;

procedure TFrameScrolls.sComboBox2Change(Sender: TObject);
begin
  sGauge1.ProgressSkin := sComboBox2.Text;
  sGauge2.ProgressSkin := sComboBox2.Text;
  sProgressBar1.ProgressSkin := sComboBox2.Text;
  sProgressBar2.ProgressSkin := sComboBox2.Text;
end;

procedure TFrameScrolls.sComboBox1Change(Sender: TObject);
begin
  sGauge1.Skindata.SkinSection := sComboBox1.Text;
  sGauge2.Skindata.SkinSection := sComboBox1.Text;
  sProgressBar1.Skindata.SkinSection := sComboBox1.Text;
  sProgressBar2.Skindata.SkinSection := sComboBox1.Text;
end;

procedure TFrameScrolls.sRadioButton1Click(Sender: TObject);
begin
  sProgressBar1.Style := pbstNormal
end;

procedure TFrameScrolls.sRadioButton2Click(Sender: TObject);
begin
  sProgressBar1.Style := pbstMarquee
end;

procedure TFrameScrolls.sCheckBox1Click(Sender: TObject);
begin
  sGauge1.Animated := sCheckBox1.Checked;
  sGauge2.Animated := sCheckBox1.Checked;
end;

procedure TFrameScrolls.sCheckBox2Click(Sender: TObject);
begin
  sGauge1.ShowText := sCheckBox2.Checked;
  sGauge2.ShowText := sCheckBox2.Checked;
end;

procedure TFrameScrolls.sEdit1Change(Sender: TObject);
begin
  sGauge1.Suffix := sEdit1.Text;
end;

procedure TFrameScrolls.sCheckBox3Click(Sender: TObject);
var
  Png : TPNGGraphic;
begin
  if sCheckBox3.Checked then begin
    // Load PNG image from AlphaImageList component
    if (MainForm.ImageList16.Items[0].ImgData <> nil) and (MainForm.ImageList16.Items[0].ImgData.Size > 0) then begin
      Png := TPNGGraphic.Create;
      MainForm.ImageList16.Items[0].ImgData.Seek(0, 0);
      Png.LoadFromStream(MainForm.ImageList16.Items[0].ImgData);
      sTrackBar1.ThumbGlyph := Png;
      sTrackBar2.ThumbGlyph := Png;
      Png.Free;
    end;
  end
  else begin
    sTrackBar1.ThumbGlyph.Assign(nil);
    sTrackBar1.Repaint;
    sTrackBar2.ThumbGlyph.Assign(nil);
    sTrackBar2.Repaint;
  end;
end;

end.
