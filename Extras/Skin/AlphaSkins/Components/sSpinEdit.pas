unit sSpinEdit;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  Windows, Classes, StdCtrls, ExtCtrls, Controls, Messages, SysUtils, Forms, Graphics, buttons,
  {$IFDEF DELPHI7UP} Types, {$ENDIF}
  sEdit, acntUtils, sConst, sGraphUtils, sSpeedButton;

type
{$IFNDEF NOTFORHELP}
  TNumGlyphs = Buttons.TNumGlyphs;

  TsTimerSpeedButton = class;
  TsSpinEdit = class;


  TsSpinButton = class(TWinControl)
  private
    FOnUpClick,
    FOnDownClick: TNotifyEvent;

    FFocusControl: TWinControl;
    FOwner: TsSpinEdit;
    function CreateButton: TsTimerSpeedButton;
    function GetUpGlyph:   TBitmap;
    function GetDownGlyph: TBitmap;
    procedure SetUpGlyph  (Value: TBitmap);
    procedure SetDownGlyph(Value: TBitmap);
    procedure BtnClick    (Sender: TObject);
    procedure BtnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SetFocusBtn (Btn: TsTimerSpeedButton);
    procedure WMSize      (var Message: TWMSize);       message WM_SIZE;
    procedure WMSetFocus  (var Message: TWMSetFocus);   message WM_SETFOCUS;
    procedure WMKillFocus (var Message: TWMKillFocus);  message WM_KILLFOCUS;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure AdjustSize  (var W, H: Integer); reintroduce;
  protected
    FUpButton,
    FDownButton,
    FFocusedButton: TsTimerSpeedButton;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure WndProc(var Message: TMessage); override;
  public
    procedure SetFlat(Btn: TsTimerSpeedButton; Value: boolean);
    procedure PaintTo(DC: hdc; P: TPoint);
    constructor Create(AOwner: TComponent); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
  published
    property Align;
    property Anchors;
    property Constraints;
    property Ctl3D;
    property DownGlyph: TBitmap read GetDownGlyph write SetDownGlyph;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FocusControl: TWinControl read FFocusControl write FFocusControl;
    property ParentCtl3D;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property UpGlyph: TBitmap read GetUpGlyph write SetUpGlyph;
    property Visible;
    property OnDownClick: TNotifyEvent read FOnDownClick write FOnDownClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDock;
    property OnStartDrag;
    property OnUpClick: TNotifyEvent read FOnUpClick write FOnUpClick;
  end;
{$ENDIF} // NOTFORHELP


  TsBaseSpinEdit = class(TsEdit)
{$IFNDEF NOTFORHELP}
   private
    FEditorEnabled,
    FAllowNegative,
    FShowSpinButtons: Boolean;

    FPrevTabControl,
    FNextTabControl: TWinControl;

    FOnUpClick,
    FOnDownClick: TNotifyEvent;

    FButton: TsSpinButton;
    FAlignment: TAlignment;
    FFlatSpinButtons: Boolean;
    function GetMinHeight: Integer;
    procedure WMSize      (var Message: TWMSize);       message WM_SIZE;
    procedure WMPaste     (var Message: TWMPaste);      message WM_PASTE;
    procedure WMCut       (var Message: TWMCut);        message WM_CUT;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure SetAlignment      (const Value: TAlignment);
    procedure SetFlatSpinButtons(const Value: Boolean);
    procedure SetShowSpinButtons(const Value: Boolean);
  protected
    procedure ExcludeChildControls(DC: hdc); override;
    procedure SetEditRect;
    procedure UpClick  (Sender: TObject); virtual; abstract;
    procedure DownClick(Sender: TObject); virtual; abstract;
    procedure KeyDown   (var Key: Word; Shift: TShiftState); override;
    procedure KeyPress  (var Key: Char); override;
    function IsValidChar(var Key: Char): Boolean; virtual;
    procedure PaintText; override;
    function PrepareCache: boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    destructor Destroy; override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    property Button: TsSpinButton read FButton;
    property CharCase;
    procedure Loaded; override;
    procedure WndProc(var Message: TMessage); override;
  published
    property NextTabControl:  TWinControl  read FNextTabControl  write FNextTabControl;
    property PrevTabControl:  TWinControl  read FPrevTabControl  write FPrevTabControl;
{$ENDIF} // NOTFORHELP
    property Alignment:       TAlignment   read FAlignment       write SetAlignment       default taLeftJustify;
    property AllowNegative:   Boolean      read FAllowNegative   write FAllowNegative     default True;
    property EditorEnabled:   Boolean      read FEditorEnabled   write FEditorEnabled     default True;
    property FlatSpinButtons: Boolean      read FFlatSpinButtons write SetFlatSpinButtons default True;
    property ShowSpinButtons: Boolean      read FShowSpinButtons write SetShowSpinButtons default True;
    property OnDownClick:     TNotifyEvent read FOnDownClick     write FOnDownClick;
    property OnUpClick:       TNotifyEvent read FOnUpClick       write FOnUpClick;
  end;


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsSpinEdit = class(TsBaseSpinEdit)
{$IFNDEF NOTFORHELP}
  private
    FMinValue,
    FMaxValue,
    FIncrement: LongInt;
    function GetValue: LongInt;
    function CheckValue(NewValue: LongInt): Longint;
    procedure SetValue (NewValue: LongInt);
    procedure CMExit      (var Message: TCMExit);       message CM_EXIT;
    procedure CMMouseWheel(var Message: TCMMouseWheel); message CM_MOUSEWHEEL;
    procedure CMChanged   (var Message: TMessage);      message CM_CHANGED;
    procedure WMPaste     (var Message: TWMPaste);      message WM_PASTE;
  protected
    function IsValidChar(var Key: Char): Boolean; override;
    procedure UpClick  (Sender: TObject); override;
    procedure DownClick(Sender: TObject); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
{$ENDIF} // NOTFORHELP
    property Increment: LongInt read FIncrement write FIncrement default 1;
    property MaxValue:  LongInt read FMaxValue  write FMaxValue;
    property MinValue:  LongInt read FMinValue  write FMinValue;
    property Value:     LongInt read GetValue   write SetValue;
  end;


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsDecimalSpinEdit = class(TsBaseSpinEdit)
{$IFNDEF NOTFORHELP}
  private
    FValue,
    FMinValue,
    FMaxValue,
    FIncrement: Extended;
    fDecimalPlaces: Integer;
    FUseSystemDecSeparator: boolean;
    FHideExcessZeros: boolean;
    function GetFormattedText: string;
    procedure FormatText;
    function GetValue: Extended;
    procedure SetValue (NewValue: Extended);
    function CheckValue(NewValue: Extended): Extended;
    procedure CMExit      (var Message: TCMExit);       message CM_EXIT;
    procedure CMChanged   (var Message: TMessage);      message CM_CHANGED;
    procedure CMMouseWheel(var Message: TCMMouseWheel); message CM_MOUSEWHEEL;
    procedure WMPaste     (var Message: TWMPaste);      message WM_PASTE;
    procedure SetHideExcessZeros(const Value: boolean);
  protected
    TextChanging,
    ValueChanging: boolean;
    function IsValidChar(var Key: Char): Boolean; override;
    procedure UpClick   (Sender: TObject); override;
    procedure DownClick (Sender: TObject); override;
    procedure SetDecimalPlaces(New: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    procedure CreateWnd; override;
  published
{$ENDIF} // NOTFORHELP
    property HideExcessZeros: boolean read FHideExcessZeros write SetHideExcessZeros default False;
    property Increment: Extended read FIncrement write FIncrement;
    property MaxValue: Extended read FMaxValue write FMaxValue;
    property MinValue: Extended read FMinValue write FMinValue;
    property Value: Extended read GetValue write SetValue;
    property DecimalPlaces: Integer read fDecimalPlaces write SetDecimalPlaces default 2;
    property UseSystemDecSeparator: boolean read FUseSystemDecSeparator write FUseSystemDecSeparator default True;
  end;


{$IFNDEF NOTFORHELP}
  TTimeBtnState = set of (tbFocusRect, tbAllowTimer);


  TsTimerSpeedButton = class(TsSpeedButton)
  private
    FOwner: TsSpinButton;
    FRepeatTimer: TTimer;
    FTimeBtnState: TTimeBtnState;
    procedure TimerExpired(Sender: TObject);
  protected
    procedure Paint; override;
    procedure DrawGlyph; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    Up: boolean;
    constructor Create (AOwner: TComponent); override;
    destructor Destroy; override;
    procedure PaintTo(DC: hdc; P: TPoint);
    procedure WndProc(var Message: TMessage); override;
    property TimeBtnState: TTimeBtnState read FTimeBtnState write FTimeBtnState;
  end;


  TacTimePortion = (tvHours, tvMinutes, tvSeconds);

  
{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsTimePicker = class(TsBaseSpinEdit)
  private
    fHour,
    fMin,
    fSec: word;

    FDoBeep,
    FUse12Hour,
    FShowSeconds: boolean;
    function GetValue: TDateTime;
    procedure SetValue (NewValue: TDateTime);
    function CheckValue(NewValue: TDateTime): TDateTime;
    procedure SetShowSeconds(const Value: boolean);
    procedure SetUse12Hour  (const Value: boolean);
    procedure CMExit      (var Message: TCMExit);       message CM_EXIT;
    procedure CMMouseWheel(var Message: TCMMouseWheel); message CM_MOUSEWHEEL;
  protected
    FPos: integer;
    function IsValidChar(var Key: Char): Boolean; override;
    procedure ClickUpDown(Up: boolean);
    procedure UpClick  (Sender: TObject); override;
    procedure DownClick(Sender: TObject); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure SetHour(NewHour: integer);
    procedure SetMin (NewMin: integer);
    procedure SetSec (NewSec: integer);
    procedure DecodeValue;
    function Portion: TacTimePortion;
    procedure SetPos(NewPos: integer; Highlight: boolean = True);
    procedure IncPos;
    procedure ReplaceAtPos(APos: integer; AChar: Char);
    procedure KeyDown (var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure HighlightPos(APos: integer);
    function EmptyText: acString;
    function TextLength: integer;
    function Sec: word;
  public
    MaxHour: integer;
    constructor Create(AOwner: TComponent); override;
    procedure Loaded; override;
  published
    property Date:  TDateTime read GetValue write SetValue;
    property Value: TDateTime read GetValue write SetValue;
    property Time:  TDateTime read GetValue write SetValue;
    property DoBeep:      boolean read FDoBeep      write FDoBeep        default False;
    property ShowSeconds: boolean read FShowSeconds write SetShowSeconds default True;
    property Use12Hour:   boolean read FUse12Hour   write SetUse12Hour   default False;
  end;
{$ENDIF} // NOTFORHELP


implementation

uses
  Math, Menus,
  {$IFDEF LOGGED}sDebugMsgs, {$ENDIF}
  sSkinProps, sMessages, sCommonData, sSkinManager, sVCLUtils, sAlphaGraph, sStyleSimply;


{$IFNDEF NOTFORHELP}
const
  InitRepeatPause = 400;  { pause before repeat timer (ms) }
  RepeatPause     = 100;  { pause before hint window displays (ms)}
{$ENDIF} // NOTFORHELP


constructor TsSpinButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption];
  FOwner := TsSpinEdit(AOwner);
  FUpButton := CreateButton;
  FUpButton.Up := True;
  FDownButton := CreateButton;
  FDownButton.Up := False;
  UpGlyph := nil;
  DownGlyph := nil;
  Width := 18;
  FFocusedButton := FUpButton;
end;


function TsSpinButton.CreateButton: TsTimerSpeedButton;
begin
  Result := TsTimerSpeedButton.Create(Self);
  Result.Parent := Self;
  Result.OnClick := BtnClick;
  Result.NumGlyphs := 1;
  Result.OnMouseDown := BtnMouseDown;
  Result.Visible := True;
  Result.Enabled := True;
  Result.Flat := False;
  Result.Transparent := True;
  Result.TimeBtnState := [tbAllowTimer];
end;


procedure TsSpinButton.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FFocusControl) then
    FFocusControl := nil;
end;


procedure TsSpinButton.AdjustSize(var W, H: Integer);
begin
  if (FUpButton <> nil) and not (csLoading in ComponentState) and (H <> 0) then begin
    if W < 15 then
      W := 15;

    FUpButton.SetBounds(0, 0, W, H div 2);
    FDownButton.SetBounds(0, FUpButton.Height, W, H - FUpButton.Height);
  end;
end;


procedure TsSpinButton.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  W, H: Integer;
begin
  W := AWidth;
  H := AHeight;
  AdjustSize(W, H);
  inherited SetBounds(ALeft, ATop, W, H);
end;


procedure TsSpinButton.WMSize(var Message: TWMSize);
var
  W, H: Integer;
begin
  inherited;
  W := Width;
  H := Height;
  AdjustSize(W, H);
  if (W <> Width) or (H <> Height) then
    inherited SetBounds(Left, Top, W, H);

  Message.Result := 0;
end;


procedure TsSpinButton.WMSetFocus(var Message: TWMSetFocus);
begin
  FFocusedButton.TimeBtnState := FFocusedButton.TimeBtnState + [tbFocusRect];
  FFocusedButton.Invalidate;
end;


procedure TsSpinButton.WMKillFocus(var Message: TWMKillFocus);
begin
  FFocusedButton.TimeBtnState := FFocusedButton.TimeBtnState - [tbFocusRect];
  FFocusedButton.Invalidate;
end;


procedure TsSpinButton.BtnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then begin
    SetFocusBtn(TsTimerSpeedButton (Sender));
    if (FFocusControl <> nil) and FFocusControl.TabStop and FFocusControl.CanFocus and (GetFocus <> FFocusControl.Handle) then
      FFocusControl.SetFocus
    else
      if TabStop and (GetFocus <> Handle) and CanFocus then
        SetFocus;
  end;
end;


procedure TsSpinButton.BtnClick(Sender: TObject);
begin
  if Sender = FUpButton then begin
    if Assigned(FOnUpClick) then
      FOnUpClick(Self);
  end
  else
    if Assigned(FOnDownClick) then
      FOnDownClick(Self);
end;


procedure TsSpinButton.SetFlat(Btn: TsTimerSpeedButton; Value: boolean);
var
  Side: TacSide;
begin
  if (Btn.SkinData.SkinManager <> nil) and Btn.SkinData.SkinManager.CommonSkinData.Active then begin
    if Btn = FUpButton then
      Side := asTop
    else
      Side := asBottom;

    Btn.SkinData.SkinSection := iff(FOwner.FlatSpinButtons, s_ToolButton, Btn.SkinData.SkinManager.ConstData.UpDownBtns[Side].SkinSection);
    if Btn.SkinData.SkinIndex < 0 then
      Btn.SkinData.SkinSection := s_Button;
  end
  else begin
    Btn.SkinData.SkinSection := iff(FOwner.FlatSpinButtons, s_ToolButton, s_UpDown);
    Btn.Flat := Value;
  end;
end;


procedure TsSpinButton.SetFocusBtn(Btn: TsTimerSpeedButton);
begin
  if TabStop and CanFocus and  (Btn <> FFocusedButton) then begin
    FFocusedButton.TimeBtnState := FFocusedButton.TimeBtnState - [tbFocusRect];
    FFocusedButton := Btn;
    if (GetFocus = Handle) then begin
      FFocusedButton.TimeBtnState := FFocusedButton.TimeBtnState + [tbFocusRect];
      Invalidate;
    end;
  end;
end;


procedure TsSpinButton.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS;
end;


procedure TsSpinButton.Loaded;
var
  W, H: Integer;
begin
  inherited Loaded;
  W := Width;
  H := Height;
  AdjustSize(W, H);
  if (W <> Width) or (H <> Height) then
    inherited SetBounds(Left, Top, W, H);

  FUpButton.SkinData.SkinManager   := FOwner.SkinData.FSkinManager;
  FDownButton.SkinData.SkinManager := FOwner.SkinData.FSkinManager;
end;


function TsSpinButton.GetUpGlyph: TBitmap;
begin
  Result := FUpButton.Glyph;
end;


procedure TsSpinButton.SetUpGlyph(Value: TBitmap);
begin
  FUpButton.Glyph := Value
end;


function TsSpinButton.GetDownGlyph: TBitmap;
begin
  Result := FDownButton.Glyph;
end;


procedure TsSpinButton.SetDownGlyph(Value: TBitmap);
begin
  FDownButton.Glyph := Value
end;


procedure TsSpinButton.WndProc(var Message: TMessage);
var
  PS: TPaintStruct;
  BordWidth: integer;
begin
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_GETBG: begin
          BordWidth := integer(FOwner.BorderStyle <> bsNone) * (1 + integer(FOwner.Ctl3d));
{$IFDEF DELPHI7UP}
          if BordWidth = 0 then begin
            if FOwner.BevelInner <> bvNone then
              inc(BordWidth);

            if FOwner.BevelOuter <> bvNone then
              inc(BordWidth);
          end;
{$ENDIF}
          FOwner.SkinData.CtrlSkinState := FOwner.SkinData.CtrlSkinState or ACS_BGRECEIVING;
          if FOwner.SkinData.BGChanged then
            SendAMessage(FOwner.Handle, AC_PREPARECACHE);

          PacBGInfo(Message.LParam).BgType := btCache;
          PacBGInfo(Message.LParam).Color  := SendMessage(FOwner.Handle, SM_ALPHACMD, MakeWParam(0, AC_GETCONTROLCOLOR), 0);
          PacBGInfo(Message.LParam).Bmp    := FOwner.SkinData.FCacheBmp;
          PacBGInfo(Message.LParam).Offset := Point(Left + BordWidth, Top + BordWidth);
          FOwner.SkinData.CtrlSkinState := FOwner.SkinData.CtrlSkinState and not ACS_BGRECEIVING;
          Exit;
        end;

        AC_PREPARING: begin
          Message.Result := LRESULT(FOwner.SkinData.FUpdating);
          Exit;
        end;

        AC_ENDPARENTUPDATE:
          Exit;
      end;

    WM_PAINT:
      if FOwner.SkinData.Skinned and not FOwner.Enabled then begin
        BeginPaint(Handle, PS);
        EndPaint  (Handle, PS);
        Exit;
      end;

    WM_ERASEBKGND:
      if not FOwner.Enabled or FOwner.SkinData.Updating then
        Exit;
  end;
  inherited;
  case Message.Msg of
    CM_ENABLEDCHANGED: begin
      SetUpGlyph  (nil);
      SetDownGlyph(nil);
    end;
  end;
end;


procedure TsSpinButton.PaintTo(DC: hdc; P: TPoint);
begin
  if FUpButton.CurrentState = 0 then
    FUpButton.PaintTo(DC, P);

  inc(P.Y, FUpButton.Height);
  if FDownButton.CurrentState = 0 then
    FDownButton.PaintTo(DC, P);
end;


constructor TsBaseSpinEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csSetCaption] + [csAcceptsControls];
  FButton := TsSpinButton.Create(Self);
  FButton.Visible := False;
  FButton.Parent := Self;
  FButton.FocusControl := Self;
  FButton.OnUpClick := UpClick;
  FButton.OnDownClick := DownClick;
  FButton.SetUpGlyph(nil);
  FButton.SetDownGlyph(nil);
  FButton.Visible := True;
  ControlStyle := ControlStyle - [csAcceptsControls];
  FAlignment := taLeftJustify;
  FEditorEnabled := True;
  FShowSpinButtons := True;
  FFlatSpinButtons := True;
  FAllowNegative := True;
