unit sAlphaGraph;
{$I sDefs.inc}

interface

uses
  Windows, SysUtils, Graphics, Controls, math,
  {$IFNDEF DELPHI5} Types, {$ELSE} Classes, {$ENDIF}
  {$IFNDEF ACHINTS} sMaskData, sCommonData, {$ENDIF}
  sConst;


{$IFNDEF NOTFORHELP}
type
  TsCorner = (scLeftTop, scLeftBottom, scRightTop, scRightBottom);
  TsCorners = set of TsCorner;

  
{$ENDIF} // NOTFORHELP
function SwapColor(Color: TColor): TColor;
function SwapRedBlue(const Color: TColor): TColor;
procedure BlendColorRect(Bmp: TBitmap; R: TRect; Transparency: TPercent; Color: TColor);
procedure FillRect32(const Bmp: TBItmap; R: TRect; const Color: TColor; Alpha: byte = MaxByte);
procedure FillAlphaRect(const Bmp: TBItmap; const R: TRect; Value: byte; TransparentColor: TColor = clNone);
{$IFNDEF ACHINTS}
// Copy with AlphaMask from MasterBmp (get transp. pixels from parent)
procedure CopyMasterRect(R1, R2: TRect; const Bmp: TBitmap; const CI: TCacheInfo; const MaskData: TsMaskData);
procedure DrawSmallSkinRect(Bmp: TBitmap; R: TRect; const ci: TCacheInfo; const MaskData: TsMaskData; State: integer);
// Skinned rectangle with transparent corners
procedure DrawSkinRect    (Bmp: TBitmap; const R: TRect; const ci: TCacheInfo; const MaskData: TsMaskData; const State: integer; const UpdateCorners: boolean);
procedure DrawSkinRect32  (Bmp: TBitmap; const R: TRect; const ci: TCacheInfo; const MaskData: TsMaskData; const State: integer);
procedure DrawSkinRect32Ex(Bmp: TBitmap; const R: TRect; const ci: TCacheInfo; const MaskData: TsMaskData; const State: integer; MaxWidths: TRect; Opacity: integer);
// Skip transparent part of corners
procedure DrawSkinGlyph(Bmp: TBitmap; P: TPoint; State, AddedTransparency: integer; const MaskData: TsMaskData; const CI: TCacheInfo);
procedure StretchBltMask    (DstX1, DstY1, Dst_Width, Dst_Height, SrcX1, SrcY1, Src_Width, Src_Height: integer; BmpDst, BmpSrc: TBitmap; MaskOffset: integer; NoStdStretch: boolean = False);
procedure StretchBltMask32  (DstX1, DstY1, Dst_Width, Dst_Height, SrcX1, SrcY1, Src_Width, Src_Height: integer; BmpDst, BmpSrc: TBitmap; MaskOffset: integer; NoStdStretch: boolean = False);
procedure StretchBltMask32Ex(DstX1, DstY1, Dst_Width, Dst_Height, SrcX1, SrcY1, Src_Width, Src_Height: integer; BmpDst, BmpSrc: TBitmap; MaskOffset: integer; Opacity: integer; NoStdStretch: boolean = False);
// Transparency - percent of the bmp visibility
procedure BmpDisabledKind(const Bmp: TBitmap; const DisabledKind: TsDisabledKind; Parent: TControl; const CI: TCacheInfo; Offset: TPoint);
{$IFNDEF NOTFORHELP}
// Skip transparent pixels
procedure CopyByMask32(R1, R2: TRect; const Bmp1, Bmp2: TBitmap; const CI: TCacheInfo; const MaskData: TsMaskData);
procedure CopyByMask32Ex(R1, R2: TRect; Bmp1, Bmp2: TBitmap; const CI: TCacheInfo; const MaskData: TsMaskData; Opacity: integer);
procedure BlendGlyphByMask(R1, R2: TRect; Bmp1, Bmp2: TBitmap; AddedTransparency: integer; const MaskData: TsMaskData);
procedure UpdateCorners(SkinData: TsCommonData; State: integer; Corners: TsCorners = [scLeftTop, scLeftBottom, scRightTop, scRightBottom]);
procedure FillTransPixels32(const DstBmp, SrcBmp: TBitmap; const DstRect: TRect; const SrcPoint: TPoint; MaskIndex: integer = -1; SkinManager: TObject = nil; MaskPos: Cardinal = HTTOPLEFT);
{$IFNDEF WIN64}
procedure FillLongword(var X; Count: Integer; Value: Longword);
{$ENDIF}
// Copy mask (red channel in bitmap) as AlphaChannel
procedure WriteColor(const Bmp: TBitmap; Text: PacChar; Enabled: boolean; lRect: TRect; Flags: Cardinal; Color: TColor; IsAnsi: boolean = False);
procedure WriteText32(const Bmp: TBitmap; Text: PacChar; Enabled: boolean; var aRect: TRect; Flags: Cardinal; SkinIndex: integer; Hot: boolean; SkinManager: TObject = nil; IsAnsi: boolean = False);
procedure FillDCBorder32(const Bmp: TBitmap; const aRect: TRect; const wl, wt, wr, wb: integer; const Color: TColor);
procedure UpdateTransPixels(Img: TBitmap);
function MakeIcon32(Img: TBitmap; UpdateAlphaChannell: boolean = False): HICON;
function SwapLong(Value: Cardinal): Cardinal; overload;
procedure SwapLong(P: PInteger; Count: Cardinal); overload;
function GetAPixel(const Bmp: TBitmap; x, y: integer): TsColor;
procedure SetAPixel(const Bmp: TBitmap; x, y: integer; const Value: TsColor);
procedure PaintItem32(SkinIndex: integer; Filling: boolean; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TObject = nil); overload;
procedure PaintItemBG32(SkinIndex: integer; State: integer; R: TRect; ItemBmp: TBitmap; SkinManager: TObject; CustomColor: TColor = clFuchsia);
procedure UpdateAlpha(Img: TBitmap); overload;
procedure UpdateAlpha(Img: TBitmap; R: TRect); overload;
{$ENDIF} // NOTFORHELP
{$ENDIF}
implementation

Uses acntUtils, sGraphUtils{$IFNDEF ACHINTS}, sDefaults, sVclUtils, sSkinManager{$ENDIF}, sGradient;


procedure UpdateTransPixels(Img: TBitmap);
var
  x, y, DeltaS: integer;
  S0, S: PRGBAArray;
begin
  if InitLine(Img, Pointer(S0), DeltaS) then
    for Y := 0 to Img.Height - 1 do begin
      S := Pointer(LongInt(S0) + DeltaS * Y);
      for X := 0 to Img.Width - 1 do
        with S[X] do
          if (I = clWhite) then
            I := 0;
    end;
end;


function MakeIcon32(Img: TBitmap; UpdateAlphaChannell: boolean = False): HICON;
var
  D0, D: PByteArray;
  TransColor: TColor;
  IconInfo: TIconInfo;
  MaskBitmap: TBitmap;
  S0, S: PRGBAArray_RGB;
  X, Y, DeltaS, DeltaD: integer;
begin
  MaskBitmap := TBitmap.Create;
  MaskBitmap.PixelFormat := pf8bit;
  MaskBitmap.Width := Img.Width;
  MaskBitmap.Height := Img.Height;

  TransColor := GetAPixel(Img, 0, 0).C;
  Img.PixelFormat := pf32bit;

  if InitLine(Img, Pointer(S0), DeltaS) and InitLine(MaskBitmap, Pointer(D0), DeltaD) then
    for Y := 0 to Img.Height - 1 do begin
      S := Pointer(LongInt(S0) + DeltaS * Y);
      D := Pointer(LongInt(D0) + DeltaD * Y);
      for X := 0 to Img.Width - 1 do
        with S[X] do
          if Col <> TransColor then
            D[X] := 0
          else
            D[X] := $FF;
    end;
    
  MaskBitmap.PixelFormat := pf1bit;
  try
    IconInfo.fIcon := True;
    IconInfo.hbmColor := Img.Handle;
    IconInfo.hbmMask := MaskBitmap.Handle;
    Result := CreateIconIndirect(IconInfo);
  finally
    FreeAndNil(MaskBitmap);
  end;
end;


function SwapLong(Value: Cardinal): Cardinal; overload;
{$IFDEF WIN64}
begin
  PByte(@Result)[0] := PByte(@Value)[3];
  PByte(@Result)[1] := PByte(@Value)[2];
  PByte(@Result)[2] := PByte(@Value)[1];
  PByte(@Result)[3] := PByte(@Value)[0];
{$ELSE}
asm
  BSWAP EAX
{$ENDIF}
end;


procedure SwapLong(P: PInteger; Count: Cardinal); overload;
{$IFDEF WIN64}
begin
  while Count > 0 do begin
    p^ := SwapLong(p^);
  {$POINTERMATH ON}
    inc(p);
  {$POINTERMATH OFF}
    dec(Count);
  end;
{$ELSE}
asm
@@Loop:
  MOV ECX, [EAX]
  BSWAP ECX
  MOV [EAX], ECX
  ADD EAX, 4
  DEC EDX
  JNZ @@Loop
{$ENDIF}
end;


procedure UpdateAlpha(Img: TBitmap);
begin
  UpdateAlpha(Img, MkRect(Img));
end;


procedure UpdateAlpha(Img: TBitmap; R: TRect);
var
  S0, S: PRGBAArray;
  x, y, Delta: integer;
begin
  if InitLine(Img, Pointer(S0), Delta) then
    for Y := R.Top to R.Bottom - 1 do begin
      S := Pointer(LongInt(S0) + Delta * Y);
      for X := R.Left to R.Right - 1 do
        with S[X] do
          if (I = clWhite) then
            I := 0
          else begin
            R := (R * A) shr 8;
            G := (G * A) shr 8;
            B := (B * A) shr 8;
          end;
    end;
end;


function GetAPixel(const Bmp: TBitmap; x, y: integer): TsColor;
var
  S: PRGBAArray;
begin
  S := Bmp.ScanLine[Y];
  Result.I := S[X].I;
end;


procedure SetAPixel(const Bmp: TBitmap; x, y: integer; const Value: TsColor);
var
  S: PRGBAArray;
begin
  S := Bmp.ScanLine[Y];
  S[X].I := Value.I;
end;


procedure FillTransPixels32(const DstBmp, SrcBmp: TBitmap; const DstRect: TRect; const SrcPoint: TPoint; MaskIndex: integer = -1; SkinManager: TObject = nil; MaskPos: Cardinal = HTTOPLEFT);
var
  C: TsColor_;
  mOffset: TPoint;
  MaskBmp: TBitmap;
  M0, M: PRGBAArray;
  S0, D0, S, D: PRGBAArray;
  X, Y, w, h, wi, hi: integer;
  DeltaS, DeltaD, DeltaM: integer;
begin
  w := min(WidthOf(DstRect,  True) - 1, SrcBmp.Width  - SrcPoint.X - 1);
  h := min(HeightOf(DstRect, True) - 1, SrcBmp.Height - SrcPoint.Y - 1);
  if (MaskIndex = -1) then begin
    if InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(DstBmp, Pointer(D0), DeltaD) then
      for Y := 0 to h do begin
        S := Pointer(LongInt(S0) + DeltaS * (SrcPoint.Y  + Y));
        D := Pointer(LongInt(D0) + DeltaD * (DstRect.Top + Y));
        for X := 0 to w do begin
          C := D[DstRect.Left + X];
          C.A := 0;
          if C.C = clFuchsia then
            D[DstRect.Left + X] := S[SrcPoint.X + X];
        end;
      end;
  end
  else
    with TsSkinManager(SkinManager) do begin
      MaskBmp := ma[MaskIndex].Bmp;
      if MaskBMp = nil then
        MaskBmp := MasterBitmap;

      wi := WidthOfImage(ma[MaskIndex]);
      hi := HeightOfImage(ma[MaskIndex]);
      case MaskPos of
        HTTOPLEFT    : mOffset := ma[MaskIndex].R.TopLeft;
        HTTOPRIGHT   : mOffset := Point(ma[MaskIndex].R.Left + wi - ma[MaskIndex].WR, ma[MaskIndex].R.Top);
        HTBOTTOMLEFT : mOffset := Point(ma[MaskIndex].R.Left, ma[MaskIndex].R.Top + hi - ma[MaskIndex].WB);
        HTBOTTOMRIGHT: mOffset := Point(ma[MaskIndex].R.Left + wi - ma[MaskIndex].WR, ma[MaskIndex].R.Top + hi - ma[MaskIndex].WB);
        else           mOffset := ma[MaskIndex].R.TopLeft;
      end;
      if InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(DstBmp, Pointer(D0), DeltaD) and InitLine(MaskBmp, Pointer(M0), DeltaM) then
        for Y := 0 to h do begin
          S := Pointer(LongInt(S0) + DeltaS * (SrcPoint.Y  + Y));
          D := Pointer(LongInt(D0) + DeltaD * (DstRect.Top + Y));
          M := Pointer(LongInt(M0) + DeltaM * (mOffset.Y   + Y));
          for X := 0 to w do begin
            C := M[mOffset.X + X];
            C.A := 0;
            if C.C = clFuchsia then
              D[DstRect.Left + X] := S[SrcPoint.X + X];
          end;
        end;
    end;
end;


procedure WriteColor(const Bmp: TBitmap; Text: PacChar; Enabled: boolean; lRect: TRect; Flags: Cardinal; Color: TColor; IsAnsi: boolean = False);
var
  x, y, h, w, miny, minx: integer;
  S0, D0, S, D: PRGBAArray;
  DeltaS, DeltaD: integer;
  SrcColor: TsColor;
  TmpBmp: TBitmap;
  CC: TsColor_;
  bC: byte;
  R: TRect;
begin
  TmpBmp := CreateBmp32(lRect);
  TmpBmp.Canvas.Font.Assign(Bmp.Canvas.Font);

  SetTextColor(TmpBmp.Canvas.Handle, 0);
  SetBkColor(TmpBmp.Canvas.Handle, clWhite);

  R := MkRect(TmpBmp);
  if IsAnsi then
    DrawText(TmpBmp.Canvas.Handle, PAnsiChar(Text), StrLen(PChar(Text)), R, Flags)
  else
    AcDrawText(TmpBmp.Canvas.Handle, Text, R, Flags);

  h := TmpBmp.Height - 1;
  w := TmpBmp.Width  - 1;

  if lRect.Top + h > Bmp.Height - 1 then
    h := Bmp.Height - 1 - lRect.Top;

  if lRect.Left + w > Bmp.Width - 1 then
    w := Bmp.Width - 1 - lRect.Left;

  if lRect.Top < 0 then
    miny := -lRect.Top
  else
    miny := 0;

  if lRect.Left < 0 then
    minx := -lRect.Left
  else
    minx := 0;

  CC.A := MaxByte;
  SrcColor.C := Color;
  if InitLine(TmpBmp, Pointer(S0), DeltaS) and InitLine(Bmp, Pointer(D0), DeltaD) then begin
    if Enabled then
      for y := miny to h do begin
        S := Pointer(LongInt(S0) + DeltaS * Y);
        D := Pointer(LongInt(D0) + DeltaD * (y + lRect.Top));
        for x := minx to w do
          if (S[x].C <> clWhite) and (S[x].I <> -1) then
            with D[x + lRect.Left] do begin
              bC := (S[x].R + S[x].G + S[x].B) div 3;
              A := max((A + MaxByte) shr 1, MaxByte - bC);
              R := ((R - SrcColor.R) * bC + SrcColor.R shl 8) * A shr 16;
              G := ((G - SrcColor.G) * bC + SrcColor.G shl 8) * A shr 16;
              B := ((B - SrcColor.B) * bC + SrcColor.B shl 8) * A shr 16;
            end;
      end
    else
      for y := miny to h do begin
        S := Pointer(LongInt(S0) + DeltaS * Y);
        D := Pointer(LongInt(D0) + DeltaD * (y + lRect.Top));
        for x := minx to w do
          if (S[x].C <> clWhite) and (S[x].I <> -1) then
            with D[x + lRect.Left] do begin
              A := MaxByte;
              R := ((R - SrcColor.R) * S[x].R + SrcColor.R shl 8) shr 8;
              G := ((G - SrcColor.G) * S[x].G + SrcColor.G shl 8) shr 8;
              B := ((B - SrcColor.B) * S[x].B + SrcColor.B shl 8) shr 8;
            end;
      end;
  end;
  FreeAndNil(TmpBmp);
end;


procedure WriteText32(const Bmp: TBitmap; Text: PacChar; Enabled: boolean; var aRect: TRect; Flags: Cardinal; SkinIndex: integer; Hot: boolean; SkinManager: TObject = nil; IsAnsi: boolean = False);
var
  State: Integer;
  R, Rd: TRect;
  C: TColor;
begin
 if (Text <> '') and not IsRectEmpty(aRect) then begin
    if SkinManager = nil then
      SkinManager := DefaultManager;

    if Assigned(SkinManager) then
      with TsSkinManager(SkinManager) do begin
        R := aRect;
        if IsValidSkinIndex(SkinIndex) then begin
          State := integer(Hot);
          if Enabled then begin
            // Left
            C := gd[SkinIndex].Props[State].FontColor.Left;
            if C <> -1 then begin
              Rd := Rect(R.Left - 1, R.Top, R.Right - 1, R.Bottom);
              WriteColor(Bmp, Text, True, Rd, Flags, C);
            end;
            // Top
            C := gd[SkinIndex].Props[State].FontColor.Top;
            if C <> -1 then begin
              Rd := Rect(R.Left, R.Top - 1, R.Right, R.Bottom - 1);
              WriteColor(Bmp, Text, True, Rd, Flags, C);
            end;
            // Right
            C := gd[SkinIndex].Props[State].FontColor.Right;
            if C <> -1 then begin
              Rd := Rect(R.Left + 1, R.Top, R.Right + 1, R.Bottom);
              WriteColor(Bmp, Text, True, Rd, Flags, C);
            end;
            // Bottom
            C := gd[SkinIndex].Props[State].FontColor.Bottom;
            if C <> -1 then begin
              Rd := Rect(R.Left, R.Top + 1, R.Right, R.Bottom + 1);
              WriteColor(Bmp, Text, True, Rd, Flags, C);
            end;
          end;
          // Center
          C := gd[SkinIndex].Props[State].FontColor.Color;
          WriteColor(Bmp, Text, Enabled, R, Flags, C);
        end
        else
          WriteColor(Bmp, Text, Enabled, R, Flags, Bmp.Canvas.Font.Color);
      end
    else
      WriteColor(Bmp, Text, Enabled, aRect, Flags, Bmp.Canvas.Font.Color);
  end;
