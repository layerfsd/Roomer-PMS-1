unit acMeter;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  Windows, Graphics, SysUtils, Classes, Controls, Messages, ImgList;


{$IFNDEF NOTFORHELP}
const
  DefaultSize = 160;
{$ENDIF}


type
{$IFNDEF NOTFORHELP}
  TMeterPaintData = class;

  TMeterDialType = (dtNumbers, dtGradient);
  TContentType = (ctGradient, ctValues, ctNone, ctCustomImage);

  TMeterShadowData = class(TPersistent)
  private
    FVisible: boolean;
    procedure SetVisible(const Value: boolean);
  protected
    FOwner: TMeterPaintData;
  public
    constructor Create(AOwner: TMeterPaintData);
  published
    property Visible: boolean read FVisible write SetVisible default True;
  end;
{$ENDIF}

  TMeterPaintData = class(TPersistent)
{$IFNDEF NOTFORHELP}
  private
    FDialShadow,
    FArrowShadow: TMeterShadowData;

    FStretched,
    FTransparent: boolean;

    FColor,
    FDialColor,
    FArrowColor: TColor;

    FBackgroundImage: TBitmap;
    procedure SetBackgroundImage(const Value: TBitmap);
    procedure SetShadowData     (const Index: Integer; const Value: TMeterShadowData);
    procedure SetBoolean        (const Index: Integer; const Value: boolean);
    procedure SetColor          (const Index: Integer; const Value: TColor);
  protected
    FOwner: TGraphicControl;
  public
    constructor Create(AOwner: TGraphicControl);
    destructor Destroy; override;
  published
{$ENDIF}
    property BackgroundImage: TBitmap read FBackgroundImage write SetBackgroundImage;
    property ArrowColor: TColor index 0 read FArrowColor write SetColor default clBlack;
    property Color:      TColor index 1 read FColor      write SetColor default clWhite;
    property DialColor:  TColor index 2 read FDialColor  write SetColor default clBlack;
    property ArrowShadow: TMeterShadowData index 0 read FArrowShadow write SetShadowData;
    property DialShadow:  TMeterShadowData index 0 read FDialShadow  write SetShadowData;
    property Stretched:   boolean index 0 read FStretched   write SetBoolean default False;
    property Transparent: boolean index 1 read FTransparent write SetBoolean default False;
  end;


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsMeter = class(TGraphicControl)
{$IFNDEF NOTFORHELP}
  private
    FMin,
    FMax,
    FPosition,
    ArrowLength,
    UpdateCount,
    FGlyphIndex,
    FTickStepBig,
    FTickStepSmall: integer;

    FTextMax,
    FTextMin: string;

    FShowTicks,
    FShowMinMax,
    FShowCaption,
    FIgnoreBounds: boolean;

    FImages: TCustomImageList;
    FShowMinMaxValue: boolean;
    FContentType: TContentType;
    FShowCaptionValue: boolean;
    FPaintData: TMeterPaintData;
    FImageChangeLink: TChangeLink;
    procedure ImageListChange(Sender: TObject);
    procedure SetContentType(const Value: TContentType);
    procedure SetPaintData  (const Value: TMeterPaintData);
    procedure SetImages     (const Value: TCustomImageList);
    procedure SetInteger    (const Index, Value: integer);
    procedure SetBoolean    (const Index: Integer; const Value: boolean);
    procedure SetText       (const Index: Integer; const Value: string);
  protected
    Screw,
    Cache,
    Circle,
    ColorLine,
    ShadowLayer,
    ScrewShadow,
    ArrowCircle: TBitmap;

    Center: TPoint;
    MeterSize: TSize;
    procedure Paint; override;
    function GetMargin: real;
    procedure PrepareCache;
    function GetMinRect: TRect;
    function GetMaxRect: TRect;
    procedure Init;
    function GetLineCoord(aAngle: real; aRadius: real = 0): TPoint; // Angle from 0 to 120
    function GetPaintColor(IsArrow: boolean): TColor;
    function PosToRad(Pos: integer): real;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    function GetCaptionRect: TRect;
    constructor Create(AOwner: TComponent); override;
    procedure WndProc(var Message: TMessage); override;
    procedure AfterConstruction; override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure BeginUpdate;
    procedure EndUpdate(DoRepaint: boolean);
  published
    property Align;
    property Anchors;
    property Caption;
    property Font;
    property Constraints;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Height default DefaultSize;
    property Width default DefaultSize;
    property Visible;
{$ENDIF}
    property ContentType:   TContentType    read FContentType   write SetContentType default ctGradient;
    property PaintData:     TMeterPaintData read FPaintData     write SetPaintData;

    property Max:           integer index 0 read FMax           write SetInteger default 100;
    property Min:           integer index 1 read FMin           write SetInteger default 0;
    property Position:      integer index 2 read FPosition      write SetInteger default 40;
    property TickStepSmall: integer index 3 read FTickStepSmall write SetInteger default 5;
    property TickStepBig:   integer index 4 read FTickStepBig   write SetInteger default 25;
    property GlyphIndex:    integer index 5 read FGlyphIndex    write SetInteger default -1;

    property TextMax:       string  index 0 read FTextMax       write SetText;
    property TextMin:       string  index 1 read FTextMin       write SetText;

    property ShowCaption:      boolean index 0 read FShowCaption      write SetBoolean default True;
    property ShowMinMax:       boolean index 1 read FShowMinMax       write SetBoolean default True;
    property ShowTicks:        boolean index 2 read FShowTicks        write SetBoolean default True;
    property IgnoreBounds:     boolean index 3 read FIgnoreBounds     write SetBoolean default False;
    property ShowCaptionValue: boolean index 4 read FShowCaptionValue write SetBoolean default False;
    property ShowMinMaxValue:  boolean index 5 read FShowMinMaxValue  write SetBoolean default False;

    property Images: TCustomImageList read FImages write SetImages;

