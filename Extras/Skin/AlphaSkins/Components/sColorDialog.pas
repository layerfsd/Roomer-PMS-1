unit sColorDialog;
{$I sDefs.inc}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Buttons, Mask, StdCtrls, ExtCtrls, 
  {$IFDEF DELPHI_XE2} UITypes, {$ENDIF}
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  sSkinProvider, sBitBtn, sPanel, sMaskEdit, sCurrencyEdit, sLabel, sConst, sSpeedButton, sGraphUtils,
  sCurrEdit, sCustomComboEdit;


type
  TColorArray = array of TColor;


  TsColorDialogForm = class(TForm)
    sBitBtn1: TsBitBtn;
    sBitBtn2: TsBitBtn;
    sBitBtn3: TsBitBtn;
    sBitBtn4: TsBitBtn;
    sBitBtn5: TsBitBtn;

    sLabel2: TsLabel;
    sLabel4: TsLabel;
    sLabel5: TsLabel;
    sLabel6: TsLabel;

    Panel1: TPanel;
    GradPanel:  TsPanel;
    ColorPanel: TsPanel;

    sREdit: TsCurrencyEdit;
    sGEdit: TsCurrencyEdit;
    sBEdit: TsCurrencyEdit;
    sHEdit: TsCurrencyEdit;
    sSEdit: TsCurrencyEdit;
    sVEdit: TsCurrencyEdit;

    AddPal:  TsColorsPanel;
    MainPal: TsColorsPanel;

    OldPanel:      TShape;
    SelectedPanel: TShape;

    sEditHex: TsMaskEdit;
    sEditDecimal: TsCurrencyEdit;
    sSpeedButton1: TsSpeedButton;
    sSkinProvider1: TsSkinProvider;

    procedure CreateExtBmp;
    procedure FormShow(Sender: TObject);
    procedure sBitBtn2Click(Sender: TObject);
    procedure sBitBtn1Click(Sender: TObject);

    procedure ColorPanelPaint(Sender: TObject; Canvas: TCanvas);
    procedure ColorPanelMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ColorPanelMouseUp  (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ColorPanelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);

    procedure GradPanelPaint(Sender: TObject; Canvas: TCanvas);
    procedure GradPanelMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GradPanelMouseUp  (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GradPanelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);

    procedure MainPalChange(Sender: TObject);
    procedure sEditHexKeyPress(Sender: TObject; var Key: Char);
    function GetColorCoord(const C: TsColor): integer;
    procedure FormPaint(Sender: TObject);
    procedure sEditHexChange(Sender: TObject);
    procedure sEditDecimalChange(Sender: TObject);
    procedure sHEditChange (Sender: TObject);
    procedure sREditChange (Sender: TObject);
    procedure FormCreate   (Sender: TObject);
    procedure sBitBtn4Click(Sender: TObject);
    procedure sBitBtn5Click(Sender: TObject);
    procedure sBitBtn3Click(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
    procedure PickFormPaint(Sender: TObject);
    procedure PickFormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PickFormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PickFormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);

    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp  (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure MainPalDblClick(Sender: TObject);
    procedure AddPalDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  public
    ExtBmp,
    TmpBmp: TBitmap;
    
    TopColors: TColorArray;
    Owner: TColorDialog;
    PickPanel: TsPanel;
    destructor Destroy; override;
    procedure SetMarker;
    procedure PaintCursor(mX, mY: integer; Canvas: TCanvas);
    function GradToColor(Coord: integer): TColor;
    procedure SetCurrentColor(c: TColor);
    procedure SetInternalColor(h: integer; s: real);
    procedure SetColorFromEdit(Color: TColor; var Flag: boolean);
    procedure ExitPanels;
    procedure InitLngCaptions;
    function MarkerRect: TRect;
  end;


var
  sColorDialogForm: TsColorDialogForm;


implementation

uses math, sCommonData, acntUtils, sDialogs, sAlphaGraph, sVclUtils, sSkinProps;

{$R *.DFM}
{$R ASCursors.res}

var
  Bmp: TBitmap;
  SelectedHsv: TsHSV;
  ColorCoord: TPoint;
  GradY, CurrCustomIndex: integer;
  InternalColor, PickColor: TColor;
  UseCoords, ExPressed, GradPressed: boolean;
  ColorChanging, HexChanging, DecChanging, HsvChanging, RgbChanging: boolean;


type
  TAccessPanel = class(TPanel);


const
  bWidth = 0;
  ArrowSize = 5;
  crASPipette = -50;
  dblWidth = bWidth * 0;


procedure Marker(DC: hdc; Pos: TPoint);
var
  x, y: integer;
  C: TColor;
begin
  if (sColorDialogForm <> nil) and sColorDialogForm.sSkinProvider1.SkinData.Skinned then
    C := sColorDialogForm.sSkinProvider1.SkinData.SkinManager.GetGlobalFontColor
  else
    C := clBlack;

  for y := 0 to ArrowSize do
    for x := 0 to ArrowSize do begin
      if x > y then
        SetPixel(DC, Pos.X + X, Pos.Y + Y, C);

      if x > ArrowSize - y then
        SetPixel(DC, Pos.X + X, Pos.Y + Y - ArrowSize, C);
    end;
end;


procedure SkinMarker(Form: TsColorDialogForm);
var
  CI: TCacheInfo;
  x, y: integer;
  DC: hdc;
  Bmp: TBitmap;
begin
  DC := Form.Canvas.Handle;
  with Form do
    if not sSkinProvider1.SkinData.BGChanged then begin
      CI.Bmp := sSkinProvider1.SkinData.FCacheBmp;
      CI.X := sSkinProvider1.OffsetX;
      CI.Y := sSkinProvider1.OffsetY;
      CI.Ready := True;
      x := Form.GradPanel.Left + Form.GradPanel.Width;
      y := Form.GradPanel.Top - ArrowSize;
      Bmp := TBitmap.Create;
      if (TmpBmp = nil) then begin // Save BG
        TmpBmp := CreateBmp32(10, GradPanel.Height + ArrowSize * 2);
        if CI.Ready then
          BitBlt(TmpBmp.Canvas.Handle, 0, 0, TmpBmp.Width, TmpBmp.Height, CI.Bmp.Canvas.Handle, x, y, SRCCOPY)
        else
          FillDC(TmpBmp.Canvas.Handle, MkRect(TmpBmp), CI.FillColor);
      end;
      Bmp.Assign(TmpBmp);

      if not InAnimationProcess then
        Marker(Bmp.Canvas.Handle, Point(0, GradY + ArrowSize));

      BitBlt(DC, GradPanel.Left + GradPanel.Width, GradPanel.Top - ArrowSize, 20, TmpBmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
      Bmp.Free;
    end;
end;


procedure RepaintRect(Form: TsColorDialogForm);
var
  UR: TRect;
begin
  if (Form.sSkinProvider1.SkinData.SkinManager = nil) or not Form.sSkinProvider1.SkinData.SkinManager.Active then begin
    UR := Form.MarkerRect;
    RedrawWindow(Form.Handle, @UR, 0, RDW_INVALIDATE or RDW_ERASE or RDW_UPDATENOW);
  end;
end;


procedure TsColorDialogForm.sBitBtn2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;


procedure TsColorDialogForm.sBitBtn1Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;


procedure TsColorDialogForm.ColorPanelPaint(Sender: TObject; Canvas: TCanvas);
begin
  if ExtBmp <> nil then begin
    BitBlt(Canvas.Handle, 0, 0, ExtBmp.Width, ExtBmp.Height, ExtBmp.Canvas.Handle, 0, 0, SRCCOPY);
    if not ExPressed then
      if UseCoords then
        PaintCursor(ColorCoord.x, ColorCoord.y, Canvas)
      else
        PaintCursor(SelectedHsv.h * ColorPanel.Width div 360, Round((1 - SelectedHsv.s) * ColorPanel.Height), Canvas)
  end;
end;


procedure TsColorDialogForm.CreateExtBmp;
var
  x, y, ImgWidth, ImgHeight: integer;
begin
  ImgWidth := ColorPanel.Width - dblWidth;
  ImgHeight := ColorPanel.Height - dblWidth;
  if (ImgWidth <> 0) and (ImgHeight <> 0) then
    try
      ExtBmp := CreateBmp32(ImgWidth, ImgHeight);
    finally
      if ExtBmp <> nil then
        for y := 0 to ImgHeight - 1 do
          for x := 0 to ImgWidth - 1 do
            ExtBmp.Canvas.Pixels[x, y] := Hsv2Rgb(x * 360 / ImgWidth, 1 - y / ImgHeight, 1 - y / (ImgHeight * 3)).C;
    end;
end;


procedure TsColorDialogForm.FormShow(Sender: TObject);
begin
  SetCurrentColor(ColorToRGB(TsColorDialog(Owner).Color));
  TsColorDialog(Owner).DoShow;
  if TmpBmp <> nil then
    FreeAndNil(TmpBmp);
end;


procedure TsColorDialogForm.ColorPanelMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  R: TRect;
  P: TPoint;
begin
  ColorPanel.SetFocus;
  ExPressed := True;
  SetInternalColor(Round(x * 360 / ColorPanel.Width), 1 - y / ColorPanel.Height);
  ColorPanel.SkinData.BGChanged := True;
  ColorPanelPaint(ColorPanel, TAccessPanel(ColorPanel).Canvas);
  P := ColorPanel.ClientToScreen(MkPoint);
  R := MkRect(ColorPanel);
  OffsetRect(R, P.x, P.y);
  ClipCursor(@R);
end;


procedure TsColorDialogForm.GradPanelPaint(Sender: TObject; Canvas: TCanvas);
var
  x, y, Hdiv2, ImgWidth, ImgHeight: integer;
  R, G, B, RStep, GStep, BStep: real;
  TmpBitmap: TBitmap;
  S: PRGBAArray;
  c: TsColor_;
begin
  ImgWidth := GradPanel.Width - dblWidth;
  ImgHeight := GradPanel.Height - dblWidth;
  TmpBitmap := CreateBmp32(ImgWidth, ImgHeight);
  c.C := SwapRedBlue(InternalColor);

  b := max(c.R, c.G);
  b := max(c.B, b);

  R := $FF / b;

  c.R := Round(c.R * R);
  c.G := Round(c.G * R);
  c.B := Round(c.B * R);

  R := MaxByte;
  G := MaxByte;
  B := MaxByte;
  y := 0;
  Hdiv2 := ImgHeight div 2;
  RStep := (MaxByte - c.R) / Hdiv2;
  GStep := (MaxByte - c.G) / Hdiv2;
  BStep := (MaxByte - c.B) / Hdiv2;
  while y < (ImgHeight - 1) div 2 do begin
    R := R - RStep;
    G := G - GStep;
    B := B - BStep;
    c.R := max(min(round(R), MaxByte), 0);
    c.G := max(min(round(G), MaxByte), 0);
    c.B := max(min(round(B), MaxByte), 0);
    S := TmpBitmap.ScanLine[y];
    for x := 0 to ImgWidth - 1 do
      S[X] := C;

    inc(y)
  end;
  RStep := c.R / Hdiv2;
  GStep := c.G / Hdiv2;
  BStep := c.B / Hdiv2;
  while y < ImgHeight do begin
    R := R - RStep;
    G := G - GStep;
    B := B - BStep;
    c.R := max(min(round(R), MaxByte), 0);
    c.G := max(min(round(G), MaxByte), 0);
    c.B := max(min(round(B), MaxByte), 0);
    S := TmpBitmap.ScanLine[y];
    for x := 0 to ImgWidth - 1 do
      S[X] := C;

    inc(y)
  end;
  BitBlt(Canvas.Handle, 0, 0, ImgWidth, ImgHeight, TmpBitmap.Canvas.Handle, 0, 0, SRCCOPY);
  TmpBitmap.Free;
end;


procedure TsColorDialogForm.ColorPanelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if ExPressed then
    SetInternalColor(Round(x * 360 / ColorPanel.Width), 1 - y / ColorPanel.Height);
end;


procedure TsColorDialogForm.GradPanelMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  GradPanel.SetFocus;
  GradPressed := True;
  GradY := Y;
  UseCoords := True;
  SetCurrentColor(GradToColor(y));
  UseCoords := False;
  FormPaint(Self);
end;


procedure TsColorDialogForm.SetMarker;
var
  CI: TCacheInfo;
  c: TsColor;
begin
  GradPanel.SkinData.BGChanged := True;
  GradPanelPaint(GradPanel, TAccessPanel(GradPanel).Canvas);
  CI := sCommonData.GetParentCache(GradPanel.SkinData);
  if CI.Ready then
    BitBlt(Canvas.Handle, GradPanel.Left + GradPanel.Width, GradPanel.Top - 5, 20, GradPanel.Height + 10, CI.Bmp.Canvas.Handle, GradPanel.Left + GradPanel.Width + CI.X, GradPanel.Top + CI.Y - 5, SRCCOPY)
  else
    FillDC(Canvas.Handle, Rect(GradPanel.Left + GradPanel.Width, GradPanel.Top - 5, GradPanel.Left + GradPanel.Width + 20, GradPanel.Top + GradPanel.Height + 5), CI.FillColor);

  c.C := SelectedPanel.Brush.Color;
  GradY := GetColorCoord(c);
end;


procedure TsColorDialogForm.GradPanelMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ClipCursor(nil);
  GradPressed := False;
  RepaintRect(Self);
end;


procedure TsColorDialogForm.GradPanelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if GradPressed then begin
    RepaintRect(Self);
    GradY := Y;
    UseCoords := True;
    SetCurrentColor(GradToColor(y));
    UseCoords := False;
  end;
end;


procedure TsColorDialogForm.ColorPanelMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ClipCursor(nil);
  ExPressed := False;
  ColorPanel.SkinData.BGChanged := True;
  ColorPanelPaint(ColorPanel, TAccessPanel(ColorPanel).Canvas);
end;


function TsColorDialogForm.GradToColor(Coord: integer): TColor;
var
  RStep, GStep, BStep, R, G, B, id2: real;
  y, ImgHeight: integer;
  c: TsColor;
begin
  c.C := InternalColor;
  R := MaxByte;
  G := MaxByte;
  B := MaxByte;
  ImgHeight := GradPanel.Height - dblWidth;
  id2 := ImgHeight / 2;
  RStep := (MaxByte - c.R) / id2;
  GStep := (MaxByte - c.G) / id2;
  BStep := (MaxByte - c.B) / id2;
  y := 0;
  while y < (ImgHeight - 1) div 2 do begin
    R := R - RStep;
    G := G - GStep;
    B := B - BStep;
    c.R := Trunc(R);
    c.G := Trunc(G);
    c.B := Trunc(B);
    if y = Coord then begin
      if c.R < 3 then c.R := 0;
      if c.G < 3 then c.G := 0;
      if c.B < 3 then c.B := 0;
      if c.R > 253 then c.R := MaxByte;
      if c.G > 253 then c.G := MaxByte;
      if c.B > 253 then c.B := MaxByte;
      Result := c.C;
      Exit;
    end;
    inc(y)
  end;
  RStep := c.R / id2;
  GStep := c.G / id2;
  BStep := c.B / id2;
  while y < ImgHeight - 1 do begin
    R := R - RStep;
    G := G - GStep;
    B := B - BStep;
    c.R := Trunc(R);
    c.G := Trunc(G);
    c.B := Trunc(B);
    if y = Coord then begin
      Result := c.C;
      Exit;
    end;
    inc(y)
  end;
  if Coord <= 0 then
    Result := $FFFFFF
  else
    Result := c.C;
end;


procedure TsColorDialogForm.SetCurrentColor(c: TColor);
var
  sColor: TsColor;
  TempValue: real;
begin
  ColorChanging := True;
  SelectedPanel.Brush.Color := ColorToRGB(c);
  SelectedPanel.Pen.Color := SelectedPanel.Brush.Color;
  sColor.C := c;
  if not UseCoords then begin
    SelectedHsv := Rgb2Hsv(sColor);
    InternalColor := max(Hsv2Rgb(SelectedHsv.h, SelectedHsv.s, 1).C, 0);
  end;
  if not HsvChanging then begin
    sHEdit.Value := Round(SelectedHsv.H);
    if not UseCoords then begin
      sSEdit.Value := SelectedHsv.S * 100;
      sVEdit.Value := SelectedHsv.V * 100
    end
    else
      if GradY < GradPanel.Height div 2 then begin
        TempValue := SelectedHsv.S * 100;
        sSEdit.Value := (TempValue * 2) / GradPanel.Height * (GradY + 1);
      end
      else
        sVEdit.Value := (1 - abs(GradPanel.Height div 2 - GradY) / (GradPanel.Height div 2)) * 100;
  end;

  if not RgbChanging then begin
    sREdit.Value := sColor.R;
    sGEdit.Value := sColor.G;
    sBEdit.Value := sColor.B;
  end;

  if not DecChanging then
    sEditDecimal.Text := IntToStr(sColor.C);

  if not HexChanging then
    sEditHex.Text := IntToHex(SwapInteger(sColor.C), 6);

  SelectedPanel.Brush.Color := sColor.C;
  SelectedPanel.Pen.Color := SelectedPanel.Brush.Color;
  if not UseCoords then
    ColorCoord := Point(SelectedHsv.h * ColorPanel.Width div 360, Round((1 - SelectedHsv.s) * ColorPanel.Height));
    
  SetMarker;
  sSkinProvider1.SkinData.BGChanged := True;
  RepaintRect(Self);
  ExitPanels;
  ColorChanging := False;
end;


procedure TsColorDialogForm.PaintCursor(mX, mY: integer; Canvas: TCanvas);
begin
  Canvas.Ellipse(mX - 5, mY - 5, mX + 5, mY + 5);
end;


procedure TsColorDialogForm.MainPalChange(Sender: TObject);
begin
  if (TsColorsPanel(Sender).ItemIndex <> -1) and not ((Sender = AddPal) and (AddPal.Colors[AddPal.ItemIndex] = 'FFFFFF')) then begin
    SetCurrentColor(TsColorsPanel(Sender).ColorValue);
    ColorPanel.SkinData.BGChanged := True;
    ColorPanelPaint(ColorPanel, TAccessPanel(ColorPanel).Canvas);
  end;
end;


procedure TsColorDialogForm.sEditHexKeyPress(Sender: TObject; var Key: Char);
begin
  if CharInSet(Key, [ZeroChar..'9', 'A'..'F', 'a'..'f', Chr(3) {Ctrl-C}, Chr(22) {Ctrl-V}, Chr(27), Chr(13)]) then
    inherited
  else
    Key := #0;
end;


function TsColorDialogForm.GetColorCoord(const C: TsColor): integer;
const
  cNear = 3;
var
  RStep, GStep, BStep, R, G, B: real;
  y, ImgHeight, Hdiv2: integer;
  IntCol: TsColor_;
begin
  R := MaxByte;
  G := MaxByte;
  B := MaxByte;
  ImgHeight := GradPanel.Height - dblWidth;
  IntCol.C := SwapRedBlue(InternalColor);
  Hdiv2 := ImgHeight div 2;
  RStep := (MaxByte - IntCol.R) / Hdiv2;
  GStep := (MaxByte - IntCol.G) / Hdiv2;
  BStep := (MaxByte - IntCol.B) / Hdiv2;
  y := 0;
  while y < (ImgHeight - 1) div 2 do begin
    R := R - RStep;
    G := G - GStep;
    B := B - BStep;
    if (abs(c.R - R) < cNear) and (abs(c.G - G) < cNear) and (abs(c.B - B) < cNear) then begin
      Result := y;
      Exit;
    end;
    inc(y);
  end;
  RStep := IntCol.R / Hdiv2;
  GStep := IntCol.G / Hdiv2;
  BStep := IntCol.B / Hdiv2;
  while y < ImgHeight do begin
    R := R - RStep;
    G := G - GStep;
    B := B - BStep;
    if (abs(c.R - R) < cNear) and (abs(c.G - G) < cNear) and (abs(c.B - B) < cNear) then begin
      Result := y;
      Exit;
    end;
    inc(y);
  end;
  Result := y;
end;


procedure TsColorDialogForm.SetInternalColor(h: integer; s: real);
var
  sColor, sC: TsColor;
begin
  ColorChanging := True;
  SelectedHsv.h := h;
  SelectedHsv.s := s;
  sColor := Hsv2Rgb(h, s, 1);
  InternalColor := max(sColor.C, 0);

  sHEdit.Value := Round(SelectedHsv.H);
  sSEdit.Value := SelectedHsv.S * 100;
  if GradY < GradPanel.Height div 2 then
    sVEdit.Value := 100
  else
    sVEdit.Value := (1 - abs(GradPanel.Height div 2 - GradY) / (GradPanel.Height div 2)) * 100;

  GradPanel.SkinData.BGChanged := True;
  GradPanelPaint(GradPanel, TAccessPanel(GradPanel).Canvas);
  sC.C := GradToColor(GradY);
  sREdit.Value := sC.R;
  sGEdit.Value := sC.G;
  sBEdit.Value := sC.B;
  sEditDecimal.Text := IntToStr(sC.C);
  sEditHex.Text := IntToHex(SwapInteger(sC.C), 6);
  SelectedPanel.Brush.Color := sC.C;
  SelectedPanel.Pen.Color := SelectedPanel.Brush.Color;
  ColorCoord := Point(SelectedHsv.h * ColorPanel.Width div 360, Round((1 - SelectedHsv.s) * ColorPanel.Height));
  ExitPanels;
  ColorChanging := False;
end;


procedure TsColorDialogForm.FormPaint(Sender: TObject);
begin
  if sSkinProvider1.SkinData.Skinned and not sSkinProvider1.SkinData.FCacheBmp.Empty then
    SkinMarker(Self)
  else
    Marker(Canvas.Handle, Point(GradPanel.Left + GradPanel.Width, GradPanel.Top + GradY));
end;


procedure TsColorDialogForm.sEditHexChange(Sender: TObject);
begin
  SetColorFromEdit(SwapInteger(HexToInt(ExtractWord(1, sEditHex.Text, [s_Space]))), HexChanging);
end;


procedure TsColorDialogForm.sEditDecimalChange(Sender: TObject);
begin
  SetColorFromEdit(sEditDecimal.AsInteger, DecChanging);
end;


procedure TsColorDialogForm.sHEditChange(Sender: TObject);
begin
  SetColorFromEdit(Hsv2Rgb(sHEdit.asInteger, sSEdit.Value / 100, sVEdit.Value / 100).C, HsvChanging);
end;


procedure TsColorDialogForm.SetColorFromEdit(Color: TColor; var Flag: boolean);
begin
  if not ColorChanging then begin
    Flag := True;
    SetCurrentColor(Color);
    MainPal.ItemIndex := -1;
    ColorPanel.SkinData.BGChanged := True;
    ColorPanelPaint(ColorPanel, TAccessPanel(ColorPanel).Canvas);
    Flag := False;
  end;
end;


procedure TsColorDialogForm.sREditChange(Sender: TObject);
var
  c: TsColor;
begin
  c.R := sREdit.AsInteger;
  c.G := sGEdit.AsInteger;
  c.B := sBEdit.AsInteger;
  SetColorFromEdit(c.C, RgbChanging);
end;


procedure TsColorDialogForm.FormCreate(Sender: TObject);
begin
  CurrCustomIndex := 0;
  CreateExtBmp;
end;


procedure TsColorDialogForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(ExtBmp);
end;


procedure TsColorDialogForm.sBitBtn4Click(Sender: TObject);
begin
  Width := Constraints.MaxWidth;
  sBitBtn4.Enabled := False;
end;


procedure TsColorDialogForm.sBitBtn5Click(Sender: TObject);
begin
  Application.HelpContext(Owner.Helpcontext);
end;


procedure TsColorDialogForm.sBitBtn3Click(Sender: TObject);
begin
  if AddPal.ItemIndex <> -1 then
    AddPal.Colors[AddPal.ItemIndex] := sEditHex.Text
  else begin
    AddPal.Colors[CurrCustomIndex] := sEditHex.Text;
    if CurrCustomIndex < AddPal.Colors.Count - 1 then
      inc(CurrCustomIndex)
  end;
  AddPal.GenerateColors;
  AddPal.SkinData.Invalidate;
end;


procedure TsColorDialogForm.ExitPanels;
begin
  if MainPal.ItemIndex <> - 1 then
    if MainPal.ColorValue <> SelectedPanel.Brush.Color then
      MainPal.ItemIndex := -1;
      
  if AddPal.ItemIndex <> - 1 then
    if AddPal.ColorValue <> SelectedPanel.Brush.Color then begin
      CurrCustomIndex := AddPal.ItemIndex;
      AddPal.ItemIndex := -1;
    end;
end;


procedure TsColorDialogForm.sSpeedButton1Click(Sender: TObject);
var
  DC, SavedDC: hdc;
  PickForm: TForm;
  p: TPoint;
begin
  Bmp := TBitmap.Create;
  Bmp.Width := Monitor.Width;
  Bmp.Height := Monitor.Height;
  DC := GetDC(0);
  SavedDC := SaveDC(DC);
  try
    BitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.width, Bmp.height, dc, Monitor.Left, Monitor.Top, SRCCOPY);
    PickForm := TForm.Create(Application);
    PickForm.Visible := False;
    PickForm.BorderStyle := bsNone;
    PickForm.Tag := ExceptTag;
    PickForm.DoubleBuffered := True;

    p := SelectedPanel.ClientToScreen(MkPoint);
    PickPanel := TsPanel.Create(PickForm);
    PickPanel.SkinData.CustomColor := True;
    PickPanel.SkinData.SkinSection := s_Transparent;
    PickPanel.BorderStyle := bsNone;
    PickPanel.BevelOuter := bvNone;
    PickPanel.ParentCtl3D := False;
    PickPanel.Ctl3D := False;
    PickPanel.Width := SelectedPanel.Width;
    PickPanel.Height := SelectedPanel.Height;
    PickPanel.Color := SelectedPanel.Brush.Color;
    PickPanel.Left := p.x;
    PickPanel.Top := p.y;
    PickPanel.Parent := PickForm;
    PickPanel.Visible := True;

    PickForm.OnMouseMove := PickFormMouseMove;
    PickForm.Cursor := crHandPoint;
    PickForm.Cursor := crASPipette;
    PickForm.WindowState := wsMaximized;
    PickForm.OnPaint := PickFormPaint;
    PickForm.OnMouseDown := PickFormMouseDown;
    PickForm.OnKeyDown := PickFormKeyDown;
    PickForm.ShowModal;
    FreeAndNil(PickPanel);
    FreeAndNil(PickForm);
  finally
    RestoreDC(DC, SavedDC);
    FreeAndNil(Bmp);
  end;
end;


procedure TsColorDialogForm.PickFormPaint(Sender: TObject);
begin
  BitBlt(TForm(Sender).Canvas.Handle, 0, 0, Bmp.width, Bmp.height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
end;


procedure TsColorDialogForm.PickFormMouseDown(Sender: TObject;  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  PickColor := Bmp.Canvas.Pixels[x, y];
  SetCurrentColor(PickColor);
  TForm(Sender).Close;
end;


procedure TsColorDialogForm.PickFormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 27 then
    TForm(Sender).Close
end;


procedure TsColorDialogForm.PickFormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if PickPanel <> nil then begin
    PickColor := Bmp.Canvas.Pixels[x, y];
    PickPanel.Color := PickColor;
    PickPanel.Repaint;
  end;
end;


procedure TsColorDialogForm.InitLngCaptions;
begin
  sBitBtn1.Caption := acs_MsgDlgOK;
  sBitBtn2.Caption := acs_MsgDlgCancel;
  sBitBtn3.Caption := acs_ColorDlgAdd;
  sBitBtn4.Caption := acs_ColorDlgDefine;
  sBitBtn5.Caption := acs_MsgDlgHelp;
  sLabel2. Caption := acs_ColorDlgAddPal;
  Caption := acs_ColorDlgTitle;
  sREdit.BoundLabel.Caption := acs_ColorDlgRed;
  sGEdit.BoundLabel.Caption := acs_ColorDlgGreen;
  sBEdit.BoundLabel.Caption := acs_ColorDlgBlue;
  sEditHex.BoundLabel.Caption := acs_ColorDlgHex;
  sEditDecimal.BoundLabel.Caption := acs_ColorDlgDecimal;
end;


function TsColorDialogForm.MarkerRect: TRect;
begin
  Result := Rect(GradPanel.Left + GradPanel.Width, 0, Width, GradPanel.Top + GradPanel.Height + 4);
end;


procedure TsColorDialogForm.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  R: TRect;
begin
  R := MarkerRect;
  inc(R.Top, GradPanel.Top);
  R.Bottom := GradPanel.Top + GradPanel.Height;
  if PtInRect(R, Point(x, y)) then
    GradPanel.OnMouseDown(GradPanel, Button, Shift, X - GradPanel.Left - GradPanel.Width, Y - GradPanel.Top);
end;


procedure TsColorDialogForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  R: TRect;
begin
  R := MarkerRect;
  inc(R.Top, GradPanel.Top);
  R.Bottom := GradPanel.Top + GradPanel.Height;
  if PtInRect(R, Point(x, y)) then
    GradPanel.OnMouseMove(GradPanel, Shift, X - GradPanel.Left - GradPanel.Width, Y - GradPanel.Top);
end;


procedure TsColorDialogForm.FormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  R: TRect;
begin
  R := MarkerRect;
  inc(R.Top, GradPanel.Top);
  R.Bottom := GradPanel.Top + GradPanel.Height;
  if PtInRect(R, Point(x, y)) then
    GradPanel.OnMouseUp(GradPanel, Button, Shift, X - GradPanel.Left - GradPanel.Width, Y - GradPanel.Top);
end;


procedure TsColorDialogForm.MainPalDblClick(Sender: TObject);
begin
  sBitBtn1.Click
end;


procedure TsColorDialogForm.AddPalDblClick(Sender: TObject);
begin
  sBitBtn1.Click
end;


destructor TsColorDialogForm.Destroy;
begin
  if TmpBmp <> nil then
    FreeAndNil(TmpBmp);
    
  inherited;
end;


initialization
  Screen.Cursors[crASPipette] := LoadCursor(HInstance, 'CRASPIPETTE');

end.
