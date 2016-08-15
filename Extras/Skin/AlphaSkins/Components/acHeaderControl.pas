unit acHeaderControl;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ComCtrls,
  {$IFDEF DELPHI7UP} Types, {$ENDIF}
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  sCommonData;


type
{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsHeaderControl = class(THeaderControl)
{$IFNDEF NOTFORHELP}
  private
    FCommonData: TsCommonData;
  protected
    CurItem,
    IndexLeft,
    IndexRight,
    IndexAlone,
    PressedItem: integer;
    procedure WMPaint  (var Message: TWMPaint); message WM_PAINT;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
    procedure PrepareCache;
    procedure PaintItems;
    procedure UpdateIndexes;
    procedure WndProc (var Message: TMessage); override;
    function GetItemUnderMouse(p: TPoint): integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure AfterConstruction; override;
  published
{$ENDIF}
    property SkinData: TsCommonData read FCommonData write FCommonData;
  end;


implementation

uses
  Commctrl, math,
  sGraphUtils, sStyleSimply, acntUtils, sMessages, sVCLUtils, sConst, sSkinProps, acAlphaImageList;


procedure TsHeaderControl.AfterConstruction;
begin
  inherited;
  FCommonData.Loaded;
  UpdateIndexes;
end;


constructor TsHeaderControl.Create(AOwner: TComponent);
begin
  FCommonData := TsCommonData.Create(Self, True);
  FCommonData.COC := COC_TsHeaderControl;
  inherited Create(AOwner);
  CurItem := -1;
  PressedItem := -1;
end;


destructor TsHeaderControl.Destroy;
begin
  FreeAndNil(FCommonData);
  inherited Destroy;
end;


function TsHeaderControl.GetItemUnderMouse(p: TPoint): integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to Sections.Count - 1 do
    if PtInRect(Rect(Sections[i].Left, BorderWidth, Sections[i].Right, Height - BorderWidth), p) then begin
      Result := i;
      Exit;
    end;
end;


procedure TsHeaderControl.Loaded;
begin
  inherited;
  FCommonData.Loaded;
  UpdateIndexes;
end;


procedure TsHeaderControl.PaintItems;
const
  Margin = 5;
  Spacing = 10;
var
  i, si, Ndx, ImgW, Index, State: integer;
  R, TextRC, ItemRC: TRect;
  Section: THeaderSection;
  NewText: acString;
  TempBmp: TBitmap;
  TextSize: TSize;
  CI: TCacheInfo;
  C: TColor;
begin
  if not FCommonData.SkinManager.IsValidSkinIndex(FCommonData.SkinManager.ConstData.Sections[ssColHeader]) then
    Ndx := FCommonData.SkinManager.ConstData.Sections[ssButton]
  else
    Ndx := FCommonData.SkinManager.ConstData.Sections[ssColHeader];

  CI := MakeCacheInfo(FCommonData.FCacheBmp);
  TempBmp := nil;
  for i := 0 to Self.Sections.Count - 1 do begin
    Index := Header_OrderToIndex(Handle, i);
    Section := Sections[i];
    if Section.AllowClick then
      if i = PressedItem then
        State := 2
      else
        State := integer(i = CurItem)
    else
      State := 0;

    Header_GetItemRect(Handle, Index, @ItemRc);
    TempBmp := CreateBmp32(WidthOf(ItemRc), Height - 2 * BorderWidth);
    R := MkRect(TempBmp);
    if (i = 0) and (i = Sections.Count - 1) and (IndexAlone >= 0) then
      si := IndexAlone
    else
      if (i = 0) and (IndexLeft >= 0) then
        si := IndexLeft
      else
        if (i = Sections.Count - 1) and (IndexRight >= 0) then
          si := IndexRight
        else
          si := Ndx;

    PaintItem(si, CI, True, State, R, Point(ItemRc.Left + BorderWidth, BorderWidth), TempBmp, FCommonData.SkinManager);
    TempBmp.Canvas.Brush.Style := bsClear;
    TempBmp.Canvas.Font.Assign(Font);
    if (Section.Style = hsOwnerDraw) and Assigned(OnDrawSection) then begin
      Canvas.Handle := TempBmp.Canvas.Handle;
      TempBmp.Canvas.Lock;
      Self.OnDrawSection(Self, Section, MkRect(TempBmp), State = 2);
      TempBmp.Canvas.UnLock;
      Canvas.Handle := 0;
    end
    else begin
      if Assigned(Images) and (Section.ImageIndex >= 0) then
        ImgW := Images.Width
      else
        ImgW := 0;

      TextSize := TempBmp.Canvas.TextExtent(Section.Text);
{$IFNDEF DELPHI2005}
      inc(TextSize.cx);  
{$ENDIF}
      NewText := Section.Text;
      TextRC.Top := (HeightOf(R) - TextSize.cy) div 2;
      TextRC.Bottom := TextRC.Top + TextSize.cy;
      case Section.Alignment of
        taLeftJustify:
          if ImgW = 0 then
            TextRC.Left := Margin
          else
            TextRC.Left := Margin + ImgW + SPacing;

        taCenter:
          if ImgW = 0 then
            TextRC.Left := (WidthOf(ItemRc) - TextSize.cx) div 2
          else
            TextRC.Left := (WidthOf(ItemRc) - TextSize.cx - ImgW - Spacing) div 2 + ImgW;

        taRightJustify:
          TextRC.Left := WidthOf(ItemRc) - TextSize.cx - Margin;
      end;
      TextRC.Right := min(TextRC.Left + TextSize.cx, WidthOf(ItemRc));

      if (Length(Section.Text) > 0) or (ImgW > 0) then begin
        if (State = 2) and not FCommonData.SkinManager.ButtonsOptions.ShiftContentOnClick then
          State := 1;

        if ImgW > 0 then
          if (Images is TsAlphaImageList) and SkinData.SkinManager.Effects.DiscoloredGlyphs then begin
            if State = 0 then
              if FCommonData.SkinIndex >= 0 then
                C := FCommonData.SkinManager.gd[FCommonData.SkinIndex].Props[0].Color
              else
                C := $FFFFFF
            else
              C := clNone;

            DrawAlphaImgList(Images, TempBmp,
                             TextRC.Left - ImgW - Spacing + integer(State = 2),
                             (Height - Images.Height) div 2 + integer(State = 2) - BorderWidth,
                             Section.ImageIndex, 0, C, 0, 1, False) // Reflected)
          end
          else
            Images.Draw(TempBmp.Canvas,
                        TextRC.Left - ImgW - Spacing + integer(State = 2),
                        (Height - Images.Height) div 2 + integer(State = 2) - BorderWidth,
                        Section.ImageIndex, Enabled);

        if State = 2 then
          OffsetRect(TextRC, 1, 1);

        acWriteTextEx(TempBmp.Canvas, PacChar(NewText), True, TextRc,
                      DrawTextBiDiModeFlags(DT_EXPANDTABS) or DT_SINGLELINE or DT_VCENTER or DT_NOCLIP or DT_END_ELLIPSIS or DT_WORD_ELLIPSIS,
                      Si, (State <> 0), FCommonData.SkinManager);
      end;
    end;
    BitBlt(FCommonData.FCacheBMP.Canvas.Handle, ItemRc.Left + BorderWidth, BorderWidth, R.Right, R.Bottom, TempBmp.Canvas.Handle, 0, 0, SRCCOPY);
    FreeAndNil(TempBmp);
  end;
end;


procedure TsHeaderControl.PrepareCache;
var
  CI: TCacheInfo;
begin
  if FCommonData.BGChanged then begin
    CI := GetParentCache(FCommonData);
    InitCacheBmp(FCommonData);
    PaintItem(FCommonData, CI, False, 0, MkRect(Self), MkPoint(Self), FCommonData.FCacheBMP, True);
    PaintItems;
    FCommonData.BGChanged := False;
  end;
end;


procedure TsHeaderControl.UpdateIndexes;
begin
  if FCommonData.SkinManager <> nil then
    with FCommonData.SkinManager do begin
      IndexLeft  := GetSkinIndex(s_ColHeaderL);
      IndexRight := GetSkinIndex(s_ColHeaderR);
      IndexAlone := GetSkinIndex(s_ColHeaderA);
    end;
end;


procedure TsHeaderControl.WMNCPaint(var Message: TMessage);
var
  DC, SavedDC: hdc;
  bWidth: integer;
begin
  if FCommonData.Skinned then begin
    bWidth := BorderWidth;
    DC := GetWindowDC(Handle);
    SavedDC := SaveDC(DC);
    try
      FCommonData.FUpdating := FCommonData.Updating;
      if not FCommonData.FUpdating and Showing then begin
        PrepareCache;
        ExcludeClipRect(DC, bWidth, bWidth, Width - bWidth, Height - bWidth);
        CopyWinControlCache(Self, FCommonData, MkRect, MkRect(Self), DC, True);
        FCommonData.BGChanged := False;
      end;
    finally
      RestoreDC(DC, SavedDC);
      ReleaseDC(Handle, DC);
    end
  end
  else
    inherited;
end;


procedure TsHeaderControl.WMPaint(var Message: TWMPaint);
var
  DC, SavedDC: hdc;
  PS: TPaintStruct;
  bWidth: integer;
begin
  if FCommonData.Skinned then begin
    bWidth := BorderWidth;
    BeginPaint(Handle, PS);
    SavedDC := 0;
    DC := 0;
    if Message.DC = 0 then begin
      SavedDC := SaveDC(DC);
      DC := GetDC(Handle)
    end
    else
      DC := Message.DC;

    try
      FCommonData.FUpdating := FCommonData.Updating;
      if not FCommonData.FUpdating and Showing then begin
        PrepareCache;
        CopyWinControlCache(Self, FCommonData, Rect(bWidth, bWidth, 0, 0), MkRect(Self), DC, True);
        FCommonData.BGChanged := False;
      end;
    finally
      if Message.DC = 0 then begin
        RestoreDC(DC, SavedDC);
        ReleaseDC(Handle, DC);
      end;
      EndPaint(Handle, PS);
    end
  end
  else
    inherited;
end;


procedure TsHeaderControl.WndProc(var Message: TMessage);
var
  p: TPoint;
  NewItem: integer;
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  if Message.Msg = SM_ALPHACMD then
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
          RecreateWnd;
          Exit;
        end;

      AC_SETNEWSKIN:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          FCommonData.BGChanged := True;
          CommonWndProc(Message, FCommonData);
          UpdateIndexes;
          Exit;
        end;

      AC_REFRESH:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          CommonWndProc(Message, FCommonData);
          RedrawWindow(Handle, nil, 0, RDWA_NOCHILDRENNOW);
          Exit;
        end;

      AC_ENDPARENTUPDATE:
        if FCommonData.Updating then begin
          FCommonData.Updating := False;
          RedrawWindow(Handle, nil, 0, RDWA_NOCHILDRENNOW);
          Exit;
        end;
    end;

  if not ControlIsReady(Self) or not FCommonData.Skinned then
    inherited
  else begin
    case Message.Msg of
      HDM_DELETEITEM, HDM_INSERTITEM, HDM_SETITEM:
        FCommonData.BGChanged := True;

      WM_ERASEBKGND: begin
        FCommonData.FUpdating := FCommonData.Updating;
        Exit;
      end;

      WM_MOVE:
        if FCommonData.SkinManager.gd[FCommonData.SkinIndex].Props[0].Transparency > 0 then
          FCommonData.BGChanged := True;

      WM_PRINT: begin
        FCommonData.FUpdating := False;
        FCommonData.BGChanged := True;
        SendMessage(Handle, WM_PAINT, Message.WParam, Message.LParam);
        Exit;
      end;

      CM_MOUSELEAVE: begin
        FCommonData.BGChanged := True;
        CurItem := -1;
        PressedItem := -1;
        Repaint;
      end;

      WM_LBUTTONDBLCLK, WM_LBUTTONDOWN:
        if not (csDesigning in ComponentState) and (Style <> hsFlat) then begin
          FCommonData.BGChanged := True;
          p.x := TCMHitTest(Message).XPos;
          p.y := TCMHitTest(Message).YPos;
          NewItem := GetItemUnderMouse(p);
          if (NewItem <> PressedItem) and (Sections[NewItem].Right - p.x > 8) and ((NewItem = 0) or (p.x - Sections[NewItem].Left > 8)) then begin
            PressedItem := NewItem;
          end;
        end;

      WM_LBUTTONUP:
        if not (csDesigning in ComponentState) then begin
          FCommonData.BGChanged := True;
          PressedItem := -1;
        end;

      WM_NCHITTEST:
        if not (csDesigning in ComponentState) and HotTrack and not (csLButtonDown in ControlState) and (Style <> hsFlat) then begin
          p.x := TCMHitTest(Message).XPos;
          p.y := TCMHitTest(Message).YPos + BorderWidth;
          p := Self.ScreenToClient(p);
          NewItem := GetItemUnderMouse(p);
          if (NewItem <> CurItem) then FCommonData.BGChanged := True;
          inherited;
          if NewItem <> CurItem then begin
            CurItem := NewItem;
            Repaint
          end;
          Exit;
        end
        else
          if csLButtonDown in ControlState then
            FCommonData.BGChanged := True;
    end;
    CommonWndProc(Message, FCommonData);
    inherited;
    case Message.Msg of
      HDM_SETITEMA:
        FCommonData.Invalidate;

      WM_MOVE, WM_SIZE: begin
        if csDesigning in ComponentState then
          Repaint;
          
        Perform(WM_NCPAINT, 0, 0);
      end;
    end;
  end
end;

end.
