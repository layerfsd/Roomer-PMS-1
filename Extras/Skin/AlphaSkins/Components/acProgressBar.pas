unit acProgressBar;
{$I sDefs.inc}
//+
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ComCtrls, sCommonData, ExtCtrls,
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  sConst;


type
{$IFNDEF D2009}
  TProgressBarStyle = (pbstNormal, pbstMarquee);
{$ENDIF}


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsProgressBar = class(TProgressBar)
{$IFNDEF NOTFORHELP}
  private
    FOrient,
    FMarqSize,
    FMarqStep,
    FOldCount: integer;

    Timer: TTimer;
    FMarqPos: real;
    FCommonData: TsCommonData;
    FProgressSkin: TsSkinSection;
{$IFNDEF D2009}
    FSavedPosition: Integer;
    FMarqueeInterval: Integer;
    FStyle: TProgressBarStyle;
{$ENDIF}
    procedure PrepareCache;
    function ProgressRect: TRect;
    function ItemSize: TSize;
    function ClRect: TRect;
    procedure SetProgressSkin(const Value: TsSkinSection);
{$IFNDEF D2009}
    procedure SetStyle(const Value: TProgressBarStyle);
    procedure SetMarqueeInterval(const Value: Integer);
{$ENDIF}
    procedure TimerAction(Sender: TObject);
  public
    procedure Paint(DC: hdc);
    constructor Create(AOwner: TComponent); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure Loaded; override;
    procedure WndProc (var Message: TMessage); override;
  published
{$ENDIF}
    property ProgressSkin: TsSkinSection read FProgressSkin write SetProgressSkin;
    property SkinData: TsCommonData read FCommonData write FCommonData;
{$IFNDEF D2009}
    property Style: TProgressBarStyle read FStyle write SetStyle default pbstNormal;
    property MarqueeInterval: Integer read FMarqueeInterval write SetMarqueeInterval default 10;
{$ENDIF}
  end;


implementation

uses sMessages, sStyleSimply, sVclUtils, sGraphUtils, acntUtils, sAlphaGraph, sSkinProps, CommCtrl{$IFDEF DELPHI7UP}, Themes{$ENDIF};


const
  iNdent = 2;


procedure TsProgressBar.AfterConstruction;
begin
  inherited;
  FCommonData.Loaded;
end;


function TsProgressBar.ClRect: TRect;
begin
  Result := MkRect(Width, Height);
  InflateRect(Result, -1, -1);
end;


constructor TsProgressBar.Create(AOwner: TComponent);
begin
  FCommonData := TsCommonData.Create(Self, False);
  FCommonData.COC := COC_TsGauge;
  inherited Create(AOwner);
  FMarqSize := 40;
  FMarqStep := 8;
  FOldCount := -1;
{$IFNDEF D2009}
  FMarqueeInterval := 10;
  FStyle := pbstNormal;
{$ENDIF}
  ControlStyle := ControlStyle + [csOpaque];
  Timer := TTimer.Create(Self);
  Timer.Enabled := False;
  Timer.Interval := 30;
  Timer.OnTimer := TimerAction;
  FOrient := 1;
end;


destructor TsProgressBar.Destroy;
begin
  FreeAndNil(FCommonData);
  FreeAndNil(Timer);
  inherited Destroy;
end;


function TsProgressBar.ItemSize: TSize;
const
  prop = 0.66;
begin
  if Style = pbstMarquee then
    if Orientation = pbVertical then
      Result := MkSize(WidthOf(clRect) - BorderWidth * 2, 9)
    else
      Result := MkSize(9, HeightOf(clRect) - BorderWidth * 2)
  else
    if Orientation = pbVertical then begin
      Result.cx := WidthOf(clRect) - BorderWidth * 2;
      if Smooth then
        Result.cy := ProgressRect.Bottom
      else
        Result.cy := Round(Result.cx * prop) - Indent;
    end
    else begin
      Result.cy := HeightOf(clRect) - BorderWidth * 2;
      if Smooth then
        Result.cx := ProgressRect.Right
      else
        Result.cx := Round(Result.cy * prop) - Indent;
    end;
