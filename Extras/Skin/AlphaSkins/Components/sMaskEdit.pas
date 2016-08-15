unit sMaskEdit;
{$I sDefs.inc}
//{$DEFINE LOGGED}
//+
interface


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, Mask,
  {$IFNDEF DELPHI5} types, {$ENDIF}
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  sCommonData, sConst, sDefaults;

type
  TValidateErrorEvent = procedure(Sender: TObject; Text: string) of object;
  
{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsMaskEdit = class(TMaskEdit)
{$IFNDEF NOTFORHELP}
  private
    FCheckOnExit: Boolean;
    FBoundLabel: TsBoundLabel;
    FCommonData: TsCtrlSkinData;
    FDisabledKind: TsDisabledKind;
    FOnValidateError: TValidateErrorEvent;
    procedure SetDisabledKind(const Value: TsDisabledKind);
  protected
    procedure SetEditRect; virtual;
    procedure Change; override;
    procedure PaintBorder(DC: hdc); virtual;
    function PrepareCache: boolean;
    procedure PaintText; virtual;
    procedure OurPaintHandler(aDC: hdc = 0); virtual;
    procedure ExcludeChildControls(DC: hdc);
    function BorderWidth: integer;
  public
    procedure AfterConstruction; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ValidateEdit; override;
    procedure Loaded; override;
    procedure WndProc(var Message: TMessage); override;
  published
    property Align;
{$ENDIF} // NOTFORHELP
    property CheckOnExit: Boolean read FCheckOnExit write FCheckOnExit;
    property BoundLabel: TsBoundLabel read FBoundLabel write FBoundLabel;
    property DisabledKind: TsDisabledKind read FDisabledKind write SetDisabledKind default DefDisabledKind;
    property SkinData: TsCtrlSkinData read FCommonData write FCommonData;
{$IFDEF D2005}
    property OnMouseActivate;
{$ENDIF}
{$IFDEF D2009}
    property TextHint;
    property ParentDoubleBuffered;
    property OnMouseEnter;
    property OnMouseLeave;
{$ENDIF}
    property OnValidateError: TValidateErrorEvent read FOnValidateError write FOnValidateError;
{$IFDEF D2010}
    property Touch;
    property OnGesture;
{$ENDIF}
  end;


implementation

uses sStyleSimply, sVCLUtils, sMessages, acntUtils, sGraphUtils, sAlphaGraph, sSkinProps, sEdit;


procedure TsMaskEdit.AfterConstruction;
begin
  inherited AfterConstruction;
  FCommonData.Loaded;
end;


constructor TsMaskEdit.Create(AOwner: TComponent);
begin
  FCommonData := TsCtrlSkinData.Create(Self, True);
  FCommonData.COC := COC_TsEdit;
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csSetCaption];
  FCheckOnExit := True;
  FDisabledKind := DefDisabledKind;
  FBoundLabel := TsBoundLabel.Create(Self, FCommonData);
end;


destructor TsMaskEdit.Destroy;
begin
  FreeAndNil(FBoundLabel);
  FreeAndNil(FCommonData);
  inherited Destroy;
end;


procedure TsMaskEdit.Loaded;
begin
  inherited Loaded;
  FCommonData.Loaded;
end;


procedure TsMaskEdit.OurPaintHandler(aDC: hdc = 0);
var
  DC, SavedDC: hdc;
  PS: TPaintStruct;
