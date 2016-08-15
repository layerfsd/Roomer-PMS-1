unit sGroupBox;
{$I sDefs.inc}
//{$DEFINE LOGGED}
//+
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls,
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  {$IFDEF TNTUNICODE} TntGraphics, TntControls, TntActnList, TntClasses, TntSysUtils, TntForms, TntStdCtrls, {$ENDIF}
  sCommonData, sRadioButton, sConst;


type
  TsCaptionLayout = (clTopLeft, clTopCenter, clTopRight);


{$IFNDEF NOTFORHELP}
  TacIntProperty = 0..MaxInt;

  TsMargin = class(TPersistent)
  private
    FLeft,
    FTop,
    FRight,
    FBottom: TacIntProperty;

    FControl: TControl;
    procedure SetMargin(Index: Integer; Value: TacIntProperty);
  public
    constructor Create(Control: TControl);
    procedure Invalidate;
  published
    property Left:   TacIntProperty index 0 read FLeft   write SetMargin default 2;
    property Top:    TacIntProperty index 1 read FTop    write SetMargin default 0;
    property Right:  TacIntProperty index 2 read FRight  write SetMargin default 2;
    property Bottom: TacIntProperty index 3 read FBottom write SetMargin default 0;
  end;
{$ENDIF}


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
{$IFDEF TNTUNICODE}
  TsGroupBox = class(TTntGroupBox)
{$ELSE}
  TsGroupBox = class(TGroupBox)
{$ENDIF}
{$IFNDEF NOTFORHELP}
  private
    FChecked,
    FCheckBoxVisible: boolean;

    FCaptionLayout: TsCaptionLayout;
    FCaptionYOffset: integer;
    FCommonData: TsCommonData;
    FCaptionSkin: TsSkinSection;
    FCaptionMargin: TsMargin;
    FCaptionWidth: TacIntProperty;

    FOnCheckBoxChanged: TNotifyEvent;
    procedure WMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure SetCaptionLayout  (const Value: TsCaptionLayout);
    procedure SetCaptionYOffset (const Value: integer);
    procedure SetCaptionSkin    (const Value: TsSkinSection);
    procedure SetCaptionWidth   (const Value: TacIntProperty);
    procedure SetCheckBoxVisible(const Value: boolean);
    procedure SetChecked        (const Value: boolean);
  protected
    CheckHot,
    CheckPressed: boolean;
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure WndProc(var Message: TMessage); override;
    function CheckBoxHeight: integer;
    function CheckBoxWidth: integer;
    function TextHeight: integer;
    function MouseInCheckBox: boolean;
    function CheckBoxRect: TRect;
    function CheckBoxIndex: integer;
    procedure PaintCheckBoxSkin(Bmp: TBitmap; R: TRect; State: integer);
    procedure PaintCheckBoxStd (DC:  hdc;     R: TRect; State: integer);
    procedure RepaintCheckBox(State: integer; DoAnimation: boolean = False);
  public
    procedure AfterConstruction; override;
    procedure Loaded; override;
    function CaptionRect: TRect;
    function CaptionHeight: integer;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure PaintToDC(DC: hdc);
    function PrepareCache: boolean;
    procedure PaintCaptionArea(cRect: TRect; CI: TCacheInfo; AState: integer);
    procedure WriteText(R: TRect; CI: TCacheInfo);
  published
{$ENDIF} // NOTFORHELP
    property CaptionLayout: TsCaptionLayout read FCaptionLayout write SetCaptionLayout default clTopLeft;
    property CaptionMargin: TsMargin read FCaptionMargin write FCaptionMargin;
    property CaptionYOffset: integer read FCaptionYOffset write SetCaptionYOffset default 0;
    property SkinData: TsCommonData read FCommonData write FCommonData;
    property CaptionSkin: TsSkinSection read FCaptionSkin write SetCaptionSkin;
    property CaptionWidth: TacIntProperty read FCaptionWidth write SetCaptionWidth default 0;
{$IFDEF D2010}
    property Touch;
{$ENDIF}
    property CheckBoxVisible: boolean read FCheckBoxVisible write SetCheckBoxVisible default False;
    property Checked: boolean read FChecked write SetChecked default False;
    property OnCheckBoxChanged: TNotifyEvent read FOnCheckBoxChanged write FOnCheckBoxChanged;
    property OnKeyDown;
    property OnKeyPress;
  end;


{$IFNDEF NOTFORHELP}
  TacIndexChangingEvent = procedure(Sender: TObject; NewIndex: Integer; var AllowChange: Boolean) of object;
{$ENDIF}

  TsRadioGroup = class(TsGroupBox)
{$IFNDEF NOTFORHELP}
  private
    FReading,
    FUpdating,
    FShowFocus: boolean;

    FColumns,
    FItemIndex: Integer;

    FAnimatEvents: TacAnimatEvents;
    FOnChange: TNotifyEvent;
    FOnChanging: TacIndexChangingEvent;
    FItems: {$IFDEF TNTUNICODE}TTntStrings;{$ELSE}TStrings;{$ENDIF}
    procedure ArrangeButtons;
    procedure ButtonClick(Sender: TObject);
    procedure ItemsChange(Sender: TObject);
    procedure SetButtonCount(Value: Integer);
    procedure SetColumns(Value: Integer);
    procedure SetItemIndex(Value: Integer);
    procedure UpdateButtons;
    procedure WMSize          (var Message: TWMSize);  message WM_SIZE;
    procedure CMFontChanged   (var Message: TMessage); message CM_FONTCHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    function GetButtons(Index: Integer): TsRadioButton;
    procedure SetItems(Value: {$IFDEF TNTUNICODE}TTntStrings);{$ELSE}TStrings);{$ENDIF}
  protected
    procedure ReadState(Reader: TReader); override;
    procedure WndProc(var Message: TMessage); override;
  public
    FButtons: TList;
    procedure Loaded; override;
    function CanModify(NewIndex: integer): Boolean; virtual;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure FlipChildren(AllLevels: Boolean); override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    property Buttons[Index: Integer]: TsRadioButton read GetButtons;
  published
    property AnimatEvents: TacAnimatEvents read FAnimatEvents write FAnimatEvents default [aeGlobalDef];
{$ENDIF} // NOTFORHELP
    property Columns: Integer read FColumns write SetColumns default 1;
    property ItemIndex: Integer read FItemIndex write SetItemIndex default -1;
{$IFDEF TNTUNICODE}
    property Items: TTntStrings read FItems write SetItems;
{$ELSE}
    property Items: TStrings read FItems write SetItems;
{$ENDIF}
    property ShowFocus: boolean read FShowFocus write FShowFocus default True;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnChanging: TacIndexChangingEvent read FOnChanging write FOnChanging;
  end;


