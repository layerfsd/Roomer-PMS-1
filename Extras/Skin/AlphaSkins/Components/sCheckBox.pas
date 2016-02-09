unit sCheckBox;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, imglist, StdCtrls,
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  {$IFDEF TNTUNICODE} TntControls, TntActnList, TntForms, TntClasses, {$ENDIF}
  sCommonData, sConst, sDefaults, sFade;


type
{$IFNDEF NOTFORHELP}
  TsImageIndex = integer;
{$ENDIF} // NOTFORHELP


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsCheckBox = class(TCustomCheckBox)
{$IFNDEF NOTFORHELP}
  private
    FPressed,
    FShowFocus: boolean;

    FMargin,
    FTextIndent: integer;

    FGlyphChecked,
    FGlyphUnChecked: TBitmap;

    FImgChecked,
    FImgUnchecked: TsImageIndex;

    FVerticalAlign: TvaAlign;
    FCommonData: TsCommonData;
    FImages: TCustomImageList;
    FDisabledKind: TsDisabledKind;
    FAnimatEvents: TacAnimatEvents;
    FOnValueChanged: TNotifyEvent;
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
    procedure SetImageChecked  (const Value: TsImageIndex);
    procedure SetImages        (const Value: TCustomImageList);
    procedure SetImageUnChecked(const Value: TsImageIndex);
    procedure SetVerticalAlign (const Value: TvaAlign);
{$IFDEF TNTUNICODE}
    procedure SetHint          (const Value: WideString);
    procedure SetCaption       (const Value: TWideCaption);
    function GetCaption:      TWideCaption;
    function GetHint:         WideString;
    function IsHintStored:    boolean;
    function IsCaptionStored: boolean;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
{$ENDIF}
  protected
    FReadOnly: boolean;
    function GetReadOnly: boolean;
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    procedure SetChecked(Value: Boolean); override;
    procedure PaintHandler(M: TWMPaint);
    procedure PaintControl(DC: HDC);
    procedure DrawCheckText;
    procedure DrawCheckArea;
    procedure DrawSkinGlyph(i: integer);
    function PaintCtrlState: integer;
    procedure PaintGlyph(Bmp: TBitmap; const Index: integer);
    function SkinGlyphHeight(i: integer): integer;
    function SkinGlyphWidth (i: integer): integer;
    function SkinCheckRect  (i: integer): TRect;
    function Glyph: TBitmap;
    function CheckRect: TRect;
    function GlyphWidth: integer;
    function GlyphHeight: integer;
//    function GlyphMaskIndex(State: TCheckBoxState): smallint;
    function PrepareCache: boolean;
{$IFDEF TNTUNICODE}
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure DefineProperties(Filer: TFiler); override;
    function GetActionLinkClass: TControlActionLinkClass; override;
{$ENDIF}
  public
    function GetControlsAlignment: TAlignment; override;
    procedure AfterConstruction; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure WndProc(var Message: TMessage); override;
  published
{$IFDEF TNTUNICODE}
    property Caption: TWideCaption read GetCaption write SetCaption stored IsCaptionStored;
    property Hint: WideString read GetHint write SetHint stored IsHintStored;
{$ELSE}
    property Caption;
{$ENDIF}
    property Action;
    property Align;
    property Alignment;
    property AllowGrayed;
    property Anchors;
    property AutoSize default True;
    property BiDiMode;
    property Checked;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property State;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    property Margin: integer read FMargin write SetMargin default 2;
{$ENDIF} // NOTFORHELP
    property AnimatEvents: TacAnimatEvents read FAnimatEvents write FAnimatEvents default [aeGlobalDef];
    property SkinData: TsCommonData read FCommonData write FCommonData;
    property DisabledKind: TsDisabledKind read FDisabledKind write SetDisabledKind default DefDisabledKind;
    property GlyphChecked: TBitmap read FGlyphChecked write SetGlyphChecked;
    property GlyphUnChecked: TBitmap read FGlyphUnChecked write SetGlyphUnChecked;
    property ImgChecked: TsImageIndex read FImgChecked write SetImageChecked;
    property ImgUnchecked: TsImageIndex  read FImgUnchecked write SetImageUnChecked;
    property Images: TCustomImageList read FImages write SetImages;
    property ReadOnly: boolean read GetReadOnly write SetReadOnly default False;
    property ShowFocus: boolean read FShowFocus write SetShowFocus default True;
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
  end;


