unit sGraphUtils;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls, math, Buttons,
  {$IFDEF TNTUNICODE} TntGraphics, TntWideStrUtils, {$ENDIF}
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  {$IFDEF DELPHI_XE2} UITypes, {$ENDIF}
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  {$IFNDEF ACHINTS} imglist, sMaskData, sCommonData, {$ENDIF}
  {$IFNDEF NOJPG}{$IFDEF TINYJPG}acTinyJpg,{$ELSE}Jpeg,{$ENDIF}{$ENDIF}
  acntUtils, sConst;


{$IFNDEF NOTFORHELP}
type
  TsHSV = record
    h: integer;
    s, v: real;
  end;
  TFilterType = (ftBox {fastest}, ftTriangle, ftHermite, ftBell, ftSpline, ftLanczos3 {Slowest}, ftMitchell);


const
  MaxKernelSize = 16;


type
  PByteArrays = ^TByteArrays;
  TByteArrays = array [0..1000000] of PByteArray;
  TKernelSize = 1..MaxKernelSize;

procedure CopyBmp(DstBmp, SrcBmp: TBitmap);
procedure DrawColorArrow(const Canvas: TCanvas; const Color: TColor; R: TRect; const Direction: TacSide); overload;
function InitLine(Bmp: TBitmap; var Line0: Pointer; var Delta: Integer): boolean;
function MakeAngledFont(DC: hdc; Font: TFont; Orient: integer): hFont;
procedure SetFontSmoothing(AFont: TFont);
{$ENDIF} // NOTFORHELP

function SwapInteger(const i: integer): integer;
// Paint tiled TGraphic on bitmap
procedure TileBitmap(const Canvas: TCanvas; const aRect: TRect; const Graphic: TGraphic); overload;
procedure Stretch(const Src, Dst: TBitmap; const Width, Height: Integer; const Filter: TFilterType; const Param: Integer = 0);
procedure QBlur(Bmp: TBitmap);

{$IFNDEF ACHINTS}
procedure RGBToHSV(const R, G, B: Real; var H, S, V: Real);
procedure HSVtoRGB(const H, S, V: Real; var R, G, B: real);
procedure PaintItemBG(SkinData: TsCommonData; const ci: TCacheInfo; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; OffsetX: integer = 0; OffsetY: integer = 0); overload;
procedure PaintItem(SkinData: TsCommonData; const ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; UpdateCorners: boolean; OffsetX: integer = 0; OffsetY: integer = 0); overload;
function PaintSection(const Bmp: TBitmap; Section: string; const SecondSection: string; const State: integer; const Manager: TObject; const ParentOffset: TPoint; const BGColor: TColor; ParentDC: hdc = 0): integer; overload;
function PaintSection(const Bmp: TBitmap; SectionIndex: integer; const SecondIndex: integer; const State: integer; const Manager: TObject; const ParentOffset: TPoint; const BGColor: TColor; ParentDC: hdc = 0): integer; overload;

procedure PaintControlByTemplate(const DstBmp, SrcBmp: TBitmap; const DstRect, SrcRect, BorderWidths, BorderMaxWidths: TRect; const DrawModes: TRect; const StretchCenter: boolean; FillCenter: boolean = True);
function PaintSkinControl(const SkinData: TsCommonData; const Parent: TControl; const Filling: boolean; State: integer; const R: TRect; const pP: TPoint; const ItemBmp: TBitmap; const UpdateCorners: boolean; const OffsetX: integer = 0; const OffsetY: integer = 0): boolean;
procedure CopyChannel32(const DstBmp, SrcBmp: TBitmap; const Channel: integer); overload;
procedure CopyChannel32(const DstBmp, SrcBmp: TBitmap; const Channel: integer; DstRect, SrcRect: TRect); overload;
procedure CopyChannel(const Bmp32, Bmp8: TBitmap; const Channel: integer; const From32To8: boolean);

procedure DrawGlyphEx(Glyph, DstBmp: TBitmap; R: TRect; NumGlyphs: integer; Enabled: boolean; DisabledGlyphKind: TsDisabledGlyphKind; State, Blend: integer; Down: boolean = False; Reflected: boolean = False);
{$ENDIF}
// Fills rectangle on device context by Color
procedure FillDC(DC: HDC; const aRect: TRect; const Color: TColor);
procedure FillDCBorder(const DC: HDC; const aRect: TRect; const wl, wt, wr, wb: integer; const Color: TColor);
procedure BitBltBorder(const DestDC: HDC; const X, Y, Width, Height: Integer; const SrcDC: HDC; const XSrc, YSrc: Integer; const BorderWidth: integer);
// Grayscale bitmap
procedure GrayScale(Bmp: TBitmap);
procedure GrayScaleTrans(Bmp: TBitmap; const TransColor: TsColor);
function CutText(Canvas: TCanvas; const Text: acString; MaxLength: integer): acString;
// Writes text on Canvas on custom rectangle by Flags
procedure WriteText(Canvas: TCanvas; Text: PChar; Enabled: boolean; var aRect: TRect; Flags: Cardinal);
procedure SumBitmaps(SrcBmp, MskBmp: Graphics.TBitMap; const AlphaValue: byte);
procedure PaintBmp32(SrcBmp, MskBmp: Graphics.TBitMap);
procedure SumBmpRect(const DstBmp, SrcBmp: Graphics.TBitMap; const AlphaValue: byte; SrcRect: TRect; DstPoint: TPoint);
procedure PaintBmpRect32(const DstBmp, SrcBmp: Graphics.TBitMap; SrcRect: TRect; DstPoint: TPoint);
// Alpha-blending of rectangle on bitmap by Blend, excluding pixels with color clFuchsia
procedure BlendTransRectangle(Dst: TBitmap; X, Y: integer; Src: TBitmap; aRect: TRect; Blend: real; TransColor: TColor = clFuchsia);
procedure BlendTransBitmap(Bmp: TBitmap; Blend: real; const Color: TsColor);
// Alpha-blending of rectangle on bitmap custom transparency, color, blur and radius
procedure FadeBmp(FadedBmp: TBitMap; aRect: TRect; Transparency: integer; const Color: TsColor; Blur, Radius: integer);
// Sum two bitmaps where Color used as mask
procedure BlendBmpByMask(SrcBmp, MskBmp: Graphics.TBitMap; const BlendColor: TsColor);
procedure BlendBmpRectByMask(SrcBmp, MskBmp: Graphics.TBitMap; TopLeft: TPoint; const BlendColor: TsColor);
// Copying bitmap SrcBmp to DstBmp, excluding pixels with color TransColor
procedure CopyTransBitmaps(DstBmp, SrcBmp: Graphics.TBitMap; X, Y: integer; TransColor: TsColor);
// Sum two bitmaps by mask MskBmp
procedure SumByMaskWith32(const DstBmp, SrcBmp, MskBmp: Graphics.TBitMap; const aRect: TRect);
// procedure SumByMask(var Src1, Src2, MskBmp: Graphics.TBitMap; aRect: TRect);
function MakeRotated90(var Bmp: TBitmap; CW: boolean; KillSource: boolean = True): TBitmap;
// Returns color as ColorBegin -  (ColorBegin - ColorEnd) * i
//function ChangeColor(const ColorBegin, ColorEnd: TColor; const i: real): TColor;
// Returns color as (ColorBegin + ColorEnd) / 2
function AverageColor(const ColorBegin, ColorEnd: TsColor): TsColor; overload;
function AverageColor(const ColorBegin, ColorEnd: TColor): TColor; overload;
function MixColors(const Color1, Color2: TColor; const PercentOfColor1: real): TColor;
// Draws rectangle on device context
procedure DrawRectangleOnDC(DC: HDC; var R: TRect; ColorTop, ColorBottom: TColor; var Width: integer);
// Returns height of font
function GetFontHeight(hFont: HWnd): integer;
// Returns width of text
function GetStringSize(hFont: hgdiobj; const Text: acString; Flags: Cardinal = 0; WrapText: boolean = False; MaxWidth: integer = MaxInt): TSize;
procedure LoadBmpFromPngFile(Bmp: TBitmap; const FileName: string);
procedure LoadBmpFromPngStream(Bmp: TBitmap; Stream: TStream);
procedure FocusRect(Canvas: TCanvas; R: TRect; LightColor: TColor = clBtnFace; DarkColor: TColor = clBlack);
{$IFNDEF NOTFORHELP}
{$IFNDEF ACHINTS}
procedure SetBmp32Pixels(var Bmp: TBitmap);
procedure ExcludeControls(const DC: hdc; const Ctrl: TWinControl; const CtrlType: TacCtrlType; const OffsetX: integer; const OffsetY: integer);
procedure CalcButtonLayout(const Client: TRect; const GlyphSize: TPoint; const TextRectSize: TSize; Layout: TButtonLayout; Alignment: TAlignment;
  AMargin, Spacing: Integer; var GlyphPos: TPoint; var TextBounds: TRect; BiDiFlags: LongInt; VerticalAlignment: TVerticalAlignment = taVerticalCenter);
procedure TileBitmap(Canvas: TCanvas; var aRect: TRect; Graphic: TGraphic; const MaskData: TsMaskData; FillMode: TacFillMode = fmTiled); overload;
procedure TileMasked(Bmp: TBitmap; var aRect: TRect; const CI: TCacheInfo; const MaskData: TsMaskData; FillMode: TacFillMode = fmDisTiled);
procedure AddRgn(var AOR: TAOR; Width: integer; const MaskData: TsMaskData; VertOffset: integer; Bottom: boolean);
procedure GetRgnFromBmp(var rgn: hrgn; MaskBmp: TBitmap; TransColor: TColor);
procedure AddRgnBmp(var AOR: TAOR; MaskBmp: TBitmap; TransColor: TsColor);
function GetBGInfo(const BGInfo: PacBGInfo; const Handle: THandle; PleaseDraw: boolean = False): boolean; overload;
function GetBGInfo(const BGInfo: PacBGInfo; const Control: TControl; PleaseDraw: boolean = False): boolean; overload;
function BGInfoToCI(const BGInfo: PacBGInfo): TCacheInfo;
{$ENDIF}
procedure SumBitmapsByMask(var DstBmp, Src1, Src2: Graphics.TBitMap; MskBmp: Graphics.TBitMap; Percent: word = 0);
// Copy Bmp with AlphaMask if Bmp2 is not MasterBitmap
procedure CopyByMask(R1, R2: TRect; const Bmp1, Bmp2: TBitmap; const CI: TCacheInfo; const UpdateTrans: boolean); overload;
procedure CopyByMask(R1, R2: TRect; const Bmp1, Bmp2: TBitmap; const CI: TCacheInfo; const UpdateTrans: boolean; const MaskData: TsMaskData); overload;
procedure CopyBmp32(R1, R2: TRect; const Bmp1, Bmp2: TBitmap; const CI: TCacheInfo; const UpdateTrans: boolean; GrayedColor: TColor;
                    const Blend: integer; const Reflected: boolean);
// Copying rectangle from SrcBmp to DstBmp, excluding pixels with color TransColor (get trans pixels from parent)
procedure CopyTransRect(DstBmp, SrcBmp: Graphics.TBitMap; X, Y: integer; SrcRect: TRect; TransColor: TColor; const CI: TCacheInfo; UpdateTrans: boolean);
// Skip transarent part
procedure CopyTransRectA(DstBmp, SrcBmp: Graphics.TBitMap; X, Y: integer; SrcRect: TRect; TransColor: TColor; CI: TCacheInfo);
// Creates bitmap like Bmp
function CreateBmpLike(const Bmp: TBitmap): TBitmap;
function CreateAlphaBmp(const SrcMaskedBmp: TBitmap; const SrcRect: TRect): TBitmap;
function CreateBmp32(const Width: integer = 0; const Height: integer = 0): TBitmap; overload;
function CreateBmp32(const R: TRect): TBitmap; overload;
function CreateBmp32(const Size: TSize): TBitmap; overload;
function CreateBmp32(const Bmp: TBitmap): TBitmap; overload;
function CreateBmp32(const Ctrl: TControl): TBitmap; overload;
procedure WriteTextOnDC(DC: hdc; Text: PChar; Enabled: boolean; var aRect: TRect; Flags: Cardinal);
function acDrawText(hDC: HDC; const Text: ACString; var lpRect: TRect; uFormat: Cardinal): Integer;
function acTextWidth (const Canvas: TCanvas; const Text: ACString): Integer;
function acTextHeight(const Canvas: TCanvas; const Text: ACString): Integer;
function acTextExtent(const Canvas: TCanvas; const Text: ACString): TSize;
procedure acTextRect (const Canvas: TCanvas; const Rect: TRect; X, Y: Integer; const Text: ACString);

function acGetTextExtent(const DC: HDC; const Str: acString; var Size: TSize): BOOL;

procedure acDrawGlowForText(const DstBmp: TBitmap; Text: PacChar; aRect: TRect; Flags: Cardinal; Side: Cardinal; BlurSize: integer; Color: TColor; var MaskBmp: TBitmap);
procedure Blur8(theBitmap: TBitmap; radius: double);

procedure acWriteTextEx(const Canvas: TCanvas; const Text: PacChar; const Enabled: boolean; var aRect: TRect; const Flags: Cardinal; const SkinData: TsCommonData; const Hot: boolean; const SkinManager: TObject = nil); overload;
procedure acWriteTextEx(const Canvas: TCanvas; const Text: PacChar; const Enabled: boolean; var aRect: TRect; const Flags: Cardinal; const SkinIndex: integer; const Hot: boolean; const SkinManager: TObject = nil); overload;
procedure acWriteText(const Canvas: TCanvas; const Text: PacChar; const Enabled: boolean; var aRect: TRect; const Flags: Cardinal);

{$IFNDEF ACHINTS}
procedure WriteTextEx(const Canvas: TCanvas; Text: PChar; Enabled: boolean; var aRect: TRect; Flags: Cardinal; SkinIndex: integer; Hot: boolean; SkinManager: TObject = nil); overload;
procedure WriteTextEx(const Canvas: TCanvas; Text: PChar; Enabled: boolean; var aRect: TRect; Flags: Cardinal; SkinData: TsCommonData; Hot: boolean); overload;
{$IFDEF TNTUNICODE}
procedure WriteUnicode(const Canvas: TCanvas; const Text: WideString; Enabled: boolean; var aRect: TRect; Flags: Cardinal; SkinData: TsCommonData; Hot: boolean); overload;
procedure WriteTextExW(const Canvas: TCanvas; Text: PWideChar; Enabled: boolean; var aRect: TRect; Flags: Cardinal; SkinData: TsCommonData; Hot: boolean); overload;
// replace function of Canvas.TextRect
procedure TextRectW(const Canvas: TCanvas; var Rect: TRect; X, Y: Integer; const Text: WideString);
procedure WriteTextExW(const Canvas: TCanvas; Text: PWideChar; Enabled: boolean; var aRect: TRect; Flags: Cardinal; SkinIndex: integer; Hot: boolean; SkinManager: TObject = nil); overload;
{$ENDIF}

procedure PaintItemBG(SkinIndex: integer; const ci: TCacheInfo; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TObject = nil; TextureIndex: integer = -1; HotTextureIndex: integer = -1; CustomColor: TColor = clFuchsia); overload;
procedure PaintItemBGFast(SkinIndex, BGIndex, BGHotIndex: integer; const ci: TCacheInfo; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TObject = nil); overload;
procedure PaintItemFast(SkinIndex, MaskIndex, BGIndex, BGHotIndex: integer; const ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TObject = nil); overload;
procedure PaintItem(SkinIndex: integer; const ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TObject = nil; BGIndex: integer = -1; BGHotIndex: integer = -1); overload;
procedure PaintItem(SkinIndex: integer; const ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; DC: HDC; SkinManager: TObject = nil); overload;

// Deprecated procedures <<<
// Loads to Image TJpegImage or TBitmap from FileName
function LoadJpegOrBmp(Image: TPicture; const FileName: string; Gray: boolean): boolean; {$IFDEF WARN_DEPRECATED} deprecated; {$ENDIF}
procedure CopyImage(const Glyph: TBitmap; const ImageList: TCustomImageList; const Index: Integer); {$IFDEF WARN_DEPRECATED} deprecated; {$ENDIF}
procedure PaintItemBG(SkinIndex: integer; const SkinSection: string; const ci: TCacheInfo; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TObject = nil; TextureIndex: integer = -1; HotTextureIndex: integer = -1; CustomColor: TColor = clFuchsia); overload; {$IFDEF WARN_DEPRECATED} deprecated; {$ENDIF}
procedure PaintItemBGFast(SkinIndex, BGIndex, BGHotIndex: integer; const SkinSection: string; const ci: TCacheInfo; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TObject = nil); overload; {$IFDEF WARN_DEPRECATED} deprecated; {$ENDIF}
procedure PaintItemFast(SkinIndex, MaskIndex, BGIndex, BGHotIndex: integer; const SkinSection: string; const ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TObject = nil); overload; {$IFDEF WARN_DEPRECATED} deprecated; {$ENDIF}
procedure PaintItem(SkinIndex: integer; const SkinSection: string; const ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TObject = nil; BGIndex: integer = -1; BGHotIndex: integer = -1); overload; {$IFDEF WARN_DEPRECATED} deprecated; {$ENDIF}
procedure PaintItem(SkinIndex: integer; const SkinSection: string; const ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; DC: HDC; SkinManager: TObject = nil); overload; {$IFDEF WARN_DEPRECATED} deprecated; {$ENDIF}
//procedure PaintSmallItem(SkinIndex: integer; const SkinSection: string; const ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TObject = nil);
// End of deprecated procedures >>>


function ChangeBrightness(const Color: TColor; const Delta: integer): TColor;

function ChangeSaturation(const Color: TColor; const Delta: integer): TColor; overload;
function ChangeSaturation(const Delta: integer; const Color: TsColor_): TsColor_; overload;

function ChangeHue(const Delta: integer; const Color: TColor): TColor; overload;
function ChangeHue(const Delta: integer; C: TsColor_): TsColor_; overload;

function ChangeTone(const Color: TsColor_; const Tone: TsColor_RGB): TsColor_; overload;
function ChangeTone(const Color, Tone: TColor): TColor; overload;

function Hsv2Rgb(h, s, v: real): TsColor;
function Rgb2Hsv(C: TsColor): TsHSV;
function acLayered: Boolean;

function CheckWidth (const SkinManager: TObject; const SmallGlyphs: boolean = True): integer;
function CheckHeight(const SkinManager: TObject; const SmallGlyphs: boolean = True): integer;
procedure acDrawCheck(const R: TRect; const AState: TCheckBoxState; const AEnabled: Boolean; const Bmp: TBitmap; const CI: TCacheInfo; const SkinManager: TObject; const SmallGlyphs: boolean = True);


type
  TacChangeColor = procedure(var Color: TsColor_; const Param: integer);

procedure DrawBmp(ACanvas: TCanvas; Bmp: TBitmap; R: TRect; Reflected: boolean);
function MakeCompIcon(Img: TBitmap; BGColor: TColor = Graphics.clNone): HICON;
procedure ChangeBitmapPixels(Bmp: TBitmap; ChangeProc: TacChangeColor; Param: integer; SkipColor: TColor);
procedure ChangeColorBrightness(var Prop: TsColor_; const Param: integer);
procedure ChangeColorSaturation(var Prop: TsColor_; const Param: integer);
procedure ChangeColorHUE       (var Prop: TsColor_; const Param: integer);
procedure ChangeColorTone      (var Prop: TsColor_; const Param: integer);
procedure MakeAlphaPixel       (var Prop: TsColor_; const Param: integer);
procedure acSetLayout(hdc: HDC; dwLayout: DWORD);
function acGetLayout(hdc: HDC): DWord;
{$ENDIF}


var
  FCheckWidth, FCheckHeight: Integer;
  User32Lib: HModule = 0;
  Gdi32Lib: HModule = 0;
  SetLayeredWindowAttributes: function (Hwnd: THandle; crKey: COLORREF; bAlpha: Byte; dwFlags: DWORD): Boolean; stdcall;
  UpdateLayeredWindow: function (Handle: THandle; hdcDest: HDC; pptDst: PPoint; _psize: PSize;
    hdcSrc: HDC; pptSrc: PPoint; crKey: COLORREF; pblend: PBLENDFUNCTION; dwFlags: DWORD): Boolean; stdcall;

  SetLayout: function(hdc: HDC; dwLayout: DWORD): DWORD; stdcall;
  GetLayout: function(hdc: HDC): DWORD; stdcall;
{$ENDIF} // NOTFORHELP




implementation


uses
  {$IFNDEF ACHINTS} sStyleSimply, sSkinProps, sSkinManager, sSkinProvider, sMessages, {$ENDIF}
  {$IFDEF TNTUNICODE} TntWindows, {$ENDIF}
  {$IFNDEF ALITE} sSplitter, {$ENDIF}
  {$IFNDEF FPC} acPng, {$ENDIF}
  sGradient, sAlphaGraph, sDefaults;


type
  TKernel = record
    Size: TKernelSize;
    Weights: array [-MaxKernelSize..MaxKernelSize] of Single;
  end;


procedure SetFontSmoothing(AFont: TFont);
var
  tagLOGFONT: TLogFont;
begin
  GetObject(AFont.Handle, SizeOf(TLogFont), @tagLOGFONT);
  tagLOGFONT.lfQuality := ANTIALIASED_QUALITY;
  AFont.Handle := CreateFontIndirect(tagLOGFONT);
end;


procedure CopyBmp(DstBmp, SrcBmp: TBitmap);
begin
  DstBmp.PixelFormat := SrcBmp.PixelFormat;
  DstBmp.HandleType := bmDIB;
  DstBmp.Width := SrcBmp.Width;
  DstBmp.Height := SrcBmp.Height;
  BitBlt(DstBmp.Canvas.Handle, 0, 0, SrcBmp.Width, SrcBmp.Height, SrcBmp.Canvas.Handle, 0, 0, SRCCOPY);
end;


function InitLine(Bmp: TBitmap; var Line0: Pointer; var Delta: Integer): boolean;
begin
  Result := False;
  if Bmp.Height > 0 then
    try
      Line0 := Bmp.ScanLine[0];
      if Bmp.Height > 1 then
        Delta := Integer(Bmp.ScanLine[1]) - Integer(Bmp.ScanLine[0])
      else
        Delta := 0;
    finally
      Result := True;
    end;
end;


procedure DrawColorArrow(const Canvas: TCanvas; const Color: TColor; R: TRect; const Direction: TacSide);
const
  aWidth = 5;
  aHeight = 3;
var
  x, y, Left, Top, i: integer;
begin
  i := 0;
  case Direction of
    asTop: begin
      Left := R.Left + (WidthOf(R) - aWidth) div 2 - 1;
      Top := R.Top + (HeightOf(R) - aHeight) div 2 - 1;
      for y := Top + aHeight downto Top do begin
        for x := i to aHeight do begin
          Canvas.Pixels[Left + x, y] := Color;
          Canvas.Pixels[Left + aWidth - x + 1, y] := Color;
        end;
        inc(i);
      end;
    end;

    asLeft: begin
      Left := R.Left + (WidthOf(R) - aHeight) div 2;
      Top  := R.Top + (HeightOf(R) - aWidth)  div 2;
      for x := Left + aHeight downto Left do begin
        for y := Top + i to Top + aHeight do begin
          Canvas.Pixels[x, y] := Color;
          Canvas.Pixels[x, y + aHeight - i] := Color;
        end;
        inc(i);
      end;
    end;

    asBottom: begin
      Left := R.Left + (WidthOf(R) - aWidth) div 2 - 1;
      Top := R.Top + (HeightOf(R) - aHeight) div 2 - 1;
      for y := Top to Top + aHeight do begin
        for x := i to aHeight do begin
          Canvas.Pixels[Left + x, y] := Color;
          Canvas.Pixels[Left + aWidth - x + 1, y] := Color;
        end;
        inc(i);
      end;
    end;

    asRight: begin
      Left := R.Left + (WidthOf(R) - aHeight) div 2;
      Top  := R.Top + (HeightOf(R) - aWidth)  div 2;
      for x := Left to Left + aHeight do begin
        for y := Top + i to Top + aHeight do begin
          Canvas.Pixels[x, y] := Color;
          Canvas.Pixels[x, y + aHeight - i] := Color;
        end;
        inc(i);
      end;
    end;
  end;
end;


function MakeAngledFont(DC: hdc; Font: TFont; Orient: integer): hFont;
var
  NewFont: hFont;
{$IFDEF TNTUNICODE}
  pFont: PLogFontW;
  VertFont: TLogFontW;
{$ELSE}
  pFont: PLogFont;
  VertFont: TLogFont;
{$ENDIF}
begin
{$IFDEF TNTUNICODE}
  pFont := PLogFontW(@VertFont);
  GetObject(DC, SizeOf(TLogFontW), pFont);
{$ELSE}
  pFont := PLogFont(@VertFont);
  GetObject(DC, SizeOf(TLogFont), pFont);
{$ENDIF}
  VertFont.lfEscapement := Orient;
  VertFont.lfHeight := Font.Height;
  VertFont.lfStrikeOut := integer(fsStrikeOut in Font.Style);
  VertFont.lfItalic := integer(fsItalic in Font.Style);
  VertFont.lfUnderline := integer(fsUnderline in Font.Style);
  if fsBold in Font.Style then
    VertFont.lfWeight := FW_BOLD
  else
    VertFont.lfWeight := FW_NORMAL;

  VertFont.lfCharSet := Font.Charset;
  VertFont.lfWidth := 0;
  VertFont.lfOutPrecision := OUT_DEFAULT_PRECIS;
  VertFont.lfClipPrecision := CLIP_DEFAULT_PRECIS;
  VertFont.lfOrientation := VertFont.lfEscapement;
  VertFont.lfPitchAndFamily := Default_Pitch;
  VertFont.lfQuality := Default_Quality;
  if Font.Name <> 'MS Sans Serif' then
{$IFDEF TNTUNICODE}
    WStrPCopy(VertFont.lfFaceName, Font.Name)
  else
    WStrPCopy(VertFont.lfFaceName, 'Arial');

  NewFont := CreateFontIndirectW(VertFont);
{$ELSE}
    StrPCopy(VertFont.lfFaceName, Font.Name)
  else
    VertFont.lfFaceName := 'Arial';

  NewFont := CreateFontIndirect(VertFont);
{$ENDIF}

  Result := SelectObject(DC, NewFont);
  SetTextColor(DC, ColorToRGB(Font.Color));
  DeleteObject(NewFont);
end;


function CheckWidth(const SkinManager: TObject; const SmallGlyphs: boolean = True): integer;
begin
  with TsSkinManager(SkinManager) do
    if SmallGlyphs then
      if Assigned(SkinManager) and Active and IsValidImgIndex(ConstData.SmallCheckBox[cbChecked]) then
        Result := WidthOfImage(ma[ConstData.SmallCheckBox[cbChecked]]) + 2
      else
        Result := FCheckWidth
    else
      if Assigned(SkinManager) and Active and IsValidImgIndex(ConstData.CheckBox[cbChecked]) then
        Result := WidthOfImage(ma[ConstData.CheckBox[cbChecked]]) + 2
      else
        Result := FCheckWidth;
end;


function CheckHeight(const SkinManager: TObject; const SmallGlyphs: boolean = True): integer;
begin
  with TsSkinManager(SkinManager) do
    if SmallGlyphs then
      if Assigned(SkinManager) and Active and IsValidImgIndex(ConstData.SmallCheckBox[cbChecked]) then
        Result := HeightOfImage(ma[ConstData.SmallCheckBox[cbChecked]])
      else
        Result := FCheckHeight
    else
      if Assigned(SkinManager) and Active and IsValidImgIndex(ConstData.CheckBox[cbChecked]) then
        Result := HeightOfImage(ma[ConstData.CheckBox[cbChecked]])
      else
        Result := FCheckHeight;
end;


procedure GetCheckSize;
var
  AButtonsBitmap: HBITMAP;
  B: Windows.TBitmap;
begin
  AButtonsBitmap := LoadBitmap(0, PChar(OBM_CHECKBOXES));
  try
    GetObject(AButtonsBitmap, SizeOf(Windows.TBitmap), @B);
    FCheckWidth := B.bmWidth shr 2;
    FCheckHeight := B.bmHeight div 3;
  finally
    DeleteObject(AButtonsBitmap);
  end;
end;


procedure acDrawCheck(const R: TRect; const AState: TCheckBoxState; const AEnabled: Boolean; const Bmp: TBitmap; const CI: TCacheInfo; const SkinManager: TObject; const SmallGlyphs: boolean = True);
var
  DrawState, w, h: Integer;
  DrawRect: TRect;
  SkinnedGlyph: boolean;
begin
  with TsSkinManager(SkinManager) do begin
    SkinnedGlyph := False;
    if IsValidImgIndex(ConstData.SmallCheckBox[AState]) then
      SkinnedGlyph := True;

    DrawRect := R;
    DrawState := 0;

    w := CheckWidth (SkinManager, SmallGlyphs);
    h := CheckHeight(SkinManager, SmallGlyphs);

    if not SkinnedGlyph then begin
      OffsetRect(DrawRect, - DrawRect.Left, - DrawRect.Top);
      if CI.Ready then
        BitBlt(Bmp.Canvas.Handle, DrawRect.Left, DrawRect.Top, w + 2, HeightOf(R), CI.Bmp.Canvas.Handle, CI.X + R.Left + 1, CI.Y + R.Top + 1, SRCCOPY)
      else
        FillDC(Bmp.Canvas.Handle, Rect(DrawRect.Left, DrawRect.Top, DrawRect.Left + w + 2, DrawRect.Top + HeightOf(R)), CI.FillColor);

      case AState of
        cbChecked:   DrawState := DFCS_BUTTONCHECK or DFCS_CHECKED;
        cbUnchecked: DrawState := DFCS_BUTTONCHECK;
        else         DrawState := DFCS_BUTTON3STATE or DFCS_CHECKED;
      end;

      if not AEnabled then
        DrawState := DrawState or DFCS_INACTIVE;
    end;

    DrawRect.Left   := DrawRect.Left + (DrawRect.Right - DrawRect.Left - w) div 2;
    DrawRect.Top    := DrawRect.Top  + (DrawRect.Bottom - DrawRect.Top - h) div 2;
    DrawRect.Right  := DrawRect.Left + w;
    DrawRect.Bottom := DrawRect.Top  + h;

    if SkinnedGlyph then begin
