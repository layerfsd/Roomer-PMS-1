unit sUpDown;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ComCtrls, 
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  sConst, sDefaults;


type
{$IFNDEF NOTFORHELP}
  TsDrawingState = (dsDefault, dsPrevUp, dsNextUp, dsPrevDown, dsNextDown);
{$ENDIF} // NOTFORHELP


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsUpDown = class(TCustomUpDown)
{$IFNDEF NOTFORHELP}
  private
    FShowInaccessibility: boolean;
    FDisabledKind: TsDisabledKind;
    FDrawingState: TsDrawingState;
    FButtonSkin: TsSkinSection;
    procedure SetShowInaccessibility(const Value: boolean);
    procedure SetDisabledKind(const Value: TsDisabledKind);
    procedure SetDrawingState(const Value: TsDrawingState);
    procedure SetSkinSection(const Value: TsSkinSection);
  protected
    Pressed: boolean;
    function BtnRect: TRect;
    procedure WndProc(var Message: TMessage); override;
  public
    procedure DrawBtn(Btn: TBitmap; Side: TacSide);
    constructor Create(AOwner: TComponent); override;
    property DrawingState: TsDrawingState read FDrawingState write SetDrawingState default dsDefault;
  published
    property Align;
    property AlignButton;
    property Anchors;
    property Associate;
    property ArrowKeys;
    property Enabled;
    property Hint;
    property Min;
    property Max;
    property Increment;
    property Constraints;
    property Orientation;
    property ParentShowHint;
    property PopupMenu;
    property Position;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Thousands;
    property Visible;
    property Wrap;
    property OnChanging;
    property OnChangingEx;
    property OnContextPopup;
    property OnClick;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
{$ENDIF} // NOTFORHELP
    property ButtonSkin: TsSkinSection read FButtonSkin write SetSkinSection;
    property DisabledKind: TsDisabledKind read FDisabledKind write SetDisabledKind default DefDisabledKind;
    property ShowInaccessibility: boolean read FShowInaccessibility write SetShowInaccessibility default True;
  end;


implementation

uses
  math,
  {$IFDEF LOGGED}sDebugMsgs, {$ENDIF}
  sStyleSimply, sPageControl, sMessages, sGraphUtils, sSkinProps, acntUtils,
  sAlphaGraph, sSkinManager, sCommonData, sVCLUtils, sMaskData;


function TsUpDown.BtnRect: TRect;
begin
  if Orientation = udVertical then
    Result := MkRect(Width, Height div 2)
  else
    Result := MkRect(Width div 2, Height);
end;


constructor TsUpDown.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Pressed := False;
  FDrawingState := dsDefault;
  FShowInaccessibility := True;
  FDisabledKind := DefDisabledKind;
  ControlStyle := ControlStyle - [csDoubleClicks];
end;


procedure TsUpDown.SetDisabledKind(const Value: TsDisabledKind);
begin
  if FDisabledKind <> Value then begin
    FDisabledKind := Value;
    Repaint;
  end;
end;


procedure TsUpDown.SetDrawingState(const Value: TsDrawingState);
begin
  if FDrawingState <> Value then begin
    FDrawingState := Value;
    Repaint;
  end;
end;


procedure TsUpDown.SetShowInaccessibility(const Value: boolean);
begin
  if FShowInaccessibility <> Value then begin
    FShowInaccessibility := Value;
    Repaint;
  end;
end;


