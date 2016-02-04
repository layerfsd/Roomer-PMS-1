unit sBorders;
{$I sDefs.inc}

interface

uses
  Windows, Graphics, Classes, SysUtils,
  sMaskData, sCommonData, sGraphUtils;


function PaintBorderFast(DC: hdc; aRect: TRect; MinBorderWidth: integer; SkinData: TsCommonData; State: integer): TRect; // New rect for filling is returned
procedure PaintRgnBorder(Bmp: TBitmap; Region: hrgn; Filling: boolean; MaskData: TsMaskData; State: integer);
procedure CopyMask(DstX1, DstY1, DstX2, DstY2, SrcX1, SrcY1, SrcX2, SrcY2: integer; Bmp: TBitmap; Region: hrgn; const MaskData: TsMaskData; FillRgn: boolean = False);


implementation

uses
  Math,
  acntUtils, sSkinManager, sConst, sAlphaGraph;


function PaintBorderFast(DC: hdc; aRect: TRect; MinBorderWidth: integer; SkinData: TsCommonData; State: integer): TRect;
var
  Color: TColor;
  l, t, r, b: integer;
  sm: TsSkinManager;
  ParentBG: TacBGInfo;
  CI: TCacheInfo;
begin
  Color := GetBGColor(SkinData, State); // Control BG color
  ParentBG.BgType := btUnknown;
  if (SkinData.FOwnerControl <> nil) and (SkinData.FOwnerControl.Parent <> nil) then begin // Get info about parent
    ParentBG.PleaseDraw := False;
    GetBGInfo(@ParentBG, SkinData.FOwnerControl.Parent);
  end; // Init parent BG data
  if SkinData.BorderIndex >= 0 then begin // if borders exists
    sm := SkinData.SkinManager;
    State := min(State, sm.gd[SkinData.SkinIndex].States - 1);
    InitCacheBmp(SkinData);
    if SkinData.SkinManager.ma[SkinData.BorderIndex].MaskType = 1 then
//      if ParentBG.BgType = btCache then begin
      if SkinData.CtrlSkinState and ACS_FAST <> ACS_FAST{ ParentBG.BgType = btCache} then begin
        if ParentBG.Bmp <> nil then begin
          l := max(SkinData.SkinManager.ma[SkinData.BorderIndex].WB, SkinData.SkinManager.ma[SkinData.BorderIndex].WL);
          l := max(l, SkinData.SkinManager.ma[SkinData.BorderIndex].WT);
          l := max(l, SkinData.SkinManager.ma[SkinData.BorderIndex].Wr);
          BitBltBorder(SkinData.FCacheBmp.Canvas.Handle, aRect.Left, aRect.Top, WidthOf(aRect), HeightOf(aRect),
                       ParentBG.Bmp.Canvas.Handle, ParentBG.Offset.X + SkinData.FOwnerControl.Left + aRect.Left,
                       ParentBG.Offset.Y + SkinData.FOwnerControl.Top + aRect.Top, l);
        end;
      end
      else
        FillDCBorder(SkinData.FCacheBmp.Canvas.Handle, aRect, sm.ma[SkinData.BorderIndex].WL, sm.ma[SkinData.BorderIndex].WT,
                     sm.ma[SkinData.BorderIndex].WR, sm.ma[SkinData.BorderIndex].WB, Color);

    CI := BGInfoToCI(@ParentBG);
    if SkinData.FOwnerControl <> nil then begin
      CI.X := CI.X + SkinData.FOwnerControl.Left;
      CI.Y := CI.Y + SkinData.FOwnerControl.Top;
    end;
    DrawSkinRect(SkinData.FCacheBmp, aRect, CI, SkinData.SkinManager.ma[SkinData.BorderIndex], State, True);
    if SkinData.FOwnerControl <> nil then begin
      CI.X := CI.X - SkinData.FOwnerControl.Left;
      CI.Y := CI.Y - SkinData.FOwnerControl.Top;
    end;
    Result := Rect(aRect.Left   + sm.ma[SkinData.BorderIndex].WL,
                   aRect.Top    + sm.ma[SkinData.BorderIndex].WT,
                   aRect.Right  - sm.ma[SkinData.BorderIndex].WR,
                   aRect.Bottom - sm.ma[SkinData.BorderIndex].WB);

    if MinBorderWidth <> 0 then begin
      l := max(min(MinBorderWidth, WidthOf(aRect)  - sm.ma[SkinData.BorderIndex].WR) - sm.ma[SkinData.BorderIndex].WL, 0);
      t := max(min(MinBorderWidth, HeightOf(aRect) - sm.ma[SkinData.BorderIndex].WB) - sm.ma[SkinData.BorderIndex].WT, 0);
      r := max(min(MinBorderWidth, WidthOf(aRect)  - sm.ma[SkinData.BorderIndex].WL) - sm.ma[SkinData.BorderIndex].WR, 0);
      b := max(min(MinBorderWidth, HeightOf(aRect) - sm.ma[SkinData.BorderIndex].WT) - sm.ma[SkinData.BorderIndex].WB, 0);
      FillDCBorder32(SkinData.FCacheBmp, Result, l, t, r, b, ColorToRGB(Color)); // Fill skipped parts
      Result := Rect(aRect.Left + MinBorderWidth, aRect.Top + MinBorderWidth, aRect.Right - MinBorderWidth, aRect.Bottom - MinBorderWidth);
      if Result.Right < Result.Left then
        Result.Right := Result.Left;

      if Result.Bottom < Result.Top then
        Result.Bottom := Result.Top;
    end;
    if SkinData.FCacheBmp.Canvas.Handle <> DC then
      if MinBorderWidth <> 0 then
        BitBltBorder(DC, aRect.Left, aRect.Top, WidthOf(aRect), HeightOf(aRect), SkinData.FCacheBmp.Canvas.Handle, aRect.Left, aRect.Top, MinBorderWidth);
  end
  else
    if MinBorderWidth <> 0 then begin
      FillDCBorder(DC, aRect, MinBorderWidth, MinBorderWidth, MinBorderWidth, MinBorderWidth, Color);
      InflateRect(aRect, MinBorderWidth, MinBorderWidth);
    end;
