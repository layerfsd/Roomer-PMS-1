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

unit TntExtCtrls;

{$INCLUDE TntCompilers.inc}

{$IFDEF DELPHI_UNICODE}

interface

uses
  ExtCtrls;

type
  TTntShape = class(TShape);
  TTntPaintBox = class(TPaintBox);
  TTntImage = class(TImage);
  TTntBevel = class(TBevel);
  TTntCustomPanel = TCustomPanel;
  TTntPanel = class(TPanel);
  TTntCustomControlBar = TCustomControlBar;
  TTntControlBar = class(TControlBar);
  TTntCustomRadioGroup = TCustomRadioGroup;
  TTntRadioGroup = class(TRadioGroup);
  TTntSplitter = class(TSplitter);
  TTntLabeledEdit = class(TLabeledEdit);
  TTntTrayIcon = class(TTrayIcon);

implementation

{$ENDIF}

{$IFNDEF DELPHI_UNICODE}


interface

uses
  Classes, Messages, Controls, ExtCtrls, TntClasses, TntControls, TntStdCtrls, 
  TntGraphics, ShellAPI, Graphics, Windows, Menus; 

type
{TNT-WARN TShape}
  TTntShape = class(TShape{TNT-ALLOW TShape})
  private
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    function IsHintStored: Boolean;
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    function GetActionLinkClass: TControlActionLinkClass; override;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
  published
    property Hint: WideString read GetHint write SetHint stored IsHintStored;
  end;

{TNT-WARN TPaintBox}
  TTntPaintBox = class(TPaintBox{TNT-ALLOW TPaintBox})
  private
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    function IsHintStored: Boolean;
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    function GetActionLinkClass: TControlActionLinkClass; override;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
  published
    property Hint: WideString read GetHint write SetHint stored IsHintStored;
  end;

{TNT-WARN TImage}
  TTntImage = class(TImage{TNT-ALLOW TImage})
  private
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    function IsHintStored: Boolean;
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
    function GetPicture: TTntPicture;
    procedure SetPicture(const Value: TTntPicture);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    function GetActionLinkClass: TControlActionLinkClass; override;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Hint: WideString read GetHint write SetHint stored IsHintStored;
    property Picture: TTntPicture read GetPicture write SetPicture;
  end;

{TNT-WARN TBevel}
  TTntBevel = class(TBevel{TNT-ALLOW TBevel})
  private
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    function IsHintStored: Boolean;
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    function GetActionLinkClass: TControlActionLinkClass; override;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
  published
    property Hint: WideString read GetHint write SetHint stored IsHintStored;
  end;

{TNT-WARN TCustomPanel}
  TTntCustomPanel = class(TCustomPanel{TNT-ALLOW TCustomPanel})
  private
    function GetCaption: TWideCaption;
    procedure SetCaption(const Value: TWideCaption);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    function IsCaptionStored: Boolean;
    function IsHintStored: Boolean;
  protected
    procedure Paint; override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure DefineProperties(Filer: TFiler); override;
    function GetActionLinkClass: TControlActionLinkClass; override;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    property Caption: TWideCaption read GetCaption write SetCaption stored IsCaptionStored;
  published
    property Hint: WideString read GetHint write SetHint stored IsHintStored;
  end;

{TNT-WARN TPanel}
  TTntPanel = class(TTntCustomPanel)
  public
    property DockManager;
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderWidth;
    property BorderStyle;
    property Caption;
    property Color;
    property Constraints;
    property Ctl3D;
    property UseDockManager default True;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FullRepaint;
    property Font;
    property Locked;
    {$IFDEF COMPILER_10_UP}
    property Padding;
    {$ENDIF}
    property ParentBiDiMode;
    {$IFDEF COMPILER_7_UP}
    property ParentBackground;
    {$ENDIF}
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    {$IFDEF COMPILER_9_UP}
    property VerticalAlignment;
    {$ENDIF}
    property Visible;
    {$IFDEF COMPILER_9_UP}
    property OnAlignInsertBefore;
    property OnAlignPosition;
    {$ENDIF}
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
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
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

{TNT-WARN TCustomControlBar}
  TTntCustomControlBar = class(TCustomControlBar{TNT-ALLOW TCustomControlBar})
  private
    function IsHintStored: Boolean;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure DefineProperties(Filer: TFiler); override;
    function GetActionLinkClass: TControlActionLinkClass; override;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
  published
    property Hint: WideString read GetHint write SetHint stored IsHintStored;
  end;

{TNT-WARN TControlBar}
  TTntControlBar = class(TTntCustomControlBar)
  public
    property Canvas;
  published
    property Align;
    property Anchors;
    property AutoDock;
    property AutoDrag;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BorderWidth;
    property Color {$IFDEF COMPILER_7_UP} nodefault {$ENDIF};
    property Constraints;
    {$IFDEF COMPILER_10_UP}
    property CornerEdge;
    {$ENDIF}
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    {$IFDEF COMPILER_10_UP}
    property DrawingStyle;
    {$ENDIF}
    property Enabled;
    {$IFDEF COMPILER_10_UP}
    property GradientDirection;
    property GradientEndColor;
    property GradientStartColor;
    {$ENDIF}
    {$IFDEF COMPILER_7_UP}
    property ParentBackground default True;
    {$ENDIF}
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property Picture;
    property PopupMenu;
    property RowSize;
    property RowSnap;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    {$IFDEF COMPILER_9_UP}
    property OnAlignInsertBefore;
    property OnAlignPosition;
    {$ENDIF}
    property OnBandDrag;
    property OnBandInfo;
    property OnBandMove;
    property OnBandPaint;
    {$IFDEF COMPILER_9_UP}
    property OnBeginBandMove;
    property OnEndBandMove;
    {$ENDIF}
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
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
    property OnPaint;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

