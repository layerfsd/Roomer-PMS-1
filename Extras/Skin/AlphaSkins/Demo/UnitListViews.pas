unit UnitListViews;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  sRadioButton, ExtCtrls, sPanel, sGroupBox, ComCtrls, sListView, sFrameAdapter, StdCtrls,
  sComboBox, sButton, Buttons, sSpeedButton, sCheckBox;

type
  TFrameListViews = class(TFrame)
    sListView1: TsListView;
    sGroupBox10: TsGroupBox;
    sRadioButton21: TsRadioButton;
    sRadioButton22: TsRadioButton;
    sRadioButton23: TsRadioButton;
    sRadioButton24: TsRadioButton;
    sFrameAdapter1: TsFrameAdapter;
    sButton1: TsButton;
    sCheckBox1: TsCheckBox;
    sCheckBox2: TsCheckBox;
    sCheckBox3: TsCheckBox;
    sCheckBox4: TsCheckBox;
    procedure sRadioButton21Change(Sender: TObject);
    procedure sRadioButton22Change(Sender: TObject);
    procedure sRadioButton23Change(Sender: TObject);
    procedure sRadioButton24Change(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure sCheckBox1Click(Sender: TObject);
    procedure sCheckBox2Click(Sender: TObject);
    procedure sCheckBox3Click(Sender: TObject);
    procedure sCheckBox4Click(Sender: TObject);
  end;

implementation

uses MainUnit;

{$R *.DFM}

procedure TFrameListViews.sRadioButton21Change(Sender: TObject);
begin
  sListView1.ViewStyle := vsIcon;
end;

procedure TFrameListViews.sRadioButton22Change(Sender: TObject);
begin
  sListView1.ViewStyle := vsList;
end;

procedure TFrameListViews.sRadioButton23Change(Sender: TObject);
begin
  sListView1.ViewStyle := vsReport;
end;

procedure TFrameListViews.sRadioButton24Change(Sender: TObject);
begin
  sListView1.ViewStyle := vsSmallIcon;
end;

procedure TFrameListViews.sButton1Click(Sender: TObject);
var
  i, l : integer;
begin
  sListView1.SkinData.BeginUpdate; // Disable an updating of skinned scrolls
  sListView1.Items.BeginUpdate;
  l := sListView1.Items.Count;
  for i := l + 1 to l + 200 do with sListView1.Items.Add do begin
    Caption := 'Item ' + IntToStr(i);
    ImageIndex := Random(sListView1.SmallImages.Count - 1);
    SubItems.Add('SubItem 1');
    SubItems.Add('SubItem 2');
    SubItemImages[0] := Random(sListView1.SmallImages.Count - 1);
  end;
  sListView1.Items.EndUpdate;
  sListView1.SkinData.EndUpdate;
end;

procedure TFrameListViews.sCheckBox1Click(Sender: TObject);
begin
  if sCheckBox1.Checked then begin
    sListView1.SmallImages := MainForm.ImageList16;
    sListView1.LargeImages := MainForm.ImageList32;
  end
  else begin
    sListView1.SmallImages := nil;
    sListView1.LargeImages := nil;
  end;
end;

procedure TFrameListViews.sCheckBox2Click(Sender: TObject);
begin
  sListView1.Checkboxes := sCheckBox2.Checked;
end;

procedure TFrameListViews.sCheckBox3Click(Sender: TObject);
begin
  sListView1.GridLines := sCheckBox3.Checked;
end;

procedure TFrameListViews.sCheckBox4Click(Sender: TObject);
begin
  sListView1.RowSelect := sCheckBox4.Checked;
end;

end.
