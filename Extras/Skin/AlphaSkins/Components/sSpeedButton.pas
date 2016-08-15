unit sSpeedButton;
{$I sDefs.inc}
//{$DEFINE LOGGED}
//+
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Imglist, Buttons, comctrls, menus,
  {$IFNDEF DELPHI5}   Types,      {$ENDIF}
  {$IFDEF TNTUNICODE} TntButtons, {$ENDIF}
  {$IFDEF FPC}        LMessages,  {$ENDIF}
  sCommonData, sConst, sDefaults, sFade;


type     
{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
{$IFDEF TNTUNICODE}
  TsSpeedButton = class(TTntSpeedButton)
{$ELSE}
  TsSpeedButton = class(TSpeedButton)
{$ENDIF}
  private
{$IFNDEF NOTFORHELP}
    FBlend,
    FOffset,
    FOldSpacing,
    FImageIndex,
    FOldNumGlyphs,
    FImageIndexHot,
    FImageIndexPressed,
    FImageIndexDisabled,
    FImageIndexSelected: integer;

    OldFlat,
    FWordWrap,
    FReflected,
    FStdParent,
    FBGCopying,
    FStoredDown,
    FUseEllipsis,
    FShowCaption,
    FDrawOverBorder: boolean;

    FOnMouseEnter,
    FOnMouseLeave: TNotifyEvent;

    FAlignment,
    FTextAlignment:     TAlignment;

    FGlyphColorTone:    TColor;
    FStdBG:             TBitmap;
    FDropdownMenu:      TPopupMenu;
    FImageChangeLink:   TChangeLink;
    FGrayedMode:        TacGrayedMode;
    FCommonData:        TsCtrlSkinData;
    FDisabledKind:      TsDisabledKind;
    FDisabledGlyphKind: TsDisabledGlyphKind;
    FImages:            TCustomImageList;
    FButtonStyle:       TToolButtonStyle;
    FOnPaint:           TBmpPaintEvent;
    FAnimatEvents:      TacAnimatEvents;

    procedure SetAlignment        (const Value: TAlignment);
    procedure SetTextAlignment    (const Value: TAlignment);
    procedure SetDropdownMenu     (const Value: TPopupMenu);
    procedure SetDisabledKind     (const Value: TsDisabledKind);
    procedure SetImages           (const Value: TCustomImageList);
    procedure SetButtonStyle      (const Value: TToolButtonStyle);
    procedure SetDisabledGlyphKind(const Value: TsDisabledGlyphKind);
    procedure SetInteger          (const Index: Integer; const Value: integer);
    procedure SetBoolean          (const Index: Integer; const Value: boolean);
    procedure SetGlyphColorTone   (const Value: TColor);
    procedure ImageListChange(Sender: TObject);
  protected
    FGrayed,
    FHotState,
    DroppedDown,
    MenuVisible,
    FMenuOwnerMode: boolean;

    OldMargin: integer;
    OldCaption: acString;
    OldLayout: TButtonLayout;
    OldOnChange: TNotifyEvent;
    procedure DrawCaption;
    function ArrowWidth: integer;
    function GenMargin: integer;
    procedure DoDrawText(var R: TRect; Flags: Cardinal);
    procedure DrawGlyph; {$IFNDEF FPC}virtual;{$ENDIF}
    function GlyphWidth:  integer; virtual;
    function GlyphHeight: integer; virtual;
    procedure CopyFromCache(aDC: hdc); virtual;

    function PrepareCache: boolean; virtual;

    procedure PaintArrow(const pR: PRect; Mode: integer);
    procedure ActionChanged(Sender: TObject);
    procedure ActionChange (Sender: TObject; CheckDefaults: Boolean); override;
    procedure GlyphChanged (Sender: TObject);
    procedure Ac_CMMouseEnter; virtual;
    procedure Ac_CMMouseLeave; virtual;
    procedure StdPaint(PaintButton: boolean = True); virtual;
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
{$IFDEF DELPHI7UP}
    function GetActionLinkClass: TControlActionLinkClass; override;
{$ENDIF}
  public
    function CurrentState: integer; virtual;
    function CurrentImageIndex: integer;

    function CaptionRect(ShiftClicked: boolean = True): TRect;
    function ImgRect    (ShiftClicked: boolean = True): TRect;
    function ArrowRect: TRect;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GraphRepaint;
    procedure UpdateControl;
    procedure AfterConstruction; override;
    procedure Invalidate; override;
    procedure Loaded; override;
    procedure WndProc(var Message: TMessage); override;
    function TextRectSize: TSize;
    property Canvas;
{$ENDIF} // NOTFORHELP
  published
{$IFNDEF NOTFORHELP}
    property Align;
    property OnDragDrop;
    property OnDragOver;
    property DragKind;
    property DragCursor;
    property DragMode;
{$ENDIF} // NOTFORHELP
    property OnPaint: TBmpPaintEvent read FOnPaint write FOnPaint;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;

    property AnimatEvents: TacAnimatEvents read FAnimatEvents write FAnimatEvents default [aeGlobalDef];
    property Alignment: TAlignment read FAlignment write SetAlignment default taCenter;
    property ButtonStyle: TToolButtonStyle read FButtonStyle write SetButtonStyle default tbsButton;
    property SkinData: TsCtrlSkinData read FCommonData write FCommonData;
    property DisabledGlyphKind: TsDisabledGlyphKind read FDisabledGlyphKind write SetDisabledGlyphKind default DefDisabledGlyphKind;
    property DisabledKind: TsDisabledKind read FDisabledKind write SetDisabledKind default DefDisabledKind;
    property DropdownMenu: TPopupMenu read FDropdownMenu write SetDropdownMenu;
    property Images: TCustomImageList read FImages write SetImages;
    property TextAlignment: TAlignment read FTextAlignment write SetTextAlignment default taCenter;
    property GrayedMode: TacGrayedMode read FGrayedMode write FGrayedMode default gmInactive;
    property GlyphColorTone: TColor read FGlyphColorTone write SetGlyphColorTone default clNone;

    property Blend:              integer index 0 read FBlend      write SetInteger default 0;
    property ImageIndex:         integer index 1 read FImageIndex write SetInteger default -1;
    property TextOffset:         integer index 2 read FOffset     write SetInteger default 0;

    property ImageIndexHot:      integer index 3 read FImageIndexHot      write SetInteger default -1;
    property ImageIndexPressed:  integer index 4 read FImageIndexPressed  write SetInteger default -1;
    property ImageIndexDisabled: integer index 5 read FImageIndexDisabled write SetInteger default -1;
    property ImageIndexSelected: integer index 6 read FImageIndexSelected write SetInteger default -1;

    property DrawOverBorder: boolean index 0 read FDrawOverBorder write SetBoolean default True;
    property Grayed:         boolean index 1 read FGrayed         write SetBoolean default False;
    property Reflected:      boolean index 2 read FReflected      write SetBoolean default False;
    property ShowCaption:    boolean index 3 read FShowCaption    write SetBoolean default True;
    property WordWrap:       boolean index 4 read FWordWrap       write SetBoolean default True;
    property UseEllipsis:    boolean index 5 read FUseEllipsis    write SetBoolean default True;
  end;


{$IFDEF DELPHI7UP}
  TacSpeedButtonActionLink = class(TSpeedButtonActionLink)
  protected
    procedure SetImageIndex(Value: Integer); override;
  public
  end;
{$ENDIF}


{$IFNDEF NOTFORHELP}
  TsTimerSpeedButton = class(TsSpeedButton)
  private
    FAllowTimer: boolean;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property AllowTimer: boolean read FAllowTimer write FAllowTimer default True;
  end;
{$ENDIF} // NOTFORHELP


implementation

uses
  math, ActnList,
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  {$IFDEF DELPHI7UP} Themes, {$ENDIF}
  sGraphUtils, sVCLUtils, sMessages, acntUtils, sAlphaGraph, sStyleSimply, sSkinProps,
  sThirdParty, sSkinManager, acGlow;


const
  AddedWidth = 16;


type
  TPopupActionBar_ = class(TPopupMenu)
{$IFDEF D2009}
    FActionManager: TObject;
{$ENDIF}
    FPopupMenu: TObject;
  end;


function GlowingAllowed(Btn: TsSpeedButton): boolean;
begin
  if Btn.DropDownMenu = nil then
    Result := True
  else
    if Btn.DropDownMenu.ClassName = 'TPopupActionBar' then
      Result := TPopupActionBar_(Btn.DropDownMenu).FPopupMenu = nil
    else
      Result := True
end;


function IsImgListDefined(Btn: TsSpeedButton): boolean;
begin
  with Btn do
    Result := Assigned(Images) and IsValidIndex(ImageIndex, GetImageCount(Images));
end;


procedure PaintParentControls(Button: TsSpeedButton; aCanvas: TCanvas);
var
  i: integer;
  R, cR: TRect;
  SavedDC: hdc;
begin
  with Button do begin
    R := BoundsRect;
    for i := 0 to Parent.ControlCount - 1 do
      if Parent.Controls[i] <> Button then
        with Parent.Controls[i] do
          if (Visible or (csDesigning in ComponentState)) and (csOpaque in ControlStyle) then begin
            cR := BoundsRect;
            if PtInRect(R, cR.TopLeft) or PtInRect(R, cR.BottomRight) then begin
              SavedDC := SaveDC(aCanvas.Handle);
              try
                aCanvas.Lock;
                ControlState := ControlState + [csPaintCopy];
                MoveWindowOrg(aCanvas.Handle, cR.Left - R.Left, cr.Top - R.Top);
                IntersectClipRect(aCanvas.Handle, 0, 0, Width, Height);
                Perform(WM_PAINT, WPARAM(aCanvas.Handle), 0);
                ControlState := ControlState - [csPaintCopy];
                aCanvas.UnLock;
              finally
                RestoreDC(aCanvas.Handle, SavedDC);
              end;
            end;
          end;
  end;
end;


function MaxCaptionWidth(Button: TsSpeedButton): integer;
begin
  with Button do
    if ShowCaption and (Caption <> '') then begin
      Result := Width - 2 * max(0, Margin) - ArrowWidth;
      if Layout in [blGlyphLeft, blGlyphRight] then
        Result := Result - (Spacing + GlyphWidth) * integer(GlyphWidth <> 0)
    end
    else
      Result := 0
end;


function TsSpeedButton.ArrowRect: TRect;
var
  w, m: integer;
  cr, ir: TRect;
begin
  if ButtonStyle = tbsDropDown then begin
    w := AddedWidth;
    if not Assigned(OnCLick) then begin
      ir := ImgRect(False);
      if ShowCaption then
        cr := CaptionRect(False)
      else
        if ir.Left <> ir.Right then begin
          cr.Left := ir.Right;
          cr.Right := cr.Left;
        end
        else begin
          cr.Left := (Width - w) div 2 + GlyphWidth;
          cr.Right := cr.Left;
        end;

      m := integer(WidthOf(cr) + WidthOf(ir) > 0) * 2;
      case Layout of
        blGlyphLeft:
          Result.Left := cr.Right + m;

        blGlyphRight:
          Result.Left := ir.Right + m

        else
          Result.Left := max(ir.Right, cr.Right) + m
      end
    end
    else
      Result.Left := Width - w;

    Result.Right := Result.Left + w;
    Result.Top := 1;
    Result.Bottom := Height - 1;
  end
  else
    Result := MkRect;

  if CurrentState = 2 then
    if not SkinData.Skinned or (SkinData.SkinManager <> nil) and SkinData.SkinManager.ButtonsOptions.ShiftContentOnClick then
      OffsetRect(Result, 1, 1);
end;


function TsSpeedButton.ArrowWidth: integer;
begin
  Result := integer(ButtonStyle = tbsDropDown) * AddedWidth;
end;


procedure TsSpeedButton.AfterConstruction;
begin
  inherited;
  FCommonData.Loaded;
  if FCommonData.Skinned then
    ControlStyle := ControlStyle + [csOpaque];
end;


function TsSpeedButton.CaptionRect(ShiftClicked: boolean = True): TRect;
var
  l, t, r, b, iAddedWidth, iArrowWidth, iGlyphWidth, iGlyphHeight, iSpacing: integer;
  dh, dw, emptyw, imargin: integer;
  Size: TSize;
begin
  l := 0;
  t := 0;
  r := 0;
  b := 0;
  Size := TextRectSize;
  iGlyphWidth := GlyphWidth;
  iSpacing := Spacing * integer((iGlyphWidth > 0) and (Caption <> ''));
  iMargin := GenMargin;
  if ButtonStyle = tbsDropDown then
    if not Assigned(OnCLick) then begin
      iAddedWidth := 0;
      iArrowWidth := AddedWidth;
    end
    else begin
      iAddedWidth := AddedWidth;
      iArrowWidth := 0;
    end
  else begin
    iAddedWidth := 0;
    iArrowWidth := 0;
  end;

  case Layout of
    blGlyphLeft: begin
      emptyw := Width - iAddedWidth - iArrowWidth - Size.cx - iGlyphWidth - iSpacing - iMargin * 2; // Calc space for text
      t := (Height - Size.cy) div 2;
      b := t + Size.cy;
      case Alignment of
        taLeftJustify: begin
          case TextAlignment of
            taLeftJustify: l := iMargin + iGlyphWidth + iSpacing;

            taCenter:
              if iGlyphWidth = 0 then
                l := iMargin
              else
                l := emptyw div 2 + iGlyphWidth + iSpacing + iMargin;

            taRightJustify:
              if iGlyphWidth = 0 then
                l := iMargin
              else
                l := Width - iMargin - Size.cx - iAddedWidth - iArrowWidth;
          end;
          r := l + Size.cx;
        end;

        taCenter: begin
          l := iMargin + emptyw div 2 + iGlyphWidth + iSpacing;
          r := l + Size.cx;
        end;

        taRightJustify: begin
          r := Width - iAddedWidth - iArrowWidth - iMargin;
          l := r - Size.cx;
        end;
      end;
    end;

    blGlyphRight: begin
      emptyw := Width - iAddedWidth - iArrowWidth - iGlyphWidth - iSpacing - iMargin * 2;
      t := (Height - Size.cy) div 2;
      b := t + Size.cy;
      case Alignment of
        taLeftJustify: begin
          l := iMargin;
          r := iMargin + Size.cx
        end;

        taCenter: begin
          dw := (Width - iAddedWidth - iArrowWidth - iGlyphWidth - iSpacing - Size.cx) div 2 - iMargin;
          l := iMargin + dw;
          r := iMargin + dw + Size.cx
        end;

        taRightJustify: begin
          case TextAlignment of
            taCenter:
              if iGlyphWidth = 0 then
                l := Width - iMargin - Size.cx - iAddedWidth - iArrowWidth
              else
                l := (Width - iMargin - iGlyphWidth - iSpacing - Size.cx - iAddedWidth - iArrowWidth) div 2;

            taLeftJustify:
              if iGlyphWidth = 0 then
                l := Width - iMargin - Size.cx - iAddedWidth - iArrowWidth
              else
                l := iMargin;

            taRightJustify: l := Width - iMargin - iGlyphWidth - iSpacing - Size.cx - iAddedWidth - iArrowWidth;
          end;
          r := iMargin + emptyw;
        end;
      end;
    end;

    blGlyphTop: begin
      iGlyphHeight := GlyphHeight;
      dh := (Height - iGlyphHeight - Spacing * integer((iGlyphHeight > 0) and (Caption <> '')) - Size.cy) div 2 - iMargin;
      l := (Width - Size.cx - iAddedWidth - iArrowWidth) div 2;
      t := (iMargin + dh + iGlyphHeight + Spacing * integer((iGlyphHeight > 0) and (Caption <> '')));
      r := Width - l - iAddedWidth - iArrowWidth;
      b := Height - dh - iMargin;
    end;

    blGlyphBottom: begin
      iGlyphHeight := GlyphHeight;
      dh := (Height - iGlyphHeight - Spacing * integer((iGlyphHeight > 0) and (Caption <> '')) - Size.cy) div 2 - iMargin;
      l := (Width - Size.cx - iAddedWidth - iArrowWidth) div 2;
      t := iMargin + dh;
      r := Width - l - iAddedWidth - iArrowWidth;
      b := Height - dh - iMargin - iGlyphHeight - Spacing * integer((iGlyphHeight > 0) and (Caption <> ''));
    end;
  end;

  case Layout of
    blGlyphLeft, blGlyphRight: Result := Rect(l + FOffset, t, r + FOffset, b);
    blGlyphTop, blGlyphBottom: Result := Rect(l, t + FOffset, r, b + FOffset);
  end;

  if ShiftClicked and (CurrentState = 2) then
    if not SkinData.Skinned or (SkinData.SkinManager <> nil) and SkinData.SkinManager.ButtonsOptions.ShiftContentOnClick then
      OffsetRect(Result, 1, 1);
end;


procedure TsSpeedButton.CopyFromCache(aDC: hdc);
begin
  BitBlt(Canvas.Handle, 0, 0, Width, Height, aDC, 0, 0, SRCCOPY)
end;


constructor TsSpeedButton.Create(AOwner: TComponent);
begin
  FCommonData := TsCtrlSkinData.Create(Self, True);
  FCommonData.COC := COC_TsSpeedButton;
  inherited Create(AOwner);
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FButtonStyle := tbsButton;
  FWordWrap := True;

  FImageIndex := -1;
  FImageIndexHot := -1;
  FImageIndexPressed := -1;
  FImageIndexDisabled := -1;
  FImageIndexSelected := -1;

  FGrayed := False;
  FBlend := 0;
  FMenuOwnerMode := False;
  MenuVisible := False;
  FStdParent := False;
  FBGCopying := False;
  FHotState := False;
  FStdBG := nil;
  FGrayedMode := gmInactive;
  FDisabledGlyphKind := DefDisabledGlyphKind;
  FDisabledKind := DefDisabledKind;
  FOffset := 0;
  FAlignment := taCenter;
  FGlyphColorTone := clNone;
  FShowCaption := True;
  FUseEllipsis := True;
  FDrawOverBorder := True;
  FTextAlignment := taCenter;
  OldOnChange := Glyph.OnChange;
  OldMargin := -1;
  OldFlat := True;
  Glyph.OnChange := GlyphChanged;
  FAnimatEvents := [aeGlobalDef];
end;


function TsSpeedButton.CurrentImageIndex: integer;
begin
  Result := -1;
  if not Enabled then
    Result := FImageIndexDisabled
  else
    if ((FState in [bsDown, bsExclusive]) or MenuVisible) and not FMenuOwnerMode then
      if not (FState = bsExclusive) then
        Result := FImageIndexPressed
      else
        Result := FImageIndexSelected
    else
      if SkinData.FMouseAbove then
        Result := FImageIndexHot;

  if Result = -1 then
    Result := FImageIndex;
end;


function TsSpeedButton.CurrentState: integer;
begin
  if ((FState in [bsDown, bsExclusive]) or MenuVisible) and not FMenuOwnerMode then
    Result := 2
  else
    Result := integer(ControlIsActive(FCommonData) or FHotState or FMenuOwnerMode);
end;


type
  TAccessBasicAction = class(TBasicAction);


destructor TsSpeedButton.Destroy;
begin
//  if ActionLink <> nil then
//    TAccessBasicAction(Action).OnChange := nil;
//    ActionLink.OnChange := nil;

  if (FCommonData.SkinManager <> nil) and (FCommonData.SkinManager.ActiveGraphControl = Self) then
    FCommonData.SkinManager.ActiveGraphControl := nil;

  FreeAndNil(FCommonData);
  FreeAndNil(FStdBG);
  FreeAndNil(FImageChangeLink);
  inherited Destroy;
end;


procedure TsSpeedButton.DoDrawText(var R: TRect; Flags: Cardinal);
var
  aRect: TRect;
begin
  Flags := Flags or DT_NOCLIP;
  if WordWrap then
    Flags := Flags and not DT_SINGLELINE;

  if SkinData.Skinned then
    acWriteTextEx(FCommonData.FCacheBMP.Canvas, PacChar(Caption), True, R, Flags, FCommonData, boolean(CurrentState))
  else begin
    Canvas.Font.Assign(Font);
    Canvas.Brush.Style := bsClear;
    SelectObject(Canvas.Handle, Canvas.Font.Handle);
    if not Enabled then begin
      aRect := OffsRect(R, 1);
      Canvas.Font.Color := clBtnHighlight;
      acDrawText(Canvas.Handle, PacChar(Caption), aRect, Flags);
      Canvas.Font.Color := clBtnShadow;
    end;
    Canvas.Brush.Color := Color;
    Canvas.Brush.Style := bsClear;
    acDrawText(Canvas.Handle, PacChar(Caption), R, Flags);
  end;
  if ButtonStyle = tbsDropDown then begin
    aRect := ArrowRect;
    PaintArrow(@aRect, CurrentState);
  end;
end;


procedure TsSpeedButton.DrawCaption;
var
  R: TRect;
begin
  if ShowCaption then begin
    FCommonData.FCacheBmp.Canvas.Font.Assign(Font);
    FCommonData.FCacheBMP.Canvas.Brush.Style := bsClear;
    R := CaptionRect;
    DoDrawText(R, GetStringFlags(Self, FTextAlignment) or TextWrapping[WordWrap] or TextEllips[UseEllipsis]);
  end;
end;


procedure TsSpeedButton.DrawGlyph;
begin
  if SkinData.Skinned then
    DrawBtnGlyph(Self, SkinData.FCacheBmp.Canvas)
  else
    DrawBtnGlyph(Self, Canvas);
end;


function TsSpeedButton.GenMargin: integer;
begin
  Result := iff(Margin < 0, 0, Margin + 3);
end;


{$IFDEF DELPHI7UP}
function TsSpeedButton.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TacSpeedButtonActionLink;
end;
{$ENDIF}


function TsSpeedButton.GlyphHeight: integer;
begin
  if (Glyph <> nil) and (Glyph.Height > 0) then
    Result := Glyph.Height
  else
    if IsImgListDefined(Self) then
      Result := Images.Height
    else
      Result := 0;
end;


function TsSpeedButton.GlyphWidth: integer;
begin
  if (Glyph <> nil) and (Glyph.Width > 0) then
    Result := Glyph.Width div NumGlyphs
  else
    if IsImgListDefined(Self) then
      Result := Images.Width div NumGlyphs
    else
      Result := 0;
end;


procedure TsSpeedButton.GraphRepaint;
begin
  if ([csDestroying, csLoading] * ComponentState = []) and not (csCreating in ControlState) and not InAnimationProcess then
    if (Visible or (csDesigning in ComponentState)) then
      if Assigned(Parent) and Parent.HandleAllocated and IsWindowVisible(Parent.Handle) then
        with Skindata do
          if Skinned and not (csDesigning in ComponentState) then begin
            if not Updating then begin
              if BGChanged then begin
                if not PrepareCache then
                  Exit;

                if not (csPaintCopy in ControlState) then
                  PaintParentControls(Self, FCacheBmp.Canvas)
              end;
              if TimerIsActive(SkinData) and (AnimTimer.BmpOut <> nil) then
                CopyFromCache(SkinData.AnimTimer.BmpOut.Canvas.Handle)
              else
                CopyFromCache(FCacheBmp.Canvas.Handle);
            end;
          end
          else
            Repaint;
end;


function TsSpeedButton.ImgRect(ShiftClicked: boolean = True): TRect;
var
  x, y, iAddedWidth, iArrowWidth, iSpacing, iMargin, dh, dw, gh, gw: integer;
  TextSize: TSize;
begin
  x := 0;
  y := 0;
  Result := MkRect;
  gh := GlyphHeight;
  gw := GlyphWidth;
  TextSize := TextRectSize;
  iMargin := GenMargin;
  if ButtonStyle = tbsDropDown then
    if not Assigned(OnCLick) then begin
      iAddedWidth := 0;
      iArrowWidth := AddedWidth;
    end
    else begin
      iAddedWidth := AddedWidth;
      iArrowWidth := 0;
    end
  else begin
    iAddedWidth := 0;
    iArrowWidth := 0;
  end;
  iSpacing := Spacing * integer(ShowCaption and (gw > 0) and (Caption <> ''));
  dw := (Width - iAddedWidth - iArrowWidth - gw - iSpacing - TextSize.cx) div 2 - iMargin; // Content offset
  dh := (Height - gh - iSpacing - TextSize.cy) div 2 - iMargin;
  case Layout of
    blGlyphLeft: begin
      case Alignment of
        taLeftJustify:  x := iMargin;
        taCenter:       x := iMargin + dw;
        taRightJustify: x := iMargin + 2 * dw;
      end;
      y := (Height - gh) div 2;
    end;

    blGlyphRight:
      case Alignment of
        taLeftJustify: begin
          x := CaptionRect.Right + iSpacing;
          y := (Height - gh) div 2;
          if CurrentState = 2 then  // Return back
            dec(x);
        end;
        taCenter: begin
          x := (Width - iAddedWidth - iArrowWidth - gw + iSpacing + TextSize.cx) div 2;
          y := (Height - gh) div 2;
        end;
        taRightJustify: begin
          x := Width - iAddedWidth - iArrowWidth - gw - iMargin;
          y := (Height - gh) div 2;
        end;
      end;

    blGlyphTop: begin
      x := (Width - iAddedWidth - iArrowWidth - gw) div 2 + 1;
      y := iMargin + dh;
    end;

    blGlyphBottom: begin
      x := (Width - iAddedWidth - iArrowWidth - gw) div 2 + 1;
      y := Height - iMargin - dh - gh;
    end;
  end;
  if ShiftClicked and (CurrentState = 2) then
    if not SkinData.Skinned or (SkinData.SkinManager <> nil) and SkinData.SkinManager.ButtonsOptions.ShiftContentOnClick then begin
      inc(x);
      inc(y);
    end;
      
  Result := Rect(x, y, x + gw, y + gh);
  if Reflected then
    OffsetRect(Result, 0, - HeightOf(Result) div 6);
end;


procedure TsSpeedButton.Loaded;
begin
  inherited;
  FCommonData.Loaded;
  if FCommonData.Skinned then
    ControlStyle := ControlStyle + [csOpaque];

  if IsImgListDefined(Self) then
    Glyph.Assign(nil);

//  if ActionLink <> nil then
//    ActionLink.OnChange := ActionChanged;
end;


procedure TsSpeedButton.Paint;
var
  R: TRect;
  ParentDC: hdc;
begin
  if (Visible or (csDesigning in ComponentState)) and (Parent <> nil) then begin
    if Assigned(FCommonData.SkinManager) and FCommonData.SkinManager.Active and (FCommonData.SkinIndex < 1) then
      FCommonData.UpdateIndexes;

    if not FCommonData.Skinned then
      StdPaint
    else begin
      if (Width > 0) and (Height > 0) then
          if TimerIsActive(SkinData) then begin
            if Assigned(SkinData.AnimTimer.BmpOut) and (SkinData.AnimTimer.BmpOut.Width = Width) then
              BitBlt(Canvas.Handle, 0, 0, Width, Height, SkinData.AnimTimer.BmpOut.Canvas.Handle, 0, 0, SRCCOPY);
          end
          else begin
            if not SkinData.FMouseAbove or PtInRect(MkRect(Self), ScreenToClient(acMousePos)) then begin // Do not repaint automatically if btn pressed
              if (SkinData.AnimTimer <> nil) and (SkinData.AnimTimer.Enabled) and DroppedDown then
                Exit;
  {$IFDEF D2005}
              if CurrentState > 0 then
                FCommonData.BGChanged := True
              else
  {$ENDIF}
                FCommonData.BGChanged := (FStoredDown <> Down) or FCommonData.BGChanged or FCommonData.HalfVisible;

              FStoredDown := Down;
              if Parent <> nil then begin
                ParentDC := GetWindowDC(Parent.Handle);
                FCommonData.HalfVisible := (GetClipBox(ParentDC, R) = 0) or IsRectEmpty(R) or (WidthOF(R) < (Left + Width)) or (HeightOF(R) < (Top + Height)) or (Top < 0) or (Left < 0);
                ReleaseDC(Parent.Handle, ParentDC)
              end
              else
                FCommonData.HalfVisible := False;

              if not FCommonData.BGChanged then begin
                if FOldNumGlyphs <> NumGlyphs then begin
                  FCommonData.BGChanged := True;
                  FOldNumGlyphs := NumGlyphs;
                end
                else
                  if FOldSpacing <> Spacing then begin
                    FCommonData.BGChanged := True;
                    FOldSpacing := Spacing;
                  end;
              end
              else begin
                FOldNumGlyphs := NumGlyphs;
                FOldSpacing := Spacing;
              end;
              if not FCommonData.BGChanged and not FStdParent or PrepareCache then
                BitBlt(Canvas.Handle, 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
            end;
          end;
    end;
  end;
end;


function TsSpeedButton.PrepareCache: boolean;
var
  R: TRect;
  CI: TCacheInfo;
  BGInfo: TacBGInfo;
  ArrowMode, si, mi, w, Mode, x, y, z: integer;

  procedure PaintControl;
  begin
    InitCacheBmp(SkinData);
    FCommonData.FCacheBmp.Canvas.Font.Assign(Font);
    if CI.Ready and CI.Bmp.Empty then
      FCommonData.BGChanged := False
    else begin
      ArrowMode := 0;
      case FButtonStyle of
        tbsDivider: begin
          if CI.Ready then
            BitBlt(FCommonData.FCacheBMP.Canvas.Handle, 0, 0, Width, Height, CI.Bmp.Canvas.Handle, Left + CI.X, Top + CI.Y, SRCCOPY)
          else
            FillDC(FCommonData.FCacheBMP.Canvas.Handle, ClientRect, CI.FillColor);

          si := FCommonData.SkinManager.ConstData.Sections[ssDivider];
          if FCommonData.SkinManager.IsValidSkinIndex(si) then begin
            mi := FCommonData.SkinManager.GetMaskIndex(si, s_BordersMask);
            if Assigned(FCommonData.SkinManager) and FCommonData.SkinManager.IsValidImgIndex(mi) then begin
              w := Width div 2 - 1;
              DrawSkinRect(FCommonData.FCacheBmp, Rect(w, 0, w + 2, Height), CI, FCommonData.SkinManager.ma[mi], 0, False);
            end;
          end;
        end;

        tbsSeparator:
          if CI.Ready then
            BitBlt(FCommonData.FCacheBMP.Canvas.Handle, 0, 0, Width, Height, CI.Bmp.Canvas.Handle, Left, Top, SRCCOPY)
          else
            FillDC(FCommonData.FCacheBMP.Canvas.Handle, ClientRect, CI.FillColor)

        else begin
          if (FButtonStyle = tbsDropDown) {and Assigned(OnClick)} then begin
            if ((Assigned(DropDownMenu) and DroppedDown) or Down or (FState in [bsDown, bsExclusive])) then
              Mode := 2
            else
              Mode := integer(ControlIsActive(FCommonData));

            if Assigned(OnClick) then begin
              ArrowMode := 2;
              x := FCommonData.HUEOffset;
              y := FCommonData.Saturation;
              z := FCommonData.ColorTone;
              FCommonData.FHUEOffset  := 0;
              FCommonData.FSaturation := 0;
              FCommonData.FColorTone := clNone;
              // Paint BG
              PaintItemBG(FCommonData, ci, Mode, Rect(Width - AddedWidth, 0, Width, Height), Point(Left + Width - ArrowWidth, Top), FCommonData.FCacheBMP, integer(Down), integer(Down));
              inc(ci.X, Left);
              inc(ci.Y, Top);
              if FCommonData.SkinManager.IsValidImgIndex(FCommonData.BorderIndex) then
                DrawSkinRect(FCommonData.FCacheBMP, Rect(Width - AddedWidth, 0, Width, Height), ci, FCommonData.SkinManager.ma[FCommonData.BorderIndex], Mode, True);

              dec(ci.X, Left);
              dec(ci.Y, Top);
              FCommonData.FHUEOffset  := x;
              FCommonData.FSaturation := y;
              FCommonData.FColorTone  := z;
            end
            else
              ArrowMode := 1;
          end
          else
            Mode := CurrentState;

          if not FDrawOverBorder then begin
            PaintItemBG(FCommonData, ci, Mode, MkRect(Width - ArrowWidth, Height), Point(Left, Top), FCommonData.FCacheBMP, integer(Down), integer(Down));
            DrawCaption;
            DrawGlyph;
            if Assigned(FOnPaint) then
              FOnPaint(Self, FCommonData.FCacheBmp);

            inc(ci.X, Left);
            inc(ci.Y, Top);
            if FCommonData.SkinManager.IsValidImgIndex(FCommonData.BorderIndex) then
              DrawSkinRect(FCommonData.FCacheBMP, MkRect(Width - ArrowWidth, Height), ci, FCommonData.SkinManager.ma[FCommonData.BorderIndex], Mode, False);
          end
          else begin
            PaintItem(FCommonData, CI, True, Mode, MkRect(Width - integer(ArrowMode = 2) * ArrowWidth, Height), Point(Left, Top), FCommonData.FCacheBMP, True, integer(Down), integer(Down));
            DrawCaption;
            DrawGlyph;
            if (ArrowMode = 2) or not ShowCaption and (ArrowMode = 1) then begin
              R := ArrowRect;
              PaintArrow(@R, Mode);
            end;
            if Assigned(FOnPaint) then
              FOnPaint(Self, FCommonData.FCacheBmp);

          end;
          if not Enabled then begin
            CI := GetParentCache(FCommonData);
            BmpDisabledKind(FCommonData.FCacheBmp, FDisabledKind, Parent, CI, Point(Left, Top));
          end;
        end;
      end;
      FCommonData.BGChanged := False;
    end;
  end;

begin
  if Self <> nil then begin
    Result := True;

    BGInfo.Bmp := nil;
    BGInfo.BgType := btUnknown;
    BGInfo.PleaseDraw := False;
    BGInfo.FillRect := MkRect;
    Parent.Perform(SM_ALPHACMD, AC_GETBG_HI, LPARAM(@BGInfo));

    if BGInfo.BgType = btUnknown then begin
      FStdParent := True;
{
      if Transparent then begin
        ControlStyle := ControlStyle - [csOpaque];
        if not FBGCopying then begin
          FBGCopying := True;
          if FStdBG = nil then
            FStdBG := CreateBmp32(Self)
          else begin
            FStdBG.Width := Width;
            FStdBG.Height := Height;
          end;
          CI.Bmp := FStdBG;
          CI.X := -Left;
          CI.Y := -Top;
          CI.Ready := True;
          if not (csPaintCopy in Parent.ControlState) and not (Assigned(SkinData.AnimTimer) and (SkinData.AnimTimer.State > 0)) and not FCommonData.FMouseAbove then begin
            DC := GetDC(Parent.Handle);
            try
              BitBlt(FStdBG.Canvas.Handle, 0, 0, Width, Height, DC, Left, Top, SRCCOPY);
            finally
              ReleaseDC(Parent.Handle, DC);
            end;
          end;
          PaintControl;
          FBGCopying := False;
        end;
      end
      else }
      begin
        ControlStyle := ControlStyle + [csOpaque];
        InitCacheBmp(SkinData);
        CI.Ready := False;
        CI.Bmp := nil;
        CI.FillColor := ColorToRGB(TsAccessControl(Parent).Color);
        PaintControl;
      end;
    end
    else
      if BGInfo.BgType = btNotReady then begin
        FCommonData.FUpdating := True;
        Result := False;
      end
      else begin
        CI := BGInfoToCI(@BGInfo);
        PaintControl;
      end;
  end
  else
    Result := False;
end;


procedure TsSpeedButton.SetAlignment(const Value: TAlignment);
begin
  if FAlignment <> Value then begin
    FAlignment := Value;
    UpdateControl;
  end;
end;


procedure TsSpeedButton.SetButtonStyle(const Value: TToolButtonStyle);
begin
  if FButtonStyle <> Value then begin
    if not (csLoading in ComponentState) then
      if Value = tbsDropDown then
        Width := Width + AddedWidth
      else
        if FButtonStyle = tbsDropdown then
          Width := Width - AddedWidth;

    FButtonStyle := Value;
    UpdateControl;
  end;
end;


procedure TsSpeedButton.SetDisabledGlyphKind(const Value: TsDisabledGlyphKind);
begin
  if FDisabledGlyphKind <> Value then begin
    FDisabledGlyphKind := Value;
    UpdateControl;
  end;
end;


procedure TsSpeedButton.SetDisabledKind(const Value: TsDisabledKind);
begin
  if FDisabledKind <> Value then begin
    FDisabledKind := Value;
    UpdateControl;
  end;
end;


procedure TsSpeedButton.SetImages(const Value: TCustomImageList);
begin
  if Images <> Value then begin
    if Images <> nil then
      Images.UnRegisterChanges(FImageChangeLink);

    FImages := Value;
    if Images <> nil then begin
      Images.RegisterChanges(FImageChangeLink);
      Images.FreeNotification(Self);
    end;
    UpdateControl;
  end;
end;


function TsSpeedButton.TextRectSize: TSize;
var
  R: TRect;
begin
  R := MkRect(MaxCaptionWidth(Self), 0);
  acDrawText(FCommonData.FCacheBMP.Canvas.Handle, Caption, R, TextWrapping[FWordWrap] or TextEllips[UseEllipsis] or DT_EXPANDTABS or DT_CALCRECT);
  Result := MkSize(R);
end;


procedure TsSpeedButton.UpdateControl;
begin
  if (Visible or (csDesigning in ComponentState)) and (SkinData.CtrlSkinState and ACS_LOCKED = 0) then begin
    FCommonData.BGChanged := True;
    GraphRepaint;
  end;
end;


procedure TsSpeedButton.WndProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
//  if Tag = 1 then
    AddToLog(Message);
{$ENDIF}
  if Message.Msg = SM_ALPHACMD then
    case Message.WParamHi of
      AC_CTRLHANDLED: begin
        Message.Result := 1;
        Exit;
      end;

      AC_SETNEWSKIN:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          CommonMessage(Message, FCommonData);
          if FCommonData.Skinned then
            ControlStyle := ControlStyle + [csOpaque];

          Exit;
        end;

      AC_REMOVESKIN:
        if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) and not (csDestroying in ComponentState) then begin
          CommonMessage(Message, FCommonData);
          ControlStyle := ControlStyle - [csOpaque];
          if Visible or (csDesigning in ComponentState) then
            Repaint;
        end;

      AC_ENDPARENTUPDATE: begin
        if not InUpdating(FCommonData, True) and FCommonData.Skinned then
          GraphRepaint;

        Exit;
      end;

      AC_REFRESH:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          CommonMessage(Message, FCommonData);
          if Visible or (csDesigning in ComponentState) then
            Repaint;

          Exit;
        end;

      AC_INVALIDATE: begin
        FCommonData.FUpdating := False;
        GraphRepaint;
        Exit;
      end;

      AC_MOUSELEAVE: begin
        Ac_CMMouseLeave;
        Exit;
      end;

      AC_GETDEFINDEX: begin
        if FCommonData.SkinManager <> nil then
          if Flat then
            Message.Result := FCommonData.SkinManager.ConstData.Sections[ssToolButton] + 1
          else
            Message.Result := FCommonData.SkinManager.ConstData.Sections[ssSpeedButton] + 1;

        Exit;
      end;
    end;

  if not ControlIsReady(Self) or not FCommonData.Skinned then begin
    case Message.Msg of
//      CM_ACTIONUPDATE:
//        ActionChanged(Self);
//        if Action <> nil then
//          Enabled := TCustomAction(Action).Enabled;

      CM_MOUSEENTER:
        if Enabled and ([csDesigning, csDestroying] * ComponentState = []) then begin
          FCommonData.FMouseAbove := True;
          if Assigned(FOnMouseEnter) then
            FOnMouseEnter(Self);
        end;

      CM_MOUSELEAVE:
        if Enabled and ([csDesigning, csDestroying] * ComponentState = []) then begin
          FCommonData.FMouseAbove := False;
          if Assigned(FOnMouseLeave) then
            FOnMouseLeave(Self);

          if bsDown = FState then
            FState := bsUp;
        end;
    end;
    inherited
  end
  else begin
    case Message.Msg of
      SM_ALPHACMD:
        case Message.WParamHi of
          AC_UPDATESECTION: begin
            GraphRepaint;
            Exit;
          end;

          AC_PREPARING: begin
            Message.Result := LRESULT(FCommonData.FUpdating);
            Exit;
          end;

          AC_PREPARECACHE: begin
            PrepareCache;
            Exit;
          end;
        end;

      CM_MOUSEENTER:
        if Enabled and not MouseInControl and not (csDesigning in ComponentState) then begin
          Ac_CMMouseEnter;
          inherited;
          Exit;
        end;

      WM_MOUSELEAVE, CM_MOUSELEAVE:
        if Enabled and not InAnimationProcess then begin
          Ac_CMMouseLeave;
          inherited;
          Exit;
        end;

      WM_ERASEBKGND, WM_NCPAINT:
        Exit;

{$IFNDEF DYNAMICCACHE}
      CM_TEXTCHANGED:
        if ShowCaption then begin
          FCommonData.BGChanged := True;
          StopTimer(SkinData);
          GraphRepaint;
          Exit;
        end;
{$ENDIF}
      CM_PARENTCOLORCHANGED, WM_WINDOWPOSCHANGED, WM_SIZE:
        if Visible or (csDesigning in ComponentState) then
          FCommonData.BGChanged := True;

      WM_LBUTTONDBLCLK, WM_LBUTTONDOWN:
        if not (csDesigning in ComponentState) then
          if FMenuOwnerMode then
            Exit;

      WM_LBUTTONUP:
        if not (csDesigning in ComponentState) then begin
          if FMenuOwnerMode then
            Exit;

          if TimerIsActive(SkinData) and Assigned(SkinData.AnimTimer.BmpOut) and (SkinData.AnimTimer.BmpOut.Width = Width) then begin
            PrepareCache;
            GraphRepaint; // Fast repainting if clicked quickly
          end;
        end;
    end;

    if not CommonWndProc(Message, FCommonData) then begin
      inherited;
      case Message.Msg of
        CM_VISIBLECHANGED: begin
          SkinData.FMouseAbove := False;
          SkinData.BGChanged := True;
        end;

        WM_MOUSEMOVE:
          if SkinData.FMouseAbove then
            if FCommonData.SkinManager.ActiveGraphControl <> Self then begin
              SkinData.FMouseAbove := False;
              Ac_CMMouseEnter;
              Perform(CM_MOUSEENTER, 0, 0);
            end;

        CM_BUTTONPRESSED: begin // If changed when GroupIndex <> 0
          StopTimer(SkinData);
          FCommonData.BGChanged := True;
          GraphRepaint;
        end;

        CM_FONTCHANGED:
          if FCommonData.CustomFont then begin // If changed when GroupIndex <> 0
            StopTimer(SkinData);
            FCommonData.BGChanged := True;
            GraphRepaint;
          end;

        WM_LBUTTONDBLCLK, WM_LBUTTONDOWN:
          if not (csDesigning in ComponentState) then begin
            FCommonData.FUpdating := FCommonData.Updating;
            FCommonData.BGChanged := False;
            DoChangePaint(SkinData, 2, UpdateGraphic_CB, EventEnabled(aeMouseDown, FAnimatEvents), True, False);
         end;

        WM_LBUTTONUP:
          if Visible and ([csDesigning, csDestroying] * ComponentState = []) and (SkinData <> nil) then
            DoChangePaint(SkinData, integer(SkinData.FMouseAbove), UpdateGraphic_CB, EventEnabled(aeMouseUp, FAnimatEvents), True)
          else
            Message.Result := -1;

        CM_ENABLEDCHANGED:
          if Visible or (csDesigning in ComponentState) then begin
            if not Enabled then
              StopTimer(SkinData);

            FCommonData.BGChanged := True;
            if not (csLoading in ComponentState) then
              GraphRepaint;

            Exit;
          end;

        WM_MOVE:
          if (csDesigning in ComponentState) and not SkinData.Updating then
            Repaint;

        WM_SIZE, WM_WINDOWPOSCHANGED:
          if (csDesigning in ComponentState) and not SkinData.Updating then
            GraphRepaint;
      end;
    end;
  end;
end;


procedure TsSpeedButton.SetDropdownMenu(const Value: TPopupMenu);
begin
  if Value <> FDropdownMenu then begin
    FDropdownMenu := Value;
    if Value <> nil then
      Value.FreeNotification(Self);
  end;
end;


procedure TsSpeedButton.SetGlyphColorTone(const Value: TColor);
begin
  if FGlyphColorTone <> Value then begin
    FGlyphColorTone := Value;
    FCommonData.BGChanged := True;
    GraphRepaint;
  end;
end;


procedure TsSpeedButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  p: TPoint;
  c: TMouse;
begin
  if not ShowHintStored then begin
    AppShowHint := Application.ShowHint;
    Application.ShowHint := False;
    ShowHintStored := True;
  end;
  if (Button = mbLeft) and Enabled then
    if (ButtonStyle = tbsDropDown) and Assigned(DropDownMenu) and ((X > Width - AddedWidth) or not Assigned(OnCLick)) then begin
      TempControl := pointer(Self);
      c := nil;
      StopTimer(SkinData);
      if not MenuVisible then begin
{$IFNDEF FPC}
        if SkinData.SkinManager <> nil then
          SkinData.SkinManager.SkinableMenus.HookPopupMenu(DropDownMenu, SkinData.SkinManager.Active);
{$ENDIF}

        MenuVisible := True;
        DroppedDown := True;
        if not Assigned(OnCLick) then
          FState := bsDown;

        FCommonData.FUpdating := FCommonData.Updating;
        FCommonData.BGChanged := True;

        GraphRepaint;
        HideGlow(SkinData.GlowID);
        p := ClientToScreen(Point(0, Height));
        DropDownMenu.PopupComponent := Self;
        DropDownMenu.Popup(p.X, p.Y);
        ControlState := ControlState - [csLButtonDown]; // Not changed automatically
        DroppedDown := False;
        MenuVisible := False;
        TempControl := nil;
        if not PtInRect(Rect(p.x, p.y - Height - 1, p.x + Width, p.y - 1), c.CursorPos) then
          Perform(CM_MOUSELEAVE, 0, 0);

        StopTimer(SkinData);
        if not Assigned(OnCLick) then
          FState := bsUp;

        if not SkinData.Skinned then
          Repaint
        else begin
          GraphRepaint;
        end;
        if ShowHintStored then begin
          Application.ShowHint := AppShowHint;
          ShowHintStored := False;
        end;
      end;
    end
    else
      inherited
  else
    inherited;

end;


procedure TsSpeedButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not (csDestroying in ComponentState) then begin
    Application.ShowHint := AppShowHint;
    ShowHintStored := False;
    if (Button = mbLeft) and Enabled and (ButtonStyle = tbsDropDown) then begin
      DroppedDown := False;
      TempControl := nil;
    end;
    inherited;
  end;
end;


procedure TsSpeedButton.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
    if AComponent = Images then
      Images := nil
    else
      if AComponent = DropDownMenu then
        DropDownMenu := nil;
end;


procedure TsSpeedButton.ActionChange(Sender: TObject; CheckDefaults: Boolean);
var
  b: boolean;
begin
  inherited ActionChange(Sender, CheckDefaults);
  if not (csLoading in ComponentState) then
    with TCustomAction(Sender) do begin
      if (ActionList <> nil) and (Self.Images <> ActionList.Images) then begin
        Self.Images := ActionList.Images;
        b := True;
      end
      else
        b := False;

      if Self.ImageIndex <> ImageIndex then begin
        Self.ImageIndex := ImageIndex;
        b := True;
      end;
      if b and (Self.Images <> nil) and IsValidIndex(Self.ImageIndex, GetImageCount(Self.Images)) then
        Glyph.Assign(nil);

//      if ActionLink <> nil then
//        ActionLink.OnChange := ActionChanged;

      if not (csDestroying in ComponentState) then
        FCommonData.Invalidate;
    end;
end;


procedure TsSpeedButton.GlyphChanged(Sender: TObject);
begin
  if Assigned(OldOnChange) then
    OldOnChange(Glyph);

  if ([csLoading, csDestroying] * ComponentState = []) and not (csCreating in ControlState) then
    FCommonData.Invalidate;
end;


procedure TsSpeedButton.SetTextAlignment(const Value: TAlignment);
begin
  if FTextAlignment <> Value then begin
    FTextAlignment := Value;
    UpdateControl;
  end;
end;


procedure TsSpeedButton.ActionChanged(Sender: TObject);
var
  b: boolean;
begin
  with TCustomAction(Sender) do
    if not FCommonData.FUpdating and (Action <> nil) and (ActionList <> nil) then begin
      b := False;
      if Self.Images <> ActionList.Images then begin
        Self.Images := ActionList.Images;
        b := True;
      end;
{$IFDEF DELPHI2010}
      if Self.ImageIndex <> TacSpeedButtonActionLink(ActionLink).FImageIndex then begin
        Self.ImageIndex := TacSpeedButtonActionLink(ActionLink).FImageIndex;
        b := True;
      end;
{$ENDIF}
      if b then
        Repaint;
    end;
end;


procedure TsSpeedButton.Ac_CMMouseEnter;
begin
  if Assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);

  if not FCommonData.FMouseAbove and not (ButtonStyle in [tbsDivider, tbsSeparator]) and not SkinData.SkinManager.Options.NoMouseHover then begin
    FCommonData.FMouseAbove := True;
    FCommonData.SkinManager.ActiveGraphControl := Self;
    if not FMenuOwnerMode then
      DoChangePaint(SkinData, 1, UpdateGraphic_CB, EventEnabled(aeMouseEnter, FAnimatEvents), False)
    else
      FCommonData.BGChanged := True;
  end;
