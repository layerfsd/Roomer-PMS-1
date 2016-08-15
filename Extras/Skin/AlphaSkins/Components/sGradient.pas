unit sGradient;
{$I sDefs.inc}
//+

interface

uses
  {$IFDEF FPC} JwaWinGDI, {$ENDIF}
  Windows, Graphics, Classes, SysUtils, math,
  sConst;


// Fills bitmap by custom properties of Gradient
procedure PaintGrad   (Bmp: TBitMap; aRect: TRect; const Gradient: string); overload;
procedure PaintGrad   (Bmp: TBitMap; aRect: TRect; const Data: TsGradArray; OffsetX: integer = 0; OffsetY: integer = 0); overload;
procedure PaintGradTxt(Bmp: TBitMap; aRect: TRect; const Data: TsGradArray; TextureBmp: TBitmap; TextureRect: TRect; TextureAlpha: byte; AlphaChannel: byte = MaxByte);
procedure PrepareGradArray(const GradientStr: string; var GradArray: TsGradArray);

implementation

uses
  acntUtils, sAlphaGraph, sGraphUtils;


type
  TRIVERTEX = packed record
    X, Y: DWORD;
    Red, Green, Blue, Alpha: Word;
  end;


var
  GradientFillAC: function(DC: hDC; pVertex: Pointer; dwNumVertex: DWORD; pMesh: Pointer; dwNumMesh, dwMode: DWORD): DWORD; stdcall;


procedure PaintGrad(Bmp: TBitMap; aRect: TRect; const Data: TsGradArray; OffsetX: integer = 0; OffsetY: integer = 0); overload;
var
  R, G, B: single;
  CurrentColor: TsColor_;
  C, Color1, Color2: TsColor;
  S0, SSrc1, SSrc: PRGBAArray_;
  RStep, GStep, BStep, p: real;
  vert:  array [0..4] of TRIVERTEX;
  gRect: array [0..3] of GRADIENT_TRIANGLE;
  i, dX, dY, w, Y, X, DeltaLine: integer;
  bHeight, bWidth, Count, Percent, CurrentX, MaxX, CurrentY, MaxY: integer;
