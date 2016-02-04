unit sTrackBar;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, comctrls,
  commctrl, ExtCtrls,
  {$IFNDEF DELPHI5} types,{$ENDIF}
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  {$IFDEF TNTUNICODE} TntComCtrls, {$ENDIF}
  sConst, acntUtils, sGraphUtils, sDefaults, sCommonData, sFade;


type
  TsTrackBar = class;
{$IFNDEF NOTFORHELP}
  TAPoint = array of TPoint;
{$ENDIF}

{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
{$IFDEF TNTUNICODE}
  TsTrackBar = class(TTnTTrackBar)
{$ELSE}
  TsTrackBar = class(TTrackBar)
{$ENDIF}
{$IFNDEF NOTFORHELP}
  private
    FOnUserChange,
    FOnUserChanged: TNotifyEvent;

    EventFlag,
    FReversed,
    FShowFocus,
    AppShowHint,
    FShowProgress: boolean;

    Thumb,
    FThumbGlyph: TBitmap;

    FCanvas: TCanvas;
    FBarOffset: TPoint;
    FCommonData: TsCommonData;
    FOnSkinPaint: TPaintEvent;
    FShowProgressFrom: Integer;
    FDisabledKind: TsDisabledKind;
    FAnimatEvents: TacAnimatEvents;
    function GetHBarOffset: Integer;
    function GetVBarOffset: Integer;
    procedure SetHBarOffset      (const Value: Integer);
    procedure SetVBarOffset      (const Value: Integer);
    procedure SetThumbGlyph      (const Value: TBitmap);
    procedure SetShowProgressFrom(const Value: Integer);
    procedure SetDisabledKind    (const Value: TsDisabledKind);
    procedure SetBoolean         (const Index: Integer; const Value: boolean);
    procedure WMNCHitTest        (var Message: TWMNCHitTest);
    procedure WMMouseMsg         (var Message: TWMMouse);
    procedure TBMGetThumbRect    (var Message: TMessage);
  protected
    TickHeight,
    FTickNdx,
    FThumbNdx,
    FSliderNdx,
//    TrackBarNdx,
    FProgressNdx: integer;

    iStep: real;

    procedure UpdateIndexes(MainNdx: integer);

    procedure StdPaintBG (Bmp: TBitmap);
    procedure StdPaintBar(Bmp: TBitmap);
    procedure StdPaintThumb(i: integer);

    procedure PaintBody;
    procedure PaintBar;
    procedure PaintTicksHor;
    procedure PaintTicksVer;
    procedure PaintTick    (P: TPoint; Horz: boolean);
    procedure PaintProgress(R: TRect;  Horz: boolean);
    procedure PaintThumb;

    procedure Paint;
    procedure PrepareCache;

    procedure PaintWindow(DC: HDC); override;
    property Canvas: TCanvas read FCanvas;
    procedure WndProc(var Message: TMessage); override;
    procedure UserChanged(Finished: boolean);
  public
    function ThumbRect: TRect;
    function ChannelRect: TRect;
    function TickPos(i: integer): integer;
    function TickCount: integer;
    function TicksArray: TAPoint;
    constructor Create(AOwner: TComponent); override;
    procedure CreateWnd; override;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure Loaded; override;
    function Mode: integer;
  published
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property ThumbLength default 23;
{$ENDIF} // NOTFORHELP
    property AnimatEvents: TacAnimatEvents read FAnimatEvents write FAnimatEvents default [aeGlobalDef];
    property DisabledKind: TsDisabledKind read FDisabledKind write SetDisabledKind default DefDisabledKind;
    property SkinData: TsCommonData read FCommonData write FCommonData;

    property Reversed:     boolean index 0 read FReversed     write SetBoolean default False;
    property ShowFocus:    boolean index 1 read FShowFocus    write SetBoolean default False;
    property ShowProgress: boolean index 2 read FShowProgress write SetBoolean default False;

    property ThumbGlyph: TBitmap read FThumbGlyph write SetThumbGlyph;
{$IFNDEF NOTFORHELP}
    property OnSkinPaint:   TPaintEvent  read FOnSkinPaint   write FOnSkinPaint;
    property OnUserChange:  TNotifyEvent read FOnUserChange  write FOnUserChange;
    property OnUserChanged: TNotifyEvent read FOnUserChanged write FOnUserChanged;
    property TickStyle;
    property TickMarks;
{$ENDIF} // NOTFORHELP
    property BarOffsetV: Integer read GetVBarOffset write SetVBarOffset;
    property BarOffsetH: Integer read GetHBarOffset write SetHBarOffset;
    property ShowProgressFrom: Integer read FShowProgressFrom write SetShowProgressFrom default 0;
  end;


implementation

uses
  math,
  {$IFDEF DELPHI7UP}Themes, {$ENDIF}
  sMaskData, sSkinProps, sAlphaGraph, sVCLUtils, sMessages, sSkinManager, sStyleSimply;

const
  iThumbSize = 23;
{$IFNDEF D2007}
  TBS_DOWNISLEFT = 1024;
  TBS_REVERSED   = 512;
{$ENDIF}


constructor TsTrackBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCommonData := TsCommonData.Create(Self, True);
  FCommonData.COC := COC_TsTrackBar;

  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;

  Thumb := TBitmap.Create;
  Thumb.PixelFormat := pf32Bit;

  FThumbGlyph := TBitmap.Create;

  ControlStyle := ControlStyle - [csOpaque];
  EventFlag := False;

  TickHeight := 4;
  ThumbLength := iThumbSize;
  FShowProgressFrom := 0;

  FDisabledKind := DefDisabledKind;
  FAnimatEvents := [aeGlobalDef];
  FShowProgress := False;
  FReversed := False;
end;


destructor TsTrackBar.Destroy;
begin
  if Assigned(FCommonData) then
    FreeAndNil(FCommonData);

  if Assigned(Thumb) then
    FreeAndNil(Thumb);
    
  FreeAndNil(FCanvas);
  FreeAndNil(FThumbGlyph);
  inherited Destroy;
end;


function TsTrackBar.GetHBarOffset: Integer;
begin
  Result := FBarOffset.X;
end;


function TsTrackBar.GetVBarOffset: Integer;
begin
  Result := FBarOffset.Y;
end;


procedure TsTrackBar.WMMouseMsg(var Message: TWMMouse);
var
  State: TKeyboardState;

  function GetShiftState: TShiftState;
  begin
    Result := [];
    if GetAsyncKeyState(VK_SHIFT) < 0 then
      Include(Result, ssShift);

    if GetAsyncKeyState(VK_CONTROL) < 0 then
      Include(Result, ssCtrl);

    if GetAsyncKeyState(VK_MENU) < 0 then
      Include(Result, ssAlt);
  end;

begin
  if FReversed then
    if Orientation = trVertical then
      Message.YPos := Height - Message.YPos
    else
      Message.XPos := Width - Message.XPos;

  DefaultHandler(Message);
  GetKeyboardState(State);
  case Message.Msg of
    WM_LBUTTONUP:     if Assigned(OnMouseUp)   then OnMouseUp  (Self, mbLeft, GetShiftState, acMousePos.X, acMousePos.Y);
    WM_LBUTTONDOWN:   if Assigned(OnMouseDown) then OnMouseDown(Self, mbLeft, GetShiftState, acMousePos.X, acMousePos.Y);
  end;
end;


procedure TsTrackBar.WMNCHitTest(var Message: TWMNCHitTest);
var
  R: TRect;
begin
  GetWindowRect(Handle, R);
  if Orientation = trVertical then
    Message.YPos := Height - (Message.YPos - R.Top) + R.Top
  else
    Message.XPos := Width - (Message.XPos - R.Left) + R.Left;
end;


procedure TsTrackBar.WndProc(var Message: TMessage);
var
  PS: TPaintStruct;
  DC, SavedDC: hdc;
{$IFDEF DELPHI7UP}
  ParentForm: TCustomForm;
{$ENDIF}
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
        end; // AlphaSkins supported

        AC_REMOVESKIN:
          if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
            CommonMessage(Message, FCommonData);
            RecreateWnd;
            Exit;
          end;

        AC_SETNEWSKIN:
          if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
            CommonMessage(Message, FCommonData);
            UpdateIndexes(SkinData.SkinIndex);
            Exit;
          end;

        AC_REFRESH:
          if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
            CommonMessage(Message, FCommonData);
            Repaint;
            Exit;
          end;

        AC_PREPARECACHE:
          PrepareCache;

        AC_DRAWANIMAGE: begin
          Message.Result := 0;
          if Message.LParam <> 0 then
            try
              DC := GetWindowDC(Handle);
              SavedDC := SaveDC(DC);
              try
                BitBlt(DC, BorderWidth, BorderWidth, Width, Height, TBitmap(Message.LParam).Canvas.Handle, 0, 0, SRCCOPY);
              finally
                RestoreDC(DC, SavedDC);
                ReleaseDC(Handle, DC);
              end;
            finally
              Message.Result := 1;
            end;

          Exit;
        end;

        AC_GETDEFINDEX: begin
          if FCommonData.SkinManager <> nil then begin
            Message.Result := FCommonData.SkinManager.ConstData.Sections[ssTrackBar] + 1;
          end
          else
            Message.Result := 0;

          UpdateIndexes(Message.Result - 1);
          Exit;
        end;

        AC_ENDPARENTUPDATE:
          if FCommonData.Updating then begin
            FCommonData.Updating := False;
            Repaint;
          end
      end;

      CM_MOUSEENTER:
        if not (csDesigning in ComponentState) and not (csLButtonDown in ControlState) then begin
{$IFDEF DELPHI7UP}
          ParentForm := GetParentForm(Self);
          if (ParentForm = nil) or not TForm(ParentForm).TransparentColor then
{$ENDIF}
          begin
            FCommonData.FMouseAbove := True;
            FCommonData.BGChanged := False;
            if FCommonData.SkinIndex >= 0 then
              DoChangePaint(FCommonData, 1, UpdateWindow_CB, EventEnabled(aeMouseEnter, FAnimatEvents), False)
            else
              RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_NOERASE or RDW_UPDATENOW);
          end;
        end;

      CM_MOUSELEAVE:
        if not (csDesigning in ComponentState) and not (csLButtonDown in ControlState) then begin
{$IFDEF DELPHI7UP}
          ParentForm := GetParentForm(Self);
          if (ParentForm = nil) or not TForm(ParentForm).TransparentColor then
{$ENDIF}
          begin
            FCommonData.FMouseAbove := False;
            FCommonData.BGChanged := False;
            if FCommonData.SkinIndex >= 0 then
              DoChangePaint(FCommonData, 0, UpdateWindow_CB, EventEnabled(aeMouseLeave, FAnimatEvents), False)
            else
              RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_NOERASE or RDW_UPDATENOW);
          end;
        end;

      WM_NCHITTEST:
        if not (csDesigning in ComponentState) and FReversed then begin
          WMNCHitTest(TWMNCHitTest(Message));
          Message.Result := 1;
          Exit;
        end;

      WM_MOUSEMOVE:
        if not (csDesigning in ComponentState) and FReversed then 
          WMMouseMsg(TWMMouse(Message));

      WM_LBUTTONUP, WM_LBUTTONDBLCLK, WM_LBUTTONDOWN:
        if not (csDesigning in ComponentState) and FReversed then begin
          WMMouseMsg(TWMMouse(Message));
          Exit;
        end;

      TBM_GETTHUMBRECT: begin
        TBMGetThumbRect(Message);
        Exit;
      end;

      WM_PAINT: if not SkinData.Skinned then begin
        ControlState := ControlState + [csCustomPaint];
        inherited;
        ControlState := ControlState - [csCustomPaint];
        Exit;
      end;