{$IFNDEF NOTFORHELP}
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
{$ENDIF}
  end;

implementation

uses Math,
  sGraphUtils, sVCLUtils, sCommonData, sConst, acntUtils, acPng, sAlphaGraph, sMessages;

{$R acMeter.res}

const
  s_Max = 'MAX';
  s_Min = 'MIN';
  ImgSize = DefaultSize - 2;
  MinSize = 16;
  LineWidth = 2;

var
  resScrew,
  resColorLine,
  resCircleLine,
  resArrowCircle,
  resScrewShadow: TBitmap;


procedure DrawAntialisedLine(Bmp: TBitmap; const AX1, AY1, AX2, AY2: real; const LineColor: TColor);
var
  Swapped: boolean;
  C_: TsColor;

  procedure Plot(const x, y: integer; c: real);
  var
    ResClr: TsColor;
  begin
    if BetWeen(y, 0, Bmp.Height - 1) and BetWeen(x, 0, Bmp.Width - 1) then begin
      ResClr := GetAPixel(Bmp, iff(Swapped, y, x), iff(Swapped, x, y));
      ResClr.R := Round(ResClr.R * (1 - c) + C_.R * c);
      ResClr.G := Round(ResClr.G * (1 - c) + C_.G * c);
      ResClr.B := Round(ResClr.B * (1 - c) + C_.B * c);
      SetAPixel(Bmp, iff(Swapped, y, x), iff(Swapped, x, y), ResClr);
    end;
  end;

  function rfrac(const x: real): real;
  begin
    rfrac := 1 - frac(x);
  end;

  procedure swap(var a, b: real);
  var
    tmp: real;
  begin
    tmp := a;
    a := b;
    b := tmp;
  end;

var
  x1, x2, y1, y2, dx, dy, gradient, xend, yend, xgap, xpxl1, ypxl1, xpxl2, ypxl2, intery: real;
  x: integer;
begin
  x1 := AX1;
  x2 := AX2;
  y1 := AY1;
  y2 := AY2;
  dx := x2 - x1;
  dy := y2 - y1;
  Swapped := abs(dx) < abs(dy);
  C_.C := SwapRedBlue(LineColor);
  if swapped then begin
    swap(x1, y1);
    swap(x2, y2);
    swap(dx, dy);
  end;
  if x2 < x1 then begin
    swap(x1, x2);
    swap(y1, y2);
  end;
  if dx <> 0 then begin
    gradient := dy / dx;
    xend := round(x1);
    yend := y1 + gradient * (xend - x1);
    xgap := rfrac(x1 + 0.5);
    xpxl1 := xend;
    ypxl1 := floor(yend);
    plot(Round(xpxl1), Round(ypxl1), rfrac(yend) * xgap);
    plot(Round(xpxl1), Round(ypxl1) + 1, frac(yend) * xgap);
    intery := yend + gradient;
    xend := round(x2);
    yend := y2 + gradient * (xend - x2);
    xgap := frac(x2 + 0.5);
    xpxl2 := xend;
    ypxl2 := floor(yend);
    plot(Round(xpxl2), Round(ypxl2), rfrac(yend) * xgap);
    plot(Round(xpxl2), Round(ypxl2) + 1, frac(yend) * xgap);
    for x := round(xpxl1) + 1 to round(xpxl2) - 1 do begin
      plot(Round(x), floor(intery), rfrac(intery));
      plot(Round(x), floor(intery) + 1, frac(intery));
      intery := intery + gradient;
    end;
  end;