{$IFNDEF NOTFORHELP}
var
  PaintState: integer = -1;
{$ENDIF}


implementation

uses Math,
  {$IFDEF CHECKXP}UxTheme, {$ENDIF}
  sGraphUtils, acntUtils, sAlphaGraph, sVclUtils, sStylesimply, sSkinProps,
  acAlphaImageList, sMaskData, sMessages, sSKinManager;


procedure TsCheckBox.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
{$IFDEF TNTUNICODE}
  TntControl_BeforeInherited_ActionChange(Self, Sender, CheckDefaults);
{$ENDIF}
  FCommonData.BGChanged := True;
  inherited;
  Repaint;
end;


procedure TsCheckBox.AfterConstruction;
begin
  inherited;
  SkinData.Loaded;
end;


function TsCheckBox.GetControlsAlignment: TAlignment;
begin
  if not UseRightToLeftAlignment then
    Result := Alignment
  else
    if Alignment = taRightJustify then
      Result := taLeftJustify
    else
      Result := taRightJustify;
end;


function TsCheckBox.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
var
  R: TRect;
  ss: TSize;
  w, h: integer;
begin
  Result := False;
  if FCommonData.Skinned then begin
    if not (csLoading in ComponentState) and AutoSize then begin
      ss := GetStringSize(Font.Handle, Caption, DT_WORDBREAK, WordWrap);
      R := CheckRect;
      NewWidth := WidthOf(R) + 2 * Margin + (ss.cx + FTextIndent + 8) * integer(Caption <> '');
      NewHeight := Max(HeightOf(R), 2 * Margin + ss.cy * integer(Caption <> ''));// + 2;
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
      w := NewWidth; h := NewHeight;
      Result := inherited CanAutoSize(w, h);
      NewWidth := w; NewHeight := h;
    end;
end;


function TsCheckBox.CheckRect: TRect;
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
  if Assigned(Images) and (ImgChecked >= 0) and (ImgUnChecked >= 0) then begin
    GlyphTop := GetGlyphTop;
    if GetControlsAlignment = taRightJustify then
      Result := Rect(Margin, GlyphTop, Margin + GlyphWidth, GlyphHeight + GlyphTop)
    else
      Result := Rect(Width - GlyphWidth - Margin, GlyphTop, Width - Margin, GlyphHeight + GlyphTop)
  end
  else
    if FGlyphChecked.Width > 0 then begin
      GlyphTop := GetGlyphTop;
      if GetControlsAlignment = taRightJustify then
        Result := Rect(Margin, GlyphTop, Margin + GlyphWidth, GlyphHeight + GlyphTop)
      else
        Result := Rect(Width - GlyphWidth - Margin, GlyphTop, Width - Margin, GlyphHeight + GlyphTop)
    end
    else begin
      if FCommonData.SkinManager.IsValidImgIndex(FCommonData.SkinManager.ConstData.CheckBox[State]) then
        Result := SkinCheckRect(FCommonData.SkinManager.ConstData.CheckBox[State])
      else
        Result := MkRect(16, 16);
    end;
end;


{$IFDEF TNTUNICODE}
procedure TsCheckBox.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsWideCharAccel(Message.CharCode, Caption) and CanFocus then begin
      SetFocus;
      if Focused then
        Toggle;
        
      Result := 1;
    end
    else
      Broadcast(Message);
end;
{$ENDIF}


constructor TsCheckBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCommonData := TsCommonData.Create(Self, False);
  FCommonData.COC := COC_TsCheckBox;
  FCommonData.FOwnerControl := Self;
  FMargin := 2;
  FShowFocus := True;
  FTextIndent := 0;
  FDisabledKind := DefDisabledKind;
  FGlyphChecked := TBitmap.Create;
  FGlyphUnChecked := TBitmap.Create;
  FAnimatEvents := [aeGlobalDef];
  FVerticalAlign := vaMiddle;
{$IFNDEF DELPHI7UP}
  FWordWrap := False;
{$ELSE}
  WordWrap := False;
{$ENDIF}
  FPressed := False;
  AutoSize := True;
end;


{$IFDEF TNTUNICODE}
procedure TsCheckBox.CreateWindowHandle(const Params: TCreateParams);
begin
  CreateUnicodeHandle(Self, Params, 'BUTTON');
end;


procedure TsCheckBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;
{$ENDIF}


