unit sSplitter;
{$I sDefs.inc}
//{$DEFINE LOGGED}
//+
interface


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Extctrls,
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  sCommonData;


type
{$IFNDEF NOTFORHELP}
  TacSplitterState = (ssOpened, ssClosed);
{$ENDIF} // NOTFORHELP

{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsSplitter = class(TSplitter)
{$IFNDEF NOTFORHELP}
  private
    FOnMouseLeave,
    FOnMouseEnter: TNotifyEvent;

    FSizing,
    Pressed,
    FShowGrip,
    FSizingByClick: boolean;

    PrevSize,
    FGripState,
    FOldCursor: TCursor;

    FGlyph: TBitmap;
    FCommonData: TsCommonData;
    FSplitterState: TacSplitterState;
    procedure SetGlyph        (const Value: TBitmap);
    procedure SetShowGrip     (const Value: boolean);
    procedure SetSizingByClick(const Value: boolean);
    procedure SetSplitterState(const Value: TacSplitterState);
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
  protected
    function GripRect(Btn: boolean): TRect;
    procedure PrepareCache;
    procedure Paint; override;
    procedure FillGripColor(Canvas: TCanvas; R: TRect);
    procedure WndProc(var Message: TMessage); override;
    procedure MouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure SetGripState(AValue: integer);
    function FindControl: TControl;
  public
    constructor Create(AOwner: TComponent); override;
    procedure AfterConstruction; override;
    destructor Destroy; override;
    procedure Loaded; override;
    property State: TacSplitterState read FSplitterState write SetSplitterState default ssOpened;
  published
    property Enabled;
    property Color;
    property Glyph: TBitmap read FGlyph write SetGlyph;
    property ParentColor;
    property Hint;
    property ParentShowHint;
    property ResizeStyle default rsUpdate;
    property SizingByClick: boolean read FSizingByClick write SetSizingByClick default False;
    property ShowGrip: boolean read FShowGrip write SetShowGrip default False;
    property ShowHint;
    property Visible;
    property Width default 6;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property OnMouseUp;
    property OnResize;
{$ENDIF} // NOTFORHELP
    property SkinData: TsCommonData read FCommonData write FCommonData;
  end;


implementation

uses
  math,
  sConst, sVclUtils, sMaskData, sMessages, sStyleSimply, sGraphUtils, acntUtils, sSkinManager,
  sFade, sAlphaGraph, sSkinProps, acGlow;


const
  DefGripHeight = 4;
  DefGripWidth = 21;
  Directions: array [boolean, alTop..alRight] of TacSide = ((asTop, asBottom, asLeft, asRight), (asBottom, asTop, asRight, asLeft));

type
  TAccessSplitter = class(TGraphicControl)
  public
    FActiveControl: TWinControl;
    FAutoSnap,
    FBeveled: Boolean;
    FBrush: TBrush;
    FControl: TControl;
    FDownPos: TPoint;
    FLineDC: HDC;
    FLineVisible: Boolean;
    FMinSize: NaturalNumber;
    FMaxSize,
    FNewSize: Integer;
  end;


procedure TsSplitter.AfterConstruction;
begin
  inherited;
  SkinData.Loaded;
end;


constructor TsSplitter.Create(AOwner: TComponent);
begin
  FCommonData := TsCommonData.Create(Self, False);
  FCommonData.COC := COC_TsSplitter;
  inherited Create(AOwner);
  FGlyph := TBitmap.Create;
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents, csOpaque, csDoubleClicks];
  ResizeStyle := rsUpdate;
  FSizingByClick := False;
  FOldCursor := crDefault;
  PrevSize := 0;
  Width := 6;
  Pressed := False;
  FSizing := False;
  FShowGrip := False;
end;


destructor TsSplitter.Destroy;
begin
  FreeAndNil(FCommonData);
  if Assigned(FGlyph) then
    FreeAndNil(FGlyph);

  inherited Destroy;
