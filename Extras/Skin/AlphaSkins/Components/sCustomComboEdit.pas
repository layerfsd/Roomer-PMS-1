unit sCustomComboEdit;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, Mask, buttons, menus,
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  {$IFDEF DELPHI6UP} Variants, {$ENDIF}
  acntUtils, sConst, sSpeedButton, sGraphUtils, sCommonData, sDefaults, sMaskEdit,
  sSkinProps, sGlyphUtils;


type
{$IFNDEF NOTFORHELP}
  TCloseUpEvent = procedure (Sender: TObject; Accept: Boolean) of object;
  TsCustomComboEdit = class;


  TsEditButton = class(TsSpeedButton)
  private
    FOwner: TsCustomComboEdit;
  public
    procedure BeginInitGlyph;
    procedure EndInitGlyph;
    constructor Create(AOwner: TComponent); override;
    procedure WndProc(var Message: TMessage); override;
    procedure PaintTo(DC: hdc; R: TPoint);
    function PrepareCache: boolean; override;
    procedure Paint; override;
    function GlyphWidth: integer; override;
    function GlyphHeight: integer; override;
  end;
{$ENDIF} // NOTFORHELP


  TsCustomComboEdit = class(TsMaskEdit)
{$IFNDEF NOTFORHELP}
  private
    FPopupWidth,
    FPopupHeight: integer;

    FReadOnly,
    FDirectInput,
    FShowButton: boolean;

    FButton: TsEditButton;
    FClickKey: TShortCut;
{$IFNDEF D2009}
    FAlignment: TAlignment;
{$ENDIF}
    FGlyphMode: TsGlyphMode;
    FDisabledKind: TsDisabledKind;
    FPopupWindowAlign: TPopupWindowAlign;
    procedure EditButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure EditButtonMouseUp  (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    function GetDroppedDown: Boolean;
    procedure SetDirectInput(Value: Boolean);
{$IFNDEF D2009}
    procedure SetAlignment(Value: TAlignment);
{$ENDIF}
    procedure SetDisabledKind(const Value: TsDisabledKind);
    procedure SetShowButton  (const Value: boolean);
    procedure CMFocuseChanged (var Message: TCMFocusChanged); message CM_FOCUSCHANGED;
    procedure CMCancelMode    (var Message: TCMCancelMode);   message CM_CANCELMODE;
    procedure WMPaste         (var Message: TWMPaste);        message WM_PASTE;
    procedure WMCut           (var Message: TWMCut);          message WM_CUT;
  protected
    FOnButtonClick: TNotifyEvent;
    procedure PaintText; override;
    procedure SetEditRect; override;
    procedure EditButtonClick(Sender: TObject);
    procedure PaintBorder(DC: hdc); override;
    procedure OurPaintHandler(DC: hdc); override;

    procedure SetReadOnly(Value: Boolean); virtual;
    function GetReadOnly: Boolean; virtual;
    procedure KeyPress(var Key: Char); override;

    procedure PopupWindowShow; virtual;
    procedure PopupWindowClose; virtual;
    procedure CreateParams(var Params: TCreateParams); override;

    procedure Change; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure ButtonClick; dynamic;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
{$IFNDEF D2009}
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
{$ENDIF}
    property PopupAlign: TPopupWindowAlign read FPopupWindowAlign write FPopupWindowAlign default pwaRight;
  public
    FDefBmpID: integer;
    FPopupWindow: TWinControl;
    constructor Create(AOwner: TComponent); override;
    procedure CreateWnd; override;
    destructor Destroy; override;
    procedure Invalidate; override;
    procedure AfterConstruction; override;
    procedure Loaded; override;

    procedure WndProc (var Message: TMessage); override;
    procedure DoClick;
    procedure SelectAll; virtual;
    property Button: TsEditButton read FButton;
    property DroppedDown: Boolean read GetDroppedDown;
    property PopupWidth: integer read FPopupWidth write FPopupWidth default 197;
    property PopupHeight: integer read FPopupHeight write FPopupHeight default 166;
{$ENDIF} // NOTFORHELP
  published
{$IFNDEF NOTFORHELP}
    property Align;
    property Anchors;
    property AutoSelect;
    property DragCursor;
    property DragMode;
    property EditMask;
    property Enabled;
    property Font;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnContextPopup;
{$ENDIF} // NOTFORHELP
    property OnButtonClick: TNotifyEvent read FOnButtonClick write FOnButtonClick;
    property ShowButton: boolean read FShowButton write SetShowButton default True;
    property ClickKey: TShortCut read FClickKey write FClickKey default scAlt + vk_Down;
    property DisabledKind: TsDisabledKind read FDisabledKind write SetDisabledKind default DefDisabledKind;
    property GlyphMode: TsGlyphMode read FGlyphMode write FGlyphMode;
    property DirectInput: Boolean read FDirectInput write SetDirectInput default True;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
  end;


implementation

uses
  {$IFDEF LOGGED}sDebugMsgs, {$ENDIF}
  sToolEdit, sVCLUtils, sMessages, sAlphaGraph, sThirdParty;


function BtnOffset(ComboEdit: TsCustomComboEdit): integer;
begin
  Result := integer(ComboEdit.BorderStyle <> bsNone) * (2 * integer(ComboEdit.Ctl3d));
end;


procedure TsEditButton.BeginInitGlyph;
begin
  if not (csLoading in ComponentState) and not (csCreating in ControlState) then begin
    SkinData.CtrlSkinState := SkinData.CtrlSkinState or ACS_LOCKED;
    if Assigned(FOwner.GlyphMode.Images) and (FOwner.GlyphMode.ImageIndex > -1) and (FOwner.GlyphMode.ImageIndex < GetImageCount(FOwner.GlyphMode.Images)) then begin
      Blend  := FOwner.GlyphMode.Blend;
      Grayed := FOwner.GlyphMode.Grayed;
      Images := FOwner.GlyphMode.Images;
      case CurrentState of
        0: ImageIndex := FOwner.GlyphMode.ImageIndex;
        1: ImageIndex := FOwner.GlyphMode.ImageIndexHot;
        2: ImageIndex := FOwner.GlyphMode.ImageIndexPressed;
      end;
      if (ImageIndex < 0) or (ImageIndex > GetImageCount(FOwner.GlyphMode.Images) - 1) then
        ImageIndex := FOwner.GlyphMode.ImageIndex;

      NumGlyphs := 1;
    end
    else begin
      Images := acResImgList;
      ImageIndex := FOwner.FDefBmpID;
      NumGlyphs := 3;
    end;
    SkinData.CtrlSkinState := SkinData.CtrlSkinState and not ACS_LOCKED;
  end;
end;


constructor TsEditButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOwner := TsCustomComboEdit(AOwner);
  SkinData.SkinSection := s_SpeedButton_Small;
  DisabledGlyphKind := [dgBlended];
{$IFDEF CHECKXP}
  Flat := True;
{$ENDIF}
  Cursor := crArrow;
  Align := alRight; // Button is aligned by right side
  Width := 22;
  ShowCaption := False;
  AnimatEvents := [aeMouseEnter, aeMouseLeave];
end;


constructor TsCustomComboEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SkinData.COC := COC_TsComboEdit;
  FDisabledKind := DefDisabledKind;
{$IFNDEF D2009}
  FAlignment := taLeftJustify;
{$ENDIF}
  AutoSize := False;
  FDirectInput := True;
  FClickKey := scAlt + vk_Down;
  FPopupWindowAlign := pwaRight;
  FShowButton := True;

  FDefBmpID := iBTN_ELLIPSIS;

  FButton := TsEditButton.Create(Self);
  FButton.Parent := Self;
  FButton.Visible := True;
  FButton.OnClick := EditButtonClick;
  FButton.OnMouseDown := EditButtonMouseDown;
  FButton.OnMouseUp := EditButtonMouseUp;

  FGlyphMode := TsGlyphMode.Create(Self);
  FGlyphMode.Btn := FButton;

  Height := 21;
  FPopupWidth := 197;
  FPopupHeight := 166;
end;


destructor TsCustomComboEdit.Destroy;
begin
  OnKeyDown := nil;
  if Assigned(FGlyphMode) then
    FreeAndNil(FGlyphMode);

  if Assigned(FButton) then
    FButton.OnClick := nil;

  inherited Destroy;
end;


procedure TsCustomComboEdit.PopupWindowShow;
var
  P: TPoint;
  Y: Integer;
  Flags: Cardinal;
  Form: TCustomForm;
begin
  if (FPopupWindow <> nil) and not (ReadOnly or DroppedDown) then begin
    FPopupWindow.Visible := False;
    FPopupWindow.Width := FPopupWidth;
    FPopupWindow.Height := FPopupHeight;
    P := Parent.ClientToScreen(Point(Left, Top));
    Y := P.Y + Height;

    if Y + FPopupWindow.Height > Screen.DesktopHeight then
      Y := P.Y - FPopupWindow.Height;

    case FPopupWindowAlign of
      pwaRight: begin
        Dec(P.X, FPopupWindow.Width - Width);
        if P.X < Screen.DesktopLeft then
          Inc(P.X, FPopupWindow.Width - Width);
      end;

      pwaLeft:
        if P.X + FPopupWindow.Width > Screen.DesktopWidth then
          Dec(P.X, FPopupWindow.Width - Width);
    end;
    if P.X < Screen.DesktopLeft then
      P.X := Screen.Desktopleft
    else
      if P.X + FPopupWindow.Width > Screen.DesktopWidth then
        P.X := Screen.DesktopWidth - FPopupWindow.Width;

    Form := GetParentForm(Self);
    if CanFocus then
      SetFocus;

    if Form <> nil then begin
      if (FPopupWindow is TForm) and (TForm(Form).FormStyle = fsStayOnTop) then
        TForm(FPopupWindow).FormStyle := fsStayOnTop;

      Flags := SWP_NOCOPYBITS or SWP_SHOWWINDOW or SWP_NOACTIVATE or SWP_NOOWNERZORDER;
      SetWindowPos(FPopupWindow.Handle, HWND_TOPMOST, P.X, Y, FPopupWindow.Width, FPopupWindow.Height, Flags);
    end;
    FPopupWindow.Visible := True;
  end;
end;


procedure TsCustomComboEdit.Change;
begin
  if not DroppedDown then
    inherited Change;
end;


procedure TsCustomComboEdit.KeyDown(var Key: Word; Shift: TShiftState);
var
  M: tagMsg;
  sc: TShortCut;
begin
  inherited KeyDown(Key, Shift);
  sc := ShortCut(Key, Shift);
  if (sc = FClickKey) and (GlyphMode.Width > 0) then begin
    EditButtonClick(Self);
    Key := 0;
  end
  else
    if (sc = scCtrl + ord('A')) then begin
      SelectAll;
      Key := 0;
      PeekMessage(M, Handle, WM_CHAR, WM_CHAR, PM_REMOVE);
    end;

  SetEditRect;
end;


procedure TsCustomComboEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not RestrictDrawing then
    SkinData.BGChanged := True;

  inherited MouseDown(Button, Shift, X, Y);
  if DroppedDown then
    PopupWindowClose;

  SetEditRect;
end;


procedure TsCustomComboEdit.SetEditRect;
var
  Loc: TRect;
begin
  if (Parent <> nil) and HandleAllocated then begin
    SendMessage(Handle, EM_GETRECT, 0, LPARAM(@Loc));
    Loc.Bottom := ClientHeight;
    Loc.Right := ClientWidth - integer(FShowButton) * FButton.Width;
    Loc.Top := 0;

    if (BorderStyle <> bsNone) then
      Loc.Left := 2 * integer(not Ctl3d)
    else
      Loc.Left := 0;

    SendMessage(Handle, EM_SETRECTNP, 0, LPARAM(@Loc));
    SendMessage(Handle, EM_GETRECT,   0, LPARAM(@Loc));  {debug}
  end;
end;


function TsCustomComboEdit.GetDroppedDown: Boolean;
begin
  Result := (FPopupWindow <> nil) and FPopupWindow.Visible;
end;


procedure TsCustomComboEdit.CMCancelMode(var Message: TCMCancelMode);
begin
  if (Message.Sender <> Self) and
       (Message.Sender <> FPopupWindow) and
         (Message.Sender <> FButton) and
           ((FPopupWindow <> nil) and IsWindowVisible(FPopupWindow.Handle) and
             not FPopupWindow.ContainsControl(Message.Sender)) then
    PopupWindowClose;
end;


procedure TsCustomComboEdit.EditButtonClick(Sender: TObject);
begin
  if not FReadOnly then
    ButtonClick;
end;


procedure TsCustomComboEdit.DoClick;
begin
  EditButtonClick(Self);
end;


procedure TsCustomComboEdit.ButtonClick;
begin
  if Assigned(FOnButtonClick) then
    FOnButtonClick(Self);

  if DroppedDown then
    PopupWindowClose
  else
    PopupWindowShow;
end;


procedure TsCustomComboEdit.SelectAll;
begin
  if (Text <> '') then
    SendMessage(Handle, EM_SETSEL, 0, -1);
end;


procedure TsCustomComboEdit.SetDirectInput(Value: Boolean);
begin
  inherited ReadOnly := not Value or FReadOnly;
  FDirectInput := Value;
end;


procedure TsCustomComboEdit.WMPaste(var Message: TWMPaste);
begin
  if FDirectInput and not ReadOnly then
    inherited;
end;


procedure TsCustomComboEdit.WMCut(var Message: TWMCut);
begin
  if FDirectInput and not ReadOnly then
    inherited;
end;


procedure TsCustomComboEdit.SetReadOnly(Value: Boolean);
begin
  if Value <> FReadOnly then begin
    FReadOnly := Value;
    inherited ReadOnly := Value or not FDirectInput;
  end;
end;


{$IFNDEF D2009}
procedure TsCustomComboEdit.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then begin
    FAlignment := Value;
    if HandleAllocated and Visible then
      SkinData.Invalidate;
  end;
end;
{$ENDIF}


procedure TsCustomComboEdit.WndProc(var Message: TMessage);
var
  DC: hdc;
  b: boolean;
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_GETBG: begin
          InitBGInfo(SkinData, PacBGInfo(Message.LParam), 0);
          PacBGInfo(Message.LParam)^.Offset.X := BorderWidth;
          PacBGInfo(Message.LParam)^.Offset.Y := PacBGInfo(Message.LParam)^.Offset.X;
          Exit;
        end;
      end;

    WM_ERASEBKGND:
      if SkinData.Skinned and IsWindowVisible(Handle) then begin
        SkinData.Updating := SkinData.Updating;
        if SkinData.Updating then
          Exit;
      end;

    CM_MOUSEENTER:
      if SkinData.FMouseAbove then
        Exit;


    WM_PRINT:
      if SkinData.Skinned then begin
        SkinData.Updating := False;
        DC := TWMPaint(Message).DC;
        if SkinData.BGChanged then
          PrepareCache;

        UpdateCorners(SkinData, 0);
        b := FButton.Visible;
        FButton.Visible := False;
        OurPaintHandler(DC);
        BitBltBorder(DC, 0, 0, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, BorderWidth);
        if ShowButton then
          FButton.PaintTo(DC, Point(FButton.Left + BtnOffset(Self), FButton.Top + BtnOffset(Self)));

        FButton.Visible := b;
        Exit;
      end;

    WM_KILLFOCUS:
      if (Self is TsDateEdit) and (FPopupWindow <> nil) then
        TForm(FPopupWindow).Close;
  end;
  inherited;
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_REMOVESKIN, AC_SETNEWSKIN, AC_REFRESH:
          if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
            AlphaBroadcast(Self, Message);
            SetEditRect;
          end;

        AC_PREPARING:
          Message.Result := 0;
      end;

    CM_ENABLEDCHANGED:
      if Assigned(Button) then
        Button.Enabled := Enabled;

    WM_SETFOCUS:
      if AutoSelect then
        SelectAll;

    WM_SIZE, CM_FONTCHANGED:
      SetEditRect;
        
    CM_EXIT:
      Repaint;
  end
end;


procedure TsCustomComboEdit.Invalidate;
begin
  inherited;
  if Assigned(FButton) and not (csLoading in FButton.ComponentState) then begin
    if not RestrictDrawing then
      FButton.SkinData.BGChanged := True;

    if FShowButton then begin
      FButton.Width := FGlyphMode.Width;
      if not FButton.Visible then begin
        FButton.Parent := Self;
        FButton.SkinData.UpdateIndexes;
        FButton.Visible := True;
      end;
    end
    else
      if FButton.Visible then begin
        FButton.Visible := False;
        FButton.Parent := nil;
        FButton.Width := 0;
      end;

    GlyphMode.Invalidate;
  end;
end;


procedure TsCustomComboEdit.PopupWindowClose;
begin
  if Assigned(FPopupWindow) and TForm(FPopupWindow).Visible then
    TForm(FPopupWindow).Close;
end;


procedure TsCustomComboEdit.CreateParams(var Params: TCreateParams);
const
  Alignments: array[TAlignment] of Longword = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_MULTILINE or Alignments[Alignment] or WS_CLIPCHILDREN;
end;


procedure TsCustomComboEdit.KeyPress(var Key: Char);
begin
  if (Key = Char(VK_RETURN)) or (Key = Char(VK_ESCAPE)) then begin
    { must catch and remove this, since is actually multi-line }
    GetParentForm(Self).Perform(CM_DIALOGKEY, Byte(Key), 0);
    if Key = Char(VK_RETURN) then begin
      inherited KeyPress(Key);
      Key := #0;
      Exit;
    end;
  end;
  inherited KeyPress(Key);
end;


procedure TsCustomComboEdit.AfterConstruction;
begin
  inherited;
  SkinData.Loaded;
end;


procedure TsCustomComboEdit.Loaded;
begin
  inherited;
  SkinData.Loaded;
  SetEditRect;
end;


procedure TsCustomComboEdit.EditButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//
end;


procedure TsCustomComboEdit.EditButtonMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//
end;


function TsCustomComboEdit.GetReadOnly: Boolean;
begin
  Result := FReadOnly;
end;


procedure TsCustomComboEdit.SetDisabledKind(const Value: TsDisabledKind);
begin
  if FDisabledKind <> Value then begin
    FDisabledKind := Value;
    SkinData.Invalidate;
  end;
end;


procedure TsCustomComboEdit.OurPaintHandler(DC: hdc);
var
  NewDC, SavedDC: hdc;
  PS: TPaintStruct;
begin
  if not InAnimationProcess {or (DC = 0)} then
    BeginPaint(Handle, PS);

  if DC = 0 then
    NewDC := GetWindowDC(Handle)
  else
    NewDC := DC;

  SavedDC := SaveDC(NewDC);
  try
    if SkinData.Skinned then begin
//      SkinData.Updating := SkinData.Updating;
      if not InUpdating(SkinData) then begin
        SkinData.BGChanged := SkinData.BGChanged or SkinData.HalfVisible or GetBoolMsg(Parent, AC_GETHALFVISIBLE);
        SkinData.HalfVisible := not RectInRect(Parent.ClientRect, BoundsRect);
        if SkinData.BGChanged then
          PrepareCache;

        UpdateCorners(SkinData, 0);
        BitBlt(NewDC, 0, 0, Width, Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
        if (not Focused{ControlIsActive(SkinData)} or (SkinData.PrintDC = NewDC)) and FButton.Visible then
          FButton.PaintTo(NewDC, Point(FButton.Left + BtnOffset(Self), FButton.Top + BtnOffset(Self)));
{$IFDEF DYNAMICCACHE}
        if Assigned(SkinData.FCacheBmp) then
          FreeAndNil(SkinData.FCacheBmp);
{$ENDIF}
      end;
    end
    else begin
      PrepareCache;
      BitBlt(NewDC, 3, 3, Width - 6, Height - 6, SkinData.FCacheBmp.Canvas.Handle, 3, 3, SRCCOPY);
      if FButton.Visible then
        FButton.Paint;
    end;
  finally
    RestoreDC(NewDC, SavedDC);
    if DC = 0 then
      ReleaseDC(Handle, NewDC);

    if not InAnimationProcess {or (DC = 0) }then
      EndPaint(Handle, PS);
  end;
end;


procedure TsCustomComboEdit.PaintBorder(DC: hdc);
const
  BordWidth = 2;
var
  NewDC, SavedDC: HDC;
begin
  if Assigned(Parent) and Visible and Parent.Visible and not (csCreating in ControlState) and not SkinData.Updating then begin
    if DC = 0 then
      NewDC := GetWindowDC(Handle)
    else
      NewDC := DC;

    SavedDC := SaveDC(NewDC);
    try
      if SkinData.BGChanged then
        PrepareCache;

      UpdateCorners(SkinData, 0);
      BitBltBorder(NewDC, 0, 0, Width, Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, BordWidth);
      if ControlIsActive(SkinData) and FButton.Visible then
        FButton.PaintTo(NewDC, Point(FButton.Left + BtnOffset(Self), FButton.Top + BtnOffset(Self)));
{$IFDEF DYNAMICCACHE}
      if Assigned(SkinData.FCacheBmp) then
        FreeAndNil(SkinData.FCacheBmp);
{$ENDIF}
    finally
      RestoreDC(NewDC, SavedDC);
      if DC = 0 then
        ReleaseDC(Handle, NewDC);
    end;
  end;
end;


procedure TsEditButton.EndInitGlyph;
begin
  if not (csLoading in ComponentState) and not (csCreating in ControlState) then begin
    SkinData.CtrlSkinState := SkinData.CtrlSkinState or ACS_LOCKED;
    Images := nil;
    SkinData.CtrlSkinState := SkinData.CtrlSkinState and not ACS_LOCKED;
  end;
end;


function TsEditButton.GlyphHeight: integer;
begin
  Result := FOwner.GlyphMode.Height;
end;


function TsEditButton.GlyphWidth: integer;
begin
  Result := FOwner.GlyphMode.Width;
end;


procedure TsEditButton.Paint;
begin
  if not FOwner.SkinData.Skinned then begin
    BeginInitGlyph;
    StdPaint(False);
    EndInitGlyph;
  end
  else
    if not (InAnimationProcess and (Canvas.Handle <> SkinData.PrintDC)) then
      inherited; // Animation under Vista fix
end;


procedure TsEditButton.PaintTo(DC: hdc; R: TPoint);
begin
  if not FOwner.SkinData.Skinned then
    Paint
  else begin
    PrepareCache;
    BitBlt(DC, R.x, R.y, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
  end;
end;


procedure TsCustomComboEdit.PaintText;
var
  SavedDC: hdc;
  R: TRect;
  bw: integer;
  aText: acString;
begin
  SkinData.FCacheBMP.Canvas.Font.Assign(Font);
  bw := BorderWidth;
  aText := EditText;
  R := Rect(bw + 2 * integer(not Ctl3D), bw, Width - bw - integer(FShowButton) * Button.Width, Height - bw);
  if Text <> '' then begin
    if PasswordChar <> #0 then
      acFillString(aText, Length(aText), acChar(PasswordChar));

    SavedDC := SaveDC(SkinData.FCacheBMP.Canvas.Handle);
    IntersectClipRect(SkinData.FCacheBMP.Canvas.Handle, 0, 0, R.Right, R.Bottom);
    try
      acWriteTextEx(SkinData.FCacheBMP.Canvas, PacChar(aText), Enabled or SkinData.Skinned, R, DT_TOP or GetStringFlags(Self, Alignment) or DT_NOPREFIX, SkinData, ControlIsActive(SkinData));
    finally
      RestoreDC(SkinData.FCacheBMP.Canvas.Handle, SavedDC);
    end;
  end
{$IFDEF D2009}
  else
    if (TextHint <> '') then begin
      SkinData.FCacheBMP.Canvas.Brush.Style := bsClear;
      if SkinData.Skinned then
        SkinData.FCacheBMP.Canvas.Font.Color := MixColors(ColorToRGB(Font.Color), ColorToRGB(Color), 0.65)
      else
        SkinData.FCacheBMP.Canvas.Font.Color := clGrayText;

      SavedDC := SaveDC(SkinData.FCacheBMP.Canvas.Handle);
      IntersectClipRect(SkinData.FCacheBMP.Canvas.Handle, 0, 0, R.Right, R.Bottom);
      try
        acDrawText(SkinData.FCacheBMP.Canvas.Handle, TextHint, R, DT_TOP or GetStringFlags(Self, Alignment) and not DT_VCENTER);
      finally
        RestoreDC(SkinData.FCacheBMP.Canvas.Handle, SavedDC);
      end;
    end;
{$ENDIF}
end;


function TsEditButton.PrepareCache: boolean;
var
  CI: TCacheInfo;
begin
  Result := True;
  BeginInitGlyph;
  InitCacheBmp(SkinData);
  BitBlt(SkinData.FCacheBmp.Canvas.Handle, 0, 0, Width, Height, FOwner.SkinData.FCacheBmp.Canvas.Handle, Left + BtnOffset(FOwner), Top + BtnOffset(FOwner), SRCCOPY);
  DrawGlyph;
  SkinData.BGChanged := False;
  EndInitGlyph;
  if not Enabled or FOwner.ReadOnly then begin
    CI := MakeCacheInfo(FOwner.SkinData.FCacheBmp, 2, 2);
    BmpDisabledKind(SkinData.FCacheBmp, DisabledKind, Parent, CI, Point(Left, Top));
  end;
end;


procedure TsEditButton.WndProc(var Message: TMessage);
begin
  if Assigned(FOwner) and Assigned(FOwner.SkinData) and FOwner.SkinData.Skinned then
    case Message.Msg of
      CM_MOUSELEAVE, WM_MOUSELEAVE:
        if not acMouseInControl(FOwner) then
          FOwner.WndProc(Message);

      CM_MOUSEENTER:
        FOwner.WndProc(Message)
    end;

  inherited;
end;


procedure TsCustomComboEdit.CMFocuseChanged(var Message: TCMFocusChanged);
begin
  if DroppedDown and (Message.Sender <> Self) then
    PopupWindowClose;

  inherited;
end;


procedure TsCustomComboEdit.SetShowButton(const Value: boolean);
begin
  if FShowButton <> Value then begin
    FShowButton := Value;
    Invalidate
  end;
end;


procedure TsCustomComboEdit.CreateWnd;
begin
  inherited;
  SetEditRect
end;


procedure TsCustomComboEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (FGlyphMode <> nil) and (AComponent = FGlyphMode.Images) then
    FGlyphMode.Images := nil;
end;

end.
