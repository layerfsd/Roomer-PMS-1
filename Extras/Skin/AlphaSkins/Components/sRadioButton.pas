unit sRadioButton;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls,
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  {$IFDEF TNTUNICODE} TntControls, TntActnList, TntForms, TntClasses, {$ENDIF}
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  sCommonData, sConst, sDefaults, sFade;


type
{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsRadioButton = class(TRadioButton)
{$IFNDEF NOTFORHELP}
  private
    FGlyphChecked,
    FGlyphUnChecked: TBitmap;

    FMargin,
    FTextIndent:     integer;

    FShowFocus:      Boolean;
    FCommonData:     TsCommonData;
    FDisabledKind:   TsDisabledKind;
    FAnimatEvents:   TacAnimatEvents;
    FOnValueChanged: TNotifyEvent;
    FVerticalAlign:  TvaAlign;
{$IFNDEF DELPHI7UP}
    FWordWrap: boolean;
    procedure SetWordWrap      (const Value: boolean);
{$ENDIF}
    procedure SetDisabledKind  (const Value: TsDisabledKind);
    procedure SetGlyphChecked  (const Value: TBitmap);
    procedure SetGlyphUnChecked(const Value: TBitmap);
    procedure SetTextIndent    (const Value: integer);
    procedure SetShowFocus     (const Value: Boolean);
    procedure SetMargin        (const Value: integer);
    procedure SetReadOnly      (const Value: boolean);
    procedure SetVerticalAlign (const Value: TvaAlign);
{$IFDEF TNTUNICODE}
    procedure SetCaption       (const Value: TWideCaption);
    procedure SetHint          (const Value: WideString);
    function GetCaption: TWideCaption;
    function GetHint: WideString;
    function IsCaptionStored: Boolean;
    function IsHintStored: Boolean;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
{$ENDIF}
  protected
    FPressed,
    FReadOnly: boolean;
    function GetReadOnly: boolean;
    function CanModify: boolean; virtual;
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    procedure SetChecked(Value: Boolean); override;
    procedure PaintHandler(M: TWMPaint);
    procedure PaintControl(DC: HDC);
    procedure DrawCheckText;
    procedure DrawCheckArea;
    procedure DrawSkinGlyph(i: integer);
    function PaintCtrlState: integer;
    procedure PaintGlyph(Bmp: TBitmap; const Index: integer);
    function SkinGlyphWidth (i: integer): integer;
    function SkinGlyphHeight(i: integer): integer;
    function SkinCheckRect  (i: integer): TRect;
    function Glyph: TBitmap;

    function CheckRect: TRect;
    function GlyphWidth: integer;
    function GlyphHeight: integer;

    function GlyphMaskIndex(Checked: boolean): smallint;
    function PrepareCache: boolean;
{$IFDEF TNTUNICODE}
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure DefineProperties(Filer: TFiler); override;
    function GetActionLinkClass: TControlActionLinkClass; override;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
{$ENDIF}
  public
    function GetControlsAlignment: TAlignment; override;
    procedure AfterConstruction; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Invalidate; override;
    procedure Loaded; override;
    procedure WndProc(var Message: TMessage); override;
  published
{$IFDEF TNTUNICODE}
    property Caption: TWideCaption read GetCaption write SetCaption stored IsCaptionStored;
    property Hint: WideString read GetHint write SetHint stored IsHintStored;
{$ENDIF}
    property AutoSize default True;
{$ENDIF} // NOTFORHELP
    property AnimatEvents: TacAnimatEvents read FAnimatEvents write FAnimatEvents default [aeGlobalDef];
    property SkinData: TsCommonData read FCommonData write FCommonData;
    property DisabledKind: TsDisabledKind read FDisabledKind write SetDisabledKind default DefDisabledKind;
    property GlyphChecked: TBitmap read FGlyphChecked write SetGlyphChecked;
    property GlyphUnChecked: TBitmap read FGlyphUnChecked write SetGlyphUnChecked;
    property ReadOnly: boolean read GetReadOnly write SetReadOnly default False;
    property ShowFocus: Boolean read FShowFocus write SetShowFocus default True;
    property TextIndent: integer read FTextIndent write SetTextIndent default 0;
{$IFNDEF DELPHI7UP}
    property WordWrap: boolean read FWordWrap write SetWordWrap default False;
{$ELSE}
    property WordWrap default False;
{$ENDIF}
    property VerticalAlign: TvaAlign read FVerticalAlign write SetVerticalAlign default vaMiddle;
    property OnValueChanged: TNotifyEvent read FOnValueChanged write FOnValueChanged;
{$IFDEF D2007}
    property OnMouseEnter;
    property OnMouseLeave;
{$ENDIF}
    property Margin: integer read FMargin write SetMargin default 2;
  end;

implementation

uses
  ExtCtrls, Math,
  {$IFDEF CHECKXP}UxTheme, {$ENDIF}
  sGraphUtils, acntUtils, sAlphaGraph, sVclUtils, sMaskData, sStylesimply, sSkinProps, sMessages, sSKinManager;


{$IFDEF TNTUNICODE}
procedure TsRadioButton.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  TntControl_BeforeInherited_ActionChange(Self, Sender, CheckDefaults);
  inherited;
end;
{$ENDIF}


procedure TsRadioButton.AfterConstruction;
begin
  inherited;
  SkinData.Loaded;
end;


function TsRadioButton.GetControlsAlignment: TAlignment;
begin
  if not UseRightToLeftAlignment then
    Result := Alignment
  else
    if Alignment = taRightJustify then
      Result := taLeftJustify
    else
      Result := taRightJustify;
end;


function TsRadioButton.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
var
  ss: TSize;
  R: TRect;
  w, h: integer;
begin
  Result := False;
  if FCommonData.Skinned then begin
    if not (csLoading in ComponentState) then
      if AutoSize then begin
        ss := GetStringSize(Font.Handle, Caption, DT_WORDBREAK, WordWrap);
        R := CheckRect;
        NewWidth := WidthOf(R) + 2 * Margin + (ss.cx + FTextIndent + 8) * integer(Caption <> '');
        NewHeight := Max(HeightOf(R), 2 * Margin + ss.cy * integer(Caption <> '')) + 2;
        Result := True;
      end;
  end
  else
    if AutoSize then begin
      ss := GetStringSize(Font.Handle, Caption, DT_WORDBREAK, WordWrap);
      NewWidth := ss.cx + 20;
      NewHeight := max(ss.cy + 4, 20);
      Result := True;
    end
    else begin
      w := NewWidth;
      h := NewHeight;
      Result := inherited CanAutoSize(w, h);
      NewWidth := w;
      NewHeight := h;
    end;
end;


function TsRadioButton.Glyph: TBitmap;
begin
  if Checked then
    Result := GlyphChecked
  else
    Result := GlyphUnChecked;

  if Result.Empty then
    Result := nil;
end;


function TsRadioButton.CheckRect: TRect;
var
  GlyphTop: integer;

  function GetGlyphTop: integer;
  begin
    case FVerticalAlign of
      vaTop:    Result := 0;
      vaMiddle: Result := (Height - GlyphHeight) div 2
      else      Result := (Height - GlyphHeight);
    end;
  end;

begin
  if FGlyphChecked.Width > 0 then begin
    GlyphTop := GetGlyphTop;
    if GetControlsAlignment = taRightJustify then
      Result := Rect(Margin, GlyphTop, Margin + GlyphWidth, GlyphHeight + GlyphTop)
    else
      Result := Rect(Width - GlyphWidth - Margin, GlyphTop, Width - Margin, GlyphHeight + GlyphTop)
  end
  else
    if SkinData.SkinManager.IsValidImgIndex(FCommonData.SkinManager.ConstData.RadioButton[Checked]) then
      Result := SkinCheckRect(FCommonData.SkinManager.ConstData.RadioButton[Checked])
    else
      Result := MkRect(16, 16);
end;


{$IFDEF TNTUNICODE}
procedure TsRadioButton.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsWideCharAccel(Message.CharCode, Caption) and CanFocus then begin
      SetFocus;
      Result := 1;
    end
    else
      Broadcast(Message);
end;
{$ENDIF}


constructor TsRadioButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCommonData := TsCommonData.Create(Self, False);
  FCommonData.COC := COC_TsRadioButton;
  FCommonData.FOwnerControl := Self;
  FMargin := 2;
  FShowFocus := True;
  FTextIndent := 0;
  FDisabledKind := DefDisabledKind;
  FGlyphChecked := TBitmap.Create;
  FGlyphUnChecked := TBitmap.Create;
  FPressed := False;
  AutoSize := True;
  FAnimatEvents := [aeGlobalDef];
  FVerticalAlign := vaMiddle;
{$IFNDEF DELPHI7UP}
  FWordWrap := False;
{$ELSE}
  WordWrap := False;
{$ENDIF}
end;


{$IFDEF TNTUNICODE}
procedure TsRadioButton.CreateWindowHandle(const Params: TCreateParams);
begin
  CreateUnicodeHandle(Self, Params, 'BUTTON');
end;


procedure TsRadioButton.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;
{$ENDIF}


destructor TsRadioButton.Destroy;
begin
  if Assigned(FCommonData) then
    FreeAndNil(FCommonData);

  if Assigned(FGlyphChecked) then
    FreeAndNil(FGlyphChecked);

  if Assigned(FGlyphUnchecked) then
    FreeAndNil(FGlyphUnChecked);
    
  inherited Destroy;
end;


procedure TsRadioButton.DrawCheckArea;
var
  GlyphCount, GlyphIndex: integer;
begin
  if Glyph <> nil then begin
    GlyphCount := Glyph.Width div Glyph.Height;
    if FPressed then
      GlyphIndex := min(2, GlyphCount - 1)
    else
      if ControlIsActive(FCommonData) and not ReadOnly then
        GlyphIndex := min(1, GlyphCount - 1)
      else
        GlyphIndex := 0;

    PaintGlyph(Glyph, GlyphIndex);
  end
  else
    if SkinData.SkinManager.IsValidImgIndex(FCommonData.SkinManager.ConstData.RadioButton[Checked]) then
      DrawSkinGlyph(FCommonData.SkinManager.ConstData.RadioButton[Checked]);
end;


procedure TsRadioButton.DrawCheckText;
var
  rText: TRect;
  Fmt, State, t, b, w, h, dx: integer;
begin
  if Caption <> '' then begin
    w := Width - (WidthOf(CheckRect) + FTextIndent + 2 * Margin + 2);

    rText := MkRect(w, 0);
    Fmt := DT_CALCRECT or iff(WordWrap, DT_WORDBREAK, DT_SINGLELINE);

    AcDrawText(FCommonData.FCacheBMP.Canvas.Handle, Caption, rText, Fmt);
    h := HeightOf(rText);
    dx := WidthOf(rText);
    t := Max((Height - h) div 2, Margin);
    b := t + h;

    Fmt := DT_TOP;
    if Alignment = taRightJustify then
      if IsRightToLeft then begin
        rText.Right := Width - Margin - WidthOf(CheckRect) - FTextIndent - 4;
        rText.Left := rText.Right - dx;
        rText.Top := t;
        rText.Bottom := b;
        if not WordWrap then
          Fmt := DT_RIGHT;
      end
      else
        rText := Rect(Width - w - Margin + 2, t, Width - w - Margin + 2 + dx, b)
    else
      rText := Rect(Margin, t, w + Margin, b);

    OffsetRect(rText, -integer(WordWrap), -1);
    Fmt := Fmt or iff(WordWrap, DT_WORDBREAK, DT_SINGLELINE);
      
    if UseRightToLeftReading then
      Fmt := Fmt or DT_RTLREADING;

    acWriteTextEx(FCommonData.FCacheBmp.Canvas, PacChar(Caption), True, rText, Fmt, FCommonData, ControlIsActive(FCommonData) and not ReadOnly);

    FCommonData.FCacheBmp.Canvas.Pen.Style := psClear;
    FCommonData.FCacheBmp.Canvas.Brush.Style := bsSolid;
    if Focused and ShowFocus then begin
//      dec(rText.Bottom, integer(not WordWrap));
      inc(rText.Top);
      InflateRect(rText, 2, 1);
      State := min(ac_MaxPropsIndex, SkinData.SkinManager.gd[SkinData.SkinIndex].States);
      FocusRect(SkinData.FCacheBMP.Canvas, rText, SkinData.SkinManager.gd[SkinData.SkinIndex].Props[State].FontColor.Color, clNone);
    end;
  end;
end;


procedure TsRadioButton.DrawSkinGlyph(i: integer);
begin
  with FCommonData do
    if FCacheBmp.Width > 0 then
      sAlphaGraph.DrawSkinGlyph(FCacheBmp, SkinCheckRect(i).TopLeft, PaintCtrlState, 1, SkinManager.ma[i], MakeCacheInfo(FCacheBmp));
end;


{$IFDEF TNTUNICODE}
function TsRadioButton.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TntControl_GetActionLinkClass(Self, inherited GetActionLinkClass);
end;


function TsRadioButton.GetCaption: TWideCaption;
begin
  Result := TntControl_GetText(Self)
end;


function TsRadioButton.GetHint: WideString;
begin
  Result := TntControl_GetHint(Self)
end;
{$ENDIF}


function TsRadioButton.GetReadOnly: boolean;
begin
  Result := FReadOnly;
end;


function TsRadioButton.CanModify: boolean;
begin
  Result := True;
end;


function TsRadioButton.GlyphHeight: integer;
begin
  if Glyph <> nil then
    Result := Glyph.Height
  else
    Result := 16;
end;


function TsRadioButton.GlyphMaskIndex(Checked: boolean): smallint;
begin
  Result := FCommonData.SkinManager.GetMaskIndex(FCommonData.SkinManager.ConstData.IndexGLobalInfo, acRadioGlyphs[Checked]);
end;


function TsRadioButton.GlyphWidth: integer;
begin
  if Glyph <> nil then
    if Glyph.Width mod Glyph.Height = 0 then
      Result := Glyph.Width div (Glyph.Width div Glyph.Height)
    else
      Result := Glyph.Width
  else
    Result := 16;
end;


procedure TsRadioButton.Invalidate;
begin
  inherited;
end;


{$IFDEF TNTUNICODE}
function TsRadioButton.IsCaptionStored: Boolean;
begin
  Result := TntControl_IsCaptionStored(Self);
end;


function TsRadioButton.IsHintStored: Boolean;
begin
  Result := TntControl_IsHintStored(Self)
end;
{$ENDIF}


procedure TsRadioButton.Loaded;
begin
  inherited;
  SkinData.Loaded;
  AdjustSize;
end;


procedure TsRadioButton.PaintControl(DC: HDC);
begin
  if not InUpdating(FCommonData) and not TimerIsActive(SkinData) then
    if not SkinData.BGChanged or PrepareCache then begin
      UpdateCorners(FCommonData, 0);
      BitBlt(DC, 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
    end;
end;


procedure TsRadioButton.PaintGlyph(Bmp: TBitmap; const Index: integer);
var
  R: TRect;
begin
  if FCommonData.FCacheBmp.Width <> 0 then begin
    R := CheckRect;
    if Bmp.PixelFormat = pfDevice then
      Bmp.HandleType := bmDIB;

    if Bmp.PixelFormat <> pf32bit then begin
      Bmp.PixelFormat := pf32bit;
      FillAlphaRect(Bmp, MkRect(Bmp), MaxByte);
    end;
    CopyByMask(R, Rect(GlyphWidth * Index, 0, GlyphWidth * (Index + 1), GlyphHeight), FCommonData.FCacheBmp, Bmp, EmptyCI, True);
  end;
end;


procedure TsRadioButton.PaintHandler(M: TWMPaint);
var
  PS: TPaintStruct;
  DC: hdc;
  SavedDC: hdc;
begin
  if M.DC = 0 then begin
    BeginPaint(Handle, PS);
    DC := GetDC(Handle);
  end
  else
    DC := M.DC;

  SavedDC := SaveDC(DC);
  try
    PaintControl(DC);
  finally
    RestoreDC(DC, SavedDC);
    if M.DC = 0 then begin
      ReleaseDC(Handle, DC);
      EndPaint(Handle, PS);
    end;
  end;
end;


function TsRadioButton.PrepareCache: boolean;
var
  BGInfo: TacBGInfo;
begin
  Result := True;
  InitCacheBmp(SkinData);
  FCommonData.FCacheBmp.Canvas.Font.Assign(Font);
  FCommonData.FCacheBmp.Canvas.Lock;
  BGInfo.PleaseDraw := False;
  BGInfo.Offset := Point(Left, Top);
  BGInfo.R := MkRect(Width, Height);
  GetBGInfo(@BGInfo, Parent);
  case BGInfo.BgType of
    btUnknown: begin // If parent is not AlphaControl
      BGInfo.Bmp := FCommonData.FCacheBmp;
      BGInfo.BgType := btCache;
    end;
    btNotReady: begin
      Result := False;
      SkinData.FUpdating := True;
      Exit;
    end;
  end;
  FCommonData.FCacheBmp.Canvas.Unlock;
  PaintItem(FCommonData, BGInfoToCI(@BGInfo), True, PaintCtrlState, MkRect(FCommonData.FCacheBmp.Width, Height), Point(Left, Top), FCommonData.FCacheBmp, True);
  DrawCheckText;
  DrawCheckArea;
  if not Enabled then
    BmpDisabledKind(FCommonData.FCacheBmp, FDisabledKind, Parent, BGInfoToCI(@BGInfo), Point(Left, Top));

  FCommonData.BGChanged := False
end;


{$IFDEF TNTUNICODE}
procedure TsRadioButton.SetCaption(const Value: TWideCaption);
begin
  TntControl_SetText(Self, Value);
end;
{$ENDIF}


{$IFNDEF DELPHI7UP}
procedure TsRadioButton.SetWordWrap(const Value: boolean);
begin
  if FWordWrap <> Value then begin
    FWordWrap := Value;
    FCommonData.BGChanged := True;
    if AutoSize then
      AutoSize := False;

    Repaint;
  end;
end;
{$ENDIF}


procedure TsRadioButton.SetDisabledKind(const Value: TsDisabledKind);
begin
  if FDisabledKind <> Value then begin
    FDisabledKind := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsRadioButton.SetGlyphChecked(const Value: TBitmap);
begin
  FGlyphChecked.Assign(Value);
  if AutoSize then
    AdjustSize;

  if Checked then
    FCommonData.Invalidate;
end;


procedure TsRadioButton.SetGlyphUnChecked(const Value: TBitmap);
begin
  FGlyphUnChecked.Assign(Value);
  if AutoSize then
    AdjustSize;

  if not Checked then
    FCommonData.Invalidate;
end;


{$IFDEF TNTUNICODE}
procedure TsRadioButton.SetHint(const Value: WideString);
begin
  TntControl_SetHint(Self, Value);
end;
{$ENDIF}


procedure TsRadioButton.SetMargin(const Value: integer);
begin
  if FMargin <> Value then begin
    FMargin := Value;
    if AutoSize then
      AdjustSize;

    Invalidate;
  end;
end;


procedure TsRadioButton.SetReadOnly(const Value: boolean);
begin
  FReadOnly := Value;
end;


procedure TsRadioButton.SetShowFocus(const Value: Boolean);
begin
  if FShowFocus <> Value then begin
    FShowFocus := Value;
    Invalidate;
  end;
end;


procedure TsRadioButton.SetTextIndent(const Value: integer);
begin
  if FTextIndent <> Value then begin
    FTextIndent := Value;
    if AutoSize then
      AdjustSize;

    Invalidate;
  end;
end;


function TsRadioButton.SkinCheckRect(i: integer): TRect;
var
  h, w, hdiv: integer;
begin
  h := SkinGlyphHeight(i);
  w := SkinGlyphWidth(i);
  case FVerticalAlign of
    vaTop:    hdiv := 0;
    vaMiddle: hdiv := (Height - h) div 2
    else      hdiv := (Height - h);
  end;
  if GetControlsAlignment = taRightJustify then
    Result := Rect(Margin, hdiv, Margin + w, h + hdiv)
  else
    Result := Rect(Width - w - Margin, hdiv, Width - Margin, h + hdiv);
end;


function TsRadioButton.SkinGlyphHeight(i: integer): integer;
begin
  Result := HeightOfImage(FCommonData.SkinManager.ma[i]);
end;


function TsRadioButton.SkinGlyphWidth(i: integer): integer;
begin
  Result := WidthOfImage(FCommonData.SkinManager.ma[i]);
end;


procedure TsRadioButton.WndProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_CTRLHANDLED: begin
          Message.Result := 1;
          Exit;
        end; // AlphaSkins supported

        AC_GETAPPLICATION: begin
          Message.Result := LRESULT(Application);
          Exit;
        end;

        AC_REMOVESKIN:
          if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
            CommonWndProc(Message, FCommonData);
            if HandleAllocated then
              SendMessage(Handle, BM_SETCHECK, Integer(Checked), 0);

            if not (csDesigning in ComponentState) and (uxthemeLib <> 0) then
              Ac_SetWindowTheme(Handle, nil, nil);

            Repaint;
            Exit;
          end;

        AC_REFRESH:
          if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
            SetClassLong(Handle, GCL_STYLE, GetClassLong(Handle, GCL_STYLE) and not CS_VREDRAW and not CS_HREDRAW);
            CommonWndProc(Message, FCommonData);
            AdjustSize;
            Repaint;
            Exit;
          end;

        AC_PREPARECACHE: begin
          PrepareCache;
          Exit;
        end;

        AC_GETDEFINDEX: begin
          if FCommonData.SkinManager <> nil then
            Message.Result := FCommonData.SkinManager.ConstData.Sections[ssCheckBox] + 1;

          Exit;
        end;

        AC_SETNEWSKIN:
          if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
            CommonWndProc(Message, FCommonData);
            Exit;
          end;
      end;

      CM_FONTCHANGED, CM_TEXTCHANGED:
        if AutoSize then begin
          if not (csDesigning in ComponentState) then
            HandleNeeded;

          inherited;
          AdjustSize;
          Exit;
        end;
    end;

  if (FCommonData <> nil) and FCommonData.Skinned(True) then
    case Message.Msg of
      CM_MOUSEENTER:
        if Enabled and not (csDesigning in ComponentState) and not FCommonData.FMouseAbove then begin
          FCommonData.FMouseAbove := True;
          DoChangePaint(FCommonData, 1, UpdateWindow_CB, EventEnabled(aeMouseEnter, FAnimatEvents), False);
        end;

      CM_MOUSELEAVE:
        if Enabled and not (csDesigning in ComponentState) then begin
          FCommonData.FMouseAbove := False;
          FPressed := False;
          DoChangePaint(FCommonData, 0, UpdateWindow_CB, EventEnabled(aeMouseLeave, FAnimatEvents), False, False);
        end;

      WM_SETFOCUS, CM_ENTER:
        if not (csDesigning in ComponentState) then begin
          if Enabled then begin
            inherited;
            FCommonData.BGChanged := True;
            if (SkinData.AnimTimer <> nil) and SkinData.AnimTimer.Enabled then begin
              SkinData.BGChanged := True;
              SkinData.AnimTimer.TimeHandler; // Fast repaint
            end
            else
              Repaint
          end;
          Exit;
        end;

      WM_KILLFOCUS, CM_EXIT:
        if not (csDesigning in ComponentState) then
          if Enabled then begin
            StopTimer(SkinData);
            Perform(WM_SETREDRAW, 0, 0);
            inherited;
            Perform(WM_SETREDRAW, 1, 0);
            FCommonData.FFocused := False;
            FCommonData.FMouseAbove := False;
            FCommonData.Invalidate;
            Exit;
          end;
    end;

  if not ControlIsReady(Self) then
    inherited
  else begin
    if CommonWndProc(Message, FCommonData) then
      Exit;

    if FCommonData.Skinned(True) then
      case Message.Msg of
        SM_ALPHACMD:
          case Message.WParamHi of
            AC_ENDPARENTUPDATE:
              if FCommonData.Updating or FCommonData.HalfVisible then begin
                FCommonData.Updating := False;
                PaintHandler(TWMPaint(MakeMessage(WM_PAINT, 0, 0, 0)));
              end
          end;

        WM_ENABLE, WM_NCPAINT:
          Exit; // Disabling of blinking when switched
{$IFDEF CHECKXP}
        WM_UPDATEUISTATE: begin
          if SkinData.Skinned and UseThemes and not (csDesigning in ComponentState) and (uxthemeLib <> 0) then
            Ac_SetWindowTheme(Handle, s_Space, s_Space);

          Exit;
        end;
{$ENDIF}
        CM_ENABLEDCHANGED: begin
          inherited;
          Repaint;
          Exit;
        end;

        BM_SETSTATE:
          Exit;

        CN_COMMAND:
          if not ((csCreating in ControlState) or (csLoading in ComponentState)) and ReadOnly then
            Exit;

        BM_SETCHECK: begin
          Perform(WM_SETREDRAW, 0, 0);
          inherited;
          Perform(WM_SETREDRAW, 1, 0);
          FCommonData.BGChanged := True;
          if not TimerIsActive(SkinData) then begin
            StopTimer(SkinData);
            Repaint;
          end;
          Checked := Message.WParam = 1;
          StopTimer(SkinData);
          if not FPressed then
            FCommonData.Invalidate;

          Exit;
        end;

        WM_ERASEBKGND: begin
          if (TWMPaint(Message).DC <> 0) and (Skindata.FCacheBmp <> nil) and not FCommonData.BGChanged and not TimerIsActive(SkinData) then
            CopyWinControlCache(Self, FCommonData, MkRect, MkRect(Self), TWMPaint(Message).DC, False);

          Message.Result := 1;
          Exit;
        end;

        WM_PRINT: begin
          SkinData.Updating := False;
          PaintHandler(TWMPaint(Message));
        end;

        WM_PAINT: begin
          PaintHandler(TWMPaint(Message));
          if not (csDesigning in ComponentState) then
            Exit;
        end;

        WM_KEYDOWN:
          if Enabled and not (csDesigning in ComponentState) and (TWMKey(Message).CharCode = VK_SPACE) then begin
            if not ReadOnly then begin
              FPressed := True;
              if not Focused then begin
                ClicksDisabled := True;
                Windows.SetFocus(Handle);
                ClicksDisabled := False;
              end;
              Repaint;
              if Assigned(OnKeyDown) then
                OnKeydown(Self, TWMKeyDown(Message).CharCode, KeysToShiftState(word(TWMKeyDown(Message).KeyData)));
            end;
            Exit;
          end;

        WM_LBUTTONDBLCLK, WM_LBUTTONDOWN:
          if not (csDesigning in ComponentState) and Enabled and (DragMode = dmManual) then begin
            if not ReadOnly then begin
              FPressed := True;
              DoChangePaint(FCommonData, 2, UpdateWindow_CB, EventEnabled(aeMouseDown, FAnimatEvents), False);

              if not Focused then begin
                ClicksDisabled := True;
                Windows.SetFocus(Handle);
                ClicksDisabled := False;
              end;

              if WM_LBUTTONDBLCLK = Message.Msg then begin
                if Assigned(OnDblClick) then
                  OnDblClick(Self)
              end
              else
                if Assigned(OnMouseDown) then
                  OnMouseDown(Self, mbLeft, KeysToShiftState(TWMMouse(Message).Keys), TWMMouse(Message).XPos, TWMMouse(Message).YPos);
            end;
            Exit;
          end;

        WM_KEYUP:
          if Enabled and not (csDesigning in ComponentState) and (TWMKey(Message).CharCode = VK_SPACE) then begin
            if not ReadOnly then begin
              if FPressed then begin
                FPressed := False;
                Checked := True;
              end;
              Repaint;
              if Assigned(OnKeyUp) then
                OnKeyUp(Self, TWMKey(Message).CharCode, KeysToShiftState(TWMKey(Message).KeyData));
            end;
            Exit;
          end;

        WM_LBUTTONUP:
          if not (csDesigning in ComponentState) and Enabled then begin
            if not ReadOnly and CanModify and FPressed then begin
              Checked := True;
              Perform(CN_COMMAND, MakeWParam(BN_CLICKED, 0), Handle);
            end;
            FPressed := False;
            StopTimer(SkinData);
            Repaint;
            if Assigned(OnMouseUp) then
              OnMouseUp(Self, mbLeft, KeysToShiftState(TWMMouse(Message).Keys), TWMMouse(Message).XPos, TWMMouse(Message).YPos);

            Exit;
          end;
      end
    else
      case Message.Msg of
        CM_FONTCHANGED, CM_TEXTCHANGED: begin
          if AutoSize then
            AdjustSize;

          Repaint;
          Exit;
        end;

        WM_KEYDOWN, WM_LBUTTONDOWN:
          FPressed := True;

        WM_KEYUP, WM_LBUTTONUP:
          FPressed := False;

        WM_LBUTTONDBLCLK:
          if ReadOnly then
            Exit;

        BM_SETSTATE, BM_SETCHECK:
          if not ((csCreating in ControlState) or (csLoading in ComponentState)) and FPressed and ReadOnly then
            Exit;

        CN_COMMAND:
          if not ((csCreating in ControlState) or (csLoading in ComponentState)) and ReadOnly then
            Exit;
      end;

    inherited;
  end;
end;


procedure TsRadioButton.SetVerticalAlign(const Value: TvaAlign);
begin
  if FVerticalAlign <> Value then begin
    FVerticalAlign := Value;
    Repaint;
  end;
end;


procedure TsRadioButton.SetChecked(Value: Boolean);
var
   CurValue:Boolean;
begin
  CurValue := Checked;
  inherited;
  if Assigned(FOnValueChanged) and (CurValue <> Checked) then
    FOnValueChanged(self);
end;


function TsRadioButton.PaintCtrlState: integer;
begin
  if FPressed then
    Result := 2
  else
    Result := integer(ControlIsActive(FCommonData) and not ReadOnly);
end;

end.
