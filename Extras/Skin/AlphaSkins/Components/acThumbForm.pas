unit acThumbForm;
{$WARNINGS OFF}
{$i sDefs.inc}

interface

uses
  {$IFDEF DELPHI6UP} Variants, {$ENDIF}
  Windows, Messages, SysUtils, Classes, Controls, Forms;


const
  sMagnificationDll = 'Magnification.dll';


type
  TMagTransform = packed record
    v: packed array [0..2, 0..2] of Single;
  end;

  THWNDArray = packed array [0..1] of HWND;
  PHWNDArray = ^THWNDArray;


type
  TMagnifierOwner = class;
  TMagnifierWindow = class
  private
    FTop,
    FLeft,
    FWidth,
    FHeight: Integer;
    FHandle: HWND;
    FMagFactor: Byte;
    FVisible: Boolean;
    FWndStyle: Cardinal;
    FParent: TMagnifierOwner;
    procedure SetMagFactor(const Value: Byte);
    procedure SetVisible(const Value: Boolean);
  public
    PosUpdating: boolean;
    property Handle: HWND read FHandle;
    property MagFactor: Byte read FMagFactor write SetMagFactor;
    property Visible: Boolean read FVisible write SetVisible;
    constructor Create(Parent: TMagnifierOwner);
    destructor Destroy; override;
    procedure Refresh;
    procedure UpdateSource;
  end;


  TMagnifierOwner = class(TForm)
    procedure WMMove(var m: TMessage); message WM_MOVE;
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  public
    cL,
    cT,
    cR,
    cB: integer;
    ParentForm: TForm;
    MagnWnd: TMagnifierWindow;
    constructor Create(AOwner: TComponent); override;
    procedure CreateParams(var Params: TCreateParams); override;
    destructor Destroy; override;
    procedure UpdatePosition(Full: boolean = True);
    procedure UpdateRgn;
  end;


var
  MagnifierOwner: TMagnifierOwner;
  acMagInitialize:          function: BOOL; stdcall;
  acMagUninitialize:        function: BOOL; stdcall;
  acMagSetWindowSource:     function (hwnd: HWND; rect: TRect): BOOL; stdcall;
  acMagSetWindowTransform:  function (hwnd: HWND; out Transform: TMagTransform): BOOL; stdcall;
  acMagSetWindowFilterList: function (hwnd: HWND; dwFilterMode: DWORD; count: Integer; pHWND: PHWNDArray): BOOL; stdcall;


implementation

uses
  math,
  {$IFDEF DELPHI5}sConst, {$ENDIF}
  sSkinProvider, acMagn, sGraphUtils, acntUtils;

{$R *.dfm}

const
  WC_MAGNIFIER = 'Magnifier';


constructor TMagnifierOwner.Create(AOwner: TComponent);
begin
  inherited;
  ParentForm := TForm(AOwner);
  with TacMagnForm(AOwner).ContentMargins do begin
    cL := Left;
    cR := Right;
    cT := Top;
    cB := Bottom;
  end;
  Left := ParentForm.Left + cL;
  Top := ParentForm.Top + cT;
  Width  := TacMagnForm(AOwner).MagnSize.cx - cL - cR;
  Height := TacMagnForm(AOwner).MagnSize.cy - cT - cB;
  if HandleAllocated then begin
    MagnWnd := TMagnifierWindow.Create(Self);
    MagnWnd.MagFactor := TacMagnForm(ParentForm).Caller.Scaling;
    UpdatePosition(True);
  end;
end;


procedure TMagnifierOwner.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle := Params.ExStyle or WS_EX_TOOLWINDOW or WS_EX_NOACTIVATE or WS_EX_TRANSPARENT or WS_EX_TOPMOST;
end;


destructor TMagnifierOwner.Destroy;
begin
  inherited;
  if Assigned(MagnWnd) then
    FreeAndNil(MagnWnd);
end;


procedure TMagnifierOwner.WMMove(var m: TMessage);
begin
  if Assigned(MagnWnd) then
    MagnWnd.UpdateSource;
end;


constructor TMagnifierWindow.Create(Parent: TMagnifierOwner);
begin
  if Assigned(acMagInitialize) then begin
    if not acMagInitialize then
      {$IFDEF DELPHI6UP} RaiseLastOSError{$ENDIF};

    FVisible := False;
    PosUpdating := False;
    FParent := Parent;
    FLeft := 0;
    FTop := 0;

    FWidth := Parent.ClientWidth;
    FHeight := Parent.ClientHeight;
    SetLayeredWindowAttributes(Handle, 0, MaxByte, ULW_ALPHA);
    FWndStyle := WS_CHILD or WS_VISIBLE or WS_CLIPSIBLINGS;
    FHandle := CreateWindow(WC_MAGNIFIER, 'acMagWnd', FWndStyle, FLeft, FTop, FWidth, FHeight, FParent.Handle, 0, HInstance, nil);
    if FHandle = 0 then
      {$IFDEF DELPHI6UP} RaiseLastOSError{$ENDIF};
  end;
