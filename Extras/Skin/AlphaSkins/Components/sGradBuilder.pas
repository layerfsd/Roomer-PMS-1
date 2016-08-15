unit sGradBuilder;
{$I sDefs.inc}
//+

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, Menus, StdCtrls, Buttons, ComCtrls,

  sGradient, sSkinProvider, sPanel, sLabel, sButton, sComboBox, sRadioButton, sDialogs, sPageControl, sColorSelect,
  sSpeedButton, sGroupBox, sConst, sMessages;


type
  TGradPoint = class(TPanel)
  protected
    procedure acSMAlphaCmd(var Message: TMessage); message SM_ALPHACMD;
  public
    Number: integer;
    constructor Create(AOwner: TComponent); override;
  end;


  TPointArray = array of TGradPoint;


  TGradBuilder = class(TForm)
    PopupMenu1: TPopupMenu;
    Changecolor1: TMenuItem;
    Delete1: TMenuItem;
    sSkinProvider1: TsSkinProvider;
    BitBtn1: TsButton;
    sButton1: TsButton;
    sButton2: TsButton;
    sRadioButton1: TsRadioButton;
    sRadioButton2: TsRadioButton;
    sRadioButton3: TsRadioButton;
    sGroupBox1: TsGroupBox;
    PaintPanel: TsPanel;
    PaintBox1: TPaintBox;
    Panel2: TsPanel;
    TemplatePanel: TsPanel;
    sGroupBox2: TsGroupBox;
    sPanel1: TsPanel;
    PaintBox2: TPaintBox;
    sColorSelect5: TsColorSelect;
    sColorSelect3: TsColorSelect;
    sColorSelect4: TsColorSelect;
    sColorSelect2: TsColorSelect;
    sColorSelect1: TsColorSelect;
    procedure Panel2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TemplatePanelMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TemplatePanelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Changecolor1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure TemplatePanelMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TemplatePanelDblClick(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sRadioButton1Click(Sender: TObject);
    procedure sColorSelect1Change(Sender: TObject);
  private
    function GetDirection: integer;
    procedure SetDirection(const Value: integer);
    procedure MakefirstPoints;
    procedure InitTriangles;
  public
    a: TPointArray;
    g: TsGradArray;
    LastPoint: TGradPoint;
    ModalResult: TModalResult;
    CurrentArray: TsGradArray;
    ColorDialog1: TColorDialog;
    function AsString: string;
    procedure LoadFromArray(NewArray: TsGradArray);
    procedure ReCalcData;
    procedure NewPoint(Owner: TsPanel; y: integer; Color: TColor);
    procedure DeleteFromArray(p: TGradPoint);
    procedure Reinit;
    property Direction: integer read GetDirection write SetDirection;
  end;


const
  PointHeight = 6;
  PointAmount = 5;


var
  NoMouse: boolean;
  GradBuilder: TGradBuilder;
  ColorDialog: TColorDialog;
  ColSelects: array[0..PointAmount - 1] of TsColorSelect;


procedure CreateEditorForm; overload;
procedure CreateEditorForm(CustomDlg: TColorDialog); overload;
procedure KillForm;


implementation

uses math,
  acntUtils, sStyleSimply, sGraphUtils, sColorDialog, acPopupController;


const
  acs_FirstPoint = 'FirstPoint';
  acs_LastPoint  = 'LastPoint';

{$R *.DFM}

procedure CreateEditorForm;
begin
  Application.CreateForm(TGradBuilder, GradBuilder);
end;


procedure CreateEditorForm(CustomDlg: TColorDialog); overload;
var
  i: integer;
begin
  CreateEditorForm;
  ColorDialog := CustomDlg;
  with GradBuilder do begin
    ColorDialog1 := CustomDlg;
    ColSelects[0] := sColorSelect1;
    ColSelects[1] := sColorSelect5;
    ColSelects[2] := sColorSelect2;
    ColSelects[3] := sColorSelect4;
    ColSelects[4] := sColorSelect3;
    for i := 0 to PointAmount - 1 do
      ColSelects[i].ColorDialog := CustomDlg;
  end;
end;


procedure KillForm;
begin
  if Assigned(GradBuilder) then
    GradBuilder.Release;
end;


procedure TGradBuilder.sRadioButton1Click(Sender: TObject);
begin
  Direction := TsRadioButton(Sender).Tag;
end;


procedure TGradBuilder.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (ColorDialog = nil) and (ColorDialog1 <> nil) then
    FreeAndNil(ColorDialog1)
  else
    ColorDialog1 := nil;
end;


procedure TGradBuilder.ReCalcData;
var
  i, c, n: integer;
  CurPoint, PrevPoint: TGradPoint;

  function GetMinPoint(Top: integer): TGradPoint;
  var
    i: integer;
  begin
    Result := a[1];
    for i := 0 to c - 1 do
      if (a[i].Top > Top) and (a[i].Top <= Result.Top) then
        Result := a[i];
  end;

begin
  if Direction <> 2 then begin
    SetLength(g, 0);
    c := Length(a);
    PrevPoint := a[0];
    for i := 0 to c - 1 do begin
      CurPoint := GetMinPoint(PrevPoint.Top);
      SetLength(g, Length(g) + 1);
      with g[Length(g) - 1] do begin
        Color1 := ColorToRGB(PrevPoint.Color);
        Color2 := ColorToRGB(CurPoint.Color);
        n := Round((CurPoint.Top - PrevPoint.Top) / 2.2);//* 100 / (PaintPanel.Height - PointHeight));
        Percent :=  min(n, 100);
        Mode1 := max(Direction, 0);
      end;
      PrevPoint := CurPoint;
    end;
    GradBuilder.PaintBox1.Repaint;
  end
  else begin
    c := Length(g);
    for i := 0 to PointAmount - 1 do
      if c > i then g[i].color1 := ColSelects[i].ColorValue;

    GradBuilder.PaintBox2.Repaint;
  end;
end;


procedure TGradBuilder.NewPoint(Owner: TsPanel; y: integer; Color: TColor);
var
  c: integer;
begin
  c := Length(a);
  a[c - 1] := TGradPoint.Create(Owner);
  a[c - 1].Parent := Owner;

  a[c - 1].Left := 1;//5;
  a[c - 1].Width := Owner.Width - 1;//0;
  a[c - 1].Top := y;
  a[c - 1].Visible := True;
  a[c - 1].Caption := s_Space;
  a[c - 1].Color := ColorToRGB(Color);
  a[c - 1].PopupMenu := GradBuilder.PopupMenu1;
  a[c - 1].Number := Length(a) - 1;

  with GradBuilder.TemplatePanel do begin
    a[c - 1].onMouseDown := OnMouseDown;
    a[c - 1].onMouseUp   := OnMouseUp;
    a[c - 1].onMouseMove := OnMouseMove;
    a[c - 1].onDblClick  := OnDblClick;
  end;
end;


procedure TGradBuilder.DeleteFromArray(p: TGradPoint);
var
  i: integer;
begin
  for i := p.Number to Length(a) - 2 do
    a[i] := a[i + 1];

  SetLength(a, Length(a) - 1);
  p.PopupMenu := nil;
  p.onMouseDown := nil;
  p.onMouseMove := nil;
  p.onMouseUp := nil;
  if Assigned(p) then
    FreeAndNil(p);
end;


procedure TGradPoint.acSMAlphaCmd(var Message: TMessage);
begin
  inherited;
  case Message.WParamHi of
    AC_POPUPCLOSED:
      if (Message.LParam <> 0) and (TsColorDialogForm(Message.LParam).ModalResult = mrOk) then begin
        Color := ColorToRGB(TsColorDialogForm(Message.LParam).sColor.C);
        GradBuilder.ReCalcData;
      end;
  end;
end;


constructor TGradPoint.Create(AOwner: TComponent);
begin
  inherited;
  Tag := ExceptTag; // Preventing an automatic skinning
  Parent := TWinControl(AOwner);
{$IFDEF DELPHI7UP}
  ParentBackground := False;
{$ENDIF}
  Visible := False;
  Height := PointHeight;
end;


procedure TGradBuilder.Panel2Click(Sender: TObject);
var
  m: TMouse;
  p: TPoint;
begin
  m := TMouse.Create;
  p := m.CursorPos;
  p := Panel2.ScreenToClient(p);
  if Assigned(m) then
    FreeAndNil(m);

  SetLength(a, Length(a) + 1);
  NewPoint(Panel2, p.y, clWhite);
  ReCalcData;
end;


procedure TGradBuilder.FormCreate(Sender: TObject);
begin
  MakefirstPoints;
end;


procedure TGradBuilder.TemplatePanelMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  t: integer;
begin
  if not NoMouse then begin
    LastPoint := TGradPoint(Sender);
    if (Button = mbLeft) and (LastPoint.Name <> acs_FirstPoint) and (LastPoint.Name <> acs_LastPoint) then begin
      t := LastPoint.Top;
      ReleaseCapture;
      LastPoint.Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
      if t <> LastPoint.Top then
        ReCalcData;
    end;
  end;
  NoMouse := False;
end;


procedure TGradBuilder.TemplatePanelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  TPanel(Sender).Left := 1;
  TPanel(Sender).Width := Panel2.Width - 1;
end;


procedure TGradBuilder.Changecolor1Click(Sender: TObject);
begin
  TemplatePanelDblClick(LastPoint);
end;


procedure TGradBuilder.PopupMenu1Popup(Sender: TObject);
begin
  if LastPoint <> nil then
    Delete1.Enabled := (LastPoint.Name <> acs_FirstPoint) and (LastPoint.Name <> acs_LastPoint);
end;


procedure TGradBuilder.Delete1Click(Sender: TObject);
begin
  if LastPoint <> nil then begin
    DeleteFromArray(LastPoint);
    ReCalcData;
  end;
end;


procedure TGradBuilder.PaintBox1Paint(Sender: TObject);
var
  b: TBitMap;
begin
  b := CreateBmp32(TPaintBox(Sender).Width, TPaintBox(Sender).Height);
  try
    PaintGrad(b, MkRect(b), g);
    TPaintBox(Sender).Canvas.Draw(0, 0, b);
  finally
    FreeAndNil(b);
  end;
end;


procedure TGradBuilder.FormShow(Sender: TObject);
begin
  ReCalcData;
  if (CurrentArray <> nil) and (Length(CurrentArray) > 0) then
    Direction := max(CurrentArray[0].Mode1, 0)
  else
    Direction := 0;
end;


procedure TGradBuilder.BitBtn1Click(Sender: TObject);
begin
  ModalResult := mrCancel;
  Close;
end;


function TGradBuilder.AsString: string;
var
  i: integer;
begin
  Result := '';
  for i := 0 to Length(g) - 1 do
    with g[i] do
      Result := Result +
                IntToStr(ColorToRGB(Color1)) + ';' +
                IntToStr(ColorToRGB(Color2)) + ';' +
                IntToStr(Percent) + ';' +
                IntToStr(Mode1) + ';' +
                IntToStr(Mode2) + ';';

  Delete(Result, Length(Result), 1);
end;


procedure TGradBuilder.LoadFromArray(NewArray: TsGradArray);
var
  i, c: integer;
begin
  CurrentArray := NewArray;
  c := Length(NewArray) - 1;
  if c > 0 then begin
    SetLength(g, c + 1);
    for i := 0 to c do
      with NewArray[i] do begin
        g[i].Color1  := Color1;
        g[i].Color2  := Color2;
        g[i].Percent := Percent;
        g[i].Mode1   := Mode1;
        g[i].Mode2   := Mode2;
      end;

    Direction := NewArray[0].Mode1;
  end;
end;


procedure TGradBuilder.TemplatePanelMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ReCalcData;
end;


procedure TGradBuilder.TemplatePanelDblClick(Sender: TObject);
begin
  LastPoint := TGradPoint(Sender);
  NoMouse := True;
  if sColorDialogForm = nil then
    sColorDialogForm := TsColorDialogForm.Create(Application);

  sColorDialogForm.InitControls(True, False, LastPoint.Color, bsNone);
  sColorDialogForm.SetCurrentColor(LastPoint.Color);
  ShowPopupForm(sColorDialogForm, LastPoint);//Self);
  // Allow showing of Dlg when screen is captured
  SetWindowLong(sColorDialogForm.Handle, GWL_EXSTYLE, GetWindowLong(sColorDialogForm.Handle, GWL_EXSTYLE) and not WS_EX_LAYERED);
  NoMouse := False;
end;


procedure TGradBuilder.sButton1Click(Sender: TObject);
begin
  ModalResult := mrOk;
  Close;
end;


procedure TGradBuilder.sButton2Click(Sender: TObject);
const
  sReally = 'Are you really wanna clear a current gradient information?';
begin
{$IFNDEF ALITE}
  if Customrequest(sReally) then begin
{$ELSE}
  if MessageDlg(sReally, mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
{$ENDIF}
    ModalResult := mrNone;
    Close;
  end;
end;


function TGradBuilder.GetDirection: integer;
begin
  if sRadioButton1.Checked then
    Result := 0
  else
    Result := 1 + integer(not sRadioButton2.Checked)
end;


procedure TGradBuilder.SetDirection(const Value: integer);
var
  i: integer;
begin
  case Value of
    0: begin
      sRadioButton1.Checked := True;
      sGroupBox1.BringToFront;
      MakefirstPoints;
    end;

    1: begin
      sRadioButton2.Checked := True;
      sGroupBox1.BringToFront;
      MakefirstPoints;
    end;

    2: begin
      sRadioButton3.Checked := True;
      sGroupBox2.BringToFront;
    end;
  end;
  for i := 0 to Length(g) - 1 do
    g[i].Mode1 := Value;

  Reinit;
end;


procedure TGradBuilder.sColorSelect1Change(Sender: TObject);
begin
  SetLength(g, 5);
  g[TsColorSelect(Sender).Tag].Color1 := ColorToRGB(TsColorSelect(Sender).ColorValue);
  InitTriangles;
  Reinit;
end;


procedure TGradBuilder.Reinit;
var
  i, c: integer;
  h: integer;
begin
  c := Length(g);
  if Direction < 2 then begin
    SetLength(a, 0);
    while Panel2.ComponentCount > 0 do
      Panel2.Components[0].Destroy;

    MakefirstPoints;
    h := 0;
    for i := 0 to Panel2.ComponentCount - 1 do
      if Panel2.Components[i].Name = acs_FirstPoint then
        TGradPoint(Panel2.Components[i]).Color := ColorToRGB(g[0].Color1)
      else
        if Panel2.Components[i].Name = acs_LastPoint then
          TGradPoint(Panel2.Components[i]).Color := ColorToRGB(g[c - 1].Color2);

    for i := 1 to c - 2 do begin
      inc(h, Round(g[i - 1].Percent * 2.2));
      SetLength(a, Length(a) + 1);
      NewPoint(Panel2, h, ColorToRGB(g[i].Color1));
    end;
  end
  else begin
    SetLength(a, 0);
    while Panel2.ComponentCount > 0 do
      Panel2.Components[0].Destroy;

    for i := 0 to PointAmount - 1 do
      if c > i then
        ColSelects[i].ColorValue := g[i].color1
      else
        if i = 0 then
          ColSelects[i].ColorValue := 0
        else
          ColSelects[i].ColorValue := ColSelects[i - 1].ColorValue;
  end;
  ReCalcData;
end;


procedure TGradBuilder.MakeFirstPoints;
begin
  if Panel2.ComponentCount = 0 then begin
    // FirstPoint
    SetLength(a, 1);
    NewPoint(Panel2, 0, clWhite);
    a[Length(a) - 1].Name := acs_FirstPoint;
    // LastPoint
    SetLength(a, 2);
    NewPoint(Panel2, Panel2.Height - PointHeight, clBtnShadow);
    a[Length(a) - 1].Name := acs_LastPoint;
  end;
end;


procedure TGradBuilder.InitTriangles;
var
  i, p: integer;
begin
  p := 100 div PointAmount - 1;
  if Length(g) < PointAmount then
    SetLength(g, PointAmount);

  for i := 0 to PointAmount - 1 do
    with g[i] do
      if i < PointAmount - 1 then begin
        Color1 := ColSelects[i].ColorValue;
        Color2 := ColSelects[i + 1].ColorValue;
        Percent := p;
      end
      else begin
        Color1 := ColSelects[i].ColorValue;
        Color2 := ColSelects[i].ColorValue;
        Percent := 0;
      end;
end;

end.

