unit sGlyphUtils;
{$I sDefs.inc}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, buttons, ImgList,
  acAlphaImageList, sSpeedButton;


type
  TsGlyphMode = class(TPersistent)
  private
    FImageIndex,
    FImageIndexHot,
    FImageIndexPressed: integer;

    FOwner: TWinControl;
    FImages: TCustomImageList;
    procedure SetBlend            (const Value: integer);
    procedure SetHint             (const Value: string);
    procedure SetGrayed           (const Value: boolean);
    procedure SetImages           (const Value: TCustomImageList);
    procedure SetImageIndex       (const Value: integer);
    procedure SetImageIndexHot    (const Value: integer);
    procedure SetImageIndexPressed(const Value: integer);
    function GetHint: string;
    function ReadBlend: integer;
    function ReadGrayed: boolean;
    function BtnIsReady: boolean;
  public
    Btn: TsSpeedButton;
    constructor Create(AOwner: TWinControl);
    procedure Invalidate;
    function ImageCount: integer;
    function Width: Integer;
    function Height: Integer;
  published
    property Blend: integer read ReadBlend write SetBlend;
    property Grayed: boolean read ReadGrayed write SetGrayed;
    property Hint: string read GetHint write SetHint;
    property Images: TCustomImageList read FImages write SetImages;
    property ImageIndex:        integer read FImageIndex        write SetImageIndex        default -1;
    property ImageIndexHot:     integer read FImageIndexHot     write SetImageIndexHot     default -1;
    property ImageIndexPressed: integer read FImageIndexPressed write SetImageIndexPressed default -1;
  end;

  
const
  iBTN_ARROW      = -1;
  iBTN_OPENFILE   = 0;
  iBTN_OPENFOLDER = 1;
  iBTN_DATE       = 2;
  iBTN_ELLIPSIS   = 3;
  iBTN_CALC       = 4;


var
  acResImgList: TsAlphaImageList;


implementation

uses
  {$IFNDEF ALITE}sCurrencyEdit, {$ENDIF}
  {$IFDEF UNICODE}PngImage, {$ENDIF}
  sCustomComboEdit, sComboBox, acntUtils, sThirdParty;


const
  acGlyphsResNames: array [0..4] of string = ('SF', 'SR', 'SD', 'SE', 'SC');


constructor TsGlyphMode.Create(AOwner: TWinControl);
begin
  Btn := nil;
  FOwner := AOwner;
  FImageIndex := -1;
  FImageIndexHot := -1;
  FImageIndexPressed := -1;
end;


function TsGlyphMode.GetHint: string;
begin
  if (FOwner is TsCustomComboEdit) and (TsCustomComboEdit(FOwner).Button <> nil) then
    Result := TsCustomComboEdit(FOwner).Button.Hint
  else
    Result := TsComboBox(FOwner).Hint;
end;


procedure TsGlyphMode.SetBlend(const Value: integer);
begin
  if BtnIsReady then
    Btn.Blend := Value;
end;


procedure TsGlyphMode.SetHint(const Value: string);
begin
  if (FOwner is TsCustomComboEdit) and (TsCustomComboEdit(FOwner).Button <> nil) then
    TsCustomComboEdit(FOwner).Button.Hint := Value;
end;


procedure TsGlyphMode.SetGrayed(const Value: boolean);
begin
  if BtnIsReady then
    Btn.Grayed := Value;
end;


procedure TsGlyphMode.Invalidate;
begin
  if FOwner is TsCustomComboEdit then
    with TsCustomComboEdit(FOwner) do begin
      Button.Width := Self.Width + 2;
      Button.NumGlyphs := ImageCount;
      Button.Invalidate;
    end;
end;


