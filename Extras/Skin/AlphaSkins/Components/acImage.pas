unit acImage;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Imglist,
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  sConst, ExtCtrls, acAlphaImageList, sCommonData;


type
{$IFNDEF NOTFORHELP}
  TsCustomImage = class(TImage)
  private
    FGrayed,
    FReflected,
    FUseFullSize: boolean;

    FBlend: TPercent;
    FImageIndex: integer;
    FImages: TCustomImageList;
    FCommonData: TsCtrlSkinData;
    FImageChangeLink: TChangeLink;
{$IFNDEF D2010}
    FOnMouseLeave,
    FOnMouseEnter: TNotifyEvent;
{$ENDIF}
    procedure SetBlend       (const Value: TPercent);
    procedure SetGrayed      (const Value: boolean);
    procedure SetImageIndex  (const Value: integer);
    procedure SetImages      (const Value: TCustomImageList);
    procedure SetReflected   (const Value: boolean);
    procedure SetUseFullSize (const Value: boolean);
    procedure ImageListChange(Sender: TObject);
  protected
    ImageChanged: boolean;
    function OwnDrawing: boolean;
    function PrepareCache(DC: HDC): boolean;
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    procedure AfterConstruction; override;
    procedure Loaded; override;
    constructor Create(AOwner:TComponent); override;
    procedure UpdateImage;

    function Empty: boolean;
    destructor Destroy; override;
    procedure acWM_Paint(var Message: TWMPaint); message WM_PAINT;
    procedure WndProc (var Message: TMessage); override;

    property Blend: TPercent read FBlend write SetBlend default 0;
    property UseFullSize: boolean read FUseFullSize write SetUseFullSize default False;
    property ImageIndex: integer read FImageIndex write SetImageIndex default -1;
    property Images: TCustomImageList read FImages write SetImages;
    property Grayed: boolean read FGrayed write SetGrayed default False;
    property Reflected: boolean read FReflected write SetReflected default False;
    property SkinData: TsCtrlSkinData read FCommonData write FCommonData;
{$IFNDEF D2010}
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
{$ENDIF}
  end;
{$ENDIF}


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsImage = class(TsCustomImage)
  published
{$IFNDEF NOTFORHELP}
    property Picture;
    property OnMouseEnter;
    property OnMouseLeave;
{$ENDIF}
    property Blend;
    property ImageIndex;
    property Images;
    property Grayed;
    property Reflected;
    property SkinData;
    property UseFullSize;
  end;


implementation

uses
  math,
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  sGraphUtils, acntUtils, sAlphaGraph, sSkinManager, sThirdParty;


procedure TsCustomImage.AfterConstruction;
begin
  inherited;
  FCommonData.Loaded;
end;


constructor TsCustomImage.Create(AOwner: TComponent);
begin
  inherited;
  FCommonData := TsCtrlSkinData.Create(Self, True);
  FCommonData.COC := COC_TsImage;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  ImageChanged := True;
  FImageIndex := -1;
end;


destructor TsCustomImage.Destroy;
begin
  if Assigned(FCommonData) then
    FreeAndNil(FCommonData);

  FreeAndNil(FImageChangeLink);
  inherited;
end;


procedure TsCustomImage.SetBlend(const Value: TPercent);
begin
  if FBlend <> Value then begin
    FBlend := Value;
    Skindata.Invalidate;
  end;
end;


procedure TsCustomImage.SetGrayed(const Value: boolean);
begin
  if FGrayed <> Value then begin
    FGrayed := Value;
    Skindata.Invalidate;
  end;
end;


procedure TsCustomImage.SetImageIndex(const Value: integer);
begin
  if FImageIndex <> Value then begin
    FImageIndex := Value;
    Skindata.Invalidate;
  end;
end;


procedure TsCustomImage.SetImages(const Value: TCustomImageList);
begin
  if FImages <> Value then begin
    if FImages <> nil then
      Images.UnRegisterChanges(FImageChangeLink);

    FImages := Value;
    if Images <> nil then begin
      Images.RegisterChanges(FImageChangeLink);
      Images.FreeNotification(Self);
    end;
    UpdateImage;
  end;
end;


procedure TsCustomImage.SetReflected(const Value: boolean);
begin
  if FReflected <> Value then begin
    FReflected := Value;
    Skindata.Invalidate;
  end;
end;


