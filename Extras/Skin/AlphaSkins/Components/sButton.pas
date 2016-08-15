unit sButton;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ImgList, Menus, StdCtrls,
  {$IFNDEF DELPHI5}   Types,       {$ENDIF}
  {$IFDEF DELPHI_XE2} UITypes,     {$ENDIF}
  {$IFDEF LOGGED}     sDebugMsgs,  {$ENDIF}
  {$IFDEF TNTUNICODE} TntStdCtrls, {$ENDIF}
  {$IFDEF FPC}        LMessages, lcltype,   {$ENDIF}
  sCommonData, sConst, sDefaults, sFade;


type
{$IFNDEF NOTFORHELP}
  TButtonStyle = (bsPushButton, bsCommandLink, bsSplitButton);
{$ENDIF}

{$IFNDEF D2009}
{$IFNDEF NOTFORHELP}
  TImageAlignment = (iaLeft, iaRight, iaTop, iaBottom, iaCenter);

  TImageMargins = class(TPersistent)
  private
    FTop,
    FLeft,
    FRight,
    FBottom: Integer;
    FOnChange: TNotifyEvent;
    procedure SetMargin(Index, Value: Integer);
  protected
    procedure Change;
  public
    procedure Assign(Source: TPersistent); override;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property Left:   Integer index 0 read FLeft   write SetMargin default 0;
    property Top:    Integer index 1 read FTop    write SetMargin default 0;
    property Right:  Integer index 2 read FRight  write SetMargin default 0;
    property Bottom: Integer index 3 read FBottom write SetMargin default 0;
  end;
{$ENDIF}
{$ENDIF}


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
{$IFDEF TNTUNICODE}
  TsButton = class(TTntButton)
{$ELSE}
  TsButton = class(TButton)
{$ENDIF}
{$IFNDEF NOTFORHELP}
  private
    FOnMouseEnter,
    FOnMouseLeave: TNotifyEvent;

    FDown,
    FShowFocus,
    FMouseClicked,
    RegionChanged,
    FReflected: boolean;

    FFocusMargin,
    FContentMargin: integer;

    LastRect: TRect;
    FStyle: TButtonStyle;
    FDisabledKind: TsDisabledKind;
    FAnimatEvents: TacAnimatEvents;
    FCommonData: sCommonData.TsCtrlSkinData;
{$IFNDEF D2009}
    FImageIndex,
    FHotImageIndex,
    FPressedImageIndex,
    FDisabledImageIndex,
    FSelectedImageIndex: TImageIndex;

    FDropDownMenu: TPopupMenu;
    FCommandLinkHint: acString;
    FImageChangeLink: TChangeLink;
    FImages: TCustomImageList;
    FImageAlignment: TImageAlignment;
    FImageMargins: TImageMargins;
{$ELSE}
    OldImageIndex: integer;
{$ENDIF}
{$IFNDEF DELPHI7UP}
    FWordWrap: boolean;
    procedure SetWordWrap(const Value: boolean);
{$ENDIF}
    procedure SetDown          (const Value: boolean);
    procedure SetStyle         (const Value: TButtonStyle);
    procedure SetShowFocus     (const Value: boolean);
    procedure SetReflected     (const Value: boolean);
    procedure SetFocusMargin   (const Value: integer);
    procedure SetDisabledKind  (const Value: TsDisabledKind);
    procedure SetContentMargin (const Value: integer);
    procedure WMKeyUp      (var Message: TWMKey);         message WM_KEYUP;
    procedure CNDrawItem   (var Message: TWMDrawItem);    message CN_DRAWITEM;
    procedure CNMeasureItem(var Message: TWMMeasureItem); message CN_MEASUREITEM;
    function GetDown: boolean;
{$IFNDEF D2009}
    procedure ImageListChange(Sender: TObject);
    procedure ImageMarginsChange(Sender: TObject);
    procedure SetImages            (const Value: TCustomImageList);
    procedure SetImageMargins      (const Value: TImageMargins);
    procedure SetHotImageIndex     (const Value: TImageIndex);
    procedure SetImageAlignment    (const Value: TImageAlignment);
    procedure SetCommandLinkHint   (const Value: acString);
    procedure SetPressedImageIndex (const Value: TImageIndex);
    procedure SetDisabledImageIndex(const Value: TImageIndex);
    procedure SetSelectedImageIndex(const Value: TImageIndex);
    procedure SetImageIndex        (const Value: TImageIndex);
{$ELSE}
    function GetImageIndex: TImageIndex;
    procedure SetImageIndex        (const Value: TImageIndex);
{$ENDIF}
    function IsImageIndexStored: Boolean;
  protected
    IsFocused,
    DroppedDown: boolean;
    FRegion: hrgn;
{$IFDEF D2009}
    procedure UpdateImages; override;
    procedure UpdateImageList; override;
{$ELSE}
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
{$ENDIF}
    procedure StdDrawItem(const DrawItemStruct: TDrawItemStruct);
    procedure SetButtonStyle(ADefault: Boolean); {$IFNDEF FPC} override;{$ENDIF}
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure OurPaintHandler(aDC: hdc);
    procedure DrawCaption(Canvas: TCanvas = nil);
    procedure DrawGlyph  (Canvas: TCanvas = nil);
    function CaptionRect: TRect;
    function GlyphExist: boolean;
    function PrepareCache: boolean;
  public
    constructor Create(AOwner: TComponent); override;
    procedure CreateParams(var Params: TCreateParams); override;
    function CurrentState: integer;
    function GlyphIndex: integer;
    function GlyphRect: TRect;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure Invalidate; override;
    procedure Loaded; override;
    procedure WndProc(var Message: TMessage); override;
  published
{$ENDIF} // NOTFORHELP
    property AnimatEvents: TacAnimatEvents read FAnimatEvents write FAnimatEvents default [aeGlobalDef];
    property SkinData: TsCtrlSkinData read FCommonData write FCommonData;
    property ShowFocus: boolean read FShowFocus write SetShowFocus default True;
    property DisabledKind: TsDisabledKind read FDisabledKind write SetDisabledKind default DefDisabledKind;
    property Down: boolean read GetDown write SetDown default False;
    property FocusMargin: integer read FFocusMargin write SetFocusMargin default 1;
{$IFNDEF NOTFORHELP}
{$IFNDEF D2009}
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property CommandLinkHint: acString read FCommandLinkHint write SetCommandLinkHint;
    property DropDownMenu: TPopupMenu read FDropDownMenu write FDropDownMenu;
    property Images: TCustomImageList read FImages write SetImages;
    property ImageAlignment: TImageAlignment read FImageAlignment write SetImageAlignment default iaLeft;
    property ImageMargins: TImageMargins read FImageMargins write SetImageMargins;

    property HotImageIndex:      TImageIndex read FHotImageIndex      write SetHotImageIndex default -1;
    property DisabledImageIndex: TImageIndex read FDisabledImageIndex write SetDisabledImageIndex default -1;
    property PressedImageIndex:  TImageIndex read FPressedImageIndex  write SetPressedImageIndex default -1;
    property SelectedImageIndex: TImageIndex read FSelectedImageIndex write SetSelectedImageIndex default -1;
    property ImageIndex:         TImageIndex read FImageIndex         write SetImageIndex stored IsImageIndexStored default -1;
{$ELSE}
    property ImageIndex:         TImageIndex read GetImageIndex       write SetImageIndex stored IsImageIndexStored default -1;
{$ENDIF}
    property Style: TButtonStyle read FStyle write SetStyle default bsPushButton;
{$ENDIF} // NOTFORHELP
    property ContentMargin: integer read FContentMargin write SetContentMargin default 6;
    property Reflected: boolean read FReflected write SetReflected default False;
    property WordWrap{$IFNDEF DELPHI7UP}: boolean read FWordWrap write SetWordWrap{$ENDIF} default True;
  end;


