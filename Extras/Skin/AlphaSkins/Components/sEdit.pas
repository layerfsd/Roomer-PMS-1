unit sEdit;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls,
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  {$IFDEF TNTUNICODE} TntControls, TntActnList, TntStdCtrls, TntClasses, {$ENDIF}
  sCommonData, sConst, sDefaults;


type
{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
{$IFDEF TNTUNICODE}
  TsEdit = class(TTntEdit)
{$ELSE}
  TsEdit = class(TEdit)
{$ENDIF}
{$IFNDEF NOTFORHELP}
  private
    FCommonData: TsCtrlSkinData;
    FDisabledKind: TsDisabledKind;
    FBoundLabel: TsBoundLabel;
    procedure SetDisabledKind(const Value: TsDisabledKind);
  protected
    procedure PaintBorder;
    function PrepareCache: boolean; virtual;
    procedure PaintText; virtual;
    procedure OurPaintHandler(aDC: hdc = 0);
    procedure ExcludeChildControls(DC: hdc); virtual;
  public
    procedure AfterConstruction; override;
    constructor Create(AOwner: TComponent); override;
    procedure CreateParams(var Params: TCreateParams); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure WndProc(var Message: TMessage); override;
  published
    property Align;
{$ENDIF} // NOTFORHELP
    property DisabledKind: TsDisabledKind read FDisabledKind write SetDisabledKind default DefDisabledKind;
    property SkinData: TsCtrlSkinData read FCommonData write FCommonData;
    property BoundLabel: TsBoundLabel read FBoundLabel write FBoundLabel;
  end;


implementation

uses sStyleSimply, sVCLUtils, sMessages, sGraphUtils, sAlphaGraph, acntUtils;


procedure TsEdit.AfterConstruction;
begin
  inherited AfterConstruction;
  FCommonData.Loaded;
end;


constructor TsEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCommonData := TsCtrlSkinData.Create(Self, True);
  FCommonData.COC := COC_TsEdit;
  FDisabledKind := DefDisabledKind;
  FBoundLabel := TsBoundLabel.Create(Self, FCommonData);
end;


destructor TsEdit.Destroy;
begin
  FreeAndNil(FBoundLabel);
  if Assigned(FCommonData) then
    FreeAndNil(FCommonData);

  inherited Destroy;
end;


procedure TsEdit.Loaded;
begin
  inherited Loaded;
  FCommonData.Loaded;
end;


procedure TsEdit.OurPaintHandler(aDC: hdc = 0);
var
  DC, SavedDC: hdc;
  PS: TPaintStruct;
begin
  if not InAnimationProcess then
    BeginPaint(Handle, PS);

  if not InUpdating(FCommonData) then begin
    SavedDC := 0;
    if aDC = 0 then begin
      DC := GetWindowDC(Handle);
      SavedDC := SaveDC(DC);
    end
    else
      DC := aDC;

    try
      FCommonData.BGChanged := FCommonData.BGChanged or FCommonData.HalfVisible or GetBoolMsg(Parent, AC_GETHALFVISIBLE);
      FCommonData.HalfVisible := not RectInRect(Parent.ClientRect, BoundsRect);
      if not FCommonData.BGChanged or PrepareCache then begin
        UpdateCorners(FCommonData, 0);
        ExcludeChildControls(DC);
        BitBlt(DC, 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
      end
      else
        FCommonData.FUpdating := True;
    finally
      if aDC = 0 then begin
        RestoreDC(DC, SavedDC);
        ReleaseDC(Handle, DC);
      end;
    end;
  end;
  if not InAnimationProcess then
    EndPaint(Handle, PS);
end;


function TsEdit.PrepareCache: boolean;
var
  BGInfo: TacBGInfo;
begin
  Result := False;
  BGInfo.BgType := btUnknown;
  GetBGInfo(@BGInfo, Parent);
  if BGInfo.BgType <> btNotReady then begin
    InitCacheBmp(SkinData);
    if BorderStyle = bsSingle then
      PaintItem(FCommonData, BGInfoToCI(@BGInfo), True, integer(ControlIsActive(FCommonData)), MkRect(Self), Point(Left, top), FCommonData.FCacheBmp, False)
    else
      PaintItemBG(FCommonData, BGInfoToCI(@BGInfo), integer(ControlIsActive(FCommonData)), MkRect(Self), Point(Left, top), FCommonData.FCacheBmp);

    PaintText;
    if not Enabled then
      BmpDisabledKind(FCommonData.FCacheBmp, FDisabledKind, Parent, BGInfoToCI(@BGInfo), Point(Left, Top));

    FCommonData.BGChanged := False;
    Result := True;
  end;
end;


procedure TsEdit.PaintBorder;
var
  DC, SavedDC: HDC;
  BordWidth: integer;
begin
  if not InUpdating(FCommonData) then begin
    DC := GetWindowDC(Handle);
    SavedDC := SaveDC(DC);
    try
      if FCommonData.BGChanged then
        if not PrepareCache then begin
          RestoreDC(DC, SavedDC);
          ReleaseDC(Handle, DC);
          FCommonData.FUpdating := True;
          Exit;
        end;

      BordWidth := integer(BorderStyle <> bsNone) * (1 + integer(Ctl3d));
{$IFDEF DELPHI7UP}
      if BordWidth = 0 then begin
        if BevelInner <> bvNone then
          inc(BordWidth);

        if BevelOuter <> bvNone then
          inc(BordWidth);
      end;
{$ENDIF}
      UpdateCorners(FCommonData, 0);
      BitBltBorder(DC, 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, BordWidth);
{$IFDEF DYNAMICCACHE}
      if Assigned(FCommonData.FCacheBmp) then
        FreeAndNil(FCommonData.FCacheBmp);
{$ENDIF}
    finally
      RestoreDC(DC, SavedDC);
      ReleaseDC(Handle, DC);
    end;
  end;
end;


procedure TsEdit.PaintText;
var
  R: TRect;
  pc: acChar;
  s: acString;
  Flags: Cardinal;
  i, iSingle, BordWidth: integer;
begin
  FCommonData.FCacheBMP.Canvas.Font.Assign(Font);
  if BorderStyle <> bsNone then begin
    BordWidth := 1 + integer(Ctl3D);
    BordWidth := BordWidth {$IFDEF DELPHI7UP} + integer(BevelKind <> bkNone) * (integer(BevelOuter <> bvNone) + integer(BevelInner <> bvNone)) {$ENDIF};
  end
  else
    BordWidth := 0;

  Flags := DT_TOP or DT_NOPREFIX or DT_SINGLELINE;
  iSingle := integer(BorderStyle = bsSingle);
  R := Rect(BordWidth + iSingle, BordWidth + iSingle, Width - BordWidth - iSingle, Height - BordWidth);
{$IFNDEF D2009}
  if Self.IsRightToLeft then begin
    Flags := Flags or DT_RTLREADING or DT_RIGHT;
    dec(R.Right);
  end;
{$ENDIF}
  if Text <> '' then begin
    if (PasswordChar <> #0) then begin
{$IFDEF D2009}
      if PasswordChar = '*' then
        pc := #9679
      else
{$ENDIF}
        pc := PasswordChar;

      for i := 1 to Length(Text) do
        s := s + pc;
    end
    else
      s := Text;

    acWriteTextEx(FCommonData.FCacheBMP.Canvas, PacChar(s), True, R,
                  Flags {$IFDEF D2009}or Cardinal(GetStringFlags(Self, Alignment)) and not DT_VCENTER{$ENDIF},
                  FCommonData, ControlIsActive(FCommonData));
  end
{$IFDEF D2009}
  else
    if (TextHint <> '') then begin
      FCommonData.FCacheBMP.Canvas.Brush.Style := bsClear;
      if FCommonData.Skinned then
        FCommonData.FCacheBMP.Canvas.Font.Color := MixColors(ColorToRGB(Font.Color), ColorToRGB(Color), 0.65)
      else
        FCommonData.FCacheBMP.Canvas.Font.Color := clGrayText;

      acDrawText(FCommonData.FCacheBMP.Canvas.Handle, TextHint, R, Flags {$IFDEF D2009}or Cardinal(GetStringFlags(Self, Alignment)) and not DT_VCENTER{$ENDIF});
    end;
{$ENDIF}
end;


procedure TsEdit.SetDisabledKind(const Value: TsDisabledKind);
begin
  if FDisabledKind <> Value then begin
    FDisabledKind := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsEdit.WndProc(var Message: TMessage);
var
  DC: hdc;
  bw: integer;
  PS: TPaintStruct;
begin
{$IFDEF LOGGED}
  AddToLog(Message, IntToStr(Color));
{$ENDIF}
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_REMOVESKIN:
          if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
            CommonWndProc(Message, FCommonData);
            Exit;
          end;

        AC_REFRESH:
          if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
            CommonWndProc(Message, FCommonData);
            if not InAnimationProcess and HandleAllocated and Visible then
              RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_ERASE or RDW_FRAME);

            Exit;
          end;

        AC_SETNEWSKIN:
          if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
            CommonWndProc(Message, FCommonData);
            Exit;
          end;

        AC_CHILDCHANGED: begin
          Message.LParam := 0; // Internal buttons not required in the repainting
          Exit;
        end;

        AC_GETCONTROLCOLOR:
          if not FCommonData.Skinned then begin
            Message.Result := ColorToRGB(Color);
            Exit;
          end;

        AC_GETDEFINDEX: begin
          if FCommonData.SkinManager <> nil then
            Message.Result := FCommonData.SkinManager.ConstData.Sections[ssEdit] + 1;

          Exit;
        end

        else
          if CommonMessage(Message, SkinData) then
            Exit;
      end;
  end;

  if not ControlIsReady(Self) or not FCommonData.Skinned then
    inherited
  else begin
    case Message.Msg of
      WM_ERASEBKGND, CN_DRAWITEM: begin
        if not InAnimationProcess and not InUpdating(SkinData) and Enabled then
          inherited;

        Exit;
      end;

      WM_NCPAINT: begin
        PaintBorder;
        Exit;
      end;

      WM_PAINT: begin
        if InAnimationProcess or InUpdating(SkinData) then begin // Exit if parent is not ready yet
          BeginPaint(Handle, PS);
          EndPaint(Handle, PS);
          Exit;
        end;
        if not (Enabled and TWinControl(FCommonData.FOwnerControl).Focused) then begin
          OurPaintHandler(TWMPaint(Message).DC);
          if csDesigning in ComponentState then
            inherited;

          Exit;
        end
      end;

      WM_PRINT: begin
        SkinData.Updating := False;
        DC := TWMPaint(Message).DC;
        PrepareCache;
        UpdateCorners(SkinData, 0);
        bw := integer(BorderStyle <> bsNone) * (1 + integer(Ctl3d));
        if PRF_CLIENT and Message.LParam = PRF_CLIENT then begin
          MoveWindowOrg(DC, -bw, -bw);
          IntersectClipRect(DC, 0, 0, SkinData.FCacheBmp.Width - bw, SkinData.FCacheBmp.Height - bw);
        end
        else
          BitBltBorder(DC, 0, 0, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, bw);

        OurPaintHandler(DC);
        Exit;
      end;
      
      CM_COLORCHANGED:
        if FCommonData.CustomColor then
          FCommonData.BGChanged := True;
    end;
    if CommonWndProc(Message, FCommonData) then
      Exit;

    inherited;
    case Message.Msg of
      SM_ALPHACMD:
        case Message.WParamHi of
          AC_ENDPARENTUPDATE:
            if SkinData.FUpdating then
              if not InUpdating(FCommonData, True) then begin
                Repaint;
                SendMessage(Handle, WM_NCPAINT, 0, 0);
              end;

        end;

      WM_SETTEXT, CM_TEXTCHANGED, CM_VISIBLECHANGED, CM_ENABLEDCHANGED, WM_SETFONT:
        if not (csLoading in ComponentState) and not InAnimationProcess then begin
          FCommonData.BGChanged := True;
          Repaint;
          SendMessage(Handle, WM_NCPAINT, 0, 0);
        end;

      WM_SIZE:
        SendMessage(Handle, WM_NCPAINT, 0, 0);
    end;
  end;

  if Assigned(BoundLabel) then
    BoundLabel.HandleOwnerMsg(Message, Self);
end;


procedure TsEdit.CreateParams(var Params: TCreateParams);
begin
  inherited;
//  Params.ExStyle := Params.ExStyle or WS_EX_TRANSPARENT;
end;


procedure TsEdit.ExcludeChildControls;
var
  i, bw: integer;
begin
  if ControlCount <> 0 then begin
    bw := integer(BorderStyle <> bsNone) * (2 + integer(Ctl3d)) - 1;
    for i := 0 to ControlCount - 1 do
      ExcludeClipRect(DC, Controls[i].Left + bw, Controls[i].Top + bw, Controls[i].BoundsRect.Right + bw, Controls[i].BoundsRect.Bottom + bw);
  end;
end;

end.
