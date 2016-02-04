unit UnitMultiSkin;

interface

{$WARN SYMBOL_PLATFORM OFF}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ComCtrls, sStatusBar, StdCtrls, sGroupBox, ExtCtrls, sPanel,
  sSkinProvider, sSkinManager, sListBox, sButton, Buttons, sBitBtn, sLabel, FileCtrl;

type
  TFormMultiSkin = class(TForm)
    sSkinManager1: TsSkinManager;
    sSkinManager2: TsSkinManager;
    sSkinProvider1: TsSkinProvider;
    sPanel1: TsPanel;
    sStatusBar1: TsStatusBar;
    sButton1: TsButton;
    sButton2: TsButton;
    sListBox1: TsListBox;
    sPanel2: TsPanel;
    sButton4: TsButton;
    sButton5: TsButton;
    sListBox2: TsListBox;
    sStatusBar2: TsStatusBar;
    sStatusBar3: TsStatusBar;
    sBitBtn1: TsBitBtn;
    sBitBtn2: TsBitBtn;
    sLabelFX1: TsLabelFX;
    procedure FormCreate(Sender: TObject);
    procedure sListBox1Click(Sender: TObject);
  end;

var
  FormMultiSkin: TFormMultiSkin;

implementation

uses MainUnit;

{$R *.DFM}

procedure TFormMultiSkin.FormCreate(Sender: TObject);
begin
  if DirectoryExists(MainForm.sSkinManager1.SkinDirectory) then begin
    sSkinManager1.SkinDirectory := MainForm.sSkinManager1.SkinDirectory;
    sSkinManager1.GetSkinNames(sListBox1.Items);
    sSkinManager2.SkinDirectory := MainForm.sSkinManager1.SkinDirectory;
    sSkinManager2.GetSkinNames(sListBox2.Items);
  end;
  sLabelFX1.Visible := sListBox1.Items.Count < 1;
end;

procedure TFormMultiSkin.sListBox1Click(Sender: TObject);
begin
  TsListBox(Sender).SkinData.SkinManager.SkinName := TsListBox(Sender).Items[TsListBox(Sender).ItemIndex];
  TsListBox(Sender).SkinData.SkinManager.Active := True;
end;

end.