{TNT-WARN TCustomRadioGroup}
  TTntCustomRadioGroup = class(TTntCustomGroupBox)
  private
    FButtons: TList;
    FItems: TTntStrings;
    FItemIndex: Integer;
    FColumns: Integer;
    FReading: Boolean;
    FUpdating: Boolean;
    function GetButtons(Index: Integer): TTntRadioButton;
    procedure ArrangeButtons;
    procedure ButtonClick(Sender: TObject);
    procedure ItemsChange(Sender: TObject);
    procedure SetButtonCount(Value: Integer);
    procedure SetColumns(Value: Integer);
    procedure SetItemIndex(Value: Integer);
    procedure SetItems(Value: TTntStrings);
    procedure UpdateButtons;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  protected
    procedure Loaded; override;
    procedure ReadState(Reader: TReader); override;
    function CanModify: Boolean; virtual;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    property Columns: Integer read FColumns write SetColumns default 1;
    property ItemIndex: Integer read FItemIndex write SetItemIndex default -1;
    property Items: TTntStrings read FItems write SetItems;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure FlipChildren(AllLevels: Boolean); override;
    property Buttons[Index: Integer]: TTntRadioButton read GetButtons;
  end;

{TNT-WARN TRadioGroup}
  TTntRadioGroup = class(TTntCustomRadioGroup)
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Color;
    property Columns;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ItemIndex;
    property Items;
    property Constraints;
    property ParentBiDiMode;
    {$IFDEF COMPILER_7_UP}
    property ParentBackground default True;
    {$ENDIF}
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDock;
    property OnStartDrag;
  end;

{TNT-WARN TSplitter}
  TTntSplitter = class(TSplitter{TNT-ALLOW TSplitter})
  private
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    function IsHintStored: Boolean;
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    function GetActionLinkClass: TControlActionLinkClass; override;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
  published
    property Hint: WideString read GetHint write SetHint stored IsHintStored;
  end;

  TTntBoundLabel = class(TTntCustomLabel)
  private
    function GetTop: Integer;
    function GetLeft: Integer;
    function GetWidth: Integer;
    function GetHeight: Integer;
    procedure SetHeight(const Value: Integer);
    procedure SetWidth(const Value: Integer);
  protected
    procedure AdjustBounds; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property BiDiMode;
    property Caption;
    property Color;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Font;
    property Height: Integer read GetHeight write SetHeight;
    property Left: Integer read GetLeft;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowAccelChar;
    property ShowHint;
    property Top: Integer read GetTop;
    property Transparent;
    property Layout;
    property WordWrap;
    property Width: Integer read GetWidth write SetWidth;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  TTntCustomLabeledEdit = class(TTntCustomEdit)
  private
    FEditLabel: TTntBoundLabel;
    FLabelPosition: TLabelPosition;
    FLabelSpacing: Integer;
    procedure SetLabelPosition(const Value: TLabelPosition);
    procedure SetLabelSpacing(const Value: Integer);
  protected
    procedure SetParent(AParent: TWinControl); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const Value: TComponentName); override;
    procedure CMVisiblechanged(var Message: TMessage);
      message CM_VISIBLECHANGED;
    procedure CMEnabledchanged(var Message: TMessage);
      message CM_ENABLEDCHANGED;
    procedure CMBidimodechanged(var Message: TMessage);
      message CM_BIDIMODECHANGED;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
    procedure SetupInternalLabel;
    property EditLabel: TTntBoundLabel read FEditLabel;
    property LabelPosition: TLabelPosition read FLabelPosition write SetLabelPosition;
    property LabelSpacing: Integer read FLabelSpacing write SetLabelSpacing;
  end;

  TTntLabeledEdit = class(TTntCustomLabeledEdit)
  published
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property BiDiMode;
    property BorderStyle;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property EditLabel;
    property Enabled;
    property Font;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property LabelPosition default lpAbove;
    property LabelSpacing default 3;
    property MaxLength;
    property OEMConvert;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
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
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  {$IFDEF DELPHI_10}
  TTntTrayIcon = class(TComponent)
  private
    FAnimate: Boolean;
    FData: Shellapi.TNotifyIconDataW;
    FDataA: Shellapi.TNotifyIconDataA;
    FIsClicked: Boolean;
    FCurrentIcon: TIcon;
    FIcon: TIcon;
    FIconList: TImageList;
    FPopupMenu: TPopupMenu;
    FTimer: TTimer;
    FHint: WideString;
    FIconIndex: Integer;
    FVisible: Boolean;
    FOnMouseMove: TMouseMoveEvent;
    FOnClick: TNotifyEvent;
    FOnDblClick: TNotifyEvent;
    FOnMouseDown: TMouseEvent;
    FOnMouseUp: TMouseEvent;
    FOnAnimate: TNotifyEvent;
    FOnBalloonHintShow: TNotifyEvent;
    FOnBalloonHintHide: TNotifyEvent;
    FOnBalloonHintTimeout: TNotifyEvent;
    FOnBalloonHintClick: TNotifyEvent;
    FBalloonHint: WideString;
    FBalloonTitle: WideString;
    FBalloonFlags: TBalloonFlags;
    class var
      RM_TaskbarCreated: DWORD;
  protected
    //function IsBalloonHintStored: Boolean;
    //function IsBalloonTitleStored: Boolean;
    procedure SetHint(const Value: WideString);
    function GetAnimateInterval: Cardinal;
    procedure SetAnimateInterval(Value: Cardinal);
    procedure SetAnimate(Value: Boolean);
    procedure SetBalloonHint(const Value: WideString);
    function GetBalloonTimeout: Integer;
    procedure SetBalloonTimeout(Value: Integer);
    procedure SetBalloonTitle(const Value: WideString);
    procedure SetVisible(Value: Boolean); virtual;
    procedure SetIconIndex(Value: Integer); virtual;
    procedure SetIcon(Value: TIcon);
    procedure SetIconList(Value: TImageList);
    procedure WindowProc(var Message: TMessage); virtual;
    procedure DoOnAnimate(Sender: TObject); virtual;
    property Data: Shellapi.TNotifyIconDataW read FData;
    property DataA: Shellapi.TNotifyIconDataA read FDataA;
    function Refresh(Message: Integer): Boolean; overload;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure Refresh; overload;
    procedure SetDefaultIcon;
    procedure ShowBalloonHint; virtual;
  published
    property Animate: Boolean read FAnimate write SetAnimate default False;
    property AnimateInterval: Cardinal read GetAnimateInterval write SetAnimateInterval default 1000;
    property BalloonHint: WideString read FBalloonHint write SetBalloonHint;
    property BalloonTitle: WideString read FBalloonTitle write SetBalloonTitle;
    property BalloonTimeout: Integer read GetBalloonTimeout write SetBalloonTimeout default 3000;
    property BalloonFlags: TBalloonFlags read FBalloonFlags write FBalloonFlags default bfNone;
    property Hint: WideString read FHint write SetHint;
    property Icon: TIcon read FIcon write SetIcon;
    property Icons: TImageList read FIconList write SetIconList;
    property IconIndex: Integer read FIconIndex write SetIconIndex default 0;
    property PopupMenu: TPopupMenu read FPopupMenu write FPopupMenu;
    property Visible: Boolean read FVisible write SetVisible default False;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnMouseMove: TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseUp: TMouseEvent read FOnMouseUp write FOnMouseUp;
    property OnMouseDown: TMouseEvent read FOnMouseDown write FOnMouseDown;
    property OnAnimate: TNotifyEvent read FOnAnimate write FOnAnimate;
    property OnBalloonHintShow: TNotifyEvent read FOnBalloonHintShow write FOnBalloonHintShow;
    property OnBalloonHintHide: TNotifyEvent read FOnBalloonHintHide write FOnBalloonHintHide;
    property OnBalloonHintTimeout: TNotifyEvent read FOnBalloonHintTimeout write FOnBalloonHintTimeout;
    property OnBalloonHintClick: TNotifyEvent read FOnBalloonHintClick write FOnBalloonHintClick;
  end;
  {$ENDIF}