implementation

uses
  math,
  {$IFDEF TNTUNICODE}TntWindows, {$ENDIF}
  {$IFDEF LOGGED}sDebugMsgs, {$ENDIF}
  {$IFDEF DELPHI7UP}Themes, {$ENDIF}
  acntUtils, sStyleSimply, sMessages, sVCLUtils, sGraphUtils, sSkinProps, sSkinManager, sAlphaGraph, sMaskData, acThdTimer;

const
  CheckIndent = 2;


function UpdateCheckBox_CB(Data: TObject; iIteration: integer): boolean;
var
  sd: TsCommonData;
  gb: TsGroupBox;
  cRect: TRect;
  Bmp: TBitmap;
  Alpha: byte;
  DC: HDC;
begin
  Result := False;
  if Data is TsCommonData then begin
    sd := TsCommonData(Data);
    if sd.FOwnerControl is TsGroupBox then begin
      gb := TsGroupBox(sd.FOwnerControl);
      cRect := SumRects(gb.CaptionRect, gb.CheckBoxRect);
      Bmp := CreateBmp32(cRect);
      BitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, sd.AnimTimer.BmpFrom.Canvas.Handle, 0, 0, SRCCOPY);

      with sd.AnimTimer do
        case State of
          0, 2: Glow := Glow - GlowStep;
          1:    Glow := Glow + GlowStep
          else  Glow := MaxByte - (Iteration / Iterations) * MaxByte;
        end;

      Alpha := LimitIt(Round(sd.AnimTimer.Glow), 0, MaxByte);
      SumBmpRect(Bmp, sd.FCacheBmp, iff(sd.AnimTimer.State = 1, MaxByte - Alpha, Alpha), cRect, MkPoint);
      DC := GetDC(gb.Handle);
      try
        BitBlt(DC, cRect.Left, cRect.Top, WidthOf(cRect), HeightOf(cRect), Bmp.Canvas.Handle, 0, 0, SRCCOPY);
      finally
        ReleaseDC(gb.Handle, DC);
      end;
      Bmp.Free;

      with sd.AnimTimer do
        if sd.AnimTimer.Iteration >= sd.AnimTimer.Iterations then begin
          if (State = 0) and (Alpha > 0) then begin
            Iteration := Iteration - 1;
            UpdateCheckBox_CB(Data, iIteration);
            Exit;
          end;
          if State = 0 then
            StopTimer(sd);
        end
        else
          Result := True;
    end;
  end;
end;


procedure TsGroupBox.AdjustClientRect(var Rect: TRect);
begin
  if not (csDestroying in ComponentState) then begin
    inherited AdjustClientRect(Rect);
    inc(Rect.Top, CaptionYOffset);
  end;
end;


procedure TsGroupBox.AfterConstruction;
begin
  inherited;
  FCommonData.Loaded;
end;


function TsGroupBox.CaptionHeight: integer;
begin
  Result := TextHeight + FCaptionYOffset + FCaptionMargin.Top + FCaptionMargin.Bottom;
end;


function TsGroupBox.CaptionRect: TRect;
const
  xOffset = 6;
var
  Margin, aTextWidth: integer;
  aRect: TRect;
begin
  aRect.Top := 0;
  aRect.Bottom := aRect.Top + CaptionHeight;
  if FCaptionYOffset < 0 then
    inc(aRect.Top, FCaptionYOffset);

  Margin := FCaptionMargin.Left + FCaptionMargin.Right;
  if CaptionWidth = 0 then begin
    aTextWidth := acTextWidth(FCommonData.FCacheBmp.Canvas, Caption);
    if FCaptionLayout = clTopCenter then
      aRect.Left := (Width - aTextWidth - Margin - xOffset) div 2
    else
      if ((FCaptionLayout = clTopLeft) and not UseRightToLeftAlignment) or ((FCaptionLayout = clTopRight) and UseRightToLeftAlignment) then
        aRect.Left := xOffset
      else
        aRect.Left := Width - aTextWidth - 2 * Margin - xOffset;

    if aRect.Left < 0 then
      aRect.Left := 0;

    aRect.Right := aRect.Left + aTextWidth + 2 * Margin;
    if aRect.Right > Width then
      aRect.Right := Width;

    if WidthOf(aRect) < 2 * BevelWidth then begin
      aRect.Left := aRect.Left - BevelWidth;
      aRect.Right := aRect.Right + BevelWidth;
    end;
  end
  else begin
    aTextWidth := CaptionWidth;
    if FCaptionLayout = clTopCenter then
      aRect.Left := (Width - aTextWidth - xOffset) div 2
    else
      if ((FCaptionLayout = clTopLeft) and not UseRightToLeftAlignment) or ((FCaptionLayout = clTopRight) and UseRightToLeftAlignment) then
        aRect.Left := xOffset + FCaptionmargin.Left
      else
        aRect.Left := Width - aTextWidth - xOffset - FCaptionMargin.Right;

    if aRect.Left < 0 then
      aRect.Left := 0;

    aRect.Right := aRect.Left + aTextWidth + FCaptionMargin.Left;
    if aRect.Right > Width then
      aRect.Right := Width;

    if WidthOf(aRect) < 2 * BevelWidth then begin
      aRect.Left := aRect.Left - BevelWidth;
      aRect.Right := aRect.Right + BevelWidth;
    end;
  end;
  Result := aRect;
  if CheckBoxVisible then
    if BidiMode = bdLeftToRight then begin
      if CaptionLayout = clTopLeft then
        OffsetRect(Result, CheckBoxWidth + CheckIndent, 0);
    end
    else
      if CaptionLayout = clTopRight then
        OffsetRect(Result, - CheckBoxWidth - CheckIndent, 0);
