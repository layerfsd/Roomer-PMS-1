unit acGlow;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  Windows, Controls, Classes, Forms, SysUtils, Graphics, Messages,
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  acntTypes, sSkinManager, sCommonData;


function ShowGlow(const RealRect: TRect; const SkinSection, Name: string; const Margin, Alpha: integer; WndHandle: HWND; SkinData: TsCommonData = nil): integer; overload;
function ShowGlow(const RealRect: TRect; MaskIndexes: array of integer; const Margin, Alpha: integer; WndHandle: HWND; SkinData: TsCommonData = nil): integer; overload;
procedure HideGlow(var ID: integer; DoAnimation: boolean = False);
procedure SetGlowAlpha(ID: integer; aAlpha: byte);
procedure ClearGlows(ManualFreeing: boolean = False);


var
  bGlowingDestroying: boolean = False;


implementation

uses
  math,
  acntUtils, sGraphUtils, sAlphaGraph, sConst, sVCLUtils, acThdTimer, sFade;


type
  TacGlowEffect = class(TObject)
  public
    Margin,
    MaskIndex: integer;

    Wnd: TacGlowForm;
    AlphaBmp: TBitmap;
    Destroyed: boolean;
    OldWndProc: TWndMethod;
    SkinManager: TsSkinManager;
    SkinData: TsCommonData;
    constructor Create;
    destructor Destroy; override;
    procedure CreateAlphaBmp(const Width, Height: integer);
    procedure Show(R, RealRect: TRect; const Alpha: integer; WndHandle: HWND);
    procedure NewWndProc(var Message: TMessage);
  end;

  TacGlowEffects = array of TacGlowEffect;


var
  FBlend: TBlendFunction;
  acgEffects: TacGlowEffects;

{
function HideGlow_CB(Data: TObject; Iteration: integer): boolean;
var
  sd: TsCommonData;
  IterCount: integer;
begin
  Result := False;
  if Data is TsCommonData then begin
    sd := TsCommonData(Data);
    if sd.GlowID >= 0 then begin
      IterCount := sd.AnimTimer.Iterations;// acAnimationTime div acTimerInterval;
      if IterCount <= Iteration then begin
        HideGlow(sd.GlowID);

        if (sd.AnimTimer <> nil) and not sd.AnimTimer.Destroyed then
          FreeAndNil(sd.AnimTimer);
      end
      else begin
        SetGlowAlpha(sd.GlowID, MaxByte - Round(MaxByte * Iteration / IterCount));
        Result := True;
      end;
    end;
  end;
end;
}

function ShowGlow(const RealRect: TRect; const SkinSection, Name: string; const Margin, Alpha: integer; WndHandle: HWND; SkinData: TsCommonData = nil): integer;
var
  NewGlow: TacGlowEffect;
  mi: integer;
begin
  Result := -1;
  if acLayered and (SkinData <> nil) and (GetCapture = 0) then begin
    NewGlow := TacGlowEffect.Create;
    NewGlow.SkinData := SkinData;
    NewGlow.SkinManager := SkinData.SkinManager;
    mi := NewGlow.SkinManager.GetMaskIndex(SkinSection, Name + ZeroChar);
    if mi >= 0 then begin
      Result := Length(acgEffects);
      SetLength(acgEffects, Result + 1);
      acgEffects[Result] := NewGlow;
      NewGlow.Margin := Margin;
      NewGlow.MaskIndex := mi;
      NewGlow.Show(RealRect, RealRect, Alpha, WndHandle)
    end
    else begin
      Result := -1;
      FreeAndNil(NewGlow);
    end;
  end;
end;


function ShowGlow(const RealRect: TRect; MaskIndexes: array of integer; const Margin, Alpha: integer; WndHandle: HWND; SkinData: TsCommonData = nil): integer; overload;
var
  NewGlow: TacGlowEffect;
