unit CheckComboBox;

{
Copyright (C) 2008-2012 Michal Turecki
Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
History:
  v1.0 2012-12-12 First public release
  v1.1 2014-03-14 Added AutoWidth feature along with a bugfix provided by Wolfgang Prinzjakowitsch
}

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  StdCtrls,
  UxTheme;

type
  TCheckComboBox = class;

  TCheckComboAggregateEvent = procedure(Sender: TCheckComboBox; var AValue: string) of object;

  TCheckComboBox = class(TComboBox)
  private
    FAutoWidth: Boolean;
    FCaption: string;
    FCheckCombo: Boolean;
    FChecked: TList;
    FDefaultValue: string;
    FDefListProc: Pointer;
    FDisplayValues: Boolean;
    FListHandle: HWND; // List WndProc hook
    FListProcInstance: Pointer;
    FOnAggregate: TCheckComboAggregateEvent;
    FOnDrawItem: TDrawItemEvent;
    FSelectedCount: Integer;
    FValue: string;
    FValues: TStrings;
    FValuesAreFlags: Boolean;
    FClickCheck: TNotifyEvent;
    FBulkChanging: Boolean;

	function GetChecked(AIndex: Integer): Boolean;
	procedure InternalSetChecked(const AIndex: Integer; const AValue: Boolean);
    procedure SetCaption(const Value: string);
    procedure SetCheckCombo(const Value: Boolean);
	procedure SetChecked(AIndex: Integer; AChecked: Boolean);
    procedure SetDisplayValues(const Value: Boolean);
    procedure SetText(const AValue: string; AUseValue: Boolean);
    procedure SetValue(const Value: string);
    procedure SetValues(const Value: TStrings);
    procedure UpdateChecked;

    procedure SetBulkChanging(const Value: Boolean);  protected
    function InternalSetAll(AChecked: Boolean): Boolean;
    procedure InvalidateItem(AIndex: Integer);
    procedure CloseUp; override;
    procedure ComboListWndProc(var Message: TMessage);
    procedure ComboWndProc(var Message: TMessage; ComboWnd: HWnd; ComboProc: Pointer); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure DropDown; override;
    procedure SelectionChanged;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear; override;
    procedure SetAll(const AChecked: Boolean);
    property Checked[AIndex: Integer]: Boolean read GetChecked write SetChecked;
  published
    property AutoWidth: Boolean read FAutoWidth write FAutoWidth default False;
    property Caption: string read FCaption write SetCaption;
    property CheckCombo: Boolean read FCheckCombo write SetCheckCombo default True;
    property DefaultValue: string read FDefaultValue write FDefaultValue;
    property DisplayValues: Boolean read FDisplayValues write SetDisplayValues default False;
    property OnAggregate: TCheckComboAggregateEvent read FOnAggregate write FOnAggregate;
    property OnDrawItem: TDrawItemEvent read FOnDrawItem write FOnDrawItem;
    property OnClickCheck: TNotifyEvent read FClickCheck write FClickCheck;
    property SelectedCount: Integer read FSelectedCount;
    property Value: string read FValue write SetValue;
    property Values: TStrings read FValues write SetValues;
    property ValuesAreFlags: Boolean read FValuesAreFlags write FValuesAreFlags default False;
    property BulkChanging : Boolean read FBulkChanging write SetBulkChanging;
  end;

procedure Register;

implementation

uses
  Math;

procedure Register;
begin
  RegisterComponents('Roomer', [TCheckComboBox]);
end;

{ TCheckComboBox }

constructor TCheckComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FListProcInstance := Classes.MakeObjectInstance(ComboListWndProc);
  FDefListProc := nil;
  FListHandle := 0;
  FSelectedCount := 0;
  FDisplayValues := False;
  FValues := TStringList.Create;
  FValuesAreFlags := False;
  FChecked := TList.Create;
  FCheckCombo := True;
  FAutoWidth := False;
end;

destructor TCheckComboBox.Destroy;
begin
  Classes.FreeObjectInstance(FListProcInstance);
  FValues.Free;
  FChecked.Free;
  inherited;
end;

function TCheckComboBox.GetChecked(AIndex: Integer): Boolean;
begin
  UpdateChecked;
  Result := FChecked[AIndex] <> nil;