procedure TsUpDown.WndProc(var Message: TMessage);
var
  PS: TPaintStruct;
  SaveIndex, DC: hdc;
  Btn: TBitmap;
  h: integer;
  R: TRect;
  p: TPoint;

  function BtnPrevDisabled: boolean;
  begin
    if Orientation = udVertical then
      Result := Position = Max
    else
      Result := Position = Min;
  end;

  function BtnNextDisabled: boolean;
  begin
    if Orientation = udVertical then
      Result := Position = Min
    else
      Result := Position = Max;
  end;

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

        AC_REMOVESKIN:
          if Message.LParam = LPARAM(DefaultManager) then begin
            Repaint;
            Exit;
          end;

        AC_REFRESH:
          if Message.LParam = LPARAM(DefaultManager) then begin
            Repaint;
            Exit;
          end
      end;

    WM_LBUTTONDBLCLK, WM_NCLBUTTONDBLCLK: begin
      inherited;
      Pressed := True;
      if (DrawingState = dsPrevUp) and (Position < Max) then
        DrawingState := dsPrevDown
      else
        if (DrawingState = dsNextUp) and (Position > Min) then
          DrawingState := dsNextDown;
    end;

    WM_NCHITTEST: begin
      inherited;
      if not (csDesigning in ComponentState) then begin
        R := BtnRect;
        p := ScreenToClient(Point(TWMMouse(Message).XPos, TWMMouse(Message).YPos));
        if PtInRect(R, p) then begin
          if (FShowInaccessibility and BtnPrevDisabled) then
            DrawingState := dsDefault
          else
            if (DrawingState <> dsPrevUp) and not Pressed then begin
              DrawingState := dsPrevUp;
              Repaint
            end
        end
        else
          if (FShowInaccessibility and BtnNextDisabled) then
            DrawingState := dsDefault
          else
            if (DrawingState <> dsNextUp) and not Pressed then begin
              DrawingState := dsNextUp;
              Repaint
            end
      end;
    end;

    WM_LBUTTONUP: begin
      inherited;
      if not (csDesigning in ComponentState) then 
        if Pressed then begin
          Pressed := False;
          if DrawingState = dsPrevDown then begin
            if (FShowInaccessibility and (Position = Max)) then
              Exit;

            DrawingState := dsPrevUp
          end
          else begin
            if (FShowInaccessibility and (Position = Min)) then
              Exit;

            DrawingState := dsNextUp;
          end;
          Message.Result := 1;
        end;
    end;

    WM_LBUTTONDOWN: begin
      inherited;
      if not (csDesigning in ComponentState) then begin
        Pressed := True;
        if (DrawingState = dsPrevUp) and (Position < Max) then
          DrawingState := dsPrevDown
        else
          if (DrawingState = dsNextUp) and (Position > Min) then
            DrawingState := dsNextDown;

        Message.Result := 1;
      end;
    end;

    CM_MOUSELEAVE: begin
      inherited;
      if not (csDesigning in ComponentState) then begin
        Pressed := False;
        DrawingState := dsDefault;
      end;
    end;

    WM_NCPAINT, WM_ERASEBKGND:
      if not Assigned(DefaultManager) or not DefaultManager.Active then
        inherited;

    WM_PRINT:
      SendMessage(Handle, WM_PAINT, Message.WParam, Message.LParam);

    WM_PAINT: begin
      if Assigned(DefaultManager) and DefaultManager.CommonSkinData.Active then
        with DefaultManager.ConstData do
          if Orientation = udVertical then
            if (Scrolls[asTop].SkinIndex >= 0) and (Scrolls[asBottom].SkinIndex >= 0) then begin
              DC := TWMPaint(Message).DC;
              if DC = 0 then
                DC := BeginPaint(Handle, PS);

              SaveIndex := SaveDC(DC);
              try
                h := Height div 2;
                Btn := CreateBmp32(Width, h);
                try
                  DrawBtn(Btn, asTop);
                  BitBlt(DC, 0, 0, Btn.Width, Btn.Height, Btn.Canvas.Handle, 0, 0, SRCCOPY);
                  DrawBtn(Btn, asBottom);
                  BitBlt(DC, 0, h, Btn.Width, Btn.Height, Btn.Canvas.Handle, 0, 0, SRCCOPY);
                finally
                  FreeAndNil(Btn);
                end;
              finally
                RestoreDC(DC, SaveIndex);
                if TWMPaint(Message).DC = 0 then
                  EndPaint(Handle, PS);
              end;
            end
            else
              inherited
          else
            if (Scrolls[asLeft].SkinIndex >= 0) and (Scrolls[asRight].SkinIndex >= 0) then begin
              DC := TWMPaint(Message).DC;
              if DC = 0 then
                DC := BeginPaint(Handle, PS);

              SaveIndex := SaveDC(DC);
              try
                h := Width div 2;
                Btn := CreateBmp32(h, Height);
                try
                  DrawBtn(Btn, asLeft);
                  BitBlt(DC, 0, 0, Btn.Width, Btn.Height, Btn.Canvas.Handle, 0, 0, SRCCOPY);
                  DrawBtn(Btn, asRight);
                  BitBlt(DC, h, 0, Btn.Width, Btn.Height, Btn.Canvas.Handle, 0, 0, SRCCOPY);
                finally
                  FreeAndNil(Btn);
                end;
              finally
                RestoreDC(DC, SaveIndex);
                if TWMPaint(Message).DC = 0 then
                  EndPaint(Handle, PS);
              end;
            end
            else
              inherited
      else
        inherited;
    end
    else
      inherited;
  end;
end;


procedure TsUpDown.SetSkinSection(const Value: TsSkinSection);
begin
  if FButtonSkin <> Value then begin
    FButtonSkin := Value;
    Invalidate;
  end;