end;


procedure TsProgressBar.Loaded;
begin
  inherited;
  FCommonData.Loaded;
  if not (csDesigning in ComponentState) and (Style = pbstMarquee) and not Timer.Enabled then
    Timer.Enabled := True;
end;


procedure TsProgressBar.Paint;
var
  NewDC, SavedDC: hdc;
begin
  if (Width >= 0) or (Height >= 0) then begin
{$IFDEF D2009}
    if Style = pbstMarquee then
      Timer.Enabled := True;
{$ENDIF}

    if DC = 0 then
      NewDC := GetWindowDC(Handle)
    else
      NewDC := DC;

    SavedDC := SaveDC(NewDC);
    try
      if not InUpdating(FCommonData) then begin
        FCommonData.BGChanged := FCommonData.BGChanged or FCommonData.HalfVisible or GetBoolMsg(Parent, AC_GETHALFVISIBLE);
        FCommonData.HalfVisible := not RectInRect(Parent.ClientRect, BoundsRect);
        if FCommonData.BGChanged then
          PrepareCache;

        if FCommonData.FCacheBmp <> nil then begin
          UpdateCorners(FCommonData, 0);
          CopyWinControlCache(Self, FCommonData, MkRect, MkRect(Width, Height), NewDC, True);
          sVCLUtils.PaintControls(NewDC, Self, True, MkPoint);
        end;
      end;
    finally
      RestoreDC(NewDC, SavedDC);
      if DC = 0 then
        ReleaseDC(Handle, NewDC);
    end;
  end;
end;


procedure TsProgressBar.PrepareCache;
var
  si, i, d, c, value, w, h: integer;
  ci: TCacheInfo;
  prRect: TRect;
  Bmp: TBitmap;
  iSize: TSize;