end;


procedure DrawBoldLine(Bmp: TBitmap; const AX1, AY1, AX2, AY2: real; const aWidth: integer; const LineColor: TColor);
var
  dw, i, j: integer;
begin
  dw := aWidth div 2;
  for j := -dw + 1 to dw do
    for i := -dw + 1 to dw do
      DrawAntialisedLine(Bmp, AX1 - j, AY1 - i, AX2 - j, AY2 - i, LineColor);
end;


procedure TsMeter.AfterConstruction;
begin
  inherited;
  if FTextMax = '' then
    FTextMax := s_Max;

  if FTextMin = '' then
    FTextMin := s_Min;
end;


procedure TsMeter.BeginUpdate;
begin
  inc(UpdateCount);
end;


constructor TsMeter.Create(AOwner: TComponent);
begin
  inherited;
  Height := DefaultSize;
  Width := DefaultSize;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FMax := 100;
  FMin := 0;
  FPosition := 40;
  FTickStepSmall := 5;
  FTickStepBig := 25;
  FGlyphIndex := -1;
  FShowCaption := True;
  FShowMinMax  := True;
  FShowTicks   := True;
  FIgnoreBounds := False;
  FShowCaptionValue := False;
  FShowMinMaxValue  := False;

  FContentType := ctGradient;
  FPaintData := TMeterPaintData.Create(Self);
  ControlStyle := ControlStyle + [csOpaque];

  Screw := TBitmap.Create;
  Screw.Assign(resScrew);

  ScrewShadow := TBitmap.Create;
  ScrewShadow.Assign(resScrewShadow);
  ScrewShadow.PixelFormat := pf32Bit;
  FillAlphaRect(ScrewShadow, MkRect(ScrewShadow), MaxByte);
end;


destructor TsMeter.Destroy;
begin
  FPaintData.Free;
  Screw.Free;
  Cache.Free;
  Circle.Free;
  ColorLine.Free;
  ArrowCircle.Free;
  ScrewShadow.Free;
  ShadowLayer.Free;
  FreeAndNil(FImageChangeLink);
  inherited;
end;


procedure TsMeter.EndUpdate(DoRepaint: boolean);
begin
  dec(UpdateCount);
  if DoRepaint and (UpdateCount <= 0) then
    Repaint;
end;


function TsMeter.GetPaintColor(IsArrow: boolean): TColor;
var
  p: TPoint;
  C: TsColor;

  function GetGradColor: TColor;
  begin
    p := GetLineCoord(PosToRad(FPosition), 8 + GetMargin + ArrowLength);
    C := GetAPixel(ColorLine, p.X, p.Y);
    C.A := 0;
    Result := SwapRedBlue(C.C);
  end;

begin
  if IsArrow then
    if PaintData.FArrowColor = clNone then
      Result := GetGradColor
    else
      Result := PaintData.FArrowColor
  else
    if PaintData.FDialColor = clNone then
      Result := GetGradColor
    else
      Result := PaintData.FDialColor
end;


function TsMeter.GetCaptionRect: TRect;
begin
  Result.Top    := MeterSize.cy div 2 + MeterSize.cy div 7;
  Result.Left   := MeterSize.cx div 4;
  Result.Bottom := MeterSize.cy - MeterSize.cy div 7;
  Result.Right  := MeterSize.cx - MeterSize.cx div 4;
end;


function TsMeter.GetLineCoord(aAngle: real; aRadius: real = 0): TPoint;
begin
  if aRadius = 0 then begin
    Result.X := Center.X - Round(cos(aAngle) * ArrowLength);
    Result.Y := Center.Y - Round(sin(aAngle) * ArrowLength);
  end
  else begin
    Result.X := Center.X - Round(cos(aAngle) * aRadius);
    Result.Y := Center.Y - Round(sin(aAngle) * aRadius);
  end;
