unit UnitSkinManager;

interface

uses 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  sFrameAdapter, StdCtrls, sLabel, Buttons, sSpeedButton;

type
  TFrameSkinManager = class(TFrame)
    sFrameAdapter1: TsFrameAdapter;
    sLabelFX1: TsLabelFX;
    sLabelFX2: TsLabelFX;
    sLabelFX3: TsLabelFX;
    sSpeedButton1: TsSpeedButton;
    procedure sSpeedButton1Click(Sender: TObject);
  public
    procedure CloseBtnClick(Sender: TObject);
    procedure SkinsListBoxClick(Sender: TObject);
  end;

implementation

uses sSkinProvider, sSKinManager, sBitBtn, sSkinProps, sListBox, UnitMultiSkin, MainUnit;

{$R *.DFM}

procedure TFrameSkinManager.CloseBtnClick(Sender: TObject);
begin
  TForm(TsBitBtn(Sender).Parent).Close;
end;

procedure TFrameSkinManager.SkinsListBoxClick(Sender: TObject);
begin
  with TsListBox(Sender) do begin
  if SkinData.SkinManager.SkinName <> Items[ItemIndex] then begin
    SkinData.SkinManager.SkinName := Items[ItemIndex];
  end;
  end;
end;

procedure TFrameSkinManager.sSpeedButton1Click(Sender: TObject);
begin
  Application.CreateForm(TFormMultiSkin, FormMultiSkin);
  FormMultiSkin.ShowModal;
  if FormMultiSkin.sLabelFX1.Visible then MainForm.sSkinManager1.UpdateSkin;
  FreeAndNil(FormMultiSkin);
end;

end.