end;


procedure TsSplitter.FillGripColor(Canvas: TCanvas; R: TRect);
var
  x, y: integer;
  C, ColorLight, ColorDark: TColor;
begin
  if SkinData.SkinManager <> nil then
  	C := SkinData.SkinManager.GetGlobalColor
  else
    C := Color;

  ColorLight := BlendColors(C, $FFFFFF, 127);
  ColorDark := BlendColors(C, 0, 127);
  y := R.Top;
  while y < R.Bottom do begin
    x := R.Left;
    while x < R.Right do begin
      Canvas.Pixels[x, y] := ColorLight;
      Canvas.Pixels[x + 1, y + 1] := ColorDark;
      inc(x, 2);
    end;
    inc(y, 2);
  end;
end;


function TsSplitter.FindControl: TControl;
var
  EmptyControl: TControl;
  P: TPoint;
  I: Integer;
  R: TRect;
begin
  P := Point(Left, Top);
  EmptyControl := nil;
  case Align of
{$IFDEF D2006}
    alLeft:   Dec(P.X, iff(AlignWithMargins, Margins.Left   + 1,          1));
    alRight:  Inc(P.X, iff(AlignWithMargins, Margins.Right  + 1 + Width,  Width + 1));
    alTop:    Dec(P.Y, iff(AlignWithMargins, Margins.Top    + 1,          1));
    alBottom: Inc(P.Y, iff(AlignWithMargins, Margins.Bottom + 1 + Height, Height + 1))
{$ELSE}
    alLeft:   Dec(P.X);
    alRight:  Inc(P.X, Width);
    alTop:    Dec(P.Y);
    alBottom: Inc(P.Y, Height);
{$ENDIF}
    else begin
      Result := nil;
      Exit;
    end;
  end;
  for I := 0 to Parent.ControlCount - 1 do begin
    Result := Parent.Controls[I];
    if Result.Visible and Result.Enabled and (Result <> Self) then begin
      R := Result.BoundsRect;
{$IFDEF D2006}
      if Result.AlignWithMargins then begin
        Inc(R.Right,  Result.Margins.Right);
        Dec(R.Left,   Result.Margins.Left);
        Inc(R.Bottom, Result.Margins.Bottom);
        Dec(R.Top,    Result.Margins.Top);
      end;
{$ENDIF}
      if R.Right - R.Left = 0 then begin
        if Result.Align in [alTop, alLeft] then
          Dec(R.Left)
        else
          Inc(R.Right);
      end;

      if R.Bottom - R.Top = 0 then begin
        if Result.Align in [alTop, alLeft] then
          Dec(R.Top)
        else begin
          dec(R.Right);
          dec(R.Bottom);
        end;

        if PtInRect(BoundsRect, R.TopLeft) or PtInRect(BoundsRect, R.BottomRight) then
          EmptyControl := Result;
      end;

      if PtInRect(R, P) then
        Exit;
    end;
  end;
  Result := EmptyControl;
  if EmptyControl <> nil then // Bugfix for situation when coords of cntrol are changed by VCL
    case EmptyControl.Align of
      alLeft:   begin
        EmptyControl.Left := Left - 1;
        Left := Left + 1;
      end;
      alTop:    begin
        EmptyControl.Top  := Top - 1;
        Top := Top + 1;
      end;
      alRight:
        EmptyControl.Left := Left + Width + 1;

      alBottom:
        EmptyControl.Top  := Top + Height + 1;
    end;
end;


function TsSplitter.GripRect(Btn: boolean): TRect;
begin
  if Align in [alLeft, alRight] then begin
    Result.Left   := iff(Btn, 0, (Width - DefGripHeight) div 2);
    Result.Top    := (Height - Height div 3) div 2;
    Result.Right  := Result.Left + iff(Btn, Width, DefGripHeight);
    Result.Bottom := Result.Top + Height div 3;
  end
  else begin
    Result.Left   := (Width - Width div 3) div 2;
    Result.Top    := iff(Btn, 0, (Height - DefGripHeight) div 2);
    Result.Right  := Result.Left + Width div 3;
    Result.Bottom := Result.Top + iff(Btn, Height, DefGripHeight);
  end;