end;


function TsMeter.GetMargin: real;
begin
  Result := 4 * MeterSize.cx / ImgSize;
end;


function TsMeter.GetMaxRect: TRect;
var
  Size: TSize;
begin
  Size := acTextExtent(Cache.Canvas, TextMax);
  Result.Left   := MeterSize.cx - Center.X div 7 * 2 - Size.cx;
  Result.Top    := Center.Y + Center.X div 3 + 4;
  Result.Right  := Result.Left + 10;
  Result.Bottom := Result.Top + 10;
end;


function TsMeter.GetMinRect: TRect;
begin
  Result.Left   := Center.X div 7 * 2;
  Result.Top    := Center.Y + Center.X div 3 + 4;
  Result.Right  := Result.Left + 10;
  Result.Bottom := Result.Top + 10;
end;


procedure TsMeter.Init;
var
  TmpBmp: TBitmap;
begin
  if (Width > MinSize) and (Height > MinSize) then begin
    Circle.Free;
    Circle := TBitmap.Create;
    if (ctCustomImage <> ContentType) and (FPaintData.FDialShadow.Visible or FPaintData.FArrowShadow.Visible) then begin
      Circle.Assign(resCircleLine);
      Circle.PixelFormat := pf32Bit;
    end;
    if not FPaintData.Stretched then begin
      MeterSize.cx := ImgSize;
      MeterSize.cy := ImgSize;
    end
    else begin
      MeterSize.cx := Width;
      MeterSize.cy := Height;
    end;

    if ArrowCircle = nil then
      ArrowCircle := TBitmap.Create;

    ArrowCircle.Assign(resArrowCircle);
    ArrowCircle.PixelFormat := pf32Bit;

    if FPaintData.Stretched then begin
      MeterSize.cx := Math.min(Width, Height);
      MeterSize.cy := MeterSize.cx;
    end;

    Center.X := MeterSize.cx div 2;
    Center.Y := Center.X;

    ArrowLength := Center.X div 5 * 3;

    ColorLine.Free;
    ColorLine := TBitmap.Create;
    ColorLine.Assign(resColorLine);

    Cache.Free;
    Cache := CreateBmp32(MeterSize);

    if FPaintData.Stretched and ((MeterSize.cy <> Circle.Height) or (MeterSize.cx <> Circle.Width)) then begin
      TmpBmp := CreateBmp32(MeterSize);
      Stretch(Circle, TmpBmp, MeterSize.cx, MeterSize.cy, ftMitchell);
      Circle.Free;
      Circle := TmpBmp;

      TmpBmp := CreateBmp32(MeterSize);
      Stretch(ColorLine, TmpBmp, MeterSize.cx, MeterSize.cy, ftMitchell);
      ColorLine.Free;
      ColorLine := TmpBmp;
    end;
//    BitBlt(Circle.Canvas.Handle, Center.X - ArrowCircle.Width div 2, Center.Y - ArrowCircle.Height div 2, ArrowCircle.Width, ArrowCircle.Height,
//           ArrowCircle.Canvas.Handle, 0, 0, SRCCOPY);
  end;
end;


procedure TsMeter.Loaded;
begin
  inherited;
  if FTextMax = '' then
    FTextMax := s_Max;

  if FTextMin = '' then
    FTextMin := s_Min;
end;


procedure TsMeter.Paint;
var
  BGInfo: TacBGInfo;

  procedure FillBG(DC: hdc; R: TRect);
  begin
    if BGInfo.BgType = btCache then
      BitBlt(DC, R.Left, R.Top, WidthOf(R), HeightOf(R), BGInfo.Bmp.Canvas.Handle, Left + R.Left + BGInfo.Offset.X, Top + R.Top +BGInfo.Offset.Y, SRCCOPY)
    else
      if BGInfo.BgType = btFill then
        FillDC(DC, R, BGInfo.Color)
      else
        FillDC(DC, R, TsHackedControl(Parent).Color);
  end;