end;


function TsGroupBox.CheckBoxHeight: integer;
var
  GlyphNdx: integer;
begin
  if SkinData.Skinned then begin
    GlyphNdx := CheckBoxIndex;
    if SkinData.SkinManager.IsValidImgIndex(GlyphNdx) then
      Result := FCommonData.SkinManager.ma[GlyphNdx].Height
    else
      Result := 0;
  end
  else
{$IFDEF DELPHI7UP}
    if acThemesEnabled then
      Result := 16
    else
{$ENDIF}    
      Result := 13;
end;


function TsGroupBox.CheckBoxIndex: integer;
const
  GlyphStates: array [boolean] of TCheckBoxState = (cbUnchecked, cbChecked);
begin
  Result := FCommonData.SkinManager.ConstData.CheckBox[GlyphStates[Checked]];
end;


function TsGroupBox.CheckBoxRect: TRect;
var
  R: TRect;
begin
  if FCheckBoxVisible then begin
    R := CaptionRect;
    Result.Top := max(0, (HeightOf(R) - CheckBoxHeight) div 2);
    Result.Bottom := Result.Top + CheckBoxHeight;
    if BiDiMode = bdLeftToRight then begin
      Result.Right := R.Left - CheckIndent;
      Result.Left := Result.Right - CheckBoxWidth;
    end
    else begin
      Result.Left := R.Right + CheckIndent;
      Result.Right := Result.Left + CheckBoxWidth;
    end;
  end
  else
    Result := MkRect;
end;


function TsGroupBox.CheckBoxWidth: integer;
var
  GlyphNdx: integer;
begin
  if SkinData.Skinned then begin
    GlyphNdx := CheckBoxIndex;
    if SkinData.SkinManager.IsValidImgIndex(GlyphNdx) then
      Result := FCommonData.SkinManager.ma[GlyphNdx].Width
    else
      Result := 0;
  end
  else
{$IFDEF DELPHI7UP}
    if acThemesEnabled then
      Result := 16
    else
{$ENDIF}    
      Result := 13;
end;


constructor TsGroupBox.Create(AOwner: TComponent);
begin
  FCommonData := TsCommonData.Create(Self, True);
  FCommonData.COC := COC_TsGroupBox;
  inherited Create(AOwner);
  FCaptionLayout := clTopLeft;
  FCaptionYOffset := 0;
  FCaptionMargin := TsMargin.Create(Self);
  FCaptionWidth := 0;
  FCheckBoxVisible := False;
  FChecked := False;
  CheckPressed := False;
  CheckHot := False;
end;


destructor TsGroupBox.Destroy;
begin
  FreeAndNil(FCommonData);
  FCaptionMargin.Free;
  inherited Destroy;
end;


procedure TsGroupBox.Loaded;
begin
  inherited;
  FCommonData.Loaded;
end;


function TsGroupBox.MouseInCheckBox: boolean;
begin
  Result := not (csDesigning in ComponentState) and (PtInRect(CheckBoxRect, ScreenToClient(acMousePos)) or PtInRect(CaptionRect, ScreenToClient(acMousePos)));
end;


procedure TsGroupBox.Paint;
begin
  PaintToDC(Canvas.Handle)
end;


procedure TsGroupBox.PaintCaptionArea(cRect: TRect; CI: TCacheInfo; AState: integer);
begin
  if Caption <> '' then
    WriteText(cRect, CI);

  if CheckBoxVisible then
    PaintCheckBoxSkin(FCommonData.FCacheBMP, CheckBoxRect, AState);
end;


procedure TsGroupBox.PaintCheckBoxSkin(Bmp: TBitmap; R: TRect; State: integer);
var
  GlyphNdx: integer;
begin
  GlyphNdx := CheckBoxIndex;
  if SkinData.SkinManager.IsValidImgIndex(GlyphNdx) then
    DrawSkinGlyph(Bmp, R.TopLeft, State, 1, FCommonData.SkinManager.ma[GlyphNdx], MakeCacheInfo(Bmp))
end;


procedure TsGroupBox.PaintCheckBoxStd(DC: hdc; R: TRect; State: integer);
const
  CheckStates: array [boolean] of Cardinal = (DFCS_ADJUSTRECT, DFCS_CHECKED);
{$IFDEF DELPHI7UP}
  ThemedChecks: array [boolean, 0..3] of TThemedButton = ((tbCheckBoxUncheckedNormal, tbCheckBoxUncheckedHot, tbCheckBoxUncheckedPressed, tbCheckBoxUncheckedDisabled),
                                                          (tbCheckBoxCheckedNormal,   tbCheckBoxCheckedHot,   tbCheckBoxCheckedPressed, tbCheckBoxCheckedDisabled));
{$ENDIF}
begin
{$IFDEF DELPHI7UP}
  if acThemesEnabled then
    acThemeServices.DrawElement(DC, acThemeServices.GetElementDetails(ThemedChecks[Checked, iff(Enabled, State, 3)]), R)
  else
{$ENDIF}
    DrawFrameControl(DC, R, DFC_BUTTON, CheckStates[Checked]);
end;


procedure TsGroupBox.PaintToDC(DC: hdc);
var
  b: boolean;

