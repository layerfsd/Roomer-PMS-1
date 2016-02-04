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

unit TntDBCtrls;

{$INCLUDE TntCompilers.inc}

{$IFDEF DELPHI_UNICODE}

interface

uses
  DBCtrls;

type
  TTntDBEdit = class(TDBEdit);
  TTntDBText = class(TDBText);
  TTntCustomDBComboBox = class(TDBComboBox);
  TTntDBComboBox = class(TDBComboBox);
  TTntDBCheckBox = class(TDBCheckBox);
  TTntDBRichEdit = class(TDBRichEdit);
  TTntDBMemo = class(TDBMemo);
  TTntDBRadioGroup = class(TDBRadioGroup);
  TTntDBLookupListBox = class(TDBLookupListBox);
  TTntDBLookupComboBox = class(TDBLookupComboBox);

implementation

{$ENDIF}

{$IFNDEF DELPHI_UNICODE}

interface

uses
  Classes, Windows, Messages, DB, DBCtrls, Controls, StdCtrls, Forms,
  TntClasses, TntStdCtrls, TntControls, TntComCtrls, TntExtCtrls, MaskUtils
  {$IFDEF DELPHI_7_UP}
  , Themes
  {$ENDIF}
  {$IFDEF DELPHI_9_UP}
  , Types
  {$ENDIF}
  ;

type
{TNT-WARN TPaintControl}
  TTntPaintControl = class
  private
    FOwner: TWinControl;
    FClassName: WideString;
    FHandle: HWnd;
    FObjectInstance: Pointer;
    FDefWindowProc: Pointer;
    FCtl3dButton: Boolean;
    function GetHandle: HWnd;
    procedure SetCtl3DButton(Value: Boolean);
    procedure WndProc(var Message: TMessage);
  public
    constructor Create(AOwner: TWinControl; const ClassName: WideString);
    destructor Destroy; override;
    procedure DestroyHandle;
    property Ctl3DButton: Boolean read FCtl3dButton write SetCtl3dButton;
    property Handle: HWnd read GetHandle;
  end;

type
{TNT-WARN TDBEdit}
  TTntDBEdit = class(TDBEdit{TNT-ALLOW TDBEdit})
  private
    InheritedDataChange: TNotifyEvent;
    FPasswordChar: WideChar;
    procedure DataChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    function IsHintStored: Boolean;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    function GetTextMargins: TPoint;
    function GetPasswordChar: WideChar;
    procedure SetPasswordChar(const Value: WideChar);
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
  private
    function GetSelStart: Integer; reintroduce; virtual;
    procedure SetSelStart(const Value: Integer); reintroduce; virtual;
    function GetSelLength: Integer; reintroduce; virtual;
    procedure SetSelLength(const Value: Integer); reintroduce; virtual;
    function GetSelText: WideString; reintroduce;
    procedure SetSelText(const Value: WideString);
    function GetText: WideString;
    procedure SetText(const Value: WideString);
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DefineProperties(Filer: TFiler); override;
    function GetActionLinkClass: TControlActionLinkClass; override;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    property SelText: WideString read GetSelText write SetSelText;
    property SelStart: Integer read GetSelStart write SetSelStart;
    property SelLength: Integer read GetSelLength write SetSelLength;
    property Text: WideString read GetText write SetText;
  published
    property Hint: WideString read GetHint write SetHint stored IsHintStored;
    property PasswordChar: WideChar read GetPasswordChar write SetPasswordChar default #0;
  end;

  TTntDBMaskEdit = class(TTntMaskEdit)
  private
    FDataLink: TFieldDataLink;
    FAlignment: TAlignment;
    FFocused: Boolean;
    FinternalEditMaskChange: Boolean;
    FIsFieldEditMask: Boolean;
    procedure ActiveChange(Sender: TObject);
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure ResetMaxLength;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetFocused(Value: Boolean);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMUndo(var Message: TMessage); message WM_UNDO;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure Change; override;
    function EditCanModify: Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure Reset; override;
    procedure SetEditMask(const Value: TEditMask); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
  end;

{TNT-WARN TDBText}
  TTntDBText = class(TDBText{TNT-ALLOW TDBText})
  private
    FDataLink: TFieldDataLink;
    InheritedDataChange: TNotifyEvent;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    function IsHintStored: Boolean;
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    function GetCaption: TWideCaption;
    function IsCaptionStored: Boolean;
    procedure SetCaption(const Value: TWideCaption);
    function GetFieldText: WideString;
    procedure DataChange(Sender: TObject);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    function GetLabelText: WideString; reintroduce; virtual;
    function GetActionLinkClass: TControlActionLinkClass; override;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    procedure DoDrawText(var Rect: TRect; Flags: Longint); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Caption: TWideCaption read GetCaption write SetCaption stored IsCaptionStored;
  published
    property Hint: WideString read GetHint write SetHint stored IsHintStored;
  end;

{TNT-WARN TDBComboBox}
  TTntCustomDBComboBox = class(TDBComboBox{TNT-ALLOW TDBComboBox},
    IWideCustomListControl)
  private
    FDataLink: TFieldDataLink;
    FFilter: WideString;
    FLastTime: Cardinal;
    procedure UpdateData(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure SetReadOnly;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    function IsHintStored: Boolean;
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
  private
    FItems: TTntStrings;
    FSaveItems: TTntStrings;
    FSaveItemIndex: integer;
    function GetItems: TTntStrings;
    procedure SetItems(const Value: TTntStrings); reintroduce;
    function GetSelStart: Integer;
    procedure SetSelStart(const Value: Integer);
    function GetSelLength: Integer;
    procedure SetSelLength(const Value: Integer);
    function GetSelText: WideString;
    procedure SetSelText(const Value: WideString);
    function GetText: WideString;
    procedure SetText(const Value: WideString);

    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
  protected
    procedure DataChange(Sender: TObject);
    function GetAutoComplete_UniqueMatchOnly: Boolean; dynamic;
    function GetAutoComplete_PreserveDataEntryCase: Boolean; dynamic;
    procedure DoEditCharMsg(var Message: TWMChar); virtual;
    function GetFieldValue: Variant; virtual;
    procedure SetFieldValue(const Value: Variant); virtual;
    function GetComboValue: Variant; virtual; abstract;
    procedure SetComboValue(const Value: Variant); virtual; abstract;
    {$IFDEF DELPHI_7} // fix for Delphi 7 only
    function GetItemsClass: TCustomComboBoxStringsClass; override;
    {$ENDIF}
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure DefineProperties(Filer: TFiler); override;
    function GetActionLinkClass: TControlActionLinkClass; override;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure WndProc(var Message: TMessage); override;
    procedure ComboWndProc(var Message: TMessage; ComboWnd: HWnd; ComboProc: Pointer); override;
    procedure KeyPress(var Key: AnsiChar); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CopySelection(Destination: TCustomListControl); override;
    procedure AddItem(const Item: WideString; AObject: TObject); reintroduce; virtual;
  public
    property SelText: WideString read GetSelText write SetSelText;
    property SelStart: Integer read GetSelStart write SetSelStart;
    property SelLength: Integer read GetSelLength write SetSelLength;
    property Text: WideString read GetText write SetText;
  published
    property Hint: WideString read GetHint write SetHint stored IsHintStored;
    property Items: TTntStrings read GetItems write SetItems;
  end;

  TTntDBComboBox = class(TTntCustomDBComboBox)
  protected
    function GetFieldValue: Variant; override;
    procedure SetFieldValue(const Value: Variant); override;
    function GetComboValue: Variant; override;
    procedure SetComboValue(const Value: Variant); override;
  end;

type
{TNT-WARN TDBCheckBox}
  TTntDBCheckBox = class(TDBCheckBox{TNT-ALLOW TDBCheckBox})
  private
    function GetCaption: TWideCaption;
    procedure SetCaption(const Value: TWideCaption);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    function IsCaptionStored: Boolean;
    function IsHintStored: Boolean;
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure DefineProperties(Filer: TFiler); override;
    function GetActionLinkClass: TControlActionLinkClass; override;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    procedure Toggle; override;
  published
    property Caption: TWideCaption read GetCaption write SetCaption stored IsCaptionStored;
    property Hint: WideString read GetHint write SetHint stored IsHintStored;
  end;

{TNT-WARN TDBRichEdit}
  TTntDBRichEdit = class(TTntCustomRichEdit)
  private
    FDataLink: TFieldDataLink;
    FAutoDisplay: Boolean;
    FFocused: Boolean;
    FMemoLoaded: Boolean;
    FDataSave: AnsiString;
    procedure BeginEditing;
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetDataField: WideString;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: WideString);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure SetAutoDisplay(Value: Boolean);
    procedure SetFocused(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
  protected
    procedure InternalLoadMemo; dynamic;
    procedure InternalSaveMemo; dynamic;
  protected
    procedure Change; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: AnsiChar); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    procedure LoadMemo; virtual;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoDisplay: Boolean read FAutoDisplay write SetAutoDisplay default True;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Constraints;
    property Ctl3D;
    property DataField: WideString read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property HideScrollBars;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PlainText;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ScrollBars;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property WantReturns;
    property WantTabs;
    property WordWrap;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
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
    property OnResizeRequest;
    property OnSelectionChange;
    property OnProtectChange;
    property OnSaveClipboard;
    property OnStartDock;
    property OnStartDrag;
  end;

type
{TNT-WARN TDBMemo}
  TTntDBMemo = class(TTntCustomMemo)
  private
    FDataLink: TFieldDataLink;
    FAutoDisplay: Boolean;
    FFocused: Boolean;
    FMemoLoaded: Boolean;
    FPaintControl: TTntPaintControl;
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetDataField: WideString;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: WideString);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure SetAutoDisplay(Value: Boolean);
    procedure SetFocused(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMUndo(var Message: TMessage); message WM_UNDO;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure Change; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char{TNT-ALLOW Char}); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    procedure LoadMemo; virtual;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoDisplay: Boolean read FAutoDisplay write SetAutoDisplay default True;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Constraints;
    property Ctl3D;
    property DataField: WideString read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;    
    property ImeMode;
    property ImeName;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ScrollBars;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property WantReturns;
    property WantTabs;
    property WordWrap;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
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
    property OnStartDock;
    property OnStartDrag;
  end;

{ TDBRadioGroup }
type
  TTntDBRadioGroup = class(TTntCustomRadioGroup)
  private
    FDataLink: TFieldDataLink;
    FValue: WideString;
    FValues: TTntStrings;
    FInSetValue: Boolean;
    FOnChange: TNotifyEvent;
    procedure DataChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    function GetDataField: WideString;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    function GetButtonValue(Index: Integer): WideString;
    procedure SetDataField(const Value: WideString);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure SetValue(const Value: WideString);
    procedure SetItems(Value: TTntStrings);
    procedure SetValues(Value: TTntStrings);
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure Change; dynamic;
    procedure Click; override;
    procedure KeyPress(var Key: Char{TNT-ALLOW Char}); override;
    function CanModify: Boolean; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    property DataLink: TFieldDataLink read FDataLink;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
    property ItemIndex;
    property Value: WideString read FValue write SetValue;
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Color;
    property Columns;
    property Constraints;
    property Ctl3D;
    property DataField: WideString read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property Items write SetItems;
    {$IFDEF COMPILER_7_UP}
    property ParentBackground;
    {$ENDIF}
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Values: TTntStrings read FValues write SetValues;
    property Visible;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    {$IFDEF COMPILER_10_UP}
    property OnMouseEnter;
    property OnMouseLeave;
    {$ENDIF}
    property OnStartDock;
    property OnStartDrag;
  end;

  (*TTntDBLookupComboBox = class(TDBLookupComboBox)
  private
    //FDataLink: TFieldDataLink;
    FAlignment: TAlignment;
    FButtonWidth: Integer;
    FMouseInControl: Boolean;
    FPressed: Boolean;
    FTracking: Boolean;
    function GetText: WideString;
    procedure SetText(const Value: WideString);
    function GetHint: WideString;
    function IsHintStored: Boolean;
    procedure SetHint(const Value: WideString);
    procedure StopTracking;
    procedure TrackButton(X, Y: Integer);
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure DefineProperties(Filer: TFiler); override;
    function GetActionLinkClass: TControlActionLinkClass; override;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    function IsLookupMode: Boolean;
    function GetListField: TField;
    procedure KeyValueChanged; override;
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Text: WideString read GetText{ write SetText};
  published
    property Hint: WideString read GetHint write SetHint stored IsHintStored;
  end;*)

