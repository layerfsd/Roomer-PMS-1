unit uTransparentPanel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  TRoomerTransparentPanel = class(TPanel)
  private
    FBackground: TBitmap;
    procedure WMEraseBkGnd(Var msg: TWMEraseBkGnd); message WM_ERASEBKGND;
  protected
    procedure CaptureBackground;
    procedure Paint; override;
  public
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    property Canvas;
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Roomer', [TRoomerTransparentPanel]);
end;

procedure TRoomerTransparentPanel.CaptureBackground;
var
  Canvas: TCanvas;
  dc: HDC;
  sourcerect: TRect;
begin
  FBackground := TBitmap.Create;
  with FBackground do
  begin
    width := clientwidth;
    height := clientheight;
  end;
  sourcerect.TopLeft := ClientToScreen(clientrect.TopLeft);
  sourcerect.BottomRight := ClientToScreen(clientrect.BottomRight);
  dc := CreateDC('DISPLAY', nil, nil, nil);
  try
    Canvas := TCanvas.Create;
    try
      Canvas.handle := dc;
      FBackground.Canvas.CopyRect(clientrect, Canvas, sourcerect);
    finally
      Canvas.handle := 0;
      Canvas.free;
    end;
  finally
    DeleteDC(dc);
  end;
end;

constructor TRoomerTransparentPanel.Create(aOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle - [csSetCaption];
end;

destructor TRoomerTransparentPanel.Destroy;
begin
  FBackground.free;
  inherited;
end;

procedure TRoomerTransparentPanel.Paint;
begin
  if csDesigning In ComponentState then
    inherited
    { would need to draw frame and optional caption here do not call
      inherited, the control fills its client area if you do }
end;

procedure TRoomerTransparentPanel.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if Visible and HandleAllocated and not(csDesigning In ComponentState) then
  begin
    FBackground.free;
    FBackground := Nil;
    Hide;
    inherited;
    Parent.Update;
    Show;
  end
  else
    inherited;
end;

procedure TRoomerTransparentPanel.WMEraseBkGnd(var msg: TWMEraseBkGnd);
var
  Canvas: TCanvas;
begin
  if csDesigning In ComponentState then
    inherited
  else
  begin
    if not Assigned(FBackground) then
      CaptureBackground;
    Canvas := TCanvas.Create;
    try
      Canvas.handle := msg.dc;
      Canvas.draw(0, 0, FBackground);
    finally
      Canvas.handle := 0;
      Canvas.free;
    end;
    msg.result := 1;
  end;
end;
end.
