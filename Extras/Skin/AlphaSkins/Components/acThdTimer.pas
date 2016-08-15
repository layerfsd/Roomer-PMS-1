// Copyright 1996, 1997, 1998 Carlos Barbosa //
unit acThdTimer;
{$I sDefs.inc}
{$IFDEF DELPHI6UP}
  {$WARN SYMBOL_DEPRECATED OFF} // "Resume" is deprecated
{$ENDIF}

{$DEFINE USE_TIMER} // Patched by M. Zhuravsky (standard timer used if key is enabled)
//{$DEFINE DEBUG}

interface

uses
  Windows, ExtCtrls, SysUtils, Classes, Forms, SyncObjs, Graphics, Controls;


type
  TacThreadedTimer = class;

  TacTimerThread = class(TThread)
    Interval: DWord;
    TimeEvent: TSimpleEvent;
    OwnerTimer: TacThreadedTimer;
    procedure Execute; override;
    procedure DoTimer;
  end;

  TacAnimProc = function(Data: TObject; Iteration: integer): boolean;

  TacThreadedTimer = class(TComponent)
  private
    FEnabled: Boolean;
    FInterval: DWord;
    FOnTimer: TNotifyEvent;
    FTimerThread: {$IFDEF USE_TIMER}TTimer{$ELSE}TacTimerThread{$ENDIF};
    FThreadPriority: TThreadPriority;
{$IFDEF DEBUG}
    FState,
    FIteration: integer;
    procedure SetState    (const Value: integer);
    procedure SetIteration(const Value: integer);
{$ENDIF}
    procedure StartTimer;
    procedure KillTimer;
{$IFDEF USE_TIMER}
    Procedure OnTimer2(Sender: TObject);
{$ENDIF}
  protected
    InHandler,
    Executing: boolean;

    FOwner: TObject;
    procedure UpdateTimer;
    procedure SetInterval      (Value: DWord);
    procedure SetEnabled       (Value: Boolean);
    procedure SetOnTimer       (Value: TNotifyEvent);
    procedure SetThreadPriority(Value: TThreadPriority);
    procedure Timer;
    procedure TimeEvent(Sender: TObject); // Temporary (while AnimProc is not used anywhere)
  public
    Glow,
    Value,
    GlowStep,
    ValueStep: real;

{$IFNDEF DEBUG}
    State,
    Iteration,
{$ENDIF}
    IntState,
    OldState,
    Iterations,
    ThreadType: integer;

    BmpTo,
    BmpOut,
    BmpFrom: TBitmap;

    AnimRect: TRect;
    AnimData: TObject;
    Destroyed: boolean;
    AnimControl: TControl;
    AnimProc: TacAnimProc;
    constructor Create(AOwner: TComponent); override;
    constructor CreateOwned(AOwner: TComponent; ChangeEvent: boolean); virtual;
    destructor Destroy; override;
    procedure CopyFrom(var DstBmp: TBitmap; SrcBmp: TBitmap; R: TRect);
    procedure InitData(AData: TObject; AIteration: integer; AAnimProc: TacAnimProc; AState: integer; AFast: boolean = False);
    procedure TimeHandler; virtual;
    procedure Reset;
{$IFDEF DEBUG}
    property State: integer read FState write SetState;
    property Iteration: integer read FIteration write SetIteration;
{$ENDIF}
  published
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Interval: DWord read FInterval write SetInterval default 1000;
    property OnTimer: TNotifyEvent read FOnTimer write SetOnTimer;
    property ThreadPriority: TThreadPriority read FThreadPriority write SetThreadPriority;
  end;


function GetNewTimer(var ATimer: TacThreadedTimer; AOwner: TComponent; State: integer): integer; // Current iteration returned (if timer exists already);

const
  // Thread types
  TT_GLOWING = 1;

implementation


uses
  math,
  sConst, acntUtils, sGraphUtils, sCommonData;


function GetNewTimer(var ATimer: TacThreadedTimer; AOwner: TComponent; State: integer): integer; // Current iteration returned (if timer exists already);
begin
  if ATimer <> nil then
    if ATimer.State = 0 then
      Result := max(acMaxIterations * acMultipNormal - ATimer.Iteration, 0)
    else
      Result := max(acMaxIterations - ATimer.Iteration, 0)
  else begin
    ATimer := TacThreadedTimer.Create(AOwner);
    if State = 0 then
      ATimer.Glow := MaxByte;

    Result := 0;
  end;
