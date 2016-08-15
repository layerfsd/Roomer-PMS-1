unit sBorders;
{$I sDefs.inc}

interface

uses
  Windows, Graphics, Classes, SysUtils,
  sMaskData, sCommonData, sGraphUtils;


function PaintBorderFast(DC: hdc; aRect: TRect; MinBorderWidth: integer; SkinData: TsCommonData; State: integer): TRect; // New rect for filling is returned
procedure PaintRgnBorder(aBmp: TBitmap; Region: hrgn; Filling: boolean; MaskData: TsMaskData; State: integer);
procedure CopyMask(DstX1, DstY1, DstX2, DstY2, SrcX1, SrcY1, SrcX2, SrcY2: integer; aBmp: TBitmap; Region: hrgn; const MaskData: TsMaskData; FillRgn: boolean = False);


implementation

uses
  Math,
  acntUtils, sSkinManager, sConst, sAlphaGraph;


function PaintBorderFast(DC: hdc; aRect: TRect; MinBorderWidth: integer; SkinData: TsCommonData; State: integer): TRect;
var
  w, h, l, t, rr, b: integer;
  ParentBG: TacBGInfo;
  CI: TCacheInfo;
  Color: TColor;
begin
  Color := GetBGColor(SkinData, State); // Control BG color
  ParentBG.BgType := btUnknown;
  with SkinData, aRect do begin
    if (FOwnerControl <> nil) and (FOwnerControl.Parent <> nil) then begin // Get info about parent
      ParentBG.PleaseDraw := False;
      GetBGInfo(@ParentBG, FOwnerControl.Parent);
    end; // Init parent BG data
    if BorderIndex >= 0 then
      with SkinManager, ma[SkinData.BorderIndex] do begin // if borders exists
        State := min(State, gd[SkinIndex].States - 1);
        InitCacheBmp(SkinData);
        if MaskType = 1 then
          if CtrlSkinState and ACS_FAST = 0 then begin
            if ParentBG.Bmp <> nil then begin
              l := max(WB, WL);
              l := max(l, WT);
              l := max(l, WR);
              BitBltBorder(FCacheBmp.Canvas.Handle, Left, Top, WidthOf(aRect), HeightOf(aRect),
                           ParentBG.Bmp.Canvas.Handle, ParentBG.Offset.X + FOwnerControl.Left + Left,
                           ParentBG.Offset.Y + FOwnerControl.Top + Top, l);
            end;
          end
          else
            FillDCBorder(FCacheBmp.Canvas.Handle, aRect, WL, WT, WR, WB, Color);

        CI := BGInfoToCI(@ParentBG);
        if SkinData.FOwnerControl <> nil then begin
          CI.X := CI.X + FOwnerControl.Left;
          CI.Y := CI.Y + FOwnerControl.Top;
        end;
        DrawSkinRect(FCacheBmp, aRect, CI, ma[BorderIndex], State, True);
        if FOwnerControl <> nil then begin
          CI.X := CI.X - FOwnerControl.Left;
          CI.Y := CI.Y - FOwnerControl.Top;
        end;
        Result := Rect(Left + WL, Top + WT, Right - WR, Bottom - WB);
        w := WidthOf(aRect);
        h := HeightOf(aRect);
        if MinBorderWidth <> 0 then begin
          l  := max(min(MinBorderWidth, w - WR) - WL, 0);
          t  := max(min(MinBorderWidth, h - WB) - WT, 0);
          rr := max(min(MinBorderWidth, w - WL) - WR, 0);
          b  := max(min(MinBorderWidth, h - WT) - WB, 0);
          FillDCBorder32(FCacheBmp, Result, l, t, rr, b, ColorToRGB(Color)); // Fill skipped parts
          Result := Rect(Left + MinBorderWidth, Top + MinBorderWidth, Right - MinBorderWidth, Bottom - MinBorderWidth);
          if Result.Right < Result.Left then
            Result.Right := Result.Left;

          if Result.Bottom < Result.Top then
            Result.Bottom := Result.Top;
        end;
        if FCacheBmp.Canvas.Handle <> DC then
          if MinBorderWidth <> 0 then
            BitBltBorder(DC, Left, Top, w, h, FCacheBmp.Canvas.Handle, Left, Top, MinBorderWidth);
      end
      else
        if MinBorderWidth <> 0 then begin
          FillDCBorder(DC, aRect, MinBorderWidth, MinBorderWidth, MinBorderWidth, MinBorderWidth, Color);
          InflateRect(aRect, MinBorderWidth, MinBorderWidth);
        end;
  end;
