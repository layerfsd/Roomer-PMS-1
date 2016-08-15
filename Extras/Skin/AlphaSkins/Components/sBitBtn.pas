unit sBitBtn;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Imglist, StdCtrls, Buttons,
  {$IFDEF LOGGED}     sDebugMsgs, {$ENDIF}
  {$IFNDEF DELPHI5}   Types,      {$ENDIF}
  {$IFDEF TNTUNICODE} TntButtons, {$ENDIF}
  {$IFDEF FPC}        LMessages,  {$ENDIF}
  sCommonData, sConst, sDefaults, sFade;


type
{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
{$IFDEF TNTUNICODE}
  TsBitBtn = class(TTntBitBtn)
  published
{$ELSE}
  TsBitBtn = class(TBitBtn)
{$ENDIF}
{$IFNDEF NOTFORHELP}
  private
    FDown,
    FGrayed,
    FShowFocus,
    FReflected,
    FShowCaption,
    RegionChanged,
    FMouseClicked,
    FAcceptsControls,
    FDrawOverBorder: boolean;

    FOnMouseEnter,
    FOnMouseLeave: TNotifyEvent;

    FBlend,
    FOffset,
    FOldSpacing,
    FImageIndex,
    FFocusMargin: integer;

    FAlignment,
    FTextAlignment: TAlignment;

    LastRect: TRect;
    FGlyphColorTone: TColor;
    FOnPaint: TBmpPaintEvent;
    FImages: TCustomImageList;
    FCommonData: TsCtrlSkinData;
    FImageChangeLink: TChangeLink;
    FDisabledKind: TsDisabledKind;
    FAnimatEvents: TacAnimatEvents;
    FDisabledGlyphKind: TsDisabledGlyphKind;
    FVerticalAlignment: TVerticalAlignment;
{$IFNDEF DELPHI7UP}
    FWordWrap: boolean;
    procedure SetWordWrap(const Value: boolean);
{$ENDIF}
    function GetGrayed: boolean;
    function GetDown: boolean;
    procedure ImageListChange(Sender: TObject);

    procedure SetDown             (const Value: boolean);
    procedure SetFocusMargin      (const Value: integer);
    procedure SetDisabledKind     (const Value: TsDisabledKind);
    procedure SetDisabledGlyphKind(const Value: TsDisabledGlyphKind);
    procedure SetBlend            (const Value: integer);
    procedure SetGrayed           (const Value: boolean);
    procedure SetOffset           (const Value: Integer);
    procedure SetImageIndex       (const Value: integer);
    procedure SetImages           (const Value: TCustomImageList);
    procedure SetShowCaption      (const Value: boolean);
    procedure SetShowFocus        (const Value: boolean);
    procedure SetAlignment        (const Value: TAlignment);
    procedure SetDrawOverBorder   (const Value: boolean);
    procedure SetReflected        (const Value: boolean);
    procedure SetTextAlignment    (const Value: TAlignment);
    procedure SetVerticalAlignment(const Value: TVerticalAlignment);
    procedure SetAcceptsControls  (const Value: boolean);

    procedure WMKeyUp    (var Message: TWMKey);      message WM_KEYUP;
    procedure CNDrawItem (var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure SetGlyphColorTone(const Value: TColor);
  protected
    IsFocused,
    ControlsShifted: boolean;

    FRegion: hrgn;
    GlyphPos: TPoint;
    CaptionRect: TRect;
    OldLayout: TButtonLayout;
    procedure StdDrawItem(const DrawItemStruct: TDrawItemStruct);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    procedure OurPaintHandler(aDC: hdc);
    procedure DoDrawText(var Rect: TRect; Flags: Cardinal);
    procedure DrawCaption(Canvas: TCanvas = nil);
    procedure ShiftControls(Offset: integer);
    function TextRectSize: TSize;
    function GlyphWidth: integer;
    function GlyphHeight: integer;

    function PrepareCache: boolean;
  public
    constructor Create(AOwner: TComponent); override;
    function CurrentState: integer;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure Loaded; override;
    function ImgRect: TRect;
    procedure Invalidate; override;
    procedure WndProc(var Message: TMessage); override;
    procedure SetButtonStyle(ADefault: Boolean); {$IFNDEF FPC} override; {$ENDIF}
  published
    property OnPaint: TBmpPaintEvent read FOnPaint write FOnPaint;
{$ENDIF} // NOTFORHELP
    property AcceptsControls: boolean read FAcceptsControls write SetAcceptsControls default False;
    property Alignment: TAlignment read FAlignment write SetAlignment default taCenter;
    property AnimatEvents: TacAnimatEvents read FAnimatEvents write FAnimatEvents default [aeGlobalDef];
    property Blend: integer read FBlend write SetBlend default 0;
    property DisabledGlyphKind: TsDisabledGlyphKind read FDisabledGlyphKind write SetDisabledGlyphKind default DefDisabledGlyphKind;
    property DisabledKind: TsDisabledKind read FDisabledKind write SetDisabledKind default DefDisabledKind;
    property Down: boolean read GetDown write SetDown default False;
    property DrawOverBorder: boolean read FDrawOverBorder write SetDrawOverBorder default True;
    property FocusMargin: integer read FFocusMargin write SetFocusMargin default 1;
    property Grayed: boolean read GetGrayed write SetGrayed default False;
    property GlyphColorTone: TColor read FGlyphColorTone write SetGlyphColorTone default clNone;
    property ImageIndex: integer read FImageIndex write SetImageIndex default -1;
    property Images: TCustomImageList read FImages write SetImages;
    property VerticalAlignment: TVerticalAlignment read FVerticalAlignment write SetVerticalAlignment default taVerticalCenter;
    property Reflected: boolean read FReflected write SetReflected default False;
    property ShowCaption: boolean read FShowCaption write SetShowCaption default True;
    property ShowFocus: boolean read FShowFocus write SetShowFocus default True;
    property SkinData: TsCtrlSkinData read FCommonData write FCommonData;
    property TextOffset: Integer read FOffset write SetOffset default 0;
    property TextAlignment: TAlignment read FTextAlignment write SetTextAlignment default taCenter;
{$IFNDEF DELPHI7UP}
    property WordWrap: boolean read FWordWrap write SetWordWrap default True;
{$ELSE}
    property WordWrap default True;
{$ENDIF}
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  end;


implementation

uses
  math, ActnList,
  {$IFDEF DELPHI7UP} Themes, {$ENDIF}
  sVCLUtils, sMessages, acntUtils, sGraphUtils, sAlphaGraph, acGlow, sBorders, sThirdParty, sSkinManager, sStyleSimply, acntTypes;


var
  bFocusChanging: boolean = False;


function IsImgListDefined(Btn: TsBitBtn): boolean;
begin
  with Btn do
    Result := Assigned(Images) and (ImageIndex >= 0) and (ImageIndex < GetImageCount(Btn.Images))
end;


function MaxCaptionWidth(Button: TsBitBtn): integer;
begin
  with Button do
    if ShowCaption and (Caption <> '') then begin
      Result := Width - 2 * Margin;
      case Layout of
        blGlyphLeft, blGlyphRight:
          Result := Result - (Spacing + GlyphWidth) * integer(GlyphWidth <> 0);
      end;
    end
    else
      Result := 0
end;


procedure TsBitBtn.SetButtonStyle(ADefault: Boolean);
begin
  inherited;
  if ADefault <> IsFocused then
    IsFocused := ADefault;

  SkinData.Invalidate;
end;


procedure TsBitBtn.AfterConstruction;
begin
  inherited;
  FCommonData.FCacheBmp.Canvas.Font.Assign(Font);
  FCommonData.Loaded;
end;


constructor TsBitBtn.Create(AOwner: TComponent);
begin
  FCommonData := TsCtrlSkinData.Create(Self, True);
  FCommonData.COC := COC_TsBitBtn;
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csOpaque];// + [csAcceptsControls];
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FFocusMargin := 1;
  FRegion := 1;
  FDown := False;

  FImageIndex := -1;
  AcceptsControls := False;
  FGrayed := False;
  ControlsShifted := False;
  FBlend := 0;
  FDisabledGlyphKind := DefDisabledGlyphKind;
  FDisabledKind := DefDisabledKind;
  FDrawOverBorder := True;
  FVerticalAlignment := taVerticalCenter;
  FOffset := 0;
  FAlignment := taCenter;
  FGlyphColorTone := clNone;
  FShowCaption := True;
  FTextAlignment := taCenter;
  FShowFocus := True;
  FAnimatEvents := [aeGlobalDef];
{$IFNDEF DELPHI7UP}
  FWordWrap := True;
{$ELSE}
  WordWrap := True;
{$ENDIF}
  RegionChanged := True;
end;


function TsBitBtn.CurrentState: integer;
var
  Wnd: THandle;
begin
  if ((SendMessage(Handle, BM_GETSTATE, 0, 0) and BST_PUSHED = BST_PUSHED) or fGlobalFlag) and
       (SkinData.FMouseAbove or
         not (csLButtonDown in ControlState) or
           ((SkinData.SkinManager <> nil) and SkinData.SkinManager.Options.NoMouseHover))
             or FDown then
    Result := 2
  else
    if not (csDesigning in ComponentState) and ControlIsActive(FCommonData) then
      Result := 1
    else
      if Default then begin
        Wnd := GetFocus;
        // Focused control is a button
        if Wnd <> 0 then
          Result := iff(GetWindowLong(Wnd, GWL_STYLE) and BS_USERBUTTON = BS_USERBUTTON, 0, 3)
        else
          Result := 3
      end
      else
        Result := 0
end;


destructor TsBitBtn.Destroy;
begin
  FreeAndNil(FImageChangeLink);
  FreeAndNil(FCommonData);
  inherited Destroy;
end;


procedure TsBitBtn.DoDrawText(var Rect: TRect; Flags: Cardinal);
begin
{$IFNDEF FPC}
  Flags := DrawTextBiDiModeFlags(Flags);
{$ENDIF}
  acWriteTextEx(FCommonData.FCacheBMP.Canvas, PacChar(Caption), True, Rect, Flags, FCommonData, boolean(CurrentState));
end;


procedure TsBitBtn.DrawCaption(Canvas: TCanvas = nil);
var
  DrawStyle: Cardinal;
  State: integer;
  R: TRect;
begin
  if Canvas = nil then
    Canvas := FCommonData.FCacheBmp.Canvas;
    
  Canvas.Font.Assign(Font);
  Canvas.Brush.Style := bsClear;
  R := CaptionRect;
  if CurrentState = 2 then
    if not SkinData.Skinned or (SkinData.SkinManager <> nil) and SkinData.SkinManager.ButtonsOptions.ShiftContentOnClick then
      OffsetRect(R, 1, 1);

  DrawStyle := DT_EXPANDTABS or GetStringFlags(Self, FTextAlignment) or DT_END_ELLIPSIS;
  if WordWrap then
    DrawStyle := DrawStyle or DT_WORDBREAK;

  if UseRightToLeftReading then
    DrawStyle := DrawStyle or DT_RTLREADING;

  if SkinData.Skinned then begin
    DoDrawText(R, DrawStyle);
    if Enabled and
         SkinData.SkinManager.ButtonsOptions.ShowFocusRect and
           Focused and
             (Caption <> '') and
               ShowFocus and
                 ShowCaption then begin
      InflateRect(R, FocusMargin + 1, FocusMargin);
      State := min(ac_MaxPropsIndex, FCommonData.SkinManager.gd[FCommonData.SkinIndex].States);
      FocusRect(Canvas, R, FCommonData.SkinManager.gd[FCommonData.SkinIndex].Props[State].FontColor.Color, clNone);
    end;
  end
  else begin
    Canvas.Brush.Style := bsClear;
    if not Enabled then begin
      OffsetRect(R, 1, 1);
      Canvas.Font.Color := clBtnHighlight;
      acDrawText(Canvas.Handle, PacChar(Caption), R, DrawStyle);
      OffsetRect(R, -1, -1);
      Canvas.Font.Color := clBtnShadow;
      acDrawText(Canvas.Handle, PacChar(Caption), R, DrawStyle);
    end
    else
      acDrawText(Canvas.Handle, PacChar(Caption), R, DrawStyle);
  end;
end;


function TsBitBtn.GetDown: boolean;
begin
  Result := FDown;
end;


function TsBitBtn.GlyphHeight: integer;
begin
  if IsImgListDefined(Self) then
    Result := GetImageHeight(Images)
  else
    if (Glyph <> nil) and (Glyph.Height > 0) then
      Result := Glyph.Height
    else
      Result := 0;
end;


function TsBitBtn.GlyphWidth: integer;
begin
  if IsImgListDefined(Self) then
    Result := GetImageWidth(Images) div NumGlyphs
  else
    if (Glyph <> nil) and (Glyph.Width > 0) then
      Result := Glyph.Width div NumGlyphs
    else
      Result := 0;
end;


function TsBitBtn.ImgRect: TRect;
begin
  Result.Left   := GlyphPos.x;
  Result.Top    := GlyphPos.y;
  Result.Right  := GlyphPos.x + GlyphWidth;
  Result.Bottom := GlyphPos.y + GlyphHeight;
  if CurrentState = 2 then
    if not SkinData.Skinned or (SkinData.SkinManager <> nil) and SkinData.SkinManager.ButtonsOptions.ShiftContentOnClick then
      OffsetRect(Result, 1, 1);

  if Reflected then
    OffsetRect(Result, 0, - WidthOf(Result) div 6);
end;


procedure TsBitBtn.Invalidate;
begin
  if OldLayout <> Layout then begin
    OldLayout := Layout;
    FCommonData.BGChanged := True;
  end;
  inherited;
end;


procedure TsBitBtn.Loaded;
begin
  inherited;
  FCommonData.FCacheBmp.Canvas.Font.Assign(Font);
  FCommonData.Loaded;
  if IsImgListDefined(Self) then
    Glyph.Assign(nil);
end;


procedure TsBitBtn.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FCommonData.Skinned and Enabled and not (csDesigning in ComponentState) then begin
    FCommonData.Updating := False;
    if (Button = mbLeft) and not ShowHintStored then begin
      AppShowHint := Application.ShowHint;
      Application.ShowHint := False;
      ShowHintStored := True;
    end;
    FMouseClicked := True;
    if Button = mbLeft then
      if not Down then begin
        RegionChanged := True;
        FCommonData.FUpdating := FCommonData.Updating;
        FCommonData.BGChanged := False;
        DoChangePaint(FCommonData, 2, UpdateWindow_CB, EventEnabled(aeMouseDown, FAnimatEvents), True, False);
      end;

    if ShowHintStored then begin;
      Application.ShowHint := AppShowHint;
      ShowHintStored := False
    end;
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;


procedure TsBitBtn.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not (csDestroying in ComponentState) then begin
    if (FCommonData <> nil) and FCommonData.Skinned and Enabled and not (csDesigning in ComponentState) then begin
      if Button = mbLeft then begin
        Application.ShowHint := AppShowHint;
        ShowHintStored := False;
      end;
      if FMouseClicked then begin
        FMouseClicked := False;
        if (Button = mbLeft) and Enabled then begin
          if (SkinData.AnimTimer <> nil) and SkinData.AnimTimer.Enabled then begin
            SkinData.AnimTimer.Enabled := False;
            FCommonData.BGChanged := True;
            fGlobalFlag := True;
            RedrawWindow(Handle, nil, 0, RDW_UPDATENOW or RDW_INVALIDATE);
            fGlobalFlag := False;
            Sleep(30);
          end;
          FCommonData.FUpdating := False;
          if (Self <> nil) and not (csDestroying in ComponentState) then begin
            RegionChanged := True;
            FCommonData.BGChanged := False;
  	        if Assigned(FCommonData) and FCommonData.FMouseAbove then
              DoChangePaint(FCommonData, 1, UpdateWindow_CB, EventEnabled(aeMouseUp, FAnimatEvents), True);
          end;
        end;
      end
      else
        if SkinData.AnimTimer <> nil then
          FreeAndNil(SkinData.AnimTimer);
    end;
    inherited MouseUp(Button, Shift, X, Y);
  end;
end;


procedure TsBitBtn.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = Images) then
    Images := nil;
