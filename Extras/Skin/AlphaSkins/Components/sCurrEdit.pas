unit sCurrEdit;
{$I sDefs.inc}

interface

uses SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, Mask, 
  {$IFNDEF ALITE}sCalcUnit, {$ENDIF}
  sCustomComboEdit, acntUtils, sConst;

  
type
{$IFNDEF NOTFORHELP}
  TsCustomNumEdit = class(TsCustomComboEdit)
  private
    FValue,
    FMinValue,
    FMaxValue: Extended;

    FFocused,
    FBeepOnError,
    FCheckOnExit,
    FFlatButtons,
    FFormatOnEditing,
    FFormatting: Boolean;

    FCanvas: TControlCanvas;
    FAlignment: TAlignment;
    FDecimalPlaces: Cardinal;
    FDisplayFormat: string;
    function GetValue: Extended;
    function GetAsInteger: Longint;
    function GetText: string;
    function GetDisplayFormat: string;
    function TextToValText(const AValue: string): string;
    function CheckValue(NewValue: Extended): Extended;
    function IsFormatStored: Boolean;

    procedure SetFocused       (AValue: Boolean);
    procedure SetAlignment     (AValue: TAlignment);
    procedure SetBeepOnError   (AValue: Boolean);
    procedure SetDisplayFormat (AValue: string);
    procedure SetDecimalPlaces (AValue: Cardinal);
    procedure SetValue         (AValue: Extended);
    procedure SetMaxValue      (AValue: Extended);
    procedure SetMinValue      (AValue: Extended);
    procedure SetText          (AValue: string);

    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit (var Message: TCMExit ); message CM_EXIT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
{$IFNDEF FPC}
{$IFNDEF ALITE}
    procedure CalcWindowClose(Sender: TObject; var Action: TCloseAction);
{$ENDIF}
{$ENDIF}
  protected
    procedure Change; override;
    procedure ReformatEditText;
    procedure DataChanged;
    function DefFormat: string;
    procedure KeyPress(var Key: Char); override;
    function IsValidChar(Key: Char): Boolean;
    function FormatDisplayText(AValue: Extended): string;
    function GetDisplayText: string; virtual;
    procedure Reset; override;
    procedure CheckRange;
    procedure UpdateData;
    property Formatting: Boolean read FFormatting;
    property Alignment: TAlignment read FAlignment write SetAlignment default taRightJustify;
    property BeepOnError: Boolean read FBeepOnError write SetBeepOnError default True;
    property CheckOnExit: Boolean read FCheckOnExit write FCheckOnExit default False;
    property DecimalPlaces: Cardinal read FDecimalPlaces write SetDecimalPlaces default 2;
    property DisplayFormat: string read GetDisplayFormat write SetDisplayFormat stored IsFormatStored;
    property MaxValue: Extended read FMaxValue write SetMaxValue;
    property MinValue: Extended read FMinValue write SetMinValue;
    property Text: string read GetText write SetText stored False;
    property MaxLength default 0;
    procedure PopupWindowShow; override;
    property ClickKey;
    procedure PaintText; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear; override;
    procedure WndProc(var Message: TMessage); override;
    property AsInteger: Longint read GetAsInteger;
    property DisplayText: string read GetDisplayText;
    property DroppedDown;
    property Value: Extended read GetValue write SetValue;
  published
    property FlatButtons: boolean read FFlatButtons write FFlatButtons default False;
    property PopupWidth  default 216;
    property PopupHeight default 136;
  end;
{$ENDIF} // NOTFORHELP


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsCalcEdit = class(TsCustomNumEdit)
  public
    property AsInteger;
{$IFNDEF NOTFORHELP}
    constructor Create(AOwner: TComponent); override;
  published
    property ClickKey;
    property AutoSelect;
    property BeepOnError;
    property DirectInput;
    property DragCursor;
    property Enabled;
    property Font;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property ParentFont;
    property ParentShowHint;
    property PopupAlign;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnButtonClick;
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
{$ENDIF} // NOTFORHELP
    property Alignment;
    property CheckOnExit;
    property DecimalPlaces;
    property DisplayFormat;
    property MaxValue;
    property MinValue;
    property Text;
    property Value;
  end;

implementation

uses sVclUtils, sMessages, sGraphUtils, sCommonData, sGlyphUtils;


constructor TsCustomNumEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAlignment := taRightJustify;
  FDisplayFormat := DefFormat;
  MaxLength := 0;
  FDecimalPlaces := 2;
  FBeepOnError := True;
  FFormatOnEditing := False;
  FFlatButtons := False;
  inherited Text := '';
  inherited Alignment := taLeftJustify;
  DataChanged;
  PopupWidth := 216;
  PopupHeight := 136;