begin
  if not IsRectEmpty(aRect) then begin
    bHeight := Bmp.Height;
    bWidth := Bmp.Width;
    if aRect.Right > bWidth then
      aRect.Right := bWidth;

    if aRect.Bottom > bHeight then
      aRect.Bottom := bHeight;

    if aRect.Left < 0 then
      aRect.Left := 0;

    if aRect.Top < 0 then
      aRect.Top := 0;

    CurrentColor.A := MaxByte;
    Count := Length(Data) - 1;
    if Count >= 0 then
      case Data[0].Mode1 of
        0: begin
          C.A := MaxByte;
          MaxY := aRect.Top + OffsetY;
          w := min(WidthOf(aRect) + aRect.Left, bWidth) - 1;
          dX := w - aRect.Left + 1;
          if InitLine(Bmp, Pointer(S0), DeltaLine) then
            for i := 0 to Count do begin
              Color1.C := Data[i].Color1;
              Color2.C := Data[i].Color2;
              Percent  := Data[i].Percent;
              CurrentY := MaxY;
              MaxY := CurrentY + ((HeightOf(aRect) + OffsetY) * Percent) div 100;
              if i = Count then
                MaxY := min(aRect.Bottom, bHeight) - 1
              else
                MaxY := min(MaxY, min(aRect.Bottom, bHeight) - 1);

              if MaxY - CurrentY > 0 then begin
                R := Color1.R;
                G := Color1.G;
                B := Color1.B;
                if (i = Count) or (MaxY >= bHeight) then
                  MaxY := min(aRect.Bottom, bHeight) - 1;

                dY := MaxY - CurrentY;
                if dY > 0 then
                  if Color1.C = Color2.C then begin
                    CurrentColor.R := Color1.R;
                    CurrentColor.G := Color1.G;
                    CurrentColor.B := Color1.B;
                    for Y := CurrentY to MaxY do begin
                      SSrc := Pointer(LongInt(S0) + DeltaLine * Y);
{$IFDEF WIN64}
                      for X := aRect.Left to aRect.Left + dX - 1 do
                        SSrc[X] := CurrentColor;
{$ELSE}
                      FillLongword(SSrc[aRect.Left], dX, Cardinal(CurrentColor.C));
{$ENDIF}
                    end
                  end
                  else begin
                    RStep := (Color2.R - Color1.R) / dY;
                    GStep := (Color2.G - Color1.G) / dY;
                    BStep := (Color2.B - Color1.B) / dY;
                    for Y := CurrentY to MaxY do begin
                      CurrentColor.R := Round(R);
                      CurrentColor.G := Round(G);
                      CurrentColor.B := Round(B);
                      SSrc := Pointer(LongInt(S0) + DeltaLine * Y);
{$IFDEF WIN64}
                      for X := aRect.Left to aRect.Left + dX - 1 do
                        SSrc[X] := CurrentColor;
{$ELSE}
                      FillLongword(SSrc[aRect.Left], dX, Cardinal(CurrentColor.C));
{$ENDIF}
                      R := R + RStep;
                      G := G + GStep;
                      B := B + BStep;
                    end
                  end;
              end;
            end;
        end;

        1:
          if InitLine(Bmp, Pointer(S0), DeltaLine) then begin
            p := WidthOf(aRect) / 100;
            // Paint first line
            SSrc1 := Pointer(LongInt(S0) + DeltaLine * aRect.Top);
            MaxX := aRect.Left;
            for i := 0 to Count do begin
              Color1.C := Data[i].Color1;
              Color2.C := Data[i].Color2;
              Percent  := Data[i].Percent;
              CurrentX := MaxX;
              MaxX := Round(CurrentX + (p * Percent));
              if i = Count then
                MaxX := min(aRect.Right, bWidth) - 1
              else
                MaxX := min(MaxX, min(aRect.Right, bWidth) - 1);

              if MaxX - CurrentX > 0 then begin
                dX := MaxX - CurrentX;
                R := Color1.R;
                G := Color1.G;
                B := Color1.B;
                RStep := (Color2.R - Color1.R) / dX;
                GStep := (Color2.G - Color1.G) / dX;
                BStep := (Color2.B - Color1.B) / dX;
                for X := CurrentX to MaxX do begin
                  CurrentColor.R := Round(R);
                  CurrentColor.G := Round(G);
                  CurrentColor.B := Round(B);
                  SSrc1[X] := CurrentColor;
                  R := R + RStep;
                  G := G + GStep;
                  B := B + BStep;
                end;
              end;
              // Clone lines
              w := WidthOf(aRect);
              if w > 0 then
                for CurrentY := aRect.Top + 1 to aRect.Bottom - 1 do begin
                  SSrc := Pointer(LongInt(S0) + DeltaLine * CurrentY);
                  CopyMemory(@SSrc[aRect.Left], @SSrc1[aRect.Left], (aRect.Right - aRect.Left) * 4);
                end;
            end
          end;

        2: begin // Triangles
          if Count >= 0 then
            c.C := Data[0].Color1
          else
            c.C := 0;
          // Left-top
          with vert[0] do begin
            Alpha := $FF00;
            x     := aRect.Left;
            y     := aRect.Top;
            Red   := c.R shl 8;
            Green := c.G shl 8;
            Blue  := c.B shl 8;
          end;

          if Count > 0 then
            c.C := Data[1].Color1;
          // Center
          with vert[1] do begin
            Alpha := $FF00;
            x     := aRect.Left + WidthOf(aRect) div 2;
            y     := aRect.Top + HeightOf(aRect) div 2;
            Red   := c.R shl 8;
            Green := c.G shl 8;
            Blue  := c.B shl 8;
          end;

          if Count > 1 then
            c.C := Data[2].Color1;
          // Right-top
          with vert[2] do begin
            Alpha := $FF00;
            x     := aRect.Right;
            y     := aRect.Top;
            Red   := c.R shl 8;
            Green := c.G shl 8;
            Blue  := c.B shl 8;
          end;

          if Count > 2 then
            c.C := Data[3].Color1;
          // Right-bottom
          with vert[3] do begin
            Alpha := $FF00;
            x     := aRect.Right;
            y     := aRect.Bottom;
            Red   := c.R shl 8;
            Green := c.G shl 8;
            Blue  := c.B shl 8;
          end;

          if Count > 3 then
            c.C := Data[4].Color1;
          // Left-bottom
          with vert[4] do begin
            Alpha := $FF00;
            x     := aRect.Left;
            y     := aRect.Bottom;
            Red   := c.R shl 8;
            Green := c.G shl 8;
            Blue  := c.B shl 8;
          end;

          gRect[0].Vertex1 := 0; // Top
          gRect[0].Vertex2 := 1;
          gRect[0].Vertex3 := 2;

          gRect[1].Vertex1 := 1; // Right
          gRect[1].Vertex2 := 2;
          gRect[1].Vertex3 := 3;

          gRect[2].Vertex1 := 0; // Left
          gRect[2].Vertex2 := 1;
          gRect[2].Vertex3 := 4;

          gRect[3].Vertex1 := 4; // Bottom
          gRect[3].Vertex2 := 1;
          gRect[3].Vertex3 := 3;

          if Assigned(GradientFillAC) then
            GradientFillAC(Bmp.Canvas.Handle, @vert, 5, @gRect, 4, GRADIENT_FILL_TRIANGLE);
        end;
      end;
  end;