end;


procedure TsBitBtn.OurPaintHandler;
var
  DC, SavedDC: hdc;
  PS: TPaintStruct;
  aRect: TRect;
  b: boolean;

  procedure ToFinish;
  begin
    if aDC <> DC then
      ReleaseDC(Handle, DC);

    if not InanimationProcess then
      EndPaint(Handle, {$IFDEF FPC}@{$ENDIF}PS);
  end;

begin
  if InAnimationProcess and ((aDC <> SkinData.PrintDC) or (aDC = 0)) then
    Exit;

  if aDC = 0 then
    DC := GetDC(Handle)
  else
    DC := aDC;

  if not InAnimationProcess then
    BeginPaint(Handle, PS);

  try
    if not InUpdating(FCommonData) and not (Assigned(SkinData.AnimTimer) and SkinData.AnimTimer.Enabled) then begin
      FCommonData.BGChanged := FCommonData.BGChanged or FCommonData.HalfVisible or GetBoolMsg(Parent, AC_GETHALFVISIBLE);
      FCommonData.HalfVisible := not RectInRect(Parent.ClientRect, BoundsRect);
      if not FCommonData.BGChanged then
        if FOldSpacing <> Spacing then begin
          FCommonData.BGChanged := True;
          FOldSpacing := Spacing;
        end;

      b := (FRegion = 1) or aSkinChanging;
      FRegion := 0;
      with FCommonData.SkinManager do
        if RegionChanged and IsValidImgIndex(FCommonData.BorderIndex) and (ma[SkinData.BorderIndex].CornerType = 2) and not (csDesigning in ComponentState) then begin
          if not PrepareCache then begin
            ToFinish;
            Exit;
          end;
          UpdateCorners(FCommonData, CurrentState);
          with FCommonData, SkinManager.ma[FCommonData.BorderIndex] do begin
            BitBlt(DC, 0, 0, WL, WT, FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
            BitBlt(DC, 0, Height - WB, Width, WB, FCacheBmp.Canvas.Handle, 0, Height - WB, SRCCOPY);
            BitBlt(DC, Width - WR, Height - WB, WR, WB, FCacheBmp.Canvas.Handle, Width - WR, Height - WB, SRCCOPY);
            BitBlt(DC, Width - WR, 0, WR, WT, FCacheBmp.Canvas.Handle, Width - WR, 0, SRCCOPY);
            if (DC <> SkinData.PrintDC) {$IFNDEF FPC}and not (csAlignmentNeeded in ControlState){$ENDIF} then // Set region
              if FRegion <> 0 then begin
                SetWindowRgn(Handle, FRegion, b); // Speed increased if repainting is disabled
                if (Width < WidthOf(LastRect)) or (Height < HeightOf(LastRect)) then
                  if not GetParentCache(SkinData).Ready then
                    with TSrcRect(LastRect) do begin
                      aRect := Rect(SRight - WR, STop, SRight, STop + WT);
                      InvalidateRect(Parent.Handle, @aRect, True); // Top-right
                      aRect := Rect(SRight - WR, SBottom - WB, SRight, SBottom);
                      InvalidateRect(Parent.Handle, @aRect, True); // Bottom-right
                      aRect := Rect(SLeft, SBottom - WB, SLeft + WL, SBottom);
                      InvalidateRect(Parent.Handle, @aRect, True); // Left-bottom
                    end;

                LastRect := BoundsRect;
                FRegion := 0;
              end;
          end;
        end
        else
          if (FCommonData.BGChanged or (csDesigning in ComponentState {for glyph changing})) then
            if not PrepareCache then begin
              ToFinish;
              Exit;
            end;

      SavedDC := SaveDC(DC);
      try
        BitBlt(DC, 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
        sVCLUtils.PaintControls(DC, Self, True, MkPoint);
      finally
        RestoreDC(DC, SavedDC);
      end;
    end;
  finally
    ToFinish;
  end;
end;


function TsBitBtn.PrepareCache: boolean;
var
  CI: TCacheInfo;
  State: integer;
  sm: TsSkinManager;
  BGInfo: TacBGInfo;
begin
  Result := True;
  GetBGInfo(@BGInfo, Parent);
  if BGInfo.BgType = btNotReady then begin
    FCommonData.FUpdating := True;
    Result := False;
  end
  else begin
    CI := BGInfoToCI(@BGInfo);
    InitCacheBmp(SkinData);
    sm := FCommonData.SkinManager;
    if (CurrentState = 3 {Def/Focused}) and (sm.gd[FCommonData.SkinIndex].States < 4) then
      State := 1
    else
      State := min(CurrentState, sm.gd[FCommonData.SkinIndex].States - 1);

    PaintItemBG(FCommonData, CI, State, MkRect(Self), Point(Left, Top), FCommonData.FCacheBMP, integer(State = 2), integer(State = 2));
    if sm.IsValidImgIndex(FCommonData.BorderIndex) then begin
      if RegionChanged and (sm.ma[FCommonData.BorderIndex].CornerType = 2) and not (csDesigning in ComponentState) and not InAnimationProcess and (SkinData.AnimTimer = nil) then begin
        if FRegion > 1 then
          DeleteObject(FRegion);

        FRegion := CreateRectRgn(0, 0, Width, Height);
        if FDrawOverBorder then
          if (State <> 0) or (sm.ma[FCommonData.BorderIndex].DrawMode and BDM_ACTIVEONLY = 0) then
            PaintRgnBorder(FCommonData.FCacheBmp, FRegion, True, sm.ma[FCommonData.BorderIndex], State);
      end
      else // Empty region
        if FDrawOverBorder then
          if (State <> 0) or (sm.ma[FCommonData.BorderIndex].DrawMode and BDM_ACTIVEONLY = 0) then begin
            inc(CI.X, Left);
            inc(CI.Y, Top);
            DrawSkinRect(FCommonData.FCacheBmp, MkRect(FCommonData.FCacheBmp), CI, sm.ma[FCommonData.BorderIndex], State, True);
            dec(CI.X, Left);
            dec(CI.Y, Top);
          end;
    end;
    UpdateBmpColors(FCommonData.FCacheBmp, SkinData, True, State);
    CalcButtonLayout(ClientRect, Point(GlyphWidth, GlyphHeight), TextRectSize, Layout, Alignment, Margin, Spacing, GlyphPos,
                     CaptionRect, {$IFDEF FPC}0{$ELSE}DrawTextBiDiModeFlags(0){$ENDIF}, VerticalAlignment);

    if FOffset <> 0 then
      case Layout of
        blGlyphLeft, blGlyphRight: OffsetRect(CaptionRect, FOffset, 0);
        blGlyphTop, blGlyphBottom: OffsetRect(CaptionRect, 0, FOffset);
      end;

    if ShowCaption then
      DrawCaption;

    DrawBtnGlyph(Self);
    if Assigned(FOnPaint) then
      FOnPaint(Self, FCommonData.FCacheBmp);

    if not FDrawOverBorder and sm.IsValidImgIndex(FCommonData.BorderIndex) then
      if (State <> 0) or (sm.ma[FCommonData.BorderIndex].DrawMode and BDM_ACTIVEONLY = 0) then
        if (sm.ma[FCommonData.BorderIndex].CornerType = 2) and not (csDesigning in ComponentState) then
          PaintRgnBorder(FCommonData.FCacheBmp, FRegion, True, sm.ma[FCommonData.BorderIndex], State)
        else
          DrawSkinRect(FCommonData.FCacheBmp, MkRect(FCommonData.FCacheBmp), CI, sm.ma[FCommonData.BorderIndex], State, True);

    if not Enabled or ((Action <> nil) and not Assigned(TAction(Action).OnExecute){ not TAction(Action).Enabled // Button not repainted immediately if Action.Enabled changed }) then
      BmpDisabledKind(FCommonData.FCacheBmp, FDisabledKind, Parent, CI, Point(Left, Top));

    FCommonData.BGChanged := False;
    if State = 2 then begin
      if not ControlsShifted then begin
        ControlsShifted := True;
        ShiftControls(1);
      end;
    end
    else
      if ControlsShifted then begin
        ShiftControls(-1);
        ControlsShifted := False;
      end;
  end;
end;


procedure TsBitBtn.SetAlignment(const Value: TAlignment);
begin
  if FAlignment <> Value then begin
    FAlignment := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsBitBtn.SetBlend(const Value: integer);
begin
  if FBlend <> Value then begin
    if Value < 0 then
      FBlend := 0
    else
      FBlend := iff(Value > 100, 100, Value);

    FCommonData.Invalidate;
  end;
end;


procedure TsBitBtn.SetDisabledGlyphKind(const Value: TsDisabledGlyphKind);
begin
  if FDisabledGlyphKind <> Value then begin
    FDisabledGlyphKind := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsBitBtn.SetDisabledKind(const Value: TsDisabledKind);
begin
  if FDisabledKind <> Value then begin
    FDisabledKind := Value;
    FCommonData.Invalidate;
  end;
end;


{$IFNDEF DELPHI7UP}
procedure TsBitBtn.SetWordWrap(const Value: boolean);
begin
  if FWordWrap <> Value then begin
    FWordWrap := Value;
    FCommonData.BGChanged := True;
    Repaint;
  end;
end;
{$ENDIF}


procedure TsBitBtn.SetDown(const Value: boolean);
begin
  if FDown <> Value then begin
    FDown := Value;
    RegionChanged := True;
    FCommonData.BGChanged := True;
    Repaint;
  end;
end;


procedure TsBitBtn.SetFocusMargin(const Value: integer);
begin
  if FFocusMargin <> Value then
    FFocusMargin := Value;
end;


procedure TsBitBtn.SetGlyphColorTone(const Value: TColor);
begin
  if FGlyphColorTone <> Value then begin
    FGlyphColorTone := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsBitBtn.SetGrayed(const Value: boolean);
begin
  if FGrayed <> Value then begin
    FGrayed := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsBitBtn.SetImageIndex(const Value: integer);
begin
  if FImageIndex <> Value then begin
    FImageIndex := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsBitBtn.SetImages(const Value: TCustomImageList);
begin
  if Images <> Value then begin
    if Images <> nil then
      Images.UnRegisterChanges(FImageChangeLink);

    FImages := Value;
    if Images <> nil then begin
      Images.RegisterChanges(FImageChangeLink);
      Images.FreeNotification(Self);
    end;
    FCommonData.Invalidate;
  end;
end;


procedure TsBitBtn.SetOffset(const Value: Integer);
begin
  if FOffset <> Value then begin
    FOffset := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsBitBtn.SetShowCaption(const Value: boolean);
begin
  if FShowCaption <> Value then begin
    FShowCaption := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsBitBtn.SetShowFocus(const Value: boolean);
begin
  if FShowFocus <> Value then begin
    FShowFocus := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsBitBtn.SetDrawOverBorder(const Value: boolean);
begin
  if FDrawOverBorder <> Value then begin
    FDrawOverBorder := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsBitBtn.SetReflected(const Value: boolean);
begin
  if FReflected <> Value then begin
    FReflected := Value;
    FCommonData.Invalidate;
  end;
end;


function TsBitBtn.TextRectSize: TSize;
var
  R: TRect;
  DrawStyle: Cardinal;
begin
  R := MkRect(MaxCaptionWidth(Self), 0);
  DrawStyle := DT_EXPANDTABS or GetStringFlags(Self, FTextAlignment) or DT_CALCRECT;
  if WordWrap then
    DrawStyle := DrawStyle or DT_WORDBREAK;

  FCommonData.FCacheBMP.Canvas.Font.Assign(Font);
  acDrawText(FCommonData.FCacheBMP.Canvas.Handle, Caption, R, DrawStyle);
  Result := MkSize(R);
end;


procedure TsBitBtn.WMKeyUp(var Message: TWMKey);
begin
  inherited;
  if Assigned(FCommonData) and FCommonData.Skinned and (Message.CharCode = 32) then begin
    RegionChanged := True;
    FCommonData.BGChanged := True;
    Repaint;
  end;
end;


procedure TsBitBtn.WndProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  if (Message.Msg = WM_KILLFOCUS) and (csDestroying in ComponentState) then
    Exit;

  if Message.Msg = SM_ALPHACMD then
    case Message.WParamHi of
      AC_CTRLHANDLED: begin
        Message.Result := 1;
        Exit;
      end; // AlphaSkins is supported

      AC_SETNEWSKIN:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          RegionChanged := True;
          AlphaBroadCast(Self, Message);
          CommonMessage(Message, FCommonData);
          Exit;
        end;

      AC_REMOVESKIN:
        if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) and not (csDestroying in ComponentState) then begin
          AlphaBroadCast(Self, Message);
          CommonMessage(Message, FCommonData);
          FRegion := 0;
          SetWindowRgn(Handle, 0, False);
          Repaint;
          Exit;
        end;

      AC_REFRESH:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          SetWindowRgn(Handle, 0, False);
          CommonMessage(Message, FCommonData);
          RegionChanged := True;
          if SkinData.PrintDC = 0 then
            Repaint;

          AlphaBroadCast(Self, Message);
          Exit;
        end;

      AC_PREPARECACHE: begin
        Message.Result := LRESULT(not PrepareCache);
        Exit;
      end;

      AC_DRAWANIMAGE:
        if FRegion > 1 then begin
          DeleteObject(FRegion);
          FRegion := 0;
        end;

      AC_GETDEFINDEX: begin
        if FCommonData.SkinManager <> nil then
          Message.Result := FCommonData.SkinManager.ConstData.Sections[ssButton] + 1;

        Exit;
      end{
      else
        if CommonMessage(Message, SkinData) then
          Exit};
    end;

  if not ControlIsReady(Self) or not FCommonData.Skinned(True) then begin
    case Message.Msg of
      CM_MOUSEENTER: begin
        SkinData.FMouseAbove := True;
        if Assigned(FOnMouseEnter) and Enabled and not (csDesigning in ComponentState) then
          FOnMouseEnter(Self);
      end;

      CM_MOUSELEAVE: begin
        SkinData.FMouseAbove := False;
        if Assigned(FOnMouseLeave) and Enabled and not (csDesigning in ComponentState) then
          FOnMouseLeave(Self);
      end;

      WM_PRINT: begin
        Perform(WM_PAINT, Message.WParam, Message.LParam);
        Exit;
      end;
    end;
    inherited
  end
  else begin
    case Message.Msg of
      SM_ALPHACMD:
        case Message.WParamHi of
          AC_ENDPARENTUPDATE:
            if FCommonData.FUpdating then begin
              if not InUpdating(FCommonData, True) then
                Repaint;

              Exit;
            end

          else
            if CommonMessage(Message, FCommonData) then
              Exit;
        end;

      WM_WINDOWPOSCHANGING:
        RegionChanged := True;

      WM_WINDOWPOSCHANGED: begin
        RegionChanged := True;
        SkinData.BGChanged := True;
      end;

      CM_UIACTIVATE:
        SkinData.Updating := False;

      CM_DIALOGCHAR:
        if Enabled and Focused and (TCMDialogChar(Message).CharCode = VK_SPACE) then begin
          StopTimer(SkinData);
          RegionChanged := True;
          FCommonData.BGChanged := True;
          HideGlow(SkinData.GlowID);
          Repaint;
        end;

      CM_MOUSEENTER:
        if Enabled and not (csDesigning in ComponentState) then
          if not FCommonData.FMouseAbove and not SkinData.SkinManager.Options.NoMouseHover then begin
            if Assigned(FOnMouseEnter) then
              FOnMouseEnter(Self);

            FCommonData.FMouseAbove := True;
            FCommonData.BGChanged := False;
            DoChangePaint(FCommonData, 1, UpdateWindow_CB, EventEnabled(aeMouseEnter, FAnimatEvents), False);
          end;

      CM_MOUSELEAVE:
        if Enabled and not (csDesigning in ComponentState) then begin
          if Assigned(FOnMouseLeave) then
            FOnMouseLeave(Self);

          FCommonData.FMouseAbove := False;
          FCommonData.BGChanged := False;
          DoChangePaint(FCommonData, 0, UpdateWindow_CB, EventEnabled(aeMouseLeave, FAnimatEvents), False, False);
        end;

      WM_SIZE:
        RegionChanged := True;

      WM_UPDATEUISTATE:
        if Visible or (csDesigning in ComponentState) then begin
          Message.Result := 0;
          Exit;
        end;

      WM_ERASEBKGND:
        if Visible or (csDesigning in ComponentState) then begin
          if not InUpdating(FCommonData) then begin
            if (TWMPaint(Message).DC <> 0) and (Skindata.FCacheBmp <> nil) and not FCommonData.BGChanged and ((SkinData.AnimTimer = nil) or not SkinData.AnimTimer.Enabled) then
              CopyWinControlCache(Self, FCommonData, MkRect, MkRect(Self), TWMPaint(Message).DC, False);

            Message.Result := 0;
          end;
          Exit;
        end;

      WM_SETTEXT:
        if Showing then begin
          StopTimer(SkinData);
          SetRedraw(Handle, 0);
          inherited;
          SetRedraw(Handle, 1);
          Exit;
        end;

      CM_TEXTCHANGED:
        if not (csDestroying in ComponentState) and (Visible or (csDesigning in ComponentState)) then begin
          StopTimer(SkinData);
          FCommonData.Invalidate;
          Exit;
        end;

      WM_PRINT: begin
        RegionChanged := True;
        FCommonData.FUpdating := False;
        OurPaintHandler(TWMPaint(Message).DC);
        Exit;
      end;

      WM_PAINT:
        if Visible or (csDesigning in ComponentState) then begin
          if Parent = nil then
            Exit;

          OurPaintHandler(TWMPaint(Message).DC);
          if not (csDesigning in ComponentState) then
            Exit;
        end;

      CN_DRAWITEM: begin
        Message.WParam := 0;
        Message.LParam := 0;
        Message.Result := 1;
        Exit;
      end;

      WM_MOVE:
        if (FCommonData.SkinManager.gd[FCommonData.SkinIndex].Props[0].Transparency > 0) or
             ((FCommonData.SkinManager.gd[FCommonData.SkinIndex].Props[1].Transparency > 0) and
               ControlIsActive(FCommonData)) then begin
          FCommonData.BGChanged := True;
          Repaint;
        end;

      WM_SETFOCUS, CM_ENTER:
        if not (csDesigning in ComponentState) and Visible then begin
          if Enabled and not (csDestroying in ComponentState) and not bFocusChanging then begin
            Perform(WM_SETREDRAW, 0, 0);
            bFocusChanging := True;
            inherited;
            Perform(WM_SETREDRAW, 1, 0);
            bFocusChanging := False;
            if (SkinData.AnimTimer <> nil) and SkinData.AnimTimer.Enabled then begin
              SkinData.BGChanged := True;
              SkinData.AnimTimer.TimeHandler {Fast repaint}
            end
            else
              FCommonData.Invalidate;
          end
          else
            inherited;

          Exit;
        end;

      WM_KILLFOCUS, CM_EXIT:
        if not (csDesigning in ComponentState) and Visible then begin
          if Enabled and not (csDestroying in ComponentState) then begin
            StopTimer(SkinData);
            Perform(WM_SETREDRAW, 0, 0);
            inherited;
            Perform(WM_SETREDRAW, 1, 0);
            if FCommonData.Skinned then begin
              FCommonData.FFocused := False;
              FCommonData.Invalidate;
              HideGlow(SkinData.GlowID);
            end;
          end
          else
            inherited;

          Exit
        end;

      CM_FOCUSCHANGED:
        if Visible then begin
          if not bFocusChanging then
            Perform(WM_SETREDRAW, 0, 0);

          inherited;
          if not bFocusChanging then
            Perform(WM_SETREDRAW, 1, 0);
        end; // Blinking removing

      WM_ENABLE:
        Exit; // Blinking removing
    end;

    if CommonWndProc(Message, FCommonData) then
      Exit;

    inherited;
    case Message.Msg of
      CM_ENABLEDCHANGED:
        if (Visible or (csDesigning in ComponentState)) and not (csDestroying in ComponentState) then begin
          FCommonData.FUpdating := False;
          StopTimer(SkinData);
          FCommonData.BGChanged := True;
          RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW);
        end;

      CM_VISIBLECHANGED:
        if not (csDestroying in ComponentState) and Visible then begin
          FCommonData.BGChanged := True;
          FCommonData.Updating := False;
          if Visible or (csDesigning in ComponentState) then
            Repaint;
        end;

      WM_SETFONT:
        if Visible or (csDesigning in ComponentState) then begin
          FCommonData.FUpdating := False;
          StopTimer(SkinData);
          FCommonData.Invalidate;
        end;

      CM_ACTIONUPDATE:
        if Action <> nil then
          Enabled := TCustomAction(Action).Enabled;
    end;
  end;
end;


procedure TsBitBtn.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  inherited ActionChange(Sender, CheckDefaults);
  if not (csLoading in ComponentState) then begin
    if (TCustomAction(Sender).ActionList <> nil) and (Images = nil) then
      Images := TCustomAction(Sender).ActionList.Images;

    if ImageIndex < 0 then
      ImageIndex := TCustomAction(Sender).ImageIndex;

    if not (csDestroying in ComponentState) then
      FCommonData.Invalidate;
  end;
end;


procedure TsBitBtn.SetTextAlignment(const Value: TAlignment);
begin
  if FTextAlignment <> Value then begin
    FTextAlignment := Value;
    FCommonData.Invalidate
  end;
end;


procedure TsBitBtn.CNDrawItem(var Message: TWMDrawItem);
begin
  if SkinData <> nil then
    if not SkinData.Skinned then
      StdDrawItem(Message.DrawItemStruct^)
    else
      inherited;
end;


procedure TsBitBtn.StdDrawItem(const DrawItemStruct: TDrawItemStruct);
var
  IsDown, IsDefault: Boolean;
  R: TRect;
  Flags: Cardinal;
{$IFDEF DELPHI7UP}
  Details: TThemedElementDetails;
  Button: TThemedButton;
{$ENDIF}
  Canvas: TCanvas;
begin
  if not (csDestroying in ComponentState) then begin
    Canvas := TCanvas.Create;
    Canvas.Handle := DrawItemStruct.hDC;
    CalcButtonLayout(ClientRect, Point(GlyphWidth, GlyphHeight), TextRectSize, Layout, Alignment, Margin, Spacing,
                     GlyphPos, CaptionRect, {$IFDEF FPC}0{$ELSE}DrawTextBiDiModeFlags(0){$ENDIF}, VerticalAlignment);

    if FOffset <> 0 then
      case Layout of
        blGlyphLeft, blGlyphRight: OffsetRect(CaptionRect, FOffset, 0);
        blGlyphTop, blGlyphBottom: OffsetRect(CaptionRect, 0, FOffset);
      end;

    R := ClientRect;
    with DrawItemStruct do begin
      Canvas.Handle := hDC;
      Canvas.Font := Self.Font;
      IsDown := itemState and ODS_SELECTED <> 0;
      IsDefault := itemState and ODS_FOCUS <> 0;
    end;
  {$IFDEF DELPHI7UP}
    if acThemesEnabled then begin
      if not Enabled then
        Button := tbPushButtonDisabled
      else
        if IsDown then
          Button := tbPushButtonPressed
        else
          if SkinData.FMouseAbove{ MouseInControl } then
            Button := tbPushButtonHot
          else
            if IsFocused or IsDefault then
              Button := tbPushButtonDefaulted
            else
              Button := tbPushButtonNormal;

      Details := acThemeServices.GetElementDetails(Button);
      // Parent background
      acThemeServices.DrawParentBackground(Handle, DrawItemStruct.hDC, @Details, True);
      // Button shape
      acThemeServices.DrawElement(DrawItemStruct.hDC, Details, DrawItemStruct.rcItem);
  {$IFDEF DELPHI_XE2}
      acThemeServices.GetElementContentRect(Canvas.Handle, Details, DrawItemStruct.rcItem, R);
  {$ELSE}
      R := acThemeServices.ContentRect(Canvas.Handle, Details, DrawItemStruct.rcItem);
  {$ENDIF}
      if IsFocused and IsDefault and ((SkinData.SkinManager = nil) or SkinData.SkinManager.ButtonsOptions.ShowFocusRect) then begin
        Canvas.Pen.Color := clWindowFrame;
        Canvas.Brush.Color := clBtnFace;
        DrawFocusRect(Canvas.Handle, R);
      end;
    end
    else
  {$ENDIF}
    begin
      Flags := DFCS_BUTTONPUSH or DFCS_ADJUSTRECT;
      if IsDown then
        Flags := Flags or DFCS_PUSHED;

      if DrawItemStruct.itemState and ODS_DISABLED <> 0 then
        Flags := Flags or DFCS_INACTIVE;
      // DrawFrameControl doesn't allow for drawing a button as the default button, so it must be done here
      if IsFocused or IsDefault then begin
        Canvas.Pen.Color := clWindowFrame;
        Canvas.Pen.Width := 1;
        Canvas.Brush.Style := bsClear;
        Canvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
        // DrawFrameControl must draw within this border
        InflateRect(R, -1, -1);
      end;
      // DrawFrameControl does not draw a pressed button correctly
      if IsDown then begin
        Canvas.Pen.Color := clBtnShadow;
        Canvas.Pen.Width := 1;
        Canvas.Brush.Color := clBtnFace;
        Canvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
        InflateRect(R, -1, -1);
      end
      else
        DrawFrameControl(DrawItemStruct.hDC, R, DFC_BUTTON, Flags);

      if IsFocused then begin
        R := ClientRect;
        InflateRect(R, -1, -1);
      end;
      Canvas.Font := Self.Font;
      if IsDown then
        OffsetRect(R, 1, 1);

      if IsFocused and IsDefault and ((SkinData.SkinManager = nil) or SkinData.SkinManager.ButtonsOptions.ShowFocusRect) then begin
        R := ClientRect;
        InflateRect(R, -4, -4);
        Canvas.Pen.Color := clWindowFrame;
        Canvas.Brush.Color := clBtnFace;
        DrawFocusRect(Canvas.Handle, R);
      end;
    end;
    DrawCaption(Canvas);
    DrawBtnGlyph(Self, Canvas);

    Canvas.Handle := 0;
    Canvas.Free;
  end;
end;


procedure TsBitBtn.ImageListChange(Sender: TObject);
begin
  if Images <> nil then
    FCommonData.Invalidate;
end;


function TsBitBtn.GetGrayed: boolean;
begin
  Result := FGrayed or SkinData.Skinned and (SkinData.SkinManager <> nil) and SkinData.SkinManager.Effects.DiscoloredGlyphs;
end;


procedure TsBitBtn.SetVerticalAlignment(const Value: TVerticalAlignment);
begin
  if FVerticalAlignment <> Value then begin
    FVerticalAlignment := Value;
    SkinData.Invalidate;
  end;
end;


procedure TsBitBtn.ShiftControls(Offset: integer);
var
  i: integer;
begin
  if (SkinData.SkinManager = nil) or SkinData.SkinManager.ButtonsOptions.ShiftContentOnClick then
    for i := 0 to ControlCount - 1 do
      Controls[i].SetBounds(Controls[i].Left + Offset, Controls[i].Top + Offset, Controls[i].Width, Controls[i].Height);
end;


procedure TsBitBtn.SetAcceptsControls(const Value: boolean);
begin
  if FAcceptsControls <> Value then begin
    FAcceptsControls := Value;
    if Value then
      ControlStyle := ControlStyle + [csAcceptsControls]
    else
      ControlStyle := ControlStyle - [csAcceptsControls]
  end;
end;

end.