//      OffsetRect(DrawRect, 0, - DrawRect.Top + (HeightOf(R) - h) div 2);
      if SmallGlyphs then begin
        if IsValidImgIndex(ConstData.SmallCheckBox[AState]) then
          sAlphaGraph.DrawSkinGlyph(Bmp, DrawRect.TopLeft, 0, 1 + integer(not AEnabled), ma[ConstData.SmallCheckBox[AState]], CI);
      end
      else
        if IsValidImgIndex(ConstData.CheckBox[AState]) then
          sAlphaGraph.DrawSkinGlyph(Bmp, DrawRect.TopLeft, 0, 1 + integer(not AEnabled), ma[ConstData.CheckBox[AState]], CI);
    end
    else
      DrawFrameControl(Bmp.Canvas.Handle, DrawRect, DFC_BUTTON, DrawState);
  end;
end;


type
  TAccessBmp = class (TBitmap);
  
procedure DrawBmp(ACanvas: TCanvas; Bmp: TBitmap; R: TRect; Reflected: boolean);
var
  DstBmp, SrcBmp, SrcBmp8, Mask: TBitmap;
  w, h: integer;
begin
  if (Bmp.PixelFormat = pf32bit) then
    begin
      w := WidthOf(R);
      h := HeightOf(R);
      DstBmp := CreateBmp32(w, h + Integer(Reflected) * (h div 2));
      BitBlt(DstBmp.Canvas.Handle, 0, 0, w, DstBmp.Height, ACanvas.Handle, R.Left, R.Top, SRCCOPY);
      if (w = Bmp.Width) and (h = Bmp.Height) then
        CopyBmp32(MkRect(w, h), MkRect(w, h), DstBmp, Bmp, EmptyCI, False, Graphics.clNone, 0, Reflected)
      else begin // If stretched
        SrcBmp := TBitmap.Create;
        SrcBmp.PixelFormat := pfDevice;
        SrcBmp.Width := w;
        SrcBmp.Height := h;

        SetStretchBltMode(SrcBmp.Canvas.Handle, COLORONCOLOR);
        StretchBlt(SrcBmp.Canvas.Handle, 0, 0, w, h, Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, SRCCOPY);
        SrcBmp.PixelFormat := pf32bit;

        Mask := CreateBmpLike(Bmp);
        Mask.PixelFormat := pf8bit;

        CopyChannel(Bmp, Mask, 3, True);
        Mask.PixelFormat := pfDevice;
        SrcBmp8 := TBitmap.Create;
        SrcBmp8.PixelFormat := pfDevice;
        SrcBmp8.Width := w;
        SrcBmp8.Height := h;
        SetStretchBltMode(SrcBmp8.Canvas.Handle, COLORONCOLOR);
        StretchBlt(SrcBmp8.Canvas.Handle, 0, 0, w, h, Mask.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, SRCCOPY);
        SrcBmp8.PixelFormat := pf8bit;
        CopyChannel(SrcBmp, SrcBmp8, 3, False);
        FreeAndNil(Mask);
        FreeAndNil(SrcBmp8);
        CopyBmp32(MkRect(w, h), MkRect(w, h), DstBmp, SrcBmp, EmptyCI, False, Graphics.clNone, 0, False);
        FreeAndNil(SrcBmp);
      end;
      BitBlt(ACanvas.Handle, R.Left, R.Top, DstBmp.Width, DstBmp.Height, DstBmp.Canvas.Handle, 0, 0, SRCCOPY);
      FreeAndNil(DstBmp);
    end
  else
    TAccessBmp(Bmp).Draw(ACanvas, R);
end;


function MakeCompIcon(Img: TBitmap; BGColor: TColor = Graphics.clNone): HICON;
var
  IconInfo: TIconInfo;
  S0, D0, S, D: PRGBAArray;
  X, Y, DeltaS, DeltaD: integer;
  MaskBitmap, ColorBitmap: TBitmap;
begin
  MaskBitmap := TBitmap.Create;
  MaskBitmap.PixelFormat := pf1bit;
  MaskBitmap.Width := Img.Width;
  MaskBitmap.Height := Img.Height;

  ColorBitmap := CreateBmp32(Img.Width, Img.Height);
  FillDC(ColorBitmap.Canvas.Handle, MkRect(ColorBitmap), BGColor);
  DrawBmp(ColorBitmap.Canvas, Img, MkRect(ColorBitmap), False);

  if Img.PixelFormat <> pf32bit then begin
    Img.PixelFormat := pf32bit;
    if InitLine(Img, Pointer(S0), DeltaS) then
      for Y := 0 to Img.Height - 1 do begin
        S := Pointer(LongInt(S0) + DeltaS * Y);
        for X := 0 to Img.Width - 1 do
          with S[X] do
            if C = clFuchsia then
              A := 0
            else
              A := MaxByte;
      end;
  end;

  if InitLine(Img, Pointer(S0), DeltaS) and InitLine(ColorBitmap, Pointer(D0), DeltaD) then begin
    for Y := 0 to Img.Height - 1 do begin
      S := Pointer(LongInt(S0) + DeltaS * Y);
      D := Pointer(LongInt(D0) + DeltaD * Y);
      for X := 0 to Img.Width - 1 do
        with S[X] do begin
          D[X].C := C;
          if A = 0 then
            SetPixelV(MaskBitmap.Canvas.Handle, X, Y, clWhite)
          else
            SetPixelV(MaskBitmap.Canvas.Handle, X, Y, clBlack)
        end;
    end;
  end;

  try
    IconInfo.fIcon := True;
    IconInfo.hbmColor := ColorBitmap.Handle;
    IconInfo.hbmMask := MaskBitmap.Handle;
    Result := CreateIconIndirect(IconInfo);
  finally
    FreeAndNil(MaskBitmap);
    FreeAndNil(ColorBitmap);
  end;
end;


procedure ChangeBitmapPixels(Bmp: TBitmap; ChangeProc: TacChangeColor; Param: integer; SkipColor: TColor);
var
  CC: TsColor;
  S0, S: PRGBAArray;
  Delta, x, y: integer;
begin
  CC.C := SwapRedBlue(SkipColor);
  if Assigned(Bmp) then
    if InitLine(Bmp, Pointer(S0), Delta) then
      if SkipColor <> clNone then
        for y := 0 to Bmp.Height - 1 do begin
          S := Pointer(LongInt(S0) + Delta * Y);
          for x := 0 to Bmp.Width - 1 do
            if (S[X].C <> CC.C) then
              ChangeProc(S[X], Param);
        end
      else
        for y := 0 to Bmp.Height - 1 do begin
          S := Pointer(LongInt(S0) + Delta * Y);
          for x := 0 to Bmp.Width - 1 do
            ChangeProc(S[X], Param);
        end
end;


procedure ChangeColorBrightness(var Prop: TsColor_; const Param: integer);
begin
  Prop.C := ChangeBrightness(Prop.C, Param);
end;


procedure ChangeColorSaturation(var Prop: TsColor_; const Param: integer);
begin
  Prop := ChangeSaturation(Param, Prop);
end;


procedure ChangeColorHUE(var Prop: TsColor_; const Param: integer);
begin
  Prop := ChangeHUE(Param, Prop);
end;


procedure ChangeColorTone(var Prop: TsColor_; const Param: integer);
begin
  Prop := ChangeTone(Prop, TsColor_RGB(Param));
end;


procedure MakeAlphaPixel(var Prop: TsColor_; const Param: integer);
begin
  Prop.A := $FF;
end;


function acLayered: Boolean;
begin
  Result := Pointer(@UpdateLayeredWindow) <> nil;
end;


function SwapInteger(const i: integer): integer;
var
  r, g, b, j: integer;
begin
  r := i mod 256;
  j := i shr 8;
  g := j mod 256;
  b := j shr 8;
  Result := r shl 16 + g shl 8 + b;
end;


{$IFNDEF ACHINTS}
function IsNAN(const d: double): boolean;
var
  Overlay: Int64 absolute d;
begin
  Result := ((Overlay and $7FF0000000000000) = $7FF0000000000000) and ((Overlay and $000FFFFFFFFFFFFF) <> $0000000000000000)
end;


function ChangeTone(const Color: TsColor_; const Tone: TsColor_RGB): TsColor_; overload;
begin
  with Result, Tone do begin
    A := Color.A;
    // Discolor by lighter channel
    if Color.R > Color.G then
      if Color.R > Color.B then
        R := Color.R
      else
        R := Color.B
    else
      if Color.G > Color.B then
        R := Color.G
      else
        R := Color.B;

    G := R;
    B := R;

    R := R * Red   shr 8;
    G := G * Green shr 8;
    B := B * Blue  shr 8;
  end;
end;


procedure acSetLayout(hdc: HDC; dwLayout: DWORD);
begin
  if @SetLayout <> nil then
    SetLayout(hdc, dwLayout);
end;


function acGetLayout(hdc: HDC): DWord;
begin
  if @GetLayout <> nil then
    Result := GetLayout(hdc)
  else
    Result := 0;
end;


function ChangeTone(const Color, Tone: TColor): TColor; overload;
begin
  Result := ChangeTone(TsColor_(Color), TsColor_RGB(Tone)).C;
end;


function ChangeBrightness(const Color: TColor; const Delta: integer): TColor;
var
  C: TsColor;
begin
  Result := Color;
  if Delta <> 0 then
    with C do begin
      C := Color;
      R := max(min(Trunc(R + Delta), MaxByte), 0);
      G := max(min(Trunc(G + Delta), MaxByte), 0);
      B := max(min(Trunc(B + Delta), MaxByte), 0);
      Result := C;
    end;
end;


function ChangeSaturation(const Color: TColor; const Delta: integer): TColor;
begin
  if Delta <> 0 then
    Result := ChangeSaturation(Delta, TsColor_(Color)).C
  else
    Result := Color;
end;


function ChangeSaturation(const Delta: integer; const Color: TsColor_): TsColor_; overload;
var
  Gray: integer;
begin
  if Delta <> 0 then begin
    Gray := (Color.R + Color.G + Color.B) div 3;
    with TsColor(Result) do begin
      A := Color.A;
      B := LimitIt(Color.R - Delta * (Gray - Color.R) div MaxByte, 0, MaxByte);
      G := LimitIt(Color.G - Delta * (Gray - Color.G) div MaxByte, 0, MaxByte);
      R := LimitIt(Color.B - Delta * (Gray - Color.B) div MaxByte, 0, MaxByte);
    end;
  end
  else
    Result := Color;
end;


function Hsv2Rgb(h, s, v: real): TsColor;
var
  II: integer;
  F, M, N, K: real;
begin
  Result.A := 0;
  if S = 0 then
    with Result do begin
      R := lo(Trunc(V * MaxByte));
      G := R;
      B := R;
    end
  else begin
    if H = 360 then
      H := 0
    else
      H := H / 60;

    II := Trunc(Int(H));
    F := (H - II);

    V := V * MaxByte;
    M := V * (1 - S);
    N := V * (1 - S * F);
    K := V * (1 - S * (1 - F));

    M := max(min(M, MaxByte), 0);
    N := max(min(N, MaxByte), 0);
    K := max(min(K, MaxByte), 0);

    with Result do begin
      A := 0;
      case II of
        0: begin
          R := Trunc(V);
          G := Trunc(K);
          B := Trunc(M)
        end;
        1: begin
          R := Trunc(N);
          G := Trunc(V);
          B := Trunc(M)
        end;
        2: begin
          R := Trunc(M);
          G := Trunc(V);
          B := Trunc(K)
        end;
        3: begin
          R := Trunc(M);
          G := Trunc(N);
          B := Trunc(V)
        end;
        4: begin
          R := Trunc(K);
          G := Trunc(M);
          B := Trunc(V)
        end
        else begin
          R := Trunc(V);
          G := Trunc(M);
          B := Trunc(N)
        end
      end;
    end;
  end
end;


function Rgb2Hsv(C: TsColor): TsHSV;
var
  Rt, Gt, Bt, H, S, V: real;
  d, max, min: integer;
begin
  C.A := 0;
  max := math.Max(math.Max(c.R, c.G), c.B);
  min := math.Min(math.Min(c.R, c.G), c.B);
  d := max - min;
  V := max;

  if (max <> 0) then
    S := d / max
  else
    S := 0;

  if S = 0 then
    Result.H := 0
  else begin
    rt := max - c.R * 60 / d;
    gt := max - c.G * 60 / d;
    bt := max - c.B * 60 / d;

    if c.R = max then
      H := bt - gt
    else
      if c.G = max then
        H := 120 + rt - bt
      else
        H := 240 + gt - rt;

    if H < 0 then
      H := H + 360;

    Result.H := Trunc(H);
  end;
  Result.S := S;
  Result.V := V / MaxByte;
end;


function ChangeHue(const Delta: integer; C: TsColor_): TsColor_; overload;
var
  Rt, Gt, Bt, H, S, V, r: real;
  d, max, min, II: integer;
  F, M, N, K: real;
begin
  max := math.Max(math.Max(c.R, c.G), c.B);
  min := math.Min(math.Min(c.R, c.G), c.B);
  d := max - min;
  V := max;

  if (max <> 0) then
    S := d / max
  else
    S := 0;

  if S = 0 then
    H := 0
  else begin
    r := 60 / d;
    rt := max - c.R * r;
    gt := max - c.G * r;
    bt := max - c.B * r;
    if c.R = max then
      H := bt - gt
    else
      if c.G = max then
        H := 120 + rt - bt
      else
        H := 240 + gt - rt;

    if H < 0 then
      H := H + 360;
  end;
  H := Trunc(H + Delta) mod 360;
  if S = 0 then
    C.R := Trunc(V)
  else begin
    H := H / 60;
    Ii := Trunc(H);
    F := (H - Ii);

    M := V * (1 - S);
    N := V * (1 - S * F);
    K := V * (1 - S * (1 - F));

    M := Math.max(Math.min(M, MaxByte), 0);
    N := Math.max(Math.min(N, MaxByte), 0);
    K := Math.max(Math.min(K, MaxByte), 0);

    with C do
      case Ii of
        0: begin
          R := Trunc(V);
          G := Trunc(K);
          B := Trunc(M)
        end;
        1: begin
          R := Trunc(N);
          G := Trunc(V);
          B := Trunc(M)
        end;
        2: begin
          R := Trunc(M);
          G := Trunc(V);
          B := Trunc(K)
        end;
        3: begin
          R := Trunc(M);
          G := Trunc(N);
          B := Trunc(V)
        end;
        4: begin
          R := Trunc(K);
          G := Trunc(M);
          B := Trunc(V)
        end
        else begin
          R := Trunc(V);
          G := Trunc(M);
          B := Trunc(N)
        end
      end;
  end;
  Result := C
end;


function ChangeHue(const Delta: integer; const Color: TColor): TColor; overload;
var
  CC: TsColor_;
begin
  if Delta <> 0 then
    with CC do begin
      with TsColor_RGB(Color) do begin
        A := Alpha;
        R := Red;
        G := Green;
        B := Blue;
      end;
      CC := ChangeHue(Delta, CC);
      with TsColor_RGB(Result) do begin
        Alpha := A;
        Red   := R;
        Green := G;
        Blue  := B;
      end;
    end
  else
    Result := Color;
end;


procedure HSVtoRGB(const H, S, V: Real; var R, G, B: real);
var
  f: Real;
  i: Integer;
  hTemp: Real;              // since H is const parameter
  p, q, t: Real;
begin
  if (ABS(S - 0.0001) <= 0.0001) or IsNan(H) { color is on black-and-white center line } then begin
    if IsNaN(H) then begin
      R := V;                   // achromatic:  shades of gray
      G := V;
      B := V
    end
  end
  else begin                    // chromatic color
    if H = 360.0 { 360 degrees same as 0 degrees } then
      hTemp := 0.0
    else
      hTemp := H;

    hTemp := hTemp / 60;        // h is now IN [0,6)
    i := Trunc(hTemp);          // largest integer <= h
    f := hTemp - i;             // fractional part of h
    p := V * (1.0 - S);
    q := V * (1.0 - (S * f));
    t := V * (1.0 - (S * (1.0 - f)));
    case i OF
      0: begin
        R := V;
        G := t;
        B := p
      end;
      1: begin
        R := q;
        G := V;
        B := p
      end;
      2: begin
        R := p;
        G := V;
        B := t
      end;
      3: begin
        R := p;
        G := q;
        B := V
      end;
      4: begin
        R := t;
        G := p;
        B := V
      end;
      5: begin
        R := V;
        G := p;
        B := q
      end
    end
  end
end;


procedure RGBToHSV (const R, G, B: Real; var H, S, V: Real);
var
  Delta, Min: Real;
begin
  Min := MinValue( [R, G, B] );
  V   := MaxValue( [R, G, B] );
  Delta := V - Min;
  // Calculate saturation:  saturation is 0 if r, g and b are all 0
  if V = 0.0 then
    S := 0
  else
    S := Delta / V;

  if S <> 0.0 then
    {H := NAN // Achromatic:  When s = 0, h is undefined
  else }begin    // Chromatic
    if R = V then { between yellow and magenta [degrees] }
      H := 60.0 * (G - B) / Delta
    else
      if G = V then { between cyan and yellow }
        H := 120.0 + 60.0 * (B - R) / Delta
      else
        if B = V then { between magenta and cyan }
          H := 240.0 + 60.0 * (R - G) / Delta;

    if H < 0.0 then
      H := H + 360.0
  end
end;


procedure GetRgnFromBmp(var rgn: hrgn; MaskBmp: TBitmap; TransColor: TColor);
var
  ArOR: TAOR;
  subrgn: hrgn;
  i, l: integer;
begin
  SetLength(ArOR, 0);
  AddRgnBmp(ArOR, MaskBmp, TsColor(TransColor));
  l := Length(ArOR);
  rgn := CreateRectRgn(0, 0, MaskBmp.Width, MaskBmp.Height);
  if l > 0 then
    for i := 0 to l - 1 do begin
      subrgn := CreateRectRgn(ArOR[i].Left, ArOR[i].Top, ArOR[i].Right, ArOR[i].Bottom);
      CombineRgn(rgn, rgn, subrgn, RGN_DIFF);
      DeleteObject(subrgn);
    end
end;


function GetBGInfo(const BGInfo: PacBGInfo; const Handle: THandle; PleaseDraw: boolean = False): boolean;
var
  b: boolean;
  FSaveIndex: hdc;
  P: TPoint;
begin
  Result := False;
  b := BGInfo^.PleaseDraw;
  BGInfo^.BgType := btUnknown;
  BGInfo^.PleaseDraw := PleaseDraw;
  BGInfo^.FillRect := MkRect;
  SendMessage(Handle, SM_ALPHACMD, MakeWParam(0, AC_GETBG), LPARAM(BGInfo));
  if BGInfo^.BgType <> btUnknown then
    Result := True
  else
    if b then begin // If real parent bg is required
      FSaveIndex := SaveDC(BGInfo^.DrawDC);
      GetViewportOrgEx(BGInfo^.DrawDC, P);
      SetViewportOrgEx(BGInfo^.DrawDC, P.X - BGInfo^.Offset.X, P.Y - BGInfo^.Offset.Y, nil);
      OffsetRect(BGInfo^.R, BGInfo^.Offset.X, BGInfo^.Offset.Y);
      IntersectClipRect(BGInfo^.DrawDC, BGInfo^.R.Left, BGInfo^.R.Top, BGInfo^.R.Right, BGInfo^.R.Bottom);

      SendMessage(Handle, WM_ERASEBKGND, WPARAM(BGInfo^.DrawDC), 0);
      SendMessage(Handle, WM_PAINT, WPARAM(BGInfo^.DrawDC), 0);
      RestoreDC(BGInfo^.DrawDC, FSaveIndex);
    end
    else begin
      if DefaultManager <> nil then
        BGInfo^.Color := DefaultManager.GetGlobalColor
      else
        BGInfo^.Color := clBtnFace;

      BGInfo^.BgType := btFill;
      Result := False;
    end;
end;


function BGInfoToCI(const BGInfo: PacBGInfo): TCacheInfo;
begin
  if BGInfo^.BgType = btCache then
    Result := MakeCacheInfo(BGInfo^.Bmp, BGInfo^.Offset.X, BGInfo^.Offset.Y)
  else begin
    Result.Bmp := BGInfo^.Bmp;
    Result.X := BGInfo^.Offset.X;
    Result.Y := BGInfo^.Offset.Y;
    Result.Ready := False;
    Result.FillColor := ColorToRGB(BGInfo^.Color);
    Result.FillRect := BGInfo^.FillRect;
  end;
end;


function GetBGInfo(const BGInfo: PacBGInfo; const Control: TControl; PleaseDraw: boolean = False): boolean; overload;
var
  b: boolean;
  FSaveIndex: hdc;
  P: TPoint;
begin
  BGInfo^.Bmp := nil;
  BGInfo^.BgType := btUnknown;
  BGInfo^.PleaseDraw := PleaseDraw;
  BGInfo^.FillRect := MkRect;
  b := BGInfo^.PleaseDraw;
  if (Control is TWinControl) and (TWinControl(Control)).HandleAllocated then
    SendMessage(TWinControl(Control).Handle, SM_ALPHACMD, MakeWParam(0, AC_GETBG), LPARAM(BGInfo))
  else
    Control.Perform(SM_ALPHACMD, MakeWParam(0, AC_GETBG), LPARAM(BGInfo));

  if BGInfo^.BgType = btUnknown then
    if b then begin // If real parent bg is required
      FSaveIndex := SaveDC(BGInfo^.DrawDC);
      GetViewportOrgEx(BGInfo^.DrawDC, P);
      SetViewportOrgEx(BGInfo^.DrawDC, P.X - BGInfo^.Offset.X, P.Y - BGInfo^.Offset.Y, nil);
      OffsetRect(BGInfo^.R, BGInfo^.Offset.X, BGInfo^.Offset.Y);
      IntersectClipRect(BGInfo^.DrawDC, BGInfo^.R.Left, BGInfo^.R.Top, BGInfo^.R.Right, BGInfo^.R.Bottom);

      Control.Perform(WM_ERASEBKGND, WPARAM(BGInfo^.DrawDC), 0);
      Control.Perform(WM_PAINT, WPARAM(BGInfo^.DrawDC), 0);
      RestoreDC(BGInfo^.DrawDC, FSaveIndex);
    end
    else begin
      BGInfo^.BgType := btFill;
      if (csDesigning in Control.ComponentState) and (DefaultManager <> nil) and DefaultManager.CommonSkinData.Active then
        BGInfo^.Color := DefaultManager.GetGlobalColor
      else
        BGInfo^.Color := Control.Perform(SM_ALPHACMD, MakeWParam(0, AC_GETCONTROLCOLOR), 0);

      if BGInfo^.Color = 0 then
        BGInfo^.Color := ColorToRGB(TsHackedControl(Control).Color);

      if BGInfo^.PleaseDraw and (BGInfo^.Bmp <> nil) then
        FillDC(BGInfo^.DrawDC, BGInfo^.R, BGInfo^.Color);
    end;

  Result := True;//BGInfo^.BgType <> btNotReady;
end;


procedure AddRgnBmp(var AOR: TAOR; MaskBmp: TBitmap; TransColor: TsColor);
var
  X, Y, h, w, l: Integer;
  c: TsColor;
  RegRect: TRect;
begin
  h := MaskBmp.Height - 1;
  w := MaskBmp.Width - 1;
  RegRect := Rect(-1, 0, 0, 0);
  TransColor.A := 0;
  c.A := 0;
  l := Length(AOR);
  with RegRect do
    for Y := 0 to h do begin
      for X := 0 to w do begin
        c := GetAPixel(MaskBmp, x, y);
        if c.C = TransColor.C then
          if Left <> -1 then
            inc(Right)
          else begin
            Left := X;
            Right := Left + 1;
            Top := Y;
            Bottom := Top + 1;
          end
        else
          if Left <> -1 then begin
            SetLength(aOR, l + 1);
            AOR[l] := RegRect;
            inc(l);
            Left := -1;
          end;

      end;
      if Left <> -1 then begin
        SetLength(AOR, l + 1);
        AOR[l] := RegRect;
        inc(l);
        Left := -1;
      end;
    end;
end;


procedure AddRgn(var AOR: TAOR; Width: integer; const MaskData: TsMaskData; VertOffset: integer; Bottom: boolean);
var
  S0, S: PRGBAArray;
  Delta: integer;
  X, Y, h, w, l, w2, cx: Integer;
  cur: TsColor_;
  RegRect: TRect;
  Bmp: TBitmap;
  XOffs, YOffs, MaskOffs: integer;
begin
  if MaskData.Manager <> nil then begin
    if MaskData.Bmp = nil then
      Bmp := TsSkinManager(MaskData.Manager).MasterBitmap
    else
      Bmp := MaskData.Bmp;

    if Bottom then
      h := MaskData.WB
    else
      h := MaskData.WT;

    w := MaskData.WL;
    if Bottom then
      MaskOffs := (HeightOf(MaskData.R) div (1 + MaskData.MaskType) - MaskData.WB)
    else
      MaskOffs := 0;

    XOffs := MaskData.R.Left; YOffs := MaskData.R.Top;
    if Bmp <> nil then begin
      inc(YOffs, MaskOffs);
      RegRect := Rect(-1, 0, 0, 0);
      l := Length(AOR);
      dec(h); dec(w);
      if h + YOffs <= Bmp.Height then
        if InitLine(Bmp, Pointer(S0), Delta) then
          for Y := 0 to h do begin
            S := Pointer(LongInt(S0) + Delta * (Y + YOffs));
            for X := 0 to w do begin
              cur := S[X + XOffs];
              if (cur.C = clFuchsia) then
                if RegRect.Left <> -1 then
                  inc(RegRect.Right)
                else begin
                  RegRect.Left := X;
                  RegRect.Right := RegRect.Left + 1;
                  RegRect.Top := Y + VertOffset;
                  RegRect.Bottom := RegRect.Top + 1;
                end
              else
                if RegRect.Left <> -1 then begin
                  SetLength(aOR, l + 1);
                  AOR[l] := RegRect;
                  inc(l);
                  RegRect.Left := -1;
                end;

            end;
            if RegRect.Left <> -1 then begin
              SetLength(AOR, l + 1);
              AOR[l] := RegRect;
              inc(l);
              RegRect.Left := -1;
            end;
          end;
          w2 := WidthOfImage(MaskData);
          w := w2 - MaskData.WR;
          cx := Width - w2; // First pixel on control
          dec(w2);
          for Y := 0 to h do begin
            S := Pointer(LongInt(S0) + Delta * (Y + YOffs));
            for X := w to w2 do begin
              cur := S[X + XOffs];
              if (cur.C = clFuchsia) then
                if RegRect.Left <> -1 then
                  inc(RegRect.Right)
                else begin
                  RegRect.Left := cx + X;
                  RegRect.Right := RegRect.Left + 1;
                  RegRect.Top := Y + VertOffset;
                  RegRect.Bottom := RegRect.Top + 1;
                end
              else
                if RegRect.Left <> -1 then begin
                  SetLength(aOR, l + 1);
                  AOR[l] := RegRect;
                  inc(l);
                  RegRect.Left := -1;
                end;
            end;
            if RegRect.Left <> -1 then begin
              SetLength(AOR, l + 1);
              AOR[l] := RegRect;
              inc(l);
              RegRect.Left := -1;
            end;
          end;
    end;
  end;
end;


procedure CopyImage(const Glyph: TBitmap; const ImageList: TCustomImageList; const Index: Integer);
begin
  with Glyph do begin
    Width := ImageList.Width;
    Height := ImageList.Height;
    if ImageList.BkColor = clNone then
      Canvas.Brush.Color := clFuchsia
    else
      Canvas.Brush.Color := ImageList.BkColor;//! for lack of a better color

    Canvas.FillRect(Rect(0,0, Width, Height));
{$IFDEF DELPHI7UP}
    ImageList.Draw(Canvas, 0, 0, Index, dsTransparent, itImage);
{$ELSE}
    ImageList.Draw(Canvas, 0, 0, Index, True);
{$ENDIF}
  end;
end;


procedure PaintItemBG(SkinIndex: integer; const ci: TCacheInfo; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TObject = nil; TextureIndex: integer = -1; HotTextureIndex: integer = -1; CustomColor: TColor = clFuchsia); overload;
var
  aRect, dRect, bRect: TRect;
  iDrawed: boolean;
  TempBmp: TBitmap;
  ImagePercent, GradientPercent: integer;
  w, h, Transparency: integer;
  GradientArray: TsGradArray;
  Color, C: TColor;
  aCI: TCacheInfo;

  procedure PaintAddons(var aBmp: TBitmap);
  var
    bmp: TBitmap;
    R: TRect;
  begin
    iDrawed := False;
    if (ImagePercent + GradientPercent = 100) and
         (GradientPercent in [1..99]) and
           (TsSkinManager(SkinManager).ma[TextureIndex].DrawMode = 0) and
             (GradientArray[0].Mode1 < 2) then // Optimized drawing

      if TsSkinManager(SkinManager).ma[TextureIndex].Bmp <> nil then
        PaintGradTxt(aBmp, aRect, GradientArray, TsSkinManager(SkinManager).ma[TextureIndex].Bmp, TsSkinManager(SkinManager).ma[TextureIndex].R, MaxByte * ImagePercent div 100)
      else
        PaintGradTxt(aBmp, aRect, GradientArray, TsSkinManager(SkinManager).MasterBitmap,         TsSkinManager(SkinManager).ma[TextureIndex].R, MaxByte * ImagePercent div 100)
    else begin
      R := aRect;
      // BGImage painting
      if (ImagePercent > 0) then
        with TsSkinManager(SkinManager) do begin
          if (TextureIndex > -1) and (TextureIndex < Length(ma)) then begin
            if boolean(ma[TextureIndex].MaskType) then
              TileMasked(aBmp, R, CI, ma[TextureIndex], acFillModes[ma[TextureIndex].DrawMode])
            else
              TileBitmap(aBmp.Canvas, R, ma[TextureIndex].Bmp, ma[TextureIndex], acFillModes[ma[TextureIndex].DrawMode]);

            iDrawed := True;
          end;

          if R.Right <> -1 then
            if aBmp.PixelFormat = pf32bit then
              FillRect32(aBmp, R, Color)
            else
              FillDC(aBmp.Canvas.Handle, R, Color);
        end;
      // BGGradient painting
      if (GradientPercent > 0) then
        if iDrawed then begin
          Bmp := CreateBmp32(aRect);
          try
            if Length(GradientArray) > 0 then
              PaintGrad(Bmp, MkRect(Bmp), GradientArray)
            else
              if Bmp.PixelFormat = pf32bit then
                FillRect32(Bmp, aRect, Color)
              else
                FillDC(Bmp.Canvas.Handle, aRect, Color);

            SumBmpRect(aBmp, Bmp, max(min((ImagePercent * integer(MaxByte)) div 100, MaxByte), 0), MkRect(Bmp), aRect.TopLeft);
          finally
            FreeAndNil(Bmp);
          end;
        end
        else
          if Length(GradientArray) > 0 then
            PaintGrad(aBmp, aRect, GradientArray)
          else
            if aBmp.PixelFormat = pf32bit then
              FillRect32(aBmp, aRect, Color)
            else
              FillDC(aBmp.Canvas.Handle, aRect, Color);

      case GradientPercent + ImagePercent of
        1..99:
          BlendColorRect(aBmp, aRect, GradientPercent + ImagePercent, Color);

        0:
          if not ci.Ready and (Transparency <> 0) then begin
            case Transparency of
              100: C := Color
              else C := MixColors(Color, ci.FillColor, Transparency / 100)
            end;
            FillRect32(aBmp, aRect, C)
          end

        else
          FillRect32(aBmp, aRect, Color);
      end;
    end;
  end;

