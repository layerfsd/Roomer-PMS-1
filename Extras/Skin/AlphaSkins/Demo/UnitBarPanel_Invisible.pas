unit UnitBarPanel_Invisible;

interface

uses 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  sFrameAdapter, Buttons, sSpeedButton, StdCtrls, sGroupBox;

type
  TBarPanel_Invisible = class(TFrame)
    sFrameAdapter1: TsFrameAdapter;
    sBitBtn3: TsSpeedButton;
    sBitBtn4: TsSpeedButton;
    sSpeedButton3: TsSpeedButton;
    sSpeedButton1: TsSpeedButton;
    sBitBtn1: TsSpeedButton;
    procedure sBitBtn1Click(Sender: TObject);
    procedure sBitBtn3Click(Sender: TObject);
    procedure sSpeedButton3Click(Sender: TObject);
    procedure sBitBtn4Click(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
  end;

implementation

uses UnitFrames, UnitFrameDialogs, UnitHints,
  UnitSkinManager, MainUnit, UnitForms, UnitStdVCL;

{$R *.DFM}

procedure TBarPanel_Invisible.sBitBtn1Click(Sender: TObject);
begin
  if Assigned(CurrentFrame) then OldFrame := CurrentFrame;
  if OldFrame is TFrameForms then FreeAndNil(OldFrame);
  CurrentFrame := TFrameForms.Create(MainForm);
  MainForm.UpdateFrame(Sender);
end;

procedure TBarPanel_Invisible.sBitBtn3Click(Sender: TObject);
begin
  if Assigned(CurrentFrame) then OldFrame := CurrentFrame;
  if OldFrame is TFrameFrames then FreeAndNil(OldFrame);
  CurrentFrame := TFrameFrames.Create(MainForm);
  MainForm.UpdateFrame(Sender);
end;

procedure TBarPanel_Invisible.sSpeedButton3Click(Sender: TObject);
begin
  if Assigned(CurrentFrame) then OldFrame := CurrentFrame;
  if OldFrame is TFrameDialogs then FreeAndNil(OldFrame);
  CurrentFrame := TFrameDialogs.Create(MainForm);
  MainForm.UpdateFrame(Sender);
end;

procedure TBarPanel_Invisible.sBitBtn4Click(Sender: TObject);
begin
  if Assigned(CurrentFrame) then OldFrame := CurrentFrame;
  if OldFrame is TFrameHints then FreeAndNil(OldFrame);
  CurrentFrame := TFrameHints.Create(MainForm);
  MainForm.UpdateFrame(Sender);
end;

procedure TBarPanel_Invisible.sSpeedButton1Click(Sender: TObject);
begin
  if Assigned(CurrentFrame) then OldFrame := CurrentFrame;
  if OldFrame is TFrameSkinManager then FreeAndNil(OldFrame);
  CurrentFrame := TFrameSkinManager.Create(MainForm);
  MainForm.UpdateFrame(Sender);
end;

end.
