unit sFontCtrls;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
 Windows, Messages, Classes, Graphics, Controls, StdCtrls,
 {$IFNDEF DELPHI5} Types, {$ENDIF}
 sListBox, sComboBox;


type
{$IFNDEF NOTFORHELP}
  FontTypes = (PS, TTF, RASTER, UNKNOWN);

  TFontClass = class
    FntName: string;
    FntType: FontTypes;
  end;

  TFilterOption = (ShowTrueType, ShowPostScript, ShowRaster);
  TFilterOptions = set of TFilterOption;
  EValidateFont = procedure (Sender: TObject; Font: TFontClass; var accept: Boolean) of object;
{$ENDIF} // NOTFORHELP

{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsFontListBox = Class(TsCustomListBox)
{$IFNDEF NOTFORHELP}
  private
    FFilterOptions: TFilterOptions;
    FOnValidateFont: EValidateFont;
    FDrawFont: boolean;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure SetDrawFont(const Value: boolean);
  protected
    procedure SetFilterOptions(Value: TFilterOptions);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Loaded; override;
    procedure WndProc (var Message: TMessage); override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure MeasureItem(Index: Integer; var Height: Integer); override;
  published
    property Align;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property ExtendedSelect;
    property Font;
    property IntegralHeight;
    property ItemHeight;
    property Items stored False;
    property MultiSelect;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style default lbOwnerDrawVariable;
    property TabOrder;
    property TabWidth;
    property Visible;
    property OnValidateFont:EValidateFont read FOnValidateFont write FOnValidateFont;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
{$ENDIF} // NOTFORHELP
    property DrawFont: boolean read FDrawFont write SetDrawFont default True;
    property FilterOptions: TFilterOptions read FFilterOptions write SetFilterOptions default [ShowTrueType, ShowPostScript, ShowRaster];
  end;


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsFontComboBox = Class(TsCustomComboBox)
{$IFNDEF NOTFORHELP}
  private
    FFilterOptions: TFilterOptions;
    FOnValidateFont: EValidateFont;
    FDrawFont: boolean;
    procedure SetDrawFont(const Value: boolean);
  protected
    procedure SetFilterOptions(Value: TFilterOptions);
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Loaded; override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure MeasureItem(Index: Integer; var Height: Integer); override;
    procedure WndProc (var Message: TMessage); override;
    property Style default csOwnerDrawVariable;
  published
    property Align;
    property Color;
    property Ctl3D;
    property DragMode;
    property DragCursor;
    property DropDownCount;
    property Enabled;
    property Font;
    property ItemHeight;
    property Items stored False;
    property MaxLength;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnValidateFont: EValidateFont read FOnValidateFont write FOnValidateFont;
    property OnChange;
    property OnClick;
{$IFDEF DELPHI6UP}
    property OnCloseUp;
{$ENDIF}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnStartDrag;
{$ENDIF} // NOTFORHELP
    property DrawFont: boolean read FDrawFont write SetDrawFont default True;
    property FilterOptions: TFilterOptions read FFilterOptions write SetFilterOptions default [ShowTrueType, ShowPostScript, ShowRaster];
  end;


implementation

uses
  SysUtils,
  {$IFDEF LOGGED}sDebugMsgs, {$ENDIF}
  sSkinProps, sConst, acntUtils, sGraphUtils, sVclUtils, sCommonData, sStyleSimply;


type
  TBitmapArray = array [0..3] of TBitmap;
  TFontsArray = array of TFontClass;


const
  TestStr = 'Ag';

var
  iC: integer;
  fa: TFontsArray;
  FBitmaps: TBitmapArray;


function GetNearestSize(ACanvas: TCanvas; AHeight: integer): integer;
var
  Size: TSize;
begin
  Result := ACanvas.Font.Size - 1;
  if acGetTextExtent(ACanvas.Handle, TestStr, Size) then
    while Size.cy < AHeight - 1 do begin
      Result := ACanvas.Font.Size;
      ACanvas.Font.Size := ACanvas.Font.Size + 1;
      if not acGetTextExtent(ACanvas.Handle, TestStr, Size) then
        Exit;
    end;
end;


function EnumFontFamProc(var LogFont: TLogFont; var TextMetric: TTextMetric; FontType: Integer; Data: Pointer): Integer; StdCall;
var
  s: string;
  i, l: integer;
  FontClass: TFontClass;
begin
  Result := 1;
  s := LogFont.lfFaceName;
  l := Length(fa);
  for i := 0 to l - 1 do
    if (AnsiCompareText(fa[i].FntName, s) = 0) or (s = '') then
      Exit; // Skip duplicates Synchronize

  FontClass := TFontClass.Create;
  with FontClass do begin
    FntName := LogFont.lfFaceName;
    case FontType of
      1:   FntType := RASTER;
      2:   FntType := PS;
      4:   FntType := TTF;
      else FntType := UNKNOWN;
    end;
  end;
  SetLength(fa, Length(fa) + 1);
  fa[Length(fa) - 1] := FontClass;
end;


procedure GetFonts(Sender: TControl);
var
  i: integer;
  cont: Boolean;
  fc: TFontClass;
begin
  if Sender is TsFontListBox then
    with Sender as TsFontListBox do begin
      Items.BeginUpdate;
      Items.Clear;
      for i := 0 to Length(fa) - 1 do begin
        Cont := True;
        if Assigned(FOnValidateFont) then
          FOnValidateFont(Sender, fa[i], Cont);

        fc := fa[i];
        if Cont then
          with fa[i] do
            case FntType of
              PS:
                if ShowPostScript in TsFontListBox(Sender).FFilterOptions then
                  Items.AddObject(FntName, fa[i]);

              TTF:
                if ShowTrueType in FFilterOptions then
                  TsFontListBox(Sender).Items.AddObject(FntName, fa[i]);

              RASTER:
                if ShowRaster in FFilterOptions then
                  Items.AddObject(FntName, fc);

              else
                Items.AddObject(FntName, fa[i]);
            end;
      end;
      Items.EndUpdate;
    end
  else
    with Sender as TsFontComboBox do begin
      Items.BeginUpdate;
      Items.Clear;
      for i := 0 to Length(fa) - 1 do begin
        Cont := True;
        if Assigned(FOnValidateFont) then
          FOnValidateFont(Sender, fa[i], Cont);

        if Cont then
          with fa[i] do begin
            case FntType of
              PS:
                if ShowPostScript in FFilterOptions then
                  Items.AddObject(FntName, fa[i]);

              TTF:
                if ShowTrueType in FFilterOptions then
                  Items.AddObject(FntName, fa[i]);

              RASTER:
                if ShowRaster in FFilterOptions then
                  Items.AddObject(FntName, fa[i]);

              else
                Items.AddObject(FntName, fa[i]);
            end;
{$IFDEF LOGGED}
//  LogLines.Add(FntName);
{$ENDIF}
          end;
      end;
      Items.EndUpdate;
    end;
end;


procedure GetAllInstalledScreenFonts;
var
  DC: HDC;
begin
  DC := GetDC(0);
  EnumFontFamilies(DC, nil, @EnumFontFamProc, 0);
  ReleaseDC(0, DC);
end;


Constructor TsFontListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Sorted := True;
  FFilterOptions := [ShowTrueType, ShowPostScript, ShowRaster];
  FDrawFont := True;
end;


Constructor TsFontComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Sorted := True;
  Style := csOwnerDrawVariable;
  FFilterOptions := [ShowTrueType, ShowPostScript, ShowRaster];
  FDrawFont := True;
end;


procedure TsFontListBox.SetFilterOptions(Value: TFilterOptions);
begin
  if FFilterOptions <> Value then begin
    FFilterOptions := Value;
    if not (csLoading in ComponentState) then
      GetFonts(Self);
  end;
end;


procedure TsFontComboBox.SetFilterOptions(Value: TFilterOptions);
begin
  if FFilterOptions <> Value then begin
    FFilterOptions := Value;
    if not (csLoading in ComponentState) then
      GetFonts(Self);
  end;
end;


procedure TsFontListBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Bmp, fBmp: TBitmap;
  aRect, BRect: TRect;
  TmpColor: TColor;
  TmpFontClass: TFontClass;
  ts: TSize;
  sNdx: integer;
  CI: TCacheInfo;
  DrawStyle: Cardinal;
begin
  TmpFontClass := nil;
  Bmp := nil;
  if (Index >= 0) and (Index < Items.Count) and (Items.Objects[Index] <> nil) then begin
    TmpFontClass := TFontClass(Items.Objects[Index]);
    fBmp := FBitmaps[ord(TmpFontClass.FntType)];
    fBmp.Transparent := True;
    aRect := MkRect(fBmp);
  end
  else
    fBmp := nil;

  if SkinData.Skinned then begin
    Bmp := CreateBmp32(Rect);
    Bmp.Canvas.Font.Assign(Font);
    if (odSelected in State) then begin
      CI.Bmp := nil;
      CI.Ready := False;
      CI.FillColor := Color;
      sNdx := SkinData.SkinManager.ConstData.Sections[ssSelection];
      if sNdx < 0 then
        FillDC(Bmp.Canvas.Handle, MkRect(Bmp), SkinData.SkinManager.GetHighLightColor(odFocused in State))
      else
        PaintItem(sNdx, CI, True, integer(odFocused in State), MkRect(Bmp), MkPoint, Bmp, SkinData.SkinManager)
    end
    else begin
      sNdx := -1;
      FillDC(Bmp.Canvas.Handle, MkRect(Bmp), Color);
    end;
    if Assigned(TmpFontClass) and Assigned(fBmp) then begin
      brect := MkRect(Bmp.Height, Bmp.Height);
      Bmp.Canvas.Draw(bRect.Left, bRect.Top, fBmp);
      aRect.Right := Bmp.Width;
      aRect.Left := brect.right;
      if DrawFont then
        Bmp.Canvas.Font.Name := TmpFontClass.FntName;

      if True then
        Bmp.Canvas.Font.Size := GetNearestSize(Bmp.Canvas, ItemHeight);

      DrawStyle := DT_NOPREFIX or DT_EXPANDTABS or DT_SINGLELINE or DT_VCENTER or DT_NOCLIP;
      InflateRect(aRect, -1, 0);
      if sNdx = -1 then begin
        if odSelected in State then
          Bmp.Canvas.Font.Color := SkinData.SkinManager.GetHighLightFontColor(odFocused in State)
        else
          with SkinData.SkinManager.gd[SkinData.SkinIndex] do
            Bmp.Canvas.Font.Color := Props[integer(ControlIsActive(SkinData) and (States > 1))].FontColor.Color;

        Bmp.Canvas.Brush.Style := bsClear;
        AcDrawText(Bmp.Canvas.Handle, TmpFontClass.FntName, aRect, DrawStyle);
      end
      else
        WriteTextEx(Bmp.Canvas, PChar(TmpFontClass.FntName), True, aRect, DrawStyle, sNdx, (odFocused in State), SkinData.SkinManager);
    end;
    BitBlt(Canvas.Handle, Rect.Left, Rect.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
    FreeAndNil(Bmp);
  end
  else begin
    TmpColor := ColorToRGB(iff(odSelected in State, clHighLight, Color));
    FillDC(Canvas.Handle, Rect, TmpColor);
    if Assigned(TmpFontClass) then begin
      brect := classes.Rect(rect.left, rect.top, rect.bottom - rect.top + rect.left, rect.bottom);
      Canvas.Draw(bRect.Left, bRect.Top, fBmp);
      Rect.Left := Rect.Left + brect.right;
      if DrawFont then
        Canvas.Font.Name := TmpFontClass.FntName;

      if True then
        Canvas.Font.Size := GetNearestSize(Canvas, ItemHeight);

      Canvas.Font.Color := iff(odSelected in State, ColorToRGB(clHighlightText), Font.Color);
      GetTextExtentPoint32(Canvas.Handle, PChar(TmpFontClass.FntName), Length(TmpFontClass.FntName), ts);
      Canvas.Brush.Style := bsClear;
      Canvas.TextRect(Rect, Rect.Left + 1, Rect.Top + (HeightOf(Rect) - ts.cy) div 2, TmpFontClass.FntName);
    end;
  end;
end;


procedure TsFontComboBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Bmp, fBmp: TBitmap;
  aRect, BRect: TRect;
  TmpColor: TColor;
  TmpFontClass: TFontClass;
  ts: TSize;
  sNdx, ItemHeight: integer;
  CI: TCacheInfo;
  DrawStyle: Cardinal;

begin
  TmpFontClass := nil;
  Bmp := nil;
  ItemHeight := HeightOf(Rect);
  if (Index >= 0) and (Index < Items.Count) and (Items.Objects[Index] <> nil) then begin
    TmpFontClass := TFontClass(Items.Objects[Index]);
    fBmp := FBitmaps[ord(TmpFontClass.FntType)];
    fBmp.Transparent := True;
    aRect := MkRect(fBmp);
  end
  else
    fBmp := nil;

  if SkinData.Skinned then begin
    Bmp := CreateBmp32(Rect);
    Bmp.Canvas.Font.Assign(Font);
    if odComboBoxEdit in State then
      CI := MakeCacheInfo(SkinData.FCacheBmp, Rect.Left, Rect.Top)
    else begin
      CI.Bmp := nil;
      CI.Ready := False;
      CI.FillColor := Color;
    end;
    if (odSelected in State) then begin
      CI.Bmp := nil;
      CI.Ready := False;
      CI.FillColor := Color;
      sNdx := SkinData.SkinManager.ConstData.Sections[ssSelection];
      if sNdx < 0 then
        FillDC(Bmp.Canvas.Handle, MkRect(Bmp), SkinData.SkinManager.GetHighLightColor(odFocused in State))
      else
        PaintItem(sNdx, CI, True, integer(odFocused in State), MkRect(Bmp), MkPoint, Bmp, SkinData.SkinManager)
    end
    else begin
      sNdx := -1;
      if CI.Ready then
        BitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, CI.Bmp.Canvas.Handle, CI.X, CI.Y, SRCCOPY)
      else
        FillDC(Bmp.Canvas.Handle, MkRect(Bmp), Color);
    end;
    if Assigned(TmpFontClass) then begin
      bRect := MkRect(Bmp.Height, Bmp.Height);
      case VerticalAlignment of
        taAlignTop:       Bmp.Canvas.Draw(bRect.Left, bRect.Top, fBmp);
        taVerticalCenter: Bmp.Canvas.Draw(bRect.Left, bRect.Top + (ItemHeight - fBmp.Height) div 2, fBmp);
        taAlignBottom:    Bmp.Canvas.Draw(bRect.Left, bRect.Bottom - fBmp.Height, fBmp);
      end;
      aRect.Right := Bmp.Width;
      aRect.Left := bRect.right;
      aRect.Bottom := Bmp.Height;
      if DrawFont then
        Bmp.Canvas.Font.Name := TmpFontClass.FntName;

      if True then
        Bmp.Canvas.Font.Size := GetNearestSize(Bmp.Canvas, ItemHeight);

      DrawStyle := DT_NOPREFIX or DT_EXPANDTABS or DT_SINGLELINE or DT_NOCLIP;
      case VerticalAlignment of
        taAlignTop:       InflateRect(aRect, -1, 0);
        taVerticalCenter: DrawStyle := DrawStyle or DT_VCENTER;
        taAlignBottom:    DrawStyle := DrawStyle or DT_BOTTOM;
      end;
      if sNdx = -1 then begin
        if odSelected in State then
          Bmp.Canvas.Font.Color := SkinData.SkinManager.GetHighLightFontColor(odFocused in State)
        else
          with SkinData.SkinManager.gd[SkinData.SkinIndex] do
            Bmp.Canvas.Font.Color := Props[integer(ControlIsActive(SkinData) and (States > 1))].FontColor.Color;

        Bmp.Canvas.Brush.Style := bsClear;
        AcDrawText(Bmp.Canvas.Handle, TmpFontClass.FntName, aRect, DrawStyle);
      end
      else
        WriteTextEx(Bmp.Canvas, PChar(TmpFontClass.FntName), True, aRect, DrawStyle, sNdx, (odFocused in State), SkinData.SkinManager);
    end;
    BitBlt(Canvas.Handle, Rect.Left, Rect.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
    FreeAndNil(Bmp);
  end
  else begin
    TmpColor := ColorToRGB(iff(odSelected in State, clHighLight, Color));
    FillDC(Canvas.Handle, Rect, TmpColor);
    if Assigned(TmpFontClass) then begin
      brect := classes.Rect(rect.left, rect.top, rect.bottom - rect.top + rect.left, rect.bottom);
      Canvas.Draw(bRect.Left, bRect.Top, fBmp);
      Rect.Left := Rect.Left + brect.right;
      if DrawFont then
        Canvas.Font.Name := TmpFontClass.FntName;

      if True then
        Canvas.Font.Size := GetNearestSize(Canvas, ItemHeight);

      Canvas.Font.Color := iff(odSelected in State, ColorToRGB(clHighlightText), Font.Color);
      GetTextExtentPoint32(Canvas.Handle, PChar(TmpFontClass.FntName), Length(TmpFontClass.FntName), ts);
      Canvas.Brush.Style := bsClear;
      Canvas.TextRect(Rect, Rect.Left + 1, Rect.Top + (ItemHeight - ts.cy) div 2, TmpFontClass.FntName);
    end;
  end;
end;


procedure TsFontListBox.CMFontChanged(var Message: TMessage);
var
  h: integer;
begin
  if SkinData.CtrlSkinState and ACS_CHANGING <> ACS_CHANGING then begin
    SkinData.FCacheBMP.Canvas.Font.Assign(Font);
    h := acTextHeight(SkinData.FCacheBMP.Canvas, 'Wy') + 4;
    if ItemHeight <> h then
      ItemHeight := h;

    inherited;
  end;
end;


procedure TsFontListBox.SetDrawFont(const Value: boolean);
begin
  if FDrawFont <> Value then begin
    FDrawFont := Value;
    if not (csLoading in ComponentState) then
      Invalidate;
  end;
end;


procedure TsFontComboBox.SetDrawFont(const Value: boolean);
begin
  if FDrawFont <> Value then begin
    FDrawFont := Value;
    if not (csLoading in ComponentState) then
      Invalidate;
  end;
end;


procedure TsFontListBox.MeasureItem(Index: Integer; var Height: Integer);
begin
  inherited MeasureItem(Index, Height);
end;


procedure TsFontComboBox.MeasureItem(Index: Integer; var Height: Integer);
begin
  inherited MeasureItem(Index, Height);
end;


procedure TsFontListBox.Loaded;
begin
  inherited;
  GetFonts(Self);
end;


procedure TsFontComboBox.Loaded;
begin
  inherited;
  GetFonts(Self);
end;


procedure TsFontComboBox.CNDrawItem(var Message: TWMDrawItem);
var
  State: TOwnerDrawState;
begin
  with Message.DrawItemStruct^ do begin
    State := TOwnerDrawState(LongRec(itemState).Lo);
    if itemState and ODS_COMBOBOXEDIT <> 0 then
      Include(State, odComboBoxEdit);

    if itemState and ODS_DEFAULT <> 0 then
      Include(State, odDefault);

    Canvas.Handle := hDC;
    Canvas.Font := Font;
    Canvas.Brush := Brush;
    if (Integer(itemID) >= 0) and (odSelected in State) then begin
      Canvas.Brush.Color := clHighlight;
      Canvas.Font.Color := clHighlightText
    end;
    if Integer(itemID) >= 0 then
      DrawItem(itemID, rcItem, State)
    else
      Canvas.FillRect(rcItem);

    if (odFocused in State) and not SkinData.Skinned then
      DrawFocusRect(hDC, rcItem);

    Canvas.Handle := 0;
  end;
end;


procedure TsFontComboBox.WndProc(var Message: TMessage);
var
  s: string;
  i: integer;
begin
  case Message.Msg of
    WM_FONTCHANGE:
      GetFonts(Self);

    WM_SETTEXT:
      if not (csLoading in ComponentState) and
            not (csCreating in ControlState) and
              HandleAllocated and
                not SkinData.FUpdating {Control is not ready} then begin // Change a font when text is changed
        s := PChar(Message.LParam);
        inherited;
        i := Items.IndexOf(s);
        if ItemIndex <> i then
          ItemIndex := i;

        Exit;
      end;
  end;
  inherited;
end;


procedure TsFontListBox.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_FONTCHANGE:
      GetFonts(Self);
  end;
  inherited;
end;


const
  FontTypesArray: array [0..3] of string = ('PS', 'TTF', 'RASTER', 'UNKNOWN');

initialization
  GetAllInstalledScreenFonts;
  for iC := 0 to 3 do begin
    FBitmaps[iC]:= TBitmap.Create;
    FBitmaps[iC].Handle := LoadBitmap(hinstance, PChar(FontTypesArray[iC]));
  end;


finalization
{$WARNINGS OFF}
  for iC := 0 to Length(fa) - 1 do
    TFontClass(fa[iC]).Free;

  SetLength(fa, 0);
  for iC := 0 to 3 do
    FreeAndNil(FBitmaps[iC]);

end.