{$IFDEF DELPHI_XE4}
      WM_ERASEBKGND:
        if csDesigning in ComponentState then begin
          FCanvas.Lock;
          if TWMPaint(Message).DC <> 0 then
            FCanvas.Handle := TWMPaint(Message).DC
          else
            FCanvas.Handle := GetWindowDC(Handle);

          try
            TControlCanvas(FCanvas).UpdateTextFlags;
            Paint;
          finally
            if TWMPaint(Message).DC = 0 then
              ReleaseDC(Handle, FCanvas.Handle);

            FCanvas.Handle := 0;
            FCanvas.Unlock;
          end;
          Exit;
        end;
{$ENDIF}        
  end;

  if not ControlIsReady(Self) or not FCommonData.Skinned(True) then
    inherited
  else begin
    case Message.Msg of
      WM_PRINT: begin
        SkinData.FUpdating := False;
        PaintWindow(TWMPaint(Message).DC);
      end;

      WM_PAINT: begin
        if TimerIsActive(SkinData) then begin
          BeginPaint(Handle, PS);
          EndPaint(Handle, PS);
          Exit;
        end;
        ControlState := ControlState + [csCustomPaint];
      end;

      WM_ERASEBKGND:
        Exit;

      WM_SETFOCUS, CM_ENTER:
        if not (csDesigning in ComponentState) then begin
          inherited;
          if Enabled and not TimerIsActive(SkinData) then
            Repaint;

          Exit;
        end;

      WM_KILLFOCUS, CM_EXIT:
        if not (csDesigning in ComponentState) then begin
          inherited;
          if Enabled then begin
            StopTimer(SkinData);
            Exit
          end;
        end;

      WM_SIZE:
        StopTimer(SkinData);

      WM_LBUTTONUP:
        if not (csDesigning in ComponentState) and Enabled then begin
          Application.ShowHint := AppShowHint;
          ShowHintStored := False;
          if PtInRect(ThumbRect, SmallPointToPoint(TWMMouse(Message).Pos)) then begin
            ControlState := ControlState - [csLButtonDown];
            DoChangePaint(FCommonData, 1, UpdateWindow_CB, EventEnabled(aeMouseUp, FAnimatEvents), True);
          end
          else
            StopTimer(SkinData);
        end;

      WM_LBUTTONDBLCLK, WM_LBUTTONDOWN:
        if not (csDesigning in ComponentState) and Enabled then begin
          if not ShowHintStored then begin
            AppShowHint := Application.ShowHint;
            Application.ShowHint := False;
            ShowHintStored := True;
          end;
          if PtInRect(ThumbRect, SmallPointToPoint(TWMMouse(Message).Pos)) then begin
            ControlState := ControlState + [csLButtonDown];
            Skindata.BGChanged := False;
            DoChangePaint(FCommonData, 2, UpdateWindow_CB, EventEnabled(aeMouseDown, FAnimatEvents), True);
          end
          else
            StopTimer(SkinData);
        end;

      CN_HSCROLL, CN_VSCROLL: begin
        StopTimer(SkinData);
