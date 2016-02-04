unit acCoolBar;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ToolWin, ComCtrls,
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  sCommonData;


type
{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsCoolBar = class(TCoolBar)
{$IFNDEF NOTFORHELP}
  private
    FGripIndex: integer;
    FGripsection: string;
    FGripTexture: integer;
    FCommonData: TsCommonData;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMNCPaint (var Message: TWMNCPaint); message WM_NCPAINT;
    procedure ACPaint(DC: HDC = 0; SendUpdated: boolean = True);
    function PrepareCache: boolean;
    function GetCaptionSize(Band: TCoolBand): Integer;
    function GetGripSize   (Band: TCoolBand): integer;
    function GetCaptionFontHeight: Integer;
    procedure UpdateGripIndex;
  public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure Loaded; override;
    procedure WndProc (var Message: TMessage); override;
  published
{$ENDIF} // NOTFORHELP
    property SkinData: TsCommonData read FCommonData write FCommonData;
  end;


implementation

uses
  ImgList, math,
  acntUtils, sGraphUtils, sAlphaGraph, sVCLUtils, sMessages, sConst, sStyleSimply, sSkinProps;


procedure TsCoolBar.ACPaint;
var
  b: boolean;
  NewDC: HDC;
  RW, RC: TRect;
  i: integer;
  SavedDC: hdc;
  R, CaptRect: TRect;
  CaptSize: integer;

  procedure PaintGrips;
  var
    i: integer;
    Band: TCoolBand;
    CI: TCacheInfo;
    DesignText: boolean;
    TempBmp: TBitmap;
    rText: TRect;
    GripSize: integer;
  begin
    CI := MakeCacheInfo(FCommonData.FCacheBmp, ACClientRect(Handle).Left, ACClientRect(Handle).Top);
    for i := 0 to Bands.Count - 1 do
      if Assigned(Bands[i].Control) and ((csDesigning in ComponentState) or Bands[i].Visible) then begin
        Band := Bands[I];
        CaptSize := GetCaptionSize(Band);
        GripSize := GetGripSize(Band);
        if Vertical then begin
          CaptRect.TopLeft := Point(min(Band.Control.Left - (Band.Height - Band.Control.Width) div 2, Band.Control.Left),
                                    Band.Control.Top - CaptSize);
          CaptRect.BottomRight := Point(CaptRect.Left + Band.Height, CaptRect.Top + CaptSize);
          TempBmp := CreateBmp32(Band.Height, CaptSize);
          BitBlt(TempBmp.Canvas.Handle, 0, 0, TempBmp.Width, TempBmp.Height, FCommonData.FCacheBmp.Canvas.Handle, CaptRect.Left + CI.X, CaptRect.Top + CI.Y, SRCCOPY);
          if FGripIndex <> -1 then
            PaintItem(FGripIndex, Ci, True, 0,
                      MkRect(Band.Height, GripSize - 2), Point(CaptRect.Left, CaptRect.Top),
                      TempBmp, SkinData.SkinManager, FGripTexture);

          rText := CaptRect;
          OffsetRect(rText, -rText.Left, -rText.Top);
          inc(rText.Top, GripSize);
          if Assigned(Images) and (Band.ImageIndex > -1) then begin
            Images.DrawingStyle := dsTransparent;
            Images.Draw(TempBmp.Canvas, (WidthOf(CaptRect) - Images.Width) div 2, GripSize, Band.ImageIndex);
            inc(rText.Top, Images.Height + 2);
          end;

          DesignText := (csDesigning in ComponentState) and (Band.Control = nil) and (Band.Text = '');
          if ShowText or DesignText then begin
            if DesignText then
              Text := Band.DisplayName
            else
              Text := Band.Text;
            
            if Text <> '' then begin
              TempBMP.Canvas.Font.Assign(Font);
              WriteTextEx(TempBMP.Canvas, PChar(Text), True, rText, DT_EXPANDTABS or DT_SINGLELINE or DT_VCENTER, FCommonData, False);
            end;
          end;
        end
        else begin
          CaptRect.TopLeft := Point(Band.Control.Left - CaptSize,
                                    min(Band.Control.Top - (Band.Height - Band.Control.Height) div 2, Band.Control.Top));
          CaptRect.BottomRight := Point(CaptRect.Left + CaptSize, CaptRect.Top + Band.Height);
          TempBmp := CreateBmp32(CaptSize, Band.Height);
          BitBlt(TempBmp.Canvas.Handle, 0, 0, TempBmp.Width, TempBmp.Height, FCommonData.FCacheBmp.Canvas.Handle, CaptRect.Left + CI.X, CaptRect.Top + CI.Y, SRCCOPY);
          if FGripIndex <> -1 then
            PaintItem(FGripIndex, Ci, True, 0, MkRect(GripSize - 2, Band.Height), CaptRect.TopLeft, TempBmp, SkinData.SkinManager, FGripTexture);

          rText := CaptRect;
          OffsetRect(rText, -rText.Left, -rText.Top);
          inc(rText.Left, GripSize);
          if Assigned(Images) and (Band.ImageIndex > -1) then begin
            Images.DrawingStyle := dsTransparent;
            Images.Draw(TempBmp.Canvas, GripSize, (Band.Height - Images.Height) div 2, Band.ImageIndex);
            inc(rText.Left, Images.Width + 2);
          end;

          DesignText := (csDesigning in ComponentState) and (Band.Control = nil) and (Band.Text = '');
          if ShowText or DesignText then begin
            if DesignText then
              Text := Band.DisplayName
            else
              Text := Band.Text;

            if Text <> '' then begin
              TempBMP.Canvas.Font.Assign(Font);
              WriteTextEx(TempBMP.Canvas, PChar(Text), True, rText, DT_EXPANDTABS or DT_SINGLELINE or DT_VCENTER, FCommonData, False);
            end;
          end;
        end;
        R := Rect(1, 1, 1, 1);
        GetClipBox(NewDC, R);
        BitBlt(NewDC, CaptRect.Left, CaptRect.Top, TempBmp.Width, TempBmp.Height, TempBmp.Canvas.Handle, 0, 0, SRCCOPY);
        FreeAndNil(TempBmp);
      end;
  end;
begin
  if (csDestroying in ComponentState) or
       (csCreating in Parent.ControlState) or
         not Assigned(FCommonData) or
           not FCommonData.Skinned or
             not FCommonData.SkinManager.CommonSkinData.Active then
    Exit;

  if not InUpdating(FCommonData) then begin
    // If transparent and form resizing processed
    b := FCommonData.HalfVisible or FCommonData.BGChanged;

    if SkinData.RepaintIfMoved then begin
      FCommonData.HalfVisible := not (PtInRect(Parent.ClientRect, Point(Left + 1, Top + 1)));
      FCommonData.HalfVisible := FCommonData.HalfVisible or not PtInRect(Parent.ClientRect, Point(Left + Width - 1, Top + Height - 1));
    end
    else
      FCommonData.HalfVisible := False;

    if b then
      if not PrepareCache then
        Exit;

    UpdateCorners(FCommonData, 0);
    if DC <> 0 then NewDC := DC else Exit;
    Windows.GetClientRect(Handle, RC);
    GetWindowRect(Handle, RW);
    MapWindowPoints(0, Handle, RW, 2);
    OffsetRect(RC, -RW.Left, -RW.Top);


    SavedDC := SaveDC(NewDC);
    for i := 0 to Bands.Count - 1 do
      if Assigned(Bands[i].Control) and (Bands[i].Visible or (csDesigning in ComponentState)) then begin
        CaptSize := GetCaptionSize(Bands[i]);
        if Vertical then begin
          CaptRect.TopLeft := Point(min(Bands[i].Control.Left - (Bands[i].Height - Bands[i].Control.Width) div 2, Bands[i].Control.Left),
                                    Bands[i].Control.Top - CaptSize);
          CaptRect.BottomRight := Point(CaptRect.Left + Bands[i].Height, CaptRect.Top + CaptSize);
        end
        else begin
          CaptRect.TopLeft := Point(Bands[i].Control.Left - CaptSize,
                                    min(Bands[i].Control.Top - (Bands[i].Height - Bands[i].Control.Height) div 2, Bands[i].Control.Top));
          CaptRect.BottomRight := Point(CaptRect.Left + CaptSize, CaptRect.Top + Bands[i].Height);
        end;
        ExcludeClipRect(NewDC, CaptRect.Left, CaptRect.Top, CaptRect.Right, CaptRect.Bottom);
      end;

    R := Rect(1, 1, 1, 1);
    GetClipBox(NewDC, R);
    CopyWinControlCache(Self, FCommonData, Rect(RC.Left, RC.Top, 0, 0), MkRect(WidthOf(RC), HeightOf(RC)), NewDC, True);
    R := Rect(1, 1, 1, 1);
    GetClipBox(NewDC, R);
    RestoreDC(NewDC, SavedDC);
    R := Rect(1, 1, 1, 1);
    sVCLUtils.PaintControls(NewDC, Self, b and SkinData.RepaintIfMoved, MkPoint);
    PaintGrips;
    if SendUpdated then
      SetParentUpdated(Self);
  end;
end;


procedure TsCoolBar.AfterConstruction;
begin
  inherited;
  FCommonData.Loaded;
end;


constructor TsCoolBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCommonData := TsCommonData.Create(Self, True);
  FCommonData.COC := COC_TsCoolBar;
  UpdateGripIndex;
end;


destructor TsCoolBar.Destroy;
begin
  if Assigned(FCommonData) then
    FreeAndNil(FCommonData);

  inherited Destroy;
end;


function TsCoolBar.GetCaptionFontHeight: Integer;
var
  TxtMetric: TTextMetric;
begin
  Result := 0;
  if HandleAllocated then
    with TControlCanvas.Create do
      try
        Control := Self;
        if (GetTextMetrics(Handle, TxtMetric)) then
          Result := TxtMetric.tmHeight;
      finally
        Free;
      end;
end;


const
  GripSizeIE3 = 8;
  GripSizeIE4 = 5;
  ControlMargin = 4;
  IDMask = $7FFFFFFF;


function TsCoolBar.GetCaptionSize(Band: TCoolBand): Integer;
var
  Text: string;
  Adjust, DesignText: Boolean;
begin
  Result := 0;
  Adjust := False;
  if (Band <> nil) and ((csDesigning in ComponentState) or Band.Visible) then begin
    DesignText := (csDesigning in ComponentState) and (Band.Control = nil) and (Band.Text = '');
    if ShowText or DesignText then begin
      if DesignText then
        Text := Band.DisplayName
      else
        Text := Band.Text;

      if Text <> '' then begin
        Adjust := True;
        if Vertical then
          Result := GetCaptionFontHeight
        else
          with TControlCanvas.Create do
            try
              Control := Self;
              Result := TextWidth(Text)
            finally
              Free;
            end;
      end;
    end;
    if Band.ImageIndex >= 0 then begin
      if Adjust then
        Inc(Result, 2);
        
      if Images <> nil then begin
        Adjust := True;
        if Vertical then
          Inc(Result, Images.Height)
        else
          Inc(Result, Images.Width)
      end
      else
        if not Adjust then
          Inc(Result, ControlMargin);
    end;
    if Adjust then
      Inc(Result, ControlMargin);

    inc(Result, GetGripSize(Band));
  end;
end;


procedure TsCoolBar.Loaded;
begin
  inherited;
  FCommonData.Loaded;
  UpdateGripIndex;
end;


function TsCoolBar.PrepareCache: boolean;
var
  ParentBG: TacBGInfo;
begin
  ParentBG.PleaseDraw := False;
  GetBGInfo(@ParentBG, Parent);
  if ParentBG.BgType = btNotReady then begin
    SkinData.FUpdating := True;
    Result := False;
    Exit;
  end;
  InitCacheBmp(SkinData);
  PaintItem(FCommonData, GetParentCache(FCommonData), False, 0, MkRect(Self), MkPoint(Self), FCommonData.FCacheBMP, True);
  FCommonData.BGChanged := False;
  Result := True;
end;


procedure TsCoolBar.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  if not FCommonData.Skinned then
    inherited
  else
    Message.Result := 1;
end;


procedure TsCoolBar.WMNCPaint(var Message: TWMNCPaint);
var
  DC, SavedDC: HDC;
  RC, RW: TRect;
  w, h : integer;
begin
  if FCommonData.Skinned then begin
    if InAnimationProcess then
      Exit;

    if (csDestroying in ComponentState) or InUpdating(FCommonData) then
      Exit;

    DC := GetWindowDC(Handle);
    SavedDC := SaveDC(DC);
    try
      RC := ACClientRect(Handle);
      ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
      { Draw borders in non-client area }
      w := WidthOf(Rc);
      h := HeightOf(Rc);
      if FCommonData.BGChanged then
        if not PrepareCache then begin
          RestoreDC(DC, SavedDC);
          ReleaseDC(Handle, DC);
          Exit;
        end;
      // Top
      BitBlt(DC, 0, 0, Width, Rc.Top, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
      // Left
      BitBlt(DC, 0, Rc.Top, Rc.Left, h, SkinData.FCacheBmp.Canvas.Handle, 0, Rc.Top, SRCCOPY);
      // Bottom
      BitBlt(DC, 0, Rc.Bottom, Width, Height - h - Rc.Top, SkinData.FCacheBmp.Canvas.Handle, 0, Rc.Bottom, SRCCOPY);
      // Right
      BitBlt(DC, Rc.Right, Rc.Top, Width - Rc.Left - w, h, SkinData.FCacheBmp.Canvas.Handle, Rc.Right, Rc.Top, SRCCOPY);

      IntersectClipRect(DC, RW.Left, RW.Top, RW.Right, RW.Bottom);
    finally
      RestoreDC(DC, SavedDC);
      ReleaseDC(Handle, DC);
    end;
  end
  else
    inherited;
end;


procedure TsCoolBar.WMPaint(var Message: TWMPaint);
var
  PS: TPaintStruct;
  DC, SavedDC: hdc;
  cR: TRect;
begin
  if not FCommonData.Skinned then
    inherited
  else begin
    BeginPaint(Handle, PS);
    SavedDC := 0;

    if (Message.DC = 0) then begin
      DC := GetDC(Handle);
      SavedDC := SaveDC(DC);
    end
    else
      DC := Message.DC;

    try
      if not InAnimationProcess then begin
        cR := Rect(1, 1, 1, 1);
        GetClipBox(DC, cR);
        ACPaint(DC);
      end
    finally
      if Message.DC = 0 then begin
        RestoreDC(DC, SavedDC);
        ReleaseDC(Handle, DC);
      end;
      EndPaint(Handle, PS);
    end;
  end;
end;


procedure TsCoolBar.WndProc(var Message: TMessage);
var
  rc: TRect;
  i, w, h: integer;
  SavedDC: hdc;
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_CTRLHANDLED: begin
          Message.Result := 1;
          Exit
        end; // AlphaSkins supported

        AC_GETAPPLICATION: begin
          Message.Result := LRESULT(Application);
          Exit
        end;

        AC_REMOVESKIN:
          if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
            CommonWndProc(Message, FCommonData);
            UpdateGripIndex;
            if not (csDesigning in ComponentState) and (uxthemeLib <> 0) then
              Ac_SetWindowTheme(Handle, nil, nil);

            if HandleAllocated then
              RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_ERASE or RDW_FRAME or RDW_UPDATENOW);

            AlphaBroadCast(Self, Message);
            Exit
          end;

        AC_SETNEWSKIN:
          if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
            if not (csDesigning in ComponentState) and (uxthemeLib <> 0) then
              Ac_SetWindowTheme(Handle, s_Space, s_Space);

            AlphaBroadCast(Self, Message);
            CommonWndProc(Message, FCommonData);
            UpdateGripIndex;
            Exit
          end;

        AC_REFRESH:
          if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
            if not (csDesigning in ComponentState) and (uxthemeLib <> 0) then
              Ac_SetWindowTheme(Handle, s_Space, s_Space);

            CommonMessage(Message, FCommonData);
            PrepareCache;
            Change;
            RedrawWindow(Handle, nil, 0, RDW_ERASE or RDW_FRAME or RDW_ALLCHILDREN or RDW_INVALIDATE or RDW_UPDATENOW);
            for i := 0 to Bands.Count - 1 do
              TCoolBand(Bands[I]).Control.Perform(Message.Msg, Message.WParam, Message.LParam);

            AlphaBroadCast(Self, Message);
            Exit
          end;

        AC_GETCACHE: begin
          PacBGInfo(Message.LParam)^.Offset := MkPoint;
          InitBGInfo(FCommonData, PacBGInfo(Message.LParam), 0);
          PacBGInfo(Message.LParam)^.Offset.X := ACClientRect(Handle).Left;
          PacBGInfo(Message.LParam)^.Offset.Y := ACClientRect(Handle).Top;
          Exit;
        end;

        AC_GETBG: begin
          InitBGInfo(FCommonData, PacBGInfo(Message.LParam), 0);
          PacBGInfo(Message.LParam)^.Offset.X := PacBGInfo(Message.LParam)^.Offset.X + ACClientRect(Handle).Left;
          PacBGInfo(Message.LParam)^.Offset.Y := PacBGInfo(Message.LParam)^.Offset.Y + ACClientRect(Handle).Top;
          if (PacBGInfo(Message.LParam)^.BgType = btFill) and (PacBGInfo(Message.LParam)^.Bmp <> nil) then begin
            PacBGInfo(Message.LParam).FillRect.Left := PacBGInfo(Message.LParam)^.Offset.X - PacBGInfo(Message.LParam).FillRect.Left;
            PacBGInfo(Message.LParam).FillRect.Top := PacBGInfo(Message.LParam)^.Offset.Y - PacBGInfo(Message.LParam).FillRect.Top;
          end;
          Exit;
        end;

        AC_ENDPARENTUPDATE: begin
          FCommonData.Updating := False;
          FCommonData.BGChanged := True;
          RedrawWindow(Handle, nil, 0, RDW_UPDATENOW or RDW_ERASE or RDW_INVALIDATE or RDW_INTERNALPAINT or RDW_ERASENOW or RDW_FRAME);
          SetParentUpdated(Self);
        end;

        AC_GETDEFINDEX: begin
          if FCommonData.SkinManager <> nil then
            Message.Result := FCommonData.SkinManager.ConstData.Sections[ssToolBar] + 1;

          Exit;
        end;

        AC_PREPARING: begin
          Message.Result := integer(FCommonData.FUpdating);
          Exit;
        end

        else
          if CommonMessage(Message, FCommonData) then
            Exit;
      end;

    CM_VISIBLECHANGED: begin
      FCommonData.BGChanged := True;
      inherited;
      if not FCommonData.Updating then
        Repaint;

      Exit;
    end;

    WM_KILLFOCUS, WM_SETFOCUS: begin
      inherited;
      Exit
    end;

    WM_PRINT: begin
      FCommonData.Updating := False;
      FCommonData.BGChanged := True;
      try
        RC := ACClientRect(Handle);
        w := WidthOf(Rc);
        h := HeightOf(Rc);
        if FCommonData.BGChanged and not PrepareCache then
          Exit;
        // Top
        BitBlt(TWMPaint(Message).DC, 0, 0, Width, Rc.Top, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
        // Left
        BitBlt(TWMPaint(Message).DC, 0, Rc.Top, Rc.Left, h, SkinData.FCacheBmp.Canvas.Handle, 0, Rc.Top, SRCCOPY);
        // Bottom
        BitBlt(TWMPaint(Message).DC, 0, Rc.Bottom, Width, Height - h - Rc.Top, SkinData.FCacheBmp.Canvas.Handle, 0, Rc.Bottom, SRCCOPY);
        // Right
        BitBlt(TWMPaint(Message).DC, Rc.Right, Rc.Top, Width - Rc.Left - w, h, SkinData.FCacheBmp.Canvas.Handle, Rc.Right, Rc.Top, SRCCOPY);
        MoveWindowOrg(TWMPaint(Message).DC, Rc.Left, Rc.Top);
        IntersectClipRect(TWMPaint(Message).DC, 0, 0, w, h);
        ACPaint(TWMPaint(Message).DC);
        for i := 0 to Bands.Count - 1 do
          if Bands[i].Control <> nil then begin
            SavedDC := SaveDC(TWMPaint(Message).DC);
            MoveWindowOrg(TWMPaint(Message).DC, Bands[i].Control.Left, Bands[i].Control.Top);
            IntersectClipRect(TWMPaint(Message).DC, 0, 0, Bands[i].Control.Width, Bands[i].Control.Height);
            Bands[i].Control.Perform(WM_PAINT, Message.WParam, Message.LParam);
            RestoreDC(TWMPaint(Message).DC, SavedDC);
          end;
      finally
        //
      end;
      Exit;
    end;
  end;
  CommonWndProc(Message, FCommonData);
  inherited;
  if (FCommonData <> nil) and FCommonData.Skinned then
    case Message.Msg of
      WM_SIZE: begin
        FCommonData.BGChanged := True;
        RedrawWindow(Handle, nil, 0, RDW_UPDATENOW or RDW_ERASE or RDW_INVALIDATE or RDW_INTERNALPAINT or RDW_ERASENOW or RDW_FRAME);
      end;
    end;
end;


function TsCoolBar.GetGripSize(Band: TCoolBand): integer;
begin
  Result := 0;
  if (not FixedOrder or (Band.ID and IDMask > 0)) and not Band.FixedSize then begin
    Inc(Result, ControlMargin);
    if GetComCtlVersion < ComCtlVersionIE4 then
      Inc(Result, GripSizeIE3)
    else
      Inc(Result, GripSizeIE4);
  end;
end;


procedure TsCoolBar.UpdateGripIndex;
begin
  if FCommonData.Skinned then begin
    if Vertical then
      FGripsection := s_GripV
    else
      FGripsection := s_GripH;

    FGripIndex := SkinData.SkinManager.GetSkinIndex(FGripsection);
    if FGripIndex <> -1 then
      FGripTexture := SkinData.SkinManager.GetTextureIndex(FGripIndex, FGripsection, s_Pattern)
    else begin
      FGripsection := s_ProgressV;
      FGripIndex := SkinData.SkinManager.GetSkinIndex(FGripsection);
      FGripTexture := -1;
    end;
  end
  else begin
    FGripIndex := -1;
    FGripTexture := -1;
  end;
end;

end.