implementation

uses
  ActnList, math,
  {$IFDEF DELPHI7UP}Themes, {$ENDIF}
  sVCLUtils, sMessages, acntUtils, sGraphUtils, sAlphaGraph, sBorders, sSkinManager, sThirdParty,
  sStyleSimply, acGlow, acntTypes;


{$IFNDEF D2009}
type
  TPushButtonActionLink = class(TButtonActionLink)
  protected
    function IsImageIndexLinked: Boolean; override;
    procedure SetImageIndex(Value: Integer); override;
  end;
{$ENDIF}


const
  ContentSpacing = 6;
  DropWidth = 16;


var
  bFocusChanging: boolean = False;


function MaxContentWidth(Button: TsButton): integer;
begin
  with Button do
    Result := Width - 2 * FContentMargin;
end;


function GetImageSize(Button: TsButton; AddMargins: boolean = True): TSize;
begin
  with Button do begin
    if (Images <> nil) and (ImageIndex >= 0) and (ImageIndex < GetImageCount(Images)) then
      Result := MkSize(Images.Width, Images.Height)
    else
      Result := MkSize(32, 32);

    if AddMargins then
      Result := MkSize(Result.cx + ImageMargins.Left + ImageMargins.Right, Result.cy + ImageMargins.Top + ImageMargins.Bottom);
  end;
end;


function GetCaptionSize(Button: TsButton): TSize;
var
  R: TRect;
  Flags: Cardinal;
begin
  with Button do
    if Caption <> '' then begin
      SelectObject(SkinData.FCacheBmp.Canvas.Handle, Button.Font.Handle);
      if Style = bsCommandLink then begin
        SkinData.FCacheBmp.Canvas.Font.Style := SkinData.FCacheBmp.Canvas.Font.Style + [fsBold];
        SkinData.FCacheBmp.Canvas.Font.Size := SkinData.FCacheBmp.Canvas.Font.Size + 2;
      end;
      Flags := DT_EXPANDTABS or DT_CENTER or DT_CALCRECT;
      if WordWrap then
        Flags := Flags or DT_WORDBREAK
      else
        Flags := Flags or DT_SINGLELINE;

      if Style = bsPushButton then
        R := Rect(FContentMargin, 0, Width - FContentMargin, 0)
      else
        R := Rect(FContentMargin, 0, Width - 2 * FContentMargin - GetImageSize(Button).cx - ContentSpacing - FContentMargin, 0);

      acDrawText(SkinData.FCacheBmp.Canvas.Handle, Caption, R, Flags);
      if Style = bsCommandLink then begin
        SkinData.FCacheBmp.Canvas.Font.Style := SkinData.FCacheBmp.Canvas.Font.Style - [fsBold];
        SkinData.FCacheBmp.Canvas.Font.Size := SkinData.FCacheBmp.Canvas.Font.Size - 2;
      end;
      Result := MkSize(R);
    end
    else
      Result := MkSize;
