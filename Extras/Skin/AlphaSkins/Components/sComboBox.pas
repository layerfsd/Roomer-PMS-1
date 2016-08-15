unit sComboBox;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls,
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  {$IFDEF TNTUNICODE} TntControls, TntClasses, TntActnList, TntStdCtrls, TntGraphics, {$ENDIF}
  sConst, sDefaults, acSBUtils, sCommonData;


type
{$IFNDEF NOTFORHELP}
{$IFDEF TNTUNICODE}
  TsCustomComboBox = class(TTntCustomComboBox)
{$ELSE}
  TsCustomComboBox = class(TCustomComboBox)
{$ENDIF}
  private
    FReadOnly,
    FShowButton,
    FAllowMouseWheel: boolean;

    FAlignment: TAlignment;
    FCommonData: TsCtrlSkinData;
    FBoundLabel: TsBoundLabel;
    FDisabledKind: TsDisabledKind;
    FVerticalAlignment: TVerticalAlignment;
    procedure SetReadOnly          (const Value: boolean);
    procedure SetShowButton        (const Value: boolean);
    procedure SetAlignment         (const Value: TAlignment);
    procedure SetDisabledKind      (const Value: TsDisabledKind);
    procedure SetVerticalAlignment (const Value: TVerticalAlignment);
  protected
    State,
    FGlyphIndex: integer;

    lboxhandle: hwnd;
    ListSW: TacScrollWnd;
    FDropDown: boolean;
    procedure PrepareCache;
    function AllowBtnStyle: boolean;
    procedure ChangeScale(M, D: Integer); override;
    procedure OurPaintHandler(iDC: hdc);
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure AnimateCtrl(AState: integer);
{$IFNDEF DELPHI5}
    function GetItemHt: Integer; override;
    procedure SetDropDownCount(const Value: Integer); override;
{$ENDIF}
    procedure WndProc         (var Message: TMessage); override;
    function  HandleAlphaMsg  (var Message: TMessage): boolean;
    procedure ComboWndProc    (var Message: TMessage; ComboWnd: HWnd; ComboProc: Pointer); override;
    procedure CNMeasureItem   (var Message: TWMMeasureItem); message CN_MEASUREITEM;
    procedure CNDrawItem      (var Message: TWMDrawItem);    message CN_DRAWITEM;
    procedure WMLButtonDblClk (var Message: TMessage);       message WM_LBUTTONDBLCLK;
    procedure WMLButtonDown   (var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
  public
    AllowDropDown: boolean;
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    function IndexOf(const s: acString): integer;
    procedure Invalidate; override;
    function ButtonRect: TRect;
    procedure UpdateIndexes;
    procedure PaintButton;
    procedure DoDropDown;
    function ButtonHeight: integer;
    procedure CreateWnd; override;
    function Focused: Boolean; override;
    property ShowButton: boolean read FShowButton write SetShowButton default True;
  published
{$IFDEF D2007}
    property AutoCloseUp;
    property AutoDropDown;
{$ENDIF}
    property Align;
    property Anchors;
    property Alignment: TAlignment read FAlignment write SetAlignment;
    property AllowMouseWheel: boolean read FAllowMouseWheel write FAllowMouseWheel default True;
{$IFDEF D2005}
    property AutoCompleteDelay;
{$ENDIF}
    property BoundLabel: TsBoundLabel read FBoundLabel write FBoundLabel;
    property DisabledKind: TsDisabledKind read FDisabledKind write SetDisabledKind default DefDisabledKind;
    property DropDownCount default 16;
    property SkinData: TsCtrlSkinData read FCommonData write FCommonData;
    property VerticalAlignment: TVerticalAlignment read FVerticalAlignment write SetVerticalAlignment;
{$IFDEF D2010}
    property TextHint;
    property Touch;
{$ENDIF}
    property ReadOnly: boolean read FReadOnly write SetReadOnly default False;
{$ENDIF} // NOTFORHELP
  end;


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsComboBox = class(TsCustomComboBox)
{$IFNDEF NOTFORHELP}
    property Style; {Must be published before Items}
{$IFDEF DELPHI7UP}
    property AutoComplete;
{$ENDIF}
    property BiDiMode;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DropDownCount;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ItemHeight;
    property ItemIndex;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
{$IFDEF TNTUNICODE}
    property SelText;
    property SelStart;
    property SelLength;
{$ENDIF}
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
{$IFDEF DELPHI6UP}
    property AutoDropDown;
    property OnCloseUp;
    property OnSelect;
{$ENDIF}
{$IFDEF D2006}
    property OnMouseEnter;
    property OnMouseLeave;
{$ENDIF}
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnStartDock;
    property OnStartDrag;
    property Items; { Must be published after OnMeasureItem }
{$ENDIF} // NOTFORHELP
    property BoundLabel;
    property DisabledKind;
    property SkinData;
    property ReadOnly;
  end;


implementation

uses
  math,
  {$IFDEF DELPHI7UP}Themes, {$ENDIF}
  sStyleSimply, sSkinProps, sVCLUtils, sMessages, sAlphaGraph, acntUtils, sGraphUtils, sSkinManager, acGlow, sMaskData, sFade;


function IsOwnerDraw(Ctrl: TsCustomComboBox): boolean;
begin
  Result := (Ctrl.Style in [csOwnerDrawFixed, csOwnerDrawVariable]) and Assigned(Ctrl.OnDrawItem)
end;


function TsCustomComboBox.AllowBtnStyle: boolean;
begin
  Result := (Style in [csDropDownList, csOwnerDrawFixed, csOwnerDrawVariable]) and (SkinData.SkinSection = '');
end;


function UpdateCombo_CB(Data: TObject; iIteration: integer): boolean;
var
  DC: HDC;
  R: TRect;
  Alpha: byte;
  cb: TsComboBox;
  Handle: THandle;
  sd: TsCommonData;
begin
  Result := False;
  if Data is TsCommonData then begin
    sd := TsCommonData(Data);
    if sd.FOwnerControl is TsCustomComboBox then begin
      cb := TsComboBox(sd.FOwnerControl);
      Handle := cb.Handle;
      with sd.AnimTimer do
        if (Iterations > 0) and (Handle <> 0) then begin
          if BmpOut = nil then
            BmpOut := CreateBmp32(cb)
          else begin
            BmpOut.Width  := sd.FCacheBmp.Width;
            BmpOut.Height := sd.FCacheBmp.Height;
          end;
          BitBlt(BmpOut.Canvas.Handle, 0, 0, BmpOut.Width, BmpOut.Height, BmpFrom.Canvas.Handle, 0, 0, SRCCOPY);
          sd.AnimTimer.Value := Value + ValueStep;
          if State in [0, 2] then
            Glow := Glow - GlowStep
          else
            sd.AnimTimer.Glow := Glow + GlowStep;

          Alpha := LimitIt(Round(Value), 0, MaxByte);
          SumBmpRect(BmpOut, BmpTo, MaxByte - Alpha, MkRect(BmpOut), MkPoint);
          DC := GetDC(Handle);
          try
            if cb.AllowBtnStyle then
              BitBlt(DC, 0, 0, BmpOut.Width, BmpOut.Height, BmpOut.Canvas.Handle, 0, 0, SRCCOPY)
            else begin
              BitBltBorder(DC, 0, 0, BmpOut.Width, BmpOut.Height, BmpOut.Canvas.Handle, 0, 0, 2);
              R := cb.ButtonRect;
              BitBlt(DC, R.Left, R.Top, WidthOf(R), HeightOf(R), BmpOut.Canvas.Handle, R.Left, R.Top, SRCCOPY);
            end;
          finally
            ReleaseDC(Handle, DC);
          end;

          Alpha := LimitIt(Round(Glow), 0, MaxByte);
          if sd.AnimTimer.Iteration >= sd.AnimTimer.Iterations then begin
            if (State = 0) and (Alpha > 0) then begin
              if sd.GlowID >= 0 then
                SetGlowAlpha(sd.GlowID, Alpha);

              Iteration := Iteration - 1;
              UpdateCombo_CB(Data, Iteration);
            end
            else
              if (State = 2) and (Value < MaxByte) then begin
                Iteration := Iteration - 1;
                UpdateCombo_CB(Data, iIteration);
              end
              else begin
                if State = 0 then
                  StopTimer(sd);

                if not (State in [1, 3]) then
                  HideGlow(sd.GlowID);
              end;
          end
          else begin
            Result := True;
            if sd.GlowID >= 0 then
              SetGlowAlpha(sd.GlowID, Alpha);
          end;
        end;
    end;
  end;
end;


procedure TsCustomComboBox.AnimateCtrl(AState: integer);
var
  R: TRect;
begin
  FCommonData.BGChanged := False;
  FCommonData.FMouseAbove := AState <> 0;
  if (AState in [1, 3]) and AllowBtnStyle then
    ShowGlowingIfNeeded(SkinData, AState > 1, Handle, MaxByte * integer(not SkinData.SkinManager.Effects.AllowAnimation), False, SkinData.SkinManager.ConstData.Sections[ssButton]);

  if (AState = 1) and not AllowBtnStyle then begin // Refresh of background sometimes required
    R := Rect(2, 2, ButtonRect.Left - 2, Height - 2);
    RedrawWindow(Handle, @R, 0, RDW_INVALIDATE or RDW_ERASE or RDW_UPDATENOW or RDW_NOFRAME);
  end;
  DoChangePaint(SkinData, AState, UpdateCombo_CB, SkinData.SkinManager.Effects.AllowAnimation, AState in [2, 4], not AllowBtnStyle and (SkinData.GlowID < 0));
end;


function TsCustomComboBox.ButtonHeight: integer;
begin
  with SkinData.SkinManager.ConstData.ComboBtn do
    if FCommonData.Skinned and (FGlyphIndex >= 0) then
      Result := FCommonData.SkinManager.ma[FGlyphIndex].Height
    else
      Result := 16;
end;


function TsCustomComboBox.ButtonRect: TRect;
var
  w: integer;
begin
  if (Style <> csSimple) and FShowButton then
    w := GetComboBtnSize(SkinData.SkinManager) {+ SkinData.SkinManager.CommonSkinData.ComboBoxMargin} - 1
  else
    w := 0;

  Result.Top := SkinData.SkinManager.CommonSkinData.ComboBoxMargin;
  if UseRightToLeftAlignment then
    Result.Left := Result.Top
  else
    Result.Left := Width - w - Result.Top;

  Result.Right := Result.Left + w;
  Result.Bottom := Height - Result.Top;
end;


procedure TsCustomComboBox.ComboWndProc(var Message: TMessage; ComboWnd: HWnd; ComboProc: Pointer);
var
  ps: TPaintStruct;
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  if ReadOnly or not AllowDropDown then
    case Message.Msg of
      WM_KEYDOWN, WM_CHAR, WM_KEYUP, WM_SYSKEYUP, CN_KEYDOWN, CN_CHAR, CN_SYSKEYDOWN, CN_SYSCHAR, WM_PASTE, WM_CUT, WM_CLEAR, WM_UNDO:
        Exit;
    end;

  if not (csDestroying in ComponentState) and FCommonData.Skinned then
    case Message.Msg of
      WM_MOUSEMOVE:
        if not (csDesigning in ComponentState) and (SkinData.SkinManager.ActiveControl <> Handle) then
          SkinData.SkinManager.ActiveControl := Handle;

      WM_ERASEBKGND, WM_NCPAINT:
        if (Style <> csSimple) and (not (Focused or FCommonData.FFocused) or not Enabled or ReadOnly or not AllowDropDown) then begin
          Message.Result := 1;
          Exit;
        end;

      WM_PAINT:
        if (Style <> csSimple) and (not (Focused or FCommonData.FFocused) or not Enabled or ReadOnly or not AllowDropDown) then begin
          BeginPaint(ComboWnd, PS);
          EndPaint(ComboWnd, PS);
          Exit;
        end;
    end;

  inherited;
end;


constructor TsCustomComboBox.Create(AOwner: TComponent);
begin
  FCommonData := TsCtrlSkinData.Create(Self, True);
  FCommonData.COC := COC_TsComboBox;
  inherited Create(AOwner);
  AllowDropDown := True;
  DropDownCount := 16;
  FDisabledKind := DefDisabledKind;
  FAllowMouseWheel := True;
//  actM := 1;
//  actD := 1;
  FBoundLabel := TsBoundLabel.Create(Self, FCommonData);
  FDropDown := False;
  FReadOnly := False;
  FShowButton := True;
end;


destructor TsCustomComboBox.Destroy;
begin
  if lBoxHandle <> 0 then begin
    SetWindowLong(lBoxHandle, GWL_STYLE, GetWindowLong(lBoxHandle, GWL_STYLE) and not WS_THICKFRAME or WS_BORDER);
    UninitializeACScroll(lBoxHandle, True, False, ListSW);
    lBoxHandle := 0;
  end;
  FreeAndNil(FBoundLabel);
  FreeAndNil(FCommonData);
  inherited Destroy;
end;


procedure TsCustomComboBox.DoDropDown;
begin
  if CanFocus then
    SetFocus;

  if Assigned(OnDropDown) then begin
    FDropDown := True;
    State := 2;
    AnimateCtrl(2);
    OnDropDown(Self);
  end;
end;


function TsCustomComboBox.Focused: Boolean;
var
  FocusedWnd: HWND;
begin
  Result := False;
  if HandleAllocated then begin
    FocusedWnd := GetFocus;
    Result := (FocusedWnd <> 0) and ((FocusedWnd = EditHandle) or (FocusedWnd = ListHandle)) or FCommonData.FFocused;
  end;
end;


function TsCustomComboBox.IndexOf(const s: acString): integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to Items.Count - 1 do
    if Items[i] = s then begin
      Result := i;
      Exit;
    end;
end;


procedure TsCustomComboBox.Invalidate;
begin
  if Focused then
    FCommonData.FFocused := True;

  inherited Invalidate;
end;


procedure TsCustomComboBox.OurPaintHandler(iDC: hdc);
const
  BordWidth = 3;
var
  DC: hdc;
  R: TRect;
begin
  if Showing and HandleAllocated then begin
    if iDC = 0 then
      DC := GetDC(Handle)
    else
      DC := iDC;

    R := ButtonRect;
    try
      if not InUpdating(FCommonData) and not (InAnimationProcess and (DC <> SkinData.PrintDC) and (SkinData.PrintDC <> 0)) and ((FCommonData.AnimTimer = nil) or not FCommonData.AnimTimer.Enabled) then begin
        FCommonData.BGChanged := FCommonData.BGChanged or FCommonData.HalfVisible or GetBoolMsg(Parent, AC_GETHALFVISIBLE) or IsOwnerDraw(Self);
        FCommonData.HalfVisible := not RectInRect(Parent.ClientRect, BoundsRect);
        if FCommonData.BGChanged then
          PrepareCache;

        UpdateCorners(FCommonData, 0);
        case Style of
          csSimple:
            BitBltBorder(DC, 0, 0, Width, FCommonData.FCacheBmp.Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, BordWidth);

          csDropDown:
            if Focused then begin
              BitBltBorder(DC, 0, 0, Width, FCommonData.FCacheBmp.Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, BordWidth);
              R := ButtonRect;
              dec(R.Left, 2);
              BitBlt(DC, R.Left, R.Top, WidthOf(R), HeightOf(R), FCommonData.FCacheBmp.Canvas.Handle, R.Left, R.Top, SRCCOPY);
            end
            else
              BitBlt(DC, 0, 0, Width, FCommonData.FCacheBmp.Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);

          csDropDownList, csOwnerDrawFixed, csOwnerDrawVariable:
            BitBlt(DC, 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
        end;
{$IFDEF DYNAMICCACHE}
        if Assigned(FCommonData.FCacheBmp) then
          FreeAndNil(FCommonData.FCacheBmp);
{$ENDIF}
      end;
    finally
      if iDC = 0 then
        ReleaseDC(Handle, DC);
    end;
  end;
end;


procedure TsCustomComboBox.PaintButton;
var
  R: TRect;
  C: TColor;
  Mode: integer;
  TmpBtn: TBitmap;
begin
  if FDropDown then
    Mode := 2
  else
    Mode := integer((State = 1) or (AllowBtnStyle and (FCommonData.FMouseAbove or FCommonData.FFocused)));

  R := ButtonRect;
  with SkinData.SkinManager do
    if not AllowBtnStyle then
      with ConstData.ComboBtn do begin
        if SkinIndex >= 0 then begin
          TmpBtn := CreateBmpLike(FCommonData.FCacheBmp);
          BitBlt(TmpBtn.Canvas.Handle, 0, 0, TmpBtn.Width, TmpBtn.Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
          PaintItem(SkinIndex, MakeCacheInfo(FCommonData.FCacheBmp), True, Mode, R, MkPoint, FCommonData.FCacheBmp, FCommonData.SkinManager, BGIndex[0], BGIndex[1]);
          FreeAndNil(TmpBtn);
        end;
        if not gd[FCommonData.SkinIndex].GiveOwnFont and IsValidImgIndex(FGlyphIndex) then
          DrawSkinGlyph(FCommonData.FCacheBmp, Point(R.Left + (WidthOf(R) - ma[FGlyphIndex].Width) div 2,
                        (Height - ButtonHeight) div 2), Mode, 1, ma[FGlyphIndex], MakeCacheInfo(SkinData.FCacheBmp))
        else begin // Paint without glyph
          if SkinIndex >= 0 then // If COMBOBTN used
            C := gd[SkinIndex].Props[min(Mode, ac_MaxPropsIndex)].FontColor.Color
          else
            if SkinData.SkinIndex >= 0 then
              C := gd[SkinData.SkinIndex].Props[min(Mode, ac_MaxPropsIndex)].FontColor.Color
            else
              C := ColorToRGB(clWindowText);

          DrawColorArrow(FCommonData.FCacheBmp, C, R, asBottom);
        end;
      end
    else begin
      if not gd[FCommonData.SkinIndex].GiveOwnFont and IsValidImgIndex(FGlyphIndex) then
        DrawSkinGlyph(FCommonData.FCacheBmp, Point(R.Left + (WidthOf(R) - ma[FGlyphIndex].Width) div 2,
                      (Height - ButtonHeight) div 2), Mode, 1, ma[FGlyphIndex], MakeCacheInfo(SkinData.FCacheBmp))
      else begin // Paint without glyph
        if SkinData.SkinIndex >= 0 then
          C := gd[SkinData.SkinIndex].Props[min(Mode, ac_MaxPropsIndex)].FontColor.Color
        else
          C := ColorToRGB(clWindowText);

        DrawColorArrow(FCommonData.FCacheBmp, C, R, asBottom);
      end;
    end;
end;


procedure TsCustomComboBox.PrepareCache;
const
  BordWidth = 3;
var
  State: integer;
  R, bRect: TRect;
  odState: TOwnerDrawState;
begin
  InitCacheBmp(SkinData);
  if FDropDown and AllowBtnStyle then
    State := 2
  else
    State := integer(ControlIsActive(FCommonData) or AllowBtnStyle and FCommonData.FMouseAbove);
    
  if Style = csSimple then
    FCommonData.FCacheBmp.Height := ItemHeight + 8;

  PaintItem(FCommonData, GetParentCache(FCommonData), True, State, MkRect(Width, FCommonData.FCacheBmp.Height), MkPoint(Self), FCommonData.FCacheBmp, True);
  case Style of
    csDropDown, csDropDownList, csOwnerDrawFixed, csOwnerDrawVariable: begin
      bRect := ButtonRect;
      if UseRightToLeftAlignment then
        R := Rect(bRect.Right + 2, BordWidth, Width - BordWidth, FCommonData.FCacheBmp.Height - BordWidth)
      else
        R := Rect(BordWidth, BordWidth, bRect.Left - 2, FCommonData.FCacheBmp.Height - BordWidth);

      odState := [odComboBoxEdit];
      if (Focused or SkinData.FFocused) and not (Style in [csDropDown, csSimple]) then
        odState := odState + [odFocused, odSelected];

      Canvas.Handle := FCommonData.FCacheBmp.Canvas.Handle;
      FCommonData.FCacheBmp.Canvas.Lock;
      DrawItem(ItemIndex, R, odState);
      FCommonData.FCacheBmp.Canvas.Unlock;
      Canvas.Handle := 0;
      if FShowButton then
        PaintButton;
    end;
  end;
  if not Enabled {and not IsOwnerDraw(Self)} then
    BmpDisabledKind(FCommonData.FCacheBmp, FDisabledKind, Parent, GetParentCache(FCommonData), Point(Left, Top));

  FCommonData.BGChanged := False;
end;


procedure TsCustomComboBox.SetAlignment(const Value: TAlignment);
begin
  if FAlignment <> Value then begin
    FAlignment := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsCustomComboBox.SetDisabledKind(const Value: TsDisabledKind);
begin
  if FDisabledKind <> Value then begin
    FDisabledKind := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsCustomComboBox.SetReadOnly(const Value: boolean);
begin
  if FReadOnly <> Value then
    FReadOnly := Value;
end;


procedure TsCustomComboBox.WMLButtonDblClk(var Message: TMessage);
begin
  if FReadOnly then begin
    SetFocus;
    if Assigned(OnDblClick) then
      OnDblClick(Self);
  end
  else
    if not AllowDropDown then
      DoDropDown
    else
      inherited;
end;


procedure TsCustomComboBox.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if FReadOnly then
    SetFocus
  else
    if not AllowDropDown then
      DoDropDown
    else
      inherited
end;


procedure TsCustomComboBox.SetShowButton(const Value: boolean);
begin
  if FShowButton <> Value then begin
    FShowButton := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsCustomComboBox.WndProc(var Message: TMessage);
var
  DC: hdc;
  P: TPoint;
  i: integer;
  R, bR: TRect;
  PS: TPaintStruct;
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    SM_ALPHACMD:
      if HandleAlphaMsg(Message) then
        Exit;

    WM_SYSCHAR, WM_SYSKEYDOWN, CN_SYSCHAR, CN_SYSKEYDOWN, WM_KEYDOWN, CN_KEYDOWN:
      case TWMKey(Message).CharCode of
        VK_F4, VK_SPACE..VK_DOWN, $39..$39, $41..$5A:
          if ReadOnly or not AllowDropDown then
            Exit;
      end;

    WM_MOUSEWHEEL: if not FAllowMouseWheel then
      Exit;

    WM_CHAR:
      if ReadOnly or not AllowDropDown then
        Exit;

    WM_COMMAND, CN_COMMAND:
      if (TWMCommand(Message).NotifyCode = CBN_DROPDOWN) and (ReadOnly or not AllowDropDown) then
        Exit;
  end;

  if not ControlIsReady(Self) or not FCommonData.Skinned then begin
    inherited;
    if not (csLoading in ComponentState) then
      case Message.Msg of
        CM_FONTCHANGED:
          if HandleAllocated and (SkinData.CtrlSkinState and ACS_CHANGING = 0) then begin
            if IsWindowVisible(Handle) then
              ItemHeight := ItemHeight; // Update control size

            Invalidate;
          end;
      end;
  end
  else begin
    case Message.Msg of
//      CM_RECREATEWND: if EmptyScaling then
//        Exit;
//
      CM_COLORCHANGED, CM_MOUSEWHEEL:
        FCommonData.BGChanged := True;

      CN_COMMAND:
        case TWMCommand(Message).NotifyCode of
          CBN_CLOSEUP: begin
            FDropDown := False;
            FCommonData.BGChanged := True;
            if SkinData.AnimTimer <> nil then
              SkinData.AnimTimer.Glow := 0;

            OurPaintHandler(0);
            if not acMouseInControl(Self) then begin
              SkinData.FMouseAbove := False;
              State := 0;
            end;
            if FCommonData.AnimTimer <> nil then
              FCommonData.AnimTimer.CopyFrom(FCommonData.AnimTimer.BmpOut, FCommonData.FCacheBmp, MkRect(FCommonData.FCacheBmp));

            if AllowBtnStyle then
              AnimateCtrl(integer(SkinData.FMouseAbove));
          end;

          CBN_DROPDOWN: begin
            FDropDown := True;
            State := 2;
            AnimateCtrl(2);
            inherited;
            Exit;
          end;
        end;

      WM_SETFOCUS, CM_ENTER: if CanFocus then begin
        if SkinData.CtrlSkinState and ACS_FOCUSCHANGING = 0 then begin
          FCommonData.CtrlSkinState := FCommonData.CtrlSkinState or ACS_FOCUSCHANGING;
          FinishTimer(SkinData.AnimTimer);
          FCommonData.FFocused := True;
          FCommonData.BGChanged := True;
          UpdateControlColors(SkinData);
          inherited;
          FCommonData.CtrlSkinState := FCommonData.CtrlSkinState and not ACS_FOCUSCHANGING;
          SendMessage(Handle, WM_NCPAINT, 0, 0);
          Repaint;
        end
        else
          inherited;

        Exit;
      end;

      WM_KILLFOCUS, CM_EXIT: begin
        if SkinData.CtrlSkinState and ACS_FOCUSCHANGING = 0 then begin
          FCommonData.CtrlSkinState := FCommonData.CtrlSkinState or ACS_FOCUSCHANGING;
          StopTimer(SkinData);
          if not SkinData.FMouseAbove then
            HideGlow(SkinData.GlowID);

          FCommonData.FFocused := False;
          FCommonData.BGChanged := True;
          UpdateControlColors(SkinData);
          inherited;
          FCommonData.CtrlSkinState := FCommonData.CtrlSkinState and not ACS_FOCUSCHANGING;
          Repaint;
        end
        else
          inherited;

        Exit;
      end;

      WM_NCPAINT: begin
        if InanimationProcess then
          OurPaintHandler(0);

        Exit;
      end;

      WM_PAINT: begin
        BeginPaint(Handle, PS);
        if not InAnimationProcess then begin
          if TWMPaint(Message).DC = 0 then
            DC := GetDC(Handle)
          else
            DC := TWMPaint(Message).DC;

          OurPaintHandler(DC);
          if TWMPaint(Message).DC = 0 then
            ReleaseDC(Handle, DC);
        end;
        EndPaint(Handle, PS);
        if csDesigning in ComponentState then
          inherited;

        Exit;
      end;

      WM_MOUSEMOVE:
        if not (csDesigning in ComponentState) then begin
          if not DroppedDown and not AllowBtnStyle then begin
            GetWindowRect(Handle, R);
            bR := ButtonRect;
            OffsetRect(bR, R.Left, R.Top);
            p := acMousePos;
            i := integer(PtInRect(bR, p));
            if not ac_AllowHotEdits and (i <> State) then begin
              State := i;
              AnimateCtrl(1 + 2 * i);
            end;
            inherited;
          end
          else
            inherited;

          Exit;
        end;

      CM_MOUSEENTER:
        if not (csDesigning in ComponentState) then begin
          if not DroppedDown then begin
            if not FCommonData.FMouseAbove then begin
              FCommonData.FMouseAbove := True;
              SkinData.SkinManager.ActiveControl := Handle;
              GetWindowRect(Handle, R);
              bR := ButtonRect;
              InflateRect(bR, 1, 1);
              OffsetRect(bR, R.Left, R.Top);
              p := acMousePos;
              i := integer(PtInRect(bR, p));
              State := i;
              AnimateCtrl(1 + 2 * i)
            end;
          end
          else
            inherited;

          Exit;
        end;

      CM_MOUSELEAVE:
        if not (csDesigning in ComponentState) then begin
          if FCommonData.FMouseAbove then
            if not DroppedDown then begin
              GetWindowRect(Handle, R);
              P := acMousePos;
              if not PtInRect(R, P) then begin
                FCommonData.FMouseAbove := False;
                State := 0;
                AnimateCtrl(0);
              end;
            end
            else
              inherited;

          Exit;
        end;

      WM_COMMAND: begin
        if not ReadOnly and AllowDropDown then begin
          FDropDown := False;
          FCommonData.BGChanged := True;
          FinishTimer(SkinData.AnimTimer);
          OurPaintHandler(0);
          CommonWndProc(Message, FCommonData);
          inherited;
        end;
        Exit;
      end;

{$IFNDEF TNTUNICODE}
      WM_CTLCOLORLISTBOX:
        if not (csLoading in ComponentState) and (lBoxHandle = 0) then begin
          lBoxHandle := hwnd(Message.LParam);
          ListSW := TacComboListWnd.CreateEx(lboxhandle, nil, SkinData.SkinManager, s_Edit, True, Style = csSimple);
        end;
{$ENDIF}

      CM_VISIBLECHANGED, CM_ENABLEDCHANGED, WM_SETFONT:
        if SkinData.CtrlSkinState and ACS_CHANGING = 0 then
          FCommonData.BGChanged := True
        else
            Exit;

      WM_PRINT: begin
        SkinData.FUpdating := False;
        OurPaintHandler(TWMPaint(Message).DC);
        if (Style = csDropDown) and SkinData.FFocused then
          BitBlt(TWMPaint(Message).DC, 0, 0, Width, Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);

        Exit;
      end;
    end;
    CommonWndProc(Message, FCommonData);
    inherited;
    case Message.Msg of
      SM_ALPHACMD:
        case Message.WParamHi of
          AC_DROPPEDDOWN:
            Message.Result := LRESULT(DroppedDown);
        end;

      CM_VISIBLECHANGED:
        if SkinData.CtrlSkinState and ACS_CHANGING = 0 then
          Repaint;

      CM_ENABLEDCHANGED, WM_SETFONT:
        Repaint;

      CB_SETCURSEL: begin
        StopTimer(SkinData);
        FCommonData.BGChanged := True;
        Repaint;
      end;

      CM_FONTCHANGED:
        if SkinData.CtrlSkinState and ACS_CHANGING = 0 then begin
          if IsWindowVisible(Handle) then
            ItemHeight := ItemHeight; // Update control size

          Invalidate;
        end;

      CM_CHANGED, CM_TEXTCHANGED: begin
        FCommonData.BGChanged := True;
        Repaint;
      end;
    end;
  end;

  if Assigned(BoundLabel) then
    BoundLabel.HandleOwnerMsg(Message, Self);
end;


procedure TsCustomComboBox.CreateWnd;
begin
  inherited;
{$IFDEF DELPHI7UP}
{$IFNDEF D2009}
  if CheckWin32Version(5, 1) and ThemeServices.ThemesEnabled then
    SendMessage(Handle, $1701{CB_SETMINVISIBLE}, WPARAM(DropDownCount), 0);
{$ENDIF}
{$ENDIF}
  FCommonData.Loaded;
  UpdateIndexes;
end;


{$IFNDEF DELPHI5}
procedure TsCustomComboBox.SetDropDownCount(const Value: Integer);
begin
  if Value <> DropDownCount then begin
    inherited;
{$IFDEF DELPHI7UP}
{$IFNDEF D2009}
    if CheckWin32Version(5, 1) and ThemeServices.ThemesEnabled and HandleAllocated then
      SendMessage(Handle, $1701{CB_SETMINVISIBLE}, WPARAM(DropDownCount), 0);
{$ENDIF}
{$ENDIF}
  end;
end;
{$ENDIF}


procedure TsCustomComboBox.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if Style in [csDropDown, csDropDownList] then
    Params.Style := Params.Style or CBS_OWNERDRAWFIXED and not CBS_OWNERDRAWVARIABLE;
end;


procedure TsCustomComboBox.CNDrawItem(var Message: TWMDrawItem);
var
  State: TOwnerDrawState;
begin
  with Message.DrawItemStruct^ do begin
    State := TOwnerDrawState(LongRec(itemState).Lo);
    if itemState and ODS_COMBOBOXEDIT <> 0 then
      Include(State, odComboBoxEdit);

    if itemState and ODS_DEFAULT <> 0 then
      Include(State, odDefault);

    Canvas.Handle := hDC;
    DrawItem(integer(itemID), rcItem, State);
    Canvas.Handle := 0;
  end;
end;


procedure TsCustomComboBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  s: ACString;
  Bmp: TBitmap;
  aRect: TRect;
  CI: TCacheInfo;
  BtnStyle: boolean;
  C, TmpColor: TColor;
  DrawStyle: Cardinal;
  OldDC, SavedDC: hdc;
  l, sNdx, mNdx, aState: integer;

  function GetFontColor: TColor;
  begin
    if (odSelected in State) and not BtnStyle then
      Result := SkinData.SkinManager.GetHighLightFontColor(True)
    else
      if SkinData.CustomFont then
        Result := Font.Color
      else
        if odComboBoxEdit in State then
          Result := SkinData.SkinManager.gd[mNdx].Props[aState].FontColor.Color
        else
          Result := SkinData.SkinManager.Palette[pcEditText];
  end;

begin
  aRect := MkRect(WidthOf(Rect), HeightOf(Rect));
  DrawStyle := DT_NOPREFIX or DT_EXPANDTABS or DT_SINGLELINE or DT_TOP or DT_NOCLIP;
  l := Items.Count;
  s := Items[Index];
  if SkinData.Skinned then begin
    BtnStyle := AllowBtnStyle and (odComboBoxEdit in State);
    mNdx := SkinData.SkinIndex;
    Bmp := CreateBmp32(Rect);
    Bmp.Canvas.Font.Assign(Font);
    if odComboBoxEdit in State then begin
      CI := MakeCacheInfo(FCommonData.FCacheBmp, Rect.Left, Rect.Top);
      aState := integer(ControlIsActive(SkinData) or Focused or (BtnStyle and SkinData.FMouseAbove));
    end
    else begin
      CI.Bmp := nil;
      CI.Ready := False;
      CI.FillColor := Color;
      aState := 0;
    end;
    if (odSelected in State) and not BtnStyle then begin
      sNdx := SkinData.SkinManager.ConstData.Sections[ssSelection];
      C := SkinData.SkinManager.GetHighLightColor(True);
      Canvas.Brush.Color := C;
      if sNdx < 0 then
        FillDC(Bmp.Canvas.Handle, MkRect(Bmp), C)
      else
        PaintItem(sNdx, CI, True, 1, MkRect(Bmp), MkPoint, Bmp, SkinData.SkinManager);

      Canvas.Font.Color := SkinData.SkinManager.GetHighLightFontColor(True);
    end
    else begin
      if SkinData.CustomColor then
        C := Color
      else
        if odComboBoxEdit in State then
          C := SkinData.SkinManager.gd[mNdx].Props[aState].Color
        else
          C := SkinData.SkinManager.Palette[pcEditBG];

      if CI.Ready then
        BitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, CI.Bmp.Canvas.Handle, CI.X, CI.Y, SRCCOPY)
      else
        FillDC(Bmp.Canvas.Handle, MkRect(Bmp), C);

      Canvas.Font.Color := GetFontColor;
      Canvas.Brush.Color := C;
      sNdx := -1;
    end;
    if Assigned(OnDrawItem) and (Style in [csOwnerDrawFixed, csOwnerDrawVariable]) then begin
      if IsValidIndex(Index, l) then begin
        OldDC := Canvas.Handle;
        Canvas.Handle := Bmp.Canvas.Handle;
        Bmp.Canvas.Lock;
        SavedDC := SaveDC(Canvas.Handle);
        try
          MovewindowOrg(Canvas.Handle, -Rect.Left, -Rect.Top);
          OnDrawItem(Self, Index, Rect, State);
        finally
          RestoreDC(Canvas.Handle, SavedDC);
          Bmp.Canvas.UnLock;
        end;
        Canvas.Handle := OldDC;
      end
    end
    else begin
      if UseRightToLeftAlignment then
        DrawStyle := DrawStyle or DT_RIGHT;

      if UseRightToLeftReading then
        DrawStyle := DrawStyle or DT_RTLREADING;

      case VerticalAlignment of
        taAlignBottom:    DrawStyle := DrawStyle or DT_BOTTOM;
        taVerticalCenter: DrawStyle := DrawStyle or DT_VCENTER;
      end;

      case Alignment of
        taLeftJustify:;
        taCenter:       DrawStyle := DrawStyle or DT_CENTER;
        taRightJustify: DrawStyle := DrawStyle or DT_RIGHT;
      end;

      if (csDropDown = Style) and (odComboBoxEdit in State) then begin
        Bmp.Canvas.Brush.Style := bsClear;
        if SkinData.CustomFont then
          Bmp.Canvas.Font.Color := Font.Color
        else
          Bmp.Canvas.Font.Color := SkinData.SkinManager.gd[SkinData.SkinIndex].Props[aState].FontColor.Color;

        AcDrawText(Bmp.Canvas.Handle, Text, aRect, DrawStyle);
      end
      else begin
        InflateRect(aRect, -2, 0);
        if sNdx < 0 then begin // Selected is not visible
          Bmp.Canvas.Font.Color := GetFontColor;
          Bmp.Canvas.Brush.Style := bsClear;
          AcDrawText(Bmp.Canvas.Handle, s, aRect, DrawStyle);
        end
        else
          acWriteTextEx(Bmp.Canvas, PACChar(s), True, aRect, DrawStyle, sNdx, (odSelected in State) or (aState > 0), SkinData.SkinManager);

        if (odFocused in State) and (sNdx < 0) and not AllowBtnStyle then begin
          Bmp.Canvas.Brush.Style := bsSolid;
          InflateRect(aRect, 2, 0);
          DrawFocusRect(Bmp.Canvas.Handle, aRect);
        end;
      end;
    end;
    BitBlt(Canvas.Handle, Rect.Left, Rect.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
    FreeAndNil(Bmp);
  end
  else begin
    Canvas.Font.Assign(Font);
    if odSelected in State then begin
      TmpColor := ColorToRGB(clHighLight);
      Canvas.Font.Color := ColorToRGB(clHighLightText);
      Canvas.Brush.Color := ColorToRGB(clHighLight);
    end
    else begin
      TmpColor := ColorToRGB(Color);
      Canvas.Font.Color := ColorToRGB(Font.Color);
      Canvas.Brush.Color := Color;
    end;
    FillDC(Canvas.Handle, Rect, TmpColor);
    if (Index >= 0) and (Index < Items.Count) then begin
      InflateRect(Rect, -2, 0);
      if Assigned(OnDrawItem) and (Style in [csOwnerDrawFixed, csOwnerDrawVariable]) then
        OnDrawItem(Self, Index, Rect, State)
      else begin
        Canvas.Brush.Style := bsClear;
        case Alignment of
          taLeftJustify:;
          taCenter:       DrawStyle := DrawStyle or DT_CENTER;
          taRightJustify: DrawStyle := DrawStyle or DT_RIGHT;
        end;
        AcDrawText(Canvas.Handle, Items[Index], Rect, DrawStyle);
      end;
      if odFocused in State then begin
        InflateRect(Rect, 2, 0);
        DrawFocusRect(Canvas.Handle, Rect);
      end;
    end;
  end;
end;


procedure TsCustomComboBox.CNMeasureItem(var Message: TWMMeasureItem);
{$IFNDEF DELPHI6UP}
var
  Bmp: TBitmap;
{$ENDIF}
begin
{$IFDEF DELPHI6UP}
  if not (Style in [csOwnerDrawFixed, csOwnerDrawVariable]) then begin
    Canvas.Font.Assign(Font);
    if SkinData.CtrlSkinState and ACS_CHANGING = 0 then
      Message.MeasureItemStruct^.itemHeight := Canvas.TextHeight('A') + 2
  end
  else
    inherited;
{$ELSE}
  if {not (Style in [csOwnerDrawFixed, csOwnerDrawVariable]) and }not (csLoading in ComponentState) then begin
    if SkinData.CtrlSkinState and ACS_CHANGING = 0 then begin
      Bmp := TBitmap.Create;
      Bmp.Canvas.Font.Assign(Font);
      Message.MeasureItemStruct^.itemHeight := Bmp.Canvas.TextHeight('A') + 2;
      Bmp.Free;
    end;
  end
  else
    inherited;
{$ENDIF}
end;


{$IFNDEF DELPHI5}
function TsCustomComboBox.GetItemHt: Integer;
begin
  if not (Style in [csOwnerDrawFixed, csOwnerDrawVariable]) then
    Result := SendMessage(Handle, CB_GETITEMHEIGHT, 0, 0)
  else
    Result := inherited GetItemHt;
end;
{$ENDIF}


procedure TsCustomComboBox.ChangeScale(M, D: Integer);
begin
  if M <> D then begin
    inherited;
    if Showing then
      ItemHeight := MulDiv(ItemHeight, M, D);
  end
  else
    inherited;
end;


function TsCustomComboBox.HandleAlphaMsg(var Message: TMessage): boolean;
var
  i: integer;
begin
  Result := True;
  case Message.WParamHi of
    AC_REMOVESKIN:
      if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
        HideGlow(SkinData.GlowID);
        CommonWndProc(Message, FCommonData);
        if lBoxHandle <> 0 then begin
          SetWindowLong(lBoxHandle, GWL_STYLE, GetWindowLong(lBoxHandle, GWL_STYLE) and not WS_THICKFRAME or WS_BORDER);
          UninitializeACScroll(lBoxHandle, True, False, ListSW);
          lBoxHandle := 0;
        end;

        if not FCommonData.CustomColor then
          Color := clWindow;

        if not FCommonData.CustomFont then begin
          Font.OnChange := nil; // Don't recreate control!
          Font.Color := clWindowText;
        end;
      end;

    AC_REFRESH:
      if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
        HideGlow(SkinData.GlowID);
        i := ItemIndex;
        SendMessage(Handle, CB_SHOWDROPDOWN, 0, 0);
        if ItemIndex <> i then
          ItemIndex := i;

        CommonWndProc(Message, FCommonData);
        Repaint;
      end;

    AC_SETSCALE: begin
      if BoundLabel <> nil then BoundLabel.UpdateScale(Message.LParam);
      Exit;
    end;

    AC_SETNEWSKIN:
      if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
        HideGlow(SkinData.GlowID);
        CommonWndProc(Message, FCommonData);
        UpdateIndexes;
        if ListSW <> nil then
          ListSW.acWndProc(Message);
      end;

    AC_ENDPARENTUPDATE:
      if FCommonData.Updating then begin
        FCommonData.Updating := False;
        Repaint;
      end;

    AC_PREPARECACHE:
      PrepareCache;

    AC_GETDEFINDEX: begin
      if FCommonData.SkinManager <> nil then
        if AllowBtnStyle then
          Message.Result := FCommonData.SkinManager.ConstData.Sections[ssButton] + 1
        else
          Message.Result := FCommonData.SkinManager.ConstData.Sections[ssComboBox] + 1;

      Exit;
    end;

    AC_MOUSELEAVE:
      SendMessage(Handle, CM_MOUSELEAVE, 0, 0)

    else
      CommonMessage(Message, FCommonData);
  end;
end;


procedure TsCustomComboBox.SetVerticalAlignment(const Value: TVerticalAlignment);
begin
  if FVerticalAlignment <> Value then begin
    FVerticalAlignment := Value;
    SkinData.BGChanged := True;
    Invalidate;
  end;
end;


procedure TsCustomComboBox.UpdateIndexes;
begin
  if (SkinData.SkinManager <> nil) and (SkinData.SkinIndex >= 0) then
    if AllowBtnStyle then
      FGlyphIndex := SkinData.SkinManager.GetMaskIndex(FCommonData.SkinManager.ConstData.Sections[ssComboBox], s_ItemGlyph)
    else
      FGlyphIndex := SkinData.SkinManager.GetMaskIndex(SkinData.SkinIndex, s_ItemGlyph)
  else
    FGlyphIndex := -1;
end;

end.