end;


destructor TsBaseSpinEdit.Destroy;
begin
  FButton := nil;
  inherited Destroy;
end;


procedure TsBaseSpinEdit.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
//
end;


procedure TsBaseSpinEdit.KeyDown(var Key: Word; Shift: TShiftState);
var
  myForm: TCustomForm;
  CtlDir: integer;
  M: tagMsg;
begin
  inherited KeyDown(Key, Shift);
  case Key of
    VK_UP:
      UpClick(Self);

    VK_DOWN:
      DownClick(Self);

    VK_TAB, VK_RETURN: begin
      if ssShift in Shift then begin
        CtlDir := 1;
        if Assigned(FPrevTabControl) then begin
          Key := 0;
          FPrevTabControl.SetFocus;
          Exit;
        end;
      end
      else begin
        if Assigned(FNextTabControl) then begin
          Key := 0;
          FNextTabControl.SetFocus;
          Exit;
        end;
        CtlDir := 0;
      end;
      if VK_TAB = Key then begin
        myForm := GetParentForm(Self);
        if not (MYForm = nil) then
          SendMessage(myForm.Handle, WM_NEXTDLGCTL, CtlDir, 0);

        Exit;
      end;
    end;

    ord('A'):
      if (ShortCut(Key, Shift) = scCtrl + ord('A')) then begin
        SelectAll;
        Key := 0;
        PeekMessage(M, Handle, WM_CHAR, WM_CHAR, PM_REMOVE);
      end;
  end;
  if Key <> 0 then
    SetEditRect;