{ TTntDBLookupControl }

  TTntDBLookupControl = class;

  TDataSourceLink = class(TDataLink)
  private
    FDBLookupControl: TTntDBLookupControl;
  protected
    procedure FocusControl(Field: TFieldRef); override;
    procedure ActiveChanged; override;
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
  public
    constructor Create;
  end;

  TListSourceLink = class(TDataLink)
  private
    FDBLookupControl: TTntDBLookupControl;
  protected
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
    procedure LayoutChanged; override;
  public
    constructor Create;
  end;

  TTntDBLookupControl = class(TCustomControl)
  private
    FLookupSource: TDataSource;
    FDataLink: TDataSourceLink;
    FListLink: TListSourceLink;
    FDataFieldName: string;
    FKeyFieldName: string;
    FListFieldName: string;
    FListFieldIndex: Integer;
    FDataField: TField;
    FMasterField: TField;
    FKeyField: TField;
    FListField: TField;
    FListFields: TList;
    FKeyValue: Variant;
    FSearchText: string;
    FLookupMode: Boolean;
    FListActive: Boolean;
    FHasFocus: Boolean;
    FNullValueKey: TShortCut;
    procedure CheckNotCircular;
    procedure CheckNotLookup;
    procedure DataLinkRecordChanged(Field: TField);
    function GetDataSource: TDataSource;
    function GetKeyFieldName: string;
    function GetListSource: TDataSource;
    function GetReadOnly: Boolean;
    procedure SetDataFieldName(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetKeyFieldName(const Value: string);
    procedure SetKeyValue(const Value: Variant);
    procedure SetListFieldName(const Value: string);
    procedure SetListSource(Value: TDataSource);
    procedure SetLookupMode(Value: Boolean);
    procedure SetReadOnly(Value: Boolean);
    procedure WMGetDlgCode(var Message: TMessage); message WM_GETDLGCODE;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;    
    procedure WMKillFocus(var Message: TMessage); message WM_KILLFOCUS;
    procedure WMSetFocus(var Message: TMessage); message WM_SETFOCUS;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    function CanModify: Boolean; virtual;
    function GetBorderSize: Integer; virtual;
    function GetTextHeight: Integer; virtual;
    procedure KeyValueChanged; virtual;
    procedure ListLinkDataChanged; virtual;
    function LocateKey: Boolean; virtual;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure ProcessSearchKey(Key: Char); virtual;
    procedure SelectKeyValue(const Value: Variant); virtual;
    procedure UpdateDataFields; virtual;
    procedure UpdateListFields; virtual;
    property DataField: string read FDataFieldName write SetDataFieldName;
    property DataLink: TDataSourceLink read FDataLink;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property HasFocus: Boolean read FHasFocus;
    property KeyField: string read GetKeyFieldName write SetKeyFieldName;
    property KeyValue: Variant read FKeyValue write SetKeyValue;
    property ListActive: Boolean read FListActive;
    property ListField: string read FListFieldName write SetListFieldName;
    property ListFieldIndex: Integer read FListFieldIndex write FListFieldIndex default 0;
    property ListFields: TList read FListFields;
    property ListLink: TListSourceLink read FListLink;
    property ListSource: TDataSource read GetListSource write SetListSource;
    property NullValueKey: TShortCut read FNullValueKey write FNullValueKey default 0;    
    property ParentColor default False;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property SearchText: string read FSearchText write FSearchText;
    property TabStop default True;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    property Field: TField read FDataField;
  end;

{ TTntDBLookupListBox }

  TTntDBLookupListBox = class(TTntDBLookupControl)
  private
    FRecordIndex: Integer;
    FRecordCount: Integer;
    FRowCount: Integer;
    FBorderStyle: TBorderStyle;
    FPopup: Boolean;
    FKeySelected: Boolean;
    FTracking: Boolean;
    FTimerActive: Boolean;
    FLockPosition: Boolean;
    FMousePos: Integer;
    FSelectedItem: WideString;
    function GetKeyIndex: Integer;
    procedure SelectCurrent;
    procedure SelectItemAt(X, Y: Integer);
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetRowCount(Value: Integer);
    procedure StopTimer;
    procedure StopTracking;
    procedure TimerScroll;
    procedure UpdateScrollBar;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure WMCancelMode(var Message: TMessage); message WM_CANCELMODE;
    procedure WMTimer(var Message: TMessage); message WM_TIMER;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    function GetHint: WideString;
    function IsHintStored: Boolean;
    procedure SetHint(const Value: WideString);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure DefineProperties(Filer: TFiler); override;
    function GetActionLinkClass: TControlActionLinkClass; override;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyValueChanged; override;
    procedure ListLinkDataChanged; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Paint; override;
    procedure UpdateListFields; override;
  public
    constructor Create(AOwner: TComponent); override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property KeyValue;
    property SelectedItem: WideString read FSelectedItem;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
  published
    property Align;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property Color;
    property Constraints;
    property Ctl3D;
    property DataField;
    property DataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property Hint: WideString read GetHint write SetHint stored IsHintStored;
    property ImeMode;
    property ImeName;
    property KeyField;
    property ListField;
    property ListFieldIndex;
    property ListSource;
    property NullValueKey;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property RowCount: Integer read FRowCount write SetRowCount stored False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

{ TTntDBLookupComboBox }

  TTntPopupDataList = class(TTntDBLookupListBox)
  private
    procedure WMMouseActivate(var Message: TMessage); message WM_MOUSEACTIVATE;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TDropDownAlign = (daLeft, daRight, daCenter);

  TTntDBLookupComboBox = class(TTntDBLookupControl)
  private
    FDataList: TTntPopupDataList;
    FButtonWidth: Integer;
    FText: WideString;
    FDropDownRows: Integer;
    FDropDownWidth: Integer;
    FDropDownAlign: TDropDownAlign;
    FListVisible: Boolean;
    FPressed: Boolean;
    FTracking: Boolean;
    FAlignment: TAlignment;
    FLookupMode: Boolean;
    {$IFDEF DELPHI_7_UP}
    FMouseInControl: Boolean;
    {$ENDIF}
    FOnDropDown: TNotifyEvent;
    FOnCloseUp: TNotifyEvent;
    procedure ListMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StopTracking;
    procedure TrackButton(X, Y: Integer);
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure WMCancelMode(var Message: TMessage); message WM_CANCELMODE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure CMBiDiModeChanged(var Message: TMessage); message CM_BIDIMODECHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    function IsHintStored: Boolean;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DefineProperties(Filer: TFiler); override;
    function GetActionLinkClass: TControlActionLinkClass; override;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    procedure Paint; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyValueChanged; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure UpdateListFields; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure CloseUp(Accept: Boolean); virtual;
    procedure DropDown; virtual;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property KeyValue;
    property ListVisible: Boolean read FListVisible;
    property Text: WideString read FText;
  published
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BiDiMode;
    property Color;
    property Constraints;
    property Ctl3D;
    property DataField;
    property DataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DropDownAlign: TDropDownAlign read FDropDownAlign write FDropDownAlign default daLeft;
    property DropDownRows: Integer read FDropDownRows write FDropDownRows default 7;
    property DropDownWidth: Integer read FDropDownWidth write FDropDownWidth default 0;
    property Enabled;
    property Font;
    property Hint: WideString read GetHint write SetHint stored IsHintStored;
    property ImeMode;
    property ImeName;
    property KeyField;
    property ListField;
    property ListFieldIndex;
    property ListSource;
    property NullValueKey;    
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
    property Visible;
    property OnClick;
    property OnCloseUp: TNotifyEvent read FOnCloseUp write FOnCloseUp;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

uses
  SysUtils, Graphics, Variants, TntDB, DBConsts, VDBConsts, Menus,
  TntActnList, TntGraphics, TntSysUtils, RichEdit, Mask;

function FieldIsBlobLike(Field: TField): Boolean;
begin
  Result := False;
  if Assigned(Field) then begin
    if (Field.IsBlob)
    or (Field.DataType in [Low(TBlobType).. High(TBlobType)]) then
      Result := True
    else if (Field is TWideStringField{TNT-ALLOW TWideStringField})
    and (Field.Size = MaxInt) then
      Result := True; { wide string field filling in for a blob field }
  end;
end;

function VarEquals(const V1, V2: Variant): Boolean;
begin
  Result := False;
  try
    Result := V1 = V2;
  except
  end;
end;

{ TTntPaintControl }

type
  TAccessWinControl = class(TWinControl);

constructor TTntPaintControl.Create(AOwner: TWinControl; const ClassName: WideString);
begin
  FOwner := AOwner;
  FClassName := ClassName;
end;

destructor TTntPaintControl.Destroy;
begin
  DestroyHandle;
end;

procedure TTntPaintControl.DestroyHandle;
begin
  if FHandle <> 0 then DestroyWindow(FHandle);
  Classes.FreeObjectInstance(FObjectInstance);
  FHandle := 0;
  FObjectInstance := nil;
end;

function TTntPaintControl.GetHandle: HWnd;
var
  Params: TCreateParams;
begin
  if FHandle = 0 then
  begin
    FObjectInstance := Classes.MakeObjectInstance(WndProc);
    TAccessWinControl(FOwner).CreateParams(Params);
    Params.Style := Params.Style and not (WS_HSCROLL or WS_VSCROLL);
    if (not Win32PlatformIsUnicode) then begin
      with Params do
        FHandle := CreateWindowEx(ExStyle, PAnsiChar(AnsiString(FClassName)),
          PAnsiChar(TAccessWinControl(FOwner).Text), Style or WS_VISIBLE,
          X, Y, Width, Height, Application.Handle, 0, HInstance, nil);
      FDefWindowProc := Pointer(GetWindowLong(FHandle, GWL_WNDPROC));
      SetWindowLong(FHandle, GWL_WNDPROC, Integer(FObjectInstance));
    end else begin
      with Params do
        FHandle := CreateWindowExW(ExStyle, PWideChar(FClassName),
          PWideChar(TntControl_GetText(FOwner)), Style or WS_VISIBLE,
          X, Y, Width, Height, Application.Handle, 0, HInstance, nil);
      FDefWindowProc := Pointer(GetWindowLongW(FHandle, GWL_WNDPROC));
      SetWindowLongW(FHandle, GWL_WNDPROC, Integer(FObjectInstance));
    end;
    SendMessage(FHandle, WM_SETFONT, Integer(TAccessWinControl(FOwner).Font.Handle), 1);
  end;
  Result := FHandle;
end;

procedure TTntPaintControl.SetCtl3DButton(Value: Boolean);
begin
  if FHandle <> 0 then DestroyHandle;
  FCtl3DButton := Value;
end;

procedure TTntPaintControl.WndProc(var Message: TMessage);
begin
  with Message do
    if (Msg >= CN_CTLCOLORMSGBOX) and (Msg <= CN_CTLCOLORSTATIC) then
      Result := FOwner.Perform(Msg, WParam, LParam)
    else if (not Win32PlatformIsUnicode) then
      Result := CallWindowProcA(FDefWindowProc, FHandle, Msg, WParam, LParam)
    else
      Result := CallWindowProcW(FDefWindowProc, FHandle, Msg, WParam, LParam);
end;

{ THackFieldDataLink }
type
  THackFieldDataLink_D6_D7_D9 = class(TDataLink)
  protected
    FxxxField: TField;
    FxxxFieldName: string{TNT-ALLOW string};
    FxxxControl: TComponent;
    FxxxEditing: Boolean;
    FModified: Boolean;
  end;

{$IFDEF COMPILER_6}  // verified against VCL source in Delphi 6 and BCB 6
  THackFieldDataLink = THackFieldDataLink_D6_D7_D9;
{$ENDIF}
{$IFDEF DELPHI_7}    // verified against VCL source in Delphi 7
  THackFieldDataLink = THackFieldDataLink_D6_D7_D9;
{$ENDIF}
{$IFDEF DELPHI_9}    // verified against VCL source in Delphi 9
  THackFieldDataLink = THackFieldDataLink_D6_D7_D9;
{$ENDIF}
{$IFDEF DELPHI_10}    // verified against VCL source in Delphi 10
  THackFieldDataLink = class(TDataLink)
  protected
    FxxxField: TField;
    FxxxFieldName: WideString;
    FxxxControl: TComponent;
    FxxxEditing: Boolean;
    FModified: Boolean;
  end;
{$ENDIF}

{ TTntDBEdit }

type
  THackDBEdit_D6_D7_D9 = class(TCustomMaskEdit)
  protected
    FDataLink: TFieldDataLink;
    FCanvas: TControlCanvas;
    FAlignment: TAlignment;
    FFocused: Boolean;
  end;

{$IFDEF COMPILER_6}   // verified against VCL source in Delphi 6 and BCB 6
  THackDBEdit = THackDBEdit_D6_D7_D9;
{$ENDIF}
{$IFDEF DELPHI_7}     // verified against VCL source in Delphi 7
  THackDBEdit = THackDBEdit_D6_D7_D9;
{$ENDIF}
{$IFDEF DELPHI_9}     // verified against VCL source in Delphi 9
  THackDBEdit = THackDBEdit_D6_D7_D9;
{$ENDIF}
{$IFDEF DELPHI_10}     // verified against VCL source in Delphi 10
  THackDBEdit = THackDBEdit_D6_D7_D9;
{$ENDIF}

constructor TTntDBEdit.Create(AOwner: TComponent);
begin
  inherited;
  InheritedDataChange := THackDBEdit(Self).FDataLink.OnDataChange;
  THackDBEdit(Self).FDataLink.OnDataChange := DataChange;
  THackDBEdit(Self).FDataLink.OnUpdateData := UpdateData;
end;

procedure TTntDBEdit.CreateWindowHandle(const Params: TCreateParams);
begin
  CreateUnicodeHandle(Self, Params, 'EDIT');
end;

procedure TTntDBEdit.CreateWnd;
begin
  inherited;
  TntCustomEdit_AfterInherited_CreateWnd(Self, FPasswordChar);
end;

procedure TTntDBEdit.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntDBEdit.GetSelStart: Integer;
begin
  Result := TntCustomEdit_GetSelStart(Self);
end;

procedure TTntDBEdit.SetSelStart(const Value: Integer);
begin
  TntCustomEdit_SetSelStart(Self, Value);
end;

function TTntDBEdit.GetSelLength: Integer;
begin
  Result := TntCustomEdit_GetSelLength(Self);
end;

procedure TTntDBEdit.SetSelLength(const Value: Integer);
begin
  TntCustomEdit_SetSelLength(Self, Value);
end;

function TTntDBEdit.GetSelText: WideString;
begin
  Result := TntCustomEdit_GetSelText(Self);
end;

procedure TTntDBEdit.SetSelText(const Value: WideString);
begin
  TntCustomEdit_SetSelText(Self, Value);
end;

function TTntDBEdit.GetPasswordChar: WideChar;
begin
  Result := TntCustomEdit_GetPasswordChar(Self, FPasswordChar)
end;

procedure TTntDBEdit.SetPasswordChar(const Value: WideChar);
begin
  TntCustomEdit_SetPasswordChar(Self, FPasswordChar, Value);
end;

function TTntDBEdit.GetText: WideString;
begin
  Result := TntControl_GetText(Self);
end;

procedure TTntDBEdit.SetText(const Value: WideString);
begin
  TntControl_SetText(Self, Value);
end;

procedure TTntDBEdit.DataChange(Sender: TObject);
begin
  with THackDBEdit(Self), Self do begin
    if Field = nil then
      InheritedDataChange(Sender)
    else begin
      if FAlignment <> Field.Alignment then
      begin
        EditText := '';  {forces update}
        FAlignment := Field.Alignment;
      end;
      EditMask := Field.EditMask;
      if not (csDesigning in ComponentState) then
      begin
        if (Field.DataType in [ftString, ftWideString]) and (MaxLength = 0) then
          MaxLength := Field.Size;
      end;
      if FFocused and FDataLink.CanModify then
        Text := GetWideText(Field)
      else
      begin
        Text := GetWideDisplayText(Field);
        if FDataLink.Editing and THackFieldDataLink(FDataLink).FModified then
          Modified := True;
      end;
    end;
  end;
end;

procedure TTntDBEdit.UpdateData(Sender: TObject);
begin
  ValidateEdit;
  SetWideText(Field, Text);
end;

procedure TTntDBEdit.CMEnter(var Message: TCMEnter);
var
  SaveFarEast: Boolean;
begin
  SaveFarEast := SysLocale.FarEast;
  try
    SysLocale.FarEast := False;
    inherited; // inherited tries to work around Win95 FarEast bug, but introduces others
  finally
    SysLocale.FarEast := SaveFarEast;
  end;
end;

function TTntDBEdit.IsHintStored: Boolean;
begin
  Result := TntControl_IsHintStored(Self);
end;

function TTntDBEdit.GetHint: WideString;
begin
  Result := TntControl_GetHint(Self)
end;

procedure TTntDBEdit.SetHint(const Value: WideString);
begin
  TntControl_SetHint(Self, Value);
end;

procedure TTntDBEdit.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  TntControl_BeforeInherited_ActionChange(Self, Sender, CheckDefaults);
  inherited;
end;

function TTntDBEdit.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TntControl_GetActionLinkClass(Self, inherited GetActionLinkClass);
end;

procedure TTntDBEdit.WMPaint(var Message: TWMPaint);
const
  AlignStyle : array[Boolean, TAlignment] of DWORD =
   ((WS_EX_LEFT, WS_EX_RIGHT, WS_EX_LEFT),
    (WS_EX_RIGHT, WS_EX_LEFT, WS_EX_LEFT));
var
  ALeft: Integer;
  _Margins: TPoint;
  R: TRect;
  DC: HDC;
  PS: TPaintStruct;
  S: WideString;
  AAlignment: TAlignment;
  I: Integer;
begin
  with THackDBEdit(Self), Self do begin
    AAlignment := FAlignment;
    if UseRightToLeftAlignment then ChangeBiDiModeAlignment(AAlignment);
    if ((AAlignment = taLeftJustify) or FFocused) and (not (csPaintCopy in ControlState))
    or (not Win32PlatformIsUnicode) then
    begin
      inherited;
      Exit;
    end;
  { Since edit controls do not handle justification unless multi-line (and
    then only poorly) we will draw right and center justify manually unless
    the edit has the focus. }
    if FCanvas = nil then
    begin
      FCanvas := TControlCanvas.Create;
      FCanvas.Control := Self;
    end;
    DC := Message.DC;
    if DC = 0 then DC := BeginPaint(Handle, PS);
    FCanvas.Handle := DC;
    try
      FCanvas.Font := Font;
      with FCanvas do
      begin
        R := ClientRect;
        if not (NewStyleControls and Ctl3D) and (BorderStyle = bsSingle) then
        begin
          Brush.Color := clWindowFrame;
          FrameRect(R);
          InflateRect(R, -1, -1);
        end;
        Brush.Color := Color;
        if not Enabled then
          Font.Color := clGrayText;
        if (csPaintCopy in ControlState) and (Field <> nil) then
        begin
          S := GetWideDisplayText(Field);
          case CharCase of
            ecUpperCase:
              S := Tnt_WideUpperCase(S);
            ecLowerCase:
              S := Tnt_WideLowerCase(S);
          end;
        end else
          S := Text { EditText? };
        if PasswordChar <> #0 then
          for I := 1 to Length(S) do S[I] := PasswordChar;
        _Margins := GetTextMargins;
        case AAlignment of
          taLeftJustify: ALeft := _Margins.X;
          taRightJustify: ALeft := ClientWidth - WideCanvasTextWidth(FCanvas, S) - _Margins.X - 1;
        else
          ALeft := (ClientWidth - WideCanvasTextWidth(FCanvas, S)) div 2;
        end;
        if SysLocale.MiddleEast then UpdateTextFlags;
        WideCanvasTextRect(FCanvas, R, ALeft, _Margins.Y, S);
      end;
    finally
      FCanvas.Handle := 0;
      if Message.DC = 0 then EndPaint(Handle, PS);
    end;
  end;
end;

function TTntDBEdit.GetTextMargins: TPoint;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  if NewStyleControls then
  begin
    if BorderStyle = bsNone then I := 0 else
      if Ctl3D then I := 1 else I := 2;
    Result.X := SendMessage(Handle, EM_GETMARGINS, 0, 0) and $0000FFFF + I;
    Result.Y := I;
  end else
  begin
    if BorderStyle = bsNone then I := 0 else
    begin
      DC := GetDC(0);
      GetTextMetrics(DC, SysMetrics);
      SaveFont := SelectObject(DC, Font.Handle);
      GetTextMetrics(DC, Metrics);
      SelectObject(DC, SaveFont);
      ReleaseDC(0, DC);
      I := SysMetrics.tmHeight;
      if I > Metrics.tmHeight then I := Metrics.tmHeight;
      I := I div 4;
    end;
    Result.X := I;
    Result.Y := I;
  end;
end;

{ TTntDBText }

constructor TTntDBText.Create(AOwner: TComponent);
begin
  inherited;
  FDataLink := TDataLink(Perform(CM_GETDATALINK, 0, 0)) as TFieldDataLink;
  InheritedDataChange := FDataLink.OnDataChange;
  FDataLink.OnDataChange := DataChange;
end;

destructor TTntDBText.Destroy;
begin
  FDataLink := nil;
  inherited;
end;

procedure TTntDBText.CMDialogChar(var Message: TCMDialogChar);
begin
  TntLabel_CMDialogChar(Self, Message, Caption);
end;

function TTntDBText.IsCaptionStored: Boolean;
begin
  Result := TntControl_IsCaptionStored(Self)
end;

function TTntDBText.GetCaption: TWideCaption;
begin
  Result := TntControl_GetText(Self);
end;

procedure TTntDBText.SetCaption(const Value: TWideCaption);
begin
  TntControl_SetText(Self, Value);
end;

procedure TTntDBText.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntDBText.GetLabelText: WideString;
begin
  if csPaintCopy in ControlState then
    Result := GetFieldText
  else
    Result := Caption;
end;

procedure TTntDBText.DoDrawText(var Rect: TRect; Flags: Integer);
begin
  if not TntLabel_DoDrawText(Self, Rect, Flags, GetLabelText) then
    inherited;
end;

function TTntDBText.IsHintStored: Boolean;
begin
  Result := TntControl_IsHintStored(Self);
end;

function TTntDBText.GetHint: WideString;
begin
  Result := TntControl_GetHint(Self)
end;

procedure TTntDBText.SetHint(const Value: WideString);
begin
  TntControl_SetHint(Self, Value);
end;

procedure TTntDBText.CMHintShow(var Message: TMessage);
begin
  ProcessCMHintShowMsg(Message);
  inherited;
end;

procedure TTntDBText.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  TntControl_BeforeInherited_ActionChange(Self, Sender, CheckDefaults);
  inherited;
end;

function TTntDBText.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TntControl_GetActionLinkClass(Self, inherited GetActionLinkClass);
end;

function TTntDBText.GetFieldText: WideString;
begin
  if Field <> nil then
    Result := GetWideDisplayText(Field)
  else
    if csDesigning in ComponentState then Result := Name else Result := '';
end;

procedure TTntDBText.DataChange(Sender: TObject);
begin
  Caption := GetFieldText;
end;

{ TTntCustomDBComboBox }

constructor TTntCustomDBComboBox.Create(AOwner: TComponent);
begin
  inherited;
  FItems := TTntComboBoxStrings.Create;
  TTntComboBoxStrings(FItems).ComboBox := Self;
  FDataLink := TDataLink(Perform(CM_GETDATALINK, 0, 0)) as TFieldDataLink;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnEditingChange := EditingChange;
end;

destructor TTntCustomDBComboBox.Destroy;
begin
  FreeAndNil(FItems);
  FreeAndNil(FSaveItems);
  FDataLink := nil;
  inherited;
end;

procedure TTntCustomDBComboBox.CreateWindowHandle(const Params: TCreateParams);
begin
  CreateUnicodeHandle(Self, Params, 'COMBOBOX');
end;

procedure TTntCustomDBComboBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

type
  TAccessCustomComboBox = class(TCustomComboBox{TNT-ALLOW TCustomComboBox});

procedure TTntCustomDBComboBox.CreateWnd;
var
  PreInheritedAnsiText: AnsiString;
begin
  PreInheritedAnsiText := TAccessCustomComboBox(Self).Text;
  inherited;
  TntCombo_AfterInherited_CreateWnd(Self, Items, FSaveItems, FSaveItemIndex, PreInheritedAnsiText);
end;

procedure TTntCustomDBComboBox.DestroyWnd;
var
  SavedText: WideString;
begin
  if not (csDestroyingHandle in ControlState) then begin { avoid recursion when parent is TToolBar and system font changes. }
    TntCombo_BeforeInherited_DestroyWnd(Self, Items, FSaveItems, ItemIndex, FSaveItemIndex, SavedText);
    inherited;
    TntControl_SetStoredText(Self, SavedText);
  end;
end;

procedure TTntCustomDBComboBox.SetReadOnly;
begin
  if (Style in [csDropDown, csSimple]) and HandleAllocated then
    SendMessage(EditHandle, EM_SETREADONLY, Ord(not FDataLink.CanModify), 0);
end;

procedure TTntCustomDBComboBox.EditingChange(Sender: TObject);
begin
  SetReadOnly;
end;

procedure TTntCustomDBComboBox.CMEnter(var Message: TCMEnter);
var
  SaveFarEast: Boolean;
begin
  SaveFarEast := SysLocale.FarEast;
  try
    SysLocale.FarEast := False;
    inherited; // inherited tries to work around Win95 FarEast bug, but introduces others
  finally
    SysLocale.FarEast := SaveFarEast;
  end;
end;

procedure TTntCustomDBComboBox.WndProc(var Message: TMessage);
begin
  if (not (csDesigning in ComponentState))
  and (Message.Msg = CB_SHOWDROPDOWN)
  and (Message.WParam = 0)
  and (not FDataLink.Editing) then begin
    DataChange(Self); {Restore text}
    Dispatch(Message); {Do NOT call inherited!}
  end else
    inherited WndProc(Message);
end;

procedure TTntCustomDBComboBox.ComboWndProc(var Message: TMessage; ComboWnd: HWnd; ComboProc: Pointer);
begin
  if not TntCombo_ComboWndProc(Self, Message, ComboWnd, ComboProc, DoEditCharMsg) then
    inherited;
end;

procedure TTntCustomDBComboBox.KeyPress(var Key: AnsiChar);
var
  SaveAutoComplete: Boolean;
begin
  TntCombo_BeforeKeyPress(Self, SaveAutoComplete);
  try
    inherited;
  finally
    TntCombo_AfterKeyPress(Self, SaveAutoComplete);
  end;
end;

procedure TTntCustomDBComboBox.DoEditCharMsg(var Message: TWMChar);
begin
  TntCombo_AutoCompleteKeyPress(Self, Items, Message,
    GetAutoComplete_UniqueMatchOnly, GetAutoComplete_PreserveDataEntryCase);
end;

procedure TTntCustomDBComboBox.WMChar(var Message: TWMChar);
begin
  TntCombo_AutoSearchKeyPress(Self, Items, Message, FFilter, FLastTime);
  inherited;
end;

function TTntCustomDBComboBox.GetItems: TTntStrings;
begin
  Result := FItems;
end;

procedure TTntCustomDBComboBox.SetItems(const Value: TTntStrings);
begin
  FItems.Assign(Value);
  DataChange(Self);
end;

function TTntCustomDBComboBox.GetSelStart: Integer;
begin
  Result := TntCombo_GetSelStart(Self);
end;

procedure TTntCustomDBComboBox.SetSelStart(const Value: Integer);
begin
  TntCombo_SetSelStart(Self, Value);
end;

function TTntCustomDBComboBox.GetSelLength: Integer;
begin
  Result := TntCombo_GetSelLength(Self);
end;

procedure TTntCustomDBComboBox.SetSelLength(const Value: Integer);
begin
  TntCombo_SetSelLength(Self, Value);
end;

function TTntCustomDBComboBox.GetSelText: WideString;
begin
  Result := TntCombo_GetSelText(Self);
end;

procedure TTntCustomDBComboBox.SetSelText(const Value: WideString);
begin
  TntCombo_SetSelText(Self, Value);
end;

function TTntCustomDBComboBox.GetText: WideString;
begin
  Result := TntControl_GetText(Self);
end;

procedure TTntCustomDBComboBox.SetText(const Value: WideString);
begin
  TntControl_SetText(Self, Value);
end;

procedure TTntCustomDBComboBox.CNCommand(var Message: TWMCommand);
begin
  if not TntCombo_CNCommand(Self, Items, Message) then
    inherited;
end;

function TTntCustomDBComboBox.GetFieldValue: Variant;
begin
  Result := Field.Value;
end;

procedure TTntCustomDBComboBox.SetFieldValue(const Value: Variant);
begin
  Field.Value := Value;
end;

procedure TTntCustomDBComboBox.DataChange(Sender: TObject);
begin
  if not (Style = csSimple) and DroppedDown then Exit;
  if Field <> nil then
    SetComboValue(GetFieldValue)
  else
    if csDesigning in ComponentState then
      SetComboValue(Name)
    else
      SetComboValue(Null);
end;

procedure TTntCustomDBComboBox.UpdateData(Sender: TObject);
begin
  SetFieldValue(GetComboValue);
end;

function TTntCustomDBComboBox.GetAutoComplete_PreserveDataEntryCase: Boolean;
begin
  Result := True;
end;

function TTntCustomDBComboBox.GetAutoComplete_UniqueMatchOnly: Boolean;
begin
  Result := False;
end;

function TTntCustomDBComboBox.IsHintStored: Boolean;
begin
  Result := TntControl_IsHintStored(Self);
end;

function TTntCustomDBComboBox.GetHint: WideString;
begin
  Result := TntControl_GetHint(Self)
end;

procedure TTntCustomDBComboBox.SetHint(const Value: WideString);
begin
  TntControl_SetHint(Self, Value);
end;

procedure TTntCustomDBComboBox.AddItem(const Item: WideString; AObject: TObject);
begin
  TntComboBox_AddItem(Items, Item, AObject);
end;

procedure TTntCustomDBComboBox.CopySelection(Destination: TCustomListControl);
begin
  TntComboBox_CopySelection(Items, ItemIndex, Destination);
end;

procedure TTntCustomDBComboBox.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  TntControl_BeforeInherited_ActionChange(Self, Sender, CheckDefaults);
  inherited;
end;

function TTntCustomDBComboBox.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TntControl_GetActionLinkClass(Self, inherited GetActionLinkClass);
end;

{$IFDEF DELPHI_7} // fix for Delphi 7 only
function TTntCustomDBComboBox.GetItemsClass: TCustomComboBoxStringsClass;
begin
  Result := TD7PatchedComboBoxStrings;
end;
{$ENDIF}

{ TTntDBComboBox }

function TTntDBComboBox.GetFieldValue: Variant;
begin
  Result := GetWideText(Field);
end;

procedure TTntDBComboBox.SetFieldValue(const Value: Variant);
begin
  SetWideText(Field, Value);
end;

procedure TTntDBComboBox.SetComboValue(const Value: Variant);
var
  I: Integer;
  Redraw: Boolean;
  OldValue: WideString;
  NewValue: WideString;
begin
  OldValue := VarToWideStr(GetComboValue);
  NewValue := VarToWideStr(Value);

  if NewValue <> OldValue then
  begin
    if Style <> csDropDown then
    begin
      Redraw := (Style <> csSimple) and HandleAllocated;
      if Redraw then Items.BeginUpdate;
      try
        if NewValue = '' then I := -1 else I := Items.IndexOf(NewValue);
        ItemIndex := I;
      finally
        Items.EndUpdate;
      end;
      if I >= 0 then Exit;
    end;
    if Style in [csDropDown, csSimple] then Text := NewValue;
  end;
end;

function TTntDBComboBox.GetComboValue: Variant;
var
  I: Integer;
begin
  if Style in [csDropDown, csSimple] then Result := Text else
  begin
    I := ItemIndex;
    if I < 0 then Result := '' else Result := Items[I];
  end;
end;

{ TTntDBCheckBox }

procedure TTntDBCheckBox.CreateWindowHandle(const Params: TCreateParams);
begin
  CreateUnicodeHandle(Self, Params, 'BUTTON');
end;

procedure TTntDBCheckBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntDBCheckBox.IsCaptionStored: Boolean;
begin
  Result := TntControl_IsCaptionStored(Self);
end;

function TTntDBCheckBox.GetCaption: TWideCaption;
begin
  Result := TntControl_GetText(Self)
end;

procedure TTntDBCheckBox.SetCaption(const Value: TWideCaption);
begin
  TntControl_SetText(Self, Value);
end;

function TTntDBCheckBox.IsHintStored: Boolean;
begin
  Result := TntControl_IsHintStored(Self);
end;

function TTntDBCheckBox.GetHint: WideString;
begin
  Result := TntControl_GetHint(Self)
end;

procedure TTntDBCheckBox.SetHint(const Value: WideString);
begin
  TntControl_SetHint(Self, Value);
end;

procedure TTntDBCheckBox.Toggle;
var
  FDataLink: TDataLink;
begin
  inherited;
  FDataLink := TDataLink(Perform(CM_GETDATALINK, 0, 0)) as TFieldDataLink;
  FDataLink.UpdateRecord;
end;

procedure TTntDBCheckBox.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  TntControl_BeforeInherited_ActionChange(Self, Sender, CheckDefaults);
  inherited;
end;

function TTntDBCheckBox.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TntControl_GetActionLinkClass(Self, inherited GetActionLinkClass);
end;

{ TTntDBRichEdit }

constructor TTntDBRichEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := True;
  FAutoDisplay := True;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
end;

destructor TTntDBRichEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TTntDBRichEdit.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then
    DataChange(Self)
end;

procedure TTntDBRichEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

function TTntDBRichEdit.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TTntDBRichEdit.BeginEditing;
begin
  if not FDataLink.Editing then
  try
    if FieldIsBlobLike(Field) then
      FDataSave := Field.AsString{TNT-ALLOW AsString};
    FDataLink.Edit;
  finally
    FDataSave := '';
  end;
end;

procedure TTntDBRichEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if FMemoLoaded then
  begin
    if (Key = VK_DELETE) or (Key = VK_BACK) or
      ((Key = VK_INSERT) and (ssShift in Shift)) or
      (((Key = Ord('V')) or (Key = Ord('X'))) and (ssCtrl in Shift)) then
      BeginEditing;
  end;
end;

procedure TTntDBRichEdit.KeyPress(var Key: AnsiChar);
begin
  inherited KeyPress(Key);
  if FMemoLoaded then
  begin
    if (Key in [#32..#255]) and (Field <> nil) and
      not Field.IsValidChar(Key) then
    begin
      MessageBeep(0);
      Key := #0;
    end;
    case Key of
      ^H, ^I, ^J, ^M, ^V, ^X, #32..#255:
        BeginEditing;
      #27:
        FDataLink.Reset;
    end;
  end else
  begin
    if Key = #13 then LoadMemo;
    Key := #0;
  end;
end;

procedure TTntDBRichEdit.Change;
begin
  if FMemoLoaded then
    FDataLink.Modified;
  FMemoLoaded := True;
  inherited Change;
end;

procedure TTntDBRichEdit.CNNotify(var Message: TWMNotify);
begin
  inherited;
  if Message.NMHdr^.code = EN_PROTECTED then
    Message.Result := 0 { allow the operation (otherwise the control might appear stuck) }
end;

function TTntDBRichEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TTntDBRichEdit.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TTntDBRichEdit.GetDataField: WideString;
begin
  Result := FDataLink.FieldName;
end;

procedure TTntDBRichEdit.SetDataField(const Value: WideString);
begin
  FDataLink.FieldName := Value;
end;

function TTntDBRichEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TTntDBRichEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TTntDBRichEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TTntDBRichEdit.InternalLoadMemo;
var
  Stream: TStringStream{TNT-ALLOW TStringStream};
begin
  if PlainText then
    Text := GetAsWideString(Field)
  else begin
    Stream := TStringStream{TNT-ALLOW TStringStream}.Create(Field.AsString{TNT-ALLOW AsString});
    try
      Lines.LoadFromStream(Stream);
    finally
      Stream.Free;
    end;
  end;
end;

procedure TTntDBRichEdit.LoadMemo;
begin
  if not FMemoLoaded and Assigned(Field) and FieldIsBlobLike(Field) then
  begin
    try
      InternalLoadMemo;
      FMemoLoaded := True;
    except
      { Rich Edit Load failure }
      on E:EOutOfResources do
        Lines.Text := WideFormat('(%s)', [E.Message]);
    end;
    EditingChange(Self);
  end;
end;

procedure TTntDBRichEdit.DataChange(Sender: TObject);
begin
  if Field <> nil then
    if FieldIsBlobLike(Field) then
    begin
      if FAutoDisplay or (FDataLink.Editing and FMemoLoaded) then
      begin
        { Check if the data has changed since we read it the first time }
        if (FDataSave <> '') and (FDataSave = Field.AsString{TNT-ALLOW AsString}) then Exit;
        FMemoLoaded := False;
        LoadMemo;
      end else
      begin
        Text := WideFormat('(%s)', [Field.DisplayName]);
        FMemoLoaded := False;
      end;
    end else
    begin
      if FFocused and FDataLink.CanModify then
        Text := GetWideText(Field)
      else
        Text := GetWideDisplayText(Field);
      FMemoLoaded := True;
    end
  else
  begin
    if csDesigning in ComponentState then Text := Name else Text := '';
    FMemoLoaded := False;
  end;
  if HandleAllocated then
    RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_ERASE or RDW_FRAME);
end;

procedure TTntDBRichEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not (FDataLink.Editing and FMemoLoaded);
end;

procedure TTntDBRichEdit.InternalSaveMemo;
var
  Stream: TStringStream{TNT-ALLOW TStringStream};
begin
  if PlainText then
    SetAsWideString(Field, Text)
  else begin
    Stream := TStringStream{TNT-ALLOW TStringStream}.Create('');
    try
      Lines.SaveToStream(Stream);
      Field.AsString{TNT-ALLOW AsString} := Stream.DataString;
    finally
      Stream.Free;
    end;
  end;
end;

procedure TTntDBRichEdit.UpdateData(Sender: TObject);
begin
  if FieldIsBlobLike(Field) then
    InternalSaveMemo
  else
    SetAsWideString(Field, Text);
end;

procedure TTntDBRichEdit.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if not Assigned(Field) or not FieldIsBlobLike(Field) then
      FDataLink.Reset;
  end;
end;

procedure TTntDBRichEdit.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);
  inherited;
end;

procedure TTntDBRichEdit.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  SetFocused(False);
  inherited;
end;

procedure TTntDBRichEdit.SetAutoDisplay(Value: Boolean);
begin
  if FAutoDisplay <> Value then
  begin
    FAutoDisplay := Value;
    if Value then LoadMemo;
  end;
end;

procedure TTntDBRichEdit.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  if not FMemoLoaded then LoadMemo else inherited;
end;

procedure TTntDBRichEdit.WMCut(var Message: TMessage);
begin
  BeginEditing;
  inherited;
end;

procedure TTntDBRichEdit.WMPaste(var Message: TMessage);
begin
  BeginEditing;
  inherited;
end;

procedure TTntDBRichEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TTntDBRichEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TTntDBRichEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

{ TTntDBMemo }

constructor TTntDBMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := True;
  ControlStyle := ControlStyle + [csReplicatable];
  FAutoDisplay := True;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FPaintControl := TTntPaintControl.Create(Self, 'EDIT');
end;

destructor TTntDBMemo.Destroy;
begin
  FPaintControl.Free;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TTntDBMemo.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TTntDBMemo.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

function TTntDBMemo.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TTntDBMemo.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if FMemoLoaded then
  begin
    if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) then
      FDataLink.Edit;
  end;
