unit sCheckListBox;
{$I sDefs.inc}
//+
{$T-,H+,X+}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls,
  {$IFDEF DELPHI_XE2} UITypes, {$ENDIF}
  {$IFNDEF DELPHI5} Types, {$ELSE} Consts, {$ENDIF}
  sListBox, sConst;


type
{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsCheckListBox = class(TsListBox)
{$IFNDEF NOTFORHELP}
  private
    FHeaderColor,
    FHeaderBackgroundColor: TColor;

{$IFNDEF D2007}
    FSaveStates: TList;
{$ELSE}
    FWrapperList: TList;
{$ENDIF}
    FAllowGrayed: Boolean;
    FHeaderSkin: TsSkinSection;
    FOnClickCheck: TNotifyEvent;
    FDblClickToggle: boolean;
    procedure DrawCheck(R: TRect; AState: TCheckBoxState; AEnabled: Boolean; Bmp: TBitmap; const CI: TCacheInfo); overload;
    procedure DrawCheck(R: TRect; AState: TCheckBoxState; AEnabled: Boolean; C: TCanvas); overload;
    procedure ToggleClickCheck(Index: Integer);
    procedure InvalidateCheck(Index: Integer);
    function CreateWrapper(Index: Integer): TObject;
    function ExtractWrapper(Index: Integer): TObject;
    function HaveWrapper(Index: Integer): Boolean;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonDblClick(var Message: TWMLButtonDown); message WM_LBUTTONDBLCLK;

    function GetHeader     (Index: Integer): Boolean;
    function GetWrapper    (Index: Integer): TObject;
    function GetChecked    (Index: Integer): Boolean;
    function GetItemEnabled(Index: Integer): Boolean;
    function GetState      (Index: Integer): TCheckBoxState;

    procedure SetItemEnabled(Index: Integer; const Value: Boolean);
    procedure SetHeader     (Index: Integer; const Value: Boolean);
    procedure SetState      (Index: Integer; AState: TCheckBoxState);
    procedure SetChecked    (Index: Integer; Checked: Boolean);
    procedure SetHeaderBackgroundColor(const Value: TColor);
    procedure SetHeaderColor          (const Value: TColor);
    procedure SetHeaderSkin           (const Value: TsSkinSection);
  protected
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    function InternalGetItemData(Index: Integer): ACLongInt; override;
    function GetItemData        (Index: Integer): ACLongInt; override;
    procedure InternalSetItemData(Index: Integer; AData: ACLongInt); override;
    procedure SetItemData        (Index: Integer; AData: ACLongInt); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    function SearchNextItem(GoForward: boolean): integer;
{$IFNDEF D2007}
    procedure WMDestroy(var Msg: TWMDestroy);message WM_DESTROY;
    procedure DestroyWnd; override;
{$ELSE}
    procedure LoadRecreateItems(RecreateItems: TStrings); override;
    procedure SaveRecreateItems(RecreateItems: TStrings); override;
{$ENDIF}
    procedure ResetContent; override;
    procedure DeleteString(Index: Integer); override;
    procedure ClickCheck; virtual;
    function GetCheckWidth: Integer;
  public
    constructor Create (AOwner: TComponent); override;
    procedure CreateWnd; override;
    destructor Destroy; override;
{$ENDIF} // NOTFORHELP
    property Checked    [Index: Integer]: Boolean        read GetChecked     write SetChecked;
    property ItemEnabled[Index: Integer]: Boolean        read GetItemEnabled write SetItemEnabled;
    property State      [Index: Integer]: TCheckBoxState read GetState       write SetState;
    property Header     [Index: Integer]: Boolean        read GetHeader      write SetHeader;
  published
    {:@event}
    property OnClickCheck: TNotifyEvent read FOnClickCheck write FOnClickCheck;
    property AllowGrayed: boolean read FAllowGrayed write FAllowGrayed default False;
    property DblClickToggle: boolean read FDblClickToggle write FDblClickToggle default False;
    property HeaderColor: TColor read FHeaderColor write SetHeaderColor default clInfoText;
    property HeaderBackgroundColor: TColor read FHeaderBackgroundColor write SetHeaderBackgroundColor default clInfoBk;
    property HeaderSkin: TsSkinSection read FHeaderSkin write SetHeaderSkin;
{$IFNDEF NOTFORHELP}
    property Align;
    property Anchors;
    property BiDiMode;
    property BorderStyle default bsNone;
    property Color;
    property Columns;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property IntegralHeight;
    property ItemHeight;
    property Items;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property Style;
    property TabOrder;
    property TabStop;
    property TabWidth;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnEndDock;
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
    property OnStartDock;
    property OnStartDrag;
{$ENDIF} // NOTFORHELP
  end;

implementation

uses
  {$IFDEF DELPHI6UP}RTLConsts, {$ENDIF}
  acntUtils, sGraphUtils, sCommonData, sStyleSimply;


type
  TsCheckListBoxDataWrapper = class
  private
    FHeader,
    FDisabled: Boolean;

    FData: LongInt;
    FState: TCheckBoxState;
    procedure SetChecked(Check: Boolean);
    function GetChecked: Boolean;
  public
    class function GetDefaultState: TCheckBoxState;
    property Checked: Boolean read GetChecked write SetChecked;
    property State: TCheckBoxState read FState write FState;
    property Disabled: Boolean read FDisabled write FDisabled;
    property Header: Boolean read FHeader write FHeader;
  end;


{$IFNDEF D2007}
function MakeSaveState(State: TCheckBoxState; Disabled: Boolean): TObject;
begin
  Result := TObject((Byte(State) shl 16) or Byte(Disabled));
end;


function GetSaveState(AObject: TObject): TCheckBoxState;
begin
  Result := TCheckBoxState(Integer(AObject) shr 16);
end;


function GetSaveDisabled(AObject: TObject): Boolean;
begin
  Result := Boolean(Integer(AObject) and $FF);
end;
{$ENDIF}


function TsCheckListBoxDataWrapper.GetChecked: Boolean;
begin
  Result := FState = cbChecked;
end;


class function TsCheckListBoxDataWrapper.GetDefaultState: TCheckBoxState;
begin
  Result := cbUnchecked;
end;


procedure TsCheckListBoxDataWrapper.SetChecked(Check: Boolean);
begin
  FState := CheckBoxStates[integer(Check)];
end;


procedure TsCheckListBox.ClickCheck;
begin
  if Assigned(FOnClickCheck) then
    FOnClickCheck(Self);
end;


constructor TsCheckListBox.Create(AOwner: TComponent);
begin
  inherited;
  FHeaderColor := clInfoText;
  FHeaderBackgroundColor := clInfoBk;
  FDblClickToggle := False;
{$IFDEF D2007}
  FWrapperList := TList.Create;
{$ENDIF}
end;


procedure TsCheckListBox.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if Style = lbStandard then
    Params.Style := Params.Style or LBS_OWNERDRAWFIXED and not LBS_OWNERDRAWVARIABLE;
end;


procedure TsCheckListBox.CreateWnd;
{$IFNDEF D2007}
var
  I: Integer;
  Wrapper: TsCheckListBoxDataWrapper;
  SaveState: TObject;
{$ENDIF}
begin
  inherited CreateWnd;
{$IFNDEF D2007}
  if FSaveStates <> nil then begin
    for I := 0 to FSaveStates.Count - 1 do begin
      Wrapper := TsCheckListBoxDataWrapper(GetWrapper(I));
      SaveState := FSaveStates[I];
      Wrapper.FState := GetSaveState(SaveState);
      Wrapper.FDisabled := GetSaveDisabled(SaveState);
    end;
    FreeAndNil(FSaveStates);
  end;
{$ENDIF}
end;


function TsCheckListBox.CreateWrapper(Index: Integer): TObject;
begin
{$IFDEF D2007}
  FWrapperList.Expand;
{$ENDIF}
  Result := TsCheckListBoxDataWrapper.Create;
{$IFDEF D2007}
  FWrapperList.Add(Result);
{$ENDIF}

{$IFDEF DELPHI_XE2}
  inherited SetItemData(Index, TListBoxItemData(Result));
{$ELSE}
  inherited SetItemData(Index, LPARAM(Result));
{$ENDIF}
end;


procedure TsCheckListBox.DeleteString(Index: Integer);
{$IFDEF D2007}
var
  LIndex: Integer;
  LWrapper: TsCheckListBoxDataWrapper;
{$ENDIF}
begin
  if HaveWrapper(Index) then
{$IFDEF D2007}
  begin
    LWrapper := TsCheckListBoxDataWrapper(GetWrapper(Index));
    LIndex := FWrapperList.IndexOf(LWrapper);
    if LIndex >= 0 then
      FWrapperList.Delete(LIndex);

    LWrapper.Free;
  end;
{$ELSE}
  GetWrapper(Index).Free;
{$ENDIF}
  inherited;
end;


destructor TsCheckListBox.Destroy;
{$IFDEF D2007}
var
  I: Integer;
begin
  for I := 0 to FWrapperList.Count - 1 do
    TsCheckListBoxDataWrapper(FWrapperList[I]).Free;

  FWrapperList.Free;
{$ELSE}
begin
  FreeAndNil(FSaveStates);
{$ENDIF}
  inherited;
end;


{$IFNDEF D2007}
procedure TsCheckListBox.DestroyWnd;
var
  I: Integer;
begin
  if Items.Count > 0 then begin
    FSaveStates := TList.Create;
    for I := 0 to Items.Count - 1 do
      FSaveStates.Add(MakeSaveState(GetState(I), not GetItemEnabled(I)));
  end;
  inherited DestroyWnd;
end;
{$ENDIF}


procedure TsCheckListBox.DrawCheck(R: TRect; AState: TCheckBoxState; AEnabled: Boolean; Bmp: TBitmap; const CI: TCacheInfo);
begin
  acDrawCheck(R, AState, AEnabled, Bmp, CI, SkinData.SkinManager);
end;


procedure TsCheckListBox.DrawCheck(R: TRect; AState: TCheckBoxState; AEnabled: Boolean; C: TCanvas);
const
  exB = 1;
var
  Rgn, SaveRgn: HRgn;
  DrawState: Integer;
  DrawRect: TRect;
begin
  DrawRect := R;
  DrawRect.Left   := DrawRect.Left + (DrawRect.Right  - DrawRect.Left - CheckWidth(nil)) div 2;
  DrawRect.Top    := DrawRect.Top  + (DrawRect.Bottom - DrawRect.Top - CheckHeight(nil)) div 2;
  DrawRect.Right  := DrawRect.Left + CheckWidth(nil);
  DrawRect.Bottom := DrawRect.Top  + CheckHeight(nil);
  case AState of
    cbUnchecked: DrawState := DFCS_BUTTONCHECK;
    cbChecked:   DrawState := DFCS_BUTTONCHECK or DFCS_CHECKED
    else         DrawState := DFCS_BUTTON3STATE or DFCS_CHECKED;
  end;
  if not AEnabled then
    DrawState := DrawState or DFCS_INACTIVE;

  C.Brush.Style := bsClear;
  C.Pen.Style := psSolid;
  SaveRgn := CreateRectRgn(0, 0, 0, 0);
  GetClipRgn(C.Handle, SaveRgn);
  Rgn := CreateRectRgn(DrawRect.Left + exB, DrawRect.Top + exB, DrawRect.Right - exB, DrawRect.Bottom - exB);
  SelectClipRgn(C.Handle, Rgn);
  DeleteObject(Rgn);
  DrawFrameControl(C.Handle, DrawRect, DFC_BUTTON, DFCS_FLAT or DrawState);
  SelectClipRgn(C.Handle, SaveRgn);
  DeleteObject(SaveRgn);
end;


procedure TsCheckListBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
const
  CheckOffset = 2;
var
  xOffset, ACheckWidth: Integer;
  Bmp: Graphics.TBitmap;
  rText, rCheck: TRect;
  CI: TCacheInfo;
begin
  if IsValidIndex(Index, Items.Count) then begin
    if (Columns = 0) and (ListSW <> nil) and (ListSW.sBarHorz <> nil) then
      XOffset := ListSW.sBarHorz.ScrollInfo.nPos
    else
      XOffset := 0;

    if not GetHeader(Index) then begin
      ACheckWidth := GetCheckWidth;
      if not UseRightToLeftAlignment then
        Rect.Left := Rect.Left + ACheckWidth + CheckOffset
      else
        Rect.Right := Rect.Right - ACheckWidth - CheckOffset;

      if {not Enabled or }not GetItemEnabled(Index) then
        State := State + [odDisabled];

      inherited;
      if not UseRightToLeftAlignment then
        Rect.Left := Rect.Left - ACheckWidth - CheckOffset
      else
        Rect.Right := Rect.Right + ACheckWidth + CheckOffset;

      if SkinData.Skinned then begin
        Bmp := CreateBmp32(ACheckWidth + CheckOffset, HeightOf(Rect));
        CI := MakeCacheInfo(SkinData.FCacheBmp, ListSW.cxLeftEdge, ListSW.cxLeftEdge);
        if odReserved1 in State then
          BitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, SkinData.FCacheBmp.Canvas.Handle, Rect.Left + CI.X - 2 * XOffset, Rect.Top + CI.Y, SRCCOPY)
        else
          BitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, SkinData.FCacheBmp.Canvas.Handle, Rect.Left + CI.X - XOffset, Rect.Top + CI.Y, SRCCOPY);

        rCheck := MkRect(Bmp);
        DrawCheck(rCheck, GetState(Index), Enabled and GetItemEnabled(Index), Bmp, CI);
        if not UseRightToLeftAlignment then
          BitBlt(Canvas.Handle, Rect.Left - XOffset, Rect.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY)
        else
          BitBlt(Canvas.Handle, Rect.Right - XOffset - ACheckWidth - CheckOffset, Rect.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);

        Bmp.Free;
      end
      else begin
        rCheck := Rect;
        if not UseRightToLeftAlignment then
          rCheck.Right := rCheck.Left + ACheckWidth + xOffset
        else
          rCheck.Left := Rect.Right - ACheckWidth - xOffset;

        rCheck.Left := rCheck.Right - ACheckWidth;
        DrawCheck(rCheck, GetState(Index), Enabled and GetItemEnabled(Index), Canvas);
      end;
    end
    else
      if Assigned(OnDrawItem) then
        OnDrawItem(Self, Index, Rect, State)
      else begin
        Bmp := CreateBmp32(Rect);
        CI := MakeCacheInfo(SkinData.FCacheBmp, ListSW.cxLeftEdge, ListSW.cxLeftEdge);
        rText := MkRect(Bmp);
        if SkinData.CustomColor then begin
          Canvas.Font.Color := HeaderColor;
          Canvas.Brush.Color := HeaderBackgroundColor;
          inherited;
        end
        else begin
          if (HeaderSkin <> '') and SkinData.Skinned then begin
            ACheckWidth := SkinData.SkinManager.GetSkinIndex(HeaderSkin);
            if ACheckWidth >= 0 then begin
              PaintItem(ACheckWidth, CI, True, 1, rText, MkPoint, Bmp);
              Bmp.Canvas.Font.Color := SkinData.SkinManager.gd[ACheckWidth].Props[1].FontColor.Color;
            end;
            Bmp.Canvas.Brush.Style := bsClear;
            acWriteText(Bmp.Canvas, PacChar(Items[Index]), True, rText, DT_VCENTER or DT_NOPREFIX)
          end
          else begin
            if SkinData.Skinned and (SkinData.SkinManager.ConstData.IndexGlobalInfo >= 0) then begin
              Bmp.Canvas.Brush.Color := SkinData.SkinManager.gd[SkinData.SkinManager.ConstData.IndexGlobalInfo].Props[0].Color;
              Bmp.Canvas.Font.Color := SkinData.SkinManager.GetGlobalFontColor;
            end
            else begin
              Bmp.Canvas.Brush.Color := ColorToRGB(HeaderBackgroundColor);
              Bmp.Canvas.Font.Color := ColorToRGB(HeaderColor);
            end;
            Bmp.Canvas.Brush.Style := bsSolid;
            Bmp.Canvas.FillRect(rText);
            if not Assigned(OnDrawItem) then begin
              InflateRect(rText, -4, 0);
              acWriteText(Bmp.Canvas, PacChar(Items[Index]), True, rText, DT_NOPREFIX or DT_EXPANDTABS or DT_SINGLELINE or DT_VCENTER or DT_NOCLIP);
            end;
          end;
          BitBlt(Canvas.Handle, Rect.Left - XOffset, Rect.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
          Bmp.Free;
        end;
      end;
  end;
end;


function TsCheckListBox.ExtractWrapper(Index: Integer): TObject;
begin
  if Index < 0 then
    Result := nil
  else begin
    Result := TsCheckListBoxDataWrapper(inherited GetItemData(Index));
    if LB_ERR = Integer(Result) then
      raise EListError.CreateResFmt(@SListIndexError, [Index]);

    if (Result <> nil) and not (Result is TsCheckListBoxDataWrapper) then
      Result := nil;
  end;
end;


function TsCheckListBox.GetChecked(Index: Integer): Boolean;
begin
  if HaveWrapper(Index) then
    Result := TsCheckListBoxDataWrapper(GetWrapper(Index)).GetChecked
  else
    Result := False;
end;


function TsCheckListBox.GetCheckWidth: Integer;
begin
  Result := CheckWidth(SkinData.SkinManager);
end;


function TsCheckListBox.GetHeader(Index: Integer): Boolean;
begin
  if HaveWrapper(Index) then
    Result := TsCheckListBoxDataWrapper(GetWrapper(Index)).Header
  else
    Result := False;
end;


function TsCheckListBox.GetItemData(Index: Integer): ACLongInt;
begin
  Result := 0;
  if HaveWrapper(Index) then
    Result := TsCheckListBoxDataWrapper(GetWrapper(Index)).FData;
end;


function TsCheckListBox.GetItemEnabled(Index: Integer): Boolean;
begin
  Result := False;
  if IsValidIndex(Index, Items.Count) then
    if HaveWrapper(Index) then
      Result := not TsCheckListBoxDataWrapper(GetWrapper(Index)).Disabled
    else
      Result := True;
end;


function TsCheckListBox.GetState(Index: Integer): TCheckBoxState;
begin
  if HaveWrapper(Index) then
    Result := TsCheckListBoxDataWrapper(GetWrapper(Index)).State
  else
    Result := TsCheckListBoxDataWrapper.GetDefaultState;
end;


function TsCheckListBox.GetWrapper(Index: Integer): TObject;
begin
  Result := ExtractWrapper(Index);
  if Result = nil then
    Result := CreateWrapper(Index);
end;


function TsCheckListBox.HaveWrapper(Index: Integer): Boolean;
begin
  Result := ExtractWrapper(Index) <> nil;
end;


function TsCheckListBox.InternalGetItemData(Index: Integer): ACLongInt;
begin
  Result := inherited GetItemData(Index);
end;


procedure TsCheckListBox.InternalSetItemData(Index: Integer; AData: ACLongInt);
begin
  inherited SetItemData(Index, AData);
end;


type
  TAccessStrings = class(TStrings);

procedure TsCheckListBox.InvalidateCheck(Index: Integer);
var
  R: TRect;
begin
  if not GetHeader(Index) {$IFDEF DELPHI7UP}and (TAccessStrings(Items).UpdateCount = 0){$ENDIF} {and not Items.Add }then begin
    R := ItemRect(Index);
    if not UseRightToLeftAlignment then
      R.Right := R.Left + GetCheckWidth
    else
      R.Left := R.Right - GetCheckWidth;

    InvalidateRect(Handle, @R, not (csOpaque in ControlStyle));
    if SkinData.Skinned then
      UpdateWindow(Handle)
    else
      Repaint;
  end;
end;


procedure TsCheckListBox.KeyDown(var Key: Word; Shift: TShiftState);
var
  i: integer;
begin
  case Key of
    VK_HOME:
      if (Items.Count = 0) or ItemEnabled[0] then
        inherited
      else
        Key := 0;

    VK_END:
      if (Items.Count = 0) or ItemEnabled[Items.Count - 1] then
        inherited
      else
        Key := 0;

    VK_LEFT:
      if Columns > 0 then begin
        i := ItemIndex - ClientHeight div ItemHeight;
        if (i < 0) or ItemEnabled[i] then
          inherited
        else
          Key := 0;
      end;

    VK_RIGHT:
      if Columns > 0 then begin
        i := ItemIndex + ClientHeight div ItemHeight;
        if (i >= Items.Count) or ItemEnabled[i] then
          inherited
        else
          Key := 0;
      end;

    VK_UP: begin
      i := SearchNextItem(False);
      if ItemIndex <> i then
        if ItemIndex = i - 1 then
          inherited
        else begin
          Key := 0;
          ItemIndex := i;
        end;
    end;

    VK_DOWN: begin
      i := SearchNextItem(True);
      if ItemIndex <> i then
        if ItemIndex = i + 1 then
          inherited
        else begin
          Key := 0;
          ItemIndex := i;
        end;
    end
    else
      inherited;
  end;
end;


procedure TsCheckListBox.KeyPress(var Key: Char);
begin
  case Key of
    s_Space: begin
      ToggleClickCheck(ItemIndex);
      Key := #0;
    end
    else
      inherited;
  end;
end;


{$IFDEF D2007}
procedure TsCheckListBox.LoadRecreateItems(RecreateItems: TStrings);
var
  I, Index: Integer;
begin
  with RecreateItems do begin
    BeginUpdate;
    try
      Items.NameValueSeparator := NameValueSeparator;
      Items.QuoteChar := QuoteChar;
      Items.Delimiter := Delimiter;
      Items.LineBreak := LineBreak;
      for I := 0 to Count - 1 do begin
        Index := Items.Add(RecreateItems[I]);
        if Objects[I] <> nil then
          InternalSetItemData(Index, {$IFDEF DELPHI_XE2}TListBoxItemData{$ELSE}LPARAM{$ENDIF}(Objects[I]));
      end;
    finally
      EndUpdate;
    end;
  end;
end;


procedure TsCheckListBox.SaveRecreateItems(RecreateItems: TStrings);
var
  I: Integer;
  LWrapper: TsCheckListBoxDataWrapper;
begin
  FWrapperList.Clear;
  with RecreateItems do begin
    BeginUpdate;
    try
      NameValueSeparator := Items.NameValueSeparator;
      QuoteChar := Items.QuoteChar;
      Delimiter := Items.Delimiter;
      LineBreak := Items.LineBreak;
      for I := 0 to Items.Count - 1 do begin
        LWrapper := TsCheckListBoxDataWrapper(ExtractWrapper(I));
        AddObject(Items[I], LWrapper);
        if LWrapper <> nil then
          FWrapperList.Add(LWrapper);
      end;
    finally
      EndUpdate;
    end;
  end;
end;
{$ENDIF}


procedure TsCheckListBox.ResetContent;
var
{$IFDEF D2007}
  I, Index: Integer;
  LWrapper: TsCheckListBoxDataWrapper;
begin
  for I := 0 to Items.Count - 1 do begin
    LWrapper := TsCheckListBoxDataWrapper(ExtractWrapper(I));
    if Assigned(LWrapper) then begin
      Index := FWrapperList.IndexOf(LWrapper);
      if Index >= 0 then
        FWrapperList.Delete(Index);

      LWrapper.Free;
    end;
  end;
{$ELSE}
  I: Integer;
begin
  for I := 0 to Items.Count - 1 do
    if HaveWrapper(I) then
      GetWrapper(I).Free;
{$ENDIF}
  inherited;
end;


function TsCheckListBox.SearchNextItem(GoForward: boolean): integer;
var
  i: integer;
begin
  Result := ItemIndex;
  if GoForward then begin
    for i := ItemIndex + 1 to Items.Count - 1 do
      if (i < Items.Count) and ItemEnabled[i] then begin
        Result := i;
        Exit;
      end;
  end
  else
    for i := ItemIndex - 1 downto 0 do
      if (i >= 0) and ItemEnabled[i] then begin
        Result := i;
        Exit;
      end;
end;


procedure TsCheckListBox.SetChecked(Index: Integer; Checked: Boolean);
begin
  if Checked <> GetChecked(Index) then begin
    TsCheckListBoxDataWrapper(GetWrapper(Index)).SetChecked(Checked);
    if not SkinData.FUpdating then
      InvalidateCheck(Index);
  end;
end;


procedure TsCheckListBox.SetHeader(Index: Integer; const Value: Boolean);
begin
  if Value <> GetHeader(Index) then begin
    TsCheckListBoxDataWrapper(GetWrapper(Index)).Header := Value;
    SkinData.Invalidate;
  end;
end;


procedure TsCheckListBox.SetHeaderBackgroundColor(const Value: TColor);
begin
  if Value <> HeaderBackgroundColor then begin
    FHeaderBackgroundColor := Value;
    SkinData.Invalidate;
  end;
end;


procedure TsCheckListBox.SetHeaderColor(const Value: TColor);
begin
  if Value <> HeaderColor then begin
    FHeaderColor := Value;
    SkinData.Invalidate;
  end;
end;


procedure TsCheckListBox.SetHeaderSkin(const Value: TsSkinSection);
begin
  if FHeaderSkin <> Value then begin
    FHeaderSkin := Value;
    SkinData.Invalidate
  end;
end;


procedure TsCheckListBox.SetItemData(Index: integer; AData: ACLongInt);
var
  Wrapper: TsCheckListBoxDataWrapper;
begin
  if HaveWrapper(Index) or (AData <> 0) then begin
    Wrapper := TsCheckListBoxDataWrapper(GetWrapper(Index));
    Wrapper.FData := AData;
  end;
end;


procedure TsCheckListBox.SetItemEnabled(Index: Integer; const Value: Boolean);
begin
  if Value <> GetItemEnabled(Index) then begin
    TsCheckListBoxDataWrapper(GetWrapper(Index)).Disabled := not Value;
    InvalidateCheck(Index);
  end;
end;


procedure TsCheckListBox.SetState(Index: Integer; AState: TCheckBoxState);
begin
  if AState <> GetState(Index) then begin
    TsCheckListBoxDataWrapper(GetWrapper(Index)).State := AState;
    InvalidateCheck(Index);
  end;
end;


procedure TsCheckListBox.ToggleClickCheck(Index: Integer);
var
  State: TCheckBoxState;
begin
  if IsValidIndex(Index, Items.Count) and GetItemEnabled(Index) then begin
    State := GetState(Index);
    case State of
      cbUnchecked:
        if AllowGrayed then
          State := cbGrayed
        else
          State := cbChecked;

      cbChecked:
        State := cbUnchecked;

      cbGrayed:
        State := cbChecked;
    end;
    SetState(Index, State);
    ClickCheck;
  end;
end;


{$IFNDEF D2007}
procedure TsCheckListBox.WMDestroy(var Msg: TWMDestroy);
var
  i: Integer;
begin
  if Items <> nil then
    for i := 0 to Items.Count - 1 do
      ExtractWrapper(i).Free;

  inherited;
end;
{$ENDIF}


procedure TsCheckListBox.WMLButtonDblClick(var Message: TWMLButtonDown);
var
  Index: Integer;
begin
  inherited;
  if FDblClickToggle then begin
    Index := ItemAtPos(Point(Message.XPos,Message.YPos), True);
    if (Index >= 0) and GetItemEnabled(Index) then
      ToggleClickCheck(Index)
  end;
end;


procedure TsCheckListBox.WMLButtonDown(var Message: TWMLButtonDown);
var
  Index: Integer;
begin
  inherited;
  Index := ItemAtPos(Point(Message.XPos,Message.YPos), True);
  if (Index >= 0) and GetItemEnabled(Index) then
    if not UseRightToLeftAlignment then begin
      if Message.XPos - ItemRect(Index).Left < GetCheckWidth then
        ToggleClickCheck(Index)
    end
    else begin
      Dec(Message.XPos, ItemRect(Index).Right - GetCheckWidth);
      if (Message.XPos > 0) and (Message.XPos < GetCheckWidth) then
        ToggleClickCheck(Index)
    end;
end;

end.