//        RedrawWindow(Handle, nil, 0, RDW_UPDATENOW or RDW_INVALIDATE);
        PaintWindow(0);
      end;
    end;
    CommonWndProc(Message, FCommonData);
    inherited;
    case Message.Msg of
      TB_INDETERMINATE: {if not ThumbGlyph.Empty then }
        Repaint; // Full control repainting

      WM_MOVE:
        if csDesigning in ComponentState then
          Repaint;

      WM_PAINT:
        ControlState := ControlState - [csCustomPaint];
    end;
  end;
  case Message.Msg of
    CN_HSCROLL, CN_VSCROLL:
      if not EventFlag then begin
        EventFlag := True;
        UserChanged(TWMScroll(Message).ScrollCode in [TB_THUMBPOSITION, TB_LINEUP, TB_LINEDOWN, TB_PAGEUP, TB_PAGEDOWN]);
        EventFlag := False;
      end;
  end;
end;


procedure TsTrackBar.PaintBody;
var
  R: TRect;
  fColor: TColor;
begin
  R := ClientRect;
  if SkinData.SkinIndex >= 0 then begin
    PaintItem(FCommonData, GetParentCache(FCommonData), True, integer(ControlIsActive(FCommonData)), R, Point(Left, Top), FCommonData.FCacheBmp, False);
    if SkinData.SkinIndex >= 0 then begin
      PaintBar;
      if Assigned(FOnSkinPaint) then
        FOnSkinPaint(Self, FCommonData.FCacheBMP.Canvas);

      PaintThumb;
    end;
    FColor := SkinData.SkinManager.gd[SkinData.SkinIndex].Props[1].FontColor.Color;
  end
  else begin
    StdPaintBG(FCommonData.FCacheBmp);
    if Assigned(FOnSkinPaint) then
      FOnSkinPaint(Self, FCommonData.FCacheBMP.Canvas);

    StdPaintBar(FCommonData.FCacheBmp);
    StdPaintThumb(Position);
    FColor := clBtnText;
  end;
  if FShowFocus and Focused then begin
    InflateRect(R, 0, -1);
    FocusRect(SkinData.FCacheBMP.Canvas, R, FColor, clNone)
  end;
end;


procedure TsTrackBar.PaintBar;
var
  w, h, i, j, d, pos: integer;
  aRect, sRect: TRect;
  CI: TCacheInfo;
begin
  aRect := ChannelRect;
//  i := SkinData.SkinManager.GetMaskIndex(TrackBarNdx, s_SliderChannelMask);
  if SkinData.SkinManager.IsValidImgIndex(FSliderNdx) then begin
    CI := MakeCacheInfo(FCommonData.FCacheBmp);
    pos := SendMessage(Handle, TBM_GETPOS, 0, 0);
    case Orientation of
      trHorizontal: begin
        h := HeightOfImage(SkinData.SkinManager.ma[FSliderNdx]) - 1;
        w := HeightOf(aRect);
        aRect.Top := aRect.Top + (w - h) div 2;
        aRect.Bottom := aRect.Top + h;
        InflateRect(aRect, -1, 0);
        DrawSkinRect(FCommonData.FCacheBmp, aRect, CI, SkinData.SkinManager.ma[FSliderNdx], integer(ControlIsActive(FCommonData)), True);
        if ShowProgress then begin
          sRect := aRect;
          d := math.Max(0, ShowProgressFrom - Min);
          if Max = Min then begin
            i := pos - Min;
            j := d;
          end
          else begin
            i := Round(WidthOf(aRect) * (pos - Min) / (Max - Min));
            j := Round(WidthOf(aRect) * d / (Max - Min));
          end;
          if Reversed then
            if (pos < ShowProgressFrom) then begin
              sRect.Left := sRect.Right - j;
              sRect.Right := sRect.Right - i;
            end
            else begin
              sRect.Left := sRect.Right - i;
              sRect.Right := sRect.Right - j;
            end
          else
            if (pos < ShowProgressFrom) then begin
              sRect.Right := sRect.Left + j;
              sRect.Left := sRect.Left + i;
            end
            else begin
              sRect.Right := sRect.Left + i;
              sRect.Left := sRect.Left + j;
            end;

          PaintProgress(sRect, True);
        end;
      end;

      trVertical: begin
        h := WidthOfImage(SkinData.SkinManager.ma[FSliderNdx]) - 1;
        w := WidthOf(aRect);
        aRect.Left := aRect.Left + (w - h) div 2;
        aRect.Right := aRect.Left + h;
        InflateRect(aRect, 0, -1);
        DrawSkinRect(FCommonData.FCacheBmp, aRect, CI, SkinData.SkinManager.ma[FSliderNdx], integer(ControlIsActive(FCommonData)), True);
        if ShowProgress then begin
          sRect := aRect;
          d := math.Max(0, ShowProgressFrom - Min);
          if Max = Min then begin
            i := pos - Min;
            j := d;
          end
          else begin
            i := Round(HeightOf(aRect) * (pos - Min) / (Max - Min));
            j := Round(HeightOf(aRect) * d / (Max - Min));
          end;
          if Reversed then begin
            if (pos < ShowProgressFrom) then begin
              sRect.Top    := sRect.Bottom - j;
              sRect.Bottom := sRect.Bottom - i;
            end
            else begin
              sRect.Top    := sRect.Bottom - i;
              sRect.Bottom := sRect.Bottom - j;
            end;
          end
          else begin
            if (pos < ShowProgressFrom) then begin
              sRect.Bottom := sRect.Top + j;
              sRect.Top    := sRect.Top + i;
            end
            else begin
              sRect.Bottom := sRect.Top + i;
              sRect.Top    := sRect.Top + j;
            end;
          end;
{
          i := Round(HeightOf(aRect) * (SendMessage(Handle, TBM_GETPOS, 0, 0) - Min) / (Max - Min));
          if Reversed then
            sRect.Top := sRect.Bottom - i
          else
            sRect.Bottom := sRect.Top + i;
}
          PaintProgress(sRect, False);
        end;
      end;
    end;
  end;
  if Orientation = trHorizontal then
    PaintTicksHor
  else
    PaintTicksVer;
