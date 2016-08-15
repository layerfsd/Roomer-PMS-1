unit sScrollBox;
{$I sDefs.inc}
//{$DEFINE LOGGED}
//+
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  sCommonData, acSBUtils;


type
  TsPaintEvent = procedure (ControlBmp: TBitmap) of object;


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsScrollBox = class(TScrollingWinControl)
  private
{$IFNDEF NOTFORHELP}
    FOnMouseLeave,
    FOnMouseEnter,
    FOnAfterScroll,
    FOnBeforeScroll: TNotifyEvent;

    FOnPaint: TsPaintEvent;
    FCanvas: TControlCanvas;
    FAutoMouseWheel: boolean;
    FCommonData: TsScrollWndData;
    function GetCanvas: TCanvas;
    procedure SetBorderStyle(const Value: TBorderStyle);
  protected
    acTrackPos: integer;
    FBorderStyle: TBorderStyle;
    function ActBorderWidth: integer;
    procedure WMPrint       (var Message: TWMPaint); message WM_PRINT;
    procedure WMNCPaint     (var Message: TWMPaint); message WM_NCPAINT;
    procedure WMNCHitTest   (var Message: TMessage); message WM_NCHITTEST;
    procedure WMEraseBkGnd  (var Message: TWMPaint); message WM_ERASEBKGND;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure SetParent(AParent: TWinControl); override;
  public
    ListSW: TacScrollWnd;
    constructor Create(AOwner: TComponent); override;
    procedure CreateParams(var Params: TCreateParams); override;
    destructor Destroy; override;
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean; override;
    procedure AfterConstruction; override;
    procedure Loaded; override;
    procedure ScrollBy(DeltaX, DeltaY: Integer);
    function PrepareCache: boolean;
    procedure Paint(aDC: hdc = 0; SendUpdated: boolean = True);
    procedure PaintWindow(DC: HDC); override;
    procedure WndProc(var Message: TMessage); override;
{$ENDIF} // NOTFORHELP
  published
    property OnPaint: TsPaintEvent read FOnPaint write FOnPaint;
{$IFNDEF NOTFORHELP}
    property OnAfterScroll: TNotifyEvent read FOnAfterScroll write FOnAfterScroll;
    property OnBeforeScroll: TNotifyEvent read FOnBeforeScroll write FOnBeforeScroll;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property Align;
    property Anchors;
    property AutoMouseWheel: boolean read FAutoMouseWheel write FAutoMouseWheel default False;
    property AutoScroll default True;
    property BiDiMode;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property Canvas: TCanvas read GetCanvas;
    property Constraints;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Color;
    property Ctl3D;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
{$IFDEF D2010}
    property Touch;
    property OnGesture;
{$ENDIF}
    property Visible;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDblClick;
    property OnDockDrop;
    property OnDockOver;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
{$ENDIF} // NOTFORHELP
    property SkinData: TsScrollWndData read FCommonData write FCommonData;
  end;

implementation

uses
  {$IFDEF LOGGED}sDebugMsgs, {$ENDIF}
  sStyleSimply, sGraphUtils, sConst, sVCLUtils, acntUtils, sMessages, sAlphaGraph, sSkinManager, sBorders;


procedure TsScrollBox.AfterConstruction;
begin
  inherited AfterConstruction;
  FCommonData.Loaded(False);
  if HandleAllocated then
    RefreshScrolls(SkinData, ListSW);
end;


procedure TsScrollBox.CMCtl3DChanged(var Message: TMessage);
begin
  if NewStyleControls and (FBorderStyle = bsSingle) then
    RecreateWnd;

  inherited;
end;


constructor TsScrollBox.Create(AOwner: TComponent);
begin
  FCommonData := TsScrollWndData.Create(Self, True);
  FCommonData.COC := COC_TsScrollBox;
  inherited Create(AOwner);
  FAutoMouseWheel := False;
  ControlStyle := ControlStyle + [csAcceptsControls];
  FCanvas := TControlCanvas.Create;
  FCanvas.Control := Self;
  acTrackPos := 0;
  Width := 185;
  Height := 41;
  AutoScroll := True;
  FBorderStyle := bsSingle;
end;