{$IFDEF DELPHI7UP}
  procedure PaintThemedGroupBox;
  var
    OuterRect: TRect;
    Box: TThemedButton;
    Details: TThemedElementDetails;
    R: TRect;
  begin
    with Canvas do begin
      OuterRect := ClientRect;
      OuterRect.Top := (CaptionRect.Bottom - CaptionRect.Top) div 2;
      with CaptionRect do
        ExcludeClipRect(Handle, Left, Top, Right, Bottom);

      if Enabled then
        Box := tbGroupBoxNormal
      else
        Box := tbGroupBoxDisabled;

      Details := acThemeServices.GetElementDetails(Box);
      acThemeServices.DrawElement(Handle, Details, OuterRect);
      SelectClipRgn(Handle, 0);
      if Text <> '' then begin
        R := CaptionRect;
        SelectObject(DC, Font.Handle);
        SetTextColor(DC, ColorToRGB(Font.Color));
        SetBkMode(DC, TRANSPARENT);
        acDrawText(DC, Text, R, DrawTextBiDiModeFlags(DT_SINGLELINE or DT_CENTER));
      end;
(*
{$IFDEF DELPHI_XE2}
      begin
        R := CaptionRect;
        acThemeServices.DrawText(Handle, Details, Caption, R, [tfLeft]);
      end
{$ELSE}
        acThemeServices.DrawText(Handle, Details, Caption, CaptionRect, DT_LEFT, 0);
{$ENDIF}
*)
    end;
  end;
{$ENDIF}

  procedure PaintGroupBox;
  var
    H: Integer;
    R: TRect;
    Flags: Cardinal;
  begin
    with Canvas do begin
      H := acTextHeight(Canvas, ZeroChar);
      R := Rect(0, H div 2 - 1, Width, Height);
      if Ctl3D then begin
        Inc(R.Left);
        Inc(R.Top);
        Brush.Color := clBtnHighlight;
        FrameRect(R);
        OffsetRect(R, -1, -1);
        Brush.Color := clBtnShadow;
      end
      else
        Brush.Color := clWindowFrame;

      FrameRect(R);
      if Caption <> '' then begin
        R := CaptionRect;
        Flags := DrawTextBiDiModeFlags(DT_SINGLELINE);
        acDrawText(Handle, PacChar(Caption), R, Flags or DT_CALCRECT);
        Brush.Color := Color;
        acDrawText(Handle, PacChar(Caption), R, Flags);
      end;
    end;
  end;

begin
  if FCommonData.Skinned(True) then begin
    if not (csDestroying in ComponentState) and (Visible or (csDesigning in ComponentState)) then
      if not InAnimationProcess or (DC = SkinData.PrintDC) then
        if not InUpdating(FCommonData) then begin
          // If transparent and form resizing processed
          b := FCommonData.HalfVisible or FCommonData.BGChanged;
          if SkinData.RepaintIfMoved then begin
            FCommonData.HalfVisible := not (PtInRect(Parent.ClientRect, Point(Left + 1, Top + 1)));
            FCommonData.HalfVisible := FCommonData.HalfVisible or not PtInRect(Parent.ClientRect, Point(Left + Width - 1, Top + Height - 1));
          end
          else
            FCommonData.HalfVisible := False;

          if b then
            PrepareCache;

          CopyWinControlCache(Self, FCommonData, MkRect, MkRect(Self), DC, False);
          sVCLUtils.PaintControls(DC, Self, b, MkPoint);
          SetParentUpdated(Self);
        end;
  end
  else begin
    Canvas.Font := Self.Font;
{$IFDEF DELPHI7UP}
    if acThemesEnabled then
      PaintThemedGroupBox
    else
{$ENDIF}
      PaintGroupBox;

    if CheckBoxVisible then
      PaintCheckBoxStd(DC, CheckBoxRect, integer(CheckHot));
  end
end;


function TsGroupBox.PrepareCache: boolean;
var
  cRect, aRect: TRect;
  CI: TCacheInfo;
  BG: TacBGInfo;
begin
  InitCacheBmp(SkinData);
  GetBGInfo(@BG, Parent);
  if BG.BgType = btNotReady then begin
    Result := False;
    SkinData.FUpdating := True;
  end
  else begin
    CI := BGInfoToCI(@BG);
    aRect := MkRect(Width, Height);
    cRect := CaptionRect;
    // Caption BG painting
    if CI.Ready then
      BitBlt(FCommonData.FCacheBmp.Canvas.Handle, aRect.Left, aRect.Top, Width, HeightOf(cRect), CI.Bmp.Canvas.Handle, Left + CI.X, Top + CI.Y, SRCCOPY)
    else
      if Parent <> nil then
        FillDC(FCommonData.FCacheBmp.Canvas.Handle, MkRect(Width, cRect.Bottom), CI.FillColor);

    if FCaptionYOffset < 0 then
      aRect.Top := 0
    else
      aRect.Top := HeightOf(cRect) div 2;

    PaintItem(FCommonData, CI, False, 0, Rect(0, aRect.Top, Width, Height), Point(Left, Top + aRect.Top), FCommonData.FCacheBMP, True);
    PaintCaptionArea(cRect, CI, 0);
    SkinData.PaintOuterEffects(Self, MkPoint);
    FCommonData.BGChanged := False;
    Result := True;
  end;
end;


procedure TsGroupBox.RepaintCheckBox(State: integer; DoAnimation: boolean = False);
var
  DC: hdc;
  cRect, R: TRect;
  i: integer;