begin
  if (Style <> pbstMarquee) and not Smooth then
    if (FCommonData.FCacheBmp <> nil) and (FCommonData.FCacheBmp.Width = Width) and (FCommonData.FCacheBmp.Height = Height) then begin
      iSize := ItemSize;
      if Orientation = pbHorizontal then begin
        w := WidthOf(clRect) - iNdent;
        c := w div (iSize.cx + iNdent);
      end
      else begin
        h := HeightOf(clRect) - iNdent;
        c := h div (iSize.cy + iNdent);
      end;

      if (c > 1) and (Max > Min) and (Position > Min) and (Max - Min <> 0) then
        value := Round(c / (Max - Min) * (Position - Min))
      else
        value := 0;

      if (value = FOldCount) and ((Position - Min) <> Max) then
        Exit
      else
        FOldCount := value;
    end;

  InitCacheBmp(FCommonData);
  PaintItem(FCommonData, GetParentCache(FCommonData), True, 0, MkRect(Self), Point(Left, Top), FCommonData.FCacheBMP, False);

  if Max > Min then begin
    with FCommonData.SkinManager do
      if ProgressSkin <> '' then
        si := GetSkinIndex(ProgressSkin)
      else
        if Orientation = pbVertical then
          si := ConstData.Sections[ssProgressV]
        else
          si := ConstData.Sections[ssProgressH];

    ci := MakeCacheInfo(FCommonData.FCacheBmp);
    prRect := ProgressRect;
    if (prRect.Right <= prRect.Left) or (prRect.Bottom <= prRect.Top) then
      Exit;

    iSize := ItemSize;
    if (iSize.cx < 2) or (iSize.cy < 2) then
      Exit;
    
    Bmp := CreateBmp32(iSize);
    if Style = pbstMarquee then begin
      d := 1;
      if Orientation = pbHorizontal then
        for i := 0 to 4 do begin
          c := prRect.Left + i * (iSize.cx + d);
          if c > Width then
            c := c - Width;

          PaintItem(si, ci, True, 0, MkRect(Bmp), Point(c, prRect.Top), Bmp, FCommonData.SkinManager);
          BitBlt(FCommonData.FCacheBmp.Canvas.Handle, c, prRect.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
        end
      else
        for i := 0 to 4 do begin
          c := prRect.Bottom - i * (iSize.cy + d) - iSize.cy;
          if c < 0 then
            c := Height + c;

          PaintItem(si, ci, True, 0, MkRect(Bmp), Point(prRect.Left, c), Bmp, FCommonData.SkinManager);
          BitBlt(FCommonData.FCacheBmp.Canvas.Handle, prRect.Left, c, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
        end;
    end
    else
      if Orientation = pbHorizontal then begin
        if Smooth then begin
          Bmp.Width := WidthOf(prRect);
          PaintItem(si, ci, True, 0, MkRect(Bmp), prRect.TopLeft, Bmp, FCommonData.SkinManager);
          BitBlt(FCommonData.FCacheBmp.Canvas.Handle, prRect.Left, prRect.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
        end
        else
          if (Max > Min) and (Position > Min) then begin
            w := WidthOf(clRect) - iNdent;
            c := w div (iSize.cx + iNdent);
            if c > 1 then begin
              d := (w - c * iSize.cx) div (c - 1);
              value := Round(c / (Max - Min) * (Position - Min));
              for i := 0 to value - 1 do begin
                PaintItem(si, ci, True, 0, MkRect(Bmp), Point(prRect.Left + i * (iSize.cx + d), prRect.Top), Bmp, FCommonData.SkinManager);
                BitBlt(FCommonData.FCacheBmp.Canvas.Handle, prRect.Left + i * (iSize.cx + d), prRect.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
              end;
              if (Value > 0) and (Position = Max) and (w - (Value - 1) * (iSize.cx + d) - iSize.cx > 3) then begin
                Bmp.Width := w - (Value - 1) * (iSize.cx + d) - iSize.cx;
                PaintItem(si, ci, True, 0, MkRect(Bmp), Point(prRect.Left + Value * (iSize.cx + d), prRect.Top), Bmp, FCommonData.SkinManager);
                BitBlt(FCommonData.FCacheBmp.Canvas.Handle, prRect.Left + (Value * (iSize.cx + d)), prRect.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
              end;
            end;
          end
      end
      else
        if Smooth then begin
          Bmp.Height := HeightOf(prRect);
          PaintItem(si, ci, True, 0, MkRect(Bmp), prRect.TopLeft, Bmp, FCommonData.SkinManager);
          BitBlt(FCommonData.FCacheBmp.Canvas.Handle, prRect.Left, prRect.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
        end
        else
          if (Max > Min) and (Position > Min) then begin
            h := HeightOf(clRect) - iNdent;
            c := h div (iSize.cy + iNdent);
            if c > 1 then begin
              d := (h - c * iSize.cy) div (c - 1);
              value := Round(c / (Max - Min) * (Position - Min));
              for i := 0 to value - 1 do begin
                PaintItem(si, ci, True, 0, MkRect(Bmp), Point(prRect.Left, prRect.Bottom - i * (iSize.cy + d) - iSize.cy), Bmp, FCommonData.SkinManager);
                BitBlt(FCommonData.FCacheBmp.Canvas.Handle, prRect.Left, prRect.Bottom - i * (iSize.cy + d) - iSize.cy, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
              end;
              if (Value > 0) and (Position = Max) and (h - (Value - 1) * (iSize.cy + d) - iSize.cy > 3) then begin
                Bmp.Height := HeightOf(clRect) - Value * (iSize.cy + d);
                PaintItem(si, ci, True, 0, MkRect(Bmp), prRect.TopLeft, Bmp, FCommonData.SkinManager);
                BitBlt(FCommonData.FCacheBmp.Canvas.Handle, prRect.Left, prRect.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
              end;
            end;
          end;

    FreeAndNil(Bmp);
  end;
end;


function TsProgressBar.ProgressRect: TRect;
begin
  Result := clRect;
  InflateRect(Result, -BorderWidth, -BorderWidth);
  if Style = pbstMarquee then
    if Orientation = pbVertical then begin
      Result.Bottom := round(Height - FMarqPos);
      Result.Top := Result.Bottom - FMarqSize;
    end
    else begin
      Result.Left := round(Result.Left + FMarqPos);
      Result.Right := Result.Left + FMarqSize;
    end
  else
    if Max <> Min then
      if Orientation = pbVertical then
        if Position = Max then
          Result.Top := Result.Left
        else
          Result.Top := Result.Bottom - Round(((Height - 2 * Result.Left) / (Max - Min)) * (Position - Min))
      else
        if Position = Max then
          Result.Right := Width - Result.Left
        else
          Result.Right := Round(((Width - 2 * Result.Left) / (Max - Min)) * (Position - Min));
end;


procedure TsProgressBar.SetProgressSkin(const Value: TsSkinSection);
begin
  if FProgressSkin <> Value then begin
    FProgressSkin := Value;
    FCommonData.Invalidate;
  end;
end;


{$IFNDEF D2009}
procedure TsProgressBar.SetMarqueeInterval(const Value: Integer);
{$IFDEF DELPHI7UP}
var
  MarqueeEnabled: Boolean;
{$ENDIF}
begin
  FMarqueeInterval := Value;
{$IFNDEF D2009}
{$IFDEF DELPHI7UP}
  if (FStyle = pbstMarquee) and ThemeServices.ThemesEnabled and CheckWin32Version(5, 1) and HandleAllocated then begin
    MarqueeEnabled := FStyle = pbstMarquee;
    SendMessage(Handle, WM_USER + 10{PBM_SETMARQUEE}, WPARAM(MarqueeEnabled), LPARAM(FMarqueeInterval));
    if Timer <> nil then
      Timer.Interval := 12;
  end;
{$ENDIF}
{$ENDIF}
end;


procedure TsProgressBar.SetStyle(const Value: TProgressBarStyle);
{$IFDEF DELPHI7UP}
var
  MarqueeEnabled: Boolean;
{$ENDIF}
begin
  if FStyle <> Value then begin
    FStyle := Value;
    if FStyle = pbstMarquee then begin
      FSavedPosition := Position;
      DoubleBuffered := False;
    end;
    Timer.Enabled := SkinData.Skinned and (FStyle = pbstMarquee);
{$IFDEF DELPHI7UP}
    if ThemeServices.ThemesEnabled and CheckWin32Version(5, 1) and HandleAllocated then begin
      MarqueeEnabled := FStyle = pbstMarquee;
      SendMessage(Handle, WM_USER + 10{PBM_SETMARQUEE}, WPARAM(THandle(MarqueeEnabled)), LPARAM(FMarqueeInterval));
    end;
{$ENDIF}
    RecreateWnd;
    if FStyle = pbstNormal then
      Position := FSavedPosition;
  end;
end;
{$ENDIF} // D2009


procedure TsProgressBar.WndProc(var Message: TMessage);
var
  PS: TPaintStruct;
begin
  if Message.Msg = SM_ALPHACMD then
    case Message.WParamHi of
      AC_CTRLHANDLED: begin
        Message.Result := 1;
        Exit;
      end; // AlphaSkins supported

      AC_REMOVESKIN:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          if Style = pbstMarquee then
            Timer.Enabled := False;

          CommonWndProc(Message, FCommonData);
          RedrawWindow(Handle, nil, 0, RDWA_NOCHILDRENNOW);
          Exit;
        end;

      AC_REFRESH:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          CommonWndProc(Message, FCommonData);
          Repaint;
          FOldCount := -1;
          Exit;
        end;

      AC_SETNEWSKIN:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          CommonWndProc(Message, FCommonData);
          if not (csDesigning in ComponentState) and (Style = pbstMarquee) then
            Timer.Enabled := True;

          FOldCount := -1;
          Exit;
        end;

      AC_ENDPARENTUPDATE:
        if FCommonData.Updating then begin
          FCommonData.Updating := False;
          Repaint;
          Exit;
        end;

      AC_GETBG:
        with PacBGInfo(Message.LParam)^ do begin
          Offset := MkPoint;
          Bmp := FCommonData.FCacheBmp;
          BgType := btCache;
          Exit;
        end;

      AC_GETDEFINDEX: begin
        if FCommonData.SkinManager <> nil then
          Message.Result := FCommonData.SkinManager.ConstData.Sections[ssGauge] + 1;

        Exit;
      end;
    end;

  if ControlIsReady(Self) and FCommonData.Skinned then begin
    case Message.Msg of
      PBM_SETPOS: begin
        if Style = pbstMarquee then
          Perform(WM_SETREDRAW, 0, 0);

        inherited;
        if Style = pbstMarquee then
          Perform(WM_SETREDRAW, 1, 0);

        Exit;
      end;

      WM_PRINT: begin
        SkinData.Updating := False;
        Paint(TWMPaint(Message).DC);
        Exit;
      end;

      WM_PAINT: begin
        BeginPaint(Handle, PS);
        Paint(TWMPaint(Message).DC);
        EndPaint(Handle, PS);
        Message.Result := 0;
        Exit;
      end;

      WM_SIZE, WM_MOVE, WM_WINDOWPOSCHANGED:
        FOldCount := -1;

      WM_NCPAINT: begin
        Message.Result := 0;
        Exit;
      end;

      WM_ERASEBKGND: begin
        Message.Result := 1;
        Exit;
      end;
    end;
    if CommonWndProc(Message, FCommonData) then
      Exit;
  end;
  inherited;
end;


procedure TsProgressBar.CreateParams(var Params: TCreateParams);
begin
  inherited;
{$IFNDEF D2009}
{$IFDEF DELPHI7UP}
  if (FStyle = pbstMarquee) and ThemeServices.ThemesEnabled and CheckWin32Version(5, 1) then
    Params.Style := Params.Style or 8{PBS_MARQUEE};
{$ENDIF}
{$ENDIF}
end;


procedure TsProgressBar.CreateWnd;
begin
  inherited;
{$IFDEF DELPHI7UP}
{$IFNDEF D2009}
  if ThemeServices.ThemesEnabled and CheckWin32Version(5, 1) and HandleAllocated then begin
    SendMessage(Handle, WM_USER + 10{PBM_SETMARQUEE}, WPARAM(THandle(FStyle = pbstMarquee)), LPARAM(FMarqueeInterval * 10));
    if Timer <> nil then
      Timer.Interval := 12;//FMarqueeInterval;
  end;
{$ENDIF}
{$ENDIF}
end;


procedure TsProgressBar.TimerAction(Sender: TObject);
var
  DC: hdc;
begin
  if SkinData.Skinned then begin
    if Visible then begin
      PrepareCache;
      DC := GetWindowDC(Handle);
      BitBlt(DC, 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
      ReleaseDC(Handle, DC);
      FMarqPos := FMarqPos + FOrient * FMarqStep * (18 / (MarqueeInterval + 27));
{$IFDEF D2009}
      if State = pbsError then begin
        if (FMarqPos >= Width - FMarqSize - BorderWidth - FMarqStep) or (FMarqPos <= BorderWidth) then
          FOrient := -1 * FOrient;
      end
      else
{$ENDIF}
        if FMarqPos >= Width - FMarqStep then
          FMarqPos := 0;
    end;
  end
  else
    Timer.Enabled := False;
end;

end.