procedure TsScrollBox.CreateParams(var Params: TCreateParams);
const
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
begin
  inherited CreateParams(Params);
  with Params do begin
    Style := Style or BorderStyles[FBorderStyle];
    if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;
  end;
end;


destructor TsScrollBox.Destroy;
begin
  if ListSW <> nil then
    FreeAndNil(ListSW);

  if Assigned(FCanvas) then
    FreeAndNil(FCanvas);

  FreeAndNil(FCommonData);
  inherited Destroy;
end;


function TsScrollBox.GetCanvas: TCanvas;
begin
  Result := FCanvas;
end;


procedure TsScrollBox.Loaded;
begin
  inherited Loaded;
  RefreshScrolls(SkinData, ListSW);
  FCommonData.Loaded;
end;


procedure TsScrollBox.Paint(aDC: hdc = 0; SendUpdated: boolean = True);
var
  R: TRect;
  b: boolean;
  DC, SavedDC: hdc;
  bWidth, i: integer;
  ParentBG: TacBGInfo;
begin
  bWidth := BorderWidth + ActBorderWidth * integer(BorderStyle = bsSingle);
  if aDC <> 0 then
    DC := aDC
  else
    DC := GetDC(Handle);

  if IsCached(FCommonData) and not SkinData.CustomColor or Assigned(FOnPaint) then begin
    if not InUpdating(FCommonData, False) then begin
      // If transparent and parent is resized
      b := FCommonData.HalfVisible or FCommonData.BGChanged;
      if SkinData.RepaintIfMoved then begin
        GetClipBox(DC, R);
        FCommonData.HalfVisible := (WidthOf(R) <> Width) or (HeightOf(R) <> Height)
      end
      else
        FCommonData.HalfVisible := False;

      if b or (FCommonData.FCacheBmp = nil) then
        if not PrepareCache then
          Exit;

      CopyWinControlCache(Self, FCommonData, Rect(bWidth, bWidth, 0, 0), MkRect(Width - 2 * bWidth, Height - 2 * bWidth), DC, False);
      sVCLUtils.PaintControls(DC, Self, b and SkinData.RepaintIfMoved, MkPoint);
      MoveWindowOrg(DC, bWidth, bWidth);
    end;
  end
  else begin
    i := SkinBorderMaxWidth(FCommonData);
    R := MkRect(Self);
    SavedDC := SaveDC(DC);
    ExcludeControls(DC, Self, 0, 0);
    MoveWindowOrg(DC, -bWidth, -bWidth);
    ParentBG.PleaseDraw := False;
    if not SkinData.CustomColor then
      GetBGInfo(@ParentBG, Self)
    else begin
      ParentBG.Color := ColorToRGB(Color);
      ParentBG.BgType := btFill;
    end;

    if (FCommonData.SkinManager.gd[FCommonData.SkinIndex].Props[0].Transparency = 100) and (ParentBG.BgType = btCache) then begin
      if not InUpdating(FCommonData, False) then
        if i = 0 then
          BitBlt(DC, 0, 0, Width, Height, ParentBG.Bmp.Canvas.Handle, ParentBG.Offset.X, ParentBG.Offset.Y, SRCCOPY)
        else begin
          if FCommonData.FCacheBmp = nil then
            FCommonData.FCacheBmp := CreateBmp32(Width, Height);

          R := PaintBorderFast(DC, R, i, FCommonData, 0);
          if FCommonData.SkinManager.gd[FCommonData.SkinIndex].Props[0].Transparency = 100 then
            FillDC(DC, R, ParentBG.Color)
          else
            FillDC(DC, R, GetBGColor(SkinData, 0));

          if i > 0 then
            BitBltBorder(DC, 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, i);

          BitBlt(DC, i, i, Width - 2 * i, Height - 2 * i, ParentBG.Bmp.Canvas.Handle, ParentBG.Offset.X + i, ParentBG.Offset.Y + i, SRCCOPY);
        end;
    end
    else
      if i = 0 then
        FillDC(DC, R, ParentBG.Color)
      else begin
        if FCommonData.FCacheBmp = nil then
          FCommonData.FCacheBmp := CreateBmp32(Width, Height);

        R := PaintBorderFast(DC, R, i, FCommonData, 0);
        if FCommonData.SkinManager.gd[FCommonData.SkinIndex].Props[0].Transparency = 100 then
          FillDC(DC, R, ParentBG.Color)
        else
          FillDC(DC, R, GetBGColor(SkinData, 0));

        if i > 0 then
          BitBltBorder(DC, 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, i);
      end;

    R := ClientRect;
    i := BorderWidth + integer(BevelInner <> bvNone) * BevelWidth + integer(BevelOuter <> bvNone) * BevelWidth;
    InflateRect(R, -i, -i);
    RestoreDC(DC, SavedDC);
    sVCLUtils.PaintControls(DC, Self, True, MkPoint);
    if FCommonData.FCacheBmp <> nil then
      FreeAndNil(FCommonData.FCacheBmp);
  end;
  if aDC <> DC then
    ReleaseDC(Handle, DC);

  SetParentUpdated(Self);