end;


type
  TAccessManager = class(TsSkinManager);


procedure TsSpeedButton.Ac_CMMouseLeave;
begin
  if FCommonData.FMouseAbove and not (csDestroying in ComponentState) and not acMouseInControl(Self) then begin
    if Assigned(FOnMouseLeave) then
      FOnMouseLeave(Self);

    FCommonData.FMouseAbove := False;
    if TAccessManager(FCommonData.SkinManager).FActiveGraphControl = Self then
      TAccessManager(FCommonData.SkinManager).FActiveGraphControl := nil;

    if bsDown = FState then
      FState := bsUp;

    if Visible and not (csDesigning in ComponentState) and not FMenuOwnerMode then begin
      if not DroppedDown then
        DoChangePaint(SkinData, 0, UpdateGraphic_CB, EventEnabled(aeMouseLeave, FAnimatEvents), False, False)
    end
    else
      FCommonData.BGChanged := True;
  end;
end;


procedure TsSpeedButton.Invalidate;
begin
  if (OldLayout <> Layout) or (OldMargin <> Margin) or (OldFlat <> Flat) then begin
    OldLayout := Layout;
    OldMargin := Margin;
    OldFlat   := Flat;
    FCommonData.BGChanged := True;
    FCommonData.UpdateIndexes;
  end;
  if not (FState in [bsDown]) or not SkinData.Skinned then
    inherited;