begin
  Result := -1;
  if acLayered and (SkinData <> nil) and (GetCapture = 0) then begin
    NewGlow := TacGlowEffect.Create;
    NewGlow.SkinData := SkinData;
    NewGlow.SkinManager := SkinData.SkinManager;
    if (Length(MaskIndexes) > 0) and (MaskIndexes[0] >= 0) then begin
      Result := Length(acgEffects);
      SetLength(acgEffects, Result + 1);
      acgEffects[Result] := NewGlow;
      NewGlow.Margin := Margin;
      NewGlow.MaskIndex := MaskIndexes[0];
      NewGlow.Show(RealRect, RealRect, Alpha, WndHandle)
    end
    else begin
      Result := -1;
      FreeAndNil(NewGlow);
    end;
  end;
end;


procedure HideGlow(var ID: integer; DoAnimation: boolean = False);
var
  sd: TsCommonData;
  i: integer;
begin
  if IsValidIndex(ID, Length(acgEffects)) and (acgEffects[ID] <> nil) then begin
    sd := acgEffects[ID].SkinData;
    if DoAnimation and sd.SkinManager.Effects.AllowAnimation and not Application.Terminated and ((sd.AnimTimer = nil) or (sd.AnimTimer.ThreadType = TT_GLOWING)) then begin
      i := GetNewTimer(sd.AnimTimer, sd.FOwnerControl, 1);
      if sd.AnimTimer.State <> 0 then begin// Started already
        sd.AnimTimer.InitData(sd, i, UpdateGlowing_CB, 0);
        sd.AnimTimer.TimeHandler;
      end;
    end
    else begin
      if (acgEffects[ID].Wnd <> nil) then begin
        acgEffects[ID].Wnd.WindowProc := acgEffects[ID].OldWndProc;
        bGlowingDestroying := True;
        if (csDestroying in acgEffects[ID].SkinManager.ComponentState) or Application.Terminated then
          FreeAndNil(acgEffects[ID].Wnd)
        else begin
          acgEffects[ID].Wnd.Release;
          acgEffects[ID].Wnd := nil;
        end;
        bGlowingDestroying := False;
      end;

      if (ID >= 0) and (acgEffects[ID] <> nil) then begin
        acgEffects[ID].Free;
        acgEffects[ID] := nil;
      end;

      ID := -1;
      if sd.AnimTimer <> nil then
        StopTimer(sd);
//        FreeAndNil(sd.AnimTimer);
    end;
  end;
end;


procedure SetGlowAlpha(ID: integer; aAlpha: byte);
begin
  if IsValidIndex(ID, Length(acgEffects)) and (acgEffects[ID] <> nil) then
    SetFormBlendValue(acgEffects[ID].Wnd.Handle, acgEffects[ID].AlphaBmp, AAlpha);
end;


procedure ClearGlows(ManualFreeing: boolean = False);
var
  i, l: integer;
begin
  if not bGlowingDestroying then begin
    l := Length(acgEffects) - 1;
    for i := 0 to l do if acgEffects[i] <> nil then begin
      if ManualFreeing then
        if acgEffects[i].Wnd <> nil then begin
          acgEffects[i].Wnd.WindowProc := acgEffects[i].OldWndProc;
          bGlowingDestroying := True;
          FreeAndNil(acgEffects[i].Wnd);
          bGlowingDestroying := False;
        end;

      if acgEffects[i].SkinData <> nil then
        acgEffects[i].SkinData.GlowID := -1;

      acgEffects[i].Free;
    end;
    SetLength(acgEffects, 0);
  end;
end;


constructor TacGlowEffect.Create;
begin
  Wnd := nil;
  Destroyed := False;
end;


procedure TacGlowEffect.CreateAlphaBmp(const Width, Height: integer);
begin
  if AlphaBmp <> nil then
    FreeAndNil(AlphaBmp);

  AlphaBmp := CreateBmp32(Width, Height);
  FillDC(AlphaBmp.Canvas.Handle, MkRect(AlphaBmp), 0);
  if MaskIndex >= 0 then
    DrawSkinRect(AlphaBmp, MkRect(AlphaBmp), EmptyCI, SkinManager.ma[MaskIndex], 0, False);

  UpdateBmpColors(AlphaBmp, SkinData, False, 0);