end;


function GetHintSize(Button: TsButton): TSize;
var
  R: TRect;
  Flags: Cardinal;
begin
  with Button do
    if CommandLinkHint <> '' then begin
      Flags := DT_EXPANDTABS or DT_CENTER or DT_CALCRECT or DT_WORDBREAK;
      R := MkRect(MaxContentWidth(Button) - GetImageSize(Button).cx, 0);
      acDrawText(SkinData.FCacheBmp.Canvas.Handle, CommandLinkHint, R, Flags);
      Result := MkSize(R);
    end
    else
      Result := MkSize;
end;


procedure TsButton.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TCustomAction then
    Self.Enabled := TCustomAction(Sender).Enabled;
end;


procedure TsButton.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or BS_OWNERDRAW;
end;


procedure TsButton.CNMeasureItem(var Message: TWMMeasureItem);
begin
  with Message.MeasureItemStruct^ do begin
    itemWidth  := Width;
    itemHeight := Height;
  end;
end;


procedure TsButton.AfterConstruction;
begin
  inherited;
  FCommonData.Loaded;
end;


procedure TsButton.Invalidate;
begin
{$IFDEF D2009}
  if OldImageIndex <> ImageIndex then begin
    OldImageIndex := ImageIndex;
    FCommonData.BGChanged := True;
  end;
{$ENDIF}
  inherited;
end;


procedure TsButton.SetButtonStyle(ADefault: Boolean);
begin
  if ADefault <> IsFocused then
    IsFocused := ADefault;

  SkinData.Invalidate;
end;


function TsButton.CaptionRect: TRect;
var
  Size: TSize;
  aWidth: integer;
begin
  Size := GetCaptionSize(Self);
  aWidth := Width;
  if Style = bsSplitButton then
    dec(aWidth, DropWidth);

  if Style = bsCommandLink then begin
    Result.Left := FContentMargin + GetImageSize(Self).cx + ContentSpacing;
    Result.Right := aWidth - FContentMargin;
    Result.Top := FContentMargin;
    Result.Bottom := Result.Top + Size.cy;
  end
  else
    if GlyphExist and (ImageAlignment <> iaCenter) then
      case ImageAlignment of
        iaLeft: begin
          Result.Left := ImageMargins.Left + FContentMargin + Images.Width + ImageMargins.Right;
          Result.Right := aWidth - FContentMargin;
          Result.Top := (Height - Size.cy) div 2;
          Result.Bottom := Height - Result.Top;
        end;

        iaRight: begin
          Result.Right := aWidth - (ImageMargins.Right + FContentMargin + Images.Width + ImageMargins.Left);
          Result.Left := FContentMargin;
          Result.Top := (Height - Size.cy) div 2;
          Result.Bottom := Height - Result.Top;
        end;

        iaTop: begin
          Result.Top := ImageMargins.Top + 2 * FContentMargin + Images.Height;
          Result.Bottom := Height - FContentMargin;

          Result.Top := Result.Top + (Result.Bottom - Result.Top - Size.cy) div 2;
          Result.Bottom := Result.Top + Size.cy;

          Result.Left := FContentMargin;
          Result.Right := aWidth - FContentMargin;
        end

        else {iaBottom} begin
          Result.Bottom := Height - (ImageMargins.Bottom + FContentMargin + Images.Height + ImageMargins.Top);
          Result.Top := ImageMargins.Top + (Result.Bottom - ImageMargins.Top - Size.cy) div 2;
          Result.Bottom := Result.Top + Size.cy;

          Result.Left := FContentMargin;
          Result.Right := aWidth - FContentMargin;
        end;
      end
    else begin
      Result.Left   := (aWidth - Size.cx) div 2 - 1;
      Result.Right  := Result.Left + Size.cx + 2;
      Result.Top    := (Height - Size.cy) div 2;
      Result.Bottom := Height - Result.Top;
    end;
    
  if CurrentState = 2 then
    if not SkinData.Skinned or (SkinData.SkinManager <> nil) and SkinData.SkinManager.ButtonsOptions.ShiftContentOnClick then
      OffsetRect(Result, 1, 1);
end;


constructor TsButton.Create(AOwner: TComponent);
begin
  FCommonData := sCommonData.TsCtrlSkinData.Create(Self, True);
  FCommonData.COC := COC_TsButton;
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csOpaque, csDoubleClicks];// + [csAcceptsControls];
  FDisabledKind := DefDisabledKind;
  FFocusMargin := 1;
  FDown := False;
  FRegion := 1;
  FAnimatEvents := [aeGlobalDef];
  FShowFocus := True;
  FReflected := False;
  FContentMargin := 6;
  DroppedDown := False;
{$IFNDEF DELPHI7UP}
  FWordWrap := True;
{$ELSE}
  WordWrap := True;
{$ENDIF}
  RegionChanged := True;
{$IFNDEF D2009}
  FDropDownMenu := nil;
  FStyle := bsPushButton;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FImageMargins := TImageMargins.Create;
  FImageMargins.OnChange := ImageMarginsChange;
  FCommandLinkHint := '';
  FDisabledImageIndex := -1;
  FHotImageIndex := -1;
  FImageAlignment := iaLeft;
  FImageIndex := -1;
  FPressedImageIndex := -1;
  FSelectedImageIndex := -1;
{$ELSE}
  OldImageIndex := -1;
{$ENDIF}
end;