end;


procedure TsSpeedButton.StdPaint(PaintButton: boolean = True);
const
  DownStyles: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
  FillStyles: array[Boolean] of Integer = (BF_MIDDLE, 0);
var
  PaintRect: TRect;
  DrawFlags: Integer;
  ArrowPoints: array of TPoint;
{$IFDEF DELPHI7UP}
  Button: TThemedButton;
  ToolButton: TThemedToolBar;
  Details: TThemedElementDetails;
{$ENDIF}
begin
  Canvas.Lock;
  if not Enabled then
    FState := bsDisabled
  else
    if FState = bsDisabled then
      if Down and (GroupIndex <> 0) then
        FState := bsExclusive
      else
        FState := bsUp;

  Canvas.Font.Assign(Font);
  case ButtonStyle of
    tbsDivider: begin
{$IFDEF DELPHI7UP}
      PaintRect := ClientRect;
      PaintRect.Left := WidthOf(PaintRect) div 2 - 1;
      if acThemesEnabled then begin
        PaintRect.Right := PaintRect.Left + 4;
        PerformEraseBackground(Self, Canvas.Handle);
        ToolButton := ttbSeparatorNormal;
        Details := acThemeServices.GetElementDetails(ToolButton);
        acThemeServices.DrawElement(Canvas.Handle, Details, PaintRect);
      end
      else
{$ENDIF}
      begin
        PaintRect.Right := PaintRect.Left + 2;
        DrawEdge(Canvas.Handle, PaintRect, BDR_SUNKENOUTER, BF_RECT);
      end;
    end;

    tbsSeparator:
    // Leaved as is

    else begin
      if PaintButton then begin
        if (ButtonStyle = tbsDropDown) and Assigned(OnCLick) then begin
          PaintRect := ClientRect;
          PaintRect.Right := PaintRect.Right - ArrowWidth;
        end
        else
          PaintRect := ClientRect;
{$IFDEF DELPHI7UP}
        if acThemesEnabled then begin
          PerformEraseBackground(Self, Canvas.Handle);
                                             
          if not Enabled then
            Button := tbPushButtonDisabled
          else
            if FState in [bsDown, bsExclusive] then
              Button := tbPushButtonPressed
            else
              if MouseInControl or FHotState then
                Button := tbPushButtonHot
              else
                Button := tbPushButtonNormal;
                
          ToolButton := ttbToolbarDontCare;
          if Flat then
            case Button of
              tbPushButtonDisabled: Toolbutton := ttbButtonDisabled;
              tbPushButtonPressed : Toolbutton := ttbButtonPressed;
              tbPushButtonHot     : Toolbutton := ttbButtonHot;
              tbPushButtonNormal  : Toolbutton := ttbButtonNormal;
            end;

          if ToolButton = ttbToolbarDontCare then begin
            Details := acThemeServices.GetElementDetails(Button);
            acThemeServices.DrawElement(Canvas.Handle, Details, PaintRect);
{$IFDEF DELPHI_XE2}
            acThemeServices.GetElementContentRect(Canvas.Handle, Details, PaintRect, PaintRect);
{$ELSE}
            PaintRect := acThemeServices.ContentRect(Canvas.Handle, Details, PaintRect);
{$ENDIF}
          end
          else begin
            Details := acThemeServices.GetElementDetails(ToolButton);
            acThemeServices.DrawElement(Canvas.Handle, Details, PaintRect);
{$IFDEF DELPHI_XE2}
            acThemeServices.GetElementContentRect(Canvas.Handle, Details, PaintRect, PaintRect);
{$ELSE}
            PaintRect := acThemeServices.ContentRect(Canvas.Handle, Details, PaintRect);
{$ENDIF}
          end;
          if ButtonStyle = tbsDropDown then begin
            PaintRect := ClientRect;
            PaintRect.Left := PaintRect.Right - ArrowWidth;

            if (Assigned(DropDownMenu) and DroppedDown) or Down or (FState in [bsDown, bsExclusive]) then
              if ToolButton = ttbToolbarDontCare then begin
                Button := tbPushButtonPressed;
                Details := acThemeServices.GetElementDetails(Button);
              end
              else begin
                ToolButton := ttbButtonPressed;
                Details := acThemeServices.GetElementDetails(ToolButton);
              end;

            acThemeServices.DrawElement(Canvas.Handle, Details, PaintRect);
            SetLength(ArrowPoints, 3);

            ArrowPoints[0] := Point(Width - 12 + integer(Toolbutton = ttbButtonPressed), (HeightOf(PaintRect) - 5) div 2 + PaintRect.Top + integer(Toolbutton = ttbButtonPressed));
            ArrowPoints[1] := Point(ArrowPoints[0].X + 5, ArrowPoints[0].Y);
            ArrowPoints[2] := Point(ArrowPoints[0].X + 2, ArrowPoints[0].Y + 5);

            Canvas.Brush.Style := bsSolid;
            Canvas.Brush.Color := clBtnText;
            Canvas.Pen.Color := clBtnText;
            Canvas.Polygon(ArrowPoints);
          end;

        end
        else
{$ENDIF}
        begin
          if not Flat then begin
            DrawFlags := DFCS_BUTTONPUSH or DFCS_ADJUSTRECT;
            if FState in [bsDown, bsExclusive] then
              DrawFlags := DrawFlags or DFCS_PUSHED;

            DrawFrameControl(Canvas.Handle, PaintRect, DFC_BUTTON, DrawFlags);
          end
          else begin
            if (FState in [bsDown, bsExclusive]) or (MouseInControl and (FState <> bsDisabled)) or (csDesigning in ComponentState) then
              DrawEdge(Canvas.Handle, PaintRect, DownStyles[FState in [bsDown, bsExclusive]], FillStyles[Transparent] or BF_RECT)
            else
              if not Transparent then begin
                Canvas.Brush.Color := Color;
                Canvas.FillRect(PaintRect);
              end;

            InflateRect(PaintRect, -1, -1);
          end;
{$IFDEF FPS}
          if FState in [bsDown, bsExclusive] then
            if (FState = bsExclusive) and (not Flat or not MouseInControl) then begin
              Canvas.Brush.Bitmap := AllocPatternBitmap(clBtnFace, clBtnHighlight);
              Canvas.FillRect(PaintRect);
            end;
{$ENDIF}

          if ButtonStyle = tbsDropDown then begin
            PaintRect := ClientRect;
            PaintRect.Left := PaintRect.Right - ArrowWidth;
            if Assigned(OnCLick) then
              if (Assigned(DropDownMenu) and DroppedDown) or Down or (FState in [bsDown, bsExclusive]) then
                if not Flat then begin
                  DrawFlags := DFCS_BUTTONPUSH or DFCS_ADJUSTRECT or DFCS_PUSHED;
                  DrawFrameControl(Canvas.Handle, PaintRect, DFC_BUTTON, DrawFlags);
                end
                else
                  DrawEdge(Canvas.Handle, PaintRect, DownStyles[True], FillStyles[Transparent] or BF_RECT)
              else
                if not Flat then begin
                  DrawFlags := DFCS_BUTTONPUSH or DFCS_ADJUSTRECT;
                  DrawFrameControl(Canvas.Handle, PaintRect, DFC_BUTTON, DrawFlags);
                end
                else
                  if MouseInControl then
                    DrawEdge(Canvas.Handle, PaintRect, DownStyles[FState in [bsDown, bsExclusive]], FillStyles[Transparent] or BF_RECT);

            SetLength(ArrowPoints, 3);
            ArrowPoints[0] := Point(Width - 12 + integer(FState in [bsDown, bsExclusive]), (HeightOf(PaintRect) - 5) div 2 + PaintRect.Top + integer(FState in [bsDown, bsExclusive]));
            ArrowPoints[1] := Point(ArrowPoints[0].X + 5, ArrowPoints[0].Y);
            ArrowPoints[2] := Point(ArrowPoints[0].X + 2, ArrowPoints[0].Y + 5);
            Canvas.Brush.Style := bsSolid;
            Canvas.Brush.Color := clBtnText;
            Canvas.Pen.Color := clBtnText;
            Canvas.Polygon(ArrowPoints);
          end;
        end;
      end;
      DrawCaption;
      DrawGlyph;
    end;
  end;
  Canvas.UnLock;