end;


procedure TsSplitter.Loaded;
begin
  inherited Loaded;
  SkinData.Loaded;
end;


type
  TWinControlAccess = class(TWinControl);


procedure TsSplitter.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i: integer;
begin
  StopTimer(SkinData);
  TAccessSplitter(Self).FControl := FindControl;
  if FSizingByClick then
    if PtInRect(GripRect(True), Point(X, Y)) then begin
      Pressed := True;
      SetGripState(2);
    end;

  if not ShowHintStored then begin
    AppShowHint := Application.ShowHint;
    Application.ShowHint := False;
    ShowHintStored := True;
  end;
  if AutoSnap and (Parent <> nil) then  // Hack for standard bug with Realign procedure removing
    for i := 0 to Parent.ControlCount - 1 do
      case Parent.Controls[i].Align of
        alLeft:
          if Parent.Controls[i].Width = 0 then
            Parent.Controls[i].Left := Left;

        alTop:
          if Parent.Controls[i].Height = 0 then
            Parent.Controls[i].Top := Top;

        alBottom:
          if Parent.Controls[i].Height = 0 then
            Parent.Controls[i].Top := Top + Height;
      end;

  if not FSizingByClick or Pressed then begin
    if TAccessSplitter(Self).FActiveControl <> nil then begin
      TWinControlAccess(TAccessSplitter(Self).FActiveControl).OnKeyDown := nil;
      TAccessSplitter(Self).FActiveControl := nil; // Do not touch the OnKeyDown event in inherited MouseUp
    end;
    inherited;
  end;

  if (FGripState <> 0) or not FSizingByClick then begin
    FSizing := True;
    if ResizeStyle = rsUpdate then
      Repaint;
  end;
end;


procedure TsSplitter.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  OldState: integer;
begin
  if Pressed and ((TAccessSplitter(Self).FDownPos.X <> X) or (TAccessSplitter(Self).FDownPos.Y <> Y)) then
    Pressed := False;

  OldState := FGripState;
  if SizingByClick and ShowGrip then
    if PtInRect(GripRect(SizingByClick), Point(X, Y)) then begin
      if FOldCursor = crDefault then
        FOldCursor := Cursor;

      Cursor := crArrow;
      FGripState := integer(Pressed) + 1;
      if OldState <> FGripState then begin
        FCommonData.BGChanged := False;
        DoChangePaint(FCommonData, 105, UpdateGraphic_CB, True, False);
      end;
    end
    else begin
      if (Cursor = crDefault) or (Cursor = crArrow) then
        if FOldCursor <> crDefault then
          Cursor := FOldCursor
        else
          if Align in [alBottom, alTop] then
            Cursor := crVSplit
          else
            Cursor := crHSplit;

      FGripState := 0;
      if OldState <> FGripState then begin
        FCommonData.BGChanged := False;
        DoChangePaint(FCommonData, 104, UpdateGraphic_CB, True, False);
      end;
    end
  else
    inherited;
end;


procedure TsSplitter.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i, j: integer;
begin
  if SizingByClick and Pressed then
    with TAccessSplitter(Self) do begin
      TAccessSplitter(Self).FControl := FindControl;
      if TAccessSplitter(Self).FControl <> nil then begin
        if PrevSize = 0 then begin
          j := iff(Align in [alLeft, alRight], FControl.Width, FControl.Height);
          i := 0;
        end
        else begin
          i := PrevSize;
          j := 0;
        end;
        if Self.CanResize(i) then begin
          PrevSize := j;
          TAccessSplitter(Self).FNewSize := i;
          if i <> 0 then
            FSplitterState := ssOpened;
        end;
        SetGripState(0);
      end;
    end;

  if not SizingByClick or Pressed then begin
    Pressed := False;
    inherited MouseUp(Button, Shift, X, Y);
    FSizing := False;
    if ResizeStyle = rsUpdate then
      Repaint;
  end;
  Application.ShowHint := AppShowHint;
  ShowHintStored := False;