end;


procedure CopyMask(DstX1, DstY1, DstX2, DstY2, SrcX1, SrcY1, SrcX2, SrcY2: integer; Bmp: TBitmap; Region: hrgn; const MaskData: TsMaskData; FillRgn: boolean = False);
var
  D0, D, M: PRGBAArray;
  S0, S: PRGBAArray_RGB;
  DeltaS, DeltaD: integer;
  X, Y, h, w, MaskH, MaskHd2, MaskBmpHeight: Integer;
  RegRect: TRect;
  fr: hrgn;
  BmpSrc: TBitmap;
  msk: TsColor_;
begin
  if (DstX1 >= 0) and (DstX2 >= 0) and (DstY1 >= 0) and (DstY2 >= 0) and (Bmp.Height > 1) and (Bmp.Width > 1) and (MaskData.Manager <> nil) then begin
    if MaskData.Bmp = nil then
      BmpSrc := TsSkinManager(MaskData.Manager).MasterBitmap
    else
      BmpSrc := MaskData.Bmp;

    if InitLine(BmpSrc, Pointer(S0), DeltaS) and InitLine(Bmp, Pointer(D0), DeltaD) then
      if MaskData.MaskType = 1 then begin
        MaskH := HeightOf(MaskData.R);
        MaskBmpHeight := BmpSrc.Height - 1;
        MaskHd2 := MaskH div 2;

        h := Min(DstY2 - DstY1, Bmp.Height - DstY1);
        h := Min(h, MaskBmpHeight - SrcY1);
        h := Min(SrcY2 - SrcY1, h);
        w := Min(DstX2 - DstX1, SrcX2 - SrcX1);
        RegRect := Rect(-1, 0, 0, 0);
        if FillRgn then
          for Y := 0 to h do begin
            S := Pointer(LongInt(S0) + DeltaS * (SrcY1 + Y));
            D := Pointer(LongInt(D0) + DeltaD * (DstY1 + Y));
            M := Pointer(LongInt(S0) + DeltaS * (SrcY1 + MaskHd2 + Y));
            for X := 0 to w do
              with S^[SrcX1 + X] do
                if Col = clFuchsia then begin // If transparent pixel..
                  if (Region <> 0) then
                    if RegRect.Left <> -1 then
                      inc(RegRect.Right)
                    else begin
                      RegRect.Left   := DstX1 + X;
                      RegRect.Right  := RegRect.Left + 1;
                      RegRect.Top    := DstY1 + Y;
                      RegRect.Bottom := RegRect.Top + 1;
                    end;
                end
                else begin
                  if (RegRect.Left <> -1) and (Region <> 0) then begin
                    fr := CreateRectRgn(RegRect.Left, RegRect.Top, RegRect.Right, RegRect.Bottom);
                    CombineRgn(Region, Region, fr, RGN_XOR);
                    DeleteObject(fr);
                    RegRect.Left := -1;
                  end;
                  with D^[DstX1 + X] do begin
                    msk := M^[SrcX1 + X];
                    R := ((R - Red  ) * msk.R + Red   shl 8) shr 8;
                    G := ((G - Green) * msk.G + Green shl 8) shr 8;
                    B := ((B - Blue ) * msk.B + Blue  shl 8) shr 8;
                  end;
                end;

            if (RegRect.Left <> -1) and (Region <> 0) then begin
              fr := CreateRectRgn(RegRect.Left, RegRect.Top, RegRect.Right, RegRect.Bottom);
              CombineRgn(Region, Region, fr, RGN_DIFF);
              DeleteObject(fr);
              RegRect.Left := -1;
            end;
          end
          else
            for Y := 0 to h do begin
              S := Pointer(LongInt(S0) + DeltaS * (SrcY1 + Y));
              D := Pointer(LongInt(D0) + DeltaD * (DstY1 + Y));
              M := Pointer(LongInt(S0) + DeltaS * (SrcY1 + MaskHd2 + Y));
              for X := 0 to w do begin
                msk := M^[SrcX1 + X];
                with D^[DstX1 + X], S^[SrcX1 + X] do begin
                  R := ((R - Red  ) * msk.R + Red   shl 8) shr 8;
                  G := ((G - Green) * msk.G + Green shl 8) shr 8;
                  B := ((B - Blue ) * msk.B + Blue  shl 8) shr 8;
                end;
              end;
            end;
      end
      else begin
        h := Min(DstY2 - DstY1, Bmp.Height - DstY1);
        h := Min(SrcY2 - SrcY1, h);
        w := Min(DstX2 - DstX1, SrcX2 - SrcX1);
        RegRect := Rect(-1, 0, 0, 0);
        if FillRgn then
          for Y := 0 to h do begin
            S := Pointer(LongInt(S0) + DeltaS * (SrcY1 + Y));
            D := Pointer(LongInt(D0) + DeltaD * (DstY1 + Y));
            for X := 0 to w do
              with S^[SrcX1 + X] do
                if Col = sFuchsia.C then begin // If transparent pixel..
                  if (Region <> 0) then
                    if RegRect.Left <> -1 then
                      inc(RegRect.Right)
                    else begin
                      RegRect.Left := DstX1 + X;
                      RegRect.Right := RegRect.Left + 1;
                      RegRect.Top := DstY1 + Y;
                      RegRect.Bottom := RegRect.Top + 1;
                    end;
                end
                else begin
                  if (RegRect.Left <> -1) and (Region <> 0) then begin
                    fr := CreateRectRgn(RegRect.Left, RegRect.Top, RegRect.Right, RegRect.Bottom);
                    CombineRgn(Region, Region, fr, RGN_XOR);
                    DeleteObject(fr);
                    RegRect.Left := -1;
                  end;
                  D^[DstX1 + X].C := Col;
                end;

            if (RegRect.Left <> -1) and (Region <> 0) then begin
              fr := CreateRectRgn(RegRect.Left, RegRect.Top, RegRect.Right, RegRect.Bottom);
              CombineRgn(Region, Region, fr, RGN_DIFF);
              DeleteObject(fr);
              RegRect.Left := -1;
            end;
          end
        else
          for Y := 0 to h do begin
            S := Pointer(LongInt(S0) + DeltaS * (SrcY1 + Y));
            D := Pointer(LongInt(D0) + DeltaD * (DstY1 + Y));
            for X := 0 to w do
              D^[DstX1 + X].C := S^[SrcX1 + X].Col;
          end;
      end;
  end;
