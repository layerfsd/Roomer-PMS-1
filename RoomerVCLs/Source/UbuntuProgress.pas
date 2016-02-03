unit UbuntuProgress;

interface

uses
  Windows, SysUtils, Classes, Controls, Graphics, Math, ExtCtrls;

type
  TUbuntuProgressColorSets = (csOriginal, csBlue, csRed);
  TUbuntuProgressMode = (pmNormal, pmMarquee);
  TMarqueeMode = (mmToLeft, mmToRight);
  TMarqueeSpeed = (msSlow, msMedium, msFast);

  TUbuntuProgress = class(TGraphicControl)
  private
    FColorSet: TUbuntuProgressColorSets;
    FProgressDividers: Boolean;
    FBackgroundDividers: Boolean;
    FMarqueeWidth: Longint;
    FMax: Longint;
    FMode: TUbuntuProgressMode;
    FPosition: Longint;
    FShadow: Boolean;
    FSpeed: TMarqueeSpeed;
    FStep: Longint;
    FVisible: Boolean;
    Buffer: TBitmap;
    DrawWidth: Longint;
    MarqueeMode: TMarqueeMode;
    MarqueePosition: Longint;
    Timer: TTimer;
    procedure SetColorSet(newColorSet: TUbuntuProgressColorSets);
    procedure SetProgressDividers(newProgressDividers: Boolean);
    procedure SetBackgroundDividers(newBackgroundDividers: Boolean);
    procedure SetMarqueeWidth(newMarqueeWidth: Longint);
    procedure SetMax(newMax: Longint);
    procedure SetMode(newMode: TUbuntuProgressMode);
    procedure SetPosition(newPosition: Longint);
    procedure SetShadow(newShadow: Boolean);
    procedure SetSpeed(newSpeed: TMarqueeSpeed);
    procedure SetStep(newStep: Longint);
    procedure SetVisible(newVisible: Boolean);
    procedure MarqueeOnTimer(Sender: TObject);
    procedure PaintNormal;
    procedure PaintMarquee;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure StepIt;
  published
    property ColorSet: TUbuntuProgressColorSets read FColorSet write SetColorSet;
    property ProgressDividers: Boolean read FProgressDividers write SetProgressDividers;
    property BackgroundDividers: Boolean read FBackgroundDividers write SetBackgroundDividers;
    property MarqueeWidth: Longint read FMarqueeWidth write SetMarqueeWidth;
    property Max: Longint read FMax write SetMax;
    property Mode: TUbuntuProgressMode read FMode write SetMode;
    property Position: Longint read FPosition write SetPosition;
    property Shadow: Boolean read FShadow write SetShadow;
    property Speed: TMarqueeSpeed read FSpeed write SetSpeed;
    property Step: Longint read FStep write SetStep;
    property Height;
    property Visible: Boolean read FVisible write SetVisible;
    property Width;
  end;

procedure Register;

implementation
uses
  UbuntuProgressColors;

{$R UbuntuProgress.dcr}

procedure Register;
begin
  RegisterComponents('Roomer', [TUbuntuProgress]);
end;


procedure TUbuntuPRogress.SetColorSet(newColorSet: TUbuntuProgressColorSets);
  begin
    FColorSet := newColorSet;
    Invalidate;
  end;

procedure TUbuntuProgress.SetMarqueeWidth(newMarqueeWidth: Integer);
  var
    OldWidth: Longint;
  begin
    if (newMarqueeWidth < (Width-3)) and (newMarqueeWidth > 0) then
      begin
        OldWidth := FMarqueeWidth;
        FMarqueeWidth := newMarqueeWidth;
        if MarqueeMode = mmToRight then
          MarqueePosition := MarqueePosition - (newMarqueeWidth - OldWidth);
      end;
  end;

procedure TUbuntuProgress.SetProgressDividers(newProgressDividers: Boolean);
  begin
    FProgressDividers := newProgressDividers;
    Invalidate;
  end;

procedure TUbuntuProgress.SetBackgroundDividers(newBackgroundDividers: Boolean);
  begin
    FBackgroundDividers := newBackgroundDividers;
    Invalidate;
  end;

procedure TUbuntuProgress.SetMax(newMax: Integer);
  begin
    if newMax > 0 then
      FMax := newMax;
    if FPosition > FMax then
      FPosition := FMax;
    Invalidate;
  end;