end;


const
  SelSize = 3;


procedure TsTrackBar.PaintTicksHor;
var
  dw: real;
  cr: TRect;
  pa: TAPoint;
  ArrowPoints: array of TPoint;
  i, mh, sStart, sEnd: integer;
begin
  pa := nil;
  mh := 0;
  if TickStyle <> tsNone then begin
    pa := TicksArray;
    cr := ChannelRect;
    mh := (HeightOf(ThumbRect) - HeightOf(cr)) div 2 + 2;
    if TickMarks in [tmTopLeft, tmBoth] then
      for i := 0 to High(pa) do
        if ((SelStart = 0) and (SelEnd = 0)) or ((i <> SelStart) and (i <> SelEnd)) then
          PaintTick(Point(pa[i].x, cr.Top - mh - TickHeight), True);

    if TickMarks in [tmBottomRight, tmBoth] then
      for i := 0 to High(pa) do
        if ((SelStart = 0) and (SelEnd = 0)) or ((i <> SelStart) and (i <> SelEnd)) then
          PaintTick(Point(pa[i].x, cr.Bottom + mh), True);
  end;
  if (SelStart <> 0) or (SelEnd <> 0) then begin
    sStart := math.max(SelStart, Min);
    sEnd := Math.min(SelEnd, Max);
    dw := (WidthOf(ChannelRect) - WidthOf(ThumbRect)) / (Max - Min);
    SetLength(ArrowPoints, 3);
    FCommonData.FCacheBmp.Canvas.Brush.Style := bsSolid;
    FCommonData.FCacheBmp.Canvas.Brush.Color := FCommonData.SkinManager.GetGlobalFontColor;
    FCommonData.FCacheBmp.Canvas.Pen.Color := FCommonData.SkinManager.GetGlobalFontColor;
    if TickMarks in [tmTopLeft, tmBoth] then begin
      // SelStart
      i := Round(dw * (sStart + 1)) + ChannelRect.Left + 4;
      ArrowPoints[0] := Point(i, cr.Top - mh - TickHeight);
      ArrowPoints[1] := Point(ArrowPoints[0].X, ArrowPoints[0].Y - SelSize);
      ArrowPoints[2] := Point(ArrowPoints[0].X - SelSize, ArrowPoints[0].Y - SelSize);
      FCommonData.FCacheBmp.Canvas.Polygon(ArrowPoints);
      // SelEnd
      i := Round(dw * (sEnd + 1)) + ChannelRect.Left + 4;
      ArrowPoints[0] := Point(i, cr.Top - mh - TickHeight);
      ArrowPoints[1] := Point(ArrowPoints[0].X, ArrowPoints[0].Y - SelSize);
      ArrowPoints[2] := Point(ArrowPoints[0].X + SelSize, ArrowPoints[0].Y - SelSize);
      FCommonData.FCacheBmp.Canvas.Polygon(ArrowPoints);
    end;
    if TickMarks in [tmBottomRight, tmBoth] then begin
      // SelStart
      i := Round(dw * (sStart + 1)) + ChannelRect.Left + 4;
      ArrowPoints[0] := Point(i, cr.Bottom + mh);
      ArrowPoints[1] := Point(ArrowPoints[0].X, ArrowPoints[0].Y + SelSize);
      ArrowPoints[2] := Point(ArrowPoints[0].X - SelSize, ArrowPoints[0].Y + SelSize);
      FCommonData.FCacheBmp.Canvas.Polygon(ArrowPoints);
      // SelEnd
      i := Round(dw * (sEnd + 1)) + ChannelRect.Left + 4;
      ArrowPoints[0] := Point(i, cr.Bottom + mh);
      ArrowPoints[1] := Point(ArrowPoints[0].X, ArrowPoints[0].Y + SelSize);
      ArrowPoints[2] := Point(ArrowPoints[0].X + SelSize, ArrowPoints[0].Y + SelSize);
      FCommonData.FCacheBmp.Canvas.Polygon(ArrowPoints);
    end
  end
end;


procedure RotateBmp180(Bmp: TBitmap; Horz: boolean);
var
  x, y: integer;
  c: TColor;
begin
  if not Horz then
    for x := 0 to Bmp.Width - 1 do
      for y := 0 to (Bmp.Height - 1) div 2 do begin
        c := Bmp.Canvas.Pixels[x, y];
        Bmp.Canvas.Pixels[x, y] := Bmp.Canvas.Pixels[x, Bmp.Height - y - 1];
        Bmp.Canvas.Pixels[x, Bmp.Height - y - 1] := c
      end
  else
    for y := 0 to Bmp.Height - 1 do
      for x := 0 to (Bmp.Width - 1) div 2 do begin
        c := Bmp.Canvas.Pixels[x, y];
        Bmp.Canvas.Pixels[x, y] := Bmp.Canvas.Pixels[Bmp.Width - x - 1, y];
        Bmp.Canvas.Pixels[Bmp.Width - x - 1, y] := c
      end;
end;


procedure TsTrackBar.PaintThumb;
var
  Bmp: TBitmap;
  GlyphSize: TSize;
  DrawPoint: TPoint;
  Stretched: boolean;
  aRect, DrawRect: TRect;

  procedure PaintGlyph(R: TRect);
  var
    b: boolean;
    S0, S: PRGBAArray;
    Y, X, DeltaS: integer;
  begin
    if ThumbGlyph.PixelFormat = pfDevice then begin
      ThumbGlyph.HandleType := bmDIB;
      if (ThumbGlyph.Handle <> 0) and (ThumbGlyph.PixelFormat = pf32bit) then begin // Checking for an empty alpha-channel
        b := False;
        if InitLine(ThumbGlyph, Pointer(S0), DeltaS) then
          for Y := 0 to ThumbGlyph.Height - 1 do begin
            S := Pointer(LongInt(S0) + DeltaS * Y);
            for X := 0 to ThumbGlyph.Width - 1 do
              if S[X].A = MaxByte then begin
                b := True;
                Break;
              end;

            if b then
              Break;
          end;
          
        if not b then
          ThumbGlyph.PixelFormat := pf24bit;
      end;
    end;
    if (ThumbGlyph.PixelFormat = pf32bit) then  // Patch if Png, don't work in std. mode
      CopyBmp32(R, MkRect(ThumbGlyph), FCommonData.FCacheBmp, ThumbGlyph, EmptyCI, False, clNone, 0, False)
    else
      BitBlt(FCommonData.FCacheBmp.Canvas.Handle, R.Left, R.Top, ThumbGlyph.Width, ThumbGlyph.Height, ThumbGlyph.Canvas.Handle, 0, 0, SRCCOPY);
  end;

  function PrepareBG: TRect;
  var
    TmpBmp: TBitmap;
  begin
    if Stretched or (TickMarks = tmTopLeft) then begin
      Bmp := CreateBmp32(GlyphSize);
      Result := MkRect(GlyphSize);
      TmpBmp := CreateBmp32(aRect);
      BitBlt(TmpBmp.Canvas.Handle, 0, 0, TmpBmp.Width, TmpBmp.Height, FCommonData.FCacheBmp.Canvas.Handle, aRect.Left, aRect.Top, SRCCOPY);
      Stretch(TmpBmp, Bmp, Bmp.Width, Bmp.Height, ftMitchell);
      if TickMarks = tmTopLeft then
        RotateBmp180(Bmp, Orientation <> trHorizontal);
        
      FreeAndNil(TmpBmp);
    end
    else begin
      Bmp := FCommonData.FCacheBmp;
      Result := aRect;
    end;
  end;

  procedure ReturnToCache;
  var
    TmpBmp: TBitmap;
  begin
    if FCommonData.FCacheBmp <> Bmp then begin
      if TickMarks = tmTopLeft then
        RotateBmp180(Bmp, Orientation <> trHorizontal);
        
      TmpBmp := CreateBmp32(aRect);
      Stretch(Bmp, TmpBmp, TmpBmp.Width, TmpBmp.Height, ftMitchell);
      BitBlt(FCommonData.FCacheBmp.Canvas.Handle, aRect.Left, aRect.Top, WidthOf(aRect), HeightOf(aRect), TmpBmp.Canvas.Handle, 0, 0, SRCCOPY);
      FreeAndNil(TmpBmp);
    end
  end;

