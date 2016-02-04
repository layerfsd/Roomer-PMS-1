{***************************************************************************}
{ TMS Unicode Component Pack                                                }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ Copyright © 2007 - 2008 by TMS software                                   }
{ Email : info@tmssoftware.com                                              }
{ Web : http://www.tmssoftware.com                                          }
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit TntDBGrids;

{$INCLUDE TntCompilers.inc}

{$IFDEF DELPHI_UNICODE}

interface

uses
  Classes, Grids, DBGrids;

type

  TTntDBGrid = class(TDBGrid);

implementation

{$ENDIF}

{$IFNDEF DELPHI_UNICODE}


interface

uses
  Classes, TntClasses, Controls, Windows, Grids, DBGrids, Messages, DBCtrls, DB, TntStdCtrls;

type
{TNT-WARN TColumnTitle}
  TTntColumnTitle = class(TColumnTitle{TNT-ALLOW TColumnTitle})
  private
    FCaption: WideString;
    procedure SetInheritedCaption(const Value: AnsiString);
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function IsCaptionStored: Boolean;
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
    function DefaultCaption: WideString;
  published
    property Caption: WideString read GetCaption write SetCaption stored IsCaptionStored;
  end;

{TNT-WARN TColumn}
type
  TTntColumn = class(TColumn{TNT-ALLOW TColumn})
  private
    FWidePickList: TTntStrings;
    function GetWidePickList: TTntStrings;
    procedure SetWidePickList(const Value: TTntStrings);
    procedure HandlePickListChange(Sender: TObject);
    function GetTitle: TTntColumnTitle;
    procedure SetTitle(const Value: TTntColumnTitle);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    function  CreateTitle: TColumnTitle{TNT-ALLOW TColumnTitle}; override;
  public
    destructor Destroy; override;
    property WidePickList: TTntStrings read GetWidePickList write SetWidePickList;
  published
{TNT-WARN PickList}
    property PickList{TNT-ALLOW PickList}: TTntStrings read GetWidePickList write SetWidePickList;
    property Title: TTntColumnTitle read GetTitle write SetTitle;
  end;

  { TDBGridInplaceEdit adds support for a button on the in-place editor,
    which can be used to drop down a table-based lookup list, a stringlist-based
    pick list, or (if button style is esEllipsis) fire the grid event
    OnEditButtonClick.  }

type
  TDBGridInplaceEdit{TNT-ALLOW TDBGridInplaceEdit} = class(TInplaceEditList)
  private
    {$IFDEF COMPILER_6} // verified against VCL source in Delphi 6 and BCB 6
    FDataList: TDBLookupListBox; // 1st field - Delphi/BCB 6 TCustomDBGrid assumes this
    FUseDataList: Boolean;       // 2nd field - Delphi/BCB 6 TCustomDBGrid assumes this
    {$ENDIF}
    {$IFDEF DELPHI_7}  // verified against VCL source in Delphi 7
    FDataList: TDBLookupListBox; // 1st field - Delphi 7 TCustomDBGrid assumes this
    FUseDataList: Boolean;       // 2nd field - Delphi 7 TCustomDBGrid assumes this
    {$ENDIF}
    {$IFDEF DELPHI_9} // verified against VCL source in Delphi 9
    FDataList: TDBLookupListBox; // 1st field - Delphi 9 TCustomDBGrid assumes this
    FUseDataList: Boolean;       // 2nd field - Delphi 9 TCustomDBGrid assumes this
    {$ENDIF}
    {$IFDEF DELPHI_10} // verified against VCL source in Delphi 10
    FDataList: TDBLookupListBox; // 1st field - Delphi 10 TCustomDBGrid assumes this
    FUseDataList: Boolean;       // 2nd field - Delphi 10 TCustomDBGrid assumes this
    {$ENDIF}
    FLookupSource: TDatasource;
    FWidePickListBox: TTntCustomListbox;
    function GetWidePickListBox: TTntCustomListbox;
  protected
    procedure CloseUp(Accept: Boolean); override;
    procedure DoEditButtonClick; override;
    procedure DropDown; override;
    procedure UpdateContents; override;
    property UseDataList: Boolean read FUseDataList;
  public
    constructor Create(Owner: TComponent); override;
    property DataList: TDBLookupListBox read FDataList;
    property WidePickListBox: TTntCustomListbox read GetWidePickListBox;
  end;

type
{TNT-WARN TDBGridInplaceEdit}
  TTntDBGridInplaceEdit = class(TDBGridInplaceEdit{TNT-ALLOW TDBGridInplaceEdit})
  private
    FInDblClick: Boolean;
    FBlockSetText: Boolean;
    procedure WMSetText(var Message: TWMSetText); message WM_SETTEXT;
  protected
    function GetText: WideString; virtual;
    procedure SetText(const Value: WideString); virtual;
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure UpdateContents; override;
    procedure DblClick; override;
  public
    property Text: WideString read GetText write SetText;
  end;

{TNT-WARN TDBGridColumns}
  TTntDBGridColumns = class(TDBGridColumns{TNT-ALLOW TDBGridColumns})
  private
    function GetColumn(Index: Integer): TTntColumn;
    procedure SetColumn(Index: Integer; const Value: TTntColumn);
  public
    function Add: TTntColumn;
    property Items[Index: Integer]: TTntColumn read GetColumn write SetColumn; default;
  end;

  TTntGridDataLink = class(TGridDataLink)
  private
    OriginalSetText: TFieldSetTextEvent;
    FModifiedEx: Boolean;
    procedure GridUpdateFieldText(Sender: TField; const Text: AnsiString);
  protected
    procedure ActiveChanged; override;
    procedure UpdateData; override;
    procedure ModifiedEx;
    procedure RecordChanged(Field: TField); override;
    procedure DataSetChanged; override;
  end;

  TTntDBGridMaskEdit = class;

{TNT-WARN TCustomDBGrid}
  TTntCustomDBGrid = class(TCustomDBGrid{TNT-ALLOW TCustomDBGrid})
  private
    FEditText: WideString;
    FDBMaskEdit: TTntDBGridMaskEdit;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    function IsHintStored: Boolean;
    procedure WMChar(var Msg: TWMChar); message WM_CHAR;
    procedure WMCommand(var Message: TWMCommand); message WM_COMMAND;
    procedure WMLButtonDown(var Message: TMessage); message WM_LBUTTONDOWN;
    function GetColumns: TTntDBGridColumns;
    procedure SetColumns(const Value: TTntDBGridColumns);
    procedure ShowEditControl(ACol, ARow: Integer);
    procedure HideEditControl(ACol, ARow: Integer);
    procedure HideInplaceEdit;
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure ShowEditorChar(Ch: WideChar); dynamic;
    procedure DefineProperties(Filer: TFiler); override;
    function GetActionLinkClass: TControlActionLinkClass; override;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    function CreateColumns: TDBGridColumns{TNT-ALLOW TDBGridColumns}; override;
    property Columns: TTntDBGridColumns read GetColumns write SetColumns;
    function CreateEditor: TInplaceEdit{TNT-ALLOW TInplaceEdit}; override;
    function CreateDataLink: TGridDataLink; override;
    function GetEditText(ACol, ARow: Longint): WideString; reintroduce;
    procedure DrawCell(ACol, ARow: Integer; ARect: TRect; AState: TGridDrawState); override;
    procedure SetEditText(ACol, ARow: Longint; const Value: AnsiString); override;
    procedure UpdateData;
    function CanEditShow: Boolean; override;
    function CanEditModify: Boolean; override;
    function IsMaskedEdit(ACol, ARow: Integer): Boolean; overload;
    function IsMaskedEdit: Boolean; overload;
    procedure UpdateText;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DefaultDrawColumnCell(const Rect: TRect; DataCol: Integer;
      Column: TTntColumn; State: TGridDrawState); dynamic;
    procedure DefaultDrawDataCell(const Rect: TRect; Field: TField;
      State: TGridDrawState);
  published
    property Hint: WideString read GetHint write SetHint stored IsHintStored;
  end;

{TNT-WARN TDBGrid}
  TTntDBGrid = class(TTntCustomDBGrid)
  public
    property Canvas;
    property SelectedRows;
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Columns stored False; //StoreColumns;
    property Constraints;
    property Ctl3D;
    property DataSource;
    property DefaultDrawing;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FixedColor;
    property Font;
    property ImeMode;
    property ImeName;
    property Options;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property TitleFont;
    property Visible;
    property OnCellClick;
    property OnColEnter;
    property OnColExit;
    property OnColumnMoved;
    property OnDrawDataCell;  { obsolete }
    property OnDrawColumnCell;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEditButtonClick;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    {$IFDEF COMPILER_9_UP}
    property OnMouseActivate;
    {$ENDIF}
    property OnMouseDown;
    {$IFDEF COMPILER_10_UP}
    property OnMouseEnter;
    property OnMouseLeave;
    {$ENDIF}
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnStartDock;
    property OnStartDrag;
    property OnTitleClick;
  end;

  TTntDBGridMaskEdit = class(TTntMaskEdit)
  private
    FClickTime: Longint;
    procedure CMWantSpecialKey(var Msg: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
    procedure WMChar(var Msg: TWMChar); message WM_CHAR;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure DoExit; override;
    procedure UpdateContents; virtual;
    procedure Deselect;
  public
    FGrid: TTntDBGrid;
    constructor Create(AOwner: TComponent); override;
    procedure ReCreate;
  end;

implementation

uses
  SysUtils, TntControls, Math, Variants, Forms,
  TntGraphics, Graphics, TntDB, TntActnList, TntSysUtils, TntWindows;

{ TTntColumnTitle }

procedure TTntColumnTitle.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntColumnTitle.DefaultCaption: WideString;
var
  Field: TField;
begin
  Field := Column.Field;
  if Assigned(Field) then
    Result := Field.DisplayName
  else
    Result := Column.FieldName;
end;

function TTntColumnTitle.IsCaptionStored: Boolean;
begin
  Result := (cvTitleCaption in Column.AssignedValues) and
    (FCaption <> DefaultCaption);
end;

procedure TTntColumnTitle.SetInheritedCaption(const Value: AnsiString);
begin
  inherited Caption := Value;
end;

function TTntColumnTitle.GetCaption: WideString;
begin
  if cvTitleCaption in Column.AssignedValues then
    Result := GetSyncedWideString(FCaption, inherited Caption)
  else
    Result := DefaultCaption;
end;

procedure TTntColumnTitle.SetCaption(const Value: WideString);
begin
  if not (Column as TTntColumn).IsStored then
    inherited Caption := Value
  else begin
    if (cvTitleCaption in Column.AssignedValues) and (Value = FCaption) then Exit;
    SetSyncedWideString(Value, FCaption, inherited Caption, SetInheritedCaption);
  end;
end;

procedure TTntColumnTitle.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TTntColumnTitle then
  begin
    if cvTitleCaption in TTntColumnTitle(Source).Column.AssignedValues then
      Caption := TTntColumnTitle(Source).Caption;
  end;
end;

procedure TTntColumnTitle.RestoreDefaults;
begin
  FCaption := '';
  inherited;
end;

{ TTntColumn }

procedure TTntColumn.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntColumn.CreateTitle: TColumnTitle{TNT-ALLOW TColumnTitle};
begin
  Result := TTntColumnTitle.Create(Self);
end;

function TTntColumn.GetTitle: TTntColumnTitle;
begin
  Result := (inherited Title) as TTntColumnTitle;
end;

procedure TTntColumn.SetTitle(const Value: TTntColumnTitle);
begin
  inherited Title := Value;
end;

function TTntColumn.GetWidePickList: TTntStrings;
begin
  if FWidePickList = nil then begin
    FWidePickList := TTntStringList.Create;
    TTntStringList(FWidePickList).OnChange := HandlePickListChange;
  end;
  Result := FWidePickList;
end;

procedure TTntColumn.SetWidePickList(const Value: TTntStrings);
begin
  if Value = nil then
  begin
    FWidePickList.Free;
    FWidePickList := nil;
    (inherited PickList{TNT-ALLOW PickList}).Clear;
    Exit;
  end;
  WidePickList.Assign(Value);
end;

procedure TTntColumn.HandlePickListChange(Sender: TObject);
begin
  inherited PickList{TNT-ALLOW PickList}.Assign(WidePickList);
end;

destructor TTntColumn.Destroy;
begin
  inherited;
  FWidePickList.Free;
end;

{ TTntPopupListbox }
type
  TTntPopupListbox = class(TTntCustomListbox)
  private
    FSearchText: WideString;
    FSearchTickCount: Longint;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
    procedure KeyPressW(var Key: WideChar);
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  end;

procedure TTntPopupListbox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_BORDER;
    ExStyle := WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
    AddBiDiModeExStyle(ExStyle);
    WindowClass.Style := CS_SAVEBITS;
  end;
end;

procedure TTntPopupListbox.CreateWnd;
begin
  inherited CreateWnd;
  Windows.SetParent(Handle, 0);
  CallWindowProc(DefWndProc, Handle, wm_SetFocus, 0, 0);
end;

procedure TTntPopupListbox.WMChar(var Message: TWMChar);
var
  Key: WideChar;
begin
  Key := GetWideCharFromWMCharMsg(Message);
  KeyPressW(Key);
  SetWideCharForWMCharMsg(Message, Key);
  inherited;
end;

procedure TTntPopupListbox.KeypressW(var Key: WideChar);
var
  TickCount: Integer;
begin
  case Key of
    #8, #27: FSearchText := '';
    #32..High(WideChar):
      begin
        TickCount := GetTickCount;
        if TickCount - FSearchTickCount > 2000 then FSearchText := '';
        FSearchTickCount := TickCount;
        if Length(FSearchText) < 32 then FSearchText := FSearchText + Key;
        if IsWindowUnicode(Handle) then
          SendMessageW(Handle, LB_SelectString, WORD(-1), Longint(PWideChar(FSearchText)))
        else
          SendMessageA(Handle, LB_SelectString, WORD(-1), Longint(PAnsiChar(AnsiString(FSearchText))));
        Key := #0;
      end;
  end;
end;

procedure TTntPopupListbox.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  (Owner as TDBGridInplaceEdit{TNT-ALLOW TDBGridInplaceEdit}).CloseUp((X >= 0) and (Y >= 0) and
      (X < Width) and (Y < Height));
end;

{ TTntPopupDataList }
type
  TTntPopupDataList = class(TPopupDataList)
  protected
    procedure Paint; override;
  end;

procedure TTntPopupDataList.Paint;
var
  FRecordIndex: Integer;
  FRecordCount: Integer;
  FKeySelected: Boolean;
  FKeyField: TField;

  procedure UpdateListVars;
  begin
    if ListActive then
    begin
      FRecordIndex := ListLink.ActiveRecord;
      FRecordCount := ListLink.RecordCount;
      FKeySelected := not VarIsNull(KeyValue) or
        not ListLink.DataSet.BOF;
    end else
    begin
      FRecordIndex := 0;
      FRecordCount := 0;
      FKeySelected := False;
    end;

    FKeyField := nil;
    if ListLink.Active and (KeyField <> '') then
      FKeyField := GetFieldProperty(ListLink.DataSet, Self, KeyField);
  end;

  function VarEquals(const V1, V2: Variant): Boolean;
  begin
    Result := False;
    try
      Result := V1 = V2;
    except
    end;
  end;

var
  I, J, W, X, TxtWidth, TxtHeight, LastFieldIndex: Integer;
  S: WideString;
  R: TRect;
  Selected: Boolean;
  Field: TField;
  AAlignment: TAlignment;
begin
  UpdateListVars;
  Canvas.Font := Font;
  TxtWidth := WideCanvasTextWidth(Canvas, '0');
  TxtHeight := WideCanvasTextHeight(Canvas, '0');
  LastFieldIndex := ListFields.Count - 1;
  if ColorToRGB(Color) <> ColorToRGB(clBtnFace) then
    Canvas.Pen.Color := clBtnFace else
    Canvas.Pen.Color := clBtnShadow;
  for I := 0 to RowCount - 1 do
  begin
    if Enabled then
      Canvas.Font.Color := Font.Color else
      Canvas.Font.Color := clGrayText;
    Canvas.Brush.Color := Color;
    Selected := not FKeySelected and (I = 0);
    R.Top := I * TxtHeight;
    R.Bottom := R.Top + TxtHeight;
    if I < FRecordCount then
    begin
      ListLink.ActiveRecord := I;
      if not VarIsNull(KeyValue) and
        VarEquals(FKeyField.Value, KeyValue) then
      begin
        Canvas.Font.Color := clHighlightText;
        Canvas.Brush.Color := clHighlight;
        Selected := True;
      end;
      R.Right := 0;
      for J := 0 to LastFieldIndex do
      begin
        Field := ListFields[J];
        if J < LastFieldIndex then
          W := Field.DisplayWidth * TxtWidth + 4 else
          W := ClientWidth - R.Right;
        S := GetWideDisplayText(Field);
        X := 2;
        AAlignment := Field.Alignment;
        if UseRightToLeftAlignment then ChangeBiDiModeAlignment(AAlignment);
        case AAlignment of
          taRightJustify: X := W - WideCanvasTextWidth(Canvas, S) - 3;
          taCenter: X := (W - WideCanvasTextWidth(Canvas, S)) div 2;
        end;
        R.Left := R.Right;
        R.Right := R.Right + W;
        if SysLocale.MiddleEast then TControlCanvas(Canvas).UpdateTextFlags;
        WideCanvasTextRect(Canvas, R, R.Left + X, R.Top, S);
        if J < LastFieldIndex then
        begin
          Canvas.MoveTo(R.Right, R.Top);
          Canvas.LineTo(R.Right, R.Bottom);
          Inc(R.Right);
          if R.Right >= ClientWidth then Break;
        end;
      end;
    end;
    R.Left := 0;
    R.Right := ClientWidth;
    if I >= FRecordCount then Canvas.FillRect(R);
    if Selected then
      Canvas.DrawFocusRect(R);
  end;
  if FRecordCount <> 0 then ListLink.ActiveRecord := FRecordIndex;
end;

//-----------------------------------------------------------------------------------------
//                   TDBGridInplaceEdit - Delphi 6 and higher
//-----------------------------------------------------------------------------------------

constructor TDBGridInplaceEdit{TNT-ALLOW TDBGridInplaceEdit}.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FLookupSource := TDataSource.Create(Self);
end;

function TDBGridInplaceEdit{TNT-ALLOW TDBGridInplaceEdit}.GetWidePickListBox: TTntCustomListBox;
var
  PopupListbox: TTntPopupListbox;
begin
  if not Assigned(FWidePickListBox) then
  begin
    PopupListbox := TTntPopupListbox.Create(Self);
    PopupListbox.Visible := False;
    PopupListbox.Parent := Self;
    PopupListbox.OnMouseUp := ListMouseUp;
    PopupListbox.IntegralHeight := True;
    PopupListbox.ItemHeight := 11;
    FWidePickListBox := PopupListBox;
  end;
  Result := FWidePickListBox;
end;

procedure TDBGridInplaceEdit{TNT-ALLOW TDBGridInplaceEdit}.CloseUp(Accept: Boolean);
var
  MasterField: TField;
  ListValue: Variant;
begin
  if ListVisible then
  begin
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    if ActiveList = DataList then
      ListValue := DataList.KeyValue
    else
      if WidePickListBox.ItemIndex <> -1 then
        ListValue := WidePickListBox.Items[WidePickListBox.ItemIndex];
    SetWindowPos(ActiveList.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    ListVisible := False;
    if Assigned(FDataList) then
      FDataList.ListSource := nil;
    FLookupSource.Dataset := nil;
    Invalidate;
    if Accept then
      if ActiveList = DataList then
        with Grid as TTntCustomDBGrid, Columns[SelectedIndex].Field do
        begin
          MasterField := DataSet.FieldByName(KeyFields);
          if MasterField.CanModify and DataLink.Edit then
            MasterField.Value := ListValue;
        end
      else
        if (not VarIsNull(ListValue)) and EditCanModify then
          with Grid as TTntCustomDBGrid do
            SetWideText(Columns[SelectedIndex].Field, ListValue)
  end;
end;

procedure TDBGridInplaceEdit{TNT-ALLOW TDBGridInplaceEdit}.DoEditButtonClick;
begin
  (Grid as TTntCustomDBGrid).EditButtonClick;
end;

type TAccessTntCustomListbox = class(TTntCustomListbox);

procedure TDBGridInplaceEdit{TNT-ALLOW TDBGridInplaceEdit}.DropDown;
var
   Column: TTntColumn;
   I, J, Y: Integer;
begin
  if not ListVisible then
  begin
    with (Grid as TTntCustomDBGrid) do
      Column := Columns[SelectedIndex] as TTntColumn;
    if ActiveList = FDataList then
      with Column.Field do
      begin
        FDataList.Color := Color;
        FDataList.Font := Font;
        FDataList.RowCount := Column.DropDownRows;
        FLookupSource.DataSet := LookupDataSet;
        FDataList.KeyField := LookupKeyFields;
        FDataList.ListField := LookupResultField;
        FDataList.ListSource := FLookupSource;
        FDataList.KeyValue := DataSet.FieldByName(KeyFields).Value;
      end
    else if ActiveList = WidePickListBox then
    begin
      WidePickListBox.Items.Assign(Column.WidePickList);
      DropDownRows := Column.DropDownRows;
      // this is needed as inherited doesn't know about our WidePickListBox
      if (DropDownRows > 0) and (WidePickListBox.Items.Count >= DropDownRows) then
        WidePickListBox.Height := DropDownRows * TAccessTntCustomListbox(WidePickListBox as TTntCustomListbox).ItemHeight + 4
      else
        WidePickListBox.Height := WidePickListBox.Items.Count * TAccessTntCustomListbox(WidePickListBox as TTntCustomListbox).ItemHeight + 4;
      if Text = '' then
        WidePickListBox.ItemIndex := -1
      else
        WidePickListBox.ItemIndex := WidePickListBox.Items.IndexOf(Text);
      J := WidePickListBox.ClientWidth;
      for I := 0 to WidePickListBox.Items.Count - 1 do
      begin
        Y := WideCanvasTextWidth(WidePickListBox.Canvas, WidePickListBox.Items[I]);
        if Y > J then J := Y;
      end;
      WidePickListBox.ClientWidth := J;
    end;
  end;
  inherited DropDown;
end;

procedure TDBGridInplaceEdit{TNT-ALLOW TDBGridInplaceEdit}.UpdateContents;
var
  Column: TTntColumn;
begin
  inherited UpdateContents;
  if EditStyle = esPickList then
    ActiveList := WidePickListBox;
  if FUseDataList then
  begin
    if FDataList = nil then
    begin
      FDataList := TTntPopupDataList.Create(Self);
      FDataList.Visible := False;
      FDataList.Parent := Self;
      FDataList.OnMouseUp := ListMouseUp;
    end;
    ActiveList := FDataList;
  end;
  with (Grid as TTntCustomDBGrid) do
    Column := Columns[SelectedIndex] as TTntColumn;
  Self.ReadOnly := Column.ReadOnly;
  Font.Assign(Column.Font);
  ImeMode := Column.ImeMode;
  ImeName := Column.ImeName;
end;

//-----------------------------------------------------------------------------------------

{ TTntDBGridInplaceEdit }

procedure TTntDBGridInplaceEdit.CreateWindowHandle(const Params: TCreateParams);
begin
  TntCustomEdit_CreateWindowHandle(Self, Params);
end;

function TTntDBGridInplaceEdit.GetText: WideString;
begin
  Result := TntControl_GetText(Self);
end;

procedure TTntDBGridInplaceEdit.SetText(const Value: WideString);
begin
  TntControl_SetText(Self, Value);
end;

procedure TTntDBGridInplaceEdit.WMSetText(var Message: TWMSetText);
begin
  if (not FBlockSetText) then
    inherited;
end;

procedure TTntDBGridInplaceEdit.UpdateContents;
var
  Grid: TTntCustomDBGrid;
begin
  Grid := Self.Grid as TTntCustomDBGrid;
  EditMask  := Grid.GetEditMask(Grid.Col, Grid.Row);
  Text      := Grid.GetEditText(Grid.Col, Grid.Row);
  MaxLength := Grid.GetEditLimit;

  FBlockSetText := True;
  try
    inherited;
  finally
    FBlockSetText := False;
  end;
end;

procedure TTntDBGridInplaceEdit.DblClick;
begin
  FInDblClick := True;
  try
    inherited;
  finally
    FInDblClick := False;
  end;
end;

type
  TSelection = record
    StartPos, EndPos: Integer;
  end;

{ TTntDBGridMaskEdit }

procedure TTntDBGridMaskEdit.CMWantSpecialKey(var Msg: TCMWantSpecialKey);
begin
  inherited;
  if (Msg.CharCode = VK_RETURN) then
    Msg.Result := 1;

  if (Msg.CharCode = VK_TAB) and (dgTabs in FGrid.Options) then
    Msg.Result := 1;
end;

constructor TTntDBGridMaskEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FGrid := AOwner as TTntDBGrid;
end;

procedure TTntDBGridMaskEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_MULTILINE;
end;

procedure TTntDBGridMaskEdit.Deselect;
begin
  SendMessage(Handle, EM_SETSEL, $7FFFFFFF, Longint($FFFFFFFF));
end;

procedure TTntDBGridMaskEdit.DoExit;
begin
  FGrid.HideEditor;
  FGrid.HideInplaceEdit;
  self.Text := ' ';
  inherited DoExit;
end;

procedure TTntDBGridMaskEdit.KeyDown(var Key: Word; Shift: TShiftState);
  procedure SendToParent;
  begin
    FGrid.KeyDown(Key, Shift);
  end;

  function ForwardMovement: Boolean;
  begin
    Result := dgAlwaysShowEditor in FGrid.Options;
  end;

  function Ctrl: Boolean;
  begin
    Result := ssCtrl in Shift;
  end;

  function Selection: TSelection;
  begin
    SendMessage(Handle, EM_GETSEL, Longint(@Result.StartPos), Longint(@Result.EndPos));
  end;

  function CaretPos: Integer;
  var
    P: TPoint;
  begin
    Windows.GetCaretPos(P);
    Result := SendMessage(Handle, EM_CHARFROMPOS, 0, MakeLong(P.X, P.Y));
  end;

  function RightSide: Boolean;
  begin
    with Selection do
      Result := (CaretPos = GetTextLen) and
        ((StartPos = 0) or (EndPos = StartPos)) and (EndPos = GetTextLen);
   end;

  function LeftSide: Boolean;
  begin
    with Selection do
      Result := (CaretPos = 0) and (StartPos = 0) and
        ((EndPos = 0) or (EndPos = GetTextLen));
  end;

begin
  case Key of
    VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT, VK_ESCAPE: SendToParent;
    //VK_TAB: if not (ssAlt in Shift) and (dgTabs in FGrid.Options) then SendToParent;
    VK_LEFT: if ForwardMovement and (Ctrl or LeftSide) then SendToParent;
    VK_RIGHT: if ForwardMovement and (Ctrl or RightSide) then SendToParent;
    VK_HOME: if ForwardMovement and (Ctrl or LeftSide) then SendToParent;
    VK_END: if ForwardMovement and (Ctrl or RightSide) then SendToParent;
    VK_F2:
      begin
        //ParentEvent;
        if Key = VK_F2 then
        begin
          Deselect;
          Exit;
        end;
      end;
    VK_DELETE:
      if Ctrl then
        SendToParent
      else
        if not FGrid.CanEditModify then Key := 0;
  end;

  if (Key in [VK_DOWN,VK_UP,VK_ESCAPE,VK_RETURN,VK_TAB]) then
  begin
    if (Key in [VK_RETURN, VK_UP, VK_DOWN]) then
    begin
      FGrid.HideEditor;
      FGrid.HideInplaceEdit;
      FGrid.SetFocus;
    end;

    if (Key = VK_TAB) and (dgTabs in FGrid.Options) then
    begin
      FGrid.HideInplaceEdit;
      FGrid.SetFocus;
    end;

    if (Key = VK_TAB) and not (ssAlt in Shift) and (dgTabs in FGrid.Options) then SendToParent;

    if Key = VK_ESCAPE then
    begin
      //self.Text := FGrid.Cells[FGrid.Col,FGrid.Row];
      FGrid.HideInplaceEdit;
      FGrid.SetFocus;
    end;
  end;

  if Key <> 0 then
  begin
    inherited KeyDown(Key, Shift);
  end;
end;

procedure TTntDBGridMaskEdit.KeyPress(var Key: Char);
//var
  //Selection: TSelection;
begin
  inherited;
  {
  if not (Key in [#27, #33, #34, #35, #36, #37, #39]) then
  begin
    FGrid.UpdateText;
  end;

  FGrid.KeyPress(Key);
  if (Key in [#32..#255]) and not FGrid.CanEditAcceptKey(Key) then
  begin
    Key := #0;
    MessageBeep(0);
  end;
  case Key of
    #9, #27: Key := #0;
    #13:
      begin
        SendMessage(Handle, EM_GETSEL, Longint(@Selection.StartPos), Longint(@Selection.EndPos));
        if (Selection.StartPos = 0) and (Selection.EndPos = GetTextLen) then
          Deselect else
          SelectAll;
        Key := #0;
      end;
    ^H, ^V, ^X, #32..#255:
      if not FGrid.CanEditModify then Key := #0;
  end;
  if Key <> #0 then inherited KeyPress(Key);}
end;

procedure TTntDBGridMaskEdit.WMPaste(var Message: TMessage);
begin
  inherited;
  FGrid.UpdateText;
end;

procedure TTntDBGridMaskEdit.CMTextChanged(var Message: TMessage);
begin
  inherited;
end;

procedure TTntDBGridMaskEdit.WMChar(var Msg: TWMChar);
var
  Key: WChar;
  Selection: TSelection;
begin
  if Msg.CharCode in [Ord(#13),Ord(#9)] then
    Msg.Result :=0
  else
  begin
    if IsMasked and (Char(Msg.CharCode) <> #0) {and not (Char(Msg.CharCode) in [^V, ^X, ^C])} then
    begin
      Key := WideChar(Msg.CharCode);
      if (Char(Key) in [#32..#255]) and not FGrid.CanEditAcceptKey(Char(Key)) then
      begin
        //Key := #0;
        MessageBeep(0);
      end;
      case Key of
        #9, #27: ;//Key := #0;
        #13:
          begin
            SendMessage(Handle, EM_GETSEL, Longint(@Selection.StartPos), Longint(@Selection.EndPos));
            if (Selection.StartPos = 0) and (Selection.EndPos = GetTextLen) then
              Deselect else
              SelectAll;
            //Key := #0;
          end;
        ^H, ^V, ^X, #32..#255:
          if not FGrid.CanEditModify then ;//Key := #0;
      end;
    end;

    inherited;

    if not (Msg.CharCode in [Ord(#27), Ord(#33), Ord(#34), Ord(#35), Ord(#36), Ord(#37), Ord(#39)]) then
    begin
      FGrid.UpdateText;
    end;
  end;
end;

procedure TTntDBGridMaskEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  FGrid.KeyUp(Key, Shift);
end;

procedure TTntDBGridMaskEdit.ReCreate;
begin
  ReCreateWnd;
end;

procedure TTntDBGridMaskEdit.UpdateContents;
begin
  Text := '';
  EditMask := FGrid.GetEditMask(FGrid.Col, FGrid.Row);
  Text := FGrid.GetEditText(FGrid.Col, FGrid.Row);
  MaxLength := FGrid.GetEditLimit;
end;

procedure TTntDBGridMaskEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  if dgTabs in FGrid.Options then
    Message.Result := Message.Result or DLGC_WANTTAB;
end;

procedure TTntDBGridMaskEdit.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
end;

{ TTntGridDataLink }

procedure TTntGridDataLink.ActiveChanged;
begin
  inherited;
  FModifiedEx := False;
end;

procedure TTntGridDataLink.DataSetChanged;
begin
  inherited;
  FModifiedEx := False;
end;

procedure TTntGridDataLink.GridUpdateFieldText(Sender: TField; const Text: AnsiString);
begin
  Sender.OnSetText := OriginalSetText;
  if Assigned(Sender) then
    SetWideText(Sender, (Grid as TTntCustomDBGrid).FEditText);
end;

procedure TTntGridDataLink.ModifiedEx;
begin
  FModifiedEx := True;
  Modified;
end;

procedure TTntGridDataLink.RecordChanged(Field: TField);
var
  CField: TField;
begin
  inherited;
  if Grid.HandleAllocated then begin
    CField := Grid.SelectedField;
    if ((Field = nil) or (CField = Field)) and
      (Assigned(CField) and (GetWideText(CField) <> (Grid as TTntCustomDBGrid).FEditText)) then
    begin
      with (Grid as TTntCustomDBGrid) do begin
        InvalidateEditor;
        if InplaceEditor <> nil then InplaceEditor.Deselect;
      end;
    end;
  end;
  FModifiedEx := False;
end;

procedure TTntGridDataLink.UpdateData;
var
  Field: TField;
begin
  Field := (Grid as TTntCustomDBGrid).SelectedField;

  if not (csDesigning in Grid.ComponentState) and Assigned(Field) and (Field.EditMask <> '') then
  begin
    if FModifiedEx and (DataSet.State in [dsEdit, dsInsert]) then
      SetWideText(Field, (Grid as TTntCustomDBGrid).FEditText);
  end
  else
  begin
    // remember "set text"
    if Field <> nil then
      OriginalSetText := Field.OnSetText;
    try
      // redirect "set text" to self
      if Field <> nil then
        Field.OnSetText := GridUpdateFieldText;
      inherited; // clear modified !
    finally
      // redirect "set text" to field
      if Field <> nil then
        Field.OnSetText := OriginalSetText;
      // forget original "set text"
      OriginalSetText := nil;
    end;
  end;
  
  FModifiedEx := False;
end;

{ TTntDBGridColumns }

function TTntDBGridColumns.Add: TTntColumn;
begin
  Result := inherited Add as TTntColumn;
end;

function TTntDBGridColumns.GetColumn(Index: Integer): TTntColumn;
begin
  Result := inherited Items[Index] as TTntColumn;
end;

procedure TTntDBGridColumns.SetColumn(Index: Integer; const Value: TTntColumn);
begin
  inherited Items[Index] := Value;
end;

{ TTntCustomDBGrid }

procedure TTntCustomDBGrid.CreateWindowHandle(const Params: TCreateParams);
begin
  CreateUnicodeHandle(Self, Params, '');
end;

type TAccessCustomGrid = class(TCustomGrid);

procedure TTntCustomDBGrid.WMChar(var Msg: TWMChar);
begin
  if (goEditing in TAccessCustomGrid(Self).Options)
  and (AnsiChar(Msg.CharCode) in [^H, #32..#255]) then begin
    RestoreWMCharMsg(TMessage(Msg));
    ShowEditorChar(WideChar(Msg.CharCode));
  end else
    inherited;
end;

procedure TTntCustomDBGrid.ShowEditorChar(Ch: WideChar);
begin
  ShowEditor;
  if InplaceEditor <> nil then begin
    if Win32PlatformIsUnicode then
      PostMessageW(InplaceEditor.Handle, WM_CHAR, Word(Ch), 0)
    else
      PostMessageA(InplaceEditor.Handle, WM_CHAR, Word(Ch), 0);
  end;
end;

procedure TTntCustomDBGrid.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntCustomDBGrid.IsHintStored: Boolean;
begin
  Result := TntControl_IsHintStored(Self);
end;

function TTntCustomDBGrid.GetHint: WideString;
begin
  Result := TntControl_GetHint(Self)
end;

procedure TTntCustomDBGrid.SetHint(const Value: WideString);
begin
  TntControl_SetHint(Self, Value);
end;

function TTntCustomDBGrid.CreateColumns: TDBGridColumns{TNT-ALLOW TDBGridColumns};
begin
  Result := TTntDBGridColumns.Create(Self, TTntColumn);
end;

function TTntCustomDBGrid.GetColumns: TTntDBGridColumns;
begin
  Result := inherited Columns as TTntDBGridColumns;
end;

procedure TTntCustomDBGrid.SetColumns(const Value: TTntDBGridColumns);
begin
  inherited Columns := Value;
end;

function TTntCustomDBGrid.CreateEditor: TInplaceEdit{TNT-ALLOW TInplaceEdit};
begin
  Result := TTntDBGridInplaceEdit.Create(Self);
end;

function TTntCustomDBGrid.CreateDataLink: TGridDataLink;
begin
  Result := TTntGridDataLink.Create(Self);
end;

function TTntCustomDBGrid.GetEditText(ACol, ARow: Integer): WideString;
var
  Field: TField;
begin
  Field := GetColField(RawToDataColumn(ACol));
  if Field = nil then
    Result := ''
  else
    Result := GetWideText(Field);
  FEditText := Result;
end;

procedure TTntCustomDBGrid.SetEditText(ACol, ARow: Integer; const Value: AnsiString);
begin
  if Assigned(InplaceEditor) and not IsMaskedEdit then
  begin
    if (InplaceEditor as TTntDBGridInplaceEdit).FInDblClick then
      FEditText := Value
    else
      FEditText := (InplaceEditor as TTntDBGridInplaceEdit).Text;
  end
  else if Assigned(FDBMaskEdit) and IsMaskedEdit then
  begin
    FEditText := FDBMaskEdit.Text;
  end;
  inherited;
end;

procedure TTntCustomDBGrid.UpdateText;
begin
  if Assigned(FDBMaskEdit) and IsMaskedEdit then
  begin
    FEditText := FDBMaskEdit.Text;
  end;
end;

//----------------- DRAW CELL PROCS --------------------------------------------------
var
  DrawBitmap: TBitmap = nil;

procedure WriteText(ACanvas: TCanvas; ARect: TRect; DX, DY: Integer;
  const Text: WideString; Alignment: TAlignment; ARightToLeft: Boolean);
const
  AlignFlags : array [TAlignment] of Integer =
    ( DT_LEFT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
      DT_RIGHT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
      DT_CENTER or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX );
  RTL: array [Boolean] of Integer = (0, DT_RTLREADING);
var
  B, R: TRect;
  Hold, Left: Integer;
  I: TColorRef;
begin
  I := ColorToRGB(ACanvas.Brush.Color);
  if GetNearestColor(ACanvas.Handle, I) = I then
  begin                       { Use ExtTextOutW for solid colors }
    { In BiDi, because we changed the window origin, the text that does not
      change alignment, actually gets its alignment changed. }
    if (ACanvas.CanvasOrientation = coRightToLeft) and (not ARightToLeft) then
      ChangeBiDiModeAlignment(Alignment);
    case Alignment of
      taLeftJustify:
        Left := ARect.Left + DX;
      taRightJustify:
        Left := ARect.Right - WideCanvasTextWidth(ACanvas, Text) - 3;
    else { taCenter }
      Left := ARect.Left + (ARect.Right - ARect.Left) div 2
        - (WideCanvasTextWidth(ACanvas, Text) div 2);
    end;
    WideCanvasTextRect(ACanvas, ARect, Left, ARect.Top + DY, Text);
  end
  else begin                  { Use FillRect and Drawtext for dithered colors }
    DrawBitmap.Canvas.Lock;
    try
      with DrawBitmap, ARect do { Use offscreen bitmap to eliminate flicker and }
      begin                     { brush origin tics in painting / scrolling.    }
        Width := Max(Width, Right - Left);
        Height := Max(Height, Bottom - Top);
        R := Rect(DX, DY, Right - Left - 1, Bottom - Top - 1);
        B := Rect(0, 0, Right - Left, Bottom - Top);
      end;
      with DrawBitmap.Canvas do
      begin
        Font := ACanvas.Font;
        Font.Color := ACanvas.Font.Color;
        Brush := ACanvas.Brush;
        Brush.Style := bsSolid;
        FillRect(B);
        SetBkMode(Handle, TRANSPARENT);
        if (ACanvas.CanvasOrientation = coRightToLeft) then
          ChangeBiDiModeAlignment(Alignment);
        Tnt_DrawTextW(Handle, PWideChar(Text), Length(Text), R,
          AlignFlags[Alignment] or RTL[ARightToLeft]);
      end;
      if (ACanvas.CanvasOrientation = coRightToLeft) then  
      begin
        Hold := ARect.Left;
        ARect.Left := ARect.Right;
        ARect.Right := Hold;
      end;
      ACanvas.CopyRect(ARect, DrawBitmap.Canvas, B);
    finally
      DrawBitmap.Canvas.Unlock;
    end;
  end;
end;

procedure TTntCustomDBGrid.DefaultDrawDataCell(const Rect: TRect; Field: TField;
  State: TGridDrawState);
var
  Alignment: TAlignment;
  Value: WideString;
begin
  Alignment := taLeftJustify;
  Value := '';
  if Assigned(Field) then
  begin
    Alignment := Field.Alignment;
    Value := GetWideDisplayText(Field);
  end;
  WriteText(Canvas, Rect, 2, 2, Value, Alignment,
    UseRightToLeftAlignmentForField(Field, Alignment));
end;

procedure TTntCustomDBGrid.DefaultDrawColumnCell(const Rect: TRect;
  DataCol: Integer; Column: TTntColumn; State: TGridDrawState);
var
  Value: WideString;
begin
  Value := '';
  if Assigned(Column.Field) then
    Value := GetWideDisplayText(Column.Field);
  WriteText(Canvas, Rect, 2, 2, Value, Column.Alignment,
    UseRightToLeftAlignmentForField(Column.Field, Column.Alignment));
end;

procedure TTntCustomDBGrid.DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
var
  FrameOffs: Byte;

  procedure DrawTitleCell(ACol, ARow: Integer; Column: TTntColumn; var AState: TGridDrawState);
  const
    ScrollArrows: array [Boolean, Boolean] of Integer =
      ((DFCS_SCROLLRIGHT, DFCS_SCROLLLEFT), (DFCS_SCROLLLEFT, DFCS_SCROLLRIGHT));
  var
    MasterCol: TColumn{TNT-ALLOW TColumn};
    TitleRect, TxtRect, ButtonRect: TRect;
    I: Integer;
    InBiDiMode: Boolean;
  begin
    TitleRect := CalcTitleRect(Column, ARow, MasterCol);

    if MasterCol = nil then
    begin
      Canvas.FillRect(ARect);
      Exit;
    end;

    Canvas.Font := MasterCol.Title.Font;
    Canvas.Brush.Color := MasterCol.Title.Color;
    if [dgRowLines, dgColLines] * Options = [dgRowLines, dgColLines] then
      InflateRect(TitleRect, -1, -1);
    TxtRect := TitleRect;
    I := GetSystemMetrics(SM_CXHSCROLL);
    if ((TxtRect.Right - TxtRect.Left) > I) and MasterCol.Expandable then
    begin
      Dec(TxtRect.Right, I);
      ButtonRect := TitleRect;
      ButtonRect.Left := TxtRect.Right;
      I := SaveDC(Canvas.Handle);
      try
        Canvas.FillRect(ButtonRect);
        InflateRect(ButtonRect, -1, -1);
        IntersectClipRect(Canvas.Handle, ButtonRect.Left,
          ButtonRect.Top, ButtonRect.Right, ButtonRect.Bottom);
        InflateRect(ButtonRect, 1, 1);
        { DrawFrameControl doesn't draw properly when orienatation has changed.
          It draws as ExtTextOutW does. }
        InBiDiMode := Canvas.CanvasOrientation = coRightToLeft;
        if InBiDiMode then { stretch the arrows box }
          Inc(ButtonRect.Right, GetSystemMetrics(SM_CXHSCROLL) + 4);
        DrawFrameControl(Canvas.Handle, ButtonRect, DFC_SCROLL,
          ScrollArrows[InBiDiMode, MasterCol.Expanded] or DFCS_FLAT);
      finally
        RestoreDC(Canvas.Handle, I);
      end;
    end;
    with (MasterCol.Title as TTntColumnTitle) do
      WriteText(Canvas, TxtRect, FrameOffs, FrameOffs, Caption, Alignment, IsRightToLeft);
    if [dgRowLines, dgColLines] * Options = [dgRowLines, dgColLines] then
    begin
      InflateRect(TitleRect, 1, 1);
      DrawEdge(Canvas.Handle, TitleRect, BDR_RAISEDINNER, BF_BOTTOMRIGHT);
      DrawEdge(Canvas.Handle, TitleRect, BDR_RAISEDINNER, BF_TOPLEFT);
    end;
    AState := AState - [gdFixed];  // prevent box drawing later
  end;

var
  OldActive: Integer;
  Highlight: Boolean;
  Value: WideString;
  DrawColumn: TTntColumn;
begin
  if csLoading in ComponentState then
  begin
    Canvas.Brush.Color := Color;
    Canvas.FillRect(ARect);
    Exit;
  end;

  if (gdFixed in AState) and (RawToDataColumn(ACol) < 0) then
  begin
    inherited;
    exit;
  end;

  Dec(ARow, FixedRows);
  ACol := RawToDataColumn(ACol);

  if (gdFixed in AState) and ([dgRowLines, dgColLines] * Options =
    [dgRowLines, dgColLines]) then
  begin
    InflateRect(ARect, -1, -1);
    FrameOffs := 1;
  end
  else
    FrameOffs := 2;

  with Canvas do
  begin
    DrawColumn := Columns[ACol] as TTntColumn;
    if not DrawColumn.Showing then Exit;
    if not (gdFixed in AState) then
    begin
      Font := DrawColumn.Font;
      Brush.Color := DrawColumn.Color;
    end;
    if ARow < 0 then
      DrawTitleCell(ACol, ARow + FixedRows, DrawColumn, AState)
    else if (DataLink = nil) or not DataLink.Active then
      FillRect(ARect)
    else
    begin
      Value := '';
      OldActive := DataLink.ActiveRecord;
      try
        DataLink.ActiveRecord := ARow;
        if Assigned(DrawColumn.Field) then
          Value := GetWideDisplayText(DrawColumn.Field);
        Highlight := HighlightCell(ACol, ARow, Value, AState);
        if Highlight then
        begin
          Brush.Color := clHighlight;
          Font.Color := clHighlightText;
        end;
        if not Enabled then
          Font.Color := clGrayText;
        if DefaultDrawing then
          DefaultDrawColumnCell(ARect, ACol, DrawColumn, AState);
        if Columns.State = csDefault then
          DrawDataCell(ARect, DrawColumn.Field, AState);
        DrawColumnCell(ARect, ACol, DrawColumn, AState);
      finally
        DataLink.ActiveRecord := OldActive;
      end;
      if DefaultDrawing and (gdSelected in AState)
        and ((dgAlwaysShowSelection in Options) or Focused)
        and not (csDesigning in ComponentState)
        and not (dgRowSelect in Options)
        and (UpdateLock = 0)
        and (ValidParentForm(Self).ActiveControl = Self) then
        Windows.DrawFocusRect(Handle, ARect);
    end;
  end;
  if (gdFixed in AState) and ([dgRowLines, dgColLines] * Options =
    [dgRowLines, dgColLines]) then
  begin
    InflateRect(ARect, 1, 1);
    DrawEdge(Canvas.Handle, ARect, BDR_RAISEDINNER, BF_BOTTOMRIGHT);
    DrawEdge(Canvas.Handle, ARect, BDR_RAISEDINNER, BF_TOPLEFT);
  end;
end;

procedure TTntCustomDBGrid.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  TntControl_BeforeInherited_ActionChange(Self, Sender, CheckDefaults);
  inherited;
end;

function TTntCustomDBGrid.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TntControl_GetActionLinkClass(Self, inherited GetActionLinkClass);
end;

constructor TTntCustomDBGrid.Create(AOwner: TComponent);
begin
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    FDBMaskEdit := TTntDBGridMaskEdit.Create(Self);
    FDBMaskEdit.Parent := Self;
    FDBMaskEdit.Enabled := False;
    FDBMaskEdit.Visible := False;
    FDBMaskEdit.Borderstyle := bsNone;
  end;
end;

destructor TTntCustomDBGrid.Destroy;
begin
  if not (csDesigning in ComponentState) then
    FDBMaskEdit.Free;

  inherited;
end;

procedure TTntCustomDBGrid.HideEditControl(ACol, ARow: Integer);
var
  ws: WideString;
begin
  ws := FDBMaskEdit.Text;
  SetEditText(ACol, ARow, ws);
  //Cells[ACol,ARow] := ws;
  FDBMaskEdit.Enabled := False;
  FDBMaskEdit.Visible := False;
end;

procedure TTntCustomDBGrid.HideInplaceEdit;
begin
  HideEditControl(Col, Row);
end;

procedure TTntCustomDBGrid.ShowEditControl(ACol, ARow: Integer);
var
  R: TRect;
  //ws: WideString;
  XYOffset: TPoint;
  CellWidth, CellHeight: Integer;
  EditColor: TColor;
begin
  R := CellRect(ACol, ARow);
  XYOffset := Point(0, 0);
  CellWidth := R.Right - R.Left - 1;
  CellHeight := R.Bottom - R.Top - 1;
  EditColor := Canvas.Brush.Color;

  FDBMaskEdit.ReCreate;
  FDBMaskEdit.Top := r.Top + 1 + XYOffset.Y;
  FDBMaskEdit.Left := r.Left + 1 + XYOffset.X;
  FDBMaskEdit.Width := CellWidth - 1 - XYOffset.X * 2;
  FDBMaskEdit.Height := CellHeight - 1 - XYOffset.Y * 2;
  FDBMaskEdit.Visible := True;
  FDBMaskEdit.Enabled := True;
  FDBMaskEdit.Color := EditColor;
  FDBMaskEdit.Font.Assign(Font);
  FDBMaskEdit.UpdateContents;

  //ws := Cells[ACol, ARow];
  //FDBMaskEdit.Text := ws;

  FDBMaskEdit.SetFocus;
end;

procedure TTntCustomDBGrid.WMLButtonDown(var Message: TMessage);
begin
  inherited;
  if (FDBMaskEdit <> nil) {and Assigned(OnGetEditMask)} then FDBMaskEdit.FClickTime := GetMessageTime;
end;

function TTntCustomDBGrid.CanEditShow: Boolean;
var
  aField: TField;
begin
  Result := inherited CanEditshow;

  if (csDesigning in ComponentState) or (csLoading in ComponentState) then
    Exit;

  aField := SelectedField;
  if not Assigned(aField) or (aField.EditMask = '') then
    Exit;

  if Result then
  begin
    ShowEditControl(Col,Row);
    Result := False;
  end;
end;

procedure TTntCustomDBGrid.UpdateData;
var
  Field: TField;
begin
  Field := SelectedField;
  if (csDesigning in ComponentState) or (csLoading in ComponentState) or not Assigned(Field) or (Field.EditMask = '') then
    Exit;

  if Assigned(Field) then
    Field.Text := FEditText;
end;

function TTntCustomDBGrid.CanEditModify: Boolean;
var
  Field: TField;
begin
  Result := inherited CanEditModify;

  if Result then TTntGridDataLink(Datalink).ModifiedEx;

  Field := SelectedField;

  if not (csDesigning in ComponentState) and Assigned(Field) and (Field.EditMask <> '') then
  begin
  end;

end;

function TTntCustomDBGrid.IsMaskedEdit: Boolean;
var
  Field: TField;
begin
  Field := SelectedField;
  Result := not (csDesigning in ComponentState) and Assigned(Field) and (Field.EditMask <> '');
end;

function TTntCustomDBGrid.IsMaskedEdit(ACol, ARow: Integer): Boolean;
var
  Field: TField;
begin
  Result := False;

  if (ACol >= 0) and (ACol < ColCount) then
  begin
    Field := Columns[ACol].Field;
    Result := not (csDesigning in ComponentState) and Assigned(Field) and (Field.EditMask <> '');
  end;
end;

procedure TTntCustomDBGrid.WMCommand(var Message: TWMCommand);
begin
  inherited;
end;

initialization
  DrawBitmap := TBitmap.Create;

finalization
  DrawBitmap.Free;

{$ENDIF}

end.