end;


procedure TsUpDown.DrawBtn(Btn: TBitmap; Side: TacSide);
var
  CI: TCacheInfo;
  p: TPoint;
  State: integer;
  c: TsColor;
  R: TRect;
  sSkinIndex, sArrowMask, sLimPosition, XOffset, YOffset: integer;
  sSkinSection: string;
  SkinManager: TsSkinManager;
begin
  if Parent is TsPageControl then begin
    SkinManager := TsPageControl(Parent).SkinData.SkinManager;
    CI.Ready := False;
  end
  else begin
    SkinManager := DefaultManager;
    CI := GetParentCacheHwnd(Handle);
  end;
  if Assigned(SkinManager) then begin
    with SkinManager.ConstData do begin
      if ButtonSkin <> '' then begin
        sSkinSection := ButtonSkin;
        sSkinIndex := SkinManager.GetSkinIndex(sSkinSection);
      end
      else begin
        sSkinIndex   := Scrolls[asTop].SkinIndex;
        sSkinSection := Scrolls[asTop].SkinSection;
      end;
      sArrowMask := Scrolls[Side].GlyphIndex;

      if Side in [asTop, asLeft] then begin
        case DrawingState of
          dsPrevUp:   State := 1;
          dsPrevDown: State := 2
          else        State := 0;
        end;
        sLimPosition := iff(Side = asTop, Max, Min);
      end
      else begin
        case DrawingState of
          dsNextUp:   State := 1;
          dsNextDown: State := 2
          else        State := 0;
        end;
        sLimPosition := iff(Side = asBottom, Min, Max);
      end;

      XOffset := 0;
      YOffset := 0;
      case Side of
        asBottom: begin
          Btn.Height := Height - Btn.Height;
          YOffset    := Height - Btn.Height;
        end;

        asRight: begin
          Btn.Width := Width - Btn.Width;
          XOffset   := Width - Btn.Width;
        end;
      end;
      if Assigned(SkinManager) then begin
        R := MkRect(Btn.Width, Btn.Height);
        CI := GetParentCacheHwnd(Handle);
        PaintItem(sSkinIndex, CI, True, State, R, Point(Left + XOffset, Top + YOffset), Btn, SkinManager);
      end;
      Ci.Bmp := Btn;
      CI.Ready := True;
      if (sArrowMask >= 0) then begin
        if SkinManager.ma[sArrowMask].Bmp = nil then begin
          p.x := (Btn.Width  - WidthOfImage (SkinManager.ma[sArrowMask])) div 2;
          p.y := (Btn.Height - HeightOfImage(SkinManager.ma[sArrowMask])) div 2;
        end
        else
          if (SkinManager.ma[sArrowMask].Bmp.Height div 2 < Btn.Height) then begin
            p.x := (Btn.Width  - SkinManager.ma[sArrowMask].Bmp.Width  div 3) div 2;
            p.y := (Btn.Height - SkinManager.ma[sArrowMask].Bmp.Height div 2) div 2;
          end;

        if (p.x < 0) or (p.y < 0) then
          Exit;

        DrawSkinGlyph(Btn, p, State, 1, SkinManager.ma[sArrowMask], CI);
      end
      else begin
        sArrowMask := GetFontIndex(Self, sSkinIndex, SkinManager, State); // Receive parent font if needed
        R := MkRect(Btn.Width, Btn.Height);
        if State = 2 then
          if {CanOffset and }({not SkinData.Skinned or }(SkinManager <> nil) and SkinManager.ButtonsOptions.ShiftContentOnClick) then
            OffsetRect(R, 1, 1);

        if sArrowMask >= 0 then
          DrawColorArrow(Btn.Canvas, SkinManager.gd[sArrowMask].Props[math.min(integer(State > 0), SkinManager.gd[sArrowMask].States - 1)].FontColor.Color, R, Side)
        else
          DrawColorArrow(Btn.Canvas, Font.Color, R, Side);
      end;

      if not Enabled or (FShowInaccessibility and (Position = sLimPosition)) then begin
        CI := GetParentCacheHwnd(Handle);
        if not CI.Ready then begin
          c.C := ColorToRGB(TsHackedControl(Parent).Color);
          FadeBmp(Btn, MkRect(Btn.Width + 1, Btn.Height + 1), 60, c, 0, 0);
        end
        else
          BmpDisabledKind(Btn, FDisabledKind, Parent, CI, Point(Left + XOffset, Top + YOffset));
      end;
    end;
  end;
end;

end.