begin
  if SkinManager = nil then
    SkinManager := DefaultManager;

  if not Assigned(SkinManager) or not TsSkinManager(SkinManager).IsValidSkinIndex(SkinIndex) then
    Exit;
    
  ImagePercent := 0;
  GradientPercent := 0;
  with TsSkinManager(SkinManager) do begin
    if gd[SkinIndex].States <= State then
      State := gd[SkinIndex].States - 1;

    if State > ac_MaxPropsIndex then
      State := ac_MaxPropsIndex;

    aRect := R;
    if CustomColor = clFuchsia then begin
      Color := gd[SkinIndex].Props[State].Color;
      Transparency := gd[SkinIndex].Props[State].Transparency;
      if Transparency <> 100 then begin
        ImagePercent := gd[SkinIndex].Props[State].ImagePercent;
        GradientPercent := gd[SkinIndex].Props[State].GradientPercent;
        if (ImagePercent > 0) and (TextureIndex < 0) then
          TextureIndex := gd[SkinIndex].Props[State].TextureIndex;

        if GradientPercent <> 0 then
          GradientArray := gd[SkinIndex].Props[State].GradientArray
      end;
    end
    else begin
      Color := CustomColor;
      Transparency := 0;
    end;
    if ci.Ready or (ci.FillColor <> clFuchsia) then
      case Transparency of
        100: begin
          w := WidthOf(aRect, True);
          h := HeightOf(aRect, True);
          if ci.Ready and (ci.Bmp <> nil) then begin
            if (ItemBmp <> ci.Bmp) then
              BitBlt(ItemBmp.Canvas.Handle, aRect.Left, aRect.Top, w, h, ci.Bmp.Canvas.Handle, ci.X + pP.X, ci.Y + pP.Y, SRCCOPY)
          end
          else begin
            bRect := MkRect(w, h);
            OffsetRect(bRect, pP.X, pP.Y);
            if ci.Bmp <> nil then begin
              if (ci.FillRect.Left - ci.X > 0) and (bRect.Left < ci.FillRect.Left) then begin
                dRect.Left := ci.FillRect.Left - bRect.Left;
                BitBlt(ItemBmp.Canvas.Handle, aRect.Left, aRect.Top, dRect.Left, h, ci.Bmp.Canvas.Handle, ci.X + pP.X, ci.Y + pP.Y, SRCCOPY);
              end
              else
                dRect.Left := 0;

              if (ci.FillRect.Top - ci.Y > 0) and (bRect.Top < ci.FillRect.Top) then begin
                dRect.Top := ci.FillRect.Top - bRect.Top;
                BitBlt(ItemBmp.Canvas.Handle, aRect.Left, aRect.Top, w, dRect.Top, ci.Bmp.Canvas.Handle, ci.X + pP.X, ci.Y + pP.Y, SRCCOPY);
              end
              else
                dRect.Top := 0;

              if (ci.FillRect.Right > 0) and (ci.Bmp.Width - ci.FillRect.Right < bRect.Right) then
                if ci.Bmp.Width > bRect.Right then begin
                  dRect.Right := bRect.Right - (ci.Bmp.Width - ci.FillRect.Right);
                  BitBlt(ItemBmp.Canvas.Handle, aRect.Right - dRect.Right, aRect.Top, dRect.Right, h, ci.Bmp.Canvas.Handle, ci.X + bRect.Right - dRect.Right, ci.Y + pP.Y, SRCCOPY);
                end
                else
                  dRect.Right := 0
              else
                dRect.Right := 0;

              if (ci.FillRect.Bottom > 0) and (ci.Bmp.Height - ci.FillRect.Bottom < bRect.Bottom) then
                if ci.Bmp.Height > bRect.Bottom then begin
                  dRect.Bottom := bRect.Bottom - (ci.Bmp.Height - ci.FillRect.Bottom);
                  BitBlt(ItemBmp.Canvas.Handle, aRect.Left, aRect.Bottom - dRect.Bottom, w, dRect.Bottom, ci.Bmp.Canvas.Handle, ci.X + pP.X, ci.Y + bRect.Bottom - dRect.Bottom, SRCCOPY);
                end
                else
                  dRect.Bottom := 0
              else
                dRect.Bottom := 0;

              FillRect32(ItemBmp, Rect(aRect.Left + dRect.Left, aRect.Top + dRect.Top, aRect.Right - dRect.Right, aRect.Bottom - dRect.Bottom), ci.FillColor);
            end
            else
              FillRect32(ItemBmp, aRect, ci.FillColor);
          end;
        end;

        0:
          PaintAddons(ItemBmp);

        else begin
          if ci.Ready or (GradientPercent + ImagePercent <> 0) then begin
            TempBmp := CreateBmp32(aRect);
            try
              OffsetRect(aRect, -aRect.Left, -aRect.Top);
              PaintAddons(TempBmp);
              aRect := R;
              if ci.Ready then begin
                if ItemBmp <> ci.Bmp then
                  BitBlt(ItemBmp.Canvas.Handle, R.Left, R.Top, WidthOf(R, True), HeightOf(R, True), ci.Bmp.Canvas.Handle, ci.X + pP.X, ci.Y + pP.y, SRCCOPY)
              end
              else
                if ItemBmp.PixelFormat = pf32bit then
                  FillRect32(ItemBmp, aRect, ci.FillColor)
                else
                  FillDC(ItemBmp.Canvas.Handle, R, ci.FillColor);

              SumBmpRect(ItemBmp, TempBmp, lo(Round(Transparency * 2.55 {255 / 100})), MkRect(WidthOf(aRect, True), HeightOf(aRect, True)), aRect.TopLeft);
            finally
              FreeAndNil(TempBmp);
            end
          end
          else begin
            case Transparency of
              0:   C := ci.FillColor;
              100: C := Color
              else C := MixColors(ci.FillColor, Color, Transparency / 100)
            end;
            if ItemBmp.PixelFormat = pf32bit then
              FillRect32(ItemBmp, aRect, C)
            else
              FillDC(ItemBmp.Canvas.Handle, aRect, C)
          end;
        end;
      end
    else
      PaintAddons(ItemBmp);

    if TextureIndex < 0 then 
      TextureIndex := gd[SkinIndex].Props[State].TextureIndex;

    case State of
      0:
        if (TextureIndex <> -1) then
          if (ma[TextureIndex].MaskType > 0) then
            if (ma[TextureIndex].DrawMode in [ord(fmDisTiled)]) then begin
              aCI := CI;
              inc(aCI.X, pP.X);
              inc(aCI.Y, pP.Y);
              TileMasked(ItemBmp, R, aCI, ma[TextureIndex], acFillModes[ma[TextureIndex].DrawMode]);
            end;

      else
        if (HotTextureIndex <> -1) then
          if (ma[HotTextureIndex].MaskType > 0) then
            if (ma[HotTextureIndex].DrawMode in [ord(fmDisTiled)]) then begin
              aCI := CI;
              inc(aCI.X, pP.X);
              inc(aCI.Y, pP.Y);
              TileMasked(ItemBmp, R, aCI, ma[HotTextureIndex], acFillModes[ma[HotTextureIndex].DrawMode]);
            end;
    end;
  end;
end;


procedure PaintItemBGFast(SkinIndex, BGIndex, BGHotIndex: integer; const ci: TCacheInfo; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TObject = nil); overload;
var
  aRect: TRect;
  Color: TColor;
  iDrawed: boolean;
  TempBmp: TBitmap;
  GradientArray: TsGradArray;
  ImagePercent, GradientPercent: integer;
  TextureIndex, Transparency, arState: integer;

  procedure PaintAddons(var aBmp: TBitmap);
  var
    bmp: TBitmap;
  begin
    iDrawed := False;
    // BGImage painting
    if (ImagePercent > 0) then
      with TsSkinManager(SkinManager) do begin
        aRect := R;
        if (TextureIndex > -1) and (TextureIndex < Length(ma)) then begin
          if boolean(ma[TextureIndex].MaskType) then
            TileMasked(aBmp, R, CI, ma[TextureIndex], acFillModes[ma[TextureIndex].DrawMode])
          else
            TileBitmap(aBmp.Canvas, R, ma[TextureIndex].Bmp, ma[TextureIndex], acFillModes[ma[TextureIndex].DrawMode]);

          iDrawed := True;
        end;

        if R.Right <> -1 then
          if aBmp.PixelFormat = pf32bit then
            FillRect32(aBmp, R, Color)
          else
            FillDC(aBmp.Canvas.Handle, R, Color)
        else
          R := aRect;
      end;
    // BGGradient painting
    if (GradientPercent > 0) then begin
      if iDrawed then begin
        bmp := CreateBmp32(R);
        try
          if Length(GradientArray) > 0 then
            PaintGrad(Bmp, MkRect(Bmp), GradientArray)
          else
            if Bmp.PixelFormat = pf32bit then
              FillRect32(Bmp, R, Color)
            else
              FillDC(Bmp.Canvas.Handle, R, Color);

          SumBmpRect(aBmp, Bmp, ImagePercent * integer(MaxByte) div 100, MkRect(Bmp), R.TopLeft);
        finally
          FreeAndNil(Bmp);
        end;
      end
      else
        if Length(GradientArray) > 0 then
          PaintGrad(aBmp, R, GradientArray)
        else
          if aBmp.PixelFormat = pf32bit then
            FillRect32(aBmp, R, Color)
          else
            FillDC(aBmp.Canvas.Handle, R, Color);
    end;
    case GradientPercent + ImagePercent of
      1..99:
        BlendColorRect(aBmp, R, GradientPercent + ImagePercent, Color);

      100:
        //

      else begin
        if not CI.Ready and (Transparency = 100) then
          if aBmp.PixelFormat = pf32bit then
            FillRect32(aBmp, R, ci.FillColor)
          else
            FillDC(aBmp.Canvas.Handle, R, CI.FillColor)
        else
          if aBmp.PixelFormat = pf32bit then
            FillRect32(aBmp, R, Color)
          else
            FillDC(aBmp.Canvas.Handle, R, Color);
      end;
    end;
  end;

begin
  if SkinManager = nil then
    SkinManager := DefaultManager;

  if Assigned(SkinManager) and TsSkinManager(SkinManager).IsValidSkinIndex(SkinIndex) then
    with TsSkinManager(SkinManager) do begin
      // Properties definition from skin file
      arState         := min(State, ac_MaxPropsIndex);
      Color           := gd[SkinIndex].Props[arState].Color;
      ImagePercent    := gd[SkinIndex].Props[arState].ImagePercent;
      GradientPercent := gd[SkinIndex].Props[arState].GradientPercent;
      Transparency    := gd[SkinIndex].Props[arState].Transparency;
      TextureIndex    := BGIndex;
      if GradientPercent <> 0 then
        GradientArray := gd[SkinIndex].Props[arState].GradientArray;

      if ci.Ready and (Transparency = 100) then begin
        if ItemBmp <> ci.Bmp then
          BitBlt(ItemBmp.Canvas.Handle, R.Left, R.Top, WidthOf(R, True), HeightOf(R, True), ci.Bmp.Canvas.Handle, ci.X + pP.X, ci.Y + pP.Y, SRCCOPY);
      end
      else
        if not ci.Ready or (Transparency = 0) then
          PaintAddons(ItemBmp)
        else
          if ci.Ready and (Transparency > 0) then begin
            TempBmp := CreateBmp32(R);
            try
              aRect := R;
              OffsetRect(R, -R.Left, -R.Top);
              PaintAddons(TempBmp);
              R := aRect;
              if ci.Ready and (ci.Bmp <> nil) and (ci.Bmp <> ItemBmp) then
                BitBlt(ItemBmp.Canvas.Handle, aRect.Left, aRect.Top, WidthOf(aRect, True), HeightOf(aRect, True), ci.Bmp.Canvas.Handle, ci.X + pP.X, ci.Y + pP.y, SRCCOPY);

              SumBmpRect(ItemBmp, TempBmp, lo(Transparency * integer(MaxByte) div 100), MkRect(WidthOf(aRect, True), HeightOf(aRect, True)), aRect.TopLeft);
            finally
              FreeAndNil(TempBmp);
            end;
          end;
    end;
end;


procedure PaintItemFast(SkinIndex, MaskIndex, BGIndex, BGHotIndex: integer; const ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TObject = nil); overload;
var
  aci: TCacheInfo;
begin
  if SkinManager = nil then
    SkinManager := DefaultManager;

  if Assigned(SkinManager) and TsSkinManager(SkinManager).IsValidSkinIndex(SkinIndex) then 
    if (R.Bottom <= ItemBmp.Height) and (R.Right <= ItemBmp.Width) and (R.Left >= 0) and (R.Top >= 0) then begin
      if TsSkinManager(SkinManager).gd[SkinIndex].States <= State then
        State := TsSkinManager(SkinManager).gd[SkinIndex].States - 1;

      PaintItemBGFast(SkinIndex, BGIndex, BGHotIndex, ci, State, R, pP, ItemBmp, SkinManager);
      aci := ci;
      inc(aci.X, pP.X);
      inc(aci.Y, pP.Y);
      if TsSkinManager(SkinManager).IsValidImgIndex(MaskIndex) then
        DrawSkinRect(ItemBmp, R, aci, TsSkinManager(SkinManager).ma[MaskIndex], State, True);
    end;
end;


procedure PaintItem(SkinIndex: integer; const ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TObject = nil; BGIndex: integer = -1; BGHotIndex: integer = -1); overload;
var
  aci: TCacheInfo;
begin
  if (ItemBmp <> nil) and not IsRectEmpty(R) then begin
    if (SkinManager = nil) then
      SkinManager := DefaultManager;

    if not Assigned(SkinManager) or
         not TsSkinManager(SkinManager).IsValidSkinIndex(SkinIndex) or
           (R.Bottom > ItemBmp.Height) or (R.Right > ItemBmp.Width) or
             (R.Left < 0) or (R.Top < 0) then
      Exit;
    // Count of allowed states is limited in skin
    if TsSkinManager(SkinManager).gd[SkinIndex].States <= State then
      State := TsSkinManager(SkinManager).gd[SkinIndex].States - 1;

    PaintItemBG(SkinIndex, ci, State, R, pP, ItemBmp, SkinManager, BGIndex, BGHotIndex);
    with TsSkinManager(SkinManager).gd[SkinIndex] do begin
      if ImgTL > -1 then
        DrawSkinGlyph(ItemBmp, Point(R.Left, R.Top), State, 1, TsSkinManager(SkinManager).ma[ImgTL], MakeCacheInfo(ItemBmp));

      if ImgTR > -1 then
        DrawSkinGlyph(ItemBmp, Point(R.Right - WidthOfImage(TsSkinManager(SkinManager).ma[ImgTR]), R.Top), State, 1, TsSkinManager(SkinManager).ma[ImgTR], MakeCacheInfo(ItemBmp));

      if ImgBL > -1 then
        DrawSkinGlyph(ItemBmp, Point(R.Left, R.Bottom - HeightOfImage(TsSkinManager(SkinManager).ma[ImgBL])), State, 1, TsSkinManager(SkinManager).ma[ImgBL], MakeCacheInfo(ItemBmp));

      if ImgBR > -1 then
        DrawSkinGlyph(ItemBmp, Point(R.Right - WidthOfImage(TsSkinManager(SkinManager).ma[ImgBR]), R.Bottom - HeightOfImage(TsSkinManager(SkinManager).ma[ImgBR])), State, 1, TsSkinManager(SkinManager).ma[ImgBR], MakeCacheInfo(ItemBmp));

      if TsSkinManager(SkinManager).IsValidImgIndex(TsSkinManager(SkinManager).gd[SkinIndex].BorderIndex) then begin
        aci := ci;
        inc(aci.X, pP.X);
        inc(aci.Y, pP.Y);
        DrawSkinRect(ItemBmp, R, aci, TsSkinManager(SkinManager).ma[BorderIndex], State, True);
      end;
    end;
  end;
end;

procedure PaintItem(SkinIndex: integer; const ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; DC: HDC; SkinManager: TObject = nil); overload;
var
  TempBmp: TBitmap;
  SavedDC: HDC;
begin
  if (SkinManager = nil) then
    SkinManager := DefaultManager;

  if not Assigned(SkinManager) or
       not TsSkinManager(SkinManager).IsValidSkinIndex(SkinIndex) or
         (R.Left < 0) or (R.Top < 0) or (R.Right - R.Left < 1) or (R.Bottom - R.Top < 1) then
    Exit;

  SavedDC := SaveDC(DC);
  TempBmp := CreateBmp32(r);
  try
    PaintItem(SkinIndex, ci, Filling, State , MkRect(TempBmp), pP, TempBmp, SkinManager);
    BitBlt(DC, r.Left, r.top, WidthOf(r, True), HeightOf(r, True), TempBmp.Canvas.Handle, 0, 0, SRCCOPY);
  finally
    FreeAndNil(TempBmp);
    RestoreDC(DC, SavedDC);
  end;
end;


procedure PaintItemBG(SkinData: TsCommonData; const ci: TCacheInfo; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; OffsetX: integer = 0; OffsetY: integer = 0); overload;
var
  CustomColor: TColor;
begin
  if SkinData.CustomColor then // If custom color used
    if SkinData.FOwnerObject is TsSkinProvider then
      CustomColor := ColorToRGB(TsHackedControl(TsSkinProvider(SkinData.FOwnerObject).Form).Color)
    else
      if (SkinData.FOwnerControl <> nil) then
        CustomColor := ColorToRGB(TsHackedControl(SkinData.FOwnerControl).Color)
      else
        CustomColor := clFuchsia
  else
    CustomColor := clFuchsia;

  State := min(State, SkinData.SkinManager.gd[SkinData.SkinIndex].States - 1);
  PaintItemBG(SkinData.SkinIndex, ci, State, R, pP, ItemBmp, SkinData.SkinManager, SkinData.Texture, SkinData.HotTexture, CustomColor);
end;


procedure PaintItemBG(SkinIndex: integer; const SkinSection: string; const ci: TCacheInfo; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TObject = nil; TextureIndex: integer = -1; HotTextureIndex: integer = -1; CustomColor: TColor = clFuchsia);
begin
  PaintItemBG(SkinIndex, ci, State, R, pP, ItemBmp, SkinManager, TextureIndex, HotTextureIndex, CustomColor);
end;


procedure PaintItemBGFast(SkinIndex, BGIndex, BGHotIndex: integer; const SkinSection: string; const ci: TCacheInfo; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TObject = nil);
begin
  PaintItemBGFast(SkinIndex, BGIndex, BGHotIndex, ci, State, R, pP, ItemBmp, SkinManager);
end;


procedure PaintItem(SkinIndex: integer; const SkinSection: string; const ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; DC: HDC; SkinManager: TObject = nil); overload;
begin
  PaintItem(SkinIndex, ci, Filling, State, R, pP, DC, SkinManager);
end;


procedure PaintItem(SkinIndex: integer; const SkinSection: string; const ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TObject = nil; BGIndex: integer = -1; BGHotIndex: integer = -1); overload;
begin
  PaintItem(SkinIndex, ci, Filling, State, R, pP, ItemBmp, SkinManager, BGIndex, BGHotIndex);
end;


procedure PaintItemFast(SkinIndex, MaskIndex, BGIndex, BGHotIndex: integer; const SkinSection: string; const ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TObject = nil); overload;
begin
  PaintItemFast(SkinIndex, MaskIndex, BGIndex, BGHotIndex, ci, Filling, State, R, pP, ItemBmp, SkinManager);
end;


function PaintSection(const Bmp: TBitmap; Section: string; const SecondSection: string; const State: integer; const Manager: TObject; const ParentOffset: TPoint; const BGColor: TColor; ParentDC: hdc = 0): integer;
var
  CI: TCacheInfo;
begin
  with TsSkinManager(Manager) do begin
    Result := GetSkinIndex(Section);
    if not IsValidSkinIndex(Result) then
      Result := GetSkinIndex(SecondSection);

    if IsValidSkinIndex(Result) then begin
      CI.FillColor := BGColor;
      CI.Ready := ParentDC <> 0;
      if not CI.Ready then
        CI.Bmp := nil
      else begin
        BitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, ParentDC, ParentOffset.x, ParentOffset.y, SRCCOPY);
        CI.Bmp := Bmp;
      end;
      PaintItem(Result, CI, True, State, MkRect(Bmp), MkPoint, Bmp, Manager);
    end;
  end;
end;


function PaintSection(const Bmp: TBitmap; SectionIndex: integer; const SecondIndex: integer; const State: integer; const Manager: TObject; const ParentOffset: TPoint; const BGColor: TColor; ParentDC: hdc = 0): integer; overload;
var
  CI: TCacheInfo;
begin
  with TsSkinManager(Manager) do begin
    if SectionIndex >= 0 then
      Result := SectionIndex
    else
      Result := SecondIndex;

    if Result >= 0 then begin
      CI.FillColor := BGColor;
      CI.Ready := ParentDC <> 0;
      if not CI.Ready then
        CI.Bmp := nil
      else begin
        BitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, ParentDC, ParentOffset.x, ParentOffset.y, SRCCOPY);
        CI.Bmp := Bmp;
      end;
      PaintItem(Result, CI, True, State, MkRect(Bmp), MkPoint, Bmp, Manager);
    end;
  end;
end;


procedure PaintItem(SkinData: TsCommonData; const ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; UpdateCorners: boolean; OffsetX: integer = 0; OffsetY: integer = 0); overload;
var
  aci: TCacheInfo;
begin
  if SkinData.SkinManager <> nil then
    with SkinData.SkinManager do begin
      if (ItemBmp = nil) or (R.Bottom > ItemBmp.Height) or (R.Right > ItemBmp.Width) or (R.Left < 0) or (R.Top < 0) or not IsValidSkinIndex(SkinData.SkinIndex) then
        Exit;

      if State >= gd[SkinData.SkinIndex].States then
        State := gd[SkinData.SkinIndex].States - 1;

      PaintItemBG(SkinData, ci, State, R, pP, ItemBmp, OffsetX, OffsetY);
      with gd[SkinData.SkinIndex] do begin
        if IsValidImgIndex(ImgTL) then
          DrawSkinGlyph(ItemBmp, Point(R.Left, R.Top), State, 1, ma[ImgTL], MakeCacheInfo(ItemBmp));

        if IsValidImgIndex(ImgTR) then
          DrawSkinGlyph(ItemBmp, Point(R.Right - WidthOfImage(ma[ImgTR]), R.Top), State, 1, ma[ImgTR], MakeCacheInfo(ItemBmp));

        if IsValidImgIndex(ImgBL) then
          DrawSkinGlyph(ItemBmp, Point(0, R.Bottom - HeightOfImage(ma[ImgBL])), State, 1, ma[ImgBL], MakeCacheInfo(ItemBmp));

        if IsValidImgIndex(ImgBR) then
          DrawSkinGlyph(ItemBmp, Point(R.Right - WidthOfImage(ma[ImgBR]), R.Bottom - HeightOfImage(ma[ImgBR])), State, 1, ma[ImgBR], MakeCacheInfo(ItemBmp));
      end;
      if IsValidImgIndex(SkinData.BorderIndex) and not ((State = 0) and (ma[SkinData.BorderIndex].DrawMode and BDM_ACTIVEONLY = BDM_ACTIVEONLY)) then begin
        aci := ci;
        inc(aci.X, pP.X);
        inc(aci.Y, pP.Y);
        DrawSkinRect(ItemBmp, R, aci, ma[SkinData.BorderIndex], State, UpdateCorners);
        if SkinData.ColorTone <> clNone then
          ChangeBitmapPixels(ItemBmp, ChangeColorTone, SkinData.ColorTone, clFuchsia);

        if SkinData.HUEOffset <> 0 then
          ChangeBitmapPixels(ItemBmp, ChangeColorHUE, SkinData.HUEOffset, clFuchsia);

        if SkinData.Saturation <> 0 then
          ChangeBitmapPixels(ItemBmp, ChangeColorSaturation, SkinData.Saturation, clFuchsia);
      end
      else
        if IsValidSkinIndex(SkinData.SkinIndex) and (gd[SkinData.SkinIndex].Props[min(State, ac_MaxPropsIndex)].Transparency = 0) then begin
          if SkinData.ColorTone <> clNone then
            ChangeBitmapPixels(ItemBmp, ChangeColorTone, SkinData.ColorTone, clFuchsia);

          if (SkinData.HUEOffset <> 0) then
            ChangeBitmapPixels(ItemBmp, ChangeColorHUE, SkinData.HUEOffset, clFuchsia);

          if (SkinData.Saturation <> 0) then
            ChangeBitmapPixels(ItemBmp, ChangeColorSaturation, SkinData.Saturation, clFuchsia);
        end;
    end;
end;


function PaintSkinControl(const SkinData: TsCommonData; const Parent: TControl; const Filling: boolean; State: integer; const R: TRect; const pP: TPoint; const ItemBmp: TBitmap; const UpdateCorners: boolean; const OffsetX: integer = 0; const OffsetY: integer = 0): boolean;
var
  BG: TacBGInfo;
  CI: TCacheInfo;
begin
  Result := True;
  if SkinData.SkinManager <> nil then
    with SkinData.SkinManager do begin
      if (ItemBmp = nil) or (R.Bottom > ItemBmp.Height) or (R.Right > ItemBmp.Width) or (R.Left < 0) or (R.Top < 0) or not IsValidSkinIndex(SkinData.SkinIndex) then
        Exit;

      if State >= gd[SkinData.SkinIndex].States then
        State := gd[SkinData.SkinIndex].States - 1;

      BG.PleaseDraw := False;
      GetBGInfo(@BG, Parent);
      if BG.BgType = btNotReady then
        Result := False
      else begin
        CI := BGInfoToCI(@BG);
        PaintItemBG(SkinData, ci, State, R, pP, ItemBmp, OffsetX, OffsetY);
        inc(ci.X, pP.X);
        inc(ci.Y, pP.Y);
        if IsValidImgIndex(SkinData.BorderIndex) and not ((State = 0) and (ma[SkinData.BorderIndex].DrawMode and BDM_ACTIVEONLY = BDM_ACTIVEONLY)) then
          DrawSkinRect(ItemBmp, R, ci, ma[SkinData.BorderIndex], State, UpdateCorners);

        with gd[SkinData.SkinIndex] do begin
          if ImgTL > -1 then
            DrawSkinGlyph(ItemBmp, Point(R.Left, R.Top), State, 1, ma[ImgTL], MakeCacheInfo(ItemBmp));

          if ImgTR > -1 then
            DrawSkinGlyph(ItemBmp, Point(R.Right - WidthOfImage(ma[ImgTR]), R.Top), State, 1, ma[ImgTR], MakeCacheInfo(ItemBmp));

          if ImgBL > -1 then
            DrawSkinGlyph(ItemBmp, Point(0, R.Bottom - HeightOfImage(ma[ImgBL])), State, 1, ma[ImgBL], MakeCacheInfo(ItemBmp));

          if ImgBR > -1 then
            DrawSkinGlyph(ItemBmp, Point(R.Right - WidthOfImage(ma[ImgBR]), R.Bottom - HeightOfImage(ma[ImgBR])), State, 1, ma[ImgBR], MakeCacheInfo(ItemBmp));
        end;
      end;
    end;
end;


procedure CopyChannel32(const DstBmp, SrcBmp: TBitmap; const Channel: integer);
var
  D0, S0, D, S: PByteArray;
  DeltaS, DeltaD: integer;
  X, Y: integer;
begin
  if InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(DstBmp, Pointer(D0), DeltaD) then
    for Y := 0 to DstBmp.Height - 1 do begin
      D := Pointer(LongInt(D0) + DeltaD * Y);
      S := Pointer(LongInt(S0) + DeltaS * Y);
      for X := 0 to DstBmp.Width - 1 do
        D[X * 4 + Channel] := S[X * 4 + Channel];
    end;
end;


procedure CopyChannel32(const DstBmp, SrcBmp: TBitmap; const Channel: integer; DstRect, SrcRect: TRect); overload;
var
  D0, S0, D, S: PByteArray;
  DeltaS, DeltaD: integer;
  X, Y, X1, Y1, hSrc, wSrc: integer;
begin
  hSrc := HeightOf(SrcRect, True) - 1;
  if hSrc + SrcRect.Top >= SrcBmp.Height then
    hSrc := SrcBmp.Height - SrcRect.Top - 1;

  if hSrc + DstRect.Top >= DstBmp.Height then
    hSrc := DstBmp.Height - DstRect.Top - 1;

  if SrcRect.Top < 0 then
    Y1 := -SrcRect.Top else Y1 := 0;

  if DstRect.Top < 0 then
    Y1 := min(Y1, -SrcRect.Top);

  wSrc := WidthOf(SrcRect, True) - 1;
  if wSrc + SrcRect.Left >= SrcBmp.Width then
    wSrc := SrcBmp.Width - SrcRect.Left - 1;

  if wSrc + DstRect.Left >= DstBmp.Width then
    wSrc := DstBmp.Width - DstRect.Left - 1;

  if SrcRect.Left < 0 then
    X1 := -DstRect.Left
  else
    X1 := 0;

  if DstRect.Left < 0 then
    X1 := max(X1, -DstRect.Left);

  if InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(DstBmp, Pointer(D0), DeltaD) then
    with SrcRect do
      for Y := Y1 to hSrc + Y1 do begin
        D := Pointer(LongInt(D0) + DeltaD * (Y + DstRect.Top));
        S := Pointer(LongInt(S0) + DeltaS * (Y + Top));
        for X := X1 to wSrc + X1 do
          D[(X + DstRect.Left) * 4 + Channel] := S[(X + Left) * 4 + Channel];
      end;
end;


procedure CopyChannel(const Bmp32, Bmp8: TBitmap; const Channel: integer; const From32To8: boolean);
var
  S0, D0, D, S: PByteArray;
  DeltaS, DeltaD, X, Y: integer;
