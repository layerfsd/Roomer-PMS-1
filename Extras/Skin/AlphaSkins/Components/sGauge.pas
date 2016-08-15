unit sGauge;
{$I sDefs.inc}
//{$DEFINE LOGGED}
//+

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ExtCtrls,
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  sConst, sGraphUtils, sVclUtils, acntUtils, sCommonData, acPNG;


type
  TsGaugeKind = (gkText, gkHorizontalBar, gkVerticalBar, gkPie, gkNeedle);

  TPrintTextEvent = procedure (Sender: TObject; var TextToPrint: string) of Object;

{$IFDEF DELPHI5}
  acInt64 = LongInt;
{$ELSE}
  acInt64 = Int64;
{$ENDIF}


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsGauge = class(TGraphicControl)
{$IFNDEF NOTFORHELP}
  private
    FMinValue,
    FMaxValue,
    FCurValue: acInt64;

    FAnimPos,
    FLongTime: integer;

    FShowText,
    FAnimated,
    FCalcPercents: boolean;

    Light: TBitmap;
    FSuffix: string;
    FKind: TsGaugeKind;
    FOnChange: TNotifyEvent;
    FCommonData: TsCommonData;
    FBorderStyle: TBorderStyle;
    FProgressSkin: TsSkinSection;
    FOnPaintText: TPrintTextEvent;
    FForeColor, FBackColor: TColor;
    procedure PaintBackground(AnImage: TBitmap);
    procedure PaintAsText    (AnImage: TBitmap; PaintRect: TRect);
    procedure PaintAsNothing (AnImage: TBitmap; PaintRect: TRect);
    procedure PaintAsBar     (AnImage: TBitmap; PaintRect: TRect);
    procedure PaintAsPie     (AnImage: TBitmap; PaintRect: TRect);
    procedure PaintAsNeedle  (AnImage: TBitmap; PaintRect: TRect);

    procedure SkinPaintAsText  (aRect: TRect);
    procedure SkinPaintAsBar   (aRect: TRect);
    procedure SkinPaintAsPie   (aRect: TRect);
    procedure SkinPaintAsNeedle(aRect: TRect);
    procedure SkinPaintBody    (aRect: TRect);

    procedure SetGaugeKind(Value: TsGaugeKind);
    procedure SetShowText(Value: Boolean);
    procedure SetMinValue(Value: acInt64);
    procedure SetMaxValue(Value: acInt64);
    procedure SetProgress(Value: acInt64);
    function GetPercentDone: acInt64;
    procedure WMEraseBkGND (var Message: TWMPaint); message WM_ERASEBKGND;
    procedure SetSuffix(const Value: string);
    procedure SetForeColor(const Value: TColor);
    procedure SetBackColor(const Value: TColor);
    procedure SetBorderStyle(const Value: TBorderStyle);
    procedure SetProgressSkin(const Value: TsSkinSection);
    procedure SetCalcPercents(const Value: boolean);
    procedure SetAnimated(const Value: boolean);
  protected
    Timer: TTimer;
    FTmpProgressBmp: TBitmap;
    LightingBmp: TPNGGraphic;
    procedure WndProc (var Message: TMessage); override;
    procedure TimerAction(Sender: TObject);
    function AnimSize: integer;
    function AnimStep: integer;
    procedure UpdateLighting;
  public
    procedure Paint; override;
    procedure PrepareCache;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddProgress(Value: acInt64);
    procedure AfterConstruction; override;
    procedure Loaded; override;
    property PercentDone: acInt64 read GetPercentDone;
    property Color;
  published
    property Align;
    property Anchors;
    property Constraints;
    property Enabled;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property Kind: TsGaugeKind read FKind write SetGaugeKind default gkHorizontalBar;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property CalcPercents: boolean read FCalcPercents write SetCalcPercents default True;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
{$ENDIF} // NOTFORHELP
    property Animated: boolean read FAnimated write SetAnimated default True;
    property SkinData: TsCommonData read FCommonData write FCommonData;
    property BackColor: TColor read FBackColor write SetBackColor default clWhite;
    property ForeColor: TColor read FForeColor write SetForeColor;
    property MinValue: acInt64 read FMinValue write SetMinValue default 0;
    property MaxValue: acInt64 read FMaxValue write SetMaxValue default 100;
    property Progress: acInt64 read FCurValue write SetProgress;
    property ProgressSkin: TsSkinSection read FProgressSkin write SetProgressSkin;
    property ShowText: Boolean read FShowText write SetShowText default True;
    property Suffix: string read FSuffix write SetSuffix;
    property OnPaintText: TPrintTextEvent read FOnPaintText write FOnPaintText;
  end;