procedure TUbuntuProgress.SetMode(newMode: TUbuntuProgressMode);
  begin
    FMode := newMode;
    if FMode = pmNormal then
      Timer.Enabled := False
    else
      Timer.Enabled := True;
    Invalidate;
  end;

procedure TUbuntuProgress.SetPosition(newPosition: Integer);
  begin
    if (newPosition >= 0) and (newPosition <= FMax) then
      FPosition := newPosition;
    Invalidate;
  end;

procedure TUbuntuProgress.SetShadow(newShadow: Boolean);
  begin
    FShadow := newShadow;
    if FShadow then
      Height := 19
    else
      Height := 18;
    Invalidate;
  end;

procedure TUbuntuProgress.SetSpeed(newSpeed: TMarqueeSpeed);
  begin
    FSpeed := newSpeed;
    case FSpeed of
      msSlow: Timer.Interval := 50;
      msMedium: Timer.Interval := 20;
      msFast: Timer.Interval := 10;
    end;
  end;

procedure TUbuntuProgress.SetStep(newStep: Integer);
  begin
    if (newStep > 0) and (newStep <= (FMax)) then
      FStep := newStep;
  end;

procedure TUbuntuProgress.SetVisible(newVisible: Boolean);
  begin
    FVisible := newVisible;
    if FVisible then
      Invalidate
    else
      Parent.Invalidate;
  end;

procedure TUbuntuProgress.MarqueeOnTimer(Sender: TObject);
  begin
    if not (csDesigning in ComponentState) then
      Invalidate;
  end;

procedure TUbuntuProgress.PaintNormal;
  var
    POverlay: Longint;
    PJoist: Longint;
    PDistance: Extended;
    i, k: Longint;
  begin
    POverlay := Floor((DrawWidth-3)/FMax*FPosition);
    PJoist := Floor((Width-3)/16);
    PDistance := (Width-3)/PJoist;
    with Buffer.Canvas do
      begin
        //3D-Effekt Fortschritt
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[0];
        FillRect(Rect(1, 1, POverlay+1, 2));
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[1];
        FillRect(Rect(1, 2, POverlay+1, 3));
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[2];
        FillRect(Rect(1, 3, POverlay+1, 4));
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[3];
        FillRect(Rect(1, 4, POverlay+1, 5));
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[4];
        FillRect(Rect(1, 5, POverlay+1, 6));
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[5];
        FillRect(Rect(1, 6, POverlay+1, 7));
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[6];
        FillRect(Rect(1, 7, POverlay+1, 8));
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[7];
        FillRect(Rect(1, 8, POverlay+1, 9));
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[8];
        FillRect(Rect(1, 9, POverlay+1, 12));
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[9];
        FillRect(Rect(1, 12, POverlay+1, 13));
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[10];
        FillRect(Rect(1, 13, POverlay+1, 14));
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[11];
        FillRect(Rect(1, 14, POverlay+1, 15));
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[12];
        FillRect(Rect(1, 15, POverlay+1, 16));
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[13];
        FillRect(Rect(1, 16, POverlay+1, 17));
        //Balken Fortschritt
        if FProgressDividers then
          begin
            for i := 1 to PJoist-1 do
              begin
                if Round(PDistance*i)<=POverlay then
                  for k := 0 to 15 do
                      Pixels[Round(PDistance*i), k+1] := UbuntuProgressColorSets[FColorSet].JoistLeft[k];
                if Round(PDistance*i)+1<=POverlay then
                  for k := 0 to 15 do
                      Pixels[Round(PDistance*i)+1, k+1] := UbuntuProgressColorSets[FColorSet].JoistRight[k];
              end;
          end;
      end;
  end;