end;


function TsScrollBox.PrepareCache: boolean;
var
  bWidth: integer;
begin
  InitCacheBmp(SkinData);
  if not PaintSkinControl(FCommonData, Parent, False, 0, MkRect(Self), Point(Left, Top), FCommonData.FCacheBMP, True) then begin
    SkinData.FUpdating := True; // Check it later in LC projects
    Result := False;
  end
  else begin
    Result := True;
    SkinData.BGChanged := False;
    bWidth := BorderWidth + ActBorderWidth * integer(BorderStyle = bsSingle);
    SkinData.PaintOuterEffects(Self, Point(bWidth, bWidth));
    if Assigned(FOnPaint) then begin
      FCommonData.FCacheBmp.Canvas.Lock;
      OnPaint(FCommonData.FCacheBmp);
      FCommonData.FCacheBmp.Canvas.UnLock;
    end;
  end;
end;


procedure TsScrollBox.ScrollBy(DeltaX, DeltaY: Integer);
begin
  SendAMessage(Handle, AC_BEFORESCROLL);
  inherited ScrollBy(DeltaX, DeltaY);
  SendAMessage(Handle, AC_AFTERSCROLL);
end;


procedure TsScrollBox.SetBorderStyle(const Value: TBorderStyle);
begin
  if Value <> FBorderStyle then begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;


procedure TsScrollBox.SetParent(AParent: TWinControl);
begin
  inherited;
  if Parent <> nil then
    FCommonData.Loaded;
end;


procedure TsScrollBox.WMNCHitTest(var Message: TMessage);
begin
  DefaultHandler(Message);
end;


procedure TsScrollBox.WMNCPaint(var Message: TWMPaint);
var
  DC, SavedDC: hdc;
  bWidth: integer;
begin
  if FCommonData.Skinned and (BorderStyle <> bsNone) and Visible then begin
    if not InAnimationProcess then begin
      if csDesigning in ComponentState then
        inherited;

      if IsCached(FCommonData) then begin
        if ControlIsReady(Self) and not InUpdating(FCommonData, False) then begin
          if SkinData.BGChanged or (FCommonData.FCacheBmp = nil) then
            PrepareCache;

          UpdateCorners(FCommonData, 0);
          bWidth := ActBorderWidth * integer(BorderStyle = bsSingle) + BorderWidth;
          DC := GetWindowDC(Handle);
          SavedDC := SaveDC(DC);
          BitBltBorder(DC, 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, bWidth);
          if Assigned(ListSW) and Assigned(ListSW.sBarVert) then
            Ac_NCDraw(ListSW, Handle, -1, DC);

          RestoreDC(DC, SavedDC);
          ReleaseDC(Handle, DC);
        end;
      end
      else begin
        DC := GetWindowDC(Handle);
        SavedDC := SaveDC(DC);
        PaintBorderFast(DC, MkRect(Self), 2 * integer(BorderStyle = bsSingle) + BorderWidth, SkinData, 0);
        if FCommonData.FCacheBmp <> nil then
          FreeAndNil(FCommonData.FCacheBmp);

        RestoreDC(DC, SavedDC);
        ReleaseDC(Handle, DC);
      end;
    end;
  end
  else
    inherited;
end;