begin
  if (Width > MinSize) and (Height > MinSize) and (UpdateCount <= 0) then begin
    Init;
    BGInfo.BgType := btUnknown;
    BGInfo.PleaseDraw := False;
    BGInfo.FillRect := MkRect;
    SendMessage(Parent.Handle, SM_ALPHACMD, MakeWParam(0, AC_GETBG), LPARAM(@BGInfo));
    FillBG(Cache.Canvas.Handle, MkRect(Cache));
    PrepareCache;
    if Cache.Width < Width then
      FillBG(Canvas.Handle, Rect(Cache.Width, 0, Width, Height));

    if Cache.Height < Height then
      FillBG(Canvas.Handle, Rect(0, Cache.Height, Width, Height));

    BitBlt(Canvas.Handle, 0, 0, Cache.Width, Cache.Height, Cache.Canvas.Handle, 0, 0, SRCCOPY);
  end;
end;


function TsMeter.PosToRad(Pos: integer): real;
const
  ExtAngle = 20;
var
  Grad: real;
  iRange, iPos: integer;
begin
  iRange := FMax - FMin;
  iPos := Pos - FMin;
  Grad := ((180 + 2 * ExtAngle) / iRange) * iPos - ExtAngle;
  Result := Grad * Pi / 180;
end;


procedure TsMeter.PrepareCache;
const
  ShadowOffset: TPoint = (X: 1; Y: 1);
  ShadowBlur = 2;
var
  R: TRect;
  Rad: real;
  s: string;
  C_: TsColor;
  SavedDC: hdc;
  TextSize: TSize;
  i, gr, Margin: integer;
  Coord1, Coord2: TPoint;

  function PaintText: TRect;
  begin
    Cache.Canvas.Font.Assign(Font);
    Cache.Canvas.Brush.Style := bsClear;
    if ShowMinMax then begin
      R := GetMinRect;
      if ShowMinMaxValue then
        acDrawText(Cache.Canvas.Handle, IntToStr(Min), R, DT_NOCLIP)
      else
        acDrawText(Cache.Canvas.Handle, FTextMin, R, DT_NOCLIP);

      R := GetMaxRect;
      if ShowMinMaxValue then
        acDrawText(Cache.Canvas.Handle, IntToStr(Max), R, DT_NOCLIP)
      else
        acDrawText(Cache.Canvas.Handle, FTextMax, R, DT_NOCLIP);
    end;
    Result := GetCaptionRect;
    if ShowCaption then
      if ShowCaptionValue then
        acDrawText(Cache.Canvas.Handle, IntToStr(Position), Result, DT_NOCLIP or DT_CENTER or DT_VCENTER or DT_WORDBREAK)
      else
        acDrawText(Cache.Canvas.Handle, Caption, Result, DT_NOCLIP or DT_CENTER or DT_VCENTER or DT_WORDBREAK)
  end;

  procedure BlendTransBmpByMask(SrcBmp, MskBmp: Graphics.TBitMap; const BlendColor: TsColor);
  var
    S0, S: PRGBAArray;
    DeltaS, X, Y: Integer;
  begin
    if InitLine(MskBmp, Pointer(S0), DeltaS) then
      for Y := 0 to MskBmp.Height - 1 do begin
        S := Pointer(LongInt(S0) + DeltaS * Y);
        for X := 0 to MskBmp.Width - 1 do
          with S[X] do
            if I = 16777215 then
              I := -1;
      end;

    BlendBmpByMask(SrcBmp, MskBmp, BlendColor);
  end;

  procedure DrawAngledText(Canvas: TCanvas; s: string; aAngle: integer; Pos: TPoint);
  begin
    SetBkMode(Canvas.Handle, TRANSPARENT);
    MakeAngledFont(Canvas.Handle, Canvas.Font, aAngle);
    TextOut(Canvas.Handle, Pos.X, Pos.Y, PChar(s), Length(s));
  end;