end;


procedure FillDCBorder32(const Bmp: TBitmap; const aRect: TRect; const wl, wt, wr, wb: integer; const Color: TColor);
begin
  FillRect32(Bmp, Rect(aRect.Left,       aRect.Top,         aRect.Right,     aRect.Top + wt),    Color);
  FillRect32(Bmp, Rect(aRect.Left,       aRect.Top + wt,    aRect.Left + wl, aRect.Bottom),      Color);
  FillRect32(Bmp, Rect(aRect.Left + wl,  aRect.Bottom - wb, aRect.Right,     aRect.Bottom),      Color);
  FillRect32(Bmp, Rect(aRect.Right - wr, aRect.Top + wt,    aRect.Right,     aRect.Bottom - wb), Color);
end;


procedure BlendColorRect(Bmp: TBitmap; R: TRect; Transparency: TPercent; Color: TColor);
var
  rT, tR: real;
  bR, bG, bB: byte;
  S0, S: PRGBAArray;
  BlendColor: TsColor;
  Delta, x, y: integer;
begin
  if R.Left < 0 then
    R.Left := 0;

  if R.Top < 0 then
    R.Top := 0;

  if R.Right > Bmp.Width - 1 then
    R.Right := Bmp.Width - 1;

  if R.Bottom > Bmp.Height - 1 then
    R.Bottom := Bmp.Height - 1;

  BlendColor.C := ColorToRGB(Color);
  bR := BlendColor.R;
  bG := BlendColor.G;
  bB := BlendColor.B;
  rT := Transparency / 100;
  tR := 1 - rT;
  if InitLine(Bmp, Pointer(S0), Delta) then
    for y := R.Top to R.Bottom do begin
      S := Pointer(LongInt(S0) + Delta * Y);
      for x := R.Left to R.Right do
        with S[X] do begin
          R := Round(R * rT + bR * tR);
          G := Round(G * rT + bG * tR);
          B := Round(B * rT + bB * tR);
        end;
    end;
end;


function SwapColor(Color: TColor): TColor;
{$IFDEF WIN64}
begin
  Result := Color;
{$ELSE}
asm
  BSWAP EAX
  ROR   EAX, 8
{$ENDIF}
end;


function SwapRedBlue(const Color: TColor): TColor;
begin
  with TsColor(Result), TsColor_RGB_(Color) do begin
    A := Alpha;
    R := Red;
    G := Green;
    B := Blue;
  end;
end;


procedure FillRect32(const Bmp: TBItmap; R: TRect; const Color: TColor; Alpha: byte = MaxByte);
var
  C: TsColor_;
  S0, S: PRGBAArray;
  Delta, X, Y: integer;
begin
  if Bmp.Height < R.Bottom then
    R.Bottom := Bmp.Height;

  C.C := SwapRedBlue(Color);
  C.A := Alpha;
  if InitLine(Bmp, Pointer(S0), Delta) then
    for Y := max(0, R.Top) to min(Bmp.Height, R.Bottom) - 1 do begin
      S := Pointer(LongInt(S0) + Delta * Y);
      for X := max(0, R.Left) to min(Bmp.Width, R.Right) - 1 do
        S[X] := C;
    end;
end;


procedure BlendRect32(const Bmp: TBItmap; R: TRect; Color: TColor; BlendValue: byte; Alpha: byte = MaxByte);
var
  Col: TsColor_;
  S0, S: PRGBAArray;
  Delta, X, Y: integer;
begin
  if Bmp.Height < R.Bottom then
    R.Bottom := Bmp.Height;

  Col.C := SwapRedBlue(Color);
  Col.A := Alpha;
  if InitLine(Bmp, Pointer(S0), Delta) then
    for Y := max(0, R.Top) to min(Bmp.Height, R.Bottom) - 1 do begin
      S := Pointer(LongInt(S0) + Delta * Y);
      for X := max(0, R.Left) to min(Bmp.Width, R.Right) - 1 do
        with S[X] do begin
          R := R - BlendValue * (R - Col.R) div 100;
          G := G - BlendValue * (G - Col.G) div 100;
          B := B - BlendValue * (B - Col.B) div 100;
          A := Col.A;
        end;
    end;
end;


procedure FillAlphaRect(const Bmp: TBItmap; const R: TRect; Value: byte; TransparentColor: TColor = clNone);
var
  S0, S: PRGBAArray;
  Delta, X, Y, w, h: integer;
begin
  w := WidthOf (R, True) - 1;
  h := HeightOf(R, True) - 1;
  if InitLine(Bmp, Pointer(S0), Delta) then
    if TransparentColor <> clNone then
      for Y := 0 to h do begin
        S := Pointer(LongInt(S0) + Delta * (R.Top + Y));
        for X := 0 to w do
          if TsColor_(S[R.Left + X]).C <> TransparentColor then
            TsColor_(S[R.Left + X]).A := Value;
      end
    else
      for Y := 0 to h do begin
        S := Pointer(LongInt(S0) + Delta * (R.Top + Y));
        for X := 0 to w do
          TsColor_(S[R.Left + X]).A := Value;
      end;
end;


{$IFNDEF ACHINTS}
procedure BmpDisabledKind(const Bmp: TBitmap; const DisabledKind: TsDisabledKind; Parent: TControl; const CI: TCacheInfo; Offset: TPoint);
var
  C: TColor;
  R: TRect;
begin
  if (dkGrayed in DisabledKind) then
    if DefDisabledSaturation = -100 then
      GrayScale(Bmp)
    else
      ChangeBitmapPixels(Bmp, ChangeColorSaturation, Round(DefDisabledSaturation * MaxByte / 100), clFuchsia);

  if (dkBlended in DisabledKind) then begin
    R := MkRect(Bmp);
    if CI.Ready then begin
      OffsetRect(R, CI.X + Offset.X, CI.Y + Offset.Y);
      BlendTransRectangle(Bmp, 0, 0, CI.Bmp, R, DefDisabledBlend);
    end
    else begin
      if CI.FillColor <> clFuchsia then
        C := CI.FillColor
      else
        C := GetControlColor(Parent);

      BlendColorRect(Bmp, R, Trunc(DefDisabledBlend * 100), C);
    end;
  end;
end;


procedure DrawSmallSkinRect(Bmp: TBitmap; R: TRect; const ci: TCacheInfo; const MaskData: TsMaskData; State: integer);
var
  x, y, w, h, dw, dh: integer;
  mw, mh, minhp, minwp, minh, minw: integer;
begin
  if MaskData.Bmp = nil then
    with TsSkinManager(MaskData.Manager) do begin
      if MaskData.Manager = nil then
        Exit;

      if (WidthOf(R) < 2) or (HeightOf(R) < 2) then
        Exit;

      if MaskData.ImageCount = 0 then
        Exit;

      if State >= MaskData.ImageCount then
        State := MaskData.ImageCount - 1;

      dw := State * WidthOf(MaskData.R) div (MaskData.ImageCount); // Width of mask
      dh := HeightOf(MaskData.R) div (1 + MaskData.MaskType);      // Height of mask
      w := WidthOf (MaskData.R) div (3 * MaskData.ImageCount);
      h := HeightOf(MaskData.R) div (3 * (1 + MaskData.MaskType));

      if WidthOf(R) < w * 2 then
        mw := WidthOf(R) div 2
      else
        mw := 0;

      if HeightOf(R) < h * 2 then
        mh := HeightOf(R) div 2
      else
        mh := 0;

      if mh > 0 then begin
        minh := mh;
        minhp := minh;
        if HeightOf(R) mod 2 <> 0 then
          inc(minhp);
      end
      else begin
        minh := h;
        minhp := h;
      end;

      if mw > 0 then begin
        minw := mw;
        minwp := minw;
        if WidthOf(R) mod 2 <> 0 then
          inc(minwp);
      end
      else begin
        minw := w;
        minwp := w;
      end;

      if MaskData.MaskType = 0 then begin
        // left - top
        CopyTransRect(Bmp, MasterBitmap, R.Left, R.Top, Rect(MaskData.R.Left + dw, MaskData.R.Top, MaskData.R.Left + dw + minw, MaskData.R.Top + minh), clFuchsia, CI, True);
        // left - middle
        y := R.Top + h;
        if MaskData.DrawMode and BDM_STRETCH = 0 then begin
          while y < R.Bottom - h do begin
            BitBlt(Bmp.Canvas.Handle, R.Left, y, minw, h, MasterBitmap.Canvas.Handle, MaskData.R.Left + dw, MaskData.R.Top + h, SRCCOPY);
            inc(y, h);
          end;
          if y < R.Bottom - h then
            BitBlt(Bmp.Canvas.Handle, R.Left, y, minw, h, MasterBitmap.Canvas.Handle, MaskData.R.Left + dw, MaskData.R.Top + h, SRCCOPY);
        end
        else
          StretchBlt(Bmp.Canvas.Handle, R.Left, y, R.Left + minw, R.Bottom - minh - y, MasterBitmap.Canvas.Handle, MaskData.R.Left + dw, MaskData.R.Top + h, minw, h, SRCCOPY);

        // top - middle
        x := R.Left + minw;
        if MaskData.DrawMode and BDM_STRETCH = 0 then begin
          while x < R.Right - w - minw do begin
            BitBlt(Bmp.Canvas.Handle, x, R.Top, w, minh, MasterBitmap.Canvas.Handle, MaskData.R.Left + dw + w, MaskData.R.Top, SRCCOPY);
            inc(x, w);
          end;
          if x < R.Right - minw then
            BitBlt(Bmp.Canvas.Handle, x, R.Top, R.Right - minw - x, minh, MasterBitmap.Canvas.Handle, MaskData.R.Left + dw + w, MaskData.R.Top, SRCCOPY);
        end
        else
          StretchBlt(Bmp.Canvas.Handle, x, R.Top, R.Right - minw - x, minh, MasterBitmap.Canvas.Handle, MaskData.R.Left + dw + w, MaskData.R.Top, w, minh, SRCCOPY);

        // left - bottom
        CopyTransRect(Bmp, MasterBitmap, R.Left, R.Bottom - minhp, Rect(MaskData.R.Left + dw, MaskData.R.Bottom - minhp, MaskData.R.Left + dw + minw - 1,
                      MaskData.R.Bottom - 1), clFuchsia, CI, True);
        // bottom - middle
        x := R.Left + minw;
        if MaskData.DrawMode and BDM_STRETCH = 0 then begin
          while x < R.Right - w - minw do begin
            BitBlt(Bmp.Canvas.Handle, x, R.Bottom - minh, w, minh, MasterBitmap.Canvas.Handle, MaskData.R.Left + dw + w, MaskData.R.Bottom - minh, SRCCOPY);
            inc(x, w);
          end;
          if x < R.Right - minw then
            BitBlt(Bmp.Canvas.Handle, x, R.Bottom - minh, R.Right - minw - x, minh, MasterBitmap.Canvas.Handle, MaskData.R.Left + dw + w, MaskData.R.Bottom - minh, SRCCOPY);
        end
        else
          StretchBlt(Bmp.Canvas.Handle, x, R.Bottom - minh, R.Right - minw - x, minh, MasterBitmap.Canvas.Handle, MaskData.R.Left + dw + w, MaskData.R.Bottom - minh, w, minh, SRCCOPY);
        // right - bottom
        CopyTransRect(Bmp, MasterBitmap, R.Right - minwp, R.Bottom - minhp,
                      Rect(MaskData.R.Left + dw + 3 * w - minwp, MaskData.R.Bottom - minhp, MaskData.R.Left + dw + 3 * w - 1, MaskData.R.Bottom - 1), clFuchsia, CI, True);
        // right - top
        CopyTransRect(Bmp, MasterBitmap, R.Right - minwp, R.Top,
                      Rect(MaskData.R.Left + dw + 3 * w - minwp, MaskData.R.Top, MaskData.R.Left + dw + 3 * w - 1, MaskData.R.Top + minh - 1), clFuchsia, CI, True);
        // right - middle
        y := R.Top + h;
        while y < R.Bottom - h do begin
          BitBlt(Bmp.Canvas.Handle, R.Right - minwp, y, minwp, h, MasterBitmap.Canvas.Handle, MaskData.R.Left + dw + 3 * w - minwp, MaskData.R.Top + h, SRCCOPY);
          inc(y, h);
        end;
        if y < R.Bottom - h then
          BitBlt(Bmp.Canvas.Handle, R.Right - minwp, y, minwp, R.Bottom - h - y, MasterBitmap.Canvas.Handle, MaskData.R.Left + dw + 3 * w - minwp, MaskData.R.Top + h, SRCCOPY);

        // Fill
        if (MaskData.DrawMode and BDM_FILL = BDM_FILL) then begin
          y := R.Top + h;
          while y < R.Bottom - 2 * h do begin
            x := R.Left + w;
            while x < R.Right - 2 * w do begin
              BitBlt(Bmp.Canvas.Handle, x, y, w, h, MasterBitmap.Canvas.Handle, MaskData.R.Left + dw + w, MaskData.R.Top + h, SRCCOPY);
              inc(x, w);
            end;
            if x < R.Right - w then
              BitBlt(Bmp.Canvas.Handle, x, y, R.Right - w - x,  R.Bottom - h - y, MasterBitmap.Canvas.Handle, MaskData.R.Left + dw + w, MaskData.R.Top + h, SRCCOPY);

            inc(y, h);
          end;
          x := R.Left + w;
          if y < R.Bottom - h then begin
            while x < R.Right - 2 * w do begin
              BitBlt(Bmp.Canvas.Handle, x, y, w,  R.Bottom - h - y, MasterBitmap.Canvas.Handle, MaskData.R.Left + dw + w, MaskData.R.Top + h, SRCCOPY);
              inc(x, w);
            end;
            if x < R.Right - w then
              BitBlt(Bmp.Canvas.Handle, x, y, R.Right - w - x, R.Bottom - h - y, MasterBitmap.Canvas.Handle, MaskData.R.Left + dw + w, MaskData.R.Top + h, SRCCOPY);
          end;
        end;
      end
      else begin
        CopyMasterRect(Rect(R.Left, R.Top, R.Left + minw + 1, R.Top + minh + 1), Rect(MaskData.R.Left + dw, MaskData.R.Top, MaskData.R.Left + dw + minw, MaskData.R.Top + minh), Bmp, ci, MaskData);
        // left - middle
        y := R.Top + h;
        while y < R.Bottom - h do begin
          CopyMasterRect(Rect(R.Left, y, R.Left + minw + 1, y + h + 1), Rect(MaskData.R.Left + dw, MaskData.R.Top + h, MaskData.R.Left + dw + minw, MaskData.R.Top + 2 * h), Bmp, CI, MaskData);
          inc(y, h);
        end;
        if y < R.Bottom - h then
          CopyMasterRect(Rect(R.Left, y, R.Left + minw, R.Bottom - h), Rect(MaskData.R.Left + dw, MaskData.R.Top + h, MaskData.R.Left + dw + minw, MaskData.R.Top + dh - h), Bmp, CI, MaskData);
        // top - middle
        x := R.Left + w;
        while x < R.Right - 2 * w do begin
          CopyMasterRect(Rect(x, R.Top, x + w, R.Top + minh), Rect(MaskData.R.Left + dw + w, MaskData.R.Top, MaskData.R.Left + dw + 2 * w, MaskData.R.Top + minh), Bmp, CI, MaskData);
          inc(x, w);
        end;
        if x < R.Right - w then
          CopyMasterRect(Rect(x, R.Top, R.Right - w, R.Top + minh), Rect(MaskData.R.Left + dw + w, MaskData.R.Top, MaskData.R.Left + dw + 2 * w, MaskData.R.Top + minh), Bmp, CI, MaskData);
        // left - bottom
        CopyMasterRect(Rect(R.Left, R.Bottom - minhp, R.Left + minw, R.Bottom), Rect(MaskData.R.Left + dw, MaskData.R.Top + dh - minhp, MaskData.R.Left + dw + minw, MaskData.R.Top + dh), Bmp, CI, MaskData);
        // bottom - middle
        x := R.Left + w;
        while x < R.Right - 2 * w do begin
          CopyMasterRect(Rect(x, R.Bottom - minhp, x + w, R.Bottom), Rect(MaskData.R.Left + dw + w, MaskData.R.Top + dh - minhp, MaskData.R.Left + dw + 2 * w, MaskData.R.Top + dh), Bmp, CI, MaskData);
          inc(x, w);
        end;
        if x < R.Right - w then
          CopyMasterRect(Rect(x, R.Bottom - minhp, R.Right - w, R.Bottom), Rect(MaskData.R.Left + dw + w, MaskData.R.Top + dh - minhp, MaskData.R.Left + dw + 2 * w, MaskData.R.Top + dh), Bmp, CI, MaskData);
        // right - bottom
        CopyMasterRect(Rect(R.Right - minwp, R.Bottom - minhp, R.Right, R.Bottom), Rect(MaskData.R.Left + dw + 3 * w - minwp, MaskData.R.Top + dh - minhp, MaskData.R.Left + dw + 3 * w, MaskData.R.Top + dh), Bmp, CI, MaskData);
        // right - top
        CopyMasterRect(Rect(R.Right - minwp, R.Top, R.Right, R.Top + minh), Rect(MaskData.R.Left + dw + 3 * w - minwp, MaskData.R.Top, MaskData.R.Left + dw + 3 * w, MaskData.R.Top + minh), Bmp, CI, MaskData);
        // right - middle
        y := R.Top + h;
        while y < R.Bottom - h do begin
          CopyMasterRect(Rect(R.Right - minwp, y, R.Right, y + h), Rect(MaskData.R.Left + dw + 3 * w - minwp, MaskData.R.Top + h, MaskData.R.Left + dw + 3 * w, MaskData.R.Top + 2 * h), Bmp, CI, MaskData);
          inc(y, h);
        end;
        if y < R.Bottom - h then
          CopyMasterRect(Rect(R.Right - minwp, y, R.Right, R.Bottom - h), Rect(MaskData.R.Left + dw + 3 * w - minwp, MaskData.R.Top + h, MaskData.R.Left + dw + 3 * w, MaskData.R.Top + 2 * h), Bmp, CI, MaskData);
        // Fill
        if (MaskData.DrawMode and BDM_FILL = BDM_FILL) then begin
          y := R.Top + h;
          while y < R.Bottom - h do begin
            x := R.Left + w;
            while x < R.Right - 2 * w do begin
              CopyMasterRect(Rect(x, y, x + w, y + h), Rect(MaskData.R.Left + dw + w, MaskData.R.Top + h, MaskData.R.Left + dw + 2 * w, MaskData.R.Top + 2 * h), Bmp, EmptyCI, MaskData);
              inc(x, w);
            end;
            if x < R.Right - w then
              CopyMasterRect(Rect(x, y, R.Right - w, y + h), Rect(MaskData.R.Left + dw + w, MaskData.R.Top + h, MaskData.R.Left + dw + 2 * w, MaskData.R.Top + 2 * h), Bmp, EmptyCI, MaskData);
            inc(y, h);
          end;
          x := R.Left + w;
          if y < R.Bottom - h then begin
            while x < R.Right - 2 * w do begin
              CopyMasterRect(Rect(x, y, x + w, R.Bottom - h), Rect(MaskData.R.Left + dw + w, MaskData.R.Top + h, MaskData.R.Left + dw + 2 * w, MaskData.R.Top + 2 * h), Bmp, EmptyCI, MaskData);
              inc(x, w);
            end;
            if x < R.Right - w then
              CopyMasterRect(Rect(x, y, R.Right - w, R.Bottom - h), Rect(MaskData.R.Left + dw + w, MaskData.R.Top + h, MaskData.R.Left + dw + 2 * w, MaskData.R.Top + 2 * h), Bmp, EmptyCI, MaskData);
          end;
        end;
      end;
    end;