destructor TsCheckBox.Destroy;
begin
  if Assigned(FCommonData) then
    FreeAndNil(FCommonData);

  if Assigned(FGlyphChecked) then
    FreeAndNil(FGlyphChecked);

  if Assigned(FGlyphUnchecked) then
    FreeAndNil(FGlyphUnChecked);

  inherited Destroy;
end;


procedure TsCheckBox.DrawCheckArea;
var
  i, ImgIndex, GlyphCount, GlyphIndex: integer;
  TempBmp: TBitmap;
  R: TRect;
begin
  if Assigned(Images) and (ImgChecked >= 0) and (ImgUnChecked >= 0) then begin
    ImgIndex := iff(Checked, ImgChecked, ImgUnChecked);
    if (ImgIndex >= 0) then begin
      R := CheckRect;
      GlyphCount := Images.Width div Images.Height;
      if (GlyphCount > 1) and (Images.Width mod Images.Height = 0) then begin // If complex image
        TempBmp := TBitmap.Create;
        if Images is TsAlphaImageList then begin
          if not TsAlphaImageList(Images).GetBitmap32(ImgIndex, TempBmp) then
            Exit
        end
        else
  {$IFDEF DELPHI5}
          Images.GetBitmap(ImgIndex, TempBmp);
  {$ELSE}
          if not Images.GetBitmap(ImgIndex, TempBmp) then
            Exit;
  {$ENDIF}
        if FPressed then
          GlyphIndex := min(2, GlyphCount - 1)
        else
          if ControlIsActive(FCommonData) and not ReadOnly then
            GlyphIndex := min(1, GlyphCount - 1)
          else
            GlyphIndex := 0;

        PaintGlyph(TempBmp, GlyphIndex);
        FreeAndNil(TempBmp);
      end
      else
        Images.Draw(FCommonData.FCacheBmp.Canvas, R.Left, R.Top, ImgIndex, True);
    end;
  end
  else
    if Glyph <> nil then begin
      GlyphCount := max(1, Glyph.Width div Glyph.Height);
      if FPressed then
        GlyphIndex := min(2, GlyphCount - 1)
      else
        if ControlIsActive(FCommonData) and not ReadOnly then
          GlyphIndex := min(1, GlyphCount - 1)
        else
          GlyphIndex := 0;

      if Glyph.Width <> 0 then
        PaintGlyph(Glyph, GlyphIndex);
    end
    else begin
      if PaintState >= 0 then
        i := FCommonData.SkinManager.ConstData.CheckBox[sConst.CheckBoxStates[PaintState]]
      else
        i := FCommonData.SkinManager.ConstData.CheckBox[State];

      if SkinData.SkinManager.IsValidImgIndex(i) then
        DrawSkinGlyph(i);
    end;
end;


procedure TsCheckBox.DrawCheckText;
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

    acWriteTextEx(FCommonData.FCacheBmp.Canvas, PacChar(Caption), True, rText, Fmt, FCommonData, PaintCtrlState > 0);//ControlIsActive(FCommonData) and not ReadOnly);
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


procedure TsCheckBox.DrawSkinGlyph(i: integer);
begin
  with FCommonData do
    if FCacheBmp.Width > 0 then
      sAlphaGraph.DrawSkinGlyph(FCacheBmp, SkinCheckRect(i).TopLeft, PaintCtrlState, 1, SkinManager.ma[i], MakeCacheInfo(FCacheBmp))
end;


{$IFDEF TNTUNICODE}
function TsCheckBox.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TntControl_GetActionLinkClass(Self, inherited GetActionLinkClass);
end;


function TsCheckBox.GetCaption: TWideCaption;
begin
  Result := TntControl_GetText(Self)
end;


function TsCheckBox.GetHint: WideString;
begin
  Result := TntControl_GetHint(Self)
end;
{$ENDIF}


function TsCheckBox.GetReadOnly: boolean;
begin
  Result := FReadOnly;
end;


function TsCheckBox.GlyphHeight: integer;
begin
  if Assigned(Images) and (ImgChecked >= 0) and (ImgUnChecked >= 0) then
    Result := Images.Height
  else
    if Glyph <> nil then
      Result := Glyph.Height
    else
      Result := 16;
end;

{
function TsCheckBox.GlyphMaskIndex(State: TCheckBoxState): smallint;
begin
  Result := FCommonData.SkinManager.ConstData.CheckBox[State];
end;
}