end;


procedure TsBaseSpinEdit.KeyPress(var Key: Char);
var
  err: boolean;
  C: Char;
begin
  C := Key;
  err := not IsValidChar(C);
  if err or (C = #0) then begin
    if (C = #0) then
      Key := #0;

    if err then
      MessageBeep(0);
  end
  else
    inherited KeyPress(Key);
end;


function TsBaseSpinEdit.IsValidChar(var Key: Char): Boolean;
begin
  Result := CharInSet(Key, [{$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}DecimalSeparator, CharPlus, CharMinus, ZeroChar..'9']) or
            ((Key < #32) and (Key <> Chr(VK_RETURN)));
  if Result then
    Result := (FAllowNegative or (Key <> CharMinus));

  if not FEditorEnabled and Result and ((Key >= #32) or CharInSet(Key, [Char(VK_BACK), Char(VK_DELETE)])) then
    Result := False;

  if Result then begin
    Result := False;
    case Key of
      Chr(VK_RETURN), Chr(VK_TAB): begin
        Result := True;
        Key := #0;
      end;

      Char(VK_BACK), Chr(VK_ESCAPE):
        Result := True;

      CharMinus:
        if not fAllowNegative then
          Result := False
        else begin
          if (Length(Text) > 0) then begin
            if SelLength = 0 then
              if Text[1] = CharMinus then
                Result := False
              else begin
                SelStart := 0;
                if Text[1] = CharPlus then
                  SelLength := 1;

                Result := True;
              end
            else
              if (DWord(SendMessage(Handle, EM_GETSEL, 0, 0)) mod $10000 = 0) then
                Result := True;
          end
          else
            Result := True;
        end;

      CharPlus:
        if (Length(Text) > 0) then begin
          if SelLength = 0 then
            if Text[1] = CharPlus then
              Result := False
            else begin
              SelStart := 0;
              if Text[1] = CharMinus then
                SelLength := 1;

              Result := True;
            end
          else
            if (DWord(SendMessage(Handle, EM_GETSEL, 0, 0)) mod $10000 = 0) then
              Result := True;
        end
        else
          Result := True;

    else
      Result := True;
    end;
  end;
end;


procedure TsBaseSpinEdit.CreateParams(var Params: TCreateParams);
const
  Alignments: array[TAlignment] of Longword = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN or Alignments[FAlignment] and not WS_BORDER;
end;


procedure TsBaseSpinEdit.CreateWnd;
begin
  inherited CreateWnd;
  SetEditRect;
end;


procedure TsBaseSpinEdit.SetEditRect;
var
  Loc: TRect;
begin
  SendMessage(Handle, EM_GETRECT, 0, LPARAM(@Loc));
  Loc.TopLeft := MkPoint;
  Loc.Bottom := ClientHeight + 1;  {+1 is workaround for windows paint bug}
  Loc.Right := Width - FButton.Width * Ord(FButton.Visible and ShowSpinButtons) - 3;
  SendMessage(Handle, EM_SETRECTNP, 0, LPARAM(@Loc));
  SendMessage(Handle, EM_GETRECT,   0, LPARAM(@Loc));  {debug}
end;


procedure TsBaseSpinEdit.SetFlatSpinButtons(const Value: Boolean);
begin
  if FFlatSpinButtons <> Value then begin
    FFlatSpinButtons := Value;
    FButton.SetFlat(FButton.FUpButton, FlatSpinButtons);
    FButton.SetFlat(FButton.FDownButton, FlatSpinButtons);
    SkinData.Invalidate;
  end;
end;

procedure TsBaseSpinEdit.WMSize(var Message: TWMSize);
var
  MinHeight: Integer;
begin
  inherited;
  MinHeight := GetMinHeight;
  if Height < MinHeight then
    Height := MinHeight
  else
    if (FButton <> nil) and ShowSpinButtons then begin
      FButton.SetBounds(Width - FButton.Width - 4, 0, FButton.Width, Height - 4);
      SetEditRect;
    end;
end;


function TsBaseSpinEdit.GetMinHeight: Integer;
begin
  Result := 0;
end;


procedure TsBaseSpinEdit.WMPaste(var Message: TWMPaste);
begin
  if FEditorEnabled and not ReadOnly then
    inherited;
end;


procedure TsBaseSpinEdit.WMCut(var Message: TWMPaste);
begin
  if FEditorEnabled and not ReadOnly then
    inherited;
end;


procedure TsBaseSpinEdit.Loaded;
begin
  inherited;
  FButton.Visible := FShowSpinButtons;
  FButton.Parent := Self;
  FButton.SetUpGlyph(nil);
  FButton.SetDownGlyph(nil);
  FButton.SetFlat(FButton.FUpButton,   FlatSpinButtons);
  FButton.SetFlat(FButton.FDownButton, FlatSpinButtons);
  SetEditRect;
end;


constructor tsSpinEdit.Create(AOwner:TComponent);
begin
  inherited create(AOwner);
  FIncrement := 1;
end;


procedure TsSpinEdit.CMExit(var Message: TCMExit);
begin
  inherited;
  if (Text = '-0') or (Text = CharMinus) or (Text = '+0') or (Text = CharPlus) then
    Text := ZeroChar;

  if CheckValue(Value) <> Value then
    SetValue(Value);
end;


procedure TsSpinEdit.UpClick(Sender: TObject);
begin
  if ReadOnly then
    MessageBeep(0)
  else
    if Assigned(FOnUpClick) then
      FOnUpClick(Self)
    else
      Value := Value + FIncrement;
end;


procedure TsSpinEdit.DownClick (Sender: TObject);
begin
  if ReadOnly then
    MessageBeep(0)
  else
    if Assigned(FOnDownClick) then
      FOnDownClick(Self)
    else
      Value := Value - FIncrement;
end;


function TsSpinEdit.GetValue: LongInt;
begin
  if Text <> '' then
    try
      Result := StrToInt(Text);
    except
      Result := FMinValue;
    end
  else
    Result := 0;
end;


procedure TsSpinEdit.SetValue(NewValue: LongInt);
begin
  if (NewValue < 0) and not FAllowNegative then
    NewValue := max(0, FMinValue);

  if not (csLoading in ComponentState) then
    Text := IntToStr(CheckValue(NewValue));
end;


function TsSpinEdit.CheckValue(NewValue: LongInt): LongInt;
begin
  if (NewValue < 0) and not FAllowNegative then
    Result := max(0, FMinValue)
  else
    Result := NewValue;

  if ((FMinValue <> 0) or (FMinValue <> FMaxValue)) and (NewValue < FMinValue) then
    Result := FMinValue
  else
    if (FMaxValue <> 0) and (NewValue > FMaxValue) then
      Result := FMaxValue;
end;


function TsSpinEdit.IsValidChar(var Key: Char): Boolean;
begin
  Result := inherited IsValidChar(Key);
  if Result then
    if Key = CharMinus then
      if not fAllowNegative then
        Result := False
      else
        Result := (MinValue <= 0);

  if not Result then
    Key := #0;
end;


procedure TsSpinEdit.CMMouseWheel(var Message: TCMMouseWheel);
begin
  inherited;
  if not ReadOnly and (Message.Result = 0) then begin
    Value := Value + Increment * (Message.WheelDelta div 120);
    Message.Result := 1
  end;
end;


procedure TsSpinEdit.WMPaste(var Message: TWMPaste);
{$IFDEF DELPHI6UP}
var
  OldValue, NewValue: integer;
{$ENDIF}
begin
  if FEditorEnabled and not ReadOnly then begin
{$IFDEF DELPHI6UP}
    OldValue := Value;
{$ENDIF}
    inherited;
{$IFDEF DELPHI6UP}
    if not TryStrToInt(Text, NewValue) then
      Text := IntToStr(OldValue);
{$ENDIF}
  end;
end;


procedure TsSpinEdit.CMChanged(var Message: TMessage);
begin
  inherited;
//  if Value > MaxValue then
//    Value := MaxValue;

{  if not (csLoading in ComponentState) and not ValueChanging then begin
    TextChanging := True;
    if (Text = '') or (Text = CharMinus) or (Text = CharPlus) then
      Value := 0
    else
      Value := StrToFloat(Text);

    TextChanging := False;
  end;}
end;


constructor TsDecimalSpinEdit.Create(AOwner:TComponent);
begin
   inherited create(AOwner);
   ValueChanging := False;
   TextChanging := False;
   FUseSystemDecSeparator := True;
   FHideExcessZeros := False;
   FIncrement := 1.0;
   FDecimalPlaces := 2;
end;


procedure TsDecimalSpinEdit.CMExit(var Message: TCMExit);
begin
  inherited;
  if CheckValue(Value) <> Value then
    SetValue(Value);

  FormatText;
end;


procedure TsDecimalSpinEdit.UpClick(Sender: TObject);
var
  CurValue: real;
begin
  if ReadOnly then MessageBeep(0) else begin
    CurValue := Value;
    if Assigned(FOnUpClick) then
      FOnUpClick(Self)
    else
      Value := CurValue + FIncrement;
  end;
end;


procedure TsDecimalSpinEdit.DownClick(Sender: TObject);
var
  CurValue: real;
begin
  if ReadOnly then
    MessageBeep(0)
  else begin
    CurValue := Value;
    if Assigned(FOnDownClick) then
      FOnDownClick(Self)
    else
      Value := CurValue - FIncrement;
  end;
end;


procedure TsDecimalSpinEdit.SetDecimalPlaces(New: Integer);
begin
  if fDecimalPlaces <> New then begin
    fDecimalPlaces := New;
    Value := CheckValue(Value);
  end;
end;


procedure TsDecimalSpinEdit.SetHideExcessZeros(const Value: boolean);
begin
  if FHideExcessZeros <> Value then begin
    FHideExcessZeros := Value;
    if not (csLoading in ComponentState) then
      Text := GetFormattedText;
  end;
end;


procedure TsDecimalSpinEdit.SetValue(NewValue: Extended);
begin
  if (NewValue < 0) and not FAllowNegative then
    NewValue := max(0, FMinValue);

  if MaxValue > MinValue then
    FValue := max(min(NewValue, MaxValue), MinValue)
  else
    FValue := NewValue;

  ValueChanging := True;
  if not TextChanging then begin
    SendMessage(Handle, WM_SETTEXT, 0, LPARAM(PChar(GetFormattedText)));
    if not (csLoading in ComponentState) and Assigned(OnChange) then
      OnChange(Self);
  end;
  ValueChanging := False;
end;


function TsDecimalSpinEdit.CheckValue(NewValue: Extended): Extended;
begin
  if (NewValue < 0) and not FAllowNegative then
    Result := max(0, FMinValue)
  else
    Result := NewValue;

  if (FMinValue <> 0) and (NewValue < FMinValue) then
    Result := FMinValue
  else
    if (FMaxValue <> 0) and (NewValue > FMaxValue) then
      Result := FMaxValue;
end;


function TsDecimalSpinEdit.IsValidChar(var Key: Char): Boolean;
begin
  Result := inherited IsValidChar(Key);
  if Result then
    case Key of
      CharMinus:
        if not fAllowNegative then
          Result := False
        else
          Result := (MinValue <= 0);
    end;

  if not Result then
    Key := #0;
end;


procedure TsDecimalSpinEdit.CMMouseWheel(var Message: TCMMouseWheel);
begin
  inherited;
  if not ReadOnly and (Message.Result = 0) then begin
    Value := Value + Increment * (Message.WheelDelta div 120);
    Message.Result := 1
  end;
end;


function TsDecimalSpinEdit.GetFormattedText: string;
var
  l: integer;
begin
  Result := FloatToStrF(CheckValue(FValue), ffFixed, 18, FDecimalPlaces);
  if FHideExcessZeros then
    while True do begin
      l := Length(Result);
      if l > 0 then
        case Result[l] of
          ',', '.': begin
            Delete(Result, l, 1);
            Exit;
          end;

          '0':
            Delete(Result, l, 1)

          else
            Exit;
        end
      else
        Exit;
    end;
end;


function TsDecimalSpinEdit.GetValue: Extended;
{$IFDEF DELPHI6UP}
var
  v: Extended;
{$ENDIF}
begin
  if not TextChanging then
    Result := FValue
  else
{$IFDEF DELPHI6UP}
    if TryStrToFloat(Text, V) then
      Result := V
    else
      Result := 0;
{$ELSE}
  try
    if Text = '' then
      Result := 0
    else
      Result := StrToFloat(Text);
  except
    Result := 0;
  end;
{$ENDIF}
end;


procedure TsDecimalSpinEdit.CreateWnd;
begin
  inherited;
end;


procedure TsDecimalSpinEdit.CMChanged(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) and not ValueChanging then begin
    TextChanging := True;
    if (Text = '') or (Text = CharMinus) or (Text = CharPlus) then
      Value := 0
    else
{$IFDEF DELPHI6UP}
      Value := StrToFloatDef(Text, 0);
{$ELSE}
      Value := StrToFloat(Text);
{$ENDIF}

    TextChanging := False;
  end;
end;


procedure TsDecimalSpinEdit.FormatText;
begin
  ValueChanging := True;
  if not TextChanging then
    SendMessage(Handle, WM_SETTEXT, 0, LPARAM(PChar(GetFormattedText)));

  ValueChanging := False;
end;


procedure TsDecimalSpinEdit.WMPaste(var Message: TWMPaste);
{$IFDEF DELPHI6UP}
var
  OldValue, NewValue: extended;
{$ENDIF}
begin
  if FEditorEnabled and not ReadOnly then begin
{$IFDEF DELPHI6UP}
    OldValue := Value;
{$ENDIF}
    inherited;
{$IFDEF DELPHI6UP}
    if not TryStrToFloat(Text, NewValue) then
      Text := FloatToStr(OldValue);
{$ENDIF}
  end;
end;


destructor TsTimerSpeedButton.Destroy;
begin
  if FRepeatTimer <> nil then
    FreeAndNil(FRepeatTimer);

  inherited Destroy;
end;


procedure TsTimerSpeedButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  Down := True;
  if tbAllowTimer in FTimeBtnState then begin
    if FRepeatTimer = nil then
      FRepeatTimer := TTimer.Create(Self);

    FRepeatTimer.OnTimer := TimerExpired;
    FRepeatTimer.Interval := InitRepeatPause;
    FRepeatTimer.Enabled  := True;
  end;
end;


procedure TsTimerSpeedButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Down := False;
  inherited MouseUp(Button, Shift, X, Y);
  if FRepeatTimer <> nil then
    FRepeatTimer.Enabled  := False;
end;


procedure TsTimerSpeedButton.TimerExpired(Sender: TObject);
begin
  FRepeatTimer.Interval := RepeatPause;
  if MouseCapture then
    try
      Click;
    except
      FRepeatTimer.Enabled := False;
      raise;
    end;
end;


procedure TsTimerSpeedButton.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_REFRESH:
          FOwner.SetFlat(Self, FOwner.FOwner.FlatSpinButtons);
      end;
  end;
  inherited;
end;


procedure TsTimerSpeedButton.Paint;
var
  R: TRect;
begin
  if not (csDestroying in ComponentState) and not (csLoading in ComponentState) {and not InAnimationProcess }then begin
    inherited Paint;
    if (tbFocusRect in FTimeBtnState) and SkinData.SkinManager.ButtonsOptions.ShowFocusRect then begin
      R := Bounds(0, 0, Width, Height);
      InflateRect(R, -3, -3);
      if Down then
        OffsetRect(R, 1, 1);

      DrawFocusRect(Canvas.Handle, R);
    end;
  end;
end;


constructor TsTimerSpeedButton.Create(AOwner: TComponent);
begin
  FOwner := TsSpinButton(AOwner);
  inherited Create(AOwner);
end;


procedure TsBaseSpinEdit.WndProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    WM_KILLFOCUS: begin
      StopTimer(SkinData);
      StopTimer(FButton.FUpButton.SkinData);
      StopTimer(FButton.FDownButton.SkinData);
    end;
  end;
  inherited;
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_REMOVESKIN, AC_SETNEWSKIN, AC_REFRESH:
          if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
            FButton.FUpButton.Perform  (Message.Msg, Message.WParam, Message.LParam);
            FButton.FdownButton.Perform(Message.Msg, Message.WParam, Message.LParam);
            if Message.WParamHi in [AC_REFRESH, AC_REMOVESKIN] then begin
              FButton.FUpButton.Invalidate;
              FButton.FDownButton.Invalidate;
            end
            else begin
              FButton.FUpButton.Enabled := True;
              FButton.FDownButton.Enabled := True;
            end;
            if (AC_SETNEWSKIN <> Message.WParamHi) and not SkinData.BGChanged then begin
              FButton.SetUpGlyph(nil);
              FButton.SetDownGlyph(nil);
            end;
            SetEditRect;
          end;

        AC_ENDPARENTUPDATE:
          if not InUpdating(SkinData) and FButton.HandleAllocated then
            RedrawWindow(FButton.Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW or RDW_ALLCHILDREN);
//            FButton.Repaint;

        AC_GETBG:
          InitBGInfo(SkinData, PacBGInfo(Message.LParam), 0);

        AC_GETCONTROLCOLOR:
          Message.Result := GetBGColor(SkinData, 0);

        AC_PREPARECACHE:
          PrepareCache;
      end;

    CM_ENABLEDCHANGED: begin
      FButton.Enabled := Enabled;
      if SkinData.Skinned then begin
        FButton.Visible := ShowSpinButtons and Enabled;
        if FButton.Visible then
          FButton.Parent := Self
        else
          FButton.Parent := nil;
      end
      else begin
        FButton.FUpButton.Enabled := Enabled;
        FButton.FDownButton.Enabled := Enabled;
      end
    end;

    WM_PAINT:
      if SkinData.Skinned then
        if not InUpdating(SkinData) and Enabled then begin
          Button.FUpButton.Perform  (SM_ALPHACMD, MakeWParam(0, AC_STOPFADING), 0);
          Button.FDownButton.Perform(SM_ALPHACMD, MakeWParam(0, AC_STOPFADING), 0);
          if not TabStop and ShowSpinButtons and not Focused then // Repaint of hidden buttons
            FButton.Repaint;
        end;

    WM_PRINT: begin
      MoveWindowOrg(TWMPaint(Message).DC, 2, 2);
      IntersectClipRect(TWMPaint(Message).DC, 0, 0, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height);
    end;

    WM_SIZE, CM_FONTCHANGED:
      SetEditRect;

    WM_SETFOCUS:
      if AutoSelect then
        Self.SelectAll;

    CM_MOUSELEAVE: begin
      SkinData.BGChanged := True; // Update cache will be required (repaint buttons there)
//      PrepareCache;
    end;

    CM_COLORCHANGED: begin
      if SkinData.CustomColor then
        PrepareCache;

      RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE);
    end;
  end;
end;


procedure TsTimerSpeedButton.PaintTo(DC: hdc; P: TPoint);
begin
  PrepareCache;
  BitBlt(DC, P.X, P.Y, Width, Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
end;


procedure TsTimerSpeedButton.DrawGlyph;
var
  C: TColor;
  P: TPoint;
  aCanvas: TCanvas;
begin
  if (Glyph = nil) or Glyph.Empty then begin
    if SkinData.SkinIndex >= 0 then
      if (CurrentState = 0) and (FOwner.FOwner <> nil) then
        if FOwner.FOwner.FlatSpinButtons or (SkinData.SkinManager.gd[SkinData.SkinIndex].Props[0].Transparency = 100) then
          C := ColorToRGB(SkinData.SkinManager.gd[FOwner.FOwner.SkinData.SkinIndex].Props[0].FontColor.Color)//FOwner.FOwner.Font.Color
        else
          C := ColorToRGB(SkinData.SkinManager.gd[SkinData.SkinIndex].Props[0].FontColor.Color)
      else
        if not FOwner.FOwner.SkinData.CustomFont then
          if FOwner.FOwner.FlatSpinButtons or (SkinData.SkinManager.gd[SkinData.SkinIndex].Props[1].Transparency = 100) then
            C := ColorToRGB(SkinData.SkinManager.gd[SkinData.SkinIndex].Props[1].FontColor.Color)
          else
            C := ColorToRGB(SkinData.SkinManager.gd[FOwner.FOwner.SkinData.SkinIndex].Props[0].FontColor.Color)//FOwner.FOwner.Font.Color
        else
          C := ColorToRGB(iff(Enabled, ColorToRGB(SkinData.SkinManager.gd[FOwner.FOwner.SkinData.SkinIndex].Props[0].FontColor.Color), clGrayText))
    else
      C := FOwner.FOwner.Font.Color;

    if SkinData.Skinned then
      aCanvas := SkinData.FCacheBmp.Canvas
    else
      aCanvas := Canvas;

    aCanvas.Pen.Color := C;
    aCanvas.Brush.Style := bsSolid;
    aCanvas.Brush.Color := clFuchsia;
    aCanvas.FillRect(MkRect(Glyph));

    aCanvas.Pen.Style := psSolid;
    aCanvas.Brush.Color := C;

    P.X := (Width  - 9) div 2;
    P.Y := (Height - 5) div 2;

    if Up then
      aCanvas.Polygon([Point(P.X + 1, P.Y + 4), Point(P.X + 7, P.Y + 4), Point(P.X + 4, P.Y + 1)])
    else
      aCanvas.Polygon([Point(P.X + 1, P.Y + 1), Point(P.X + 7, P.Y + 1), Point(P.X + 4, P.Y + 4)]);
  end
  else
    inherited;
end;


constructor TsTimePicker.Create(AOwner:TComponent);
begin
  inherited create(AOwner);
  MaxHour := 24;
  FShowSeconds := True;
  FDoBeep := False;
  fHour := 0;
  fMin := 0;
  fSec := 0;
end;


procedure TsTimePicker.CMExit(var Message: TCMExit);
begin
  inherited;
  if CheckValue(Value) <> Value then
    SetValue(Value);
end;


procedure TsTimePicker.ClickUpDown(Up: boolean);
var
  cPortion: TacTimePortion;
  Increment: integer;
begin
  cPortion := Portion;
  if ReadOnly then begin
    if FDoBeep then
      MessageBeep(0);
  end
  else
    if length(Text) = TextLength then begin
      Increment := iff(Up, 1, -1);
      DecodeValue;
      case Portion of
        tvHours:   SetHour(FHour + Increment);
        tvMinutes: SetMin (FMin  + Increment);
        tvSeconds: SetSec (FSec  + Increment);
      end;
      if ShowSeconds then
        Text := Format('%0.2d:%0.2d:%0.2d', [fHour, fMin, fSec])
      else
        Text := Format('%0.2d:%0.2d', [fHour, fMin]);

      if (not (csLoading in ComponentState)) then begin
        case cPortion of
          tvHours:   SelStart := 0;
          tvMinutes: SelStart := 3;
          tvSeconds: SelStart := 6;
        end;
        FPos := SelStart + 2;
        SelLength := 2;
      end;
    end;
end;


procedure TsTimePicker.UpClick(Sender: TObject);
begin
  ClickUpDown(True);
end;


procedure TsTimePicker.DownClick(Sender: TObject);
begin
  ClickUpDown(False);
end;


function TsTimePicker.GetValue: TDateTime;
begin
  Result := 0;
  if Length(Text) = TextLength then
    try
      DecodeValue;
      Result := EncodeTime(FHour, FMin, Sec, 0)
    except
      Result := 0;
    end;
end;


procedure TsTimePicker.SetValue(NewValue: TDateTime);
var
  NewText: String;
  dMSec: Word;
begin
  DecodeTime(NewValue, FHour, FMin, FSec, dMSec);
  if ShowSeconds then
    NewText := Format('%0.2d:%0.2d:%0.2d', [FHour, FMin, FSec])
  else
    NewText := Format('%0.2d:%0.2d', [FHour, FMin]);

  if not (csLoading in ComponentState) then
    Text := NewText;
end;


function TsTimePicker.CheckValue (NewValue: TDateTime): TDateTime;
begin
  Result := integer(NewValue >= 0) * NewValue;
end;


function TsTimePicker.IsValidChar(var Key: Char): Boolean;
var
  i: integer;
{$IFDEF TNTUNICODE}
  c: PWideChar;
{$ENDIF}
  s: string;
begin
  Result := False;
  if not FEditorEnabled or ReadOnly or CharInSet(Key, [Chr(VK_ESCAPE), Chr(VK_RETURN), #0]) then
    Key := #0
  else begin
    Result := CharInSet(Key, [ZeroChar..'9']);
    if Result then begin
{$IFDEF TNTUNICODE}
      c := PWideChar(Text);
      s := WideCharToString(c);
{$ELSE}
      s := Text;
{$ENDIF}
      case FPos of
        1: i := StrToInt(Key  + s[2]);
        2: i := StrToInt(s[1] + Key);
        4: i := StrToInt(Key  + s[4]);
        5: i := StrToInt(s[4] + Key);
        7: i := StrToInt(Key  + s[8]);
        8: i := StrToInt(s[7] + Key)
        else begin // If selected all
          FPos := 1;
          i := StrToInt(Key + s[2]);
        end
      end;
      if FPos in [1, 2] then
        if (FPos = 1) and (StrToInt(Key) > 2) then
          Result := False
        else begin
          if (i > 23) then
            if AllEditSelected(Self) then begin
              s[2] := '3';
              Text := s;
            end
            else
              Result := False;
        end
      else
        if i > 59 then
          Result := False;
    end;
    if not Result then
      Key := #0;
  end;
end;


function TsBaseSpinEdit.PrepareCache: boolean;
var
  bw: integer;
  BGInfo: TacBGInfo;
begin
  Result := False;
  BGInfo.BgType := btUnknown;
  GetBGInfo(@BGInfo, Parent);
  if BGInfo.BgType <> btNotReady then begin
    InitCacheBmp(SkinData);
    if BorderStyle = bsSingle then
      PaintItem(SkinData, BGInfoToCI(@BGInfo), True, integer(ControlIsActive(SkinData)), MkRect(Self), Point(Left, top), SkinData.FCacheBmp, False)
    else
      PaintItemBG(SkinData, BGInfoToCI(@BGInfo), integer(ControlIsActive(SkinData)), MkRect(Self), Point(Left, Top), SkinData.FCacheBmp);

    if SkinData.CustomColor then begin
      bw := integer(BorderStyle <> bsNone) * (1 + integer(Ctl3d));
      FillDC(SkinData.FCacheBmp.Canvas.Handle, Rect(bw, bw, Width - bw, Height - bw), Color);
    end;
    PaintText;
    if ShowSpinButtons and (not Enabled or not ControlIsActive(SkinData)) then begin
      bw := integer(BorderStyle <> bsNone) * (1 + integer(Ctl3d));
      SkinData.FCacheBmp.Canvas.Lock;

//      if ShowSpinButtons and not (SkinData.AnimTimer <> nil) and (SkinData.AnimTimer.Enabled or (SkinData.AnimTimer.State <> -1)) and
//           (SkinData.CtrlSkinState and ACS_BGRECEIVING <> ACS_BGRECEIVING) then

//      if ShowSpinButtons and //(not ((SkinData.AnimTimer <> nil) and (SkinData.AnimTimer.Enabled or (SkinData.AnimTimer.State <> -1))) and
//           (SkinData.CtrlSkinState and ACS_BGRECEIVING <> ACS_BGRECEIVING) then
        FButton.PaintTo(SkinData.FCacheBmp.Canvas.Handle, Point(FButton.Left + bw, FButton.Top + bw));

      SkinData.FCacheBmp.Canvas.UnLock;
    end;
    if not Enabled then
      BmpDisabledKind(SkinData.FCacheBmp, DisabledKind, Parent, GetParentCache(SkinData), Point(Left, Top));

    SkinData.BGChanged := False;
    Result := True;
  end;
end;


procedure TsTimePicker.KeyDown(var Key: Word; Shift: TShiftState);
var
  M: tagMsg;
begin
  case Key of
    VK_UP:
      UpClick(Self);

    VK_DOWN:
      DownClick(Self);

    VK_RIGHT:
      if (Shift = []) then
        IncPos
      else begin
        FPos := min(TextLength, FPos + 1);
        inherited;
        Exit;
      end;

    VK_LEFT:
      if (Shift = []) then
        SetPos(max(1, FPos - 1 - integer(FPos in [4, 7])), (Shift = []))
      else begin
        FPos := max(1, FPos - 1);
        inherited;
        exit;
      end;

    VK_BACK, VK_DELETE:
      if not AllEditSelected(Self) then begin
        ReplaceAtPos(FPos, ZeroChar);
        if Key = VK_BACK then begin
          Key := VK_LEFT;
          KeyDown(Key, Shift);
        end
        else begin
          HighlightPos(FPos);
          Key := 0;
        end
      end
      else
        if not ReadOnly then begin
          if (not (csLoading in ComponentState)) and not (csDesigning in ComponentState) and Visible then begin
            SelStart := 0;
            SelLength := 0;
          end;
          Text := EmptyText;
          SetPos(1);
        end;

    ord('A'): 
      if (ShortCut(Key, Shift) = scCtrl + ord('A')) then begin
        Key := 0;
        SelectAll;
        PeekMessage(M, Handle, WM_CHAR, WM_CHAR, PM_REMOVE);
      end;
  end;
  if Key in [VK_BACK, VK_SPACE, VK_LEFT..VK_DOWN, VK_DELETE] then
    Key := 0;

  inherited;
  case Key of
    VK_END: begin
      FPos := TextLength;
      if (Shift = []) then begin
        if (not (csLoading in ComponentState)) and not (csDesigning in ComponentState) and Visible then begin
          SelStart := TextLength - 1;
          SelLength := 1;
        end;
        Key := 0;
      end;
    end;

    VK_HOME: begin
      if (Shift = []) then begin
        if (not (csLoading in ComponentState)) and not (csDesigning in ComponentState) and Visible then begin
          SelStart := 0;
          SelLength := 1;
        end;
        Key := 0;
      end
      else
        SelStart := FPos;

      FPos := 1;
    end;
  end
end;


procedure TsTimePicker.KeyPress(var Key: Char);
var
  C: Char;
begin
  C := Key;
  if not IsValidChar(C) then
    if C = #0 then begin
      Key := #0;
      if FDoBeep then
        MessageBeep(0);
    end
    else
      inherited
  else begin
    if AllEditSelected(Self) then
      SetPos(1);

    inherited;
    if Key <> #0 then
      ReplaceAtPos(FPos, Key);

    Key := #0;
    IncPos;
  end;
end;


procedure TsTimePicker.HighlightPos(APos: integer);
begin
  if (not (csLoading in ComponentState)) and not (csDesigning in ComponentState) and Visible then begin
    SelStart := APos - 1;
    SelLength := 1;
  end
end;


procedure TsTimePicker.SetPos(NewPos: integer; Highlight: boolean);
begin
  FPos := NewPos;
  if FPos in [3, 6] then
    dec(FPos);

  if Highlight then
    HighlightPos(FPos);
end;


procedure TsTimePicker.ReplaceAtPos(APos: integer; AChar: Char);
var
  s: string;
begin
  if FEditorEnabled and (APos <= Length(Text)) then begin
    s := Text;
    s[APos] := AChar;
    Text := s;
  end;
end;


procedure TsTimePicker.IncPos;
begin
  SetPos(min(TextLength, FPos + 1 + integer(FPos in [2, 5])));
end;


function TsTimePicker.Portion: TacTimePortion;
var
  FCurPos: DWord;
begin
  FCurPos := DWord(SendMessage(Handle, EM_GETSEL, 0, 0)) mod $10000;
  case FCurPos of
    0..2: Result := tvHours;
    3..5: Result := tvMinutes
    else  Result := tvSeconds;
  end
end;


procedure TsTimePicker.DecodeValue;
var
  s: string;
begin
  s := Text;
  FHour := StrToInt(copy(s, 1, 2));
  FMin  := StrToInt(copy(s, 4, 2));
  if (TextLength <= Length(Text)) and ShowSeconds then
    FSec := StrToInt(copy(s, 7, 2))
  else
    FSec := 0;
end;


procedure TsTimePicker.SetHour(NewHour: integer);
begin
  if NewHour >= MaxHour then
    SetHour(NewHour - MaxHour)
  else
    if NewHour < 0 then
      SetHour(NewHour + MaxHour)
    else
      FHour := NewHour;
end;


procedure TsTimePicker.SetMin(NewMin: integer);
begin
  if NewMin >= 60 then begin
    SetHour(FHour + 1);
    SetMin(NewMin - 60);
  end
  else
    if NewMin < 0 then begin
      SetHour(FHour - 1);
      SetMin(NewMin + 60);
    end
    else
      FMin := NewMin
end;


procedure TsTimePicker.SetSec(NewSec: integer);
begin
  if NewSec >= 60 then begin
    SetMin(FMin + 1);
    SetSec(NewSec - 60);
  end
  else
    if NewSec < 0 then begin
      SetMin(FMin - 1);
      SetSec(NewSec + 60);
    end
    else
      FSec := NewSec
end;


procedure TsTimePicker.Loaded;
begin
  inherited;
  if AllEditSelected(Self) then
    FPos := TextLength + 1
  else
    SetPos(1);

  if Text = '' then
    Text := EmptyText;
end;


procedure TsTimePicker.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if SelLength = 0 then begin
    FPos := DWord(SendMessage(Handle, EM_GETSEL, 0, 0)) mod $10000;
    SetPos(min(TextLength, FPos) + 1)
  end
  else
    FPos := SelStart + 1;
end;


procedure TsTimePicker.SetShowSeconds(const Value: boolean);
var
  CurValue: TDateTime;
begin
  if FShowSeconds <> Value then begin
    CurValue := Self.Value;
    FShowSeconds := Value;
    SetValue(CurValue);
    if not (csLoading in ComponentState) and Visible then
      Repaint;
  end;
end;


function TsTimePicker.EmptyText: acString;
begin
  Result := iff(ShowSeconds, '00:00:00', '00:00');
end;


function TsTimePicker.TextLength: integer;
begin
  Result := iff(ShowSeconds, 8, 5);
end;


function TsTimePicker.Sec: word;
begin
  Result := integer(FShowSeconds) * FSec
end;


procedure TsTimePicker.SetUse12Hour(const Value: boolean);
begin
  FUse12Hour := Value;
  MaxHour := iff(Value, 12, 24);
end;


procedure TsBaseSpinEdit.SetAlignment(const Value: TAlignment);
begin
  if FAlignment <> Value then begin
    FAlignment := Value;
    RecreateWnd;
  end;
end;


procedure TsBaseSpinEdit.PaintText;
var
  R: TRect;
  s: acString;
  i, BordWidth: integer;
  Flags: Cardinal;
begin
  SkinData.FCacheBMP.Canvas.Font.Assign(Font);
  if BorderStyle <> bsNone then begin
    BordWidth := 1 + integer(Ctl3D);
    BordWidth := BordWidth {$IFDEF DELPHI7UP} + integer(BevelKind <> bkNone) * (integer(BevelOuter <> bvNone) + integer(BevelInner <> bvNone)) {$ENDIF};
  end
  else
    BordWidth := 0;

  Flags := DT_TOP or DT_NOPREFIX or DT_SINGLELINE;
  R := Rect(BordWidth + 1, BordWidth + 1, Width - BordWidth - FButton.Width * integer(FShowSpinButtons), Height - BordWidth);
{$IFDEF TNTUNICODE}
  if PasswordChar <> #0 then
    for i := 1 to Length(Text) do
      s := s + PasswordChar
  else
    s := Text;

  acWriteTextEx(SkinData.FCacheBMP.Canvas, PacChar(s), True, R, Flags or Cardinal(GetStringFlags(Self, Alignment)) and not DT_VCENTER, SkinData, ControlIsActive(SkinData));
{$ELSE}
  if PasswordChar <> #0 then
    for i := 1 to Length(Text) do
      s := s + PasswordChar
  else
    s := Text;

  acWriteTextEx(SkinData.FCacheBMP.Canvas, PacChar(s), True, R, Flags or Cardinal(GetStringFlags(Self, Alignment)) and not DT_VCENTER, SkinData, ControlIsActive(SkinData));
{$ENDIF}
end;


procedure TsBaseSpinEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  Message.Result := Message.Result and not DLGC_WANTALLKEYS;
end;


procedure TsTimePicker.CMMouseWheel(var Message: TCMMouseWheel);
begin
  inherited;
  if not ReadOnly and (Message.Result = 0) then
    if Message.WheelDelta < 0 then
      DownClick(Self)
    else
      if Message.WheelDelta > 0 then
        UpClick(Self);
end;


procedure TsBaseSpinEdit.SetShowSpinButtons(const Value: Boolean);
begin
  if FShowSpinButtons <> Value then begin
    FShowSpinButtons := Value;
    Button.Visible := Value;
    if FButton.Visible then
      FButton.Parent := Self
    else
      FButton.Parent := nil;

    if not (csLoading in ComponentState) then begin
      SetEditRect;
      SkinData.BGChanged := True;
      RedrawWindow(Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_ALLCHILDREN or RDW_UPDATENOW);
      if FButton.Visible then
        FButton.Repaint;
    end;
  end;
end;


procedure TsBaseSpinEdit.ExcludeChildControls(DC: hdc);
var
  i, bw: integer;
begin
  if ControlCount <> 0 then begin
    bw := integer(BorderStyle <> bsNone) * (2 + integer(Ctl3d)) - 1;
    for i := 0 to ControlCount - 1 do
      if not (Controls[i] is TsSpinButton) then
        ExcludeClipRect(DC, Controls[i].Left + bw, Controls[i].Top + bw, Controls[i].BoundsRect.Right + bw, Controls[i].BoundsRect.Bottom + bw);
  end;
end;

end.