procedure TsScrollBox.WMEraseBkGnd(var Message: TWMPaint);
begin
  if SkinData.Skinned then begin
    with Message do
      if not InUpdating(SkinData) then
        if not (csPaintCopy in ControlState) and (TMessage(Message).WParam <> WParam(TMessage(Message).LParam) {PerformEraseBackground, TntSpeedButtons}) then begin
          if InAnimationProcess and (DC <> SkinData.PrintDC) or not ControlIsReady(Self) then
            Exit; // Prevent of BG drawing in Aero

          Paint(DC);
          Message.Result := 1;
        end
        else
          if DC <> 0 then begin // From PaintTo
            if FCommonData.BGChanged then
              PrepareCache;

            if not FCommonData.BGChanged then
              if IsCached(FCommonData) then
                BitBlt(DC, 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY)
              else
                FillDC(DC, MkRect(Self), GetControlColor(Handle));
          end;
  end
  else
    inherited;
end;


procedure TsScrollBox.WMPrint;
var
  cR: TRect;
  SavedDC: hdc;
  bWidth: integer;
begin
  if FCommonData.Skinned then begin
    FCommonData.Updating := False;
    with Message do
      if ControlIsReady(Self) then begin
        PrepareCache;
        bWidth := BorderWidth + ActBorderWidth * integer(BorderStyle = bsSingle);
        // Paint borders
        BitBltBorder(DC, 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, bWidth);
        // And scrolls
        Ac_NCDraw(ListSW, Handle, -1, DC);
        // Paint GraphicControls
        MoveWindowOrg(DC, bWidth, bWidth);
        cR := GetClientRect;
        IntersectClipRect(DC, 0, 0, WidthOf(cR), HeightOf(cR));
        SavedDC := SaveDC(DC);
        try
          FCommonData.HalfVisible := False;
          Paint(DC);
          MoveWindowOrg(DC, -bWidth, -bWidth);
        finally
          RestoreDC(DC, SavedDC);
        end;
      end;
  end
  else
    inherited;
end;