end;


procedure DrawSkinRect(Bmp: TBitmap; const R: TRect; const ci: TCacheInfo; const MaskData: TsMaskData; const State: integer; const UpdateCorners: boolean);
var
  BmpSrc: TBitmap;
  Stretch: boolean;
  x, y, w, h, dw, dh, dhm: integer;
  NewState, wl, wt, wr, wb: integer;
begin
  if (State = 0) and (MaskData.DrawMode and BDM_ACTIVEONLY = BDM_ACTIVEONLY) then
    Exit;

  if (WidthOf(R) < 2) or (HeightOf(R) < 2) or (MaskData.Manager = nil) then
    Exit;

  wl := MaskData.WL;
  wt := MaskData.WT;
  wr := MaskData.WR;
  wb := MaskData.WB;
  if wl + wr > WidthOf(R) then begin
    y := ((wl + wr) - WidthOf(R));
    x := y div 2;
    dec(wl, x);
    dec(wr, x);
    if y mod 2 > 0 then
      dec(wr);

    if wl < 0 then
      wl := 0;

    if wr < 0 then
      wr := 0;
  end;
  if wt + wb > HeightOf(R) then begin
    y := ((wt + wb) - HeightOf(R));
    x := y div 2;
    dec(wt, x);
    dec(wb, x);
    if y mod 2 > 0 then
      dec(wb);

    if wt < 0 then
      wt := 0;

    if wb < 0 then
      wb := 0;
  end;
  if State >= MaskData.ImageCount then
    NewState := MaskData.ImageCount - 1
  else
    NewState := State;

  dw := WidthOfImage(MaskData);  // Width of mask
  dh := HeightOfImage(MaskData); // Height of mask
  if MaskData.MaskType = 0 then
    dhm := 0
  else
    dhm := dh;

  if MaskData.DrawMode and BDM_STRETCH = BDM_STRETCH then begin
    Stretch := True;
    SetStretchBltMode(Bmp.Canvas.Handle, COLORONCOLOR);
  end
  else
    Stretch := False;

  w := dw - wl - wr;
  if w < 0 then
    Exit;              // Width of middle piece must be > 0

  h := dh - wt - wb;
  if h < 0 then
    Exit;              // Height of middle piece must be > 0

  dw := dw * NewState; // Offset of mask

  if MaskData.Bmp <> nil then
    BmpSrc := MaskData.Bmp
  else
    BmpSrc := TsSkinManager(MaskData.Manager).MasterBitmap;

  if MaskData.MaskType = 0 then begin // Copy without mask
    // left - top
    CopyTransRect(Bmp, BmpSrc, R.Left, R.Top, Rect(MaskData.R.Left + dw, MaskData.R.Top, MaskData.R.Left + dw + wl - 1, MaskData.R.Top + wt - 1), clFuchsia, CI, UpdateCorners and (MaskData.CornerType > 0));
    y := R.Top + wt;
    // left - middle
    if not Stretch then begin
      if h > 0 then
        while y < R.Bottom - h - wb do begin
          BitBlt(Bmp.Canvas.Handle, R.Left, y, wl, h, BmpSrc.Canvas.Handle, MaskData.R.Left + dw, MaskData.R.Top + wt, SRCCOPY);
          inc(y, h);
        end;

      if y < R.Bottom - wb then
        BitBlt(Bmp.Canvas.Handle, R.Left, y, wl, R.Bottom - wb - y, BmpSrc.Canvas.Handle, MaskData.R.Left + dw, MaskData.R.Top + wt, SRCCOPY);
    end
    else
      StretchBlt(Bmp.Canvas.Handle, R.Left, y, wl, R.Bottom - wb - y, BmpSrc.Canvas.Handle, MaskData.R.Left + dw, MaskData.R.Top + wt, wl, h, SRCCOPY);
    // top - middle
    x := R.Left + wl;
    if not Stretch then begin
      if w > 0 then
        while x < R.Right - w - wr do begin
          BitBlt(Bmp.Canvas.Handle, x, R.Top, w, wt, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Top, SRCCOPY);
          inc(x, w);
        end;

      if x < R.Right - wr then
        BitBlt(Bmp.Canvas.Handle, x, R.Top, R.Right - wr - x, wt, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Top, SRCCOPY);
    end
    else
      StretchBlt(Bmp.Canvas.Handle, x, R.Top, R.Right - wr - x, wt, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Top, w, wt, SRCCOPY);

    // left - bottom
    CopyTransRect(Bmp, BmpSrc, R.Left, R.Bottom - wb, Rect(MaskData.R.Left + dw, MaskData.R.Bottom - wb, MaskData.R.Left + dw + wl - 1, MaskData.R.Bottom - 1), clFuchsia, CI, UpdateCorners and (MaskData.CornerType > 0));
    // bottom - middle
    x := R.Left + wl;
    if not Stretch then begin
      if w > 0 then
        while x < R.Right - w - wr do begin
          BitBlt(Bmp.Canvas.Handle, x, R.Bottom - wb, w, wb, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Bottom - wb, SRCCOPY);
          inc(x, w);
        end;

      if x < R.Right - wr then
        BitBlt(Bmp.Canvas.Handle, x, R.Bottom - wb, R.Right - wr - x, wb, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Bottom - wb, SRCCOPY);
    end
    else
      StretchBlt(Bmp.Canvas.Handle, x, R.Bottom - wb, R.Right - wr - x, wb, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Bottom - wb, w, wb, SRCCOPY);

    // right - bottom
    CopyTransRect(Bmp, BmpSrc, R.Right - wr, R.Bottom - wb, Rect(MaskData.R.Left + dw + w + wl, MaskData.R.Bottom - wb, MaskData.R.Left + dw + w + wl + wr - 1, MaskData.R.Bottom - 1), clFuchsia, CI, UpdateCorners and (MaskData.CornerType > 0));
    // right - top
    CopyTransRect(Bmp, BmpSrc, R.Right - wr, R.Top, Rect(MaskData.R.Left + dw + w + wl, MaskData.R.Top, MaskData.R.Left + dw + w + wl + wr - 1, MaskData.R.Top + wt - 1), clFuchsia, CI, UpdateCorners and (MaskData.CornerType > 0));
    y := R.Top + wt;
    // right - middle
    if not Stretch then begin
      if h > 0 then
        while y < R.Bottom - h - wb do begin
          BitBlt(Bmp.Canvas.Handle, R.Right - wr, y, wr, h, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl + w, MaskData.R.Top + wt, SRCCOPY);
          inc(y, h);
        end;

      if y < R.Bottom - wb then
        BitBlt(Bmp.Canvas.Handle, R.Right - wr, y, wr, R.Bottom - wb - y, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + w + wl, MaskData.R.Top + wt, SRCCOPY);
    end
    else
      StretchBlt(Bmp.Canvas.Handle, R.Right - wr, y, wr, R.Bottom - wb - y, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl + w, MaskData.R.Top + wt, wr, h, SRCCOPY);
    // Fill
    if (MaskData.DrawMode and BDM_FILL = BDM_FILL) then begin
      if not Stretch then begin
        y := R.Top + wt;
        if h > 0 then
          while y < R.Bottom - h - wb do begin
            x := R.Left + wl;
            if w > 0 then
              while x < R.Right - w - wr do begin
                BitBlt(Bmp.Canvas.Handle, x, y, w, h, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Top + wt, SRCCOPY);
                inc(x, w);
              end;

            if x < R.Right - wr then
              BitBlt(Bmp.Canvas.Handle, x, y, R.Right - wr - x,  R.Bottom - wb - y, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Top + wt, SRCCOPY);

            inc(y, h);
          end;

        x := R.Left + wl;
        if y < R.Bottom - wb then begin
          if w > 0 then
            while x < R.Right - w - wr do begin
              BitBlt(Bmp.Canvas.Handle, x, y, w, R.Bottom - wb - y, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Top + wt, SRCCOPY);
              inc(x, w);
            end;

          if x < R.Right - wr then
            BitBlt(Bmp.Canvas.Handle, x, y, R.Right - wr - x, R.Bottom - wb - y, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Top + wt, SRCCOPY);
        end;
      end
      else begin
        y := R.Top + wt;
        x := R.Left + wl;
        StretchBlt(Bmp.Canvas.Handle, x, y, R.Right - wr - x, R.Bottom - wb - y, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Top + wt, w, h, SRCCOPY);
      end;
    end;
  end
  else begin
    // left - top
    CopyByMask(Rect(R.Left, R.Top, R.Left + wl, R.Top + wt), Rect(MaskData.R.Left + dw, MaskData.R.Top, MaskData.R.Left + dw + wl, MaskData.R.Top + wt), Bmp, BmpSrc, CI, UpdateCorners and (MaskData.CornerType > 0), MaskData);
    y := R.Top + wt;
    // left - middle
    if not Stretch then begin
      while y < R.Bottom - h - wb do begin
        CopyByMask(Rect(R.Left, y, R.Left + wl, y + h), Rect(MaskData.R.Left + dw, MaskData.R.Top + wt, MaskData.R.Left + dw + wl, MaskData.R.Top + h + wt), Bmp, BmpSrc, EmptyCI, False, MaskData);
        inc(y, h);
      end;
      if y < R.Bottom - wb then
        CopyByMask(Rect(R.Left, y, R.Left + wl, R.Bottom - wb), Rect(MaskData.R.Left + dw, MaskData.R.Top + wt, MaskData.R.Left + dw + wl, MaskData.R.Top + wt + h), Bmp, BmpSrc, EmptyCI, False, MaskData);
    end
    else
      StretchBltMask(R.Left, y, wl, R.Bottom - wb - y, MaskData.R.Left + dw, MaskData.R.Top + wt, wl, h, Bmp, BmpSrc, dhm);

    // top - middle
    x := R.Left + wl;
    if not Stretch then begin
      while x < R.Right - w - wr do begin
        CopyByMask(Rect(x, R.Top, x + w, R.Top + wt), Rect(MaskData.R.Left + dw + wl, MaskData.R.Top, MaskData.R.Left + dw + w + wl, MaskData.R.Top + wt), Bmp, BmpSrc, EmptyCI, False, MaskData);
        inc(x, w);
      end;
      if x < R.Right - wr then
        CopyByMask(Rect(x, R.Top, R.Right - wr, R.Top + wt), Rect(MaskData.R.Left + dw + wl, MaskData.R.Top, MaskData.R.Left + dw + w + wl, MaskData.R.Top + wt), Bmp, BmpSrc, EmptyCI, False, MaskData);
    end
    else
      StretchBltMask(x, R.Top, R.Right - wr - x, wt, MaskData.R.Left + dw + wl, MaskData.R.Top, w, wt, Bmp, BmpSrc, dhm);

    // left - bottom
    CopyByMask(Rect(R.Left, R.Bottom - wb, R.Left + wl, R.Bottom), Rect(MaskData.R.Left + dw, MaskData.R.Top + dh - wb, MaskData.R.Left + dw + wl, MaskData.R.Top + dh), Bmp, BmpSrc, CI, UpdateCorners and (MaskData.CornerType > 0), MaskData);
    // bottom - middle
    x := R.Left + wl;
    if not Stretch then begin
      while x < R.Right - w - wr do begin
        CopyByMask(Rect(x, R.Bottom - wb, x + w, R.Bottom), Rect(MaskData.R.Left + dw + wl, MaskData.R.Top + dh - wb, MaskData.R.Left + dw + w + wl, MaskData.R.Top + dh), Bmp, bmpSrc, EmptyCI, False, MaskData);
        inc(x, w);
      end;
      if x < R.Right - wr then
        CopyByMask(Rect(x, R.Bottom - wb, R.Right - wr, R.Bottom), Rect(MaskData.R.Left + dw + wl, MaskData.R.Top + dh - wb, MaskData.R.Left + dw + w + wl, MaskData.R.Top + dh), Bmp, BmpSrc, EmptyCI, False, MaskData);
    end
    else
      StretchBltMask(x, R.Bottom - wb, R.Right - wr - x, wb, MaskData.R.Left + dw + wl, MaskData.R.Top + dh - wb, w, wb, Bmp, BmpSrc, dhm);

    // right - bottom
    CopyByMask(Rect(R.Right - wr, R.Bottom - wb, R.Right, R.Bottom), Rect(MaskData.R.Left + dw + w + wl, MaskData.R.Top + dh - wb, MaskData.R.Left + dw + w + wl + wr, MaskData.R.Top + dh), Bmp, BmpSrc, CI, UpdateCorners and (MaskData.CornerType > 0), MaskData);
    // right - top
    CopyByMask(Rect(R.Right - wr, R.Top, R.Right, R.Top + wt), Rect(MaskData.R.Left + dw + w + wl, MaskData.R.Top, MaskData.R.Left + dw + w + wl + wr, MaskData.R.Top + wt), Bmp, BmpSrc, CI, UpdateCorners and (MaskData.CornerType > 0), MaskData);
    // right - middle
    y := R.Top + wt;
    if not Stretch then begin
      while y < R.Bottom - h - wb do begin
        CopyByMask(Rect(R.Right - wr, y, R.Right, y + h), Rect(MaskData.R.Left + dw + w + wl, MaskData.R.Top + wt, MaskData.R.Left + dw + w + wl + wr, MaskData.R.Top + h + wt), Bmp, BmpSrc, EmptyCI, False, MaskData);
        inc(y, h);
      end;
      if y < R.Bottom - wb then
        CopyByMask(Rect(R.Right - wr, y, R.Right, R.Bottom - wb), Rect(MaskData.R.Left + dw + w + wl, MaskData.R.Top + wt, MaskData.R.Left + dw + w + wl + wr, MaskData.R.Top + h + wt), Bmp, BmpSrc, EmptyCI, False, MaskData);
    end
    else
      StretchBltMask(R.Right - wr, y, wr, R.Bottom - wb - y, MaskData.R.Left + dw + wl + w, MaskData.R.Top + wt, wr, h, Bmp, BmpSrc, dhm);

    // Fill
    if (MaskData.DrawMode and BDM_FILL = BDM_FILL) then
      if Stretch then begin
        y := R.Top + wt;
        x := R.Left + wl;
        StretchBltMask(x, y, R.Right - wr - x, R.Bottom - wb - y, MaskData.R.Left + dw + wl, MaskData.R.Top + wt, w, h, Bmp, BmpSrc, dhm, True)
      end
      else begin
        y := R.Top + wt;
        while y < R.Bottom - h - wb do begin
          x := R.Left + wl;
          while x < R.Right - w - wr do begin
            CopyByMask(Rect(x, y, x + w, y + h), Rect(MaskData.R.Left + dw + wl, MaskData.R.Top + wt, MaskData.R.Left + dw + w + wl, MaskData.R.Top + h + wt), Bmp, BmpSrc, EmptyCI, False, MaskData);
            inc(x, w);
          end;
          if x < R.Right - wr then
            CopyByMask(Rect(x, y, R.Right - wr, y + h), Rect(MaskData.R.Left + dw + wl, MaskData.R.Top + wt, MaskData.R.Left + dw + w + wl, MaskData.R.Top + h + wt), Bmp, BmpSrc, EmptyCI, False, MaskData);

          inc(y, h);
        end;
        x := R.Left + wl;
        if y < R.Bottom - wb then begin
          while x < R.Right - w - wr do begin
            CopyByMask(Rect(x, y, x + w, R.Bottom - wb), Rect(MaskData.R.Left + dw + wl, MaskData.R.Top + wt, MaskData.R.Left + dw + w + wl, MaskData.R.Top + h + wt), Bmp, BmpSrc, EmptyCI, False, MaskData);
            inc(x, w);
          end;
          if x < R.Right - wr then
            CopyByMask(Rect(x, y, R.Right - wr, R.Bottom - wb), Rect(MaskData.R.Left + dw + wl, MaskData.R.Top + wt, MaskData.R.Left + dw + w + wl, MaskData.R.Top + h + wt), Bmp, BmpSrc, EmptyCI, False, MaskData);
        end;
      end;
  end;