function TsButton.CurrentState: integer;
begin
  if ((SendMessage(Handle, BM_GETSTATE, 0, 0) and BST_PUSHED = BST_PUSHED) or fGlobalFlag) and
         (SkinData.FMouseAbove or not (csLButtonDown in ControlState) or ((SkinData.SkinManager <> nil) and SkinData.SkinManager.Options.NoMouseHover)) or
           FDown or
             DroppedDown then
    Result := 2
  else
    if not (csDesigning in ComponentState) and ControlIsActive(FCommonData) then
      Result := 1
    else
      Result := integer(Default) * 3
end;


destructor TsButton.Destroy;
begin
{$IFNDEF D2009}
  FreeAndNil(FImageChangeLink);
  FreeAndNil(FImageMargins);
{$ENDIF}
  FreeAndNil(FCommonData);
  inherited Destroy;
end;


procedure TsButton.DrawCaption;
var
  R, hR: TRect;
  DrawStyle: Cardinal;
  State: integer;
begin
  if Canvas = nil then
    Canvas := FCommonData.FCacheBmp.Canvas;

  Canvas.Font.Assign(Font);
  Canvas.Brush.Style := bsClear;
  R := CaptionRect;
  { Calculate vertical layout }
  if Style = bsCommandLink then begin
    Canvas.Font.Style := Canvas.Font.Style + [fsBold];
    Canvas.Font.Size := Canvas.Font.Size + 2;
    DrawStyle := DT_EXPANDTABS or DT_WORDBREAK;
  end
  else begin
    DrawStyle := DT_EXPANDTABS or DT_CENTER or DT_VCENTER;
    if WordWrap then
      DrawStyle := DrawStyle or DT_WORDBREAK;
  end;
  if UseRightToLeftReading then
    DrawStyle := DrawStyle or DT_RTLREADING;

  acWriteTextEx(Canvas, PacChar(Caption), Enabled or SkinData.Skinned, R, Cardinal(DrawStyle), FCommonData, boolean(CurrentState));
  if Style = bsCommandLink then begin
    Canvas.Font.Style := Canvas.Font.Style - [fsBold];
    Canvas.Font.Size := Canvas.Font.Size - 2;
    if CommandLinkHint <> '' then begin
      hR := R;
      hR.Top := R.Bottom + ContentSpacing;
      hR.Bottom := Height - FContentMargin;
      acWriteTextEx(Canvas, PacChar(CommandLinkHint), Enabled or SkinData.Skinned, hR, Cardinal(DrawStyle), FCommonData, boolean(CurrentState));
    end;
  end;

  if Focused and
       ((SkinData.SkinManager = nil) or SkinData.SkinManager.ButtonsOptions.ShowFocusRect) and
         Enabled and
           (Caption <> '') and
             ShowFocus and
               FCommonData.Skinned and
                 (SkinData.SkinManager = nil) then begin
    InflateRect(R, FocusMargin + 1, FocusMargin);
    if R.Top < 3 then
      R.Top := 3;

    if R.Bottom > Height - 3 then
      R.Bottom := Height - 3;

    State := min(ac_MaxPropsIndex, SkinData.SkinManager.gd[SkinData.SkinIndex].States);
    FocusRect(Canvas, R, SkinData.SkinManager.gd[SkinData.SkinIndex].Props[State].FontColor.Color, clNone);
  end;
end;


procedure TsButton.DrawGlyph;
begin
  if Assigned(Images) and (ImageIndex >= 0) and (ImageIndex < GetImageCount(Images)) then
    DrawBtnGlyph(Self, FCommonData.FCacheBmp.Canvas);
end;


function TsButton.GetDown: boolean;
begin
  Result := FDown;
end;


function TsButton.GlyphExist: boolean;
begin
  Result := Assigned(Images) and (ImageIndex >= 0) and (ImageIndex < GetImageCount(Images));
end;


function TsButton.GlyphIndex: integer;
var
  State: integer;
begin
  if not Enabled then
    State := 4
  else
    if CurrentState = 2 then
      State := 2
    else
      State := iff(Focused, 3, CurrentState);

  case State of
    0: Result := ImageIndex;
    1: Result := iff((HotImageIndex >= 0)      and (HotImageIndex      < GetImageCount(Images)), HotImageIndex,      ImageIndex);
    2: Result := iff((PressedImageIndex >= 0)  and (PressedImageIndex  < GetImageCount(Images)), PressedImageIndex,  ImageIndex);
    3: Result := iff((SelectedImageIndex >= 0) and (SelectedImageIndex < GetImageCount(Images)), SelectedImageIndex, ImageIndex);
    4: Result := iff((DisabledImageIndex >= 0) and (DisabledImageIndex < GetImageCount(Images)), DisabledImageIndex, ImageIndex)
    else Result := -1;
  end;
end;


function TsButton.GlyphRect: TRect;
var
  aWidth: integer;