implementation

uses
  Consts, Forms, {$IFDEF THEME_7_UP} Themes, {$ENDIF}
  TntSysUtils, TntWindows, TntActnList, SysUtils
  {$IFDEF DELPHI_10}
  , WideStrUtils
  {$ENDIF}
  ;


{ TTntShape }

procedure TTntShape.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntShape.IsHintStored: Boolean;
begin
  Result := TntControl_IsHintStored(Self)
end;

function TTntShape.GetHint: WideString;
begin
  Result := TntControl_GetHint(Self)
end;

procedure TTntShape.SetHint(const Value: WideString);
begin
  TntControl_SetHint(Self, Value);
end;

procedure TTntShape.CMHintShow(var Message: TMessage);
begin
  ProcessCMHintShowMsg(Message);
  inherited;
end;

procedure TTntShape.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  TntControl_BeforeInherited_ActionChange(Self, Sender, CheckDefaults);
  inherited;
end;

function TTntShape.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TntControl_GetActionLinkClass(Self, inherited GetActionLinkClass);
end;

{ TTntPaintBox }

procedure TTntPaintBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntPaintBox.IsHintStored: Boolean;
begin
  Result := TntControl_IsHintStored(Self)
end;

function TTntPaintBox.GetHint: WideString;
begin
  Result := TntControl_GetHint(Self)
end;

procedure TTntPaintBox.SetHint(const Value: WideString);
begin
  TntControl_SetHint(Self, Value);
end;

procedure TTntPaintBox.CMHintShow(var Message: TMessage);
begin
  ProcessCMHintShowMsg(Message);
  inherited;
end;

procedure TTntPaintBox.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  TntControl_BeforeInherited_ActionChange(Self, Sender, CheckDefaults);
  inherited;
end;

function TTntPaintBox.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TntControl_GetActionLinkClass(Self, inherited GetActionLinkClass);
end;

type
{$IFDEF COMPILER_6}    // verified against VCL source in Delphi 6 and BCB 6
  THackImage = class(TGraphicControl)
  protected
    FPicture: TPicture{TNT-ALLOW TPicture};
  end;
{$ENDIF}
{$IFDEF DELPHI_7}      // verified against VCL source in Delphi 7
  THackImage = class(TGraphicControl)
  protected
    FPicture: TPicture{TNT-ALLOW TPicture};
  end;
{$ENDIF}
{$IFDEF DELPHI_9}      // verified against VCL source in Delphi 9
  THackImage = class(TGraphicControl)
  private
    FPicture: TPicture{TNT-ALLOW TPicture};
  end;
{$ENDIF}
{$IFDEF DELPHI_10}      // verified against VCL source in Delphi 10
  THackImage = class(TGraphicControl)
  private
    FPicture: TPicture{TNT-ALLOW TPicture};
  end;
{$ENDIF}

{ TTntImage }

constructor TTntImage.Create(AOwner: TComponent);
var
  OldPicture: TPicture{TNT-ALLOW TPicture};
begin
  inherited;
  OldPicture := THackImage(Self).FPicture;
  THackImage(Self).FPicture := TTntPicture.Create;
  Picture.OnChange := OldPicture.OnChange;
  Picture.OnProgress := OldPicture.OnProgress;
  OldPicture.Free;
end;

function TTntImage.GetPicture: TTntPicture;
begin
  Result := inherited Picture as TTntPicture;
end;

procedure TTntImage.SetPicture(const Value: TTntPicture);
begin
  inherited Picture := Value;
end;

procedure TTntImage.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntImage.IsHintStored: Boolean;
begin
  Result := TntControl_IsHintStored(Self)
end;

function TTntImage.GetHint: WideString;
begin
  Result := TntControl_GetHint(Self)
end;

procedure TTntImage.SetHint(const Value: WideString);
begin
  TntControl_SetHint(Self, Value);
end;

procedure TTntImage.CMHintShow(var Message: TMessage);
begin
  ProcessCMHintShowMsg(Message);
  inherited;
end;

procedure TTntImage.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  TntControl_BeforeInherited_ActionChange(Self, Sender, CheckDefaults);
  inherited;
end;

function TTntImage.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TntControl_GetActionLinkClass(Self, inherited GetActionLinkClass);
end;

{ TTntBevel }

procedure TTntBevel.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntBevel.IsHintStored: Boolean;
begin
  Result := TntControl_IsHintStored(Self)
end;

function TTntBevel.GetHint: WideString;
begin
  Result := TntControl_GetHint(Self)
end;

procedure TTntBevel.SetHint(const Value: WideString);
begin
  TntControl_SetHint(Self, Value);
end;

procedure TTntBevel.CMHintShow(var Message: TMessage);
begin
  ProcessCMHintShowMsg(Message);
  inherited;
end;

