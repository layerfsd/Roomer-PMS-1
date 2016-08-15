unit sTabControl;
{$I sDefs.inc}
//{$DEFINE LOGGED}
//+
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ComCtrls, CommCtrl,
  {$IFDEF DELPHI_XE2} UITypes, {$ENDIF}
  {$IFNDEF DELPHI5} types, {$ENDIF}
  acSBUtils, sCommonData, sConst;


type
{$IFNDEF NOTFORHELP}
{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsTabControl = class(TTabControl)
  protected
    BtnSW: TacSpinWnd;
    CurItem: integer;
    FCommonData: TsCommonData;
    ChangedSkinSection: string;
    function GetClRect: TRect;
    function TabsRect: TRect;
    function TabRow(TabIndex: integer): integer;
    procedure CheckUpDown;
  public
    function PageRect: TRect;
    function SkinTabRect(Index: integer; Active: boolean): TRect;
    function GetTabUnderMouse(p: TPoint): integer;
    procedure DrawSkinTabs(const CI: TCacheInfo);
    procedure DrawSkinTab(Index: Integer; State: integer; Bmp: TBitmap; OffsetPoint: TPoint); overload;
    procedure DrawSkinTab(Index: Integer; State: integer; DC: hdc); overload;
    procedure RepaintTab(i, State: integer; TabDC: hdc = 0);
    procedure AC_WMPaint(var Message: TWMPaint);
    procedure Loaded; override;
    procedure AfterConstruction; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure WndProc(var Message: TMessage); override;
  published
    property SkinData: TsCommonData read FCommonData write FCommonData;
  end;
{$ENDIF} // NOTFORHELP


implementation

uses
  math,
  {$IFDEF LOGGED}sDebugMsgs, {$ENDIF}
  sStyleSimply, sSkinProps, sGraphUtils, acntUtils, sMessages, sVCLUtils, sSkinManager, sAlphaGraph;


procedure TsTabControl.AC_WMPaint(var Message: TWMPaint);
var
  DC, SavedDC, TabDC: hdc;
  ci: TCacheInfo;
  R: TRect;
begin
  SavedDC := 0;
  TabDC := 0;
  SkinData.FUpdating := SkinData.Updating;
  if not SkinData.FUpdating then begin
    if (Message.Unused = 1) or InAnimationProcess or (SkinData.CtrlSkinState and ACS_PRINTING <> 0) then
      DC := Message.DC
    else begin
      DC := GetDC(Handle);
      SavedDC := SaveDC(DC);
    end;
    try
      // If transparent and form resizing processed
      SkinData.BGChanged := True;
      CI := GetParentCache(SkinData);
      if SkinData.BGChanged then begin
        InitCacheBmp(SkinData);
        SkinData.FCacheBmp.Width := Width;
        SkinData.FCacheBmp.Height := Height;
        if Tabs.Count > 0 then
          DrawSkinTabs(CI);

        R := PageRect;
        PaintItem(SkinData.SkinIndex, CI, False, 0, R, Point(Left, Top), SkinData.FCacheBmp, SkinData.SkinManager);
        SkinData.BGChanged := False;
      end;
      if (Tabs.Count > 0) and (TabIndex >= 0) then begin
        R := SkinTabRect(TabIndex, True);
        TabDC := SaveDC(DC);
        ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
      end;
      SkinData.PaintOuterEffects(Self, MkPoint);
      CopyWinControlCache(Self, SkinData, MkRect, MkRect(Self), DC, False);
      if (Tabs.Count > 0) and (TabIndex >= 0) then begin
        RestoreDC(DC, TabDC);
        if Message.Unused <> 1 then begin
          RestoreDC(DC, SavedDC);
          SavedDC := SaveDC(DC);
        end;
        DrawSkinTab(TabIndex, 2, DC);
      end;
      SetParentUpdated(Self);
      sVCLUtils.PaintControls(DC, Self, True, MkPoint);
    finally
      if DC <> Message.DC then begin
        RestoreDC(DC, SavedDC);
        ReleaseDC(Handle, DC);
      end;
    end;
  end
end;


procedure TsTabControl.AfterConstruction;
begin
  inherited AfterConstruction;
  SkinData.Loaded;
  CheckUpDown;
end;


procedure TsTabControl.CheckUpDown;
var
  Wnd: HWND;
  sp: TacSkinParams;
begin
  if not (csLoading in ComponentState) and not (csCreating in ControlState) then
    if FCommonData.Skinned and HandleAllocated then begin
      Wnd := FindWindowEx(Handle, 0, 'msctls_updown32', nil);
      if Wnd <> 0 then begin
        if BtnSW <> nil then
          FreeAndNil(BtnSW);

        sp.SkinSection := s_UpDown;
        sp.Control := nil;
        BtnSW := TacSpinWnd.Create(Wnd, nil, SkinData.SkinManager, sp);
      end
      else
        if BtnSW <> nil then
          FreeAndNil(BtnSW);
    end;
end;


constructor TsTabControl.Create(AOwner: TComponent);
begin
  FCommonData := TsCommonData.Create(Self, True);
  FCommonData.COC := COC_TsTabControl;
  inherited Create(AOwner);
  BtnSW := nil;
  CurItem := -1;
end;


destructor TsTabControl.Destroy;
begin
  FreeAndNil(FCommonData);
  if BtnSW <> nil then
    FreeAndNil(BtnSW);

  inherited Destroy;
end;


procedure TsTabControl.DrawSkinTab(Index, State: integer; Bmp: TBitmap; OffsetPoint: TPoint);
var
  rText, aRect, R: TRect;
  VertFont: TLogFont;
  Buffer: array [0..4095] of AcChar;
  bFont, cFont: hfont;
  ItemData: {$IFDEF TNTUNICODE}TTCItemW{$ELSE}TTCItem{$ENDIF};
  Font: TFont;
  ImgList: HImageList;
  pFont: PLogFontA;
  i, h, w, iHeight, iWidth: integer;
  CI: TCacheInfo;
  TabsCovering, TabSkinIndex, {TabMask, }TabState: integer;
  TabSection: string;
  TempBmp: Graphics.TBitmap;
  SavedDC,MaskDC: hdc;
  lCaption: ACString;
  Flags: Cardinal;

  procedure MakeVertFont(Orient: integer);
  begin
    Font := TFont.Create;
    Font.Assign(Bmp.Canvas.Font);
    pFont := PLogFontA(@VertFont);
    GetObject(Bmp.Canvas.Handle, SizeOf(TLogFont), pFont);
    VertFont.lfEscapement := Orient;
    VertFont.lfHeight := Bmp.Canvas.Font.Height;
    VertFont.lfStrikeOut := integer(fsStrikeOut in Bmp.Canvas.Font.Style);
    VertFont.lfItalic := integer(fsItalic in Bmp.Canvas.Font.Style);
    VertFont.lfUnderline := integer(fsUnderline	in Bmp.Canvas.Font.Style);
    VertFont.lfWeight := FW_NORMAL;
    VertFont.lfCharSet := Bmp.Canvas.Font.Charset;

    VertFont.lfWidth := 0;
    Vertfont.lfOutPrecision := OUT_DEFAULT_PRECIS;
    VertFont.lfClipPrecision := CLIP_DEFAULT_PRECIS;
    VertFont.lfOrientation := VertFont.lfEscapement;
    VertFont.lfPitchAndFamily := Default_Pitch;
    VertFont.lfQuality := Default_Quality;
    if Font.Name <> 'MS Sans Serif' then
      StrPCopy(VertFont.lfFaceName, Font.Name)
    else
      VertFont.lfFaceName := 'Arial';

    Bmp.Canvas.Font.Handle := CreateFontIndirect(VertFont);
    Bmp.Canvas.Font.Color := SkinData.SkinManager.gd[TabSkinIndex].Props[integer(State > 0)].FontColor.Color;
  end;

  procedure KillVertFont;
  begin
    if Font <> nil then begin
      Bmp.Canvas.Font.Assign(Font);
      FreeAndNil(Font);
    end;
  end;

begin
  if Index >= 0 then begin
    bFont := LongWord(SendMessage(Handle, WM_GETFONT, 0, 0));
    cFont := SelectObject(Bmp.Canvas.Handle, bFont);

    R := SkinTabRect(Index, Index = TabIndex);
    if (State = 1) and (R.Left < 0) then
      Exit;

    rText := SkinTabRect(Index, (State = 2) and (Index = TabIndex));
    aRect := rText;

    ItemData.mask := TCIF_IMAGE or TCIF_STATE or TCIF_TEXT;
    ItemData.dwStateMask := TCIF_STATE;
    ItemData.pszText := Buffer;
    ItemData.cchTextMax := SizeOf(Buffer);

  {$IFDEF TNTUNICODE}
    SendMessage(Handle, TCM_GETITEMW, Index, LPARAM(@ItemData));
  {$ELSE}
    SendMessage(Handle, TCM_GETITEM, Index, LPARAM(@ItemData));
  {$ENDIF}
    lCaption := Buffer;
    TabsCovering := 0;
    // Tabs drawing
    with SkinData.SkinManager do
      if ConstData.Tabs[tlSingle][asTop].SkinIndex >= 0 then begin // new style
        TabState := State;
        case Style of
          tsTabs: begin
            TabSkinIndex := ConstData.Tabs[tlSingle][acTabSides[TabPosition]].SkinIndex;
//            TabMask      := ConstData.Tabs[tlSingle][acTabSides[TabPosition]].MaskIndex;
            TabSection   := ConstData.Tabs[tlSingle][acTabSides[TabPosition]].SkinSection;
            TabsCovering := CommonSkinData.TabsCovering;
          end;

          tsButtons: begin
            TabSection := s_Button;
            TabSkinIndex := GetSkinIndex(TabSection);
//            TabMask := GetMaskIndex(TabSection, s_BordersMask);
          end

          else begin
            TabSection := s_ToolButton;
            TabSkinIndex := GetSkinIndex(TabSection);
//            TabMask := GetMaskIndex(TabSection, s_BordersMask);
          end;
        end;
        if TabSkinIndex >= 0 then begin
          if FCommonData.SkinManager.gd[TabSkinIndex].States <= TabState then
            TabState := FCommonData.SkinManager.gd[TabSkinIndex].States - 1;

//        if IsValidImgIndex(TabMask) then begin // Drawing of tab
          TempBmp := CreateBmp32(aRect);
          try
            if (State = 2) and (Index = TabIndex) then
              with OffsetPoint do begin
                // Restore BG for Active tab
                BitBlt(TempBmp.Canvas.Handle, aRect.Left + x, aRect.Top + y, TempBmp.Width, TempBmp.Height,
                       SkinData.FCacheBmp.Canvas.Handle, aRect.Left, aRect.Top, SRCCOPY);
                OffsetRect(R, X, Y);
                BitBlt(TempBmp.Canvas.Handle, 0, 0, TempBmp.Width, TempBmp.Height,
                       SkinData.FCacheBmp.Canvas.Handle, SkinTabRect(Index, Index = TabIndex).Left,
                       SkinTabRect(Index, Index = TabIndex).Top, SRCCOPY);
                // Paint active tab
                BitBlt(Bmp.Canvas.Handle, aRect.Left + x, aRect.Top + y, TempBmp.Width, TempBmp.Height, TempBmp.Canvas.Handle, 0, 0, SRCCOPY);
                CI := MakeCacheInfo(TempBmp);
                PaintItem(TabSkinIndex, CI, True, TabState, MkRect(TempBmp),
                          Point(0, 0), Bmp, SkinData.SkinManager);
              end
            else begin
              CI := MakeCacheInfo(SkinData.FCacheBmp);
              if State = 1 then
                CI.X := 0;

              PaintItem(TabSkinIndex, CI, True, TabState, MkRect(TempBmp), aRect.TopLeft, TempBmp, SkinData.SkinManager);
              SavedDC := SaveDC(Bmp.Canvas.Handle);
              R := PageRect;
              if TabPosition in [tpLeft, tpTop] then
                ExcludeClipRect(Bmp.Canvas.Handle, R.Left, R.Top, R.Right, R.Bottom);

              BitBlt(Bmp.Canvas.Handle, aRect.Left + OffsetPoint.x, aRect.Top + OffsetPoint.y, TempBmp.Width, TempBmp.Height, TempBmp.Canvas.Handle, 0, 0, SRCCOPY);
              RestoreDC(Bmp.Canvas.Handle, SavedDC);
            end;
          finally
            FreeAndNil(TempBmp);
          end;
        end;
      end
      else
        TabState := 0;
    // End of tabs drawing
    if not (OwnerDraw and Assigned(OnDrawTab)) then begin
      // Drawing of the tab content
      OffsetRect(rText, OffsetPoint.x, OffsetPoint.y);
      R := rText;
      InflateRect(R, -3, -3);
      ImgList := SendMessage(Handle, TCM_GETIMAGELIST, 0, 0);
      Bmp.Canvas.Font.Assign(Self.Font);
      Flags := DT_CENTER or DT_SINGLELINE or DT_VCENTER;
      if UseRightToLeftReading then
        Flags := Flags or DT_RTLREADING;

      if TabPosition in [tpTop, tpBottom] then begin
        if TabsCovering > 0 then
          InflateRect(R, -TabsCovering * 2, 0);
      end
      else
        if TabsCovering > 0 then
          InflateRect(R, 0, -TabsCovering * 2);

      case TabPosition of
        tpTop, tpBottom: begin
          if (ImgList <> 0) and (ItemData.iImage >= 0) then begin
            ImageList_GetIconSize(ImgList, w, h);
            Images.Draw(Bmp.Canvas, rText.Left + (WidthOf(rText) - (acTextWidth(Bmp.Canvas, lCaption) + Images.Width + 8)) div 2,
                        rText.Top + (HeightOf(rText) - Images.Height) div 2, ItemData.iImage, True);
            inc(rText.Left, w);
          end;
          R := rText;
          acWriteTextEx(Bmp.Canvas, PacChar(lCaption), True, rText, Flags, TabSkinIndex, TabState <> 0, SkinData.SkinManager);
        end;

        tpLeft: begin
          Bmp.Canvas.Brush.Style := bsClear;
          MakeVertFont(-2700);
          with acTextExtent(bmp.Canvas, lCaption) do begin
            h := cx;
            w := cy;
          end;
          if (ImgList <> 0) and (ItemData.iImage >= 0) then begin
            ImageList_GetIconSize(ImgList, iWidth, iHeight);
            if Index = TabIndex then
              OffsetRect(rText, 2, 0);

            i := rText.Bottom - (HeightOf(rText) - (iHeight + 4 + h)) div 2 - iHeight;
            Images.Draw(Bmp.Canvas, rText.Left + (WidthOf(rText) - Images.Width) div 2, i, ItemData.iImage, Enabled);
            Bmp.Canvas.Brush.Style := bsClear;
            acTextRect(bmp.Canvas, rText, rText.Left + (WidthOf(rText) - w) div 2, i - 4, lCaption);
            InflateRect(rText, (w - WidthOf(rText)) div 2, (h - HeightOf(rText)) div 2 + 2);
            OffsetRect(rText, 0, - (4 + h) div 2);
          end
          else begin
            Bmp.Canvas.Brush.Style := bsClear;
            acTextRect(Bmp.Canvas, rText, rText.Left + (WidthOf(rText) - w) div 2, rText.Bottom - (HeightOf(rText) - h) div 2, lCaption);
            InflateRect(rText, (w - WidthOf(rText)) div 2, (h - HeightOf(rText)) div 2);
          end;
          KillVertFont;
        end;

        tpRight: begin
          Bmp.Canvas.Brush.Style := bsClear;
          MakeVertFont(-900);
          OffsetRect(rText, -2, -1);
          with acTextExtent(bmp.Canvas, lCaption) do begin
            h := cx;
            w := cy;
          end;
          if (ImgList <> 0) and (ItemData.iImage >= 0) then begin
            ImageList_GetIconSize(ImgList, iWidth, iHeight);
            if Index = TabIndex then
              OffsetRect(rText, 2, 0);

            i := rText.Top + (HeightOf(rText) - (iHeight + 4 + h)) div 2;
            Images.Draw(Bmp.Canvas, rText.Left + (WidthOf(rText) - Images.Width) div 2, i, ItemData.iImage, Enabled);
            Bmp.Canvas.Brush.Style := bsClear;
            acTextRect(Bmp.Canvas, rText, rText.Left + (WidthOf(rText) - w) div 2 + Bmp.Canvas.TextHeight(lCaption), i + 4 + iHeight, lCaption);
            InflateRect(rText, (w - WidthOf(rText)) div 2, (h - HeightOf(rText)) div 2 + 2);
            OffsetRect(rText, 0, + (4 + iHeight) div 2);
          end
          else begin
            Bmp.Canvas.Brush.Style := bsClear;
            acTextRect(Bmp.Canvas, rText, rText.Left + (WidthOf(rText) + w) div 2, rText.Top + (HeightOf(rText) - h) div 2, lCaption);
            InflateRect(rText, (w - WidthOf(rText)) div 2, (h - HeightOf(rText)) div 2 + 2);
          end;
          KillVertFont;
        end;
      end;
    end
    else begin
      Bmp.Canvas.Lock;
      R := SkinTabRect(Index, Index = TabIndex);
      InflateRect(R, -3, -3);
      if Bmp <> SkinData.FCacheBmp then
      begin
        aRect :=TabsRect;
        TempBmp := CreateBmp32(aRect);
        MaskDC := CreateCompatibleDC(0);
        try
          TempBmp.Canvas.Lock;
          TempBmp.Canvas.FillRect(aRect);
          Canvas.Handle := TempBmp.Canvas.Handle;
          OnDrawTab(Self, Index, R, Index = TabIndex);
          TempBmp.Canvas.Unlock;
          SelectObject(MaskDC, TempBmp.MaskHandle);
          TransparentStretchBlt(Bmp.Canvas.Handle, 3, 3, WidthOf(R), HeightOf(R),
            TempBmp.Canvas.Handle, R.Left, R.Top, WidthOf(R), HeightOf(R), MaskDC, R.Left, R.Top);
        finally
          DeleteDC(MaskDC);
          FreeAndNil(TempBmp);
        end;
      end
      else
      begin
        Canvas.Handle := Bmp.Canvas.Handle;
        OnDrawTab(Self, Index, R, Index = TabIndex);
      end;
      Bmp.Canvas.Unlock;
    end;
    SelectObject(Bmp.Canvas.Handle, cFont);
  end;
end;


procedure TsTabControl.DrawSkinTab(Index, State: integer; DC: hdc);
var
  aRect: TRect;
  TempBmp: TBitmap;
begin
  if Index >= 0 then begin
    aRect := SkinTabRect(Index, State = 2);
    TempBmp := CreateBmp32(aRect);
    DrawSkinTab(Index, State, TempBmp, Point(-aRect.Left, -aRect.Top));
    BitBlt(DC, aRect.Left, aRect.Top, WidthOf(aRect), HeightOf(aRect), TempBmp.Canvas.Handle, 0, 0, SRCCOPY);
    FreeAndNil(TempBmp);
  end;
end;


procedure TsTabControl.DrawSkinTabs(const CI: TCacheInfo);
var
  i, Row, rc: integer;
  aRect: TRect;
begin
  aRect := TabsRect;
  with SkinData.FCacheBmp.Canvas do
    if not ci.Ready then begin
      Brush.Style := bsSolid;
      Brush.Color := CI.FillColor;
      FillRect(aRect);
    end
    else
      BitBlt(Handle, aRect.Left, aRect.Top, min(WidthOf(aRect), ci.Bmp.Width), min(HeightOf(aRect), ci.Bmp.Height),
             ci.Bmp.Canvas.Handle, ci.X + Left + aRect.Left, ci.Y + Top + aRect.Top, SRCCOPY);
  // Draw tabs in special order
  rc := TabCtrl_GetRowCount(Handle);
  for Row := 1 to rc do
    for i := 0 to Tabs.Count - 1 do
      if (i <> TabIndex) and (TabRow(i) = Row) then
        DrawSkinTab(i, 0, SkinData.FCacheBmp, MkPoint);
end;


function TsTabControl.GetClRect: TRect;
begin
  Result := MkRect(Self);
  SendMessage(Handle, TCM_ADJUSTRECT, 0, LPARAM(@Result));
  Inc(Result.Top, 2);
end;


function TsTabControl.GetTabUnderMouse(p: TPoint): integer;
var
  i: integer;
  R: TRect;
begin
  Result := -1;
  for i := 0 to Tabs.Count - 1 do begin
    R := SkinTabRect(i, False);
    if PtInRect(R, p) then begin
      Result := i;
      Exit;
    end;
  end;
end;


procedure TsTabControl.Loaded;
begin
  inherited Loaded;
  SkinData.Loaded;
  CheckUpDown;
end;


function TsTabControl.PageRect: TRect;
var
  clRect: TRect;
begin
  Result := MkRect(Self);
  if Tabs.Count > 0 then begin
    clRect := GetClRect;
    case TabPosition of
      tpTop:    Result.Top    := clRect.Top    - TopOffset;
      tpBottom: Result.Bottom := clRect.Bottom + BottomOffset;
      tpLeft:   Result.Left   := clRect.Left   - LeftOffset;
      tpRight:  Result.Right  := clRect.Right  + RightOffset;
    end;
  end;
end;


procedure TsTabControl.RepaintTab(i, State: integer; TabDC: hdc);
var
  DC, SavedDC: hdc;
  R: TRect;
  PS: TPaintStruct;
begin
  BeginPaint(Handle, PS);
  if TabDC = 0 then
    DC := GetDC(Handle)
  else
    DC := TabDC;

  SavedDC := SaveDC(DC);
  try
    R := TabRect(i);
    if TabDC <> 0 then
      OffsetRect(R, - R.Left, - R.Top)
    else begin
      InterSectClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
      R := SkinTabRect(TabIndex, True);
      ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
    end;
    DrawSkinTab(i, State, DC);
  finally
    RestoreDC(DC, SavedDC);
    if TabDC = 0 then
      ReleaseDC(Handle, DC);

    EndPaint(Handle, PS);
  end;
end;


function TsTabControl.SkinTabRect(Index: integer; Active: boolean): TRect;
var
  aTabsCovering: integer;
begin
  Result := MkRect;
  if not IsValidIndex(Index, Tabs.Count) or (Tabs.Count < 1) then
    Exit;

  Result := TabRect(Index);
  if (Style <> tsTabs) or (Result.Left = Result.Right) then
    Exit;

  aTabsCovering := 0;
  if Style = tsTabs then
    aTabsCovering := SkinData.SkinManager.CommonSkinData.TabsCovering;

  if Active then
    dec(Result.Bottom, 1)
  else begin
    inc(Result.Bottom, 3);
    dec(Result.Right, 1);
  end;

  case TabPosition of
    tpTop: begin
      InflateRect(Result, 2 * Integer(Active), 2 * Integer(Active));
      inc(Result.Bottom, 1);
    end;

    tpBottom: begin
      InflateRect(Result, 2 * Integer(Active), Integer(Active));
      dec(Result.Top, 2);
      if Active then
        inc(Result.Bottom)
      else
        dec(Result.Bottom, 3);
    end;

    tpLeft: begin
      InflateRect(Result, 0, 1);
      inc(Result.Right, 2);
      if Active then
        InflateRect(Result, 1, 1)
      else begin
        dec(Result.Bottom, 4);
        inc(Result.Right, 2);
      end;
    end;

    tpRight: begin
      InflateRect(Result, 1, 0);
      OffsetRect(Result, -1, -1);
      if Active then begin
        InflateRect(Result, 1, 1);
        inc(Result.Bottom, 3);
      end
      else
        dec(Result.Bottom, 2);
    end;
  end;
  if TabPosition in [tpTop, tpBottom] then begin
    if aTabsCovering > 0 then begin
      OffsetRect(Result, aTabsCovering, 0);
      InflateRect(Result, aTabsCovering, 0);
    end;
  end
  else
    if aTabsCovering > 0 then begin
      OffsetRect(Result, 0, aTabsCovering);
      InflateRect(Result, 0, aTabsCovering);
    end;
end;


function TsTabControl.TabRow(TabIndex: integer): integer;
var
  h, w, rCount: integer;
  R, tR: TRect;
begin
  rCount := TabCtrl_GetRowCount(Handle);
  if rCount > 1 then begin
    R := TabRect(TabIndex);
    tR := TabsRect;
    w := WidthOf(R) + 1;
    h := HeightOf(R) + 1;
    case TabPosition of
      tpTop:   Result := (R.Bottom + h div 2) div h;
      tpLeft:  Result := (R.Right +  w div 2) div w;
      tpRight: Result := rCount - (R.Right - tR.Left + w div 2) div w + 1
      else     Result := rCount - (R.Bottom - tR.Top + h div 2) div h + 1;
    end;
  end
  else
    Result := 1;
end;


function TsTabControl.TabsRect: TRect;
var
  r: TRect;
begin
  Result := MkRect(Self);
  if Tabs.Count > 0 then begin
    r := GetClRect;
    case TabPosition of
      tpTop:    Result.Bottom := R.Top    - TopOffset;
      tpBottom: Result.Top    := R.Bottom + BottomOffset;
      tpLeft:   Result.Right  := R.Left   - LeftOffset;
      tpRight:  Result.Left   := R.Right  + RightOffset;
    end;
  end;
end;


procedure TsTabControl.WndProc(var Message: TMessage);
var
  R: TRect;
  p: TPoint;
  b: boolean;
  NewItem: integer;
  PS: TPaintStruct;
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

      AC_REMOVESKIN: begin
        if Message.LParam = LPARAM(SkinData.SkinManager) then begin
          CommonMessage(Message, FCommonData);
          CheckUpDown;
          if BtnSW <> nil then
            FreeAndNil(BtnSW);

          RedrawWindow(Handle, nil, 0, RDWA_ALLNOW);
        end;
        AlphaBroadcast(Self, Message);
      end;

      AC_REFRESH:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          CommonMessage(Message, FCommonData);
          Repaint;
          SendMessage(Handle, WM_NCPAINT, 0, 0);
          CheckUpDown;
          AlphaBroadcast(Self, Message);
          Exit;
        end;

      AC_SETNEWSKIN:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          AlphaBroadcast(Self, Message);
          CommonMessage(Message, FCommonData);
          Exit;
        end;

      AC_PREPARING: begin
        Message.Result := LRESULT(FCommonData.FUpdating);
        Exit;
      end;

      AC_ENDPARENTUPDATE:
        if SkinData.Skinned and SkinData.Updating then begin
          SkinData.FUpdating := False;
          InvalidateRect(Handle, nil, True);
          Exit;
        end;

      AC_GETOUTRGN: begin
        PRect(Message.LParam)^ := PageRect;
        OffsetRect(PRect(Message.LParam)^, Left, Top);
        Exit;
      end;

      AC_GETDEFINDEX: begin
        if FCommonData.SkinManager <> nil then
          Message.Result := FCommonData.SkinManager.GetSkinIndex(s_PageControl + sTabPositions[TabPosition]) + 1;

        Exit;
      end;

      AC_GETBG:
        if SkinData.Skinned then begin
          CommonMessage(Message, SkinData);
          Exit;
        end;
    end;
    if Assigned(FCommonData) then begin
      if CommonWndProc(Message, FCommonData) and (Message.Msg = SM_ALPHACMD) then
        Exit;

      if FCommonData.Skinned then
        if Message.Msg <> SM_ALPHACMD then
          case Message.Msg of
            WM_PRINT: begin
              AC_WMPaint(TWMPaint(Message));
              Exit;
            end;

            WM_NCPAINT:
              if IsWindowVisible(Handle) then begin
                if not InAnimationProcess then
                  AC_WMPaint(TWMPaint(Message));

                Message.Result := 0;
                Exit;
              end;

            WM_ERASEBKGND:
              if IsWindowVisible(Handle) then begin
                if not InAnimationProcess then
                  AC_WMPaint(TWMPaint(Message));

                Message.Result := 0;
                Exit;
              end;

            WM_PAINT: begin
              if not (csDestroying in ComponentState) and (Parent <> nil) then // Background update
                InvalidateRect(Handle, nil, True); // Background update (for repaint of graphic controls and for tansheets refreshing)

              BeginPaint(Handle, PS);
              EndPaint(Handle, PS);
              Exit;
            end;

            CM_VISIBLECHANGED, WM_MOUSEWHEEL:
              if FCommonData.Skinned and ([csReading, csLoading] * ComponentState = []) then begin
                FCommonData.BGChanged := True;
                Repaint;
                if not FCommonData.Updating then
                  FCommonData.BGChanged := False;
              end;

            WM_SETFOCUS, CM_ENTER, WM_KILLFOCUS, CM_EXIT:
              if FCommonData.Skinned and TabStop then begin
                FCommonData.FFocused := (Message.Msg = CM_ENTER) or (Message.Msg = WM_SETFOCUS);
                FCommonData.FMouseAbove := False;
                FCommonData.BGChanged := True;
                if ([csReading, csLoading] * ComponentState = []) and not (csCreating in ControlState) then begin
                  Repaint;
                  SendMessage(Handle, WM_NCPAINT, 0, 0);
                  if not FCommonData.Updating then
                    FCommonData.BGChanged := False;
                end;
              end;

            CM_MOUSEENTER:
              if not FCommonData.FFocused and not (csDesigning in ComponentState) then
                FCommonData.FMouseAbove := Message.Msg = CM_MOUSEENTER;

            WM_WINDOWPOSCHANGING:
              FCommonData.BGChanged := True;

            WM_MOUSELEAVE, CM_MOUSELEAVE:
              if not (csDesigning in ComponentState) and HotTrack then begin
                inherited;
                if (CurItem >= 0) and (CurItem <> TabIndex) then
                  if HotTrack then
                    RepaintTab(CurItem, 0);

                CurItem := -1;
                Exit;
              end;

            WM_MOUSEMOVE:
              if not (csDesigning in ComponentState) then begin
                if (DefaultManager <> nil) and not (csDesigning in DefaultManager.ComponentState) then
                  DefaultManager.ActiveControl := 0;

                b := HotTrack or (Style <> tsTabs);
                if b then begin
                  p.x := TCMHitTest(Message).XPos;
                  p.y := TCMHitTest(Message).YPos;
                  if PtInRect(TabsRect, p) then begin
                    Application.ProcessMessages;
                    NewItem := GetTabUnderMouse(p);
                    if NewItem <> CurItem then begin // if changed
                      if CurItem >= 0 then begin
                        if HotTrack then
                          if b then
                            RepaintTab(CurItem, 0);
                      end;
                      inherited;
                      CurItem := NewItem;
                      if (CurItem >= 0) and HotTrack then
                        if TabIndex <> CurItem then begin
                          if b then
                            RepaintTab(CurItem, integer(HotTrack));
                        end
                        else
                          CurItem := -1;
                    end;
                  end
                  else
                    if CurItem >= 0 then begin
                      if b then
                        RepaintTab(CurItem, 0);

                      CurItem := -1;
                    end;
                end;
              end;
          end
    end;

  inherited;
  if (SkinData <> nil) and SkinData.Skinned then
    case Message.Msg of
      CN_NOTIFY:
        case TWMNotify(Message).NMHdr^.code of
          TCN_SELCHANGE:
            if Style in [tsButtons, tsFlatButtons] then begin
              SkinData.BGChanged := True;
              RedrawWindow(Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE);
            end;
        end;

      TCM_SETCURSEL:
        RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE);

      WM_SIZE: begin
        CheckUpDown;
        GetWindowRect(Handle, R);
        if (WidthOf(R) < Width) or (HeightOf(R) < Height) then
          RedrawWindow(Handle, nil, 0, RDWA_NOCHILDREN);
      end;

      WM_MOVE:
        if [csReading, csLoading] * ComponentState = [] then
          Repaint;
    end;
end;

end.