end;


procedure TsSpeedButton.ImageListChange(Sender: TObject);
begin
  if SkinData.Skinned then begin
    SkinData.BGChanged := True;
    GraphRepaint;
  end
  else
    Repaint;
end;


procedure TsSpeedButton.SetBoolean(const Index: Integer; const Value: boolean);
begin
  case Index of
    0: if FDrawOverBorder <> Value then begin
      FDrawOverBorder := Value;
      UpdateControl;
    end;

    1: if FGrayed <> Value then begin
      FGrayed := Value;
      UpdateControl;
    end;

    2: if FReflected <> Value then begin
      FReflected := Value;
      UpdateControl;
    end;

    3: if FShowCaption <> Value then begin
      FShowCaption := Value;
      UpdateControl;
    end;

    4: if FWordWrap <> Value then begin
      FWordWrap := Value;
      UpdateControl;
    end;

    5: if FUseEllipsis <> Value then begin
      FUseEllipsis := Value;
      UpdateControl;
    end;
  end;
end;


procedure TsSpeedButton.PaintArrow(const pR: PRect; Mode: integer);
var
  iNdx: integer;
begin
  with FCommonData do
    if Skinned then begin
      iNdx := GetFontIndex(Self, SkinIndex, SkinManager, Mode); // Receive parent font if needed
      if iNdx >= 0 then
        DrawColorArrow(FCacheBmp, SkinManager.gd[iNdx].Props[min(Mode, ac_MaxPropsIndex)].FontColor.Color, pR^, asBottom)
      else
        DrawColorArrow(FCacheBmp, Font.Color, pR^, asBottom);
    end
    else
      DrawColorArrow(FCacheBmp.Canvas, Font.Color, pR^, asBottom);