begin
  if SkinData.Skinned then
    if DoAnimation and SkinData.SkinManager.Effects.AllowAnimation and (State <> 2) then begin
      i := GetNewTimer(SkinData.AnimTimer, SkinData.FOwnerControl, State);
      if (SkinData.AnimTimer.State >= 0) and (State = SkinData.AnimTimer.State) then // Started already
        Exit;

      cRect := SumRects(CaptionRect, CheckBoxRect);
      if SkinData.AnimTimer.BmpFrom <> nil then
        FreeAndNil(SkinData.AnimTimer.BmpFrom);

      SkinData.AnimTimer.BmpFrom := CreateBmp32(cRect);
      BitBlt(SkinData.AnimTimer.BmpFrom.Canvas.Handle, 0, 0, SkinData.AnimTimer.BmpFrom.Width, SkinData.AnimTimer.BmpFrom.Height, SkinData.FCacheBmp.Canvas.Handle, cRect.Left, cRect.Top, SRCCOPY);
      PaintCaptionArea(CaptionRect, GetParentCache(SkinData), State);
      SkinData.AnimTimer.InitData(SkinData, i, UpdateCheckBox_CB, State);
    end
    else begin
      if SkinData.AnimTimer <> nil then
        FreeAndNil(SkinData.AnimTimer);

      DC := GetDC(Handle);
      try
        R := CheckBoxRect;
        if SkinData.Skinned then begin
          cRect := CaptionRect;
          PaintCaptionArea(cRect, GetParentCache(SkinData), State);
          cRect := SumRects(CaptionRect, R);
          BitBlt(DC, cRect.Left, cRect.Top, WidthOf(cRect), HeightOf(cRect), SkinData.FCacheBmp.Canvas.Handle, cRect.Left, cRect.Top, SRCCOPY);
        end
        else
          PaintCheckBoxStd(DC, R, State);
      finally
        ReleaseDC(Handle, DC);
      end;
    end
  else
    Repaint;
end;


procedure TsGroupBox.SetCaptionLayout(const Value: TsCaptionLayout);
begin
  if FCaptionLayout <> Value then begin
    FCaptionLayout := Value;
    if Caption <> '' then
      SkinData.Invalidate;
  end;
end;


procedure TsGroupBox.SetCaptionSkin(const Value: TsSkinSection);
begin
  if FCaptionSkin <> Value then begin
    FCaptionSkin := Value;
    FCommonData.Invalidate
  end;
end;


procedure TsGroupBox.SetCaptionWidth(const Value: TacIntProperty);
begin
  if FCaptionWidth <> Value then begin
    FCaptionWidth := Value;
    FCommonData.Invalidate
  end;
end;


procedure TsGroupBox.SetCaptionYOffset(const Value: integer);
begin
  if FCaptionYOffset <> Value then begin
    FCaptionYOffset := Value;
    SkinData.Invalidate;
  end;
end;


procedure TsGroupBox.SetCheckBoxVisible(const Value: boolean);
begin
  if FCheckBoxVisible <> Value then begin
    FCheckBoxVisible := Value;
    FCommonData.Invalidate;
  end;
end;

procedure TsGroupBox.SetChecked(const Value: boolean);
begin
  if FChecked <> Value then begin
    FChecked := Value;
    if not (csLoading in ComponentState) then begin
      if not CheckPressed then
        FCommonData.Invalidate;

      if Assigned(OnCheckBoxChanged) then
        OnCheckBoxChanged(Self);
    end;
  end;
end;

function TsGroupBox.TextHeight: integer;
begin
  Result := Maxi(4, FCommonData.FCacheBmp.Canvas.TextHeight('W')) + 2;
end;


procedure TsGroupBox.WMFontChanged(var Message: TMessage);
begin
  inherited;
  FCommonData.FCacheBmp.Canvas.Font.Assign(Font);
  if Caption <> '' then
    FCommonData.Invalidate;
end;


procedure TsGroupBox.WndProc(var Message: TMessage);
var
  PS: TPaintStruct;
  DC: hdc;