end;


procedure CopyMasterRect(R1, R2: TRect; const Bmp: TBitmap; const CI: TCacheInfo; const MaskData: TsMaskData);
var
  col_: TsColor_;
  S0, D0, S, D, M: PRGBAArray;
  DeltaS, DeltaD, hd2, X, Y, h, w, dx: Integer;
begin
  if MaskData.Manager <> nil then
    with TsSkinManager(MaskData.Manager) do begin
      h := Min(HeightOf(R1), HeightOf(R2));
      h := Min(h, Bmp.Height - R1.Top);
      h := Min(h, TsSkinManager(MaskData.Manager).MasterBitmap.Height - R2.Top) - 1;
      if h < 0 then
        Exit;

      w := Min(WidthOf(R1), WidthOf(R2));
      w := Min(w, Bmp.Width - R1.Left);
      w := Min(w, MasterBitmap.Width - R2.Left) - 1;
      if w < 0 then
        Exit;

      if R1.Left < R2.Left then begin
        if (R1.Left < 0) then begin
          inc(R2.Left, - R1.Left);
          dec(w, - R1.Left);
          R1.Left := 0;
        end;
      end
      else
        if (R2.Left < 0) then begin
          inc(R1.Left, - R2.Left);
          dec(w, - R2.Left);
          R2.Left := 0;
        end;

      if R1.Top < R2.Top then begin
        if (R1.Top < 0) then begin
          inc(R2.Top, - R1.Top);
          dec(h, - R1.Top);
          R1.Top := 0;
        end;
      end
      else
        if (R2.Top < 0) then begin
          inc(R1.Top, - R2.Top);
          dec(h, - R2.Top);
          R2.Top := 0;
        end;

      hd2 := HeightOf(MaskData.R) div 2;
      if InitLine(MasterBitmap, Pointer(S0), DeltaS) and InitLine(Bmp, Pointer(D0), DeltaD) then begin
        col_.C := SwapRedBlue(CI.FillColor);
        if not CI.Ready then
          for Y := 0 to h do begin
            D := Pointer(LongInt(D0) + DeltaD * (R1.Top + Y));
            S := Pointer(LongInt(S0) + DeltaS * (R2.Top + Y));
            M := Pointer(LongInt(S0) + DeltaS * (R2.Top + hd2 + Y));
            for X := 0 to w do begin
              dx := R2.Left + X;
              if (S[dx].C <> clFuchsia) then
                with D[R1.Left + X] do begin
                  R := ((R - S[dx].R) * M[dx].R + S[dx].R shl 8) shr 8;
                  G := ((G - S[dx].G) * M[dx].G + S[dx].G shl 8) shr 8;
                  B := ((B - S[dx].B) * M[dx].B + S[dx].B shl 8) shr 8;
                end
              else
                if CI.FillColor <> clFuchsia then
                  D[R1.Left + X] := col_;
            end;
          end
        else
          for Y := 0 to h do begin
            D := Pointer(LongInt(D0) + DeltaD * (R1.Top + Y));
            S := Pointer(LongInt(S0) + DeltaS * (R2.Top + Y));
            M := Pointer(LongInt(S0) + DeltaS * (R2.Top + hd2 + Y));
            for X := 0 to w do begin
              dx := R2.Left + X;
              if (S[dx].C <> clFuchsia) then
                with D[R1.Left + X] do begin
                  R := ((R - S[dx].R) * M[dx].R + S[dx].R shl 8) shr 8;
                  G := ((G - S[dx].G) * M[dx].G + S[dx].G shl 8) shr 8;
                  B := ((B - S[dx].B) * M[dx].B + S[dx].B shl 8) shr 8;
                end
              else
                if CI.FillColor <> clFuchsia then
                  D[R1.Left + X] := col_
                else begin
                  if (CI.Bmp.Height <= R1.Top + ci.Y + Y) then
                    Continue;

                  if (CI.Bmp.Width <= R1.Left + ci.X + X) then
                    Break;

                  if R1.Top + ci.Y + Y < 0 then
                    Continue;

                  if R1.Left + ci.X + X < 0 then
                    Continue;

                  D[R1.Left + X].C := GetAPixel(ci.Bmp, R1.Left + ci.X + X, R1.Top + ci.Y + Y).C;
                end;
            end;
          end;
      end;
    end;
end;


procedure CopyByMask32(R1, R2: TRect; const Bmp1, Bmp2: TBitmap; const CI: TCacheInfo; const MaskData: TsMaskData);
var
  Cur: TsColor_;
  S0, D0, S, D, M, CacheBMP: PRGBAArray;
  X, Y, h, w, dX1, dX2, hdiv2, k1, aa, a_, DeltaS, DeltaD: integer;
begin
{$IFDEF NOSLOWDETAILS} Exit;{$ENDIF}
  h := R1.Bottom - R1.Top;
  if h > R2.Bottom - R2.Top then
    h := R2.Bottom - R2.Top;

  if h > Bmp1.Height - R1.Top then
    h := Bmp1.Height - R1.Top;

  if h > Bmp2.Height - R2.Top then
    h := Bmp2.Height - R2.Top - 1
  else
    h := h - 1;

  if h >= 0 then begin
    w := R1.Right - R1.Left;
    if w > R2.Right - R2.Left then
      w := R2.Right - R2.Left;

    if w > Bmp1.Width - R1.Left then
      w := Bmp1.Width - R1.Left;

    if w > Bmp2.Width - R2.Left then
      w := Bmp2.Width - R2.Left - 1
    else
      w := w - 1;

    if w >= 0 then begin
      if R1.Left < R2.Left then begin
        if (R1.Left < 0) then begin
          inc(R2.Left, - R1.Left);
          dec(w, - R1.Left);
          R1.Left := 0;
        end;
      end
      else
        if (R2.Left < 0) then begin
          inc(R1.Left, - R2.Left);
          dec(w, - R2.Left);
          R2.Left := 0;
        end;

      if R1.Top < R2.Top then begin
        if (R1.Top < 0) then begin
          inc(R2.Top, - R1.Top);
          dec(h, - R1.Top);
          R1.Top := 0;
        end;
      end
      else
        if (R2.Top < 0) then begin
          inc(R1.Top, - R2.Top);
          dec(h, - R2.Top);
          R2.Top := 0;
        end;

      Cur.A := 0;
      C1.A := 0;
      hdiv2 := (MaskData.R.Bottom - MaskData.R.Top) div 2;
      k1 := min(R2.Top + hdiv2, Bmp2.Height - h - 1); // Mask offset
      if InitLine(Bmp2, Pointer(S0), DeltaS) and InitLine(Bmp1, Pointer(D0), DeltaD) then begin
        if CI.Ready and (CI.Bmp <> nil) then begin
          if h >= CI.Bmp.Height then
            h := CI.Bmp.Height - 1;

          for Y := 0 to h do begin
            S := Pointer(LongInt(S0) + DeltaS * (R2.Top + Y));
            D := Pointer(LongInt(D0) + DeltaD * (R1.Top + Y));
            M := Pointer(LongInt(S0) + DeltaS * (k1 + Y));
            CacheBMP := CI.Bmp.ScanLine[R1.Top + Y + CI.Y];
            dX1 := R1.Left;
            dX2 := R2.Left;
            for X := 0 to w do begin
              cur := S[dX2];
              if cur.C <> clFuchsia then
                with D[dX1] do begin
                  aa := M[dX2].R;
                  a_ := MaxByte - aa;
                  R := (R * aa + cur.R * a_) shr 8;
                  G := (G * aa + cur.G * a_) shr 8;
                  B := (B * aa + cur.B * a_) shr 8;
                  case A of
                    $FF: ;                       // Do not change
                    $00: A := MaxByte - M[dX2].R // Full transparency
                    else A := max(A, MaxByte - M[dX2].R);
                  end;
                end
              else
                D[dX1] := CacheBMP[dX1 + CI.X];

              inc(dX1);
              inc(dX2);
            end;
          end;
        end
        else
          for Y := 0 to h do begin
            S := Pointer(LongInt(S0) + DeltaS * (R2.Top + Y));
            D := Pointer(LongInt(D0) + DeltaD * (R1.Top + Y));
            M := Pointer(LongInt(S0) + DeltaS * (k1 + Y));
            dX1 := R1.Left;
            dX2 := R2.Left;
            for X := 0 to w do begin
              cur := S[dX2];
              with D[dX1] do
                if cur.C <> clFuchsia then begin
                  aa := M[dX2].R;
                  a_ := MaxByte - aa;
                  R := (R * aa + cur.R * a_) shr 8;
                  G := (G * aa + cur.G * a_) shr 8;
                  B := (B * aa + cur.B * a_) shr 8;
                  case A of
                    $FF: ;                       // Do not change
                    $00: A := MaxByte - M[dX2].R // Full transparency
                    else A := max(A, MaxByte - M[dX2].R);
                  end;
                end
                else
                  A := 0;

              inc(dX1);
              inc(dX2);
            end;
          end;
      end;
    end;
  end;
end;


procedure CopyByMask32Ex(R1, R2: TRect; Bmp1, Bmp2: TBitmap; const CI: TCacheInfo; const MaskData: TsMaskData; Opacity: integer);
var
  Cur: TsColor_;
  S0, D0, S, D, M, CacheBMP: PRGBAArray;
  aa, a_, DeltaS, DeltaD, X, Y, h, w, dX1, dX2, hdiv2, k1: integer;
begin
{$IFDEF NOSLOWDETAILS} Exit;{$ENDIF}
  h := R1.Bottom - R1.Top;
  if h > R2.Bottom - R2.Top then
    h := R2.Bottom - R2.Top;

  if h > Bmp1.Height - R1.Top then
    h := Bmp1.Height - R1.Top;

  if h > Bmp2.Height - R2.Top then
    h := Bmp2.Height - R2.Top - 1
  else
    h := h - 1;

  if h >= 0 then begin
    w := R1.Right - R1.Left;
    if w > R2.Right - R2.Left then
      w := R2.Right - R2.Left;

    if w > Bmp1.Width - R1.Left then
      w := Bmp1.Width - R1.Left;

    if w > Bmp2.Width - R2.Left then
      w := Bmp2.Width - R2.Left - 1
    else
      w := w - 1;

    if w >= 0 then begin
      if R1.Left < R2.Left then begin
        if (R1.Left < 0) then begin
          inc(R2.Left, - R1.Left);
          dec(w, - R1.Left);
          R1.Left := 0;
        end;
      end
      else
        if (R2.Left < 0) then begin
          inc(R1.Left, - R2.Left);
          dec(w, - R2.Left);
          R2.Left := 0;
        end;

      if R1.Top < R2.Top then begin
        if (R1.Top < 0) then begin
          inc(R2.Top, - R1.Top);
          dec(h, - R1.Top);
          R1.Top := 0;
        end;
      end
      else
        if (R2.Top < 0) then begin
          inc(R1.Top, - R2.Top);
          dec(h, - R2.Top);
          R2.Top := 0;
        end;

      Cur.A := 0;
      C1.A := 0;
      hdiv2 := (MaskData.R.Bottom - MaskData.R.Top) div 2;
      k1 := min(R2.Top + hdiv2, Bmp2.Height - h - 1); // Mask offset
      if InitLine(Bmp2, Pointer(S0), DeltaS) and InitLine(Bmp1, Pointer(D0), DeltaD) then
        if CI.Ready and (CI.Bmp <> nil) then begin
          if h >= CI.Bmp.Height then
            h := CI.Bmp.Height - 1;

          for Y := 0 to h do begin
            S := Pointer(LongInt(S0) + DeltaS * (R2.Top + Y));
            D := Pointer(LongInt(D0) + DeltaD * (R1.Top + Y));
            M := Pointer(LongInt(S0) + DeltaS * (k1 + Y));
            CacheBMP := CI.Bmp.ScanLine[R1.Top + Y + CI.Y];
            dX1 := R1.Left;
            dX2 := R2.Left;
            for X := 0 to w do begin
              cur := S[dX2];
              if cur.C <> clFuchsia then
                with D[dX1] do begin
                  a_ := (MaxByte - M[dX2].R) * Opacity shr 8;
                  aa := (MaxByte - a_);
                  R := (R * aa + cur.R * a_) shr 8;
                  G := (G * aa + cur.G * a_) shr 8;
                  B := (B * aa + cur.B * a_) shr 8;
                  case A of
                    0:   A := MaxByte - M[dX2].R; // Full transparency
                    $FF:                          // Do not change
                    else A := max(A, MaxByte  - M[dX2].R);
                  end;
                end
              else
                D[dX1] := CacheBMP[dX1 + CI.X];

              inc(dX1);
              inc(dX2);
            end;
          end;
        end
        else
          for Y := 0 to h do begin
            S := Pointer(LongInt(S0) + DeltaS * (R2.Top + Y));
            D := Pointer(LongInt(D0) + DeltaD * (R1.Top + Y));
            M := Pointer(LongInt(S0) + DeltaS * (k1 + Y));
            dX1 := R1.Left;
            dX2 := R2.Left;
            for X := 0 to w do begin
              cur := S[dX2];
              with D[dX1] do begin
                if cur.C <> clFuchsia then begin
                  a_ := (MaxByte - M[dX2].R) * Opacity shr 8;
                  aa := (MaxByte - a_);
                  R := (R * aa + cur.R * a_) shr 8;
                  G := (G * aa + cur.G * a_) shr 8;
                  B := (B * aa + cur.B * a_) shr 8;
                  case A of
                    0:   A := MaxByte  - M[dX2].R; // Full transparency
                    $FF:                           // Do not change
                    else A := max(A, MaxByte  - M[dX2].R);
                  end;
                end
                else
                  A := 0;
              end;
              inc(dX1);
              inc(dX2);
            end;
          end;
    end;
  end;
end;


procedure DrawSkinGlyph(Bmp: TBitmap; P: TPoint; State, AddedTransparency: integer; const MaskData: TsMaskData; const CI: TCacheInfo);
var
  w, h, cy, cx, dw: integer;
begin
  w := WidthOfImage (MaskData);
  h := HeightOfImage(MaskData);

  if State > MaskData.ImageCount - 1 then
    State := MaskData.ImageCount - 1;

  dw := State * w;
  cy := iff(p.y < 0, -p.y, 0);
  cx := iff(p.x < 0, -p.x, 0);
  if MaskData.Bmp = nil then
    with TsSkinManager(MaskData.Manager) do begin
      if (MaskData.Manager <> nil) and (MaskData.ImageCount > 0) then
        if (MaskData.MaskType > 0) then
          BlendGlyphByMask(Rect(p.x + cx, p.y + cy, p.x + w - 1 + cx, p.y + h + cy {- 1}),
                           Rect(dw + cx + MaskData.R.Left, cy + MaskData.R.Top, dw + w - 1 + cx + MaskData.R.Left, h - 1 + cy + MaskData.R.Top),
                           Bmp, MasterBitmap, AddedTransparency, MaskData)
        else
          if AddedTransparency <> 1 then
            BlendTransRectangle(Bmp, p.x + cx, p.y + cy, MasterBitmap,
                                Rect(dw + cx + MaskData.R.Left, cy + MaskData.R.Top, dw + cx + MaskData.R.Left + w - 1,
                                cy + MaskData.R.Top + h - 1), 0.5)
          else
            CopyTransRect(Bmp, MasterBitmap, p.x + cx, p.y + cy,
                          Rect(dw + cx + MaskData.R.Left, cy + MaskData.R.Top, dw + cx + MaskData.R.Left + w - 1,
                          cy + MaskData.R.Top + h - 1), clFuchsia, CI, True);
    end
  else
    if (MaskData.R.Right <= MaskData.Bmp.Width) and (MaskData.R.Bottom <= MaskData.Bmp.Height) then
      BlendGlyphByMask(Rect(p.x + cx, p.y + cy, p.x + w - 1 + cx, p.y + h + cy - 1),
                       Rect(dw + cx + MaskData.R.Left, cy + MaskData.R.Top, dw + w - 1 + cx + MaskData.R.Left, h - 1 + cy + MaskData.R.Top),
                       Bmp, MaskData.Bmp, AddedTransparency, MaskData);
end;


procedure StretchBltMask(DstX1, DstY1, Dst_Width, Dst_Height, SrcX1, SrcY1, Src_Width, Src_Height: integer; BmpDst, BmpSrc: TBitmap; MaskOffset: integer; NoStdStretch: boolean = False);
var
  CC: TsColor_RGB_;
  S0, S: PRGBAArray_RGB;
  D0, M0, D, M: PRGBAArray;
  MaskBmp, Bmp, TmpBmp: TBitmap;
  DeltaM, DeltaS, DeltaD, X, Y, iY, iX: Integer;