procedure TsCustomImage.ImageListChange(Sender: TObject);
begin
  Skindata.Invalidate;
end;


function TsCustomImage.OwnDrawing: boolean;
begin
  Result := Reflected or Grayed or (Blend > 0);
end;


function TsCustomImage.PrepareCache(DC: HDC): boolean;
var
  R: TRect;
  CI: TCacheInfo;
  BGInfo: TacBGInfo;

  procedure DrawImage;
  var
    l, t: integer;
    StretchSize, Size: TSize;
    TmpBmp, StretchSrc: TBitmap;

    function GetSrcSize(CalcStretch: boolean = True): TSize;
    var
      SrcHeight: integer;
{$IFNDEF DELPHI5}
      xyaspect: real;
{$ENDIF}
    begin
      if (ImageIndex >= 0) and (Images <> nil) then
        Result := MkSize(Images.Width, Images.Height)
      else
        Result := MkSize(Picture.Width, Picture.Height);

      if (Result.cx <> 0) and (Result.cy <> 0) then // Picture is not empty?
        if CalcStretch then begin
          SrcHeight := Height;
          if Reflected then
            SrcHeight := SrcHeight * 2 div 3;
{$IFNDEF DELPHI5}
          if Proportional then begin
            xyaspect := Result.cx / Result.cy;
            if Result.cx > Result.cy then begin
              Result.cx := Width;
              Result.cy := Trunc(Width / xyaspect);
              if Result.cy > SrcHeight then begin
                Result.cy := SrcHeight;
                Result.cx := Trunc(Result.cy * xyaspect);
              end;
            end
            else begin
              Result.cy := SrcHeight;
              Result.cx := Trunc(Result.cy * xyaspect);
              if Result.cx > Width then begin
                Result.cx := Width;
                Result.cy := Trunc(Result.cx / xyaspect);
              end;
            end;
          end
          else
{$ENDIF}
            Result := MkSize(Width, SrcHeight);
        end;
    end;

  begin
    Size := GetSrcSize(False);
    StretchSize := GetSrcSize(Stretch);
    TmpBmp := CreateBmp32(Size);
    if (ImageIndex >= 0) and (Images <> nil) then begin
      // Get bitmap from imagelist
      TmpBmp.Width := Images.Width;
      TmpBmp.Height := Images.Height;
      if Images is TsAlphaImageList then
        TsAlphaImageList(Images).GetBitmap32(ImageIndex, TmpBmp)
      else
        if Images is TsVirtualImageList then
          TsVirtualImageList(Images).GetBitmap32(ImageIndex, TmpBmp)
        else
          Images.GetBitmap(ImageIndex, TmpBmp);

      if Stretch then begin
        StretchSrc := TmpBmp;
        TmpBmp := CreateBmp32(StretchSize);
        sGraphUtils.Stretch(StretchSrc, TmpBmp, StretchSize.cx, StretchSize.cy, ftMitchell);
        StretchSrc.Free;
      end;
    end
    else
      if not (Picture.Graphic is TBitmap) {$IFDEF D2010}{or not Picture.Graphic.SupportsPartialTransparency uncomment in the Beta}{$ENDIF} then begin
        BitBlt(TmpBmp.Canvas.Handle, 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
        TmpBmp.Width := StretchSize.cx;
        TmpBmp.Height := StretchSize.cy;
        R := MkRect(TmpBmp);
        if Stretch then begin
          R.Right := min(Width, R.Left + StretchSize.cx);
          R.Bottom := min(Height, R.Top + StretchSize.cy);
        end;
        TmpBmp.Canvas.StretchDraw(R, Picture.Graphic);
        FillAlphaRect(TmpBmp, R, MaxByte);
      end
      else
        if not Picture.Bitmap.Empty then begin
          TmpBmp.Assign(Picture.Bitmap);
          if TmpBmp.PixelFormat <> pf32bit then begin
            TmpBmp.PixelFormat := pf32bit;
            FillAlphaRect(TmpBmp, MkRect(TmpBmp), MaxByte);
          end;
          if Stretch then begin
            StretchSrc := TmpBmp;
            TmpBmp := CreateBmp32(StretchSize);
            sGraphUtils.Stretch(StretchSrc, TmpBmp, StretchSize.cx, StretchSize.cy, ftMitchell);
            StretchSrc.Free;
          end;
        end;

    if Stretch {$IFDEF DELPHI6UP}and (not Proportional){$ENDIF} or not Center then begin
      l := 0;
      t := 0;
    end
    else begin
      l := (Width - TmpBmp.Width) div 2;
      t := (Height - TmpBmp.Height - integer(FUseFullSize) * (TmpBmp.Height div 2)) div 2;
    end;
    CopyBmp32(Rect(l, t, l + TmpBmp.Width, t + TmpBmp.Height), MkRect(TmpBmp), FCommonData.FCacheBmp, TmpBmp, EmptyCI, False,
                                                               iff(Grayed, $FFFFFF, clNone), Blend, Reflected);
    TmpBmp.Free;
  end;

begin
  Result := True;
  GetBGInfo(@BGInfo, Parent);
  if BGInfo.BgType = btNotReady then begin
    FCommonData.FUpdating := True;
    Result := False;
  end
  else begin
    CI := BGInfoToCI(@BGInfo);
    InitCacheBmp(SkinData);
    if CI.Ready and CI.Bmp.Empty then
      Exit;

    if Transparent then
      BitBlt(FCommonData.FCacheBmp.Canvas.Handle, 0, 0, Width, Height, DC, 0, 0, SRCCOPY);

    PaintItem(FCommonData, CI, True, 0, MkRect(Self), MkPoint(Self), FCommonData.FCacheBMP, True, 0, 0);
    DrawImage;
    FCommonData.BGChanged := False;
  end;
end;


procedure TsCustomImage.WndProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  if FCommonData <> nil then
    case Message.Msg of
      WM_ERASEBKGND:
        Exit;

      WM_WINDOWPOSCHANGED, WM_SIZE:
        if Visible then
          FCommonData.BGChanged := True;

      CM_VISIBLECHANGED: begin
        FCommonData.BGChanged := True;
        SkinData.FMouseAbove := False
      end;
    end;

  inherited;
{$IFNDEF D2010}
  case Message.Msg of
    CM_MOUSEENTER: if Assigned(FOnMouseEnter) then FOnMouseEnter(Self);
    CM_MOUSELEAVE: if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);
  end;
{$ENDIF}
end;