begin
{$IFDEF LOGGED}
  AddToLog(Message, Name);
{$ENDIF}
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_CTRLHANDLED: begin
          Message.Result := 1;
          Exit
        end;

        AC_SETSCALE:
          if SkinData.SkinManager <> nil then begin
            CaptionWidth := MulDiv(CaptionWidth, Message.LParam, SkinData.ScalePercent);
            CommonMessage(Message, SkinData);
            Exit;
          end;

        AC_SETNEWSKIN: begin
          AlphaBroadCast(Self, Message);
          if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then
            CommonWndProc(Message, FCommonData);

          Exit;
        end;

        AC_GETBG:
          if CaptionSkin <> '' then
            with PacBGInfo(Message.LParam)^ do begin // If BG of groupbox used
              Bmp := SkinData.FCacheBmp;
              Offset := MkPoint;
              BgType := btCache;
              Exit;
            end;

        AC_PREPARECACHE: begin
          if SkinData.Skinned and not InUpdating(SkinData) and not PrepareCache then
            SkinData.FUpdating := True;

          Exit;
        end;

        AC_GETOUTRGN: begin
          PRect(Message.LParam)^ := MkRect(Width, Height);
          if FCaptionYOffset < 0 then
            PRect(Message.LParam)^.Top := 0
          else
            PRect(Message.LParam)^.Top := HeightOf(CaptionRect) div 2;

          OffsetRect(PRect(Message.LParam)^, Left, Top);
          Exit;
        end;

        AC_MOUSELEAVE:
          if CheckBoxVisible then
            if CheckHot then begin
              CheckHot := False;
              RepaintCheckBox(0);
            end;

        AC_REFRESH, AC_REMOVESKIN: begin
          if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
            CommonWndProc(Message, FCommonData);
            AlphaBroadCast(Self, Message);
            Repaint;
          end
          else
            AlphaBroadCast(Self, Message);

          Exit;
        end;

        AC_GETDEFINDEX: begin
          if FCommonData.SkinManager <> nil then
            Message.Result := FCommonData.SkinManager.ConstData.Sections[ssGroupBox] + 1;

          Exit;
        end;
      end;

    CM_MOUSELEAVE, WM_MOUSELEAVE:
      if CheckBoxVisible then
        if CheckHot then begin
          CheckHot := False;
          RepaintCheckBox(0, True);
        end;

    WM_MOUSEMOVE:
      if CheckBoxVisible then
        if MouseInCheckBox then begin
          if not CheckHot then begin
            CheckHot := True;
            RepaintCheckBox(1, True);
          end;
        end
        else
          if CheckHot then begin
            CheckHot := False;
            RepaintCheckBox(0, True);
          end;

    WM_LBUTTONDBLCLK, WM_LBUTTONDOWN:
      if CheckBoxVisible then
        if MouseInCheckBox then begin
          CheckPressed := True;
          RepaintCheckBox(2);
        end;

    WM_LBUTTONUP:
      if CheckBoxVisible then
        if CheckPressed then begin
          if MouseInCheckBox then
            Checked := not Checked;

          CheckPressed := False;
          RepaintCheckBox(1);
        end;
  end;

  if not ControlIsReady(Self) or not FCommonData.Skinned then
    inherited
  else begin
    if Message.Msg = SM_ALPHACMD then
      case Message.WParamHi of
{
        AC_PREPARING: begin // Remove this case in the Beta
          Message.Result := LRESULT(FCommonData.BGChanged or FCommonData.Updating);
          Exit
        end;
}
        AC_ENDPARENTUPDATE: begin
          if FCommonData.FUpdating then begin
            if Showing and not InUpdating(FCommonData, True) then begin
              RedrawWindow(Handle, nil, 0, RDWA_NOCHILDRENNOW);
              SetParentUpdated(Self);
            end;
          end
          else
            if SkinData.CtrlSkinState and ACS_FAST <> 0 then
              SetParentUpdated(Self);

          Exit;
        end;

        AC_PREPARECACHE: begin
          if not PrepareCache then
            SkinData.FUpdating := True;

          Exit;
        end

        else begin
          CommonMessage(Message, FCommonData);
          Exit;
        end;
      end
    else
      case Message.Msg of
        WM_PAINT: begin
          BeginPaint(Handle, PS);
          if Message.WParam = 0 then
            DC := GetDC(Handle)
          else
            DC := hdc(Message.WParam);

          try
            PaintToDC(DC);
          finally
            if Message.WParam = 0 then
              ReleaseDC(Handle, DC);
          end;
          EndPaint(Handle, PS);
          Exit;
        end;

        WM_PRINT: begin
          SkinData.Updating := False;
          PaintToDC(TWMPaint(Message).DC);
          Exit;
        end;

        CM_TEXTCHANGED: begin
          SkinData.Invalidate;
          Exit;
        end;

        WM_ERASEBKGND: begin
          if not (csPaintCopy in ControlState) and (Message.WParam <> WParam(Message.LParam) {PerformEraseBackground, TntSpeedButtons}) then begin
            Message.Result := 1;
            if csDesigning in ComponentState then
              inherited; // Drawing in the BDS IDE
          end
          else
            if Message.WParam <> 0 then // From PaintTo
              if not FCommonData.BGChanged then
                if IsCached(FCommonData) then
                  BitBlt(TWMPaint(Message).DC, 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY)
                else
                  FillDC(TWMPaint(Message).DC, MkRect(Width, Height), GetBGColor(SkinData, 0));

          Exit;
        end;

        CM_VISIBLECHANGED, WM_WINDOWPOSCHANGED:
          FCommonData.BGChanged := True;

        WM_KILLFOCUS, WM_SETFOCUS: begin
          inherited;
          Exit
        end;

        WM_MOVE:
          FCommonData.BGChanged := FCommonData.BGChanged or FCommonData.RepaintIfMoved;
      end;

    if not CommonWndProc(Message, FCommonData) then begin
      inherited;
      case Message.Msg of
        WM_SIZE:
          if csDesigning in ComponentState then
            SendMessage(Handle, WM_PAINT, 0, 0);
      end
    end;
  end;
end;


procedure TsGroupBox.WriteText(R: TRect; CI: TCacheInfo);
var
  sIndex: integer;
  Flags: Cardinal;
  Bmp: TBitmap;
  rText: TRect;
begin
  Flags := DT_SINGLELINE or DT_VCENTER or iff((CaptionWidth = 0) or (CaptionLayout = clTopCenter), DT_CENTER, DT_END_ELLIPSIS);
  if UseRightToLeftReading then
    Flags := Flags or DT_RTLREADING;

  if FCaptionSkin = '' then begin
    CI := GetParentCache(FCommonData);
    if CheckBoxVisible then begin
      sIndex := SkinData.SkinManager.ConstData.Sections[ssCheckBox];
      if BidiMode = bdLeftToRight then
        R.Left := R.Left - CheckBoxWidth - CheckIndent - 2
      else
        R.Right := R.Right + CheckBoxWidth + CheckIndent + 2;
    end
    else
      sIndex := SkinData.SkinManager.ConstData.Sections[ssTransparent];

    if not CI.Ready then
      FillDC(FCommonData.FCacheBmp.Canvas.Handle, R, CI.FillColor)
    else
      PaintItem(sIndex, CI, True, integer(Focused or CheckHot), R, Point(Left + R.Left, Top + R.Top), FCommonData.FCacheBmp, FCommonData.SkinManager);

    if CheckBoxVisible then
      if BidiMode = bdLeftToRight then
        R.Left := R.Left + CheckBoxWidth + CheckIndent + 2
      else
        R.Left := R.Left - CheckBoxWidth - CheckIndent - 2;

    inc(R.Left,    FCaptionMargin.Left);
    inc(R.Top,     FCaptionMargin.Top);
    inc(R.Right,  -FCaptionMargin.Right);
    inc(R.Bottom, -FCaptionMargin.Bottom);
    if {not CheckHot or }(sIndex < 0) then
      sIndex := SkinData.SkinIndex;

    if NeedParentFont(SkinData.SkinManager, sIndex, integer(CheckHot)) then begin
      sIndex := GetFontIndex(Parent, sIndex, SkinData.SkinManager, integer(CheckHot));
    end;

    acWriteTextEx(FCommonData.FCacheBMP.Canvas, PacChar(Caption), True, R, Flags, sIndex, CheckHot, FCommonData.SkinManager);
{
    if CheckHot and (sIndex >= 0) then
      acWriteTextEx(FCommonData.FCacheBMP.Canvas, PacChar(Caption), True, R, Flags, sIndex, CheckHot, FCommonData.SkinManager)
    else
      acWriteTextEx(FCommonData.FCacheBMP.Canvas, PacChar(Caption), True, R, Flags, SkinData, CheckHot, FCommonData.SkinManager);
}
  end
  else begin
    CI := MakeCacheInfo(FCommonData.FCacheBmp);
    sIndex := FCommonData.SkinManager.GetSkinIndex(FCaptionSkin);

    Bmp := CreateBmp32(R);
    Bmp.Canvas.Font.Assign(Font);
    PaintItem(sIndex, CI, True, integer(Focused or CheckHot), MkRect(Bmp), R.TopLeft, Bmp, FCommonData.SkinManager);

    rText := Rect(FCaptionMargin.Left, FCaptionMargin.Top, Bmp.Width - FCaptionMargin.Right, Bmp.Height - FCaptionMargin.Bottom);
    if not SkinData.CustomFont then
      acWriteTextEx(BMP.Canvas, PacChar(Caption), True, rText, Flags, sIndex, CheckHot, FCommonData.SkinManager)
    else begin
      BMP.Canvas.Font.Assign(Font);
      acWriteText(BMP.Canvas, PacChar(Caption), True, rText, Flags);
    end;
    BitBlt(FCommonData.FCacheBMP.Canvas.Handle, R.Left, R.Top, Bmp.Width, Bmp.Height, BMP.Canvas.Handle, 0, 0, SRCCOPY);
    Bmp.Free;
  end;