procedure TTntBevel.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  TntControl_BeforeInherited_ActionChange(Self, Sender, CheckDefaults);
  inherited;
end;

function TTntBevel.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TntControl_GetActionLinkClass(Self, inherited GetActionLinkClass);
end;

{ TTntCustomPanel }

procedure TTntCustomPanel.CreateWindowHandle(const Params: TCreateParams);
begin
  CreateUnicodeHandle(Self, Params, '');
end;

procedure TTntCustomPanel.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntCustomPanel.IsCaptionStored: Boolean;
begin
  Result := TntControl_IsCaptionStored(Self);
end;

function TTntCustomPanel.GetCaption: TWideCaption;
begin
  Result := TntControl_GetText(Self)
end;

procedure TTntCustomPanel.SetCaption(const Value: TWideCaption);
begin
  TntControl_SetText(Self, Value);
end;

procedure TTntCustomPanel.Paint;
const
  Alignments: array[TAlignment] of Longint = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  Rect: TRect;
  TopColor, BottomColor: TColor;
  FontHeight: Integer;
  Flags: Longint;

  procedure AdjustColors(Bevel: TPanelBevel);
  begin
    TopColor := clBtnHighlight;
    if Bevel = bvLowered then TopColor := clBtnShadow;
    BottomColor := clBtnShadow;
    if Bevel = bvLowered then BottomColor := clBtnHighlight;
  end;

begin
  if (not Win32PlatformIsUnicode) then
    inherited
  else begin
    Rect := GetClientRect;
    if BevelOuter <> bvNone then
    begin
      AdjustColors(BevelOuter);
      Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
    end;
    {$IFDEF THEME_7_UP}
    if ThemeServices.ThemesEnabled {$IFDEF COMPILER_7_UP} and ParentBackground {$ENDIF} then
      InflateRect(Rect, -BorderWidth, -BorderWidth)
    else
    {$ENDIF}
    begin
      Frame3D(Canvas, Rect, Color, Color, BorderWidth);
    end;
    if BevelInner <> bvNone then
    begin
      AdjustColors(BevelInner);
      Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
    end;
    with Canvas do
    begin
      {$IFDEF THEME_7_UP}
      if not ThemeServices.ThemesEnabled {$IFDEF COMPILER_7_UP} or not ParentBackground {$ENDIF} then
      {$ENDIF}
      begin
        Brush.Color := Color;
        FillRect(Rect);
      end;
      Brush.Style := bsClear;
      Font := Self.Font;
      FontHeight := WideCanvasTextHeight(Canvas, 'W');
      with Rect do
      begin
        Top := ((Bottom + Top) - FontHeight) div 2;
        Bottom := Top + FontHeight;
      end;
      Flags := DT_EXPANDTABS or DT_VCENTER or Alignments[Alignment];
      Flags := DrawTextBiDiModeFlags(Flags);
      Tnt_DrawTextW(Handle, PWideChar(Caption), -1, Rect, Flags);
    end;
  end;
end;

function TTntCustomPanel.IsHintStored: Boolean;
begin
  Result := TntControl_IsHintStored(Self)
end;

function TTntCustomPanel.GetHint: WideString;
begin
  Result := TntControl_GetHint(Self);
end;

procedure TTntCustomPanel.SetHint(const Value: WideString);
begin
  TntControl_SetHint(Self, Value);
end;

procedure TTntCustomPanel.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  TntControl_BeforeInherited_ActionChange(Self, Sender, CheckDefaults);
  inherited;
end;

function TTntCustomPanel.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TntControl_GetActionLinkClass(Self, inherited GetActionLinkClass);
end;

{ TTntCustomControlBar }

procedure TTntCustomControlBar.CreateWindowHandle(const Params: TCreateParams);
begin
  CreateUnicodeHandle(Self, Params, '');
end;

procedure TTntCustomControlBar.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntCustomControlBar.IsHintStored: Boolean;
begin
  Result := TntControl_IsHintStored(Self);
end;

function TTntCustomControlBar.GetHint: WideString;
begin
  Result := TntControl_GetHint(Self);
end;

procedure TTntCustomControlBar.SetHint(const Value: WideString);
begin
  TntControl_SetHint(Self, Value);
end;

procedure TTntCustomControlBar.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  TntControl_BeforeInherited_ActionChange(Self, Sender, CheckDefaults);
  inherited;
end;

function TTntCustomControlBar.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TntControl_GetActionLinkClass(Self, inherited GetActionLinkClass);
end;

{ TTntGroupButton }

type
  TTntGroupButton = class(TTntRadioButton)
  private
    FInClick: Boolean;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char{TNT-ALLOW Char}); override;
  public
    constructor InternalCreate(RadioGroup: TTntCustomRadioGroup);
    destructor Destroy; override;
  end;

constructor TTntGroupButton.InternalCreate(RadioGroup: TTntCustomRadioGroup);
begin
  inherited Create(RadioGroup);
  RadioGroup.FButtons.Add(Self);
  Visible := False;
  Enabled := RadioGroup.Enabled;
  ParentShowHint := False;
  OnClick := RadioGroup.ButtonClick;
  Parent := RadioGroup;
end;

destructor TTntGroupButton.Destroy;
begin
  TTntCustomRadioGroup(Owner).FButtons.Remove(Self);
  inherited Destroy;
end;

procedure TTntGroupButton.CNCommand(var Message: TWMCommand);
begin
  if not FInClick then
  begin
    FInClick := True;
    try
      if ((Message.NotifyCode = BN_CLICKED) or
        (Message.NotifyCode = BN_DOUBLECLICKED)) and
        TTntCustomRadioGroup(Parent).CanModify then
        inherited;
    except
      Application.HandleException(Self);
    end;
    FInClick := False;
  end;
end;

procedure TTntGroupButton.KeyPress(var Key: Char{TNT-ALLOW Char});
begin
  inherited KeyPress(Key);
  TTntCustomRadioGroup(Parent).KeyPress(Key);
  if (Key = #8) or (Key = ' ') then
  begin
    if not TTntCustomRadioGroup(Parent).CanModify then Key := #0;
  end;
end;

procedure TTntGroupButton.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  TTntCustomRadioGroup(Parent).KeyDown(Key, Shift);
end;

{ TTntCustomRadioGroup }

constructor TTntCustomRadioGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csSetCaption, csDoubleClicks {$IFDEF COMPILER_7_UP}, csParentBackground {$ENDIF}];
  FButtons := TList.Create;
  FItems := TTntStringList.Create;
  TTntStringList(FItems).OnChange := ItemsChange;
  FItemIndex := -1;
  FColumns := 1;
