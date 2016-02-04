unit UnitFrames;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, 
  sFrameAdapter, StdCtrls, sButton;

type
  TFrameFrames = class(TFrame)
    sFrameAdapter1: TsFrameAdapter;
    sButton1: TsButton;
    sButton2: TsButton;
    constructor Create(AOwner : TComponent); override;
    procedure sButton1Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
  private
    x : integer;
    y : integer;
    Count : integer;
  end;

implementation

uses UnitFrameTest;

{$R *.DFM}

constructor TFrameFrames.Create(AOwner: TComponent);
begin
  inherited;
  x := 260;
  y := 10;
  Count := 0;
end;

procedure TFrameFrames.sButton1Click(Sender: TObject);
var
  NewFrame : TFrameTest;
begin
  inc(Count);
  NewFrame := TFrameTest.Create(Self);
  NewFrame.Name := 'TFrame16' + IntToStr(Count);
  NewFrame.Visible := False;
  NewFrame.Top := y;
  NewFrame.Left := x;
  NewFrame.Visible := True;
  NewFrame.Parent := Self;
  dec(x, 50);
  inc(y, 70);
  if Count > 5 then sButton1.Enabled := False;
  sButton2.Enabled := True;
end;

procedure TFrameFrames.sButton2Click(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to ControlCount - 1 do if Controls[i] is TFrame then begin
    Controls[i].Free;
    Break;
  end;
end;

end.