end;


type
  TsGroupButton = class(TsRadioButton)
  private
    FInClick,
    FInModifying: boolean;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
  protected
    function CanModify: boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
  public
    constructor InternalCreate(RadioGroup: TsRadioGroup);
    destructor Destroy; override;
  end;


constructor TsGroupButton.InternalCreate(RadioGroup: TsRadioGroup);
begin
  inherited Create(RadioGroup);
  SkinData.SkinManager := RadioGroup.SkinData.SkinManager;
  SkinData.SkinSection := s_CheckBox;
  AutoSize := False;
  ShowFocus := True;
  RadioGroup.FButtons.Add(Self);
  Visible := False;
  Enabled := RadioGroup.Enabled;
  ParentShowHint := False;
  OnClick := RadioGroup.ButtonClick;
  TabStop := False;
  SkinData.CustomFont := RadioGroup.SkinData.CustomFont;
  AnimatEvents := RadioGroup.AnimatEvents;
  Parent := RadioGroup;
  ControlStyle := ControlStyle + [csOpaque];
end;


destructor TsGroupButton.Destroy;
begin
  TsRadioGroup(Owner).FButtons.Remove(Self);
  inherited Destroy;
end;


procedure TsGroupButton.CNCommand(var Message: TWMCommand);
begin
  if not FInClick and not FInModifying and not (csLoading in ComponentState) then begin
    FInClick := True;
    try
      with TsRadioGroup(Parent) do
        if (Message.NotifyCode in [BN_CLICKED, BN_DOUBLECLICKED]) and CanModify(FButtons.IndexOf(Self)) then begin
          inherited;
          if Assigned(FOnChange) then
            FOnChange(Parent);
        end;
    except
      Application.HandleException(Self);
    end;
    FInClick := False;
  end;
end;