begin
  Margin := Round(GetMargin);
  // Shadows
  if FPaintData.FDialShadow.Visible and (ctCustomImage <> ContentType) or FPaintData.FArrowShadow.Visible then
    if ShadowLayer = nil then
      ShadowLayer := CreateBmp32(MeterSize.cx, MeterSize.cy)
    else begin
      ShadowLayer.Width := MeterSize.cx;
      ShadowLayer.Height := MeterSize.cy;
      FillDC(ShadowLayer.Canvas.Handle, MkRect(ShadowLayer), $FFFFFF);
    end;

  if FPaintData.FDialShadow.Visible and (ctCustomImage <> ContentType) then begin
    ShadowLayer.Canvas.Pen.Color := $AAAAAA;
    ShadowLayer.Canvas.Pen.Width := 2;
    ShadowLayer.Canvas.Brush.Style := bsSolid;
    ShadowLayer.Canvas.Brush.Color := $FFFFFF;
    ShadowLayer.Canvas.Ellipse(Margin + ShadowOffset.X, Margin + ShadowOffset.Y,
        MeterSize.cx - Margin -1{+ ShadowOffset.X}, MeterSize.cy - Margin{ + ShadowOffset.Y});
  end;
  if FPaintData.FArrowShadow.Visible then begin
    BitBlt(ShadowLayer.Canvas.Handle, Center.X - ScrewShadow.Width div 2 + ShadowOffset.X, Center.Y - ScrewShadow.Height div 2 + ShadowOffset.Y, ScrewShadow.Width, ScrewShadow.Height,
           ScrewShadow.Canvas.Handle, 0, 0, SRCCOPY);
    Coord1 := GetLineCoord(PosToRad(FPosition));
    DrawBoldLine(ShadowLayer, Coord1.X + ShadowOffset.X, Coord1.Y + ShadowOffset.Y, Center.X + ShadowOffset.X, Center.Y + ShadowOffset.Y, LineWidth, $999999);
  end;

  if ctCustomImage <> ContentType {FPaintData.BackgroundImage.Empty} then begin
    if FPaintData.FDialShadow.Visible or FPaintData.FArrowShadow.Visible then begin
      FillAlphaRect(ShadowLayer, MkRect(ShadowLayer), MaxByte);
      for i := 0 to ShadowBlur - 1 do
        QBlur(ShadowLayer);

      SavedDC := SaveDC(ShadowLayer.Canvas.Handle);
      try
        ExcludeClipRect(ShadowLayer.Canvas.Handle, Margin, Margin, MeterSize.cx - Margin, MeterSize.cy - Margin);
        FillDC(ShadowLayer.Canvas.Handle, MkRect(ShadowLayer), $FFFFFF);
      finally
        RestoreDC(ShadowLayer.Canvas.Handle, SavedDC);
      end;
    end;

    // BG fill
    if not FPaintData.Transparent then begin
      Cache.Canvas.Brush.Color := ColorToRGB(FPaintData.Color);
      Cache.Canvas.Pen.Style := psClear;
      Cache.Canvas.Ellipse(Margin, Margin, MeterSize.cx - Margin, MeterSize.cx - Margin);
    end;
    if FShowTicks then begin
      // Ticks big
      i := Min;
      Circle.Canvas.Font.Assign(Font);
      while i <= Max do begin
        if i mod TickStepBig = 0 then begin
          Rad := PosToRad(i);
          Coord1 := GetLineCoord(Rad, Center.X - Margin - 1);
          Coord2 := GetLineCoord(Rad, Center.X - ArrowLength div 4);
          DrawBoldLine(Circle, Coord1.X, Coord1.Y, Coord2.X, Coord2.Y, LineWidth, 0);
          if FContentType = ctValues then begin
            s := IntToStr(i);
            TextSize := GetStringSize(Circle.Canvas.Handle, s);
            gr := 90 - Round(Rad * 180 / Pi);

            Coord2.X := Round(Coord2.X - sin(Rad) * (TextSize.cx / 2) + sin(Rad));
            Coord2.Y := Round(Coord2.Y + cos(Rad) * (TextSize.cy / 2) - 2 * cos(Rad));

            DrawAngledText(Circle.Canvas, IntToStr(i), gr * 10, Coord2);
          end;
        end;
        inc(i, TickStepSmall);
      end;
      if FContentType = ctGradient then
        PaintBmp32(Cache, ColorLine);
      // Ticks small
      i := Min;
      while i <= Max do begin
        if i mod TickStepBig <> 0 then begin
          Coord1 := GetLineCoord(PosToRad(i), Center.X - Margin - 1);
          Coord2 := GetLineCoord(PosToRad(i), Center.X - ArrowLength div 5);
          DrawBoldLine(Cache, Coord1.X, Coord1.Y, Coord2.X, Coord2.Y, LineWidth, $BBBBBB);
        end;
        inc(i, TickStepSmall);
      end;
    end;