begin
  if (DstX1 < 0) or (DstY1 < 0) or (Dst_Width < 0) or (Dst_Height < 1) or (Dst_Width < 1) or (BmpDst.Height < 2) or (BmpDst.Width < 2) then
    Exit;

  if (MaskOffset <> 0) then begin // If masked
    if BmpSrc.Width < SrcX1 + Src_Width then
      Exit;

    if BmpSrc.Height < SrcY1 + Src_Height then
      Exit;

    if NoStdStretch and (Src_Width = 1) and (Src_Height = 1) then begin
      if SrcY1 + MaskOffset >= BmpSrc.Height then
        Exit;

      if InitLine(BmpSrc, Pointer(S0), DeltaS) and InitLine(BmpDst, Pointer(D0), DeltaD) then begin
        S := Pointer(LongInt(S0) + DeltaS * SrcY1);
        CC.Col := S[SrcX1].Col;
        M := Pointer(LongInt(S0) + DeltaS * (SrcY1 + MaskOffset));
        CC.Alpha := M[SrcX1].R; // Get mask value
        case CC.Alpha of
          0: begin // If not transparent pixel
            CC.Col := SwapRedBlue(CC.Col);
            FillRect32(BmpDst, Rect(DstX1, DstY1, DstX1 + Dst_Width, DstY1 + Dst_Height), CC.Col);
          end;

          $FF: // Dst Changed

          else
            for Y := DstY1 to DstY1 + Dst_Height - 1 do begin
              D := Pointer(LongInt(D0) + DeltaD * Y);
              for X := DstX1 to DstX1 + Dst_Width - 1 do
                with D[X], CC do begin
                  R := ((R - CC.Red)   * CC.Alpha + CC.Red   shl 8) shr 8;
                  G := ((G - CC.Green) * CC.Alpha + CC.Green shl 8) shr 8;
                  B := ((B - CC.Blue)  * CC.Alpha + CC.Blue  shl 8) shr 8;
                end;
            end;
        end;
      end;
      Exit;
    end;

    Bmp := CreateBmp32(Dst_Width, Dst_Height);
    MaskBmp := CreateBmp32(Dst_Width, Dst_Height);
    if ((Src_Width > Dst_Width) and (Src_Height = Dst_Height) or (Src_Width = Dst_Width) and (Src_Height > Dst_Height) or NoStdStretch) and (Dst_Width > 1) and (Dst_Height > 1) then begin
      TmpBmp := CreateBmp32(max(Src_Width, 2), max(Src_Height, 2));
      BitBlt(TmpBmp.Canvas.Handle, 0, 0, Src_Width, Src_Height, BmpSrc.Canvas.Handle, SrcX1, SrcY1, SRCCOPY);
      if Src_Width = 1 then
        BitBlt(TmpBmp.Canvas.Handle, 1, 0, 1, Src_Height, TmpBmp.Canvas.Handle, 0, 0, SRCCOPY);

      if Src_Height = 1 then
        BitBlt(TmpBmp.Canvas.Handle, 0, 1, Src_Width, 1, TmpBmp.Canvas.Handle, 0, 0, SRCCOPY);

      Stretch(TmpBmp, Bmp, Dst_Width, Dst_Height, ftMitchell);
      BitBlt(TmpBmp.Canvas.Handle, 0, 0, Src_Width, Src_Height, BmpSrc.Canvas.Handle, SrcX1, SrcY1 + MaskOffset, SRCCOPY);
      if Src_Width = 1 then
        BitBlt(TmpBmp.Canvas.Handle, 1, 0, 1, Src_Height, TmpBmp.Canvas.Handle, 0, 0, SRCCOPY);

      if Src_Height = 1 then
        BitBlt(TmpBmp.Canvas.Handle, 0, 1, Src_Width, 1, TmpBmp.Canvas.Handle, 0, 0, SRCCOPY);

      Stretch(TmpBmp, MaskBmp, Dst_Width, Dst_Height, ftMitchell);
      TmpBmp.Free;
    end
    else begin
      StretchBlt(Bmp.Canvas.Handle, 0, 0, Dst_Width, Dst_Height, BmpSrc.Canvas.Handle, SrcX1, SrcY1, Src_Width, Src_Height, SRCCOPY);
      StretchBlt(MaskBmp.Canvas.Handle, 0, 0, Dst_Width, Dst_Height, BmpSrc.Canvas.Handle, SrcX1, SrcY1 + MaskOffset, Src_Width, Src_Height, SRCCOPY);
    end;
    iY := 0;
    if DstY1 + Dst_Height > BmpDst.Height then
      Dst_Height := BmpDst.Height - DstY1;

    if InitLine(Bmp, Pointer(S0), DeltaS) and InitLine(MaskBmp, Pointer(M0), DeltaM) and InitLine(BmpDst, Pointer(D0), DeltaD) then
      for Y := DstY1 to DstY1 + Dst_Height - 1 do begin
        D := Pointer(LongInt(D0) + DeltaD * Y);
        S := Pointer(LongInt(S0) + DeltaS * iY);
        M := Pointer(LongInt(M0) + DeltaM * iY);
        iX := 0;
        for X := DstX1 to DstX1 + Dst_Width - 1 do
          with D[X], S[iX] do begin
            R := ((R - Red)   * M[iX].R + Red   shl 8) shr 8;
            G := ((G - Green) * M[iX].G + Green shl 8) shr 8;
            B := ((B - Blue)  * M[iX].B + Blue  shl 8) shr 8;
            A := MaxByte;
            inc(iX);
          end;

        inc(iY);
      end;

    MaskBmp.Free;
    Bmp.Free;
  end
  else
    StretchBlt(BmpDst.Canvas.Handle, DstX1, DstY1, Dst_Width, Dst_Height, BmpSrc.Canvas.Handle, SrcX1, SrcY1, Src_Width, Src_Height, SRCCOPY);
end;


procedure StretchBltMask32(DstX1, DstY1, Dst_Width, Dst_Height, SrcX1, SrcY1, Src_Width, Src_Height: integer; BmpDst, BmpSrc: TBitmap; MaskOffset: integer; NoStdStretch: boolean = False);
var
  aa, a_: byte;
  CC: TsColor_RGB_;
  S0, S: PRGBAArray_RGB;
  D0, M0, D, M: PRGBAArray;
  MaskBmp, Bmp, TmpBmp: TBitmap;
  DeltaM, DeltaS, DeltaD, X, Y, iY, iX: Integer;
begin
  if (DstX1 < 0) or (DstY1 < 0) or (Dst_Width < 0) or (Dst_Height < 1) or (Dst_Width < 1) or (BmpDst.Height < 2) or (BmpDst.Width < 2) then
    Exit;

  if (MaskOffset <> 0) then begin // If masked
    if BmpSrc.Width < SrcX1 + Src_Width then
      Exit;

    if BmpSrc.Height < SrcY1 + Src_Height then
      Exit;

    if NoStdStretch and (Src_Width = 1) and (Src_Height = 1) then begin
      if SrcY1 + MaskOffset >= BmpSrc.Height then
        Exit;

      if InitLine(BmpSrc, Pointer(S0), DeltaS) and InitLine(BmpDst, Pointer(D0), DeltaD) then begin
        S := Pointer(LongInt(S0) + DeltaS * SrcY1);
        CC.Col := S[SrcX1].Col;
        M := Pointer(LongInt(S0) + DeltaS * (SrcY1 + MaskOffset));
        CC.Alpha := M[SrcX1].R; // Get mask value

        CC := S[SrcX1];
        CC.Alpha := M[SrcX1].R; // Get mask value
        case CC.Alpha of
          MaxByte:
            ; // Dst Changed
          0: begin // If not transparent pixel
            CC.Col := SwapRedBlue(CC.Col);
            FillRect32(BmpDst, Rect(DstX1, DstY1, DstX1 + Dst_Width, DstY1 + Dst_Height), CC.Col);
          end
          else
            for Y := DstY1 to DstY1 + Dst_Height - 1 do begin
              D := Pointer(LongInt(D0) + DeltaD * Y);
              for X := DstX1 to DstX1 + Dst_Width - 1 do
                with D[X], CC do begin
                  aa := min(CC.Alpha, A);
                  a_ := MaxByte - aa;
                  R := (R * aa + Red   * a_) shr 8;
                  G := (G * aa + Green * a_) shr 8;
                  B := (B * aa + Blue  * a_) shr 8;
                  A := max(A, MaxByte - Alpha);
                end;
            end;
        end;
      End;
      Exit;
    end;

    Bmp     := CreateBmp32(Dst_Width, Dst_Height);
    MaskBmp := CreateBmp32(Dst_Width, Dst_Height);
    if ((Src_Width > Dst_Width) and (Src_Height = Dst_Height) or (Src_Width = Dst_Width) and (Src_Height > Dst_Height) or NoStdStretch) and (Dst_Width > 1) and (Dst_Height > 1) then begin
      TmpBmp := CreateBmp32(max(Src_Width, 2), max(Src_Height, 2));
      BitBlt(TmpBmp.Canvas.Handle, 0, 0, Src_Width, Src_Height, BmpSrc.Canvas.Handle, SrcX1, SrcY1, SRCCOPY);
      if Src_Width = 1 then
        BitBlt(TmpBmp.Canvas.Handle, 1, 0, 1, Src_Height, TmpBmp.Canvas.Handle, 0, 0, SRCCOPY);

      if Src_Height = 1 then
        BitBlt(TmpBmp.Canvas.Handle, 0, 1, Src_Width, 1, TmpBmp.Canvas.Handle, 0, 0, SRCCOPY);

      Stretch(TmpBmp, Bmp, Dst_Width, Dst_Height, ftMitchell);
      BitBlt(TmpBmp.Canvas.Handle, 0, 0, Src_Width, Src_Height, BmpSrc.Canvas.Handle, SrcX1, SrcY1 + MaskOffset, SRCCOPY);
      if Src_Width = 1 then
        BitBlt(TmpBmp.Canvas.Handle, 1, 0, 1, Src_Height, TmpBmp.Canvas.Handle, 0, 0, SRCCOPY);

      if Src_Height = 1 then
        BitBlt(TmpBmp.Canvas.Handle, 0, 1, Src_Width, 1, TmpBmp.Canvas.Handle, 0, 0, SRCCOPY);

      Stretch(TmpBmp, MaskBmp, Dst_Width, Dst_Height, ftHermite);
      TmpBmp.Free;
    end
    else begin
      StretchBlt(Bmp.Canvas.Handle,     0, 0, Dst_Width, Dst_Height, BmpSrc.Canvas.Handle, SrcX1, SrcY1,              Src_Width, Src_Height, SRCCOPY);
      StretchBlt(MaskBmp.Canvas.Handle, 0, 0, Dst_Width, Dst_Height, BmpSrc.Canvas.Handle, SrcX1, SrcY1 + MaskOffset, Src_Width, Src_Height, SRCCOPY);
    end;

    iY := 0;
    if DstY1 + Dst_Height > BmpDst.Height then
      Dst_Height := BmpDst.Height - DstY1;

    if InitLine(Bmp, Pointer(S0), DeltaS) and InitLine(MaskBmp, Pointer(M0), DeltaM) and InitLine(BmpDst, Pointer(D0), DeltaD) then
      for Y := DstY1 to DstY1 + Dst_Height - 1 do begin
        D := Pointer(LongInt(D0) + DeltaD * Y);
        S := Pointer(LongInt(S0) + DeltaS * iY);
        M := Pointer(LongInt(M0) + DeltaM * iY);
        iX := 0;
        for X := DstX1 to DstX1 + Dst_Width - 1 do begin
          with D[X], S[iX] do
            case M[iX].R of
              MaxByte:
                ; // Continue;

              0: begin
                I := Intg;
                A := MaxByte;
              end

              else begin
                aa := min(M[iX].R, A);
                a_ := MaxByte - aa;
                R := (R * aa + Red   * a_) shr 8;
                G := (G * aa + Green * a_) shr 8;
                B := (B * aa + Blue  * a_) shr 8;
                A := max(A, MaxByte - M[iX].R);
              end;
            end;

          inc(iX);
        end;
        inc(iY);
      end;

    MaskBmp.Free;
    Bmp.Free;
  end
  else
    StretchBlt(BmpDst.Canvas.Handle, DstX1, DstY1, Dst_Width, Dst_Height, BmpSrc.Canvas.Handle, SrcX1, SrcY1, Src_Width, Src_Height, SRCCOPY);
end;


procedure StretchBltMask32Ex(DstX1, DstY1, Dst_Width, Dst_Height, SrcX1, SrcY1, Src_Width, Src_Height: integer; BmpDst, BmpSrc: TBitmap; MaskOffset: integer; Opacity: integer; NoStdStretch: boolean = False);
var
  DeltaM, DeltaS, DeltaD, X, Y, iY, iX: Integer;
  MaskBmp, Bmp, TmpBmp: TBitmap;
  D0, M0, D, M: PRGBAArray;
  S0, S: PRGBAArray_RGB;
  CC: TsColor_RGB_;
  aa, a_: byte;
begin
  if (DstX1 < 0) or (DstY1 < 0) or (Dst_Width < 0) or (Dst_Height < 1) or (Dst_Width < 1) or (BmpDst.Height < 2) or (BmpDst.Width < 2) then
    Exit;

  if (MaskOffset <> 0) then begin // If masked
    if (BmpSrc.Width < SrcX1 + Src_Width) or (BmpSrc.Height < SrcY1 + Src_Height) then
      Exit;

    if NoStdStretch and (Src_Width = 1) and (Src_Height = 1) then begin
      if SrcY1 + MaskOffset >= BmpSrc.Height then
        Exit;

      if InitLine(BmpSrc, Pointer(S0), DeltaS) and InitLine(BmpDst, Pointer(D0), DeltaD) then begin
        S := Pointer(LongInt(S0) + DeltaS * SrcY1);
        CC.Col := S[SrcX1].Col;
        M := Pointer(LongInt(S0) + DeltaS * (SrcY1 + MaskOffset));
        CC.Alpha := M[SrcX1].R; // Get mask value
        CC := S[SrcX1];
        CC.Alpha := M[SrcX1].R; // Get mask value
        case CC.Alpha of
          MaxByte:
            ; // Dst Changed

          0: begin // If not transparent pixel
            CC.Col := SwapRedBlue(CC.Col);
            FillRect32(BmpDst, Rect(DstX1, DstY1, DstX1 + Dst_Width, DstY1 + Dst_Height), CC.Col);
          end

          else
            for Y := DstY1 to DstY1 + Dst_Height - 1 do begin
              D := Pointer(LongInt(D0) + DeltaD * Y);
              for X := DstX1 to DstX1 + Dst_Width - 1 do
                with D[X], CC do begin
                  a_ := (MaxByte - CC.Alpha) * Opacity shr 8;
                  aa := (MaxByte - a_);
                  R := (R * aa + Red   * a_) shr 8;
                  G := (G * aa + Green * a_) shr 8;
                  B := (B * aa + Blue  * a_) shr 8;
                  case A of
                    0:   A := MaxByte - Alpha;         // Full transparency
                    $FF:                               // Do not change
                    else begin
                      aa := MaxByte - Alpha;
                      if aa > A then
                        A := aa;
                    end;
                  end;
                end;
            end;
        end;
      End;
      Exit;
    end;
    Bmp := CreateBmp32(Dst_Width, Dst_Height);
    MaskBmp := CreateBmp32(Dst_Width, Dst_Height);
    if ((Src_Width > Dst_Width) and
          (Src_Height = Dst_Height) or (Src_Width = Dst_Width) and
            (Src_Height > Dst_Height) or NoStdStretch) and
              (Dst_Width > 1) and
                (Dst_Height > 1) then begin
      TmpBmp := CreateBmp32(max(Src_Width, 2), max(Src_Height, 2));
      BitBlt(TmpBmp.Canvas.Handle, 0, 0, Src_Width, Src_Height, BmpSrc.Canvas.Handle, SrcX1, SrcY1, SRCCOPY);
      if Src_Width = 1 then
        BitBlt(TmpBmp.Canvas.Handle, 1, 0, 1, Src_Height, TmpBmp.Canvas.Handle, 0, 0, SRCCOPY);

      if Src_Height = 1 then
        BitBlt(TmpBmp.Canvas.Handle, 0, 1, Src_Width, 1, TmpBmp.Canvas.Handle, 0, 0, SRCCOPY);

      Stretch(TmpBmp, Bmp, Dst_Width, Dst_Height, ftMitchell);
      BitBlt(TmpBmp.Canvas.Handle, 0, 0, Src_Width, Src_Height, BmpSrc.Canvas.Handle, SrcX1, SrcY1 + MaskOffset, SRCCOPY);
      if Src_Width = 1 then
        BitBlt(TmpBmp.Canvas.Handle, 1, 0, 1, Src_Height, TmpBmp.Canvas.Handle, 0, 0, SRCCOPY);

      if Src_Height = 1 then
        BitBlt(TmpBmp.Canvas.Handle, 0, 1, Src_Width, 1, TmpBmp.Canvas.Handle, 0, 0, SRCCOPY);
        
      Stretch(TmpBmp, MaskBmp, Dst_Width, Dst_Height, ftHermite);
      TmpBmp.Free;
    end
    else begin
      StretchBlt(Bmp.Canvas.Handle, 0, 0, Dst_Width, Dst_Height, BmpSrc.Canvas.Handle, SrcX1, SrcY1, Src_Width, Src_Height, SRCCOPY);
      StretchBlt(MaskBmp.Canvas.Handle, 0, 0, Dst_Width, Dst_Height, BmpSrc.Canvas.Handle, SrcX1, SrcY1 + MaskOffset, Src_Width, Src_Height, SRCCOPY);
    end;

    iY := 0;
    if DstY1 + Dst_Height > BmpDst.Height then
      Dst_Height := BmpDst.Height - DstY1;

    if DstX1 + Dst_Width > BmpDst.Width then
      Dst_Width := BmpDst.Width - DstX1;

    if InitLine(Bmp, Pointer(S0), DeltaS) and InitLine(MaskBmp, Pointer(M0), DeltaM) and InitLine(BmpDst, Pointer(D0), DeltaD) then
      for Y := DstY1 to DstY1 + Dst_Height - 1 do begin
        D := Pointer(LongInt(D0) + DeltaD * Y);
        S := Pointer(LongInt(S0) + DeltaS * iY);
        M := Pointer(LongInt(M0) + DeltaM * iY);
        iX := 0;
        for X := DstX1 to DstX1 + Dst_Width - 1 do begin
          with D[X], S[iX] do
            case M[iX].R of
              MaxByte:
                ; // Continue;

              0: begin
                I := Intg;
                A := MaxByte;
              end

              else begin
                a_ := (MaxByte - M[iX].R) * Opacity shr 8;
                aa := (MaxByte - a_);
                R := (R * aa + Red   * a_) shr 8;
                G := (G * aa + Green * a_) shr 8;
                B := (B * aa + Blue  * a_) shr 8;
                case A of
                  0:   A := MaxByte - M[iX].R;         // Full transparency
                  $FF:                                 // Do not change
                  else begin
                    aa := MaxByte - M[iX].R;
                    if aa > A then
                      A := aa;
                  end;
                end;
              end;
            end;

          inc(iX);
        end;
        inc(iY);
      end;

    MaskBmp.Free;
    Bmp.Free;
  end
  else
    StretchBlt(BmpDst.Canvas.Handle, DstX1, DstY1, Dst_Width, Dst_Height, BmpSrc.Canvas.Handle, SrcX1, SrcY1, Src_Width, Src_Height, SRCCOPY);