end;

procedure TCheckComboBox.InternalSetChecked(const AIndex: Integer; const AValue: Boolean);
begin
  UpdateChecked;
  FChecked[AIndex] := Pointer(Ord(AValue));
  if Assigned(FClickCheck) then
    FClickCheck(Self);
end;

procedure TCheckComboBox.SetChecked(AIndex: Integer; AChecked: Boolean);
begin
  UpdateChecked;
  if AChecked <> Checked[AIndex] then
  begin
    InternalSetChecked(AIndex, AChecked);
    SelectionChanged;
    Change;
    if NOT FBulkChanging then
      InvalidateItem(AIndex);
  end;
end;

procedure TCheckComboBox.UpdateChecked;
begin
  while FChecked.Count < ItemCount do
    FChecked.Add(nil);
  while FChecked.Count > ItemCount do
    FChecked.Delete(FChecked.Count - 1);
end;

procedure TCheckComboBox.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style := Params.Style or CBS_HASSTRINGS;
  if FCheckCombo then
    Params.Style := Params.Style or CBS_OWNERDRAWVARIABLE
  else
    Params.Style := Params.Style and (not CBS_OWNERDRAWVARIABLE);
end;

procedure TCheckComboBox.CreateWnd;
begin
  if FCheckCombo then
    AutoComplete := False;
  inherited;
  if FCheckCombo and (FEditHandle <> 0) then
    SendMessage(FEditHandle, EM_SETREADONLY, 1, 0);
end;

procedure TCheckComboBox.WndProc(var Message: TMessage);
begin
  if Message.Msg = CBN_CLOSEUP then
    SelectionChanged;

  inherited WndProc(Message);

  if Message.Msg = WM_CTLCOLORLISTBOX then
  begin
    if FListHandle = 0 then
    begin
      FListHandle := Message.LParam;
      FDefListProc := Pointer(GetWindowLong(FListHandle, GWL_WNDPROC));
      SetWindowLong(FListHandle, GWL_WNDPROC, Longint(FListProcInstance));
    end;
  end;
end;

procedure TCheckComboBox.ComboWndProc(var Message: TMessage; ComboWnd: HWnd; ComboProc: Pointer);
var
  i: Integer;
begin
  if FCheckCombo and DroppedDown and (Message.Msg = WM_CHAR) and (TWMChar(Message).CharCode = 32) and (FListProcInstance <> nil) then
  begin
    i := CallWindowProcA(FDefListProc, FListHandle, LB_GETCURSEL, Message.wParam, Message.lParam);
    if i >= 0 then
    begin
      Checked[i] := not Checked[i];
      Message.Result := 0;
      Exit;
    end;
  end;

  inherited ComboWndProc(Message, ComboWnd, ComboProc);
end;

procedure TCheckComboBox.Clear;
begin
  inherited;
  FChecked.Clear;
  FValues.Clear;
end;

procedure TCheckComboBox.CloseUp;
begin
  inherited;
  SelectionChanged;
end;

procedure TCheckComboBox.ComboListWndProc(var Message: TMessage);
var
  idx: Integer;
  listRect: TRect;
begin
  if FCheckCombo then
  begin
    case Message.Msg of
      LB_GETCURSEL:
      begin
        Message.Result := -1;
        Exit;
      end;

      WM_CHAR:
      begin
        if Message.WParam = VK_SPACE then
        begin
          idx := CallWindowProcA(FDefListProc, FListHandle, LB_GETCURSEL, Message.wParam, Message.lParam);
          Checked[idx] := not Checked[idx];
        end;
      end;

      WM_LBUTTONDOWN:
      begin
        idx := CallWindowProcA(FDefListProc, FListHandle, LB_GETCURSEL, Message.wParam, Message.lParam);
        GetWindowRect(FListHandle, listRect);
        if PtInRect(listRect, Mouse.CursorPos) then
          if idx >= 0 then
            Checked[idx] := not Checked[idx];
      end;

      WM_LBUTTONUP:
      begin
        Message.Result := 0;
        Exit;
      end;
    end;
  end;

  Message.Result := CallWindowProc(FDefListProc, FListHandle, Message.Msg, Message.wParam, Message.lParam);
