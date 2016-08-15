unit sScrollBar;
{$I sDefs.inc}
//{$DEFINE LOGGED}
//+
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, extctrls,
  {$IFDEF DELPHI6UP} Types, {$ENDIF}
  acntUtils, sConst, sCommonData, sDefaults, sSkinManager;


type
{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsScrollBar = class(TScrollBar)
  private
{$IFNDEF NOTFORHELP}
    FBtn1Rect,
    FBtn2Rect,
    FBar1Rect,
    FBar2Rect,
    FSliderRect: TRect;

    FCurrPos,
    FBtn1State,
    FBar2State,
    FBtn2State,
    FBar1State,
    FSliderState: integer;

    FBeginTrack,
    SkinnedRecreate,
    MustBeRecreated: boolean;

    Timer: TTimer;
    FSI: TScrollInfo;
    FCommonData: TsCommonData;
    FDisabledKind: TsDisabledKind;
    procedure CNHScroll(var Message: TWMHScroll); message CN_HSCROLL;
    procedure CNVScroll(var Message: TWMVScroll); message CN_VSCROLL;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure SetInteger(Index: integer; Value: integer);
    procedure SetDisabledKind(const Value: TsDisabledKind);
    function GetSkinManager: TsSkinManager;
    procedure SetSkinManager(const Value: TsSkinManager);
  protected
    CI: TCacheInfo;
    AppShowHint: boolean;
    RecreateCount: integer;
    procedure Change; override;
    procedure CheckRecreate;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WndProc(var Message: TMessage); override;

    procedure Paint(MsgDC: hdc);
    procedure DrawSlider(b: TBitmap);

    function Bar1Rect: TRect;
    function Bar2Rect: TRect;
    function Btn1Rect: TRect;
    function Btn2Rect: TRect;
    function SysBtnSize: integer;
    function WorkSize: integer;
    function SliderRect: TRect;
    function SliderSize: integer;
    function CoordToPoint(p: TPoint): TPoint;
    function CoordToPosition(p: TPoint): integer;
    function PositionToCoord: integer;
    function BarIsHot: boolean;
    procedure PrepareTimer;
    procedure PrepareBtnTimer;
    procedure PrepareBarTimer;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure KeyDown(var Key: word; Shift: TShiftState); override;
    procedure IncPos(Offset: integer);
    procedure SetPos(Pos: integer);
  public
    ScrollCode,
    MouseOffset: integer;

    RepaintNeeded,
    DoSendChanges,
    DrawingForbidden: boolean;

    LinkedControl: TWinControl;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure Loaded; override;
    procedure UpdateBar;
    procedure OnTimer   (Sender: TObject);
    procedure OnBtnTimer(Sender: TObject);
    procedure OnBarTimer(Sender: TObject);
    property Btn1State:   integer index 0 read FBtn1State   write SetInteger;
    property Btn2State:   integer index 1 read FBtn2State   write SetInteger;
    property Bar1State:   integer index 2 read FBar1State   write SetInteger;
    property Bar2State:   integer index 3 read FBar2State   write SetInteger;
    property SliderState: integer index 4 read FSliderState write SetInteger;
    property SkinData: TsCommonData read FCommonData write FCommonData;
{$ENDIF}
  published
    property DisabledKind: TsDisabledKind read FDisabledKind write SetDisabledKind default DefDisabledKind;
    property SkinManager: TsSkinManager read GetSkinManager write SetSkinManager;
{$IFNDEF NOTFORHELP}
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
{$ENDIF}
  end;


{$IFNDEF NOTFORHELP}
function UpdateControlScrollBar(Control: TWinControl; var ScrollBar: TsScrollBar; Kind: TScrollBarKind; Free: boolean = true): boolean;

{$ENDIF}

implementation

uses
  math,
  {$IFDEF LOGGED}sDebugMsgs, {$ENDIF}
  {$IFDEF CHECKXP}UxTheme, {$ENDIF}
  sGraphUtils, sSkinProps, sMessages, sMaskData, sStyleSimply, sVclUtils, sAlphaGraph, acSBUtils;


{$HINTS OFF}
type
  TScrollBar_ = class(TWinControl)
  private
    FPageSize: Integer;
  end;
{$HINTS ON}


function Skinned(sb: TsScrollBar): boolean;
begin
  with sb.SkinData do begin
    if not Assigned(SkinManager) then
      SkinManager := DefaultManager;

    if Assigned(SkinManager) and SkinManager.CommonSkinData.Active then
      Result := True
    else
      Result := False;
  end;
end;


function UpdateControlScrollBar(Control: TWinControl; var ScrollBar: TsScrollBar; Kind: TScrollBarKind; Free: boolean = true): boolean;
const
  SysConsts: array[TScrollBarKind] of Integer = (SM_CXHSCROLL, SM_CXVSCROLL);
  Kinds: array[TScrollBarKind] of DWORD = (SB_HORZ, SB_VERT);
var
  SI: TScrollInfo;

  function HaveScroll(Handle: hwnd; fnBar: integer): boolean;
  var
    Style: ACNativeInt;
  begin
    Style := GetWindowLong(Handle, GWL_STYLE);
    case fnBar of
      SB_VERT: Result := Style and WS_VSCROLL <> 0;
      SB_HORZ: Result := Style and WS_HSCROLL <> 0;
      SB_BOTH: Result := (Style and WS_VSCROLL <> 0) and (Style and WS_HSCROLL <> 0)
      else     Result := False
    end;
  end;

  function GetScrollInfo(Handle: HWND; Kind: Integer; Mask: Cardinal; var ScrollInfo: TScrollInfo): boolean;
  begin
    Result := HaveScroll(Handle, Kind);
    if Result then begin
      ScrollInfo.cbSize := SizeOf(TScrollInfo);
      ScrollInfo.fMask := Mask;
      Result := Windows.GetScrollInfo(Handle, Kind, ScrollInfo);
    end;
  end;
  
begin
  Result := false;
  if Control.Visible then begin
    if GetScrollInfo(Control.Handle, Kinds[Kind], SIF_ALL, SI) then begin
      if ScrollBar = nil then begin
        ScrollBar := TsScrollBar.Create(Control);
        ScrollBar.Visible          := False;
        ScrollBar.LinkedControl    := Control;
        ScrollBar.DoSendChanges    := true;
        ScrollBar.DrawingForbidden := True;
        ScrollBar.TabStop          := False;
        ScrollBar.Kind             := Kind;
        ScrollBar.Parent           := Control.Parent;
      end;
      Result := true;
    end
    else
      if Assigned(ScrollBar) and Free then
        FreeAndNil(ScrollBar);

  end
  else
    if Assigned(ScrollBar) then
      FreeAndNil(ScrollBar);
end;


procedure TsScrollBar.AfterConstruction;
begin
  inherited;
  FCommonData.Loaded;
{$IFDEF CHECKXP}
  if UseThemes and not (SkinData.Skinned and SkinData.SkinManager.CommonSkinData.Active) then
    ControlStyle := ControlStyle - [csParentBackground]; // Patching of bug with TGraphicControls repainting when XPThemes used
{$ENDIF}
  CheckRecreate;
end;


function TsScrollBar.Btn1Rect: TRect;
begin
  FBtn1Rect.Left := 0;
  FBtn1Rect.Top := 0;
  if Kind = sbHorizontal then begin
    FBtn1Rect.Right := SysBtnSize;
    FBtn1Rect.Bottom := Height;
    if WidthOf(FBtn1Rect) > Width div 2 then
      FBtn1Rect.Right := Width div 2;
  end
  else begin
    FBtn1Rect.Right := Width;
    FBtn1Rect.Bottom := SysBtnSize;
    if HeightOf(FBtn1Rect) > Height div 2 then
      FBtn1Rect.Bottom := Height div 2;
  end;
  Result := FBtn1Rect;
end;


function TsScrollBar.Btn2Rect: TRect;
begin
  if Kind = sbHorizontal then begin
    FBtn2Rect.Left := Width - SysBtnSize;
    FBtn2Rect.Top := 0;
    FBtn2Rect.Right := Width;
    FBtn2Rect.Bottom := Height;
    if WidthOf(FBtn2Rect) > Width div 2 then
      FBtn2Rect.Left := Width div 2;
  end
  else begin
    FBtn2Rect.Left := 0;
    FBtn2Rect.Top := Height - SysBtnSize;
    FBtn2Rect.Right := Width;
    FBtn2Rect.Bottom := Height;
    if HeightOf(FBtn2Rect) > Height div 2 then
      FBtn2Rect.Top := Height div 2;
  end;
  Result := FBtn2Rect;
end;


function TsScrollBar.CoordToPosition(p: TPoint): integer;
var
  ss: integer;
  r: real;
begin
  if Enabled then begin
    ss := SliderSize;
    if Kind = sbHorizontal then begin
      r := (Width - 2 * SysBtnSize - ss);
      if r = 0 then
        Result := 0
      else
        Result := Round((p.x - SysBtnSize - ss / 2) * (FSI.nMax - FSI.nMin - Math.Max(Integer(FSI.nPage) - 1, 0)) / r)
    end
    else begin
      r := (Height - 2 * SysBtnSize - ss);
      if r = 0 then
        Result := 0
      else
        Result := Round((p.y - SysBtnSize - ss / 2) * (FSI.nMax - FSI.nMin- Math.Max(Integer(FSI.nPage) -1, 0)) / r);
    end;
  end
  else
    Result := 0;
end;


constructor TsScrollBar.Create(AOwner: TComponent);
begin
  FCommonData := TsCommonData.Create(TWinControl(Self), True);
  FCommonData.COC := COC_TsScrollBar;
  inherited Create(AOwner);
  RecreateCount := 0;
  SkinnedRecreate := False;
  CI := MakeCacheInfo(FCommonData.FCacheBmp);
  FSI.nMax := FSI.nMin - 1;

  Btn1State := 0;
  Btn2State := 0;
  Bar1State := 0;
  Bar2State := 0;

  FBtn1Rect.Right := 0;
  FBtn2Rect.Right := 0;
  FDisabledKind := DefDisabledKind;
end;


procedure TsScrollBar.CreateParams(var Params: TCreateParams);

  procedure DefCreateParams(var Params: TCreateParams);
  var
    FText: string;
    FLeft, FTop, FWidth, FHeight: integer;
  begin
    FillChar(Params, SizeOf(Params), 0);
    FText := Text;
    FLeft := Left;
    FTop  := Top;
    FWidth:= Width;
    FHeight:= Height;
    with Params do begin
      Caption := PChar(FText);
      Style := WS_CHILD or WS_CLIPSIBLINGS;
      AddBiDiModeExStyle(ExStyle);
      if csAcceptsControls in ControlStyle then begin
        Style := Style or WS_CLIPCHILDREN;
        ExStyle := ExStyle or WS_EX_CONTROLPARENT;
      end;
      if not (csDesigning in ComponentState) and not Enabled then
        Style := Style or WS_DISABLED;

      if TabStop then
        Style := Style or WS_TABSTOP;
        
      X := FLeft;
      Y := FTop;
      Width := FWidth;
      Height := FHeight;
      if Parent <> nil then
        WndParent := Parent.Handle
      else
        WndParent := ParentWindow;

      WindowClass.style := CS_VREDRAW + CS_HREDRAW + CS_DBLCLKS;
      WindowClass.lpfnWndProc := @DefWindowProc;
      WindowClass.hCursor := LoadCursor(0, IDC_ARROW);
      WindowClass.hbrBackground := 0;
      WindowClass.hInstance := HInstance;
      StrPCopy(WinClassName, ClassName);
    end;
  end;
  
begin
  if SkinnedRecreate then
    DefCreateParams(Params)
  else begin
    inherited CreateParams(Params);
    if Skinned(Self) and (RecreateCount < 5) {Prevent of unlim loop} then begin
      inc(RecreateCount);
      MustBerecreated := True;
    end;
  end;
end;


destructor TsScrollBar.Destroy;
begin
  if Assigned(Timer) then begin
    Timer.Enabled := False;
    FreeAndNil(Timer);
  end;
  inherited Destroy;
  FreeAndNil(FCommonData);
end;


procedure TsScrollBar.Loaded;
begin
  inherited;
  FCommonData.Loaded;
{$IFDEF CHECKXP}
  if UseThemes and not (SkinData.Skinned and SkinData.SkinManager.CommonSkinData.Active) then
    ControlStyle := ControlStyle - [csParentBackground]; // Patching of bug with TGraphicControls repainting when XPThemes used
{$ENDIF}
  CheckRecreate;
  if (csDesigning in ComponentState) and (FSI.nMax = FSI.nMin - 1) {If FSI is not initialized} then begin
    FSI.nMax := Max;
    FSI.nMin := Min;
    FSI.nPos := Position;
    FSI.nTrackPos := Position;
  end;
end;


procedure TsScrollBar.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
  BtnCodes1:  array[boolean] of integer = (SB_LINELEFT,  SB_LINEUP);
  BtnCodes2:  array[boolean] of integer = (SB_LINERIGHT, SB_LINEDOWN);
  PageCodes1: array[boolean] of integer = (SB_PAGELEFT,  SB_PAGEUP);
  PageCodes2: array[boolean] of integer = (SB_PAGERIGHT, SB_PAGEDOWN);
var
  i: integer;
begin
  if not Skinned(Self) or not Enabled or not (Button = mbLeft) then
    inherited
  else begin
    if not ControlIsReady(Self) then
      Exit;

    AppShowHint := Application.ShowHint;
    Application.ShowHint := False;
    MouseOffset := 0;
    if CanFocus then
      SetFocus;
    // If Button1 pressed...
    if PtInRect(Btn1Rect, Point(x,y)) then begin
      if Btn1State <> 2 then begin
        ScrollCode := BtnCodes1[Kind = sbVertical];
        Btn1State := 2;
        DrawingForbidden := True;
        IncPos(-1);
        PrepareBtnTimer;
      end;
    end
    // If Button2 pressed...
    else
      if PtInRect(Btn2Rect, Point(x,y)) then begin
        if Btn2State <> 2 then begin
          ScrollCode := BtnCodes2[Kind = sbVertical];
          Btn2State := 2;
          DrawingForbidden := True;
          IncPos(1);
          PrepareBtnTimer;
        end;
      end
      // If slider pressed...
      else
        if PtInRect(SliderRect, Point(x,y)) then begin
          ScrollCode := SB_THUMBTRACK;
          if SliderState <> 2 then begin
            i := CoordToPosition(Point(x, y));
            MouseOffset := i - FCurrPos;
            SliderState := 2;
            FBeginTrack := true;
            IncPos(0);
            PrepareTimer;
          end;
        end
        else
          if PtInRect(Bar1Rect, Point(x,y)) then begin
            ScrollCode := PageCodes1[Kind = sbVertical];
            if Bar1State <> 2 then begin
              Bar1State := 2;
              Bar2State := integer(BarIsHot);
              DrawingForbidden := True;
              IncPos(-Math.Max(Integer(FSI.nPage), 1));
              PrepareBarTimer;
            end;
          end
          else begin
            ScrollCode := PageCodes2[Kind = sbVertical];
            if Bar2State <> 2 then begin
              Bar1State := integer(BarIsHot);
              Bar2State := 2;
              DrawingForbidden := True;
              IncPos(Math.Max(Integer(FSI.nPage), 1));
              PrepareBarTimer;
            end;
          end;

    UpdateBar;
    inherited;
  end;
end;


procedure TsScrollBar.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not Skinned(Self) or not Enabled then
    inherited
  else
    if ControlIsReady(Self) then begin
      if Assigned(Timer) then begin
        Timer.Enabled := False;
        if Assigned(Timer) then
          FreeAndNil(Timer);
      end;
      if PtInRect(SliderRect, Point(X, Y)) or (SliderState = 2) then begin
        ScrollCode := SB_THUMBPOSITION;
        Bar1State := integer(BarIsHot);
        Bar2State := Bar1State;
        if SliderState = 2 then begin
          DrawingForbidden := True;
          IncPos(0);
          if PtInRect(SliderRect, Point(X, Y)) then
            SliderState := 1
          else
            SliderState := 0;
        end
      end
      else
        if PtInRect(Btn1Rect, Point(X, Y)) and (Btn1State = 2) then
          Btn1State := 1
        else
          if PtInRect(Btn2Rect, Point(X, Y)) and (Btn2State = 2) then
            Btn2State := 1
          else
            if (Bar1State = 2) then
              Bar1State := integer(BarIsHot)
            else
              if (Bar2State = 2) then
                Bar2State := integer(BarIsHot);

      UpdateBar;
      ReleaseCapture;
      inherited;
      ScrollCode := SB_ENDSCROLL;
      IncPos(0);
      Application.ShowHint := AppShowHint;
    end;
end;


procedure TsScrollBar.OnTimer(Sender: TObject);
begin
  if Assigned(Timer) and ControlIsReady(Self) and not (csDestroying in Timer.ComponentState) and not FCommonData.FMouseAbove then begin
    SetPos(CoordToPosition(ScreenToClient(acMousePos)) - MouseOffset);
    SetCapture(Handle);
  end;
end;


procedure TsScrollBar.Paint(MsgDC: hdc);
var
  LocalState: integer;
  PS: TPaintStruct;
  DC, SavedDC: hdc;
  lCI: TCacheInfo;
  BG: TacBGInfo;
  Side: TacSide;
  bmp: TBitmap;
  c: TsColor;
begin
  if HandleAllocated then begin
    bmp := nil;
    BeginPaint(Handle, PS);
    if MsgDC = 0 then
      DC := GetWindowDC(Handle)
    else
      DC := MsgDC;

    SavedDC := SaveDC(DC);
    try
      if ([csDestroying, csLoading] * ComponentState = []) and
            not (DrawingForbidden or not ControlIsReady(Self) or RestrictDrawing or FCommonData.Updating) then begin
        RepaintNeeded := False;
        InitCacheBmp(SkinData);
        if not Enabled then
          bmp := CreateBmpLike(FCommonData.FCacheBmp)
        else
          bmp := FCommonData.FCacheBmp;

        BG.PleaseDraw := False;
        if (LinkedControl <> nil) and (LinkedControl is TWinControl) then begin
          GetBGInfo(@BG, LinkedControl);
          lCI := BGInfoToCI(@BG);
          if not (LinkedControl is TCustomForm) then begin
            dec(lCI.X, LinkedControl.Left);
            dec(lCI.Y, LinkedControl.Top);
          end;
        end
        else begin
          GetBGInfo(@BG, Parent);
          lCI := BGInfoToCI(@BG);
        end;

        with FCommonData.SkinManager.ConstData do begin
          Bar1Rect;
          if not IsRectEmpty(FBar1Rect) then begin
            if Enabled then
              LocalState := math.max(Bar1State, integer(BarIsHot))
            else
              LocalState := 0;

            Side := TacSide(integer(Kind <> sbHorizontal));
            with SkinManager.ConstData.Scrolls[Side] do
              if SkinData.SkinManager.IsValidSkinIndex(SkinIndex) then
                PaintItemFast(SkinIndex, MaskIndex, BGIndex[0], BGIndex[1],
                              lCi, True, LocalState, FBar1Rect, Point(Left, Top), FCommonData.FCacheBmp, SkinData.SkinManager);
          end;
          Bar2Rect;
          if not IsRectEmpty(FBar2Rect) then begin
            if Enabled then
              LocalState := math.max(Bar2State, integer(BarIsHot))
            else
              LocalState := 0;

            Side := TacSide(integer(Kind <> sbHorizontal) + 2);
            with SkinManager.ConstData.Scrolls[Side] do
              if SkinData.SkinManager.IsValidSkinIndex(SkinIndex) then
                PaintItemFast(SkinIndex, MaskIndex, BGIndex[0], BGIndex[1],
                              lCi, True, LocalState, FBar2Rect, Point(Left + FBar2Rect.Left, Top + FBar2Rect.Top), FCommonData.FCacheBmp, SkinData.SkinManager);
          end;
        end;
        BitBlt(bmp.Canvas.Handle, 0, 0, bmp.Width, bmp.Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);

        if SysBtnSize <> 0 then
          if Kind = sbHorizontal then begin
            ac_DrawScrollBtn(Btn1Rect, Btn1State, Bmp, SkinData, asLeft);
            ac_DrawScrollBtn(Btn2Rect, Btn2State, Bmp, SkinData, asRight);
          end
          else begin
            ac_DrawScrollBtn(Btn1Rect, Btn1State, Bmp, SkinData, asTop);
            ac_DrawScrollBtn(Btn2Rect, Btn2State, Bmp, SkinData, asBottom);
          end;

        if Enabled then
          DrawSlider(bmp);

        BG.PleaseDraw := False;
        if not Enabled then
          if LinkedControl <> nil then begin
            GetBGInfo(@BG, LinkedControl);
            lCI := BGInfoToCI(@BG);
            if lCI.Ready then
              BmpDisabledKind(bmp, FDisabledKind, Parent, lCI, Point(Left - LinkedControl.Left, Top - LinkedControl.Top))
            else begin
              c.C := lCI.FillColor;
              FadeBmp(bmp, MkRect(bmp.Width + 1, bmp.Height + 1), 60, c, 0, 0);
            end;
          end
          else begin
            lCI := GetParentCache(FCommonData);
            BmpDisabledKind(bmp, FDisabledKind, Parent, lCI, Point(Left, Top));
          end;

        BitBlt(DC, 0, 0, bmp.Width, bmp.Height, bmp.Canvas.Handle, 0, 0, SRCCOPY);
      end;
      if not Enabled and Assigned(bmp) then
        FreeAndNil(bmp);
    finally
      RestoreDC(DC, SavedDC);
      if MsgDC = 0 then
        ReleaseDC(Handle, DC);

      EndPaint(Handle, PS);
    end;
  end;
end;


procedure TsScrollBar.Preparetimer;
begin
  if Assigned(Timer) then
    FreeAndNil(Timer);

  SetCapture(Handle);
  Timer := TTimer.Create(Self);
  Timer.OnTimer := OnTimer;
  Timer.Interval := 50;
  Timer.Enabled := True;
end;


function TsScrollBar.SliderRect: TRect;
begin
  if Kind = sbHorizontal then begin
    if Max = Min then
      FSliderRect.Left := Btn1Rect.Right
    else
      FSliderRect.Left := PositionToCoord - SliderSize div 2;

    FSliderRect.Top := 0;
    FSliderRect.Right := FSliderRect.Left + SliderSize;
    FSliderRect.Bottom := Height;
  end
  else begin
    if Max = Min then
      FSliderRect.Top := Btn1Rect.Bottom
    else
      FSliderRect.Top := PositionToCoord - SliderSize div 2;

    FSliderRect.Left := 0;
    FSliderRect.Right := Width;
    FSliderRect.Bottom := FSliderRect.Top + SliderSize;
  end;
  Result := FSliderRect;
end;


function TsScrollBar.SliderSize: integer;
begin
  if FSI.nPage = 0 then
    Result := acMinThumbSize
  else
    Result := math.max(acMinThumbSize, Round(FSI.nPage * (WorkSize / (FSI.nMax - Math.Max(Integer(FSI.nPage) - 1, 0) + integer(FSI.nPage) - FSI.nMin))));
end;


procedure TsScrollBar.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  if not DrawingForbidden and not InAnimationProcess then
    DefaultHandler(Message);
end;


procedure TsScrollBar.WndProc(var Message: TMessage);
var
  OldPos: integer;
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  if (Message.Msg = SM_ALPHACMD) and not (csDestroying in ComponentState) then
    case Message.WParamHi of
      AC_CTRLHANDLED: begin
        Message.Result := 1;
        Exit;
      end;

      AC_REMOVESKIN:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          CommonWndProc(Message, FCommonData);
          if not SkinnedRecreate then begin
            OldPos := Position;
            RecreateWnd;
            Position := OldPos;
          end;
          Exit;
        end;

      AC_SETNEWSKIN:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          CommonWndProc(Message, FCommonData);
          Exit;
        end;

      AC_REFRESH:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          CommonWndProc(Message, FCommonData);
          FCommonData.BGChanged := True;
          if not SkinnedRecreate then begin
            SkinnedRecreate := True;
            OldPos := Position;
            RecreateWnd;
            Position := OldPos;
            SkinnedRecreate := False;
          end;
          Exit;
        end;

      AC_ENDPARENTUPDATE: begin
        FCommonData.Updating := False;
        Repaint;
        Exit;
      end
    end;

  case Message.Msg of
    WM_PRINT:
      if (DefaultManager <> nil) and DefaultManager.Active then begin
        SendMessage(Handle, WM_PAINT, Message.WParam, Message.LParam);
        Perform(WM_NCPAINT, Message.WParam, Message.LParam);
        Exit;
      end;

    WM_NCHITTEST:
      if MustBeRecreated and not InAnimationProcess then begin // Control must be recreated for the skinned mode using without std blinking
        MustBeRecreated := False;
        SkinnedRecreate := True;
        OldPos := Position;
        if Parent <> nil then begin
          SendMessage(Parent.Handle, WM_SETREDRAW, 0, 0);
          RecreateWnd;
          SendMessage(Parent.Handle, WM_SETREDRAW, 1, 0);
        end
        else
          RecreateWnd;

        Position := OldPos;
        SkinnedRecreate := False;
      end;
  end;
  if CommonWndProc(Message, FCommonData) then
    Exit;

  if Skinned(Self) then begin
    case Message.Msg of
      CM_ENABLEDCHANGED: begin
        inherited;
        FCommonData.Invalidate;
        Exit;
      end;

      CM_CHANGED: begin
        if Visible and HandleAllocated then begin
          SendMessage(Handle, WM_SETREDRAW, 0, 0);
          inherited;
          SendMessage(Handle, WM_SETREDRAW, 1, 0);
          FCommonData.Invalidate;
        end
        else
          inherited;

        Exit;
      end;

      SBM_SETSCROLLINFO: begin
        with PScrollInfo(Message.LParam)^ do begin
          if Boolean(fMask and SIF_PAGE) and (FSI.nPage <> nPage) then begin
            FSI.nPage := PScrollInfo(Message.LParam)^.nPage;
            RepaintNeeded := LongBool(Message.WParam);
          end;
          if Boolean(fMask and SIF_POS) and (FSI.nPos <> nPos) then begin
            FSI.nPos := PScrollInfo(Message.LParam)^.nPos;
            RepaintNeeded := LongBool(Message.WParam);
          end;
          if Boolean(fMask and SIF_RANGE) and ((FSI.nMin <> nMin) or (FSI.nMax <> nMax)) then begin
            if (nMax - nMin) < 0 then begin
              FSI.nMin := 0;
              FSI.nMax := 0;
              RepaintNeeded := LongBool(Message.WParam);
            end
            else begin
              FSI.nMin := nMin;
              FSI.nMax := nMax;
              RepaintNeeded := LongBool(Message.WParam);
            end;
            if Boolean(fMask and SIF_POS) then begin
              if (Min <> FSI.nMin) then
                Min := FSI.nMin;

              if (Cardinal(PageSize) <> FSI.nPage) and (FSI.nPage < Cardinal(Max)) then
                PageSize := FSI.nPage;

              if PageSize > FSI.nMax then
                PageSize := FSI.nMax;

              if (FSI.nMax <> Max) then
                Max := FSI.nMax;
            end;
          end;
          if integer(FSI.nPage) < 0 then
            FSI.nPage := 0
          else
            if integer(FSI.nPage) > (FSI.nMax - FSI.nMin + 1) then
              FSI.nPage := (FSI.nMax - FSI.nMin + 1);

          if FSI.nPos < FSI.nMin then
            FSI.nPos := FSI.nMin
          else
            if FSI.nPos > (FSI.nMax - Math.Max(Integer(FSI.nPage) - 1, 0)) then
              FSI.nPos := (FSI.nMax - Math.Max(Integer(FSI.nPage) - 1, 0));

          if ScrollCode <> SB_THUMBTRACK then
            FCurrPos := FSI.nPos;
        end;
        if Visible then begin
          SendMessage(Handle, WM_SETREDRAW, 0, 0);
          inherited;
          SendMessage(Handle, WM_SETREDRAW, 1, 0);
        end
        else
          inherited;

        if not DrawingForbidden then
          Repaint;
          
        Exit;
      end;

      SBM_GETSCROLLINFO:
        with PScrollInfo(Message.LParam)^ do begin
          if Boolean(fMask and SIF_PAGE) then
            nPage := FSI.nPage;

          if Boolean(fMask and SIF_POS) then
            nPos := FSI.nPos;

          if Boolean(fMask and SIF_TRACKPOS) and (cbSize = SizeOf(TScrollInfo)) then
            nTrackPos := FSI.nTrackPos;

          if Boolean(fMask and SIF_RANGE) then begin
            nMin := FSI.nMin;
            nMax := FSI.nMax;
          end;
        end;
    end;
  end;
  inherited WndProc(Message);
end;


procedure TsScrollBar.DrawSlider(b: TBitmap);
var
  R: TRect;
begin
  R := SliderRect;
  if Kind = sbVertical then begin
    if HeightOf(R) > Height - HeightOf(FBtn1Rect) - HeightOf(FBtn2Rect) then
      Exit
  end
  else
    if WidthOf(R) > Width - WidthOf(FBtn1Rect) - WidthOf(FBtn2Rect) then
      Exit;

  ac_DrawSlider(R, SliderState, b, SkinData.SkinManager, Kind = sbVertical);
end;


procedure TsScrollBar.WMNCHitTest(var Message: TWMNCHitTest);
var
  i: integer;
begin
  if Skinned(Self) and Enabled and not (csDesigning in ComponentState) then begin
    if not ControlIsReady(Self) then
      Exit;

    if PtInRect(SliderRect, CoordToPoint(SmallPointToPoint(Message.Pos))) or (SliderState = 2) then
      if SliderState <> 2 then
        SliderState := 1
      else begin
        i := CoordToPosition(CoordToPoint(Point(Message.Pos.X, Message.Pos.Y))) - MouseOffset;
        if FCurrPos <> i then begin
          DrawingForbidden := True;
          SetPos(i);
        end;
      end
    else
      if PtInRect(Btn1Rect, CoordToPoint(SmallPointToPoint(Message.Pos))) then begin
        if Btn1State <> 2 then
          Btn1State := 1;
      end
      else
        if PtInRect(Btn2Rect, CoordToPoint(SmallPointToPoint(Message.Pos))) then begin
          if Btn2State <> 2 then
            Btn2State := 1;
        end
        else
          if SliderState = 2 then begin
            i := CoordToPosition(CoordToPoint(SmallPointToPoint(Message.Pos)));
            if FCurrPos <> i then begin
              DrawingForbidden := True;
              SetPos(i);
            end;
          end
          else begin
            SliderState := 0;
            Btn1State := 0;
            Btn2State := 0;
          end;

    if Self <> nil then
      UpdateBar;
  end;
  inherited;
end;


procedure TsScrollBar.OnBtnTimer(Sender: TObject);
begin
  if Assigned(Timer) and not (csDestroying in Timer.ComponentState) then begin
    if Btn1State = 2 then
      IncPos(-1)
    else
      if Btn2State = 2 then
        IncPos(1)
      else
        if Assigned(Timer) then
          FreeAndNil(Timer);

    if Assigned(Timer) and (Timer.Interval > 50) then
      Timer.Interval := 50;
  end;
end;


procedure TsScrollBar.PrepareBtnTimer;
begin
  if Assigned(Timer) then
    FreeAndNil(Timer);

  Timer := TTimer.Create(Self);
  Timer.OnTimer := OnBtnTimer;
  Timer.Interval := 500;
  Timer.Enabled := True;
end;


function TsScrollBar.PositionToCoord: integer;
begin
  if Enabled and (FSI.nMax - FSI.nMin - Math.Max(Integer(FSI.nPage) - 1, 0) <> 0) then
    if Kind = sbHorizontal then
      Result := SysBtnSize + SliderSize div 2 + Round((FCurrPos - FSI.nMin) * ((Width - 2 * SysBtnSize - SliderSize) / (FSI.nMax - FSI.nMin - Math.Max(Integer(FSI.nPage) - 1,0))))
    else
      Result := SysBtnSize + SliderSize div 2 + Round((FCurrPos - FSI.nMin) * ((Height - 2 * SysBtnSize - SliderSize) / (FSI.nMax - FSI.nMin - Math.Max(Integer(FSI.nPage) - 1,0))))
  else
    if Kind = sbHorizontal then
      Result := Width div 2
    else
      Result := Height div 2;
end;


function TsScrollBar.CoordToPoint(p: TPoint): TPoint;
begin
  Result := ScreenToClient(P);
end;


procedure TsScrollBar.KeyDown(var Key: word; Shift: TShiftState);
begin
  inherited;
end;


procedure TsScrollBar.WMPaint(var Msg: TWMPaint);
begin
  if DrawingForbidden or (not (csCreating in Controlstate) and Assigned(SkinData.SkinManager) and SkinData.SkinManager.CommonSkinData.Active and not (csDestroying in Componentstate)) then begin
    if MustBeRecreated and not InAnimationProcess then
      CheckRecreate
    else
      if not InUpdating(FCommonData) then
        Paint(Msg.DC);
  end
  else
    inherited;
end;


procedure TsScrollBar.CMMouseLeave(var Msg: TMessage);
begin
  if Skinned(Self) then begin
    Btn1State := 0;
    Btn2State := 0;
    if SliderState <> 2 then begin
      SliderState := 0;
      Bar1State := 0;
      Bar2State := 0;
    end;
    UpdateBar;
  end
  else
    inherited;
end;


procedure TsScrollBar.PrepareBarTimer;
begin
  if Assigned(Timer) then
    FreeAndNil(Timer);

  Timer := TTimer.Create(Self);
  Timer.OnTimer := OnBarTimer;
  Timer.Interval := 500;
  Timer.Enabled := True;
end;


procedure TsScrollBar.OnBarTimer(Sender: TObject);
begin
  if Assigned(Timer) and not (csDestroying in Timer.ComponentState) then begin
    if (Bar1State = 2) and (FCurrPos > CoordToPosition(ScreenToClient(acMousePos))) then
      IncPos(-Math.Max(Integer(FSI.nPage), 1))
    else
      if (Bar2State = 2) and (FCurrPos < CoordToPosition(ScreenToClient(acMousePos))) then
        IncPos(Math.Max(Integer(FSI.nPage), 1))
      else
        if Assigned(Timer) then
          FreeAndNil(Timer);

    if assigned(Timer) and (Timer.Interval > 50) then
      Timer.Interval := 50;
  end;
end;


function TsScrollBar.Bar1Rect: TRect;
begin
  FBar1Rect.Left := 0;
  FBar1Rect.Top := 0;
  if Kind = sbHorizontal then begin
    FBar1Rect.Right := PositionToCoord;
    FBar1Rect.Bottom := Height;
  end
  else begin
    FBar1Rect.Right := Width;
    FBar1Rect.Bottom := PositionToCoord;
  end;
  Result := FBar1Rect;
end;


function TsScrollBar.Bar2Rect: TRect;
begin
  if Kind = sbHorizontal then begin
    FBar2Rect.Left := PositionToCoord;
    FBar2Rect.Top := 0;
  end
  else begin
    FBar2Rect.Left := 0;
    FBar2Rect.Top := PositionToCoord;
  end;
  FBar2Rect.Right := Width;
  FBar2Rect.Bottom := Height;
  Result := FBar2Rect;
end;


procedure TsScrollBar.CMMouseEnter(var Msg: TMessage);
begin
  if Skinned(Self) then begin
    Bar1State := 1;
    Bar2State := 1;
    UpdateBar;
  end
  else
    inherited;
end;


procedure TsScrollBar.UpdateBar;
begin
  DrawingForbidden := False;
  if RepaintNeeded then
    Paint(0);
end;


procedure TsScrollBar.SetInteger(Index, Value: integer);
begin
  case Index of
    0: if FBtn1State <> Value then begin
      RepaintNeeded := True;
      FBtn1State := Value;
      case Value of
        1, 2: begin
          FBtn2State := 0;
          FSliderState := 0;
          FBar1State := 1;
          FBar2State := 1;
        end;
      end;
    end;

    1: if FBtn2State <> Value then begin
      RepaintNeeded := True;
      FBtn2State := Value;
      case Value of
        1, 2: begin
          FBtn1State := 0;
          FSliderState := 0;
          FBar1State := 1;
          FBar2State := 1;
        end;
      end;
    end;

    2: if FBar1State <> Value then begin
      RepaintNeeded := True;
      FBar1State := Value;
      case Value of
        1, 2: begin
          FBtn1State := 0;
          FBtn2State := 0;
          FSliderState := 0;
          FBar2State := 1;
        end;
      end;
    end;

    3: if FBar2State <> Value then begin
      RepaintNeeded := True;
      FBar2State := Value;
      case Value of
        1, 2: begin
          FBtn1State := 0;
          FBtn2State := 0;
          FSliderState := 0;
          FBar1State := 1;
        end;
      end;
    end;

    4: if FSliderState <> Value then begin
      RepaintNeeded := True;
      FSliderState := Value;
      case Value of
        1, 2: begin
          FBtn1State := 0;
          FBtn2State := 0;
          FBar1State := 1;
          FBar2State := 1;
        end;
      end;
    end;
  end;
end;


function TsScrollBar.BarIsHot: boolean;
begin
  Result := ControlIsActive(FCommonData);
end;


function TsScrollBar.WorkSize: integer;
begin
  Result := iff(Kind = sbHorizontal, Width, Height) - 2 * SysBtnSize
end;


procedure TsScrollBar.SetDisabledKind(const Value: TsDisabledKind);
begin
  if FDisabledKind <> Value then begin
    FDisabledKind := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsScrollBar.IncPos(Offset: integer);
begin
  SetPos(FCurrPos + Offset);
end;


procedure TsScrollBar.SetPos(Pos: integer);
const
  Kinds:  array [TScrollBarKind] of DWORD = (SB_HORZ, SB_VERT);
  Styles: array [TScrollBarKind] of DWORD = (WM_HSCROLL, WM_VSCROLL);
var
  m: TWMScroll;
begin
  FCurrPos := Pos;
  if FCurrPos < FSI.nMin then
    FCurrPos := FSI.nMin
  else
    if FCurrPos > (FSI.nMax - Math.Max(Integer(FSI.nPage) - 1, 0)) then
      FCurrPos := (FSI.nMax - Math.Max(Integer(FSI.nPage) - 1, 0));

  m.Msg := Styles[Kind];
  m.ScrollBar := Handle;
  m.ScrollCode := SmallInt(ScrollCode);

  if m.ScrollCode = SB_THUMBTRACK then begin
    if (FSI.nTrackPos = FCurrPos) and (not FBeginTrack) then
      Exit;

    FBeginTrack := false;
    FSI.nTrackPos := FCurrPos
  end
  else
    m.Pos := SmallInt(FCurrPos);

  if m.ScrollCode in [SB_THUMBTRACK, SB_THUMBPOSITION] then
    m.Pos := SmallInt(FCurrPos)
  else
    m.Pos := 0;

  SendMessage(Handle, M.Msg, TMessage(M).WParam, TMessage(M).LParam);
  RepaintNeeded := true;
  UpdateBar;

  if DoSendChanges and Assigned(LinkedControl) and LinkedControl.HandleAllocated then
    SendMessage(LinkedControl.Handle, M.Msg, TMessage(M).WParam, TMessage(M).LParam);
end;


procedure TsScrollBar.CNHScroll(var Message: TWMHScroll);
begin
  if not (DoSendChanges and Assigned(LinkedControl)) then
    inherited;
end;


procedure TsScrollBar.CNVScroll(var Message: TWMVScroll);
begin
  if not (DoSendChanges and Assigned(LinkedControl)) then
    inherited;
end;


function TsScrollBar.GetSkinManager: TsSkinManager;
begin
  Result := SkinData.SkinManager
end;


procedure TsScrollBar.SetSkinManager(const Value: TsSkinManager);
begin
  SkinData.SkinManager := Value;
  SkinData.Updating := False;
end;


procedure TsScrollBar.Change;
begin
  CheckRecreate;
  if not SkinnedRecreate then
    inherited;
end;


procedure TsScrollBar.CheckRecreate;
var
  OldPos: integer;
begin
  if MustBeRecreated then begin // Control must be recreated for the skinned mode using without std blinking
    MustBeRecreated := False;
    SkinnedRecreate := True;
    OldPos := Position;
    RecreateWnd;
    Position := OldPos;
    SkinnedRecreate := False;
  end;
end;


function TsScrollBar.SysBtnSize: integer;
begin
  Result := GetScrollSize(SkinData.SkinManager);
end;

end.