begin
  aRect := ThumbRect;
  if ThumbGlyph.Empty then begin
{    if Orientation = trVertical then
      i := SkinData.SkinManager.GetMaskIndex(TrackBarNdx, s_SliderVertMask)
    else
      i := -1;

    if i = -1 then
      i := SkinData.SkinManager.GetMaskIndex(TrackBarNdx, s_SliderHorzMask);
}
    with SkinData.SkinManager do
      if IsValidImgIndex(FThumbNdx) then begin
        GlyphSize := MkSize(ma[FThumbNdx]);
        if (Orientation = trHorizontal) and (HeightOf(aRect) = iThumbSize) or (Orientation = trVertical) and (WidthOf(aRect) = iThumbSize) then
          Stretched := False
        else
          Stretched := (HeightOf(aRect) <> GlyphSize.cy) or (WidthOf(aRect) <> GlyphSize.cx);

        DrawRect := PrepareBG;
        DrawPoint := Point(DrawRect.Left + (WidthOf(DrawRect) - GlyphSize.cx) div 2, DrawRect.Top + (HeightOf(DrawRect) - GlyphSize.cy) div 2);
        DrawSkinGlyph(Bmp, DrawPoint, Mode, 1, ma[FThumbNdx], MakeCacheInfo(Bmp));
        ReturnToCache;
        if Bmp <> FCommonData.FCacheBmp then
          FreeAndNil(Bmp);
      end;
  end
  else begin
    DrawRect.Left   := aRect.Left    + (WidthOf (aRect) - ThumbGlyph.Width)  div 2;
    DrawRect.Top    := aRect.Top     + (HeightOf(aRect) - ThumbGlyph.Height) div 2;
    DrawRect.Right  := DrawRect.Left + ThumbGlyph.Width;
    DrawRect.Bottom := DrawRect.Top  + ThumbGlyph.Height;
    PaintGlyph(DrawRect);
  end;
end;


procedure TsTrackBar.TBMGetThumbRect(var Message: TMessage);
var
  pR: PRect;
  Size: integer;
  M: TMessage;
begin
  M := Message;
  DefaultHandler(M);
  if FReversed then begin
    pR := Pointer(Message.LParam);
    if Orientation = trVertical then begin
      Size := HeightOf(pR^);
      pR^.Top := Height - Size - pR^.Top;
      pR^.Bottom := pR^.Top + Size;
    end
    else begin
      Size := WidthOf(pR^);
      pR^.Left := Width - Size - pR^.Left;
      pR^.Right := pR^.Left + Size;
    end;
  end;
end;


function TsTrackBar.ThumbRect: TRect;
begin
  Result := MkRect(1, 1);
  SendMessage(Handle, TBM_GETTHUMBRECT, 0, LPARAM(@Result));
  OffsetRect(Result, FBarOffset.X, FBarOffset.Y);
end;


function TsTrackBar.ChannelRect: TRect;
begin
  Result := MkRect(1, 1);
  SendMessage(Handle, TBM_GETCHANNELRECT, 0, LPARAM(@Result));
  if Orientation = trVertical then begin
    Changei(Result.Left, Result.Top);
    Changei(Result.Right, Result.Bottom);
  end;
  OffsetRect(Result, fBarOffset.X, fBarOffset.Y);
end;


function TsTrackBar.TickPos(i: integer): integer;
var
  Value: ACNativeInt;
begin
  Value := longint(i);
  Result := SendMessage(Handle, TBM_GETTICPOS, Value, 0);
end;


function TsTrackBar.TickCount: integer;
begin
  Result := SendMessage(Handle, TBM_GETNUMTICS, 0, 0);
end;


function TsTrackBar.TicksArray: TAPoint;
var
  i, w, c: integer;
  ChRect, ThRect: TRect;
begin
  Result := nil;
  ChRect := ChannelRect;
  ThRect := ThumbRect;
  c := TickCount;
  SetLength(Result, c);
  if TickStyle = tsAuto then
    if Orientation = trVertical then begin
      iStep := (HeightOf(ChRect) - HeightOf(ThRect)) / (TickCount - 1);
      w := HeightOf(ThRect) div 2;
      for i := 0 to c - 1 do
        Result[i] := Point(0, Round(ChRect.Top + i * iStep + w));
    end
    else begin
      OffsetRect(ChRect, 2, 0);
      iStep := (WidthOf(ChRect) - WidthOf(ThRect)) / (TickCount - 1);
      w := WidthOf(ThRect) div 2;
      for i := 0 to c - 1 do
        Result[i] := Point(Round(ChRect.Left + i * iStep + w), 0);
    end
  else
    if Orientation = trVertical then begin
      Result[0] := Point(0, ChRect.Top + HeightOf(ThRect) div 2);
      for i := 0 to c - 3 do
        Result[i + 1] := Point(0, TickPos(i));

      Result[c - 1] := Point(0, ChRect.Bottom - HeightOf(ThRect) div 2);
    end
    else begin
      OffsetRect(ChRect, 2, 0);
      Result[0] := Point(ChRect.Left + WidthOf(ThRect) div 2, 0);
      for i := 0 to c - 3 do
        Result[i + 1] := Point(TickPos(i), 0);

      Result[c - 1] := Point(ChRect.Right - WidthOf(ThRect) div 2, 0);
    end;
end;


procedure TsTrackBar.PaintTicksVer;
var
  dh: real;
  cr: TRect;
  pa: TAPoint;
  ArrowPoints: array of TPoint;
  i, mh, sStart, sEnd: integer;