end;

destructor TTntCustomRadioGroup.Destroy;
begin
  SetButtonCount(0);
  TTntStringList(FItems).OnChange := nil;
  FItems.Free;
  FButtons.Free;
  inherited Destroy;
end;

procedure TTntCustomRadioGroup.FlipChildren(AllLevels: Boolean);
begin
  { The radio buttons are flipped using BiDiMode }
end;

procedure TTntCustomRadioGroup.ArrangeButtons;
var
  ButtonsPerCol, ButtonWidth, ButtonHeight, TopMargin, I: Integer;
  DC: HDC;
  SaveFont: HFont;
  Metrics: TTextMetric;
  DeferHandle: THandle;
  ALeft: Integer;
begin
  if (FButtons.Count <> 0) and not FReading then
  begin
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
        with TTntGroupButton(FButtons[I]) do
        begin
          BiDiMode := Self.BiDiMode;
          ALeft := (I div ButtonsPerCol) * ButtonWidth + 8;
          if UseRightToLeftAlignment then
            ALeft := Self.ClientWidth - ALeft - ButtonWidth;
          DeferHandle := DeferWindowPos(DeferHandle, Handle, 0,
            ALeft,
            (I mod ButtonsPerCol) * ButtonHeight + TopMargin,
            ButtonWidth, ButtonHeight,
            SWP_NOZORDER or SWP_NOACTIVATE);
          Visible := True;
        end;
    finally
      EndDeferWindowPos(DeferHandle);
    end;
  end;
end;

procedure TTntCustomRadioGroup.ButtonClick(Sender: TObject);
begin
  if not FUpdating then
  begin
    FItemIndex := FButtons.IndexOf(Sender);
    Changed;
    Click;
  end;
end;

procedure TTntCustomRadioGroup.ItemsChange(Sender: TObject);
begin
  if not FReading then
  begin
    if FItemIndex >= FItems.Count then FItemIndex := FItems.Count - 1;
    UpdateButtons;
  end;
end;

procedure TTntCustomRadioGroup.Loaded;
begin
  inherited Loaded;
  ArrangeButtons;
end;

procedure TTntCustomRadioGroup.ReadState(Reader: TReader);
begin
  FReading := True;
  inherited ReadState(Reader);
  FReading := False;
  UpdateButtons;
end;

procedure TTntCustomRadioGroup.SetButtonCount(Value: Integer);
begin
  while FButtons.Count < Value do TTntGroupButton.InternalCreate(Self);
  while FButtons.Count > Value do TTntGroupButton(FButtons.Last).Free;
end;

procedure TTntCustomRadioGroup.SetColumns(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if Value > 16 then Value := 16;
  if FColumns <> Value then
  begin
    FColumns := Value;
    ArrangeButtons;
    Invalidate;
  end;
end;

procedure TTntCustomRadioGroup.SetItemIndex(Value: Integer);
begin
  if FReading then FItemIndex := Value else
  begin
    if Value < -1 then Value := -1;
    if Value >= FButtons.Count then Value := FButtons.Count - 1;
    if FItemIndex <> Value then
    begin
      if FItemIndex >= 0 then
        TTntGroupButton(FButtons[FItemIndex]).Checked := False;
      FItemIndex := Value;
      if FItemIndex >= 0 then
        TTntGroupButton(FButtons[FItemIndex]).Checked := True;
    end;
  end;
end;

procedure TTntCustomRadioGroup.SetItems(Value: TTntStrings);
begin
  FItems.Assign(Value);
end;

procedure TTntCustomRadioGroup.UpdateButtons;
var
  I: Integer;
begin
  SetButtonCount(FItems.Count);
  for I := 0 to FButtons.Count - 1 do
    TTntGroupButton(FButtons[I]).Caption := FItems[I];
  if FItemIndex >= 0 then
  begin
    FUpdating := True;
    TTntGroupButton(FButtons[FItemIndex]).Checked := True;
    FUpdating := False;
  end;
  ArrangeButtons;
  Invalidate;
end;

procedure TTntCustomRadioGroup.CMEnabledChanged(var Message: TMessage);
var
  I: Integer;
begin
  inherited;
  for I := 0 to FButtons.Count - 1 do
    TTntGroupButton(FButtons[I]).Enabled := Enabled;
end;

procedure TTntCustomRadioGroup.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ArrangeButtons;
end;

procedure TTntCustomRadioGroup.WMSize(var Message: TWMSize);
begin
  inherited;
  ArrangeButtons;
end;

function TTntCustomRadioGroup.CanModify: Boolean;
begin
  Result := True;
end;

procedure TTntCustomRadioGroup.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
end;

function TTntCustomRadioGroup.GetButtons(Index: Integer): TTntRadioButton;
begin
  Result := TTntRadioButton(FButtons[Index]);
end;

{ TTntSplitter }

procedure TTntSplitter.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntSplitter.IsHintStored: Boolean;
begin
  Result := TntControl_IsHintStored(Self)
end;

function TTntSplitter.GetHint: WideString;
begin
  Result := TntControl_GetHint(Self)
end;

procedure TTntSplitter.SetHint(const Value: WideString);
begin
  TntControl_SetHint(Self, Value);
end;

procedure TTntSplitter.CMHintShow(var Message: TMessage);
begin
  ProcessCMHintShowMsg(Message);
  inherited;
end;

procedure TTntSplitter.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  TntControl_BeforeInherited_ActionChange(Self, Sender, CheckDefaults);
  inherited;
end;

function TTntSplitter.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TntControl_GetActionLinkClass(Self, inherited GetActionLinkClass);
end;

{ TTntBoundLabel }

constructor TTntBoundLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Name := 'SubLabel';  { do not localize }
  SetSubComponent(True);
  if Assigned(AOwner) then
    Caption := AOwner.Name;
end;

procedure TTntBoundLabel.AdjustBounds;
begin
  inherited AdjustBounds;
  if Owner is TTntCustomLabeledEdit then
    with Owner as TTntCustomLabeledEdit do
      SetLabelPosition(LabelPosition);
end;

function TTntBoundLabel.GetHeight: Integer;
begin
  Result := inherited Height;
end;

function TTntBoundLabel.GetLeft: Integer;
begin
  Result := inherited Left;
end;

function TTntBoundLabel.GetTop: Integer;
begin
  Result := inherited Top;
end;

function TTntBoundLabel.GetWidth: Integer;
begin
  Result := inherited Width;
end;

procedure TTntBoundLabel.SetHeight(const Value: Integer);
begin
  SetBounds(Left, Top, Width, Value);
end;

procedure TTntBoundLabel.SetWidth(const Value: Integer);
begin
  SetBounds(Left, Top, Value, Height);
end;

{ TTntCustomLabeledEdit }

constructor TTntCustomLabeledEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLabelPosition := lpAbove;
  FLabelSpacing := 3;
  SetupInternalLabel;
end;

procedure TTntCustomLabeledEdit.CMBidimodechanged(var Message: TMessage);
begin
  inherited;
  FEditLabel.BiDiMode := BiDiMode;
end;

procedure TTntCustomLabeledEdit.CMEnabledchanged(var Message: TMessage);
begin
  inherited;
  FEditLabel.Enabled := Enabled;
end;

procedure TTntCustomLabeledEdit.CMVisiblechanged(var Message: TMessage);
begin
  inherited;
  FEditLabel.Visible := Visible;
end;

procedure TTntCustomLabeledEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FEditLabel) and (Operation = opRemove) then
    FEditLabel := nil;