begin
  if not InAnimationProcess or (aDC = 0) then
    BeginPaint(Handle, PS);

  SavedDC := 0;
  if aDC = 0 then begin
    DC := GetWindowDC(Handle);
    SavedDC := SaveDC(DC);
  end
  else
    DC := aDC;

  try
    if not InUpdating(FCommonData) then begin
      FCommonData.BGChanged := FCommonData.BGChanged or FCommonData.HalfVisible or GetBoolMsg(Parent, AC_GETHALFVISIBLE);
      FCommonData.HalfVisible := not RectInRect(Parent.ClientRect, BoundsRect);
      if FCommonData.BGChanged then
        if not PrepareCache then begin
          if aDC = 0 then begin
            RestoreDC(DC, SavedDC);
            ReleaseDC(Handle, DC);
          end;
          if not InAnimationProcess then
            EndPaint(Handle, PS);

          FCommonData.FUpdating := True;
          Exit;
        end;

      UpdateCorners(FCommonData, 0);
      ExcludeChildControls(DC);
      BitBlt(DC, 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
    end;
  finally
    if aDC = 0 then begin
      RestoreDC(DC, SavedDC);
      ReleaseDC(Handle, DC);
    end;
    if not InAnimationProcess or (aDC = 0) then
      EndPaint(Handle, PS);
  end;
end;


procedure TsMaskEdit.PaintBorder(DC: hdc);
const
  BordWidth = 2;
var
  NewDC, SavedDC: HDC;
begin
  if Assigned(Parent) and Visible and Parent.Visible and not (csCreating in ControlState) and (BorderStyle <> bsNone) then
    if not InUpdating(SkinData) then begin
      if DC = 0 then
        NewDC := GetWindowDC(Handle)
      else
        NewDC := DC;

      SavedDC := SaveDC(NewDC);
      try
        if FCommonData.BGChanged then
          PrepareCache;

        UpdateCorners(FCommonData, 0);
        BitBltBorder(NewDC, 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, BordWidth);
      finally
        RestoreDC(NewDC, SavedDC);
        if DC = 0 then
          ReleaseDC(Handle, NewDC);
      end;
    end;
end;


procedure TsMaskEdit.PaintText;
var
  R: TRect;
  bw: integer;
  aText: acString;
begin
  aText := EditText;
  if aText = '' then begin
{$IFDEF D2009}
    if TextHint <> '' then begin
      FCommonData.FCacheBMP.Canvas.Font.Assign(Font);
      bw := BorderWidth;
      R := Rect(bw, bw, Width - bw, bw + acTextHeight(FCommonData.FCacheBMP.Canvas, TextHint) + 2);
      if FCommonData.Skinned then
        FCommonData.FCacheBMP.Canvas.Font.Color := BlendColors(ColorToRGB(Font.Color), ColorToRGB(Color), 167)
      else
        FCommonData.FCacheBMP.Canvas.Font.Color := clGrayText;

      acDrawText(FCommonData.FCacheBMP.Canvas.Handle, TextHint, R, DT_NOPREFIX or DT_TOP or DT_EXTERNALLEADING or GetStringFlags(Self, {$IFDEF D2009}Alignment{$ELSE}taLeftJustify{$ENDIF}));
    end
    else
{$ENDIF}
      Exit;
  end;
  FCommonData.FCacheBMP.Canvas.Font.Assign(Font);
  bw := BorderWidth;
  R := Rect(bw, bw, Width - bw, bw + acTextHeight(FCommonData.FCacheBMP.Canvas, aText) + 2);
  if PasswordChar = #0 then
    acWriteTextEx(FCommonData.FCacheBMP.Canvas, PacChar(aText), True, R,
                  DT_NOPREFIX or DT_TOP or DT_EXTERNALLEADING or GetStringFlags(Self, {$IFDEF D2009}Alignment{$ELSE}taLeftJustify{$ENDIF}),
                  FCommonData, ControlIsActive(FCommonData))
  else begin
    acFillString(aText, Length(aText), acChar(PasswordChar));
    acWriteTextEx(FCommonData.FCacheBMP.Canvas, PacChar(aText), True, R, DT_NOPREFIX or DT_TOP or GetStringFlags(Self, {$IFDEF D2009}Alignment{$ELSE}taLeftJustify{$ENDIF}), FCommonData, ControlIsActive(FCommonData));
  end;
end;


function TsMaskEdit.PrepareCache: boolean;
var
  BGInfo: TacBGInfo;
begin
  Result := False;
  BGInfo.BgType := btUnknown;
  GetBGInfo(@BGInfo, Parent);
  if BGInfo.BgType <> btNotReady then begin
    InitCacheBmp(SkinData);
    if SkinData.Skinned then begin
      if BorderStyle = bsSingle then
        PaintItem(FCommonData, BGInfoToCI(@BGInfo), True, integer(ControlIsActive(FCommonData)), MkRect(Self), Point(Left, top), FCommonData.FCacheBmp, False)
      else
        PaintItemBG(FCommonData, BGInfoToCI(@BGInfo), 0, MkRect(Self), Point(Left, top), FCommonData.FCacheBmp, 0, 0);

      PaintText;
      if not Enabled then
        BmpDisabledKind(FCommonData.FCacheBmp, FDisabledKind, Parent, BGInfoToCI(@BGInfo), Point(Left, Top));

      SkinData.BGChanged := False;
    end
    else begin
      FillDC(FCommonData.FCacheBmp.Canvas.Handle, MkRect(Self), Color);
      PaintText;
    end;
    Result := True;
  end;
end;


procedure TsMaskEdit.SetDisabledKind(const Value: TsDisabledKind);
begin
  if FDisabledKind <> Value then begin
    FDisabledKind := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsMaskEdit.WndProc(var Message: TMessage);
var
  PS: TPaintStruct;
  DC, SavedDC: hdc;
  i, bw: integer;
  b: boolean;
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  if Message.Msg = SM_ALPHACMD then
    case Message.WParamHi of
      AC_SETSCALE: begin
        if BoundLabel <> nil then BoundLabel.UpdateScale(Message.LParam);
        Exit;
      end;

      AC_CTRLHANDLED: begin
        Message.Result := 1;
        Exit;
      end; // AlphaSkins supported

      AC_SETNEWSKIN:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          CommonMessage(Message, FCommonData);
          Exit;
        end;

      AC_REFRESH:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          CommonMessage(Message, FCommonData);
          if HandleAllocated then
            SendMessage(Handle, WM_NCPaint, 0, 0);

          Repaint;
          Exit;
        end;

      AC_REMOVESKIN:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          CommonMessage(Message, FCommonData);
          Invalidate;
          Exit
        end;

      AC_ENDPARENTUPDATE:
        if FCommonData.Updating then begin
          FCommonData.Updating := False;
          InvalidateRect(Handle, nil, True);
          SendMessage(Handle, WM_NCPAINT, 0, 0);
          Exit;
        end;

      AC_GETDEFINDEX: begin
        if FCommonData.SkinManager <> nil then
          Message.Result := FCommonData.SkinManager.ConstData.Sections[ssEdit] + 1;

        Exit;
      end;
    end;

  if (FCommonData = nil) or not FCommonData.Skinned or not ControlIsReady(Self) then
    case Message.Msg of
      WM_PRINT: begin
        PaintTo(TWMPaint(Message).DC, 0, 0);
        Exit;
      end;

      WM_PAINT: begin
        if not Focused then begin
          b := False;
          for i := 0 to ControlCount - 1 do // Search buttons
            if Controls[i] is TGraphicControl then begin
              b := True;
              Break;
            end;

          BeginPaint(Handle, PS);
          PrepareCache;
          bw := integer(BorderStyle <> bsNone) * 2;
          with SkinData.FCacheBmp do
            if b then // If buttons exists
              for i := 0 to ControlCount - 1 do
                if Controls[i] is TGraphicControl then begin
                  SavedDC := SaveDC(Canvas.Handle);
                  MoveWindowOrg(Canvas.Handle, Controls[i].Left + bw, Controls[i].Top + bw);
                  TGraphicControl(Controls[i]).Perform(WM_PAINT, WPARAM(Canvas.Handle), 0);
                  RestoreDC(Canvas.Handle, SavedDC);
                end;

          DC := GetWindowDC(Handle);
          BitBlt(DC, bw, bw, SkinData.FCacheBmp.Width - 2 * bw, SkinData.FCacheBmp.Height - 2 * bw, SkinData.FCacheBmp.Canvas.Handle, bw, bw, SRCCOPY);
          ReleaseDC(Handle, DC);
          EndPaint(Handle, PS);
          if not (Enabled and ControlIsActive(FCommonData)) and (csDesigning in ComponentState) then
            inherited;
        end
        else
          inherited;
      end

      else
        inherited
    end
  else begin
    case Message.Msg of
      WM_ERASEBKGND, CN_DRAWITEM: begin
        if not InAnimationProcess and not InUpdating(SkinData) then
          inherited;
          
        Exit;
      end;

      WM_NCPAINT: begin
        if not InAnimationProcess and not InUpdating(SkinData) then begin
          DC := GetWindowDC(Handle);
          SavedDC := SaveDC(DC);
          try
            PaintBorder(DC);
          finally
            RestoreDC(DC, SavedDC);
            ReleaseDC(Handle, DC);
          end;
        end;
        Exit;
      end;

      WM_PRINT: begin
        SkinData.Updating := False;
        DC := TWMPaint(Message).DC;
        if SkinData.BGChanged then
          PrepareCache;

        UpdateCorners(SkinData, 0);
        bw := BorderWidth;
        OurPaintHandler(DC);
        BitBltBorder(DC, 0, 0, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, bw);
        Exit;
      end;

      WM_PAINT: begin
        if not Focused {ControlIsActive(SkinData)} then begin
          OurPaintHandler(TWMPaint(Message).DC);
          if not (Enabled and ControlIsActive(FCommonData)) and (csDesigning in ComponentState) then
            inherited;
        end
        else begin
          inherited;
          PaintBorder(0);
        end;
        Exit;
      end;

      CM_COLORCHANGED, CM_CHANGED:
        FCommonData.BGChanged := True;

      WM_SETTEXT:
//        if csDesigning in ComponentState then
          FCommonData.BGChanged := True;
    end;
    if CommonWndProc(Message, FCommonData) then
      Exit;

    inherited;
    case Message.Msg of
      CM_VISIBLECHANGED, CM_ENABLEDCHANGED, WM_SETFONT:
        FCommonData.Invalidate;
    end;
  end;
  if Assigned(BoundLabel) then
    BoundLabel.HandleOwnerMsg(Message, Self);
end;


procedure TsMaskEdit.Change;
begin
  if not (csLoading in ComponentState) then
    inherited;
end;


procedure TsMaskEdit.SetEditRect;
begin
//
end;


function TsMaskEdit.BorderWidth: integer;
begin
//  Result := EditBorderWidth(TEdit(Self));
  Result := integer(BorderStyle <> bsNone) * (2 + integer(Ctl3d));
end;


procedure TsMaskEdit.ExcludeChildControls;
var
  i, bw: integer;
begin
  if ControlCount <> 0 then begin
    bw := integer(BorderStyle <> bsNone) * (2 + integer(Ctl3d)) - 1;
    for i := 0 to ControlCount - 1 do
      with Controls[i] do
        ExcludeClipRect(DC, Left + bw, Top + bw, BoundsRect.Right + bw, BoundsRect.Bottom + bw);
  end;
end;


procedure TsMaskEdit.ValidateEdit;
var
  Text: string;
begin
  if FCheckOnExit then
    try
      inherited ValidateEdit;
    except
      on E: EDBEditError do begin
        Text := E.Message;
        if Assigned(FOnValidateError) then
          FOnValidateError(Self, Text);

        raise EDBEditError.Create(Text);
      end;
    end;
end;

end.