function TsGlyphMode.Width: Integer;
begin
  if FOwner is TsCustomComboEdit and TsCustomComboEdit(FOwner).Button.ComboBtn then
    Result := GetSystemMetrics(SM_CXVSCROLL) - 3
  else
    if Assigned(FImages) and IsValidIndex(ImageIndex, GetImageCount(FImages)) then
      Result := FImages.Width div ImageCount
    else
      Result := acResImgList.Width div ImageCount;
end;


function TsGlyphMode.Height: Integer;
begin
  if Assigned(FImages) and IsValidIndex(ImageIndex, GetImageCount(FImages)) then
    Result := FImages.Height
  else
    Result := acResImgList.Height
end;


function TsGlyphMode.ImageCount: integer;
var
  w, h: integer;
begin
  if Assigned(FImages) and IsValidIndex(ImageIndex, GetImageCount(FImages)) then begin
    w := FImages.Width;
    h := FImages.Height
  end
  else begin
    w := acResImgList.Width;
    h := acResImgList.Height
  end;
  if w mod h = 0 then
    Result := w div h
  else
    Result := 1;
end;


procedure TsGlyphMode.SetImages(const Value: TCustomImageList);
begin
  if FImages <> Value then begin
    FImages := Value;
    Invalidate;
  end;
end;


procedure TsGlyphMode.SetImageIndex(const Value: integer);
begin
  if FImageIndex <> Value then begin
    FImageIndex := Value;
    Invalidate;
  end;
end;


procedure TsGlyphMode.SetImageIndexHot(const Value: integer);
begin
  if FImageIndexHot <> Value then begin
    FImageIndexHot := Value;
    Invalidate;
  end;
end;


procedure TsGlyphMode.SetImageIndexPressed(const Value: integer);
begin
  if FImageIndexPressed <> Value then begin
    FImageIndexPressed := Value;
    Invalidate;
  end;
end;


function TsGlyphMode.ReadBlend: integer;
begin
  if BtnIsReady then
    Result := Btn.Blend
  else
    Result := 0;
end;


function TsGlyphMode.ReadGrayed: boolean;
begin
  if BtnIsReady then
    Result := Btn.Grayed
  else
    Result := False;
end;


function TsGlyphMode.BtnIsReady: boolean;
begin
  Result := (Btn <> nil) and ([csLoading, csDestroying] * Btn.ComponentState = [])
end;


{$IFDEF UNICODE}
function MakeIconFromPng(Png: TPngImage): HICON;
var
  IconInfo: TIconInfo;
  ImgBitmap, MaskBitmap: TBitmap;
begin
  MaskBitmap := TBitmap.Create;
  ImgBitmap := TBitmap.Create;
  try
    MaskBitmap.Width := Png.Width;
    MaskBitmap.Height := Png.Height;

    MaskBitmap.PixelFormat := pf1bit;
    MaskBitmap.Canvas.Brush.Color := clBlack;
    MaskBitmap.Canvas.FillRect(MkRect(MaskBitmap));

    IconInfo.fIcon := True;
    Png.AssignTo(ImgBitmap);
    IconInfo.hbmColor := ImgBitmap.Handle;
    IconInfo.hbmMask := MaskBitmap.Handle;

    Result := CreateIconIndirect(IconInfo);
  finally
    ImgBitmap.Free;
    MaskBitmap.Free;
  end;
end;
{$ENDIF}


var
  s: TResourceStream;
  it: integer;


initialization
  // Load glyphs from resources
  acResImgList := TsAlphaImageList.Create(nil);
  acResImgList.Width  := 32; // 16 x 2
  acResImgList.Height := 16;
  for it := 0 to 4 do begin
    s := TResourceStream.Create(hInstance, acGlyphsResNames[it], RT_RCDATA);
    with TsImgListItem(acResImgList.Items.Add) do begin
      ImgData.LoadFromStream(s);
      ImageFormat := ifPNG;
      PixelFormat := pf32bit;
    end;
    s.Free;
  end;
  acResImgList.GenerateStdList;

  
finalization
  FreeAndNil(acResImgList);

end.