end;

procedure TTntCustomLabeledEdit.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetLabelPosition(FLabelPosition);
end;

procedure TTntCustomLabeledEdit.SetLabelPosition(const Value: TLabelPosition);
var
  P: TPoint;
begin
  if FEditLabel = nil then exit;
  FLabelPosition := Value;
  case Value of
    lpAbove: P := Point(Left, Top - FEditLabel.Height - FLabelSpacing);
    lpBelow: P := Point(Left, Top + Height + FLabelSpacing);
    lpLeft : P := Point(Left - FEditLabel.Width - FLabelSpacing,
                    Top + ((Height - FEditLabel.Height) div 2));
    lpRight: P := Point(Left + Width + FLabelSpacing,
                    Top + ((Height - FEditLabel.Height) div 2));
  end;
  FEditLabel.SetBounds(P.x, P.y, FEditLabel.Width, FEditLabel.Height);
end;

procedure TTntCustomLabeledEdit.SetLabelSpacing(const Value: Integer);
begin
  FLabelSpacing := Value;
  SetLabelPosition(FLabelPosition);
end;

procedure TTntCustomLabeledEdit.SetName(const Value: TComponentName);
begin
  if (csDesigning in ComponentState) and ((FEditlabel.GetTextLen = 0) or
     (CompareText(FEditLabel.Caption, Name) = 0)) then
    FEditLabel.Caption := Value;
  inherited SetName(Value);
  if csDesigning in ComponentState then
    Text := '';
end;

procedure TTntCustomLabeledEdit.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if FEditLabel = nil then exit;
  FEditLabel.Parent := AParent;
  FEditLabel.Visible := True;
end;

procedure TTntCustomLabeledEdit.SetupInternalLabel;
begin
  if Assigned(FEditLabel) then exit;
  FEditLabel := TTntBoundLabel.Create(Self);
  FEditLabel.FreeNotification(Self);
  FEditLabel.FocusControl := Self;
end;

{$IFDEF DELPHI_10}
{ TTntTrayIcon }

procedure CopyW(var Des: Array of WideChar; Src: WideString);
var
  i, j: Integer;
begin
  j := Length(Src);
  if (j > SizeOf(Des)) then
    j := SizeOf(Des);
  for i := 0 to j do
  begin
    Des[i] := Src[i+1];
  end;
end;

constructor TTntTrayIcon.Create(Owner: TComponent);
begin
  inherited;
  FAnimate := False;
  FBalloonFlags := bfNone;
  BalloonTimeout := 3000;
  FIcon := TIcon.Create;
  FCurrentIcon := TIcon.Create;
  FTimer := TTimer.Create(Nil);
  FIconIndex := 0;
  FVisible := False;
  FIsClicked := False;
  FTimer.Enabled := False;
  FTimer.OnTimer := DoOnAnimate;
  FTimer.Interval := 1000;

  if not (csDesigning in ComponentState) then
  begin
    if Win32PlatformIsUnicode then
    begin
      FillChar(FData, SizeOf(FData), 0);
      FData.cbSize := SizeOf(FData);
      FData.Wnd := Classes.AllocateHwnd(WindowProc);
      FData.uID := FData.Wnd;
      FData.uTimeout := 3000;
      FData.hIcon := FCurrentIcon.Handle;
      FData.uFlags := NIF_ICON or NIF_MESSAGE;
      FData.uCallbackMessage := WM_SYSTEM_TRAY_MESSAGE;
      //StrPLCopy(FData.szTip, Application.Title, SizeOf(FData.szTip) - 1);
      //CopyW(FData.szTip, Application.Title);
      WStrPLCopy(FData.szTip, Application.Title, SizeOf(FData.szTip) - 1);
    
      if Length(Application.Title) > 0 then
         FData.uFlags := FData.uFlags or NIF_TIP;
    end
    else
    begin   
      FillChar(FDataA, SizeOf(FDataA), 0);
      FDataA.cbSize := SizeOf(FDataA);
      FDataA.Wnd := Classes.AllocateHwnd(WindowProc);
      FDataA.uID := FDataA.Wnd;
      FDataA.uTimeout := 3000;
      FDataA.hIcon := FCurrentIcon.Handle;
      FDataA.uFlags := NIF_ICON or NIF_MESSAGE;
      FDataA.uCallbackMessage := WM_SYSTEM_TRAY_MESSAGE;
      StrPLCopy(FDataA.szTip, Application.Title, SizeOf(FDataA.szTip) - 1);
      if Length(Application.Title) > 0 then
         FDataA.uFlags := FDataA.uFlags or NIF_TIP;
    end;
    Refresh;
  end;
end;

