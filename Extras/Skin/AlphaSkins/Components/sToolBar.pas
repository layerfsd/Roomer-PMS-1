unit sToolBar;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ToolWin, ComCtrls,
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  {$IFDEF TNTUNICODE} TntComCtrls, {$ENDIF}
  sCommonData, sConst, sDefaults;


type
{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
{$IFDEF TNTUNICODE}
  TsToolBar = class(TTntToolBar)
{$ELSE}
  TsToolBar = class(TToolBar)
{$ENDIF}
{$IFNDEF NOTFORHELP}
  private
    HotButtonIndex: integer;
    FCommonData: TsCommonData;
    FDisabledKind: TsDisabledKind;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure SetDisabledKind(const Value: TsDisabledKind);
  protected
    DroppedButton: TToolButton;
    procedure WndProc(var Message: TMessage); override;
    function OffsetX: integer;
    function OffsetY: integer;
    function PrepareCache: boolean;
    procedure OurAdvancedCustomDraw(Sender: TToolBar; const ARect: TRect; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
    procedure OurAdvancedCustomDrawButton(Sender: TToolBar; Button: TToolButton; State: TCustomDrawState;
                                          Stage: TCustomDrawStage; var Flags: TTBCustomDrawFlags; var DefaultDraw: Boolean);
    function GetButtonRect(Index: integer): TRect;
    function IndexByMouse(MousePos: TPoint): integer;
    procedure RepaintButton(Index: integer);
{$IFDEF DELPHI6UP}
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
{$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure Loaded; override;
    procedure UpdateEvents;
  published
    property Flat;
{$ENDIF} // NOTFORHELP
    property BtnDisabledKind: TsDisabledKind read FDisabledKind write SetDisabledKind default DefDisabledKind;
    property SkinData: TsCommonData read FCommonData write FCommonData;
  end;


implementation

uses
  CommCtrl, ImgList, Menus,
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  acntUtils, sStyleSimply, sVCLUtils, sMessages, sMaskData, sGraphUtils,
  sSkinProps, sAlphaGraph, sSkinManager, sThirdParty;


procedure PaintSeparator(const DC: hdc; const R: TRect; const ToolBar: TsToolBar; IsDivider: boolean);
var
  SavedDC: hdc;
  Bmp: TBitmap;
  si, mi: integer;
  nRect, cR: TRect;
  BGInfo: TacBGInfo;
begin
  si := ToolBar.SkinData.SkinManager.ConstData.Sections[ssDivider];
  mi := ToolBar.SkinData.SkinManager.gd[si].BorderIndex;
  if ToolBar.SkinData.SkinManager.IsValidImgIndex(mi) then begin
    Bmp := CreateBmp32(R);
    BGInfo.BgType := btUnknown;
    BGInfo.Offset.X := 0;
    BGInfo.Offset.Y := 0;
    BGInfo.Bmp := nil;
    BGInfo.R := MkRect(Bmp);
    BGInfo.PleaseDraw := False;
    GetBGInfo(@BGInfo, ToolBar.Handle, False);
    if BGInfo.BgType = btCache then
      BitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, BGInfo.Bmp.Canvas.Handle, BGInfo.Offset.X + R.Left, BGInfo.Offset.Y + R.Top, SRCCOPY)
    else
      FillDC(Bmp.Canvas.Handle, MkRect(Bmp), BGInfo.Color);

    nRect.Top    := 2;
    nRect.Left   := Bmp.Width div 2 - 2;
    nRect.Bottom := Bmp.Height - 2;
    nRect.Right  := nRect.Left + 4;

    if IsDivider then
      PaintItem(si, BGInfoToCI(@BGInfo), True, 0, nRect, Point(R.Left + ToolBar.BorderWidth, R.Top + ToolBar.BorderWidth), Bmp, ToolBar.SkinData.SkinManager);

    if DC = ToolBar.SkinData.PrintDC then begin
      SavedDC := SaveDC(DC);
      cR := ACClientRect(ToolBar.Handle);
      MoveWindowOrg(DC, -cR.Left, -cR.Top);
    end
    else
      SavedDC := 0;

    BitBlt(DC, ToolBar.OffsetX + R.Left, ToolBar.OffsetY + R.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
    if DC = ToolBar.SkinData.PrintDC then
      RestoreDC(DC, SavedDC);

    FreeAndNil(Bmp);
  end;
end;


function TsToolBar.OffsetX: integer;
begin
  Result := (integer(ebLeft in EdgeBorders) + BorderWidth) * integer(EdgeInner <> esNone) + (integer(ebLeft in EdgeBorders) + BorderWidth) * integer(EdgeOuter <> esNone)
end;


function TsToolBar.OffsetY: integer;
begin
  Result := (integer(ebTop in EdgeBorders) + BorderWidth) * integer(EdgeInner <> esNone) + (integer(ebTop in EdgeBorders) + BorderWidth) * integer(EdgeOuter <> esNone)
end;


procedure TsToolBar.AfterConstruction;
begin
  inherited;
  FCommonData.Loaded;
  UpdateEvents;
end;


{$IFDEF DELPHI6UP}
procedure TsToolBar.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if not (csDesigning in ComponentState) and Assigned(FCommonData) and FCommonData.Skinned then
    if (AComponent is TPopupMenu) and Assigned(DefaultManager) then
      DefaultManager.SkinableMenus.HookPopupMenu(TPopupMenu(AComponent), Operation = opInsert);
end;
{$ENDIF}


constructor TsToolBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCommonData := TsCommonData.Create(Self, True);
  FCommonData.COC := COC_TsToolBar;
  FDisabledKind := DefDisabledKind;
  DoubleBuffered := True;
  HotButtonIndex := -1;
end;


destructor TsToolBar.Destroy;
begin
  if Assigned(FCommonData) then
    FreeAndNil(FCommonData);
    
  inherited Destroy;
end;


function TsToolBar.GetButtonRect(Index: integer): TRect;
begin
  if SendMessage(Handle, TB_GETITEMRECT, Index, LPARAM(@Result)) = 0 then
    Result.Left := Result.Right;
end;


function TsToolBar.IndexByMouse(MousePos: TPoint): integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to ButtonCount - 1 do
    if PtInRect(GetButtonRect(i), MousePos) then begin
      if (TControl(Buttons[I]) is TToolButton) and (Buttons[i].Style in [tbsButton, tbsCheck, tbsDropDown]) then
        Result := i;

      Exit;
    end;
end;


procedure TsToolBar.Loaded;
begin
  inherited;
  FCommonData.Loaded;
  UpdateEvents;
end;


procedure CopyCache(Control: TWinControl; SkinData: TsCommonData; SrcRect, DstRect: TRect; DstDC: HDC);
var
  SaveIndex: HDC;
  i: integer;
  Designing: boolean;
begin
  SaveIndex := SaveDC(DstDC);
  IntersectClipRect(DstDC, DstRect.Left, DstRect.Top, DstRect.Right, DstRect.Bottom);
  Designing := csDesigning in Control.ComponentState;
  try
    for i := 0 to Control.ControlCount - 1 do begin
      if (Control.Controls[i] is TToolButton) and (csDesigning in Control.ComponentState) then
        Continue;

      if (Control.Controls[i] is TGraphicControl) and StdTransparency then
        Continue;

      if not Control.Controls[i].Visible or not RectIsVisible(DstRect, Control.Controls[i].BoundsRect) then
        Continue;

      if (csOpaque in Control.Controls[i].ControlStyle) or (Control.Controls[i] is TGraphicControl) or Designing then
        ExcludeClipRect(DstDC, Control.Controls[i].Left, Control.Controls[i].Top,
                        Control.Controls[i].Left + Control.Controls[i].Width,
                        Control.Controls[i].Top + Control.Controls[i].Height);
    end;
    BitBlt(DstDC, DstRect.Left, DstRect.Top, WidthOf(DstRect), HeightOf(DstRect), SkinData.FCacheBmp.Canvas.Handle, SrcRect.Left, SrcRect.Top, SRCCOPY);
  finally
    RestoreDC(DstDC, SaveIndex);
  end;
end;


procedure TsToolBar.OurAdvancedCustomDraw(Sender: TToolBar; const ARect: TRect; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
var
  RC, RW: TRect;
  DC: hdc;
begin
  if FCommonData.Skinned then begin
    DC := Canvas.Handle;
    FCommonData.FUpdating := FCommonData.Updating;
    if not (Stage in [cdPrePaint]) then
      DefaultDraw := False
    else 
      if not FCommonData.BGChanged or PrepareCache then begin
        FCommonData.FCacheBMP.Canvas.Font.Assign(Font);
        Windows.GetClientRect(Handle, RC);
        GetWindowRect(Handle, RW);
        MapWindowPoints(0, Handle, RW, 2);
        OffsetRect(RC, -RW.Left, -RW.Top);

        CopyCache(Self, FCommonData, RC, ARect, DC);
        sVCLUtils.PaintControls(DC, Self, True, MkPoint);
        SetParentUpdated(Self);
        if (RC.Left > 0) or (RC.Top > 0) or (RC.Right <> Width) or (RC.Bottom <> Height) then
          Perform(WM_NCPAINT, 0, 0);
      end
      else
        DefaultDraw := False;
  end
  else begin
    DefaultDraw := True;
    inherited;
  end
end;


procedure TsToolBar.OurAdvancedCustomDrawButton(Sender: TToolBar; Button: TToolButton; State: TCustomDrawState; Stage: TCustomDrawStage; var Flags: TTBCustomDrawFlags; var DefaultDraw: Boolean);
var
  R, iR: TRect;
  ci: TCacheInfo;
  BtnBmp: TBitmap;
  bWidth, bHeight, Mode, SkinIndex: integer;

  function AddedWidth: integer;
  begin
    if (Button.Style = tbsDropDown) then
      Result := GetScrollSize(Skindata.SkinManager) - 2
    else
      Result := 0
  end;

  function IntButtonWidth: integer;
  begin
    Result := Button.Width - AddedWidth;
  end;

  function ButtonWidth: integer;
  begin
    Result := Button.Width;
  end;

  function ImgRect: TRect;
  begin
    if not List then begin
      Result.Left   := (IntButtonWidth - Images.Width) div 2 + 1;
      Result.Top    := (Button.Height - Images.Height - integer(ShowCaptions) * (FCommonData.FCacheBMP.Canvas.TextHeight('A') + 3)) div 2;
      Result.Right  := Result.Left + Images.Width;
      Result.Bottom := Result.Bottom + Images.Height;
    end
    else begin
      Result.Left   := 5;
      Result.Top    := (Button.Height - Images.Height) div 2;
      Result.Right  := Result.Left + Images.Width;
      Result.Bottom := Result.Bottom + Images.Height;
    end;
    if Mode = 2 then
      if SkinData.Skinned and SkinData.SkinManager.ButtonsOptions.ShowFocusRect then
        OffsetRect(Result, 1, 1);
  end;

  procedure DrawBtnCaption;
  var
    cRect: TRect;

    function CaptionRect: TRect;
    var
      l, t, r, b, dh: integer;
    begin
      if not List then begin
        l := (IntButtonWidth - FCommonData.FCacheBMP.Canvas.TextWidth(Button.Caption)) div 2;
        if Assigned(Images) then begin
          dh := (Button.Height - Images.Height - FCommonData.FCacheBMP.Canvas.TextHeight('A') - 3) div 2;
          t := dh + Images.Height + 3;
        end
        else begin
          dh := (Button.Height - FCommonData.FCacheBMP.Canvas.TextHeight('A')) div 2;
          t := dh;
        end;
        r := IntButtonWidth - l;
        b := Button.Height - dh;
        Result := Rect(l - 1, t, r + 2, b);
      end
      else begin
        if Assigned(Images) and (Button.ImageIndex >= 0) then
          Result.Left := 6 + Images.Width
        else
          Result.Left := 1;

        Result.Right := IntButtonWidth - 2;
        Result.Top := 2;
        Result.Bottom := Button.Height - 2;
      end;
      if Mode = 2 then
        if SkinData.Skinned and SkinData.SkinManager.ButtonsOptions.ShowFocusRect then
          OffsetRect(Result, 1, 1);
    end;
  begin
    if ShowCaptions {$IFDEF D2010}or (AllowTextButtons and (Button.Style = tbsTextButton)) {$ENDIF} then begin
      cRect := CaptionRect;
{$IFDEF TNTUNICODE}
      if Button is TTntToolButton then
        WriteTextExW(BtnBMP.Canvas, PWideChar(TTntToolButton(Button).Caption), True, cRect,
                     DT_CENTER or DT_VCENTER or DT_SINGLELINE, GetFontIndex(Button, SkinIndex, SkinData.SkinManager), Mode > 0)
      else
{$ENDIF}
        acWriteTextEx(BtnBMP.Canvas, PacChar(Button.Caption), Enabled and (DisabledImages = nil), cRect,
                      DT_CENTER or DT_VCENTER or DT_SINGLELINE, GetFontIndex(Button, SkinIndex, SkinData.SkinManager), Mode > 0);
    end;
  end;

  procedure DrawBtnGlyph;
  begin
    if Assigned(Images) and (Button.ImageIndex >= 0) and (Button.ImageIndex < GetImageCount(Images)) then
      sThirdParty.CopyToolBtnGlyph(Self, Button, State, Stage, Flags, BtnBmp);
  end;

  procedure DrawArrow;
  var
    Mode, x, y: integer;
  begin
    with FCommonData.SkinManager do begin
      if ((DroppedButton = Button) and Assigned(Button.DropDownMenu) or Button.Down) then
        Mode := 2
      else
        Mode := integer(cdsHot in State);

      R.Left := IntButtonWidth;
      R.Right := Button.Width;
      if IsValidImgIndex(gd[SkinIndex].BorderIndex) then
        DrawSkinRect(BtnBmp, R, ci, ma[gd[SkinIndex].BorderIndex], Mode, True);

      if (ConstData.ScrollBtns[asBottom].GlyphIndex >= 0) and (ConstData.ScrollBtns[asBottom].GlyphIndex < High(ma)) then begin
        x := IntButtonWidth + (AddedWidth - 3 - WidthOfImage(ma[ConstData.ScrollBtns[asBottom].GlyphIndex])) div 2 + 2;
        y := (ButtonHeight - HeightOfImage(ma[ConstData.ScrollBtns[asBottom].GlyphIndex])) div 2;
        DrawSkinGlyph(BtnBmp, Point(x, y), Mode, 1, ma[ConstData.ScrollBtns[asBottom].GlyphIndex], MakeCacheInfo(BtnBmp));
      end
      else
        DrawColorArrow(BtnBmp.Canvas, FCommonData.SkinManager.gd[SkinIndex].Props[integer(Mode > 0)].FontColor.Color, R, asBottom);
    end;
  end;

begin
  if FCommonData.Skinned then begin
    DefaultDraw := False;
//    if FCommonData.FUpdating then Exit; Black rects blinking avoiding
    if not (Stage in [cdPrePaint]) then
      DefaultDraw := False
    else
      if (Stage in [cdPrePaint]) then begin
        if not Flat and not (csDesigning in ComponentState) and (HotButtonIndex = Button.Index) then
          State := State + [cdsHot];

        Flags := Flags + [tbNoEtchedEffect, tbNoEdges];
        iR := GetButtonRect(Button.Index);
        if WidthOf(iR) <> Button.Width then begin
          Loaded; // Reinit buttons
          iR := GetButtonRect(Button.Index);
        end;
        if WidthOf(iR) <> 0 then begin
          bWidth := WidthOf(iR);
          bHeight := HeightOf(iR);
          BtnBmp := CreateBmp32(bWidth, bHeight);
          BtnBmp.Canvas.Font.Assign(Font);
          if not Button.Marked and not Button.Indeterminate and ((State = []) or (State = [cdsDisabled])) then
            Mode := 0
          else
            Mode := 1 + integer((cdsSelected in State) or (cdsChecked in State) or Button.Marked or Button.Indeterminate);

          if Flat then
            SkinIndex := FCommonData.SkinManager.ConstData.Sections[ssToolButton]
          else
            SkinIndex := FCommonData.SkinManager.ConstData.Sections[ssSpeedButton];

          if SkinIndex >= 0 then begin
            ci := MakeCacheInfo(FCommonData.FCacheBmp,
                                BorderWidth * 2 + integer(ebLeft in EdgeBorders) * (integer(EdgeInner <> esNone) + integer(EdgeOuter <> esNone)),
                                BorderWidth * 2 + integer(ebTop  in EdgeBorders) * (integer(EdgeInner <> esNone) + integer(EdgeOuter <> esNone)));

            R := MkRect(bWidth, Button.Height);
            OffsetRect(R, ClientRect.Left, ClientRect.Top);

            PaintItemBg(SkinIndex, ci, Mode, R, Point(Button.Left, Button.Top), BtnBmp, FCommonData.SkinManager);
            R.Right := bWidth - AddedWidth;

            ci.X := ci.X + Button.Left;
            ci.Y := ci.Y + Button.Top;
            if FCommonData.SkinManager.gd[SkinIndex].BorderIndex >= 0 then
              DrawSkinRect(BtnBmp, R, ci, FCommonData.SkinManager.ma[FCommonData.SkinManager.gd[SkinIndex].BorderIndex], Mode, True);

            DrawBtnCaption;
            DrawBtnGlyph;
            if Button.Style = tbsDropDown then
              DrawArrow;

            if (not Button.Enabled or Button.Indeterminate) then
              BmpDisabledKind(BtnBmp, FDisabledKind, Parent, CI, MkPoint);

            BitBlt(Canvas.Handle, Button.Left, Button.Top, bWidth, bHeight, BtnBmp.Canvas.Handle, 0, 0, SRCCOPY);
          end;
          FreeAndNil(BtnBmp);
        end;
      end;
  end
  else begin
    DefaultDraw := True;
    inherited;
  end;
end;


procedure UpdateInvalRects(SkinData: TsCommonData; State: integer);
var
  CurrentBounds: TRect;
  bWidth: integer;
begin
  if SkinData.FOwnerControl <> nil then begin
    CurrentBounds := MkRect(SkinData.FOwnerControl);
    // InvalidRectH
    if (CurrentBounds.Right = SkinData.FCacheBmp.Width) or
         (SkinData.SkinManager.gd[SkinData.SkinIndex].Props[State].GradientPercent <> 0) and
           (SkinData.BGType and BGT_GRADIENTHORZ = BGT_GRADIENTHORZ) then
      // If Rect is not used
      SkinData.InvalidRectH.Right := 0
    else begin
      if SkinData.BorderIndex < 0 then
        bWidth := 0
      else
        bWidth := SkinData.SkinManager.MaskWidthRight(SkinData.BorderIndex);

      if CurrentBounds.Right > SkinData.FCacheBmp.Width then begin
        SkinData.InvalidRectH.Left := SkinData.FCacheBmp.Width - bWidth;
        SkinData.InvalidRectH.Right := CurrentBounds.Right;
      end
      else begin
        SkinData.InvalidRectH.Left := CurrentBounds.Right - bWidth;
        SkinData.InvalidRectH.Right := CurrentBounds.Right;
      end;
      SkinData.InvalidRectH.Top := 0;
      SkinData.InvalidRectH.Bottom := CurrentBounds.Bottom;
    end;
    // InvalidRectV
    if (CurrentBounds.Bottom = SkinData.FCacheBmp.Height)
         or (SkinData.SkinManager.gd[SkinData.SkinIndex].Props[State].GradientPercent <> 0)
           and (SkinData.BGType and BGT_GRADIENTVERT = BGT_GRADIENTVERT) then
      // If Rect is not used
      SkinData.InvalidRectV.Bottom := 0
    else begin
      if SkinData.BorderIndex < 0 then
        bWidth := 0
      else
        bWidth := SkinData.SkinManager.MaskWidthBottom(SkinData.BorderIndex);

      if CurrentBounds.Bottom > SkinData.FCacheBmp.Height then begin
        SkinData.InvalidRectV.Top := SkinData.FCacheBmp.Height - bWidth;
        SkinData.InvalidRectV.Bottom := CurrentBounds.Bottom;
      end
      else begin
        SkinData.InvalidRectV.Top := CurrentBounds.Bottom - bWidth;
        SkinData.InvalidRectV.Bottom := CurrentBounds.Bottom;
      end;
      SkinData.InvalidRectV.Left := 0;
      SkinData.InvalidRectV.Right := CurrentBounds.Right;
    end;
  end;
end;


function TsToolBar.PrepareCache: boolean;
var
  ParentBG: TacBGInfo;
begin
  ParentBG.PleaseDraw := False;
  GetBGInfo(@ParentBG, Parent);
  if ParentBG.BgType = btNotReady then begin
    SkinData.FUpdating := True;
    Result := False;
  end
  else begin
    UpdateInvalRects(FCommonData, 0);
    InitCacheBmp(SkinData);
    PaintItem(FCommonData, GetParentCache(FCommonData), True, 0, MkRect(Self), Point(Left, Top), FCommonData.FCacheBmp, True);
    FCommonData.BGChanged := False;
    Result := True;
  end;
end;


procedure TsToolBar.RepaintButton(Index: integer);
var
  Flags: TTBCustomDrawFlags;
  DC, SavedDC: HDC;
  RC, RW: TRect;
  Def: boolean;
begin
  if (Index >= 0) and Buttons[Index].Visible then begin
    Flags := [tbNoEtchedEffect, tbNoEdges];
    Def := False;
    DC := GetWindowDC(Handle);
    SavedDC := SaveDC(DC);
    try
      Windows.GetClientRect(Handle, RC);
      GetWindowRect(Handle, RW);
      MapWindowPoints(0, Handle, RW, 2);
      OffsetRect(RC, -RW.Left, -RW.Top);
      MoveWindowOrg(DC, -RW.Left, -RW.Top);

      Canvas.Handle := DC;
      OurAdvancedCustomDrawButton(Self, Buttons[Index], [], cdPrePaint, Flags, Def)
    finally
      Canvas.Handle := 0;
      RestoreDC(DC, SavedDC);
      ReleaseDC(Handle, DC);
    end;
  end;
end;


procedure TsToolBar.SetDisabledKind(const Value: TsDisabledKind);
begin
  if FDisabledKind <> Value then begin
    FDisabledKind := Value;
    Repaint;
  end;
end;


procedure TsToolBar.UpdateEvents;
begin
  if SkinData.Skinned then begin
    inherited
    OnAdvancedCustomDraw := OurAdvancedCustomDraw;
    if not (csDesigning in ComponentState) then
      inherited OnAdvancedCustomDrawButton := OurAdvancedCustomDrawButton;
  end
  else begin
    inherited
    OnAdvancedCustomDraw := nil;
    if not (csDesigning in ComponentState) then
      inherited OnAdvancedCustomDrawButton := nil;
  end;
end;


procedure TsToolBar.WMNCPaint(var Message: TWMNCPaint);
var
  DC, SavedDC: HDC;
  RC, RW: TRect;
  w, h: integer;
begin
  if FCommonData.Skinned then begin
    if not InUpdating(FCommonData) and not (csDestroying in ComponentState) then begin
      if not FCommonData.BGChanged or PrepareCache then begin
        DC := GetWindowDC(Handle);
        SavedDC := SaveDC(DC);
        try
          Windows.GetClientRect(Handle, RC);
          GetWindowRect(Handle, RW);
          MapWindowPoints(0, Handle, RW, 2);
          OffsetRect(RC, -RW.Left, -RW.Top);
          ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
          { Draw borders in non-client area }
          w := WidthOf(Rc);
          h := HeightOf(Rc);
          // Top
          BitBlt(DC, 0, 0, Width, Rc.Top, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
          // Left
          BitBlt(DC, 0, Rc.Top, Rc.Left, h, SkinData.FCacheBmp.Canvas.Handle, 0, Rc.Top, SRCCOPY);
          // Bottom
          BitBlt(DC, 0, Rc.Bottom, Width, Height - h - Rc.Top, SkinData.FCacheBmp.Canvas.Handle, 0, Rc.Bottom, SRCCOPY);
          // Right
          BitBlt(DC, Rc.Right, Rc.Top, Width - Rc.Left - w, h, SkinData.FCacheBmp.Canvas.Handle, Rc.Right, Rc.Top, SRCCOPY);

          IntersectClipRect(DC, RW.Left, RW.Top, RW.Right, RW.Bottom);
        finally
          RestoreDC(DC, SavedDC);
          ReleaseDC(Handle, DC);
        end;
      end;
    end;
  end
  else
    inherited;
end;


procedure TsToolBar.WndProc(var Message: TMessage);
var
  i, OldIndex, w, h: integer;
  PS: TPaintStruct;
  rc: TRect;
  DC: hdc;
begin
{$IFDEF LOGGED}
//  if (Form1 <> nil) and (Form1.sPageControl1 <> nil) and Form1.sPageControl1.Visible then
    AddToLog(Message);
{$ENDIF}
  if (Message.Msg = SM_ALPHACMD) then begin
    case Message.WParamHi of
      AC_CTRLHANDLED: begin
        Message.Result := 1;
        Exit;
      end;

      AC_SETNEWSKIN:
        if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
          AlphaBroadCast(Self, Message);
          CommonWndProc(Message, FCommonData);
          UpdateEvents;
          Exit;
        end;

      AC_ENDPARENTUPDATE:
        if FCommonData.FUpdating then begin
          FCommonData.Updating := False;
          FCommonData.BGChanged := True;
          if HandleAllocated then
            RedrawWindow(Handle, nil, 0, RDW_UPDATENOW or RDW_ERASE or RDW_INVALIDATE or RDW_FRAME);

          Exit;
        end;

      AC_REFRESH:
        if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
          DroppedButton := nil;
          CommonWndProc(Message, FCommonData);
          AlphaBroadcast(Self, Message);
          UpdateEvents;
          Perform(WM_NCPAINT, 0, 0);
          Repaint;
          Exit;
        end;

      AC_REMOVESKIN:
        if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
          DroppedButton := nil;
          CommonWndProc(Message, FCommonData);
          AlphaBroadcast(Self, Message);
          UpdateEvents;
          Repaint;
          Perform(WM_NCPAINT, 0, 0);
          Exit;
        end;

      AC_GETDEFINDEX: begin
        if FCommonData.SkinManager <> nil then
          Message.Result := FCommonData.SkinManager.ConstData.Sections[ssToolBar] + 1;

        Exit;
      end;
    end;
  end;

  if not ControlIsReady(Self) or not FCommonData.Skinned then
    inherited
  else begin
    if Message.Msg = SM_ALPHACMD then
      case Message.WParamHi of
        AC_GETBG: begin
          PacBGInfo(Message.LParam)^.Offset := MkPoint;
          InitBGInfo(FCommonData, PacBGInfo(Message.LParam), 0);
          inc(PacBGInfo(Message.LParam)^.Offset.X, OffsetX);
          inc(PacBGInfo(Message.LParam)^.Offset.Y, OffsetY);
          if (PacBGInfo(Message.LParam)^.BgType = btFill) and (PacBGInfo(Message.LParam)^.Bmp <> nil) then begin
            PacBGInfo(Message.LParam).FillRect.Left := PacBGInfo(Message.LParam)^.Offset.X - PacBGInfo(Message.LParam).FillRect.Left;
            PacBGInfo(Message.LParam).FillRect.Top  := PacBGInfo(Message.LParam)^.Offset.Y - PacBGInfo(Message.LParam).FillRect.Top;
          end;
          Exit;
        end

        else
          if CommonMessage(Message, SkinData) then
            Exit;
      end
    else
      case Message.Msg of
        WM_PRINT: begin
          FCommonData.Updating := False;
          RC := ACClientRect(Handle);
          w := WidthOf(Rc);
          h := HeightOf(Rc);
          PrepareCache;
          BitBlt(TWMPaint(Message).DC, 0, 0, Width, Rc.Top, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
          BitBlt(TWMPaint(Message).DC, 0, Rc.Top, Rc.Left, h, SkinData.FCacheBmp.Canvas.Handle, 0, Rc.Top, SRCCOPY);
          BitBlt(TWMPaint(Message).DC, 0, Rc.Bottom, Width, Height - h - Rc.Top, SkinData.FCacheBmp.Canvas.Handle, 0, Rc.Bottom, SRCCOPY);
          BitBlt(TWMPaint(Message).DC, Rc.Right, Rc.Top, Width - Rc.Left - w, h, SkinData.FCacheBmp.Canvas.Handle, Rc.Right, Rc.Top, SRCCOPY);
          MoveWindowOrg(TWMPaint(Message).DC, Rc.Left, Rc.Top);
          IntersectClipRect(TWMPaint(Message).DC, 0, 0, w, h);
          if aSkinChanging then begin // Preventing of blinking when skin is changed
            SendMessage(Parent.Handle, WM_SETREDRAW, 0, 0);
            SendMessage(Handle, WM_PAINT, Message.WParam, 0);
            SendMessage(Parent.Handle, WM_SETREDRAW, 1, 0);
          end
          else
            SendMessage(Handle, WM_PAINT, Message.WParam, 0);

          for i := 0 to ButtonCount - 1 do
            if (Buttons[i].Style in [tbsSeparator, tbsDivider]) and Buttons[i].Visible and not Buttons[i].Wrap then begin
              rc := Buttons[i].BoundsRect;
              PaintSeparator(TWMPaint(Message).DC, rc, Self, (Buttons[i].Style = tbsDivider));
            end;

          Exit;
        end;

        WM_ERASEBKGND:
          if not (csDesigning in ComponentState) then begin
            FCommonData.FUpdating := FCommonData.Updating;
            Message.Result := 1;
            Exit;
          end;

        CM_COLORCHANGED:
          Exit;

        CM_TEXTCHANGED: begin
          Repaint;
          Exit;
        end;

        CN_NOTIFY:
          with TWMNotify(Message) do
            case TWMNotify(Message).NMHdr^.code of
              TBN_DROPDOWN:
                with PNMToolBar(NMHdr)^ do
                  if Perform(TB_GETBUTTON, iItem, LPARAM(@tbButton)) <> 0 then begin
                    DroppedButton := TToolButton(tbButton.dwData);
                    DroppedButton.Repaint
                  end;

              TBN_DELETINGBUTTON:
                if HotButtonIndex >= ButtonCount then
                  HotButtonIndex := -1;
            end;

        WM_PAINT:
          if InAnimationProcess and (0 = SkinData.PrintDC) then
            Exit
          else
            if InUpdating(SkinData) then begin
              BeginPaint(Handle, PS);
              EndPaint(Handle, PS);
              Exit;
            end;

{$IFDEF DELPHI7UP}
        WM_LBUTTONDBLCLK:
          if Customizable then // Remove a custom item drawing for avoiding a bug in VCL
            if not (csDesigning in ComponentState) then
              inherited OnAdvancedCustomDrawButton := nil;
{$ENDIF}
      end;

    if CommonWndProc(Message, FCommonData) then
      Exit;
      
    inherited;
    case Message.Msg of
{$IFDEF DELPHI7UP}
      WM_LBUTTONDBLCLK:
        if Customizable then // Restore a custom drawing
          UpdateEvents;
{$ENDIF}

      WM_PAINT:
        if not InAnimationProcess then begin
          if TWMPAint(Message).DC = 0 then
            DC := GetWindowDC(Handle)
          else
            DC := TWMPAint(Message).DC;

          w := SkinData.SkinManager.ConstData.Sections[ssDivider];
          if SkinData.SkinManager.IsValidSkinIndex(w) then
            for i := 0 to ButtonCount - 1 do
              if (Buttons[i].Style in [tbsSeparator, tbsDivider]) and Buttons[i].Visible then
                if not Buttons[i].Wrap then begin
                  rc := Buttons[i].BoundsRect;
                  PaintSeparator(DC, rc, Self, (Buttons[i].Style = tbsDivider));
                end;

          if TWMPAint(Message).DC = 0 then
            ReleaseDC(Handle, DC);
        end;

      CN_DROPDOWNCLOSED:
        if DroppedButton <> nil then begin
          HotButtonIndex := -1;
          i := DroppedButton.Index;
          DroppedButton := nil;
          RepaintButton(i);
        end;

      CM_MOUSELEAVE:
        if not Flat and not (csDesigning in ComponentState) then begin
          OldIndex := HotButtonIndex;
          HotButtonIndex := -1;
          if (OldIndex >= 0) and not Buttons[OldIndex].Down then
            RepaintButton(OldIndex);

          HotButtonIndex := -1;
        end;

      WM_MOUSEMOVE:
        if not Flat and not (csDesigning in ComponentState) then
          with TWMMouse(Message) do begin
            i := IndexByMouse(Point(TWMMouse(Message).XPos, TWMMouse(Message).YPos));
            if (i <> HotButtonIndex) then begin
              if (i >= 0) and not Buttons[i].Enabled then
                Exit;

              OldIndex := HotButtonIndex;
              HotButtonIndex := i;
              if (OldIndex >= 0) and not Buttons[OldIndex].Down then
                RepaintButton(OldIndex);

              if (HotButtonIndex >= 0) and not Buttons[HotButtonIndex].Down then
                RepaintButton(HotButtonIndex);
            end;
          end;

      WM_SIZE, CM_VISIBLECHANGED, CM_ENABLEDCHANGED: begin
        FCommonData.BGChanged := True;
        InvalidateRect(Handle, nil, False);
      end;
    end;
  end;
end;

end.