end;


procedure CopyMask(DstX1, DstY1, DstX2, DstY2, SrcX1, SrcY1, SrcX2, SrcY2: integer; aBmp: TBitmap; Region: hrgn; const MaskData: TsMaskData; FillRgn: boolean = False);
var
  DeltaS, DeltaD, X, Y, h, w, MaskH, MaskHd2, MaskBmpHeight: Integer;
  S0, S: PRGBAArray_S;
  D0, D: PRGBAArray_D;
  M: PRGBAArray_M;
  BmpSrc: TBitmap;
  RegRect: TRect;
  fr: hrgn;
begin
  with MaskData, RegRect do
    if (DstX1 >= 0) and (DstX2 >= 0) and (DstY1 >= 0) and (DstY2 >= 0) and (aBmp.Height > 1) and (aBmp.Width > 1) and (Manager <> nil) then begin
      if Bmp = nil then
        BmpSrc := TsSkinManager(Manager).MasterBitmap
      else
        BmpSrc := Bmp;

      if InitLine(BmpSrc, Pointer(S0), DeltaS) and InitLine(aBmp, Pointer(D0), DeltaD) then
        if MaskType = 1 then begin
          MaskH := HeightOf(R);
          MaskBmpHeight := BmpSrc.Height - 1;
          MaskHd2 := MaskH div 2;

          h := Min(DstY2 - DstY1, aBmp.Height - DstY1);
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
                  if SC = clFuchsia then begin // If transparent pixel..
                    if Region <> 0 then
                      if Left >= 0 then
                        inc(Right)
                      else begin
                        Left   := DstX1 + X;
                        Top    := DstY1 + Y;
                        Right  := Left + 1;
                        Bottom := Top + 1;
                      end;
                  end
                  else begin
                    if (Left >= 0) and (Region <> 0) then begin
                      fr := CreateRectRgn(Left, Top, Right, Bottom);
                      CombineRgn(Region, Region, fr, RGN_XOR);
                      DeleteObject(fr);
                      Left := -1;
                    end;
                    with D^[DstX1 + X], M^[SrcX1 + X] do begin
                      DR := ((DR - SR) * MR + SR shl 8) shr 8;
                      DG := ((DG - SG) * MG + SG shl 8) shr 8;
                      DB := ((DB - SB) * MB + SB shl 8) shr 8;
                    end;
                  end;

              if (Left >= 0) and (Region <> 0) then begin
                fr := CreateRectRgn(Left, Top, Right, Bottom);
                CombineRgn(Region, Region, fr, RGN_DIFF);
                DeleteObject(fr);
                Left := -1;
              end;
            end
            else
              for Y := 0 to h do begin
                S := Pointer(LongInt(S0) + DeltaS * (SrcY1 + Y));
                D := Pointer(LongInt(D0) + DeltaD * (DstY1 + Y));
                M := Pointer(LongInt(S0) + DeltaS * (SrcY1 + MaskHd2 + Y));
                for X := 0 to w do begin
                  with D^[DstX1 + X], S^[SrcX1 + X], M^[SrcX1 + X] do begin
                    DR := ((DR - SR) * MR + SR shl 8) shr 8;
                    DG := ((DG - SG) * MG + SG shl 8) shr 8;
                    DB := ((DB - SB) * MB + SB shl 8) shr 8;
                  end;
                end;
              end;
        end
        else begin
          h := Min(DstY2 - DstY1, aBmp.Height - DstY1);
          h := Min(SrcY2 - SrcY1, h);
          w := Min(DstX2 - DstX1, SrcX2 - SrcX1);
          RegRect := Rect(-1, 0, 0, 0);
          if FillRgn then
            for Y := 0 to h do begin
              S := Pointer(LongInt(S0) + DeltaS * (SrcY1 + Y));
              D := Pointer(LongInt(D0) + DeltaD * (DstY1 + Y));
              for X := 0 to w do
                with S^[SrcX1 + X] do
                  if SC = sFuchsia.C then begin // If transparent pixel..
                    if Region <> 0 then
                      if Left >= 0 then
                        inc(Right)
                      else begin
                        Left   := DstX1 + X;
                        Top    := DstY1 + Y;
                        Right  := Left + 1;
                        Bottom := Top + 1;
                      end;
                  end
                  else begin
                    if (Left >= 0) and (Region <> 0) then begin
                      fr := CreateRectRgn(Left, Top, Right, Bottom);
                      CombineRgn(Region, Region, fr, RGN_XOR);
                      DeleteObject(fr);
                      Left := -1;
                    end;
                    D^[DstX1 + X].DC := SC;
                  end;

              if (Left >= 0) and (Region <> 0) then begin
                fr := CreateRectRgn(Left, Top, Right, Bottom);
                CombineRgn(Region, Region, fr, RGN_DIFF);
                DeleteObject(fr);
                Left := -1;
              end;
            end
          else
            for Y := 0 to h do begin
              S := Pointer(LongInt(S0) + DeltaS * (SrcY1 + Y));
              D := Pointer(LongInt(D0) + DeltaD * (DstY1 + Y));
              for X := 0 to w do
                D^[DstX1 + X].DC := S^[SrcX1 + X].SC;
            end;
        end;
    end;