destructor TTntTrayIcon.Destroy;
begin
  if not (csDesigning in ComponentState) then
    Refresh(NIM_DELETE);

  FCurrentIcon.Free;
  FIcon.Free;
  FTimer.Free;
  if Win32PlatformIsUnicode then
    Classes.DeallocateHWnd(FData.Wnd)
  else
    Classes.DeallocateHWnd(FDataA.Wnd);  

  inherited;
end;

procedure TTntTrayIcon.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    if (not FAnimate) or (FAnimate and FCurrentIcon.Empty) then
      SetDefaultIcon;

    if not (csDesigning in ComponentState) then
    begin
      if FVisible then
      begin
        if not Refresh(NIM_ADD) then
          raise EOutOfResources.Create(STrayIconCreateError);
      end
      else if not (csLoading in ComponentState) then
      begin
        if not Refresh(NIM_DELETE) then
          raise EOutOfResources.Create(STrayIconRemoveError);
      end;
      if FAnimate then
        FTimer.Enabled := Value;
    end;
  end;
end;

procedure TTntTrayIcon.SetIconList(Value: TImageList);
begin
  if FIconList <> Value then
  begin
    FIconList := Value;
    if not (csDesigning in ComponentState) then
    begin
      if Assigned(FIconList) then
        FIconList.GetIcon(FIconIndex, FCurrentIcon)
      else
        SetDefaultIcon;
      Refresh;
    end;
  end;
end;

procedure TTntTrayIcon.SetHint(const Value: WideString);
begin
  if CompareStr(FHint, Value) <> 0 then
  begin
    FHint := Value;
    //StrPLCopy(FData.szTip, FHint, SizeOf(FData.szTip) - 1);
    //CopyW(FData.szTip, FHint);
    if Win32PlatformIsUnicode then
    begin
      WStrPLCopy(FData.szTip, FHint, SizeOf(FData.szTip) - 1);
      if Length(Hint) > 0 then
        FData.uFlags := FData.uFlags or NIF_TIP
      else
        FData.uFlags := FData.uFlags and not NIF_TIP;
    end
    else
    begin
      StrPLCopy(FDataA.szTip, FHint, SizeOf(FDataA.szTip) - 1);
      if Length(Hint) > 0 then
        FDataA.uFlags := FDataA.uFlags or NIF_TIP
      else
        FDataA.uFlags := FDataA.uFlags and not NIF_TIP;
    end;
    Refresh;
  end;
end;

function TTntTrayIcon.GetAnimateInterval: Cardinal;
begin
  Result := FTimer.Interval;
end;

procedure TTntTrayIcon.SetAnimateInterval(Value: Cardinal);
begin
  FTimer.Interval := Value;
end;

procedure TTntTrayIcon.SetAnimate(Value: Boolean);
begin
  if FAnimate <> Value then
  begin
    FAnimate := Value;
    if not (csDesigning in ComponentState) then
    begin
      if (FIconList <> nil) and (FIconList.Count > 0) and Visible then
        FTimer.Enabled := Value;
      if (not FAnimate) and (not FCurrentIcon.Empty) then
        FIcon.Assign(FCurrentIcon);
    end;
  end;
end;

{ Message handler for the hidden shell notification window. Most messages
  use WM_SYSTEM_TRAY_MESSAGE as the Message ID, with WParam as the ID of the
  shell notify icon data. LParam is a message ID for the actual message, e.g.,
  WM_MOUSEMOVE. Another important message is WM_ENDSESSION, telling the shell
  notify icon to delete itself, so Windows can shut down.

  Send the usual events for the mouse messages. Also interpolate the OnClick
  event when the user clicks the left button, and popup the menu, if there is
  one, for right click events. }
procedure TTntTrayIcon.WindowProc(var Message: TMessage);

  { Return the state of the shift keys. }
  function ShiftState: TShiftState;
  begin
    Result := [];

    if GetKeyState(VK_SHIFT) < 0 then
      Include(Result, ssShift);
    if GetKeyState(VK_CONTROL) < 0 then
      Include(Result, ssCtrl);
    if GetKeyState(VK_MENU) < 0 then
      Include(Result, ssAlt);
  end;

var
  Point: TPoint;
  Shift: TShiftState;
begin
  case Message.Msg of
    WM_QUERYENDSESSION:
      Message.Result := 1;

    WM_ENDSESSION:
    begin
      if TWmEndSession(Message).EndSession then
        Refresh(NIM_DELETE);
    end;

    WM_SYSTEM_TRAY_MESSAGE:
    begin
      case Message.lParam of
        WM_MOUSEMOVE:
        begin
          if Assigned(FOnMouseMove) then
          begin
            Shift := ShiftState;
            GetCursorPos(Point);
            FOnMouseMove(Self, Shift, Point.X, Point.Y);
          end;
        end;

        WM_LBUTTONDOWN:
        begin
          if Assigned(FOnMouseDown) then
          begin
            Shift := ShiftState + [ssLeft];
            GetCursorPos(Point);
            FOnMouseDown(Self, mbMiddle, Shift, Point.X, Point.Y);
          end;

          FIsClicked := True;
        end;

        WM_LBUTTONUP:
        begin
          Shift := ShiftState + [ssLeft];
          GetCursorPos(Point);
          if FIsClicked and Assigned(FOnClick) then
          begin
            FOnClick(Self);
            FIsClicked := False;
          end;
          if Assigned(FOnMouseUp) then
            FOnMouseUp(Self, mbLeft, Shift, Point.X, Point.Y);
        end;

        WM_RBUTTONDOWN:
        begin
          if Assigned(FOnMouseDown) then
          begin
            Shift := ShiftState + [ssRight];
            GetCursorPos(Point);
            FOnMouseDown(Self, mbRight, Shift, Point.X, Point.Y);
          end;
        end;

        WM_RBUTTONUP:
        begin
          Shift := ShiftState + [ssRight];
          GetCursorPos(Point);
          if Assigned(FOnMouseUp) then
            FOnMouseUp(Self, mbRight, Shift, Point.X, Point.Y);
          if Assigned(FPopupMenu) then
          begin
            SetForegroundWindow(Application.Handle);
            Application.ProcessMessages;
            FPopupMenu.AutoPopup := False;
            FPopupMenu.PopupComponent := Owner;
            FPopupMenu.Popup(Point.x, Point.y);
          end;
        end;

        WM_LBUTTONDBLCLK, WM_MBUTTONDBLCLK, WM_RBUTTONDBLCLK:
          if Assigned(FOnDblClick) then
            FOnDblClick(Self);

        WM_MBUTTONDOWN:
        begin
          if Assigned(FOnMouseDown) then
          begin
            Shift := ShiftState + [ssMiddle];
            GetCursorPos(Point);
            FOnMouseDown(Self, mbMiddle, Shift, Point.X, Point.Y);
          end;
        end;

        WM_MBUTTONUP:
        begin
          if Assigned(FOnMouseUp) then
          begin
            Shift := ShiftState + [ssMiddle];
            GetCursorPos(Point);
            FOnMouseUp(Self, mbMiddle, Shift, Point.X, Point.Y);
          end;
        end;

        NIN_BALLOONHIDE, NIN_BALLOONTIMEOUT,
        NIN_BALLOONSHOW, NIN_BALLOONUSERCLICK:
        begin
          if Win32PlatformIsUnicode then
            FData.uFlags := FData.uFlags and not NIF_INFO
          else
            FDataA.uFlags := FDataA.uFlags and not NIF_INFO;
          case Message.lParam of
            NIN_BALLOONHIDE:
              if Assigned(FOnBalloonHintHide) then
                FOnBalloonHintHide(Self);
            NIN_BALLOONTIMEOUT:
              if Assigned(FOnBalloonHintTimeout) then
                FOnBalloonHintTimeout(Self);
            NIN_BALLOONSHOW:
              if Assigned(FOnBalloonHintShow) then
                FOnBalloonHintShow(Self);
            NIN_BALLOONUSERCLICK:
              if Assigned(FOnBalloonHintClick) then
                FOnBalloonHintClick(Self);
          end;
        end;
      end;
    end;

    else if (Message.Msg = RM_TaskBarCreated) and Visible then
      Refresh(NIM_ADD);
  end;