end;


destructor TMagnifierWindow.Destroy;
begin
  DestroyWindow(FHandle);
  if not acMagUninitialize then
    {$IFDEF DELPHI6UP} RaiseLastOSError{$ENDIF};

  inherited;
end;


procedure TMagnifierWindow.SetMagFactor(const Value: Byte);
var
  matrix: TMagTransform;
begin
  FMagFactor := Value;
  FillMemory(@matrix, SizeOf(matrix), 0);
  matrix.v[0][0] := FMagFactor;
  matrix.v[1][1] := FMagFactor;
  matrix.v[2][2] := 1;
  if not acMagSetWindowTransform(FHandle, matrix) then
    {$IFDEF DELPHI6UP} RaiseLastOSError{$ENDIF};
end;


procedure TMagnifierWindow.SetVisible(const Value: Boolean);
const
  ShowCmd: array[Boolean] of Cardinal = (SW_HIDE, SW_SHOW);
begin
  FVisible := Value;
  ShowWindow(FHandle, ShowCmd[FVisible]);
  if FVisible then
    UpdateSource;
end;


procedure TMagnifierWindow.Refresh;
begin
//  InvalidateRect(FHandle, nil, True);
end;


procedure TMagnifierWindow.UpdateSource;
var
  p: TPoint;
  SourceRect: TRect;
  warray: THWNDArray;
begin
  if not PosUpdating then begin
    PosUpdating := True;
    SourceRect := Rect(FLeft, FTop, FLeft + FWidth, FTop + FHeight);
    InflateRect(SourceRect, ((FWidth div FMagFactor) - FWidth) div 2, ((FHeight div FMagFactor) - FHeight) div 2);
    SourceRect.TopLeft := FParent.ClientToScreen(SourceRect.TopLeft);
    SourceRect.BottomRight := FParent.ClientToScreen(SourceRect.BottomRight);
    if Assigned(TacMagnForm(FParent.ParentForm).Caller.OnGetSourceCoords) then begin
      p := SourceRect.TopLeft;
      TacMagnForm(FParent.ParentForm).Caller.OnGetSourceCoords(p);
      SourceRect := Rect(p.x, p.y, WidthOf(SourceRect), HeightOf(SourceRect));
    end;
    SetWindowPos(FHandle, HWND_TOP, 0, 0, FWidth, FHeight, SWP_NOREDRAW or SWP_NOMOVE or SWP_NOACTIVATE or SWP_NOREDRAW or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER or SWP_NOZORDER);
    warray[0] := FParent.ParentForm.Handle;
    warray[1] := FParent.Handle;
    acMagSetWindowFilterList(FHandle, 0, 2, @warray);
    if not acMagSetWindowSource(FHandle, SourceRect) then
      {$IFDEF DELPHI6UP} RaiseLastOSError{$ENDIF};

    Visible := True;
    Refresh;
    PosUpdating := False;
  end;
end;


procedure TMagnifierOwner.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  Perform(WM_SYSCOMMAND, $F012, 0)
end;


procedure TMagnifierOwner.UpdatePosition(Full: boolean = True);
const
  TestOffset = 0;
begin
  if Full then begin
    InitDwm(Handle, True);
    with MagnWnd do begin
      FWidth  := min(max(TacMagnForm(ParentForm).MinSize, ParentForm.Width),  amMaxSize) - cL - cR;
      FHeight := min(max(TacMagnForm(ParentForm).MinSize, ParentForm.Height), amMaxSize) - cT - cB;
    end;
    SetWindowPos(Handle, ParentForm.Handle, ParentForm.Left + cL + TestOffset, ParentForm.Top + cT, MagnWnd.FWidth, MagnWnd.FHeight, SWP_NOACTIVATE or SWP_NOREDRAW or SWP_SHOWWINDOW or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER);
    UpdateRgn;
    MagnWnd.UpdateSource;
  end
  else
    SetWindowPos(Handle, 0, ParentForm.Left + cL + TestOffset, ParentForm.Top + cT, 0, 0, SWP_NOSIZE or SWP_NOACTIVATE or SWP_NOREDRAW or SWP_NOZORDER or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER);
end;


procedure TMagnifierOwner.UpdateRgn;
begin
  if TacMagnForm(ParentForm).Caller.Style = amsLens then
    SetWindowRgn(Handle, CreateRoundRectRgn(0, 0, Width, Height, 262, 262), False);
end;

end.