procedure TUbuntuProgress.PaintMarquee;
  var
    PLeft: Longint;
    PRight: Longint;
    PJoist: Longint;
    PDistance: Extended;
    i, k: Longint;
  begin
    PJoist := Floor((Width-3)/16);
    PDistance := (Width-3)/PJoist;
    if MarqueeMode = mmToRight then
      Inc(MarqueePosition,1)
    else
      Dec(MarqueePosition,1);
    if MarqueePosition >= (Width-FMarqueeWidth-2) then
      MarqueeMode := mmToLeft
    else if MarqueePosition <= 1 then
      MarqueeMode := mmToRight;
    PLeft := MarqueePosition;
    PRight := PLeft + FMarqueeWidth;
    with Buffer.Canvas do
      begin
        //3D-Effekt Innen
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[0];
        FillRect(Rect(PLeft, 1, PRight, 2));
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[1];
        FillRect(Rect(PLeft, 2, PRight, 3));
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[2];
        FillRect(Rect(PLeft, 3, PRight, 4));
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[3];
        FillRect(Rect(PLeft, 4, PRight, 5));
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[4];
        FillRect(Rect(PLeft, 5, PRight, 6));
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[5];
        FillRect(Rect(PLeft, 6, PRight, 7));
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[6];
        FillRect(Rect(PLeft, 7, PRight, 8));
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[7];
        FillRect(Rect(PLeft, 8, PRight, 9));
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[8];
        FillRect(Rect(PLeft, 9, PRight, 12));
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[9];
        FillRect(Rect(PLeft, 12, PRight, 13));
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[10];
        FillRect(Rect(PLeft, 13, PRight, 14));
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[11];
        FillRect(Rect(PLeft, 14, PRight, 15));
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[12];
        FillRect(Rect(PLeft, 15, PRight, 16));
        Brush.Color := UbuntuProgressColorSets[FColorSet].Progress[13];
        FillRect(Rect(PLeft, 16, PRight, 17));
        //Balken Innen
        if FProgressDividers then
          begin
            for i := 1 to PJoist-1 do
              begin
                if (Round(PDistance*i)>=PLeft) and
                   (Round(PDistance*i)<=PRight) then
                  for k := 0 to 15 do
                    Pixels[Round(PDistance*i), k+1] := UbuntuProgressColorSets[FColorSet].JoistLeft[k];
                if (Round(PDistance*i)+1>=PLeft) and
                   (Round(PDistance*i)+1<=PRight) then
                  for k := 0 to 15 do
                      Pixels[Round(PDistance*i)+1, k+1] := UbuntuProgressColorSets[FColorSet].JoistRight[k];
              end;
          end;
      end;
  end;