var
  AnimLongDelay: integer = 2222;


implementation

uses Consts, math,
  {$IFDEF LOGGED}sDebugMsgs, {$ENDIF}
  sSkinProps, sStyleSimply, sAlphaGraph, sMessages, sSKinManager;


const
  AnimMinHeight = 22;


{ This function solves for x in the equation "x is y% of z". }
function SolveForX(Y, Z: acInt64): acInt64;
begin
  Result := acInt64(Round(Z * (Y * 0.01)));
end;


{ This function solves for y in the equation "x is y% of z". }
function SolveForY(X, Z: acInt64): acInt64;
begin
  if Z = 0 then
    Result := 0
  else
    Result := acInt64(Round(X * (100 / Z)));
end;


constructor TsGauge.Create(AOwner: TComponent);
begin
  FCommonData := TsCommonData.Create(Self, False);
  FCommonData.COC := COC_TsGauge;
  inherited Create(AOwner);
  Timer := TTimer.Create(Self);
  Timer.Enabled := False;
  Timer.Interval := acTimerInterval;
  Timer.OnTimer := TimerAction;
  FLongTime := AnimLongDelay + 1;
  FAnimPos := 9999;
  ControlStyle := ControlStyle + [csOpaque];

  FMinValue := 0;
  FMaxValue := 100;
  FAnimated := True;
  FTmpProgressBmp := nil;
  FCalcPercents := True;
  FKind := gkHorizontalBar;
  FShowText := True;
  FBorderStyle := bsSingle;
  FForeColor := clBlack;
  FBackColor := clWhite;
  Width := 120;
  Height := 30;
  FSuffix := '%';
  LightingBmp := nil;
end;


function TsGauge.GetPercentDone: acInt64;
begin
  Result := SolveForY(FCurValue - FMinValue, FMaxValue - FMinValue);
end;


procedure TsGauge.Paint;
var
  TheImage: TBitmap;
  OverlayImage: TBitmap;
  PaintRect: TRect;
