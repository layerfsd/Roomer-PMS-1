unit UnitPanels;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, 
  sSplitter, sPanel, sMonthCalendar, ExtCtrls, sGroupBox, sFrameAdapter, StdCtrls, sButton,
  ComCtrls, sStatusBar, sComboBox;

type
  TFramePanels = class(TFrame)
    sFrameAdapter1: TsFrameAdapter;
    sPanel5: TsPanel;
    sButton1: TsButton;
    sButton2: TsButton;
    sButton3: TsButton;
    sPanel1: TsPanel;
    sContainer2: TsPanel;
    sSplitter1: TsSplitter;
    sSplitter2: TsSplitter;
    sPanel2: TsPanel;
    sPanel6: TsPanel;
    sPanel7: TsPanel;
    sPanel3: TsPanel;
    sPanel4: TsPanel;
    sGroupBox1: TsGroupBox;
    sGroupBox2: TsGroupBox;
    sSplitter3: TsSplitter;
    sPanel8: TsPanel;
    sComboBox1: TsComboBox;
    sComboBox2: TsComboBox;
    procedure sButton1Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure sComboBox1Change(Sender: TObject);
    procedure sComboBox2Change(Sender: TObject);
  end;

implementation

{$R *.DFM}

uses sSkinProps;

procedure TFramePanels.sButton1Click(Sender: TObject);
begin
  sPanel5.SkinData.SkinSection := s_PanelLow
end;

procedure TFramePanels.sButton2Click(Sender: TObject);
begin
  sPanel5.SkinData.SkinSection := s_Panel
end;

procedure TFramePanels.sButton3Click(Sender: TObject);
begin
  sPanel5.SkinData.SkinSection := s_GroupBox
end;

procedure TFramePanels.sComboBox1Change(Sender: TObject);
begin
  sPanel3.SkinData.SkinSection := sComboBox1.Text;
  sGroupBox2.SkinData.SkinSection := sComboBox1.Text;
end;

procedure TFramePanels.sComboBox2Change(Sender: TObject);
begin
  sGroupBox2.CaptionSkin := sComboBox2.Text;
  sGroupBox1.CaptionSkin := sComboBox2.Text;

end;

end.