end;


procedure BlendGlyphByMask(R1, R2: TRect; Bmp1, Bmp2: TBitmap; AddedTransparency: integer; const MaskData: TsMaskData);
var
  cc: TsColor_RGB_;
  D0, D, M: PRGBAArray;
  S0, S: PRGBAArray_RGB;DeltaS, DeltaD: integer;
  X, Y, h, w, hdiv2, dx1, dy1, dx2, dy2: Integer;
begin
  hdiv2 := HeightOf(MaskData.R) div (MaskData.MaskType + 1);
  h := Min(HeightOf(R1), HeightOf(R2));
  h := min(h, Bmp1.Height - R1.Top - 1);
  h := min(h, Bmp2.Height - R2.Top - hdiv2 - 1);

  if MaskData.ImageCount < 1 then
    h := min(h, hdiv2 - R2.Top - 1);

  w := Min(WidthOf(R1), WidthOf(R2));
  w := min(w, Bmp1.Width - R1.Left - 1);

  if MaskData.ImageCount < 1 then
    w := min(w, Bmp2.Width - R2.Left - 1);

  if MaskData.MaskType = 0 then
    CopyTransRectA(Bmp1, Bmp2, R1.Left, R1.Top, R2, clFuchsia, EmptyCI)
  else
    if R2.Top + h <= Bmp2.Height then begin
      cc.Alpha := 0;
      dy1 := R1.Top;
      dy2 := R2.Top;
      if Bmp1.PixelFormat = pf32bit then
        if InitLine(Bmp2, Pointer(S0), DeltaS) and InitLine(Bmp1, Pointer(D0), DeltaD) then
          for Y := 0 to h do begin
            S := Pointer(LongInt(S0) + DeltaS * dy2);
            D := Pointer(LongInt(D0) + DeltaD * dy1);
            M := Pointer(LongInt(S0) + DeltaS * (dy2 + hdiv2));
            dx1 := R1.Left;
            dx2 := R2.Left;
            for X := 0 to w do begin
              cc := S[R2.Left + X];
              with D[dx1], S[dx2] do
                if (Col <> clFuchsia) and (M[dx2].R <> MaxByte) then
                  if AddedTransparency <> 1 then begin
                    R := ((R - Red)   * min(M[dx2].R + 100, MaxByte) + Red   shl 8) shr 8;
                    G := ((G - Green) * min(M[dx2].G + 100, MaxByte) + Green shl 8) shr 8;
                    B := ((B - Blue)  * min(M[dx2].B + 100, MaxByte) + Blue  shl 8) shr 8;
                    A := A + ((MaxByte - A) * (MaxByte - M[dx2].R)) shr 8;
                  end
                  else begin
                    R := ((R - Red)   * M[dx2].R + Red   shl 8) shr 8;
                    G := ((G - Green) * M[dx2].G + Green shl 8) shr 8;
                    B := ((B - Blue)  * M[dx2].B + Blue  shl 8) shr 8;
                    A := A + ((MaxByte - A) * (MaxByte - M[dx2].R)) shr 8;
                  end;

              inc(dx1);
              inc(dx2);
            end;
            inc(dy1);
            inc(dy2);
          end;
    end;
end;


procedure CopyTransCorner(const SrcBmp: Graphics.TBitMap; const X, Y: integer; SrcRect: TRect; const BGInfo: TacBGInfo; const SkinData: TsCommonData);
var
  S0, D0, Dst, Src: PRGBAArray;
  h, w, DeltaS, DeltaD, sX, sY, SrcX, DstX, DstY: integer;
begin
  if SrcRect.Top < 0 then
    SrcRect.Top := 0;

  if SrcRect.Bottom > SrcBmp.Height - 1 then
    SrcRect.Bottom := SrcBmp.Height - 1;

  if SrcRect.Left < 0 then
    SrcRect.Left := 0;

  if SrcRect.Right > SrcBmp.Width - 1 then
    SrcRect.Right := SrcBmp.Width - 1;

  h := HeightOf(SrcRect);
  w := WidthOf (SrcRect);
  if InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(SkinData.FCacheBmp, Pointer(D0), DeltaD) then begin
    if (BGInfo.BgType = btCache) and (BGInfo.Bmp <> nil) then
      for sY := 0 to h do begin
        DstY := sY + Y;
        if (BGInfo.Offset.Y + DstY >= BGInfo.Bmp.Height) or (BGInfo.Offset.Y + DstY < 0) then
          Continue;

        if (DstY <= SkinData.FCacheBmp.Height - 1) and (DstY >= 0) then begin
          Src := Pointer(LongInt(S0) + DeltaS * (sY + SrcRect.Top));
          Dst := Pointer(LongInt(D0) + DeltaD * DstY);
          for sX := 0 to w do begin
            DstX := sX + X;
            if (DstX <= SkinData.FCacheBmp.Width - 1) and (DstX >= 0) then begin
              SrcX := sX + SrcRect.Left;
              if (Src[SrcX].C = clFuchsia) {if transparent pixel} then begin
                if (BGInfo.Offset.X + DstX >= BGInfo.Bmp.Width) or (BGInfo.Offset.X + DstX < 0) then
                  Continue;

                Dst[DstX].C := {SwapRedBlue}(GetAPixel(BGInfo.Bmp, BGInfo.Offset.X + DstX, BGInfo.Offset.Y + DstY).C);
              end;
            end;
          end
        end;
      end
    else
      if BGInfo.Color <> clFuchsia then
        for sY := 0 to h do begin
          DstY := sY + Y;
          if (DstY <= SkinData.FCacheBmp.Height - 1) and (DstY >= 0) then begin
            Src := Pointer(LongInt(S0) + DeltaS * (sY + SrcRect.Top));
            Dst := Pointer(LongInt(D0) + DeltaD * DstY);
            for sX := 0 to w do begin
              DstX := sX + X;
              if (DstX <= SkinData.FCacheBmp.Width - 1) and (DstX >= 0) then
                if (Src[sX + SrcRect.Left].C = clFuchsia) then
                  Dst[DstX].C := SwapRedBlue(BGInfo.Color);
            end
          end;
        end;
  end;
end;


procedure CopyMasterCorner(R1, R2: TRect; const Bmp: TBitmap; const BGInfo: TacBGInfo; const SkinData: TsCommonData);
var
  X, Y, h, w, DeltaS, DeltaD: integer;
  S0, D0, S, D: PRGBAArray;
  col_: TsColor_;
begin
  h := Min(HeightOf(R1), HeightOf(R2));
  h := Min(h, SkinData.FCacheBmp.Height - R1.Top);
  h := Min(h, Bmp.Height - R2.Top) - 1;
  if h >= 0 then begin
    w := Min(WidthOf(R1), WidthOf(R2));
    w := Min(w, SkinData.FCacheBmp.Width - R1.Left);
    w := Min(w, Bmp.Width - R2.Left) - 1;
    if w >= 0 then begin
      if R1.Left < R2.Left then begin
        if (R1.Left < 0) then begin
          inc(R2.Left, - R1.Left);
          dec(w, - R1.Left);
          R1.Left := 0;
        end;
      end
      else
        if (R2.Left < 0) then begin
          inc(R1.Left, - R2.Left);
          dec(w, - R2.Left);
          R2.Left := 0;
        end;

      if R1.Top < R2.Top then begin
        if (R1.Top < 0) then begin
          inc(R2.Top, - R1.Top);
          dec(h, - R1.Top);
          R1.Top := 0;
        end;
      end
      else
        if (R2.Top < 0) then begin
          inc(R1.Top, - R2.Top);
          dec(h, - R2.Top);
          R2.Top := 0;
        end;

      col_.C := BGInfo.Color;
      col_.B := TsColor(BGInfo.Color).B;
      col_.R := TsColor(BGInfo.Color).R;
      if InitLine(Bmp, Pointer(S0), DeltaS) and InitLine(SkinData.FCacheBmp, Pointer(D0), DeltaD) then
        if BGInfo.BgType <> btCache then
          for Y := 0 to h do begin
            S := Pointer(LongInt(S0) + DeltaS * (R2.Top + Y));
            D := Pointer(LongInt(D0) + DeltaD * (R1.Top + Y));
            for X := 0 to w do
              if (S[R2.Left + X].C = clFuchsia) then
                D[R1.Left + X] := col_;
          end
        else
          for Y := 0 to h do begin
            S := Pointer(LongInt(S0) + DeltaS * (R2.Top + Y));
            D := Pointer(LongInt(D0) + DeltaD * (R1.Top + Y));
            if BGInfo.BgType <> btCache then begin
              for X := 0 to w do
                if (S[R2.Left + X].C = clFuchsia) then
                  D[R1.Left + X] := col_;
            end
            else
              for X := 0 to w do
                if (S[R2.Left + X].C = clFuchsia) then begin
                  if (BGInfo.Bmp.Height <= R1.Top + BGInfo.Offset.Y + Y) then
                    Continue;

                  if (BGInfo.Bmp.Width <= R1.Left + BGInfo.Offset.X + X) then
                    Break;

                  if R1.Top + BGInfo.Offset.Y + Y < 0 then
                    Break;

                  if R1.Left + BGInfo.Offset.X + X < 0 then
                    Continue;

                  D[R1.Left + X].C := GetAPixel(BGInfo.Bmp, R1.Left + BGInfo.Offset.X + X, R1.Top + BGInfo.Offset.Y + Y).C;
                end
          end;
    end;
  end;
end;


procedure UpdateCorners(SkinData: TsCommonData; State: integer; Corners: TsCorners = [scLeftTop, scLeftBottom, scRightTop, scRightBottom]);
var
  w, Width, Height, dw, dh, wl, wt, wr, wb: integer;
  MaskData: TsMaskData;
  BGInfo: TacBGInfo;
  SrcBmp: TBitmap;
begin
  if not Skindata.SkinManager.IsValidImgIndex(SkinData.BorderIndex) or not Assigned(SkinData.FCacheBmp) or (SkinData.FOwnerControl = nil) then
    Exit;

  MaskData := SkinData.SkinManager.ma[SkinData.BorderIndex];
  if MaskData.CornerType <> 0 then begin
    BGInfo.PleaseDraw := False;
    BGInfo.DrawDC := 0;
    if SkinData.FOwnerControl.Parent = nil then
      if SkinData.FOwnerControl is TWinControl then
        GetBGInfo(@BGInfo, GetParent(TWinControl(SkinData.FOwnerControl).Handle))
      else
        Exit
    else
      GetBGInfo(@BGInfo, SkinData.FOwnerControl.Parent);

    Width  := SkinData.FOwnerControl.Width;
    Height := SkinData.FOwnerControl.Height;
    wl := MaskData.WL;
    wt := MaskData.WT;
    wr := MaskData.WR;
    wb := MaskData.WB;
    if (MaskData.ImageCount = 0) and (MaskData.Bmp <> nil) then begin // if external
      MaskData.MaskType := 1;
      MaskData.ImageCount := 3;
      MaskData.R := MkRect(MaskData.Bmp);
    end;

    if BGInfo.BgType = btCache then begin
      inc(BGInfo.Offset.X, SkinData.FOwnerControl.Left);
      inc(BGInfo.Offset.Y, SkinData.FOwnerControl.Top);
    end;

    if State >= MaskData.ImageCount then State := MaskData.ImageCount - 1;
    dw := State * (WidthOfImage(MaskData));
    dh := HeightOfImage(MaskData);

    w := WidthOfImage(MaskData) - wl - wr;             // Width of piece of mask

    if MaskData.Bmp <> nil then
      SrcBmp := MaskData.Bmp
    else
      SrcBmp := SkinData.SkinManager.MasterBitmap;
    
    if MaskData.MaskType = 0 then begin // Copy without mask
      if (scLeftTop in Corners) then
        CopyTransCorner(SrcBmp, 0, 0, Rect(MaskData.R.Left + dw, MaskData.R.Top, MaskData.R.Left + dw + wl - 1, MaskData.R.Top + wt - 1), BGInfo, SkinData);

      if (scLeftBottom in Corners) then
        CopyTransCorner(SrcBmp, 0, Height - wb, Rect(MaskData.R.Left + dw, MaskData.R.Bottom - wb, MaskData.R.Left + dw + wl - 1, MaskData.R.Bottom - 1), BGInfo, SkinData);

      if (scRightBottom in Corners) then
        CopyTransCorner(SrcBmp, Width - wr, Height - wb, Rect(MaskData.R.Left + dw + wl + w, MaskData.R.Bottom - wb, MaskData.R.Left + dw + wl + w + wr - 1, MaskData.R.Bottom - 1), BGInfo, SkinData);

      if (scRightTop in Corners) then
        CopyTransCorner(SrcBmp, Width - wr, 0, Rect(MaskData.R.Left + dw + wl + w, MaskData.R.Top, MaskData.R.Left + dw + wl + w + wr - 1, MaskData.R.Top + wt - 1), BGInfo, SkinData);
    end
    else begin
      if (scLeftTop in Corners) then
        CopyMasterCorner(MkRect(wl + 1, wt + 1), Rect(MaskData.R.Left + dw, MaskData.R.Top, MaskData.R.Left + dw + wl, MaskData.R.Top + wt), SrcBmp, BGInfo, SkinData);

      if (scLeftBottom in Corners) then
        CopyMasterCorner(Rect(0, Height - wb, wl, Height), Rect(MaskData.R.Left + dw, MaskData.R.Top + dh - wb, MaskData.R.Left + dw + wl, MaskData.R.Top + dh), SrcBmp, BGInfo, SkinData);

      if (scRightBottom in Corners) then
        CopyMasterCorner(Rect(Width - wr, Height - wb, Width, Height), Rect(MaskData.R.Left + dw + wl + w, MaskData.R.Top + dh - wb, MaskData.R.Left + dw + wl + w + wr, MaskData.R.Top + dh), SrcBmp, BGInfo, SkinData);

      if (scRightTop in Corners) then
        CopyMasterCorner(Rect(Width - wr, 0, Width, wt), Rect(MaskData.R.Left + dw + wl + w, MaskData.R.Top, MaskData.R.Left + dw + wl + w + wr, MaskData.R.Top + wt), SrcBmp, BGInfo, SkinData);
    end;
  end;
end;
{$ENDIF}


{$IFNDEF WIN64}
procedure FillLongword(var X; Count: Integer; Value: Longword);
asm
// EAX = X
// EDX = Count
// ECX = Value
    PUSH  EDI
    MOV   EDI, EAX // Point EDI to destination
    MOV   EAX, ECX
    MOV   ECX, EDX
    TEST  ECX, ECX
    JS    @exit
    REP   STOSD    // Fill count dwords
@exit:
    POP   EDI
end;
{$ENDIF}


procedure PaintItem32(SkinIndex: integer; Filling: boolean; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TObject = nil); overload;
var
  mState: integer;
  CacheBmp: TBitmap;
begin
  if (ItemBmp <> nil) and not IsRectEmpty(R) then begin
    if (SkinManager = nil) then
      SkinManager := DefaultManager;

    if Assigned(SkinManager) and TsSkinManager(SkinManager).IsValidSkinIndex(SkinIndex) and (R.Bottom <= ItemBmp.Height) and (R.Right <= ItemBmp.Width) and
        (R.Left >= 0) and (R.Top >= 0) then begin
      // Count of allowed states is limited in skin
      if TsSkinManager(SkinManager).gd[SkinIndex].States <= State then
        State := TsSkinManager(SkinManager).gd[SkinIndex].States - 1;

      mState := min(State, ac_MaxPropsIndex);
      CacheBmp := CreateBmp32(WidthOf(R) + 1, HeightOf(R) + 1);
      BitBlt(CacheBmp.Canvas.Handle, 0, 0, CacheBmp.Width, CacheBmp.Height, ItemBmp.Canvas.Handle, R.Left, R.Top, SRCCOPY);
      PaintItemBG32(SkinIndex, mState {normal or hot}, R, ItemBmp, SkinManager);
      if TsSkinManager(SkinManager).IsValidImgIndex(TsSkinManager(SkinManager).gd[SkinIndex].BorderIndex) then
        DrawSkinRect32(ItemBmp, R, MakeCacheInfo(CacheBmp, -R.Left, -R.Top), TsSkinManager(SkinManager).ma[TsSkinManager(SkinManager).gd[SkinIndex].BorderIndex], State);

      CacheBmp.Free;
      if (ItemBmp.Width = WidthOf(R)) and (ItemBmp.Height = HeightOf(R)) then
        UpdateAlpha(ItemBmp, R) // Updating for using of bitmap in layered windows
    end;
  end;