end;


procedure PaintRgnBorder(Bmp: TBitmap; Region: hrgn; Filling: boolean; MaskData: TsMaskData; State: integer);
var
  x, y: integer;
  w, h: integer;
  dw, dh, pw, dhm: integer;
  wl, wt, wr, wb: integer;
  BmpSrc: TBitmap;
  Stretch: boolean;
begin
  if (Bmp.Width > 1) and (Bmp.Height > 1) and (MaskData.Manager <> nil) then begin
    wl := MaskData.WL;
    wt := MaskData.WT;
    wr := MaskData.WR;
    wb := MaskData.WB;
    if wl + wr > Bmp.Width then begin
      x := ((wl + wr) - Bmp.Width) div 2;
      dec(wl, x);
      dec(wr, x);
      if Bmp.Width mod 2 > 0 then
        dec(wr);

      if wl < 0 then
        wl := 0;

      if wr < 0 then
        wr := 0;
    end;
    if wt + wb > Bmp.Height then begin
      x := ((wt + wb) - Bmp.Height) div 2;
      dec(wt, x);
      dec(wb, x);
      if Bmp.Height mod 2 > 0 then
        dec(wb);

      if wt < 0 then
        wt := 0;

      if wb < 0 then
        wb := 0;
    end;
    if MaskData.ImageCount < 1 then begin
      MaskData.ImageCount := 1;
      MaskData.R := MkRect(MaskData.Bmp);
    end;
    if State >= MaskData.ImageCount then
      State := MaskData.ImageCount - 1;
    
    pw := WidthOf(MaskData.R) div MaskData.ImageCount;        // Width of mask
    if MaskData.MaskType = 0 then begin
      dh := HeightOf(MaskData.R);
      dhm := 0;
    end
    else begin
      dh := HeightOf(MaskData.R) div (1 + MaskData.MaskType); // Height of mask
      dhm := dh;
    end;
    w := pw - MaskData.WL - MaskData.WR;
    if w < 0 then
      w := 0;                                                 // Width of middle piece

    h := dh - MaskData.WT - MaskData.WB;
    if h < 0 then
      h := 0;                                                 // Height of middle piece

    dw := MaskData.R.Left + pw * State;                       // Offset of mask
    if MaskData.Bmp = nil then
      BmpSrc := TsSkinManager(MaskData.Manager).MasterBitmap
    else
      BmpSrc := MaskData.Bmp;

    if MaskData.DrawMode and BDM_STRETCH = BDM_STRETCH then begin
      Stretch := True;
      SetStretchBltMode(Bmp.Canvas.Handle, COLORONCOLOR);
    end
    else
      Stretch := False;

    // left - top
    CopyMask(0, 0, wl - 1, wt - 1, dw, MaskData.R.Top, dw + wl - 1, MaskData.R.Top + wt - 1, Bmp, Region, MaskData, True);
    // left - bottom
    CopyMask(0, Bmp.Height - wb, wl - 1, Bmp.Height - 1, dw, MaskData.R.Top + dh - wb, dw + MaskData.WL - 1, MaskData.R.Top + dh - 1, Bmp, Region, MaskData, True);
    // left - middle
    if h > 0 then begin
      y := wt;
      if Stretch then
        StretchBltMask(0, y, wl, Bmp.Height - wb - wt, dw, MaskData.R.Top + wt, wl, h, Bmp, BmpSrc, dhm)
      else begin
        while y < Bmp.Height - h - wb do begin
          CopyMask(0, y, wl - 1, y + h - 1, dw, MaskData.R.Top + wt, MaskData.R.Left + dw + wl - 1, MaskData.R.Top + wt + h - 1, Bmp, Region, MaskData, False);
          inc(y, h);
        end;
        if y < Bmp.Height - wb then
          CopyMask(0, y, wl - 1, Bmp.Height - wb - 1,  dw, MaskData.R.Top + wt, dw + wl - 1, MaskData.R.Top + wt + h - 1, Bmp, Region, MaskData, False);
      end;
    end;
    // top - middle
    if w > 0 then begin
      x := wl;
      if Stretch then
        StretchBltMask(x, 0, Bmp.Width - wr - x, wt, dw + wl, MaskData.R.Top, w, wt, Bmp, BmpSrc, dhm)
      else begin
        while x < Bmp.Width - w - wr do begin
          CopyMask(x, 0, x + w - 1, wt - 1, dw + wl, MaskData.R.Top, dw + w + wl - 1, MaskData.R.Top + wt - 1, Bmp, Region, MaskData, False);
          inc(x, w);
        end;
        if x < Bmp.Width - wr then
          CopyMask(x, 0, Bmp.Width - wr - 1, wt - 1, dw + wl, MaskData.R.Top, dw + w + wl - 1, MaskData.R.Top + wt - 1, Bmp, Region, MaskData, False);
      end;
    end;
    // bottom - middle
    if w > 0 then begin
      x := wl;
      if Stretch then
        StretchBltMask(x, Bmp.Height - wb, Bmp.Width - wr - x, wb, dw + wl, MaskData.R.Top + dh - wb, w, wb, Bmp, BmpSrc, dhm)
      else begin
        while x < Bmp.Width - w - wr do begin
          CopyMask(x, Bmp.Height - wb, x + w - 1, Bmp.Height - 1, dw + wl, MaskData.R.Top + dh - wb, dw + w + wl - 1, MaskData.R.Top + dh - 1, Bmp, Region, MaskData, False);
          inc(x, w);
        end;
        if x < Bmp.Width - wr then
          CopyMask(x, Bmp.Height - wb, Bmp.Width - wr - 1, Bmp.Height - 1, dw + wl, MaskData.R.Top + dh - wb, dw + w + wl - 1, MaskData.R.Top + dh - 1, Bmp, Region, MaskData, False);
      end;
    end;
    // right - middle
    if h > 0 then begin
      y := wt;
      if Stretch then
        StretchBltMask(Bmp.Width - wr, y, wr, Bmp.Height - wb - y, dw + w + wl, MaskData.R.Top + wt, wr, h, Bmp, BmpSrc, dhm)
      else begin
        while y < Bmp.Height - h - wb do begin
          CopyMask(Bmp.Width - wr, y, Bmp.Width - 1, y + h - 1, dw + pw - wr, MaskData.R.Top + wt, dw + pw - 1, MaskData.R.Top + h + wt - 1, Bmp, Region, MaskData, False);
          inc(y, h);
        end;
        if y < Bmp.Height - wb then
          CopyMask(Bmp.Width - wr, y, Bmp.Width - 1, Bmp.Height - wb - 1, dw + pw - wr, MaskData.R.Top + wt, dw + pw - 1, MaskData.R.Top + h + wt - 1, Bmp, Region, MaskData, False);
      end;
    end;
    // right - bottom
    CopyMask(Bmp.Width - wr, Bmp.Height - wb, Bmp.Width - 1, Bmp.Height - 1, dw + pw - wr, MaskData.R.Top + dh - wb, dw + pw - 1, MaskData.R.Top + dh - 1, Bmp, Region, MaskData, True);
    // right - top
    CopyMask(Bmp.Width - wr, 0, Bmp.Width - 1, wt - 1, dw + pw - wr, MaskData.R.Top, dw + pw - 1, MaskData.R.Top + wt - 1, Bmp, Region, MaskData, True);
    // Fill
    if Filling and (MaskData.DrawMode and BDM_FILL = BDM_FILL) and (h > 0) and (w > 0) then
      if Stretch then
        StretchBltMask(wl, wt, Bmp.Width - wr - wl, Bmp.Height - wb - wt, dw + wl, MaskData.R.Top + wt, w, h, Bmp, BmpSrc, dhm, True)
      else begin
        y := wt;
        while y < Bmp.Height - h - wb do begin
          x := wl;
          while x < Bmp.Width - w - wr do begin
            CopyMask(x, y, x + w - 1, y + h - 1, dw + wl, MaskData.R.Top + wt, dw + w + wl - 1, MaskData.R.Top + h + wt - 1, Bmp, Region, MaskData, False);
            inc(x, w);
          end;
          if x < Bmp.Width - wr then
            CopyMask(x, y, Bmp.Width - wr - 1, y + h - 1, dw + wl, MaskData.R.Top + wt, dw + w + wl - 1, MaskData.R.Top + h + wt - 1, Bmp, Region, MaskData, False);

          inc(y, h);
        end;
        x := wl;
        if y < Bmp.Height - wb then begin
          while x < Bmp.Width - w - wr do begin
            CopyMask(x, y, x + w - 1, Bmp.Height - wb - 1, dw + wl - 1, MaskData.R.Top + wt, dw + w + wl - 1, MaskData.R.Top + h + wt - 1, Bmp, Region, MaskData, False);
            inc(x, w);
          end;
          if x < Bmp.Width - wr then
            CopyMask(x, y, Bmp.Width - wr - 1, Bmp.Height - wb - 1, dw + wl - 1, MaskData.R.Top + wt, dw + w + wl - 1, MaskData.R.Top + h + wt - 1, Bmp, Region, MaskData, False);
        end;
      end;
  end;
end;

end.