begin
  if GlyphExist then begin
    aWidth := Width;
    if Style = bsSplitButton then
      dec(aWidth, DropWidth);

    if Style = bsCommandLink then begin
      Result.Left := ImageMargins.Left + FContentMargin;
      Result.Right := Result.Left + Images.Width;
      Result.Top := FContentMargin;
      Result.Bottom := Result.Top + Images.Height;
    end
    else
      case ImageAlignment of
        iaLeft: begin
          Result.Left := ImageMargins.Left + FContentMargin;
          Result.Right := Result.Left + Images.Width;
          Result.Top := (Height - Images.Height) div 2;
          Result.Bottom := Result.Top + Images.Height;
        end;

        iaRight: begin
          Result.Right := aWidth - ImageMargins.Right - FContentMargin;
          Result.Left := Result.Right - Images.Width;
          Result.Top := (Height - Images.Height) div 2;
          Result.Bottom := Result.Top + Images.Height;
        end;

        iaTop: begin
          Result.Top := ImageMargins.Bottom + FContentMargin;
          Result.Bottom := Result.Top + Images.Height;
          Result.Left := (aWidth - Images.Width) div 2;
          Result.Right := Result.Left + Images.Width;
        end;

        iaBottom: begin
          Result.Bottom := Height - ImageMargins.Bottom - FContentMargin;
          Result.Top := Result.Bottom - Images.Height;
          Result.Left := (aWidth - Images.Width) div 2;
          Result.Right := Result.Left + Images.Width;
        end

        else begin
          Result.Top := (Height - Images.Height) div 2;
          Result.Bottom := Result.Top + Images.Height;
          Result.Left := (aWidth - Images.Width) div 2;
          Result.Right := Result.Left + Images.Width;
        end;
      end;
  end
  else
    Result := MkRect;

  if CurrentState = 2 then
    if not SkinData.Skinned or (SkinData.SkinManager <> nil) and SkinData.SkinManager.ButtonsOptions.ShiftContentOnClick then
      OffsetRect(Result, 1, 1);
end;


procedure TsButton.Loaded;
begin
  inherited;
  FCommonData.FCacheBmp.Canvas.Font.Assign(Font);
  FCommonData.Loaded;
end;


procedure TsButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
begin
  if (Style = bsSplitButton) and (DropDownMenu <> nil) and PtInRect(Rect(Width - DropWidth, 0, Width, Height), Point(X, Y)) then begin
    P := ClientToScreen(MkPoint);
    DroppedDown := True;
    FCommonData.Invalidate;
{$IFNDEF FPC}
    if (DefaultManager <> nil) and DefaultManager.Active then
      DefaultManager.SkinableMenus.HookPopupMenu(DropDownMenu, True);
{$ENDIF}
    DropDownMenu.PopupComponent := Self;
    DropDownMenu.Popup(P.X, P.Y + Height);
    DroppedDown := False;
    FCommonData.Invalidate;
  end
  else begin
    if FCommonData.Skinned and Enabled and not (csDesigning in ComponentState) then begin
      FCommonData.FUpdating := False;
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
end;


procedure TsButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not (csDestroying in ComponentState) then begin
    if FCommonData.Skinned and Enabled and not (csDesigning in ComponentState) {and FDown} then begin
      if (Button = mbLeft) and ShowHintStored then begin
        Application.ShowHint := AppShowHint;
        ShowHintStored := False;
      end;
      if not FMouseClicked or (csDestroying in ComponentState) then
        Exit;

      FMouseClicked := False;
      if (Button = mbLeft) and Enabled then begin
        if TimerIsActive(SkinData) then begin
          StopTimer(SkinData);
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
    end;
    inherited MouseUp(Button, Shift, X, Y);
  end;
end;


procedure TsButton.OurPaintHandler;
var
  aRect: TRect;
  b: boolean;
  DC, SavedDC: hdc;
  PS: TPaintStruct;

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

  if not InanimationProcess then
    BeginPaint(Handle, {$IFDEF FPC}@{$ENDIF}PS);

  try
    if not InUpdating(FCommonData) and not TimerIsActive(SkinData) then begin
      if (GetClipBox(DC, aRect) = 0) {or IsRectEmpty(R) is not redrawn while resizing }then begin
        ToFinish;
        Exit;
      end;

      FCommonData.BGChanged := FCommonData.BGChanged or FCommonData.HalfVisible;// or GetBoolMsg(Parent, AC_GETHALFVISIBLE);