end;

procedure TCheckComboBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  r: TRect;
  h: Cardinal;
  s: Size;
  v: string;
const
  PADDING = 2;
begin
  TControlCanvas(Canvas).UpdateTextFlags;
  if Assigned(FOnDrawItem) then
  begin
    OnDrawItem(Self, Index, Rect, State);
    Exit;
  end;

  if (Index >= 0) and FCheckCombo then
  begin
    UpdateChecked;
    if UseThemes then
    begin
      h := OpenThemeData(Handle, 'BUTTON');
      if h <> 0 then
      begin
        try
          GetThemePartSize(h, Canvas.Handle, BP_CHECKBOX, CBS_CHECKEDNORMAL, nil, TS_DRAW, s);
          r.Top := Rect.Top + (Rect.Bottom - Rect.Top - s.cy) div 2;
          r.Bottom := r.Top + s.cy;
          r.Left := Rect.Left + PADDING;
          r.Right := r.Left + s.cx;
          DrawThemeBackground(h, Canvas.Handle, BP_CHECKBOX, IfThen(Checked[Index], CBS_CHECKEDNORMAL, CBS_UNCHECKEDNORMAL), r, nil);
        finally
          CloseThemeData(h);
        end;
      end;
    end
    else
    begin
      s.cx := GetSystemMetrics(SM_CXMENUCHECK);
      s.cy := GetSystemMetrics(SM_CYMENUCHECK);
      r.Top := Rect.Top + (Rect.Bottom - Rect.Top - s.cy) div 2;
      r.Bottom := r.Top + s.cy;
      r.Left := Rect.Left + PADDING;
      r.Right := r.Left + s.cx;
      DrawFrameControl(Canvas.Handle, r, DFC_BUTTON, IfThen(Checked[Index], CBS_CHECKEDNORMAL, CBS_UNCHECKEDNORMAL));
    end;
    s.cx := s.cx + PADDING * 2;
  end
  else
    s.cx := 0;

  if not FDisplayValues then
    v := Items[Index]
  else if Index < Values.Count then
    v := Values[Index]
  else
    v := FDefaultValue;
  Canvas.TextOut(Rect.Left + s.cx, Rect.Top, v);
end;

function TCheckComboBox.InternalSetAll(AChecked: Boolean): Boolean;
var
  i: Integer;
begin
  UpdateChecked;
  Result := False;
  for i := 0 to Items.Count - 1 do
  begin
    Result := Result or (Checked[i] <> AChecked);
    InternalSetChecked(i, AChecked);
  end;
end;

procedure TCheckComboBox.InvalidateItem(AIndex: Integer);
var
  r: TRect;
begin
  if CallWindowProcA(FDefListProc, FListHandle, LB_GETITEMRECT, AIndex, Cardinal(@r)) <> LB_ERR then
    InvalidateRect(FListHandle, @r, False);
end;

procedure TCheckComboBox.SetAll(const AChecked: Boolean);
begin
  if InternalSetAll(AChecked) then
  begin
    SelectionChanged;
    Change;
  end;
end;

procedure TCheckComboBox.SetBulkChanging(const Value: Boolean);
begin
  FBulkChanging := Value;
  if Value then
     Items.BeginUpdate
  else
     Items.EndUpdate;
end;

procedure TCheckComboBox.SetCheckCombo(const Value: Boolean);
begin
  FCheckCombo := Value;
  if WindowHandle <> 0 then
  begin
    FListHandle := 0;
    Perform(CM_RECREATEWND, 0, 0);
  end;
end;

procedure TCheckComboBox.SetDisplayValues(const Value: Boolean);
begin
  FDisplayValues := Value;
  SelectionChanged;
end;

procedure TCheckComboBox.SetValues(const Value: TStrings);
begin
  UpdateChecked;
  if Assigned(FValues) then
    FValues.Assign(Value)
  else
    FValues := Value;
end;

procedure TCheckComboBox.SetCaption(const Value: string);
begin
  SetText(Value, False);
end;

procedure TCheckComboBox.SetValue(const Value: string);
begin
  SetText(Value, True);
end;

procedure TCheckComboBox.SetText(const AValue: string; AUseValue: Boolean);
var
  i, idx: Integer;
  v, flags: Cardinal;
  sl: TStringList;
  list: TStrings;