begin
  mh := 0;
  if TickStyle <> tsNone then begin
    pa := TicksArray;
    cr := ChannelRect;
    mh := (WidthOf(ThumbRect) - WidthOf(cr)) div 2 + 2;
    if TickMarks in [tmTopLeft, tmBoth] then
      for i := 0 to High(pa) do
        if ((SelStart = 0) and (SelEnd = 0)) or ((i <> SelStart) and (i <> SelEnd)) then
          PaintTick(Point(cr.Left - mh - TickHeight, pa[i].y), False);

    if TickMarks in [tmBottomRight, tmBoth] then
      for i := 0 to High(pa) do
        if ((SelStart = 0) and (SelEnd = 0)) or ((i <> SelStart) and (i <> SelEnd)) then
          PaintTick(Point(cr.Right + mh, pa[i].y), False);
  end
  else
    pa := nil;

  if (SelStart > 0) or (SelEnd > 0) then begin
    sStart := math.max(SelStart, Min);
    sEnd := Math.min(SelEnd, Max);
    dh := (HeightOf(ChannelRect) - HeightOf(ThumbRect)) / (Max - Min);
    SetLength(ArrowPoints, 3);
    FCommonData.FCacheBmp.Canvas.Brush.Style := bsSolid;
    FCommonData.FCacheBmp.Canvas.Brush.Color := FCommonData.SkinManager.GetGlobalFontColor;
    FCommonData.FCacheBmp.Canvas.Pen.Color := FCommonData.SkinManager.GetGlobalFontColor;
    if TickMarks in [tmTopLeft, tmBoth] then begin
      // SelStart
      i := Round(dh * (sStart + 1)) + ChannelRect.Top + 4;
      ArrowPoints[0] := Point(cr.Left - mh - TickHeight, i);
      ArrowPoints[1] := Point(ArrowPoints[0].X - SelSize, ArrowPoints[0].Y - SelSize);
      ArrowPoints[2] := Point(ArrowPoints[0].X - SelSize, ArrowPoints[0].Y);
      FCommonData.FCacheBmp.Canvas.Polygon(ArrowPoints);
      // SelEnd
      i := Round(dh * (sEnd + 1)) + ChannelRect.Top + 4;
      ArrowPoints[0] := Point(cr.Left - mh - TickHeight, i);
      ArrowPoints[1] := Point(ArrowPoints[0].X - SelSize, ArrowPoints[0].Y);
      ArrowPoints[2] := Point(ArrowPoints[0].X - SelSize, ArrowPoints[0].Y + SelSize);
      FCommonData.FCacheBmp.Canvas.Polygon(ArrowPoints);
    end;
    if TickMarks in [tmBottomRight, tmBoth] then begin
      // SelStart
      i := Round(dh * (sStart + 1)) + ChannelRect.Top + 4;
      ArrowPoints[0] := Point(cr.Right + mh, i);
      ArrowPoints[1] := Point(ArrowPoints[0].X + SelSize, ArrowPoints[0].Y - SelSize);
      ArrowPoints[2] := Point(ArrowPoints[0].X + SelSize, ArrowPoints[0].Y);
      FCommonData.FCacheBmp.Canvas.Polygon(ArrowPoints);
      // SelEnd
      i := Round(dh * (sEnd + 1)) + ChannelRect.Top + 4;
      ArrowPoints[0] := Point(cr.Right + mh, i);
      ArrowPoints[1] := Point(ArrowPoints[0].X + SelSize, ArrowPoints[0].Y);
      ArrowPoints[2] := Point(ArrowPoints[0].X + SelSize, ArrowPoints[0].Y + SelSize);
      FCommonData.FCacheBmp.Canvas.Polygon(ArrowPoints);
    end
  end
end;