procedure TUbuntuProgress.Paint;
  var
    PJoist: Longint;
    PDistance: Extended;
    i: Longint;
  begin
    inherited;
    if Visible or ((not Visible) and (csDesigning in ComponentState)) then
      begin
        if FShadow then
          DrawWidth := Width
        else
          DrawWidth := Width + 1;
        PJoist := Floor((Width-3)/16);
        PDistance := (Width-3)/PJoist;
        Buffer.Width := Width;
        Buffer.Height := Height; //19
        with Buffer.Canvas do
          begin
            Brush.Style := bsSolid;
            Pen.Style := psSolid;
            //Eckpixel
            Pixels[0, 0] := $00C6C7CE;{-}
            Pixels[DrawWidth-2, 0] := $00C6C7CE;{-}
            Pixels[DrawWidth-2, 17] := $00C6C7CE;{-}
            Pixels[0, 17] := $00C6C7CE;{-}
            //Übergang
            Pixels[1, 0] := $00737584;{-}
            Pixels[DrawWidth-3, 0] := $00737584;{-}
            Pixels[DrawWidth-2, 1] := $00737584;{-}
            Pixels[DrawWidth-2, 16] := $00737584;{-}
            Pixels[DrawWidth-3, 17] := $00737584;{-}
            Pixels[1, 17] := $00737584;{-}
            Pixels[0, 16] := $00737584;{-}
            Pixels[0, 1] := $00737584;{-}
            //Seitenlinien
            Pen.Color := $00636973;{-}
            MoveTo(2, 0);
            LineTo(DrawWidth-3, 0);
            MoveTo(DrawWidth-2, 2);
            LineTo(DrawWidth-2, 16);
            MoveTo(DrawWidth-4, 17);
            LineTo(1, 17);
            MoveTo(0, 15);
            LineTo(0, 1);
            //Schatten
            if FShadow then
              begin
                Pixels[0, 18] := $00E7EBEF;{-}
                Pixels[1, 18] := $00DEE3E7;{-}
                Pixels[DrawWidth-3, 18] := $00DEE3E7;{-}
                Pixels[DrawWidth-2, 18] := $00E7EBEF;{-}
                Pixels[DrawWidth-1, 18] := $00E7EBEF;{-}
                Pixels[DrawWidth-1, 17] := $00E7EBEF;{-}
                Pixels[DrawWidth-1, 16] := $00DEE3E7;{-}
                Pixels[DrawWidth-1, 1] := $00DEE3E7;{-}
                Pixels[DrawWidth-1, 0] := $00E7EBEF;{-}
                Pen.Color := $00D6D7DE;{-}
                MoveTo(2, 18);
                LineTo(DrawWidth-3, 18);
                MoveTo(DrawWidth-1, 15);
                LineTo(DrawWidth-1, 1);
              end;
            //3D-Effekt Innen
            Brush.Color := $00F7F7F7;{-}
            FillRect(Rect(1, 1, DrawWidth-2, 3));
            Brush.Color := $00F7F3F7;{-}
            FillRect(Rect(1, 3, DrawWidth-2, 5));
            Brush.Color := $00EFF3F7;{-}
            FillRect(Rect(1, 5, DrawWidth-2, 8));
            Brush.Color := $00E7E7EF;{-}
            FillRect(Rect(1, 8, DrawWidth-2, 9));
            Brush.Color := $00E7EBEF;{-}
            FillRect(Rect(1, 9, DrawWidth-2, 12));
            Brush.Color := $00EFEFE7;{-}
            FillRect(Rect(1, 12, DrawWidth-2, 13));
            Brush.Color := $00EFF3F7;{-}
            FillRect(Rect(1, 13, DrawWidth-2, 14));
            Brush.Color := $00EFEFF7;{-}
            FillRect(Rect(1, 14, DrawWidth-2, 16));
            Brush.Color := $00F7F7FF;{-}
            FillRect(Rect(1, 16, DrawWidth-2, 17));
            //Balken Innen
            for i := 1 to PJoist-1 do
              if FBackgroundDividers then
                begin
                  Pen.Color := $00DEDBDE;{-}
                  MoveTo(Round(PDistance*i), 1);
                  LineTo(Round(PDistance*i), 17);
                  Pen.Color := $00D8D5E0;{-}
                  MoveTo(Round(PDistance*i), 8);
                  LineTo(Round(PDistance*i), 13);
                  Pen.Color := $00FCF5FC;{-}
                  MoveTo(Round(PDistance*i)+1, 1);
                  LineTo(Round(PDistance*i)+1, 17);
                  Pen.Color := $00EDEDF5;{-}
                  MoveTo(Round(PDistance*i)+1, 8);
                  LineTo(Round(PDistance*i)+1, 13);
                end;
          end;
        case FMode of
          pmNormal: PaintNormal;
          pmMarquee:
            begin
              if not (csDesigning in ComponentState) then
                PaintMarquee;
              end;
        end;
        BitBlt(Canvas.Handle, 0, 0, Width, 19, Buffer.Canvas.Handle, 0, 0, SRCCOPY);
      end;
  end;

procedure TUbuntuProgress.SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer);
  begin
    if AWidth < 100 then
      AWidth := 100;
    if FShadow then
      inherited SetBounds(ALeft, ATop, AWidth, 19)
    else
      inherited SetBounds(ALeft, ATop, AWidth, 18);
  end;

procedure TUbuntuProgress.StepIt;
  begin
    if FMode = pmNormal then
      begin
        FPosition := FPosition+FStep;
        if FPosition > FMax then
          FPosition := 0;
        Invalidate;
      end;
  end;

constructor TUbuntuProgress.Create(AOwner: TComponent);
  begin
    inherited Create(AOwner);
    ControlStyle := ControlStyle + [csFixedHeight, csOpaque];
    Buffer := TBitmap.Create;
    Timer := TTimer.Create(Self);
    Timer.Enabled := False;
    Timer.Interval := 20;
    Timer.OnTimer := MarqueeOnTimer;
    FColorSet := csOriginal;
    FProgressDividers := True;
    FBackgroundDividers := True;
    FMarqueeWidth := 30;
    FMax := 100;
    FMode := pmNormal;
    FPosition := 50;
    FShadow := True;
    FSpeed := msMedium;
    FStep := 1;
    MarqueeMode := mmToRight;
    MarqueePosition := 0;
    Height := 19;
    Width := 150;
    Visible := True;
  end;

destructor TUbuntuProgress.Destroy;
  begin
    Timer.Free;
    Buffer.Free;
    inherited;
  end;

end.
