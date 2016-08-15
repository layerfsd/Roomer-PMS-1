unit sCalcUnit;
{$I sDefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ExtCtrls, Menus, Clipbrd, Mask, Buttons,
  sConst, sPanel, sSpeedButton, sSkinProvider;


type
  TsCalcState = (csFirst, csValid, csError);

  TsCalcForm = class(TForm)
    FMainPanel: TsPanel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    OK1: TMenuItem;
    Cancel1: TMenuItem;
    FCalculatorPanel: TsPanel;
    sSpeedButton1: TsSpeedButton;
    sSpeedButton2: TsSpeedButton;
    sSpeedButton3: TsSpeedButton;
    sSpeedButton4: TsSpeedButton;
    sSpeedButton5: TsSpeedButton;
    sSpeedButton6: TsSpeedButton;
    sSpeedButton7: TsSpeedButton;
    sSpeedButton8: TsSpeedButton;
    sSpeedButton9: TsSpeedButton;
    sSpeedButton10: TsSpeedButton;
    sSpeedButton11: TsSpeedButton;
    sSpeedButton12: TsSpeedButton;
    sSpeedButton13: TsSpeedButton;
    sSpeedButton14: TsSpeedButton;
    sSpeedButton15: TsSpeedButton;
    sSpeedButton16: TsSpeedButton;
    sSpeedButton17: TsSpeedButton;
    sSpeedButton18: TsSpeedButton;
    sSpeedButton19: TsSpeedButton;
    sSpeedButton20: TsSpeedButton;
    sSpeedButton21: TsSpeedButton;
    sSpeedButton22: TsSpeedButton;
    sSpeedButton23: TsSpeedButton;
    sSpeedButton24: TsSpeedButton;
    sSpeedButton25: TsSpeedButton;
    sSpeedButton26: TsSpeedButton;
    FCalcPanel: TsPanel;
    sDragBar1: TsDragBar;
    sToolButton3: TsSpeedButton;
    sToolButton1: TsSpeedButton;
    FDisplayPanel: TsPanel;
    sPanel2: TsPanel;
    sSpeedButton27: TsSpeedButton;
    procedure sSpeedButton22Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure sSpeedButton24Click(Sender: TObject);
    procedure sSpeedButton23Click(Sender: TObject);
    procedure sSpeedButton25Click(Sender: TObject);
    procedure sSpeedButton26Click(Sender: TObject);
    procedure sSpeedButton19Click(Sender: TObject);
    procedure sSpeedButton13Click(Sender: TObject);
    procedure sSpeedButton7Click(Sender: TObject);
    procedure sSpeedButton21Click(Sender: TObject);
    procedure sSpeedButton15Click(Sender: TObject);
    procedure sSpeedButton9Click(Sender: TObject);
    procedure sSpeedButton3Click(Sender: TObject);
    procedure OK1Click(Sender: TObject);
    procedure Cancel1Click(Sender: TObject);
    procedure sSpeedButton2Click(Sender: TObject);
    procedure sSpeedButton14Click(Sender: TObject);
    procedure sSpeedButton8Click(Sender: TObject);
    procedure sSpeedButton20Click(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sToolButton3Click(Sender: TObject);
    procedure sToolButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sSpeedButton27Click(Sender: TObject);
  protected
    FOperand: Extended;

    FOnOk,
    FOnError,
    FOnCancel,
    FOnResult,
    FOnTextChange,
    FOnDisplayChange: TNotifyEvent;

    FOnCalcKey: TKeyPressEvent;
  private
//    Rects: TRects;
    procedure TextChanged;
  public
    FText: string;
    FMemory: Extended;
    FPrecision: Byte;
    FBeepOnError: Boolean;
    FStatus: TsCalcState;
    FOperator: Char;
    FEditor: TCustomMaskEdit;
//    procedure FillArOR;
//    function GetRgnFromRects: hrgn;
    function GetValue: Variant;
    procedure WndProc (var Message: TMessage); override;
    procedure SetValue(const Value: Variant);
    procedure SetText(const Value: string);
    procedure ChangeBtnsStyle(Flat: boolean);
    procedure CheckFirst;
    procedure CalcKey(Key: Char);
    procedure Clear;
    procedure Error;
    procedure SetDisplay(R: Extended);
    function GetDisplay: Extended;
    procedure UpdateMemoryLabel;
    procedure Copy;
    procedure Paste;

    property DisplayValue: Extended read GetDisplay write SetDisplay;
    property Text: string read FText;
    property OnResultClick:   TNotifyEvent   read FOnResult        write FOnResult;
    property OnError:         TNotifyEvent   read FOnError         write FOnError;
    property OnTextChange:    TNotifyEvent   read FOnTextChange    write FOnTextChange;
    property OnDisplayChange: TNotifyEvent   read FOnDisplayChange write FOnDisplayChange;
    property OnCalcKey:       TKeyPressEvent read FOnCalcKey       write FOnCalcKey;
  end;


implementation

uses sCurrEdit, sCustomComboEdit, acntUtils, sSkinManager, sGraphUtils, sMessages, sVCLUtils, sSkinProps;

{$R *.dfm}

const
  ResultKeys = [#13, '=', '%'];


var
  s_Close:    acString = '';
  s_Minimize: acString = '';


procedure TsCalcForm.CalcKey(Key: Char);
var
  R: Extended;
  Editor: TsCalcEdit;
begin
  Key := UpCase(Key);
  if (FStatus = csError) and (Key <> 'C') and (Key <> 'CE') then
    Key := #0;

  if Assigned(FOnCalcKey) then
    FOnCalcKey(Self, Key);

  case Key of
    s_Dot, s_Comma: begin
      CheckFirst;
      if Pos({$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}DecimalSeparator, FText) = 0 then
        SetText(FText + {$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}DecimalSeparator);

      Exit;
    end;

    'R': if FStatus in [csValid, csFirst] then begin
      FStatus := csFirst;
      if GetDisplay = 0 then
        Error
      else
        SetDisplay(1.0 / GetDisplay);
    end;

    'Q': if FStatus in [csValid, csFirst] then begin
      FStatus := csFirst;
      if GetDisplay < 0 then
        Error
      else
        SetDisplay(Sqrt(GetDisplay));
    end;

    ZeroChar..'9': begin
      CheckFirst;
      if FText = ZeroChar then
        SetText('');

      if Pos('E', FText) = 0 then
        if Length(FText) < Maxi(2, FPrecision) + Ord(Boolean(Pos(CharMinus, FText))) then
          SetText(FText + Key)
        else
          if FBeepOnError then
            MessageBeep(0);
    end;

    #8: begin
      CheckFirst;
      if (Length(FText) = 1) or (Length(FText) = 2) and (FText[1] = CharMinus) then
        SetText(ZeroChar)
      else
        SetText(System.Copy(FText, 1, Length(FText) - 1));
    end;

    'E': begin
      CheckFirst;
      SetText(ZeroChar)
    end;

    '_':
      SetDisplay(-GetDisplay);

    CharPlus, CharMinus, '*', '/', '=', '%', #13:
      if (Key = #13) and (FStatus = csFirst) then begin
        if FEditor <> nil then begin
          TsCalcEdit(FEditor).Value := StrToFloat(FText);
          FEditor.SetFocus;
          if TsCustomComboEdit(FEditor).AutoSelect then
            TsCustomComboEdit(FEditor).SelectAll;

          if Assigned(TsCustomComboEdit(FEditor).OnChange) then
            TsCustomComboEdit(FEditor).OnChange(FEditor);

          Close;
        end;
      end
      else begin
        if FStatus = csValid then begin
          FStatus := csFirst;
          R := GetDisplay;
          if Key = '%' then
            case FOperator of
              CharPlus, CharMinus:
                R := FOperand * R / 100;

              '*', '/':
                R := R / 100;
            end;

          case FOperator of
            CharMinus: SetDisplay(FOperand - R);
            CharPlus:  SetDisplay(FOperand + R);
            '*':       SetDisplay(FOperand * R);
            '/':
              if R = 0 then
                Error
              else
                SetDisplay(FOperand / R);
          end;
        end;
        FOperator := Key;
        FOperand := GetDisplay;
        if CharInSet(AnsiChar(Key), ResultKeys) then
          if Assigned(FOnResult) then
            FOnResult(Self);

        if (Key = '=') and Assigned(FEditor) then begin
          Editor := TsCalcEdit(FEditor);
          Editor.Value := StrToFloat(FText);
          Editor.SetFocus;
          if Editor.AutoSelect then
            Editor.SelectAll;

          if Assigned(Editor.OnChange) then
            Editor.OnChange(FEditor);

          if (Editor <> nil) and (Editor.FPopupWindow <> nil) {and Showing} then
            Close;
        end;
      end;

    #27:
      if FText = ZeroChar then begin
        if Assigned(FEditor) then
          FEditor.SetFocus;

        Close;
      end
      else
        CLear;

    'C':
      Clear;

    ^C:
      Clipboard.AsText := FText;

    ^V:
      Paste;
  end;
end;


procedure ChangeBtns_CB(Ctrl: TControl; Data: integer);
begin
  if Ctrl is TsSpeedButton then
    if Data > 1 then // Skinned
      TsSpeedButton(Ctrl).SkinData.SkinSection := iff(Data = 3, s_ToolButton, s_Button)
    else
      TsSpeedButton(Ctrl).Flat := Data = 1;
end;


procedure TsCalcForm.ChangeBtnsStyle(Flat: boolean);
begin
  IterateControls(FCalculatorPanel, integer(FCalculatorPanel.SkinData.Skinned) * 2 + integer(Flat), ChangeBtns_CB);
end;


procedure TsCalcForm.CheckFirst;
begin
  if FStatus = csFirst then begin
    FStatus := csValid;
    SetText(ZeroChar);
  end;
end;


procedure TsCalcForm.Clear;
begin
  FStatus := csFirst;
  SetDisplay(0);
  FOperator := '=';
end;


procedure TsCalcForm.Error;
begin
  FStatus := csError;
  SetText('Error');
  if FBeepOnError then
    MessageBeep(0);

  if Assigned(FOnError) then
    FOnError(Self);
end;


procedure TsCalcForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  CalcKey(Key);
end;


function TsCalcForm.GetDisplay: Extended;
begin
  if FStatus = csError then
    Result := 0
  else
    Result := StrToFloat(Trim(FText));
end;


procedure TsCalcForm.N1Click(Sender: TObject);
begin
  Copy;
end;


procedure TsCalcForm.N2Click(Sender: TObject);
begin
  Paste;
end;


procedure TsCalcForm.PopupMenu1Popup(Sender: TObject);
begin
  N2.Enabled := Clipboard.HasFormat(CF_TEXT);
end;


procedure TsCalcForm.SetDisplay(R: Extended);
var
  S: string;
begin
  S := FloatToStrF(R, ffGeneral, Maxi(2, FPrecision), 0);
  if FText <> S then begin
    SetText(S);
    if Assigned(FOnDisplayChange) then
      FOnDisplayChange(Self);
  end;
end;


procedure TsCalcForm.SetText(const Value: string);
begin
  if FText <> Value then begin
    FText := Value;
    TextChanged;
  end;
end;


procedure TsCalcForm.TextChanged;
begin
  if FDisplayPanel.Visible then begin
    FDisplayPanel.Caption := FText + s_Space;
    FDisplayPanel.SkinData.BGChanged := True;
  end
  else begin
    TsCustomNumEdit(FEditor).Text := FText;
    TsCustomNumEdit(FEditor).SkinData.Invalidate;
  end;
  if Assigned(FOnTextChange) then
    FOnTextChange(Self);
end;


procedure TsCalcForm.UpdateMemoryLabel;
begin
  if FMemory <> 0 then begin
    FCalcPanel.Caption := 'M';
    sSpeedButton3.Enabled := True;
    sSpeedButton9.Enabled := True;
  end
  else begin
    FCalcPanel.Caption := '';
    sSpeedButton3.Enabled := False;
    sSpeedButton9.Enabled := False;
  end;
end;


procedure TsCalcForm.sSpeedButton22Click(Sender: TObject);
begin
  CalcKey(Char(TComponent(Sender).Tag + Ord(ZeroChar))); // Digits
end;


procedure TsCalcForm.sSpeedButton24Click(Sender: TObject);
begin
  CalcKey(s_Dot);
end;


procedure TsCalcForm.sSpeedButton23Click(Sender: TObject);
begin
  CalcKey('_');
end;


procedure TsCalcForm.sSpeedButton25Click(Sender: TObject);
begin
  CalcKey(CharPlus);
end;


procedure TsCalcForm.sSpeedButton26Click(Sender: TObject);
begin
  CalcKey('=');
end;


procedure TsCalcForm.sSpeedButton19Click(Sender: TObject);
begin
  CalcKey(CharMinus);
end;


procedure TsCalcForm.sSpeedButton13Click(Sender: TObject);
begin
  CalcKey('*');
end;


procedure TsCalcForm.sSpeedButton7Click(Sender: TObject);
begin
  CalcKey('/');
end;


procedure TsCalcForm.sSpeedButton21Click(Sender: TObject);
begin
  if FStatus in [csValid, csFirst] then begin
    FStatus := csFirst;
    FMemory := FMemory + GetDisplay;
    UpdateMemoryLabel;
  end;
end;


procedure TsCalcForm.sSpeedButton15Click(Sender: TObject);
begin
  if FStatus in [csValid, csFirst] then begin
    FStatus := csFirst;
    FMemory := GetDisplay;
    UpdateMemoryLabel;
  end;
end;


procedure TsCalcForm.sSpeedButton9Click(Sender: TObject);
begin
  if FStatus in [csValid, csFirst] then begin
    FStatus := csFirst;
    CheckFirst;
    SetDisplay(FMemory);
  end;
end;


procedure TsCalcForm.sSpeedButton3Click(Sender: TObject);
begin
  FMemory := 0;
  UpdateMemoryLabel;
end;


procedure TsCalcForm.OK1Click(Sender: TObject);
begin
  if FStatus <> csError then begin
    DisplayValue := DisplayValue;
    if Assigned(FOnOk) then
      FOnOk(Self);
  end
  else
    if FBeepOnError then
      MessageBeep(0);
end;


procedure TsCalcForm.Cancel1Click(Sender: TObject);
begin
  if Assigned(FOnCancel) then
    FOnCancel(Self);
end;


procedure TsCalcForm.sSpeedButton2Click(Sender: TObject);
begin
  CalcKey('C');
end;


procedure TsCalcForm.Paste;
begin
  if Clipboard.HasFormat(CF_TEXT) then
    try
      SetDisplay(StrToFloat(Trim(ReplaceStr(Clipboard.AsText, {$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}CurrencyString, ''))));
    except
      SetText(ZeroChar);
    end;
end;


procedure TsCalcForm.sSpeedButton14Click(Sender: TObject);
begin
  CalcKey('%');
end;


procedure TsCalcForm.sSpeedButton8Click(Sender: TObject);
begin
  CalcKey('Q');
end;


procedure TsCalcForm.sSpeedButton20Click(Sender: TObject);
begin
  CalcKey('R');
end;


procedure TsCalcForm.sSpeedButton1Click(Sender: TObject);
begin
  CalcKey(#8);
end;


procedure TsCalcForm.Copy;
begin
  Clipboard.AsText := FText;
end;


procedure TsCalcForm.FormCreate(Sender: TObject);
{
  procedure ScaleControl(Ctrl: TWinControl);
  var
    i, iScaleFactor: integer;
  begin
    DisableAlign;
    iScaleFactor := aScalePercents[DefaultManager.GetScale];
    for i := 0 to Ctrl.ControlCOunt - 1 do begin
      with Ctrl.Controls[i] do begin
        Left   := Left   * iScaleFactor div 100;
        Top    := Top    * iScaleFactor div 100;
        Width  := Width  * iScaleFactor div 100;
        Height := Height * iScaleFactor div 100;
      end;
      if Ctrl.Controls[i] is TWinControl then
        ScaleControl(TWinControl(Ctrl.Controls[i]));
    end;

    EnableAlign;
  end;
}
begin
  sToolButton1.Hint := s_Close;
  sToolButton3.Hint := s_Minimize;
//  SetClassLong(Handle, GCL_STYLE, GetClassLong(Handle, GCL_STYLE) or NCS_DROPSHADOW);
  FText := ZeroChar;
  sSpeedButton24.Caption := {$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}DecimalSeparator;
//  if (DefaultManager <> nil){ and (DefaultManager.SysFontScale <> DefaultManager.GetScale)} then
//    ScaleControl(Self);
end;


procedure TsCalcForm.sToolButton3Click(Sender: TObject);
begin
  Application.Minimize;
end;


procedure TsCalcForm.sToolButton1Click(Sender: TObject);
begin
  Close;
end;


function TsCalcForm.GetValue: Variant;
begin
  Result := 0;
end;


procedure TsCalcForm.SetValue(const Value: Variant);
begin
  DisplayValue := 0;
end;


procedure TsCalcForm.FormShow(Sender: TObject);
var
  m: TMessage;
//  rgn: hrgn;
begin
{  if (FEditor <> nil) and (TsCustomNumEdit(FEditor).SkinData.SkinManager <> nil) and TsCustomNumEdit(FEditor).SkinData.SkinManager.Active then begin
    FillArOR;
    rgn := GetRgnFromRects;
    SetWindowRgn(Handle, rgn, False);
  end;}
  if FEditor <> nil then
    SetDisplay(TsCustomNumEdit(FEditor).Value);

  if (DefaultManager <> nil) and DefaultManager.CommonSkinData.Active then begin
    m := MakeMessage(SM_ALPHACMD, AC_SETBGCHANGED_HI + 1, 1, 0);
    FCalculatorPanel.BroadCast(m);
  end
  else
    Color := clBtnFace;
end;


procedure TsCalcForm.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_GETBG: begin
          PacBGInfo(Message.LParam)^.Color := TsCustomNumEdit(FEditor).SkinData.SkinManager.GetGlobalColor;
          PacBGInfo(Message.LParam)^.BgType := btFill;
        end;
      end;


    WM_ERASEBKGND:
      if Assigned(DefaultManager) and DefaultManager.Active then
        Exit;
  end;
  inherited;
end;

{
procedure TsCalcForm.FillArOR;
begin
  SetLength(Rects, 0);
  if (FEditor <> nil) then
    with TsCustomNumEdit(FEditor).SkinData.SkinManager, FMainPanel.SkinData do
      if IsValidImgIndex(BorderIndex) then begin
        AddRgn(Rects, Width, ma[BorderIndex], 0, False);
        AddRgn(Rects, Width, ma[BorderIndex], Height - ma[BorderIndex].WB, True);
      end;
end;


function TsCalcForm.GetRgnFromRects: hrgn;
var
  l, i: integer;
  subrgn: HRGN;
begin
  l := Length(Rects);
  Result := CreateRectRgn(0, 0, Width, Height);
  if l > 0 then
    for i := 0 to l - 1 do begin
      with Rects[i] do
        subrgn := CreateRectRgn(Left, Top, Right, Bottom);

      CombineRgn(Result, Result, subrgn, RGN_DIFF);
      DeleteObject(subrgn);
    end;
end;
}

var
  Lib: HMODULE = 0;
  ResStringRec: TResStringRec;


procedure TsCalcForm.sSpeedButton27Click(Sender: TObject);
begin
  CalcKey('E');
end;


initialization
  Lib := LoadLibrary('User32');
  if Lib <> 0 then begin
{$IFDEF DELPHI5}
    ResStringRec.Module := @Longint(Lib);
{$ELSE}
    ResStringRec.Module := Pointer(@Lib);
{$ENDIF}    
    ResStringRec.Identifier := 905;
    s_Close := LoadResString(@ResStringRec);
    ResStringRec.Identifier := 900;
    s_Minimize := LoadResString(@ResStringRec);
    FreeLibrary(Lib);
  end;

finalization

end.