procedure TsScrollBox.WndProc(var Message: TMessage);
var
  R: TRect;
  m: TMessage;
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
      end;

      AC_SETNEWSKIN: begin
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          AlphaBroadCast(Self, Message);
          CommonWndProc(Message, FCommonData);
        end
        else
          AlphaBroadCast(Self, Message);

        Exit;
      end;

      AC_REFRESH: begin
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          CommonWndProc(Message, FCommonData);
          if not InUpdating(SkinData) and not InAnimationProcess then
            RedrawWindow(Handle, nil, 0, RDWA_NOCHILDRENNOW)
          else
            RedrawWindow(Handle, nil, 0, RDWA_NOCHILDREN);

          RefreshScrolls(SkinData, ListSW);
        end;
        AlphaBroadCast(Self, Message);
        Exit;
      end;

      AC_REMOVESKIN: begin
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          if ListSW <> nil then begin
            FreeAndNil(ListSW);
            if Assigned(Ac_InitializeFlatSB) then
              Ac_InitializeFlatSB(Handle);
          end;
          AlphaBroadCast(Self, Message);
          if not (csDestroying in ComponentState) then
            RecreateWnd;
        end
        else
          AlphaBroadCast(Self, Message);

        Exit;
      end;

      AC_INVALIDATE:
        RedrawWindow(Handle, nil, 0, RDWA_ALL);

      AC_BEFORESCROLL: begin
        if Assigned(FOnBeforeScroll) then
          FOnBeforeScroll(Self);

        if Message.LParamHi = WM_HSCROLL then
          acTrackPos := HorzScrollBar.Position
        else
          acTrackPos := VertScrollBar.Position;

        if IsCached(FCommonData) then
          if (Message.LParamHi = WM_HSCROLL) and HorzScrollBar.Tracking or (Message.LParamHi = WM_VSCROLL) and VertScrollBar.Tracking then
            SendMessage(Handle, WM_SETREDRAW, 0, 0);
      end;

      AC_AFTERSCROLL: begin
        if IsCached(FCommonData) then
          if (Message.LParamHi = WM_HSCROLL) and not HorzScrollBar.Tracking or (Message.LParamHi = WM_VSCROLL) and not VertScrollBar.Tracking then
            RedrawWindow(Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_UPDATENOW or RDW_ALLCHILDREN)
          else begin
            SendMessage(Handle, WM_SETREDRAW, 1, 0);
            m := MakeMessage(SM_ALPHACMD, AC_SETCHANGEDIFNECESSARY shl 16 + 1, 0, 0);
            BroadCast(m);
            RedrawWindow(Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_ALLCHILDREN or RDW_UPDATENOW);
            if Message.LParamHi = WM_HSCROLL then
              acTrackPos := acTrackPos - HorzScrollBar.Position
            else begin
              acTrackPos := acTrackPos - VertScrollBar.Position;
              if acTrackPos < 0 then
                R := Rect(0, Height + acTrackPos, Width, Height);
            end;
          end
        else
          if ((Message.LParamHi = WM_HSCROLL) and HorzScrollBar.Tracking) or ((Message.LParamHi = WM_VSCROLL) and VertScrollBar.Tracking) then begin
            if Message.LParamHi = WM_HSCROLL then begin
              acTrackPos := acTrackPos - HorzScrollBar.Position;
              if acTrackPos < 0 then
                R := Rect(Width + acTrackPos, 0, Width, Height)
              else
                R := MkRect(acTrackPos, Height);
            end
            else begin
              acTrackPos := acTrackPos - VertScrollBar.Position;
              if acTrackPos < 0 then
                R := Rect(0, Height + acTrackPos, Width, Height)
              else
                R := MkRect(Width, acTrackPos);
            end;
            RedrawWindow(Handle, @R, 0, RDWA_ALLNOW);
          end;

        if Assigned(FOnAfterScroll) then
          FOnAfterScroll(Self);
      end;

      AC_PREPARECACHE: begin
        PrepareCache;
        Exit;
      end;

      AC_GETBG: begin
        InitBGInfo(SkinData, PacBGInfo(Message.LParam), integer(SkinData.FFocused or SkinData.FMouseAbove));
        if ListSW <> nil then begin
          inc(PacBGInfo(Message.LParam).Offset.X, ListSW.cxLeftEdge);
          inc(PacBGInfo(Message.LParam).Offset.Y, ListSW.cyTopEdge);
        end
        else begin
          inc(PacBGInfo(Message.LParam).Offset.X, BorderWidth + Integer(BorderStyle = bsSingle) * 2);
          inc(PacBGInfo(Message.LParam).Offset.Y, BorderWidth + Integer(BorderStyle = bsSingle) * 2);
        end;
        Exit;
      end;

      AC_GETDEFINDEX: begin
        if FCommonData.SkinManager <> nil then
          if BorderStyle = bsNone then
            Message.Result := FCommonData.SkinManager.ConstData.Sections[ssTransparent] + 1
          else
            Message.Result := FCommonData.SkinManager.ConstData.Sections[ssPanelLow] + 1;

        Exit;
      end;

      AC_ENDPARENTUPDATE: begin
        if FCommonData.FUpdating then begin
          if not InUpdating(FCommonData, True) then
            RedrawWindow(Handle, nil, 0, RDWA_NOCHILDRENNOW);

          SetParentUpdated(Self);
        end
        else
          if SkinData.CtrlSkinState and ACS_FAST <> 0 then
            SetParentUpdated(Self);

        Exit;
      end

      else
        if CommonMessage(Message, FCommonData) then
          Exit;
    end;

  case Message.Msg of
    CM_MOUSEENTER: if Assigned(FOnMouseEnter) then FOnMouseEnter(Self);
    CM_MOUSELEAVE: if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);
  end;

  if not ControlIsReady(Self) then
    inherited
  else begin
    if FCommonData.Skinned then
      case Message.Msg of
        SM_ALPHACMD:
          case Message.WParamHi of
            AC_PREPARING: begin
              Message.Result := LRESULT(IsCached(FCommonData) and (FCommonData.FUpdating));
              Exit;
            end;

            AC_GETBG: begin
              if FCommonData.FCacheBmp = nil then
                Message.Result := 0;

              InitBGInfo(FCommonData, PacBGInfo(Message.LParam), 0);
              with PacBGInfo(Message.LParam)^ do
                if (BgType = btCache) and not PleaseDraw then begin
                  Offset.X := Offset.X + 2 * integer(BorderStyle = bsSingle) + BorderWidth;
                  Offset.Y := Offset.Y + 2 * integer(BorderStyle = bsSingle) + BorderWidth;
                end;

              Exit;
            end

            else
              if CommonMessage(Message, FCommonData) then
                Exit;
          end;

        CM_VISIBLECHANGED: begin
          FCommonData.BGChanged := True;
          FCommonData.FUpdating := False;
          if Visible then begin
            PrepareCache;
            inherited;
            SetParentUpdated(Self);
          end
          else
            inherited;

          Exit;
        end;

        CM_ENTER, CM_EXIT: begin
          FCommonData.BeginUpdate;
          inherited;
          FCommonData.EndUpdate;
          Exit;
        end;

        WM_PAINT: begin
          if IsCached(FCommonData) then begin
            BeginPaint(Handle, PS);
            Paint(TWMPaint(Message).DC);
            Message.LParam := 1;
            EndPaint(Handle, PS);
          end
          else begin
            InvalidateRect(Handle, nil, True);
            BeginPaint(Handle, PS);
            sVclUtils.PaintControls(TWMPaint(Message).DC, Self, True, MkPoint);
            EndPaint(Handle, PS);
          end;
          Exit;
        end;
      end;

    CommonWndProc(Message, FCommonData);
    inherited;
    if (Message.Result >= 0) {Avoiding an issue when ScrollBox is killed by child control already} and (FCommonData <> nil) and FCommonData.Skinned then
      case Message.Msg of
        45138 {CM_GESTURE}:
          UpdateScrolls(ListSW, True);

        WM_SIZE:
          RedrawWindow(Handle, nil, 0, RDWA_ALL);

        CM_FOCUSCHANGED:
          UpdateScrolls(ListSW, True);

        CM_SHOWINGCHANGED:
          RefreshScrolls(SkinData, ListSW);

        WM_PARENTNOTIFY:
          if Message.WParamLo in [WM_CREATE, WM_DESTROY] then
            if AutoScroll then
              UpdateScrolls(ListSW, True);

        WM_WINDOWPOSCHANGING, WM_MOUSEWHEEL, CM_CONTROLLISTCHANGE, CM_CONTROLCHANGE:
          if not SkinData.Updating then
            if AutoScroll then
              UpdateScrolls(ListSW, True);
      end;
  end;