end;


procedure TacTimerThread.Execute;
var
  term_cause: TWaitResult;
begin
  repeat
    term_cause := TimeEvent.WaitFor(Interval);
    if term_cause = wrTimeout then
      Synchronize(DoTimer);
  until Terminated or (term_cause <> wrTimeout) or Application.Terminated;
end;


procedure TacTimerThread.DoTimer;
begin
  if not Application.Terminated then
    OwnerTimer.Timer;
end;


constructor TacThreadedTimer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FThreadPriority := tpNormal;
  Executing := False;
  Destroyed := False;
  InHandler := False;
  Glow := 0;
  Value := 0;
  AnimData := nil;
  AnimProc := nil;
  BmpOut := nil;
  State := -1;
  IntState := -1;
  OldState := -1;
  BmpTo := nil;
  BmpFrom := nil;
  ThreadType := 0;
  Iteration := 0;
  Iterations := acMaxIterations;
  if not Application.Terminated then begin
    FEnabled := True;
    FInterval := 1000;
    StartTimer;
  end;
end;


destructor TacThreadedTimer.Destroy;
begin
  Enabled := False;
  if AnimData is TsCommonData then
    TsCommonData(AnimData).AnimTimer := nil;

  if not Destroyed then begin
    Destroyed := True;
    KillTimer;
    if BmpFrom <> nil then
      FreeAndNil(BmpFrom);

    if BmpTo <> nil then
      FreeAndNil(BmpTo);

    if BmpOut <> nil then
      FreeAndNil(BmpOut);

    inherited Destroy;
  end;
end;


procedure TacThreadedTimer.InitData(AData: TObject; AIteration: integer; AAnimProc: TacAnimProc; AState: integer; AFast: boolean = False);
begin
  Enabled := False;
  AnimData := AData;
  Value := 0;
  if Glow > MaxByte then
    Glow := MaxByte
  else
    if Glow < 0 then
      Glow := 0;

  Iterations := acMaxIterations;
  if AFast then
    Iterations := Iterations div 2;

  case AState of
    0: begin
      Iterations := acMultipNormal * Iterations;
      GlowStep := Glow / Iterations;
    end;

    2:
      GlowStep := Glow / Iterations

    else begin
      if State > 0 then
        Iterations := acMaxIterations
      else
        Iterations := Round(acMaxIterations * (MaxByte - Glow) / MaxByte);

      Iterations := max(1, Iterations);
      GlowStep  := (MaxByte - Glow)  / Iterations;
    end;
  end;
  ValueStep := (MaxByte - Value) / Iterations;
  if (AState = 2) or (AState = 1) and (State = 2) then
    if (BmpOut <> nil) then
      CopyFrom(BmpFrom, BmpOut, MkRect(BmpOut));

  if (AState = 1) and (State < 1) then
    Iteration := Round(acMaxIterations * Glow / MaxByte)
  else
    if (AState = 0) and (State = 1) then
      if Glow = 0 then // If glow not used
        Iteration := 0
      else
        Iteration := Round(Iterations * (MaxByte - Glow) / MaxByte)
    else
      if (BmpOut <> nil) then
        Iteration := 0
      else
        Iteration := AIteration;

  Interval := acTimerInterval;
  AnimProc := AAnimProc;
  OldState := State;
  State    := AState;
  Enabled  := True;
end;


procedure TacThreadedTimer.StartTimer;
begin
{$IFDEF USE_TIMER}
  FTimerThread := TTimer.Create(Self);
  FTimerThread.Interval := FInterval;
  FTimerThread.OnTimer := OnTimer2;
{$ELSE}
  FTimerThread := TacTimerThread.Create(True);
  FTimerThread.OwnerTimer := Self;
  FTimerThread.Interval := FInterval;
  FTimerThread.Priority := FThreadPriority;
  FTimerThread.FreeOnTerminate := False;
  FTimerThread.TimeEvent := TSimpleEvent.Create;
  FTimerThread.TimeEvent.ResetEvent;
  FTimerThread.Resume;
{$ENDIF}
end;