procedure TsGroupButton.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  with TsRadioGroup(Parent) do begin
    KeyPress(Key);
    if ((Key = #8) or (Key = s_Space)) and not CanModify(FButtons.IndexOf(Self)) then
      Key := #0;
  end;
end;


procedure TsGroupButton.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  TsRadioGroup(Parent).KeyDown(Key, Shift);
end;


function TsGroupButton.CanModify: boolean;
begin
  FInModifying := True;
  Result := TsRadioGroup(Parent).CanModify(TsRadioGroup(Parent).FButtons.IndexOf(Self));
  FInModifying := False;
end;


procedure TsRadioGroup.ArrangeButtons;
var
  DC: HDC;
  ALeft: Integer;
  SaveFont: HFont;
  Metrics: TTextMetric;
  DeferHandle: THandle;
  ButtonsPerCol, ButtonWidth, ButtonHeight, TopMargin, I: Integer;
begin
  if (FButtons.Count <> 0) and not FReading and not (csLoading in ComponentState) then begin
    DC := GetDC(0);
    SaveFont := SelectObject(DC, Font.Handle);
    GetTextMetrics(DC, Metrics);
    SelectObject(DC, SaveFont);
    ReleaseDC(0, DC);
    ButtonsPerCol := (FButtons.Count + FColumns - 1) div FColumns;
    ButtonWidth := (Width - 10) div FColumns;
    I := Height - Metrics.tmHeight - 5;
    ButtonHeight := I div ButtonsPerCol;
    TopMargin := Metrics.tmHeight + 1 + (I mod ButtonsPerCol) div 2;
    DeferHandle := BeginDeferWindowPos(FButtons.Count);
    try
      for I := 0 to FButtons.Count - 1 do
        with TsGroupButton(FButtons[I]) do begin
          SkinData.SkinManager := Self.SkinData.SkinManager;
          BiDiMode := self.BiDiMode;
          ShowFocus := Self.ShowFocus;
          if UseRightToLeftAlignment then
            ALeft := (I div ButtonsPerCol) * ButtonWidth + 8 + ButtonWidth - Width
          else
            ALeft := (I div ButtonsPerCol) * ButtonWidth + 8;
            
          DeferHandle := DeferWindowPos(DeferHandle, Handle, 0, ALeft, (I mod ButtonsPerCol) * ButtonHeight + TopMargin,
                                        ButtonWidth, ButtonHeight, SWP_NOZORDER or SWP_NOACTIVATE);
          Visible := True;
        end;
    finally
      EndDeferWindowPos(DeferHandle);
    end;
  end;
end;


procedure TsRadioGroup.ButtonClick(Sender: TObject);
begin
  if not FUpdating then begin
    FItemIndex := FButtons.IndexOf(Sender);
    Changed;
    Click;
  end;
end;


function TsRadioGroup.CanModify(NewIndex: integer): Boolean;
begin
  Result := True;
  if Assigned(FOnChanging) then
    FOnChanging(Self, NewIndex, Result);
end;


procedure TsRadioGroup.CMEnabledChanged(var Message: TMessage);
var
  I: Integer;
begin
  inherited;
  for I := 0 to FButtons.Count - 1 do begin
    TsGroupButton(FButtons[I]).Enabled := Enabled;
    TsGroupButton(FButtons[I]).SkinData.BGChanged := True;
  end;
end;


procedure TsRadioGroup.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ArrangeButtons;
end;


constructor TsRadioGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csSetCaption, csDoubleClicks{$IFDEF DELPHI7UP}, csParentBackground{$ENDIF}];
  FButtons := TList.Create;
{$IFDEF TNTUNICODE}
  FItems := TTntStringList.Create;
  TTntStringList(FItems).OnChange := ItemsChange;
{$ELSE}
  FItems := TStringList.Create;
  TStringList(FItems).OnChange := ItemsChange;
{$ENDIF}
  FItemIndex := -1;
  FColumns := 1;
  FAnimatEvents := [aeGlobalDef];
  FShowFocus := True;
end;


destructor TsRadioGroup.Destroy;
begin
  SetButtonCount(0);
{$IFDEF TNTUNICODE}
  TTntStringList(FItems).OnChange := Nil;
{$ELSE}
  TStringList(FItems).OnChange := Nil;
{$ENDIF}
  FreeAndNil(FItems);
  FButtons.Free;
  inherited Destroy;
end;


procedure TsRadioGroup.FlipChildren(AllLevels: Boolean);
begin
//
end;


function TsRadioGroup.GetButtons(Index: Integer): TsRadioButton;
begin
  Result := TsRadioButton(FButtons[Index]);
end;


procedure TsRadioGroup.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
//
end;


procedure TsRadioGroup.ItemsChange(Sender: TObject);
var
  i: integer;
begin
  if not FReading and not(csLoading in ComponentState) then begin
    if FItemIndex >= FItems.Count then
      FItemIndex := FItems.Count - 1;

    UpdateButtons;
  end;
  for i := 0 to FButtons.Count - 1 do
    TsRadioButton(FButtons[i]).Loaded;
end;


procedure TsRadioGroup.Loaded;
begin
  inherited Loaded;
  UpdateButtons;
  if IsValidIndex(FItemIndex, FButtons.Count) then begin
    FUpdating := True;
    TsGroupButton(FButtons[FItemIndex]).Checked := True;
    FUpdating := False;
  end;
end;


procedure TsRadioGroup.ReadState(Reader: TReader);
begin
  FReading := True;
  inherited ReadState(Reader);
  FReading := False;
  UpdateButtons;
end;


procedure TsRadioGroup.SetButtonCount(Value: Integer);
begin
  while FButtons.Count < Value do
    TsGroupButton.InternalCreate(Self);

  while FButtons.Count > Value do
    TsGroupButton(FButtons.Last).Free;
end;


procedure TsRadioGroup.SetColumns(Value: Integer);
begin
  if Value < 1 then
    Value := 1
  else
    if Value > 16 then
      Value := 16;

  if FColumns <> Value then begin
    FColumns := Value;
    ArrangeButtons;
    Invalidate;
  end;
end;


procedure TsRadioGroup.SetItemIndex(Value: Integer);
begin
  if FReading then
    FItemIndex := Value
  else begin
    if Value < -1 then
      Value := -1
    else
      if Value >= FButtons.Count then
        Value := FButtons.Count - 1;

    if FItemIndex <> Value then begin
      if FItemIndex >= 0 then
        TsGroupButton(FButtons[FItemIndex]).Checked := False;

      FItemIndex := Value;
      if FItemIndex >= 0 then
        TsGroupButton(FButtons[FItemIndex]).Checked := True;

      if Assigned(FOnChange) then
        FOnChange(Self);
    end;
  end;
end;


procedure TsRadioGroup.SetItems(Value: {$IFDEF TNTUNICODE}TTntStrings{$ELSE}TStrings{$ENDIF});
begin
  FItems.Assign(Value);
end;


procedure TsRadioGroup.UpdateButtons;
var
  I: Integer;
begin
  if not FReading and not (csLoading in ComponentState) then begin
    SetButtonCount(FItems.Count);
    for I := 0 to FButtons.Count - 1 do begin
      TsGroupButton(FButtons[I]).Caption := FItems[I];
      TsGroupButton(FButtons[I]).Cursor := Cursor;
    end;
    ArrangeButtons;
    Invalidate;
  end;
end;


procedure TsRadioGroup.WMSize(var Message: TWMSize);
begin
  inherited;
  ArrangeButtons;
end;


procedure TsRadioGroup.WndProc(var Message: TMessage);
begin
  if Message.Msg = SM_ALPHACMD then
    case Message.WParamHi of
      AC_REFRESH:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then
          ArrangeButtons;
    end;

  inherited;
end;


constructor TsMargin.Create(Control: TControl);
begin
  inherited Create;
  FControl := Control;
  FLeft   := 2;
  FRight  := 2;
  FTop    := 0;
  FBottom := 0;
end;


procedure TsMargin.Invalidate;
begin
  if not (csLoading in FControl.ComponentState) and (FControl is TsGroupBox) then
    TsGroupBox(FControl).SkinData.Invalidate;
end;


procedure TsMargin.SetMargin(Index: Integer; Value: TacIntProperty);
begin
  case Index of
    0: if Value <> FLeft   then FLeft   := Value;
    1: if Value <> FTop    then FTop    := Value;
    2: if Value <> FRight  then FRight  := Value;
    3: if Value <> FBottom then FBottom := Value;
  end;
  Invalidate;
end;

end.
