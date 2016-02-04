unit UnitForms;
{$WARNINGS OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, 
  sSpinEdit, StdCtrls, sEdit, sCheckbox, sRadioButton, ExtCtrls, sPanel, sGroupBox, 
  sSkinProvider, sFrameAdapter, sComboBox, sButton;

type
  TFrameForms = class(TFrame)
    sGroupBox7: TsGroupBox;
    sRadioButton12: TsRadioButton;
    sRadioButton13: TsRadioButton;
    sRadioButton14: TsRadioButton;
    sRadioButton15: TsRadioButton;
    sRadioButton16: TsRadioButton;
    sRadioButton17: TsRadioButton;
    sButton1: TsButton;
    sGroupBox8: TsGroupBox;
    sCheckBox9: TsCheckBox;
    sCheckBox15: TsCheckBox;
    sCheckBox16: TsCheckBox;
    sCheckBox17: TsCheckBox;
    sGroupBox9: TsGroupBox;
    sRadioButton18: TsRadioButton;
    sRadioButton19: TsRadioButton;
    sRadioButton20: TsRadioButton;
    sCheckBox19: TsCheckBox;
    sCheckBox20: TsCheckBox;
    sEdit2: TsEdit;
    sSpinEdit4: TsSpinEdit;
    sFrameAdapter1: TsFrameAdapter;
    sCheckBox1: TsCheckBox;
    sComboBox1: TsComboBox;
    sCheckBox2: TsCheckBox;
    sCheckBox3: TsCheckBox;
    procedure sRadioButton12Click(Sender: TObject);
    procedure sRadioButton18Change(Sender: TObject);
    procedure sRadioButton19Change(Sender: TObject);
    procedure sRadioButton20Change(Sender: TObject);
    procedure sCheckBox19Change(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure sCheckBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    procedure BtnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure CloseBtnClick(Sender: TObject);
  end;

var
  bs : TFormBorderStyle = bsSizeable;
  bi : TBorderIcons = [biSystemMenu, biMinimize, biMaximize];

implementation

uses acntUtils, MainUnit, ImgList, math, sMessages;

{$R *.DFM}

procedure TFrameForms.sRadioButton12Click(Sender: TObject);
begin
  if Sender = sRadioButton12 then bs := bsDialog else
  if Sender = sRadioButton13 then bs := bsNone else
  if Sender = sRadioButton14 then bs := bsSingle else
  if Sender = sRadioButton15 then bs := bsSizeable else
  if Sender = sRadioButton16 then bs := bsSizeToolWin else
  if Sender = sRadioButton17 then bs := bsToolWindow;
end;

procedure TFrameForms.sRadioButton18Change(Sender: TObject);
begin
  MainForm.sSkinProvider1.CaptionAlignment := taLeftJustify;
end;

procedure TFrameForms.sRadioButton19Change(Sender: TObject);
begin
  MainForm.sSkinProvider1.CaptionAlignment := taCenter;
end;

procedure TFrameForms.sRadioButton20Change(Sender: TObject);
begin
  MainForm.sSkinProvider1.CaptionAlignment := taRightJustify;
end;

procedure TFrameForms.sCheckBox19Change(Sender: TObject);
begin
  MainForm.sSkinProvider1.ShowAppIcon := sCheckBox19.Checked;
end;

procedure TFrameForms.sButton1Click(Sender: TObject);
var
  Form : TForm;
  SkinProvider : TsSkinProvider;
//  i : integer;
begin
  Application.CreateForm(TForm, Form);
  if not sCheckBox3.Checked then Form.Tag := -98; // Any standard window skinning will be forbidden if Tag is -98
  Form.BorderStyle := bs;
  Form.Position := poScreenCenter;
  Form.Caption := sEdit2.Text;
  Form.Constraints.MinWidth := Form.Width;
  Form.OnCloseQuery := MainForm.OnCloseQuery;

  bi := [];
  if sCheckBox9.Checked  then bi := bi + [biSystemMenu];
  if sCheckBox15.Checked then bi := bi + [biMaximize];
  if sCheckBox16.Checked then bi := bi + [biMinimize];
  if sCheckBox17.Checked then bi := bi + [biHelp];
  Form.BorderIcons := bi;                 

  // Receive an existing SkinProvider which was created automatically
  if not Form.HandleAllocated then Form.HandleNeeded;
  SkinProvider := TsSkinProvider(SendMessage(Form.Handle, SM_ALPHACMD, MakeWParam(0, AC_GETPROVIDER), 0));

  if SkinProvider <> nil then begin // If SkinProvider component is exists
    if sCheckBox1.Checked then SkinProvider.ResizeMode := rmBorder else SkinProvider.ResizeMode := rmStandard;
    SkinProvider.MakeSkinMenu := sCheckBox2.Checked;

    if sRadioButton18.Checked
      then SkinProvider.CaptionAlignment := taLeftJustify
      else if sRadioButton19.Checked
        then SkinProvider.CaptionAlignment := taCenter
        else if sRadioButton20.Checked then SkinProvider.CaptionAlignment := taRightJustify;

    SkinProvider.SkinData.SkinSection := sComboBox1.Text;
    SkinProvider.ShowAppIcon := sCheckBox19.Checked;

    if sCheckBox20.Checked then SkinProvider.GripMode := gmRightBottom else SkinProvider.GripMode := gmNone;
{
    for i := 0 to sSpinEdit4.Value - 1 do begin
      SkinProvider.TitleButtons.Add;
      SkinProvider.TitleButtons.Items[i].Name := 'TitleButton' + IntToStr(i);
      SkinProvider.TitleButtons.Items[i].OnMouseUp := BtnMouseUp;
      // Assigning a glyph from MainForm Title button
      if SkinProvider.TitleButtons.Items[i].Glyph = nil then SkinProvider.TitleButtons.Items[i].Glyph := TBitmap.Create;
      SkinProvider.TitleButtons.Items[i].Glyph.Assign(MainForm.sSkinProvider1.TitleButtons.Items[0].Glyph);
    end;
}    
  end;

  with TsButton.Create(Form) do begin
    Caption := 'Close';
    SetBounds(120, 120, 84, 32);
    Anchors := Anchors + [akBottom, akRight] - [aktop];
    Parent := Form;
    OnClick := CloseBtnClick;
  end;

  with TsPanel.Create(Form) do begin
    SetBounds(10, 30, 84, 162);
    Name := 'sPanel1';
    Parent := Form;
  end;

  Form.ShowModal;

  FreeAndNil(Form);
end;

procedure TFrameForms.BtnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Alert(TsTitleButton(Sender).Name + ' clicked!');
end;

procedure TFrameForms.CloseBtnClick(Sender: TObject);
begin
  TForm(TsButton(Sender).Parent).Close;
end;

procedure TFrameForms.sCheckBox1Change(Sender: TObject);
begin
  if sCheckBox1.Checked then MainForm.sSkinProvider1.ResizeMode := rmBorder else MainForm.sSkinProvider1.ResizeMode := rmStandard
end;

end.