function TsCheckBox.GlyphWidth: integer;
begin
  if Assigned(Images) and (ImgChecked >= 0) and (ImgUnChecked >= 0) then
    if Images.Width mod Images.Height = 0 then
      Result := Images.Width div (Images.Width div Images.Height)
    else
      Result := Images.Width
  else
    if Glyph <> nil then
      if Glyph.Width mod Glyph.Height = 0 then
        Result := Glyph.Width div (Glyph.Width div Glyph.Height)
      else
        Result := Glyph.Width
    else
      Result := 16;
end;


{$IFDEF TNTUNICODE}
function TsCheckBox.IsCaptionStored: boolean;
begin
  Result := TntControl_IsCaptionStored(Self)
end;


function TsCheckBox.IsHintStored: boolean;
begin
  Result := TntControl_IsHintStored(Self)
end;
{$ENDIF}


procedure TsCheckBox.Loaded;
begin
  inherited;
  SkinData.Loaded;
  AdjustSize;
end;


procedure TsCheckBox.PaintControl(DC: HDC);
begin
  if not FCommonData.Updating and not (Assigned(SkinData.AnimTimer) and SkinData.AnimTimer.Enabled) then
    if PrepareCache then begin
      UpdateCorners(FCommonData, 0);
      BitBlt(DC, 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
    end;
end;


procedure TsCheckBox.PaintGlyph(Bmp: TBitmap; const Index: integer);
var
  R: TRect;
begin
  if FCommonData.FCacheBmp.Width > 0 then begin
    R := CheckRect;
    if Bmp.PixelFormat = pfDevice then
      Bmp.HandleType := bmDIB;

    if Bmp.PixelFormat <> pf32bit then begin
      Bmp.PixelFormat := pf32bit;
      FillAlphaRect(Bmp, MkRect(Bmp), MaxByte);
    end;
    CopyByMask(Rect(R.Left, R.Top, R.Right, R.Bottom), Rect(GlyphWidth * Index, 0, GlyphWidth * (Index + 1), GlyphHeight), FCommonData.FCacheBmp, Bmp, EmptyCI, True);
  end;
end;


procedure TsCheckBox.PaintHandler(M: TWMPaint);
var
  PS: TPaintStruct;
  DC, SavedDC: hdc;
begin
  DC := M.DC;
  if (DC = 0) or (SkinData.CtrlSkinState and ACS_PRINTING <> ACS_PRINTING) then
    DC := BeginPaint(Handle, PS);

  SavedDC := SaveDC(DC);
  try
    if not InUpdating(FCommonData) then
      PaintControl(DC);
  finally
    RestoreDC(DC, SavedDC);
    if (M.DC = 0) or (SkinData.CtrlSkinState and ACS_PRINTING <> ACS_PRINTING) then
      EndPaint(Handle, PS);
  end;
end;


function TsCheckBox.PrepareCache: boolean;
var
  BGInfo: TacBGInfo;
begin
  Result := True;
  InitCacheBmp(SkinData);
  FCommonData.FCacheBmp.Canvas.Font.Assign(Font);
  FCommonData.FCacheBmp.Canvas.Lock;
  BGInfo.PleaseDraw := False;
  BGInfo.Offset := Point(Left, Top);
  BGInfo.R := MkRect(Self);
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
  PaintItem(FCommonData, BGInfoToCI(@BGInfo), True, PaintCtrlState, MkRect(FCommonData.FCacheBmp), MkPoint(Self), FCommonData.FCacheBmp, True);
  DrawCheckText;
  DrawCheckArea;
  if not Enabled then
    BmpDisabledKind(FCommonData.FCacheBmp, FDisabledKind, Parent, BGInfoToCI(@BGInfo), Point(Left, Top));
    
  FCommonData.BGChanged := False
end;


{$IFDEF TNTUNICODE}
procedure TsCheckBox.SetCaption(const Value: TWideCaption);
begin
  TntControl_SetText(Self, Value);
end;
{$ENDIF}


procedure TsCheckBox.SetChecked(Value: Boolean);
var
  b: boolean;
begin
  b := False;
  if not (csLoading in ComponentState) then begin
    if (Value <> Checked) then begin
      FCommonData.BGChanged := True;
      b := True;
    end;
    inherited;
    if FCommonData.BGChanged then
      Repaint;

    if b and assigned(FOnValueChanged) then
      FOnValueChanged(self);
  end
  else
    inherited;
end;


{$IFNDEF DELPHI7UP}
procedure TsCheckBox.SetWordWrap(const Value: boolean);
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


procedure TsCheckBox.SetDisabledKind(const Value: TsDisabledKind);
begin
  if FDisabledKind <> Value then begin
    FDisabledKind := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsCheckBox.SetGlyphChecked(const Value: TBitmap);
begin
  FGlyphChecked.Assign(Value);
  if AutoSize then
    AdjustSize;

  FCommonData.Invalidate;
end;


procedure TsCheckBox.SetGlyphUnChecked(const Value: TBitmap);
begin
  FGlyphUnChecked.Assign(Value);
  if AutoSize then
    AdjustSize;

  Invalidate;
end;


{$IFDEF TNTUNICODE}
procedure TsCheckBox.SetHint(const Value: WideString);
begin
  TntControl_SetHint(Self, Value);
end;
{$ENDIF}


procedure TsCheckBox.SetImageChecked(const Value: TsImageIndex);
begin
  if FImgChecked <> Value then begin
    FImgChecked := Value;
    if AutoSize then
      AdjustSize;

    if Checked then
      SkinData.Invalidate;
  end;
end;


procedure TsCheckBox.SetImages(const Value: TCustomImageList);
begin
  if FImages <> Value then begin
    FImages := Value;
    if AutoSize then
      AdjustSize;

    SkinData.Invalidate;
  end;
end;


procedure TsCheckBox.SetImageUnChecked(const Value: TsImageIndex);
begin
  if FImgUnchecked <> Value then begin
    FImgUnchecked := Value;
    if AutoSize then
      AdjustSize;

    if not Checked then
      SkinData.Invalidate;
  end;
end;


procedure TsCheckBox.SetMargin(const Value: integer);
begin
  if FMargin <> Value then begin
    FMargin := Value;
    if AutoSize then
      AdjustSize;

    Invalidate;
  end;
end;


procedure TsCheckBox.SetReadOnly(const Value: boolean);
begin
  FReadOnly := Value;
end;


procedure TsCheckBox.SetShowFocus(const Value: Boolean);
begin
  if FShowFocus <> Value then begin
    FShowFocus := Value;
    Invalidate;
  end;
end;


procedure TsCheckBox.SetTextIndent(const Value: integer);
begin
  if FTextIndent <> Value then begin
    FTextIndent := Value;
    if AutoSize then
      AdjustSize;

    Invalidate;
  end;
end;


function TsCheckBox.Glyph: TBitmap;
begin
  if Checked then
    Result := GlyphChecked
  else
    Result := GlyphUnChecked;

  if Result.Empty then
    Result := nil;
end;


function TsCheckBox.SkinCheckRect(i: integer): TRect;
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


function TsCheckBox.SkinGlyphHeight(i: integer): integer;
begin
  Result := HeightOfImage(FCommonData.SkinManager.ma[i]);
end;


function TsCheckBox.SkinGlyphWidth(i: integer): integer;
begin
  Result := WidthOfImage(FCommonData.SkinManager.ma[i]);
end;


procedure TsCheckBox.WndProc(var Message: TMessage);
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
        end;

        AC_GETAPPLICATION: begin
          Message.Result := LRESULT(Application);
          Exit;
        end;

        AC_REMOVESKIN:
          if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
            CommonWndProc(Message, FCommonData);
            if HandleAllocated then
              SendMessage(Handle, BM_SETCHECK, LPARAM(State), 0);

            if not (csDesigning in ComponentState) and (uxthemeLib <> 0) then
              Ac_SetWindowTheme(Handle, nil, nil);

            Repaint;
            Exit;
          end;

        AC_REFRESH:
          if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
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
          end
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
      CM_MOUSEENTER: begin
        if Enabled and not (csDesigning in ComponentState) and not FCommonData.FMouseAbove then begin
          FCommonData.FMouseAbove := True;
          DoChangePaint(FCommonData, 1, UpdateWindow_CB, EventEnabled(aeMouseEnter, FAnimatEvents), False);
        end;
        inherited;
        Exit;
      end;

      CM_MOUSELEAVE: begin
        if Enabled and not (csDesigning in ComponentState) and FCommonData.FMouseAbove then begin
          FCommonData.FMouseAbove := False;
          FPressed := False;
          DoChangePaint(FCommonData, 0, UpdateWindow_CB, EventEnabled(aeMouseLeave, FAnimatEvents), False, False);
        end;
        inherited;
        Exit;
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
              Repaint;
          end;
          Exit;
        end;

      WM_KILLFOCUS, CM_EXIT:
        if not (csDesigning in ComponentState) then
          if Enabled then begin
            StopTimer(SkinData);
            SetRedraw(Handle);
            inherited;
            SetRedraw(Handle, 1);
            FCommonData.FFocused := False;
            FCommonData.FMouseAbove := False;
            FCommonData.Invalidate;
            Exit
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
              if FCommonData.FUpdating or FCommonData.HalfVisible then
                if not (csDesigning in ComponentState) and not InUpdating(FCommonData, True) then
                  Repaint;
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

        CM_CHANGED:
          if not (csDesigning in ComponentState) and TimerIsActive(SkinData) then
            DoChangePaint(FCommonData, PaintCtrlState, UpdateWindow_CB, EventEnabled(aeMouseUp, FAnimatEvents), False)
          else
            FCommonData.Invalidate;

        BM_SETCHECK: begin
          StopTimer(SkinData);
          State := sConst.CheckBoxStates[Message.WParam];
          Repaint;
          Exit;
        end;

        WM_ERASEBKGND: begin
          if (TWMPaint(Message).DC <> 0) and (Skindata.FCacheBmp <> nil) and not FCommonData.BGChanged and not TimerIsActive(SkinData) then
            CopyWinControlCache(Self, FCommonData, MkRect, MkRect(Self), TWMPaint(Message).DC, False);

          Message.Result := 1;
          Exit;
        end;

        WM_PRINT: begin
          SkinData.FUpdating := False;
          PaintHandler(TWMPaint(Message));
          Exit;
        end;

        WM_PAINT: begin
          PaintHandler(TWMPaint(Message));
          if not (csDesigning in ComponentState) then
            Exit;
        end;

        CM_FONTCHANGED, CM_TEXTCHANGED: begin
          if AutoSize then
            AdjustSize;

          Repaint;
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
              DoChangePaint(FCommonData, 2, UpdateWindow_CB, EventEnabled(aeMouseDown, FAnimatEvents), True);
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
          if not (csDesigning in ComponentState) and Enabled and (TWMKey(Message).CharCode = VK_SPACE) then begin
            if not ReadOnly then begin
              if FPressed then begin
                FPressed := False;
                Toggle;
              end;
              if Assigned(OnKeyUp) then
                OnKeyUp(Self, TWMKey(Message).CharCode, KeysToShiftState(TWMKey(Message).KeyData));

              if TimerIsActive(SkinData) and (Width <> SkinData.FCacheBmp.Width) then begin // Repaint after animation if size of control is changed
                StopTimer(SkinData);
                Repaint;
              end;
            end;
            Exit;
          end;

        WM_LBUTTONUP:
          if not (csDesigning in ComponentState) and Enabled then begin
            if not ReadOnly then begin
              if FPressed then begin
                FPressed := False;
                Toggle;
              end
              else
                FPressed := False;

              if Assigned(OnMouseUp) then
                OnMouseUp(Self, mbLeft, KeysToShiftState(TWMMouse(Message).Keys), TWMMouse(Message).XPos, TWMMouse(Message).YPos);

              if TimerIsActive(SkinData) and (Width <> SkinData.FCacheBmp.Width) then begin // Repaint after animation if size of control is changed
                StopTimer(SkinData);
                Repaint;
              end;
            end;
            Exit;
          end;
      end
    else
      case Message.Msg of
        WM_KEYDOWN, WM_LBUTTONDOWN:
          FPressed := True;

        WM_KEYUP, WM_LBUTTONUP:
          FPressed := False;

        WM_LBUTTONDBLCLK:
          if ReadOnly then
            Exit;

        BM_SETSTATE, BM_SETCHECK:
          if not (csCreating in ControlState) and FPressed and ReadOnly then
            Exit;
      end;

    inherited;
  end;
end;


procedure TsCheckBox.SetVerticalAlign(const Value: TvaAlign);
begin
  if FVerticalAlign <> Value then begin
    FVerticalAlign := Value;
    Repaint;
  end;
end;


function TsCheckBox.PaintCtrlState: integer;
begin
  if FPressed then
    Result := 2
  else
    Result := integer(ControlIsActive(FCommonData) and not ReadOnly);
end;

end.