procedure TacThreadedTimer.KillTimer;
begin
  if FTimerThread <> nil then begin
{$IFDEF USE_TIMER}
    FTimerThread.Enabled := False;
{$ELSE}
    FTimerThread.TimeEvent.SetEvent;         // Note: if the thread is suspended
                                             //       it will never terminate!
    if FTimerThread.Suspended then
      FTimerThread.Resume;

    FTimerThread.WaitFor;
    FTimerThread.TimeEvent.Free;
{$ENDIF}
    FTimerThread.Free;
    FTimerThread := nil;
  end;
end;


procedure TacThreadedTimer.UpdateTimer;
begin
  if FTimerThread <> nil then begin
{$IFDEF USE_TIMER}
    FTimerThread.Enabled := False;
    if (FInterval <> 0) and FEnabled and (Assigned(FOnTimer) or Assigned(AnimProc)) then
      FTimerThread.Enabled := True;
{$ELSE}
    if not FTimerThread.Suspended then
      FTimerThread.Suspend;

    if (FInterval <> 0) and FEnabled and (Assigned(FOnTimer) or Assigned(AnimProc)) then
      FTimerThread.Resume;
{$ENDIF}
  end;
end;


procedure TacThreadedTimer.SetEnabled(Value: Boolean);
begin
  if Value <> FEnabled then begin
    FEnabled := Value;
    UpdateTimer;
  end;
end;


procedure TacThreadedTimer.SetInterval(Value: DWord);
begin
  if Value <> FInterval then begin
    FInterval := Value;
    if FTimerThread <> nil then begin
      FTimerThread.Interval := FInterval;
      UpdateTimer;
    end;
  end;
end;


procedure TacThreadedTimer.SetOnTimer(Value: TNotifyEvent);
begin
  FOnTimer := Value;
  UpdateTimer;
end;


procedure TacThreadedTimer.SetThreadPriority(Value: TThreadPriority);
begin
  if Value <> FThreadPriority then begin
    FThreadPriority := Value;
{$IFNDEF USE_TIMER}
    FTimerThread.Priority := Value;
{$ENDIF}
    UpdateTimer;
  end;
end;


procedure TacThreadedTimer.Timer;
begin
  if not Destroyed and Enabled then
    if Assigned(AnimProc) then begin
      Iteration := Iteration + 1;
      if Iteration > Iterations then
        Enabled := False
      else
        AnimProc(AnimData, Iteration);
    end
    else
      if Assigned(FOnTimer) then
        FOnTimer(Self);
end;


procedure TacThreadedTimer.Reset;
begin
  KillTimer;
  StartTimer;
  UpdateTimer;
end;


constructor TacThreadedTimer.CreateOwned(AOwner: TComponent; ChangeEvent: boolean);
begin
  Create(AOwner);
  Enabled := False;
  FOwner := AOwner;
  if ChangeEvent then
    OnTimer := TimeEvent;
end;


procedure TacThreadedTimer.TimeHandler;
begin
  if Enabled and Assigned(AnimProc) and not Destroyed then
    if not AnimProc(AnimData, Iteration) then begin
      Enabled := False;
      State := -1;
    end;
end;


procedure TacThreadedTimer.TimeEvent(Sender: TObject);
begin
  TimeHandler;
end;


{$IFDEF USE_TIMER}
procedure TacThreadedTimer.OnTimer2(Sender: TObject);
begin
  if TTimer(Sender).Enabled and not Executing and not Destroyed then begin
    Executing := True;
    if TTimer(Sender).Owner <> nil then
      TacThreadedTimer(TTimer(Sender).Owner).Timer;

    if Sender <> nil then
      Executing := False;
  end;
end;
{$ENDIF}


procedure TacThreadedTimer.CopyFrom(var DstBmp: TBitmap; SrcBmp: TBitmap; R: TRect);
begin
  if DstBmp = nil then
    DstBmp := CreateBmp32(R)
  else begin
    SrcBmp.Width  := WidthOf(R, True);
    SrcBmp.Height := HeightOf(R, True);
  end;
  BitBlt(DstBmp.Canvas.Handle, 0, 0, DstBmp.Width, DstBmp.Height, SrcBmp.Canvas.Handle, R.Left, R.Top, SRCCOPY);
end;


{$IFDEF DEBUG}
procedure TacThreadedTimer.SetState(const Value: integer);
begin
  FState := Value;
end;

procedure TacThreadedTimer.SetIteration(const Value: integer);
begin
  FIteration := Value;
end;
{$ENDIF}

end.
