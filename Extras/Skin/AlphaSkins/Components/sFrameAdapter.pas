unit sFrameAdapter;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  sConst, sCommondata, acSBUtils;


type
{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsFrameAdapter = class(TComponent)
{$IFNDEF NOTFORHELP}
  protected
    FCommonData: TsScrollWndData;
    function PrepareCache: boolean;
    procedure OurPaintHandler(aDC: hdc);
    procedure AC_WMPaint(const aDC: hdc);
  public
    Frame: TFrame;
    OldWndProc: TWndMethod;
    ListSW: TacScrollWnd;
    procedure Loaded; override;
    procedure AfterConstruction; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure NewWndProc(var Message: TMessage);
{$ENDIF} // NOTFORHELP
  published
    property SkinData: TsScrollWndData read FCommonData write FCommonData;
  end;


implementation

uses
  menus,
  sVclUtils, sBorders, sGraphUtils, sSkinProps, sSkinManager, acntUtils, sMessages, sStyleSimply, sSpeedButton;


const
  sWinControlForm = 'TWinControlForm';


procedure TsFrameAdapter.AC_WMPaint(const aDC: hdc);
var
  DC, SavedDC: hdc;
  PS: TPaintStruct;
begin
  if not (csDestroying in Frame.ComponentState) and (Frame.Parent <> nil) and not IsCached(FCommonData) then
    InvalidateRect(Frame.Handle, nil, True); // Background update (for repaint of graphic controls and for a frame refreshing)

  BeginPaint(Frame.Handle, PS);
  if aDC = 0 then
    DC := GetDC(Frame.Handle)
  else
    DC := aDC;

  SavedDC := SaveDC(DC);
  try
    if IsCached(FCommonData) then
      if not InUpdating(FCommonData) then
        OurPaintHandler(DC);
  finally
    RestoreDC(DC, SavedDC);
    if aDC = 0 then
      ReleaseDC(Frame.Handle, DC);
      
    EndPaint(Frame.Handle, PS);
  end;
end;


procedure TsFrameAdapter.AfterConstruction;
begin
  inherited;
  if Assigned(Frame) {and (GetBoolMsg(Frame, AC_CTRLHANDLED) or not Frame.HandleAllocated)} then begin
//    SendAMessage(Frame.Handle, AC_SETNEWSKIN, LParam(SkinData.SkinManager));
    FCommonData.InitCommonProp;
    Frame.Perform(SM_ALPHACMD, MakeWParam(0, AC_SETNEWSKIN), LParam(SkinData.SkinManager));
  end;
end;


constructor TsFrameAdapter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if not (AOwner is TCustomFrame) then begin
    Frame := nil;
    Raise Exception.Create(acs_FrameAdapterError1);
  end;
  FCommonData := TsScrollWndData.Create(Self, True);
  if (FCommonData.SkinSection = ClassName) or (FCommonData.SkinSection = '') then
    FCommonData.SkinSection := s_GroupBox;

  FCommonData.COC := COC_TsFrameAdapter;
  Frame := TFrame(AOwner);
  FCommonData.FOwnerControl := TControl(AOwner);
  if Frame <> nil then begin
    OldWndProc := Frame.WindowProc;
    Frame.WindowProc := NewWndProc;
  end;
  FCommonData.InitCommonProp;
end;


destructor TsFrameAdapter.Destroy;
begin
  if ListSW <> nil then
    FreeAndNil(ListSW);

  if (Frame <> nil) and Assigned(OldWndProc) then
    Frame.WindowProc := OldWndProc;

  Frame := nil;
  if FCommonData <> nil then
    FreeAndNil(FCommonData);

  inherited Destroy;
end;


procedure TsFrameAdapter.Loaded;
var
  i: integer;
begin
  inherited Loaded;
  if Assigned(Frame) and GetBoolMsg(Frame, AC_CTRLHANDLED) and Assigned(SkinData) and Assigned(SkinData.SkinManager) then
    with SkinData.SkinManager do begin
      SkinData.UpdateIndexes;
      if CommonSkinData.Active and not (csDesigning in ComponentState) then begin
        if (csDesigning in Frame.ComponentState) and // Updating of form color in design-time
             (Frame.Parent.ClassName = sWinControlForm) and
               FCommonData.SkinManager.IsValidSkinIndex(FCommonData.SkinManager.ConstData.IndexGlobalInfo) then
          TsHackedControl(Frame.Parent).Color := gd[FCommonData.SkinManager.ConstData.IndexGlobalInfo].Props[0].Color;
        // Popups initialization
        for i := 0 to Frame.ComponentCount - 1 do
          if (Frame.Components[i] is TPopupMenu) and SkinnedPopups then
            SkinableMenus.HookPopupMenu(TPopupMenu(Frame.Components[i]), True);

        if SkinData.Skinned and (srThirdParty in SkinningRules) then
          AddToAdapter(Frame);
      end;

      FCommonData.InitCommonProp;
    end;
end;


procedure TsFrameAdapter.NewWndProc(var Message: TMessage);
var
  i: integer;
  m: TMessage;
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  if csDesigning in ComponentState then
    OldWndProc(Message)
  else begin
    case Message.Msg of
      SM_ALPHACMD:
        case Message.WParamHi of
          AC_CTRLHANDLED: begin
            Message.Result := 1;
            Exit;
          end;

          AC_SETNEWSKIN:
            if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
              AlphaBroadCast(Frame, Message);
              CommonWndProc(Message, FCommonData);
              if Assigned(SkinData.SkinManager) then begin
                for i := 0 to Frame.ComponentCount - 1 do
                  if (Frame.Components[i] is TPopupMenu) and SkinData.SkinManager.SkinnedPopups then
                    SkinData.SkinManager.SkinableMenus.HookPopupMenu(TPopupMenu(Frame.Components[i]), True);

  {$IFDEF CHANGEFORMSINDESIGN}
                if (csDesigning in Frame.ComponentState) and // Updating of form color in design-time
                     (Frame.Parent.ClassName = sWinControlForm) and
                       (FCommonData.SkinManager.ConstData.IndexGlobalInfo > -1) then
                  TsHackedControl(Frame.Parent).Color := SkinData.SkinManager.gd[FCommonData.SkinManager.ConstData.IndexGlobalInfo].Props[0].Color;
  {$ENDIF}
              end;
              Exit;
            end;

          AC_REFRESH:
            if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
              CommonWndProc(Message, FCommonData);
              FCommonData.UpdateIndexes;
              if Assigned(FCommonData.SkinManager) then begin
  {$IFDEF CHANGEFORMSINDESIGN}
                if (csDesigning in Frame.ComponentState) and // Updating of form color in design-time
                     (Frame.Parent.ClassName = sWinControlForm) and
                       (FCommonData.SkinManager.ConstData.IndexGlobalInfo >= 0) then
                  TsHackedControl(Frame.Parent).Color := SkinData.SkinManager.gd[FCommonData.SkinManager.ConstData.IndexGlobalInfo].Props[0].Color;
  {$ENDIF}

                if Message.WParamLo <> 1 then
                  AlphaBroadcast(Frame, Message);

                RedrawWindow(Frame.Handle, nil, 0, RDW_ERASE or RDW_UPDATENOW or RDW_INVALIDATE or RDW_ALLCHILDREN or RDW_FRAME);
                RefreshScrolls(SkinData, ListSW);
              end;
              Exit;
            end;

          AC_STOPFADING: begin
            AlphaBroadcast(Frame, Message);
            Exit;
          end;

          AC_BEFORESCROLL:
            if GetBoolMsg(Frame, AC_CHILDCHANGED) or FCommonData.RepaintIfMoved then
              Frame.Perform(WM_SETREDRAW, 0, 0);

          AC_AFTERSCROLL:
            if GetBoolMsg(Frame, AC_CHILDCHANGED) or FCommonData.RepaintIfMoved then begin
              Frame.Perform(WM_SETREDRAW, 1, 0);
              RedrawWindow(Frame.Handle, nil, 0, RDW_UPDATENOW or RDW_INVALIDATE or RDW_ALLCHILDREN or RDW_FRAME);
            end;

          AC_REMOVESKIN:
            if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
              if ListSW <> nil then
                FreeAndNil(ListSW);

              CommonWndProc(Message, FCommonData);
              if (csDesigning in Frame.ComponentState) and // Updating of form color in design-time
                   Assigned(Frame.Parent) and
                     (Frame.Parent.ClassName = sWinControlForm) then
                TsHackedControl(Frame.Parent).Color := clBtnFace;

              if not Application.Terminated then begin
                SetWindowPos(Frame.Handle, 0, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_FRAMECHANGED);
                RedrawWindow(Frame.Handle, nil, 0, RDW_ERASE or RDW_UPDATENOW or RDW_INVALIDATE or RDW_ALLCHILDREN or RDW_FRAME);
                Application.ProcessMessages; // Repaint graphic controls
              end;
              AlphaBroadcast(Frame, Message);
              Exit;
            end;

          AC_PREPARECACHE: begin
            if not InUpdating(SkinData) and not PrepareCache then
              SkinData.Updating := True;

            Exit;
          end;

          AC_GETDEFINDEX: begin
  {$IFNDEF ALITE}
            if (SkinData.SkinSection <> '') then begin
              SkinData.UpdateIndexes;
              Message.Result := SkinData.SkinIndex + 1;
            end
            else
  {$ENDIF}
              if SkinData.SkinManager <> nil then
                Message.Result := SkinData.SkinManager.ConstData.Sections[ssTransparent] + 1;

            Exit;
          end;

          AC_GETSKININDEX: begin
            PacSectionInfo(Message.LParam)^.SkinIndex := FCommonData.SkinIndex;
            Exit;
          end;
        end;

      WM_SIZE:
        SkinData.BGChanged := True;
    end;

    if (csDestroying in ComponentState) or
         (csDestroying in Frame.ComponentState) or
           not FCommonData.Skinned or
             not ((SkinData.SkinManager <> nil) and
               SkinData.SkinManager.CommonSkinData.Active) then begin
      if SkinData.SkinManager <> nil then
        if SkinData.SkinManager.CommonSkinData.Active then
          case Message.Msg of
            CM_SHOWINGCHANGED, CM_VISIBLECHANGED:
              if Assigned(Frame) and Frame.HandleAllocated then begin
                SkinData.UpdateIndexes;
                UpdateSkinState(SkinData, True);
                m := MakeMessage(SM_ALPHACMD, MakeWParam(AC_SETNEWSKIN, AC_SETNEWSKIN), LPARAM(SkinData.SkinManager), 0);
                AlphaBroadCast(Frame, m);
              end;
          end;

      OldWndProc(Message);
    end
    else
      case Message.Msg of
        SM_ALPHACMD:
          case Message.WParamHi of
            AC_CHILDCHANGED: begin
              if (SkinData.SkinIndex < 0) or not Assigned(SkinData.SkinManager) then
                Message.LParam := 0
              else
                Message.LParam := LPARAM((SkinData.SkinManager.gd[SkinData.SkinIndex].Props[0].GradientPercent +
                                          SkinData.SkinManager.gd[SkinData.SkinIndex].Props[0].ImagePercent > 0) or
                                         SkinData.RepaintIfMoved);
              Message.Result := Message.LParam;
              Exit;
            end;

            AC_UPDATING: begin
              FCommonData.Updating := Message.WParamLo = 1;
              for i := 0 to Frame.ControlCount - 1 do
                Frame.Controls[i].Perform(Message.Msg, Message.WParam, Message.LParam);

              Exit;
            end;

            AC_ENDPARENTUPDATE: begin
              if FCommonData.FUpdating {$IFDEF D2006} and not (csRecreating in Frame.ControlState) and not (csAligning in Frame.ControlState) {$ENDIF} then begin
                if not InUpdating(FCommonData, True) then begin
                  if SkinData.BGChanged and Assigned(Frame.OnResize) then begin
                    RedrawWindow(Frame.Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW or RDW_ERASE or RDW_FRAME);
                    Frame.OnResize(Frame);
                  end
                  else
                    RedrawWindow(Frame.Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW or RDW_ERASE or RDW_FRAME);

                  SetParentUpdated(Frame);
                end;
              end
              else
                if SkinData.CtrlSkinState and ACS_FAST = ACS_FAST then
                  SetParentUpdated(Frame);

              Exit;
            end;

            AC_PREPARECACHE: begin
              if not PrepareCache then
                SkinData.Updating := True;

              Exit;
            end;

            AC_GETCONTROLCOLOR:
              if SkinData.Skinned then
                if not IsCached(SkinData) then
                  case SkinData.SkinManager.gd[SkinData.Skinindex].Props[0].Transparency of
                    0:
                      Message.Result := LRESULT(SkinData.SkinManager.gd[SkinData.Skinindex].Props[0].Color);

                    100:
                      if Frame.Parent <> nil then begin
                        Message.Result := Frame.Parent.Perform(SM_ALPHACMD, MakeWParam(0, AC_GETCONTROLCOLOR), 0);
                        if Message.Result = clFuchsia {if AlphaMessage not supported} then
                          Message.Result := LRESULT(TsHackedControl(Frame.Parent).Color)
                      end
                      else
                        Message.Result := LRESULT(ColorToRGB(Frame.Color));

                    else begin
                      if Frame.Parent <> nil then
                        Message.Result := Frame.Parent.Perform(SM_ALPHACMD, MakeWParam(0, AC_GETCONTROLCOLOR), 0)
                      else
                        Message.Result := LRESULT(ColorToRGB(Frame.Color));
                      // Mixing of colors
                      C1.C := TColor(Message.Result);
                      C2.C := SkinData.SkinManager.gd[SkinData.Skinindex].Props[0].Color;
                      C1.R := ((C1.R - C2.R) * SkinData.SkinManager.gd[SkinData.SkinIndex].Props[0].Transparency + C2.R shl 8) shr 8;
                      C1.G := ((C1.G - C2.G) * SkinData.SkinManager.gd[SkinData.SkinIndex].Props[0].Transparency + C2.G shl 8) shr 8;
                      C1.B := ((C1.B - C2.B) * SkinData.SkinManager.gd[SkinData.SkinIndex].Props[0].Transparency + C2.B shl 8) shr 8;
                      Message.Result := LRESULT(C1.C);
                    end
                  end
                else begin
                  if SkinData.CtrlSkinState and ACS_BGUNDEF = ACS_BGUNDEF then
                    UpdateSkinState(SkinData, False);

                  Message.LParam := LRESULT(clFuchsia);
                end
              else
                if Assigned(Frame) then
                  Message.LParam := LPARAM(ColorToRGB(TsHackedControl(Frame).Color));

            else
              try
                if CommonMessage(Message, FCommonData) then
                  Exit;
              except
                Exit;
              end;
          end;

        WM_CREATE, WM_NCCREATE: begin
          OldWndProc(Message);
          if Frame.HandleAllocated then
            SkinData.InitCommonProp;
        end;

        CM_MOUSEENTER:
          if not (csDesigning in ComponentState) then begin
            OldWndProc(Message);
            for i := 0 to Frame.ControlCount - 1 do
              if (Frame.Controls[i] is TsSpeedButton) and
                   (Frame.Controls[i] <> Pointer(Message.LParam)) and
                     TsSpeedButton(Frame.Controls[i]).SkinData.FMouseAbove then
                Frame.Controls[i].Perform(CM_MOUSELEAVE, 0, 0);

            if DefaultManager <> nil then
              DefaultManager.ActiveControl := Frame.Handle;
          end;

        CM_VISIBLECHANGED: begin
          FCommonData.BGChanged := True;
          UpdateSkinState(SkinData, True);
          OldWndProc(Message);
          if Assigned(SkinData.SkinManager) then
            Frame.Perform(SM_ALPHACMD, MakeWParam(0, AC_REFRESH), LongWord(SkinData.SkinManager));
        end;

        WM_WINDOWPOSCHANGED, WM_SIZE, WM_MOVE: begin
          FCommonData.BGChanged := FCommonData.BGChanged or (Message.Msg = WM_SIZE) or FCommonData.RepaintIfMoved;
          if FCommonData.BGChanged then begin
            m := MakeMessage(SM_ALPHACMD, MakeWParam(1, AC_SETBGCHANGED), 0, 0);
            Frame.BroadCast(m);
          end;
          if Message.Msg <> WM_MOVE then
            InvalidateRect(Frame.Handle, nil, True);

          OldWndProc(Message);
        end;

        WM_PARENTNOTIFY:
          if (Message.WParamLo in [WM_CREATE, WM_DESTROY]) and not (csLoading in ComponentState) and not (csCreating in Frame.ControlState) then begin
            if (Message.WParamLo = WM_CREATE) and (srThirdParty in SkinData.SkinManager.SkinningRules) then
              AddToAdapter(Frame);

            OldWndProc(Message);
            UpdateScrolls(ListSW, False);
          end
          else
            OldWndProc(Message);

        CM_SHOWINGCHANGED: begin
          UpdateSkinState(SkinData, True);
          OldWndProc(Message);
          RefreshScrolls(SkinData, ListSW);
          if (srThirdParty in SkinData.SkinManager.SkinningRules) then
            AddToAdapter(Frame);
        end;

        WM_PAINT:
          if (csDesigning in Frame.ComponentState) or (Frame.Parent = nil) or (csDestroying in ComponentState) then
            OldWndProc(Message)
          else begin
            AC_WMPaint(TWMPaint(Message).DC);
            Message.Result := 0;
          end;

        WM_PRINT:
          if FCommonData.Skinned then begin
            FCommonData.FUpdating := False;
            if ControlIsReady(Frame) then begin
              OurPaintHandler(TWMPaint(Message).DC);
              Ac_NCDraw(ListSW, Frame.Handle, -1, TWMPaint(Message).DC); // Scrolls painting
              if Assigned(Frame.OnResize) then
                Frame.OnResize(Frame);
            end;
          end
          else
            OldWndProc(Message);

        WM_NCPAINT:
          if csDesigning in Frame.ComponentState then
            OldWndProc(Message)
          else
            if not InUpdating(FCommonData) then
              Message.Result := 0;

        WM_ERASEBKGND:
          if (csDesigning in Frame.ComponentState) or not Frame.Showing then
            OldWndProc(Message)
          else
            if not InAnimationProcess then begin
              if not InUpdating(FCommonData) and (not IsCached(FCommonData) or not FCommonData.BGChanged) then
                OurPaintHandler(TWMPaint(Message).DC);

              Message.Result := 1;
            end;

        else
          OldWndProc(Message);
      end;
  end;
end;


procedure TsFrameAdapter.OurPaintHandler(aDC: hdc);
var
  R: TRect;
  i: integer;
  Changed: boolean;
  DC, SavedDC: hdc;
  BGInfo: TacBGInfo;

  procedure FillBG(aRect: TRect);
  begin
    FillDC(DC, aRect, GetBGColor(SkinData, 0))
  end;

begin
  if (aDC <> 0) and (not InAnimationProcess or (aDC = SkinData.PrintDC)) then begin
    DC := aDC;
    if IsCached(FCommonData) then begin
      SavedDC := SaveDC(DC);
      if not InUpdating(FCommonData) then begin
        Changed := True;
        if (FCommonData.BorderIndex < 0) and (FCommonData.SkinManager.gd[FCommonData.SkinIndex].Props[0].Transparency = 100) and not HaveOuterEffects(SkinData) then begin // Parent BG is taken
          BGInfo.DrawDC := 0;
          BGInfo.PleaseDraw := False;
          GetBGInfo(@BGInfo, Frame.Parent);
          if (BGInfo.BgType = btCache) and (BGInfo.Bmp <> nil) then begin
            BitBlt(DC, 0, 0, Frame.Width, Frame.Height, BGInfo.Bmp.Canvas.Handle, Frame.Left + BGInfo.Offset.X, Frame.Top + BGInfo.Offset.Y, SRCCOPY);
            InitCacheBmp(SkinData);
            BitBlt(SkinData.FCacheBmp.Canvas.Handle, 0, 0, Frame.Width, Frame.Height, BGInfo.Bmp.Canvas.Handle, Frame.Left + BGInfo.Offset.X, Frame.Top + BGInfo.Offset.Y, SRCCOPY);
          end
          else begin
            SavedDC := SaveDC(DC);
            ExcludeControls(DC, Frame, actGraphic, 0, 0);
            FillBG(MkRect(Frame.Width, Frame.Height));
            RestoreDC(DC, SavedDC);
          end
        end
        else begin
          Changed := FCommonData.BGChanged or FCommonData.HalfVisible;
          i := GetClipBox(DC, R);
          if (i = 0) {or IsRectEmpty(R) is not redrawn while resizing }then
            Exit;

          if SkinData.RepaintIfMoved and (Frame.Parent <> nil) then
            FCommonData.HalfVisible := (WidthOf(R, True) <> Frame.Width) or (HeightOf(R, True) <> Frame.Height)
          else
            FCommonData.HalfVisible := False;

          if Changed then
            if not PrepareCache then begin
              RestoreDC(DC, SavedDC);
              Exit;
            end;
            
          CopyWinControlCache(Frame, FCommonData, MkRect, MkRect(Frame), DC, True);
        end;
        sVCLUtils.PaintControls(DC, Frame, Changed, MkPoint);
        SetParentUpdated(Frame);
      end;
      RestoreDC(DC, SavedDC);
    end
    else begin
      FCommonData.Updating := False;
      i := SkinBorderMaxWidth(FCommonData);
      R := MkRect(Frame.Width, Frame.Height);
      if aDC <> SkinData.PrintDC then
        DC := GetDC(Frame.Handle);
        
      try
        SavedDC := SaveDC(DC);
        ExcludeControls(DC, Frame, actGraphic, 0, 0);
        if i = 0 then
          FillBG(R) { Just fill BG}
        else begin
          if FCommonData.FCacheBmp = nil then
            FCommonData.FCacheBmp := CreateBmp32(Frame.Width, Frame.Height);
            
          PaintBorderFast(DC, R, i, FCommonData, 0);
          InflateRect(R, i, i);
          FillBG(R);
        end;
        RestoreDC(DC, SavedDC);
        if i > 0 then
          BitBltBorder(DC, 0, 0, Frame.Width, Frame.Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, i);

        PaintControls(DC, Frame, True, MkPoint);
        if FCommonData.FCacheBmp <> nil then
          FreeAndNil(FCommonData.FCacheBmp);
      finally
        if aDC <> SkinData.PrintDC then
          ReleaseDC(Frame.Handle, DC);
      end;
    end;
  end;
end;


function TsFrameAdapter.PrepareCache: boolean;
var
  BGInfo: TacBGInfo;
begin
  Result := False;
  SkinData.UpdateIndexes;
  if IsCached(SkinData) then begin
    if Frame.Parent <> nil then
      GetBGInfo(@BGInfo, Frame.Parent)
    else
      BGInfo.BgType := btNotReady;
      
    if BGInfo.BgType = btNotReady then begin
      SkinData.Updating := True;
      Exit;
    end;
    InitCacheBmp(SkinData);
    SkinData.FCacheBMP.Canvas.Font.Assign(Frame.Font);
    PaintItem(SkinData, BGInfoToCI(@BGInfo), False, 0, MkRect(Frame), MkPoint(Frame), SkinData.FCacheBMP, False);
  end;
  SkinData.PaintOuterEffects(Frame, MkPoint);
  SkinData.BGChanged := False;
  Result := True;
end;

end.