//      FCommonData.HalfVisible := not RectInRect(Parent.ClientRect, BoundsRect);
      FCommonData.HalfVisible := (WidthOf(aRect, True) <> Width) or (HeightOf(aRect, True) <> Height);
      b := (FRegion = 1) or aSkinChanging;
      FRegion := 0;
      if RegionChanged and
           FCommonData.SkinManager.IsValidImgIndex(FCommonData.BorderIndex) and
             (SkinData.SkinManager.ma[SkinData.BorderIndex].CornerType = 2) and
               not (csDesigning in ComponentState) then begin

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
          if (DC <> SkinData.PrintDC) {$IFNDEF FPC} and not (csAlignmentNeeded in ControlState) {$ENDIF} then // Set region
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
        if FCommonData.BGChanged and not PrepareCache then begin
          ToFinish;
          Exit;
        end;

      SavedDC := SaveDC(DC);
      try
        BitBlt(DC, 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
      finally
        RestoreDC(DC, SavedDC);
      end;
    end;
  finally
    ToFinish;
  end;
end;


function TsButton.PrepareCache: boolean;
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
    FCommonData.FCacheBmp.Canvas.Font.Assign(Font);
    sm := FCommonData.SkinManager;
    if (CurrentState = 3 {Def/Focused}) and (sm.gd[FCommonData.SkinIndex].States < 4) then
      State := 1
    else
      State := min(CurrentState, sm.gd[FCommonData.SkinIndex].States - 1);

    PaintItemBG(FCommonData, CI, State, MkRect(Self), Point(Left, Top), FCommonData.FCacheBMP, 0, 0);
    if sm.IsValidImgIndex(FCommonData.BorderIndex) then
      if RegionChanged and (sm.ma[FCommonData.BorderIndex].CornerType = 2) and not InAnimationProcess and (SkinData.AnimTimer = nil) then begin
        if FRegion > 1 then
          DeleteObject(FRegion);

        FRegion := CreateRectRgn(0, 0, Width, Height);
        if (State <> 0) or (sm.ma[FCommonData.BorderIndex].DrawMode and BDM_ACTIVEONLY = 0) then
          PaintRgnBorder(FCommonData.FCacheBmp, FRegion, True, sm.ma[FCommonData.BorderIndex], State);
      end
      else  // Empty region
        if (State <> 0) or (sm.ma[FCommonData.BorderIndex].DrawMode and BDM_ACTIVEONLY = 0) then begin
          inc(CI.X, Left);
          inc(CI.Y, Top);
          DrawSkinRect(FCommonData.FCacheBmp, MkRect(FCommonData.FCacheBmp), CI, sm.ma[FCommonData.BorderIndex], State, True);
          dec(CI.X, Left);
          dec(CI.Y, Top);
        end;

    UpdateBmpColors(FCommonData.FCacheBmp, SkinData, True, State);
    DrawGlyph;
    DrawCaption;
    if Style = bsSplitButton then
      with FCommonData, FCacheBmp.Canvas do begin
        Pen.Color := ColorToRGB(SkinManager.gd[SkinIndex].Props[integer(State <> 0)].FontColor.Color);
        Pen.Width := 1;
        MoveTo(Width - DropWidth + 1, 4);
        LineTo(Width - DropWidth + 1, Height - 4);
        DrawColorArrow(FCacheBmp, Pen.Color, Rect(Width - DropWidth, 0, Width, Height), asBottom);
      end;

    if not Enabled or ((Action <> nil) and not Assigned(TAction(Action).OnExecute){ not TAction(Action).Enabled // Button not repainted immediately if Action.Enabled changed }) then
      BmpDisabledKind(FCommonData.FCacheBmp, FDisabledKind, Parent, CI, Point(Left, Top));

    FCommonData.BGChanged := False;
  end;
end;


procedure TsButton.SetDisabledKind(const Value: TsDisabledKind);
begin
  if FDisabledKind <> Value then begin
    FDisabledKind := Value;
    if not (csLoading in ComponentState) then
      FCommonData.Invalidate;
  end;
end;


{$IFNDEF DELPHI7UP}
procedure TsButton.SetWordWrap(const Value: boolean);
begin
  if FWordWrap <> Value then begin
    FWordWrap := Value;
    if not (csLoading in ComponentState) then
      FCommonData.Invalidate;
  end;
end;
{$ENDIF}


procedure TsButton.SetDown(const Value: boolean);
begin
  if FDown <> Value then begin
    FDown := Value;
    RegionChanged := True;
    if not (csLoading in ComponentState) then
      FCommonData.Invalidate;
  end;
end;


procedure TsButton.SetFocusMargin(const Value: integer);
begin
  if FFocusMargin <> Value then
    FFocusMargin := Value;
end;


procedure TsButton.SetShowFocus(const Value: boolean);
begin
  if FShowFocus <> Value then begin
    FShowFocus := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsButton.WMKeyUp(var Message: TWMKey);
begin
  inherited;
  if Assigned(FCommonData) and FCommonData.Skinned and (Message.CharCode = 32) then begin
    RegionChanged := True;
    FCommonData.BGChanged := True;
    Repaint;
  end;
end;


procedure TsButton.WndProc(var Message: TMessage);
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
      end; // AlphaSkins supported

      AC_SETNEWSKIN:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          RegionChanged := True;
          CommonMessage(Message, FCommonData);
          Exit;
        end;

      AC_REMOVESKIN:
        if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) and not (csDestroying in ComponentState) then begin
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

          Exit
        end;

      AC_PREPARECACHE: begin
        PrepareCache;
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
      end;
    end;
    if not ControlIsReady(Self) or not FCommonData.Skinned(True) then begin
      inherited;
      case Message.Msg of
        CM_MOUSEENTER, CM_MOUSELEAVE:
          if not (csDestroying in ComponentState) and not (csDesigning in ComponentState) and Enabled then begin
            SkinData.FMouseAbove := Message.Msg = CM_MOUSEENTER;
            if SkinData.FMouseAbove then begin
              if Assigned(FOnMouseEnter) then
                FOnMouseEnter(Self);
            end
            else
              if Assigned(FOnMouseLeave) then
                FOnMouseLeave(Self);

            RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_NOERASE or RDW_UPDATENOW);
          end;

        CM_ENABLEDCHANGED:
          if (Visible or (csDesigning in ComponentState)) and not (csDestroying in ComponentState) then
            Repaint;
      end;
    end
  else begin
    case Message.Msg of
      SM_ALPHACMD:
        case Message.WParamHi of
          AC_ENDPARENTUPDATE:
            if FCommonData.FUpdating then begin
              if not InUpdating(FCommonData, True) then
                Repaint;

              Exit
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

            FCommonData.BGChanged := False;
            FCommonData.FMouseAbove := True;
            DoChangePaint(FCommonData, 1, UpdateWindow_CB, EventEnabled(aeMouseEnter, FAnimatEvents), False);
          end;

      CM_MOUSELEAVE:
        if Enabled and not (csDesigning in ComponentState) then begin
          if Assigned(FOnMouseLeave) then
            FOnMouseLeave(Self);

          FCommonData.BGChanged := False;
          FCommonData.FMouseAbove := False;
          DoChangePaint(FCommonData, 0, UpdateWindow_CB, EventEnabled(aeMouseLeave, FAnimatEvents), False, False);
        end;

      WM_SIZE: begin
        RegionChanged := True;
        HideGlow(SkinData.GlowID);
      end;

      WM_UPDATEUISTATE:
        if Visible or (csDesigning in ComponentState) then begin
          Message.Result := 1;
          Exit;
        end;

      WM_ERASEBKGND:
        if Visible or (csDesigning in ComponentState) then begin
          if (TWMPaint(Message).DC <> 0) and (Skindata.FCacheBmp <> nil) and not InUpdating(SkinData) then begin
            if FCommonData.BGChanged then
              PrepareCache;

            if not FCommonData.BGChanged and not TimerIsActive(SkinData) then
              CopyWinControlCache(Self, FCommonData, MkRect, MkRect(Self), TWMPaint(Message).DC, False);
          end;
          Message.Result := 0;
          Exit;
        end;

      CM_TEXTCHANGED:
        if not (csDestroying in ComponentState) then begin
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
          if (Parent = nil) or InUpdating(FCommonData) then
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
        with FCommonData.SkinManager.gd[FCommonData.SkinIndex] do
          if (Props[0].Transparency > 0) or ((States > 0) and (Props[1].Transparency > 0) and ControlIsActive(FCommonData)) then begin
            FCommonData.BGChanged := True;
            Repaint
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
              SkinData.AnimTimer.TimeHandler // Fast repaint
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
              RegionChanged := True;
              FCommonData.Invalidate;
              HideGlow(SkinData.GlowID);
            end;
          end
          else
            inherited;

          Exit
        end;

      CM_FOCUSCHANGED:
        if Visible then
          if not bFocusChanging then begin // Avoiding of blinking
            Perform(WM_SETREDRAW, 0, 0);
            inherited;
            Perform(WM_SETREDRAW, 1, 0);
          end
          else
            inherited;

      WM_ENABLE: 
        Exit; // Avoiding of blinking when switched
    end;
    if CommonWndProc(Message, FCommonData) then
      Exit;

    inherited;
    if not (csDestroying in ComponentState) then
      case Message.Msg of
        CM_CANCELMODE:
          HideGlow(SkinData.GlowID);

        CM_ENABLEDCHANGED:
          if (Visible or (csDesigning in ComponentState)) and not (csDestroying in ComponentState) then begin
            FCommonData.FUpdating := False;
            StopTimer(SkinData);
            FCommonData.BGChanged := True;
            RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW);
          end;

        CM_VISIBLECHANGED:
          if not (csDestroying in ComponentState) then begin
            FCommonData.BGChanged := True;
            FCommonData.FUpdating := False;
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