//    C_.C := 0;
//    if FPaintData.FDialShadow.Visible or FPaintData.FArrowShadow.Visible then
//      BlendTransBmpByMask(Cache, ShadowLayer, C_);
  end
  else
    if not FPaintData.BackgroundImage.Empty then begin
      if FPaintData.BackgroundImage.PixelFormat <> pf32bit then
        BitBlt(Cache.Canvas.Handle, 0, 0, FPaintData.BackgroundImage.Width, FPaintData.BackgroundImage.Height, FPaintData.BackgroundImage.Canvas.Handle, 0, 0, SRCCOPY)
      else
        PaintBmp32(Cache, FPaintData.BackgroundImage);

      if FPaintData.FArrowShadow.Visible then begin
        FillAlphaRect(ShadowLayer, MkRect(ShadowLayer), MaxByte);
        for i := 0 to ShadowBlur - 1 do
          QBlur(ShadowLayer);

        SavedDC := SaveDC(ShadowLayer.Canvas.Handle);
        try
          ExcludeClipRect(ShadowLayer.Canvas.Handle, Margin, Margin, MeterSize.cx - Margin, MeterSize.cy - Margin);
          FillDC(ShadowLayer.Canvas.Handle, MkRect(ShadowLayer), $FFFFFF);
        finally
          RestoreDC(ShadowLayer.Canvas.Handle, SavedDC);
        end;
      end;
    end;

  C_.C := 0;
  if FPaintData.FDialShadow.Visible and (ctCustomImage <> ContentType) or FPaintData.FArrowShadow.Visible then
    BlendTransBmpByMask(Cache, ShadowLayer, C_);

  C_.I := GetPaintColor(False);
  // Arrow
  BlendTransBmpByMask(Cache, Circle, C_);

  Coord1 := GetLineCoord(PosToRad(FPosition));
  DrawBoldLine(Cache, Coord1.X, Coord1.Y, Center.X, Center.Y, LineWidth, GetPaintColor(True));

  C_.C := GetPaintColor(True);
  BlendBmpRectByMask(Cache, ArrowCircle, Point(Center.X - ArrowCircle.Width div 2, Center.Y - ArrowCircle.Height div 2), C_);

  R := PaintText;
  if (Images <> nil) and (FGlyphIndex >= 0) then begin
    Coord1.X := Center.X - Images.Width div 2;
    Coord1.Y := MeterSize.cy - Images.Height - MeterSize.cy div 14;
    Images.Draw(Cache.Canvas, Coord1.X, Coord1.Y, FGlyphIndex);
  end;
  PaintBmpRect32(Cache, Screw, MkRect(Screw), Point(Center.X - Screw.Width div 2, Center.Y - Screw.Height div 2));
end;


procedure TsMeter.SetBoolean(const Index: Integer; const Value: boolean);
begin
  case Index of
    0: if FShowCaption <> Value then begin
      FShowCaption := Value;
      Repaint;
    end;

    1: if FShowMinMax <> Value then begin
      FShowMinMax := Value;
      Repaint;
    end;

    2: if FShowTicks <> Value then begin
      FShowTicks := Value;
      Repaint;
    end;

    3: if FIgnoreBounds <> Value then
      FIgnoreBounds := Value;

    4: if FShowCaptionValue <> Value then begin
      FShowCaptionValue := Value;
      Repaint;
    end;

    5: if FShowMinMaxValue <> Value then begin
      FShowMinMaxValue := Value;
      Repaint;
    end;
  end;
end;


procedure TsMeter.SetContentType(const Value: TContentType);
begin
  if FContentType <> Value then begin
    FContentType := Value;
    Repaint;
  end;
end;


procedure TsMeter.SetInteger(const Index, Value: integer);
begin
  case Index of
    0: if FMax <> Value then begin
      FMax := Value;
      Repaint;
    end;

    1: if FMin <> Value then begin
      FMin := Value;
      Repaint;
    end;

    2: if FPosition <> Value then begin
      if not FIgnoreBounds and (Max <> Min) then
        FPosition := math.max(math.min(Value, Max), Min)
      else
        FPosition := Value;

      Repaint;
    end;

    3: if FTickStepSmall <> Value then begin
      FTickStepSmall := Value;
      Repaint;
    end;

    4: if FTickStepBig <> Value then begin
      FTickStepBig := Value;
      Repaint;
    end;

    5: if FGlyphIndex <> Value then begin
      FGlyphIndex := Value;
      Repaint;
    end;
  end;
end;