begin
  if From32To8 then begin
    if InitLine(Bmp32, Pointer(S0), DeltaS) and InitLine(Bmp8, Pointer(D0), DeltaD) then
      for Y := 0 to Bmp32.Height - 1 do begin
        D := Pointer(LongInt(D0) + DeltaD * Y);
        S := Pointer(LongInt(S0) + DeltaS * Y);
        for X := 0 to Bmp32.Width - 1 do
          D[X] := S[X * 4 + Channel];
      end
  end
  else
    if InitLine(Bmp8, Pointer(S0), DeltaS) and InitLine(Bmp32, Pointer(D0), DeltaD) then
      for Y := 0 to Bmp32.Height - 1 do begin
        D := Pointer(LongInt(D0) + DeltaD * Y);
        S := Pointer(LongInt(S0) + DeltaS * Y);
        for X := 0 to Bmp32.Width - 1 do
          D[X * 4 + Channel] := S[X];
      end;
end;


procedure PaintControlByTemplate(const DstBmp, SrcBmp: TBitmap; const DstRect, SrcRect, BorderWidths, BorderMaxWidths: TRect; const DrawModes: TRect; const StretchCenter: boolean; FillCenter: boolean = True);
var
  X, Y, w, h, i: integer;
  dl, dr, dt, db: integer;
begin
  dl := min(BorderWidths.Left,   BorderMaxWidths.Left);
  dr := min(BorderWidths.Right,  BorderMaxWidths.Right);
  dt := min(BorderWidths.Top,    BorderMaxWidths.Top);
  db := min(BorderWidths.Bottom, BorderMaxWidths.Bottom);
  SetStretchBltMode(DstBmp.Canvas.Handle, COLORONCOLOR);
  // Copy corners
  // LeftTop
  BitBlt(DstBmp.Canvas.Handle, DstRect.Left, DstRect.Top, BorderWidths.Left, dt, SrcBmp.Canvas.Handle, SrcRect.Left, SrcRect.Top, SRCCOPY);
  if dt <> BorderWidths.Top then
    BitBlt(DstBmp.Canvas.Handle, DstRect.Left, DstRect.Top + dt, dl, BorderWidths.Top - dt, SrcBmp.Canvas.Handle, SrcRect.Left, SrcRect.Top + dt, SRCCOPY);

  // LeftBottom
  BitBlt(DstBmp.Canvas.Handle, DstRect.Left, DstRect.Bottom - db, BorderWidths.Left, db, SrcBmp.Canvas.Handle, SrcRect.Left, SrcRect.Bottom - db, SRCCOPY);
  if db <> BorderWidths.Bottom then
    BitBlt(DstBmp.Canvas.Handle, DstRect.Left, DstRect.Bottom - BorderWidths.Bottom, dl, BorderWidths.Bottom - db, SrcBmp.Canvas.Handle, SrcRect.Left, SrcRect.Bottom - BorderWidths.Bottom, SRCCOPY);

  // RightTop
  BitBlt(DstBmp.Canvas.Handle, DstRect.Right - BorderWidths.Right, DstRect.Top, BorderWidths.Right, dt, SrcBmp.Canvas.Handle, SrcRect.Right - BorderWidths.Right, SrcRect.Top, SRCCOPY);
  if dt <> BorderWidths.Top then
    BitBlt(DstBmp.Canvas.Handle, DstRect.Right - dr, DstRect.Top + dt, dr, BorderWidths.Top - dt, SrcBmp.Canvas.Handle, SrcRect.Right - dr, SrcRect.Top + dt, SRCCOPY);

  // RightBottom
  BitBlt(DstBmp.Canvas.Handle, DstRect.Right - BorderWidths.Right, DstRect.Bottom - db, BorderWidths.Right, db, SrcBmp.Canvas.Handle, SrcRect.Right - BorderWidths.Right, SrcRect.Bottom - db, SRCCOPY);
  if db <> BorderWidths.Bottom then
    BitBlt(DstBmp.Canvas.Handle, DstRect.Right - dr, DstRect.Bottom - BorderWidths.Bottom, dr, BorderWidths.Bottom - db, SrcBmp.Canvas.Handle, SrcRect.Right - dr, SrcRect.Bottom - BorderWidths.Bottom, SRCCOPY);

  w := max(0, WidthOf (SrcRect, True) - BorderWidths.Right - BorderWidths.Left);
  h := max(0, HeightOf(SrcRect, True) - BorderWidths.Bottom - BorderWidths.Top);
  // Left border
  if (h <> 0) then
    case DrawModes.Left of
      0: begin
        X := DstRect.Left;
        Y := DstRect.Top + BorderWidths.Top;
        while Y < DstRect.Bottom - BorderWidths.Bottom - h do begin
          BitBlt(DstBmp.Canvas.Handle, X, Y, dl, h, SrcBmp.Canvas.Handle, SrcRect.Left, SrcRect.Top + BorderWidths.Top, SRCCOPY);
          inc(Y, h);
        end;
        if Y < DstRect.Bottom - BorderWidths.Bottom then
          BitBlt(DstBmp.Canvas.Handle, X, Y, dl, DstRect.Bottom - BorderWidths.Bottom - Y, SrcBmp.Canvas.Handle, SrcRect.Left, SrcRect.Top + BorderWidths.Top, SRCCOPY);
      end;

      1: begin
        i := SrcRect.Bottom - SrcRect.Top - BorderWidths.Top - BorderWidths.Bottom;
        StretchBlt(DstBmp.Canvas.Handle, DstRect.Left, DstRect.Top + BorderWidths.Top, dl, DstRect.Bottom - DstRect.Top - BorderWidths.Top - BorderWidths.Bottom,
                   SrcBmp.Canvas.Handle, SrcRect.Left, SrcRect.Top + BorderWidths.Top, dl, i, SRCCOPY);
      end;
    end;
  // Top border
  if (w <> 0) then
    case DrawModes.Top of
      0: begin
        X := DstRect.Left + BorderWidths.Left;
        Y := DstRect.Top;
        while X < DstRect.Right - BorderWidths.Right - w do begin
          BitBlt(DstBmp.Canvas.Handle, X, Y, w, dt, SrcBmp.Canvas.Handle, SrcRect.Left + BorderWidths.Left, SrcRect.Top, SRCCOPY);
          inc(X, w);
        end;
        if X < DstRect.Right - BorderWidths.Right then
          BitBlt(DstBmp.Canvas.Handle, X, Y, DstRect.Right - BorderWidths.Right - X, dt, SrcBmp.Canvas.Handle, SrcRect.Left + BorderWidths.Left, SrcRect.Top, SRCCOPY);
      end;

      1:
        StretchBlt(DstBmp.Canvas.Handle, DstRect.Left + BorderWidths.Left, DstRect.Top, DstRect.Right - DstRect.Left - BorderWidths.Left - BorderWidths.Right, dt,
                   SrcBmp.Canvas.Handle, SrcRect.Left + BorderWidths.Left, SrcRect.Top, SrcRect.Right - SrcRect.Left - BorderWidths.Left - BorderWidths.Right, dt, SRCCOPY);
    end;
  // Right border
  if (h <> 0) then
    case DrawModes.Right of
      0: begin
        X := DstRect.Right - dr;
        Y := DstRect.Top + BorderWidths.Top;
        while Y < DstRect.Bottom - BorderWidths.Bottom - h do begin
          BitBlt(DstBmp.Canvas.Handle, X, Y, dr, h, SrcBmp.Canvas.Handle, SrcRect.Right - dr, SrcRect.Top + BorderWidths.Top, SRCCOPY);
          inc(Y, h);
        end;
        if Y < DstRect.Bottom - BorderWidths.Bottom then
          BitBlt(DstBmp.Canvas.Handle, X, Y, dr, DstRect.Bottom - BorderWidths.Bottom - Y, SrcBmp.Canvas.Handle, SrcRect.Right - dr, SrcRect.Top + BorderWidths.Top, SRCCOPY);
      end;

      1:
        StretchBlt(DstBmp.Canvas.Handle, DstRect.Right - dr, DstRect.Top + BorderWidths.Top, dr, DstRect.Bottom - DstRect.Top - BorderWidths.Bottom - BorderWidths.Top,
                   SrcBmp.Canvas.Handle, SrcRect.Right - dr, SrcRect.Top + BorderWidths.Top, dr, SrcRect.Bottom - SrcRect.Top - BorderWidths.Bottom - BorderWidths.Top, SRCCOPY);
    end;
  // Bottom border
  if (w <> 0) then
    case DrawModes.Bottom of
      0: begin
        X := DstRect.Left + BorderWidths.Left;
        Y := DstRect.Bottom - db;
        while X < DstRect.Right - BorderWidths.Right - w do begin
          BitBlt(DstBmp.Canvas.Handle, X, Y, w, db, SrcBmp.Canvas.Handle, SrcRect.Left + BorderWidths.Left, SrcRect.Bottom - db, SRCCOPY);
          inc(X, w);
        end;
        if X < DstRect.Right - BorderWidths.Right then
          BitBlt(DstBmp.Canvas.Handle, X, Y, DstRect.Right - BorderWidths.Right - X, db, SrcBmp.Canvas.Handle, SrcRect.Left + BorderWidths.Left, SrcRect.Bottom - db, SRCCOPY);
      end;

      1:
        StretchBlt(DstBmp.Canvas.Handle, DstRect.Left + BorderWidths.Left, DstRect.Bottom - db, DstRect.Right - DstRect.Left - BorderWidths.Right - BorderWidths.Left, db,
                   SrcBmp.Canvas.Handle, SrcRect.Left + BorderWidths.Left, SrcRect.Bottom - db, SrcRect.Right - SrcRect.Left - BorderWidths.Right - BorderWidths.Left, db, SRCCOPY);
    end;
  // Center
  if FillCenter then
    if StretchCenter then
      StretchBlt(DstBmp.Canvas.Handle, DstRect.Left + BorderWidths.Left, DstRect.Top + BorderWidths.Top,
                 DstRect.Right - DstRect.Left - BorderWidths.Right - BorderWidths.Left, DstRect.Bottom - DstRect.Top - BorderWidths.Bottom - BorderWidths.Top,
                 SrcBmp.Canvas.Handle, SrcRect.Left + BorderWidths.Left, SrcRect.Top + BorderWidths.Top,
                 SrcRect.Right - SrcRect.Left - BorderWidths.Right - BorderWidths.Left, SrcRect.Bottom - SrcRect.Top - BorderWidths.Bottom - BorderWidths.Top, SRCCOPY)
    else
      if (h <> 0) and (w <> 0) then begin
        X := DstRect.Left + BorderWidths.Left;
        while X < DstRect.Right - BorderWidths.Right - w do begin
          Y := DstRect.Top + BorderWidths.Top;
          while Y < DstRect.Bottom - BorderWidths.Bottom - h do begin
            BitBlt(DstBmp.Canvas.Handle, X, Y, w, h, SrcBmp.Canvas.Handle, SrcRect.Left + BorderWidths.Left, SrcRect.Top + BorderWidths.Top, SRCCOPY);
            inc(Y, h);
          end;
          if Y < DstRect.Bottom - BorderWidths.Bottom then
            BitBlt(DstBmp.Canvas.Handle, X, Y, w, DstRect.Bottom - BorderWidths.Bottom - Y, SrcBmp.Canvas.Handle, SrcRect.Left + BorderWidths.Left, SrcRect.Top + BorderWidths.Top, SRCCOPY);
          inc(X, w);
        end;
        if X < DstRect.Right - BorderWidths.Right then begin
          Y := DstRect.Top + BorderWidths.Top;
          while Y < DstRect.Bottom - BorderWidths.Bottom - h do begin
            BitBlt(DstBmp.Canvas.Handle, X, Y, DstRect.Right - BorderWidths.Right - X, h, SrcBmp.Canvas.Handle, SrcRect.Left + BorderWidths.Left, SrcRect.Top + BorderWidths.Top, SRCCOPY);
            inc(Y, h);
          end;
          if Y < DstRect.Bottom - BorderWidths.Bottom then
            BitBlt(DstBmp.Canvas.Handle, X, Y, DstRect.Right - BorderWidths.Right - X, DstRect.Bottom - BorderWidths.Bottom - Y, SrcBmp.Canvas.Handle, SrcRect.Left + BorderWidths.Left, SrcRect.Top + BorderWidths.Top, SRCCOPY);
        end;
      end;
end;


procedure DrawGlyphReflection(DstBmp, SrcBmp: TBitmap; DstTopLeft: TPoint; SrcRect: TRect; TransColor: TsColor_; BlendValue: integer);
var
  oldleft, oldtop, dx, dy, h, w, width, height, curX, nextX: integer;
  S0, D0, S, D: PRGBAArray;
  DeltaS, DeltaD: integer;
  TransStep, TransValue: byte;
  MaskValue: integer;
  Col_: TsColor_;
begin
{$IFNDEF WIN64}
  S := nil;
  D := nil;
{$ENDIF}
  if SrcRect.Top < 0 then begin
    oldtop := SrcRect.Top;
    SrcRect.Top := 0
  end
  else
    oldtop := 0;

  if SrcRect.Left < 0 then begin
    oldleft := SrcRect.Left;
    SrcRect.Left := 0
  end
  else
    oldleft := 0;

  if SrcRect.Bottom > SrcBmp.Height - 1 then
    SrcRect.Bottom := SrcBmp.Height - 1;

  if SrcRect.Right > SrcBmp.Width - 1 then
    SrcRect.Right := SrcBmp.Width - 1;

  w := WidthOf(SrcRect);
  width := DstBmp.Width - 1;
  height := DstBmp.Height - 1;
  h := min(SrcBmp.Height div 3 * 2 - 1, DstBmp.Height - (DstTopLeft.Y) - 1);

  TransStep := MaxByte div (h);
  TransValue := MaxByte;
  TransColor.C := SwapColor(TransColor.C);

  if InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(DstBmp, Pointer(D0), DeltaD) then
    with DstTopLeft do
      for dy := 0 to h do begin
        if (dy + Y > height) then
          Continue
        else
          if dy + Y < 0 then
            Continue;

        if dy + SrcRect.Top >= 0 then
          S := Pointer(LongInt(S0) + DeltaS * (SrcRect.Bottom - dy - oldtop))
        else
          Continue;

        if dy + Y - oldtop < 0 then
          Continue
        else
          if dy + Y - oldtop > DstBmp.Height - 1 then
            Continue
          else
            D := Pointer(LongInt(D0) + DeltaD * (Y + dy));

        nextX := X - oldleft;
        CurX := SrcRect.Left;
        MaskValue := (MaxByte * (h - dy) div h * TransValue shr 9 * (100 - BlendValue) div 100) and MaxByte;
        for dx := 0 to w do begin
          if (nextX > Width) then
            Break;

          if (nextX < 0) then
            Continue;

          if CurX > SrcBmp.Width - 1 then
            Continue;

          Col_ := S[CurX];
          if Col_.C <> TransColor.C then
            with D[nextX] do begin
              R := ((Col_.R - R) * MaskValue + R shl 8) shr 8;
              G := ((Col_.G - G) * MaskValue + G shl 8) shr 8;
              B := ((Col_.B - B) * MaskValue + B shl 8) shr 8;
            end;

          inc(nextX);
          inc(CurX);
        end;
        dec(TransValue, TransStep);
      end;
end;


procedure DrawGlyphEx(Glyph, DstBmp: TBitmap; R: TRect; NumGlyphs: integer; Enabled: boolean; DisabledGlyphKind: TsDisabledGlyphKind; State, Blend: integer; Down: boolean = False; Reflected: boolean = False);
var
  CI: TCacheInfo;
  TmpGlyph: TBitmap;
  MaskColor: TsColor;
  w, GlyphIndex: integer;
begin
  GlyphIndex := -1;
  TmpGlyph := TBitmap.Create;
  TmpGlyph.Assign(Glyph);
  TmpGlyph.PixelFormat := pf32bit;
  if Reflected then
    OffsetRect(R, 0, - HeightOf(R) div 8);

  if NumGlyphs = 1 then
    State := 0;

  if State > 0 then
    Blend := 0;

  if not Enabled then
    GlyphIndex := 0
  else begin
    case State of
      0:
        GlyphIndex := 0;

      1:
        if (Glyph.PixelFormat = pf4bit) or (DefaultManager = nil) or DefaultManager.Options.StdGlyphsOrder then
          GlyphIndex := 0
        else
          GlyphIndex := 1;

      2:
        if NumGlyphs > 2 + integer(Down) then
          GlyphIndex := 2 + integer(Down)
        else begin
          if (Glyph.PixelFormat = pf4bit) or (DefaultManager = nil) or DefaultManager.Options.StdGlyphsOrder then
            GlyphIndex := 0
          else
            GlyphIndex := min(1, NumGlyphs - 1);
        end;

      3:
        if NumGlyphs > 2 then
          GlyphIndex := 2
        else
          GlyphIndex := 0;
    end;
  end;
  w := TmpGlyph.Width div NumGlyphs;
  MaskColor := TsColor(TmpGlyph.Canvas.Pixels[GlyphIndex * w, TmpGlyph.Height - 1]);
  if Enabled or (Blend = 0) then begin
    CI := MakeCacheInfo(DstBmp);
    CopyTransRectA(DstBmp, TmpGlyph, R.Left, R.Top, Rect(w * GlyphIndex, 0, (GlyphIndex + 1) * w - 1, TmpGlyph.Height - 1), MaskColor.C, CI)
  end
  else
    BlendTransRectangle(DstBmp, R.Left, R.Top, TmpGlyph, Rect(w * GlyphIndex, 0, (GlyphIndex + 1) * w - 1, TmpGlyph.Height - 1), Blend / 100);

  if Reflected then begin
    OffsetRect(R, 0, HeightOf(R));
    DrawGlyphReflection(DstBmp, TmpGlyph, R.TopLeft, Rect(w * GlyphIndex, 0, (GlyphIndex + 1) * w - 1, TmpGlyph.Height - 1), TsColor_(MaskColor), Blend);
  end;
  FreeAndNil(TmpGlyph);
end;
{$ENDIF}


procedure FillDC(DC: HDC; const aRect: TRect; const Color: TColor);
var
  OldBrush, NewBrush: hBrush;
  SavedDC: hdc;
begin
  SavedDC := SaveDC(DC);
  NewBrush := CreateSolidBrush(Cardinal(ColorToRGB(Color)));
  OldBrush := SelectObject(dc, NewBrush);
  try
    FillRect(DC, aRect, NewBrush);
  finally
    SelectObject(dc, OldBrush);
    DeleteObject(NewBrush);
    RestoreDC(DC, SavedDC);
  end;
end;


procedure FillDCBorder(const DC: HDC; const aRect: TRect; const wl, wt, wr, wb: integer; const Color: TColor);
var
  OldBrush, NewBrush: hBrush;
  SavedDC: hWnd;
begin
  SavedDC := SaveDC(DC);
  NewBrush := CreateSolidBrush(Cardinal(ColorToRGB(Color)));
  OldBrush := SelectObject(dc, NewBrush);
  try
    FillRect(DC, Rect(aRect.Left,       aRect.Top,         aRect.Right,     aRect.Top + wt),    NewBrush);
    FillRect(DC, Rect(aRect.Left,       aRect.Top + wt,    aRect.Left + wl, aRect.Bottom),      NewBrush);
    FillRect(DC, Rect(aRect.Left + wl,  aRect.Bottom - wb, aRect.Right,     aRect.Bottom),      NewBrush);
    FillRect(DC, Rect(aRect.Right - wr, aRect.Top + wt,    aRect.Right,     aRect.Bottom - wb), NewBrush);
  finally
    SelectObject(dc, OldBrush);
    DeleteObject(NewBrush);
    RestoreDC(DC, SavedDC);
  end;
end;


procedure BitBltBorder(const DestDC: HDC; const X, Y, Width, Height: Integer; const SrcDC: HDC; const XSrc, YSrc: Integer; const BorderWidth: integer);
begin
  BitBlt(DestDC, X, Y, BorderWidth, Height, SrcDC, XSrc, YSrc, SRCCOPY);
  BitBlt(DestDC, X + BorderWidth, Y, Width, BorderWidth, SrcDC, XSrc + BorderWidth, YSrc, SRCCOPY);
  BitBlt(DestDC, Width - BorderWidth, Y + BorderWidth, Width, Height, SrcDC, XSrc + Width - BorderWidth, YSrc + BorderWidth, SRCCOPY);
  BitBlt(DestDC, X + BorderWidth, Height - BorderWidth, Width - BorderWidth, Height, SrcDC, XSrc + BorderWidth, YSrc + Height - BorderWidth, SRCCOPY);
end;


procedure ExcludeControls(const DC: hdc; const Ctrl: TWinControl; const CtrlType: TacCtrlType; const OffsetX: integer; const OffsetY: integer);
var
  i: integer;
  Child: TControl;
begin
  for i := 0 to Ctrl.ControlCount - 1 do begin
    Child := Ctrl.Controls[i];
    if (Child is TGraphicControl) and StdTransparency {$IFNDEF ALITE} or (Child is TsSplitter) {$ENDIF} then
      Continue;

    if Child.Visible then
      if (Child is TGraphicControl) then
        ExcludeClipRect(DC, Child.Left + OffsetX, Child.Top + OffsetY, Child.Left + Child.Width + OffsetX, Child.Top + Child.Height + OffsetY);
  end;
end;


procedure GrayScale(Bmp: TBitmap);
var
  S0, S: PRGBAArray;
  Delta: integer;
  x, y, w, h: integer;
begin
  h := Bmp.Height - 1;
  w := Bmp.Width - 1;
  if InitLine(Bmp, Pointer(S0), Delta) then
    for y := 0 to h do begin
      S := Pointer(LongInt(S0) + Delta * Y);
      for x := 0 to w do
        with S[x] do begin
          R := (R + G + B) div 3;
          G := R;
          B := R;
        end
    end;
end;


procedure GrayScaleTrans(Bmp: TBitmap; const TransColor: TsColor);
var
  S0, S: PRGBAArray;
  Delta: integer;
  x, y, w, h: integer;
  InvColor: TsColor_;
begin
  h := Bmp.Height - 1;
  w := Bmp.Width - 1;
  InvColor.C := TransColor.C;
  InvColor.R := TransColor.B;
  InvColor.B := TransColor.R;
  if InitLine(Bmp, Pointer(S0), Delta) then
    for Y := 0 to h do begin
      S := Pointer(LongInt(S0) + Delta * Y);
      for X := 0 to w do
        with S[x] do
          if (C <> InvColor.C) then begin
            R := (R + G + B) div 3;
            G := R;
            B := R
          end
    end;
end;


procedure SetBmp32Pixels(var Bmp: TBitmap);
{$IFDEF FPC}
var
  TmpBmp: TBitmap;