end;


destructor TacGlowEffect.Destroy;
begin
  Destroyed := True;
  if Wnd <> nil then begin
    Wnd.WindowProc := OldWndProc;
    if (csDestroying in SkinManager.ComponentState) or Application.Terminated then
      FreeAndNil(Wnd)
    else
      Wnd.Release;

    Wnd := nil;
  end;
  if AlphaBmp <> nil then
    FreeAndNil(AlphaBmp);

  inherited;
end;


procedure TacGlowEffect.NewWndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_NCHITTEST: begin
      Message.Result := HTTRANSPARENT;
      Exit;
    end;
  end;
  OldWndProc(Message);
end;


procedure TacGlowEffect.Show(R, RealRect: TRect; const Alpha: integer; WndHandle: HWND);
var
  DC: hdc;
  h: HWND;
  NewR: TRect;
  FBmpSize: TSize;
  FBmpTopLeft: TPoint;
  AddedStyle: {$IFDEF DELPHI7UP}NativeInt{$ELSE}longword{$ENDIF};
begin
  if Wnd = nil then begin
    Wnd := TacGlowForm.CreateNew(nil);

    Wnd.ControlStyle := Wnd.ControlStyle - [csCaptureMouse];

    OldWndProc := Wnd.WindowProc;
    Wnd.WindowProc := NewWndProc;
    R := RealRect;

    FBmpSize.cx := WidthOf (R, True) + SkinManager.ma[MaskIndex].WL + SkinManager.ma[MaskIndex].WR - 2 * Margin;
    FBmpSize.cy := HeightOf(R, True) + SkinManager.ma[MaskIndex].WT + SkinManager.ma[MaskIndex].WB - 2 * Margin;
    FBlend.SourceConstantAlpha := MaxByte;

    CreateAlphaBmp(FBmpSize.cx, FBmpSize.cy);

    Wnd.Width := FBmpSize.cx;
    Wnd.Height := FBmpSize.cy;
    if (GetWindowLong(WndHandle, GWL_EXSTYLE) and WS_EX_TOPMOST <> 0) or (SkinData.FOwnerObject = nil) then
      h := HWND_TOPMOST
    else
      h := GetNextWindow(WndHandle, GW_HWNDPREV);

    NewR := Rect(R.Left - SkinManager.ma[MaskIndex].WL + Margin, R.Top - SkinManager.ma[MaskIndex].WT + Margin, 0, 0);
    if h = 0 then
      h := WndHandle;

    Wnd.HandleNeeded;
    if Wnd.HandleAllocated then begin
      AddedStyle := WS_EX_LAYERED{ or WS_EX_NOACTIVATE} or WS_EX_TRANSPARENT;// or WS_EX_TOOLWINDOW;
      SetWindowLong(Wnd.Handle, GWL_EXSTYLE, GetWindowLong(Wnd.Handle, GWL_EXSTYLE) or AddedStyle);

      SetWindowPos(Wnd.Handle, h, NewR.Left, NewR.Top,
        0, 0, SWP_NOACTIVATE or SWP_NOOWNERZORDER or SWP_NOSENDCHANGING or SWP_NOSIZE {or SWP_NOZORDER {Preventing of windows positions changing});

      Wnd.Left := NewR.Left;
      Wnd.Top := NewR.Top;
      FBmpTopLeft := MkPoint;

      DC := GetDC(0);
      FBlend.SourceConstantAlpha := Alpha;
      UpdateLayeredWindow(Wnd.Handle, DC, nil, @FBmpSize, AlphaBmp.Canvas.Handle, @FBmpTopLeft, 0, @FBlend, ULW_ALPHA);
      ShowWindow(Wnd.Handle, SW_SHOWNOACTIVATE);
      ReleaseDC(0, DC);
    end;
  end;
end;


initialization
  with FBlend do begin
    BlendFlags := 0;
    BlendOp := AC_SRC_OVER;
    AlphaFormat := AC_SRC_ALPHA;
    SourceConstantAlpha := MaxByte;
  end;


finalization
  ClearGlows;

end.