end;

procedure TTntDBMemo.KeyPress(var Key: Char{TNT-ALLOW Char});
begin
  inherited KeyPress(Key);
  if FMemoLoaded then
  begin
    if (Key in [#32..#255]) and (FDataLink.Field <> nil) and
      not FDataLink.Field.IsValidChar(Key) then
    begin
      MessageBeep(0);
      Key := #0;
    end;
    case Key of
      ^H, ^I, ^J, ^M, ^V, ^X, #32..#255:
        FDataLink.Edit;
      #27:
        FDataLink.Reset;
    end;
  end else
  begin
    if Key = #13 then LoadMemo;
    Key := #0;
  end;
end;

procedure TTntDBMemo.Change;
begin
  if FMemoLoaded then FDataLink.Modified;
  FMemoLoaded := True;
  inherited Change;
end;

function TTntDBMemo.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TTntDBMemo.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TTntDBMemo.GetDataField: WideString;
begin
  Result := FDataLink.FieldName;
end;

procedure TTntDBMemo.SetDataField(const Value: WideString);
begin
  FDataLink.FieldName := Value;
end;

function TTntDBMemo.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TTntDBMemo.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TTntDBMemo.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TTntDBMemo.LoadMemo;
begin
  if not FMemoLoaded and Assigned(FDataLink.Field) and FieldIsBlobLike(FDataLink.Field) then
  begin
    try
      Lines.Text := GetAsWideString(FDataLink.Field);
      FMemoLoaded := True;
    except
      { Memo too large }
      on E:EInvalidOperation do
        Lines.Text := WideFormat('(%s)', [E.Message]);
    end;
    EditingChange(Self);
  end;
end;

procedure TTntDBMemo.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
    if FieldIsBlobLike(FDataLink.Field) then
    begin
      if FAutoDisplay or (FDataLink.Editing and FMemoLoaded) then
      begin
        FMemoLoaded := False;
        LoadMemo;
      end else
      begin
        Text := WideFormat('(%s)', [FDataLink.Field.DisplayName]);
        FMemoLoaded := False;
        EditingChange(Self);
      end;
    end else
    begin
      if FFocused and FDataLink.CanModify then
        Text := GetWideText(FDataLink.Field)
      else
        Text := GetWideDisplayText(FDataLink.Field);
      FMemoLoaded := True;
    end
  else
  begin
    if csDesigning in ComponentState then Text := Name else Text := '';
    FMemoLoaded := False;
  end;
  if HandleAllocated then
    RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_ERASE or RDW_FRAME);
end;

procedure TTntDBMemo.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not (FDataLink.Editing and FMemoLoaded);
end;

procedure TTntDBMemo.UpdateData(Sender: TObject);
begin
  SetAsWideString(FDataLink.Field, Text);
end;

procedure TTntDBMemo.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if not Assigned(FDataLink.Field) or not FieldIsBlobLike(FDataLink.Field) then
      FDataLink.Reset;
  end;
end;

procedure TTntDBMemo.WndProc(var Message: TMessage);
begin
  with Message do
    if (Msg = WM_CREATE) or (Msg = WM_WINDOWPOSCHANGED) or
      (Msg = CM_FONTCHANGED) then FPaintControl.DestroyHandle;
  inherited;
end;

procedure TTntDBMemo.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);
  inherited;