begin
  if (Width > 0) and (Height > 0) then
    if FCommonData.Skinned then
      if FCommonData.Updating then
        SetPixel(Canvas.Handle, 0, 0, clFuchsia)
      else begin
        PrepareCache;
        UpdateCorners(FCommonData, 0);

        BitBlt(Canvas.Handle, 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
        FreeAndNil(FCommonData.FCacheBmp);
      end
    else
      with Canvas do begin
        TheImage := CreateBmp32(Width, Height);
        try
          PaintBackground(TheImage);
          PaintRect := ClientRect;
          if FBorderStyle = bsSingle then
            InflateRect(PaintRect, -1, -1);

          OverlayImage := CreateBmpLike(TheImage);
          OverlayImage.Canvas.Brush.Color := clWindowFrame;
          OverlayImage.Canvas.Brush.Style := bsSolid;
          OverlayImage.Canvas.FillRect(MkRect(Self));
          try
            PaintBackground(OverlayImage);
            case FKind of
              gkText:
                PaintAsNothing(OverlayImage, PaintRect);

              gkHorizontalBar, gkVerticalBar:
                PaintAsBar(OverlayImage, PaintRect);

              gkPie:
                PaintAsPie(OverlayImage, PaintRect);

              gkNeedle:
                PaintAsNeedle(OverlayImage, PaintRect);
            end;
            TheImage.Canvas.CopyMode := cmSrcInvert;
            TheImage.Canvas.Draw(0, 0, OverlayImage);
            TheImage.Canvas.CopyMode := cmSrcCopy;
            if FShowText then
              PaintAsText(TheImage, PaintRect);
          finally
            OverlayImage.Free;
          end;
          Canvas.CopyMode := cmSrcCopy;
          Canvas.Draw(0, 0, TheImage);
        finally
          TheImage.Destroy;
        end;
      end;
end;


procedure TsGauge.SkinPaintAsText(aRect: TRect);
var
  S: string;
begin
  S := Format('%d%', [iff(FCalcPercents, PercentDone, FCurValue)]) + FSuffix;
  if Assigned(FOnPaintText) then
    FOnPaintText(Self, S);

  FCommonData.FCacheBmp.Canvas.Font.Assign(Font);
  FCommonData.FCacheBmp.Canvas.Pen.Style := psInsideFrame;
  FCommonData.FCacheBmp.Canvas.Brush.Style := bsClear;
  WriteTextEx(FCommonData.FCacheBmp.Canvas, PChar(s), Enabled, aRect, GetStringFlags(Self, taCenter) or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE, FCommonData, False)
end;


procedure TsGauge.SkinPaintAsBar(aRect: TRect);
var
  CI: TCacheInfo;
  IsVert: boolean;
  FillSize: acInt64;
  pSkinSection, s: string;
  bRect, R1, R2, RR: TRect;
  W, H, X, RgnIndex, index: integer;
  TempBmp, MaskBmp, SrcBmp, LightBmp, RtSrc: TBitmap;

  function GetFillSize: integer;
  begin
    if MaxValue - MinValue > 0 then
      Result := min(Round(W * ((Progress - MinValue) / (MaxValue - MinValue))), W)
    else
      Result := 0;
  end;

begin
  RgnIndex := -1;
  CI := MakeCacheInfo(FCommonData.FCacheBmp);
  bRect := aRect;
  MaskBmp := nil;
  IsVert := Kind = gkVerticalBar;
  if ProgressSkin <> '' then
    pSkinSection := ProgressSkin
  else
    pSkinSection := iff(not IsVert or (Animated and SkinData.SkinManager.Effects.AllowAnimation), s_ProgressH, s_ProgressV);

  Index := FCommonData.SkinManager.GetSkinIndex(pSkinSection);
  RtSrc := nil;
  if not IsVert or (Animated and SkinData.SkinManager.Effects.AllowAnimation) or not FCommonData.SkinManager.IsValidSkinIndex(Index) then begin
    if IsVert then begin
      if not FCommonData.SkinManager.IsValidSkinIndex(Index) then begin
        pSkinSection := s_ProgressH;
        Index := FCommonData.SkinManager.GetSkinIndex(pSkinSection);
      end;
      W := HeightOf(aRect, True);
      H := WidthOf(aRect, True);
      RtSrc := CreateBmp32(H, W);
      FillSize := GetFillSize;
      BitBlt(RtSrc.Canvas.Handle, 0, 0, RtSrc.Width, RtSrc.Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
      RtSrc := MakeRotated90(RtSrc, True, True);
      CI.Bmp := RtSrc;
    end
    else begin
      W := WidthOf(aRect, True);
      H := HeightOf(aRect, True);
      FillSize := GetFillSize;
    end;
    TempBmp := CreateBmp32(W, H);
    if FillSize > 0 then
      if FCommonData.SkinManager.IsValidSkinIndex(Index) then begin
        bRect.Right := FillSize;
        bRect.Bottom := H;
        TempBmp.Width := WidthOf(bRect, True);
        if Animated and SkinData.SkinManager.Effects.AllowAnimation and (FAnimPos < Fillsize + AnimSize) then begin // Prepare mask of region
          if (Light = nil) or (AnimSize <> Light.Width) or (iff(Kind = gkVerticalBar, Width, Height) <> Light.Height) then
            UpdateLighting;

          R1 := MkRect(TempBmp);
          R2 := MkRect(Light);
          OffsetRect(R2, FAnimPos, 0);
          RR := RectsAnd(R1, R2);
          if not SkinData.SkinManager.gd[SkinData.SkinIndex].ReservedBoolean then begin
            RgnIndex := FCommonData.SkinManager.GetMaskIndex(Index, pSkinSection, s_LightRegion);
            if (WidthOf(RR) > 0) and FCommonData.SkinManager.IsValidImgIndex(RgnIndex) then begin
              CI.Ready := False;
              CI.FillColor := clWhite;
              DrawSkinRect(TempBmp, MkRect(TempBmp), CI, FCommonData.SkinManager.ma[RgnIndex], 0, False);
              MaskBmp := CreateBmp32(RR);
              BitBlt(MaskBmp.Canvas.Handle, 0, 0, MaskBmp.Width, MaskBmp.Height, TempBmp.Canvas.Handle, RR.Left, RR.Top, SRCCOPY);
              CI.Ready := True;
            end;
          end;

        end;
        if (FTmpProgressBmp <> nil) and (TempBmp.Width = FTmpProgressBmp.Width) and (TempBmp.Height = FTmpProgressBmp.Height) then
          BitBlt(TempBmp.Canvas.Handle, 0, 0, TempBmp.Width, TempBmp.Height, FTmpProgressBmp.Canvas.Handle, 0, 0, SRCCOPY)
        else begin
          if SkinData.SkinManager.gd[SkinData.SkinIndex].ReservedBoolean then
            PaintItemBG(Index, CI, 0, MkRect(FillSize, H), MkPoint, TempBmp, FCommonData.SkinManager)
          else
            PaintItem(Index, CI, True, 0, MkRect(FillSize, H), MkPoint, TempBmp, FCommonData.SkinManager);

          if FTmpProgressBmp = nil then
            FTmpProgressBmp := CreateBmp32(TempBmp)
          else begin
            FTmpProgressBmp.Width  := TempBmp.Width;
            FTmpProgressBmp.Height := TempBmp.Height;
          end;
          BitBlt(FTmpProgressBmp.Canvas.Handle, 0, 0, TempBmp.Width, TempBmp.Height, TempBmp.Canvas.Handle, 0, 0, SRCCOPY);
        end;
        if Animated and SkinData.SkinManager.Effects.AllowAnimation and (FAnimPos < Fillsize + AnimSize) then
          if (WidthOf(RR) > 0) and FCommonData.SkinManager.IsValidImgIndex(RgnIndex) and not SkinData.SkinManager.gd[SkinData.SkinIndex].ReservedBoolean then begin
            SrcBmp := CreateBmp32(RR);
            LightBmp := CreateBmp32(RR);
            if R2.Left < 0 then
              X := -R2.Left
            else
              X := 0;

            BitBlt(SrcBmp.Canvas.Handle, 0, 0, SrcBmp.Width, SrcBmp.Height, TempBmp.Canvas.Handle, RR.Left, RR.Top, SRCCOPY);
            BitBlt(LightBmp.Canvas.Handle, 0, 0, LightBmp.Width, LightBmp.Height, Light.Canvas.Handle, X, RR.Top, SRCCOPY);
            SumByMaskWith32(SrcBmp, LightBmp, MaskBmp, MkRect(WidthOf(RR, True), HeightOf(RR, True)));
            BitBlt(TempBmp.Canvas.Handle, RR.Left, RR.Top, SrcBmp.Width, SrcBmp.Height, SrcBmp.Canvas.Handle, 0, 0, SRCCOPY);
            SrcBmp.Free;
            LightBmp.Free;
            MaskBmp.Free;
          end
          else begin
            if R2.Left < 0 then
              R2.Left := -R2.Left
            else
              R2.Left := 0;

            R2.Right := R2.Left + WidthOf(RR, True);
            CopyBmp32(RR, R2, TempBmp, Light, EmptyCI, False, clNone, 0, False);
          end;

        if RtSrc <> nil then begin
          TempBmp := MakeRotated90(TempBmp, False, True);
          if FShowText then begin
            S := Format('%d%', [iff(FCalcPercents, PercentDone, FCurValue)]) + FSuffix;
            TempBmp.Canvas.Font.Assign(Font);
            TempBmp.Canvas.Pen.Style := psInsideFrame;
            TempBmp.Canvas.Brush.Style := bsClear;
            OffsetRect(aRect, 0, FillSize - Height);
            WriteTextEx(TempBmp.Canvas, PChar(s), Enabled, aRect, GetStringFlags(Self, taCenter) or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE, Index, False, SkinData.SkinManager);
          end;
          BitBlt(FCommonData.FCacheBmp.Canvas.Handle, 0, Height - FillSize, TempBmp.Width, FillSize, TempBmp.Canvas.Handle, 0, 0, SRCCOPY);
        end
        else begin
          if FShowText then begin
            S := Format('%d%', [iff(FCalcPercents, PercentDone, FCurValue)]) + FSuffix;
            if Assigned(FOnPaintText) then
              FOnPaintText(Self, S);

            TempBmp.Canvas.Font.Assign(Font);
            TempBmp.Canvas.Pen.Style := psInsideFrame;
            TempBmp.Canvas.Brush.Style := bsClear;
            WriteTextEx(TempBmp.Canvas, PChar(s), Enabled, aRect, GetStringFlags(Self, taCenter) or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE, Index, False, SkinData.SkinManager);
          end;
          BitBlt(FCommonData.FCacheBmp.Canvas.Handle, aRect.Left, aRect.Top, TempBmp.Width, H, TempBmp.Canvas.Handle, 0, 0, SRCCOPY);
        end;
      end;

    if RtSrc <> nil then
      FreeAndNil(RtSrc);
  end
  else begin
    W := WidthOf(aRect, True);
    H := HeightOf(aRect, True);
    TempBmp := CreateBmp32(W, H);
    FillSize := SolveForX(PercentDone, H);
    if FillSize >= H then
      FillSize := H;

    if FillSize > 0 then
      if FCommonData.SkinManager.IsValidSkinIndex(Index) then begin
        bRect.Top := Height - FillSize;
        H := HeightOf(bRect);
        TempBmp.Height := H;
        PaintItem(Index, CI, True, 0, MkRect(W, H), bRect.TopLeft, TempBmp, FCommonData.SkinManager);
        if FShowText then begin
          S := Format('%d%', [iff(FCalcPercents, PercentDone, FCurValue)]) + FSuffix;
          if Assigned(FOnPaintText) then
            FOnPaintText(Self, S);

          TempBmp.Canvas.Font.Assign(Font);
          TempBmp.Canvas.Pen.Style := psInsideFrame;
          FCommonData.FCacheBmp.Canvas.Brush.Style := bsClear;
          OffsetRect(aRect, 0, -bRect.Top);
          WriteTextEx(TempBmp.Canvas, PChar(s), Enabled, aRect, GetStringFlags(Self, taCenter) or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE, Index, False, SkinData.SkinManager);
        end;

        BitBlt(FCommonData.FCacheBmp.Canvas.Handle, bRect.Left, bRect.Top, W, H, TempBmp.Canvas.Handle, 0, 0, SRCCOPY);
      end;
  end;
  FreeAndNil(TempBmp);
end;


procedure TsGauge.SkinPaintAsPie(aRect: TRect);
var
  W, H, MiddleX, MiddleY: Integer;
  Angle: Double;
begin
  W := WidthOf (aRect, True);
  H := HeightOf(aRect, True);
  with FCommonData.FCacheBmp.Canvas do begin
    Pen.Width := 1;
    Brush.Style := bsSolid;
    Pen.Style := psSolid;
    Pen.Color := ForeColor;
    Ellipse(aRect.Left, aRect.Top, W, H);
    Pen.Style := psSolid;
    Brush.Color := ForeColor;
    if PercentDone > 0 then begin
      MiddleX := W div 2;
      MiddleY := H div 2;
      Angle := Pi * (PercentDone / 50 + 0.5);
      Pie(aRect.Left, aRect.Top, W, H, Integer(Round(MiddleX * (1 - Cos(Angle)))),
                                       Integer(Round(MiddleY * (1 - Sin(Angle)))), MiddleX, 0);
    end;
  end;
end;


procedure TsGauge.SkinPaintAsNeedle(aRect: TRect);
var
  MiddleX, X, Y, W, H: Integer;
  Angle: Double;
begin
  X := aRect.Left;
  Y := aRect.Top;
  W := WidthOf(aRect, True);
  H := HeightOf(aRect, True);

  with FCommonData.FCacheBmp.Canvas do begin
    Brush.Style := bsClear;
    Pen.Width := 1;
    Pie(X, Y, W, H * 2 - 1, X + W, aRect.Bottom - 1, X, aRect.Bottom - 1);
    MoveTo(X, aRect.Bottom);
    LineTo(X + W, aRect.Bottom);
    Pen.Color := ForeColor;
    Pen.Style := psSolid;
    Pie(X, Y, W, H * 2 - 1, X + W, aRect.Bottom - 1, X, aRect.Bottom - 1);
    if PercentDone > 0 then begin
      MiddleX := Width div 2;
      MoveTo(MiddleX, aRect.Bottom - 1);
      Angle := (Pi * ((PercentDone / 100)));
      LineTo(Integer(Round(MiddleX * (1 - Cos(Angle)))), Integer(Round((aRect.Bottom - 1) * (1 - Sin(Angle)))));
    end;
  end;
end;


procedure TsGauge.SetGaugeKind(Value: TsGaugeKind);
begin
  if Value <> FKind then begin
    FKind := Value;
    Refresh;
  end;
end;


procedure TsGauge.SetShowText(Value: Boolean);
begin
  if Value <> FShowText then begin
    FShowText := Value;
    Refresh;
  end;
end;


procedure TsGauge.SetMinValue(Value: acInt64);
begin
  if Value <> FMinValue then begin
    if Value > FMaxValue then
      if not (csLoading in ComponentState) then
        raise EInvalidOperation.CreateFmt(SOutOfRange, [-MaxInt, FMaxValue - 1]);

    FMinValue := Value;
    if FCurValue < Value then
      FCurValue := Value;

    Refresh;
  end;
end;


procedure TsGauge.SetMaxValue(Value: acInt64);
begin
  if Value <> FMaxValue then begin
    if Value < FMinValue then 
      if not (csLoading in ComponentState) then
        raise EInvalidOperation.CreateFmt(SOutOfRange, [FMinValue + 1, MaxInt]);

    FMaxValue := Value;
    if FCurValue > Value then
      FCurValue := Value;

    Refresh;
  end;
end;


procedure TsGauge.SetProgress(Value: acInt64);
var
  TempPercent: acInt64;
begin
  TempPercent := GetPercentDone;
  Value := LimitIt(Value, FMinValue, FMaxValue);
  if FCurValue <> Value then begin
    FCurValue := Value;
    if TempPercent <> GetPercentDone then begin
      if not RestrictDrawing then
        FCommonData.BGChanged := True;

      Refresh;
    end;
    if Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;


procedure TsGauge.AddProgress(Value: acInt64);
begin
  Progress := FCurValue + Value;
  Refresh;
end;


destructor TsGauge.Destroy;
begin
  FreeAndNil(FCommonData);
  FreeAndNil(Timer);
  if LightingBmp <> nil then
    FreeAndNil(LightingBmp);

  if Light <> nil then
    FreeAndNil(Light);

  if FTmpProgressBmp <> nil then
    FreeAndNil(FTmpProgressBmp);

  inherited Destroy;
end;


procedure TsGauge.WndProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  if Message.Msg = SM_ALPHACMD then
    case Message.WParamHi of
      AC_CTRLHANDLED: begin
        Message.Result := 1;
        Exit;
      end;

      AC_CLEARCACHE:
        if FTmpProgressBmp <> nil then
          FreeAndNil(FTmpProgressBmp);

      AC_GETAPPLICATION: begin
        Message.Result := LRESULT(Application);
        Exit;
      end;

      AC_REMOVESKIN:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          if Animated and SkinData.SkinManager.Effects.AllowAnimation then
            Timer.Enabled := False;

          if FTmpProgressBmp <> nil then
            FreeAndNil(FTmpProgressBmp);

          CommonWndProc(Message, FCommonData);
          Repaint;
          Exit;
        end;

      AC_REFRESH:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          if FTmpProgressBmp <> nil then
            FreeAndNil(FTmpProgressBmp);

          CommonWndProc(Message, FCommonData);
          Repaint;
          if not (csDesigning in ComponentState) and Animated and SkinData.SkinManager.Effects.AllowAnimation then
            Timer.Enabled := True;

          Exit;
        end;

      AC_SETNEWSKIN:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          if FTmpProgressBmp <> nil then
            FreeAndNil(FTmpProgressBmp);

          CommonWndProc(Message, FCommonData);
          Exit;
        end;

      AC_ENDPARENTUPDATE:
        if FCommonData.Updating then begin
          FCommonData.Updating := False;
          Repaint;
          Exit;
        end;

      AC_GETDEFINDEX: begin
        if FCommonData.SkinManager <> nil then
          Message.Result := FCommonData.SkinManager.ConstData.Sections[ssGauge] + 1;

        Exit;
      end;
    end;

  if not ControlIsReady(Self) or not Assigned(FCommonData) or not FCommonData.Skinned then
    inherited
  else
    if not CommonWndProc(Message, FCommonData) then
      inherited;
end;


procedure TsGauge.SkinPaintBody(aRect: TRect);
begin
  if ShowText then
    SkinPaintAsText(aRect);

  case Kind of
    gkHorizontalBar, gkVerticalBar:
      SkinPaintAsBar(aRect);

    gkPie:
      SkinPaintAsPie(aRect);

    gkNeedle:
      SkinPaintAsNeedle(aRect);
  end;
end;


procedure TsGauge.TimerAction(Sender: TObject);
begin
  if SkinData.Skinned then begin
    if FLongTime > AnimLongDelay then begin
      FAnimPos := -AnimSize;
      FLongTime := 0;
    end;
    inc(FLongTime, acTimerInterval);//AnimShortDelay);
    if FAnimPos < iff(Kind = gkVerticalBar, Height, Width) then begin
      if Visible and (Progress > 0) and (Parent <> nil) and IsWindowVisible(Parent.Handle) then begin
        PrepareCache;
        UpdateCorners(FCommonData, 0);
        BitBlt(Canvas.Handle, 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
      end;
      inc(FAnimPos, AnimStep);
    end;
  end
  else
    Timer.Enabled := False;
end;


procedure TsGauge.UpdateLighting;
var
  dy: integer;
  rs: TResourceStream;
begin
  if LightingBmp = nil then begin
    LightingBmp := TPNGGraphic.Create;
    rs := TResourceStream.Create(hInstance, 'ACGL', RT_RCDATA);
    LightingBmp.LoadFromStream(rs);
    rs.Free;
  end;

  if Light = nil then
    Light := CreateBmp32(Animsize, iff(Kind = gkVerticalBar, Width, Height))
  else begin
    Light.Width := AnimSize;
    Light.Height := iff(Kind = gkVerticalBar, Width, Height);
  end;

  if Height < LightingBmp.Height then begin
    dy := (LightingBmp.Height - iff(Kind = gkVerticalBar, Width, Height)) div 2 + 1;
    if Light.Height - 2 * dy < 0 then
      dy := 0;
  end
  else
    dy := 0;

  StretchBlt(Light.Canvas.Handle, 0, 0, Light.Width, Light.Height, LightingBmp.Canvas.Handle, 0, dy, LightingBmp.Width, LightingBmp.Height - dy, SRCCOPY);
end;


procedure TsGauge.WMEraseBkGND(var Message: TWMPaint);
begin
  if not Skindata.Skinned then
    inherited;
end;


procedure TsGauge.SetSuffix(const Value: string);
begin
  if FSuffix <> Value then begin
    FSuffix := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsGauge.AfterConstruction;
begin
  inherited;
  FCommonData.Loaded;
end;


function TsGauge.AnimSize: integer;
begin
  Result := 300;
end;


function TsGauge.AnimStep: integer;
begin
  Result := max(Round(iff(Kind = gkVerticalBar, Height, Width) / (AnimLongDelay / (2 * acTimerInterval))), acTimerInterval);
end;


procedure TsGauge.Loaded;
begin
  inherited;
  FCommonData.Loaded;
  if not (csDesigning in ComponentState) and FAnimated and (SkinData.SkinManager <> nil) and SkinData.SkinManager.Effects.AllowAnimation and not Timer.Enabled then
    Timer.Enabled := True;
end;


procedure TsGauge.SetForeColor(const Value: TColor);
begin
  if FForeColor <> Value then begin
    FForeColor := Value;
    Repaint;
  end;
end;


procedure TsGauge.PaintBackground(AnImage: TBitmap);
var
  ARect: TRect;
begin
  with AnImage.Canvas do begin
    CopyMode := cmBlackness;
    ARect := MkRect(Self);
    CopyRect(ARect, Animage.Canvas, ARect);
    CopyMode := cmSrcCopy;
  end;
end;


procedure TsGauge.PrepareCache;
var
  CI: TCacheInfo;
begin
  InitCacheBmp(SkinData);
  CI := GetParentCache(FCommonData);
  if SkinData.SkinManager.gd[SkinData.SkinIndex].ReservedBoolean and (Kind in [gkHorizontalBar, gkVerticalBar]) then begin
    PaintItemBG(FCommonData, CI, 0, MkRect(Self), Point(Left, Top), FCommonData.FCacheBMP);
    SkinPaintBody(MkRect(Self));
    if SkinData.SkinManager.IsValidImgIndex(SkinData.SkinManager.gd[SkinData.SkinIndex].BorderIndex) then
      DrawSkinrect(FCommonData.FCacheBMP, MkRect(Self), CI,
                   SkinData.SkinManager.ma[SkinData.SkinManager.gd[SkinData.SkinIndex].BorderIndex], 0, False);
  end
  else begin
    PaintItem(FCommonData, GetParentCache(FCommonData), True, 0, MkRect(Self), Point(Left, Top), FCommonData.FCacheBMP, False);
    SkinPaintBody(MkRect(Self));
  end;
  FCommonData.BGChanged := False;
end;


procedure TsGauge.SetBorderStyle(const Value: TBorderStyle);
begin
  if Value <> FBorderStyle then begin
    FBorderStyle := Value;
    Refresh;
  end;
end;


procedure TsGauge.SetCalcPercents(const Value: boolean);
begin
  if FCalcPercents <> Value then begin
    FCalcPercents := Value;
    FCommonData.Invalidate
  end;
end;


procedure TsGauge.PaintAsBar(AnImage: TBitmap; PaintRect: TRect);
var
  FillSize: acInt64;
  W, H: Integer;
begin
  W := PaintRect.Right - PaintRect.Left + 1;
  H := PaintRect.Bottom - PaintRect.Top + 1;
  with AnImage.Canvas do begin
    Brush.Color := BackColor;
    FillRect(PaintRect);
    Pen.Color := ForeColor;
    Pen.Width := 1;
    Brush.Color := ForeColor;
    case FKind of
      gkHorizontalBar: begin
        FillSize := SolveForX(PercentDone, W);
        if FillSize > W then
          FillSize := W;

        if FillSize > 0 then
          FillRect(Rect(PaintRect.Left, PaintRect.Top, integer(FillSize), H));
      end;

      gkVerticalBar: begin
        FillSize := SolveForX(PercentDone, H);
        if FillSize >= H then
          FillSize := H - 1;

        FillRect(Rect(PaintRect.Left, H - integer(FillSize), W, H));
      end;
    end;
  end;
end;


procedure TsGauge.PaintAsNeedle(AnImage: TBitmap; PaintRect: TRect);
var
  MiddleX: Integer;
  Angle: Double;
  X, Y, W, H: Integer;
begin
  with PaintRect do begin
    X := Left;
    Y := Top;
    W := Right - Left;
    H := Bottom - Top;
    if FBorderStyle = bsSingle then begin
      Inc(W);
      Inc(H);
    end;
  end;
  with AnImage.Canvas do begin
    Brush.Color := Color;
    FillRect(PaintRect);
    Brush.Color := BackColor;
    Pen.Color := ForeColor;
    Pen.Width := 1;
    Pie(X, Y, W, H * 2 - 1, X + W, PaintRect.Bottom - 1, X, PaintRect.Bottom - 1);
    MoveTo(X, PaintRect.Bottom);
    LineTo(X + W, PaintRect.Bottom);
    if PercentDone > 0 then begin
      Pen.Color := ForeColor;
      MiddleX := Width div 2;
      MoveTo(MiddleX, PaintRect.Bottom - 1);
      Angle := (Pi * PercentDone / 100);
      LineTo(Integer(Round(MiddleX * (1 - Cos(Angle)))), Integer(Round((PaintRect.Bottom - 1) * (1 - Sin(Angle)))));
    end;
  end;
end;


procedure TsGauge.PaintAsNothing(AnImage: TBitmap; PaintRect: TRect);
begin
  with AnImage do begin
    Canvas.Brush.Color := BackColor;
    Canvas.FillRect(PaintRect);
  end;
end;


procedure TsGauge.PaintAsPie(AnImage: TBitmap; PaintRect: TRect);
var
  MiddleX, MiddleY: Integer;
  Angle: Double;
  W, H: Integer;
begin
  W := PaintRect.Right - PaintRect.Left;
  H := PaintRect.Bottom - PaintRect.Top;
  if FBorderStyle = bsSingle then begin
    Inc(W);
    Inc(H);
  end;
  with AnImage.Canvas do begin
    Brush.Color := Color;
    FillRect(PaintRect);
    Brush.Color := BackColor;
    Pen.Color := ForeColor;
    Pen.Width := 1;
    Ellipse(PaintRect.Left, PaintRect.Top, W, H);
    if PercentDone > 0 then begin
      Brush.Color := ForeColor;
      MiddleX := W div 2;
      MiddleY := H div 2;
      Angle := (Pi * (PercentDone / 50 + 0.5));
      Pie(PaintRect.Left, PaintRect.Top, W, H, Integer(Round(MiddleX * (1 - Cos(Angle)))), Integer(Round(MiddleY * (1 - Sin(Angle)))), MiddleX, 0);
    end;
  end;
end;


procedure TsGauge.PaintAsText(AnImage: TBitmap; PaintRect: TRect);
var
  S: string;
  X, Y: Integer;
  OverRect: TBitmap;
begin
  OverRect := CreateBmpLike(AnImage);
  OverRect.Canvas.Brush.Color := clWindowFrame;
  OverRect.Canvas.Brush.Style := bsSolid;
  OverRect.Canvas.FillRect(MkRect(Self));
  try
    PaintBackground(OverRect);
    S := Format('%d%', [iff(FCalcPercents, PercentDone, FCurValue)]) + FSuffix;
    if Assigned(FOnPaintText) then
      FOnPaintText(Self, S);

    with OverRect.Canvas do begin
      Brush.Style := bsClear;
      Font := Self.Font;
      Font.Color := clWhite;
      with PaintRect do begin
        X := (Right - Left + 1 - TextWidth(S)) div 2;
        Y := (Bottom - Top + 1 - TextHeight(S)) div 2;
      end;
      TextRect(PaintRect, X, Y, S);
    end;
    AnImage.Canvas.CopyMode := cmSrcInvert;
    AnImage.Canvas.Draw(0, 0, OverRect);
  finally
    OverRect.Free;
  end;
end;


procedure TsGauge.SetAnimated(const Value: boolean);
begin
  if FAnimated <> Value then begin
    FAnimated := Value;
    if not (csDesigning in ComponentState) then begin
      if FTmpProgressBmp <> nil then
        FreeAndNil(FTmpProgressBmp);

      Timer.Enabled := Value and SkinData.SkinManager.Effects.AllowAnimation;
      if not Timer.Enabled then
        SkinData.Invalidate;
    end;
  end;
end;


procedure TsGauge.SetBackColor(const Value: TColor);
begin
  if Value <> FBackColor then begin
    FBackColor := Value;
    Refresh;
  end;
end;


procedure TsGauge.SetProgressSkin(const Value: TsSkinSection);
begin
  if FProgressSkin <> Value then begin
    FProgressSkin := Value;
    if FTmpProgressBmp <> nil then
      FreeAndNil(FTmpProgressBmp);

    FCommonData.BGChanged := True;
    Repaint;
  end;
end;

end.