end;


procedure TsScrollBox.PaintWindow(DC: HDC);
begin
//  Empty for fixing the Borland bug
end;


var
  bacFlag: boolean = False;

function TsScrollBox.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean;
var
  c: TControl;
  m: TCMMouseWheel;
  Form: TCustomForm;
begin
  if FAutoMouseWheel then
    if not bacFlag then begin
      Form := GetParentForm(Self);
      if Form <> nil then begin
        c := Form.ActiveControl;
        m.Result := 0;
        if c <> nil then begin
          m.Pos := PointToSmallPoint(MousePos);
          m.ShiftState := Shift;
          m.WheelDelta := WheelDelta;
          m.Result := 0;
          bacFlag := True;
          m.Result := c.Perform(WM_MOUSEWHEEL, TMessage(m).WParam, TMessage(m).LParam);
          UpdateScrolls(ListSW, True);
          bacFlag := False;
        end;
        if m.Result = 0 then begin
          if Assigned(FOnBeforeScroll) then
            FOnBeforeScroll(Self);

          SendScrollMessage(Handle, WM_VSCROLL, SB_THUMBTRACK, VertScrollBar.Position - (WheelDelta div WHEEL_DELTA) * VertScrollBar.Increment);
          if Assigned(FOnAfterScroll) then
            FOnAfterScroll(Self);

          if not SkinData.Skinned then
            SendMessage(Handle, WM_NCPAINT, 0, 0);
        end;
      end;
      Result := True;
    end
    else
      Result := False
  else
    Result := inherited DoMouseWheel(Shift, WheelDelta, MousePos);
end;


function TsScrollBox.ActBorderWidth: integer;
begin
  if ListSW <> nil then
    Result := ListSW.cxLeftEdge
  else
    Result := 2;
end;

end.