end;


procedure PaintGrad(Bmp: TBitMap; aRect: TRect; const Gradient: string); overload;
var
  ga: TsGradArray;
begin
  PrepareGradArray(Gradient, ga);
  PaintGrad(Bmp, aRect, ga);
end;


procedure PaintGradTxt(Bmp: TBitMap; aRect: TRect; const Data: TsGradArray; TextureBmp: TBitmap; TextureRect: TRect; TextureAlpha: byte; AlphaChannel: byte = MaxByte);
var
  snR, snG, snB: single;
  Color1, Color2: TsColor;
  RStep, GStep, BStep, p: real;
  YPos, XPos, DeltaS, DeltaT: integer;
  CurrentColor, C_: TsColor_;
  i, w, h, dX, dY, TxtW, TxtH: Integer;
  SSrc: PRGBAArray_D;
  STxt: PRGBAArray_S;
  S0, SSrc1, STxt1: PRGBAArray_;
  bWidth, bHeight, Count, Percent, CurrentX, MaxX, CurrentY, MaxY: integer;
begin
  if not IsRectEmpty(aRect) then begin
    bWidth := Bmp.Width;
    bHeight := Bmp.Height;
    if aRect.Right > bWidth then
      aRect.Right := bWidth;

    if aRect.Bottom > bHeight then
      aRect.Bottom := bHeight;

    if aRect.Left < 0 then
      aRect.Left := 0;

    if aRect.Top < 0 then
      aRect.Top := 0;

    CurrentColor.A := AlphaChannel;
    C_.A := AlphaChannel;
    if IsRectEmpty(TextureRect) then
      TextureRect := MkRect(TextureBmp); // Compatibility with old skins

    TxtW := WidthOf (TextureRect, True);
    TxtH := HeightOf(TextureRect, True);
    if TextureRect.Top + TxtH >= TextureBmp.Height then
      TxtH := TextureBmp.Height - 1 - TextureRect.Top;

    if TextureRect.Left + TxtW >= TextureBmp.Width then
      TxtW := TextureBmp.Width - 1 - TextureRect.Left;

    if (TxtH < 0) or (TxtW < 0) then
      Exit;

    Count := Length(Data) - 1;
    if Count >= 0 then
      case Data[0].Mode1 of
        0: begin
          MaxY := aRect.Top;
          for i := 0 to Count do begin
            Color1.C := Data[i].Color1;
            Color2.C := Data[i].Color2;
            Percent  := Data[i].Percent;
            CurrentY := MaxY;
            MaxY := CurrentY + (HeightOf(aRect) * Percent) div 100;
            if i = Count then
              MaxY := min(aRect.Bottom, bHeight) - 1
            else
              MaxY := min(MaxY, min(aRect.Bottom, bHeight) - 1);

            if MaxY - CurrentY > 0 then begin
              snR := Color1.R;
              snG := Color1.G;
              snB := Color1.B;
              if (i = Count) or (MaxY >= bHeight) then
                MaxY := min(aRect.Bottom, bHeight) - 1;

              dY := MaxY - CurrentY;
              if dY > 0 then begin
                RStep := (Color2.R - Color1.R) / dY;
                GStep := (Color2.G - Color1.G) / dY;
                BStep := (Color2.B - Color1.B) / dY;
                if InitLine(Bmp, Pointer(S0), DeltaS) and InitLine(TextureBmp, Pointer(STxt1), DeltaT) then
                  for YPos := CurrentY to MaxY do
                    with CurrentColor do begin
                      R := Round(snR);
                      G := Round(snG);
                      B := Round(snB);
                      SSrc := Pointer(LongInt(S0) + DeltaS * YPos);
                      STxt := Pointer(LongInt(STxt1) + DeltaT * (TextureRect.Top + YPos mod TxtH));
                      for XPos := aRect.Left to aRect.Right - 1 do
                        with SSrc[XPos], STxt[TextureRect.Left + XPos mod TxtW] do begin
                          DR := ((SR - R) * TextureAlpha + R shl 8) shr 8;
                          DG := ((SG - G) * TextureAlpha + G shl 8) shr 8;
                          DB := ((SB - B) * TextureAlpha + B shl 8) shr 8;
                          DA := AlphaChannel;
                        end;

                      snR := snR + RStep;
                      snG := snG + GStep;
                      snB := snB + BStep;
                    end;
              end;
            end;
          end;
        end;

        1: begin
          if InitLine(Bmp, Pointer(S0), DeltaS) and InitLine(TextureBmp, Pointer(STxt1), DeltaT) then begin
            p := WidthOf(aRect) / 100;
            SSrc1 := Pointer(LongInt(S0) + DeltaS * aRect.Top);
            // Paint first line
            MaxX := aRect.Left;
            for i := 0 to Count do begin
              Color1.C := Data[i].Color1;
              Color2.C := Data[i].Color2;
              Percent  := Data[i].Percent;
              CurrentX := MaxX;
              MaxX := Round(CurrentX + (p * Percent));
              if i = Count then
                MaxX := min(aRect.Right, bWidth) - 1
              else
                MaxX := min(MaxX, min(aRect.Right, bWidth) - 1);

              if MaxX - CurrentX > 0 then begin
                dX := MaxX - CurrentX;
                snR := Color1.R;
                snG := Color1.G;
                snB := Color1.B;
                RStep := (Color2.R - Color1.R) / dX;
                GStep := (Color2.G - Color1.G) / dX;
                BStep := (Color2.B - Color1.B) / dX;
                for XPos := CurrentX to MaxX do
                  with SSrc1[XPos] do begin
                    R := Round(snR);
                    G := Round(snG);
                    B := Round(snB);
                    snR := snR + RStep;
                    snG := snG + GStep;
                    snB := snB + BStep;
                  end;
              end;
            end;
            h := min(TxtH, HeightOf(aRect, True)) - 1;
            // Clone lines with using a texture
            for CurrentY := aRect.Top + 1 to h + aRect.Top do begin
              SSrc := Pointer(LongInt(S0) + DeltaS * CurrentY);
              STxt := Pointer(LongInt(STxt1) + DeltaT * (TextureRect.Top + CurrentY mod TxtH));
              for XPos := aRect.Left to aRect.Right - 1 do
                with SSrc[XPos], STxt[TextureRect.Left + XPos mod TxtW], SSrc1[XPos] do begin
                  DR := ((SR - R) * TextureAlpha + R shl 8) shr 8;
                  DG := ((SG - G) * TextureAlpha + G shl 8) shr 8;
                  DB := ((SB - B) * TextureAlpha + B shl 8) shr 8;
                  DA := AlphaChannel;
                end;

            end;
            // Texture for the first line
            CurrentY := aRect.Top;
            STxt := Pointer(LongInt(STxt1) + DeltaT * (TextureRect.Top + CurrentY mod TxtH));
            for XPos := aRect.Left to aRect.Right - 1 do
              with STxt[TextureRect.Left + XPos mod TxtW], SSrc1[XPos] do begin
                R := ((SR - R) * TextureAlpha + R shl 8) shr 8;
                G := ((SG - G) * TextureAlpha + G shl 8) shr 8;
                B := ((SB - B) * TextureAlpha + B shl 8) shr 8;
              end;

            CurrentY := aRect.Top + h;
            w := WidthOf(aRect);
            if w > 0 then
              while CurrentY < aRect.Bottom - 1 - h do begin
                BitBlt(Bmp.Canvas.Handle, aRect.Left, CurrentY, w, h, Bmp.Canvas.Handle, aRect.Left, aRect.Top, SRCCOPY);
                inc(CurrentY, h);
              end;

            if CurrentY < aRect.Bottom then
              BitBlt(Bmp.Canvas.Handle, aRect.Left, CurrentY, w, aRect.Bottom - CurrentY, Bmp.Canvas.Handle, aRect.Left, aRect.Top, SRCCOPY);
          end;
        end;
      end;
  end;
end;


procedure PrepareGradArray(const GradientStr: string; var GradArray: TsGradArray);
var
  Count, i: integer;
begin
  SetLength(GradArray, 0);
  if GradientStr <> '' then begin
    Count := WordCount(GradientStr, [';']) div 5;
    SetLength(GradArray, Count);
    for i := 0 to Count - 1 do begin
      GradArray[i].Color1 := ColorToRGB(StrToInt(ExtractWord(i * 5 + 1, GradientStr, [';'])));
      GradArray[i].Color2 := ColorToRGB(StrToInt(ExtractWord(i * 5 + 2, GradientStr, [';'])));
      GradArray[i].Percent := max(0, min(100, StrToInt(ExtractWord(i * 5 + 3, GradientStr, [';']))));
      GradArray[i].Mode1 := StrToInt(ExtractWord(i * 5 + 4, GradientStr, [';']));
    end;
  end;
end;


var
  hmsimg32: HMODULE = 0;


initialization
  hmsimg32 := LoadLibrary('msimg32.dll');
  if hmsimg32 <> 0 then
    GradientFillAC := GetProcAddress(hmsimg32, 'GradientFill');


finalization
  if hmsimg32 <> 0 then
    FreeLibrary(hmsimg32);
end.