end;

procedure TTntTrayIcon.Refresh;
begin
  if not (csDesigning in ComponentState) then
  begin
    if Win32PlatformIsUnicode then
      FData.hIcon := FCurrentIcon.Handle
    else
      FDataA.hIcon := FCurrentIcon.Handle;

    if Visible then
      Refresh(NIM_MODIFY);
  end;
end;

function TTntTrayIcon.Refresh(Message: Integer): Boolean;
begin
  if Win32PlatformIsUnicode then
    Result := Shell_NotifyIconW(Message, @FData)
  else
    Result := Shell_NotifyIcon(Message, @FDataA);
end;

procedure TTntTrayIcon.SetIconIndex(Value: Integer);
begin
  if FIconIndex <> Value then
  begin
    FIconIndex := Value;
    if not (csDesigning in ComponentState) then
    begin
      if Assigned(FIconList) then
        FIconList.GetIcon(FIconIndex, FCurrentIcon);
      Refresh;
    end;
  end;
end;

procedure TTntTrayIcon.DoOnAnimate(Sender: TObject);
begin
  if Assigned(FOnAnimate) then
    FOnAnimate(Self);
  if Assigned(FIconList) and (FIconIndex < FIconList.Count - 1) then
    IconIndex := FIconIndex + 1
  else
    IconIndex := 0;
  Refresh;
end;

procedure TTntTrayIcon.SetIcon(Value: TIcon);
begin
  FIcon.Assign(Value);
  FCurrentIcon.Assign(Value);
  Refresh;
end;

procedure TTntTrayIcon.SetBalloonHint(const Value: WideString);
begin
  if CompareStr(FBalloonHint, Value) <> 0 then
  begin
    FBalloonHint := Value;
    //StrPLCopy(FData.szInfo, FBalloonHint, SizeOf(FData.szInfo) - 1);
    //CopyW(FData.szInfo, FBalloonHint);
    if Win32PlatformIsUnicode then
      WStrPLCopy(FData.szInfo, FBalloonHint, SizeOf(FData.szInfo) - 1)
    else
      StrPLCopy(FDataA.szInfo, FBalloonHint, SizeOf(FDataA.szInfo) - 1);
    Refresh(NIM_MODIFY);
  end;
end;

procedure TTntTrayIcon.SetDefaultIcon;
begin
  if not FIcon.Empty then
    FCurrentIcon.Assign(FIcon)
  else
    FCurrentIcon.Assign(Application.Icon);
  Refresh;
end;

procedure TTntTrayIcon.SetBalloonTimeout(Value: Integer);
begin
  if Win32PlatformIsUnicode then
    FData.uTimeout := Value
  else
    FDataA.uTimeout := Value
end;

function TTntTrayIcon.GetBalloonTimeout: Integer;
begin
  if Win32PlatformIsUnicode then
    Result := FData.uTimeout
  else
    Result := FDataA.uTimeout;
end;

procedure TTntTrayIcon.ShowBalloonHint;
begin
  if Win32PlatformIsUnicode then
  begin
    FData.uFlags := FData.uFlags or NIF_INFO;
    FData.dwInfoFlags := Integer(FBalloonFlags);
  end
  else
  begin
    FDataA.uFlags := FDataA.uFlags or NIF_INFO;
    FDataA.dwInfoFlags := Integer(FBalloonFlags);
  end;
  Refresh(NIM_MODIFY);
end;

procedure TTntTrayIcon.SetBalloonTitle(const Value: WideString);
begin
  if CompareStr(FBalloonTitle, Value) <> 0 then
  begin
    FBalloonTitle := Value;
    //StrPLCopy(FData.szInfoTitle, FBalloonTitle, SizeOf(FData.szInfoTitle) - 1);
    //CopyW(FData.szInfoTitle, FBalloonTitle);
    if Win32PlatformIsUnicode then
      WStrPLCopy(FData.szInfoTitle, FBalloonTitle, SizeOf(FData.szInfoTitle) - 1)
    else
      StrPLCopy(FDataA.szInfoTitle, FBalloonTitle, SizeOf(FDataA.szInfoTitle) - 1);
    Refresh(NIM_MODIFY);
  end;
end;
{$ENDIF}

{$ENDIF}
end.