end;


constructor TsTimerSpeedButton.Create(AOwner: TComponent);
begin
  inherited;
  Width := Height - 4;
end;


procedure TsSpeedButton.SetInteger(const Index: Integer; const Value: integer);
var
  i: integer;
begin
  case Index of
    0: begin
      i := LimitIt(Value, 0, 100);
      if FBlend <> i then begin
        FBlend := i;
        UpdateControl;
      end;
    end;

    1: if FImageIndex <> Value then begin
      FImageIndex := Value;
      UpdateControl;
    end;

    2: if (FOffset <> Value) then begin
      FOffset := Value;
      UpdateControl;
    end;

    3: if FImageIndexHot <> Value then begin
      FImageIndexHot := Value;
      UpdateControl;
    end;

    4: if FImageIndexPressed <> Value then begin
      FImageIndexPressed := Value;
      UpdateControl;
    end;

    5: if FImageIndexDisabled <> Value then begin
      FImageIndexDisabled := Value;
      UpdateControl;
    end;

    6: if FImageIndexSelected <> Value then begin
      FImageIndexSelected := Value;
      UpdateControl;
    end;
  end;
end;


{$IFDEF DELPHI7UP}
procedure TacSpeedButtonActionLink.SetImageIndex(Value: Integer);
begin
  if IsImageIndexLinked or FClient.Glyph.Empty then begin
{$IFDEF DELPHI2010}
    FImageIndex := Value;
{$ENDIF}
    if (Action is TCustomAction) and (FClient is TsSpeedButton) then
      TsSpeedButton(FClient).ActionChanged(Action);
  end;
end;
{$ENDIF}

end.