constructor TMeterShadowData.Create(AOwner: TMeterPaintData);
begin
  FOwner := AOwner;
  FVisible := True;
end;


procedure TMeterShadowData.SetVisible(const Value: boolean);
begin
  if FVisible <> Value then begin
    FVisible := Value;
    FOwner.FOwner.Repaint;
  end;
end;


function LoadBmpFromRes(Name: string; IsPng: boolean): TBitmap;
var
  rs: TResourceStream;
begin
  rs := TResourceStream.Create(hInstance, Name, RT_RCDATA);
  if IsPng then
    Result := TPNGGraphic.Create
  else
    Result := TBitmap.Create;

  Result.LoadFromStream(rs);
  rs.Free;
end;


constructor TMeterPaintData.Create(AOwner: TGraphicControl);
begin
  FOwner := AOwner;
  Color := clWhite;
  FTransparent := False;
  FStretched := False;
  FArrowColor := clBlack;
  FDialShadow  := TMeterShadowData.Create(Self);
  FArrowShadow := TMeterShadowData.Create(Self);
  FBackgroundImage := TBitmap.Create;
end;


destructor TMeterPaintData.Destroy;
begin
  FDialShadow.Free;
  FArrowShadow.Free;
  FBackgroundImage.Free;
  inherited;
end;


procedure TMeterPaintData.SetBackgroundImage(const Value: TBitmap);
begin
  FBackgroundImage.Assign(Value);
  if not (csLoading in FOwner.ComponentState) then
    FOwner.Repaint;
end;


procedure TMeterPaintData.SetBoolean(const Index: Integer; const Value: boolean);
begin
  case Index of
    0: if FStretched <> Value then begin
      FStretched := Value;
      FOwner.Repaint;
    end;

    1: if FTransparent <> Value then begin
      FTransparent := Value;
      FOwner.Repaint;
    end;
  end;
end;


procedure TMeterPaintData.SetColor(const Index: Integer; const Value: TColor);
begin
  case Index of
    0: if FArrowColor <> Value then begin
      FArrowColor := Value;
      FOwner.Repaint;
    end;

    1: if FColor <> Value then begin
      FColor := Value;
      FOwner.Repaint;
    end;

    2: if FDialColor <> Value then begin
      FDialColor := Value;
      FOwner.Repaint;
    end;
  end;
end;


procedure TMeterPaintData.SetShadowData(const Index: Integer; const Value: TMeterShadowData);
begin
  case Index of
    0: FArrowShadow.Assign(Value);
    1: FDialShadow. Assign(Value);
  end;
end;


procedure TsMeter.SetPaintData(const Value: TMeterPaintData);
begin
  FPaintData.Assign(Value);
end;


procedure TsMeter.SetImages(const Value: TCustomImageList);
begin
  if Images <> Value then begin
    if Images <> nil then
      Images.UnRegisterChanges(FImageChangeLink);

    FImages := Value;
    if Images <> nil then begin
      Images.RegisterChanges(FImageChangeLink);
      Images.FreeNotification(Self);
    end;
    if (Visible or (csDesigning in ComponentState)) and not (csLoading in ComponentState) then
      Repaint;
  end;
end;


procedure TsMeter.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = Images) then
    Images := nil;
end;


procedure TsMeter.ImageListChange(Sender: TObject);
begin
  Repaint;
end;


procedure TsMeter.SetText(const Index: Integer; const Value: string);
begin
  case Index of
    0: if FTextMax <> Value then begin
      FTextMax := Value;
      Repaint;
    end;

    1: if FTextMin <> Value then begin
      FTextMin := Value;
      Repaint;
    end;
  end;
end;


procedure TsMeter.WndProc(var Message: TMessage);
begin
  inherited;
  case Message.Msg of
    CM_TEXTCHANGED:
      if not (csDestroying in ComponentState) then begin
        Repaint;
      end;
  end;
end;


initialization
  resScrew       := LoadBmpFromRes('Screw',       True);
  resColorLine   := LoadBmpFromRes('ColorLine',   True);
  resCircleLine  := LoadBmpFromRes('CircleLine',  True);
  resArrowCircle := LoadBmpFromRes('ArrowCircle', False);
  resScrewShadow := LoadBmpFromRes('ScrewShadow', False);


finalization
  resScrew.Free;
  resColorLine.Free;
  resCircleLine.Free;
  resArrowCircle.Free;
  resScrewShadow.Free;

end.
