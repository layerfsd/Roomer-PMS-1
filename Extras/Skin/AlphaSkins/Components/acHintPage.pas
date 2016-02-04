unit acHintPage;
{$I sDefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, ComCtrls, ExtCtrls, ExtDlgs, Dialogs, Buttons, 
  {$IFDEF DELPHI6} Variants, {$ENDIF}
  {$IFDEF DELPHI7UP} Types, {$ENDIF}
  sSpeedButton, sScrollBox, sFrameAdapter, sLabel, sTrackBar, sPageControl, sRadioButton, sGroupBox, acAlphaHints, sPanel,
  sEdit, sSpinEdit;


type
  TFrameHintPage = class(TFrame)
    sScrollBox1: TsScrollBox;
    sFrameAdapter1: TsFrameAdapter;
    PaintBox1: TPaintBox;
    OpenPictureDialog1: TOpenPictureDialog;
    sGroupBox2: TsGroupBox;
    sTrackBar1: TsTrackBar;
    sTrackBar4: TsTrackBar;
    sTrackBar6: TsTrackBar;
    sTrackBar8: TsTrackBar;
    sLabel14: TsLabel;
    sLabel19: TsLabel;
    sLabel2: TsLabel;
    sLabel9: TsLabel;
    sGroupBox3: TsGroupBox;
    sTrackBar2: TsTrackBar;
    sTrackBar3: TsTrackBar;
    sTrackBar5: TsTrackBar;
    sTrackBar7: TsTrackBar;
    sLabel4: TsLabel;
    sLabel10: TsLabel;
    sLabel15: TsLabel;
    sLabel20: TsLabel;
    sGroupBox4: TsGroupBox;
    sGroupBox5: TsPanel;
    sRadioButton1: TsRadioButton;
    sRadioButton2: TsRadioButton;
    sGroupBox6: TsPanel;
    sRadioButton3: TsRadioButton;
    sRadioButton4: TsRadioButton;
    sLabel26: TsLabel;
    sLabel27: TsLabel;
    sLabel28: TsLabel;
    sLabel29: TsLabel;
    sLabel30: TsLabel;
    sLabel31: TsLabel;
    sLabel32: TsLabel;
    sLabel33: TsLabel;
    sPanel1: TsPanel;
    sPanel2: TsPanel;
    sRadioButton5: TsRadioButton;
    sRadioButton6: TsRadioButton;
    sLabel34: TsLabel;
    sLabel35: TsLabel;
    sLabel36: TsLabel;
    sLabel37: TsLabel;
    sRadioButton7: TsRadioButton;
    sRadioButton8: TsRadioButton;
    sPanel3: TsPanel;
    sRadioButton9: TsRadioButton;
    sRadioButton10: TsRadioButton;
    sLabel38: TsLabel;
    sGroupBox7: TsGroupBox;
    sLabel1: TsLabel;
    sLabel3: TsLabel;
    sLabel5: TsLabel;
    sLabel6: TsLabel;
    sLabel7: TsLabel;
    sLabel8: TsLabel;
    sLabel11: TsLabel;
    sLabel12: TsLabel;
    sTrackBar9: TsTrackBar;
    sTrackBar10: TsTrackBar;
    sTrackBar11: TsTrackBar;
    sTrackBar12: TsTrackBar;
    sSpeedButton3: TsSpeedButton;
    sLabel21: TsLabel;
    sLabel23: TsLabel;
    sLabel22: TsLabel;
    sLabel24: TsLabel;
    sSpinEdit1: TsSpinEdit;
    sSpinEdit2: TsSpinEdit;
    sSpeedButton1: TsSpeedButton;
    sSpeedButton2: TsSpeedButton;
    sSpeedButton4: TsSpeedButton;
    procedure PaintBox1Paint(Sender: TObject);
    procedure sSpeedButton3Click(Sender: TObject);
    procedure sRadioButton1Click(Sender: TObject);
    procedure sRadioButton2Click(Sender: TObject);
    procedure sRadioButton3Click(Sender: TObject);
    procedure sRadioButton4Click(Sender: TObject);
    procedure sRadioButton5Click(Sender: TObject);
    procedure sRadioButton6Click(Sender: TObject);
    procedure sRadioButton7Click(Sender: TObject);
    procedure sRadioButton8Click(Sender: TObject);
    procedure sRadioButton9Click(Sender: TObject);
    procedure sRadioButton10Click(Sender: TObject);
    procedure sTrackBar9Change(Sender: TObject);
    procedure sTrackBar10Change(Sender: TObject);
    procedure sTrackBar11Change(Sender: TObject);
    procedure sTrackBar12Change(Sender: TObject);
    procedure sTrackBar2Change(Sender: TObject);
    procedure sTrackBar3Change(Sender: TObject);
    procedure sTrackBar5Change(Sender: TObject);
    procedure sTrackBar7Change(Sender: TObject);
    procedure sTrackBar1Change(Sender: TObject);
    procedure sTrackBar4Change(Sender: TObject);
    procedure sTrackBar6Change(Sender: TObject);
    procedure sTrackBar8Change(Sender: TObject);
    procedure sSpinEdit1Change(Sender: TObject);
    procedure sSpinEdit2Change(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
  protected
    procedure ChangeProperty(ABordersSizes: TacBordersSizes; Index: integer; ATrackBar: TsTrackBar; ALabel: TsLabel);
  public
    Image: TacHintImage;
    procedure LoadImage(Img: TacHintImage; Repaint: boolean = True);
    function CreatePreviewBmp(const Width, Height: integer): TBitmap;
    function CreateAlphaBmp: TBitmap;
    procedure UpdateData(Repaint: boolean = True);
    procedure RefreshPaintBox;
    procedure WndProc(var Message: TMessage); override;
  end;


var
  acUpdating: boolean = False;
  acPreviewScale: integer = 0;


implementation

uses math, sAlphaGraph, acAlphaHintsEdit, sGraphUtils, sConst, sVCLUtils, acPNG, sSkinProvider, acntUtils;

{$R *.dfm}

procedure TFrameHintPage.LoadImage(Img: TacHintImage; Repaint: boolean = True);
begin
  Image := Img;
  UpdateData(Repaint);
end;


procedure TFrameHintPage.sTrackBar9Change(Sender: TObject); // Shadow left
begin
  if Image <> nil then begin
    if not acUpdating then Image.ShadowSizes.Left := TsTrackBar(Sender).Position;
    sLabel1.Caption := IntToStr(TsTrackBar(Sender).Position);
  end;
end;


procedure TFrameHintPage.sTrackBar10Change(Sender: TObject);
begin
  if Image <> nil then begin
    if not acUpdating then Image.ShadowSizes.Top := TsTrackBar(Sender).Position;
    sLabel3.Caption := IntToStr(TsTrackBar(Sender).Position);
  end;
end;


procedure TFrameHintPage.sTrackBar11Change(Sender: TObject);
begin
  if Image <> nil then begin
    if not acUpdating then Image.ShadowSizes.Right := TsTrackBar(Sender).Position;
    sLabel5.Caption := IntToStr(TsTrackBar(Sender).Position);
  end;
end;


procedure TFrameHintPage.sTrackBar12Change(Sender: TObject);
begin
  if Image <> nil then begin
    if not acUpdating then Image.ShadowSizes.Bottom := TsTrackBar(Sender).Position;
    sLabel6.Caption := IntToStr(TsTrackBar(Sender).Position);
  end;
end;


function TFrameHintPage.CreatePreviewBmp(const Width, Height: integer): TBitmap;
const
  SqSize = 8;
  SqColor = $cccccc;
var
  X, Y, dx, dy, i: integer;
  R: TRect;
begin
  Result := CreateBmp32(Width, Height);
  i := 0;
  X := 0;
  dx := Width div SqSize + 1;
  dy := Height div SqSize + 1;
  while X < dx do begin
    i := integer(i = 0);
    Y := i;
    while Y < dy do begin
      R.Left := X * SqSize;
      R.Top := Y * SqSize;
      R.Right := R.Left + SqSize;
      R.Bottom := R.Top + SqSize;
      FillDC(Result.Canvas.Handle, R, SqColor);
      inc(Y, 2);
    end;
    inc(X);
  end;
end;


procedure TFrameHintPage.PaintBox1Paint(Sender: TObject);
var
  SrcBmp: TBitmap;
  X, Y: integer;
  BorderColor: TsColor;
  R: TRect;

  procedure PaintCtrl;
  const
    Size = 31;
  var
    R: TRect;
  begin
    if Image = Image.FOwner.ImageDefault then
      if Image.FOwner.HintAlign = haHorzCenter then
        R.TopLeft := Point(X - Size div 2, Y - Size)
      else
        R.TopLeft := Point(X - Size, Y - Size div 2)

    else
      if Image = Image.FOwner.Img_RightTop then
        if Image.FOwner.HintAlign = haHorzCenter then
          R.TopLeft := Point(X + SrcBmp.Width - Size div 2, Y - Size)
        else
          R.TopLeft := Point(X + SrcBmp.Width, Y - Size div 2)
      else
        if Image = Image.FOwner.Img_RightBottom then
          if Image.FOwner.HintAlign = haHorzCenter then
            R.TopLeft := Point(X + SrcBmp.Width - Size div 2, Y + SrcBmp.Height)
          else
            R.TopLeft := Point(X + SrcBmp.Width, Y + SrcBmp.Height - Size div 2)
        else
          if Image.FOwner.HintAlign = haHorzCenter then
            R.TopLeft := Point(X - Size div 2, Y + SrcBmp.Height)
          else
            R.TopLeft := Point(X - Size, Y + SrcBmp.Height -Size div 2);

    dec(R.Left, Image.OffsetHorz); // yello
    dec(R.Top,  Image.OffsetVert);

    R.Right := R.Left + Size;
    R.Bottom := R.Top + Size;
    PreviewBmp.Canvas.Brush.Color := clWhite;
    PreviewBmp.Canvas.Pen.Style := psSolid;
    PreviewBmp.Canvas.Pen.Color := 0;
    PreviewBmp.Canvas.Pen.Width := 1;
    PreviewBmp.Canvas.Rectangle(R);
    PreviewBmp.Canvas.Pen.Color := clSilver;

    PreviewBmp.Canvas.MoveTo(R.Left + Size div 2, R.Top + 1);
    PreviewBmp.Canvas.LineTo(R.Left + Size div 2, R.Bottom - 1);
    PreviewBmp.Canvas.MoveTo(R.Left  + 1, R.Top + Size div 2);
    PreviewBmp.Canvas.LineTo(R.Right - 1, R.Top + Size div 2);
  end;

begin
  if PreviewBmp = nil then begin
    PreviewBmp := CreatePreviewBmp(PaintBox1.Width, PaintBox1.Height);
    if (CurrentTemplate <> nil) and (Image.Image <> nil) then begin
      if Image.Image.Empty and (Image.FImageData.Size <> 0) then
        Image.Image.LoadFromStream(Image.FImageData);

      if not Image.Image.Empty then begin
        SrcBmp := CreateAlphaBmp;
        X := (PaintBox1.Width  - SrcBmp.Width)  div 2;
        Y := (PaintBox1.Height - SrcBmp.Height) div 2;
        PaintCtrl;
        CopyBmp32(Rect(X, Y, X + SrcBmp.Width, Y + SrcBmp.Height), MkRect(SrcBmp), PreviewBmp, SrcBmp, EmptyCI, False, clNone, 0, False);
        BorderColor.C := 0;

        if sTrackBar1.Focused then
          FadeBmp(PreviewBmp, Rect(X, Y, X + Image.BordersWidths.Left, Y + SrcBmp.Height), 50, BorderColor, 0, 0)
        else
          if sTrackBar4.Focused then
            FadeBmp(PreviewBmp, Rect(X, Y, X + SrcBmp.Width, Y + Image.BordersWidths.Top), 50, BorderColor, 0, 0)
          else
            if sTrackBar6.Focused then
              FadeBmp(PreviewBmp, Rect(X + SrcBmp.Width - Image.BordersWidths.Right, Y, X + SrcBmp.Width, Y + SrcBmp.Height), 50, BorderColor, 0, 0)
            else
              if sTrackBar8.Focused then
                FadeBmp(PreviewBmp, Rect(X, Y + SrcBmp.Height - Image.BordersWidths.Bottom, X + SrcBmp.Width, Y + SrcBmp.Height), 50, BorderColor, 0, 0);

        if sTrackBar9.Focused then
          FadeBmp(PreviewBmp, Rect(X, Y, X + Image.ShadowSizes.Left, Y + SrcBmp.Height), 50, BorderColor, 0, 0)
        else
          if sTrackBar10.Focused then
            FadeBmp(PreviewBmp, Rect(X, Y, X + SrcBmp.Width, Y + Image.ShadowSizes.Top), 50, BorderColor, 0, 0)
          else
            if sTrackBar11.Focused then
              FadeBmp(PreviewBmp, Rect(X + SrcBmp.Width - Image.ShadowSizes.Right, Y, X + SrcBmp.Width, Y + SrcBmp.Height), 50, BorderColor, 0, 0)
            else
              if sTrackBar12.Focused then
                FadeBmp(PreviewBmp, Rect(X, Y + SrcBmp.Height - Image.ShadowSizes.Bottom, X + SrcBmp.Width, Y + SrcBmp.Height), 50, BorderColor, 0, 0);

        FreeAndNil(SrcBmp);
      end;
    end;
  end;
  if acPreviewScale > 0 then begin
    R.TopLeft := Point(PreviewBmp.Width div 2 - PreviewBmp.Width div (4 * acPreviewScale), PreviewBmp.Height div 2 - PreviewBmp.Height div (4 * acPreviewScale));
    R.Right  := R.Left + PreviewBmp.Width div (2 * acPreviewScale);
    R.Bottom := R.Top + PreviewBmp.Height div (2 * acPreviewScale);
    SetStretchBltMode(PreviewBmp.Canvas.Handle, COLORONCOLOR);
    StretchBlt(PaintBox1.Canvas.Handle, 0, 0, PaintBox1.Width, PaintBox1.Height, PreviewBmp.Canvas.Handle,
               R.Left, R.Top, WidthOf(R), HeightOf(R), SRCCOPY);

  end
  else
    BitBlt(PaintBox1.Canvas.Handle, 0, 0, PaintBox1.Width, PaintBox1.Height, PreviewBmp.Canvas.Handle, 0, 0, SRCCOPY);
end;


function TFrameHintPage.CreateAlphaBmp: TBitmap;
const
  PreviewText = 'Hint preview';
var
  TempBmp: TBitmap;
  b: boolean;
begin
  Result := CreateBmp32;
  Result.Canvas.Font.Assign(CurrentTemplate.Font);
  Result.Width  := Result.Canvas.TextWidth (PreviewText);
  Result.Height := Result.Canvas.TextHeight(PreviewText);
  Result.Width  := max(Result.Width  + Image.ClientMargins.Left + Image.ClientMargins.Right, Image.BordersWidths.Left + Image.BordersWidths.Right);
  Result.Height := max(Result.Height + Image.ClientMargins.Top  + Image.ClientMargins.Bottom, Image.BordersWidths.Top + Image.BordersWidths.Bottom);

  PaintControlByTemplate(Result, Image.Image, MkRect(Result), MkRect(Image.Image),
      Rect(Image.BordersWidths.Left, Image.BordersWidths.Top, Image.BordersWidths.Right, Image.BordersWidths.Bottom),
      Rect(MaxByte, MaxByte, MaxByte, MaxByte),
      Rect(ord(Image.BorderDrawModes.Left), ord(Image.BorderDrawModes.Top), ord(Image.BorderDrawModes.Right), ord(Image.BorderDrawModes.Bottom)), boolean(ord(Image.BorderDrawModes.Center)));

  TempBmp := TBitmap.Create;
  TempBmp.Assign(Result);
  Result.Canvas.Brush.Style := bsClear;
  Result.Canvas.Font.Assign(CurrentTemplate.Font);
  if sFrameAdapter1.SkinData.Skinned then begin
    b := sFrameAdapter1.SkinData.SkinManager.Options.ChangeSysColors;
    sFrameAdapter1.SkinData.SkinManager.Options.ChangeSysColors := False;
    SetTextColor(Result.Canvas.Handle, Cardinal(ColorToRGB(CurrentTemplate.Font.Color)));
    sFrameAdapter1.SkinData.SkinManager.Options.ChangeSysColors := b;
  end;
  Result.Canvas.TextOut(Image.ClientMargins.Left, Image.ClientMargins.Top, PreviewText);
  CopyChannel32(Result, TempBmp, 3);
  FreeAndNil(TempBmp);
end;


procedure TFrameHintPage.UpdateData(Repaint: boolean = True);
var
  w, h: integer;
begin
  if not acUpdating then begin
    acUpdating := True;
    if not (AlphaHintsEdit.ActiveControl is TsRadioButton) then
      if (Image <> nil) then begin
        if Image.Image.Empty and (Image.FImageData.Size <> 0) then
          Image.Image.LoadFromStream(Image.FImageData);

        if not Image.Image.Empty then begin
          w := Image.ImageWidth;
          h := Image.ImageHeight;
          sLabel23.Caption := IntToStr(w);
          sLabel24.Caption := IntToStr(h);

          sTrackBar1.Max := w - 1;
          sTrackBar6.Max := sTrackBar1.Max;
          sTrackBar2.Max := sTrackBar1.Max;
          sTrackBar5.Max := sTrackBar1.Max;

          sTrackBar3.Max := h - 1;
          sTrackBar4.Max := sTrackBar3.Max;
          sTrackBar7.Max := sTrackBar3.Max;
          sTrackBar8.Max := sTrackBar3.Max;

          sSpinEdit1.Value := Image.OffsetHorz;
          sSpinEdit2.Value := Image.OffsetVert;

          // Border width
          if Image.BordersWidths.Left + Image.BordersWidths.Top + Image.BordersWidths.Right + Image.BordersWidths.Bottom = 0 then begin // First init
            Image.BordersWidths.Left := w div 2;
            Image.BordersWidths.Right := Image.BordersWidths.Left;
            Image.BordersWidths.Top := h div 2;
            Image.BordersWidths.Bottom := Image.BordersWidths.Top;
          end;
          sTrackBar1.Position := Image.BordersWidths.Left;
          sTrackBar4.Position := Image.BordersWidths.Top;
          sTrackBar6.Position := Image.BordersWidths.Right;
          sTrackBar8.Position := Image.BordersWidths.Bottom;

          // Drawing modes
          if Image.BorderDrawModes.Left   = dmRepeat then sRadioButton1.Checked := True else sRadioButton2.Checked  := True;
          if Image.BorderDrawModes.Top    = dmRepeat then sRadioButton3.Checked := True else sRadioButton4.Checked  := True;
          if Image.BorderDrawModes.Right  = dmRepeat then sRadioButton5.Checked := True else sRadioButton6.Checked  := True;
          if Image.BorderDrawModes.Bottom = dmRepeat then sRadioButton7.Checked := True else sRadioButton8.Checked  := True;
          if Image.BorderDrawModes.Center = dmRepeat then sRadioButton9.Checked := True else sRadioButton10.Checked := True;

          // Margins
          if Image.ClientMargins.Left + Image.ClientMargins.Top + Image.ClientMargins.Right + Image.ClientMargins.Bottom = 0 then begin // First init
            Image.ClientMargins.Left := w div 2;
            Image.ClientMargins.Right := Image.ClientMargins.Left;
            Image.ClientMargins.Top := h div 2;
            Image.ClientMargins.Bottom := Image.ClientMargins.Top;
          end;
          sTrackBar2.Position := Image.ClientMargins.Left;
          sTrackBar3.Position := Image.ClientMargins.Top;
          sTrackBar5.Position := Image.ClientMargins.Right;
          sTrackBar7.Position := Image.ClientMargins.Bottom;

          // Shadows
          sTrackBar9 .Position := Image.ShadowSizes.Left;
          sTrackBar10.Position := Image.ShadowSizes.Top;
          sTrackBar11.Position := Image.ShadowSizes.Right;
          sTrackBar12.Position := Image.ShadowSizes.Bottom;

          if AlphaHintsEdit.FrameTL = Self then
            ChangeStates(Self, 1, True);

          ChangeStates(Self, 2, not Image.Image.Empty);
        end;
      end
      else begin
        sLabel23.Caption := ZeroChar;
        sLabel24.Caption := ZeroChar;
        sTrackBar1.Max := 0;
        sTrackBar6.Max := sTrackBar1.Max;
        sTrackBar2.Max := sTrackBar1.Max;
        sTrackBar5.Max := sTrackBar1.Max;

        sTrackBar3.Max := 0;
        sTrackBar4.Max := sTrackBar3.Max;
        sTrackBar7.Max := sTrackBar3.Max;
        sTrackBar8.Max := sTrackBar3.Max;

        sTrackBar1.Position := 0;
        sTrackBar4.Position := 0;
        sTrackBar6.Position := 0;
        sTrackBar8.Position := 0;

        sTrackBar2.Position := 0;
        sTrackBar3.Position := 0;
        sTrackBar5.Position := 0;
        sTrackBar7.Position := 0;

        sTrackBar9 .Position := 0;
        sTrackBar10.Position := 0;
        sTrackBar11.Position := 0;
        sTrackBar12.Position := 0;

        ChangeStates(AlphaHintsEdit, 2, False);
      end;

    case acPreviewScale of
      0: sSpeedButton1.Down := True;
      1: sSpeedButton2.Down := True;
      2: sSpeedButton4.Down := True;
    end;

    if Repaint and not InAnimationProcess then
      RefreshPaintBox;

    acUpdating := False;
  end;
end;


procedure TFrameHintPage.sSpeedButton3Click(Sender: TObject);
var
  Bmp: TBitmap;
begin
  if OpenPictureDialog1.Execute then begin
    Image.FImageData.LoadFromFile(OpenPictureDialog1.FileName);
    Image.StreamChanged;
    Bmp := TBitmap.Create;
    Bmp.Assign(Image.FImage);
    Bmp.PixelFormat := pf32bit;
  end;
end;


procedure TFrameHintPage.WndProc(var Message: TMessage);
begin
  inherited;
  if (Message.Msg = CM_FOCUSCHANGED) and not InAnimationProcess and not AeroIsEnabled and (PaintBox1 <> nil) and sFrameAdapter1.SkinData.Skinned then
    RefreshPaintBox;
end;


procedure TFrameHintPage.sRadioButton1Click(Sender: TObject);
begin
  if Image <> nil then
    Image.BorderDrawModes.Left := dmRepeat;
end;


procedure TFrameHintPage.sRadioButton2Click(Sender: TObject);
begin
  if Image <> nil then
    Image.BorderDrawModes.Left := dmStretch;
end;


procedure TFrameHintPage.sRadioButton3Click(Sender: TObject);
begin
  if Image <> nil then
    Image.BorderDrawModes.Top := dmRepeat;
end;


procedure TFrameHintPage.sRadioButton4Click(Sender: TObject);
begin
  if Image <> nil then
    Image.BorderDrawModes.Top := dmStretch;
end;


procedure TFrameHintPage.sRadioButton5Click(Sender: TObject);
begin
  if Image <> nil then
    Image.BorderDrawModes.Right := dmRepeat;
end;


procedure TFrameHintPage.sRadioButton6Click(Sender: TObject);
begin
  if Image <> nil then
    Image.BorderDrawModes.Right := dmStretch;
end;


procedure TFrameHintPage.sRadioButton7Click(Sender: TObject);
begin
  if Image <> nil then
    Image.BorderDrawModes.Bottom := dmRepeat;
end;


procedure TFrameHintPage.sRadioButton8Click(Sender: TObject);
begin
  if Image <> nil then
    Image.BorderDrawModes.Bottom := dmStretch;
end;


procedure TFrameHintPage.sRadioButton9Click(Sender: TObject);
begin
  if Image <> nil then
    Image.BorderDrawModes.Center := dmRepeat;
end;


procedure TFrameHintPage.sRadioButton10Click(Sender: TObject);
begin
  if Image <> nil then
    Image.BorderDrawModes.Center := dmStretch;
end;


procedure TFrameHintPage.RefreshPaintBox;
begin
  FreeAndNil(PreviewBmp); // Update bitmap
  if IsWindowVisible(Handle) then
    PaintBox1.Perform(WM_PAINT, WParam(PaintBox1.Canvas.Handle), 0);
end;


procedure TFrameHintPage.ChangeProperty(ABordersSizes: TacBordersSizes; Index: integer; ATrackBar: TsTrackBar; ALabel: TsLabel);
begin
  if (Image <> nil) then begin
    if not acUpdating then
      ABordersSizes.SetInteger(Index, ATrackBar.Position);

    ALabel.Caption := IntToStr(ATrackBar.Position);
  end;
end;


procedure TFrameHintPage.sTrackBar3Change(Sender: TObject);
begin
  ChangeProperty(Image.ClientMargins, 0, TsTrackBar(Sender), sLabel10);
end;


procedure TFrameHintPage.sTrackBar2Change(Sender: TObject);
begin
  ChangeProperty(Image.ClientMargins, 1, TsTrackBar(Sender), sLabel4);
end;


procedure TFrameHintPage.sTrackBar7Change(Sender: TObject);
begin
  ChangeProperty(Image.ClientMargins, 2, TsTrackBar(Sender), sLabel20);
end;


procedure TFrameHintPage.sTrackBar5Change(Sender: TObject);
begin
  ChangeProperty(Image.ClientMargins, 3, TsTrackBar(Sender), sLabel15);
end;


procedure TFrameHintPage.sTrackBar1Change(Sender: TObject);
begin
  Image.BordersWidths.CheckSize := True;
  ChangeProperty(Image.BordersWidths, 1, TsTrackBar(Sender), sLabel2);
  Image.BordersWidths.CheckSize := False;
end;


procedure TFrameHintPage.sTrackBar4Change(Sender: TObject);
begin
  Image.BordersWidths.CheckSize := True;
  ChangeProperty(Image.BordersWidths, 0, TsTrackBar(Sender), sLabel9);
  Image.BordersWidths.CheckSize := False;
end;


procedure TFrameHintPage.sTrackBar6Change(Sender: TObject);
begin
  Image.BordersWidths.CheckSize := True;
  ChangeProperty(Image.BordersWidths, 3, TsTrackBar(Sender), sLabel14);
  Image.BordersWidths.CheckSize := False;
end;


procedure TFrameHintPage.sTrackBar8Change(Sender: TObject);
begin
  Image.BordersWidths.CheckSize := True;
  ChangeProperty(Image.BordersWidths, 2, TsTrackBar(Sender), sLabel19);
  Image.BordersWidths.CheckSize := False;
end;


procedure TFrameHintPage.sSpinEdit1Change(Sender: TObject);
begin
  if not acUpdating and (Image <> nil) then
    Image.OffsetHorz := sSpinEdit1.Value;
end;


procedure TFrameHintPage.sSpinEdit2Change(Sender: TObject);
begin
  if not acUpdating and (Image <> nil) then
    Image.OffsetVert := sSpinEdit2.Value;
end;


procedure TFrameHintPage.sSpeedButton1Click(Sender: TObject);
begin
  acPreviewScale := TsSpeedButton(Sender).Tag;
  RefreshPaintBox;
end;

end.
