unit acSlider;
{$I sDefs.inc}

interface

uses
  Windows, SysUtils, Classes, Controls, ExtCtrls, Graphics, Messages, ImgList,
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  {$IFDEF DELPHI_XE2} UITypes, {$ENDIF}
  sCommonData, sPanel, sConst;


type
{$IFNDEF NOTFORHELP}
  TacSliderChangeEvent = procedure(Sender: TObject) of object;
  TacOnChangingEvent   = procedure(Sender: TObject; var CanChange: boolean) of object;
  TControlOrientation  = (coHorizontal, coVertical);
  TSliderContentPlacing = (scpThumb, scpBackground);
{$ENDIF}


  TsButtonPanel = class(TsPanel)
  public
    procedure WndProc(var Message: TMessage); override;
  end;

{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsSlider = class(TsPanel)
{$IFNDEF NOTFORHELP}
  private
    Dragged,
    Capturing,
    FSliderOn,
    FReversed,
    FUseSymbols,
    FShowCaption: boolean;

    FImageIndexOn,
    FImageIndexOff: TImageIndex;

    FSliderCaptionOn,
    FSliderCaptionOff: acString;

    FThumbIndexOn,
    FThumbIndexOff,
    FGlyphIndexOn,
    FGlyphIndexOff: TImageIndex;

    FFontOn: TFont;
    FButton: TsButtonPanel;
    UpdateCount: integer;
    MouseDownSpot: TPoint;
    FThumbSection: string;
    FImages: TCustomImageList;
    FBoundLabel: TsBoundLabel;
    FThumbSizeInPercent: TPercent;
    FImageChangeLink: TChangeLink;
    FOnChanging: TacOnChangingEvent;
    FOrientation: TControlOrientation;
    FOnSliderChange: TacSliderChangeEvent;
    FContentPlacing: TSliderContentPlacing;
    FSliderCursor: TCursor;
    procedure ImageListChange      (Sender: TObject);
    procedure FontOnChange         (Sender: TObject);
    procedure SetFontOn            (const Value: TFont);
    procedure SetSliderCursor      (const Value: TCursor);
    procedure SetThumbSizeInPercent(const Value: TPercent);
    procedure SetSliderCaptionOff  (const Value: acString);
    procedure SetSliderCaptionOn   (const Value: acString);
    procedure SetThumbSection      (const Value: String);
    procedure SetImages            (const Value: TCustomImageList);
    procedure SetOrientation       (const Value: TControlOrientation);
    procedure SetContentPlacing    (const Value: TSliderContentPlacing);
    procedure SetBoolean           (const Index: Integer; const Value: boolean);
    procedure SetImageIndex        (const Index: Integer; const Value: TImageIndex);
  protected
    ClickPoint: TPoint;
    function CanChange: boolean;
    function ThumbSize: TSize;
    procedure UpdateBtnFont;
    procedure UpdateButton;
    function BtnInBeginning: boolean;
    function StateFromPos: boolean;
    function ThumbMargin(Side: TacSide): integer;
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    procedure ChangeValueAnim(DoChange: boolean = False);
    procedure ButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ButtonMouseUp  (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ButtonMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ButtonPaint    (Sender: TObject; Canvas: TCanvas);
    procedure PaintContent(R: TRect; aCanvas: TCanvas);
    procedure UpdateThumbSkin(SetUpdating: boolean = False);
    function ContentRect: TRect;
    function CustomImageUsed: boolean;
    function ThumbImgIndex: integer;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    ThumbOffsetX1,
    ThumbOffsetX2,
    ThumbOffsetY1,
    ThumbOffsetY2: integer;
    procedure Click; override;
    procedure OurPaint(DC: HDC = 0; SendUpdated: boolean = True); override;
    constructor Create(AOwner: TComponent); override;
    function PrepareCache: boolean; override;
    procedure AfterConstruction; override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure BeginUpdate;
    procedure EndUpdate(DoRepaint: boolean);
    procedure UpdateSize;
    procedure WndProc(var Message: TMessage); override;
  published
    property BevelOuter default bvLowered;
    property Height default 21;
    property Width default 57;
{$ENDIF}
    property BoundLabel: TsBoundLabel read FBoundLabel write FBoundLabel;
    property Orientation: TControlOrientation read FOrientation write SetOrientation default coHorizontal;
    property Images: TCustomImageList read FImages write SetImages;

    property GlyphIndexOff: TImageIndex index 0 read FGlyphIndexOff write SetImageIndex default -1;
    property GlyphIndexOn:  TImageIndex index 1 read FGlyphIndexOn  write SetImageIndex default -1;
    property ImageIndexOff: TImageIndex index 2 read FImageIndexOff write SetImageIndex default -1;
    property ImageIndexOn:  TImageIndex index 3 read FImageIndexOn  write SetImageIndex default -1;
    property ThumbIndexOff: TImageIndex index 4 read FThumbIndexOff write SetImageIndex default -1;
    property ThumbIndexOn:  TImageIndex index 5 read FThumbIndexOn  write SetImageIndex default -1;

    property FontOn: TFont read FFontOn write SetFontOn;
    property SliderCursor: TCursor read FSliderCursor write SetSliderCursor default crDefault;
    property SliderCaptionOn:  acString read FSliderCaptionOn  write SetSliderCaptionOn;
    property SliderCaptionOff: acString read FSliderCaptionOff write SetSliderCaptionOff;
    property ThumbSection:     acString read FThumbSection write SetThumbSection;
    property ContentPlacing: TSliderContentPlacing read FContentPlacing write SetContentPlacing default scpThumb;
    property ThumbSizeInPercent: TPercent read FThumbSizeInPercent write SetThumbSizeInPercent default 50;

    property Reversed:    boolean index 0 read FReversed    write SetBoolean default False;
    property ShowCaption: boolean index 1 read FShowCaption write SetBoolean default True;
    property SliderOn:    Boolean index 2 read FSliderOn    write SetBoolean default True;
    property UseSymbols:  boolean index 3 read FUseSymbols  write SetBoolean default False;
    {:@event}
    property OnChanging:     TacOnChangingEvent   read FOnChanging     write FOnChanging;
    {:@event}
    property OnSliderChange: TacSliderChangeEvent read FOnSliderChange write FOnSliderChange;
  end;


implementation

uses
  sSkinProps, sStyleSimply, acntUtils, math, sGraphUtils, sMessages, sVCLUtils;


const
  ContentMargin = 8;


procedure TsSlider.AfterConstruction;
begin
  inherited;
  UpdateButton;
  if FFontOn.Height = 100 then
    FFontOn.Assign(Font);

  UpdateBtnFont;
  FButton.OnClick := OnClick;
end;


const
  BtnPosArray: array [boolean, boolean] of boolean = ((False, True), (True, False));

function TsSlider.BtnInBeginning: boolean;
begin
  Result := BtnPosArray[SliderOn, FReversed];
end;


procedure TsSlider.ButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then begin
    Capturing := True;
    MouseDownSpot.X := X;
    MouseDownSpot.Y := Y;
    ClickPoint.X := X;
    ClickPoint.Y := Y;
  end;
end;


procedure TsSlider.ButtonMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  OldState: boolean;
begin
  if Capturing then begin
    SkinData.CtrlSkinState := SkinData.CtrlSkinState and not ACS_FAST;
    OldState := FSliderOn;
    FButton.SkinData.BeginUpdate;
    Dragged := (ClickPoint.X <> X) or (ClickPoint.Y <> Y);
    if Orientation = coHorizontal then begin
      if (FButton.Left - ThumbMargin(asLeft) - (MouseDownSpot.X - X) > 0) and (FButton.Left - (MouseDownSpot.X - X) + FButton.Width < Width - ThumbMargin(asRight)) then begin
        FButton.Left := FButton.Left - (MouseDownSpot.X - X);
        if BtnInBeginning then begin
          if (FButton.Left > Width - FButton.Width - 3 - ThumbMargin(asRight)) and (OldState = FSliderOn) then
            SliderOn := not SliderOn;
        end
        else
          if FButton.Left < 3 + ThumbMargin(asLeft) then
            SliderOn := not SliderOn;
      end
      else
        if (FButton.Left - (MouseDownSpot.X - X) - ThumbMargin(asLeft) < 0) then begin
          if FButton.Left <> ThumbMargin(asLeft) then begin
            FButton.Left := ThumbMargin(asLeft);
            SliderOn := StateFromPos;
          end;
        end
        else
          if (FButton.Left - (MouseDownSpot.X - X) + FButton.Width > Width) then begin
            FButton.Left := Width - FButton.Width - ThumbMargin(asRight);
            SliderOn := StateFromPos;
          end;
    end
    else
      if (FButton.Top - ThumbMargin(asTop) - (MouseDownSpot.Y - Y) > 0) and (FButton.Top - (MouseDownSpot.Y - Y) + FButton.Height < Height - ThumbMargin(asBottom)) then begin
        FButton.Top := FButton.Top - (MouseDownSpot.Y - Y);
        if BtnInBeginning then begin
          if (FButton.Top > Height - FButton.Height - 3 - ThumbMargin(asBottom)) and (OldState = FSliderOn) then
            SliderOn := not SliderOn;
        end
        else
          if FButton.Top < 3 + ThumbMargin(asTop) then
            SliderOn := not SliderOn;
      end
      else
        if (FButton.Top - (MouseDownSpot.Y - Y) - ThumbMargin(asTop) < 0) then begin
          if FButton.Top <> ThumbMargin(asTop) then begin
            FButton.Top := ThumbMargin(asTop);
            SliderOn := StateFromPos;
          end;
        end
        else
          if (FButton.Top - (MouseDownSpot.Y - Y) + FButton.Height > Height) then begin
            FButton.Top := Height - FButton.Height - ThumbMargin(asBottom);
            SliderOn := StateFromPos;
          end;

    FButton.SkinData.BGChanged := True;
    FButton.SkinData.EndUpdate;
    FButton.Repaint;
  end;
end;


procedure TsSlider.ButtonMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Capturing then begin
    Capturing := False;
    SetFocus;
    if Dragged then
      SliderOn := StateFromPos
{      if Orientation = coHorizontal then
        if not Reversed then
          SliderOn := (FButton.Left < Round((Width - FButton.Width) * FThumbSizeInPercent / 100))
        else
          SliderOn := (FButton.Left > Round(FButton.Width * FThumbSizeInPercent / 100))
      else
        if not Reversed then
          SliderOn := (FButton.Top < Round((Height - FButton.Height) * FThumbSizeInPercent / 100))
        else
          SliderOn := (FButton.Top < Round(FButton.Height * FThumbSizeInPercent / 100))}
    else
      ChangeValueAnim;

    UpdateButton;
  end;
  Dragged := False;
end;


procedure TsSlider.ButtonPaint(Sender: TObject; Canvas: TCanvas);
var
  NCR: TRect;
  Bmp: TBitmap;
begin
  if CustomImageUsed then begin
    if not SkinData.Skinned then begin
      Bmp := CreateBmp32(FButton);
      BitBlt(Bmp.Canvas.Handle, 0, 0, FButton.Width, FButton.Height, SkinData.FCacheBmp.Canvas.Handle, FButton.Left, FButton.Top, SRCCOPY);
      Images.Draw(Bmp.Canvas, (FButton.Width - Images.Width) div 2, (FButton.Height - Images.Height) div 2, ThumbImgIndex);
      BitBlt(Canvas.Handle, 0, 0, FButton.Width, FButton.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
      Bmp.Free;
    end
    else
      Images.Draw(Canvas, (FButton.Width - Images.Width) div 2, (FButton.Height - Images.Height) div 2, ThumbImgIndex)
  end
  else begin
    if not SkinData.Skinned then begin
      NCR := MkRect(FButton);
      Frame3D(Canvas, NCR, clBtnHighlight, clBtnShadow, FButton.BevelWidth);
      FillDC(Canvas.Handle, NCR, FButton.Color);
    end;
    if {FShowCaption and }(ContentPlacing <> scpBackground) then
      PaintContent(MkRect(FButton), Canvas);
  end;
end;


function TsSlider.CustomImageUsed: boolean;
begin
  Result := (Images <> nil) and (ImageIndexOff >= 0) and (ImageIndexOn >= 0);
end;


function TsSlider.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
var
  cy, cx, h: integer;
begin
  if CustomImageUsed then begin
    NewWidth  := Images.Width;
    NewHeight := Images.Height;
  end
  else begin
    if Images <> nil then begin
      h := Images.Height;
      if Orientation = coHorizontal then begin
        cx := Images.Width + 2;
        cy := 0;
      end
      else begin
        cx := 0;
        cy := h + 2;
      end;
    end
    else begin
      cx := 0;
      cy := 0;
      h := 8;
    end;
    if FShowCaption then begin
      NewWidth := (cx + max(Canvas.TextWidth(SliderCaptionOff), Canvas.TextWidth(SliderCaptionOn)) + ContentMargin) * 2;
      NewHeight := (max(cy + Canvas.TextHeight(SliderCaptionOn), h) + ContentMargin);
    end
    else begin
      NewWidth := (cx + ContentMargin) * 2;
      NewHeight := h + ContentMargin;
    end;
  end;
  Result := True;
end;


function TsSlider.CanChange: boolean;
begin
  Result := True;
  if Assigned(FOnChanging) then
    FOnChanging(Self, Result);
end;


procedure TsSlider.ChangeValueAnim(DoChange: boolean = False);
var
  lTicks: DWord;
  ThumbPos: real;
  Flags: Cardinal;
  Target, i: integer;
  Bmp1, Bmp2: TBitmap;
  Skinned, Changed: boolean;
begin
  if CanChange then begin
    Skinned := SkinData.Skinned;
    Changed := DoChange;
    Flags := RDW_UPDATENOW or RDW_INVALIDATE{ or RDW_ERASE} or RDW_ALLCHILDREN;
    if Orientation = coHorizontal then begin
      if BtnInBeginning then
        Target := Width - FButton.Width - ThumbMargin(asRight)
      else
        Target := ThumbMargin(asLeft);

      if (SkinData.SkinManager = nil) or SkinData.SkinManager.Effects.AllowAnimation then begin
        ThumbPos := FButton.Left;
        if Skinned or CustomImageUsed then begin
          Bmp1 := CreateBmpLike(SkinData.FCacheBmp);
          Bmp2 := CreateBmpLike(SkinData.FCacheBmp);
          // Full paint
          if not Reversed and FSliderOn or Reversed and not FSliderOn then
            CopyBmp(Bmp2, SkinData.FCacheBmp)
          else
            CopyBmp(Bmp1, SkinData.FCacheBmp);

          FSliderOn := not FSliderOn;
          // Full paint
          SkinData.BGChanged := True;
          if Skinned then
            PrepareCache;

          if not Reversed and not FSliderOn or Reversed and FSliderOn then
            CopyBmp(Bmp1, SkinData.FCacheBmp)
          else
            CopyBmp(Bmp2, SkinData.FCacheBmp);

          while abs(ThumbPos - Target) > 0.1 do begin
            lTicks := GetTickCount;
            SetRedraw(Handle, 0);
            ThumbPos := ThumbPos - (ThumbPos - Target) / 4;
            FButton.SkinData.BGChanged := True;
            FButton.Left := Round(ThumbPos);
            i := FButton.Left + FButton.Width div 2;
            BitBlt(SkinData.FCacheBmp.Canvas.Handle, 0, 0, i, Bmp1.Height, Bmp1.Canvas.Handle, 0, 0, SRCCOPY);
            BitBlt(SkinData.FCacheBmp.Canvas.Handle, i, 0, Bmp2.Width - i, Bmp2.Height, Bmp2.Canvas.Handle, i, 0, SRCCOPY);
            if not Changed and (abs(ThumbPos - Target) < 1) and Skinned then begin
              Changed := True;
              if BtnInBeginning then begin
                if (FButton.SkinData.SkinSection <> s_Thumb_On) or Reversed then
                  UpdateThumbSkin(True);
              end
              else
                if (FButton.SkinData.SkinSection <> s_Thumb_Off) or Reversed then
                  UpdateThumbSkin(True);
            end;
            SetRedraw(Handle, 1);
            RedrawWindow(Handle, nil, 0, Flags);
            while lTicks + acTimerInterval > GetTickCount do ; // wait here
          end;
          Bmp1.Free;
          Bmp2.Free;
          SkinData.BGChanged := True;
          if Skinned then
            PrepareCache;
        end
        else begin
          FSliderOn := not FSliderOn;
          while abs(ThumbPos - Target) > 0.1 do begin
            lTicks := GetTickCount;
            ThumbPos := ThumbPos - (ThumbPos - Target) / 4;
            FButton.Left := Round(ThumbPos);
            RedrawWindow(Handle, nil, 0, Flags);
            while lTicks + acTimerInterval > GetTickCount do ; // wait here
          end;
        end;
        RedrawWindow(Handle, nil, 0, Flags);
      end
      else begin
        FButton.Left := Round(Target);
        FSliderOn := not FSliderOn;
        if BtnInBeginning then begin
          if (FButton.SkinData.SkinSection <> s_Thumb_On) or Reversed then begin
            UpdateThumbSkin(True);
            SkinData.BGChanged := True;
          end;
        end
        else
          if (FButton.SkinData.SkinSection <> s_Thumb_Off) or Reversed then begin
            UpdateThumbSkin(True);
            SkinData.BGChanged := True;
          end;

        RedrawWindow(Handle, nil, 0, Flags);
      end;
    end
    else begin
      if BtnInBeginning then
        Target := Height - FButton.Height - ThumbMargin(asBottom)
      else
        Target := ThumbMargin(asTop);

      ThumbPos := FButton.Top;
      while abs(ThumbPos - Target) > 0.4 do begin
        lTicks := GetTickCount;
        SendMessage(Handle, WM_SETREDRAW, 0, 0);
        ThumbPos := ThumbPos - (ThumbPos - Target) / 4;
        FButton.Top := Round(ThumbPos);
        if not Skinned then
          FButton.Repaint;

        if not Changed and (abs(ThumbPos - Target) < 1) then begin
          FSliderOn := not FSliderOn;
          Changed := True;
          if BtnInBeginning then begin
            if (FButton.SkinData.SkinSection <> s_Thumb_On) or Reversed then begin
              FButton.SkinData.Updating := True;
              FButton.SkinData.SkinSection := s_Thumb_On;
              FButton.SkinData.Updating := False;
              SkinData.BGChanged := True;
            end;
          end
          else
            if (FButton.SkinData.SkinSection <> s_Thumb_Off) or Reversed then begin
              FButton.SkinData.Updating := True;
              FButton.SkinData.SkinSection := s_Thumb_Off;
              FButton.SkinData.Updating := False;
              SkinData.BGChanged := True;
            end;
        end;
        SendMessage(Handle, WM_SETREDRAW, 1, 0);
        RedrawWindow(Handle, nil, 0, Flags);
        while lTicks + acTimerInterval > GetTickCount do ; // wait here
      end;
    end;
    UpdateButton;
    UpdateBtnFont;
    RedrawWindow(FButton.Handle, nil, 0, RDW_UPDATENOW or RDW_INVALIDATE or RDW_FRAME);// or RDW_ERASE);
    if Assigned(FOnSliderChange) then
      FOnSliderChange(Self);
  end;
end;


procedure TsSlider.Click;
begin
  inherited;
  ChangeValueAnim;
end;


function TsSlider.ContentRect: TRect;
var
  w: integer;
begin
  Result := ClientRect;
  w := BorderWidth + integer(BevelInner <> bvNone) * BevelWidth + integer(BevelOuter <> bvNone) * BevelWidth;
  InflateRect(Result, -w, -w);
  if FReversed and FSliderOn or not FReversed and not FSliderOn then // First rect
    if Orientation = coHorizontal then
      Result.Right := Width - FButton.Width + w
    else
      Result.Top := FButton.Top + FButton.Height + w
  else
    if Orientation = coHorizontal then
      Result.Left := FButton.Width - w
    else
      Result.Bottom := FButton.Top - w;
end;


constructor TsSlider.Create(AOwner: TComponent);
begin
  inherited;
  SkinData.COC := COC_TsSlider;
  FBoundLabel := TsBoundLabel.Create(Self, SkinData);
  FSliderOn := True;
  FShowCaption := True;
  FOrientation := coHorizontal;
  FUseSymbols := False;
  FSliderCursor := crDefault;
  TabStop := False;
  BevelOuter := bvLowered;
  Width := 57;
  Height := 21;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FThumbSizeInPercent := 50;
  FContentPlacing := scpThumb;
  FReversed := False;

  FGlyphIndexOff := -1;
  FGlyphIndexOn  := -1;
  FImageIndexOff := -1;
  FImageIndexOn  := -1;
  FThumbIndexOff := -1;
  FThumbIndexOn  := -1;

  FFontOn := TFont.Create;
  FFontOn.OnChange := FontOnChange;
  FFontOn.Height := 100;

  FButton := TsButtonPanel.Create(Self);
  FButton.Cursor := FSliderCursor;
  FButton.BevelOuter := bvNone;
  FButton.Parent := Self;
  FButton.Top := 1;
  FButton.TabStop := False;
  FButton.OnMouseDown := ButtonMouseDown;
  FButton.OnMouseMove := ButtonMouseMove;
  FButton.OnMouseUp   := ButtonMouseUp;
  FButton.OnPaint     := ButtonPaint;
  UpdateButton;
end;


destructor TsSlider.Destroy;
begin
  FreeAndNil(FBoundLabel);
  FButton.Free;
  FFontOn.Free;
  FreeAndNil(FImageChangeLink);
  inherited;
end;


procedure TsSlider.FontOnChange(Sender: TObject);
begin
  if SkinData.Skinned then
    SkinData.Invalidate
  else
    Repaint;

  UpdateSize;
end;


procedure TsSlider.ImageListChange(Sender: TObject);
begin
  if SkinData.Skinned then
    SkinData.Invalidate
  else
    Repaint;
end;


procedure TsSlider.Loaded;
begin
  inherited;
  ThumbOffsetX1 := 1;
  ThumbOffsetY1 := 1;
  ThumbOffsetX2 := 1;
  ThumbOffsetY2 := 1;
  UpdateButton;
  if FFontOn.Height = 100 then
    FFontOn.Assign(Font);

  UpdateBtnFont;
  FButton.OnClick := OnClick;
  if CustomImageUsed then
    BevelOuter := bvNone;
end;


procedure TsSlider.OurPaint(DC: HDC; SendUpdated: boolean);
begin
  if UpdateCount < 1 then begin
    SkinData.CtrlSkinState := SkinData.CtrlSkinState and not ACS_FAST;
    if not SkinData.Skinned and CustomImageUsed then begin
      SkinData.FCacheBmp.Width := Width;
      SkinData.FCacheBmp.Height := Height;
      FillDC(SkinData.FCacheBmp.Canvas.Handle, MkRect(Self), Color);
//      PaintItem(SkinData.SkinManager.ConstData.Sections[ssTransparent], GetParentCache(SkinData), False, 0, MkRect(Self), Point(Left, Top), SkinData.FCacheBMP, SkinData.SkinManager);
      Images.Draw(SkinData.FCacheBmp.Canvas, 0, 0, ifF(FSliderOn, FImageIndexOn, FImageIndexOff));
      BitBlt(DC, 0, 0, Width, Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
    end
    else
      inherited;

    if not SkinData.Skinned and (ContentPlacing = scpBackground) then
      PaintContent(ContentRect, Canvas);
  end;
end;


procedure TsSlider.PaintContent(R: TRect; aCanvas: TCanvas);
const
  cMargin = 2;
var
  x, y, Ndx, w, h: integer;
  rPercent: real;
  sa: AnsiString;
  s: acString;
begin
  x := R.Left;
  y := R.Top;
  w := WidthOf(R);
  h := HeightOf(R);
  if not SkinData.CustomFont and SkinData.Skinned then
    if (ContentPlacing = scpThumb) then
      Ndx := FButton.SkinData.SkinIndex
    else
      Ndx := SkinData.SkinIndex
  else
    Ndx := -1;

  if FUseSymbols then begin
    aCanvas.Font.Name := 'Windings';
    aCanvas.Font.Charset := SYMBOL_CHARSET;
    aCanvas.Font.Size := min(w, h) - 2;
    if FSliderOn then
      sa := #$FC
    else
      sa := #$FB;

    if Ndx >= 0 then
      aCanvas.Font.Color := SkinData.SkinManager.gd[Ndx].Props[0].FontColor.Color
    else
      if FSliderOn then
        aCanvas.Font.Color := FontOn.Color
      else
        aCanvas.Font.Color := Font.Color;

    SetBkMode(aCanvas.Handle, Transparent);
    DrawTextA(aCanvas.Handle, PAnsiChar(sa), 1, R, DT_CENTER or DT_VCENTER or DT_SINGLELINE);
  end
  else begin
    if FShowCaption then
      if FSliderOn then begin
        s := FSliderCaptionOn;
        if s <> '' then begin
          SelectObject(aCanvas.Handle, FontOn.Handle);
          aCanvas.Font.Assign(FontOn);
        end;
      end
      else begin
        s := FSliderCaptionOff;
        if s <> '' then begin
          SelectObject(aCanvas.Handle, Font.Handle);
          aCanvas.Font.Assign(Font);
        end;
      end
    else
      s := '';

    if (Images <> nil) and (GlyphIndexOff >= 0) and (GlyphIndexOn >= 0) then begin
      rPercent := FThumbSizeInPercent / 100;
      if Orientation = coHorizontal then begin
        if s = '' then
          x := R.Left + Round((w - Images.Width) * rPercent);

        Images.Draw(aCanvas, x, Round((h - Images.Height) * rPercent), iff(FSliderOn, GlyphIndexOn, GlyphIndexOff));
        inc(x, Images.Width + 2);
      end
      else begin
        Images.Draw(aCanvas, R.Left + Round((w - Images.Width) * rPercent), y, iff(FSliderOn, GlyphIndexOn, GlyphIndexOff));
        inc(y, Images.Height + 2);
      end;
    end;

    if (s <> '') then begin
      R.Left := x;
      R.Top := y;
      acWriteTextEx(aCanvas, PacChar(s), Enabled, R, DT_CENTER or DT_VCENTER or DT_SINGLELINE, Ndx, False, SkinData.SkinManager);
    end;
  end;
end;


function TsSlider.PrepareCache: boolean;

  function ImageIndex: integer;
  begin
    if FSliderOn then
      Result := FImageIndexOn
    else
      Result := FImageIndexOff;
  end;

begin
  SkinData.UpdateIndexes;
  InitCacheBmp(SkinData);
  if CustomImageUsed then begin
    if SkinData.SkinManager.Active then
      PaintItem(SkinData.SkinManager.ConstData.Sections[ssTransparent], GetParentCache(SkinData), False, 0, MkRect(Self), Point(Left, Top), SkinData.FCacheBMP, SkinData.SkinManager)
    else
      FillDC(SkinData.FCacheBmp.Canvas.Handle, MkRect(Self), ColorToRGB(Color));

    Images.Draw(SkinData.FCacheBmp.Canvas, 0, 0, ImageIndex);
  end
  else
    PaintItem(SkinData.SkinIndex, GetParentCache(SkinData), True, 0, MkRect(Self), Point(Left, Top), SkinData.FCacheBMP, SkinData.SkinManager);

  if {FShowCaption and }(ContentPlacing = scpBackground) then
    PaintContent(ContentRect, SkinData.FCacheBmp.Canvas);

  SkinData.PaintOuterEffects(Self, MkPoint);
  if Assigned(OnPaint) then
    OnPaint(Self, SkinData.FCacheBmp.Canvas);

  if DockSite then
    PaintDragPanel(SkinData.FCacheBmp.Canvas.Handle);

  SkinData.BGChanged := False;
  Result := True;
end;


procedure TsSlider.SetFontOn(const Value: TFont);
begin
  FontOn.Assign(Value);
end;


procedure TsSlider.SetImageIndex(const Index: Integer; const Value: TImageIndex);
begin
  case Index of
    0: if FGlyphIndexOff <> Value then begin
      FGlyphIndexOff := Value;
      SkinData.Invalidate;
    end;

    1: if FGlyphIndexOn <> Value then begin
      FGlyphIndexOn := Value;
      SkinData.Invalidate;
    end;

    2: if FImageIndexOff <> Value then begin
      FImageIndexOff := Value;
      UpdateButton;
    end;

    3: if FImageIndexOn <> Value then begin
      FImageIndexOn := Value;
      UpdateButton;
    end;

    4: if FThumbIndexOff <> Value then begin
      FThumbIndexOff := Value;
      UpdateButton;
    end;

    5: if FThumbIndexOn <> Value then begin
      FThumbIndexOn := Value;
      UpdateButton;
    end;
  end;
end;


procedure TsSlider.SetImages(const Value: TCustomImageList);
begin
  if Images <> Value then begin
    if Images <> nil then
      Images.UnRegisterChanges(FImageChangeLink);

    FImages := Value;
    if Images <> nil then begin
      Images.RegisterChanges(FImageChangeLink);
      Images.FreeNotification(Self);
      AdjustSize;
      UpdateButton;
    end;
    if (Visible or (csDesigning in ComponentState)) and (SkinData.CtrlSkinState and ACS_LOCKED <> ACS_LOCKED) then begin
      UpdateSize;
      SkinData.Invalidate;
    end;
  end;
end;


procedure TsSlider.SetOrientation(const Value: TControlOrientation);
begin
  if FOrientation <> Value then begin
    FOrientation := Value;
    UpdateButton;
  end;
end;


procedure TsSlider.SetSliderCaptionOff(const Value: acString);
begin
  if FSliderCaptionOff <> Value then begin
    FSliderCaptionOff := Value;
    UpdateSize;
    SkinData.Invalidate;
  end;
end;


procedure TsSlider.SetThumbSection(const Value: String);
begin
  if FThumbSection <> Value then begin
    FThumbSection := Value;
    UpdateButton;
    SkinData.Invalidate;
  end;
end;


procedure TsSlider.SetSliderCaptionOn(const Value: acString);
begin
  if FSliderCaptionOn <> Value then begin
    FSliderCaptionOn := Value;
    UpdateSize;
    SkinData.Invalidate;
  end;
end;


procedure TsSlider.SetSliderCursor(const Value: TCursor);
begin
  if FSliderCursor <> Value then begin
    FSliderCursor := Value;
    if FButton <> nil then
      FButton.Cursor := Value;
  end;
end;


procedure TsSlider.SetContentPlacing(const Value: TSliderContentPlacing);
begin
  if FContentPlacing <> Value then begin
    FContentPlacing := Value;
    UpdateButton;
    SkinData.Invalidate;
  end;
end;


procedure TsSlider.SetThumbSizeInPercent(const Value: TPercent);
begin
  if FThumbSizeInPercent <> Value then begin
    FThumbSizeInPercent := Value;
    UpdateButton;
    SkinData.Invalidate;
  end;
end;


function TsSlider.StateFromPos: boolean;
begin
  if Orientation = coHorizontal then
    if not Reversed then
      Result := (FButton.Left < Round((Width - FButton.Width) * FThumbSizeInPercent / 100) - ThumbMargin(asRight))
    else
      Result := (FButton.Left > Round(FButton.Width * FThumbSizeInPercent / 100) + ThumbMargin(asLeft))
  else
    if not Reversed then
      Result := (FButton.Top < Round((Height - FButton.Height) * FThumbSizeInPercent / 100) - ThumbMargin(asBottom))
    else
      Result := (FButton.Top < Round(FButton.Height * FThumbSizeInPercent / 100) + ThumbMargin(asTop))
end;


function TsSlider.ThumbImgIndex: integer;
begin
  if FSliderOn then
    Result := FThumbIndexOn
  else
    Result := FThumbIndexOff;
end;


function TsSlider.ThumbSize: TSize;
begin
  if Orientation = coHorizontal then
    Result := MkSize(Round(Width * FThumbSizeInPercent / 100), Height - integer(ThumbImgIndex < 0) * 2)
  else
    Result := MkSize(Width - integer(ThumbImgIndex < 0) * 2, Round(Height * FThumbSizeInPercent / 100))
end;


procedure TsSlider.UpdateBtnFont;
begin
  if FSliderOn then begin
    FButton.SkinData.CustomFont := True;
    FButton.Font.Assign(FontOn);
  end
  else begin
    FButton.SkinData.CustomFont := SkinData.CustomFont;
    FButton.Font.Assign(Font);
  end;
end;


procedure TsSlider.UpdateButton;
begin
  if Orientation = coHorizontal then begin
    FButton.Width := Round(Width * FThumbSizeInPercent / 100);
    FButton.Height := Height - ThumbMargin(asTop) - ThumbMargin(asBottom);
    if not Capturing then
      if BtnInBeginning then
        FButton.Left := ThumbMargin(asLeft)
      else
        FButton.Left := Width - FButton.Width - ThumbMargin(asRight);

    FButton.Top := ThumbMargin(asTop);
  end
  else begin
    FButton.Width := Width - ThumbMargin(asLeft) - ThumbMargin(asRight);
    FButton.Height := Round(Height * FThumbSizeInPercent / 100);
    FButton.Left := ThumbMargin(asLeft);
    if not Capturing then
      if BtnInBeginning then
        FButton.Top := ThumbMargin(asTop)
      else
        FButton.Top := Height - FButton.Height - ThumbMargin(asBottom);
  end;
  FButton.SkinData.BGChanged := True;
  UpdateThumbSkin;
end;


procedure TsSlider.UpdateSize;
begin
  if AutoSize then begin
    AdjustSize;
    UpdateButton;
  end;
end;


procedure TsSlider.UpdateThumbSkin(SetUpdating: boolean = False);
begin
  if SetUpdating then
    FButton.SkinData.Updating := True;

  if (Images <> nil) and (ThumbImgIndex >= 0) then
    FButton.SkinData.SkinSection := s_CheckBox
  else
    if FThumbSection <> '' then
      FButton.SkinData.SkinSection := FThumbSection
    else begin
      FButton.SkinData.SkinSection := iff(SliderOn, s_Thumb_On, s_Thumb_Off);
      if FButton.SkinData.SkinIndex < 0 then
        FButton.SkinData.SkinSection := s_Panel;
    end;

  FButton.SkinData.CtrlSkinState := FButton.SkinData.CtrlSkinState and not ACS_FAST;
  if SetUpdating then
    FButton.SkinData.Updating := False;
end;


procedure TsSlider.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_GETDEFINDEX: begin
          if SkinData.SkinManager <> nil then
            Message.Result := SkinData.SkinManager.GetSkinIndex(iff(SliderOn, s_Slider_On, s_Slider_Off)) + 1;
            if Message.Result <= 0 then
              Message.Result := SkinData.SkinManager.ConstData.Sections[ssPanelLow] + 1;

          Exit;
        end;

        AC_GETBG: begin
          PacBGInfo(Message.LParam).BgType := btCache;
          PacBGInfo(Message.LParam).Bmp    := SkinData.FCacheBmp;
          PacBGInfo(Message.LParam).Offset := Point(0, 0);
          Exit;
        end;

        AC_REFRESH: begin
          inherited;
          UpdateButton;
          Exit;
        end;

        AC_SETCHANGEDIFNECESSARY: begin
          SkinData.BGChanged := True;
          FButton.SkinData.BGChanged := True;
          if (Message.WParamLo = 1) then
            RedrawWindow(Handle, nil, 0, RDW_NOERASE + RDW_NOINTERNALPAINT + RDW_INVALIDATE + RDW_ALLCHILDREN);

          Exit;
        end;

        AC_REMOVESKIN: begin
          inherited;
          FButton.Color := clBtnFace;
          Exit;
        end;
      end;

    WM_GETTEXTLENGTH: begin
      Message.Result := 0;
      Exit;
    end;

    WM_PAINT:
      SkinData.CtrlSkinState := SkinData.CtrlSkinState and not ACS_FAST;

    WM_ERASEBKGND:
      if SkinData.Skinned then
        Exit;

    WM_SIZE:
      if CustomImageUsed then begin
        Width := Images.Width;
        Height := Images.Height;
        UpdateButton;
        Exit;
      end;
  end;
  inherited;
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_SETNEWSKIN:
          UpdateThumbSkin;
      end;

    WM_SIZE: 
      UpdateButton;
  end;

  if Assigned(BoundLabel) then
    BoundLabel.HandleOwnerMsg(Message, Self);
end;


procedure TsSlider.SetBoolean(const Index: Integer; const Value: boolean);
begin
  case Index of
    0: if FReversed <> Value then begin
      FReversed := Value;
      UpdateButton;
      SkinData.Invalidate;
    end;

    1: if FShowCaption <> Value then begin
      FShowCaption := Value;
      UpdateButton;
      SkinData.Invalidate;
    end;

    2: if (FSliderOn <> Value) and CanChange then begin
      SkinData.BeginUpdate;
      FSliderOn := Value;
      UpdateButton;
      UpdateBtnFont;
      SkinData.UpdateIndexes;
      SkinData.CtrlSkinState := SkinData.CtrlSkinState and not ACS_FAST;
      SkinData.EndUpdate;
      if not (csLoading in ComponentState) then begin
        SkinData.BGChanged := True;
        RedrawWindow(Handle, nil, 0, RDW_UPDATENOW or RDW_INVALIDATE or RDW_ALLCHILDREN);
      end;
      if Assigned(FOnSliderChange) then begin
        FOnSliderChange(Self);
        if GetCapture <> Handle then begin
          Dragged := False;
          Capturing := False;
          UpdateButton;
        end;
      end;
    end;

    3: if FUseSymbols <> Value then begin
      FUseSymbols := Value;
      UpdateButton;
      SkinData.Invalidate;
    end;
  end;
end;


procedure TsSlider.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = Images) then
    Images := nil;
end;


procedure TsSlider.BeginUpdate;
begin
  inc(UpdateCount);
end;


procedure TsSlider.EndUpdate(DoRepaint: boolean);
begin
  dec(UpdateCount);
  if DoRepaint then
    Repaint;
end;


procedure TsButtonPanel.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_PAINT: begin
      SkinData.CtrlSkinState := SkinData.CtrlSkinState and not ACS_FAST;
      inherited;
    end;

    WM_NCPAINT, WM_ERASEBKGND:

    else
      inherited;
  end;
end;


function TsSlider.ThumbMargin(Side: TacSide): integer;
begin
  if (Images <> nil) and (ThumbImgIndex >= 0) then // If custome images used
    case Side of
      asLeft:   Result := ThumbOffsetX1;
      asTop:    Result := ThumbOffsetY1;
      asRight:  Result := ThumbOffsetX2
      else      Result := ThumbOffsetY2
    end
  else
    if SkinData.Skinned then
      Result := SkinData.SkinManager.CommonSkinData.SliderMargin
    else
      Result := 1;
end;

end.