begin
  if not FCheckCombo then
  begin
    if AUseValue then
      ItemIndex := Values.IndexOf(AValue)
    else
      ItemIndex := Items.IndexOf(AValue)
  end
  else
  begin
    InternalSetAll(False);

    if AUseValue then
      list := FValues
    else
      list := Items;

    if FValuesAreFlags and AUseValue then
    begin
      flags := StrToIntDef(AValue, 0);
      for i := 0 to FValues.Count - 1 do
      begin
        v := StrToIntDef(FValues[i], 0);
        FChecked[i] := Pointer(Ord(((v and flags) > 0) or ((flags = 0) and (v = 0))));
      end;
    end
    else
    begin
      sl := TStringList.Create;
      try
        sl.CommaText := AValue;
        for i := 0 to sl.Count - 1 do
        begin
          idx := list.IndexOf(Trim(sl[i]));
          if idx >= 0 then
            Checked[idx] := True;
        end;
      finally
        sl.Free;
      end;
    end;
  end;
  SelectionChanged;
end;

procedure TCheckComboBox.SelectionChanged;
var
  i: Integer;
  v: string;
  flags: Integer;
begin
  FSelectedCount := 0;
  FValue := '';
  FCaption := '';
  flags := 0;

  if not FCheckCombo then
  begin
    if ItemIndex >= 0 then
    begin
      FCaption := Items[ItemIndex];
      if (FValues.Count = Items.Count) then
        FValue := Values[ItemIndex]
      else
        FValue := FDefaultValue;
    end
    else
    begin
      FCaption := '';
      FValue := '';
    end;
  end
  else
  begin
    UpdateChecked;
    for i := 0 to Items.Count - 1 do
    begin
      if Checked[i] then
      begin
        if FSelectedCount > 0 then
        begin
          FCaption := FCaption + ',';
          if not Assigned(FOnAggregate) then
            FValue := FValue + ',';
        end;

        FCaption := FCaption + Items[i];
        if not Assigned(FOnAggregate) then
        begin
          if i < FValues.Count then
          begin
            v := FValues[i];
            if FValuesAreFlags then
              flags := flags or StrToIntDef(FValues[i], 0);
          end
          else
            v := FDefaultValue;
          FValue := FValue + v;
        end;
        Inc(FSelectedCount);
      end;
    end;
    
    if FValuesAreFlags then
      FValue := IntToStr(flags)
    else if Assigned(FOnAggregate) then
      FOnAggregate(Self, FValue);
  end;

  if FDisplayValues then
    v := FValue
  else
    v := FCaption;

  inherited Text := v;

  if HandleAllocated then
  begin
    SendMessage(Handle, WM_SETREDRAW, 1, 0);
    Invalidate;
  end;
end;

procedure TCheckComboBox.DropDown;
var
  i: LongInt;
  lf: LOGFONT;
  f: HFONT;
  itemWidth: Integer;
begin
  inherited DropDown;
  
  if FAutoWidth then
  begin
    itemWidth := Width - GetSystemMetrics(SM_CYVTHUMB) - GetSystemMetrics(SM_CXVSCROLL);

    FillChar(lf, SizeOf(lf), 0);
    StrPCopy(lf.lfFaceName, Font.Name);
    lf.lfHeight := Font.Height;
    lf.lfWeight := FW_NORMAL;
    if fsBold in Font.Style then
      lf.lfWeight := lf.lfWeight or FW_BOLD;

    f := CreateFontIndirect(lf);
    if (f <> 0) then
    begin
      try
        Canvas.Handle := GetDC(Handle);
        SelectObject(Canvas.Handle,f);
        try
          for i := 0 to Items.Count -1 do
            itemWidth := Max(itemWidth, Canvas.TextWidth(Items[i]));
          Inc(itemWidth , GetSystemMetrics(SM_CYVTHUMB) + GetSystemMetrics(SM_CXVSCROLL));
        finally
          ReleaseDC(Handle, Canvas.Handle);
        end;
      finally
        DeleteObject(f);
      end;
    end;

    Perform(CB_SETDROPPEDWIDTH, itemWidth, 0);
  end;
end;

end.