end;


procedure PaintItemBG32(SkinIndex: integer; State: integer; R: TRect; ItemBmp: TBitmap; SkinManager: TObject; CustomColor: TColor = clFuchsia);
var
  C: TsColor;
  aRect: TRect;
  Color: TColor;
  iDrawed: boolean;
  sMan: TsSkinManager;
  GradientArray: TsGradArray;
  ImagePercent, GradientPercent, PatternIndex, Transparency: integer;

  procedure PaintAddons(var aBmp: TBitmap);
  var
    bmp: TBitmap;
    R: TRect;
  begin
    iDrawed := False;
    if (ImagePercent + GradientPercent = 100) and
         (GradientPercent in [1..99]) and
           (sMan.ma[PatternIndex].DrawMode = 0) and
             (GradientArray[0].Mode1 < 2) and
               sMan.IsValidImgIndex(PatternIndex) then // Optimized drawing
      if sMan.ma[PatternIndex].Bmp <> nil then
        PaintGradTxt(aBmp, aRect, GradientArray, sMan.ma[PatternIndex].Bmp, sMan.ma[PatternIndex].R, MaxByte * ImagePercent div 100, Round(1 - Transparency / 100) * MaxByte)
      else
        PaintGradTxt(aBmp, aRect, GradientArray, sMan.MasterBitmap, sMan.ma[PatternIndex].R, MaxByte * ImagePercent div 100, Round(1 - Transparency / 100) * MaxByte)
    else begin
      R := aRect;
      // BGImage painting
      if (ImagePercent > 0) then
        with sMan do begin
          if (PatternIndex > -1) and (PatternIndex < Length(ma)) then begin
            if boolean(ma[PatternIndex].MaskType) then
              TileMasked(aBmp, R, EmptyCI {!}, ma[PatternIndex], acFillModes[ma[PatternIndex].DrawMode])
            else
              TileBitmap(aBmp.Canvas, R, ma[PatternIndex].Bmp, ma[PatternIndex], acFillModes[ma[PatternIndex].DrawMode]);

            iDrawed := True;
          end;
          if R.Right <> -1 then
            FillRect32(aBmp, R, Color); // If not all rect was filled by texture
        end;
      // BGGradient painting
      if (GradientPercent > 0) then
        if iDrawed then begin // If texture exists
          Bmp := CreateBmp32(WidthOf(aRect, True), HeightOf(aRect, True));
          try
            if Length(GradientArray) > 0 then
              PaintGrad(Bmp, MkRect(Bmp), GradientArray)
            else
              FillRect32(Bmp, aRect, Color);

            SumBmpRect(aBmp, Bmp, max(min((ImagePercent * integer(MaxByte)) div 100, MaxByte), 0), MkRect(Bmp), aRect.TopLeft);
          finally
            FreeAndNil(Bmp);
          end;
        end
        else
          if Length(GradientArray) > 0 then
            PaintGrad(aBmp, aRect, GradientArray)
          else begin
            FillRect32(aBmp, aRect, Color);
            Exit;
          end;

      case GradientPercent + ImagePercent of
        1..99:
          BlendColorRect(aBmp, aRect, GradientPercent + ImagePercent, Color); // Mix with color

        0: begin
          // Just fill by color
          C := GetAPixel(aBmp, R.Left, R.Top);
          if C.I <> 0 then
            case Transparency of
              0:   FillRect32 (aBmp, aRect, Color, MaxByte);
              100: FillRect32 (aBmp, aRect, Color, C.A);
              else BlendRect32(aBmp, aRect, Color, 100 - Transparency, max(C.A, (100 - Transparency) * MaxByte div 100));
            end
          else
            FillRect32(aBmp, aRect, Color, (100 - Transparency) * MaxByte div 100);

          Exit; // AlphaChannel is ready
        end;
      end;
    end;
  end;
  
begin
  sMan := TsSkinManager(SkinManager);
  if Assigned(sMan) and sMan.IsValidSkinIndex(SkinIndex) then begin
    Transparency := sMan.gd[SkinIndex].Props[min(State, ac_MaxPropsIndex)].Transparency;
    if (Transparency = 100) then begin
      if (ItemBmp.Width = WidthOf(R)) and (ItemBmp.Height = HeightOf(R)) then // Make
        FillRect32(ItemBmp, R, clBlack, 0);
    end // Exit without changes
    else
      with sMan do begin
        aRect := R;
        PatternIndex := -1;
        if CustomColor = clFuchsia then begin // Get skin props
          State := min(State, ac_MaxPropsIndex);
          Color := gd[SkinIndex].Props[State].Color;
          ImagePercent := gd[SkinIndex].Props[State].ImagePercent;
          GradientPercent := gd[SkinIndex].Props[State].GradientPercent;
          if GradientPercent > 0 then
            GradientArray := gd[SkinIndex].Props[State].GradientArray;

          if (ImagePercent > 0) then
            PatternIndex := gd[SkinIndex].Props[State].TextureIndex
        end
        else begin // Filling by custom color only
          ImagePercent := 0;
          GradientPercent := 0;
          Color := CustomColor;
          Transparency := 0;
        end;
        PaintAddons(ItemBmp);
      end;
  end;
end;


procedure DrawSkinRect32(Bmp: TBitmap; const R: TRect; const ci: TCacheInfo; const MaskData: TsMaskData; const State: integer);
var
  BmpSrc: TBitmap;
  Stretch: boolean;
  x, y, w, h, dw, dh, dhm: integer;
  wl, wt, wr, wb, NewState: integer;
begin
  if (State = 0) and (MaskData.DrawMode and BDM_ACTIVEONLY = BDM_ACTIVEONLY) then
    Exit;

  if (WidthOf(R) < 2) or (HeightOf(R) < 2) or (MaskData.Manager = nil) then
    Exit;
    
  wl := MaskData.WL;
  wt := MaskData.WT;
  wr := MaskData.WR;
  wb := MaskData.WB;
  if wl + wr > WidthOf(R) then begin
    y := ((wl + wr) - WidthOf(R));
    x := y div 2;
    dec(wl, x);
    dec(wr, x);
    if y mod 2 > 0 then
      dec(wr);
      
    if wl < 0 then
      wl := 0;

    if wr < 0 then
      wr := 0;
  end;
  if wt + wb > HeightOf(R) then begin
    y := ((wt + wb) - HeightOf(R));
    x := y div 2;
    dec(wt, x);
    dec(wb, x);
    if y mod 2 > 0 then
      dec(wb);

    if wt < 0 then
      wt := 0;

    if wb < 0 then
      wb := 0;
  end;
  if State >= MaskData.ImageCount then
    NewState := MaskData.ImageCount - 1
  else
    NewState := State;
    
  dw := WidthOfImage(MaskData);                  // Width of mask
  dh := HeightOfImage(MaskData);                 // Height of mask
  if MaskData.MaskType = 0 then
    dhm := 0
  else
    dhm := dh;

  if MaskData.DrawMode and BDM_STRETCH = BDM_STRETCH then begin
    Stretch := True;
    SetStretchBltMode(Bmp.Canvas.Handle, COLORONCOLOR);
  end
  else
    Stretch := False;

  w := dw - wl - wr;
  if w < 0 then
    Exit;      // Width of middle piece must be > 0

  h := dh - wt - wb;
  if h < 0 then
    Exit;      // Height of middle piece must be > 0

  dw := dw * NewState;                        // Offset of mask

  if MaskData.Bmp <> nil then
    BmpSrc := MaskData.Bmp
  else
    BmpSrc := TsSkinManager(MaskData.Manager).MasterBitmap;

  if MaskData.MaskType = 0 then begin // Copy without mask
    // left - top
    CopyTransRect(Bmp, BmpSrc, R.Left, R.Top, Rect(MaskData.R.Left + dw, MaskData.R.Top, MaskData.R.Left + dw + wl - 1, MaskData.R.Top + wt - 1), clFuchsia, CI, True);
    y := R.Top + wt;
    // left - middle
    if not Stretch then begin
      if h > 0 then
        while y < R.Bottom - h - wb do begin
          BitBlt(Bmp.Canvas.Handle, R.Left, y, wl, h, BmpSrc.Canvas.Handle, MaskData.R.Left + dw, MaskData.R.Top + wt, SRCCOPY);
          inc(y, h);
        end;

      if y < R.Bottom - wb then
        BitBlt(Bmp.Canvas.Handle, R.Left, y, wl, R.Bottom - wb - y, BmpSrc.Canvas.Handle, MaskData.R.Left + dw, MaskData.R.Top + wt, SRCCOPY);
    end
    else
      StretchBlt(Bmp.Canvas.Handle, R.Left, y, wl, R.Bottom - wb - y, BmpSrc.Canvas.Handle, MaskData.R.Left + dw, MaskData.R.Top + wt, wl, h, SRCCOPY);

    // top - middle
    x := R.Left + wl;
    if not Stretch then begin
      if w > 0 then
        while x < R.Right - w - wr do begin
          BitBlt(Bmp.Canvas.Handle, x, R.Top, w, wt, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Top, SRCCOPY);
          inc(x, w);
        end;

      if x < R.Right - wr then
        BitBlt(Bmp.Canvas.Handle, x, R.Top, R.Right - wr - x, wt, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Top, SRCCOPY);
    end
    else
      StretchBlt(Bmp.Canvas.Handle, x, R.Top, R.Right - wr - x, wt, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Top, w, wt, SRCCOPY);

    // left - bottom
    CopyTransRect(Bmp, BmpSrc, R.Left, R.Bottom - wb, Rect(MaskData.R.Left + dw, MaskData.R.Bottom - wb, MaskData.R.Left + dw + wl - 1, MaskData.R.Bottom - 1), clFuchsia, CI, True);

    // bottom - middle
    x := R.Left + wl;
    if not Stretch then begin
      if w > 0 then
        while x < R.Right - w - wr do begin
          BitBlt(Bmp.Canvas.Handle, x, R.Bottom - wb, w, wb, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Bottom - wb, SRCCOPY);
          inc(x, w);
        end;

      if x < R.Right - wr then
        BitBlt(Bmp.Canvas.Handle, x, R.Bottom - wb, R.Right - wr - x, wb, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Bottom - wb, SRCCOPY);
    end
    else
      StretchBlt(Bmp.Canvas.Handle, x, R.Bottom - wb, R.Right - wr - x, wb, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Bottom - wb, w, wb, SRCCOPY);

    // right - bottom
    CopyTransRect(Bmp, BmpSrc, R.Right - wr, R.Bottom - wb, Rect(MaskData.R.Left + dw + w + wl, MaskData.R.Bottom - wb, MaskData.R.Left + dw + w + wl + wr - 1, MaskData.R.Bottom - 1), clFuchsia, CI, True);
    // right - top
    CopyTransRect(Bmp, BmpSrc, R.Right - wr, R.Top, Rect(MaskData.R.Left + dw + w + wl, MaskData.R.Top, MaskData.R.Left + dw + w + wl + wr - 1, MaskData.R.Top + wt - 1), clFuchsia, CI, True);
    y := R.Top + wt;
    // right - middle
    if not Stretch then begin
      if h > 0 then
        while y < R.Bottom - h - wb do begin
          BitBlt(Bmp.Canvas.Handle, R.Right - wr, y, wr, h, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl + w, MaskData.R.Top + wt, SRCCOPY);
          inc(y, h);
        end;

      if y < R.Bottom - wb then
        BitBlt(Bmp.Canvas.Handle, R.Right - wr, y, wr, R.Bottom - wb - y, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + w + wl, MaskData.R.Top + wt, SRCCOPY);
    end
    else
      StretchBlt(Bmp.Canvas.Handle, R.Right - wr, y, wr, R.Bottom - wb - y, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl + w, MaskData.R.Top + wt, wr, h, SRCCOPY);

    // Fill
    if (MaskData.DrawMode and BDM_FILL = BDM_FILL) then
      if not Stretch then begin
        y := R.Top + wt;
        if h > 0 then
          while y < R.Bottom - h - wb do begin
            x := R.Left + wl;
            if w > 0 then
              while x < R.Right - w - wr do begin
                BitBlt(Bmp.Canvas.Handle, x, y, w, h, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Top + wt, SRCCOPY);
                inc(x, w);
              end;

            if x < R.Right - wr then
              BitBlt(Bmp.Canvas.Handle, x, y, R.Right - wr - x,  R.Bottom - wb - y, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Top + wt, SRCCOPY);

            inc(y, h);
          end;

        x := R.Left + wl;
        if y < R.Bottom - wb then begin
          if w > 0 then
            while x < R.Right - w - wr do begin
              BitBlt(Bmp.Canvas.Handle, x, y, w, R.Bottom - wb - y, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Top + wt, SRCCOPY);
              inc(x, w);
            end;

          if x < R.Right - wr then
            BitBlt(Bmp.Canvas.Handle, x, y, R.Right - wr - x, R.Bottom - wb - y, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Top + wt, SRCCOPY);
        end;
      end
      else begin
        y := R.Top + wt;
        x := R.Left + wl;
        StretchBlt(Bmp.Canvas.Handle, x, y, R.Right - wr - x, R.Bottom - wb - y, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Top + wt, w, h, SRCCOPY);
      end;
  end
  else begin
    // left - top
    CopyByMask32(Rect(R.Left, R.Top, R.Left + wl, R.Top + wt), Rect(MaskData.R.Left + dw, MaskData.R.Top, MaskData.R.Left + dw + wl, MaskData.R.Top + wt), Bmp, BmpSrc, CI, MaskData);
    y := R.Top + wt;
    // left - middle
    if not Stretch then begin
      while y < R.Bottom - h - wb do begin
        CopyByMask32(Rect(R.Left, y, R.Left + wl, y + h), Rect(MaskData.R.Left + dw, MaskData.R.Top + wt, MaskData.R.Left + dw + wl, MaskData.R.Top + h + wt), Bmp, BmpSrc, EmptyCI, MaskData);
        inc(y, h);
      end;
      if y < R.Bottom - wb then
        CopyByMask32(Rect(R.Left, y, R.Left + wl, R.Bottom - wb), Rect(MaskData.R.Left + dw, MaskData.R.Top + wt, MaskData.R.Left + dw + wl, MaskData.R.Top + wt + h), Bmp, BmpSrc, EmptyCI, MaskData);
    end
    else
      StretchBltMask32(R.Left, y, wl, R.Bottom - wb - y, MaskData.R.Left + dw, MaskData.R.Top + wt, wl, h, Bmp, BmpSrc, dhm);
    // top - middle
    x := R.Left + wl;
    if not Stretch then begin
      while x < R.Right - w - wr do begin
        CopyByMask32(Rect(x, R.Top, x + w, R.Top + wt), Rect(MaskData.R.Left + dw + wl, MaskData.R.Top, MaskData.R.Left + dw + w + wl, MaskData.R.Top + wt), Bmp, BmpSrc, EmptyCI, MaskData);
        inc(x, w);
      end;
      if x < R.Right - wr then
        CopyByMask32(Rect(x, R.Top, R.Right - wr, R.Top + wt), Rect(MaskData.R.Left + dw + wl, MaskData.R.Top, MaskData.R.Left + dw + w + wl, MaskData.R.Top + wt), Bmp, BmpSrc, EmptyCI, MaskData);
    end
    else
      StretchBltMask32(x, R.Top, R.Right - wr - x, wt, MaskData.R.Left + dw + wl, MaskData.R.Top, w, wt, Bmp, BmpSrc, dhm);

    // left - bottom
    CopyByMask32(Rect(R.Left, R.Bottom - wb, R.Left + wl, R.Bottom), Rect(MaskData.R.Left + dw, MaskData.R.Top + dh - wb, MaskData.R.Left + dw + wl, MaskData.R.Top + dh), Bmp, BmpSrc, CI, MaskData);
    // bottom - middle
    x := R.Left + wl;
    if not Stretch then begin
      while x < R.Right - w - wr do begin
        CopyByMask32(Rect(x, R.Bottom - wb, x + w, R.Bottom), Rect(MaskData.R.Left + dw + wl, MaskData.R.Top + dh - wb, MaskData.R.Left + dw + w + wl, MaskData.R.Top + dh), Bmp, BmpSrc, EmptyCI, MaskData);
        inc(x, w);
      end;
      if x < R.Right - wr then
        CopyByMask32(Rect(x, R.Bottom - wb, R.Right - wr, R.Bottom), Rect(MaskData.R.Left + dw + wl, MaskData.R.Top + dh - wb, MaskData.R.Left + dw + w + wl, MaskData.R.Top + dh), Bmp, BmpSrc, EmptyCI, MaskData);
    end
    else
      StretchBltMask32(x, R.Bottom - wb, R.Right - wr - x, wb, MaskData.R.Left + dw + wl, MaskData.R.Top + dh - wb, w, wb, Bmp, BmpSrc, dhm);

    // right - bottom
    CopyByMask32(Rect(R.Right - wr, R.Bottom - wb, R.Right, R.Bottom), Rect(MaskData.R.Left + dw + w + wl, MaskData.R.Top + dh - wb, MaskData.R.Left + dw + w + wl + wr, MaskData.R.Top + dh), Bmp, BmpSrc, CI, MaskData);
    // right - top
    CopyByMask32(Rect(R.Right - wr, R.Top, R.Right, R.Top + wt), Rect(MaskData.R.Left + dw + w + wl, MaskData.R.Top, MaskData.R.Left + dw + w + wl + wr, MaskData.R.Top + wt), Bmp, BmpSrc, CI, MaskData);
    // right - middle
    y := R.Top + wt;
    if not Stretch then begin
      while y < R.Bottom - h - wb do begin
        CopyByMask32(Rect(R.Right - wr, y, R.Right, y + h), Rect(MaskData.R.Left + dw + w + wl, MaskData.R.Top + wt, MaskData.R.Left + dw + w + wl + wr, MaskData.R.Top + h + wt), Bmp, BmpSrc, EmptyCI, MaskData);
        inc(y, h);
      end;
      if y < R.Bottom - wb then
        CopyByMask32(Rect(R.Right - wr, y, R.Right, R.Bottom - wb), Rect(MaskData.R.Left + dw + w + wl, MaskData.R.Top + wt, MaskData.R.Left + dw + w + wl + wr, MaskData.R.Top + h + wt), Bmp, BmpSrc, EmptyCI, MaskData);
    end
    else
      StretchBltMask32(R.Right - wr, y, wr, R.Bottom - wb - y, MaskData.R.Left + dw + wl + w, MaskData.R.Top + wt, wr, h, Bmp, BmpSrc, dhm);
    // Fill
    if (MaskData.DrawMode and BDM_FILL = BDM_FILL) then
      if Stretch then begin
        y := R.Top + wt;
        x := R.Left + wl;
        StretchBltMask32(x, y, R.Right - wr - x, R.Bottom - wb - y, MaskData.R.Left + dw + wl, MaskData.R.Top + wt, w, h, Bmp, BmpSrc, dhm, True)
      end
      else begin
        y := R.Top + wt;
        while y < R.Bottom - h - wb do begin
          x := R.Left + wl;
          while x < R.Right - w - wr do begin
            CopyByMask32(Rect(x, y, x + w, y + h), Rect(MaskData.R.Left + dw + wl, MaskData.R.Top + wt, MaskData.R.Left + dw + w + wl, MaskData.R.Top + h + wt), Bmp, BmpSrc, EmptyCI, MaskData);
            inc(x, w);
          end;
          if x < R.Right - wr then
            CopyByMask32(Rect(x, y, R.Right - wr, y + h), Rect(MaskData.R.Left + dw + wl, MaskData.R.Top + wt, MaskData.R.Left + dw + w + wl, MaskData.R.Top + h + wt), Bmp, BmpSrc, EmptyCI, MaskData);

          inc(y, h);
        end;
        x := R.Left + wl;
        if y < R.Bottom - wb then begin
          while x < R.Right - w - wr do begin
            CopyByMask32(Rect(x, y, x + w, R.Bottom - wb), Rect(MaskData.R.Left + dw + wl, MaskData.R.Top + wt, MaskData.R.Left + dw + w + wl, MaskData.R.Top + h + wt), Bmp, BmpSrc, EmptyCI, MaskData);
            inc(x, w);
          end;
          if x < R.Right - wr then
            CopyByMask32(Rect(x, y, R.Right - wr, R.Bottom - wb), Rect(MaskData.R.Left + dw + wl, MaskData.R.Top + wt, MaskData.R.Left + dw + w + wl, MaskData.R.Top + h + wt), Bmp, BmpSrc, EmptyCI, MaskData);
        end;
      end;
  end;