procedure TsTrackBar.Paint;
begin
  if not (csDestroying in ComponentState) then 
    if not FCommonData.Skinned or not (InUpdating(FCommonData) or TimerIsActive(SkinData)) then begin
      PrepareCache;
      if FCommonData.SkinIndex >= 0 then
        UpdateCorners(FCommonData, 0);

      BitBlt(Canvas.Handle, 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
    end;
end;


procedure TsTrackBar.AfterConstruction;
begin
  inherited;
  FCommonData.Loaded;
  UpdateIndexes(SkinData.SkinIndex);
end;


procedure TsTrackBar.Loaded;
begin
  inherited;
  FCommonData.Loaded;
  UpdateIndexes(SkinData.SkinIndex);
end;


procedure TsTrackBar.SetBoolean(const Index: Integer; const Value: boolean);
begin
  case Index of
    0: if FReversed <> Value then begin
      FReversed := Value;
      if FReversed then
        SetWindowLong(Handle, GWL_STYLE, GetWindowLong(Handle, GWL_STYLE) or TBS_DOWNISLEFT or TBS_REVERSED)
      else
        SetWindowLong(Handle, GWL_STYLE, GetWindowLong(Handle, GWL_STYLE) and not TBS_DOWNISLEFT and not TBS_REVERSED);

      Repaint;
    end;

    1: if FShowFocus <> Value then begin
      FShowFocus := Value;
      if FShowFocus <> Value then
        FCommonData.Invalidate;
    end;

    2: if FShowProgress <> Value then begin
      FShowProgress := Value;
      if not (csLoading in ComponentState) and SkinData.Skinned then
        SkinData.Invalidate
    end;
  end;
end;


procedure TsTrackBar.SetDisabledKind(const Value: TsDisabledKind);
begin
  if FDisabledKind <> Value then begin
    FDisabledKind := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsTrackBar.SetHBarOffset(const Value: Integer);
begin
  if FBarOffset.X <> Value then begin
    FBarOffset.X := Value;
    Repaint;
  end;
end;


procedure TsTrackBar.SetVBarOffset(const Value: Integer);
begin
  if FBarOffset.Y <> Value then begin
    FBarOffset.Y := Value;
    Repaint;
  end;
end;


procedure TsTrackBar.StdPaintBar(Bmp: TBitmap);
var
  i, j, d, pos: integer;
  aRect, sRect: TRect;
{$IFDEF DELPHI7UP}
  Details: TThemedElementDetails;
  te: TThemedTrackBar;
{$ENDIF}
begin
  aRect := ChannelRect;
{$IFDEF DELPHI7UP}
  if acThemesEnabled then begin
    if Orientation = trVertical then
      te := ttbTrack
    else
      te := ttbTrackVert;

    Details := acThemeServices.GetElementDetails(te);
    acThemeServices.DrawElement(Bmp.Canvas.Handle, Details, aRect);
    InflateRect(aRect, -1, -1);
  end
  else
{$ENDIF}
  begin
    Frame3D(Bmp.Canvas, aRect, clBtnShadow, clBtnHighlight, 1);
    Frame3D(Bmp.Canvas, aRect, cl3DDkShadow, cl3DLight, 1);
    FillDC(Bmp.Canvas.Handle, aRect, clWindow);
  end;
  if ShowProgress then begin
    sRect := aRect;
    pos := SendMessage(Handle, TBM_GETPOS, 0, 0);
    d := math.Max(0, ShowProgressFrom - Min);
    if Orientation = trVertical then begin
      if Max = Min then begin
        i := pos - Min;
        j := d;
      end
      else begin
        i := Round(HeightOf(aRect) * (pos - Min) / (Max - Min));
        j := Round(HeightOf(aRect) * d / (Max - Min));
      end;
      if Reversed then
        if (pos < ShowProgressFrom) then begin
          sRect.Top := sRect.Bottom - j;
          sRect.Bottom := sRect.Bottom - i;
        end
        else begin
          sRect.Top := sRect.Bottom - i;
          sRect.Bottom := sRect.Bottom - j;
        end
      else
        if (pos < ShowProgressFrom) then begin
          sRect.Bottom := sRect.Top + j;
          sRect.Top := sRect.Top + i;
        end
        else begin
          sRect.Bottom := sRect.Top + i;
          sRect.Top := sRect.Top + j;
        end;
    end
    else begin
      if Max = Min then begin
        i := pos - Min;
        j := d;
      end
      else begin
        i := Round(WidthOf(aRect) * (pos - Min) / (Max - Min));
        j := Round(WidthOf(aRect) * d / (Max - Min));
      end;
      if Reversed then
        if (pos < ShowProgressFrom) then begin
          sRect.Left := sRect.Right - j;
          sRect.Right := sRect.Right - i;
        end
        else begin
          sRect.Left := sRect.Right - i;
          sRect.Right := sRect.Right - j;
        end
      else
        if (pos < ShowProgressFrom) then begin
          sRect.Right := sRect.Left + j;
          sRect.Left := sRect.Left + i;
        end
        else begin
          sRect.Right := sRect.Left + i;
          sRect.Left := sRect.Left + j;
        end;
    end;
    FillRect32(Bmp, sRect, ColorToRGB(clHighLight));
  end;
  if Orientation = trHorizontal then
    PaintTicksHor
  else
    PaintTicksVer;
end;


procedure TsTrackBar.StdPaintBG(Bmp: TBitmap);
{$IFDEF DELPHI7UP}
var
  Details: TThemedElementDetails;
{$ENDIF}
begin
{$IFDEF DELPHI7UP}
  if acThemesEnabled then begin
    FillDC(Bmp.Canvas.Handle, MkRect(Bmp), clBtnFace);
    Details := acThemeServices.GetElementDetails(ttBody);
    acThemeServices.DrawParentBackground(Handle, Bmp.Canvas.Handle, @Details, False);
  end
  else
{$ENDIF}
    FillDC(Bmp.Canvas.Handle, MkRect(Bmp), clBtnFace);
end;


const
  ProgArray:  array [boolean] of string = (s_ProgVert, s_ProgHorz);
  ThickArray: array [boolean] of string = (s_TickVert, s_TickHorz);

procedure TsTrackBar.UpdateIndexes(MainNdx: integer);
var
  Horz: boolean;
begin
  Horz := Orientation = trHorizontal;
  if MainNdx >= 0 then
    with SkinData.SkinManager do begin
      FTickNdx     := GetMaskIndex(MainNdx, ThickArray[Horz]);
      FProgressNdx := GetMaskIndex(MainNdx, ProgArray[Horz]);
      FSliderNdx   := GetMaskIndex(MainNdx, s_SliderChannelMask);

      if not Horz then
        FThumbNdx := GetMaskIndex(MainNdx, s_SliderVertMask)
      else
        FThumbNdx := -1;

      if FThumbNdx = -1 then
        FThumbNdx := GetMaskIndex(MainNdx, s_SliderHorzMask);
    end
  else begin
    FTickNdx     := -1;
    FProgressNdx := -1;
    FSliderNdx   := -1;
    FThumbNdx    := -1;
  end;
end;


procedure TsTrackBar.UserChanged(Finished: boolean);
begin
  if Assigned(FOnUserChange) then
    FOnUserChange(Self);

  if Finished and Assigned(FOnUserChanged) then
    FOnUserChanged(Self);
end;


procedure TsTrackBar.PaintWindow(DC: HDC);
begin
  if not TimerIsActive(SkinData) then begin
    FCanvas.Lock;
    if SkinData.PrintDC <> 0 then
      FCanvas.Handle := SkinData.PrintDC
    else
      FCanvas.Handle := GetWindowDC(Handle);

    try
      TControlCanvas(FCanvas).UpdateTextFlags;
      Paint;
    finally
      if SkinData.PrintDC = 0 then
        ReleaseDC(Handle, FCanvas.Handle);

      FCanvas.Handle := 0;
      FCanvas.Unlock;
    end;
  end;
end;


procedure TsTrackBar.PrepareCache;
var
  CI: TCacheInfo;
begin
  InitCacheBmp(SkinData);
  PaintBody;
  if (SkinData.SkinIndex >= 0) and not Enabled then begin
    CI := GetParentCache(FCommonData);
    BmpDisabledKind(FCommonData.FCacheBmp, FDisabledKind, Parent, CI, Point(Left, Top));
  end;
end;


procedure TsTrackBar.PaintTick(P: TPoint; Horz: boolean);
var
  w: integer;
  R: TRect;
begin
  if SkinData.SkinIndex >= 0 then
    with SkinData.SkinManager do begin
      if FTickNdx <> -1 then begin
        if Horz then
          dec(P.x, WidthOfImage (ma[FTickNdx]))
        else
          dec(P.y, HeightOfImage(ma[FTickNdx]));

        DrawSkinGlyph(SkinData.FCacheBmp, P, Mode, 1, ma[FTickNdx], MakeCacheInfo(FCommonData.FCacheBmp))
      end
      else begin
        if Horz then
          R := Rect(P.x, P.y, P.x + 2, P.Y + TickHeight)
        else
          R := Rect(P.x, P.y, P.x + TickHeight, P.Y + 2);

        w := 1;
        DrawRectangleOnDC(FCommonData.FCacheBmp.Canvas.Handle, R, ColorToRGB(clBtnShadow), ColorToRGB(clWhite), w);
      end;
    end
  else begin
    if Horz then
      R := Rect(P.x, P.y, P.x + 1, P.Y + 3)
    else
      R := Rect(P.x, P.y, P.x + 3, P.Y + 1);

    FillDC(FCommonData.FCacheBmp.Canvas.Handle, R, clBtnShadow);
  end;
end;


function TsTrackBar.Mode: integer;
begin
  if (csLButtonDown in ControlState) then
    Result := 2
  else
    Result := integer(ControlIsActive(FCommonData));
end;


procedure TsTrackBar.SetThumbGlyph(const Value: TBitmap);
begin
  FThumbGlyph.Assign(Value);
  if not (csLoading in ComponentState) and SkinData.Skinned then
    SkinData.Invalidate
end;


procedure TsTrackBar.PaintProgress(R: TRect; Horz: boolean);
var
  CI: TCacheInfo;
begin
  with SkinData.SkinManager do begin
    CI := MakeCacheInfo(FCommonData.FCacheBmp);
    if IsValidImgIndex(FProgressNdx) then
      DrawSkinRect(FCommonData.FCacheBmp, R, CI, ma[FProgressNdx], integer(ControlIsActive(FCommonData)), True);
  end;
end;


procedure TsTrackBar.StdPaintThumb(i: integer);
{$IFDEF DELPHI7UP}
const
  ThumbStyles: array [boolean, TTickMark, 0..2] of TThemedTrackBar =
   (((ttbThumbBottomNormal, ttbThumbBottomHot, ttbThumbBottomPressed),
     (ttbThumbTopNormal,    ttbThumbTopHot,    ttbThumbTopPressed),
     (ttbThumbNormal,       ttbThumbHot,       ttbThumbPressed)),

    ((ttbThumbRightNormal, ttbThumbRightHot, ttbThumbRightPressed),
     (ttbThumbLeftNormal, ttbThumbLeftHot, ttbThumbLeftPressed),
     (ttbThumbVertNormal, ttbThumbVertHot, ttbThumbVertPressed)));
{$ENDIF}
var
  Bmp: TBitmap;
  GlyphSize: TSize;
  DrawPoint: TPoint;
  Stretched: boolean;
  aRect, DrawRect: TRect;
{$IFDEF DELPHI7UP}
  Details: TThemedElementDetails;
  te: TThemedTrackBar;
{$ENDIF}

  function PrepareBG: TRect;
  var
    TmpBmp: TBitmap;
  begin
    if Stretched or (TickMarks = tmTopLeft) then begin
      Bmp := CreateBmp32(GlyphSize);
      Result := MkRect(GlyphSize);
      TmpBmp := CreateBmp32(aRect);
      BitBlt(TmpBmp.Canvas.Handle, 0, 0, TmpBmp.Width, TmpBmp.Height, FCommonData.FCacheBmp.Canvas.Handle, aRect.Left, aRect.Top, SRCCOPY);
      Stretch(TmpBmp, Bmp, Bmp.Width, Bmp.Height, ftMitchell);
      if TickMarks = tmTopLeft then
        RotateBmp180(Bmp, Orientation <> trHorizontal);

      FreeAndNil(TmpBmp);
    end
    else begin
      Bmp := FCommonData.FCacheBmp;
      Result := aRect;
    end;
  end;

  procedure ReturnToCache;
  var
    TmpBmp: TBitmap;
  begin
    if FCommonData.FCacheBmp <> Bmp then begin
      if TickMarks = tmTopLeft then
        RotateBmp180(Bmp, Orientation <> trHorizontal);

      TmpBmp := CreateBmp32(aRect);
      Stretch(Bmp, TmpBmp, TmpBmp.Width, TmpBmp.Height, ftMitchell);
      BitBlt(FCommonData.FCacheBmp.Canvas.Handle, aRect.Left, aRect.Top, WidthOf(aRect), HeightOf(aRect), TmpBmp.Canvas.Handle, 0, 0, SRCCOPY);
      FreeAndNil(TmpBmp);
    end
  end;

  procedure PaintGlyph(R: TRect);
  var
    b: boolean;
    S0, S: PRGBAArray;
    Y, X, DeltaS: integer;
  begin
    if ThumbGlyph.PixelFormat = pfDevice then begin
      ThumbGlyph.HandleType := bmDIB;
      if (ThumbGlyph.Handle <> 0) and (ThumbGlyph.PixelFormat = pf32bit) then begin // Checking for an empty alpha-channel
        b := False;
        if InitLine(ThumbGlyph, Pointer(S0), DeltaS) then
          for Y := 0 to ThumbGlyph.Height - 1 do begin
            S := Pointer(LongInt(S0) + DeltaS * Y);
            for X := 0 to ThumbGlyph.Width - 1 do
              if S[X].A = MaxByte then begin
                b := True;
                Break;
              end;

            if b then
              Break;
          end;
          
        if not b then
          ThumbGlyph.PixelFormat := pf24bit;
      end;
    end;
    if (ThumbGlyph.PixelFormat = pf32bit) then  // Patch if Png, don't work in std. mode
      CopyBmp32(R, MkRect(ThumbGlyph), FCommonData.FCacheBmp, ThumbGlyph, EmptyCI, False, clNone, 0, False)
    else
      BitBlt(FCommonData.FCacheBmp.Canvas.Handle, R.Left, R.Top, ThumbGlyph.Width, ThumbGlyph.Height, ThumbGlyph.Canvas.Handle, 0, 0, SRCCOPY);
  end;

begin
  aRect := ThumbRect;
  if ThumbGlyph.Empty then begin
    with SkinData.SkinManager do begin
      GlyphSize := MkSize(aRect);
      if (Orientation = trHorizontal) and (HeightOf(aRect) = iThumbSize) or (Orientation = trVertical) and (WidthOf(aRect) = iThumbSize) then
        Stretched := False
      else
        Stretched := (HeightOf(aRect) <> GlyphSize.cy) or (WidthOf(aRect) <> GlyphSize.cx);

      DrawRect := PrepareBG;
      DrawPoint := Point(DrawRect.Left + (WidthOf(DrawRect) - GlyphSize.cx) div 2, DrawRect.Top + (HeightOf(DrawRect) - GlyphSize.cy) div 2);

{$IFDEF DELPHI7UP}
      if acThemesEnabled then begin
        te := ThumbStyles[Orientation = trVertical, TickMarks, Mode];
        Details := acThemeServices.GetElementDetails(te);
        acThemeServices.DrawElement(Bmp.Canvas.Handle, Details, DrawRect);
      end
      else
{$ENDIF}
      begin
        dec(aRect.Bottom);
        Frame3D(Bmp.Canvas, aRect, cl3DLight, cl3DDkShadow, 1);
        Frame3D(Bmp.Canvas, aRect, clWhite, clBtnShadow, 1);
        FillDC(Bmp.Canvas.Handle, aRect, clBtnFace);
      end;
      ReturnToCache;
      if Bmp <> FCommonData.FCacheBmp then
        FreeAndNil(Bmp);
    end
  end
  else begin
    DrawRect.Left   := aRect.Left    + (WidthOf (aRect) - ThumbGlyph.Width)  div 2;
    DrawRect.Top    := aRect.Top     + (HeightOf(aRect) - ThumbGlyph.Height) div 2;
    DrawRect.Right  := DrawRect.Left + ThumbGlyph.Width;
    DrawRect.Bottom := DrawRect.Top  + ThumbGlyph.Height;
    PaintGlyph(DrawRect);
  end;
end;


procedure TsTrackBar.SetShowProgressFrom(const Value: Integer);
begin
  if FShowProgressFrom <> Value then begin
    FShowProgressFrom := Value;
    if FShowProgressFrom < Min then
      FShowProgressFrom := Min;

    if FShowProgressFrom > Max then
      FShowProgressFrom := Max;
      
    if not (csLoading in ComponentState) and SkinData.Skinned then
      SkinData.Invalidate
  end;
end;


procedure TsTrackBar.CreateWnd;
begin
  inherited;
  DoubleBuffered := False;
end;

end.