end;


destructor TsCustomNumEdit.Destroy;
begin
  if FPopupWindow <> nil then
    FreeAndNil(FPopupWindow);

  if Assigned(FCanvas) then
    FreeAndNil(FCanvas);

  inherited Destroy;
end;


function TsCustomNumEdit.DefFormat: string;
begin
  Result := '### ### ##0.00;-### ### ##0.00;0';
end;


function TsCustomNumEdit.IsFormatStored: Boolean;
begin
  Result := (DisplayFormat <> DefFormat);
end;


function TsCustomNumEdit.IsValidChar(Key: Char): Boolean;
var
  S: string;
  SelStart, SelStop, DecPos: Integer;
  RetValue: Extended;
begin
  Result := False;
  if (Key = CharMinus) and ((MinValue >= 0) and (MaxValue <> MinValue)) then
    Exit;

  S := EditText;
  GetSel(SelStart, SelStop);
  System.Delete(S, SelStart + 1, SelStop - SelStart);
  System.Insert(Key, S, SelStart + 1);
  S := TextToValText(S);
  DecPos := Pos({$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}DecimalSeparator, S);
  if (DecPos > 0) then begin
    SelStart := Pos('E', UpperCase(S));
    if (SelStart > DecPos) then
      DecPos := SelStart - DecPos
    else
      DecPos := Length(S) - DecPos;

    if DecPos > Integer(FDecimalPlaces) then
      Exit;
  end;
  Result := IsValidFloat(S, RetValue);
  if Result and (FMinValue >= 0) and (FMaxValue > 0) and (RetValue < 0) then
    Result := False;
end;


procedure TsCustomNumEdit.KeyPress(var Key: Char);
var
  p: DWord;