end;


procedure DrawSkinRect32Ex(Bmp: TBitmap; const R: TRect; const ci: TCacheInfo; const MaskData: TsMaskData; const State: integer; MaxWidths: TRect; Opacity: integer);
var
  x, y, w, h, dw, dh, dhm: integer;
  NewState, wl, wt, wr, wb: integer;
  maxl, maxt, maxr, maxb: integer;
  BmpSrc: TBitmap;
  Stretch: boolean;
begin
  if (State = 0) and (MaskData.DrawMode and BDM_ACTIVEONLY = BDM_ACTIVEONLY) then
    Exit;

  if (WidthOf(R) < 2) or (HeightOf(R) < 2) or (MaskData.Manager = nil) then
    Exit;
    
  wl := MaskData.WL;
  wt := MaskData.WT;
  wr := MaskData.WR;
  wb := MaskData.WB;
  if wl + wr > WidthOf(R) then begin
    y := (wl + wr) - WidthOf(R);
    x := y div 2;
    dec(wl, x);
    dec(wr, x);
    if y mod 2 > 0 then
      dec(wr);

    if wl < 0 then
      wl := 0;

    if wr < 0 then
      wr := 0;
  end;
  if wt + wb > HeightOf(R) then begin
    y := ((wt + wb) - HeightOf(R));
    x := y div 2;
    dec(wt, x);
    dec(wb, x);
    if y mod 2 > 0 then
      dec(wb);

    if wt < 0 then
      wt := 0;

    if wb < 0 then
      wb := 0;
  end;
  if State >= MaskData.ImageCount then
    NewState := MaskData.ImageCount - 1
  else
    NewState := State;

  dw := WidthOfImage(MaskData);                  // Width of mask
  dh := HeightOfImage(MaskData);                 // Height of mask
  if MaskData.MaskType = 0 then
    dhm := 0
  else
    dhm := dh;

  if MaskData.DrawMode and BDM_STRETCH = BDM_STRETCH then begin
    Stretch := True;
    SetStretchBltMode(Bmp.Canvas.Handle, COLORONCOLOR);
  end
  else
    Stretch := False;

  w := dw - wl - wr;
  if w < 0 then
    Exit; // Width of middle piece must be > 0

  h := dh - wt - wb;
  if h < 0 then
    Exit; // Height of middle piece must be > 0

  dw := dw * NewState; // Offset of mask

  if MaskData.Bmp <> nil then
    BmpSrc := MaskData.Bmp
  else
    BmpSrc := TsSkinManager(MaskData.Manager).MasterBitmap;

  MaxT := min(wt, MaxWidths.Top);
  MaxL := min(wl, MaxWidths.Left);
  MaxR := min(wr, MaxWidths.Right);
  MaxB := min(wb, MaxWidths.Bottom);

  if MaskData.MaskType = 0 then begin // Copy without mask
    // left - top
    CopyTransRect(Bmp, BmpSrc, R.Left, R.Top, Rect(MaskData.R.Left + dw, MaskData.R.Top, MaskData.R.Left + dw + wl - 1, MaskData.R.Top + wt - 1), clFuchsia, CI, True);
    y := R.Top + wt;
    // left - middle
    if not Stretch then begin
      if h > 0 then
        while y < R.Bottom - h - wb do begin
          BitBlt(Bmp.Canvas.Handle, R.Left, y, wl, h, BmpSrc.Canvas.Handle, MaskData.R.Left + dw, MaskData.R.Top + wt, SRCCOPY);
          inc(y, h);
        end;

      if y < R.Bottom - wb then
        BitBlt(Bmp.Canvas.Handle, R.Left, y, wl, R.Bottom - wb - y, BmpSrc.Canvas.Handle, MaskData.R.Left + dw, MaskData.R.Top + wt, SRCCOPY);
    end
    else
      StretchBlt(Bmp.Canvas.Handle, R.Left, y, wl, R.Bottom - wb - y, BmpSrc.Canvas.Handle, MaskData.R.Left + dw, MaskData.R.Top + wt, wl, h, SRCCOPY);

    // top - middle
    x := R.Left + wl;
    if not Stretch then begin
      if w > 0 then
        while x < R.Right - w - wr do begin
          BitBlt(Bmp.Canvas.Handle, x, R.Top, w, wt, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Top, SRCCOPY);
          inc(x, w);
        end;

      if x < R.Right - wr then
        BitBlt(Bmp.Canvas.Handle, x, R.Top, R.Right - wr - x, wt, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Top, SRCCOPY);
    end
    else
      StretchBlt(Bmp.Canvas.Handle, x, R.Top, R.Right - wr - x, wt, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Top, w, wt, SRCCOPY);

    // left - bottom
    CopyTransRect(Bmp, BmpSrc, R.Left, R.Bottom - wb, Rect(MaskData.R.Left + dw, MaskData.R.Bottom - wb, MaskData.R.Left + dw + wl - 1, MaskData.R.Bottom - 1), clFuchsia, CI, True);

    // bottom - middle
    x := R.Left + wl;
    if not Stretch then begin
      if w > 0 then
        while x < R.Right - w - wr do begin
          BitBlt(Bmp.Canvas.Handle, x, R.Bottom - wb, w, wb, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Bottom - wb, SRCCOPY);
          inc(x, w);
        end;

      if x < R.Right - wr then
        BitBlt(Bmp.Canvas.Handle, x, R.Bottom - wb, R.Right - wr - x, wb, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Bottom - wb, SRCCOPY);
    end
    else
      StretchBlt(Bmp.Canvas.Handle, x, R.Bottom - wb, R.Right - wr - x, wb, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Bottom - wb, w, wb, SRCCOPY);

    // right - bottom
    CopyTransRect(Bmp, BmpSrc, R.Right - wr, R.Bottom - wb, Rect(MaskData.R.Left + dw + w + wl, MaskData.R.Bottom - wb, MaskData.R.Left + dw + w + wl + wr - 1, MaskData.R.Bottom - 1), clFuchsia, CI, True);
    // right - top
    CopyTransRect(Bmp, BmpSrc, R.Right - wr, R.Top, Rect(MaskData.R.Left + dw + w + wl, MaskData.R.Top, MaskData.R.Left + dw + w + wl + wr - 1, MaskData.R.Top + wt - 1), clFuchsia, CI, True);
    y := R.Top + wt;
    // right - middle
    if not Stretch then begin
      if h > 0 then
        while y < R.Bottom - h - wb do begin
          BitBlt(Bmp.Canvas.Handle, R.Right - wr, y, wr, h, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl + w, MaskData.R.Top + wt, SRCCOPY);
          inc(y, h);
        end;

      if y < R.Bottom - wb then
        BitBlt(Bmp.Canvas.Handle, R.Right - wr, y, wr, R.Bottom - wb - y, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + w + wl, MaskData.R.Top + wt, SRCCOPY);
    end
    else
      StretchBlt(Bmp.Canvas.Handle, R.Right - wr, y, wr, R.Bottom - wb - y, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl + w, MaskData.R.Top + wt, wr, h, SRCCOPY);

    // Fill
    if (MaskData.DrawMode and BDM_FILL = BDM_FILL) then
      if not Stretch then begin
        y := R.Top + wt;
        if h > 0 then
          while y < R.Bottom - h - wb do begin
            x := R.Left + wl;
            if w > 0 then
              while x < R.Right - w - wr do begin
                BitBlt(Bmp.Canvas.Handle, x, y, w, h, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Top + wt, SRCCOPY);
                inc(x, w);
              end;

            if x < R.Right - wr then
              BitBlt(Bmp.Canvas.Handle, x, y, R.Right - wr - x,  R.Bottom - wb - y, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Top + wt, SRCCOPY);

            inc(y, h);
          end;

        x := R.Left + wl;
        if y < R.Bottom - wb then begin
          if w > 0 then
            while x < R.Right - w - wr do begin
              BitBlt(Bmp.Canvas.Handle, x, y, w, R.Bottom - wb - y, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Top + wt, SRCCOPY);
              inc(x, w);
            end;

          if x < R.Right - wr then
            BitBlt(Bmp.Canvas.Handle, x, y, R.Right - wr - x, R.Bottom - wb - y, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Top + wt, SRCCOPY);
        end;
      end
      else begin
        y := R.Top + wt;
        x := R.Left + wl;
        StretchBlt(Bmp.Canvas.Handle, x, y, R.Right - wr - x, R.Bottom - wb - y, BmpSrc.Canvas.Handle, MaskData.R.Left + dw + wl, MaskData.R.Top + wt, w, h, SRCCOPY);
      end;
  end
  else begin
    // left - top
    CopyByMask32Ex(Rect(R.Left, R.Top, R.Left + wl, R.Top + wt), Rect(MaskData.R.Left + dw, MaskData.R.Top, MaskData.R.Left + dw + wl, MaskData.R.Top + wt), Bmp, BmpSrc, CI, MaskData, Opacity);
    y := R.Top + wt;
    // left - middle
    if not Stretch then begin
      while y < R.Bottom - h - wb do begin
        CopyByMask32Ex(Rect(R.Left, y, R.Left + MaxL, y + h), Rect(MaskData.R.Left + dw, MaskData.R.Top + wt, MaskData.R.Left + dw + MaxL, MaskData.R.Top + h + wt), Bmp, BmpSrc, EmptyCI, MaskData, Opacity);
        inc(y, h);
      end;
      if y < R.Bottom - wb then
        CopyByMask32Ex(Rect(R.Left, y, R.Left + MaxL, R.Bottom - wb), Rect(MaskData.R.Left + dw, MaskData.R.Top + wt, MaskData.R.Left + dw + MaxL, MaskData.R.Top + wt + h), Bmp, BmpSrc, EmptyCI, MaskData, Opacity);
    end
    else
      StretchBltMask32Ex(R.Left, y, MaxL, R.Bottom - wb - y, MaskData.R.Left + dw, MaskData.R.Top + wt, MaxL, h, Bmp, BmpSrc, dhm, Opacity);

    // top - middle
    x := R.Left + wl;
    if not Stretch then begin
      while x < R.Right - w - wr do begin
        CopyByMask32Ex(Rect(x, R.Top, x + w, R.Top + MaxT), Rect(MaskData.R.Left + dw + wl, MaskData.R.Top, MaskData.R.Left + dw + w + wl, MaskData.R.Top + MaxT), Bmp, BmpSrc, EmptyCI, MaskData, Opacity);
        inc(x, w);
      end;
      if x < R.Right - wr then
        CopyByMask32Ex(Rect(x, R.Top, R.Right - wr, R.Top + MaxT), Rect(MaskData.R.Left + dw + wl, MaskData.R.Top, MaskData.R.Left + dw + w + wl, MaskData.R.Top + MaxT), Bmp, BmpSrc, EmptyCI, MaskData, Opacity);
    end
    else
      StretchBltMask32Ex(x, R.Top, R.Right - wr - x, MaxT, MaskData.R.Left + dw + wl, MaskData.R.Top, w, MaxT, Bmp, BmpSrc, dhm, Opacity);

    // left - bottom
    CopyByMask32Ex(Rect(R.Left, R.Bottom - wb, R.Left + wl, R.Bottom), Rect(MaskData.R.Left + dw, MaskData.R.Top + dh - wb, MaskData.R.Left + dw + wl, MaskData.R.Top + dh), Bmp, BmpSrc, CI, MaskData, Opacity);
    // bottom - middle
    x := R.Left + wl;
    if not Stretch then begin
      while x < R.Right - w - wr do begin
        CopyByMask32Ex(Rect(x, R.Bottom - MaxB, x + w, R.Bottom), Rect(MaskData.R.Left + dw + wl, MaskData.R.Top + dh - MaxB, MaskData.R.Left + dw + w + wl, MaskData.R.Top + dh), Bmp, BmpSrc, EmptyCI, MaskData, Opacity);
        inc(x, w);
      end;
      if x < R.Right - wr then
        CopyByMask32Ex(Rect(x, R.Bottom - MaxB, R.Right - wr, R.Bottom), Rect(MaskData.R.Left + dw + wl, MaskData.R.Top + dh - MaxB, MaskData.R.Left + dw + w + wl, MaskData.R.Top + dh), Bmp, BmpSrc, EmptyCI, MaskData, Opacity);
    end
    else
      StretchBltMask32Ex(x, R.Bottom - MaxB, R.Right - wr - x, MaxB, MaskData.R.Left + dw + wl, MaskData.R.Top + dh - MaxB, w, MaxB, Bmp, BmpSrc, dhm, Opacity);

    // right - bottom
    CopyByMask32Ex(Rect(R.Right - wr, R.Bottom - wb, R.Right, R.Bottom), Rect(MaskData.R.Left + dw + w + wl, MaskData.R.Top + dh - wb, MaskData.R.Left + dw + w + wl + wr, MaskData.R.Top + dh), Bmp, BmpSrc, CI, MaskData, Opacity);
    // right - top
    CopyByMask32Ex(Rect(R.Right - wr,   R.Top,   R.Right,   R.Top + wt),
                 Rect(MaskData.R.Left + dw + w + wl,   MaskData.R.Top,   MaskData.R.Left + dw + w + wl + wr,   MaskData.R.Top + wt),   Bmp,   BmpSrc,   CI,   MaskData, Opacity);
    // right - middle
    y := R.Top + wt;
    if not Stretch then begin
      while y < R.Bottom - h - wb do begin
        CopyByMask32Ex(Rect(R.Right - MaxR,   y,   R.Right,   y + h),
                     Rect(MaskData.R.Left + dw + w + wl + wr - MaxR,   MaskData.R.Top + wt,   MaskData.R.Left + dw + w + wl + wr,   MaskData.R.Top + h + wt), Bmp, BmpSrc, EmptyCI, MaskData, Opacity);
        inc(y, h);
      end;
      if y < R.Bottom - wb then
        CopyByMask32Ex(Rect(R.Right - MaxR,   y,   R.Right,   R.Bottom - wb),
                     Rect(MaskData.R.Left + dw + w + wl + wr - MaxR,   MaskData.R.Top + wt,   MaskData.R.Left + dw + w + wl + wr,   MaskData.R.Top + h + wt), Bmp, BmpSrc, EmptyCI, MaskData, Opacity);
    end
    else
      StretchBltMask32Ex(R.Right - MaxR,   y,  MaxR,   R.Bottom - wb - y,   MaskData.R.Left + dw + wl + w + wr - MaxR,   MaskData.R.Top + wt,   MaxR,   h,   Bmp,   BmpSrc,   dhm, Opacity);
  end;
end;

end.