procedure TsCustomImage.acWM_Paint(var Message: TWMPaint);
var
  SavedDC: hdc;
begin
  if not InUpdating(FCommonData) and not (Empty and (SkinData.SkinIndex < 0)) then begin
    SavedDC := SaveDC(Message.DC);
    try
      if FCommonData.BGChanged or ImageChanged then begin
        FCommonData.UpdateIndexes;
        PrepareCache(Message.DC);
      end;
      BitBlt(Message.DC, 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
    finally
      RestoreDC(Message.DC, SavedDC);
    end;
  end
  else
    inherited;
end;


function TsCustomImage.Empty: boolean;
begin
  if (FImages <> nil) and ((FImageIndex >= 0) and (FImageIndex < GetImageCount(FImages))) then
    Result := False
  else
    if Picture.Graphic <> nil then
      Result := Picture.Graphic.Empty
    else
      if Picture.Bitmap <> nil then
        Result := Picture.Bitmap.Empty
      else
        Result := True;
end;


procedure TsCustomImage.UpdateImage;
begin
  if not (csLoading in ComponentState) and not (csDestroying in ComponentState) then
    Repaint;
end;


procedure TsCustomImage.SetUseFullSize(const Value: boolean);
begin
  if FUseFullSize <> Value then begin
    FUseFullSize := Value;
    Skindata.Invalidate;
  end;
end;


function TsCustomImage.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
var
  w, h: integer;
begin
  Result := True;
  if not (csDesigning in ComponentState) or not Empty then begin
    if (Images <> nil) and Between(ImageIndex, 0, GetImageCount(Images)) then begin
      w := Images.Width;
      h := Images.Height;
    end
    else begin
      w := Picture.Width;
      h := Picture.Height;
    end;
    if Align in [alNone, alLeft, alRight] then
      NewWidth := w;

    if Align in [alNone, alTop, alBottom] then begin
      NewHeight := h;
      if FUseFullSize and FReflected then
        inc(NewHeight, NewHeight div 2)
    end;
  end
  else
    inherited CanAutoSize(NewWidth, NewHeight);
end;


procedure TsCustomImage.Loaded;
begin
  inherited;
  FCommonData.Loaded;
end;


procedure TsCustomImage.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
    if AComponent = Images then
      Images := nil;
end;

end.