procedure TsButton.SetReflected(const Value: boolean);
begin
  if FReflected <> Value then begin
    FReflected := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsButton.CNDrawItem(var Message: TWMDrawItem);
begin
  if not SkinData.Skinned then
    StdDrawItem(TDrawItemStruct(Message.DrawItemStruct^))
  else
    inherited;
end;


procedure TsButton.StdDrawItem(const DrawItemStruct: TDrawItemStruct);
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
  Canvas := TCanvas.Create;
  R := ClientRect;
  with DrawItemStruct do begin
    Canvas.Handle := {$IFDEF FPC}_hDC{$ELSE}hDC{$ENDIF};
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
        if SkinData.FMouseAbove then
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
      if Style = bsSplitButton then
        R.Right := R.Right - DropWidth + 2;

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
    { DrawFrameControl doesn't allow for drawing a button as the default button, so it must be done here. }
    if IsFocused or IsDefault then begin
      Canvas.Pen.Color := clWindowFrame;
      Canvas.Pen.Width := 1;
      Canvas.Brush.Style := bsClear;
      Canvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
      { DrawFrameControl must draw within this border }
      InflateRect(R, -1, -1);
    end;
    { DrawFrameControl does not draw a pressed button correctly }
    if IsDown then begin
      Canvas.Pen.Color := clBtnShadow;
      Canvas.Pen.Width := 1;
      Canvas.Brush.Color := clBtnFace;
      Canvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
      InflateRect(R, -1, -1);
    end
    else
      DrawFrameControl(DrawItemStruct.{$IFDEF FPC}_hDC{$ELSE}hDC{$ENDIF}, R, DFC_BUTTON, Flags);

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
      if Style = bsSplitButton then
        R.Right := R.Right - DropWidth + 2;

      DrawFocusRect(Canvas.Handle, R);
    end;
  end;
  DrawCaption(Canvas);
  DrawBtnGlyph(Self, Canvas);
  if Style = bsSplitButton then begin
    Canvas.Pen.Color := clWindowFrame;
    Canvas.Pen.Width := 1;
    Canvas.MoveTo(Width - DropWidth + 1, 4);
    Canvas.LineTo(Width - DropWidth + 1, Height - 4);
    DrawColorArrow(Canvas, Font.Color, Rect(Width - DropWidth, 0, Width, Height), asBottom);
  end;
  Canvas.Handle := 0;
  Canvas.Free;
end;


{$IFDEF D2009}
procedure TsButton.UpdateImageList;
begin
  FCommonData.Invalidate
// Ignore inherited;
end;


procedure TsButton.UpdateImages;
begin
// Ignore inherited;
end;
{$ENDIF}


procedure TsButton.SetStyle(const Value: TButtonStyle);
begin
  if FStyle <> Value then begin
    FStyle := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsButton.SetContentMargin(const Value: integer);
begin
  if FContentMargin <> Value then begin
    FContentMargin := Value;
    FCommonData.Invalidate;
  end;
end;


{$IFNDEF D2009}
function TsButton.IsImageIndexStored: Boolean;
begin
  Result := (ActionLink = nil) or not TPushButtonActionLink(ActionLink).IsImageIndexLinked;
end;


procedure TsButton.SetDisabledImageIndex(const Value: TImageIndex);
begin
  if Value <> FDisabledImageIndex then begin
    FDisabledImageIndex := Value;
    if Images <> nil then
      FCommonData.Invalidate;
  end;
end;


procedure TsButton.SetHotImageIndex(const Value: TImageIndex);
begin
  if Value <> FHotImageIndex then begin
    FHotImageIndex := Value;
    if Images <> nil then
      FCommonData.Invalidate;
  end;
end;


procedure TsButton.SetImageAlignment(const Value: TImageAlignment);
begin
  if Value <> FImageAlignment then begin
    FImageAlignment := Value;
    if Images <> nil then
      FCommonData.Invalidate;
  end;
end;


procedure TsButton.SetImageIndex(const Value: TImageIndex);
begin
  if Value <> FImageIndex then begin
    FImageIndex := Value;
    if Images <> nil then
      FCommonData.Invalidate;
  end;
end;


procedure TsButton.SetImageMargins(const Value: TImageMargins);
begin
  FImageMargins.Assign(Value);
end;


procedure TsButton.SetImages(const Value: TCustomImageList);
begin
  if Value <> FImages then begin
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


procedure TsButton.SetPressedImageIndex(const Value: TImageIndex);
begin
  if Value <> FPressedImageIndex then begin
    FPressedImageIndex := Value;
    if Images <> nil then
      FCommonData.Invalidate;
  end;
end;


procedure TsButton.SetSelectedImageIndex(const Value: TImageIndex);
begin
  if Value <> FSelectedImageIndex then begin
    FSelectedImageIndex := Value;
    if Images <> nil then
      FCommonData.Invalidate;
  end;
end;


procedure TsButton.ImageMarginsChange(Sender: TObject);
begin
  if Images <> nil then
    FCommonData.Invalidate;
end;


procedure TsButton.ImageListChange(Sender: TObject);
begin
  if Images <> nil then
    FCommonData.Invalidate;
end;


procedure TsButton.SetCommandLinkHint(const Value: acString);
begin
  if FCommandLinkHint <> Value then begin
    FCommandLinkHint := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsButton.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
    if AComponent = Images then
      Images := nil
{$IFNDEF D2009}
    else
      if AComponent = DropDownMenu then
        DropDownMenu := nil;
{$ENDIF}
end;


procedure TImageMargins.Assign(Source: TPersistent);
begin
  if Source is TImageMargins then begin
    FLeft   := TImageMargins(Source).Left;
    FTop    := TImageMargins(Source).Top;
    FRight  := TImageMargins(Source).Right;
    FBottom := TImageMargins(Source).Bottom;
    Change;
  end
  else
    inherited Assign(Source);
end;


procedure TImageMargins.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;


procedure TImageMargins.SetMargin(Index, Value: Integer);
begin
  case Index of
    0: if Value <> FLeft then begin
      FLeft := Value;
      Change;
    end;

    1: if Value <> FTop then begin
      FTop := Value;
      Change;
    end;

    2: if Value <> FRight then begin
      FRight := Value;
      Change;
    end;

    3: if Value <> FBottom then begin
      FBottom := Value;
      Change;
    end;
  end;
end;


function TPushButtonActionLink.IsImageIndexLinked: Boolean;
begin
  Result := inherited IsImageIndexLinked and (TsButton(FClient).ImageIndex = (Action as TCustomAction).ImageIndex);
end;


procedure TPushButtonActionLink.SetImageIndex(Value: Integer);
begin
  if IsImageIndexLinked then
    TsButton(FClient).ImageIndex := Value;
end;


{$ELSE}


procedure TsButton.SetImageIndex(const Value: TImageIndex);
begin
  inherited ImageIndex := Value;
  FCommonData.Invalidate(True);
end;


function TsButton.GetImageIndex: TImageIndex;
begin
  Result := inherited ImageIndex;
end;


type
  TAccessActionLink = class(TPushButtonActionLink);

function TsButton.IsImageIndexStored: Boolean;
begin
  Result := (ActionLink = nil) or not TAccessActionLink(ActionLink).IsImageIndexLinked;
end;

{$ENDIF}

end.