end;


procedure PaintRgnBorder(aBmp: TBitmap; Region: hrgn; Filling: boolean; MaskData: TsMaskData; State: integer);
var
  bWidth, bHeight, x, y, w, h, dw, dh, pw, dhm: integer;
  Stretch: boolean;
  BmpSrc: TBitmap;
begin
  bWidth := aBmp.Width;
  bHeight := aBmp.Height;
  if (bWidth > 1) and (bHeight > 1) and (MaskData.Manager <> nil) then
    with MaskData do begin
      if wl + wr > bWidth then begin
        x := (wl + wr - bWidth) div 2;
        dec(wl, x);
        dec(wr, x);
        if bWidth mod 2 > 0 then
          dec(wr);

        if wl < 0 then
          wl := 0;

        if wr < 0 then
          wr := 0;
      end;
      if wt + wb > bHeight then begin
        x := (wt + wb - bHeight) div 2;
        dec(wt, x);
        dec(wb, x);
        if bHeight mod 2 > 0 then
          dec(wb);

        if wt < 0 then
          wt := 0;

        if wb < 0 then
          wb := 0;
      end;
      if ImageCount <= 0 then begin
        ImageCount := 1;
        R := MkRect(Bmp);
      end;
      if State >= ImageCount then
        State := ImageCount - 1;

      pw := Width;//WidthOf(R) div ImageCount;        // Width of mask
      if MaskType = 0 then begin
        dh := HeightOf(R);
        dhm := 0;
      end
      else begin
        dh := Height;//HeightOf(R) div (1 + MaskType); // Height of mask
        dhm := dh;
      end;
      w := pw - WL - WR;
      if w < 0 then
        w := 0;                                                 // Width of middle piece

      h := dh - WT - WB;
      if h < 0 then
        h := 0;                                                 // Height of middle piece

      dw := R.Left + pw * State;                       // Offset of mask
      if Bmp = nil then
        BmpSrc := TsSkinManager(Manager).MasterBitmap
      else
        BmpSrc := Bmp;

      if DrawMode and BDM_STRETCH <> 0 then begin
        Stretch := True;
        SetStretchBltMode(aBmp.Canvas.Handle, COLORONCOLOR);
      end
      else
        Stretch := False;

      // left - top
      CopyMask(0, 0, wl - 1, wt - 1, dw, R.Top, dw + wl - 1, R.Top + wt - 1, aBmp, Region, MaskData, True);
      // left - bottom
      CopyMask(0, bHeight - wb, wl - 1, bHeight - 1, dw, R.Top + dh - wb, dw + WL - 1, R.Top + dh - 1, aBmp, Region, MaskData, True);
      // left - middle
      if h > 0 then begin
        y := wt;
        if Stretch then
          StretchBltMask(0, y, wl, bHeight - wb - wt, dw, R.Top + wt, wl, h, aBmp, BmpSrc, dhm)
        else begin
          while y < bHeight - h - wb do begin
            CopyMask(0, y, wl - 1, y + h - 1, dw, R.Top + wt, R.Left + dw + wl - 1, R.Top + wt + h - 1, aBmp, Region, MaskData, False);
            inc(y, h);
          end;
          if y < bHeight - wb then
            CopyMask(0, y, wl - 1, bHeight - wb - 1,  dw, R.Top + wt, dw + wl - 1, R.Top + wt + h - 1, aBmp, Region, MaskData, False);
        end;
      end;
      // top - middle
      if w > 0 then begin
        x := wl;
        if Stretch then
          StretchBltMask(x, 0, bWidth - wr - x, wt, dw + wl, R.Top, w, wt, aBmp, BmpSrc, dhm)
        else begin
          while x < bWidth - w - wr do begin
            CopyMask(x, 0, x + w - 1, wt - 1, dw + wl, R.Top, dw + w + wl - 1, R.Top + wt - 1, aBmp, Region, MaskData, False);
            inc(x, w);
          end;
          if x < bWidth - wr then
            CopyMask(x, 0, bWidth - wr - 1, wt - 1, dw + wl, R.Top, dw + w + wl - 1, R.Top + wt - 1, aBmp, Region, MaskData, False);
        end;
      end;
      // bottom - middle
      if w > 0 then begin
        x := wl;
        if Stretch then
          StretchBltMask(x, bHeight - wb, bWidth - wr - x, wb, dw + wl, R.Top + dh - wb, w, wb, aBmp, BmpSrc, dhm)
        else begin
          while x < bWidth - w - wr do begin
            CopyMask(x, bHeight - wb, x + w - 1, bHeight - 1, dw + wl, R.Top + dh - wb, dw + w + wl - 1, R.Top + dh - 1, aBmp, Region, MaskData, False);
            inc(x, w);
          end;
          if x < bWidth - wr then
            CopyMask(x, bHeight - wb, bWidth - wr - 1, bHeight - 1, dw + wl, R.Top + dh - wb, dw + w + wl - 1, R.Top + dh - 1, aBmp, Region, MaskData, False);
        end;
      end;
      // right - middle
      if h > 0 then begin
        y := wt;
        if Stretch then
          StretchBltMask(bWidth - wr, y, wr, bHeight - wb - y, dw + w + wl, R.Top + wt, wr, h, aBmp, BmpSrc, dhm)
        else begin
          while y < bHeight - h - wb do begin
            CopyMask(bWidth - wr, y, bWidth - 1, y + h - 1, dw + pw - wr, R.Top + wt, dw + pw - 1, R.Top + h + wt - 1, aBmp, Region, MaskData, False);
            inc(y, h);
          end;
          if y < bHeight - wb then
            CopyMask(bWidth - wr, y, bWidth - 1, bHeight - wb - 1, dw + pw - wr, R.Top + wt, dw + pw - 1, R.Top + h + wt - 1, aBmp, Region, MaskData, False);
        end;
      end;
      // right - bottom
      CopyMask(bWidth - wr, bHeight - wb, bWidth - 1, bHeight - 1, dw + pw - wr, R.Top + dh - wb, dw + pw - 1, R.Top + dh - 1, aBmp, Region, MaskData, True);
      // right - top
      CopyMask(bWidth - wr, 0, bWidth - 1, wt - 1, dw + pw - wr, R.Top, dw + pw - 1, R.Top + wt - 1, aBmp, Region, MaskData, True);
      // Fill
      if Filling and (DrawMode and BDM_FILL = BDM_FILL) and (h > 0) and (w > 0) then
        if Stretch then
          StretchBltMask(wl, wt, bWidth - wr - wl, bHeight - wb - wt, dw + wl, R.Top + wt, w, h, aBmp, BmpSrc, dhm, True)
        else begin
          y := wt;
          while y < bHeight - h - wb do begin
            x := wl;
            while x < bWidth - w - wr do begin
              CopyMask(x, y, x + w - 1, y + h - 1, dw + wl, R.Top + wt, dw + w + wl - 1, R.Top + h + wt - 1, aBmp, Region, MaskData, False);
              inc(x, w);
            end;
            if x < bWidth - wr then
              CopyMask(x, y, bWidth - wr - 1, y + h - 1, dw + wl, R.Top + wt, dw + w + wl - 1, R.Top + h + wt - 1, aBmp, Region, MaskData, False);

            inc(y, h);
          end;
          x := wl;
          if y < bHeight - wb then begin
            while x < bWidth - w - wr do begin
              CopyMask(x, y, x + w - 1, bHeight - wb - 1, dw + wl - 1, R.Top + wt, dw + w + wl - 1, R.Top + h + wt - 1, aBmp, Region, MaskData, False);
              inc(x, w);
            end;
            if x < bWidth - wr then
              CopyMask(x, y, bWidth - wr - 1, bHeight - wb - 1, dw + wl - 1, R.Top + wt, dw + w + wl - 1, R.Top + h + wt - 1, aBmp, Region, MaskData, False);
          end;
        end;
    end;
end;

end.