end;


procedure TsSplitter.Paint;
const
  XorColor = $00FFD8CE;
var
  R: TRect;
  C: TColor;
  TmpBmp: TBitmap;
begin
  if not FCommonData.Skinned then begin
    inherited;
    if not FGlyph.Empty then begin
      R.Top := (Height - FGlyph.Height) div 2;
      R.Left := (Width - FGlyph.Width) div 2;
      if FGlyph.PixelFormat = pf32bit then begin
        TmpBmp := CreateBmp32(FGlyph);
        BitBlt(TmpBmp.Canvas.Handle, 0, 0, TmpBmp.Width, TmpBmp.Height, Canvas.Handle, R.Left, R.Top, SRCCOPY);
        CopyByMask(MkRect(FGlyph), MkRect(FGlyph), TmpBmp, FGlyph, EmptyCI, False);
        BitBlt(Canvas.Handle, R.Left, R.Top, TmpBmp.Width, TmpBmp.Height, TmpBmp.Canvas.Handle, 0, 0, SRCCOPY);
        FreeAndNil(TmpBmp);
      end
      else begin
        FGlyph.Transparent := True;
        Canvas.Draw(R.Left, R.Top, FGlyph);
      end;
    end
    else
      if FShowGrip then // Grip paint
        if SizingByClick then begin
          case FGripState of
            0:   C := clScrollBar;
            2:   C := clGray
            else C := BlendColors(ColorToRGB(clScrollBar), $FFFFFF, 180);
          end;
          FillDC(Canvas.Handle, GripRect(True), C);
          DrawColorArrow(Canvas, clBtnText, GripRect(True), Directions[PrevSize <> 0, Align]);
        end
        else
          FillGripColor(Canvas, GripRect(False));
  end
  else
    if TimerIsActive(SkinData) then
      with SkinData.AnimTimer do begin
        if Assigned(BmpOut) and (BmpOut.Width = Width) then
          BitBlt(Canvas.Handle, 0, 0, Width, Height, BmpOut.Canvas.Handle, 0, 0, SRCCOPY);
      end
    else begin
      PrepareCache;
      BitBlt(Canvas.Handle, 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
      if csDesigning in ComponentState then
        with Canvas do begin
          Pen.Style := psDot;
          Pen.Mode := pmXor;
          Pen.Color := XorColor;
          Brush.Style := bsClear;
          Rectangle(0, 0, ClientWidth, ClientHeight);
        end;

      if Assigned(OnPaint) then
        OnPaint(Self);
    end;
end;


procedure TsSplitter.PrepareCache;
var
  R: TRect;
  C: TColor;
  TmpBmp: TBitmap;
  GripPos: TPoint;
  ParentBG: TacBGInfo;
  Ndx, AState: integer;
begin
  R := ClientRect;
  InitCacheBmp(SkinData);
  if not SizingByClick then begin
    AState := integer(ControlIsActive(FCommonData));
    if FSizing and (ResizeStyle = rsUpdate) then
      AState := 2;
  end
  else
    AState := 0;

  ParentBG.PleaseDraw := False;
  GetBGInfo(@ParentBG, Parent);
  PaintItem(FCommonData, BGInfoToCI(@ParentBG), True, AState, R, Point(Left, Top), FCommonData.FCacheBmp, True);
  if not FGlyph.Empty then begin
    R.TopLeft := Point((Width - FGlyph.Width) div 2, (Height - FGlyph.Height) div 2);
    if FGlyph.PixelFormat = pf32bit then
      CopyByMask(Rect(R.Left, R.Top, R.Left + FGlyph.Width, R.Top + FGlyph.Height),MkRect(FGlyph), FCommonData.FCacheBmp, FGlyph, EmptyCI, False)
    else begin
      FGlyph.Transparent := True;
      FCommonData.FCacheBmp.Canvas.Draw(R.Left, R.Top, FGlyph);
    end;
  end
  else
    if FShowGrip then
      with SkinData.SkinManager do // Grip paint
        if SizingByClick then begin
          R := GripRect(True);
          if ConstData.Sections[ssSpeedButton] >= 0 then begin
            TmpBmp := CreateBmp32(R);
            PaintItem(ConstData.Sections[ssSpeedButton], MakeCacheInfo(FCommonData.FCacheBmp), True, FGripState, MkRect(TmpBmp), R.TopLeft, TmpBmp, FCommonData.SkinManager);
            BitBlt(FCommonData.FCacheBmp.Canvas.Handle, R.Left, R.Top, TmpBmp.Width, TmpBmp.Height, TmpBmp.Canvas.Handle, 0, 0, SRCCOPY);
            FreeAndNil(TmpBmp);
            C := gd[ConstData.Sections[ssSpeedButton]].Props[min(FGripState, ac_MaxPropsIndex)].FontColor.Color;
          end
          else
            C := 0;

          if NeedParentFont(SkinData.SkinManager, ConstData.Sections[ssSpeedButton], FGripState) then begin
            Ndx := GetFontIndex(Parent, ConstData.Sections[ssSpeedButton], SkinData.SkinManager, FGripState);
            C := gd[Ndx].Props[min(FGripState, ac_MaxPropsIndex)].FontColor.Color;
          end;
          if Align in [alTop..alRight] then
            DrawColorArrow(FCommonData.FCacheBmp, C, GripRect(True), Directions[PrevSize <> 0, Align]);
        end
        else begin
          Ndx := iff(Align in [alLeft, alRight], ConstData.GripVertical, ConstData.GripHorizontal);
          if Ndx >= 0 then begin
            GripPos.X := (Width  - SkinData.SkinManager.ma[Ndx].Width) div 2;
            GripPos.Y := (Height - SkinData.SkinManager.ma[Ndx].Height) div 2;
            DrawSkinGlyph(FCommonData.FCacheBmp, GripPos, AState, 1, FCommonData.SkinManager.ma[Ndx], MakeCacheInfo(FCommonData.FCacheBmp));
          end
          else
            FillGripColor(FCommonData.FCacheBmp.Canvas, GripRect(False));
        end;

  SkinData.BGChanged := False;
end;


procedure TsSplitter.SetGlyph(const Value: TBitmap);
begin
  FGlyph.Assign(Value);
  Repaint;
end;


procedure TsSplitter.SetGripState(AValue: integer);
begin
  if FGripState <> AValue then begin
    FGripState := AValue;
    SkinData.BGChanged := True;
    Repaint;
  end;
end;


procedure TsSplitter.SetShowGrip(const Value: boolean);
begin
  FShowGrip := Value;
  Repaint;
end;


procedure TsSplitter.SetSizingByClick(const Value: boolean);
begin
  if FSizingByClick <> Value then begin
    FSizingByClick := Value;
    if not (csLoading in ComponentState) then
      SkinData.Invalidate;
  end;
end;


procedure TsSplitter.SetSplitterState(const Value: TacSplitterState);
var
  i: integer;
begin
  if FSplitterState <> Value then begin
    FSplitterState := Value;
    if not (csLoading in ComponentState) then begin
      FSizing := True;
      with TAccessSplitter(Self) do begin
        FControl := FindControl;
        if FSplitterState = ssClosed then begin
          if FControl <> nil then
            PrevSize := iff(Align in [alLeft, alRight], FControl.Width, FControl.Height)
          else
            PrevSize := Minsize;

          i := 0;
        end
        else begin
          i := PrevSize;
          PrevSize := 0;
        end;
        FNewSize := i;
        SetGripState(0);
      end;
      if TAccessSplitter(Self).FActiveControl <> nil then begin
        TWinControlAccess(TAccessSplitter(Self).FActiveControl).OnKeyDown := nil;
        TAccessSplitter(Self).FActiveControl := nil; // Do not touch the OnKeyDown event in inherited MouseUp
      end;
      inherited MouseUp(mbLeft, [], 0, 0);
      FSizing := False;
      Repaint;
    end;
  end;
end;


procedure TsSplitter.WMSetCursor(var Message: TWMSetCursor);
begin
//
end;


procedure TsSplitter.WndProc(var Message: TMessage);
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

      AC_SETNEWSKIN, AC_REMOVESKIN, AC_REFRESH:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          CommonWndProc(Message, FCommonData);
          if Message.WParamHi <> AC_SETNEWSKIN then
            Repaint;

          Exit;
        end;

      AC_INVALIDATE:
        Repaint;

      AC_PREPARECACHE: begin
        PrepareCache;
        Exit;
      end;

      AC_GETDEFINDEX: begin
        if FCommonData.SkinManager <> nil then
          Message.Result := FCommonData.SkinManager.ConstData.Sections[ssSplitter] + 1;

        Exit;
      end;
    end;

  if not ControlIsReady(Self) or not FCommonData.Skinned then begin
    case Message.Msg of
      CM_MOUSEENTER:
        if Assigned(FOnMouseEnter) then
          FOnMouseEnter(Self);
    end;
    inherited;
    case Message.Msg of
      CM_MOUSELEAVE: begin
        SetGripState(0);
        if Assigned(FOnMouseLeave) then
          FOnMouseLeave(Self);
      end;
    end;
  end
  else begin
    case Message.Msg of
      SM_ALPHACMD:
        case Message.WParamHi of
          AC_ENDPARENTUPDATE:
            if FCommonData.Updating then begin
              FCommonData.Updating := False;
              Perform(WM_PAINT, 0, 0);
              Exit;
            end
          else
            if CommonMessage(Message, SkinData) then
              Exit;
        end;

      WM_WINDOWPOSCHANGING, WM_WINDOWPOSCHANGED: begin
        FCommonData.BGChanged := True;
        HideGlow(SkinData.GlowID);
      end;

      WM_NCPAINT, WM_ERASEBKGND: begin
        Message.Result := 1;
        Exit;
      end;

      CM_VISIBLECHANGED, WM_SIZE, CM_ENABLEDCHANGED, WM_MOUSEWHEEL, WM_MOVE:
        FCommonData.BGChanged := True;

      CM_MOUSEENTER:
        if Assigned(FOnMouseEnter) then
          FOnMouseEnter(Self);
    end;
    CommonWndProc(Message, FCommonData);
    inherited;
    case Message.Msg of
      WM_SETFOCUS, CM_ENTER, WM_KILLFOCUS, CM_EXIT: begin
        FCommonData.FFocused := (Message.Msg = WM_SETFOCUS) or (Message.Msg = CM_ENTER);
        FCommonData.FMouseAbove := False;
        FCommonData.BGChanged := True;
        Repaint;
      end;

      CM_MOUSELEAVE, CM_MOUSEENTER: begin
        if not FCommonData.FFocused and not (csDesigning in ComponentState) then begin
          FCommonData.FMouseAbove := Message.Msg = CM_MOUSEENTER;
          SetGripState(0);
          if FCommonData.BGChanged then
            PrepareCache;

          if not FCommonData.FMouseAbove or not SizingByClick then
            DoChangePaint(FCommonData, integer(FCommonData.FMouseAbove), UpdateGraphic_CB, True, False);
        end;
        if (CM_MOUSELEAVE = Message.Msg) and Assigned(FOnMouseLeave) then
          FOnMouseLeave(Self);
      end;
    end;
  end;
end;

end.