end;

procedure TTntDBMemo.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  SetFocused(False);
  inherited;
end;

procedure TTntDBMemo.SetAutoDisplay(Value: Boolean);
begin
  if FAutoDisplay <> Value then
  begin
    FAutoDisplay := Value;
    if Value then LoadMemo;
  end;
end;

procedure TTntDBMemo.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  if not FMemoLoaded then LoadMemo else inherited;
end;

procedure TTntDBMemo.WMCut(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TTntDBMemo.WMUndo(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TTntDBMemo.WMPaste(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TTntDBMemo.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

procedure TTntDBMemo.WMPaint(var Message: TWMPaint);
var
  S: WideString;
begin
  if not (csPaintCopy in ControlState) then
    inherited
  else begin
    if FDataLink.Field <> nil then
      if FieldIsBlobLike(FDataLink.Field) then
      begin
        if FAutoDisplay then
          S := TntAdjustLineBreaks(GetAsWideString(FDataLink.Field)) else
          S := WideFormat('(%s)', [FDataLink.Field.DisplayName]);
      end else
        S := GetWideDisplayText(FDataLink.Field);
    if (not Win32PlatformIsUnicode) then
      SendMessageA(FPaintControl.Handle, WM_SETTEXT, 0, Integer(PAnsiChar(AnsiString(S))))
    else begin
      SendMessageW(FPaintControl.Handle, WM_SETTEXT, 0, Integer(PWideChar(S)));
    end;
    SendMessage(FPaintControl.Handle, WM_ERASEBKGND, Integer(Message.DC), 0);
    SendMessage(FPaintControl.Handle, WM_PAINT, Integer(Message.DC), 0);
  end;
end;

function TTntDBMemo.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TTntDBMemo.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

{ TTntDBRadioGroup }

constructor TTntDBRadioGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FValues := TTntStringList.Create;
end;

destructor TTntDBRadioGroup.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  FValues.Free;
  inherited Destroy;
end;

procedure TTntDBRadioGroup.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

function TTntDBRadioGroup.UseRightToLeftAlignment: Boolean;
begin
  Result := inherited UseRightToLeftAlignment;
end;

procedure TTntDBRadioGroup.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
    Value := GetWideText(FDataLink.Field) else
    Value := '';
end;

procedure TTntDBRadioGroup.UpdateData(Sender: TObject);
begin
  if FDataLink.Field <> nil then
    SetWideText(FDataLink.Field, Value);
end;

function TTntDBRadioGroup.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TTntDBRadioGroup.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TTntDBRadioGroup.GetDataField: WideString;
begin
  Result := FDataLink.FieldName;
end;

procedure TTntDBRadioGroup.SetDataField(const Value: WideString);
begin
  FDataLink.FieldName := Value;
end;

function TTntDBRadioGroup.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TTntDBRadioGroup.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TTntDBRadioGroup.GetField: TField;
begin
  Result := FDataLink.Field;
end;

function TTntDBRadioGroup.GetButtonValue(Index: Integer): WideString;
begin
  if (Index < FValues.Count) and (FValues[Index] <> '') then
    Result := FValues[Index]
  else if Index < Items.Count then
    Result := Items[Index]
  else
    Result := '';
end;

procedure TTntDBRadioGroup.SetValue(const Value: WideString);
var
  WasFocused: Boolean;
  I, Index: Integer;
begin
  if FValue <> Value then
  begin
    FInSetValue := True;
    try
      WasFocused := (ItemIndex > -1) and (Buttons[ItemIndex].Focused);
      Index := -1;
      for I := 0 to Items.Count - 1 do
        if Value = GetButtonValue(I) then
        begin
          Index := I;
          Break;
        end;
      ItemIndex := Index;
      // Move the focus rect along with the selected index
      if WasFocused then
        Buttons[ItemIndex].SetFocus;
    finally
      FInSetValue := False;
    end;
    FValue := Value;
    Change;
  end;
end;

procedure TTntDBRadioGroup.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    if ItemIndex >= 0 then
      (Controls[ItemIndex] as TTntRadioButton).SetFocus else
      (Controls[0] as TTntRadioButton).SetFocus;
    raise;
  end;
  inherited;
end;

procedure TTntDBRadioGroup.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

procedure TTntDBRadioGroup.Click;
begin
  if not FInSetValue then
  begin
    inherited Click;
    if ItemIndex >= 0 then Value := GetButtonValue(ItemIndex);
    if FDataLink.Editing then FDataLink.Modified;
  end;
end;

procedure TTntDBRadioGroup.SetItems(Value: TTntStrings);
begin
  Items.Assign(Value);
  DataChange(Self);
end;

procedure TTntDBRadioGroup.SetValues(Value: TTntStrings);
begin
  FValues.Assign(Value);
  DataChange(Self);
end;

procedure TTntDBRadioGroup.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TTntDBRadioGroup.KeyPress(var Key: Char{TNT-ALLOW Char});
begin
  inherited KeyPress(Key);
  case Key of
    #8, ' ': FDataLink.Edit;
    #27: FDataLink.Reset;
  end;
end;

function TTntDBRadioGroup.CanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;

function TTntDBRadioGroup.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (DataLink <> nil) and
    DataLink.ExecuteAction(Action);
end;

function TTntDBRadioGroup.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (DataLink <> nil) and
    DataLink.UpdateAction(Action);
end;
(*
{ TTntDBLookupComboBox }

procedure TTntDBLookupComboBox.ActionChange(Sender: TObject;
  CheckDefaults: Boolean);
begin
  TntControl_BeforeInherited_ActionChange(Self, Sender, CheckDefaults);
  inherited;
end;

constructor TTntDBLookupComboBox.Create(AOwner: TComponent);
begin
  inherited;
  {FDataLink := TDataLink(Perform(CM_GETDATALINK, 0, 0)) as TFieldDataLink;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnEditingChange := EditingChange;}
  FButtonWidth := GetSystemMetrics(SM_CXVSCROLL);
end;

destructor TTntDBLookupComboBox.Destroy;
begin
  //FDataLink := nil;
  inherited;
end;

procedure TTntDBLookupComboBox.CreateWindowHandle(
  const Params: TCreateParams);
begin
  CreateUnicodeHandle(Self, Params, '');
  //inherited;
end;

procedure TTntDBLookupComboBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntDBLookupComboBox.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TntControl_GetActionLinkClass(Self, inherited GetActionLinkClass);
end;

function TTntDBLookupComboBox.GetHint: WideString;
begin
  Result := TntControl_GetHint(Self);
end;

function TTntDBLookupComboBox.GetText: WideString;
begin
  Result := TntControl_GetText(Self);
end;

function TTntDBLookupComboBox.IsHintStored: Boolean;
begin
  Result := TntControl_IsHintStored(Self);
end;

procedure TTntDBLookupComboBox.SetHint(const Value: WideString);
begin
  TntControl_SetHint(Self, Value);
end;

procedure TTntDBLookupComboBox.SetText(const Value: WideString);
begin
  TntControl_SetText(Self, Value);
end;

function TTntDBLookupComboBox.IsLookupMode: Boolean;
begin
  Result := (Field <> nil) and (Field.FieldKind = fkLookup);
end;

function TTntDBLookupComboBox.GetListField: TField;
var
  DataSet: TDataSet;
begin
  Result := nil;
  if Assigned(ListLink) and Assigned(ListLink.DataSet) then
  begin
    DataSet := ListLink.DataSet;
    if IsLookupMode then
    begin
      Result := GetFieldProperty(DataSet, Self, Field.LookupResultField);
    end else
    begin
    if (ListFieldIndex >= 0) and (ListFieldIndex < ListFields.Count) then
        Result := ListFields[ListFieldIndex] else
        Result := ListFields[0];
    end;
  end;
end;

procedure TTntDBLookupComboBox.KeyValueChanged;
var
  LstField: TField;
begin
  //inherited;
  //Exit;
  if {FLookupMode}False then
  begin
    //FText := FDataField.DisplayText;
    SetText(GetWideDisplayText(Field));
    FAlignment := Field.Alignment;
  end else
  if ListActive and LocateKey then
  begin
    //Text := FListField.DisplayText;
    LstField := GetListField;
    if Assigned(LstField) then
    begin
      SetText(GetWideDisplayText(LstField));
      FAlignment := LstField.Alignment;
    end;  
  end else
  begin
    SetText('');
    FAlignment := taLeftJustify;
  end;
  Invalidate;
end;

procedure TTntDBLookupComboBox.Paint;
var
  W, X, Flags: Integer;
  Text: WideString;
  AAlignment: TAlignment;
  Selected: Boolean;
  R: TRect;
  State : TThemedComboBox;
  Details: TThemedElementDetails;
begin
  //inherited;
  //Exit;
  Canvas.Font := Font;
  Canvas.Brush.Color := Color;
  Selected := HasFocus and not ListVisible and
    not (csPaintCopy in ControlState);
  if Enabled then
    Canvas.Font.Color := Font.Color
  else
    Canvas.Font.Color := clGrayText;
  if Selected then
  begin
    Canvas.Font.Color := clHighlightText;
    Canvas.Brush.Color := clHighlight;
  end;
  if (csPaintCopy in ControlState) and (Field <> nil) and
    (Field.Lookup) then
  begin
    Text := GetWideDisplayText(Field);
    AAlignment := Field.Alignment;
  end else
  begin
    if (csDesigning in ComponentState) and (Field = nil) then
      Text := Name else
      Text := GetText;
    AAlignment := FAlignment;
  end;
  if UseRightToLeftAlignment then ChangeBiDiModeAlignment(AAlignment);
  W := ClientWidth - FButtonWidth;
  X := 2;
  case AAlignment of
    taRightJustify: X := W - WideCanvasTextWidth(Canvas, Text) - 3;
    taCenter: X := (W - WideCanvasTextWidth(Canvas, Text)) div 2;
  end;
  SetRect(R, 1, 1, W - 1, ClientHeight - 1);
  if (SysLocale.MiddleEast) and (BiDiMode = bdRightToLeft) then
  begin
    Inc(X, FButtonWidth);
    Inc(R.Left, FButtonWidth);
    R.Right := ClientWidth;
  end;
  if SysLocale.MiddleEast then TControlCanvas(Canvas).UpdateTextFlags;
  Canvas.TextRect(R, X, 2, Text);
  WideCanvasTextRect(Canvas, R, X, 2, Text);
  if Selected then Canvas.DrawFocusRect(R);
  SetRect(R, W, 0, ClientWidth, ClientHeight);
  if (SysLocale.MiddleEast) and (BiDiMode = bdRightToLeft) then
  begin
    R.Left := 0;
    R.Right:= FButtonWidth;
  end;

  if ThemeServices.ThemesEnabled then
  begin
    if not ListActive then
      State := tcDropDownButtonDisabled
    else
      if FPressed then
        State := tcDropDownButtonPressed
      else
        if FMouseInControl and not ListVisible then
          State := tcDropDownButtonHot
        else
          State := tcDropDownButtonNormal;
    Details := ThemeServices.GetElementDetails(State);
    ThemeServices.DrawElement(Canvas.Handle, Details, R);
  end
  else
  begin
    if not (ListActive and Enabled) then
      Flags := DFCS_SCROLLCOMBOBOX or DFCS_INACTIVE
    else if FPressed then
      Flags := DFCS_SCROLLCOMBOBOX or DFCS_FLAT or DFCS_PUSHED
    else
      Flags := DFCS_SCROLLCOMBOBOX;
    DrawFrameControl(Canvas.Handle, R, DFC_SCROLL, Flags);
  end;
end;

procedure TTntDBLookupComboBox.CMMouseEnter(var Message: TMessage);
begin
  {Windows XP themes use hot track states, hence we have to update the drop down button.}
  if ThemeServices.ThemesEnabled and not (FMouseInControl) and not (csDesigning in ComponentState) then
  begin
    FMouseInControl := True;
  end;
  inherited;
end;

procedure TTntDBLookupComboBox.CMMouseLeave(var Message: TMessage);
begin
  if ThemeServices.ThemesEnabled and FMouseInControl then
  begin
    FMouseInControl := False;
  end;
  inherited;
end;

procedure TTntDBLookupComboBox.StopTracking;
begin
  if FTracking then
  begin
    TrackButton(-1, -1);
    FTracking := False;
  end;
end;

procedure TTntDBLookupComboBox.TrackButton(X, Y: Integer);
var
  NewState: Boolean;
begin
  NewState := PtInRect(Rect(ClientWidth - FButtonWidth, 0, ClientWidth, ClientHeight), Point(X, Y));
  if FPressed <> NewState then
  begin
    FPressed := NewState;
    Repaint;
  end;
end;

procedure TTntDBLookupComboBox.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if Button = mbLeft then
  begin
    if ListVisible then
      if ListActive then
      begin
        FTracking := True;
        TrackButton(X, Y);
      end;
  end;
end;

procedure TTntDBLookupComboBox.MouseMove(Shift: TShiftState; X,
  Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
  if FTracking then
  begin
    TrackButton(X, Y);
    {if ListVisible then
    begin
      ListPos := FDataList.ScreenToClient(ClientToScreen(Point(X, Y)));
      if PtInRect(FDataList.ClientRect, ListPos) then
      begin
        StopTracking;
        MousePos := PointToSmallPoint(ListPos);
        SendMessage(FDataList.Handle, WM_LBUTTONDOWN, 0, Integer(MousePos));
        Exit;
      end;
    end;}
  end;
end;

procedure TTntDBLookupComboBox.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  StopTracking;
  inherited MouseUp(Button, Shift, X, Y);
end; *)

{ TDataSourceLink }

constructor TDataSourceLink.Create;
begin
  inherited Create;
  VisualControl := True;
end;

procedure TDataSourceLink.ActiveChanged;
begin
  if FDBLookupControl <> nil then FDBLookupControl.UpdateDataFields;
end;

procedure TDataSourceLink.FocusControl(Field: TFieldRef);
begin
  if (Field^ <> nil) and (Field^ = FDBLookupControl.Field) and
    (FDBLookupControl <> nil) and FDBLookupControl.CanFocus then
  begin
    Field^ := nil;
    FDBLookupControl.SetFocus;
  end;
end;

procedure TDataSourceLink.LayoutChanged;
begin
  if FDBLookupControl <> nil then FDBLookupControl.UpdateDataFields;
end;

procedure TDataSourceLink.RecordChanged(Field: TField);
begin
  if FDBLookupControl <> nil then FDBLookupControl.DataLinkRecordChanged(Field);
end;

{ TListSourceLink }

constructor TListSourceLink.Create;
begin
  inherited Create;
  VisualControl := True;
end;

procedure TListSourceLink.ActiveChanged;
begin
  if FDBLookupControl <> nil then FDBLookupControl.UpdateListFields;
end;

procedure TListSourceLink.DataSetChanged;
begin
  if FDBLookupControl <> nil then FDBLookupControl.ListLinkDataChanged;
end;

procedure TListSourceLink.LayoutChanged;
begin
  if FDBLookupControl <> nil then FDBLookupControl.UpdateListFields;
end;

{ TTntDBLookupControl }

var
  SearchTickCount: Cardinal = 0;

constructor TTntDBLookupControl.Create(AOwner: TComponent);
{$IFDEF COMPILER_7_UP}
const
  LookupStyle = [csOpaque, csNeedsBorderPaint];
{$ENDIF}
begin
  inherited Create(AOwner);
{$IFDEF COMPILER_7_UP}
  if NewStyleControls then
    ControlStyle := LookupStyle
  else
    ControlStyle := LookupStyle + [csFramed];
{$ELSE}
  ControlStyle := [csOpaque, csFramed];
{$ENDIF}
  ParentColor := False;
  TabStop := True;
  FLookupSource := TDataSource.Create(Self);
  FDataLink := TDataSourceLink.Create;
  FDataLink.FDBLookupControl := Self;
  FListLink := TListSourceLink.Create;
  FListLink.FDBLookupControl := Self;
  FListFields := TList.Create;
  FKeyValue := Null;
end;

destructor TTntDBLookupControl.Destroy;
begin
  inherited Destroy;
  FListFields.Free;
  FListFields := nil;
  if FListLink <> nil then
    FListLink.FDBLookupControl := nil;
  FListLink.Free;
  FListLink := nil;
  if FDataLink <> nil then
    FDataLink.FDBLookupControl := nil;
  FDataLink.Free;
  FDataLink := nil;
end;

function TTntDBLookupControl.CanModify: Boolean;
begin
  Result := FListActive and not ReadOnly and ((FDataLink.DataSource = nil) or
    (FMasterField <> nil) and FMasterField.CanModify);
end;

procedure TTntDBLookupControl.CheckNotCircular;
begin
  if FListLink.Active and FListLink.DataSet.IsLinkedTo(DataSource) then
    DatabaseError(SCircularDataLink);
end;

procedure TTntDBLookupControl.CheckNotLookup;
begin
  if FLookupMode then DatabaseError(SPropDefByLookup);
  if FDataLink.DataSourceFixed then DatabaseError(SDataSourceFixed);
end;

procedure TTntDBLookupControl.UpdateDataFields;
begin
  FDataField := nil;
  FMasterField := nil;
  if FDataLink.Active and (FDataFieldName <> '') then
  begin
    CheckNotCircular;
    FDataField := GetFieldProperty(FDataLink.DataSet, Self, FDataFieldName);
    if FDataField.FieldKind = fkLookup then
      FMasterField := GetFieldProperty(FDataLink.DataSet, Self, FDataField.KeyFields)
    else
      FMasterField := FDataField;
  end;
  SetLookupMode((FDataField <> nil) and (FDataField.FieldKind = fkLookup));
  DataLinkRecordChanged(nil);
end;

procedure TTntDBLookupControl.DataLinkRecordChanged(Field: TField);
begin
  if (Field = nil) or (Field = FMasterField) then
    if FMasterField <> nil then
      SetKeyValue(FMasterField.Value) else
      SetKeyValue(Null);
end;

function TTntDBLookupControl.GetBorderSize: Integer;
var
  Params: TCreateParams;
  R: TRect;
begin
  CreateParams(Params);
  SetRect(R, 0, 0, 0, 0);
  AdjustWindowRectEx(R, Params.Style, False, Params.ExStyle);
  Result := R.Bottom - R.Top;
end;

function TTntDBLookupControl.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TTntDBLookupControl.GetKeyFieldName: string;
begin
  if FLookupMode then Result := '' else Result := FKeyFieldName;
end;

function TTntDBLookupControl.GetListSource: TDataSource;
begin
  if FLookupMode then Result := nil else Result := FListLink.DataSource;
end;

function TTntDBLookupControl.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

function TTntDBLookupControl.GetTextHeight: Integer;
var
  DC: HDC;
  SaveFont: HFont;
  Metrics: TTextMetric;
begin
  DC := GetDC(0);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  Result := Metrics.tmHeight;
end;

procedure TTntDBLookupControl.KeyValueChanged;
begin
end;

procedure TTntDBLookupControl.UpdateListFields;
var
  DataSet: TDataSet;
  ResultField: TField;
begin
  FListActive := False;
  FKeyField := nil;
  FListField := nil;
  FListFields.Clear;
  if FListLink.Active and (FKeyFieldName <> '') then
  begin
    CheckNotCircular;
    DataSet := FListLink.DataSet;
    FKeyField := GetFieldProperty(DataSet, Self, FKeyFieldName);
    try
      DataSet.GetFieldList(FListFields, FListFieldName);
    except
      DatabaseErrorFmt(SFieldNotFound, [Self.Name, FListFieldName]);
    end;
    if FLookupMode then
    begin
      ResultField := GetFieldProperty(DataSet, Self, FDataField.LookupResultField);
      if FListFields.IndexOf(ResultField) < 0 then
        FListFields.Insert(0, ResultField);
      FListField := ResultField;
    end else
    begin
      if FListFields.Count = 0 then FListFields.Add(FKeyField);
      if (FListFieldIndex >= 0) and (FListFieldIndex < FListFields.Count) then
        FListField := FListFields[FListFieldIndex] else
        FListField := FListFields[0];
    end;
    FListActive := True;
  end;
end;

procedure TTntDBLookupControl.ListLinkDataChanged;
begin
end;

function TTntDBLookupControl.LocateKey: Boolean;
var
  KeySave: Variant;
begin
  Result := False;
  try
    KeySave := FKeyValue;
    if not VarIsNull(FKeyValue) and FListLink.DataSet.Active and
      FListLink.DataSet.Locate(FKeyFieldName, FKeyValue, []) then
    begin
      Result := True;
      FKeyValue := KeySave;
    end;
  except
  end;
end;

procedure TTntDBLookupControl.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if (FDataLink <> nil) and (AComponent = DataSource) then DataSource := nil;
    if (FListLink <> nil) and (AComponent = ListSource) then ListSource := nil;
  end;
end;

procedure TTntDBLookupControl.ProcessSearchKey(Key: Char);
var
  TickCount: Cardinal;
  S: string;
  CharMsg: TMsg;
begin
  if (FListField <> nil) and (FListField.FieldKind in [fkData, fkInternalCalc]) and
    (FListField.DataType in [ftString, ftWideString]) then
    case Key of
      #8, #27: SearchText := '';
      #32..#255:
        if CanModify then
        begin
          TickCount := GetTickCount;
          if TickCount - SearchTickCount > 2000 then SearchText := '';
          SearchTickCount := TickCount;
          if SysLocale.FarEast and (Key in LeadBytes) then
            if PeekMessage(CharMsg, Handle, WM_CHAR, WM_CHAR, PM_REMOVE) then
            begin
              if CharMsg.Message = WM_Quit then
              begin
                PostQuitMessage(CharMsg.wparam);
                Exit;
              end;
              SearchText := SearchText + Key;
              Key := Char(CharMsg.wParam);
            end;
          if Length(SearchText) < 32 then
          begin
            S := SearchText + Key;
            try
              if FListLink.DataSet.Locate(FListField.FieldName, S,
                [loCaseInsensitive, loPartialKey]) then
              begin
                SelectKeyValue(FKeyField.Value);
                SearchText := S;
              end;
            except
              { If you attempt to search for a string larger than what the field
                can hold, and exception will be raised.  Just trap it and
                reset the SearchText back to the old value. }
              SearchText := S;
            end;
          end;
        end;
    end;
end;

procedure TTntDBLookupControl.SelectKeyValue(const Value: Variant);
begin
  if FMasterField <> nil then
  begin
    if FDataLink.Edit then
      FMasterField.Value := Value;
  end else
    SetKeyValue(Value);
  Repaint;
  Click;
end;

procedure TTntDBLookupControl.SetDataFieldName(const Value: string);
begin
  if FDataFieldName <> Value then
  begin
    FDataFieldName := Value;
    UpdateDataFields;
  end;
end;

procedure TTntDBLookupControl.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TTntDBLookupControl.SetKeyFieldName(const Value: string);
begin
  CheckNotLookup;
  if FKeyFieldName <> Value then
  begin
    FKeyFieldName := Value;
    UpdateListFields;
  end;
end;

procedure TTntDBLookupControl.SetKeyValue(const Value: Variant);
begin
  if not VarEquals(FKeyValue, Value) then
  begin
    FKeyValue := Value;
    KeyValueChanged;
  end;
end;

procedure TTntDBLookupControl.SetListFieldName(const Value: string);
begin
  if FListFieldName <> Value then
  begin
    FListFieldName := Value;
    UpdateListFields;
  end;
end;

procedure TTntDBLookupControl.SetListSource(Value: TDataSource);
begin
  CheckNotLookup;
  FListLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TTntDBLookupControl.SetLookupMode(Value: Boolean);
begin
  if FLookupMode <> Value then
    if Value then
    begin
      FMasterField := GetFieldProperty(FDataField.DataSet, Self, FDataField.KeyFields);
      FLookupSource.DataSet := FDataField.LookupDataSet;
      FKeyFieldName := FDataField.LookupKeyFields;
      FLookupMode := True;
      FListLink.DataSource := FLookupSource;
    end else
    begin
      FListLink.DataSource := nil;
      FLookupMode := False;
      FKeyFieldName := '';
      FLookupSource.DataSet := nil;
      FMasterField := FDataField;
    end;
end;

procedure TTntDBLookupControl.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

procedure TTntDBLookupControl.WMGetDlgCode(var Message: TMessage);
begin
  Message.Result := DLGC_WANTARROWS or DLGC_WANTCHARS;
end;

procedure TTntDBLookupControl.WMKillFocus(var Message: TMessage);
begin
  FHasFocus := False;
  inherited;
  Invalidate;
end;

procedure TTntDBLookupControl.WMSetFocus(var Message: TMessage);
begin
  SearchText := '';
  FHasFocus := True;
  inherited;
  Invalidate;
end;

procedure TTntDBLookupControl.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TTntDBLookupControl.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TTntDBLookupControl.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TTntDBLookupControl.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TTntDBLookupControl.WMKeyDown(var Message: TWMKeyDown);
begin
  if (FNullValueKey <> 0) and CanModify and (FNullValueKey = ShortCut(Message.CharCode,
     KeyDataToShiftState(Message.KeyData))) then
  begin
    FDataLink.Edit;
    Field.Clear;
    Message.CharCode := 0;
  end;
  inherited;
end;

{ TTntDBLookupListBox }

constructor TTntDBLookupListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csDoubleClicks];
  Width := 121;
  FBorderStyle := bsSingle;
  RowCount := 7;
end;

procedure TTntDBLookupListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    if FBorderStyle = bsSingle then
      if NewStyleControls and Ctl3D then
        ExStyle := ExStyle or WS_EX_CLIENTEDGE
      else
        Style := Style or WS_BORDER;
end;

procedure TTntDBLookupListBox.CreateWnd;
begin
  inherited CreateWnd;
  UpdateScrollBar;
end;

function TTntDBLookupListBox.GetKeyIndex: Integer;
var
  FieldValue: Variant;
begin
  if not VarIsNull(FKeyValue) then
    for Result := 0 to FRecordCount - 1 do
    begin
      ListLink.ActiveRecord := Result;
      FieldValue := FKeyField.Value;
      ListLink.ActiveRecord := FRecordIndex;
      if VarEquals(FieldValue, FKeyValue) then Exit;
    end;
  Result := -1;
end;

procedure TTntDBLookupListBox.KeyDown(var Key: Word; Shift: TShiftState);
var
  Delta, KeyIndex: Integer;
begin
  inherited KeyDown(Key, Shift);
  if CanModify then
  begin
    Delta := 0;
    case Key of
      VK_UP, VK_LEFT: Delta := -1;
      VK_DOWN, VK_RIGHT: Delta := 1;
      VK_PRIOR: Delta := 1 - FRowCount;
      VK_NEXT: Delta := FRowCount - 1;
      VK_HOME: Delta := -Maxint;
      VK_END: Delta := Maxint;
    end;
    if Delta <> 0 then
    begin
      SearchText := '';
      if Delta = -Maxint then ListLink.DataSet.First else
        if Delta = Maxint then ListLink.DataSet.Last else
        begin
          KeyIndex := GetKeyIndex;
          if KeyIndex >= 0 then
            ListLink.DataSet.MoveBy(KeyIndex - FRecordIndex)
          else
          begin
            KeyValueChanged;
            Delta := 0;
          end;
          ListLink.DataSet.MoveBy(Delta);
        end;
      SelectCurrent;
    end;
  end;
end;

procedure TTntDBLookupListBox.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  ProcessSearchKey(Key);
end;

procedure TTntDBLookupListBox.KeyValueChanged;
begin
  if ListActive and not FLockPosition then
    if not LocateKey then ListLink.DataSet.First;
  if FListField <> nil then
    FSelectedItem := GetWideDisplayText(FListField){.DisplayText} else
    FSelectedItem := '';
end;

procedure TTntDBLookupListBox.UpdateListFields;
begin
  try
    inherited;
  finally
    if ListActive then KeyValueChanged else ListLinkDataChanged;
  end;
end;

procedure TTntDBLookupListBox.ListLinkDataChanged;
begin
  if ListActive then
  begin
    FRecordIndex := ListLink.ActiveRecord;
    FRecordCount := ListLink.RecordCount;
    FKeySelected := not VarIsNull(FKeyValue) or
      not ListLink.DataSet.BOF;
  end else
  begin
    FRecordIndex := 0;
    FRecordCount := 0;
    FKeySelected := False;
  end;
  if HandleAllocated then
  begin
    UpdateScrollBar;
    Invalidate;
  end;
end;

procedure TTntDBLookupListBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    SearchText := '';
    if not FPopup then
    begin
      SetFocus;
      if not HasFocus then Exit;
    end;
    if CanModify then
      if ssDouble in Shift then
      begin
        if FRecordIndex = Y div GetTextHeight then DblClick;
      end else
      begin
        MouseCapture := True;
        FTracking := True;
        SelectItemAt(X, Y);
      end;
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TTntDBLookupListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if FTracking then
  begin
    SelectItemAt(X, Y);
    FMousePos := Y;
    TimerScroll;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TTntDBLookupListBox.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if FTracking then
  begin
    StopTracking;
    SelectItemAt(X, Y);
  end;
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TTntDBLookupListBox.Paint;
var
  I, J, W, X, TextWidth, TextHeight, LastFieldIndex: Integer;
  S: WideString;
  R: TRect;
  Selected: Boolean;
  Field: TField;
  AAlignment: TAlignment;
begin
  Canvas.Font := Font;
  TextWidth := Canvas.TextWidth('0');
  TextHeight := Canvas.TextHeight('0');
  LastFieldIndex := ListFields.Count - 1;
  if ColorToRGB(Color) <> ColorToRGB(clBtnFace) then
    Canvas.Pen.Color := clBtnFace else
    Canvas.Pen.Color := clBtnShadow;
  for I := 0 to FRowCount - 1 do
  begin
    if Enabled then
      Canvas.Font.Color := Font.Color else
      Canvas.Font.Color := clGrayText;
    Canvas.Brush.Color := Color;
    Selected := not FKeySelected and (I = 0);
    R.Top := I * TextHeight;
    R.Bottom := R.Top + TextHeight;
    if I < FRecordCount then
    begin
      ListLink.ActiveRecord := I;
      if not VarIsNull(FKeyValue) and
        VarEquals(FKeyField.Value, FKeyValue) then
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
          W := Field.DisplayWidth * TextWidth + 4 else
          W := ClientWidth - R.Right;
        S := GetWideDisplayText(Field){.DisplayText};
        X := 2;
        AAlignment := Field.Alignment;
        if UseRightToLeftAlignment then ChangeBiDiModeAlignment(AAlignment);
        case AAlignment of
          taRightJustify: X := W - WideCanvasTextWidth(Canvas, S){Canvas.TextWidth(S)} - 3;
          taCenter: X := (W - WideCanvasTextWidth(Canvas, S){Canvas.TextWidth(S)}) div 2;
        end;
        R.Left := R.Right;
        R.Right := R.Right + W;
        if SysLocale.MiddleEast then TControlCanvas(Canvas).UpdateTextFlags;
        //Canvas.TextRect(R, R.Left + X, R.Top, S);
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
    if Selected and (HasFocus or FPopup) then
      Canvas.DrawFocusRect(R);
  end;
  if FRecordCount <> 0 then ListLink.ActiveRecord := FRecordIndex;
end;

procedure TTntDBLookupListBox.SelectCurrent;
begin
  FLockPosition := True;
  try
    SelectKeyValue(FKeyField.Value);
  finally
    FLockPosition := False;
  end;
end;

procedure TTntDBLookupListBox.SelectItemAt(X, Y: Integer);
var
  Delta: Integer;
begin
  if Y < 0 then Y := 0;
  if Y >= ClientHeight then Y := ClientHeight - 1;
  Delta := Y div GetTextHeight - FRecordIndex;
  ListLink.DataSet.MoveBy(Delta);
  SelectCurrent;
end;

procedure TTntDBLookupListBox.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
    RowCount := RowCount;
  end;
end;

procedure TTntDBLookupListBox.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  BorderSize, TextHeight, Rows: Integer;
begin
  BorderSize := GetBorderSize;
  TextHeight := GetTextHeight;
  Rows := (AHeight - BorderSize) div TextHeight;
  if Rows < 1 then Rows := 1;
  FRowCount := Rows;
  if ListLink.BufferCount <> Rows then
  begin
    ListLink.BufferCount := Rows;
    ListLinkDataChanged;
  end;
  inherited SetBounds(ALeft, ATop, AWidth, Rows * TextHeight + BorderSize);
end;

function TTntDBLookupListBox.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TTntDBLookupListBox.SetRowCount(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if Value > 100 then Value := 100;
  Height := Value * GetTextHeight + GetBorderSize;
end;

procedure TTntDBLookupListBox.StopTimer;
begin
  if FTimerActive then
  begin
    KillTimer(Handle, 1);
    FTimerActive := False;
  end;
end;

procedure TTntDBLookupListBox.StopTracking;
begin
  if FTracking then
  begin
    StopTimer;
    FTracking := False;
    MouseCapture := False;
  end;
end;

procedure TTntDBLookupListBox.TimerScroll;
var
  Delta, Distance, Interval: Integer;
begin
  Delta := 0;
  Distance := 0;
  if FMousePos < 0 then
  begin
    Delta := -1;
    Distance := -FMousePos;
  end;
  if FMousePos >= ClientHeight then
  begin
    Delta := 1;
    Distance := FMousePos - ClientHeight + 1;
  end;
  if Delta = 0 then StopTimer else
  begin
    if ListLink.DataSet.MoveBy(Delta) <> 0 then SelectCurrent;
    Interval := 200 - Distance * 15;
    if Interval < 0 then Interval := 0;
    SetTimer(Handle, 1, Interval, nil);
    FTimerActive := True;
  end;
end;

procedure TTntDBLookupListBox.UpdateScrollBar;
var
  Pos, Max: Integer;
  ScrollInfo: TScrollInfo;
begin
  Pos := 0;
  Max := 0;
  if FRecordCount = FRowCount then
  begin
    Max := 4;
    if not ListLink.DataSet.BOF then
      if not ListLink.DataSet.EOF then Pos := 2 else Pos := 4;
  end;
  ScrollInfo.cbSize := SizeOf(TScrollInfo);
  ScrollInfo.fMask := SIF_POS or SIF_RANGE;
  if not GetScrollInfo(Handle, SB_VERT, ScrollInfo) or
    (ScrollInfo.nPos <> Pos) or (ScrollInfo.nMax <> Max) then
  begin
    ScrollInfo.nMin := 0;
    ScrollInfo.nMax := Max;
    ScrollInfo.nPos := Pos;
    SetScrollInfo(Handle, SB_VERT, ScrollInfo, True);
  end;
end;

procedure TTntDBLookupListBox.CMCtl3DChanged(var Message: TMessage);
begin
  if NewStyleControls and (FBorderStyle = bsSingle) then
  begin
    RecreateWnd;
    RowCount := RowCount;
  end;
  inherited;
end;

procedure TTntDBLookupListBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  Height := Height;
end;

procedure TTntDBLookupListBox.WMCancelMode(var Message: TMessage);
begin
  StopTracking;
  inherited;
end;

procedure TTntDBLookupListBox.WMTimer(var Message: TMessage);
begin
  TimerScroll;
end;

procedure TTntDBLookupListBox.WMVScroll(var Message: TWMVScroll);
begin
  SearchText := '';
  if ListLink.DataSet = nil then
    Exit;
  with Message, ListLink.DataSet do
    case ScrollCode of
      SB_LINEUP: MoveBy(-FRecordIndex - 1);
      SB_LINEDOWN: MoveBy(FRecordCount - FRecordIndex);
      SB_PAGEUP: MoveBy(-FRecordIndex - FRecordCount + 1);
      SB_PAGEDOWN: MoveBy(FRecordCount - FRecordIndex + FRecordCount - 2);
      SB_THUMBPOSITION:
        begin
          case Pos of
            0: First;
            1: MoveBy(-FRecordIndex - FRecordCount + 1);
            2: Exit;
            3: MoveBy(FRecordCount - FRecordIndex + FRecordCount - 2);
            4: Last;
          end;
        end;
      SB_BOTTOM: Last;
      SB_TOP: First;
    end;
end;

function TTntDBLookupListBox.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TTntDBLookupListBox.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TTntDBLookupListBox.ActionChange(Sender: TObject;
  CheckDefaults: Boolean);
begin
  TntControl_BeforeInherited_ActionChange(Self, Sender, CheckDefaults);
  inherited;
end;

procedure TTntDBLookupListBox.CreateWindowHandle(
  const Params: TCreateParams);
begin
  CreateUnicodeHandle(Self, Params, '');
end;

procedure TTntDBLookupListBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntDBLookupListBox.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TntControl_GetActionLinkClass(Self, inherited GetActionLinkClass);
end;

function TTntDBLookupListBox.GetHint: WideString;
begin
  Result := TntControl_GetHint(Self);
end;

function TTntDBLookupListBox.IsHintStored: Boolean;
begin
  Result := TntControl_IsHintStored(Self);
end;

procedure TTntDBLookupListBox.SetHint(const Value: WideString);
begin
  TntControl_SetHint(Self, Value);
end;

{ TTntPopupDataList }

constructor TTntPopupDataList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csNoDesignVisible, csReplicatable];
  FPopup := True;
end;

procedure TTntPopupDataList.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP or WS_BORDER;
    ExStyle := WS_EX_TOOLWINDOW;
    AddBiDiModeExStyle(ExStyle);
    WindowClass.Style := CS_SAVEBITS;
  end;
end;

procedure TTntPopupDataList.WMMouseActivate(var Message: TMessage);
begin
  Message.Result := MA_NOACTIVATE;
end;

{ TTntDBLookupComboBox }

constructor TTntDBLookupComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  Width := 145;
  Height := 0;
  FDataList := TTntPopupDataList.Create(Self);
  FDataList.Visible := False;
  FDataList.Parent := Self;
  FDataList.OnMouseUp := ListMouseUp;
  FButtonWidth := GetSystemMetrics(SM_CXVSCROLL);
  FDropDownRows := 7;
end;

procedure TTntDBLookupComboBox.CloseUp(Accept: Boolean);
var
  ListValue: Variant;
begin
  if FListVisible then
  begin
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    SetFocus;
    ListValue := FDataList.KeyValue;
    SetWindowPos(FDataList.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    FListVisible := False;
    FDataList.ListSource := nil;
    Invalidate;
    SearchText := '';
    if Accept and CanModify then SelectKeyValue(ListValue);
    if Assigned(FOnCloseUp) then FOnCloseUp(Self);
  end;
end;

procedure TTntDBLookupComboBox.CMBiDiModeChanged(var Message: TMessage);
begin
  inherited;
  FDataList.BiDiMode := BiDiMode;
end;

procedure TTntDBLookupComboBox.CMDialogKey(var Message: TCMDialogKey);
begin
  if (Message.CharCode in [VK_RETURN, VK_ESCAPE]) and FListVisible then
  begin
    CloseUp(Message.CharCode = VK_RETURN);
    Message.Result := 1;
  end else
    inherited;
end;

procedure TTntDBLookupComboBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    if NewStyleControls and Ctl3D then
      ExStyle := ExStyle or WS_EX_CLIENTEDGE
    else
      Style := Style or WS_BORDER;
end;

procedure TTntDBLookupComboBox.DropDown;
var
  P: TPoint;
  I, Y: Integer;
  S: String;
  ADropDownAlign: TDropDownAlign;
begin
  if not FListVisible and ListActive then
  begin
    if Assigned(FOnDropDown) then FOnDropDown(Self);
    FDataList.Color := Color;
    FDataList.Font := Font;
    if FDropDownWidth > 0 then
      FDataList.Width := FDropDownWidth else
      FDataList.Width := Width;
    FDataList.ReadOnly := not CanModify;
    if (ListLink.DataSet.RecordCount > 0) and
       (FDropDownRows > ListLink.DataSet.RecordCount) then
      FDataList.RowCount := ListLink.DataSet.RecordCount else
      FDataList.RowCount := FDropDownRows;
    FDataList.KeyField := FKeyFieldName;
    for I := 0 to ListFields.Count - 1 do
      S := S + TField(ListFields[I]).FieldName + ';';
    FDataList.ListField := S;
    FDataList.ListFieldIndex := ListFields.IndexOf(FListField);
    FDataList.ListSource := ListLink.DataSource;
    FDataList.KeyValue := KeyValue;
    P := Parent.ClientToScreen(Point(Left, Top));
    Y := P.Y + Height;
    if Y + FDataList.Height > Screen.Height then Y := P.Y - FDataList.Height;
    ADropDownAlign := FDropDownAlign;
    { This alignment is for the ListField, not the control }
    if DBUseRightToLeftAlignment(Self, FListField) then
    begin
      if ADropDownAlign = daLeft then
        ADropDownAlign := daRight
      else if ADropDownAlign = daRight then
        ADropDownAlign := daLeft;
    end;
    case ADropDownAlign of
      daRight: Dec(P.X, FDataList.Width - Width);
      daCenter: Dec(P.X, (FDataList.Width - Width) div 2);
    end;
    SetWindowPos(FDataList.Handle, HWND_TOP, P.X, Y, 0, 0,
      SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
    FListVisible := True;
    Repaint;
  end;
end;

procedure TTntDBLookupComboBox.KeyDown(var Key: Word; Shift: TShiftState);
var
  Delta: Integer;
begin
  inherited KeyDown(Key, Shift);
  if ListActive and ((Key = VK_UP) or (Key = VK_DOWN)) then
    if ssAlt in Shift then
    begin
      if FListVisible then CloseUp(True) else DropDown;
      Key := 0;
    end else
      if not FListVisible then
      begin
        if not LocateKey then
          ListLink.DataSet.First
        else
        begin
          if Key = VK_UP then Delta := -1 else Delta := 1;
          ListLink.DataSet.MoveBy(Delta);
        end;
        SelectKeyValue(FKeyField.Value);
        Key := 0;
      end;
  if (Key <> 0) and FListVisible then FDataList.KeyDown(Key, Shift);
end;

procedure TTntDBLookupComboBox.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if FListVisible then
    if Key in [#13, #27] then
      CloseUp(Key = #13)
    else
      FDataList.KeyPress(Key)
  else
    ProcessSearchKey(Key);
end;

procedure TTntDBLookupComboBox.KeyValueChanged;
begin
  if FLookupMode then
  begin
    FText := GetWideDisplayText(FDataField){.DisplayText};
    FAlignment := FDataField.Alignment;
  end else
  if ListActive and LocateKey then
  begin
    FText := GetWideDisplayText(FListField){.DisplayText};
    FAlignment := FListField.Alignment;
  end else
  begin
    FText := '';
    FAlignment := taLeftJustify;
  end;
  Invalidate;
end;

procedure TTntDBLookupComboBox.UpdateListFields;
begin
  inherited;
  KeyValueChanged;
end;

procedure TTntDBLookupComboBox.ListMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    CloseUp(PtInRect(FDataList.ClientRect, Point(X, Y)));
end;

procedure TTntDBLookupComboBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    SetFocus;
    if not HasFocus then Exit;
    if FListVisible then CloseUp(False) else
      if ListActive then
      begin
        MouseCapture := True;
        FTracking := True;
        TrackButton(X, Y);
        DropDown;
      end;
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TTntDBLookupComboBox.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  ListPos: TPoint;
  MousePos: TSmallPoint;
begin
  if FTracking then
  begin
    TrackButton(X, Y);
    if FListVisible then
    begin
      ListPos := FDataList.ScreenToClient(ClientToScreen(Point(X, Y)));
      if PtInRect(FDataList.ClientRect, ListPos) then
      begin
        StopTracking;
        MousePos := PointToSmallPoint(ListPos);
        SendMessage(FDataList.Handle, WM_LBUTTONDOWN, 0, Integer(MousePos));
        Exit;
      end;
    end;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TTntDBLookupComboBox.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  StopTracking;
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TTntDBLookupComboBox.Paint;
var
  W, X, Flags: Integer;
  Text: WideString;
  AAlignment: TAlignment;
  Selected: Boolean;
  R: TRect;
  {$IFDEF DELPHI_7_UP}
  State : TThemedComboBox;
  Details: TThemedElementDetails;
  {$ENDIF}  
begin
  Canvas.Font := Font;
  Canvas.Brush.Color := Color;
  Selected := HasFocus and not FListVisible and
    not (csPaintCopy in ControlState);
  if Enabled then
    Canvas.Font.Color := Font.Color
  else
    Canvas.Font.Color := clGrayText;
  if Selected then
  begin
    Canvas.Font.Color := clHighlightText;
    Canvas.Brush.Color := clHighlight;
  end;
  if (csPaintCopy in ControlState) and (FDataField <> nil) and
    (FDataField.Lookup) then
  begin
    Text := GetWideDisplayText(FDataField){.DisplayText};
    AAlignment := FDataField.Alignment;
  end else
  begin
    if (csDesigning in ComponentState) and (FDataField = nil) then
      Text := Name else
      Text := FText;
    AAlignment := FAlignment;
  end;
  if UseRightToLeftAlignment then ChangeBiDiModeAlignment(AAlignment);
  W := ClientWidth - FButtonWidth;
  X := 2;
  case AAlignment of
    taRightJustify: X := W - WideCanvasTextWidth(Canvas, Text){Canvas.TextWidth(Text)} - 3;
    taCenter: X := (W - WideCanvasTextWidth(Canvas, Text){Canvas.TextWidth(Text)}) div 2;
  end;
  SetRect(R, 1, 1, W - 1, ClientHeight - 1);
  if (SysLocale.MiddleEast) and (BiDiMode = bdRightToLeft) then
  begin
    Inc(X, FButtonWidth);
    Inc(R.Left, FButtonWidth);
    R.Right := ClientWidth;
  end;
  if SysLocale.MiddleEast then TControlCanvas(Canvas).UpdateTextFlags;
  //Canvas.TextRect(R, X, 2, Text);
  WideCanvasTextRect(Canvas, R, X, 2, Text);
  if Selected then Canvas.DrawFocusRect(R);
  SetRect(R, W, 0, ClientWidth, ClientHeight);
  if (SysLocale.MiddleEast) and (BiDiMode = bdRightToLeft) then
  begin
    R.Left := 0;
    R.Right:= FButtonWidth;
  end;

  {$IFDEF DELPHI_7_UP}
  if ThemeServices.ThemesEnabled then
  begin
    if not ListActive then
      State := tcDropDownButtonDisabled
    else
      if FPressed then
        State := tcDropDownButtonPressed
      else
        if FMouseInControl and not FListVisible then
          State := tcDropDownButtonHot
        else
          State := tcDropDownButtonNormal;
    Details := ThemeServices.GetElementDetails(State);
    ThemeServices.DrawElement(Canvas.Handle, Details, R);
  end
  else 
  {$ENDIF} 
  begin
    if not (ListActive and Enabled) then
      Flags := DFCS_SCROLLCOMBOBOX or DFCS_INACTIVE
    else if FPressed then
      Flags := DFCS_SCROLLCOMBOBOX or DFCS_FLAT or DFCS_PUSHED
    else
      Flags := DFCS_SCROLLCOMBOBOX;
    DrawFrameControl(Canvas.Handle, R, DFC_SCROLL, Flags);
  end;
end;

procedure TTntDBLookupComboBox.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, GetTextHeight + GetBorderSize + 4);
end;

function TTntDBLookupComboBox.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TTntDBLookupComboBox.StopTracking;
begin
  if FTracking then
  begin
    TrackButton(-1, -1);
    FTracking := False;
    MouseCapture := False;
  end;
end;

procedure TTntDBLookupComboBox.TrackButton(X, Y: Integer);
var
  NewState: Boolean;
begin
  NewState := PtInRect(Rect(ClientWidth - FButtonWidth, 0, ClientWidth,
    ClientHeight), Point(X, Y));
  if FPressed <> NewState then
  begin
    FPressed := NewState;
    Repaint;
  end;
end;

procedure TTntDBLookupComboBox.CMCancelMode(var Message: TCMCancelMode);
begin
  if (Message.Sender <> Self) and (Message.Sender <> FDataList) then
    CloseUp(False);
end;

procedure TTntDBLookupComboBox.CMCtl3DChanged(var Message: TMessage);
begin
  if NewStyleControls then
  begin
    RecreateWnd;
    Height := 0;
  end;
  inherited;
end;

procedure TTntDBLookupComboBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  Height := 0;
end;

procedure TTntDBLookupComboBox.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

procedure TTntDBLookupComboBox.WMCancelMode(var Message: TMessage);
begin
  StopTracking;
  inherited;
end;

procedure TTntDBLookupComboBox.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  CloseUp(False);
end;

function TTntDBLookupComboBox.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TTntDBLookupComboBox.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TTntDBLookupComboBox.CMMouseEnter(var Message: TMessage);
begin  
  {Windows XP themes use hot track states, hence we have to update the drop down button.}
  {$IFDEF DELPHI_7_UP}
  if ThemeServices.ThemesEnabled and not (FMouseInControl) and not (csDesigning in ComponentState) then
  begin
    FMouseInControl := True;
    Invalidate;
  end;
  {$ENDIF}
  inherited;
end;

procedure TTntDBLookupComboBox.CMMouseLeave(var Message: TMessage);
begin
  {$IFDEF DELPHI_7_UP}  
  if ThemeServices.ThemesEnabled and FMouseInControl then
  begin
    FMouseInControl := False;
    Invalidate;
  end;
  {$ENDIF}
  inherited;
end;

function TTntDBLookupComboBox.GetHint: WideString;
begin
  Result := TntControl_GetHint(Self);
end;

procedure TTntDBLookupComboBox.SetHint(const Value: WideString);
begin
  TntControl_SetHint(Self, Value);
end;

function TTntDBLookupComboBox.IsHintStored: Boolean;
begin
  Result := TntControl_IsHintStored(Self);
end;

procedure TTntDBLookupComboBox.CreateWindowHandle(
  const Params: TCreateParams);
begin
  CreateUnicodeHandle(Self, Params, '');
end;

procedure TTntDBLookupComboBox.ActionChange(Sender: TObject;
  CheckDefaults: Boolean);
begin
  TntControl_BeforeInherited_ActionChange(Self, Sender, CheckDefaults);
  inherited;
end;

procedure TTntDBLookupComboBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntDBLookupComboBox.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TntControl_GetActionLinkClass(Self, inherited GetActionLinkClass);
end;

{ TTntDBMaskEdit}

procedure TTntDBMaskEdit.ResetMaxLength;
var
  F: TField;
begin
  if (MaxLength > 0) and Assigned(DataSource) and Assigned(DataSource.DataSet) then
  begin
    F := DataSource.DataSet.FindField(DataField);
    if Assigned(F) and (F.DataType in [ftString, ftWideString]) and (F.Size = MaxLength) then
      MaxLength := 0;
  end;
end;

constructor TTntDBMaskEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := True;
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnActiveChange := ActiveChange;
end;

destructor TTntDBMaskEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TTntDBMaskEdit.Loaded;
begin
  inherited Loaded;
  ResetMaxLength;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TTntDBMaskEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

function TTntDBMaskEdit.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TTntDBMaskEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) then
    FDataLink.Edit;
end;

procedure TTntDBMaskEdit.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if (Key in [#32..#255]) and (FDataLink.Field <> nil) and
    not FDataLink.Field.IsValidChar(Key) then
  begin
    MessageBeep(0);
    Key := #0;
  end;
  case Key of
    ^H, ^V, ^X, #32..#255:
      FDataLink.Edit;
    #27:
      begin
        FDataLink.Reset;
        SelectAll;
        Key := #0;
      end;
  end;
end;

function TTntDBMaskEdit.EditCanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;

procedure TTntDBMaskEdit.Reset;
begin
  FDataLink.Reset;
  SelectAll;
end;

procedure TTntDBMaskEdit.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if (FAlignment <> taLeftJustify) and not IsMasked then Invalidate;
    FDataLink.Reset;
  end;
end;

procedure TTntDBMaskEdit.Change;
begin
  FDataLink.Modified;
  inherited Change;
end;

function TTntDBMaskEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TTntDBMaskEdit.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TTntDBMaskEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TTntDBMaskEdit.SetDataField(const Value: string);
begin
  if not (csDesigning in ComponentState) then
    ResetMaxLength;
  FDataLink.FieldName := Value;
end;

function TTntDBMaskEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TTntDBMaskEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TTntDBMaskEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TTntDBMaskEdit.ActiveChange(Sender: TObject);
begin
  ResetMaxLength;
end;

procedure TTntDBMaskEdit.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
  begin
    if FAlignment <> FDataLink.Field.Alignment then
    begin
      EditText := '';  {forces update}
      FAlignment := FDataLink.Field.Alignment;
    end;

    if (FDataLink.Field.EditMask <> '') and (FDataLink.Field.EditMask <> EditMask) and ((EditMask = '') or FIsFieldEditMask) then
    begin
      FinternalEditMaskChange := True;
      EditMask := FDataLink.Field.EditMask;
      FinternalEditMaskChange := False;
    end;  
      
    if not (csDesigning in ComponentState) then
    begin
      if (FDataLink.Field.DataType in [ftString, ftWideString]) and (MaxLength = 0) then
        MaxLength := FDataLink.Field.Size;
    end;
    if FFocused and FDataLink.CanModify then
      Text := GetWideText(FDataLink.Field)
    else
    begin
      EditText := GetWideText(FDataLink.Field);
      if FDataLink.Editing and THackFieldDataLink(FDataLink).FModified then
        Modified := True;
    end;
  end else
  begin
    FAlignment := taLeftJustify;
    //EditMask := '';
    if csDesigning in ComponentState then
      EditText := Name else
      EditText := '';
  end;
end;

procedure TTntDBMaskEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

procedure TTntDBMaskEdit.UpdateData(Sender: TObject);
begin
  ValidateEdit;
  SetWideText(FDataLink.Field, Text);
end;

procedure TTntDBMaskEdit.WMUndo(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TTntDBMaskEdit.WMPaste(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TTntDBMaskEdit.WMCut(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TTntDBMaskEdit.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);
  inherited;
  if SysLocale.FarEast and FDataLink.CanModify then
    inherited ReadOnly := False;
end;

procedure TTntDBMaskEdit.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  SetFocused(False);
  CheckCursor;
  DoExit;
end;

procedure TTntDBMaskEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TTntDBMaskEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TTntDBMaskEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TTntDBMaskEdit.SetEditMask(const Value: TEditMask);
begin
  inherited;
  FIsFieldEditMask := FinternalEditMaskChange;
end;

{$ENDIF}

end.