begin
  if Bmp.PixelFormat <> pf32bit then begin
    TmpBmp := CreateBmp32(Bmp.Width, Bmp.Height);
    BitBlt(TmpBmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
    Bmp.Free;
    Bmp := TmpBmp;
  end
{$ELSE}
begin
    Bmp.PixelFormat := pf32bit;
{$ENDIF}
end;


function CutText(Canvas: TCanvas; const Text: acString; MaxLength: integer): acString;
begin
  Result := iff(MaxLength < 1, '', Text);
  if (Canvas.TextWidth(Result) > MaxLength) and (Result <> '') then begin
    while (Result <> '') and (Canvas.TextWidth(Result + s_Ellipsis) > MaxLength) do
      Delete(Result, Length(Result), 1);

    if Result <> '' then
      Result := Result + s_Ellipsis;
  end;
end;


procedure WriteText(Canvas: TCanvas; Text: PChar; Enabled: boolean; var aRect: TRect; Flags: Cardinal);
var
  x, y: integer;
  R, Rd: TRect;
  ts: TSize;
begin
  R := aRect;
  if Flags or DT_WORDBREAK <> Flags then begin // If not multiline
    GetTextExtentPoint32(Canvas.Handle, Text, Length(Text), ts);
    R.Right := R.Left + ts.cx;
    R.Bottom := R.Top + ts.cy;
    if Flags or DT_CENTER = Flags then begin
      y := (HeightOf(R) - HeightOf(aRect)) div 2;
      x := (WidthOf(R, True) - WidthOf(aRect, True)) div 2;
      InflateRect(aRect, x, y);
    end
    else
      if Flags or DT_RIGHT = Flags then begin
        y := (HeightOf(R) - HeightOf(aRect)) div 2;
        dec(aRect.Top, y);
        inc(aRect.Bottom, y);
        inc(aRect.Left, WidthOf(aRect, True) - WidthOf(R, True));
      end
      else
        if Flags or DT_LEFT = Flags then begin
          y := (HeightOf(R) - HeightOf(aRect)) div 2;
          dec(aRect.Top, y);
          inc(aRect.Bottom, y);
          inc(aRect.Right, WidthOf(R) - WidthOf(aRect));
        end;

    R := aRect;
    InflateRect(aRect, 1, 1);
  end;
  Canvas.Brush.Style := bsClear;
  if Text <> ''then
    if Enabled then
      DrawText(Canvas.Handle, Text, Length(Text), R, Flags)
    else begin
      Rd := Rect(R.Left + 1, R.Top + 1, R.Right + 1, R.Bottom + 1);
      Canvas.Font.Color := ColorToRGB(clBtnHighlight);
      DrawText(Canvas.Handle, Text, Length(Text), Rd, Flags);

      Canvas.Font.Color := ColorToRGB(clBtnShadow);
      DrawText(Canvas.Handle, Text, Length(Text), R, Flags);
    end;
end;


procedure WriteTextOnDC(DC: hdc; Text: PChar; Enabled: boolean; var aRect: TRect; Flags: Cardinal);
var
  x, y: integer;
  R, Rd: TRect;
  ts: TSize;
begin
  if Text <> '' then begin
    R := aRect;
    SetBkMode(DC, TRANSPARENT);
    if Flags or DT_WORDBREAK <> Flags then begin // If no multiline
      GetTextExtentPoint32(DC, Text, Length(Text), ts);
      R.Right := R.Left + ts.cx;
      R.Bottom := R.Top + ts.cy;
      if Flags or DT_CENTER = Flags then begin
        y := (HeightOf(R) - HeightOf(aRect)) div 2;
        x := (WidthOf(R) - WidthOf(aRect)) div 2;
        InflateRect(aRect, x, y);
      end
      else
        if Flags or DT_RIGHT = Flags then begin
          y := (HeightOf(R) - HeightOf(aRect)) div 2;
          dec(aRect.Top, y);
          inc(aRect.Bottom, y);
          inc(aRect.Left, WidthOf(aRect) - WidthOf(R));
        end
        else
          if Flags or DT_LEFT = Flags then begin
            y := (HeightOf(R) - HeightOf(aRect)) div 2;
            dec(aRect.Top, y);
            inc(aRect.Bottom, y);
            inc(aRect.Right, WidthOf(R) - WidthOf(aRect));
          end;

      R := aRect;
      InflateRect(aRect, 1, 1);
    end;
    if Enabled then
      DrawText(DC, Text, Length(Text), R, Flags)
    else begin
      Rd := Rect(R.Left + 1, R.Top + 1, R.Right + 1, R.Bottom + 1);
      DrawText(DC, Text, Length(Text), Rd, Flags);
      DrawText(DC, Text, Length(Text), R, Flags);
    end;
  end;
end;


function acDrawText(hDC: HDC; const Text: ACString; var lpRect: TRect; uFormat: Cardinal): Integer;
begin
{$IFDEF TNTUNICODE}
  Result := Tnt_DrawTextW(hDC, PACChar(Text), Length(Text), lpRect, uFormat);
{$else}
  Result := DrawText(hDC, PACChar(Text), Length(Text), lpRect, uFormat);
{$ENDIF}
end;


function acTextWidth(const Canvas: TCanvas; const Text: ACString): Integer;
begin
{$IFDEF TNTUNICODE}
  Result := WideCanvasTextExtent(Canvas, Text).cx;
{$ELSE}
  Result := Canvas.TextExtent(Text).cx;
{$ENDIF}
end;


function acTextHeight(const Canvas: TCanvas; const Text: ACString): Integer;
begin
{$IFDEF TNTUNICODE}
  Result := WideCanvasTextExtent(Canvas, Text).cy;
{$ELSE}
  Result := Canvas.TextExtent(Text).cy;
{$ENDIF}
end;


function acTextExtent(const Canvas: TCanvas; const Text: ACString): TSize;
begin
{$IFDEF TNTUNICODE}
  Result := WideCanvasTextExtent(Canvas, Text);
{$ELSE}
  Result := Canvas.TextExtent(Text);
{$ENDIF}
end;


procedure acTextRect(const Canvas: TCanvas; const Rect: TRect; X, Y: Integer; const Text: ACString);
begin
{$IFDEF TNTUNICODE}
  WideCanvasTextRect(Canvas, Rect, X, Y, Text);
{$ELSE}
  Canvas.TextRect(Rect, X, Y, Text);
{$ENDIF}
end;


function acGetTextExtent(const DC: HDC; const Str: acString; var Size: TSize): BOOL;
begin
{$IFDEF TNTUNICODE}
  Result := GetTextExtentPoint32W(DC, PWideChar(Str), Length(Str), Size);
{$ELSE}
  Result := GetTextExtentPoint32(DC, PChar(Str), Length(Str), Size);
{$ENDIF}
end;


procedure acDrawGlowForText(const DstBmp: TBitmap; Text: PacChar; aRect: TRect; Flags: Cardinal; Side: Cardinal; BlurSize: integer; Color: TColor; var MaskBmp: TBitmap);
const
  Offs = 4;
  lOffs = 1;
var
  bMask: byte;
  gColor: TsColor;
  D0, D: PRGBAArray;
  M0, M: PByteArray;
  RR, lRect, tmpRect: TRect;
  X, Y, DeltaD, DeltaM: integer;
begin
  OffsetRect(aRect, 1, 1);
  RR := aRect;
  gColor.C := Color;
  InflateRect(RR, BlurSize + Offs, BlurSize + Offs);
  if (MaskBmp = nil) or (MaskBmp.Width <> WidthOf(RR)) or (MaskBmp.Height <> HeightOf(RR)) then begin
    if MaskBmp = nil then
      MaskBmp := TBitmap.Create;

    MaskBmp.PixelFormat := pf8bit;
    MaskBmp.Width := WidthOf(RR, True);
    MaskBmp.Height := HeightOf(RR, True);
    MaskBmp.Canvas.Brush.Color := clWhite;
    MaskBmp.Canvas.FillRect(MkRect(MaskBmp));

    MaskBmp.Canvas.Font.Assign(DstBmp.Canvas.Font);
    MaskBmp.Canvas.Font.Color := 0;
    MaskBmp.Canvas.Brush.Style := bsClear;

    lRect := Rect(BlurSize + Offs, BlurSize + Offs, BlurSize + Offs + WidthOf(aRect), BlurSize + Offs + HeightOf(aRect));
    if Side and BF_LEFT = BF_LEFT then begin
      tmpRect := Rect(lRect.Left - lOffs, lRect.Top, lRect.Right - lOffs, lRect.Bottom);
      acDrawText(MaskBmp.Canvas.Handle, Text, tmpRect, Flags);
    end;
    if Side and BF_TOP = BF_TOP then begin
      tmpRect := Rect(lRect.Left, lRect.Top - lOffs, lRect.Right, lRect.Bottom - lOffs);
      acDrawText(MaskBmp.Canvas.Handle, Text, tmpRect, Flags);
    end;
    if Side and BF_RIGHT = BF_RIGHT then begin
      tmpRect := Rect(lRect.Left + lOffs, lRect.Top, lRect.Right + lOffs, lRect.Bottom);
      acDrawText(MaskBmp.Canvas.Handle, Text, tmpRect, Flags);
    end;
    if Side and BF_BOTTOM = BF_BOTTOM then begin
      tmpRect := Rect(lRect.Left, lRect.Top + lOffs, lRect.Right, lRect.Bottom + lOffs);
      acDrawText(MaskBmp.Canvas.Handle, Text, tmpRect, Flags);
    end;
    tmpRect := lRect;
    acDrawText(MaskBmp.Canvas.Handle, Text, tmpRect, Flags);
    Blur8(MaskBmp, BlurSize);
  end;
  if MaskBmp <> nil then
    if InitLine(MaskBmp, Pointer(M0), DeltaM) and InitLine(DstBmp, Pointer(D0), DeltaD) then
      for Y := 0 to MaskBmp.Height - 1 do begin
        if (aRect.Top + Y - BlurSize - Offs < 0) or (aRect.Top + Y - BlurSize - Offs >= DstBmp.Height) then
          Continue;

        D := Pointer(LongInt(D0) + DeltaD * (aRect.Top + Y - BlurSize - Offs));
        M := Pointer(LongInt(M0) + DeltaM * Y);
        for X := 0 to MaskBmp.Width - 1 do
          if (M[X] <> MaxByte) then begin
            if (aRect.Left + X - BlurSize - Offs < 0) or (aRect.Left + X - BlurSize - Offs >= DstBmp.Width) then
              Continue;

            bMask := M[X];
            with D[aRect.Left + X - BlurSize - Offs] do begin
              A := A + (MaxByte - A) * (MaxByte - bMask) shr 8;

              R := (gColor.R * (MaxByte - bMask) + R * bMask) shr 8;
              G := (gColor.G * (MaxByte - bMask) + G * bMask) shr 8;
              B := (gColor.B * (MaxByte - bMask) + B * bMask) shr 8;
            end;
          end;
      end;
end;


procedure MakeGaussianKernel(var K: TKernel; radius: double; MaxData, DataGranularity: double);
var
  j: integer;
  temp, delta: double;
  KernelSize: TKernelSize;
begin
  for j := Low(K.Weights) to High(K.Weights) do begin
    temp := j / radius;
    K.Weights[j] := Round(exp(-temp * temp / 2));
  end;

  temp := 0;
  for j := Low(K.Weights) to High(K.Weights) do
    temp := temp + K.Weights[j];

  for j := Low(K.Weights) to High(K.Weights) do
    K.Weights[j] := K.Weights[j] / temp;

  KernelSize := MaxKernelSize;
  delta := DataGranularity / (2 * MaxData);
  temp := 0;
  while (temp < delta) and (KernelSize > 1) do begin
    temp := temp + 2 * K.Weights[KernelSize];
    dec(KernelSize);
  end;
  K.Size := KernelSize;
  temp := 0;

  for j := -K.Size to K.Size do
    temp := temp + K.Weights[j];

  for j := -K.Size to K.Size do
    K.Weights[j] := K.Weights[j] / temp;
end;


function TrimInt(Lower, Upper, theInteger: integer): integer;
begin
  if (theInteger <= Upper) and (theInteger >= Lower) then
    Result := theInteger
  else
    if theInteger > Upper then
      Result := Upper
    else
      Result := Lower;
end;


procedure BlurRow8(var theRow: array of byte; const K: TKernel; P: PByteArray);
var
  j, n, h: integer;
  d, w: double;
begin
  h := High(theRow);
  if h >= 0 then begin
    for j := 0 to h do begin
      d := 0;
      for n := -K.Size to K.Size do begin
        w := K.Weights[n];
        d := d + w * theRow[TrimInt(0, h, j - n)];
      end;
      if d > MaxByte then
        P[j] := MaxByte
      else
        if d < 0 then
          P[j] := 0
        else
          P[j] := trunc(d);
    end;
    Move(P[0], theRow[0], (h + 1));
  end;
end;


procedure Blur8(theBitmap: TBitmap; radius: double);
var
  K: TKernel;
  P: PByteArray;
  ACol: PByteArray;
  R0, theRows: PByteArrays;
  DeltaR, Row, Col: integer;
begin
  if {True or }(theBitmap.HandleType = bmDIB) and (theBitmap.PixelFormat = pf8Bit) then begin
    MakeGaussianKernel(K, radius, MaxByte, 1);
    GetMem(theRows, theBitmap.Height * SizeOf(PByteArrays));
    GetMem(ACol, theBitmap.Height);
    if InitLine(theBitmap, Pointer(R0), DeltaR) then begin
      for Row := 0 to theBitmap.Height - 1 do
        theRows[Row] := Pointer(LongInt(R0) + DeltaR * Row);

      P := AllocMem(theBitmap.Width);
      for Row := 0 to theBitmap.Height - 1 do
        BlurRow8(Slice(theRows[Row]^, theBitmap.Width), K, P);

      ReAllocMem(P, theBitmap.Height);
      for Col := 0 to theBitmap.Width - 1 do begin
        for Row := 0 to theBitmap.Height - 1 do
          ACol[Row] := theRows[Row][Col];

        BlurRow8(Slice(ACol^, theBitmap.Height), K, P);
        for Row := 0 to theBitmap.Height - 1 do
          theRows[Row][Col] := ACol[Row];
      end;
    end;
    FreeMem(theRows);
    FreeMem(ACol);
    ReAllocMem(P, 0);
  end;
end;


type
  PPRows = ^TPRows;
  TPRows = array[0..1000000] of PRGBAArray;


procedure BlurRow(var theRow: array of TsColor_; P: PRGBAArray);
var
  tw: byte;
  C, sC: TsColor_;
  j, n, h, tw3: integer;
  tr, tg, tb, ta, sr, sg, sb, sa: integer;
begin
  h := High(theRow);
  for j := 0 to h do begin
    tb := 0;
    tg := 0;
    tr := 0;
    ta := 0;
    sb := 0;
    sg := 0;
    sr := 0;
    sa := 0;
    tw := 0;
    sC.I := 0;
    for n := -1 to 1 do
      if (j - n >= 0) and (j - n < h) then begin
        C := theRow[j - n];
        if C.a > 0 then
          with C do begin
            tb := tb + b div 3;
            tg := tg + g div 3;
            tr := tr + r div 3;
            ta := ta + a div 3 + 1;
            sC.I := I;
          end
        else
          if sC.A > 0 then
            with sC do begin
              sb := sb + b div 3;
              sg := sg + g div 3;
              sr := sr + r div 3;
              sa := sa + a div 3;
            end
          else
            inc(tw)
      end
      else
        with sC do
          if A <> 0 then begin
            sb := sb + b div 3;
            sg := sg + g div 3;
            sr := sr + r div 3;
            sa := sa + a div 3;
          end
          else
            inc(tw);

    if (tw <> 0) and (sC.A <> 0) then
      with sC do begin
        tw3 := 3 * tw;
        sb := sb + b div tw3;
        sg := sg + g div tw3;
        sr := sr + r div tw3;
        sa := sa + a div tw3;
      end;

    if sa <> 0 then begin
      inc(tb, sb);
      inc(tg, sg);
      inc(tr, sr);
    end;
    with P[j] do
      if ta > 0 then begin
        if tb > MaxByte then b := MaxByte else b := tb;
        if tg > MaxByte then g := MaxByte else g := tg;
        if tr > MaxByte then r := MaxByte else r := tr;
        if ta > MaxByte then a := MaxByte else a := ta;
      end
      else
        I := 0;
  end;
  Move(P[0], theRow[0], (h + 1) * 4{Sizeof(TsColor_)});
end;


procedure QBlur(Bmp: TBitmap);
var
  Row, Col, Delta: integer;
  ACol, P: PRGBAArray;
  Rows: PPRows;
begin
  GetMem(Rows, Bmp.Height * SizeOf(PRGBAArray));
  GetMem(ACol, Bmp.Height * SizeOf(TsColor_));
  Rows[0] := Bmp.Scanline[0];
  if Bmp.Height > 1 then begin
    Rows[1] := Bmp.Scanline[1];
    if Bmp.Height > 2 then begin
      Delta := integer(Rows[1]) - integer(Rows[0]);
      for Row := 2 to Bmp.Height - 1 do
        Rows[Row] := Pointer(integer(Rows[0]) + Row * Delta);
    end;
  end;
  P := AllocMem(Bmp.Width * SizeOf(TsColor_));
  for Row := 0 to Bmp.Height - 1 do
    BlurRow(Slice(Rows[Row]^, Bmp.Width), P);

  ReAllocMem(P, Bmp.Height * SizeOf(TsColor_));
  for Col := 0 to Bmp.Width - 1 do begin
    for Row := 0 to Bmp.Height - 1 do
      ACol[Row] := Rows[Row][Col];

    BlurRow(Slice(ACol^, Bmp.Height), P);
    for Row := 0 to Bmp.Height - 1 do
      Rows[Row][Col] := ACol[Row];
  end;
  FreeMem(Rows);
  FreeMem(ACol);
  ReAllocMem(P, 0);
end;


procedure acWriteTextEx(const Canvas: TCanvas; const Text: PacChar; const Enabled: boolean; var aRect: TRect; const Flags: Cardinal; const SkinData: TsCommonData; const Hot: boolean; const SkinManager: TObject = nil);
begin
{$IFDEF TNTUNICODE}
  WriteTextExW(Canvas, Text, Enabled, aRect, Flags, SkinData, Hot);
{$ELSE}
  WriteTextEx(Canvas, Text, Enabled, aRect, Flags, SkinData, Hot);
{$ENDIF}
end;


procedure acWriteTextEx(const Canvas: TCanvas; const Text: PacChar; const Enabled: boolean; var aRect: TRect; const Flags: Cardinal; const SkinIndex: integer; const Hot: boolean; const SkinManager: TObject = nil);
begin
{$IFDEF TNTUNICODE}
  WriteTextExW(Canvas, Text, Enabled, aRect, Flags, SkinIndex, Hot, SkinManager);
{$ELSE}
  WriteTextEx(Canvas, Text, Enabled, aRect, Flags, SkinIndex, Hot, SkinManager);
{$ENDIF}
end;


procedure acWriteText(const Canvas: TCanvas; const Text: PacChar; const Enabled: boolean; var aRect: TRect; const Flags: Cardinal);
begin
{$IFDEF TNTUNICODE}
  DrawTextW(Canvas.Handle, Text, Length(Text), aRect, Flags);
{$ELSE}
  DrawText(Canvas.Handle, Text, Length(Text), aRect, Flags);
{$ENDIF}
end;


{$IFNDEF ACHINTS}
procedure WriteTextEx(const Canvas: TCanvas; Text: PChar; Enabled: boolean; var aRect: TRect; Flags: Cardinal; SkinIndex: integer; Hot: boolean; SkinManager: TObject = nil); overload;
var
  C: TColor;
  R, Rd: TRect;
  nLength, State: integer;
begin
  if (Text <> '') then begin
    nLength := StrLen(Text);
    if SkinManager = nil then
      SkinManager := DefaultManager;

    SetBkMode(Canvas.Handle, TRANSPARENT);
    if not Assigned(SkinManager) or not TsSkinManager(SkinManager).IsValidSkinIndex(SkinIndex) then
      DrawText(Canvas.Handle, Text, nLength, aRect, Flags)
    else
      with TsSkinManager(SkinManager) do begin
        R := aRect;
        if Enabled then begin
          State := integer(Hot);
          if IsValidSkinIndex(SkinIndex) then begin
            // Left
            C := TsSkinManager(SkinManager).gd[SkinIndex].Props[State].FontColor.Left;
            if C <> -1 then begin
              Rd := Rect(R.Left - 1, R.Top, R.Right - 1, R.Bottom);
              SetTextColor(Canvas.Handle, Cardinal(C));
              DrawText(Canvas.Handle, Text, nLength, Rd, Flags);
            end;
            // Top
            C := gd[SkinIndex].Props[State].FontColor.Top;
            if C <> -1 then begin
              Rd := Rect(R.Left, R.Top - 1, R.Right, R.Bottom - 1);
              SetTextColor(Canvas.Handle, Cardinal(C));
              DrawText(Canvas.Handle, Text, nLength, Rd, Flags);
            end;
            // Right
            C := gd[SkinIndex].Props[State].FontColor.Right;
            if C <> -1 then begin
              Rd := Rect(R.Left + 1, R.Top, R.Right + 1, R.Bottom);
              SetTextColor(Canvas.Handle, Cardinal(C));
              DrawText(Canvas.Handle, Text, nLength, Rd, Flags);
            end;
            // Bottom
            C := gd[SkinIndex].Props[State].FontColor.Bottom;
            if C <> -1 then begin
              Rd := Rect(R.Left, R.Top + 1, R.Right, R.Bottom + 1);
              SetTextColor(Canvas.Handle, Cardinal(C));
              DrawText(Canvas.Handle, Text, nLength, Rd, Flags);
            end;
            // Center
            C := gd[SkinIndex].Props[State].FontColor.Color;
            SetTextColor(Canvas.Handle, Cardinal(C));
            DrawText(Canvas.Handle, Text, nLength, R, Flags);
          end
          else
            DrawText(Canvas.Handle, Text, -1, R, Flags);
        end
        else begin
          Rd := R;
          Canvas.Font.Color := MixColors(gd[SkinIndex].Props[0].FontColor.Color, gd[SkinIndex].Props[0].Color, DefDisabledBlend);
          DrawText(Canvas.Handle, Text, nLength, Rd, Flags);
        end;
      end;
  end;
end;
{$ENDIF}


function UpdateColor(Color: TColor; SkinData: TsCommonData): TColor;
begin
  with SkinData do begin
    if ColorTone <> clNone then
      Result := ChangeTone(Color, SwapRedBlue(ColorToRGB(ColorTone)))
    else
      Result := Color;

    Result := ColortoRGB(ChangeSaturation(ChangeHUE(SkinData.HUEOffset, Result), Trunc(SkinData.Saturation * 2.55)));
  end;
end;


procedure WriteTextEx(const Canvas: TCanvas; Text: PChar; Enabled: boolean; var aRect: TRect; Flags: Cardinal; SkinData: TsCommonData; Hot: boolean); overload;
var
  C: TColor;
  R, Rd: TRect;
  SavedDC: hdc;
  SM: TsSkinManager;
  FGlowMask: TBitmap;
  State, nLength, SkinIndex, i: integer;
begin
  if Text <> '' then begin
    nLength := StrLen(Text);
    R := aRect;
    SM := SkinData.SkinManager;
    if Hot and (SkinData.SkinIndex >= 0) and (SkinData.SkinIndex = SM.ConstData.Sections[ssWebBtn]) then
      Canvas.Font.Style := Canvas.Font.Style + [fsUnderline];

    Canvas.Brush.Style := bsClear;
    SavedDC := SaveDC(Canvas.Handle);
    try
      if SkinData.Skinned and not SkinData.CustomFont then begin
        State := integer(Hot);
        if (SkinData.FOwnerControl <> nil) and
             SectionInArray(SkinData.SkinManager.ConstData.Sections, SkinData.SkinIndex, ssMenuItem, ssWebBtn) and
               (SkinData.FOwnerControl.Parent <> nil) then
          SkinIndex := GetFontIndex(SkinData.FOwnerControl, SkinData.SkinIndex, SM)
        else
          SkinIndex := SkinData.SkinIndex;


        if SM.IsValidSkinIndex(SkinIndex) then begin
          State := min(State, ac_MaxPropsIndex);
          if SkinData.FCacheBmp <> nil then begin
            i := SM.gd[SkinIndex].Props[State].GlowSize;
            if i <> 0 then begin
              IntersectClipRect(Canvas.Handle, aRect.Left, aRect.Top, aRect.Right, aRect.Bottom);
              FGlowMask := nil;
              c := UpdateColor(SM.gd[SkinIndex].Props[State].GlowColor, SkinData);
              acDrawGlowForText(SkinData.FCacheBmp, PacChar(Text), R, Flags, BF_LEFT or BF_TOP or BF_BOTTOM or BF_RIGHT, i, C, FGlowMask);
              FreeAndNil(FGlowMask);
              RestoreDC(Canvas.Handle, SavedDC);
              SavedDC := SaveDC(Canvas.Handle);
            end;
          end;
          if Enabled then begin
            // Left contour
            if not SkinData.CustomFont then begin
              if SM.gd[SkinIndex].Props[State].FontColor.Left <> -1 then begin
                C := UpdateColor(SM.gd[SkinIndex].Props[State].FontColor.Left, SkinData);
                Rd := OffsRect(R, -1, 0);
                SetTextColor(Canvas.Handle, C);
                DrawText(Canvas.Handle, Text, nLength, Rd, Flags);
              end;
              // Top
              if SM.gd[SkinIndex].Props[State].FontColor.Top <> -1 then begin
                C := UpdateColor(SM.gd[SkinIndex].Props[State].FontColor.Top, SkinData);
                Rd := OffsRect(R, 0, -1);
                SetTextColor(Canvas.Handle, C);
                DrawText(Canvas.Handle, Text, nLength, Rd, Flags);
              end;
              // Right
              if SM.gd[SkinIndex].Props[State].FontColor.Right <> -1 then begin
                C := UpdateColor(SM.gd[SkinIndex].Props[State].FontColor.Right, SkinData);
                Rd := OffsRect(R, 1, 0);
                SetTextColor(Canvas.Handle, C);
                DrawText(Canvas.Handle, Text, nLength, Rd, Flags);
              end;
              // Bottom
              if SM.gd[SkinIndex].Props[State].FontColor.Bottom <> -1 then begin
                C := UpdateColor(SM.gd[SkinIndex].Props[State].FontColor.Bottom, SkinData);
                Rd := OffsRect(R, 0, 1);
                SetTextColor(Canvas.Handle, ColorToRGB(C));
                DrawText(Canvas.Handle, Text, nLength, Rd, Flags);
              end;
              // Center
              if not SkinData.CustomFont then begin
                C := UpdateColor(SM.gd[SkinIndex].Props[State].FontColor.Color, SkinData);
                SetTextColor(Canvas.Handle, C);
              end;
              DrawText(Canvas.Handle, Text, -1, R, Flags or DT_NOCLIP);
            end
            else
              DrawText(Canvas.Handle, Text, nLength, R, Flags or DT_NOCLIP);
          end
          else begin
            Canvas.Font.Color := UpdateColor(SM.gd[SkinIndex].Props[State].FontColor.Color, SkinData);
            DrawText(Canvas.Handle, Text, nLength, R, Flags);
          end
        end
        else
          DrawText(Canvas.Handle, Text, nLength, R, Flags);
      end
      else
        if Enabled then
          DrawText(Canvas.Handle, Text, nLength, R, Flags)
        else begin
          Rd := OffsRect(R, 1);
          Canvas.Font.Color := clBtnHighlight;
          DrawText(Canvas.Handle, Text, nLength, Rd, Flags);
          Canvas.Font.Color := clBtnShadow;
          DrawText(Canvas.Handle, Text, nLength, R, Flags);
        end;
    finally
      RestoreDC(Canvas.Handle, SavedDC);
    end;
  end;
end;


{$IFDEF TNTUNICODE}
procedure WriteTextExW(const Canvas: TCanvas; Text: PWideChar; Enabled: boolean; var aRect: TRect; Flags: Cardinal; SkinData: TsCommonData; Hot: boolean); overload;
var
  C: TColor;
  R, Rd: TRect;
  SavedDC: hdc;
  FGlowMask: TBitmap;
  State, nLength, SkinIndex, i: integer;
begin
  if Text <> '' then begin
    nLength := Length(Text);
    R := aRect;
    if Hot and (SkinData.SkinIndex >= 0) and (SkinData.SkinIndex = SkinData.SkinManager.ConstData.Sections[ssWebBtn]) then
      Canvas.Font.Style := Canvas.Font.Style + [fsUnderline];

    SavedDC := SaveDC(Canvas.Handle);
    try
      IntersectClipRect(Canvas.Handle, aRect.Left, aRect.Top, aRect.Right, aRect.Bottom);
      if SkinData.Skinned then begin
        State := integer(Hot);          
        if (SkinData.FOwnerControl <> nil) and
             SectionInArray(SkinData.SkinManager.ConstData.Sections, SkinData.SkinIndex, ssMenuItem, ssWebBtn) and
                  (SkinData.FOwnerControl.Parent <> nil) then
//          if (SkinData.SkinManager.gd[SkinData.SkinIndex].Props[State].Transparency > 0) then
          SkinIndex := GetFontIndex(SkinData.FOwnerControl, SkinData.SkinIndex, SkinData.SkinManager)
//          else
//            SkinIndex := SkinData.SkinIndex
        else
          SkinIndex := SkinData.SkinIndex;

        Canvas.Brush.Style := bsClear;
        if SkinData.SkinManager.IsValidSkinIndex(SkinIndex) then begin
          if SkinData.FCacheBmp <> nil then begin
            i := SkinData.SkinManager.gd[SkinIndex].Props[State].GlowSize;
            if i <> 0 then begin
              FGlowMask := nil;
              C := UpdateColor(SkinData.SkinManager.gd[SkinIndex].Props[State].GlowColor, SkinData);
              acDrawGlowForText(SkinData.FCacheBmp, PacChar(Text), R, Flags, BF_LEFT or BF_TOP or BF_BOTTOM or BF_RIGHT, i, C, FGlowMask);
              FreeAndNil(FGlowMask);
            end;
          end;
          if Enabled then begin
            // Left contour
            if not SkinData.CustomFont then begin
              if SkinData.SkinManager.gd[SkinIndex].Props[State].FontColor.Left <> -1 then begin
                C := UpdateColor(SkinData.SkinManager.gd[SkinIndex].Props[State].FontColor.Left, SkinData);
                Rd := Rect(R.Left - 1, R.Top, R.Right - 1, R.Bottom);
                SetTextColor(Canvas.Handle, C);
                Tnt_DrawTextW(Canvas.Handle, Text, nLength, Rd, Flags);
              end;
              // Top
              if SkinData.SkinManager.gd[SkinIndex].Props[State].FontColor.Top <> -1 then begin
                C := UpdateColor(SkinData.SkinManager.gd[SkinIndex].Props[State].FontColor.Top, SkinData);
                Rd := Rect(R.Left, R.Top - 1, R.Right, R.Bottom - 1);
                SetTextColor(Canvas.Handle, C);
                Tnt_DrawTextW(Canvas.Handle, Text, nLength, Rd, Flags);
              end;
              // Right
              if SkinData.SkinManager.gd[SkinIndex].Props[State].FontColor.Right <> -1 then begin
                C := UpdateColor(SkinData.SkinManager.gd[SkinIndex].Props[State].FontColor.Right, SkinData);
                Rd := Rect(R.Left + 1, R.Top, R.Right + 1, R.Bottom);
                SetTextColor(Canvas.Handle, C);
                Tnt_DrawTextW(Canvas.Handle, Text, nLength, Rd, Flags);
              end;
              // Bottom
              if SkinData.SkinManager.gd[SkinIndex].Props[State].FontColor.Bottom <> -1 then begin
                C := UpdateColor(SkinData.SkinManager.gd[SkinIndex].Props[State].FontColor.Bottom, SkinData);
                Rd := Rect(R.Left, R.Top + 1, R.Right, R.Bottom + 1);
                SetTextColor(Canvas.Handle, C);
                Tnt_DrawTextW(Canvas.Handle, Text, nLength, Rd, Flags);
              end;
              // Center
              if not SkinData.CustomFont then begin
                C := UpdateColor(SkinData.SkinManager.gd[SkinIndex].Props[State].FontColor.Color, SkinData);
                SetTextColor(Canvas.Handle, C);
              end;
              Tnt_DrawTextW(Canvas.Handle, Text, nLength, R, Flags or DT_NOCLIP);
            end
            else
              Tnt_DrawTextW(Canvas.Handle, Text, nLength, R, Flags or DT_NOCLIP);
          end
          else begin
            Canvas.Font.Color := UpdateColor(MixColors(SkinData.SkinManager.gd[SkinIndex].Props[0].FontColor.Color, SkinData.SkinManager.GetGlobalColor, DefDisabledBlend), SkinData);
            Tnt_DrawTextW(Canvas.Handle, Text, nLength, R, Flags);
          end
        end
        else
          Tnt_DrawTextW(Canvas.Handle, Text, nLength, R, Flags);
      end
      else
        if Enabled then
          Tnt_DrawTextW(Canvas.Handle, Text, nLength, R, Flags)
        else begin
          OffsetRect(R, 1, 1);
          Canvas.Font.Color := clBtnHighlight;
          Tnt_DrawTextW(Canvas.Handle, Text, nLength, R, Flags);
          OffsetRect(R, -1, -1);
          Canvas.Font.Color := clBtnShadow;
          Tnt_DrawTextW(Canvas.Handle, Text, nLength, R, Flags);
        end;
    finally
      RestoreDC(Canvas.Handle, SavedDC);
    end;
  end;
end;


procedure WriteUnicode(const Canvas: TCanvas; const Text: WideString; Enabled: boolean; var aRect: TRect; Flags: Cardinal; SkinData: TsCommonData; Hot: boolean); overload;
var
  ts: TSize;
  SavedDC: hdc;
  R, Rd: TRect;
  nLength, State, x, y: integer;
begin
  nLength := Length(Text);
  R := aRect;
  if Hot and (SkinData.SkinIndex >= 0) and (SkinData.SkinIndex = SkinData.SkinManager.ConstData.Sections[ssWebBtn]) then
    Canvas.Font.Style := Canvas.Font.Style + [fsUnderline];

  State := integer(Hot);
  SavedDC := SaveDC(Canvas.Handle);
  try
    IntersectClipRect(Canvas.Handle, aRect.Left, aRect.Top, aRect.Right, aRect.Bottom);
    if Flags or DT_WORDBREAK <> Flags then begin // If no multiline
      ts := WideCanvasTextExtent(Canvas, Text);

      R.Right := R.Left + ts.cx;
      R.Bottom := R.Top + ts.cy;

      if Flags or DT_CENTER = Flags then begin
        y := (HeightOf(R) - HeightOf(aRect)) div 2;
        x := (WidthOf(R) - WidthOf(aRect)) div 2;
        InflateRect(aRect, x, y);
      end
      else
        if Flags or DT_RIGHT = Flags then begin
          y := (HeightOf(R) - HeightOf(aRect)) div 2;
          dec(aRect.Top, y);
          inc(aRect.Bottom, y);
          inc(aRect.Left, WidthOf(aRect) - WidthOf(R));
        end
        else
          if Flags or DT_LEFT = Flags then begin
            y := (HeightOf(R) - HeightOf(aRect)) div 2;
            dec(aRect.Top, y);
            inc(aRect.Bottom, y);
            inc(aRect.Right, WidthOf(R) - WidthOf(aRect));
          end;

      R := aRect;
      InflateRect(aRect, 1, 1);
    end;
    Canvas.Brush.Style := bsClear;
    Flags := ETO_CLIPPED or Flags;
    if Text <> '' then
      if Enabled then begin
        if Assigned(SkinData.SkinManager) and SkinData.SkinManager.IsValidSkinIndex(SkinData.SkinIndex) then
          // Left contur
          if not SkinData.CustomFont then begin
            if SkinData.SkinManager.gd[SkinData.SkinIndex].Props[State].FontColor.Left <> -1 then begin
              Canvas.Font.Color := UpdateColor(SkinData.SkinManager.gd[SkinData.SkinIndex].Props[State].FontColor.Left, SkinData);
              Rd := Rect(R.Left - 1, R.Top, R.Right - 1, R.Bottom);
              Windows.ExtTextOutW(Canvas.Handle, Rd.Left, Rd.Top, Flags, @Rd, PWideChar(Text), nLength, nil)
            end;
            // Top
            Canvas.Font.Color := SkinData.SkinManager.gd[SkinData.SkinIndex].Props[State].FontColor.Top;
            if Canvas.Font.Color <> -1 then begin
              Rd := Rect(R.Left, R.Top - 1, R.Right, R.Bottom - 1);
              Windows.ExtTextOutW(Canvas.Handle, Rd.Left, Rd.Top, Flags, @Rd, PWideChar(Text), nLength, nil)
            end;
            // Right
            Canvas.Font.Color := SkinData.SkinManager.gd[SkinData.SkinIndex].Props[State].FontColor.Right;
            if Canvas.Font.Color <> -1 then begin
              Rd := Rect(R.Left + 1, R.Top, R.Right + 1, R.Bottom);
              Windows.ExtTextOutW(Canvas.Handle, Rd.Left, Rd.Top, Flags, @Rd, PWideChar(Text), nLength, nil)
            end;
            // Bottom
            Canvas.Font.Color := SkinData.SkinManager.gd[SkinData.SkinIndex].Props[State].FontColor.Bottom;
            if Canvas.Font.Color <> -1 then begin
              Rd := Rect(R.Left, R.Top + 1, R.Right, R.Bottom + 1);
              Windows.ExtTextOutW(Canvas.Handle, Rd.Left, Rd.Top, Flags, @Rd, PWideChar(Text), nLength, nil)
            end;
          end;
          // Center
          if not SkinData.CustomFont then
            Canvas.Font.Color := SkinData.SkinManager.gd[SkinData.SkinIndex].Props[State].FontColor.Color;

          Windows.ExtTextOutW(Canvas.Handle, R.Left, R.Top, Flags, @R, PWideChar(Text), nLength, nil)
        end
        else
          Windows.ExtTextOutW(Canvas.Handle, R.Left, R.Top, Flags, @R, PWideChar(Text), nLength, nil)
      else begin
        Canvas.Font.Color := MixColors(SkinData.SkinManager.gd[SkinData.SkinIndex].Props[0].FontColor.Color, SkinData.SkinManager.gd[SkinData.SkinIndex].Props[0].Color, DefDisabledBlend);
        Windows.ExtTextOutW(Canvas.Handle, R.Left, R.Top, Flags, @R, PWideChar(Text), nLength, nil)
      end;
  finally
    RestoreDC(Canvas.Handle, SavedDC);
  end;
end;


procedure TextRectW(const Canvas: TCanvas; var Rect: TRect; X, Y: Integer; const Text: WideString);
begin
  WideCanvasTextRect(Canvas, Rect, X, Y, Text);
end;


procedure WriteTextExW(const Canvas: TCanvas; Text: PWideChar; Enabled: boolean; var aRect: TRect; Flags: Cardinal; SkinIndex: integer; Hot: boolean; SkinManager: TObject = nil);
var
  ts: TSize;
  R, Rd: TRect;
  x, y, nLength: Integer;
begin
  nLength := {$IFNDEF D2006}WStrLen(Text){$ELSE}Length(Text){$ENDIF};
  if SkinManager = nil then
    SkinManager := DefaultManager;

  if Assigned(DefaultManager) and TsSkinManager(SkinManager).IsValidSkinIndex(SkinIndex) then
    with TsSkinManager(SkinManager) do begin
      R := aRect;
      if (Flags or DT_WORDBREAK <> Flags) and (Flags or DT_END_ELLIPSIS <> Flags) then begin // If not multiline
        GetTextExtentPoint32W(Canvas.Handle, Text, nLength, ts);
        R.Right := R.Left + ts.cx;
        R.Bottom := R.Top + ts.cy;

        if Flags or DT_CENTER = Flags then begin
          y := (HeightOf(R) - HeightOf(aRect)) div 2;
          x := (WidthOf(R) - WidthOf(aRect)) div 2;
          InflateRect(aRect, x, y);
        end
        else
          if Flags or DT_RIGHT = Flags then begin
            y := (HeightOf(R) - HeightOf(aRect)) div 2;
            dec(aRect.Top, y);
            inc(aRect.Bottom, y);
            inc(aRect.Left, WidthOf(aRect) - WidthOf(R));
          end
          else
            if Flags or DT_LEFT = Flags then begin
              y := (HeightOf(R) - HeightOf(aRect)) div 2;
              dec(aRect.Top, y);
              inc(aRect.Bottom, y);
              inc(aRect.Right, WidthOf(R) - WidthOf(aRect));
            end;

        R := aRect;
        InflateRect(aRect, 1, 1);
      end;
      Canvas.Brush.Style := bsClear;
      if Text <> '' then
        if Enabled then begin
          if IsValidSkinIndex(SkinIndex) then begin
            // Left contur
            Canvas.Font.Color := gd[SkinIndex].Props[integer(Hot)].FontColor.Left;
            if Canvas.Font.Color <> -1 then begin
              Rd := Rect(R.Left - 1, R.Top, R.Right - 1, R.Bottom);
              Tnt_DrawTextW(Canvas.Handle, Text, nLength, Rd, Flags);
            end;
            // Top
            Canvas.Font.Color := gd[SkinIndex].Props[integer(Hot)].FontColor.Top;
            if Canvas.Font.Color <> -1 then begin
              Rd := Rect(R.Left, R.Top - 1, R.Right, R.Bottom - 1);
              Tnt_DrawTextW(Canvas.Handle, Text, nLength, Rd, Flags);
            end;
            // Right
            Canvas.Font.Color := gd[SkinIndex].Props[integer(Hot)].FontColor.Right;
            if Canvas.Font.Color <> -1 then begin
              Rd := Rect(R.Left + 1, R.Top, R.Right + 1, R.Bottom);
              Tnt_DrawTextW(Canvas.Handle, Text, nLength, Rd, Flags);
            end;
            // Bottom
            Canvas.Font.Color := gd[SkinIndex].Props[integer(Hot)].FontColor.Bottom;
            if Canvas.Font.Color <> -1 then begin
              Rd := Rect(R.Left, R.Top + 1, R.Right, R.Bottom + 1);
              Tnt_DrawTextW(Canvas.Handle, Text, nLength, Rd, Flags);
            end;
            // Center
            Canvas.Font.Color := gd[SkinIndex].Props[integer(Hot)].FontColor.Color;
            Tnt_DrawTextW(Canvas.Handle, Text, nLength, R, Flags);
          end
          else
            Tnt_DrawTextW(Canvas.Handle, Text, nLength, R, Flags);
        end
        else begin
          Canvas.Font.Color := MixColors(gd[SkinIndex].Props[integer(Hot)].FontColor.Color, gd[SkinIndex].Props[Integer(Hot)].Color, DefDisabledBlend);
          Tnt_DrawTextW(Canvas.Handle, Text, nLength, R, Flags);
        end;
    end;
end;
{$ENDIF}


procedure FadeBmp(FadedBmp: TBitMap; aRect: TRect; Transparency: integer; const Color: TsColor; Blur, Radius: integer);
var
  rr: TRect;
  delta: real;
  Ct: TsColor;
  RValue, ii: integer;
  Bmp, TempBmp: Graphics.TBitmap;
begin
  Bmp := CreateBmp32(aRect.Right - aRect.Left, aRect.Bottom - aRect.Top);
  TempBmp := CreateBmp32(Bmp.Width, Bmp.Height);
  Blur   := min(min(TempBmp.Width div 2, TempBmp.Height div 2), Blur);
  Radius := min(min(TempBmp.Width div 2, TempBmp.Height div 2), Radius);
  RValue := MaxByte * Transparency div 100;
  // Copy faded area in Ftb
  bitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, FadedBmp.Canvas.Handle, aRect.Left, aRect.Top, SrcCopy);

  TempBmp.Canvas.Pen.Style   := psClear;
  TempBmp.Canvas.Brush.Style := bsSolid;
  TempBmp.Canvas.Brush.Color := clWhite;

  delta := (MaxByte - RValue) / (Blur + 1);
  // Prepare template
  Ct.C := clWhite;

  with Ct do
    for ii := 0 to Blur do begin
      TempBmp.Canvas.Brush.Color := C;
      TempBmp.Canvas.RoundRect(ii, ii, TempBmp.Width - ii, TempBmp.Height - ii, Radius, Radius);
      R := RValue + Trunc(delta * (Blur - ii));
      G := R;
      B := R;
    end;
    
  rr := Rect(Blur, Blur, TempBmp.Width - Blur, TempBmp.Height - Blur);

  TempBmp.Canvas.Brush.Color := Ct.C;
  TempBmp.Canvas.Pen.Style := psClear;
  TempBmp.Canvas.Brush.Style := bsSolid;
  TempBmp.Canvas.RoundRect(rr.Left, rr.Top, rr.Right, rr.Bottom, Blur, Blur);

  BlendBmpByMask(Bmp, TempBmp, Color);
  // Copy back
  BitBlt(FadedBmp.Canvas.Handle, aRect.Left, aRect.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
  FreeAndNil(Bmp);
  FreeAndNil(TempBmp);
end;


procedure BlendTransRectangle(Dst: TBitmap; X, Y: integer; Src: TBitmap; aRect: TRect; Blend: real; TransColor: TColor = clFuchsia);
var
  oldleft, oldtop, dx, dy, h, w, width, height, curX, nextX: integer;
  S0, D0, S, D: PRGBAArray;
  DeltaS, DeltaD: integer;
begin
{$IFNDEF WIN64}
  S := nil;
  D := nil;
{$ENDIF}
  if aRect.Top < 0 then begin
    oldtop := aRect.Top;
    aRect.Top := 0
  end
  else
    oldtop := 0;

  if aRect.Left < 0 then begin
    oldleft := aRect.Left;
    aRect.Left := 0
  end
  else
    oldleft := 0;

  if aRect.Bottom > Src.Height - 1 then
    aRect.Bottom := Src.Height - 1;

  if aRect.Right > Src.Width - 1 then
    aRect.Right := Src.Width - 1;

  h := HeightOf(aRect);
  w := WidthOf(aRect);
  width := Dst.Width - 1;
  height := Dst.Height - 1;

  if InitLine(Src, Pointer(S0), DeltaS) and InitLine(Dst, Pointer(D0), DeltaD) then
    for dy := 0 to h do begin
      if (dy + Y > height) then
        break
      else
        if dy + Y < 0 then
          Continue;

      if dy + aRect.Top >= 0 then
        S := Pointer(LongInt(S0) + DeltaS * (dy + aRect.Top))
      else
        Continue;

      if dy + Y - oldtop < 0 then
        Continue
      else
        if dy + Y - oldtop > Dst.Height - 1 then
          Break
        else
          D := Pointer(LongInt(D0) + DeltaD * (dy + Y - oldtop));

      nextX := X - oldleft;
      CurX := aRect.Left;
      for dx := 0 to w do begin
        if (nextX > Width) then
          Break;

        if (nextX < 0) then
          Continue;

        if CurX > Src.Width - 1 then
          Continue;

        with S[CurX] do
          if C <> TransColor then begin
            D[nextX].R := Trunc(R - Blend * (R - D[nextX].R));
            D[nextX].G := Trunc(G - Blend * (G - D[nextX].G));
            D[nextX].B := Trunc(B - Blend * (B - D[nextX].B));
          end;

        inc(nextX);
        inc(CurX);
      end;
    end;
end;


procedure BlendTransBitmap(Bmp: TBitmap; Blend: real; const Color: TsColor);
var
  S: PRGBAArray;
  w, h, dx, dy: integer;
begin
  w := Bmp.Width - 1;
  h := Bmp.Height - 1;
  for dy := 0 to h do begin
    S := Bmp.ScanLine[dy];
    for dx := 0 to w do
      with S[dX] do
        if (C <> clFuchsia) then begin
          R := Trunc((R - Color.R) * Blend + Color.R);
          G := Trunc((G - Color.G) * Blend + Color.G);
          B := Trunc((B - Color.B) * Blend + Color.B);
        end;
  end;
end;


procedure BlendBmpByMask(SrcBmp, MskBmp: Graphics.TBitMap; const BlendColor: TsColor);
var
  D0, S0, D, S: PRGBAArray;
  DeltaD, DeltaS: integer;
  minW, minH: integer;
  rr, gg, bb: integer;
  X, Y: Integer;
begin
  if (SrcBmp.Width = MskBmp.Width) and (SrcBmp.Height = MskBmp.Height) then begin
    minH := SrcBmp.Height - 1;
    minW := SrcBmp.Width - 1;
    rr := BlendColor.R shl 8;
    gg := BlendColor.G shl 8;
    bb := BlendColor.B shl 8;

    if InitLine(MskBmp, Pointer(S0), DeltaS) and InitLine(SrcBmp, Pointer(D0), DeltaD) then
      for Y := 0 to minH do begin
        S := Pointer(LongInt(S0) + DeltaS * Y);
        D := Pointer(LongInt(D0) + DeltaD * Y);
        for X := 0 to minW do
          with D[X] do
            if S[X].I <> -1 then begin
              R := ((R - BlendColor.R) * S[X].R + rr) shr 8;
              G := ((G - BlendColor.G) * S[X].G + gg) shr 8;
              B := ((B - BlendColor.B) * S[X].B + bb) shr 8;
            end
      end;
  end;
end;


procedure BlendBmpRectByMask(SrcBmp, MskBmp: Graphics.TBitMap; TopLeft: TPoint; const BlendColor: TsColor);
var
  D0, S0, D, S: PRGBAArray;
  DeltaD, DeltaS: integer;
  minW, minH: integer;
  rr, gg, bb: integer;
  X, Y: Integer;
begin
//  if (SrcBmp.Width = MskBmp.Width) and (SrcBmp.Height = MskBmp.Height) then begin
    minH := MskBmp.Height - 1;
    minW := MskBmp.Width - 1;
    rr := BlendColor.R shl 8;
    gg := BlendColor.G shl 8;
    bb := BlendColor.B shl 8;

    if InitLine(MskBmp, Pointer(S0), DeltaS) and InitLine(SrcBmp, Pointer(D0), DeltaD) then
      for Y := 0 to minH do begin
        S := Pointer(LongInt(S0) + DeltaS * Y);
        D := Pointer(LongInt(D0) + DeltaD * (Y + TopLeft.Y));
        for X := 0 to minW do
          with D[X + TopLeft.X] do
            if S[X].I <> -1 then begin
              R := ((R - BlendColor.R) * S[X].R + rr) shr 8;
              G := ((G - BlendColor.G) * S[X].G + gg) shr 8;
              B := ((B - BlendColor.B) * S[X].B + bb) shr 8;
            end
      end;
//  end;
end;


procedure SumBitmaps(SrcBmp, MskBmp: Graphics.TBitMap; const AlphaValue: byte);
var
  D0, S0, D, S: PRGBAArray;
  DeltaD, DeltaS, X, Y: Integer;
begin
  if (SrcBmp.Width = MskBmp.Width) and (SrcBmp.Height = MskBmp.Height) then
    if InitLine(MskBmp, Pointer(S0), DeltaS) and InitLine(SrcBmp, Pointer(D0), DeltaD) then
      for Y := 0 to SrcBmp.Height - 1 do begin
        S := Pointer(LongInt(S0) + DeltaS * Y);
        D := Pointer(LongInt(D0) + DeltaD * Y);
        for X := 0 to SrcBmp.Width - 1 do
          with D[X] do begin
            R := ((R - S[X].R) * AlphaValue + S[X].R shl 8) shr 8;
            G := ((G - S[X].G) * AlphaValue + S[X].G shl 8) shr 8;
            B := ((B - S[X].B) * AlphaValue + S[X].B shl 8) shr 8;
          end
      end;
end;


procedure PaintBmp32(SrcBmp, MskBmp: Graphics.TBitMap);
var
  D0, S0, D, S: PRGBAArray;
  DeltaD, DeltaS, X, Y: Integer;
begin
  if (SrcBmp.Width = MskBmp.Width) and (SrcBmp.Height = MskBmp.Height) then
    if InitLine(MskBmp, Pointer(S0), DeltaS) and InitLine(SrcBmp, Pointer(D0), DeltaD) then
      for Y := 0 to SrcBmp.Height - 1 do begin
        S := Pointer(LongInt(S0) + DeltaS * Y);
        D := Pointer(LongInt(D0) + DeltaD * Y);
        for X := 0 to SrcBmp.Width - 1 do
          with D[X] do begin
            R := ((S[X].R - R) * S[X].A + R shl 8) shr 8;
            G := ((S[X].G - G) * S[X].A + G shl 8) shr 8;
            B := ((S[X].B - B) * S[X].A + B shl 8) shr 8;
          end
      end;
end;


procedure SumBmpRect(const DstBmp, SrcBmp: Graphics.TBitMap; const AlphaValue: byte; SrcRect: TRect; DstPoint: TPoint);
var
  D0, S0, D, S: PRGBAArray;
  DeltaS, DeltaD, X, Y, Xd, Yd: Integer;
begin
  // Coordinates correcting
  if DstPoint.x < 0 then begin
    inc(SrcRect.Left, -DstPoint.x);
    DstPoint.x := 0;
  end;
  if DstPoint.y < 0 then begin
    inc(SrcRect.Top, -DstPoint.y);
    DstPoint.y := 0;
  end;
  if SrcRect.Left < 0 then begin
    inc(DstPoint.x, -SrcRect.Left);
    SrcRect.Left := 0;
    if DstPoint.x < 0 then begin
      inc(SrcRect.Left, -DstPoint.x);
      DstPoint.x := 0;
    end;
  end;
  if SrcRect.Top < 0 then begin
    inc(DstPoint.y, - SrcRect.Top);
    SrcRect.Top := 0;
    if DstPoint.y < 0 then begin
      inc(SrcRect.Top, - DstPoint.y);
      DstPoint.y := 0;
    end;
  end;

  if (SrcRect.Right > SrcRect.Left) and (SrcRect.Bottom > SrcRect.Top) then
    if (DstPoint.x < DstBmp.Width) and (DstPoint.y < DstBmp.Height) then 
      if (SrcRect.Left < SrcBmp.Width) and (SrcRect.Top < SrcBmp.Height) then begin
        if SrcRect.Right >= SrcBmp.Width then
          SrcRect.Right := SrcBmp.Width - 1;

        if SrcRect.Bottom >= SrcBmp.Height then
          SrcRect.Bottom := SrcBmp.Height - 1;

        if DstPoint.x + WidthOf(SrcRect) >= DstBmp.Width then
          SrcRect.Right := SrcRect.Left + (DstBmp.Width - DstPoint.x) - 1;

        if DstPoint.y + HeightOf(SrcRect) >= DstBmp.Height then
          SrcRect.Bottom := SrcRect.Top + (DstBmp.Height - DstPoint.y) - 1;

        Yd := DstPoint.Y;
        if InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(DstBmp, Pointer(D0), DeltaD) then
          for Y := SrcRect.Top to SrcRect.Bottom do begin
            S := Pointer(LongInt(S0) + DeltaS * Y);
            D := Pointer(LongInt(D0) + DeltaD * Yd);
            Xd := DstPoint.X;
            for X := SrcRect.Left to SrcRect.Right{ - 1} do
              with D[Xd] do begin
                R := ((R - S[X].R) * AlphaValue + S[X].R shl 8) shr 8;
                G := ((G - S[X].G) * AlphaValue + S[X].G shl 8) shr 8;
                B := ((B - S[X].B) * AlphaValue + S[X].B shl 8) shr 8;
                A := ((A - S[X].A) * AlphaValue + S[X].A shl 8) shr 8;
                inc(Xd);
              end;

            inc(Yd);
          end;
      end;
end;


procedure PaintBmpRect32(const DstBmp, SrcBmp: Graphics.TBitMap; SrcRect: TRect; DstPoint: TPoint);
var
  D0, S0, D, S: PRGBAArray;
  DeltaS, DeltaD, X, Y, Xd, Yd: Integer;
begin
  // Coordinates correcting
  if DstPoint.x < 0 then begin
    inc(SrcRect.Left, -DstPoint.x);
    DstPoint.x := 0;
  end;
  if DstPoint.y < 0 then begin
    inc(SrcRect.Top, -DstPoint.y);
    DstPoint.y := 0;
  end;
  if SrcRect.Left < 0 then begin
    inc(DstPoint.x, -SrcRect.Left);
    SrcRect.Left := 0;
    if DstPoint.x < 0 then begin
      inc(SrcRect.Left, -DstPoint.x);
      DstPoint.x := 0;
    end;
  end;
  if SrcRect.Top < 0 then begin
    inc(DstPoint.y, - SrcRect.Top);
    SrcRect.Top := 0;
    if DstPoint.y < 0 then begin
      inc(SrcRect.Top, - DstPoint.y);
      DstPoint.y := 0;
    end;
  end;

  if (SrcRect.Right > SrcRect.Left) and (SrcRect.Bottom > SrcRect.Top) then
    if (DstPoint.x < DstBmp.Width) and (DstPoint.y < DstBmp.Height) then
      if (SrcRect.Left < SrcBmp.Width) and (SrcRect.Top < SrcBmp.Height) then begin
        if SrcRect.Right >= SrcBmp.Width then
          SrcRect.Right := SrcBmp.Width - 1;

        if SrcRect.Bottom >= SrcBmp.Height then
          SrcRect.Bottom := SrcBmp.Height - 1;

        if DstPoint.x + WidthOf(SrcRect) >= DstBmp.Width then
          SrcRect.Right := SrcRect.Left + (DstBmp.Width - DstPoint.x) - 1;

        if DstPoint.y + HeightOf(SrcRect) >= DstBmp.Height then
          SrcRect.Bottom := SrcRect.Top + (DstBmp.Height - DstPoint.y) - 1;

        Yd := DstPoint.Y;

        if InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(DstBmp, Pointer(D0), DeltaD) then
          for Y := SrcRect.Top to SrcRect.Bottom do begin
            S := Pointer(LongInt(S0) + DeltaS * Y);
            D := Pointer(LongInt(D0) + DeltaD * Yd);
            Xd := DstPoint.X;
            for X := SrcRect.Left to SrcRect.Right{ - 1} do
              with D[Xd] do begin
                R := ((S[X].R - R) * S[X].A + R shl 8) shr 8;
                G := ((S[X].G - G) * S[X].A + G shl 8) shr 8;
                B := ((S[X].B - B) * S[X].A + B shl 8) shr 8;

                A := ((S[X].A - A) * S[X].A + A shl 8) shr 8;
                inc(Xd);
              end;

            inc(Yd);
          end;
      end;
end;


procedure CopyByMask(R1, R2: TRect; const Bmp1, Bmp2: TBitmap; const CI: TCacheInfo; const UpdateTrans: boolean); overload;
var
  C_: TsColor_;
  col: TsColor;
  D0, S0, D, S: PRGBAArray;
  DeltaD, DeltaS, X, Y, h, w, dX1, dX2: Integer;
begin
  if Bmp2 <> nil then begin
    h := Min(HeightOf(R1), HeightOf(R2));
    h := Min(h, Bmp1.Height - R1.Top);
    h := Min(h, Bmp2.Height - R2.Top) - 1;
    if h < 0 then
      Exit;

    w := Min(WidthOf(R1), WidthOf(R2));
    w := Min(w, Bmp1.Width - R1.Left);
    w := Min(w, Bmp2.Width - R2.Left) - 1;
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

    if InitLine(Bmp2, Pointer(S0), DeltaS) and InitLine(Bmp1, Pointer(D0), DeltaD) then begin
      if not CI.Ready then
        for Y := 0 to h do begin
          S := Pointer(LongInt(S0) + DeltaS * (R2.Top + Y));
          D := Pointer(LongInt(D0) + DeltaD * (R1.Top + Y));
          dX1 := R1.Left;
          dX2 := R2.Left;
          for X := 0 to w do
            with D[dX1] do begin
              R := ((S[dX2].R - R) * S[dX2].A + R shl 8) shr 8;
              G := ((S[dX2].G - G) * S[dX2].A + G shl 8) shr 8;
              B := ((S[dX2].B - B) * S[dX2].A + B shl 8) shr 8;
              if S[dX2].A <> 0 then
                A := A + ((MaxByte - A) * S[dX2].A) shr 8;

              inc(dX1);
              inc(dX2);
            end;
        end
      else begin
        for Y := 0 to h do begin
          S := Pointer(LongInt(S0) + DeltaS * (R2.Top + Y));
          D := Pointer(LongInt(D0) + DeltaD * (R1.Top + Y));
          dX1 := R1.Left;
          dX2 := R2.Left - 1;
          for X := 0 to w do begin
            inc(dX2);
            C_ := S[dX2];
            if C_.C <> clFuchsia then
              with D[dX1] do begin
                R := ((C_.R - R) * C_.A + R shl 8) shr 8;
                G := ((C_.G - G) * C_.A + G shl 8) shr 8;
                B := ((C_.B - B) * C_.A + B shl 8) shr 8;
                if C_.A <> 0 then
                  A := A + ((MaxByte - A) * C_.A) shr 8;
              end
            else
              if UpdateTrans then begin
                if (CI.Bmp.Height <= ci.Y + R1.Top + Y) then
                  Continue;

                if (CI.Bmp.Width <= ci.X + R1.Left + X) then
                  Continue;

                if ci.Y + R1.Top + Y < 0 then
                  Continue;

                if ci.X + dX1 < 0 then
                  Continue;

                col := GetAPixel(ci.Bmp, ci.X + R1.Left + X, ci.Y + R1.Top + Y);
                with D[dX1] do begin
                  R := col.R;
                  G := col.G;
                  B := col.B;
                  A := MaxByte;
                end;
              end;

            inc(dX1);
          end;
        end;
      end;
    end;
  end;
end;


procedure CopyBmp32(R1, R2: TRect; const Bmp1, Bmp2: TBitmap; const CI: TCacheInfo; const UpdateTrans: boolean; GrayedColor: TColor; const Blend: integer; const Reflected: boolean);
var
  col: TsColor;
  Col_: TsColor_;
  dR, dG, dB: real;
  gMaskValue, MaskValue: byte;
  D0, S0, D, S: PRGBAArray;
  DeltaD, DeltaS, X, Y, h, w, dX1, dX2: Integer;
begin
  if Bmp2 <> nil then begin
    Bmp2.PixelFormat := pf32Bit;

    h := Min(HeightOf(R1, True), HeightOf(R2, True));
    h := Min(h, Bmp1.Height - R1.Top);
    h := Min(h, Bmp2.Height - R2.Top) - 1;
    if h < 0 then
      Exit;

    w := Min(WidthOf(R1, True), WidthOf(R2, True));
    w := Min(w, Bmp1.Width - R1.Left);
    w := Min(w, Bmp2.Width - R2.Left);
    if w < 0 then
      Exit;

    if R1.Left < R2.Left then
      if (R1.Left < 0) then begin
        inc(R2.Left, - R1.Left);
        dec(w, - R1.Left);
        R1.Left := 0;
        w := Min(w, Bmp2.Width - R2.Left) - 1;
      end
    else
      if (R2.Left < 0) then begin
        inc(R1.Left, - R2.Left);
        dec(w, - R2.Left);
        R2.Left := 0;
        w := Min(w, Bmp1.Width - R1.Left) - 1;
      end;

    if R1.Top < R2.Top then
      if (R1.Top < 0) then begin
        inc(R2.Top, - R1.Top);
        dec(h, - R1.Top);
        R1.Top := 0;
        h := Min(h, Bmp2.Height - R2.Top) - 1;
      end
    else
      if (R2.Top < 0) then begin
        inc(R1.Top, - R2.Top);
        dec(h, - R2.Top);
        R2.Top := 0;
        h := Min(h, Bmp1.Height - R1.Top) - 1;
      end;

    w := Min(w, Bmp1.Width - R1.Left);
    w := Min(w, Bmp2.Width - R2.Left) - 1;
    Bmp2.Handle;
    if InitLine(Bmp2, Pointer(S0), DeltaS) and InitLine(Bmp1, Pointer(D0), DeltaD) then begin
      if GrayedColor <> clNone then begin
        col.C := GrayedColor;
        MaskValue := max(col.R, col.G);
        MaskValue := MaxByte - max(col.B, MaskValue);
        inc(col.R, MaskValue);
        inc(col.G, MaskValue);
        inc(col.B, MaskValue);

        dR := Col.R / MaxByte;
        dG := Col.G / MaxByte;
        dB := Col.B / MaxByte;

        if Blend <> 0 then begin
          if not CI.Ready then
            for Y := 0 to h do begin
              S := Pointer(LongInt(S0) + DeltaS * (R2.Top + Y));
              D := Pointer(LongInt(D0) + DeltaD * (R1.Top + Y));
              for X := 0 to w do begin
                dX1 := R1.Left + X;
                dX2 := R2.Left + X;
                col_ := S[dX2];
                MaskValue := col_.A * (100 - Blend) div 100;
                gMaskValue := (col_.R + col_.G + col_.B) div 3;
                with D[dX1] do begin
                  R := ((Min(Trunc(gMaskValue * dR), MaxByte) - R) * MaskValue + R shl 8) shr 8;
                  G := ((Min(Trunc(gMaskValue * dG), MaxByte) - G) * MaskValue + G shl 8) shr 8;
                  B := ((Min(Trunc(gMaskValue * dB), MaxByte) - B) * MaskValue + B shl 8) shr 8;
                end;
              end;
            end
          else
            for Y := 0 to h do begin
              S := Pointer(LongInt(S0) + DeltaS * (R2.Top + Y));
              D := Pointer(LongInt(D0) + DeltaD * (R1.Top + Y));
              dX1 := R1.Left;
              dX2 := R2.Left;
              for X := 0 to w do begin
                Col_ := S[dX2];
                if Col_.C <> clFuchsia then begin
                  MaskValue := Col_.A * (100 - Blend) div 100;
                  gMaskValue := (col_.R + col_.G + col_.B) div 3;
                  with D[dX1] do begin
                    R := ((min(Trunc(gMaskValue * dR), MaxByte) - R) * MaskValue + R shl 8) shr 8;
                    G := ((min(Trunc(gMaskValue * dG), MaxByte) - G) * MaskValue + G shl 8) shr 8;
                    B := ((min(Trunc(gMaskValue * dB), MaxByte) - B) * MaskValue + B shl 8) shr 8;
                  end;
                end
                else
                  if UpdateTrans then begin
                    if (CI.Bmp.Height <= ci.Y + R1.Top + Y) then Continue;
                    if (CI.Bmp.Width <= ci.X + dX1) then Break;
                    if ci.Y + R1.Top + Y < 0 then Break;
                    if ci.X + dX1 < 0 then Continue;
                    col.C := ci.Bmp.Canvas.Pixels[ci.X + dX1, ci.Y + R1.Top + Y];
                    with D[dX1] do begin
                      R := col.R;
                      G := col.G;
                      B := col.B;
                    end;
                  end;

                inc(dX1);
                inc(dX2);
              end;
            end;
        end
        else begin
          if not CI.Ready then
            for Y := 0 to h do begin
              S := Pointer(LongInt(S0) + DeltaS * (R2.Top + Y));
              D := Pointer(LongInt(D0) + DeltaD * (R1.Top + Y));
              dX1 := R1.Left;
              dX2 := R2.Left;
              for X := 0 to w do begin
                Col_ := S[dX2];
                gMaskValue := (col_.R + col_.G + col_.B) div 3;
                with D[dX1] do begin
                  R := ((min(Trunc(gMaskValue * dR), MaxByte) - R) * S[dX2].A + R shl 8) shr 8;
                  G := ((min(Trunc(gMaskValue * dG), MaxByte) - G) * S[dX2].A + G shl 8) shr 8;
                  B := ((min(Trunc(gMaskValue * dB), MaxByte) - B) * S[dX2].A + B shl 8) shr 8;
                end;
                inc(dX1);
                inc(dX2);
              end;
            end
          else
            for Y := 0 to h do begin
              S := Pointer(LongInt(S0) + DeltaS * (R2.Top + Y));
              D := Pointer(LongInt(D0) + DeltaD * (R1.Top + Y));
              dX1 := R1.Left;
              dX2 := R2.Left;
              for X := 0 to w do begin
                Col_ := S[dX2];
                gMaskValue := (col_.R + col_.G + col_.B) div 3;
                if Col_.C <> clFuchsia then begin
                  with D[dX1] do begin
                    R := ((min(Trunc(gMaskValue * dR), MaxByte) - R) * S[dX2].A + R shl 8) shr 8;
                    G := ((min(Trunc(gMaskValue * dG), MaxByte) - G) * S[dX2].A + G shl 8) shr 8;
                    B := ((min(Trunc(gMaskValue * dB), MaxByte) - B) * S[dX2].A + B shl 8) shr 8;
                  end;
                end
                else
                  if UpdateTrans then begin
                    if (CI.Bmp.Height <= ci.Y + R1.Top + Y) then Continue;
                    if (CI.Bmp.Width <= ci.X + dX1) then Break;
                    if ci.Y + R1.Top + Y < 0 then Break;
                    if ci.X + dX1 < 0 then Continue;
                    col.C := ci.Bmp.Canvas.Pixels[ci.X + R1.Left + X, ci.Y + R1.Top + Y];
                    with D[dX1] do begin
                      R := col.R;
                      G := col.G;
                      B := col.B;
                    end;
                  end;

                inc(dX1);
                inc(dX2);
              end;
            end;
        end;
        if Reflected then begin
          h := min(Bmp2.Height div 2 - 1, Bmp1.Height - R1.Bottom - 1);
          Col.A := MaxByte div (Bmp2.Height div 2); // Step
          Col.R := MaxByte;
          for Y := 1 to h do begin
            S := Pointer(LongInt(S0) + DeltaS * (R2.Bottom - Y - 1));
            D := Pointer(LongInt(D0) + DeltaD * (R1.Bottom + Y));
            dX1 := R1.Left;
            dX2 := R2.Left;
            for X := 0 to w do begin
              Col_ := S[dX2];
              if Col_.C <> clFuchsia then begin
                if Blend = 0 then
                  MaskValue := Col_.A * (h - Y) div h * Col.R shr 9
                else
                  MaskValue := Col_.A * (h - Y) div h * Col.R shr 9 * (100 - Blend) div 100;

                gMaskValue := (col_.R + col_.G + col_.B) div 3;
                with D[dX1] do begin
                  R := ((min(Trunc(gMaskValue * dR), MaxByte) - R) * MaskValue + R shl 8) shr 8;
                  G := ((min(Trunc(gMaskValue * dG), MaxByte) - G) * MaskValue + G shl 8) shr 8;
                  B := ((min(Trunc(gMaskValue * dB), MaxByte) - B) * MaskValue + B shl 8) shr 8;
                end;
              end;
              inc(dX1);
              inc(dX2);
            end;
            dec(Col.R, Col.A);
          end;
        end;
      end
      else begin
        if Blend <> 0 then begin
          if not CI.Ready then
            for Y := 0 to h do begin
              S := Pointer(LongInt(S0) + DeltaS * (R2.Top + Y));
              D := Pointer(LongInt(D0) + DeltaD * (R1.Top + Y));
              for X := 0 to w do begin
                dX1 := R1.Left + X;
                dX2 := R2.Left + X;
                col_ := S[dX2];
                MaskValue := col_.A * (100 - Blend) div 100;
                with D[dX1] do begin
                  R := ((col_.R - R) * MaskValue + R shl 8) shr 8;
                  G := ((col_.G - G) * MaskValue + G shl 8) shr 8;
                  B := ((col_.B - B) * MaskValue + B shl 8) shr 8;
                end;
              end;
            end
          else
            for Y := 0 to h do begin
              S := Pointer(LongInt(S0) + DeltaS * (R2.Top + Y));
              D := Pointer(LongInt(D0) + DeltaD * (R1.Top + Y));
              dX1 := R1.Left;
              dX2 := R2.Left;
              for X := 0 to w do begin
                Col_ := S[dX2];
                if Col_.C <> clFuchsia then begin
                  MaskValue := Col_.A * (100 - Blend) div 100;
                  with D[dX1] do begin
                    R := ((Col_.R - R) * MaskValue + R shl 8) shr 8;
                    G := ((Col_.G - G) * MaskValue + G shl 8) shr 8;
                    B := ((Col_.B - B) * MaskValue + B shl 8) shr 8;
                  end;
                end
                else
                  if UpdateTrans then begin
                    if (CI.Bmp.Height <= ci.Y + R1.Top + Y) then Continue;
                    if (CI.Bmp.Width <= ci.X + dX1) then Break;
                    if ci.Y + R1.Top + Y < 0 then Break;
                    if ci.X + dX1 < 0 then Continue;
                    col.C := ci.Bmp.Canvas.Pixels[ci.X + dX1, ci.Y + R1.Top + Y];
                    with D[dX1] do begin
                      R := col.R;
                      G := col.G;
                      B := col.B;
                    end;
                  end;

                inc(dX1);
                inc(dX2);
              end;
            end;
        end
        else begin
          if not CI.Ready then
            for Y := 0 to h do begin
              S := Pointer(LongInt(S0) + DeltaS * (R2.Top + Y));
              D := Pointer(LongInt(D0) + DeltaD * (R1.Top + Y));
              dX1 := R1.Left;
              dX2 := R2.Left;
              for X := 0 to w do begin
                with D[dX1] do begin
                  R := ((S[dX2].R - R) * S[dX2].A + R shl 8) shr 8;
                  G := ((S[dX2].G - G) * S[dX2].A + G shl 8) shr 8;
                  B := ((S[dX2].B - B) * S[dX2].A + B shl 8) shr 8;
                  A := max(D[dX1].A, S[dX2].A);
                end;
                inc(dX1);
                inc(dX2);
              end;
            end
          else
            for Y := 0 to h do begin
              S := Pointer(LongInt(S0) + DeltaS * (R2.Top + Y));
              D := Pointer(LongInt(D0) + DeltaD * (R1.Top + Y));
              dX1 := R1.Left;
              dX2 := R2.Left;
              for X := 0 to w do begin
                Col_ := S[dX2];
                if Col_.C <> clFuchsia then begin
                  with D[dX1] do begin
                    R := ((S[dX2].R - R) * S[dX2].A + R shl 8) shr 8;
                    G := ((S[dX2].G - G) * S[dX2].A + G shl 8) shr 8;
                    B := ((S[dX2].B - B) * S[dX2].A + B shl 8) shr 8;
                    A := max(D[dX1].A, S[dX2].A);
                  end;
                end
                else
                  if UpdateTrans then begin
                    if (CI.Bmp.Height <= ci.Y + R1.Top + Y) then Continue;
                    if (CI.Bmp.Width <= ci.X + dX1) then Break;
                    if ci.Y + R1.Top + Y < 0 then Break;
                    if ci.X + dX1 < 0 then Continue;
                    col.C := ci.Bmp.Canvas.Pixels[ci.X + R1.Left + X, ci.Y + R1.Top + Y];
                    with D[dX1] do begin
                      R := col.R;
                      G := col.G;
                      B := col.B;
                    end;
                  end;

                inc(dX1);
                inc(dX2);
              end;
            end;
        end;

        if Reflected then begin
          h := min(Bmp2.Height div 2 - 1, Bmp1.Height - R1.Bottom - 1);
          Col.A := MaxByte div (Bmp2.Height); // Step
          Col.R := MaxByte;
          for Y := 1 to h do begin
            S := Pointer(LongInt(S0) + DeltaS * (R2.Bottom - Y - 1));
            D := Pointer(LongInt(D0) + DeltaD * (R1.Bottom + Y));
            dX1 := R1.Left;
            dX2 := R2.Left;
            for X := 0 to w do begin
              Col_ := S[dX2];
              if Col_.C <> clFuchsia then begin
                if Blend = 0 then
                  MaskValue := Col_.A * (h - Y) div h * Col.R shr 9
                else
                  MaskValue := Col_.A * (h - Y) div h * Col.R shr 9 * (100 - Blend) div 100;

                with D[dX1] do begin
                  R := ((Col_.R - R) * MaskValue + R shl 8) shr 8;
                  G := ((Col_.G - G) * MaskValue + G shl 8) shr 8;
                  B := ((Col_.B - B) * MaskValue + B shl 8) shr 8;
                end;
              end;

              inc(dX1);
              inc(dX2);
            end;
            dec(Col.R, Col.A);
          end;
        end;
      end;
    end;
  end;
end;


procedure CopyByMask(R1, R2: TRect; const Bmp1, Bmp2: TBitmap; const CI: TCacheInfo; const UpdateTrans: boolean; const MaskData: TsMaskData); overload;
var
  Color: TsColor_RGB_;
  S0, S, M: PRGBAArray;
  D0, D: PRGBAArray_RGB;
  DeltaS, DeltaD, X, Y, h, w, ch, cw, dX1, dX2, hdiv2, k1, k2: Integer;
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

  if h < 0 then
    Exit;

  w := R1.Right - R1.Left;
  if w > R2.Right - R2.Left then
    w := R2.Right - R2.Left;

  if w > Bmp1.Width - R1.Left then
    w := Bmp1.Width - R1.Left;

  if w > Bmp2.Width - R2.Left then
    w := Bmp2.Width - R2.Left - 1
  else
    w := w - 1;

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

  C1.A := 0;
  Color.Alpha := TsColor(CI.FillColor).A; // Invert channels for a fast filling
  Color.Red   := TsColor(CI.FillColor).R;
  Color.Green := TsColor(CI.FillColor).G;
  Color.Blue  := TsColor(CI.FillColor).B;

  hdiv2 := (MaskData.R.Bottom - MaskData.R.Top) div 2;
  k1 := min(R2.Top + hdiv2, Bmp2.Height - h - 1); // Mask offset
  k2 := ci.X + R1.Left;

  if InitLine(Bmp2, Pointer(S0), DeltaS) and InitLine(Bmp1, Pointer(D0), DeltaD) then
    if not CI.Ready then begin
      if UpdateTrans then
        for Y := 0 to h do begin
          S := Pointer(LongInt(S0) + DeltaS * (R2.Top + Y));
          D := Pointer(LongInt(D0) + DeltaD * (R1.Top + Y));
          M := Pointer(LongInt(S0) + DeltaS * (k1 + Y));
          dX1 := R1.Left;
          dX2 := R2.Left;
          for X := 0 to w do begin
            with S[dX2], D[dX1] do
              if C <> clFuchsia then begin
                Red   := ((Red   - R) * M[dX2].R + R shl 8) shr 8;
                Green := ((Green - G) * M[dX2].G + G shl 8) shr 8;
                Blue  := ((Blue  - B) * M[dX2].B + B shl 8) shr 8;
              end
              else
                D[dX1] := Color; // UpdateTrans

            inc(dX1);
            inc(dX2);
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
            with D[dX1], S[dX2] do begin
              if C <> clFuchsia then begin
                Red   := ((Red   - R) * M[dX2].R + R shl 8) shr 8;
                Green := ((Green - G) * M[dX2].G + G shl 8) shr 8;
                Blue  := ((Blue  - B) * M[dX2].B + B shl 8) shr 8;
              end;
            end;
            inc(dX1);
            inc(dX2);
          end;
        end;
    end
    else begin
      ch := CI.Bmp.Height;
      cw := CI.Bmp.Width;
      if UpdateTrans then
        for Y := 0 to h do begin
          S := Pointer(LongInt(S0) + DeltaS * (R2.Top + Y));
          D := Pointer(LongInt(D0) + DeltaD * (R1.Top + Y));
          M := Pointer(LongInt(S0) + DeltaS * (k1 + Y));
          dX1 := R1.Left;
          dX2 := R2.Left;
          for X := 0 to w do begin
            with D[dX1], S[dX2] do begin
              Alpha := MaxByte;
              if C <> clFuchsia then begin
                Red   := ((Red   - R) * M[dX2].R + R shl 8) shr 8;
                Green := ((Green - G) * M[dX2].G + G shl 8) shr 8;
                Blue  := ((Blue  - B) * M[dX2].B + B shl 8) shr 8;
              end
              else begin
                if (ch <= ci.Y + R1.Top + Y) then Continue;
                if (cw <= k2 + X) then Break; // if Width of parent image is smaller than (X + Coord of mask)
                if ci.Y + R1.Top + Y < 0 then Break;
                if X < -k2 then Continue; // k2 + X < 0
                Col := GetAPixel(CI.Bmp, k2 + X, ci.Y + R1.Top + Y).C;
              end;
            end;
            inc(dX1);
            inc(dX2);
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
            with D[dX1], S[dX2] do begin
              Red   := ((Red   - R) * M[dX2].R + R shl 8) shr 8;
              Green := ((Green - G) * M[dX2].G + G shl 8) shr 8;
              Blue  := ((Blue  - B) * M[dX2].B + B shl 8) shr 8;
              Alpha := MaxByte;
            end;
            inc(dX1);
            inc(dX2);
          end;
        end;
    end;
end;


procedure CopyTransBitmaps(DstBmp, SrcBmp: Graphics.TBitMap; X, Y: integer; TransColor: TsColor);
var
  S0, S: PRGBAArray;
  D0, D: PRGBAArray_RGB;
  DeltaS, DeltaD, minDY, maxDY, minDX, maxDX, dX, dY, sX, sY, sw, sh, dh, dw: Integer;
begin
  sw := SrcBmp.Width - 1;
  sh := SrcBmp.Height - 1;
  dw := DstBmp.Width - 1;
  dh := DstBmp.Height - 1;

  sY := 0;
  maxDY := min(dh, Y + sh);
  minDY := max(Y, 0);
  maxDX := min(dw, X + sw);
  minDX := max(X, 0);

  if InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(DstBmp, Pointer(D0), DeltaD) then begin
    TransColor.C := SwapColor(TransColor.C);
    for dY := minDY to maxDY do begin
      S := Pointer(LongInt(S0) + DeltaS * sY);
      D := Pointer(LongInt(D0) + DeltaD * dY);
      sX := 0;
      for dX := minDX to maxDX do begin
        with S[sX], D[dX] do
          if C <> TransColor.C then begin
            Col := C;
            Alpha := MaxByte
          end;

        inc(sX);
      end;
      inc(sY);
    end
  end;
end;


procedure CopyTransRect(DstBmp, SrcBmp: Graphics.TBitMap; X, Y: integer; SrcRect: TRect; TransColor: TColor; const CI: TCacheInfo; UpdateTrans: boolean);
var
  DstPix: TsColor;
  S0, S: PRGBAArray;
  ParentRGBA: TsColor_;
  D0, D: PRGBAArray_RGB;
  DeltaS, DeltaD, sX, sY, DstX, DstY, SrcX, SrcY, h, w, ch, cw, dh, dw: integer;
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
  w := WidthOf(SrcRect);
  dh := DstBmp.Height - 1;
  dw := DstBmp.Width - 1;
  DstPix.C := DstBmp.Canvas.Pixels[0, 0]; // Save Alpha Value of dest bitmap

  if InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(DstBmp, Pointer(D0), DeltaD) then
    if UpdateTrans and CI.Ready and (CI.Bmp <> nil) then begin
      ch := CI.Bmp.Height;
      cw := CI.Bmp.Width;

      DstY := Y;
      SrcY := SrcRect.Top;
      if DstBmp <> CI.Bmp then
        for sY := 0 to h do begin
          if (DstY <= dh) and (DstY >= 0) then begin
            S := Pointer(LongInt(S0) + DeltaS * SrcY);
            D := Pointer(LongInt(D0) + DeltaD * DstY);
            DstX := X;
            SrcX := SrcRect.Left;
            for sX := 0 to w do begin
              if (DstX <= dw) and (DstX >= 0) then
                with S[SrcX], D[DstX] do begin
                  if C <> TransColor then
                    Intg := I
                  else begin
                    if (ch <= ci.Y + DstY) then Continue;
                    if (cw <= ci.X + DstX) then Break;
                    if ci.Y + DstY < 0 then Break;
                    if ci.X + DstX < 0 then Continue;
                    Col := GetAPixel(CI.Bmp, ci.X + DstX, ci.Y + DstY).C;
                  end;
                end;

              inc(DstX);
              inc(SrcX);
            end
          end;
          inc(DstY);
          inc(SrcY);
        end
      else
        for sY := 0 to h do begin
          if (DstY <= dh) and (DstY >= 0) then begin
            S := Pointer(LongInt(S0) + DeltaS * SrcY);
            D := Pointer(LongInt(D0) + DeltaD * DstY);
            DstX := X;
            SrcX := SrcRect.Left;
            for sX := 0 to w do begin
              if (DstX <= dw) and (DstX >= 0) then
                with S[SrcX], D[DstX] do
                  if C <> TransColor then begin
                    Col  := C;
                    Alpha := MaxByte;
                  end;

              inc(DstX);
              inc(SrcX);
            end
          end;
          inc(DstY);
          inc(SrcY);
        end
    end
    else begin
      DstY := Y;
      SrcY := SrcRect.Top;
      if not CI.Ready then begin // If color for transparent pixels is defined
        ParentRGBA.R := TsColor(CI.FillColor).R;
        ParentRGBA.G := TsColor(CI.FillColor).G;
        ParentRGBA.B := TsColor(CI.FillColor).B;
        ParentRGBA.A := DstPix.A; // Save Alpha Value of dest bitmap
        for sY := 0 to h do begin
          if (DstY <= dh) and (DstY >= 0) then begin
            S := Pointer(LongInt(S0) + DeltaS * SrcY);
            D := Pointer(LongInt(D0) + DeltaD * DstY);
            DstX := X;
            SrcX := SrcRect.Left;
            for sX := 0 to w do begin
              if (DstX <= dw) and (DstX >= 0) then
                with S[SrcX], D[DstX] do
                  if (C <> TransColor) then
                    Col := C
                  else
                    Col := ParentRGBA.C;

              inc(DstX);
              inc(SrcX);
            end
          end;
          inc(DstY);
          inc(SrcY);
        end
      end
      else
        for sY := 0 to h do begin
          if (DstY <= dh) and (DstY >= 0) then begin
            S := Pointer(LongInt(S0) + DeltaS * SrcY);
            D := Pointer(LongInt(D0) + DeltaD * DstY);
            DstX := X;
            SrcX := SrcRect.Left;
            for sX := 0 to w do begin
              if (DstX <= dw) and (DstX >= 0) then
                with S[SrcX], D[DstX] do
                  if (C <> TransColor) then
                    Col := C;

              inc(DstX);
              inc(SrcX);
            end
          end;
          inc(DstY);
          inc(SrcY);
        end;
    end;
end;


procedure CopyTransRectA(DstBmp, SrcBmp: Graphics.TBitMap; X, Y: integer; SrcRect: TRect; TransColor: TColor; CI: TCacheInfo);
var
  M: TsColor_;
  S0, S: PRGBAArray;
  D0, D: PRGBAArray_RGB;
  DeltaS, DeltaD, sX, sY, SrcX, DstX, DstY, h, w, dh, dw: integer;
begin
  M.B := TsColor_(TransColor).R;
  M.G := TsColor_(TransColor).G;
  M.R := TsColor_(TransColor).B;
  M.A := 0;

  if SrcRect.Top < 0 then
    SrcRect.Top := 0;

  if SrcRect.Bottom > SrcBmp.Height - 1 then
    SrcRect.Bottom := SrcBmp.Height - 1;

  if SrcRect.Left < 0 then
    SrcRect.Left := 0;

  if SrcRect.Right > SrcBmp.Width - 1 then
    SrcRect.Right := SrcBmp.Width - 1;

  h := HeightOf(SrcRect);
  w := WidthOf(SrcRect);

  DstY := Y;
  dh := DstBmp.Height - 1;
  dw := DstBmp.Width - 1;

  if InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(DstBmp, Pointer(D0), DeltaD) then
    for sY := 0 to h do begin
      if (DstY <= dh) and (DstY >= 0) then begin
        S := Pointer(LongInt(S0) + DeltaS * (sY + SrcRect.Top));
        D := Pointer(LongInt(D0) + DeltaD * DstY);
        DstX := X;
        SrcX := SrcRect.Left;
        for sX := 0 to w do
          if (DstX <= dw) and (DstX >= 0) then begin
            with S[SrcX], D[DstX] do
              if C <> M.C then
                Col := C;

            inc(SrcX);
            inc(dstX);
          end;
      end;
      inc(DstY);
    end;
end;


procedure SumBitmapsByMask(var DstBmp, Src1, Src2: Graphics.TBitMap; MskBmp: Graphics.TBitMap; Percent: word = 0);
var
  D0, D: PRGBAArray_RGB;
  S01, S02, M0, S1, S2, M: PRGBAArray;
  X, Y, w, h, DeltaS1, DeltaS2, DeltaD, DeltaM: integer;
begin
  if (Src1.Width = Src2.Width) and (Src1.Height = Src2.Height) then begin
    w := Src1.Width - 1;
    h := Src1.Height - 1;
    if InitLine(Src1, Pointer(S01), DeltaS1) and InitLine(Src2, Pointer(S02), DeltaS2) and InitLine(DstBmp, Pointer(D0), DeltaD) then begin
      if MskBmp = nil then
        for Y := 0 to h do begin
          S1 := Pointer(LongInt(S01) + DeltaS1 * Y);
          S2 := Pointer(LongInt(S02) + DeltaS2 * Y);
          D  := Pointer(LongInt(D0) + DeltaD * Y);
          for X := 0 to w do
            with D[X], S2[X] do begin
              Red   := ((S1[X].R - R) * Percent + R shl 8) shr 8;
              Green := ((S1[X].G - G) * Percent + G shl 8) shr 8;
              Blue  := ((S1[X].B - B) * Percent + B shl 8) shr 8;
            end
        end
      else
        if InitLine(MskBmp, Pointer(M0), DeltaM) then
          for Y := 0 to h do begin
            S1 := Pointer(LongInt(S01) + DeltaS1 * Y);
            S2 := Pointer(LongInt(S02) + DeltaS2 * Y);
            D  := Pointer(LongInt(D0) + DeltaD * Y);
            M  := Pointer(LongInt(M0) + DeltaM * Y);
            for X := 0 to w do
              with D[X], S2[X] do begin
                Red   := ((S1[X].R - R) * M[X].R + R shl 8) shr 8;
                Green := ((S1[X].G - G) * M[X].G + G shl 8) shr 8;
                Blue  := ((S1[X].B - B) * M[X].B + B shl 8) shr 8;
              end
          end;
    end;
  end;
end;


procedure SumByMaskWith32(const DstBmp, SrcBmp, MskBmp: Graphics.TBitMap; const aRect: TRect);
var
  D0, D: PRGBAArray_RGB;
  S0, M0, S, M: PRGBAArray;
  DeltaS, DeltaD, DeltaM, X, Y, BB, RR, tmp: integer;
begin
  if (DstBmp.Width >= WidthOf(aRect)) and (DstBmp.Height >= HeightOf(aRect)) then begin
    BB := aRect.Bottom - 1;
    RR := aRect.Right - 1;
    if InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(DstBmp, Pointer(D0), DeltaD) and InitLine(MskBmp, Pointer(M0), DeltaM) then
      for Y := aRect.Top to BB do begin
        S := Pointer(LongInt(S0) + DeltaS * Y);
        D  := Pointer(LongInt(D0) + DeltaD * Y);
        M  := Pointer(LongInt(M0) + DeltaM * Y);
        for X := aRect.Left to RR do
          case M[X].R of
            MaxByte:
              ;// skip

            0:
              with D[X], S[X] do begin
                Red   := ((R - Red  ) * A + Red    shl 8) shr 8;
                Green := ((G - Green) * A + Green  shl 8) shr 8;
                Blue  := ((B - Blue ) * A + Blue   shl 8) shr 8;
              end

            else
              with D[X], S[X] do begin
                tmp := ((MaxByte - M[X].R) * A) shr 8;
                Red    := ((R - Red   ) * tmp + Red    shl 8) shr 8;
                Green  := ((G - Green ) * tmp + Green  shl 8) shr 8;
                Blue   := ((B - Blue  ) * tmp + Blue   shl 8) shr 8;
              end;
          end;
      end;
  end;
end;


function MakeRotated90(var Bmp: TBitmap; CW: boolean; KillSource: boolean = True): TBitmap;
var
  X, Y, w, h: integer;
  C: TsColor;
begin
  w := Bmp.Width - 1;
  h := Bmp.Height - 1;
  if Bmp.PixelFormat = pf32bit then begin
    Result := CreateBmp32(h + 1, w + 1);
    if CW then
      for Y := 0 to h do
        for X := 0 to w do begin
          C := GetAPixel(Bmp, X, Y);
          SetAPixel(Result, h - Y, X, C);
        end
    else
      for Y := 0 to h do
        for X := 0 to w do begin
          C := GetAPixel(Bmp, w - X, Y);
          SetAPixel(Result, Y, X, C);
        end;
  end
  else
    Result := nil;

  if KillSource then
    FreeAndNil(Bmp);
end;


function CreateBmpLike(const Bmp: TBitmap): TBitmap;
begin
  Result             := TBitmap.Create;
  Result.Width       := Bmp.Width;
  Result.Height      := Bmp.Height;
  Result.PixelFormat := Bmp.PixelFormat
end;


function CreateAlphaBmp(const SrcMaskedBmp: TBitmap; const SrcRect: TRect): TBitmap;
var
  S0, S: PRGBAArray;
  D0, D: PRGBAArray_RGB;
  DeltaS, DeltaD, w, h, Y, X: integer;
begin
  w := WidthOf(SrcRect, True);
  h := HeightOf(SrcRect, True) div 2;
  if (w <> 0) and (h <> 0) then begin
    Result := CreateBmp32(w, h);
    // Copy content
    BitBlt(Result.Canvas.Handle, 0, 0, w, h, SrcMaskedBmp.Canvas.Handle, SrcRect.Left, SrcRect.Top, SRCCOPY);
    // Copy mask (red channel) as AlphaChannel
    if InitLine(SrcMaskedBmp, Pointer(S0), DeltaS) and InitLine(Result, Pointer(D0), DeltaD) then
      for Y := 0 to h - 1  do begin
        S := Pointer(LongInt(S0) + DeltaS * (SrcRect.Top + Y + h));
        D := Pointer(LongInt(D0) + DeltaD * Y);
        for X := 0 to w - 1  do
          D[X].Alpha := MaxByte - S[SrcRect.Left + X].R;
      end;
  end
  else
    Result := nil;
end;


function CreateBmp32(const Width: integer = 0; const Height: integer = 0): TBitmap;
begin
  Result := TBitmap.Create;
  try
    Result.PixelFormat := pf32bit;
    Result.HandleType  := bmDIB;
    Result.Width       := Width;
    Result.Height      := Height;
  except
    Result.Width  := 0;
    Result.Height := 0;
  end
end;


function CreateBmp32(const R: TRect): TBitmap; overload;
begin
  Result := CreateBmp32(WidthOf(R, True), HeightOf(R, True));
end;


function CreateBmp32(const Size: TSize): TBitmap; overload;
begin
  Result := CreateBmp32(Size.cx, Size.cy);
end;


function CreateBmp32(const Bmp: TBitmap): TBitmap; overload;
begin
  Result := CreateBmp32(Bmp.Width, Bmp.Height);
end;


function CreateBmp32(const Ctrl: TControl): TBitmap; overload;
begin
  Result := CreateBmp32(Ctrl.Width, Ctrl.Height);
end;


function AverageColor(const ColorBegin, ColorEnd: TsColor): TsColor;
begin
  Result.R := ((ColorBegin.R - ColorEnd.R) * 127 + ColorEnd.R shl 8) shr 8;
  Result.G := ((ColorBegin.G - ColorEnd.G) * 127 + ColorEnd.G shl 8) shr 8;
  Result.B := ((ColorBegin.B - ColorEnd.B) * 127 + ColorEnd.B shl 8) shr 8;
  Result.A := 0;
end;


function AverageColor(const ColorBegin, ColorEnd: TColor): TColor; overload;
var
  c1, c2: TsColor;
begin
  c1.C := ColorBegin;
  c2.C := ColorEnd;
  Result := AverageColor(c1, c2).C;
end;


function MixColors(const Color1, Color2: TColor; const PercentOfColor1: real): TColor;
var
  c1, c2: TsColor;
begin
  c1.C := Color1;
  c2.C := Color2;
  c1.R := Trunc(c1.R * PercentOfColor1 + c2.R * (1 - PercentOfColor1));
  c1.G := Trunc(c1.G * PercentOfColor1 + c2.G * (1 - PercentOfColor1));
  c1.B := Trunc(c1.B * PercentOfColor1 + c2.B * (1 - PercentOfColor1));
  Result := c1.C;
end;


procedure DrawRectangleOnDC(DC: HDC; var R: TRect; ColorTop, ColorBottom: TColor; var Width: integer);
var
  OldBrush: hBrush;
  Points: array [0..2] of TPoint;
  PenTop, PenBottom, OldPen: hPen;

  procedure DoRect;
  var
    TopRight, BottomLeft: TPoint;
  begin
    with R do begin
      TopRight.X := Right;
      TopRight.Y := Top;
      BottomLeft.X := Left;
      BottomLeft.Y := Bottom;

      Points[0] := BottomLeft;
      Points[1] := TopLeft;
      Points[2] := TopRight;
      SelectObject(dc, PenTop);
      PolyLine(DC, PPoints(@Points)^, 3);

      Dec(BottomLeft.X);

      Points[0] := TopRight;
      Points[1] := BottomRight;
      Points[2] := BottomLeft;
      SelectObject(dc, PenBottom);
      PolyLine(DC, PPoints(@Points)^, 3);
    end;
  end;

begin
  PenTop := CreatePen(PS_SOLID, 1, ColorToRGB(ColorTop));
  PenBottom := CreatePen(PS_SOLID, 1, ColorBottom);
  OldPen := SelectObject(dc, PenTop);
  OldBrush := SelectObject(dc, GetStockObject(NULL_BRUSH));

  Dec(R.Bottom);
  Dec(R.Right);

  while Width > 0 do begin
    Dec(Width);
    DoRect;
    InflateRect(R, -1, -1);
  end;
  Inc(R.Bottom); Inc(R.Right);

  SelectObject(dc, OldPen);
  SelectObject(dc, OldBrush);
  DeleteObject(PenTop);
  DeleteObject(PenBottom);
end;


procedure TileBitmap(const Canvas: TCanvas; const aRect: TRect; const Graphic: TGraphic);
var
  X, Y, cx, cy, w, h: Integer;
  SavedDC: hdc;
begin
{$IFNDEF NOSLOWDETAILS}
  if Graphic <> nil then begin
    w := Graphic.Width;
    h := Graphic.Height;
    if (w <> 0) and (h <> 0) then begin
      Canvas.OnChange := nil;
      Canvas.OnChanging := nil;
      if Graphic is TBitmap then begin
        x := aRect.Left;
        while x < aRect.Right - w do begin
          y := aRect.Top;
          while y < aRect.Bottom - h do begin
            BitBlt(Canvas.Handle, x, y, w, h, TBitmap(Graphic).Canvas.Handle, 0, 0, SRCCOPY);
            inc(y, h);
          end;
          BitBlt(Canvas.Handle, x, y, w, aRect.Bottom - y, TBitmap(Graphic).Canvas.Handle, 0, 0, SRCCOPY);
          inc(x, w);
        end;
        y := aRect.Top;
        while y < aRect.Bottom - h do begin
          BitBlt(Canvas.Handle, x, y, aRect.Right - x, h, TBitmap(Graphic).Canvas.Handle, 0, 0, SRCCOPY);
          inc(y, h);
        end;
        BitBlt(Canvas.Handle, x, y, aRect.Right - x, aRect.Bottom - y, TBitmap(Graphic).Canvas.Handle, 0, 0, SRCCOPY);
      end
      else
{$IFNDEF NOJPG}
{$IFDEF TINYJPG}
        if Graphic is TacTinyJPGImage then begin
{$ELSE}
        if Graphic is TJPEGImage then begin
{$ENDIF}
          SavedDC := SaveDC(Canvas.Handle);
          IntersectClipRect(Canvas.Handle, aRect.Left, aRect.Top, aRect.Right, aRect.Bottom);
          cx := WidthOf(aRect) div w;
          cy := HeightOf(aRect) div h;
          for X := 0 to cx do
            for Y := 0 to cy do
              Canvas.Draw(aRect.Left + X * w, aRect.Top + Y * h, Graphic);

          RestoreDC(Canvas.Handle, SavedDC);
        end;
{$ENDIF}
    end;
  end;
{$ENDIF}  
end;


{$IFNDEF ACHINTS}
procedure TileBitmap(Canvas: TCanvas; var aRect: TRect; Graphic: TGraphic; const MaskData: TsMaskData; FillMode: TacFillMode = fmTiled);
var
  X, Y, w, h, NewX, NewY, Tmp: Integer;
  SrcBmp: TBitmap;
begin
{$IFNDEF NOSLOWDETAILS}
//  if (MaskData.PropertyName <> '') then begin // If bitmap in the MaskData
//  if ((Graphic = nil) or Graphic.Empty) and (MaskData.R.Left <> MaskData.R.Right) then begin // If bitmap in the MaskData
    if MaskData.Bmp <> nil then
      SrcBmp := MaskData.Bmp
    else
      if MaskData.Manager <> nil then
        SrcBmp := TsSkinManager(MaskData.Manager).MasterBitmap
      else
        Exit;

    w := WidthOf(MaskData.R);
    h := HeightOf(MaskData.R);
    Tmp := 0;
    case FillMode of
      fmStretched: begin
        SetStretchBltMode(Canvas.Handle, COLORONCOLOR);
        StretchBlt(Canvas.Handle, aRect.Left, aRect.Top, WidthOf(aRect), HeightOf(aRect), SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top, w, h, SRCCOPY);
        aRect := Rect(-1, -1, -1, -1);
      end;

      fmStretchHorzTop: begin
        SetStretchBltMode(Canvas.Handle, COLORONCOLOR);
        StretchBlt(Canvas.Handle, aRect.Left, aRect.Top, WidthOf(aRect), h, SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top, w, h, SRCCOPY);
        aRect := Rect(aRect.Left, aRect.Top + h, aRect.Right, aRect.Bottom);
      end;

      fmStretchVertLeft: begin
        SetStretchBltMode(Canvas.Handle, COLORONCOLOR);
        StretchBlt(Canvas.Handle, aRect.Left, aRect.Top, w, HeightOf(aRect), SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top, w, h, SRCCOPY);
        aRect := Rect(aRect.Left + w, aRect.Top, aRect.Right, aRect.Bottom);
      end;

      fmStretchHorz: begin
        y := aRect.Top;
        SetStretchBltMode(Canvas.Handle, COLORONCOLOR);
        while y < aRect.Bottom - h do begin
          StretchBlt(Canvas.Handle, aRect.Left, y, WidthOf(aRect), h, SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top, w, h, SRCCOPY);
          inc(y, h);
        end;
        StretchBlt(Canvas.Handle, aRect.Left, y, WidthOf(aRect), h, SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top, w, h, SRCCOPY);
        aRect := Rect(-1, -1, -1, -1);
      end;

      fmStretchVert: begin
        x := aRect.Left;
        SetStretchBltMode(Canvas.Handle, COLORONCOLOR);
        while x < aRect.Right - w do begin
          StretchBlt(Canvas.Handle, x, aRect.Top, w, HeightOf(aRect), SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top, w, h, SRCCOPY);
          inc(x, w);
        end;
        StretchBlt(Canvas.Handle, x, aRect.Top, w, HeightOf(aRect), SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top, w, h, SRCCOPY);
        aRect := Rect(-1, -1, -1, -1);
      end;

      fmDisTiled: begin
        x := aRect.Left;
        NewX := aRect.Right - w;
        NewY := aRect.Bottom - h;
        while x < NewX do begin
          y := aRect.Top;
          while y < NewY do begin
            BitBlt(Canvas.Handle, x, y, w, h, SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top, SRCCOPY);
            inc(y, h);
          end;
          inc(x, w);
        end;
        y := aRect.Top;
        while y < NewY do begin
          BitBlt(Canvas.Handle, x, y, aRect.Right - x, h, SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top, SRCCOPY);
          inc(y, h);
        end;
        aRect := Rect(-1, -1, -1, -1);
      end

      else begin
        x := aRect.Left;
        case FillMode of
          fmTiled: begin
            NewX := aRect.Right - w;
            NewY := aRect.Bottom - h;
          end;

          fmTiledHorz: begin
            NewX := aRect.Right - w;
            NewY := aRect.Top;
          end;

          fmTiledVert: begin
            NewX := aRect.Left;
            NewY := aRect.Bottom - h;
          end;

          fmTileHorBtm: begin
            Tmp := aRect.Top;
            aRect.Top := aRect.Bottom - h;
            NewX := aRect.Right - w;
            NewY := aRect.Top;
          end

          else begin
            Tmp := aRect.Left;
            aRect.Left := aRect.Right - w;
            NewX := aRect.Left;
            NewY := aRect.Bottom - h;
          end;
        end;
        while x < NewX do begin
          y := aRect.Top;
          while y < NewY do begin
            BitBlt(Canvas.Handle, x, y, w, h, SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top, SRCCOPY);
            inc(y, h);
          end;
          BitBlt(Canvas.Handle, x, y, w, aRect.Bottom - y, SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top, SRCCOPY);
          inc(x, w);
        end;
        y := aRect.Top;
        while y < NewY do begin
          BitBlt(Canvas.Handle, x, y, aRect.Right - x, h, SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top, SRCCOPY);
          inc(y, h);
        end;
        BitBlt(Canvas.Handle, x, y, aRect.Right - x, aRect.Bottom - y, SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top, SRCCOPY);
        case FillMode of
          fmTiled:         aRect := Rect(-1, -1, -1, -1);
          fmTiledHorz:     aRect := Rect(aRect.Left, aRect.Top + h, aRect.Right, aRect.Bottom);
          fmTiledVert:     aRect := Rect(aRect.Left + w, aRect.Top, aRect.Right, aRect.Bottom);
          fmTileHorBtm:    aRect := Rect(aRect.Left, Tmp, aRect.Right, aRect.Bottom - h);
          fmTileVertRight: aRect := Rect(Tmp, arect.Top, aRect.Right - w, aRect.Bottom);
        end;
      end
    end
{$ENDIF}
end;


procedure TileMasked(Bmp: TBitmap; var aRect: TRect; const CI: TCacheInfo; const MaskData: TsMaskData; FillMode: TacFillMode = fmDisTiled);
var
  X, Y, w, h, NewX, NewY: Integer;
  mr: TRect;
begin
  if MaskData.Manager <> nil then begin
    w := WidthOfImage(MaskData);
    h := HeightOf(MaskData.R) div 2;
    case FillMode of
      fmTiled: begin
        x := aRect.Left;
        NewX := aRect.Right - w;
        NewY := aRect.Bottom - h;
        mr := MaskData.R;
        while x < NewX do begin
          y := aRect.Top;
          while y < NewY do begin
            CopyMasterRect(Rect(x, y, x + w, y + h), mr, Bmp, CI, MaskData);
            inc(y, h);
          end;
          inc(x, w);
        end;
        y := aRect.Top;
        while y < NewY do begin
          CopyMasterRect(Rect(x, y, aRect.Right, y + h), mr, Bmp, CI, MaskData);
          inc(y, h);
        end;
        aRect := Rect(-1, -1, -1, -1);
      end;

      fmDisTiled: begin
        x := aRect.Left;
        NewX := aRect.Right - w;
        NewY := aRect.Bottom - h;
        mr := MaskData.R;
        y := 0;
        while x < NewX do begin
          y := aRect.Top;
          while y < NewY do begin
            CopyMasterRect(Rect(x, y, x + w, y + h), mr, Bmp, CI, MaskData);
            inc(y, h);
          end;
          inc(x, w);
        end;
        if CI.Ready then begin
          BitBlt(Bmp.Canvas.Handle, aRect.Left, y, WidthOf(aRect), aRect.Bottom - y, CI.Bmp.Canvas.Handle, aRect.Left + CI.X, Y + CI.Y, SRCCOPY);
          BitBlt(Bmp.Canvas.Handle, x, aRect.Top, aRect.Right - x, HeightOf(aRect), CI.Bmp.Canvas.Handle, x + CI.X, aRect.Top + CI.Y, SRCCOPY);
        end
        else
          if Bmp.PixelFormat = pf32bit then begin
            FillRect32(Bmp, Rect(aRect.Left, y, aRect.Right, aRect.Bottom), ci.FillColor);
            FillRect32(Bmp, Rect(x, aRect.Top, aRect.Right, aRect.Bottom), ci.FillColor);
          end
          else begin
            FillDC(Bmp.Canvas.Handle, Rect(aRect.Left, y, aRect.Right, aRect.Bottom), CI.FillColor);
            FillDC(Bmp.Canvas.Handle, Rect(x, aRect.Top, aRect.Right, aRect.Bottom), CI.FillColor);
          end;

        aRect := Rect(-1, -1, -1, -1);
      end;
    end;
  end;
end;
{$ENDIF}


procedure CalcButtonLayout(const Client: TRect; const GlyphSize: TPoint; const TextRectSize: TSize; Layout: TButtonLayout; Alignment: TAlignment;
  AMargin, Spacing: Integer; var GlyphPos: TPoint; var TextBounds: TRect; BiDiFlags: LongInt; VerticalAlignment: TVerticalAlignment = taVerticalCenter);
var
  TextPos, ClientSize, TextSize, TotalSize: TPoint;
  Margin, dh: integer;
begin
  if (BiDiFlags and DT_RIGHT) = DT_RIGHT then
    if Layout = blGlyphLeft then
      Layout := blGlyphRight
    else
      if Layout = blGlyphRight then
        Layout := blGlyphLeft;
  { calculate the item sizes }
  ClientSize := Point(Client.Right - Client.Left, Client.Bottom - Client.Top);

  TextBounds := MkRect(TextRectSize.cx, TextRectSize.cy);
  TextSize := Point(TextRectSize.cx, TextRectSize.cy);

  { If the layout has the glyph on the right or the left, then both the
    text and the glyph are centered vertically.  If the glyph is on the top
    or the bottom, then both the text and the glyph are centered horizontally.}
  if Layout in [blGlyphLeft, blGlyphRight] then begin
    GlyphPos.Y := (ClientSize.Y - GlyphSize.Y + 1) div 2;
    TextPos.Y  := (ClientSize.Y - TextSize.Y  + 1) div 2;
  end
  else begin
    GlyphPos.X := (ClientSize.X - GlyphSize.X + 1) div 2;
    TextPos.X  := (ClientSize.X - TextSize.X  + 1) div 2;
  end;

  { If there is no text or no bitmap, then Spacing is irrelevant }
  if (TextSize.X = 0) or (GlyphSize.X = 0) then
    Spacing := 0;

  Margin := AMargin;
  if Margin = -1 then // Adjust Margin and Spacing
    if Spacing < 0 then begin
      TotalSize := Point(GlyphSize.X + TextSize.X, GlyphSize.Y + TextSize.Y);
      if Layout in [blGlyphLeft, blGlyphRight] then
        Margin := (ClientSize.X - TotalSize.X) div 3
      else
        Margin := (ClientSize.Y - TotalSize.Y) div 3;

      Spacing := Margin;
    end
    else begin
      if (Alignment in [taLeftJustify, taRightJustify]) then
        TotalSize := ClientSize
      else
        TotalSize := Point(GlyphSize.X + Spacing + TextSize.X, GlyphSize.Y + Spacing + TextSize.Y);

      case VerticalAlignment of
        taVerticalCenter:
          if Alignment = taCenter then
            if Layout in [blGlyphLeft, blGlyphRight] then
              Margin := (ClientSize.X - TotalSize.X + 1) div 2
            else
              Margin := (ClientSize.Y - TotalSize.Y + 1) div 2
          else
            Margin := 2;

        taAlignTop, taAlignBottom:
          Margin := 2;
      end;
    end
  else
    if Spacing < 0 then begin
      TotalSize := Point(ClientSize.X - (Margin + GlyphSize.X), ClientSize.Y - (Margin + GlyphSize.Y));
      if Layout in [blGlyphLeft, blGlyphRight] then
        Spacing := (TotalSize.X - TextSize.X) div 2
      else
        Spacing := (TotalSize.Y - TextSize.Y) div 2;
    end;

  case Layout of
    blGlyphLeft:
      case Alignment of
        taLeftJustify: begin
          GlyphPos.X := Margin;
          TextPos.X := GlyphPos.X + GlyphSize.X + Spacing;
          TextBounds.Right := Client.Right - Margin - TextPos.X;
        end;
        taCenter: begin
          Margin := max((ClientSize.X - TextSize.X - Spacing - GlyphSize.X) div 2, Margin);
          GlyphPos.X := Margin;
          TextPos.X := GlyphPos.X + Spacing + GlyphSize.X;
        end;
        taRightJustify: begin
          TextPos.X := ClientSize.X - Margin - TextSize.X;
          GlyphPos.X := TextPos.X - Spacing - GlyphSize.X;
        end;
      end;

    blGlyphRight:
      case Alignment of
        taLeftJustify: begin
          GlyphPos.X := Margin + TextSize.X + Spacing;
          TextPos.X := GlyphPos.X - Spacing - TextRectSize.cx;
        end;
        taCenter: begin
          Margin := (ClientSize.X - TextSize.X - Spacing - GlyphSize.X) div 2;
          TextPos.X := Margin;
          GlyphPos.X := TextPos.X + Spacing + TextSize.X;
        end;
        taRightJustify: begin
          GlyphPos.X := ClientSize.X - Margin - GlyphSize.X;
          TextPos.X := 0;
          TextBounds.Right := GlyphPos.X - Spacing - TextPos.X;
        end;
      end;

    blGlyphTop: begin
      dh := (ClientSize.y - GlyphSize.Y - Spacing - TextRectSize.cy) div 2 - Margin;
      GlyphPos.Y := Margin + dh;
      TextPos.Y := GlyphPos.Y + GlyphSize.Y + Spacing;
    end;

    blGlyphBottom: begin
      dh := (ClientSize.y - GlyphSize.Y - Spacing - TextRectSize.cy) div 2 - Margin;
      GlyphPos.Y := ClientSize.Y - Margin - GlyphSize.Y - dh;
      TextPos.Y := GlyphPos.Y - Spacing - TextSize.Y;
    end;
  end;
  // Fixup the result variables
  with GlyphPos do begin
    Inc(X, Client.Left);
    Inc(Y, Client.Top);
  end;
  OffsetRect(TextBounds, TextPos.X + Client.Left, TextPos.Y + Client.Top);
  case VerticalAlignment of
    taAlignTop: begin
      Margin := max(0, AMargin);
      case Layout of
        blGlyphLeft, blGlyphRight: begin
          GlyphPos.Y := Margin;
          OffsetRect(TextBounds, 0, Margin - TextBounds.Top);
        end;
        blGlyphTop: begin
          OffsetRect(TextBounds, 0, Margin - GlyphPos.Y);
          GlyphPos.Y := Margin;
        end;
        blGlyphBottom: begin
          GlyphPos.Y := GlyphPos.Y + (Margin - TextBounds.Top);
          OffsetRect(TextBounds, 0, Margin - TextBounds.Top);
        end;
      end;
    end;

    taAlignBottom: begin
      Margin := max(0, AMargin);
      case Layout of
        blGlyphLeft, blGlyphRight: begin
          GlyphPos.Y := Client.Bottom - Margin - GlyphSize.Y;
          OffsetRect(TextBounds, 0, Client.Bottom - Margin - TextBounds.Bottom);
        end;
        blGlyphTop: begin
          GlyphPos.Y := GlyphPos.Y + (Client.Bottom - Margin - TextBounds.Bottom);
          OffsetRect(TextBounds, 0, Client.Bottom - Margin - TextBounds.Bottom);
        end;
        blGlyphBottom: begin
          OffsetRect(TextBounds, 0, Client.Bottom - Margin - GlyphPos.Y - GlyphSize.Y);
          GlyphPos.Y := Client.Bottom - Margin - GlyphSize.Y;
        end;
      end;
    end;
  end;
end;


function GetFontHeight(hFont: HWnd): integer;
var
  DC: HDC;
  SaveFont: HGDIOBJ;
  Metrics: TTextMetric;
begin
  DC := GetDC(0);
  try
    SaveFont := SelectObject(DC, hFont);
    GetTextMetrics(DC, Metrics);
    SelectObject(DC, SaveFont);
    Result := Metrics.tmHeight + 6;
  finally
    ReleaseDC(0, DC);
  end;
end;


function GetStringSize(hFont: hgdiobj; const Text: acString; Flags: Cardinal = 0; WrapText: boolean = False; MaxWidth: integer = MaxInt): TSize;
var
  DC: HDC;
  R: TRect;
  SaveFont: HGDIOBJ;
begin
  DC := GetDC(0);
  try
    SaveFont := SelectObject(DC, hFont);
    if WrapText then begin
      R := MkRect(MaxWidth, 0);
      acDrawText(DC, PacChar(Text), R, Flags or DT_CALCRECT);
      Result := MkSize(R);
    end
    else
{$IFDEF TNTUNICODE}
      if not GetTextExtentPoint32W(DC, PWideChar(Text), Length(Text), Result) then
{$ELSE}
      if not GetTextExtentPoint32(DC, PChar(Text), Length(Text), Result) then
{$ENDIF}
        Result := MkSize;

    SelectObject(DC, SaveFont);
  finally
    ReleaseDC(0, DC);
  end;
end;


function LoadJpegOrBmp(Image: TPicture; const FileName: string; Gray: boolean): boolean;
var
  s: string;
{$IFNDEF NOJPG}
  {$IFDEF TINYJPG} j: TacTinyJPGImage {$ELSE} j: TJPEGImage {$ENDIF};
{$ENDIF}
begin
  Result := False;
  if FileExists(FileName) then begin
    s := ExtractFileExt(FileName);
    if (UpperCase(s)='.JPG') or (UpperCase(s)='.JPEG') then begin
{$IFNDEF NOJPG}
  {$IFDEF TINYJPG}
      j := TacTinyJPGImage.Create;
  {$ELSE}
      j := TJPEGImage.Create;
  {$ENDIF}
      try
        j.LoadFromFile(FileName);
        Image.Assign(TGraphic(j));
      finally
        FreeAndNil(j);
      end;
{$ENDIF}      
    end
    else
      if (UpperCase(s)='.BMP') then begin
        Image.LoadFromFile(FileName);
        Image.Bitmap.PixelFormat := pf32Bit;
        if Gray then
          GrayScale(Image.Bitmap);
      end;
  end
  else
    Image.Assign(nil);
end;


procedure LoadBmpFromPngFile(Bmp: TBitmap; const FileName: string);
{$IFNDEF FPC}
var
  Png: TPNGGraphic;
begin
  Png := TPNGGraphic.Create;
{$ELSE}
var
  Png: TPortableNetworkGraphic;
begin
  Png := TPortableNetworkGraphic.Create;
{$ENDIF}
  Png.LoadFromFile(FileName);
  Bmp.Assign(Png);
  Png.Free;
end;


procedure LoadBmpFromPngStream(Bmp: TBitmap; Stream: TStream);
{$IFNDEF FPC}
var
  Png: TPNGGraphic;
begin
  Png := TPNGGraphic.Create;
{$ELSE}
var
  Png: TPortableNetworkGraphic;
begin
  Png := TPortableNetworkGraphic.Create;
{$ENDIF}
  Png.LoadFromStream(Stream);
  Bmp.Assign(Png);
  Png.Free;
end;


procedure FocusRect(Canvas: TCanvas; R: TRect; LightColor: TColor = clBtnFace; DarkColor: TColor = clBlack);
const
  Step = 2;
var
  x, y, dx, dy: integer;
begin
  dx := WidthOf(R)  div Step;
  dy := HeightOf(R) div Step;
  dec(R.Right);
  dec(R.Bottom);
  for x := dx downto 1 do begin
    if DarkColor <> clNone then begin
      Canvas.Pixels[R.Left + Step * x, R.Top] := DarkColor;
      Canvas.Pixels[R.Left + Step * x, R.Bottom] := DarkColor;
    end;
    if LightColor <> clNone then begin
      Canvas.Pixels[R.Left + Step * x - 1, R.Top] := LightColor;
      Canvas.Pixels[R.Left + Step * x - 1, R.Bottom] := LightColor;
    end;
  end;
  for y := dy downto 1 do begin
    if DarkColor <> clNone then begin
      Canvas.Pixels[R.Left, R.Top + Step * y] := DarkColor;
      Canvas.Pixels[R.Right, R.Top + Step * y] := DarkColor;
    end;
    if LightColor <> clNone then begin
      Canvas.Pixels[R.Left, R.Top + Step * y - 1] := LightColor;
      Canvas.Pixels[R.Right, R.Top + Step * y - 1] := LightColor;
    end;
  end;
end;


type
  TContributor = packed record
    Pixel: Integer;
    Weight: Integer;
  end;
  TContributorList = array[0..0] of TContributor;
  PContributorList = ^TContributorList;
  TCList = packed record
    Count: Integer;
    Data: PContributorList;
  end;
  TCListList = array[0..0] of TCList;
  PCListList = ^TCListList;
  TRGBTripleArray = array[0..0] of TRGBTriple;
  PRGBTripleArray = ^TRGBTripleArray;
  TDrawProc = procedure(Count: Integer; Contributes: PCListList; srcLine, dstLine: Pointer; dstDelta, srcDelta: Integer); pascal;


procedure CreateContributors(var Contrib: PCListList; Size: Integer; MaxSize: Integer; Filter: TFilterType; Delta: Integer);
var
  Scale2, AWidth, Param, W, Center: Single;
  A, B, Count, CSize: Integer;
  Data: PContributorList;
const
  CFilters: array [TFilterType] of Single = (0.51, 1, 1, 1.5, 2, 3, 2);
begin
{$T-}
{$R-}
  Contrib := nil;
  if MaxSize > Size then
    Scale2 := Size / MaxSize
  else
    Scale2 := 1;

  AWidth := CFilters[Filter] / Scale2;
  CSize := Trunc(AWidth * 2 + 1) * SizeOf(TContributor);
  GetMem(Contrib, Size * (SizeOf(TCList) + CSize));
  Data := @PAnsiChar(Contrib)[Size * SizeOf(TCList)];
  for A := Size - 1 downto 0 do begin
    Count := 0;
    Center := A * MaxSize / Size;
    for B := Ceil(Center + AWidth) downto Floor(Center - AWidth) do begin
      Param := Abs(Center - B) * Scale2;
      if Param >= CFilters[Filter] then
        Continue;

      case Filter of
        ftBox:
          if (Param <= 0.5) and ((Center - B) * Scale2 <> -0.5) then
            W := 1.0
          else
            W := 0.0;

        ftTriangle:
          W := 1.0 - Param;

        ftHermite:
          W := (2.0 * Param - 3.0) * Sqr(Param) + 1.0;

        ftBell:
          if Param < 0.5 then
            W := 0.75 - Sqr(Param)
          else
            W := Sqr(Param - 1.5) * 0.5;

        ftSpline:
          if Param < 1.0 then
            W := 2 / 3 + Sqr(Param) * (Param * 0.5 - 1.0)
          else
            W := Sqr(2 - Param) * (2 - Param) * (1 / 6);

        ftLanczos3:
          if Param <> 0.0 then
            W := Sin(Param * Pi) * Sin(Param) / (Sqr(Param) * Pi)
          else
            W := 1.0;

        ftMitchell:
          if Param < 1.0 then
            W := Sqr(Param) * (7 / 6 * Param - 2) + 8 / 9
          else
            W := Sqr(Param) * ((-7 / 18) * Param + 2.0) - 10 / 3 * Param + 16 / 9;

        else
          W := 0.0;
      end;
      if W = 0.0 then
        Continue;

      with Data[Count] do begin
        if B < 0 then
          Pixel := -B
        else
          if B >= MaxSize then
            Pixel := 2 * MaxSize - B - 1
          else
            Pixel := B;

        Pixel := Pixel * Delta;
        Weight := Round(W * Scale2 * 65536);
      end;
      Inc(Count);
    end;
    Contrib[A].Count := Count;
    Contrib[A].Data := Data;
    Data := PContributorList(DWord(Data) + DWord(CSize));
  end;
{$R+}
{$T+}
end;


procedure FreeContributors(var Contrib: PCListList);
begin
  if Assigned(Contrib) then begin
    FreeMem(Contrib);
    Contrib := nil;
  end;
end;


procedure DrawLine32Pas(Count: Integer; Contributes: PCListList; srcLine, dstLine: Pointer; dstDelta, srcDelta: Integer); pascal;
var
  Dest: PRGBQUAD;
  r, g, B, AA, A, X: Integer;
begin
{$R-}
  Dest := dstLine;
  for X := 0 to Count - 1 do begin
    r := 0;
    g := 0;
    B := 0;
    AA := 0;
    for A := Contributes[X].Count - 1 downto 0 do
      with Contributes[X].Data[A] do
        if Weight <> 0 then
          with PRGBQuad(Integer(srcLine) + Pixel)^ do begin
            Inc(r,  rgbRed      * Weight);
            Inc(g,  rgbGreen    * Weight);
            Inc(B,  rgbBlue     * Weight);
            Inc(AA, rgbReserved * Weight);
          end;

    with Dest^ do begin
      if r < 0 then
        rgbRed := 0
      else
        if r > $FF0000 then
          rgbRed := MaxByte
        else
          rgbRed := r shr 16;

      if g < 0 then
        rgbGreen := 0
      else
        if g > $FF0000 then
          rgbGreen := MaxByte
        else
          rgbGreen := g shr 16;

      if B < 0 then
        rgbBlue := 0
      else
        if B > $FF0000 then
          rgbBlue := MaxByte
        else
          rgbBlue := B shr 16;

      if AA < 0 then
        rgbReserved := 0
      else
        if AA > $FF0000 then
          rgbReserved := MaxByte
        else
          rgbReserved := AA shr 16;
    end;

    if LongInt(Dest) + LongInt(dstDelta) < MaxLongInt then
      Dest := PRGBQUAD(LongInt(Dest) + LongInt(dstDelta))
  end;
{$R+}
end;


procedure Stretch(const Src, Dst: TBitmap; const Width, Height: Integer; const Filter: TFilterType; const Param: Integer = 0);
var
  Work: TBitmap;
  S, D: Pointer;
  Contrib: PCListList;
  DrawLine: TDrawProc;
  SrcPixelFormat: TPixelFormat;
  A, BytePerPixel, DeltaS, DeltaD, SrcWidth, SrcHeight: Integer;
begin
  if Height <> 0 then begin
    SrcWidth := Src.Width;
    SrcHeight := Src.Height;
    BytePerPixel := 4;
    DrawLine := DrawLine32Pas;
    SrcPixelFormat := pf32bit;
    if (SrcWidth > 1) and (SrcHeight > 1) then begin // Source bitmap is not too small
      if (SrcWidth <> Width) or (SrcHeight <> Height) then begin
        Work := TBitmap.Create;
        try
          Work.Height := SrcHeight;
          Work.Width := Width;
          Src.PixelFormat := SrcPixelFormat;
          Work.PixelFormat := SrcPixelFormat;
          S := Src.ScanLine[0];
          DeltaS := PAnsiChar(Src.ScanLine[1]) - PAnsiChar(S);
          D := Work.ScanLine[0];
          DeltaD := PAnsiChar(Work.ScanLine[1]) - PAnsiChar(D);
          CreateContributors(Contrib, Width, SrcWidth, Filter, BytePerPixel);
          try
            for A := SrcHeight - 1 downto 0 do begin
              DrawLine(Width, Contrib, S, D, BytePerPixel, BytePerPixel);
              Inc(PAnsiChar(S), DeltaS);
              Inc(PAnsiChar(D), DeltaD);
            end;
          finally
            FreeContributors(Contrib);
          end;
          Dst.Width := Width;
          Dst.Height := Height;
          Dst.PixelFormat := SrcPixelFormat;
          S := Work.ScanLine[0];
          DeltaS := PAnsiChar(Work.ScanLine[1]) - PAnsiChar(S);
          D := Dst.ScanLine[0];
          DeltaD := PAnsiChar(Dst.ScanLine[1]) - PAnsiChar(D);
          CreateContributors(Contrib, Height, SrcHeight, Filter, DeltaS);
          try
            for A := Width - 1 downto 0 do begin
              DrawLine(Height, Contrib, S, D, DeltaD, DeltaS);
              S := Pointer(DWORD(S) + DWord(BytePerPixel));
              D := Pointer(DWORD(D) + DWord(BytePerPixel));
            end;
          finally
            FreeContributors(Contrib);
          end;
        finally
          FreeAndNil(Work);
        end;
      end
      else
        if Dst <> Src then
          Dst.Assign(Src);
    end;
  end;
end;


initialization
  Gdi32Lib := LoadLibrary(gdi32);
  if Gdi32Lib <> 0 then begin
    SetLayout := GetProcAddress(Gdi32Lib, 'SetLayout');
    GetLayout := GetProcAddress(Gdi32Lib, 'GetLayout');
  end
  else begin
    @SetLayout := nil;
    @GetLayout := nil;
  end;

  if not Assigned(UpdateLayeredWindow) then begin
    User32Lib := LoadLibrary(user32);
    if User32Lib <> 0 then begin
      UpdateLayeredWindow := GetProcAddress(User32Lib, 'UpdateLayeredWindow');
      SetLayeredWindowAttributes := GetProcAddress(User32Lib, 'SetLayeredWindowAttributes');
    end
    else begin
      @UpdateLayeredWindow := nil;
      @SetLayeredWindowAttributes := nil;
    end;
  end;
  GetCheckSize;


finalization
  if Gdi32Lib <> 0 then
    FreeLibrary(Gdi32Lib);

  if User32Lib <> 0 then
    FreeLibrary(User32Lib);

end.



