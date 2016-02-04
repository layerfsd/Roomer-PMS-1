unit UnitBarPanel_Visible;

interface

uses 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  sFrameAdapter, Buttons, sSpeedButton, sScrollBox;

type
  TBarPanel_Visible = class(TFrame)
    sFrameAdapter1: TsFrameAdapter;
    sSpeedButton5: TsSpeedButton;
    sSpeedButton4: TsSpeedButton;
    sSpeedButton3: TsSpeedButton;
    sSpeedButton2: TsSpeedButton;
    sSpeedButton1: TsSpeedButton;
    sBitBtn9: TsSpeedButton;
    sBitBtn8: TsSpeedButton;
    sBitBtn5: TsSpeedButton;
    sBitBtn4: TsSpeedButton;
    sBitBtn3: TsSpeedButton;
    sBitBtn2: TsSpeedButton;
    sBitBtn1: TsSpeedButton;
    sSpeedButton6: TsSpeedButton;
    procedure sBitBtn1Click(Sender: TObject);
    procedure sBitBtn2Click(Sender: TObject);
    procedure sBitBtn3Click(Sender: TObject);
    procedure sBitBtn4Click(Sender: TObject);
    procedure sBitBtn5Click(Sender: TObject);
    procedure sBitBtn8Click(Sender: TObject);
    procedure sBitBtn9Click(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
    procedure sSpeedButton2Click(Sender: TObject);
    procedure sSpeedButton3Click(Sender: TObject);
    procedure sSpeedButton4Click(Sender: TObject);
    procedure sSpeedButton5Click(Sender: TObject);
    procedure sSpeedButton6Click(Sender: TObject);
  end;

implementation

uses UnitEditors, UnitPanels, UnitCheckBoxes, UnitScrolls, UnitButtons, UnitScrollBoxes, 
  MainUnit, UnitTabControls, UnitStdVCL, UnitEditorsAdd, FrameFrameBar, UnitOtherAdd, UnitShellCtrls,
  UnitListViews;

{$R *.DFM}

procedure TBarPanel_Visible.sBitBtn1Click(Sender: TObject);
begin
  if Assigned(CurrentFrame) then OldFrame := CurrentFrame;
  if OldFrame is TFrameEditors then FreeAndNil(OldFrame);
  CurrentFrame := TFrameEditors.Create(MainForm);
  Mainform.UpdateFrame(Sender);
end;

procedure TBarPanel_Visible.sBitBtn2Click(Sender: TObject);
begin
  if Assigned(CurrentFrame) then OldFrame := CurrentFrame;
  if OldFrame is TFramePanels then FreeAndNil(OldFrame);
  CurrentFrame := TFramePanels.Create(MainForm);
  Mainform.UpdateFrame(Sender);
end;

procedure TBarPanel_Visible.sBitBtn3Click(Sender: TObject);
begin
  if Assigned(CurrentFrame) then OldFrame := CurrentFrame;
  if OldFrame is TFrameCheckBoxes then FreeAndNil(OldFrame);
  CurrentFrame := TFrameCheckBoxes.Create(MainForm);
  Mainform.UpdateFrame(Sender);
end;

procedure TBarPanel_Visible.sBitBtn4Click(Sender: TObject);
begin
  if Assigned(CurrentFrame) then OldFrame := CurrentFrame;
  if OldFrame is TFrameScrolls then FreeAndNil(OldFrame);
  CurrentFrame := TFrameScrolls.Create(MainForm);
  Mainform.UpdateFrame(Sender);
end;

procedure TBarPanel_Visible.sBitBtn5Click(Sender: TObject);
begin
  if Assigned(CurrentFrame) then OldFrame := CurrentFrame;
  if OldFrame is TFrameButtons then FreeAndNil(OldFrame);
  CurrentFrame := TFrameButtons.Create(MainForm);
  TFrameButtons(CurrentFrame).sToolBar1.Flat := True;
  TFrameButtons(CurrentFrame).sToolBar2.Flat := True;
  Mainform.UpdateFrame(Sender);
end;

procedure TBarPanel_Visible.sBitBtn8Click(Sender: TObject);
begin
  if Assigned(CurrentFrame) then OldFrame := CurrentFrame;
  if OldFrame is TFrameScrollBoxes then FreeAndNil(OldFrame);
  CurrentFrame := TFrameScrollBoxes.Create(MainForm);
  Mainform.UpdateFrame(Sender);
end;

procedure TBarPanel_Visible.sBitBtn9Click(Sender: TObject);
begin
  if Assigned(CurrentFrame) then OldFrame := CurrentFrame;
  if OldFrame is TFrameTabControls then FreeAndNil(OldFrame);
  CurrentFrame := TFrameTabControls.Create(MainForm);
  Mainform.UpdateFrame(Sender);
end;

procedure TBarPanel_Visible.sSpeedButton1Click(Sender: TObject);
begin
  if Assigned(CurrentFrame) then OldFrame := CurrentFrame;
  if OldFrame is TFrameEditorsAdd then FreeAndNil(OldFrame);
  CurrentFrame := TFrameEditorsAdd.Create(MainForm);
try
  Mainform.UpdateFrame(Sender);
except
end;
end;

procedure TBarPanel_Visible.sSpeedButton2Click(Sender: TObject);
begin
  if Assigned(CurrentFrame) then OldFrame := CurrentFrame;
  if OldFrame is TFrameBar then FreeAndNil(OldFrame);
  CurrentFrame := TFrameBar.Create(MainForm);
  Mainform.UpdateFrame(Sender);
end;

procedure TBarPanel_Visible.sSpeedButton3Click(Sender: TObject);
begin
  if Assigned(CurrentFrame) then OldFrame := CurrentFrame;
  if OldFrame is TFrameOtherAdd then FreeAndNil(OldFrame);
  CurrentFrame := TFrameOtherAdd.Create(MainForm);
  Mainform.UpdateFrame(Sender);
end;

procedure TBarPanel_Visible.sSpeedButton4Click(Sender: TObject);
begin
  if Assigned(CurrentFrame) then OldFrame := CurrentFrame;
  if OldFrame is TFrameListViews then FreeAndNil(OldFrame);
  CurrentFrame := TFrameListViews.Create(MainForm);
  Mainform.UpdateFrame(Sender);
end;

procedure TBarPanel_Visible.sSpeedButton5Click(Sender: TObject);
begin
  if Assigned(CurrentFrame) then OldFrame := CurrentFrame;
  if OldFrame is TFrameShellControls then FreeAndNil(OldFrame);
  CurrentFrame := TFrameShellControls.Create(MainForm);
  Mainform.UpdateFrame(Sender);
end;

procedure TBarPanel_Visible.sSpeedButton6Click(Sender: TObject);
var
  x, y : integer;
begin
  if Assigned(CurrentFrame) then OldFrame := CurrentFrame;
  if OldFrame is TFrameStdVCL then FreeAndNil(OldFrame);
  CurrentFrame := TFrameStdVCL.Create(MainForm);
  for x := 0 to TFrameStdVCL(CurrentFrame).StringGrid1.ColCount - 1 do
    for y := 0 to TFrameStdVCL(CurrentFrame).StringGrid1.RowCount - 1 do
      TFrameStdVCL(CurrentFrame).StringGrid1.Cells[x, y] := 'Cell ' + IntToStr(x) + ':' + IntToStr(y);
  MainForm.UpdateFrame(Sender);
end;

end.