begin
  if Assigned(FPopupWindow) and IsWindowVisible(FPopupWindow.Handle) then begin
{$IFNDEF ALITE}
    TsCalcForm(FPopupWindow).OnKeyPress(FPopupWindow, Key);
{$ENDIF}    
    Key := #0;
  end
  else begin
    if CharInSet(AnsiChar(Key), [s_Dot, s_Comma] - [{$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}ThousandSeparator]) then
      Key := {$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}DecimalSeparator;

    inherited KeyPress(Key);
    if not CharInSet(Key, [#3, #22]) then begin // Ctrl-C, Ctrl-V
      if CharInSet(Key, [#43{'+'}, #45{'-'}, #47{'/'}, #42{'*'}, #37{'%'}]) then begin
        p := DWord(SendMessage(Handle, EM_GETSEL, 0, 0)) mod $10000;
        if p = 0 then begin
          if (Key <> #45) then
            Key := #0;

          Exit;
        end;

        if (Key = #45) and (Value = 0) or not ShowButton then
          Exit;

        EditButtonClick(Self);
{$IFNDEF ALITE}
        if Assigned(FPopupWindow) and IsWindowVisible(FPopupWindow.Handle) then
          TsCalcForm(FPopupWindow).OnKeyPress(FPopupWindow, Key);
{$ENDIF}          

        Key := #0;
      end
      else
        if not CharInSet(Key, [#8]) and not IsValidChar(Key) then begin
          if BeepOnError then
            MessageBeep(0);

          Key := #0;
        end
        else
          if Key = #27 then begin
            Reset;
            Key := #0;
          end;
    end;
  end;
end;


procedure TsCustomNumEdit.Reset;
begin
  DataChanged;
  SelectAll;
end;


procedure TsCustomNumEdit.SetBeepOnError(AValue: Boolean);
begin
  if FBeepOnError <> AValue then
    FBeepOnError := AValue;
end;


procedure TsCustomNumEdit.SetAlignment(AValue: TAlignment);
begin
  if FAlignment <> AValue then begin
    FAlignment := AValue;
    SkinData.Invalidate;
  end;
end;


procedure TsCustomNumEdit.SetDisplayFormat(AValue: string);
begin
  if DisplayFormat <> AValue then begin
    FDisplayFormat := AValue;
    SkinData.Invalidate;
    DataChanged;
  end;
end;


function TsCustomNumEdit.GetDisplayFormat: string;
begin
  Result := FDisplayFormat;
end;


procedure TsCustomNumEdit.SetFocused(AValue: Boolean);
begin
  if FFocused <> AValue then begin
    FFocused := AValue;
    if not Focused or not AutoSelect then
      SkinData.Invalidate;

    FFormatting := True;
    try
      DataChanged;
    finally
      FFormatting := False;
    end;
  end;
end;


procedure TsCustomNumEdit.SetDecimalPlaces(AValue: Cardinal);
begin
  if FDecimalPlaces <> AValue then begin
    FDecimalPlaces := AValue;
    DataChanged;
    SkinData.Invalidate;
  end;
end;


function TsCustomNumEdit.FormatDisplayText(AValue: Extended): string;
begin
  if DisplayFormat <> '' then begin
    Result := FormatFloat(DisplayFormat, AValue);
    while (Length(Result) > 0) and (Result[1] = s_Space) do
      Delete(Result, 1, 1); // Del leading spaces
  end
  else
    Result := FloatToStr(AValue);
end;


function TsCustomNumEdit.GetDisplayText: string;
begin
  if not Focused then
    Result := FormatDisplayText(StrToFloat(TextToValText(Text)))
  else
    Result := EditText;
end;


procedure TsCustomNumEdit.Clear;
begin
  Text := '';
end;


procedure TsCustomNumEdit.DataChanged;
var
  EditFormat: string;
begin
  if EditMask = '' then begin
    EditFormat := ZeroChar;
    if FDecimalPlaces > 0 then
      EditFormat := EditFormat + s_Dot + MakeStr(CharDiez, FDecimalPlaces);

    EditText := FormatFloat(EditFormat, FValue);
  end;
end;


function TsCustomNumEdit.CheckValue(NewValue: Extended): Extended;
begin
  Result := NewValue;
  if (FMaxValue <> FMinValue) then
    if (FMaxValue > FMinValue) then begin
      if NewValue < FMinValue then
        Result := FMinValue
      else
        if NewValue > FMaxValue then
          Result := FMaxValue;
    end
    else
      if FMaxValue = 0 then begin
        if NewValue < FMinValue then
          Result := FMinValue;
      end
      else
        if FMinValue = 0 then
          if NewValue > FMaxValue then
            Result := FMaxValue;
end;


procedure TsCustomNumEdit.CheckRange;
begin
  if not (csDesigning in ComponentState) and CheckOnExit then
    CheckValue(StrToFloat(TextToValText(EditText)));
end;


procedure TsCustomNumEdit.UpdateData;
var
  s: string;
  Minus: integer;
begin
  s := Text;
  if pos(CharMinus, s) = 1 then begin
    Delete(s, 1, 1);
    Minus := -1
  end
  else
    Minus := 1;

  FValue := CheckValue(StrToFloat(TextToValText(ZeroChar + s)) * Minus);
end;


function TsCustomNumEdit.GetValue: Extended;
begin
  if not (csDesigning in ComponentState) then
    try
      UpdateData;
    except
      FValue := FMinValue;
    end;

  Result := FValue;
end;


procedure TsCustomNumEdit.SetValue(AValue: Extended);
begin
  FValue := CheckValue(AValue);
  DataChanged;
  SkinData.Invalidate;
end;


function TsCustomNumEdit.GetAsInteger: Longint;
begin
  Result := Trunc(Value);
end;


procedure TsCustomNumEdit.SetMinValue(AValue: Extended);
begin
  if FMinValue <> AValue then begin
    FMinValue := AValue;
    Value := FValue;
  end;
end;


procedure TsCustomNumEdit.SetMaxValue(AValue: Extended);
begin
  if FMaxValue <> AValue then begin
    FMaxValue := AValue;
    Value := FValue;
  end;
end;


function TsCustomNumEdit.GetText: string;
begin
  Result := inherited Text;
  Result := DelChars(Result, CharQuest);
  Result := DelChars(Result, #13);
  Result := DelChars(Result, #10);
end;


function TsCustomNumEdit.TextToValText(const AValue: string): string;
begin
  Result:= StringReplace(AValue, s_Space, '', [rfIgnoreCase, rfReplaceAll]);
  if {$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}DecimalSeparator <> {$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}ThousandSeparator then
    Result := DelChars(Result, {$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}ThousandSeparator);

  if ({$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}DecimalSeparator <> s_Dot) and ({$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}ThousandSeparator <> s_Dot) then
    Result := ReplaceStr(Result, s_Dot, {$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}DecimalSeparator);

  if ({$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}DecimalSeparator <> s_Comma) and ({$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}ThousandSeparator <> s_Comma) then
    Result := ReplaceStr(Result, s_Comma, {$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}DecimalSeparator);

  if Result = '' then
    Result := ZeroChar
  else
    if Result = CharMinus then
      Result := '-0';
end;


procedure TsCustomNumEdit.SetText(AValue: string);
begin
  if not (csReading in ComponentState) then begin
    FValue := CheckValue(StrToFloat(TextToValText(AValue)));
    DataChanged;
    SkinData.Invalidate;
  end;
end;


procedure TsCustomNumEdit.ReformatEditText;
var
  S: string;
  IsEmpty: Boolean;
  OldLen, SelStart, SelStop: Integer;
begin
  FFormatting := True;
  try
    S := inherited Text;
    OldLen := Length(S);
    IsEmpty := (OldLen = 0) or (S = CharMinus);
    if HandleAllocated then
      GetSel(SelStart, SelStop);

    if not IsEmpty then
      S := TextToValText(S);

    S := FormatFloatStr(S, Pos(s_Comma, DisplayFormat) > 0);
    inherited Text := S;
    if HandleAllocated and (GetFocus = Handle) and not (csDesigning in ComponentState) then begin
      Inc(SelStart, Length(S) - OldLen);
      SetCursor(SelStart);
    end;
  finally
    FFormatting := False;
  end;
end;


procedure TsCustomNumEdit.Change;
begin
  if not FFormatting then begin
    if FFormatOnEditing and FFocused then
      ReformatEditText;

    inherited Change;
  end;
end;


procedure TsCustomNumEdit.WMPaste(var Message: TMessage);
var
  S: string;
begin
  S := EditText;
  try
    inherited;
    UpdateData;
  except
    EditText := S;
    SelectAll;
    if CanFocus then
      SetFocus;

    if BeepOnError then
      MessageBeep(0);
  end;
end;


procedure TsCustomNumEdit.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);
  if FFormatOnEditing then
    ReformatEditText;

  inherited;
end;


procedure TsCustomNumEdit.CMExit(var Message: TCMExit);
begin
  try
    CheckRange;
    UpdateData;
  except
    SelectAll;
    if CanFocus then
      SetFocus;

    raise;
  end;
  SetFocused(False);
  SetCursor(0);
  DoExit;
end;


procedure TsCustomNumEdit.PopupWindowShow;
begin
  FadingForbidden := True;
{$IFNDEF ALITE}
  if not Assigned(FPopupWindow) then begin
    FPopupWindow := TsCalcForm.Create(Self);
    with TsCalcForm(FPopupWindow) do begin
      ChangeBtnsStyle(FlatButtons);
      TsCalcForm(FPopupWindow).Height := PopupHeight - TsCalcForm(FPopupWindow).sDragBar1.Height - TsCalcForm(FPopupWindow).FDisplayPanel.Height;
    end;
  end;
  with TsCalcForm(FPopupWindow) do begin
    Position := poDefault;
    FDisplayPanel.Visible := False;
    if sDragBar1 <> nil then
      sDragBar1.Visible := False;

    FPrecision := 16;
    FEditor := Self;
    if SkinData.Skinned then begin
      FMainPanel.BorderStyle := bsNone;
      FDisplayPanel.BorderStyle := bsNone;
    end
    else begin
      FMainPanel.Ctl3D := False;
      FMainPanel.BorderStyle := bsSingle;
      FDisplayPanel.BorderStyle := bsSingle;
    end;
    SetText(Text);
    OnClose := CalcWindowClose;
  end;
{$ENDIF}
  inherited;
  FadingForbidden := False;
end;


procedure TsCustomNumEdit.PaintText;
var
  R: TRect;
  s: string;
  bw: integer;
  al: TAlignment;
begin
  SkinData.FCacheBMP.Canvas.Font.Assign(Font);
  bw := BorderWidth;
  R := Rect(bw, bw, Width - bw - integer(ShowButton) * Button.Width, Height - bw);

  if Focused then
    al := taLeftJustify
  else
    al := Alignment;

  if PasswordChar = #0 then
    WriteTextEx(SkinData.FCacheBMP.Canvas, PChar(DisplayText), True, R, DT_TOP or GetStringFlags(Self, al) or DT_NOPREFIX,
              SkinData, ControlIsActive(SkinData))
  else begin
    SetLength(s, Length(EditText));
    FillChar(s[1], Length(s), PasswordChar);
    WriteTextEx(SkinData.FCacheBMP.Canvas, PChar(s), True, R, DT_TOP or DT_SINGLELINE or DT_WORDBREAK or GetStringFlags(Self, al) or DT_NOPREFIX,
              SkinData, ControlIsActive(SkinData));
  end;
end;


procedure TsCustomNumEdit.WndProc(var Message: TMessage);
begin
  inherited;
  if Message.Msg = SM_ALPHACMD then
    case Message.WParamHi of
      AC_SETNEWSKIN, AC_REFRESH:
        if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) and Assigned(FPopupWindow) then
          AlphaBroadCast(FPopupWindow, Message);
    end;
end;


constructor TsCalcEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDefBmpID := iBTN_CALC;
end;


{$IFNDEF FPC}
{$IFNDEF ALITE}
procedure TsCustomNumEdit.CalcWindowClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
end;
{$ENDIF}
{$ENDIF}

end.
