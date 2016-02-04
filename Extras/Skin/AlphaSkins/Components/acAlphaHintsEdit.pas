unit acAlphaHintsEdit;
{$I sDefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ComCtrls, ImgList, 
  {$IFDEF DELPHI6UP} Variants, {$ENDIF}
  acAlphaHints, sListBox, sBitBtn, sSpeedButton, sEdit, sPageControl, sLabel, sCheckBox, sGroupBox, sSkinProvider, acAlphaImageList,
  acHintPage, sRadioButton, ExtCtrls, sPanel;


type
  TAlphaHintsEdit = class(TForm)
    sBitBtn1: TsBitBtn;
    sBitBtn2: TsBitBtn;
    sPageControl1: TsPageControl;
    sTabSheet1: TsTabSheet;
    sTabSheet2: TsTabSheet;
    sTabSheet3: TsTabSheet;
    sTabSheet4: TsTabSheet;
    sCheckBox1: TsCheckBox;
    FrameTL: TFrameHintPage;
    Hints: TsAlphaHints;
    sGroupBox1: TsGroupBox;
    sSpeedButton1: TsSpeedButton;
    sSpeedButton2: TsSpeedButton;
    sListBox1: TsListBox;
    sSkinProvider1: TsSkinProvider;
    sSpeedButton3: TsSpeedButton;
    FontDialog1: TFontDialog;
    sAlphaImageList1: TsAlphaImageList;
    sSpeedButton4: TsSpeedButton;
    sSpeedButton5: TsSpeedButton;
    sSpeedButton6: TsSpeedButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    sLabel1: TsLabel;
    sRadioButton1: TsRadioButton;
    sRadioButton2: TsRadioButton;
    procedure sCheckBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sListBox1Click(Sender: TObject);
    procedure sPageControl1Change(Sender: TObject);
    procedure sSpeedButton3Click(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
    procedure sSpeedButton2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FrameTLPaintBox1Paint(Sender: TObject);
    procedure sSpeedButton4Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sSpeedButton5Click(Sender: TObject);
    procedure sSpeedButton6Click(Sender: TObject);
    procedure FrameTLsSpeedButton3Click(Sender: TObject);
    procedure sRadioButton2Click(Sender: TObject);
    procedure sRadioButton1Click(Sender: TObject);
  public
    CurrentFrame: TFrameHintPage;
    procedure LoadTemplates;
    procedure InitTemplate(Index: integer);
    procedure UpdateFrame(Sender: TObject);
  end;


var
  AlphaHintsEdit: TAlphaHintsEdit;
  FrameTR: TFrameHintPage = nil;
  FrameBR: TFrameHintPage = nil;
  FrameBL: TFrameHintPage = nil;
  CurrentTemplate: TacHintTemplate;


function EditHints(acHints: TsAlphaHints): boolean;
procedure ChangeStates(Parent: TWinControl; Tag: integer; Enabled: boolean);


var
  PreviewBmp: TBitmap = nil;
  acInitializing: boolean = False;


implementation

uses
  sDialogs, sConst, acntUtils;

{$R *.dfm}

procedure ChangeStates(Parent: TWinControl; Tag: integer; Enabled: boolean);
var
  i: integer;
begin
  for i := 0 to Parent.ControlCount - 1 do begin
    if Parent.Controls[i].Tag = Tag then
      Parent.Controls[i].Enabled := Enabled;

    if Parent.Controls[i] is TWinControl then
      ChangeStates(TWinControl(Parent.Controls[i]), Tag, Enabled);
  end;
end;


function EditHints(acHints: TsAlphaHints): boolean;
begin
  Application.CreateForm(TAlphaHintsEdit, AlphaHintsEdit);
  AlphaHintsEdit.Hints.Assign(acHints);
  AlphaHintsEdit.LoadTemplates;
  AlphaHintsEdit.ShowModal;
  if AlphaHintsEdit.ModalResult = mrOk then begin
    acHints.Assign(AlphaHintsEdit.Hints);
    acHints.TemplateName := AlphaHintsEdit.Hints.TemplateName;
    FreeAndNil(AlphaHintsEdit);
    Result := True;
  end
  else begin
    FreeAndNil(AlphaHintsEdit);
    Result := False;
  end;
  // Init HintWindow
  acHints.Active := True;
  Manager := acHints;
  Application.OnShowHint := acHints.OnShowHintApp;
end;


procedure TAlphaHintsEdit.sCheckBox1Click(Sender: TObject);

  function CreateHintPage(AName: string; AParent: TsTabSheet; ATemplate: TacHintImage): TFrameHintPage;
  begin
    Result := TFrameHintPage.Create(Self);
    Result.Parent := AParent;
    Result.Left := 2;
    Result.Top := 2;
    Result.Name := AName;
    Result.LoadImage(ATemplate, False);
  end;

begin
  if sCheckBox1.Checked then begin
    if FrameTR = nil then
      FrameTR := CreateHintPage('FrameTR', sTabSheet2, CurrentTemplate.Img_RightTop);

    if FrameBL = nil then
      FrameBL := CreateHintPage('FrameBL', sTabSheet3, CurrentTemplate.Img_LeftBottom);

    if FrameBR = nil then
      FrameBR := CreateHintPage('FrameBR', sTabSheet4, CurrentTemplate.Img_RightBottom);

    ChangeStates(sPageControl1, 1, True);
  end
  else begin
    if FrameTR <> nil then
      FreeAndNil(FrameTR);

    if FrameBR <> nil then
      FreeAndNil(FrameBR);

    if FrameBL <> nil then
      FreeAndNil(FrameBL);
  end;
  sTabSheet2.TabVisible := sCheckBox1.Checked;
  sTabSheet3.TabVisible := sCheckBox1.Checked;
  sTabSheet4.TabVisible := sCheckBox1.Checked;
end;


procedure TAlphaHintsEdit.FormCreate(Sender: TObject);
begin
  FrameTR := nil;
  FrameBR := nil;
  FrameBL := nil;
  CurrentTemplate := nil;
  Hints.OnChange := UpdateFrame;
end;


procedure TAlphaHintsEdit.LoadTemplates;
var
  i, DefIndex: integer;
begin
  CurrentFrame := FrameTL;
  sListBox1.Clear;
  DefIndex := -1;
  for i := 0 to Hints.Templates.Count - 1 do begin
    sListBox1.Items.Add(Hints.Templates[i].Name);
    if (DefIndex = -1) and (Hints.Templates[i].Name = Hints.TemplateName) then
      DefIndex := i;
  end;
  if DefIndex <> -1 then begin
    sListBox1.ItemIndex := DefIndex;
    InitTemplate(DefIndex);
  end;
end;


procedure TAlphaHintsEdit.sListBox1Click(Sender: TObject);
begin
  inherited;
  if sListBox1.ItemIndex > -1 then
    InitTemplate(sListBox1.ItemIndex)
  else
    FrameTL.LoadImage(nil);
end;


procedure TAlphaHintsEdit.InitTemplate(Index: integer);
begin
  acInitializing := True;
  CurrentTemplate := Hints.Templates[Index];
  if FrameTR <> nil then
    FrameTR.LoadImage(CurrentTemplate.Img_RightTop);

  if FrameBR <> nil then
    FrameBR.LoadImage(CurrentTemplate.Img_RightBottom);

  if FrameBL <> nil then
    FrameBL.LoadImage(CurrentTemplate.Img_LeftBottom);

  FrameTL.LoadImage(CurrentTemplate.ImageDefault);
  with CurrentTemplate do
    if not (Img_LeftBottom.Image.Empty and (Img_LeftBottom.FImageData.Size = 0)) or
         not (Img_RightBottom.Image.Empty and (Img_RightBottom.FImageData.Size = 0)) or
           not (Img_RightTop.Image.Empty and (Img_RightTop.FImageData.Size = 0)) then
      sCheckBox1.Checked := True
    else
      sCheckBox1.Checked := False;

  if CurrentTemplate.HintAlign = haVertCenter then
    sRadioButton2.Checked := True
  else
    sRadioButton1.Checked := True;

  ChangeStates(Self, 1, True);
  Hints.TemplateName := CurrentTemplate.Name;
  acInitializing := False;
end;


procedure TAlphaHintsEdit.sPageControl1Change(Sender: TObject);
begin
  case sPageControl1.ActivePageIndex of
    0: CurrentFrame := FrameTL;
    1: CurrentFrame := FrameTR;
    2: CurrentFrame := FrameBL;
    3: CurrentFrame := FrameBR;
  end;
  CurrentFrame.UpdateData;
end;


procedure TAlphaHintsEdit.UpdateFrame(Sender: TObject);
begin
  if (CurrentFrame <> nil) and (CurrentFrame.Image <> nil) then
    CurrentFrame.UpdateData;
end;


procedure TAlphaHintsEdit.sSpeedButton3Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(CurrentTemplate.Font);
  if FontDialog1.Execute then begin
    CurrentTemplate.Font.Assign(FontDialog1.Font);
    UpdateFrame(Hints);
  end;
end;


procedure TAlphaHintsEdit.sSpeedButton1Click(Sender: TObject);
var
  s: acString;
begin
  CurrentTemplate := TacHintTemplate(Hints.Templates.Add);
  CurrentTemplate.Name := 'New template';
  sListBox1.Items.Add(CurrentTemplate.Name);
  sListBox1.ItemIndex := sListBox1.Items.Count - 1;
  InitTemplate(sListBox1.ItemIndex);
  s := CurrentTemplate.Name;
  if sInputQuery('Template name changing', 'Define new name here:', s) then begin
    CurrentTemplate.Name := s;
    sListBox1.Items[sListBox1.ItemIndex] := CurrentTemplate.Name;
  end;
end;


procedure TAlphaHintsEdit.sSpeedButton2Click(Sender: TObject);
begin
  CurrentTemplate := nil;
  Hints.Templates.Delete(sListBox1.ItemIndex);
  sListBox1.Items.Delete(sListBox1.ItemIndex);
  sListBox1.ItemIndex := sListBox1.Items.Count - 1;
  sListBox1.OnClick(sListBox1);
  if sListBox1.ItemIndex < 0 then
    ChangeStates(Self, 1, False);
end;


procedure TAlphaHintsEdit.FormDestroy(Sender: TObject);
begin
  if PreviewBmp <> nil then
    FreeAndNil(PreviewBmp)
end;


procedure TAlphaHintsEdit.FrameTLPaintBox1Paint(Sender: TObject);
begin
  FrameTL.PaintBox1Paint(Sender);
end;


procedure TAlphaHintsEdit.sSpeedButton4Click(Sender: TObject);
var
  s: acString;
begin
  s := CurrentTemplate.Name;
  if sInputQuery('Template name changing', 'Define new name here:', s) then begin
    CurrentTemplate.Name := s;
    sListBox1.Items[sListBox1.ItemIndex] := CurrentTemplate.Name;
    InitTemplate(sListBox1.ItemIndex);
  end;
end;


procedure TAlphaHintsEdit.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F2 then
    sSpeedButton4Click(sSpeedButton4);
end;


procedure TAlphaHintsEdit.sSpeedButton5Click(Sender: TObject);
begin
  SaveDialog1.InitialDir := GetAppPath;
  SaveDialog1.FileName := Hints.TemplateName;
  if SaveDialog1.Execute then
    Hints.SaveToFile(SaveDialog1.FileName);
end;


procedure TAlphaHintsEdit.sSpeedButton6Click(Sender: TObject);
begin
  OpenDialog1.InitialDir := GetAppPath;
  if OpenDialog1.Execute then begin
    CurrentTemplate := Hints.LoadFromFile(OpenDialog1.FileName);
    sListBox1.Items.Add(CurrentTemplate.Name);
    sListBox1.ItemIndex := sListBox1.Items.Count - 1;
    InitTemplate(sListBox1.ItemIndex);
  end;
end;


procedure TAlphaHintsEdit.FrameTLsSpeedButton3Click(Sender: TObject);
begin
  FrameTL.sSpeedButton3Click(Sender);
end;


procedure TAlphaHintsEdit.sRadioButton2Click(Sender: TObject);
begin
  if not acUpdating then begin
    acUpdating := True;
    CurrentTemplate.HintAlign := haVertCenter;
    CurrentFrame.RefreshPaintBox;
    acUpdating := False;
  end;
end;


procedure TAlphaHintsEdit.sRadioButton1Click(Sender: TObject);
begin
  if not acUpdating then begin
    acUpdating := True;
    CurrentTemplate.HintAlign := haHorzCenter;
    CurrentFrame.RefreshPaintBox;
    acUpdating := False;
  end;
end;

end.
